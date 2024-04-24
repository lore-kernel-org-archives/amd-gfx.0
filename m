Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6DDC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 05:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D4910FD6F;
	Wed, 24 Apr 2024 05:52:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r2PK+oIL";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF81010FD6B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 05:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fl6P1mwcL2qONXhspsSBj5Exmp+2buTiY9ymhYOE5YMCgork2/TTzpn5XxqiVp4Dwvbh9X6ffP6lUl8tCc5bb2Ox1Xe0ZqZ9KxIThwpJAGSdOdHRtWMQIDJ5g/Ju6TA2FZ6ckg8jWxCzMYQ3zrbs6tZgji7HEMRRNxcG9nQwQzslWUvvO48wg+Cn9sZ3oZXqz8+ztJuNMv/xinE2pZbbmZDKnxYrWVnqV3PG/Wz22uLWT7TZVCG1l/yFyZkZyjiqbsFJlQcDg9aOUfOJvhmYKh43rgdyBGR9Tr7HAHSS8xBb5gdz5AAXlsBNf37TeB3sO9BuoLswk9bsDb3ee+MgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PM3NIEegkyeUeIcQTIGaYkcyLtz9WE965L1VE/n1CRQ=;
 b=VUrWxuHqWEHiiMoLlZRQve0F43a8+YFKdk0VLMH1yoFEOm68oomORjMbx85axBf0ZBpdEifkvXiAJDSqhkN3H1rxXfOmPRr+LPrYLGxMrpvRLxIUHgS5kBEF3r5dHZ/qmf3H0HB3axuS5Ot6IZ2/vF2e96qn1dDMs0NFXti7FOsywk2ZfgVxh1Gy3eXOgkjocBiK7EuUh9kiiRUyBvT5ehvDM+PklY0b8LI8OgwU3F//gyAeX4JjfSWzgNxcM9bP5j7DvEY4FrP6TLi3cb+IeOgWmArX0Ha31/PK7bZ8IDcrDl1odoJz8k5m1v5a9yGgQhOe+p19pWHHxQiHXuuluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PM3NIEegkyeUeIcQTIGaYkcyLtz9WE965L1VE/n1CRQ=;
 b=r2PK+oIL7xj5VQl8iUA1aRWqepCp9Bgp9lNrmAU5A6G9HjQPEbBbQW/mHg5rTCq6OYkf2bNWDn7M2TsYlhhMbA+iivQWt9orApTCUxxuAYE5QynASFo2rvrJ+ve2KWjPRJKJkOsAijvdDUXEHNrkgg+29tSQRTdaEy1M1Q+NGe0=
Received: from CYZPR10CA0024.namprd10.prod.outlook.com (2603:10b6:930:8a::8)
 by SN7PR12MB8435.namprd12.prod.outlook.com (2603:10b6:806:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 05:52:47 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::18) by CYZPR10CA0024.outlook.office365.com
 (2603:10b6:930:8a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 05:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 05:52:46 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 00:52:44 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH V2] drm/amdgpu: Fix ras mode2 reset failure in ras aca mode
Date: Wed, 24 Apr 2024 13:52:28 +0800
Message-ID: <20240424055228.904041-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|SN7PR12MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d229b3-ec64-452f-d3c1-08dc6422c489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZLNId+xwSDWeDrbnrEv4YuB5VvIUUkAK71reMx9OsjaE9Yd5nDcT+oX8QnIS?=
 =?us-ascii?Q?Y85VttUzfgNmjtLeB3+dD1NbzPfKRqWlcFulwoebz1tgLN5VDN0etrciC6lS?=
 =?us-ascii?Q?Thf4Pww7NaJHaNh+yCiIdwb0/G4eY7zWn5dw2DXB2HfH8qZE5Tgb/s54uyNv?=
 =?us-ascii?Q?1lzflZxb9pph3kxePEeYHapOrKFUUybrNIwuqvo1EBbiHWY2Z5oVNchfmpaa?=
 =?us-ascii?Q?3kcnJz919h8i1PTJBBw/gN9nV1vfIRu6phHDm0t3xqViptSCnEoYiyED8Dk5?=
 =?us-ascii?Q?fIwCWzuWMc7FashQpIfYsUs/VcFFKS3zxj2+R4K67NcmQVWICXiCTq3HV/w0?=
 =?us-ascii?Q?noKXC0Y3KgDlgouffNdZvrvEhddGiEWZ9lKtOKQ6w2CZeyC0NmtJInu1qKoO?=
 =?us-ascii?Q?CumyJIC3jGp4ti2MNnQCYnO67uUi+yxztRY/SgFvmgTvgUwdD2GQli1vGHPa?=
 =?us-ascii?Q?ulrh7A/LylkqQ2TXHy76iaYl9vKdlROsGAEsNLvtK21jsivuKim9pOuLAieH?=
 =?us-ascii?Q?1sIj8kf3mEjJZYFFy7rVbMgetIstXgkFLQ2phwwtLdu4338CkgQHtJlsW1+c?=
 =?us-ascii?Q?y4K8NS7ExJV5oREvbtRPnB5hx8La189wObbltPVNhwrcJNqpExEtOZU6xCad?=
 =?us-ascii?Q?ZIv4TSQNwWABfd3ukwncnOoa88g4jfevZBa3B5Z9zqRaCcZe/99yv+/LJ/R3?=
 =?us-ascii?Q?mhO6w4ESgPRqUfUGQXezErSfJ4gMk634YbYRJ1hExqv1p41rh1Ngx2jII4y1?=
 =?us-ascii?Q?GFFPglcVGuo30mfchjOWVf8edTU2gPew6GLuynvKdStilNVRaQr/Do43EIPh?=
 =?us-ascii?Q?2J3/ZDKGs8RFDsrP2kbHMl+BOifq7VtAsbd+7Ap6nbqJIMGRkWexP1ConD6m?=
 =?us-ascii?Q?WXo7q3C+iOXXnU5S9F7qdyi05fPv+GxjWpWGrMF6TopVigvr1I9QBi4W9a8L?=
 =?us-ascii?Q?2OfTNdmTUrFBmWcX0S3eNgr8wGB+Z6vKLu/mIcAJTs/c4dvwoQ7wEoqBhGxw?=
 =?us-ascii?Q?UvCQoYudq2omtv8aVmffxLP/hfRDac3z08hFahoiENaoPwzWbZs9Wfktrn34?=
 =?us-ascii?Q?V9hAY81so6EptD4aTFPEEMZuscRGfdRyRfEE7+l7Glk3x0fSojutCPfRD84R?=
 =?us-ascii?Q?CFTeuBOVBL2/KM9w8zHTXWLLhmTDEbs4opktADSGGtfZKkDWq2omdJExZ4Aj?=
 =?us-ascii?Q?02RWLAw7mnMvc6gv5c8hRph0U6N4AnZn8slHEFDQGlImoxIFQPsI5nAvOVnf?=
 =?us-ascii?Q?0jBn0JxaB82jne83NFphfqyuweB7l0RY8RcotS33gdT7/TfwoFtm83Q4bcpZ?=
 =?us-ascii?Q?6KsuM/DczCThfw13cCt0z8Mg+rOicDjboVI1PzF+0bomyZCtOMdr8x/D3riB?=
 =?us-ascii?Q?POrIcY40Ki3DqjkmLgrMBYqkbMc8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 05:52:46.7862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d229b3-ec64-452f-d3c1-08dc6422c489
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8435
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

Fix ras mode2 reset failure in ras aca mode.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index edb3cd0cef96..11a70991152c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1254,6 +1254,10 @@ int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
 {
 	struct ras_manager *obj;
 
+	/* in resume phase, no need to create aca fs node */
+	if (adev->in_suspend || amdgpu_in_reset(adev))
+		return 0;
+
 	obj = get_ras_manager(adev, blk);
 	if (!obj)
 		return -EINVAL;
-- 
2.34.1

