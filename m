Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78311C87FD2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 15:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB3210E114;
	Mon, 11 Aug 2025 15:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O/wSrv3y";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4149610E114
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 15:05:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5loSt/J6flouoa6YzGHBkpxlGQlN1QCfihhIPaocDVaPiWB4rMt9b9r0P3CYAzk2JNS76o2wKb572s6IHJFwOGE0c9JzzMKGr0D9Gdo0CEdyLK9CZtocOqM1Wid/iyE4RdsPbWbcOQ8zZkZTERNi87PlBJ2QzkfZm3h78knWKur2KKbrjZixb7Rn8Jblp/hfjPXBabRfXgu2iZu1h2c6MZ+Ei729/ug6vh5kreZcfSJ2OLXthrx1m/y73jwn5FUcvfNrbDUwuVlMZtDEnc26GdBjIHXlstHk/RU6sAdHeq1OvMiNSwnsz5gHS3L8C1IM+iP5gvMgcGKRNmGGVzVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNwtEsxj6l/tgLpVAYjhf8yRSWDgsrpZCAh9++qajCE=;
 b=KblQpzfgCpSw3NMBmkihmmw4sR6THT4YgeEZ2E59rV2+ikh4jRbEVTOtYOwqfVoVpxxuGOiwdrCX5CJ2s3QpR80nFxA4quZUDAAYQa52P1SU0VcCD3iwEiDMBi6Qy6zXgPM8NLpiKdNK38RTlR0dNDrGNn4MsueogqxN6xXN4HKhczM6XP+TYyHxBiHir3IxwfRsQJrtEkAyZFHSdhu5rXveHXjT0IMKqirJDalIGwVIGBurHz+dOhl7D14d2g3xZbZLkQ7AJcjsJiDq7772l6BR3P4rytHgTdSpcF+jJlhqeOck98ZTUz7UOnX/fbMQ/bD0+E4ivWHACmXr08gFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNwtEsxj6l/tgLpVAYjhf8yRSWDgsrpZCAh9++qajCE=;
 b=O/wSrv3yxXyMdtA6P9N7awKjJUnGETSZcye9iXE5eQ5UUc130OgKH3xrFmQ7rKua31f8sU689PGz66VkSOP0O7u0Sopl6MmyAee51+o3/+rzxwxtVQSqJbM+jdmtMya5YR6GBQqkLxZp43cMjUYfp+ijsjCNt9OwfkykHHCz05Q=
Received: from MW4PR03CA0168.namprd03.prod.outlook.com (2603:10b6:303:8d::23)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 15:05:56 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::ca) by MW4PR03CA0168.outlook.office365.com
 (2603:10b6:303:8d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 11 Aug 2025 15:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 15:05:55 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 10:05:53 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v12 3/3] drm/amdgpu: Allow kfd CRIU with no buffer objects
Date: Mon, 11 Aug 2025 11:05:36 -0400
Message-ID: <20250811150536.3394262-4-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811150536.3394262-1-David.Francis@amd.com>
References: <20250811150536.3394262-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b4d8b8-7704-4b27-e3c7-08ddd8e8920f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tFTo+geBsE0fREngg+15RVa/g+OXJbxLklu1D02BWzsPHCFNeFHSOUCj3eE7?=
 =?us-ascii?Q?RW5M34vkTtZDxeFotccEiS1KCIHt9jB/LEzEzgRXCcbMRSgS2v+eclATvT3g?=
 =?us-ascii?Q?DKm+Quzx2NuZAzOG7AuSNiDsGAOwqKlTVKi7e2kQKGTDvyG/KDtPERusM4+c?=
 =?us-ascii?Q?te98R9GUA9kWgSF/Fpd4XotilmAmgcRwow7XR56vUoTbj6D3xro4F5M71nFy?=
 =?us-ascii?Q?FyO1un3Cem/Wh+hNlV6QJlZjH9odKrZ9VQ1xMGrwwTZA3Fz9ixtEYq+O8y3W?=
 =?us-ascii?Q?ig9G6KubxZEd8rXKSp+Ce6xfS+s96H76V2dXaYPF3a2azMBpPy8KRRbic/px?=
 =?us-ascii?Q?zP5Uj1JhTPf+ON2ThfMxNwLiUJWbqTe6GKcyLD8b+5C0BcXAbi5r+l0UI/JI?=
 =?us-ascii?Q?HAcfYsQCw/WD+/oBorirl1vSOCNzwFcxBPdtoy4csrxLbD0ZJayeDKF5mlMu?=
 =?us-ascii?Q?pdRQoWqiUr7nHlX61niH1Zl5czoLkAlyfLm8p4KvArIZKncQRsf8u2OFzid9?=
 =?us-ascii?Q?K+OfbtnGavPa/n4kuATADgGN9fM+jcXP9YKCMpnCC9ZDdsknPI+r7sRP6TDe?=
 =?us-ascii?Q?yxncqWBzjCNH/QZ7Hy9Km9YSHS3kRpfJ05xC1SZgMjpGoKUparUtHK9gnVVu?=
 =?us-ascii?Q?zV1p4PsmRndNPUfaUczaJtTeumvpZ/QZwNLM1Cr+fDPQpOGWjFnpgkw86QnZ?=
 =?us-ascii?Q?Lg0/LURNDmUNvQczzzXImGiEZNtmjogXNWMqyudatiPofqCQblSFQy+9ey7o?=
 =?us-ascii?Q?Yqx+JaAyX8dB1+8bIH32BJFYuGvgb535ckfxdicXconuoZQe3JveSCxz5MbO?=
 =?us-ascii?Q?SpLjRscmebLEqAl70P3/8dZzsle+ZwGI1e4CJppzZSy9QSrr16l+u2ESbZry?=
 =?us-ascii?Q?SC+ecNSVq2VfM69u6DFMqIixGD9TS8dqZl2B0VkJ9CavIZqwIx0NiOsao2Td?=
 =?us-ascii?Q?Htsh5AYHcsvXWGhfZrICU/IUoViJAHHYxwI6c02UNqg4x2tx667htDiEJ+HT?=
 =?us-ascii?Q?QS3Md9u2buUuFgpFmJYxv7JrkZ08t9t4XKa05JSxU/90cVTWt0+BJClQGfHH?=
 =?us-ascii?Q?4IXI32sKxtErb1eDMLi5oTSpnqG+BYf4yFk5P1QQlMiFiM0AHvYa1PZCyQfs?=
 =?us-ascii?Q?bKI0Jwq2wR0CQuscgJBlgTpIEweS76oQdd0eG+1l6Uec4/QMAPQskDCD65Vo?=
 =?us-ascii?Q?M3FPCfHUYTMGtIJ+lY1GbYdjsh/yBlwE4j0mdk7NTFu/HaYWpKc84JHiEkxx?=
 =?us-ascii?Q?z4iUF5ccwarxYZuOO+0DOQE3u6eRl+4MbYuUkA9vygykWW1zwvcYQji8WLlU?=
 =?us-ascii?Q?84PI/gV7hfpLHhNQNqumRLVGpRs6tlKo0+dTaSOTZaUQ89JFfRN+R5XxzhX+?=
 =?us-ascii?Q?awnM3JAStkXy+ki2W2RIays7OUlC6W6//LYx9hF6QafBXBQPokTWUpdHt7D3?=
 =?us-ascii?Q?nH0Su75vcOpoyRIY6wXV7ut9ldV27kWmwlfdKxtVFoCgo4kW6E8ldMoiuyvo?=
 =?us-ascii?Q?yyZh19uE2JDe7tPQTSFR1/56oB+ISdjE18lG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:05:55.0348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b4d8b8-7704-4b27-e3c7-08ddd8e8920f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822
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

