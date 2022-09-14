Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11785ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E2DC10E80B;
	Wed, 14 Sep 2022 03:52:38 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 251B810E80C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:52:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4lm9Kde6c3X1Z3mgu7kIwEUVia9gwg1qvMtvgxL+Owb+LpaXS16eGiNp9iZm6HRX+mXOAsRmxnVE0vSKIaZ3rIYCJERUCI7HgNaidTSWKEjqgwI2U0Pi+tDpN7l867hye0qd9N52d9fGAD7fQ0mkeq997nsuoici9Nd6h6rI+AJVqTTrhSl5Nky25PKiPKrHZ0XAJfikr8Wk9aHRoMnNvlrxj81j63H3lTOc+XnDb/OcLytG2VFVyJz70/CiqlUkTb0Lmh1oBJ+JvbcVbdcKsmIuVJTzovE5FxUZCy4BT0LcbytmLFbHV4hNEduzSIblB5gmgPAZ7fLgyA/PHervQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPBBu7yceNxS/6oq8QiXYEGvTmTzFcYvX3DzZEUbDnw=;
 b=mnUJOtlMBbk9Z9TBCKWD3DCJzAIKNVESJn3+OU1b5GhUsw3LQhsnfOk2CWEExznQ6tQFWqs8cGNdMP7EhNvyR8XbMLlV4wfgbXi1nGn+Ur+iv1WY8HpkaAlWIv3LGqUZ1QeM28vAugJeoON0c0Veft+Egl3WUh6ia8Vm3Z/90sucgWrQVSzELL+Hwwj/JZJSZx7srrE3CxpV/mRoZ3Ld0VPeQWDaBCoD8wJWMKMYCTXP3e1XPyYyDy4gpPSdqosk/fmsK3RsXEo5wtf8qwCMLK9TwaOK8bHK0tSW0o62e+HWurMfl1UXT79d6eI4VlS5zxyFWxDRn1uDL11/v2pH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPBBu7yceNxS/6oq8QiXYEGvTmTzFcYvX3DzZEUbDnw=;
 b=PZl86fv3UhJtKsmmNXeB3VIrMCbyjXSbMgWqLf2pKHgkEdjyfA4ZUKL3sXJTbHoempIuGwwQvJ+OviQuD2d7HkN3406K9X6vw7MYSIpFGfJb6QSDtcGRKBX+o4eLGZxbRnbSCKgGIxp2U1CLvTv13+5SKKR3uoRi+tQ8W/xznF8=
Received: from MW4PR03CA0055.namprd03.prod.outlook.com (2603:10b6:303:8e::30)
 by DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 03:52:31 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::90) by MW4PR03CA0055.outlook.office365.com
 (2603:10b6:303:8e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 03:52:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:52:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:52:30 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:52:25 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 20/47] drm/amd/display: update gamut remap if plane has
 changed
Date: Wed, 14 Sep 2022 11:47:41 +0800
Message-ID: <20220914034808.1093521-21-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|DM4PR12MB5088:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f26f79-fc2a-406e-3313-08da96048ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uo8IMD1XKzgt2P3RZGNrTx24Dg/nw4xj3KLDmneMCruc8/Q0i8dz7QiF6nPHkH4kUY+qwtNKuU/JmkDyiGs/arIv1OmxYbyG24bb0qhYglx734iQhoD05gGZn9SekCse/fm7uSZFNQEE9jsMxuCbHFijwe5BxkOP5+ESr3ywNz+ZjiioNQZWqd0aRzu/bEeBObGkRKmnfK5Wtp5qlDUBlHfsW7H7h3rfW+0By7Z2Nj6DxIbVzqQ49waUW/w2Uz4C+Ifsix4jazfSsDeE/XtW6tb0SWjcmUCo881vlfTbw41a6XSomT+Me7tGlZfGHBcEmhpT7NiP7BaVPxXsu164M5jBkivqUMHpg9jEEPvS30ckYCCCUiQ01QERTH6TEwi7Zyz5ojS/p0GdW8OLXkgcLhW+3mgaOlbfvsQcS0yya8JGDOOUQJ3GNEiaDr+j/tBU7LtcDgaEjW//23kLEKrdbF1ew8m4x+8IrxyFX0a5qfDup09YMpXhzGtHFQNF03CJ9gWLl9FntEtEUDYo6rlWN9Yg5tD+1gOPM3ksTCXrcPI94Sx1Ir0TNYV7JDVyqpSaSq5eGerSaUlsMD98tNL3OLA8s9NtR5cAoRUQ4R1lfQ2/RML/QZ3moZNCpGO+GHjCBE7JOTDepkC5CNYqWGyEXvoBKdRGAXmdMUUZ7cL47u6c4ufUMc4bgV7d2SxlOj6w1vW8dLW8hUukuQpGzJt8fgg/B2virw6/WeUxBFAi3A0Oy8RLCeTy+7miA/89BKxZwk+hoQL7BGyXmrXaCZdW6yzkblHuw4vf6KGIt1WWUqVRM/bXGLBVBlFYT79iFG3N
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(426003)(41300700001)(478600001)(2616005)(36756003)(47076005)(82740400003)(1076003)(6916009)(15650500001)(81166007)(336012)(70206006)(26005)(54906003)(316002)(83380400001)(70586007)(82310400005)(40460700003)(186003)(356005)(6666004)(8676002)(4326008)(7696005)(2906002)(5660300002)(36860700001)(8936002)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:52:31.0856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f26f79-fc2a-406e-3313-08da96048ccc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Hugo Hu <hugo.hu@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hugo Hu <hugo.hu@amd.com>

[Why]
The desktop plane and full-screen game plane may have different
gamut remap coefficients, if switching between desktop and
full-screen game without updating the gamut remap will cause
incorrect color.

[How]
Update gamut remap if planes change.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Hugo Hu <hugo.hu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index ab56f14d6247..e1d271fe9e64 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1573,6 +1573,7 @@ static void dcn20_update_dchubp_dpp(
 	/* Any updates are handled in dc interface, just need
 	 * to apply existing for plane enable / opp change */
 	if (pipe_ctx->update_flags.bits.enable || pipe_ctx->update_flags.bits.opp_changed
+			|| pipe_ctx->update_flags.bits.plane_changed
 			|| pipe_ctx->stream->update_flags.bits.gamut_remap
 			|| pipe_ctx->stream->update_flags.bits.out_csc) {
 		/* dpp/cm gamut remap*/
-- 
2.37.3

