Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA579E936E6
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D9D10E157;
	Wed,  4 Oct 2023 21:22:16 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F16A10E3C2
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:22:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aj6l/rjVqgo/vcT/lP0sCW/4edaYmljk7zdRBfp8c/ngfoHD6iN0Ys7lZlxTTwJQjMFT6YPQUDv8387qFpGDB4HnDe37cnn825qLOa95peBsmVx0E/ctb/RtgqilwdcmrM7/2Lwsu60NUalFV2rjJ1KUK//MhPJnGkPmVkN7j8TEos8tsk6o/22MJjsQYzo8Vgp/sOtfd2hwTGMSeFYVdXj0xEzVfDKYHMpj82esm+s47fN2aSrx7rIQMOjEjRefdyMa3FCdTBOtcThUa/KTvQdJyBjjP4JJBCZarvc0EKV23R+84FVEg12Uyy7ExbC7YHNmDTwve23PUqtFFpRdSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDmY52JmRU58+KpJnqcaww8v0zld4tizEpNVx8LpO/s=;
 b=khoPgCqYt9pSoF9Ac5ZH6qKE3H43LRdOJSijMAyWEbBrEReeeoUfBXFGC7GyvWnqM0xtWt8UAmg0DtvSO9DNFkCwL4giVivUf8O41EPironxMZliPlEsG6CyoT1LWEVAdtAFXdZhc82Kv2r7+GaIIN3JXu+bbVqbbrT7uocjqdbe+LSUJNsVfke2FwPHRwI9QcWyAXHlRksItqmQASrwxTAEFwW9qwWvcQxjfZfzUl11gm7GVUqZRsvnASPMeOIpNkwpKC/dJ4xPO5Dx3/yTV/nLbY81nw610x4iwNNwCiV3ACNFu0M0gBz2WW5GffL7MaK1wvMlJhReuiNqnTWU3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDmY52JmRU58+KpJnqcaww8v0zld4tizEpNVx8LpO/s=;
 b=NUyZDZ5diUVXaCn2ksSnuzPirIde4LkVFEsD6XnpesQe5XgFX2TTQrqL6ixNM/XWlUm9KY+HMFDAtvRMntKj/rXx0JybC5zE673e4eyYdbFjF4hE3hld83rh+ODiGAl/ydXbQsz92AsMF8x5Ite5ceikURlMY5uzZuxYdDUMc3w=
Received: from BL1PR13CA0131.namprd13.prod.outlook.com (2603:10b6:208:2bb::16)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Wed, 4 Oct
 2023 21:22:08 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::30) by BL1PR13CA0131.outlook.office365.com
 (2603:10b6:208:2bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 21:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 21:22:08 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 16:21:54 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 10/16] drm/amd/display: Split pipe for stereo timings
Date: Wed, 4 Oct 2023 15:21:04 -0600
Message-ID: <20231004212110.3753955-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 50fc27d2-3c0b-41af-b312-08dbc51ff6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/7mjNOrS8MmMJKPUaPx7x29+1lb2oF6WVxzbmTxkK6kTvfaUqUVmE8vYZ6fJv9W19oL6XSTz/4DzgOxsRgiT8PP2x0wfE/IyBEtZZ8fLSpM/rH3wHJIB1pBBS8R6+v+1SEa8WhLUt/vD4mFFbYlJD8P49qpKgVuvQlrO9CCgsRfZLq2WBHYgQHaqg6VMX+MBLqlqxOtfcDKXUN8ysnRT51fvZuKk56oOLEMMCGScPZ3BR8aN+/S6r7NGmdnEHjeqf4/is5HyOo8+pBjx0urLwsuOUfKwYCnNfrXz0owfmGSymNhQmycKPUZvIYXjID5i3Dy5sRftH+jGX3GfAU3i8eANds/yGAA4rvJVXFhQdvnI/K+JSvGnGIhDwv112Petl8pefzU3UEWx2xinFEYs45oZcPUVUwqLvffq8lFlZ0adXlK6Yp0Fd6v22Q6VvZyr8BmSO4eAPgXBxS52yqQjUZWMYFEj0VjDFRX/w0ehxY8x7v8sgwiJ/00vWgws3kaIKFDXJm4Opwu5dIWJYiQ2Gkt3sKQ76zv+XFgqllbHY5Ro3YNllrFlr38+P7Q3SD1ZkFeCgMeN9/Rs48XGtt+lnmqQ/IBnVDD3KDgWqegPRXxY94NBHl44MpWDjO90aUeCxY8dyEAWJ98PSJ3Z3iI6ECA8uMd0AemdV4LvQhon37a0HnqhXcC2kVwK+/5BQbzvKhx0cMPwF+fg6zqzd6M1kY1H0LgSQj2Ni2KbfI6AvtmQlM+8tghw67CMmDyufuJ9n/CliLIUyPJ6d7Le29ixw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(82310400011)(64100799003)(1800799009)(451199024)(186009)(46966006)(36840700001)(40470700004)(336012)(6666004)(8676002)(8936002)(4326008)(478600001)(2616005)(41300700001)(40460700003)(6916009)(40480700001)(47076005)(86362001)(356005)(82740400003)(5660300002)(2906002)(36860700001)(1076003)(70586007)(36756003)(426003)(70206006)(316002)(54906003)(26005)(81166007)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:22:08.0281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fc27d2-3c0b-41af-b312-08dbc51ff6f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890
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
Cc: Charlene Liu <charlene.liu@amd.com>, Sunpeng.Li@amd.com,
 richard.gong@amd.com, Qingqing
 Zhuo <Qingqing.Zhuo@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Taimur
 Hassan <syed.hassan@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <syed.hassan@amd.com>

[Why & How]
DML2 did not carry over DML1 logic that splits pipe for stero timings. Pipe
splitting is needed in this case to pass stereo tests.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
---
 .../drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 8da145fd4d7b..116b78a5107c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -708,6 +708,17 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 					// If ODM combine is not inuse, then the number of pipes
 					// per plane is determined by MPC combine factor
 					scratch.mpc_info.mpc_factor = DPPPerSurface[plane_disp_cfg_index];
+
+					//For stereo timings, we need to pipe split
+					if ((state->streams[stream_index]->view_format ==
+							VIEW_3D_FORMAT_SIDE_BY_SIDE ||
+							state->streams[stream_index]->view_format ==
+							VIEW_3D_FORMAT_TOP_AND_BOTTOM) &&
+							(state->streams[stream_index]->timing.timing_3d_format ==
+							TIMING_3D_FORMAT_TOP_AND_BOTTOM ||
+							state->streams[stream_index]->timing.timing_3d_format ==
+							TIMING_3D_FORMAT_SIDE_BY_SIDE))
+						scratch.mpc_info.mpc_factor = 2;
 				} else {
 					// If ODM combine is enabled, then we use at most 1 pipe per
 					// odm slice per plane, i.e. MPC combine is never used
-- 
2.40.1

