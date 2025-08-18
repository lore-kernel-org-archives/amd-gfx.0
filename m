Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C4FCA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 18:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE82B10E1D9;
	Mon, 18 Aug 2025 18:38:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OIWuqvQ9";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C149110E1D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 18:38:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQVN4kuL1L5QHqkodmYZuDgVaOlZrqF8Bd5LPKARIldczJaVx7ob8hwLqKMFl/IruxaAc9JwrFAWJs/wtzA8TipyX8BeM9tFolISlx4ckO1pS+4eFDOTbGZEFWF7zfUz3d11M+0EmAf14/xc/hvc6ruouG6Qpkh4A5ZQuCn/+7CkKzSjQ40DU78pLSEMkYn3NhigELZzqFR9U6/EFYRGOKK05Tj7q8EkdscUwSIojxbt8DtKkvSUDqFiwoiOzvn14Ye4Ur1+98N2mE0xsQlIoFNU8v6dhRDLONawsDvVvt9bc7Gmw2Oz2NJSWYDM2JpUwdzq5DzIofPdn1rifnpM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qKq6k8u/2Z21Hei1A9XsxFiHN1wSXw48Hfs+/9vxLc=;
 b=mPUsC/qovgp7CkmpsSz6OhR8f0sOS7kW4+7WjilF3JEpsRcrlKCt09QjD5OVPaMpHJb0ENm8MCCLdDKjQpM4QjCd7evn2QH8mN49xd7fqze2Ow2YfWXrtcdHCa9bb0KQZ0XRNU/eT2lfFHzC4zUoXocBJdeeEPDLv206hWNA/pyZmSK8xVFbHlDrWkOQskTJbzhpd6dnc3GPc+MHY6on0wHdg3eOMN+fARuXRrEvoLHtAU3MGaXjb4Plrhaqlm8luNN0VhvEdV867gHyxeih1Sl5KifQvq3g+DCdeUyOO97jocANq7nQXfNYsVqxtyNhsCUUdPPYsj5gwuHeKrhcKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qKq6k8u/2Z21Hei1A9XsxFiHN1wSXw48Hfs+/9vxLc=;
 b=OIWuqvQ9zu3PgHWVWU8XC590PeGCxBp+aziTAyc5b9QYkrgP33oHPTuzCmSXlPSW5JkFwiPfz+DjZL6IYir5S3x3+roy26T6VWLAbOLEPu72LQeF5MAUVjgLddZhoi4hM1nrhf9KH4t/sHFcNOa8X72oTFbhc637rEU7tcaSnD0=
Received: from MW3PR06CA0013.namprd06.prod.outlook.com (2603:10b6:303:2a::18)
 by IA1PR12MB9499.namprd12.prod.outlook.com (2603:10b6:208:595::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Mon, 18 Aug
 2025 18:38:46 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::e4) by MW3PR06CA0013.outlook.office365.com
 (2603:10b6:303:2a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 18:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 18:38:45 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Aug 2025 13:38:43 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: fix vram allocation failure for a special case
Date: Mon, 18 Aug 2025 14:38:29 -0400
Message-ID: <20250818183829.176628-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|IA1PR12MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: 153b891b-34e2-419a-3b7c-08ddde867689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LaoUNk8T/OoEbZbOfgNsUPwy4LcyaaEYN2AzLWZXoZqBdoavQmWon+51LhUw?=
 =?us-ascii?Q?Ew390Mn7PqYRaw4y8mSEdNRreXV7mdfu3SlGrxFrZ+412BSY+dz394P2R29e?=
 =?us-ascii?Q?W1Wsr6clv19pG3Bg7gqQTlO7n+FQYw7b8FX2U0n3Kff59VMK6tyPoTUKIYZy?=
 =?us-ascii?Q?0MPgetkqe/pvrzzrUlxxUIvx8hwtpsl0hnZXejfZD3dJMx1L59RR3s3kBJcn?=
 =?us-ascii?Q?E9JZrxai1YCGxd9EbTjRH4JQZTQFk9x4IfGbbB9GDJ13q5pI3SOmq0jEsvlE?=
 =?us-ascii?Q?WlGS/A67Kkg5USBPRtQtvIs27pmcMigmWYnT3UmkKVMwvJbStHGFZBg62ogi?=
 =?us-ascii?Q?4OrywqVC9S0v168/RSaXsyD7CJaz/zETSVAeIow/4kgS3IHtDHs40F8fK7LF?=
 =?us-ascii?Q?UOfEP72rch26yVRFJeLyNaBwhNR397ZfgrYPi2fgGfOsCC062710FJOhwDze?=
 =?us-ascii?Q?ykYtWvTXitkrKpd4OfZXdx56eloOEFevZwzAvVTEOlQfRfCbLyQ8XybkWPQ5?=
 =?us-ascii?Q?xWf7/pKSM7wTeZ4kDoybwCtl9YJxcGB7sO7UY9wIY6rpj6csdKMql3DCF1HC?=
 =?us-ascii?Q?bZou9IXBYDJyiVw1pacCAuQwzPbB5hLf3H66HaX6IGZWs4ndiE5b+5B9haoL?=
 =?us-ascii?Q?wTNIlw2M02O35Izt6WFu7sZi3d2S5UH32D8u2a8x6SwWfYnstURDY3p5JyGk?=
 =?us-ascii?Q?tfY8MILa44ggfTHWEv+5DttsHYtMfHFZzND6i+j6H1S1WdugJJDYcrQY+1Z5?=
 =?us-ascii?Q?XaW18nE6AKUqGE7Z9lf0AXMtbZ4b0Z4swVRWSJkTcUqZ3tB3Rz3TKPT5/KBe?=
 =?us-ascii?Q?zCvvpu75yhTg18Xl6J3P4jmz07AcrwEyXiuSe+TXQ4z+KMSeK95N7bKM9mso?=
 =?us-ascii?Q?ggFRh9iHW3Qh3PVsq5Wmv3PF/EnIHVVNK9KmjftytYkOx1M+Nowr3FdPQu0b?=
 =?us-ascii?Q?nOL1PjtS1mrK3/J4920v20FEIj5Z5N2WKKyZ1b/dQXcmLH6aEIdpgeSu6sTL?=
 =?us-ascii?Q?BWoBAJ0OKhLzR8aLpglkSPFdhMqQM1PeHdAQtl7lDI+Xe3CvQdANefoGkIYL?=
 =?us-ascii?Q?tdEbePfjeTCHF5JxUa7QJ0C0+J0UhQ7lYUFmPyVkI2cxRsP5df+qmXaMs6QH?=
 =?us-ascii?Q?PY2faMu9RHzzRCDSeWhG6xKDdJMiJBsPiB1ovnrE9vFz62nQX1QHQZofMFdd?=
 =?us-ascii?Q?AARzxbdIa7N+3yIMK9RKu/9xriDSm2V1Rbq1mfuEJZK2GG+6O1IqyoU/U2W9?=
 =?us-ascii?Q?bGSfY5eVsssu1hdiVO21ofW/j/t108spQx7ruzHAMrJ/jZltbgKZgvKc+Zd+?=
 =?us-ascii?Q?/dghf5fMkfkNRThcUl4DifGOYZFGxNPQRfMt89PRtUbq7AkkOgtRwCgAYQ+2?=
 =?us-ascii?Q?ySuxsSDZq0fyrB9bYaWTB8czJ+DM8Uro13IlacTkJj9VGYXWqUYCxXPpDz6U?=
 =?us-ascii?Q?UziNndpAl8sfqwXAlg/X8xL7qQbKbLPo83GNTadJRjQjsvRVSVpnmVCC7ysr?=
 =?us-ascii?Q?WcdhuTVGyy+woa3uvk71fPYokKYBjVYveyZe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:38:45.0821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 153b891b-34e2-419a-3b7c-08ddde867689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9499
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

When it only allocates vram without va, which is 0, and a
SVM range allocated stays in this range, the vram allocation
returns failure. It should be skipped for this case from
SVM usage check.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 79ed3be63d0d..43115a374469 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1070,7 +1070,12 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	svm_range_list_lock_and_flush_work(&p->svms, current->mm);
 	mutex_lock(&p->svms.lock);
 	mmap_write_unlock(current->mm);
-	if (interval_tree_iter_first(&p->svms.objects,
+
+	/* Skip a special case that allocates VRAM without VA,
+	 * VA will be invalid of 0.
+	 */
+	if (!(!args->va_addr && (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)) &&
+	    interval_tree_iter_first(&p->svms.objects,
 				     args->va_addr >> PAGE_SHIFT,
 				     (args->va_addr + args->size - 1) >> PAGE_SHIFT)) {
 		pr_err("Address: 0x%llx already allocated by SVM\n",
-- 
2.34.1

