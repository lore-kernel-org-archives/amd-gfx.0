Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56B2CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFF610F606;
	Tue, 13 Oct 2026 08:25:34 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013003.outbound.protection.outlook.com
 [40.93.196.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A5710F5F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3Yw3sfEDt2Iebrx19DEee69o+7nuHiW/rawz4pEcNFpUhj3ZRgoKums2A6HMq8m8AjB6T/wq4rH+57LA6HLCNInIpQZVVHXH5y9NhwxWYk0IIIUrm9K/Bf+aGeSPDSDBcw1TziusWJ1xqCvovVnqD1l8BEjhdy0FHPYx7YtugvZlDBsVF6e/Af1bJ3XNCjIIxBmMjDNgmCwTYxCr0MtfMk/YoZ+mtsR4IQOVFcpXjhSsISYOWIxsNVgrJ0jI/gN5jy/VIa52TrLeZN7A6ScG6E+utIRayT8TlDoYiPaq8Kqr5vSboJud8NFjhnrja6/EMWg92ezgkeNbxLpeJGUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHCNvFLfZprm+M8+4AlYnpGgMfsbbIKMozVYDaVmRIg=;
 b=IwTNRD2An2mHAzP+qizJ1yUuaOUqOu/b+4FV2Hd3p5bjIGfrCxtJ3XCoINIUrSxkofg1BVkeq2aExi5titJZIBLrvcUEG1m08oBjxWx3N7F1U8H+FicF35U4Yq/an7/rGY0bacWijzF/yafinCWTPVACvh7ABmfpXZp58qMoftUgV0Hqugv7HqoiD/tYgwX8A4cq6+jvkmM4Hd0Zcv9D8zbF1ePMAh8huJF2CrNiYAZRuEDdC2ld6PQZCvGohqph2fWruFFt531SHWkFoAXARZfwUJkC/g4CAUal4MNCrqw2H58CEBuEv5c9v5tB2VeHi+liGsJbyHQojIOLnOrq1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHCNvFLfZprm+M8+4AlYnpGgMfsbbIKMozVYDaVmRIg=;
 b=kJQgYF39PyuuFkGMXeeYj+Vt6oJ85BgLGcpUSOgEnhFwEFukZFsny0NM6NOMJowNqgS2IFpUuKUeSRKhkwJRBuRUG2EtQ1pTugfZsO2Km+sAmu3uH9XNsQw753Tq+Tn+N18FSh7uz/Hrckl2F2QCHdO+raSOUOujATW7JDnTdpA=
Received: from DS7PR05CA0015.namprd05.prod.outlook.com (2603:10b6:5:3b9::20)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Tue, 13 Oct
 2026 08:25:22 +0000
Received: from DS1PEPF00053451.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::5f) by DS7PR05CA0015.outlook.office365.com
 (2603:10b6:5:3b9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 08:25:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00053451.mail.protection.outlook.com (10.167.23.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:25:22 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:25:08 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 4/9] drm/amdgpu/userq: complete hung queue fences after
 successful removal
Date: Tue, 13 Oct 2026 16:24:52 +0800
Message-ID: <20261013082457.2492273-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013082457.2492273-1-Prike.Liang@amd.com>
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053451:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d87193-1a12-4a8b-3b62-08df2903863e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|261009223027099003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5mhHN1/oXLI1MX99JvnzUxhXsmTeiCUiPd3OeS4GHyMTNlB6LwsLzvY1QfbVlZqtDdoJDfcTm4TJCe9lCjzaZ3kpW/HMLvwt9ZrEbt9286vy8ZEpVy41WQx69rIYm42AfBRIFF9IrqI7PJLG0n0Ld22sYDfoMA6iVxu3nxo8eGpd8V6DTWmBBSluH94/hQ2w7G46NiV2yPn3vhD6562aMuHKrDyCzSxd4vW9SxynVKSEJRFIbOfY7cFnKgSIrGwyhgEqb15uf6WtY78NBrfVRCprudbrh6aI6QwaPxDLUJJk1DsD1USh/XPbVFITLOXcIJk9zeP/yMqK1XWIvPdhPscU1U3ARw+0ic4y4J3We8rku4NCw/9g1FxK68ARzqvVw06E+Xix6mlEsK8rn+rsZ67M7KWSLlZfb+4uJZmSjE5l9OPRQXa74CjQpu0StOKipIybAbvEOZG2iRqoppLZHZ9p9Jfey5jJeqPkJ+yqKOcSYv0UkOKx7dbjy4sMa3LpaAxDej9NtrvnjYnB/HpyJZ6IHNUE2jwSSoMoZk/pLJHlSbJIAnXRwg2/TLtGijpzIINT0hnDFkB/SgaTwlaNdpiEwHz6/mlyzcS4Oqfl7Xd2tRSfWQUa91ir1HBU13S4yLZjR7U1jgcVRb3vu0VAKpMXYmN5z5rTUgbJwr7SRuXsBs9PIlMN0d+i+RfuB9Sy+xAz+9Lpiedz36REAdwb8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(261009223027099003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7t0FySyKz8bCWdGmGmKGOYLZO7L2d+T+NRI5651xw7OM661kc2qs3FuaLIEOc+Nl/OmX4XZBJioOsk8EzUYqEgUmQkxm7LwrPPd+VO/5CQwYXXmC9r/iwO5dy3/MsN7B9aaWZ4Ilqk49lURE42pioDHBAXNyKynbO3xF9QI6IWvxYymurQfYMI7J9zcGPmzkkdxGUkVyQ/bKG8/0gERYFX5jEs7OVRVfvEoWAQpoPPpefuAcRoqVapdoqRZNtttS8OM8zu0NVfkyX68/cl7+f93KeO54Q2e2+8mTSSLtNK6gSYLI9qAMPM3iIn0nyg5DSJORdD6fen2m74fNgyAoPpxpi+gqs6btluAW0KzqWmc179l7evF2ATV4ZBF41s72n6NMAaP9SwCdjYnoAN5+nJY+X1TeushdNyjHbhXmidy9de7MFMSLgMtHMz6YpRE1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:25:22.2913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d87193-1a12-4a8b-3b62-08df2903863e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053451.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
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

Only mark an additional MES queue as hung and complete its fences after
both hardware reset and removal succeed. A failed operation leaves its
dependencies pending for device recovery; it does not prove DMA stopped.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index fe49aa4dc5ff..3b973ea0c24a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -282,7 +282,6 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
 			if (uq == guilty_uq)
 				continue;
 			if (uq->doorbell_index == db) {
-				uq->state = AMDGPU_USERQ_STATE_HUNG;
 				if (use_mmio)
 					r = amdgpu_mes_reset_queue_mmio(adev, queue_type, 0, 1, pipe, queue, 0);
 				else
@@ -292,8 +291,10 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
 				r = mes_userq_unmap(uq);
 				if (r)
 					return r;
+				trace_amdgpu_userq_state_changed(uq, AMDGPU_USERQ_STATE_HUNG);
+				uq->state = AMDGPU_USERQ_STATE_HUNG;
 				amdgpu_userq_fence_driver_force_completion(uq);
-				break;
+				return 0;
 			}
 		}
 	}
-- 
2.34.1

