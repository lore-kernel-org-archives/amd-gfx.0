Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14F3D591CC
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 659B810E5C8;
	Tue, 19 Nov 2024 06:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JyLlkFh1";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2640610E5C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKXq4ggqfZQW5opBVkjYEQLri9CpXeTRxSliIx64iBQ7vcpJGvHW7YTlv9N1MWJFM91uKlNwch6+cFh27hWNtmJJqvgNfqeFghlJ8YNRhKZ8qcK0LJY6Fs/LaYFDDI3daXI+dZuZIv+7XS14P1/aVZWkQJvzPCUqK1mnorCz9GGVhQQoyfmOtbokIQpzO/83WnXidS8dT76AfQgf7ET4LHkVRkPhu5Yfdb6hPO34EUHTP9wNEo6/VLx8uh1K9ZFVrtUAFSBw0Wgxc7BxeRIw0YAA2KNe8/E6yQ+C3DAFWRr3Qjx9/dJHDPWxEviHyKyfgXWYO+dTNVXpIwsGoKQtsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaxDV+Op5HWBTRIfz7Z58VQ0r93PrJ8/bGJpR0GvV+M=;
 b=f8WArGXrJOStqNvu4XXhCLEa5lbeQ52WYmhQgeUSZZNn+DLFYzwjOgPs5KSAtrwkqx6zsXe/JsUdORuE/NKQzMzBpVcbySErCoZKpt+dL/+L3SfEGmVmsjBKqcGOkrWaRjvLZ43VZX7TFdzZebBsK0tMXHlXRQhvmQCZf6+PJeAyoKuc+KvNduG9B2vJSyKfnLa+xgMjQewyzBoYoIztJXJ72O/95ws9XsCWXZfaMbADglXx269SL9VKps024x/D9xmN8/U1ehM61GfoPmpUA/ocJ98zz11MTHrRSe1xtHDgW2w4vp2ggc7sM3/4PuiMUzWpYTtqVc+zuzGzjg9IsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaxDV+Op5HWBTRIfz7Z58VQ0r93PrJ8/bGJpR0GvV+M=;
 b=JyLlkFh1uo6lA0IdJHPQFdmB3PQLAyQc562FQ4en5xPrJhVC950wxDMXcitnidpT5SglDLH7iy9WnkiUp56uFWT9aeaLlzQ9FRQX60K9O2ebMltF3iEFoLXD5UyxocVkxZ4/uPRerQs2usAuIbsGFbbLx3C5Wah0O04a93AAlLs=
Received: from MW4PR03CA0060.namprd03.prod.outlook.com (2603:10b6:303:8e::35)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 06:36:31 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::b2) by MW4PR03CA0060.outlook.office365.com
 (2603:10b6:303:8e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:29 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:27 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 05/21] drm/amdgpu: reduce memory usage for
 umc_lookup_bad_pages_in_a_row
Date: Tue, 19 Nov 2024 14:35:48 +0800
Message-ID: <20241119063604.81461-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: f184931b-d712-4862-eeb2-08dd08648063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aiaSdJaCPDteQmnjfE3nXns/u6kYDVjeM+JPV71knyxd0Im+dlOp+/8iZn22?=
 =?us-ascii?Q?tUxbiEbC5XAjJHXUcKmiCzTL+Iiu4vvutDmo76FJ41up4CY/+Jy2fGCrTg+H?=
 =?us-ascii?Q?XnOM7UrUZ9WnsSjxedB9pmQoL0XMbFmBLs150b4JN4SpPWP8B4OezatC7izC?=
 =?us-ascii?Q?+W26iUr+YzPNT1f9pkTJzwPucQJTasFRaNUw5d6w1adM/ooCRlN5U9zCLOfX?=
 =?us-ascii?Q?43zqmIMbig/8R7uW0VTptXgqUT2OixW1kzINUD1EvJHazxBvK4TcodcvvuFx?=
 =?us-ascii?Q?Pn0ybT84UP5PwStz4sK4k4lac8N4JPFMf4SO6/EFeIgShj6L/geqCQzCQ2B9?=
 =?us-ascii?Q?3gOSCBntlDWSKn7NiWeOm0uqUcFJDEUeDgaPCzatjMePp2sWXwGu4lLnHDfb?=
 =?us-ascii?Q?arQgfL5UCrul1PGEseVHQrUXQoajIcu4hsjgxkVaFyKPrXkBY9v9s6e3Rt84?=
 =?us-ascii?Q?1vhJ+e+MIQI2BmM9xpktQhi8dQD3vClp8uI+Q7FZ2zZsKAkjvVsbDK3T87SU?=
 =?us-ascii?Q?3Oqk4JotBNt/oMLjZGiE102zAw495ahi1Rx1I6EpJaoV+xqJzkuZM+EKwS5l?=
 =?us-ascii?Q?se+rSUT7GrCf7KWAGHoaDEKr9YHD0x3JTVtAwEFQ6cm5GswN9aAJhRfavO46?=
 =?us-ascii?Q?H9fLX56YDhsc+6zteOJqeH19ditZWrNHq7aoix03JVmlQVRgla4CuM2RNuGc?=
 =?us-ascii?Q?/1UdYxw9QIl46I95VjmeE5itEl6ITF97BQML2SMm6Og1eGYGc2JpWll0YvzA?=
 =?us-ascii?Q?tCuAed+sHb+sURZdP3fGhEf0X0ERgyDXcEcX0teZh431Ay+CjCpu0mu2WLEY?=
 =?us-ascii?Q?ssJdmiKr8X0xVX6H2VEqDANpHU7I8lJwEk/2BOS1Oytv+YOq5TOgD3ec1Mh6?=
 =?us-ascii?Q?LZnyBG116aqw/BJuB4sJZnB3YmLbrRAQ2yvEwLg8JEfADl+nq+lYb71jUnyr?=
 =?us-ascii?Q?bzOK7kQ6rLF7OUmWC+PxxPMOwx1QWHKbjFiMRvngngMkEyLCdmZhZzAftznp?=
 =?us-ascii?Q?G0E/QkTvqBjdv895uy/nIBvwz/JyjB7lUOfeWvGGOqSk50t1NKEgTufIN452?=
 =?us-ascii?Q?3rJYiprUuZTSyfMZGPd1FbGQCY8imXP8TzUr8Wj4ydKtffYS1SkK3G3c7IYX?=
 =?us-ascii?Q?kqXN4cvHutyKpNMj24f4CxMeqOUlithkKzFwL6NuqgYHRFqJDeFSWUnij3kr?=
 =?us-ascii?Q?dDM+PCXpxgMFV6c98qvbhizWYsmsF0vEbDLmTXd1EAoxbmlcvb+P8uIrmnFw?=
 =?us-ascii?Q?/eLqtkB9OQgqeRP/XL4qesdjW37phOyLxalJYfRynoyBLpaqNEm+Gp1hHuOJ?=
 =?us-ascii?Q?teav8mIRdZqVEdTkwbR1zP2QZBgLWeO9IX3ugb6kF2r2WSTiuiZenRXtI9Jc?=
 =?us-ascii?Q?uw6vpPEYxYOf1p4ZjYu0aAnSQUOMcjv1dtAVwra1g+QY79WDxw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:29.8544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f184931b-d712-4862-eeb2-08dd08648063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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

The function handles one page in one time, allocating umc.retire_unit
bad page records is enough.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 75ded3904ee7..c0433e6471f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -454,7 +454,7 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 	struct ras_err_data err_data;
 
 	err_data.err_addr =
-		kcalloc(adev->umc.max_ras_err_cnt_per_query,
+		kcalloc(adev->umc.retire_unit,
 				sizeof(struct eeprom_table_record), GFP_KERNEL);
 	if(!err_data.err_addr) {
 		dev_warn(adev->dev, "Failed to alloc memory in "
@@ -470,7 +470,7 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 	else
 		goto out;
 
-	for (i = 0; i < adev->umc.max_ras_err_cnt_per_query; i++) {
+	for (i = 0; i < adev->umc.retire_unit; i++) {
 		if (pos >= len)
 			goto out;
 
-- 
2.34.1

