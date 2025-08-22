Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D526CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 19:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5BD010EB9B;
	Fri, 22 Aug 2025 19:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZBzb4W6j";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8D4A10EB96
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 19:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eF/MSQ1k/2FIGCf7U5OqN2N6TVkzvjTYCSZYmVuFV1Iqq7nYBqCkmtgpmm4Y4YIlb/P2EK8Rld5Cfuack2gtlQQuzUB4Ur5jhTBEgDfRg8nzC5Ee1xg9Jp8WEFn72rEuHqH1pzO/jfmjMWzXEvLCetVFqweOPY1c/PQGb32It9cwQ/0SDG2JdALbOyF8XUXxQzBbp3MoMpdk/GBLsaPfWX4CiYqr2HK/PRq+XG2kF0zBtSME2eV1So7AWYNOyLjmbmD27bKSXbCjUyKyFD2r3PKvRn+mEBbXdAc26CL/xKMPqp/tBUw4WODFJuQqcMXYI8viIT+44oM3zC8YMys/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNwtEsxj6l/tgLpVAYjhf8yRSWDgsrpZCAh9++qajCE=;
 b=jiRA+HlrQnAWqeBAegf+0qRntVc4dERUogS50bBJ3f2xVT1G909u1rbodlbcrz906TRKzdxNnmga9sawxu7XIxGzuIwOdgVX6BuBG4XP+m0loSUakhRVy3vdk/291NgGClh2hS8TLdcrVnlPZAcbC4aLCeMVTuyMN1clzW5VVRwCZieAr31sBtc17kN6r/9QLJ4xBmfudsgIXM3hUmP22xI2mlVtBlnUVtthiaLGt6Ae2ZVWwuFsE7T2xIwdB9PhJ39kyQsxM8m/KpfTR0YrjW1j8QjWftNHWQ4nDfa/T1W71W8I6NHUOd2q/Hmj+zCGRiwS7hvC/qEbhL83B96QYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNwtEsxj6l/tgLpVAYjhf8yRSWDgsrpZCAh9++qajCE=;
 b=ZBzb4W6j8bQYUYkAKt749SxYTTiCnU4PK2fgug8nQpD0LQUpaHf3w42nLZP9pnIUBTEI8Z2MdB9o0BoortmcrjFaovqa34TT0HXbwQOQD5BxOHxaoPUPKk0u3zs0/A2TNmMNQqq5Or6WhRpx8kw2tOmmXTN2QQqFt9FgMlRbtAo=
Received: from MW4PR03CA0297.namprd03.prod.outlook.com (2603:10b6:303:b5::32)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 19:48:16 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::2b) by MW4PR03CA0297.outlook.office365.com
 (2603:10b6:303:b5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.18 via Frontend Transport; Fri,
 22 Aug 2025 19:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.0 via Frontend Transport; Fri, 22 Aug 2025 19:48:16 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 14:48:09 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v15 4/4] drm/amdgpu: Allow kfd CRIU with no buffer objects
Date: Fri, 22 Aug 2025 15:47:49 -0400
Message-ID: <20250822194749.362771-5-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822194749.362771-1-David.Francis@amd.com>
References: <20250822194749.362771-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5d8c41-387b-47fa-be7c-08dde1b4d66d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c/NAqsA4XJxVGnIsLmfiN3KAZ/E2NQzUF/DNM8TWGiEeGdt8r2hnVoy00REn?=
 =?us-ascii?Q?w4PVLPkRhg/tEFWkjar7yT2XYVGIVRk/vokYR5fn0umhYUtXcBOe8SjdCpN5?=
 =?us-ascii?Q?LMUj+cyqly7+jBN6DsNutyEiUxJa1spD0nuI23LpsjG211iO9QSy4+rBJ8gt?=
 =?us-ascii?Q?nd64xEMf9Y+0bQpVGgQrx0cfWOpi7XZzrn1EPGCabypydgMKOW9R/UWIBN4z?=
 =?us-ascii?Q?XXuWrpCGLFVQ6rTU3UE54cFlGHUGt3nNFoF+HrGm1bAWQShbzf/MadDtPexm?=
 =?us-ascii?Q?qgDcyEmpBKWoWNsRBlq/Jiqjg9JqV/F4Jm5OKQReIvkpctkgpS3hSDONIxwk?=
 =?us-ascii?Q?SK5NlLyhiTs4p7OAsiqA0bJiLB2Xn4ikzojIJvjhG01gQirc7J1OR4uNjtp7?=
 =?us-ascii?Q?LqhWR+b8vcwLchlnotsb0p12qSu9L8M5JbsU/cUZZRVoNwfsqEpgeWVLabWA?=
 =?us-ascii?Q?wBB2BGqzdVXT9NX+335d+st+WcnytualRE9WfauAbhEn/6oXf87QwqBUBeay?=
 =?us-ascii?Q?frQQijN0xTlQh1IwMGBSmBQ/YNx8wQOY7EUWUAJm0QdYX3JTgQ6doZGbrP09?=
 =?us-ascii?Q?aLHEd+as5PJDwHDvkV4UNpmXnS+z1R2TlahBluf/g/N62KwWL/ByM3/UHonK?=
 =?us-ascii?Q?RLRlicuyoY3V3dU5kOm5WKVGFi0ysSwxiS2gZSHr03UgRB3mBMid5hGD9DGN?=
 =?us-ascii?Q?sdNU9r95J9bkiU85LCfXbJGB2GuT72n+sxYEKJWsn1kCtRVUO6d8Wyu+NQ2O?=
 =?us-ascii?Q?19eNZbd72ZKwNkK7IXrdPstC+xV9Om1WREyl91V8xoz66Wp5ll8drXAFw0eG?=
 =?us-ascii?Q?exiKovm2cKVOpLnvf/ivDm/QsRaFFUBjMtIyeuX7OwP/0Jqx7oq1QdsifLPU?=
 =?us-ascii?Q?fmyngbYDa9HqZu+Ja1/1cgvWtYOB/0sMGxWREyGAJfYLKyLu0WEouaPDJlvN?=
 =?us-ascii?Q?/x2QJUzyu5FndSTal0OJI8y5Pm+FzC/AL5XNKifcMpgJiroVRAks01Lx1mfD?=
 =?us-ascii?Q?C1MBw1qQR0/0VBof0jhaYP2shjLgtgK9ChkoPMKGllNq65oxoudZTUtVE1Y4?=
 =?us-ascii?Q?v1i6giF+nFOzlt0yHrigUjSQY001twhu5X7yB2mrc+MArDmr23OCXYgaASHL?=
 =?us-ascii?Q?CS8WIjbLeLCCYx1mSXVj24ZYMZsGaQzbVxeGw5n/AfZa+hq5TkYL/ePu3Rna?=
 =?us-ascii?Q?g2lbTbHPCEt6tqMruAxuRXquyIngKslGTNK3KxtBWhTAsy6utHXZnmJDfdqN?=
 =?us-ascii?Q?22zfX/7VAHM1mMXAlKManxsY5WVUwzykxhRPNAHdzIp4HlEOTOXFLaTiWvkg?=
 =?us-ascii?Q?QXzvEjdZuktDYNTyqzEz8QKoH574kHJV+UrSlXDyNyi1rWsPamNAEOubxZ/c?=
 =?us-ascii?Q?+rc/5KmiLL6WkPu7/fcSxWaOJj/A6q+2G24mJq71NRr/SV0TRY7tvuT2OZz5?=
 =?us-ascii?Q?fGa2RAMR8SXeRNAVBpPrkcKIXgoF3BRpxU1pEXWvcaURe7nR4K07YcLszL0J?=
 =?us-ascii?Q?/kAEzRQRYyIt086AN1QoUav9ic+aI/G2NzjU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 19:48:16.3096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5d8c41-387b-47fa-be7c-08dde1b4d66d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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

The kfd CRIU checkpoint ioctl would return an error if trying
to checkpoint a process with no kfd buffer objects.

This is a normal case and should not be an error.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 828a9ceef1e7..f7f34b710d3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2566,8 +2566,8 @@ static int criu_restore(struct file *filep,
 	pr_debug("CRIU restore (num_devices:%u num_bos:%u num_objects:%u priv_data_size:%llu)\n",
 		 args->num_devices, args->num_bos, args->num_objects, args->priv_data_size);
 
-	if (!args->bos || !args->devices || !args->priv_data || !args->priv_data_size ||
-	    !args->num_devices || !args->num_bos)
+	if ((args->num_bos > 0 && !args->bos) || !args->devices || !args->priv_data ||
+	    !args->priv_data_size || !args->num_devices)
 		return -EINVAL;
 
 	mutex_lock(&p->mutex);
-- 
2.34.1

