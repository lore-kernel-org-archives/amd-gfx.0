Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFA7C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAF2B10E425;
	Tue,  9 May 2023 22:18:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96BD310E425
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J74TdUWgTWGwnlGtwIUFGTppLH239TbMfdRix5PS2yVhLOUAw30aEFx488nXV8wO3m3vLRtm1lk2fpPsL251audO0eX3uRn8XrehXvVMn/qsPsrnynaOB3h5KOugtdTOj0TxjP3Rrh/1j1l8ywLXTWI4sk1QLMGi6zrlCqCD2eMZ2Cdu7Nhap2vldI4berOpdb0NmpoMBShPEL922HLVF2Z5Lt1eJ2YDbQRfUiEmyDEj2VDHKyWYYe0Vd/4Kj4BE0CV8kNVh5yXZ+RcFEsJgKno3/RoqH6ijMsvjBebaKQSFzSjoyrsi3vv5SK5pP/ddHcY/uFykyRQh5AykE69Mtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyA/hnzGZdUx1C4LKTMMHPbPxG/MTWiNsSPux5DVyF8=;
 b=bE1IQ0XFZKe3Dao9LhUJvicQBfSpvwqOYtK9KVOcfa1CgUid9MRNp8L8TN70LylqJRN+mJh/XqXJwePJqnex0POrpeW4qNv7Atw7m6G/pVxCtccP4T5eeAM8TVnyFBuXMg9DOfI2trhnYv9ckvet/27/bWcoOlQg2NZsrcZ1AvpIC78oKFDXisWCujVBESH/JX7cEeWMyaRGGuv2eFQ92dObJ2CzfAMMNXaHTqb4ggin73U1kmD+fORyzpoQXfGBg+fYrBg223z+FaQILZ9Fq2qJzlHAxeAF+BEfWs7qI7opatKX3YUiKfFxKSoIYbRSezfrS4vTYQ5oCRf+3KO6kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyA/hnzGZdUx1C4LKTMMHPbPxG/MTWiNsSPux5DVyF8=;
 b=hyoTpcZEQfEWug3YO1ode4yYiMgZ6H6VNQIT5DTYrW3kxqHZzqgCx8DfBm9FHmFCZWIoSOL9O56vtXxrNfbgvbiNjcpwPdK5h37HR4yp8m/TdLXuDZjMSbbVoCsf2yrLJtNPScMcift7+LYaJ+TfNFrYe7imNC/GTM/rMprQpX8=
Received: from MW4PR04CA0279.namprd04.prod.outlook.com (2603:10b6:303:89::14)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Tue, 9 May
 2023 22:18:45 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::90) by MW4PR04CA0279.outlook.office365.com
 (2603:10b6:303:89::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:18:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:18:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: Add PSP spatial parition interface
Date: Tue, 9 May 2023 18:18:30 -0400
Message-ID: <20230509221830.477324-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221830.477324-1-alexander.deucher@amd.com>
References: <20230509221830.477324-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT068:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c688cb8-496b-4533-8c11-08db50db5b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dn/ePKHgo56tBHb5m3SBVT1RX1aRSBKUiYGtBcBK1ePlzUswIczR1hjO22P7+ZwFWi8ruFEUOck/mlpTSc4+TMcQF6o5amERF9OAx6glO9XgHPBHw/M8ZKRDgtD4lkeybvieMbUGST9luuaSKa69TWLRqETo7dBLeGXkFrHhNUq4b2bOUPAYodt2O+967vb+XwZVYKu1oS/VECWbL26A4OIJDl2auEm153jferoEaVYXZLNm0IzvYTHBAslGkRNlPzRFzpy7qJuw0KM9UCylypln8kFuVQ8abFlF0qP4dkh3dFkwr1HMpXAOkgdAPE/i5BWgvaNpK6JXVUujrk6oql1bqfpBXW78v0IsLT3YPiRzHSQIBde054xqZYRdtSZqylChW8M4KZ7pcjhu8m6pAKt68FnNAzeYLaeIYlCLMcGllKeTG692C3JeJlxAtiK9a7BJaZkrIk4XLlG9ZrFHCUApecUuewlPaHrGWVa7PxtGrTFhtKGfeK3Lx5IBYjSrCj5osp8JFMkP9EOsUu+k8vEv1kisJp4V8D5NNMa6KDxGWNnNbBPkyvd04CVNHrNtHyKIWGriA5cvyoKac5xsRp3Stmw4grExtEbY/zltbjH0lJMkhtBP4WYW8EVJ810vOlZ63vRm1Tdmj9GDHZcWkebUlCdSLtvmddsKR6vcfAJRIbx7NGX3TZHwRdJN4MgsyK8PLeaSbPWbOkw/tyjYWXe/cNqkrYyad/n5yCGWzyg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(8676002)(5660300002)(54906003)(82310400005)(4326008)(1076003)(26005)(478600001)(86362001)(2906002)(8936002)(36756003)(186003)(316002)(16526019)(2616005)(83380400001)(426003)(336012)(70206006)(70586007)(6916009)(47076005)(6666004)(7696005)(36860700001)(40460700003)(40480700001)(81166007)(41300700001)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:18:45.7038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c688cb8-496b-4533-8c11-08db50db5b0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add PSP ring command interface for spatial partitioning.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |  9 +++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index ea47012795e7..d62746b596f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -991,6 +991,27 @@ static int psp_rl_load(struct amdgpu_device *adev)
 	return ret;
 }
 
+int psp_spatial_partition(struct psp_context *psp, int mode)
+{
+	struct psp_gfx_cmd_resp *cmd;
+	int ret;
+
+	if (amdgpu_sriov_vf(psp->adev))
+		return 0;
+
+	cmd = acquire_psp_cmd_buf(psp);
+
+	cmd->cmd_id = GFX_CMD_ID_SRIOV_SPATIAL_PART;
+	cmd->cmd.cmd_spatial_part.mode = mode;
+
+	dev_info(psp->adev->dev, "Requesting %d paritions through PSP", mode);
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+	release_psp_cmd_buf(psp);
+
+	return ret;
+}
+
 static int psp_asd_initialize(struct psp_context *psp)
 {
 	int ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index cf4f60c66122..0a409da749d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -519,6 +519,8 @@ int psp_load_fw_list(struct psp_context *psp,
 		     struct amdgpu_firmware_info **ucode_list, int ucode_count);
 void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size);
 
+int psp_spatial_partition(struct psp_context *psp, int mode);
+
 int is_psp_fw_valid(struct psp_bin_desc bin);
 
 int amdgpu_psp_sysfs_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 22c775f39119..18917df785ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -102,6 +102,7 @@ enum psp_gfx_cmd_id
     GFX_CMD_ID_LOAD_TOC           = 0x00000020,   /* Load TOC and obtain TMR size */
     GFX_CMD_ID_AUTOLOAD_RLC       = 0x00000021,   /* Indicates all graphics fw loaded, start RLC autoload */
     GFX_CMD_ID_BOOT_CFG           = 0x00000022,   /* Boot Config */
+    GFX_CMD_ID_SRIOV_SPATIAL_PART = 0x00000027,   /* Configure spatial partitioning mode */
 };
 
 /* PSP boot config sub-commands */
@@ -338,6 +339,13 @@ struct psp_gfx_cmd_boot_cfg
     uint32_t                        boot_config_valid;    /* dynamic boot configuration valid bits bitmask */
 };
 
+struct psp_gfx_cmd_sriov_spatial_part {
+	uint32_t mode;
+	uint32_t override_ips;
+	uint32_t override_xcds_avail;
+	uint32_t override_this_aid;
+};
+
 /* All GFX ring buffer commands. */
 union psp_gfx_commands
 {
@@ -351,6 +359,7 @@ union psp_gfx_commands
     struct psp_gfx_cmd_setup_tmr        cmd_setup_vmr;
     struct psp_gfx_cmd_load_toc         cmd_load_toc;
     struct psp_gfx_cmd_boot_cfg         boot_cfg;
+    struct psp_gfx_cmd_sriov_spatial_part cmd_spatial_part;
 };
 
 struct psp_gfx_uresp_reserved
-- 
2.40.1

