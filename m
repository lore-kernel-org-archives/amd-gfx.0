Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94BEC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 19:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A5FB10E9EF;
	Thu, 11 Apr 2024 19:04:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EG4NvIoZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D45510F2C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 19:04:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKa+zQEiFAC91DASXKnHGAeV6/clyQr3y0xyOPJl+gndUdksojM+zCLIq1wDxdfYnqSjadFQudKqasG1vL4Xr6JAvWoJknDT3tg0fVQSqCpgFRfnROWQ4lAcgHIX3s66xLE6d+YFesnSRVgL6tPP3Q2ePDyiS30Oa1vKjX1Zf/9jInlBqs20FnaNxiJtRgGory3Jc1zr4fixK8XCxFQRdJj94rYUHDORwQMlH7BNtrVMmR8CXfqGynvVKNOye005n6edYQ8w8eQhtElbk3TEjpcvdoAF32UR/qqra6DxiCcEt3zg9+3grN/WZBjyMMtErspi9m8HjdljEjIMo3BHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRnSmk6rb9DVZdhXll4Li4Zvmh6Ug7NmDsjLk0Q2B1c=;
 b=gtJCTdA1UeDgu2ZQ6WTAfkRmaEqeIMG4HjwwYzqNdcNUUEtrgwZOL2N/zbV5hCzjp4+g+glyGNSDS7gcW1HBc3dX8F2GxmFhD/fmoCXBnilbrx9BzJnRD/QrsnpgFDfMwJeF4wvv4taz5G2DuVlHf1uTQho1R/AAUPIfdpAIrolI1sLwTxuTjOAWiOy+MwVH9hB3440MLz/GeIIxTE8YG0HDxtYM8X4YtGKkkcEoSYf61qP07kFQYMWNu5b9FnrDX4uTxHIRRFDr39LvkKnaDXPQV3bnx5ItW2rwSOMH0fBQjAYZ5tQCFShJve+3RyF67ZFsWZWZZGMqaIpwVRTgRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRnSmk6rb9DVZdhXll4Li4Zvmh6Ug7NmDsjLk0Q2B1c=;
 b=EG4NvIoZmC4MMOaOjcxiiYAdTEOPpdvKCgZs+iqrzZClp5Zv0S2INib1Cnpc8m1ujt/lLCtjRgqDRZ0VNjIB0W6/TqTYgkw8Rkg4C1XppKD+bkBe2zyUIM65bQKQMIJwFOXxqy+JsTSSM6qflSdVlazYDIFWhlXBXLifyvIjkyA=
Received: from BY3PR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:217::31)
 by DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 19:04:06 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::a1) by BY3PR04CA0026.outlook.office365.com
 (2603:10b6:a03:217::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.25 via Frontend
 Transport; Thu, 11 Apr 2024 19:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 19:04:05 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 11 Apr
 2024 14:03:59 -0500
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Mukul.Joshi@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdgpu: increase mes submission timeout
Date: Thu, 11 Apr 2024 15:03:44 -0400
Message-ID: <20240411190344.1148610-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|DM4PR12MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 70400580-9788-45b3-d93a-08dc5a5a289a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7CbvybgxGb8XR17tpG9RpO1FmSVnlvGuvjX32ijJ/+PjNhy3vvlXp+sqWKwwmwoabki1Uqy+PCgrcBwYiUyavoSdkNrarG3ldBCujTwVqSx0NpPFipo0zhEbu0jSRHAy7GFrH+aOsTntc0FY94/KQvefZoTF9IpwLLNFDolMBvmRMRfNYB/adiz9gu5AlQ1JF+GZGvUzzRUcXJKWXyOhQOfrliqiJxzmQPfqOccHcXuFMb0JMOctSxyM0NvegbyQgRl0hYJDUjck9xtnYDZH8gHoHYxOIMf965CFyusdYMt2VeQ9ms5csPXCvRGajZFbukz+14fXpEjKI7nxwxIl9x9zFgkej0L0Cmu7H6/tEgE31/Mbo+OABzJD1flU8lc9vGXku45B0LVscwqh+BsB0x7mZLMHN0iSB9+77eHoJQn+ad7WNqrDZxpYB8nrpa/D4VJnYhBVNlDHzf4gWGROeZOs0vRdpHwv907lDO7rwGq4mf26gC0ENl9B35/oITmO7t9my57mtLmsbrbPQFQNZvOuQP5hpgq+jM3hYRyXmNgvM6mfWZ3HyZzEEw6KVa0g4pLEBLf0nOSpW1wpCVn+Xz+wxKL9xcuO30LTxzDQASjUIJVaXmsVv3Hh6GDdoLsXYJBEYuqdr/RMSihOKA3QSDqt83NE53HrsYGbuxGGK4l6/HKPwpiG4+IeYbGska0JHmAG5UqtnB2D1I6DtTqM/Q8a8ilxQPMd6joWh/fdj4533CWorT1B2SMEIg5sUPb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 19:04:05.3311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70400580-9788-45b3-d93a-08dc5a5a289a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818
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

MES internally has a timeout allowance of 2 seconds.
Increase driver timeout to 3 seconds to be safe.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e5230078a4cd..81833395324a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -111,7 +111,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	struct amdgpu_device *adev = mes->adev;
 	struct amdgpu_ring *ring = &mes->ring;
 	unsigned long flags;
-	signed long timeout = adev->usec_timeout;
+	signed long timeout = 3000000; /* 3000 ms */
 
 	if (amdgpu_emu_mode) {
 		timeout *= 100;
-- 
2.34.1

