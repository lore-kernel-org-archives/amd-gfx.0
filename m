Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CB7C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 09:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E9A6108D
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 09:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E9A6108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F01906EC1A;
	Wed,  2 Jun 2021 09:31:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D75C26EC1A
 for <amd-gfx@freedesktop.org>; Wed,  2 Jun 2021 09:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hg7TBdWfqyXHv8FEDvMI64Sn0F/T0bJBmWC0W7H1vAJK9qmO/Eg91/oEbEg20xHADdx90RSxYDaro6Bz1uNvWRJzzH1RPr/wRlAhNapxdZm8WAvKtMymtiBFIcXoCWWODpobT0qYPajdSSHDQcqFhMIGc+8aD53G3VBaFIq2GIKWIx/AAfKa9h2UKZtfnsDLSHXuYCDWxkQyLxLzxT5c3PCw6hGy+ab1SIvKBVH1d3A7+pUbUURD48v4PfW4ZcvRP6jyRfgS5TcyMTCMgyhkI8xjMBZ5GNIgoeEwJ7fVp0pSHjJrdS1sROEpCn6dya49wXUTBSoAMh7wZeHefHhpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIopib6ZATFMAZ9IFDLxbqNZJC9gu1SWtgSEVKJXVL8=;
 b=mm11RhjrJ36ZnJjLGcsKC2YF/W8hx5JWF5FBM6jqQZPuDP/ci7ViR9DJYKap8OCRspXqg9LePErd+gSzWsk4GjF2zWPm5nl+8StHlSaPMcSP2jn/mJZvzjImCNwGjx0JYeSVNrb8tI9PTNObw2DVP1D+cp3D3OBBEzjiRz1sRXDEMQ12W5KhAlYsZV0Ts9UR41LB04N/4GQHzcUX+iRa+tzbrcf14/QMZkslzkOQ4c9e0XQFRKniMscJ692eivTTQPBD4Ouu1UN+XvFNRmY0egmmEK/ZCaGmzqezoM5Kf2TyurT0k/ZCWjz41jG/a68jXf04PGTWuaxuRnaCmLNXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIopib6ZATFMAZ9IFDLxbqNZJC9gu1SWtgSEVKJXVL8=;
 b=oc9Jf7RDVHBxvqW9JgM6jrAIolnYslkw7YNzAjZ0WZN3RbP+EwDEoa5181LkO9u9wsowBvQM8vEH+wX7D1GdwWrGLDBWeisHIFM8O0IvFiOl5eQF3HGcsRrS4KELJW8SWYRLqWx52F0VykzBSu5ZSxiuNdbkJT9hFeuIDdV5hTI=
Authentication-Results: freedesktop.org; dkim=none (message not signed)
 header.d=none;freedesktop.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5056.namprd12.prod.outlook.com (2603:10b6:5:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 09:31:55 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 09:31:55 +0000
Subject: Re: [PATCH] drm/amdgpu: take back kvmalloc_array for entries alloc
 because of kzalloc memory limit
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@freedesktop.org" <amd-gfx@freedesktop.org>
References: <20210602083017.2335-1-Changfeng.Zhu@amd.com>
 <c9c3817a-ddd5-d73e-5a5b-fb3ad25d8ddc@amd.com>
 <9a3adb34-031e-9742-d165-cb6f36c91063@amd.com>
 <MW2PR12MB4684CB6391DA014F76CC9C46FD3D9@MW2PR12MB4684.namprd12.prod.outlook.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <af3adc83-a25c-e7ee-d547-cfc2f7ea4b8a@amd.com>
Date: Wed, 2 Jun 2021 11:31:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <MW2PR12MB4684CB6391DA014F76CC9C46FD3D9@MW2PR12MB4684.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [165.204.72.6]
X-ClientProxiedBy: AM4PR0101CA0057.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::25) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.54.68] (165.204.72.6) by
 AM4PR0101CA0057.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Wed, 2 Jun 2021 09:31:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0049663-a083-4442-7421-08d925a942c5
X-MS-TrafficTypeDiagnostic: DM4PR12MB5056:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5056269C6CDFEDFC84C5ACA68B3D9@DM4PR12MB5056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/+lkmC6VzhF2p55zHA/43GCVRrqTMtz5F3BL7SpfWxoN6E8q6mYQGvAoBcLdjqJv5Ez8tXCi0HlT/shTBp2R4yEHvWQT+HYWhZi6Ewd0F/ukboroKG7Y0RxAvAO0w3yH0RPdmhkwLPqln6D1tHSKHpkG19NU17i3D92yLgf08VDECVJGQqPYZcAmut/pGdB6wlH+lTP1nxef8f+KEBPPi/iE5HAYU8aYlPM+F9kqR9NCl3nn9Luz5o0d/mCaMeqSNumgCozIgdjLWZv6gLawudDAM6TctxobZLY1O66SI3kvl/8OOqdvaFOWjxtvrL+UZKfuGoVbq8Dt6/vVCvAWECYEHuk7hvUnGa1cf7walvc/k+J0KqoC/jeKQQ0S23bdizPa2PwCyjPNIhi9F5KEJmipckxCObMvPIb7m0VGIUhuWv0sXzZj3aPIjMnOPjmR+6QnhW9Esyt/q9LH40dZtUwTdRBKNBXawYQ8pyHT6JDrvtS8vM5FGf4YYzeshhsVFzEEUDaXDakqGRHukQS7uyHEvGbJGRUzh6LcmrCFbHbVDi5fHjk1Qne4fBsP5WyvrEmfaKk/K7fWKmucwW2j6sgfz0+4Ceub2sCrrv7Ce15leAiYCJlbJvxOu/7Dg05WBUszjiFz5HfiBEruFd4NTgJvAwhvDwyjMWs1NaDCE5ev3B3V0p06yoz9SXgDQAJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(478600001)(16576012)(66556008)(110136005)(66946007)(52116002)(31686004)(83380400001)(38100700002)(36756003)(6666004)(8936002)(53546011)(66476007)(8676002)(956004)(186003)(16526019)(26005)(2906002)(5660300002)(2616005)(316002)(31696002)(86362001)(38350700002)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QlZKTWJnMGw0amxMeWhiMlVOdEdZWEhxcUViR25ZMDZpOG1DaklLc1g0dllC?=
 =?utf-8?B?UU0wMlFGV0x5NXZQNHJ0RzlaVXpmcmNscTVQVXZuMk4xdjNxai9sM0hiWkdv?=
 =?utf-8?B?bXV4TTcxbi9TQjNCNUtETUNOWEpXZmI4UXNvUXQwMDQ3UUFINndMQ2RXcXBr?=
 =?utf-8?B?VnJ6R1kvdUduNFlpTWtNRmJNZlBPYXJxVVJyUkw4WElOdXVSY242TE80cDdV?=
 =?utf-8?B?TysvTm9QVnh6SjVtM0FnRWFjL0FzcmtIUjhKK29DRFZ6TkJXZmxjc1JUNXpI?=
 =?utf-8?B?bmZQcm9LclQ4S1JrQVhsU1RkK0NYQ08zWmd0QjVnUlh0a2VBSklOYTgzV0RC?=
 =?utf-8?B?a0Z2M2V1L2pyS1czUmRqY01kcW9nNU52eXRKdHR4RWwxMU85d1VKZ0V5aWJ3?=
 =?utf-8?B?S2NTbnpPdktiQ0pzQWlKbkJ3SGxvWk03ZFVBSFU0MlVWaGdENE13MEszL1Vj?=
 =?utf-8?B?eTJ0WHNmNUY3aEdqdGozTWtPcENEbTJXeEE5Vk9MSysvSzBIcERjZk10ZmJt?=
 =?utf-8?B?alFGUk1QZHJyUzJJdGtyY0JqY29Sb25xakdENklYdDVTSTRHNG84elRlSFJv?=
 =?utf-8?B?TlBybTdDellLRWo3YnpxRHBJNU1BSU1pem43Mzg0a1IrdTJZS1ZVWHphMXZz?=
 =?utf-8?B?N0lVd3NoMEhONDMvRysybm44ZEtzbEpGWjl3WmJPQy9wRTdHSHBocGNiSm1p?=
 =?utf-8?B?REM5VHhuczIwVDdWVWg3eGpxaU5HeUliWXhnNmhGczgyN1JMcWl1NGpiWHI4?=
 =?utf-8?B?RWE5dG4rQ0lrSHRKK2hpMDZaQW0rTGdlblhrcWdJZ3FtUjZmVmtvR2g2VFFT?=
 =?utf-8?B?WU1ZRVlUY2ZodjlvOE5iOFpsZ2JaQ1dIT0l3dm1HWkJuS2lIeTJ4OG1IQ1JF?=
 =?utf-8?B?b1lweDRLUzZmMGhGRkdKb0dPZkIwYmcvNFBDcjZGM2doL2lQcGZRbXdrcFRU?=
 =?utf-8?B?dFdQc1VESnZRVzFiSEZ1aWY1TzJvRlRXYTg4TkNJRXNjRHV3WlliS0VHRmp2?=
 =?utf-8?B?aEk2dDBGbjd4SVZ2cGZPOEI0dENKelRMS0FDRE8wems2cnI5cXUxWjltZmMv?=
 =?utf-8?B?NnpxMGVGQWg0TEhtcFpoVFRtS0F5OE9PVUJTMjhMOGVkUkpnQU11Wm5iQ2FN?=
 =?utf-8?B?bWt3TUJTTUx5OFNLL3hSVXFtUkx5UUtLNDlPbXFhSUljOXozbEo0VG9rOUpw?=
 =?utf-8?B?bmJycmRCZFYrZXJ4aTYvYkdMZkJ6YzhzTXR3LytWQ0hvdzgwaDZyY0RtMVFC?=
 =?utf-8?B?TzdtV2lqSndjM0xXNTNObjhQZjlES1YrVWs4RXpFVUZ0NS8zUFJ0WEwwWUVI?=
 =?utf-8?B?OGpjdEZHRWFqankxajU2VXJpVmlWeEhTWXdJQVpmdytlaFlwNGt5N0xLYzA1?=
 =?utf-8?B?UGwwd0tlWFdzOTg2b3UwUjRiZ3dJN2hxZnQ3VEZHUWY4b1VibUk0aDF2Z3dN?=
 =?utf-8?B?a0J0dzhpVk43bElzL1EyT2FYZXJHQkNINDRpOTJ6K0h2MmViOFlxbk1PT0ww?=
 =?utf-8?B?UCt3Q0QwRXlQM1BYMjY5d1N6amxwMW5wY3NzeUFSN1RFbHlPNGMwcGhhZ09E?=
 =?utf-8?B?eWJ0VVQxSmFYRzNrTWpNdnRrcGg2Sjg5aEYrU3Zvd0xiUVA3VmJybUJMak95?=
 =?utf-8?B?Ym9RM24xRDRTUFovU2IybEsya05maFhkelg1cFVBMWdRbEdoWkFjYkFZemNi?=
 =?utf-8?B?TEtKRE9IWlNjak4wTG0rOWk2c280ZFFXanJKaDRaQVZrTkprN2NVSHBObGJX?=
 =?utf-8?Q?KlWy2Ms9nMi55sV+p93ieKteyK71m90k3EbQGeI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0049663-a083-4442-7421-08d925a942c5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 09:31:55.5726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raWXg78XbcXyUv4U7XR4E8TGhbSDhNFd9rOmb22d8Ln7B2W6u5UJlxKPPUn/Mx57Di8VYLOY/oXhbSjoskjCMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5056
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDYvMi8yMDIxIDExOjEwIEFNLCBaaHUsIENoYW5nZmVuZyB3cm90ZToKPiBbQU1EIE9mZmlj
aWFsIFVzZSBPbmx5XQo+Cj4gSGkgQ2hyaXMsCj4KPiBBY3R1YWxseSwgSSB0aGluayBhYm91dCBz
d2l0Y2hpbmcga3phbGxvYyB0byBrdm1hbGxvYyBpbiBhbWRncHVfYm9fY3JlYXRlLgo+IEhvd2V2
ZXIsIEkgb2JzZXJ2ZSBicC5mbGFncyA9IEFNREdQVV9HRU1fQ1JFQVRFX1ZSQU1fQ09OVElHVU9V
UyBpbiBhbWRncHVfdm1fcHRfY3JlYXRlLgo+Cj4gRG9lcyBpdCBtYXR0ZXIgd2Ugc3dpdGNoIGt6
YWxsb2MgdG8ga3ZtYWxsb2MgaWYgdGhlcmUgaXMgYSBwaHlzaWNhbCBjb250aW51b3VzIG1lbW9y
eSByZXF1ZXN0IHdoZW4gY3JlYXRpbmcgYm8/IFN1Y2ggYXMgQU1ER1BVX0dFTV9DUkVBVEVfVlJB
TV9DT05USUdVT1VTPwoKCk9ubHkgZHJpdmVyIHdpbGwgYWNjZXNzIHRoaXMgQk8gc3RydWN0LCBz
byBrdm1hbGxvYyB3aWxsIGJlIGZpbmUuCgoKUmVnYXJkcywKCk5pcm1veQoKCj4KPiBCUiwKPiBD
aGFuZ2ZlbmcuCj4KPgo+Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tCj4gRnJvbTogS29lbmln
LCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4KPiBTZW50OiBXZWRuZXNkYXks
IEp1bmUgMiwgMjAyMSA0OjU3IFBNCj4gVG86IERhcywgTmlybW95IDxOaXJtb3kuRGFzQGFtZC5j
b20+OyBaaHUsIENoYW5nZmVuZyA8Q2hhbmdmZW5nLlpodUBhbWQuY29tPjsgSHVhbmcsIFJheSA8
UmF5Lkh1YW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGZyZWVkZXNrdG9wLm9yZwo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGRybS9hbWRncHU6IHRha2UgYmFjayBrdm1hbGxvY19hcnJheSBmb3IgZW50cmll
cyBhbGxvYyBiZWNhdXNlIG9mIGt6YWxsb2MgbWVtb3J5IGxpbWl0Cj4KPgo+Cj4gQW0gMDIuMDYu
MjEgdW0gMTA6NTQgc2NocmllYiBEYXMsIE5pcm1veToKPj4gT24gNi8yLzIwMjEgMTA6MzAgQU0s
IENoYW5nZmVuZyB3cm90ZToKPj4+IEZyb206IGNoYW5nemh1IDxDaGFuZ2ZlbmcuWmh1QGFtZC5j
b20+Cj4+Pgo+Pj4gRnJvbTogQ2hhbmdmZW5nIDxDaGFuZ2ZlbmcuWmh1QGFtZC5jb20+Cj4+Pgo+
Pj4gSXQgd2lsbCBjYXVzZSBlcnJvciB3aGVuIGFsbG9jIG1lbW9yeSBsYXJnZXIgdGhhbiAxMjhL
QiBpbgo+Pj4gYW1kZ3B1X2JvX2NyZWF0ZS0+a3phbGxvYy4KPj4KPj4gSSB3b25kZXIgd2h5IEkg
ZGlkbid0IHNlZSB0aGUgZXJyb3Igb24gbXkgbWFjaGluZS4gSXMgdGhlcmUgYW55IGNvbmZpZwo+
PiBJIG1pZ2h0IGJlIG1pc3NpbmcgPwo+IFZNIHBhZ2UgdGFibGUgbGF5b3V0IGRlcGVuZHMgb24g
aGFyZHdhcmUgZ2VuZXJhdGlvbiwgQVBVIHZzIGRHUFUgYW5kIGtlcm5lbCBjb21tYW5kIGxpbmUg
c2V0dGluZ3MuCj4KPiBJIHRoaW5rIHdlIGp1c3QgbmVlZCB0byBzd2l0Y2ggYW1kZ3B1X2JvX2Ny
ZWF0ZSgpIGZyb20ga3phbGxvYyB0byBrdm1hbGxvYyAoYW5kIGtmcmVlIHRvIGt2ZnJlZSBpbiBh
bWRncHVfYm9fZGVzdHJveSBvZiBjb3Vyc2UpLgo+Cj4gU2hvdWxkbid0IGJlIG1vcmUgdGhhbiBh
IHR3byBsaW5lIHBhdGNoLgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPj4KPj4gVGhhbmtz
LAo+Pgo+PiBOaXJtb3kKPj4KPj4+IENhbGwgVHJhY2U6Cj4+PiAgwqDCoMKgIGFsbG9jX3BhZ2Vz
X2N1cnJlbnQrMHg2YS8weGUwCj4+PiAgwqDCoMKgIGttYWxsb2Nfb3JkZXIrMHgzMi8weGIwCj4+
PiAgwqDCoMKgIGttYWxsb2Nfb3JkZXJfdHJhY2UrMHgxZS8weDgwCj4+PiAgwqDCoMKgIF9fa21h
bGxvYysweDI0OS8weDJkMAo+Pj4gIMKgwqDCoCBhbWRncHVfYm9fY3JlYXRlKzB4MTAyLzB4NTAw
IFthbWRncHVdCj4+PiAgwqDCoMKgID8geGFzX2NyZWF0ZSsweDI2NC8weDNlMAo+Pj4gIMKgwqDC
oCBhbWRncHVfYm9fY3JlYXRlX3ZtKzB4MzIvMHg2MCBbYW1kZ3B1XQo+Pj4gIMKgwqDCoCBhbWRn
cHVfdm1fcHRfY3JlYXRlKzB4ZjUvMHgyNjAgW2FtZGdwdV0KPj4+ICDCoMKgwqAgYW1kZ3B1X3Zt
X2luaXQrMHgxZmQvMHg0ZDAgW2FtZGdwdV0KPj4+Cj4+PiBDaGFuZ2UtSWQ6IEkyOWU0NzlkYjQ1
ZWFkMzdjMzk0NDllODU2NTk5ZmQ0ZjZhMGUzNGNlCj4+PiBTaWduZWQtb2ZmLWJ5OiBDaGFuZ2Zl
bmcgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gIMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMjcKPj4+ICsrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tCj4+PiAgwqAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9u
cygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYwo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4g
aW5kZXggMTkyM2YwMzU3MTNhLi43MTRkNjEzZDAyMGIgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+IEBAIC04OTQsNiArODk0LDEwIEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X3ZtX3B0X2NyZWF0ZShzdHJ1Y3QKPj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+
PiAgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9lbnRyaWVzID0gMDsKPj4+ICDCoCDCoMKgwqDCoMKg
IGJwLmJvX3B0cl9zaXplID0gc3RydWN0X3NpemUoKCp2bWJvKSwgZW50cmllcywgbnVtX2VudHJp
ZXMpOwo+Pj4gK8KgwqDCoCBpZiAoYnAuYm9fcHRyX3NpemUgPiAzMipBTURHUFVfR1BVX1BBR0Vf
U0laRSkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIERSTV9JTkZPKCJDYW4ndCBhbGxvYyBtZW1vcnkg
bGFyZ2VyIHRoYW4gMTI4S0IgYnkgdXNpbmcKPj4+IGt6YWxsb2MgaW4gYW1kZ3B1X2JvX2NyZWF0
ZVxuIik7Cj4+PiArwqDCoMKgwqDCoMKgwqAgYnAuYm9fcHRyX3NpemUgPSBzaXplb2Yoc3RydWN0
IGFtZGdwdV9ib192bSk7Cj4+PiArwqDCoMKgIH0KPj4+ICDCoCDCoMKgwqDCoMKgIGlmICh2bS0+
dXNlX2NwdV9mb3JfdXBkYXRlKQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBicC5mbGFncyB8PSBB
TURHUFVfR0VNX0NSRUFURV9DUFVfQUNDRVNTX1JFUVVJUkVEOwo+Pj4gQEAgLTk2NSwxNSArOTY5
LDE5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2FsbG9jX3B0cyhzdHJ1Y3QKPj4+IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCj4+PiAgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvX3ZtICpwdDsKPj4+
ICDCoMKgwqDCoMKgIGludCByOwo+Pj4gIMKgIC3CoMKgwqAgaWYgKGVudHJ5LT5iYXNlLmJvKSB7
Cj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKGN1cnNvci0+bGV2ZWwgPCBBTURHUFVfVk1fUFRCKQo+
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW50cnktPmVudHJpZXMgPQo+Pj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0b19hbWRncHVfYm9fdm0oZW50cnktPmJhc2UuYm8pLT5l
bnRyaWVzOwo+Pj4gLcKgwqDCoMKgwqDCoMKgIGVsc2UKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGVudHJ5LT5lbnRyaWVzID0gTlVMTDsKPj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsK
Pj4+ICvCoMKgwqAgaWYgKGN1cnNvci0+bGV2ZWwgPCBBTURHUFVfVk1fUFRCICYmICFlbnRyeS0+
ZW50cmllcykgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIG51bV9lbnRyaWVzOwo+Pj4g
K8KgwqDCoMKgwqDCoMKgIG51bV9lbnRyaWVzID0gYW1kZ3B1X3ZtX251bV9lbnRyaWVzKGFkZXYs
IGN1cnNvci0+bGV2ZWwpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGVudHJ5LT5lbnRyaWVzID0ga3Zt
YWxsb2NfYXJyYXkobnVtX2VudHJpZXMsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2YoKmVudHJ5LT5lbnRyaWVzKSwKPj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEdGUF9LRVJORUwgfCBfX0dG
UF9aRVJPKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIWVudHJ5LT5lbnRyaWVzKQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07Cj4+PiAgwqDCoMKgwqDCoCB9Cj4+
PiAgwqAgK8KgwqDCoCBpZiAoZW50cnktPmJhc2UuYm8pCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIDA7Cj4+PiArCj4+PiAgwqDCoMKgwqDCoCByID0gYW1kZ3B1X3ZtX3B0X2NyZWF0ZShhZGV2
LCB2bSwgY3Vyc29yLT5sZXZlbCwgaW1tZWRpYXRlLAo+Pj4gJnB0KTsKPj4+ICDCoMKgwqDCoMKg
IGlmIChyKQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcjsKPj4+IEBAIC05ODQsMTAg
Kzk5Miw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2FsbG9jX3B0cyhzdHJ1Y3QKPj4+IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCj4+PiAgwqDCoMKgwqDCoCBwdF9ibyA9ICZwdC0+Ym87Cj4+PiAgwqDC
oMKgwqDCoCBwdF9iby0+cGFyZW50ID0gYW1kZ3B1X2JvX3JlZihjdXJzb3ItPnBhcmVudC0+YmFz
ZS5ibyk7Cj4+PiAgwqDCoMKgwqDCoCBhbWRncHVfdm1fYm9fYmFzZV9pbml0KCZlbnRyeS0+YmFz
ZSwgdm0sIHB0X2JvKTsKPj4+IC3CoMKgwqAgaWYgKGN1cnNvci0+bGV2ZWwgPCBBTURHUFVfVk1f
UFRCKQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGVudHJ5LT5lbnRyaWVzID0gcHQtPmVudHJpZXM7Cj4+
PiAtwqDCoMKgIGVsc2UKPj4+IC3CoMKgwqDCoMKgwqDCoCBlbnRyeS0+ZW50cmllcyA9IE5VTEw7
Cj4+PiAgwqAgwqDCoMKgwqDCoCByID0gYW1kZ3B1X3ZtX2NsZWFyX2JvKGFkZXYsIHZtLCBwdCwg
aW1tZWRpYXRlKTsKPj4+ICDCoMKgwqDCoMKgIGlmIChyKQo+Pj4gQEAgLTEwMTcsNiArMTAyMSw3
IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92bV9mcmVlX3RhYmxlKHN0cnVjdAo+Pj4gYW1kZ3B1X3Zt
X3B0ICplbnRyeSkKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2JvX3VucmVmKCZzaGFk
b3cpOwo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfYm9fdW5yZWYoJmVudHJ5LT5iYXNl
LmJvKTsKPj4+ICDCoMKgwqDCoMKgIH0KPj4+ICvCoMKgwqAga3ZmcmVlKGVudHJ5LT5lbnRyaWVz
KTsKPj4+ICDCoMKgwqDCoMKgIGVudHJ5LT5lbnRyaWVzID0gTlVMTDsKPj4+ICDCoCB9Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
