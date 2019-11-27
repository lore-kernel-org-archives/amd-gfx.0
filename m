Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05C8C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E78F2070A
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E78F2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AE176E4E8;
	Wed, 27 Nov 2019 09:15:56 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770070.outbound.protection.outlook.com [40.107.77.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D4C6E4E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 09:15:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwSPZ5mLsVlLMWjL2iffE8Tup2bPPvEvBgkjAJfaC65gzF15VIEzf+BMy3yRLa34k/hb4pJu/0f6egiyXheWWdTgXJ4da0JVW2psnPtuDzRls6XfxlXFGfiqxyHU/zQZSaNDqduFMbi3ohKTGVvFuHq0DENaukku8eLe5Yg7eo7Uz7rRvOLmYkCqRyhzkE66kV8Rsba83aj74M/4m1Sg7BChQd6oTZ08t85un2p4Er2sIDwBnGtjOC5thdCzoAmAYGTKN7ochiRulj9BcE9SBG0tQXxmSGDPO+nAhL4lcjw0r6BybVfib3yCgRCLmePRVMkPqH1wsAvz1WtiTYmTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWJgP45BVndeH9RbKhoMVzdYHgIxemyU91BkQIJST3I=;
 b=BNtT+VULau1Z53L+17VoMQfCfbKyUMrxgClOg+FrNpT88ZgnBjbRW90APFDMTlKylFoUfqOkGdnelwOLpwnz/hEnC4IIMmE6h2J6OfyDLW+Wfp7oItgcalu4r3KXBU5CJwaYBEYuLPpbEe71LCPourguNkMI/v96qoipjUfDgmaRaG9J1WauJsAwCFBQUmOQwHG2ltiiflAT6QXa/PXhmL7QM7/jytvvRSwSojAgxmPcHMKFp8AqUVDROARvRUkT0m2RTl2hr2MRKi/Cjeqq5j0JtDCwE3zZAVDh/99oV6DOfvrcPjzUicevcHcKRss8wdVNZVHOsmjOQzRm90Yffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from SN1PR12CA0062.namprd12.prod.outlook.com (2603:10b6:802:20::33)
 by DM5PR12MB1499.namprd12.prod.outlook.com (2603:10b6:4:8::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 27 Nov 2019 09:15:50 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::204) by SN1PR12CA0062.outlook.office365.com
 (2603:10b6:802:20::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2495.17 via Frontend
 Transport; Wed, 27 Nov 2019 09:15:49 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 27 Nov 2019 09:15:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 03:15:45 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 03:15:45 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 27 Nov 2019 03:15:42 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/10] drm/amdgpu: enable/disable doorbell interrupt in baco
 entry/exit helper
Date: Wed, 27 Nov 2019 17:15:24 +0800
Message-ID: <1574846129-4826-4-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574846129-4826-1-git-send-email-le.ma@amd.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(428003)(199004)(189003)(2351001)(50466002)(26005)(446003)(186003)(48376002)(16586007)(316002)(47776003)(5660300002)(305945005)(11346002)(44832011)(51416003)(81156014)(2616005)(86362001)(70586007)(70206006)(336012)(76176011)(6916009)(356004)(2906002)(54906003)(36756003)(4326008)(81166006)(8676002)(426003)(8936002)(6666004)(478600001)(50226002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1499; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eabb41d0-7364-446f-3467-08d7731a64f6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1499:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14999C11BBC1696DC2E7ACE7F6440@DM5PR12MB1499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 023495660C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTEeRmxS2eqDBjYjhY0bsZl+mvEgHmXi/BI9gCYa10/XUAQCl+Vo/EsL47xAHF3MnnJoxvGZixS5u0urUmWrnEuZ/PTzK3GC42YlTxlm+lwVMcOOqOt+jwVVkckCkRb7rFD0cxjo3tuVPOW7OQHYEC6P1IzFUpKkSraemEctsm2RZacTnQy8drgi5K2II41qbu2MAtdwQWY8IIOEmLC0VKhvNyMKAV3XUGr0BzEdd8LVY8iVlMAPx0lF7SpDz+UYxmHDNhv8XQuQq8iShUSHHmX/wFntB1zD726fF/7rCRxOTp7k8LZbO8TE64AHXuAfwzYljWxBSvbeaSIJb4m7f7uDFTihTSscTLLbN1xh8R1YZ8djA9WTLI2nuaVlrq70y5aFtK/2VBp/uIwJuLKMwbEIe+v10Qkfxw9Yt1EM5e81LhdRbnHk5ean2GKHc4+n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 09:15:49.5104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eabb41d0-7364-446f-3467-08d7731a64f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1499
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWJgP45BVndeH9RbKhoMVzdYHgIxemyU91BkQIJST3I=;
 b=vN1gS5lQNuHMs+9OA6yXaIS+UI617IXmdk+xX0J5DSSG8M8S67UaGqkqBmY5Dx3L3Jp5VSXuGowypMxWFd3GEgRDKHL/QD5rjyu6jXEZIaZCKv3VslbziYpidPCPQkF/otOCr3ElicNLZndk2UjlfZzGdHA31gCLid0i1fWVbcc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
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
Cc: guchun.chen@amd.com, tao.zhou1@amd.com, Le Ma <le.ma@amd.com>,
 alexander.deucher@amd.com, dennis.li@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127091524.pkYJq2ABSenWFyLgFeObRgB0HBsWFhzBnwRl88tAoe8@z>

VGhpcyBvcGVyYXRpb24gaXMgbmVlZGVkIHdoZW4gYmFjbyBlbnRyeS9leGl0IGZvciByYXMgcmVj
b3ZlcnkKCkNoYW5nZS1JZDogSTUzNWM3MjMxNjkzZjMxMzhhOGUzZDVhY2Q1NTY3MmUyYWM2ODIz
MmYKU2lnbmVkLW9mZi1ieTogTGUgTWEgPGxlLm1hQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMTkgKysrKysrKysrKysrLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCmluZGV4IGIxNDA4YzUuLmJkMzg3
YmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTQz
MDgsMTAgKzQzMDgsMTQgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2RldmljZV9nZXRfcGNpZV9pbmZv
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogaW50IGFtZGdwdV9kZXZpY2VfYmFjb19lbnRl
cihzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQogewogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gZGV2LT5kZXZfcHJpdmF0ZTsKKwlzdHJ1Y3QgYW1kZ3B1X3JhcyAqcmFzID0gYW1kZ3B1X3Jh
c19nZXRfY29udGV4dChhZGV2KTsKIAogCWlmICghYW1kZ3B1X2RldmljZV9zdXBwb3J0c19iYWNv
KGFkZXYtPmRkZXYpKQogCQlyZXR1cm4gLUVOT1RTVVBQOwogCisJaWYgKHJhcyAmJiByYXMtPnN1
cHBvcnRlZCkKKwkJYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxsX2ludGVycnVwdChh
ZGV2LCBmYWxzZSk7CisKIAlpZiAoaXNfc3VwcG9ydF9zd19zbXUoYWRldikpIHsKIAkJc3RydWN0
IHNtdV9jb250ZXh0ICpzbXUgPSAmYWRldi0+c211OwogCQlpbnQgcmV0OwpAQCAtNDMxOSw4ICs0
MzIzLDYgQEAgaW50IGFtZGdwdV9kZXZpY2VfYmFjb19lbnRlcihzdHJ1Y3QgZHJtX2RldmljZSAq
ZGV2KQogCQlyZXQgPSBzbXVfYmFjb19lbnRlcihzbXUpOwogCQlpZiAocmV0KQogCQkJcmV0dXJu
IHJldDsKLQotCQlyZXR1cm4gMDsKIAl9IGVsc2UgewogCQl2b2lkICpwcF9oYW5kbGUgPSBhZGV2
LT5wb3dlcnBsYXkucHBfaGFuZGxlOwogCQljb25zdCBzdHJ1Y3QgYW1kX3BtX2Z1bmNzICpwcF9m
dW5jcyA9IGFkZXYtPnBvd2VycGxheS5wcF9mdW5jczsKQEAgLTQzMzEsMTQgKzQzMzMsMTUgQEAg
aW50IGFtZGdwdV9kZXZpY2VfYmFjb19lbnRlcihzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQogCQkv
KiBlbnRlciBCQUNPIHN0YXRlICovCiAJCWlmIChwcF9mdW5jcy0+c2V0X2FzaWNfYmFjb19zdGF0
ZShwcF9oYW5kbGUsIDEpKQogCQkJcmV0dXJuIC1FSU87Ci0KLQkJcmV0dXJuIDA7CiAJfQorCisJ
cmV0dXJuIDA7CiB9CiAKIGludCBhbWRncHVfZGV2aWNlX2JhY29fZXhpdChzdHJ1Y3QgZHJtX2Rl
dmljZSAqZGV2KQogewogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gZGV2LT5kZXZfcHJp
dmF0ZTsKKwlzdHJ1Y3QgYW1kZ3B1X3JhcyAqcmFzID0gYW1kZ3B1X3Jhc19nZXRfY29udGV4dChh
ZGV2KTsKIAogCWlmICghYW1kZ3B1X2RldmljZV9zdXBwb3J0c19iYWNvKGFkZXYtPmRkZXYpKQog
CQlyZXR1cm4gLUVOT1RTVVBQOwpAQCAtNDM1MSw3ICs0MzU0LDYgQEAgaW50IGFtZGdwdV9kZXZp
Y2VfYmFjb19leGl0KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYpCiAJCWlmIChyZXQpCiAJCQlyZXR1
cm4gcmV0OwogCi0JCXJldHVybiAwOwogCX0gZWxzZSB7CiAJCXZvaWQgKnBwX2hhbmRsZSA9IGFk
ZXYtPnBvd2VycGxheS5wcF9oYW5kbGU7CiAJCWNvbnN0IHN0cnVjdCBhbWRfcG1fZnVuY3MgKnBw
X2Z1bmNzID0gYWRldi0+cG93ZXJwbGF5LnBwX2Z1bmNzOwpAQCAtNDM2Miw3ICs0MzY0LDEwIEBA
IGludCBhbWRncHVfZGV2aWNlX2JhY29fZXhpdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQogCQkv
KiBleGl0IEJBQ08gc3RhdGUgKi8KIAkJaWYgKHBwX2Z1bmNzLT5zZXRfYXNpY19iYWNvX3N0YXRl
KHBwX2hhbmRsZSwgMCkpCiAJCQlyZXR1cm4gLUVJTzsKLQotCQlyZXR1cm4gMDsKIAl9CisKKwlp
ZiAocmFzICYmIHJhcy0+c3VwcG9ydGVkKQorCQlhZGV2LT5uYmlvLmZ1bmNzLT5lbmFibGVfZG9v
cmJlbGxfaW50ZXJydXB0KGFkZXYsIGZhbHNlKTsKKworCXJldHVybiAwOwogfQotLSAKMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
