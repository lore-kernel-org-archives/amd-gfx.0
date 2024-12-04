Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF91E7716E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 15:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31C1F10E4D7;
	Wed,  4 Dec 2024 15:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4MNWro/f";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CFA210E4D7
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 15:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLw0i74kxdnZxNDV4No3fVA9aGVF8d6xALSfGPW//LdjbrgA530XhPuuYMrL08ym+M3sVizHJSAi41/et5S0xn7KMEWA5DiVRH0BQMHIuxGm6jv/F/J7usbWMZS2kBrK0yhNX5Rx+fqoeYCm167KMhe7MoRve5lDuqglzjiNjgHm6mJ6+8OW/p4kzzF4qr1rtP3uIbMaiF81QkC7cggENKsanPopk6FfP7Db25tsRKokMWCpj9GC7wDY2E1HHTczCIsgsxyW5VxYgXav428h09ngboEyMQW9k3jVJ8zV0unpQhSXm3Aazz9q0H2beu84em6Vn19ZncxUF9JNWOjDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzqGKbYy+b4EKip6a4zlIjwdIT2SmRBU5Ud/W42QAJ8=;
 b=pHyL4T/DdSj8ObcgQ0LD3wE+Zg1xbHOIHKlJN5fumRmhQLbkpHlS+Vnh+51CTX+xf41HCm9/6uVEoOKBRMy0J0k7WqZkobC0MluW4UDJzuL/jtvhfSpJC5mk8NjJ7/eGz6mV9ff3w/k6SDAyJk1+eK+px7/SEzh7H4WdMR/laZm+fKEs8fleff1RoArp+oiPulbfOi7pYijdpT095UIcl7VoUUXpBpBYFBbQsgw0YrggzZyH3Un+d0Ckf02pNGhelZmIuiIs3Pgayu720s7HJZHiJHRcuGGz5/x3nI9SC+QzofGVfu5C6l2uq1Ewxq11tz0pr34w+QuCRb+N7zathQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzqGKbYy+b4EKip6a4zlIjwdIT2SmRBU5Ud/W42QAJ8=;
 b=4MNWro/fDbqT+Dkgu9SiWSfKYx5kVyiEhwxALn562QiGG61Kf0CMVdpAbk2r+/onwCM6NDm+7NzTUHbw8KMPMaqoV8/edBISoM1c8qhvhuXimX4+Z4ylBFEyVASuhYQdcSfXIGVZlF9DNt81XjIpx9UjAgYuCc8rItuKmTgmr4U=
Received: from MW4PR03CA0034.namprd03.prod.outlook.com (2603:10b6:303:8e::9)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 4 Dec
 2024 15:09:31 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::8b) by MW4PR03CA0034.outlook.office365.com
 (2603:10b6:303:8e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Wed,
 4 Dec 2024 15:09:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 15:09:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 09:09:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: Add mode2 support for SMU v13.0.12
Date: Wed, 4 Dec 2024 10:09:12 -0500
Message-ID: <20241204150913.3425270-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204150913.3425270-1-alexander.deucher@amd.com>
References: <20241204150913.3425270-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 3833c94a-7234-4d86-9a20-08dd1475a73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZZ4TWGTYCugvfCws2fAda0/tV6k6+GK87o+1K0A3rA1Ej2xmAZEzSEMZ4Kqo?=
 =?us-ascii?Q?RnM42xsmg8n/1gpMHsUd1usU+XkXGMouYBSHkOPY34cDN5PUAYLcrDWuyIE0?=
 =?us-ascii?Q?kiS6o6HWPprE56+U4p2iCH0EUomNsSV5PsPhEmD+s/hrJbO5+C4tZeKlpsJc?=
 =?us-ascii?Q?deSkscNFj0U3Y0JH0U6LbZ8xs8+FVd3WqWYercC/mPP+wyhN3lHzH9OuWB/O?=
 =?us-ascii?Q?+P3NGupTZWNIqauCCZN4Fg99zNGTmgjirACUkZ7IlQ3LNoGDSzZoZMalPOLg?=
 =?us-ascii?Q?Bn9+PjW7cyhpyiSGOZq/sk4nle3SlIODYKkggcTP/lRD0swtl958cb+9P9/t?=
 =?us-ascii?Q?oaa+f+ZqnjY4A5gM/T+S9QzZ/EOVY6OvAx1BbOx+c9+neeg6XZvn0iTEfc7K?=
 =?us-ascii?Q?sVebGuIz27nenSexFI5SzIa4Mp8pI7Dbzj2iYJVAHhY3UU6+JvrOIXetcD5b?=
 =?us-ascii?Q?y0GhefAuMj7fRpvHL3Jwb8C0+jKGL+EHtiTh1V1OkCEMjyyBHL69GJ2pK7jS?=
 =?us-ascii?Q?hp+th+TC5wMD6l2HOCqTbW/duWAB2oaM9pDSH7ByZYLj726BZ1wr523xZ+Ia?=
 =?us-ascii?Q?Kzn2czhkuKn9mETdNPIiM/xkaOVkpb1bBAwJ99Xnqf0n8NQrpt32p0u5eT4U?=
 =?us-ascii?Q?1EFS1tkfc8o028Ga/V1KIsBtByj32KSKCFIvrdbzFbmsUgHWkt6IwlywNfyD?=
 =?us-ascii?Q?Y0Sc7ObrnySAtXKkXcL831NlkwcMDKD8/bZihIIoWhOkCR1PynAP0GeMQF1P?=
 =?us-ascii?Q?YvU2h8fWG6igqkPVy2hfOHb2iaCOOr6/yi7t7fiYC7pDkcXTgkdPaWxX+kA9?=
 =?us-ascii?Q?LWKwsGjkoXXX5/8u9APWY7nPQfI5VzyGTSV0+6ZZqUOyDs1O2osv5Rrnoa08?=
 =?us-ascii?Q?Cdv+7RWH9XoPO6hq2mZSgXxTYrI9IiHqEe+F2RaZo/hhzEsC7dTxnZFnPb8J?=
 =?us-ascii?Q?fnHlryzK2aATw0jF43o9B1A4JeH7szY+F6SyrtF9mTCp2kqWImUJ15eKwEmV?=
 =?us-ascii?Q?lEsSjUkgiGcggbp13uYwFL9dui3Mw0PmIpVtwMU8PW/iInYD6BzhB5ryrsPq?=
 =?us-ascii?Q?0nUKtD2rHhFjjsn4WRQusBZD9CnQKFlMYrYJIHoMuJhDRrV8apIhENzVduCo?=
 =?us-ascii?Q?L5vEGVuyXbEz8mwWIgVob1cGBeTiy5p0AK+h9kmADcBImMqysNZ5DLCpaih4?=
 =?us-ascii?Q?BzC6FzHebdHfsaY3cbxOagEGlufOTbeSWIUVUJhuolqXFNhLAkkLjK9Q5N6f?=
 =?us-ascii?Q?kAssXsmDVLQZyZO21/AYg744OzuG9RdKmpDq/0WlzAPB5MN+lFqEkNH3q66s?=
 =?us-ascii?Q?giOnrbjt7kxMhWDDjgDhqaq4Jv9lhd1ED5mwwH+aNT5diEctGsJRGfCLJIh7?=
 =?us-ascii?Q?k5/PN5ZZ0AmG6bdNQHC4cid2WIcvblQxbm7Zg/0Qzz64jCeyBe4IEqiIUrFz?=
 =?us-ascii?Q?kWKyfR0UxBFEVfQPms3GM56d5y97LXLh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 15:09:30.4386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3833c94a-7234-4d86-9a20-08dd1475a73e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
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

From: Asad Kamal <asad.kamal@amd.com>

Add mode2 reset support for smu version 13.0.12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/soc15.c        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index a0acb65f4b40a..dabfbdf6f1ce6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -183,6 +183,7 @@ int amdgpu_reset_init(struct amdgpu_device *adev)
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
 		ret = aldebaran_reset_init(adev);
 		break;
@@ -206,6 +207,7 @@ int amdgpu_reset_fini(struct amdgpu_device *adev)
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
 		ret = aldebaran_reset_fini(adev);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 68bdd91f0a630..020530f978142 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -556,6 +556,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 12):
 		/* Use gpu_recovery param to target a reset method.
 		 * Enable triggering of GPU reset only if specified
 		 * by module parameter.
-- 
2.47.0

