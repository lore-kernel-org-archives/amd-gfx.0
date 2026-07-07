Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B00C43602
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F5310EE1D;
	Tue,  7 Jul 2026 15:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SxyaipSC";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AAB610EE16
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUl4nbqRe35Fjglj/0AYTPSXnGX8A9AvW+q3msf7qh1V8O8q9gEngvozxpnfIFKss5+aEdBN/SUhiAjXTGAfocBwn8Z4nPYui2xeHpf8kphSgtmO+qdVM5uHRCdeW1dT929/aDMHoDLRps5NR466REx5m1WMrO0ZUAeHt9CrehUudnXKxxAkpcHgNn2nJJ2wzqNX2k6EV6/U6DReM8pHrjmUD7Prat20sGtL6fZg7/nTbJ918gzzCKQp3J6xGMzKX6tQeIrdiOUH5O1JUB9P6snTXdSZWq1fSvs9Y6viGXpjQW4Cd9YoWrZA4gpOGZ75cA4EMFSBxlljgyCmrWiuxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHqbeLu0jyIBt8wMVbuEvbuMFKTNko1POmJt14tKlZQ=;
 b=wNcWc4YBWMyXZ2qjyNL7EkzB9fcUWNzWe1cejPLQzKemJS6YrFWgLSY/R2JDSQFX+tYQ2adicBbBl04BIewEXRVS63m1gJuUVQyFR5qHwfo+UgK+xk3V4zrdJQwefNW/5Mn9ipW9OQLxeiZLlxst91ulSI/KbJDF7TjCpDat3URFUzNUbsFjJsDcKfhmPJMtIddDWZk3vZ3ZR+xhJS6peTqdjIncmVNDol+PlgofGeV+bb8FvOLCJCeHM8YwapuMDeQ7AQAyVZD/dFJRgllQR9QHbWoqFaM60turjXhvYm120KgdcvALPe4b0cvGAnRIT7AVPOdgwfXY4vm+8dct1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHqbeLu0jyIBt8wMVbuEvbuMFKTNko1POmJt14tKlZQ=;
 b=SxyaipSCvvODFuBJQ4lbBFUrd5X/NnCyWEvmimtTpRmNFtXU4oJfyuHYsJn/J2S+pIcThWJPCBZ3zo2pcnMo+YU6T8OUgINcdJ8gO0EM40+fWDgHweTxsscrS/3oMy+8m9AljfIGvjZ7fOwYqrrMq9EE6m+qoYNGFtEkjL4/0Ag=
Received: from BN8PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:d4::34)
 by SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:42:36 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::1d) by BN8PR04CA0060.outlook.office365.com
 (2603:10b6:408:d4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:27 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 08:42:27 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/30] drm/amdgpu/psp13.0.4: replace BUG() with an error
Date: Tue, 7 Jul 2026 11:41:53 -0400
Message-ID: <20260707154203.2603209-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SA3PR12MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c57667-7543-4e55-9135-08dedc3e5e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: +OxX5kJKj5QNbR2QQnUKrtzY8WQHqKR8J4YS8ZHhn8w2Skvd86trUyRguNDzBjqiImgaWysQXV5WdshIHviSglwUBYNx32NeC9t6KfukZ6koJTdIoKDDUYjRqGDIPjbrSQU6Ey4I9XbRZROEITbpYfCqSqUpyhB4EOFKCnXyhoW5PzII7+mT+H4CJL4N2ATdVzoD06P38uFWSxB/1o1f/ck25AKHdG9Vw0xacjtflS/7yZ/e+mDvZ7NMk/Q4QAWTbTRkR6j0GfysqzSzwHTXXQXs+ls4t8XAZPNRppqFsigifZBJY0wkyODd07Lcudy2hWsFYaqeXSgmhtk7eA3/YkZPpQXWSa1aXIF9HLHnnEq3dJbNwdBpN26+on0W1x5s6QCNSdJPm/O0qxLGuhH5xAvtDCdmqtCGyI4J08zdWx7JZSIYIJJepR0wb8Q7SwgSIwJOEsUX8y2XY1wy6PFwISG9t4StdKqe+e0ucECTr4LqQH3HAPQhqJObdFppYbe6o12rTEJ/b+9U1XtDtv0ocR//DTsX1/C0t3zh/rtyB25KZ7CZivicYsij/b5UUh+3pBnTMRojYXEvYcgPQjjtjvQ2GfwGqkMmmih/madgbnoGEylzA9SHJvfan6Ms5G5nSdjuPIA2Ut//WQkVzlniiiRVFkwM5BDqEX3WZ6EevfTSpmhiQ6cX1uZXvM5np+LzeshbzHu0PAH28SkDR2jjtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qmESGIHKE/duFb5QAMz4tyZA1MHK/PixvXviNMCj4/hBw95dhBJuWSzWpe1iWWC5peIXYbR2ivbMtok+r95jOt0v5JWEbxmXtX/eeNIlbnuUYOQy7FwhylVf1/s77Iy4rh42G2lShzKU/ixmB+0EJi4zECnxcgfX+K2U2XmawOkdCc/tL1aKJ1YDobtuexQti8KXl/KZ8WwkLev2x/LiNIDkcHDYvLgYn8In655WPaB/p7YP04ieXz03Wd6a2oaEGAtJ657bsWszm6XgalC+K1WPvcgTgbsihMWVNvTRbMAFidonG16BjKPUZKFNCUGwXkUc/os3tVc2jSTn8MUawsUi4ljUG/ino47JiSq5qXyYzGp8U4SkWmL+BalJ9/uIUsc3/uuIEEWvGr9BBbVwXk6wOBtmrtx54CzUpzrQePto5QM1b4G63H6V+ONLx02f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:36.1434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c57667-7543-4e55-9135-08dedc3e5e54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022
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

There's no need to crash the kernel for this case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
index 3d5e26b3fa00a..caaeeef27544c 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
@@ -50,7 +50,7 @@ static int psp_v13_0_4_init_microcode(struct psp_context *psp)
 			return err;
 		break;
 	default:
-		BUG();
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.55.0

