Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22452C87FCA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 22:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCECB10E197;
	Thu,  7 Aug 2025 22:04:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Io78T+cf";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29CE210E197
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 22:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxDbiYwRw+Vcqd5gRDADEgP20g74V4nkj1e7i5gR2souU+bsJ9vACogyH4Fn1dquKaPeSI58L3tCHGte5w2I6Wjiu84E6o6c9Ez+dAAw2JN1uC8NyFZwB8ooJKZx5Dm3joL8YCkOQ7kGWuchkZdugFb9lBINGRvhX7kxjP/VCLYGgxm7XrVg3QnyDju9C6nura6kYWQt/IzIotqhtbEUnSnLlWf/8ob74DdvYPmKKq9eT/ntyIs1hoTfBk54vGVQZOzEFSZfLrRWxki+CrY107aU2unKLSR16Chw4U1EZ5N/KJ6ggJpeUTPmw4tq59UCAouuP6JyIX1GbfPfGbqIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQ6USezJckqDWBBUBYpW4sLxRLIgxSdLRWm4ZItxbAA=;
 b=fcXWkIh63o4OezOWtCefq5endJBr+rFropBAijJes2KFJbJuQOQoaBKLZtjhktOIHkYOT5mQiL4rASoiTGup9/hwJ7ltr7jSWwhWOysQu9iuw8otvzFuOFciV+Lh0KwK7rOh1emEWCcc7ax9HNyF6MlCEvIGpj8uW/WwrbJWvYhNwaozejNEdB8QE5cJp+2tcvtITrLtUnropyQFRM0/31Qile/s0EvlJFzocTdUc6T0Os8nb1eJXfPjEaWyDHYvz4XTpWkrctRznKhj1KwcGLeD4mZj4sw5t27xzFjTxQsdJyTdP1lsVwsinhrJcZLk6kGLMC6P1sktQ/wzd3kg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ6USezJckqDWBBUBYpW4sLxRLIgxSdLRWm4ZItxbAA=;
 b=Io78T+cfOk8BUXer5B8Ud8Fhn57LDP21YukXN/xV3N+5u81P3j/YaCBn+XOlXyz/31fKg7O/TFNJ3+Mod9daGWZF651PhHE4p2NI+A8eCAL0Qy2krRXM4IFeGLQQFlYwdaCb7GRcDLELSjv0hQr00rHVYH/w/UTkZZZT8i24RdA=
Received: from SN7P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::25)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 22:04:36 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:123:cafe::32) by SN7P220CA0020.outlook.office365.com
 (2603:10b6:806:123::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Thu,
 7 Aug 2025 22:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 22:04:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 17:04:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 17:04:29 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Aug 2025 17:04:29 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add to custom amdgpu_drm_release
 drm_dev_enter/exit
Date: Thu, 7 Aug 2025 18:04:18 -0400
Message-ID: <20250807220418.37185-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: 002db11d-1b10-4776-17bf-08ddd5fe65a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QW8vOTJpUHNhMEtsQzhFRGFTZUdNZTE3SkZiS0tUU3crUUZ5c1ZWQWFLWkda?=
 =?utf-8?B?MWdSYzJVVVlqWk1sTURGTWxYbEZtVEJsWkFMeHk4eHQ5Nk44QnVUaXIrTG1s?=
 =?utf-8?B?a2htMWdsS3A0dTNTMFRyNDc4dmVuczNVTlRRYVpUWUNDQ1BwSW0zUGloSm94?=
 =?utf-8?B?bGR4MjNRVEhoZm5Rc3JVcUtFbkFXRVA1Rkt6VWFOOUN6dGZ5aFBocXVBYlFj?=
 =?utf-8?B?WTVWOFlqQkpNTmlIaHNPRHI5NDR0OU9mY1Y4b0k3REIwb2JVQ1V5NFhuNkor?=
 =?utf-8?B?cnRBWEZmQzM3RFJsUEVlVTYxdDNFYlZYWDI2cTdVeWk0MTVMakpuOCtZNTlr?=
 =?utf-8?B?MlhtK2hiTnAyUEgyUmtMTzREVjRZbG1YbytCR0J6cFpvYWM2SXBWRFhTR3pX?=
 =?utf-8?B?bkhMbkpWWWpHQjlXY3krWENxbmJ2Z0prK2hsSjh3YjBLNHF3QllKYWY4Y0d6?=
 =?utf-8?B?MFRxTHBWazRHYi9seGdGU1BRSzBvcE1tSjlHYlZYU2QwSVgrQUhSSVR1NFU3?=
 =?utf-8?B?ODF0ZmxIbmhFVnlIa2lKRWRYUytydmFWRXhyeHM0UldxaVdERUFaM0FpVHow?=
 =?utf-8?B?ZGErNDV2WXB2WkxxeFFSK3puTGJBV1o0Qnl5NlMwazRJNUwxU1l1cHhzUWRo?=
 =?utf-8?B?UldWS09GSUtOOVhSZnYzV0wxQitmbVk5VmEvc1JvY0MzTG5FVjVFZmw3R0Rh?=
 =?utf-8?B?UzlFY1ZzakgyRFlmTHFQUzZLRWZSVHRma2g0bUVIZ2hwL1Z3ZWF0TkR1UEJL?=
 =?utf-8?B?cWNScWpuN2F5N3p6WTJ3T2dGN0p0TjFWbytpL1NUTGlaSEduOGJlRlFNVzZR?=
 =?utf-8?B?TzFxMnh3QloxdCtIdExZNnlDZ0JPeFhEUVdqQlQreVN2VmM1Y2NnZlhpN240?=
 =?utf-8?B?Yk1NdVUvdytmTjFCREkwazhzL1JlZ3RNbU42NUVWUzY4V1VGZ21jdngwUEJq?=
 =?utf-8?B?cnkrc29Ra0NKaS9nN0FYMUVGUnhPN054SGwzSnRxclNyWE8yL2hVZlpsTXVk?=
 =?utf-8?B?SktsTk9WM2wzaWg4MUNXNmNJU1pUUVVkSUpJYjlzdkxQQ1g1ZEJXamwvcGtv?=
 =?utf-8?B?WHV3cFd3WDlLT1dJWENMUk8xL1EyZ2ZyTlpUK283T1E2LzBpM1M5VjdpeHQ5?=
 =?utf-8?B?WFpwRHBqTkdweit4bHVUZk5YaFlQb3NyTExtWUNtWXpFdEtwR25NZ0llMUln?=
 =?utf-8?B?N1RHd3JIWDVNMVQ5cEh1dTRHQWxQRU9temxTcEoxeHhOc203TzNoNk9hNXpS?=
 =?utf-8?B?bGhCRU5ndjVqZUxxMlNZZjJyNjJhejZucmFXczIrRkZneUpJTG9ick9lTDky?=
 =?utf-8?B?dTczUk5ROVRWVDRzbXdGQUJnVHdzNFBYNzV4dVY1WENhQ3VWTzIyY0YxMitp?=
 =?utf-8?B?TmNlc1FJeURCTTVJWUx0NnlkcmhGL3B3K3JFeUpLNFBNcWt3ZjJGYm9ZWGQw?=
 =?utf-8?B?RUgzS24zeGpwTUQ2OXMrd1hRUU9mc2tPSk12TkFqQXQ1ajNMc2ZSelVSSXhh?=
 =?utf-8?B?SkRMdDFZbEhidWJpTUZPNEFzSUM5WDVueXZTRDhDbFlRKzZLR2JScXBhY2tO?=
 =?utf-8?B?NHlPK2pIZzhML0RHUUFiOVloS2oyaUx2U1YyaFJBdy9iUFkvYzBtaEdBdVFZ?=
 =?utf-8?B?QmxMejdvMm1FMXBKelpPbzZCWWQvZnoyNlRkR3hwZEx2bXRoL2VKeWQybTZO?=
 =?utf-8?B?dDJ0WDl4eE5aMjlJcGg4Rmp1N2F1K1J1bnJkYy9icEd0RFFseE5NbzlnTGU4?=
 =?utf-8?B?L1dmZUhrZU5iYjdSSlZCODc4WloxMXVPWlo5U2VuaDlXZDR2cEEvdlF1OTBY?=
 =?utf-8?B?YkRoWC9CWE9TNmRla2h5WVBrNHRseVdnaktkS1luL2k2MjRraldwSFh0UFM3?=
 =?utf-8?B?SjFDWGJWNnoxTGgvN0RZMCtMRkhjcys0aitVb2dwcDlaTUpFRmtST09wNnNm?=
 =?utf-8?B?N0JIVjlFYnJpcndKWVpMd1RMQVExTHdyeTAxVnVneWJLRm1xcjVSbi9MYzk1?=
 =?utf-8?B?L296TG1DVGJuUFpwdXB6S3FmTGZlVVB5WFVsNGIwelhybXd1V3FJcWZ5SVVq?=
 =?utf-8?Q?nee5vH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 22:04:35.9673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 002db11d-1b10-4776-17bf-08ddd5fe65a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

User queues are disabled before GEM objects are released
(protecting against user app crashes).
No races with PCI hot-unplug (because drm_dev_enter prevents cleanup
if device is being removed).

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4ff3a2eaaf55..32caaef522a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2920,11 +2920,14 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 {
 	struct drm_file *file_priv = filp->private_data;
 	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct drm_device *dev = file_priv->minor->dev;
+	int idx;
 
-	if (fpriv) {
+	if (fpriv && drm_dev_enter(dev, &idx)) {
 		fpriv->evf_mgr.fd_closing = true;
 		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
+		drm_dev_exit(idx);
 	}
 
 	return drm_release(inode, filp);
-- 
2.34.1

