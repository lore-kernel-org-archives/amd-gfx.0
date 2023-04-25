Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE45DC6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 06:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB8B10E696;
	Tue, 25 Apr 2023 06:38:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC1E410E68F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 06:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUSN2QFSjv0AwM+7HFurvEdiVoDhmcrP2Ht12AL1r5gy+xyR9iUFHymAwCZLjrjoYoPl+ErfA1C2X4bBBoAA4XWGu9UyMEYOxERANUVICdeGE90hxdGNyHW1dyH3lXRvhdFZ4aUOWXw3/7jeSOZ5BAd/ql/QXB5+9idsBIwZpuo0BWKBAv8MpyTOQTKytxquEngxXnd9mF+/LKeKksdlkXPf3Zsq7nESSlcDRIdthMalnnpX3xepTZA4Z75e9+lDb6jZc2xTLhgqyhEmyYzdQM8OLrWrV/HW3fZaCeNzW8yYD/1B0kmud4uoMsBUtsCFOdUGoM8RB4v0gcAn4JKf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yQFk8vwwOr48SLAbRn3wlkPcoTsnCLstSm9a5BEXVA=;
 b=NK8vOJuJrSBYcR3wNIvG7yUI5ktYYPMvhIeZk06fZc7VGnxLpPC1Fnj3TYHKsdZSyMPN2ZnaaKZgXzrWq5IHEFooM/8QcHqdwdVR4McNex0tzYddsGSgLeryAXhJ7k15ofI13NnXTi9kcpLpF/7AIOBuEey84hIDMPcpPdeUJ1XNb/kzM2Kli8g8rc+bzQ6wbsA7pqIzy66iURsn+RXcnXRJfjZjRGiJz+PiKx678bEjUqwyTMgHBAIcm2oOWVKdgm3txS/zbufdXG+cfuzN7e851uSVpu3okO+X0FpkxitDC3jLt0ONgvDoRyKBVyJ1EmCbbHNJIhd/SQdPcko2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yQFk8vwwOr48SLAbRn3wlkPcoTsnCLstSm9a5BEXVA=;
 b=pBrp7d0xX47BXeGhgf9+EoumNyQYugg5jRDa0aHzeqhRYFRlZopuWOgkZV2D1LKqFfljNhNBTvn+1G0StDkB+fYNRBGzXogC69jxbStWrWSTOEFXkcCXlJaMSv0VgeBury+UlMGsCo8TnAME9BTH50tuomko4A8FoSs5wZtGFdM=
Received: from DS7PR03CA0163.namprd03.prod.outlook.com (2603:10b6:5:3b2::18)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 06:38:48 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::b7) by DS7PR03CA0163.outlook.office365.com
 (2603:10b6:5:3b2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Tue, 25 Apr 2023 06:38:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 06:38:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 01:38:47 -0500
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Tue, 25 Apr 2023 01:38:45 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <hawking.zhang@amd.com>, <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amdgpu: fix amdgpu_irq_put call trace in
 gmc_v11_0_hw_fini
Date: Tue, 25 Apr 2023 14:38:36 +0800
Message-ID: <20230425063837.26701-2-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425063837.26701-1-Hongkun.Zhang@amd.com>
References: <20230425063837.26701-1-Hongkun.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT028:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d84c09c-f273-4778-405f-08db4557b9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UmqrQo1fZykl+q8fZaGtEQyFmd+w2wOGy+Z0y24Yq5jHx3XkR3XKxlWvTN+39EUT8M51AWiRbkE9gqp28P9voOdhEwdvkdajO/66u9t9Hr6g/FPl0WTyxSE5hNG8UUbVUIwOgjCLXZyJlr4EJ7QeSIgDm1MyMeqxVyBBc57cB9zlarcUXeYdJztIcSxo4VSuo4ZEztt4qCdgJZYrZksAsWTwrD+UCFgwDfFn8JIozQIOc5PouunMwoGCqQsViIjRXuCGr/XRUgzfnGQQbceJJqxHfFZsFvckc3qVCLbUrFhwdy6p0XiSk0a3x619butnpz5arOTev12hfjRYSnC5GdDsLiPCq9T57ow77lodPW4tcfhT1MjJLGkDkpfKom61XR2U8ZzYaYFYJNp45KSpULLPEyPYnBOFkh3yXstiDwKP6NPKJwuaTy033NSrH7exCF9jamwFvUN9gYyX0b8fM3F2Sp7RbH/yjeSa4B9Dcdno7Qv8Tia1w84Zgj6rwy/+BEPn+aPFbNdK5YIo3IC90+5L7E6GyARqd0LjOPqh1CUA5jqLCkfcLlvy8us1J0nZrR6O1elkqlx0e3hykE9hlP9K1UUTEsw8wQgC0ERWJyeQQ86B+5Yeh32hz4uXkYsOAqMyNjvjs7n+Q1CO4mxuFwJZrXqUlN/A7lxy8Fs3EzCBh9BGXae3oAKou4RGxnQBBq/UiAXE8hWK3KPwNwnc9vcWge/vO2JDrKBWNyge/E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(1076003)(26005)(8676002)(8936002)(54906003)(4326008)(70586007)(70206006)(316002)(110136005)(36756003)(41300700001)(40460700003)(478600001)(7696005)(6666004)(5660300002)(40480700001)(36860700001)(47076005)(356005)(82740400003)(81166007)(86362001)(2906002)(2616005)(186003)(83380400001)(82310400005)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 06:38:48.3000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d84c09c-f273-4778-405f-08db4557b9be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
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
Cc: longlong.yao@amd.com, feifei.xu@amd.com,
 Horatio Zhang <Hongkun.Zhang@amd.com>, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The gmc.ecc_irq is enabled by firmware per IFWI setting,
and the host driver is not privileged to enable/disable
the interrupt. So, it is meaningless to use the amdgpu_irq_put
function in gmc_v11_0_hw_fini, which also leads to the call
trace.

[  102.980303] Call Trace:
[  102.980303]  <TASK>
[  102.980304]  gmc_v11_0_hw_fini+0x54/0x90 [amdgpu]
[  102.980357]  gmc_v11_0_suspend+0xe/0x20 [amdgpu]
[  102.980409]  amdgpu_device_ip_suspend_phase2+0x240/0x460 [amdgpu]
[  102.980459]  amdgpu_device_ip_suspend+0x3d/0x80 [amdgpu]
[  102.980520]  amdgpu_device_pre_asic_reset+0xd9/0x490 [amdgpu]
[  102.980573]  amdgpu_device_gpu_recover.cold+0x548/0xce6 [amdgpu]
[  102.980687]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu]
[  102.980740]  process_one_work+0x21f/0x3f0
[  102.980741]  worker_thread+0x200/0x3e0
[  102.980742]  ? process_one_work+0x3f0/0x3f0
[  102.980743]  kthread+0xfd/0x130
[  102.980743]  ? kthread_complete_and_exit+0x20/0x20
[  102.980744]  ret_from_fork+0x22/0x30

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 3828ca95899f..f73c238f3145 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -951,7 +951,6 @@ static int gmc_v11_0_hw_fini(void *handle)
 		return 0;
 	}
 
-	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 	gmc_v11_0_gart_disable(adev);
 
-- 
2.34.1

