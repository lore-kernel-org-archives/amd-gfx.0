Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C13ACAC5B0
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Oct 2025 17:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFF2910E827;
	Thu,  2 Oct 2025 17:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ya2LIQ4x";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC25F10E825
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Oct 2025 17:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P41GhtDtg2mmtydlOjssv2MWy5HkRFVQl2pnWCi8e72gUNafir5BY9mnJcB/V2fpgH1jTKjws+0eKwOgLkdrwvXfcXUr/5sd0CMDJc1JJZMt+2w50G/quqGdezXHzMK/RVVX2B+hQMjz1xbPkmUUirgszq+SpI/xxenKqg3yFEzj+LYQdDLuvKjbF7ochAIiu3K86wMOWdm436/5mhxMNoH742/dWTknEopD2JLKBg+trSkI5+rYeyl6Y4MY+M+LTFrPcBgGjK67L6EffYVQATmLqGq9xHLfkVo+c2SGNjv/t1zyK77udi9LRZAAYZwTgcerejyPuyL0mW7SbLfh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16bGf+i2SuqVtf5lMnUX48cOvil6hio187vTSEu5IJo=;
 b=kTL14/JjTHvbBrlqFmoJ0yhOAIV62Jomju/nq/csrRya+ZE6X74jqhoyE7g+YiEMcZz5dwWvqppcj+RRw563ZlAKTC0P99IUSAXOT9J+XsvSHYOw1mAax7hZSLL1RRYyeHxbv8aY1buZZOv5+5AA8QoIg4O5f4e7Vm32PMtwZ6Dh73Dowyy9N6ZOTLc/ZsHnWZzqxuCoWVr3Iq7TOSKe3RUjrShOlzxXDFw5yFBymm6DinwvZxHagJfkNxO0CzHYPDfWMM+1SuObu6e92CDhHifcKTjpTFvJhzJUF8i2vBcLp3Jzyo8J7B/b0BcVpdoEh7MkkNh347MQJe2GcSu8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16bGf+i2SuqVtf5lMnUX48cOvil6hio187vTSEu5IJo=;
 b=Ya2LIQ4xWTzs+T71KcOh9G5Kx5fpKEDcyTOHWbZiDEn21hKzGA/QqLleAnd0Dpju4Pn//NmbITk9ebOtPUslmwaDuIYGKCb5wtTdfoQZ8uSiirH99MGPUJf1Qha4RJxve8qeYKrqzUyF2oDeJxlmzBZ047untmfk2B1uiLZSLrk=
Received: from SJ0PR03CA0234.namprd03.prod.outlook.com (2603:10b6:a03:39f::29)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 17:43:52 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::b1) by SJ0PR03CA0234.outlook.office365.com
 (2603:10b6:a03:39f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 17:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:43:51 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Oct 2025 10:43:49 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amd: Stop exporting amdgpu_device_ip_suspend()
 outside amdgpu_device
Date: Thu, 2 Oct 2025 12:42:40 -0500
Message-ID: <20251002174245.1691343-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002174245.1691343-1-mario.limonciello@amd.com>
References: <20251002174245.1691343-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 3476519b-aab4-417b-30d5-08de01db4013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uIWzJyrp0z3/9EhXK6Sd98fMY4pBa+aROfdhctpSvsFVMJXsbOWuZqzpRm75?=
 =?us-ascii?Q?k2ypALjUZ/sSlQ5tUYn5UrQ84kYwnD8cF8G/BBuJi+cSHo3sHbzfvg/kJKlN?=
 =?us-ascii?Q?djQuVA//qrLBWsdn/F/tNTlSPr2n7e+WbwT9CgCs74ep/1wXtPgVMXxPTC3R?=
 =?us-ascii?Q?RfkOSvq1Rd6D1BWXX4E5DHHSekIcs7mNLEQX0auZqyV1NAOblLwUhk1UzmyN?=
 =?us-ascii?Q?4f5+DXqWPJfW4m+uctFOpv3go+8I9tCK5S7t7mz3xyjg3ehsmWWxNL3u6KmF?=
 =?us-ascii?Q?C7mPmh+hJq1nG3YqsH2WkOU/0PXc3sv1qLs2p0GiAqYeEJ7sd7qkHJuWjyYX?=
 =?us-ascii?Q?zUGFGQeh9XLEIIDpfNTob+1UW+Tzl3KFvdxjBIe/hwRulH9QX2WEp7RyuAMQ?=
 =?us-ascii?Q?0BQPWC4jas+dJWONafUqAaGpfvm1erAu1KEBpLOpTNN8wlAsoHMgbxwlUA3b?=
 =?us-ascii?Q?VmZjjJsAeqNt0janoENWh/XyrZDWxkf4imPwIDN0Z1Su9Tf9gdNJec+RwEEC?=
 =?us-ascii?Q?5QuQmyOTOSmEqkZIcDzJ1izCdRdqqXlzMQ+FuP8noMy8MQrA4YKxQiq9phnt?=
 =?us-ascii?Q?ByrqvxeElcAT+UrbS6qeP6EkrOuzmVjtzVzh2MNAZdlNhERsdMD6/zRxl+A8?=
 =?us-ascii?Q?J9284WI63/SduE2drClyH5jtlbcALevVtE9DgWhhdav/9idZoSl2yUypLR4l?=
 =?us-ascii?Q?vop+yzwyS3LnwNoM7XC7qU4uid1QvQzIitkqT00i+h0cbYy2fxEkWbjow5sS?=
 =?us-ascii?Q?+a2TInnQdDpOQ1wDmhUxLaCqFdQFIThC+alrktCLLWf+kG+lGFbSCZ5sDJfU?=
 =?us-ascii?Q?DUu+q6XQf/z3AcAF/GmgiTnqpe/td7vAS2LLnUV5uzGPIJADH0hlDl1xzTkv?=
 =?us-ascii?Q?NgUu4gjjpPgyoTbLE42A4LA1FdTycCjndtVc0HcXAFaMxYkWMdWgso+NQHCW?=
 =?us-ascii?Q?uXwYITuYpWE0aj/nPlcqTY8FYs9WkWa6MZrUvwhHM6tYq2FthZ7zHx54/9S1?=
 =?us-ascii?Q?t9eosn5kueHgCzrkagd3hxPTMv8tm7DQsj7yBfK4mzgwYeIsaoppj/tGA3Mt?=
 =?us-ascii?Q?D58tB4/Pj+3sf7FPrsz8gVZaQD06VSWXY1ZKdGtyl26X46Z4g+nt/cINJMFA?=
 =?us-ascii?Q?m5NOGAhoNwtCvyum/ordAI2IPuOxLX3qq3SkfSpafnPWCBCF8RDPsJCptaxD?=
 =?us-ascii?Q?KQHwS/cFZla6euipg9QbYl2OFlbc2vJ4DXNi04EJDiZuocA2q5iK3fQgfRYn?=
 =?us-ascii?Q?nkf7Qmk6WDXJSbgkisWJOtYifkrhCKkuY1/dyr5OrITyYcdnd9NUFxjQ5k0o?=
 =?us-ascii?Q?pj/Wy7EiavOn2Hkk7c66lcfgwyn8Fl6N7FhH1ayeZHxw4zMMI92K6bBwMJem?=
 =?us-ascii?Q?o6G12CIgmH5UxeShNIO0I3tCkUZors+Uq93p4MzpeZQMxG/FtzC5DwxXMlXP?=
 =?us-ascii?Q?hFFSvdwkaA1a1nKySyLsb07PtUQxT5hfZ+JPOz7T1ogxYihISJwjcjG6BVNe?=
 =?us-ascii?Q?zsMDwC8EQo72GPN78DQxc354vtcOaOKdNUHqzqyxAjvxueV2gp890/msnGJf?=
 =?us-ascii?Q?5EM1b6n84TFjebaZUTI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:43:51.6285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3476519b-aab4-417b-30d5-08de01db4013
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
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

amdgpu_device_ip_suspend() doesn't have a caller outside of
amdgpu_device.c. Make it static.

No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2a0df4cabb99..9cbc8648f837 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1637,7 +1637,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 				 struct drm_file *file_priv);
 void amdgpu_driver_release_kms(struct drm_device *dev);
 
-int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
 int amdgpu_device_prepare(struct drm_device *dev);
 void amdgpu_device_complete(struct drm_device *dev);
 int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a77000c2e0bb..870969f15735 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3888,7 +3888,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
  * in each IP into a state suitable for suspend.
  * Returns 0 on success, negative error code on failure.
  */
-int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
+static int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
 {
 	int r;
 
-- 
2.51.0

