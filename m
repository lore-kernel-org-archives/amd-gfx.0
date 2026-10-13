Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D82CC6B12
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 22:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 290F310FA0F;
	Tue, 13 Oct 2026 22:31:19 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B5BD10F9FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 22:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpjNkzv0DMkITHo3dnxgowgcSq4RluF/vSmiK/uqNw12Dh0vDW1PZbeog5lGDCuIgDtKtnhcHS1i8gPW5CrLrSNvKDCHk01647X1W7Jn4QJCd1yV2vEpbjPh7IXqAO60+G3YQCntYRVu/UTLYyw39Mz3EXKk6T0ol3M7bRQ5HpblX2OHHGpVl2HewWo9xLADmrTFeDv5gifg4CXiwSAUCDT60F1WEZ9rI4lF1DvzNrrV/d+OYnhH6XtIBa+/x18XmnaYm0org9M8BvWBhTaAzD7ILY1QZxUo7bro4f2WGCvWdG9TwI+lKBikqC+br3awlkC8TGDp4u2AlSxEHFwy3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21/EOM0FvRg47VlOXVwi1kShPkxczbwJuQzn+Mds2JA=;
 b=BUXFgMSXeD4wQiyJ8us4DxKdD47oiFHB2YQF+szDgV1CSXdFmzmRAaL/pY8als4YVCaqwHwEsyIiyN9bEg7BX4Ffk2thXMY89D/E0IlQHLqFesZPDjhxckXGoGY97eyVxAEx4QxW9H6o5hBoqJj10hxmpo4RJOBzyHtQeQYhBAmql1DSC0VvARxkE9kR4d/nVLk8nhme5Mozs6lYBwVmzNwewsQM8LDC0Mg+nFM/+9MtPPn7QnlMfpQYIlYZw1YA1riUlHFmOW0AM8Q2u+hYf67zAaugSw6lUXMjTFSDxKA40UdZpqGtrSoxj808NvVDEVgSbR2bzt3kfjCMFhZO+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21/EOM0FvRg47VlOXVwi1kShPkxczbwJuQzn+Mds2JA=;
 b=4XorNYPmPX/0QB4BE+LMskdwUJzjX0/vnTmpj7KTr1Z8BY8CHtGiyh7G4KpWwqMM/GOVM1DtsD7g9fZFcmF1ZECOarBhHfeyvPwrSsyn3Y/u/yu3+DdnD134UnPe6VY04nlU/yR7iC4DUenDZAmf86AcB0MyNHlDir5VEJstFW0=
Received: from BN9PR03CA0297.namprd03.prod.outlook.com (2603:10b6:408:f5::32)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 13 Oct
 2026 22:31:02 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::2a) by BN9PR03CA0297.outlook.office365.com
 (2603:10b6:408:f5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 22:31:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 22:31:02 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 17:30:55 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Zhigang.Luo@amd.com>, <Gavin.Wan@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Enable queue reset for sdma 7.1 VFs
Date: Tue, 13 Oct 2026 18:29:51 -0400
Message-ID: <20261013222951.763992-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ca5bdb-8557-4d7f-2e92-08df2979a97c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: YNTQnQqrYePGdopxZOyfHdE43mSEK9ShsvOwilvFJVQ+eH/J0nRe0kuZZc5KICrxYdBb4CEU9gnhJmgpycbgVOU2dT4SsQGG+FxJQVqioVUnmA6H1YcXz2hWB8dZoivkT/+MqfvFrBX/PI3C+WhE9XlM5vRYR70uv74f91gtU4RciOq19KfVN9a6C9qR8eYYOz2lbn878dsgEatocD4LzGucyKskF1N2Mrm4kHIsVnL4qvOcn1mT8q3KMoud1AGauF3x6hhM70cN+Ll+lH7f3PwrtuAr1DX3Dvao/n7sBcJNKjOB9lgpe5Gl1x2LgdzCqqeXiqhmELXiAb+LOGR1fQdSnbCqMm5kjRlzF4nXXU7CWpf/CJc27RfBHnqwMaq8aDDTC8YQRnhR5qcHwVVMJW/RGOr9i6VEmZ2AdNk9HASoJtFezAL5C2YPf8+LW/NMBx6GybjwG83syfx4g6xPcN65gCvv4BoqiWjBYVZ+CVr/DoSIVXf9XRMYIW9Vi0RwzBJz8KEekpYm52LQhaw1cdlDK9n3u6zt2wdF+K1TGZK3oyN/wz6x5e84Y2gCwyEvRL5qcAhYmRiVjggnUI38ZJGbyFLJ+Hf8iT1Pn44D8iFXt3RGdIuIVY4SP3cI7s6HodP+3y8pPueYpfza4rXCpCJ8Sa4T0LwgnUpic3lUDOWDcDCYXweUFl7VUeRRZWQXmcGNKuAg6/aPEQhsvSJIgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vtL+a1rDcM5e99fzPPn00/LJoQuUM+ytNTaxM1vV4mHnl3ssHjfdEXVmGerba3OOQrnzlQ6t0LCmhKQLrk8zQSfNbz2oT54bNIWqvIUsWoMqPOUCz4lf7gXOe1N2ceMea8tdwDfM8nSl0/uR1bzFAVUvuoLdaK1a3rtkqREqn0TyM1B2Eqh8oPR/R15NEB1rsmkf1VnHfz3if3cGr0ik7DlazkTK0LhOV+sBmZip1vk2lK4piOpIMF2kKCgxOMyhqaQ1qKhhFFqZMUP3ndjCYuw0sM1gXbT2PE/yV3hP7Pcrj90H6IqzxR+qAlddsLAKpAH8a/JsN+jYf2Tctae++vZmC0XylQdCpEuFiw/3EbTJh6mWIFMfZiCH9AvvWzA6Y4ciVFzZxqsfC5tkdlTgV37S51DQstUS6tyOTGQcaGnCYfHGxETSrLwjPAK4XU0+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 22:31:02.0764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ca5bdb-8557-4d7f-2e92-08df2979a97c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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

VFs support same SDMA 7.1 queue reset capabilities as baremetal.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 21882f2cd2ae..6bea65622086 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1333,8 +1333,7 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block *ip_block)
 
 	adev->sdma.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
-	if (!amdgpu_sriov_vf(adev) &&
-	    !adev->debug_disable_gpu_ring_reset)
+	if (!adev->debug_disable_gpu_ring_reset)
 		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
-- 
2.34.1

