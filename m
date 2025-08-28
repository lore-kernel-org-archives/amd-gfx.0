Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DCDCA0FF9
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D4F10E93E;
	Thu, 28 Aug 2025 09:15:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YiC474BD";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DDDA10E93B
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0lp5a6bBLOrLaTzGFNetrTH3dCBuzVQtxYPj8Qp8Oxl6iS0YhThmhl0dUrf5aoRxxra7WfTQM4tzDRyOf04XAGACwgOn7KRrzKpgzMFCQ7HpKUVlF5nk98KGhWDNmht9Bd/BQc8YQqqKGzWE1J26Hg5m2zT27txQYIt/frEoXQV/bFea5jNCZ1Bm5UUEdDVo6H4Dg/L72CmwudjA1VQf5AfHaApqN4jbYOMtgTl8/w99sjKS5FOTSwoXi2OfQ+p8/AQILB8V3QHzLHIDpaXqWD0t5HGB1pVUGIdbRhzxq/TrwpGTNRZzZexG3fXWNs88UDZ6qtjcO2w1mal/p+w5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYuz1zu6i38UVe88fGfQ4Da0z/ZuUNq2enAyT8Zv4mg=;
 b=psXX/q8TekKe1fLe9T+Z380EiT2C9gx1qmuBJXuCi8ifhGWT7vr+GlUvVeNFsh2slHdvqq8Ms4zFMAkKNfnt92HgMJnmrL4vuIggDnPL4FWAk+E1VRzKWR0IbJY1zEW2b8M1W09nNcBQcu/krgLLt1lZEKSejiCrt+05Q/K+fU/1OSPpR8hToLTKniVPzklCX1NrU+86e4fARTrkiiLboyDi4eu0lajypLz6Ks3yiFWpnw+veYif7oI9ARamB0qsZZcKrJ6IC1YKpGyNUVl3h9yzmibb3gbW/c4KEM0lXV/JH6NHvURgpYCDCmSBm9pNwxPX3PRKqqwrzVMXwfbWoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYuz1zu6i38UVe88fGfQ4Da0z/ZuUNq2enAyT8Zv4mg=;
 b=YiC474BDYA7woMhua+Jc/MbB3ccAi2ycDR0qtOQ3dasOvjbZ+0xrICCEGW0WtgnFrWPcgUzcPa0gi625JsNmLPO4wObGqEEmic62gjAU+5zYuGp5momeqvCueVFW6NLfg9xdf4ZzduiHTP2DWw79keX6NM3ntQOAU2V888xsnLI=
Received: from CH5PR03CA0017.namprd03.prod.outlook.com (2603:10b6:610:1f1::12)
 by IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 09:15:35 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::40) by CH5PR03CA0017.outlook.office365.com
 (2603:10b6:610:1f1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.18 via Frontend Transport; Thu,
 28 Aug 2025 09:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:15:35 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Aug 2025 01:45:54 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 2/9] drm/ttm: Bump TTM_NUM_MEM_TYPES to 9 (Prep for
 AMDGPU_PL_MMIO_REMAP)
Date: Thu, 28 Aug 2025 12:15:23 +0530
Message-ID: <20250828064530.3948378-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
References: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 44165aa1-c3bd-4a35-5f13-08dde6137256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkxaUW5NUDRLWlo3ZkdXeEZ6bGxIZDZWSU5PT1hIenVYMmlVN1hZV01YRlUv?=
 =?utf-8?B?TzN5OWFJWmxsSFFkVmF1NTRoejRYbldXMGxIWWFnZDFOSGVhb21HNzVlWGdR?=
 =?utf-8?B?R3Fza0QyYUlRd1dvdE1ZKytNWGlJTzNkUEU0RlhTZmFUNVQxc2NCeDMxL05x?=
 =?utf-8?B?Zlc1R3hZQlNFT2t0cjhPZ1ZjR1pMamtnTUFrZUlERmRSZkFqdlphZkRHQUhR?=
 =?utf-8?B?cjVXQVdzUmFxSTFROTJDM1ZBTlEyVHR4Y2RCUU5yMnJGLzFQMnJ3c05HMU1x?=
 =?utf-8?B?bmRXcHBoeFp3c1lOaHB1eFhHamJwQUloaDVNTmI1OHVQOXNCTW5aMW55eDdK?=
 =?utf-8?B?Q3NSUHk4VFN0RHM3V2ZhNTQ1b29BYjV6L2prYnVmbWRGQXZHcjB4a0wyWUVB?=
 =?utf-8?B?SU4wQVo3UFlLMngvcHhKR2pTdFVUZlJrWnIya2Znd3RiNytZcDN0MkNJdWEv?=
 =?utf-8?B?bnptSkYzb0tQU1AwRnR3VituanNPSTIzb2lxaUpiMk9uZTJ2YnRacm9NQ0VF?=
 =?utf-8?B?U3NsdjhlKzh4eFlxdEdnTlFCWFJEciswSWltN2t1aENYU2V1Ykt6TnQwL0xT?=
 =?utf-8?B?OWJGelBOTW9pV2dkM0VHRWpxTThjUkZaY3UzaVM5Ukp3bWkwQlQ3ZVhId3ps?=
 =?utf-8?B?N2s2MjR5eTgxQWZpRW9BM2dGSVZSRUlkQktBTzBBZXVmNkt5Vis1NDRDbk1v?=
 =?utf-8?B?aVJDVTdVdUpqNFpkcENHRU1kcU8wTlRYSE05Q1NLbERvbG1qZ0xlQXQvY3B4?=
 =?utf-8?B?RGtDQjF2OGh2Tlh0Q3RLQzhrdUozSnc1VDhIYStVS3lSanBVZjY3UDNxRjRz?=
 =?utf-8?B?UkZVR1VBUENMcHp4MlliOERZYWZJMlU0b2pHRTUvWDAvVC94T1BrRXNyQmpE?=
 =?utf-8?B?V25uOEZyZ3V3Z3lOdVVvUUJRNVJJRlN4aisvY3d4MFJuL1NsL05qNGgrMDZG?=
 =?utf-8?B?ajE5MDFRNE5SS0VJdzA0OWRPU2F6Q0x6R2ZUMVJFakd4L3lrT3RJbytjSk8r?=
 =?utf-8?B?TnBUOEU0c0JTNys4a0NXYytiSmoyZUM3MTc4TnZiM3dQN2hGMThncG1qbTQ2?=
 =?utf-8?B?eFlzdElCR01YcWpNV0d0bkhiSDFYeTNOQTJhci9nK09WeTJ4TWc0bHJ0UVNU?=
 =?utf-8?B?VnVVbjVEUkFlRW1JTFNhWWJ0TGtZS1FRbDlmOEdnalhiOGFqSERSZS9wMjBk?=
 =?utf-8?B?b0dLeDhwUEpCaUdkeE9CKzJmUVZWdUQrVUsvTXI5KzY3S0Jmc1J2Zmh5aHRU?=
 =?utf-8?B?UW11OG5sbkNzSVcwaERDRG5XS0s2QTVNd3RCTFNWMzE5TnpKTzlYWDRldTc5?=
 =?utf-8?B?cjNUUUdQQUpsY3ZVWXI1NFhKSWI5dlNROElOTEhuem1QVWU3Qmo3alpiMHZI?=
 =?utf-8?B?SytBWUZHdjM4SWxZQ3UwU0xSK1FXNlpLMmF2NEZGTFl4dENNdzdTZTRNMytO?=
 =?utf-8?B?RXloQm9wVU9EU041aTAxSzlINEJxWDB2SmFHWUNHbVFuUGFhRHduQVB0dDhu?=
 =?utf-8?B?cFYxbG9tYWhHdzcvTHpON3Fqc1ZaY3FReVg2NXNGUzlCOFFWYmZhdUIxSnBM?=
 =?utf-8?B?QVFpR3VkKzNEditWUE1YTFNWM1gvNk56WEk1d21DYU1UcFVxR0lpSlFZSnNG?=
 =?utf-8?B?elQ4QTBuVEJPdHF1dGRHOEZJcDV2LzdXOFZzalRwZkJxdXNTejU2NkpqQjRY?=
 =?utf-8?B?NlIrQ3JnRk54YnN5b0dYMG1pRXBFTkZ0c2JDWTBXN0gySVVNMjd5M0JNOG1p?=
 =?utf-8?B?b29XU2pPWVBsNUljd1R5NWJnV25Oc0FtWjFPOHdFVnNUd2QwMUZTZWd3ZTJU?=
 =?utf-8?B?NkVOS2N1U0hSM2xhdjl4ZDlCT29qVDZ1Wi9mcFhqbit2UzFiNks2djdncGxN?=
 =?utf-8?B?S01FTy9UZENubktnZWtSY0g4U2x0Vzk2aTZvd0t6ZUhzNXh1WHl0bWR1Szla?=
 =?utf-8?B?QlJ2UzNURlBsK2Q5c0lLR1FkT2tMSVp3cWtaRlJpN0I1NzlXOE9YYlgvOVQz?=
 =?utf-8?B?OFE2eVlaWGNSNFJMT29NSEhkdzNTMXBRYUF6OUVCYW1mWmwwRkFjVGtNeXIw?=
 =?utf-8?Q?09eIJZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:15:35.2902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44165aa1-c3bd-4a35-5f13-08dde6137256
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421
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

Increase TTM_NUM_MEM_TYPES from 8 to 9 to accommodate the upcoming
AMDGPU_PL_MMIO_REMAP placement.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 include/drm/ttm/ttm_resource.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index e52bba15012f..f49daa504c36 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -36,7 +36,7 @@
 #include <drm/ttm/ttm_kmap_iter.h>
 
 #define TTM_MAX_BO_PRIORITY	4U
-#define TTM_NUM_MEM_TYPES 8
+#define TTM_NUM_MEM_TYPES 9
 
 struct dmem_cgroup_device;
 struct ttm_device;
-- 
2.34.1

