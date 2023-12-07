Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820F0C4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8848910E200;
	Thu,  7 Dec 2023 22:54:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5731210E0E7
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGLeORDdWqd4trC/gsdktEOw66vE9+noJWRMAv4SMmfqbsvFiGRCzicDJA8nzIPqQh4zZyMdwkGggvEuJo5sN0xKQTHBnwZsTvWRw83QmWHKu9qWa8T9lBwyAGP7Q5YiPyrDwzQLa/hnzywXX+hVBOlZsJYwNyVqCT0xZQ7uqcJw2cF+I3Pj7CoLFAX7ajN2CdMaHgyMGZBGhuzj7i50O5cwt4eCOth7bFhKKRng7bZyKJAhpWTiNZRDjry0hmMGnyl+2XyIyb2iPs8ypzgRR+guw60oB1MQlnC4q9Xd71MNGqofl1iRTWTqEoPgvpsk7LbEOU5/75Gpu7v+B7LVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXvDw49j8UE4zlSf8AOXneaWRU2ZQu0Q9vqc08/BZJE=;
 b=SpErgtMiVTrlnXd18SzGae3xcQu8aV++ecCzBnuQOhFiCzLXmDD2swa0LklN8TSiOKswkuBEb4cePw+qAKo/S+QCcgB+N0b2+x6HMkpbCTxRbYt8Gxb9Czjys9cMJSpt8m0amcsQacALfFIEvzM7gmct0urNjRJuJZfl7dGEIWFfsMtz29g27lOpNkvbCvAZPQqMN/q3c7IceWNSNMJVSLD+FNnsvH8Au4YvALOwjxPZf/fURKY7sDJaZQIzAYM69Imq+o6NjFT7lQ1DdIlaL006ab3QRnUdp8KL6kE98fB8Mqh9Dzt6otoRbKCif3/FTuNko6qWQfCvkxefUazsAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXvDw49j8UE4zlSf8AOXneaWRU2ZQu0Q9vqc08/BZJE=;
 b=3O974wavaz1V12CTZYjXp6DxjgE+mn/8Clq4khhHLUJvLzzNbSAD/d1aJcFHhWeEvwrtnJ966PMh7QgKdmHLG3qkFWffXn0ecvVjscHZJIljqTvRCM9OHm22y7GYbCfDUUZqE++Wof9gTvLpKXc9IFlhP3/LNEP1EVQp4CzymXY=
Received: from CH2PR20CA0005.namprd20.prod.outlook.com (2603:10b6:610:58::15)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 22:54:41 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::ce) by CH2PR20CA0005.outlook.office365.com
 (2603:10b6:610:58::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:41 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:39 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 09/23] drm/amdkfd: add interface to trigger pc sampling trap
Date: Thu, 7 Dec 2023 17:54:08 -0500
Message-ID: <20231207225422.4057292-10-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7861f5-029d-4d17-1b99-08dbf7777f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DexcgfEE38/M9zQbkwr4NviL5QIiD7ynW27HSGWEegcerChzZFspya30b27tSPHwEZxGsWOohl1a+gyZCVRba9qvA55Ndbfi1ouW4o0XBM+hszwH5xxL4rhaLZiA1fv1FZGyABzJg498JnsLs5WH2dDwztnCV18r+pb9kRWmkqoGEATBa4n8En1vcWHlHXYc416BWzObWEqMJn+n/7lWoe6swfVokT7hnNbw5/lOqGfr/sR3kcboWHQLOcwfAWXQauhhfVHOH01b35C1L4KYlZjBEcFDmhsYqu40tcIdgz8D1CkBwjS8UVgEhyqOjkSGYWu8jiOM2Yt2nmy8JnX6OK1x+eUlIpC664GGht/GLNpI/ypGkwMEgiQ4gdrokPE0N8X7VGOMLWJTQRw07YuhekPRpViqG2mQpRcELaAjEemRfCsjOABgXJ5k4hDQO0yzbtaptxAl6XTLf0ka/T8v28xAPS4+ZYrjRVzwot7TwXWD6aRVIPU4egHrocWPHy0QA6Rwth3qSfTlSh0LRHEXdrO1ksr9loIZdiY3gbBDIquZwWAoUBJBli4V+9x4UIfgakxXTcPcm+ch/c6AjjI8a458eSRDz+myiup+w74r3bZmQd/5JN1bSJhU9ULUkZDczon8TR5yUEQoU26a8EhI8lJBe0HlksW8UXqutJnxM+Ij/zkxYOb4BhWaFf6lqu0ulTmgVRDHZpXoRBmG0Eg9Zcp2+UnVbdzGEkKaLensrwvEcYJ9DIpkaW3XBuxEN4FAw4aL1tfaXCpz6f/ejjdcPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(8676002)(8936002)(70206006)(70586007)(478600001)(4326008)(40480700001)(7696005)(6666004)(5660300002)(316002)(6916009)(54906003)(2616005)(40460700003)(2906002)(1076003)(26005)(36756003)(47076005)(81166007)(82740400003)(356005)(36860700001)(336012)(16526019)(426003)(41300700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:41.3432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7861f5-029d-4d17-1b99-08dbf7777f6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add interface to trigger pc sampling trap.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 6d094cf3587d..05b0255aca37 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -33,6 +33,7 @@
 #include <linux/dma-fence.h>
 #include "amdgpu_irq.h"
 #include "amdgpu_gfx.h"
+#include <uapi/linux/kfd_ioctl.h>
 
 struct pci_dev;
 struct amdgpu_device;
@@ -318,6 +319,11 @@ struct kfd2kgd_calls {
 	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
 			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
 			uint32_t inst);
+	uint32_t (*trigger_pc_sample_trap)(struct amdgpu_device *adev,
+					uint32_t vmid,
+					uint32_t *target_simd,
+					uint32_t *target_wave_slot,
+					enum kfd_ioctl_pc_sample_method method);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.25.1

