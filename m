Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5241CAC58C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58BD510E858;
	Wed, 10 Sep 2025 05:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CafdgmVm";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85DC310E857
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCUf6tU9MmJSneRJ9YNKaVGnST9vqkfavWK+qd7BjhG/iMha5YaMhMP3PHMsiv4q09Skm/U/qM4smMsjs663GwPiv6XIhLSbYQuG0+y0425l8uuqIApCa3GXUqYHdsMkYfDKXBci1iJ7Vo6IzqUjkH0XDdNeHHGLK5ptENvXQwcWiUJOrPlzQ7IEKDJXQ5L4mnPdTZCKtCUrsAym3VNwlF2d2F/7+DVH5cs0G2T1eoALguipgZ5juCMd4kzqY7XT8L7TxkMsRsviVBNCHtTMks/V2bVynWx96t2lCpRfQyKI4RpR1Kw9s+wf3aiVLJG+w7cgH2/EzcbCM2k7P8yoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcR+ab+iOQ42cqt4uJhKBOOt/nhQSgQLPus/M2eGUKA=;
 b=FbsNbpAgqYAIqboXVohpS4G9i0mzPRNDfOFqXI1JBMpugzBuiXIhzEiDSws/gqJ9KITankFEHBbvmzqfwvCsBUHVFb43WKWOPqRM6OjCyfoi/9vRyU0gxmFSoojKv+vjFX6NCXP2Qrb4Jx8vbWminGaVsDeoBlxkZOJsNNiTrjsPSEh3bfiqQd+LgKcdad2vaTTdrr0KGia19u5GiKc4iDFeI1TtE1RDOlDf5TPWJ0jzwbZY04GkWoTxiFpqCiHLXZbUbBh37NaafLthCYPlks0ZNXxnqxd9z7ScCyrNsvA8EffXedkAMAxHpzLYk3oJcP720gu2+3yZZjlD2IzXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcR+ab+iOQ42cqt4uJhKBOOt/nhQSgQLPus/M2eGUKA=;
 b=CafdgmVmYlmxgIT0BGyQH7bM0aT4iXnoU3BEPY9LbfjqqRoRgdpndvO1/0PDEYT8XSNrG0hvLebQnnmeNziXsXsVdVuHg/0QF3cmV/vyxv9XPlrXTeq+zvVGagtSptLtEHe/4KmKYdPcPbAytLuqigsWC/KupK4rhQ48S1hu3xA=
Received: from DM6PR14CA0043.namprd14.prod.outlook.com (2603:10b6:5:18f::20)
 by SA5PPFEC2853BA9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:33:20 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::2e) by DM6PR14CA0043.outlook.office365.com
 (2603:10b6:5:18f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:33:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:33:18 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:33:17 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:33:14 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Dillon
 Varone" <Dillon.Varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 09/15] drm/amd/display: Add missing post flip calls
Date: Wed, 10 Sep 2025 13:30:32 +0800
Message-ID: <20250910053222.2884632-10-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053222.2884632-1-ray.wu@amd.com>
References: <20250910053222.2884632-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|SA5PPFEC2853BA9:EE_
X-MS-Office365-Filtering-Correlation-Id: fa06391a-311e-407e-8128-08ddf02b8daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+fUvM76uP+0mA0e1n7WUxwafss/TUePsGUcAemxNm+v3bHFwufrvpOx61onH?=
 =?us-ascii?Q?rXqtYKWyV700N4fU8a/rGDpPmaCXEO0B7fB2NKtx2j/2WSuH1td0kX0u7n2J?=
 =?us-ascii?Q?swZ+hXRmJHXzaY0aokVyvZYv1Nz8X/KjJSxnUdJDejAus1Vop6kIyHz2E+T/?=
 =?us-ascii?Q?7aoTD3bd5nTZVYbSqKorpk3Z0n7tzs6jjo2i0vIj9tmqYKyRj2EjFMSJFmvl?=
 =?us-ascii?Q?TD9HlUgE2/aOSCoj2pV3lJCZkqpxQ5443hubadHcAxb0+AIbWJvSWATkKpEx?=
 =?us-ascii?Q?aHCVUCHTe/KiBncMlmBs2zZttgvobPdwD+i4BoB9YDrIQuz1/EWVsY6SSzVa?=
 =?us-ascii?Q?o5MSjjxnmKOBNDi2Ridz81N/uYxcJLuIiuDk1IxAPI3gX1g8Dc11OrWzA2jQ?=
 =?us-ascii?Q?vpDFa8lwGWROHvR229WqGQtRPaMzyh8kYosP87v/loVxweeWIutfx1C8rV63?=
 =?us-ascii?Q?MdEAO05+KKLS3HWTCN2dq+4JnsGL2OaSUKFLkYKy+Sm1mpAxSxuTf7COtU8Q?=
 =?us-ascii?Q?vrPzImxc6Fap8YoK9hX/i1mpqDdgV877FY9faC6PBHM/gUjhGcrLrtl9+iBI?=
 =?us-ascii?Q?uJXdnt+H8zLANptRC4H3kLlTenCyop5bi3gSl0lIYMvvE3akSDB1Dkh6G8S+?=
 =?us-ascii?Q?Fb1SXnFKCShkAeb5MRDzPIwP1DngR+StZZHwA4Mo7BIJ6bM2MrOARR2ESobR?=
 =?us-ascii?Q?PLfKK1SwjD6Wn7LsMsvwd4F5AAguSR5yIZ+tTcO1MFTiNPKl6NztDL7K3/ep?=
 =?us-ascii?Q?WNoI3q4+8UzYuwLeKyFhgtN5a0uvakAzZjZG9lAcDgUA2MeDBxNJOhDUywhs?=
 =?us-ascii?Q?sUJlJL9tPH6YRtdIQxnrFrsUOnKWxeMAdCljKDnQC1d5i+guxSZbjcDrDrEc?=
 =?us-ascii?Q?4RTimGyYUKi5qpDu621U3t4XD2aXS0/0v5gg40HsIZYBz7CL987hjGj//bt4?=
 =?us-ascii?Q?sG/DIbCsKRjy9mgCgnLPgeaHnmBILMegrK3WNMNnarnHb/w6hPtRy+urhyMN?=
 =?us-ascii?Q?4p2/L8ul+AoyDMfWdN4bCaowIx+jDi6G/hhIbzKGVLrWNCwSpntf05BwTr8c?=
 =?us-ascii?Q?R723r8fPW2xnkwLkTdfq+LAyvbrhsKKeLIFoE4ToxqNWdXfYLAOEaQE8lb2h?=
 =?us-ascii?Q?v2OTp4U32ujChZA/l/8R1c4+IzkymtL59xSMmhEn4W4IGxJCPtPyVkTa/mfR?=
 =?us-ascii?Q?jeIu/4YULsCZBg0ZeqsrtzG88iiVBLhGlLHMmMH81lxsMCi9m1YaXxRihN6j?=
 =?us-ascii?Q?T4LKhMToGJd27Ii7Whg5pboPHFOHjtuPSIy9VgankH8H2Im/wxF5I0fgLQ53?=
 =?us-ascii?Q?I0MZZFDAtCW3j60r8fm11vsGHWIwXMT3qSYFsJaXE4f6UQk6erz6vNxS3sJ7?=
 =?us-ascii?Q?TujTv8XpbcgOvhptAhkD8RzffIRPd31GDC/zDgDd+L9RW+IKS9HB+UXML3pm?=
 =?us-ascii?Q?SRpu3cxP2Lju3HrrkiDxq6qG86qSdQ7x2HkvqF3svN8iIIBCl7CbnLDENm5h?=
 =?us-ascii?Q?lmKO4dy53SrVGoW4iap6PFfdA+a6gL+fT02s?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:33:20.6688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa06391a-311e-407e-8128-08ddf02b8daa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFEC2853BA9
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
dc_post_update_surfaces_to_stream needs to be called after a full update
completes in order to optimize clocks and watermarks for power. Add
missing calls before idle entry is requested to ensure optimal power.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 3 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 8 ++++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b088cb8ae780..849c45d10ad6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -417,8 +417,7 @@ static inline bool update_planes_and_stream_adapter(struct dc *dc,
 	/*
 	 * Previous frame finished and HW is ready for optimization.
 	 */
-	if (update_type == UPDATE_TYPE_FAST)
-		dc_post_update_surfaces_to_stream(dc);
+	dc_post_update_surfaces_to_stream(dc);
 
 	return dc_update_planes_and_stream(dc,
 					   array_of_surface_update,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 45feb404b097..94f43f0cb4a4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -218,8 +218,10 @@ static void amdgpu_dm_idle_worker(struct work_struct *work)
 			break;
 		}
 
-		if (idle_work->enable)
+		if (idle_work->enable) {
+			dc_post_update_surfaces_to_stream(idle_work->dm->dc);
 			dc_allow_idle_optimizations(idle_work->dm->dc, true);
+		}
 		mutex_unlock(&idle_work->dm->dc_lock);
 	}
 	idle_work->dm->idle_workqueue->running = false;
@@ -273,8 +275,10 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 			vblank_work->acrtc->dm_irq_params.allow_sr_entry);
 	}
 
-	if (dm->active_vblank_irq_count == 0)
+	if (dm->active_vblank_irq_count == 0) {
+		dc_post_update_surfaces_to_stream(dm->dc);
 		dc_allow_idle_optimizations(dm->dc, true);
+	}
 
 	mutex_unlock(&dm->dc_lock);
 
-- 
2.43.0

