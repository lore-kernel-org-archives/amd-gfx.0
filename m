Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C229BCF8840
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 14:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B53810EA24;
	Fri,  4 Oct 2024 14:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B9SvLIIr";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 610A810EA1E
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 14:30:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUXnxFltQufZvk+yE/DChwAVxMWldvVMbzh8XMMF0V0R1Oy17PZRXH95IeYf+DgviRzqq3XSyzTqc9CLk3/MScyI3O/XokqGNb8hg0QErQxA6PickkNTmb4Pp3EjYPHCE4UxqAUvOa1UEB6zTaAztEesBRiK8DUAG15J+jVi0zQllM++I+R8msYKNvox/6qKUZZXzKlMTfN/1VGIcX3SztmdWVtnEmSCGxgpAYeVS5xeNGDxnzipvc/VoXsv6xqJiY7kTrLzJI78Tv6mkTO7NfrivUNvUisQNZkCYl+Dy6LVR6g6wIFtmkq7Ao/HDtUC3RwySIIlkQLFqnwUXu+nUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAbmXOVrOL0UQfwyOdN7RjZd/aOc9gxE5sD2z7vN0po=;
 b=G4JQ8BabqOSZuaFnJAYwPBEVxLK04dgPW63SlopKypS/5+PLpyStoWBm/nDdGbUPzzWV4L0Ulx/+LFzlBrjOyZbF8LrS2QL0T+Fq3MWZAG55wJFiOjrM1tSZkR+UWvQmFItnB44+wkdFJnRp4u4t/nc18U5AlvcvgF9OjdhbsANtGb5OYLUzW6u2h4MluBr0a6j+bYiXrtTpWpExPtkm/O4SDltvry1jEYk9OR2b9ZjixxYmt48FaOHL1L9GnaDXcqYvQUZbNdebYr4Er31G8kRPQvGOZKJeRjjisHYJKM1fyraGgVWNF+Xm1AfLJ9fAlPuPhA1D0Q0ZTj9+OnUVgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAbmXOVrOL0UQfwyOdN7RjZd/aOc9gxE5sD2z7vN0po=;
 b=B9SvLIIrO86JidoI/6AoNoj0N5PqGzsZtrG5hkcULZLBRjRD6zHtCitfi03YdN0NWy6vLo1PJ2o828zRTg99AYpqWYeqzQKiWgwqT/u9cnkB/DqOUTMlWR80rEpl1T/HOjg2w/mjWO7iNOo6Obj0Blb5R7TGY2VSiKQlgn6tmOw=
Received: from BN9P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::17)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Fri, 4 Oct
 2024 14:30:29 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::67) by BN9P220CA0012.outlook.office365.com
 (2603:10b6:408:13e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Fri, 4 Oct 2024 14:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 14:30:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 09:30:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: disable SG displays on cyan skillfish
Date: Fri, 4 Oct 2024 10:30:10 -0400
Message-ID: <20241004143010.444578-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 100f5484-95fa-455b-6a31-08dce4811856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?74H/nUPKVv9tUSxU9ERM3gm+Wdsq9SE2zsXM5BWvN1SVAlpKD1soSYDSWndk?=
 =?us-ascii?Q?gfGmYFw9OkG+9d9DIKqJ9aSdbJkKMedyqNlGGxHipRYczVVfZ/ifKTUw21bP?=
 =?us-ascii?Q?9oefzV9zoG5cFZQwWQs1X5+brY2D5kdnOS9K1gX1/CwPIsv6n/o+1NwXiZWm?=
 =?us-ascii?Q?ivh1A60UAb/HLVs2cbExSUByUFD3hP6kTYyIKS9vbPGX1RPthGSJ8UhgfGEe?=
 =?us-ascii?Q?Povd6gY2gJAL+Z97AV63q4fffb7oxELhtmd5rV/afvucgrpOVtqhAalCR4J+?=
 =?us-ascii?Q?1H3G+zWT4LDJqKB+MNVPB9dA1yhNXefIkv1n+nK/do1eQr8IheJKsU0maaj6?=
 =?us-ascii?Q?nvPF5evK9aC0NlsuDHB7FFIH/qWJTQgBLqSpnWwapuViTbQ6LUw+SAyD1veh?=
 =?us-ascii?Q?n/p7ZfifLBcgeDfb/xQjHJ1KKbEQpngbvnb4Wqf4miRqkj51KGtOYSHzcOQQ?=
 =?us-ascii?Q?DjPEVuxlamMgr5+W+YJhSY6N6HH6OKrD0biWId4q8GcthWrSKl08EuO6FhIP?=
 =?us-ascii?Q?31a72Vq5PxYKurWWEhNShnOXana4ZCJc61ZJiA5/C330+pCabK94Xy1OlJhf?=
 =?us-ascii?Q?A1gBpWnmYHyYTSUlOykI8oy3JMGouBSStfVZIZTKgRxqy07ysTHEKRznYJAn?=
 =?us-ascii?Q?vllf3fNsE9Nvg7f+J2X6MoXvOUXufm1TaUe9BD4ay08810T9GGBsFDmREHLU?=
 =?us-ascii?Q?cuIpNixXeQx3GYeZsuAMBM5toUvNrMvnaj07KnTyArfVnM0pjewQuhmR9fX5?=
 =?us-ascii?Q?xpv32iZCtuMqa/LEQe7PvHlAcdxcS/b02JuwhtmHPqG+dxHA2bQukmkusIlU?=
 =?us-ascii?Q?NUP9AxbiIB8aJ93qHHcFPeuH4lmehkixsRzrQTFdPMrD1as+tK1HZzEQ4YiN?=
 =?us-ascii?Q?TdDY26ptQbu5BkV9w6Qfw4W6pyd2VrEWczfhY35JQ3DJzjE4skIbkWxgCxsB?=
 =?us-ascii?Q?4JrwcUvgeaq+9aqObcyHfsUW/AybS65x8VUPtZ2UiTAVHySrltKN7SIF7Ktl?=
 =?us-ascii?Q?aVh3mQzbRVWSxPG7+fRma20XYiHtKF8+iGsMRLvjxBkGiA2UpAWDgTUXEuaV?=
 =?us-ascii?Q?iU0lpCKzv26T21TEjSwtfvSr45vYaJ6tjfxGBHzenWBdsIzHa22qlWVFiK6A?=
 =?us-ascii?Q?PAl4Z6sC64SS+LqiPowmoQ4DOLrREvcX5MTDnctNdoQ33aduX2Ns25TkDWgs?=
 =?us-ascii?Q?+B4xxFADD28Igc6bahRWeMzDssRja2/dpEZtka9R9Q98XX8AhUVry4G83aUZ?=
 =?us-ascii?Q?3U/APo4dZN3UGmQ1UIEYw8ft8mNCpratVyvhSCv827adOGFkG9p8KbfHesPU?=
 =?us-ascii?Q?XhCTty9snnOkwwnmr7WRuc2m?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 14:30:28.9373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 100f5484-95fa-455b-6a31-08dce4811856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621
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

These parts were mainly for compute workloads, but they have
a display that was available for the console.  These chips
should support SG display, but I don't know that the support
was ever validated on Linux so disable it by default. It can
still be enabled by setting sg_display=1 for those that
want to play with it.  These systems also generally had large
carve outs so SG display was less of a factor.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3356
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7616d7a509b9..84fdfb4c8bd0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1886,7 +1886,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		else
 			init_data.flags.gpu_vm_support = (amdgpu_sg_display != 0);
 	} else {
-		init_data.flags.gpu_vm_support = (amdgpu_sg_display != 0) && (adev->flags & AMD_IS_APU);
+		if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(2, 0, 3))
+			init_data.flags.gpu_vm_support = (amdgpu_sg_display == 1);
+		else
+			init_data.flags.gpu_vm_support =
+				(amdgpu_sg_display != 0) && (adev->flags & AMD_IS_APU);
 	}
 
 	adev->mode_info.gpu_vm_support = init_data.flags.gpu_vm_support;
-- 
2.46.2

