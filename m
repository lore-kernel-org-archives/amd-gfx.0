Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA66BC4321E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 09:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A93A610E08B;
	Wed, 30 Nov 2022 09:35:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 921FE10E08B
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 09:35:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuDf6lNFdO6dPWQ7EHrkaJkIiWEHP8XJzKHyUw0yHeBRlDji8b7lKjdW5lX5EBWrd4M7hXUAk1Ocl+QleK+u3iaW/pW1d/kf+ZVeFQwFI3QrQ7qTr+iUAfrKfY2gdlZLgmDDAXAkKKd2+lHdf5JLkNZp6tvYR9p2J1IKXZeHxGltehp56Dt693oPjzMyt5c7EPw+GIopSSU8+pvCl67YlU/TFocXw9/EfZrTf99Nck82XSpvjLHnL4I0fiLvOYVy8IPwBnJrIhhrvznKKK1jEhcBAGpFCSfPBR5HCQ5oWQ5e7KOD+0QI6YSDjH3O5mIf5OExzqyhRDbMfXRBqHAHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksNkJgrIRuH7sRqSakm8dzX2PG7BsviwEb75xfcJ/UI=;
 b=SEXDiXKOruN4RuWoxmOk6zNuqC73dqeMT6kvs2phDg29Fp+ByLGVv2nYUEtfUEtJxbkuOYb45rbAFkyKTqp4gZQ6cEflrvOeXdfKyiE/XkTvwUojgQkEMSEJw/eof8mMWT5FrDihKIXd1W6OLqbI/3FkWJJMpRivgsze4PuVhyVbio8OTF+ByfElW5rmaMYUrdmWtL9Lka52aUaX7pRnrouw45o6UEFCtyEY4ISgZHmsofF1vT7aXK1/Yv3ex01JmEIlak/xyaDvJgOlhFmOWY16mzrk3Pp5dBifhkAvCYHhVt4QThLgwwtqp2vSiwJueDyn8hBqKUC00Sk+afnTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksNkJgrIRuH7sRqSakm8dzX2PG7BsviwEb75xfcJ/UI=;
 b=MvLGAJBG2nyIAhdnKVzfYS9lzHT9m0yJcj6itntj6H5b3UVgiSSej84tPmkNXTewDOJVyr1twA4mWnhGhhJds2jKhjxyKsEBaN+EkPHWGXqUFo6NbK1PUeRsbFNDqol229AKqCxdcyg03R4x2dxvDeG9clS/7B9KGsnudLKPmSM=
Received: from MW4PR03CA0140.namprd03.prod.outlook.com (2603:10b6:303:8c::25)
 by PH8PR12MB6963.namprd12.prod.outlook.com (2603:10b6:510:1be::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 09:35:21 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::55) by MW4PR03CA0140.outlook.office365.com
 (2603:10b6:303:8c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 09:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Wed, 30 Nov 2022 09:35:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 03:35:16 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 03:35:16 -0600
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 30 Nov 2022 03:35:13 -0600
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add nv mailbox irq in soc21
Date: Wed, 30 Nov 2022 17:34:48 +0800
Message-ID: <20221130093447.365856-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|PH8PR12MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 9939f3c2-dd8f-4289-bc6c-08dad2b63373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9ylb8J6SKj2si8+cPrgv42FAn5/Y/IGs4bLgRRdej7GFmXbzJlqAQZw9aXXTP/0quaVuce5bz4Iq3/qWjHqeGOEC2p8b5iiHCqP/fByHK9Ldp1+jcq7twmTaWTD4qqsEy2+l/qJcKB7iYF5T9Iwj9vWtSx7xqdXXzec7xd4WZOYD9M4fgRgK2xdD+VBHWAhMlvfvUz/QevcH2eYR5mLfU3xNBtR1PFAt1zyBnmvfbE7GkTIez8/dVVfye8SAYlUkHaGJLhvZ2IdjodvEQkFAEhcAq+R2BfeDMadTqZnRtsEnpeXJ+l8tIJ1oLGyLpEBwNee+plj1/3aMBcj3CZpBoFPJuefVmny9VI1yXj7Z+NBIe7wHqzgh4MEfX/aLHgyLSvMz8nLsOhFvdRXNFi8WrtWtAt8nDqym8llwJNEb7y/tfpsU/hvjAzbqvS62N7Zg6YwxychPtTk1LrveONSlCZhC0yPkXWZn+M214pW68Cd1wxkkSt5+97mC8qsJtJtV2ohyKO+ZPHYX3OjxBBHT0sCGnw0YRS4tZeMBelVuR2yFTc1HlHc3CiDOCyDR16Tn2K7mcW0mBpVEBmwp9BPJSmXOW7CPqJzazK0QNqIcMKlTNIdZpy1GnxDVz1vLqcbaSUZnBQeOHlJfcQBkngQuVUFD557x9Udf45OvaCanUAJQN8YIbR3vpiwj/EamK2Pxco61ADRK4SzC9U0566OikiSm+Vuly3UMeNnN6OoI7Cfj2g+5gWCSnJ3VvQ8uKX1MATacxaYjNMN724frenbuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(81166007)(356005)(2906002)(40480700001)(36756003)(40460700003)(7696005)(6666004)(86362001)(478600001)(26005)(41300700001)(316002)(70586007)(36860700001)(5660300002)(6916009)(70206006)(8676002)(54906003)(8936002)(4326008)(15650500001)(82740400003)(2616005)(186003)(1076003)(336012)(83380400001)(82310400005)(426003)(47076005)(43170500006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 09:35:21.3731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9939f3c2-dd8f-4289-bc6c-08dad2b63373
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6963
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Under virtualization guest needs to receive notification from host to
perform reset in some cases. Add nv mailbox irq in soc21.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index c559f9bfc36d..41b94c824717 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -43,6 +43,7 @@
 #include "soc15.h"
 #include "soc15_common.h"
 #include "soc21.h"
+#include "mxgpu_nv.h"
 
 static const struct amd_ip_funcs soc21_common_ip_funcs;
 
@@ -659,19 +660,31 @@ static int soc21_common_early_init(void *handle)
 		return -EINVAL;
 	}
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_init_setting(adev);
+		xgpu_nv_mailbox_set_irq_funcs(adev);
+	}
 
 	return 0;
 }
 
 static int soc21_common_late_init(void *handle)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (amdgpu_sriov_vf(adev))
+		xgpu_nv_mailbox_get_irq(adev);
+
 	return 0;
 }
 
 static int soc21_common_sw_init(void *handle)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (amdgpu_sriov_vf(adev))
+		xgpu_nv_mailbox_add_irq_id(adev);
+
 	return 0;
 }
 
@@ -709,6 +722,9 @@ static int soc21_common_hw_fini(void *handle)
 	/* disable the doorbell aperture */
 	soc21_enable_doorbell_aperture(adev, false);
 
+	if (amdgpu_sriov_vf(adev))
+		xgpu_nv_mailbox_put_irq(adev);
+
 	return 0;
 }
 
-- 
2.25.1

