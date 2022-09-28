Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F79C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA8710E9DC;
	Wed, 28 Sep 2022 19:42:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DBCC10E9B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSuwSfCOWcHRQanuAWdM0ryJS/Ti/EVyAYSV1NH1VsG0T1VD0JaSYdqH2MxGAKCd+kZbi7SrinyNA5HKDfBxRIPgqufM9ZvIxS6IJ/0+Et4K/nzIiErd7iWbG9VstYQCy8XzTcjJtFVrhrxz7DRzKzz3t2Nc2Y6t7s3OVAy7Yd/iWFHwILdGqqYvnaCiPTDgyDxaaf/Duwij3dmngi00cThwN+nQllhkEXkkEJKS5C6awql32zxZJ3Sz0YHZ7Hd+FJy/TSdyWOiX1NllWM+VT06NiX1Z5Up/+/2EIIIPBuy1MdRFIoUNwUSRdqkErfhYPU8/VtxIvE1J5Myip0ep7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DRISapCuIsl2y3lqen/GJUOdWQXE1hbknzBJ9eKDU0=;
 b=CF7J8Hpe7nT/ihRnwuKHsSZQWXQbXqleNGNp+Edc0x8M2Ocd528/tEcrE25HblL66LFWF0RDlDoEwA/rroCoS0A5fzaG9YCraBgGJmTzqmSRlEEP9+/inMOV6hXt0PI2RCB4bbM0cjfjFMjIUAQWjqbwTUC5hS/mjsCwwZUci6g/Wf1dPSObpojPNg/Q6C59EAGYOHvbrnM6ki5wYQJquICXPtJZCZmhw9XB8ftvPSLdqEuHrjChAaKKy1+aBjAtiztuU2OVs6y2Gx/l7pqifr9V4lb2K5d3i3fqq0VjXM8qqWJRYY8NlbcDcinZ/wAzvhBTkQO9gTautcJcvllYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DRISapCuIsl2y3lqen/GJUOdWQXE1hbknzBJ9eKDU0=;
 b=FW02voMuik/5Z8HkqVJJzMfMxV3VHto06V0GMlJp9JzJMmGh5y8yqT/C51yS9+NzAHC9kh4bvvNVAr3DwJdikDtMgakNJS7envxpbHxxdHNCkyBUY5tCovsq/zBqqlwx1WhkfOHYwGjhSLq7DMLoKPb8T12bTMJ9/2iYv2yaUJw=
Received: from BN9PR03CA0726.namprd03.prod.outlook.com (2603:10b6:408:110::11)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 19:41:35 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::e6) by BN9PR03CA0726.outlook.office365.com
 (2603:10b6:408:110::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:35 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:34 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/36] drm/amd/display: Add missing SDP registers to DCN32
 reglist
Date: Wed, 28 Sep 2022 15:40:20 -0400
Message-ID: <20220928194028.144879-29-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 208d72e2-6a13-4605-6663-08daa1897418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NVhNXFmAfJwsuo/cX6/weZkStyHH20o4jOgk6ppyN1mS0d7hcVtaU2vPJZwLakSZ0HkQouR9kyFADlQVGWecOmlUt4zcHbU+74/B2B3wOAnDTYHteddRhkxvxbnov0LMVC6+1FoH7rokaCqmY+G+g8G0f/x8F3pRx2+PchRk8SMZrV3aR96JggIrZTGs8OsES4NIMNUe+8T5owfkaUe48MGBcz0wj0AaV4fSgR+ou9yucdkiV8ULhrXVAelGXrNA+HgsRIb/DtDHlYI4XIQfffjkmyx7/qsW5aDmyawl51nM2rUrlmkqbJylztwKWAi6x9vBiW2Nezjk6I29hRQtbm7zlgYvwmf5QxjFuYCxw0wHwSPAxVG/usc1FpwlsZmhGeaRPX37Y/pGZw3LJd0zaA6azSRn6UWkdMe9p/AcaKV6ujuGaTOU2aouyUMZzAgkDKShWFXznQx4gAwaEvihg9BHJHHtBTrRxnsNUzQUZkEFC2fuqzZVP5c+oV8j6xCVlOBKZ8ruo5sWz3C/ZR0z1s5VSfhB23mJhbGDnFY01Zs7Qx8mDToFvpmNaN3/DtUPlJjNbofjch2nzuu9k3NK6MwT25FCePqOMp0JHoMuIfaWjuCKQqIwJpBfsCi/bQ0yfnhKPRc//qPhjhWLjmsgBE8q+xYTVaixoCMpWTVTsJHwhr8kHVxuXgNB4fpe7MwugglHqS3Sx3Ipv6mTmDlyMp5/KnNvAbcCL5u3Xn3YWF8Znvj7XSDj0XMtcCJH0BcS+X1tqQ62zQGEFMfPoEKn8p/TuicFMcHjN8L4wdXb6RSYxkn6fWN4GADp2dJW5xomWOdKuDnCTSlVyKzlsxWgVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(86362001)(81166007)(36756003)(36860700001)(356005)(2906002)(186003)(1076003)(16526019)(478600001)(336012)(40480700001)(40460700003)(82310400005)(5660300002)(44832011)(6666004)(26005)(41300700001)(7696005)(426003)(47076005)(83380400001)(316002)(2616005)(4326008)(70586007)(54906003)(8676002)(8936002)(6916009)(70206006)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:35.5912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 208d72e2-6a13-4605-6663-08daa1897418
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520
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
 qingqing.zhuo@amd.com, George Shen <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <George.Shen@amd.com>

[Why]
Certain features require the additional DP SDP configuration registers
DP_SEC_CNTL1 and DP_SEC_CNTL5 in order to function correctly.

The DCN32 DIO stream encoder reglist is currently missing these two
registers.

[How]
Add the missing registers to the DCN32 DIO stream encoder reglist.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: George Shen <George.Shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
index 250d9a341cf6..df7e36576ac0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
@@ -71,7 +71,9 @@
 	SRI(DP_MSE_RATE_UPDATE, DP, id), \
 	SRI(DP_PIXEL_FORMAT, DP, id), \
 	SRI(DP_SEC_CNTL, DP, id), \
+	SRI(DP_SEC_CNTL1, DP, id), \
 	SRI(DP_SEC_CNTL2, DP, id), \
+	SRI(DP_SEC_CNTL5, DP, id), \
 	SRI(DP_SEC_CNTL6, DP, id), \
 	SRI(DP_STEER_FIFO, DP, id), \
 	SRI(DP_VID_M, DP, id), \
-- 
2.37.2

