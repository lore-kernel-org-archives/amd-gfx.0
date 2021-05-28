Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED82C4708C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C76A613AB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C76A613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28EC16E560;
	Fri, 28 May 2021 20:01:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 406006E550
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 20:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lITqatRspSPiu0uOBHoX/iv6gPvV80b6u1zom099t2VBmmdukLkK76KLkvJ6+Gh28Xn3AM004FuuZNjuNmlY/Mknz7sdgIVrK4tAe95wROm/ObSVFurj+iTLunrDQjqJUubxpRrlDeRMIqAM3J/wmeE9nBV6l1EtPlLXke8UNp+khkmfp1pGz3lvomUvZygZ+y5//OUImJN/rwoi9edWpM548YrB46YXwfPLIjXsqJQb0EImiBIZCNvCcAlHGws044jTcSLIrkE9nZPFElXrPq/um5fZfOV/NiY16NfNSTkBTiz/6o5MfxaW08CQn7nZfQ+mv67sSnQJEU7PWMggDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqlofI4U2OIufuvpcuAUEZQrSS7XFvRio8SqN/sJbXY=;
 b=Da7zXnPXeZCF/IfAZ3MTSaLTy0aQr3b78sGGppfAXQSm2Bm4HUudmS55ZCIpCeKn+qmoxCsq+nQ0xQq+nBd72EfV0Erv3T4JNGVw05YlXpKPJvpXQz01k9jvn4Uw2djYKiZTPhbwv3RHPkfXX7+1IkSf1kqcnou5xNs4dLBi88eulbPbSRbLrn5OVCfpqaOQcJ2SjYN649WNZqydLafeStdipEEkkQ4O6veMJnqiArCKOm+mq5vRSfozRT8STdtaRAZpOu6LOcls3Cr/b3FL5jLKDv3JDUR6L1vD/9hJsG6rnWk4kiuwfb+V5nGDyQYXWVzh2pifJ1iRpswoFPQBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqlofI4U2OIufuvpcuAUEZQrSS7XFvRio8SqN/sJbXY=;
 b=y15nfQY4VJNzxl3ZcmSA45TS2C0fgR/1HsawqjijRPQ8wlZEuYYa5uBs7H42mfP+1dbsymNnh0/XdmXiriHrSHJXfsNOszcMj1auQ6K+jeWFF1fmHDpTra/t785ylr7BKyw1d8Eq3bZBRpsmX8LdgfHw/ibfqqhaSe950daPyfE=
Received: from MWHPR03CA0024.namprd03.prod.outlook.com (2603:10b6:300:117::34)
 by DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 20:01:15 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::75) by MWHPR03CA0024.outlook.office365.com
 (2603:10b6:300:117::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Fri, 28 May 2021 20:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 20:01:15 +0000
Received: from grasider-dev.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 15:01:13 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/8] drm/amd/pm: Add u64 throttler status field to
 gpu_metrics
Date: Fri, 28 May 2021 15:58:08 -0400
Message-ID: <20210528195815.2615-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c42014d-af90-4b4f-ed5f-08d9221359a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2811:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2811A26AA83F4DAEE01835928A229@DM6PR12MB2811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQbwiUPLzCm37kNpg4oOaVm4C8nXTgWIT7tkYZYPJpExp1zk8/4IY4hzbBaKJSAYtWEbfGJa9zhUP+aGO6tl2nhQYyezj8c+AtfR4vzibMxo5ivmctTjFDhz6WJ1XoMMLj0RUeHBhteA/Ul7SSktz7kKLuJ7FRdBJKaycPEIErBAA47osMQXBHXpk6kKkCUULYrn+zcw4h6JRoSmYox8OVJW1I5t1lzRIpjm+MjLPT70nyQOYuuQGrKFqFgMEuX/PnUXWiCELSPAQee0SR0/HvKIYmKp+fKomdswUAucJm6h6zXw4V6vFP5JToO83IRCmVu++v3ZPr3TlprLSo1eBsXeCVf6nY5X7rSiURSBnZpRJSo9/O+bbkj3LSk9ya+V+gK5VxAMFK2EwcysLTH0kJtmaszESd4H95QNPM9Xr6bu2zsHgGOJtpoD//X3uK28bhrFJ2LxPPvV8VOe3bV6csNh6c3rzByQrPxDCyD8yQY0gA6XFN/nUw91YUSd0r/URS+bcmlRoqPTbotJtN6drPMilJ/desl2usHQUPAFQ9dWr3hxYXIpSJYuWbHfwcjeRJuMIpKKUXchhePO0gI6mze3NKOFwbLulNSpNfRnm+cOdeND6yug2HzSQy42jeWuuKcmsb8dn0XFs66XlIcNlBMAdniBPs7NPAWcrMcX3DzOXm/jNGUXZ90UxICrMXeC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966006)(36840700001)(70206006)(1076003)(316002)(70586007)(82310400003)(6666004)(36756003)(6916009)(54906003)(478600001)(5660300002)(336012)(2616005)(356005)(426003)(2906002)(82740400003)(16526019)(47076005)(26005)(83380400001)(4326008)(81166007)(8936002)(186003)(86362001)(8676002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 20:01:15.1625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c42014d-af90-4b4f-ed5f-08d9221359a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
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
Cc: Harish.Kasiviswanathan@amd.com, Graham
 Sider <Graham.Sider@amd.com>, Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch piggybacks off the gpu_metrics_v1_3 bump and adds a new ASIC
independant u64 throttler status field (indep_throttle_status).
Similarly bumps gpu_metrics_v2 version (to v2_2) to add field. The
alternative to adding this new field would be to overwrite the
original u32 throttle_status (would still require a version bump for
gpu_metrics_v2). The benefit to adding a new field is that we can
allocate 16 bits to each "type" of throttler information and have more
leeway for adding additional throttler bits in the future.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 58 ++++++++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  3 +
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index b1cd52a9d684..b50d6bd0833c 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -577,7 +577,7 @@ struct gpu_metrics_v1_3 {
 	uint16_t			current_vclk1;
 	uint16_t			current_dclk1;
 
-	/* Throttle status */
+	/* Throttle status (ASIC dependant) */
 	uint32_t			throttle_status;
 
 	/* Fans */
@@ -602,6 +602,9 @@ struct gpu_metrics_v1_3 {
 	uint16_t			voltage_gfx;
 	uint16_t			voltage_mem;
 
+	/* Throttle status (ASIC independant) */
+	uint64_t			indep_throttle_status;
+
 	uint16_t			padding1;
 };
 
@@ -709,4 +712,57 @@ struct gpu_metrics_v2_1 {
 	uint16_t			padding[3];
 };
 
+struct gpu_metrics_v2_2 {
+	struct metrics_table_header	common_header;
+
+	/* Temperature */
+	uint16_t			temperature_gfx; // gfx temperature on APUs
+	uint16_t			temperature_soc; // soc temperature on APUs
+	uint16_t			temperature_core[8]; // CPU core temperature on APUs
+	uint16_t			temperature_l3[2];
+
+	/* Utilization */
+	uint16_t			average_gfx_activity;
+	uint16_t			average_mm_activity; // UVD or VCN
+
+	/* Driver attached timestamp (in ns) */
+	uint64_t			system_clock_counter;
+
+	/* Power/Energy */
+	uint16_t			average_socket_power; // dGPU + APU power on A + A platform
+	uint16_t			average_cpu_power;
+	uint16_t			average_soc_power;
+	uint16_t			average_gfx_power;
+	uint16_t			average_core_power[8]; // CPU core power on APUs
+
+	/* Average clocks */
+	uint16_t			average_gfxclk_frequency;
+	uint16_t			average_socclk_frequency;
+	uint16_t			average_uclk_frequency;
+	uint16_t			average_fclk_frequency;
+	uint16_t			average_vclk_frequency;
+	uint16_t			average_dclk_frequency;
+
+	/* Current clocks */
+	uint16_t			current_gfxclk;
+	uint16_t			current_socclk;
+	uint16_t			current_uclk;
+	uint16_t			current_fclk;
+	uint16_t			current_vclk;
+	uint16_t			current_dclk;
+	uint16_t			current_coreclk[8]; // CPU core clocks
+	uint16_t			current_l3clk[2];
+
+	/* Throttle status (ASIC dependant) */
+	uint32_t			throttle_status;
+
+	/* Fans */
+	uint16_t			fan_pwm;
+
+	/* Throttle status (ASIC independant) */
+	uint64_t			indep_throttle_status;
+
+	uint16_t			padding[3];
+};
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 0ceb7329838c..01645537d9ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -773,6 +773,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(2, 1):
 		structure_size = sizeof(struct gpu_metrics_v2_1);
 		break;
+	case METRICS_VERSION(2, 2):
+		structure_size = sizeof(struct gpu_metrics_v2_2);
+		break;
 	default:
 		return;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
