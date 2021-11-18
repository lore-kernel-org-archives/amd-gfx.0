Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A7CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 18:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C8661057
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 18:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F2C8661057
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A179E6EA42;
	Thu, 18 Nov 2021 18:19:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87CF36EA57
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 18:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXcOFkVj3HtGCcR4XmDAT5PY31eGWPLWD96KMoGBUMfaGeNcU4cB4ZBmyv1JfWuwnrS4GbYJbHHTDoNFNPbddo3XLTqHa5OuYVdU/NIhF2NCLyI3aZtOJSjpIH3JWVBe/Hhz3vRNnWMF1ftK4ND2zL/cW+LuNj1v+aJfdMQn9GLmLhMnoyUn8fVmrAg6wPrTurDyQj7s1ezIlTke4A8/e5HAMIJLj5ZQSfYABPUD/+vY+7Pv0DDFI+cYXWuxOussw9OLYWtymvA2EfNWe7uVWrx/gTlxMxN0AF9P4qHFy0jC1nR8p8N9pCXmhFB4m/cegzLZf57ZTXpM0xzTEl4d+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXAqNs9Qf5vUgy8mcIHFbtab5maA+w849k9F3z89sZc=;
 b=l3J6ayWot1GAr2S380OnpSxVgPXn+HDe18gTO+rZWVV/4oAtgPzCUkagdKZmeORTDzMKOmW9ar+iVPhC+wWpg1b9LLltM30WS64gD/AszmAEZcqQxFCE1teuGZpgdB4gn4wW1rSR0zgOHsGrL6m/K2OJactAqNSNNIHPSk1yf8fYeNxZnEq025WpKB2ICDH4EqcURJ06ej7OvTvBhd2L7mf81D7yuxpINrRGyjOL2W39zUhm7g2SO+vrij6KvLdIVUDWwrRWrXB8Z5+jhE9x0O+mR7eIA7wCbunFClj0Z/Xguiw8RjbYUP8bCFoZJosUDcIZDPmmLJ5bvth6fIwtow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXAqNs9Qf5vUgy8mcIHFbtab5maA+w849k9F3z89sZc=;
 b=djk7OlKKafcjadIP5/Xn/HSqVdt0JgWPWhy5+i4NFM8NGiASHRcY6RONyhi8Cxl/17ySCpfIs/uMy0S71X21sPH6lckEDPyh3LkPiZPjU43wrFTqCPQHP3d/cSniddxWLwb/a47ObT29Zg1FFfRmCo5GrH/9aNoy18JATQ4F8Ls=
Received: from DM5PR04CA0033.namprd04.prod.outlook.com (2603:10b6:3:12b::19)
 by DM5PR12MB1500.namprd12.prod.outlook.com (2603:10b6:4:11::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.27; Thu, 18 Nov 2021 18:19:05 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::d5) by DM5PR04CA0033.outlook.office365.com
 (2603:10b6:3:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Thu, 18 Nov 2021 18:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 18:19:05 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 18 Nov 2021 12:19:03 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 2/3] drm/amd/pm: Add STB support in sienna_cichlid
Date: Thu, 18 Nov 2021 13:18:26 -0500
Message-ID: <20211118181827.237115-3-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211118181827.237115-1-andrey.grodzovsky@amd.com>
References: <20211118181827.237115-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8baa65a0-a0bd-4545-efbc-08d9aabfe7f6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1500:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1500AE83E9E5BF7F2EE04D92EA9B9@DM5PR12MB1500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9kJSgoZedI5fB4nDuYVkIx+Dnh9M3WuvAnoubqKfAAVp/hu9uq9uO5kKmd4Se3aEEzfNHA/euMGwOqK2s5PKToKODq3jHMMtGVNKn4lg36EcSI6HGN0fF4UfSlBNUYZgHaUzxT0kiDEjp1fW8GVNYQdBfXpODhFRImybvq0SHvHikmit/BEt4BJ++WFurSX4lT/zPU9fC3kFXbxCL7rohNT74HXw4kf6s/7/RBlWgY9HsFTI0WSf04uzBu65GzjTpdIllEwfywDnKootn3YQfLAqcnoIql9MywCAj/25mbLa9OpMBhHxV9jr9keYBSEWSX3NwV0VUnvBZ/LaNBbqx+3zBCB9LQ9V7SKiKQvWZpIiskK9TghBqKy58m8VOzpNNOYQB5v5rhaB23rjUlKVtNPgNEyjXgYTvj55qFzQYxhVnvv70EGXuht345mkNApSjvSWFDxuQqkdOiWArTA13bIGOooBBGRLY9zBy2TMQlvE881SfHXSlApN7+7jrnFbdYs6X/tgHWaTJRolpR69uZV2ElzHGv0nDPvDR2/D60XoHHbqCxPUT+oIPCYCIfSe4voExC+tkp//t3UN0CexOMEUrJszQrbGNmUtW4Nj/yDqW2a8WJ+RteS95tbZMO8LukG9XOYfooUhJf8ibICIp0yucNRHGgD4F348hasJU9NO40eUIvatvzUX5WQ955M9nnB93UGsjBbUTb7ge0liB2XbtU2rLrZyBBfLgWXJaA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(70206006)(6916009)(316002)(2906002)(426003)(16526019)(1076003)(6666004)(44832011)(82310400003)(83380400001)(70586007)(5660300002)(86362001)(26005)(186003)(4326008)(508600001)(81166007)(19627235002)(36756003)(36860700001)(8936002)(47076005)(8676002)(54906003)(2616005)(7696005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 18:19:05.6031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8baa65a0-a0bd-4545-efbc-08d9aabfe7f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1500
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
Cc: alexander.deucher@amd.com, Lijo Lazar <lijo.lazar@amd.com>,
 luben.tuikov@amd.com, Shyam-sundar.S-k@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add STB implementation for sienna_cichlid

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../amd/include/asic_reg/mp/mp_11_0_offset.h  |  7 +++
 .../amd/include/asic_reg/mp/mp_11_0_sh_mask.h | 12 ++++
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 55 +++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_offset.h
index 6d0052ce6bed..da6d380c948b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_offset.h
@@ -354,5 +354,12 @@
 #define mmMP1_SMN_EXT_SCRATCH7                                                                         0x03c7
 #define mmMP1_SMN_EXT_SCRATCH7_BASE_IDX                                                                0
 
+/*
+ * addressBlock: mp_SmuMp1Pub_MmuDec
+ * base address: 0x0
+ */
+#define smnMP1_PMI_3_START                                                                              0x3030204
+#define smnMP1_PMI_3_FIFO                                                                               0x3030208
+#define smnMP1_PMI_3                                                                                    0x3030600
 
 #endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_sh_mask.h
index 136fb5de6a4c..a5ae2a801254 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_sh_mask.h
@@ -959,5 +959,17 @@
 #define MP1_SMN_EXT_SCRATCH7__DATA__SHIFT                                                                     0x0
 #define MP1_SMN_EXT_SCRATCH7__DATA_MASK                                                                       0xFFFFFFFFL
 
+// MP1_PMI_3_START
+#define MP1_PMI_3_START__ENABLE_MASK                       0x80000000L
+// MP1_PMI_3_FIFO
+#define MP1_PMI_3_FIFO__DEPTH_MASK                         0x00000fffL
+
+// MP1_PMI_3_START
+#define MP1_PMI_3_START__ENABLE__SHIFT                     0x0000001f
+// MP1_PMI_3_FIFO
+#define MP1_PMI_3_FIFO__DEPTH__SHIFT                       0x00000000
+
+
+
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b0bb389185d5..9d7b4fade301 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -80,6 +80,9 @@
 		(*member) = (smu->smu_table.driver_pptable + offsetof(PPTable_t, field));\
 } while(0)
 
+/* STB FIFO depth is in 64bit units */
+#define SIENNA_CICHLID_STB_DEPTH_UNIT_BYTES 8
+
 static int get_table_size(struct smu_context *smu)
 {
 	if (smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 13))
@@ -650,6 +653,8 @@ static int sienna_cichlid_allocate_dpm_context(struct smu_context *smu)
 	return 0;
 }
 
+static void sienna_cichlid_stb_init(struct smu_context *smu);
+
 static int sienna_cichlid_init_smc_tables(struct smu_context *smu)
 {
 	int ret = 0;
@@ -662,6 +667,8 @@ static int sienna_cichlid_init_smc_tables(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	sienna_cichlid_stb_init(smu);
+
 	return smu_v11_0_init_smc_tables(smu);
 }
 
@@ -3793,6 +3800,53 @@ static int sienna_cichlid_set_mp1_state(struct smu_context *smu,
 	return ret;
 }
 
+static void sienna_cichlid_stb_init(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t reg;
+
+	reg = RREG32_PCIE(MP1_Public | smnMP1_PMI_3_START);
+	smu->stb_context.enabled = REG_GET_FIELD(reg, MP1_PMI_3_START, ENABLE);
+
+	/* STB is disabled */
+	if (!smu->stb_context.enabled)
+		return;
+
+	spin_lock_init(&smu->stb_context.lock);
+
+	/* STB buffer size in bytes as function of FIFO depth */
+	reg = RREG32_PCIE(MP1_Public | smnMP1_PMI_3_FIFO);
+	smu->stb_context.stb_buf_size = 1 << REG_GET_FIELD(reg, MP1_PMI_3_FIFO, DEPTH);
+	smu->stb_context.stb_buf_size *=  SIENNA_CICHLID_STB_DEPTH_UNIT_BYTES;
+
+	dev_info(smu->adev->dev, "STB initialized to %d entries",
+		 smu->stb_context.stb_buf_size / SIENNA_CICHLID_STB_DEPTH_UNIT_BYTES);
+
+}
+
+int sienna_cichlid_stb_get_data_direct(struct smu_context *smu,
+				       void *buf,
+				       uint32_t size)
+{
+	uint32_t *p = buf;
+	struct amdgpu_device *adev = smu->adev;
+
+	/* No need to disable interrupts for now as we don't lock it yet from ISR */
+	spin_lock(&smu->stb_context.lock);
+
+	/*
+	 * Read the STB FIFO in units of 32bit since this is the accessor window
+	 * (register width) we have.
+	 */
+	buf = ((char *) buf) + size;
+	while ((void *)p < buf)
+		*p++ = cpu_to_le32(RREG32_PCIE(MP1_Public | smnMP1_PMI_3));
+
+	spin_unlock(&smu->stb_context.lock);
+
+	return 0;
+}
+
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
@@ -3882,6 +3936,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.interrupt_work = smu_v11_0_interrupt_work,
 	.gpo_control = sienna_cichlid_gpo_control,
 	.set_mp1_state = sienna_cichlid_set_mp1_state,
+	.stb_collect_info = sienna_cichlid_stb_get_data_direct,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

