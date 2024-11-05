Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BFBD1269D
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 12:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8427C10E140;
	Tue,  5 Nov 2024 12:34:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ta3PQRKA";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F80B10E140
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 12:34:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYX5TTrTQkpfYQDD+pPYQUieCwzr0Vyq5MscqpPdVWlN+ghnJTkIDF7WpewDFCaevnPVD9xWW+GK3ji8mQIl/Gdl5G6goMnp5OLq/0aTLpgi1fmQ70aooq06Y/ukI0vNptJ+3vBPCba/8y1a0GrRwFffaUwhhe8XwODNKXCKn0vHAWxpuDTxvGgxzsRLRLAgupluPsrcTbR9JXuqVcC3Rphz3XOoFX0+KXOITWxcYwkQ5nRSKbQdmMdu9yproJJyiSsic+CQmlr0LQ3AC+kIOs964caKTBQ3ihZvYR2ihj8Jq/60nuv/sCkj4gmFnv5PxxebMsG3T+uese87qM0dHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryoNtbq5/CpOGzKYS8Lvsr8ZZM8tFC0cE1vwXHsyd/w=;
 b=S27IRk93kmQJyF2AET6g2DllV/ZfHfl0WRknWl1ubAGZ/DtlHPsvjsJn63TLKDi4ez59ru36NObj3yvhc4B/MN43mdjQ6HdjFxQq3Mp7ZLnWhnEYcCAPYfsVWt3J/4zu2hZzyRYWx2VLM8WqYqHlzHNMFM/yD25ldsrOXceP+NiPrpdZIBsFHz4cXsu74L2zciN6cCONyX4u0mGprW4tascY3NVlMArKekYLJbuPBjbQXJ7LFu5VZKAdeV2cbV3C0+nZkwgMqFrEpKdNn4P8ib7yEK2TjGKNZzfDE2NimVoGYFR4ptepAr9ivXziKAj0pG7R52p9m91LYUW+C3nQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryoNtbq5/CpOGzKYS8Lvsr8ZZM8tFC0cE1vwXHsyd/w=;
 b=Ta3PQRKA+S7iOXXM1KyETQIwVigQhjdHjtEgrRW8LsgQ5E0LLof1Ul2AJRm4TasWMlBfdINJWwIWpc4LMbp3HhwKeTtfUPP0iKX9hk9Vv9/ptPz7oI9QW7jy5XIWlphi6G37vdSY3WtMkp28Po+90/k7+3/CgtPBOI9DExcpowg=
Received: from PH8PR07CA0032.namprd07.prod.outlook.com (2603:10b6:510:2cf::6)
 by IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 12:34:40 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::2c) by PH8PR07CA0032.outlook.office365.com
 (2603:10b6:510:2cf::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 12:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 12:34:39 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 06:34:35 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>,
 <hawking.zhang@amd.com>
CC: <le.ma@amd.com>, <shiwu.zhang@amd.com>, <Asad.Kamal@amd.com>,
 <charis.poag@amd.com>, <donald.cheung@amd.com>, <sepehr.khatir@amd.com>,
 <daniel.oliveira@amd.com>
Subject: [PATCH v3] drm/amdgpu: Add supported NPS modes node
Date: Tue, 5 Nov 2024 20:34:20 +0800
Message-ID: <20241105123420.872322-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|IA1PR12MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: f95095c1-d16c-4d12-3f7e-08dcfd96379e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fnRJTsG2mBztBoT4fp57iu0OpUEUpwR0R3u1wYLPVIwz5QjFLvzsV9SKogAl?=
 =?us-ascii?Q?mM5Lq3FKT+WaOecya07qO5CLIZ7qbvEVqKIkAkws50gjXIf61uEaMy8vFAey?=
 =?us-ascii?Q?LwPw6ROMoWfoK+Z0poV4V/eU5VooFn62KMPVTTuYxgKcz/jcOe7+44XX+Tev?=
 =?us-ascii?Q?asU0YhIKxIp5cS5k9y6KJoiUnn9D9169Cf78qY/Qk2kx17l9o/RW9o65e2jB?=
 =?us-ascii?Q?MnCOW3pbp7mJPvj9CqwpgJ+1XbYBvVD+kenUEfboHQack1mp94JNYlQ/HbBU?=
 =?us-ascii?Q?JC4Z8UebGUsvjZ8y0Fc3ka58Yv22LshEKqfBBsrIJ0vhdmTOzQQTtOAmS9VC?=
 =?us-ascii?Q?XtNL5WFRtVroJPVtrytPL4VyWogXaz07/gnexCtEaDmJsVJvC3XEPKwuuoc6?=
 =?us-ascii?Q?dD52aBAq3OYaBUMaW+TZQo3DEjpmBvPDW8r7AvB9QfmHhlI+txxHTwsbJwJn?=
 =?us-ascii?Q?YB9JFz7B14EI/i1GZmDmyls3Z//Fnw6wxl7SUyoJJMwOaJkaLDTE1GHHz4+s?=
 =?us-ascii?Q?q9STlztwcUxIWpBQ9SOjRKoxh7D9xaWOUFvNTEjTN1zCj1r+LCD8OUdhqeCA?=
 =?us-ascii?Q?F79/NkOqQo+FKjoWrzQ6zD9SEF1No8Q4WbSaCozoebTt5RO1Vt7PbkPMbQdj?=
 =?us-ascii?Q?tdqdLyCXS8cq5YlSj8h6gDJsPgk9E9MwF7UibxbaX6JVO/Rk1T3GeD2uxWUd?=
 =?us-ascii?Q?8FQhdQ+f6YFci/Am7TX0EixAbbT/uuEi/EAVXc66WOwLolLPncGnetlMW1FI?=
 =?us-ascii?Q?2EhI/pARtqL43WXw5+fR7qRIE+NQ6AC3vmrFYcXQBbcR6KO/26Myfmu++aqA?=
 =?us-ascii?Q?obNYiZeML9bZ6FRoPpjuZNspeOgjcBDa2zl+CyDwaCgy0ZwA/RwFuz+yP7Q2?=
 =?us-ascii?Q?ueyVqhvFv4u+1xSjSS4hvoMMVEJaLzHcgzyXttHCQBUnmvn//uMeGjP1XTny?=
 =?us-ascii?Q?+ga79hD6gEeNj/i4OzpkjUG7r72I4JhBxdkaMkMGPGsSaZNfo4lPphbEvXPp?=
 =?us-ascii?Q?K5aW6eMNmzZ04/F6zErZO9PjZPDih64CX9tcfn0obNZ9G8vXUpjZ2McBpSFu?=
 =?us-ascii?Q?KEeMGTyhtky3N2v+0VZlzhjMFYKZMgSXHPpINHpNACC0wYLOFcz6NEn6s8MV?=
 =?us-ascii?Q?Qi97Q55oV/5jfcLUdaSQFCXvzacJ03c8DKqXlv1DWTQehhqoLiO2+EWAz851?=
 =?us-ascii?Q?5dWN+HuMgJrWxuuWA6UUH64l1cHASN/0MVCKckeJLTK4IO/yyZIu3OCfMi++?=
 =?us-ascii?Q?K4z3Y61desYd9qKjy0U4iwtVuigVn5yVGeH8VQ3LHqbyM8K1ZPJqRyfzkzb1?=
 =?us-ascii?Q?hxjtpXSeG1FmYE5UIInXvCsHUHY1DHvYoH9CyirXvyJfe7VuYlz+Gjfov3u2?=
 =?us-ascii?Q?1hleygSy8vGKU/HnPqLkUC7W2QZQgJ/GNwv1bGzqjms6+5q36A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 12:34:39.7463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f95095c1-d16c-4d12-3f7e-08dcfd96379e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020
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

Add sysfs node to show supported NPS mode for the
partition configuration selected using xcp_config

v2: Hide node if dynamic nps switch not supported

v3: Fix removal of files in case of error

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 48 ++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 83a16918ea76..e209b5e101df 100644
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
@@ -596,6 +626,9 @@ static const struct kobj_type xcp_cfg_sysfs_ktype = {
 static struct kobj_attribute supp_part_sysfs_mode =
 	__ATTR_RO(supported_xcp_configs);
 
+static struct kobj_attribute supp_nps_sysfs_mode =
+	__ATTR_RO(supported_nps_configs);
+
 static const struct attribute *xcp_attrs[] = {
 	&supp_part_sysfs_mode.attr,
 	&xcp_cfg_sysfs_mode.attr,
@@ -625,13 +658,24 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
 	if (r)
 		goto err1;
 
+	if (adev->gmc.supported_nps_modes != 0) {
+		r = sysfs_create_file(&xcp_cfg->kobj, &supp_nps_sysfs_mode.attr);
+		if (r) {
+			sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
+			goto err1;
+		}
+	}
+
 	mode = (xcp_cfg->xcp_mgr->mode ==
 		AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) ?
 		       AMDGPU_SPX_PARTITION_MODE :
 		       xcp_cfg->xcp_mgr->mode;
 	r = amdgpu_xcp_get_res_info(xcp_cfg->xcp_mgr, mode, xcp_cfg);
-	if (r)
+	if (r) {
+		sysfs_remove_file(&xcp_cfg->kobj, &supp_nps_sysfs_mode.attr);
+		sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
 		goto err1;
+	}
 
 	xcp_cfg->mode = mode;
 	for (i = 0; i < xcp_cfg->num_res; i++) {
@@ -653,6 +697,7 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
 		kobject_put(&xcp_res->kobj);
 	}
 
+	sysfs_remove_file(&xcp_cfg->kobj, &supp_nps_sysfs_mode.attr);
 	sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
 err1:
 	kobject_put(&xcp_cfg->kobj);
@@ -673,6 +718,7 @@ void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *adev)
 		kobject_put(&xcp_res->kobj);
 	}
 
+	sysfs_remove_file(&xcp_cfg->kobj, &supp_nps_sysfs_mode.attr);
 	sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
 	kobject_put(&xcp_cfg->kobj);
 }
-- 
2.46.0

