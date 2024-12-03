Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31E8E74AC6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 17:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9729E10EADC;
	Tue,  3 Dec 2024 17:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5a056lZc";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 755CD10EADC
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 17:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlT9jpX2htKngM8smEGXdckk+Yvnir3JV9+/JaQdzzSvHlYuKjxm/3T6qRxFji0UCeQX/dD0f4gNAEkA8+t0nblzzYe9o6nxw76vgr8k0JS4oYHPyON79jYs/o2kFX0cXH6oEvWbbmyUo8qDYh1YkhkB/jY/1bV0tdkXrJoYyHZlhbDOgFIMys1hgBp/TnGk9dfpvinZUyoZTje8a+ffOjksftwyB+5w54tzoYwrsEgOJf9y/xtEJPR2kGEfv/zRG8+1YxJVKEYAU9V63jOugvAqP7PJoxLU0dxnWdvxDrxKcVsP0GjF8VVWXlSOw+K8NVCjiJQ1+O6vy5wtPbUUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x34negbYu+WjHFg1FiHh5Yu8NvLcVfYR9VYZsC91Qeo=;
 b=VucOoo49PY7lIUhcOs5Sv1rU7Vzzj00uY3il+ICP2DS1wRcyNCmV5paU31Fk02dCJ4qA1Jm2nR0BKUC4nheGbh10rbaexnwWPLysn4hC7XCzp7RZbhEkDflNKLIy4N6vNPtYzfBlUiWjOaebNVeALoytVspnTlaQOJY7ARTZPJYPsdX+UJdgXC5YwUX1y9H3zUP4BdAFo1tjv4VSEZlAvWgcsKAkp/PUKc+NyHsNrWd2CmXslXlKRNwV0L0iaK7z6HmJOq2RUK5nl5eJdHxASQWQmezoCanflfh5pQF2RwBzQZt6mT423WQa0M3k5qPEMF6m03hIAwb6PhANyi6Lag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x34negbYu+WjHFg1FiHh5Yu8NvLcVfYR9VYZsC91Qeo=;
 b=5a056lZcI5RVwJoWPe+nwRJTN/Sk5iJE1w05xiFmq12Iij4YyeTHnY87TcV+fF9ckZNWkJfrb88fQQDmDtEgmf7m7kySao/px1o3ounaGE+xETqInTVFB2HeHk5/KXQPbM6TLSs7sFLCpYLm2ASOCgoOrUdK5oQGTiCoffCahV8=
Received: from SJ0PR05CA0150.namprd05.prod.outlook.com (2603:10b6:a03:33d::35)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Tue, 3 Dec
 2024 17:29:30 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:33d:cafe::17) by SJ0PR05CA0150.outlook.office365.com
 (2603:10b6:a03:33d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.5 via Frontend Transport; Tue, 3
 Dec 2024 17:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.1 via Frontend Transport; Tue, 3 Dec 2024 17:29:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 11:29:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Amber Lin <Amber.Lin@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add ih cam support for IH 4.4.4
Date: Tue, 3 Dec 2024 12:28:58 -0500
Message-ID: <20241203172858.2831134-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c50651b-5f24-455b-6da9-08dd13c00ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VmRWFcUQ6xR++FhmYT3sepIJ06PsNF89kqGBtUw+5imQPRDLx3Nz9S3M7xTC?=
 =?us-ascii?Q?6Y+blQgBpeCZ7ac2bv4CVkA38s1juDIAZg468sWTd3iSZh7xO2EejMZyIOH2?=
 =?us-ascii?Q?yMDIWiR6MumpZ8OMFUulh1Z1NPrctxQgCiT4Vs9XhE3mIU30/DmB+ENL9mDJ?=
 =?us-ascii?Q?fxZy/8+kWBzAcl57eB8oZa6U5lKFg+YBHrzK9bGIxZgb1qfjNUeX6uZLDErA?=
 =?us-ascii?Q?UZmGL0pnOXYpwGoDX9xGqNAgSQEKLUP81sYunQK8uF0UsDmWYF15NmhzXO2S?=
 =?us-ascii?Q?5TFBV60XeQm1g7B3Rk4IMnbz5T5O9Fl27/1elq4bTSVIUFLAxJnJZ7ggdFrE?=
 =?us-ascii?Q?hSeGkiSNB+tBiua2V6plu3AvB8EZI3Mzu+J70+mUDFwgHQRNTo2+KVYix2He?=
 =?us-ascii?Q?NzvNhoGPgdyDial/Qa0/lU0p0ZFKj0zXoy6iWeXKM19E7oMQnb0m1udIbnVH?=
 =?us-ascii?Q?Ly/O1B2EnJorru9NJ/Y0XpqjhQUFqVZ/A8SFXb2lW+94pZUKX1Bk1eJf1+EC?=
 =?us-ascii?Q?nSVyBgf1A56hFSGCbvXnUO+6wJ2v+JFS+rpwynl8TXg+ynb2VsXsrRPt4hTX?=
 =?us-ascii?Q?8VeKN0hbRBK9U9M7ftnkzMBqSxx2L1l82Je2t/6kPUHDG3CHBhXGSmGiFVCK?=
 =?us-ascii?Q?kNjAaYa1euk1z/GNKOgEDNycgd7PwBM2ICmT4In679Z0zM4OtfUDI4mqGdsL?=
 =?us-ascii?Q?aSq94jp+v9f3g5/wvctJuU5mcoFDY4NxlNUMv9q9nAzN7zw4RaJwQXBh3t/R?=
 =?us-ascii?Q?QYUuVymAun1BCTchdsbb7FjYN8DoSBzTkPXZtO+my8K+9uCUCCBN4OZhRTiz?=
 =?us-ascii?Q?jSZoKAEI5J3wVsjpvghwiK0gOzEAzu/PPKVYhoy5YZLywevBJ5Q0yrm4Uh1f?=
 =?us-ascii?Q?Ggs7oPJT8crevurxq8xHMBQwzT4Zp46r8SLqFHkXhFlgZ3GG8ZnS2EykR+7Y?=
 =?us-ascii?Q?AFme2XmYL2cvUr0mFUiTp9wx+W4eW66igFEzYlySXkRghCNBcrHiHX0qWxF7?=
 =?us-ascii?Q?H+rk6jg2tjJUA8CxzCKgrzpkmj54zF13d1+T9y1J4AbmU9PNIWoednv3dnXt?=
 =?us-ascii?Q?K6oxXunb12QP7dDtTPe81TIUThk3JvkzBbtuPrlTGj9EusCj9Lq80L2QP2hj?=
 =?us-ascii?Q?V1mFS6JKx0qkOU2InaYmUUFisFHGohmNw/B6TxgIknWc1HQDXixzj0wjC7XT?=
 =?us-ascii?Q?b04XeNCCQCk8qRM3Yaen7ewhHHLm0Xb4FjPLwppySUhrXcdsj+paeVOVw7rk?=
 =?us-ascii?Q?mrSbz6WBZ2BGmDcBwbn1vhrLM98uxLtgTzrHDE4/YEm9mRjV0PpVa+OKQFqY?=
 =?us-ascii?Q?yd2EfNpf/bWHckPTVDln9j+4JNU9jXPVXTXbcS9o0dVareBmvhVHImE+bXQg?=
 =?us-ascii?Q?g4BAWZY/jiITO6CiOJGH9B7U4sIG9gjmECVfTbo81Pr3kcDtwUHUszxCzmv5?=
 =?us-ascii?Q?QhM62xWPAPuPl71/2Gt5jkFBix0bua4M?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 17:29:29.2569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c50651b-5f24-455b-6da9-08dd13c00ae8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
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

From: Alex Sierra <alex.sierra@amd.com>

Same as IH 4.4.2.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 87a530bbc0924..2c1c4b788b6d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -366,6 +366,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 	/* Enable IH Retry CAM */
 	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 0) ||
 	    amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 2) ||
+	    amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 4) ||
 	    amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 5))
 		WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL_ALDEBARAN,
 			       ENABLE, 1);
-- 
2.47.0

