Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDA6CD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 16:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B1410E1BD;
	Tue, 26 May 2026 16:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mcnhuSa7";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013065.outbound.protection.outlook.com
 [40.93.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA44410E1BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 16:32:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUZU2Yj2A3sRgAtfX1Z3IMlfJIpAoeT8xAtgHf0m7WyJdbDm/hVgOy0VGImZE47gHYOzqOHwyD9CBkhMoQdSL48jDEWJ0Xdc87ZJY7wrEXJlUGUNOTfFaQplmRX7cvF1zD51qroTGe9D93sia7JyxoWnxkJnemkpHY9Yq7nLt4NsSl2GLin+rxumxr7qErdOvjm55094Sgwy/km1G7nYtKoCxabvygDDC1pfsgvqssbAbpzbJET8fk9HCVq/t3du7n08Ds8sVHslrg9pvkC5f77P9dlaA9CdSmK7+mmXjMFQfyQ2yoeA40RHKaioQSQfPO02vnfvwFScaaXNjkrMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwUHyzQQ8hA8XPMYgjcaN58hSoRYxF73MkhJbpGJ4zk=;
 b=Qz2aYG+pMzR3g/civ9augHJYVZjj2lGDolmyEZITTEANk8mTeO3q5Pr5z4aOGgJ0ZrG/OBUycZ05qG71KhIGt5Nf9AbL7ps+8L5GjglS1gIQFnPVtJbWrSBNfqD1IM+b5N21snTRyZHTWkjR9wWv30GihRSNGS4k3ZhjX3y3JiKB3dYsANcRvyC0L1JseiUod4VC4URTVG2VJTdBrVToci+oJXqoOprUZ30WBGV4Wg/NGzt2NQwqiDMDw6NH5uwbIe8KM6ZGYoGum8JL5fX0BxoYhWU386cDIYNk21X1h9gokOd7KWWKS2VKkR/q2Zr6ptyoaC9szfl5wZnfGYmQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwUHyzQQ8hA8XPMYgjcaN58hSoRYxF73MkhJbpGJ4zk=;
 b=mcnhuSa7vZJ8joK/MGCURnl1kCS8xbxqe+JrJ8wR4FQKKQJmCPuYMbZZ6Rr7q8TqrRvAeCSOXwUYd7dH0R5Dt+nSZg1azlhwtPvuqIKUIKG4MCIUIqKyYJbk4QsQOEkr1ibvH0TIEpty3I7HCxocJGA9s400TciAIraj3b6fAH8=
Received: from BL1PR13CA0087.namprd13.prod.outlook.com (2603:10b6:208:2b8::32)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 16:32:28 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::1d) by BL1PR13CA0087.outlook.office365.com
 (2603:10b6:208:2b8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 16:32:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 16:32:27 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 26 May 2026 11:32:26 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, Boyuan Zhang
 <boyuan.zhang@amd.com>
Subject: [PATCH] drm/amdgpu/vce: fix integer overflow in image size
Date: Tue, 26 May 2026 12:32:14 -0400
Message-ID: <20260526163215.807373-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: d32c492f-ffb5-4ea9-436a-08debb445fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: lYbNdR67zERo1sfF1L0gwZZ34Qd3xTRydAg+huRFRjHlfcYQyQVNR2MMzkb0M0jV2sXwfyG/SHnPlYQNojhipghW1DBE1z9N8rl2ZlMdIDwYAnh3uS8BLMl5VRVtLK4Wswudw5CfX+ytim0JHu0myUR4twRw9f/RCw79BdsCOH8hLQJW6yrezvBEt0G7d1LoD/1kcoM2d4zKgUBUdzoq2Gm/EiW1959xMsHIA4L3lB6UACX7PQ+UUuZBBzLaDL2S0wMxqaQ2XH2thx2Y1L9E9zvQuLfYNIbgeYIrLyGK9OVBWKZwR94/gkfyjZ0xxT5L2DEadkPIxHKIRa6AI/IKomxkDQ+83WTbjtfydAFXPVOojlQT/MdzGaBxOVi1vdM/wGww1RULu1LBPIH270Ilz1ux8b+o/mMr6OI3gaFAfvXuU/plYUVw5fKU0MT8dh0tK2/lrACOHGhQhKo48sjmOQUevJ4SNVZsxS0Ouypj9jW1JeI6JnBJCr3+VRajNvW4ZJuaf4EhpPMtE0mW8JQE3XJzcAGkbiOu5uIXztTge/0GdxzBd4nN3jMCV1ZkFHQyRpy7cHPt5Yuw/Mn0jM+CcDRMqH1JOt3ypAvQyvgIP4ic3pgUeCxKTfLORdfbUM1a7BIz4u45X0VzX32Ntw96D3qzmqfn6MfR3H0EzsqFweX7D80HqsmAgXiZLXYbTbcH14mK2MecX5iydWKg/CRpcyNi5ns67FkOKOA94Cb0cqU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vn0a2bHGcfc0BpqeO1uxMZ7nc+FdZkH8PTHu12+rv8Xl9bP3PBq0GNIF7hYxFC/1VCy1yJ7HXk+X4BTvz3cREwEgR0AxvpQvyw2JmSwmCi0Dwwxubwy2640yisuQ/FJ69tbOp8y+91tysGSe5Xdtcraih57zuaddPj/aegI3/7dRuNIYqtf3ig9CsHGiXFki6wzvxtyC36qdhGiGykkPDwO9s24LPiFTHXAsv+W2Xe8FUMvbAW16GFH+ZAYN9uPLtCFPcH7u5HJNCTXReZu7zUtePBBuSB5A8Dc9iHTP1BPSClO9rTdrzussjrzQPeKCeE1ljDB6mxy3IzCwa8NzahTP9mB0HqBmpgrmMY+2/oWPguNLwmCUQ+hXn8K4hN49J4NZOrRNcBsgZivAbfW3Ie6kAvdGajFfdjgDM44Ggs3aisqnJkSsc7xOy9gLbhnd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 16:32:27.0117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d32c492f-ffb5-4ea9-436a-08debb445fad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Fix a security vulnerability where malicious VCE command streams
with oversized dimensions (e.g. 65536×65536) cause 32-bit integer
overflow, wrapping the calculated buffer size to 0. This bypasses
validation and allows GPU firmware to perform out-of-bound memory
access.

The fix uses 64-bit arithmetic to detect overflow and rejects
invalid dimensions before they reach the hardware.
V2: remove redundant check
V3: modify max height value

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index efdebd9c0a1f..bf7184dc7c7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -877,9 +877,21 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 				goto out;
 			}
 
-			*size = amdgpu_ib_get_value(ib, idx + 8) *
-				amdgpu_ib_get_value(ib, idx + 10) *
-				8 * 3 / 2;
+			uint32_t width = amdgpu_ib_get_value(ib, idx + 8);
+			uint32_t height = amdgpu_ib_get_value(ib, idx + 10);
+			uint64_t size64;
+
+			if (width == 0 || height == 0 ||
+			    width > 4096 || height > 2304) {
+				DRM_ERROR("invalid VCE image size: %ux%u\n",
+					  width, height);
+				r = -EINVAL;
+				goto out;
+			}
+
+			size64 = (uint64_t)width * (uint64_t)height * 12ULL;
+			*size = (uint32_t)size64;
+
 			break;
 
 		case 0x04000001: /* config extension */
-- 
2.43.0

