Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBD1CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 07:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA5BB10E70A;
	Wed, 29 Oct 2025 07:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QPH/ifLt";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561EC10E709
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 07:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aj1a0PuaGLy7wL59XqiBXr7D+rB9PIN0OpEmEOxgqveqQIRslyPCJSHxYlqMz3h+nIc7TkzNm3cAB6fGXcZt2BvpbYUTsVBSK9N9N632TAtn/KSlhcXH5c1EEhOhfCiFST5VyqH77sKblGngrR5b1e9VPYFcQXgJYHnOp03/tHWeh27k3j5zmDoWhwoYmqQB6QccViZPvjY8jGWO3+gYlwhns+vu3prr/ZvgES32Vgb28biqBU984bU2MMeCn4fTIgyknw5SpZVz4AeDAIp3/duii41kEDojpT127y7tx+As+GVRuYj2uE6awNl0YQOxP7u2R/uwght8O1p4L63O/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgxnC6RbmpnHdjC2VniT2oKhflNBlNEWV7WPbuf4u2o=;
 b=l07UybzUmyrrEfzkUCbyem8PNBIf+HyaTo2fnpYTBGi1CK/gig0qdWhRsSpuPMGZjYLSJVIS6nJoOp2kdnDdgWSNlPw3u7Rvu2gypEdrF0wYBPyOVIliEIJALhFB6m++QDChb0IJ6au9SwUz0SUFA/1Y9+DtsxxVywZGG1DQBFqNbni1i838Ez5sO95R2Y5QbpzlVA6GPIxk2YLzxCGeETdZXPQV52Av1hoxEhYd7J4YrnFQHAGxBxItbSM3C6RFoRdXF7GOkdurjHWABNKAjq0ss7CQ3Hq4U/BZJYeXxVOfYmZviBxJyy8tBiyCaFoCOxZgq84pvLvJkPNVfJLdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgxnC6RbmpnHdjC2VniT2oKhflNBlNEWV7WPbuf4u2o=;
 b=QPH/ifLtzO+fcgaKBZmRI6+D5ri/KDlXfrTs1Gli4468v45R1N5F+lVinqTn8uYhUD16H3DWh3HB7/j27EmOaZPXf9/RUpuTT8Pu9qeOcQTGpNQIqU6ES/YFaCI/9Es9T5wO+0abGkWr+wIKwIpDJbjffu6GnylDroA9IN5Lgyo=
Received: from DM6PR06CA0075.namprd06.prod.outlook.com (2603:10b6:5:336::8) by
 DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Wed, 29 Oct 2025 07:32:07 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:5:336:cafe::ef) by DM6PR06CA0075.outlook.office365.com
 (2603:10b6:5:336::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 07:32:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 07:32:06 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 00:32:03 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 06/10] drm/amdgpu: add wrapper functions for pmfw eeprom
 interface
Date: Wed, 29 Oct 2025 15:31:04 +0800
Message-ID: <20251029073108.1698129-6-ganglxie@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DS0PR12MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ca8d6a-855d-4aa7-57d9-08de16bd4321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BND9aoiWVGcjsTBtIL4LnVgve4UXcPC4T3E2BXNMPDkjuRcH695ZG63O+0te?=
 =?us-ascii?Q?rIudLDPAkHQZjUSTJ7PAnU/jJWAcSduMLonMrtkvBzkGDBznLfmXkEJs8GY6?=
 =?us-ascii?Q?vvJCb7VSoCK9se2dmDdkmiqzBL+fhzagaXuA7GlIINGEF1r9nJdiOW+ySt9y?=
 =?us-ascii?Q?qWZj5GYgy3ZoUatofrwC7wW0k13IJOaXKi+LVBwX/9d69cu0G/u96gAjdkzc?=
 =?us-ascii?Q?x/ApybKRbVolq86wdNUDdb+rT5Uhqj2sFBypcIboCMCoyKZDTrkBiEIJBdPN?=
 =?us-ascii?Q?CyUQRGasInxVkePnoAxHqhf+SiDmXCylPlsRlKVq6EnWC2DRZ51zVDx1sfep?=
 =?us-ascii?Q?TA5pOqQxAh6rMOwM2sN931dp23wWmxH8TlkQQN8WJD8dXb1C732kd7T27vmG?=
 =?us-ascii?Q?2NLtH3gxXFTxjWKtblbwtDFK1a939LvlFUr/tVvXChh9gEKl5qbPj6S961Lq?=
 =?us-ascii?Q?pRy7y/54MqvdWwY+Ct10IdcNe+Yn7nkrDM+g9pg5tZV3jkMABXiOCUhoVWrh?=
 =?us-ascii?Q?u0AWv/O+IwbSX0gDu4/iZfvaMuL/CichZcKeuQp+yGbHyNx8FnIqw3ZNLZZ6?=
 =?us-ascii?Q?YnCSRvE8mf/sp4+accpR8nDx1iOAXae+fp7gA9PdT1PXYhodNzOi3hSjr0+J?=
 =?us-ascii?Q?ZzAdABnYq1i07m7p7jZ+Izc/tjGGfCaVr6z7gSbm+wAINsLhZ5zEz6Q3nhBU?=
 =?us-ascii?Q?hZ3flpUc9v7CXkNyKEuoubjdKDkGZMjsviTVUxaJpmJo6d27UCcK5pSxzdwE?=
 =?us-ascii?Q?JeojqOJ4NlRkoKPo626xiGEmc8iJ/0shpzOsscSMXeH0mSSSbEd49s5bTeFF?=
 =?us-ascii?Q?t6QXnuutL3VVNZuKkF7Y8+o5KHSQ/yAs+dnaVB+9gUdjWTsidg5eApcy/Yjt?=
 =?us-ascii?Q?kNxdsFNJ6OjJoUvCJOVAu/jChMNio9RaGt9GfhCBxTf0lLwCaC26dqXpMbKq?=
 =?us-ascii?Q?uIF3ibjMM7jNy3P7T+yHKr2Mn2q/ppMTmGd67Gy52WS+naVEqbdNt89GdsN+?=
 =?us-ascii?Q?eQKcO0Yev4s2MG6FEhJPJi+dHQ2n7fN3yrEI2PkXOaBhnynxa1ofzo/2yVYM?=
 =?us-ascii?Q?M5HLdevj30PfKNxnk/y39PgZyCjf+MH3lghqLK9e5MQa8GDb0B+l7F4/QoSR?=
 =?us-ascii?Q?1KGylFhVbiy0uQaxADXdoapMH6cSASfP7aCg57ip4f33faxmzws+4lZIfY+p?=
 =?us-ascii?Q?Uh8FA37OlAWF9nk3RKrqN5d4jtPabuBuEDpA413zaVpPNr/9641TvHy8fYKt?=
 =?us-ascii?Q?H88Opt/nv8XjxWzvlET4uD2F+2KldZimp/ueuO5H3LXovq8ezuHL4ylAUXJA?=
 =?us-ascii?Q?Up8BbOVDCdkICoypqnarW0kRjAztVR09dWmgCkiDyKvPF8TiLfFfE34K1x/9?=
 =?us-ascii?Q?Scs2G8UnA77wPztvydKW/M8k22v8nI0yu7UTAHj0csMQwGKQlXgCNlUiJXAE?=
 =?us-ascii?Q?Trlbh4L5NIfL6WbjnfsbUIgR+BJDlwCPC+XtkCXSsxAoiexASvA0Ocd2ndKC?=
 =?us-ascii?Q?6oGq8xcY4CBg2LBU7wMsrGNlHZ1A5H/XgBuVOjYrLBwbeEDDLTmTSZr7Sw6A?=
 =?us-ascii?Q?WaIOkk4ZxrBvRcOU1SY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:32:06.3537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ca8d6a-855d-4aa7-57d9-08de16bd4321
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533
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

add wrapper functions for pmfw eeprom interface, for these interfaces
to be easily and safely called

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 98 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    | 21 ++++
 2 files changed, 119 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index c38d88a60c41..8533f1b6ebe5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1608,3 +1608,101 @@ bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev)
 
 	return !!(flags & RAS_SMU_FEATURE_BIT__RAS_EEPROM);
 }
+
+int amdgpu_ras_smu_get_table_version(struct amdgpu_device *adev,
+				     uint32_t *table_version)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (smu_ras_drv->smu_eeprom_funcs->get_ras_table_version)
+		return smu_ras_drv->smu_eeprom_funcs->get_ras_table_version(adev,
+										 table_version);
+	return -EOPNOTSUPP;
+}
+
+int amdgpu_ras_smu_get_badpage_count(struct amdgpu_device *adev,
+				     uint32_t *count, uint32_t timeout)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (smu_ras_drv->smu_eeprom_funcs->get_badpage_count)
+		return smu_ras_drv->smu_eeprom_funcs->get_badpage_count(adev,
+									     count, timeout);
+	return -EOPNOTSUPP;
+}
+
+int amdgpu_ras_smu_get_badpage_mca_addr(struct amdgpu_device *adev,
+					uint16_t index, uint64_t *mca_addr)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (smu_ras_drv->smu_eeprom_funcs->get_badpage_mca_addr)
+		return smu_ras_drv->smu_eeprom_funcs->get_badpage_mca_addr(adev,
+										index, mca_addr);
+	return -EOPNOTSUPP;
+}
+
+int amdgpu_ras_smu_set_timestamp(struct amdgpu_device *adev,
+				 uint64_t timestamp)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (smu_ras_drv->smu_eeprom_funcs->set_timestamp)
+		return smu_ras_drv->smu_eeprom_funcs->set_timestamp(adev,
+									 timestamp);
+	return -EOPNOTSUPP;
+}
+
+int amdgpu_ras_smu_get_timestamp(struct amdgpu_device *adev,
+				 uint16_t index, uint64_t *timestamp)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (smu_ras_drv->smu_eeprom_funcs->get_timestamp)
+		return smu_ras_drv->smu_eeprom_funcs->get_timestamp(adev,
+									 index, timestamp);
+	return -EOPNOTSUPP;
+}
+
+int amdgpu_ras_smu_get_badpage_ipid(struct amdgpu_device *adev,
+				    uint16_t index, uint64_t *ipid)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (smu_ras_drv->smu_eeprom_funcs->get_badpage_ipid)
+		return smu_ras_drv->smu_eeprom_funcs->get_badpage_ipid(adev,
+									    index, ipid);
+	return -EOPNOTSUPP;
+}
+
+int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device *adev,
+				   uint32_t *result)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (smu_ras_drv->smu_eeprom_funcs->erase_ras_table)
+		return smu_ras_drv->smu_eeprom_funcs->erase_ras_table(adev,
+									   result);
+	return -EOPNOTSUPP;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index feff46b22b6f..cfbd402ddea2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -165,6 +165,27 @@ void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
 
 bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev);
 
+int amdgpu_ras_smu_get_table_version(struct amdgpu_device *adev,
+							uint32_t *table_version);
+
+int amdgpu_ras_smu_get_badpage_count(struct amdgpu_device *adev,
+								uint32_t *count, uint32_t timeout);
+
+int amdgpu_ras_smu_get_badpage_mca_addr(struct amdgpu_device *adev,
+								uint16_t index, uint64_t *mca_addr);
+
+int amdgpu_ras_smu_set_timestamp(struct amdgpu_device *adev,
+										uint64_t timestamp);
+
+int amdgpu_ras_smu_get_timestamp(struct amdgpu_device *adev,
+							uint16_t index, uint64_t *timestamp);
+
+int amdgpu_ras_smu_get_badpage_ipid(struct amdgpu_device *adev,
+								uint16_t index, uint64_t *ipid);
+
+int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device *adev,
+									uint32_t *result);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
-- 
2.34.1

