Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6CEC10F16
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 14:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73F6D10EFB1;
	Tue, 30 Apr 2024 14:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fGk+Pg1/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 166A210EFB1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 14:23:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SL1PvrsSm1lXqsEqLdRfXPW+gwEHJx+FuZzgTvMC2SanWP7y08E/Xi5d8/ZiIGIL5QZdmXDv5+DWQ0RCJ+OyPxAovlc9bDQPvYr4gjfBNfIewMh1+acEdTfIY3ob0jPNBnTcUGnf58JSoLuImTV4Rtl5lvJbHtEpqciGWDdJ3aPKHiKV0MOlK4K4bu41962M/cZekcnsRM3zjXOiMB84IrAJcLUPt+Qs8NY4JLQ92ObEw/cWVuWA8JKfRjQ6Kt4yClvZdrFobRN8nF6yKCp7HqWOEdOCHFxwRqHWv6QMvCtW/TWK8YQ4MMteU/xXMKX6A+uoWmI8mWZSq3Q45JofEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KCBB/9kIRWt9fdy8T7oM8WF9LHPRVT5z/BGECTPQrc=;
 b=mH0WqOfhGGyoXLicoCaKyPfxSLp4gZCB/JnT8mQ6BE+FNZDnHc8xo57qg1yeDCbkjLhRVIKsEoPrsO5+Efv82bO3kgDA6iR2p4mzON2ivd/7SZ3qnkFQ+Nx27LopaKrIXQlTlSllCGvQwBSkVihTNyx94NUkpyQD4vDx6D9Zmbf6xOtavA/EZ9s5k4r0hAC8ufK7tI0LYWpXSzcPOZoPvAZfGQqD5o7UsZPJadVImuF7ycmMJo5Vzya3SRsInw0kxo40v3B70kgQVgQ1vW5HmUI185gVp4MTHRw8ZTPoBrKDNFyPioOplEKLBBqX4GK/+YsEXHM7AbzojgjY38dWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KCBB/9kIRWt9fdy8T7oM8WF9LHPRVT5z/BGECTPQrc=;
 b=fGk+Pg1/leVfnPHwksY8l+p6uz3bB9cxkVyw3aFU1vlWBupeUJgt0GlAUihf0UUeE4j63q5CX/i+v0ZD3HoVikoehcgU4za0oKtEoFzyKe8ZzQlKnHmAw4mw5mzaIGWPrmqn1Wao3l/+hi5b1Q8GqwNIEgRxJmknrbtO34oa3NA=
Received: from BN9PR03CA0499.namprd03.prod.outlook.com (2603:10b6:408:130::24)
 by SN7PR12MB7785.namprd12.prod.outlook.com (2603:10b6:806:346::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Tue, 30 Apr
 2024 14:23:44 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::ec) by BN9PR03CA0499.outlook.office365.com
 (2603:10b6:408:130::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 14:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 14:23:43 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 09:23:43 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Sashank.Saye@amd.com>, <Jeffrey.Chan@amd.com>,
 <lijo.lazar@amd.com>, Zhigang Luo <Zhigang.Luo@amd.com>
Subject: [PATCH] drm/amdgpu: update vf to pf message retry from 2 to 5
Date: Tue, 30 Apr 2024 10:23:29 -0400
Message-ID: <20240430142329.23407-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|SN7PR12MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: c08c85ed-451d-4570-325b-08dc69212411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TUpeesoIcISLxqMCyBlYjvMsoEOseqiRBPFpT0uuBHTe5quTrTKF+pX5BIDG?=
 =?us-ascii?Q?uCzG7z9tSkYaEcWaaxbYTpnD6QANbUpo3qc8vdT34DoD8ASDWZAuewv3U6Ol?=
 =?us-ascii?Q?Wi8aVY0Gcq2liWSdjj7TRdyo9FXXtpEIUoHesCqe7OjBIovE4SdUlDpIeWR8?=
 =?us-ascii?Q?0sh22NiYz9jIi2ptXBi4Qcmd5Lvxug/P9VCy0XH7N7k0b1oIU4ci+pPKAsHA?=
 =?us-ascii?Q?TMlDhtFq+PCnl7dceBEmozxBiBcfs6HEAQMJKo3NGVmfUKP9UKFS4AnIAftB?=
 =?us-ascii?Q?cCT2n2IoYbdcI/U7ip9QkdDHtHHFOkp7M7Pn6e+Pv/Yfp1CLK1nivJ6Ok5qi?=
 =?us-ascii?Q?3XhQzplOyAgFLnzDhTmi5micvwkPDX38odlwze5tujcPvv85yPZ3sqp3rv5F?=
 =?us-ascii?Q?aCUWOP2xU/Rjvjz5XM/j/aem2BtAtC2VjhApPJp9sq8DEmouQ8sNAikGL5GQ?=
 =?us-ascii?Q?HA+akwpjVgzHo3IQ7xME89Wsj2k6mH2aKijfMfcer8POOupqvnuJC/rU3odX?=
 =?us-ascii?Q?8O/JI+VYfLM6Y3mVl5c4Vj9YbWFzme0epb4UDPeGkuOWsBIvp6HFddM0A2Wp?=
 =?us-ascii?Q?K014i+K4QIQUENhJ7rdF08U/b8xuC8oShqrjIGL7HcLsyajzWMAUwyCSPKVH?=
 =?us-ascii?Q?5SbD1sz078UxOqloTA5bsVsX1OHnh0SxmtETX5YV0MNNWnDX0ayBfhbihiIz?=
 =?us-ascii?Q?dCcBBv2jFsqpzxEfoRJkjHARrpMBGvn4vQ0mt/kUUuo3kHmAvYwPCqntOJv6?=
 =?us-ascii?Q?gbuZzwgwjx3V6o1j1IP9A87uixwFeGAnncdQk+nVOHVK9/Rxy+eZemOMZBQz?=
 =?us-ascii?Q?85UN+A4dbhKWeOsz72igLUNB94PMtUVT7bjRhldqpSeihxEMrVJeg9NUiG1z?=
 =?us-ascii?Q?3JBgMcSkvQA5igM24jSl/Y2wZaSeuitPggyoDnqvNs6MwLtuC/2SjqA2oYch?=
 =?us-ascii?Q?ujMBChhMW/+rxtV8v64mpBtu+LshAjrWiHsHMw6tgtXjtzCpNApYRod8lF1e?=
 =?us-ascii?Q?X5+GVV16jBl6LFnpzDHwQb5AWYm4J1FPPjMjC0bnxbbWP8jzrn2uF3wFcTHB?=
 =?us-ascii?Q?YH98MPkBD/vh12JdVcki3tO97yxv20oirG3tN8299Mt0NBGLcSozuqc5Oz05?=
 =?us-ascii?Q?SZja0HIZyfJMGxIQXQCZQMdpC2dJ8JWMRik/1uT2staawU2nP83lLZoYfA4m?=
 =?us-ascii?Q?1rjrVS4APPso64z3vUpFC1aGxY2QDH4bwoyLSvNhQ0yzvEM/7uK0vYS04kxl?=
 =?us-ascii?Q?T/dh6Y9lQUDJU/+U0lIw4bSIVx0KTe03R/VP+npXmidpItYwmyq3aLGAvVZL?=
 =?us-ascii?Q?L/HTQhhNZqQ4hivTIxevnYCcKdqmRLYyfKAdhuilyIzj6hHQhu3y585bg8/q?=
 =?us-ascii?Q?WEx33GOpfMnn+7jn9ETuVI4gHy+S?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 14:23:43.9399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c08c85ed-451d-4570-325b-08dc69212411
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7785
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

increase retry times to wait host has enough time to complete reset.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 89992c1c9a62..8b0ab075b728 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -181,7 +181,7 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 	if (event != -1) {
 		r = xgpu_nv_poll_msg(adev, event);
 		if (r) {
-			if (retry++ < 2)
+			if (retry++ < 5)
 				goto send_request;
 
 			if (req != IDH_REQ_GPU_INIT_DATA) {
-- 
2.25.1

