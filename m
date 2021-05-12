Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68519C43616
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D5961059
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D5961059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523D86EC83;
	Wed, 12 May 2021 17:32:16 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F06D6EC81
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeQEKBDy/O1p3UNdkWjWrB2Kqii+LHVlbpgErXhsTY5Y33yR7qnDxnLwF6TwGFlr1pvyqX9iCcbL2h7TTSdOWPDnxmmwp+6R+xQkXhPPXD+NPZG4yPoV/2+mHkvyOomSsUXRysmSBMa1yTdU5fOQEfUYRHzZO5shpM+nEohNO3jKJCEwchikPxuNLkX3kFHyUlIBXOPMFeqVAgdsAL1IQ9oWAmIM9qbqVosA5baHck4fAxfqIRyrIKQLzrsIgrt3f94xFkEdMOahcRmDZsgBYVQn8LrehyaJK+jDKBIcBNVmqUL7hmYkEahwUIQO/pIB1cejzFOs9g5bQrboa39xrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qDSsFFGmw0a+lfFKAcEudMwhn99Ku6T6rhQcDTCobQ=;
 b=S3z5PqYTc6vueI9s2ZVup8oVc0eQRBN0MdmFP9HKAbpuIqI9klT10UwwcnDfFiP0048PtHODUJFBCLv1lvUWzEDUopJotmDqQC/WwyxzVVfs56VDPKvfMAiNVOoPZ1lJQ+RrPdSAEGwM041GSBZmsWaqVSzIevpXGwxC8Wd54Hxz8gQSvq/gJEjDLppytE02zs3xbw9ieSBYH+lYAHFIYZhYXEAxbbdQTwN8LNYiWTq9RktsVeiGQP1ypwLWGGbu4AcWsVIhFY2hq0OFhZFx2pDHKSlA+FGfAHb7VkQ7jMASdEwATnM0WyfgVPHfqAlO5aWmjBY6KWhmCKk7WVxZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qDSsFFGmw0a+lfFKAcEudMwhn99Ku6T6rhQcDTCobQ=;
 b=yYkR7Jr3YY+IbaGMtEQJvBhz0N9HH8h+0I5Ose2pQg6lTAX6fpxW+Qg0WXSSg8HDoLAgFo6JeBzGDnTNUPnNe8ZVMVyMfYxoAmRS/YqzqtFyYtfS6GGLKhODHHjfPHOX5jLPLJ28eoUqAmiyaHHDoe5eMhMUXIc1yrtR+0ztgPE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2564.namprd12.prod.outlook.com (2603:10b6:207:49::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 17:32:11 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:11 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 45/49] drm/amd/amdgpu: Enable DCN IP init for Beige Goby
Date: Wed, 12 May 2021 13:30:49 -0400
Message-Id: <20210512173053.2347842-45-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c31ca009-7e61-4e03-46a3-08d9156bce1d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB256466B4FE297E06971FFA0BF7529@BL0PR12MB2564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OAQgSkRXDlilEjHYryqYsOTwtoMIG/zMn778EJS1LoO1Snr7nGK5KPx2PzAra0a0B+7RSFe9aVdSokvmayTj3FjrhQq7s1u0U/l9nxZu6GhNpqT9PGAXxFVITpQxlYBqe+LWuGiE8hvdJr3t+MosGIniHuxqQbc3Njhun3T79QV1INH6mLEeEUuJg/UgLXsGSfuBsaFd2k39fKxTGtTAmiCMyFze3B7UmeLX4YeVMrhPs880d/MXUzfHeF1b9C/YuYp03pwXkrqlsYBiU+6e7U2qXKkeC1Hef5NjIsp7OH6ieVpRvAdTf8y4G1k7R2M2B4zQPJL1pVgucqOpovxlZGwYU0Dh/tbx7GVuLE9JpgcW69ssI488Z5D8vLwhix6KT1VjwL7E7wvFi1Z8dyqNECjikmLHaHutms9AhC9Dv2gGmGcXSIXUJdbvTKWDvUbT4paq0P7U250kvn6RTllpmnEKkReR7wGwU3zkmemPW4H41d4Yt9RyQNVjO9SfkhZhtG6VyiAoUjRjRPa49KN2yYCsWDMIsBb0v+7xWqPGNjXDHS7BG9FlEWlbUmQ8fxzGGqzoCAo0gviC71ZTdhPkhbFUu3WsnjHH+EG/9ezjrvpNwfEE0Y7nSCbZzeknpqi1gfiCVt/AYQsxXzO3fO7Abj1jOxI5r3HBmdSTlVORy9OYfHBSd6eyECYPiLBy09DQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(5660300002)(2906002)(6486002)(1076003)(66556008)(54906003)(83380400001)(186003)(316002)(38350700002)(38100700002)(52116002)(66476007)(2616005)(66946007)(16526019)(6506007)(26005)(956004)(86362001)(8936002)(8676002)(478600001)(6512007)(36756003)(4326008)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RANg85t85nyezm96REimctPB4yw7kT8tRorGNkTasT2Xxf1KFQ32I8h6mkzf?=
 =?us-ascii?Q?J8STAZim528LGxYgHriKQyW4sz6zneaAL6GdPoCLA8JChkUgKUvIuPIe7HsC?=
 =?us-ascii?Q?vs+c1Z7EuroOfK3inSBAav6Y39AmXJ98+EEcv70Opbh3BJ2GN1vDz0E6oDvo?=
 =?us-ascii?Q?jplYXBZiOvbufZbzLiDjh0NlfubUtuOLI4uZ8yT7X5PCHBSfR7ve53pQ7dKJ?=
 =?us-ascii?Q?PVtiVum2FBXYjbiXczxM41RDP1ckU0sebswRXQM4sh+QJ4Lt4yDw/0YxeOPU?=
 =?us-ascii?Q?rJRGU6JxBSWkcOeVXuH+8qkmOWbj3+PfftXy784AnrnCXP8c18WBt/eP/ulw?=
 =?us-ascii?Q?/WauoTF/J1vn7c7ImZvU87IgGYVySKNNO4uRnOwZw8uUzkqw0C6ClABwNVZk?=
 =?us-ascii?Q?jfFZXGNFXzrAXq+mglgoynUg0+pzQ6LtOK7GHW589J3E9TC8IYvrp09sWMNN?=
 =?us-ascii?Q?8GA206/XIIOztCz4e/tVAA8/6lUkmtxSRA0sQnZcEt3mX3Nf/XcOAmhRO1SZ?=
 =?us-ascii?Q?KgR3msa7IdLBpl3fy4G9VL4EZknGu7lBSxq2IXdtA/m0yVo+B+/SptdV5wa4?=
 =?us-ascii?Q?uydQWcIH195IRnP8+PnxRctke62nEyUGVUvtUTkhx9bRPWVUsMsrT5LZPnEg?=
 =?us-ascii?Q?1kUcwi6zF/gyuhYXHVHbnXfQ6atNQKRwf5CRsblHLxIxa6HNazAgElslchpq?=
 =?us-ascii?Q?vzKiD2mpiR1b1R4C1+elIvR8lgojNbt6ZxIEvz/x3OP3RoOkJ3AjtUWfl8eA?=
 =?us-ascii?Q?qkyKHXxenOfh8Z11VmWeT5XScnFB01eWx61auGpHQ6S6eagHsC6Yp6JKCW7e?=
 =?us-ascii?Q?gdckb79MePfSNw/Qf64NKAN4sAWFGkJorf2WYNT0CNGAYnCcQxeq4GiMtSRK?=
 =?us-ascii?Q?CJDRFF5uPhqfok6Gx0IJkOEaW5RrVCsWw9meHcg/n+xqCxwJb3BfyHknC6Sr?=
 =?us-ascii?Q?u1SKzQ8DWdPblXIopFa22/D4EJUxgdwGI/uatoxquQ95yuJ+jX4K5SMqM+Ai?=
 =?us-ascii?Q?uFWgmV0MruwLdu8AjqPVDneWvT5Exi8dGe0yz/jeDspItRORI94txEiGBMYV?=
 =?us-ascii?Q?Nppj2h4sBiKs4+sF7/+IQP99n+NsjvilENgqiha6USQLMI3QV0Dg8NVkgNIq?=
 =?us-ascii?Q?Ny/1UV/oaf3QRB06+/k9AhWE402HMgRk2Hmw2QOna7stqJqCtGBqE/ez4EMt?=
 =?us-ascii?Q?/8UbKXUhvVsbffMak/X9qLzkJEVq1tVL/RAeWalpnFi8//XoTh1kXTXVDJoQ?=
 =?us-ascii?Q?9LsBUFWo3IwsOS0BG8GXfaMzrsD7WsG/sbrdP7r/NQl6XaNmcUNasdOj8Dxy?=
 =?us-ascii?Q?AnNJkfYwHq+MKT0ttq/uNAah?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31ca009-7e61-4e03-46a3-08d9156bce1d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:41.4768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4USIjbZya7kkIA4X8cF1iu0QmvpVeOQY4kPdhzJG1M+jmEI5zpo3Epsx3Q/Iu71zvogxgNghumz5GqnI/X0elQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2564
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
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Adds DCN IP block initialization for Beige Goby

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c            | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ea3753ca4198..d675c390ebd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3087,6 +3087,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 	case CHIP_VANGOGH:
 #endif
 		return amdgpu_dc != 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 96c7374b93ff..088200e7abad 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -859,6 +859,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
+#if defined(CONFIG_DRM_AMD_DC)
+		else if (amdgpu_device_has_dc_support(adev))
+			amdgpu_device_ip_block_add(adev, &dm_ip_block);
+#endif
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
 		    is_support_sw_smu(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
