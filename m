Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1013E91269
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E5B310E388;
	Thu,  5 Feb 2026 06:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bm1/LzKU";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E246610E388
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:51:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pS+gbiApTDO9QRT4VTvmkngEpJJeUir4v9nnyTsR8eS7k9nWgQc6EL5Hjdq3oLMQVkVl3qeTib2xg2EOCmXtCgmRNVGTiHcHDj4nXOBQ9rbemUPwwFVLP5ijWs9lBbtEfVdzVsTuGokbi0OJzOSn5WEestLDQ2O0OklBufJIT7kTvB6kH9wLsUsrpR22SoW7wmdfQeyL4+pxV4ecuHAD6pS2kvtKJdG79riRmowB/xHXw2rAX3VQNYNMn9Yhw9JOAmMeK3izAspf/x7dn0QDqivDgGHJ7OncY00+pGMu67AAB9nT/QtGOHM9dzDGylmNDdSifMRf2s09qNSCfK0vCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZwKWA1TTftigqlVKuYywmHlJ+mhcwu8sHBRmAvdhR0=;
 b=r+XmBINn6jFdpAJOHiBLEmDBTaPHGFb1lzutYxLPub/TTh1es7xtg//FVCvehlegZIZw/CxU69J0zgrFqH5miIMLzVHXM5qY+tsnmsz4Q3i2Qx7XjOLavzWJtJn9MaE+BPT8EcOaMmlQCK69xwe+W0lIGIIR8OJTiQ5arOge4s8Gk61fpirIHBcbKXoPMWiSyCOzyfjzZgePfKKnmZ93d5eDE8k7YFqBBvBPyd3iAh1TXr8Q15dX80wPDlP3x9AhLEe3rddrguZWYwvdZcR+1AWQGj7D8sCNU1jjj8bkMqAxibXc2ksaijTtnbbso9yxOBOth6pax9532nSImsnbdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZwKWA1TTftigqlVKuYywmHlJ+mhcwu8sHBRmAvdhR0=;
 b=Bm1/LzKUeIKB+wsMtotfJaYIUp5gp0h1/kZrGWx9FlwLX0G4dboYhrXp72tCkBjt3bP73Za9iViuvXQLHBwjgNAvPNwXZrAtX04b45sLX8aAXtzo7KJgdFeHZajMPQG2OfglmJgywUSX+uYRKpWEIOsjoiHfedOxuPR90YZTzdE=
Received: from PH7P221CA0052.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::23)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 06:51:46 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::78) by PH7P221CA0052.outlook.office365.com
 (2603:10b6:510:33c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Thu,
 5 Feb 2026 06:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:51:46 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:51:43 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 05/22] drm/amdgpu: integrate PTL control with PMC device
 locking
Date: Thu, 5 Feb 2026 14:51:13 +0800
Message-ID: <20260205065130.654921-5-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9b3344-8ce7-4753-a4a9-08de64830787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PNzsA5WqrTekCZmyY75WiAsrHySVt0J/+3kwF6CZXD3zrkJcYvnkY8mpiiRP?=
 =?us-ascii?Q?/S8DlTbkcacsEH6gq48o2mSBkdfcSnmrEsG7mIcMsc2+ekKg7jQrFm8+pMZA?=
 =?us-ascii?Q?zQBIOSocM6PV5VqOYj/N98s9UjxSqFOax6VPQ+0uZnRbSe8EuHutzFFIiST+?=
 =?us-ascii?Q?+1SWZxXQ0prauAjEy+wDcmpxQObneuTn+XGii6JQyjvnln7eJw457JpdxHIf?=
 =?us-ascii?Q?ZmDUfDXHxExv7nmI4OB/r847irsTspLO8N/Vvg9Kbphfb7W3EpZ4B/FH1fYk?=
 =?us-ascii?Q?oZ+SZgyXNEqIreWLZ7ZfSgPzIO4EYVvVo2CU1Zkj8nBlBydbhh+ozhB0HK+S?=
 =?us-ascii?Q?N8k2zTfMvYd5Lxs0j3jUCDxlqCUuDWVeszMqsP9PuFsb04cwmVieRZgho8Ka?=
 =?us-ascii?Q?IZ5IxCuoYNWpwKiL3W30aK0WZpvBZKKowBjICuPOUCWccNKSIcmo14Kt/spn?=
 =?us-ascii?Q?uWH/ngsinEHENX3iq4PcgUnbkUTZ3dAF2E48LtMZEt6a7n8xbsMsBIHGbWc7?=
 =?us-ascii?Q?OadoJeujW3LDsmsQ+ffiJzkK2I1uromOLJwIgv9Ehp3MHO6XbOZWgZOw0W89?=
 =?us-ascii?Q?oUwHjTBcNNnPs/gyhRO9zWgQ/OWDH1+JNwEmiAlIFegJNXTpRwmUHoNjOqes?=
 =?us-ascii?Q?u1ygNZFTXHU4dQSmwXfFVwcNukkGIiFXbshtLcoznLtRC1Ek0y/OAqmUbhVj?=
 =?us-ascii?Q?eGTIwaySBHE/jUjmh+Lo3TsCz5orh6RRdhtJ3sjA7pn3fRD5V1cwAe8ba3fl?=
 =?us-ascii?Q?sxxjb3dQAsVibwMypdjSLvVNHcZm7Wg7xjY5wjfa7bUcm3JsDpH6C0YBEpZb?=
 =?us-ascii?Q?o1yIlMui0zD9LLlLXJkqS66HE9dn2S9Jqo0g+cVD50IaAy53t4tlA7MVrAaX?=
 =?us-ascii?Q?6h+dO0C2BuoUBxFSR9tjhi8n3kLXirqSa9P8yc0bwK3JE1zEIzndYsTti0mN?=
 =?us-ascii?Q?R7l3sHTBWQMrMHO1z5vhzRbu2q5Rbb5FB9Hi5EkGIxboA9do7KnuJMErayie?=
 =?us-ascii?Q?QC0I+Vcqx13g8tE6wm2GW5nzrZvsY/4PkDIuPpxJJQHgEnJ+ijNmfsPUXK56?=
 =?us-ascii?Q?N9ZNKzIftyA7cE9KUzNEa+z7h+jTY6A/UN5mLq5Xwl64Fu2LNjre3evpI2KB?=
 =?us-ascii?Q?YgOZMA6di9VNh/eWXnK2adEG3BoG+W+tRW20f8g8hs/VrbEtmehBY5IULU3R?=
 =?us-ascii?Q?Zr3o7dkCoqwksNn5GHjlGonBhUUk/XJuzp0anSGsz7LTePND+iiWORhZyu6S?=
 =?us-ascii?Q?2ipwKvI8/5AA/vTaDI7j6PGI1itpIN+ubOIrxLY1U+slSPKaHCTi+gnSdStn?=
 =?us-ascii?Q?NoNhobvez+GaWwgcvR0noC4sCNV1dkYfhmklg9bagN1HhWQy2n9Qb+mFhJse?=
 =?us-ascii?Q?8oDF9RANiJ44Q0hijPkgleApRDn91WPhlMSMkGH8Qr148Il2qpWudHVGMX/1?=
 =?us-ascii?Q?ykRS7F+FIwtuTUgwaNV1wYTiytwP0Tn0Xghyixs+yDn39C4+5Cbvzp8TaEad?=
 =?us-ascii?Q?0ePCVzM5EwtaE+Nwlm+u81B3Gexq9u5b8700OLUmN6WUysM74bQQ7+DUypOa?=
 =?us-ascii?Q?+jg6eUsrpKFjzwH8s+ZFe8FakfvAx61s9OfWIhF/pw7IUNcVxkVIbT6hxGor?=
 =?us-ascii?Q?KWsNIjKrqA3HAne3tfhxyELm4IANakWy7DShtTfbYPphjjZsUjW1f8bmuXhm?=
 =?us-ascii?Q?zpUQNQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FG5HtBDOpyW/72hBTwjBvtmiCsyitINDSpn+VYGAOHG5Oc0ZLKle/MKNLspXShYiFotX+h1iJySNmSw727x4tO2VNEz0Qm0CQiUuWQ4qTSo4bqU/1nI9QrSpoNA4eR+/worAuRpKmRH2HQqyOmwOv45/VcXFDca8tTSseoUv9pKw9ruLFHLD13J1zUq4aMefxBid99gcPSbBO3yBsFL8cf3W1X+8/jUbbzQhw+N2P/b5ScH8C6UlbmKxMR7PxGzY9YwIVbGm5PJA1MD6fuDMmMeTWJ2qmIFFQahh3gdl9xujyk4WfJVZckFRBXPxZ1ogciqAIAKNs/rX/R08m6Ib93YtWuyB8/b44s/2gor8+K6CVrrcxkwIid539RBRc1+q/viU94TXW36A/Aum3cMIU0UVSTz1Q4w3ebRJbEnU5kGgZMzcyppH3bMhRkF+K9QG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:51:46.2136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9b3344-8ce7-4753-a4a9-08de64830787
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
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

Combine PTL hardware control with the existing PMC device locking mechanism
to ensure proper synchronization and hardware state management during
profiling operations.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index dbb111a33678..1e619eda8433 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1764,6 +1764,27 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 }
 #endif
 
+static int kfd_ptl_control(struct kfd_process_device *pdd, bool enable)
+{
+	struct amdgpu_device *adev = pdd->dev->adev;
+	enum amdgpu_ptl_fmt pref_format1 = adev->psp.ptl_fmt1;
+	enum amdgpu_ptl_fmt pref_format2 = adev->psp.ptl_fmt2;
+	uint32_t ptl_state = enable ? 1 : 0;
+	int ret;
+
+	if (!adev->psp.ptl_hw_supported)
+		return -EOPNOTSUPP;
+
+	if (!pdd->dev->kfd2kgd || !pdd->dev->kfd2kgd->ptl_ctrl)
+		return -EOPNOTSUPP;
+
+	ret = pdd->dev->kfd2kgd->ptl_ctrl(adev, PSP_PTL_PERF_MON_SET,
+					  &ptl_state,
+					  &pref_format1,
+					  &pref_format2);
+	return ret;
+}
+
 static int criu_checkpoint_process(struct kfd_process *p,
 			     uint8_t __user *user_priv_data,
 			     uint64_t *priv_offset)
@@ -3229,6 +3250,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 		if (!kfd->profiler_process) {
 			kfd->profiler_process = p;
 			status = 0;
+			kfd_ptl_control(pdd, false);
 		} else if (kfd->profiler_process == p) {
 			status = -EALREADY;
 		} else {
@@ -3237,6 +3259,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 	} else if (op == 0 && kfd->profiler_process == p) {
 		kfd->profiler_process = NULL;
 		status = 0;
+		kfd_ptl_control(pdd, true);
 	}
 	mutex_unlock(&kfd->profiler_lock);
 
-- 
2.34.1

