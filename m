Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2975CCD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 04:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3B1F10EBDD;
	Thu, 28 May 2026 04:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="epY+5+up";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EB7810EBDD
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 04:34:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0enr0tzvVsbvfXQBwkQcrbpJ8YJNjXJVw+UsrL729rFbnXkNui+dWjc1DwEBZTb2poK2pUrxne0GYWOdxG6oHkC9eKUx7DtMlRXTVarf6Z+tmwDCpewwKqFQZiOTGloZcPO/iexsgNYMWZcg3CzrqxI+diQ6XcyyUUM41KMUk64dhiNpOOHHw3rbXodY3/y129zQYip73cXRUN3lNhtPqx/8NoXHVbvP78z6Aad34ihHkw6rbjk2SEmVT6OVF/L2vRUKC95U/mHkU/oktsvtMzKv6HVSuM9SmjZhJy5Eq9/+YlHCRWnic17nsXjcZrgx0xiIfMEIaTxKDt7FfEU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIlQ+uc6BVXYui/p9cJ2CNE8Uy798t3dpBo5XCGWFAw=;
 b=aon09kWzPTrDp1Jj+pP26Vro/hVHCZXsxIIKN/QO28txibfyYF7bLhvd2fyofilceEL8c9i7ZYA0o4muatTmRdHNEdjMGLPx5SFiYae0TGedmyQSbzNr6/qRaffMRk5CckzhSLPtR2tI2tf7xemcBRBa96TdijjTyt7X2TBeeTI/XEYx0DhfQ4JaTT9ZuSd5EqxQFePJNwyxF9ZhDDSfEkpiu5gy/DWlh4OsTc3PoEPWpWa3b8XWgRbt11gaCCRa/7Qi7Czg6xRM1rcyizTF965s4pCBCmPJRR+JwxMRRZxQd7mbsWnveV4LFjUeYpYwFbdZqiMlZzh62l91IrQzhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIlQ+uc6BVXYui/p9cJ2CNE8Uy798t3dpBo5XCGWFAw=;
 b=epY+5+upGFMI6f9+9mCLliUiGTpeEpLFOIboreqr63L6ejGEOnEga6ew3IeF9yPYOMq5DpXbTacMYlqZRzH6QgKqDa8sTyiIAtW+fKU6W8P3On0PYMCajUw04RS+MMBDWWEwy0B06miYI54US1VEzvgOSe7Y8iPIm4kAx2Cb6Nc=
Received: from SJ0PR03CA0376.namprd03.prod.outlook.com (2603:10b6:a03:3a1::21)
 by DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Thu, 28 May
 2026 04:34:34 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::74) by SJ0PR03CA0376.outlook.office365.com
 (2603:10b6:a03:3a1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 04:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 04:34:34 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 23:34:32 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Stanley Yang <stanley.yang@amd.com>, Thomas Chai <yipeng.chai@amd.com>,
 Candice Li <candice.li@amd.com>
Subject: [PATCH 2/8] drm/amdgpu/pm: fix SmartShift bias sysfs store PM
 refcount on parse error
Date: Thu, 28 May 2026 12:34:02 +0800
Message-ID: <20260528043408.237209-2-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260528043408.237209-1-candice.li@amd.com>
References: <20260528043408.237209-1-candice.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DS0PR12MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4fed16-bd1c-4285-c8a2-08debc726b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: iZcvefiHeVgS8MCEgS/zmBR5g+TEoCSY0ic+5KG7i6Jb1UbEjyPaQnSJz1d8t5zyNqMlePwVtBPCrRuXirbstZIkM6wbL5sn56WuUNXcOSKNiL+3wa3/6hGf6xvKhyofYXxhAThFKq48LPaCFjnCqpsBpw9Ygzys4tA73HVR8h00WQEE3qGsr7uwrRBOnOAt67EJ5uKiUnAZZrKZW6dW2doBNN4GQlSyhFlnEgGKPyTKHSD9mOWIRK226xoErKmvIkjdm96FfcavS9eb9WvQ/uuT6aivFo4h5Jv5SB0K51rpjHvuUoMHZLfYO0zdHdk383VTl7LO5Wt59WcXTXOtlqPsPBj7Ys+6KC40eBaPRDjkdaZ50p4IFSBBjFVHSp1XPHwpjG9K+4MMQym+aGBjc3tWMJu6X1iMr21uTd3v+1Vn0m0Xim+mh43fWVcMZQ+VnI7Pr3Oppqjj1mgnp8KzJ+/kQRqfiA7eFmgmz9iBprSVWWAlaN9C2WtMbve8bMYcZAVSuRk2dvmyQtU5G7BEjMLYg/bgDRomxMXuVJU4hxlcxRcDLqejclllWfS0EY8lKbpGg3OJZAE7e10+UeZui4ac2km23oKL5nHEXBKkHlGRW70Ltzfrsr2FAXnyvish6tWrDW4ndqyaX/dkO9eTKWd8D8CX3lt/owQEJfwqEwExMer4YnBAzaaqMr66x/zEjVoUR9S/Gq7nqy2Lqsfao/n9fAWv5SMSj5j516hhFRI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KyNI6z2BCSITcEVliycwBx3EFfXYgGsRd680HtKsb5Wbc9J9Q9+eiQljG6uFEGSs0fS0mxNThHrvWwfsmYsMPi8KoUUfTM7oXS+50NvD18l0wAJIMKVS+aBmjr0wz3fouX0sBvk8OeCT8Do6eGo3tSn4WTrtXS5d3nXDE8wJKqnVEuNXF7lzyQV4T+7ImjpGatkylzUhmK7bnMac832wkZFqcWH+QVwGDKvbVgs8bJUfyZ07Takwj8RI8axq0q7t0id8ZXGESWKxejhmV8V0wxzL2F7JNB/1OEYCO34pIIjTMGjXa0Fs4HtYae6WuZcjZJRMKc1qxJX41JiT5tS2EgAO+7YQgJb4cB0RdlrpAQtrBJZASRS1ZFAi3gYddebXTeN7MiVVZbz1D9+ZnFBvfhwDHTBBpG39hP4jiqBPuFcTrHBNkfLBmIUaGbXAXOtd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 04:34:34.0867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4fed16-bd1c-4285-c8a2-08debc726b0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504
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

Return the parse error before acquiring PM access.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 0c58d23013f41f..8140bc77591c3e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1862,12 +1862,12 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int r = 0;
+	int r;
 	int bias = 0;
 
 	r = kstrtoint(buf, 10, &bias);
 	if (r)
-		goto out;
+		return r;
 
 	r = amdgpu_pm_get_access(adev);
 	if (r < 0)
@@ -1879,14 +1879,12 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
 		bias = AMDGPU_SMARTSHIFT_MIN_BIAS;
 
 	amdgpu_smartshift_bias = bias;
-	r = count;
 
 	/* TODO: update bias level with SMU message */
 
-out:
 	amdgpu_pm_put_access(adev);
 
-	return r;
+	return count;
 }
 
 static int ss_power_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
-- 
2.25.1

