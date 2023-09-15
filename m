Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424D0EE6456
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 10:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C810D10E61E;
	Fri, 15 Sep 2023 10:57:38 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E01B10E61B
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 10:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWPA3UwyGFN7J+Jk9IuawcUZ9IwOl+qATCoou+RO8lsU1ODZIAV08BOXbhbKQmyXWeSOtBgZc2kSAmgQ7Z67MIE+iiPtL2j0iDWji+NSQgwGN/KcurtcJKHxYT0E4So7c+iHoC75pzm9dkHz6K3Nd64ryUfZeScK/6pxNe3DgWF0ruhxzoUKXimM2FUS7Pgq5QPIC38KROgHA59g5Qc5UPSyxJjUxosCemCIU3+NIcTj6To6GQaSPXquQgKsf/cLWvHrYCNVJjubi52i/sVPkcfmwOIJ9EfZChKzQf+o4irBW7GRDR9nMWQoZGsw/IMIfCXdZCDozZO964EzLdvIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qldFVlsQKbawyXj+k/LM/XA8/70X1O9ELygqAecIJvc=;
 b=QgjmNS/2JDvWAHplNtfjPG+AvLyrLkBZdHF7QJtiVmajLIrh69itL27aI0I40uLSooDboKHFp7IfwmQQwPMwLKOoBmgqz3g2tSI1FucJD/zCRO/f6G8gDKxbisHW9t85aL254NVoAKq/rNJrkAqeSfyE6XXvM2flmLN+kHjMpf/Liigjv9ypxQArPE5w30JKVE5EoVxRbDoBTXfLZ/JDH+h4xkC55H6KhDxSTQHeKCI0TF8LeMhWdPXLcRdFN/fb59HPj9o1atefgb0CKJ3VfisskIq5aDSvhNwXBbrPbwZ/W9y1EZF99kTc3eelP8cVEV7TXwNxBcTHo+/qyLlYYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qldFVlsQKbawyXj+k/LM/XA8/70X1O9ELygqAecIJvc=;
 b=PA5HNlPHWzzVUz69YuR5i2RN+ZC5Exb/mjacM+9F3hRu48Q6k9ooIiWk03btZliv7sYJvKbMkfaDDtjP05UBGMUnDRyRXclxiCST+3xGoGfAIHHVY59ppbTDnkdbjglCOTmMFT0VdVtti7hzw/wpkGavfgn2bL2mUj3nwEwsZrk=
Received: from SN6PR05CA0030.namprd05.prod.outlook.com (2603:10b6:805:de::43)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 10:57:33 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::f5) by SN6PR05CA0030.outlook.office365.com
 (2603:10b6:805:de::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 10:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 10:57:33 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 05:57:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 03:57:32 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 15 Sep 2023 05:57:31 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: Fix false positive error log
Date: Fri, 15 Sep 2023 18:57:29 +0800
Message-ID: <20230915105729.1849284-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|BL0PR12MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb4c398-73d9-4aca-7a5c-08dbb5da905c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spq9FFjv7FBSm/6+AsNLS/cvBD2o6hmTQu/faDk88jxGr8J2XSUYVyMoL42y/SSV5x0RdteOgP87Ms2UNe89Yf2THUGUo+cnNYIvXFVG63YJcdWO/PJpF2yFiWbgOblPCEi7n6CxCnQNxgwIVMVCaKChLBg/koWz68pWMfzrqZ1fc5gT3tM39tDEGq6TqSA+EayUc0U01b26xWnnAdAsM5CG9ot9SlbLmUJhi4Fz0POV1G0e38GrHk3xGli5M5cb2rUW7SPFtBAQhuuCjj89mFf2uyHxSnvtJTjntrpiIVmTtYLDY7mvGYGLZe7UOllh2MtcfXswfP3ZKm93C4ijuBE8RVNcsG4Fr4+YMnVI4AXxBpnbh3X054t2lInbgP7IUX2Hrm3z9yFcQnIi1X2fIKWVKAuUQ1gKg+9r/gFF56GY6Cb65PmPEupPvAYjwUovqRbkcOWdDN2F81UjJ5RC1JvbKZyInNAVI1sHAnth9WskAaY313OWjmFC45Srn1I5daGgfLMDDX8YVqiIL6MGSPdkOlKbO3CCmHoANd6ZXzQFrhKCuYb4ELFKWghX6sA45664N3tTufZCQ0RpbFoGu16braj9mimWft93O3oOxtvfQ5KWNf//iEbvhZ01feckT2pyMZ4Hs5XjLXeWfyJy0e5XBV80hlcGR8hTVHcC2mokvYWIXCyS7cHm1YATN4+8dlSI9vE8SToKNZG/9WXHGyR3hcw4JBNW4h2kugAmvE+p7+YAsSJFHUkz6Qs+V2MPQ/DFWiCcBu+dbNL5t+ZUxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(478600001)(1076003)(2616005)(26005)(356005)(7696005)(81166007)(40480700001)(40460700003)(82740400003)(86362001)(316002)(6916009)(4744005)(70206006)(70586007)(41300700001)(83380400001)(36756003)(5660300002)(47076005)(8676002)(8936002)(4326008)(36860700001)(426003)(336012)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 10:57:33.1753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb4c398-73d9-4aca-7a5c-08dbb5da905c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It should first check block ras obj whether be set, it should
return directly if block ras obj is not set.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4a6df4e24243..ee62f5fa4456 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1105,10 +1105,13 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 {
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
 
+	if (!block_obj)
+		return 0;
+
 	if (!amdgpu_ras_is_supported(adev, block))
 		return -EINVAL;
 
-	if (!block_obj || !block_obj->hw_ops)   {
+	if (!block_obj->hw_ops)   {
 		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
 			     ras_block_str(block));
 		return -EINVAL;
-- 
2.25.1

