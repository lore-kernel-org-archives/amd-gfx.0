Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F364CD13CF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 12:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDEE010E57A;
	Tue,  3 Sep 2024 12:32:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YBGDv5ao";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B2BF10E57A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 12:32:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsH/FLtruvc75W/b1gY+XSCNrUHQ75UY6ub/JQHbzJbR8gUzvGE25C60YOTcP6La9FfBueh44j8cKP0+lGqAyUAAU117az4Zl7xEQTKQGjKumOgzKeu7re0AQ+RAzG1jmY2DwZkDKrOLXLH7ecTeY2aXU8JMvggQ9wiVcQT8jbQUPc/UKCX9fDWtFPgfA4jJbDARX0fIuDPXzgrnGR5FcHaqF4ESyiC651fhnUbYpHbL2ZFxXHfDH3vcOzXkMRTG9kFWL13Uu5xGvKDTGC5+KEiTbu1wMfgKJ1ZaS6lOvPUGw++jSkc5azAqa8An2uvFc7A8Q8X7h9Huwe9lJ830jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIVCAS7gnuhNr7ygZplf27qdStjvbghaMkCO5Hhqmic=;
 b=cTgVnInl1kGcn/Sini2KeQ0TVdhK1mBmxAi80Ui03QdW9Yx7lpBpeUNH6mAcJQSglmjJo+deSlVmYJscoFI5nfpPCAbtAjuevbNAXUt0h2f9040CmiO4IcOSiEjH7/2HZVKef6E6qWfKIjYn/nlXRB2J5aad2l/g4mZFwvYv+OsD51t5bsEpFUtSzPzn/xrd7DTyQ2nHr06L6YgNcP22vy/kjngYxXqG1f3wxfvfyslYS2CvSR79zLL0g5Vm6aAPsUEkGB0mQqPGaybzPQJdjfDF7uhXbMsNzEVP4bgVapdayFKqgQI499i12k4A8nxkUTJ528cqzilI4acPEdteYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIVCAS7gnuhNr7ygZplf27qdStjvbghaMkCO5Hhqmic=;
 b=YBGDv5ao2xM0VbUAk91USu8Vm/cNyNhwsk3xwrveDX1DgJVidvnC8RMLMsu+OI2HBYqcj12fZvzSF9PkOoh8wW96QQX0qJbofUaqNfn+4LhDl5are/gJeKHZOYKZlfVj8lsr9brGZeV/I7kzBZ55DujmYeridJ7n9R6uFrH9TUg=
Received: from SJ0PR13CA0206.namprd13.prod.outlook.com (2603:10b6:a03:2c3::31)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 12:31:58 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::91) by SJ0PR13CA0206.outlook.office365.com
 (2603:10b6:a03:2c3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Tue, 3 Sep 2024 12:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 12:31:58 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 07:31:55 -0500
From: Asher Song <Asher.Song@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <felix.kuehling@amd.com>,
 <thomas.hellstrom@linux.intel.com>
CC: <bob.zhou@amd.com>, Asher Song <Asher.Song@amd.com>
Subject: [PATCH] drm/amdgpu: fix a call trace when unload amdgpu driver
Date: Tue, 3 Sep 2024 20:31:36 +0800
Message-ID: <20240903123136.555278-1-Asher.Song@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e45d68-852e-4719-568e-08dccc146747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eG1MNllDUFloc3JZNndSMXF2OFZKalB4b0NWdjBLU0p2NDkyTUwvd0xGcDNZ?=
 =?utf-8?B?K09LRzU3SkkvZmNaVC83VjJOMTEvRE93M1hIUFR0NENxcENEZ0RDU0Z4cDJX?=
 =?utf-8?B?K0hQMmRmUVJBTmxhWXFtdkpGUmhJTXdvZzdYYVg4WnNKRkJ5bnNXWFRqZGVQ?=
 =?utf-8?B?T2JUdXN3dWxINmx6b2F4a0lCTnk0aEViUnNEcmZOc05LY2FVSzZCT05COTZZ?=
 =?utf-8?B?M2VWYnM0cThIREhLZjFFSmo3NFNUTStGNkYxb0dpT3V6WjJNYXA0R1BXTkxX?=
 =?utf-8?B?UUxJVWFUcmRwczEwNU83TG16SU1qcWlRYkptdVhQa1d5YSswekJsVWpBVU0x?=
 =?utf-8?B?ZlhpaGZuNnZOSXVMTWtaMCtVU295WkNlb29PZHI0UkpORVJmRHdNR0ZiK29a?=
 =?utf-8?B?MmNhOUZJY2wyVFVJSjVvNjZ3VjlRK3hGcFRjT1VEbGEwZ1pYVE0vUlNrYXU0?=
 =?utf-8?B?NFllR0ZIeGJNRzlxem9rZ1FBVzQ5amRUK0JRNStScHZwY01KWlVCZzBURWdS?=
 =?utf-8?B?THljTytnZEpSWGNQa3BrYTJXM0R0Nk1aVHdTWXlpb2ZUMEFqVFU2d2VzalNm?=
 =?utf-8?B?MGVpTURRb3NhbStERzgzZng5MEk0cmFYektKZjNLQnZEM28rZnZuZVpsRmhC?=
 =?utf-8?B?TElFN2RoMFFqOUdpam1sWlM0ZnpZY2I3T0xYVmVUTytqTWlzMTlWeWx3MHlr?=
 =?utf-8?B?TXRqLzI2V2tXYjBTVi91T0FibGJ1Z2Q1VElsenFlb1pmRk1FN3gxTG82UHkw?=
 =?utf-8?B?ZWhnMDU4WEluWUZOc0Zyc3VKWVF0UFh1OXVRUVU3bUp1UWM2akcvUGFjaUlv?=
 =?utf-8?B?a2xEbnRaY3UvWmRlMnhSRUNQcTVYdVk1VWZweUpGK0wvZFA4TGxGeEtoU1Y4?=
 =?utf-8?B?ZGFpL0c0MXp0SVI5WThVcmpDdVVDUzRpTVVudEQ3b2MvYWZNUGxwOUs0QkE2?=
 =?utf-8?B?MmFCS0hxcDAySW5uK0gxUGZWbFNmS0tYWHNzRHdyR3gyNWxiSm1aUi9yOWw2?=
 =?utf-8?B?TG9xSUthSEkyNDNRai9CbEJUT1FvZkpFUnhWWTFCcnlKRkxOVFVhL1Z1Tk5a?=
 =?utf-8?B?TzlQM1pxNkx6VDJPTHIvQlZ1K3hWeHNTazRGaWQ3WDZDTi9qVkdKMTdYam1l?=
 =?utf-8?B?WjFuTEYxeU5Mck8wNkhxa2p0dGx3Y25FVDVJNVVkeU1aTjZCT3ZhMGV0ZnYy?=
 =?utf-8?B?NWE2V2Q0c3VaQzBRSkR6T3VReDNLeElWUWdnT3d4L3JRL0xxb1RNeWpxV0VI?=
 =?utf-8?B?bVRJSjVjSVExejh3T085UzVFR0ZqRHQwUCsvVGZLZEd3TDZWMk1SUHVaVkl6?=
 =?utf-8?B?MU03bVducUtra2NDZkZZNGVDR1h1cWxWZXpNTVkyNnpBRzJSSmJjelRXUmFS?=
 =?utf-8?B?Z3Z5UVhXNHhlWnlDd2JiVDJ0NFltRnloZklZd3F5WnlBN2xKVWt3TDlOL3RV?=
 =?utf-8?B?RngrY21pQ3dEd3hOWWxRSXV5UWE2VElRQUpmQmR5bDYzVnh4VE9EUHN1ZHpv?=
 =?utf-8?B?bHd1cXp5emYrcWNTY284WlBubVA2Rm9mSlErT20rZERHV1ZOeVdJVlNSOWxa?=
 =?utf-8?B?MjRyYlYzcUJMU0d3cFBzOS9Hbkh5VkNaYUMvdU5SSVlDRVJLMjBFTVJVTVdy?=
 =?utf-8?B?aW9hclZvTlcvNWIrNW52UVJXbjN4TUVhd3MzVWVUUmJiTFVhd3JXNkdEeFd3?=
 =?utf-8?B?SStpUmxiVFE4WXByQm0zYXVYTXhGVVduU0VsYzdqOVAwakE0VkdTZnpGWnpK?=
 =?utf-8?B?eDdIMkRwMFFvUVJVNmc2d1hTSlN6ZkJXbGI0djY0RDMxOHI5SXpydWh6Zkkw?=
 =?utf-8?B?Wk84MFpkNFR0RmJUVFY3MUNQM2R3MzRUbHRGMDVXSlljc1pNdkNlLzg2ZFoy?=
 =?utf-8?B?b29kZEdIckNHSm5la29ibXhFTkhDcXUwdG01R1JQS0szdjN3SVhQMGhTNHV0?=
 =?utf-8?Q?pXHivMJugffiVOWrY/6QKXm7dBpi0xke?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 12:31:58.1720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e45d68-852e-4719-568e-08dccc146747
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734
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

In some APUs, the bo type of GART page table is ttm_bo_type_sg.
Those type BOs is released by bo->delayed_delete which is added in
ttm_device->wq, not released immediately.

To make sure all the ttm_resource is released before ttm_resource_manager
is finilized, drain the workqueue in ttm_device.

Fixes:d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 0a5c8d97787a..99017e426618 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2216,6 +2216,7 @@ static int gmc_v9_0_sw_fini(void *handle)
 	if (!adev->gmc.real_vram_size) {
 		dev_info(adev->dev, "Put GART in system memory for APU free\n");
 		amdgpu_gart_table_ram_free(adev);
+		drain_workqueue(adev->mman.bdev.wq);
 	} else {
 		amdgpu_gart_table_vram_free(adev);
 	}
-- 
2.25.1

