Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1F0C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 03:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD8364E64
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 03:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD8364E64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 155876E0C1;
	Mon, 22 Feb 2021 03:53:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26EE06E0C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 03:53:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSbO5J4f/6kIMnVuNMdCFZ4T3XoXxUvh1gitbsbUfn1mtidc+vZq7JjKchCoxWGeBx4uewVh0CO4wGcutFm7k6QBfC75A2ECsLTQP03gU5NxRkDvRO61JK1jkKPwQEm3gf0vGCfbYGMS3uzoV30ObrCIkmk89rXwl9VQzgVGaORFGXMXUD4BtcF9voHv62Hgm8y62v6njAK/XBAELC8FyQsg/AtWbGOSQ4Jk2f38SsqccU8UTONbcveH7RUTvtZ2sJoTMZBT7Z+BerK0gIF92TyCCHjG+IrI6HiCAu0D/m5FpW781+hYCmLYcOz+2yZ2R5hLWwBY9aQT71cEzAIkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFfxL5olibYM+oK/2XofMrC2NsjzT9tKC224x111wHc=;
 b=fvhx4xEYaY6WoT8I4nIwLAUUlQU1lhP5e2A1i6ErSxHM2vLanOT900jkJ2up6IGHJxgbpgFAygopEId+Am3tv0dlC9H5VkBvOphVPsFnl5U3GkfguK2D5yFqr9+UaVLIvbHu59FSz/QTth2s2XNXAiEJUs0fdtv+C4Sj+gSsWN3cuPA6gAMLbFqSN8kqQtSTnpm5bpgVGndB5WgBtLbVErhGRLoS1RjCDHni6Le+IJDuCFcFca2A9AEZoO8gxf5Wn9VBJxa9FQtaXNWPOWeGPc1K4U8PYfcz57zptZ3IUpl5clyi046lkUK97hmaNS51IMzOHHBdEjsdw8Vjuo6PRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFfxL5olibYM+oK/2XofMrC2NsjzT9tKC224x111wHc=;
 b=r11pJbVkQvac5Tmx+5z2Pl5wS8IDqfdbdcy8BuScMgLz4UQn7YfXnNsZwwfZBNNwPEdlYfaJ7ppwQGu1RNYQhETIowKJAxPfFN0PBxwaW/Am4L4vO8barNzSfyNKGy3VdnSetDHoktjjQOaCTeLEbqjiUrwmaZukjhcdnVHLDI8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.33; Mon, 22 Feb 2021 03:53:20 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 03:53:20 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: correct Arcturus mmTHM_BACO_CNTL register address
Date: Mon, 22 Feb 2021 11:53:01 +0800
Message-Id: <20210222035301.1280592-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0401CA0004.apcprd04.prod.outlook.com
 (2603:1096:202:2::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0401CA0004.apcprd04.prod.outlook.com (2603:1096:202:2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Mon, 22 Feb 2021 03:53:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87ee31fe-42a8-48d4-f5c8-08d8d6e564e0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB47488C4AAD35C84C4FBB95F0E4819@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxdeI7Hc0Y+ZcbzBHjo3O5DYDK7AMUNO/3v7nRFAQy01d7Zie6WfzQ01Ipje9cUPMQbvDwSP0hfTuhNuxi2vk5/rDw2eDV054Ptj+1qFqrCGCivOufgIIfZNJLalLrZIdbOqkY6pqoV4Mr4geJEcniM5U+jE+AknyVlGvCKl5UavCY9i1sgxLDCS/L1h8Xc1niWkL9Jx+BzIcVTPYS673No4EBH4JgU8U+ZVfLRA10lpyBH+CspSuOPR6VfnvUcU/Ub3jacZar+MapIWKl8+WcxUIhfNIarlGfaUgSewC5HCfrUMkHGGc3hBRFDasY/jXWz3bWKdj0qkIIUJseXgfdKIwOLQ+x8JZKExi/FCKTGNKs4+L4G4/EwuHHXSVL2FSGvYgBK+8KaMNIR0mfDIi4E2eL7VFgVEgtv/7wn3IlMAaKGtuAFJWGcKIz1JPUTxujGd560Q8Nfa0YdttoVGT9SFLMnUqdvlBW3tYrfsNtuZ4QzBiTPEJ8n+P2do8fPP8IAE3pledBqAVo2R0zZbTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(66946007)(478600001)(66556008)(86362001)(66476007)(8676002)(8936002)(2906002)(1076003)(6916009)(4326008)(316002)(36756003)(956004)(5660300002)(6486002)(83380400001)(52116002)(7696005)(2616005)(26005)(44832011)(186003)(6666004)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0yLZhhXas34obMIx6epVHbrIQx/xggjhqz7Pa3Kpm/PkISAkeLDkWrDJy7kF?=
 =?us-ascii?Q?u3ZqogX7Fnjj0+aXt+XI09wwrz88XvoWVMm+DIVB4TtASxmgraJFtK3ZWi19?=
 =?us-ascii?Q?iXY3AF8JCdSYf9cjD4vvG9EIBDVM/x6/SsJe6MubNM1h3OkMEx2gPyLHoOPU?=
 =?us-ascii?Q?IW1nf6kq7Ew1yy5vCrgn0gzQdZ1FTXvUiCZt+VM07kYHffox3w1IrKIZi1cx?=
 =?us-ascii?Q?BxE7CjFQcOTYcqLNC/4BekmLNJ4fsy1LO1Gy+i8a0GNDlOQovHXOHlcSLyGL?=
 =?us-ascii?Q?07OrJ5XDn0zC9SLsWbNhMESQTLFZ+unWrwvD3WjD1IXS5ppepsdTZFI2aDCR?=
 =?us-ascii?Q?nQ4jTN3Hn6XtSsFHWAMWwa0hXs2j/y7XLhAeuEVzfWgp2i31yIIOwPaSXIiU?=
 =?us-ascii?Q?oyeMDKP/99dZLd3GElZsWl/WCjc9OxHViRoPDfgxxZ3wPMKr7kd1y0e3xnla?=
 =?us-ascii?Q?sRNWQpK9ObAcVd40j3qa/Li9E1d8yZ5gAkRuyvDixKXeneMyYT/RVe+RtPkH?=
 =?us-ascii?Q?tA9DaZP5Vuf0WvuTyo/EhcJfVdNGXVgaVvQ2TXTvYLuVD9/jRJajcC9DJpAM?=
 =?us-ascii?Q?fIHa6xM8+dMeWZIiLLxj6J7yy3qkTTgSkKHw6pO9u0CZEFgZyHHOR+HgZOV0?=
 =?us-ascii?Q?ClQcbXmJWOUZCBscOLUUaSIdeuLddV+PDecpiNgDCqAu+sZ/E8DB3rY9pTgg?=
 =?us-ascii?Q?c+2tYS7lXX68MQ6bVFSRuxlP6E3UNkFXCVoeAV44jVvzdq6evf6DlKDcr7x4?=
 =?us-ascii?Q?1aYqPQzq1uil+sMHdyl+RQIbDLxrktP1Ew/bqQ0R85Qf5VxQI/p5PqDZQByR?=
 =?us-ascii?Q?skML9YnFLD5t2X8MYJrrHSkECzrgGIzEGYXc5MD7900yrajVgtKW1DAeG7s+?=
 =?us-ascii?Q?Lvruj0npcWHfryeXSpWXCRYjoACgLK9gBpEwiQs8r3lgFP51GzPafRQ20VhA?=
 =?us-ascii?Q?6+F5vmfXdpG8r/8ExffKovhyuFPI9EpEo5jI5BPxQWCGMIo1nqJ6v3MBPq9O?=
 =?us-ascii?Q?3WLHKhPMDHir+MrJUuL9lLG9U+vMAVTPDKuYipAc8iI4+KbH/l9Do75mLHzU?=
 =?us-ascii?Q?jlSVJG3wvIVPPYj8dnpuc2BHkgu4b0kIwu/++MBQuMvGsrHgU5kAqohcTsPu?=
 =?us-ascii?Q?4vmx8Pw/gtM0PbYTnvr1YVPS+n1Iy5dJvE0/tZz68RjuqV01fkZzyDVLfAW8?=
 =?us-ascii?Q?aZQKxj8ltLGeA/dJpriIUBG0NpL8J3OSPVoZxSxyjegR8mJ+H9vGd1+wgzYD?=
 =?us-ascii?Q?4Trn4vWikgIhF4wdTBSYg4QRFN3pw2BxWfxk9i6L9NoYXVpQz0w29cwYbApp?=
 =?us-ascii?Q?kz6klIL1b6XEZSTVYEUGkwCT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ee31fe-42a8-48d4-f5c8-08d8d6e564e0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 03:53:20.6171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/8LF6ARGcQtPcLaCSKEQjJvnJ9gntptXEP7gyGbNZ9i7Uj/P3YEb21f6t4plMj/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Arcturus has a different register address from other SMU V11
ASICs.

Change-Id: I2bb9b4f00ebd563880ed3d3687e8f24124213150
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b0922b221bf1..74758fb10de2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -78,6 +78,9 @@ MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_smc.bin");
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xC000
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0xE
 
+#define mmTHM_BACO_CNTL_ARCT			0xA7
+#define mmTHM_BACO_CNTL_ARCT_BASE_IDX		0
+
 static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
 static int link_speed[] = {25, 50, 80, 160};
 
@@ -1532,9 +1535,15 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 			break;
 		default:
 			if (!ras || !ras->supported) {
-				data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
-				data |= 0x80000000;
-				WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
+				if (adev->asic_type == CHIP_ARCTURUS) {
+					data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT);
+					data |= 0x80000000;
+					WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT, data);
+				} else {
+					data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
+					data |= 0x80000000;
+					WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
+				}
 
 				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 0, NULL);
 			} else {
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
