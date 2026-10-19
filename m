Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E9DCCF2D6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 06:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E9810E79F;
	Mon, 19 Oct 2026 06:49:14 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE5E10E7BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 06:49:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxlFO/UDGQkl6TYUY1+pxkw2xdfs9i+2h9YI895VFrNcd/umVXnp52XeLcvDT0ucRPWh2l9PlSZ+x/b7KLAkw20hSm0nDe88pi53uBRX3OMsH9FzWWASC/oLmrCb7ZKanr80H9oZATFFDQJWaKYblvvSQW5paH+MPXo2Sw5GDKg4IUUIlGABUfIzLyoLMS8trt9Vuq68B46UNqy0K+Akacl36CX1jbiOZquXJ8T6T4xPHxpto8dbxNh2yNMQUV+b4x9MY2KumuCsAKOg8c0u20f5dOAKZPer9VQhza6A8I6XPhW/I3qT3Ha80ZwCPGgJ5b8PWELkC1FTgPRpFnlVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LcgUT/Spyvks0kpU7RaOTDmGxJBWQ3WuExiz3wyZNc=;
 b=yuWYwgk/iSiMC0JSvcouJc8cvBFVl0U4N+y6EpTAz3+oQmUeZmeDGWGH3Xd+cXtN+olio1u5zlYDfdrFeh5bi7o5UIaLhepO14bL0moSTlI3yohfICX9LyMvbS7PsZW8HTychWjRbCl8JAb3z34D8GfMYk6sUvSL0OK7p0+765UdryCaH6TDbMSNvorr4wKgGbmLvkeer/Hw2H9jcb5kOspeC4KJJ0wL/gLqIHtY8rb5ctvAto6zzhS1QLmEUQwNw1+k5VE7BdBMv6FFX10oEPN4cTZajAIWBtQW1NcTCMZCssZIo92sAVUf1xyM/wlxW+w57uvRljIg8L5sduBf+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LcgUT/Spyvks0kpU7RaOTDmGxJBWQ3WuExiz3wyZNc=;
 b=e//JbIFiHNyoxZgZaJir51Vb1I6AYqmhAI2Inl0oNye7A3Z4L+0KrF7ykQND3VHx1RKcP8hMZWF9Nj2Efw3+4VkQH5gXiCqvzcvi3p6UhpyR1kLYJM3NghlrBof6LWgMS99ZnfNvCodtFt0WiQ6pCdEFvJV0xHkEwTHqvlbXpPo=
Received: from SJ2PR07CA0023.namprd07.prod.outlook.com (2603:10b6:a03:505::9)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Mon, 19 Oct
 2026 06:49:00 +0000
Received: from EA8PEPF00000009.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::7a) by SJ2PR07CA0023.outlook.office365.com
 (2603:10b6:a03:505::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 06:48:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000009.mail.protection.outlook.com (10.167.249.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 06:48:59 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 01:48:50 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 04/10] drm/amdgpu: drop the unused firmware loading mutex
Date: Mon, 19 Oct 2026 14:48:32 +0800
Message-ID: <20261019064838.2577746-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019064838.2577746-1-Prike.Liang@amd.com>
References: <20261019064838.2577746-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000009:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 703be0a6-d00f-4483-5ba9-08df2dad0e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|6133799003|18002099003|10067099003|22082099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 6MI50lAj6s1dyBLkWHmwSPZ3dxzvz2b1rTTLt10xQ7FdEjeQsESIbLee+Ml/w4IhrgYrCUfs+EIr/E+byIy8XcVnCb8ICcPmzzscQNnRiAcUllKnUQn0dfEu0YUMZxdFKcvq9X4gxo8PKVbyDL2sgfdbjqbOnOHGlVcu1yOxAjLvK0PMsjz298OYmaNoLaQ3n1lS05lIsyNZKAPvj1/sHpe/8xnkl5BJ95DhAysfdt/mtGeYlSCC8fUhM7xDNl2RT/fyFXBG5PvgSjk1Y3on3Vj6CylCoMsNPMm1Zf2IjkT9pd9Yk5F1LWPcHgAXBrteEJSszvHBlwAEjfUm6EsuZe+HvxtJH7wHn35CVPJlTe2A9gfR1O+KF2S87TSj7N19yZuXv1YEipamJZq3xMuNxlwuctN2Y+oGU/mStGBou1gs38fRqSzP6lu7ERxHFgbqQBk09Dio4i6pQIQ/b2uNDp/5Khn3IMcctabLTYW9ysi8k93p42sTWj/fLwX7mQh5NuEgfQ4oQvnTCy+4nZIjoEM8MwIPVnmq1fk45hw2M6ALcgungZj+sLhS6uhnYvzw0lWT8VqWqfTsv9FKgI3O2TbTIKcJs2miylyvLhk8N2d5mIyeho+Ar5l0OtMyVggWEiCpOClQ7LAZeeg8H8cMKpDa/qgMm8ivGz9uZWvqOMxjTaJvsvpUXT8/eQGQZoszxFxdoPlTGF72psYxeFyYDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l1pWnRk1xsyvf0EMxePZyedMXhczmCvj18BPviY2PTjLpwoijIit1mGlNl3a5ePtltk/OVAlpBJ3X03IlorjXlJQbmaCcXfsQXwZqLHVZxqusTZ1HJOenrQ7LQIh7nbsc70Wk0ReAp0/gVupcZ5y5sHBWmHwmzYEEk8yGuwOIinqcOuAX6bKqalb4fexW6iy1HdVvw6UpIYYX9mUr8Ck2LwUeVOqa4fK6UMz/L+P1YpUlIlxV2FpRm2dshg0WGsfA3/Ee1hj9VRP/LqeAueOLD3V4SHMJQ0CoVSFVmL6qvpqyTV+aAgY7RUN/LCS/VDiv6FsLHd1eTeIeGRJh7KIO5S8fcZL9kJXFVryJy/MmMJUkYPa7hkjv63cnDEwqqUnH7mZEMIxGDOAH9TPoJiVh6yIomw7f1fbxfNrPhemS/NFANx000HNGKsyNIGV9g/B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:48:59.6574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 703be0a6-d00f-4483-5ba9-08df2dad0e08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000009.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868
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

adev->firmware.mutex was added to serialize amdgpu_ucode_init_bo()
between the PSP and powerplay firmware loaders. Powerplay no longer loads
firmware through it, so the mutex no longer protects anything: its only
users are psp_hw_init() and psp_resume(), which the IP init, resume and
reset sequences already serialize.

psp_hw_init() still allocates and reserves the PSP ring, TMR and TA
buffers with it held, and GPU recovery takes the same mutex in
psp_resume() while holding reset_domain->sem, so lockdep reports:

  &adev->firmware.mutex --> &userq_mgr->userq_mutex --> &reset_domain->sem

Remove the mutex instead of keeping a lock that recovery shares with an
allocating path.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 9 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h  | 1 -
 3 files changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 20f02dd14c41..71aa13a9883b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3817,7 +3817,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* mutex initialization are all done here so we
 	 * can recall function without having locking issues
 	 */
-	mutex_init(&adev->firmware.mutex);
 	mutex_init(&adev->pm.mutex);
 	mutex_init(&adev->gfx.gpu_clock_mutex);
 	mutex_init(&adev->srbm_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 36bc4b431dd5..01dca6858833 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -4157,8 +4157,6 @@ static int psp_hw_init(struct amdgpu_ip_block *ip_block)
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 
-	mutex_lock(&adev->firmware.mutex);
-
 	ret = amdgpu_ucode_init_bo(adev);
 	if (ret)
 		goto failed;
@@ -4169,12 +4167,10 @@ static int psp_hw_init(struct amdgpu_ip_block *ip_block)
 		goto failed;
 	}
 
-	mutex_unlock(&adev->firmware.mutex);
 	return 0;
 
 failed:
 	adev->firmware.load_type = AMDGPU_FW_LOAD_DIRECT;
-	mutex_unlock(&adev->firmware.mutex);
 	return -EINVAL;
 }
 
@@ -4282,8 +4278,6 @@ static int psp_resume(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
-	mutex_lock(&adev->firmware.mutex);
-
 	ret = amdgpu_ucode_init_bo(adev);
 	if (ret)
 		goto failed;
@@ -4345,13 +4339,10 @@ static int psp_resume(struct amdgpu_ip_block *ip_block)
 				"SECUREDISPLAY: Failed to initialize SECUREDISPLAY\n");
 	}
 
-	mutex_unlock(&adev->firmware.mutex);
-
 	return 0;
 
 failed:
 	dev_err(adev->dev, "PSP resume failed\n");
-	mutex_unlock(&adev->firmware.mutex);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 35277b240f25..7c809692807f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -612,7 +612,6 @@ struct amdgpu_firmware {
 	/* firmwares are loaded by psp instead of smu from vega10 */
 	const struct amdgpu_psp_funcs *funcs;
 	struct amdgpu_bo *rbuf;
-	struct mutex mutex;
 
 	/* gpu info firmware data pointer */
 	const struct firmware *gpu_info_fw;
-- 
2.34.1

