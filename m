Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76163C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 12:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15DD810ECE1;
	Thu, 16 May 2024 12:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YvI+UgLQ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28E9B10ECDC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 12:43:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf83KtXY5+fMv8U+DxvaBl6OITo/xmxSviGeka/0tLYRBuncqBE4x03gD2RlfXCMuJvSYQ4BCzlnZgbXbWzs9OtVDbAgbB3c2W04c5Cfi2DNxLp/yrbM1YE7QkzroQj30GWl7RhS1JE9WoUH5in8anTDhUzUZHk4Vy9GyaaAvU32J3PQE2FuaSB6W+UMKhP62TOkFp/HUjKnJVemJ7cYSTdamaVS/z8eGrWXiGcaore+GVIXJUFv99dzMWhf+KrR/BBiAYoFQ7K8G7yny+RDMJvRvnDstvpmlDEPpE8nL0rxuixukhz/hma5chWecVlQtIDuBh+is2lU9zjtVzYyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wWwaF4JNrAv1ONDP590uiwj5+Li79FAsJcWI7BLLYw=;
 b=j0NwaV53qzxx27P9XIv25FEVVTls/V5pVvJELtKYDp58J4ibs/uq0A9FlwB2oINKvjXUovPUbOeQkQRuTry6W7OQtZ4iscfqS5GVrxf0hPtT/wbwDyCW0BgvS05U9SKYSj6O65IOC2sqN8atehSYnv6qgW0kMoO5NuI7lXiqsdDnLRtTu252ciRiJ4cNe0tBbMvUK0nKaYFrKBmxDQaU75tB/FHk9+vm1XgVsKPBmhxEHvIEKF64VAJFwSBs05HIltpwsw5EGlhON2mdGJx5JvDkAG3Uo40SRfYjltla2XR1y0BPRY12Div969GIymLK8LjdXAaTdawbknCGJFCOig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wWwaF4JNrAv1ONDP590uiwj5+Li79FAsJcWI7BLLYw=;
 b=YvI+UgLQRP6FLBAOQR9VFPqrIlYzHQwmOei/rqJeAl8RU8HwxGkf/yi2WB5HcrSK5pWMtk8fRBoUT3Vrps1zHmOUkdswlTWZ+foHIjnqVILKJcSjGWGmO2EqOyHDB+08TRRbRGGKWnmHNq7b71gM+W32NdhsjgQIKeN1VGnJ/8Y=
Received: from DS7PR03CA0164.namprd03.prod.outlook.com (2603:10b6:5:3b2::19)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Thu, 16 May
 2024 12:43:46 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::46) by DS7PR03CA0164.outlook.office365.com
 (2603:10b6:5:3b2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 12:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 12:43:46 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 07:43:44 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v5 04/10] drm/amd/pm: Add xgmi plpd policy to pm_policy
Date: Thu, 16 May 2024 18:13:12 +0530
Message-ID: <20240516124318.508785-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240516124318.508785-1-lijo.lazar@amd.com>
References: <20240516124318.508785-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: add08865-ac18-4181-0b25-08dc75a5d41b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c0XhPvNoH7RSYaor50ZxijQHTASTuIgrYEe7PXy51Xq5J/cKX7M5d+d7CcII?=
 =?us-ascii?Q?nq6JKoFRI3Xy4RDgaUCL1Z7Bd+TQMTWT3/HCb6I0SiKR5vReHDEJADklrzKv?=
 =?us-ascii?Q?o6SQft8d6y9pV1uoT3a4J8urM3NFqWhfcZ+DLw9D07IMni5hg5cLirbji1nJ?=
 =?us-ascii?Q?ifMrG/Xgz4nWWCL8WGyhVoUv72WN36BTaaTXK0VdHnqQ0Im1hwnXZNVzCCKb?=
 =?us-ascii?Q?6Nc9tt7SrgNgqROQVg16dOIrbvX2zOcCE+j7/A1dC6xqR2hFUcnluiR6XwkX?=
 =?us-ascii?Q?6THzu8aR4j+NPDheDmOkS6hRtczzwh5frjbT6HfuxsBBmXww4MPd+nvScIy1?=
 =?us-ascii?Q?+E9SEBb73sIo5R3BnUwnWpQMhvgIAfBoAIeobHB/+Cd88xMej+vkErMgd7qc?=
 =?us-ascii?Q?wV5hKUZGPTRg9WU2iXi6I7dBU+/3Pkq7qEKOrDxXp2MWh89WvwhhhoDVjJbg?=
 =?us-ascii?Q?P8fl1ms9mfGA9CzDDdNM0saBmb0SAPmEQvxRI50xlzunleo1L5bqZieQb+cr?=
 =?us-ascii?Q?vSSjkgPvpH1JHunfbwHZBJ2IJg3F4AvIHIVlX0CARYr5TNDAEMQImHmbA7Va?=
 =?us-ascii?Q?HAuHJskVAdrKuJ9IoDCThSTWSfRMaXxcxhR1K5RYWl/Zm/TTjm6pfEY0XON4?=
 =?us-ascii?Q?9hLgrT+MCM7p1jNSKNRq3WQxfa7bxYjZtp7ssQhz4gqJj78wlIykbYffFzuo?=
 =?us-ascii?Q?t/tedKqSvh13DhOaJSQu5H2L/7IxRYON4HfA7/G86teZy+V5iSv8AbIU0y8U?=
 =?us-ascii?Q?krYcv8h3tD9m5J63+72eyL3Ias/+WwiwBv86DTqsddLDFeoO9vJNZtdJJllP?=
 =?us-ascii?Q?RP2bKGiZrUM6EJLtJkM8kbWoUCqib+C4V8dF9jrud4Pwf0Ld/yKEWeBOR+Wk?=
 =?us-ascii?Q?b/qhklSUNaM5PLdWwM8zAuWr/tEG/7SL7RRGEhx+DJMG1II04HOUk3OGuhHC?=
 =?us-ascii?Q?RuVyulGC5z4qppxoK+qr8sETec507SqEgFwxbNd9YT+ExyWbkTrmUw6fA+Mr?=
 =?us-ascii?Q?uNv5TTjh1jPPddPzoGxR5NkXoKYeKgc/NLahJirNMDhE6MqlEJGdMct18C+z?=
 =?us-ascii?Q?a0IqaT6ZOgPFDP50XxXgZ8TavwOyGO/cszKtk340SLa7H8AWyol8DxSXqBkG?=
 =?us-ascii?Q?X9y5WyHAjgoI9zn2syrZOxGKBahaeF2zj0q+YEuviArJs//krcL+NNv+lUGe?=
 =?us-ascii?Q?fMZyVe7OnLcMPBlA3W9fPWlQJiCaDjYJdrwjB/F23QAR6c15jPa+jhKBrtdj?=
 =?us-ascii?Q?SSpuGnE3+4XKEqO3wA9yR+vt6rRGXHo23bTHpVF9aAaaabSmEgalGj1aJEV2?=
 =?us-ascii?Q?C8iCfj/FG0kEnYRTZTi4KJFu5GwqYYhxLe7VcXoysxTMo36kxYnj230MI1Vj?=
 =?us-ascii?Q?FjV6iQE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 12:43:46.7426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: add08865-ac18-4181-0b25-08dc75a5d41b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709
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

Add support to set XGMI PLPD policy levels through 'pm_policy/xgmi_plpd'
sysfs node.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2, v3: No change
v4: Use a macro for XGMI PLPD policy type
v5: Use a separate sysfs node for xgmi_plpd policy

 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c             | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 4adfe9f0fd92..ac76bcd81a5d 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -276,6 +276,7 @@ enum pp_xgmi_plpd_mode {
 enum pp_pm_policy {
 	PP_PM_POLICY_NONE = -1,
 	PP_PM_POLICY_SOC_PSTATE = 0,
+	PP_PM_POLICY_XGMI_PLPD,
 	PP_PM_POLICY_NUM,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f1d3423409b4..d47a646c680b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2373,9 +2373,11 @@ static ssize_t amdgpu_set_pm_policy_attr(struct device *dev,
 #define AMDGPU_PM_POLICY_ATTR_PTR(_name) &pm_policy_attr_##_name.dev_attr.attr
 
 AMDGPU_PM_POLICY_ATTR(soc_pstate, SOC_PSTATE)
+AMDGPU_PM_POLICY_ATTR(xgmi_plpd, XGMI_PLPD)
 
 static struct attribute *pm_policy_attrs[] = {
 	AMDGPU_PM_POLICY_ATTR_PTR(soc_pstate),
+	AMDGPU_PM_POLICY_ATTR_PTR(xgmi_plpd),
 	NULL
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index a35ffe5d2021..84ec4ae3d6c5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1574,6 +1574,7 @@ typedef struct {
 } WifiBandEntryTable_t;
 
 #define STR_SOC_PSTATE_POLICY "soc_pstate"
+#define STR_XGMI_PLPD_POLICY "xgmi_plpd"
 
 struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
 					 enum pp_pm_policy p_type);
-- 
2.25.1

