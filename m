Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51686C4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 07:38:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1D222582
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 07:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1D222582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD056E061;
	Mon, 14 Dec 2020 07:38:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2E7E6E061
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 07:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2u8ewSCOnj8xjAoOdGz6aOFpOggYn5gd0xorPudQdD5gKwPdYP4D5NFigc6ujbM/O1hH/sYIM7sgklE0E38MHYbWo0GCjbic42G5w2J3PWLZi9PS9GIF6SxojRLF7L+V055S1MNDKbQ2Jyzftbkye7kjn4uw0NSBlOuQVLAHezi20gpg7vO52KoFMl7/lgSHSrxPHuguzh9vg2P8bBGXnCRlMT1xTHonaZmQt0eLhAK7CaBbMy6LqTI7oFqZGcnbh9TyyiCgZYwqNYy6cvSEtLw02FqB2ND168JePZ52QecjUD5THjHYt+rwMMldiJMy4k5XLNIgEbHSeXgtmuBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdouhmW4tF9pdA9tJwHzTRhKG4wwcQMYjZLRmlR6zK8=;
 b=CFP6GDUK8HZY8wHneDm52MakkF9U6ckijg88nA5tQsOpS3TnkKafMGlzHSdIoVuGC/y3U8YPuNw9ANFsXdcMst+PKVvJ7JHh1tW5v4Ebs5j55P0YEKZY4XJA0YvT6bCeA3zEQ7EM6b2gXHIEKPKTh4UaHe74XAV3inqaWd2RrZMOEVc9yTU/5RE1n11nuSyKiSq5cE/LBdIKhWD2Ssj+Gq9OaVSk3kgDQnX/cyQjXNEkMO0OazNtT4MYJDyVvwb0PfbhMd8m5h3zFTLHhp/bKX+b32vhbaazDx0g5oF1d4OnyYzYgqlBHudzLiTECCVohuH5NWTCMm+EXT0RRu9EMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdouhmW4tF9pdA9tJwHzTRhKG4wwcQMYjZLRmlR6zK8=;
 b=AHaDzhTx3lXa1man57KQgRRChpTPNmccPksbFLnAmI9pL4JV2fqB4gUBzig0AT9gHQGby6dkR3LIY6J9O4TPuqJQO9gpqx6/n0XOVZKcIaH/BLGQtkWk6gAYz6onFnhifOYzNAgyDFqkt6e3ENUaYKgDe5vw2VNJv52KSbI3hOI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR1201MB0048.namprd12.prod.outlook.com (2603:10b6:301:59::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Mon, 14 Dec
 2020 07:38:37 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3654.024; Mon, 14 Dec
 2020 07:38:37 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [v2] drm/amdgpu: skip vram operation for BAMACO runtime
Date: Mon, 14 Dec 2020 15:37:44 +0800
Message-Id: <20201214073744.160679-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:203:c8::12) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HKAPR03CA0007.apcprd03.prod.outlook.com (2603:1096:203:c8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.12 via Frontend Transport; Mon, 14 Dec 2020 07:38:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38184430-2fba-4b1f-5c53-08d8a00344d1
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0048283A1CFF0163AE5AD408EFC70@MWHPR1201MB0048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LaVPfktLlcTBg9SN4wZJMXfo2wwxcuo7EGP7SnlAC4FQFXpyNHhv0oEqLvgqmjPizUbY2nKj1ePdHFb4ZRisPIl514q/Lx+sQLWk0Fx4L7FHdc6l6GX9/y5B/hj/gkvS1KuQ09U8LcSJhByeqgOp6zyxlrv6hCXGtImrlD98dHwG3yWvoPEEd7TePUM+Ia7rz2isr/tyHaoGj8X7CV+Z+2BX6vwvpAk/h3szqTl3vybGy8xGqYGm1KrWdoaHSh+MQ/XE6Ynujd9fjzO6Av8li0Qp+5byYgVDilyc6fmLPmEDha5NQfDv5eo+hptL1Y+984z7oVgAVPnbpXaAphrPx8I7j0NJGaj8NDz1Zlkudi+HT7A1j+QAb/NDd1L8mQNp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(6916009)(66476007)(44832011)(16526019)(66946007)(66556008)(54906003)(5660300002)(4326008)(8936002)(2616005)(6486002)(7696005)(86362001)(1076003)(6666004)(8676002)(52116002)(36756003)(2906002)(956004)(26005)(186003)(83380400001)(508600001)(34490700003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?r6VNByr6Tl29bcNtb6qCMKdsfWgnMR4z20KhbAsMF5qv6e4hYVNFrHTSR4O0?=
 =?us-ascii?Q?g0J4/cTNNLQGMtXDwuWigjpvF2+U9Fi2nCaFbSc21BMgUsTyks0fLoH/B83H?=
 =?us-ascii?Q?/3NaxePs9duQIEh/wpdaIK4EqBqgsdeFUAhii4ID+fADxLvETvKk9wSGfJjO?=
 =?us-ascii?Q?FL8Cr4shuCR7Oz0+mH12iaGOuDPUzJNO6AiMd5QLO6Z5PFtyMBpggrKtyWfx?=
 =?us-ascii?Q?z1CE5SnpBe+0OyqviSyLX4wI40uCF81P8V1cBYvkXMu5MAHYdnRKVqBnYHNA?=
 =?us-ascii?Q?8rkNsMX/6UZ1LBsn1o9kvNdaWXsFgwC4MxxiLZquoXOTuOEnRR1K22hjJcfw?=
 =?us-ascii?Q?UOH7w5bpgyl+hLsTiAe+92NThhdTpbqeWtURnw3rJsuasUQrbL1VeQZy867H?=
 =?us-ascii?Q?bqdL9XL5iArgOiLX/cb/aztT946VPvX78H92VmCCSCmlvgdKdIuHzFqil72J?=
 =?us-ascii?Q?tY3TOgJnQhdKgZLEncA04ztiyd4cdXAnlPUNfkZhQzVR3BeCyyQUoEhhCpek?=
 =?us-ascii?Q?1+f+ZZdi0HeNzoi7SplYgHbRw9LvIgK86/msabkGNeycf0Ekzz+3NEqPpYhm?=
 =?us-ascii?Q?dC9YbNkV9NpwrcPpjK5rlpJDM2IavHC6FwxZTbsGQ4hy+rq1TJceRoNSO4Iw?=
 =?us-ascii?Q?VMFk+6tf7QlJhKo8ZgImwtyu44UJr7W5tv5u/SrLNdfFWysXr08chPsJLFiG?=
 =?us-ascii?Q?2Gbq9m517WCPsFXv5b8lKuNrLjsaYXfZo6+Az1dj/qQa0ObP47q+zzIM/SJF?=
 =?us-ascii?Q?y5ke9l4H8G3PmAaFXNtkaxU8swMlumEDxqLP1w365DsHMJBqtavgv0RghzZ9?=
 =?us-ascii?Q?mKvRlpow0laNH/kkMEcUAYqUIC8xoi7CXWxHvWOBoWnxYDTqpmq9M5bH9nDN?=
 =?us-ascii?Q?KNI3LYGHntAndaDkxvQ3NyINYvWIzS4ysZljkkKJtxYs+iWk8lWw0olNPqEw?=
 =?us-ascii?Q?FPaAFpmigVNVfzVZNIykgt38jNMuSRQFoDGW/xCqWf0iGIAAqGtCF66IB4ta?=
 =?us-ascii?Q?3YAC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2020 07:38:37.1313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 38184430-2fba-4b1f-5c53-08d8a00344d1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwUjrG32g5DAQ40mgloJmSiGZCiYliiVKZ659h5UaQ5GCjw4Vg9arYui3JUJK+n5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0048
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Skip vram related operation for bamaco rumtime suspend and resume as
vram is alive when BAMACO.
It can save about 32ms when suspend and about 15ms when resume.

v2: add local adev variable for maco enablement which checked by device
MACO support cap and runtime method parameter to have a mix of devices
that support different runtime pm modes.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I99cbaf720bfeecdc6682057b238d29c4e41cf155
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 72 +++++++++++--------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  7 +-
 4 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index eed5410947e9..288c41e0b61f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1027,6 +1027,7 @@ struct amdgpu_device {
 	/* enable runtime pm on the device */
 	bool                            runpm;
 	bool                            in_runpm;
+	bool				runpm_maco_en;
 
 	bool                            pm_sysfs_en;
 	bool                            ucode_sysfs_en;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0ec7c28c4d5a..0c608b903ec3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2464,7 +2464,8 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
 
-	amdgpu_device_fill_reset_magic(adev);
+	if (!adev->runpm_maco_en || !adev->in_runpm)
+		amdgpu_device_fill_reset_magic(adev);
 
 	r = amdgpu_device_enable_mgpu_fan_boost();
 	if (r)
@@ -3706,7 +3707,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	amdgpu_amdkfd_suspend(adev, !fbcon);
 
 	/* evict vram memory */
-	amdgpu_bo_evict_vram(adev);
+	if (!adev->runpm_maco_en || !adev->in_runpm)
+		amdgpu_bo_evict_vram(adev);
 
 	amdgpu_fence_driver_suspend(adev);
 
@@ -3718,7 +3720,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	 * This second call to evict vram is to evict the gart page table
 	 * using the CPU.
 	 */
-	amdgpu_bo_evict_vram(adev);
+	if (!adev->runpm_maco_en || !adev->in_runpm)
+		amdgpu_bo_evict_vram(adev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 523d22db094b..a198bc5d6a68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -397,10 +397,12 @@ static int psp_tmr_init(struct psp_context *psp)
 		}
 	}
 
-	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-	ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE,
+	if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm) {
+		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
+		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE,
 				      AMDGPU_GEM_DOMAIN_VRAM,
 				      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
+	}
 
 	return ret;
 }
@@ -504,8 +506,10 @@ static int psp_tmr_terminate(struct psp_context *psp)
 		return ret;
 
 	/* free TMR memory buffer */
-	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-	amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
+	if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm) {
+		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
+		amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
+	}
 
 	return 0;
 }
@@ -795,9 +799,10 @@ int psp_xgmi_terminate(struct psp_context *psp)
 	psp->xgmi_context.initialized = 0;
 
 	/* free xgmi shared memory */
-	amdgpu_bo_free_kernel(&psp->xgmi_context.xgmi_shared_bo,
-			&psp->xgmi_context.xgmi_shared_mc_addr,
-			&psp->xgmi_context.xgmi_shared_buf);
+	if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
+		amdgpu_bo_free_kernel(&psp->xgmi_context.xgmi_shared_bo,
+				&psp->xgmi_context.xgmi_shared_mc_addr,
+				&psp->xgmi_context.xgmi_shared_buf);
 
 	return 0;
 }
@@ -812,7 +817,8 @@ int psp_xgmi_initialize(struct psp_context *psp)
 	    !psp->adev->psp.ta_xgmi_start_addr)
 		return -ENOENT;
 
-	if (!psp->xgmi_context.initialized) {
+	if (!psp->xgmi_context.initialized &&
+	    (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
 		ret = psp_xgmi_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1122,9 +1128,10 @@ static int psp_ras_terminate(struct psp_context *psp)
 	psp->ras.ras_initialized = false;
 
 	/* free ras shared memory */
-	amdgpu_bo_free_kernel(&psp->ras.ras_shared_bo,
-			&psp->ras.ras_shared_mc_addr,
-			&psp->ras.ras_shared_buf);
+	if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
+		amdgpu_bo_free_kernel(&psp->ras.ras_shared_bo,
+				&psp->ras.ras_shared_mc_addr,
+				&psp->ras.ras_shared_buf);
 
 	return 0;
 }
@@ -1145,7 +1152,8 @@ static int psp_ras_initialize(struct psp_context *psp)
 		return 0;
 	}
 
-	if (!psp->ras.ras_initialized) {
+	if (!psp->ras.ras_initialized &&
+	    (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
 		ret = psp_ras_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1257,7 +1265,8 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 		return 0;
 	}
 
-	if (!psp->hdcp_context.hdcp_initialized) {
+	if (!psp->hdcp_context.hdcp_initialized &&
+	    (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
 		ret = psp_hdcp_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1325,9 +1334,10 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 	psp->hdcp_context.hdcp_initialized = false;
 
 	/* free hdcp shared memory */
-	amdgpu_bo_free_kernel(&psp->hdcp_context.hdcp_shared_bo,
-			      &psp->hdcp_context.hdcp_shared_mc_addr,
-			      &psp->hdcp_context.hdcp_shared_buf);
+	if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
+		amdgpu_bo_free_kernel(&psp->hdcp_context.hdcp_shared_bo,
+				      &psp->hdcp_context.hdcp_shared_mc_addr,
+				      &psp->hdcp_context.hdcp_shared_buf);
 
 	return 0;
 }
@@ -1404,7 +1414,8 @@ static int psp_dtm_initialize(struct psp_context *psp)
 		return 0;
 	}
 
-	if (!psp->dtm_context.dtm_initialized) {
+	if (!psp->dtm_context.dtm_initialized &&
+	    (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
 		ret = psp_dtm_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1472,9 +1483,10 @@ static int psp_dtm_terminate(struct psp_context *psp)
 	psp->dtm_context.dtm_initialized = false;
 
 	/* free hdcp shared memory */
-	amdgpu_bo_free_kernel(&psp->dtm_context.dtm_shared_bo,
-			      &psp->dtm_context.dtm_shared_mc_addr,
-			      &psp->dtm_context.dtm_shared_buf);
+	if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
+		amdgpu_bo_free_kernel(&psp->dtm_context.dtm_shared_bo,
+				      &psp->dtm_context.dtm_shared_mc_addr,
+				      &psp->dtm_context.dtm_shared_buf);
 
 	return 0;
 }
@@ -1563,7 +1575,8 @@ static int psp_rap_initialize(struct psp_context *psp)
 		return 0;
 	}
 
-	if (!psp->rap_context.rap_initialized) {
+	if (!psp->rap_context.rap_initialized &&
+	    (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
 		ret = psp_rap_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1602,9 +1615,10 @@ static int psp_rap_terminate(struct psp_context *psp)
 	psp->rap_context.rap_initialized = false;
 
 	/* free rap shared memory */
-	amdgpu_bo_free_kernel(&psp->rap_context.rap_shared_bo,
-			      &psp->rap_context.rap_shared_mc_addr,
-			      &psp->rap_context.rap_shared_buf);
+	if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
+		amdgpu_bo_free_kernel(&psp->rap_context.rap_shared_bo,
+				      &psp->rap_context.rap_shared_mc_addr,
+				      &psp->rap_context.rap_shared_buf);
 
 	return ret;
 }
@@ -2261,10 +2275,12 @@ static int psp_resume(void *handle)
 
 	DRM_INFO("PSP is resuming...\n");
 
-	ret = psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
-	if (ret) {
-		DRM_ERROR("Failed to process memory training!\n");
-		return ret;
+	if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm) {
+		ret = psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
+		if (ret) {
+			DRM_ERROR("Failed to process memory training!\n");
+			return ret;
+		}
 	}
 
 	mutex_lock(&adev->firmware.mutex);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index db0f2a476c23..fc8db9d69817 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -302,9 +302,12 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 		table_context->power_play_table;
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 
-	if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_BACO ||
-	    powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_MACO)
+	if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_BACO) {
 		smu_baco->platform_support = true;
+		if ((powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_MACO) &&
+		    (amdgpu_runtime_pm == 2))
+			smu->adev->runpm_maco_en = true;
+	}
 
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
