Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A970C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D154510EC19;
	Wed, 29 Mar 2023 20:10:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED0F10EC0B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:09:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7NmJ9yvaXuJsQ42GO2d8PY2oQ3e+cIKzGRoejX/2Ue+M3iQ2CkCFIGhjfFjzN1X8mWUrQMIocEFVMDikYzUVkv3MQ1uPAj/9vah6loLz2eHQRvoMWVfvGRRUit+130G6CztFeoiqNfwmCiSc6UsHK2kET7Mzp8ScBtvU9alPEL+CcNcF3mDI+cL1CXft08K9vZf3EdDl0lsJSpSYD4vryaKFH+uNj9jukmCGnT9UoxTVJWNR8IY4yGxKumBowL0oPuYH9GK+3leHdKyCSj6zs6Orz9RPYbZ6txexU4XJqju3eSVu1mt5HdC3/CksY+DKT8dmxATWR1FiaurJwmd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+yb/GUcxMmxW1WFZdX4sRoaOxXkUG8zcvKhZissqNI=;
 b=aq/BwsCFN+ov7hxlofv5liu0I03r3drjEeirFbVmZM3DG2SjSm/RYER8SV5kIaoqT1ZGPTLmHM4SrWjAo8Mo+zc9sI3QNZxcMgsXPji33CHsJsqE50i3vuGtk2ba5WX0SztDRuxVT/RcPnyZFo0SxYJd5NL8Q/FMMUwxk5Ke3ARyoHUlVMtZzUH9lug9ywTR2sSrlGTR0xegsXWsxtvmXhO7frs+bJWfof2EikY4+0piAgonWA7jbSokiiFf+6tCk4PnRqzuNb/HJWrYt5cXsNiamfBMWM6tTAxYJ7LpppIGa5UvVq67ZyJoiShEU23JBjWaOqIOR2JU32+FUd7niw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+yb/GUcxMmxW1WFZdX4sRoaOxXkUG8zcvKhZissqNI=;
 b=yXPplr8Cf1u2FRba2QfD7uHjD54LJgG8hshuc3rBw2GGCNZ2/7jS94KZr6sSP/T3SCs2j4w7tD2mPAJKB7xdQ7HS/NLNceV2h+D5J17zvD/jz2Mnl//e0J6A3Y4bi3mAD6dw2n+dBoEfQYLuehOqd8ek3Vc/DmhDDfCJb8tPdeU=
Received: from DS7PR06CA0024.namprd06.prod.outlook.com (2603:10b6:8:2a::8) by
 PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Wed, 29 Mar 2023 20:09:57 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::68) by DS7PR06CA0024.outlook.office365.com
 (2603:10b6:8:2a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:09:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:09:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amdgpu: Add mask for SDMA instances
Date: Wed, 29 Mar 2023 16:09:27 -0400
Message-ID: <20230329200930.1982035-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329200930.1982035-1-alexander.deucher@amd.com>
References: <20230329200930.1982035-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: d2bbdbe0-ebfa-400d-f137-08db309191bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYgsbbD8/i8X6/9nKBZ1Uce2i18p3pmJRZ6fcfTRrFKIoVmm8cl7SHrUETt1JhiY+jezW/Mp+UigyBaBwHfBhcija5MOFPqX6zSbcSkp7SBRHXIk4JLj1fuKiwDt8IyUaWbjwPLnCtxezk+/OTlnqcXacGaPxe6+cKiWXNIPgn/6Bz8FkwUhOblsl0sRWMdG16c3gZNuWlPX1TMApBrHKiXDm794O36VAAw54Ji74ZC35EDmcZoFIvitthbv3FH1AbZhZ6/SZcu66I0NPEt7+CA1VFK6ragsCBbKDkfb4VOHPeCQaTm2WkJfISE//ec8FTPLxCPXOu1oBPc//mPGDLZm7P5uvhzEwbeJ3D+kYoIM1v/ZteTYtyUsNCmg8vcDuB2Mb9ouvKDmT5DewX39517TMuoWxqZAqHfDgKloFAgwE6DMCfJfCNEL8oan3UnSG6yxdA+62HyzQIq+s3VezWSrzqdledhNu0w2p3pci6tHDEdzWXXE5oSjW0CodxtK4ty5R5nZD78POri1UR1/kuzaPZ+zkz63HYpXjSKqeTIhq4I+A8D64Y+ZFrE5yJ3bqfAmJpjMrUvkIJEZQ2P3zu5GBJoCnbEMOgWcbpHwXv9WKwgrroW97BdqeqpyJ/x8y22p4a6EhvG6eug6397PQqhKDx68Fo8s8LJfXV5MBwZ+lxMr9wcrgfQ2i5MZXwJ2UZ1tqmFioj98e3PMtOW+Hi/9jg5iCt66SngMuMlmkYo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(82310400005)(7696005)(40460700003)(8676002)(36756003)(70586007)(41300700001)(6916009)(70206006)(316002)(54906003)(4326008)(36860700001)(478600001)(5660300002)(40480700001)(82740400003)(16526019)(81166007)(356005)(2616005)(186003)(86362001)(6666004)(26005)(1076003)(8936002)(426003)(336012)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:09:57.5680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bbdbe0-ebfa-400d-f137-08db309191bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add a mask of SDMA instances available for use. On certain ASIC configs,
not all SDMA instances are available for software use.

v2:
	Change sdma mask type to uint32_t (Le)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 632b77138fe4..62afb282a3ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -48,6 +48,8 @@ enum amdgpu_sdma_irq {
 	AMDGPU_SDMA_IRQ_LAST
 };
 
+#define NUM_SDMA(x) hweight32(x)
+
 struct amdgpu_sdma_instance {
 	/* SDMA firmware */
 	const struct firmware	*fw;
@@ -75,6 +77,7 @@ struct amdgpu_sdma {
 	struct amdgpu_irq_src	srbm_write_irq;
 
 	int			num_instances;
+	uint32_t 		sdma_mask;
 	int			num_inst_per_aid;
 	uint32_t                    srbm_soft_reset;
 	bool			has_page_queue;
-- 
2.39.2

