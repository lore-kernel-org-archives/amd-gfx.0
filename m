Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDBBC3A5A7
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 07:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0175F10E46A;
	Thu,  8 Dec 2022 07:52:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C88D10E467
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 07:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDNzN0bh7Xe91mVnYy85kemgwjJAn92327/SUnz5vY/WbUU47wLOpwJAHkeGRsZOdedn2Isq6h4g981hC4diiMrvx6PAYexxKU4kzaLf72Svz/kyXkTnmdQav/9CykWLkSGo2sRdvfItyPlBRY1SxJcKrpxVWyfRpafNsFchQyOGngSD9yrX8wHPLZ8gYa0aqODB06/0zyMMcQFm0tOduDHynREUmYgZ3XmY5uDv9C0PNUjeZXwJj3jMQBl/rNFA7HewUYOSbBxy+A/GYy204nbRH1X1hiaqM/q83Re427yxZ00FS2YRZsE4EG9ylVmUYdN839BQXh5VYYtwJx5sJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFfhtWtOuekfqMIPNczwx+8wOz+321GqfnhgwUTLD9c=;
 b=NXpYY8vYh0oBqnvTbxpPGSLNy5Mg0ubi2kiRLA+cftMfgM17ZW2D9BsYeET3GT0AsNjOOQIi9nfoznfoZMm9BzDCNIzdnpjI/sQHoYacsOBrN+f0RXFcM9ISuiHlpnRs2Rp6cvBIByZ06ppBWESo4Ebq8Ce7oxI6j1utyYk/BtiOG6fG36HGFILRDGxC8m0vNVvBN0l8OXW/GiIiIYcOIkNzTpMF601/jDjS69rViZGK6bmhmSz5zIAMz4ZkjmaMoMJs2zIn0bGp5eAh1ZcKHa7YXM0kjyks2Se3py159yyG1evsBKuhx/VYNT4zcH5jWcbIX3LQeEUrtaUPeh3aAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFfhtWtOuekfqMIPNczwx+8wOz+321GqfnhgwUTLD9c=;
 b=YFKRc6TrH+7F6U/tbDHgO/ObNV05MVl+Mk/n/TLTkBVkRlBkVSCojUs/NGkS+dPxOc3n2I3RbzszbPWmsTPT77SIjsk3Q2PiXoH5Qy6nxlA/HkymPrhxXLiz/k5AGJuBCSQMPnw/g2+SUGNKQ4N7ubwRzzHrf0KT4mFxKo6xiv0=
Received: from MW4PR04CA0372.namprd04.prod.outlook.com (2603:10b6:303:81::17)
 by SA0PR12MB4560.namprd12.prod.outlook.com (2603:10b6:806:97::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 07:51:58 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::b) by MW4PR04CA0372.outlook.office365.com
 (2603:10b6:303:81::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 07:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.15 via Frontend Transport; Thu, 8 Dec 2022 07:51:57 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 01:51:54 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Gavin.Wan@amd.com>, <Vignesh.Chander@amd.com>,
 <david.yu@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: update VCN/JPEG RAS setting
Date: Thu, 8 Dec 2022 15:51:21 +0800
Message-ID: <20221208075122.28702-6-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221208075122.28702-1-tao.zhou1@amd.com>
References: <20221208075122.28702-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|SA0PR12MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: 081e87cc-2687-42cd-213b-08dad8f114b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+UzRYnSElkymveGx2mcPN8NU5jQ+xMIMLPW8FbmgOGEBGf2NAWO3e+sg359REW8QpBPyPv6gqSjzWu53CFdBlP17R0Ap0TOIXi0TkTDEv83mtJzx3+L9B+ugOv/kZbJI9gGs/s8FrokBMTsLWZbBO4g6R2ZR7PzaSZU6p6hVEujmz/c3TledY3iltJWL6dH2EL9NS6kBPOJEawbRi2eiSD6kmBhzSC64F1UZxlGW7UtxmNBlQWqJYS/FEwVLX3ibv5cqB0gAK985zgvTHxoJvdYJDJMGTKdjEmkVPpJXrRxfJmp+l6Au3KBivMyManj5WnQQ41vc1Qz+dmEGhJZOJitBXK0nOiOvs0KPjPL3e22XzEcOJ40e+E++8/4C/RdojCoX0Evg7TMH4G4qoUyHjBQQIVCnvvLzHY21+33Svu2Frwch8kL+QvlqhhUaYAgS0nXVkyxpEsFQIYhKVLZq3gIMf+IgSKotb9mLDRCOZJa6Wy8K2GLUki5+DpGo/vAm7rp4jb96ghil3PSJRdyiJlq3Ssa3wihTFD4C9/HgG8DswzOU+oiKagzxNQcbaQzLtCXSr1z3866ssWj35Pzvji6MvShVHxYuT48f6kSPK0i+Z42KExZEQHU/DYZSrHjkowWSZTTgiL/Y56t5VITFdWpNu4gl31ZW1oMdDHIXdsv56hhd4HWf5248ZAHlMUlnkdJAUL/J4aKJHkkIKbTvH03Midsp9mRPCuLdZkhzi4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(8936002)(336012)(5660300002)(426003)(47076005)(86362001)(6666004)(478600001)(36860700001)(40460700003)(40480700001)(83380400001)(7696005)(4326008)(82310400005)(186003)(16526019)(41300700001)(82740400003)(1076003)(70586007)(70206006)(26005)(2906002)(2616005)(356005)(8676002)(110136005)(81166007)(316002)(6636002)(15650500001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:51:57.1073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 081e87cc-2687-42cd-213b-08dad8f114b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4560
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

Support VCN/JPEG RAS in both bare metal and SRIOV environment.

v2: update commit description.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4e450e0b14fa..56d2c581f545 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2348,22 +2348,24 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 
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
+			/* VCN/JPEG RAS can be supported on both bare metal and
+			 * SRIOV environment
+			 */
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

