Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06255C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 07:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED8222482
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 07:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED8222482
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED94689EA9;
	Tue,  5 Jan 2021 07:09:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E49189EA9
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 07:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/rnHNhAFih5QM/0oXh37VZ23/CgiXL1rd2fRIy/IcPZJFwZUw4s9s98nY5PAvp8aJqi9gx/vfMD/zzP5IUN8OeQR/t6nSRtK0MVnYjQLJ+NqEk5G0IDXAsMZ5pG64789YJJ3DlA0aSd/p+jdLX4AEL4CgJ3J/JsFzIY73yTUcFXuvAgrSt1E3J1qyJ6DptAXEgRsuEMwYfnplP2U7ZsD+KhhVBhiuJiUupvZW+1IJ2eQcmBdEz34k0VQgotSOMwVPfD9qbjXqugv9wSLaBg269S4aMXlghBKDg8hL8WzAiBT2PE5BAo5gjrM4YrlO9vgGyz2CpiMJH4aXa8zmT4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7EmC7aSjppldBip1TeEAM9GdnrRIvUwCLchRCFMigI=;
 b=DO3c+Ts6Z8uJEkD/qYH6DykqhGiwPF/e78uquLmdUeU1oupY0cOHoWXKKCY8nGRIe0Xoh2j6y2zbWrxMfNRxVYEHwvBgRP1Wx8XFPPQLrQ/DmH5lNR3QRK3B9giu84yeX/aVK0as6RiGs6W4+11JcxIk6YuSzhLsuLhyMvGj4Gd7d+tvpkZMp4EVQyfBWpDiylM9l2tP53s0W1itOmPqKsi6TeLL0RxSs/nGVgx6WlXqmsBEe0MOl10245DF/M45rAFIp040m3XwJxlStlGIaXPewI4RSIxsTe+QCZ3kvkl7JPo7aC+BghXGY73hTXANzJ7stZEilEMB3WZmgJ7Z3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7EmC7aSjppldBip1TeEAM9GdnrRIvUwCLchRCFMigI=;
 b=1cA40A65jQaIS8/eZthPf+2kHVQQsxSQqGPz+yV5FYBhsJRPoM+PFePVFdxAkP1Re9oqFX5NkKXYp45/KbVTWf3/Ai83LDqtxVjTUF4wd2J98mQkTfCi+7qzUnfcq7LGVFAi+vRCtQkWWljTLbdkBKNUKu1HPprPa0CBSsh38Kw=
Received: from BN8PR15CA0027.namprd15.prod.outlook.com (2603:10b6:408:c0::40)
 by BN8PR12MB3171.namprd12.prod.outlook.com (2603:10b6:408:99::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.22; Tue, 5 Jan
 2021 07:09:19 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::4) by BN8PR15CA0027.outlook.office365.com
 (2603:10b6:408:c0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend
 Transport; Tue, 5 Jan 2021 07:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3721.23 via Frontend Transport; Tue, 5 Jan 2021 07:09:17 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 5 Jan 2021
 01:09:17 -0600
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 5 Jan 2021 01:09:16 -0600
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/psp: fix psp gfx ctrl cmds
Date: Tue, 5 Jan 2021 15:08:22 +0800
Message-ID: <20210105070822.25795-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b70e223-7403-46d3-85df-08d8b148d11f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3171:
X-Microsoft-Antispam-PRVS: <BN8PR12MB317181A5A4D0EE6768C37515FAD10@BN8PR12MB3171.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MoWtUN0eTj0B59a94aNbVsZN3UGYqrmu4X03GWEIhR+T/XtHyRM3dftyq8szbhBTFWet/LJzzB1hWZl9AvyYHmNvYvpv6cxWrufXJVh/hKSPpE4TaytRPzHPaWSy/F/NSSikh0u3O8CnCtvrtPnrr8EilDrH89UDH1DZ9J/6YkBaQxGVAC2GPTGZJNxYWEhzViXn4W8odBB9xr22/B30JOvPHvkEU+TiJwfesTf1JXIcipq2Qq4oBOF+C7punvBeNR1G2rQTxGp4xxY8WlGH5CpoQ8qYG3COKGkdVRmWZccLSS5ndDarmjo+jWdT9yocr6VcF3bc5noz014sUayggJR4HEx1SYGzEvlooLMf1iu1dx6tIGOuuITObJoVs2fH9Kv6RpfTKHmmrJrfzZ6VM5q77VHTh51mNOI+oJNZhRjLezFTNmpxNqGceT7Bn8BWHsbkh9fhQiF4PJw6eT+jsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966006)(70586007)(4326008)(426003)(356005)(70206006)(478600001)(1076003)(8936002)(82740400003)(82310400003)(186003)(6666004)(336012)(2616005)(86362001)(83380400001)(7696005)(316002)(8676002)(6916009)(47076005)(26005)(81166007)(36756003)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 07:09:17.5961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b70e223-7403-46d3-85df-08d8b148d11f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3171
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
Cc: Victor Zhao <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

psp GFX_CTRL_CMD_ID_CONSUME_CMD different for windows and linux,
according to psp, linux cmds are not correct

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 26 +++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index d65a5339d354..602ea5cd9f3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -39,18 +39,20 @@
 */
 enum psp_gfx_crtl_cmd_id
 {
-    GFX_CTRL_CMD_ID_INIT_RBI_RING   = 0x00010000,   /* initialize RBI ring */
-    GFX_CTRL_CMD_ID_INIT_GPCOM_RING = 0x00020000,   /* initialize GPCOM ring */
-    GFX_CTRL_CMD_ID_DESTROY_RINGS   = 0x00030000,   /* destroy rings */
-    GFX_CTRL_CMD_ID_CAN_INIT_RINGS  = 0x00040000,   /* is it allowed to initialized the rings */
-    GFX_CTRL_CMD_ID_ENABLE_INT      = 0x00050000,   /* enable PSP-to-Gfx interrupt */
-    GFX_CTRL_CMD_ID_DISABLE_INT     = 0x00060000,   /* disable PSP-to-Gfx interrupt */
-    GFX_CTRL_CMD_ID_MODE1_RST       = 0x00070000,   /* trigger the Mode 1 reset */
-    GFX_CTRL_CMD_ID_GBR_IH_SET      = 0x00080000,   /* set Gbr IH_RB_CNTL registers */
-    GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x000A0000,   /* send interrupt to psp for updating write pointer of vf */
-    GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING = 0x000C0000, /* destroy GPCOM ring */
-
-    GFX_CTRL_CMD_ID_MAX             = 0x000F0000,   /* max command ID */
+    GFX_CTRL_CMD_ID_INIT_RBI_RING       = 0x00010000,   /* initialize RBI ring */
+    GFX_CTRL_CMD_ID_INIT_GPCOM_RING     = 0x00020000,   /* initialize GPCOM ring */
+    GFX_CTRL_CMD_ID_DESTROY_RINGS       = 0x00030000,   /* destroy rings */
+    GFX_CTRL_CMD_ID_CAN_INIT_RINGS      = 0x00040000,   /* is it allowed to initialized the rings */
+    GFX_CTRL_CMD_ID_ENABLE_INT          = 0x00050000,   /* enable PSP-to-Gfx interrupt */
+    GFX_CTRL_CMD_ID_DISABLE_INT         = 0x00060000,   /* disable PSP-to-Gfx interrupt */
+    GFX_CTRL_CMD_ID_MODE1_RST           = 0x00070000,   /* trigger the Mode 1 reset */
+    GFX_CTRL_CMD_ID_GBR_IH_SET          = 0x00080000,   /* set Gbr IH_RB_CNTL registers */
+    GFX_CTRL_CMD_ID_CONSUME_CMD         = 0x00090000,   /* send interrupt to PSP for SRIOV ring write pointer update */
+    GFX_CTRL_CMD_ID_MODE2_RST           = 0x000A0000,   /* trigger the Mode 2 reset */
+    GFX_CTRL_CMD_ID_DESTROY_RBI_RING    = 0x000B0000,   /* destroy RBI ring */
+    GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING  = 0x000C0000,   /* destroy GPCOM ring */
+
+    GFX_CTRL_CMD_ID_MAX                 = 0x000F0000,   /* max command ID */
 };
 
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
