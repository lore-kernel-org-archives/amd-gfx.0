Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F6CC433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D0F64E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D0F64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C918D6EB8D;
	Wed, 24 Feb 2021 22:22:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59EDF6EB88
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBj5CF57dpSNy/FnKadGtOUozbPrQ4GgsHq/nFB66I4ey5IJhTtNS57ez7KnnU7CSfCgGucXFohw2oJr1ZIU6834wy3CPpnFF0jwwUlmnvmL4dgSNwJl79N6SMlrGELqmAsD4ybs0WruUxH8gdp7Wj3v3qbXGs78PZ6FzhTcLhuiImnfZXPVFZ52D8zzWPqqKnoATuLs8guoPck4bLNwK9p2sOwB8sRPZvlThM9x5nkncFY2DpkiFwGl3zVCTZqrubMxCA4BjpuzgzfYOL27NzaMWdVK5UDrfJ0+Sbc672GHK1dwE7BpKKrvS6kPgrEdOnG3shwvn9jiJhfQvSoxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaqmE6otaYplvCQmbH5UJm2Jm7eptP8o+3RYww8KY8Q=;
 b=EHi5IVFe8d3mvKeUBN2ePA6i/wiRo2A7AFV+1xktDHjSr8PwHGtrJHt22e81+1ie30iM17d3ONdiqRd0c0+TivxNukfum/krX8KtC4Y7I4rgeEmw2VobEYBnmnmyButX1DwZ67E1JiD/HVsxyB3pdZCvi2mhvNHXOCyz/lDOlWX8tXrvmzc/LWtlZPZwc3574erA19g/s1TwK3nWN3aC6ibi3vyeeD9UOkcsrfTGvGGMjALMCaVMWUVrfwtzJOmNIh0nAvqH+zHiO/SvEfb7xtqdNOoA5Wgnx3q5RfFMrFd7ujjsfIgLyOhZRNGioWaVJJL9PHrl3tlpWjSj8qGs+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaqmE6otaYplvCQmbH5UJm2Jm7eptP8o+3RYww8KY8Q=;
 b=XwhpufZHPBAIjWd7Z50UPbNBlpRtWHfgZuQyKblKRPsZST+ZoLlvBGFco0bPnhZ9lBQnsmI63F7NM24FsdkAbotG3sxau6DwfLBBglLVTrejkvgnSnJbiFl9t+hC5WXbk0KaQIc0lTB0RdBYhBsH2grEp7nN8Wvuhv1gaaz9ODk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 22:21:54 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:54 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 127/159] drm/amdgpu: Use physical translation mode to access
 page table
Date: Wed, 24 Feb 2021 17:18:27 -0500
Message-Id: <20210224221859.3068810-120-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1e1af5af-26a6-4254-d0c3-08d8d9127096
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4503279DF8E97BB11639C73CF79F9@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Af/37jPb4yWeIHB6miCAQP/lHlfd40piIFAWt+tuLjg/CwWOXQ4vDvk26uJulGPF1eEEMvTGUyL9uM43VF8r2VVelrVQDzGOoQTVTEbdtcSfkIW8sW33e49Em27JOf4CJxJobMVlTW2mshuGqhBaQkvcuAluxZ8+Hk/QaRRvcdBb2W/VpexrSKGEbFvA9W2k+CQ68nUaPbDXR4mOjdUHrtjEpNE9F8qUvYvJH3k0BiRXHSR3WzM/mAly5S0rwkxdWQTrprO2CJ9aMG9G3hvuL6SKQKlr/2DUzyuOd4KuXSSeaRYOMxjN/cpUWH0NuLm49JRUV7y55aCRFbWdFlxhGFJFUSIXbFXW+yUMvM2vLnNM7VSw5e1Lu2+w0tgXSCHKNIGoQQ7885kvyD8tfXodJmaj/MABREUpf4s6TaP3esVbgD6Wz6xIXa9LThX4nfp9eKteW/OEs978mdFXuHOj2JduLVVjlyIkoG+c06jvv+c2PTnCi6xB6iKKjtIm3VgmhwL5xA3LSaDAYwD8gqOgmzMN8i5ueCdiw9s4YIlqXHiLa/wQKXakYabAIuI262bYV/J+BUmKDYHOa+/cr+Puyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(6916009)(52116002)(478600001)(5660300002)(1076003)(4326008)(36756003)(54906003)(6506007)(6486002)(6512007)(66556008)(6666004)(83380400001)(186003)(26005)(66476007)(8676002)(8936002)(2616005)(316002)(956004)(2906002)(86362001)(66946007)(69590400012)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yxvr3Lm8bGflHAJre6hBS8Foq+tI42S+k6WK1HFcmOf53V6/EfWLdsytCjFh?=
 =?us-ascii?Q?p4atOmQLeC+c06M/ilEfnLjpSKp1ahETVfk+7t4IQ4pDQupIIGAuqRhgJNdH?=
 =?us-ascii?Q?mMphT0qVeBxqzU5ynjCIUSS93yNygMSKu7Ga6qreUTroCnxHkBqIFySB/Z0t?=
 =?us-ascii?Q?3G4ai2FWkPl+aUmCedcE+6nTJuHv71pX5+zZIy+l3/ZDKxr9AAye/ybWjhZk?=
 =?us-ascii?Q?Csndlu36QbSVzg8NNBzWvVHHZx76IpNXnA811vgmsCF06CZz0DXh0n7SkPxy?=
 =?us-ascii?Q?zfGLmOobhxZFi0M/zynBhwZBeabkK2pjyyh1tH28ZNrBAAzbFY3VzpuqwDjr?=
 =?us-ascii?Q?FQiSfxzKBz8jUQ6BwRRjEhZCJbIL61qJ8g/RHIjJK4zRzoCSPrrJWP4zqJte?=
 =?us-ascii?Q?BIUa5R89KG/T13RvYtSYTC4f46vaOFQp1jxMhqjhDXJD42rJYdkSQ2wk99Er?=
 =?us-ascii?Q?nKURRyGEIfxOwtlSurjLRbbKLTleHWe4Lo8g460OjMUj14iTMCODOpNQfWhn?=
 =?us-ascii?Q?yVw1P5UjHBfyN1VfuLsVm1mq5bwluPcLnPIF9KC5An4Qt0yX77x9gBOwR0q/?=
 =?us-ascii?Q?VDdSYuH7ou05cDs0D9gIbTQSzA0yQnbdTw4NDs1/ZtOUjnLnsJN613wNuuCI?=
 =?us-ascii?Q?QoFCuMd1QLo9hJgh2pvIeqLH0Pfq8HRh9bnUg0YRjj5moK20sISb5PN9jqis?=
 =?us-ascii?Q?tsu3QApDui6wh8Z6uRDJi+WyYJIa6syl8bDg2kVRxOQVXeTzkXQpMYEPbC0k?=
 =?us-ascii?Q?ADRybYMkNMZcV5BFG9F/J/JMWODjbNf1Z6PmseiTALcEAartVGSFtgITvz/T?=
 =?us-ascii?Q?XzYflKNoO/u16e5hLxLByrzywWMmYzoMopsT9Kb5C6Cm86T80JCp7Jd8C0jC?=
 =?us-ascii?Q?p15NdJ4IS4BZYHhk3QXSBm6+UvSm7teD6ExxZ/BnSGRclWugEy/K6XKUTB1G?=
 =?us-ascii?Q?6D35s21jvTBYHqHu6PdrpkFiy9wpdF6tSRK7lIwrVeqxHAlhv0mWVfTdGLb1?=
 =?us-ascii?Q?JIH6tC6RJukOdLsrcVxaUYlpfL/BOGsqC9RnloEV+kgQACEwARzshDhgarN7?=
 =?us-ascii?Q?43Lee44Udg/EI8yQ+VE9YLxWmPuLI8tdGcFdX5BeFkHkrhMqS1yD+eNohXBX?=
 =?us-ascii?Q?9gioPbifWITjqwbShY6iA2NW/EFaKeQDTfMp4jeBWLE/a5vG8LI66UiJ1rge?=
 =?us-ascii?Q?rZCoM3IXPipklzQUMkyh1nLpvikDieJp4VDaV5WpTQV2cVsKLBYZQVa/dmNZ?=
 =?us-ascii?Q?QAJ8fYawuOksZ/eC1Lwjb9QIlXUyWiltSNl4q+taBy/AMXShbHsQcpM9OTLE?=
 =?us-ascii?Q?uJ2u0cmHNo1FaGxOZRIDFSAs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1af5af-26a6-4254-d0c3-08d8d9127096
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:49.6188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0uFczlzXfm1qrB8wyEe5JFJ4R5gByw81qg6K5L7omOoK1FkjtQ7LaLDn5fGspzYaoKI3Q4xcGJTl3m3L0ubQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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
 Felix Kuehling <felix.kuehling@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Christian Konig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

On A+A platform, CPU write page directory and page table in cached
mode. So it is necessary for page table walker to snoop CPU cache.
This setting is necessary for page walker to snoop page directory
and page table data out of CPU cache.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Acked-by: Christian Konig <christian.koenig@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 13 +++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 6ddd53ba8b77..c6687c6cf03d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -173,8 +173,13 @@ static void gfxhub_v1_0_init_cache_regs(struct amdgpu_device *adev)
 	WREG32_SOC15_RLC(GC, 0, mmVM_L2_CNTL3, tmp);
 
 	tmp = mmVM_L2_CNTL4_DEFAULT;
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 1);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 1);
+	} else {
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
+	}
 	WREG32_SOC15_RLC(GC, 0, mmVM_L2_CNTL4, tmp);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index c3f3e755d4b7..08c50ce491e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -178,8 +178,17 @@ static void mmhub_v1_7_init_cache_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL3, tmp);
 
 	tmp = regVM_L2_CNTL4_DEFAULT;
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
+				    VMC_TAP_PDE_REQUEST_PHYSICAL, 1);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
+				    VMC_TAP_PTE_REQUEST_PHYSICAL, 1);
+	} else {
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
+				    VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
+				    VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
+	}
 	WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL4, tmp);
 }
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
