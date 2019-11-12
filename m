Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99D1C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93DE62184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DE62184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B1356EA33;
	Tue, 12 Nov 2019 00:34:11 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730067.outbound.protection.outlook.com [40.107.73.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B85A36EA3D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tnllrnwtx5F30wWCGMk3Vtcwp4EN+8AjbC80wB8n2t/dTU4A3ag1KJyVnNVRsF6EJ8+TeFrZms5/QjS/lhwtGgjZWmtqBHnLTvDMjxv8T/zhxCpeaa4dyV2uEC9KVyU3+hOlkQpUINE/3sVp6pGoQ1hDWXxkaD6+fIRrOc18C6yRPqgdj7WSbrq/XEsRoSbqAu5CzTXrRcbnRfGUgyQY4yz+fkIHCezLgRdQNPnNKRPIImx11OKziaNQu+wj0FOtwYTERv3XPEXs8IRucmRLA2z4AuGbVb21p7n6cwWGaZ2nnwDtdhkBXa+8eTJ1cq0j5d0TBBFhqhHMV8aO4heuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5rw1HVFC9WS0GASwZaia7n9IyNjgWjUPbYoTgJs/yg=;
 b=JpQcO+DQ6DSEyyE6NrBzTLh/IVjOR9+rKg1U2pe6veaI6no4NFuUAZ7Stvf5jvyjWWqciUyXg4W2uyxjQIX4XnlUVs4HtlwgQV4gujO3fKxBbcI+g8nOMyKP3KZleHcD0uM/DZqUdoNi4O/+D9rKOcnFvYFUqeTmRC8swAUAp23FyJgD+A4sULDflb3RaRHU0e14+MW9nFU2JOYJsDpzNnAIojVJxVRqAAU0Y3AsTCCRfxJldJ/2nIpOr0vwH6Z6WhuoN+84GfTspO564KLax7FcXbWdU940UfafLlHE85xpY48b77yWBVzJ4bNEw+NFXGFEBk+krvM6B4/eE4xccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:34:04 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:34:04 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/30] drm/amd/display: Spin for DMCUB PHY init in DC
Date: Mon, 11 Nov 2019 19:33:21 -0500
Message-Id: <20191112003324.8419-28-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
References: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ff57819-fdc3-4130-19ec-08d76708051e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2554893D694CD460E477C98A98770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(1496009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(14444005)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XzQZatlzwWd0yxFpwGQMPOZuxMJgcCBEEf2rKmnzU/9uTEh9QYUEEQl9ycmyuGWaCHLvsXQSpyk5vevhZkoD9n03VhAnzJCN4Qp1LQ+h9Fzqfig9bMKD41DQE+hj1rmzsLNCRO06DCZL7+MfsvHQPZdqAX94LO8kA9WFtHHcDkoW1ypbwmF/n+9sbXpGnJ8hXh7wcnP8q6QKpJMeupAZb2dJwqY8nn9YWz17XT5Ju4rr64mWJf5vx6DTgETwF3ELPZ9oas7SJXeEltgram2N7t5HLAhzCrOI5M/uqotzaXyPJ6xyO/S5vFpFbh417n6ii7c7nKW0JN7jxknYRk41CcV4gEEVKblJ5z8E5v96kQbz5lo3Kk56CQteuRv//MuKwpwe4HxYC99QogHgdRQpFEvS5XYaIxgyukfw49Tt5aLV4oJoB17hz8nGZXWxqVsh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff57819-fdc3-4130-19ec-08d76708051e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:34:04.1991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zW/A51fMU3hi5vx54VXWw5IzWi3dGJ3QcJ0jqTTnc6tlE1IM5ExLBKtrwtSRyijIOAbYslAX2w/NhRBc1cDGvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5rw1HVFC9WS0GASwZaia7n9IyNjgWjUPbYoTgJs/yg=;
 b=V0f9b9X60DLOlZkExzjxfK7hxfJpt3oeXYGcDcTjVAyfe+qNPKDun9rcfzUo2n639DEBQ/Gqg3oO7Qx98fbZBwQ7sK5aBP+gug637j3hthE/9TuDyX0NFMlZLyKDsNaKxKUvvPC1EgTTOhNP1h7ituMb70KVqtJ8hOSrZq4/I2I=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
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
Cc: Tony Cheng <Tony.Cheng@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003321.yOgHTSbNXyDqeHIEPo8nIjQBy8jVjGh7hXNXu7KaafE@z>

RnJvbTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgoK
W1doeV0KRENOIHdpbGwgaGFuZyBpZiB3ZSBhY2Nlc3MgcmVnaXN0ZXJzIGJlZm9yZSBQSFkgaW5p
dCBpcyBkb25lLgoKU28gd2UgbmVlZCB0byBzcGluIG9yIGFib3J0LgoKW0hvd10KT24gaGFyZHdh
cmUgd2l0aCBETUNVQiBydW5uaW5nIGFuZCB3b3JraW5nIHdlIHNob3VsZG4ndCB0aW1lIG91dAp3
YWl0aW5nIGZvciB0aGlzIHRvIGZpbmlzaCBhbmQgd2Ugc2hvdWxkbid0IGhpdCB0aGUgc3BpbiBj
eWNsZS4KCklmIHRoZXJlJ3Mgbm8gaGFyZHdhcmUgc3VwcG9ydCB0aGVuIHdlIHNob3VsZCBleGl0
IG91dCBvZiB0aGUgZnVuY3Rpb24KZWFybHkgYXNzdW1pbmcgdGhhdCBQSFkgaW5pdCB3YXMgYWxy
ZWFkeSBkb25lIGVsc2V3aGVyZS4KCklmIHdlIGhpdCB0aGUgdGltZW91dCB0aGVuIHRoZXJlJ3Mg
bGlrZWx5IGEgYnVnIGluIGZpcm13YXJlIG9yIHNvZnR3YXJlCmFuZCB3ZSBuZWVkIHRvIGRlYnVn
IC0gYWRkIGVycm9ycyBhbmQgYXNzZXJ0cyBhcyBhcHByb3ByaWF0ZS4KClNpZ25lZC1vZmYtYnk6
IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFzLmthemxhdXNrYXNAYW1kLmNvbT4KUmV2aWV3
ZWQtYnk6IFRvbnkgQ2hlbmcgPFRvbnkuQ2hlbmdAYW1kLmNvbT4KQWNrZWQtYnk6IFJvZHJpZ28g
U2lxdWVpcmEgPFJvZHJpZ28uU2lxdWVpcmFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNfZG11Yl9zcnYuYyB8IDIxICsrKysrKysrKysrKysrKystLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfZG11Yl9zcnYuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19kbXViX3Nydi5jCmluZGV4IDc0ZmZlNTNlYjQ5
ZC4uMDNlMjg0MmNiNTczIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNfZG11Yl9zcnYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNf
ZG11Yl9zcnYuYwpAQCAtMTEyLDEwICsxMTIsMjMgQEAgdm9pZCBkY19kbXViX3Nydl93YWl0X3Bo
eV9pbml0KHN0cnVjdCBkY19kbXViX3NydiAqZGNfZG11Yl9zcnYpCiAJc3RydWN0IGRjX2NvbnRl
eHQgKmRjX2N0eCA9IGRjX2RtdWJfc3J2LT5jdHg7CiAJZW51bSBkbXViX3N0YXR1cyBzdGF0dXM7
CiAKLQlzdGF0dXMgPSBkbXViX3Nydl93YWl0X2Zvcl9waHlfaW5pdChkbXViLCAxMDAwMDAwMCk7
Ci0JaWYgKHN0YXR1cyAhPSBETVVCX1NUQVRVU19PSykgewotCQlEQ19FUlJPUigiRXJyb3Igd2Fp
dGluZyBmb3IgRE1VQiBwaHkgaW5pdDogc3RhdHVzPSVkXG4iLAotCQkJIHN0YXR1cyk7CisJZm9y
ICg7OykgeworCQkvKiBXYWl0IHVwIHRvIGEgc2Vjb25kIGZvciBQSFkgaW5pdC4gKi8KKwkJc3Rh
dHVzID0gZG11Yl9zcnZfd2FpdF9mb3JfcGh5X2luaXQoZG11YiwgMTAwMDAwMCk7CisJCWlmIChz
dGF0dXMgPT0gRE1VQl9TVEFUVVNfT0spCisJCQkvKiBJbml0aWFsaXphdGlvbiBPSyAqLworCQkJ
YnJlYWs7CisKKwkJRENfRVJST1IoIkRNQ1VCIFBIWSBpbml0IGZhaWxlZDogc3RhdHVzPSVkXG4i
LCBzdGF0dXMpOwogCQlBU1NFUlQoMCk7CisKKwkJaWYgKHN0YXR1cyAhPSBETVVCX1NUQVRVU19U
SU1FT1VUKQorCQkJLyoKKwkJCSAqIFNlcnZlciBsaWtlbHkgaW5pdGlhbGl6ZWQgb3Igd2UgZG9u
J3QgaGF2ZQorCQkJICogRE1DVUIgSFcgc3VwcG9ydCAtIHRoaXMgd29uJ3QgZW5kLgorCQkJICov
CisJCQlicmVhazsKKworCQkvKiBDb250aW51ZSBzcGlubmluZyBzbyB3ZSBkb24ndCBoYW5nIHRo
ZSBBU0lDLiAqLwogCX0KIH0KLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
