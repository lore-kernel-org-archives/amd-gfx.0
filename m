Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BC0C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 17:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF096192E
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 17:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF096192E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBC9F89B57;
	Mon, 29 Mar 2021 17:40:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D9D989B57
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 17:40:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsVu0MUiuK577fc6KIXKgwfEKzvnrFUfcoolND+ZP2t+6B7I8t3YD+Ydk48F1GYrHBfVLsroi61dhCnqHG4Z53vHEdjqHx1O7TLqbdGUehuEK7J+252yb39ipnJYlM5bROOMRyduzOfR27Tj5uK9PnRm5h6wJlznQwR61YHnjgOY/IEi0X1jF9LQ4cLw83mlFPF9UpU3NQ0m+KeWBoNZ8t4WeYKkcx0sSupDApUMIrFRRXxuHnnkLn7Lu6WqA9WmjmNBEKSASSN5PeT9hlUga3cZcmhY38RAj+DJKXlfOuVgzOorgDOxxdwPWhJM2w9wOj/hr+JAeaM+a5JV4V2vxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRxTW7h1k2xfxC5N2wc5ro98YNcVfIpvZOoJ+4f2nBE=;
 b=NjoLugmH0mzIdi0YMIv5EXzA6vprlB0bHmS/Z/2DAtz42QClQXicNazy2F5q6OVUoBdrWIO5d8V2Wfl3SuV4O40Pefvq13NwC8LZGgHSIm/Q2vrRdUT9zP1++JcnMUDO/5yWUS/ozSZERLaz12+eHNJmiYwULJbcZg/jK3s2O50BP3GqVrb4HgAGSs4pNkaEQ8ERA66oaqlfj+WbNJTScWJ0rM29D6i13iFINtSvtK9efHJUV4bzk6y3vuPMYg27d5A5MgE/3Dyvn9MuRHBLgevZEnXEtw7Yknmop/3POajXaNfVmdCvgcQ9sIzuNcWXYKBz7tiyynIe33kY3ez9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRxTW7h1k2xfxC5N2wc5ro98YNcVfIpvZOoJ+4f2nBE=;
 b=gKcPgElUULpRmAIrEUwQKrx3D0dLY9EUshiyQFa0HdQN+FUCbkuFlQftuYdBHQUC9mzQO65eoEOKa8cJK6CzxkOktiT66REyWe9QJseMp+MGQPGt8x9MxP2AnvHJcyB5SyRswiKiYJcSCK0N1EX/ukdjYVm9apXPJxuHTApqQmM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 17:40:56 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 17:40:56 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: check whether s2idle is enabled to determine s0ix
Date: Mon, 29 Mar 2021 13:40:39 -0400
Message-Id: <20210329174039.1872099-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: BL1PR13CA0388.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::33) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 BL1PR13CA0388.namprd13.prod.outlook.com (2603:10b6:208:2c0::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.14 via Frontend
 Transport; Mon, 29 Mar 2021 17:40:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad080348-d39c-46a5-b839-08d8f2d9ce64
X-MS-TrafficTypeDiagnostic: MN2PR12MB4285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4285ED2916048C9D4B9D8F43F77E9@MN2PR12MB4285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCQCSsjaVDp+0zeP/0L2lVbz/sCqQaxlXYKfH4aJ1y0TR24BfCqqD0Q8hyHn6wve+gikWNvNfuVtYHZPewWfBygo5wg4EqycaqTj6tbQvMc7YAe8J30Uz72F5tEuQRBrKvu7KyuNtFuJ4YZ/yDuDAnTtOYEraWTb/bHVYJJNQ70uMp/MN1WRgIPx+OIrdpHXdsWtfmWoHMsYkb5zdF+iEVAF/2UZTxCeWEt/4QRipipCCMDti3vWuFSnT+o9jhv9tFkXKUu+cVBWOHqs7LlKnxGJDB38cuzg7/Gxo6Ue8Ir8+FmPyAOHEEF8Z9JrBSOLusVULeNZ19uVSDABeqUumUKk/4pJpL5V2S509WEcodl4XrCboaLq1Eqe8BMnbk1BuyQ3qVlAsUL9iagmqzozT/9jI+ifUHw/55w+pcu+rOP0f6al3h+V0qJMIOsVo4e4h67DVDjw7VLK6gT/iZAKlReZ+COcC7U9IHgCztV5kfOCWL1eHOCu6pbkTU1yY+Jbu9MzliH041kgqeLydPxrvzoKbYVXyWQohp0IEOkxKS+qc1ai33w3HAwWJ6RO0uNE3HArYO7n884P435eGtAjLsSSoKvtftrVRn5nyOstJY+259Xi5O2XSVmC9PBut0yYP8nw64rg8NCxGCi9nb+Hb+KpAI6xC1zd288wTv2Qbl7IAGPRyP5FjlYD9jZhcQGQyUp8GZjO3YDViKq3YLiYICOfYdykfMKXZ1sYjfEiDz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(6506007)(66476007)(36756003)(6916009)(6512007)(6486002)(52116002)(86362001)(5660300002)(6666004)(2906002)(966005)(8676002)(478600001)(8936002)(1076003)(69590400012)(956004)(2616005)(66556008)(38100700001)(16526019)(66946007)(186003)(83380400001)(316002)(4326008)(26005)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HmDTIzCDoProKH2PbyjbmOOLOboYic1bSMF9brI8HjYK82m0izmY8Ai4oJDW?=
 =?us-ascii?Q?otrY8+h1eZ5vFdPbUOJTz1VNtwUxASNohItbAmLhSL960qNbnMs11bgTUIO3?=
 =?us-ascii?Q?dFixgBZGpQB57BenLNzPBOdZsQJHXIiMf95KtznEOYkNGfpYbo7Gd+cqxE60?=
 =?us-ascii?Q?9Mua7BQCaB4tGhIP6cwsX8aCIeHZJa3SaANVISomLVwSfqXuqeo24dCVKBqS?=
 =?us-ascii?Q?p1tAjo8sIjXTBZg5KVmFZcsVM6Lso4Q6MuKv7KoarWzQPxkuhzAt49PENNAk?=
 =?us-ascii?Q?VaETzqNMWDqfHq2snyhwUB2JVBqSLPApuB3CdDE4R7fEEgeTJZ121XouhvIU?=
 =?us-ascii?Q?gMBvqS6Ju5fOnisHqCl+spWjvOy3ruu62P0ZcZtSkFYzNiGJ4WATbSqYcaXo?=
 =?us-ascii?Q?ZGrqUdKMuB5xqU+hBuhZ/KrATgafeFzsIpZlhiKrJjI+/4Ftrs8ml8YcteE1?=
 =?us-ascii?Q?3HITDk5jHHqjImG5t2xR4O1lnp1qSg/d2M9yCigOKitle6eVp02otnfw6kbx?=
 =?us-ascii?Q?JbDrJoLH1e5v5FJw5v8P3iDfrgncyzKhfsmJSgGFs5HrdlwcABLGhJxVlDrx?=
 =?us-ascii?Q?2QLvDH3oTdrdfW9fZIXKCrN8jkVNX1Fgnwdo3RxhXbvG1W6wlTBzporE7f1X?=
 =?us-ascii?Q?vliuB/tpB6ndpNHYxctp6alREPCPlYLdNx++ydUeF9LmxaLau3S+g8efUhI4?=
 =?us-ascii?Q?yyj9AQQImJ8fKESCrI5F96xahD8TMW+xcvjbOV3hgzHMVSk3CgIIyDI82My5?=
 =?us-ascii?Q?8MVYjH7HiOlsmXdUA2VszQ+lG9shTgQBOCX4pxeUeujjCPNMB3fBflhcdjZg?=
 =?us-ascii?Q?Xna92MdPIv6JgR2dQx1QQx0EIaQW99modeSX3T1fug6wyPQzeptBolsnKaNE?=
 =?us-ascii?Q?RY9kAaAW31DwFfDo4LD86Bx/OySlrkWze57jaeonpTOaEr4Q9knu2vbLuZ2c?=
 =?us-ascii?Q?tksYYW8dbnMlYTv+Tvj2sdqFDUCyIA3tmx71ZrcGX9LsnrtvSY0m8VxBpFcY?=
 =?us-ascii?Q?GYQew7yrEex1KYwUYSU1jrDWo0/l3/idsVvVoblrAmj7IA49IUxXbp0rBfEt?=
 =?us-ascii?Q?8mhl9BkbThpO2ctsgKuOTkwwZukS8I1gw+PiHgWhGMRdPyJbveEwXv6ybj/e?=
 =?us-ascii?Q?sdFDoOl4xrP92Y5+NvNdj+NNi4i2/iXpnGLGpMKu50HW3QP4G4LX7m1KJ4JR?=
 =?us-ascii?Q?Nd2JHt8S7jI6DqyplvS8JuOIVx9OsiWhTLM3XlzXMSvCi7NO31/ubNAuxhqi?=
 =?us-ascii?Q?5irM+g9IHz3yPxX0fJ70wPisQtbFrELoa7vf+EWGEL7MEooFgoyAjJrNR0d9?=
 =?us-ascii?Q?Yn+qatb8SOsE3IBrbY6WLB0I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad080348-d39c-46a5-b839-08d8f2d9ce64
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 17:40:56.0762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6T2NAKrH2WxmETJax96I+9tZTuvhz70hNLFltLM55jOZXNIRsyHIgL2WbrfYV5IH/SNaD2uX4ar/1UaSWtswSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For legacy S3, we need to use different handling in the driver.
Suggested by Heiko Przybyl.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1553
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 2e9b16fb3fcd..b64c002b9aa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/power_supply.h>
 #include <linux/pm_runtime.h>
+#include <linux/suspend.h>
 #include <acpi/video.h>
 #include <acpi/actbl.h>
 
@@ -906,7 +907,7 @@ bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
 #if defined(CONFIG_AMD_PMC) || defined(CONFIG_AMD_PMC_MODULE)
 	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
 		if (adev->flags & AMD_IS_APU)
-			return true;
+			return pm_suspend_default_s2idle();
 	}
 #endif
 	return false;
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
