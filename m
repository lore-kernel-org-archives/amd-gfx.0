Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D388BC25B67
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 18:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A8910E84D;
	Thu, 26 Oct 2023 18:15:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1191A10E84D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 18:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKeRt3XHKLIeGi9fMsg0vN/AanOL1yT1M4ffgJdsepen1teaEHJSTPM52NEW1sQNi1quaRGW89+N5T87CAOKts2Czc3ZZDAzwovFdbB00BWfK5Q437/1r7O/qJs6qnfS3gzPV1l6Wfy4BD8w/eiM04Aogsivz9ECTVYXqMwCbwY2WgHWgVsIEuP3XcJ51H4fTLFAGOvIe8l+RusiRpw3QaE/2/+JYzfxEa3EIQ4byOVhwK4VQZJGVU7kajZ3T1QfTZWrHCbubDivzG94CAVcH9pwHP1FsF0qLdndIORtOYhElU2Q8X47yV2/cB0OsDgdArQ+IzqLy5/0kJIKrOQqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJzbps7FfFJwcBGJmj/+AQx/0JXus1pQ0ILo/AxZWx8=;
 b=F+jlpbmQk/JO0KJQS01cP8XURZ+XkcZTmjSKkp9MmgcPksAkqd9sLMRbyUfa6AITd6BhGLBnh0RXm7CxJ5ykGesNdC3paJemShfCmlr8LJubfBIghMiQpldmTpjSK76ntHWO2Ro/MHu6j6La5J4ZTiTegRnMfB8uIjOPfYXBgXQ5iVyoRknSo6z5kxd9HeijinBHZy6RKV7oXn00y/FkCu2qJubkE39J4C1BMMCsnCA/2DXI57kJ6Sdkiu8D4cI/CgvEvOImwkfslPgz4YYMPG/5KoET2FZin809S7lM/KV0bO0zqr1/McaDsgOlwvplmET3/q7xbWZ1nFQfhwdw6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJzbps7FfFJwcBGJmj/+AQx/0JXus1pQ0ILo/AxZWx8=;
 b=k3n0yo+1+FmCDK2ebQV8zCQjCIH3oofd9cVEutzzh+n7c07MtymkZWfaDSeNh6R8BStvtUcbf25Ec+DgF+miHWs8XAwtP8Xd+yu5UP86WUMVltt863pMH26kZX8DDXQC/W5+MCK3dchUhLUCHfvbn+YwrMroMGQCX3+hVM4nhk4=
Received: from CH0PR13CA0028.namprd13.prod.outlook.com (2603:10b6:610:b1::33)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 18:15:40 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:610:b1:cafe::1c) by CH0PR13CA0028.outlook.office365.com
 (2603:10b6:610:b1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Thu, 26 Oct 2023 18:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 18:15:40 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 13:15:39 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix typo in IP discovery parsing
Date: Thu, 26 Oct 2023 14:15:22 -0400
Message-ID: <20231026181522.262269-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: d20308eb-7dc6-4dcd-c4ec-08dbd64f8fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /S37sj1TPabk/u/SWUYoTcaG1Ug4MN7g1j5Rgrwul68ciKvBgU/uM6B4EayeEP4v+OEDuqqQF2o8JAiv4tV5UrtXBV4U2ox+i9kK9JzwhuSvZSuW91dERceCOyOxQ+c1GIbUIkdxGt3N9O6dcDbtZnm1uuBY9k0baJQB4ICl7b2y9p62ccE1Zr7hpg1QWIjAoI/uAX+UJM27yaEOxI/KYaq9oZ7wmE4V2Pkks19peo09wol1+irUK/oPjdDItmRBAep9ynkQZST/Wc8xDJPq9s835g0OqnvIyn2hT6GXII7PaMg47tVwOsQ9dKCgkRTnYsnPR3DlFbY6jZMpdwYOGxT7g40Fv9J6YD4uzFjDdnKWwDUzyyFgdstK3jizUneT7RfUYIIcy8Ai14gpq+1r5xouB+XuhNaKBpMRwQbh4FJ+msINhYdriYYrexDEfbbjB5SCpMXRWey8HR9HukWx4HGIs1RxlXPqS/iX4GdNdcmHn6wdTbA4qSAfW1kUevI2lQEiUYPa7MUVxhQdGPAdwHx4EasDlYMO1N1SuMO1grfnbGxOaV82QkHppH2tEx7IPCwfbXOKcFbIfG/MSlI6TllC7BvM8s1Icw/Ow1mTc++Z8iRkBVBKAg0ZnO7ARR5QW3a72eGlQNqN0AbUQYtEJ52RIzv5/zTvBDgYrR+3JOYcSnLFYOO8y5wvfiHpD739o+2/31FSlhr4HXvBxpa65nTCSMOtILAt6hoZanw32J8RgHjoAzkLSgVDLnMRECyxFwkcHBJ2g2LPofYFd0O2Dg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(41300700001)(82740400003)(2906002)(36860700001)(316002)(70586007)(356005)(70206006)(6916009)(54906003)(7696005)(478600001)(1076003)(2616005)(81166007)(426003)(6666004)(336012)(47076005)(83380400001)(40480700001)(36756003)(44832011)(40460700003)(86362001)(5660300002)(4326008)(8676002)(8936002)(26005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 18:15:40.2729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d20308eb-7dc6-4dcd-c4ec-08dbd64f8fa5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431
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
Cc: alexander.deucher@amd.com, Mukul Joshi <mukul.joshi@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix a typo in parsing of the GC info table header when
reading the IP discovery table.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8d3681172cea..81476cd8461c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1488,7 +1488,7 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 		adev->gfx.config.num_sc_per_sh = le32_to_cpu(gc_info->v2.gc_num_sc_per_se) /
 			le32_to_cpu(gc_info->v2.gc_num_sh_per_se);
 		adev->gfx.config.num_packer_per_sc = le32_to_cpu(gc_info->v2.gc_num_packer_per_sc);
-		if (le16_to_cpu(gc_info->v2.header.version_minor == 1)) {
+		if (le16_to_cpu(gc_info->v2.header.version_minor) == 1) {
 			adev->gfx.config.gc_num_tcp_per_sa = le32_to_cpu(gc_info->v2_1.gc_num_tcp_per_sh);
 			adev->gfx.config.gc_tcp_size_per_cu = le32_to_cpu(gc_info->v2_1.gc_tcp_size_per_cu);
 			adev->gfx.config.gc_num_sdp_interface = le32_to_cpu(gc_info->v2_1.gc_num_sdp_interface); /* per XCD */
-- 
2.35.1

