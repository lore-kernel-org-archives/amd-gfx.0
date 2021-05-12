Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB9EC43470
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15AC161419
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AC161419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D6C6EC7D;
	Wed, 12 May 2021 17:32:11 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0969D6EC7C
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lb5/BpMXeEOeGcSOtp65rrpXm1zAzB/RKTd4f+qnoulcukE3Fzv3uASkQ7ManM1pCRp8h6SEHqQqqJyYNzIpcVsQkvhsPy3GjlBq2sTF6GwjZn4P7RFki9zlK3r4S5GAgD055mgj7OCZurLurKCYjCaSyYJ7tcWinunWznSmXTGTkmsJ4i2qmCCNyVIrRuoBXZ4Zr6GS2RcuTnuc0ijKma12vNGL1xCrWqsRAwtqCbsCOe3Mm0ZbYdjvqm+doNg5Xs0A96SIeRbjgQGhnaRimJeJSlXPGYo6YCjlYKBYHFXERrS7LB1OvFym3LXKIsi/x5uPufr9ZGIKbvV/mIBjTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajDx/3ruQs1xiVZ1Wrma8XnCcgNow6eWkbwQK0Jb/fY=;
 b=TpWFCsWmzmHL8QEIVRcPdujaReGVtYx3S+W2bP2gAUuesp7AZg5VRiyIe3LkOB0Kx+tc/pgccOEvpUlrlzLIsyMEUBipDT40wR0ANNgVqZardUgOO32+ABVXu22WgrQQwE9UqUQfJkwSB7BngbFYHy/Sb54xuFccfIJMaoow/FBdr58Vs+0uzBvmxuERle3utRCVHTdzoxKa6JgzZM5eJ2JTokZnmDE4cbKyLnPuRGHQs+SPCrMlorLmrk3MREwptIgXIE+3tWthFfDzhZAVdL/8KMEG7a/9Y3LoG2pTtHpMduY41V6zZcniq5GhsoyqpR5UVsKP8sPgngqoiObytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajDx/3ruQs1xiVZ1Wrma8XnCcgNow6eWkbwQK0Jb/fY=;
 b=M88BnzT+6J+Qc5B4aTlVRvmMcs2BCH8Rbb5uO8ecpEF15GNk/o70KNkFSW5O0n2Wh9SV3oc5RYEEjz+VtHvXaTqS5f71H0JuuDkTVIHjiUJMJfhSxUs+SlBMeBkSgbxCzoNERtyhgMoB5+B+y/unO4TtcBz7htM/RuHKqkcEjOo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 17:32:08 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:08 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 38/49] drm/amd/amdgpu: Enable gfxoff for beige_goby
Date: Wed, 12 May 2021 13:30:43 -0400
Message-Id: <20210512173053.2347842-39-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be2ce569-1bdb-47a4-4faf-08d9156bcc0a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40796A1337205DC97FBE8BCAF7529@MN2PR12MB4079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5d4eeCrBXAgWOPuc2dvwvlCuOKirxuYCc5cVc25p39j1ercrr1raULFnOhO1bxUgaQqcLPWD4n/rFAP4ULU54cS7V1btXorWU5BFC9pOuqkoKdZELs3ntRPhOdDGxI66MV8F4OhgbhqiaxiZrEVQrBZoBmf6LPAb8AheLn8C+5N1jNLvU249UdyFyjtLPcZ3M6I0cvmmscaQ0FXCo8mgCJXw0KZIJtYJPNTO5s+DFN3dO+J3PnhtqOQILNqMTrlDKXv6jansTcpbQmEYeLiEeqENJFHTUEGtVA8hmwXH8zlP2qvb+ZlEqwmZgWgMRQsFv7F3ImXyTk1ByyhAagX/+YOdTkqwhe2OePgrq+Z0jXx6YbW8UlO7FNkg1Mw6UyDJ5CepujIEcV6pWLennG20BpOn1dpXLgM+9MsfpDb/ltRgi0DHyu9lpgT+0Zo65xKbMgZr5ReNgJwMJSo0dUVQeuCi+XlBiFvcxhcWLxEszvc/gkxOupqNe5BDjzZHNncLyZL+d5xa0WJCCF45ww7S8IEXin/4u767rC+6mN0S1/BQ31kkJnKHUjkklAYDKsLauOUTeCW+xz0Q9axawbuhy4kNJXCHzwXbpLT4HqMckpQGTNkL5fLBcFDNLfwNuonEQod8nle4dV5TCZKqdr+tZjTW+SJvfhkhxVjaV/4B3bW8UVkLZAlyXiCqDIuWwnY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(8936002)(6506007)(8676002)(86362001)(26005)(16526019)(186003)(52116002)(2906002)(956004)(66556008)(2616005)(478600001)(38100700002)(66476007)(5660300002)(66946007)(36756003)(38350700002)(6512007)(6486002)(316002)(54906003)(6666004)(1076003)(6916009)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lTUzG+BziKZvs0au8dV2nQKigR0A2gXJwlGD4pNhCsKPOS4F7yTKZIJLnXru?=
 =?us-ascii?Q?yOkmaQhaFsR5SPH9HlYiDb8UugAI9lhLMhNLfXXv/+QVi6SRKCRpgSwfv5zH?=
 =?us-ascii?Q?nxehRlutMZKimggxZxz8NgdIdFmeS4NyrXL/BjkeH4VQ7HJToBgaZqFbH7aW?=
 =?us-ascii?Q?z7haBZgvcl28HDEJHeCYa/GquQDw/eXInWCLQk8+OHZZ+Jmd+Vux5Gl0CH1R?=
 =?us-ascii?Q?tyArRiQOuSCl8QwW85BDHq+J6uVMENyRtPhSWeqnZ0J9/l58R7qrZfi5q05b?=
 =?us-ascii?Q?O2+QxK6I0srFIlQL0+FWNaH3+ikWqvFOaqt1nvJEyiJCoJ7wGAjWX/8ya0w7?=
 =?us-ascii?Q?UJ+7JDMQPrLXNgFz+4IHo+0LpEHXuoTNIRlRGxgfOU0KL09FuPoRanYuuHv/?=
 =?us-ascii?Q?lsp22ugTuwX8M4W1e1AGrC6B8w7CTkk1e4qng8pMqj92Jc2/mvcI5MIXrVit?=
 =?us-ascii?Q?nGSgYsbDLJYAdKhtsqT5U9khBPgR5JcoRL8eNXcXHY9eyU70+M7ywJdcZz9b?=
 =?us-ascii?Q?zvCroYsjGYaEF8/M2CN/gvKezI5QaoODW2ymYi+LLTBG3rTfv3dAL9cnL2tj?=
 =?us-ascii?Q?p406jRWMAoBxCE+ThC50M4iBdwoOjOA1Nxg9U4N+pPRenHJMhRqkrAms9k2d?=
 =?us-ascii?Q?0C8Lxntlk1Vys5cMb7tQQaYwnarsKs9KY0DpGxfODgSyTwwd7F63J7tGj4QT?=
 =?us-ascii?Q?VPRRUVSDEwwWogS9NnPeJ7z2ONVdUY51cQDp51q5eaaVqeY+g3YXpGcJAdW5?=
 =?us-ascii?Q?3xKbyvmBR/zwj3SddnFQUzwl1QZddZjXYzav8ExOTeiA6yL1Lch3splk34Vg?=
 =?us-ascii?Q?Gwx5613gR2GpUUR6ltyU8Rslrg9HGkjAUxKz7YKPvo93YBPyiA6A53lE51Kh?=
 =?us-ascii?Q?bX4UoLZN3iLhLB8kFwAgmxXNVl47GQAHEo3NCIe+HWUDEzKPHz29LwxPyP1+?=
 =?us-ascii?Q?KR3cr3HD3nBN83VHqKNd+tLbPkYt/5Ct4wTD9E5a27M4MI55o308ytKN4c/1?=
 =?us-ascii?Q?6xnLcCplDZhbwZuJ+dRx388UYGUGokRUvrs0op8f+PMGA+xhHAR5H9GqQSwW?=
 =?us-ascii?Q?4CNFD82oZMfyoI6A4TalEtS/iBWDnx8Z9RBJsjus/ftBYhJcCCgSZzxt+uzU?=
 =?us-ascii?Q?4qL8VlbzuZxOmvqE+3Gs/1D1YbdzkqtHbV+nBk7i4RJht34fahmr931oAgYe?=
 =?us-ascii?Q?wQpTvlO3IgD2Sk0j5h8peMDzhAkvDgMQhkn23Es5Vs1+RrUp0p6zvKafXz5E?=
 =?us-ascii?Q?RMkizro/zSgfQ9G19N1sjsbI+ysZTAJpPt4PC6gOJBahFz2RpjY/oHq/Mm7I?=
 =?us-ascii?Q?th2W1Ytv4f+cmpjshwVebZz9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2ce569-1bdb-47a4-4faf-08d9156bcc0a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:38.0100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqpaFro78V00NlbgCtWNTrU5I5FabjlpHRhXKBaDt+WzOyJwsYUEAhpjQmZmNOojS5YVWjC5H6XxBj2Tr/TGFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Enable gfxoff in driver side based on SMC#73.3

v2: fix typo 'Eanble' --> 'Enable'

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c         | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 338cd080051f..a04010e0e21b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8065,6 +8065,7 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	case CHIP_VANGOGH:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 9c992f31cdf2..ff1f60101129 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1128,6 +1128,7 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 	case CHIP_VANGOGH:
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
