Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FBAC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF0810E4EE;
	Thu, 20 Oct 2022 15:48:36 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C6A410E4C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqxAi2en3DlyvEyaSejx1FLQnvPK/fDrI8E43lR/oKreco+CdhYvGKBiAaKf8aTIB782gUl3+IuPN3nACVq4wsIvrBIEdZIOdWQ4qbW93WUMU/G1vNGyXV4GlJ9EzyS7bGRK1r/2Xi1Matoq36XY4j2thTbRGvcXVdwGMcZNTUUH0eLKR5ryAh/LEENgw0TVLJkEtQ/4X/EJKkc/JGJCXfooyWySfUd+hGGfMzSujk/JiFw2bpL/jTo8a0mttBgcR540hM+z/3FIhX0tUbd7nvBWuupm7aI6zN17l+le87KQ3dsNv+mDbm6zGxG8x+RDxmFwuvPezijIE29egkHGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P008avAtcOrkp6LeN8QvaMAhNqaQzW+6eg2WUg5NBQ0=;
 b=VbiH8yjdB46fvRsESyOOL40zIB9rkccVKaHUOqmpKJYbMM3K08ZH58uywzEclEIVdSAVi5aQuVbfGtGYmD5YmNvsbBjffy5KU8XIxsZ43UlETdVsDz7mVAfy3AVkthvLcwq7gaAzEISgh8UvRpVVxscXS8arXR77XRtHt9tYFQYSQKX3UURJBcplWSqem3yH1Q3VwtP7l9VgO2iHKJOYoxXI2FALdX22pwgoHchNQ665bdJNDuYxsUAPv+VgDXiw/MW5OvtS23X5AW0efIO1e/P7aWH3u16Wku1hPImq49G3tTE2PCues6ymxEof50dST963B8ilwO4tRK1Pt3j77w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P008avAtcOrkp6LeN8QvaMAhNqaQzW+6eg2WUg5NBQ0=;
 b=MOE0EwzrHKLHFUYOt5JSVWrf4GXvphQ2h/g0+PSwJvpgd1GDyjwYYZSfNvNSUJ6+pQXloNtd5lmRloOQngaZKivXQtzzcumtwklNLx6VOofOrhI6C6/Voi+aW7mayNaE2Vtj7ugo4WQUDpREGMILq2u+4wNQYCE4ZKQHpdrWZ2I=
Received: from DS7PR06CA0034.namprd06.prod.outlook.com (2603:10b6:8:54::18) by
 SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 15:48:10 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::d2) by DS7PR06CA0034.outlook.office365.com
 (2603:10b6:8:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Thu, 20 Oct 2022 15:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:48:10 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:48:05 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/33] drm/amd/display: Enable timing sync on DCN32
Date: Thu, 20 Oct 2022 11:46:51 -0400
Message-ID: <20221020154702.503934-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: d5aafa3b-6b60-4dae-cca6-08dab2b27d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wahtzc8mBinQdwUBbEhlIO3D0VdMrm8zrMFa3ZIP+wFv+YBJfauU1d1ldbJO5unwn4rHWR3G/6/oFKyI30J17fgC3RceeLSPNf426vwO6uYPDMOUMJDFPi1eYVe30YvlE6OX3sbgltQcuQ2mbhplYV3pDFB7F3gGkFv1jA+Kpfp0PA6WGME1epAo4yg4FQjqNYABcImsGxuj3Y0y8wf8/8W0AK9pbqYdFNCuZSCkymsoUe2m+mM+PXWb8rLWc/YPqr191XgkGYDVK/7p9b4Ty9h5Zto8Y/epfwd3JtTnwzdHgyU07lT77BLGoIYpPAg5s7F/v6zHEuDM6rl+5pr4aLnB7n+WjX8ODmfvWMStry5gr0BnY2hUBIchUYd1GjvuquF/bpIW+kqGR4XMSTe6pWN5TVd4MXrHG37aicrqYzD7r3cyANCezMl5lg+ofT1Ol6J4I5ynTGrf+pdFC1QaQ029ktLCUfNY79Pb0UZVFS1MNUkkuQVbjLUYMo+oKasb4IhE0pvqhiM1LZ9CWHD4e7fk+Q4+EZPtm1exckCPntGk9ii8lkURts+/oqldn6j4Mgpunq3VZxX2o2eb+dhtUvqpMEDbWdXyLytijwtXvRdbVYurw7vDM5fS38APk45/hXnPQAXtC9uJEpPW58/JgRwbI/TLay4XzHkBw2HEvZYKrEDFdE/oybILUJHCMXEzoSOhjTE7ksefRH9vLWRdcRoipvVs2etBpWv+ec+XB4ngp9LkYn3/hd0iFKUIjSVbMV0wFSBCmaZJf5/FKWbnlk0kmHMpgrGtytaWXGpioO62XOBAmgxE8vRRGID+StsI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(2616005)(7696005)(26005)(6666004)(336012)(426003)(40480700001)(5660300002)(2906002)(82740400003)(54906003)(316002)(86362001)(41300700001)(36756003)(16526019)(8676002)(4326008)(40460700003)(8936002)(36860700001)(186003)(70586007)(1076003)(70206006)(6916009)(47076005)(356005)(82310400005)(478600001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:48:10.0322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5aafa3b-6b60-4dae-cca6-08dab2b27d35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774
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
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

Missed enabling timing sync on DCN32 because DCN32 has a different DML
param.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index ec2eae99b892..602e885ed52c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1228,6 +1228,7 @@ int dcn20_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].pipe.src.dcc = false;
 		pipes[pipe_cnt].pipe.src.dcc_rate = 1;
 		pipes[pipe_cnt].pipe.dest.synchronized_vblank_all_planes = synchronized_vblank;
+		pipes[pipe_cnt].pipe.dest.synchronize_timings = synchronized_vblank;
 		pipes[pipe_cnt].pipe.dest.hblank_start = timing->h_total - timing->h_front_porch;
 		pipes[pipe_cnt].pipe.dest.hblank_end = pipes[pipe_cnt].pipe.dest.hblank_start
 				- timing->h_addressable
-- 
2.35.1

