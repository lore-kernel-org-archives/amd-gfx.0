Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242A9C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 05:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C750010E5C0;
	Fri, 19 May 2023 05:17:32 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FF510E5C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 05:17:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtSLPlg3crtKXSFdNDkdZfgG83flPysKmrzXXnRi6iuVl9g9Uqr4IPNfg8BY+rYjtdYxgVxim5Bqe6vsMI+V/G8p7kzmVzKW42cIyh5HCEJVbb7uMtz+PuTZX+TIrfcm8VHFC4/M/kRCsdUORpVFaNi2XDGlx1LAlJZiKWyuIYeKCenoemx0Zjw2ZMrPQYcE3r7Ndt7DV9ReUCcQQ+a1iRUp/JXhvWd6rTtsxCcCVNKsRfUvRxaGCE5C8RKP5rF0xJxvw6svPTQAoI/3pALomQ+bmOsn1pMCyBCMgcoA/2pA+26iZqhB1/21EZo445EBs6bIe2HmBVRBtDUTrzfwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjT73xFx9iTRXsr5yHwxAT/Zd3GSj25MpkuUwKdeOcY=;
 b=QNOLmAekmwKlbyNN74zyUVHM2h18qmuLVEgyHesFXa6k3uyzXTOoInwaZV0+Ml4xfCLFI0U6ebU9WHNV5bD1PcUPNzO3UZScoHCMOyzp53ty2wFUbWjPwSZVxpVvki4/173QxK+GczgqrzsfQXvS+MIGWS+r+r22CyvwnN9Y0SPcyhECJEnCeWQV2qcNEckkkYwfXMX/7ScQPZd08SCF1ndQye29iuDkrFYF6CH7lFDYQJnSiR0NSIXEoDdmE77aRsMhMuGNK34ihhxxo2qpkvk3SoqU4K5zmjO1263hSCasTq2mPvr7hrBFY24KRg2n3ZiRTayqO5t6JsOZb5DTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjT73xFx9iTRXsr5yHwxAT/Zd3GSj25MpkuUwKdeOcY=;
 b=L28HlDPRtLXac0pTQjr0Z2hO345hEJHaEP6wwZ3sib03Ro5dECPKt741gn4D9KeNtBh6Glv4iNYSOWzJK7u1gxJOGsSUbra1OQa+xjsHVcQVdqAN8mKRu4oB0i/zbkGZ6cqi4BqUn806QpNDY8cv4z+iktF1PCTEEr0vEIYaqM8=
Received: from BN9P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::23)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 05:17:28 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::b3) by BN9P221CA0024.outlook.office365.com
 (2603:10b6:408:10a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 05:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Fri, 19 May 2023 05:17:28 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 00:17:25 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdgpu: Fix uninitalized variable in kgd2kfd_device_init
Date: Fri, 19 May 2023 10:47:12 +0530
Message-ID: <20230519051712.23462-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|BL1PR12MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b60e00-d540-41b1-662c-08db582856f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rDnQ+xO9WTkOBao3+OeI3kcJ7Tb5/mXOefWGjSIm75v8ee+s04z4N+RgcBmNtdrq8g+KRzmjh46kp6K6mfXeiTzAPq04HXA+RQC8FKKneUyUsv+3WhfmE6YuKaLn6Z0/jlkLE5x02pXpbe0uuzeF4rQdPdI92s4MhgMYpKxeCfRKvBRmjMzaCwn+WY4mWImPfG7bUglBwhNoxFRgKxb86xs6ucy0wI6NvLUgI8/BX/X97VO+PhtLcet0cw/Ue4xr+OOXr9+SF60ROaAgkdnY/LPQXBftgFqRMDrSWI4FSve8AsPivP1H0GwHyCvhyMKiQfVVOQUeCdDioOV7OCfYPSIdg2GjP/TcqRtgnZ095uP4zRnmx519SdZm1WEfIjsmH6z4qnYKkxCLTzJhtPihX80/1HkVwP+5bPtaU0iDPWtLAVU5GzVFQZ17gUNNDrM6T8U+ztOdn9AsXnvKYX6N5wLjjYJp4tXKYc50WeTcFownZO4dLYS7vMOUAz6ttZ7xMq0imanySTcvyl7sZ+P5Y5hb2oDeXUf6hviO1MhsWo0MCA1AmIRI50e4Fjj5/1eD31laNnlu9hi1zOOEQC7JUPeEPxR8MV2InlA8traprUbns112njfFI7ZZIY/Pf3Qe7F2l/8IaCxl1z7hlxCIvT4Qw0MujBolE+MyLzgGqvEB7RLKYPIV0T09DbuStVk0YEZWh6c8e4iy3wqP+Iid9wCt7saqdEj/nGnjHWGivO8U1JCecJfmCQN3Z+UqouvkNaa2wWvNzqybjVC0mFFV5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(7696005)(6666004)(82740400003)(26005)(186003)(1076003)(16526019)(426003)(2616005)(47076005)(66574015)(336012)(83380400001)(36860700001)(40480700001)(36756003)(40460700003)(81166007)(356005)(2906002)(70206006)(70586007)(316002)(4326008)(6636002)(86362001)(8676002)(8936002)(44832011)(5660300002)(41300700001)(54906003)(478600001)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 05:17:28.3709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b60e00-d540-41b1-662c-08db582856f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device.c:613:4: error: variable 'num_xcd' is uninitialized when used here [-Werror,-Wuninitialized]
                        num_xcd, kfd->adev->gfx.num_xcc_per_xcp);
                        ^~~~~~~
include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
        dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                       ^~~~~~~~~~~
include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                    ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device.c:597:13: note: initialize the variable 'num_xcd' to silence this warning
        int num_xcd, partition_mode;
                   ^
                    = 0
1 error generated.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 986543a000bf..e92b93b2c14c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -594,7 +594,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	struct kfd_node *node;
 	uint32_t first_vmid_kfd, last_vmid_kfd, vmid_num_kfd;
 	unsigned int max_proc_per_quantum;
-	int num_xcd, partition_mode;
+	int partition_mode;
 	int xcp_idx;
 
 	kfd->mec_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
@@ -609,8 +609,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	if (kfd->num_nodes == 0) {
 		dev_err(kfd_device,
-			"KFD num nodes cannot be 0, GC inst: %d, num_xcc_in_node: %d\n",
-			num_xcd, kfd->adev->gfx.num_xcc_per_xcp);
+			"KFD num nodes cannot be 0, num_xcc_in_node: %d\n",
+			kfd->adev->gfx.num_xcc_per_xcp);
 		goto out;
 	}
 
-- 
2.25.1

