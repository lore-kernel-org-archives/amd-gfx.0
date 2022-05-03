Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF64C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C6F10F5F6;
	Tue,  3 May 2022 20:43:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE8DE10F245
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:43:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jt1P/M2xFpNR3qJ2CnJD8hXC+uHy9ZFYoh6vFZBmkBOTVUcR1LKGRMhq+dy2Cjlgq4TJt3jzpqCeC5T8v0JA+1Vg4rQzLdFecNgFBfC6f9Fw6SeskalUML0Lxnh9ldQiVYcm3kgNgtg/f4R8owIzKM+ATll6aLz8cUtJL7t8kn++Uirw9v1mhcovu0krAbVkNDaVoU6X1sFtKoJPJzUNqX11FqgP/x10dNsAAesqoy1dPWv6LtCpz40pwe+MZbLFzD+gK+mVQGEEw9j84iQwsjSkdzhogbOeDwL7feR/au1m/bG05afyI3AhPGDS1f6Y3dgQlTh7NqQlGtkvyjmMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8mju++cek7hWHz2cVWOIaRkR+ali3MQvjThcmZWY4Y=;
 b=Fz97UUK1FmulP6dZea8JN+zK2RtWl0rN2TWIzrkNYozkWH5JGafCIfXuUgaYH5XoRnwCd9qqeei2OIkue5jSAkWaKBZPQwuE7GoudUqxxxs8neuD9duKMAiHbT9GQsJSL6u+IkrzR8rN/th3HcLzpePHMbXalBRnWLhtKvOiEu8bH8ekPRHiEkb4RX5GMbC0K9T2FUbyThTiJdqigPG1W0HnrD83LKHghHCw8iMQwD9mzoUAoW6new4DKxqpI6Q42l7VowCkGXAKQ8/axhz1hh6wHjmSdBSLMrrFPDtHhYWKUcRzyPsuB1LkliO5kpIRbwTvkjZ8BqTldLaZK/uq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8mju++cek7hWHz2cVWOIaRkR+ali3MQvjThcmZWY4Y=;
 b=XPFdhyKC3Sjaw+NZKDDBwYM27AIqF+bA4LcUH5MbEfWNk0RfgikAbqHyr3iTqsGcJmPcylzqIDP7LiGpAZvrDiTiboa7UQbk5w3epqWDo3bppXWxbY+uRKKCEF62PZygIizo2yKJ0LE5qWePOZokBACnHD5lbqHssiN63RBdmgM=
Received: from BN9PR03CA0506.namprd03.prod.outlook.com (2603:10b6:408:130::31)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:43:38 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::eb) by BN9PR03CA0506.outlook.office365.com
 (2603:10b6:408:130::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:43:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:43:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/admgpu/discovery: add NBIO v7.7 into the IP discovery
 list
Date: Tue, 3 May 2022 16:43:14 -0400
Message-ID: <20220503204314.1250729-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503204314.1250729-1-alexander.deucher@amd.com>
References: <20220503204314.1250729-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ab8895f-c887-496d-55dc-08da2d459986
X-MS-TrafficTypeDiagnostic: DM4PR12MB6109:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6109297BC99726E31AE1DBA5F7C09@DM4PR12MB6109.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5cZlHt90vzMmT1N3gO5s/kdQqSwdwuzjfBcCeMq7bGzQv7nIA5f4pNepRJYZu9ijrWRIkhUtFON3/wkw+vXxKF1HVCzmTY0D/5mEywMXChSunq6s31oAEc0eo57wA38C5+goEkeJ2wXlneiJblzNtlsM51qeMvfpq0a5L+Bi9gDYC9PoEs039xmQGROFIekcgLfiRNJFdrH1coSb3K5PnEyodkKM17EAByM5LuHn2KQF+w/fd3+uO65hbcTWeAufD/ayv3qWXz+o//hk9RSNnxpF2HoglRgOtzpw6d8Fl0ax7LArxU8BrOp/LO1ksXOIm9uV3O5uWkjjpve7NMN5zO9RvsNo6j0giLWoYzBLnnGLTegkm750GrjlgIEgvdo37abUaciyuafYokV9rsoyc6yQkpp4yxznMwyf4mAUczo9yIMJPK0t4T0k9nqRXFP3L7dNO4A/o7dfAohfQokKNnM+UfLPVM4Z81yJLBwrVa2Vjo8nN+6viUI/6vobCqcpW4pE3ClvkdUF2XXC/00Vf+iJL65FvBTTv6pkHjpdSQ0i6f3BXrWDwAZnd36Fzbgc7PpmGJmP0fPG8buz1cw5su0lEDr/0/uLK4PgUe5xZ8xOOcDyBNZ/dSbFylb1pIPVDwUMni13c/2gMpKQBW6jhLMkSCaSzn9zvvtkC0fOBUCPJlbE4IHdzPRtTWkkX01MVbBgfrr+IA6g+Nutoo2WA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(26005)(86362001)(508600001)(8936002)(36756003)(6666004)(356005)(7696005)(5660300002)(8676002)(82310400005)(70586007)(83380400001)(4326008)(81166007)(70206006)(336012)(426003)(40460700003)(47076005)(1076003)(316002)(16526019)(186003)(54906003)(6916009)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:43:37.7432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab8895f-c887-496d-55dc-08da2d459986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
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
 Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch is to add NBIO v7.7 into the IP discovery list.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 7ffbe38450cc..2188b9277a6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -53,6 +53,7 @@
 #include "nbio_v2_3.h"
 #include "nbio_v4_3.h"
 #include "nbio_v7_2.h"
+#include "nbio_v7_7.h"
 #include "hdp_v5_0.h"
 #include "hdp_v6_0.h"
 #include "nv.h"
@@ -2200,6 +2201,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.funcs = &nbio_v4_3_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v4_3_hdp_flush_reg;
 		break;
+	case IP_VERSION(7, 7, 0):
+		adev->nbio.funcs = &nbio_v7_7_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v7_7_hdp_flush_reg;
+		break;
 	default:
 		break;
 	}
-- 
2.35.1

