Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138A4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Mar 2022 09:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D30610E38A;
	Fri,  4 Mar 2022 09:16:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D31810E38A
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Mar 2022 09:16:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW24b00iIweTfMT/pcdGP6icfDlb2qr3N0+utxKNUNiAh3lxsMnRI1mj+YUKNd5IsbuNCdY9tS2p0rAwJPbbn/O+ZykDl1H5aRc7b1gCdfZZ3khVj/T+mdvGSj0fhRvzyXXoVzoWez/+LLnNQq3OpOWIwlReqiYZ8mLFNVVvJD6n4sarGGMUWFs3aPD/dL9pvE1xmzwBD9h5+///Bze7xavgjvSGQlTNt2iFQqFCKxaOqhkca61W+sqEn1RPW5orgIkiOO26tLy9BVCc7dOFLQBdEdAR8ehDPHbYG1vL343Yj9cgYjShx1bm0EJqEamh/5eAYkY20I1KG2uSJWTXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqOrZ7e0Ll8Ti/XA+63VLmRhmlTLMVN94JS9TTKUAsk=;
 b=hi4NelqeE8hh7wkCvk8l8HyK0CFQRV6Q5t7+jq1FwEACzni5jfYuep8PVdspTIS3LQoQoEeSbEpg3/iC6Ud6tO2DPRJ1aF+KKu+zrzei8Xs0RJ6D2noiObqohQf1Fe3MEkwMH7T93rVKi5E09N8xmZJtCH3TtwHYEkWppgR/49mnhm68iQzxQ40p3gUj+hsR92S20Z+RuFaunttJPtx0jTsax8XJ1xRm3CJSDccxy5LpxPe2cP9lXrODA5kBBt9R4QbOkz7jqnjoMb21QSDdsM5y0+SvYuMq9EyfZdnvygJrll4axQ17WBGrVIHPv098UNPU1LsaDOM94deU2UWS5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqOrZ7e0Ll8Ti/XA+63VLmRhmlTLMVN94JS9TTKUAsk=;
 b=z2Sm9rnZJtjK4LK1sHQHMMiEwCD96Jp/6uGmxCL38l5W3Mdqu0A4NTLu5QunEB19CYlICqnWyM7HA3pOr5sf7YC6/O7BOI+n1NdI6mSLw/IFJK2DbgEn/DuK5o6Z76oom449AZok5Br0j1GMk/BrLJYX8/PXFmZaCKjneYI7Kj8=
Received: from DS7PR03CA0048.namprd03.prod.outlook.com (2603:10b6:5:3b5::23)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 09:16:13 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::22) by DS7PR03CA0048.outlook.office365.com
 (2603:10b6:5:3b5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Fri, 4 Mar 2022 09:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Fri, 4 Mar 2022 09:16:12 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 03:16:10 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Date: Fri, 4 Mar 2022 17:15:55 +0800
Message-ID: <20220304091555.4094582-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f7936e-e9de-4b20-dc50-08d9fdbfa0a4
X-MS-TrafficTypeDiagnostic: BN9PR12MB5082:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB508227DA457F7E280E832DCBFB059@BN9PR12MB5082.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OFyrTBMxRP/hopJL6SCbSHDsAFknExRUzQgE7YuZabZdgcnZVmGqZRzxrsOSAbOQ8LHai8yN/S5UShRWsc5n/RM5ZzlSkYo7eB4BDVV9ArIHpGzFQuE5wP9BRTLGKXgyigR4ObtpZM0ZWM9Dri32TJkNpwT4l2j4wQGLqjyLEtcrg5VTXX5+QSsabGxqcpy+XhNIK12bFsBqVIzxhxO0SnO5c9Mz+/Ur8+Q50s9DRtSKLtuI/Saq08VtTknMGWRIgboUm57spE06OQQQJ6moUVwJ9igmzcEv485DYEDYPg5aXOYpbHzBhdSRd7ILKqQs0+XyXt2ruvCreTH9oK6aiTbh2dzKH+uKYS3nNDss6TCUAfkrgQpBIV3LiJc9yy9XogHbknZcjQLFjv0sO56G+V4quPqlRobLL4fgxFQcS9SsKOYql9mfdhDZBXjUzEQHvOh56PAiDoPti86El+ZM6tRkV6MnD3HouIGNNyaAo3x+aLTJHRqXSWfp0/z1xQ8PxzY2Uza1LysGBj68U5+zNi9oItxADA1LLa+6atPbd+t43weBrH7PhnE30IaeebSn073ZKoIN382sG9RT2DaTP2i5ByOLSDOvscdLg7Bi0G3tbH4am3AQr31Iy32SGEK2zf5/Ma83yGoEp1hI2bvjGMnDTaQ+SzuddNP7ZVeRWYKhroswSPSOs3pgNuDysozybDnrgZ6VqY65ZSZDtm+0Gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400004)(1076003)(2616005)(356005)(81166007)(5660300002)(7696005)(8676002)(70586007)(4326008)(508600001)(70206006)(2906002)(6666004)(36756003)(36860700001)(40460700003)(426003)(47076005)(336012)(6916009)(26005)(54906003)(16526019)(186003)(86362001)(316002)(83380400001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 09:16:12.4281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f7936e-e9de-4b20-dc50-08d9fdbfa0a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is a hardware issue that VCN can't handle a GTT
backing stored TMZ buffer on Raven.

Move such a TMZ buffer to VRAM domain before command
submission.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index af12256e1bd3..66345f2ce6ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -393,6 +393,24 @@ void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
 	spin_unlock(&adev->mm_stats.lock);
 }
 
+static int raven_vcn_tmz_quirks(struct amdgpu_cs_parser *p, struct amdgpu_bo *bo, uint32_t *domain)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
+
+	if ((adev->asic_type == CHIP_RAVEN) &&
+	    (bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED) &&
+	    (ring->funcs->type == AMDGPU_HW_IP_VCN_DEC ||
+	    ring->funcs->type == AMDGPU_HW_IP_VCN_ENC ||
+	    ring->funcs->type == AMDGPU_HW_IP_VCN_JPEG)) {
+		if (domain)
+			*domain = AMDGPU_GEM_DOMAIN_VRAM;
+		return 1;
+	}
+
+	return 0;
+}
+
 static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
@@ -403,6 +421,7 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
 		.resv = bo->tbo.base.resv
 	};
 	uint32_t domain;
+	bool need_retry = 1;
 	int r;
 
 	if (bo->tbo.pin_count)
@@ -431,6 +450,8 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
 		domain = bo->allowed_domains;
 	}
 
+	raven_vcn_tmz_quirks(p, bo, &domain);
+
 retry:
 	amdgpu_bo_placement_from_domain(bo, domain);
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
@@ -442,6 +463,12 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
 
 	if (unlikely(r == -ENOMEM) && domain != bo->allowed_domains) {
 		domain = bo->allowed_domains;
+		if (raven_vcn_tmz_quirks(p, bo, &domain)) {
+			if (need_retry)
+				need_retry = 0;
+			else
+				return r;
+		}
 		goto retry;
 	}
 
-- 
2.25.1

