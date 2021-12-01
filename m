Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2855DC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 10:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA966F5DD;
	Wed,  1 Dec 2021 10:53:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50F9B6F5DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 10:53:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfO9qVUrpHQK554q5yswIPiaeJp8qOltB5BmysRgDVcx1BC/uqXQ7XiPPktx/dXDvla6/LIh0aYlTWB7Z6mXIfetqYnpV1uOGMaK5JFbelJOrg2Maz22C5sV5ZadrVIAlF5zQhL3FhSSVWeX8nnuhN3hgBuRXwKrG0E2CL0nmfpRy8Tz78y3/ovUvcXX06RaycLzcrqUIj1g7FlFNOQEP80topC4BVIW+JZmWSkisF3Ol176goNV+4CkvRKkh4YNWgBeuAzUdfPBL7KvKpWXDNOxLa50g6S4pks0WHVOicQkRronQLFYwSs0KKRqduveGKQB0UTJWlxPmXfvekUIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hrm4PsxhnOlUELdoELrqS6WF0sVr+K8skVWViisaugI=;
 b=MbRsedK1WUd/l8qauv5F4jp6NE5GT4esQroGj++tt4qvgwE1OTO7dLwn06YeCZRo4xHNr22divXn+m6TXcb8iNKMTcyeUc37MWBUOBLErDJ/dpne2R4BCBAXe6YaSjGu0ROGdV2D/1OhHi8p3QNAmv5RCxh6D9+veUs56bsEBk+J+BSD9Ykwxv2FLwi9bfxRF8+BGCJoCr/zbYX2fLC4C/IpP76rJn3fMx6NSo/zHiIiWhdAwcEhAqeQExGm9CJmBBqdU5smYv6i15E9+r8Uuxy2ndRofYI/d3J5bcNFoPAPw+x3KlnaUVfLgNktA/burox7Qpz6oAMizNjC1LkYdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hrm4PsxhnOlUELdoELrqS6WF0sVr+K8skVWViisaugI=;
 b=g9DcwQWqu+SKv5a3BmO7wGx9dtQI0Mv6vAQdKJq33OYF8sJzUDjWuJ71y+pCXtnXmuenh5zlv5DkUzSmtF9VdQDmZVQRjkZtxYp95FiplowjK41yeQRgBIxSKn9/R8mXTst1XMcVlnkisA5LrI4w6NbPhKUo9kGehZOKHKSTosw=
Received: from BN6PR14CA0011.namprd14.prod.outlook.com (2603:10b6:404:79::21)
 by BL0PR12MB4995.namprd12.prod.outlook.com (2603:10b6:208:1c7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Wed, 1 Dec
 2021 10:53:42 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::15) by BN6PR14CA0011.outlook.office365.com
 (2603:10b6:404:79::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Wed, 1 Dec 2021 10:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 10:53:41 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 04:53:39 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 05/11] drm/amdgpu: Modify hdp block to fit for the unified
 ras block data and ops
Date: Wed, 1 Dec 2021 18:52:44 +0800
Message-ID: <20211201105250.298525-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201105250.298525-1-YiPeng.Chai@amd.com>
References: <20211201105250.298525-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8d59125-c4b3-4678-125d-08d9b4b8d6c1
X-MS-TrafficTypeDiagnostic: BL0PR12MB4995:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4995E17A797D6A50B06C69A5FC689@BL0PR12MB4995.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:339;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kF2MqjqGu9I/2SPsNYzpeV+TyN1R+CwyQeFEYWIWxR6uhxlO0dXXHnRN1uF6uogBomHBQXuN80y1508GRzP6gjcfwLEvfyCHVMkzU+7Ta30F+MKlriCQmMvrI0WIIm+jDio9uSsSQBarGlVqmP0x/e0JGSi3rFAtwLk7AtJ7bXN8Uqb8hiSXfRf1eazhuF0V8a15ojGQG2dpdbxwZ1d4UNVX6j7vVFJ7YBnjZpFwqRuVuw++HfT79J/Vf0mqJxI9AviLACkqEYFmH0O91ZvsWMgA3QLAYI9PysMrm7gWIGlbWrJagwBKJg1+6CS9DbZ/D1EYbZUS6NyrAErkPRIS0tPE/98B0h5Tm1RErk5Nnnpq0ijq4U0crsfiIjdnTtI0c13AhWJHrgU93aoxNxgqfqgPgeAKHqmLCsMJ5N6PiR2QuE734dL8pTZq5pgQbIZLDqUfYuOzKYBJHexumyY6gkz5vkS8G0PAmJ+I474JihNc08QGzdy9/olnJ7fpY71k3mlFE7b8YpyQrd3OGdnUnVFvnyE0WRku6hfl4IN7PLx+551pfN+ySws+AsOqxKzuNgVvkB/LsdEYipLr9cHgcoVPyGokSFBlJqlOBvUg1KDHUDYVN2AUnaYRwC2aVAY+YZwIRmoTE6q4ksE488wLHqWzyzvoa1WWU/LZzcEamSZwEXfAtAPZrvCYFu7jR/Y4eQYej0z817w0bM5SAq6MJYZSfkr6fFq3PLCh6HFAzB3tVCizOnKP0WfZMM8OOUyv6InLtqsIBUwSPGiwOqrdpQ9titFtIklC6YNS0U68NvRAL/5VseMCeBaC0WInc9dBL7Yka2pfW6nJh1m6EDns1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(36860700001)(81166007)(2616005)(82310400004)(7696005)(4326008)(426003)(6916009)(8936002)(508600001)(336012)(8676002)(16526019)(5660300002)(1076003)(36756003)(54906003)(2906002)(186003)(26005)(70206006)(86362001)(70586007)(6666004)(47076005)(316002)(83380400001)(40460700001)(356005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 10:53:41.9176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d59125-c4b3-4678-125d-08d9b4b8d6c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4995
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, yipechai <YiPeng.Chai@amd.com>,
 yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.Modify hdp block to fit for the unified ras block data and ops.
2.Implement .ras_block_match function pointer for hdp block to identify itself.
3.Change amdgpu_hdp_ras_funcs to amdgpu_hdp_ras, and the corresponding variable name remove _funcs suffix.
4.Remove the const flag of hdp ras variable so that hdp ras block can be able to be insertted into amdgpu device ras block link list.
5.Invoke amdgpu_ras_register_ras_block function to register hdp ras block into amdgpu device ras block link list.
6.Remove the redundant code about hdp in amdgpu_ras.c after using the unified ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h | 11 ++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 22 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h   |  2 +-
 6 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 3ba2f0f1f1b4..0d06e7a2b951 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -460,9 +460,9 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	if (adev->hdp.ras_funcs &&
-	    adev->hdp.ras_funcs->ras_late_init) {
-		r = adev->hdp.ras_funcs->ras_late_init(adev);
+	if (adev->hdp.ras && adev->hdp.ras->ras_block.ops &&
+	    adev->hdp.ras->ras_block.ops->ras_late_init) {
+		r = adev->hdp.ras->ras_block.ops->ras_late_init(adev);
 		if (r)
 			return r;
 	}
@@ -505,9 +505,9 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 	    adev->gmc.xgmi.ras->ras_block.ops->ras_fini)
 		adev->gmc.xgmi.ras->ras_block.ops->ras_fini(adev);
 
-	if (adev->hdp.ras_funcs &&
-	    adev->hdp.ras_funcs->ras_fini)
-		adev->hdp.ras_funcs->ras_fini(adev);
+	if (adev->hdp.ras && adev->hdp.ras->ras_block.ops &&
+	    adev->hdp.ras->ras_block.ops->ras_fini)
+		adev->hdp.ras->ras_block.ops->ras_fini(adev);
 }
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 7ec99d591584..6e53898fb283 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -22,13 +22,10 @@
  */
 #ifndef __AMDGPU_HDP_H__
 #define __AMDGPU_HDP_H__
+#include "amdgpu_ras.h"
 
-struct amdgpu_hdp_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	void (*query_ras_error_count)(struct amdgpu_device *adev,
-				      void *ras_error_status);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+struct amdgpu_hdp_ras{
+	struct amdgpu_ras_block_object ras_block;
 };
 
 struct amdgpu_hdp_funcs {
@@ -43,7 +40,7 @@ struct amdgpu_hdp_funcs {
 struct amdgpu_hdp {
 	struct ras_common_if			*ras_if;
 	const struct amdgpu_hdp_funcs		*funcs;
-	const struct amdgpu_hdp_ras_funcs	*ras_funcs;
+	struct amdgpu_hdp_ras 	*ras;
 };
 
 int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a6a2f928c6ca..bed414404c6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -970,6 +970,7 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 			adev->nbio.ras_funcs->query_ras_error_count(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
+	case AMDGPU_RAS_BLOCK__HDP:
 		if (!block_obj || !block_obj->ops)	{
 			dev_info(adev->dev, "%s don't config ras function \n",
 				get_ras_block_str(&info->head));
@@ -978,11 +979,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		if (block_obj->ops->query_ras_error_count)
 			block_obj->ops->query_ras_error_count(adev, &err_data);
 		break;
-	case AMDGPU_RAS_BLOCK__HDP:
-		if (adev->hdp.ras_funcs &&
-		    adev->hdp.ras_funcs->query_ras_error_count)
-			adev->hdp.ras_funcs->query_ras_error_count(adev, &err_data);
-		break;
 	case AMDGPU_RAS_BLOCK__MCA:
 		amdgpu_ras_mca_query_error_status(adev, &info->head, &err_data);
 		break;
@@ -1074,9 +1070,13 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 			adev->sdma.funcs->reset_ras_error_count(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__HDP:
-		if (adev->hdp.ras_funcs &&
-		    adev->hdp.ras_funcs->reset_ras_error_count)
-			adev->hdp.ras_funcs->reset_ras_error_count(adev);
+		if (!block_obj || !block_obj->ops)	{
+			dev_info(adev->dev, "%s don't config ras function \n", ras_block_str(block));
+			return -EINVAL;
+		}
+
+		if (block_obj->ops->reset_ras_error_count)
+			block_obj->ops->reset_ras_error_count(adev);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3606d2cbff5e..c66dc13e256f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1223,7 +1223,8 @@ static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 
 static void gmc_v9_0_set_hdp_ras_funcs(struct amdgpu_device *adev)
 {
-	adev->hdp.ras_funcs = &hdp_v4_0_ras_funcs;
+	adev->hdp.ras = &hdp_v4_0_ras;
+	amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);
 }
 
 static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev)
@@ -1300,9 +1301,9 @@ static int gmc_v9_0_late_init(void *handle)
 		    adev->mmhub.ras_funcs->reset_ras_error_count)
 			adev->mmhub.ras_funcs->reset_ras_error_count(adev);
 
-		if (adev->hdp.ras_funcs &&
-		    adev->hdp.ras_funcs->reset_ras_error_count)
-			adev->hdp.ras_funcs->reset_ras_error_count(adev);
+		if (adev->hdp.ras && adev->hdp.ras->ras_block.ops &&
+		    adev->hdp.ras->ras_block.ops->reset_ras_error_count)
+			adev->hdp.ras->ras_block.ops->reset_ras_error_count(adev);
 	}
 
 	r = amdgpu_gmc_ras_late_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 74b90cc2bf48..8b15843ea52a 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -149,13 +149,33 @@ static void hdp_v4_0_init_registers(struct amdgpu_device *adev)
 	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev->gmc.vram_start >> 40));
 }
 
-const struct amdgpu_hdp_ras_funcs hdp_v4_0_ras_funcs = {
+static int hdp_v4_0_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	if(!block_obj)
+		return -EINVAL;
+
+	if(block_obj->block == block) {
+		return 0;
+	}
+	return -EINVAL;
+}
+
+struct amdgpu_ras_block_ops hdp_v4_0_ras_ops = {
+	.ras_block_match = hdp_v4_0_ras_block_match,
 	.ras_late_init = amdgpu_hdp_ras_late_init,
 	.ras_fini = amdgpu_hdp_ras_fini,
 	.query_ras_error_count = hdp_v4_0_query_ras_error_count,
 	.reset_ras_error_count = hdp_v4_0_reset_ras_error_count,
 };
 
+struct amdgpu_hdp_ras hdp_v4_0_ras = {
+	.ras_block = {
+		.name = "hdp",
+		.block = AMDGPU_RAS_BLOCK__HDP,
+		.ops = &hdp_v4_0_ras_ops,
+	},
+};
+
 const struct amdgpu_hdp_funcs hdp_v4_0_funcs = {
 	.flush_hdp = hdp_v4_0_flush_hdp,
 	.invalidate_hdp = hdp_v4_0_invalidate_hdp,
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
index dc3a1b81dd62..c44eee9282ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
@@ -27,6 +27,6 @@
 #include "soc15_common.h"
 
 extern const struct amdgpu_hdp_funcs hdp_v4_0_funcs;
-extern const struct amdgpu_hdp_ras_funcs hdp_v4_0_ras_funcs;
+extern struct amdgpu_hdp_ras  hdp_v4_0_ras;
 
 #endif
-- 
2.25.1

