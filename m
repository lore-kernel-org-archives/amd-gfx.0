Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82551C33CB6
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 15:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 579912072B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 15:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vXQbMekQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579912072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1311D6ED93;
	Thu, 16 Jan 2020 15:29:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF0D6ED93
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 15:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C41uS1gm9/MWioyyy0GjGIpUkXGHr2ZQfuru/ODR13fdmm8E9CS/0uuRiYNO2fJNAXkN5E2mMcG1yghECphiSifdbHit+nmK8VeVv/hOQWpQf1pnRNyZKNLM32jOwMooSV3xmdXG7RMgMEdJHpiWGnZZidGQ+S3YlhrC079p8XuWfaNlNZXx2+eeIzMA+s/qOzH48nFWCZ/vFMK+VD5YGf0NQzBOHkGoDotQMZDTXeVTANXXUFHkVeyfQU0rgSuyot+IFvbTTPTMyxp8JAEJ3SNFuW1AdNBiC1oYEgaghhIoc6145wPTdJb6WrIkl4aTUlKnCykoRFjWVMNGnpUAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXaCWVSPJ8QPOPiSihuJvfhmZWpzF9zb2fKsykMFu+E=;
 b=DelU/JJvWXtA2ybtEES82m7peLVUcvs+2vRdV3vPho/MSkYiJtS63GNpb+CBPieq1thgxen11u2tALfTA0kwI7ZG5a39MykL9jAqaAEEOIdxbpG7FXn5/nEloobMblpPJcu6uvq6+QK+bTzPwstSD7YDwyij0aBYaEV7wKMzRbocmgf0NRzeG668I97FUuGS2ZUVkncnyDFReDE068o1E570C2ZgHOZc2EmpkVO1LCK79B4QcWrzk8LzaovZdFyhQoZS7452IHq2KdJBupwQWQJ12lQWWhXb4hej1AvrLvUwjj2THc/wLsY0zW7KUqTyZRlqXlPmz0uPLMSFNQaUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXaCWVSPJ8QPOPiSihuJvfhmZWpzF9zb2fKsykMFu+E=;
 b=vXQbMekQu9yN0Zn/5rRaDV5Gkg/d0hSrRHJOhpe7kWsXBp5LbUyNH/ymYtkbdpZWtDSdrrgO3w51XPkoIJsx03QKOytQ0au/gh2r5RuicebWKzl6zpnXhXqC6ztzQTStG92gUEOA1n0AXe/8cIGzo+8h60wu8lS+khVxGWIsjzQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (10.255.237.223) by
 MN2PR12MB3197.namprd12.prod.outlook.com (20.179.83.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 16 Jan 2020 15:29:06 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::802e:382b:9d26:d2b9]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::802e:382b:9d26:d2b9%6]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 15:29:06 +0000
Subject: Re: [PATCH] drm/amdgpu: skip unallocated PDs/PTs while invalidating
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200116152822.2327-1-christian.koenig@amd.com>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <5502e4bf-c648-d17c-e314-856c8b23cd86@amd.com>
Date: Thu, 16 Jan 2020 10:29:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <20200116152822.2327-1-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: MN2PR12CA0002.namprd12.prod.outlook.com
 (2603:10b6:208:a8::15) To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.84.11) by
 MN2PR12CA0002.namprd12.prod.outlook.com (2603:10b6:208:a8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 15:29:04 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6b65655-4a8d-478b-9e79-08d79a98d1f6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3197:
X-Microsoft-Antispam-PRVS: <MN2PR12MB31975D07F6F45B3F331FDBD6F7360@MN2PR12MB3197.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 02843AA9E0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(199004)(189003)(16526019)(8936002)(8676002)(5660300002)(2616005)(6506007)(81166006)(2906002)(186003)(26005)(52116002)(53546011)(956004)(81156014)(36756003)(6512007)(66574012)(31686004)(66476007)(66556008)(6486002)(316002)(31696002)(478600001)(66946007)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3197;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7v4Lw7XDd63IuPRjLjzwd/FZq6mWCDbpHMslzPfvSCluZ2mi691wOiD1NgymbFvs5fg5TKgidn/WxcuIabCrcfTufzFKCRIKFGUoSwHYAQXMN73h1K2StvZeLXYu7d7rJxlrkYxegU1ko0Czqt8Ka9J0oLw+n49fRGgp6BbhuSyXIALCW1hsBl+MTzbYzHabWq06r5X4x/QCK14FvQmKk0bX426DYuAdRwxf/STvQJdXWhV4B6/6+JV21cRglfKeIcvgo5XcLOxIyy0dizzbnKvP8ZOF0Ve6FblYZrRslNipK9S/iptdaYU4nRD6phqlr/ComOBe1uyxKuEcNXam45vW0iPMKIuZfd+6xcLi7KjrGkfr2ROT2GsSbXXEMHzqLoSrL3+V7RvHtcBVavfDslFyrzAoU2uKD5CA24NfuonT/FNEQokwm2VrdtMd75v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b65655-4a8d-478b-9e79-08d79a98d1f6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 15:29:06.2291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HkHGzoxO7Q50vvW+oFyvbE/QYM6z5doqTUBMKdWhX1C15aY7M9LSBeQIkmWAPykl53oesSA6VHpR5AuiMX1kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3197
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

SSdsbCB0ZXN0IGl0IG91dCBpbiBhIG1pbnV0ZS4KCgpUb20KCk9uIDIwMjAtMDEtMTYgMTA6Mjgg
YS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBXZSBkb24ndCBuZWVkIHRvIHJldHVybiBh
biBlcnJvciBpbiB0aGlzIGNhc2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gRml4ZXM6IGQ2OTMyYTRkODZlNCBkcm0vYW1k
Z3B1OiBtYWtlIHN1cmUgdG8gbmV2ZXIgYWxsb2NhdGUgUERzL1BUcyBmb3IgaW52YWxpZGF0aW9u
cwo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCA4ICsr
KysrKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCA1Y2IxODIy
MzFmNWQuLjZjZjQwN2FhYjI3OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5jCj4gQEAgLTE0NjcsOCArMTQ2NywxMiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRh
dGVfcHRlcyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywKPiAgIAkJCSAq
IHNtYWxsZXIgdGhhbiB0aGUgYWRkcmVzcyBzaGlmdC4gR28gdG8gdGhlIG5leHQKPiAgIAkJCSAq
IGNoaWxkIGVudHJ5IGFuZCB0cnkgYWdhaW4uCj4gICAJCQkgKi8KPiAtCQkJaWYgKCFhbWRncHVf
dm1fcHRfZGVzY2VuZGFudChhZGV2LCAmY3Vyc29yKSkKPiAtCQkJCXJldHVybiAtRU5PRU5UOwo+
ICsJCQlpZiAoIWFtZGdwdV92bV9wdF9kZXNjZW5kYW50KGFkZXYsICZjdXJzb3IpKSB7Cj4gKwkJ
CQlpZiAoZmxhZ3MgJiBBTURHUFVfUFRFX1ZBTElEKQo+ICsJCQkJCXJldHVybiAtRU5PRU5UOwo+
ICsJCQkJZWxzZQo+ICsJCQkJCWFtZGdwdV92bV9wdF9uZXh0KGFkZXYsICZjdXJzb3IpOwo+ICsJ
CQl9Cj4gICAJCQljb250aW51ZTsKPiAgIAkJfSBlbHNlIGlmIChmcmFnID49IHBhcmVudF9zaGlm
dCkgewo+ICAgCQkJLyogSWYgdGhlIGZyYWdtZW50IHNpemUgaXMgZXZlbiBsYXJnZXIgdGhhbiB0
aGUgcGFyZW50Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
