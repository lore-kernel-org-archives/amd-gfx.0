Return-Path: <SRS0=Vl9p=Y4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD4DCA9ECF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 04:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (unknown [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F062190F
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 04:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F062190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF3A56E133;
	Mon,  4 Nov 2019 04:43:39 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820043.outbound.protection.outlook.com [40.107.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B6C56E133
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2019 04:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQnFuI53lO9gwTTO6DR0witFODwZLtKABfczlEYV0pNYw94f+hl/VEzOGeeLYsj5sns4+CP4QpMyXNd1O84J7eFMiMGUmWRLuics6ZIDkXxvxk94mwIdtZBCF5T4ch6S4I9uOGhOZkKlAYAk8yk7vvs3RxWIRu4mDyn8C//tmtSHD0HAkZbx3szx3eOk0rzNHE10bKxc8d8s6eyp17kWTAZNqsf3/DMqbYfxPhf2MJPRy6+oAOwZqEr2A10x0WoPk8si6M4XwFGop1+IXy+D0mX3mqLcaD3vv1WBo9njoqZXrqdxvSVQB4nfcpSpzKNgRFJBMSc4xlaMfvlb4493mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8a/u1VkYWwHonbn2EdVyABfAAzHJS0D3tUx4+nytbk=;
 b=jLiYv6m+ETy1LRRHEINLAxDrg9xm6bzCdHRbQiwh6Q1qbaCWhPZYqmJyX7ftxBMuZ3NRAOdF0q2S/mphivzWcdisUxlHzw8vyWXbNi7iLDrpL7HsiyU8ftb46kDLnKjRzbZSuM+xInTqN4s1BTvLS30mLcq7TxiVEoAy6+7ALCmHmS91zYD+/FWbN1QBuY4eVYqpCjHO7ZzNg5dAwCEY7LC/4VQfPysfPrPsr3VEcb0Jjn9D+8sQdJuHbMo8KjmPGp2qmbC0pu74Vq5qmHoS4v6U1pQjekNL8a0j2W54MwVqeEeM0voiBPDDPIHWgjUL6tW2MD4fPCjiJstETCS4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MWHPR12CA0036.namprd12.prod.outlook.com (2603:10b6:301:2::22)
 by DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Mon, 4 Nov
 2019 04:43:35 +0000
Received: from DM3NAM03FT015.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::202) by MWHPR12CA0036.outlook.office365.com
 (2603:10b6:301:2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.24 via Frontend
 Transport; Mon, 4 Nov 2019 04:43:34 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT015.mail.protection.outlook.com (10.152.82.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Mon, 4 Nov 2019 04:43:33 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 3 Nov 2019
 22:43:31 -0600
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Sun, 3 Nov 2019 22:43:30 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: Need to free discovery memory
Date: Mon, 4 Nov 2019 12:43:26 +0800
Message-ID: <1572842606-32074-1-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(39860400002)(428003)(189003)(199004)(26005)(186003)(6666004)(356004)(53416004)(486006)(51416003)(7696005)(2906002)(16586007)(81166006)(81156014)(336012)(316002)(426003)(4326008)(2351001)(86362001)(47776003)(478600001)(70586007)(70206006)(126002)(476003)(2616005)(6916009)(5660300002)(8676002)(48376002)(36756003)(50226002)(305945005)(8936002)(50466002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2502; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7f826a7-7b25-4c1c-03c8-08d760e18c80
X-MS-TrafficTypeDiagnostic: DM5PR12MB2502:
X-Microsoft-Antispam-PRVS: <DM5PR12MB250275EB4C43E940ABF52A128F7F0@DM5PR12MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:224;
X-Forefront-PRVS: 0211965D06
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQo+A8KdJcFkJDnQPQrj02uSI63ROO49cxA3ulp7D5x16wrWd8hiNpp8cdLXbQtqGiSbneNK6ODaIyaXsFuV9IDwuHYV1LV5qhlbTCIahdbOif8dwbHSmt6ujJHVjqKl4KxxcveXZRG2/OA20FTBxmNmPRmovqIzSEx6Ui9aL75RZM++4U2kPoI0Il12mKqebDD/m0oO4We0BqZnVSEHmHXa0l1Xab3j0KV3jfeBbJN6VglkX1hhmFtK/fLkC8jW/JJRzWwUMFH1x20NECek6d7f2UJOzLflLhZrGXP7be2TCBPR2BSYYSCaRKlOoXsfyYV02OGqC8APv9lr713cYBvewPW2f9OMupDKCfriHv09YykvPO6erb5fiLyoGK8Fvu3yuLQRigHFA7itX/wUuHcVh1B1s8CZiS17tcWUKhC/2wQPg2jE0w9nrgoTp4Ij
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2019 04:43:33.6291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f826a7-7b25-4c1c-03c8-08d760e18c80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8a/u1VkYWwHonbn2EdVyABfAAzHJS0D3tUx4+nytbk=;
 b=ELrDhvnc7KZctF2FJ6ZTyeR/KYZmzRVvRp4Ptv9albnoQV27/0llsRs2kcCGv92HWYTEltFR+dfqLacJKAcek8gb08ZZpoGtoEerDPVG6GFZClK1X3ud1Qm+YHykUhjvVoLatdU8AgHo+el/F51I1Z28Ef6NxsgzFXTFkdAtdWk=
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191104044326.J6QNiNmWK_KeJUtIMNKKW-4McPpnp8g_X9HJHcR8Mfo@z>

V2hlbiB1bmxvYWRpbmcgZHJpdmVyLCBuZWVkIHRvIGZyZWUgZGlzY292ZXJ5IG1lbW9yeS4KClNp
Z25lZC1vZmYtYnk6IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHRtLmMKaW5kZXggMjhiMDlmNi4uN2NiZTZkOSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwpAQCAtMjEwNiw5ICsyMTA2LDYgQEAgdm9pZCBhbWRn
cHVfdHRtX2xhdGVfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAl2b2lkICpzdG9s
ZW5fdmdhX2J1ZjsKIAkvKiByZXR1cm4gdGhlIFZHQSBzdG9sZW4gbWVtb3J5IChpZiBhbnkpIGJh
Y2sgdG8gVlJBTSAqLwogCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRldi0+c3RvbGVuX3ZnYV9t
ZW1vcnksIE5VTEwsICZzdG9sZW5fdmdhX2J1Zik7Ci0KLQkvKiByZXR1cm4gdGhlIElQIERpc2Nv
dmVyeSBUTVIgbWVtb3J5IGJhY2sgdG8gVlJBTSAqLwotCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgm
YWRldi0+ZGlzY292ZXJ5X21lbW9yeSwgTlVMTCwgTlVMTCk7CiB9CiAKIC8qKgpAQCAtMjEyMSw3
ICsyMTE4LDEwIEBAIHZvaWQgYW1kZ3B1X3R0bV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogCiAJYW1kZ3B1X3R0bV9kZWJ1Z2ZzX2ZpbmkoYWRldik7CiAJYW1kZ3B1X3R0bV90cmFp
bmluZ19yZXNlcnZlX3ZyYW1fZmluaShhZGV2KTsKKwkvKiByZXR1cm4gdGhlIElQIERpc2NvdmVy
eSBUTVIgbWVtb3J5IGJhY2sgdG8gVlJBTSAqLworCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRl
di0+ZGlzY292ZXJ5X21lbW9yeSwgTlVMTCwgTlVMTCk7CiAJYW1kZ3B1X3R0bV9md19yZXNlcnZl
X3ZyYW1fZmluaShhZGV2KTsKKwogCWlmIChhZGV2LT5tbWFuLmFwZXJfYmFzZV9rYWRkcikKIAkJ
aW91bm1hcChhZGV2LT5tbWFuLmFwZXJfYmFzZV9rYWRkcik7CiAJYWRldi0+bW1hbi5hcGVyX2Jh
c2Vfa2FkZHIgPSBOVUxMOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
