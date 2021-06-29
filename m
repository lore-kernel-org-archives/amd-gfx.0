Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4A7C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 14:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394E9610E6
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 14:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394E9610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20456E89B;
	Tue, 29 Jun 2021 14:14:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D2A6E898
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 14:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7tuPOvyp2fl9sUwpVFdo2b6eshpbZyzEO7taVroMIOZ7SOt074oS97MSzdFzNS56Rci0L9r54C/vVChEu4VjfMN5j+xbj0hDGo89ZQbqPWCyGC70vyyn54UrMqQEXo1BdybTCYISnoJiGu5V7XFMy4gssawCRBUCsvarFPqgpwhMDiOVXdzx+6HFjUK4sO9N2QWAUKFRKcNCsRtqHQsB3Uq7nuByR0rqxl9rOIwhZMm9itdGsAVaiN76MQfE3E5mL925NJpeHB21K8OpIIR0WNme7ufBWQ6a2SGxzJP7D8yDg69Y+SUaR7TxsUBivfl+mrNcUxc75dSUfLGeOAmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGkHZryNtgPQ74hZqYdvOSzOPLDByHKqA11V/8wtOsc=;
 b=FNWqBxVfhFsU66FUrOEdNVsEitYJ5uGEG0jRJ2vvWobtC55Qw4N9rTyo8IFGBBMODgfOnZGGfSNB9k4i92gfSlTtVy1RM/zTeduUkF45LsZO2KgVORhWHWYEK93PayZZ+rCnVTzPClMJ8iNJ+qR8N3x4pkyiLVEuFwWAHKPQ0o/o5kvmngk9FT8XAnagQDWp25KRLXEkZTWFXXqlPcRUQ0HsxOQZUsithSbvqkIXS7kicQQ0ley+GJkGv/FRec4VKw4t2q9rtX+h3mEAkixwbo8oMlWoxsZGknHQg4NDHGptPf0iofBQ/K60aulKWI6DsikdPGjXDj3v+jgsSaewUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGkHZryNtgPQ74hZqYdvOSzOPLDByHKqA11V/8wtOsc=;
 b=RoULilKrtvSnh40ju38tUSJHagn/9PPuSAauPAqefBMY6KfjxFYhdBdHTWjtdPoI4Sx6t6WR1X9Z25kWfmPcnvxt43bVQ8QI+jR8UBGO83F9zD4NfJ/TMIExDOx39Zov23ac0LK7JRGuXC++F+E86dqxE/ZsI5c2AbtywdwWwD8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Tue, 29 Jun
 2021 14:14:34 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%7]) with mapi id 15.20.4287.022; Tue, 29 Jun 2021
 14:14:34 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add license to umc_8_7_0_sh_mask.h
Date: Tue, 29 Jun 2021 10:14:19 -0400
Message-Id: <20210629141419.279179-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [192.161.79.198]
X-ClientProxiedBy: MN2PR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:208:239::22) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.198) by
 MN2PR08CA0017.namprd08.prod.outlook.com (2603:10b6:208:239::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend
 Transport; Tue, 29 Jun 2021 14:14:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23a74a2f-8d60-4e2b-02b8-08d93b083868
X-MS-TrafficTypeDiagnostic: BL1PR12MB5031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5031C1C31690C65272192DFDF7029@BL1PR12MB5031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBK5RK/mz10r2PKpqx1ApunFR1oVVG0yEYbwP+DWyPYHL34qnuyQ5YjblRlzv8w9oqJQQmEwXej0snbOfoJ7IGi8PO2z9sI6xPwX1Xkd/JS2a2xpJpvnD7/yASPKpxhqinta/15TRIp64l7fEXIg6lEIaHYMVZtgtc2EE6Zf5gIIOBID8RHUucIEgLOHf8IkzBofUZ3i9M4ffyXjEsY0qiCH2ETkVt7MxY2vq/5yuiE8QWBMsjmfTEyTDhCv0Q+NI/mW3M6Z8h5M/33G9WVHlAkaqSvmZuuGDuLj39hFtKP3cGAFic0t+6RMjX9+bde0ou9JMs2Ncav52WbkQCfAFxx1Omhh6ZeoL3wCcJuf6Ks3T8HmjNe7H1NwMORd4udGlA9UqUhCLdhz5T9S+Iiby5KYCB9hl7hvPc/EOXUeLuqqYgUW2EqbYzGg9XR+6YWIgLk/d4UjONTCoQ/ErtGawf1X0G0HvQ+yYgQKrVrpfhqmxTkbonaN0XJMzwCeUt/vqcfwDToYd1U8VoxSZ9R1Ygi3yZ+XtP6SbbSzh9gv8fzJdfT7cz/JmyfLZqlFsq6X4Ybkua6M60GArRmoRSL7yCMth2Oc96D4c+4Z7tnWDANCH8WDvDpOMvfwTLtzIZTbU7Hcz23+iHFCiIIdBEW1ukNOAJagTTNeT8AxHyLtqT1Q2tsYtYf1VpGGa8HMLVkvaCiBrPAIsCFZP766YN63xnIgQ3IOXQ/f6pdjcLkR+42dgBUG40YsW0gwPwsNiytu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(6666004)(83380400001)(1076003)(86362001)(5660300002)(316002)(36756003)(66946007)(26005)(2906002)(52116002)(6512007)(6506007)(38100700002)(38350700002)(6916009)(8676002)(186003)(4326008)(66476007)(16526019)(956004)(2616005)(8936002)(478600001)(6486002)(66556008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HPRuyQJvYSzY4D4/X7LFbpw2Y/bOqWkmOOWDQgmGmz7hoDcolIrlZkFgfY1t?=
 =?us-ascii?Q?sP4n0SNyBrd6/zB/HVVMx0Hu+zfOdzqas/NIEQ83aznXVocabgu6RafWtuU7?=
 =?us-ascii?Q?7jwZwww80zkMgs1nCqUboFANjtxTEPjTiK0rWVTMIuJrJivkxuFQQ/QnzPkI?=
 =?us-ascii?Q?BTGiMKTcgvkqsC99j03ExWr2ab2AN+ZCHT76Huq/yny74S9FBdG7m3k6oCGX?=
 =?us-ascii?Q?8gICQfKF5G9vhDKTyVE0kzAZjHpu+HA5Rc0AJd12EATqF3QttkBtICuhethD?=
 =?us-ascii?Q?nfWGeW525/SylP0oenUMFOdzmVjOjkIkXhxRC9CCqnJmnsyFmxQesMIfaknU?=
 =?us-ascii?Q?fR4jRLdLXTP/UeTzjhaWQtH6SvJJQqGuKSXsgCCNztY7NOGmGRZ5fA3nnL4V?=
 =?us-ascii?Q?nNRf0lk4MGTd8T7Wid5JbrORGs8GfRrTq7HkOq1afkdevi43PeKL1h4bzkzb?=
 =?us-ascii?Q?l3W5eJQI8wkGNFekVHYD4UFU5nsuD6pWWvkDlY37YBG0d7U5Stoxoz/u0Q4/?=
 =?us-ascii?Q?/Yb5ZCW8huUEPN+CEXpfF+qrT19lDxSdNxGVl3xsnD5tVKUbOXpS6ZWyvjRC?=
 =?us-ascii?Q?p8EmYYMaU6pD4K1X9TeZUyP66gDJ5221AjoMn65YBpxD6GCKOSt4zblAsRyp?=
 =?us-ascii?Q?TQMJHjPkTxToHxPD5YL2MuRCI+XUJs+13cR6TIvrFnINkQJlU8+aFjr6JXcu?=
 =?us-ascii?Q?IyPS00J/Mozrhwfbzq4qDtebOjQ2EQJ5loTt31CREjvh1lAl90IgrTLPT234?=
 =?us-ascii?Q?DIVjdvmt/v+gGel0Yji5C7IQM8RaUO+xsCx4VrwhCGmZiP8IrFKWkhiWLAYk?=
 =?us-ascii?Q?LpqoKZC+iDH9QEa+ZqYPfipCdRJvdP4mC7SF6Ni7eYDXdZwEgrKpUW6xEjex?=
 =?us-ascii?Q?b4szRGCCpKWhiif1tymLQ+2MLSN4jqX9T7BeRGypzcnrqjO7KM0yVw3sE+ac?=
 =?us-ascii?Q?btqK27Kbe8GOamSHIf/uN4txqS5FM2MbmGNk6H0zbgW0ivgsHuii1+kGRHx7?=
 =?us-ascii?Q?Um8FHWAQEGi2f4eD/UJaD7XGVmd3ejQV9+D9c2t5YNiX4zm07ju7N6fcIWgH?=
 =?us-ascii?Q?rXgKUgtcDun954mTDnPlCCwZSxaX8Oq1TKzqIH2ZJ91W6kK9g2Lxgh2HU77A?=
 =?us-ascii?Q?JDRW1bt24UDF9TgnhnA1VZH4UilvnUKl+1vxPGoJ5LpMRc8TvEfswBSOBOet?=
 =?us-ascii?Q?NOstuNzdqd8s7B7doJHGMNEswJ51ZAk04QwRnuFQjgB7RDqmjCyb0EhnMUHF?=
 =?us-ascii?Q?pU6iWqUhZhVxD7GdzDeVkur7DwGnlDlmxADXlvk9vuCsRVOV8NGtz/lg4dmB?=
 =?us-ascii?Q?cYMv8NgF+9XRWGPHLgIQWMiG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a74a2f-8d60-4e2b-02b8-08d93b083868
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 14:14:34.3943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xenIpdpL5OVHjFyBI3fU5rTS/KHqTu+cdG9oJM+7MprdTSUx8Cjx9rxcNHBbkLW+IiJ47dDZ2hDiD4tEwfgtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
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

Was missing. Add it.

Fixes: 6b36fa6143f6ca ("drm/amdgpu: add umc v8_7_0 IP headers")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/asic_reg/umc/umc_8_7_0_sh_mask.h  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h
index d5ef91d3c391..20329da53b0a 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h
@@ -1,3 +1,24 @@
+/*
+ * Copyright (C) 2020  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
 #ifndef _umc_8_7_0_SH_MASK_HEADER
 #define _umc_8_7_0_SH_MASK_HEADER
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
