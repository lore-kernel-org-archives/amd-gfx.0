Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50C3C19776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 09:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A3D10EC23;
	Fri, 28 Feb 2025 09:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sQA6YuZF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6194410EC23
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 09:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWKTaamtbO/pcM/vZhnJpIuCFvhTVVPrETSOaz4CJ4ypThgEedfLcv+JFUl/3UR3xPtMW1dpJO86w1hjOtK0R7VNPn9w9TXKnxrK8+vqkf+JeRtZSTQLrjoDBJK0mmsKSLNcD3T1z6U1n8uFOZOWfQ4ggfR7K/aEoOC7Blzjf/ZgAJOT4E43UcpbfoYlj0s4FA8NG4ded2ZFbFOfVll9ldM8MEcyVopmDGPMM5zd+Y7SJB7og8oPkm8yeSWojeXvvrP6zzH7ax9EerAXi0SQSZaMUIp6KPXeJjwhoHq8ejpTrazDah/fah9mp49zpWvqetYLRhi0T04elVqKEdFfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3bLowBRuF2/YYieBhcLxvFCd5WXEDap7M+RmLPcjPA=;
 b=ujRa/X2Bb5zjJdFmOMU+nbaVeZEYDRbUD515RniYlapHREvla0YB3RuNRyUhqhXKEtFwTBO4Ux5MKSaOwHikq301eV1OQaBihV04FnN06m6xIfux7McDkzQMt8R4COGobfF43vNG5I5cIjTJZGlYJK/Sfr9FcwQEkgJvybOCID/i9rJyUzFGjVWZfmLfVJOTI0fbyB/z1JhxCcnjhJUGnfte3t5M54SZ29mdDQ8gZP1D0JZxhwSuoTdfM+QVUo2/7HtYHvhFVaDQNk3ZDSZeSdHKSmhgePDiFmMwhIWYzIvfqjasxxTuxEuIQv52tTpBzSfkxQOjqC041JZU7zMFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3bLowBRuF2/YYieBhcLxvFCd5WXEDap7M+RmLPcjPA=;
 b=sQA6YuZF76si33afoUhVTQjiq5poxikgLCFPtBSM5Uf2nC0qCQfpCLA1hiveNxbINl4Xkb9C23uhyJnypAv7/CpC2ibjeULoBo49NBWT57G3gczkC6nnnJL6A8HnrRp5mppkCkPjFkFD1151ccccTGHkyGbGFwq1qdvzoA/zOZw=
Received: from BY5PR17CA0035.namprd17.prod.outlook.com (2603:10b6:a03:1b8::48)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 09:07:00 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::35) by BY5PR17CA0035.outlook.office365.com
 (2603:10b6:a03:1b8::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.22 via Frontend Transport; Fri,
 28 Feb 2025 09:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:07:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:05:35 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Fri, 28 Feb 2025 03:05:21 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: always allow ih interrupt from fw
Date: Fri, 28 Feb 2025 17:05:19 +0800
Message-ID: <20250228090519.528255-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ad1488-7233-4df5-06fc-08dd57d7428f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UoriXeViV3AGAxf/Oa2Su5utls27gvO6pKJZz5Zn71COy9ByNKOzRsiUIeuu?=
 =?us-ascii?Q?bxdBfWUrj/BgZVRL56g54wS32Ra+WFegAy8hP5VNEuRtS3s1jG+6mMan5wxI?=
 =?us-ascii?Q?mrF/i7xa/JVGxwxaS5iy7/BPB1IjpNw3+lpcauJseez98UpFYE4J0w0k1Unu?=
 =?us-ascii?Q?qgRSyTiGEeRdQPj7+xmIxahf2uMI5U38V/iCd6fPHy5IuWiv+LeCx+Fsm7qg?=
 =?us-ascii?Q?ajS0y8SXQ0pKPYz8IMXogFRB+hjtTiVCoYM94lQSnWIFORtgMT8L2cLiyp7o?=
 =?us-ascii?Q?XVID6E6ubSwINM36pHWikFwdcnoyNyThHccPI7bwfspFVWVTe9QxLJLr927O?=
 =?us-ascii?Q?3MZo22dzWVYzp80ft6uiQHzw4kDbSwwHgJopeqVUQ1kIN5rTBSSXZP32QhBH?=
 =?us-ascii?Q?RqZ+RP56H5MNNSsapCQC6CS0Bjoge/9XL1QfPuCmjUwt1j8rwpax2cZU84KC?=
 =?us-ascii?Q?bdf0TTHfTv2qxFxIWZNuJyf1Sr87+kZxKaZQH8bsXqZOsWuAsWkwtfprjlre?=
 =?us-ascii?Q?ZIcEuULpo6qf2u/LeWXfm5wTLQmI+vlGWEZTvHxntym2hu6+NbAwuxb6Dn71?=
 =?us-ascii?Q?C9roQnVafEYdEXpMcf57ouCOaYGpaYZ+VaYj/w1ypvMQ+8VQAoU4EtuuT0oC?=
 =?us-ascii?Q?AA6dx5vo6JI31AX03pYAwm9FkrqZmzzzypZtxpx/lmy6rFy0zb59Ky4/A/8O?=
 =?us-ascii?Q?9w35kLkVzsaFukz/S4zzFliaZWsXIbTDe23TbdRGaItp1U/isEHTsftJZ2Q+?=
 =?us-ascii?Q?MROEqSV38cT0KnJgv84Rc4T5XmhoHkXdUlIAVw3AMz2sZ9+lDUB7UMSkIhQN?=
 =?us-ascii?Q?4J2+7SYYFj9SBdUfE3i8hr+yGCmeSavuSljqaOBhwQANMBYOCsvZyVLhUx56?=
 =?us-ascii?Q?D/e5DzqKCBTL95K4TFvSC1HLfGbuoa7DNBwbgtv1jKLFEI/8qSQpuUzsTij6?=
 =?us-ascii?Q?eBinoJOl0TTzKZ7OYhb5yD9C+TShQz+oGebzoVktbG0fJRnAo/+7Mh3AYQgh?=
 =?us-ascii?Q?rUqYu3jtTAKtFpZNykWgHivDus1CvxfrrpN0DC1Bse2i891eOnfeJoN5fRQs?=
 =?us-ascii?Q?+shX4hXLDhjF1NOBbKPKBDWl4/bOt9Z7dcqemFkGWI6DqiPG7gSTpyBpQ2EM?=
 =?us-ascii?Q?Al5OD8UVZYF63fvwAA1kw+XbLSfVN2zYrl4FNi01hwgvjP+h0IWCQ6AetoCR?=
 =?us-ascii?Q?QS3V5kL/PyZzAfgk1TivdvcV4BUg0yU82u1NdJvt8/xGKJBHGVWFW6WHU5yt?=
 =?us-ascii?Q?xR/DeWiO4Ln61A8VvTVAZOuDv11WLHkgw9/88gO38CRv2glSkpU2rXpY7lqA?=
 =?us-ascii?Q?4PsEhw5FcFxUmPxhrsSXoNiL7mYUtjrYNRXKyBF0gMdtKw/ARvJn7999qROg?=
 =?us-ascii?Q?BQ1KsYZ+Wlxq+0HbcCdEFeEo9j6VA4URJay3ZOZY6Sv4lUCFzaNeAHbh0ZHx?=
 =?us-ascii?Q?syGrdlWGIjeGqpIAiMmneVmCVu54kgYOjgXbP7Dzh2hpzhj+rtdC8w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:07:00.1014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ad1488-7233-4df5-06fc-08dd57d7428f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
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

always allow ih interrupt from fw on smu v14 based on
the interface requirement

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 14a5760082b8..76c1adda83db 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1949,16 +1949,6 @@ static int smu_v14_0_allow_ih_interrupt(struct smu_context *smu)
 				    NULL);
 }
 
-static int smu_v14_0_process_pending_interrupt(struct smu_context *smu)
-{
-	int ret = 0;
-
-	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
-		ret = smu_v14_0_allow_ih_interrupt(smu);
-
-	return ret;
-}
-
 int smu_v14_0_enable_thermal_alert(struct smu_context *smu)
 {
 	int ret = 0;
@@ -1970,7 +1960,7 @@ int smu_v14_0_enable_thermal_alert(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	return smu_v14_0_process_pending_interrupt(smu);
+	return smu_v14_0_allow_ih_interrupt(smu);
 }
 
 int smu_v14_0_disable_thermal_alert(struct smu_context *smu)
-- 
2.34.1

