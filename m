Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E70AD132C8
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 13:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 147BC10E43B;
	Mon,  4 Nov 2024 13:50:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VZNuffjk";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 449E810E43B
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 13:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xM5BLT5vSRGA8DyhKAWEuWO6IrWz7DlTyzCES/A56XEieW2KwayMRAZvtQhRRKftrz2FKnLjk9K4kDyJu2NqX95io4Esrnu1b25F9MrW/RuK/M0VA2g96nkzcd7tYQi/H/88G5ArvR8MYmiTxdYFhZ9PfSL0E/qpLBvBzOUcC3PPPSVpQ9XRLvObSMJ9eA8jjA3IOlVip7EIU5QqPdCajNVtpikUvfIGQGlqW3d5q6ftnEZP9UiOhwd7PSsBQjeeaxyOYDT1bhEsfuoHNMz4UYpeUIuNN28ru79gaALAX3ZbdKVKJC2xVvTv7FFJJ2snOUsuIX9LZLnftTVpq8ab4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPrj0/lcdttX+LgNzrbRfLMMkzfPIRxo0vP7/ZOPIO8=;
 b=If10oj7m6/4fE8gBenXWtyJ0igQkZtspQr7Opr7MoVvAmASnCqj7dXe3849cAyd6Uj4K857TAH5aRA5p5eXa8Vo+En4X+q4m3Zsr1rkhV9LhaCh7TdS/XSJ4GDonZBQiARqyXkybfyI4iUoqjbO5w09JH+dGJU7r7E+MVb/zVaz6VYIRglW+ofYO32UXSdwAK1EYQwGlxH7WhrYQKWjdKSR8RFXRQitwqxKFh21abDnkpsS8TNP3Np5UG9dahVX/R3IzcKYqU356zjrEVDzAIg6cOVUqt9Hpm5pLk+MKD7kX3rA2gd0kvngwbX6GiEE7r8L6QnbyqCYfnda33VkRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPrj0/lcdttX+LgNzrbRfLMMkzfPIRxo0vP7/ZOPIO8=;
 b=VZNuffjknrPJ0bvxHTHZ/ID2atvpgPu/gWBPRuaVnphyObBJn3MXCpEXIxJDnGV/PgwVy26rkpdq7BlsytmAlOnC14yWFRBXQ421rkrxLRMcOU+3JadQQZxzthit50Xxa0nnDI/vx+yOCDYlUtCh/835N36FlxOz1C3L/jQ6et8=
Received: from CH0PR03CA0417.namprd03.prod.outlook.com (2603:10b6:610:11b::6)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 13:50:04 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::f1) by CH0PR03CA0417.outlook.office365.com
 (2603:10b6:610:11b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Mon, 4 Nov 2024 13:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 13:50:03 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 07:50:00 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH] drm/amdgpu: Add supported NPS modes node
Date: Mon, 4 Nov 2024 21:49:47 +0800
Message-ID: <20241104134947.663648-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: ec205a20-87a5-4761-c2ac-08dcfcd795b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EEy+YCd1GwZKuTRywsIlCgDMMPtvMmMxg/KXyKwkeJLWQ/MQLB6KTru+8k2o?=
 =?us-ascii?Q?HVfs1XZsUKKG16TYjNvT7IJi3bk1ui41yD5SYtaZHjajLkGNmB01xQH1rxrX?=
 =?us-ascii?Q?V3E4GU/C+iqiJclr7hzDtWu9DfF4zMBVGkPN0k/yym2bXSYcWzZX4sNtVvbV?=
 =?us-ascii?Q?vcqUj0ODPnnAWeIYAtDJ7e/OtjHkvVqnZ4VHWgVU1qJkg33c8AgSKg+Hyaw+?=
 =?us-ascii?Q?nnesFdGNVa4FBLYq4H8fhy3moL74OgoWuKwDcCeb56OaNTqD80T1rOESdVFZ?=
 =?us-ascii?Q?9ZezNGzMaE+zjQyuwvcylbsLrqPOn0ogJQ4ZZEFduYqBWqoOEZWdgzosYUYm?=
 =?us-ascii?Q?WZm7ejL1nwRdsC4LLpqXo2VB2FXn5pI1wgL5yBgbXIJngqTNw5nOK1EzNYpe?=
 =?us-ascii?Q?mfibkIiSNZ1qqkRgYwy5KmZYTh7M2TMSCH1Kv54MBDWgkGA/aqRM3dq1uL88?=
 =?us-ascii?Q?Fc96JsxBZSD6ZNfCeL7eITSS3e1Xehfnokca08+dMfYiTET9oEBjlXpQAEBd?=
 =?us-ascii?Q?XjOH8xkEn33e61WGfp7lWzPI+a3Sm7+p+H7MeUkW/Kr7OIWxcKq34d761lC+?=
 =?us-ascii?Q?lRRINAMZeHNnjQLHFgsMUdl0HBYJsAfOR+MuqwVrLvzLc5xKN7iMBIR5Vvwc?=
 =?us-ascii?Q?GLgwYM/oP2VdvS2NdHl4K81yGJuItxZ8st30QO5QIwwuAly3FPEda/j2TWqS?=
 =?us-ascii?Q?GqOPgPl7pF1Ny56jfUzhZupQ8s1T+4f2pb3CudghYgZEHwD1vhgm0Q9Q2C/6?=
 =?us-ascii?Q?ZGxBRCcie1z389c1C3/O8cA0fFNBAUSD9JWcRVnslQnQbBo4rLKyv2ia72Ge?=
 =?us-ascii?Q?rNAwLNzO6ICOQeOdELJZKLK3bIXen2kRNLuB0bk0VkvVzmNKS5eW/Z8HcbLG?=
 =?us-ascii?Q?mVRcHl5c/AKoGom0YIPtjR5oG8483j9Xz5mxW+/Ul0lRnCoQuvPDjudJ9VTl?=
 =?us-ascii?Q?1x7ApdVbS//2JmGkSRh+HJxeyYmKLjyZkv8bqT+Gq0hMsZu9TXl4Jn0eLipd?=
 =?us-ascii?Q?+GZTk91StsfPiHM7hgnhL/XiBFKW+sQmuN326vFd+30hQWc5B2AU/fBYh24v?=
 =?us-ascii?Q?zpqAr/rmZ/UNUTvwKMjmIh7oFcP+Kw7dn33rQhyUfcWL6hEBRE0LwhVK9mcC?=
 =?us-ascii?Q?yonjHlmTAbMwwlQUpoR5RkVsuxi2o6z2rnUy5MwnefqZsbpy1DelmR+jpjx+?=
 =?us-ascii?Q?lH7/mGVYLgDqTpkXyhsWJkrUg+o+kJfRP8NWurYd/w2Uxun3piE+cRykkix3?=
 =?us-ascii?Q?uVUmZR71xpWBJCdsKaAov3F0D2BsjxBdhfjKBLo3HmE2tzyurH+xqZFSY09h?=
 =?us-ascii?Q?JNoEsbXNtEVKOS/K281YqGBg7P4ivRrqewT+NRM/A9Ve7cZ6JsDKhpF4FMf4?=
 =?us-ascii?Q?YbACwgJxTi663C7JiruGBxdZ8yJ+nlqJXVFsQVi17BHzeNCPFA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 13:50:03.8740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec205a20-87a5-4761-c2ac-08dcfcd795b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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

Add sysfs node to show supported NPS mode

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 83a16918ea76..5e1673b1a30c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -471,6 +471,16 @@ static const char *xcp_desc[] = {
 	[AMDGPU_CPX_PARTITION_MODE] = "CPX",
 };
 
+static const char *nps_desc[] = {
+	[UNKNOWN_MEMORY_PARTITION_MODE] = "UNKNOWN",
+	[AMDGPU_NPS1_PARTITION_MODE] = "NPS1",
+	[AMDGPU_NPS2_PARTITION_MODE] = "NPS2",
+	[AMDGPU_NPS3_PARTITION_MODE] = "NPS3",
+	[AMDGPU_NPS4_PARTITION_MODE] = "NPS4",
+	[AMDGPU_NPS6_PARTITION_MODE] = "NPS6",
+	[AMDGPU_NPS8_PARTITION_MODE] = "NPS8",
+};
+
 ATTRIBUTE_GROUPS(xcp_cfg_res_sysfs);
 
 #define to_xcp_attr(x) \
@@ -540,6 +550,26 @@ static ssize_t supported_xcp_configs_show(struct kobject *kobj,
 	return size;
 }
 
+static ssize_t supported_nps_configs_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	struct amdgpu_xcp_cfg *xcp_cfg = to_xcp_cfg(kobj);
+	int size = 0, mode;
+	char *sep = "";
+
+	if (!xcp_cfg || !xcp_cfg->compatible_nps_modes)
+		return sysfs_emit(buf, "Not supported\n");
+
+	for_each_inst(mode, xcp_cfg->compatible_nps_modes) {
+		size += sysfs_emit_at(buf, size, "%s%s", sep, nps_desc[mode]);
+		sep = ", ";
+	}
+
+	size += sysfs_emit_at(buf, size, "\n");
+
+	return size;
+}
+
 static ssize_t xcp_config_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
 {
@@ -596,9 +626,13 @@ static const struct kobj_type xcp_cfg_sysfs_ktype = {
 static struct kobj_attribute supp_part_sysfs_mode =
 	__ATTR_RO(supported_xcp_configs);
 
+static struct kobj_attribute supp_nps_sysfs_mode =
+	__ATTR_RO(supported_nps_configs);
+
 static const struct attribute *xcp_attrs[] = {
 	&supp_part_sysfs_mode.attr,
 	&xcp_cfg_sysfs_mode.attr,
+	&supp_nps_sysfs_mode.attr,
 	NULL,
 };
 
-- 
2.46.0

