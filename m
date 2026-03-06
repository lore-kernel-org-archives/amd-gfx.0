Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC01DFCC04F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 17:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4551410EDF1;
	Fri,  6 Mar 2026 17:24:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I8DpK+G9";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013021.outbound.protection.outlook.com
 [40.93.196.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E01210EDEC
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 17:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7ZSJeVlSymNl6p8bXZLggkNUtMPW8YJOaDloE+mq7yyWHajsMXAUUpEAVRGo47lfZu2+EVt8dSvHfLf/IKmvCsnuDEwV9r8BmlkgvgmDtvl+TcwgBN2TfRFuqOtTWNtE6/4EJHQtG/pmYns7A85Vm82AimkUHtjAu3Xoo9nsbQsSQvjwpA3JUcdkgdtIDvcEB06R0x4UZ/EGUx2/sWkXZ3XeXgfS39/XjRAjhoGnWVkjYnfvTXJnG+CnHNh1m4364SIKdSQ5vNw+vFEJ+04A8HArn9/WHUc1YUzWglFb0RMhcHg8GeZPPB6bIMSzCz4cl3NxKB9Ny36yOeG9kBz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuDewrXWrPCswxQ5ub17CswWakUfjHXRPGtVBxq5NQk=;
 b=TLwkyKErBFQhCByjh/M7xF0DfgXSxvXaLbrmDxTt1SQgzo0bySPTeBYUmV4XwsKFNNgMKGBglnu4nvHbdvUxlUHwLTxkzJT8h0ge8iMGoGAsnjwscjcl0BWMdDxeMxwSZtwpdEGSX9mMzXd4qklOUk3mi2eD/lKRImEFOS4nfUgXCU8ffi8EsFpuwze4iTdCZz2fyNaf/qI9gTSbRcGTXZ6r/xesI9EQVnce2wqXcB3q/OyxW4ytLuwObWnQta7sWPHTb/owdq9p+yU9PJcPrULk6W0xh0tolj6lV3tm8d8POppgQloCRzXhz8FCcMg6vSUOv0Vc2bP4HLSo8TuZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuDewrXWrPCswxQ5ub17CswWakUfjHXRPGtVBxq5NQk=;
 b=I8DpK+G9uqK9lhRJeti98WUyhN1O+Ros2RadShezrL4yf2Idi28qnIp0ZcCl0z2fyoSGMChHM35oA0YGleaqyzrD0b+5N3APWW/txRO701b23KnlnvHaJAdwo2gTYXPYMo6n+g/VJNTAe0lrSijBfaT+DErrbRkFqDyO+Csqilk=
Received: from SJ0PR03CA0378.namprd03.prod.outlook.com (2603:10b6:a03:3a1::23)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 17:24:30 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::c3) by SJ0PR03CA0378.outlook.office365.com
 (2603:10b6:a03:3a1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Fri,
 6 Mar 2026 17:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 17:24:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 6 Mar
 2026 11:24:27 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Mar
 2026 11:24:26 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 11:24:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/9] drm/amdgpu/sdma_4.4.2: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Fri, 6 Mar 2026 12:24:14 -0500
Message-ID: <20260306172417.325169-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306172417.325169-1-alexander.deucher@amd.com>
References: <20260306172417.325169-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: d0be8b17-58c5-46a3-e6cc-08de7ba5395e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: 9P9DVX84QrqyXIeUAhQrKuOnWAyWR4gK1Sy6S000OjFMQ5pdjGvGLxUYne21eJ42kD7X9lQpa8WQvX3ijcXqThKv3XK/yqIzvHoN2P4sjyhROGY31VzcTB9D6+F7cyMtyoMRl1h67g71MwiOc3IntAQIBYiFq1i8nPQWJSCW8SrHcbvn93bbiPyBLU0sYXfoGmPyKBRDXP/LEzA4Wj6unMALC9NesOqqOhtvE96mHfvO8xBnjJDP/qNs15mvMeY7YL3rr5mH/hZiOOqduaiGF4krATWTBur8rdG09ljm2uvmYUWAQxzWJaWYuDItf1d5PwGamCHG1V0St3rtnHkhKghT2bhOZ6jTClJ4kMGxftvvTdQq8Wz4R24+NUN0QGDI7SGc6U6ztu9PrnVIf71qtOqhqlkBNh9CHU89KMQdWvkXFFA8mLW2oV3VBoVbFjz+14y6ooCGK0BER1auJLWfAQzDIrreaEOEtybol3p3ODP1/SiJSgrZAIHEzqV2DHOJIOV9F11fEjmXB8cokF5GiHP//UY6jLosmSHAEQtva238O438QFuBnL7JDO4PykspQTL6RhC37HfA/fYiL/q/xRMoGxdT3HQKl2YbRfpvgmzg0BMJRdUDDaQDbwdDv5Yqc7eFhIXAYsaUK6gwcCI1wZ61LfmH7lAG9MStjfXKAs5qi1wUmOPXeJpRv5KCKrsSQwHELFnVdxSa+1bmRi9SS8lITuN1TBhLbbsW/FsTu0KraiDSy22YI05TWOfR72FbOKO1GGyKU8UXVmV2sldgdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /3sJxHet0x/7w1g0eyZEhOqvVGaEU80Fiax/ubmZ0O9cuRDsvcEr+BIhECSofre07Ryz86qEOR2SO9RBRITNWyh1DGfEP4QjGOnztEPQVRr32LcSE/fYkUXTxlheOYI1Un+fP+wuA6caNx3QEXVniyPvlhsCZLqIUKePkFxwwp43y1O+3FRj7pjwANnEZ16wQ7ue6xTXz+wxGLhgR+bzOUQ8gahPYX5MDis5v1XrxLtSPjIZle1tMkvXsCPB3LP4CvW10R8cEdYt35+Km/1CX4ajX0lvFCgnfYezV+jjxoC41ydX0WcVRMZZROe1OBmW2bFWMT2a9YtqAK83HPFZIH9YBJPvdtUwTKJJSXwaUhYy4F7fpxDWjlC1xmtiCcANNoW0nTMTX8WWpxWaascRWPwDCLkv4XyKUfTVrx7wyI7HZLvC4ccyG6xFV3RiKW0O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 17:24:29.4179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0be8b17-58c5-46a3-e6cc-08de7ba5395e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249
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

0 waits forever.  We don't actually use the HW semaphore anymore,
but if someone uses the packet, set a time out value so we
eventually time out and avoid a potential queue or GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 78bdfed0a7fd3..cf4ad97a93652 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -992,7 +992,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 	for_each_inst(i, tmp_mask) {
 		uint32_t temp;
 
-		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
+		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 10);
 		sdma_v4_4_2_gfx_resume(adev, i, restore);
 		if (adev->sdma.has_page_queue)
 			sdma_v4_4_2_page_resume(adev, i, restore);
-- 
2.53.0

