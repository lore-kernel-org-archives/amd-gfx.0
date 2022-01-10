Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF6BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 02:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C7411300E;
	Mon, 10 Jan 2022 02:27:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE9A311300E
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 02:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em98uFQ5n4lo8YXmdmfy/SRfWeYskbUZNZFxb10UOSeAnMqmme7H6efjvV+g6LRMxGSPJG6shwxOO3NgTmID1Ia8pJn112PrUR1HqQAC6O1iwRjeFF0O82X5OM+0c5FxwD3K/wPGR/v4rgWa/kmM3TLb1MD4+lLnlI9AZckq7M0iQbH8ol1ckrNn2DuSAh5mOf0xEcaj06eB7O2rMHCrPnKfPeXStuyYgDT3iE0BHwGFQ9DEiHs0irh97h/RRqyz0T40njjTDH7+uH3vpEJgNU3n5sGGKa3toCHOp2Kic8D9isHeGeAsg60O6OhWNpNohF1s/iMNmBICCJgFXka9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiF4Lf2XRb79m06I77hJ/js9BzqG4d0iKldO8PnMXlM=;
 b=WoPU9U5XBagft0D5UnWtTn7Xj0A4hYAU/KU+ToVfNDaVB2Vdok7M9BmnKPXvvixLxYRoaXpLqvkWDANnV+ac7ru0qSNAu+pKxX//2iMQwvsYd23ForjuE7qr5tofjRw1lprsbaOPtQbkE7UxZ4za0MdgzhyB6ab2xqnnWQinjeGQbNiEkXZtvYYm5ykL2ipfv6RkigLZLbAs1GeUVenIpWmGffTpix5z9Cm78uac7XXWjSnL4ITKdHwh7Gdf4QDtOIiiDfVjSJoP632u+40vn9881KtSl1RxZMdcQX3/YXl/RAKSPK5k85jwhkc2X7ydAevnr0EYEi3rKdJ2a1NrBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiF4Lf2XRb79m06I77hJ/js9BzqG4d0iKldO8PnMXlM=;
 b=pBjIFJJol+RCO6Xzc+0jtKy4LwEXnjlg8WigtAAJG3WGnvZqzksb2kv+spezMQoEAndyhjY/Cey00EKBqhNTZWBQ+1QSz5gMSicI0U3H0K9lo352Vub0KfYt9scfmlIgAf46GOqTSQLkBBhiuXt9t0mzxEs4+cJht0XUDKBD0n4=
Received: from CO1PR15CA0050.namprd15.prod.outlook.com (2603:10b6:101:1f::18)
 by BL0PR12MB4609.namprd12.prod.outlook.com (2603:10b6:208:8d::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 02:27:41 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:1f:cafe::5b) by CO1PR15CA0050.outlook.office365.com
 (2603:10b6:101:1f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Mon, 10 Jan 2022 02:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Mon, 10 Jan 2022 02:27:41 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 9 Jan
 2022 20:27:38 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: not return error on the init_apu_flags
Date: Mon, 10 Jan 2022 10:25:57 +0800
Message-ID: <1641781557-32516-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aedd0ea0-ed97-4d3f-0bf4-08d9d3e0c6e5
X-MS-TrafficTypeDiagnostic: BL0PR12MB4609:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB460932397DF5D05C483D72B6FB509@BL0PR12MB4609.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjHTRwj6HbqCMTv7HUrP/4n+rde+t7wB5aMWK3K3bpsQkN4jLTjoGBiYGX9mGAewNpZTDUQETl2zfkPdQdFQqDcFVSrQyX403boUdFThX20afDUpS3vmevzEiz+Boyu3DPiSDws8122FkySa3D8fyf9e8B3MYk2R3wJFozIMQrTym8nHZpxE4WWXgJPxksbEWu5RpRv8jJSVX/6+CN607uRE9x3if6HNH1rfzMCziDQWE4pHVNjZgCayKwgUvWeoBBAO8R5RWaNbPV7EVqCTji0DFdZlVQlPYvytdAU84RnghCzNn/nvaAD2C/8rBmbPjhl6s459LfLQsVOa0EhXhErL7hmNWTmOj4P4iGFfhoD63+QTcqf/UzWvkSQ8986dabSQFe576ON2hu7cpx0VYWqrrQkqLkWg00TplUVzYSQqo3WAVv35vmR/HaulPWDI5o2S0QgGLiuKxFgDEOln8RJuTxbbHbbbWHnePCjS4IQUqBhtwggvVKcRacq1UKOe1BdVD4J3n5texXV3Q1tBWMDR71rJ0qHZiaWNwZunY6hze20fZJ/h7/lDOGKbjBOIK7NMeyK22BRirhVEUvawkRRdpZz7nVFUK48Ul5o2Ld3prRPMftIWcqw8S5RKqs82iqUVy+2IADiYnxdEQYEoQUSjUAImQaIm2GlihBskyhYqa1moWcxupp/A/8YjAhZqO4PZmKc097VjuthT6SZOjQk9VumCbAX8/nCdCmPOUfSnwsnnWmreXXrlEK5HX8yQ3B9kj2gj9wqRraNyg7RV7l8bNTiU1DpQJXvvfqRg7BU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(26005)(336012)(426003)(186003)(86362001)(6666004)(36860700001)(16526019)(508600001)(54906003)(316002)(47076005)(356005)(83380400001)(5660300002)(8936002)(8676002)(70206006)(6916009)(2906002)(70586007)(81166007)(82310400004)(4326008)(40460700001)(2616005)(36756003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 02:27:41.1108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aedd0ea0-ed97-4d3f-0bf4-08d9d3e0c6e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4609
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In some APU project we needn't always assign flags to identify each other,
so we may not need return an error.

Change-Id: I92c1acb9ffbdba7e9a68469163911801db262412
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4322d92c25c7..2a6671f37336 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1449,7 +1449,7 @@ static int amdgpu_device_init_apu_flags(struct amdgpu_device *adev)
 			adev->apu_flags |= AMD_APU_IS_CYAN_SKILLFISH2;
 		break;
 	default:
-		return -EINVAL;
+		break;
 	}
 
 	return 0;
@@ -3497,9 +3497,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
 
-	r = amdgpu_device_init_apu_flags(adev);
-	if (r)
-		return r;
+	 amdgpu_device_init_apu_flags(adev);
 
 	r = amdgpu_device_check_arguments(adev);
 	if (r)
-- 
2.17.1

