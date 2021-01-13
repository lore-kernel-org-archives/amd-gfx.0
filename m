Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0694C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 12:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7D023339
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 12:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7D023339
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 858A76E978;
	Wed, 13 Jan 2021 12:30:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98CA66E95E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 12:30:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXVnwJGEJh41P4y9ro+3tJy7Q8vI1Hf7MLUd+7VvcrPWGKnCA90e2YzjIUArjtGOW1YjrI5p695ol66+AKv7unQY9FumIbb+H5s5dPNdZuSOR0uQGlWtIttFvpi/8G/xNitWILDbkMFtsyCpz57yFd0KXZlAytjlwYA2BmZ5/09wN08rH84h7FQ3gNw6saMBAGl9dsXlWHzbT5q1IOJkmYoYGg2jVbjMuZ+ERrCXbu5ovShbLnhX4AAun//D/8I4L4Jx4nj9ENBM+V0RjLFAXhXRZK9nxdUjXfzwpODyvg5AtG8abqMlfvptVAvPnRj7Eft6C5KtjtYP5s8VkZhODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0FUY41uH3JiDlc//sXPfN2hsgVsaDG9qV3M8/8MfqY=;
 b=OymgpzwGphURfpCg2p1pHyBWpeFJTN1136hTHSEGzxw7ynoWYVQFUEohkSt9QqAbZ4bpRDKrViuNs6Gm5lrhROPa8ethpyhJ0gwi9nOiHLzLNpogEGdBCmRhKQYw2UCXmUymNQZxvPwt/p/LdvA6fv+w0XjbtKy63nWmUOfBsgCuksgajugQPhh3WC3ReEMZxqEkd8zvWDuwwnvwaQqAucliFIwd4IgAxDUHWgLBy7faVuUTz3iPhZdG0wUT8q/HYxw/CJhsmNrv5acjJW695RQ5ty019djOe+kBkbEshKNgqAU6elvbFlHUVHcXQFRcr2/7K/9RYQqwPOmgh9ZjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0FUY41uH3JiDlc//sXPfN2hsgVsaDG9qV3M8/8MfqY=;
 b=sdnXZG1tpTI6bs0OUB2GzwcbvrF/PasxzzbKUZ9cQ0sXMeNxPtZ8jnexpNuO7/+e8PB4BT2ZKLairAx5pKuGt95x3nr0bHEOKMMMLDLYaUbw9/5wzwXh38FPusjcFMq5M+0w8lVIID13afXeXxsfTfq2I0g5SJRg3NX8YCzDhGw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB2541.namprd12.prod.outlook.com (2603:10b6:300:e5::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 12:30:09 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 12:30:09 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix vram type and bandwidth error for DDR5 and
 DDR4
Date: Wed, 13 Jan 2021 20:29:48 +0800
Message-Id: <20210113122948.218187-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:203:b0::23) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HK0PR03CA0107.apcprd03.prod.outlook.com (2603:1096:203:b0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Wed, 13 Jan 2021 12:30:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a5d5cc77-8bcd-4642-0dd0-08d8b7bef793
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2541DD6C271C2F58D06BEEAAECA90@MWHPR1201MB2541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sqj0/qvljC2O3z1x5lRomFJiWtdsK4PACpgYU7EKLwb2lFAoam+rtVGfDCHi0tyTLJjcLMw+MVY9FCfQgmGwD6e2dJVVOiEM8p01m3/pi+2i56eTu5VkPgBdcaxhh/pclIP4iLEkxNqx2dJzOYx2Ro2E55th1SgC0Yzv8QUAprHkaEMq9q4IRVR6M70dF7Z3r0nlgMiSNnARg6PV1klCb116xflb5OcvITqH1UUm/cxBODREosZVameBFFyZDAt7OMHbu8544fOP1Hm4KefRBe9vsBxSNHPUZ7qppU9OMBCCR4tNGD3F70yzjFeSaovnYUn9tpMkKfQYqm6y5XamTVUZee2U50vtUP+D9k20ZqtKBJjXeS707GHBlwpCWeKMgjKWTaNyIXgfaxABMB7Gqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(16526019)(2616005)(36756003)(956004)(2906002)(66556008)(52116002)(186003)(7696005)(4326008)(26005)(86362001)(54906003)(6916009)(8936002)(66946007)(5660300002)(316002)(66476007)(8676002)(1076003)(6666004)(6486002)(83380400001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SVXmcKUEeMFCXmfySyew/zxsaYsaM+6pvQiKgSlf6aC1rLHh3PnDgak7Ku5b?=
 =?us-ascii?Q?zN4GND4b8mWtTUGLhnL0b3IULv7BZUV8TJTSs8f0uLnsu7xODR1AHTQqAjs1?=
 =?us-ascii?Q?cldPIz2ldlxqtqgdE5/03WMnghPbqGgRllAt5F2Rrq8LrOTXwl8wd+2/HdD0?=
 =?us-ascii?Q?QyGuPTI9l5KrPNrmeI0wXIYUlDHRuZGTygDWD0xDXT2xYp0MsqeONsfeGz1l?=
 =?us-ascii?Q?moAT7R9ckY0GKsf6WN+NOGCJhyQo3HdVo/In4CPEAk7Fl6Sqzxtqcq39NgnU?=
 =?us-ascii?Q?XPET6GFIMlHzaLBicyGeEUN6IYNTPrjqFW6h4n8yF9GvKTB08XL2Lcplmdlx?=
 =?us-ascii?Q?CmNb6kkKnDCdef1AyN7aMufforHtzam/X7A46ZAqyOdVaCq7t5vowrrZuAtm?=
 =?us-ascii?Q?36VAKINQz83cINGxRO36e0yi+xYt7sn7+32RJYGaQyeB73iZ4Y/LQWrcixSi?=
 =?us-ascii?Q?5gm6thY6MQXraDVWiUPRcCUGYnf3xSz66XnrCUjH3nmZJY2WaqPq/0B8qCIe?=
 =?us-ascii?Q?qBvFcbVfgZxc4w4I8uE5ULbUW8cUDb23AVWl8x9mL/Zvx8Ns9OyU7vhp8lJI?=
 =?us-ascii?Q?scoGaiKDxYrzFHF328qbnB0E5KhB2qChwbJ4lKp9NXNLQm/7JfDNsCiCOBK0?=
 =?us-ascii?Q?S1wM0U1fg0fP0D5yXmz0YDmVgT6LyTge28RA5KoDNDEW1i9GrM3FLTh5teGR?=
 =?us-ascii?Q?IGtd+OnmY/IrX26CdiCPs8wcgg52ZK36gw7mDS7XsC5hZ5C5ZV5gVcVpDyXv?=
 =?us-ascii?Q?nl6zD/LKPGGKi7NcXYWLDpUtxAl2+956bBD0sItCAPKqX5OY5Dbpu0SGmuDd?=
 =?us-ascii?Q?8EultBgKbL/jJdJhe1P6ungXWkMmvzQ62+bts3/IbIc2nxo0avJKp+TJMIxz?=
 =?us-ascii?Q?Q6/ufyjfr3sUVouqfr/TvbF+a6GXlfz4L11N4zmpVYWaQm+dmWve+ced1ZCC?=
 =?us-ascii?Q?BGsBKpxMv6MA48MGy3deTsT7RxNL3l+wLIMxCDpPodqbagBGolZff6u7kiL+?=
 =?us-ascii?Q?Igmz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 12:30:09.7204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d5cc77-8bcd-4642-0dd0-08d8b7bef793
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9DTJwgbu5Hf5kn60V6k6lMboTuDxIu9kCtMpSaFDe6hU5EgMx8oqezGIPtQq1mquBa7ACr8BjV3dwJs1Yoc4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2541
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to update atomfirmware parser for the memory type and
bandwidth of DDR5 and DDR4.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 53 +++++++++++++------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 306077884a67..6107ac91db25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -112,6 +112,7 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
 union igp_info {
 	struct atom_integrated_system_info_v1_11 v11;
 	struct atom_integrated_system_info_v1_12 v12;
+	struct atom_integrated_system_info_v2_1 v21;
 };
 
 union umc_info {
@@ -209,24 +210,42 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 		if (adev->flags & AMD_IS_APU) {
 			igp_info = (union igp_info *)
 				(mode_info->atom_context->bios + data_offset);
-			switch (crev) {
-			case 11:
-				mem_channel_number = igp_info->v11.umachannelnumber;
-				/* channel width is 64 */
-				if (vram_width)
-					*vram_width = mem_channel_number * 64;
-				mem_type = igp_info->v11.memorytype;
-				if (vram_type)
-					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+			switch (frev) {
+			case 1:
+				switch (crev) {
+				case 11:
+				case 12:
+					mem_channel_number = igp_info->v11.umachannelnumber;
+					if (!mem_channel_number)
+						mem_channel_number = 1;
+					/* channel width is 64 */
+					if (vram_width)
+						*vram_width = mem_channel_number * 64;
+					mem_type = igp_info->v11.memorytype;
+					if (vram_type)
+						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+					break;
+				default:
+					return -EINVAL;
+				}
 				break;
-			case 12:
-				mem_channel_number = igp_info->v12.umachannelnumber;
-				/* channel width is 64 */
-				if (vram_width)
-					*vram_width = mem_channel_number * 64;
-				mem_type = igp_info->v12.memorytype;
-				if (vram_type)
-					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+			case 2:
+				switch (crev) {
+				case 1:
+				case 2:
+					mem_channel_number = igp_info->v21.umachannelnumber;
+					if (!mem_channel_number)
+						mem_channel_number = 1;
+					/* channel width is 64 */
+					if (vram_width)
+						*vram_width = mem_channel_number * 64;
+					mem_type = igp_info->v21.memorytype;
+					if (vram_type)
+						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+					break;
+				default:
+					return -EINVAL;
+				}
 				break;
 			default:
 				return -EINVAL;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
