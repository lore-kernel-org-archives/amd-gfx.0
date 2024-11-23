Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F26E6ADFF
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Nov 2024 13:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6075E10E081;
	Sat, 23 Nov 2024 13:59:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ybo3hSlu";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6FCF10E095
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Nov 2024 13:59:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWEVbbi4NkQtO38/X89dNAkiF15gYk18W3WmhTp8l13r8QGN05ZYHkmRkX6qZDxmrdJigc5JQHMv2haaKyPtwZo4tgSF57E8egVLc1YD+SAstJl7xPeKMDBlXLUKJxHuOBCM+a94r6+OWBsaeT9KKJl8DInO2ZpOOlEIHpicV5eqFTSSBksWHUwXVICltKemK2yXRtkMScto1cwrr0QqOPGduJKaRnlq7gJJkjMdI07eUngvZgtN3B8fef1W2VCSdqSC+XL7LS5N+OiSyxQ5iQ6YGahQpx1hGETQIYNZwURCT7bVNyvNpTXFoyQd01lvn8VMyB3nefE5MkujLO8l8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKGkOPE2ZmoZbB4/L5PBUshZ0QmPYfxLmlR8kuQfiZ4=;
 b=tvM4exOZyyVHrFJWlwc6/Mm9LY/k+zpHzipxwIlmzposu3VnXpyZVHOMW5Wf4DtVp8Xm1SqYkcBU8mdmzINBLCa/eE1QXAFRLnXIdyiSwMiZ71zzgsn/w9Yquz6yz9Xl3QYNRbwjBXgg5d9STUnaXqZC/hDY4HGm3KAyYY0IlrVKJ1I8pWKs0fMK813ZzpN3SGxhCucfq3LKlKuTeih0rPbIAOYxOEE+zw35VFo0IQHtnSOjTDdpgm9OFKvgaxNPA5SS/QxL5ro+HssVWhVxEcD20Bjhl2HhFcU/Sh1kIWHT3MxvLSiJamh4fI2xehIE/z7JpaI9GQV58sKbpJR3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKGkOPE2ZmoZbB4/L5PBUshZ0QmPYfxLmlR8kuQfiZ4=;
 b=ybo3hSluxO92JqjFQWoGb7SkPzHIWCm112NecULOgdF3ZjtQRQj9V0wPhq1iuDe5TWGJZ7O5utUS0u6+nNJLegregk3ZlLRV2Y+jBzCmj4Cp1IIqyACy51UfK6fvUbBYV1/IEb6tyRjCA97bALxvapujtxepW143H14wirdZL9Q=
Received: from MN2PR14CA0006.namprd14.prod.outlook.com (2603:10b6:208:23e::11)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Sat, 23 Nov
 2024 13:59:28 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::95) by MN2PR14CA0006.outlook.office365.com
 (2603:10b6:208:23e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Sat, 23 Nov 2024 13:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Sat, 23 Nov 2024 13:59:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 23 Nov
 2024 07:59:27 -0600
Received: from victor-x86-02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 23 Nov 2024 07:59:26 -0600
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: use sjt mec fw on gfx943 for sriov
Date: Sat, 23 Nov 2024 21:59:20 +0800
Message-ID: <20241123135920.2593163-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Victor.Zhao@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: 147a49b4-8f77-46fc-148e-08dd0bc70bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KwgRYwPc4fnKa46/Aiua3VVht4o4AGrHXMSu0LSvvyblr48STI1iEr2kj1uY?=
 =?us-ascii?Q?Oyxf138hDM9wifvdT3Q9B8fCc9Gv2OCv+Lonw9JOlhQP30uyavESeeG7etwS?=
 =?us-ascii?Q?rd96rV1Le8WE2qwwUkOxgyQcqvweq75Ybhz8xVAL3QK0d5OcDpYdRuHjiqs1?=
 =?us-ascii?Q?nQS1mUZfVgSIp5FHb5O24kdNZ5IA8SMSyYC6fTR1rQZzTwzzTuHHuTO+tZF4?=
 =?us-ascii?Q?sDhKOKZnyk5uTOGlj1UcKWOEtGkF+0SOk/sV6vBI+8siyr4kly7zsoaAUx4s?=
 =?us-ascii?Q?3YKAHjSLW+FGe2lGuCeafPrqE75o5OxJhF68KMDsQzZJSIpEovbZhUIvy0rY?=
 =?us-ascii?Q?I/0JpvZSAANppBI8mt0MxKvbSmeYT8f29fQt+gUQCj5O42fXWqbQbnES/EaM?=
 =?us-ascii?Q?hYR8E7iNQin8tba1IkvHfBV7lG3x1oiyZhG4Ay0jM4Xqsel4VX8Rv7an0eiR?=
 =?us-ascii?Q?DjE8xmtpM7Br+zRip/M+5Pumz7DWCj+sMxEqK9NpcXJ25ztmCRul0vwCfYhn?=
 =?us-ascii?Q?DDZ6HVrUIofjbMK9wohWCSwTBOQRcGfskScCW2wPkPUd5PLi50nuDSucFfeR?=
 =?us-ascii?Q?nLkJnAvVtDCEts/6Jr8ghBitmegzxpcYFmVO17E79bv4YUnh3GjZvPZZOgEC?=
 =?us-ascii?Q?NaOCcXFTmvsMKAgSaRQwB3e44qTFD4+D4E/CJCJoQ7jp8d3ffnpQw8QsYJIH?=
 =?us-ascii?Q?lVOmWe6FuSBuAHBFn7Igc09FfbGvQT8TK/kwumiFW3Mnef6vp7Ed6mJBpNNA?=
 =?us-ascii?Q?ZRGBgQjyWY3wwP3rfq/8prYmEHTl79Qey/0bISeqGtuAyYtDwZ2e8CtZlktR?=
 =?us-ascii?Q?7hLKvFmGlO0k8635spyVYKDTTQmmcHk8bdDSubmGPRZOg7buks1rpj3HDWlI?=
 =?us-ascii?Q?Ae3FCSSBWmjvk08u7CZLrUnf4JePZ9v4Fc2bqUuMJ82Yje3/HfWLjxb0mUEQ?=
 =?us-ascii?Q?7vzBzE1rzV/aDbRxZCaaf4+zCQare3k28CZ5ooY57semrnp/t9FDaavK615X?=
 =?us-ascii?Q?rhnd9dcgZRH+68tvhjXdyttzQUXG1C9WElm1LCY02881HZd7VJGXchzQCCbA?=
 =?us-ascii?Q?5teY0b3Sj/RXbGHir9iMK7WI2Z2xP0aoJqsoWojryBInZoo15jiDd0PXgP7M?=
 =?us-ascii?Q?REQYAs2zz9ISb1HWoIvDNlzMvJ0NdpxzHqwjinY8NT36Jqm+yvlekaUWolZD?=
 =?us-ascii?Q?Mpi0iWqxyX+rGW3M7EvlJzTKGWsJ4mdQeUSuCq7Ap3BKQ3c/DoHuxTimlMy8?=
 =?us-ascii?Q?UGPrEwtmY9NnOw1OTm1BlS/3PKThn9S9uzf6U/lmT2U1FdmyCFULwzSQ6Wc7?=
 =?us-ascii?Q?CI48V5+lcl4sNQBo9NolEGy2yC08AMNxXV6Yuostx0/tCyLNRSk8dfsrBzWt?=
 =?us-ascii?Q?Y8l6lVloDsg+ypvJGO8oPh4HkpQtgR2V5o1Mn89QBWxHVxa1F4oFiCpmrGU0?=
 =?us-ascii?Q?4z439pVcY4aHAijbOTx9Wp5ktaI1IU18?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2024 13:59:27.8511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 147a49b4-8f77-46fc-148e-08dd0bc70bb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157
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

Use second jump table in sriov for live migration or mulitple VF
support so different VF can load different version of MEC as long
as they support sjt

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index f23df55d72fd..58541b93580a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -45,6 +45,8 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_3_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_4_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_9_4_3_sjt_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_9_4_4_sjt_mec.bin");
 
 #define GFX9_MEC_HPD_SIZE 4096
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
@@ -574,8 +576,12 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 {
 	int err;
 
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
-				   "amdgpu/%s_mec.bin", chip_name);
+	if (amdgpu_sriov_vf(adev))
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				"amdgpu/%s_sjt_mec.bin", chip_name);
+	else
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				"amdgpu/%s_mec.bin", chip_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
-- 
2.34.1

