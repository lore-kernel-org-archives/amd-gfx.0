Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD605C25B7E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 12:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F0310E0BC;
	Fri, 31 May 2024 12:34:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="inbZHm0A";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFE5810E0BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 12:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sc0Z0c8r5xmMuNa3/w9IEcPAdyjyWdaHqOgGk6c+DXWAsp1n203UL4q8MIo6C1p0qPzozlE7S1liFPGoEk069TJP4oCq34UxtrUg/5ISLpO28UUhqmQKJ8UatUSEkoOCcUcngrEWIl59P543Uc8voKI+njU5J5ni33mQbfiNZtHeNveJydZklzYGs8YgDcduCrNHe7s6J3MWaJWbTTmSd/QEl12UgIb3YLBAPvX/2emujWME65a+7uZiCRolQjXFFQbnRSTJmKNEWM8xIzKEtIA3ee7GHNlqd5ar/YuJehRep3I3k7fb0Q5M6uiy5DP3zkLGuFREl4japCbeN1z0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+HYTlt0igLet9NhCbSGFU/K1b8j8G7ieJ16Da2d0NQ=;
 b=ZCz/IfT3eynsv1JNu3XDHzLBBx9Ys5xVwjAwWWE6qiAUKpwhfTxLx9QsVGySGLp91SsyQzi52thI2uWRmk9E5+02PbSUViRDo5OfaHVPZX/im6g+veAEhRiNsSWyQ5q0W/hosLYQL098dwnZ0P1fne0MxEvEQIvch5lJebr3hBccrFOTNXjUkQ+tFfcUSSqKXhC4SDG9o5Yu3UbjKG35zHFV4LanRUhExfGNBkpf8NbxBE28kgdXNR5ujWyjipxe0rzH3qbxvgBTBkmEJmgw1h5xQxzQUDYePU9WFXn6WXLwtKO/L+ot1x3uEMNyx+OZUe40DcUnVNzOEqysxHBk2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+HYTlt0igLet9NhCbSGFU/K1b8j8G7ieJ16Da2d0NQ=;
 b=inbZHm0Ag0Iv3tR/+9ptBObdcxDTV+4O9JwVclOo/8hEbEFm4q3sdFyfhmLPOYUn0YUWBBS8XHyQmk+McJYDePsPEadw5oueBupS27z/FKytqqNq4zepfL3Dvo1u1P5MFy2a3OOimsGeSwWyuivCvTxRZFUoCQjIEWI2Bc9M8hA=
Received: from CH2PR18CA0034.namprd18.prod.outlook.com (2603:10b6:610:55::14)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Fri, 31 May
 2024 12:34:26 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::52) by CH2PR18CA0034.outlook.office365.com
 (2603:10b6:610:55::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24 via Frontend
 Transport; Fri, 31 May 2024 12:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 12:34:26 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 07:34:23 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <sukhatri@amd.com>
Subject: [PATCH] drm/amdgpu: Skip coredump during resets for debug
Date: Fri, 31 May 2024 18:04:03 +0530
Message-ID: <20240531123403.978597-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 699ff376-5da7-4f67-df92-08dc816e022b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SU50diCx0tsIfl3guFVJ5h27Ln/pabrnRRXIJsE3V1NM8e7Puw4zMk7m5Wtz?=
 =?us-ascii?Q?2SgOMLfakB5/osiTMJOJuyw1aDNzx1S7DJVXMicTanvRkmxH5ZKX3bULcrNN?=
 =?us-ascii?Q?SXbszku/3UX6H1bAvtx48GbpPzu4duZS9bPHoOUaLalBYwczX1+CUy+rSH6h?=
 =?us-ascii?Q?/y2o6ann2fD6slJhRU+2zqYvqqmn2MPR/ZcXD93oJb5LRCdJ8BiPRbMbCUhr?=
 =?us-ascii?Q?iN4cShN0pY8+OfegEEshdmHzsEDpMJAsxWGKlfFA/hfdUPKYh3jcRfoQsntP?=
 =?us-ascii?Q?sj1rp8XMTMgP6u2q/T/ICBmIJxZ0TpBhwVWlZM3lFitcQ0COr1fucDydQvYS?=
 =?us-ascii?Q?s8++6zHoy/8nggG8X5XejDKzmyhH4+huB/giQO6HF1JQGXr0cmhtKxRsTbNg?=
 =?us-ascii?Q?fTPn8c9y6V9RoWDsud/8J8kVkCsfpi6qz/RXJqNNi44UgGZzfgH6Kx5G5m+M?=
 =?us-ascii?Q?n2Y0Y/MOOOQsIqROM37qTleN+s5bp6QGZbTKZGDEH8Ibo0cMDRhvhp5AV00X?=
 =?us-ascii?Q?KPVWLl8YPxLmZ4illULNvVn/ZVz3jo0yxXiODAXYhe590MuNtB/3fr/IHxxu?=
 =?us-ascii?Q?gUcfRDESp+j/QvCL5KfyPyI/gg42P3Sn+C+b585+Xc5+WWHoz4OMdv0VyAWN?=
 =?us-ascii?Q?sYrigXn5wKSC4lrMHE+R7cfslgLrelPUisdlNaTz4HVfmwzmiHpMUQUoY/yy?=
 =?us-ascii?Q?UiqtcJU0TXNEHu8r3x/UVfyCc40tl9Ry8Y21xH+tR+R2Yazd8f7l+9ymZJxd?=
 =?us-ascii?Q?tFJlcgV/mvjfGcwqZIiSBg5XmZaZ+wnXKX8Ju1Tb/O1mxLDuCaLZbzfrgNQF?=
 =?us-ascii?Q?I4mQ6JDpRsBIscwhW5lpodHswuL++Cjt3hyq28He80YDXjfPA+25tKEJqgot?=
 =?us-ascii?Q?DU64ugaxzoO5nxyglOooOfOvIbX1ZdWzdYofNk4NYJlujJqxVjOKJhA/Cogv?=
 =?us-ascii?Q?da5E8UWqiJsEc87hZsilOadmXCVhQvkwollnCNKP3NhhxtvCnFm6+1THkCJV?=
 =?us-ascii?Q?jVBr1xIbY3xAuQv+XnriekMWgpDyxRJSLp2Mw8+dld3bI+MrahkKqA/BLlgU?=
 =?us-ascii?Q?m18YxIabafxy7/EiYrBNKrCTlp//5ltiidB3GzhUPF05MSqmqMJdD/9ysbmY?=
 =?us-ascii?Q?tTQENMZt10VDQW5eaO3psamVajgJhYNPeXUH3wYqkDDqd9IEkOBlBZ4h5YeU?=
 =?us-ascii?Q?sRsK9pe3Oc+PAeZytmOUHBZTwgDBlE7uZuq9FBLO3lZjFxJiwpSYAOTjPr3d?=
 =?us-ascii?Q?5XUtoHVEyAsuEeJEDnvVFQwHGoKYQf+UBbwj3GZaQLvNkqOJgsVWV90B4j4M?=
 =?us-ascii?Q?YnczleIrqBmLRuEDVVkHk7ojhZIQKB1r9ZRdBpZT5i4xqTRubh62cXcGnn7I?=
 =?us-ascii?Q?yGY9u3y6APzOxk0455fTDhe6wXyj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 12:34:26.1958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 699ff376-5da7-4f67-df92-08dc816e022b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415
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

Skip scheduling coredump when gpu reset is intentionally triggered
through debugfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 10832b470448..1a9fda1d20fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -981,6 +981,7 @@ static void amdgpu_debugfs_reset_work(struct work_struct *work)
 	reset_context.method = AMD_RESET_METHOD_NONE;
 	reset_context.reset_req_dev = adev;
 	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+	set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
 
 	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 }
-- 
2.25.1

