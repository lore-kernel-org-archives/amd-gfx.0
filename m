Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6A3C10F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCEE710E27B;
	Fri, 10 May 2024 02:54:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nThJDftX";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0C1510E27B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R65XTwbjfPJFAp2WdyR/hj9arMnRBHfIP1vmWxVQ96NGSA/fIvBDixcfTjLjCJdokWapL3a7JLIIMTNixBf8HBe8BtVvEqMX/xgm7/zSXrPVmfUhaoySPQznkjq1N2l0J+W1mPGlnBw9RM9MMjVioyf/sB9+FDROFeQon9DvRmWq9UZnDRU9TnruM7H4gteI+e30EGzEfvJh47QEqZD5yDkPOKs15dJgDnKHwp9G6q3d1MQhVbnJcGU4zu3MnDwPcCgmXhirPsDbNAgjbzEs22Gjp9yXw9tPgYEu9Azck/b2YN4K8Rte+U5yJ7767ZE4rJ4rJ6wNFeEqLVQbXS2Uuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikZ/qUqKKX+MgH3j4IXNq1v8frKmXRRNhB4n5drePEI=;
 b=O+/JJFuU0zaPvnKFeHNvdWtRjxsviypU3r0aqdJk0TEeXttgyNjQm2KZwLhRNxw8nRCtB6Izn4MSi7vgMMw7PURzkTH+YY1nJjElyBzSueZ+KAKbEXe8wLYoLGCZKEZPTSN8LdRcuqsbb1EENQspmSnXgEtjECM9Q1agDs9O/HZqeMiTdA1VnGSiEdAqhllY+9xjHUmRW249M27tQJqCwNW2wiUn4tMEEhRzy74AyWPZKjUG5tjhIs0pk9DiV7veHPg0zhz8oYCDu25/MA/SZrDbo7hNcn6y9zMLoeAaOCiGm331kMZdTBbi5+y0WsYzkqq9s17KsEl/BrgUmDx7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikZ/qUqKKX+MgH3j4IXNq1v8frKmXRRNhB4n5drePEI=;
 b=nThJDftXGfwwlElyVHVyTx19+LQdKds8XMD8HNCUKWjc9LScDkJhZl7qxf2y0ym4X9Hmdbf1eC5s5X+U0kXQRLpwGbeTtkQk24c1KcPL+AI23g05gfQMQsOeCrEVD1dTs2Fzvv6go4v9RExxa8jEz4+Qqov4qXe7ES56t0bcafk=
Received: from SJ0P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::18)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 02:54:35 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::eb) by SJ0P220CA0027.outlook.office365.com
 (2603:10b6:a03:41b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47 via Frontend
 Transport; Fri, 10 May 2024 02:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:54:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:54:33 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:54:32 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 21/22] drm/amd/pm: fix get dpm level count for yello carp
Date: Fri, 10 May 2024 10:50:37 +0800
Message-ID: <20240510025038.3488381-21-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|MW3PR12MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: ca18de14-7270-4d04-cd8b-08dc709c8623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xto+F1lkld87enLIrfLBkSqFLpczswBlMLwXSKeacgKaEoyDRMv+csN4+v4u?=
 =?us-ascii?Q?+gx4/p0++igtxEAf+ceq3iavPTwEFlOCljAmxYBVqOxak1pOL86sbc2qnKms?=
 =?us-ascii?Q?oPgXp5Zu+53OJIRAGL/RPGQZ6fVB3yMacw+5JSt3kWHOXxomoAb0LqmnhJ+e?=
 =?us-ascii?Q?4gMiZeP4tWrfII7Gyy7De7B5QDZAyhUDQzVDdDzEYlnq5mrx8wKZZEqpUi9M?=
 =?us-ascii?Q?QKkl+f1W55puzbENGH0JZzQ/tgg/S9kDMVK6muSLyuEAlyOX2liImeCPao76?=
 =?us-ascii?Q?TatGYpgFrzSGveuow6KddEjT3SHYzYMNDJjnYoXe4iSTcmfl0EpJxNKyda0g?=
 =?us-ascii?Q?diTgY017MGhZAghYVoxLEb8pWUAuBb9jqwtFTB+mI2IbMaPzN0X9NAiugIb5?=
 =?us-ascii?Q?b+H+/WP+K/wlzzFYjl8lnlKhuKvjsihUkAgx2n6vWXqGstkf8Au0T9ZaCfdd?=
 =?us-ascii?Q?ybpqpYttot7TfbxPG5h1wnKo90WUr9hQDgSRG2i5khrgM4/Q+rNNEhOSLm84?=
 =?us-ascii?Q?SkedhDekNer23A4mCaw1vCv6aQY0koRTde6aD3UE+DhtRYKiA+sCaa5IcAkO?=
 =?us-ascii?Q?AbYWuv0X7zNjfwNByWP7XL4ZTYRy8dMob4yfUAkZhwQLYjOrBJwFwPKo0E9X?=
 =?us-ascii?Q?1Pku32JHZHkFf0vBWqvL8g5Lv6OcIt1t3moZh0JOmHmYi8XF9YARL/dn7fK9?=
 =?us-ascii?Q?11lIZyOgdHQDAlPOR2ACNVmLhX8P+EZ9SBlX+r6WQNVfK1Gpk7eyuxAz2pQp?=
 =?us-ascii?Q?U9BrqbuzIHUIrBdv7feicsUKJWx+dZbYSqOmyNtSLq16isTZvaP1ONf8XVGh?=
 =?us-ascii?Q?uCrDru5tBramLQAz7epsf02RJNjMSSc73h/gI+ccMKU3S5ewpFe0JeLJY6j1?=
 =?us-ascii?Q?mezFL9q6XsKRq1tf/O3EP2hZHVC4kS5+qhKrGoCeXMQW1xAj2PQhOutsQzs/?=
 =?us-ascii?Q?CodZWhp2e7omkE2b+xIZdS5e691WZ0on+pIxgllGKWrS9K86w0alMo6m5Bma?=
 =?us-ascii?Q?BK7FEKkCxnV+tum24KxvbLTRFV+JPrrPKVzNaEQHz731PTlUb+HAd5N5SrkX?=
 =?us-ascii?Q?x3IYQorn2cWnc6zGZEBtzSkrSuXtN9yPOjRbJLp902yiaZ82xYwUJ+2Rf4es?=
 =?us-ascii?Q?R3XE1zsBKtbX45Upg/R9r/PQFs+r5CXv9m0VD+Xiqc5dJp8nV51iwkfZ/T73?=
 =?us-ascii?Q?queVTZdxjU7+HhfH/lH1kUtleN+/G2lnZcMJLPHKH71F7bD0Uf3QsteOBoGd?=
 =?us-ascii?Q?/mmd7G/8lBgz5BBr/1UvvoVsWzpHyM+Y4MRlp371W212Zv3RueVxLoJL/RH0?=
 =?us-ascii?Q?zFD38u7180/gNxb/aM7eTINQHq0sm3gAHQ6ZU0KYE3v6O2PebksEY6KG/0ac?=
 =?us-ascii?Q?iieSs/22DdPMzJJFuR0p63otvQql?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:54:34.6532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca18de14-7270-4d04-cd8b-08dc709c8623
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393
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

For invalid clk types, return -EINVAL to check the return.

 Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 5917c88cc87d..260c339f89c5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -777,7 +777,7 @@ static int yellow_carp_get_dpm_level_count(struct smu_context *smu,
 		*count = clk_table->NumDfPstatesEnabled;
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.25.1

