Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8545CF9C6B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 14:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9972B10E6D4;
	Tue, 24 Sep 2024 14:16:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vTVIu/zq";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2751710E705
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 14:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N58LTv5GjbtDUHBuom2f6cEt9fJon0NWQ18WFKuC3Tm3qEoVT11hwl8lvDFdF6S5YzhsLLxUKwwoRqL4b+P84o2L+lACj44Cps1s8mCVIGJ+S0KebT6oe8pZBqyd3XJGQhfSDo1sE9MMYGQa0o+qlryEI0/9DyFnTmY6lJOhC+OK2vo1hAXzZvr/jpG9VU4kSXgRBzn5rZNKGjlTe4SpccxnybTbMdv4oXui4anPK5H3aCr9+WPlk+8rS4EpT+3x61e5f1p+v71ARqJd9u3OmOYo/KC4okPTId330jHNoLL+Y3sGT5tR/eByW2p3n34d/68gF4O7TlSDxgJR3hY0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cPukSLqqPD1Ke9nHYV4+FK2pTfH14j7N6RyDIxy4bk=;
 b=glc8/Y52bT/vEohTcSVimii1pswMnqskira3HXPJpJlZbSb1h82zKYBBYCPasL+/bkWssIscfPUFXBwC3haAQGMrX7noSzUhQ7z39auyUqHKNqJ/gXak7Mjd/BYn13a8IvG46IiUdwHEsx5a58S8aaFKbGZkwcZuXewEFjJmBvSGaYcjryrNEmc+90dQWLGqV8oiKlGoXHp+1wru3WV0j9bwmVGKsw7sXWB5A3tqhWsUg6V4hJq3gzaq77DB1wPJ3dnlDg2Zl9BgHgRkaNdVet0y8tCYVupPsPP3c6yqWBPsD8TL2NYKL60kJohCn0QkGglInzXZSrI1Fvqzil9V4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cPukSLqqPD1Ke9nHYV4+FK2pTfH14j7N6RyDIxy4bk=;
 b=vTVIu/zqPX7a2F2Nk5GivDTZwVgUvxIaBnog7GFM7zCbxcMgXVrfi6OE8yeb1Q8R/6mWP8l59QF2SZd/VTtKRFui/OdPt95eRBQ2bxTyNZLszT+SeT/tPbqydcNiJm1ZN9vgPW6r49f7GQ0fB4okPEwbuy+rOWmEBQciw/7PxGQ=
Received: from PH7P220CA0121.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::10)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Tue, 24 Sep
 2024 14:16:17 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::4b) by PH7P220CA0121.outlook.office365.com
 (2603:10b6:510:327::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Tue, 24 Sep 2024 14:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 14:16:15 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 09:16:12 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu: Add supported partition mode node
Date: Tue, 24 Sep 2024 22:15:49 +0800
Message-ID: <20240924141549.244754-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240924141549.244754-1-asad.kamal@amd.com>
References: <20240924141549.244754-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae9174f-7afb-4355-b6c6-08dcdca373b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JyJyX++LbzDL8STfplDv8YnZhGf9WXq7VKwXbPVW7sMRJk9xDH8a3+8Tn4Ir?=
 =?us-ascii?Q?hHD1cexmN3h3D5JG05Z/MhqXF3EMlP8lU9bULHrduORAHpNIwJ9jHXtGkjt0?=
 =?us-ascii?Q?/EM0YXbHyB8vdjukxCkaOdkoBTXGAUpSrQWvb3xPvCpXcx4hOwWdExj0WhbE?=
 =?us-ascii?Q?zA4syAuOojuU/BBOuzb86p9KyJa5PcowzQpMRmw2uFczPS9bPL5DqARni0nV?=
 =?us-ascii?Q?uCpYqaK2QGumWE0JXezdQepf5eJrqHagfDIoCGiPtxLHLysdpe+MZg4XEuWk?=
 =?us-ascii?Q?v0tbn6ppcNqMKKFoRx2vuDgEfNaZ+uIfW4/o4nixUVYmJ9gGIH64Y+dCixmX?=
 =?us-ascii?Q?1X83Jb/+k5YvoVdkrwLPQktFoEIV8AYf4ssBTa4m95mEgNby4cNtc6d7DUpV?=
 =?us-ascii?Q?7iK17soxrj8x0OuCA2btx3+7Goj7NoN1EQ5ObaPXtSwQIfSmfjzjhj5rxnAU?=
 =?us-ascii?Q?tc9bK1fkHrqTg98eajV8hesTaF9bcRn3xKOBemqCNmeExgild+cRvUwmBxrQ?=
 =?us-ascii?Q?lurLTHfXsK0FjQZBZN99NM1bIv/H6XUCJj6dTV0A8NdVB0if/3qCdVzga2Kr?=
 =?us-ascii?Q?vTfwFA+6hDmTMVFgdUIGPUIMn/HVYLACQtB6OpiTUiaSWTzMVbiF1/irRN+1?=
 =?us-ascii?Q?18TfFtP89fm77VVTvx26fh5pu6LI47MRnrmPs9AfwZetN0vtyEhyjAlOXRFC?=
 =?us-ascii?Q?khTrs1M34cBwMylKDY9gUjn5lImSVBITkQzquPgEuiM5asCycYd1WbXKwIwP?=
 =?us-ascii?Q?mlSc8WHj/5Ql6V45kFwk6/WCeK8xRUEZCXucJBugRK37cNnG49u1rbrh95GT?=
 =?us-ascii?Q?n7PK3t1p1pQkTGewnjFydE8YgWFb5BprJz0hF0Qv7fU7QgPOxrKnWSnB7cgN?=
 =?us-ascii?Q?AfFRNDuMtbpwSGujf/1cwLALWBtaziEO0/g6gwy4AL4wAiqa75LQr0JXjZe2?=
 =?us-ascii?Q?y4WAeLVLbEpdn9aLobCgh6Vm/hOVE5Hyc4wW87to+ljR0ILRvc83xV19GEXi?=
 =?us-ascii?Q?3+XqJhRbrhJMZ9pyW/9Ad++h7vGS2x22ysE/uevRWbkud2emz41xPiR/nQtt?=
 =?us-ascii?Q?HJs1UyhYUQNsGQwu2Tzfy//rTf9Rvt0grt1L1Tatk9/wJa7yLXohAeqa5ITG?=
 =?us-ascii?Q?4AEty2nsAsgBDHdPu/1XLIQoApz1OwNRy0citkQRB+5J7u6MJnb/moPRyV0t?=
 =?us-ascii?Q?ysb1/xlPKUc71o6dLI6GFTPuc1l5BAd27ikZJgjAdO+eRHzPF1+GVHI12W5u?=
 =?us-ascii?Q?X5/+pdMrwQMei7334hgSAyI06lklIIW+7nJ6X9E8kmf3qUf5WdJyiTXl+sH1?=
 =?us-ascii?Q?Mt0zx6PObbMOT9+PsClaqqq2g+txAV7BJv5igeyaQ1yC2qWsIxF/fkJUxvnf?=
 =?us-ascii?Q?feVO08oMSJHMf5SeSVVW0Fno9uOrJxEzqDpl/HlyiGa7uaViWH2GndOfdWPE?=
 =?us-ascii?Q?yQqdzXLGGPOLVnvE1yiq+dE0bWQeoMId?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 14:16:15.8251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae9174f-7afb-4355-b6c6-08dcdca373b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
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

Add sysfs node to show supoorted partition modes across all NPS modes

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 48 +++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index fc4ab1d8c7c9..10daa6a15e5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -463,6 +463,14 @@ static struct attribute *xcp_cfg_res_sysfs_attrs[] = {
 	&XCP_CFG_SYSFS_RES_ATTR_PTR(num_shared), NULL
 };
 
+static const char *xcp_desc[] = {
+	[AMDGPU_SPX_PARTITION_MODE] = "SPX",
+	[AMDGPU_DPX_PARTITION_MODE] = "DPX",
+	[AMDGPU_TPX_PARTITION_MODE] = "TPX",
+	[AMDGPU_QPX_PARTITION_MODE] = "QPX",
+	[AMDGPU_CPX_PARTITION_MODE] = "CPX",
+};
+
 ATTRIBUTE_GROUPS(xcp_cfg_res_sysfs);
 
 #define to_xcp_attr(x) \
@@ -511,6 +519,27 @@ static int amdgpu_xcp_get_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
 }
 
 #define to_xcp_cfg(x) container_of(x, struct amdgpu_xcp_cfg, kobj)
+static ssize_t supported_xcp_configs_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	struct amdgpu_xcp_cfg *xcp_cfg = to_xcp_cfg(kobj);
+	struct amdgpu_xcp_mgr *xcp_mgr = xcp_cfg->xcp_mgr;
+	int size = 0, mode;
+	char *sep = "";
+
+	if (!xcp_mgr || !xcp_mgr->supp_xcp_modes)
+		return sysfs_emit(buf, "Not supported\n");
+
+	for_each_inst(mode, xcp_mgr->supp_xcp_modes) {
+		size += sysfs_emit_at(buf, size, "%s%s", sep, xcp_desc[mode]);
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
@@ -564,6 +593,19 @@ static const struct kobj_type xcp_cfg_sysfs_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
+static struct kobj_attribute supp_part_sysfs_mode =
+	__ATTR_RO(supported_xcp_configs);
+
+static const struct kobj_type supp_part_sysfs_ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+static const struct attribute *xcp_attrs[] = {
+	&supp_part_sysfs_mode.attr,
+	&xcp_cfg_sysfs_mode.attr,
+	NULL,
+};
+
 void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_res_details *xcp_res;
@@ -583,7 +625,7 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
 	if (r)
 		goto err1;
 
-	r = sysfs_create_file(&xcp_cfg->kobj, &xcp_cfg_sysfs_mode.attr);
+	r = sysfs_create_files(&xcp_cfg->kobj, xcp_attrs);
 	if (r)
 		goto err1;
 
@@ -611,7 +653,7 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
 		kobject_put(&xcp_res->kobj);
 	}
 
-	sysfs_remove_file(&xcp_cfg->kobj, &xcp_cfg_sysfs_mode.attr);
+	sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
 err1:
 	kobject_put(&xcp_cfg->kobj);
 }
@@ -631,6 +673,6 @@ void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *adev)
 		kobject_put(&xcp_res->kobj);
 	}
 
-	sysfs_remove_file(&xcp_cfg->kobj, &xcp_cfg_sysfs_mode.attr);
+	sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
 	kobject_put(&xcp_cfg->kobj);
 }
-- 
2.46.0

