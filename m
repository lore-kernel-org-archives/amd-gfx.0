Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13769C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B65310E8B8;
	Thu,  6 Oct 2022 21:28:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F77710E8B6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwjMTU/IfExZXEaqglDbpTF+yjh/nrBCOAbpQt7ZxJweD5BuP9yO4FLfmipGjl1GwjLba5Ici0otpAbLULiyS/HIP18XD+bDHVz6tiXL3yUwKlN0dZNpumPJMIprril0mWwemZVL8xJZ5Zs4sGglZw98C5f8mBaWtCBC0myGGQcxiVzmBSn6EGKb+ppLuLrzUClO8y65F/2e7rKtUrLdvfaj6C4tnWOW6wtC0CPL4CycE3zcMZbcsPoiGKcLluXHJXh3+SdKlM3SAI1cjye2l00Lkt6H37C4ORVzkiehXDUvoZNbdJcd6Ye9DX9QvhhIqoy00NR4X9cdb+QV9h64Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OPefSZ/ZU+doxdYEFzx+EXOk9kYxPWH2qHwJN0m7ug=;
 b=FSH0NcmvaUKtN+UzZD2xjlaqsfvZm68RFMyZ9VbETZW8kwLNyZZdv9uzamDgOmtxaJ4Z2fbMAdEQ/8SJY2dlZF/nMnbK5qfqFhXyJa8OH5VLff1jcLCRXInt3snZNdRjLfceaIX95SHjDLyIj6++5iKeEveawh52cc2ZEbR8xd2scRqY5JpeU9QpigqAVj/5+1nkG7NzxYN2cUmFD2+64LbFrGwtpu7W+RaFGqMaXW9d5VvV5W6N2vMG5E/8ShawZWGs2wPqywG0CL+IhGmgCrpRwvHMgOqpZbBMvliacGKdtwjX+KX46LQNeJICkDn2XXF9VHftLAiofVj1qq9/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OPefSZ/ZU+doxdYEFzx+EXOk9kYxPWH2qHwJN0m7ug=;
 b=M0xhPd8ArMeJovDoDAaf41nL4H76Q3LeExaXeXie5qmJBgssShaScnhXMaJBN8zd25HmZamkR3S7kby2HTQl/WAh1N3fEpSWcX/ZkxqJlaEBQAcg9II5+oGaPfNkjnFQGftR5R7i2DLX1nqjGgA68kcH1WfpQj6CyDzbPbxALLI=
Received: from BN9PR03CA0352.namprd03.prod.outlook.com (2603:10b6:408:f6::27)
 by CH2PR12MB4923.namprd12.prod.outlook.com (2603:10b6:610:6a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Thu, 6 Oct
 2022 21:27:57 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::fd) by BN9PR03CA0352.outlook.office365.com
 (2603:10b6:408:f6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:56 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:55 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/23] drm/amd/display: Don't return false if no stream
Date: Thu, 6 Oct 2022 17:26:49 -0400
Message-ID: <20221006212650.561923-23-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|CH2PR12MB4923:EE_
X-MS-Office365-Filtering-Correlation-Id: 0862b722-776a-4e40-bee8-08daa7e1a2ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ez48P8fNhaZg7BxekoWx50Leypz5KflpQUdeeMU5NN/Gj7wAk4mfH+ss/DEAiUaOmgttNHC21ssYIEgD6/gBzOE1rKPQafgFw92Exg0ZotmzI6uFhLZEARXMS1k+yWxoVGvlAEuTL/LSAHpGw0Rs1UF7p5rQlvL/s5mftZTq4cjTSQ3Hy//qKObk+96ZFMkb2u+HtQZqbH6QF7tcDHJ2tUnb6hS22tKJpO0uYJDkG05PQ9AvbhtfipWXtsZA4xOZKfTDFX/fMbtkeQgazaZe1SZVSPRgfcm1G4yRs2a7ZP+/ScvuyEERMVsTUrbRbgwccH4Q7h3z9erQd+j/B0jffp36TrnvPhDGBMC+ZE9X957seYRjFlg3fd0AEgYGWjx9YGddKCwb1/9KVBGJonG1RrMCNzGjPUv/+SKkq4wMCKeiBYNs2SBI2MFwafht2rUWeo3wrBV6618OfUJii8dXHFNuh+jWP8o/7UFukkZkalmz4aXTF+BpkJMJDRN57GQanG3sH4JFNcha32uNau3mgxdL1+EZYNYUICCizh569JGPYOPm+Dt3CTuYH1koOXPfGmDdejYyp1wWvWLTRcLHltO5T3L2IZ8iIS3kSdMNQ6SOWXSWH0CL3+6tJqL8c7W5NIDGryY72Ip732pOpnMcGL9le2CPfB+eb5ZErky5RTOratpiGtgKSPJEoNgUOK/rzAL6TlmFEzFtFTs3wju9/VTlSVV0IWBLYNPzTGGyv2ljiBNmWqKMS7jhvOnDPM8FbietF+9WM3WXt1BGemRT+NZRRuVOY8ebq0405Mkv5lZNIUQwB1PhGgbFgH0MpIRf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(36756003)(81166007)(356005)(82740400003)(36860700001)(83380400001)(426003)(47076005)(86362001)(82310400005)(336012)(16526019)(186003)(2616005)(1076003)(40460700003)(26005)(6666004)(478600001)(2906002)(54906003)(4744005)(5660300002)(44832011)(6916009)(316002)(41300700001)(4326008)(40480700001)(8676002)(8936002)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:56.8666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0862b722-776a-4e40-bee8-08daa7e1a2ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4923
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

pipe_ctx[i] exists even if the pipe is not
in use. If the pipe is not in use it will
always have a null stream, so don't return
false in this case.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index d51d0c40ae5b..b03a7814e96d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -200,7 +200,7 @@ bool dcn32_all_pipes_have_stream_and_plane(struct dc *dc,
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (!pipe->stream)
-			return false;
+			continue;
 
 		if (!pipe->plane_state)
 			return false;
-- 
2.25.1

