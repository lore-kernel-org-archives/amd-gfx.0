Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867ABC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 10:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF8626FA30;
	Wed,  1 Dec 2021 10:54:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C986FA2D
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 10:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuYX7VdyfwAp7uOrJUPVjLwIgtFTz1LGZBX6ahoCHIiPTyQ9IZQwbADHd9ki8eMHg6+rWbGX7uxYbHCm0h8f9L2rc+mHYjv/k70Z3/WrLMSENAyyih7SfkKubj/MuJNWv6KkxMmGWkEnt4rP0/3QjCNf7oIhiziKD5MoZvvohmrvWqYKHLtmXqsuyv8L0O38tTRnJyyIY6XT8FQdgza9kLJ7Jwic7xKwsT3dVCcQX8UicMm7VhCfvYdoUvrsFENxuRpNCHkYas2ExjirV4lDWDBjRxpKP+eGYHXmS/qGZ3diCgm2Wq0lU32Pieh8l/ZtzcqfVLUJ+dyXpf0AeP+Uww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkbVrZLRfGE3MyWkKwjNLYEjxwPp0dT1u0jA1O/X9E0=;
 b=Kn90YRsj9fvks8fr/1R8hR6xamaZmRbr4qixPJ1ZyzT1HDd8hhqWhyMCH/n8RfQ6iNpvas+JWc+sawy2xLBcomdKQEiPPjsSaW2raOZyPOKFAAOGo08wJ+5UO9VCazrWU4xieqcpK3J2i8uY5UXtaBo5MytNiuh5Ixire+B6phqBcUPd4iIs9RkMYvvdvBv+QHJxVF1+EFMphak1Zppx+lOAf8Xh92yn4pSbYLHj5d7TJdzrTeNjdP8D312Gh//CpiDqmE0LF3WN6GRLUBuqn/wvbGprSaRqWOobgmq8DO4cNNpf64aEemsQ8aEJuVuQQRG1Bnp/nqGSi0KdHDvbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkbVrZLRfGE3MyWkKwjNLYEjxwPp0dT1u0jA1O/X9E0=;
 b=YZ5bfzbYs9IxyCAw9sBu+s/EQMDgGKx+NCUt88/MmAqg1c31NDDxN5LxHEx+rifWVq4QfBhFsRmZ62YdCk1rkL7tNtvel2oxn8gpwqNuL1ZjGxS0ISIp01OeqBc/j9RfPPhaj3clRdS9dT+fCn4zSq0Z46qYY4u9zIb1rcAhwC0=
Received: from BN9PR03CA0111.namprd03.prod.outlook.com (2603:10b6:408:fd::26)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 10:54:01 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::c3) by BN9PR03CA0111.outlook.office365.com
 (2603:10b6:408:fd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Wed, 1 Dec 2021 10:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 10:54:00 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 04:53:50 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 11/11] drm/amdgpu: Move error inject function from
 amdgpu_ras.c to each block
Date: Wed, 1 Dec 2021 18:52:50 +0800
Message-ID: <20211201105250.298525-11-YiPeng.Chai@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1bfd8a57-e759-4d29-6d5a-08d9b4b8e22d
X-MS-TrafficTypeDiagnostic: MW3PR12MB4347:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4347E3F59B5B3DC933FBB711FC689@MW3PR12MB4347.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bd6m7AGvWPHzsuDbKQfL+lvmKprdM96x2H69ctfUxfroLc+nW0UzV67S9t+1GC2xAkYAZ/f2JxXJjrohl53SX84em8JUDxBueuLgxOKYp8126COU5Acd0NRjpzuuYkitkzlVkEE/To+op6MgFELwqRhKHl2ciHhKsinmh16wCopgHAdV97hWUvp3XWOWHuR7VXw+PbBu+F5jMrTURauTJz7aMaC/jn02FrP7rpWpxTPcAakP9l70le5p+HrO7gxaCGA0OtRgagYDWsboTvGoZfpGe/QsMUO83xfpyusGpoToHEBLrZIqAR0/+YF5XfOcGnw2rpJjVvOV7Sg/fMhqBz9loavzFwAOxWU6end09RxK1JDUmFTRHCom7WLQpFIGPjQDfJ9IBBmOGCK17f+Ii0JOuqvIKhVeL/qEr9hE/nagVdEX0xxyvRoMqTKap3uM8yfBvKo720S6C6OzYSOiWFnnP1AEuqtCGCThgQtfHAgOc81f8BXEVQYtKMQL7tuwQx2Bb9zPho+fSKvOhqh0jvUOkvhBbLSN5ZIefirV8BLDD0iWY+yhvOjwY21N4gsviokbdNZSCUCKWEvtmi36U4jNQTRUUZpMmF0ShYbo1rIryrHpE88ayYF/uTaMFFDW7yepohflCSfDMxAAHhssmuGMqx/NBHzeQW0ZztHPwXTT/Zadt0yP64E1QlUHbc1wcKa2tKQc/BB3lyUygave7AXDCjbDosE2RRvVwuGK10Bc441Uq5jcmh0niykuZZjjyJ2NnXPSCAKUmPqAhstzYHRHKlFbwwezLet1zPi+1eTlWhvNkVhQuzI6Nh1XQCnu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(1076003)(7696005)(30864003)(86362001)(70586007)(40460700001)(81166007)(70206006)(2906002)(82310400004)(316002)(8676002)(6916009)(356005)(26005)(83380400001)(5660300002)(4326008)(36756003)(426003)(336012)(47076005)(508600001)(8936002)(54906003)(2616005)(186003)(16526019)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 10:54:00.9214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfd8a57-e759-4d29-6d5a-08d9b4b8e22d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347
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

Move each block error inject function from amdgpu_ras.c to each block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 62 +++++-------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 28 +++++++++++
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c    | 18 +++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 16 ++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 16 ++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  | 16 ++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   | 16 ++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 16 ++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c   | 16 ++++++
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c    | 16 ++++++
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c    | 16 ++++++
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c    | 16 ++++++
 12 files changed, 201 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 2e38bd3d3d45..87b625d305c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1032,31 +1032,7 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 	return 0;
 }
 
-/* Trigger XGMI/WAFL error */
-static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
-				 struct ta_ras_trigger_error_input *block_info)
-{
-	int ret;
-
-	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
-		dev_warn(adev->dev, "Failed to disallow df cstate");
 
-	if (amdgpu_dpm_allow_xgmi_power_down(adev, false))
-		dev_warn(adev->dev, "Failed to disallow XGMI power down");
-
-	ret = psp_ras_trigger_error(&adev->psp, block_info);
-
-	if (amdgpu_ras_intr_triggered())
-		return ret;
-
-	if (amdgpu_dpm_allow_xgmi_power_down(adev, true))
-		dev_warn(adev->dev, "Failed to allow XGMI power down");
-
-	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
-		dev_warn(adev->dev, "Failed to allow df cstate");
-
-	return ret;
-}
 
 /* wrapper of psp_ras_trigger_error */
 int amdgpu_ras_error_inject(struct amdgpu_device *adev,
@@ -1076,41 +1052,25 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 	if (!obj)
 		return -EINVAL;
 
+	if (!block_obj || !block_obj->ops)	{
+		dev_info(adev->dev, "%s don't config ras function \n", get_ras_block_str(&info->head));
+		return -EINVAL;
+	}
+
 	/* Calculate XGMI relative offset */
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
-		block_info.address =
-			amdgpu_xgmi_get_relative_phy_addr(adev,
-							  block_info.address);
+		block_info.address =  amdgpu_xgmi_get_relative_phy_addr(adev, block_info.address);
 	}
 
-	switch (info->head.block) {
-	case AMDGPU_RAS_BLOCK__GFX:
-		if (!block_obj || !block_obj->ops)	{
-			dev_info(adev->dev, "%s don't config ras function \n", get_ras_block_str(&info->head));
-			return -EINVAL;
-		}
-		if (block_obj->ops->ras_error_inject)
+	if (block_obj->ops->ras_error_inject) {
+		if(info->head.block == AMDGPU_RAS_BLOCK__GFX)
 			ret = block_obj->ops->ras_error_inject(adev, info);
-		break;
-	case AMDGPU_RAS_BLOCK__UMC:
-	case AMDGPU_RAS_BLOCK__SDMA:
-	case AMDGPU_RAS_BLOCK__MMHUB:
-	case AMDGPU_RAS_BLOCK__PCIE_BIF:
-	case AMDGPU_RAS_BLOCK__MCA:
-		ret = psp_ras_trigger_error(&adev->psp, &block_info);
-		break;
-	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
-		ret = amdgpu_ras_error_inject_xgmi(adev, &block_info);
-		break;
-	default:
-		dev_info(adev->dev, "%s error injection is not supported yet\n",
-			 get_ras_block_str(&info->head));
-		ret = -EINVAL;
+		else
+			ret = block_obj->ops->ras_error_inject(adev, &block_info);
 	}
 
 	if (ret)
-		dev_err(adev->dev, "ras inject %s failed %d\n",
-			get_ras_block_str(&info->head), ret);
+		dev_err(adev->dev, "ras inject %s failed %d\n", get_ras_block_str(&info->head), ret);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index da541c7b1ec2..298742afba99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -940,6 +940,33 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 	err_data->ce_count += ce_cnt;
 }
 
+/* Trigger XGMI/WAFL error */
+static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
+                                void *inject_if)
+{
+       int ret = 0;;
+       struct ta_ras_trigger_error_input *block_info =  (struct ta_ras_trigger_error_input *)inject_if;
+
+       if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
+               dev_warn(adev->dev, "Failed to disallow df cstate");
+
+       if (amdgpu_dpm_allow_xgmi_power_down(adev, false))
+               dev_warn(adev->dev, "Failed to disallow XGMI power down");
+
+       ret = psp_ras_trigger_error(&adev->psp, block_info);
+
+       if (amdgpu_ras_intr_triggered())
+               return ret;
+
+       if (amdgpu_dpm_allow_xgmi_power_down(adev, true))
+               dev_warn(adev->dev, "Failed to allow XGMI power down");
+
+       if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
+               dev_warn(adev->dev, "Failed to allow df cstate");
+
+       return ret;
+}
+
 static int amdgpu_xgmi_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
 {
 	if(!block_obj)
@@ -958,6 +985,7 @@ struct amdgpu_ras_block_ops  xgmi_ras_ops = {
 	.ras_fini = amdgpu_xgmi_ras_fini,
 	.query_ras_error_count = amdgpu_xgmi_query_ras_error_count,
 	.reset_ras_error_count = amdgpu_xgmi_reset_ras_error_count,
+	.ras_error_inject = amdgpu_ras_error_inject_xgmi,
 };
 
 struct amdgpu_xgmi_ras xgmi_ras = {
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index 99edc75ed4ec..ce6841967b05 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -60,12 +60,28 @@ static int mca_v3_0_ras_block_match(struct amdgpu_ras_block_object* block_obj, e
 	return -EINVAL;
 }
 
+static int mca_v3_0_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
+{
+	int ret = 0;
+	if (!adev || !inject_if) {
+		dev_err(adev->dev, "%s invaild parameters \n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	ret = psp_ras_trigger_error(&adev->psp, (struct ta_ras_trigger_error_input *)inject_if);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return ret;
+}
+
 const struct amdgpu_ras_block_ops mca_v3_0_mp0_ops = {
 	.ras_block_match = mca_v3_0_ras_block_match,
 	.ras_late_init = mca_v3_0_mp0_ras_late_init,
 	.ras_fini = mca_v3_0_mp0_ras_fini,
 	.query_ras_error_count = mca_v3_0_mp0_query_ras_error_count,
 	.query_ras_error_address = NULL,
+	.ras_error_inject = mca_v3_0_ras_error_inject,
 };
 
 struct amdgpu_mca_ras_block mca_v3_0_mp0_ras = {
@@ -101,6 +117,7 @@ const struct amdgpu_ras_block_ops mca_v3_0_mp1_ops = {
 	.ras_fini = mca_v3_0_mp1_ras_fini,
 	.query_ras_error_count = mca_v3_0_mp1_query_ras_error_count,
 	.query_ras_error_address = NULL,
+	.ras_error_inject = mca_v3_0_ras_error_inject,
 };
 
 struct amdgpu_mca_ras_block mca_v3_0_mp1_ras = {
@@ -136,6 +153,7 @@ const struct amdgpu_ras_block_ops mca_v3_0_mpio_ops = {
 	.ras_fini = mca_v3_0_mpio_ras_fini,
 	.query_ras_error_count = mca_v3_0_mpio_query_ras_error_count,
 	.query_ras_error_address = NULL,
+	.ras_error_inject = mca_v3_0_ras_error_inject,
 };
 
 struct amdgpu_mca_ras_block mca_v3_0_mpio_ras = {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index da505314802a..7cca86c504e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -786,12 +786,28 @@ static int mmhub_v1_0_ras_block_match(struct amdgpu_ras_block_object* block_obj,
 	return -EINVAL;
 }
 
+static int mmhub_v1_0_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
+{
+	int ret = 0;
+	if (!adev || !inject_if) {
+		dev_err(adev->dev, "%s invaild parameters \n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	ret = psp_ras_trigger_error(&adev->psp, (struct ta_ras_trigger_error_input *)inject_if);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return ret;
+}
+
 struct amdgpu_ras_block_ops mmhub_v1_0_ras_ops = {
 	.ras_block_match = mmhub_v1_0_ras_block_match,
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
 	.ras_fini = amdgpu_mmhub_ras_fini,
 	.query_ras_error_count = mmhub_v1_0_query_ras_error_count,
 	.reset_ras_error_count = mmhub_v1_0_reset_ras_error_count,
+	.ras_error_inject = mmhub_v1_0_ras_error_inject,
 };
 
 struct amdgpu_mmhub_ras mmhub_v1_0_ras = {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 829d14ee87d3..79a9995caef1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -1333,6 +1333,21 @@ static int mmhub_v1_7_ras_block_match(struct amdgpu_ras_block_object* block_obj,
 	return -EINVAL;
 }
 
+static int mmhub_v1_7_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
+{
+	int ret = 0;
+	if (!adev || !inject_if) {
+		dev_err(adev->dev, "%s invaild parameters \n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	ret = psp_ras_trigger_error(&adev->psp, (struct ta_ras_trigger_error_input *)inject_if);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return ret;
+}
+
 struct amdgpu_ras_block_ops mmhub_v1_7_ras_ops = {
 	.ras_block_match = mmhub_v1_7_ras_block_match,
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
@@ -1341,6 +1356,7 @@ struct amdgpu_ras_block_ops mmhub_v1_7_ras_ops = {
 	.reset_ras_error_count = mmhub_v1_7_reset_ras_error_count,
 	.query_ras_error_status = mmhub_v1_7_query_ras_error_status,
 	.reset_ras_error_status = mmhub_v1_7_reset_ras_error_status,
+	.ras_error_inject = mmhub_v1_7_ras_error_inject,
 };
 
 struct amdgpu_mmhub_ras mmhub_v1_7_ras = {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 1edc98e5bcbb..eaed556b9551 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -1667,6 +1667,21 @@ static int mmhub_v9_4_ras_block_match(struct amdgpu_ras_block_object* block_obj,
 	return -EINVAL;
 }
 
+static int mmhub_v9_4_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
+{
+	int ret = 0;
+	if (!adev || !inject_if) {
+		dev_err(adev->dev, "%s invaild parameters \n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	ret = psp_ras_trigger_error(&adev->psp, (struct ta_ras_trigger_error_input *)inject_if);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return ret;
+}
+
 const struct amdgpu_ras_block_ops mmhub_v9_4_ras_ops = {
 	.ras_block_match = mmhub_v9_4_ras_block_match,
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
@@ -1674,6 +1689,7 @@ const struct amdgpu_ras_block_ops mmhub_v9_4_ras_ops = {
 	.query_ras_error_count = mmhub_v9_4_query_ras_error_count,
 	.reset_ras_error_count = mmhub_v9_4_reset_ras_error_count,
 	.query_ras_error_status = mmhub_v9_4_query_ras_error_status,
+	.ras_error_inject = mmhub_v9_4_ras_error_inject,
 };
 
 struct amdgpu_mmhub_ras mmhub_v9_4_ras = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 14f7265d954e..8e62e2ffabe5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -650,11 +650,27 @@ static int nbio_v7_4_ras_block_match(struct amdgpu_ras_block_object* block_obj,
 	return -EINVAL;
 }
 
+static int nbio_v7_4_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
+{
+	int ret = 0;
+	if (!adev || !inject_if) {
+		dev_err(adev->dev, "%s invaild parameters \n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	ret = psp_ras_trigger_error(&adev->psp, (struct ta_ras_trigger_error_input *)inject_if);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return ret;
+}
+
 const struct amdgpu_ras_block_ops nbio_v7_4_ras_ops = {
 	.ras_block_match = nbio_v7_4_ras_block_match,
 	.query_ras_error_count = nbio_v7_4_query_ras_error_count,
 	.ras_late_init = amdgpu_nbio_ras_late_init,
 	.ras_fini = amdgpu_nbio_ras_fini,
+	.ras_error_inject = nbio_v7_4_ras_error_inject,
 };
 
 struct amdgpu_nbio_ras nbio_v7_4_ras = {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 30a651613776..578ee40cc0d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2803,11 +2803,27 @@ static int sdma_v4_0_ras_block_match(struct amdgpu_ras_block_object* block_obj,
 	return -EINVAL;
 }
 
+static int sdma_v4_0_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
+{
+	int ret = 0;
+	if (!adev || !inject_if) {
+		dev_err(adev->dev, "%s invaild parameters \n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	ret = psp_ras_trigger_error(&adev->psp, (struct ta_ras_trigger_error_input *)inject_if);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return ret;
+}
+
 const struct amdgpu_ras_block_ops sdma_v4_0_ras_ops = {
 	.ras_block_match = sdma_v4_0_ras_block_match,
 	.ras_fini = amdgpu_sdma_ras_fini,
 	.query_ras_error_count = sdma_v4_0_query_ras_error_count,
 	.reset_ras_error_count = sdma_v4_0_reset_ras_error_count,
+	.ras_error_inject = sdma_v4_0_ras_error_inject,
 };
 
 static struct amdgpu_sdma_ras sdma_v4_0_ras = {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
index 8c165bcb0ffa..0656c6a7a2c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
@@ -270,11 +270,27 @@ static int sdma_v4_4_ras_block_match(struct amdgpu_ras_block_object* block_obj,
 	return -EINVAL;
 }
 
+static int sdma_v4_4_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
+{
+	int ret = 0;
+	if (!adev || !inject_if) {
+		dev_err(adev->dev, "%s invaild parameters \n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	ret = psp_ras_trigger_error(&adev->psp, (struct ta_ras_trigger_error_input *)inject_if);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return ret;
+}
+
 const struct amdgpu_ras_block_ops sdma_v4_4_ras_ops = {
 	.ras_block_match = sdma_v4_4_ras_block_match,
 	.ras_fini = amdgpu_sdma_ras_fini,
 	.query_ras_error_count = sdma_v4_4_query_ras_error_count,
 	.reset_ras_error_count = sdma_v4_4_reset_ras_error_count,
+	.ras_error_inject = sdma_v4_4_ras_error_inject,
 };
 
 struct amdgpu_sdma_ras sdma_v4_4_ras = {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index ed480c2081a6..2058439b02cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -477,12 +477,28 @@ static int umc_v6_1_ras_block_match(struct amdgpu_ras_block_object* block_obj, e
 	return -EINVAL;
 }
 
+static int umc_v6_1_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
+{
+	int ret = 0;
+	if (!adev || !inject_if) {
+		dev_err(adev->dev, "%s invaild parameters \n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	ret = psp_ras_trigger_error(&adev->psp, (struct ta_ras_trigger_error_input *)inject_if);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return ret;
+}
+
 const struct amdgpu_ras_block_ops umc_v6_1_ras_ops = {
 	.ras_block_match = umc_v6_1_ras_block_match,
 	.ras_late_init = amdgpu_umc_ras_late_init,
 	.ras_fini = amdgpu_umc_ras_fini,
 	.query_ras_error_count = umc_v6_1_query_ras_error_count,
 	.query_ras_error_address = umc_v6_1_query_ras_error_address,
+	.ras_error_inject = umc_v6_1_ras_error_inject,
 };
 
 struct amdgpu_umc_ras umc_v6_1_ras = {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index e26728dbc6e9..2e87e7de4a55 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -333,6 +333,21 @@ static int umc_v6_7_ras_block_match(struct amdgpu_ras_block_object* block_obj, e
 	return -EINVAL;
 }
 
+static int umc_v6_7_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
+{
+	int ret = 0;
+	if (!adev || !inject_if) {
+		dev_err(adev->dev, "%s invaild parameters \n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	ret = psp_ras_trigger_error(&adev->psp, (struct ta_ras_trigger_error_input *)inject_if);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return ret;
+}
+
 const struct amdgpu_ras_block_ops umc_v6_7_ras_pos = {
 	.ras_block_match = umc_v6_7_ras_block_match,
 	.ras_late_init = amdgpu_umc_ras_late_init,
@@ -340,6 +355,7 @@ const struct amdgpu_ras_block_ops umc_v6_7_ras_pos = {
 	.query_ras_error_count = umc_v6_7_query_ras_error_count,
 	.query_ras_error_address = umc_v6_7_query_ras_error_address,
 	.query_ras_poison_mode = umc_v6_7_query_ras_poison_mode,
+	.ras_error_inject = umc_v6_7_ras_error_inject,
 };
 
 struct amdgpu_umc_ras umc_v6_7_ras = {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index 037791e90c24..f7fb653434b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -336,12 +336,28 @@ static int umc_v8_7_ras_block_match(struct amdgpu_ras_block_object* block_obj, e
 	return -EINVAL;
 }
 
+static int umc_v8_7_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
+{
+	int ret = 0;
+	if (!adev || !inject_if) {
+		dev_err(adev->dev, "%s invaild parameters \n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	ret = psp_ras_trigger_error(&adev->psp, (struct ta_ras_trigger_error_input *)inject_if);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return ret;
+}
+
 const struct amdgpu_ras_block_ops umc_v8_7_ras_ops = {
 	.ras_block_match = umc_v8_7_ras_block_match,
 	.ras_late_init = amdgpu_umc_ras_late_init,
 	.ras_fini = amdgpu_umc_ras_fini,
 	.query_ras_error_count = umc_v8_7_query_ras_error_count,
 	.query_ras_error_address = umc_v8_7_query_ras_error_address,
+	.ras_error_inject = umc_v8_7_ras_error_inject,
 };
 
 struct amdgpu_umc_ras umc_v8_7_ras = {
-- 
2.25.1

