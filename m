Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2C2CA0EE5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 18:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 225BF10E795;
	Wed, 13 Aug 2025 18:50:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mPZFIDkz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5060D10E795
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 18:50:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iD3O0ei9wCPp0tQvIPfcvbyxnTCzHPOfJhW0Ybcef9doHU7gJyf/RcQc8kvimiBlPro0pBkcDZzpyiflmmNCuwT0gdrHMlbCwPiW1eKL7n3MiTb6LCFzNdGuV5rfX8s/fnKfDopmtSxmh3uxr0vUnt/XZKRWV3xqZywKsf2uL0kG8g/xfJ5JUJYNwoEn4YY1GW/U4oEOWp506AQCMl8OqiO8Cu44G9qEPZwRwWlbkOKTYfo/1hQyXdLxa4EAcn9Id3d6Yxp6McGHx4jX6oryLjxRQWfXVx9q+98ql5ooa7WC20nXrzx8eGnJ8w3cny91bshscmy84WaF6AAKB5Oz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNwtEsxj6l/tgLpVAYjhf8yRSWDgsrpZCAh9++qajCE=;
 b=w+AsaMb2pL11larNwJIOvWK7etoSXNLk+lsP407ihtZ1TYrLsu1NIRMA07sCnyfMogpklWY918qaGuE7BDutCjBzE8iFTL7odo/QOPaT+4Udd/pEd1TC3JeNB8oQuIvFCx5WmqEX93OH/2S9kzVO9D6t0Cn9JotXojVLx1FSMoiSlohEniDeise8MhltlEbp08n3FiwfCZaikGPhb8gHWTqI/6rU9xo1NgPxKIWJ9HRANCveHzn42jXCbGyTmIIPSujcek/BrCokVsxH/8eOzdhnYIjlD0422vdCcxS9CRXtUN0sqztmABxf4Ky74+CdGdWToMQAZYULlXl3KG3brg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNwtEsxj6l/tgLpVAYjhf8yRSWDgsrpZCAh9++qajCE=;
 b=mPZFIDkzJbAa1A1N1IF4jWtqhRQp8ZfQgZrjY1FbKrqGus2Rp+9v4uaVdCoviItXm3GdnErLURd5MFkeKFYkuY5els17OMIJp+JAL2eTTwgCygIhLclrXgeR2W0wFzXGuxKUTEeN2LCDg0e6WjHkN2Y7vzX0/frSAXiZ8nrmFfU=
Received: from BYAPR07CA0014.namprd07.prod.outlook.com (2603:10b6:a02:bc::27)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 18:50:13 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::19) by BYAPR07CA0014.outlook.office365.com
 (2603:10b6:a02:bc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 18:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 18:50:12 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 13:50:10 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v14 4/4] drm/amdgpu: Allow kfd CRIU with no buffer objects
Date: Wed, 13 Aug 2025 14:49:53 -0400
Message-ID: <20250813184953.3666821-5-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813184953.3666821-1-David.Francis@amd.com>
References: <20250813184953.3666821-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: f4458269-0f5e-4eee-45f4-08ddda9a3c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IMs6rOvuZfEmy6SpE5PK0AUhp9wao3QacRkG61jkosxFenkQr6HVAJjiMVVk?=
 =?us-ascii?Q?Z+H/i/G+DoFtFDBg0yprDjIFLa3lRjf43xONrRMvgxd/723ZHj12BqII5NNN?=
 =?us-ascii?Q?5PEVF3ksla0rkWVbaO5eZ70RQlE8RDZGEG8Oir3/IdqhsBxnDSjwrguDNP8k?=
 =?us-ascii?Q?ZAt8OT8cWOo8MmHtKniOU1PxTpkYpjmuefRXhq/QoGS3eYY6eC+4fIfm3ypQ?=
 =?us-ascii?Q?ApSmRqMPW/TaGHlU8m7DZaJQLWIVuIL7hP17uFvzUZyjzGiwTw9fZVkYvh2O?=
 =?us-ascii?Q?4eNzvXdrprKRsAxlXywE91VA07jCo/CTyOnzpqqAm/3vrs4uML64/vjKZskw?=
 =?us-ascii?Q?az43+25GEZhpviznLZYYiol7B0GnC5OCIKwK0XJ2s4ojz8HMnyyJCJAT7bG1?=
 =?us-ascii?Q?U5lg3QyIphmgk7I8B9gGh+Umafb3FL/7QpFe25OApN1uRNaidyhDsTNPrmlY?=
 =?us-ascii?Q?i6htciX2nFu/ofgeQARfMREq97lPjzVkAC6Pr99p60rntfwj9ByK57iAbAMU?=
 =?us-ascii?Q?jfms7fygBjim/lxPxBfegFZzQQb6sVHp6/ev8Y19xRxkl/5Qz2gj64in6+vy?=
 =?us-ascii?Q?oOx9NseaJkjks7jPvrFDlgbysebeMchQK86d6ZMFftD0PAq6y61DJMijN9O5?=
 =?us-ascii?Q?TEeXqHSLafaEdGKZI7/AfxeMcLNr+CG0PlNsjrf/YMZFSxJB2uNOS4pdsZgS?=
 =?us-ascii?Q?IMRb9enXUmchkf8mbIKS8SMLCmEWJhSmvJNnfKU7bkKvdgIl0YJyxVLk+EFd?=
 =?us-ascii?Q?3MN1IM1FLzBDDf6az6Vb/JzJ3rFh9FIU3R+rl5Eet4m104jqaYsLE/91sIRx?=
 =?us-ascii?Q?Eo/YQIGaAVsr6XLIG1YuEOgMLBOSwttsHkk/IxHawerp9Gpk2G1XQL1uFb8f?=
 =?us-ascii?Q?0EfekCkUtglelOi5WqETyH5xT9Dgil/J6AR+VbeUnoGMuzmVJZhvFBlpHwip?=
 =?us-ascii?Q?KgNQQk5YkRMDtmkxt/CEPjcnOTYvZ9GsZztQemSqrdqm9QGY8tgrAWeSgh4z?=
 =?us-ascii?Q?O5OwBLUSme6mr3xszQvKP7JBYzsZbYj6Ybwva+QAUlOX3mldsErmvAFrKJ9m?=
 =?us-ascii?Q?swR/RNcoaMURnA/1avqvo8jdgnEA4OpJHEPWr1yhqFX6ThaJcqyWKdLL4ABB?=
 =?us-ascii?Q?+86Z8OE6jdRWfiT4T2TiCOJ7FJA31LoY3NPjILkX2PPYZy++RTQ3snNHF2Wm?=
 =?us-ascii?Q?nZRDwHB6fIMZjzHBt8Pq0L/Wh3acutGprHFjIYR1dBYGxJ+X9NBwQMH12bIW?=
 =?us-ascii?Q?lydhXStFWU5ej9c9xi7u+Ged9/bnIadgw4itTnZX7QM2JWi5AyIt1M/d95bA?=
 =?us-ascii?Q?xNctbfMiQBR/lezSZoARkQnOUEynUL0whgGRMTgrOAwVJX+uerLM4yaL64I0?=
 =?us-ascii?Q?I96IYA29f3Vtp9Y1+ine1J1+6mkVrEJ0dh3wCBCPIovimmg65K8vywdVojzz?=
 =?us-ascii?Q?2EjpR24u3bQF4CUfJLnHW/CjWZL/FSlZstOqyHqmZPNScHIisuz2vJXrZeah?=
 =?us-ascii?Q?i21eV81Np0Kuo0EAXFQe4YcIuMR0kxSRFsNR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:50:12.8659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4458269-0f5e-4eee-45f4-08ddda9a3c64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720
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

