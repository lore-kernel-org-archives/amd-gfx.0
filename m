Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E4BC3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 20:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D816910E066;
	Tue, 23 Jul 2024 20:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MSHvUOrQ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28DFC10E066
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 20:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=le4AmVT2MOkX+Gq0ZSHbdGiFDcVaY7V5Mz7IgiZNVVYAB7Xid81grxu1t3VzOk8hcx+goyGBtigO9sYRBEQ0L97mFRugyDmy94CVjNarPUlE+ZEHC11uOuhZwv3FThb+IRdm0Ec9FtiaQcrgiUefsuO/o+E0z8SNi4pZgNWwVl0LW0YtPUUQusvzW4RDDtKV5zlEiCHHQ+WkrnDeTq5cVq6i9pekT7TcNkoqYizqSQHlercm5kBhSqz0e/UheT5myEbSlFWVxPT0+Andg/MNsHEBSUSqQh/ofe4j6rp6IpPDavhMOk7CvV/LHFNKLlZ3BQkbtJijLm6MZ6neQX7fxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JADMnesaYn+OQXiCZ5P/H1DaaRcSq0FzkjhtQJbxNgY=;
 b=zNYIyuCh0psMIWpRGmJ0+Ghn+XFJ7Zb1lm8DH2iAJCV4/HeSX2mJuEMhXPFouvlVSzjorvY0LuLwozSDaOuGaBH5yoabuMURIdQn5pyYoSATk9iFfRLuSXvFS4VDjXelVJarPwHZz34FGu7j2c8nL8ktBtg+FMnPCvLzSLfcHokymXSLITD2DK7Xv+zv6BMYIrbqxURsLfcJZ+QWT6/QZDGEMF4/r0eja9mgPe1vfDoiUEtKL5Xz09Mh1vX5PMYTYX8oChFwvMq1Uk/nkK4PUhNJ/7SiVinBDyLd1K5ejMMYxVQI4qy8sGxm8wOjaSbZjdyThY531OaseIrzu5ccGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JADMnesaYn+OQXiCZ5P/H1DaaRcSq0FzkjhtQJbxNgY=;
 b=MSHvUOrQ8ZyPlSLUB0zHdKl+D+nIAnzMvHoL1HfH7Wgz/QGQTSFbMzF3LwP32NWwW67Qr+ZL6os5ZZtb/FM/rkkXAWEJ6AR5vzKYVQ7ZpWM+nqj0ctTTYqct+Tr/JxLlfnAQy4JVlYfYcQvgypz8vRLIsNgapjVl9v9xdX81GvU=
Received: from SJ0PR05CA0095.namprd05.prod.outlook.com (2603:10b6:a03:334::10)
 by DS0PR12MB9274.namprd12.prod.outlook.com (2603:10b6:8:1a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 20:51:37 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::f8) by SJ0PR05CA0095.outlook.office365.com
 (2603:10b6:a03:334::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.13 via Frontend
 Transport; Tue, 23 Jul 2024 20:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 20:51:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 23 Jul
 2024 15:51:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 2/2 V2] drm/radeon: properly handle vbios fake edid sizing
Date: Tue, 23 Jul 2024 16:51:21 -0400
Message-ID: <20240723205121.2412168-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723205121.2412168-1-alexander.deucher@amd.com>
References: <20240723205121.2412168-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DS0PR12MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: 53fdad4b-a870-4f3a-21af-08dcab593eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUN2aXhYZXdFUUlUd3ZtK0lJYzlPL0VTdG9xZ1JXOWIvazE0RmtEWks1OTRm?=
 =?utf-8?B?UXo3NUxBcHdmLzEyc1ZoTVpsNEtIcE5NdDFHM2hZQ0g3SGhxTVJxT2F5UE1o?=
 =?utf-8?B?VDZpNmNHcjk2VEwvaWZjUGpMYjB2VTQ3N1NpYzN6MGpNVUtLOG5nNXlIOTN6?=
 =?utf-8?B?SkhwblBZSjEwNlZYejVrYzNTZEtMSERaVmRtOE5WYWhTOVFEdndSdUNCcHMr?=
 =?utf-8?B?THQ5ZStUZFpJRG42ZDNFQW8wdCsvN2M0TGFMTG14RWd0M0RRMUp3NzRNZzVy?=
 =?utf-8?B?cGFIS2JvSW9IZnRSUVlrRk9PWnlXTlJzSm0rcnBlZi9tU1VJcWFzT2lnY2pk?=
 =?utf-8?B?bmsreHFRZy9ObmNlYmZybzNZeEQ5Q2c5aHBTRUpvOUpkZCt3T3NLa1J3TUZt?=
 =?utf-8?B?bENVNWFKSTFLV0l5SmJibWovSmlPa0NBbDFHOTNwclMrWmpDNENIYTlYZ1c1?=
 =?utf-8?B?N01uR2RxY2E2SzhjVUtYQWdoTDdmWVh3SWVMQ2Y1VzMvLzJMckhLclV3dHhB?=
 =?utf-8?B?Sk5GYXdnYXlWREU5VzFMRDJqd21ZRWhGalgzamROMGk1L3pGM05SUE9KcCs3?=
 =?utf-8?B?TDZwS2piY3IweHVlSXR0QlIwbUZIa05JcnR0bGNoQlB4cWV4MUxuMVc4TVNW?=
 =?utf-8?B?M3JESktGZTRHeTJmajQ0V1BrdDhRVnpDUlRqVjhSMHIvTmZjWUZucGx5d0pv?=
 =?utf-8?B?L2xRVU82NmlPODRjZnQvOUkxR2RuR3FTYURidlE1RHJGTDJXSXRzb2grQUQ4?=
 =?utf-8?B?MVJmekJnQ05kUHZsN0M5MjVpY29EcnEwK1VVSWFtS1FvMWV4QzlnQU5aeGdQ?=
 =?utf-8?B?UTc5cHNlR3RQQXR3Sk9qQURGMlBIelQzRnZGb3o5U2x3aE5za2xOTERSZUtz?=
 =?utf-8?B?SVBDWER1SlQ1aisvaXhwWlUwaVZWU256cTY5LzhRclE4Zmt0SDdlTUMrMjNY?=
 =?utf-8?B?NDM2MFcvZDZWdnUzOHhkblIrSGpiWnpleGRIaXZOM3hta3pDYWY3TnJrWTNN?=
 =?utf-8?B?UHlsVXlBMUxqdy9mTVVVREZmVzA0RUN4dDFvVEJ3T0pxVVhqaDRTZm9GNTdt?=
 =?utf-8?B?dnpMV29yYVdidHhGMjJRQ0RWdDN0cTdiaXNZN2pZc2VtZmljcnFjeDQreWhQ?=
 =?utf-8?B?L1IxMWE0Tk0yRjl3MzFUa1FMWjRiVmJUbjNFNDdwdmpsQ0F5U3NpUnBVYm10?=
 =?utf-8?B?TFRFTmdHYkVOLyt0QW9sU216VUwxZmJHbzlENnNtZE9oOGZVR1hpQ1M4UHl1?=
 =?utf-8?B?ZUY2QXBXYldMZlRSTTNVY1VLeWMzeGlCSW5IT0xFcnZuR0c3dWV4d1IxNGx3?=
 =?utf-8?B?V1pEbGRLQks4UFJaNWx6T0ZvTXgzL3FuOE5UMU1lQVgyWGhjOCthYTN5Tnhh?=
 =?utf-8?B?OGIxMytXQmFqSG5DbEIzQWFsT1IxYVZ4L1pxelY1K3dtVDVleGFBM3c1TVJC?=
 =?utf-8?B?WGFwVXYyTTBpNEZ5ZmJoNzBMWnBNVk9XMlRWOE1Va2dMSFl5NWhXUHlvRHhS?=
 =?utf-8?B?OU51NkVWclZWSURRc0lKNm5TU3BGbFl2bUJxanJoRldiMnphSkw1akMrTlJi?=
 =?utf-8?B?WDJsUmcrNTlHWHdEMEo2a2taeHpDa2ZaVWhSaE9WWThGTTNNVzhMc1YxYUJD?=
 =?utf-8?B?cXV2a0xrYXNydlUxVzZRWHNyMGZNYWVOUk1BQWt5TWhSMGtQc1lyYzI4WmNK?=
 =?utf-8?B?YzVRcEkrbGdTUk1VdXpmV1BXa0xwS1QxWUY3Uk5nZmJCY2hFa0pKUVJnMVBa?=
 =?utf-8?B?ZUxZZERUblFkbDk4T2ExcUtNSzR5aVovelVOK1BxTXNkTklnbitFelROVm14?=
 =?utf-8?B?WkNXS0sybGlzcmpCcWFNRm4xY2hWQmpzM21EZGtTSFRodWhVQXpCSDh4SEsz?=
 =?utf-8?Q?fkKRA+vMpU8Vf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 20:51:36.8106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fdad4b-a870-4f3a-21af-08dcab593eaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9274
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
Link: https://lists.freedesktop.org/archives/amd-gfx/2024-June/109964.html
Fixes: c324acd5032f ("drm/radeon/kms: parse the extended LCD info block")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

V2: Incorporate comments.
    Fix accidently dropped hunk.

 drivers/gpu/drm/radeon/radeon_atombios.c | 29 +++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 97c4e10d0550..168f3f94003b 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -1717,26 +1717,29 @@ struct radeon_encoder_atom_dig *radeon_atombios_get_lvds_info(struct
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
+						edid = kmemdup(&fake_edid_record->ucFakeEDIDString[0],
+							       edid_size, GFP_KERNEL);
 						if (edid) {
-							memcpy((u8 *)edid, (u8 *)&fake_edid_record->ucFakeEDIDString[0],
-							       fake_edid_record->ucFakeEDIDLength);
-
 							if (drm_edid_is_valid(edid)) {
 								rdev->mode_info.bios_hardcoded_edid = edid;
 								rdev->mode_info.bios_hardcoded_edid_size = edid_size;
-							} else
+							} else {
 								kfree(edid);
+							}
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

