Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFADC8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8327D10E530;
	Mon,  7 Jul 2025 19:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HcNV1zaN";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C97210E530
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIyLUEZDhT2Rp6kB9tVXGRyLP8SMKoaWoPDeaajnlwE05SgMD+uoB5bym40So6oFnLNweurVSIHxfAW25a+HWrLBkJCCS1yXRe63+kwurPEoFB9L+TIyzaYm/qUbEtu3u47joTy0h8TLHKZd9VhqVj2MhpLhNsql6pwAcftauPpiDQD3oivkFJti28IZNhm2cent2dAqjy+7n5dn16ofBIixQsXuTdpJI1fkxmq8a9IjL40I3I9H5iE7nsMSsEs5bToSf/tyvHXlPHfUynAqSHH2vVw+YsqiBH8J7N54KtFeZJXNYWZyGxnWtkoXOPTjZYbS8mKUBw2UWnMA1+0brw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fSbAV4dVAtUgh4j4bwWvwPfJak9ITkhWIYj9m9NWcw=;
 b=lLC0K5ssy7dYLgFCE69WUjpdyPNA6Lais9PRProvVD4lPpNxOrZzqtj55Yw0kSWa5ihTrsaPIlu+Mzy6y+cTxC8QDawj0HeHAMYc1w8QVVnOOjClMm0R9kZaSledE/B9YSIAMqlYepe2HC+c05KYbxzo/7kv9s4LRGjAn93Xbfj9xJiYgzePHcHxsEdyr0B17DtiBnjo2M2q7CAqM9v4HgqyOIYFY9i2NmU2+EgnQFHu1gSU6ByvVS4+m/SAVCNSK2GMzLF+ICU+pBWpQLm171hWJ7iIQQAgXVhImdaLrqtpxQ9x7JIo1tPdumjhXBwsHQaOjq9N3talWd6e/pzmVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fSbAV4dVAtUgh4j4bwWvwPfJak9ITkhWIYj9m9NWcw=;
 b=HcNV1zaNsvUZBANemJrszQjCOCgADsU/0JTbsoAgzpqRutLHuyB/CL3lhB11vHWUGUviHM6oBiknAoMxjaSwpxWKkINT+cwfRkZW+Niw6DXj/ZpFhUpvQW1MjJpYsfb/I+Oxq4RK1vwX8Y2Sud2F+vmyFl8CbjqoTUquTDI1Eio=
Received: from PH7P221CA0075.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::26)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 19:04:26 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::96) by PH7P221CA0075.outlook.office365.com
 (2603:10b6:510:328::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 24/36] drm/amdgpu/jpeg4: re-emit unprocessed state on ring
 reset
Date: Mon, 7 Jul 2025 15:03:43 -0400
Message-ID: <20250707190355.837891-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: a824a29c-1bf6-46f3-b193-08ddbd8917c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xQt5FyfrFgQdq2Zt1o+XuCSR95cawYpczpd4ZvBdZUVQWSM1VeZeMZlB5SMs?=
 =?us-ascii?Q?nD3K//stS3jRjJmoqfDSEu7v4e11waiusAcfvsd9BQ8wNX98zo+CXJU26GZ9?=
 =?us-ascii?Q?pAv2Qp5bg2iKhA7gR3WiVGPPrlCkwnxXpVdlJxKGlqefn0TUIROzcPNeYU2N?=
 =?us-ascii?Q?N/mFURVqp+dWqp36qR26pcf9VWEmmmKFBU/eWaPlVj0/C6jrJu8b1UHit59J?=
 =?us-ascii?Q?hBd9kS1JSPhTnFwiNJjLUeFAwsv4M40jOrKIC3rpMfyf7BLixy3fx+CcCp7g?=
 =?us-ascii?Q?VHZobaZKfFa6I2SPaowwZkN+uo8bb+scgnmZo8HPWwzxS9ctyRiLMNnIapm9?=
 =?us-ascii?Q?LWE7M6rH1rKxuSXHrsKBMxYd6TjFY4l9A8dBziOOEF0UgClBc1EAvOzX2HaE?=
 =?us-ascii?Q?+1vm7wG/ZessTTg4K1XQLb83dbeEJ7TKaJ1yNsHpBmP/VI69XdaDJbij8eq4?=
 =?us-ascii?Q?T+U9Hwrm+W4algPvs7CgweoX5i+EogFWA+hyhd9JbunT5eDOlV3Ihveg8jK5?=
 =?us-ascii?Q?4mjlZoAQ1KCzD9Yn3Za+O224qrg7Ke4X1eSZ4ZCuHsXV3p85DnazebPDWyNG?=
 =?us-ascii?Q?Val2y7UeQqhC4pljbufqFFdORp2bVIwsOHWfYlGY10m9fIlQv5MoTllYr5lw?=
 =?us-ascii?Q?/J0fAN5kq7itnsYwpaBce+QRwhPdCKjnrD4eNGz2v+enXFHKloY5oBeUEeaN?=
 =?us-ascii?Q?hrzHdts+RwV86U8/3Bs6ZW+2B73Cm37tU9+zxga034NI7V2sBB6oGb2tL/9Z?=
 =?us-ascii?Q?oVHjL3UbSIo8rQT0uInHGsuVoK4MWvLOpOekqvZ9qA1n6Q7rStmo/H2aG8mz?=
 =?us-ascii?Q?aqGOH6GlKUIl5l0qgcbeE240n2/WrUthhu4F3jM2XF+iq8PrB1QkFnRwX3+J?=
 =?us-ascii?Q?Um3g+/bYqhXmeV8mN0l9qatnuWaZVEXzaUSofVYwg8XwCf1fSAV8IMs3mqFe?=
 =?us-ascii?Q?guST1/oPTQCVM6oJnPYwEF8pfmFjx1bI/3Fu+QY5a87vJL8dHlsbB2suqDA9?=
 =?us-ascii?Q?vE14og0v/RmObkqtXn/HSBDUH0PypvHqUYFF4kTwBYctPCHrukUIMIT2cS1L?=
 =?us-ascii?Q?eqiM9k5Z3hG2PLVHxASZ/6k+jGn/Xnevwv7nq7OYLzlh5MBNaDG3tznfM2Oo?=
 =?us-ascii?Q?p3mhqsz1shZUObUMXubbf8J6PH5of3CTNPxn+GF13xSZ3+4wIR8B1ENqu3Qv?=
 =?us-ascii?Q?aRVtK3HzTPPV2FAJrpl1SzOMBwrIVQaTKO0UYQ1kz5ehBmyvbietjoQbHfxO?=
 =?us-ascii?Q?4f8MOcjBx8mymG6dMl1TpKAYFB6zpIduIGLsyfOb+GkbUJns/NiegQw0Rkov?=
 =?us-ascii?Q?z8iH9443/Ddv/nbWcWvixdDiQF0Y8SJmvWGGNhP/CA5Zhd2CaX+i3Md5Tq1a?=
 =?us-ascii?Q?YO0qubIRTubATidb6GVTOf5yIfHp7y7vkhxzufSJ0+ADuXpzCyT1uRvMwZiL?=
 =?us-ascii?Q?jrJArwoCl7ttr7zv89+ttKz5JVPnFbM55goYuXpcvk4n66ycsnnfkS6wmNxu?=
 =?us-ascii?Q?ccieK4GOl7SoJrosxNOgLvp8Nn0YYlK8B2ME?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:26.2599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a824a29c-1bf6-46f3-b193-08ddbd8917c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 78fe1924f3cb7..9c0610533bb0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -729,19 +729,14 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v4_0_stop(ring->adev);
 	if (r)
 		return r;
 	r = jpeg_v4_0_start(ring->adev);
 	if (r)
 		return r;
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
-- 
2.50.0

