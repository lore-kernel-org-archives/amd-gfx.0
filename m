Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BE1C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 327F210E394;
	Fri, 31 Jan 2025 16:26:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z8ec6wRO";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9045410E394
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:26:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoB7xiHhzI+QsjISZHVW5BjedkLxeeHXU1qhZiF6y3aktJO6outyfRl6Tg+bayzMPxCPSp4AwfahSmhrfoldkGsG7XU4aoFjQl0quYPf8KUDfk+Y/rXhqKP6EnfhqP2X8uMGoDB1/qoL8Y0cROyIUorD25D839kHEK+ZKxWVKHuUFjG5BjvIZo5nZgv4agScKPG0Flk6Y83SGP3QR1pFdmSJQv8ilICNJYXhjGH8RXteqiLOY7Ig1FZJaIYFsMDH5TO2Z/h1i9FtDDMBdRi4g8d4VKwUobBKjLWrm5NYsEoVzxWq7NGk8+c0KKBXUMzto04brI7cPgg2Y5cxqE7Vgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfOkXpnnNGaugLRIZP4/lbVADpmsmPwxs3YWqkFQFdg=;
 b=cTvw5BZuS/Sm0XLFzO4D7TF9pSrqjll0RB00HmdTyuMt6nT0fU7z/+zxenrf4VpFwFflkwMxP+ljEGFY7DwkuEMS3PV0+M3dh2v4yE7uD4JmCIveAGxYrhHs6N7GOPDYg58g35qF+nwTUOG79LWItyMZT+Z4tcjkacb820a03uCb7OeBtrXWtuDlKRP0Lv/u/AjQLms25m8oWsQQI2eLqY0rWv0kRET9ruLlWTXRcONgw9O/9Ezm2nqHW8Mvdx7vxEmIsOak6CJ1oYNU9Je7DMD/xvjavqQJ0cpTeNWEQjdomEvT0/7ubhENOTcZOHkmRGAz0TtwLrC/cMApDsf9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfOkXpnnNGaugLRIZP4/lbVADpmsmPwxs3YWqkFQFdg=;
 b=Z8ec6wROadpQlqojWMbe5uHnp8m3OQlQFFi4O29kjv1uyDPtrZ6I7N4w08r+p2Qgopk9MI5oo39HA2M15R3j4/fCZ97kcK4afZc3dslWibzjszHooFREauLisoPQDeB9wnicZGQd+Dl84zKyU+xfftjl3jr5NLEbjEuUTuKYADQ=
Received: from PH7P221CA0070.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::22)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Fri, 31 Jan
 2025 16:26:27 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::a5) by PH7P221CA0070.outlook.office365.com
 (2603:10b6:510:328::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:26:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:26:27 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 Jan 2025 10:26:24 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, 
 Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: Add ring reset callback for JPEG2_0_0
Date: Fri, 31 Jan 2025 21:53:21 +0530
Message-ID: <20250131162321.563314-8-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
References: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 230d4578-1af2-4d9d-83d5-08dd421402e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmdUbW5INWVqdHRtWjR1QmRHV0Qyek5NM0dXZnIwQmU1YTh2Mk9GQnV6VTh1?=
 =?utf-8?B?QkRLQk53U3lLZTdYNW9nVHJaZHQzMC9sdE1UNzlJRzlyUFYwUDc0TkhEQjQv?=
 =?utf-8?B?d0ZJNHFZRzBuazJRTytmVTlKOWZCVzFGOEFrcGYxZW1Cci9qemVUVlFrNW40?=
 =?utf-8?B?QlRMZnZLRmlyTlRXSTM3aTFXTW84MWxUTWtjMjFRUnJQNWRuNXowRlpmUWlM?=
 =?utf-8?B?U000QmMyelA1aFpZRHVFT1RueDVuaTJSYXR3Y1FmaDJ6THA1K1R6SXIxSXg0?=
 =?utf-8?B?QXg2cCs2LzU4b1FJTjU4ZDh4U3RBRjUvMVdwRHNrTTZncW9xaGNwQVBDTmw1?=
 =?utf-8?B?amU4Zm0wKzhWN1lzc3lBdEFuTU5VWWtoSVJFK2w2b3RuUmFRUkMram9iMU9J?=
 =?utf-8?B?dmQ0TTFjWmpWUENsTGVGUWJjUVZEOEJRN25FK29LQXdMZ1F3ZGRPT0E0U3VK?=
 =?utf-8?B?eGpsczYya2pEUlpDV1VTbThoeU9ITTBzQW9SKzVKREFYTWUyUVJMMlFabzdM?=
 =?utf-8?B?dUFweEptVkpIcUYvcmlRdm10VGRLdWl6K0xXN3JYQlg3RU1yR2ZFTW9DNFNR?=
 =?utf-8?B?cmROcXQ0dDhKeGEwczl4TjlpSTh5N2VudFJxSVh0WkM1MUNSRzFud3d2dStN?=
 =?utf-8?B?blZwVG5xbVdtNExQT3kybFUzVXpHUGFmblV4OXc4OU1tRHJyeno3Qk5MWTZN?=
 =?utf-8?B?Nkt1Sm1mTWlyZi85TjZvWHVDc3Q1aW91QWdDZnA4c3BCd2hOcEpZaDM0bWtk?=
 =?utf-8?B?a2FhV2RRSW5DL0twLzFBb28xME5ObjRtTEc2MzVRdnRWWnMyWklNaVhvMXh5?=
 =?utf-8?B?VWE1c05HRDViVmYrV2Z5VDA3ZUJad2x6VVBBcTBpM0ZQZzRRUnZ0U3gveFh2?=
 =?utf-8?B?cEZjd0Q1dUZOa0RvM2FZKzV5N1ExUXFNeHhpSVVuNmttR2dJd2F2eWxCWDMw?=
 =?utf-8?B?RGkrR0V3ZWhweVlxbE9KdUlvaHR3NTRQSi8raU12dlp5eWlkdkZoRXJMbFNI?=
 =?utf-8?B?MUl4Q2tZSGxnVkNCYUZmUm5vQm8xcEc3b2R0TzFKdGtwRU0yQkYxMkpHV0Jk?=
 =?utf-8?B?TDRmd1k2dERkMExRZUVWc1h4N2U2Q2x3WFpOcTdYQWVwcFF0aDBGRnRGRjBT?=
 =?utf-8?B?QUxOUjRsUWFNVFVGZDlRSmNjdlRUQ3l5VDlzNUxQTFlKYndyaUNOMHVJNTND?=
 =?utf-8?B?ZjJnWVRPUWZQYmphbXk0enhOWHFYN1V0MlAzQTJsUkFMM3VIczhhV045Q3Rj?=
 =?utf-8?B?Wlp5UG4xb2tObU5Yb3FnTkJ4bC92QklxTCsxckk2YU42LzJpRU5JYzZoa1Qz?=
 =?utf-8?B?djFIODJ6S0plNnMyR3NHVUlieUhINTZIWEhIWTROaGh2eVVSUDA5cng0RU4z?=
 =?utf-8?B?WkZkNVJpR2hKUjJ6OXVMa0k5TjZydGx0TGRkR090RWFaRzJYOWJOdDJTaytQ?=
 =?utf-8?B?RjRydFRJMmV5UkVPcEg4MXl5Ym1NT0QxeCs0WkNvMkwyME9UdUpyd3lkbWR2?=
 =?utf-8?B?VDRJWm5tRENtMU82Syt1cEJ4alpaVWtqUGtIQThpSGN0UFpxdHBNME9NYnc2?=
 =?utf-8?B?K3d5UW5Ec2U4RUdvVHpOUmVsWFdFVmVQSnRVVFdXRFBaYnBiWFFzSmVVOThZ?=
 =?utf-8?B?c09lSXdKZzlDM1hiNjM0V3FkaEtMSmlNM01FWnAwN0ZicmNmcXVkODlLUWEw?=
 =?utf-8?B?ZXp3cWFkT3VpeUlxRTVhWEtJOFpZL1AvbjhBeFVySnpTWGgvRS9PRjBWeTRu?=
 =?utf-8?B?b3NmMGJJYTJXbmtoWmlBRWhWS2oyMHhYbzBITGYrRkpUUGdwK0hkQW5BL3NV?=
 =?utf-8?B?SWV6TTljRjRYb3BnbHRqbm9XTUZ5UWtiM1lzcExlOFdBb1NqMTc3YUF0cndi?=
 =?utf-8?B?Mlh6YzNIVUY0OTZlWFNSQTlLdm9FNk1xNVV3SFFWc2xEZUR2TnZBSmRVaWd2?=
 =?utf-8?B?YjloSEpEdjUzVWNoT3NtY3lIRWNrU0g2cTlzOFlVcWxoU2FOaUhMaGNZYjdp?=
 =?utf-8?Q?10k7ONqL2uUqycGAgcFSFFq33bAFbM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:26:27.0265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 230d4578-1af2-4d9d-83d5-08dd421402e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889
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

Add ring reset function callback for JPEG2_0_0 to
recover from job timeouts without a full gpu reset.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 8c61081746c6..f6dcd7b8c5e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -118,6 +118,11 @@ static int jpeg_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE | AMDGPU_RESET_TYPE_PER_PIPE;
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -137,6 +142,8 @@ static int jpeg_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
@@ -759,6 +766,20 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int ret;
+
+	jpeg_v2_0_stop(ring->adev);
+	jpeg_v2_0_start(ring->adev);
+	ret = amdgpu_ring_test_helper(ring);
+	if (ret)
+		return ret;
+	dev_info(adev->dev, "Reset on %s succeeded\n", ring->sched.name);
+	return 0;
+}
+
 static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 	.name = "jpeg_v2_0",
 	.early_init = jpeg_v2_0_early_init,
@@ -804,6 +825,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v2_0_ring_reset,
 };
 
 static void jpeg_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

