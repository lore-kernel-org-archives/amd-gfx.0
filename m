Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D21C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 08:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6FF410E50E;
	Wed, 15 Dec 2021 08:47:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD0910E50D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 08:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1skBhB5UOK2vG4gub4XqGqMARZvBSpt5yROk9ewFEl5b9XEG598JRV994rxXY1KVQkSpXAa/gO5A7WzxfVHrcj7IkKE0GJKpt2QPcsbCN3qv56CS+2Db0MKL5/eG7BZ/+ZPLmz8GiZeczxOghGvs+Lmedyqyy7p5VS/uDCsrfqhoYxC30flF4M+BuRdWGVAVWBRuYxk1cIah5XuSd37Lks6GRbqHprwr8IBXL8Tfzpe2aDwCJD05aZ8dQYukaSHwaUXGJDgSreX1n5avLwelIqitQBsNRyiJosvWDskZ3q6aY0P9eQfIiD5YDZuWqiF5t9ZVn+HYD0cHE9aOq9bzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2Ea5nEDFEnZrQdjHFEWzKx8Lbvwh+4vlC2i4KXZTwY=;
 b=M5oWUGuLxi+uQrEhE45bJRv5+jfa++V2N/TMHTzQZGcI7MHgdBlblJaRCkJrBtAmWQF8aL2ZXFjFbAhTPpdFA7A92+zOWPpAiZ9rHcrO0xWYD8cmtLIan+/IcEFjk9+kaGIJjOzaLcCO0rnrIVRpuxvmhtYQmWg16J3fq+3baMFQt5WXgFgDN9UYnKk7RB3iSdKtyrob8ijJC0Mq+ebDYWQYFPn2CM1YFaiqwqtJIbxhN1Oio2TUIJ3ITwTXF8KS1AlHuD/sGXkHjnqmyFQ2UfLoGJ/SsAb2yJUX4Z+LGt3+JVA0ZEZ8po2aJP6/Pl4qVZXv42uW9uHIWW+bq82f/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2Ea5nEDFEnZrQdjHFEWzKx8Lbvwh+4vlC2i4KXZTwY=;
 b=Pf2fB6NDDqIqHfoX60VxNBRYQ7whyqy8KLTXSeYigaZVvYHkDGOxy9OOOVrbMrpUgw6qf4zjl4+EzyMqq+kgzJ8FkfeLiTTU5zyr5y9Afrcd/8avPTjUrsuKWtL4GbaVIaTvxu0r7HQ/frWfBjg07BEaLkp903epSMmyiMoxFWw=
Received: from DS7PR07CA0005.namprd07.prod.outlook.com (2603:10b6:5:3af::15)
 by BN6PR12MB1139.namprd12.prod.outlook.com (2603:10b6:404:1d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Wed, 15 Dec
 2021 08:47:11 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::10) by DS7PR07CA0005.outlook.office365.com
 (2603:10b6:5:3af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Wed, 15 Dec 2021 08:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.16 via Frontend Transport; Wed, 15 Dec 2021 08:47:11 +0000
Received: from syl-dev-machine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 02:47:08 -0600
From: Leslie Shi <Yuliang.Shi@amd.com>
To: <andrey.grodzovsky@amd.com>, <christian.koenig@amd.com>,
 <xinhui.pan@amd.com>, <alexander.deucher@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add drm_dev_unplug() in GPU initialization
 failure to prevent crash
Date: Wed, 15 Dec 2021 16:46:36 +0800
Message-ID: <20211215084636.2133355-1-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2ff5e55-9b51-4ddc-1d7d-08d9bfa77c10
X-MS-TrafficTypeDiagnostic: BN6PR12MB1139:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB113996EA03A3F8BDE1F3849DE0769@BN6PR12MB1139.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12bW7uby7BluJUrjD3Y7NtT2RJDeoI2LuN2joK5M12YVN1r7XXPUIUxJ61D6e3CBzpUhnD1zPAN11Q6yvoUmxiWcKmrBSftEJVgiGg5ANoCGpB7W3rKVhOqx25UR3ceQxWPSEhufykYq5YWGgNLIfb2DlQO5ga54B/Kc0H+fJ+sLEsy3p2Nm+QzI54jvwiexp5T8uxXCdIh0QxFQtzjUonahHKnXBKjvsCFZTYVmg1LCHsTYvJ6z4RuTexZ4gk9yggwmgQukFMmK6Cf9T2nedC5ERf8URgHgBYZrEPXMD3t9ylRdhYN7a367gkiNAvkBtrf0dciW5GYPggJ9AZ/p9KfFPHjnQ5HOOrQEnqH+HyZ8AiFTitNE2H76KblR6E6Ip5NIosJmGhnEmzUqR4xvIL7ylDmfVxL/oD56nhRa2WCiXXkLhBvprIiKvnsPygUqkHiS5Vfk3S/oIeJcVboftT0SNSHEhbXpHoOEp7KkHuo8FwjH3qbSmLT1tsz4lGugKfPNWGbAP2XqLfFSb+yEQvrDRhJfERUjWj8LLqh31vBFziaXFOJYHgVNifUKO9nc4j5ikO2C5CCI/SpKUDSxegZBu20G5PKArycpwhzWfi/poGNmmaSTo8uNMUiYccvH7+lKhd0ywopLLFtEP3upmU2Y91JdwL4o3RA8NVhgBUr/SjbN/6Funk1MBAMRwXamHW4/jXXqCFAahTeCuI6Fn6LRM02qx3FX8lwrOuD4oM1A7btmcITrBF7hoe994g0Nd+NUtczWgBYfZkllpqgYnhjtI5PeGRzJNjTIYoCeNtoKzILEVBok9fErD2Fe+UqP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(110136005)(54906003)(8936002)(7696005)(508600001)(4326008)(36756003)(70586007)(336012)(2906002)(8676002)(82310400004)(426003)(6666004)(5660300002)(316002)(1076003)(186003)(83380400001)(47076005)(36860700001)(26005)(356005)(81166007)(40460700001)(2616005)(16526019)(70206006)(86362001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 08:47:11.0572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ff5e55-9b51-4ddc-1d7d-08d9bfa77c10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1139
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
Cc: yuliang.shi@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
In amdgpu_driver_load_kms, when amdgpu_device_init returns error during driver modprobe, it
will start the error handle path immediately and call into amdgpu_device_unmap_mmio as well
to release mapped VRAM. However, in the following release callback, driver stills visits the
unmapped memory like vcn.inst[i].fw_shared_cpu_addr in vcn_v3_0_sw_fini. So a kernel crash occurs.

[How]
Add drm_dev_unplug() before executing amdgpu_driver_unload_kms to prevent such crash.
GPU initialization failure is somehow allowed, but a kernel crash in this case should never happen.

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 651c7abfde03..7bf6aecdbb92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -268,6 +268,8 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		/* balance pm_runtime_get_sync in amdgpu_driver_unload_kms */
 		if (adev->rmmio && adev->runpm)
 			pm_runtime_put_noidle(dev->dev);
+
+		drm_dev_unplug(dev);
 		amdgpu_driver_unload_kms(dev);
 	}
 
-- 
2.25.1

