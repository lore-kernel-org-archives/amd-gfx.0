Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F105C25B78
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 20:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD6A310E942;
	Mon, 13 May 2024 20:25:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1rM/+HBx";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2474410E153
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 20:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdpw9ickd0cCNpezXUHTO9w3pRQKUvNWm6khwdI1YmafzHsCmu09r+EM8JznT4CTxD20BikzwW/NrNChYZswgcvM0kAIZNi3N8yiE7XrcjLtOpEVakKXhJ/I0fuxZ098pEBHZETTGs8+rKAt8ZcCr4bQmsgnAXk/B17zBZxKsy6uE02rERukMMOA7pF6S4Cp5KTG84GumakuDTzp2v/BrYFOic2qok8einBag+dW9IvGmRn8gudxLUmDI7YrXeTBW9c44xKCcN1k8pq84U4Kw/mvYh3nZD5tG0pgUWciwYuHBarwnPuZVe74F+15E7KKMXnswEyWCqW2KjRKBB+uoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mHdwumDYJ48BmnULKWsTVmSRG7WeDpQWgT738yjAuE=;
 b=I4VPpSnSWrPaGjkZMJbZ6MnngyZYadWASm2GMnqh1iwlJs9p/kqpaKEKQ259Pv6cAymc7rpQ+RPEhK+Vv9zbJw6INLbc6WJ50tU9B+5DHPM6lu2cWJQYOX7KO6GdqEIgYDuU3y87YvExp2YqUuqNyJU0vWaODYBtrtQucchLeUaAWQvXyQW3IjlzdIpMyc5MaCCeowJPqYk5RsgLRwlQSKr7czzn89/LY9MLxr1vwjuTRVUWU3S598RRXcCHOcOHlVzP0BV8ddXa+dbV4jrsp6LTYUUc8x7irnD/MkUmueJOmjumTLd1LwbkRZlfX92Mqa7hMU7WjDVxIth55JTHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mHdwumDYJ48BmnULKWsTVmSRG7WeDpQWgT738yjAuE=;
 b=1rM/+HBx7br8k/lrv87rYTlzhyUHXys2qK4+mW9YHBEUcS+MhbuYmwO0waJgNdtpqtTDj/GQAQRkjKjPFc4qCRe3qT+VD7o2GzHGnTPZDQKpcAy/tDVgVqXC5RB4mlbWiEAqteMudPl7Sojh08+KxWcHtXJ+GAtb066YqOgN5+Q=
Received: from PH0PR07CA0028.namprd07.prod.outlook.com (2603:10b6:510:5::33)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 20:25:34 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::8e) by PH0PR07CA0028.outlook.office365.com
 (2603:10b6:510:5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 20:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 20:25:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 15:25:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/gfx11: select HDP ref/mask according to gfx
 ring pipe
Date: Mon, 13 May 2024 16:25:12 -0400
Message-ID: <20240513202514.141828-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: d07e86a1-ebc5-4021-6731-08dc738ad74a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WZDhYTZ8HLsVWpOnGNhhK10wIvydMmaxWLfnaQ/oRJJILYvnG+s3v55TZ/MW?=
 =?us-ascii?Q?LE3GnZHqUQAYU+bPeZVKZwZ/Sc0DwzHW03EL93l5TxK/6m0xGQCBt50rHxwO?=
 =?us-ascii?Q?A1ViQ+pu9sUOYkNslfPIcgA0He3trP2P5LGr7fshJiW4Kc6JNoTDj1gc8G7j?=
 =?us-ascii?Q?SsgHkg9tlf7hX+Xfi+kdw/v41SLozCcezcJ9k74DHtQg8IffOCNn2sGgLX4f?=
 =?us-ascii?Q?371Ac4SMSOi4KJaAEM5lZWUH5bUlTfJDwuiq1AK8iQ7xRvm7VWwoWvXyYbOR?=
 =?us-ascii?Q?LIPIIDzm2aM8J9YcN2A+0qHBytl/MRV9En9wvEan5igKuUUPUhK+oxLVgCQO?=
 =?us-ascii?Q?kfjlni9YA3ZirjncE5+yRbmqYmcBME615UxqkggsIihfYAkPBX/UtwMK+xTv?=
 =?us-ascii?Q?lIa0bIq48WgGD64/T8Ogb2FKwcuO591RvTTO6SZteAgj8I6D8YHyzJWWFTEe?=
 =?us-ascii?Q?xH4q/t27jpqyVMORTeDUJxoLXv9jApVwCqNsSrxxHIVoK8vIvz5DwZA/veAm?=
 =?us-ascii?Q?5KibyvWqaYdPhEe3IhNbDrUW+Zz8FF/hdJ/vBTy4MCOjqWZ8ClTzFKvz4UDQ?=
 =?us-ascii?Q?fuG96OnJMjtsDOJZI/U4d3V94sS/ho7SU9yUpkqaxavhhix0cAWCZAN05dlU?=
 =?us-ascii?Q?YvhrLx1k/J14OUEggmvezot0HdomHl9nXcai4bUDRO9JunNDxZrehNSb13zc?=
 =?us-ascii?Q?4dKTUugcXU/GKQj0rFuPPlXrn1D4EXUbzYhjHmmKGosNoRxLg5Q9vzyoHRD6?=
 =?us-ascii?Q?gHGNsVEVmHNPujaWXjciLWorLvDL+b6dSNHlmpbx/elDbRlzNuV1LmbnVBSP?=
 =?us-ascii?Q?ODOttRC6f9YZrJFk7s8GZNLoul2YoGRxVsfttX6qpuUVb344jsb1vbPa1IEl?=
 =?us-ascii?Q?m0NfDte+SVOSJmun52dTgmfNVgo/X2Flu34DWJcFQbqWb3AafdR2FENHDbNY?=
 =?us-ascii?Q?Hb64FCKOAHMetp+vlws967jJvRckbSue1l6SEEhKn61oDIVPq+zUKdmqNx2W?=
 =?us-ascii?Q?fM4yEBvuAU1W2+KdPeYMCSmPxQbnEmnJZ/bGlUDkDq9g3pivorLiRiefnNAY?=
 =?us-ascii?Q?XI8hjwivA8319l80oQY0QTfYICa+YhYXCLoOBITrKILIRngDsjuV22OZDNZX?=
 =?us-ascii?Q?07raKSyDi0TDzUn61dTjVxmpB3TS70J9CS09cwHq62q0tHiD/6zRsmosW8OR?=
 =?us-ascii?Q?tYxE54gm9Hx20678KwNqJkFMJHR1rRSWkMaMVvfCb3J2O9MJX2S93F1YyNgR?=
 =?us-ascii?Q?leNfgQbpzSRGyf2WCCIGP4ARyjRVskN4duqbstuxErGdUbMGB+KThA1U+lAR?=
 =?us-ascii?Q?VWiWvymhQ91TGfJ/xqAkXMDehZGfJqXOzyykART+/z1jC4tp4nH/hwiFL/dk?=
 =?us-ascii?Q?Oge4U1rq6TT9FkDyl1dT62oq9nAX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 20:25:33.3020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d07e86a1-ebc5-4021-6731-08dc738ad74a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998
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

Use correct ref/mask for differnent gfx ring pipe. Ported from
ZhenGuo's patch for gfx10.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index c87943f6c4436..c8c055ef2f3c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5294,7 +5294,7 @@ static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 		}
 		reg_mem_engine = 0;
 	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
+		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
 		reg_mem_engine = 1; /* pfp */
 	}
 
-- 
2.45.0

