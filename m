Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E7AC05027
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 08:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54F4610ECA2;
	Fri, 10 Feb 2023 08:45:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3685D10ECA2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 08:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGkdCGIHO/5HlBOZWMnAr+YYjAXaZx/RWykbjVWRymADWHZTG2ruSUMWEbViCHXaDBY0DN9Y50WRdCsPBMcvtCcm685ynyd7mg5R3R89P94p36h34Ev2oRVU0sz+6Lyc8JFE5PdxnUMcyMIv1nfO998OjxFCmvJ6fcj4EW4VsGyFH4Cj4HiJ0oec4SS3pGURBvlvCj4s+i55tGzmbqXxgH5dFn46+D2pyZEQAQyYZZowa/JAq6gPaMGF/UnqdH/TYzj+Zlyc2NTLmwupE+TlZAAddyXgNQFOf7A0xUhW6aHNO+vB1vM1AeHGdtkv1Go0f1G1b+uKL4I6ZmpwHx+sGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGS+SmXiR9xbCR7yoJGhXxO/hKN8DBaOjR8mISROG1g=;
 b=WqLfhcywP8Wis6gjUeeNIcpJztQDc+AJpzkkZYwGwLUa3vAFYYwdCicpudGukiOVD3rJYHnuz5m3Yflr6dKQsMIN8+8TeGpxMXDdJDgBeUEnGKDzpLJLXcoTHVGdonmJeqQd1Zslpb18c2iZpcmocrpCKR+UCXV5xVxlFXNdxJlY3zA+Axej7OM59d3bA1KeMmEAeyP0k9kMN+TmLhBWcVBtmYtgkg6f/dUmzeGxjmaMklPH5RBai+YxRXtZ23Q1vFawlY7OiNz9FGJycC/JGqi81sQ1K15cPRtRdicBLVmkfrkiZZqF+HquBN+wWbAOaKE4CBh1NsHeGAB2cn0OuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGS+SmXiR9xbCR7yoJGhXxO/hKN8DBaOjR8mISROG1g=;
 b=4vo83OS9kyz1PKhVEMo5xb2OxtU7ZSc7s2yzMEIwm+nH17ZtaSCr/3Glv1u5L4bEOwOLByd5dQBWS22zic3ogOZClPhbhP1a+XltHYz4lNevbmIdpLz/AgPUQy6JkXt38IdOwnyUaT3XIwCP+h9sEl2NUSw8YiUGY7+nHjXDkuI=
Received: from MW4PR04CA0289.namprd04.prod.outlook.com (2603:10b6:303:89::24)
 by SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 08:45:53 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::af) by MW4PR04CA0289.outlook.office365.com
 (2603:10b6:303:89::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.20 via Frontend
 Transport; Fri, 10 Feb 2023 08:45:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.21 via Frontend Transport; Fri, 10 Feb 2023 08:45:52 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Feb
 2023 02:45:50 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new bad page
Date: Fri, 10 Feb 2023 16:45:29 +0800
Message-ID: <20230210084529.9695-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|SJ0PR12MB5405:EE_
X-MS-Office365-Filtering-Correlation-Id: a22a8787-a09a-4a88-ae2e-08db0b43377c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xcfikf+XseOOpd+00q1AXdgegqEjh9vVb9HxFOKi4GdCyh40Br0MHo0256N7btvUXUCZPdHBVUBMttVrQRcWrtBf8GD05/Qfh1ObM2j0lfYVo7SbaBdlG2pETrM/YMsZmLeOWcgLdtpQQeuBu5Pyee5hkHjLI9vRuP2u90f1nzpuDu8xYpWfYhWF+bxgts06/qM/icxLx1TszDmg2tW7Founc3EmzoYRvNozv5nqJU/jp/HHAmtxN6huD3UR2pfbVmv/hqf44i2MXrCnf1pbmWwTKcktcwBjxQohc+ejA3RANdP0SOMK1TyARTv7gIYl8ca6f5DpqkzUiSmAcAxvhpcTkoZmMkFqPi31MWy6V0OwHCIJ67Fsm6b5GL5GEDnk0XoA3JQmBREv3mOm7RL1Fic57z1bnWjxDLtyyxpbRCeV63kCgj/cPN8mDvtgJUCapRA/8KVqWY7A5WBHBD3pxS0wBlPfer/ELSBMZEx26KU60Vpew1gyz88Ox20zm0WAC5CdGA0uu8AJD1wAm7nE96Maj8c7Yek98woB9BouPSted4gjHTf7FQXBnHvr7ySE2kp5M2TXWjRNY9tjhYZ32axlU5HY/ncsfL4AQze33uWUwCN6Wg/z4ajRErG2cszplA9Mn+XIAOWKEO+dyK33vkKes4Lpye7p+BBD1ZtwwFon7v4X4fKFhNvKt7X26D25w0voRO/Px1ucOAGX3K16RpOA9WUimUr6Q6hEY+hdTiw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199018)(46966006)(40470700004)(36840700001)(36756003)(86362001)(356005)(40460700003)(4326008)(8676002)(8936002)(70206006)(41300700001)(70586007)(110136005)(5660300002)(6636002)(316002)(2906002)(82310400005)(7696005)(83380400001)(36860700001)(40480700001)(82740400003)(81166007)(26005)(186003)(1076003)(6666004)(16526019)(478600001)(47076005)(2616005)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 08:45:52.2658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a22a8787-a09a-4a88-ae2e-08db0b43377c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If a UMC bad page is reserved but not freed by an application, the
application may trigger uncorrectable error repeatly by accessing the page.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 6 +++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e85c4689ce2c..eafe01a24349 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2049,7 +2049,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data;
-	int ret = 0;
+	int ret = 0, old_cnt;
 	uint32_t i;
 
 	if (!con || !con->eh_data || !bps || pages <= 0)
@@ -2060,6 +2060,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 	if (!data)
 		goto out;
 
+	old_cnt = data->count;
+
 	for (i = 0; i < pages; i++) {
 		if (amdgpu_ras_check_bad_page_unlock(con,
 			bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
@@ -2079,6 +2081,11 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		data->count++;
 		data->space_left--;
 	}
+
+	/* all pages have been reserved before, no new bad page */
+	if (old_cnt == data->count)
+		ret = -EEXIST;
+
 out:
 	mutex_unlock(&con->recovery_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 1c7fcb4f2380..772c431e4065 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -145,8 +145,12 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 
 		if ((amdgpu_bad_page_threshold != 0) &&
 			err_data->err_addr_cnt) {
-			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
+			ret = amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
 						err_data->err_addr_cnt);
+			/* if no new bad page is found, no need to increase ue count */
+			if (ret == -EEXIST)
+				err_data->ue_count = 0;
+
 			amdgpu_ras_save_bad_pages(adev);
 
 			amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
-- 
2.35.1

