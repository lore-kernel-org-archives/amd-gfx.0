Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B72ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D08E610E819;
	Wed, 14 Sep 2022 03:56:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E7FA10E81D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWxWRnOOKLxxEVBq9f2Wp+nkfAb3HIEkMMehwayT0HvHzfO7i8yS4efCQreUbBwk2VNpKpPoadRLoT7fPNWGUc7Kj5j9jZKnf9CmRty1ZCUTxP42OgvHszPfGpeBe0FdYQnhthh7dcTbq3E+936ZV+2buN2we8EBUKkuTvGsMMl4AQYx3EqSsDm3LFeGLC6UiYza1cDnH66rs34ImE7OWB01HTfKOZ0AAR7olB9yHYGHXHzYhh9xYoXIywTzg9sI3ptyaAIF/OkJTepn34sa0cBpnrZaMPnXQkfKYzmmbIisC385hplkDpPeV3jshZM5K+gFweL45DUEI8PHDNuALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/ly2pzz+3oSXxWt1/m38qlwfYOFO8BzwEef17WveDk=;
 b=fnolF52ck3d7k3rtOL4MboLGHId486WrGLmI7LRotsUldz31jGSV4GuQ04pJywZ49WW1LCwJBlV2moEwGMgETp9epzHo3Fq5MLgfhEwGPpopFSics+MVl8h32BvGSmuZxbrh4K514CcJkeHFmWvmqA+cy8s+WvOIpVAfjypFtB/snI6gK09rcb3LqtY7CQ57DxPWAI867aSrKQx/qqtqZJEcG2xlf9yTjr09vnvIGELI9IZDGiP4fEfK1RfKU6Q5fYh6we65enmaBpyYmmna/UWvo3mhR6SRN5V1tty4jvAotMTnr60VCdh2jbKNg6D3FmOXnxyO9HuLrS8qfXJX7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/ly2pzz+3oSXxWt1/m38qlwfYOFO8BzwEef17WveDk=;
 b=paUq0JpNZ5Tsql9abHNvmKDfap2q/qpsxnQoWllkbE1FCg5hVW8WHRBFLgQ06XWg0+Bt7tMRp9V7J7rVqPeiF7OQVt/M6SVHSrxrgLbExNe6GsBjsbWWteYu5RfPyftTYK4Esq3s/11ru9aUMpmXFNIt5C1a9vZdSzODzh0ql5c=
Received: from BN0PR08CA0015.namprd08.prod.outlook.com (2603:10b6:408:142::31)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 03:56:25 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::7e) by BN0PR08CA0015.outlook.office365.com
 (2603:10b6:408:142::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Wed, 14 Sep 2022 03:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:56:25 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:56:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:56:11 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:56:02 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 36/47] drm/amd/display: Enable committing subvp config
Date: Wed, 14 Sep 2022 11:47:57 +0800
Message-ID: <20220914034808.1093521-37-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 26acb367-1bba-4acc-4981-08da96051854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pk5SKe0KcrfGX0bw/qe0MEFu0Ts2S3H5aDiAu0zBSZPkje+Uc+pYuF566z2qU5SCRetC+vd1E9xy9UqlByuiKHvJ70NFkV3LEfkB9CJ9ZPlK5/JjvETM+5didWIqvHv6Y1ZeUYvImeJ02uZe3Y9hgMUFWCvzFHeYMGIX61ngPOhtTW4vxTV0EWaoVaWWAA1A32YDVkVw54Y0PLO9PYNnZbrkOnXZ/vcIWul/ZfLxb84+xyrUxIWX6YD0VmSYSgizZfN5uo++SF+JeIWki9SqN4G3xAHcBWy6VI+09LFwG448PDgGc7EvVYOsa8BbqAPkSiiMrhxolM4BFslUgJy4W9F1YawdUoeQY2+/MZY2RIp23TG2ffMlElF1pUcnR9t8HUT6OyVrIftoh/2nk1IcCUAZcOVtVpBq3tQcp99JCydRcLVTOoGhukaCRW9qL/6rXeR9BBIUyO0HJ2m34rkV3puJ+m7ivY5g7fPP8XjeeVpZI2R89a0SbQY9/hX3Rbi8nuYKJEszs64/VXTIW4RQl03qBlHfgAgXmmrIvQAF/rBXRwfP5K0hkgH5hX43zuyRFWpGfU+tjrndEWed4YDsp3qCkwAZ/Y81H/CrjQLaWGL1OXy+kYoK+J4xIWT4zvCjEo/Gx3BCjTGMyP3yZx+HCR3lFJ/kBt9s6O0T6IHHr61crMJkqyfimDFQi8umcB/+Bes+IlJ1w30LVSdvzPkJomLoW2YGBgrNIHml2qOIclWoZzdV8UbwhDmg0Fe/taGbaLKW73CDkAGjM8BXde8iAhJAe1tX0751tHXg6JZ+InemtQ1jI6wQw6GOLiSzNIKp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(82740400003)(5660300002)(8676002)(36860700001)(40460700003)(86362001)(336012)(186003)(26005)(70206006)(70586007)(7696005)(6666004)(426003)(81166007)(478600001)(47076005)(2616005)(83380400001)(36756003)(1076003)(54906003)(356005)(6916009)(41300700001)(316002)(2906002)(8936002)(40480700001)(4326008)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:56:25.2432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26acb367-1bba-4acc-4981-08da96051854
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why and How]
Enable committing subvp config through DMCUB for DCN32

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index b8326d41810e..7544ac8e33ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -453,7 +453,6 @@ bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
  */
 void dcn32_commit_subvp_config(struct dc *dc, struct dc_state *context)
 {
-/*
 	int i;
 	bool enable_subvp = false;
 
@@ -471,7 +470,6 @@ void dcn32_commit_subvp_config(struct dc *dc, struct dc_state *context)
 		}
 	}
 	dc_dmub_setup_subvp_dmub_command(dc, context, enable_subvp);
-*/
 }
 
 /* Sub-Viewport DMUB lock needs to be acquired by driver whenever SubVP is active and:
-- 
2.37.3

