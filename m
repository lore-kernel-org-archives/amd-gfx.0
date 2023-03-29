Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9B1C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9321210EB3D;
	Wed, 29 Mar 2023 15:25:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C371610EB25
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:25:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pne6syR1cN9dwBbcGLtww6JA506B/4xXAU4JqB0BjbNCvjDQ5wSQHw3qH6/mpTa25Wk5yeR+rIgyFU73bNRjXekEJVe/WMKW1MA3JYWzKha6rL2u18gvBPusbMn04KPq5XlRUqJ9tGX8VlED9ycN6D0R1UWfsnV78gOA0DBC4+ex7pd9/IWqYWVbrnKUtr4V2PITixkHHzKu5kpQWnkTQElpZUoOQyrrXJqtsLgk2hsBtBijOB9XxmkwWoF6uMnEPyVNOWBxmt57ATqpZ6+t3a4LtkCTT2P/Qp0IUn2htV3UZtE6EfFabQXjm84PdBKOhFQcjZK3/gkrHqULanmsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+O4JRDPJdgeLUHaIFQ4tYPN3pKyI42nDVPMzNvoBTY=;
 b=WzyIehb6np0tQoWR6p9NY8Sk4dsVw3tcFdO3BRUkvAPinoVGjC5m8MJeMiLsW4e3uIXALOmI2JOOugM0jU14Mf5MiyS1oHYx8GrdtTrwKq/jjrR1ZDwqosbOpFDm2lRnX2N9xB0ZmGmTG2K3zcQ8elMr95+zkdv20Gn3xQZsG4Tn+dUSqv5JELf5FBSVkTduCRoHacutHt5cgH3y654ExIYvvraJy7YE25k+9OnemBcbRDPcS60Z1MQsbRIPSfDG3XydHslI28sB81sTe1VFi+5xKo34HrfLUDicNaKlBpoywyIxp/EEyaeNkV7RGFgdhdGU5bezq+g+CDliYArf4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+O4JRDPJdgeLUHaIFQ4tYPN3pKyI42nDVPMzNvoBTY=;
 b=3Dn+vH9pmJXFd7dV9baamzMD+3bK5LRbFpi0BKwrnxKFMtXtBg8ZInMrcK0ATLvcr1aRmERxNR1B7kkZYytmuRsCIRhQblEALtEcdAGD3ZI+48coTcABxgs3y6aWbS3u7Kgrc6Ix6owhuiBvuv2q+Kd22fxafzpb7vjdedBQjvk=
Received: from BL0PR02CA0116.namprd02.prod.outlook.com (2603:10b6:208:35::21)
 by SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.31; Wed, 29 Mar
 2023 15:25:39 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::ee) by BL0PR02CA0116.outlook.office365.com
 (2603:10b6:208:35::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 15:25:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:25:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/13] drm/amdgpu: add gfx shadow callback
Date: Wed, 29 Mar 2023 11:25:16 -0400
Message-ID: <20230329152521.1980681-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329152521.1980681-1-alexander.deucher@amd.com>
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|SA1PR12MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: 551351df-2818-4095-880a-08db3069d9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XEE2uACtZ8aey7E4tALqj+XU1YZrg3MP3UMA/KZr5xdybX3k86Arz1eqYB8VJVMuwGxt2QvjEpriK/ndpu9X7ocixrjYKGEbmIcpBwq3CqoBvY5dzyEJaj2HkMplcngh85LXrKb1xAkTkNd7ycvxoFGwxAZxIpXpk3WilzAzbpiGTTfQwW2Lh+INCyhr1g+/Vbn4HgJJqz6RuEahQh6RoVNIU+UsPv6f4+7bPb0eE3nQuKj8Lnmx/7dyjtfZFAYxVP1qzT5DgYyFYyoSX2IsvO2+LfAvagflWcRRaE6rbR+swv/jnwrxbF7rWa9KCp20IJmiv6hmaPaMuMH3o1/qwocw7XIGs8zjuvLpZlU+hdtYCVm/ZL5PnofL1mU0nsnGTI9YYXcYFG7BnBVKi9zdLrFzCkcb8zw2Ko/mqYLgJ0xmr+pffdsfN4DB66iiS8LGzshodC7MAXJAuTxquBRrI5pKQn+YGKxLDdvflBRymwochHWK/rHaVVNXv97Iz3kQUInswP7teLNgHPX3szzZeKLfri4p8+EVJiqFBZJJxf13ryzywXt/m21M4NKR804YO5yBNetaC+r4ZTLNUwh7niEgUWObAlqYOlSJBuR1lKIVWfdvEP6AO5CJYv+EaZv1TBiNTMOCr/WOg462/X0eEhXMJNDouMVafz4i+S0yRCTfLtWVbz3E4bvmGJu7AJtpn0NH+WTx8qWIRi1oKq7abmhV9r7Rb3mmL28yEkLkGqE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(2906002)(40480700001)(36756003)(82310400005)(86362001)(40460700003)(478600001)(5660300002)(426003)(6666004)(336012)(47076005)(83380400001)(2616005)(8676002)(7696005)(81166007)(4326008)(70586007)(70206006)(316002)(186003)(36860700001)(6916009)(8936002)(1076003)(16526019)(356005)(82740400003)(26005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:25:38.8182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551351df-2818-4095-880a-08db3069d9e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8120
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To provide IP specific shadow sizes.  UMDs will use
this to query the kernel driver for the size of the
shadow buffers.

v2: make callback return an int (Alex)
v3: drop GDS (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 4ad9e225d6e6..62047a541c21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -219,6 +219,13 @@ struct amdgpu_gfx_ras {
 						struct amdgpu_iv_entry *entry);
 };
 
+struct amdgpu_gfx_shadow_info {
+	u32 shadow_size;
+	u32 shadow_alignment;
+	u32 csa_size;
+	u32 csa_alignment;
+};
+
 struct amdgpu_gfx_funcs {
 	/* get the gpu clock counter */
 	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
@@ -236,6 +243,8 @@ struct amdgpu_gfx_funcs {
 				 u32 queue, u32 vmid);
 	void (*init_spm_golden)(struct amdgpu_device *adev);
 	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
+	int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
+				   struct amdgpu_gfx_shadow_info *shadow_info);
 };
 
 struct sq_work {
@@ -372,6 +381,7 @@ struct amdgpu_gfx {
 #define amdgpu_gfx_select_se_sh(adev, se, sh, instance) (adev)->gfx.funcs->select_se_sh((adev), (se), (sh), (instance))
 #define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid) (adev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid))
 #define amdgpu_gfx_init_spm_golden(adev) (adev)->gfx.funcs->init_spm_golden((adev))
+#define amdgpu_gfx_get_gfx_shadow_info(adev, si) (adev)->gfx.funcs->get_gfx_shadow_info((adev), (si))
 
 /**
  * amdgpu_gfx_create_bitmask - create a bitmask
-- 
2.39.2

