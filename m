Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BDFCCA472
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 13:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37CDD10E813;
	Wed,  8 Oct 2025 13:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mHp5xmUk";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C2E10E813
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 13:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGFmfo7whI0X2VYyLCvyoUyeOY42F2OMtbfyjlSdS7jSHbBLt7TxCnPPAdH6s6RlSRqRy7gb1fxf/yWxbLn3bvopgmdCv5ywPGcAH/FptZ/F/uIxKbV6zu8lOTOADcSw+ROpPg349YGQ1b2UEMzzc1iTYNnFhgQBxdMz2COdusGGXdmEiVS57zZIAvLumQXs3zSG6w5YmUu1M6mr/OU90eNsnWzlOyjTt5b317m4bjCa4fxbLQxSBnP3p4P58jZzXTzUvqNv4uTOUgWkunL8gAFbCIXWLbqIFGWMHkzjGb7Gml5Gpq9Do5r9DPHZBkcFKCgAtnZhaD8V7SkSw4OliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty/pjDKeArtTM8H/Qs2fyGP19dxEumd8U9Aj6ZVEyqE=;
 b=BZIeS0vk8y3ZrcJw7R3WOHC1O699MDb/oKz/Zu6nNs5DqVy1aHVxRUImklOfCjwsNfuy1yNL/ppTsCyAu0a5fknwQYtRXVyuQwrwQ+MrE8CNG4TlPxL9Guxn1/WzqBSUwE8S4hThZBaRFecMCGFShl983mMyNuFJL8c+L7PCQQzHdmitpIrTbhsRid03h8W6194JYz9DBY8VVvyGJt6mgYtffGsVPb6x8qTA6ZbWsIMaYoT+D2fC/Ou7nj7sU5XMgvYApH1OFklOk4UBQ8ff82GH2uhF2YyfGlFmmv038PGzExHgdK4iMAc6FJvOe3HEc+jjCAMr+JexzkzRCOwdKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty/pjDKeArtTM8H/Qs2fyGP19dxEumd8U9Aj6ZVEyqE=;
 b=mHp5xmUko/vB+qQnTpl1HZFJXmumxCYJZ73WX3G2Tl3J36M4Yg0SVtzIgiwrlYXuOBujyE8GY934CHiq99j44ejEw005pM5sdl2lECxvpVt5V4aDuAoQ0Hb6+Pu/xF+joAuo0SgjYIXAQ+2HWMEzIzLhwGqVAu2rvffXQ/fsrHQ=
Received: from CH5P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::27)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Wed, 8 Oct
 2025 13:33:23 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::16) by CH5P220CA0013.outlook.office365.com
 (2603:10b6:610:1ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 13:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 13:33:22 +0000
Received: from smc-sc-di15-34.dh144.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Oct 2025 06:33:19 -0700
From: <will.aitken@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.skvortsov@amd.com>, <lijo.lazar@amd.com>, Will Aitken
 <wiaitken@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Enable xgmi extended peer links for sriov
 guest
Date: Wed, 8 Oct 2025 13:32:25 +0000
Message-ID: <20251008133225.1238028-3-will.aitken@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008133225.1238028-1-will.aitken@amd.com>
References: <20251008133225.1238028-1-will.aitken@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: fa81b556-3140-4459-f538-08de066f4075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mhMAec760paJ3p8FWqSRjZrLNUG3/f2qDW2UrTVNwoWfDUjOAK7q0FQJbpnF?=
 =?us-ascii?Q?FzPmAJ/6Fh3fDLwbShGq14ofxJl/9Lrv+j+Xl82D3cZcnhgRtnGIUb/qzQDw?=
 =?us-ascii?Q?CsAPq1DWTH1v52MMxQLYkCtXHR9b4rFdYRxiWPMWD0JL+UmIQhas9UQF6ofd?=
 =?us-ascii?Q?EDzUmyK8NOwlLngA+20WkTTNCqXEvOsIErlu1tuSe8fMqibUVCSXSFU1sLTt?=
 =?us-ascii?Q?sgSrBGkSZuaW5jkwZ7yazcFj5Ql4AiJ22f6LOciwES4gZRSPCdKXe56w6DCL?=
 =?us-ascii?Q?Yzd0qcaAsgTluGP2wOWRVmS67iltKaPb70pHH399dRISYYJ64fxPiKhm4ARs?=
 =?us-ascii?Q?gG2yLSizmghNb01fs3JPvT7iQCXqWWfJzEdlz3aOeBu3bXuCZvM7agfP3L9E?=
 =?us-ascii?Q?7Fgringj7f4aE6GTv2RyaUGd6b0Q1NsqFyX1I8wf7h2Yd5kssuUYnKTQM5oO?=
 =?us-ascii?Q?USGPJOM0VgSz1mJ5qkwdOd77tqZYOlhHMvAoisjAig1ishjA0pLx4YP0gcCz?=
 =?us-ascii?Q?I8UOtLaQG9+7IPdlk62fG8INyvf/6xX4o2Uyr+huZvh6agkaiYUPStCBvQvH?=
 =?us-ascii?Q?0g11ZvGlxLw1k/nApegd0jNAYU84v/UihBUoGCAFdr5YF0KqUB2q3AJCN66z?=
 =?us-ascii?Q?MsQOVLj8B0jdRKKBenuK5JhL5J2dBpTrC3TzZp7XPUjHvJKxO9Oej8d6XInf?=
 =?us-ascii?Q?W2iHoFHHKJoCMnniP7DUjU4O7zuXy9ceSdqjGk65W4nLs1Jr7/F/tXW4ID6U?=
 =?us-ascii?Q?Pwq4G3j84lNsxUB3J/A2eK07X4bW65rwRGIcEo4jkLfjEU8XoHQvAqW391Hj?=
 =?us-ascii?Q?UQnA3P51XEuVHd2nrvIChp2hGBLS7bFC2/m7B6XjCGgb9ab2dHD504EA8DMO?=
 =?us-ascii?Q?dNqlLQqAc5JmDR0T8XGJ2copwBrmjB/Belohvam6jzrU8JQZ6u5zThm/1Wh8?=
 =?us-ascii?Q?Cv/bCTXtIVbRnOkqcOPl7zjs9DmP1NOBenxFp/ocGPRza8v8mIo90fjBTNW5?=
 =?us-ascii?Q?nCjqMSwpZujfBVbFbERf76zAD08PL3+Tx9+aSvhrQ4iL+YxZxkjaWAFppN5p?=
 =?us-ascii?Q?+nXsbsXjdND74vPBbHQ+nJlW45Tgp9jjHnYs5bMGHSf4a2K3GG6a55zAV2u1?=
 =?us-ascii?Q?lZ3FxBkTc7v2ozrPMzdgrT8rVjHqN3epakJOYoHVk6IdVUuFaMr6o8nK1l6l?=
 =?us-ascii?Q?nrh2PuBjQA792IvMkWXViwd04kFmO3b9F437nYUzpAMlDTQTQkWra04L4Fhh?=
 =?us-ascii?Q?67x3jf1Y8tb0ltCpOn7c0TGmVrpbyUggInnUcTMib4oM5oQ+P2z5/Se5a/Qw?=
 =?us-ascii?Q?Pr8+27EWcQbLT3JOvTWRVBZhVetn93S0D9nPdTr0lXzgAGl0ikM2U4z3ygxz?=
 =?us-ascii?Q?TBOSGSPVJqMDIyWKkUjdZJTtvllTbkqLKYrmtD1FaqM+Clap+ziM5BGq23XD?=
 =?us-ascii?Q?l51suoPnknqbmbHfQjCVR935YGEJDzLHhMX8Sxp7uxwu9pJkVqzcRIzZaWYk?=
 =?us-ascii?Q?Uc/F02PUwgPRR5wgMeCApfWH28RGO0EirZl17A4xlLzqwnK+3NsKHfk4NsCO?=
 =?us-ascii?Q?G6qM0IRXxMIjMmf8LYE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 13:33:22.5275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa81b556-3140-4459-f538-08de066f4075
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773
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

From: Will Aitken <wiaitken@amd.com>

The amd-smi tool relies on extended peer link information to report xgmi
link metrics. The necessary xgmi ta command, GET_EXTEND_PEER_LINKS, has
been enabled in the host driver and this change is necessary for the
guest to make use of it. To handle the case where the host driver does
not have the latest xgmi ta, the guest driver checks for guest support
through a pf2vf feature flag before invoking psp.

Signed-off-by: Will Aitken <wiaitken@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 82500ade240d..b69e376372d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1649,8 +1649,8 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 			amdgpu_ip_version(psp->adev, MP0_HWIP, 0) ==
 				IP_VERSION(13, 0, 14) ||
 			amdgpu_sriov_vf(psp->adev);
-		bool ta_port_num_support = amdgpu_sriov_vf(psp->adev) ? 0 :
-				psp->xgmi_context.xgmi_ta_caps & EXTEND_PEER_LINK_INFO_CMD_FLAG;
+		bool ta_port_num_support = psp->xgmi_context.xgmi_ta_caps & EXTEND_PEER_LINK_INFO_CMD_FLAG ||
+			amdgpu_sriov_xgmi_ta_ext_peer_link_en(psp->adev);
 
 		/* popluate the shared output buffer rather than the cmd input buffer
 		 * with node_ids as the input for GET_PEER_LINKS command execution.
-- 
2.43.0

