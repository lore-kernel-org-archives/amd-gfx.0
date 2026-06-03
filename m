Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3B3CD6E6D
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 534941120D4;
	Wed,  3 Jun 2026 16:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UDTughfO";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA6F1120D3
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bltBtcxgXRO3XO4SwjWEPCGWS1vDZy+/kNZPo+ZHEPF5HuPa2YGYxNLLJotG8MkEGHV72c9x6MK0Pcer/u/GBWpiqPNct9B4/XUvlyAZfl8nDLGccjyPLvoWVY/kjHeckXb7Omu71KsKCx0OXvW2wxlhWmW8M+ZEQ3EO+vxvIcDrg7N4cmb9JFYUdSb3rBwykTKWg5pDOG9gqb7JIUWqvmFRS5pJqlO7965XvIN8xUhZ5GJfHkTiZuAv1bsqLn4KrQdKRbQF9oRHkxGAxJ1l1URgIVarkh4SK6NVlSFOkUyAYsHwK4F5H2JORb3BcCUHrz7gsUzpktvRKm4ku80G8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeZfs99XjwTyM4ho/lPfmAuGiM2JTukKyUxbin3otUo=;
 b=A/vdIHXCOCoUkdpN3mNfQY7bd+718o7Oea/86yEcLB0R4IQXmz/3LbmD7ECHlZ3V1nCbue7lCFICcq8QtEkJ4mH/91YjxMQ12aoS29guJcV6goJRts9RgCPyPzF+BC/8Cg882eUMY6wTn2mIaDwkrfUTiCvex3/hCxhnhQadLwaX3lHybPtIGokjK6TegMHKzyrbGesGXF8Yrjw6ueVDb6JFl2YLktYo5bZ+SfyOgCCkKn3Boafl350B3XGtJvmbbBCh/Tlw0QLjO8IGocSJJcNFYdI/4s2U39x5feXzMmL/okm3JwufiBCnBykQfzUTiAP21f6nVMeCFA9tIbBq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeZfs99XjwTyM4ho/lPfmAuGiM2JTukKyUxbin3otUo=;
 b=UDTughfOaRZMIB+UjGQ7U2rRxCTTkaLxfWoWM0t2TPxV8fIi/91W0Kktw6D/ExL5xglj0prdTnLjVhrhKVXOZEygutG0nseIbFtRscTSqYM0f4euIT4BBMqyIyr2w/xZk8tBu8ihsCBzkw9KrmJUfc8SAZwneRPlc0ssNYdB5iw=
Received: from BN9PR03CA0311.namprd03.prod.outlook.com (2603:10b6:408:112::16)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:35:18 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::27) by BN9PR03CA0311.outlook.office365.com
 (2603:10b6:408:112::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:35:18 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:35:16 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 07/11] drm/amdgpu: Document WAIT_EVENT condition semantics
Date: Wed, 3 Jun 2026 22:04:46 +0530
Message-ID: <20260603163450.2678374-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
References: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2e8257-0109-4ca0-57bb-08dec18e1940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: yZY08AVMB8ZkS3CYCNCBjmikq03KYy9GIoSggZQVgnTH+zq9jk1VaqRDGhk7fUs4as7eRgveb9wquwlWf7aB9vGx9lEN1k9C5sBX2iUxoEGkFR5oATjEm9ki1YZrc9pnPqKYnlLgha4nt/TIIyVnLk7suw2Iib7Et275d0Wc4CH9gyJ7G1WpEZhQteHyeQ03gdqyVMRiFu5UW/dnSpBxWxoMRhPmNWTnFactSV5gjyhztlHS/nV3b4hQ5wksST8ds9hPqWOIeoonbsoalisduCg85L2Va6YXH/TRqNthTKaTkt06GC5rcPiLIZQYE4vS9eDra3Ld2nzQDNGJjh0idqpT/I4xcnYJVZciC+NJh7K/F7LGNXF+oMSnxgtM6mprcoZY4alztQuEr5Bh8k6/+NMdT1yTXVQADPOfttBMduYHnu8WSeo4k2/qgxr+mWoZZXt5mJV0/va9grbjgO3KmK3ve6zmopN6FYA6XaWsaKuP0/yEJzOBMZtabuxt2904z5Z5XbLAOsduUWsXQ6SYrs1/jqCGZVXENHBEoI18X7j9ac0S+QPNuOoeTG9P1uHS67ZPPu+ZlOAcPRB35b+KRrq2jU/Q2uN4hTY4ydszp7liiGb3gWnM9AY4PaDm9cP/KobQKkfBnq4X3gBjbL5sGjXwaDMTpnupklMnNi6lLGpqobKAeEftPftuCEoX/Xl0OEq9NI2hG9CTwCBe108D3SjiV0/7+QsEiea/o1TZ7bY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cJQvHIT9Kbjzaefnw1lyk8I/RGt59HNS69ZVaaWrgn/+sDC9qSz6dT/65vZG/+Qbo/seInO+6sov1hRfiYQMNtITZgJ2ar362e5XHqlajLEQbRfLCCMPBx1UUek9pzLH5yPBPIFXCsJHfUNvjeDdSaOXKgZlWIrlNKmZE0xTv4PIMOiF3HAPsWz+twMZRwsc0jRlNvYsRVyr0RlB2uGsy/BhKH+k3DRCoXyakUL8VyB/q0wLhJuP70VtcC17bHSl/g/M46JcatZvi1PpdxkJO9bF8dFpWdCvp18WXFG9cFwtw2b+0uIiu04+y+YcuDIDQMtpF4JQ65UwaDcv9iE7XEcsN7sBUcSVkQOww2pDu8eHackSrQUZbhIvu85ozH8VfrYgJ0Zzh8z4VGCNNi10MohMbnZcADPxbsmlaQAZFMs9AZWv+XFmm9FrMKMrA/bq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:35:18.6009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2e8257-0109-4ca0-57bb-08dec18e1940
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893
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

Document the optional condition semantics of WAIT_EVENT.

When condition fields are provided, WAIT_EVENT completes only when both:
- a matching event record exists, and
- the userspace condition passes

Matching records are consumed only on successful completion.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
index 67de685647c7..3cccc652360f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
@@ -45,6 +45,16 @@ struct amdgpu_wait_event_mgr {
 	bool dead;
 };
 
+/*
+ * WAIT_EVENT semantics:
+ *
+ * - WAIT_EVENT matches pending records by event type and optional queue id.
+ * - If cond_op is DRM_AMDGPU_WAIT_COND_NONE, a matching record completes
+ *   the wait immediately.
+ * - If cond_op is set, WAIT_EVENT completes only when both the record
+ *   match and the userspace memory condition pass.
+ * - Matching records are consumed only on successful completion.
+ */
 void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr);
 void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr);
 
-- 
2.34.1

