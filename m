Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C38CA5FDD
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4501610F9D8;
	Fri,  2 Oct 2026 19:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w0BpjhWJ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 508CF10F9D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9pcC9LvvefhM+v0+Lsbv1SmMUlk3AceBCHjtL+OrQ488Cc5YhOSEDhMyRVklcXZW5ZujmfssKXY88NPTf9itvwndK4+PjBOQyuxu890WiqmJOySsuQYMOlsf5V3yvE49FrpAZaeDd4b0ReFp958N2a1GfZJ0uQHIkvNG4d0j6r6HMI2eWk0MCy1jp0JNHSw7vDV375FcAFuPqymx7i1GJcLejP5/FqRvjRRi1YCruOcEzFWOFy3Y6MEmCrp61VdbqipBMmKQXtPGYRa+7jntMD/rn13S9nkELr3gexCQ/RzWlozHIyQE2iS6Db/ZuUEkMOmBPQjsizwWXm7zZvVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7zWVTS/xzVrGJ3CtaUSx9qwCnRgtEgBtk4Yh7K27K4=;
 b=geL8y+7CcqRzLipPN7ioSm7JWZWTDX7uMJhzI55oMdCD5oA1bi9GVXo2ujKaMHp06CQ+ychjH8oPbSVFUTTUxsDb3wJXxG4wJzs+UmnHuQ/lJX5gaMiAO1jhr0EgjKq13i3q5hesHVmfDxtB/TwiknLvDWm/H6Ho1QhWJIYvZ9XYAS61cESWXEWbB0xewEWCssZZ+HL9ebCHcCq28skVDxl67+/5SpqsrUQ3DiiclTzbgjWh0fK/tHdPVc4IOdyKug05B8m5UHJ0FW2kp6mAL15bWZ7VUDgQpVMKfYlml3SzlMJVfTy5DFIh7agMUpbgQPb0/Uz+Jr3AIKMLg2/Sfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7zWVTS/xzVrGJ3CtaUSx9qwCnRgtEgBtk4Yh7K27K4=;
 b=w0BpjhWJhf3NusVrE90o3s+O2JUqRm6ObtqaKmmd6bPEYMcR/yAVWAVlyFkXLvFHTCXnC17tOYI97ijW+ZAcmSRadNbN/TGdK2gf5HpDsWb3Hi4QMK6keBAFW3xkM8P07//ZUCzaIlThflZvzpQfdAPnYHrv9pUgI9/vzh4PvBY=
Received: from CH0P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::15)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 19:33:08 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::a) by CH0P223CA0003.outlook.office365.com
 (2603:10b6:610:116::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:33:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:03 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:33:02 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>
Subject: [PATCH 01/17] drm/amd/display: enable shaper when programming 3DLUT
Date: Fri, 2 Oct 2026 15:32:24 -0400
Message-ID: <20261002193240.3441018-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c9f3e1-5865-45a1-0c1b-08df20bbfc97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|56012099006|3023799007|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: i3HBwrxU4oxPmMUHv6DWP+jiPKK6dPD8u5uGgv5VcdF58FURr9fQtzZtJD6hs0fkJX52MOSxmstCHcR0CkJGc47YczmzivvjnFyKqmWscFrCLqg5wPaVVEh9Z/dVuizb9ez1pBQ6OzApKGtnR7LMpNRljhK4lJwGsgc0HVNZj8k40nglooXBn2m5TzyW7J+y0HLDVJWLfz7OjTr0TDZaofXa1TMgmyZUIn32n5VmOAymAacLgC1Wb/AhFGoGuWnpnGmAplNxzln0Ah9TZZM6pSgaBVOEJMPOrim0GAPuObiK2IT9nkUcb5E7eSOkCFF/K9KsEiMMUKGEOo2kFaOKst0qqPQSWpn3ej99jVpDz2jNo/v2PWY8MWedxeDcqiZ+G1et3SSZifQd/0AyvLO+AI9qq1E2+52oulHlDhACwnElCIw6Y2OmbX49IqBPhGBIiZnTALMB3ThrsbAa9TemkYaA2y+RGv59wka3fteTp31EVR1oTINBb+O9k/UHLSeYoMH5vKP27oqSPKNlrSnQKg+2ZyaqiBGbnGW2yQ9F9D8dYdX/b+RDx16IttH2DPca2NAgsvooLp8LhsenjvDPBc/Zdu6b8YwxjpUWAak1tkGfsMcAXxbE7t0+6poquUBx3f9bnPkuFxLezNUtjYf8WrwebSMrUl0xD7xgu7z74rNajMgvyUd7kHY0/Yit5dQE/13USmc7cMUQcz+ts8vdRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(56012099006)(3023799007)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4+e4nybTzZKPKFvIBdHHHJBXhk6kQSv0I4YnG651XJuUYTzooBue8ebqje26hFBxIlCqw0+KgAeC1VNxrRj0hA8Qv4N3E6Lo0X4pTenHFbrrTUwnOJ/VW0sz/7bm2K3JntmXubzd6yKwM4kBGwhssSSVf0N3SUd9+Ivl9OQ8LwLDrdr+ph94Ci/MSNCQl5RfKMxAD+HQ6wMJciecUJBRBdhebSPsB0A0J/19zZI99d+bgsp1SUYIWmB1a287+TtW83SFMsHUbC8U595A+z25eZ1Q1KuWSQsxrOZ/aGdmSTCFUyuid5a7S9Y84vl8ZmWFLzer+7cNUNQb06EnIfgdS7lS1wTX9xAh+mpPPsmvb2x0KOb/0N+xIaAn28eOjfyt19xnkYHf8tNjNaQcPN0X9uE4+uwOvbswTuBjB9xlnaKnwS0FrWDkKkur96WQ5KxK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:07.8103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c9f3e1-5865-45a1-0c1b-08df20bbfc97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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

From: Harry Wentland <harry.wentland@amd.com>

The plane-XR30-XR30-3dlut_17_12_rgb kms_colorop test fails on DCN 4.x.
We need to make sure we set shaper_enable to enable the shaper block,
otherwise the 3DLUT block will stay inactive.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index eea7e7dcfa30..56d5b9cc8385 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1836,6 +1836,7 @@ __set_dm_plane_colorop_3dlut(struct drm_plane_state *plane_state,
 			tf->tf = TRANSFER_FUNCTION_LINEAR;
 			tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
 			ret = __set_output_tf_32(tf, NULL, 0, false);
+			dc_plane_state->cm.flags.bits.shaper_enable = 1;
 		}
 	} else {
 		dc_plane_state->cm.flags.bits.lut3d_enable = 0;
-- 
2.34.1

