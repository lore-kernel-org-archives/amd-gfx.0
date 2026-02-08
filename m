Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0939EF06E4
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Feb 2026 16:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A61110E305;
	Sun,  8 Feb 2026 16:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sHI4SAWp";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B0510E301
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 16:43:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f38K+v71RGxKyP/gjqY61EgiQC4TDCSfbgnEuw/ZPixcrdivSP/+BQ4m9+dMZjILahb6e6Zl9+zZ7IVTBI5ooHiJ1SIYHPgWhm52+zvr+HtcaoorjY30c8NaGpQDVGAOedJqczoQ9Iam81jOWdWta1tn3eqG4GA8v0G1oRWaol+l5IcKuL/xqoWK2QODqmoUiJ49Ad71MhbWbm4lECO03+OLkVKCe9wlNG6W2Zf9QeyKzIKCXbZeBKz+i3d9nzFHMew6MIwmu6pZoqqTY24VR5Tp0qcWstYxFQ8XvFD5aVTTG4u6F9H+EtGv2f0Y9wak9lJHLbv8wzvsusnOzaV82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8uBd9mSJzn+KaSBva617iwJoOZxGPdOfnToCblVdfA=;
 b=aqe15LFazseJyLQVSRWI9pGl+3+xNWQG9ZHARfH/DO0A5P29RuEFLZTN6B8062L29cqnWc/nY1tBKb5ryM849mba0DiYWpB+2FAeI+u2nYxlgnmXB/37F9bsWgYJ/0IEWFhsosUbg3KZpavAislTMI+IRScvcYaz3NiJPvC9nS9B2IcldPksFC8ZNM4CZVLrHSwNtZLdl7Xsql8ldimbD6UZlSmNWgZJ1FJYI0JHVMX0EJGvzVKaMBOyO0imQestwpRjMGcBAmpEwv4XFI7vitUZ2FED3qMFtMopfH2Xkt//ND8pco5HknErXhF4YWiN/ptEVCC4Is/zrjdxapct4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8uBd9mSJzn+KaSBva617iwJoOZxGPdOfnToCblVdfA=;
 b=sHI4SAWpEmaSLzH87BBGFBvSKkvhoIAssxYAWqKXqIREF6r8XFKiPGyOc1VSbjvhIYuUJftT5ztgMbi8A6CsurBrxxcSoZ50XzP2IPvt13Nl1KMP4rMfc2ycZ0igfVhbFJvT1IMspG8q1Fw2YNiE3PJhCoqPfgq0evZ+URslLhw=
Received: from SJ0PR05CA0167.namprd05.prod.outlook.com (2603:10b6:a03:339::22)
 by SA1PR12MB9469.namprd12.prod.outlook.com (2603:10b6:806:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 16:43:46 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::9d) by SJ0PR05CA0167.outlook.office365.com
 (2603:10b6:a03:339::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Sun,
 8 Feb 2026 16:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 16:43:46 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 8 Feb 2026 10:43:44 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Yifan1.Zhang@amd.com>
Subject: [PATCH v2 09/13] drm/amdkfd: suspend scheduler during PTL re-enabling
Date: Mon, 9 Feb 2026 00:42:08 +0800
Message-ID: <a3ed285fd7d82e1d81465c15a105862d055b0c69.1770568163.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1770568163.git.perry.yuan@amd.com>
References: <cover.1770568163.git.perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SA1PR12MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7c8374-e674-4c15-f728-08de67313a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pDatnAOyTlaD3qWNoqK9EEZH6N8JXPZ/1RUDvDgmhsGPdVH4D2oNwmjdeA4z?=
 =?us-ascii?Q?XtCZIt3/16N/tiqwYwgNu7qX85TmySNU5LDmTs91fiteZC5k5Cck6gkSH3Ph?=
 =?us-ascii?Q?rbRFbFPcAdceDm/2YTIcH0bt8ii8Z/UbiXAFLcbwzAU/teDMzUZxY2JWLMU4?=
 =?us-ascii?Q?OU0P9rNvr/jIFCpqcu5PiEItgX3oXtpUIW8/g47D8gVBoqWVxRO8Gl8L+SdH?=
 =?us-ascii?Q?uPtjWC726NT0VdkHL0D096YPzgiZSlY8Qo9KsIVk2mpgnQwljezJYChGgWvh?=
 =?us-ascii?Q?UCAbWVMs546AcSpscE0F4wCe2pPpATYbhFyYmHyao+KpBE8FNBYJ2v6z25Ga?=
 =?us-ascii?Q?Z2OdNhD2t09OXQfZyI0HrnJVYQIGHIQGOcDp6y/yJj/bvgt0/FTQrfQ2qJfl?=
 =?us-ascii?Q?1mTpIZ01UhQtp9dHgjIp602hzcJ2scqQRzsPDve3C/KUQVQzon7/3Db3uKeK?=
 =?us-ascii?Q?r+T+BEzxMqmriCBCrV1DZT5Tc4TCreAyY+TqNCgZxZArEB3lu0CUWuPpMpB+?=
 =?us-ascii?Q?uAgClJolDsFu/vflZoXbbDShLfU4koupL+hZTWOCbKGKraDNV64hxYBC7Iff?=
 =?us-ascii?Q?IfdlxPzuEQXKBgrXzH0ZMTObJpNXCDKRno0tDRoeaENt5Z1coQxX34PqgqHf?=
 =?us-ascii?Q?taroh05jmo0vofoNeB3E3owcRmt9r8Cg37eH1YA3tgmSE7LIHPX9QKlME/1c?=
 =?us-ascii?Q?IEMnebZzwXSTpTd5zuepEfaSuzN37bOPGXYetszpbtF2H0vDTgrfJghnV49T?=
 =?us-ascii?Q?ie3Dxl7CJ/EuPY0yWERaduyeimfSpnXTlixEjmKtxqdJc2gxGj/bLv6Ye2Nc?=
 =?us-ascii?Q?hIWYjJNNspLrNCxlAosrWYhGE0kdlUNZXMas/NadaNwkKeAU8vNpFqaGezbK?=
 =?us-ascii?Q?b5cnHatC+WGVI5NoiaYR3fbuos8QGZOEKi4tWH7s5VRkQ1rSmRaJvyBfK2vk?=
 =?us-ascii?Q?75FpXn5cAmFwDuyr9HMBqlmWzxp1Jl1k4lmBvvSb2eJNBHxT9uoqb6bikLnI?=
 =?us-ascii?Q?iWHW9/zm9WLc0zG1S7w4kvv7GUoG87zfZA150p0eaT1KbxFuBkOyadDcDTAb?=
 =?us-ascii?Q?lIvj7AF1X5KMTC/qy1v2lggBPJiOYpq9AcftqCD4LecRbHASp7vMZwKPsixf?=
 =?us-ascii?Q?tQ8oP+BHnkncYQfYR2wx0Ju/xUWxbpkc43CZsAkiL4p8DVpNH23HXkHA9WKV?=
 =?us-ascii?Q?JjMoKJSuS4c71jqFxHH3TQxjGdbXyMaawk5qv7UPOVeKVHcCJ0uyiFETc9Vt?=
 =?us-ascii?Q?vQUeBFtTxKO/xpKHUw2dhw0cZQ6TB8ZVI60cB0zx7S+8RrwIeJ/QbQs4Q4l4?=
 =?us-ascii?Q?CQ1ip6aLqYk1vYK4RFo7zFhxsehS3EJeQtiO0RAGLypzfzsayJBQqROOnuV9?=
 =?us-ascii?Q?V0B4j6Gbf0aKm4ZuomQFvcOqQub8wW0x/DkwoJ7kkMnajY+NpORCjINQYoiZ?=
 =?us-ascii?Q?IPyFgq/X9SlxWQm71+Wsls5oxs3vR8A/3YXXQhmuXrIqVKMSu3fCTpV078oJ?=
 =?us-ascii?Q?u0URqTcXjCUtRACU8+kz99gDKXbIK2qfzxx3lZBV5T4zXx/r9h+b893G5qSg?=
 =?us-ascii?Q?4RzYdZnZbEpjGEA6hH8G1Nj30HdxlgBcDUudS2R+dNyaphszKuVnSi5NNpVP?=
 =?us-ascii?Q?++9ACTr1jrMUFAjYNJoaUSxxb6RKFa2Yy8IjFwvG/dSxjlWiGigqKdQ0ADKv?=
 =?us-ascii?Q?655YTg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kp1U6RNk5qsBdiaQMf6JDLlvnekw3JWBql+ECao0X5K5ujmfrTVF3KUL0R6WIPTXECgMKb/QvougCrNjJB7WhUAa1M5rCJKSadekEJJpX25LrxMZoi0N0INcvtcDlnzzGGrfA5SdzPKZS7ayT6MYaDUgZC3oOaiilQm4PemzdJCURv8t7v80l+Je0ZwcFwwssP8S333cBpg4/A/D/g5wAJfct9er+M7kmnL6Ne0NWkeG2X5TD7KK4VWTZA6DhurXvWSh3yr1DIplYZ1FKF68jEGLOaPxhZ3rY8rb9F3xuUgA7HRK41jMMcKPhlTA2LdtjdAJEK9pQJi5bdy80odiXbsx6M2XvAnW4bHKWBNNgup1Mj/Okqa3rW409WWYXwJFRoicpsE4AKjG14eHDvs3x9jnr7Hr5xZgO/gmvJWMpr1Vu2I9eOh9GDhNCihgt1+h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:43:46.0499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7c8374-e674-4c15-f728-08de67313a40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9469
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Stop the scheduler before releasing the PTL disable request to ensure
the GPU is quiescent during the PTL state transition. This prevents
potential queue preemption failures and GPU resets caused by modifying
PTL state while waves are executing

v1->v2:
only stop/start the scheduler when the PTL state actually needs to transition(Yifan)

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 30 ++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 9a23621542fa..d699d0354bda 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1780,10 +1780,17 @@ static int kfd_ptl_control(struct kfd_process_device *pdd, bool enable)
 	if (!pdd->dev->kfd2kgd || !pdd->dev->kfd2kgd->ptl_ctrl)
 		return -EOPNOTSUPP;
 
+	if (adev->kfd.init_complete)
+		amdgpu_amdkfd_stop_sched(adev, pdd->dev->node_id);
+
 	ret = pdd->dev->kfd2kgd->ptl_ctrl(adev, PSP_PTL_PERF_MON_SET,
 					  &ptl_state,
 					  &pref_format1,
 					  &pref_format2);
+
+	if (adev->kfd.init_complete)
+		amdgpu_amdkfd_start_sched(adev, pdd->dev->node_id);
+
 	return ret;
 }
 
@@ -3310,6 +3317,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 	struct kfd_process_device *pdd;
 	struct kfd_dev *kfd;
 	int status = -EINVAL;
+	struct amdgpu_ptl *ptl;
 
 	if (!p)
 		return -EINVAL;
@@ -3322,13 +3330,22 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 		return -EINVAL;
 
 	kfd = pdd->dev->kfd;
+	ptl = &pdd->dev->adev->psp.ptl;
 
 	mutex_lock(&kfd->profiler_lock);
 	if (op == 1) {
 		if (!kfd->profiler_process) {
 			kfd->profiler_process = p;
 			status = 0;
-			kfd_ptl_disable_request(pdd, p);
+			mutex_unlock(&kfd->profiler_lock);
+			if (ptl->hw_supported) {
+				status = kfd_ptl_disable_request(pdd, p);
+				if (status != 0)
+					dev_err(kfd_device,
+						"Failed to lock device %d for profiling, error %d\n",
+						gpu_id, status);
+			}
+			return status;
 		} else if (kfd->profiler_process == p) {
 			status = -EALREADY;
 		} else {
@@ -3337,7 +3354,16 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 	} else if (op == 0 && kfd->profiler_process == p) {
 		kfd->profiler_process = NULL;
 		status = 0;
-		kfd_ptl_disable_release(pdd, p);
+		mutex_unlock(&kfd->profiler_lock);
+
+		if (ptl->hw_supported) {
+			status = kfd_ptl_disable_release(pdd, p);
+			if (status)
+				dev_err(kfd_device,
+						"Failed to unlock device %d for profiling, error %d\n",
+						gpu_id, status);
+		}
+		return status;
 	}
 	mutex_unlock(&kfd->profiler_lock);
 
-- 
2.34.1

