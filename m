Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DB6C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 19:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5676108B
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 19:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5676108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F9866E049;
	Thu,  1 Apr 2021 19:42:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D4B6E049
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 19:42:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeeqCpmiabo4OSVWjfDjm1qWN9an2ETVbeO/Mo9Q3MKJL81w/yPjNmBjaF+3l3ul48cpz4VjrT04jc5Kd2O6OPTI4HZpSHwblgQo8KmBvGPmQUBe0hF45Zw6OCSNKAP1HsWvPBvOB2xrqqLnjNnE+arVyj5FruZjBbR2sEZXWPchfhGZXpqH6eTeA4rwKX52H/5/eiB7G06l4VKaq9bQMwIIjzt5pMjJNQTG3fHAcK+bhFPB9/7DShUgin2oaPteffYjDWtvxaB/0JN/xaGG31cxt1ZHWMgBPmH5IimOluVLUNFWuxAiJcn1DoaLli0cfjdMljl4d8ela+mmeH7N8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLD5sqzsj9diTimF7FYtLwEoY3lQUZVVDCMdu/wXRIs=;
 b=ObnS3UMVlrF4Sz0Tv9ngRTIHJ8SF+Jm3rlo9Jso2DVS9SvzS0k3pyEo9Aizk9FqWtI+/imgxqB9Q9OGob8AVtdgiPDvD8KJfE3LlTtp8e8J0CudlYCpteazjxVrPbFJVd5owNTHCQyk2iW2ctVN1M2WIXb6g4JDNrZOEyg5DTcWCZ1WrUMMJYN9lIegiZu7Ns9XETD24rPL1jyuTJGYoBHQT98MuMki9HyvFmaltIlAdbKR8Tu0ZgZ9PQxpnaG2cy7Eh4Uze2AuPh2x0qCN7+tPFeK+4e+HJUTRFnTRmFr8KXjEOxop2Y/AEJVt0zKC6ARcTz7n6IOVaF0pYNmH5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLD5sqzsj9diTimF7FYtLwEoY3lQUZVVDCMdu/wXRIs=;
 b=wKgyIpg3UmFluA8wS/mFPyE8SF4gOlyiivgtKdOoR96Twvu/Uaedmc1I46pZ9QQideqxi8K/yHdoLUDQ5YCUD/dqoogGLrRCugyhzH0a+y9fMRaJt1Y8QZ6dhwAbat24435nfJqQk5F0CCqwLJtQwdcfuy8+SqDJp44zAc9+Cok=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.26; Thu, 1 Apr 2021 19:42:15 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 19:42:15 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] Revert "drm/amdgpu: workaround the TMR MC address issue
 (v2)"
Date: Thu,  1 Apr 2021 14:42:09 -0500
Message-Id: <1617306129-5869-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::31) To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YT1PR01CA0092.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.31 via Frontend Transport; Thu, 1 Apr 2021 19:42:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 691d1941-f17b-41a1-9071-08d8f5464095
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44010D16B1340F223BF7ED04807B9@DM6PR12MB4401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLvKfH894ka6EbuNJXdFwUpOB7hX3BWPYSaBba73EAmMr8HR8GyJls8R1IGZbzMpveC9EZWL92H9UnL3ZbwUs6db1dxmjSN+kuvCz2DVb1dEHxE+n2ZDsagEuQ9wC52bk8RqsGg2jWt5Qtk7gdMXYFNu3kCmTdk/QTfgZ8l/U/TnhJYcWDVK12rLkSc0KNeWegCr05JOw2QCsZc7hHUwMnbX2eADOamlbVuvHR6vLV9BY+r+WO71ydFhcEjdk+6ufuqhgPwh8IGzBEqOBOmvcZ8ik3vakXwBw8wpio95IH8R5lj1b0J+7TeU4TKwIDqX2zSoPJQ9OwCbCSZpBLQdqXKEb6SygoM1XLutP56OPpvR7c95IKJSIEtlpUylG4oIiUjTNJd4gHP5SFvf1/+CfGtciD1Sconx4BaZLtRtKqhnJ4BKekPMnmdcsamsZmrBJavn6dWEZkl1H7c459OmctQP4AJFAFMK33utNP3sBYoeLVJWb2dnbfdmaUfhfRGIWK7m7CwF2tpNzrgitrO6wmjoNlaBcYKtTZGj45E2CzRqS9pD6IUpK6J+lqIGa/opY+IBGh8NIMlYtZl8wYdU/YEus4xDZ+CNqcOqFn3XuBwKCDRgplobvFZ96iVEd63sG6jlNAdTHi00CnFX/0OBbe1LQsV4C9ltV2KemUEya1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(186003)(26005)(478600001)(5660300002)(2906002)(316002)(66946007)(66476007)(66556008)(956004)(2616005)(86362001)(83380400001)(36756003)(6666004)(38100700001)(52116002)(6916009)(6486002)(8936002)(7696005)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?R24Xl7Vzi+oU2ByGNPKc0HRO0NXN9RRZ2RfaQzElInPIkADYuQQIuMcFdimM?=
 =?us-ascii?Q?rbToynYwC6nL94iCNOSSAGKb+jV0vtLgCTkgBRMC5jwnrNgoyjY7mjmZuPw6?=
 =?us-ascii?Q?sC0MTgvXqwLtcPLjnyF8KHnSdbKeX+qCnaKxpSatOCgqyvW7mGjyIdVLEt23?=
 =?us-ascii?Q?aogw5PzDxDiuP53fqUP7kK165aoYxFGWcYRZXiXq7g113zWfYAFfm2D0yWVJ?=
 =?us-ascii?Q?UHbTFppU/kjxl/JHKc19TsWpiqmw8E1CdOnBtJi1Xa3fKzgSbSxVMV7J4Uw4?=
 =?us-ascii?Q?zGkCY6Y87VrxT3kNi2nQaAIXstyUJKrGF7m6e8460a2bpCXW+sazTs8CCfk8?=
 =?us-ascii?Q?3Q2yg5yzOeIzaHjpWMBpJ+EVv2/ORz7fVMxejG5jXaEw5oL5csFC8Fh25Ree?=
 =?us-ascii?Q?yW8KKNdVym0GWKRWsTR+Y86oqWc3lkF+nIDmtIyHS4VKywwH+zK0MCvPL1VZ?=
 =?us-ascii?Q?nIYVqrcFHJu3Hyvs/G+C4adi4VAHBBUznApkkj6CC8fO44Rty7hnx7IP/6Cw?=
 =?us-ascii?Q?RngGZPKLL1CRd7a0DEeorw45b7LwzgB9TcQwA6bXWP9sKRYUEnceLvCP4zYh?=
 =?us-ascii?Q?qqumdIbOA3z4PmdRdTS13IBa284sMrkh86oiUnEzVl0GrhDiE6RGTTzEU+hG?=
 =?us-ascii?Q?mo7QPCpVUd4NlBOz3txZQkhz2fIkyf+G/vkGeGRxmAwArMB+hzSF05VfwRVz?=
 =?us-ascii?Q?aSG6xkgsDyKLe4yqDIUc4AiVpyJCIvXAAqTaUk6GtVMoY4N6sXQvlTbsYPEs?=
 =?us-ascii?Q?58KCoP8vs79rLF+yXgB7H7qknOIRS/05smMcqPiRwnTo5c+w5ba+6ap12BQO?=
 =?us-ascii?Q?l4SYMJ1ShAc7oG6gvHeZXdChc+3uXletptB2Gw8reIoijgugiXufWiSBFuYx?=
 =?us-ascii?Q?mF9DNIk8bNeSf3YgDcEIyYbJi47yxjhrDa54mnqFLrohGpoo2wWzNWZD0zBp?=
 =?us-ascii?Q?juya1v8MTGj1AjMca+mUfJA7B6in57PT/a7r7r3LnSK3C7m/hvr1xwuhh3BO?=
 =?us-ascii?Q?CH1dYHNurJnRzCU7+CgHEFhLynIw9RJE+feUlFuzR1wO6EAeAdPBdYo5I3DM?=
 =?us-ascii?Q?TCAIF9+RpAlVnCeEt0lpdYBC7Mzmjw+t8p311ZDW5hIXrk+MgGnt6No6Odju?=
 =?us-ascii?Q?7K2YQADqAt5De4fu5h3rPZe2vy04SwEBHjOV00fyQboTnbreYMSREpEUgFp9?=
 =?us-ascii?Q?QpEZlfPnC6HST3bsjWE83gKRQszI0BKFsFEeKStH5cgn1SAEgLFpLrwdp7xR?=
 =?us-ascii?Q?TO7d0cNKT/fCoPtdfkFK89UAZTxU6sAWmF93afxvGFqJC9Lk0gRgk43zxNaH?=
 =?us-ascii?Q?gxDcZu1FTRXkYf4xr7yGHrlD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691d1941-f17b-41a1-9071-08d8f5464095
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 19:42:15.4183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PZ3GQZzCnDE64Z25xCoiBdEpAV5gpasv5KexpyalkLKovzyr/Q6eRGvBAUJk+1h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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
34a33d4683cba7ba63c894132efb1998c0217631 was a driver workaround
when PSP firmware was not ready. Now the PSP fw is ready so we
revert this driver workaround.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  9 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 10 ----------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 21 ++++++---------------
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 10 ++++------
 4 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index bc374bc..59bbe59 100644
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
index 123ab31..5298698 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -414,16 +414,6 @@ static int psp_tmr_init(struct psp_context *psp)
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
index 9b78891..561b32e 100644
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
index d341d17..71914f0 100644
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
