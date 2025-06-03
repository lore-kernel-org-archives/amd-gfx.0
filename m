Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FF4C5AD49
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 09:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9A310E046;
	Tue,  3 Jun 2025 09:12:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="feaGlPWJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04E2210E046
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 09:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0FlHbYqIf+clwAgrhuDPbQrPHkeSsxW6yFxP6eklbvwtyrc4sk0aSDYlxCDlMLX1T3nUsiSnPfYhcABE3Jq6+v6ZARp/wveblt18u+aBaJ525i/AULFy0rvKJqX/01tZCHPHZQSOowdgc/eGuWUAR2QYudc4pJ6uCOjirHUpdRXrEJ+hJjsH6ESK+p0TtWxX1akKM6l9eTY5K+N7oO+f+S7/2zkNWAaIpxS/XcT46IcjJmhZdw+cNBryuuEK+ZRHaxG9L/qsBLZHVV2zMF0Yzjq0UbqfAUCoVmMcWuuvQ97YyOQKUqk1/r81IrOAFKpgmYVVyq15JPYbnMpT1HQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rh3hIiLPRhwLZeiec/CTJ2xjhbnrzx1Dva572IBC9fE=;
 b=XkORrjKUVavv8NIoRgBBKVPsDbMDzJccJVjqIVT7q5W8i8FTS1YoPfbPWbZhT1VwrOGZb4bQrFHksGE2+c5QitxCdju/NSckjUoHPZZyRqwlB/keUzJ9hRaL4avGmLWXnvKtVsnJu04sM7otpLS/9t3YZ4wl8dldqDR9YFwHNNkb/iQbK13hSjvpSM2ADa2WFugryj1GQXVUJwiGz026NIdo/OEhBF7Tz2rzYXShL2JLv5lgCLXM7Qp9rXJrnjRLIdTwf6l8yOBfTBqMW/EOP+uk2EPGTFKmdxv63m9C1aXPFXj0Wc0jGxu6CsHcPNqsvY0mJxmg06MdHuRzjHYRag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rh3hIiLPRhwLZeiec/CTJ2xjhbnrzx1Dva572IBC9fE=;
 b=feaGlPWJr/4ZX+hs2mbGKhdesJf8ThBEwuTMho1D43sFXJuI6S8xGPnIXKA2pDtScXDShCThEOl8qlM33nax2fxmlqOCBQQLJV8Dbhvj2zHfTERFHALU8t6iH9bA8UhSoVNPwiqiw9c6dca70gkFMGwo+AW3eTmxLhf0RVHkGsc=
Received: from DS7PR03CA0183.namprd03.prod.outlook.com (2603:10b6:5:3b6::8) by
 PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.37; Tue, 3 Jun 2025 09:12:01 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::81) by DS7PR03CA0183.outlook.office365.com
 (2603:10b6:5:3b6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 3 Jun 2025 09:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 09:12:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 04:11:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 04:11:58 -0500
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Jun 2025 04:11:57 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v3] drm/ttm: Should to return the evict error
Date: Tue, 3 Jun 2025 17:11:54 +0800
Message-ID: <20250603091154.3472646-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b344d69-ee19-4ebf-657f-08dda27eb2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0guwhpci8Y8VYyuGs6CO37l29iZAMewo9ToKb6NziDBWDzkdadX0YDOpZ2jK?=
 =?us-ascii?Q?320oh+XoG4yCDRrXNWhyPPqFJo+4TYzt+Kve3A7PHhAaFIBvgQYimqzKdFU/?=
 =?us-ascii?Q?AJ5yXSzCBC/uG9ReoVLYZdgMy5wrT0kiwQxbfsIEAVg0Epg26+XNo6VJzIF5?=
 =?us-ascii?Q?FaBgytg/XGc95C3Hm5Y1xTcijUFNl/bPaXnxNzU0uoftYx7Ec/ny33YTd6b2?=
 =?us-ascii?Q?jKjcdAGW6vAD/JWtHz5dqRZHS+/BB5zJj5x6eSRdJ1qGCDBiHC3uQAWh1LlN?=
 =?us-ascii?Q?eHx8km0RizxTjMf9pLZRzyRgib6SfnvHoouw6OUMuYtWqAl9wUyuWLr+ELF+?=
 =?us-ascii?Q?pfvFvo+EUEYkL0PgM4Ii4nKZ/kw7nxy5hYoVD6G7egngTHHssN/CXKTDafjX?=
 =?us-ascii?Q?mBzJD0EY6WdjJQtplCOgPKEA6Ni8XkKpcYWSR2ygdtGJkaNKGH1tKhYmWCA4?=
 =?us-ascii?Q?mKGi99xsRcgUVlAOxGV8mgJjfc5SgNueuY9PPHbi7PXNRkXxJMmwSYRLzb9V?=
 =?us-ascii?Q?52IFhZDdQHCH5oZutFNlB+Okn7qGGr/lorW8iNt3Zju9s5eKPdP4MMPufhjl?=
 =?us-ascii?Q?VqhO2iowmVHReMVCJmSIbgmrVyfYdTe5+W0HzAVz7VvUD/WJl1h5N1bk85E0?=
 =?us-ascii?Q?b2a1+qGaJyvRtgL64/OEWihOTY41wYaOuOWa6dsMCRbQb494VwJgE43rCaa3?=
 =?us-ascii?Q?13sTRpSgfp+QfQY1zeGjVp1xR0HOIQzwydvQlS8+ZC45pD/MlcGH9ZaKXVsm?=
 =?us-ascii?Q?oOYG4DwTYeS6a2zUPubsyZoA/Z7wNzNTka83xqvbaro3ekchaE7nXfVucJqu?=
 =?us-ascii?Q?JXJa8V05jkRfOXlnSpf6OL9xnFlB8cEnqzaZiAHSyV+GO3noyu4A1W0HpM4S?=
 =?us-ascii?Q?4IkhDgEf4jh7Y/UlWM/nPDzj9EPP4/ZvWiOotd3Q60xo72nHPL2w3HQkD7Sx?=
 =?us-ascii?Q?jCSb0XfSc1OsZcbzaLCS9mR8bl2Jzw6Oo2Urt7W8iKtBB/0tvCA4DYsQwXw8?=
 =?us-ascii?Q?WubrUHSuGXpuLOVuIN6V2YdztDMkGS+h5MbMbxFkcf5ZnfRN+iL5GfqL2kmN?=
 =?us-ascii?Q?f/SR7ptQNE7JcmjBkwZNmRr96mNHrDj5PqZ5kJpO7qnEMiLX9k+F7DYPTQiG?=
 =?us-ascii?Q?+aEdxfw2sZwdXq2CFOoa+UCi+BsSJ/x3f8KvAM0lNJWgdT3yDoA9oTl253mb?=
 =?us-ascii?Q?jDgp8w7/Ac37DPWGhvJh07Tw81oHaayrIZ1Oh1iRd31CEKCEkaxL8ozvjN8g?=
 =?us-ascii?Q?3w7xzlRBupbrhNdtbogDAbXZmjYIB60Q2K3UERNywVBmX2uhTLD1r4SGuNlY?=
 =?us-ascii?Q?G4MithNzHDBPh7FJaily10+mCQggTPqLNNDkysqdO6/BeElsNWZw53eOwqJV?=
 =?us-ascii?Q?9SoDaZwds2jq3YW4/1VaRbU3/yC6SbczDxEDcnYXqSjy1+BDp5F1c9YHV0M3?=
 =?us-ascii?Q?0I1lYd4zjPtBqOA/6vkDgFkTCT2MQzK3sXwXDA0xFpET7H4d4dzjx6xPhjrd?=
 =?us-ascii?Q?o6pZ+cM0/4yV/KIiVeriinyleVI8RaS/cCqb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 09:12:00.4006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b344d69-ee19-4ebf-657f-08dda27eb2bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998
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

For the evict fail case, the evict error should be returned.

v2: Consider ENOENT case.

v3: Abort directly when the eviction failed for some reason (except for -ENOENT)
 and not wait for the move to finish

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/ttm/ttm_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 7e5a60c55813..bb84528276cd 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -558,6 +558,9 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
 		cond_resched();
 	} while (!ret);
 
+	if (ret && ret != -ENOENT)
+		return ret;
+
 	spin_lock(&man->move_lock);
 	fence = dma_fence_get(man->move);
 	spin_unlock(&man->move_lock);
-- 
2.34.1

