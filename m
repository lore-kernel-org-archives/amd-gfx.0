Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD66C35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542152067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W/117iZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542152067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F386F4B1;
	Fri, 21 Feb 2020 16:04:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D3B16F4AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+j92AM0Fio2dvqIf8Bh4Y2Zqj7a8nLHOygMWnedyAp3O/Ojf+DR9eWfO3MAyVDCQ79OQyTld1mqZBc60kVCMQK8G21QZLDZFSfNydqaVX38BMhqAs/UI2EjpOPFKC7Oszeez6G6PJ2u2cfKKdZprWiZ/hNe4c8Q8EO2C3Dy7+sQTRJ41WzO7TGwSGDxHa8LFeIUQlYHu6o1mnrgF7rV1YChbEPISzprO9CWmDLvcxkgwYmQX+cG8vulqXAcY04eiv+eGVxB/wry+VO8NxaITlA0lGQhMB7Jko0MvfIBBdsJkrihONLOguay90eENKEc93ZCTaj2Lf49IGeS8juA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcUH8T6PyqAa6rksBv1BMzauHnDG+NNV7FGVKYpb89A=;
 b=B405F0Klb4rXpXZpU3XYW1Xzw70Fujcxpb/Zyqq1f8/vvpRdKHe4fpjk9vKbNGc10mmCml8gIC0bHsZjy61j79afu5Qwq3hYbWKZ3HwZyLSbNyYUMi1VYp9RUCOBcMNTZCoFASlsRKUIAC8d3ezgq2G3tRi0lgO3hODfmTyBZN4LuMULeH+ioBuEDvl88aZLMZf5+VT90dB2KIe3kCwKd8jCS2xbsPTntM625Q91RgjjAWv7osQ70hZVOJTujDdm2kuenuFWt+bqHc2fVROxTM/cKCbWEHWRL4YpE8OZGnnE4q9iV2eT7Sv+9kP7/bBmB/kvb4rfza272GGHMl+siA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcUH8T6PyqAa6rksBv1BMzauHnDG+NNV7FGVKYpb89A=;
 b=W/117iZVTMGEdpxvsOD/2PF4rXZuSKMSY54PbjelMCYjUz0Zu2Bdu4e+lrensa4nCXkb/TP9K5j2Yr35iCYMlbfVWRtAPJURhUaRFY2LGZrGxBByV4cYRVnE2zOR+NYqPNOB7RfbkpoNcumO9ykciMyYTJw+0lUrmVtCjzBBSkw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:06 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:05 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/35] drm/amd/display: Add visual confirm support for
 FreeSync 2 ARGB2101010
Date: Fri, 21 Feb 2020 11:03:12 -0500
Message-Id: <20200221160324.2969975-24-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:04:05 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a303876c-b6e4-4087-55be-08d7b6e7ad53
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24097DB264700F8DCBE3E86D98120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(16526019)(36756003)(66946007)(66476007)(7696005)(66556008)(6916009)(26005)(52116002)(6486002)(1076003)(5660300002)(6666004)(4326008)(8936002)(81166006)(2906002)(2616005)(956004)(81156014)(54906003)(186003)(316002)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2409;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KkajGQR3Op+L4fMx7pIIz6ZQ9WdWMD2UwgEADsK7oF286GyxDbNVxT2J9fB6T3K5RxxBao89RXr2opEzutCfTYulcXUizn7mQCJTf0jc+3W//A3A0738baexzgMs8kUoSGSaaANKNjyYx4fIShBpXmS1VOT54MbOACTAk8hTWZkAgeYHazUshHsOFsh1ZQvOBU9lx1OfF/raddFx8UsEMV/V6RWs3/N27tb42bYnxU9amAr9sMMW01YDeK0IPYmUq7QSmoo2SGC25y8l8946xDRJ9WkSbHUmnHqrHoC/DGvgVX4nO8m4bB5T5O/2xtM15Z4YWNv11PQqemf374TVXUoYvS/UzD2gRI+SbwTPF64K8Sm9AkVTX6VEW0t7IaCPyBgW5HJ47s0qilguWLd0tV6uFrtVZxLVWLto8A2vjtXjYM5LYArqMXlP0ZDOR6v6
X-MS-Exchange-AntiSpam-MessageData: i4PJrM2iEXXaYclmlLD9iF8VEgc5vkvs7kCER59sVO2AO7803ZMWKsSFfw+KS2Tmt1+V9PhClw4mMMYKglwGkg9RzMaSlXo9VvlTg033gZCKVuJeMAQNsXEIoy5I045ec5pq94flfuZUf+gaiWcjlQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a303876c-b6e4-4087-55be-08d7b6e7ad53
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:05.9693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7m3shTqW1nIEX8UMIz1WbPESQwo/ejJKTQg68rIOZDkalzvZmHxe37xZrHpz+G89Lmo8uOmo+pqAy7663DutZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
Cc: Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Peikang Zhang <peikang.zhang@amd.com>,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Peikang Zhang <peikang.zhang@amd.com>

[Why]
DalMPVisualConfirm does not support FreeSync 2 ARGB2101010 which causes
black visual confirm bar when playing HDR video on FreeSync 2 display in
full screen mode

[How]
Added pink color for DalMPVisualConfirm on FreeSync 2 ARGB2101010
surface

Signed-off-by: Peikang Zhang <peikang.zhang@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 113ff6731902..77396a08ad29 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2114,6 +2114,10 @@ void dcn10_get_hdr_visual_confirm_color(
 		if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_PQ) {
 			/* HDR10, ARGB2101010 - set boarder color to red */
 			color->color_r_cr = color_value;
+		} else if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22) {
+			/* FreeSync 2 ARGB2101010 - set boarder color to pink */
+			color->color_r_cr = color_value;
+			color->color_b_cb = color_value;
 		}
 		break;
 	case PIXEL_FORMAT_FP16:
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
