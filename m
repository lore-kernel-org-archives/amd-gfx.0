Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2261C47BE0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3804D10E3A3;
	Tue,  6 Jan 2026 10:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YKLCulgc";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76EC410E3A3
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCJcwtvkd206EJOzJj4nOFfLHJFELMpq7qhIRDFFSlG0Xu1XQhI0RDl0StCwYiVnKGkEkOEbcmtG/8Lg5zbDLBTFyl2mrrJeMN1a0H8t7DV7frEraYgU2ZGOIyKkzqkDBrCMmiD74K3Pl74fQh3rI+E4D4hW564jqWsG4s4ZP2ZhgDG2YXbyr//zB0/eQo50rSRc70GxE8OTCAvOent2cxs9YGvftq0CwzIdxsXAV9Zzcu/wCwtGesWdsVctKurx2Lse35rOP7sqFQXCW5ZQZZbmMmAUzYrj3Hckl6F1J1nicAgsFcJO+jTRO6ohZKvfvTWTCYzKW3banz0IVpqb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaU2GRE9sHOl7n+PYF3vsQJ8SuOSoGvIjrvK7AbS1rg=;
 b=lD9yiGyxbkLzbnVzPP6hmhS8wpfBcgI7AUDeqMU6pZcRJHeM/Nv8NlIZBcfy95iysHvuTuiExXudL8yga0PWcWEvrDFB+KwqV78VRFoo39DmLLGN+SrLbd+qc5sMCNhbqp1qMzkvMFZEQu+9U30qYPyYAZzsbp7xNOqLbk6BYItVDcvAtC/y7ET26I5PIqhRO9xlgiwl3+x6AdAeawFRk1+r07gw0/MH/tQf9DGumyCjLuJ2ZqtVEcb5gBk09f9aqaH5yAtftsWjLl7G3VVembmhtM3BxYLHNXGMcbGvvpAyebzXMuNsCNtx3QqbIvjXKPCu3P5b1dHyKoOmhqgz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaU2GRE9sHOl7n+PYF3vsQJ8SuOSoGvIjrvK7AbS1rg=;
 b=YKLCulgcxXVvqq+QGbKfvnDZxKTDocQKV/8ic/SZaO0WDsumu8xrbzWjkdAzXlT/Zmok9dtGYPKS1BfgL86Nt3rAl7fSOjmuwSHHSnDgiwcOfFbu093o6BugLE5ucWs/aZky17daSY2RHBfxpxOB7UEcyNKstXe6A6o6gxjmyJw=
Received: from SN6PR01CA0015.prod.exchangelabs.com (2603:10b6:805:b6::28) by
 SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:13:44 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::99) by SN6PR01CA0015.outlook.office365.com
 (2603:10b6:805:b6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 10:13:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:13:44 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:13:41 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 03/21] drm/amd/pm: Add message control for SMUv12
Date: Tue, 6 Jan 2026 15:42:23 +0530
Message-ID: <20260106101317.3856153-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260106101317.3856153-1-lijo.lazar@amd.com>
References: <20260106101317.3856153-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 27702510-f5c6-4e61-652e-08de4d0c45f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w+9TvG3mZpn9yJMZwul5HwHXpOHBEhRuCT/nmd8JWaO6D3brJJx2vE+LroPx?=
 =?us-ascii?Q?VzUyQiHHcWw8eRFm/ItxLzTPWVgprqYi7Hw9nvAscALPNcn8W4e6Q5pc7ZMP?=
 =?us-ascii?Q?DxPg9QF5ndMz+g+MWwbzZ+LKbdjxQrrguyrTsj+FNV19ZQ1Qgv9QSlxwtJ2T?=
 =?us-ascii?Q?f4pJjboaHM5mF1OYJ4KkbyjGQFPJvQWOnofpEcwk1TM+wVLK6i63DTnUmz5U?=
 =?us-ascii?Q?sv6cvZQHzim7gN3cWPLxUWVHo0FSDYcI59x4I7pqWpUG8u+sT+rubN++QzBO?=
 =?us-ascii?Q?a4QuRuZ/GY5LGGiAjlOLslc3Eaw3/XtH/607FxpMJzi2ABvEnGVqeujuSx+j?=
 =?us-ascii?Q?ZVE1heFyfJDZhLcfrTo8F8HIUmWQTlLfg4YD/rKPI7GLMOA6nkwDhZNV2drg?=
 =?us-ascii?Q?05SzNQfvfVQw9JEmo+sCd3Tfjynzdj6sgDhSzxJ503gmc4OxHvHn9V94i4Uy?=
 =?us-ascii?Q?r/g2yyE7sZh1c589sMyY4FciqcZ3qTMQkv90hcWh/wCuv7vrxZP0CjvHcQAf?=
 =?us-ascii?Q?HgqBxv3bhA0QVQpNF0Su0KAMRDmztCbG+ikpSna0x9oMj9Wlu0aHy2buMFvT?=
 =?us-ascii?Q?HVjHZj7dxX/fPkb8grBICpWzqBOrlipkJu7md4cHsQsyvlonQi5MpzVnY67d?=
 =?us-ascii?Q?X82b+qSQccrBgAiOMI3iBcMc3iOciqvRj3WIwsCsUePFfWzbjoOewPCpdJYp?=
 =?us-ascii?Q?oE9pLPE5hsz4OyUXZ54rzG1mFsOXllmk3tVfAxWRMQPfN74/hajWlmcT1BPM?=
 =?us-ascii?Q?e1rx2O8gJhb1kC7/pcBfILfQZdDmZk6klMN9EZ/qGC8uzY35487hvk4lLafV?=
 =?us-ascii?Q?Yw66bRSkwz82jcJJ/g7Cr3lgYeGbeS6XHAM7oKCbjxsk1oPzGCgtlZrnHomU?=
 =?us-ascii?Q?9EB5esyHEZBs4VoGaVZy2upSQ0fybBUl0j7LfklJYoYsdllZMh5XT651aywR?=
 =?us-ascii?Q?nG9HauvlDLAuffcGYMuGp6EeMIk35LwLW/eY3OBk1BUltx3wShKE8CizLIPI?=
 =?us-ascii?Q?oTQlsQ8Wxc77KTk8De7WHylshXl8eUc54uj5AZvQ7PTy03PaT93mkXLd5PvK?=
 =?us-ascii?Q?D9bggVv1mwpcQfF4lC8q41aqbRCwHr4U3dgQ8903fBc1k30nwGmCj7I/Fbz1?=
 =?us-ascii?Q?6kYR0QpL2bMOiJY6v0zkpMvD47nn10IQz17Tc4QtbvUNBROv6gDpDmV9QwRj?=
 =?us-ascii?Q?zjlUIirSamESSqzpxCNONAEdJUzYFKKh+y2oBq/Ysy0wbwRGlN8dDi04pwru?=
 =?us-ascii?Q?DN5x+4ZGNbuYkJah7gz2z9s6BtzRbKMRot3z281YXXfPPBSXY9p3GVtrdDoM?=
 =?us-ascii?Q?aZ/KzlwQuesgb8CTc+rzPYdZYhduHZiU2QxNNiERkRvHaMCh8RGYASDdZhfH?=
 =?us-ascii?Q?IlIT1pPkEr7Z5ui6BQWak+4ffKc7Db+2PKc4q4SSxVkgU/eRUhAkE/44WKd1?=
 =?us-ascii?Q?QhqAK3/E8+T7mmvFATKeQC4AKbzPpo5Vjo7AvsnuZjDL0GeFNuteKDRFQE47?=
 =?us-ascii?Q?9V+2sPNWkMwhryNgEkKuipGTFhXbZO0HDHMQuLYkRAfYOGhL9PpF+dFfSdYo?=
 =?us-ascii?Q?Xx1Ojmj20bro+wH5UqY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:13:44.0871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27702510-f5c6-4e61-652e-08de4d0c45f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
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

Initialize smu message control in SMUv12 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h    |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c  | 17 +++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
index 0886d8cffbd0..fd3937b08662 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
@@ -62,5 +62,8 @@ int smu_v12_0_set_driver_table_location(struct smu_context *smu);
 
 int smu_v12_0_get_vbios_bootup_values(struct smu_context *smu);
 
+void smu_v12_0_init_msg_ctl(struct smu_context *smu,
+			    const struct cmn2asic_msg_mapping *message_map);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index c72ddef3fce5..7e41991f140e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1507,4 +1507,5 @@ void renoir_set_ppt_funcs(struct smu_context *smu)
 	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
 	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
 	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
+	smu_v12_0_init_msg_ctl(smu, renoir_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index 942bc3b0f700..2c20624caca4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -405,3 +405,20 @@ int smu_v12_0_get_vbios_bootup_values(struct smu_context *smu)
 
 	return 0;
 }
+
+void smu_v12_0_init_msg_ctl(struct smu_context *smu,
+			    const struct cmn2asic_msg_mapping *message_map)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	ctl->smu = smu;
+	mutex_init(&ctl->lock);
+	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
+	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
+	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	ctl->config.num_arg_regs = 1;
+	ctl->ops = &smu_msg_v1_ops;
+	ctl->default_timeout = adev->usec_timeout * 20;
+	ctl->message_map = message_map;
+}
-- 
2.49.0

