Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EF1C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E62EE10F25B;
	Fri, 29 Apr 2022 17:47:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6284910F1C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThOLb3C/0SYESmn4UYAw1RdOzPVqlYhb2oo2A4dz0GcU55Nzz/2Exx8TR51X16ZHJn1j6ZtQjLcc0RUtu1uN+weHtwsaeN3GNJwvHW4Nlfzrot1YbmzVu8J+UTHrQfmmF05s8ysRovzxj8bvH7Cp0bSjIwKVt1zakeoKMFy9iI8oASgsGzId11O3dVJStliiewruiM0fpv2xTu+0Ss4kcTg5mrvEw3D0sASamryVNAqgmdwE6C5sKRFtsjB7/UEEG8mJzfsBc4FC3qFrc11AZZ1sLkvuHuKOHgj9OBDgRNBfzIcKQi++byA9Ke6s0y4sZacBXVAMGtspv3w3uv+rCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKXPubOJlcJnJ43uklTxx/RQpBD1dGj5ir7X43hE47c=;
 b=PJbSb7IpK0kJYsMUPYzQyC6HlmSDJBhmMG/WQdyeM0dGVZpH8GC9kwpJq1a+sZ7wGqK7P+xCA4dR1ycfDdiVijCBBHerSgGGLUjyxVKpSXTQuovT4xB6CUC65xFrXmusx8RkmWd+bVK+JyKcFztR0FuimFQ8U2A24EXaWAWSTbNkA/TbiCtBzWFKvzwRa9vfhI5n5KGwZ8bpdBlshHdhCLc0RN9Ua3l2ITIkUkq2nGSljOAWji8WNUZ7TPb22/knc5DQKoh8dUKW+tOEvQNM7QGUhqkg6TA5RRTEQ2eLzDp52sw/7bwZZptFmlcm8R3t3xZ1p04FAqKBvnoVpItzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKXPubOJlcJnJ43uklTxx/RQpBD1dGj5ir7X43hE47c=;
 b=lOeuus9ux50sVj23hE3HNw43pD3DHyO5WQRtO9xNcuahWj1+yYjAEm4IPAaQTbedi91N4gMeBOXTt/Xqs4ppE+EZYL6N4jh6KpRKuh8bdY3loLtxLUItHdtdxu0hjJYOHpmc8ywd0RuH6lKO6zvQ1aBc7uBdDxBCPOr5D50bq1s=
Received: from DM6PR12CA0028.namprd12.prod.outlook.com (2603:10b6:5:1c0::41)
 by DM6PR12MB2907.namprd12.prod.outlook.com (2603:10b6:5:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 17:46:47 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::14) by DM6PR12CA0028.outlook.office365.com
 (2603:10b6:5:1c0::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/73] drm/amdgpu: use the whole doorbell space for mes
Date: Fri, 29 Apr 2022 13:45:27 -0400
Message-ID: <20220429174624.459475-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85a217e3-fdf8-4f0f-34f1-08da2a083b8e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2907:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB290718B5E466193FCCC18064F7FC9@DM6PR12MB2907.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4e4Kzz+SPvN8FlBXXsF4WAWogQEcrLthNBF+jBfVibS4PjEd7Dihj9LvXSte0Cu0I3AzTYEiRrrZOz9BtoRcA/YaFQOGmveuBG+zbbsyinM9KuYnAiL88gb7/20bK6klGr0VKo8v9wenGw7BtdN2mXzvXIaUfoygiVe24CkFVqA5sZa140U6A0TcK20fWOfRMBKQ7L+q1hwFs6M+D0S6jjWaSv+Ud6JRrmtI7EELslpgLLR1ap7k+nHQOmmiYUOGewpOUqrUrTnpX6Q3//NFqUbaWEEBT/0yAreghyNAsSc0xk8mA+fD1pw8dQgZAfy0eE+gR//+KOMuXNk/2NoFUELi8efnOVHiJLCCUVjtxQduGLWDWJEtvICi04UWE1j7Y6uKdkYxV/Jd2K65DTTQziVFUVAA+TiiMtuntZ0qTSAYUiTV0BSt/4dqtkDptALcAoDDk37+BmVVsBI1s/+ANvdSuERMJ2GC+pmyfG20LXH+/4nXEZEQsXYBf55yH0FYV0a1kX9MxnV4PHjgCqi0qY57S/5LMHBGOSzg2dC9Wi7JlDFbL9NesEQbzbreGt8aZO3mXplvokEZj2FTII9tmxw+GVMgFobKpdGcksDlF2UFn7LDup6xxXHdZisTmtQoYDT1CDEIeV5ySWoOPn8xZn4fwCwp63RS4Pi+Rz6lHZ83+miTKbN01ceZR0+YDTL3vSGW+MTua9YofoqmhRedA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(54906003)(81166007)(316002)(5660300002)(8936002)(6916009)(70206006)(40460700003)(356005)(6666004)(7696005)(4326008)(508600001)(86362001)(8676002)(70586007)(82310400005)(36756003)(186003)(1076003)(16526019)(47076005)(336012)(426003)(2616005)(83380400001)(36860700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:47.2533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a217e3-fdf8-4f0f-34f1-08da2a083b8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2907
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Use the whole doorbell space for mes. Each queue in one process occupies
one doorbell slot to ring the queue submitting.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 +++++++++++++---------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f33e3c341f8f..b9844249d464 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1044,19 +1044,25 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
 	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
 
-	adev->doorbell.num_doorbells = min_t(u32, adev->doorbell.size / sizeof(u32),
-					     adev->doorbell_index.max_assignment+1);
-	if (adev->doorbell.num_doorbells == 0)
-		return -EINVAL;
-
-	/* For Vega, reserve and map two pages on doorbell BAR since SDMA
-	 * paging queue doorbell use the second page. The
-	 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
-	 * doorbells are in the first page. So with paging queue enabled,
-	 * the max num_doorbells should + 1 page (0x400 in dword)
-	 */
-	if (adev->asic_type >= CHIP_VEGA10)
-		adev->doorbell.num_doorbells += 0x400;
+	if (adev->enable_mes) {
+		adev->doorbell.num_doorbells =
+			adev->doorbell.size / sizeof(u32);
+	} else {
+		adev->doorbell.num_doorbells =
+			min_t(u32, adev->doorbell.size / sizeof(u32),
+			      adev->doorbell_index.max_assignment+1);
+		if (adev->doorbell.num_doorbells == 0)
+			return -EINVAL;
+
+		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
+		 * paging queue doorbell use the second page. The
+		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
+		 * doorbells are in the first page. So with paging queue enabled,
+		 * the max num_doorbells should + 1 page (0x400 in dword)
+		 */
+		if (adev->asic_type >= CHIP_VEGA10)
+			adev->doorbell.num_doorbells += 0x400;
+	}
 
 	adev->doorbell.ptr = ioremap(adev->doorbell.base,
 				     adev->doorbell.num_doorbells *
-- 
2.35.1

