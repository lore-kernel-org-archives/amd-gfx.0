Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5027E7716E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 15:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A56D10E296;
	Wed,  4 Dec 2024 15:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lYR/mgbi";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75C7210E1AF
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 15:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRt0bfTnIT2IMsxV9fd5gH4j7o5pd0wNXvsJNMd+HdVvCVGh1VKO9ZBz34EIwZ6BaoRghBRjt5amR20ZZ6foGQDgMQmaUZPfXTEuy69Z3mXemgYj0hRsbWIUf3QnvRhNNO391qAelbzRp1Ai1FntzzK4drjvHadqK4oUsKK5Md9/+jIfahGRmSGmJt98vD5zHHVQMMGnBqG2frxzpP27uFsKlAehRoHjhtBedkNuxKnm3murZvglPdhG6VTEgiF/QLz46RXQvaxdf+/aVWEvBJKvzRXjwtN3dbu7/EPUqe9Dkjnhpn+tStaTnmcLnqQ7Bh1ZheuUiIKlYyr38ETaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3Hikf/2hU0Ygn+AsGIQaX/hrHiS9fzqFkReKivp34E=;
 b=FcfrXWR9DYLAcIOUgedF/oIV0dhXmZ0eEyGoSgaNczpEr/xRLjNIuxW6Y7uixSbJIpxREOnGqc2q+yxZvgkL/s/kSeVp+2nqx596ggimkXqVZk42OP/R+pNHnqnNiiJIfR2tg+0EEQKuchI77WaJbgX3+vCj1wnBonku+nq/57DnYHRkX1xI658ss9XZNLzU7pOc2AQBOZTYchw6L/PyCEvIwz7xzTWO1A5ovfAHvVgq74HflmZ+BE+e+o7fWc0laijqJq4CZT7kp+BS8n62iF8eObmRhEUVf48Gbo2SzvhtNUbm+mEoFvoOTj5TFW0Y/i0UDVkadPuA+TqXHT6HUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3Hikf/2hU0Ygn+AsGIQaX/hrHiS9fzqFkReKivp34E=;
 b=lYR/mgbi5Z52HjHdwvLmC8XotacyV4+MZb4nX/+v8i4dihyWJN1FlNC8QxUCbpO7rM7XX5/Qu9jmJ5Yl7FtnwkHADFdcgG6Jq3keU5b+mSB5HbIJYBDgOqp6SvBOvAfBKtyEiBk9JpfiuQCnje0Vq2w+Ge5H+LIb32WCZJpK1jM=
Received: from BY3PR10CA0030.namprd10.prod.outlook.com (2603:10b6:a03:255::35)
 by DS7PR12MB9043.namprd12.prod.outlook.com (2603:10b6:8:db::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.12; Wed, 4 Dec 2024 15:08:36 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::7a) by BY3PR10CA0030.outlook.office365.com
 (2603:10b6:a03:255::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 15:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 15:08:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 09:08:33 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add psp 13_0_12 version support
Date: Wed, 4 Dec 2024 10:08:18 -0500
Message-ID: <20241204150821.3424757-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS7PR12MB9043:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db4582d-d72a-40dc-eb2f-08dd14758661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6IdQ6SG6fIH8Kpe63zM1gVif7CT3U2V2qoRUdqwcLp1F8YjTry7298R8PU0S?=
 =?us-ascii?Q?jgKtEDTwJRJTR0wnFq0CVPueMOTS2oJxnlHMAW4inrpuZQ6fKUqGclRAyF3a?=
 =?us-ascii?Q?ygg6yTHFOdvJD5xSO6owwhTapQ1fn7UmuZysfxmgDBZqoNjLs9LzfoE8Eg4U?=
 =?us-ascii?Q?8MB7kiz+dH62dCRtWGotJlsKEqMnQhZpyEqgmtVDoC9WorIhZR87LMfHb4sW?=
 =?us-ascii?Q?TZZxpwEI5GOrYeFWtwo/jb30RtrR14K+8525Quol+bcBkodzezPVJeR6cn+Y?=
 =?us-ascii?Q?IXc3pz8FiGIStcoSRnOzoBMK17BxPxEWMcU2s78Z/vWHhiiBSMTn1T2HgLOa?=
 =?us-ascii?Q?V+5t/ZpC1iwK3lJb76cb0uOEWLaAo3XBsVOF7bkvnBZXB7TRrt0z8F7LZflT?=
 =?us-ascii?Q?aW9gQmSUxzmUIX/Wnbd6UX5VZcYu/1UFEVF3V/9X14GbOLNCR0cbhOur3B58?=
 =?us-ascii?Q?AWauxK3N30WioDqZe/zuZsyCDJ60Iv9Ao25dHX1yzIhd3lAAEPyP6c3hl/KK?=
 =?us-ascii?Q?83W3Cb+MnBM12ABDLPQJCWsoCzBe2BzOgFxbdO46sdiHbcdp7UPvoYrI0fIB?=
 =?us-ascii?Q?eGOGUrV/PyIbQ1UnM2t7nHgfWH5igZn5jZ9TBaO0t3XTYCYKGMqARb3L7wmo?=
 =?us-ascii?Q?RUlVU7I+v/W3vWsyEHLW2LsdFwpZpdUdoGO/kVPfGfsNn12RW9TpOIM5v8bk?=
 =?us-ascii?Q?LvMpwxc88hspqLfx4NHeJVvPtVhY6OByI/V0Jrw3P7DYFG8teOnzR62QXPtp?=
 =?us-ascii?Q?V+H1199K9YduGv20ORoAr/c+pBg+uRfvkZHXicwnBPijgpTHA4vSOHOSYTs/?=
 =?us-ascii?Q?D0O6HVeP8/qk6jJJYmJziXLtNgrcUuD2Q1rmNBdvOMbgLv3WyEVfEYDjGDcr?=
 =?us-ascii?Q?74nU+jsBQON4F/dM9tsVEzxEKFSa2Lv+tiCmaDI/pzykgiKcaXmjyLqjV726?=
 =?us-ascii?Q?hP/cdhznl/CFqIbPIgmNnIxZnt8HhgX/lr+A1l8hbpWT1q73fmn4b9V1J5xJ?=
 =?us-ascii?Q?IQ6/Qc+jqjhQbba4puCs6fTMELl1zkFnrhW+XInnSvKKATlzDxm6I7QUEMU5?=
 =?us-ascii?Q?C+t0SWiM4GjcUz6gOYMNrggV57TMlAGfH+FaH+eET0m2wPIF9dxHK53m8PQr?=
 =?us-ascii?Q?NTzKiwZgR7kndjFYU92IsBVfHOYa6YD1gLCginkWfWHzuLeXXGMjvn36aIUZ?=
 =?us-ascii?Q?nldVd+dGfDjrmFP/HQUv4/qPDrwxtfS6SlBDaUQNwmXzdwolqFVTAJprFLsX?=
 =?us-ascii?Q?BhhXMcvvtUjc9FWaweDXMKoMD6nWV3ALiqkz2PwIsM7QIJey0mhrej6QoNYA?=
 =?us-ascii?Q?o+qdxAmKXwA4GZes+VifWl33t2t3joo4E4ounEkk+o3FS93BV91ADdk3nu4v?=
 =?us-ascii?Q?W4GkjtWYSCP/F5GZR8wVh66j058V7OuZAgCByjO4QgCffBZExtTlTBkQnP0s?=
 =?us-ascii?Q?4ezuZkTafSVeuO570pT+Tgx5kUYfU85T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 15:08:35.3052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db4582d-d72a-40dc-eb2f-08dd14758661
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9043
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

From: Le Ma <le.ma@amd.com>

Add support for new psp 13_0_12 version

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 3 +++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        | 3 +++
 drivers/gpu/drm/amd/amdgpu/soc15.c            | 1 +
 4 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 57b36cae64546..37a55f6434828 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2015,6 +2015,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 10):
 	case IP_VERSION(13, 0, 11):
+	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(14, 0, 0):
 	case IP_VERSION(14, 0, 1):
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 26de60dbc9f17..87b368cf0e4e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -208,6 +208,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 		psp->boot_time_tmr = false;
 		fallthrough;
 	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = false;
@@ -359,6 +360,7 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 	int i;
 
 	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14))
 		return false;
 
@@ -870,6 +872,7 @@ static bool psp_skip_tmr(struct psp_context *psp)
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 10):
+	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
 		return true;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index c4b775aaee9fe..3c665ccfca642 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -122,6 +122,7 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 10):
+	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
 		err = psp_init_sos_microcode(psp, ucode_prefix);
 		if (err)
@@ -177,6 +178,7 @@ static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 
 	retry_cnt =
 		((amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+		  amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
 		  amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14))) ?
 			PSP_VMBX_POLLING_LIMIT :
 			10;
@@ -203,6 +205,7 @@ static int psp_v13_0_wait_for_bootloader_steady_state(struct psp_context *psp)
 	int ret;
 
 	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14)) {
 		ret = psp_v13_0_wait_for_vmbx_ready(psp);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8fad6b02c8df9..68bdd91f0a630 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1454,6 +1454,7 @@ static void soc15_common_get_clockgating_state(void *handle, u64 *flags)
 
 	if ((amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 2)) &&
 	    (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 6)) &&
+	    (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 12)) &&
 	    (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 14))) {
 		/* AMD_CG_SUPPORT_DRM_MGCG */
 		data = RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_CGTT_CTRL0));
-- 
2.47.0

