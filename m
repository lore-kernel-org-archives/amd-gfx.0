Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFD9C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 14:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1322A8F60F;
	Mon, 22 Aug 2022 14:02:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD3908EBFB
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 14:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDf2OWqxKOZ3hshivZ8TfY/NDrOXvoEqo88IQI8fvOwx8R482v4LMKBFLoqUAewLLdO0KRfJhNmvoI9mD0ONDgcOEPO6SUrBPeuMNbemuZVgK2llbrWDIzzAzQrEaCpClQBbiP5EF0JaAu5f4WGpn0Adq+xMxF0e4+OOfiTRAViEq5dK2WMofm8r4Lv49tO+ozXCdz+a/mN3TB+/vW0Za4xVZEgX/4iCcsachGVKFIW8yX1ioDdDHtkm/EqWXfxkmgoHl7tT5kYH0GWnN6aUnmGCwR2naGlqDPsyMAP2t7GnYpgo6llbgP32ABU9FA35965C2OYaMHAO/Dv8OIrIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HJ/J1qusxn0UtBCj4MuO5jdF1lkSQ78XnTuVbZbijM=;
 b=SOPBEcuBCLcZOjfYnUxtyRKT8WiD6fAEAYsw3mIVVd3oO+qgEm2uJ2sosc2oNp3fHyLADom773FzbEN9fsXMMwGKRjN0ZC+EjlBRqZzlSVRHylUaM4mweob1OBOEjPi14KEkTI6T4y1INJxf9TI3+kJQfnf5XUZG5GgD5rz9IiSgIXBEl6uqwOfP+k13osbdkpC78cHnIWrjBe0Utc3IjnCw1X2uGYgXHQnThx9c2fWoEZXrk8DNHlqRgnlUV3YT1SN2jVC1oTXcCc0BtARkAXefwPq+mMNz9J+M4eoT/VHd3BWcinLDYHIyEZRT68Tbimwaqz15BXhqhKjeYPwX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HJ/J1qusxn0UtBCj4MuO5jdF1lkSQ78XnTuVbZbijM=;
 b=qRABbdPMSJVbYI3qBc/hsfbhi7+BBdXT/A6itVG4fR77AVAcgQj3D4D/R3ALAxeidsgT0yBaEziZQe0GqUs6rJv5OiMk3Y+tsZgAN5QC+3Tl/5QIZ1RSTBsUyB++BFxjVrENGqWBMwm/k5LDOYVNOkup9lQfuKtoj9lBcd81D9s=
Received: from DS7PR03CA0090.namprd03.prod.outlook.com (2603:10b6:5:3bb::35)
 by DM5PR1201MB0122.namprd12.prod.outlook.com (2603:10b6:4:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 14:01:37 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::af) by DS7PR03CA0090.outlook.office365.com
 (2603:10b6:5:3bb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20 via Frontend
 Transport; Mon, 22 Aug 2022 14:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 14:01:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 09:01:11 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Mon, 22 Aug 2022 09:01:07
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amd/display: Uncomment SubVP scaling case
Date: Mon, 22 Aug 2022 17:57:50 +0800
Message-ID: <20220822095752.3750614-13-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822095752.3750614-1-Brian.Chang@amd.com>
References: <20220822095752.3750614-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4e0424c-a1ae-4bc8-c05b-08da8446d46a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0122:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brC7RGW3dKiqCVh8j/jQ6Dy9kjjmem9o2hDViNE0fr4qQnNx0dvQzCLUPHSYeqsdQ5Tu8I9skMccFPZz3yFW8MvMUD8q77BgfcNUTOFxiw9EwsdXLpl5IycvPiJD3iAvpdFPeIfvR0CW+esa9/ZdJ5iXo4lYHsy1DNovnAaRlGethQ3EBqG4PS9QHFnVPjqxdWe6azajeAhfBavSH8TqDgrhFjE//YJJAQfavMO5oMeWeKRQd+XaCh+PbzcaWdVaKlsULuUY6lR/d8GWhxCDXnZVoPe5PmUTfhUHSG84zLzpRCsCvF3V2/B9fEkpXoLMYb2/9TNMmsTUFBt9ekBnyKCPjuPNXSd0CpR+dYGK9df1Hh2YbOGL+1ew6AzAhSPq717K1bXGgQqEOhbfHrFeaB1eRjr20J8vk4Sks0hCzx0X3x0XNa1l+LuAJeGwPs3rYgxh3hMVmAppziTrcdqjZV1oJWSGrQc1ira0VGBxfeYKSS9uQ2Dpea2GKNLVaBdaI4wq2CSE4lS+7XU5MT7G66kkobegbt8ndD2LqmEaMGWrem/Ex68wy3Mz7OZkynrOXa0mQXbE/CGA4RIbXpt5HH+MApVEkxlDejlkUl4gtPAQ44bDE3ivnmQ+o43f5hAC+rna30ikFc7Pqn/D3TCp1XdO0Pt4HZRvOyF4uj5bmNTNVU+x29DzbbwRHMIyt+ir8y1ofwXkXWar7WGaL4NtBrQAP39M2ovOqD55Rfvgfiiv4T2iJLNtqih1cDII/Sj6lb0Efwklkwo0qy2fdmqJ+S59zba9knEYdGhF9HBeX/CTtdGh2PP7XLeO0uvsmGoxqOz+Cc3vZpxbyOkph9BgNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(136003)(36840700001)(46966006)(40470700004)(47076005)(4326008)(8676002)(70586007)(70206006)(316002)(54906003)(6916009)(40480700001)(82310400005)(40460700003)(2906002)(5660300002)(8936002)(82740400003)(356005)(81166007)(86362001)(36756003)(26005)(41300700001)(478600001)(6666004)(36860700001)(336012)(426003)(186003)(1076003)(7696005)(2616005)(83380400001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 14:01:37.1127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e0424c-a1ae-4bc8-c05b-08da8446d46a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0122
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Alvin Lee <Alvin.Lee@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee@amd.com>

[Description]
Uncomment scaling cmd assignment since
FW headers are now promoted.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 09b304507bad..cd7225d98b3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -620,9 +620,8 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 	 * Reduce the fraction 1080/2160 = 1/2 for the "scaling factor"
 	 */
 	reduce_fraction(subvp_pipe->stream->src.height, subvp_pipe->stream->dst.height, &out_num, &out_den);
-	// TODO: Uncomment below lines once DMCUB include headers are promoted
-	//pipe_data->pipe_config.subvp_data.scale_factor_numerator = out_num;
-	//pipe_data->pipe_config.subvp_data.scale_factor_denominator = out_den;
+	pipe_data->pipe_config.subvp_data.scale_factor_numerator = out_num;
+	pipe_data->pipe_config.subvp_data.scale_factor_denominator = out_den;
 
 	// Prefetch lines is equal to VACTIVE + BP + VSYNC
 	pipe_data->pipe_config.subvp_data.prefetch_lines =
-- 
2.25.1

