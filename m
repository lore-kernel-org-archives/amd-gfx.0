Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5EDC07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 13:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9906261279
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 13:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9906261279
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF7F6E859;
	Thu, 15 Jul 2021 13:50:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 214576E859
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 13:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1yuWayqC0hB/FvxNRuZ/ITbJ9m+90qc9AOFZHLqWowXjJpRdHJmTKBU7WOYGTMBQLrX8h8cAbbE+PHlX03kU0GKLbasaf32It278ezbJJAWZUefCHJR2j9i5ginVdlfF5KQWwKG2uj4aeeQ8MMlcDRe5/XQSZe14MwOaS2jTG/SDXNCI4do7qEaFFC+DIAWV6f9dV03o6qe6MPHInfstiBhP8+8VL4WvTvazbS2WV1g583ztpnj9I1dRTbzPZ4pW0+IOelHgL8agq/3dVbD7O8U6w0grH1UCAj+Wbwv/aoaHyWOW8VQNOZVh7ZBulhsxfFj5zf9Hvk14IEOQTV2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HYa2etgVj/vEIA9Hltu/FFYf319Qzge6UkzCQzYijY=;
 b=aMvCkKm7AQ4qnUFF/nJlLWf+VuyR8zk3agHza2jJEtylQ4waC5pSWMuIh0v0QhMe7OjALahIacnhAQaLYRhZ4WynOE9tbTKpsm4Lax/DIcXmMQuebpjUo9FKe5od0fJGlIHmULT0r1P4/RBGpkfFDHodM4UDk8F/87A+AyilkGFG2bqR2KJAfX3yQ09psZoYgYVdD4gpm17NOW9iE31ZJ07oAMFIBdGMXCG8+qvKP6+e6fJY1rwoir9CfJpRJQV4QXAMB9Ki9o+2Ox3gRq4HSDkCZYXnEYdW7q+oVSmeQypBwxW/UZcjCAduupY3eAh7N7JOEhAIC1PiLwyFIVXvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HYa2etgVj/vEIA9Hltu/FFYf319Qzge6UkzCQzYijY=;
 b=AMRaiSVfLmIGhDFn8vO+yh/a4MlZo1fApO/hARpYdru01QhP2+8MSPa/17FM4BtVPRHQ/IJYzSZBDVwTw53RzB7YVOKwCnVIHI4LfBHLi1EJBgafVE8OYCoCWr0QiRceAbS1C+6K5v3vwSloGWI4ucfJnW6k39RIrWL8N9Nn7HA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 15 Jul
 2021 13:50:12 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d49:f837:16e3:9561]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d49:f837:16e3:9561%4]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 13:50:12 +0000
Subject: Re: [PATCH] drm/amdgpu: further lower VRAM allocation overhead
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20210713191739.458131-1-jinhuieric.huang@amd.com>
 <a1cad35e-e24d-3078-bbc2-1534a625d932@amd.com>
 <7ac4af39-5dd9-1eac-3208-dcfecb422269@gmail.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <0ad99948-cbf9-f2fe-a121-c47ab1cf1e44@amd.com>
Date: Thu, 15 Jul 2021 09:50:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <7ac4af39-5dd9-1eac-3208-dcfecb422269@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::12) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:890e:34c4:757:cc76]
 (2607:9880:2048:122:890e:34c4:757:cc76) by
 YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 13:50:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e663f2c2-615b-41d6-998f-08d947977779
X-MS-TrafficTypeDiagnostic: BL1PR12MB5157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51573F02B4F90E5E5C3076BE82129@BL1PR12MB5157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Migkeq+aX+1YmGmn16U/KjAgYUMGmVNWNWWA342WindWH8aR0iKKlCs2U2W7yNrBpnp3zpTMQZ9XGiIi/9+uhu+BdaGou+vw49vkQRLU7Dpim/RQIYsfna2ikQhJaBNaWC1ENAIPYNCfNt1HuEvP1wfgYehResbXKSCwiea2kaL+xQ8QLT9Rb+KrcAhxy1vGq2aThPBtkjUcV3cJ6zIGbEpEqD5ExXhjNPQm1RAj51DYrz4RquyOPZQPh3MTdHrOcwCqHxDjBu9MWIlgM++9gwzwIA1jwqaTuoxNz9+pPHBu2SYfjXd4MLKMwq/LxFT1vm82qK7f/3KaD1ZVpTzGfn1tKxDjvczHWvAq4aH1chy4XRaCOjCkod3Z82a5irbJVWNwXvgzjKYzMgS19/xVlv6ZrDbhTzdwNZPkyA03U+ukIEQiQ4iO1sjPIXrD/g2Ga7J/W3GSKe+M7QYGDTFXXnLl723GMe6UHbEzzNDdz0mY5GAxiUsT4K4d+U8OYri5gD19dqrnddpgVOcuqcEjpJlGDK9prE7rM/aV5A+40HWj+6mOEsa7Def+7x1xliBGteGMapmpgFnTT2OEeOAUvj59dGT0cJjwo7pDO/GhTzAxxJEKXuIaDrJ4YcS6jyb5opns5C1plwU83RWP26kRsB+CcMBSN7yOic0asKbB3ijWvS0BwD1UhVAfmLjS5FzkjtU+0LoJWrZWzhmrGD1BXJn+3noYpi8E3tGLfTaiCTOE//xixHz/ypl+IPgdYiT9L+mC4h6HEfykGHjKiRKDQ6tyUKs39rtW6h1uuG1f7XfpHmpGXI0yfnKCmxDb1tOf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(38100700002)(478600001)(36756003)(53546011)(31696002)(6486002)(45080400002)(2906002)(316002)(186003)(86362001)(31686004)(966005)(66574015)(54906003)(6666004)(4326008)(83380400001)(8676002)(2616005)(5660300002)(66946007)(8936002)(66556008)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3hKU2dHcG5CUEMrWXhUMElVN05lQTB1Y3hVNkx3U1BXcEJhYWZEY0VzYmRG?=
 =?utf-8?B?SmwxUVJOUVpuYVBpS1EwejY3M0lvWmlEN1p3Z3ZHdmlFMmNSUXk0SS9xWEw0?=
 =?utf-8?B?WWVMN0RmVUNZOS92UlluVm1ydDUrNmY1U0owcXpSdEJsMCtyekVBL1djS2hh?=
 =?utf-8?B?SlRXSkVHU2p5VHp0K2t3dEI4SHdXSWk0R2JnVVI0RFJ1dmd5Q1lDbzRoYkVX?=
 =?utf-8?B?L2hwOElBZ1o5ZFRxZHlNNzNPbkJqcERvTXoxNlNGd2UzRWdOSmRvWm1nTGRB?=
 =?utf-8?B?NENOM1gxUHdmQzR5Y2RxZW1RV3VySEZIUTRRMVdVNFpjelR1NnZadGUzZ3N0?=
 =?utf-8?B?WjlCN3plVUZHZzA0Y1Bsem9EMVhOZFNIWlN5aUtKbWhMMlorcUx3SUtpRThH?=
 =?utf-8?B?MjNjanpBQnduRkVJK2Y5QWYxYkZKaTI4M3E4K3Y0R0dRT24rVzhKNER1SE42?=
 =?utf-8?B?NTdaaVozK0dURjZIMmxkbXhDRVRyRWZaSDlaNXBDUkE5ekN6cUtzVG1hSis5?=
 =?utf-8?B?VUNobHJObUJNV1pPczE1Si9sQldOODJpTHJHWjFTL3lJaTFnd3dPTEd2VTNw?=
 =?utf-8?B?eGxFNURBdUJMOHdibUJKSk9HZ0I5Z2NKM2grK3dyanprd3ducXVNZWJMemtD?=
 =?utf-8?B?bG8wODdMaTc0V0VQdDN5RHg3MjNNdnU3aDZ4cVlUNUZENGYwc2xFZFhGMHdn?=
 =?utf-8?B?TmF6QzN4eEhoT0NiMk1KYlpKYkp2c2E5SlE5TDBxMzFWV2hrMVk1MDJqeG9w?=
 =?utf-8?B?RGw3RkRLYWJ5bDg5a0Z1aWhyMDVkTGhEQkZJYnBpaUNxNXR5eGc1QnNacUp0?=
 =?utf-8?B?aE5mSWI3eUdnWmQ4cDdRYlVCZjhWTGNMR0YwbEM5Rk9QazdOTWo2bjVucXlO?=
 =?utf-8?B?WHlSU0tJaW9DUm40VkpucVQwcGNVK3JDWmFPcjVxVDFidTVtNGxqdy9pUHZV?=
 =?utf-8?B?cjkvbitYY2FLQ21XV0JzdzdjTUQrODJqM3RCZUlhNWpQWC9jSm96eHJhV2kz?=
 =?utf-8?B?NXROTmdLeUJEemdkeDM0UHAxZ2xua0FCU2NvRlcxLy90RlczSTNnRzBLQ2J3?=
 =?utf-8?B?c1pxZy96SGFpTnVCVU9aU0hPeTdINnMybGc0a2N6VkhORGx1dDU0VVlISHh4?=
 =?utf-8?B?bFJFbVVPQ1kwMFZiamE0dVBuUG1XK2lqQWRxUWJwdTJHR2EvNUJSY3RzaUY1?=
 =?utf-8?B?Z1d5RlhMREVJS1VFV0l3eEVoVk5Wc3ZGSEpGb0h1UFp2MWRPb3M1dEI1NGVD?=
 =?utf-8?B?VWhETi9XVG11MDBVVlFscWpxVWRRLzRUNHI4QWtmYk5wSXVhaTlpSFJjUkJD?=
 =?utf-8?B?bEVpT2UraHFkNlYya1R6bmlPODhVYkVhTkVDMVlUeTd3WEN2QUVkdUhhOWNv?=
 =?utf-8?B?Z2lKSy8yaXVxd1NBK2JVbUlGeGNUM2pvMnVCZ1VHeEg1azRycHdmdVVDMkpO?=
 =?utf-8?B?OVR1a2hOU1hyclEwckJScFl0S0diRTFIUXU2OERjRDl1ZThTenB4UldxZnlr?=
 =?utf-8?B?MnhhRTVJZzVHUnU3UjQzNmQxRkhVbDl6SHd5KzRVcmt6N2c1ZjA4SUt5blVH?=
 =?utf-8?B?SWMxcGVjemEwWG1NTzZndVJEc2k2THdPNzAydVRWclhQZS93eVI4bFJUTDZu?=
 =?utf-8?B?Q1kwRjUwWkR0YS9QQnduUjhDdE10Y3BBbFpVQ01jNGlhZHRodUxzOFdBQ1ZE?=
 =?utf-8?B?ZWMwU2l2VDl1bDk2SHhKODhBcU1tdis4UXAyMGRrUWs0bWluRWZxUDN6c1p3?=
 =?utf-8?B?anhUTmsweWd4c0RjRkpiWnYvelhRTklaVy9xK1Fqck5ERmVtM0ZDY1FvYWRP?=
 =?utf-8?B?amVOQWdwR29sZ1hxY1FNbmU1WXNEdXBMcmNZZ3h3UUJoQmpvenFLMGRQcDA0?=
 =?utf-8?Q?uyNLqcoFP4cpq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e663f2c2-615b-41d6-998f-08d947977779
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 13:50:12.1967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svJj/G6nk8II3psU/K8tDD7bPZxi/9Wa5hW7o2yf8fpF43pFHqo6EtO1rVPh9fb6mTbwgl5kj3LaDFDPwqResA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "Liu,
 Jenny \(Jing\)" <Jenny-Jing.Liu@amd.com>, "Marsan,
 Luugi" <Luugi.Marsan@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0aWFuLAoKSSBoYXZlIHB1c2hlZCBpdCBpbnRvIGFtZC1zdGFnaW5nLWRrbXMtNS4x
MSwgYnV0IGl0IGNhdXNlcyBhIHJlZ3Jlc3Npb24gCndpdGggdGVzdCBUcmFuc2ZlckJlbmNoIG9u
IE1JMjAwLiBKaXJhIGlzIGhlcmU6Cmh0dHBzOi8vb250cmFjay1pbnRlcm5hbC5hbWQuY29tL2Jy
b3dzZS9TV0RFVi0yOTUyNDUKCkNhbiB5b3UgcGxlYXNlIHRha2UgYSBsb29rPyBUaGFua3MhCgpS
ZWdhcmRzLApFcmljCgpPbiAyMDIxLTA3LTE0IDQ6MzMgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3
cm90ZToKPiBIaSBFcmljLAo+Cj4gZmVlbCBmcmVlIHRvIHB1c2ggaW50byBhbWQtc3RhZ2luZy1k
a21zLTUuMTEsIGJ1dCBwbGVhc2UgZG9uJ3QgcHVzaCBpdCAKPiBpbnRvIGFtZC1zdGFnaW5nLWRy
bS1uZXh0Lgo+Cj4gVGhlIGxhdGVyIHdpbGwganVzdCBjYXVzZSBhIG1lcmdlIGZhaWx1cmUgd2hp
Y2ggQWxleCBuZWVkcyB0byByZXNvbHZlIAo+IG1hbnVhbGx5Lgo+Cj4gSSBjYW4gdGFrZSBjYXJl
IG9mIHB1c2hpbmcgdG8gYW1kLXN0YWdpbmctZHJtLW5leHQgYXMgc29vbiBhcyB0aGF0IGlzIAo+
IHJlYmFzZWQgb24gbGF0ZXN0IHVwc3RyZWFtLgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4K
PiBBbSAxMy4wNy4yMSB1bSAyMToxOSBzY2hyaWViIEVyaWMgSHVhbmc6Cj4+IEhpIENocmlzdGlh
bi9GZWxpeCwKPj4KPj4gSWYgeW91IGRvbid0IGhhdmUgb2JqZWN0aW9uLCBpdCB3aWxsIGJlIHB1
c2hlZCBpbnRvIAo+PiBhbWQtc3RhZ2luZy1ka21zLTUuMTEgYW5kIGFtZC1zdGFnaW5nLWRybS1u
ZXh0Lgo+Pgo+PiBUaGFua3MsCj4+IEVyaWMKPj4KPj4gT24gMjAyMS0wNy0xMyAzOjE3IHAubS4s
IEVyaWMgSHVhbmcgd3JvdGU6Cj4+PiBGb3IgYWxsb2NhdGlvbnMgbGFyZ2VyIHRoYW4gNDhNaUIg
d2UgbmVlZCBtb3JlIHRoYW4gYSBwYWdlIGZvciB0aGUKPj4+IGhvdXNla2VlcGluZyBpbiB0aGUg
d29yc3QgY2FzZSByZXN1bHRpbmcgaW4gdGhlIHVzdWFsIHZtYWxsb2Mgb3ZlcmhlYWQuCj4+Pgo+
Pj4gVHJ5IHRvIGF2b2lkIHRoaXMgYnkgYXNzdW1pbmcgdGhlIGdvb2QgY2FzZSBhbmQgb25seSBm
YWxsaW5nIGJhY2sgdG8gCj4+PiB0aGUKPj4+IHdvcnN0IGNhc2UgaWYgdGhpcyBkaWRuJ3Qgd29y
a2VkLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KPj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgSHVhbmcgPGppbmh1aWVyaWMu
aHVhbmdAYW1kLmNvbT4KPj4+IFJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3Vl
aGxpbmdAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZyYW1fbWdyLmMgfCA3MSAKPj4+ICsrKysrKysrKysrKysrKy0tLS0tCj4+PiDCoCAx
IGZpbGUgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4+Pgo+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5j
IAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYwo+Pj4g
aW5kZXggYmU0MjYxYzQ1MTJlLi5lY2JlMDVlMWRiNjYgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYwo+Pj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKPj4+IEBAIC0zNjEsOSArMzYxLDEx
IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92cmFtX21ncl92aXJ0X3N0YXJ0KHN0cnVjdCAKPj4+IHR0
bV9yZXNvdXJjZSAqbWVtLAo+Pj4gwqAgc3RhdGljIGludCBhbWRncHVfdnJhbV9tZ3JfbmV3KHN0
cnVjdCB0dG1fcmVzb3VyY2VfbWFuYWdlciAqbWFuLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKnRibywKPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IHR0bV9w
bGFjZSAqcGxhY2UsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVu
c2lnbmVkIGxvbmcgbnVtX25vZGVzLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB1bnNpZ25lZCBsb25nIHBhZ2VzX3Blcl9ub2RlLAo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdHRtX3Jlc291cmNlICptZW0pCj4+PiDC
oCB7Cj4+PiAtwqDCoMKgIHVuc2lnbmVkIGxvbmcgbHBmbiwgbnVtX25vZGVzLCBwYWdlc19wZXJf
bm9kZSwgcGFnZXNfbGVmdCwgcGFnZXM7Cj4+PiArwqDCoMKgIHVuc2lnbmVkIGxvbmcgbHBmbiwg
cGFnZXNfbGVmdCwgcGFnZXM7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfdnJhbV9tZ3Ig
Km1nciA9IHRvX3ZyYW1fbWdyKG1hbik7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2ID0gdG9fYW1kZ3B1X2RldmljZShtZ3IpOwo+Pj4gwqDCoMKgwqDCoCB1aW50NjRf
dCB2aXNfdXNhZ2UgPSAwLCBtZW1fYnl0ZXMsIG1heF9ieXRlczsKPj4+IEBAIC0zOTMsMjEgKzM5
NSw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZyYW1fbWdyX25ldyhzdHJ1Y3QgCj4+PiB0dG1fcmVz
b3VyY2VfbWFuYWdlciAqbWFuLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PU1BD
Owo+Pj4gwqDCoMKgwqDCoCB9Cj4+PiDCoCAtwqDCoMKgIGlmIChwbGFjZS0+ZmxhZ3MgJiBUVE1f
UExfRkxBR19DT05USUdVT1VTKSB7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgcGFnZXNfcGVyX25vZGUg
PSB+MHVsOwo+Pj4gLcKgwqDCoMKgwqDCoMKgIG51bV9ub2RlcyA9IDE7Cj4+PiAtwqDCoMKgIH0g
ZWxzZSB7Cj4+PiAtI2lmZGVmIENPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFHRQo+Pj4gLcKgwqDC
oMKgwqDCoMKgIHBhZ2VzX3Blcl9ub2RlID0gSFBBR0VfUE1EX05SOwo+Pj4gLSNlbHNlCj4+PiAt
wqDCoMKgwqDCoMKgwqAgLyogZGVmYXVsdCB0byAyTUIgKi8KPj4+IC3CoMKgwqDCoMKgwqDCoCBw
YWdlc19wZXJfbm9kZSA9IDJVTCA8PCAoMjBVTCAtIFBBR0VfU0hJRlQpOwo+Pj4gLSNlbmRpZgo+
Pj4gLcKgwqDCoMKgwqDCoMKgIHBhZ2VzX3Blcl9ub2RlID0gbWF4X3QodWludDMyX3QsIHBhZ2Vz
X3Blcl9ub2RlLAo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIG1lbS0+cGFnZV9hbGlnbm1lbnQpOwo+Pj4gLcKgwqDCoMKgwqDCoMKgIG51bV9ub2RlcyA9
IERJVl9ST1VORF9VUChtZW0tPm51bV9wYWdlcywgcGFnZXNfcGVyX25vZGUpOwo+Pj4gLcKgwqDC
oCB9Cj4+PiAtCj4+PiDCoMKgwqDCoMKgIG5vZGVzID0ga3ZtYWxsb2NfYXJyYXkoKHVpbnQzMl90
KW51bV9ub2Rlcywgc2l6ZW9mKCpub2RlcyksCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEdGUF9LRVJORUwgfCBfX0dGUF9aRVJPKTsKPj4+IMKgwqDCoMKgwqAg
aWYgKCFub2Rlcykgewo+Pj4gQEAgLTQzNSw3ICs0MjIsMTIgQEAgc3RhdGljIGludCBhbWRncHVf
dnJhbV9tZ3JfbmV3KHN0cnVjdCAKPj4+IHR0bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4sCj4+PiDC
oMKgwqDCoMKgIGkgPSAwOwo+Pj4gwqDCoMKgwqDCoCBzcGluX2xvY2soJm1nci0+bG9jayk7Cj4+
PiDCoMKgwqDCoMKgIHdoaWxlIChwYWdlc19sZWZ0KSB7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgdWlu
dDMyX3QgYWxpZ25tZW50ID0gbWVtLT5wYWdlX2FsaWdubWVudDsKPj4+ICvCoMKgwqDCoMKgwqDC
oCB1bnNpZ25lZCBsb25nIGFsaWdubWVudCA9IG1lbS0+cGFnZV9hbGlnbm1lbnQ7Cj4+PiArCj4+
PiArwqDCoMKgwqDCoMKgwqAgaWYgKGkgPj0gbnVtX25vZGVzKSB7Cj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByID0gLUUyQklHOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBl
cnJvcjsKPj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KHBhZ2VzID49IHBhZ2VzX3Blcl9ub2RlKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YWxpZ25tZW50ID0gcGFnZXNfcGVyX25vZGU7Cj4+PiBAQCAtNDkyLDYgKzQ4NCw0OSBAQCBzdGF0
aWMgaW50IGFtZGdwdV92cmFtX21ncl9uZXcoc3RydWN0IAo+Pj4gdHRtX3Jlc291cmNlX21hbmFn
ZXIgKm1hbiwKPj4+IMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+PiDCoCB9Cj4+PiDCoCArLyoqCj4+
PiArICogYW1kZ3B1X3ZyYW1fbWdyX2FsbG9jIC0gYWxsb2NhdGUgbmV3IHJhbmdlCj4+PiArICoK
Pj4+ICsgKiBAbWFuOiBUVE0gbWVtb3J5IHR5cGUgbWFuYWdlcgo+Pj4gKyAqIEB0Ym86IFRUTSBC
TyB3ZSBuZWVkIHRoaXMgcmFuZ2UgZm9yCj4+PiArICogQHBsYWNlOiBwbGFjZW1lbnQgZmxhZ3Mg
YW5kIHJlc3RyaWN0aW9ucwo+Pj4gKyAqIEBtZW06IHRoZSByZXN1bHRpbmcgbWVtIG9iamVjdAo+
Pj4gKyAqCj4+PiArICogQWxsb2NhdGUgVlJBTSBmb3IgdGhlIGdpdmVuIEJPLgo+Pj4gKyAqLwo+
Pj4gK3N0YXRpYyBpbnQgYW1kZ3B1X3ZyYW1fbWdyX2FsbG9jKHN0cnVjdCB0dG1fcmVzb3VyY2Vf
bWFuYWdlciAqbWFuLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCB0dG1fYnVmZmVyX29iamVjdCAqdGJvLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbnN0IHN0cnVjdCB0dG1fcGxhY2UgKnBsYWNlLAo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB0dG1fcmVzb3VyY2UgKm1lbSkKPj4+ICt7Cj4+PiAr
wqDCoMKgIHVuc2lnbmVkIGxvbmcgbnVtX25vZGVzLCBwYWdlc19wZXJfbm9kZTsKPj4+ICvCoMKg
wqAgaW50IHI7Cj4+PiArCj4+PiArwqDCoMKgIGlmIChwbGFjZS0+ZmxhZ3MgJiBUVE1fUExfRkxB
R19DT05USUdVT1VTKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBhbWRncHVfdnJhbV9tZ3Jf
bmV3KG1hbiwgdGJvLCBwbGFjZSwgMSwgfjB1bCwgbWVtKTsKPj4+ICsKPj4+ICsjaWZkZWYgQ09O
RklHX1RSQU5TUEFSRU5UX0hVR0VQQUdFCj4+PiArwqDCoMKgIHBhZ2VzX3Blcl9ub2RlID0gSFBB
R0VfUE1EX05SOwo+Pj4gKyNlbHNlCj4+PiArwqDCoMKgIC8qIGRlZmF1bHQgdG8gMk1CICovCj4+
PiArwqDCoMKgIHBhZ2VzX3Blcl9ub2RlID0gMlVMIDw8ICgyMFVMIC0gUEFHRV9TSElGVCk7Cj4+
PiArI2VuZGlmCj4+PiArwqDCoMKgIHBhZ2VzX3Blcl9ub2RlID0gbWF4X3QodWludDMyX3QsIHBh
Z2VzX3Blcl9ub2RlLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBt
ZW0tPnBhZ2VfYWxpZ25tZW50KTsKPj4+ICvCoMKgwqAgbnVtX25vZGVzID0gRElWX1JPVU5EX1VQ
KG1lbS0+bnVtX3BhZ2VzLCBwYWdlc19wZXJfbm9kZSk7Cj4+PiArCj4+PiArwqDCoMKgIGlmIChz
aXplb2Yoc3RydWN0IGRybV9tbV9ub2RlKSAqIG51bV9ub2RlcyA+IFBBR0VfU0laRSkgewo+Pj4g
K8KgwqDCoMKgwqDCoMKgIHIgPSBhbWRncHVfdnJhbV9tZ3JfbmV3KG1hbiwgdGJvLCBwbGFjZSwK
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUEFHRV9TSVpFIC8gc2l6ZW9mKHN0
cnVjdCBkcm1fbW1fbm9kZSksCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBh
Z2VzX3Blcl9ub2RlLMKgwqDCoCBtZW0pOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyICE9IC1F
MkJJRykKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByOwo+Pj4gK8KgwqDCoCB9
Cj4+PiArCj4+PiArwqDCoMKgIHJldHVybiBhbWRncHVfdnJhbV9tZ3JfbmV3KG1hbiwgdGJvLCBw
bGFjZSwgbnVtX25vZGVzLCAKPj4+IHBhZ2VzX3Blcl9ub2RlLAo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZW0pOwo+Pj4gK30KPj4+ICsKPj4+IMKgIC8qKgo+Pj4g
wqDCoCAqIGFtZGdwdV92cmFtX21ncl9kZWwgLSBmcmVlIHJhbmdlcwo+Pj4gwqDCoCAqCj4+PiBA
QCAtNjkzLDcgKzcyOCw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92cmFtX21ncl9kZWJ1ZyhzdHJ1
Y3QgCj4+PiB0dG1fcmVzb3VyY2VfbWFuYWdlciAqbWFuLAo+Pj4gwqAgfQo+Pj4gwqAgwqAgc3Rh
dGljIGNvbnN0IHN0cnVjdCB0dG1fcmVzb3VyY2VfbWFuYWdlcl9mdW5jIAo+Pj4gYW1kZ3B1X3Zy
YW1fbWdyX2Z1bmMgPSB7Cj4+PiAtwqDCoMKgIC5hbGxvY8KgwqDCoCA9IGFtZGdwdV92cmFtX21n
cl9uZXcsCj4+PiArwqDCoMKgIC5hbGxvY8KgwqDCoCA9IGFtZGdwdV92cmFtX21ncl9hbGxvYywK
Pj4+IMKgwqDCoMKgwqAgLmZyZWXCoMKgwqAgPSBhbWRncHVfdnJhbV9tZ3JfZGVsLAo+Pj4gwqDC
oMKgwqDCoCAuZGVidWfCoMKgwqAgPSBhbWRncHVfdnJhbV9tZ3JfZGVidWcKPj4+IMKgIH07Cj4+
Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFt
ZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0
dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUz
QSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1n
ZngmYW1wO2RhdGE9MDQlN0MwMSU3Q2ppbmh1aWVyaWMuaHVhbmclNDBhbWQuY29tJTdDMWYzNjhk
ZWZhODgwNDI2NzdmNDAwOGQ5NDZhMjE3YzglN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRl
MTgzZCU3QzAlN0MwJTdDNjM3NjE4NDg0MjcwMTk3MDIxJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNk
OGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pY
VkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPXd2dUhOdUsxZ1FCWWJFcnZoQk8lMkZhbWJLcE56
akhMMkE5ZWEyMmZ2UU1rWSUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4KPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
