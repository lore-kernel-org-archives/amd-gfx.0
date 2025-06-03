Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1519BC5AE59
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 09:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF2710E2B1;
	Tue,  3 Jun 2025 09:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I2JTYK8J";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3657310E2B1
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 09:10:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxKfP3Yti1dKRBgxbTkspe5iIuM93mXrrDc+8zspmVsOAbRrUg5p0OH//blfcB0fZTL3FOBymsi64OeAWIPJLN5Vqnw6R+AB3vwQvDpPC9GsbnousaxslzeNv2BdlVghWVtKbb8eFjnMsNkNxd/NMVf6mvj90Fb2PQlJiTcnxRUrFmqkpU/nUi2oqI7IKG/4RGpC2JBBN6l+A/3PNDTamD6fnXFQFr9/uIs8dPJe3Mkp/tpWS6HARPV6W0o0Q3+cXUcT8qe7OHY6GEuS1uSrsK+AG4qtGOlYgUA8IAy057ikDIC0++Si/thg0eLm3woXeayMxk6jPgO41C20YVxfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1Tl5BSo+QH47BcyW7zEG3t292yAn1J7Yu9aNvQkV+U=;
 b=HHT4PWhE5C6O8MxxzIqdF7WtPvVN0Dctp9k/MqgNuJiAwNyJedOyWQgSeiPGQkqKA2BeA8Bv5sCjg68bor+pGs7tWl/0Ozt5MFBSIAyl8cb96nvjcZQNwOmTU1cPH+7/EYvO0GyEHido9YX8xVulskdVBgMp2dVYL3G8O7IlIboY6Qv/j89REQRyqL27/WbLSzBMt4YfDy+6g+lmKAT4xfd+lv4A9gRgY0GXIgo7r+LcZ3XdSXfJa5PjfRpw6vipg7PyqvJYWcugD+KgSq7pXD6R2L7QFc40vhvWEasQWYyIF4sEv9fvUTIUdFjVhICWGyA0RniHwin2war0t5pBRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1Tl5BSo+QH47BcyW7zEG3t292yAn1J7Yu9aNvQkV+U=;
 b=I2JTYK8JjEKiyoh0R1ctswlWUzK6SProRvtSV3BSWpzVShjZKRfclg74gqwaURU+T5qNZ4pt2U7EZMEcGPU1Jzf1bPMAzYmVBfgxrkf4ZjxWqS+iR9t62ui9HuGhFHQ10ut37CudihMOZGI2EotFBlPd2YjxPxlt/5blVQFZ0h4=
Received: from CH0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:610:11a::35)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 09:09:47 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::7a) by CH0PR03CA0344.outlook.office365.com
 (2603:10b6:610:11a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Tue,
 3 Jun 2025 09:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 09:09:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 04:09:46 -0500
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Jun 2025 04:09:45 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v3] drm/ttm: Should to return the evict error
Date: Tue, 3 Jun 2025 17:09:43 +0800
Message-ID: <20250603090943.3468608-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 7733336c-388a-48c3-cf30-08dda27e6364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TjmY1T1FmOjZmASxkWkdISQVMd1aXad3qyYVB5St3huPaMKs4SeAPj9GoxP/?=
 =?us-ascii?Q?Ta0gK3lB4HZbAEL9Eh61xf97Kdaum0Y41S/JTceXYRS6Eh/ZNvgQFM9ehF5X?=
 =?us-ascii?Q?Jzy/Ul5bN9YTWmeQgcQt5PGFp9K+uO5phcRaxbo6NsoR5kaYalRqXhZv1bET?=
 =?us-ascii?Q?yniZPlNcDFhGv/q2PNdycf8qWrycVq6y7kdDapnNpGOktEHoFiKLhQqoh5SO?=
 =?us-ascii?Q?zhC2j1nih5w9FAAWfdZNbM5qEW4Dg4GgVuVSe25XcpIUMfkPKsoaL6nEo4D2?=
 =?us-ascii?Q?0o/CugqOO/T7h9vNqigU7kX9rWZp/3yMn8zHRCsZ5B4d0rsANPq9YvBjoX26?=
 =?us-ascii?Q?sM5uJhj9KvlUL+LrbM2lLn4Oeb7EHaZwViVO00WZbXQxCPazrU6rrBKDHyGP?=
 =?us-ascii?Q?w+l+SL/V2LvkDoTv3aNQsmuZ+Q6+u+/Jfc+/Zgu0II279Cy+yuR0w0qwsfZg?=
 =?us-ascii?Q?3bNAuDPEyRdnPi2vaarZiR2oPoCdqaJHtY4xdOl34y6jnri5FDGBTXPQm/aq?=
 =?us-ascii?Q?JkuIKFzolSG5B5xpN5TZ0fSRYkHTABriC0AFs/dWrqHJI/rL0A7ObOrKZ0iz?=
 =?us-ascii?Q?bjsXYSuJx2IVL4pZUogmSQc9xvWIOW/CRQmXt0UlVP+CX54e8D1gbCTJq8QO?=
 =?us-ascii?Q?pIVOgO0CqW7M/R+U6k0nYITvGOMTIIUonli636Omgw9VJnndce+KHK3jKrsk?=
 =?us-ascii?Q?BeatSZM0/BCpMFiaaSxdF4riYuIZoGggU2YHGmLCTgVd5Ew31Q9VgzzfQjSX?=
 =?us-ascii?Q?O/iA8zILRktvn+8dKjszOLJd+MDVtORcU6iCha0DzLWPT1rft5XEeRJ1tx8e?=
 =?us-ascii?Q?EqP6dEaRqWiB0UCGfvfqiBJSiFuYyY8wd5fwzYyXvY5y61NaLQmjPP/f06JG?=
 =?us-ascii?Q?LCg9tI22WPFu/I0NBOaUixPgGMFcaGPHSxNXVr3e4er71w8fNSHHnwrjfFCo?=
 =?us-ascii?Q?81DxLTNtuZ7Gae7ZG5PQV3imfYy2twoNSRgDMWdsgOjOSfOt2ftqgJ1GQZe3?=
 =?us-ascii?Q?T2abcWdANLbPkvlvnK1NCvU/eCnJ6OgHyXhWdUBYe3It6BykAJMYBZcFktQ9?=
 =?us-ascii?Q?WaFjGIpjrwcABigBg30fl1HE88HJ98Wl+y7RBNxudF+ZMKpxzRt772lB6JIJ?=
 =?us-ascii?Q?Xi7qq0yoIa51yhcYQweVDO7YRi7i9hyWUxLqGmo3ixjnK0JXC3TlqZA2M7Jb?=
 =?us-ascii?Q?giKaoe5e5vCHL7nWEp5BBQzfQysfzfp7cL07WpO2d4t/HZEY6C8rKuChjS2d?=
 =?us-ascii?Q?Ga3Es5Sltdrsqy2tMO7B5rP7i4VjZfBU3mNPw99xbpST88ezicr/a3DUX5Ja?=
 =?us-ascii?Q?oaPo331CAG0DMBmhcsK6GRzQr43JJNri4C0BRpeNezErpEjTg3vnV8E8PhZt?=
 =?us-ascii?Q?wHU0RqVL2B6HM8cJzZs6RQu3ZP7d0gmuaYUe9vMnB5TH2RNmV/ADFzm+/Gd6?=
 =?us-ascii?Q?cpBJt9TY5uRHyokeMBEu/U3YotQrr5Koq/F2bOCtPZDEx2OXWpQaQgmpYztF?=
 =?us-ascii?Q?1nHi7xdXuWuRqk+MZzUd+5+KY+ZZ/91GPVww?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 09:09:47.3060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7733336c-388a-48c3-cf30-08dda27e6364
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
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
index 7e5a60c55813..a9fa903b8e39 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -558,6 +558,9 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
 		cond_resched();
 	} while (!ret);
 
+	if (ret != -ENOENT)
+		return ret;
+
 	spin_lock(&man->move_lock);
 	fence = dma_fence_get(man->move);
 	spin_unlock(&man->move_lock);
-- 
2.34.1

