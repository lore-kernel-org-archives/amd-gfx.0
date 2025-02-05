Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C71CC02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 18:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90B5510E384;
	Wed,  5 Feb 2025 18:39:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qr7trSIk";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C3FB10E384
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 18:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HePYv2aSOwVRwS9Lk4R/HLwHIodigeXB35wuomjGXOxVziOTpITLYSt8i4LndagghZMYwVWDU27Tyqb4BiJSgvr0apvpRuIDA+3ONxVGs4HnjhKWIXaQlGeuJUqwjAUKk5KUSkIgwWpPDH5z/4kpOHdm8xtBwfmeFl/0fN4Ic7Fm0+NnKD1o/M+Wzd6131OJdkC4TCGJzYqKPpRtT8r0R0ZebTUx3frOzHABU9mdo3YJ1Fk4IMVkVAwDK0rByicBW5aPv4yi4+G+GWcDNCSEVe4CzzF/vIJOhoeHEMT6QQHks3p8io1p7pLUdyXLYoCdRoPhh0AeIxIZdtQwddiK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKssQNOge97VlCYazqTpso55F6Q0aVl1JvFTSrCu5mM=;
 b=EqM/1vuLzX/Zdsog2Go1fL6roONyLgHbBQxzDcqMlyl+0rtw1D6sqRZHscaVOXQWvUu/aAwNIBFez+0r/om4qDBYL8ZU+OI4T2Jb1sguLBR8C/DAHkVKObQSeq6SjOMMsnni2lnd3uZwTOXM7uEVxE0XSlcNjrXAg78N9bveKRckvjpm3FVwm3veZ/tSefQKCTYXbycsTPq93gchUbZ1ss2RI6HCH/C1E0H+/KuXgn4YTNnVRde1xtJXeAsheaFDkBi9HkNcgUWk5PQ5FeqRFFSMIpH46REztLRJZLI90brNt3+UGdNJEbsXCsMh2Y9O2Qq4tmGtg+p8c5msAobkmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKssQNOge97VlCYazqTpso55F6Q0aVl1JvFTSrCu5mM=;
 b=qr7trSIkVNxDTx+/NCDEBtFP6was8QkkCvRioBMyU8WaJ2TgT8btO8K5u0+oUaKK8qsxnZrNVQ6z8NiEFnY5XVf0emDYwxswMbstUpWRf5tZ090BZRuX6JAKJDLQjdAxlddMK92ROdtkprZMIg68PiGYg7lIH5S6cuVVfdm9Uj0=
Received: from BYAPR05CA0089.namprd05.prod.outlook.com (2603:10b6:a03:e0::30)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Wed, 5 Feb
 2025 18:38:04 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:a03:e0:cafe::d2) by BYAPR05CA0089.outlook.office365.com
 (2603:10b6:a03:e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 18:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.2 via Frontend Transport; Wed, 5 Feb 2025 18:38:03 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:38:02 -0600
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd/include : MES v11 and v12 API header update
Date: Wed, 5 Feb 2025 13:37:38 -0500
Message-ID: <20250205183738.103990-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 68574043-339b-4e79-020e-08dd461439bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FNBfOz56ftTX1SKi6am/6vPp5Q1qbtH0fVa9nIZmxmoIHMaGsOD42u3V5+xY?=
 =?us-ascii?Q?YyIK+HgGwdayoxsLeODKW/sERTSihOJTNIca3GwbQIFRuWSjB2H4dPJQtxUa?=
 =?us-ascii?Q?dnuoQut0PqWoBDAzfb2ZWFpF8Hh2LUlZgjPN2yEuRR2bAt0WnALBezXVBAlO?=
 =?us-ascii?Q?8EUbt2QSZcn4s7ISMOgJqGHh2hVMcodxVP+PhekCWqpL7GIfYdyuHLX1xbE0?=
 =?us-ascii?Q?P3AlWL24Eorl6yO5SDOAcwp/9GNT7SZbBV7OfTFu4FgVormnDEYuugf6iuGA?=
 =?us-ascii?Q?Bd27zlxh7DSyC0dO42a/Krc7cHnfD1XABaR6rf61c4qkbpgNDVNOvvp+xW6v?=
 =?us-ascii?Q?JB7aPWaGT5kK9bkgdgSZirXDGW4bNESzxO3stVdPg22W0NP+K1ybBp8fUCdZ?=
 =?us-ascii?Q?SveOxiV4+8RzpLawUWEepidA6YrZA0A0NyBEHkvDqf6Q+HHDfq2VdKyqV8k8?=
 =?us-ascii?Q?U+f1wcXDEpo0ujmNeLs+h9fLVvwtx8FCmk1vDOutADu0T5Ql6PNiJzllggw/?=
 =?us-ascii?Q?vW7EZ21Dfvsn36zwhVyPsTbgIaRSubx0tjPIXlbA2vctqIwmaj7AzyW29uJX?=
 =?us-ascii?Q?R3jf+ICKNSZ4My0dnuu/IHif3wyQLtxWlripssRnK7dFDNSuZdQZufxmPyVb?=
 =?us-ascii?Q?JOmI4gYB7Mf8QrVUdDynkNuLr9uJE4AhQ/f0gP3YkBFNh4sVD9wSztuXsLP4?=
 =?us-ascii?Q?+O14/MsCTHt3sMAhRd2mz4rUpdbs1Jg9+lZPQTNiTwRppNM9OvgbN2fMfdw8?=
 =?us-ascii?Q?s81tXPDJmFsSFbh0i8VYGbXSu5cuVUdzZ2qhnuDFn2nDCRVqk7PEzNRSKzEn?=
 =?us-ascii?Q?89iX2HShgiZOqrLj/x/b5bW1S9GwBq0bsIA5Pv0H86B9GEBBNfis/Yfdsh7J?=
 =?us-ascii?Q?HiWOZAmbAAKAJxRrDLtnjsm60uMDOQuiPg6Osq6v5rquBvPkkdXthzgQ/crL?=
 =?us-ascii?Q?jbHHS1aWnPwurdyOivGDj9mFQvR8/2Z40J+RA+W46lGa191M0VssoRtJIwx8?=
 =?us-ascii?Q?TBo+kAijh6MrVjZmz9zm+l+HRm3OScbc4HtOWWvPbrg6EaoN8x3oHrpdhNgB?=
 =?us-ascii?Q?SE5wRTHE/XLpZPWwwlp9t957Lv/48od2JvllcKqXQPt7Iq9e+dcTCXnCVFXX?=
 =?us-ascii?Q?CJ2UrgGyOI+gE0ETXskx5rEYVw6kMjGEWNRnyjKIqAHkxvLRqUfFThbbGzn2?=
 =?us-ascii?Q?+do6NzdEZKhafPv/wTGXdSinbUwTrs4lWHErD9eE/vkz/+uW6dZuSdX55plo?=
 =?us-ascii?Q?QNNUxG2v/jwjeF00xCuDqn/MAKmUYrz6t30Mti3+0Q+d4fn6lTdXQJOKdSvU?=
 =?us-ascii?Q?6ezRxMvyvl0VGh+h4xiVJS6DrT27s+lcQLleyobmZIR5h38Qeo5/jqqWYwgS?=
 =?us-ascii?Q?dJacozb5vwGgFX3nHymGab5JI5Uaslk2nj0RBB4E22D1sjGeV668omx4zqW7?=
 =?us-ascii?Q?viSbJ8UwpoB/NKXXC3oTItvqT9LBh5rnZdU6DxIfp/J1Tw8pgnEWyCgoYrsC?=
 =?us-ascii?Q?Th0YqzoyyMSeDM0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:38:03.6738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68574043-339b-4e79-020e-08dd461439bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
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

MES requires driver set cleaner_shader_fence_mc_addr
for cleaner shader support.

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 3 ++-
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index eb46cb10c24d..6b5cd347dfb5 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -266,7 +266,8 @@ union MESAPI_SET_HW_RESOURCES_1 {
 		};
 		uint64_t							mes_info_ctx_mc_addr;
 		uint32_t							mes_info_ctx_size;
-		uint32_t							mes_kiq_unmap_timeout; // unit is 100ms
+		uint64_t							reserved;
+		uint64_t							cleaner_shader_fence_mc_addr;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index c9b2ca5cf75f..1938150a1943 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -278,6 +278,8 @@ union MESAPI_SET_HW_RESOURCES_1 {
 		uint32_t                            mes_debug_ctx_size;
 		/* unit is 100ms */
 		uint32_t                            mes_kiq_unmap_timeout;
+		uint64_t                            reserved;
+		uint64_t                            cleaner_shader_fence_mc_addr;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
-- 
2.34.1

