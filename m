Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31B4CCFA00
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 06:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 448C210E529;
	Tue,  4 Nov 2025 06:58:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w0pbg69c";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B31D10E527
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 06:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2Po8YFDqltE68SF5ix4hj5F2mf3p/curOoz9iCreZLfj3L0mgIu12X9/LNLADFIH6p3D3b2UHsccLc7L1Nd0RykJNNJLh80ij0wAEVbbLc7mmWolMvYLGkP6JJ/t4qWiCAYnCsYjvRVI9iPN6f0LKXVXO5r2ukUp//xWF46jxHA09ieflr+155HBSA8GnQXL2qpjD+yljAl9uF+8NXfKS8YxOBaWfqcgE13Ob8UlLzFpUD9mtY0xR5g2WafPQ97Ss62Ur6RrRcCVkVE7V/NtbiMddUpeNMAhUrHaV0ls97skvcxvnEWDn/p6zBSkTzuMKCu5VESj5DqpXJb4x565g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQx8krR9KsfrwSy0LTBaDg3cSymlu80g1HqTccfnsK0=;
 b=JLHxHduCK5r98HZoXQrKKsXVrN7WgYzWvySWmqSAeGIiVnIqwQe4UldvN0WJSNmjrJeRJbH+xAbh5hpHpmsvU9X4940+mYIZDc/kzq4C/VGdoX1RLmvG8/0SReDFEohybg8OeEIhoLubsJ4pzJ5qtE8PwGf+FQ4eHbCcj12Hj3CHjfBCDz0FgMMwPGC05SHRjzjrGx4BmpPXIr5ippox9LiY7c1piSmQqA6C3gcr1GlFzipva8S0pzrLk+b2d00qRyQhRmmqEO4IVm0uTL4Ak5pZJfJtKBDaqa9+gUwiczhGRjnMsMNu6Ueawdc8rz5d5mFBa9bLXEyXxFT0mh8VeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQx8krR9KsfrwSy0LTBaDg3cSymlu80g1HqTccfnsK0=;
 b=w0pbg69cxfFVbYF5Qhq/sV9VTXTUl1LZGJYbiEOiFPDUfVWND6be1hFW6s0Rz3N+LC07JCi1a4ErlHpfu71L3TD5qVXjiYnmgtdSFB0GqQRZacNBO0cnNPipNyEm/1OwHa8GI2J4r+ZZ87BeZjd0U1IUa6qpLjPuVoLUViblgCk=
Received: from MN2PR20CA0047.namprd20.prod.outlook.com (2603:10b6:208:235::16)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 06:58:25 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::eb) by MN2PR20CA0047.outlook.office365.com
 (2603:10b6:208:235::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 06:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 06:58:25 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 3 Nov 2025 22:58:23 -0800
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 07/10] drm/amdgpu: add initialization function for pmfw eeprom
Date: Tue, 4 Nov 2025 14:57:42 +0800
Message-ID: <20251104065745.1737050-7-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104065745.1737050-1-ganglxie@amd.com>
References: <20251104065745.1737050-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: af5a73ec-72d4-43f6-584d-08de1b6f8cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Iw8BsBkoi+GocTg63iqw7Saof1k7m6xyGAA1pNBzY+Ow2obfOHCO6j6cgFw3?=
 =?us-ascii?Q?LRbpCUWAg5SmeJyagdHJjfdzpzml1EuX7cCNkSvzSEJ2frlfc/vDOxPTAFhK?=
 =?us-ascii?Q?QOS0crD84aghLMyp+jLcdviQ20VlnXbDcegqYZns4s6GRw+uAkXqDgt7V0dV?=
 =?us-ascii?Q?NwLWJfaoDQR0jOL/RZP1+SZ/rGIuD/uCfRp4WTPEugrHFKu++rt+lnMyBJMy?=
 =?us-ascii?Q?Qm7LeLMwDj1/Gjq1/DpjQNZG5btnwOHXOzTQpNey2VoSJqrp2YBwHKzW9wFe?=
 =?us-ascii?Q?KkPI5NKsyDWc1eYR6tINjZ9vmmRZlhWCsmQFEJ5esxJpbsdCJGwWXuM2ZGtB?=
 =?us-ascii?Q?XjXAzRLeG7mib4D8W22zvWbGMKNB+DwFkWMzUQDTb5AeCRbm8CQd11K12wkn?=
 =?us-ascii?Q?oyVRLsGRx1nE9lK+GzxRarfO7te7kjBh5BkXFRU1C1+jUzIiJDHvct4xD13R?=
 =?us-ascii?Q?qd171SdpL57C21YGBySbOV92D3JurCC76Rur7EHqs79z/uJ82D0jIJ9Itb4m?=
 =?us-ascii?Q?eHLhruu6XkMi3N48USc3FCmtjmAnc/9hNsNSv8ZgFTkIhiR6PVRyyhOrlGug?=
 =?us-ascii?Q?1SurMw0YYkTSz1kba/JVm8lhB53PImr21IgJZG/k29olB1lW346XhsKcgVYD?=
 =?us-ascii?Q?uTjvz3KEw96x7XmGQGDbhI140J/2jaJLVrUlktcGvyUVKGxj66uK6TfRlNIe?=
 =?us-ascii?Q?nHS8a2AtdPBt+jcM0P8PGzkuo0f0kXqC0XmXz+NiMu7OtdjGwOqZBN3J4HJo?=
 =?us-ascii?Q?fcVLb4jR8FYlkmc1d2iVKJ1FRwzPfBFHJQp5H9M542OpiclZBCvKEEGL5FRX?=
 =?us-ascii?Q?ZBQkr2j9RmFyWakUTkczu6uYtg3+8Ih/YBs45Tlw3GwAIPwC//KC/nbsuEWX?=
 =?us-ascii?Q?Gccc2iAlglcwYg+DTgmumvBHOgcRUI+0AE25Nvh3URYOEkIdNO1RtlsoiKer?=
 =?us-ascii?Q?3jvwWOGNuSNga8mNKRrYy9GXPoZ5Uv/wfiOGDRAdcxfH9v33MrTiE+VJOWKQ?=
 =?us-ascii?Q?Adefavoa5ZXSkqkkwIC3sUwpvKp7M9z4VGwHVSX8gptxL7LdMWMXGlGWhoG3?=
 =?us-ascii?Q?wxsV8cM7Y4yzT6dReL9dqt3Cvn3SPM6JpK2OxwbL5bIt5UN17+Wgoh7Bh3+t?=
 =?us-ascii?Q?L1wAE1Rsknsu8VL0SYV4w5PKeogYnOIc4NHlGCUYrRMk1TUern/bhthO7y8l?=
 =?us-ascii?Q?S2ShXUM0UiSHGadImRBAsthp6JTNExbr7zt/o4Ah1dVSe/haX+Y35k07Cp+G?=
 =?us-ascii?Q?pwkdV2zxpmzKpedYSeOxE0fEQNE+Pv+QfYNsxRI2E8lYA42On58Ltiq4viO3?=
 =?us-ascii?Q?kpenbjnWwEgiDlJHMCUeyvK/sQ3nPjPJKCJXMLX9IxjjfiftQaZoA7hvqS7F?=
 =?us-ascii?Q?HGMUl1OW8Z5FqAWlD93UqQ1Qy6eq8JQND64E4/pDdSGhrPAvmnEPOeLGCQ/b?=
 =?us-ascii?Q?ia04KktXPbAmyRexK8LCKoHPOnuvAfDLOJJ1HSwv5K7qhrDMexF+wWRZbIha?=
 =?us-ascii?Q?Acg58Nz24yuGvRV+BpnsWMMiVNLAvshVIuBm+AS1OcHHydOYi7wWzVSnRD4X?=
 =?us-ascii?Q?g3yJ9WxoxuVaYjCB6fM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:58:25.0740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af5a73ec-72d4-43f6-584d-08de1b6f8cd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897
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

add initialization function for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index e9c5781e4376..6b51574530a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1386,6 +1386,42 @@ static int __read_table_ras_info(struct amdgpu_ras_eeprom_control *control)
 	return res == RAS_TABLE_V2_1_INFO_SIZE ? 0 : res;
 }
 
+static int amdgpu_ras_smu_eeprom_init(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	uint64_t local_time;
+	int res;
+
+	ras->is_rma = false;
+
+	if (!__is_ras_eeprom_supported(adev))
+		return 0;
+	mutex_init(&control->ras_tbl_mutex);
+
+	res = amdgpu_ras_smu_get_table_version(adev, &(hdr->version));
+	if (res)
+		return res;
+
+	res = amdgpu_ras_smu_get_badpage_count(adev,
+								&(control->ras_num_recs), 100);
+	if (res)
+		return res;
+
+	local_time = (uint64_t)ktime_get_real_seconds();
+	res = amdgpu_ras_smu_set_timestamp(adev, local_time);
+	if (res)
+		return res;
+
+	control->ras_max_record_count = 4000;
+
+	control->ras_num_mca_recs = 0;
+	control->ras_num_pa_recs = 0;
+
+	return 0;
+}
+
 int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -1394,6 +1430,9 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	int res;
 
+	if (amdgpu_ras_smu_eeprom_supported(adev))
+		return amdgpu_ras_smu_eeprom_init(control);
+
 	ras->is_rma = false;
 
 	if (!__is_ras_eeprom_supported(adev))
-- 
2.34.1

