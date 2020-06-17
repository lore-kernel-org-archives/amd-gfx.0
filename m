Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFA4C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 22:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D059E2082F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 22:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="co44/84r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D059E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BEE56E1F1;
	Wed, 17 Jun 2020 22:00:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 795416E1F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 22:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dnu5z+qN6GgjDijQWD2JYm9fDcqxWtlIY01GrZduV/EO1pI3O53sn2hIz20zjYCjN9fXUR1v3qtH2NvDIwo+3vz1vDhONk/6KhsqZ3MM4MVHRu81hZK7tcKCeceeqX5BT83Uwvl9Bb2BQknY3TYQ4QO9GiS0TVg2z7sEjLVSRNvKZFdJACwQTIoNi724b3xtW6aLKm5csHAWTs0RLQUZ4P2HxKddjmFTGG7ioMayWpIB0fcBiTR2Xko3jVNzTRcd8upxRWzPG1x43QM63GubVyM1dTdb8sZxmRIEwZgGjFGonDIxy+dV4K9iNdOew6mc6jf33pHNPiZ0uKoB1LPcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZgdBKCF8EWOVxHSsDWMXEA+51KR9Wn5HdRKg4dlDqE=;
 b=kLx4HvhT/6wgJ6+ijhidkBELH6ESUvetmGPJ/Q8K4kZmj01RUBgix06b4zTjhn82z+4/V0YTeMiiq3DO5Dm+ByXsVahWngK2YcX6yKfiAjLx7hsy7pN+/oXpmyplvbWOFZwXf0quuIWJp8TM5j6aQOgz+F08EHhSbFdPXGp1qh0+lovvN1neQseobWz4OZVrXDjZi77jt/skfWSOi17ejSyWkXCAbKqg6ofHX7va7QkpZEViSA4XlCiiNFuX+uP68FIlh6Ba+T+/PTt627jjCZCJAcw82Urm/957aoynIocT9BtrVDbVX1aCgGSgvUYBhzNnKO6HT8L+Cmqngjh4yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZgdBKCF8EWOVxHSsDWMXEA+51KR9Wn5HdRKg4dlDqE=;
 b=co44/84r7pvebiC+A3sDLBxsSRSm5LdO4WvJhVy/3GjR52Oqo8n/buKd6kPSM8wE1WjsuofpwGXwsuGNK2PlhaRR43bUIcanlTXz/KoUpggL3ihZgPsKosfMl+G4Uu5Sg+dEBjvjauWo/OqFG3eKaLuTMQt+V5OLqR/5Nd+8SaQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM5PR1201MB0185.namprd12.prod.outlook.com (2603:10b6:4:55::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Wed, 17 Jun 2020 22:00:56 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::64ab:bf43:33df:e88c]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::64ab:bf43:33df:e88c%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 22:00:56 +0000
From: Sonny Jiang <sonny.jiang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/7] drm amdgpu: SI UVD context rreg/wreg
Date: Wed, 17 Jun 2020 18:00:13 -0400
Message-Id: <20200617220016.4844-4-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617220016.4844-1-sonny.jiang@amd.com>
References: <20200617220016.4844-1-sonny.jiang@amd.com>
X-ClientProxiedBy: BN6PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:404:8c::31) To DM6PR12MB3433.namprd12.prod.outlook.com
 (2603:10b6:5:38::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR07CA0021.namprd07.prod.outlook.com (2603:10b6:404:8c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Wed, 17 Jun 2020 22:00:55 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: acb3edeb-01c8-4c5b-1437-08d81309e953
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0185:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0185CBC888A61F7D90404AFBFD9A0@DM5PR1201MB0185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOWN2JP781oBiC466k28QnTim3kdYNnyOaWhPVaSgPVpwTlONk1tlNCvJnSjZpQm4WdzBJiLTsDD8wCJ5x0n6JcSD7V4w50BCqdPAKtXOSebsnRc1GGKeZZGLdxI1DsQwyHQFOxZX8UoF3H2q8O4MBrz+MSQt3yMHvkYDEznY7T/0EMZkyj6xUsS7mHLlFlOwiOSE8HM69vtG5rss1k40x63+jDDptwqFQVq4FMIdO7PmW8I/Heei36vMNBxeETJiVm1yXcww4xOJztI/PA9AjDoJZxbX4YsQhB4ZAOMX1w1Cw36iEqTHYlYccW7SH9gYS3GU6i4AysSl92L6mz1BOUA7da62ckaWypE+2SuGdulYjQqfoqRFyS6VERUOAnn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(5660300002)(316002)(6666004)(86362001)(6512007)(186003)(4326008)(1076003)(16526019)(26005)(66946007)(2616005)(8676002)(6916009)(44832011)(6486002)(66476007)(66556008)(478600001)(36756003)(52116002)(6506007)(8936002)(83380400001)(69590400007)(956004)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: yePil6+uFYLPM1dOWhznFG1vjCnxAvV9ToWsXEtJbK7/g57EYVUOq9DaGRYNNneb61kmc+4OZvpKT8JYI4Pfx8uTvthWyU885DqN6nAqXYfeCPp0I4GcsYaANnLbes38MJTiy5O+KSpzkwUR0O62nkR/CI8cN0T1pE8Bw3XMxaK3PS0753ItuGkbjiDdhfvzMBs8DGk0oqHa3cqw/iYBKPNSDkUOO/16B/II2PqLHM1t5JIuCn8Bzwzm2eItlcdXQ0tLSDJx65EIq8TeyzZtmPPzLDCVHRe+WJYYspDYRYpDaB1vjKDs7eG8r8us5XsBvbQfcUjelhRo2FdPxh4NKwpEcw9Ktd/KbrTpQkMSLVWfkFn7/90Xk/Oe0O/bLgGG8P7Tmn/cTZhJY1huTdugYKm+DNjmizHWxgzgiugjaYE3zluhp5SSXcP/zLdK/xh+McZHQ0/LTgLDFZuKMesEWqEWFq2J0LgGtcQJx7GgKP81tJEHxmnx+XWhZpbLnZyG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb3edeb-01c8-4c5b-1437-08d81309e953
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 22:00:56.5603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeE45P0LK8OmyxclvYZkWfLdLtNsRnXNUmZHSaYETArZyfHkWVfwyh6ugfaddiDFBAZDop8YpIggnbU3GHP7qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0185
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
Cc: Sonny Jiang <sonny.jiang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

---
 drivers/gpu/drm/amd/amdgpu/si.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 153db3f763bc..f1c33395e3fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -973,6 +973,28 @@ static void si_smc_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
 }
 
+static u32 si_uvd_ctx_rreg(struct amdgpu_device *adev, u32 reg)
+{
+	unsigned long flags;
+	u32 r;
+
+	spin_lock_irqsave(&adev->uvd_ctx_idx_lock, flags);
+	WREG32(mmUVD_CTX_INDEX, ((reg) & 0x1ff));
+	r = RREG32(mmUVD_CTX_DATA);
+	spin_unlock_irqrestore(&adev->uvd_ctx_idx_lock, flags);
+	return r;
+}
+
+static void si_uvd_ctx_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&adev->uvd_ctx_idx_lock, flags);
+	WREG32(mmUVD_CTX_INDEX, ((reg) & 0x1ff));
+	WREG32(mmUVD_CTX_DATA, (v));
+	spin_unlock_irqrestore(&adev->uvd_ctx_idx_lock, flags);
+}
+
 static struct amdgpu_allowed_register_entry si_allowed_read_registers[] = {
 	{GRBM_STATUS},
 	{mmGRBM_STATUS2},
@@ -1443,8 +1465,8 @@ static int si_common_early_init(void *handle)
 	adev->pcie_wreg = &si_pcie_wreg;
 	adev->pciep_rreg = &si_pciep_rreg;
 	adev->pciep_wreg = &si_pciep_wreg;
-	adev->uvd_ctx_rreg = NULL;
-	adev->uvd_ctx_wreg = NULL;
+	adev->uvd_ctx_rreg = si_uvd_ctx_rreg;
+	adev->uvd_ctx_wreg = si_uvd_ctx_wreg;
 	adev->didt_rreg = NULL;
 	adev->didt_wreg = NULL;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
