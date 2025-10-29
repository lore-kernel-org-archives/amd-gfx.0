Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3809DCCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C914B10E789;
	Wed, 29 Oct 2025 10:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x1I3jXar";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012030.outbound.protection.outlook.com
 [40.93.195.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6803110E788
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:38:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ijm2eOZI1ZbRIxKDn9iplgbKc/Hp+VGrnoCCOPJ6z5Qp3TvwSDm3DdRAFtEr5sLQBx2GoUUsTVy/dE1PTaP4ccuT7T2G1A3mEagZsgXB+1dIdRAr4FXVfJkNWZgIzov/7huorRHqTPL4GYxaAT5e182tXVPjVNsR7pTC0Ebnxe9iNFFgKIHxXGToKNh58FT+E0SAFOJzUMbr48TR25aXb0RBJhgoDIGie6H/1FkIQInXzMzbFikGhvsFwmXjQ8B+6xz1hjtvTqCz4ihwSy5Ra/u1K2qKBoDTz2RzA9lWpKLEfNpVcWEIdF5l8QcYOqc7k6WLtpSoh00ZnFDbVA8WpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCXCaSCockFSYiUF6hKExzZycs7QH5L2uZda4jSqcvA=;
 b=XNe7YdAGXAFpNZrT9QYssDLi3FwMc7CFkCPPau9WoJuPM1RpUqL4TwXkyvVnwUf8fjnU1bgjp8u1HHeylFGKhM5GbDKiJUgLgo+bu/NcMSSJh62yQAblQ88K4miHMmzi6V42iZhUBZ1oab7w+nEXLP2JgZYyg+PPW3zkXibqneoVjKVzb+RLUwdG8Agib5n1iwDEM6MhRUH9Q7754i4uDUlYttFuEPky4NVhU/zsiGmh5pi0PP+/BGvnAq5E8PEx2+a6KkJvCx659kg60D8n3v2Z5F049UrdxQUhB0iekyufmRGNV0QGMc7kSkS2e8Z6GABjxDgqjuuA/jZOYOSyTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCXCaSCockFSYiUF6hKExzZycs7QH5L2uZda4jSqcvA=;
 b=x1I3jXarAU6f039ZAms6Z81deXyf9liUZLEmAAd29HFYNKPiMF82mSp7eMx253kF/7+q02JsJX/kTFGiTUM4xTyaBy0FFEMRp42EWX7DGG3QNNtOYZY0ev9BEZ4HQ2GGmWBd1tvFV2EmI/mjBzWNZ4yUpVS+1ka5M4zbVlbAPxE=
Received: from BN9PR03CA0342.namprd03.prod.outlook.com (2603:10b6:408:f6::17)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 10:38:15 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:f6:cafe::31) by BN9PR03CA0342.outlook.office365.com
 (2603:10b6:408:f6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.20 via Frontend Transport; Wed,
 29 Oct 2025 10:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 10:38:14 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 03:38:12 -0700
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/8] drm/amdgpu: support to load RAS bad pages from PMFW
Date: Wed, 29 Oct 2025 18:37:57 +0800
Message-ID: <20251029103802.1402199-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029103802.1402199-1-tao.zhou1@amd.com>
References: <20251029103802.1402199-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 51572fb0-88e6-4d3f-29e2-08de16d743d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n1XN3I6BZrWmK61MVw6jy8GIfjLDuusAuS4oBCMjDYMkG+EfMutMS78OO5CO?=
 =?us-ascii?Q?dbEfSYlj8/4YgP8ywGei7KiW86iQL56t9igyycQliSIP58ot4iEpwnxx68PE?=
 =?us-ascii?Q?mwapEg4h5iUtqMcFo0jtQynzbLjl2tQ10dOe62XXSCoJbGUMGzuuCgwRnrRv?=
 =?us-ascii?Q?asw66UBVA/NMxb4XjS6QEZk0r64xYSW6CYE9d7/Nuym/AbNmkTJSDvqHKYrV?=
 =?us-ascii?Q?tfNnt20p7yY6wIcx9yrGuRHr5tEDRo4k/ek3Sf39nNphq9iHnmSRZvUAYgyX?=
 =?us-ascii?Q?niScSXbyB5LxZR3pICIAifWy8P9ikXGOHx5kCtr4tgbs8wEX9ETXc1ItH88i?=
 =?us-ascii?Q?Js+PusVsGAHUIr/9bpJQqG++1sCc6Gf6nrMUQiteNbpFQsWSlNPSMoTRvT3L?=
 =?us-ascii?Q?PDByYMiYC3agCEi5Sy5kRJ4vD6oPAEbqX20z2Pz3MFTji8iXvxCfyVkzdb+p?=
 =?us-ascii?Q?YE8Z7X0TgHf5JFelBX18XnSdFijedgfXvLdbUzwQ1kDmEv6Rt8SwXfjMm/DT?=
 =?us-ascii?Q?+chLcAJpys2Cjiq77FciRiIPLF6rEu6/CX7GnYSiFlrk15VRCs2o+uAqGL3t?=
 =?us-ascii?Q?lkiASIZthfDA/Ks5LyTM9zHiixFIIMiYt5T1FjQd2z1WZ8JxZqy5b9Py8Vgd?=
 =?us-ascii?Q?/DzAPl0byo6tR72L2ACZaDYRdVzLL4QSyw5jhb0efD0brSjTN4yhVf1gyyPr?=
 =?us-ascii?Q?D+OF3CWUTxBrFfz+PjSzlj57YSYFDVR0t71XYRZYpZAp0D/+rsb3K6/huSmG?=
 =?us-ascii?Q?UtBkt0YZsEcjbaTRtLHH2wWT4meMM+2VdQxBgWyspO4VK7K5PI336/n5CKAD?=
 =?us-ascii?Q?2yD2ajh74+nm6qZCjw3iSp0PgzQZqWV6XuJFZ2YrImyCtrHyR/tdR2GB2Vfh?=
 =?us-ascii?Q?+mhZbS+dG3dgvBm5iIXPpUwyKVBVS9vKPc3pN+Q5DlqbTIJK6zthVKhy9GAB?=
 =?us-ascii?Q?h+56SEiE59CSvjJa/U2+yu+mdUk2Tu74cK13iNya/Bpkh1L3S11cyxl4/vp0?=
 =?us-ascii?Q?/EDKSld5lTE0PjhZosDGoLxwrSg7mUjmTBJtSuPnwpa9D0a9WFxvklqFyCAf?=
 =?us-ascii?Q?7N3zV/ULUn+6DdGd3BuPmQ3TtB+OvPQhIKKANxdn2DiNDeinQdwiAbvval3N?=
 =?us-ascii?Q?2a97CBopXygNU0fahhCmcj13pXM8imG83BWWjnjiwyQclL/pvf1FT/C42k14?=
 =?us-ascii?Q?mfw+a7M9BTC0AE2BTx66npT/hLKWjmc1g+hPjbDEhRKEbKBbyBcYwkGfPIUe?=
 =?us-ascii?Q?2T7XSHKYKYLYflxe239P2yb1y3V6rQEtngMooWZUsRWPR3DilS9H2x00VfHg?=
 =?us-ascii?Q?bLue4c8bpi8YX2bKKZ9Toz14vj+Q/PcF/6X9BBIJsGfnd6rzlRulY4Ox1v14?=
 =?us-ascii?Q?vqVz/QSIdbzr/4PWenSSU7+9j55539n6SvAZ6M/NX+4bhBWk8cc560H0/F+D?=
 =?us-ascii?Q?QPfT93Ex2XKhrptAaOhEkOM72zr76nF121EfrR1qhi71nLp0qVbq+FRbFJVw?=
 =?us-ascii?Q?ffJjwrB1u4h7uZNJllCqOlvV9WMMfS3lXfEY/WYd3ZvDwAKzOpWYa+1dk84P?=
 =?us-ascii?Q?fBcPUXHpFCz3LgxXc2k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:38:14.4665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51572fb0-88e6-4d3f-29e2-08de16d743d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
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

PMFW manages eeprom bad page records, update bad page loading
accrodingly.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e84887fe29a3..e7c36166e889 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3154,8 +3154,12 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 	int i = 0;
 	enum amdgpu_memory_partition save_nps;
 
-	save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
-	bps->retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
+	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
+		save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
+		bps->retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
+	} else {
+		save_nps = nps;
+	}
 
 	if (save_nps == nps) {
 		if (amdgpu_umc_pages_in_a_row(adev, err_data,
@@ -3221,7 +3225,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 
 	if (from_rom) {
 		/* there is no pa recs in V3, so skip pa recs processing */
-		if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
+		if ((control->tbl_hdr.version < RAS_TABLE_VER_V3) &&
+		    !amdgpu_ras_smu_eeprom_supported(adev)) {
 			for (i = 0; i < pages; i++) {
 				if (control->ras_num_recs - i >= adev->umc.retire_unit) {
 					if ((bps[i].address == bps[i + 1].address) &&
@@ -3352,7 +3357,8 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 			/*In V3, there is no pa recs, and some cases(when address==0) may be parsed
 			as pa recs, so add verion check to avoid it.
 			*/
-			if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
+			if ((control->tbl_hdr.version < RAS_TABLE_VER_V3) &&
+			    !amdgpu_ras_smu_eeprom_supported(adev)) {
 				for (i = 0; i < control->ras_num_recs; i++) {
 					if ((control->ras_num_recs - i) >= adev->umc.retire_unit) {
 						if ((bps[i].address == bps[i + 1].address) &&
-- 
2.34.1

