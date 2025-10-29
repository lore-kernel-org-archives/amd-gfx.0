Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37099CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 07:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C256910E710;
	Wed, 29 Oct 2025 07:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="27zo5WiB";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010021.outbound.protection.outlook.com
 [40.93.198.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7143310E70E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 07:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeLxAnszC4I3+YVBwQskPS96cs8oQ0RrXU8W/SaniAFy2L3XQbm9JiLswZ0pkntKCxXy2wgihCqt4FDgAejgMvMh5vwpUSx102bdhyDok2kikNuKdp4qfeZTxbHm/4gGMRVP/d8XUsNYSu/+b7jgrhqNQHM0zUoEpOQ4ZZON+JExclqODY8NuPY48mI9Tq2g4RrsqXi5CjlQ7OgnDFc95p+lM7wKDDNwq3MHfdRwKSRvz4ssjiKCDZkzVfJj1aK16XQvBbg8wBC43jTrkLEWa5Fll8eYUxCtT/VgVXrpOHzdroZrmNViiXuih3pPtlSsb7P0wWr9eMmFdvig0oYMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09mbOp4p/cvTUwgZrMyBM/3+F7+SadADYL3T/nqpiLM=;
 b=RcEHQZhvVVqXy1cKXAk63QGykwq3s+iCqdxroDp2LXWD5Ep/M+jkViA3X4P3yA/GCTdqB7+xQYcW1agJqD5A9R3R5SPci948X+cuJ8C+738abu8sBoz64bDBgW+6/89cYD0Je7cIGakuvsxxmHgGQR+K9aVHI4jIF+Bc5zahm3Ma39HEuD0iGsOvwJfFnwp4VfFmhaz00d57QA8xb8mIXR5dHS+jY17joj+VyQ2hhqUBvsgCRBdp3NKNjboA99km+jq4XPYm6E+OnrluHM+YoRddKWgWmx6gtZf3RQRKXBlje3Of8wZ+dI4muwxZpO8PasnTm+UfI+8twWo4UXE00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09mbOp4p/cvTUwgZrMyBM/3+F7+SadADYL3T/nqpiLM=;
 b=27zo5WiBTI7srKyCQDf8KQpFyolKAxHXmx0afP3g6hBLoH2OWh+oW5RLsJxiiOt6e5kJc2LMQPQ1n/lsCpqzMxCOt/b7e/qoI/5Zm3t+mhwsB5Nwiy7lT8P8S0vByQOhKYSOx0qbJd+wF2MBWNDx3IviwjsiFomEvvbqI7f9Wnc=
Received: from DM6PR08CA0020.namprd08.prod.outlook.com (2603:10b6:5:80::33) by
 DM4PR12MB8559.namprd12.prod.outlook.com (2603:10b6:8:17d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Wed, 29 Oct 2025 07:32:11 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:5:80:cafe::f4) by DM6PR08CA0020.outlook.office365.com
 (2603:10b6:5:80::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 07:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 07:32:10 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 00:32:08 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 08/10] drm/amdgpu: add initialization function for pmfw eeprom
Date: Wed, 29 Oct 2025 15:31:06 +0800
Message-ID: <20251029073108.1698129-8-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029073108.1698129-1-ganglxie@amd.com>
References: <20251029073108.1698129-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DM4PR12MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6b8adc-93da-490f-c335-08de16bd45b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XxSrVbq0+PweNTsGoei7XO2t6ZmTz1w43tK9p54vZ+JRAir2glyy0WjWtdlG?=
 =?us-ascii?Q?hduQ+c5+bSNqzLu0WOstgcWI0cus+cIyVyqv8SY1afLIm1lxaSyQSZ5RTOSV?=
 =?us-ascii?Q?PecIJplKFDAbPHNmVF9NDLjE2oz/RbYqp8197yZhhB9LNs89SthDnmr0uPAb?=
 =?us-ascii?Q?BucKXR3LvHRX95jzZUu9DLw6yFZtd7VoNFQ0ZUsCwX3CptQViY6SDh9rhFpJ?=
 =?us-ascii?Q?r8jPDe1xvZqFbO/ZZJCD+4Z+f9IB5pe4Xhu6jytOmk3ZBtsNdnHqUGwCwe4H?=
 =?us-ascii?Q?HqXCanKttbws8IetcP+2AfpI+Yo4LrD69xEmhyw7mn18e9UWeKQCSoz1XoZ7?=
 =?us-ascii?Q?Qd1bKiFUaefbmhve6XKhM9mOy283tH0wLlbTPDJ068H4XGktPn++3wnL/spU?=
 =?us-ascii?Q?EaW3hF5rxl3V22I4x4gZaEBDBEmqgNLuAPKlfnr+RhaJVHaRGRiUz/apFYB+?=
 =?us-ascii?Q?lMEYqVIVwmV821ogVLUeiPsvSHct7lIM/dzL3jKDi2+Uc/zUayZNLthdBClC?=
 =?us-ascii?Q?8KBslpEIFbSMc2Xr7ZAuQmamBj0jYXPGHbY9d8lePm8GQPZreUyKciQUTK+z?=
 =?us-ascii?Q?Cbtv+aZ1tAwDyrrqApq4I1Y+E96imJkngZy1IBpaRQQ3NKXG2YidsvGdlvEx?=
 =?us-ascii?Q?w7bywUZOHQfV3WratTbkpJSLKBQcw1Xa6bI6rzoDgfv2a0JNFgVswJIEFz6U?=
 =?us-ascii?Q?BtjscJYFAM6DXUsHtyqWPttrpbeoQL7PEx7oj0WfVccJhJj/28rPhjgx+OGM?=
 =?us-ascii?Q?I1XV2jEeycBC24jjhO90bB2jKJm0i8kfw+WytOuhRqhaICZPgfRDIjTzDhCH?=
 =?us-ascii?Q?WrZ0MQUrU6J1JlW7CC4ojFl68nen6yYgUP9+uWU2JJjcI4HTWLHKC7clzpnK?=
 =?us-ascii?Q?AZSa6xedO/YZ7N/+B1eQnbXCUkaOGnpH45QX//IUl88CQpVlReyxc4XSn0jr?=
 =?us-ascii?Q?NkXPOYD4p8mV03XmCMH6NBH0ZYQ4vKIy1LcV7xJE8TG3FMx9mX/J++4/1WCN?=
 =?us-ascii?Q?wFSAKf3/eyi1jcYO1zpU75jhBdexdrE29+aW7YH+52TH/9yLFrgIjb0FtrAt?=
 =?us-ascii?Q?ZdbPUs3ur99xmi0Q+7KhXu//1IO5JtO0d9OHBrYKGG4h6eqDGvDOK2vLTtmA?=
 =?us-ascii?Q?9mAsdrZeyI3bfSbkrShZNmjvqRgCNXUoGM/zGxEahqg5U2OeGern9yaNuhqN?=
 =?us-ascii?Q?8CRQXaq/BBFV99UY2u3AY81vmuzRtRjxBx/VD8R6fC9P+RsB2aRFpfeglY35?=
 =?us-ascii?Q?TJ4dBNKoMRmmi4rd/MaeTDN6UGNuTMUxTabnFBoDLZ1NS3sPloKLiQlaPsaL?=
 =?us-ascii?Q?mYjW6ETY262jIfvtufFCyfRHcjWF1qOiyAzWQChACpsBeMv92S8BVRJrrRDp?=
 =?us-ascii?Q?rv8+xE2CV1y3nEvJrNxEi+T5AXEm2/geEfluzc58Dw9RoRXCHNdty66PYiLY?=
 =?us-ascii?Q?HRXIdK+4hSo5o4q9WfK5XAokYFIniUijlcvgJ6XhUcMHxxe+WAu9d0/XcRxk?=
 =?us-ascii?Q?4JQODqViDM8I1SEdRsgNVbyV8wXWspG5LOx/e3tqqQrTU5Yqu2ISxEE+Yumz?=
 =?us-ascii?Q?azF+DOpxi9GgAyCh7DI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:32:10.6495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6b8adc-93da-490f-c335-08de16bd45b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8559
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
index 7ee1a758a051..fafdd7b22316 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1385,6 +1385,42 @@ static int __read_table_ras_info(struct amdgpu_ras_eeprom_control *control)
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
@@ -1393,6 +1429,9 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	int res;
 
+	if (amdgpu_ras_smu_eeprom_supported(adev))
+		return amdgpu_ras_smu_eeprom_init(control);
+
 	ras->is_rma = false;
 
 	if (!__is_ras_eeprom_supported(adev))
-- 
2.34.1

