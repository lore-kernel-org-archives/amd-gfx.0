Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C89E8B364
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD3A10E35B;
	Wed,  4 Feb 2026 03:06:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hsijlTwh";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013016.outbound.protection.outlook.com
 [40.93.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE5710E34D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:06:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f59dq9NO+tjDhaApCG9T5c7wC0kSRJDRl5hif9zCZMG5uzPfpftdLBi+VD8l6NRtwmvW+S9uUmVuo2/7YUhIbG2nkPvltsSx8Dhbrr59d52VKed3+6VyqOAmygMN5yts/WTDY8mo9nsKtqdyVqc+xs68ElsU8MqfKhpbbJhOInJFfkRJRCwvBjDR5e9PuM2RnMcGpZjz6WBorgpHCT9cxyQ68IpaAimJdhCoMdIuJ0beVXKax/0pq4NFFtK0uegJziVC1UuaDTAgR+nZgnv5/2xxe6AGC6XxnR3G5p0F4qFElqkfVm6Wg7eVbbU3kl1lK0dn5y1CsmXCJ7OQ2Cc4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztvhdTT7bIccl0qa7+xZhhnTOZ3G3IdTxXzRGzY+o6c=;
 b=TlSKNY2k/Oph85WvGmPTfmqXDK7beu8UGILPxEurUv0Jk0nsqIW3vjtXSlvgeVP7hnUZx7tLz7J/lwxwDOk0RVGdHQvMSw6xQwANwc7P6Ii7dm7TXhVYX4FkNXljZXKxdRi0HPkdRS2Aid/KwaNUUfEovivh+YVY20fMP400/6VMcF7XObkhjhpuM3JW2uTBq/Blbmt8rKdrpo5XD+kcc302O0kvT1X5HWzAz5nN6no3y8D6WRa0xwkyQQQsosq3y7aBua5DGO9SYaT3cggA8mPA73gNcLaCPuy45hhjBvuBtTEALoqYKrFikFuWmcByaHr9ttNKqkDRKXbqF7D0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztvhdTT7bIccl0qa7+xZhhnTOZ3G3IdTxXzRGzY+o6c=;
 b=hsijlTwhtnjO8twQIkx2PK1JXU7ivcmRiMKzgmc3NwoAFrMaRx4tvbZLye9/Pae9SmQ2CHUwcyyCJlpntpVq8tHcU+Lg2zhfbdGe86tFVzPKPBYmCh5HqiQIfzTEejWtuH/kj52LbEw74/+ClSELRCln0nTHMqPtLK7HL72IMFc=
Received: from CH2PR18CA0012.namprd18.prod.outlook.com (2603:10b6:610:4f::22)
 by PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 03:06:51 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::e9) by CH2PR18CA0012.outlook.office365.com
 (2603:10b6:610:4f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 03:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 03:06:51 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 21:06:49 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 04/13] drm/amd/swsmu: Add new param regs for SMU15
Date: Wed, 4 Feb 2026 03:06:11 +0000
Message-ID: <20260204030621.33369-4-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
References: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 256fbb0c-40b3-449e-4608-08de639a7181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IdvMq/TfL5DvTmCavyjWTSgWzt2SrSwYO5iIdT7d9MOnH0ef9d6LpbBqOiMI?=
 =?us-ascii?Q?B2YXlLxYr8qqOw4RLTyyfcfZhf0BNrK5e1RwxKYpvplj4gcdxxR0QcfiDWpE?=
 =?us-ascii?Q?4UCjPzdJhnE/AAsohd0Vc3CxVdMkHAZgm4DCWlDi1OB339s+rk1mbPy2zX6W?=
 =?us-ascii?Q?1duQyml+FhWE6tUciuMiqrILEpQgBdhRHnyPjbTzUobqiB5eOIElPRIYjRmz?=
 =?us-ascii?Q?0abYxYsB8hXgZ2rZAssx9LRWu7eMi79Cpnt/PXLw3cjpNzkNic1qrBFBqtoU?=
 =?us-ascii?Q?6Js1dBdjMxDNmiT84G+UEpHNmNp07zAPo0IDlQmJUttEMUbntymYpnZ6Mszy?=
 =?us-ascii?Q?ytmiw1zGwPZs/JvZliHf0shgK37FQS8NmtC59OZuYThiaXotW9T25CWb8QJQ?=
 =?us-ascii?Q?kq1GIkKNLd77FT4CW47Yuez3x80YG7JCsZrmgzf7PQJCdqYk5wRCFXmqLGaW?=
 =?us-ascii?Q?fCnDQGfh4DNIRr2e/ut7r3roVysijuB9YFNseXO5PK90NVZNTTqTjfH2yCwI?=
 =?us-ascii?Q?X7Ou0dOro9b4vakvuoPwMHIEcnbBE93XXLsPkYxX5LBjVjQOrQggTN9e591T?=
 =?us-ascii?Q?rz042nPfPLbFPERA1TwnAr0SNnnBHc6YWOH5McEimWir4sOa6vdqfouD4AD6?=
 =?us-ascii?Q?m2yOQJ5aG6PQFfyXdJIqQmFV2wTtF8UmhEdHh74zfZzVo1of2FsnWkw+ELbF?=
 =?us-ascii?Q?v2/MjvVLHVFrkMIkEmoxRjJHkU6N5IlthVZ3v0dDN34kyxFYQmKpNtOhc1jx?=
 =?us-ascii?Q?mZHx344Jx+SstqU0WFNVYVWntRbmjKJZnrtraeodZFHijLisGrm589UElSTP?=
 =?us-ascii?Q?ijP067w6B3ks/2I8e67KKSU7LOk+k73Uunx225kbTJrr+SGYua2ufyfYvpO8?=
 =?us-ascii?Q?eFyHwH2NLaIoTkU4bGh+fu7ruum7KzA7XvngL5tCeTN1m9Sd/NdwIca70R8p?=
 =?us-ascii?Q?MzXZu2Os2gOHB4gEpALVSMDOQEABFZ0xH7yLO7TOsJsjOb9xPlM5k7sK6Ur/?=
 =?us-ascii?Q?1EqbsMAX/GBPGJbDxv+CYzwG/k346YYH8Rlb51gywHmFf8QLeXZAN8CsVcND?=
 =?us-ascii?Q?iGcxOvRacDjBxO/q6XnLvNcF76Mv1nsAyOMk3l7C7B2JBqj/+Hkg5+D09/EO?=
 =?us-ascii?Q?J5AvYOywwlS8c3vAMfIn4QdXkRS9Ull5LITevPQVTGGfewgAbO4MqfQkteMF?=
 =?us-ascii?Q?y7uZk79X/1d+qvLoKIVm9sZjCcMuwAGlPwfmfZyyVZboUSpUd3tf3IhPMuNe?=
 =?us-ascii?Q?/4/EOnm/ZingoT5WhJbp1EUY/AxxaFmTURx/tRCh+ceB7PiwKxay28yGMrvv?=
 =?us-ascii?Q?yzflIVdu/abHDMa0ONhIMHT8GgYXEIxznT/4DcF7Oi5Q02d4QIBy8IsKXn76?=
 =?us-ascii?Q?o/WROz6PWXf+hOHwZ6xpwdxD4Rw6w119zg5lILhQLKmSh7TA/+erBJnhFhj3?=
 =?us-ascii?Q?2ZKv/8orpDwqhcFeUpXQ0P5eFVXIvCibgWjn2ZQAnSuMuR9hk2ctJxJUAfyW?=
 =?us-ascii?Q?t/S0Tvb7eCWsSZ6pVhPW8ygkYF7k5JW+2Ipu44VX5ey/z4YXIclG9EtHfky5?=
 =?us-ascii?Q?BsfVn9PuHyZZqxACC3w10ALg6RqbwqvG44BW0HjY9CgHhCkjyFXAS2Yf4BF6?=
 =?us-ascii?Q?boN8d15sfypCMHoao5NpXZt4CFdj/QRULdd1/8ZHeFNZOfitI9oauNWTO3Lf?=
 =?us-ascii?Q?38QG+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HU8i5m1ifRtFVApqhG6Yq4MPbsbcJBt1Ujfix3oJTaVakZMXnanURrwuTgtBVCWchultogDC0W2RRri5ODwidtsZ9C9trejv6IB0vNRGygG4RmVFOVaVD8/OW7DJJoYzD6IHf1f25f6Cq7oDJRmHv/FqsEAhPaSueLEyecRw5maYcYnNXn1siSTET0qbUVLn9H/zPFXpdbJKXJp6GU1/4LpuOg7x6PznKAbIW+86bAUNXRoB4TIYrtmjyibODfxuhiABuVL666BrznmyjFUakCQMO30xSY1Bi+iQ+cAdd741HlV2mPhXqkUhVPADZTBGjH7XYtwF3qTx4tVs4+Yw4Shm7YtytCNWL+ybttB5kIhD5zhFoGv3o2aAEjdpZYPf+bSjiEyU/z42WQtFVXS62Wf8SP59m8tWGKylymEkw9ijHkPYo54nP4Ss8RJEw5H/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:06:51.3070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 256fbb0c-40b3-449e-4608-08de639a7181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040
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

Some SMU messages have changed to multi reg read/write
Initialize during smu_early_init

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index c3f22844ba2f..d58b0bc2bf78 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -52,6 +52,12 @@
 #define mmMP1_SMN_C2PMSG_32			0x0060
 #define mmMP1_SMN_C2PMSG_32_BASE_IDX		    1
 
+#define mmMP1_SMN_C2PMSG_33                   0x0061
+#define mmMP1_SMN_C2PMSG_33_BASE_IDX                  1
+
+#define mmMP1_SMN_C2PMSG_34                   0x0062
+#define mmMP1_SMN_C2PMSG_34_BASE_IDX                  1
+
 /* MALLPowerController message arguments (Defines for the Cache mode control) */
 #define SMU_MALL_PMFW_CONTROL 0
 #define SMU_MALL_DRIVER_CONTROL 1
@@ -1347,7 +1353,9 @@ static void smu_v15_0_0_init_msg_ctl(struct smu_context *smu)
 	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_30);
 	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_31);
 	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_32);
-	ctl->config.num_arg_regs = 1;
+	ctl->config.arg_regs[1] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_33);
+	ctl->config.arg_regs[2] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_34);
+	ctl->config.num_arg_regs = 3;
 	ctl->ops = &smu_msg_v1_ops;
 	ctl->default_timeout = adev->usec_timeout * 20;
 	ctl->message_map = smu_v15_0_0_message_map;
-- 
2.43.0

