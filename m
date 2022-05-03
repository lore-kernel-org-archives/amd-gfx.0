Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5A2C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A5410F37E;
	Tue,  3 May 2022 20:29:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0479B10F047
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqXX96lJ2hIhPiQcTPVsFkyyNRzuHyd2ZLRVIECeXItNMdYXQeCebUeE/xGMnl4VAz0F48cWDHkTF4pnEkQdl2HPM+j7xLlvp9hw8cP8dn9Ycvq6uZN3E9TDiOcp6J38xmIc5eK9HXpQjYiDWP42KxSm0hSXPSWET2vCYonjftSwEaYDrYUE6WDKnFxhFd4AznTAWAeqjYRBR83b0S4DSr3tw+2gaNoTMmWcJR5BcmFvOqwxMFScS8DgEcsXnUa0DGAFylfwRtgIbAcpJpfL8RZLL0fKgkCW3b+HWNcBw7mPGouYidoqyPPSfK9ix6dvqaUXmfJYnp30hAZnG1Iy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfHAPGhxqv/o9zCslrMGqzyU3z45QeTLQl6beJRm6qY=;
 b=Qlzp2jgahyLTIfRjyUsmU0N3IWP4hesLE+6XHfHt7GO01i4TFCNqlAeh/hTPnEV8hnMMwdl9biP1GBWy48PvesLlJGdrh0o2APHvCWlh1M2OrHQcr5NQa6h6aNbplJYpcTr0+HEUwpAjUHYO74PcaWZiCftmLtyXNg3cO+f4eCponv6hOKYbFb+V3am+gB77LheJbHW2G+8DdzYgQA8nMYtqGMIz4SqhCKoOQOG0a/Zh1XmHcwPCUesfluo+93pnhVwZZJK5fwfAFolvDacwDaOgdOcibZ6YsBKU34yJLuMR5/qCLewrPZXQQr0Z/+p0oXG4L2xet2mLS0dDXRPJMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfHAPGhxqv/o9zCslrMGqzyU3z45QeTLQl6beJRm6qY=;
 b=ahqJ/owbKENwawIE4doLsdpSpAcwXi6/7QAhWDsjENjShk6wzuTm7/FylsMK/JFEynut+OQVIquU8zKbOoAcHwwUybhM5XPvLi7ewRTs7EDHBiVOQM78+BHBXCiEdtOozl8HK2Z/YCsKf8y8LfyVd+wkTqY2XIAKPClgZToNMYM=
Received: from DM6PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:333::11)
 by DM6PR12MB3258.namprd12.prod.outlook.com (2603:10b6:5:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:29:33 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::88) by DM6PR03CA0078.outlook.office365.com
 (2603:10b6:5:333::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.25 via Frontend
 Transport; Tue, 3 May 2022 20:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:29:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable vcn v4_0_4 sram
Date: Tue, 3 May 2022 16:28:59 -0400
Message-ID: <20220503202912.1211009-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b0eb626-eeed-47e7-e244-08da2d43a22c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3258:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3258D825D34722F6623B2D2DF7C09@DM6PR12MB3258.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxTZkWlT7silR546ZO5kNVPV1wTjqi7H7APaznpGSEmEKj6kPgRWK57sgV0vCZnsZmN7JRBDk64xMxHUShq7cpVkKE1T8nn6LhSKnJSfNvBS3d/kH45jFSXfzH4WEnoVn7pK9c2dTb4sjtF2mo+0ID1/2sbrbiMw9XMcK5uc2g9E9a/X8LDwyIsnmzJpuobsh/W2diRIVVeo1p3Zwmoi0NN4Hf/HAj87Uh6C9xBaUU/zqzTax+/UR+S35Q5MAlZG52K9hrKNYr2vbKCHXLcwLPtDAvIgyoG4JEwNJ7T/8k3ZTeeg9X6vLI8tGKEfKBscTrW02ipH6epy3Zllc80HTilGqKAlOEwb1T1OqtGKA7Bg2XVgrl7/HhsXFWUU7/+8v9A/kpjUmgsTElEIXO+P6CAuXLXuuFZT1+VarnP91RzwjPUHwHH38lerxnweJ/+zODZKgnmhudOGBvBZoiSUVRGEfQqv9QrZZt7zvDoDy7fDYmBag3DhM5eOTtbhVCTV4cEKlZHffsyBE0E5Jj3Kjb764pWbfTgtt3YfTwK6ubt0EofayIVC0RKMlmXFhx/EiUU48HZ3vAEgqcvELy+gH+5bKUfk6+9yG+9UTZ5B+CGTbbR8dy13jfbyadmwJd+Q2OE3zblVHD2+os0lRi0aaEPYNs3snfIxBPT1rxXjZA4J0yTcXRCH6weOzmB0Xs62uVSYPzoQau3O/9gHvBr1wQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6666004)(5660300002)(8936002)(54906003)(81166007)(356005)(7696005)(26005)(316002)(508600001)(86362001)(4326008)(8676002)(70586007)(47076005)(70206006)(16526019)(186003)(2616005)(426003)(82310400005)(336012)(36756003)(36860700001)(40460700003)(2906002)(4744005)(83380400001)(1076003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:33.2318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0eb626-eeed-47e7-e244-08da2d43a22c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3258
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Sonny Jiang <sonjiang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sonny Jiang <sonjiang@amd.com>

enable vcn v4_0_4 sram

Signed-off-by: Sonny Jiang <sonjiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index eccf001928b2..0974ebf9a9a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -189,7 +189,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		fw_name = FIRMWARE_VCN4_0_4;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
-			adev->vcn.indirect_sram = false;
+			adev->vcn.indirect_sram = true;
 		break;
 	default:
 		return -EINVAL;
-- 
2.35.1

