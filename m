Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814CFC433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 19:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416436199A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 19:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416436199A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02816E95B;
	Tue, 30 Mar 2021 19:35:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7AC789C29
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 19:35:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ1bsWhnkoQAB24Gw83ZmXaK5vGUwAbDmsq+29xFinXE2lx7HHtD5fFoxYuFg1dhfqhElMHH4FCsTYZ3XkK1MywQ7wj5ZUX9bQpfRsAyjSieQM1tVm6Z54731Qm2TO3TuMFh6P6V3lBq+RI1D8H4akO6FxDAu0JoRDyrWzmb6KRHik35NnXRvm0er90+/ODizAt8sEuB5sIcwe0Ej0kNjr28/dcyg9iOaEf2CdjhwSdwgd0QmkulTJ0BFmlun5HumKyTbkkGJJxgJGafBk1pMrURwxz6mNMd9wXYneYt4V9TjqCoNtkRjBRq1n43JS8ugzKkwJD1r2se8KqPwrIrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKsrui6uRWHEhEjojUnyrqUcBpA0AafJID3R56kYBOc=;
 b=Plhhu2BBnIjZlq7Kf1ZlbEW3g0KEWglUc+aGBFyanvbbK2dz+LZKGXzvsw4HANmX1AbKGutkDzy/4ti0W57QmX/HSyhYQA3MkbZx/pGuyfxoeEth1+NyCgM//9S+3mM8wAf0E6E8hEZmJBY28pixrvYi1rJND7q3aBWH2l+CRiH9q7FVG3SqPX9hWxLFhf9Rvvxa0zCOsrN4oASIxWbP+9i1WuwkUbtGoGKfWE2HlJqG6jwJPKBXkyKvXdNSRfhXTY/vN9gH7v+9B5tNya2wK0QM6B4kbrjEoszTD9lmXf9Mhi2H9D6U2uIWAQ8hHIC3bVROFyUIW9MZ33RKYf6O1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKsrui6uRWHEhEjojUnyrqUcBpA0AafJID3R56kYBOc=;
 b=synnyZucmLFsVvJOS7N/tnSkJBsgs38ZouemX9XVatWQPsvfk2JcEkXPq1irdWGYL0FloCZB6EZ/23R6kwOdB20mIIwpINov1eYmkrYV2mmFoHwAIY2QAKaCmkhahjrVMX6V2bwP/H8SymQGoszKz3dUlfYm+PKPtNsABnJOyKQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB3787.namprd12.prod.outlook.com (2603:10b6:5:1c1::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.30; Tue, 30 Mar 2021 19:35:42 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 19:35:42 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] Revert "drm/amdgpu: workaround the TMR MC address issue
 (v2)"
Date: Tue, 30 Mar 2021 14:35:32 -0500
Message-Id: <1617132933-16843-3-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617132933-16843-1-git-send-email-Oak.Zeng@amd.com>
References: <1617132933-16843-1-git-send-email-Oak.Zeng@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::7) To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.32 via Frontend Transport; Tue, 30 Mar 2021 19:35:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b95ae80e-8a9e-4ef2-9fad-08d8f3b30130
X-MS-TrafficTypeDiagnostic: DM6PR12MB3787:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37875AC51F227570EA64B8F5807D9@DM6PR12MB3787.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PqFiO6P43sb7YcVIyz7yGPOB4lsO+hfCTdjXwmSID/SPpc826QR7Qi6Rv55e4l5NrZOVN8yasQ+czECPb+ll8XdrydWP5Pp9zF0Udaewy77LQeBJ7fNvC8yBtdShbhKQZSHCPnpPHna/79n4cIbtSvKD8absFrP7aGnDXMsyJK3bJy04x7N5DgsohjKqH5Je5AMh0d2Q9+U5wDJbGcMlJ8xes1+GHnXokiVEGRL2b9OzHzipMguvDJDRy96Upug0P75DJgRWs9G063mXIxSWbGOghOKlnmTFrRWvTEmC8BC9/Sb37C/GqkU/uN7eh5UBhHf9TX2QAvI91muMea6Uim9pzFGDbZSJ1SohDf6S65rVvL1C7GNPFjRh9HEe5WM7u+Y2ktLvJa+0wMysHuhvsDmug0tozjhB9ukonMtIrojMV0FT5HKPDWpUoAwM+8/4tnf8MqY8ZhxW05Gusm/lwRHAn/v21lK7mDfdCe6b3vwiMa18iHzC5ETY2tbIIbz0cflz/RWgCUdhYfX/JF7wja0f/uxPTx122ZyNcZksc96aOPxlwzGQCDgz/bszwpAlxsGG2T16gW10U/TRRi+ZmknFg6l+WowlK9t8zd2kWZ5A/7zTHBd1RkyvsuGqbosQZBtdyX2UCmV37cEAsC5jWrEXU1qoj2rb4HZ80UuEuA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(6916009)(8936002)(4326008)(66476007)(2616005)(52116002)(5660300002)(38100700001)(2906002)(7696005)(86362001)(66556008)(36756003)(6486002)(186003)(26005)(83380400001)(6666004)(956004)(478600001)(16526019)(66946007)(316002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S0O3QjkrMObtB1SHLaWQPIyQYzAv8/06aTbwWJ1XCtnML9dhPjnMHPLapr/z?=
 =?us-ascii?Q?fHSQf/0O3JsOqivjfuv1UuHU8gXIq5CBjtfpaHTYiCimHGZ0FyjfXm8YcpYa?=
 =?us-ascii?Q?fXRKyjxhCixVEggkL8Ln4buEy/0Dth8Py1sNzndyNrowlBHbmVYKB9VzxS+e?=
 =?us-ascii?Q?rZd4ufKIF63tTUbzeGR4gfw99PpL6hCK/gvNEuruHZeBB47bsOYfkT9WtJFo?=
 =?us-ascii?Q?dSSvd9gXP71Dyt2BRp6SLTV6Z1hUpPnpKd205QLqB7z6B368ePw179MVr3Pp?=
 =?us-ascii?Q?3U1qm7pVpc+m6jeZ+rteYTVZE15nfKJcCLE/o7FDi3BTCjRp2GzSIE0TyVmo?=
 =?us-ascii?Q?8ihbAyjCzgC/i/qaXRV4JkOAI8nB2KWAyZyc2aLJ4Y9eb4kS9Dfqt2V9PiSZ?=
 =?us-ascii?Q?UUabUd5mOMxDtK6wpRRqj1O3EXuYR5nxC44rl2tiN7z1R2PnwEe1YZmgqE09?=
 =?us-ascii?Q?tyBqk5MwRjTWJtxUkofokR4kcMsDWtpwoWsmHFzFji9LvtCOP9ZxfIpO045Y?=
 =?us-ascii?Q?P6yq+kZVLvZ/XE5JibcoNRStGz2Kcy10tLY+KFau+QDiShR5blpbYtUr07ry?=
 =?us-ascii?Q?ZJBfCVwullJqZh8h0ajcVJejI1oEa5TbbT+Jz5ckYIUX3NAD0K85BMOTUoiM?=
 =?us-ascii?Q?2rVd62RurPcf6ddTVzHAxkaiIMV13lYSwF73vWxuufEhgy+rSHQwQNCxS3Bb?=
 =?us-ascii?Q?uIntC/Nf7FehMIZzWrYpAXL3lrOkPVyezvjM4Etn+qciBd3dX9jkYJy9oj4Y?=
 =?us-ascii?Q?9eCLVzlCE2TdBoBDYzMf3UPuJmtHcuIUF2D2mK2miGkO61xrG3ZdaHpnTaSp?=
 =?us-ascii?Q?vBaFRdKsHdtLUhZRzhPb+Ei7AIFOrVjkeX2/u7uzgYvRYQNEnJgiRZYHFyym?=
 =?us-ascii?Q?6x/Dmz2iY5E2yzHDMMKUKPBT1PRrsPf9pM/h/+XcC0qgUIVuP+ymDyHVgHKx?=
 =?us-ascii?Q?qZKl4ADVO7BTkfSbbm69p3zyu6z5tAxN4hnYkvdC58MUf14dcJQ9kRddfAyt?=
 =?us-ascii?Q?uEjsIAWmiUzMeEeKatnKIvKSjioZDHsr2wZpah4gnYprU7J+k5dvHuJP6ewW?=
 =?us-ascii?Q?LQzZcpSzLnHLinQM7im3Z7VCt3ZZ5gUkQu+e/rlQ7RvPGiag4a2GjGdsjHUH?=
 =?us-ascii?Q?4LmO4tPTm3YxWHUQR2VfuCXdCPd64tRLhG5HkaLcm5bCcou1xll3bxgwKxWg?=
 =?us-ascii?Q?iOgfXm4HFxlim2o3lqyekPyoN3E7CrV9PjHANZ2eI7u5+QHBoeI0eNL5H1Ix?=
 =?us-ascii?Q?VcEm3Cx6s83TYTDPbHRp7HiDTyGAP6+LFITFd+0ZjnfBCwZPdK3nQhpDhHM+?=
 =?us-ascii?Q?WLb6pikgLT/1so+NYfMVStad?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95ae80e-8a9e-4ef2-9fad-08d8f3b30130
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 19:35:41.9743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sh1B57kUPive/1+Pu+WQbfHPz7uupeuu4SWlDXVNMQW/B0TBCsL1KBfdXH/xiIBu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3787
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
Cc: felix.kuehling@amd.com, lijo.lazar@amd.com, christian.koenig@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 34a33d4683cba7ba63c894132efb1998c0217631.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  9 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 10 ----------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 21 ++++++---------------
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 10 ++++------
 4 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index b244298..5f53d4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -209,15 +209,6 @@ struct amdgpu_gmc {
 	 */
 	u64			fb_start;
 	u64			fb_end;
-	/* In the case of use GART table for vmid0 FB access, [fb_start, fb_end]
-	 * will be squeezed to GART aperture. But we have a PSP FW issue to fix
-	 * for now. To temporarily workaround the PSP FW issue, added below two
-	 * variables to remember the original fb_start/end to re-enable FB
-	 * aperture to workaround the PSP FW issue. Will delete it after we
-	 * get a proper PSP FW fix.
-	 */
-	u64			fb_start_original;
-	u64			fb_end_original;
 	unsigned		vram_width;
 	u64			real_vram_size;
 	int			vram_mtrr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 9e769cf..c555fa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -407,16 +407,6 @@ static int psp_tmr_init(struct psp_context *psp)
 				      AMDGPU_GEM_DOMAIN_VRAM,
 				      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
 
-	/* workaround the tmr_mc_addr:
-	 * PSP requires an address in FB aperture. Right now driver produce
-	 * tmr_mc_addr in the GART aperture. Convert it back to FB aperture
-	 * for PSP. Will revert it after we get a fix from PSP FW.
-	 */
-	if (psp->adev->asic_type == CHIP_ALDEBARAN) {
-		psp->tmr_mc_addr -= psp->adev->gmc.fb_start;
-		psp->tmr_mc_addr += psp->adev->gmc.fb_start_original;
-	}
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 8c0710c..a245e8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -140,21 +140,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	 * FB aperture and AGP aperture. Disable them.
 	 */
 	if (adev->gmc.pdb0_bo) {
-		if (adev->asic_type == CHIP_ALDEBARAN) {
-			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, adev->gmc.fb_end_original >> 24);
-			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, adev->gmc.fb_start_original >> 24);
-			WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
-			WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
-			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, adev->gmc.fb_start_original >> 18);
-			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, adev->gmc.fb_end_original >> 18);
-		} else {
-			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, 0);
-			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
-			WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
-			WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
-			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
-			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
-		}
+		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, 0);
+		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
+		WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
+		WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
+		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
+		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 2d8cf7f..7a1880d50 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -47,8 +47,6 @@ static u64 mmhub_v1_7_get_fb_location(struct amdgpu_device *adev)
 
 	adev->gmc.fb_start = base;
 	adev->gmc.fb_end = top;
-	adev->gmc.fb_start_original = base;
-	adev->gmc.fb_end_original = top;
 
 	return base;
 }
@@ -126,10 +124,10 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
 	if (adev->gmc.pdb0_bo) {
 		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BOT, 0xFFFFFF);
 		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_TOP, 0);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, adev->gmc.fb_end_original >> 24);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, adev->gmc.fb_start_original >> 24);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, adev->gmc.fb_start_original >> 18);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, adev->gmc.fb_end_original >> 18);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, 0);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
 	}
 	if (amdgpu_sriov_vf(adev))
 		return;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
