Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9848FC3064D
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC5B10E28E;
	Sun, 30 Jun 2024 14:59:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DeA4cxxM";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B62E610E25C
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:59:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtI6+z12L4laPvF1FfZu914tNm4SsKVe7hllNmco21nPLC6JhevUG2fb9TgCFIV3V9s2I1gFNpa9RSNM6K7z9ciPqahqjDj3qPEs2q5Yl2MRoWFgrjNSTnZcpf4kH018WEmjZv6xDErRrH9/X7nm1Y5HwqgpJlErZBULBuPAcKiTQL9f+kNkjL6rKsrElp476DS7zYGCRZ8NluGbwIgV+YhriZY0TUaSeRMMBpVGVOjFgaj4XSzkWU6bC3fqf1DYlgD91oWtyOcQI+8w0iHpxoMnVCKXkjRIwOhvv6q3fpXDbMpzH+BQkI0dZApWOdSLTP6mSv4OdPgJq+2jFB/Yag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMj1rfoVUEWWFQLAYP21vtUa7bweKuoK0U0cud8BOgQ=;
 b=HJCGIVDp4HoKZLDrZAtB6g7lXucxfqunBNYs/BEm6ohNYAfG9/C5udVxgMSDIce0EaU3K5XFDo3Dz1ZrmOX2kpN7sLZY0Q8Z3I7rvXqQs3xewExrK99LEAPjA9/2dt09qhUzY79SGkP1G1DV4tY/rx7YK5YCbsPWSKJm+v9AGgU65A/tLzV74XQ7kh5Dv1nvSAr6CZTPYPnp2JuIIJ4jt2/haV06k7Sywr3Bd7E/lE27llPVlFq98jXM7cWa6U352sOs6EEnhn93wQAN6mAcrkyX3GVFthvAXRmZvjwiCEYJdSTveiYLCzac+GpQq2qDGqWt+UJhns/pmYWowb/bFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMj1rfoVUEWWFQLAYP21vtUa7bweKuoK0U0cud8BOgQ=;
 b=DeA4cxxMBI6F5hXrwazOAA7ztuEdJYXD5Gv4Kp/OnKxpwq9Q0y/CDKPcYqE3zM9BX5h6CSdM5AAXRaAwJrJ6+kafOaFnLXaMEAEMpDOwBGiTEonEpHdQ09ne/42CzeBWRndi7QsFOsTW6Olvk+niCex80yq2vdSVQ0KjVno/yiE=
Received: from BYAPR06CA0057.namprd06.prod.outlook.com (2603:10b6:a03:14b::34)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:59:32 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::47) by BYAPR06CA0057.outlook.office365.com
 (2603:10b6:a03:14b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 14:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:59:31 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:59:29 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: enable mode2 reset for SMU IP v14.0.4
Date: Sun, 30 Jun 2024 22:58:30 +0800
Message-ID: <20240630145831.2023399-6-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630145831.2023399-1-Tim.Huang@amd.com>
References: <20240630145831.2023399-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: bf780530-8d78-48fa-2f74-08dc99153f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qMTuSp9jXozVPc7ejwkh54whcJZ9oUPfusP1SYODRNlrTw4g+1UR7ew1cLEM?=
 =?us-ascii?Q?dpuHo4nA3sonZD6UPByAUa79BmJ6RvTzAR7VykxKWg3NW4sTnXQ3e3YbKiN8?=
 =?us-ascii?Q?OGpsw7q+gFRYQaV4S7KOeF8qIYjVHVGizm1YgouOmuDAAMieGde0T5isargh?=
 =?us-ascii?Q?Zmw59Ogzl20mJZvVzBI43C+P4STtlsNJhGKqEXwpDRLOLk0UUoJcvZhI5mi2?=
 =?us-ascii?Q?wIYQVPx081u3rYklpRXl9z1UdrCGGuts6jIJwbkZ/3TRG61UbQJwkAmKIjkh?=
 =?us-ascii?Q?XFmDw/ESFc88NOKUA/8+sYoyXlg/tfI7Y+Jop/b063++uT4myNqOOSnPj85G?=
 =?us-ascii?Q?32+O82R4/H1czYIgUe7GytzUUemUQnO3NWYSXCLTgnz30/mLi4jnmlB734xz?=
 =?us-ascii?Q?S0HgHeotovlBoEALQ6YeNQ3xn1PNepo5uzkk5V7djFe2TeSY8XDFPQkoxnji?=
 =?us-ascii?Q?Dj4put+DDyWBvNnTce386x9y/AxDKKAyJsSWtaqf5xdIAmCYBAefd1dL1bpN?=
 =?us-ascii?Q?Jx4T5P1TmcwqeXZl9dvPwlXpmr56d7HRcaexPoUmCigI247OIOH+nTqPqFe6?=
 =?us-ascii?Q?elTsS+fMRvlSUGv8oFwqicTUL03RaAaRYiPiD9VRx+WFhgo4XHynLDR7cGnU?=
 =?us-ascii?Q?rgG0dplHVCHIwBspFuiaS1J5UdBsXfvfnX7rum4clanmAlvvXnYolejtoIL/?=
 =?us-ascii?Q?G+uLmN0Mg6Z96foBPUFdFjxB8eK+YFDo78hkLx4dU7SGceBZ6ns/dMMlE5FJ?=
 =?us-ascii?Q?Y5sDdCxGgHmyNPsUGIuwkDUwfHE7yfPu8Rh0WMfAY6DRjqKG6/phKIJc8LCx?=
 =?us-ascii?Q?ZqO5TOwCH9l+cD3uyqiZxSPrG20fGxNv3gu19PK6acIaTAf06p89B+BgAN1e?=
 =?us-ascii?Q?8yYltR8FGtHyoKbEhg/65B19ASNKiIGlMNKCxkqH4BnXF98DUimj+HIK1vxT?=
 =?us-ascii?Q?gtx2LMgQR9lG5/pEJoes3VrRwuoW+42zUWIrnqxBXCtXuYPn4fRArPHp7QYx?=
 =?us-ascii?Q?eV8WpQBnPbiEb4SSbJWU0/TQihl+gSxN5fVjBXHcEN415rum+rol4fO/vXAJ?=
 =?us-ascii?Q?8g7XcxU/GTHNC/yh5lJ6y9PU/0BeyH1gqNMWwfxQAwi6fmXfTP3CTt45gKSO?=
 =?us-ascii?Q?myCff/oX83EpLx1zcKDs+vXXjqiVpE8F2SefdN8D9zr0qFxsIMylyohw/nfi?=
 =?us-ascii?Q?Ib/SYej2PAJevwnO5KAGnR0i92LBMxYCOQ4jKiELY84r4yAT4QtAQ4Vq7obp?=
 =?us-ascii?Q?/kb8lg1vCvmZrn/sySJ5z4QBURp0POKw0xtgRJmeIU6ortuPiLerrNUXkG+v?=
 =?us-ascii?Q?eO74UeWuo6ODj1X49eQcgTSttnD2EnBJ6JR3KFIn2482sJGJohoftKOSUfxX?=
 =?us-ascii?Q?69FmEGNVJzcLQvaGGn/6E+Mjp18A1dMVNDxkYzL7dCrvo2cOl5u2Xgty+H0I?=
 =?us-ascii?Q?Woml2h1Bkfj03+Wsfg/m8sT+No5lSgV/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:59:31.5663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf780530-8d78-48fa-2f74-08dc99153f6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set the default reset method to mode2 for SMU 14.0.4.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index b43c50f1c7ad..6cc86d13f32a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -389,6 +389,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 11):
 	case IP_VERSION(14, 0, 0):
 	case IP_VERSION(14, 0, 1):
+	case IP_VERSION(14, 0, 4):
 		return AMD_RESET_METHOD_MODE2;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
-- 
2.43.0

