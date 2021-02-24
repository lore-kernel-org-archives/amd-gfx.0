Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94380C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4589F64E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4589F64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E20BB6EB9F;
	Wed, 24 Feb 2021 22:22:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4686EB9F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQGxSpNSMD+3z8ecILmVqFLyzAL0DWUe88xrVCSFcxGZB86S+irpUwKRwKZSwzWp0MhVble3ouumu7rYxqxkI8JG7IfdBWTyVyKJzzW3vVqjXa6wYKS09PlwOJvicob3/eANeoJls1Q8/hZ10XaPzZX0Z6Xp1xzGYDvQoRhWBLpTwZqmWBVmcjxC5CZcaiv5N6SPXRj0rSI4m/zz1yVVJw21tEBjKJhct7hksSRlDRQthXusBXLntN51zE9LMcqxoQy7bEm+28kfT6DfTMAuZrjOLx8I1uRl6DYylrc8vRTWXCgwVQUSm6dBA95FRcbmjHNg7XtnBuN0qXEic2c5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZwPl43724nj4h5muEemx80YVeSgsDAyACJj278G4aA=;
 b=QXROlMXlRIwcELviZ/EJ1WBZKAKCHP4dIGo1uZoBVLKTE5cAM/MUOGKR22c4KicxGtQwWjt5y/3TaHtiJHDrW3HHEKjSaYnOIuO5lS4gcSkwbf3Q41YpzFMTkcxRioNi3P4vKkXyfDIA27zw141voKjEv2pJV45VEqgIIzicHlK8rE9fskE+o7uaflPeJFrQQT3Mh0FhvCE7+WUW/PckL5JvrBkm1mYCyg/nF98HUVH4P0pByUAb+0pgpY0RoMWA1g6Lm4RzSKNFlXBp+r/hk2lSU3mTEve5dMG1923lf//3/S6lMtNXtTCxsBJ44pv7033rN+Lz7bmlEsITRfM1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZwPl43724nj4h5muEemx80YVeSgsDAyACJj278G4aA=;
 b=wKQnf/j0slGBAreIarhhpEDB7PBSFm7R4F42+qltsNqdnD1tF3gdi0k+nAQcFTHZT64ziTGQJRmCKxYJ5HNLe7QU3e1GddYI3EoqWlcQGNikixbrxX6Ri1I34xTUptJBDtbo8puYGZfSR2cPWletcl+ivsB1KhMZGxH3ULZt9sg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4722.namprd12.prod.outlook.com (2603:10b6:208:8c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 24 Feb
 2021 22:22:40 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:40 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 156/159] drm/amd/pm: add aldebaran serial number support
Date: Wed, 24 Feb 2021 17:18:56 -0500
Message-Id: <20210224221859.3068810-149-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:21:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 150ea488-2d62-480e-8c56-08d8d9127b1a
X-MS-TrafficTypeDiagnostic: BL0PR12MB4722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB47226C49833DD79DAC215816F79F9@BL0PR12MB4722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjAOxxUWuHOnS5wgPNZa3qKZz/fslGsv+4OIE3lJDqhWXxKQB/0RGGWCmohH2uk7wy1Ku60vr9JRTkvA45GHE/whPpF3K4KZm6WoY9I86IckrCj+V1ZLiZGtNATXezMvWzXkZT0RVeclri2ke4u+lVUYccuTCfRuY1MU0bfaYL+E38EkX0resStIq8h9mlPIX9BCOq4N2/rN1zfwlFvmtaJ4kaC/NkRwR3PcTnh/EpKQfbF1GOjw3KyDpMqFnUo6ISU8yulYex1XcYtoqqmCpu7RA2m4Oi/DsWi7Bg/km4s71w4ehNGrdumhZ19nb68z1u4TxjoMRBozdt4YYAYyHzb3/NO51Mdwch7qz9perSvLvGUavfgZoV2v8Wh5oEkfR6wxV6/OfgtfyN/QjGHVfHa5cqGI2VAhz6TQ/zbvHfEGTqqFGJZeEA7VYIavJXYIZTE/PXEtDAY9nNG1g5C+sK74byEvo1uDnzHpF45RoGkKybKfX8/8gUwuo9/HGAoZYg6ZSompa9O++aNElthHwOLDi7WQJK20xfrNQFyMMDjLMUv8eG32fV5qpmKH5VqCtUJqt8iCsRZsQerzPDLnZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(8676002)(69590400012)(6916009)(4326008)(6506007)(8936002)(478600001)(66476007)(54906003)(6486002)(2906002)(6512007)(86362001)(52116002)(956004)(5660300002)(83380400001)(316002)(16526019)(1076003)(2616005)(36756003)(186003)(66946007)(66556008)(26005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UZIXewHpSpNdw0OTcXNrvbYlc402av58+guis6Xhuc+bpVTdUmXUt0/n28Lb?=
 =?us-ascii?Q?EqiSG+ZBUnBiSGSKfvqQWBJbqGMQWwy426+1KPhJ91W+Z9C8LIXJH3Ry/O0O?=
 =?us-ascii?Q?Cw6Z6znnZehC1azm73dH4RBSzBZRyRx6tXjOYgeaqhk5F5T19mmdp8XhMBhK?=
 =?us-ascii?Q?wIIWjtpUNO8DCVpfG604P4u1nEnTjg3NPRKAeThz7yQ4uzEPTGKYEc0TKR1R?=
 =?us-ascii?Q?SyMijIBHg7Izi/PDIOSjoY9/GpBbuzzhBJYJEEeSQWMiw2Pz7kpdsKzAU04h?=
 =?us-ascii?Q?dmALZe3UdzvgR290GGhoDg2ouaU6BsTAf99Eo9iir9bxfm+3SfR4VAqJMkWG?=
 =?us-ascii?Q?4wttrYfnc3jchqU6Ad69gYaYtd/ZEaw3V89x0urgsYcoj9xElOqLmqBnn7/7?=
 =?us-ascii?Q?8jboWVrtEVk/KGpxtqMI/Ga7zzvQsvV4ROWz7/1u/D1sXWHYGTC0Ld3SR/Od?=
 =?us-ascii?Q?2yHBD7uvaONihkzICpcYhwYYYAJGGA72Ri3eJm8JZ6oPFzE6MZHWHzbvFkDK?=
 =?us-ascii?Q?B8Q8pnHq9j5qtTTehQRW1z51yCDIzgfx9M1HNmQQN0cZxJSXwRvIs6I8AkAb?=
 =?us-ascii?Q?fjKgfPQeuZyDVwDbj0Ba8CuO9nF8sa2mbyFFDascfkD4HEWQJv07oodk+Cr3?=
 =?us-ascii?Q?F1XdkgT6boN40qI/AxpCc+1JdiP2wDwaKGyPXdZVBHZUDWbiNso3eusSYDAL?=
 =?us-ascii?Q?Xxr67XaoNWsMZBwwdMSn/r4cBzn6cbBgFnAQLA9dKUZu6GPbpWBpbokkW8y4?=
 =?us-ascii?Q?22Pehxupb5mr+spwSYmwnrE+0U9bfmL3xCG3zJgALzrPHzBQ/QSZoyOaZOUk?=
 =?us-ascii?Q?ceRXk1qtsJTeRZSEt15j+ywkhCLiFHYSZO+VzFssEhPORnzMvxQqA2+l9EP4?=
 =?us-ascii?Q?Kw7+jAHbl59GH01O3eSqNKjXcA18KtwhWJVu+Atf9NTHEDRoOF0eG1OpNlab?=
 =?us-ascii?Q?ZUBgBsYawvLEeRz40K1FRXaM/7hhG/+qDTjrJb11LubyIsA7ojk9R8311rYe?=
 =?us-ascii?Q?10GApnBJ7Dqi7Ly4ciN/LoyemvsC1lyjG2wggjseI9wc78rmJAgI9mmqEBla?=
 =?us-ascii?Q?QI+1JchatnXdYF7yDtloFpu7Lgap1ChG52xM1X5+oBxLQk09dAHSubBXwEPU?=
 =?us-ascii?Q?4UUJqhoCWUCYw+/cdTHP7gMpw6iOrn60aVMxoq5bXAlw1XoBe5Aw1Q66/bNq?=
 =?us-ascii?Q?NQ65Lm+rxxMc59/L723iyrGznm+SJrcYwwymPyCl3O3H4WpZqp5RVwEv+ThE?=
 =?us-ascii?Q?/mamqkoroo3GDQbbZtvFQgR2hLTsBP60fbJLIFLXyFjxGtFl8vPsChF3I1jv?=
 =?us-ascii?Q?vWvmlY/KACINQaRF2UeQ1Fib?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150ea488-2d62-480e-8c56-08d8d9127b1a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:21:07.2653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7f0+DQJywRU7hYAfsrRpvbvsf1MdxcKgN8auofaopfNYUZ3Q0UGLhTqh+nrWvuKpYZBrubcIiTC7zydpRr/CPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4722
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kevin Wang <kevin1.wang@amd.com>

add aldebaran serial number support.
(serial number from metrics table)

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index befc117a25ef..c463af1cafa0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1190,6 +1190,28 @@ static bool aldebaran_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
+static void aldebaran_get_unique_id(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	SmuMetrics_t *metrics = smu->smu_table.metrics_table;
+	uint32_t upper32 = 0, lower32 = 0;
+	int ret;
+
+	mutex_lock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
+	if (ret)
+		goto out_unlock;
+
+	upper32 = metrics->PublicSerialNumUpper32;
+	lower32 = metrics->PublicSerialNumLower32;
+
+out_unlock:
+	mutex_unlock(&smu->metrics_lock);
+
+	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
+	sprintf(adev->serial, "%016llx", adev->unique_id);
+}
+
 static bool aldebaran_is_baco_supported(struct smu_context *smu)
 {
 	/* aldebaran is not support baco */
@@ -1362,6 +1384,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.set_performance_level = aldebaran_set_performance_level,
 	.get_power_limit = aldebaran_get_power_limit,
 	.is_dpm_running = aldebaran_is_dpm_running,
+	.get_unique_id = aldebaran_get_unique_id,
 	.init_microcode = smu_v13_0_init_microcode,
 	.load_microcode = smu_v13_0_load_microcode,
 	.fini_microcode = smu_v13_0_fini_microcode,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
