Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B28C25B7E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC66E10E269;
	Fri, 31 May 2024 16:08:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3vPjnDTB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A70610E190
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDp0OxO3Q8+L8bnZCi+JQxk/u08YT02H6iD+S0tgfuVDLUo+eFcs68V5uvWU/pCrfH1jmAkNK/eQJ8KMsMVntOYh/jRr1OjGn+sr+8ODYB/m8GpsyuByyhtWZnGNoc7RZOVdP3gDzqe5UnzJwp6Yo0wqkIwFb1D4wmLCnjm8rWue17eTtWUj64ipNRXp65VtkW3Q7NDuW1oJfglxWnmx9mmkV0meIcRDvfKHpF3sODKaTk/d3oTLTwsKLf2F93XteNrgJjcU2kLVIIovAUuGCkkc0aMMcZ3cbGCETEJEmavTXJacb4cXS7ils4Yi9bCUENIox3GIVGHG7lg5iaoxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHjCPIkdRfNBJx4S942bhcFbV8SpBLIgckJByEI/C5Q=;
 b=eCmxvQVX159WoOOhDW+olI2n4r5iKaIlVJPPyoVHtt0JbvMYyXZk26G5AAS+zGH2FpPpsdfCaReFi5idAAnxXm81DskWZkAiek1xKeMfrhWaZZdMVAhVu6nPXGcanQ8eHTAgjxGnNoraRlWF4xRgY6kYU+wed7XAmNy/yjaPWzSFChidIDMaHQsTtI2uaxl7iub2bm4Xtq7JDjWK7a4Dk5nOyn+51ygOXoYC2LMetazzqPSHZLOEwy9/36xiR+Z9ch1OjVt0Lic4skhZg87yz09kQBPOgCbeRFv2g5yZn16+Btdfc3rtV6MY+zWMrpqHpMpbK7rg3aw6S0siwHf2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHjCPIkdRfNBJx4S942bhcFbV8SpBLIgckJByEI/C5Q=;
 b=3vPjnDTB5DSkjNX9KHxa+UgXoEFNPzGVseMY9jitbFCUJ0rXAt657mZcv/18zKPxTOhNf47PgPm7Rj21l6fn6FIS4XYTMk9vgaC9rJ65HWGHVEUEVPb5KY0r0FnOwn7eOWs8mh4RV+6f/FxgYv/LNaO4aJP6ILKfwZE3T3kiFS0=
Received: from MW4PR03CA0047.namprd03.prod.outlook.com (2603:10b6:303:8e::22)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 16:07:55 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::19) by MW4PR03CA0047.outlook.office365.com
 (2603:10b6:303:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Fri, 31 May 2024 16:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7656.0 via Frontend Transport; Fri, 31 May 2024 16:07:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:07:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: update gc_12_0_0 headers
Date: Fri, 31 May 2024 12:07:32 -0400
Message-ID: <20240531160735.3547360-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531160735.3547360-1-alexander.deucher@amd.com>
References: <20240531160735.3547360-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: b611b0c7-4788-4a45-7e6f-08dc818bd51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ZsOvGwzzo/pt9drXRzNVKM5bPo+RdVBETGUH5EHwN6/I62OW6M5Sp35v9uI?=
 =?us-ascii?Q?v0UhOE/jM9mx4jvyxGTBV3LeVq67OZheKUV1nf+NtUJM0xnqErzfuTJfYU+9?=
 =?us-ascii?Q?qelWRGohgyL8sn4CXO5cZmMQmqFiYW0Mn4nk1vLGZsk2OlXjco5k+8hUcnb2?=
 =?us-ascii?Q?qG96XR+yyDrwYynKGmOfHVftLg/W/nuZXrkV5fyEU5brKXCXhWNRXMW2/Jiu?=
 =?us-ascii?Q?s2LjKKrNAQsaxlX6Re6LpX+XPJLCrHfLOWofJ/tHlEkvpq2ZsisOncoPqrgV?=
 =?us-ascii?Q?XLFg/n+du/jCAfe8BhkZZhCPn5g9C5u5sdtl1F4ocAPNHckdAUXuIDRyiQxe?=
 =?us-ascii?Q?jRQQIYupC8fnshC67fifewwXP3kliOBxv/AmWRgFpzW69AZu+NdSM8KhA6lF?=
 =?us-ascii?Q?3UDqffqa2hTneR73ZZL/ZcLGTTbd3cPksT5ETW5b27C0O0/wQYNtc0JJIEl+?=
 =?us-ascii?Q?U/yf5HncaHPoFTCOR6ZVhCcm3FEVdg9RiFRfsOhyWhN7EYxSQDQzjutuy6FK?=
 =?us-ascii?Q?NTcb6b11n/wVKuZ5aP3UJNynTyhAX8mQr5Ty6lZqBJA6HO6sccB9oQJpLpTF?=
 =?us-ascii?Q?t3+t7k6C30A0/nsWDvjoDosRP4+rBVVoxBeCTAZyGcTHpUaw9oxHYRHRcrD8?=
 =?us-ascii?Q?TNWDDYPnuCHpGktZ1QG9KIsZ7R8uKRKYNYJ9oChyws6Jja2ps9HOBaHIF0Fn?=
 =?us-ascii?Q?yg88yqzGG1Z7YKd5nPHOMucpPd0xVKuedCrfPrP7ouSPeZfXxwRKEjT6W2Kv?=
 =?us-ascii?Q?gVDcjqGUxj2pBT538rn/tHVtEDDM59taCLGOYzweit6ZMxnkjWd8G0k1zLf/?=
 =?us-ascii?Q?ojI67V52E2Rg929vpYWasHJoRSqqjvb9zth8YnAXjF4brWQHgR3Z5xNibSyq?=
 =?us-ascii?Q?murTMuBXLA9zNKuiWoH5YoCeIKipY0tiQw4Fx22V+dz3XtYmyNFv5SWyxu0q?=
 =?us-ascii?Q?SHbQ5CcMmDt9h5Q0SyU2uagYDkb3EezU82CtrBnUSH2OEwuW0nKYbEyYNoZg?=
 =?us-ascii?Q?Kvgp66tAkPH16GmMxZqZqZv+w1tcEICZXC7xfQXqXVDfCxyvqkfPRVGGBFZw?=
 =?us-ascii?Q?2+DQ3p6jbHDdeuMMSUVULSw1EfRQXOXJmHgsFypGEa2QlioJdRqP/Ss6k0Up?=
 =?us-ascii?Q?u5NEZfbv6LMPOYrvftX2mShRmwOZHtPLWMQ1PivdZoi/saDuJpGeeU2I71ww?=
 =?us-ascii?Q?yTzJkohUhoz5qjPM3u3jjObKOfc+u9stKMS3ee078umYJC+q9mV0eiDdO/kp?=
 =?us-ascii?Q?pmHYPucR1C3domZ8b9Q+vX0NhsuwVGeNr2TnmfBJlNSj13HsNDQ1gjqy9POC?=
 =?us-ascii?Q?ecjLyw9katFjoB8A+DrV9SS4dkChriuMWCuoRg2C87G+QYHdkT7yL5jUd2/i?=
 =?us-ascii?Q?x5wqeEd1Zt406veYz+mX5U1xC5SX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:07:55.4187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b611b0c7-4788-4a45-7e6f-08dc818bd51e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461
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

Add some additional registers.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/asic_reg/gc/gc_12_0_0_offset.h    |  8 ++
 .../include/asic_reg/gc/gc_12_0_0_sh_mask.h   | 98 +++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_0_0_offset.h
index 186fa7675c4d..645d10bfbc79 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_0_0_offset.h
@@ -85,6 +85,8 @@
 #define regSDMA0_ATOMIC_PREOP_LO_BASE_IDX                                                               0
 #define regSDMA0_ATOMIC_PREOP_HI                                                                        0x0033
 #define regSDMA0_ATOMIC_PREOP_HI_BASE_IDX                                                               0
+#define regSDMA0_DCC_CNTL                                                                               0x0034
+#define regSDMA0_DCC_CNTL_BASE_IDX                                                                      0
 #define regSDMA0_UTCL1_CNTL                                                                             0x0035
 #define regSDMA0_UTCL1_CNTL_BASE_IDX                                                                    0
 #define regSDMA0_UTCL1_WATERMK                                                                          0x0036
@@ -1065,6 +1067,8 @@
 #define regSDMA1_ATOMIC_PREOP_LO_BASE_IDX                                                               0
 #define regSDMA1_ATOMIC_PREOP_HI                                                                        0x0633
 #define regSDMA1_ATOMIC_PREOP_HI_BASE_IDX                                                               0
+#define regSDMA1_DCC_CNTL                                                                               0x0634
+#define regSDMA1_DCC_CNTL_BASE_IDX                                                                      0
 #define regSDMA1_UTCL1_CNTL                                                                             0x0635
 #define regSDMA1_UTCL1_CNTL_BASE_IDX                                                                    0
 #define regSDMA1_UTCL1_WATERMK                                                                          0x0636
@@ -5523,6 +5527,10 @@
 #define regCHC_CTRL_BASE_IDX                                                                            1
 #define regCHC_STATUS                                                                                   0x2dc1
 #define regCHC_STATUS_BASE_IDX                                                                          1
+#define regCHC_CTRL2                                                                                    0x2dc2
+#define regCHC_CTRL2_BASE_IDX                                                                           1
+#define regCHC_STATUS2                                                                                  0x2dc3
+#define regCHC_STATUS2_BASE_IDX                                                                         1
 
 
 // addressBlock: gc_gfx_cpwd_cpwd_gl2dec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_0_0_sh_mask.h
index 7c6568824693..c24e8ff6b3af 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_0_0_sh_mask.h
@@ -330,6 +330,41 @@
 //SDMA0_ATOMIC_PREOP_HI
 #define SDMA0_ATOMIC_PREOP_HI__DATA__SHIFT                                                                    0x0
 #define SDMA0_ATOMIC_PREOP_HI__DATA_MASK                                                                      0xFFFFFFFFL
+//SDMA0_DCC_CNTL
+#define SDMA0_DCC_CNTL__DCC_FORCE_BYPASS__SHIFT                                                               0x0
+#define SDMA0_DCC_CNTL__DCC_RD_NOPTE_OVERRIDE_0__SHIFT                                                        0x1
+#define SDMA0_DCC_CNTL__DCC_RD_NOPTE_COMP_EN_0__SHIFT                                                         0x2
+#define SDMA0_DCC_CNTL__DCC_WR_NOPTE_OVERRIDE_0__SHIFT                                                        0x3
+#define SDMA0_DCC_CNTL__DCC_WR_NOPTE_COMP_EN_0__SHIFT                                                         0x4
+#define SDMA0_DCC_CNTL__DCC_RD_NOPTE_OVERRIDE_1__SHIFT                                                        0x5
+#define SDMA0_DCC_CNTL__DCC_RD_NOPTE_COMP_EN_1__SHIFT                                                         0x6
+#define SDMA0_DCC_CNTL__DCC_WR_NOPTE_OVERRIDE_1__SHIFT                                                        0x7
+#define SDMA0_DCC_CNTL__DCC_WR_NOPTE_COMP_EN_1__SHIFT                                                         0x8
+#define SDMA0_DCC_CNTL__DCC_RD_NOPTE_OVERRIDE_2__SHIFT                                                        0x9
+#define SDMA0_DCC_CNTL__DCC_RD_NOPTE_COMP_EN_2__SHIFT                                                         0xa
+#define SDMA0_DCC_CNTL__DCC_WR_NOPTE_OVERRIDE_2__SHIFT                                                        0xb
+#define SDMA0_DCC_CNTL__DCC_WR_NOPTE_COMP_EN_2__SHIFT                                                         0xc
+#define SDMA0_DCC_CNTL__DCC_RD_NOPTE_OVERRIDE_3__SHIFT                                                        0xd
+#define SDMA0_DCC_CNTL__DCC_RD_NOPTE_COMP_EN_3__SHIFT                                                         0xe
+#define SDMA0_DCC_CNTL__DCC_WR_NOPTE_OVERRIDE_3__SHIFT                                                        0xf
+#define SDMA0_DCC_CNTL__DCC_WR_NOPTE_COMP_EN_3__SHIFT                                                         0x10
+#define SDMA0_DCC_CNTL__DCC_FORCE_BYPASS_MASK                                                                 0x00000001L
+#define SDMA0_DCC_CNTL__DCC_RD_NOPTE_OVERRIDE_0_MASK                                                          0x00000002L
+#define SDMA0_DCC_CNTL__DCC_RD_NOPTE_COMP_EN_0_MASK                                                           0x00000004L
+#define SDMA0_DCC_CNTL__DCC_WR_NOPTE_OVERRIDE_0_MASK                                                          0x00000008L
+#define SDMA0_DCC_CNTL__DCC_WR_NOPTE_COMP_EN_0_MASK                                                           0x00000010L
+#define SDMA0_DCC_CNTL__DCC_RD_NOPTE_OVERRIDE_1_MASK                                                          0x00000020L
+#define SDMA0_DCC_CNTL__DCC_RD_NOPTE_COMP_EN_1_MASK                                                           0x00000040L
+#define SDMA0_DCC_CNTL__DCC_WR_NOPTE_OVERRIDE_1_MASK                                                          0x00000080L
+#define SDMA0_DCC_CNTL__DCC_WR_NOPTE_COMP_EN_1_MASK                                                           0x00000100L
+#define SDMA0_DCC_CNTL__DCC_RD_NOPTE_OVERRIDE_2_MASK                                                          0x00000200L
+#define SDMA0_DCC_CNTL__DCC_RD_NOPTE_COMP_EN_2_MASK                                                           0x00000400L
+#define SDMA0_DCC_CNTL__DCC_WR_NOPTE_OVERRIDE_2_MASK                                                          0x00000800L
+#define SDMA0_DCC_CNTL__DCC_WR_NOPTE_COMP_EN_2_MASK                                                           0x00001000L
+#define SDMA0_DCC_CNTL__DCC_RD_NOPTE_OVERRIDE_3_MASK                                                          0x00002000L
+#define SDMA0_DCC_CNTL__DCC_RD_NOPTE_COMP_EN_3_MASK                                                           0x00004000L
+#define SDMA0_DCC_CNTL__DCC_WR_NOPTE_OVERRIDE_3_MASK                                                          0x00008000L
+#define SDMA0_DCC_CNTL__DCC_WR_NOPTE_COMP_EN_3_MASK                                                           0x00010000L
 //SDMA0_UTCL1_CNTL
 #define SDMA0_UTCL1_CNTL__REDO_DELAY__SHIFT                                                                   0x0
 #define SDMA0_UTCL1_CNTL__PAGE_WAIT_DELAY__SHIFT                                                              0x5
@@ -3204,6 +3239,41 @@
 //SDMA1_ATOMIC_PREOP_HI
 #define SDMA1_ATOMIC_PREOP_HI__DATA__SHIFT                                                                    0x0
 #define SDMA1_ATOMIC_PREOP_HI__DATA_MASK                                                                      0xFFFFFFFFL
+//SDMA1_DCC_CNTL
+#define SDMA1_DCC_CNTL__DCC_FORCE_BYPASS__SHIFT                                                               0x0
+#define SDMA1_DCC_CNTL__DCC_RD_NOPTE_OVERRIDE_0__SHIFT                                                        0x1
+#define SDMA1_DCC_CNTL__DCC_RD_NOPTE_COMP_EN_0__SHIFT                                                         0x2
+#define SDMA1_DCC_CNTL__DCC_WR_NOPTE_OVERRIDE_0__SHIFT                                                        0x3
+#define SDMA1_DCC_CNTL__DCC_WR_NOPTE_COMP_EN_0__SHIFT                                                         0x4
+#define SDMA1_DCC_CNTL__DCC_RD_NOPTE_OVERRIDE_1__SHIFT                                                        0x5
+#define SDMA1_DCC_CNTL__DCC_RD_NOPTE_COMP_EN_1__SHIFT                                                         0x6
+#define SDMA1_DCC_CNTL__DCC_WR_NOPTE_OVERRIDE_1__SHIFT                                                        0x7
+#define SDMA1_DCC_CNTL__DCC_WR_NOPTE_COMP_EN_1__SHIFT                                                         0x8
+#define SDMA1_DCC_CNTL__DCC_RD_NOPTE_OVERRIDE_2__SHIFT                                                        0x9
+#define SDMA1_DCC_CNTL__DCC_RD_NOPTE_COMP_EN_2__SHIFT                                                         0xa
+#define SDMA1_DCC_CNTL__DCC_WR_NOPTE_OVERRIDE_2__SHIFT                                                        0xb
+#define SDMA1_DCC_CNTL__DCC_WR_NOPTE_COMP_EN_2__SHIFT                                                         0xc
+#define SDMA1_DCC_CNTL__DCC_RD_NOPTE_OVERRIDE_3__SHIFT                                                        0xd
+#define SDMA1_DCC_CNTL__DCC_RD_NOPTE_COMP_EN_3__SHIFT                                                         0xe
+#define SDMA1_DCC_CNTL__DCC_WR_NOPTE_OVERRIDE_3__SHIFT                                                        0xf
+#define SDMA1_DCC_CNTL__DCC_WR_NOPTE_COMP_EN_3__SHIFT                                                         0x10
+#define SDMA1_DCC_CNTL__DCC_FORCE_BYPASS_MASK                                                                 0x00000001L
+#define SDMA1_DCC_CNTL__DCC_RD_NOPTE_OVERRIDE_0_MASK                                                          0x00000002L
+#define SDMA1_DCC_CNTL__DCC_RD_NOPTE_COMP_EN_0_MASK                                                           0x00000004L
+#define SDMA1_DCC_CNTL__DCC_WR_NOPTE_OVERRIDE_0_MASK                                                          0x00000008L
+#define SDMA1_DCC_CNTL__DCC_WR_NOPTE_COMP_EN_0_MASK                                                           0x00000010L
+#define SDMA1_DCC_CNTL__DCC_RD_NOPTE_OVERRIDE_1_MASK                                                          0x00000020L
+#define SDMA1_DCC_CNTL__DCC_RD_NOPTE_COMP_EN_1_MASK                                                           0x00000040L
+#define SDMA1_DCC_CNTL__DCC_WR_NOPTE_OVERRIDE_1_MASK                                                          0x00000080L
+#define SDMA1_DCC_CNTL__DCC_WR_NOPTE_COMP_EN_1_MASK                                                           0x00000100L
+#define SDMA1_DCC_CNTL__DCC_RD_NOPTE_OVERRIDE_2_MASK                                                          0x00000200L
+#define SDMA1_DCC_CNTL__DCC_RD_NOPTE_COMP_EN_2_MASK                                                           0x00000400L
+#define SDMA1_DCC_CNTL__DCC_WR_NOPTE_OVERRIDE_2_MASK                                                          0x00000800L
+#define SDMA1_DCC_CNTL__DCC_WR_NOPTE_COMP_EN_2_MASK                                                           0x00001000L
+#define SDMA1_DCC_CNTL__DCC_RD_NOPTE_OVERRIDE_3_MASK                                                          0x00002000L
+#define SDMA1_DCC_CNTL__DCC_RD_NOPTE_COMP_EN_3_MASK                                                           0x00004000L
+#define SDMA1_DCC_CNTL__DCC_WR_NOPTE_OVERRIDE_3_MASK                                                          0x00008000L
+#define SDMA1_DCC_CNTL__DCC_WR_NOPTE_COMP_EN_3_MASK                                                           0x00010000L
 //SDMA1_UTCL1_CNTL
 #define SDMA1_UTCL1_CNTL__REDO_DELAY__SHIFT                                                                   0x0
 #define SDMA1_UTCL1_CNTL__PAGE_WAIT_DELAY__SHIFT                                                              0x5
@@ -17286,6 +17356,34 @@
 #define CHC_STATUS__REQUEST_TRACKER_BUFFER_STALL_MASK                                                         0x00400000L
 #define CHC_STATUS__REQUEST_TRACKER_BUSY_MASK                                                                 0x00800000L
 #define CHC_STATUS__BUFFER_FULL_MASK                                                                          0x01000000L
+//CHC_CTRL2
+#define CHC_CTRL2__DCC_COMP_TO_CONSTANT_EN__SHIFT                                                             0x0
+#define CHC_CTRL2__DCC_COMP_TO_SINGLE_EN__SHIFT                                                               0x1
+#define CHC_CTRL2__DCC_CLEAR_ERRORS__SHIFT                                                                    0x6
+#define CHC_CTRL2__DCC_COMP_TRANSFER_SIZE_ENABLE__SHIFT                                                       0x7
+#define CHC_CTRL2__DCC_COMP_SKIP_LOW_COMP_RATIOS__SHIFT                                                       0xa
+#define CHC_CTRL2__DCC_COMPRESSION_DISABLE__SHIFT                                                             0xb
+#define CHC_CTRL2__DF_COMPRESSION_MODE_OVERRIDE__SHIFT                                                        0xc
+#define CHC_CTRL2__OC_OVERRIDE_UNCOMP_LOGICAL_SIZE_DISABLE__SHIFT                                             0xe
+#define CHC_CTRL2__EA_NACK_DISABLE__SHIFT                                                                     0xf
+#define CHC_CTRL2__DCC_FORCE_BYPASS__SHIFT                                                                    0x10
+#define CHC_CTRL2__DCC_CLEAR_128B_CONSTANT_ENCODE_EN__SHIFT                                                   0x11
+#define CHC_CTRL2__OC_UNCOMP_128B_COMPRESS_EN_DISABLE__SHIFT                                                  0x12
+#define CHC_CTRL2__DCC_COMP_TO_CONSTANT_EN_MASK                                                               0x00000001L
+#define CHC_CTRL2__DCC_COMP_TO_SINGLE_EN_MASK                                                                 0x00000002L
+#define CHC_CTRL2__DCC_CLEAR_ERRORS_MASK                                                                      0x00000040L
+#define CHC_CTRL2__DCC_COMP_TRANSFER_SIZE_ENABLE_MASK                                                         0x00000380L
+#define CHC_CTRL2__DCC_COMP_SKIP_LOW_COMP_RATIOS_MASK                                                         0x00000400L
+#define CHC_CTRL2__DCC_COMPRESSION_DISABLE_MASK                                                               0x00000800L
+#define CHC_CTRL2__DF_COMPRESSION_MODE_OVERRIDE_MASK                                                          0x00003000L
+#define CHC_CTRL2__OC_OVERRIDE_UNCOMP_LOGICAL_SIZE_DISABLE_MASK                                               0x00004000L
+#define CHC_CTRL2__EA_NACK_DISABLE_MASK                                                                       0x00008000L
+#define CHC_CTRL2__DCC_FORCE_BYPASS_MASK                                                                      0x00010000L
+#define CHC_CTRL2__DCC_CLEAR_128B_CONSTANT_ENCODE_EN_MASK                                                     0x00020000L
+#define CHC_CTRL2__OC_UNCOMP_128B_COMPRESS_EN_DISABLE_MASK                                                    0x00040000L
+//CHC_STATUS2
+#define CHC_STATUS2__DCC_OUT_ERROR_CODE__SHIFT                                                                0x0
+#define CHC_STATUS2__DCC_OUT_ERROR_CODE_MASK                                                                  0x00000FFFL
 
 
 // addressBlock: gc_gfx_cpwd_cpwd_gl2dec
-- 
2.45.1

