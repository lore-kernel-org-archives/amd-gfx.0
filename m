Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB052C02190
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D2410E05D;
	Fri, 31 Jan 2025 16:24:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g61pxM3E";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C503410E05D
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:24:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWUbgR7IhXSGQh/czAvGkKcrK4dOwkjtESdYcmXmL5tQxwrEQxd5Q/a7XGyM/FpKmRgTwqj1GCROyO2h/3oqWO8XQz5L2rkwh3bmyCacC4Qad165PQ6pR4u7ujeQhuB4d/P29njIz+/WXEZIuZDB48MeQeuX5IFT6FElZ0p6Z6fqSxlDUixrcnzsWZ/B8s/dmzOJgRkiOb4TwB0YYV229tg48O2Fx7aR1glDY4h+f9UQwBIhSb0Y4jrfmR81NwPgGJ48Uj404/FcA9z1bcCLUIwa1gvifYN4NTpgXmtbf0ccmUK/4c6yI+eC3SpDQAYH7LoE/HZrzHtrfakdZyTtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOO1ycINkHE/GKNtHshhsaMsnmTym/UsLZ4jLOQLmJY=;
 b=Yb2wxFNkk27PGdC6k7GvUO50CF8geHMUITx7fP4ul6/P/Xkt72BSx/7Ix3OxMpfkuAiVJOFO0E4x44L6aNfm88gI0y8LCsRObKyOyQb6SzlpMoAmXKi13mz9gmopWhbqfc6Y4megkutSV7IUQ2JCm2qTGloUf9Tt+/IzEjJhcbj3bkuTvLn+yEW8jWI3p3dLrE6e8HJGbpCG4+vJFyE902pZM6sdFplVD2nHTrIP/dnjxQwF4+Fm9qVH773xUvWr/v8+W0H4XHxtOWiQkU5QL9sEUk98iaLsS/fq1M14BpIoZChuwmveuvkXDco5mJxsWdvTiWkzW3BCVvYbSxXsvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOO1ycINkHE/GKNtHshhsaMsnmTym/UsLZ4jLOQLmJY=;
 b=g61pxM3EjU8VVV+oJPoY4yu6+WEtsyImYvj+BA3TS4fkfYdusWtngidwt7QeLqjpuTmFy2meRkkNdFYWmCwTHi9PKtvu/kbF+DLwX0NljTavJSL0K6kC6Nhjfqqsflh3oQrgQ7e7G7ns9M4PGPuahWR9Vd4QT54X58yYODg4n9E=
Received: from DM6PR06CA0099.namprd06.prod.outlook.com (2603:10b6:5:336::32)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 16:24:11 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::e6) by DM6PR06CA0099.outlook.office365.com
 (2603:10b6:5:336::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Fri,
 31 Jan 2025 16:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:24:10 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 Jan 2025 10:24:08 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, 
 Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: Add ring reset callback for JPEG4_0_3
Date: Fri, 31 Jan 2025 21:53:16 +0530
Message-ID: <20250131162321.563314-3-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 07491684-df2e-4f4f-f20d-08dd4213b1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW93SlhKNjFJUWlWc1gzTlJRcUptcVFwODhzOVpERFpSaFM3VS8rM1FnN3Bl?=
 =?utf-8?B?YU1DU3ZMQkxjcDE1dTJzd1VEV1VxOUZYdkpzRk9HUXhXd3RjRUpTa0FaQXdq?=
 =?utf-8?B?bTlEQStKMGM2N0F2NVVCczlYWmFWU0RpMDBlajA5Tm4yTlNWL2tMakJxZjZQ?=
 =?utf-8?B?VFlDTTBhdHlwS3E3czhOdGJSU2RVcFJsUXVjY0EzVFdVS0N2aC8yNk9jNkNJ?=
 =?utf-8?B?Y3lpSWYwTnJOZmdOQ1BLbGNBcUpnR3RBZDlMWXlraStQNWovb3BJOTNBWC9X?=
 =?utf-8?B?aFJxVm03TldyMkFTdE45Y1RRNExORVViOEhGNithd3dad2QwTkgyeEtSVDEy?=
 =?utf-8?B?QmtMZFBLb0drREh2d2FIR1hGN2hwZko0SGQvQVdYTk1xRldZQmlGMU95SlNK?=
 =?utf-8?B?VHE0aGdSZmQzdGYrMFNRRVY2bi9DdFNZcDJxaEp2TmVTSzQ5YTNFNGxCUU1r?=
 =?utf-8?B?UzRBL2QrcTBiUkI2NWVxRy8xTURnalZxTEo3SkVTSStGRXdwaUJWTEoxTlR2?=
 =?utf-8?B?RmpvUEhIb1RIMnVBa3pzeThiM3RvOGQycEtJRWttc2x4R1prbGdvM3pyL1Vt?=
 =?utf-8?B?eEZvOG4rZU9pdzdTRmtLZ3pRTUVWSElHVVNRbHc0K1BIcEw0dWcrNitHakNW?=
 =?utf-8?B?eDdpVTNOa2tvZEtMcFpXMVJ2NTRJTS93eHNVVkFRTldPeTdFMWFMZnd1SFNY?=
 =?utf-8?B?WFV3blIzZjViOWJFeUIzcXNyUTNPb2k1R3pJd3V4ajVvZ3BPZEI5MGN2M2ZV?=
 =?utf-8?B?eWxCSkNzSm96SlFNbVJHS3lIQkJkRS9jWGkrUGZia3Q2Q0RPYlkwQUhIUjFG?=
 =?utf-8?B?RHZEM2toVmFMZndEZjFkbzNnU1JGeU1sTXJETWhYN1hWSC8xa2RaWmtuNzJS?=
 =?utf-8?B?TUFsQUJ6dEpQeFpEY2pzdFBoRVVYcG9NYlQ5bWlkSHVhTjREVFRGcWhKT0Yz?=
 =?utf-8?B?eHo2VmZJbnVDTjF5dktiNVo5WlF2Y2ozYzBvenAyY3kxdXVHc2NFUmZqZHpT?=
 =?utf-8?B?RUM3RHcrMytCcDVaSE5JS2JMdVFZd2lZRUJzZXp6cG5WWVZrS0hlT2dNRjB6?=
 =?utf-8?B?eGNjcjNSbW5HTmdRQ09ZdENLQUJnOG1EL2REdDZuWm9ETm9MSzRDcW1zSC9p?=
 =?utf-8?B?cUZacWRTUHZBK3RMb0xvNWNGdVhBZTMvZy84TkdCL1lvaFlyd1UwaFRLQzhG?=
 =?utf-8?B?eklMVjJWVXpjdDJDNGR4MGZXaHdrZmtwd1dhZFBza2lTbElKMXMvbTBqeCtK?=
 =?utf-8?B?NHprYjlMOEhXS3U3V2s2MHA2dWJHdmd4aEZaWmE0d1pjY3p5dmxueEM2cS9E?=
 =?utf-8?B?T0lZS2FQS2ZPSU5RZUlzd2xlclZtUDVxQW9mbGNpMU1YSWwvbHVvOGhBZUhN?=
 =?utf-8?B?QmoxSCtNMDZheEN6K2lIbmJtL24zVXg2MG1DMDdiSjRnc2Y2bGdDMEZLRUg2?=
 =?utf-8?B?OC9zazRQUUJoUDR0UlNGMmtpbGhna25ZK3ViZWlWenUzbmxrZFhhUEJuT0F2?=
 =?utf-8?B?WXR5eWoxRE1SVWlYTUt5S2YwVmtXNEU0UmRDaElGNzM5ZjVvMCtlL0NtQzNM?=
 =?utf-8?B?d1JnUE4vWnd5bDkxelFhU2p2ZzVBanNYNmY0VE4yVnFSM2xqQ2pOUEJreWdR?=
 =?utf-8?B?OThkQTR5NlluYml6Mm1yTGxhWXVrd1BrNEVWK3lvVGJzZmJocnVCRmtWeVFP?=
 =?utf-8?B?M2Q4UTZzOUFuTE5uMmt6bUUyOUk3dmFlSXZ3Zm9KaEVTeW11aUJOY2lYWC9B?=
 =?utf-8?B?Mzl5QlBydzRTWEEwQ3FDK3FTVkRtM2Y2TDBZWkMrWE5YYUoxTmJBNzE4WlZp?=
 =?utf-8?B?SXFBVkVHakZVWEFIeENnQVluWHZERHRWY2VMNmJtaU40SzdEMDZ6cVhHQ0tV?=
 =?utf-8?B?MFJxejY1NGFOWWI1dWZybFJqbXQvRklCYUVPZVNtNlc1c0Y5WUJ0Vkl3TldG?=
 =?utf-8?B?REhkVEc2RTVqdXh6NTFkRVIvZ0lPQTZINWxLSzFpajBtNytUU05oT2RRcStu?=
 =?utf-8?Q?2yZcReJq8P5OnPCV6zAjIA0R3Vnyy4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:24:10.7704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07491684-df2e-4f4f-f20d-08dd4213b1a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135
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

Add ring reset function callback for JPEG4_0_3 to
recover from job timeouts without a full gpu reset.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 60 ++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index be0b3b4c8690..62d8628dccc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -204,9 +204,7 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	/* TODO: Add queue reset mask when FW fully supports it */
-	adev->jpeg.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_PIPE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
@@ -231,6 +229,7 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
@@ -1099,6 +1098,60 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_3_wait_for_idle_on_inst(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring *r;
+	int ret, j;
+
+	for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+		r = &adev->jpeg.inst[ring->me].ring_dec[j];
+		r->sched.ready = false;
+	}
+	/* publish update */
+	smp_rmb();
+	for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+		r = &adev->jpeg.inst[ring->me].ring_dec[j];
+		if (r->pipe == j)
+			continue;
+		ret = SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, ring->me),
+						regUVD_JRBC0_UVD_JRBC_STATUS,
+						jpeg_v4_0_3_core_reg_offset(j),
+						UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
+						UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring *r;
+	int ret, j;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	jpeg_v4_0_3_wait_for_idle_on_inst(ring);
+	jpeg_v4_0_3_stop_inst(ring->adev, ring->me);
+	jpeg_v4_0_3_start_inst(ring->adev, ring->me);
+	for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+		r = &adev->jpeg.inst[ring->me].ring_dec[j];
+		jpeg_v4_0_3_start_jrbc(r);
+		ret = amdgpu_ring_test_helper(r);
+		if (ret)
+			return ret;
+		r->sched.ready = true;
+	}
+	/* publish update */
+	smp_rmb();
+	dev_info(adev->dev, "Reset on %s succeeded\n", ring->sched.name);
+	return 0;
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
 	.name = "jpeg_v4_0_3",
 	.early_init = jpeg_v4_0_3_early_init,
@@ -1145,6 +1198,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v4_0_3_ring_reset,
 };
 
 static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

