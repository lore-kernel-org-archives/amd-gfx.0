Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592D0C61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 15:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A974310E26C;
	Mon,  6 Mar 2023 15:54:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F4F810E296
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 15:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXw3ZNuh+VPNTYye3otfaQjBz9HnpLiQRYdTcwCICp481CvhpqI+tgBf8J0bzqBrxpwOrZQrClqMg2qlMMFzWvhcZkiX5daXgh/5mz1xzbi6jK46ex91NE5O0U9nSnht9JFGhSGvjjeB1E+U1Inc2MCXjjMMrKSmr6xw9e46fidrKao97aFhpPk4NVwS9heQ/JiIJRjRnrHoFbZ/+CQ/XmD5eQio3DmSF6NODeUq5NfdcvhTcC6VVRtQn19hZKcBsJGXejC+fNhhBO7kg0mQEDHFc5THCZbOTc1CTZ5jrhTngf60hHXP+8wkipJ7My7DB8+QI6a705/lydLAE3PhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOclgPf2A4RLmL1UViqLTNBXHC0WJH6r/bAXoT1n4tM=;
 b=KTVFHY7Tye1abXr6RkKy6YTvsBrN24tT0UN13VN+eTZoIZALh8/unBNcryuVYWFAApk0h2ttVTaSpdvMHwVxK6y6PzzxrJPvGVbvHLT2n4QZNjpCE+vM8flwIQSq0/NXpjNmueIJu8bUQhItElwKMcNhI+MhknCcxd+BaMcCuUdLYgkfok2NGzoOtMqTc+9c9LvXeIG2e2TqUyoatp0nQQ4ms4ZX+3qOjRxsw4X5KP5L6tguq00HpwOfjR4FtR7k8ocm4La4KkDil6ZqKfytAmOcIUktlKML7ghgvXRinrE1MjFapj3notYUckJdAVPIDEX1945d/Dh/uC43Ym4ckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOclgPf2A4RLmL1UViqLTNBXHC0WJH6r/bAXoT1n4tM=;
 b=stnDT+zkRFcATvxC6ijOpR+E3FX2DDQ6YZcCjwuF6oWT97lsZkyjvSgLqs4qdV1uvDoQ0os9WL+gyqHfI1DEdvdUXs+t3vZEOWgvmON9Jk+Hr989yMFwIhZVRI/z9j/vFKnnzCWQ6bxp2+l6Zz+z7cHNveDMIoRdPT6QLK/Wlos=
Received: from CY5P221CA0045.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::31) by
 DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Mon, 6 Mar 2023 15:54:03 +0000
Received: from CY4PEPF0000C978.namprd02.prod.outlook.com
 (2603:10b6:930:4:cafe::a5) by CY5P221CA0045.outlook.office365.com
 (2603:10b6:930:4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 15:54:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C978.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.12 via Frontend Transport; Mon, 6 Mar 2023 15:54:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Mar
 2023 09:54:01 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: fix error checking in
 amdgpu_read_mm_registers for soc15
Date: Mon, 6 Mar 2023 10:53:47 -0500
Message-ID: <20230306155348.41081-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C978:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1ee953-4b49-45b5-4119-08db1e5b0260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcCOYPt9ywQYBBBfHlr1hFneVRqKlEpr/gXjOuGiZhQld3s+vfnxfJ9YbZNFE9QVjC2T2vGyRHv0445K5yJ1oSJllfqTAL+gq1IDMlShaBujVRTV/IxeJVVvCIyt4UyWEv39OM8IILpRCx/OhjKZjMvmqGE99bcMC5a3WRzxfIPknBrTNV/dDubaPyRMq1OdgldZWXNP5CDSaaCOoIOuRAu/o2HAORKpsgC3/qj6HcCXIcrtdeRhQ+30Mj6r6BV8ZBprxHIGrT3ayvU+zsiy9zIoEvPQ7hY67iK8tXBvowKQd5Hs6p0GJ9amulRpKgjO1zc1WFo/NuqimTbMVdeillV02kLS+T90TCKiIufdaOz1EvaVDJdTn077aPgtzyXOlELnRp5A2D+r1+TfNVA9v4Ezs85ko2iwJ2+NV6jBUWuFOAf5XLpuuvG5rs9QM71jrKqtkJ8Q3Ee5qrQgNUYVfxlm/XMIxMQn5CubdvNV8pYzPPtJ+z0iDe/GS+zJp20YTRmHcB8a6C24oqdC7aU0I7WMu2qcO4auTR7PaajUfPv1wxUNKcquRvZIyCxrr7rWae0sbA42tNAMVP2domMdKWuEd5+X7gzb8g+nCFwiTr4M/fpLabVosKsUCxVmV/XdbkaITMG+/Sc0nIwxmXmr4TuDHCOvZB6wxtkwoWoGm9UU4KLxCJNfbJtn1fIy3kM1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(84040400005)(451199018)(46966006)(40470700004)(36840700001)(83380400001)(47076005)(426003)(36860700001)(36756003)(40460700003)(40480700001)(82740400003)(8936002)(2906002)(81166007)(5660300002)(478600001)(356005)(86362001)(82310400005)(2616005)(186003)(26005)(16526019)(336012)(1076003)(6666004)(966005)(70206006)(70586007)(4744005)(7696005)(4326008)(6916009)(8676002)(316002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 15:54:03.2214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1ee953-4b49-45b5-4119-08db1e5b0260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C978.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218
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

Properly skip non-existent registers as well.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2442
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 7cd17dda32ce..2eddd7f6cd41 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -439,8 +439,9 @@ static int soc15_read_register(struct amdgpu_device *adev, u32 se_num,
 	*value = 0;
 	for (i = 0; i < ARRAY_SIZE(soc15_allowed_read_registers); i++) {
 		en = &soc15_allowed_read_registers[i];
-		if (adev->reg_offset[en->hwip][en->inst] &&
-			reg_offset != (adev->reg_offset[en->hwip][en->inst][en->seg]
+		if (!adev->reg_offset[en->hwip][en->inst])
+			continue;
+		else if (reg_offset != (adev->reg_offset[en->hwip][en->inst][en->seg]
 					+ en->reg_offset))
 			continue;
 
-- 
2.39.2

