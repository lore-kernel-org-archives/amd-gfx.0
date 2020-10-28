Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6B7C388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 15:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8922C247BD
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 15:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w4B8237t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8922C247BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B166E578;
	Wed, 28 Oct 2020 15:22:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C57B6E578
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 15:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3yG+1BACFO7y1DTPV3y26yWjhdkEjD2Lnoo87LbTxy4WbbZ6BJ74XyPlEhcOtdocLBKYkx4fEPEU7ZeqBd07HoXuYq2OqgFsGG8+ohufn8VAfunGOnK9n+NPhv+DVbAHs2ia8qe1p9BBL/zb7kYpY4q7H132YSy3DRhOC+wGVc5rFThZEnTkYTsJ6fS8DbyVVAiH6LlFvE5Qgs7EjjzFxcCq7D4HLRTNON3yRFHLfIKghQo+TULIYAWJiQ9PM6DqvQPDy4dXLK/FPtIgkq8dsqE4khBQA3rr3fzHkYV1anrHdvE1+GqUxEQ672nN60Yasb++klg6gA582jgAQFx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pp4I9KrGOpePPb2DXVcTwWWbJTTnXN+LimIFBw8GO+8=;
 b=JQrYYm7etTzWTiCm5vLVCh47Oe75fefgnvhPx4T5HVW18EhuUNscZvmtP8ZoW9AoR/m7UFa01p9HaPEbhY0dT6y6Th8vDP3QuT7/5fAeH5vzRsJjZWBtPSKHx31HApGFVce5l6OVjUZNuFf6bMomW1w/vzWq5/+6Z5TyI1+Tvop7MPGveqreIJ2QfQUTWN+EwAgz48MBIYmrP2l6nuuvNuy9La8VQcGSvTAhp6zzfGZA8ka9ZoRYKnu+IQ7+FRduoCRgbtVfQ8c/s572OE9VKijwWzJ7vM8I5Ys2Yw4Z3ee55K6amKee/DXM8rBr3r1ByBaxVTB6t/hOg3VxE2GB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pp4I9KrGOpePPb2DXVcTwWWbJTTnXN+LimIFBw8GO+8=;
 b=w4B8237tG2+FH0OHrJjpKXyqI9m7hLdxXUEMKdRs2rTxG09HNxR2qORYB+dMcIN5Gp9zFDkX/tbjKdHaUSqf3YEdfCrdm0QYsaZM1L4kaO/suDgCqsQdAezLxAARcIGESzdr8yyF+NSYuDl8X+HDZsTqnaXmhLLrpgWOeXqjBtg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM5PR1201MB2536.namprd12.prod.outlook.com (2603:10b6:3:e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 15:22:37 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 15:22:37 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdkfd: Fix getting unique_id in topology
Date: Wed, 28 Oct 2020 11:22:17 -0400
Message-Id: <20201028152218.18485-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::35) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 15:22:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e056903-14df-474f-c0ca-08d87b554d79
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2536ED45A06A3826457D24EF85170@DM5PR1201MB2536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +aDsY6mP8QLDSSaweAQAJ85G79KDB8//Xdx05uzfUDUD8BvaG0VBpR2YudsGnC3/1kWT7Z+oc9ljLqAEYdanlyPYNJUKWe7tIE5AO6Aahs25nOZp19Uakmx5keVd1rXcgRVNQ71z5fjZiosomYeDlP/l1j3p5tnOmD79rDAZsZhmO3wZjf2wIb3ycQWle9nRzz3CZp4ld7c3evQcXhIE1PqSMd/WPIWf2PXx9I1kWkbNXDeKX51ptXRRz5VgMPUEUAbHg8pdJ0md5Td/HwRMp/7+7XPFJM0awvW4ySFpq885UIhXizN/48JqPv3AdD8/MVEjcwUSBryXTBGlRWM7UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(478600001)(186003)(316002)(44832011)(26005)(66946007)(16526019)(8936002)(8676002)(6486002)(66556008)(5660300002)(66476007)(1076003)(7696005)(2906002)(36756003)(83380400001)(52116002)(956004)(6666004)(2616005)(86362001)(6916009)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pjPZO1/WdsEaTSSBrHYxmnQ5V+vUvypedVEpjdzYos2Oj787D1x7ahiRYv1jV+/hn3i0FJqRiAtvTOCFLHP5Zt8bMrYUshtiGx60soKoMNov7+yWqrfjegZDvmWexmdY0uksGITem+JEsL+lESx0YGCm0Jf1BeRtVb/c41SEzjMkyuEOS5cIvaFj7I6gGDZsqy7mSLuBKCRfdyYGlF/o+pw40Y2NeQ3ipGNKw+vErvM680uZ3weM2BZCdI//5EnuSOCvNXXPid3j0EqEUYBZ30IfLPt7hY48dYcfljdqAovhmZ633xmN+GRbdqlRgxpPOCHHAO+eBEM1gv4KknVJmBjrtLWbTqYFJMRzV04QaKD3ZFo4UeeWs0+CiqbRfS10I1wPRaUP3MI/Cm/TO55qPUcUbY9EzPlGkkRxi3kYtNgLVLDk8mARfRC479FsMeeoqX12aBmRBR5esIjeWqr+IaSEgSHXMK3smv5S7tQkPAUH1qIvnkeHwiZSmKT2mb1P1J0AUq1snc3KagD43XzyHofcjYDZN6Q1ytZ8slObQ4DQ2V+mfyEDb6bjGmqILPSwX7dtxrGE+DYQDRj+KN9XjLy4ib2Zpq0b6gveC3Nl6sfz1uKVtlhvbHTrRCp07oK0fl1T9sffsVd3JWVkatr58g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e056903-14df-474f-c0ca-08d87b554d79
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 15:22:37.7455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lErIJ3OE5qR6gz+3z4XxaxRUz1Ex9nSIAw8coU74HbgG5P3ASBjTtPVoTq8rbh1xIVJKCCChkBe4Jy0c02+2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2536
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since the unique_id is now obtained in amdgpu in smu_late_init,
topology's device addition is now happening before the unique_id is
saved, thus topology misses it. To work around this, we use the
amdgpu_amdkfd_get_unique_id to get the unique_id at read time.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3f2aa055c32c..a3fc23873819 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1340,7 +1340,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
 		amdgpu_amdkfd_get_num_gws(dev->gpu->kgd) : 0;
 	dev->node_props.num_cp_queues = get_cp_queues_num(dev->gpu->dqm);
-	dev->node_props.unique_id = gpu->unique_id;
+	dev->node_props.unique_id = amdgpu_amdkfd_get_unique_id(dev->gpu->kgd);
 
 	kfd_fill_mem_clk_max_info(dev);
 	kfd_fill_iolink_non_crat_info(dev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
