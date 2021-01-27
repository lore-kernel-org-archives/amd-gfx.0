Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7D0C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 14:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 392D62074B
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 14:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392D62074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0FEA89BB0;
	Wed, 27 Jan 2021 14:57:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29FAE89BB0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 14:57:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jay2gpIMydsYwPa42k4+ZHHWv3ptiWF4W7H9e+C/9clbEOwAcw66GZEM+y1VoNwRd+oTAZvVnPEKG8xH0voieOpwtY+kUmI2DvsHZbIgQzSRAaIG883Sxq/FosTUpYj2bE1bTiejAC/gW1rvp6x/MEtE4AiQjkOUs56GFb38n2NIDzsPhNsm0PNV64SRe10H7xM0xa0+L7KOoGVgCbQflB9uAjqlbWzAGbeugHNRH6BQKOqQUKdzPW/1zjrR3qLvbon4PD8c8b48PYuYAq4DlG3cMRGqaKVvoXtfB9dqI3FxSR8uKvKTVSCuarepX9fN2zS62F79S0YJ2G+xmuyf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDm6a+JHnTr2S2+AXWPk0amwp5ADwbmKcmrkAVyYJ9g=;
 b=B+GMDObuHfV42VBgPennJ9g67RQrfA9vHm9+Iq4bXY4AOpcdlnn9taSjNEGgDUjUz43jRoR/FLmB3iNW5INJB1ORChe1wu7vrKDFLlq9dbOE3OmXB2mZRnnbidKb71tXti8CvdbHa9e6PobH3rMsr5VVIFY3k23Cg/TBslolZ1GZZ+P+DFXhisDNerCTCz0ICqzbJXYUnqIq7wCgUVXw7x+Srn5TPiP8QHjJ4XYT9WmJ6pSJoSQzT33RhaVvT9XceH7JIA0G/i3S/G1AjTeBSghgehSGouh/jX7z0RpN7jhxbG+7kfR82WPV/tGODFBiw2lwZeOQm3F7qS3I2Zxkjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDm6a+JHnTr2S2+AXWPk0amwp5ADwbmKcmrkAVyYJ9g=;
 b=R0cKYJdTMJXkIRtwrKjyWrwaXPFTumVflxE9JoeDdTWVAqZJIpTaP5Ci0jSbAlavH5mtOA116Cy2teWm6eeUs+zQJ63Nfu+m/pZyBeHdd1Hd8Ki9gRoSyT5SbnYuNIkSZyAcq2m95P7zC0xduk7x1aQp2ktHhJSU8EZGki711Po=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1900.namprd12.prod.outlook.com (2603:10b6:3:10f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Wed, 27 Jan
 2021 14:57:42 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 14:57:42 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 2/2] drm/amdgpu: enable gfx wave limiting for high
 priority compute jobs
Date: Wed, 27 Jan 2021 15:56:58 +0100
Message-Id: <20210127145658.13099-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210127145658.13099-1-nirmoy.das@amd.com>
References: <20210127145658.13099-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.106.115]
X-ClientProxiedBy: AM0PR02CA0167.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::34) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.106.115) by
 AM0PR02CA0167.eurprd02.prod.outlook.com (2603:10a6:20b:28d::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Wed, 27 Jan 2021 14:57:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 80b79d77-b84b-4bc5-366d-08d8c2d3e5f1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1900:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1900F77C82E8F5D7581A5C8C8BBB9@DM5PR12MB1900.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EWa7x0TIrMWu7gQU3JhDDIko/MirBMaMqGw470vMDkiD9gNTz6XT4RHJDX3xduRjxwO5/+4y67+eGZPtVyyMWWlKZn0iPZTILS+fcdnaPBAb2tpVWjpWZpLexKQMfkHH9mF+fXkbNPoD98nuUXqyPKbuCkvv49ayQ3QjMwMP5mdm0elWyfMA84TIhXgPKxxAMv/YbAcsvB8GO79eBpxssilIePum8xOuHenTluY1cwuWsTCTR5IdnCLu377H6GejnjgyRwklBMx29V69+RXrVdb6wpGQy8B11hV+3ypXx/89hYrAya4q1qtPZ6sNsG16zVsCTGKBNMeWKkie8FUhqDZsXj58ktqY9HRAmA/jzcJ9zf5tXppYmpU3nysN5IrR5imM8c4rmC3ZkH0+rR0BAX1k2nWpEYSus5BJllDfWqV/vW2HQptI6ICRQHfsKI5hxn4A71uAVpC7hBzEbM7v6DT69vC+pOVPBIpinTY1E9F91aL+gRMEXq1M9EXh7WUHAeGqesoHWh5+TqWzva1u1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(478600001)(6506007)(8936002)(186003)(16526019)(52116002)(2906002)(86362001)(6512007)(6916009)(316002)(6666004)(6486002)(1076003)(4326008)(36756003)(83380400001)(26005)(66946007)(8676002)(66556008)(956004)(66476007)(2616005)(44832011)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Xp/U5uOFBBwnOuo+0tDU3WnaUiMotxSdnTRwFy/t5qVbJsV9QtsQp4RPJQVq?=
 =?us-ascii?Q?StemVP09uc/dagry6NVxLVTsxgNdL9vyeHTBMdrBDiGbyeJYtO30NiixvN3F?=
 =?us-ascii?Q?Lz1XBIKtJilmv16QqTRWRmOuzOb1v/ce7xQ7XlDON5mArxupgIaYYKG2nFg/?=
 =?us-ascii?Q?ywSpgX4OF+US9hXfxNRxM6qUdQ4hykO2agpT/qDeDyjBqRYR+86xi3GCTY7t?=
 =?us-ascii?Q?gFqUBBR0S6bITaYW0zWE3Sb0OQFNCiYdvLThXWZlbh4ubEMXzWvTAZX6rR+9?=
 =?us-ascii?Q?HCluoAZCN+DfQ/w3RLzyZsNeuc2sTaNORa8X8UDEyK3am41Q8KmiMEFjqlrG?=
 =?us-ascii?Q?QTZ+ES6LU6nxtYdPytb1zpKjS/sMijdVek87mMMSTNU3hkbEoF6qxHqDZteq?=
 =?us-ascii?Q?+ITIYIuQzgnPcJBO6BDM4nK+OT8mHPWgXjHyi3arr7JlznoBSfXYoZUS7Nad?=
 =?us-ascii?Q?TkC6yx28m8029t7hvDQ6mgntmttC6yCKChJUN2SG3dKXpDaNHbqjKyEbUdNK?=
 =?us-ascii?Q?g9K4e9ugOxiU3dNcrcIFBLW7lVMAfDuNmKHoE3b8mvoJlsSyVGlDlVv8SVDN?=
 =?us-ascii?Q?otXMDMxHWclpLhR9C0fQnn6YmC2/QtKZsq4a/KeKP+BUUy7WzHG8nQFmo0Rj?=
 =?us-ascii?Q?U/G9D0GjrCCC1E86Emrb7vtXoJOZLmihipYZ6N0JaabIzcnkwHzhOAXPRCQL?=
 =?us-ascii?Q?F2fW+TYqDYtP1gfvzElRCTXkZ1K0WbkblACDEUq232M5l89SZPzQ82FT7Jws?=
 =?us-ascii?Q?RP/Qr4mlzlBGrT/atenxlZtjjiiuG/v5aSDijnQq+jMnM78ECZTOYe7yJpM7?=
 =?us-ascii?Q?uYIy9c+e9eIhfl175lk2G1/ZPoczhlbAOKEfdnWzMM+7Z3A/l6GozOGRluN4?=
 =?us-ascii?Q?kuhGDNegQe4VzJfWkwTW+WnyS8JZdLy2z7txP1/igkaornFvbFgiwfNBgU4H?=
 =?us-ascii?Q?k+zd552sn//epK66IO3yrADulJvgjsKJ2dybZ6c4SbXXbrpPT269ZpveEis4?=
 =?us-ascii?Q?WQOJsjJ67dFX9o4LhbRNizy19m5+KsF7UVK4Tuaz2ZVloSI0ET9ucmJE9ygp?=
 =?us-ascii?Q?YV8qN4Lq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b79d77-b84b-4bc5-366d-08d8c2d3e5f1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 14:57:42.7861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRLiPzkUk7pzHuaKDxbQZdGjrB195NXl1j6tdmh2hdnB85kN6Bn5oV5GYrMYeJ2eIahRuOCLGSodCpQUNs3ovg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1900
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
Cc: Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, ray.huang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable gfx wave limiting for gfx jobs before pushing high priority
compute jobs so that high priority compute jobs more resources
to finish early.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 024d0a563a65..ee48989dfb4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -195,6 +195,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
 		ring->funcs->emit_mem_sync(ring);
 
+	if (ring->funcs->emit_wave_limit && job &&
+	    job->base.s_priority >= DRM_SCHED_PRIORITY_HIGH)
+		ring->funcs->emit_wave_limit(ring, true);
+
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);
 
@@ -295,6 +299,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	ring->current_ctx = fence_ctx;
 	if (vm && ring->funcs->emit_switch_buffer)
 		amdgpu_ring_emit_switch_buffer(ring);
+
+	if (ring->funcs->emit_wave_limit && job &&
+	    job->base.s_priority >= DRM_SCHED_PRIORITY_HIGH)
+		ring->funcs->emit_wave_limit(ring, false);
+
 	amdgpu_ring_commit(ring);
 	return 0;
 }
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
