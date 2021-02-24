Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF6BC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386C764ED6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386C764ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D278C6EB71;
	Wed, 24 Feb 2021 22:21:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 384776EB71
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFZ3tOOsEZz3iXQm7k+13Se+6P9wtV0g8mmWELi9iHO6Mw779dLVqgi2f+z3MpGMWehBgRk67B0BxOsI4xy+GQY6MFWX8KiVRm9KIJxuA92y4mCrwgUDncWKle9LoBf8f0zjqQaEsZkWiDAQRTrmHCS8TRH2UAxun0G1hNwTIABl43SW4b+TRu2C6R+axlkPIKvR3snD5RZxvS/Z67q0W/USQKMPDxPF8blv5e3J/DkHI9GdG0DUYkkK1nqNRs239N4LZQ1os+gPF6eDQQ/koig5X7yKcM7rjs2sJlHReFNk03VW3M1Pzi2aaeYzh3pl0NW4dJjTu0HVCmTL3/Z4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc7wUElQ4l1Q/OBeFO+HeKi3aZSEZgruGcb3qGGQ9gc=;
 b=BSXZxLhCcM6suS0GdzY8dOllSn4RJ1rh+BvFynAT9qzWoJViKNseW5f4yjrbvG0CBUvxjmdhIHY0504sfZdEX4d4dW3x/+gnCpbaHpertyRvilLG2N+9ZoW3ZhtXbP697N5bRdJ4MeUnBtWnDAfXt4T5XC6cMzvEDnyRN3cDlujH+i7teDufEiwyh8S9W8irgqTL8ya6PbNkMPpTaDNdpzfyvrr2ZxUKe4Ig4RfmG5TO+B/t2pC4TMbYHgS3sueuFsVXuR4PWGcHQTqQU9MBm7Zioph6cPmlibUBOj1XOS0EWXwv0/gw79iSP6bmdqTIF1i/J7Qr0/RO6XBIlipm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc7wUElQ4l1Q/OBeFO+HeKi3aZSEZgruGcb3qGGQ9gc=;
 b=fW1jJjBw8NSUBkrZ8lNx+gFpQZkLcuQtmJToTJ4DkOt0i0xG4Inbd8Hzc6ko0/sYLRAlEj3UPLx3rCZmEzhJagndE8rBmSZdMx5Cdlt8xwzXUFWxxd273xoO8PF+kuEGm7iotYj2FVtZnUfIFUHNhIqDi/66WypU5ruTXUjDkys=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 22:21:42 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:42 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 099/159] drm/amdgpu: Aldebaran doesn't use semaphore
Date: Wed, 24 Feb 2021 17:17:59 -0500
Message-Id: <20210224221859.3068810-92-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5cee6d2a-b747-47a9-1d1f-08d8d91265e6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4798EBA34ED2A47B5226C4B4F79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMYbVRxLMD5WkCuJ9oHFXFyCZFNvypfHBtHnQqHY3XdywuENHvRP4Wdjwb1v+Y11ly9CTgOyX7z0eDD6xOHhAFw+YAtOVqieAhP2q7ebiYxfrIcwbLhsEofpj1BXses6Di2H1JYI9yxnDVM31lbiKR/mUFc+Rvy9gg7A7ddw9rqaYBJ0944Sd7yZNcwkE8P1SJ7/ToKE56ZZI5S9sjeRzd9ZTGdLraa7OMWLIBvR/a4ZcAIspet7SJGurgQgrkm8u1svvuNEONTFUiIghWiayYAVt6dBKhFrH9Tk3A8BiBZ42rmnwkUapRd76BVbaO6kG0AjXfPpLyJiqiIlvDkqD6G34+WZdKbW/3T+E02Yko3c1yMd/GKe4eKyWBN/iGhyAW8EDV5xgH6H7nXD/ApWlN/+dZCy5GDfIrM7/AVn+M5b7QmqLo1k3WUJ+CuF41fj2LuF/+mJUtxoyNFwnPXxneZjkvvOOvg+VoAk6GsmELB/IWNamGJo1Zp1oF+Lm4MIX+KQ+WGfUKJ9HzJvlrhxFI/80OqETAa5u04dLCchPlm8W9ojIR9pX0dsVK4Jnz3bEKjlAqxh5yaNITGqcTxn5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(83380400001)(8676002)(8936002)(186003)(16526019)(6486002)(69590400012)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(4744005)(956004)(4326008)(36756003)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2aWaCbBDkQB+WRkrw575pF8pY0hyeclQhOhfQNWSTpfBEqK0tgZ852uRns+e?=
 =?us-ascii?Q?erecRMUpsC8S7DGP9A6o9272Y0JXJpblOPJ3UjMNOnUS/paJo/b20U4fikwl?=
 =?us-ascii?Q?XUgd6KiT1OgBNLmwBeK0R//RECjUHq7ex252p6C/z94RMae+hgSugYMCzmX3?=
 =?us-ascii?Q?0NyscVvxAiv4m5+PFSwjLJaKSdFsNql9KMFfC0BgDZh+wWIffWq5zaLQ2oMc?=
 =?us-ascii?Q?DhY3vNqTmW4u2I6i15T54UqGTEH3/HutGPlUdL7Si09ZvaJtterZEozGNaBg?=
 =?us-ascii?Q?oC7x6VMi8F7jbAHtrbqTSWtFIGlAVyXTeZtOyES2SkS2T4ykex0c0x5x2fzR?=
 =?us-ascii?Q?7kqsejvNjWfLBos6Aw6vfbSy7LvldYReW5zPzF9OHO+EBbXz7R1Y2JBJ3oze?=
 =?us-ascii?Q?PBt/+IXrXR0t1bV5HUAmslYd4idQgapfpQOA/Si6kGI5PnedVL1EUE6zg5a2?=
 =?us-ascii?Q?OhXDG/CzVcwGgT3Dhx/+OcDW4IrKuVeSzJjnIgTBZufxWQQbZimgAHAhnEVd?=
 =?us-ascii?Q?Ohk82/6nsYOVRPm+YQM4rpwCRrYiCyMnLp5fHxmvj8+/8wNiPL6FCZdurP8R?=
 =?us-ascii?Q?GOckryYaUgpjWABYNIl47pSyLJR/7dDclJ3yjVn6a+F9jPlk8qJ5Wbvq9ZFc?=
 =?us-ascii?Q?DVYaxISG6h90X7BOyL4m4HdP83IoB6/jr60aQmapn1AWaXVs+UXoyTwQC8dG?=
 =?us-ascii?Q?t8UBzsxkOfhHj6Q9dMIS1RWM+YNYZ3VeBp++POqPXzhJ5xqZRyw7rf+1oepb?=
 =?us-ascii?Q?PhC/1cPyD1NrN7iabueHK7z7tOSse85mNPVPXluCwu+1Fo+WIjLVp0i7rK6y?=
 =?us-ascii?Q?Umr5PsW613SBDmhB7R7HvLs8SN7dihxEHWzcjPwXsXIdOI10R5+ZaaU2K9qG?=
 =?us-ascii?Q?EddlFHbq4y5gHAMjStrnbC1p4BO9dxmirm08b5X2so3VMVH6Aj50N+StPd+b?=
 =?us-ascii?Q?JDt0P6NwXoK3F99m2pDBwtN/dTi2jUPTcFRWN2BpQ4Rcq0uUgMNVTqJR2J0H?=
 =?us-ascii?Q?DPenIDkplMVUu2pSWLaDNQlFx+PNRr8HCNSJeW+8PqHJRmKRHabvruJXwV+I?=
 =?us-ascii?Q?n7SMI/gevBI3PXVWDCvIjN+82FPQohCEGAJs3fm084Ce8j+6Smg5Fy2fZEpf?=
 =?us-ascii?Q?MkJAY3mTdpjrIV3EW5lcJBucpWFzLRalPbuJ2vzEOkSAHiLn071EYqIwqF/9?=
 =?us-ascii?Q?LJsgPi5ytT8nRJ6pm8cpapUM9XjjNs1OQL8P7dy/t8pKKC8HKPqs4Y+rh7+7?=
 =?us-ascii?Q?OUtyDXfachZOu381GbdRLc0CnfrrpxGWUZXe84jU6SsnAhImhQo9xYWKNDPd?=
 =?us-ascii?Q?yrXY3ZsY7Nlu3VK5hXVWB7va?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cee6d2a-b747-47a9-1d1f-08d8d91265e6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:31.7602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeIgamtM2xOacuiExFAz0EkcKsjNaQAR8Uhp/LzKLlFvNSvkLflBOVcl0vL/PEFtYNMEErVJmgTRcC7QSjn1GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Amber Lin <Amber.Lin@amd.com>

Simplify all Aldebaran DIDs into one ASIC type.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 53c09aa4e159..b25ed18a1fed 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -644,12 +644,8 @@ static uint32_t gmc_v9_0_get_invalidate_req(unsigned int vmid,
 static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 				       uint32_t vmhub)
 {
-	switch (adev->pdev->device) {
-	case 0x740c:
+	if (adev->asic_type == CHIP_ALDEBARAN)
 		return false;
-	default:
-		break;
-	}
 
 	return ((vmhub == AMDGPU_MMHUB_0 ||
 		 vmhub == AMDGPU_MMHUB_1) &&
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
