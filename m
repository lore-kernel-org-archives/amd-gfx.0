Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93742C77B6D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:18:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 367C810EFC3;
	Thu, 30 Mar 2023 19:18:23 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5CB110EFBE
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwLOnKbbovgN/nzDPaHovK3L3m4My/HZOC9cxfLm+28puEEXQgjmWwFRccFN4zJDrUrv5mxUz2pJxGZ4UX+1jwfnirXWiHYFe/eBn1iy0ZmZOI9v8CnESJYIuyJtNbpzXBuj8JDThs1csjYPdrwUAJVi9Wutwh7NqE38W1p0JHbWnmRSEBd4z6JMMPk83RtGPaPfMOmVbctsYJNi8jWJvPR7ztP2Weg2igsR06rGthqUI/UheWG2AYc/nuDpiupINGnU/HrUjeEhSgIl1d3ZQh6pkOXnJ2XygIRlFPSnOb2clz4rvm5K61quoaCKIKtimYUSp4GzdvyzAxc/MG+trg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP8TdcQ7fOBVSOx1VcvZ+5le8IzJVj5vEelNeSyGjGY=;
 b=mGQe28u18gdIhgfY1qeLL5ArkJcj5Jbt05czhTgcXknZzbVKOXlCBFsNhDKFHNJTRPh4fQW1Pmp59pze3jJIO10200N4In1WS/eyy3Z8Jh/sBCbJYF+X3jgwIJATr9yw8nxR0iS7+q5f88RBpTwEivJ+pP5bPH1VrK506aZtMtqk70z71UVD3pCH+gxAsV3zW85ZMT0x3J1VRSXQI1/I++s5bpc4IOhpJ2orPT+nMLOGSikibAThOex+dpjhA4XlSTG1yBheW5grll1Ur6NuaVEHlf1nn8KqPqE/zXBVWViYmYLknZ9Rax7b4uR8ecY7Uj51wLm+Z6IyXB5LqiJnkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP8TdcQ7fOBVSOx1VcvZ+5le8IzJVj5vEelNeSyGjGY=;
 b=F5ee9M1aU1zgSSwrLZ/KZpSRudWi5mhRAuMAoUdiyKerRBFSvY8wMzJTbleq3YcJPpeqRAOLBf/ipH2nDYlGnHNFFTS60lMwSaItmi6mKrszpWDppblQKPuSnnS0mf73YlpkFUeThozVAumxvPuenjpqqCc6EhiJaYyRG8HGka4=
Received: from BN9P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::14)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 19:18:09 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::ab) by BN9P223CA0009.outlook.office365.com
 (2603:10b6:408:10b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:18:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:18:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/13] drm/amdgpu: track MQD size for gfx and compute
Date: Thu, 30 Mar 2023 15:17:49 -0400
Message-ID: <20230330191750.1134210-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330191750.1134210-1-alexander.deucher@amd.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fcdecc-152e-4fbd-6c49-08db31537fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jHn5VZHPcVVcIX50ENMML9/a7D5owiDDFIjLWbR0bOixgfpU8+iriKA/HS+UmvZnMYat+piSgpRjGuV9uJRzoyo6nD6GtPz6O3unZrzjULG9dqimWBxkUeq39bWIPsxfvOIIOzX51rjchvO1xUS0pRB4g+0EP5cTcBNffpfpGWbdv1xCbTTzYaEZO6SBUYRULGCcD25sul4NDABwc9QblyJ+GYRwn6gcdiJO9Bfgv8V4Che4/8VoE1w2Y9h0/Osm196iefn8LpC2CpNb6mwoLSUJ6v9fZ2v+Db2S9defRDHYF6NdQf6BSswaoUXbg7ozB4U5JtbU2fSktXSkV6jPNb56PovBcRAz4NMC4yAQNuJHRPrZ4yOahxSNqpnb40ftUK/HAr7v5tYf+BvxcaCn9GtDXwkbDLfr2U+noIc7YzpdelBGzcDb1HzWI68v9y+VsMys3NPHd5pKsNvRok1AMWSx4eMnoYB/U05cyRYCvwGPRse+fUwgRS/cmm3+jrW43N2nVw8DWq+q6Fvbpvbyq/sfbn7iUTPlVeL/J8F9V2rUBuzfO+QVR7htfVJPfTF1/MK/7iWQgOFFtEo+ASYxQ6qSq7RvRB10qgvKRH0ClhDG35LWIyeiUS5cW/c1AWdRQwmgCLHNCUrmhHBXjC1qwvv+r+o8qwGK0nXZrnR/bHHQOY2I90ESCQo5Lf+dzDFQ0zjWzH4ukNs5LqgH1labGUW29crGkCaboHfrM1V+os=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(356005)(1076003)(81166007)(82740400003)(26005)(6666004)(478600001)(40460700003)(7696005)(70206006)(316002)(82310400005)(54906003)(36756003)(70586007)(6916009)(86362001)(41300700001)(336012)(4326008)(8676002)(2616005)(47076005)(2906002)(186003)(426003)(5660300002)(36860700001)(8936002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:18:09.7846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fcdecc-152e-4fbd-6c49-08db31537fbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It varies by generation and we need to know the size
to expose this via debugfs.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c50d59855011..5435f41a3b7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -404,6 +404,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 					return r;
 				}
 
+				ring->mqd_size = mqd_size;
 				/* prepare MQD backup */
 				adev->gfx.me.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
 				if (!adev->gfx.me.mqd_backup[i])
@@ -424,6 +425,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 				return r;
 			}
 
+			ring->mqd_size = mqd_size;
 			/* prepare MQD backup */
 			adev->gfx.mec.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
 			if (!adev->gfx.mec.mqd_backup[i])
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7942cb62e52c..deb9f7bead02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -257,6 +257,7 @@ struct amdgpu_ring {
 	struct amdgpu_bo	*mqd_obj;
 	uint64_t                mqd_gpu_addr;
 	void                    *mqd_ptr;
+	unsigned                mqd_size;
 	uint64_t                eop_gpu_addr;
 	u32			doorbell_index;
 	bool			use_doorbell;
-- 
2.39.2

