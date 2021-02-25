Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01321C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 16:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B35564E83
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 16:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B35564E83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 158EE6ECD7;
	Thu, 25 Feb 2021 16:44:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94BD76E159
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 16:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2ugNTbnQTRmINkXJkzta8PpaYtTbLobg2lHc5epdHqjvXpdii6TcpZPbYPIAnnoUpNid2HWocRMHF/Js5sjdwjYsja5WJJyBzXg2GR0yaAiO+nZHpu0XK0SwmO55TQUTvEk83a1euxZm1PxKRuqRN5faig9bI1CMZbZRbxkUKeWe1+rhoVEfOXoletkJn4SvZBIpXevdcgPWmmQvuKRBDrA2T0wtdj2ICnoS7BZtaSY8SxPnRlBwtHUymwTDC+c8lIyEDR/eujIWBvbJx9b0VlC6wWUHoC1K9fRYRa2shHN8a6jsWTHaI4byvRMhsum56+FaHObfsWXoRZyLcTPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXgMSoKSpb7eCerkpmyMQZyFp2lqeB3f3+1aAdmRGHY=;
 b=K8otQDmwd/RCAQMInWQEgfpNepTkbd9rytVwvBnP0mCzpfZ6QJnwyeSOkvjxsZHrifzAPle+UQa8WFvCqRtInwJN71fUvs2EykYyfFq8RryQJghZ7dX+F7ij6Pznoa77USQCVPBkvvm3s2VSzqC+q2hst7D8QBSPy8+xr/DK7/KvvHtOAwjC+D2BV3og6/xYOoQ2fioUraZLuS4xlxcG2ZVu8MtA7Nsd5mB9UVyp0EdhrJn+Z+UKJa7ahBEkDsUWgH8a/RLqBWmXeA8xm9ns1eOcTHebM/1/Q6Pe5BiLiH3zMkHDj+xdJ9LuTgGqg2MG+FvJ2fN9xehG5/6hbxsh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXgMSoKSpb7eCerkpmyMQZyFp2lqeB3f3+1aAdmRGHY=;
 b=zUBzkhQMNCu39S11Itetz7J9G0OgTS0O/tFI4nU2UeXIBbq1cHM4T38YyyEiQWFpfggwLF7CV+BZzUU49W0BBST4g52RL+/7CkVcc1TgqBF3LQd7KiVmNNXb1krK/qztgiuZKKRiyXMnHOPGA82Cckbbf36+34e4ocgR1QUOCSo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Thu, 25 Feb
 2021 16:44:24 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 16:44:24 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable TMZ by default on Raven asics
Date: Thu, 25 Feb 2021 11:44:03 -0500
Message-Id: <20210225164403.444369-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: MN2PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:c0::26) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 MN2PR05CA0013.namprd05.prod.outlook.com (2603:10b6:208:c0::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Thu, 25 Feb 2021 16:44:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 293ac029-d3d8-48ad-570b-08d8d9ac9b6b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4286:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4286C21C27784CEC5DA362F4F79E9@MN2PR12MB4286.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1R7qU5f6TvqCvAVslzGLGEHNAwEgOBHzPxO2SS4YBP2Vr11oeAcchL0AHjiRmruVgQSnXcGTF9zndcm3bojBmjwFoOuYJqr5eLnpB9TY5TGIpTw0sdEhy9L1PGME7f+WZpjQms8+y1flZIVlMPCLUkBNm/9DlJm3Droai5+5YS9sH7svFgVH//DwV10CMTZ5Ohu4YhHE/BFWhQXN1rfkl6EXhC5c/g0VOtEdL+aGkALsan2LsZ0bUC+JWjF0LhiQM6k5wtrLw3zPeH1MMjiCjBsRP3wJMYFFXwkL0PYp+OcBKLvzI6UNKqK6O6cUPi85tRaAPX10qB6vcMVBw+90OYgMstAnOgbmcRwL76gebEJXo22bXzWXoweFFHNI0o5hgZ9RBkxfOR4uLKrFcIBQvKcIEU2gH3l7mpGoJPNfj+29QDamhQ7tS7ZmJEqOY/WoSBadsP2du3Nuhqf9sWBGmgateP7UNMDos4nZWyS8FLWXMCgGm7Fzv1bWiCFwGhg2DLSkjX8Ip5FJpX4DFutw+x8B5fri9LK8H6/cMWFMb9oANQSV4QSDN2ZvcmbwdHatlAniXz4AxCGJ5I+pA5Vu6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(6506007)(26005)(186003)(16526019)(86362001)(6512007)(2906002)(6916009)(5660300002)(8936002)(1076003)(6666004)(36756003)(316002)(478600001)(8676002)(66556008)(66946007)(66476007)(4326008)(52116002)(69590400012)(83380400001)(2616005)(956004)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nLAZXz5sgwk4G7PyDbqe2yuphg7+Y825mctGgWts4du0e4pBtJib7KpBiLiD?=
 =?us-ascii?Q?lKx88l3GglQlWbnTz9iEK3rTWesMIvl6VNPnBRHqoYCPQvk2xPzInkqR9sIp?=
 =?us-ascii?Q?FmWTRQgYIY3suj+VWjidMS6eZrVKq+QVn7zMQxn3KNo4xMHUkVr1VHB8Lj/2?=
 =?us-ascii?Q?psh6eNJz4QuHjKEogppTXv2IJLKeDkqS5rdtaJgKJlHIq+ZHQXfTn/YwpdyW?=
 =?us-ascii?Q?ZHVlb7X54f0/8SWasZ5Yu6+Irk8E7iX7aSwiwd3WWzh47obzPgQ+ZwDEEEO0?=
 =?us-ascii?Q?ZvQ9jO22FqoGV1HHvRuhiCHQfEu34CCnp5RP9xq4FBR5DqFsFJ98UzLTyZCa?=
 =?us-ascii?Q?0xYfPgd1WotaA1K8+xtP1XfWLE2g42zQhb3b8cO2p/o/rNChcbK11x4usGao?=
 =?us-ascii?Q?m+GXP7L9pfBIRRO8l6M5AQr7r7dC2zJR0dO8wxTIbZDmFNxErKG8g90QKBNv?=
 =?us-ascii?Q?WPmjNFXnDTe39hlEX32KKwHL8GUvD1dnijAWFjMrgo/8FPicEXwiRe3M78zU?=
 =?us-ascii?Q?ZIuVt62tMnyqTUpZmwUAnrE6r+tR3Kry35ymcuYX+wji6ePxDw+zAa5L7zEQ?=
 =?us-ascii?Q?jowraa/jmmWwpUiuUAfljm0mUXkTeNYTwZlETKRll40CbvLHSAsMtQOkIFhp?=
 =?us-ascii?Q?8/AniomaGfT7KJLoAwMaXqUmLvU9AUms8fNM9B+i/y5yPzqAtLLJto3TX3sa?=
 =?us-ascii?Q?DGoed0rQvvQIOqgWOx5twlnaVOOyUp3cyI8XSHjCd6jLUZtA5UuBkE6d+PGV?=
 =?us-ascii?Q?AyqHnNE1mO/J2QIxDzcyW7K0csuGey6Tm5OG4SI1HVeMLDpYBrPDSbM9TJrM?=
 =?us-ascii?Q?N58cKF2hMF/XbdiAyVesIC64y+AtaRdw8Z1Bi2flV9/QfsBb+D9qhpFWd/3h?=
 =?us-ascii?Q?nstU5AyrQDMO+s6pFl4Mm7wYvlyR4XKJzJpi/MU28L9TvNia0bXQ7NC6+Jwg?=
 =?us-ascii?Q?9W0cLTupCs5HfPiL6odo+P3aHmcjUzIxRaTOZ3WBBzbTuYez8wSpSNwS3hML?=
 =?us-ascii?Q?9kXvoorlDjrL4GIaP6TABlorXfc4MhBNY2hQ9QA5pcx+yPZi20dC5N0IaimZ?=
 =?us-ascii?Q?leGbwBXFdXMXy/0gkQvFv5QxODTf86jONuFqcojEWJPON/hOgH27xhCmZJuI?=
 =?us-ascii?Q?OPrFDSJiRwtKRQrxo23MvS7gyzU+ac3OKtHUE7EpcEXHVVtWXcu3f5ZsKQFb?=
 =?us-ascii?Q?pJ8PGcv2iRpVb75iMfJTR7q2UO+ourEH5TJCvpML8La9IU2CRISUeZ+W6KZI?=
 =?us-ascii?Q?ZwyUUClAIUoylunl/ReFPugNEwsg4C5p24FiUspztzwjJJzobntL510E72UR?=
 =?us-ascii?Q?dQ0EGy8ro3LPMYnPQMPB1mnV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293ac029-d3d8-48ad-570b-08d8d9ac9b6b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 16:44:24.1296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pvt8bTuQK2OyB7V/BOCeIXgUZvMEAnwpYTk6gLcugCzT0eLM5iBqWMihTUqcUUP9YmB15zgQi0jgd+9hhWCLJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
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

This has been stable for a while.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2f71d36d2856..21504ea9085f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -164,7 +164,7 @@ int amdgpu_discovery = -1;
 int amdgpu_mes;
 int amdgpu_noretry = -1;
 int amdgpu_force_asic_type = -1;
-int amdgpu_tmz;
+int amdgpu_tmz = -1; /* auto */
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
 
@@ -790,7 +790,7 @@ module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);
  *
  * The default value: 0 (off).  TODO: change to auto till it is completed.
  */
-MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto, 0 = off (default), 1 = on)");
+MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto (default), 0 = off, 1 = on)");
 module_param_named(tmz, amdgpu_tmz, int, 0444);
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index fe1a39ffda72..1a892526d020 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -384,6 +384,16 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
+		if (amdgpu_tmz == 0) {
+			adev->gmc.tmz_enabled = false;
+			dev_info(adev->dev,
+				 "Trusted Memory Zone (TMZ) feature disabled (cmd line)\n");
+		} else {
+			adev->gmc.tmz_enabled = true;
+			dev_info(adev->dev,
+				 "Trusted Memory Zone (TMZ) feature enabled\n");
+		}
+		break;
 	case CHIP_RENOIR:
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
