Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FADC25B79
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 15:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83DFE10E4C2;
	Wed, 15 May 2024 15:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="znDqpb5t";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD2F10E4C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 15:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuCH5xxk/70PmAuSuGgG3J3S2QhNAPNjBeTRDlcXpkK5bIxA5kOjd+GpChM21HEXn2hWIo4dnwghZ4CD0iMOxzMEsRAdsmiE5nopO3ibVfWnih15totNKhqDtL4JIDNhE0sg+p9WTJ5r1zcoiikhUobWxW0ua+ty9/PO+jjSpxUJoGNCYqDllFu/hQ9WKw2Cy3Y+2Y745chjXZfWA939fn331NY4n/4Xj1VUdZt3V+t4Mgfn/1R7bhfpMh+tz87FitBK3cqMPTiaDJTIxxdgNstRzm1N02I3o0x8urNyUzE+VJ5fY+/QHWS+5OieK4tFhwSDRFfXpLk7JNi/bedCAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0QUaNrTbzmiDo4RVzUuNpXOR1F5oMMjBvv5KIbiyVo=;
 b=k0Eh7ZyLVDWOdZg/giJvfhedIExgUriW7o6NHBIKM91MP8hQm/0XT78SrE+HkMtuRAMuHIYV5GTXIhjW9aBLAeQcp0Eze+9S1lC7cES5nv2x2fxyM9WvWzD/UaMmFogfKghgjmwyBfispALzAuUesZFSFwRy7V0lL4aGc64waJ2Sop72iCZ5ew0Wzrlz32+SJYlNfiG7OQ1ofhuZC92vkMKvpp8us1pIrnO1rbwa4aNeaUxZ2vToPo4ejjt/wp9GLB0kseEBumfgAtWnYcTd1k1UzPSHn8z3vQQHq8u/2QjJFf3ZEMPu6fgRV3A6Y8o0YfNX56DZzcyUbIj+UilOhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0QUaNrTbzmiDo4RVzUuNpXOR1F5oMMjBvv5KIbiyVo=;
 b=znDqpb5t1Cmi9s4BO5bMG2SYBXJLEluw0i/BXXt/5ssnPuD4BppCZkVg9Ep+QBbeCox9+oszQy6ozeG1H1MCQ3dzarw+nwsG28Y+0V/spFCirxd5r6oUfzPoawsj8HHad2iAvlJ6y3fQbpxOB5Aj53+nkHig7QED1Fis71J6sDU=
Received: from BN9P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::8)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Wed, 15 May
 2024 15:24:02 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:10b:cafe::61) by BN9P223CA0003.outlook.office365.com
 (2603:10b6:408:10b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Wed, 15 May 2024 15:24:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 15:24:02 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 10:24:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>
Subject: [PATCH] drm/amdgpu/display: Update kdoc for 'optc35_set_odm_combine'
Date: Wed, 15 May 2024 20:53:41 +0530
Message-ID: <20240515152341.750360-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0b1851-776c-4666-a575-08dc74f30d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VP+Pr5hQhZAAAeVF/k+4VUwFkPlL9uRKcDQmA2OfQpISiWyyEN09TPyedLd7?=
 =?us-ascii?Q?z+arJ/hJaV3EFEOVsMJ3ZQQEdUGiyvyVbxCzhrUkmIpzQJDttIEsl22hHTSc?=
 =?us-ascii?Q?WABx+mhRXGsr2vaoXdtzao9Q6HYnFqIrn38Az5OkbwntWOPNFPkh6mnyEHmy?=
 =?us-ascii?Q?jZLKjTNnopXJNj6+/uxt+ETIUcX4LTUpQVIQqRP4f9FsN5JcSeI4cPPEAzIw?=
 =?us-ascii?Q?j8oB6UWaVmsqemCe9DeH6/k0i3tFc2RzQSvqG+yn33mGr9EEAkJ2X2HJaErU?=
 =?us-ascii?Q?CM9jrrC7EA3NRlpeMZaT9YTfDyZ2If0aykTDiiGIePSJCb2RBmbLB40hPYyJ?=
 =?us-ascii?Q?pfYiVTFqIUgY7Om3CymHH5iSk602/lRbPlib1iH+HXfG51j7ZOqK+MFIlCs4?=
 =?us-ascii?Q?x4mqqETLG5NUkNGEKmwkdTRrFMh8TCv8t9RqiV+tts8UC2l7uu8SXQyL7XWV?=
 =?us-ascii?Q?Q6KbZ7oLGtCH8YR9OA0oXEqmaIn5aOYqT46dcPvxWiWw+VfTy0grTp5Ifqdj?=
 =?us-ascii?Q?icXXFScNQo9oabp6ZFnI8YxtppHdcaoOV+bk7rjMQPJ6OGtUtpcXMnG4o/BD?=
 =?us-ascii?Q?ip9E1sPxTK2PngR5TfwD+qWesHx8fnyc1BpD9OaqqDufkTGBOQskhTWimGA8?=
 =?us-ascii?Q?6l4u9q/FTpZsZfUu/6I7lWxKeWwBLtEa/pcC2pN8fa9/h0DaQxkfYo2SxVpL?=
 =?us-ascii?Q?qhTs9XnnozcKiolUEwss9Ukj/RqTUs/flZ/vH279JjvBrKvY62jNKMR8q/OP?=
 =?us-ascii?Q?26XyMni8HGZ6nLTsv8tNWO391c3BgcaArzAOkuWYulSb7WrMJGUMdVUXkPA+?=
 =?us-ascii?Q?kJ0HmWVHMrczKVK//6X16zeEqD+GVvOJzNLYYOvBE1uqqz/Sw/9M9vkqMqqN?=
 =?us-ascii?Q?lkchhSVR7Nk3+v6WJYrkDvmuJ2mifz2iqJ9uqDhtPwQeNMR0d7i4qH+Ejujv?=
 =?us-ascii?Q?bIEupFLQqU+Thse+KCwZXaodRzubyliuSqGHyCuMR7MamRtTrFqtRsmVnBNv?=
 =?us-ascii?Q?NJfn4R1NvHRyrfgu5M+ZLknDzOUa/IXitaV2X7XtCcoqF/pBzDo/XciZ8kI9?=
 =?us-ascii?Q?EemCzxojy+Q2r6DxZrX9D10D/yEzVoRpFVuSQ2jwxoUD3udYDbQxtUHhKG5Y?=
 =?us-ascii?Q?hLJWhTSwE+FVcgszYVDeLicbCb20xScPovC0CaY3uK9SJBLRnW95j/trMV7l?=
 =?us-ascii?Q?4CvVeQ7MWekI4DhZ0HwnhfTzf2oC0Aba4qCPy3JaFhHWhSNCK2sie+vyymGb?=
 =?us-ascii?Q?B2np+ki7S/1Y76z+GahVtgEhTZAwUbhhbDVa6ykboZY1+aRQlGIPzJlHkwcZ?=
 =?us-ascii?Q?gWfAR+/sTbzSJci8g4xyNaIcIH3tkvnBqYRIbH3YDKKWVKEFYBdlHbU2NAC3?=
 =?us-ascii?Q?kXplIR4zoPIVoOgBtqeCIhmC2t1/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 15:24:02.3975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0b1851-776c-4666-a575-08dc74f30d0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The parameters segment_width and last_segment_width are used to control
the configuration of the Output Plane Processor (OPP), specifically the
width of each segment that the display is divided into and the width of
the last segment

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../display/dc/optc/dcn35/dcn35_optc.c:59: warning: Function parameter or struct member 'segment_width' not described in 'optc35_set_odm_combine'
drivers/gpu/drm/amd/amdgpu/../display/dc/optc/dcn35/dcn35_optc.c:59: warning: Function parameter or struct member 'last_segment_width' not described in 'optc35_set_odm_combine'
drivers/gpu/drm/amd/amdgpu/../display/dc/optc/dcn35/dcn35_optc.c:59: warning: Excess function parameter 'timing' description in 'optc35_set_odm_combine'

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 7c9faa507ec2..dfa9364fe5a6 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -50,7 +50,8 @@
  * @optc: Output Pipe Timing Combine instance reference.
  * @opp_id: Output Plane Processor instance ID.
  * @opp_cnt: Output Plane Processor count.
- * @timing: Timing parameters used to configure DCN blocks.
+ * @segment_width: Width of the segment.
+ * @last_segment_width: Width of the last segment.
  *
  * Return: void.
  */
-- 
2.34.1

