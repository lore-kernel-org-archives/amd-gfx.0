Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1109C27C6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 02:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3ACA10E950;
	Thu, 13 Jun 2024 02:27:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sPcdNfal";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C9210E950
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 02:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvT6CLYb5+tjQ2DP6e2O/hbXbjREv1ddRiupqtQNOWuGMoXkAr+2VsysdKlPTOwO53AOCJDnbvWbZOd2LaMgu08FPr1GSb1ObNdKwqFyoBiHDxc84tSnal7nse0r378b9PkoIWX/LKpdn2t5ZxAnXmMxZQJgt995jfUi1d6mf24H0d0VqAc+QP2tHZ0+olBQb9TvUeAGxvWh35461xqhATNbR1Inx1/lV5+Q4iyT78q0M30zpjsPCTsUr0xp8PsZ+2nsBhIcdNn1juGSEU3z2OWLkIWh6CqfbxT/Jk6lo4dnQrIR/DwQl9yEbPjDYIxRRRwPfn3G6SaPMBqV4ysOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJqKQhNYmzHEpFfGpCYnj30223SRy6XaB7svniczrkw=;
 b=K59WfZ74FU9uGuJfHruQlWeBgFMX3VOiSjkzLPBArhjHg0U63TCLr1gESnk6RhlxaeJis1wk40Fjx6P3/Ij6Z2y3vwh+6z6Pb2+aja52PPwWG0/DCpUOKqmxyNKNkeaGJ+ZyeJord240mHWcoI8ppogKlqe2VN2ipMcq3j2lg4Y1jR0bHkXDvQ3dfPoC410TOJ9Y4sWn6yfRYfWILYFOa1R9ffrw6VBVgY9WDTsiiMrYu0n4oAeEjHYhZe76DYRGJEZZce1xwkv+j/+PvYUXqeEQyHzCG2QzT6Sf5vpcBZY4MBGbk8ZVUkIJnRPi/Mn91De+EZ9WxhDEbbbdSiUACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJqKQhNYmzHEpFfGpCYnj30223SRy6XaB7svniczrkw=;
 b=sPcdNfaluuGXIWKp/IsRKCrfnUK8V7LDWh8Lsmsdurl5ccC5xwOH5x0/AKd4xKUnkVtYfzFKMjXLoo1Yqr1sS18eV/YywQRJ7AyyuC5JczywCczzWx52qzaxhf7ZXMDgDO2857AxCf77GO7Z0bvIoc0cGjnng1CiRr+mspR1Eho=
Received: from CY5P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::43) by
 MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.20; Thu, 13 Jun 2024 02:27:01 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::1b) by CY5P221CA0028.outlook.office365.com
 (2603:10b6:930:b::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 02:27:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 02:27:00 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 21:26:55 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: add condition check for waking up thread
Date: Thu, 13 Jun 2024 10:25:00 +0800
Message-ID: <20240613022504.81787-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: eeef881c-9b3f-4e9d-bdc0-08dc8b504e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|376008|1800799018|82310400020|36860700007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zoKUAZ9cfKr3rqJvudSssNcNrWKWJdInX7yiiLU/66tuAWGeNR32Vo1gRujw?=
 =?us-ascii?Q?8kEee19NxByi/WIOoabN3y6WA36M3DKvThjptlQgnzPM6E8SlqSQe/cOz7gv?=
 =?us-ascii?Q?aw5mR1w6GlX8H8yTteKKnx/BgCWSYr0CdiX0ZVRielhYXC6HgnzQVenjR2Re?=
 =?us-ascii?Q?Yw/6p5YyaU7oSUuWjxNiEpVIwel2EHY7KuApfKyA/ubXUrQ1tPNm6gjN9PDl?=
 =?us-ascii?Q?2AZLD4hHnWClDZhFkjFgjr8gRa6YFFVCZt52nuSzJn5dR99Bd+QnXWiMghVy?=
 =?us-ascii?Q?THsovK0yb6nQWXalLeULV4P8OQoqQ0q6j9h868CmQts7YqNuJzFL52wQlW3h?=
 =?us-ascii?Q?itVQiS3IwgIYQkRWaPgmYR7jufRvV+Rjk5lHhKePMv6QOv7bySOpkKtOqdy7?=
 =?us-ascii?Q?V4Uh4LwpEukGQiAi4KaIIO6B8FjRmwSxmwuDRgf3LlpWnKoWWRCd7RNRjTEK?=
 =?us-ascii?Q?4RB5ETeEEWnZ4rX7xHqx/QyLEfIJHU4RasqjwJ/Hi1DWhhHEzXyEoBlK2zzV?=
 =?us-ascii?Q?uSoFtHmKI6DE1dyLJbtzc4E89tefhvdULy8ljuieCU7MbERAwVQsP1hA6JGO?=
 =?us-ascii?Q?Cq7eBS743cyrSeXSE9OoZI3azHxj8ilJN0GDeQ/Zl3geZ0Yc3AJxgRoRpjQt?=
 =?us-ascii?Q?8xh4jvoJq5s9y+C+WrKGCSlSOIfXW0jemX/purs5Poi6TxbAtVjjrAE1SSQK?=
 =?us-ascii?Q?xW6LCOC9fbSyjDhIB9YFjuPEOhkOPPi+sFwCrbuCbCddZXOH8Uo6ThmqH1wH?=
 =?us-ascii?Q?6+nSei9BDvYqgYr15Eb8HXClxgexnr4938vMgjjbLstAMd6YsN3E1SNdhHLF?=
 =?us-ascii?Q?teCecNlsF8p7n6xeA8o/r8qb3mcmJVfdJDH5TBh5zv2PvYZ9B8+ac04bKT9a?=
 =?us-ascii?Q?ZymeyAtf9ZWh7ZbGFzyLEdYS9Xfd02pPmiVZqk0CjJfY7UTiWb76T3dG70Ov?=
 =?us-ascii?Q?6o+Tc6p4ipNSycniWsPVSFv5YSHZ+S/ybG965uUDJxXj7jqMJS9PMcOpGDfg?=
 =?us-ascii?Q?thXrpmaEMGfOlyN4A6S3vZEHfxCoT8JHwK2UtxApgPuIdEjKH94uHdqRp4B9?=
 =?us-ascii?Q?lvZY/HIQgvS1HDeBtQ082C2fHlEwMSJo3JhjMblivyeDO2bAkYV9tQkQ2AN5?=
 =?us-ascii?Q?FCtIS24M/2y0oE812SpphPpz31rUDSWn6GvqMYzRudges+gpZUD8CWF+wUR7?=
 =?us-ascii?Q?mWhG9n7ZVDkBKPrrAUn/xTDqwhPt0/QqJfWkXbx9keJAGZvXv84OLr7/Co67?=
 =?us-ascii?Q?P0ofPX5GHNk7EFwTHBiZeljoCR47hM2hIkhq2Fauth+wtdE1LfwqURhVW786?=
 =?us-ascii?Q?Fhs717jMl2QeTLFRS4BgSGHdlRcTWIdVN6fPvUDp+RAEbhyavFbsJ0JvSNA0?=
 =?us-ascii?Q?8r2T5xe9bHR8ysuX/tvjffpNYssCXqDn0142qK1kOlrmO3PaUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 02:27:00.2235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeef881c-9b3f-4e9d-bdc0-08dc8b504e32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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

1. Cannot add messages to fifo in gpu reset mode.
2. Only when the message is successfully saved to the
fifo, the thread can be awakened.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 18 +++++++++++-------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d0dcd3d37e6d..ed260966363f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2093,12 +2093,16 @@ static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manager *obj
 	if (amdgpu_ip_version(obj->adev, UMC_HWIP, 0) >= IP_VERSION(12, 0, 0)) {
 		struct amdgpu_ras *con = amdgpu_ras_get_context(obj->adev);
 
-		amdgpu_ras_put_poison_req(obj->adev,
-			AMDGPU_RAS_BLOCK__UMC, 0, NULL, NULL, false);
-
-		atomic_inc(&con->page_retirement_req_cnt);
-
-		wake_up(&con->page_retirement_wq);
+		if (!amdgpu_in_reset(obj->adev) && !atomic_read(&con->in_recovery)) {
+			int ret;
+
+			ret = amdgpu_ras_put_poison_req(obj->adev,
+				AMDGPU_RAS_BLOCK__UMC, 0, NULL, NULL, false);
+			if (!ret) {
+				atomic_inc(&con->page_retirement_req_cnt);
+				wake_up(&con->page_retirement_wq);
+			}
+		}
 	}
 #endif
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 1dbe69eabb9a..94181ae85886 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -293,16 +293,20 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
 
 			amdgpu_ras_error_data_fini(&err_data);
 		} else {
-				struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-
 #ifdef HAVE_KFIFO_PUT_NON_POINTER
-				amdgpu_ras_put_poison_req(adev,
-					block, pasid, pasid_fn, data, reset);
-#endif
+			struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-				atomic_inc(&con->page_retirement_req_cnt);
+			if (!amdgpu_in_reset(adev) && !atomic_read(&con->in_recovery)) {
+				int ret;
 
-				wake_up(&con->page_retirement_wq);
+				ret = amdgpu_ras_put_poison_req(adev,
+					block, pasid, pasid_fn, data, reset);
+				if (!ret) {
+					atomic_inc(&con->page_retirement_req_cnt);
+					wake_up(&con->page_retirement_wq);
+				}
+			}
+#endif
 		}
 	} else {
 		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
-- 
2.34.1

