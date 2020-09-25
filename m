Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A61AC4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 19:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16F62344C
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 19:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="o+D3yLOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16F62344C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 202B56E0D1;
	Fri, 25 Sep 2020 19:27:37 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690043.outbound.protection.outlook.com [40.107.69.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 403B56E0D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 19:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBqzsFVUg39hXVHWosm5OQ19Ta8/59NGjGmgB+hRT0vJ2yffMAoTMFMlctZn4g8PWF9x9xklqtAVOFW9xbXh9qCHPLnLOqUi+jqYzhSX/tBxBsgtiNUjZPy8eeao9hgGF5GNR6O1tFebaa50Yf1SXJEn+T7AfF7SAAU6Xwe+wubCjMKSFVND7iDs2zhXgpVPDl4nDf+YpL9l1ToN/X4OBBlvR4oo7D72OZbOZhY8paJpRTHFFzkg+yz7v0Qgs+PWSIfe1Dw9S/SQNAFmYftaj+TghrfL+Lkqmr6EegoNyldLlbhydC//4fH2p2CdNOSHXeKo4SvwMwHtDhVxVMKb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFENlmg1bnywVP/cmpVbZklLwbeDUy6mlyhP35+Noiw=;
 b=asbhu5X88xCb4U8XB6tLoxRxZ90g2XfSDmmuFFskNTmN53Xz6RlfONEYQl8B8iQMjQ7b+0XxplV8ZuUNRrZOHkkWabGIQbkGzokZMvVLAmvCHjybrpDU0TYec3zFjZWzCmdnQFnSzXtuS0AASKDHZRP+VIoPvHDettk/kFwzs22vu9B9ONEDswsJXaehtd7ZR80lPecxVmj/q1EpZ7EnA2MoW19mpYQc7S3OTY3j/tQnukr1tJYe0G3Pl0G9wi+8dLanGAQJcXZB6tGAxZPgnpOGY/9hyPufbHj/NIspUahHt0VfQV0eeuLObXkf0P2BWRCyt7UhwevyD+bTOFmrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFENlmg1bnywVP/cmpVbZklLwbeDUy6mlyhP35+Noiw=;
 b=o+D3yLOP/65EBI9wCmscaBIrr3lA3LOGXWFV0+LIw1zfWPfA1FaTDS7RQm1svb6jqj8tKHQM7pR7pbu2k4D53nTlftX4h4z9jtgxGOx0YHJwg2IbK/DAplJTWDskSJzeteK7b4Sww3eBk1sBq5pBf0cAJPpCJc/IOqNniNoEg8Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Fri, 25 Sep
 2020 19:27:35 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3412.025; Fri, 25 Sep 2020
 19:27:35 +0000
Subject: Re: [PATCH] drm/amdgpu: fix a warning in amdgpu_ras.c (v2)
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200925192357.1635290-1-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <b4b3418a-5589-47d0-c9a6-7e1e1dfbd73d@amd.com>
Date: Fri, 25 Sep 2020 15:27:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200925192357.1635290-1-alexander.deucher@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::15) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 19:27:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 337301f0-5ff0-409f-bfb3-08d861890e0f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4926:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4926DE37032852387DBA4B6399360@DM6PR12MB4926.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RApNQD/qqiKffgmSug0OCvWbDIiAV+aVvrDGDpKKZtoGPH3t1jiecTOkgLl5zY29wFMYg65ZiPmGFBUNokUkx4awX3/Mb2FTCJyZuJUC1JD45/sXf66f+Cxt2kcCZTeT/ugk0ON8rAZKvdh6xwZNNP3uckoCOxI0bjPgIEz217Regwbkj+DtZsbI+Q7Itbgj2Q7qC9M3P3nIQqlbIsrcz2kHhfAMIwSsLqv1xS+YNiXp4A2neRA+k0NMAn8D9fxj8tPUoWfCE7zVGvxFACyO5Sdy1GyRfbigckkrtaSFRFg3/eKosm8CtOfyDgHpBGTmsPoI/vXHuyemRCdnFkNFKOHQbiiiDP+d7bIPVxpW4E9OZ/hvFNj568pSvYPCHL3t7gIG3MVuPBMVPCeQeeJ4U3aaOJkf0D0gsBNSxWDOZIszapF+Jc+TtG3/5GHrVKww
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(4326008)(26005)(16526019)(186003)(52116002)(86362001)(8936002)(31686004)(83380400001)(8676002)(31696002)(53546011)(478600001)(66556008)(66476007)(5660300002)(6486002)(16576012)(44832011)(316002)(956004)(2616005)(36756003)(2906002)(6666004)(66946007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HQXfDQyiS5ahGWyPYHT3OwKbwvFhbozhasb+RPkQ609nqo6dK9i6mEzLVDb3KJq8b07vd2oAUPBoPBt4tu+T5P4M0/fpFxxuVLzqEP2cOdHZmf3tv7cB7R3liwbDR59vvmUUef7++3lKLfSU+fLFouwRg0ystugQjAkHxj3Gq2OIuio5pkE7iRSMC1yxdGmWkKzFX5SEiSyuDEas4NoctawoDRRNi/sgtVryymymE6X8Je2cBZNLVpjCLrrxFG/LN5uqG6MGZUfgqZCoVqQXdL9aBAzwRzGuo2KUZ1+2QznrgaDv0x/YUrqOGwjFUz11/0moYJOZdUKlukj49lgaqAcDGu1nM35cW61eXSXzb3RvbX3ZbpXy4wiaOROlTl3m9V+A0jn2p/9/OvYaGVGyHF6Y3SG4VFibSkxWbSc2fkkG+M1AK6lbnHDYKg3U6p+KpAz7frd7RnmTQKN9FG2TUl3DgS7j589xQd5IOJPGQa0K4I/DI7eOKhyHyDcRStxmMWnbaJVGhGKQZzqntHnKx6WUTlD+TWC0psZC/NVogPD+7DMgqFOxDR1g0tKNIBfC5lQogp+OdZquK9kQmEA8ibam1kjbIWFwdou+hdE3Skc79X5elVVBOmRkc2xD6Df2u81KEWw9hVcOGPEfxITvVg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337301f0-5ff0-409f-bfb3-08d861890e0f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 19:27:34.9910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWZOemtMxhJ2iwi8R2BmJIDD4SrepubRzYb7ywY7FTH8gMLkAAjF6g+CWJTn9lnM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4926
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEx1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+CgpUaGF0J3Mg
d2hhdCBJIGhhZCBpbiBtaW5kLiBObyBlcnJvci0tbGV0IHRoZSBzeXN0ZW0gc3Vydml2ZSBhcyBt
dWNoIGFzIGl0IGNhbi4KClJlZ2FyZHMsCkx1YmVuCgpPbiAyMDIwLTA5LTI1IDE1OjIzLCBBbGV4
IERldWNoZXIgd3JvdGU6Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5j
OiBJbiBmdW5jdGlvbiDigJhhbWRncHVfcmFzX2ZzX2luaXTigJk6Cj4gZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jOjEyODQ6Mjogd2FybmluZzogaWdub3JpbmcgcmV0dXJu
IHZhbHVlIG9mIOKAmHN5c2ZzX2NyZWF0ZV9ncm91cOKAmSwgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1
dGUgd2Fybl91bnVzZWRfcmVzdWx0IFstV3VudXNlZC1yZXN1bHRdCj4gIDEyODQgfCAgc3lzZnNf
Y3JlYXRlX2dyb3VwKCZhZGV2LT5kZXYtPmtvYmosICZncm91cCk7Cj4gICAgICAgfCAgXn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPiAKPiB2MjoganVzdCBwcmlu
dCBhbiBlcnJvciBmb3Igc3lzZnMgZ3JvdXAgY3JlYXRpb24gZmFpbHVyZQo+IAo+IFNpZ25lZC1v
ZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiAtLS0KPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgNSArKysrLQo+ICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+IGluZGV4IDQ5ZDEwMzMwYmY2NC4uOGJmNmE3
YzA1NmJjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+IEBA
IC0xMjY2LDYgKzEyNjYsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9yYXNfZnNfaW5pdChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKPiAgCQlOVUxMLAo+ICAJCU5VTEwsCj4gIAl9Owo+ICsJaW50
IHI7Cj4gIAo+ICAJLyogYWRkIGZlYXR1cmVzIGVudHJ5ICovCj4gIAljb24tPmZlYXR1cmVzX2F0
dHIgPSBkZXZfYXR0cl9mZWF0dXJlczsKPiBAQCAtMTI4MSw3ICsxMjgyLDkgQEAgc3RhdGljIGlu
dCBhbWRncHVfcmFzX2ZzX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gIAkJc3lz
ZnNfYmluX2F0dHJfaW5pdChiaW5fYXR0cnNbMF0pOwo+ICAJfQo+ICAKPiAtCXN5c2ZzX2NyZWF0
ZV9ncm91cCgmYWRldi0+ZGV2LT5rb2JqLCAmZ3JvdXApOwo+ICsJciA9IHN5c2ZzX2NyZWF0ZV9n
cm91cCgmYWRldi0+ZGV2LT5rb2JqLCAmZ3JvdXApOwo+ICsJaWYgKHIpCj4gKwkJZGV2X2Vycihh
ZGV2LT5kZXYsICJGYWlsZWQgdG8gY3JlYXRlIFJBUyBzeXNmcyBncm91cCEiKTsKPiAgCj4gIAly
ZXR1cm4gMDsKPiAgfQo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
