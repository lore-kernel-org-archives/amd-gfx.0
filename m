Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2087CEB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jun 2023 04:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A088E10E34D;
	Wed, 28 Jun 2023 04:45:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23FA310E34F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 04:45:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3pFvfTVBXbLeeJPRK4yKKwMoTMCV7r0ksog/+7ge2uunvQH81I8VrwYs3ZAdc+qmd++IVOy8DAs1XxS/qCWLuPMzLRMZuMluOjbdOcwip9UH0i5lpIgn9l4fgsqwMvq7Yl8hZRe55qN42gsi3qZpk+N3S3xMfeJeSpU0UFLiv0weViKYWl1+jXQIklgl6MNzDzGk5VFGPrQtMLlPvgS1dGSAG3E05gJ+C2IJtqQO1AJDtaTh5dy+0PxKL8di/rF6k7zCTCa6bXeYSWSORpARtLHrbQ6sLGmFm/JhtfG4QngSn9C56NG24IL2QG0L72l6GxV2BzAwntzKxJuKCkOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chgpmlarUoC+QKQkFocTjHaI4XUyifcvIi4p4FkOAS0=;
 b=dU+qEGMu/yXVM9sjZifky+i3BpFqyB6MqOWWR4DDK4xksyIrU4vEm33Hwpcg5BnpPBf53L6KnRZvZepapIuwkXarcv6TRfi4HgiW/hWSM5XUCGJnSGpejZTCetsbBaOy6xl9ZKmy51+P8gedxY+ytr0gvtUAzME48dYaRoPbXbhFsRIuXa/3TSe949LCbuy/remcc7xkGkOkAO3aHS7KvXMzPf4xa8Xb11PNMq0YM6o+BOWMameNSFtv4NUvpN/ZU/mf7KPZS2v1IF8PJB2QiQDe6sQDk+UXBzeqMKzk90vcvjAcq/RPwOAEazud8OVVJjJWvCOzwztGDjnAJbuQbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chgpmlarUoC+QKQkFocTjHaI4XUyifcvIi4p4FkOAS0=;
 b=g0XH5HiJq/GkG0oZJpN4R+99FbkAMungag5P0A8GdCIMonrupCxyINC5kOCQeZ8RGjDlgt6cex3CdEYYcKyu79+73o21fxiTyk9Y3yyXgarzvhk58NepW87Bh6NETzR2LfOYzGFYCf0BiuuYYB5z5CFTjzI2Vn/uWt9gLITfmjg=
Received: from DM6PR13CA0012.namprd13.prod.outlook.com (2603:10b6:5:bc::25) by
 CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Wed, 28 Jun 2023 04:45:43 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::f5) by DM6PR13CA0012.outlook.office365.com
 (2603:10b6:5:bc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.16 via Frontend
 Transport; Wed, 28 Jun 2023 04:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Wed, 28 Jun 2023 04:45:42 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 27 Jun
 2023 23:45:33 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amd: adjust whitespace for amdgpu_psp.h
Date: Tue, 27 Jun 2023 23:45:22 -0500
Message-ID: <20230628044522.600-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628044522.600-1-mario.limonciello@amd.com>
References: <20230628044522.600-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd0f752-c667-45fe-0a9e-08db779287c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Br93w4rdO/fTHttr2El6B7IcZxCbE6oqpUKJDc0yQtNB+wimQWH+ZnlGMgVfY9q8/JVUL5HYK87h5hC6gOmTw8Tz8VLFFxKTuqEbe4/xE2s59cFKwI7mTWnYO9iIIeeeTNiSYbgHgclpOYycahUVgwbDHjQI+7fOvjxWyMW9jjimdlhRvKym7VwpPdWFJstDrbnG/7r60NXVjF10uFFCdMb+lSg9ThNUQRGo4iYKNJQfu59rL0B7Lzxkqo7cSzZRuRzUiYKyh//isFLBaPOr4YwbQaU9AzX6T05ZrsnSDcQYCVihHkS+8B/z2/X5EHEqAspTrr70nYOaPrLUVVxSxqqUFvdPa83yspJWd/6TiJcZM3qNUAAnZ/zuCLLyqfEWQSul1jZfOtG+oeqjaSfyfU/9RApUxmJoVj71Feg3q7quF29f5E+1Yu724nb5uKO6VBUiE49Wudw2pJSHa5g7B6JHWNcvYMHUggfZPVRfsOqxTPSpgC5/5gDmjqKRDe2FKDrDOa3ZXW2Yk2XH4IFKF31XhP+ZoSOmrK5fWGRJBd8Pgru2C3anqrrvRlf3x+fEqYNSds4rj67p+IY6MyHqB7TA0mLH36MONNmDTc4VTckq264Ex1fYn7ryi02vMU8VlKkKyed0N3OKxhnaDDPpuANpTHuL9HnP24kjtRmWZtpSoH8J+IrOH424dlycsbdA8CQaa4a5k31vorxe3POBGuTl2Jls+l/t2jf/3OL/1xXLcyxXrDY6vFE1zllllpEvHfyGFjCJ6Cdrc51ExmSdNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(82310400005)(36756003)(40460700003)(70206006)(5660300002)(356005)(6916009)(4326008)(8936002)(8676002)(86362001)(41300700001)(316002)(82740400003)(81166007)(70586007)(40480700001)(44832011)(47076005)(1076003)(186003)(16526019)(2906002)(426003)(26005)(7696005)(83380400001)(6666004)(478600001)(2616005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 04:45:42.9175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd0f752-c667-45fe-0a9e-08db779287c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adjust the whitespace to be consistent with the rest of the
`struct psp_context` structure.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index e176cf204202f..050230114e88e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -309,8 +309,8 @@ struct psp_runtime_scpm_entry {
 
 struct psp_context
 {
-	struct amdgpu_device            *adev;
-	struct psp_ring                 km_ring;
+	struct amdgpu_device		*adev;
+	struct psp_ring			km_ring;
 	struct psp_gfx_cmd_resp		*cmd;
 
 	const struct psp_funcs		*funcs;
@@ -339,7 +339,7 @@ struct psp_context
 	uint64_t			tmr_mc_addr;
 
 	/* asd firmware */
-	const struct firmware	*asd_fw;
+	const struct firmware		*asd_fw;
 
 	/* toc firmware */
 	const struct firmware		*toc_fw;
@@ -388,9 +388,9 @@ struct psp_context
 	bool				sup_pd_fw_up;
 	bool				sup_ifwi_up;
 
-	char *vbflash_tmp_buf;
-	size_t vbflash_image_size;
-	bool vbflash_done;
+	char				*vbflash_tmp_buf;
+	size_t				vbflash_image_size;
+	bool				vbflash_done;
 };
 
 struct amdgpu_psp_funcs {
-- 
2.34.1

