Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC869C43600
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E8461059
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E8461059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523166EC7E;
	Wed, 12 May 2021 17:32:11 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB45A6EC7C
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rb90Mkr6tfW6HqMAw6haBLn/js2f5MFyY1ZWcSwF8a4csDVp3CBBvE+FX8BkO44NVe2HA0IopfLbAB0/TzTnUrilhfwMqVKko1rkiFJUBgofQBuSFbknJWZ+0dXd5GdVK6LBf8NKfHHVOgQjepkZF3UsxiyRJiKH7ZWr2JQJdPMt2MW298AoDu6xrnFWk8UfrXsz0bdUsFEUyjk3DS41RbbdmDmrOiNhC8mRcnZPhHINySB+hwva2W0pWqsOxY2xgwrXoaq9nrLrMpgLwgpOVs3sBoy4oNndKy6q7g5VybTMLy6XphYcYSVL7Uelm357C7Th5hWfaAfUTXhaRwVOgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKf8sLPInSB6PEvNMY46B7MyhX//OiBIK7AvBYlnMC0=;
 b=bELPhPZGHxSNPt3bAPLJa/4SgHOFX9pb7SentBqtMPwxg6TuV2l4n6zxoSqrlUiWXNjk3PNfBefdsvJmIrMWneNb8yNwlWAdOkOFT9Pk9Xw/nHQxuxHMXSEf3+9gbyfxXPLSqwRHd5DTkdgdLaa6zSfIMnyJN2MoXzAth7XajjQjcxpQRID/WKm8gU99+87r4KL1rsvNryXs0ss4LFecWCdMUJuvfRWdpcfYx1mplKWwGwmatQaWAcbBlPusaoLXVigbpKVGjVluG+VAIdVfnnwMa3ITM9kMPA8mJ9ekET+yCnIjzIktifaKXn3h0NoI8hAffb4pH0zUkMTuBu+vVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKf8sLPInSB6PEvNMY46B7MyhX//OiBIK7AvBYlnMC0=;
 b=fzK5+IPohMt7QXjTZ7zFqI5NlXOtgcXYp4DBC6uiEP4pmZ5mdZNUDSpSlUnRjNknW2WVjTkYaQLerrQ7+weQwLFqfJONRa2F+LDlX8/j1/1Wp+uGLy/Bop8dWxk31v+B8MbSlyhcV7NYuWEnNyOhJ70iC6WTJ8rLUjSpUXP93i0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 17:32:07 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:07 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 35/49] drm/amdgpu: enabled VCN3.0 CG for BEIGE GOBY
Date: Wed, 12 May 2021 13:30:40 -0400
Message-Id: <20210512173053.2347842-36-alexander.deucher@amd.com>
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
 Transport; Wed, 12 May 2021 17:31:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6405aa3b-00b2-4a21-3663-08d9156bcb19
X-MS-TrafficTypeDiagnostic: MN2PR12MB4079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4079189D0D6F899CD50F5A23F7529@MN2PR12MB4079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQM6Dtm38PfUUi/rUVTV4CPOk9WBBGqmagPCqIkGeVxD5ZXNJ3l3aUpYte+tenKZN+WpXPAmUkUfMV8R6vMQgT1n8rSwKNWFV2FCp2cHlTyfxpcKZyjBzk8YAlTp+qhsHOuKg/NL2nT2pql8cFjnjTlxHgV+XuBbOdjRpWtPi5b6gn2a5RMZa6N5A/c5mKAxn78FX21f6LspUB4YzmPH2Hge7lRA1tmLkgQz7NiQkOv61PARVNv6pdjI1zGxQCwbc53e5q4N9nJOogqXAx9gkf066WhnTnR3BQ/qVUaPgzKuI6H1glwNGfRTCEi0SYvuuI/i8/OLpvNhICE01PjfAm0x73fH2dVkx+8lG70fzdOaPFwvQ2e/LD+IfCMmXhkcaDehfZbh8QBCc+ApdiQDDIA3AYI+WEDbFJ+SkGOw3Xzreimjkk8md9Pbvm9Ek97FRYDu5bBLqBj4/k1hDMKXesrjHUrFz8EnIO3HGOpnixk/2Yb3VTsEOeE6G0AHWedaPXt6a0x/+kGrxVpLnpZJXaEkH/SBpO5sTAHvRWsNTlQhlR2w8RHm7NHb8rhHR+wKbNXiMnXV0R31RV7weuJUmq0KDBjkoaSof+7kMgUqm4vcU+UVXEocfbiB7UM9IllgYE6v+iUm8VM3TCv6yncrF0FHea0gXdrCNxslIgbcrdqi8yxACQTTquqV8aHYiZPe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(8936002)(6506007)(8676002)(83380400001)(86362001)(4744005)(26005)(16526019)(186003)(52116002)(2906002)(956004)(66556008)(2616005)(478600001)(38100700002)(66476007)(5660300002)(66946007)(36756003)(38350700002)(6512007)(6486002)(316002)(54906003)(6666004)(1076003)(6916009)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GfpNR4FoCGjdYrF4dTYjtx2rkjBN55sEHqkuwi0C/dU9lhlGpHpeOhMseMc0?=
 =?us-ascii?Q?qrW9ryKLzo0C1Xkz71e0FOViVgwuIr6BS5yi3I9oM7sg7eCeddx5oWNzVa05?=
 =?us-ascii?Q?YIEN8NpHkNd9NAHzqTOmmQWAjNwUgpdrnoQu8XeA67B+eRfagxRsspicGJGs?=
 =?us-ascii?Q?Q4MYEmTZOTGj4hcYcq1RLDk033FP/uElYPR3wNUfL433KEx+it5968xz51cV?=
 =?us-ascii?Q?kqVO55RZKNFKiRDd0jWNdCF56CoD7tgLSBXjgvEVZunkYUAvHFx2i9Fz3ky8?=
 =?us-ascii?Q?697uvjekIrzCQIB1rC1qJj0ZU8jHyA1TC5gClRyf3aOUuxCilU1gek10xY+m?=
 =?us-ascii?Q?PRTw5mGjgME7d+hXeMJbT34U0oU7fMzFiQs6fR0DdqzrC9WsFcRla3lS5HRs?=
 =?us-ascii?Q?TVCWmgjRZidHj57lIfK8zcv1KpbtgRWOXq2Iq0xvqOlAfNkHvpKIhC/cMVkk?=
 =?us-ascii?Q?O1+e1MyqqNhGtL94vKnQPvXkDe3/VeCY6Jf7HzoQIJOqAUBkT6JMOn0zsdNd?=
 =?us-ascii?Q?iy0AKPuYJRXSRQ3fr7UkL4Qm24TVpANlap4BVYr2KqzBZCGJIRUkVianMhJI?=
 =?us-ascii?Q?47Jt24dZaF/zaP8IjqBEWCjSLdb3u6tWNMniIpEeW/SKWswy14VNx8MTYy+S?=
 =?us-ascii?Q?Y1VsHWOqe+5s7+fqBBwwj/4uJWHml65njk1ggiChwJmZq7YuBhxcxIq7WtmJ?=
 =?us-ascii?Q?d6QphJgOHekDSlyR9Nvd9N53wpcVqTiK+65jqrbAiErYPJC4A8WbvtfhBAR3?=
 =?us-ascii?Q?OGCcsJTS8vwl/r5QIgwIDcMnmkDGPV1EfZ2T+fJrf8gHfdJQADdRTbQAupEH?=
 =?us-ascii?Q?zifAjoho37xvVBhUeiJ9H/wOf3cFAP1/IysS6xAfRe9SxOWZoHYM49TEkIka?=
 =?us-ascii?Q?njGB49qIlZwLIN/c79fX+8PTdv2zWggEzWnS5g0ChTtdWrvRK/B6Y6i+z9/T?=
 =?us-ascii?Q?3VRHDu2RW5rjtwu2S7q3Shvk9fwW/hACz02lm1mSE576oYu+Mn0a5nMuVOCU?=
 =?us-ascii?Q?JREAZcanlnHDKC2cLhSoRY2f4fhsmzzzmx2L/uLkOBhfQ6DlGxpodqQNIcWs?=
 =?us-ascii?Q?lBAgHRnYJb+kS3+2nlDJQPP1cNX9Ay1v6AU9blNcmuXY8q6lD4MDxHjq4zzn?=
 =?us-ascii?Q?ULXGgfdnAAbIbsBQNsTnuqR42ND02knfQwlUDiQPwC/X5xA9SrLlxoQhmZIH?=
 =?us-ascii?Q?Vs5vTy4QGB5fOVWPS/3RgYa/nW+GEyK0GWzpK583CYj1S1bYQE7AYkC/e2qX?=
 =?us-ascii?Q?81GRrUR9dng1oyE/t5g1L2gLaHObTzV0NxiSp5tCvfJkyqpOW+WqMp93NNPM?=
 =?us-ascii?Q?IzCVFIvBCUv9a0up+xL3Tc04?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6405aa3b-00b2-4a21-3663-08d9156bcb19
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:36.4240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yc0Xz5CbcC4/Zk/tyqdySuGDqrJ8l8ByyUrdJ4GfEwZC6Bedlj6QllvN+R5mKB1Qg3nXT6i7fa3UbnX3TgBXRA==
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Enable VCN CG for BEIGE GOBY

Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 7fb65f936951..a059789b00ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1179,7 +1179,8 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_MC_LS |
 			AMD_CG_SUPPORT_HDP_MGCG |
 			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_IH_CG;
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_VCN_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_ATHUB |
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
