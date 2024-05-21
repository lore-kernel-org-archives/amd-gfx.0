Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0F2C25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 07:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 241AE10E460;
	Tue, 21 May 2024 07:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fAffCMm/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53E0B10E452
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 07:18:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5R+wx9sFJ4FCkR+VGkGd03rOUycsnV3qf/ogHFokZQgyjB1wrt0qp2jfHZwutI5yQsLM7G/G6HV/erjNeUYiHqVFxH5xQ1zQCKGKQiCP2XhsVITWuM34xyxu3/wpmK9wAXXDayfR3HQdRLuA2W7wQTT6VfClWmkzAQEBGyGH2XVgjCODoxK/QelCWFXr3z1gTrmksoiGM+V+vhwiqqtFJ1EPT5IUWaLPVlKekxkzHW2QOZK57wEnA+nIoLFWmqTrk1C9ZAz7k6TYdvCBeGrJ5H9ikSFukBc5dYZWXr/dAzF/Z8L6HRkcNQgocxv1g8o3Myj18NhRWIih/EBeZYQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiWRPxYQTOZIMNwzv8yaQABTDMRZEK2kTeqqL8SqksU=;
 b=N4NuFK2vKMMoHRLA5CImZCLbbc1ChUh2h9RjMD3ga7ZrssNaJwm23Xf4DqSNvo9MqTPuovaH0ZmJ3OFS8y4fntlFJiMpvPFX4Z3zTqZkCvfaRLM55XD2cbAyDK6ON7Z9BbiJ9TrZ92XbcsWjedkNC9uOUjzHltDkEWed68I97zJ0O03V1ZyjNnRgauVwEOIBTDUwS7Va2FMEDVdd6Dn59Ni1/QxQ3UXtF/8hnFfnclw+7Q6vuv9UCj4wDTf7aFshKlBKhbCGTa/RAlIkcl7M70gzug83O1JGYfIiXi24yxR0tMFXQ6dhyY2feMrom5/8BtKrtUC1NoZYNvZq+Y8Slw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiWRPxYQTOZIMNwzv8yaQABTDMRZEK2kTeqqL8SqksU=;
 b=fAffCMm/f1t3eZ/h5uzaY2JmGOxqu5w1DMbVMIK/ezu/TTzg6wtaqmeIZZNyhXe5gm51+kJocteV+F8tHoGmIaNv/prauGOR9bj9u3Y9xuNMaH4oHu7sK87/EqEvxjf6EXDZWVGWqqkrFOhGm+Y/t/zdmq3nPwhAqEVdFKopzkI=
Received: from SA9PR11CA0008.namprd11.prod.outlook.com (2603:10b6:806:6e::13)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 07:18:03 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::9c) by SA9PR11CA0008.outlook.office365.com
 (2603:10b6:806:6e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34 via Frontend
 Transport; Tue, 21 May 2024 07:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 07:18:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 02:18:02 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 21 May 2024 02:17:55 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 4/4 V2] drm/admgpu: fix dereferencing null pointer context
Date: Tue, 21 May 2024 15:17:54 +0800
Message-ID: <20240521071754.371526-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 264f97b2-ad9c-4b59-7680-08dc7966273e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W1quTNDs1oydZYPczV02eMUCrqhgi4CuhY9ooQVxPCBbVcxc9c0DURNBFXOZ?=
 =?us-ascii?Q?cYerrzd1o/DBOAa7xCv+287fYOW1/CF0HJKxwgIvmZqgv2bLoILH5EEyEUSf?=
 =?us-ascii?Q?cN2l6e7ZCRCgVkcYc93GUZ8RPxKy1w7232KjZdfMsj9zMYV/L5JVwYlizFRN?=
 =?us-ascii?Q?NPB+pfjUxmB7K5yjhTzRizzahBvuLzS+bB74+v7OuvIzZrbf61epB1GM3VXr?=
 =?us-ascii?Q?rnxhFmKO/oiM0YssT+Ew9RMYVqYbg5QkUyd7GHzji1GS+EBZF8VIzQAoalQw?=
 =?us-ascii?Q?OL26fxc3xVcGFv29tRobdFNruYlSkZ6jaQd194bXGmYvpPc9ctxUb+qqV7Qm?=
 =?us-ascii?Q?0HO/zsyVzNUSUaTUTY35vMW1JpFboUUkFa69mQUn3dkCnmVCMXFfD230LKqc?=
 =?us-ascii?Q?R0cDvZiJywcxIcN9dSS3ST+WN93/Iyx4tBsN8eh9s/PxvscwtmurewGBkwTZ?=
 =?us-ascii?Q?u1FAWjRrhWv5SaRdyFw9K+N0Kgrnc1qmN4xg+7ljPYn6QYNAj5YrFpI91Uuo?=
 =?us-ascii?Q?9eMsxhuScXT7Uc0pg8ZNUWf3JDV2mWpRIB3DW+Nq63D99XtWq0F69a5gh9Zl?=
 =?us-ascii?Q?KPjj/NcGfSHWH3950pW1cZmMqAIJtmFEeWZovrmuKF+vz1sQSW+t1l9xmhRt?=
 =?us-ascii?Q?jzaKbxoqd30ks1y+Id5nItFc/ZB/ZnSZi16ig2OW43iEAIx1wzXjT3Tv2v4X?=
 =?us-ascii?Q?mp9LUtSjEinPHMzIV2Abac8QuBxhUW4ahnPdoW+U5dqY9ygtvWEUvjYuDD2q?=
 =?us-ascii?Q?+1UuJNBV/BzBEKKeWaG4vqiMGBi+e/iE+934mft765cVDVBzTm+dlA2nVehH?=
 =?us-ascii?Q?smj/K0Bt7VQ1S3e6Oe6p7APouj0T1ea5G+MMQ0aXErQ2uiphUmdkRvzlR8P/?=
 =?us-ascii?Q?C+sAfLf/C6lHQf40gCTFepJMcqbPvwX8lo8Vvemm6AcKyKls3HEx/htk4nBe?=
 =?us-ascii?Q?Og2C4Si/bPsMc36LsfLF31Ak0ey1u71i/16sqk91Zoj7ug/ao8zcUMeirmq1?=
 =?us-ascii?Q?FKwprElS/p0muWzMLnYBr4f6Sl3wqiJFswae6GGOY9fFEGv7pqh91GRocAG0?=
 =?us-ascii?Q?2HVf/XUAwrOS64VyTPa7hJQS0t4GRAgexnsNtFjNeR/0oO2qymsiTfi3Jxq1?=
 =?us-ascii?Q?P8DqdRXtjCKtyQ28zoeFDS/g/l2zdAN4c3lu5b/twaEcKIjv1l7O196+ivnq?=
 =?us-ascii?Q?pUh91YNhZzDpe8GhIJIt4df2nHdk8ephs+yD35jYh+xdgF3AEVgaY8JVOwq2?=
 =?us-ascii?Q?CM13PH+NWHPhtAel5b0dQEZKrLLqKzqudSvw5f9Kv/DKaNY0sMR61v3gE7N9?=
 =?us-ascii?Q?dPA7Vx+uJpeH05K83sxxBtv+Ur6tYm/ZJVoPbhI5XcSiqCXRhgi21Ezx74Eu?=
 =?us-ascii?Q?xoGs4Js=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 07:18:03.1172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 264f97b2-ad9c-4b59-7680-08dc7966273e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818
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

When user space sets an invalid ta type, the pointer context will be empty.
So it need to check the pointer context before using it

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index ca5c86e5f7cd..8e8afbd237bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -334,7 +334,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 
 	set_ta_context_funcs(psp, ta_type, &context);
 
-	if (!context->initialized) {
+	if (!context || !context->initialized) {
 		dev_err(adev->dev, "TA is not initialized\n");
 		ret = -EINVAL;
 		goto err_free_shared_buf;
-- 
2.25.1

