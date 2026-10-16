Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAA7CCA462
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 13:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 389F9112825;
	Fri, 16 Oct 2026 13:16:32 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010001.outbound.protection.outlook.com
 [40.93.198.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B4610E30C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 13:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZBlhpo3O99M2ry58OQW+w0fuDNwWuL0k+IeTqCm1FW3ONHcc5V4DYedFAwzDIcFkTLjYEd85Tm05cD8V6Xy0nLKWNq310Ve4dRqHca2ufnl+3Giob+tFnr5jG/G6f52qrEGZANtSGbkrTJ8L2TjwbN+VyhC7/ZwlNgGeTcsubhUJYwsmBNFrjv0TJADlGu3qfvbTiLgtR02qsXOHMOO6lqt/E/HlvwoX85+fLOXzxH6FC02WQVS2NayYqixr/wIGHldEOwp/nuAxTVc1O9IJSJDVHjKO6G7H+GS5zC2ZEKE8uG5m1FmtrjgWXNj0BEZjsuOLnV01cWZkkYyp4p6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh6mY1fYDPqzphHXbA9VNDY+Yd3GsgXXadvaKdgSNEs=;
 b=vu6ciK/ttbvXBefAoHkKnG4JvGf/0I/rwwwapQrH6GAFfidjF9cNSwq9/k9ECGgDYDu8PJEa2MeSUyrqHzyvD1r5hkb30E3MyqKEftkGkL44eGx8RLOxiIzg1WQINJ131HYPScO+3kvaIDlzIGJL6ECgD04P1Cjcutg7/zUAKnNF6Z7CDN+8sxtdAJCcC9+rmG77qF+3x0B/PmlpI/quIEy1toR/pkma8f5pgh6JPz+OGPB6ykEWjmh3uVbLfvEJI6iMFWRspqlRQrnsJgmcTS1B+OYKkLX/bDQGLAGo3lRJl6iD/vPW3skMbN80FhTroaird6rn3gKTrd53sPO2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh6mY1fYDPqzphHXbA9VNDY+Yd3GsgXXadvaKdgSNEs=;
 b=40YpMVHAz9tZCjbg4S5Pq4SgrYGXfGu+30caxkXfGH37qV9M3j6Lx0nmwdXqgyz9TSJQ+tTYqWn4HbMYSZ7n2KmkurEVbW5zDLr0/5LaP2f74oAchXdBdxyOiTbJV9SyLE2EZCHr8thtuKIVsxvQuFDjTUEFDI+WSXzXaKcKV8I=
Received: from PH7PR02CA0021.namprd02.prod.outlook.com (2603:10b6:510:33d::26)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 13:16:16 +0000
Received: from PH7PEPF00000008.namprd04.prod.outlook.com
 (2603:10b6:510:33d:cafe::31) by PH7PR02CA0021.outlook.office365.com
 (2603:10b6:510:33d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 13:16:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF00000008.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 13:16:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 08:16:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 08:16:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Jakub=20Oko=C5=84ski?=
 <jakub@okonski.org>
Subject: [PATCH 2/2] drm/amdgpu: allow dispatch tunneling on GFX12.1
Date: Fri, 16 Oct 2026 09:16:04 -0400
Message-ID: <20261016131604.2198664-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016131604.2198664-1-alexander.deucher@amd.com>
References: <20261016131604.2198664-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF00000008:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb405e7-0b08-4ff4-95fd-08df2b87a8d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ioBQsQ2LetjyOLCy6Wd4c9KfkY3PTlTHLSNGT22hvLkxHmImRxwCb48NyIVphf+BuHLLYk4Fu7tXdyvRTjmOFpBO+Dq9C73Shs917OmkU0uaUupsxt/yaQv/MjNmhYWsWsfJapsxAKTIIrtfYT8bNojXCS861hA0PTXreIDWJDENEm+QA9NSSS7SUcMniO0nVTe2SSOkCrEv7L6euFRGBxwmb+h8k04ek6jJHkf148f2DQukzu+MGoQ1Tmh51VlnoY6v1qXzjTaXqemzs9C//DDhFZ95UkTeK02O3uVHuhXrFEPK1uGbAb9rOBCj4jI6LKZaQKF+Wz+GBeSqkTAyWN35+lbEim1ufUE2TQrTF4Rqu8q13kH9hAJE6vdZhWHRaIGx6k9v691vRtzFmdGmImjdksXauovQ1XIJmDzsHBXFwX2x94x1N0J2jk/n1CuQHK+5dRPfzvv0C3JLVwicdl9scfOWMH7dqV+bcEQB89Px9xuBqlBaifaWMv/hPHXjlOsee1P6sBdvGzq+BlzsGJkWBS/aFUAirgRfbLN6o33VD6Wy6vVPXLzcLVZZtwOd/9n7DvAw13IZAuqsKKvV0TBkEbVsU6kACBlE6ZoeoD7xXM1cgmi+VU7opHQq//ZR+QZ8nulIXb5gnm03vDShsDFQB/2nzhDzDCPQdTgYP6ffC3YsxG6bpbcmW07SAZf4ER6aNBVUF/4gJg0HnteZ1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jDFDfcJXNz4qXTiCciUl2hRosdvY9GQc+0KmGmyZPOH5lwhiwwS137Q49a1UXPDLMMFhESOLSntKnISngmrR5z0/vw9YKga11+E4Eq6qqlPFynxcF1wNdg4BSmP9rDU3XeRVbEaGEasJ6Ux2exkcbJDZM3oknJZKZ1/RmLFEY3LNM7UNxTv17P6nNtnAe9gEd7dykj+f73uUh1248O45KVkjiPQzdcqOi8LAVhWsZT7pctctw03gIS3Qagk+P2LQAz8zPtQHwmYhUTmkmCQyzL8AcCXrArSgEgscEwARRAzaI5x2gUbQP/PSB/TIKk2Pxu7/dsopG/PEXK+5/0xY1tW8ApIWoXfsfCBD8oSxkyaX3JDhkkvU30f/kIH7iZdwJY4EDaYnc8c/bth56oPlhn0LRm6Xpyu4D6snancjXiQSxmgzd2f5oRAgZ1+zBUhu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 13:16:16.1857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb405e7-0b08-4ff4-95fd-08df2b87a8d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000008.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457
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

Was implemented for older gfx generations, but got missed
on gfx12.1.

Suggested-by: Jakub Okoński <jakub@okonski.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 147bed75261c1..aaa25f39b6678 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2304,7 +2304,8 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, SCOPE, 3);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
+			    prop->allow_tunneling);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
 	mqd->cp_hqd_pq_control = tmp;
-- 
2.56.0

