Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E91CCF9F6
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 08:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B8110E764;
	Wed, 29 Oct 2025 08:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V+e38y9g";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 681AB10E761
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 08:48:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRfEDjqd0/dMh1E+HFTIK8gouWmH3IOXyWfuPSBBvLafXmReOv4MH2KCuHpFvRFGgWdvlfY6fhig0G3Ms02CFd8J4dLLtKB/uYibng1QOhfmb6O1La2Mi/MrcSomiUdWZ2KVpeD4dE5Nc7kVVsOcNe4Ny10mleqfz96T2X33WqwKjuZEdpUFadwbZiTa0rulVkpp1qVPVDPEh4JpRK0MFJ+7DXAcXg5OaaNYr9B+aq343NcgIqABc24QNBJBkN2ycsFJUE4sDUb8Bm9LRNseiU71oVgNJXbJWJ3M4vrlwhv5IKfuTRAzLwrdPAK6B6qLTAH1qkrJ8i903b2qQjOwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09mbOp4p/cvTUwgZrMyBM/3+F7+SadADYL3T/nqpiLM=;
 b=Ns68+omaS9wBrJveffBU/cVbxUwAd2Egt86HmnL4P6c9b4uIK5n9gOpyIJ2xAKpOH/aQixfHbXjVZA5bEpgZNldcjoGkh6q90b6DWt2eJaE+iPe/Xd6/KkoL/qM71LY0uNfyBkVponhijTv1Ik8l9xIJ9/ZTvnl0mNG/ehd3xsrSkDMqC8Mavl5NCRc12CBVqAmvuQgzNOJ1pStpO8Z4Q4DHBEbJopqC2tUtCu/1OdeOsSuRRXQiFXmPIIY4bMhcgOdUZpjpQz1xbLHp+IjBxANpfKj71jQBDO15QaYpAn3ExvkSlZlddAh3/GDxR0GsrXkannTud9d4ksQUJ7L3dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09mbOp4p/cvTUwgZrMyBM/3+F7+SadADYL3T/nqpiLM=;
 b=V+e38y9gfAjb9hxnqZ+v962aO1EtD3MA/zaTARiefGWqJO2645dJXClyUE4OiN80rTi0WrwK0pSxEfB9y/HH96NVgzyNp/22o+RAEGsH3+HyzsZR5P0pmWCYpA4/22mUeNfp4IoD60+eKw18PXo+0MkEMDnxjbPMQUWRH3BcgNE=
Received: from BN9PR03CA0433.namprd03.prod.outlook.com (2603:10b6:408:113::18)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 08:48:23 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::d5) by BN9PR03CA0433.outlook.office365.com
 (2603:10b6:408:113::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Wed,
 29 Oct 2025 08:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:48:23 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 01:48:21 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 08/10] drm/amdgpu: add initialization function for pmfw eeprom
Date: Wed, 29 Oct 2025 16:47:49 +0800
Message-ID: <20251029084751.1701305-8-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029084751.1701305-1-ganglxie@amd.com>
References: <20251029084751.1701305-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: c69d946c-4a6b-4bd1-7167-08de16c7eb18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8YJq69h9i72re73lbIwhjIe14WgKo7J88rwMsRPoW6+qjlKN+kpEIZUnGBOE?=
 =?us-ascii?Q?QYIkwtWfctSrQLLHNc94GZaMGt9EA14Epf4MDlpsoXhWjKBtDtO2tIQxndNC?=
 =?us-ascii?Q?E0Q+RuummC/F700G3+qOXTUNCqFY/jh7u4G2Rp5xqcOstZw8xl9ZJ1Yl3hU8?=
 =?us-ascii?Q?ZGPWIFNzdNy7St08bpffMEkZI/kIz4XRB3HcOZaKmsCq9qTLatWuafFzP9NH?=
 =?us-ascii?Q?T2D7KEz1JJi2fPQzBJJdV3BY7GXy4edH9qPObvqJ+CkfvIb7aClsmYkJY5KC?=
 =?us-ascii?Q?PT6wKJqFE0akKpN/7NuWONKAdNqPonKprBXYQ/EAAjJj1I4dX6EIvRksGOLr?=
 =?us-ascii?Q?YML+vVSNF+iS/pBG7UsHybgTvNUHKz4dbCfnkcaQGzKjfwqlxHNLKmJKEc9U?=
 =?us-ascii?Q?pL4KsVT9Txmal2DPl72rn7mwPfgUEcDheLr527m2U8k97Xz9EqrCklKJVEzJ?=
 =?us-ascii?Q?MvdossVTXkivy+2q/Ge5l/9dfk8XcYZBjClqkeVZN/j49f8K/UoFAP+4GZPO?=
 =?us-ascii?Q?wcO6cu7aWieTPdlCHkZZm1fU3gCaS3N314TnZ+2EKVtDcgwc/RORlrmbcV6F?=
 =?us-ascii?Q?l8Wcs/a1b3ZMBU2FEOmIZUXmVx40rkDVwMR/+9v1Cc2qC/c8rBzzuEUzkehD?=
 =?us-ascii?Q?UBC7Wwj3SN+w7IJMJXpZrtiwYVpjIpbnnJE94hIZ0e6st1RxGRRvi2Ulc7lk?=
 =?us-ascii?Q?eJjqOYF2joL/JlOXZ6yFBWue7hWFK8bZHYRrTIUQAtGBN3fjndEKTNzjM35A?=
 =?us-ascii?Q?99c1GNR0o/54t5feKxwDHNknhmocrW1asKaJd8RdbiKydbYmlTrz3Tb/ivXg?=
 =?us-ascii?Q?tZRu9a5yYhV0bqiAH6Xx/oGcxCDR8NdLEcAfjYx5xMaq+OdzYMhpLtx5JRbX?=
 =?us-ascii?Q?aFT2FmoX8g/RZ1VcIrQaCOqvWeVgSfCkKYo5xCUwOuR1ZgWRa2LM7OnUGESi?=
 =?us-ascii?Q?Ocwks1/Qc9hmS+kyiFfvYw6xlaXrUrDkH8CDBAgYIYqf7ucQOp69DZ7zyhKd?=
 =?us-ascii?Q?7n0/HEWau5Xizg3COlsOU4SlACRBGx349IWcM+vaB+hx9HO9AfotUd9gHHd+?=
 =?us-ascii?Q?mEOciwW/sgo5YTpVgarFfopRzcgBLIJI1jttqbcUxRowaSsp2Hpyxz59fYgm?=
 =?us-ascii?Q?AqtmUylD1plPLdvEQcSyM/O1zvgFcCn0Zlb2zzEfhQ6s+JcT5S34ol5UVY43?=
 =?us-ascii?Q?TS9lLuvLuZfxj738kjvppM9ktzK/BDzFf8/GYa3woIEOwIbArxk5fFZ9FQPL?=
 =?us-ascii?Q?SKAaj3SP3xFv6J9Owro6huttmD64VUUddyPt476i8zk0YVhF0FQnrK9Am8lN?=
 =?us-ascii?Q?EvD6SWPFqdTt+JY62BMKZSa7GUufnyje3NDRD47nMakrjliQtZn+EHAuLS49?=
 =?us-ascii?Q?B6vkScOprI4fmBBYbeDhO8+suCnjVzbZbyWjpckC+YlMZsGPFKHwFrrsurwK?=
 =?us-ascii?Q?dPG8tdqqrWJxWv52S7rXF0NqUPq8bgdEm2x9qE2X6qrpzuwMyP5+jMBSltH0?=
 =?us-ascii?Q?4UQ22uK1PJSKFGe7C8KMuuOy9VagtO7sopSjUSz9lPLjhhPqaHBl9c0Kmbpn?=
 =?us-ascii?Q?n3U2T6J1+dsAlWIniNo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:48:23.1319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c69d946c-4a6b-4bd1-7167-08de16c7eb18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736
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

