Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15825C352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 10:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095E110E1AA;
	Wed,  7 Dec 2022 10:04:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B6A710E38F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 10:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpVZTkWmvZuMZrEG5Aiw3PIljL5omqyRwe+TKWANAJ4zXLKPvBmwtwL7Mo9RoWlXjjIXRiRXLVOsnoQ75EEKC3DldDmwz1I5ADH4VpLdiFaBYOiM9Fz6BHvkpNM7VIGxZnIEmAcynfSU2y0WqSol0KRlukUQGEatyZ5oCutIn78SMOgU/F5eC2yxmZJFdFvvtHYv5i4RbNFLk1nimZS2Eaj7XodRP3zGyFqtgEua1JR+nzLMnB8f6QToOkQy3TaFYzOoxBDfOItjo94P9w0vtuyPtycKTIOKRog63wS5ch8ecK76q2IfRPE9Tjjp4Vy2TLcpOJKp/m05XgHjgheeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxe26wlbbfBemc1xvUvCGW2QYTdskyNjM2dqGsRJ7a0=;
 b=SwZWY1SD0wI3NiemueMS2swk+zG4+CAcrMSPYlHDj66ZthjPuQikTvn0rsdWFY31a/jg7TO/ZZ8jfSe8oKk8Yw0276UCdxvEGUFTPhxk/0MX4DtqMYClO7Yd9TwzMZg3bT7QpLRr5eXnBi21OvymvykcufjMzKmw6jDVSDNeQ+u4LbwZIDCAWP9pl994UtRPL/I/oquHRIN0liie5cTPbO4vxd8fzZPULc0hCSknL789DL1QcZh3vch973DMDGwVwPtQ9oNMZoWViquCxe/Hyvv5PPjhpCr/hDdEMwJoWh47pPiinsa10Gu7OqD66mNeGQxaksF9ZX+wPVYSMXgrPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxe26wlbbfBemc1xvUvCGW2QYTdskyNjM2dqGsRJ7a0=;
 b=puzpYo8WAZTN7JLj+Dx6hQYGR1ZmmF3nCYMMBS0UNhoGrASo1cpixzn1qU1iKRIoJLxRJxqkqz/JNdA2juI+t4MK6MWxgwM4YGeJVsavUkMeNQ3+ymMWwMPXBzM1XXHPCnQkUUV04sQqssxJKJTOJZpDwXjwneO88gVXAlZL57I=
Received: from DM6PR02CA0133.namprd02.prod.outlook.com (2603:10b6:5:1b4::35)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 10:04:02 +0000
Received: from DS1PEPF0000E62E.namprd02.prod.outlook.com
 (2603:10b6:5:1b4:cafe::9b) by DM6PR02CA0133.outlook.office365.com
 (2603:10b6:5:1b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 10:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62E.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Wed, 7 Dec 2022 10:04:02 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 04:03:59 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Gavin.Wan@amd.com>, <Vignesh.Chander@amd.com>,
 <david.yu@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: update VCN/JPEG RAS setting
Date: Wed, 7 Dec 2022 18:03:40 +0800
Message-ID: <20221207100341.15356-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221207100341.15356-1-tao.zhou1@amd.com>
References: <20221207100341.15356-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62E:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: a5700e5a-c874-47f6-d1c4-08dad83a5e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZsHvgTe+iYxgYr0u1TB+yTdF6p3Oa1+uNeSain9CG1/3WsERbMbs7UXMttKaYuuRxW+5PGT+Vim3xxMHI1bT6JrKM1JX4bIp9sjHZMdCsZh0Iq/aKFpbEsg89FzQnn4vuNB9tkHnsIEl7DOjuM1LOdUZcNgm9mMJN5jvmhaoIbnxNbzpY19qC4SQWJ+rhWsjmMSlfG/YNhIWu4VQ7+7yW94CKEZskt5i9InZCP24o1QwFVqL1QMDg5PigUxUEpMPeN/D7pgC3t3WLV2pY3bzImIvEULnX/t18XBwLzVAcNaTIb7nZ93JpseTFom4B4BE/8AqIopapwWU3cK0SQ2eaxcbWPCaNoiNYm35nkglD/glgFKzM8uxxwcvFsx09rUN7D3c7LUYKMbx94WZ6pRB/1+3HpfrQCFXxemPMSFyc5mi1HgWA+NsZzix+b65FyqIKV5Eip76Fh/NZ+/ZWb/cp84IfrnbNJNcWZybVl9op8DSivCYthD0KqsqxYNtSETqiGrj17mXfyFiifoZUnEQK0Z8H4MVLbS/63pxSTMAzmwiZUyIH8AtX3ysOzhs+ZglLbPbuWfC7rXUlFcN+ajtjqTuxvezORVRkh0YpO3cACFrnUrb8oeoBsIHOzfc9OVeRlwLjBSh/zYoUy4JRNoXUqiaXUuKWO7gJNIedciy3P2c4tvSH5T0r/0aIiW5G9D7I9EAYKh6+bzb8PyFKcjs/o80RDrGWKpuB1ceUN61p8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(41300700001)(26005)(40460700003)(6666004)(7696005)(40480700001)(110136005)(36860700001)(5660300002)(316002)(6636002)(86362001)(8676002)(70586007)(4326008)(8936002)(81166007)(36756003)(70206006)(2906002)(83380400001)(1076003)(478600001)(356005)(82310400005)(47076005)(82740400003)(186003)(336012)(426003)(2616005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 10:04:02.5762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5700e5a-c874-47f6-d1c4-08dad83a5e36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The enablement of VCN/JPEG RAS is unrelated to SRIOV.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 854cff9e7ebd..20474708bc7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2353,22 +2353,22 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 
 		if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
 			dev_info(adev->dev, "SRAM ECC is active.\n");
-			if (!amdgpu_sriov_vf(adev)) {
+			if (!amdgpu_sriov_vf(adev))
 				adev->ras_hw_enabled |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
 							    1 << AMDGPU_RAS_BLOCK__DF);
-
-				if (adev->ip_versions[VCN_HWIP][0] == IP_VERSION(2, 6, 0) ||
-				    adev->ip_versions[VCN_HWIP][0] == IP_VERSION(4, 0, 0))
-					adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__VCN |
-							1 << AMDGPU_RAS_BLOCK__JPEG);
-				else
-					adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__VCN |
-							1 << AMDGPU_RAS_BLOCK__JPEG);
-			} else {
+			else
 				adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__PCIE_BIF |
 								1 << AMDGPU_RAS_BLOCK__SDMA |
 								1 << AMDGPU_RAS_BLOCK__GFX);
-			}
+
+			/* VCN/JPEG RAS setting is unrelated to SRIOV */
+			if (adev->ip_versions[VCN_HWIP][0] == IP_VERSION(2, 6, 0) ||
+			    adev->ip_versions[VCN_HWIP][0] == IP_VERSION(4, 0, 0))
+				adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__VCN |
+							1 << AMDGPU_RAS_BLOCK__JPEG);
+			else
+				adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__VCN |
+							1 << AMDGPU_RAS_BLOCK__JPEG);
 		} else {
 			dev_info(adev->dev, "SRAM ECC is not presented.\n");
 		}
-- 
2.35.1

