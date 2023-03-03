Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE18CC7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2330810E6E8;
	Fri,  3 Mar 2023 15:52:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816D410E6E6
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMq5PceUYWAxfKacr4p7gdfAfpC+D5blg2Q/+aDjNea3dvI7GpuFJBwcthc6kCv54VtYqxZaVXng1Qc89/WT3eVIptl8sqlNfcrUXqiuVdhl8SJDPydra6IrcQFaZvq/MhblEtJ1g8kMJh1ct4bwAPusaiWU1rAkZrGwj7dHsLvlC8xkPFSYbgVOwHoChcEmR/qFKXMZxoDA++IbZSrVF8y33KYnb89U2dDup7MGkDBE3DTiLVPvXHDi1szfdV1pIMCFoF/a2Zu/zqKrhjltph3EV/GHK28xILqx2QRdubbw8gQL8bHEXxK/mKXtCG2ZCmiQ9gIdD/E9BPk0KnptiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7Zxs2pHlIt5S5x6SvFHi/852PUTx6Tk6S2uTc1etYk=;
 b=GLG8ywv7vj/+wwI/PRmCNuUEDQ6EdFujlrONQ/RyIsDrhTOEvAp5lrG0oq8Oj4wIHt7L5Lk/z89m2i+j0okhYgq+VaAet6YXwQO7IOdcuiT4dhjEp9rBmBBkGdZsXifdszKUfO1QrS0gkliI3eoK33mZjSbO9q0CMaznG4hllpOnhpVNdvWczbyZV3q+C2x1aGLyP/vnlBL9h7QQwFdrtsCJCQER7eg9YFZBRw04A0NG8toNGlbzslzY9PgQqGevq8jGwZHMgcCKFy/UGdliNm32coRK6lhztEhlVgHata56+QfQZrY3LGbY7Y604TyByC6gqJmaiVKgBl/fkyERfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7Zxs2pHlIt5S5x6SvFHi/852PUTx6Tk6S2uTc1etYk=;
 b=UaglMxG7SDw7mcadDGrOxFMSDntxlDq2jVDi83G+jNZogKqCgjVsOEhdxFsvpZpUwHvNeVoeH+xVrHrw8CON6LbUqcfI9mJc5me0BJDmmAYr+GJ61J4MrQFQdaKhhhUpfeUt/4qb3qDpS+I5zVPOOu5U1fb/8uFkXjr3IN9siZo=
Received: from DS7PR05CA0091.namprd05.prod.outlook.com (2603:10b6:8:56::12) by
 SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19; Fri, 3 Mar 2023 15:51:54 +0000
Received: from DS1PEPF0000E632.namprd02.prod.outlook.com
 (2603:10b6:8:56:cafe::ef) by DS7PR05CA0091.outlook.office365.com
 (2603:10b6:8:56::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.10 via Frontend
 Transport; Fri, 3 Mar 2023 15:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E632.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Fri, 3 Mar 2023 15:51:53 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:51:45 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/33] drm/amd/display: Use dc_update_planes_and_stream
Date: Fri, 3 Mar 2023 10:40:18 -0500
Message-ID: <20230303154022.2667-30-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E632:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: c5143c37-91f9-4731-2acd-08db1bff35d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H+BGsqpLI2YMA5JAHh4mkjH57RbH5WJ0QfVlCINLb6BlxXoWKrvy1VRHZrpwgNecodZpctRfXGN0ksxbaM7trJG55jlgD3DfR0V+8415HLCJSAfA6zzab7690Wo3wNQ75H0ioG2zrvIiX5A/GJf4v4IQDSZ4ercYkdYSmE6V/uAt97MCoL8UqS/DUVumpEYIkYjh26uFhdHXaRho7AuDTQ1YlhlDqZpkNhywJ3MuBC++kBPvJ9Bp/ck/8CIXkpAqajfY+LLYVlmME1nsKYgKLggKsJnGF4eMjCBnGZ+aNOoHscuPHgFdNpx/cmSLiTt074f3tXzaopHZv0JupH6IUp0QZ+YF4aWPspKxUT2bOH42CC2UJ8O357AIN4FDcoTasUgINcJuxPc6WQ7KxYzfNKMN/J5Ntk10CfQ/V6CT7SfmG66SRXLklmk71vJp/7GNS+F8lH/o82thAxCamzcrQNqO3f2jlaHvOK69gDSfA6OcpO68fguuY4fGPKe48KXqia2uYz347oXIxizpcK71R7QwcumcV+CraSQXgu92Ipbcf4KJudzSyUaqUBNwonLnhftlATs0QNIUG7751uoc07pFsbR1w1DFP+1UEEqNAlLvX1XeatZUM77yAhCFakvCiUG7kBEbbqMUMqJnpZXmdvqHjMytdBFG2phy7d8maLFX4kpIWeMBUsBm+th++8f5RVFHZkhDABb0RbCeV8wAkwjUDHZOzkcPKqmxN6Hx0Sg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199018)(36840700001)(40470700004)(46966006)(47076005)(83380400001)(36860700001)(426003)(6666004)(40460700003)(36756003)(82310400005)(8936002)(26005)(478600001)(86362001)(82740400003)(81166007)(44832011)(356005)(40480700001)(5660300002)(2616005)(1076003)(336012)(186003)(8676002)(41300700001)(2906002)(70586007)(6916009)(16526019)(70206006)(316002)(54906003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:51:53.6048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5143c37-91f9-4731-2acd-08db1bff35d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E632.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[Why & How]
The old dc_commit_updates_for_stream lacks manipulation for many corner
cases where the DC feature requires special attention; as a result, it
starts to show its limitation (e.g., the SubVP feature is not supported
by it, among other cases). To modernize and unify our internal API, this
commit replaces the old dc_commit_updates_for_stream with
dc_update_planes_and_stream, which has more features.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f692a0d3dc4e..fadbeaaf5499 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2672,10 +2672,12 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 			bundle->surface_updates[m].surface->force_full_update =
 				true;
 		}
-		dc_commit_updates_for_stream(
-			dm->dc, bundle->surface_updates,
+
+		dc_update_planes_and_stream(dm->dc,
+			bundle->surface_updates,
 			dc_state->stream_status->plane_count,
-			dc_state->streams[k], &bundle->stream_update, dc_state);
+			dc_state->streams[k],
+			&bundle->stream_update);
 	}
 
 cleanup:
@@ -8161,12 +8163,11 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				acrtc_state->stream->link->psr_settings.psr_allow_active)
 			amdgpu_dm_psr_disable(acrtc_state->stream);
 
-		dc_commit_updates_for_stream(dm->dc,
-						     bundle->surface_updates,
-						     planes_count,
-						     acrtc_state->stream,
-						     &bundle->stream_update,
-						     dc_state);
+		dc_update_planes_and_stream(dm->dc,
+					    bundle->surface_updates,
+					    planes_count,
+					    acrtc_state->stream,
+					    &bundle->stream_update);
 
 		/**
 		 * Enable or disable the interrupts on the backend.
@@ -8696,12 +8697,11 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 
 		mutex_lock(&dm->dc_lock);
-		dc_commit_updates_for_stream(dm->dc,
-						     dummy_updates,
-						     status->plane_count,
-						     dm_new_crtc_state->stream,
-						     &stream_update,
-						     dc_state);
+		dc_update_planes_and_stream(dm->dc,
+					    dummy_updates,
+					    status->plane_count,
+					    dm_new_crtc_state->stream,
+					    &stream_update);
 		mutex_unlock(&dm->dc_lock);
 	}
 
-- 
2.34.1

