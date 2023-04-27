Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B3FC77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 18:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5769510E32F;
	Thu, 27 Apr 2023 18:34:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C8A10E32F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 18:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7v9XDNbVaJSdilyi2XDrp97UD/IpeqC7vA2ILSu9EaJ3i5f4W7kZe8m0ujK4FQSTwB6DB7hpS8UTVVh9GW+iLO+d7K4UCzS2AFvUbBKMx6wNpuITdOVSZAtTNb+4LSrZEsFSJ6hoBbe1gfUKOmL9aco9gNenz0KetmgtF7LUhGz0ttaP8cuzxo6m61gCPsuvBF+Qs9Xdh0xr15ggWSJE3XN3ECGNvZLpUEfOZLQ/vJt/Nw6Qpbf4DkreuGN7ybwQlqfc+ir+uN+cyd0ihIzatBStme0V5EKzUoBz4SkBDert9ZwPD4J9a2xehOSfEb+iZDLyt8QlYHQ3MOIqw1yUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i10LtPLovxbfVtQcHnOp9FtaYYGiLxc1mQ0d4X9o/DM=;
 b=F4IjVvWsqBCWEEJGD7LQOMLHdnyGOakryCaBZ9coqW5jhjl2J5td8h/VlqgoXxRmQhAPXjGs7stjWUMGJ4tNS1lVSztgnS4UPRUPnPVg2pWQ+bboifzI+5MiPi+bXYK4CclZbWQbu6/tjZqJ0XIXD5SH+VCzRoDYz3SEgU54Od3rqdCOl5wXr+CdaXo5qAX6y3SjdKEbrzgsOlyIzTw5QGD5dVYoetwvXTVlJ3wox9EBn47TfU3+RM002Drb1oaFSqyDfjdDGjyGA5/0HvsuNN/8vI0UtA5xC9gfuOoDFc/0IVcZThXbJpjPScIJxhBpUh3fpSCt9fwgBtWOs22/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i10LtPLovxbfVtQcHnOp9FtaYYGiLxc1mQ0d4X9o/DM=;
 b=Dur7ZaB54wT8ElphIfHcRz/4Nr99HP/ienPzM++WkSAqpiK+qFES4k4VQVA11lOkTRrqsIoT36nH4cvjnWyv+Zyk+zXxPrl9+aN39e+MzGWin0BFGUffXLqUa8Bq4oclsoqwvhtL/5Vyf1KgapS8ormwIFFWqlJaEJ63umjqaIo=
Received: from DS7PR03CA0257.namprd03.prod.outlook.com (2603:10b6:5:3b3::22)
 by MN2PR12MB4551.namprd12.prod.outlook.com (2603:10b6:208:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Thu, 27 Apr
 2023 18:34:46 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::a3) by DS7PR03CA0257.outlook.office365.com
 (2603:10b6:5:3b3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23 via Frontend
 Transport; Thu, 27 Apr 2023 18:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.23 via Frontend Transport; Thu, 27 Apr 2023 18:34:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 13:34:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: drop invalid IP revision
Date: Thu, 27 Apr 2023 14:34:28 -0400
Message-ID: <20230427183429.599578-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT067:EE_|MN2PR12MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: 06cf8d03-c94b-4372-55ad-08db474e13bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcooVEKUZzJv4lVHUIhoi2zQUa5ulzBWOHv8H7xsxzfMtmlf48vhKvTJJR+Lsb0FSGuH196rOeR7byTmTjxLAkqP3NeAfCvl5NEZ40JoEzz1poa0svw2ku3AcC0p4zb3K4uVd7uwlB52Su9JcuA097nTUKNBguzF+5I73YiDITdYisUhAzvGnny78M9ej05khAhydDerTKFfY1hN0pKj83SmIvShOfNlWCgfTrWo2C/06PhigHBX50kHH7VJ0+SzeOWvnomYADeSh2zcTovQGRIeWlKTQt/k4TAbNMuMcyaRbt82ubEgaN50YTARoEwtS+Ol4I92sH4oKcbogD507MFtIwmnaTWSxa+Szf6AsAp9xyvGlXVJep59kQsVPGpByheX5TfWsZC1DeQYd34zTDGI7m/jWWgoTbypRm4n/P5kMrAYlfaHPo6YSDh1llJDm+nVhxn+p3aPBiV0jLA3hX4dD016lrki0mNgoyxn+8rA4ItHek6G5EI5bvXZ3HDm1fveg5/HhxKuxXIsDw0Hcd9GNsefWWi5AUj6rPwTpxWK6xN9YxZXBsG6sjA1garwQCAHpMPtnrIsfoBMfxQRWW/9PFVBfR6jO+dHvP3TZNZ5FF0NFj1IZbhwUbQ5M8ABF/KzeOxklaHa5f7JOo8FIlhjQZOG5bXCaL2UHg03KwTOzR9fPGSGZlnrbLyvVSD8gHs9HKaKGT7bD9trQMtKDeDrG1o2AG8M2gyt01EmekE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(16526019)(186003)(40480700001)(40460700003)(86362001)(478600001)(82310400005)(7696005)(36756003)(6666004)(2906002)(4744005)(8936002)(82740400003)(5660300002)(8676002)(70206006)(4326008)(6916009)(70586007)(81166007)(1076003)(356005)(26005)(316002)(41300700001)(336012)(426003)(2616005)(36860700001)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 18:34:46.6472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cf8d03-c94b-4372-55ad-08db474e13bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4551
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This was already fixed and dropped in:
commit baf3f8f37406 ("drm/amdgpu: handle SRIOV VCN revision parsing")
commit c40bdfb2ffa4 ("drm/amdgpu: fix incorrect VCN revision in SRIOV")
But seems to have been accidently been left around in a merge.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0ba013275dc1..76ceca05452e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1939,7 +1939,6 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 0, 2):
-		case IP_VERSION(3, 0, 192):
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 			if (!amdgpu_sriov_vf(adev))
 				amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
-- 
2.40.0

