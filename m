Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D687FEB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 15:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5929D10E27D;
	Mon, 17 Jul 2023 15:59:27 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 253F410E282
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 15:59:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLe9urTNzWHhDS/Pk2gwEcbHfatdDYTEr2cfHapdSOnuv5eY/91t+UwbkBUMwBillGZtJ3WnLHkEmz0UR9SophAuXg7XuBZ5zk5Glf7LKGtKJXHF38lg/Dt/A8T6aoyGu5NzTABA45pGnBk4CxpVlaeYk9gDoqXPKe0XGoso3NM4YV/TOjE/jXtt3i3tKKKhtbYrRFo14G7ZYBgkhSYFFnmr6EKsmSpnxeJrNzoLCbRdDp/IY5cxpydnfcmST3l9eIIBfYi3KBle7Eqn0HmuiGCrEARSTQu4+B0PQOMWVbh8lB36kBnyy9BwmIuuwbJDNgdjoP5BF2qrfT3VmoNw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mxk8joNoi+AjOiSqmyXfuq/FfyqBLcwTvtX03DgCEUA=;
 b=lpAeVvRSoW9wCdww+SzMfhrnnt8IkRTO+uu49miA1k0g1zfZ7uBbQxJMOzkxtrYnMaceC/oVeABeLdlabkwbeg4oanTkmKo4c4UZZcr5kMLLgcMShtyy8pN/24oAcx9ihVlrrY8/p18S632pzQwl7e7mC0Fxbbosdt3g16Yv0+TOAJVqtLrqsTNhLeyeeVmRxavff9P6J14XdHVdED4lrEZndWfZOQcpa6lX89uQhZ4FJLXUGzHDouOlGmXf76GrhnAUXXl2cIbBMjk3jqEw+uDK2UBI6B3jCHPapCrpb3AJLQxmzT0F5oKrLbfpL/SsfwZhWVyNtJXo8DlF4mEwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mxk8joNoi+AjOiSqmyXfuq/FfyqBLcwTvtX03DgCEUA=;
 b=wWuiWoRHmB1BiL2cTikw5jwMzcZQJNmMn2jZlZKEyM2GJecVxzU1y3f1WjgSeb9WzQPCn7rgg1+xJaiulLYlrItCt2UF1/Mrehe7YI1mx3gRv4cH0Z9SMURkggF3Qxws2rGQNl4TzJ8SbsXN4Gd5ARSxpmyZ0Xvr4pAWOG2tmFU=
Received: from MW2PR16CA0061.namprd16.prod.outlook.com (2603:10b6:907:1::38)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Mon, 17 Jul
 2023 15:59:20 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::9c) by MW2PR16CA0061.outlook.office365.com
 (2603:10b6:907:1::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Mon, 17 Jul 2023 15:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 15:59:19 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Jul 2023 10:59:18 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amdgpu/vcn: change end doorbell index for vcn_v4_0_3
Date: Mon, 17 Jul 2023 11:58:41 -0400
Message-ID: <20230717155841.758516-7-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717155841.758516-1-samir.dhume@amd.com>
References: <20230717155841.758516-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT012:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 808954f2-2ece-47c5-1210-08db86dec7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DyRfZxiWviPdgOXERI6l/Jnmo6vIgDzN+NqkovpEbJ/b4t1tBfCXg0rFbjAepoE/+0YhFCyQ5MyjhQ6+pkERYngcLk6yuJ8quDu+CGHutTvNsC3qz5fberj7HezzcQpftEmDmvOda/w5QSYak+Dw/dw6NI3tlEoQ5LCAormNclPQKB0LNJwc2HMn4edl/IPgr+DGmSWinAc9+C3xYWejsyuMThRfNavn+aypYHszBlVgzv4KW7sXuRQE3DeCruwp0om8tAVTlA9zlBisNzGgNNbiVA9PbPuSbUKBkhKHuVqeZJHUVH4zRb2AjvYCvCdyubJrrsVCZcue+aobJ2XkYv2XpA81bHoDiCCGzLsHUG0sIv82AjnkUuEjrTXfiD2gpKGzxn9SjmZIIkdxFjeHcmIL0rpydHC7bSbxsZjUXfJ5UueyQRn3bNrT5i7K6S8yl5UOIKikoDcvxSYvvdIQa7HWfglnsyJndctpcLOif9lCBBpxi4D98le1h2zRTVAtXZfmrTsStj7YEQ5HF641tLYjvqpiaKDc7oUmBdl43OshmLHTreLr5bXDJkuqcrXdn25KZR2PaMxRN2Zr7satYS9y249j2+zvU3A+g0dlX3tID5KqdyV44on2FrcqEPv60ixoWO5IwU9s9ed++DbWhswY8jAvKjGbWQgGnu1W83khxPitn6qUM6IaC+GFsMG8oSf9TXOZdmfFwOQzRQF5sIw00WxO2CECT7jv/2YUoBrbBlb7bhIPfzq9UDAe3jQ+DzDpDgwrS1sZImNNUuGCiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(41300700001)(40480700001)(478600001)(44832011)(2906002)(8936002)(8676002)(5660300002)(316002)(6916009)(70586007)(70206006)(4326008)(6666004)(1076003)(26005)(7696005)(40460700003)(186003)(82740400003)(356005)(81166007)(16526019)(47076005)(426003)(336012)(83380400001)(2616005)(36756003)(36860700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:59:19.6670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 808954f2-2ece-47c5-1210-08db86dec7fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
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
Cc: Samir Dhume <samir.dhume@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For sriov, doorbell index for vcn0 for AID needs to be on
32 byte boundary so we need to move the vcn end doorbell

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index f637574644c0..4a279960cd21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -330,14 +330,14 @@ typedef enum _AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1 {
 	AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_END		= 0x19F,
 	/* IH: 0x1A0 ~ 0x1AF */
 	AMDGPU_DOORBELL_LAYOUT1_IH                      = 0x1A0,
-	/* VCN: 0x1B0 ~ 0x1D4 */
+	/* VCN: 0x1B0 ~ 0x1E8 */
 	AMDGPU_DOORBELL_LAYOUT1_VCN_START               = 0x1B0,
-	AMDGPU_DOORBELL_LAYOUT1_VCN_END                 = 0x1D4,
+	AMDGPU_DOORBELL_LAYOUT1_VCN_END                 = 0x1E8,
 
 	AMDGPU_DOORBELL_LAYOUT1_FIRST_NON_CP		= AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_START,
 	AMDGPU_DOORBELL_LAYOUT1_LAST_NON_CP		= AMDGPU_DOORBELL_LAYOUT1_VCN_END,
 
-	AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT          = 0x1D4,
+	AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT          = 0x1E8,
 	AMDGPU_DOORBELL_LAYOUT1_INVALID                 = 0xFFFF
 } AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1;
 
-- 
2.34.1

