Return-Path: <SRS0=NjTA=G7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35A6C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 16:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 699FA64DEF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 16:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699FA64DEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E69736E989;
	Thu, 28 Jan 2021 16:14:15 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760087.outbound.protection.outlook.com [40.107.76.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACCD56E989
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 16:14:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KENEimCradijW64hfKU/TBOLomr+BsdhXwrAN5y/bbrTtLbwn5RU4dJIMvDioFnfRK1uCvFnIaAoEZ4CZGn/9ARn6VSiRYD/jBO+vgu49d1KWjfWrnY1A2Mzi/QiRWqlFz22q3ozdzEimFHBUSJRYH8rCDUZVtMQ3kF0ogT0AEN8c7LMaje/CfjM1gCaJvkbGsgxzB4DtO8Jecrxrq4RuPpQb3ca/U9DUo2gMvn9DGRtDG4zT2H29qNqRDg04TIl4mETAnoqeo7+dWpV/fbw5HzDFKjXk/FvSXCjLWDIWOjUbh7wPKYh6Uba3rk2D3gEd7iaNas8b12G9kxw+ja3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Aur++bTQKVQpxZjiXuqyOOB69o65Vqt1W8u1giatr0=;
 b=eEXook2GhRBPWjPT/d8yM9MnQKphfQd6F9dAM0C7t9cwZWP5w0HwXT2Jc9qax9IWOoSrHZ13EFvJW5EGNhtzXzD6KECydWrsNOzrTqE0X9hPpBzpwZLcQ093+vcEIdop9oeOvOHei7z+GKRvIOzeeEE/CEDOlLBbncisGanuq7UY2LG5EI9zguPed0I0+IgGmHTMwg6K0Ud2ugE+w7bFA3pwtoj4A0gLpbAjdwJnNxnLAmGdLMZ8pY+GbuwdJ7kOOJvSomiR1zktNmLfoMQELJZQBH0mrybjr9Ijy1Z8enHxQuJzu0AqEcwp9snoCambmVzmaw8p8P1ADlE+HhiP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Aur++bTQKVQpxZjiXuqyOOB69o65Vqt1W8u1giatr0=;
 b=jserukNlDwR7fIZGmG1jMJTVb+Wt2pNGGGZnKol3uY4n/MRDAeoXz5R7XiF/XfBaHAh1ixkO8yFPeyyqPqgQRxNmWZOOJ+oXRs06w3/lRrq5Di6wGz1oRMpZRJsXQBw/UfzkQsNTAkUPOZ904SMhzGD75vDbiL8Z9VsmbvhEyWY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 28 Jan
 2021 16:14:12 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 16:14:12 +0000
Subject: Re: [RFC PATCH 2/2] drm/amdgpu: enable gfx wave limiting for high
 priority compute jobs
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210128143554.61100-1-nirmoy.das@amd.com>
 <20210128143554.61100-2-nirmoy.das@amd.com>
 <0adf796d-c0c8-87cc-e7c0-8a29336385f7@gmail.com>
 <a44f5a1a-4be3-06a0-764d-23918a51698f@amd.com>
 <4cd8a507-f472-3394-55c2-b55fee588040@gmail.com>
 <b90dd6f2-919e-837b-f26f-73258ab899cb@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a1d26d23-acf4-e76e-6f4d-fecc6bf4fa27@amd.com>
Date: Thu, 28 Jan 2021 17:14:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <b90dd6f2-919e-837b-f26f-73258ab899cb@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 16:14:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be24cfeb-0e97-4e1c-caa3-08d8c3a7c01a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4335:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43353F5F07CE2443E05C618D83BA9@MN2PR12MB4335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udqY88eMSqur5EbP5nz1u/K+ciZe1Hs3wRfK4WuUVmiAAnW6IWKu9XkgSh2ym1eyc4PjUMwgqvqLpFPHvpfYSniTaYeCQyOGaSCWkjEieYuwqEx9U12TEcR8WdQI6GVXDZVqVhhzpJqYZ0m+2fyan49b1fzWvxeTE2e8si8GY5t2EvqBRmQm2OvjsB8igBaBBUJqUg93H1572xqGAcpMoGlZjBh8OQdXI8PCBBoq0gA/9noUufCVPp6YDjzXgxqROO6KcAFrTdXSBxd2u7/6Xltai6ovXL5Yp6o9Z/nj6d+VBirZ2riEl8tLSOmt7BTvPqGt1EL3dAGj96X4bRpGRzhJGEytI1AZE3IvMCAPh2UyOnB4876HpPfFb8JuyylJoKiRQ7Yn5e1kUwM+zMig5NY3ivuXC5iA6CHFs97rtFvPpVkWCRvtDgVCJOlO6i2de1Na0iPcVfoL2EQ/CGrzrbyCyMVpTaUTTDE5epmNlxuldaZHUjiI2AtkdmHvyCcV72INmfyUHkLXb0c1E/dmcDvyZa2PyjY5kylYh+u9xG2B7uypWOUZq8iMvgLeyPL3vtq5FKMiKlACP5RoO7GmNUQcoz6skLrRqawwNuQDZgNmEtbshoDgyzqcDmgV81gdLBZN9+uk49F81P5y2VooGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(6486002)(2906002)(478600001)(86362001)(966005)(316002)(6666004)(4326008)(66574015)(31696002)(8936002)(31686004)(45080400002)(8676002)(53546011)(66556008)(66946007)(66476007)(2616005)(83380400001)(16526019)(186003)(36756003)(110136005)(5660300002)(52116002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b3pXNiszT0lldGRUdndFbCs4Y3p2TzJtM05qUWw1VHovZnBqZUJmNjB5NElu?=
 =?utf-8?B?bVN2d1FMcU14L2x5ZEVRRG10WVVHVW1MNW1qOGxzOXNKK3JIS0RMREdYR00r?=
 =?utf-8?B?bk1XemE4bG5xcVAzUXVUQ0FmdDNNdy9IY3NONnliRk5KWjlNZThoK2JBakZJ?=
 =?utf-8?B?UWpUV1grS0lHc0lheE5iUW9iRFJrVmdZQnZ1MGxQVWRDbUE1b1Q0ZThCckg2?=
 =?utf-8?B?ZEFwZlFJR2dlM1ZUekcyMXNlT2lnSlQ0eDk4bGUwc2hyTXF6aEQ4STRqZ2Jy?=
 =?utf-8?B?Z3l5a0htSzBROGFmaWRxZW9RZFZuWWhNWWhSb0dLSDFEbWthTGxYd0UxdzlP?=
 =?utf-8?B?clR6NlZITCtqako0N2FmMDZzcTlJVHlRSlc4SForMmJ5bDBIVXUvR0NrdWw5?=
 =?utf-8?B?Zm03VnUwSDVWUG9mMVYvRy8xSnExZXlJK0xxVXZpMSsvMFpiNGI0Qm1lVlp2?=
 =?utf-8?B?OUg5Wm9nSHNLWWIrNzUrVHE1T1lrWDk3akd5d285aXRwa0VGVFBBOTdOVmxE?=
 =?utf-8?B?cE0rb1JUSE82RGtLbXVxZWZxUEFzaENNZmRCUFBpMHhMWDB6SUhLaFdkNWNG?=
 =?utf-8?B?bFM5TFpGMituQlF6SEhHZzFuZ3JQVWJhUkFMRDlwMEpHcmFaejV3MmVFdGNF?=
 =?utf-8?B?RnJNcHUrb0l1YlNQYTBmc1ZlSUthYkxmK1M4OUN5V0NpeHVHdDlnQ0VHRHZE?=
 =?utf-8?B?QVkrVWZtallINHFveDdJMTdFUHl3VHIrNWhNbEVZMDg4NkNzTSs2RDZ6bk9v?=
 =?utf-8?B?aHk1QndxTFpNS21KM2xBdFhmV1hrbTlWbkswVVdaR2gzeWxPTXNyakJOblhj?=
 =?utf-8?B?YXVkeHRKK0JLdEQxWUtzVGR3cHVleWF3Y1craGlESlRaeUpTVWFWWURxSEZw?=
 =?utf-8?B?MXQ3a0Qzb2Z1clMrZXRJSkplRGViUjduUjNDWWVncEZXTnB0UjNrcEpsSTJr?=
 =?utf-8?B?Yk9hS2tXVVdhTTRxU3hkbmhSMG9odkc1eVhxVC9CT2plRElJb0hDbXNEVnpM?=
 =?utf-8?B?NWt6TFBLcXlwNlY0Z2UvVWJwRzYrOUpMR2Rqdkc4SldFSTg5QytUYUk4ajNy?=
 =?utf-8?B?dWZZY2tZYWpiUktsTnpZSUY3SEJQb2tmeUdDNlFlS2dMM1F5OGV6VTczemM1?=
 =?utf-8?B?NytLaDFOWis0REl3cUVjY1VBak9pQjA1SWs1SUtYVjFwMWU4Wk1Zb1l6ckR3?=
 =?utf-8?B?QTlkYTllSktnWFpKQU94eFdMOFowUW5uNzMzSTlPTUkwWXF5NzhLZWY4WXA1?=
 =?utf-8?B?akZlSjB4YnNVZVlXUHpXQUZOSFdvaWFlcFZOYUczYWJnTTB1emU1WXlUaFQ2?=
 =?utf-8?B?RUh5VU5VZGExUVJXZFZaSjVuOUtwOVRjV21hRlZrSHcvcGcyWWM3TlVkVnZV?=
 =?utf-8?B?dUVUMG9OODhrOTdna3IzWS94ZklSbmI0MEVQcWFCakVURUY4RnB2bkJLMFlx?=
 =?utf-8?B?engzSHdBMmZURGFBaHBJaGpoTU9tL0hjRWUzdEJLTjNONlpIb1J6ZElXU3hs?=
 =?utf-8?Q?tZPnCITuLGqsa0auBSzZeAzb0rN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be24cfeb-0e97-4e1c-caa3-08d8c3a7c01a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 16:14:12.6629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkXeqDNmjgvsx87FjmiNGil5NL2xn7mSmRKNMUymDJ34TBj6d/V2Gebu3mG3x+91
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
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
Cc: Alan.Harrison@amd.com, Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 ray.huang@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjguMDEuMjEgdW0gMTc6MDEgc2NocmllYiBOaXJtb3k6Cj4KPiBPbiAxLzI4LzIxIDQ6MjUg
UE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDI4LjAxLjIxIHVtIDE2OjIxIHNjaHJp
ZWIgTmlybW95Ogo+Pj4KPj4+IE9uIDEvMjgvMjEgMzo0OSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3
cm90ZToKPj4+PiBBbSAyOC4wMS4yMSB1bSAxNTozNSBzY2hyaWViIE5pcm1veSBEYXM6Cj4+Pj4+
IEVuYWJsZSBnZnggd2F2ZSBsaW1pdGluZyBmb3IgZ2Z4IGpvYnMgYmVmb3JlIHB1c2hpbmcgaGln
aCBwcmlvcml0eQo+Pj4+PiBjb21wdXRlIGpvYnMgc28gdGhhdCBoaWdoIHByaW9yaXR5IGNvbXB1
dGUgam9icyBnZXRzIG1vcmUgcmVzb3VyY2VzCj4+Pj4+IHRvIGZpbmlzaCBlYXJseS4KPj4+Pgo+
Pj4+IFRoZSBwcm9ibGVtIGhlcmUgaXMgd2hhdCBoYXBwZW5zIGlmIHlvdSBoYXZlIG11bHRpcGxl
IGhpZ2ggcHJpb3JpdHkgCj4+Pj4gam9icyBydW5uaW5nIGF0IHRoZSBzYW1lIHRpbWU/Cj4+Pgo+
Pj4KPj4+IEFGQUlVLCBpbiB0aGF0IGNhc2UgcXVhbnR1bSBkdXJhdGlvbiB3aWxsIGNvbWUgaW50
byBlZmZlY3QuIFRoZSAKPj4+IHF1ZXVlIGFyYml0ZXIgd2lsbCBzd2l0Y2gKPj4+Cj4+PiB0byBu
ZXh0IGhpZ2ggcHJpb3JpdHkgYWN0aXZlIHF1ZXVlIG9uY2UgcXVhbnR1bSBkdXJhdGlvbiBleHBp
cmVzLiAKPj4+IFRoaXMgc2hvdWxkIGJlIHNpbWlsYXIgdG8gd2hhdAo+Pj4KPj4+IHdlIGFscmVh
ZHkgaGF2ZSwgbXVsdGlwbGUgbm9ybWFsIHByaW9yaXR5IGpvYnMgc2hhcmluZyBHUFUgcmVzb3Vy
Y2VzIAo+Pj4gYmFzZWQgb24gQ1BfSFFEX1FVQU5UVU0uCj4+Pgo+Pj4gUVVFVUVfRFVSQVRJT04g
cmVnaXN0ZXIgdmFsdWUuCj4+Cj4+IFllYWgsIGJ1dCB3aGVuIHRoZSBmaXJzdCBoaWdoIHByaW9y
aXR5IGpvYiBjb21wbGV0ZXMgaXQgd2lsbCByZXNldCAKPj4gbW1TUElfV0NMX1BJUEVfUEVSQ0VO
VF9HRlggYmFjayB0byB0aGUgZGVmYXVsdCB2YWx1ZS4KPj4KPj4gSGF2ZSB5b3UgY29uc2lkZXJl
ZCB0aGF0Pwo+Cj4KPiBZZXMgSSBuZWVkIGJpdCBvZiBjbGFyaXR5IGhlcmUuIElzbid0IG9uZSBm
cmFtZSguLi5wbTQod2F2ZV9saW1pdCksIAo+IHBtNChJQnMpLCBwbTQocmVzdG9yZV93YXZlX2xp
bWl0KSwgLi4pCj4KPiBleGVjdXRlcyB0b2dldGhlciBhcyBvbmUgdW5pdD8gSWYgdGhhdCBpcyB0
aGUgY2FzZSB0aGVuIHRoZSBuZXh0IGhpZ2ggCj4gcHJpbyBjb21wdXRlIGpvYiB3aWxsIHNldCB0
aGUgd2F2ZSBsaW1pdAo+Cj4gYWdhaW4gYW5kIHdpbGwgYmUgYXBwbGllZCBmb3IgaXRzIGRpc3Bh
dGNoIGNhbGwuCgpZZWFoLCB0aGF0IGlzIGNvcnJlY3QuIEJ1dCB0aGUgcHJvYmxlbSBpcyBzb21l
d2hlcmUgZWxzZS4KCj4KPgo+IEkgZ3Vlc3MgdGhhdCBpcyBub3QgdGhlIGNhc2UgYmVjYXVzZSB5
b3UgYXNrZWQgdGhpcyBxdWVzdGlvbi4gRG8geW91IAo+IHRoaW5rIHdlIHNob3VsZCBoYXZlIG9u
bHkgb25lIGhpZ2ggcHJpb3JpdHkKPgo+IHF1ZXVlIHRoZW4/CgpZZXMgZXhhY3RseSB0aGF0LiBJ
SVJDIHdlIGN1cnJlbnRseSBoYXZlIDQgbG93IHByaW9yaXR5IGFuZCA0IGhpZ2ggCnByaW9yaXR5
IHF1ZXVlcy4KClRoZSBwcm9ibGVtIGlzIHRob3NlIDQgaGlnaCBwcmlvcml0eSBxdWV1ZXMuIElm
IHdlIG9ubHkgdXNlIDEgdGhlbiB3ZSAKd29uJ3QgcnVuIGludG8gdGhpcyBhcyBmYXIgYXMgSSBj
YW4gc2VlLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+Cj4gSSB0cmllZCB0byB0ZXN0IGl0IGJ5
IHJ1bm5pbmcgdHdvIGluc3RhbmNlcyBvZiBzYW1lIHZ1bGthbiB0ZXN0IAo+IGFwcGxpY2F0aW9u
LiBJIGNhbid0IHRyYWNlCj4KPiB0d28gYXBwbGljYXRpb25zIHRvZ2V0aGVyIHVzaW5nIFJHUC4g
RnJvbSB0aGUgdHJhY2Ugb2Ygb25lIAo+IGFwcGxpY2F0aW9uKGFsb25nIHdpdGggb3RoZXIgcnVu
bmluZyB0b2dldGhlciksCj4KPiBJIGRpZG4ndCBzZWUgYW55IHRocm90dGxpbmcgZG93biBvZiBo
aWdoIHByaW9yaXR5IGNvbXB1dGUgam9iKHllbGxvdyAKPiBiYXJzKS4KPgo+Cj4gTGV0IG1lIGtu
b3cgd2hhdCBkbyB5b3UgdGhpbmsuIEkgd2lsbCB3b3JrIHdpdGggQWxhbiB0byBjaGFuZ2UgdGhl
IAo+IHRlc3QgYXBwbGljYXRpb24gc28gdGhhdCB3ZSBjYW4gdmVyaWZ5IHRoaXMKPgo+IHVzaW5n
IG11bHRpcGxlIGhpZ2ggcHJpb3JpdHkgY29udGV4dC4KPgo+Cj4gUmVnYXJkcywKPgo+IE5pcm1v
eQo+Cj4+Cj4+IFRoYW5rcywKPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4KPj4+Cj4+PiBSZWdhcmRzLAo+
Pj4KPj4+IE5pcm1veQo+Pj4KPj4+Cj4+Pj4KPj4+PiBDaHJpc3RpYW4KPj4+Pgo+Pj4+Pgo+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+Pj4+IC0t
LQo+Pj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYyB8IDkgKysr
KysrKysrCj4+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykKPj4+Pj4KPj4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jIAo+
Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCj4+Pj4+IGluZGV4
IDAyNGQwYTU2M2E2NS4uZWU0ODk4OWRmYjRjIDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwo+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfaWIuYwo+Pj4+PiBAQCAtMTk1LDYgKzE5NSwxMCBAQCBpbnQgYW1k
Z3B1X2liX3NjaGVkdWxlKHN0cnVjdCBhbWRncHVfcmluZyAKPj4+Pj4gKnJpbmcsIHVuc2lnbmVk
IG51bV9pYnMsCj4+Pj4+IMKgwqDCoMKgwqAgaWYgKChpYi0+ZmxhZ3MgJiBBTURHUFVfSUJfRkxB
R19FTUlUX01FTV9TWU5DKSAmJiAKPj4+Pj4gcmluZy0+ZnVuY3MtPmVtaXRfbWVtX3N5bmMpCj4+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByaW5nLT5mdW5jcy0+ZW1pdF9tZW1fc3luYyhyaW5nKTsK
Pj4+Pj4gwqAgK8KgwqDCoCBpZiAocmluZy0+ZnVuY3MtPmVtaXRfd2F2ZV9saW1pdCAmJiBqb2Ig
JiYKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGpvYi0+YmFzZS5zX3ByaW9yaXR5ID49IERSTV9TQ0hF
RF9QUklPUklUWV9ISUdIKQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmluZy0+ZnVuY3MtPmVtaXRf
d2F2ZV9saW1pdChyaW5nLCB0cnVlKTsKPj4+Pj4gKwo+Pj4+PiDCoMKgwqDCoMKgIGlmIChyaW5n
LT5mdW5jcy0+aW5zZXJ0X3N0YXJ0KQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmluZy0+ZnVu
Y3MtPmluc2VydF9zdGFydChyaW5nKTsKPj4+Pj4gwqAgQEAgLTI5NSw2ICsyOTksMTEgQEAgaW50
IGFtZGdwdV9pYl9zY2hlZHVsZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgCj4+Pj4+ICpyaW5nLCB1bnNp
Z25lZCBudW1faWJzLAo+Pj4+PiDCoMKgwqDCoMKgIHJpbmctPmN1cnJlbnRfY3R4ID0gZmVuY2Vf
Y3R4Owo+Pj4+PiDCoMKgwqDCoMKgIGlmICh2bSAmJiByaW5nLT5mdW5jcy0+ZW1pdF9zd2l0Y2hf
YnVmZmVyKQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X3JpbmdfZW1pdF9zd2l0Y2hf
YnVmZmVyKHJpbmcpOwo+Pj4+PiArCj4+Pj4+ICvCoMKgwqAgaWYgKHJpbmctPmZ1bmNzLT5lbWl0
X3dhdmVfbGltaXQgJiYgam9iICYmCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBqb2ItPmJhc2Uuc19w
cmlvcml0eSA+PSBEUk1fU0NIRURfUFJJT1JJVFlfSElHSCkKPj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IHJpbmctPmZ1bmNzLT5lbWl0X3dhdmVfbGltaXQocmluZywgZmFsc2UpOwo+Pj4+PiArCj4+Pj4+
IMKgwqDCoMKgwqAgYW1kZ3B1X3JpbmdfY29tbWl0KHJpbmcpOwo+Pj4+PiDCoMKgwqDCoMKgIHJl
dHVybiAwOwo+Pj4+PiDCoCB9Cj4+Pj4KPj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+Pj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+Pj4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5v
cmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDElN0NuaXJt
b3kuZGFzJTQwYW1kLmNvbSU3QzY3ZTkwMzM1N2VlMjQ3ZjljZWIwMDhkOGMzYTBlZmRmJTdDM2Rk
ODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzQ3NDQ0MzI4NzAwNzkz
MCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJs
dU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1FeW91
U1V2YUtqUUlJV2VLRGlsVnJhNzNpTDFlYjBycG5hVUNEQUlEdlhBJTNEJmFtcDtyZXNlcnZlZD0w
IAo+Pj4+Cj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGlu
Zm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDElN0NuaXJtb3kuZGFzJTQwYW1kLmNvbSU3QzY3
ZTkwMzM1N2VlMjQ3ZjljZWIwMDhkOGMzYTBlZmRmJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJk
OTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzQ3NDQ0MzI4NzAwNzkzMCU3Q1Vua25vd24lN0NUV0ZwYkda
c2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dp
TENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1FeW91U1V2YUtqUUlJV2VLRGlsVnJhNzNp
TDFlYjBycG5hVUNEQUlEdlhBJTNEJmFtcDtyZXNlcnZlZD0wIAo+Pj4KPj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
