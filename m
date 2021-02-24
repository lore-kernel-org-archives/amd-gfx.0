Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3A8C43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE1764EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE1764EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 591FF6EB87;
	Wed, 24 Feb 2021 22:21:51 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680058.outbound.protection.outlook.com [40.107.68.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B35D6EB79
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j99Io10Lb8TBlH0XEVpNpOYn0p/ICJsdI/m4bwdC107ItVjuBODy7Pv7EckYk7q6NupBLPPL2pl/SGXe3RatashVyqgFX+UaM51XZ+kqQvPGfyBN9lI6GQSNVZ6OzPPG0hUzGIgjzMg8S8ugNc74q4dLbNfG2f6oxAS80vVQ2KceDM2KyMSSmXCxxMz+BXLsqkNXMeG8bNKmIcnPcP3ednVRQ9LSv6gsS5DL6A2GaQDSmaceJtK4UhCMKDUQDDL2BwI9KIMpoXuFR/yXJhOEDXNI85zKLzeB/LmHSv87atkaY7dJLb0PCFMlT+Nmw/AFaF/gGfSJpLO/tkcWcOBD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eVqMduQ+N56LWnqY/jEJBpWNKy9w5NShbaMgiqdNwk=;
 b=Vd9lOlZ2NGKrhkhtwYukMl/pocWGNdT/f5WGD2FlhNyMmUqnGj4aQvGBYhIjZOciNFuwmCFY8du/TQCppws/r6fCtw74nz3VbqMuGxSa4meLSCnAiWVHrW6Ed2d0qHEulwt0ZuyOBlYUgFyCKOG8pPlvkPVRqK9GJGUNOa1fzkybEzVp/NN57aQ7EGIX4JTawC6jTKmPfLvf15Gr8jPEyHhva8OTfmQYP6bgbLUHY+Z2LoDHM+yPRQRLttFMiiC+J5HEIPLA7H5mPATnuj5wf5E6fRrh2hHnRhWZnKzN/RDpys8TrSnWetiuLxcBBujCSB3NYwxr34+WjQQYa1ojqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eVqMduQ+N56LWnqY/jEJBpWNKy9w5NShbaMgiqdNwk=;
 b=RgUoM+vJnh4NMNntpmQwzqfni+ph0JP7sOyKU2PMhzFaH5CG0P/uWmfsrNE+NNY1RgznnAMXK0D30yhGuzKfHnZ5Dr5WUFX4n7QrJc18xcSC/7Mu34kvc+uzX/8PRAf8lGqqQ4gIBmrtFbM0A7LEjdm6ITO8Tb9ojBJx7q+9YQ8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 22:21:48 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:48 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 116/159] drm/amdgpu: apply new pmfw loading sequence to
 arcturus and onwards
Date: Wed, 24 Feb 2021 17:18:16 -0500
Message-Id: <20210224221859.3068810-109-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d5fd9bc3-fb80-42b6-9420-08d8d9126c9b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4503FE8E84DB986027D5CB40F79F9@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKD/PsTN5m5hrkixNodw8o7hUwI68oD2tlpCFVTRBBduoV/osH5gQUzwcMXRTlxFHGqRoQOryVh6R5ASNVrN5qbonh6JqWgc50QKVtsSvmeadjK96V6V+Hbt0Y0BNMJI/Ye8c+Bj9EfyNT7bzGv4RUjS2YEBycUQYfAGetcA94mqk+OlumuzlOyFXXlRMSnMIEt2AOccnIcjiiX8xN4c2seA469vUAAQttT/VdoGT08S/YPJedZJ0PGM/Vi0mLN5cIu52YvELZo34jiAuxyAL3SQbG8RdAcZrXk+J/0XoMvxbXcSfZkYFj9057LuDAgp/6uTqvAd+rsNTceNpSgpnhoDKK0bESHV9GKZ02Wc+LEve/493Z10BKWyY00ux/kTgnxSZjmNkYBQCDvzTHRgxt65vrhJaT8TlcIcDJSawNqFw76SIYx5avNuPrGOvQMVlh9s1nsHeCQZbpEzWkNYfSmp2mRHCWKiPB6X3RLvdalQ+ANg+RY8pA0PCqvo6q/ma7HcQNHj/A9p7TofHHJrs7pUUwlyTHyur7BpYHmdtpEhr3+RfTDpgEJ7jp8Rk1bTVzqB/JYLgt7m5hAKXvi+VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(6916009)(52116002)(478600001)(5660300002)(1076003)(4326008)(36756003)(54906003)(6506007)(6486002)(6512007)(66556008)(6666004)(83380400001)(186003)(26005)(66476007)(8676002)(8936002)(2616005)(316002)(956004)(2906002)(86362001)(66946007)(69590400012)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?t8GND6HR/bBHbPITARIpVNix8plW5+koitOHAoauaOVKmuU1RH6JA0fpK1vb?=
 =?us-ascii?Q?fno/7hqbmm5ru86jyuRvtHqjhHDT099s+K5lttouwP9sxQKdK33ztCDqYfwX?=
 =?us-ascii?Q?uzvl+XTNQWFvIZdaOaIirJ+FFwv0cVSMvWwO7b3j6wUPJsklD01ffQSLFH9z?=
 =?us-ascii?Q?pwDimFCQy4dPI4VNMmqcq3Frqgwe1zdQK7LwcudEGhf4WVGmLHje1zvdkj/Z?=
 =?us-ascii?Q?u9xYWWd4RPTLs01n+ABcZ2/3GSzY6dVjcIa03AaHp26B0H4tqeAdGNTLwKka?=
 =?us-ascii?Q?3wCnxXNobEGtuYZ30yFAjNShegYnZy1aGTmXEyh6ZV7eyaPT6nlT5mzu5qSj?=
 =?us-ascii?Q?/tiDwtINsTbP4HlLgpAgUIyz5RwaK27Xd9vgZSMwk+E5y1YMzrbtu3AarGYN?=
 =?us-ascii?Q?ao/3rOJa0xwQaSishkBPjbulGdxbmrOpGbLgHkfrbcK6P2m+UqvbdCN3ypAB?=
 =?us-ascii?Q?hVxwYKa5OVco0zvytyvtlAGj6FDKteMb2zA0qesZKwKA/aQPghJBBaq8DmQz?=
 =?us-ascii?Q?4oRfkfKW4cr1ZDuvhsVc3uPpe7awAGQ7UOhZnP1JPN6M499EGC5kl0lNj7Cs?=
 =?us-ascii?Q?slr1HbSek+9rWxpWayTEc4XXystyICTB7+o7wGBmKQu3etWzOx4RRu7BFtbY?=
 =?us-ascii?Q?ttvQu8zUxzHLaR75cjDvhqkZT3PAR/4TNb0TaUfyM8EOBI5jAY+W0wpHkyk7?=
 =?us-ascii?Q?PcriYUguuFxOKDMpSFZSu1QtbJ1751/+RdmzlWJuUHD0/GDd93Vkhag7vaWh?=
 =?us-ascii?Q?37ZirxeAMTCB/xgyZIxOLrmUnOCAkW+4MeBZNsIn8BO85ToWH53/20wjWddV?=
 =?us-ascii?Q?b+WvZAXMU3tMSHQ4BS+tFfWOhr9lMn04QqypT5WZ4d6k+AArqyO/A1wd+TxN?=
 =?us-ascii?Q?fQ9/Y5PSQUqDAEE6RoFfqCXYQ54zfD84kgaV5qt5JzqQV5i09DSW35kW4xs4?=
 =?us-ascii?Q?KHKb0kYN/CIcOtYn2+PBxFlsBZtbbsMRueAdQQcB2vnDeJy/94mMI7S+3W+7?=
 =?us-ascii?Q?cSYTRSoCitk03aWsx0fmDSXqCRgn/ax9p7DLaTXjHc5J1nXrvz1bdSaqJjfR?=
 =?us-ascii?Q?mvhYNR388s/f2y7njjRRh/M94aFpnIFVp707lAYlX34mGga3mu2zjbe6DD7t?=
 =?us-ascii?Q?Y5jA69MRzmlZNSlYPiC2rodhxYv8JsYeGCW/Q2umC9034kiNHgm0BkNbNul9?=
 =?us-ascii?Q?SMblPGxNFiyvNbmz/t1CeMq2jsVYd2ApEEYXYhZuMdPIYCOHDgXVKzpmQgq+?=
 =?us-ascii?Q?s0hf1/43yc9Br1FkMKOE0KB5Rra4E+MywcEDoBiGe7bvYvk6yZYhcw/bi8dB?=
 =?us-ascii?Q?zD8g0l/ollHBhoxLaCbNipzS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fd9bc3-fb80-42b6-9420-08d8d9126c9b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:42.9431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ufl3kT7H6T0O++JXDBLFY9Wc8JBVtmrjNIuz59TXKR4dzUk99IRR8S8DR+81ujcIqPCNWqGicEp0LB74zweUTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Arcturus and onwards products should follow the same sequence
that have pmfw loading ahead of tmr setup

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 38d400289013..cf8cfe620d8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -57,7 +57,7 @@ static int psp_load_smu_fw(struct psp_context *psp);
  *   - Load XGMI/RAS/HDCP/DTM TA if any
  *
  * This new sequence is required for
- *   - Arcturus
+ *   - Arcturus and onwards
  *   - Navi12 and onwards
  */
 static void psp_check_pmfw_centralized_cstate_management(struct psp_context *psp)
@@ -72,8 +72,7 @@ static void psp_check_pmfw_centralized_cstate_management(struct psp_context *psp
 	if (adev->flags & AMD_IS_APU)
 		return;
 
-	if ((adev->asic_type == CHIP_ARCTURUS)	||
-	    (adev->asic_type == CHIP_ALDEBARAN)	||
+	if ((adev->asic_type >= CHIP_ARCTURUS) ||
 	    (adev->asic_type >= CHIP_NAVI12))
 		psp->pmfw_centralized_cstate_management = true;
 }
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
