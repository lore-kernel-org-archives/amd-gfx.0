Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93924D1F9A5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Dec 2025 10:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D9A10E911;
	Thu,  4 Dec 2025 10:30:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jTFP+C6a";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 103A910E911
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 10:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkytEw9MWiI5noSTN0WcA4Rt1Ad+MwDxBeCqSLL4ndVyy/Sqz/MV73QYr8UshUuZ9FAyJEWslDWpQG6yYU0QGJZTlRoWFpKfvldQXZ3VBZXMGK04bFe3h3fEyT1ZMqBgOkuPpgcLDYYj7zkgtpl+qmAxmZNCY3TNUFB/fUrMX/KWwz8hdeSi9DlpcO4wcYZtmD3qMPp/sDR9viEH9GI8am7JrEfcAK3d+f/uFP2LEjKxTboQd3Z/9FTuimdxfkEiAzfax/tybVsI0f1YoNPhy2CvNoP82jT6wMfCH33DjpwELYOb4khJbSptzHJE1CN29cJSeo+ikdyjQvfzkuPftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuo7fMI8U3dcRcRemPoq8S8SmuS4PsXa7FtiTD1u/Lg=;
 b=u9Dvr7pM4L3gXaG6KX/uHGj7OTwsr0VgqnNq4VmJV9pks2PlP1sAcQoE0NRS6cOmn5LVP3ECfzmU1wWjkmIw8SlsebSgSFg/Ef4y5z0q1EofR5IUXSzRxK0BzAP6yWPrs2Qx3IZRJo9VDuCwr8xFS6tZOU4HdFsHr3JcqXBvsoUIfS2WtmPvSmP+tqKUJEJUeaQE9R2YMAkpQzzAkoa7DGgoGL8ScIWO3x2P33NrmWt/wWq/bPpEMeSIDLheP1KYvAUeXB7Q5oocsZZvSzfZWidEcxs+Em+8z0kH6ocQEdKRmnhM2eARWGw7jZLIt7A7nLTwhKlbSkEbduOWEXcN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuo7fMI8U3dcRcRemPoq8S8SmuS4PsXa7FtiTD1u/Lg=;
 b=jTFP+C6aGSsjlxQFd6Q00rPweLAiTCln0HU6FVQ2lfK4MBW35UCj0g1J/J6T0Y8KD5axEeR/3si6lt2PmOG+jPhgFuOTHGEZSFZHrWSj+58CKLVTgAXQt5CU9YqELnSrKi/HPkIyJ+jiKbmqDmEEYiCD9uM5Ccwx9rI/b2FaP8k=
Received: from BLAPR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:32b::10)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 10:30:20 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::bb) by BLAPR03CA0005.outlook.office365.com
 (2603:10b6:208:32b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Thu,
 4 Dec 2025 10:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 10:30:19 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Dec 2025 04:30:18 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: refine memory usage for ras
Date: Thu, 4 Dec 2025 18:29:51 +0800
Message-ID: <20251204102951.26278-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: b0645a1c-967c-4db7-35ab-08de33201fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r6pGthHzT8JTX5zoKvabALb784/CqtJwhWoy4uB0I4gax5gYxcQ5w+GBp/SJ?=
 =?us-ascii?Q?32ZjtA81xOryNiXvKceZPXv3eHu1D5e5cwysLvkdDlJXuiCU/T6tFsgHzqPF?=
 =?us-ascii?Q?DQZe+PsBtrB13ICIY7Skz2Q8aFpS4YW1DRoqFtHSy8h5S6HfZDUUzh5tjy5t?=
 =?us-ascii?Q?pPBXB9r9VPd68aIAzx1Q/AVjlsxGqwF4CYxBhjyaZ14DpJU8/5CsOdkcVYqC?=
 =?us-ascii?Q?HH1xD11r3MSxV3EBUAhxTy5ppanS4Qufb+7qwWvZqx7dHeuLyAwiTM8Qhhz9?=
 =?us-ascii?Q?HB5abH0VxUdUs+o6IL14GIYY43w2nahFJFFOt2dMYziiydhN6ge9Lj52RDZ+?=
 =?us-ascii?Q?R1qlxV7oaoKbh8xHMTzx5Alf681BYuqx7TTl3EBHZlseAFTmbAMO2SQ8GkVV?=
 =?us-ascii?Q?pSdpAv+LDriGHSgpBMFFQLugggcbn+ezAwVsUsbRamP+xsm9dQPlimA/9m6R?=
 =?us-ascii?Q?il9hhIvLXB9jCJVi2SfND72jCXS1xKXSPPxMoBwwMkbJDskErKUFNLE4YeRE?=
 =?us-ascii?Q?lAs2PCDljP+MAfR7Vvz5bvO/8ArtNrz3tTReAjIXK1qRy1r0APnRmMAV015e?=
 =?us-ascii?Q?+t12iw1Mw20aug0KTgJdvQ0GrMDDRYss1bHsKLDLf5wg/FWrO/r6SNkIn7c0?=
 =?us-ascii?Q?AluJTvYRw3+i18yWR4s4NebRyOqqSSBjW0fN4ghGTJVK0g88j+ZnLePzTcjp?=
 =?us-ascii?Q?XnI1kc7wA1a2yYD6m/zyj/fWq/KnmjuMGQAbLc7NhPGf1pPVLTIQRZVzAxGG?=
 =?us-ascii?Q?8TBjVn5y8cixCf2yPw/8UnRstnApVx+iebMu3tyLJ9MpeHZkAvkas1lHr9Z8?=
 =?us-ascii?Q?Cf9KZ3W9NIfbLy3ByLmF2Why9ByakDo8dmgueqGbehVDFUAHjSLBqrptM3CR?=
 =?us-ascii?Q?pecZWwx+/ZJ7OsPAIynwnLS0Wj2n+pVq3ifAiUq8dxK6YfWezz59tJKvuezA?=
 =?us-ascii?Q?nCEhQpg8VIMKZ+RGPt6SP8Ck2KtOgcLE4Jn+jhS+UehT9LM0wY8zhMSwWQ86?=
 =?us-ascii?Q?yTZjdbBmxaCp6aYpfloVgewcq8Up1DyfKQmPXo+I+xf0DHBZaf4IIbvtRcCo?=
 =?us-ascii?Q?TrSWheOS0nbzg0CFbtb4yD9YAtm3J3lPsr0pFINaiXs6fy6hUKHhYQpZm5eA?=
 =?us-ascii?Q?dm53XFg2SFv8i1v85a+DkV0YH9WlgJ/WeXswgj/7bw5TXECaOLtF9pSJ1cbK?=
 =?us-ascii?Q?Jxk3fPeVZ008zBZFuRIluJcOXEz09ImO4/5Rr0Go+dPuu/KHTiihw1y5kO3y?=
 =?us-ascii?Q?HV8vl4jUqoeV7maFCm1qej2TMDxn0u+GByFIWC84BQnZsCG5+si8GrpvekM3?=
 =?us-ascii?Q?cj4JWwIfaTCJELoacE5LmHDvBK4MU5eq68l+7l+8XmG2IIqZ0ljPqWW0HFB9?=
 =?us-ascii?Q?eVuH/CBwQ386gVbtXzaOwaJZ0DmYVqXeLOJMN0y3oTxaZYIiRMIleS9C3F56?=
 =?us-ascii?Q?7BzLnKpmRzhcqmf+D7NsBwSF7SVN0sQDJqCBL/o/XBDPvGfPszmIkZ7ppuhn?=
 =?us-ascii?Q?J8YIx75b0SoXP3W+gG8HWushExUGSqG7boxWyQQDmtkTlteKmmUg7iq2WZ4F?=
 =?us-ascii?Q?SYx9cgGA6sSbXFTlWPU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 10:30:19.8268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0645a1c-967c-4db7-35ab-08de33201fcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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

check and extend record memory before use, clear record
memory after allocation

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 00f890bbe912..c933ac1d6c83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3001,6 +3001,7 @@ static int amdgpu_ras_realloc_eh_data_space(struct amdgpu_device *adev,
 	}
 
 	if (data->bps) {
+		memset(bps, 0, align_space);
 		memcpy(bps, data->bps,
 				data->count * sizeof(*data->bps));
 		kfree(data->bps);
@@ -3090,6 +3091,11 @@ static int __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
 	struct ras_err_handler_data *data = con->eh_data;
 
 	for (j = 0; j < count; j++) {
+		if (!data->space_left &&
+		    amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
+			return -ENOMEM;
+		}
+
 		if (amdgpu_ras_check_bad_page_unlock(con,
 			bps[j].retired_page << AMDGPU_GPU_PAGE_SHIFT)) {
 			data->count++;
@@ -3097,11 +3103,6 @@ static int __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
 			continue;
 		}
 
-		if (!data->space_left &&
-		    amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
-			return -ENOMEM;
-		}
-
 		amdgpu_ras_reserve_page(adev, bps[j].retired_page);
 
 		memcpy(&data->bps[data->count], &(bps[j]),
-- 
2.34.1

