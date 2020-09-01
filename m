Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1C3C433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 19:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F92D2071B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 19:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2fMLgFms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F92D2071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 810FF6E8F6;
	Tue,  1 Sep 2020 19:45:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA88C6E8F7
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 19:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdWljrgYLt5atFRDNEEJjG1xfXTABybzMHogPR7AswDKR5XUrte/xZ5XYwDVuS6bFhGPgE0yH2Aj3Wsvf53B2iFO8P9YTPi4QcMaIcEwanYfRgcHxfTxJ1FxmfGoem3R4g9G8qCOcwx8eJKx6CS42/fSWCy2Q0S7AW3t8nIFiYNSiG+12OcJotkRmF1G5hoAirbaMZRWN6NfezL880Co4hYByF/B/GdB2iMkdsQRHfvh1JUYypFkoVLUpg5Q1eytlexnMLaeFaUg4DXdP2f7nqcIxJmRXlcUIK+VQXl/A9YbCtAA0hkqhY9mOKpxj8Mxs52heOe5oMQyOc9MfuCFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpQSnh3voSuNFyMKlBMRrBix171dIMeIrTZzmeWOa98=;
 b=Bv6shXeArESFhtb41/KPJimlpogLCp3oAsYaTP9tV9FcBD+aSvT9QbkJObvym68kSNDT186nkqxClYMczQ8gouV0fvMx63rRNGocV6oIBVgqaxxWnBegcPjqI4KTIvCfU4kkMXpNHVLX9w83gihtJm5/x/+WoLX56qo2t6M5n3bNXDFANpTyYX3jFaCVLXgaEaM17IXsjhIFZXzIaVAygXBuPeLLFepZ4dnd/0aRKwXfsG/zM4iCmjkydiYY10aKF4KIfDRgg0Q7ZlgdUjTgMt7jBvoCxLJHj+N/uswd/5C3Nl/37LEUKdk4I6qt4qIMtQEoUnLh/3ZyKJawQEsftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpQSnh3voSuNFyMKlBMRrBix171dIMeIrTZzmeWOa98=;
 b=2fMLgFmsyl70bOSdZhBZiEtKsN4MhbWlkHV6YKPNg7UGF8o1l2+IdiNfXUwokjFdPG84Mf7KVPNR2qtCDKe+QY6B3jXYPPOPR8tFipzBO3gTQcNPyTyetSmub4D5Mmh2SeA+xq8elW83jO3zKPeaUrxkOI3n0Gc8Z2DTEaeLXBs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2519.namprd12.prod.outlook.com (2603:10b6:4:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Tue, 1 Sep
 2020 19:45:37 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 19:45:37 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: disable gpu-sched load balance for uvd
Date: Tue,  1 Sep 2020 21:49:28 +0200
Message-Id: <20200901194928.22386-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901194928.22386-1-nirmoy.das@amd.com>
References: <20200901194928.22386-1-nirmoy.das@amd.com>
X-ClientProxiedBy: BN6PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:404:65::27) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BN6PR17CA0017.namprd17.prod.outlook.com (2603:10b6:404:65::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 19:45:35 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd043ac0-b062-452c-2c05-08d84eaf992b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2519:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25197A812A24459537B13EB48B2E0@DM5PR12MB2519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3BujD8nAZn04O9LNWQ6Cutb54NfDJQe/xfMQF8fcteDmtXGfzb/z3Jg41Prhb3hS2/umqZrkJq/Q225SKIIv9iurxCJeMX0ytS8zNaSmemkaRBsNx6d8cv1rvtA1MSWjArU9iRLGO4G3pIGRma0LdXnmpQ6P+zkoUCEJPyl5lC5ne1N/UcT+gKE/VQQjzzlUrhm7VIfyJ5EPMNyA6MYUEnAL7gLoXL6p2D94KtoBhKf41GCgTEsZuf9yGlHOLElxE7xDeRRLaMnAt0yR9esvbedJdIK9wDVU8HHFW164la+aBiULw2CyMoxiEUGFj+i7xQKvHi8y5Rt8Lk3EEIHRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(52116002)(6486002)(316002)(8936002)(86362001)(16576012)(478600001)(2906002)(5660300002)(4326008)(956004)(66556008)(66946007)(44832011)(2616005)(36756003)(6916009)(66476007)(6666004)(26005)(83380400001)(1076003)(186003)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1ClrOaVsZdsjSr40AC1gvKMIdZXhH/lcoX5unoGT084pgaZ4hG4OgB8BIM+bSgcDC4ZEL4sNqidhhXraS5/tQOq2upJGWy+jVK1LQ3wDR5p9yvQzEObQ2TTYY52CCopsJ5a+DQRyvdLbQ/EBCw+7hGqwSqT9UK5Dsd6WU+blbBmJkl/4Nahl60ehaqNuy7TtGUhiEL8SszlmtrN1Cyi05CuA7hry8Qoz/VG3tjpQ2GZPCyPbasCH0l4xoaFeBFD647e9dCCObuVdwd/uiUqeHICoWt6xNycdEqqpb7OfeNjWcrFpV0XOUxEFNJR8qQgpfLIowy5HumUwB05XCo39A3TGwih0U4WA2nY3UZnTZZw2q4EhIHziXxlZqStgA+x/DkGJ3AzqZjTpA/FwrQy0BVCFi6meu0eM0XX5eYvzSFkhdJX+n5NUx4a4aNXwjdCsLXMpesvwDtLtAWQgeXLAiumuziODLLr71K1HX3uBwHfCDQEf/kgR/CmmLt9vgCxCO9PMoT5wxyFf+Ob0QEyAYB/lBP/XZ2ofkfSOXExQmZUoiiypN5/TpQCySaMR/ZF0sKCteG+ITv3EHY/JiWZg9bJMBy0G6IyniNglbrFnNq3Yr+n9Tf/nu5K96n5IuDHZArvg1+0bHytllj16ObYaOQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd043ac0-b062-452c-2c05-08d84eaf992b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 19:45:37.1930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQwFt8/WBRv2rAysICAl4etIRBJDlyWcEYsDBjXLXRrJgd23ZOPCwojTk1Prhyt7CbbpfDxhnnyWPlllivpJZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2519
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
Cc: Tianci.Yin@amd.com, pmenzel+amd-gfx@molgen.mpg.de,
 Nirmoy Das <nirmoy.das@amd.com>, alexander.deucher@amd.com, Leo.Liu@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On hardware with multiple uvd instances, dependent uvd
jobs may get scheduled to different uvd instances. Because
uvd jobs retain hw context, dependent jobs should always
run on the same uvd instance. This patch disables gpu scheduler's
load balancer for a context that binds jobs from same the
context to a uvd instance.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 59032c26fc82..fc392dfd1789 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -114,7 +114,10 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
 	num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;

-	if (hw_ip == AMDGPU_HW_IP_VCN_ENC || hw_ip == AMDGPU_HW_IP_VCN_DEC) {
+	if (hw_ip == AMDGPU_HW_IP_UVD ||
+	    hw_ip == AMDGPU_HW_IP_UVD_ENC ||
+	    hw_ip == AMDGPU_HW_IP_VCN_ENC ||
+	    hw_ip == AMDGPU_HW_IP_VCN_DEC) {
 		sched = drm_sched_pick_best(scheds, num_scheds);
 		scheds = &sched;
 		num_scheds = 1;
--
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
