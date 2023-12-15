Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC6EC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B358110EA56;
	Fri, 15 Dec 2023 16:00:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2310E10EA40
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRjvaZVGB6OnagVLyYI3ow+tN+cGkqc6PQ6up/Zu3KaHh9TgPnyZle1IUuC7orSeyCort4wYOIl+smaPsNi2XW7dlF1zZKF+YLTvbcMaovaplP286mwzkrHqo/ExTPUkl1y96VmxGqcQUiG7VFsjnJIm2zGTUzt3FLZrfog3ohNLtgrBpN9EUjX1uLvUWJ1Atb9QlAdgsQgsTpSOwtrKgYWl8HVPWfeFssjnwzFh+V4YFKfa/kW41e1peMpphoAIJ1aab7jaKdsMNFTya6UnY+VLZ5nemNBMecknErg1mu0XuDQKs5DxJQt8aTN1LTdClro1L3qOxMvwppnP2dJlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5DuU1dyjG4A6W/BO/eFmEPotGG6v5ipyvSBuveWiZQ=;
 b=PU3uYv77DxDNbYY+lMah+2hR6+dC/TbKnGj6WgjRAuH0m1yIKgJya5bgyd7VY5XmrGm3JcWoXaPkrKDY4n3UVXcov4mg2zakSS7ekd4T7dAbOWqPfAYL8Cvn+ItAsX9mGSREoH2CtxDsKotAO1ejsq17/KLEBdXXMQFrm3JrCLnGPou/ZZsDPigKjFQ4fGvwbRrH6CURw4eP7SNDXJ8tJAJx0mvd2JMAbIT6X8Cyd1mSgL4vDxlVS8LsBMC2iAhRX1nwOZtzHiLX16qmo+fEecYJKym35Skatvx6j+P2bosyhnNw//OLesVKIpxD0YW37FZ5h6G5W36rYs+O866QjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5DuU1dyjG4A6W/BO/eFmEPotGG6v5ipyvSBuveWiZQ=;
 b=sknUhaAzvvx83ftRI+MjsZQjmVVX98X1gxLsOyY31gS5yx4rFYmVWupPZNXlgW9XUiB33/+Bz/QPTTO4XnFwlxm2OcpkNsCyJtO6rmSOFXc36eUC4kOoRZJW2xgZZZ+2RZZZfLT+dwvrPS8iU43GTNf1jsoKG9J9R33V+yeOBdE=
Received: from SN1PR12CA0104.namprd12.prod.outlook.com (2603:10b6:802:21::39)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 16:00:41 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::f7) by SN1PR12CA0104.outlook.office365.com
 (2603:10b6:802:21::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:41 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:35 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 03/24] drm/amdkfd: enable pc sampling query
Date: Fri, 15 Dec 2023 10:59:30 -0500
Message-ID: <20231215155951.811884-4-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 66947e60-fd0f-434a-4af8-08dbfd86fceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdKHI1M167MFU3crvlH2rpI60nSr+azgHqfZVvKqYtuTOZ4PJIGnBbQuDO+BJb94Eqe9p4k7DnTNYgDQfXIkalsKaNIaEDW1uCSzLP14DFc/YibA/zQuLuIgd5T70wnvDySfDhv71kF0M6YGVB86+WImsaplzuIkG0U4EFXZj6YuiBKHH6IEL0udDHFdFGrhLVNWCnkpSSybmrv/JyxcltRtEni1Eo/euc/752ATKbxRG02IOKHxa1yJlUXlJz/PY4V/UrReEF+lV/5ZEu/Lc57vJWA73ild6Pa1HOVWCQploSljWEiDBnlBY86kR5tGNSyH3PoC+1IDkxBbCDgvlGiq4nKmVOi1HV7ViHf9LoKTb+OmuWKBhzq1Ej7re8hRheOcZxuRmRjewVQc9bQEBHXweTMcNNNeByBXLEWf/AY4Vx7fGecIApnaaKvUknUiRLlqQg4TRxS19zQyneWllbzD6T4T8w5Ppj422zbW89bhgPvYNO8Zpdpy8jLBwfPgH7ent8VRaLJ930noG+M+Z1g4ZV/U4Ym2lzyC4FjdyieZbZVEM46FoUJ7U6Akczu4yyNEKru1NnN9G5KIoB0TiPlDB44rmM/CsYZPfv8nJ963C2kek9rUlAJm8s1jJ5noN/878fVlsR8dliT5rbvk82OJIl75KIm6dhmJgk88ai7vuV/gL1IKmiTuYtKSBnoO0l+oqiFYRt5L80DFlU40GOnIuawOavsSrcOjD3/56jgPxItuS1YjByqNJPTBdbXkBHG5xhrAnP6lkegH661L4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(2616005)(1076003)(16526019)(426003)(336012)(26005)(7696005)(6666004)(40460700003)(82740400003)(86362001)(81166007)(36756003)(356005)(5660300002)(8936002)(8676002)(4326008)(83380400001)(36860700001)(47076005)(54906003)(70206006)(70586007)(6916009)(41300700001)(2906002)(316002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:41.3155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66947e60-fd0f-434a-4af8-08dbfd86fceb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Yat Sin <david.yatsin@amd.com>

Enable pc sampling to query system capability.

Co-developed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 54 +++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index a7e78ff42d07..987c415f8f0f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -25,10 +25,62 @@
 #include "amdgpu_amdkfd.h"
 #include "kfd_pc_sampling.h"
 
+struct supported_pc_sample_info {
+	uint32_t ip_version;
+	const struct kfd_pc_sample_info *sample_info;
+};
+
+const struct kfd_pc_sample_info sample_info_hosttrap_9_0_0 = {
+	0, 1, ~0ULL, 0, KFD_IOCTL_PCS_METHOD_HOSTTRAP, KFD_IOCTL_PCS_TYPE_TIME_US };
+
+struct supported_pc_sample_info supported_formats[] = {
+	{ IP_VERSION(9, 4, 1), &sample_info_hosttrap_9_0_0 },
+	{ IP_VERSION(9, 4, 2), &sample_info_hosttrap_9_0_0 },
+};
+
 static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *user_args)
 {
-	return -EINVAL;
+	uint64_t sample_offset;
+	int num_method = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(supported_formats); i++)
+		if (KFD_GC_VERSION(pdd->dev) == supported_formats[i].ip_version)
+			num_method++;
+
+	if (!num_method) {
+		pr_debug("PC Sampling not supported on GC_HWIP:0x%x.",
+			pdd->dev->adev->ip_versions[GC_HWIP][0]);
+		return -EOPNOTSUPP;
+	}
+
+	if (!user_args->sample_info_ptr || !user_args->num_sample_info) {
+		user_args->num_sample_info = num_method;
+		return 0;
+	}
+
+	if (user_args->num_sample_info < num_method) {
+		user_args->num_sample_info = num_method;
+		pr_debug("Sample info buffer is not large enough, "
+			 "ASIC requires space for %d kfd_pc_sample_info entries.", num_method);
+		return -ENOSPC;
+	}
+
+	sample_offset = user_args->sample_info_ptr;
+	for (i = 0; i < ARRAY_SIZE(supported_formats); i++) {
+		if (KFD_GC_VERSION(pdd->dev) == supported_formats[i].ip_version) {
+			int ret = copy_to_user((void __user *) sample_offset,
+				supported_formats[i].sample_info, sizeof(struct kfd_pc_sample_info));
+			if (ret) {
+				pr_debug("Failed to copy PC sampling info to user.");
+				return -EFAULT;
+			}
+			sample_offset += sizeof(struct kfd_pc_sample_info);
+		}
+	}
+
+	return 0;
 }
 
 static int kfd_pc_sample_start(struct kfd_process_device *pdd)
-- 
2.25.1

