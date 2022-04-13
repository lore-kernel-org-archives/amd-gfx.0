Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4832CC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 15:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A2E910E2A8;
	Wed, 13 Apr 2022 15:27:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60AA110E2A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 15:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNnkb02vL5ZqWADWhn0x+puNQxE+RhBznN8IwuejEbGkzRVxrJbFRGqD4tHw12AqTCGlEzo6rnOINte73q7DlVyjQm1liIo72mB/T0ZZ/eS/57Kd98mVQ3iVMoxGaLTUlwytuqe8pbBD5mMYOAqZR8U7W7/FYjyukBjElj+picft2guU+WjdUBuCRhfpml8Fux7Ga7rDgYrA2FPd7PJZ4kOXpd2cVw3SHiLLBvv6o2IZhS84mENVTpP7nIH39RnW/r4N9HXyTE4/di1mBQ9qx6dtH9aYuYqVhk/6+s1Ufo14YSeuLaJ2F1O9jL67R7kkKm0GwOFyH301t+auelJJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX3aJLFCdA73ZMdeb8oDq0PrH8Q1FgNHwlmkQywdcIM=;
 b=HEthHur6jHzTv/xeaxV+Zl/rIlV6Xb1MCDl8gHyY/FDUnhQyzkEPlCtNconA9atSmXpIak9qf1pp1ZKw7u9nG8f4t/mrZMbQozavH8yKqC7cPn/lWtCJO5zwa1JRevsYWYLP9ZX7iMI2Hv8zMaSX2SAAtEzEUreOwW+gPf9eUqfBR54y0lXjh3KsLAGn6FmdbZ9LBxw57itSeseIGuBNajIKCSwYhSnoNhncYYZMUHGIiflCg4o/UpTnjMcr2aUESSuKz8LMLnn0f2goaWSh9CalUPeSeK4QLEEmS5zoMu0zqJpb7YraUxtfidh+bk0lfkVgh10ZL02f+UrL27xkQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX3aJLFCdA73ZMdeb8oDq0PrH8Q1FgNHwlmkQywdcIM=;
 b=CFfRMJ5dI6Qac7eCdrybQl0t7w7vGvjAFLZKweqDfzwCd56MDL5GgSbOdct0fGgZE21zX13dXzZjFIZBbhwfAgtjO5si9z7p/FxOa9rfmIzj+iMdCFYpQgBILpzT895zgskApe3iD1XZBwZYq2Zzq0ZPGtfbO5x5Q8QK8gCmACo=
Received: from DM5PR07CA0087.namprd07.prod.outlook.com (2603:10b6:4:ae::16) by
 BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 15:27:12 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::98) by DM5PR07CA0087.outlook.office365.com
 (2603:10b6:4:ae::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Wed, 13 Apr 2022 15:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 15:27:11 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 10:27:09 -0500
From: Gavin Wan <Gavin.Wan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Remove static from variable in RLCG Reg RW.
Date: Wed, 13 Apr 2022 11:26:41 -0400
Message-ID: <20220413152641.830023-1-Gavin.Wan@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e56ac775-6e79-4c06-0420-08da1d621469
X-MS-TrafficTypeDiagnostic: BL1PR12MB5046:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5046A75569EFE38665E4984EFCEC9@BL1PR12MB5046.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kl6sWgClxavLdw37VGuhcz7JcCid43MdtTDohduIA/gUgaQ7epYPpQK1N/eZxDlcjF8ia5SwDzLq6gUZdJp5BwgNkl3ZH5HHDpz1rFpZ3vv5mA3Fqh9bdtdBcQBsPB7E3dI9+bIUVb37QPS0oBVffdCA0VwiGdlLw+zNLSwPmAMKom0fFddv9fGukBbNc1kKuPECV1CViFMeKp02tOlRTXkp4c4ffZk54h+DjXeAIHS6eaRLx7YehimfqJkreEn4eoLIANv2xynOAFEMQ//VNfqjrY1Rs+7Q63chVegGi/Inm1r2fkykY9OtBhTU4CHcgRUm3THyiy6UkUgyZ65/Xj0pmI1/Lw2IgnvmeQDD+7StSsyh985teQuf3M1bjdfUQNj+H0yUWoHoHlnIJQ2iWDaEEgjcBZSu21kAXDF0irRMu+l5eI8gROTnSrdVJ6BcY5+m9Rkgvgal+dv4i+0vfn8zRouZi4nPJJD9Oqy10C7AIq6mPd54hTJHcGZRJzG0QBsMTCf8FXq6b3nUkn3/AqASy715hthHZK9uFzUDf8v7unlhirTBf3xD+D6mxsFfaLEvPIyeJsyNoDH0q99rt1Gxio21m6CRrNVp8l0C1d2HdPt1G0EQS8avMZvVUsMSMmWkAQNAg720dp0U+Iak/kI9S0mv62dEE+93rdkDNP+tVTNPikERtAYu9mkQxrWHFJ7SEHsUgM+TYj76OiUR+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(36756003)(316002)(336012)(82310400005)(6916009)(47076005)(26005)(186003)(16526019)(6666004)(83380400001)(7696005)(81166007)(426003)(8936002)(70586007)(40460700003)(70206006)(86362001)(8676002)(2616005)(4326008)(508600001)(36860700001)(356005)(5660300002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 15:27:11.1680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e56ac775-6e79-4c06-0420-08da1d621469
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
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
Cc: Gavin Wan <Gavin.Wan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why] These static variables saves the RLC Scratch registers address.
      When we installed multiple GPUs (for example: XGMI setting) and
      multiple GPUs call the function at same time. The RLC Scratch
      registers address are changed each other. Then it caused
      reading/writing to wrong GPU.

[fix] Removed the static from the variables. The variables are
      in stack.

Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Change-Id: Iee78849291d4f7a9688ecc5165bec70ee85cdfbe
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index d5eea031c3e3..d18a05a20566 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -868,11 +868,11 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 	uint32_t timeout = 50000;
 	uint32_t i, tmp;
 	uint32_t ret = 0;
-	static void *scratch_reg0;
-	static void *scratch_reg1;
-	static void *scratch_reg2;
-	static void *scratch_reg3;
-	static void *spare_int;
+	void *scratch_reg0;
+	void *scratch_reg1;
+	void *scratch_reg2;
+	void *scratch_reg3;
+	void *spare_int;
 
 	if (!adev->gfx.rlc.rlcg_reg_access_supported) {
 		dev_err(adev->dev,
-- 
2.32.0

