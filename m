Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7712C001DB
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 09:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C0810E3D5;
	Tue,  8 Aug 2023 09:05:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 316C810E3D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 09:05:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkB0AsSffKOAxq8Glb/NibQQ+8woW5/Ue9XPBZFCt5H2/65X8vIW1tLCkDMgaD8NOzSl7IbLtBVKXO2i04I8X9MDUxmRlUsXTcBUXhU155M8BTVHI6/v8WrGxxDBE01Xpp8lnu3FY/7qJh7rUMeyAyFFNttpsCPZE7TL+HG+nKwSKb3EiR8mEjCU7/kX9YlJVh9g2nfz1+Y0TRdeHPi0gfwjSXQWTAYUWOAnjbyVKCQDIzKGtvAC+3OAI7sCohUob0uP6A22RNG5OtZQLm5k++sCeBto6XtH2gsXWAD1PW/UBI9w92DJYRBzxPb8GJo4hZSVjy5bLTM1etzVmBgMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qp22EEetoQ3LpWswvyxvuIjpSRKYo3EfUrEocNvWRuY=;
 b=VWZMP3xoyqsMU81UUF6XVcWJzEKPtxcuv5ThUtW4pxgIhR53moiFwNqoJ9Ed3Cm/lR1IDlBKfSQWi9urKPx0RZpOpH0p3pHD+6fwzhixY28Hf1VWypdkWhR9flGV993L55Opiqma3IJot9YkFB86Zd9XYmI+SFFlYf82kqMyrSx1fiRT9xfYef0sQMREhCCRG7VyR1baea8azhiQREoZoLZwIu5foXrX+WWYqoa8+NfxY78N1jWat0Ys5NSkv3WEIflTeKi4kxGxFKsaHEtyQg/Y1FY5WQK6sYL2LDWeHV+GjgvkvRs3kv7B/U5SURTTbRoPZSSDWpEwAnG5jyK72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qp22EEetoQ3LpWswvyxvuIjpSRKYo3EfUrEocNvWRuY=;
 b=FHrAmIdaQee/c9CagYi7rbstJqciggl4YeAtBL6ProlV6OMicFRG/xO13yeU6zsKfnjFuvEzTyjtZivWxNtTZhqjml5WoH62gyasMmNNt55rEXCdM+31ij5fyIVP1sv7Ys5/Sf1BNE8YeLTlc4AP+Fw1SGqGcDVpX5FsXPUmha8=
Received: from BYAPR05CA0087.namprd05.prod.outlook.com (2603:10b6:a03:e0::28)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 09:05:35 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::ef) by BYAPR05CA0087.outlook.office365.com
 (2603:10b6:a03:e0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.16 via Frontend
 Transport; Tue, 8 Aug 2023 09:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 09:05:34 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 04:05:08 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Extend poison mode check to SDMA/VCN/JPEG
Date: Tue, 8 Aug 2023 17:04:21 +0800
Message-ID: <20230808090421.1998382-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f24649a-deb4-4381-97cf-08db97ee9ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3scV9OdTUhMJA/ixKTBE3NbQR7ocLORpCXFqhxxPQbwNAiUDN1AYZ6J0baKxXF3G72BeIsNvYMkWF7GkaQf7k38BVd00uEid+9atiMxGZKf0Vm7y1Plds/iOVl1gCLX521U4S5b+I6YowlYcWoHKxGozWL118S7vIZMwiW2jWh0Vm3nVUGAblTgDv0jQ6pjibKe7Q1Ay2CZkc0ph5zI2xE7Jxe5dYNJv7hARge+GLkBkV+S+hoq3YRC18/a3gjMD+7+bJwAKgGBCfLp9tBP4qxHtCjV7yAFvrRHH/RzzLDAzeY5xRSxNWfZkLppJWpI4J/UYoWvONo1LLF46AfbYUiVN9GLKKxLJZleOGidlqG7UM9YdfhXYQMZLK4nRocxsyvE5HuI/maLLs/HcCuJY5a+c1Cgkkfx0FrRx4AjHmu2Ga4eAXA5gJ68zM0MnxKgHbwsjGsHMXrGhBZSNIxgT4kJnPsvnKOtARf45c/LuJq4LIp72sh9nw5eeNsruump7uTlxmLIVZ9NaGBrJLwhy3ZKAj6dPbQYtJr0LwXbLSyi73mWIO20rqXjgbI6HFoBLpvpUfArkL0W0LbQRIu6wZ5q1g3Zr0OUakUSrx+sGHxJEW18QBDMZ/+qQ51TmQO1TZKnk2qCVneXnLk3A9fCIz63zvRFxlpa+CfUQfO6qgLzkGjeJ92aWLd8+r61R8E1nk2t0Ul7/kLNFVJBSoutZtKtUBCOmV/JYm4Ue5zlwsgDLtXfZxF64vaOrcdOfuwYdoUNfFTVKi5Z3Fkt6teTyNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(82310400008)(1800799003)(186006)(451199021)(46966006)(40470700004)(36840700001)(2616005)(1076003)(26005)(36756003)(16526019)(336012)(7696005)(6666004)(82740400003)(478600001)(81166007)(356005)(70586007)(70206006)(6916009)(4326008)(426003)(41300700001)(316002)(8936002)(8676002)(5660300002)(44832011)(40460700003)(4744005)(2906002)(36860700001)(83380400001)(47076005)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 09:05:34.3611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f24649a-deb4-4381-97cf-08db97ee9ffe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Treat SDMA/VCN/JPEG as RAS capable IP blocks in poison mode.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index bb29cb57add5a0..8e9cd05dee245a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3143,7 +3143,10 @@ int amdgpu_ras_is_supported(struct amdgpu_device *adev,
 	 * that the ras block supports ras function.
 	 */
 	if (!ret &&
-	    block == AMDGPU_RAS_BLOCK__GFX &&
+	    (block == AMDGPU_RAS_BLOCK__GFX ||
+	     block == AMDGPU_RAS_BLOCK__SDMA ||
+	     block == AMDGPU_RAS_BLOCK__VCN ||
+	     block == AMDGPU_RAS_BLOCK__JPEG) &&
 	    amdgpu_ras_is_poison_mode_supported(adev) &&
 	    amdgpu_ras_get_ras_block(adev, block, 0))
 		ret = 1;
-- 
2.25.1

