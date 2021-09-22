Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF56C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 10:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516FB60F41
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 10:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 516FB60F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E73D46EB6C;
	Wed, 22 Sep 2021 10:33:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 406706EB6C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 10:33:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVNwfzS5EV7yqRTxLgHNP9aEQziLCKMtwbGGdD/alNWPJPTnPWUp4rX4/B6SdbQvhVRVD1V72lyUUoFSH6lpCF/ZFcdr/wHeJONyIyu1lS0MbWPHuYKlBCzdorhTPcj/m6+sBPedGmZYMptGfiNXViE5J2+KLIIsMKb00tF+9YJ64V7aj97VFSwv9pbPsJl8x9br7bJDRBzkTcmHeZJuUcHggcDd0R29kcM01Dx7pbzWiDdAq1dA88pZI1Bx9HMLf6pItX6NaewdtHRKLo5CoyVu9pzg7iq44sdcXxC/KYUolg4iFUy0bKhEUbT/vAHT6uWyY7Z52Np5lTLpi8PFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=2nbjPwe3wZE7WsPE08InhT8Q2C4kMJVSrhOgKn5+fPs=;
 b=Dpnd1KoZHchAk0kKg6VXju4+Mu5mvAu04dUv1kQZufroJtrxxeHXtoLGOcjzVkduPoOY1Gwt478Z322Qg1Lw0Z0rIAhsLC85rUbP7sucOEOS/ufQC7fkfjVuc4G9N3pBjp3Wgdl3poBs7F3hoCeYOoHJUdQJNwivuHp+KkuIs1nCNWRUXbFgVrAau19LXGNfA97i9W7R51+oO5hUXqMnS33DbwqpsO+FEyZlOdUeGvcB8ACTh0uPaxRxa1KXo7A4Inzs74kFWoLEbnP3P4Mv0/+2c73OAfXnd619v+tRzGVUnFT0gCo6YhwOlvtM2vpoRh7j3jYoe0Om3zbKIV4pug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nbjPwe3wZE7WsPE08InhT8Q2C4kMJVSrhOgKn5+fPs=;
 b=GCRWbcwpeFkcTtlwHuSONPTDTCjHiCzsfrUs3tZ852f3Trpuar1dDTJtuVvfauqnVF8ba2HzHeC6ZmHlUGab7FLLnZxdgXufav9fNd260qMCanUlyEThJAgl2Bvjtv0kRlUL1dEShHjlFiV3V5gtdmrHee9AjOZW4xk4FhjtzN8=
Received: from BN9PR03CA0640.namprd03.prod.outlook.com (2603:10b6:408:13b::15)
 by BN6PR1201MB0244.namprd12.prod.outlook.com (2603:10b6:405:54::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 10:33:00 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::b8) by BN9PR03CA0640.outlook.office365.com
 (2603:10b6:408:13b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16 via Frontend
 Transport; Wed, 22 Sep 2021 10:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 10:33:00 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 22 Sep
 2021 05:32:58 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <john.clements@amd.com>, <stanley.yang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add poison mode query for UMC
Date: Wed, 22 Sep 2021 18:32:46 +0800
Message-ID: <20210922103248.2401-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b33eda03-8bae-4887-9ce2-08d97db459d0
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0244:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB02441299B361863C0F36ACF4B0A29@BN6PR1201MB0244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pC41duYRbFC0ZFkR7wcI0Ow5Ok9pf4K1vBC1j0S3urBEYvuNTd4Qm79u4tHtfFzmEc4X/8wT/u8u1shCNJiabMs0BZoX+dJ/Nh1UjuvW+2RgUJB7mUeJGnQ4VwIf0vIyHHCe6fhDUnAiMVnnUgY+MbXJNZi+pIp9JLWHgcsZtynAxjJhbFEwUiETU5Wma6qKGUu7G/yGms2AEgNlaEO+qsMKstc7qhSUwk9TDDMjTNF3v2RAXAGZAL8x+0b7im62QyTYuqv575K6e4R9gkz3VwoRyScTavrClTHe6NF8CA5Z8CHXsS4UjRanCuYjkxCpT+N1SLAoC2iAVYa3jr746XlTdv4bku1Md61IQKMls6KoSbAZpyzCskzItsuEg9fcpmCk1vkd7u3g2oQ5BCZ6S707r1QWHnTxiq1zZx9VYAuGW+SVOM/9ucu8rEgq6z+HgNUyr5e0QHGC98uotbfrbsut5kX44bULWBk1ryH58DGKNIK79irs5Uf0fv9VC4DC3o/xtEiCu4eIpreEr+cr5AeWmxyipXGbeKsI+hj3TJVZlM4SNjxA9mtltpdLWR1tJBcuxc0+uusw4qd/iexn1m8GQ4twz+kfTFJeOOdYKv2MWO1lJR8XU6SE4zDMYWmFQ3T8e0KKHbGDXLF0341TD4gd3RR88DWiPpyZOpn5X6WA+T8td40VN4Vqd9fRHo5uOZTcFqSyvpeooAmc19dG2vCbVWoLsQPR5PVMkkiJGP8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(86362001)(36860700001)(8676002)(356005)(7696005)(70206006)(508600001)(36756003)(70586007)(336012)(5660300002)(426003)(16526019)(186003)(316002)(6666004)(6636002)(47076005)(81166007)(8936002)(2906002)(2616005)(26005)(4326008)(1076003)(110136005)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 10:33:00.3615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b33eda03-8bae-4887-9ce2-08d97db459d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0244
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add ras poison mode query interface for UMC.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   | 34 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index e5a75fb788dd..1f5fe2315236 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -48,6 +48,7 @@ struct amdgpu_umc_ras_funcs {
 				      void *ras_error_status);
 	void (*query_ras_error_address)(struct amdgpu_device *adev,
 					void *ras_error_status);
+	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_umc_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index bb30336b1e8d..f7ec3fe134e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -288,9 +288,43 @@ static void umc_v6_7_query_ras_error_address(struct amdgpu_device *adev,
 	}
 }
 
+static uint32_t umc_v6_7_query_ras_poison_mode_per_channel(
+						struct amdgpu_device *adev,
+						uint32_t umc_reg_offset)
+{
+	uint32_t ecc_ctrl_addr, ecc_ctrl;
+
+	ecc_ctrl_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_EccCtrl);
+	ecc_ctrl = RREG32_PCIE((ecc_ctrl_addr +
+					umc_reg_offset) * 4);
+
+	return REG_GET_FIELD(ecc_ctrl, UMCCH0_0_EccCtrl, UCFatalEn);
+}
+
+static bool umc_v6_7_query_ras_poison_mode(struct amdgpu_device *adev)
+{
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	uint32_t umc_reg_offset  = 0;
+
+	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
+		umc_reg_offset = get_umc_v6_7_reg_offset(adev,
+							umc_inst,
+							ch_inst);
+		/* Enabling fatal error in one channel will be considered
+		   as fatal error mode */
+		if (umc_v6_7_query_ras_poison_mode_per_channel(adev, umc_reg_offset))
+			return false;
+	}
+
+	return true;
+}
+
 const struct amdgpu_umc_ras_funcs umc_v6_7_ras_funcs = {
 	.ras_late_init = amdgpu_umc_ras_late_init,
 	.ras_fini = amdgpu_umc_ras_fini,
 	.query_ras_error_count = umc_v6_7_query_ras_error_count,
 	.query_ras_error_address = umc_v6_7_query_ras_error_address,
+	.query_ras_poison_mode = umc_v6_7_query_ras_poison_mode,
 };
-- 
2.17.1

