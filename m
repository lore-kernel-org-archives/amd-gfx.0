Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654D9C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15EB410E037;
	Thu, 20 Oct 2022 15:48:35 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 269DA10E4F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXB0zuob7UqTQVWJDkYMAmvr+KaKSXCdCep6OwqboPvKixdp8Am6wTvNFw70CiKqNhYmAJUSvfSGGhVPGg7vn53sUW3vSBN3lQzflF2mZeC7rDl5ozmpnTeVR4ceCj0RAhU9WfT7hozkGqHRAHuF6t8Lb4WBCPrU120+Io8pwy5cmOU0Lju+h0a/EsgjYZuMSSeHGwnhDaui7ckXbc4gLSzrHIIP0A9RRZZk83r4GWBr0XDAZV0GJSYc2YW7SyFy9foxkpOFaVtBYM6UOGzM4q+XdU6jf+1cUC4GRifMzf5z4zis2ayei7sRcImXdNs3PCtOfdzNfLN5E5h8SaQHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlVN3n+YspnUjMlrVOg6dmJ+WQW4FaIrVPTRIBkf0ac=;
 b=alZue08d3z1/kQ2unh0cwRFMBqoh/RhZ54hj7PetNZWgsEsGPEx/Bl72qc8aQzjZoST55MQHoTYbOmfLVekM/yAtDCnfcCY8HrNf8JTkvS4RcJT0rOv9dRgnvztGzaGd7HdV8UuUo891q1P7Nfe4JpnoXqfX6ALp3otT3XqExHHc6MI5nLp5/6ue4Rp9ntAF8hz3zjMh4fAMAvbefUGqO8FIQLe+djcmYHmI0vG1Oyw2+Km+h6VtU+Cm3mq5dkQSvbHezKOVGgRYcsusPEOHxOTNVFCzc35zmyI5V/GbPSdjYRuKTvVXcNaa7F0VU8rExp11bWTqfN5v3kfIMMp4fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlVN3n+YspnUjMlrVOg6dmJ+WQW4FaIrVPTRIBkf0ac=;
 b=cpdUZ3y51W/82K+aXoZCUh0wsonTh4mBdGx8dLX9LXJFhOIZOzGCjQxEDEYRdsw7DPkMI2P9WDaDZcoCRLPp1Zw/H1Bd8UHMbNeP2fulP/hWOZev0fPTcrOGKVXwoWIaFBOBWIn/KVcnnJ95KcyYilv0fH/SbrNyrkMxLr4I4CU=
Received: from DS7PR06CA0041.namprd06.prod.outlook.com (2603:10b6:8:54::10) by
 DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Thu, 20 Oct 2022 15:48:11 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::d2) by DS7PR06CA0041.outlook.office365.com
 (2603:10b6:8:54::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Thu, 20 Oct 2022 15:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:48:11 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:48:06 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/33] drm/amd/display: cursor update command incomplete
Date: Thu, 20 Oct 2022 11:46:52 -0400
Message-ID: <20221020154702.503934-24-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|DM4PR12MB5261:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d3716c-b712-44ad-d116-08dab2b27e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrQ3zPRGB0QzxRtEYbY5G2Y8L16I4RFNY5EFLf64yldmDcpHm+zNiK7EHSXDd8Pf2k2JDO2gOj4s3WwqDqVe7Jo8nJT1lzh2K1emqNwufrOCYkisx/FxsUUTrxNnaXGsDRSVCjEVRx5Vas6nyTxnaHfhKNBDTcCYgcpY/AFC4sNnhzaM8895/vob15mv8XtxOuH9dwnbpDPCK/ML8MTBCqbesz5S8uu+KSzYC6SeJ83txMTMyDhat3rPion2MGjCwIDakQzl7Ft3t9u0Jv6JqnvE4Wtzac3YV3UqFJIfTYp3bIUfOtp5v9KsFSkr+FHZkzEBOt4Lz9kBVL5CkokfLA/jMqoI5l5q3Ot//L6RUEQZyWdZF/Imm/SGD9hG1Mh0mzqidTVpFdPHCUQZVN9r9RWXQk1IdVsvZKwNmNiq81/wEimI52vpNUjJDAtP2HjarEBdCAtDe+O644eITpPIzQuH2uWrCmG3BdswRrv305Uruk4UBITXi+bkw1y5EItMRRq+oGVwtEqBXnAxqVuCJ9vN2sgV6KTh+f3ODe5/nzLVL+LdKvQqkOaGEvMhd1fVwfeeCXnOSc4+Nxbo3SmFVI/944acw+5NT39DNg9LhSfGhtGdyEVMbHLZcsA7EsKmtSGXooaoL5XeAcKLwRENAXDHWgxioAj774I4y/1o++u+L4CNpzqwFrUBDarqa6DgHR3Vc03HBhBicM35VGH5fukecc2/b1IqUygi3SkaXk3T6TVFQYzb4DaBmH8r9ySWrRetz+w4YEWq5wWH4z1DWvbE2J9mqiIFHbRpEQ9/jCo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(86362001)(36756003)(81166007)(356005)(82740400003)(2906002)(7696005)(336012)(6666004)(5660300002)(40460700003)(26005)(40480700001)(1076003)(186003)(16526019)(2616005)(47076005)(426003)(36860700001)(70586007)(82310400005)(478600001)(6916009)(41300700001)(8676002)(70206006)(54906003)(316002)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:48:11.5633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d3716c-b712-44ad-d116-08dab2b27e21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5261
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Max Tseng <max.tseng@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Max Tseng <max.tseng@amd.com>

Missing send cursor_rect width & Height into DMUB. PSR-SU would use
these information. But missing these assignment in last refactor commit

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Max Tseng <max.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 4996d2810edb..938dba5249d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -623,6 +623,10 @@ void hubp2_cursor_set_attributes(
 	hubp->att.size.bits.width    = attr->width;
 	hubp->att.size.bits.height   = attr->height;
 	hubp->att.cur_ctl.bits.mode  = attr->color_format;
+
+	hubp->cur_rect.w = attr->width;
+	hubp->cur_rect.h = attr->height;
+
 	hubp->att.cur_ctl.bits.pitch = hw_pitch;
 	hubp->att.cur_ctl.bits.line_per_chunk = lpc;
 	hubp->att.cur_ctl.bits.cur_2x_magnify = attr->attribute_flags.bits.ENABLE_MAGNIFICATION;
-- 
2.35.1

