Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAAFEB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 13:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB78810E2E8;
	Tue, 20 Jun 2023 13:30:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6130F10E2EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 13:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/pWexibW2qQigMCp5NpU4BUkJJCuWdak68BoCOG6o08Qz58mIIN7Eo0kFJhhJBJac4zSVkdkW4utOPCBLXhTuWzfly2kE+1xsS19uSgYLqqcmPO7JrkCoT5XtBVMMNN5VdGEAHbrZUSXu1sB+pDFMbR4h+ZGg+FlzSwQG1S+25ioo4lYgM9QT0L7xT2oeafm3zji+UrTfu8QBOXewFJ5bEbusU89oOP2vZcRS4hepIi0Kn5uVSXxu5ZaCZvLS76ye9WxP8N+CGcjrTyIJ7rZOjdfS56zSoxgpr7lKfNcjbUY6Db8HVMcohAHG+3Gbow15xFxXUS+S8Y9AXLfVob6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uigS1xvGBIVe37NpW/KgwOt6E8atyXIbUwDX2LhBP8E=;
 b=lY3ME9WRhiIg35D1YTOxyWyyErilJNc6/yfr1GuHv8JfaFqaT9TF+QqCMXuNH8e5jfv4VrN8h7bX3RnW4g7L5wiKjin3llfC/eHT3xxeMJQi3TEKK9OrhuHnneOwtFZt+HetnHqUGMAmKWbJJx77ZdU+VKx+xV8UABADTUvdKJuHjGHjw9zLiKavCA6CwvqWVNSn42oIiTXwzNvqVSyJ9iHjTigT0mmvKesMkH5OSN6e17n9mO4eWXqtaWMyqhqHOLf3+ECvfCP9pOKcXAAQBV5qq/2YZorvFq6H0MVZYNzOeezMWm5s3U/wSNs3cuijYaHa0zYlUcbwRb3ZKXpXpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uigS1xvGBIVe37NpW/KgwOt6E8atyXIbUwDX2LhBP8E=;
 b=wOIRGKotXIrDfmBNoncEBezD/SvdMjwKICG7PlfRgOB8WfphNjt819yLByayc4xPQrN0RlKLBg2Fbg8sRqRJMRXjwAMpRHWz8lQCAqgonGDtUL0TFpzLR/Tys43t/k2zY6Ia8rljmKBGCDFt3kMO+HK/JDLDelzdWLyOG19LcJQ=
Received: from MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::8)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 13:30:03 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::9a) by MW4P220CA0003.outlook.office365.com
 (2603:10b6:303:115::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 13:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Tue, 20 Jun 2023 13:30:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 08:30:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 08:30:01 -0500
Received: from horace-sm-debug2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Jun 2023 08:29:59 -0500
From: Horace Chen <horace.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Clear VCN cache when hw_init
Date: Tue, 20 Jun 2023 21:29:50 +0800
Message-ID: <20230620132950.1121406-1-horace.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 86316bf8-2cf0-4a50-3978-08db71927416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daFstgXF2IvPqnLDfW9dHnzYilMeyFduxtUdHB1eoKG4pgfatmcCbu/fM8KJe/OJk0PFtS/t7Z/lkBNoPQdkB+SAsh4kzZgYLjZefpDo2f3lLg38g1OkTrFypQ2SA3AYicfa5HLynOoYWZinhBGOSUz7nEU1wSYw8qSFM4pr4uWwrUp9y9fgsN6ucoLYZrAM+py/bw0ykJ/SMAjQv1wXGNdMPDVfcp9sjwlnfBP956GZijGokyt7/H9u8mvRfSC5jx9dMKYSckOVAmVbZwnHxO7XhppncT1yBt9aCN9rTcJhf8ELtcLz8vAtOfvKC+BmCJCNUTzXkdF5I7q2ixL783HbFQVwASQ+alsZb+yuHm+pAVPjiKVysU7jKk6MKPS3JYj70GN0EHhBqshc/fN8cHPXCDTP5QQ2D6YYAx15S4AmbO1p2Pp+wPWKBKyzFYy6ULqhPGwnuW8Zwb0ucdsnouP4EbuLNw8rQWyJt6HmnVt76nL/Z53sWvSuDF+ydptqzaQbO8DA3F0KjAyCpl3Enr5zcR1/2NviRMoBg3mkKAtvpta7szy7ZUNAdkJ8mQBo8HyLi+hU2bjnD0T27Fpj7wzcKSXIH8fubns1CchhnFeivPltvh5fRsnqBsfseWYkLGLadbst9+sP0fe4wGwBkZcPJrkMY1LXj9VbziIEcdNv0PJaiWNXgNXLisPramn47q4W1LU6nmWmziQ8i9mMrvimPZSk6z8pJAjTZ1tf6KKoS1Y6nYSIrnxJQCUNvDbvKcO8RrV+At8yhi9edUeKfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(36756003)(36860700001)(82740400003)(81166007)(356005)(8676002)(8936002)(47076005)(426003)(186003)(26005)(336012)(54906003)(1076003)(41300700001)(316002)(2616005)(6666004)(6916009)(70586007)(478600001)(4326008)(7696005)(70206006)(44832011)(2906002)(40460700003)(5660300002)(82310400005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 13:30:02.8115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86316bf8-2cf0-4a50-3978-08db71927416
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Haijun Chang <HaiJun.Chang@amd.com>, Deucher
 Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
VCN will use some framebuffer space as its cache. It needs to
be reset when reset happens, such as FLR. Otherwise some error
may be kept after the reset.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index b48bb5212488..2db73a964031 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1292,6 +1292,7 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
 			cache_size);
 
 		cache_addr = adev->vcn.inst[i].gpu_addr + offset;
+		memset(adev->vcn.inst[i].cpu_addr + offset, 0, AMDGPU_VCN_STACK_SIZE);
 		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
 			regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
 			lower_32_bits(cache_addr));
@@ -1307,6 +1308,8 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
 
 		cache_addr = adev->vcn.inst[i].gpu_addr + offset +
 			AMDGPU_VCN_STACK_SIZE;
+		memset(adev->vcn.inst[i].cpu_addr + offset + AMDGPU_VCN_STACK_SIZE, 0,
+			AMDGPU_VCN_STACK_SIZE);
 		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
 			regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
 			lower_32_bits(cache_addr));
-- 
2.34.1

