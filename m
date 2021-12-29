Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DF4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 06:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 199F110E3D8;
	Wed, 29 Dec 2021 06:33:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1038C10E405
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 06:33:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1+IcUbRm7tbD4WgLE7FKQfI01QSF1SsXfJlR1bzJS6bxu2viHtaInmeJtwkR7RoYJZhiSO0a5UiJpLE0NzC5FWNWz9zRC/h4f7ZkEGcRFKYvUHbM7Z/hl3yGYVP52GgiLTEfrkvS724EV/jD0Ka6n9TnMxc5wzHovoDB38t15LtZFjlkVAwQ5urx7P/mHFF9UiG5uV8ACCRXviNsCEVdFkMdWkTEFNuesaXpZEcXwyuLinettm/QI2cUU8UiKHQLVJwtlyezRqX60y8CtnAOsjCO7zlVCFF6ZWR983K/NYTmn+0/QA+jUirT3f9GB+zV/ZMcbNIMO5qJiil7XRt1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4ZHaXuAzJXSmZ8sZ7aA7YO43FpBpLwsTBWIZz6HVd4=;
 b=SioQPIKa+FHJKjMqz4G3SUSv4MIaI3A0hE7JUoDzBN+5HZEb7xMABxTAazrjlWZaOfOVRsg1dEY2ou7sr+ESFqsREiicPRnzpRaXNjaVZAQ+nxIo/WA+Tm0NjcItZxg0/rVcQH1c+6j1AgAXA3MOFA+DBqK/7kT/5lqEMyTgHH8oOt5k9sTLVXLSsxwHVjdfs05q4JN3lpcVVJt2Tml8G2887+DlwbQYguXmkcb83yBjaEw4v0QCS2nF1nF04f0IJZRt6X4iblw/vE6SK3lExa5dM3ohIjfVg01MW29rumYL55EWGNdTfTSGvqI7F3bICDcKgM/MehFhd3lj9FwScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4ZHaXuAzJXSmZ8sZ7aA7YO43FpBpLwsTBWIZz6HVd4=;
 b=tmrhlwrQDvMTSi00yEIS+DbqebIYEzyKSSLFDmLuLIXQVX01HxdTbmVMp57KifZCVpZCQ9qrF6aLN8PS1NNWk6U3bQhIbVakH36A8P3TTf4R7iIslOdkyzf/F5c7cY8r5SzOHSH+qf8YNggQntvVlieP9iO7uGWFQ5BFW2QzUzw=
Received: from MWHPR04CA0069.namprd04.prod.outlook.com (2603:10b6:300:6c::31)
 by CY4PR12MB1671.namprd12.prod.outlook.com (2603:10b6:910:c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Wed, 29 Dec
 2021 06:33:13 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::32) by MWHPR04CA0069.outlook.office365.com
 (2603:10b6:300:6c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Wed, 29 Dec 2021 06:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Wed, 29 Dec 2021 06:33:12 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 29 Dec
 2021 00:33:10 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 11/12] drm/amdgpu: Adjust error inject function code style
 in amdgpu_ras.c
Date: Wed, 29 Dec 2021 14:32:10 +0800
Message-ID: <20211229063211.43840-11-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229063211.43840-1-YiPeng.Chai@amd.com>
References: <20211229063211.43840-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4660397-5b9a-495d-2b94-08d9ca9516b6
X-MS-TrafficTypeDiagnostic: CY4PR12MB1671:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1671BE755F1290A8C42C4ED3FC449@CY4PR12MB1671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:356;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vTC2gR8jRFuAOazgAB0/yjunD+UVveWgNPyfsEEWEblPDpJLE9xEjna7l0S19oAoaS9T/i0fBT08VHExwEsWrAiXoM9xC8zBDqR/ezqtVrNjHYYvysVHLYtGHuBHP647EnZapNl//iBfRrHHKW6/uhqPVxZkMwxOI8Dgp7za0VikK+LcxR3rlES3C1zZCOlUV2iMTWguhOFLqxKKq/Lk756F0OSVNEgjhbUxVTpg6OPYTO2j12mhpgyLcfqMW/Vb4X/kcbDZi3HsAvir7TjDEQU4aDy7F4zEQakk206KTO8i97Io8Ln0hYrL81dtbeiS3TUfknmxX2AGpJ277GmGkahnblRXqcx+OZ1yKU3fK9SUWhcQzWlB9m54VPhS6mOjfMxwMFRlyn3xVCqRM1p4MoxP9qaFDb2SbXzmHwWUri8CmvuS8qgA9nTdV1Vp6PYKjrf2lcGd6O8QyY8A07ZdZEaI9La90YRh7Va+rANCD07IayXsOACvMQqwmMWG3o/wLemCNLbOlN/ZGDROrYKjR86+EUul733nEAhZQkDGL1o++/uVrYqujycIVT4HsgDcU7rzP/Ytny8+kzvyCSuw8Sso4ZOWfnRxknmhTQ5TUVYfjcTPOO/e/4TFcZK2eB95JG2mvEhH1L+v1mpASjs271YqByrI5r5ojPBDbc3cVJfWQM58F2QPoTETrgoxhilty86LH7duZi35z0KE/LgRey21TNxA8e4uEF12rLEr8XAQD50ax+v6QENvYEECH7TwnCNtOBnTlzSjnWmQzf3CcVSkMKlMOI0Sp+yA9GtR6galaZoxfOI5oQPWlyHt6QmIBR2zFz8k+CwpdxNSr4WeKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(2616005)(5660300002)(426003)(336012)(186003)(36860700001)(54906003)(82310400004)(2906002)(4326008)(7696005)(83380400001)(8936002)(316002)(40460700001)(70206006)(8676002)(6916009)(47076005)(70586007)(81166007)(1076003)(356005)(36756003)(86362001)(26005)(16526019)(508600001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 06:33:12.8048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4660397-5b9a-495d-2b94-08d9ca9516b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1671
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

1. Move xgmi special error inject function from amdgpu_ras.c to xgmi block.
2. Support to use psp_ras_trigger_error as default error inject function in amdgpu_ras.c. If .ras_error_inject isn't defined in ras block, default error inject function will take effect.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 60 +++++-------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 27 +++++++++++
 2 files changed, 39 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index edba3ee292c8..21765e05b003 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1047,32 +1047,6 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
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
-
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
-
 /* wrapper of psp_ras_trigger_error */
 int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 		struct ras_inject_if *info)
@@ -1091,6 +1065,11 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 	if (!obj)
 		return -EINVAL;
 
+	if (!block_obj || !block_obj->hw_ops)	{
+		dev_info(adev->dev, "%s doesn't config ras function \n", get_ras_block_str(&info->head));
+		return -EINVAL;
+	}
+
 	/* Calculate XGMI relative offset */
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
 		block_info.address =
@@ -1098,30 +1077,15 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 							  block_info.address);
 	}
 
-	switch (info->head.block) {
-	case AMDGPU_RAS_BLOCK__GFX:
-		if (!block_obj || !block_obj->hw_ops)   {
-			dev_info(adev->dev, "%s doesn't config ras function \n", get_ras_block_str(&info->head));
-			return -EINVAL;
-		}
-
+	if (info->head.block == AMDGPU_RAS_BLOCK__GFX) {
 		if (block_obj->hw_ops->ras_error_inject)
 			ret = block_obj->hw_ops->ras_error_inject(adev, info);
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
+	} else {
+		/* If defined special ras_error_inject(e.g: xgmi), implement special ras_error_inject */
+		if (block_obj->hw_ops->ras_error_inject)
+			ret = block_obj->hw_ops->ras_error_inject(adev, &block_info);
+		else  /*If not defined .ras_error_inject, use default ras_error_inject*/
+			ret = psp_ras_trigger_error(&adev->psp, &block_info);
 	}
 
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index e3c6898c5d13..a2bd3a2abe72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -940,9 +940,36 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 	err_data->ce_count += ce_cnt;
 }
 
+/* Trigger XGMI/WAFL error */
+static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,  void *inject_if)
+{
+	int ret = 0;;
+	struct ta_ras_trigger_error_input *block_info =  (struct ta_ras_trigger_error_input *)inject_if;
+
+	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
+		dev_warn(adev->dev, "Failed to disallow df cstate");
+
+	if (amdgpu_dpm_allow_xgmi_power_down(adev, false))
+		dev_warn(adev->dev, "Failed to disallow XGMI power down");
+
+	ret = psp_ras_trigger_error(&adev->psp, block_info);
+
+	if (amdgpu_ras_intr_triggered())
+		return ret;
+
+	if (amdgpu_dpm_allow_xgmi_power_down(adev, true))
+		dev_warn(adev->dev, "Failed to allow XGMI power down");
+
+	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
+		dev_warn(adev->dev, "Failed to allow df cstate");
+
+	return ret;
+}
+
 struct amdgpu_ras_block_hw_ops  xgmi_ras_hw_ops = {
 	.query_ras_error_count = amdgpu_xgmi_query_ras_error_count,
 	.reset_ras_error_count = amdgpu_xgmi_reset_ras_error_count,
+	.ras_error_inject = amdgpu_ras_error_inject_xgmi,
 };
 
 struct amdgpu_xgmi_ras xgmi_ras = {
-- 
2.25.1

