Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986F8C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 13:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684EC20678
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 13:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684EC20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5EE6E0FB;
	Wed, 27 Nov 2019 13:55:37 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720056.outbound.protection.outlook.com [40.107.72.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BA038936C
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 13:55:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L22aeAHugyeO2TOp82iaoCQtr8RX0kPq23TB1drepxq5CfslrK02RH63FcecQHDhyrL8yeXJhq3/XwUsorVh3SL+7y8CyNpgQhNZOtml36wctWpbINM+JLfugFeBX7E1T7zB+f142ZfoClnbJO91PMS8tjk1XdlweUoTZFxrcwGzOdAVt61cu1elr2a1wDOiZo2bCJi34PcTg6gMeUDlUVrUWf7TPlw6bcR7Muu+VOx6Hx7Q7WB/FlcmuZitxXYMPlir6YdA3MKQemz1LTgOWfW2BJzpC+FbjR1qZuvfnbJY47/S+OT9cTeN/hX9hExNPB+Cm/n8mPDFORg2Hh89jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsYg9pCCditIGDNfygopbIM5BxEI05gtn0ZLtly5AMg=;
 b=htIc04qbvNik5kvy9c0Kis8wnElUcAwddWUSqlD1IkcMRpI2qzzvWAzJhhrtLpX5oegtHDk0mGgooX4WFzuSXYPPTbC/m9QVIvcfPr/XMnfzDCg2OSN3fPebbsEPGBHx2brmRqa1lJD+eDfw4TF8gLoCvwTPzRLj7GVDQd5bwUtia1b6p8eFvP73Rt5HwwYmaUtqOqXubUbNx3BEDqb/G/s9x+vgBS4Ge/eofMGBlly7KRhdqxfJSpxxAtVgjLJePytTnMKjcLhH2cJFrYp7vTPR/Sj2X6Ab+ZJtqBBxGm1pc5m16Ozgi7Wumgq3Uapr/WKK0L5PAS0Z8YLFDHqRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0090.namprd12.prod.outlook.com (2603:10b6:0:57::34) by
 DM6PR12MB2955.namprd12.prod.outlook.com (2603:10b6:5:181::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 27 Nov 2019 13:55:33 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::203) by DM3PR12CA0090.outlook.office365.com
 (2603:10b6:0:57::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18 via Frontend
 Transport; Wed, 27 Nov 2019 13:55:32 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 27 Nov 2019 13:55:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 07:53:34 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 07:53:34 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 27 Nov 2019 07:53:33 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/10 v2] drm/amdgpu: add condition to enable baco for ras
 recovery
Date: Wed, 27 Nov 2019 21:53:29 +0800
Message-ID: <1574862809-27917-1-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(428003)(189003)(199004)(44832011)(2616005)(6666004)(16586007)(356004)(48376002)(50466002)(86362001)(336012)(36756003)(4326008)(6916009)(305945005)(426003)(316002)(47776003)(8936002)(2906002)(81156014)(81166006)(50226002)(5660300002)(186003)(51416003)(26005)(54906003)(70206006)(2351001)(70586007)(478600001)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2955; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbea4c66-11d9-4fbf-a6d1-08d773417842
X-MS-TrafficTypeDiagnostic: DM6PR12MB2955:
X-Microsoft-Antispam-PRVS: <DM6PR12MB295540214329ED1C70F6E109F6440@DM6PR12MB2955.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 023495660C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbKxDTwNKph7cxDEunB9BwZrit+GMSXyZvsAe691fa1jsXXHdeL3GAWVYUrKXGLRHsDCq0X1kpoWaR/go2DIfwEyZKbEMaRF8itp6D2g9wNjhMH0F8AQLzy6kuVnMaxdwNbRzvucegMfZMWL5s0xNb3xas1rvJtkKptFQvTK6TuGhMsRdu9t5vySWkPJ4FAr/YEjiOMjIlgh9FSYVcWb7F4dkgQcMsJlodwmSZMHOTbnQGGNYmph023lPmZpQv/wYDLqHKtsDn2r4TdDgu+3vfkEw001MEUr8bEWDUseuJK6jrrDVZ+nZQ7m8qJtzdffJkGBtbLmdS71MOh/VAA7sVbeILpRdLkCJUGJPavhaikQNIx7tR6qGMMGDcc0P32uyuhAAEt7IPBwcTiqEuXb1caNri8wZbTN7PHXeCpbiF038ubVUomoEmmU3JuQ4q6v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 13:55:32.1358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbea4c66-11d9-4fbf-a6d1-08d773417842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2955
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsYg9pCCditIGDNfygopbIM5BxEI05gtn0ZLtly5AMg=;
 b=wk37L6BUasU/YilmcKhjj6pmFSo0vUf0cakr0wp6T9eQAJzIkc3vbgmNAX3dhWESlzWCAuJjx32TrnpPHmKLDxZVEw/ARkgCAlpVine8iSE9WzkX32sDr0McXUYhjPKHbvNWpRoS1pRfbEdju2By0hbUYNDcyfnfIFGEpEre5iM=
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
Cc: Le Ma <le.ma@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127135329.kAema550HbJpTVrp1v3OI-8HKM82QZlAKVDy65_fz1k@z>

U3dpdGNoIHRvIGJhY28gcmVzZXQgbWV0aG9kIGZvciByYXMgcmVjb3ZlcnkgaWYgYmFjby1zdXBw
b3J0ZWQgUE1GVyByZWFkeS4KSWYgbm90LCBrZWVwIHRoZSBvcmlnaW5hbCByZXNldCBtZXRob2Qu
CgpDaGFuZ2UtSWQ6IEkwN2MzZTY4NjJiZTAzZTA2ODc0NWM3M2RiOGVhNzFmNDI4ZWNiYTZiClNp
Z25lZC1vZmYtYnk6IExlIE1hIDxsZS5tYUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NvYzE1LmMgfCAxOCArKysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
b2MxNS5jCmluZGV4IDk1MTMyN2YuLmU4YzVhMDAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NvYzE1LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29j
MTUuYwpAQCAtNTU3LDcgKzU1Nyw4IEBAIHN0YXRpYyBpbnQgc29jMTVfbW9kZTJfcmVzZXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiBzdGF0aWMgZW51bSBhbWRfcmVzZXRfbWV0aG9kCiBz
b2MxNV9hc2ljX3Jlc2V0X21ldGhvZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKLQli
b29sIGJhY29fcmVzZXQ7CisJYm9vbCBiYWNvX3Jlc2V0ID0gZmFsc2U7CisJc3RydWN0IGFtZGdw
dV9yYXMgKnJhcyA9IGFtZGdwdV9yYXNfZ2V0X2NvbnRleHQoYWRldik7CiAKIAlzd2l0Y2ggKGFk
ZXYtPmFzaWNfdHlwZSkgewogCWNhc2UgQ0hJUF9SQVZFTjoKQEAgLTU3MSwxOCArNTcyLDE1IEBA
IHNvYzE1X2FzaWNfcmVzZXRfbWV0aG9kKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWNh
c2UgQ0hJUF9WRUdBMjA6CiAJCWlmIChhZGV2LT5wc3Auc29zX2Z3X3ZlcnNpb24gPj0gMHg4MDA2
NykKIAkJCXNvYzE1X2FzaWNfZ2V0X2JhY29fY2FwYWJpbGl0eShhZGV2LCAmYmFjb19yZXNldCk7
Ci0JCWVsc2UKLQkJCWJhY29fcmVzZXQgPSBmYWxzZTsKLQkJaWYgKGJhY29fcmVzZXQpIHsKLQkJ
CXN0cnVjdCBhbWRncHVfaGl2ZV9pbmZvICpoaXZlID0gYW1kZ3B1X2dldF94Z21pX2hpdmUoYWRl
diwgMCk7Ci0JCQlzdHJ1Y3QgYW1kZ3B1X3JhcyAqcmFzID0gYW1kZ3B1X3Jhc19nZXRfY29udGV4
dChhZGV2KTsKIAotCQkJaWYgKGhpdmUgfHwgKHJhcyAmJiByYXMtPnN1cHBvcnRlZCkpCi0JCQkJ
YmFjb19yZXNldCA9IGZhbHNlOwotCQl9CisJCS8qCisJCSAqIDEuIFBNRlcgdmVyc2lvbiA+IDB4
Mjg0MzAwOiBhbGwgY2FzZXMgdXNlIGJhY28KKwkJICogMi4gUE1GVyB2ZXJzaW9uIDw9IDB4Mjg0
MzAwOiBvbmx5IHNHUFUgdy9vIFJBUyB1c2UgYmFjbworCQkgKi8KKwkJaWYgKChyYXMgJiYgcmFz
LT5zdXBwb3J0ZWQpICYmIGFkZXYtPnBtLmZ3X3ZlcnNpb24gPD0gMHgyODM0MDApCisJCQliYWNv
X3Jlc2V0ID0gZmFsc2U7CiAJCWJyZWFrOwogCWRlZmF1bHQ6Ci0JCWJhY29fcmVzZXQgPSBmYWxz
ZTsKIAkJYnJlYWs7CiAJfQogCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
