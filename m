Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F22C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 10:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D8761360
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 10:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D8761360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75966E147;
	Thu, 22 Apr 2021 10:02:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C646E147
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 10:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Irl8/HT4wTqOaKu04my8V5g5u9dtGgfLBCQZzx7YcdmKEVv6xf7tNa3gW/I2uhCHxXjlGqJF/UqGZot9bZ9Xp6Zxwoykt4KcKLXn9HXAew1vlLGgVG3i/C/41dGFVJ/TMuIK2v0Pw/vnVnkzhNkQGFZ8b07nO251dcxj/OGUo9cxDrj9ilUqVo+87fHtFngYr3fE/EYqX7exO68muXbMtj3wUZfJuxtgwXvbu/NzBPh3gziip+/rIms3uG82RF3mKQnHwaszqC3nkgUg33/4qA5UW4TslnJu6sw7eZxFrd4EmT1g5rgsX9T3FEnscbqRsbFKxC5JZMhM2C7W7Arblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5Ct4dj4iYrSYBiQ5hoy9DWHs9sI+l4KpNoppi7/vsg=;
 b=Ph6CjM6+yoMRjSi9EgJIpCoJKix92bwAlxvaojFa8XGvIHfH82HrfkLxNT/qJuk+EVg+fE6wFs7G85iO/Rs3+pDTcGxFSaB3onNyFbGbqG7fGBgprEhf+sBE0QlomArkj58BkooUXWXe1RshMy8UmaFIRJqNGfFPiZSsLxWKJcgHf4bhHX3PUn72MAANDyF8IzkF2hV0GBoRCeDacKlycBpykY9A1Vw7j2qihlES6Ba/730CCKUW8oJ+p8bLK8z9vuJrwcyDGl+YB+FxFdfsp8KjGejD7CxkuejlR2nJ7+5aWkkURMoo4/e/4KVoVBgij7KpTSeNFW6AJlKgYIk0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5Ct4dj4iYrSYBiQ5hoy9DWHs9sI+l4KpNoppi7/vsg=;
 b=sRGZIv8OOIeeNtvnV1bkeRIYocb6OBAxkOA0GRbZIR384nryawA34a+SRWkuEvyinPLEsf+NpsBzqUaFUAKuLh32TGg6TsrpNnsT9w3EcjgkzpHMpGeqt24tN2ODDMVONsxKhv99+keiQ0oo5fTm6y5+iWQLfZ5LKb9QuQPminQ=
Received: from BN0PR02CA0041.namprd02.prod.outlook.com (2603:10b6:408:e5::16)
 by DM6PR12MB2873.namprd12.prod.outlook.com (2603:10b6:5:18a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Thu, 22 Apr
 2021 10:02:22 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::ad) by BN0PR02CA0041.outlook.office365.com
 (2603:10b6:408:e5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Thu, 22 Apr 2021 10:02:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 10:02:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 05:02:21 -0500
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 22 Apr 2021 05:02:20 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <emily.deng@amd.com>
Subject: [PATCH] drm/amdgpu/sriov: Remove clear vf fw support
Date: Thu, 22 Apr 2021 18:01:53 +0800
Message-ID: <20210422100153.57655-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a45c264-be57-4007-730a-08d90575b91b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2873:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28734DD61C3A040DABB19632FA469@DM6PR12MB2873.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nyNl581D9N/ZMABuhiFy+ToI4U2Z98OCvTD8pW8aeleXid2x4uzO+WZkmu4jzq9sce+NkqdXDc3Dr7A4mwebtxNid62rJZ53+iDK1qIM0UnQUVG1ufJ9Udft7HIkqS6/NsWBshlf1Fx1rOBQi+z6chAYDg8ifxi62rbDNVNF0a27cQE02l+PZerhe9cs9K+38k+Bz7LEd+h80shnzUj0kC1M7npVFFGxPQsUOEiWgNR+EYXjqqMtme6mGrdXBeJ2isbF4n+oNwWkd1ax/11f30tts2p1saANGjGHhJ6y4Pz8uiAejLA3jdPi4BRExCk8iOd+ZfHEDL0KmacUQwoRqKjvGrNP24yFx5A90CEPd9tXKl6IZQHJFjtHnv8zbgM0XXcCjqcUSMNOrtHbtN/VO0hI1BVYNzJOzVQC5kGyxTvmomNkjQdoFy6SvuAzuCiFb9xb1gL+TzO4aA0sLPqAQybMItsAyWgI+nsd0UR3WgRERiy8dWsiV9+6skDV0WDAiBpUIPxTDHLZZoiXxXda0WqD6FkjJodsiqUh5Gcgm03/1T0oDwKrvt/3OT9aDO0w8F6ys81FoDhYZ7FpmMs0vrVwl9jATxKx8U7aVei6Fc4V5nCIWXmkaq/PlOI1z8zzyefzHT8zbOeSuB34tWPz0zPoGjEwVBpsXXQu4sHrLDPhTpZsg94RjOW1u9Y6cyLE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(36840700001)(6636002)(8676002)(1076003)(7696005)(82740400003)(70586007)(47076005)(70206006)(6666004)(4326008)(86362001)(8936002)(2906002)(426003)(2616005)(316002)(26005)(186003)(336012)(5660300002)(36756003)(81166007)(356005)(82310400003)(36860700001)(83380400001)(110136005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 10:02:22.4092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a45c264-be57-4007-730a-08d90575b91b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2873
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
Cc: Victor Zhao <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PSP clear_vf_fw feature is outdated and has been removed.
Remove the related functions.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 32 -------------------------
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |  1 -
 2 files changed, 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 9311dcc94cb6..623044414bb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -417,26 +417,6 @@ static int psp_tmr_init(struct psp_context *psp)
 	return ret;
 }
 
-static int psp_clear_vf_fw(struct psp_context *psp)
-{
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-
-	if (!amdgpu_sriov_vf(psp->adev) || psp->adev->asic_type != CHIP_NAVI12)
-		return 0;
-
-	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-	if (!cmd)
-		return -ENOMEM;
-
-	cmd->cmd_id = GFX_CMD_ID_CLEAR_VF_FW;
-
-	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-	kfree(cmd);
-
-	return ret;
-}
-
 static bool psp_skip_tmr(struct psp_context *psp)
 {
 	switch (psp->adev->asic_type) {
@@ -1925,12 +1905,6 @@ static int psp_hw_start(struct psp_context *psp)
 		return ret;
 	}
 
-	ret = psp_clear_vf_fw(psp);
-	if (ret) {
-		DRM_ERROR("PSP clear vf fw!\n");
-		return ret;
-	}
-
 	ret = psp_boot_config_set(adev);
 	if (ret) {
 		DRM_WARN("PSP set boot config@\n");
@@ -2439,7 +2413,6 @@ static int psp_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct psp_context *psp = &adev->psp;
-	int ret;
 
 	if (psp->adev->psp.ta_fw) {
 		psp_ras_terminate(psp);
@@ -2450,11 +2423,6 @@ static int psp_hw_fini(void *handle)
 	}
 
 	psp_asd_unload(psp);
-	ret = psp_clear_vf_fw(psp);
-	if (ret) {
-		DRM_ERROR("PSP clear vf fw!\n");
-		return ret;
-	}
 
 	psp_tmr_terminate(psp);
 	psp_ring_destroy(psp, PSP_RING_TYPE__KM);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 96064c343163..f6d3180febc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -97,7 +97,6 @@ enum psp_gfx_cmd_id
     GFX_CMD_ID_SETUP_VMR          = 0x00000009,   /* setup VMR region */
     GFX_CMD_ID_DESTROY_VMR        = 0x0000000A,   /* destroy VMR region */
     GFX_CMD_ID_PROG_REG           = 0x0000000B,   /* program regs */
-    GFX_CMD_ID_CLEAR_VF_FW        = 0x0000000D,   /* Clear VF FW, to be used on VF shutdown. */
     GFX_CMD_ID_GET_FW_ATTESTATION = 0x0000000F,   /* Query GPUVA of the Fw Attestation DB */
     /* IDs upto 0x1F are reserved for older programs (Raven, Vega 10/12/20) */
     GFX_CMD_ID_LOAD_TOC           = 0x00000020,   /* Load TOC and obtain TMR size */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
