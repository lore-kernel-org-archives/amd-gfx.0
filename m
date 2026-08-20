Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD1BC5DF85
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 04:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAD5B10E12E;
	Thu, 20 Aug 2026 04:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ksXsrb7r";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56D4410E12E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 04:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5XGroysCHfbTSmeBuiLo/TBMqB5OyvnZIFML87M2yeQcl6tVf1FMR3PDWnzRUkzt4DMyZbEHvOZN8WkkAduF8XPAJlaR5j5RCoKpXaCDVWmJQQIW9OWnZ3PVCEZuq52aWvvKkVw2F8sjwwPCcWEGEym+RrpXMiNt0nUgZeZY7X1TpKE0E6axRJRfnadskSJtPh2W834qNk/Pi2he3JPiu4V3Ac6fV/vXHuaa2eytOL8buFywYM5JuF4mDPUQHi2+VIkivCX9Uqsqh37Kldf68R70XJLvcf8DFjjlWL7TsYdgeCVBFVp2yRTLI+v5rdGDEa6bpQEdrkG2AOPuLB3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uw/pKbKESaspmEaUWH74Tn6T21s68lXL1awBzymGus=;
 b=xlDjqCDU776Cr+b9fEdVUW6R6XsLjFcelJCbg418BEvbuKunOFBu1TzlDJGve1cy/fAQkdtFLRW/F79t1jM/OrKEHKW6NLVScgvzwxAh+UQqRJ5m99mgfff0QznLWO4hpDMK3FyYV55qgFGC8tw+RFUcSx8WkoYNn3rAJejOq2g/Rk1uAuY+6GGdTltnRFNqNXLSYMfbulTO2rbyufpA1F167lk7xJop43J3h+N9Yt4sLwmG0l0xJegWtymbUGo+NO6EGjVFv+qD698lH3l+yq1g2gfenUtXHTItGPfa5cAPD77Zczym0znZvliKOE0vuAwRLvXrVDU13R43/2zO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uw/pKbKESaspmEaUWH74Tn6T21s68lXL1awBzymGus=;
 b=ksXsrb7r4Yo8eQBUreVAU853hcc97W4BeQEzz/mvbA+ZV3RwYXJYJZe0HWwCIUeQB/7McRUX0nUcicGTvaSIHDJ+fZnVo3cJ4lF+KGsdKujYZwWrl7t9RP3Z96b4iSgl1GivAhMqrz8cLB2mSS3MWs83U2hgo2mLj9CTr+EI39s=
Received: from BN9PR03CA0363.namprd03.prod.outlook.com (2603:10b6:408:f7::8)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 04:55:13 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:f7:cafe::7d) by BN9PR03CA0363.outlook.office365.com
 (2603:10b6:408:f7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 04:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 04:55:12 +0000
Received: from amd-X570.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 23:55:10 -0500
From: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <sukhatri@amd.com>, Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_device padding
 for 32bit compile
Date: Thu, 20 Aug 2026 10:24:38 +0530
Message-ID: <20260820045438.3974-1-yogesh.mohanmarimuthu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 104f1bfa-f586-4f3c-b04b-08defe7737d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|56012099006|3023799007|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: O9FQyh50h0pYwQHD21mWep84nrQoMPbhmLtuQSB0JngdYii+327UfSm6dppgnFqdBmFynaqnxPYBJGnZ6NPdamJKJWNw455+10gQvFQAN5dFlTtTf9u8FJ0lfN+ZqXfb48wBX23Q20CBfAYDXdkdlPH4YITMeecWW5P1NQRFTnKFF6lCFW1p2Q9Ow+wW06L91Mrfecl4lxmf0557/Fs4CaBnGor6KQR/z+sw1OIB9U2kPHx6vwgcpwhwMsud3RbA2YJQJ06lgC+VYm+Jwjb3TfUn4RGNZK0pCONK+uJtuSPnAAaFqXC9AZVx6bJ1UXNDJg3814TJ+tdt7B/R+1eYAvnFjV83n/1Y3GoRCyNkq2dxReKsp63wOG5pRjoWHZMEMsDt4pzQrzFxttdG936HdB1PFaS0WiHcLKz8DE0DuEWRIBs9V93KgK2QWx0VbQeoZexCdX3hCJfeKxodKJRgv0voCnkqEp/sDqtJ5dp/oo9zfjTjSezBLpQNb4xfjRacdcGivlN+l2dqeqo4gPCO0o/kv6tFDYZmPIyxrZgEss6QsGMIFGC7/+uf92RQ/RwoYtjbkrBOjz55KvudlGCItBZPP7venKFos/R13L7ZXSgSDWWtQ1TwF8d6mC2iSMEHEeb420sBCHkHAbAdwPDSx2Rccz9piuT4LPif1QXh5mhzxyHhjchO7VnWLL9nAE/KJzMHayJ88xF1Z58GWLH6jA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(3023799007)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OFEelrkr8JojD06evm6NZOgGuyyCGCUBXrj3Cgyy2V3zbCOtRT8cL0iOlaNLcPQWuGWlkKNLkjpKOti5VNNCiJr+7OBsr+gbQGYyBdNmq54GbwTHAW3OfYkUW9chkEMsNMS2duaDJ7dIJ5xQ+9S1ABlcsQfgJeQZAtEkLtfK8MqwQA3xEBekHHoytgitwRIr5LSdkcgPGh3dyVoXoFuz3QWLDNAmLSCOKTStOf2aeMwtrmKje39nD/rG8VtcUZNfz0ftmsemnPIslXdVagu28eani8lNwVWp3v9ruvmJ74pxDPSEtfx+kEB6ZKZm0CK4CGUyfSudWqSwTADD7hLtYT9NFmVzSfZZ3eymcnXN73Tj4Vld95HMe12GTbclWm8eJWlcQqh85hxKUZ1FGlJdJQ8AUph+Um+d791AAFKRapOzoO3b9o0ugkd4cjB7U4dQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 04:55:12.3940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 104f1bfa-f586-4f3c-b04b-08defe7737d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
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

need to pad before __u64 tcc_disabled_mask variable.

Signed-off-by: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 0a113529b..5beef3eaa 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1517,6 +1517,7 @@ struct drm_amdgpu_info_device {
 	__u64 high_va_max;
 	/* gfx10 pa_sc_tile_steering_override */
 	__u32 pa_sc_tile_steering_override;
+	__u32 pad;
 	/* disabled TCCs */
 	__u64 tcc_disabled_mask;
 	__u64 min_engine_clock;
@@ -1541,7 +1542,6 @@ struct drm_amdgpu_info_device {
 	__u32 csa_alignment;
 	/* Userq IP mask (1 << AMDGPU_HW_IP_*) */
 	__u32 userq_ip_mask;
-	__u32 pad;
 };
 
 struct drm_amdgpu_info_hw_ip {
-- 
2.43.0

