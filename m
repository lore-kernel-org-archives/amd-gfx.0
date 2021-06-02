Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF19C47093
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D202E61C2E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D202E61C2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E0866ED8D;
	Wed,  2 Jun 2021 16:49:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E346ED29
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEw9JK5W6unGxwxWj9YFdr6m4yFeTAuVV8KWTQJok4CMm4KBl2b3mxmX9EQ6u+O6kkXIJmEmYTlU1v+ME0YDxSR0fLQ6anoclWyINKf19eVL0CqNusKkMfqLpRTwt1Pp4bv+QpMCabbyWCkW3k/1qhjLLLcjR1zNnJs42CV7MFSgEY+aozf7s4rM3lxicPsoE/7DY38fCRxJvRP6V6dOnYEaB9qiJFTWKTcDnRfQTJB+1d0cXeZo4j0UMxmQicWohxHRxCbYGlQFEm4N8zwPb920wJneS9z26F2tTCx6klEtRcIQSTYqIvXXGZXUKkSV4X7fLH6czsTFmHHaWSnnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnKR+yCH6QaCglNErsim5bQeVa/B8lGLIyAbDcGSnH8=;
 b=UxzwtrtUPsbc8hQUCQVuth/KrrNSvN9+STSb1Fr2nVnGnrfsTxSFjwu6RiXhRhlsHIrQmzVdOU9qyXyQEqiJPK/vVCIUGXMZgXuO88iP1UNxP3y0yBoynQTpBpIo2J4AzljccaXxfZSHO5Vu4/VS/EEqCZiKAcHQ5Ufnv74xG//RnJQcxa3CvXFH7CaLdiDMGE+UUuEpjueoQBA9pPPAJbS2M0NmXP3NLgo3D8tm/eZKs+uAAQunleGjH25doKszfDDGD0a+1IZHC53UrVC2FnrB6Vb4zWtb5qkR72GfTHSqrhiE0mWDnpi48IHfiMP5EO1PQ9KmLlR8t5j6U5AQ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnKR+yCH6QaCglNErsim5bQeVa/B8lGLIyAbDcGSnH8=;
 b=4f5JN2d7antvNqHsGQvgo4XvBnFYnUINvHPUeUyGbAGl/4mobHbYKnoGLXU0NTzlTOYdsTkgLHGm7phEI1k5EhFYaZYjZfh7SqlY93FbdK6p5v44PNHX6EEigyhzWUjstcVb2DlOEILUSCLQHW/eDHw44GVfjC1bTRsihDxVaa8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4533.namprd12.prod.outlook.com (2603:10b6:208:266::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 16:49:42 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:42 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/89] drm/amd/pm: partially enable swsmu for yellow carp(V2)
Date: Wed,  2 Jun 2021 12:47:59 -0400
Message-Id: <20210602164908.2848791-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74ec01f4-26ce-4a9f-e052-08d925e66af5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4533FD486AAFEB28433B53D8F73D9@MN2PR12MB4533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3o9pG1mTy4Xka03014NyGv9tAcSPRCKtn8VXyYrbZttanMfR/gZ3fzEQSAD6jq2AkYK/KnaxQ1C3BuWVT+T75UlRmXU+u6XDKVoyGIxnjOSsIoe6h+NuuCJ6sjHLlLoT5uisTWTZjj2gjz5ZQ/n6EVS3+froBDAgQ7CCI233quFPvMFHndMdJrQXoQo4JOhldciIaYBlxl6zoWJ/XXXgzIQCj1Fht6wn9wtgsx2JQukbScr/JHrQe1Mave75QOt1keF2V5rbQyIfodME67TO3l05dmYGlpMCAktZBdq/8na7a0+TnZme7/4+M6eLisvwCEB3osnLbWDuMlgfEFLXO526AvsdZ/oW+ShebSQ3AmXVsMfi6Inky02U/OB9U38kJY/EQmhVdFmA31gbecW76pr86t4AaWTpm4Ew8DhGyXWZOrYVbKVMHZluwRgJJPHyJWIuq01OyEK3+/gT/e0Rc/OD0zJhJP6N1G5O9twD3+G73UkOu/Skg0MlNL/sCSVH/nmE3Mmzo8PJ7ec2yds+HzinmRhGnA2lNq/yyD+b48ftIW0VGVFw4605fNlAb3H2L8ZW4Fm+RIbtpOr3e+nr4BAaIcd6CDE+wDhyuYZY8uyqb00275Ek9GwRFbSl4pUY29BWCw7Bnphar+NOO51zs8lOPbF5A3U/MVOQrKSiwKzapFf2nojiwyGliEi3uCaf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(4326008)(36756003)(5660300002)(1076003)(6916009)(52116002)(6486002)(8936002)(6512007)(38350700002)(38100700002)(6666004)(8676002)(86362001)(66946007)(956004)(478600001)(66476007)(66556008)(16526019)(186003)(2616005)(26005)(6506007)(2906002)(54906003)(316002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hua2PVP/lVymog2U+A726lrPAYt/0dRcoIQ+vU/KL79b+X9DIWV7Fjh1chHH?=
 =?us-ascii?Q?lHlpBn2s9njWd0+6ov4e1gUTdWhdbyJNDFQJvtE7DjsvHz0ynSbj/jxO1i1s?=
 =?us-ascii?Q?grimDcyVtEJXtoGmZyXz0eeFW1ChysJdsaPZwlFIW2HMhFUHgx6vpcoc/r3q?=
 =?us-ascii?Q?X+VQR+kFk0K5O5oiQSEzfPr+NynsFW13BjjW+Jmb1z8wGyjTcI6VqlIWFnmK?=
 =?us-ascii?Q?lNc+/p2+GBmdl4QZpfeT6p1Acng4A2DGUTsUUE18l0KYX38h145PK7vAK9kY?=
 =?us-ascii?Q?a2fHq09KTK/JQ5BMvN4l9MdWzqqWMhUJ4w0CW846oFcvAiL4gVV5WUfzqB4r?=
 =?us-ascii?Q?HY2W02SZhhC9nW6CP+Pwq1s8XvHA3E5uJY6xFXChvvwVzSF/e1RJOymdLYY6?=
 =?us-ascii?Q?X9euws1k0jhSmBYkgMEI2+YBRj0bja3OdWIBnirTa26FWDZhN//+g8JvhEOW?=
 =?us-ascii?Q?2+n158bvRqYfDoMms6d4hX9Cksq68yGWMZ20SNrFn7R+M4A28rV7qvxbE2Dp?=
 =?us-ascii?Q?MY2Li/8N6X/QtMKtaBxuDTcowIqDZV6alniUd1howYTcogEnHiFXpxa6OTE1?=
 =?us-ascii?Q?+XdlJ9itoV4QjkDCtKRw+lIjyIo1OIdsvRUWkFyggoWL/wySOCfA7sfjIt5K?=
 =?us-ascii?Q?sw3WjakLO/3sKHeqH08qPqWSrOWLNL00Xmt1OukwPMh026dXeJDJacZpb11H?=
 =?us-ascii?Q?ml4yBkyWRbHYhVuClu89Xz0jPVnwTocebhrsDLRNy6OVfKdxBHdOczByg9Dv?=
 =?us-ascii?Q?GOPFMJwHOtYJUItUPz+g3HwYTuwgB+mLtNyLLsU66O7ygleIUkL6FJ8+nvjp?=
 =?us-ascii?Q?j3gCkJz25vMyQlV6JzdVbUtkcrJIJk8VOkQ8kMY10+aMEv/tXm4xJbS1zlcH?=
 =?us-ascii?Q?yoAAm8Ew/78Ft9y6Kn486v7nIwTqURoFI3Ay9gz35wLANXxd4iwSUvkodxcF?=
 =?us-ascii?Q?T42QF5Vl84FMalR/rFV1tTv/iriftWLp3eXnvZsPP6BXDV2LrVknkJmcBV9T?=
 =?us-ascii?Q?ctqFzVVyJVbVMr8kW3ola4D9x7BqhoYT3kDiy9qLHo6X8UoQUmAK/MPh5km+?=
 =?us-ascii?Q?gBYAkYvpsWunpj5rp7r0TDo/x9CGJzkhq/DcARgmwbniCznxDqLMBsHBTjtk?=
 =?us-ascii?Q?wD2SpQc2jn2Ly7GeZSaCZRq+HvsekcM2v6ChOGSFWF4Ik4WcaXWmvtsj8Zig?=
 =?us-ascii?Q?KkhPzwR3BqNNOVgrvfIel1LaMTnf/Fgsmy4n7NmrqbPaAMPfY9VgbtKDk/pj?=
 =?us-ascii?Q?WGUhiRH2niLdylULrKarc9uV6tXAXLtLFoAd6/i7C1ENOUHGa+eXffJll3Lv?=
 =?us-ascii?Q?lPmx1sPf2Pb82TfMEUokpMKK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ec01f4-26ce-4a9f-e052-08d925e66af5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:41.9060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWbn9CcgVdG+lFGERLlPxEDlPV2QAYdbLccIMYTH2NfWNx4BDMjz0ToFSEqwrOiQME93gfydsfzczjhS+Reqpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4533
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

This patch is to partially enable swSMU for yellow carp for the moment.
V2: rename smu_v13_0 to smu_v13_0_1.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 285849cef9f2..2a5c109c0d26 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -658,6 +658,9 @@ static int smu_late_init(void *handle)
 
 	smu_set_fine_grain_gfx_freq_parameters(smu);
 
+	if (adev->asic_type == CHIP_YELLOW_CARP)
+		return 0;
+
 	if (!smu->pm_enabled)
 		return 0;
 
@@ -1303,6 +1306,9 @@ static int smu_hw_init(void *handle)
 		smu_set_gfx_cgpg(&adev->smu, true);
 	}
 
+	if (adev->asic_type == CHIP_YELLOW_CARP)
+		return 0;
+
 	if (!smu->pm_enabled)
 		return 0;
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
