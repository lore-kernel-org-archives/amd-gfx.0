Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C141C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 17:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D68210E1D0;
	Tue, 23 Jul 2024 17:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Magy97QX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B018910E1D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 17:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubfiHmVkot3k3QffkWiu49cv3hfD+RAg6qegpsdm1woP3RbV5RKpGMqir/eUKN6HUc0wavcuVOQTS59YnC46gd5k5IX0VmVOJ2UVoT+UV9UdTuFJ2qcYcZfu35XAhZyfu31NOAzb8amosg9iw017smZEcNAaovBioU0axm2iVxVycewzt6dfiG83+sd3OuE9JeyQAkSzHeuNd3HAeI64wiZh1OqIsLBZsmRYPcwVEXx8abPee+zmiACOleRRxRPVN+n2fgmQAd0lrGTgvEPeI8DrpZ9K4u+6Nyut2+wRzH9a0YF4B1Zp0oeqZTpuqXllpsfVLHp4BZlHzeMyZq5BhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7S3sNWLVcddLNCRjdI/X6sTeDUKkU2YX8mwN3iFMA4=;
 b=DeaXVxdcudJCRh7VhtjZsTF/YKjW77iZFObnL0dH76JhJhb02OBKgoSZYR1YIKKTWUUQ+9VqEIkYHPTr1A4zHNiEuja/w6blagXLnbO4dyW4XbYofkwhspnXfazIkI5sOZxr/msaZRKTKaVTunKROX7N0fdwosX2MGPIDNEcID+KQPdroaimIAs65N06J8SdgR3goA49vJIKN0oVogatXjxgKA3ohh+x9HNv2/w6abhTybe2ZFFNaZtvC5Wq9FgdEZPvijvn4ZXzdWorw1Yl9aUuEGebFMre85ChGELJQHpaSc/afFC8uaugab2pfZLYXp6fsA5d5RFbjxTWkleAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7S3sNWLVcddLNCRjdI/X6sTeDUKkU2YX8mwN3iFMA4=;
 b=Magy97QXRGFi08YjGJrLoqjgiTwyb03rgd9or72VfN/B7UHBENK/HlY+jasmYNjpwnAbK3gNpSM6rjYVYXG7ZrEVYqf7qHtC8Ec9Sk6gIFm3s5hBn7emHAIoLYqsrx7qLZcrdtNvm5pZJf+gC29o7vpCrkr2O+gDuwz9TNULLbM=
Received: from PH7PR10CA0004.namprd10.prod.outlook.com (2603:10b6:510:23d::22)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Tue, 23 Jul
 2024 17:34:12 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::bc) by PH7PR10CA0004.outlook.office365.com
 (2603:10b6:510:23d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Tue, 23 Jul 2024 17:34:12 +0000
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
 2024 12:34:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 2/2] drm/radeon: properly handle vbios fake edid sizing
Date: Tue, 23 Jul 2024 13:33:57 -0400
Message-ID: <20240723173357.2314927-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723173357.2314927-1-alexander.deucher@amd.com>
References: <20240723173357.2314927-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: f32ece53-55f1-4857-3e94-08dcab3daa6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SG5DUjlwWGRBMm1OWFUvNGQ4TTR4ZWR2S2doaHZDY1ZIOHZJMVBWK1dsbytu?=
 =?utf-8?B?TlRrZWZxVmJlR3hjbTZ5Z0ZJcjljbnBwblpRU3RKK1ZkcXFxTFdNNmNYYjI1?=
 =?utf-8?B?S2xlQlZsVlc2TmxoTTVWdC9MY2ZhUVBkbk9Xa3V4S0JUVUhpZi94c2RObGlZ?=
 =?utf-8?B?dzJLS1ozZkgvbWtJcGluZHNjUENBRmxlK3c0KzE3bEpzQ2xPeGlwNmcxdWtN?=
 =?utf-8?B?d2FkNlFQSm40Tk9NVEhuMXBnc1ZDaU1nbnZUSmU5SS9hcmlhN3d1NGJaVXBa?=
 =?utf-8?B?ZFZ2UjNFY0JmaVJJaEwwRlplQXdQdVgyR0pESjk0eGlKZEUvRHRGamRkajBX?=
 =?utf-8?B?YnIvUFFNOWpadk9ZRHNtb21CVnpwd1RHamphWHVlay95cWpDVzhBN29FZ1Bl?=
 =?utf-8?B?T1N3NWhNM2F3L0xWSmxaL2pEYm9SMit5WWNncG1zQnUwclpYKzBWR2o5SW1E?=
 =?utf-8?B?VHkyeS9kejBXdytzRlhiNXR3cVhhL3d0ZUpIMTQ5YWV0U1lVeDdzWU1tcVBU?=
 =?utf-8?B?M0xBbzFObXNwcUZ1cGVtaXR2QUpSVDJFMmpnTGIyc0tUeTdxdkZRU3JMcVQ3?=
 =?utf-8?B?dVhURjZkbm1zcTIrQ0RLWWlVRW52bGc1U2Y5cG9zdG5ZYXFpTnVzNGJ1ak5T?=
 =?utf-8?B?R3Y1ayt1R2NRUURyVVNldktUZFZQaUdqV3JpSklTME1NRTYzcFI4V2hkbjY5?=
 =?utf-8?B?NkdsUEEvTXorQ1NneW1mNUtaYkxQc0xxRStINlY2dkRvQkhBcTlxWHJCY0FZ?=
 =?utf-8?B?NkhDanVJbVNPelhyci9CcFdHN2lhQzRUY08xNDlqdXQ3R253bEdOR3hYR3NH?=
 =?utf-8?B?TjFPd0I3QzlFYkdlcHBsdkZkckdXNjQwanExY0N2NW1VaWgzcWRKUi9BUlZT?=
 =?utf-8?B?T21QR05vTitoMWc1SFV6OVI2VXo4eVZpcDJQRWI2SkxuWW5wUkdYUWxUbmVS?=
 =?utf-8?B?TExVd2sreGRxZkxRS2M1OHEwdnNEL2k3c0RBeUxaemlTdFNxemU4ME1Kbkpp?=
 =?utf-8?B?YmZIbCtGOWlwRjU4YWx4WDY3RmVTS0VDRlhVWE1Ed0d0Nk5pR0phb3BPTmd6?=
 =?utf-8?B?RW1LR3JQT01iMUY5enI0YVFlY2k1VEJSeUpuQW4xV29CMUhZU1psWjdsYU1M?=
 =?utf-8?B?eStqTjlHUFVsd3luMlFYTElLSTQzaFQ4U0NCQ3I5STlrZ08velFvTUF3UWYz?=
 =?utf-8?B?anhIWXpKWHJtV2dQeThBZ3hDR3RrVnQ4ZGFoNTY5eEVKOThCUklvR0lwYmI1?=
 =?utf-8?B?Z21tdFB5eG5SN3hVdEh0RUo4RUFZRWFmRE1Ka05lenhNVS9yMTZxcTgybnNu?=
 =?utf-8?B?MGYrMmVUQUJBYTI1WTRvUk53cVNJTUNNakxyVTQ2RXFoa0MvUk1UTW8waE50?=
 =?utf-8?B?SDJ3d2pqY3NLblNMV3JKaW1HaFBaWlFNOWV2VXBCbWNoc2dMWDN2QjlxbUlS?=
 =?utf-8?B?bmpnMVpwZnp5NEZVWkhqbDRsS21Md0RYNy9nVzRPS1NYcmN1QndESVNOemVa?=
 =?utf-8?B?Y0dISUhteU1WNml2NktuQnFvVXRudzFNYW5EYzBoM1Q2WEJwUk00dW1MTTlD?=
 =?utf-8?B?Qk9RRmxlUVR3QkdKbDZqanFtbmQ5Ykx6YzZDeUxYdTY0Z0xEY2J3VUVlUUhB?=
 =?utf-8?B?YTE3b3VnVnA4YXhyMENQY0tPbXQ3eFZ0d1BwNEVFYjQwdnZaUmpDdnJ0Z1Fp?=
 =?utf-8?B?SkZiSjRqNTE0VUdXMnNQVkZXL1N2US9DMWlJbUpQRnBlWmVLL1NyZEhpSHds?=
 =?utf-8?B?cStCOWRHMTlya1FmdEpYR1JzaWQ1NWJUZllHVTBCSTdNVHFDVDJWc2lPRldt?=
 =?utf-8?B?QWhuQjY0ak1HNW9SbUJEZTQvNFA0dWdZZjUreFdFYks5VmVIbW1pTmQxSGNP?=
 =?utf-8?B?REg4Q3dtWkh1dVFLUTRIMjlrZWRpMG9KMFN1S1NHUTIvZy9lcXZZK20xOVgv?=
 =?utf-8?Q?an6IJ+IJtd/vyc2uUlF+Rx4peNDnz1yl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 17:34:11.8649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f32ece53-55f1-4857-3e94-08dcab3daa6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550
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
 drivers/gpu/drm/radeon/radeon_atombios.c | 27 +++++++++++++-----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 97c4e10d0550..da8f8686bb9d 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -1714,15 +1714,18 @@ struct radeon_encoder_atom_dig *radeon_atombios_get_lvds_info(struct
 					record += sizeof(ATOM_LCD_MODE_CONTROL_CAP);
 					break;
 				case LCD_FAKE_EDID_PATCH_RECORD_TYPE:
-					fake_edid_record = (ATOM_FAKE_EDID_PATCH_RECORD *)record;
-					if (fake_edid_record->ucFakeEDIDLength) {
+										if (fake_edid_record->ucFakeEDIDLength) {
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
 								rdev->mode_info.bios_hardcoded_edid = edid;
@@ -1730,13 +1733,13 @@ struct radeon_encoder_atom_dig *radeon_atombios_get_lvds_info(struct
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

