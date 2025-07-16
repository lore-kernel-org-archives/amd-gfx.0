Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E545C83F22
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 11:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8B5110E7A1;
	Wed, 16 Jul 2025 11:01:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dUxTZIQf";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89D9E10E7A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 11:01:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjLLeoLkLvcJjZwGyTY1JvyjCka+xwjO0jEXO9H8Kj7BHo1RjJZSqW/NXsoFOtmhUNctUX3rGruiV+N+UdEKCKC8BUpgz8uzrR2R9zZXYF7MC2GP6zwljYr1jugEic4Rb6LknL3PM89D+60r8bk52hRIGwlaos4o6hjIBLuhvaDEX7F2PhkWCi4idYIV2lA/vj2XXQILDrivE1YeFG7xxGuz3XAfxKUueH3vsR8h87yy/FkQlzkBA6cyPDRNvpWZhUaoRTHkfm2FIcmeRaBqzKcTWHpiqKwwhKHX+bd4NpR5xTzNuI6Jhl8m23M2g3DE0Hi5E+GzcbRLaqcTJBjwag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeazxcXOenIxt3jtr7+ujc3Dn4y6Zsl9jZElXdKuyAw=;
 b=x+MCCLG/KoerTWYm93LKKNzl6x5+XMGSDzzfeQr/rjtQ/FaLA7ZeSXWY04OiS7mI5UPdoBlnFbemD5k96/xuZ6RwPcxBvqarX9nkATPobuIMXm64Csr+ZUnJzO14BtoCVpFL95oMYkyPrhL6QQPxXOkuJcdtX5DCIC3TnIV/7CdfMWQffDZyQTWN5vbvRKHTnNzTgArx0jdLGuW5Ya88iKfYuK55AU+JRxlSD9p2hlJJUCg5VJw3vfzYER6CVjFlIm0f3PpebNwC2d5EKcnnKRincQlwUpPRjY38xGhZA8BqMfq4qGDU1uh95UDeyOb0184rd134hSe3BC8GEqP6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeazxcXOenIxt3jtr7+ujc3Dn4y6Zsl9jZElXdKuyAw=;
 b=dUxTZIQfAkybldq5Iyx0fMCmeUk6oRLpnzNeTbUGoQ8PukEtI/XpgsfdLddfbDIU5Dcp061u0nHQ0TpomRMy4KoLb13CdSc4INw6FcNHz6FMaXsf9uzBQXj3oqGdc1rmtV3yDqL2eLPpmoKmGhDCab44UY6ApgVwWSW/zwXDeSk=
Received: from SA0PR11CA0059.namprd11.prod.outlook.com (2603:10b6:806:d0::34)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 16 Jul
 2025 11:00:59 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::79) by SA0PR11CA0059.outlook.office365.com
 (2603:10b6:806:d0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 11:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 11:00:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:00:54 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 06:00:48 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [v4 10/11] drm/amdgpu/userq: add force completion helpers
Date: Wed, 16 Jul 2025 18:59:30 +0800
Message-ID: <20250716110011.1670654-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
References: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 13265a30-47eb-4077-65a1-08ddc4580bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlE2bk14elBEVjVVSWl4TjRBelpydmNSMVhzdUY3Z3JudWJ4bnVVNlZ4czZM?=
 =?utf-8?B?M3A5aXA0UGRROGI5VU1JUFF5WDVXdWd3QS93aUFUbWVzaHZXdTB1YTJ5T2JH?=
 =?utf-8?B?K0xONk1SckhGamtIeXhPcmRNRTBYWDYzbFVtL3hpcGpXY1RJY1VseW1MbEtZ?=
 =?utf-8?B?dm83eE52R1IybC9ZNDhQaFdNeWNpVjJheWszVmJieWJNeFdDb2Uvd1VPUkF0?=
 =?utf-8?B?WjFQNSs4czJaVS9iUkk0MjAveDVVdWhTd0ZZNWhrZnkrMlhRclg2Sll3V2Vi?=
 =?utf-8?B?T25WU0l3amRrOEtlM2Jzb2J4bU9mK1JyeThMMnpjYkxENjRGM2tXc0RHbzdw?=
 =?utf-8?B?eHJYZlpHYXRpVi92OEtxRnJEZm9EdjN1YXN0c1hmeWY3TFZaMHFlcWFhQllJ?=
 =?utf-8?B?cmhTZG1qakF1RENkZ0gxNURjYWhJTVR1N3E5aGlCdVoyRWNwOTQ5cTIrMjJG?=
 =?utf-8?B?anBTQWlKYnZrMUdiRHhxc1RHd3ZHY2FIWVFualJyOWd2Mi90VER0dnk3eGZN?=
 =?utf-8?B?K2JOMHF2TzQ4VEYyL0lPUmU3VVhGUm5KanRJZjdiWnpaQnliZzJWVE9SZUlZ?=
 =?utf-8?B?Q2pRVlpwdXNYZWIwOXdYNzRDNFFIaDNqbEd1cjZxdUpHVGR2Q3JwQUEyMmh4?=
 =?utf-8?B?TWVHTjNKMmVMdzd4Wms5MU1nN2dLczNleE1xMDVhSFNvSVlhQTlER1NzZEV5?=
 =?utf-8?B?MmdVcU5CQUNiTVRWYzJYejE5WHZCcGxteStUd0FUNS9YZHBrR0t0ZlpGY3NE?=
 =?utf-8?B?YXJ2TWJNbU14Q2U1cElrZU5uanNZRVlWWUpGSmFFV05nazNmc2VlMmlpUTNE?=
 =?utf-8?B?ZmNwMGR2bmJ2b0NNOEE4dHdSK09LcUZ3RXZTNEpTMFR4am4vRmRYSTRyYUNI?=
 =?utf-8?B?VklBRDhlZEtmRjFmcHJMelFSREw2YzNzMnlaWE5PQVlqSFhnVjBSOXN5KzdS?=
 =?utf-8?B?MkhvdkJzWTRlZCtaN3RUbHlYZFltYWozdkZKalpqQ1p0V3VaR1g2ellLb04z?=
 =?utf-8?B?b1ZvZU9DN0pER1RGZHZCYVBpSGxxeHd5SGhrMFFGK1BscHEzS3o4aG5TY3dW?=
 =?utf-8?B?cjJXdDJrSUtlQ0lBekNVWlAyNVJTUWs2UDF3MUJ0YXNTVVdUK055K2FJdk5P?=
 =?utf-8?B?eG1aUExCTndWZ1NYaG04T0k5cnZPRXlBVzhvTHpKaFNrNVlCak9pSVFZZkxj?=
 =?utf-8?B?T2hyY2hUVzNhTFJqU0hWZWdRNUVlUCtCbThqeFp2S0hhZmtCZnBWTFRHSE9W?=
 =?utf-8?B?R0pETVV5dS9Vbi9kbG83RWxsakZPOFFHU0hnbk5LZDl2cHNSZFBaa0pIMFpO?=
 =?utf-8?B?QUZuNmMrMWNMenkyRm9UUHVzSU16dzZ5M0ZqOU14bW5qQlNJK2VoZkI5eDBH?=
 =?utf-8?B?NE9lZEl4S2NMeTdHU0xNZWlRMVppc1VYaXltYWNocTNzUVplUmRVcGtZcVRy?=
 =?utf-8?B?dXNnZWkyTDF4MWtGUml6d2hvQWxlM05nYTZXWnVRZzFta0MzQklHL0JBUkQr?=
 =?utf-8?B?VWZvOG9rR2tIcGxneXVMK0JHb2pKNnN3V2FaQU9rR05lNUFaSkxxSUVKNjJY?=
 =?utf-8?B?WnNuZU9NaDJ0L2xpeEhCL1Jhamc3UzhDWkMrd1N3QzNKZGRQSzNZVW1pMFNP?=
 =?utf-8?B?Nk5WMVRnbTdXQTQ5N0ZiNnM1SVV1aVloRDNNSDlLTndOZWFxK1F0Q1o5SnA2?=
 =?utf-8?B?YktsU1dyZWNGNE42Wm9ScDFEOXc0QzNGbk5HVGN3WHl0WC90cnJnZnNhTEUx?=
 =?utf-8?B?ZXhLQUVoS1FXYXZHVXI1b1o1UmJSYnVjdkJ0bnBLSFVqTStac1dqbWZ4aG5L?=
 =?utf-8?B?b1UvVXNwbkpwNVJHa3FpK0NCYm02VW41U0dDZjRqY0JFbjJyY2h6UE1YY3dp?=
 =?utf-8?B?NE1uZnlsSitGYW5vaDJRSlVYWEtsdW9BSERmVlBZaHBhVGlqMmFoV1c0WkEx?=
 =?utf-8?B?NytUNE1lZWN6RU9pQVN3VUlzQjBvQ25JWmlNQXRIcVVPR1F3U0lpSFFQZjZF?=
 =?utf-8?B?Zk9lWWpBenk5RmJ2MExJL3Q1NGU0a3pkZUtvcVBQSnNDYk9INEd6QlRJdWhi?=
 =?utf-8?Q?CdZvrh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:00:58.9932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13265a30-47eb-4077-65a1-08ddc4580bcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000
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

Add support for forcing completion of userq fences.
This is needed for userq resets and asic resets so that we can set the error on the fence and force completion.

v2: drop rcu_dereference_protected (Christian)

Cc: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 40 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a86616c6deef..5ad281aaf405 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -67,6 +67,14 @@ static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
 	return le64_to_cpu(*fence_drv->cpu_addr);
 }
 
+static void
+amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
+			 u64 seq)
+{
+	if (fence_drv->cpu_addr)
+		*fence_drv->cpu_addr = cpu_to_le64(seq);
+}
+
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
@@ -409,6 +417,38 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
 	dma_fence_put(fence);
 }
 
+static void
+amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
+				    int error)
+{
+	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+	unsigned long flags;
+	struct dma_fence *f;
+
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+	f = &fence->base;
+	if (f && !dma_fence_is_signaled_locked(f))
+		dma_fence_set_error(f, error);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+}
+
+void
+amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
+{
+	struct dma_fence *f = userq->last_fence;
+
+	if (f) {
+		struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
+		struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+		u64 wptr = fence->base.seqno;
+
+		amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
+		amdgpu_userq_fence_write(fence_drv, wptr);
+		amdgpu_userq_fence_driver_process(fence_drv);
+
+	}
+}
+
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 97a125ab8a78..d76add2afc77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -67,6 +67,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp);
-- 
2.49.0

