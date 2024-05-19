Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D4DC25B78
	for <amd-gfx@archiver.kernel.org>; Sun, 19 May 2024 14:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF81C10E21E;
	Sun, 19 May 2024 14:52:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R/TPpKkA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9346310E21E
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 May 2024 14:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DM5EWL57j4r/Wc0+ulZBbNF/fiOHsPG2mzSt162OewdQZhIVgmEyzjWfODvy15JCODWkIZtvetVbNeeMjKeu0Xgtw76fSlcFJEx5yFWBEn+ptf+zYI4ypAhNwkevBZ0aZjY/iq+h2Vq3dToKUAh7oIvNr8uVCkk2mci0Wm2f/w45ZnY+vmONu2p3pF4+nRffI0QXu0zQbDxH8kV7CcV7FdenD6Rc2UxUX8jk6gYCBqg8JGxzb1u5KI3/6G/YTNNdLKgxrugKvvjbB7v0OKHrh4zsti7f2k+2XNwfXVOXk81YjCjeFesF3M+V3DxFlJOaG0q9cjjXsi7XmIR49qttDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkptOT1UEeSb52WEOZM3RQFT44SRwiIeymBxU4MElgk=;
 b=TNYm9r4rBFEP+hL+545SYCmPTGwayi0qa5DS+8RD4K7pmZ24dQ6OtCriXT2Pmn6RofisAS8TMheStRm68wDuMVJz3M3LtyWeLqPhyD/LM4GQ0hOA9xaUaQX82201ep4brhNy1aq+o3dO56uPYQu2PNtjyVwccsVSnT04GZeGoLG9CdNzGuCE6vd6BVpBKCkRI8zp71VTv9ruh4hAl9p7IgsqfSY0HU0cPr1klY9r12mlbSggnYXa7FowV7cycIy/S1O8xakKPkcwzEAmBs0wrkn/KKWgbyGz9vOyR7uV/LAJT0lXSI2njIL7p7JxWimkc/Y4E5qjxereMM3gQEm9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkptOT1UEeSb52WEOZM3RQFT44SRwiIeymBxU4MElgk=;
 b=R/TPpKkAQdv30QSrrrrHUMbTDa+gmeL6apqEm+oieUq+1USxRBs8conJF5rD3Pi1KqF5OZ+N/5I33a8w5dUzTvrj3pTKuAfOxKSZLbe0w6CGGmJlNylwYLnddy84ZqnIJB3wBVeXdz4FR0cpKPt+U4VXhSdYkHUBLqZ4iQZiMDw=
Received: from MN2PR12CA0017.namprd12.prod.outlook.com (2603:10b6:208:a8::30)
 by IA0PR12MB8929.namprd12.prod.outlook.com (2603:10b6:208:484::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Sun, 19 May
 2024 14:52:44 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::37) by MN2PR12CA0017.outlook.office365.com
 (2603:10b6:208:a8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34 via Frontend
 Transport; Sun, 19 May 2024 14:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Sun, 19 May 2024 14:52:43 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 19 May
 2024 09:52:42 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Queue KFD reset workitem in VF FED
Date: Sun, 19 May 2024 10:52:21 -0400
Message-ID: <20240519145221.623701-2-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240519145221.623701-1-victor.skvortsov@amd.com>
References: <20240519145221.623701-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|IA0PR12MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: b39e796e-63bc-48fd-51be-08dc78135711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YYeo5fOIOkDvH/DYj0ZB+GZl8nPgY/uNEvb9uNKU0lZcAwv4OuVZ9KPXCZFB?=
 =?us-ascii?Q?Pa7snAR8nRdlUmXBOzk/+UyULiODEI2ffmnSunxRYz9hLjkxDButCa1dYFwh?=
 =?us-ascii?Q?D2Gh0/pwryZ+nruhnPwzqRFWzqb+3brQrYwQmwcKpCkJwwV/2vbnmfN43dZh?=
 =?us-ascii?Q?qBKaBirH/v6PTEq2xCxl5akx3abOpsLs/RXFFBdq60UqPatiSsWbcpaf0gaf?=
 =?us-ascii?Q?KdmIo3mxu0ESdV62A7vIlr1o823RcK2K3INFOmHZ36qisBRQwCojIcD1ExHD?=
 =?us-ascii?Q?FpjznDwvZAsd1wnNCrGlLmQcwcP3yz/Ueg7bzQd0Mg+8r/NnrJ7EYmuBQX44?=
 =?us-ascii?Q?+zTj67eQ9j41n1GzyXnrAi7X3Wx5xIxdvkyg8aRW+EH5b96xNpUpKEBEoizj?=
 =?us-ascii?Q?bGhYK7sWhjfrL9iBAuuNWpMiFR+mG9jIoY/GhV1K1yl1pmPphgOcOg65P7/8?=
 =?us-ascii?Q?5mTg95W1Nj9G8Pk1F0IGv/SHqWQG59b35LzvJfGcAEG2Q/DUoXQnD33FOwpv?=
 =?us-ascii?Q?K9BT/p+Z0B7ZDxlX7IZh2tABo+2VT0UkVawAWrB5h0fy1CYu1VCaYScdy1BV?=
 =?us-ascii?Q?M72xTycBPihrsjTHlf3qbvxXa6srxSgS1BspB6UsRjwJqT82ENFwq790ehDO?=
 =?us-ascii?Q?k/5h1cqZqc6cd1yv3r9b3ieEZ3Di+hYClovrwwv5BNarvUgHVf4LGgmgvIda?=
 =?us-ascii?Q?aPwd0EcxXNbUdhJLpbJjNfGttlH2v5WVWBJIVnZLyJdr5nqXtwOSInWm7lUi?=
 =?us-ascii?Q?7kOcnVmBGTZnjC0UoNsrSdMJX02dLVAJXXnHnvFKrd4I+bo2y204FvpY9zUx?=
 =?us-ascii?Q?ngX9kU1LhCyyGci5Beec6JnM9ziLrR+cWRKDnQ3BTwtPxXsfarHZk1Hqrwbo?=
 =?us-ascii?Q?3t9/QnT7cF7zmM46DYzwRsThWKkXc6Yh8eud5qD5xF/MSfXRrlowWbAW4zsu?=
 =?us-ascii?Q?NrVeoUEh23aCQUHvLXZLn+iajDoj2Ui0k3dGz/EC2UNu5gCNasaaG0ES6f0f?=
 =?us-ascii?Q?aWYdI+aeyWz+tvyRjAf9ix/g3XIjcToC0x+IB8xoiCjk/kvtQ3a4miCau23D?=
 =?us-ascii?Q?dyp0C86hUXX2qYPhySRoAflJSN1CYfL1XcQWHwmcP2rA+yWR2SOtmUgZ4fa6?=
 =?us-ascii?Q?PXJCmsKptty/f6MDOhAr9e4dG30tkZLUOtx/LlQxkJYX3udxX/o8SHbtyL5U?=
 =?us-ascii?Q?pmY8+9Y1515dKkX/5eQhdZQgbTGKunWN7pY1rh6sUNRGwuo0+9ioG7J5k7Bw?=
 =?us-ascii?Q?yi0oawKQrzrjQOGjoMFgIAbtPyfOwwkfjvHena2PDRVZmw+HvuZ86AIqvYbC?=
 =?us-ascii?Q?a8/nj+jkS7TYDMp1mD04wAt5lR1FxplNh7D5XgTCpa3QiNKjB2fozXjjpEum?=
 =?us-ascii?Q?D22Gg17ks/iwXhfGfKQLdjJJmflz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2024 14:52:43.9763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b39e796e-63bc-48fd-51be-08dc78135711
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8929
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

The guest recovery sequence is buggy in Fatal Error when both
FLR & KFD reset workitems are queued at the same time. In addition,
FLR guest recovery sequence is out of order when PF/VF communication
breaks due to a GPU fatal error

As a temporary work around, perform a KFD style reset (Initiate reset
request from the guest) inside the pf2vf thread on FED.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index d98d619fba97..3d5f58e76f2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -602,7 +602,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 		    amdgpu_sriov_runtime(adev)) {
 			amdgpu_ras_set_fed(adev, true);
 			if (amdgpu_reset_domain_schedule(adev->reset_domain,
-							  &adev->virt.flr_work))
+							  &adev->kfd.reset_work))
 				return;
 			else
 				dev_err(adev->dev, "Failed to queue work! at %s", __func__);
-- 
2.34.1

