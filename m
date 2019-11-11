Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C178C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 18:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE5B206C3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 18:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE5B206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FA7F6E9B5;
	Mon, 11 Nov 2019 18:03:55 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800084.outbound.protection.outlook.com [40.107.80.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 437336E9B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 18:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhR+jF01CXJ7mdR8QKkUQTb1WQbd4bo5pY2IWETrGwVncAAIiqN3ga7W9U9NNe9FaSuk72Yo+VuhxSktm+aci0qw7cpaxMfkTFFAhMxtZR8aDp/EBeujvcgPIsmf/mSDWopxYrIdwJvqrnht1Xh0kQky3W7SyZTP8Q16g4s54oFPIEY5fdVBpFsFudW3df20qKLDme8F+o/KR/+2i1YHTBJ11luJRPChYYMRbcSG3I3+fAnu3BnM9+8gmoCnqbBxUQPvXmiT8B6qt3mKbXvh6gC4JIOAxwQggqOIFi5bm061VR6dTgbmVaHL/XHjMBQIKjbDmBzeOZSfj7G42cQXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6LxIiN/IV+M3bBYjEbNbyisaVNWGu2yCysvxVChOuA=;
 b=B+axvEQP+E1SnO1QhblKOs2bZ6VXp0DaFo8Bwleva/GxkgWjd/MTbM6PD5eznKMXGAo0vwaibUJm+FAg9xSmOZ9U6hbALoZU1UBjAefjL/h8ucInK+TTqgDAhsVrYshTrGdcMpGEjmyeAon5C176jJcBMYn8jEVG927AN8sJ2zf+rN3ZlMZlebrWQKd9JjUtICkz9gXXf3R0p57A7KW2vm22K3WSIUp1HHF7WHa2F1PCezadySanbowDzI/yj1fgdSHgelRXRj/BJIJ27ymHDt9VseM3sddTGmTd8PaDe2TnycJEMnZK31QbEvpHZGC2a6H6bsq9YhbDjolVk9nXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3611.namprd12.prod.outlook.com (20.178.199.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Mon, 11 Nov 2019 18:03:52 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 18:03:52 +0000
Subject: Re: [PATCH] drm/amdkfd: Rename create_cp_queue() to init_user_queue()
To: "Zhao, Yong" <Yong.Zhao@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20191101201216.6205-1-Yong.Zhao@amd.com>
From: Yong Zhao <yong.zhao@amd.com>
Message-ID: <021b5a52-5559-4c8f-3127-b7590caf372a@amd.com>
Date: Mon, 11 Nov 2019 13:03:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191101201216.6205-1-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::35) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cd987bfe-0627-4427-20b8-08d766d182c9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3611:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB361105C32C67C24AF5F2E43EF0740@DM6PR12MB3611.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(189003)(199004)(2616005)(476003)(6512007)(11346002)(446003)(47776003)(65956001)(66066001)(65806001)(66476007)(66556008)(50466002)(6506007)(53546011)(6486002)(386003)(2486003)(23676004)(52116002)(76176011)(66946007)(5660300002)(186003)(230700001)(229853002)(110136005)(316002)(6116002)(6436002)(3846002)(99286004)(25786009)(31686004)(58126008)(478600001)(8936002)(14454004)(36756003)(6246003)(31696002)(44832011)(2906002)(8676002)(7736002)(305945005)(486006)(81156014)(81166006)(26005)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3611;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHGQttEn9cJGQQMqqwt0B99y27eDmN2iUiiH83uTBYsx/RdzPwNe8sywAzOasEaORkT4hbUbbzW1xUcHGwCseQ5BwR/y3XCTYMK2Kh2X+N/UwMIPLsYYoApKGQYz9nDP9M4cd7BlcZNvX9ByteZAcD9aJlf1MeiKBbT0Vhceo0QMnYKXSZ9KYRCtgd9F7WWbmXKIn5ygjBppu3bdH7WFJs/NrsVCiMrkiy18vPTlM9PHqyZNLLtNs7ewdAEnSMHPKLANkI6gqh0SKWTxLJUBACIOIxOJS2ZyNEQanAafHDwib+57x0tct6FxljgZl5CjB2swPb7SxOy0EPOqRDFEDZt2Gc/jAnOBCiAqtK/qWa7Iadf6CzLhYXtUYUmiy45SYa0wuAb15XzWCfnUKx3I21cdEQoY8CoSAJHh7Zi0dwZZgqgJEWxQ64AfgmfByil0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd987bfe-0627-4427-20b8-08d766d182c9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 18:03:52.7979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/vyuiz1e0qIsdGYuxwzgj9wELpTuxwX1XSthnMPZ4pV94z9rgpwjgliHiBKcdiQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3611
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6LxIiN/IV+M3bBYjEbNbyisaVNWGu2yCysvxVChOuA=;
 b=nTh+lLK2U9CRlU22yb6eFmMDLouKrv0ZERZPz2E9hthmfRIVV5qgyX1ckIsSIPlOMeaRQem8ZlX/toGS7g4gTyWlnfQiqDSlXG4qtGd6s4wZVUDCgRBMpT5HVss/+rtemr7/V5J6XoVFOI5y5SBn0wNza3PwpHT2OP03n10ozx8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Message-ID: <20191111180351.KPC5zttgEUAPDIToHjoNT9lxs6dsOGVWM4SeNO8_vXg@z>

cGluZwoKT24gMjAxOS0xMS0wMSA0OjEyIHAubS4sIFpoYW8sIFlvbmcgd3JvdGU6Cj4gY3JlYXRl
X2NwX3F1ZXVlKCkgY291bGQgYWxzbyB3b3JrIHdpdGggU0RNQSBxdWV1ZXMsIHNvIHdlIHNob3Vs
ZCByZW5hbWUKPiBpdC4KPgo+IENoYW5nZS1JZDogSTc2Y2JhZWQ4ZmE5NWRkOTA2MmQ3ODZjYmMx
ZGQwMzdmZjA0MWRhOWQKPiBTaWduZWQtb2ZmLWJ5OiBZb25nIFpoYW8gPFlvbmcuWmhhb0BhbWQu
Y29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVl
dWVfbWFuYWdlci5jIHwgNiArKystLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5jCj4gaW5kZXggNDgxODVkMjk1N2U5Li5l
YmIyZjY5YjQzOGMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3Byb2Nlc3NfcXVldWVfbWFuYWdlci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5jCj4gQEAgLTE2Miw3ICsxNjIsNyBAQCB2b2lk
IHBxbV91bmluaXQoc3RydWN0IHByb2Nlc3NfcXVldWVfbWFuYWdlciAqcHFtKQo+ICAgCXBxbS0+
cXVldWVfc2xvdF9iaXRtYXAgPSBOVUxMOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBpbnQgY3JlYXRl
X2NwX3F1ZXVlKHN0cnVjdCBwcm9jZXNzX3F1ZXVlX21hbmFnZXIgKnBxbSwKPiArc3RhdGljIGlu
dCBpbml0X3VzZXJfcXVldWUoc3RydWN0IHByb2Nlc3NfcXVldWVfbWFuYWdlciAqcHFtLAo+ICAg
CQkJCXN0cnVjdCBrZmRfZGV2ICpkZXYsIHN0cnVjdCBxdWV1ZSAqKnEsCj4gICAJCQkJc3RydWN0
IHF1ZXVlX3Byb3BlcnRpZXMgKnFfcHJvcGVydGllcywKPiAgIAkJCQlzdHJ1Y3QgZmlsZSAqZiwg
dW5zaWduZWQgaW50IHFpZCkKPiBAQCAtMjUxLDcgKzI1MSw3IEBAIGludCBwcW1fY3JlYXRlX3F1
ZXVlKHN0cnVjdCBwcm9jZXNzX3F1ZXVlX21hbmFnZXIgKnBxbSwKPiAgIAkJCWdvdG8gZXJyX2Ny
ZWF0ZV9xdWV1ZTsKPiAgIAkJfQo+ICAgCj4gLQkJcmV0dmFsID0gY3JlYXRlX2NwX3F1ZXVlKHBx
bSwgZGV2LCAmcSwgcHJvcGVydGllcywgZiwgKnFpZCk7Cj4gKwkJcmV0dmFsID0gaW5pdF91c2Vy
X3F1ZXVlKHBxbSwgZGV2LCAmcSwgcHJvcGVydGllcywgZiwgKnFpZCk7Cj4gICAJCWlmIChyZXR2
YWwgIT0gMCkKPiAgIAkJCWdvdG8gZXJyX2NyZWF0ZV9xdWV1ZTsKPiAgIAkJcHFuLT5xID0gcTsK
PiBAQCAtMjcyLDcgKzI3Miw3IEBAIGludCBwcW1fY3JlYXRlX3F1ZXVlKHN0cnVjdCBwcm9jZXNz
X3F1ZXVlX21hbmFnZXIgKnBxbSwKPiAgIAkJCWdvdG8gZXJyX2NyZWF0ZV9xdWV1ZTsKPiAgIAkJ
fQo+ICAgCj4gLQkJcmV0dmFsID0gY3JlYXRlX2NwX3F1ZXVlKHBxbSwgZGV2LCAmcSwgcHJvcGVy
dGllcywgZiwgKnFpZCk7Cj4gKwkJcmV0dmFsID0gaW5pdF91c2VyX3F1ZXVlKHBxbSwgZGV2LCAm
cSwgcHJvcGVydGllcywgZiwgKnFpZCk7Cj4gICAJCWlmIChyZXR2YWwgIT0gMCkKPiAgIAkJCWdv
dG8gZXJyX2NyZWF0ZV9xdWV1ZTsKPiAgIAkJcHFuLT5xID0gcTsKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
