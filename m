Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDC9C48BF6
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 10:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD0FF10E352;
	Wed, 21 Feb 2024 10:54:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pWgQq//a";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DACCB10E352
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 10:54:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCpqvEO7FbqwQ9TOV0PzjVJVWI2VtVECArelMW08kii4IbnEC9uG8ykTXh8G/T1BRRpyIaQMUjy7qUaWiH6KwsvYA2ddjqv0BIImEYZ4Ra1TKfjgFliJMZK7JcHsrSxNjuYvTu/8SejIRa9Q7/hFyxHZ0J4WTlUOGCP7Vu2oTtUNQAyRhOl4hjYEKa+iBCc7+2yahoidumGPlBhZtmm16S6iOaazs7bGXH9eHP5R2rXG9FSePQRxmHe+zfpz13s0WpF2ctFRJv464xZ155rq/TsSG67AQOKptoBkw51IEhuPYfWrt8qUeT1GJtN0JysQccWQWZjd2DA7JXHDINSR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5otWD85yjBC9Az++AazWvHnEMRDn/cQgje4DN9X8J3o=;
 b=K4DyxPYqiNU6kObzIP+3o6X1Q+KhVFw2W804jS9I1e2F4CDBHxXz/Ib9gYwZ+0j32bXOLFggbykTySUYR6ebEk66XAAARZ7RwhE5UsEjXTVJmy0bpWmozMuB5xQ0DAC89ZRSmBhZ9Wnrno4bzL7XW/r2CvX3uCyPgC/yfZph9ejiuPZwoC8oe8QyUTyNgKjyQ2v3Za8l9xwmPWFd7nBMnADOGWcgihDze5p7DmTVp59peTYbIMTBHRYc5xC+i1SGcGP0/RLRfh+eYV5yjWOIHy1q95KMTHQXZdwUg4MN4POQL3yUwShYTngbGgL6Qoawhqq9sf9dZaWoOCocOXJqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5otWD85yjBC9Az++AazWvHnEMRDn/cQgje4DN9X8J3o=;
 b=pWgQq//aPZQciPGKQYTjBdVSYd2MxY8PFQ94iieIdCA6I+F0+ZyFjQ1stv+V686/al79rcdzIuWWuVaiLsxnqpxTB4Ia+weISRX6yCKPgAomS1BzOm/UnEkWNESxOmxe5XY6LxxynQArxKrjL6cYkB93Gvc1bXgHs6nNZ737HRc=
Received: from BN9PR03CA0179.namprd03.prod.outlook.com (2603:10b6:408:f4::34)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 10:54:35 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:f4:cafe::cb) by BN9PR03CA0179.outlook.office365.com
 (2603:10b6:408:f4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.41 via Frontend
 Transport; Wed, 21 Feb 2024 10:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 10:54:35 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 21 Feb
 2024 04:54:34 -0600
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <JinHuiEric.Huang@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Felix.Kuehling@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>, Jonathan Kim
 <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: fix process reference drop on debug ioctl
Date: Wed, 21 Feb 2024 05:54:22 -0500
Message-ID: <20240221105422.1354628-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ebd044-2537-4429-975e-08dc32cb7dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65EK2FbCMPhW8B6bYXy7OCJ3Umq222Zj9W2R98eh1zNGsbnaVMoPBELCq/Volu56WZQbstjPE6NA8QlHV1nq9u4P2PL1/i1WFn4dwyHTJWl0K+Dl7corC6ZduJPKhifwI499p4jJOTjQIvPMPxXz0XGMx4fepQDkByN3HSjCHSDtjl2q/qNNhbEa3IPS3KHjOoJQEsGfMk28p0gSXQ3PeviQUt4EAkLNha6iiDiNGiDqWteAa69wDfKOYgxjoLfS2wuwvuE2iKbeDPyL3gcGjUwe5/9MjhyxfJiz1Aq3NYQvbP8wUvc9BTq6CP4mA0L3mo7A3OT324M0vnyP6NNKXscjrw3pj2Ii1oUD4kOeOyxusL4Xnh8//crh47NN70Iob93Kc0ceV21SakN8Mip4Nib7KdfcxbVr51jEVAmiQAIoZNT3/Pi7YcBDtPEEnIf1X1KwaEBTMuHvXixECz8/Uvpl3H4XUP37V2ZG/gxMh+PSrMNQTlN7afG6/hz1nc85sxQYr+BJbsfiDYVNJUASs59y0ug5S4xBxMpXN/XBcQ1IgmQCFigJsKLyLE07alFyb37O/KW11lT5as94y/kkg8BcILzL1EyySzo9a0NmaSBcavQV1qSNLgiDBNGRJTg3ZEHNCo8JzLUUgyGBXh2Xc7mAQLYVmJqUgq7bXhTGHDk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 10:54:35.2754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ebd044-2537-4429-975e-08dc32cb7dfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
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

Prevent dropping the KFD process reference at the end of a debug
IOCTL call where the acquired process value is an error.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 80e90fdef291..824e660283b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2935,6 +2935,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 	if (IS_ERR_OR_NULL(target)) {
 		pr_debug("Cannot find process PID %i to debug\n", args->pid);
 		r = target ? PTR_ERR(target) : -ESRCH;
+		target = NULL;
 		goto out;
 	}
 
-- 
2.34.1

