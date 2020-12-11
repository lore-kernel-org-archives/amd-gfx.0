Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B914FC4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 09:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6242123E1B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 09:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6242123E1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C2B6ECC5;
	Fri, 11 Dec 2020 09:06:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC5A76ECC5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 09:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0Jzy3u/vUVwrmWGsI/SXXDfZ/AFNaOWuDM6w5kTJ0M0kQj5lWep94dFMsbTU+JerLYbRpYbGJM4/W/5AGKcld9ncrjO56aPrfntbwHniy+X/H4O0X9pvJ2dbAQf6SS20S8IawbP91eNpQ7PYmSX3aTSbAxO9TvoCg2bPS9PSgmIx98Er5t1E/xvghhGHAEghS4Ii6RrZ2RTtIUCpve622LKhXsFQr3xuhcBoOybJj4ztzpiXjTz7XUS4PmGZjrBvau5fsB3FumhuCXD+fkJ3rj5ZheaovKit5qu1GywtSN0zhNvsrJQNZ7A1wUr5KEMtPUPk8/MTD5RbScYQofWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5pu2veyvPAfRFqC7GW8Tal6On4bCSqNU5mhXrQS8Os=;
 b=KE3SgripyTZoub/9rWd+EHbztH7tdynUfC7R0L916wxT5ccaaPcpc2qYyDsh02NaRwjYJaT2CjBxffGqCYy59TN6Bew61qoFS4pSCb03QCnEnm75q4aKfyO/JYR9B6GFUrlJPZP7QLPjs8AkFWtUcaBLN691uJKj1Qm5aIhD8H5EDMS2STpohbXNWoZ4gYVgHQFwoKG6DEBazSbi8fggMtr264/hA3QTJxAaD4SlUyv871yPYiAidfwq0snrhTjUYGeaBZXzocsV6ZGrlgruprkENd4OIkGvSypXFtGcnX43UEJFSPfNpJMidoSxlLYSWODeirRfA2/vQCJaGQd5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5pu2veyvPAfRFqC7GW8Tal6On4bCSqNU5mhXrQS8Os=;
 b=hLJlqL7X3R6Tww2yllTyRMRg/HiOrWIwVBsLKXQR7m2swr6v8h1mCOOH7AQuC8iPIm9XFXAI2TSm6R9s/EHAJy0dFXbIdt9L+wf1NYIA+3UYEwqcYFjCk7VgIKmO4v6ZDLAVJTctzO1VB03SYAHtEa/wrhaY61XfOlXOXsgEnNw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW2PR12MB2585.namprd12.prod.outlook.com (2603:10b6:907:3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23; Fri, 11 Dec
 2020 09:06:07 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3654.017; Fri, 11 Dec
 2020 09:06:07 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: skip vram operation for BAMACO runtime
Date: Fri, 11 Dec 2020 17:04:48 +0800
Message-Id: <20201211090448.113278-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR01CA0065.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::29) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HK0PR01CA0065.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Fri, 11 Dec 2020 09:06:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebeb9cee-c000-45db-50ea-08d89db3ff1d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2585:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25852C561F27FFA781604ACEEFCA0@MW2PR12MB2585.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuoDsbDT1BmX01rNLEgbgimM7pXRvQnzZTK0sI3rtckhTPPe7yNTZF6JYIygS3TQkciqabUM/SAqNoyfEnvQhss9Uu/1AWcMivy/ett5vq8ayOz6OzWGRxN16YHOJa6VxM66Ya5B+Cb1bbiDubVnKRVr7sex+A42RH8MxXqVO8XT9Flw+kYLJBYC3r0avqUBotwnlpuOPH4PUCzVvGUxlt6snRvQKUZJxPyjGyY2o2rND7hEHOU1ieKM8NIdb1ahA9BvUkXGXMcmGazCY70miL9AiqwOvAZo5BNCVgiaEyDjP9/tE2qKYq0vGQa1temwqtlRXcDXVF+gdgjtipp/VIkdxBibQLGbdkh4azTn5dPJ36TAQiG4cVQEHZsJN9+v
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(6666004)(8936002)(6916009)(54906003)(36756003)(6486002)(186003)(4326008)(86362001)(26005)(16526019)(5660300002)(8676002)(34490700003)(508600001)(66946007)(2616005)(7696005)(2906002)(44832011)(66556008)(52116002)(1076003)(66476007)(83380400001)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cCJ76qvLdeqXBU3c/8fhHstbswzzqXqUy3WLPZnuq9zQkUhQPoPWDvnp3VAa?=
 =?us-ascii?Q?uN0DmXx1A9EvkRlKN4HM+L+2GwmhVtqdXAtE/CaMqNC/WFqVhsmPJhp6hUR7?=
 =?us-ascii?Q?CFsZU3Ol27So/yA3HJ0yYexbCUluasdXtuOMyyGDHFU+seCA4rsEjbtq1aFb?=
 =?us-ascii?Q?13dBlC90jRIqt6qVl2VAKBbxnttLp5S/AksD82xJeZsb5xw31TR5aawW2q8E?=
 =?us-ascii?Q?/eskVlTuAXayC6TAhNiiOq2nEullOqw23opVpTSZCgxIYLbm6fK3bBayPTRA?=
 =?us-ascii?Q?ibiG8V0VDSmlB0DU01cv0Aho1+wgQwSaxZJaIEmPwJoKviBltW+wbJAt/Rnt?=
 =?us-ascii?Q?h/HPRTu0R8aA5KVSjLUCJLErmSwnxqTH5KeKB1Fi9p8AICt+URSPFd1lv0hU?=
 =?us-ascii?Q?sS0/1WsSa0RYxTolQnnIPg655tFUkHhk3rxPYJGQjQ0H067q/OsmqIKooplo?=
 =?us-ascii?Q?kjRAUfxa0Lm5et2JFjeEnxzzkAr5cMheL9SloAMhEt7s4xSoXF5VNxvi75QY?=
 =?us-ascii?Q?5f5mRe5N5x2t9GJ1W4mLVXIldp9nE90ujRIKsCVeHft+B0sJufMYoxQxQVEL?=
 =?us-ascii?Q?M+g9HQlEIZDUS3vx4OTfOniTn31LxkK+9vole9frx1ZntWlIsu6Y5uwf82B5?=
 =?us-ascii?Q?i5fFcmPpFvGPXSm9V8eadUcCTGRe1qu7uaC3j4kAE0xu+mVD6o0/Ve3COiLS?=
 =?us-ascii?Q?huzWS3v6BaTYU4B6TJU37KVFJZaO6EJAdvyvrL1LrF5v7KydhcZ6AKo7h7iC?=
 =?us-ascii?Q?65DUON8+OY0DHCqEYCkINXC3rITOzM/40wiPvC7lYe4tvHuI+NGraVMlyvfs?=
 =?us-ascii?Q?HhC2PldZuc9tFeuAScRGRwbHZtXsuQ4xdqi9f8P2Pj+D6ORmQZPIbipTL9Cf?=
 =?us-ascii?Q?6Jc6Fgam1wYz4eD0zy0/s85514SQn3M7dfzcUuTx8AEc564jxlW98jxcqm5L?=
 =?us-ascii?Q?heFgeBzpc+tyyTifEgysb2aG7qbJy6RUINAC/1BWGl+CpB3m2UMor2PJQHXm?=
 =?us-ascii?Q?Geml?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 09:06:07.6184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: ebeb9cee-c000-45db-50ea-08d89db3ff1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hG9lEoakYvtfBw0OQgcpyYE8C2snFnv6Rro1FRKsRzF1OSuCFSHSdH8rlm4IK4Tk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2585
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
Cc: Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Skip vram related operation for bamaco rumtime suspend and resume as
vram is alive when BAMACO.
It can save about 32ms when suspend and about 15ms when resume.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I6ad39765de5ed1aac2dc51e96ed7a21a727272cd
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 72 +++++++++++++---------
 2 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0ec7c28c4d5a..66b790dfb151 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2464,7 +2464,8 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
 
-	amdgpu_device_fill_reset_magic(adev);
+	if ((amdgpu_runtime_pm != 2) || !adev->in_runpm)
+		amdgpu_device_fill_reset_magic(adev);
 
 	r = amdgpu_device_enable_mgpu_fan_boost();
 	if (r)
@@ -3706,7 +3707,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	amdgpu_amdkfd_suspend(adev, !fbcon);
 
 	/* evict vram memory */
-	amdgpu_bo_evict_vram(adev);
+	if ((amdgpu_runtime_pm != 2) || !adev->in_runpm)
+		amdgpu_bo_evict_vram(adev);
 
 	amdgpu_fence_driver_suspend(adev);
 
@@ -3718,7 +3720,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	 * This second call to evict vram is to evict the gart page table
 	 * using the CPU.
 	 */
-	amdgpu_bo_evict_vram(adev);
+	if ((amdgpu_runtime_pm != 2) || !adev->in_runpm)
+		amdgpu_bo_evict_vram(adev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 523d22db094b..67e74b43a1ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -397,10 +397,12 @@ static int psp_tmr_init(struct psp_context *psp)
 		}
 	}
 
-	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-	ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE,
+	if ((amdgpu_runtime_pm != 2) || !psp->adev->in_runpm) {
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
+	if ((amdgpu_runtime_pm != 2) || !psp->adev->in_runpm) {
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
+	if ((amdgpu_runtime_pm != 2) || !psp->adev->in_runpm)
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
+	    ((amdgpu_runtime_pm != 2) || !psp->adev->in_runpm)) {
 		ret = psp_xgmi_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1122,9 +1128,10 @@ static int psp_ras_terminate(struct psp_context *psp)
 	psp->ras.ras_initialized = false;
 
 	/* free ras shared memory */
-	amdgpu_bo_free_kernel(&psp->ras.ras_shared_bo,
-			&psp->ras.ras_shared_mc_addr,
-			&psp->ras.ras_shared_buf);
+	if ((amdgpu_runtime_pm != 2) || !psp->adev->in_runpm)
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
+	    ((amdgpu_runtime_pm != 2) || !psp->adev->in_runpm)) {
 		ret = psp_ras_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1257,7 +1265,8 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 		return 0;
 	}
 
-	if (!psp->hdcp_context.hdcp_initialized) {
+	if (!psp->hdcp_context.hdcp_initialized &&
+	    ((amdgpu_runtime_pm != 2) || !psp->adev->in_runpm)) {
 		ret = psp_hdcp_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1325,9 +1334,10 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 	psp->hdcp_context.hdcp_initialized = false;
 
 	/* free hdcp shared memory */
-	amdgpu_bo_free_kernel(&psp->hdcp_context.hdcp_shared_bo,
-			      &psp->hdcp_context.hdcp_shared_mc_addr,
-			      &psp->hdcp_context.hdcp_shared_buf);
+	if ((amdgpu_runtime_pm != 2) || !psp->adev->in_runpm)
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
+	    ((amdgpu_runtime_pm != 2) || !psp->adev->in_runpm)) {
 		ret = psp_dtm_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1472,9 +1483,10 @@ static int psp_dtm_terminate(struct psp_context *psp)
 	psp->dtm_context.dtm_initialized = false;
 
 	/* free hdcp shared memory */
-	amdgpu_bo_free_kernel(&psp->dtm_context.dtm_shared_bo,
-			      &psp->dtm_context.dtm_shared_mc_addr,
-			      &psp->dtm_context.dtm_shared_buf);
+	if ((amdgpu_runtime_pm != 2) || !psp->adev->in_runpm)
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
+	    ((amdgpu_runtime_pm != 2) || !psp->adev->in_runpm)) {
 		ret = psp_rap_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1602,9 +1615,10 @@ static int psp_rap_terminate(struct psp_context *psp)
 	psp->rap_context.rap_initialized = false;
 
 	/* free rap shared memory */
-	amdgpu_bo_free_kernel(&psp->rap_context.rap_shared_bo,
-			      &psp->rap_context.rap_shared_mc_addr,
-			      &psp->rap_context.rap_shared_buf);
+	if ((amdgpu_runtime_pm !=2) || !psp->adev->in_runpm)
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
+	if ((amdgpu_runtime_pm != 2) || !psp->adev->in_runpm) {
+		ret = psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
+		if (ret) {
+			DRM_ERROR("Failed to process memory training!\n");
+			return ret;
+		}
 	}
 
 	mutex_lock(&adev->firmware.mutex);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
