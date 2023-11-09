Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81403C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 07:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB12B10E1C0;
	Thu,  9 Nov 2023 07:37:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A1F10E1C0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 07:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kuae4vedJjOaistlGt5GZdkTw4nRJqNXsJBHJGCkLeH1rrEzYNbsx+1jdMU7C/1X0sMxz4ScjgLnQUCCGWDGRsnQg2zhihsa9bRw2M+h/hRg1cPptlCmR43BkHS/P5U5hMoTPN2uoqK3rSZQQT9iIC0DY+bNXqJbblFKEqqg1px7FzpHbvSWDRzzO/eQMOR4jlDUdUiKHJVUaruCRjZswq/qvcb7pUQYq6WO3/uhBkQ8wqkB8zBxxsT3rcE+dJ5+nNZNBryZSO57LGBk24WlVN3JgOhahhIlU82dQviPRq9/6gMtQdwZFK6EccBlc99SnOTSAUUW2qYFMiJfTkrPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4matvSVUU15rm24a4pxL1FwzdxiAH00MPp7/7TIviA=;
 b=cOsy+pPv2rSd6SkH+swViBwSu/v1kLhFSVATGl3tNcwZO6fElSX0Ds6lWfC8uBqLevB3vpWxXPnEnudC1RcDIiRjk+CHfPP0Tbs8H1r9WOHRfb1ICKni7xJ1OOS4zNcVVm34MLMhrmjM1TkEvug24wA+aBMDtDnCy4+B7l3cVEPul/XP+1OtqAwUcyui6EeHUuXHZ7ZDow8y+ppml8+Ozn7yTb2o/BIgbkJDMMVBErqxdxZNSReLAaN+DeZQwDiXr2wdp/Pi8d7BH6caeP7xYwArpby6dD7ftN7+ZaEJneR+Klec3Z6WN+2SSTBXz12QnhqAVYN/KsUnAzCawBXsyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4matvSVUU15rm24a4pxL1FwzdxiAH00MPp7/7TIviA=;
 b=UIow0fVuFlBsmk6iWndpleQmpJgsX8t1pscaBLjBn7tEZXo4doGmUKqqlMfJmPzARqq7E3YRCcd8fjEVKCrQH1VOxkXUTxIZVp0fbNg46Sj4HvH62aeHxwgPinlKUTqIzPfKXj5Fdlm5Tgqamjmt/3ADAhvlu1Czsdz2eft3C1w=
Received: from MN2PR10CA0018.namprd10.prod.outlook.com (2603:10b6:208:120::31)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 07:37:14 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::2c) by MN2PR10CA0018.outlook.office365.com
 (2603:10b6:208:120::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Thu, 9 Nov 2023 07:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 07:37:14 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 01:37:12 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: correct the amdgpu runtime dereference usage
 count
Date: Thu, 9 Nov 2023 15:37:00 +0800
Message-ID: <20231109073701.1751965-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MW3PR12MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: a42a31d0-6f5f-45a4-a922-08dbe0f6b12e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzF/YltlRTQDg7mZ5Dg+QrXz3TMmVPLsXjk+FQ1LWMxACeJA9XzmeQlDyg5X9jJK9tFDye8mezElfrbhACl4blIveke5/Ld2yxifStyxd33F/6mC/EQ6s6/iOoAtmmVWMLIMG0Fn0kQnWzVhV4iQ+LwMAhsw2onrNSk5G02u4PW5PW1n+AJkSgEQ9d6U/vg1AfHmBnByV1+uYetcWFo0IJdw6uGp8QSpB68UzMu5FvRjrbQUAtVmIvuHG7VTojOb1mvcDrQx5og6anXVTVulUPbxunATaEnWOYcpgNv6/9aJIABySJdzL3WEn15b8IZI79FzpWD77rQFwS7Cd5+Arw3EjinM6w747aECkIaYhR3C+iG6h7qMeSHfTKRWEGfTUAx7HbzMZWQsUK6wzTMiXkotAJegckgr5TWBcBi4IajKPTayhBBOIl44m+kUwiWHRNl/S6g11sBfHt+epLKu+5JmZ2eynhQ+rxJ2WJqR4RVPzRJPMGOVX3Yocvyed01R8jv8mEPw4oMr0fdQW4SN5e+/fKFDQuogwdCykKiXBufH+XG+g9Dc3wclxfCSds95Ky+GPFeO57j368P1c0Juny/OUSzzjlfduLJKyt3EWvzadVw3oUlG74+5ub9jZz/r3RKs3dLXqZhG7DWyAS8pNTf8tLxGb5FwS787w8HxXDqZAfnJOCLHtOJIo42CVa/LU7+fl1hRPjU5L76XIXVhF3nK9eaMIHV6rExcTU5tYwPrvQs8oGbVFM1oD8ohjpWF5+GIYw6dFEMjZU1vpQe3bQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(6666004)(478600001)(70206006)(70586007)(7696005)(26005)(336012)(1076003)(426003)(2616005)(41300700001)(6916009)(4326008)(316002)(8936002)(8676002)(5660300002)(2906002)(54906003)(356005)(36756003)(82740400003)(86362001)(83380400001)(47076005)(36860700001)(81166007)(16526019)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 07:37:14.1790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a42a31d0-6f5f-45a4-a922-08dbe0f6b12e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the amdgpu runpm dereference usage count.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index a53f436fa9f1..f6bbbbe5d9f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1992,7 +1992,7 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
 
 	ret = amdgpu_dpm_set_soft_freq_range(adev, PP_SCLK, (uint32_t)val, (uint32_t)val);
 	if (ret)
-		ret = -EINVAL;
+		goto out;
 
 out:
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 0cacd0b9f8be..ff1f42ae6d8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -346,6 +346,7 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 	if (!active && adev->have_disp_power_ref) {
 		pm_runtime_put_autosuspend(dev->dev);
 		adev->have_disp_power_ref = false;
+		return ret;
 	}
 
 out:
-- 
2.34.1

