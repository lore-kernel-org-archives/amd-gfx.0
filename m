Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25926C48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E02110FC5E;
	Tue,  6 Feb 2024 15:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0ojtXVNT";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9483F10F9C6
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmE8IcagEDnbGH2HF/5LeaMgw9RZnZfCUq9HqDqMH0/x/uqtk7Q7vsyVtojqC65CdnKZph0g/4TLE+dFKSlCOzvASWQMmoLtJeBAHMwR310Hi9wHYI0+tY7nRsIgdB0N4Er++YE1hHrZwrNSMhVWT5iNqAMswtW7qzVZO28En9REa/163xsOP1ePnk1kTMs0LPPGKLDO1Fu8Hv1MN7i9SmoN1zWn2COXbTpMFazhIOB3lFhL6M8fIdfqvp2MmUemql4OFdFjmG31bCDCt3V5GAysmdYsrxrrjC59HzHkfUAQqHTuiJuCEdvf34vSPMdognbD1pVYl9IcU30RVAQubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmlhLimzIk9uebLFrJB7EVqNgvOg1iCy3jLa2NPtDAI=;
 b=jL1y5+BMjl+beZOMWU+ImqqYS5BbWdKW6jCIcLB+8rSyV3V1BAEAh3yqXOOYe6qhINrYPw4Z2BLZXjKgaqwkoLXmia4IHmJg+cF7uZjCklWn3MzHJZlrTXjXTQky6a+C90pO7DL5rUC24Igr0rph/5kolXltadvcf3k1QNVtef0M6n/6mozAhKqDLYh2y/+bantLw6EsZsy4zGrkhN7yKpMbdJhd5B/QXbLLSu7LYU4zlg4Miomle7/8rOg4QLmSavvJnLG1e76a7e6d9/olFbrjsjhMZXgNVaVWe+adcZiGwjnx4vy5EB/Cp3cqf7S2VX+A7TzQaqXhRP/79XmpWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmlhLimzIk9uebLFrJB7EVqNgvOg1iCy3jLa2NPtDAI=;
 b=0ojtXVNTVQ0jnqPj5loxrFhJBaj5CtGvnBbpvDvDFXRLQ+1EQr9CvOY/P8FR36T9SYkR22PlQPfbqyqpZpQ1HHyjxGS1NIPKHX957nccGPfHfvrjx8EgnsqziKCEQUjW6Z+X60ISEA0hXvK+ZE+lBvqJd7XZhEsYpTYFoIOm4hU=
Received: from BY3PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:217::8)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Tue, 6 Feb
 2024 15:59:40 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::9e) by BY3PR04CA0003.outlook.office365.com
 (2603:10b6:a03:217::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:40 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:36 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 10/24] drm/amdkfd: trigger pc sampling trap for gfx v9
Date: Tue, 6 Feb 2024 10:59:06 -0500
Message-ID: <20240206155920.3171418-11-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb62679-7c10-4bcc-40be-08dc272ca04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nf8dHHzRzwA/fp1kwjtw1oACNMBtV4iPNqfBmgJjF+xY3mjunVYp7Eawl7zadr4idqKP4qRNBVas7EdyysLaCo0O8/zBKJ26G2Anjd5P0pCpMjxJkxyrIFTXtf46s27h1xFoiE6njeZB2cIUuPGl2cGSPjiorwFLBxe7eRbSuWaUEW+P3Es7cPh1E+niorRRiOZllw0QPRRvTJY7EVCqKP9qX3zlHcQv7qlmxmoWZ+fpeat6ySwYBQrGoSZMmGhSUKsM+XUA73kxMHMU67visZSVMwE95oQAaqMm6qE1xXoQljzSbKsippMb1kN3rSf+ahnx/Wu3z2AtyZk4Jpr5MJeS13AZHdmuV4O6YG2UCI+QtlNkj80igzWUy9fo4oYTH2q7gQXIMYyz3ncI6T8R/j5gvYKXsHGxxE4m6AzITe01PgqJ3FimLBsA3nrCmDWj4i48Y+UJyB51MoTTIgSqmTdZ9ORRixnTykBpeOHs1E551Clyi5TB/s1SyAVtmTJmRFoqNBNwTKn5FqHJrFCBC8XRaMdLni8EVMirmP/8tY07Dh3P7P2+Q1QgLd98kIF3b2M8RdOKhvnr7Dz7LSMGHPoTysZDQ1tkaOD0Wzn6c8swmdiA5yD2ympRIO7Ruqc7C3K/wIfwMBVxR5vcNi7uwmats8ezkbmElvhInzBcsebFfXrIq/cHQYmJncPyTX+bkMz4e2LB0Vca6qnfFuGOdwYWaU/E9rnHgLvz0I67i9EcnhuEvNWtIb3OgocVgMqeaQV2hMLzPoZHRRtpsrX0NQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(478600001)(2906002)(86362001)(36756003)(41300700001)(2616005)(1076003)(81166007)(426003)(356005)(83380400001)(26005)(82740400003)(47076005)(16526019)(316002)(8936002)(36860700001)(7696005)(54906003)(70206006)(6666004)(336012)(4326008)(70586007)(5660300002)(8676002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:40.0110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb62679-7c10-4bcc-40be-08dc272ca04f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001
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

Implement trigger pc sampling trap for gfx v9.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 36 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  7 ++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 5a35a8ca8922..7d8c0e13ac12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1144,6 +1144,42 @@ void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
 	kgd_gfx_v9_unlock_srbm(adev, inst);
 }
 
+uint32_t kgd_gfx_v9_trigger_pc_sample_trap(struct amdgpu_device *adev,
+					    uint32_t vmid,
+					    uint32_t max_wave_slot,
+					    uint32_t max_simd,
+					    uint32_t *target_simd,
+					    uint32_t *target_wave_slot,
+					    enum kfd_ioctl_pc_sample_method method)
+{
+	if (method == KFD_IOCTL_PCS_METHOD_HOSTTRAP) {
+		uint32_t value = 0;
+
+		value = REG_SET_FIELD(value, SQ_CMD, CMD, SQ_IND_CMD_CMD_TRAP);
+		value = REG_SET_FIELD(value, SQ_CMD, MODE, SQ_IND_CMD_MODE_SINGLE);
+
+		/* select *target_simd */
+		value = REG_SET_FIELD(value, SQ_CMD, SIMD_ID, *target_simd);
+		/* select *target_wave_slot */
+		value = REG_SET_FIELD(value, SQ_CMD, WAVE_ID, (*target_wave_slot)++);
+
+		mutex_lock(&adev->grbm_idx_mutex);
+		amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0);
+		WREG32_SOC15(GC, 0, mmSQ_CMD, value);
+		mutex_unlock(&adev->grbm_idx_mutex);
+
+		*target_wave_slot %= max_wave_slot;
+		if (!(*target_wave_slot)) {
+			(*target_simd)++;
+			*target_simd %= max_simd;
+		}
+	} else {
+		pr_debug("PC Sampling method %d not supported.", method);
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
 const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index ce424615f59b..b47b926891a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -101,3 +101,10 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t grace_period,
 					       uint32_t *reg_offset,
 					       uint32_t *reg_data);
+uint32_t kgd_gfx_v9_trigger_pc_sample_trap(struct amdgpu_device *adev,
+					    uint32_t vmid,
+					    uint32_t max_wave_slot,
+					    uint32_t max_simd,
+					    uint32_t *target_simd,
+					    uint32_t *target_wave_slot,
+					    enum kfd_ioctl_pc_sample_method method);
-- 
2.25.1

