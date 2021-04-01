Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD670C43461
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 19:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825B7601FF
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 19:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825B7601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1596ED05;
	Thu,  1 Apr 2021 19:36:54 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680071.outbound.protection.outlook.com [40.107.68.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A7066ED02
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 19:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUUMp6ot6DRhCGyHH8XuqQN6qOC+/8ipYAQxLZVfwq71ZGFzgz2lHCcBjEFV9xWLCJLjCPehy6IeFktlXBpxUdrB4OXVqCpk8fpk7VkIRqUOzTZOaPwugEHIpeLBil2IkEmm128rpysYlch3A74o3RnaoUNKVH+b7TiCJF4KYggtYA9u70ikJOc575OtXpeI8Fy4L0SqzJ08m1XCKGODcnRBe1jQisVx8LWYb6cRkod6q7JRhPt+geTfN8c9CzdZq4iyh+Wh7dGqssBv/WvYU9XRWIl0khOKEdLfSaqeiXgBQ5DD4aS77RBPaBKVpLlgK0BjdfSXZQF9jYUpqeGxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=127ntMIH8G0yxohorvrx1aKLaoKJm/UkFYa0wd3pqWM=;
 b=ONNqV0BwAutuX75QWf02wMktaelTM9FdOrg5Yg8XD7inaV29p5/rbzI4lamMW/hHTqwkjet2siMKzt3HleIMpOo8iyAogPAlxyN+gCMnykBkTGh3MR8U2oyXs7BRBS6Pz8c/k9l0GDR4/K576tkGjZMvJGM8GpSrUeZ8qx83n8+hjZU0EuGzSu2j7Q5DEDOzYocMweGMoB4ELWHQxye0Iz3nz+QrVnCPjAtswQlxJy/WvocabKaZXYxvJ5KyJd8lvqzXoD3B437NeWAkcL9qftfHIkwwQe6XPv4ELz8Vu5o04LHblnc/BY6pnAbN+neHLN+c/zvbJGzWbW1+G4zOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=127ntMIH8G0yxohorvrx1aKLaoKJm/UkFYa0wd3pqWM=;
 b=gqGL89P7VtVtAIc5t1X3PpK2zfuHd669SL8DRCdCS/1ZYgiqWyqp++C5QxFOiPDWtg8EbjcrGgqXKz0nddAmZr3Rq+xr3tmq5zHum7tjf32q+Ca3Q8RvmNUi2KEhdgMfTzb+ll8cKDmwGhR+fKHLDNEeUczaMzzz/ySQZmHwHek=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.27; Thu, 1 Apr 2021 19:36:52 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 19:36:52 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] Revert "drm/amdgpu: workaround the TMR MC address issue
 (v2)"
Date: Thu,  1 Apr 2021 14:36:43 -0500
Message-Id: <1617305803-5767-4-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617305803-5767-1-git-send-email-Oak.Zeng@amd.com>
References: <1617305803-5767-1-git-send-email-Oak.Zeng@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::22) To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.30 via Frontend Transport; Thu, 1 Apr 2021 19:36:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc5d909f-65cc-4532-67f5-08d8f5458018
X-MS-TrafficTypeDiagnostic: DM6PR12MB4203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB420312E70B1ED0FFA456B5F6807B9@DM6PR12MB4203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6MtXy2IQ/el/FDh3XTFHufG+pQAp2MjOavsYcCzssNPHshxITLIMXI4RkxRtTu+4KseRhb4UMBJYiv3eNJkq12ElICRGrQMtj+9BOPHcUnV+Lq6oigbxKG9lDyvgbuvd2PmTYMwbo/gNgKDtZESV4x3/0/urPO3PdAWYU5o54WZwcvFLhnIrKpdjlv0jotojhEMSnlkts1PskcT6fLQ842m1l7LuOxAefGRYhx7BPYLsBuY9ohPVuelCEwKJBfSuQB+Xld0bndrbz0Zz4UIAnTQ5WOd8SvHsCnpKwhaC5ePG/48T4x/NI35CX6q2dmZlQK4widJO2RQk1+10U1wVKRVVaxHU4eGHgolc4/KQUoVmNxIUcIREVtO88KCChadWxVMaLmz2UUbgTvBXJwUQ8p0/py6BhZVtFQxMJt4lH1q22wSsxBtFdVRXNxLM9RZ1mRgjn60qEY4BJWFzPrk4Hw/JeXwxY0MXh89dzGJb55QRduxJhKqK/CLkosbukhBAQJNqTiB5Nj/aR6trhgA+oi7sp6QY7zjrAX8UL9qI6h/cPk0OMUGEEaIpTH3sqHDqcPtniwB8P8uuX7eb6SZEWc2NUhUERwYudTFOd/dn5TUu0m0o5b4+rstRrVvH6bRHZ1kuio4qvD9XysbmbyRWPi9IaELbtgJlgaHFd/m9Lc8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(38100700001)(66476007)(66556008)(6916009)(66946007)(26005)(52116002)(16526019)(186003)(6666004)(36756003)(8676002)(7696005)(86362001)(6486002)(83380400001)(2616005)(478600001)(956004)(316002)(5660300002)(2906002)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+S+ojcT7HWO0rr1ugtkhPEt1FEsk1WHedF3dQXZ2lMq7n/++yi/D2zqk5h6R?=
 =?us-ascii?Q?HrEU8yfBREiveQwWS2M8cgwi67aHgHTa9veyLrttiQOL6URzLJhOV5ZoX8sI?=
 =?us-ascii?Q?EygOLM8HDoqm4AT4ZUXHYlhblg9LOr9wGmqMuIgWJgaIL8xhjE+p1HQkOBNJ?=
 =?us-ascii?Q?dmCgOD8IFGPjzGwFIj3KN1Bd4Ba01/7iEWQhKF/DBvzS/d66ZUxXw5z/RuLv?=
 =?us-ascii?Q?RJqEdiFw3bRWV7VuWLfguLuBGGCIM5czdZRIzV4Ow9S1tNLZcRVOmK0Cz9NX?=
 =?us-ascii?Q?vgPbEkaX1ui8MUIrARUlJCF9IaZ57yRJWHCZ47AaemH+fjTnE+Hk3j0BGEdq?=
 =?us-ascii?Q?wmCcK/kEiaz7Fo7ODiUN5uRlvLf05XkvD1T72Eb3J3CSDS/qHBMcEM49Anzo?=
 =?us-ascii?Q?r2PxngGesWlq7lgOYX/4hhWky/rJALnqHKKOunxWNCOMAitxIqzM/QoNyE1b?=
 =?us-ascii?Q?Zhgp0kexXvEaro2+H77TNE+TOki5V+0n3RsNeXf7UiAFPkZxTlLaWf/MHd9w?=
 =?us-ascii?Q?m66yT83broAWBMsMvyzMSsfGN/lKguR9xyfzZMTeaLVFjKfhry+n/SE0e3+i?=
 =?us-ascii?Q?Oeq/V8+o/a5Oz6pHUHPbdCFHOwvoPK/or9U05HMfI4TOh4a5E+4rie1LMeyS?=
 =?us-ascii?Q?UT0T1FwXhNPIsgu5TndTepHMZliK38T/Q7cHokKwqwnowkld1h2+umkksHF+?=
 =?us-ascii?Q?2qGV2/oEkgw5N+3qtT6srHWLEGzRfu0H3JlBdO/BuMKbmDYXJ0NZfNOFEShq?=
 =?us-ascii?Q?kVJs0JW/vSqOi18fJoGRx+adaGEImQJ9/QmEfikNRCcLy6QbMSXpsyeiE6b/?=
 =?us-ascii?Q?aM/E5SIr5Iu0dXgh0Pe2StuL2/hcq9JpN6CP90L8ykqsmygY4+bLl2fo2nxK?=
 =?us-ascii?Q?UxttHB1O1W5y0Ei2j5DL02NpGOCLWpWFFHgOslxOwbMWdY7uFXkuK2G/kTB2?=
 =?us-ascii?Q?SJxQlRTw03v2JU2h3B496ZeF+VeTiPhmItK9CoOQfv72+9NHIEH20ilF/A4Z?=
 =?us-ascii?Q?H87N6x7dFLCgUnKiNJefL65lBpnsfQ7K+d590/NPe9oeXZGiUrVnCkKYasQ+?=
 =?us-ascii?Q?9Ei3TLdZPKX2+yTk59R1+4PNcjxTJWr8OGf4IUQdmJB8LP2W+fzUhiHqKbM8?=
 =?us-ascii?Q?F8oIHlnUvh2uOPLhgMcGHIMriDO42lKORbPT1Mqqe1Q0MwZ25Qiz5TqNsyWp?=
 =?us-ascii?Q?vX1iQ+vnIl0Zl68RyRKUOcfxQR5I28RdfMdDCXzwQk6Vrar5cb3JkAmrSKYL?=
 =?us-ascii?Q?/3oT1bk5OZP8Y52KwidHCg2JKO2RaMurFUEuAFo7x2EzhIICXAbQ65W/mQEq?=
 =?us-ascii?Q?vXcwSKpX6A75EqPi5Udvnx7s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5d909f-65cc-4532-67f5-08d8f5458018
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 19:36:52.5225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCDiklQPyrniN9Xv7ZbFrhVKtlvnD4zuJhv7MlDZhjAZrSfSuadBR8V2cDLzX2C6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
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
