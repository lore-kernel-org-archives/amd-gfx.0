Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FE2ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A999810EB95;
	Sat, 27 Aug 2022 02:53:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9CCE10EB95
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7yjNMSMSesRQvc9XhKPyGVlhnsr1YvUotafMeloRPHjTrOcCK0AsG1qqA5HTa7UMYwUbc+K9wbRHBy8ebHh64bXlgqQQrn4Wcm16MdXk/ZwzcC28YyQckJ+Vy6J+YbEh2+brNKpDctSZMXsdNRd7VlaOGBN+8+DQVGwR2jybQaGrE11h6CCrr3kEFxt7iAoHq4JfzT9favjCe37n5V2f8F5tCCAysZQMbWX4h11R+bjhnKXHODUUZ9vACskA5gWa4ag3I0RwJEzEFyXqwmzeGFYSfo17BgMMs/kYhq1QissR3jUCEj6AUESNMKyqHj0s4gQJjata0E2okHgUit8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkPt9InNrfrPyLisRJL65OKZNHQettwVSxfx5Cqd96M=;
 b=UOwhuizFSMwLN2JuUCLr/Dg4TGH5mQYBifkug6gYQihVi0dHHTcmavghtrxxMbaWFwZZM0afoRx503Xuwm1B0022SREqZcpB1muS+aeV9JK2UtickAhV6BHQWa5IXKYN6z7smmzUbmq5VRSeqNJk1ZJiGoaNP1pJzxsVzA8pmRE1EfJ3R/4qa/xRrQluFyeS7hVixM8DHpPHp4d40asZxqujGbPz1xBtSjQ/PkfEbANnw+oumDsN24jgtTVHPzaLKNBChoVucVC3I2tTmx9d1elfkBCIU8Ir5dxiL2E0hlSJJ1RJbgBuE+oE5NPFnxn2oB8Dji4sDWkjaGI+otkI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkPt9InNrfrPyLisRJL65OKZNHQettwVSxfx5Cqd96M=;
 b=oukSBCTCBcdtVf2TC/ejkHLaH1aRg9U+SwMHDv3K5LwlWa77oqAmn7OZQvEtvP9/GrQClIWaNHvWOQTIgdwVes9NkDBZLmi9ZEnUfyOUGH7buQgJySeU2foeJ858PwzwZe+6p3XJBLfddNqm1PXrmdW3FQzJ8VhoyBdAaFty/0o=
Received: from DM6PR18CA0027.namprd18.prod.outlook.com (2603:10b6:5:15b::40)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:53:04 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::8b) by DM6PR18CA0027.outlook.office365.com
 (2603:10b6:5:15b::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.18 via Frontend
 Transport; Sat, 27 Aug 2022 02:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:53:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:53:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:53:02 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:52:59
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/33] drm/amd/display: Fix black flash when switching from
 ODM2to1 to ODMBypass
Date: Sat, 27 Aug 2022 06:50:52 +0800
Message-ID: <20220826225053.1435588-33-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c042971-a43b-4545-6b94-08da87d74348
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74VIRXUNZOwl/Q83GgyH/xXeO6et4/WfBb0a/1jw0mne4Dy7IYf3NZueT+JJw5Y92mzpFOx5Yg/swy3qhqrHu0B01iHSK44VsGVM9GiTe09nRBY5XMB8etDFF8tAh4Gyyfutc19FA4LysGaZQG6LeNGTdaQRHeM0+uO3V2oaZAlxJOsooYYazPdj/l4Pyjn+M+PZ6g4/sQFSX0RXKF2ybUPaKJt7/HnDlypwcsZh57r2hEsSUIoMxQJmCbXq/no6xqxB6gN3O2qvOrw4NGyHNJuZBRHGeW1QgwnwvPyiZ55lWqhHhqXgeJ9300gixuH/p9phFHH2uSUUyO4l+qxDskcyYad1tiXeIqlW+c0qyE+mgMv5mLlHl11DokgwK0ajmhEF8auyq2I785T2RB6QN4KDCUHEmOjeyXB1knD1rHngMV/No3zwEulNFW+OsgFHdbtQuQiew9+fXVRdVTBjaOQRk6sgYrY1lwJknnQVeCg+vmBiFMECbDz/daXzvZ1+0ycD3uCng6GOD768FTYXZczt66sd8X8HDaACKeHDomXphFD5BYrqXcYTFTCs/V+SqN+8SoB6nHrhmIEQc7wYtXluqeODE6Ui0Tonby3FHKVZFfDGm3CD3Bwvv38r4LBvgSLe+dazQN5bt0tj+XaTSbWj5Xr4uvDHHWx2+gWr2yf+HY+MUWwkHZeN5SBdjnFk+z5ANFwrzXQXfmRiNR6d4kyWgsqZ7gMLv/VmtQsTY4u97xPNzpcvjsCskpI+Yh7lFQxvEUt0gqkQ1SgkZHxG6pSFiKvwdhrJTk3gDeBhp7W2rIvrc4Ur10PUZbnyY38s
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(40470700004)(36840700001)(46966006)(82740400003)(82310400005)(2616005)(1076003)(26005)(2906002)(356005)(81166007)(54906003)(6916009)(316002)(36756003)(41300700001)(478600001)(8936002)(70586007)(40460700003)(6666004)(5660300002)(36860700001)(8676002)(4326008)(7696005)(70206006)(83380400001)(336012)(47076005)(426003)(186003)(86362001)(40480700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:53:04.1947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c042971-a43b-4545-6b94-08da87d74348
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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
Cc: stylon.wang@amd.com, Brian
 Chang <Brian.Chang@amd.com>, Vladimir Stempen <vladimir.stempen@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Ariel Bernstein <Eric.Bernstein@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vladimir Stempen <vladimir.stempen@amd.com>

[Why]
On secondary display hotplug we switch primary
stream from ODM2to1 to ODMBypass mode. Current
logic will trigger disabling front end for this
stream.

[How]
We need to check if prev_odm_pipe is equal to NULL
in order to disable dangling planes in this scenario.

Reviewed-by: Ariel Bernstein <Eric.Bernstein@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Vladimir Stempen <vladimir.stempen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1ca76708705b..6a28f3e0ceb4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1097,7 +1097,8 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 				dc->current_state->stream_count != context->stream_count)
 			should_disable = true;
 
-		if (old_stream && !dc->current_state->res_ctx.pipe_ctx[i].top_pipe) {
+		if (old_stream && !dc->current_state->res_ctx.pipe_ctx[i].top_pipe &&
+				!dc->current_state->res_ctx.pipe_ctx[i].prev_odm_pipe) {
 			struct pipe_ctx *old_pipe, *new_pipe;
 
 			old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-- 
2.25.1

