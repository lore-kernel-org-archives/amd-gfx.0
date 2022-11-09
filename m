Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5324C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B4C310E587;
	Wed,  9 Nov 2022 06:17:46 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A77610E582
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:17:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CM8gZ0a3pxKih5g25Nm4F3jmssWOPdE6zaswB8B1Fl/aWiZcOrnEhGduR/20GQzRpM7h4YNd9o/rNJgAZ4W9PsNEJpCyMkig+zQqOLxndAFMepX09Iue043RoJHU/DJJgEj3W1GpF2+GZqT/gbFx7Th1gzdse23icai6vQzzKA6TBr7+OhBtkqDXlmULh2y8BT1hacXWIGV6sWswGw4BTAxRbY5jPs0D8YfJqHfJybNDytPseELhyXbRsJRpkmD+KQlqJgHhYnEQ68oED6M7JGgr5N14ORyOBdr8nrbXaojnZE7s3bAB8T+4FwBWX+bnEsTohoE0evir0ceeFOVuxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8ir9j7nTNxukIVKSfSlg6k5132wNrHM2QePujsRnRc=;
 b=mraHoPHqUjrznsSps11z5EYu+pLYChi2Q70+l+lb7dozIWbkImlPyBAV7CCyhqaCmgElLHcasDuJnmuojzDApxTbOsTmaC80dds6uhzV4dhdBB6CR3rrFcK5IM8RTTiL2WL4leo8Hqqns3537z+94qlar/VG+0xzVMNgkDm2Alf7JB+kFSrwp0OtJebvHQ+XwVCu7+u3mMcflW2VPP/6AY4YOFsrqUzUe7B6QBUXCvO0qO95i3AAS9xZw3h7IMeF3GKxnwrjkF787uEFoujbosjT7u5jqn8dlXzmY50OSIS6o/QNhs3YVOf8tUeQv76szQFveUlOTTEHag6Ve45z6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8ir9j7nTNxukIVKSfSlg6k5132wNrHM2QePujsRnRc=;
 b=dKJQzcnIleo3yGA2a+fvnL0YPQYF57LhkDDE1sDOz4V0jW8B2VxrOlR8eAOpyciQsYATIKd5HO2w4haeEWOwleN6IyJSyu9aUUOh13TFSWVEOs4kK4joqYaJSiwTbFq2KMS+I/gvc7JtJUK11QPC7rz/rJJv/SuBizwg4UJj1Jg=
Received: from MW4PR04CA0239.namprd04.prod.outlook.com (2603:10b6:303:87::34)
 by DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:389::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:17:36 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::86) by MW4PR04CA0239.outlook.office365.com
 (2603:10b6:303:87::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Wed, 9 Nov 2022 06:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:17:35 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:17:30 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:17:08 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:17:03 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/29] drm/amd/display: Fix optc2_configure warning on dcn314
Date: Wed, 9 Nov 2022 14:13:11 +0800
Message-ID: <20221109061319.2870943-22-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|DM4PR12MB5343:EE_
X-MS-Office365-Filtering-Correlation-Id: 280722c4-ba5a-4253-c487-08dac21a1872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtPJKnedCRj22WUA8Gg9B4Z4tTzNXe0c5H2MlaQobceoVcH6cbxJZn6ZdqiiHmHtrfM3Gsb66hkUR2c5YGQ/EN6IlGmo+Cj6TfsLxy3pw80WpMMAQNk+wNb0OU33Vb6TW4KDWvQFMpZ3Yf85IExlIRunpOwy79f9eOLRQp0e9xzN35OfFZIoDHnyr5qAxp1yq99pH5o0VeeXiuJqwuV0A+tlmYUP6lwFAnugO/L6Pxz3qB0g+r6RDZFo0cXt7d4/cSvruDGMvmGADsHYVbBaGNcdyCuj6IW55n5/YfOloi70s6D0u7WYefngvtwH9sXmQKaTIkNYG6EQ39V6BehiyuFn6qcduRmTZuZUme/HTspIIv0kj7eDdPFUof9Vmo3HfX2Xbs9dAxC0HCgVjLTzg6+VDK4YrEMjTFDNrrwCi4GSmI0gE6HPAIycqGw9fzFg1kS75vFBNrcPa9ESaVUJAnHGlLvn2lsr/tt9II1EErADiJz+liSNlch3v0FQUrSeJ8o/5HFKn2K/iiF4b8L/5Jr93Wv+GEQwvejn5kJVpSo99jsFW1IOSncersumlafpEwewmHpGRGtyFNaTCNxx3RuRDbD3UGjbnvvqy/IjQyaESPDsmLMBoeAk8eDK+Ijo17RwVqPrZthFemuRmLukJXEh+uQNnC/3VHfPEi8XLrLQYBvWd50X/fRpevvgK4Xf6ozPqRtaufzq4EC6g9LewVdStpyE89keuznIJ4ue6MskZef6+8BoYnXk63sYut0g1Ax1D2Bs0KMl6UurKksgVzLzqFhReEEqG1+M4TZlcqI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(2616005)(426003)(26005)(7696005)(1076003)(336012)(186003)(47076005)(6666004)(83380400001)(54906003)(36860700001)(2906002)(40480700001)(40460700003)(82310400005)(478600001)(41300700001)(5660300002)(8676002)(8936002)(4326008)(70586007)(70206006)(316002)(6916009)(36756003)(86362001)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:17:35.9896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 280722c4-ba5a-4253-c487-08dac21a1872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
dcn314 uses optc2_configure_crc() that wraps
optc1_configure_crc() + set additional registers
not applicable to dcn314.
It's not critical but when used leads to warning like:
WARNING: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c
Call Trace:
<TASK>
generic_reg_set_ex+0x6d/0xe0 [amdgpu]
optc2_configure_crc+0x60/0x80 [amdgpu]
dc_stream_configure_crc+0x129/0x150 [amdgpu]
amdgpu_dm_crtc_configure_crc_source+0x5d/0xe0 [amdgpu]

[How]
Use optc1_configure_crc() directly

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
index 47eb162f1a75..7dd36e402bac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
@@ -237,7 +237,7 @@ static struct timing_generator_funcs dcn314_tg_funcs = {
 		.clear_optc_underflow = optc1_clear_optc_underflow,
 		.setup_global_swap_lock = NULL,
 		.get_crc = optc1_get_crc,
-		.configure_crc = optc2_configure_crc,
+		.configure_crc = optc1_configure_crc,
 		.set_dsc_config = optc3_set_dsc_config,
 		.get_dsc_status = optc2_get_dsc_status,
 		.set_dwb_source = NULL,
-- 
2.25.1

