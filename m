Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1698AC3DA63
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 17:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D72210E619;
	Tue, 23 Jul 2024 17:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3JyY8ktN";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE51C10E1D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 17:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TopcqqdUA90Kg6+l/NAReaUD8zy352inQXCJzDcUaWwklxO0iLxQKUiDyHe0AxCQjDHTLLWJCDef4etsdHdE65/DV0V7tgVMBXiFCknw71oz5RQlTraVxWqQcfjIGy/XScahaFswCuMaxfDDQiznYt27cEiSVDtIQKlqLN3KJNQnuwVZhlsDQKyxFDoaAtJ8M4Ugr10lhARO1w0O9413nCdfba5rTvjJqZapKm5Sc72H8+iUXhZUu5DKQOcXjuwsjcaemtYloFtr94WvVhv7ZCdWB47YWzMo7wdKYUkW+jBrHqK+JfyijuvKTKUIEJwZpO9/vzmsnnA37Pm+LKne1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KiQ9tp851ZSuXrWVlqYi7F1rSWTLyQuoZ4uzhdDQm8=;
 b=Ub7KJrF7PX/DYB87fvTNWsk3roRz1a+PCOWhvRsXvXUmp6qzIXPrFmn8NbQA4Ry6FbOWBjO/PgUT+zAMcjzCBjlhZUOAG4Htg6/5zXE8n/qF9fT/eQiPPQpqIsaKeJl3+v1oq7BJ0RBOCtUgjlpG23VG4u4no4zQj4o+uBvTm3ka2NDm5kRSPnrAlUW9EoI8RLQKPlVNUh3hdM9DUrrAvBJh93ninfN291ctX5NP7noGwmOXRv5B5pGZX0VoW9o9+PT7trHl5Uam+pm5DAe2B7Ustmcxi46sKHfEYBxwINqDvZqIcCkG5GNyi9BA+ATTKr0+t6XFSE0HbtVsv1XkzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KiQ9tp851ZSuXrWVlqYi7F1rSWTLyQuoZ4uzhdDQm8=;
 b=3JyY8ktN0ykllBJz84DAV1B08UWbXxdNRNaaWE/KL8rS4UJI3vrUItE+j2PSH4eUqD0cNPhDKWQ5EyxcALR31rqAmpiw6+yilJUqhEvcrtphp/2SRtKD6nLjMlvChNx68TgTWKCP16wcIMTp7HdFebo6Vh1gydxyxuXgjJgNVpc=
Received: from PH7PR10CA0019.namprd10.prod.outlook.com (2603:10b6:510:23d::27)
 by SJ2PR12MB8942.namprd12.prod.outlook.com (2603:10b6:a03:53b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Tue, 23 Jul
 2024 17:34:11 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::2d) by PH7PR10CA0019.outlook.office365.com
 (2603:10b6:510:23d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Tue, 23 Jul 2024 17:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 17:34:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 23 Jul
 2024 12:34:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 1/2] drm/amdgpu: properly handle vbios fake edid sizing
Date: Tue, 23 Jul 2024 13:33:56 -0400
Message-ID: <20240723173357.2314927-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|SJ2PR12MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f74324c-83a2-4f6a-43d6-08dcab3da9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0VLMm9jcVdRM0pDNEpvWHhycWRPMmJNM2lHaE9DdEQ3VllyVnMvb1M1ZHVu?=
 =?utf-8?B?RHZONkNFTHdRRjBRSEJzRS9mbVhIdnJCL0xDckJROGVWS1dIRU5ERkEyRG9x?=
 =?utf-8?B?aFRFdExiSXI2Mi9KZkZVQnhlWUMzNmxQeCs3bmZuV1p0R080TzN4NUhwZ1BV?=
 =?utf-8?B?NC9CSThkTXJ4dnVqZlNYalFLd1ROZFAzR3ZNc2NMSzJCbEYrUFdUMWhRWGpy?=
 =?utf-8?B?NWo0Ry9ndnpZWVdFSFJFL2FFRG5FK0RvQThUL2tJcFB6VWZwSiswOHZmUmtY?=
 =?utf-8?B?cVp3T0lkdmY0ZmJNcTdRYnRuNFZzek82WkVaaGpyUW84dWFtYjNjbTNzdG5H?=
 =?utf-8?B?b3Fydmlxa3V1bU4zVWtTOUZqbWhoaFhhcllLV1JCU2xUdGg2ZU9Za005OGEx?=
 =?utf-8?B?OGl0NzEySGl6THpSbi9FVTRSMExzMFZTcWwzbkFSN1dIcHZjNVR1akdNeTNG?=
 =?utf-8?B?czRHOC9DZ3c4ZEgyRVhWWDcvTVdpc1RPRzFwWXMzUVVEdWxibzQ1WnFkOTZv?=
 =?utf-8?B?UlZVOTV5MFNSUGpVSG1TUFE1RXNRK1JkVitNSzl4SENvTmFwemJ2dVZLcnM0?=
 =?utf-8?B?RDJYVG9mam15c00yU09jRjRDODhHVkE2b1ZncGVQTlpTVTdBQURpNDF6N3pu?=
 =?utf-8?B?K0JQb1ZWejhFUGxlM0dRL25NUG5oZk9HMThUamZjUlZ1dVphbndLMU5HSVhZ?=
 =?utf-8?B?UGllOEZjcGhucnVKcWFKd0MzU0NWMldzN3pUaEZtRHB0QjVOSmFVS0RRcnlR?=
 =?utf-8?B?NEorS04yTS81SnN6SXp6aFB2aGhwK2Zjb2p6WE1wT0hLaktZUitySXFZeFlv?=
 =?utf-8?B?VU1kc0swaUxRekd4bUpRWk5VL2krNkVGZWR3NGFJZzNzN2pIWDA0UFN1ZkJJ?=
 =?utf-8?B?bHo2ekRiN3p6TkppaEVYMmhlZWM0ZW1OeWxvNWJmbmR1Y0RzS1ZGaVlQSzJK?=
 =?utf-8?B?eXB3OUZ5dXYrUHUzRndUVjNnNVk0OW9OMzBjSDVtV1VNM0pNWDY5Q2FyRXE3?=
 =?utf-8?B?dDVSZk01L1p1WTVtSGNyODhXMjdUVXpSeWVPTU5WZHJ5SC9xODN4cERodFdO?=
 =?utf-8?B?YW5MSDdnNUtkZFNFeFQveGZyMVdQenRTZGtPSjdQNEFkYjNISXY4V0xid2Er?=
 =?utf-8?B?TWxKTHNMT1J2TGVjSzd2bGxzK0EvWi9zMDRHcGZ3V2d0aTN2N3RXUGh1SzhI?=
 =?utf-8?B?OWY3a3paVW1tSm5ndG9lQm91RmNOWnhhQlZKTWpiMHhnSVJIREtuTHVzTE14?=
 =?utf-8?B?UDdiMjNlNGVFcnJMSGVHZ1dWNXpYNEtXU0p1WjJRQmpGYUpNeUZPeE13Umhx?=
 =?utf-8?B?WFpxUllUQndKT3oxajhSNHZIZFM2NWpzRGkvS291R0NHcDk0SG8wSlhVVUww?=
 =?utf-8?B?ckM4amV1cXBScWdUdjJKOEVVTVVIQVVLUDF3QWNMMnR5YU1Zek5hTzhOUGdR?=
 =?utf-8?B?MUVTR0IxRFFyUXNCMk9FRncrNzhOekJVbzk0a3lqYUFuNmZCUmM4SnFoUDRV?=
 =?utf-8?B?RDJlMmF5S3k5ZlpWVWEyamNqNlpUeXlMRi8vU0RacFJiblFZVklYcENxWHRR?=
 =?utf-8?B?MjUvNDAxNDdUdUxUQkRFWXB4M3Z3cDFuK0ZuczNxaDhiUWlGamtnbnVSRTdK?=
 =?utf-8?B?M1BLeE45emRlbzV6RVNJZmE2bUN2NnIxMGFOc29HclZWRHN2VlcrZWdUQ1Zy?=
 =?utf-8?B?SnJlTkVXeEpydjIwdGczTk5qcGVlUkk1bDN0K0dzc3NnM1NmQjVXcGFVenVW?=
 =?utf-8?B?bWxGZHRlOTRxZzBpZ2NjeXowRk9TeFdXRXRwRG9Oa1EzekxpdDlJTkYrTEpm?=
 =?utf-8?B?MnhTR2lHUm03aVl1R1U0aWtoU3J1TDNTOVBlQ1FlZlFFK3hGb3hsa2p0eVdL?=
 =?utf-8?B?VmRxRisxUkNJQ0RhZTBXUGYwajJLbUg4elBuRWVxL044cGx3T2xVdzQ5c0p1?=
 =?utf-8?Q?FdKaeyX9t17pNiDeSX/7saRwWAcEkVF/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 17:34:11.0524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f74324c-83a2-4f6a-43d6-08dcab3da9ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8942
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

The comment in the vbios structure says:
// = 128 means EDID length is 128 bytes, otherwise the EDID length = ucFakeEDIDLength*128

This fake edid struct has not been used in a long time, so I'm
not sure if there were actually any boards out there with a non-128 byte
EDID, but align the code with the comment.

Reported-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/atombios_encoders.c    | 24 +++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index 25feab188dfe..a8751a5901c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -2065,12 +2065,16 @@ amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
 					fake_edid_record = (ATOM_FAKE_EDID_PATCH_RECORD *)record;
 					if (fake_edid_record->ucFakeEDIDLength) {
 						struct edid *edid;
-						int edid_size =
-							max((int)EDID_LENGTH, (int)fake_edid_record->ucFakeEDIDLength);
-						edid = kmalloc(edid_size, GFP_KERNEL);
+						int edid_size;
+
+						if (fake_edid_record->ucFakeEDIDLength == 128)
+							edid_size = fake_edid_record->ucFakeEDIDLength;
+						else
+							edid_size = fake_edid_record->ucFakeEDIDLength * 128;
+						edid = kmalloc(max(EDID_LENGTH, edid_size), GFP_KERNEL);
 						if (edid) {
 							memcpy((u8 *)edid, (u8 *)&fake_edid_record->ucFakeEDIDString[0],
-							       fake_edid_record->ucFakeEDIDLength);
+							       edid_size);
 
 							if (drm_edid_is_valid(edid)) {
 								adev->mode_info.bios_hardcoded_edid = edid;
@@ -2078,13 +2082,13 @@ amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
 							} else
 								kfree(edid);
 						}
+						record += struct_size(fake_edid_record,
+								      ucFakeEDIDString,
+								      edid_size);
+					} else {
+						/* empty fake edid record must be 3 bytes long */
+						record += sizeof(ATOM_FAKE_EDID_PATCH_RECORD) + 1;
 					}
-					record += fake_edid_record->ucFakeEDIDLength ?
-						  struct_size(fake_edid_record,
-							      ucFakeEDIDString,
-							      fake_edid_record->ucFakeEDIDLength) :
-						  /* empty fake edid record must be 3 bytes long */
-						  sizeof(ATOM_FAKE_EDID_PATCH_RECORD) + 1;
 					break;
 				case LCD_PANEL_RESOLUTION_RECORD_TYPE:
 					panel_res_record = (ATOM_PANEL_RESOLUTION_PATCH_RECORD *)record;
-- 
2.45.2

