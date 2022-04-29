Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA343C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B590910F65B;
	Fri, 29 Apr 2022 17:47:46 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0BC610F690
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXjt9GQn3YnqnG0zbwKEcwHxrs2uIEfBs06spreYeTt6iQPSmae9GA3WfakQQR4UsSYqilB4f8cOYhwvNCt0qNV2bdxjx2gi3oqOt7ImIBlpV6RSOZPT2MCH94HGdInjoBLnHffFLBybmTyD4PrdklTPJ8KNMYseyYVETJHVmZLG8kM/3Rau1/yioamp/KHoB1ulkBwFzEKChjHDfzEp0QQOby66PjIIa/8h2S1m1+AkdDn17vWzSFY9njd75snnDCslJBlt3pZJYo40agGg8xr4178Zi1igaFbE/MZnPMVcdMfcrtS93TMtbmMuSf7ejJ0Ue37/bVzUfoCkc0hnNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCUspK5VvirQFigCjh+oFUX53yb97VLOxGJ6heZvQHE=;
 b=abTe+jBHK0ncPuQuo13hKmd+0GWco8d6qrHa4tt1OB8piJATp9ljHvj/JIKIya4bXXlbw24hM+BrjFRD1qVRBSnT7WZh/MTYhyk4TznkgaDW2vcWuXjMPiXB7VAnHAly0IlBeyGS+zL/rRnV+cIHIaMEBcR0syknM04nRGZLL5Y07QrNnKGdSC21OKYXTEZAsfwOfoxHT/f53ttSHxY0vgfuu8R9XdcxrmZvzjBA13ply+DU+I/stvC+gqFjfui2WVu4GOrtM4fDu7GsIHeAkoD+tNHYdjD2LzLtMffP/juVsf84RGvvwxXJGD0+rcD+b8ixLeRlj6kqW7dOut9+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCUspK5VvirQFigCjh+oFUX53yb97VLOxGJ6heZvQHE=;
 b=djeNWXVQ2SIgT9eOK/y/v1en+m6W4tUvTQ/5UaVPZBYi17eWZMdloZ4PcdGQoYcy2+FJzk/SK7tHzkc0FtUPwhjJL+6EffZW3lSOWuqHtPiWbSY6uT5ghznI1pDPDoJZ1ePa5yw0tyAp0OwtHKLId8DIqI4Sj7s/zoVKU2KYnP0=
Received: from DM6PR18CA0028.namprd18.prod.outlook.com (2603:10b6:5:15b::41)
 by BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:47:19 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::ca) by DM6PR18CA0028.outlook.office365.com
 (2603:10b6:5:15b::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 67/73] drm/amdgpu/mes: create gang and queues for mes self test
Date: Fri, 29 Apr 2022 13:46:18 -0400
Message-ID: <20220429174624.459475-68-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb0383ae-c4fc-4d8c-500c-08da2a084ebd
X-MS-TrafficTypeDiagnostic: BN9PR12MB5258:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB525843A4F4CDFDF0B11A608CF7FC9@BN9PR12MB5258.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcFRRZiItthFF5zaHo5jPcFTAAELSVngxqLNkR2FFxJrbpHn3eMAvW6z8Z0vYv1mVGjfd7cM87mDufqUNsBY93fRFiQ1PlNYQzAlfW0burbBPc+3vaeiVi3CaaNImofd4xqkuwNep/4I4hv+p3sZYeb5xE1nJwE0vpgLWzKTPNo+dTIHK141BHubVFeCzjBZ8vwwmEAaQSt8QyKHmCqMkxmHPVw33NeC6rljTM6tnXkk1clKPgHgpyRKFY4cBn2jwyfGcXPt2PinKogUvIUpy8EdtJdWARhZBB4j+lnrxnq80Cc9QWyOKOuoXMw1DXAOwTJzoQ/4wkfNEakBaWABtaSLhDe0qHvdW5WbwRpdyJ3tnM5hvdGEHts5QhpoqtFIDa0I9tuGQJeHI3lyX9WYwjLeyt+zAbzLNQRTrhKwCGEDcEyGl1N6paSm3rd+9i+YjrTMjPJM3ohkLWIQkdZd8VyshGM3FhklC7U8wpYCT0TijXYC2makoK8hP/dXK1We//eqWI/Q1PvqzZuvkfDBLnQbm8MkXj4aR4SpO3Wc8YjCHZqzuOp/MaY5ARObKUQy1zCVPjLFzRhHul7CO6VO4JsrEkOwt/xIjPtovkFGYYL6d9vB1ie9MrD3CdwVQVQ8kFWjG5ek3z4PvGg7DQy9xumrxiTq4e1XhNzDxDH8epie8pWNTrjW9f11MwiexJQYPXvnAvZ6NIkz92aUmSLtrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(16526019)(186003)(356005)(40460700003)(1076003)(47076005)(336012)(426003)(8936002)(36756003)(8676002)(5660300002)(4326008)(2906002)(2616005)(82310400005)(7696005)(70206006)(54906003)(26005)(70586007)(36860700001)(81166007)(6916009)(86362001)(316002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:19.4543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0383ae-c4fc-4d8c-500c-08da2a084ebd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5258
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Create gang and queues for mes self test.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 39 +++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index b440b36dd98a..027f3aae6025 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -919,3 +919,42 @@ static int amdgpu_mes_test_map_ctx_meta_data(struct amdgpu_device *adev,
 	amdgpu_bo_unreserve(ctx_data->meta_data_obj);
 	return r;
 }
+
+static int amdgpu_mes_test_create_gang_and_queues(struct amdgpu_device *adev,
+					  int pasid, int *gang_id,
+					  int queue_type, int num_queue,
+					  struct amdgpu_ring **added_rings,
+					  struct amdgpu_mes_ctx_data *ctx_data)
+{
+	struct amdgpu_ring *ring;
+	struct amdgpu_mes_gang_properties gprops = {0};
+	int r, j;
+
+	/* create a gang for the process */
+	gprops.priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+	gprops.gang_quantum = adev->mes.default_gang_quantum;
+	gprops.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+	gprops.priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+	gprops.global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+
+	r = amdgpu_mes_add_gang(adev, pasid, &gprops, gang_id);
+	if (r) {
+		DRM_ERROR("failed to add gang\n");
+		return r;
+	}
+
+	/* create queues for the gang */
+	for (j = 0; j < num_queue; j++) {
+		r = amdgpu_mes_add_ring(adev, *gang_id, queue_type, j,
+					ctx_data, &ring);
+		if (r) {
+			DRM_ERROR("failed to add ring\n");
+			break;
+		}
+
+		DRM_INFO("ring %s was added\n", ring->name);
+		added_rings[j] = ring;
+	}
+
+	return 0;
+}
-- 
2.35.1

