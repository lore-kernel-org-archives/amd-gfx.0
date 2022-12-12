Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E0BC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Dec 2022 17:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93B4F10E247;
	Mon, 12 Dec 2022 17:17:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E0B810E237
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Dec 2022 17:17:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WH1lky81m5IEc19iXhb3LePl9cFKAg0xshbj405UEE1CeC16ya3eMuD2yPA1YknVKmzN/gy3gX2+efBIWWjcK0ceZm5aV4hyjAD++35AVkXhWFhFPV3wV6YtXuYJ9M7E74wlm71PYRKcs/P25Sxtkxs3kc0OFo+KHaol0ZS1s7/fN7qgb04o3dd4WnFdUjlaM9gczrnKc2v/ONZhxThwmHA3jyGz51Xvp2yZgxpVUFZOrZ+jaajbc47Cw6TLyr0tyIb0Oukh2LBeSed+ZX9E7XEWi3MBsE5AJUvVBcU0HAGzh0m998EC9zv5jKGLjzvxM/W3LGjQJnsOVxkK5DvzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAPaCGos7pozPSf+iJWPQriVnkv1SpBbOMD49K2u5OI=;
 b=P3OCS6gEpeU7kGROgw4csX+mkpuXq3dmdnF07SW8unTm+x1Tgjpo6c80zAV/rTqqJFmzyadc4VLf1iigWSsC2SXGZeBKCA1zU0mM8pC0pDKP5yEKfYqr1EBXpLJmRBosl78POp4D37xg2sEhl/NH2zfz4diByV8RYoJGkSNgTrFoEoOaUVsrbz6nB1brixodVLKnJrQw2UddGBaHa3cCYGrtlmcX2O7qXwwlKxGsFP4bZ3EKBrwSxhCobjhp0BcFUPM9p0ZnobBcrz1D0BylszE8ZSqMOd7a2DPbDpAUWxOTcgMKG+1ZFo1sf/QYOfdTCdphVTcvC8JW305c2BU3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAPaCGos7pozPSf+iJWPQriVnkv1SpBbOMD49K2u5OI=;
 b=YQH0zVkjOghlyGJtrmlYheJG72mX11oDiCJpp2bq6CJkX+sVKdpF25ocXsdE3QFA4FCkKYiBirwsI6O9IKQ/C+vVj0JQbfbnymVAByePeHm3X8FyKnv2xOTKQOPh1wwN7d9ZOXK355mD4Q9yE1cdPowaSdXkIXkIOl8v55AqmVQ=
Received: from BN9PR03CA0397.namprd03.prod.outlook.com (2603:10b6:408:111::12)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 17:17:44 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::29) by BN9PR03CA0397.outlook.office365.com
 (2603:10b6:408:111::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 17:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.21 via Frontend Transport; Mon, 12 Dec 2022 17:17:43 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 12 Dec
 2022 11:17:42 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Check if fru_addr is not NULL (v2)
Date: Mon, 12 Dec 2022 12:17:33 -0500
Message-ID: <20221212171733.34622-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.39.0.rc2
In-Reply-To: <20221212171133.33982-1-luben.tuikov@amd.com>
References: <20221212171133.33982-1-luben.tuikov@amd.com>
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT020:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: bad08d2a-e580-4f37-f439-08dadc64c84d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DeXr9EBrEO+fZG4nLqBA1A81SpF32TDNASUUaP1a/mWYzQnAoSuuV/LrVrv/rZbVKmproa/yirRnQKRo1V+P6AWubnaCfaaDUhXW+G5KypOUfEeXou2iOvbCW/19iLzwj97e3879rt1100ALfrhMk5sQWStJ2JscaTZUtbKr8boWP1sw48A/nV/sMxfq/7WUp1jD9QPbO669kjV2sVdb2jQemEJdscDdTMt9CDIuloBHfWCOoNiSBG9g4z+enZCSyUfdIBGn3HUPCvCn231YKnNILDjVdtgKNd1N6C9/qaJclrIfBo3KsMYuNf7iMKm4C7G6wWwb6Sc/fg4/5/29vI94+uzfPDS59KpeGKr4YokhYvf6YNdJi2wh4LC0D7TL8g0iQbmiWUntTJEWBtIiYEXfA5n67ttyGHgdQira1X5mM70zhbRvKELIx2q04FxK7MZO5mNeOzeWywFrslJkfY1jYm66coVZDWR6DIKiI2rnPhns1X99Q1CW/lywc9kOHa+dVopEj5lDBHM054LAQR+kKkZz4AIY8nH/+jRjdZsT4Pmvd5USXtXfhlnUkoQ3JqEWbWkcdiGK2UiHqFLKVx5GEgZGlLP0lz08y6k46F5rbwH3VpOOoTpc/gZSyC23QP6nNJnJng3WMJ7EEALjMl1ElTv0MC8aXs8guAWix/wGS/04hkdL7aRkifhugpeo5RrurAovOdGDFM1XEVcP6gxyew8lcHB/HdWIQMgpcmw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(478600001)(40460700003)(426003)(6666004)(47076005)(2906002)(86362001)(36756003)(82310400005)(7696005)(5660300002)(26005)(8936002)(186003)(336012)(40480700001)(81166007)(356005)(82740400003)(44832011)(2616005)(1076003)(4326008)(16526019)(41300700001)(36860700001)(83380400001)(70206006)(8676002)(316002)(54906003)(70586007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 17:17:43.9395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bad08d2a-e580-4f37-f439-08dadc64c84d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Dan Carpenter <error27@gmail.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Always check if fru_addr is not NULL. This commit also fixes a "smatch"
warning.

v2: Add a Fixes tag.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Dan Carpenter <error27@gmail.com>
Cc: kernel test robot <lkp@intel.com>
Cc: AMD Graphics <amd-gfx@lists.freedesktop.org>
Fixes: afbe5d1e4bd7c7 ("drm/amdgpu: Bug-fix: Reading I2C FRU data on newer ASICs")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 2c38ac7bc643d5..4620c4712ce32a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -64,7 +64,8 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 			    sizeof(atom_ctx->vbios_version)) ||
 		    strnstr(atom_ctx->vbios_version, "D163",
 			    sizeof(atom_ctx->vbios_version))) {
-			*fru_addr = FRU_EEPROM_MADDR_6;
+			if (fru_addr)
+				*fru_addr = FRU_EEPROM_MADDR_6;
 			return true;
 		} else {
 			return false;
@@ -83,7 +84,8 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 				    sizeof(atom_ctx->vbios_version))) {
 				return false;
 			} else {
-				*fru_addr = FRU_EEPROM_MADDR_6;
+				if (fru_addr)
+					*fru_addr = FRU_EEPROM_MADDR_6;
 				return true;
 			}
 		} else {

base-commit: 20e03e7f6e8efd42168db6d3fe044b804e0ede8f
-- 
2.39.0.rc2

