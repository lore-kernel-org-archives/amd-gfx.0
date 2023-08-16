Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76443C04A6A
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 13:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 003F410E0D2;
	Wed, 16 Aug 2023 13:52:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4357E10E0D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 13:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lk0UpagsiQjd6Pc216mnIZJLk+0THh15a1lNpbgRtmziKHLmfQ9fyiCrNjIOBDkz2+6lqljV5SKd/P5a6V1vQjB8ZFWoLDN23Mgd/aIVm2zQ+q79N24zh26mapkCxwSARMG2gbDk9MGeLrjfpC9ni+PqNMMKAsUBYHf9KGpjfZbEIRmSrwja5norguJwryHaDXF/FO5fvsVRzfwhmlDuBAXOpOltlha5+7SPRePMv8NESy5sKbeFeDtKl0oOQi5j7qw76Dmz5sqHIs3hHRpFdvZicsXG6u399LhnydRTWAB8bd1RjegLDDGI4nBoVYkIYPM85SaIvMXSIVd5LVSKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6k3DlZTY5lxEf1A3AfFBFbj3G68iZqBJn55+pSlCy4=;
 b=G3t4NzaEPWu/60D6BhIjNa+E4bpCPj9wY4xbBV7d4fjgOJxjK9cUgMyCEoe3hX9kC05RgxOXwdfAF9hbArjUpRroelbrTGNZIRMozVGbSYH1Pw1DZ9t0cSq/elSp4s/tSmkYxWq6PSHHlyej/9h60Ecm75SGTKtD3V0tIa0VnkG8WIIxRPyV1ms3SvPuuqKNtBnlOdtbpMBoiC9/5pB/eK53gB30ApEZGsIGK5U24ZzEFZ56T6XboRcXIivUjorNfFh+gEcPwkdhIgOOuoYYByLUEEfWssiSXdncanhrrWLNy24qr9ByUAnBMwY6Xk5VAQ6PA8rz5zTpMjT+ul3SQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6k3DlZTY5lxEf1A3AfFBFbj3G68iZqBJn55+pSlCy4=;
 b=TTPqG5tOfeULM2K25AlYZDm6l6vwe9eO+JH6Tf10TVvPWBabeGAqZV5f/BIhOm+Tb/yKxR/npAyoYgSZIAco6ASX66knsM1ndeqMqYq/EfgJyP+4DUKMQONMJAI/CTfbkLDxy1oIiunIa5vT+MuPKMuoXENp40gmjQ9aa0r6XpM=
Received: from BN9PR03CA0297.namprd03.prod.outlook.com (2603:10b6:408:f5::32)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 16 Aug
 2023 13:52:05 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::3e) by BN9PR03CA0297.outlook.office365.com
 (2603:10b6:408:f5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 13:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.16 via Frontend Transport; Wed, 16 Aug 2023 13:52:05 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 08:52:02 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Update RAS EEPROM support on smu v13_0_6.
Date: Wed, 16 Aug 2023 21:51:49 +0800
Message-ID: <20230816135149.4088467-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d6692c-c102-41e9-6846-08db9e5ff9b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45IYZs0q/7ml7RJhcfA834ig1oGTm2Y3WPA0l5xBoCdjY/MbJsl0D7Eqq8M9uydcjhxSn+fXeqsDVB11cVEGDTRzZKUtCxyPVK1JyfPJkBBlKyo6sBv2NZ89SmskHN5PrNWgSBAV7YpoQqS2xVugcRFV3DhWEElhydhNeO2Z2nRcstoCHx0us2UyWOyFwWWsaDfcERgUoj5wYzl6f2oCAEMEA6QGzTxyPOaCZVIy7jAA+o9nhK9B6aUh917ywcej3K+4+NANciVOrkfE57Oy+4NTWB4MOF7wTBot2fR0pmdzP8Zhg+2Ekehlp10Bmey/Ps5J0bpMVlBJ4yNXbQgXB5d3xTSLPnM5TnoBfboQlVY85Hmessr96W2vgwo609Li0r1+pt0r51+4wH88lsvYiV3CzY13DMnPyCmMp0naLuSvt6/10ecnZ1xsACl4BspxZmMjvx4pFuMHrPhHhwSpjzlXOTC+iznnhf01LAIa9IH0pWUyTqC00m/Y5M1k5+wp6S3lN/pkhH0f+pWr7iYG1a63n0IY819yWxylfAWduv3qYGL5bj0z0A5wGK5FehDCQEKMy0HYk69hb0Zas2lH8jNNFANFGQxa0znUYQHqt2XvN3D+kc6mjN24JtA7Vh1p2RgjihuRHwqBP+6ivJSMwPPbLSKqzHJR0J/cZEZd1V0yvvA30ibg2ZQ2wxPEOsW6SxWwl1DUAswNnqLUO1FYYVNeATrkHGylTMubEo6aW/PDU3ppOJ2ahCEiXxUIFgcJsi6tngc58PmLE1UXyCC2PQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(316002)(356005)(82740400003)(6916009)(81166007)(70586007)(70206006)(36860700001)(41300700001)(5660300002)(44832011)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(4744005)(83380400001)(26005)(16526019)(40480700001)(478600001)(426003)(336012)(86362001)(7696005)(36756003)(6666004)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 13:52:05.1241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d6692c-c102-41e9-6846-08db9e5ff9b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600
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

RAS EEPROM device is only supported on dGPU platform
for smu v13_0_6.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 4764d2171f92e9..595d5e535aca63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -158,9 +158,10 @@ static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 7): /* Sienna cichlid */
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 2): /* Aldebaran */
-	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 10):
 		return true;
+	case IP_VERSION(13, 0, 6):
+		return (adev->gmc.is_app_apu) ? false : true;
 	default:
 		return false;
 	}
-- 
2.25.1

