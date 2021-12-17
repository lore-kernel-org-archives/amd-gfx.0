Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50065C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DCBD10E68D;
	Fri, 17 Dec 2021 21:24:40 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2075.outbound.protection.outlook.com [40.107.95.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 441BA10E651
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq8iKmR6QUcUtfKOP0994oUe+mbfwXqlucJGt16zfWHiBHjQzUgRDKdWbMwmoKoyxyJFdAB9EobvhcI8v294Scdrsls0vuw2Xo+xidjlFGk0EOkdoMtovAmHGyUyaXXPc/L9bsevo2htwfEHCMrrha6RLzopl/xQjO+Jvr1o/ZuYCeXwo7cf1yy6+ajlovorZXsD2GdMX6i8vhKvLNTYeS6hPpAV2El5aEAvehYd5230uA1BZMgpg3z5JaqLihbWKeC2bTobNKHkoAV7kB9NaxSIEj3bmC3P6hXGn0s1IbOoGFLWhP4170mQqzPwHD5N1UCjV2aOWe2PvyZDuZKGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muj6cX8itYMyn++UfaQNXE70mdBFBzoCTYB9Qd66rO4=;
 b=f+uien8JqyMjczbEClfmYzMiRiRXa55IAJy94K9aYVbRrpws9EMQRHSgGvfia5Vsqz6uvXFAOAXOJcpMe/KHXnReVr9qVsv8cbMIff/vEUXRdO4G89UG3sa6WWggheJG5fktRFaZYSqCwPjGLjP5xdNSZNI5sOGiWKBnY6ZkYSQW35dAT/bGsONU5nDeNeSYELbRw85PRBboaVqSEIIWw9IqpSxdiSdVGD68amvURQN6m54e5Ht45Af40CZelcttxvKHAKvk7IeLBmBJhAcomWB18ZMmLw2E+J+GRurc7xjqxfT+sL7MwI2/oQNnV58PcPQqNTZN2snmJjA6FkaYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muj6cX8itYMyn++UfaQNXE70mdBFBzoCTYB9Qd66rO4=;
 b=t8RvrP8a0/p1m6Lm7EZ12nUiNA8gfFs/PCA9RpXm9U7LcB6EvLhlAt36d1IkiPK0N+K1t6kkfuDrVeWcQ3rqLgnldUzZEHijoDgyJbDpvedP6MK16QPA6eYAzTgtBR6TUOeOXeNtCNEHbFFjSi+zGZv1El+97nZBGaaYXtvgVSc=
Received: from MWHPR1601CA0001.namprd16.prod.outlook.com
 (2603:10b6:300:da::11) by DM4PR12MB5327.namprd12.prod.outlook.com
 (2603:10b6:5:39e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 21:24:34 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::9a) by MWHPR1601CA0001.outlook.office365.com
 (2603:10b6:300:da::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:34 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:32 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/19] drm/amd/display: Set optimize_pwr_state for DCN31
Date: Fri, 17 Dec 2021 16:23:57 -0500
Message-ID: <20211217212407.3583190-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce5dd44b-5040-48ce-8485-08d9c1a39f23
X-MS-TrafficTypeDiagnostic: DM4PR12MB5327:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5327B157470639BE1B5DE72798789@DM4PR12MB5327.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOz+fc0Y1iOX+wPmtApZ6cKatHUrKsxk2deDzMoLBEI5GsbjYuDRLZlYWkgLciq5ZPgv4U9sn2bSx7NyX+RERRsoV/BnFaq1D++9GOIGx7vpV/dP3r/dRX+Z7yKOja9CO3i1HvW97idIaG4orMJT1oTl8WN1E7Z4MGIomaOnA/hydDsrySPwY6S39uZLnUlVFVCZRYL7OhhGMU7HTXKp+keLk+tt8etf7Fv1RXzISxCiyuWyKYizfelzxngUB8wOih0IphHLN6Coh5jvFvn9ykbwq8MR10syFfhSoAWGlqhAChXrIq8MwcEZdAhO/qY6AbtDgpjbtNgtChYU3QaYCEUo/smZz+/RkB5OQ9YGW6W7ryAEyVxwkbeMxhg9nDtE/J4XVDmQT2jx0mqWN8c5L+eB9WyEGXUAB85hkLH4V1fWI9UBE4zfoXDwfCBUk1EsrTecur8fbynW9c/MWdTNopVBxBX8A8V0p5oHz53qhEyccnpRp3hZEz64evRVzLIFr9Ht/ayuxYlwairYV1H5vuN8eJtqjC8E1zY/lhIw2HF5LDZ//VV1aXEyj1KLHIjCuDCypOT2p3JP30iDn8sQ53GFJWr8GoNN/mLHyLPCLkqOc0vG6k+3Mp+ltbgGwWtDvjQJ+so2BG9W2bpWWnQ+i1KE304adTHi12hah4IcTVTrXaSeX6X1DpaPCt3ECkq23tLfk7+LjCyNdI4BceWIfRfnJd/pBX4915bny4m2yx+5G+dkO63fMfuijKnA+JfSD2xZSixgAV6H5gmPegDOmAaN6cs9fhmiQ3uwiQCNh9M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(36860700001)(4326008)(70586007)(2616005)(82310400004)(2906002)(426003)(316002)(54906003)(8936002)(40460700001)(47076005)(83380400001)(1076003)(6916009)(86362001)(186003)(26005)(336012)(16526019)(36756003)(508600001)(81166007)(8676002)(356005)(70206006)(6666004)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:34.1808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5dd44b-5040-48ce-8485-08d9c1a39f23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5327
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
Cc: stylon.wang@amd.com, Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We'll exit optimized power state to do link detection but we won't enter
back into the optimized power state.

This could potentially block s2idle entry depending on the sequencing,
but it also means we're losing some power during the transition period.

[How]
Hook up the handler like DCN21. It was also missed like the
exit_optimized_pwr_state callback.

Fixes: 64b1d0e8d500 ("drm/amd/display: Add DCN3.1 HWSEQ")

Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index 7a7a8c5edabd..d7559e5a99ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -103,6 +103,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.z10_restore = dcn31_z10_restore,
 	.z10_save_init = dcn31_z10_save_init,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
+	.optimize_pwr_state = dcn21_optimize_pwr_state,
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
-- 
2.25.1

