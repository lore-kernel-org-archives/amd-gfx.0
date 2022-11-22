Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFC2C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38EB710E37E;
	Tue, 22 Nov 2022 05:53:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 888EE10E37E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:53:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4/AsHs1MZC9zu/kIaFNyX45HnP1Am+Ldr+v6jFLzBrVqtLhXYlZS/CgY+y1i+ri3IoyVngURi4QCoVic2enGgG6w6XodnOC2KG5pNc5mRAyQeKuMcshxX9+If/ZngyYqD3i5355KRb1o+T1MlF0sHDiu62mr4lfu4IFw9gF3HwJqqytcbRsxMQzaNzPKTvO/YQ0LtqqmKJ9wR6/KFIpEp8tVzVqwtHW3G21dnrKuWgcUiTT6RDYYplkUSjkLXuGIq5xFUfsF67Eub8IdamIm7f80a460ZeltLcXCyyBBGTGD6SxLVCk9QbYfI4NqCKNOxWUdXyEFOZnujiYkv4IDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc1yt12wqiSHejZSCQsCCb/FLt6gQois+Quu0JrcsH0=;
 b=Ue/qH/s8GY/O3rGeianvE5fIKtsoTDq5pvSPd6zJ3NJRtmwftuzKDECe8xFbf7BAlv2L0BWc8QjOpkDJqQftPow6UMLrfP63waC797+r1q9K+hlVRdOpWPMktasS9YVnXx/3qlyK0ide9Bc7VXyxE/cP0Jy/NyA0xltt3G6E8nDC8kwGn2n++VRW4CcKSt4cZk9COePxUIPL/GVVS+iWoqpbUUtWl1rnQyIsDCK3VOsfMhnCCMCrr99f/1IYKl4bYIic5+xVNt32KWG4ojjxV7swxv209EHWINdV41FN62ZmljmxjPF0R7XYrIRh5V7VU7mPloNctBIOMoovaupQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc1yt12wqiSHejZSCQsCCb/FLt6gQois+Quu0JrcsH0=;
 b=A2ZJyT5uKgGbYOFrGwSTFnVIrxTHnJjoMEV6ewNy+s3ac1PiV/G9CZQppO4FTbQG4qq47jmxV2tVlxd63M9K/W53cAR67q6QM0FUQ8+21/lkTl00uo71xTsGTSZwgwtv3DqsWuWZo5j8Y7JitqnqGlH9M6xe8sCefF3YhFNBMP4=
Received: from DS7PR03CA0017.namprd03.prod.outlook.com (2603:10b6:5:3b8::22)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:53:00 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::f7) by DS7PR03CA0017.outlook.office365.com
 (2603:10b6:5:3b8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 05:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:53:00 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:52:37 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/19] drm/amdgpu: add soc21 common ip block support for GC
 11.0.4
Date: Tue, 22 Nov 2022 13:50:15 +0800
Message-ID: <20221122055025.2104075-9-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122055025.2104075-1-yifan1.zhang@amd.com>
References: <20221122055025.2104075-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT023:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d35e2d-5707-4e4f-e980-08dacc4dd004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpOzel1/sJWbFg9etx7rvBlxBXgaZqgdhsrDM7jwRjS7PvzuVZjTjWCSN98tv6E8lWWSWgc23bM+y5+ac3Sd+7IaIikaOBnFT0h8Qx6ckHGAoU8uz2zjk9uTzRwjkJ6l+y4WEfTZ8CX0oT6+ZgHMKiv+rRcXZ2dIDcQx/HrPlvdTkb+eBoGI4PZ/mAp2uvouT1gXXIGzhd+MgW0wSIAVUCamK+RmKCR7T1jTZlALlclJPBf+P8hJNWilkvq0WzkjVLQdH7QvwSUEjUwlmU5sW/4RAluZ3+lE6p7sqir25Mrw51XAutIHeVoaNihITEoDKn6QP6SVgi0x3Hh0EuHDTk/i6bJ72lGeVI/hhFZ3OQ1zjLeNpuDWeokhtkBnCjMq56Jz5CR8zTEHBEummjqZLVFJ+U9bC0/OgGfg3pROcPLYMw33cnTq/hzmUjxhNdECBodfNk4RahTygpNLjB2XE2yFy+9LS3Hm02XpnT4DKPmS+HwErmJPfyeSGekWa9GCiEgqS3QnnI971jZZ3sucFs3W7jg6o9RZi2eKUUXVu05LBiBN9Gkf28qmffVfY6C/tO01tGHBsPd+4nDGdLgA8pfM2CHO35AcCdz0ZdIihems5cPfBSg04s0qyKppkB/ils6H2W1k0hdO43BKwXFeJLDKNI7vgVW0YbyuApT2w+XM/Ry1UewOeZOGSTBnAyjViKfGSNXZHhNCaM48r6rIoxwKMu39j+P7na3DnZGlO94=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(70586007)(8676002)(70206006)(86362001)(4326008)(5660300002)(36860700001)(4744005)(316002)(36756003)(41300700001)(8936002)(82740400003)(7696005)(2616005)(26005)(82310400005)(186003)(1076003)(16526019)(40480700001)(6666004)(81166007)(478600001)(356005)(83380400001)(40460700003)(54906003)(47076005)(336012)(426003)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:53:00.0096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d35e2d-5707-4e4f-e980-08dacc4dd004
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add common soc21 ip block support for GC 11.0.4.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index b258e9aa0558..69dac2aa8151 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -644,6 +644,12 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x20;
 		break;
+	case IP_VERSION(11, 0, 4):
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0x1;
+		break;
+
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
-- 
2.37.3

