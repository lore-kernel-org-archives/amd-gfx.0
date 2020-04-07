Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E122AC2BA2B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 15:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07EE20730
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 15:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Hj7S2DEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07EE20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74EDF6E8A1;
	Tue,  7 Apr 2020 15:43:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBCEB6E8A1
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 15:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQBbo23G5I1Njrd6uquMPuN9dAI2lMim+8WlNEaaMtpnNmR1it6UiFAPivUc7G76shQqZ9UizHvbUIZloW2YkBZWM8Ss5YFrVkLzj9wSw37lNOuJ1FaZiYN55YC6UIfO/XzoQNpT+AZg6MlAy06IYeLoNpPGmpg7b7JxZZCeYgH9scmvh0fS2XCYFd1GN1KPxsYdGRnNn31x8AX7+QAeezjoxwXBw8WoAd3L2htzEOxqhh8h04C9Yt2UPl1cdiQ7JQ74C75r0ZYZr6rZldMYT16yZV5YNWB1pGVItkWIu4sg34WHpcgXpjFT/HEt6+ZBepNFtquZwGeZ7tdrmhddOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KNA2XZZkBZ2DqRfmYDUMWkLq90MB+VmjZiRxhZXYAQ=;
 b=nBfJWIxCMjRkiBQa4syvEtK/8AGCfwQEiLztyqkYYe1kaJiJYFoTrdmGsZrVTNs3NmKgcRRO7OnT2Bob8MkiUVDr+mrLPa44y47MPBmEsGlVikinoG6Z58GOBWld/RTJweHxdiWa38IHzYI3GLWxBSKM2sH/KQ4/7I8YZLMp1R+nmEXvwwn2Af3Sdz7DvoioV3Xj189o2vEiQ56P4zaYF6BEDU4n1M21FN+1dyTSam98MAD9zlYLKdG9UOwffUNNTx388vxeuQoPu7Xeh/p0ndvOWo4HImAe3JDLX9PUOjMT3NJ6FfCWms7tqaSSikDg15xcaN6bHJjC6qQpsezkkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KNA2XZZkBZ2DqRfmYDUMWkLq90MB+VmjZiRxhZXYAQ=;
 b=Hj7S2DEvULd0T4/7H9iyeS6xm6/F5mrqLcC/a5H4QEqSXbxhBQ5QfUJwr4lXmBuRUvT9Wx+a5LHEPT7gDY0Nm825IdyO6YxP93+ISM7BTN+DbcRlf58XDNfi+cny3fzjT0wFdZrVifKJla8aq4QXotYh+/Ss6O+ZkNWYQywn26w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Tue, 7 Apr
 2020 15:43:22 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 15:43:22 +0000
Subject: Re: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
 playback
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org,
 ray.huang@amd.com
References: <1585886873-22825-1-git-send-email-Prike.Liang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <0233f59a-a225-75c0-22f6-7c61e3b70475@amd.com>
Date: Tue, 7 Apr 2020 11:43:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1585886873-22825-1-git-send-email-Prike.Liang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::41) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTOPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Tue, 7 Apr 2020 15:43:22 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92aa0f91-7702-42ec-9567-08d7db0a6747
X-MS-TrafficTypeDiagnostic: SN1PR12MB2414:|SN1PR12MB2414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2414EA460950D10DAD761F7392C30@SN1PR12MB2414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(66946007)(31696002)(66556008)(8936002)(66476007)(6486002)(8676002)(81166006)(4326008)(81156014)(6636002)(478600001)(86362001)(31686004)(16576012)(316002)(44832011)(36756003)(52116002)(15650500001)(16526019)(186003)(26005)(956004)(5660300002)(2906002)(2616005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +IuDparSi4vn2LyL+r9oiDXzmlBbWf4PuTxa2aIEWVMpmkqGUvCZleIc4H52NqIMQ0cG/yQTp16NabD3Zf0evLPKGOi60wxMkNyRzne290IRK8njvoi1ytL31PPpJxOeRxs7whT1qObN2OCd5Y/mfAXT0PTjB/aqgW60henMErdxhuw8nsOi51IPk+QyUTDxUrCTZi4xlWe45rYrVo0L+09j7KS4hLHG4l5W65MsBpCudfoquWFIuLWqrnBOa+NNjOE6NB+rHHLivzuQ0H0un3odiMGg+fCFE1FhH68Ijjlq1mg2/krElcDjIJibWWJJBIBg7NIPvTmkGziR3tm4wb+VUt8mgnhDZ0dM3tpkQvnuPxgwbEq4W1anzgZniCwLLls9NcGvfqpJef+FY52x+1qqQ+5KL+1K495QssTXXxvduDBo6Bba1A4+iYthLIZz
X-MS-Exchange-AntiSpam-MessageData: XW0tCti6czVTjdxYuhpUgW0DTnh3xhyv6ZjqHQXQdyBobybkkxH03DLPUrAlbs2PvI5kikf9O+YGHicOziboHiGdrEv/0faMy21z8oOKJDi3e8LLIoFivBzAV/2JOvhZ5YkzxfgD4tm/g6tJIqBN6w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92aa0f91-7702-42ec-9567-08d7db0a6747
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 15:43:22.7053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jJt4qXg0dgyK4Bic/vYCbZcgR0AUhSauulDwMPk5rd8m0IRs0cTK7LuM1nErLfxOQ6T1x8UFUR+Kiod9zhD5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2414
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
Cc: alexander.deucher@amd.com, evan.quan@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U29ycnksIEkgbWlzc2VkIHRoaXMgZW1haWwgdGhyZWFkIGJlY2F1c2UgdGhlIHN1YmplY3Qgc2Vl
bWVkIGlycmVsZXZhbnQKdG8gbWUuIEkgc3RpbGwgZG9uJ3QgZ2V0IHdoeSB0aGlzIGlzIGNhdXNp
bmcgYSBwcm9ibGVtIHdpdGgKc3VzcGVuZC9yZXN1bWUgd2l0aCB2aWRlbyBwbGF5YmFjay4KClRo
ZSBmdW5jdGlvbnMgeW91J3JlIGNoYW5naW5nIGFyZSBtb3N0bHkgdXNlZCB3aGVuIHJ1bm5pbmcg
d2l0aG91dCBIV1MuClRoaXMgc2hvdWxkIG9ubHkgYmUgdGhlIGNhc2UgZHVyaW5nIGJyaW5nLXVw
cyBvciB3aGlsZSBkZWJ1Z2dpbmcgSFdTCmlzc3Vlcy4gT3RoZXJ3aXNlIHRoZXkncmUgb25seSB1
c2VkIGZvciBzZXR0aW5nIHVwIHRoZSBISVEuIFRoYXQgbWVhbnMKaW4gbm9ybWFsIG9wZXJhdGlv
biwgdGhlc2UgZnVuY3Rpb25zIHNob3VsZCBub3QgYmUgdXNlZCBmb3IgdXNlciBtb2RlCnF1ZXVl
IG1hcHBpbmcsIHdoaWNoIGlzIGhhbmRsZWQgYnkgdGhlIEhXUy4KClJheSwgSSB2YWd1ZWx5IHJl
bWVtYmVyIHdlIGRpc2N1c3NlZCB1c2luZyBLSVEgZm9yIG1hcHBpbmcgdGhlIEhJUSBhdApzb21l
IHBvaW50LiBEaWQgYW55b25lIGV2ZXIgcHJvcG9zZSBhIHBhdGNoIGZvciB0aGF0PwoKVGhhbmtz
LArCoCBGZWxpeAoKQW0gMjAyMC0wNC0wMyB1bSAxMjowNyBhLm0uIHNjaHJpZWIgUHJpa2UgTGlh
bmc6Cj4gVGhlIHN5c3RlbSB3aWxsIGJlIGhhbmcgdXAgZHVyaW5nIFMzIGFzIFNNVSBpcyBwZW5k
aW5nIGF0IEdDIG5vdAo+IHJlc3Bvc2UgdGhlIHJlZ2lzdGVyIENQX0hRRF9BQ1RJVkUgYWNjZXNz
IHJlcXVlc3QgYW5kIHRoaXMgaXNzdWUKPiBjYW4gYmUgZml4ZWQgYnkgYWRkaW5nIFJMQyBzYWZl
IG1vZGUgZ3VhcmQgYmVmb3JlIGVhY2ggSFFECj4gbWFwL3VubWFwIHJldHJpdmUgb3B0Lgo+Cj4g
U2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+Cj4gVGVzdGVk
LWJ5OiBNZW5nYmluZyBXYW5nIDxNZW5nYmluZy5XYW5nQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMgfCA2ICsrKysrKwo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jICAgICAgICAgICAgIHwgNCAr
KysrCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jCj4gaW5kZXggZGY4
NDFjMi4uZTI2NTA2MyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYW1ka2ZkX2dmeF92OS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZF9nZnhfdjkuYwo+IEBAIC0yMzIsNiArMjMyLDcgQEAgaW50IGtnZF9nZnhf
djlfaHFkX2xvYWQoc3RydWN0IGtnZF9kZXYgKmtnZCwgdm9pZCAqbXFkLCB1aW50MzJfdCBwaXBl
X2lkLAo+ICAJdWludDMyX3QgKm1xZF9ocWQ7Cj4gIAl1aW50MzJfdCByZWcsIGhxZF9iYXNlLCBk
YXRhOwo+ICAKPiArCWFtZGdwdV9nZnhfcmxjX2VudGVyX3NhZmVfbW9kZShhZGV2KTsKPiAgCW0g
PSBnZXRfbXFkKG1xZCk7Cj4gIAo+ICAJYWNxdWlyZV9xdWV1ZShrZ2QsIHBpcGVfaWQsIHF1ZXVl
X2lkKTsKPiBAQCAtMjk5LDYgKzMwMCw3IEBAIGludCBrZ2RfZ2Z4X3Y5X2hxZF9sb2FkKHN0cnVj
dCBrZ2RfZGV2ICprZ2QsIHZvaWQgKm1xZCwgdWludDMyX3QgcGlwZV9pZCwKPiAgCj4gIAlyZWxl
YXNlX3F1ZXVlKGtnZCk7Cj4gIAo+ICsJYW1kZ3B1X2dmeF9ybGNfZXhpdF9zYWZlX21vZGUoYWRl
dik7Cj4gIAlyZXR1cm4gMDsKPiAgfQo+ICAKPiBAQCAtNDk3LDYgKzQ5OSw3IEBAIGJvb2wga2dk
X2dmeF92OV9ocWRfaXNfb2NjdXBpZWQoc3RydWN0IGtnZF9kZXYgKmtnZCwgdWludDY0X3QgcXVl
dWVfYWRkcmVzcywKPiAgCWJvb2wgcmV0dmFsID0gZmFsc2U7Cj4gIAl1aW50MzJfdCBsb3csIGhp
Z2g7Cj4gIAo+ICsJYW1kZ3B1X2dmeF9ybGNfZW50ZXJfc2FmZV9tb2RlKGFkZXYpOwo+ICAJYWNx
dWlyZV9xdWV1ZShrZ2QsIHBpcGVfaWQsIHF1ZXVlX2lkKTsKPiAgCWFjdCA9IFJSRUczMihTT0Mx
NV9SRUdfT0ZGU0VUKEdDLCAwLCBtbUNQX0hRRF9BQ1RJVkUpKTsKPiAgCWlmIChhY3QpIHsKPiBA
QCAtNTA4LDYgKzUxMSw3IEBAIGJvb2wga2dkX2dmeF92OV9ocWRfaXNfb2NjdXBpZWQoc3RydWN0
IGtnZF9kZXYgKmtnZCwgdWludDY0X3QgcXVldWVfYWRkcmVzcywKPiAgCQkJcmV0dmFsID0gdHJ1
ZTsKPiAgCX0KPiAgCXJlbGVhc2VfcXVldWUoa2dkKTsKPiArCWFtZGdwdV9nZnhfcmxjX2V4aXRf
c2FmZV9tb2RlKGFkZXYpOwo+ICAJcmV0dXJuIHJldHZhbDsKPiAgfQo+ICAKPiBAQCAtNTQxLDYg
KzU0NSw3IEBAIGludCBrZ2RfZ2Z4X3Y5X2hxZF9kZXN0cm95KHN0cnVjdCBrZ2RfZGV2ICprZ2Qs
IHZvaWQgKm1xZCwKPiAgCXVpbnQzMl90IHRlbXA7Cj4gIAlzdHJ1Y3QgdjlfbXFkICptID0gZ2V0
X21xZChtcWQpOwo+ICAKPiArCWFtZGdwdV9nZnhfcmxjX2VudGVyX3NhZmVfbW9kZShhZGV2KTsK
PiAgCWlmIChhZGV2LT5pbl9ncHVfcmVzZXQpCj4gIAkJcmV0dXJuIC1FSU87Cj4gIAo+IEBAIC01
NzcsNiArNTgyLDcgQEAgaW50IGtnZF9nZnhfdjlfaHFkX2Rlc3Ryb3koc3RydWN0IGtnZF9kZXYg
KmtnZCwgdm9pZCAqbXFkLAo+ICAJfQo+ICAKPiAgCXJlbGVhc2VfcXVldWUoa2dkKTsKPiArCWFt
ZGdwdV9nZnhfcmxjX2V4aXRfc2FmZV9tb2RlKGFkZXYpOwo+ICAJcmV0dXJuIDA7Cj4gIH0KPiAg
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4gaW5kZXggMWZlYTA3Ny4uZWUx
MDdkOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+IEBAIC0zNTMz
LDYgKzM1MzMsNyBAQCBzdGF0aWMgaW50IGdmeF92OV8wX2tpcV9pbml0X3JlZ2lzdGVyKHN0cnVj
dCBhbWRncHVfcmluZyAqcmluZykKPiAgCXN0cnVjdCB2OV9tcWQgKm1xZCA9IHJpbmctPm1xZF9w
dHI7Cj4gIAlpbnQgajsKPiAgCj4gKwlhbWRncHVfZ2Z4X3JsY19lbnRlcl9zYWZlX21vZGUoYWRl
dik7Cj4gIAkvKiBkaXNhYmxlIHdwdHIgcG9sbGluZyAqLwo+ICAJV1JFRzMyX0ZJRUxEMTUoR0Ms
IDAsIENQX1BRX1dQVFJfUE9MTF9DTlRMLCBFTiwgMCk7Cj4gIAo+IEBAIC0zNjI5LDYgKzM2MzAs
NyBAQCBzdGF0aWMgaW50IGdmeF92OV8wX2tpcV9pbml0X3JlZ2lzdGVyKHN0cnVjdCBhbWRncHVf
cmluZyAqcmluZykKPiAgCWlmIChyaW5nLT51c2VfZG9vcmJlbGwpCj4gIAkJV1JFRzMyX0ZJRUxE
MTUoR0MsIDAsIENQX1BRX1NUQVRVUywgRE9PUkJFTExfRU5BQkxFLCAxKTsKPiAgCj4gKwlhbWRn
cHVfZ2Z4X3JsY19leGl0X3NhZmVfbW9kZShhZGV2KTsKPiAgCXJldHVybiAwOwo+ICB9Cj4gIAo+
IEBAIC0zNjM3LDYgKzM2MzksNyBAQCBzdGF0aWMgaW50IGdmeF92OV8wX2tpcV9maW5pX3JlZ2lz
dGVyKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKPiAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2ID0gcmluZy0+YWRldjsKPiAgCWludCBqOwo+ICAKPiArCWFtZGdwdV9nZnhfcmxjX2VudGVy
X3NhZmVfbW9kZShhZGV2KTsKPiAgCS8qIGRpc2FibGUgdGhlIHF1ZXVlIGlmIGl0J3MgYWN0aXZl
ICovCj4gIAlpZiAoUlJFRzMyX1NPQzE1KEdDLCAwLCBtbUNQX0hRRF9BQ1RJVkUpICYgMSkgewo+
ICAKPiBAQCAtMzY2OCw2ICszNjcxLDcgQEAgc3RhdGljIGludCBnZnhfdjlfMF9raXFfZmluaV9y
ZWdpc3RlcihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4gIAlXUkVHMzJfU09DMTVfUkxDKEdD
LCAwLCBtbUNQX0hRRF9QUV9XUFRSX0hJLCAwKTsKPiAgCVdSRUczMl9TT0MxNV9STEMoR0MsIDAs
IG1tQ1BfSFFEX1BRX1dQVFJfTE8sIDApOwo+ICAKPiArCWFtZGdwdV9nZnhfcmxjX2V4aXRfc2Fm
ZV9tb2RlKGFkZXYpOwo+ICAJcmV0dXJuIDA7Cj4gIH0KPiAgCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
