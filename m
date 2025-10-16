Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1012DCCD185
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 03:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E7410E13F;
	Thu, 16 Oct 2025 03:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q9O+d7Eo";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012030.outbound.protection.outlook.com
 [40.107.200.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC6FB10E13F
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 03:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRDDrDzGnwgko6U9ncaCL2kWOruBhW0BlUDgBnoFYOq5SkwLJtQgLq012rgw+0YntAUjpeoWAcUl4mwCAleI0PNvcwg+tx62uHuhSs+Ah1J/M4t8i9Nig+1img0VQZYZJnzmtVUlTjsuRrw5L3NGBXyHeP25Xz+w3SfApCa647z1CXI5P5wewGuoIP4rfAyZ6h4O/55e6QTYtmC02kA8XqIvwClhkDIW0PeV274keonP9bhhLwfsLSwmXwXA6PvzvZAYs4KYlDfaCf1j93i3cp18ZXsXJL8IKxzm2Rb9mayEHNbAEdyjpHltMB4OmnYw4/0XWCcKrh+983BnFRi5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIF97dbFwbgCZw//Vbgd+/utQdd4Rw8IP2x0pHR104g=;
 b=p7ZESKYGu0e3sQFrk9G8dzpZaliqAuzxeA3PfZjLIcRae8iubZk9keFu7HXZ+w/e4tS+KCJOrUUB9dQWAAkGprdj8RYigw0RHC3noci9uc8ZXKLNTd6sZlsgp7kD9pYsSSPL1Pa41nIuS2WHfVbOKGRYSrpfKhHH4a21wmRmj8JtwTm6vkpkeMpZn7voSAN4zH034SwWiY0hT5IwOgcz1Yzljv5D6UJ0kBOeHnee6r6xD8C8yVsIp3Ca2Piiv3uD2Ah2s+RCsGyIzrZLcLGVR4qi3Lk1SWLo4ao3GSGzSEEQAegMSiQVXxxibmfRrreR7oFfrc8o2Vj4FtNxkiJ31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIF97dbFwbgCZw//Vbgd+/utQdd4Rw8IP2x0pHR104g=;
 b=q9O+d7EoE3GMH5dRDj/H6izeEHbMX+DdoPln++zm1226UQRngdPK6nSeza1r1/zp7rx7hMTfCz3fdytwmLqM1bnLxxGkHG46cgI4Nrv8z9riSLzAAEBFunJXw+QwKnfzqSKwwkT0t1nJbprvsGOo/BU6nhM5fgiZF0WoIKT6RD4=
Received: from BYAPR02CA0017.namprd02.prod.outlook.com (2603:10b6:a02:ee::30)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 03:41:45 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a02:ee:cafe::a6) by BYAPR02CA0017.outlook.office365.com
 (2603:10b6:a02:ee::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 03:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Thu, 16 Oct 2025 03:41:45 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Oct
 2025 20:41:44 -0700
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: check save count before RAS bad page saving
Date: Thu, 16 Oct 2025 11:41:33 +0800
Message-ID: <20251016034133.621266-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 397fdf4b-2fc3-4412-d6be-08de0c65edc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UJu7MU/O45/g6OyYHV7L28bOIUTLmpS7wM542uhVURtUlwIj1SO6Oj9ooV70?=
 =?us-ascii?Q?BbjS7tuqQItRV1/0ykLXuKXVYeqKesQnAqQSUg87S8OS7PVAZCGTUTL10hkn?=
 =?us-ascii?Q?lQOJzyQAli/gVHgPbZpCm5H7J8dM+63IodLwgCLNXJOMiK/GKBWc2UtyIt63?=
 =?us-ascii?Q?Nqj3JWfVtm67T6jLmVl9aaiIXfkw7OwDEw/qsQZplXTvbUmr3XxRiHj9Qwqi?=
 =?us-ascii?Q?T3KyeD7Ka7ymfinLEqXKBsn0WBh3tYlc6FHtm8YLrWb1D/8Mg7VRnXvVBpyz?=
 =?us-ascii?Q?ngzQu8XkHE/RDqmNe2tk+f8CAT3u1mDJlDJ9AfsnseVBksEG3yU6tStjXYQM?=
 =?us-ascii?Q?ydikbI2R7jPa4/KDV+eOKdaMywRKC7aO8NYms8khtcjHeA0v5QJmhFllr4Dc?=
 =?us-ascii?Q?IO2asb4DiTXVlgN/9ODbZiSaxHHAC7Hm2yDWJffHThJQyelAleE5ynFoAreA?=
 =?us-ascii?Q?GjiVkbZtxMSW6Nx4EnP08x8+lhm57dvArrcebgmeURkVYqWsIoNdMaxz6ymR?=
 =?us-ascii?Q?a5/uCk/64pNFFveyNRDNpg7UGrX0Ee7YPM4IkWoyBpTG5L2YYNpfbA18etHw?=
 =?us-ascii?Q?rIrFlU9gKps4BDrar3fZer406NmHeeoOOfKLE2PrfvSep0m80TiixcW6+04t?=
 =?us-ascii?Q?5xiNSoyS856vOk2n1nTU30w8c+gsHF8DrkRhVcMU2ZjTAsKaWIxeXYkGHdEG?=
 =?us-ascii?Q?+C/R3JGnlEumJz72fMiDeDFsQYoCajTBY9cjpvrGjpiAycp44kNot6dLjkss?=
 =?us-ascii?Q?aTSCu0X5qe2ZLx4WfmbrQM+KT1VVU6SAlMgx8LuxMK2VVDCyI3c+9zON2Y3H?=
 =?us-ascii?Q?GALm0OHxzElND6Cv38MtngDFbnw4YAr4bHO+/KJya1FqaOvPWR2MHTLK36vL?=
 =?us-ascii?Q?krBaI6sOK2qz1RdyGL6+1KQaaipZ8BLTf5+ClInLMtDT4TBLGy6zU6HbMSqE?=
 =?us-ascii?Q?sAJwbmWtO/p5q2WXPLYe1L0Afc6K/YKsPb3vE38ojizr34+BNTJxHgq2AAna?=
 =?us-ascii?Q?1KgEYfTc8Mb9IMgDIj8tg1jzjImw1gQhgk2iLFw3liaWBK5lgpBS8tiXvEvr?=
 =?us-ascii?Q?9E6j9cL/WpGpK6Z1KmJLE5Rybb2+XpObOJbrAsK7yCY2ZV12wyYFhCzvkJoP?=
 =?us-ascii?Q?Eql8Kmquh2AyiNRTV2C831t5t2EWOGE5g68S/7scZMQCsLbpupX4iFfGvMy4?=
 =?us-ascii?Q?VEXZbVvycG7yKD4pFTWC3h7B7ykXPgyUQnbr0JqrFOkF/vAYcXMWCsl22t+d?=
 =?us-ascii?Q?VkTNpl/mzalQ6mkkWcxe9ac2X8shkEHLTEx/iAWFR2vUusCwYi2HtlyL5M9h?=
 =?us-ascii?Q?F+HgU+9YsyZ/IEes2JqeCy+AilAUf8GEDUESqliHMA37y4bWp9+BONbqtQgi?=
 =?us-ascii?Q?LQeH+OtY8RkvuQl7eTtSvxLGiMsCI8xF/wnbAJLqcfoUNVqmuBtWfEM4vPnP?=
 =?us-ascii?Q?wujESrIN0UhTKJUuEAwE+maqzb8UQfrX1Qy9ieBtHmt19eXjLI9IUf/Bq2TB?=
 =?us-ascii?Q?VMo1pQYwOniSV4hkxPCBNg7ooxx+8rzSSetcvvKr5ORRA3Rk6WoWrMJZdugG?=
 =?us-ascii?Q?0oTCjNmtczq7gRITxHY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 03:41:45.1982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 397fdf4b-2fc3-4412-d6be-08de0c65edc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171
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

It's possible that unit_num is larger than 0 but save_count is zero,
since we do get bad page address but the address is invalid. Check
unit_num and save_count together.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c6f3a327108b..3b410ef49d91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3140,7 +3140,7 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 		*new_cnt = unit_num;
 
 	/* only new entries are saved */
-	if (unit_num > 0) {
+	if (unit_num && save_count) {
 		/*old asics only save pa to eeprom like before*/
 		if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) < 12) {
 			if (amdgpu_ras_eeprom_append(control,
-- 
2.34.1

