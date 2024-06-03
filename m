Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB998C25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 130E010E339;
	Mon,  3 Jun 2024 08:50:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O94rVw3A";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A270B10E334
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:49:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHjFPKZ7UjrvYNvsaeNw7AQ3XaG5MNK6nih8U66zks8llRgVlG9g5xFO5ohhm5V1KhleMIUK20iEZoPFTgslydf4gtf00NcT6vtkXirrdosIJdZmU/IQDJ3AUv863QJvKIbe44Z6is+XBQIkr8xr7dANRh0m7rbXFlgsTEn7A1Kideu5YLHOtlfpcueloKPYyoEKYN+UuyvczH9vSTjYgQr42MWbxtgZ/7dZ4wrHisBNxQT5uzoYr51EaqUcqgeuwHGNTZAujiiNo0J/mJTOODixMaoUrjtHhbABY4vaS+DCtTSMwczCX5vmKzVjtwQqjmN/WSQgLET9oWfrpcg+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm8o93qalsU/FTkZ8HU5ljAzM/PpL3T0rfg570KWw78=;
 b=lSMJjnIWXC8WoCc5C9+IwC/gCzDMGXjEw2lfihjbG0y89ja0KeIAV95RSGmhNqU3Tj+pqUN+Ya1Y7iNcBdu0bri35gbbIyFAMd6gXDxj6SictPvo/2imP70X121mjzHlqVnISXgB4vmne/n2K20ongIziAglIStKEqAHOi/xBQXqfNYQNRCdyGAx0OhtxRHXDRjod8kmiFGBtVerDdx4vDadDKLVjavpvFTDoTEOnGTXP5LZS4k1KlPS9v0zoFn5QGZRweZQKiThX+rP6H3xiHMO6ueRgbSWRGUNKhV7KuvJ9xaVDFMRJsE+q0RHMN3hmw3FKt5WIsJg1EQx0d2jag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vm8o93qalsU/FTkZ8HU5ljAzM/PpL3T0rfg570KWw78=;
 b=O94rVw3A2eV7fA/sqV/WVv/TKZ4PUT/A/3SGifnpz1Vhjo0F9SGZ1/DT+gxwq/Fh345MhW1hLoUCOi3XElKMIOmEFaMo0hwPOjW9x8YNlBNCmtXuT4mtZ4gsAPc5dfWtLfLPEdQJjer5PEPXwQ6Sj+zU9NsP4VtF27g55qAkC+o=
Received: from MN2PR15CA0063.namprd15.prod.outlook.com (2603:10b6:208:237::32)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 08:49:56 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::33) by MN2PR15CA0063.outlook.office365.com
 (2603:10b6:208:237::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 08:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 08:49:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:49:55 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 03:49:48 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <Tim.Huang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 11/12] drm/amdkfd: remove logically dead code
Date: Mon, 3 Jun 2024 16:49:47 +0800
Message-ID: <20240603084947.2570291-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 5318ca68-3415-4201-53da-08dc83aa2458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qWJK8quXlfRfsZK5cRzMRnNqDonOyCvXxtM3dEVgG+7WV7iBwoS+gIUuxaOX?=
 =?us-ascii?Q?NuOo/XNnWPl2BayA4qCRC0zGxRdpxneQpLLbxm3DRMZxh4yTdrYn7Yshcvuy?=
 =?us-ascii?Q?NFGGH+dktTDz7nhX9bkZ51D+WP0yeeJZ6iVHxY3MDNfjd8KEuBQP0odA3sZS?=
 =?us-ascii?Q?9b0q1M+5RdQzlibcraSLpUwfLx5mOC1NwINNMmAEkvqVvH4mKxQygSbZN9hh?=
 =?us-ascii?Q?wLNgs5p7rueZsKsO8PJyW6O3O77FahaEqVuzUbZRGXBJnNKtn7C+r1Rs2D0J?=
 =?us-ascii?Q?JtOjd+d6FkIUaBsIW8TtFSE3Lxu/X8vsoJ8QXxULkG3R04yjvR8kXqO89YDi?=
 =?us-ascii?Q?KCbuiW7Cgy0ZZWxAH9HOXrd+D3gEWqF7ND5l5HNd9U2N01sMXAbpmaLac7Zm?=
 =?us-ascii?Q?RxnTL47cxW5wEliOwIOxuLvxvYxdsT4lTKGVhrqAKf9Eh/vFaRJ0Bg52P0cN?=
 =?us-ascii?Q?rPDrMTVU1afyrfxl606TouMgfowhNvHO2aP5UAEijlpZzpUKF3M/BUAE5ZzY?=
 =?us-ascii?Q?yAqzlIT7wYVq+QlqGL0suFV7196fvs5H7vONzXLy3aBoWPwZ97RpUAYSEJZl?=
 =?us-ascii?Q?5jbbbhm3poNOwSXGoTEoF7CaqzGC/NbyqD7H5Zg7p0jDlPVE6dohCYx3EU+Q?=
 =?us-ascii?Q?Qp2o8Nk0FqefuuAmuV1qVJoqj9RarJpe5O4O2Ie2/12Af9xLxE06wY5ikNDG?=
 =?us-ascii?Q?ZYMZMezg2pU+NILXFnn1SEhgCH06/zMXz+4g2VM0p791a7VVAwJE1p4Il8M5?=
 =?us-ascii?Q?mfN5ExRGXy0nXP9HojH1G6UHXh08/N2QhiL+pxl0nhU/OlzrgcOvZWt1QFVY?=
 =?us-ascii?Q?EbCAsJ1QrPWtq0zIqJ+nGdp2XDbWdj7C5MUpKpVcf/B3t/wKLh6r8pbcbLF2?=
 =?us-ascii?Q?4hQKtyIFEr5eOzQIE8RlVRt2HlQjNOpzxCaGYXGv7XaFb6uXC914aRjdWe6R?=
 =?us-ascii?Q?h+tr83XKEX5PD7V5Bzz1WTlwRgx/i7D/kBlSUL2csdLCBKm1RZv7psP7rweM?=
 =?us-ascii?Q?MkLanfVXmC0VWe5IWk+1WU5Qqwu6bE0zOK+pAuuAoIlnS/jjawCDNJ3i5lCD?=
 =?us-ascii?Q?P/jxHDY4YexyeHgZR2mMawGy6PrNHRBHvT2SJt8WSOyOyknVNqxLZDldaRSK?=
 =?us-ascii?Q?E2BhzHDTa21ggRt0G8ZAp0FNSInsm1HIUu7SpuGlhpt6wnbRi/+5rhO9fF0R?=
 =?us-ascii?Q?Dy34mJ+Ze/d7QV46eplvXIhzygoSrcaE2QXou2U4E610stziwjc5ygcwFzAs?=
 =?us-ascii?Q?E1uHWuqZrEpAA7Fb+uHHJmlCcPzQXRsjA7xgAs/aYG9iqFS5VUlazcOhm77l?=
 =?us-ascii?Q?dcGP3hnBtm9X5TelXvV4SBvLQQmo4Wb8jIfFh78Durjg3z5bKTQAaG8Z9f+k?=
 =?us-ascii?Q?y6+UBHpQrANjZh+rFCrMt/8LhU/A?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:49:55.6746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5318ca68-3415-4201-53da-08dc83aa2458
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864
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

idr_for_each_entry can ensure that mem is not empty during the loop.
So don't need check mem again.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index fdf171ad4a3c..32e5db509560 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1913,11 +1913,6 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 			struct kfd_criu_bo_priv_data *bo_priv;
 			int i, dev_idx = 0;
 
-			if (!mem) {
-				ret = -ENOMEM;
-				goto exit;
-			}
-
 			kgd_mem = (struct kgd_mem *)mem;
 			dumper_bo = kgd_mem->bo;
 
-- 
2.25.1

