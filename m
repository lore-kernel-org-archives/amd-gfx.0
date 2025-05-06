Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9148BC3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 15:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D0AD10E6E8;
	Tue,  6 May 2025 15:59:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rFZMw1xs";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E471710E6E8
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 15:59:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8SIWdTOmwOIQXhIsLy71H71VM7jszZGZ1BOMGxrKOKU4jLWff+ZhWB/xdNVD3DEVfK+HIgMJ8qsPYSQmwuVxW3yNDE+oPuoUZsUkM/st22W/78b95lqQyFWqJ72bohuZsAGCB0TM7Ch2JAuBPQr7OyBSOxGLwaVX9Hia8Rn2ebsN5dHG1P3RxvNNfHo7JstKpiJVTUzRQ4CGyzCEMrq/y3GVF7+43OqCsA0/dF/yKO/+5wwd5/YGQ3edc3xM9zldU7sjiEoxxSGmPwE1XYkOKUIOIkxgTahvBRen/iotXVprd/F/hv0SdiIycMbhA7hiqR5q/OVnMGfYPd17SlDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuP67isiUGa/GE9R/mdaSTo5DFA0XkIwI7WG0knCRko=;
 b=ZEowLd7bxHu42yuAOvMT9DSOS5GGwaYmezqFgxSbgR6fjAuMbJJA8oe7jmODzSoBWyw0zE5yFHEVGpIRR6oe+c+lVg8KIWZsvwcOyKbjviwMjAsQAtPZ+38z2KNfp3D3EkYQLgk2wiTX6BBKJKAclfD4CQudcJoeGmhWnHDYB/F2upuQgEJ/9ImDY9yt5l6YgvyMBX+7O5sp6S+/kQymdZP8ukfigISv58GR3HM+Bcj9ksVk48YXfI8IDeU/IybE5/kr+Rw8TgPBLCmQPFP4IY6A+3deaWMsksrOL+F3IY0aF9jcd52L7pv4wsRQUF8SfkGpu1tFOprYAokNMEFDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuP67isiUGa/GE9R/mdaSTo5DFA0XkIwI7WG0knCRko=;
 b=rFZMw1xsbkudwvbnR9cr/Grpw3kTjGzZ64tvoB/tYmeBKUdyfdcDzT82BqJqMHJYop5oU7S9ZJDeq+q+6I2jMkdh10ez/5QXVlWD85QJHrHKxjCm329HZdqPWMifQGPd2zGfYyU8XkPzvqlOybZmqkrvAAsNiXu0McNIV7HBJEI=
Received: from BN9PR03CA0224.namprd03.prod.outlook.com (2603:10b6:408:f8::19)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 15:59:15 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::3c) by BN9PR03CA0224.outlook.office365.com
 (2603:10b6:408:f8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 15:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 15:59:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 10:59:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: add user queue reset source
Date: Tue, 6 May 2025 11:58:53 -0400
Message-ID: <20250506155900.3866874-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce423cc-c1f7-4347-9337-08dd8cb6f33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N056RjNDOWwzcWFpU2hlenBWL2tJNld1bWdUY1l4aEpkYXdxRUhkM3NUdVVX?=
 =?utf-8?B?TEtiRmtacTl3TVZwbTg1T3k1MGNJMzRIM3QwUnRacXBUeXEySTRKaDc3UzBC?=
 =?utf-8?B?ZWtEZHBkMWFCNVlWR05rL3Njb0lmL1grWXMrRkxlbmtWcFVhS3FnZjFLbW9m?=
 =?utf-8?B?aVJEcm5ocUl3VjVpQkdueVh6QUtmVlViSUY2RHVQbnFZam9jUVpwSXVsSmxM?=
 =?utf-8?B?YnhVcDFYY2h4L3B3NDFNQ1RBRFd4RDU0SGd3NncwRmtzeDNidzNpSlhadjVx?=
 =?utf-8?B?cDdXM3lGOUJOYjRPbnZsR0lWamhJYkN1ZThZQzhjejRuUFVDTHBUYUxjSmdl?=
 =?utf-8?B?M09CbVpROWtlMEk3N3l3L2NzZXB0WGVtZGRvaFNjdGl4aGd3cUQzZXk2bkRF?=
 =?utf-8?B?TmcxZnQ2N2lTYjE5NjNtc2dlR0JSdEVGQXRvb0IrSkp5YktVZ29tWHd5Y3JB?=
 =?utf-8?B?U2tKeFBFVUNRbEdWbWluaXNBZHBwZU5wR2xJZlNtV25pYTlJZTVYWkxWZWh5?=
 =?utf-8?B?RnpYOGxVSHFEdGZwVXN3UC9zMlJ5K2d5bnpPY0FPbXhhVE5veUMwZVUwOFVV?=
 =?utf-8?B?bHNQTGNCU3dVSEUxUGZ1cXhDd3c2aUh3NHR1YWRsVWxwN1pLQjl0YVNlNHd0?=
 =?utf-8?B?R29vU0dNRGtxKzBDYlArK2IxTWtBYjhqM2ZYb3BwblRiclJ4TElpbks2bG15?=
 =?utf-8?B?UUtPSXdNZWFKbHBtTnlhVDlPYW8rb2c1U3hCR1d5Y3crR1VjUUNUOGZFR0Zh?=
 =?utf-8?B?ZWRKSDRZNjJacmZ0QUFOaXovOGFTQk5Sa0ErV2NENmZNN0J0emE3YlRnVXRQ?=
 =?utf-8?B?aEltd1VuSENsblZmZUwvSTFJUlBtSjJ4emN1eFNMNGNsRWMzMWsxNlM2bEF3?=
 =?utf-8?B?OUZCMm9XYXpJZnpkMkFUZUpsRlRPV2VTZUNKak1iTVlQTUxhTXZvUCsvMTE5?=
 =?utf-8?B?ZFFZSWUwVk5pNG1MVHExSXEzS2FvYkZFc1R0OWZodTBsS2I3ZzI5UnRGcmxi?=
 =?utf-8?B?N0ZQWDkxaHg0U3MxNnd4Y1AzdVg2Ymx1V3JBNHlzZDdmTzE0dUE2bEJBUnlO?=
 =?utf-8?B?NHEvV2w3UTVZMlRHOHZRZlFXdHR1NHFsbGEwcEdSWXUxUVdwWGpKUHFmZ1lq?=
 =?utf-8?B?enl6cWZOVmVnMEZqdmNnM0t2bHhOZXNTL3FYakplTTJnMTBvakVVRm0zZHVT?=
 =?utf-8?B?V3ZnL1IrRzg1S3ByNVJobEF0YW9MWEVLWFJYSGd4c0d2YkFidUpLZkNHUEhO?=
 =?utf-8?B?b3FtT2F2bnlGQWhzdkJRZWt6NWd0NXJQcGdiRm5BQmY3ZzNVZnBCOHhJMTdJ?=
 =?utf-8?B?ZkxmeE8xcm5oSlZTT3A5S1h3cm5sVThrRElpd091T2s3eXUrbldHVTlYU2pa?=
 =?utf-8?B?K2trUFRhWHZ6d3lnVW9Sd2ppU0s4c1UyK2w1T28rZWJsTU8wSTdkOVk3dFBR?=
 =?utf-8?B?ZTB5TXQ0Rkx4SXlzRlZ5ZHFHY3B2UG9GN3pCNHA4d29zRlJ1YnNLbndsRFlR?=
 =?utf-8?B?TkFmSnFHWmYrU3VVVGFObmU2M3NmMmZ6aTNySnRPdkNGdW84Q2ZSSi9CUHgz?=
 =?utf-8?B?cExIcEx6VXRHWVljTHozUWFLdTNHd3JzVHJaYnpLSCtuUWtIanUraWxMRnY3?=
 =?utf-8?B?ZEFpMnptbGcrYmkxRk5SSldUMitXRDFqMWphNUlQL2trcDZkZlBOTEVLQm8r?=
 =?utf-8?B?NFJYL2plNG41UFdVMmtCSjl0cFp3SmJaR1UwMTBac2xwYllPVzBLVWMvZzZL?=
 =?utf-8?B?U1l5dFpCWXFDTXlFbXBDSnI5Wi9Ub05WQTdjQTdJbjRMME05QnFwOFVyWG5T?=
 =?utf-8?B?dHBLTENlMTVVQ25jTjFndzFmMFpRTkFqelZzRFlQS0tsZm9PdC9pbGRrTWpy?=
 =?utf-8?B?VitYNElta3JHWkdrYnlhV0RDVStnMk1XT3dDM3Q4TmdiYzRpQzI1RE1leXdt?=
 =?utf-8?B?ZXdobXQxSE5pV2V3YlF5S3dpYjJ4ZVNPdlpOL1hLRXEyRE02Z1ZHQ2ZrSFlU?=
 =?utf-8?B?QW9CeHJJWkpwWVF6OTU2Zm9UTHpISUYrWm9DQkFSS2Q3eVRZdisrNjFvZEV5?=
 =?utf-8?Q?pWtsBn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:59:14.8807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce423cc-c1f7-4347-9337-08dd8cb6f33c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128
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

Track resets from user queues.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dabfbdf6f1ce6..28c4ad62f50e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -340,6 +340,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 	case AMDGPU_RESET_SRC_USER:
 		strscpy(buf, "user trigger", len);
 		break;
+	case AMDGPU_RESET_SRC_USERQ:
+		strscpy(buf, "user queue trigger", len);
+		break;
 	default:
 		strscpy(buf, "unknown", len);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4d9b9701139be..ebcea44dd7437 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,7 @@ enum AMDGPU_RESET_SRCS {
 	AMDGPU_RESET_SRC_MES,
 	AMDGPU_RESET_SRC_HWS,
 	AMDGPU_RESET_SRC_USER,
+	AMDGPU_RESET_SRC_USERQ,
 };
 
 struct amdgpu_reset_context {
-- 
2.49.0

