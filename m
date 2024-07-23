Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94650C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 20:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2830A10E642;
	Tue, 23 Jul 2024 20:51:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SWcjsW1H";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2BF610E63F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 20:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIWmBZbScDtIPQrcHIw4nkRvx26uK7RuffqWewmCUBquoDQffvVoZw4ixqIRnSK1CDEO7GBSffJ+v4Zmok/GRTGrV5gXCwZqlw5NXKY0+qdW0rgOZcsrybeZfiM1YA0biau/aiIkphQb8Bp8uhoKRLScjorxT74Z+J3PMbh4UiCuCQxl7wqjvNKliMwykatL3XfpauZKrqlHaEHnAEBwLjbAuTdmzR/SEKd0IbHzzHv6Hlb6upz2qHenTUWlwWAf2M8eFf9bvCPNtcS7EHJ0PAtjuYDST3gvljhwIiYN6wU3fXJic5IdkBugshsMhq0iUGdM2z06KLgZgcoDQ5mKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mW/zhjdY3V4cNDQL98Tlk3E9FYJDAKcBPhUjiJ+4+HM=;
 b=wQbtXLyZYchR4ebYo/Y4U3VHKYxslkF1/6MI0QQoAiUiE5Zkd+R9gvmqNR8ninvyc+45hG4j1MlWOjrpxhlXK0FfbSqwC+fq6FcrRd8KuyoyLVdbxApNkwbXEJloiWHTQ2x/UODeXqqncRUw1ehJ0nHc29rhd72bro54zGKeoBGahcRcXmrHd2h3EN+h5hwETysZ1oxumlggEVs687NvwcP1i2vTWL1ALb0JEuAmilROT0MVB0NeIaWNZv72Bfo7Y114eWMfwhE8+Bv2caW4W0YDlFX3x7IGRvLEVLxn9Z+1sR7SidQcxwQEa3oJrXLRD7rMUyhBoXQdxINJ0/gxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW/zhjdY3V4cNDQL98Tlk3E9FYJDAKcBPhUjiJ+4+HM=;
 b=SWcjsW1HE8AJftQO93vQEkpJwPg3scMfAhFOy72XoZC4I2RJRF4uzO+dQZJTVjRn1LWWBNsJ6XFYH/oC8jlcOeRgk4KudZLYzeFBZoL+2+rLWDmx5QzF7/sHm4Wo+cRhWwPV24fBvRBmW/3Q1qfTndzzOXjCN5ge0igNzVp+RyA=
Received: from SJ0PR05CA0095.namprd05.prod.outlook.com (2603:10b6:a03:334::10)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 20:51:36 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::8b) by SJ0PR05CA0095.outlook.office365.com
 (2603:10b6:a03:334::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.13 via Frontend
 Transport; Tue, 23 Jul 2024 20:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 20:51:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 23 Jul
 2024 15:51:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 1/2 V2] drm/amdgpu: properly handle vbios fake edid sizing
Date: Tue, 23 Jul 2024 16:51:20 -0400
Message-ID: <20240723205121.2412168-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bba4f4d-7760-4910-a180-08dcab593dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnQxTTJqOFB3SjVFeVhVTUg4Z3dwcTBRNVBNdmJ1elRWSkttVlR0RzYwTmpP?=
 =?utf-8?B?c2xISlhmVll0ajV3NGNONTkwZ3pPSld0UTRjUU9ScFh0K1ZzOSsxYUN0NGlS?=
 =?utf-8?B?VzA4YzVRaHdoRk9DbzJuWjRsTTcvZTRLazNsUzhEQmFyQm1nVjJwYURmRHMz?=
 =?utf-8?B?dmFCYlZ5QjNPY3MzcnRnOWtpanZQeFZKdUVlR0NvN3ZheXZwY0o4ejBxMmg4?=
 =?utf-8?B?azRNQVo4SFNPSTFNZXVUZ1BIcGpHSzhBZ1E1VHFTVlFJWDFsTERPQnprQWhZ?=
 =?utf-8?B?cDFRamJURkdocmE3Nk05aUhYNmYyNjhkaW5QZGdjQkthdHdrVlgvVE91M3ph?=
 =?utf-8?B?YzIvcno2QlhISFJUNXFFTGdrUUNNK2ZNMGwwaUt2eVl4NEFhRExQOVh2V2ZT?=
 =?utf-8?B?NzhqNlJIZ0hvWnZubnMwbXl5M0lxWnd4TFIyRmtGY2ZRWmRwVmNwejY2UEFy?=
 =?utf-8?B?cnhGV0NXem5iUVRqM01UMms1TTB4OVVMb2UvcEwxWEFOT3VxOXNNaTdyc2k0?=
 =?utf-8?B?dDdscU41VC94aFFqSjJaQVBpWnYrZFRhajZvclh5Y2VnQzRjeXFEa0VBQXM5?=
 =?utf-8?B?ek9Tb3pvUWhBams0RElYaG5ET1UxSFE1VW1HdWNnV2xrRkhQNEN5Yk4xUlpp?=
 =?utf-8?B?cDBaOVloNEk2TFRGejJVYWFMOCtvWkNhK25aaDcxMlJsYy82OVJFc3FTRGdZ?=
 =?utf-8?B?elhsc1VGclpMamlUS0hjMVhEWndBMmdqYlNaNHFHV1FXWWhOaElXdWdNT2JP?=
 =?utf-8?B?K05pV2NKTG9EM3lQRDc2eWVCZXdYbytaNFI3bkNrYVExemhUTmlhcElwb1E5?=
 =?utf-8?B?QlhRWDl2NkNGOWw4S29Cb3VadW5NZy8xK1dQc3Q1RFd2SmU3RGRwU2FuZ0hJ?=
 =?utf-8?B?TmxFOFZHd1Q2aXdLVFJKWlVEQzNFZld5QlB6NFRWam1Rdmd6TXZld1hWZU5J?=
 =?utf-8?B?UDlsV0k2dWZnQi9DVTMwVFVBcFBqN3ZjWnE1dWVBa2Z2MGtjdTJQaVA5OGpN?=
 =?utf-8?B?cXBUSHFFc1QvSktsS3k5UnRuaW9YRUg0NmVKSlZlREk3aXZIeExsVnd6VTlQ?=
 =?utf-8?B?WFRTOFZNVTFhS0tEM28wNS9lUG9ZbUtMRktjaklCZzhXQW9sR1NrdGJndEcy?=
 =?utf-8?B?V09wUEIxbzRNU0xHWHYyNlAyTlhKeHlGZEtJYWxwc2RvWWdFRWxmZHpNZDBZ?=
 =?utf-8?B?aDJZcHNqZFplbHYyMHdjb0xmYXovNFRlSWgvU2lqckJnVFllWGpTck5TdVMz?=
 =?utf-8?B?clFiWEkzQU1zNFpDOUlPMXo1S1J4Y0E0RGowcmFJcHgzWWJpZjdRVVl4U2V3?=
 =?utf-8?B?ZkMvbFJGU2tlK1dHTGE3Skd2Z250aVlmaDhpZXJGZTVMU2Mvd3U2NVhobWZK?=
 =?utf-8?B?cENlcUphemVITzBwcWtMb1B2OFg1NTcrZmxFaGVWaE1ZWkp2cDRpUWtGL2FY?=
 =?utf-8?B?OUVhYWdPZW96SWxOM0lJNkl3MzNZdmhza1lmTml6TzFaeXlFREFwaFFGZ1NV?=
 =?utf-8?B?d21yMmQ4NkUvK3JIdDRFUU5pRnpEcWVwUHNpRW9YSGQralo5a3V6QTJYUFJi?=
 =?utf-8?B?amh0VTJKZ1k0OXovdHFGMEs1RmlZcHRWQWxEWVQrSEIzMTNDemtJS3NLUGVN?=
 =?utf-8?B?SFpUVVNrblBpbHpJMEJsZCthYUZ2MUNGS0wxZ25Hd0VoQ2NZZjV3QlMyV3dF?=
 =?utf-8?B?MG5QZ1VkdnRaVFJ4SWVwSVhTRVl0NkdxdnN4YVBCOTEySUwwRlV0eVlJMUlu?=
 =?utf-8?B?NGZ6UGNXSW1tU09zZ0puK2MvRzlXUE5Mek5nZVJQbDZiNHJUQkJTclo0MGZX?=
 =?utf-8?B?K09xZjNXK2JKNkdJVVZpcWx2OTBYa3ZZdSswR0VSZUZwalJ5REw2YXR5L1lC?=
 =?utf-8?Q?JObRPfu8HLqog?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 20:51:35.3106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bba4f4d-7760-4910-a180-08dcab593dc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323
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
Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

V2: Incorporate comments.

 .../gpu/drm/amd/amdgpu/atombios_encoders.c    | 29 ++++++++++---------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index 25feab188dfe..ebf83fee43bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -2065,26 +2065,29 @@ amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
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
 								adev->mode_info.bios_hardcoded_edid = edid;
 								adev->mode_info.bios_hardcoded_edid_size = edid_size;
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

