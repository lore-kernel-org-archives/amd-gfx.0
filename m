Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AABD3E793
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 05:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B058E10E298;
	Thu, 11 Dec 2025 05:16:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YA/lyJpu";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903D510E298
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 05:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGvV704kqrkdkwLcvOsnWmFhjcn1uhEOj0mNTWO779DMW8iMtPc0DlyXKMMXBNSMfUWMyg3hgkjRUHjTbHTVyMNHfbogK3HVUcbp6rgaoSdIRsZoCxHI7X1HObl+7kclDTv0yXFgoYXGnaXD49YuIGqNVtPydaVwqj+Hso9REmyEoedfU71sZPWFmGOg//j3wuDSBtKG4uuxi/BIhUFNaMvlqsLAylBKRHa8wynrWflzUiQhDj5qSZdyxnO4P5TCojVTp3qGAktzhg8GLjtXmvXWCJi08FHwgQ7oUSov1+BQYZlfCdzeR6gzAkwMTAD0U7jVaXw9VXVdVU6aO3ccMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsRqhLtiSxoLtNVIRs8b6+Y8iHY0gMNrCYz4igKpSuw=;
 b=NzuX2033CQE9FkDCRrtc5IK9Notp3YmfM3zqQfa9CKFfpHuEvME7aw3zB407g43ypOVe128M8aR9CTrAe6e+E9e+7E6AtuC8ZI8NXGqt+WDF90+E9NxfT2tlvjwzP9Gt/O0q6ikh08Yys6Ta/irVNKbUSXx6c58WMGMXRbL1QGjsFDm7pKfx1oX100rC2yv5Xr3z/wP3IVkdGj0ktVHkXdhxh5dacuA1o/+cmLGVd9lMgkFH9pyz3DmsH5lBOkndl3IO6fQxLjzYbOamxYNNO5DP23l0NdBNgTrIrUg36KN+3IsQHLj3EgbOsn2xG6scvh2ynDD6RPFsdpnZANK2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsRqhLtiSxoLtNVIRs8b6+Y8iHY0gMNrCYz4igKpSuw=;
 b=YA/lyJpuMsb1/+kBvpg8jRIf3JWvXdqpNQI6KKdmW5djiJAOzCFWLZVTvBv0I7tO4JhKj2t5lIcd9HsdsTzQBhOSFpbvx336hc/tDWiCG1Y7+nz6K3P+PVFflmaftnCSnSs56KQlYRNoU+ae69yc2VBYyzAvJx7lsqkBZxSL8Nc=
Received: from BN9PR03CA0939.namprd03.prod.outlook.com (2603:10b6:408:108::14)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 05:16:13 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::f7) by BN9PR03CA0939.outlook.office365.com
 (2603:10b6:408:108::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Thu,
 11 Dec 2025 05:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 11 Dec 2025 05:16:12 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 23:16:11 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amd/pm: add smu pcie dpm cap & width convert helper
Date: Thu, 11 Dec 2025 13:15:52 +0800
Message-ID: <20251211051555.652129-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: c415d43e-4782-42d0-3254-08de387466fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g28VY6gclBgILKe+BdEaEcdobyouHPTkCj/uRtpjRAbaObu3yBUa1MrlvZl2?=
 =?us-ascii?Q?kLKrEtkfSDfyIveTBxAhXy9qUXKbFpfZfXDsQlQCRrq8yALYa77uiJOuBpAG?=
 =?us-ascii?Q?c+y3h08kOTQBOBHjVPzWpil6RxICtzv1kIfH6rv8oZfLm+PD+i8STCqyPLJh?=
 =?us-ascii?Q?eYK/UpARc9ZpP5tvsDCAKQ78oIiSF0kbnEo7lZZOrPwpwi23qt75W90e3AKO?=
 =?us-ascii?Q?w0tfQ1TPypglrjOxyVf49OhPHblxzFeo0O62wSjL7GJJj9sS9wSdA5OUHLnm?=
 =?us-ascii?Q?MYllwE+IzcPIoRKnm5cT380m9mkXdEgcfIHWhICIvyEy6N7Te2k4FQZQKnSb?=
 =?us-ascii?Q?JzhNhXsZ4jtbfFZg6b2XOhofNDefl2Y/aLgMl5Xrc1yURPfmFJ+kV3cNe+9s?=
 =?us-ascii?Q?R1xTS7Xu1TnXUg1n6ryzLo6LbcXWI6FsMpR73cIzDyOSKyBxsVATckqPd+bn?=
 =?us-ascii?Q?tBGcL7XZXuZMKccf/AlZrg1TfQ97z7bhHuIjERYHlJsozmll1I1of4yALK9d?=
 =?us-ascii?Q?5p7/Q7Hyg0FMsmEaOqp4WZQfm5RM7psBIx94eMvyE7HHJ3CtHHXPqv1BgqTY?=
 =?us-ascii?Q?57zdH1ghPkUBQsZEMEVDvPI3v3Zlsugo33TJfBUZtzcjkS6MuaZ7EuIaacVW?=
 =?us-ascii?Q?+HkBAOZMXlod2/8qm5tLL2xEfiQA9ea8yaWgWiTOexv0aNn+W/iZzUx3xqP9?=
 =?us-ascii?Q?TnAI+e3FTDYZ7ZMnVg9j9td1JDRFxU07PKrQDJXaukO16kpzPpKb+oDOBUCK?=
 =?us-ascii?Q?puGpr6yvINq/WUVn+3urU+r7+k+sESR/3Pdjf+ZfUVZVy3pPzfUefWg3exxX?=
 =?us-ascii?Q?Mxp6019m3T1tv24oNes91tjfC8Sqbd5ivI/QFm3GfAFA6LsqYa9PBlD8cYD7?=
 =?us-ascii?Q?nbH3j0jtX4T6f/8y9VQeiBqh3ZvN9ar4Zn8ahweCF8Ic4gUpTA/3KFz0Kfqa?=
 =?us-ascii?Q?Avh+jZ42bslhy+h/Jp/bOTzu+ej7LevIz/HRvhhnHbJvYKzAay8aLmNEDZ92?=
 =?us-ascii?Q?izTym7klbyRilYY0rPsvHD5vNGnB84ZVjEUvMOt+c9NfVo25917Ule4lqRVK?=
 =?us-ascii?Q?LxYTql96kP46nJojDCrsjDmAmrGrTs/L1KcxKNfvAhoUGWrZx5a1Z7ooFSpK?=
 =?us-ascii?Q?AwKC+bQQD4eGk6LO995BLoaht/595YoY1xtzX+rvZhMgRYasin6QVHMJYeOz?=
 =?us-ascii?Q?4Ed8uT6+KgpOY1UA9CLZ+Qth1GVist1g2G1LgjNyyBUT4KUMDXSvFg9Gshh8?=
 =?us-ascii?Q?amciAPbUlA0GZx9nEwTFYJv7nqj17BnQCKfbB3tJsozfdCiCy3edfb5io6HD?=
 =?us-ascii?Q?hO+qOUvky7Qk/S6aK6vFZ6WlZI+91qI4ZKNwXCoeskJiJQxiff4mCeu3iDc9?=
 =?us-ascii?Q?4I7ifF61AARNc3xyn78iq575nU247n8TZDElYZhp6tMrIzS2/21TZHBgoojT?=
 =?us-ascii?Q?2i6s3hW0M2TeVnDb1ktk4efjW6OKtaYJF/9cq8liC4oDINY8sEhw/vVA9kPp?=
 =?us-ascii?Q?HgpVtY2mLDt5bVy75SLDmUO3PM02yCPwPqStGmUEGEIgte5+k4uxwHDTKC+1?=
 =?us-ascii?Q?3hYdMdTaIFsvkerX398=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 05:16:12.7969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c415d43e-4782-42d0-3254-08de387466fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
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

define following heler to convert pmfw pcie dpm index to smu index.
- SMU_DPM_PCIE_GEN_IDX(gen)
- SMU_DPM_PCIE_WIDTH_IDX(width)

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 50 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |  6 ++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index b606829a1f3f..732dadc4ebbf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1346,3 +1346,53 @@ int smu_cmn_print_pcie_levels(struct smu_context *smu,
 
 	return 0;
 }
+
+int smu_cmn_dpm_pcie_gen_idx(int gen)
+{
+	int ret;
+
+	switch (gen) {
+	case 1 ... 5:
+		ret = gen - 1;
+		break;
+	default:
+		ret = -1;
+		break;
+	}
+
+	return ret;
+}
+
+int smu_cmn_dpm_pcie_width_idx(int width)
+{
+	int ret;
+
+	switch (width) {
+	case 1:
+		ret = 1;
+		break;
+	case 2:
+		ret = 2;
+		break;
+	case 4:
+		ret = 3;
+		break;
+	case 8:
+		ret = 4;
+		break;
+	case 12:
+		ret = 5;
+		break;
+	case 16:
+		ret = 6;
+		break;
+	case 32:
+		ret = 7;
+		break;
+	default:
+		ret = -1;
+		break;
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index f458125e8d4e..3a8d05afa654 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -93,6 +93,9 @@
 		header->structure_size = sizeof(*tmp);                          \
 	} while (0)
 
+#define SMU_DPM_PCIE_GEN_IDX(gen)	smu_cmn_dpm_pcie_gen_idx((gen))
+#define SMU_DPM_PCIE_WIDTH_IDX(width)	smu_cmn_dpm_pcie_width_idx((width))
+
 extern const int link_speed[];
 
 /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */
@@ -212,6 +215,9 @@ int smu_cmn_print_pcie_levels(struct smu_context *smu,
 			       uint32_t cur_gen, uint32_t cur_lane,
 			       char *buf, int *offset);
 
+int smu_cmn_dpm_pcie_gen_idx(int gen);
+int smu_cmn_dpm_pcie_width_idx(int width);
+
 /*SMU gpu metrics */
 
 /* Attribute ID mapping */
-- 
2.34.1

