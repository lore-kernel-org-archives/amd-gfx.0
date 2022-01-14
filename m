Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A71C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 03:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C3810E9A3;
	Fri, 14 Jan 2022 03:36:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 533D710E9A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 03:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivfG/HEe/0hpytlnzDw5gXtZphnbZ548pyHUfRTnJvP+0bsu57JuduwbMWr7+hNSiuaWlfP4yXRT50c2vOjEOpxdw7Di/y9QQs7UeRRPbltN9CN0ecD2V+JieO4Hht4sMlqup/661kgtnvFLGVpSxC4NcqhzWgKlkmlWgbLGicrHCsc2SWxUipRYeIe0q1cpHwOjHbmq0TTRby24NHhysMjPmWXAps54q6ATUpI+Nm8QCVzOfYUpKhbNs8dqFgkiDE2wdgzGtzL89sY8kxyUKvtwy8lGAdgAyqJgKW4HEwlrpKIXr+BdQV6eIiNl0wEn5f75wZeZ7V5bZroopZClDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESh9LEe8AuEhiZdRgc+eJ2gpB0MmEqK6zLBR60E7BEU=;
 b=nZhO8rHTKIYwXQodl7QBtVXJ4VBKY+R+nVybKEofFAhb+GF+LDqOtjf1SBcl3AreEVHo8OXWneMeb7Gbo8FolYoTX+gWgD1TCPFbjMmkklk+CwVdlZSyRNEhJA8DeylK54M095dC0gF291BJ6k7tblgyyCi2UPEvZiGiNvYPEUNh6grWAfsC/s6INx2dmUU9ygIfGh1/vyei8nndPHH95Ym+C7p+IY4D4RsKedTp4urbW0+cDQDMfMRHqP7tHxbg16PoKPf5GTn7fwBzeC2fkGJqdF0Ue2JH2qxv/B0iUJ9gmE+cH7enlv3xJLu0SJrJbjG5JBQ3LyH+oq/f2puTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESh9LEe8AuEhiZdRgc+eJ2gpB0MmEqK6zLBR60E7BEU=;
 b=xoHuyhmlk6t8xgWYepIUZZ74X+ff+VqGmOuR+kuS6tn98SdUf7qOnKCEuExZTaxj0J8aamb5XeGMrERMlxTrGMI+hKOxkGtm6Z8wt4xxtw7aP3YijjOge6+qOjs0QQoDjZXQjt13UQ1X46YxIUxd3KdpMWkayjzxCb0Z+qD21w0=
Received: from BN9PR03CA0754.namprd03.prod.outlook.com (2603:10b6:408:13a::9)
 by DM5PR12MB1596.namprd12.prod.outlook.com (2603:10b6:4:d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.10; Fri, 14 Jan 2022 03:36:45 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::af) by BN9PR03CA0754.outlook.office365.com
 (2603:10b6:408:13a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Fri, 14 Jan 2022 03:36:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 03:36:44 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 21:36:42 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: Fix the code style warnings in hdp xgmi mca
 and umc
Date: Fri, 14 Jan 2022 11:35:59 +0800
Message-ID: <20220114033559.4009592-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114033559.4009592-1-YiPeng.Chai@amd.com>
References: <20220114033559.4009592-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10f69adb-bdb6-4fda-79d7-08d9d70f1663
X-MS-TrafficTypeDiagnostic: DM5PR12MB1596:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB15960E397533216A2DAF7E0BFC549@DM5PR12MB1596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJF0I2tRt9Q20By8O1vzGQeZjoYXbABGlBh68Fvj9juBvePnSL+ItJ9p0yoQOz4MQ9RKPJPG3xTYThI0h7BvBhIh5Op95vmEI1haElHJM+ZrS8YusgWj6pvJyoQlRZrlxw32SLMOh18T/YRIiUB+LzZ51d0iPHyfs7zD3wWMU6ONyjbPQxvp9dP8O3o6bq2VbR0u1hzKk0a1owAjqZ2puOdhfiG6WzzgwaLcJR2h/JZjbGJHBHWE2Juped4SslqYyFYv1n3NkL3FpjDp6TIfQCCqPtopNlUib05JLfwEZ2KLSVdiiq3km3fvBTSjGdd4KJ1oKHRhzAIMeH17Kfl/IMRrH3hfSY8ffv31A+HsAm8ZOJmpNnZ0FkBFCzLaCWinoZP5g98MS0pFJ5LaCjRvqe9GXdQnc2oTIaokDlWhROxHdKS6FPw15KEUtQnk68mCljFAPlKlX7ZpM7Y2O62DkLozr0ZZEAP+1ntsDW69JlZ/IlYzg6INKwbYnBvkOZNGIZmh+Mw2m7rUaS/Y1yQlGcwDEm5dHAz8FOVrwb5PdFRihY6Qilco/psC2LEp1xei5dgAW6irLW9cAs3qq9O/N50fdsaFCHlcYJEAnanIX97fTMHi0PfvuupozJI6jd/gQza22Ee/OSh5qE2s5Zpe/LZK5j75UCuibyQiCGYfoKZfMcIE6pVY64ekTXC17APsRzmJ6j4MNCKQJe4WwWLnip0vIMVXCNbs4bTXxf6vDxqcv0Z/d3yEztlsR1x/u3Umz+cfAzcMALXoxW1q9VIWnVAFkRulxFdbTuI15jlebZIjmLpWw0hizfdaI1pd3sjRTSqT8YAd/X2MrVERYWuN/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(336012)(8936002)(8676002)(186003)(54906003)(2906002)(26005)(1076003)(316002)(47076005)(356005)(81166007)(6666004)(16526019)(426003)(2616005)(36860700001)(6916009)(83380400001)(40460700001)(508600001)(4326008)(86362001)(82310400004)(70206006)(70586007)(36756003)(5660300002)(7696005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 03:36:44.9266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f69adb-bdb6-4fda-79d7-08d9d70f1663
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1596
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drm/amdgpu: Fix the code style warnings in hdp xgmi mca and umc.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c    | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c    | 3 ++-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index c94a4b3c8d6d..8e9694a4d335 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -24,7 +24,7 @@
 #define __AMDGPU_HDP_H__
 #include "amdgpu_ras.h"
 
-struct amdgpu_hdp_ras{
+struct amdgpu_hdp_ras {
 	struct amdgpu_ras_block_object ras_block;
 };
 
@@ -40,7 +40,7 @@ struct amdgpu_hdp_funcs {
 struct amdgpu_hdp {
 	struct ras_common_if			*ras_if;
 	const struct amdgpu_hdp_funcs		*funcs;
-	struct amdgpu_hdp_ras 	*ras;
+	struct amdgpu_hdp_ras *ras;
 };
 
 int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, void *ras_info);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 478457637d29..5929d6f528c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -950,7 +950,8 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,  void *inject_if)
 {
 	int ret = 0;
-	struct ta_ras_trigger_error_input *block_info =  (struct ta_ras_trigger_error_input *)inject_if;
+	struct ta_ras_trigger_error_input *block_info =
+				(struct ta_ras_trigger_error_input *)inject_if;
 
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
 		dev_warn(adev->dev, "Failed to disallow df cstate");
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index f51092041edc..68565262af9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -47,12 +47,13 @@ static void mca_v3_0_mp0_ras_fini(struct amdgpu_device *adev)
 	amdgpu_mca_ras_fini(adev, &adev->mca.mp0);
 }
 
-static int mca_v3_0_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+static int mca_v3_0_ras_block_match(struct amdgpu_ras_block_object *block_obj,
+				enum amdgpu_ras_block block, uint32_t sub_block_index)
 {
-	if(!block_obj)
+	if (!block_obj)
 		return -EINVAL;
 
-	if( (block_obj->block == block) &&
+	if ((block_obj->block == block) &&
 		(block_obj->sub_block_index == sub_block_index)) {
 		return 0;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index 4776301972d4..c9891b7a05a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -475,4 +475,5 @@ struct amdgpu_umc_ras umc_v6_1_ras = {
 		.hw_ops = &umc_v6_1_ras_hw_ops,
 	},
 	.err_cnt_init = umc_v6_1_err_cnt_init,
-};
\ No newline at end of file
+};
+
-- 
2.25.1

