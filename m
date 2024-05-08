Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34FCC04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4462E10FCF2;
	Wed,  8 May 2024 17:19:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sdsGlq8C";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DDB10FCF2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:19:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bi4Pfv1eEO+C6P5kTo0DX7eHd91DQZCk2jrCZ5pGxLhqGaz5DnBS1NAh3XWKuvJVilAg5AYpZj6ZKcLhjGgxdq8JktQzj5FUbG9dyXKwQq11pUXNsvocjVa498MNF/nkk6Ictf7Ey2mttOEHwDgAVoB9jhniCHiILNM6RAIpXpO1YCi7iucvEYxr1Yas3sIDf2bd/7gP12BbljRR9M46D/FPU/3k+qV8u91kyYPSYnB8P+kISLxZZPJH/uLAGudD0S+IO+cCKYMLNqIvr2lX+ib6exN0p0o6bJ8hyOsSLjgccuuQdTn7k/s85ra1g7iuOpd6K1pI6Pk86pKT2x/sYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVLHJbGPjLsmSOGRfG0e407sTbn600TQCnnrrhau/Xc=;
 b=ViyiTwpJXmnX6wBcnJ0ZFfLRy4NI2HNKlToL1/yhfi6Tpj8wgRQRT4s99gHr1JDP4t7ozwmkYxHBzIvM8cF9v1DbsaZnV3xi2QGjfrGpPejQ0iR8zz4VnnoxvHy6fjMrt7Vkbdpu4itvnVrbpDG/+k7g8ZVfJgSeeERdvMlTnoywpR8FpohS0RfFUJwfY+ML7FPD7oPLqeAD9txSUeT9ecF1AP8W+qbosp/cKLJOUX/PYTyz26nkl/9NtYBSmhJQvw7s3BOaUZwcaGE86uVvgqCh0KNoF0aBmBRMSaUCj/ZN0n4xxUD2oRDOcpGEc7ZEv2cPGCEbjINBupBByHlXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVLHJbGPjLsmSOGRfG0e407sTbn600TQCnnrrhau/Xc=;
 b=sdsGlq8CfRG0MzgAHkAd8E2YZOXw9cKXIRNe3KAdgte1l8bKItumSHrFb+P00AVzw7NXenBt2U8Q5LlY6hk+qJ0qjzKUOFVFbDKttLolwm44z23YNoj0WGGHPB82RzGl/tyXfea8E23j/8bE2um8z+dmIpG7x5vnLZ4hJ2h4oCY=
Received: from BL1PR13CA0288.namprd13.prod.outlook.com (2603:10b6:208:2bc::23)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 17:19:19 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:2bc:cafe::c3) by BL1PR13CA0288.outlook.office365.com
 (2603:10b6:208:2bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 17:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Wed, 8 May 2024 17:19:19 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:19:17 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Duncan Ma <duncan.ma@amd.com>,
 Ovidiu Bunea <ovidiu.bunea@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 19/20] drm/amd/display: Read default boot options
Date: Wed, 8 May 2024 11:13:19 -0600
Message-ID: <20240508171320.3292065-20-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508171320.3292065-1-alex.hung@amd.com>
References: <20240508171320.3292065-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 165d59ca-eb67-4c52-f8e1-08dc6f82fed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ccVyEPJ2jx7Ja0Iy439eI2DWUyFQ45KRvIwQCDrN2MC58oMt8d7wRdgrzYgD?=
 =?us-ascii?Q?8Kkgv7hB8NuZDtE6kUJlOFbzr4kKga5a4D7jbSxbLBWQ/8Gyrw3oSnRMv+5E?=
 =?us-ascii?Q?d0fvznQ+cqzkzshKJ6DIz9G56vdfLjGXRaktmA0Ccl/HAAnTStQD4h1laxTs?=
 =?us-ascii?Q?EcCt3XC5xuykM65zR47KNCcgT9HVGFHszzwUfIQJBkaMiUh4lVyOBKc3qicu?=
 =?us-ascii?Q?KQSyEOnhcXTcsth92oDrf80Kk51l73rN66atqrPbMC0q9vSJ3GAWSLcIlwuT?=
 =?us-ascii?Q?R1wsXfrkGndhxiZ2iXohPCdolVRpXIAopjvQ10nLIM12K6thCIasFMpNX7cI?=
 =?us-ascii?Q?a0/ZM/G7yZqvV7ZCx5CitLhts+7VWhfc3PMchNEkqlJzIZ7Yy0EHW6aKKEAC?=
 =?us-ascii?Q?DVTC5vRMRj4QTRf3qrYKVj9KDM2LIqy/8APDgwNzYRHVK0DbB1/ITIre9W0b?=
 =?us-ascii?Q?VLq3HsOmscUBAQO6inqS4WMWieNnrfx4jqzTiS4xo44hvK8fdAC/D6gb4Rvm?=
 =?us-ascii?Q?1hBwJgzZGEn+g89H+AJCw+YE3cifhsR5Uu2Qcli48Qemf8bV37HZnHNXfuSl?=
 =?us-ascii?Q?3mfv3pZPzLndvWy0gdVHiKxU0lcBKqO728ygkYeIpOm87nL+grZ6DhEOuFXG?=
 =?us-ascii?Q?eAFjrhOHihpT0hGXqQRLQWuPXmSdAhC2VU1Y7gScWNm9ECr/ejP8GggbNAg/?=
 =?us-ascii?Q?laKf3nU7QLmxXGzSnE5W24vY4ArYYGh1YVGuGw45zP70ckAIdK+MB/mpCDMw?=
 =?us-ascii?Q?NWXka2ba1zoXrGBsHY6AQtZXbKvODJ4iBpAUDvAEjxxaJRUm6NWqmKqe0Nlr?=
 =?us-ascii?Q?ZvJSjRn+pgpR6xWmxkZ7ezvLgD1cafd183Afg1EBpiO7tsG6SN6o7/q8929k?=
 =?us-ascii?Q?rPwv8S7XNhOZobQEdw8dwSlnfp5rQZ9fY40xCF0ih0ify+5LTue/YriObRpt?=
 =?us-ascii?Q?oGWa0VRxFtTVUJN2A1V0iGlwj6K0EIaa0aBswgBPig78zWOgeAgOcVoonhrx?=
 =?us-ascii?Q?58Vz+StLaicOw7PWZ7KBevO0gL3viloU4fdG3pTdvj07vyFRfQb6Tj9WFhzk?=
 =?us-ascii?Q?d9PahV2WcNkDzLOA64kRH2i3h4qS+YcYSfLrKpHwe7cRJUmruNHbWBuPodG8?=
 =?us-ascii?Q?4HNHJzMgB+jQ5bMRkzvTJKBWHGTj0ukiR8V9be9uYRyTlm55nzEkIdDGNQxc?=
 =?us-ascii?Q?bbAB6NwToHMFUr882YvhzhCs/+HWw9MqWU6cXLxidhjtpFujmEBxhWobA6te?=
 =?us-ascii?Q?2oaHFKnv+9bnMSdld0g4na+U/C+9gIVCpW+PfKnGsrCtoQ1VuvikEr4f/kem?=
 =?us-ascii?Q?MJaqCfXQZSgDRxskaiR9p3uHnwWHilTo9vwNjLnSzP+Bw/6R3/M9PP4VvEWg?=
 =?us-ascii?Q?+PZE7pxaalQ85ZP7AWEY2GksxFCn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:19:19.1297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 165d59ca-eb67-4c52-f8e1-08dc6f82fed7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781
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

From: Duncan Ma <duncan.ma@amd.com>

[WHY]
DPIA boot option is set by VBIOS. It gets
overwritten when driver loads DMU.

[HOW]
Read PreOS boot options and determine if
dpia is enabled.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 70e63aeb8f89..7f53074f4e48 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -410,10 +410,13 @@ union dmub_fw_boot_options dmub_dcn35_get_fw_boot_option(struct dmub_srv *dmub)
 void dmub_dcn35_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmub_srv_hw_params *params)
 {
 	union dmub_fw_boot_options boot_options = {0};
+	union dmub_fw_boot_options cur_boot_options = {0};
+
+	cur_boot_options = dmub_dcn35_get_fw_boot_option(dmub);
 
 	boot_options.bits.z10_disable = params->disable_z10;
 	boot_options.bits.dpia_supported = params->dpia_supported;
-	boot_options.bits.enable_dpia = params->disable_dpia == true ? 0:1;
+	boot_options.bits.enable_dpia = cur_boot_options.bits.enable_dpia && !params->disable_dpia;
 	boot_options.bits.usb4_cm_version = params->usb4_cm_version;
 	boot_options.bits.dpia_hpd_int_enable_supported = params->dpia_hpd_int_enable_supported;
 	boot_options.bits.power_optimization = params->power_optimization;
-- 
2.34.1

