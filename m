Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBD5C1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 11:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2234120714
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 11:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2Ru5Nogr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2234120714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC69F6E7F1;
	Wed, 25 Mar 2020 11:09:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB3EB6E7F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 11:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRsXkwsppx7swa3qzHFEFwsOAK5vVOcbQPm45T/aMSvqgpoGvkTUdvJuZXOvYSdNlcE4jBJeSlvcIPSpO9KPKe+Q9FVndY/B2K5/Ad6ovBivXwnSMD314v79PeKmvD6nIzHUshwh77gvEeve6HDaGbvqbhn7ECGw29Yv09criACZaqMjY/UC5dMiWTzzQHxSSYCi56Zz0cFnb/2bW+uBBYwh++fk+YCLpGYPhWb/CtmJhL1KldYpnj+sS+gkPECPUeaqKs8YGnVqaZ3YAv7KqMiKh5Vdtae3MtlT7KrCb22R8j359xvO7dp8aSxbht92KA5F+3qYouVxNhS+oM3lkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWoV4lUWxANCeGu4Qpn2a9eXqm6/Kkvccv2F0lKrJRo=;
 b=ZUIV9FAWYrXabzYdeA2K5ZnLJ0E6s9vAU4LijRLgtKfaeays1LQcB96ogJMC1E8vPUlWPmaSJ25xzYcaCtE5H51CmWrq/nkFJYS99EZUwZWL3lYAayDPulQafShHW/N7mFSY4XqoxG9PtaR9JLVRYnbPXZIO7rfcXgHu1Tic2Dzex6JSovrVhjEosVoxWe5hy4VpUC3luupmIq6hXZRKxa7pKPXwMfbY+SZWGntnaQLUaBLoTtxCg9cjNCGcMu7a1KN09QUvHKOwNSOR+Lsk/p8Rx2hhTVSg1E1FbiqWiSMCcwXOsEStRQvWQpjwboF1q795V4Ze8hQJJYa1Hj1tog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWoV4lUWxANCeGu4Qpn2a9eXqm6/Kkvccv2F0lKrJRo=;
 b=2Ru5Nogryd5P0suv56ILBvY9DhmMgqTXbS73xf3qQBp3q4DhSV9JjEMiRRuzPwjsZO+mF+GwrZjiZ5cU9xw5IQ3pPrBjtR7/WafK3ZKHa6HR/wH6Gsm3ep0JAYHon+wEip/tx6ulnVtNdgmjbMeZGTht6qzgnFQbp/IzSaXmUwM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 11:09:54 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c%3]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 11:09:54 +0000
Subject: Re: [PATCH] drm/amdgpu: Check entity rq
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200325110702.30919-1-xinhui.pan@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <8e0e3469-0c41-fbb9-1acf-aff8ff7e783e@amd.com>
Date: Wed, 25 Mar 2020 12:14:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200325110702.30919-1-xinhui.pan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZRAP278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::15) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2f:7f00:f7f4:61fb:9d17:16c0]
 (2003:c5:8f2f:7f00:f7f4:61fb:9d17:16c0) by
 ZRAP278CA0005.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Wed, 25 Mar 2020 11:09:52 +0000
X-Originating-IP: [2003:c5:8f2f:7f00:f7f4:61fb:9d17:16c0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57514fcc-0002-417c-facc-08d7d0ad0b8d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4358:|MN2PR12MB4358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4358C0545CA035E8D5EDC1798BCE0@MN2PR12MB4358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(31686004)(36756003)(316002)(66556008)(52116002)(66476007)(8676002)(53546011)(6486002)(4326008)(8936002)(2906002)(66946007)(54906003)(81166006)(5660300002)(81156014)(186003)(966005)(6666004)(31696002)(66574012)(16526019)(478600001)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4358;
 H:MN2PR12MB3872.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFcoICNbpCYzvrmSmmOnH0IUVRE89mnFCus/hE9S2U+vk3uQ79ct8DxXMgOTX4S7czafgblPbJQltIcLVF/OUWGuHRmWzw17uD/gHygbGc7mZJbUWyKze26Eso9+y9uHJD9rVb4kbncRRqjR77cDG5fhxaSovkTW33jOpfIxbd5NkaLN6oq9ltU0rz3MdAxFxDBkgaLulwaXDTolVgAs4jHrxhB4o84Xe1xDT/aaaXxh++G9CzgA09BcGUOoAFYW7XlZSc3lFS43Lgnve85VYlyhwrGmPCp2Fp/zI0AmwmfpBSnxDPIZuFvD73GNF9yhc7ZFZMrALs5kTxa0/dTHpl8+AvWWWD16vRFC5rNF1VyUp8BSECHfRKpYlrTsbkosZOr7K+8oe9fp69wBJ+X3epBeBcFPu+bpedI6gco17qnbr68jViMJGGjWVTfZVbmG2mI8MFLs16itI7slO0RC73uMIcrXAewQd1/z9zVRAyY=
X-MS-Exchange-AntiSpam-MessageData: 5qF8EppeTLX+LKr/GfH4DJoKTZI1OOU/bu0SBd0sQWmbp8qQWYw2t+yAqOws2dtU3EFTxdFss+SY8pdI7WMgEIPlHgegz64pyQa4Wms8zafFf/jxl9vkIYK7xgNAZudavA4g1xnXyWUhc2zMNfsjwheY7bkUbGrI1Zh5PW1XA29z2VyPmiM6ixykIAhX9/qdVK8FVfFXizZzYs7VxYFvYg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57514fcc-0002-417c-facc-08d7d0ad0b8d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 11:09:54.0676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWl+Mvs6EtNvWSaKWLxHnQiz+vumW4xkeDyvkK6YI2+Y6FjXl+j8FW1ETU/XK863DGKuBVv3I+H4J8U7FX/eNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgWGluaHVpLAoKCkNhbiB5b3UgcGxlYXNlIGNoZWNrIGlmIHlvdSBjYW4gcmVwcm9kdWNlIHRo
ZSBjcmFzaCB3aXRoIApodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9hcmNoaXZlcy9hbWQt
Z2Z4LzIwMjAtRmVicnVhcnkvMDQ2NDE0Lmh0bWwKCkNocmlzdGlhbiBmaXggaXQgZWFybGllciwg
SSB0aGluayBoZSBmb3Jnb3QgdG8gcHVzaCBpdC4KCgpSZWdhcmRzLAoKTmlybW95CgpPbiAzLzI1
LzIwIDEyOjA3IFBNLCB4aW5odWkgcGFuIHdyb3RlOgo+IGdwdSByZWNvdmVyIHdpbGwgY2FsbCBz
ZG1hIHN1c3BlbmQvcmVzdW1lLiBJbiB0aGlzIHBlcmlvZCwgcmluZyB3aWxsIGJlCj4gZGlzYWJs
ZWQuIFNvIHRoZSB2bV9wdGVfc2NoZWRzKHNkbWEuaW5zdGFuY2VbWF0ucmluZy5zY2hlZCktPnJl
YWR5IHdpbGwKPiBiZSBmYWxzZS4KPgo+IElmIHdlIHN1Ym1pdCBhbnkgam9icyBpbiB0aGlzIHJp
bmctZGlzYWJsZWQgcGVyaW9kLiBXZSBmYWlsIHRvIHBpY2sgdXAKPiBhIHJxIGZvciB2bSBlbnRp
dHkgYW5kIGVudGl0eS0+cnEgd2lsbCBzZXQgdG8gTlVMTC4KPiBhbWRncHVfdm1fc2RtYV9jb21t
aXQgZGlkIG5vdCBjaGVjayB0aGUgZW50aXR5LT5ycSwgc28gZml4IGl0LiBPdGhlcndpc2UKPiBo
aXQgcGFuaWMuCj4KPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6
IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6
IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMgfCAyICsrCj4gICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtX3NkbWEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bV9zZG1hLmMKPiBpbmRleCBjZjk2YzMzNWIyNTguLmQzMGQxMDNlNDhhMiAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYwo+IEBAIC05NSw2ICs5NSw4
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3NkbWFfY29tbWl0KHN0cnVjdCBhbWRncHVfdm1fdXBk
YXRlX3BhcmFtcyAqcCwKPiAgIAlpbnQgcjsKPiAgIAo+ICAgCWVudGl0eSA9IHAtPmRpcmVjdCA/
ICZwLT52bS0+ZGlyZWN0IDogJnAtPnZtLT5kZWxheWVkOwo+ICsJaWYgKCFlbnRpdHktPnJxKQo+
ICsJCXJldHVybiAtRU5PRU5UOwo+ICAgCXJpbmcgPSBjb250YWluZXJfb2YoZW50aXR5LT5ycS0+
c2NoZWQsIHN0cnVjdCBhbWRncHVfcmluZywgc2NoZWQpOwo+ICAgCj4gICAJV0FSTl9PTihpYi0+
bGVuZ3RoX2R3ID09IDApOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
