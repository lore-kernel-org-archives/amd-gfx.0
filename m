Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A8FE77189
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E1310E9F4;
	Tue, 10 Dec 2024 22:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DYs8v9Wx";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 389F710E9EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkZYv1pYKUkZJLDH+scMvHReSfYReT+kyjelnGC8ZSJLwJILkCw73xFUfRkEXmK37lvYQwYDVRwRXPCnBFan4pHDTpZpEgGpXEZFjlq9BSfaXQG32u5KM3XIoz7e1D0Mt0+3bkFHpCm7dUGSztzPESGuJZcwWER9npgPMzVAu2WCg5MH2uyT3ZGZCiS7ZenoMot81ATOV3omYHPAbVwy+cH5EA+VIRcTFRO0IBpEK1EzMfilwn145j1Le2pxJ35KqzOVss+jNYqw63nPunBGBn0gO08AhKRIFyfTkqnQ+sm510EwPUrg+1zxJfSRhiMUDl8FWfdWaBuHzKYffkhkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpMBATgRXnyUd9iTbI9gRCwb+Wlpxgy634DWybGw9ek=;
 b=w8ug+YbwiV2xuTwNqcoQCdlb+vdzPoUQmoTDBp7xvEAXiL5qbGwE6ioL6RMyZMKmM+9EEzE3xhTZ8UBtKhQc6K2pZqzY0H0EfLIcLpD8fDjX8bZrJFGJZ5SgwL8W9QeCsz48iKGVZA+GO2ylwG0XZ3VH5MpmZ5gzzv7HDG3Zt1OcecnX1XUsfcSRVvliK8oToprVjBSSi3RnLJ7iX2Y3797DS7tWLQcCwvbscClun2wnsrCMLTzLDKAaGXLg1yu7iGHBkgOfuCh5Lku8QZZStw/wOlKMoTBSvVHbqQllrF+VkTamd3zsvNvigTG2RKchBap5Cgoc9XJ7XUsyq9Wbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpMBATgRXnyUd9iTbI9gRCwb+Wlpxgy634DWybGw9ek=;
 b=DYs8v9WxGoo00Fekrl3XMDZw8IZvnBUuCxf7ZG1dR6HejbRbn8z+HY4lUq5RBhEZwGV33q7wUY04UYstQ/ZNd3NKyUAgBzZbPcA7gglZ9Dq0nVzi0g8Luwig8DZcQWymPOhwAIZBbmIUicDe6jACizi4Qum6wi5AOgpFYnuAob8=
Received: from MN2PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:c0::33)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 22:54:16 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:c0:cafe::6c) by MN2PR05CA0020.outlook.office365.com
 (2603:10b6:208:c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Tue,
 10 Dec 2024 22:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 33/48] drm/amdgpu/vcn: add a generic helper for
 set_power_gating_state
Date: Tue, 10 Dec 2024 17:53:22 -0500
Message-ID: <20241210225337.75394-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|CY8PR12MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 843f9e95-f82a-4003-7d9f-08dd196d918f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wK5hn5UcdPDWk8rkubURShiE0nSdQ17nSBMczgs0SoLr78V9SMBgNLkLp1Oh?=
 =?us-ascii?Q?6H7P2MAt7LQQzSj/iGZkwuhZFRoJefPMeos8hbEs8H9edBcPiXReCvzbB4if?=
 =?us-ascii?Q?qfqxJorPzZu64pLIaa5An0KFXMqN0aCr7xSn9aNheknW8bf8tmf//RU4I2vp?=
 =?us-ascii?Q?v9cyWdqRll86x+FbVHY02PDhJu3gXFwXXyhk837oaGRE8XetT39Cl/B+LR3k?=
 =?us-ascii?Q?4eHYrNXPwuVMf1PNZHMhCRGHzhc+QhVvlimjNGhLLEgaQPpdLlvRh943X4AS?=
 =?us-ascii?Q?WquLHTywP6qRpzRdgWrMMs/+yR4rWCjiPwgyA4sbY2YGHHGw4YM9+VWpFdXb?=
 =?us-ascii?Q?UeCGgzKN/vdOsMJYMOIt58IrtZxKcqOx5Pd5qcAX8aewW1etxa2ipWmMh8Kn?=
 =?us-ascii?Q?QEqq8Hvoq8EKoL90hIALpG/SN6oB7QsZdRW4bq9tB592BeaNx7oU+8sjMuDR?=
 =?us-ascii?Q?o0QwhoK6GO9mZOVseErhlaUwpgkcNM+1vImGz7lonwt7o9P1KeEmZ16xMoLa?=
 =?us-ascii?Q?mzZV1BjbHosPf7B9Crq12oINgru0ZVU8mNIw7/3jcRBiPQHf382xiFRfL/ih?=
 =?us-ascii?Q?WzE5sfU+90LVsI0bnUvHzBtnC3NPdm28pYK9iWciiTfPdnc6GQbTPpgFY3uJ?=
 =?us-ascii?Q?YAsyR8gcSo5pOsZMCvWUX93WTAjDpjpOvBd+yldqXia/44ARwDzPosxWaEcW?=
 =?us-ascii?Q?5taw76BDfKomdfBzOn63y6qH3X3XLerpF86hnB6oEZsxS7/4/FxHO8syptGl?=
 =?us-ascii?Q?XDSMjlKyh4icMFrJcHOX8bfW8Cr0K4Hy5pvyUy2EBGOECzSxa6u8FqvrpM6s?=
 =?us-ascii?Q?/cA17fOCcjaGtoM+lpCNBntYw/KocxGp3bAFrfehCXTA5qjyRNcqk1sWQap+?=
 =?us-ascii?Q?eBm9NdCYp0Hkyla7U2+BzTnpZHw0GjS1s1iB8Cc2wTS4EDgect0mi3fbgpkX?=
 =?us-ascii?Q?KPPtVsvFAzMVZl/wiRwhPa8er/HlbheUsywbygJ1nNCya+SDvgedbtst4Kgn?=
 =?us-ascii?Q?8lld+IE2sZSvGGqT46q9DP/Me5vqVaXYi762NrSLlJIXMhDPcEh3Esrcu/IP?=
 =?us-ascii?Q?9vKPSpNNY2chbOpyioL30LGfhbvqk65Y4kWkSycPRuDwlJLgfzI2giLEZ/9B?=
 =?us-ascii?Q?nEyJCYtTU+Zul4TPKu6LgJYAv1pa5yQF6dqV6XwHEimKN5GBGbuu1gEsymul?=
 =?us-ascii?Q?YIeT3TpMuCjPcGIdEpxv6Hmn+OTTBP73UEpi7Ug+kwvxKWVuAe2uyhiG2Zv8?=
 =?us-ascii?Q?Skpd1zcFqWrfuRDUROjer2Uf+b4a9qs4FDK5uVXvB507nWvfCwYwOzIeBkXn?=
 =?us-ascii?Q?H+v/G5FSivAJ0+b/4Dd82SKZ3FbsmMXY9LfqA0+P1W81pWhbH741yjKxnuL2?=
 =?us-ascii?Q?69ZUMoLIUVvj8ENGYqKs0ItXDN64MsafhEKZXZj2Wcq3bhPnQw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:14.0083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 843f9e95-f82a-4003-7d9f-08dd196d918f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313
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

It's common for all VCN variants.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 04a95365b7095..bced3e7318b02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1397,3 +1397,26 @@ void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_vcn_sched_mask_fops);
 #endif
 }
+
+/**
+ * vcn_set_powergating_state - set VCN block powergating state
+ *
+ * @ip_block: amdgpu_ip_block pointer
+ * @state: power gating state
+ *
+ * Set VCN block powergating state
+ */
+int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
+			      enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0, i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		ret |= vinst->set_pg_state(vinst, state);
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index d7467abf9cd5e..29e90019ba838 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -539,4 +539,7 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev);
 void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev);
 
+int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
+			      enum amd_powergating_state state);
+
 #endif
-- 
2.47.1

