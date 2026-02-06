Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86739EE20A0
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ADF810E6F1;
	Fri,  6 Feb 2026 13:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="emmTSK2l";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E8EC10E6FA
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzoF7zbZmRX0yl/0oy3Af/Kaiii+6LJ40ISXPs6Vdg0reE3uy9Gh4NA2AL3TsWzYYHZgO9Fig3ybt8gq1qn5CAMNMfxr8Mr4CJmiPvMh2NLVkE7Ovmzg4jVPyulEdz1cyQqQdbKqkWHl8QT51+8iTR7yhKbAKtb7zOJQL1kaSe3iGZqBZtudf67L0VQz+PXEZ+e9qTiC2v4iRHDdj3nuA8uzh7eFVATnHAgdkHPNAIPNDPxbEZ01JZNs8vYLtUIONzskidL64XZJz1iwt28aN21Jmhy5qX3zMl8hVvlrn8x7vzJROlPXy+0ppax7vGzznzalhD+XbW1UqxGWCjB9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywNCvmPvFlJAhEs6D0pY+4wNZwfcvZAK+KlOlV/A5Q8=;
 b=fTQ+KVMxxM5U3Pal7nJjBL6wGlqbeMgP1Rqpruw1vn5IOFKBlsVUD2FYLxdTLZFmy9tOeRLPgsOHfSyW0mYUDPrmRA3Je75wrxES1xhWEnD5WDsawDZQ5+61ODTdGmjJAB7BYtXHV/XoABtf/YrcoadInYyi4uXle1I0j0RtUTZ+2Ytb41YYI9VK12eEIFaJzsXZgZloROAWxQyQMml54WgqTSXwjSL3UMybLojymm9GlrfAjOg6aqNXHNdX2AXLjBEsA4aiMHcYdq+433p+fmfeOj4n+PBiQCx0oMWgIwxxMwLyykhgXEVQFzDIVtqufGYX0jV19XAMr+aydU3GcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywNCvmPvFlJAhEs6D0pY+4wNZwfcvZAK+KlOlV/A5Q8=;
 b=emmTSK2lrJfK1d0QG0pAvegcDTznF3Rlbdc9Oi3peUZwqfn1GZUGXF8PvKzPfD+kPATElSR/d5QgVTUofvlBOSXB2kMNjWUzgsM4+Td0gVf7me4TzqL43M27pFssbYKCnxjhuDA18XZbFVNWPyMZoxRf8F/S2Y0PY5Lflm6ECi8=
Received: from SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::16)
 by CH1PPFDB1826343.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::628) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 13:36:25 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::4b) by SN7P222CA0016.outlook.office365.com
 (2603:10b6:806:124::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 13:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 13:36:25 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 07:36:23 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 02/11] drm/amd/swsmu: Add new param regs for SMU15
Date: Fri, 6 Feb 2026 13:35:58 +0000
Message-ID: <20260206133607.91047-2-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
References: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|CH1PPFDB1826343:EE_
X-MS-Office365-Filtering-Correlation-Id: 6adf3060-52c2-4c7b-5123-08de6584b95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZXVVwBOJYkqBMINy4ase2P8yLkzHYiZucbB0pwr6FUcdKQS1++TSzwNTCOh5?=
 =?us-ascii?Q?Ubz+uP81s33mCMej7jRWC3fVkzYbnypYdt+C0kXYU0h+8a0x5VYiB5UMGrIf?=
 =?us-ascii?Q?8aivm6FWXvDhPfRaUbWzPHDYOyvDLKGl3CxIuNaXejSRrMN4MPl3EQcL9k+T?=
 =?us-ascii?Q?sEznbvrWXhMFKgdbhTmY+cugckPQQk6e/23d8C74TIjtvz87akPgQT2av5T8?=
 =?us-ascii?Q?YjifgwrYjwsW4fOWlSKNbodnNkxHcWms65zqDucOgoT/eOfS1YNVGPQyIhTY?=
 =?us-ascii?Q?HrfEHZdmYekLQmGWhkoL/PahoTArKhnPNj3GfH10i2E/GJK/XUBL2m6ATsjL?=
 =?us-ascii?Q?XhKefK5oiLP5/rE/A+paIedFrQHsJ1+0UJogmiwT+ZiJz8xlOSDvVzSe/3q2?=
 =?us-ascii?Q?HZImEHXOife7fJeQNffgV28u8hubv7HZS5FNAMxGWBDdB8c7tlXveOFJHsWA?=
 =?us-ascii?Q?PQnuG0cZTH9x1LLD8QTn0x6+GKhLvg2PaR34QcTOZxeJc7pDPpt5wOSikG4q?=
 =?us-ascii?Q?ntlv0kRwANjIyXlUtRiMvz5EDI7fG6mxJV8iHb9pveloflDHShgjzfUp6iBG?=
 =?us-ascii?Q?UxhvThn/tM2poNFuFpLXuf4qyI9AF7rtU1L5dHsAnnXjxBX8/FT8t1BVKmF2?=
 =?us-ascii?Q?SNkBv9GrIyqATz7tbPEv+mrzwZp5kEn1CyOgnOJtlVvO1CwHyrOOrb9fbh+v?=
 =?us-ascii?Q?RIhPY3R8rZVHH30MZ2JAi2RbpxT46PrwVraK0H2SOX+oLeI5a5jxYkIoZjF8?=
 =?us-ascii?Q?fjgmY6nG6LY2xw7/gFdUEZkI1uxiu6S66DqmdbNoTuTMkqJZa24vAG44I2sM?=
 =?us-ascii?Q?oWlEMV0aFuVdwBSzQi1KLc+qnL4og+OEN+JtztrTG8YaULo75A7jvXOUGDNB?=
 =?us-ascii?Q?qc4ev+uPCodyEl+tXWVOK7/ty3s/B/YW9YLJiukRSVjW7YteoTOt42W+Jlr2?=
 =?us-ascii?Q?TzNOickl/zzqeJAfa/alhTKKpRgeOM3jCYoisbzXQP5Z3DePymZZELG5Ibff?=
 =?us-ascii?Q?N2DUwvZvXFx8fhvpEcG6+XANRdZ5oihV3no0HYTWADoMs4cH+Px8+ihxUh8v?=
 =?us-ascii?Q?tiwknaMNxeggRx/cEpSS55t4NtvBqjnX6pDuI+NivSdPrVkXFTfMWvaALlbQ?=
 =?us-ascii?Q?KRpdBBB0JdrMlkHv3GYHFuyl3Z7T2PXli+QXM6zGanh+Ju1zLIRVrgbMzKIM?=
 =?us-ascii?Q?e73wdMPHQuFzIcuprzpxAoiot5Mgu6+5KfiqBuDo9bJskxBKZWxJrqu88N5a?=
 =?us-ascii?Q?dHwYEkhVl7Amg6zpOVvaa5giwKeeKymHlaveCtSjLKGKG5ODkB2fcIyDefq7?=
 =?us-ascii?Q?qx1wOAH9BBFsjWlWgc49Y2DztAxzGYwW+7JNRZ1mkJ5wdarCtDvX7KWrjbbK?=
 =?us-ascii?Q?w53WKSPAiLLcmANXYuhwh+2T+NGq0TqDEju5IzalFdX6BENlxzMHRQbtUBdf?=
 =?us-ascii?Q?rh1DY7SsFp4YeI6TL1FFw0tiZv0RcyBj6SAJtUqfS/febfc7CIv/uUTaVj/k?=
 =?us-ascii?Q?sX3pXkFZPGCzxak9WQZWqfmN1bIkqHfldiiQmcj8+2MZGWSWxogqN+G+QUtZ?=
 =?us-ascii?Q?o6IUgwqmhjpSld9UZhHib0VnM8FKuYfWGZKvkRQeIjSNsuJu9+juZaycjPc9?=
 =?us-ascii?Q?69iLXJKY9Quvf+39oye452wmkD1Cm452lFIOwx+Fae1X2R0p7xArvib+4NWQ?=
 =?us-ascii?Q?gP2Y5A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D4yfKgJl4OV9AhYusx6YegPlvrkHo9NE73D5FV4WY+K++jKmreUq8iJFIrebQuEwmxnn/beUXaxeHaXZnwNtOwdRzTnZzpaJy/LWi2oXAm65xJyI9EkKbq57oGII/w/MKQBFgt7+9mppJmu1TR/6/ivKBhAEDp33AwnNo6Tnt7SET/TtJ/RGF7P9/l3YEH2iNxzuaPdU32Q2+PvDUjLYfU3AfjSY+Uk4+KGxrWaTNsQrP7JPuO2iBkxW1LWZT5Wb6v+cqFpitEE2ql5DfSz314kcyq838db/qjjhNPA0izwzsXJHT8Zi6pEparRSZAJ1LmY/mqmsY6CTGM10WjpWyfKZO9/8g1WmZ3Lmt4BPX8DP6NepNedfIj3O8uq6w71rUtRlI6or67vGH73TzRwhTe8hn/pvSt2oFtgIjT3l3fCWh+cE0BeCKu5MGWlDTzIS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:36:25.2388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adf3060-52c2-4c7b-5123-08de6584b95b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDB1826343
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

Some SMU messages have changed to multi reg read/write
Initialize during smu_early_init

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index c3f22844ba2f..d58b0bc2bf78 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -52,6 +52,12 @@
 #define mmMP1_SMN_C2PMSG_32			0x0060
 #define mmMP1_SMN_C2PMSG_32_BASE_IDX		    1
 
+#define mmMP1_SMN_C2PMSG_33                   0x0061
+#define mmMP1_SMN_C2PMSG_33_BASE_IDX                  1
+
+#define mmMP1_SMN_C2PMSG_34                   0x0062
+#define mmMP1_SMN_C2PMSG_34_BASE_IDX                  1
+
 /* MALLPowerController message arguments (Defines for the Cache mode control) */
 #define SMU_MALL_PMFW_CONTROL 0
 #define SMU_MALL_DRIVER_CONTROL 1
@@ -1347,7 +1353,9 @@ static void smu_v15_0_0_init_msg_ctl(struct smu_context *smu)
 	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_30);
 	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_31);
 	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_32);
-	ctl->config.num_arg_regs = 1;
+	ctl->config.arg_regs[1] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_33);
+	ctl->config.arg_regs[2] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_34);
+	ctl->config.num_arg_regs = 3;
 	ctl->ops = &smu_msg_v1_ops;
 	ctl->default_timeout = adev->usec_timeout * 20;
 	ctl->message_map = smu_v15_0_0_message_map;
-- 
2.43.0

