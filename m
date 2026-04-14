Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6EEF34C7E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 05:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B97B110E09C;
	Tue, 14 Apr 2026 05:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jiygm/ys";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3290B10E09C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 05:10:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXP5BNcjEfIDhBzZf52EiiI5vLxvV0IHSndpJEz73E0SvDN49PESSrwPWZQ5Rm69vbdEd7JiDhdKo+HAQFYE2Xo6ZN7m2rb22IXKMe9Xagj4SWo6fq5fOCxR1Mna1hujiYXSCi5C2Xu9BoPeFWHxG4rPqctnIOiIBwz1NQhNdIcGRvxEkj4kMLr3TEHf5Mv6nj4bAlyXSYQn922/qgJttCkchrqp9LOmRYkx28QLQ5Bs3yfJjntx6VvoxlFtBa128bvfAiYnAg8/7kWjXaRgCEI+tm6b7Ue0p2SdK1wWyJfdx3GQh/0Uy3tBH5SC8lqIoM7eXHDphNvYvOgg3Ng6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT5P9qRQkcqRC+LaKura9wk8rK3ZmUUc+Qham3uobPc=;
 b=GYDmsYS7vf4IF5Z5Mr/APLxR/CrpSKKMhaGdnI0ncHKs7lB19Wryoy1UMGgC0chnRYtMRQWLB/r/NX8Td3WHzHLZHsWdKBcB/ZuU0famrx4PJK+UGPiZwsRFdr+n60Y7lPJ0cfZFuakCfPdTOIKsw/twJCIsBYcJCEggLbiOb3joOotwQitkgIUO6YpMxv11yBd9eIKJm+b/BgoHd8gr5nVN9W/JtrUCftnXbp8JvdUWzgA0pYWcNDbIBpviXqfBKE2bdNzoYAx8L2K+k0Wu/hz86cdFAo+sPdVia2o3quj7oht6Q0CwpieEjjyaXvnO9wEY4uXFBc2UQ9NwcIh4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT5P9qRQkcqRC+LaKura9wk8rK3ZmUUc+Qham3uobPc=;
 b=jiygm/ysPuC+fuhTfu2PJEp6h7JkKqn/dbZAxF/YMrTqb7gqzFhQD5sWWFNfZ8D5OvpyhaNS9uhjo/LAZAQh1i0IvQgD/to3lQjziMhZpo1YmAnXEf0eOEtI4mZFlGGJob7XhidXO6+debGNZvixKx/TA1s8FxqWBlVyoQaL120=
Received: from BY5PR16CA0002.namprd16.prod.outlook.com (2603:10b6:a03:1a0::15)
 by DM4PR12MB5986.namprd12.prod.outlook.com (2603:10b6:8:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 05:10:33 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::b2) by BY5PR16CA0002.outlook.office365.com
 (2603:10b6:a03:1a0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 05:10:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 05:10:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 00:10:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 22:12:38 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 00:10:19 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Michael Chen <michael.chen@amd.com>,
 "Alex
 Deucher" <alexander.deucher@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v4] drm/amdgpu/mes_v12: use mes schedule pipe for legacy
 queues on unified MES
Date: Tue, 14 Apr 2026 13:09:25 +0800
Message-ID: <20260414051018.3115995-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|DM4PR12MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ecbf6cd-ace6-4a5c-2d2d-08de99e42737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: M1FjGz5Y+ALDib2aB8GGUZF+0w999JsZZBIoY5zOrBPO2axrNW4Dz+ia6fSqPS/OcuwhMBzYX9EkRZ3v2WGSZmrSfUrNs+6U8UDKiDJPhl5FKuqYz9PDR5We3InD5Z53ikju5EdIG8rR8CzHoX8TTU56CYstaM/DsGLYS9OI8vkPwjz8uLtEOmHvPdHqf3Y16ZiYx4xrcwuSrhhwUdRv//Wb/aOu7aWRZLOMbixyvI6lMyfwnk/awixKPhC/tSIQGJdSG60HZ08Tv+jB+BWS80k7Z36qh0pBi27J9YYKkF9WB810n4vmdlFuGMmofVEinlGHAUgz9UqC1lAQEKEISaKCMisfwNRsZfs5SKIi4AYZVUBsYL2upacVTg3/ataVcg60WCI/z4HaDH5ILGhCgtJnjO9MMKkVz81RbjOmtbim03CJEzBQn2wEzL23ow1FedhCbBHe/GPk8w8ly6agr1pr+QbUnqlcWm8R6iquz609o1It//EGGf8x1zthYuQDzOlaZ4eqGDoJdSvIXbWG5F2qt5xcCfnvRKIBAfIagMvE6hNglTkrOjXoNIe7MFHel3xdsG/l97pQKexi8TsSkkNtT7/s762lxPRo1QQgP0ExND56rvBDBghr5UtycH/Bo4/3z/+olEbROV25rhk66DBsJcHOaTiKWTglq7IKHnp6uZWi9/d21/BnAmAtG3ebIRfzieuae6n8RgX8vgH5fhHSin/SYpw97msEMmkQbtFPGiFers3Ll+dhWtFXXeuClec3Lnu1oZt1NAHSsgEuLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GHneo7GUuzB6v89Dk+B9FgG0kOm3wNVMwzrNZLb84RlR6HlAW1GdWUAjJYBEl0PlNsCx/AOLrL1g4QVNiTPbrvimbhnXvuf8A84oOGhUi5AgKbJLk3lWkEiwgPfyhPXpcvClf8T0I1wsC/DQHGMLtjuYttsomKooglHrRuvCWUX8C7Ok9Q0o86ojv7Nin2V+qgivcAENMqmpXr1xbnBfxtDzDAjzbwIJ6rQjTBVPO9qLmKkZrprX7GO5azbaBx5jjJGZZSBdM46w+EHQucSQamTE4UXvf1lCGUBmoG/f8UEMoZQVlZF4Z3BdS6o2jfA9HehYVhRRshp7zyQlCFQmq5JVGQayb/pdmuDGba9vjtvIckc5H0AjnvM5Az17M6YrV7IwTCWonxnU2TP3egK9+4bAYkajYosDjrTJStyXWSTaqOh7MioZ7x1rUreJD9uv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 05:10:32.1897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecbf6cd-ace6-4a5c-2d2d-08de99e42737
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5986
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
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 023c7345ea54..47afc99796c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -528,10 +528,15 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
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
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
@@ -567,10 +572,15 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
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
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
-- 
2.49.0

