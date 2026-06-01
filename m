Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0655FCD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C88D112DB9;
	Mon,  1 Jun 2026 05:52:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vu2VX01F";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0C1112DB9
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTOouHnZgg1P8da9M7uiCoN1b6I7+U3XgAE6m1J8iLNxDRwA+1PFcqtzdFzPhqJD6OJNGwrH3yJ8B4RK3flYnAnHwIcnIkTu+Jwx7E5vNI24TsAw1BLGMMS9KC5F1v672mBoeRFBSTXeflmlZKlDGBQ0YAipzZmKzjrB9tR+JadbyP2k6MSkWmsRQawHJYUOSteIh5O6OCoo8UFSntE+yS8RSA33gAJMlHLE8bIFYR261MbKq7dP20Qa73iUtxBMTjGSo1R/VS2sbUcBEJS1sj46kLMfRc0HnJC2RN90EXHs/NsRYqKroFflv79GoahwuQIXeY2JwdZt+aoMUjPneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DO4oJ60drzrjwDnSHdIP5wme+VxWPHFUZTs1sHCtGhw=;
 b=WgTFcilkoQHmCVhI67uxH4NxoqsYC8niqMwgrn337LDrp0+bHVPHqNLaqf0K8dcCkCVy2Wb7htoMh6b4JG7ft5QgxxslrYDz34tQAZtOAd0Nf875LKiQ+KKhPHmVe5DWI9Q7bW4z/IEya7CQGBV8Ie0okEcRSLXaESPlQWEIn+AZZhJOhVuBrJ34cgvU4VcZgKV4+wGdRtFhpfzqrekdEuuRMI0r0iHjAJpGNfDbVq2lrxJJKoqbgF+unolS1R8c3lNsLpvRGnP23TIPTU044iIu5q88RlebDF0kvDxznHwBU/ifw7ps3PGs83vCRQr56di8Cc/4k6zrgEcuMgqgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO4oJ60drzrjwDnSHdIP5wme+VxWPHFUZTs1sHCtGhw=;
 b=Vu2VX01FepvNFW132bldWth+vAomyTKA/qtsod7i0c9c4CqsCg2rywUo8Vb+jKCfNAvhEjO62NJGnBuTOCoOo+p4no/7ddoHVju1H6/pNPUKKL7SjTWpKbQaPum0d9hH9+NuYcfAe695o2NLKi2M4OSu12yUq7rxp30eUrimXSQ=
Received: from BL1P223CA0033.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::8)
 by DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 05:52:10 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:5b6:cafe::3f) by BL1P223CA0033.outlook.office365.com
 (2603:10b6:208:5b6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:52:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:52:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:52:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:52:06 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:51:54 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Michael Chen <michael.chen@amd.com>,
 "Alex
 Deucher" <alexander.deucher@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 12/42] drm/amdgpu/mes_v12_1: use mes schedule pipe for
 legacy queues on unified MES
Date: Mon, 1 Jun 2026 13:48:58 +0800
Message-ID: <20260601055034.3700921-12-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfff005-10bd-4f8e-8407-08debfa1eba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Dq017vjfn9qxt3bjJazRhOZQLrU/pH9o9rZbh6Dhe4gJSq+ChbQIu6+msthXc9ZjXVmdheMmcqoJS40t5YAUu4RVjr5aS81ijy+d76Cj5mo6k+Vl19hfhjVZlQ6DYklHTTSmt3fJ5f3hMlMGPj100+vsswuUSNbGp/HBKeZzpf+X4KjRT7nflZ2XY5S03L5RM5bbD0vYeRyIBKre+u98ijTRz2U82VDsBcCLRH6g/VDrztfb8dusciKZVsXy5NYDeRsf9l5KWExRoqZKu7MsERQ4YwYxhZycZE15fjXsNhLWmrMZJ/2gq7WEjIdDhTPE55bXmrGSmm0snkpPsOqc5j9v/uAooTTAduPQdfb5Tk6CCv7AfmvZiQAycOAoAa6gg0jWEVMUwasQUadW44lP/ZmexmB3YDEIZKMq2ZXXmHBy/Qq/Qkicgx93ZZ5HqnQP5ERtBU8vFFcG7eH7zTX0KnP+cCBlqOhiFO7YQKKHlbtzY8Sfy0YxuDFS5o/WxY//xh81rJgs+x5mQqhW5+DRB0HxGikrU8D2qEb/mBSjiDLrVRioNYjTK460SISjs27Lkyh/+UWrXbFTjoC4mFZbOfw+zPJsSXIwijc6NFj/y4KvN/WSRyi5Y6Oa+NfkaSMxNoxnIEiIMIXlt3ZTWU8Tybu5yxQWPLE4o+qV5G9af87omJfS+M/G8XXMBAv8ZznjdMktDdivosa4WXncbl4dIHgjJNF1zWPhjzYQMF/LLCo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2Oxmivgd1cdy5R9FB9j+URXD7ZyopbpraYIDuUJRXuFQ5PDm+KhJ1bxHLl+Hf92TAujllreDA2Hw+XOWCKzE66Yey9izzi5t2fjViZybiidc9H4gaE8ldHyWflHpRj7sIZvCpIaI44i1valUF6pjqBLyJD4u8+INqDFVBvynTr3ABfyQgG8L9D97spg1QgXZIUIEbSd1oIQkHtJpss5JgHWbpawdAva3HEEoxB1h5D4htwSwn7AmqtC5XsaHfzoDp1qgdKGwdrA9rBGxaXzUMWTYcwXK8YlvZeLbjT8wRmTb7GnR76EABjL2BTNHNWdX9jIBckTZOfust/H5XekhzIT265tNuzN0v5mXdDGRA7VBdBbvoc/j1C2kjy3UBxyqtVYGXZwP9j7/KMji+dKISpQh9mPYk4J67A3C+wJJyaM3h4lXjvOL8pxnkQcplcW0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:52:09.7163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfff005-10bd-4f8e-8407-08debfa1eba8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326
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

when suspend_all_gangs is issued to pipe0 MES during system suspend or runtime PM, pipe0 can only suspend and resume queues it has tracked.
KCQs registered with a non-zero pipe slot may not be correctly handled, leaving them in an inconsistent state after resume.

v3: fix the schedule pipe issue

Suggested-by: Michael Chen <michael.chen@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index b169e577e583..2099beedd575 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -417,10 +417,15 @@ static int mes_v12_1_map_legacy_queue(struct amdgpu_mes *mes,
 		convert_to_mes_queue_type(input->queue_type);
 	mes_add_queue_pkt.map_legacy_kq = 1;
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
+	if (mes->adev->enable_uni_mes) {
+		/* Keep scheduler queue on KIQ pipe; map all other kernel queues on sched pipe. */
+		if (input->queue_type == AMDGPU_RING_TYPE_MES)
+			pipe = AMDGPU_MES_KIQ_PIPE;
+		else
+			pipe = AMDGPU_MES_SCHED_PIPE;
+	} else {
 		pipe = AMDGPU_MES_SCHED_PIPE;
+	}
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
 			input->xcc_id, pipe,
@@ -457,10 +462,15 @@ static int mes_v12_1_unmap_legacy_queue(struct amdgpu_mes *mes,
 			convert_to_mes_queue_type(input->queue_type);
 	}
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
+	if (mes->adev->enable_uni_mes) {
+		/* Keep scheduler queue on KIQ pipe; map all other kernel queues on sched pipe. */
+		if (input->queue_type == AMDGPU_RING_TYPE_MES)
+			pipe = AMDGPU_MES_KIQ_PIPE;
+		else
+			pipe = AMDGPU_MES_SCHED_PIPE;
+	} else {
 		pipe = AMDGPU_MES_SCHED_PIPE;
+	}
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
 			input->xcc_id, pipe,
-- 
2.49.0

