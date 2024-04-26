Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D3AC19F4F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 18:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C8D211A711;
	Fri, 26 Apr 2024 18:50:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Absk1RXq";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2763311A713
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 18:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a70jQHYTZknBX0cAAs6QVPH13uPR3JHaBExYmeR4zhUBzIWfVX9lgumBfsGAX6J1Lv/Ai3evxuZXQ0MThlriy43RmkFrP1NV+eitMSXj0tfTKd2BiYT3bGA7jsG88ISq9YaAVfQ5EbQ2gqwlIE/0UXPkQZUn+LJP5rlfRk9l0IxUw+yxICu9ehtQO6JLkL8FN5YTwHkXrqtlOszZFo+P/OFco5GSPYTlPZqpVo6/cb49iThIKwiJykMTENyOKsF3E+AwdRKTs7MBnTon8jZYBeY9QdxKUZRdnts2xiehc+xkE7Jqd29T4e3p6su2eSwRrP8oKyMrU/sDQqvhkmwIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=752AjdNLMcrXL6EwnWn5MC3GLMemaqCOhCIMii8XNHs=;
 b=kj78jWNKLooqU9iRw3wqo6/8iCN09yEbZN3I/01atGEyhJKj69wwUdVBHy3cruk5IowKUKCdt5hDz4JGP5UpIHY3aOoz7QlVxHwCKwRuiQYd3g1w5hsQE6jAJWTz70lZUYl/N9xtLdZMoujP3mYN9ScVlMydRMWQY8Uh/P7MMJmnTkcyymEyWiSp4CxWn5VqGO51KegrmBD6LPFesrK04mEWewWz7+CsJ5WmoKAnTgmhxv5wr9s/dTcUYbL9Imf7Uv6pBppE0kxOO/Bm3mGL1BiLij3mImTg3njbxZ/++s3ebIC6AlyOQwDpM2hf/jViyL7ECNusLRdJP42UDqYqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=752AjdNLMcrXL6EwnWn5MC3GLMemaqCOhCIMii8XNHs=;
 b=Absk1RXqZUWn2HsjNcIX83IA9tMiGi/yzMk8qb6zEn8EhlYjo4RJoHUl9RRAUsJam8tKnV1MYFP7ZcReu2fKLohAI7CYqq3m99dSigA91yHvVtcUciIHi9n+7Eew7b9kzn4V/An5et5I6cUcklk4eo6TFeZJJfsxqNo+5dIKAzk=
Received: from MW4PR03CA0042.namprd03.prod.outlook.com (2603:10b6:303:8e::17)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 18:50:36 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::dd) by MW4PR03CA0042.outlook.office365.com
 (2603:10b6:303:8e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 18:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 18:50:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 13:50:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/7] drm/amdgpu/sdma7: set sdma hang watchdog
Date: Fri, 26 Apr 2024 14:50:14 -0400
Message-ID: <20240426185017.660146-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426185017.660146-1-alexander.deucher@amd.com>
References: <20240426185017.660146-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 467ca669-016b-421c-df46-08dc6621c2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?igyoqyvGtD0cBKWDhCILRzsdSNz8x+njC1CWlbTx0rLUMnnN51a+F0wuHZu7?=
 =?us-ascii?Q?Db1iRCZgDZpGA+3mdBYXZ8p43IWm+C8yRAgCQh2jCoMh3aG0XODcND9SjfgF?=
 =?us-ascii?Q?oA9y2S4jHOMwL4HbILcyXz1JEvULNVhj/c85TgTzjLSGBhMvylW0TCA3Aiqf?=
 =?us-ascii?Q?J193/EoxE6GVCDPAZPX0dJtnOz0vLDoz4jBp6fYrb1GQ/0F8u8h2NZzq+nkT?=
 =?us-ascii?Q?MXDwoQUaKZg5aboG+gH0tbyQ7aoNJEf6knAldp21riIf8cFWIpCEFnWEuSvW?=
 =?us-ascii?Q?zYkmTDuCcYZm+Y6nwv8bo9nADnz1qH9bQuCnGcR4cN0xHZqq97xlSSjyVv49?=
 =?us-ascii?Q?qdW4oY+plC8Lys0FQPDuVmmaygK0zjskhIS6s4OiiHxEeuy+lewzJTW+hHaE?=
 =?us-ascii?Q?XADOEFA4qahVloi2FosukRj+dY+H6f3JFdERAY/lJ31+GBaR7agdQopGSfiv?=
 =?us-ascii?Q?njpxo4citNw1cXmNrkB3Kc8cm+0OXnqc9GnUgqhKOkbNC8mqRlOztGIg75TD?=
 =?us-ascii?Q?uTcRlQfXe6U5wbW1tlY0inIBTvQWOD27gRA1qx0hRfIgrQfmknUrPqfKzxcm?=
 =?us-ascii?Q?znp4iXkF4N8S72vPtLimfUdeGIeDyqsoNFJglvPuiP1E4T00b7tLd4d6zTYr?=
 =?us-ascii?Q?cTTT0jTgg4bhrfs9n4nigVpaQ50lSyv/sBo9wx8V1kmpCf6++ry0ImtAvyhV?=
 =?us-ascii?Q?rzcAtZo8DR8Loe4UI5dUpWHld2X2Ty0E9Xk6nKtOdzJXLnLo8R2FaJNVsBCR?=
 =?us-ascii?Q?GeCM3KC5/desKXh/7rdWZn7ckDl7xw9GxzLI9QmqKqnBIBgXcezAda6+YXsR?=
 =?us-ascii?Q?gLjRDvHsuoT7dTwMhD8Sj58UBgGMj1cCeAJwf+9vt4JPnZzLLonk33a+/ciX?=
 =?us-ascii?Q?/vHryglXqJV6UixiSJXYhj54QAF5SLqhKdaqZF4v1JoNZZUQC7zrzxFDCV41?=
 =?us-ascii?Q?tEh3/E6+Z6GsvC3PWQzXN+0KZHdP7rkrnSi5d6EabQYjJj0TD+OXg5LCFeri?=
 =?us-ascii?Q?NTlD7ZDJBXBbDr3zh/AFNaEg9BLy2RbifZfe0N33xKGJ2ghIQFsQ7CkHMI/p?=
 =?us-ascii?Q?/gdWV+BQQcjcBCR7BX960IC3SnJmFsxprK0JAdu8k75z47iHkpoI+sSpsz8r?=
 =?us-ascii?Q?4WvTVMXOUiuFg3by46PHd6oLA/t/X2V90uWAsiusyNSaArj84goI5YuQogGM?=
 =?us-ascii?Q?lP+cIL08KRP+HR3XD/eb8I/fRyUJ3HJgJaDMsJ1hTIstVZodkUkKFZxEQCUu?=
 =?us-ascii?Q?5jbwTKQfjYcDuqUWQ21rOoErz+lPNUnm+pyTnZ8cJHAl3hJ7nnPv5Trb096N?=
 =?us-ascii?Q?idbnB7qWK6AxGebng1ANNPEvJRpNUrDPL238kFk6+zJik9071xIJq/srn1eI?=
 =?us-ascii?Q?+Vyn9EGt3TL4g6JY4KGqLdLCOFNU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 18:50:36.4167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 467ca669-016b-421c-df46-08dc6621c2b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932
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

From: Jack Xiao <Jack.Xiao@amd.com>

Set SDMAx_WATCHDOG_CNTL.QUEUE_HANG_COUNT registers
to improve SDMA reliability.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 1d95bf62e9aa..35d99a4afe83 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -527,6 +527,13 @@ static int sdma_v7_0_gfx_resume(struct amdgpu_device *adev)
 		/* set minor_ptr_update to 0 after wptr programed */
 		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 0);
 
+		/* Set up sdma hang watchdog */
+		tmp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL));
+		/* 100ms per unit */
+		tmp = REG_SET_FIELD(tmp, SDMA0_WATCHDOG_CNTL, QUEUE_HANG_COUNT,
+				    max(adev->usec_timeout/100000, 1));
+		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL), tmp);
+
 		/* Set up RESP_MODE to non-copy addresses */
 		tmp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL));
 		tmp = REG_SET_FIELD(tmp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
-- 
2.44.0

