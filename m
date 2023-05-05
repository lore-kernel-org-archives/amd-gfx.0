Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADDFC77B75
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 06:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C07A210E575;
	Fri,  5 May 2023 06:39:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E2DE10E575
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 06:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNt/WxN2qMgMQhpHbG62rXYSTPGScjiDTuTADJ5bKfxU4lYDJMSf9PSYxGD6HsHp2clZr/1rYnJdfjsB++lWvtoKvCWEb+X9/1S1jkaNhHVBzY4u7Ia3wKN8OfQ8u6qsccj3q9eF/XDZDG3QcYcMiX+7RBFR6vnJYOqUr5LIj/2BVVQ9BMw8q7u1TpSBWnR7/KmOj/U7yNBQAEcBDPcYWHpTrClfA1xrQal8GV3+/uCSTqUmOqBBRB4DhVtnV7PpaROv2ZhzfyVHCpJfMuylCts85MH7+BK3GHhRzat1f2tPNPxi/jiSg6cK6Dv8i9VN70yYr1x0vs0/443ieJkRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W8NORF6+xrbpjO/DLAtMjVjEx5J92Fjkb6p8UJ/YQo=;
 b=HhZ8av/Kp1bo5LIaY/XQwyHtKbVTngkZ73y7DLpvmprugNQo61/l0oyrvzNrEtYk6M5VJrkI7b5tJ1M7DCO7Lc1EwYdSNAzTwJINgVlGMmhwG86oik856sd6M/lcyi7BRvat+62pgjq6rNsW4qIu4BA/tzLPjd6rcgFTU4GAGv6ES2Nopqf8OoWBeUv83RjHctniC1RWlzDHwzdJZ4IdOfoM9DjNPksxz11IW67mqS8T8Yw4zWlZy/L4/8rS9PQ/e9+efTnx8gQ5CqPPhP15cuV4gFW+0/Kr0279O7ru8Y7+MaM7u0eexZJJ3l6RdVza3arzTK75EJH7mZqbft1Xag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W8NORF6+xrbpjO/DLAtMjVjEx5J92Fjkb6p8UJ/YQo=;
 b=awDlg82bBLOutQu6Krf+x7laSJTHkiplWaonWzyO5QAEBEz/Z9EuTy8xUmDNZJscRMioTlI/V9xqWFbyyo29Z2PHb9PouZMl4tm1k7OkijblSpQ22d4OXc8zSJA3JNEVN76ydhU0QiklOrJICjL1R7+SD+adiLpfngCjJs45AqQ=
Received: from BN8PR16CA0030.namprd16.prod.outlook.com (2603:10b6:408:4c::43)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 06:39:50 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::81) by BN8PR16CA0030.outlook.office365.com
 (2603:10b6:408:4c::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27 via Frontend
 Transport; Fri, 5 May 2023 06:39:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.27 via Frontend Transport; Fri, 5 May 2023 06:39:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 5 May
 2023 01:39:50 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Fri, 5 May 2023 01:39:47 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: set default num_kcq to 2 under sriov
Date: Fri, 5 May 2023 14:39:39 +0800
Message-ID: <20230505063939.2485298-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a74095a-7791-4336-e1a3-08db4d3386ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZ/pohnJMOspRUzgXkVpcUE8A/LPtoDqn8UUt0irNOfCkRxyPZDrIs9XA8VnKSmfhPc/F2VQgWfVhNmdowupCE6kJSwfSyUokmzW/51pv28eF2SH5j7vk/k20MBdwyB7GbetYaP9Faa1tbqjR10vhhfPLQp68aWS5WlAzsY+32GS/W78tQSTZfZHNoqujtiWR+T7u63nMT9jDdJ0E3WhWMW4nMVv1EGVYfbxLXmooTCe7KjPPtD4T8x6zZrK+8BO21VedzaNhURVqGVtfMDuH3p7hSWkIECfCKUl3ZReLeCMr9Wq/a4laQFeOn4pDJDnGjKMbKa1SfC313UeIzoz+faax+bFfi9yfqjjzFC/WGu1m+ElWB7UpFuQcD86DcvArQAslsU+3gGwD7RbiEeb5LDBjhauzFzJaH1PNjEpNSlSC1I+6YRmfh0wj0wBSZ0AN/KTHyucGMy1T0ALhblxqFHzD8hGTpZahgwzHH7yRasGbe7+D/vgg7beF3KVFVHMlNeuxcyAk8LJrP7iPCTscnXIy9sm3uzBQyWV+vuBwWIw5uAFUR0OmwRDVrynZpPJ0fIS7uQdNDSGZqsdncV6V3JTtL++oqcDnbcQsb9MKR30pMLKEpvW/Efrt6UHd7x3uoa9azsjaQBLGMeJVTxzCplA6pZbMqnbGhaAbHh1yvXon2TuPjjvugGTD794D42uJWi1vk6rZRK66KnRXCltJQ15ds64YLKBOZ+vtgZQlNs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(356005)(82310400005)(8936002)(36756003)(40480700001)(426003)(336012)(1076003)(26005)(8676002)(2616005)(316002)(5660300002)(54906003)(4326008)(478600001)(70206006)(6666004)(6916009)(70586007)(41300700001)(82740400003)(7696005)(86362001)(81166007)(36860700001)(186003)(47076005)(4744005)(2906002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 06:39:50.4799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a74095a-7791-4336-e1a3-08db4d3386ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705
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
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The number of kernel queues has impact on the latency under sriov
usecase. So to reduce the latency we set the default num_kcq = 2 under
sriov if not set manually.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 1311e42ab8e9..d0ad7cb0fa05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -68,6 +68,9 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
 	/* enable mcbp for sriov */
 	amdgpu_mcbp = 1;
 
+	/* Reduce kcq number to 2 to reduce latency */
+	if (amdgpu_num_kcq == -1)
+		amdgpu_num_kcq = 2;
 }
 
 void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
-- 
2.25.1

