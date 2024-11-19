Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB08D591CC
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F3CB10E5C5;
	Tue, 19 Nov 2024 06:36:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="llrgaleE";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0DE110E5C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hs4bs365yJqDz8zreNyRempprlwlUzLQ0mmWy4qJPKouG8DCsrrX38fh/49Ut7vo0zNh+PxWCJxLiiusAWPcuBn77owWgrTafgx7tNFOVho+rqdaDre+XXPWiNdY+bUImkxggf6hEcbQBU5iNgpiBGwl5Wxa+j3AHYn6ve9F0HX1L/GF/lzf27P49w+e2DGDW7LX9JhxexyKBl/ToDDXnFj3rst6fy440+I2UC5tQuTv639V7lxqVwHFSxcRJRD93LK9sE7JUEDC/Y9BCsB+GRIdp9CGiRfnDa+7oVMSlcX4Xqto3i/9Cgz/BiVu3gcTq6u5q7o+TIKJEpOUjlY1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NQZFXfSFuESTZtw5u/j0lpDpFBjx65HZ5zPTRcUdwA=;
 b=vY/SXhFv5/6NuZK2cNZI3RSwvo7TLcVmGQCWZbIX5Wjt2le+hDtjvt/m0ZGy6Hlx/Hd+2xK/sOfwB2m2zUhTgob4nw8gOzeoanKo03NlwZXeaSknNUfDrDN7YWXHdHGUVXPDDGSZn09aSHICPtXk/WNxFji6JgfRefPN8kBE0kq9o/dwdsvWgSD4dz4lcpmU7JHQ1Ebd/t9EQrM32qLRUsB39sE+wxllG/O0v506KEmC1bFT+lR/jdw8VRWZZXnGV2Pnad50AIeJbgnh/Be6pZHANYIuKAhaFEXgVMBcEC+2aPcFwxNk/PFbUoEsVQsWmUy/chHRNFokTK4AfPSaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NQZFXfSFuESTZtw5u/j0lpDpFBjx65HZ5zPTRcUdwA=;
 b=llrgaleEldmOJk9v13F7PRO7mIg/NgQBlR78CdxJ6PLMiEFSkYpmmN1eeAOPhz3LdDK8b9nyg2JCRXS3KsgpP3IhMSAHwfmteWmopnwuDBXyED91D18bn8JOi/C38P8rl2W6XKKAABvD79OzUrTByHjIz4vWH9nPz1IENCal3ok=
Received: from MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 06:36:37 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::11) by MW4PR03CA0041.outlook.office365.com
 (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:37 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:33 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 10/21] drm/amdgpu: store only one RAS bad page record for all
 pages in one row
Date: Tue, 19 Nov 2024 14:35:53 +0800
Message-ID: <20241119063604.81461-10-tao.zhou1@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3852cb-e959-4569-0da0-08dd086484af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0s+LSHRJztwjs1pyeWaDYQc/JVpbtnf2oNVClW0iFbNcDDl816jigm5Cn5QT?=
 =?us-ascii?Q?aNBnS5AC9uT82IL27scD/xTp481mj4XM+4xCFxOHlUIDvNsW/ydQPjBos11a?=
 =?us-ascii?Q?GZP16vDRflNV2tmXsreUh0w3Cg22siQ3hQzxSGRwPGEIUZuOZjBHjE/2MAIF?=
 =?us-ascii?Q?fmdgWZM4n+QqstqY9wCGPbErGUpQd7uudpo9xXQk8sJPpYZft9QSb7aGMDtm?=
 =?us-ascii?Q?Brl61WkrE8rPWC2qoe6NjnJrLlkYQoUz7aNGlNKSBkAJ25ApRcYD3IXvexYd?=
 =?us-ascii?Q?FBK6oY/M+Keo5RbZahLVv3xPLi+X0frSpwC0stzeKltWI5WDJ7YxOeCa67ZF?=
 =?us-ascii?Q?eOx/IRW6ycimQiSlLqnGjfmdW1saBrUpEpDUCcoTwk0vQHgoDxysDDYKDnDN?=
 =?us-ascii?Q?C8QPfCw7BC0Et70tc4+52rr9roX+sfM0zmHWFMneJH/a0uOhJ+6CRqcnvcsK?=
 =?us-ascii?Q?2mlP0bqGjwXHzkboU15gCQ9DrfWGjrWTLWBB9IaXoXy7Zs+0UeW2+FZV2RwE?=
 =?us-ascii?Q?a0s/qgsDEbxo/kbk+jL6sjqlVepp42QTkmu/VZEH7Pj3+14/2ngGZ+IPiYRP?=
 =?us-ascii?Q?IoLmZp3LbypmjTW9wKfneb1u6TjaqaqOtV1pka2MXnUpOchmCOsOeLO0bEBb?=
 =?us-ascii?Q?b4IH16SU5ANTZo7fOqwH22KUMtxjiA6gSvhsv4RDX77nOIqddGwbyGQ6EAsd?=
 =?us-ascii?Q?H/kceeBbM2hP16Vau4VdpcbDSmmBcw7dGLFKBn7fLvrjlRetBRYakswQ2eAb?=
 =?us-ascii?Q?MU52E5SrzjELUDlOIEjZuQHNK8hm0kTsxq4bZcZeaow+mCx60QXYkt7un1zG?=
 =?us-ascii?Q?pQjpE3cE8sPPeHDy8OTY+Nap1/t2CGS5d77E7WnmVG/vbz+RAJX9ZpTU2MFf?=
 =?us-ascii?Q?iAShrbbEdUr81LK4L9xH4Ks5mQBr0QCCtBv3gs7VoATxxInVKe6+nniIrbJj?=
 =?us-ascii?Q?oQPabASS30CjX6A9ARXiRjAyysbDqQVdkr8Bq2nT8WorEIql0EVgQ8O6yX8z?=
 =?us-ascii?Q?eVqc1x5LrN6wIJr7m69xOgySXbctVpacP0ovnaUiknNM0Fyy96Ir99zlpq3b?=
 =?us-ascii?Q?4dQF631KTBgWtx0mVNQGQB/ANfoWgVMxn2sp/tNUY4wOCP4oAm4cP7gpYu4O?=
 =?us-ascii?Q?4ip4K+fykT4w6BUN2j4sIfy3ycH1fNPkctpFOH0bJ+EWqun1ML/nVJnp7VeT?=
 =?us-ascii?Q?DnV7ASCtnsxlIBsIi1oweaxyCVoYIW8QVOw8camYzilpLWMflmLn3YuGwdlq?=
 =?us-ascii?Q?+vxug4U+WKNLY+uz5nixNIdv7Zh4KsBFNCdCGPTZMF//bRFHU/vDGxS/gUYf?=
 =?us-ascii?Q?jSQGuCZEQKOzMTb0Ba/AyG2uSeNQ3KrY8G0AoQUgcAHohdXYjg/DMchqscI6?=
 =?us-ascii?Q?5MISQjeCdKF3RF0l830uMvcogB8TTzslTsYs7g8Dip5YwW7zFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:37.0263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3852cb-e959-4569-0da0-08dd086484af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
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

So eeprom space can be saved, compatible with legacy way.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 35 +++++++++++++++++++------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f2018c3e96a0..c0a011a59d59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2788,7 +2788,7 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data;
 	struct amdgpu_ras_eeprom_control *control;
-	int save_count;
+	int save_count, unit_num, bad_page_num, i;
 
 	if (!con || !con->eh_data) {
 		if (new_cnt)
@@ -2800,19 +2800,38 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 	mutex_lock(&con->recovery_lock);
 	control = &con->eeprom_control;
 	data = con->eh_data;
-	save_count = data->count - control->ras_num_recs;
+	bad_page_num = control->ras_num_recs;
+	/* one record on eeprom stands for all pages in one memory row
+	 * in this mode
+	 */
+	if (control->rec_type == AMDGPU_RAS_EEPROM_REC_MCA)
+		bad_page_num = control->ras_num_recs * adev->umc.retire_unit;
+
+	save_count = data->count - bad_page_num;
 	mutex_unlock(&con->recovery_lock);
 
+	unit_num = save_count / adev->umc.retire_unit;
 	if (new_cnt)
-		*new_cnt = save_count / adev->umc.retire_unit;
+		*new_cnt = unit_num;
 
 	/* only new entries are saved */
 	if (save_count > 0) {
-		if (amdgpu_ras_eeprom_append(control,
-					     &data->bps[control->ras_num_recs],
-					     save_count)) {
-			dev_err(adev->dev, "Failed to save EEPROM table data!");
-			return -EIO;
+		if (control->rec_type == AMDGPU_RAS_EEPROM_REC_PA) {
+			if (amdgpu_ras_eeprom_append(control,
+						     &data->bps[control->ras_num_recs],
+						     save_count)) {
+				dev_err(adev->dev, "Failed to save EEPROM table data!");
+				return -EIO;
+			}
+		} else {
+			for (i = 0; i < unit_num; i++) {
+				if (amdgpu_ras_eeprom_append(control,
+						&data->bps[bad_page_num + i * adev->umc.retire_unit],
+						1)) {
+					dev_err(adev->dev, "Failed to save EEPROM table data!");
+					return -EIO;
+				}
+			}
 		}
 
 		dev_info(adev->dev, "Saved %d pages to EEPROM table.\n", save_count);
-- 
2.34.1

