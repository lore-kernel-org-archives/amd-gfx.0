Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB34D2E014
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 04:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BFBD10E71B;
	Wed, 23 Oct 2024 04:54:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hqYSCPZG";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BF1510E71B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 04:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTXnhQ2jLUtbD9ulJm2XAp4wArbMwmNm6NF/OZP4YQ6zAlXaD+GQZqblREV6+o0yeT/VG3vcXJLBBngTbUAUuYcCuvBf5ml3AoHlZ47JzaRI2C8MEn8QGbMTlwJOMZqDjx1JAvzblzNlT3dXHp0inBgAhu2zundU8qYuiJss7/b6M2eOLZC9YGwXAjC2Oy3+jF8eTeb/rjxta1mutNRf3gf13YPacxUE0BSjg3Gpf24jkUajvQM8lwhNy5VdCBvEUyjmVU1eoTJGEtrCZ9otAd4deaiTOM+LmK1gVro8TFM2nEJ6dnzrvfeEP1CfhB4SmZ+RPnfAqul70BTo8CR8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vy11e6Jx9oE18r3ZgPME8cQmCMH9xMUN1ypiM8pr6r8=;
 b=Xxo/YgRALSulhC8J4Q5bDgmdE/eHWg+Wat2Zx0NOg5PuPfJ5EemOv1EUa+wLdHU0Ddwp1v5CMapCcxJqffV1jw8tB6aSPJHFBs57uPPnsXk5kDm6QEbNJWEmlooMyL03mSQOw8Gk7uGonPNJv6u4tMjnjBq93XkRhG9ok1OainKy9p8Opzdy0bukrte7dKeE+bHC/rk5LSsuXbTDln1sU6ADFkGKylSo4+5vC6Dc5SOL2qoQQG/qbYG+smHCdplgNIvgXeGPO3Xu2fGJnNEp+KHWA+D7A5es+pyhR83gHLl2O5UDGwB/vlzXBbsPf0dzDf0/O6sdzxqXHWVV0IM+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vy11e6Jx9oE18r3ZgPME8cQmCMH9xMUN1ypiM8pr6r8=;
 b=hqYSCPZGyIZtR2FehwH02jU5NyJesTi/nVK15DDhMQrQEBSZ6o3wQjGIqi8aDBlrb/7IaXwBmAjhBtqckt15STAjYXTV8r1kNSh/4UJubZnMjg9MGKa2aN+Bt1sAEpUTGnyY9+uguIZQDdQmF9XxSmEa5x+VAWFaAl0T+riax+k=
Received: from PH7P220CA0173.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::6)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 04:53:56 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::91) by PH7P220CA0173.outlook.office365.com
 (2603:10b6:510:33b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 04:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:53:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:53:54 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:53:51 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Hansen Dsouza <Hansen.Dsouza@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 02/16] drm/amd/display: Add a boot option to reduce phy ssc
 for HBR3
Date: Wed, 23 Oct 2024 12:53:22 +0800
Message-ID: <20241023045336.1557443-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: f482061f-a0f3-4524-b84d-08dcf31eb32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nDjaBKliqn5PSkw58iNp1AbIIzqnhl5PCqheogkF1XbGMfN8uB1f8RhUNg/2?=
 =?us-ascii?Q?XrOhCGIVVIJRgRYm1Z+JJWzL2Qt/kVHYlad4iKD35fYWP8uhun79momkX1la?=
 =?us-ascii?Q?+u3kzIUr9wcPu5q3h/bi8tWH+u8M5f59wp5f1nTKALCicUoZEQxMA8tncQMn?=
 =?us-ascii?Q?DZ4fZVmVAjojpV/BL3VKb1v4/yBlAADHS7GyX58+QGCACOqJEXwZx4GJUGHs?=
 =?us-ascii?Q?F9gt12O1bWJPNBMqpQgHx7Z6oHYZHhumaRMT7ofYyOdYPhuVBmy3LyKvB58M?=
 =?us-ascii?Q?bQemS2CE0Hk1i3u/UAXV5ykKn4iGnMqV/zpVHmOx4bOD7lNB5Gydl88MAWZ/?=
 =?us-ascii?Q?4aLQ9njlxIfLU0rS7iDQjBcM4bbZCUDbLrT3MFmL8gyrwW+5MKm4jQrBxqop?=
 =?us-ascii?Q?95KNRHBX7MzBoK1baU40VtvwZ1EvXlTxRhvCLAZygYLO+zb32EF1QEGAitNJ?=
 =?us-ascii?Q?Td/agCFDV9S4DAeIuvPF6E5qSGqU+1N9dMH2+vqzSw5a7K8IRAISFDwml+lf?=
 =?us-ascii?Q?4aiSLJ7FQUoCVAkZ+e/r5FLRcZfDgULC2GrdZfp04Qhgxa311PVXqvmXOu7e?=
 =?us-ascii?Q?cH08I855p7jPcotFBom19/Hw/p/gyvyjBPV8ZlSN0zkABMmmxt072aIs8Om5?=
 =?us-ascii?Q?h5FboqcifjHaosmqjTBziQnWgV2+drmgLumWkoeDH5maDjdtOfpCmtSMbEFa?=
 =?us-ascii?Q?jlNfXTqdNt9xas7eSdRpl8V8qt2P8DJt43Tis0uf8dJTTBn/LIhfxkwuPAXY?=
 =?us-ascii?Q?ShBTLFMSIXkdT4BP/dSdjteF2GV4epfsg/IavV4hfyFkdTDT/9ntiWKSX2zg?=
 =?us-ascii?Q?ApFprW8+4CWnzkAG4cwUXFMnPmrSK7+F+22/gZO63WcpLRIX8WHz27bHUrh2?=
 =?us-ascii?Q?tUSAFVeQM1uHbZHf5sMfL6dnnBcnuAur/mlDAxrzB5HQIdIUUlBMVNpy0gJF?=
 =?us-ascii?Q?Ofa3tpBycHnjTuKG8jDGujOfDcWGwS+GQRVExnMW+fN4cCn7QcFtLcvZTz92?=
 =?us-ascii?Q?DEVqFWc4JsWB1Cp8ujex9fHUFeo1Y3IFYB4UxOhJ8Qo+nN+6Dyql7TV97FQT?=
 =?us-ascii?Q?P5nQJnF1zXSRpw/gT8ZJ0s0pKhuf6Tgzdc/Z6FNvNLj99mmuodVeAHqpveEW?=
 =?us-ascii?Q?TM4z51pVeiHynuXJHVeZvwYsLhlq8dvkpr7Vo8p2obfZsH6dU2t1XwMppURy?=
 =?us-ascii?Q?iU6wQAjAb7Cvg4B6PN+wxj4mwzjnKIY7g+/rw1TPioPso5L8gjT55EUWqqDf?=
 =?us-ascii?Q?WzvWRPValt+7z/ixURcg11ij+bqsRJiIrrOtCqVgPvvRspzZgXrdqBWWS73e?=
 =?us-ascii?Q?5yEEpI43fHUuWco9tM4O5CBhsCfQChDsLj2Q43UN5tULSjMVBe+CKGHIGzYl?=
 =?us-ascii?Q?rY9fSIGuL2wVIo0XP4IeLFa+C+mq2pVIMDIm/jyN7a1YiuA65g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:53:55.8735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f482061f-a0f3-4524-b84d-08dcf31eb32d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818
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

From: Hansen Dsouza <Hansen.Dsouza@amd.com>

[Why]
Spread on DPREFCLK by 0.3 percent can have a negative effect on sink
when PHY SSC is also spread by 0.3 percent
[How]
Add boot option for DMU to lower PHY SSC

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       | 1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 3 ++-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index ff27229cc3a4..b353c4ceb60d 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -301,6 +301,7 @@ struct dmub_srv_hw_params {
 	bool disallow_phy_access;
 	bool disable_sldo_opt;
 	bool enable_non_transparent_setconfig;
+	bool lower_hbr3_phy_ssc;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 6edd3d34c7b5..6d96a840d24d 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -694,7 +694,8 @@ union dmub_fw_boot_options {
 		uint32_t ips_disable: 3; /* options to disable ips support*/
 		uint32_t ips_sequential_ono: 1; /**< 1 to enable sequential ONO IPS sequence */
 		uint32_t disable_sldo_opt: 1; /**< 1 to disable SLDO optimizations */
-		uint32_t reserved : 7; /**< reserved */
+		uint32_t lower_hbr3_phy_ssc: 1; /**< 1 to lower hbr3 phy ssc to 0.125 percent */
+		uint32_t reserved : 6; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 2ccad79053c5..3be315f1a443 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -426,6 +426,7 @@ void dmub_dcn35_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	boot_options.bits.ips_sequential_ono = params->ips_sequential_ono;
 	boot_options.bits.disable_sldo_opt = params->disable_sldo_opt;
 	boot_options.bits.enable_non_transparent_setconfig = params->enable_non_transparent_setconfig;
+	boot_options.bits.lower_hbr3_phy_ssc = params->lower_hbr3_phy_ssc;
 
 	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
 }
-- 
2.34.1

