Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE403E7716A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2024 06:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6984610E3D9;
	Tue, 17 Dec 2024 06:50:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w4QFXgKH";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 288CE10E3D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2024 06:50:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdD9YEks34RAfGiOXmpy4XA513n8dhhrG5c+caDvYSUm+W1S4/R3wiBQr7GpFA8e4c4zZcy3wQCutDxx0qNp772nwKSKvWOcXtTgTDwWAic9GDssm17vTwDI9vhs9Z8f8DtszTBDJVsPEeiRDPaxOMk2/4PoQTdUKPvCe4+2K63MLJjmOMc4VuIphlTHWyTVnLTkV2aLo9MPhwR7VBfnhPicl13sZ00peXqQXDJANLetgaz+a7J5XoFYrZg2TGvHQF+Zp008vaj5wRIMDA0nrIhhJDZfTH1PRfSuZiqrgOq+rIGoRb43EHXZTy8Xdft2M131K+D1ewtJAckv30cB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hlAvWn70rNGvO3DqahVRASVtRNuX/VRB4ORl0ihLX0=;
 b=Y/5fL8RqEfH5TIyXrLjexCKCl4iqw3fQbzbjNvb3NEl7+MD2pLRKl8q7a+f7i0Sk6auZAFF7sCbVKdC+44GrO9fawjqw11RhQZnUyhygQ10BxxATHyrmSC4FYgoX0pUt2EGAxmAGschBLhRaHJEr7ZrYcsTFx6Ij1AiGYjxcgff3wjOMMUL8YcPvbetCYfeHJ5e1FjoIEvz6rl4fZtao3nhpVGyLACJ2wyOkJo+0xqaKRdJYn2ho/Nju4HSjlzt7uRdjj3SBRt/lGb2QdWl7vCNI2aMr6fE/NqyyneYrpHSdQHLpdk9OdioFFMS73SS+XDrxRSDJKYQyJ62ca14rhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hlAvWn70rNGvO3DqahVRASVtRNuX/VRB4ORl0ihLX0=;
 b=w4QFXgKHsV9nB/ZcxHWXmPcro462uZSnhKUXC0fGHt213ByQD0sKNNAqKgrWVnav4JO8LAL8t9sBHElgiKduH7FJHUCgd+lJkqEdX+doDUap6v7h/7TWh5ipTRl14BFxQa+8U0Svn/AiVIomSrfX9fRVnnfyzoR5RnGtVg/McuE=
Received: from PH7P221CA0082.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::21)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Tue, 17 Dec
 2024 06:50:18 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:328::4) by PH7P221CA0082.outlook.office365.com
 (2603:10b6:510:328::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Tue,
 17 Dec 2024 06:50:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 17 Dec 2024 06:50:16 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Dec
 2024 00:50:14 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Refine ip detection log message
Date: Tue, 17 Dec 2024 12:19:48 +0530
Message-ID: <20241217064948.56037-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7f7dbb-9d04-42e1-0a21-08dd1e6710eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PaQ75IIepwnJptO22gAhGrWI7vWJnHOy8fx44vFYLqR/zLLWO2giqhujhnZq?=
 =?us-ascii?Q?yoWo8CbilqtLcmk7Ul7U9589CWLULlaIXlafPIbxU6p9Hs/cBwnpCgKiHY/4?=
 =?us-ascii?Q?F0x1mkRbpZQK/OsSl29NAuvWtoIkYasHuXN6G7YDMAXZFBlw2J6VFv6UbBAu?=
 =?us-ascii?Q?wm6py0hbQDCPohaMEQoRJv+sHhCaNPqK9OkTScAKYL/E3LzECQ7M0a3o9cZL?=
 =?us-ascii?Q?nzIGVOs+Ml2KC/DvD+3dCUtbUR5jFJRo4BvcIJwXL/JMT/pxRWIdlqhFaOKQ?=
 =?us-ascii?Q?mLVFgs137DN3vUe3J+ZfBCW/oT9E1fudRNECuiOhBm8UkC1fnZb6BqExu6Pz?=
 =?us-ascii?Q?dTK2DflAePdfWeyN+hj7ZJF7k/pGG3Ms5WV0eR2Li6Z5+WX8OndqsvDPO+yY?=
 =?us-ascii?Q?VoB349li1aCNpNY8S0iHtVCv98MGUJI7Sb4ZGKwSP0bbDlTQrTZvBsWMvd28?=
 =?us-ascii?Q?sDWFYg7WCC4a68Eq1SIJP2S+SDwmrf0Ftn2bSpohDdfDF76a3fL0NSGkZsAk?=
 =?us-ascii?Q?IzfvNB1L02waQYwtuZ8naDI49YfeSLQ+jSLIzMVSEDObD5jei+nsSO2ffv2c?=
 =?us-ascii?Q?mtfwe6HANdD/sxZPA5DDFxpsDJg6328dVlriDiZQddAwxoDBmCBVS9/dFBEr?=
 =?us-ascii?Q?RV/PYb/DQIZGI8uxZYy6wmIRj9oF70Ca9Y9Dys5Cgv6/F1LHLiU6IpmTdaSV?=
 =?us-ascii?Q?yhk6UtFqE+DRPOsQ1U7I+GbZYkDB9n1NJa7gH2gGrV1y88O8TL9NGpBi+oi0?=
 =?us-ascii?Q?zeyT5TxcDx/6+icjJiiC/nPbYeUg9PA3snVM29Ig/r9nylCIUyGTMkdj5vkM?=
 =?us-ascii?Q?sMNWtX+ELAvu54WgVFH9sOjbO3qpksA8rlzMpknkSebAbvGMNZNLEdDSypfF?=
 =?us-ascii?Q?nqIcT0mdV/rVLwFpc1xFxoSNfUGXeQ6pJ3aN7DnI//OGUfKvWs9kWuL92xZd?=
 =?us-ascii?Q?EX7h4Z5d//GlZ3tS8Lo/MZbQd46MM8Dimc7dK2zyYwaF3F3bUGaW5Fnc3aYc?=
 =?us-ascii?Q?dxCqkDuTOMvM9Lucj3pmRmThCKftCgZwnxBOsdYc0dZqi072kmOGduelBKgv?=
 =?us-ascii?Q?2k03by1KzAGgR6gWMSvGwR3L1hzqauWRd+FReflVGxTmoDYi19aoIm0sJkfu?=
 =?us-ascii?Q?ytBUHN9foO+dSh4lOVh6n5nxyuexntY2rTW43LJzyBHQ8QwVKXdgVkQL8K4f?=
 =?us-ascii?Q?lhRV+qKlNtMPAfB5XsZ1JWzmZQI2+WtHMaJbsk/ZV6yZF5nVSXnvtSnvCDbY?=
 =?us-ascii?Q?PIvnpOn07FYQl69TU3IeudanWy1HgADxBt7ffoEMIWwRS57VOT6BtyY4kCkt?=
 =?us-ascii?Q?hexWnrzesLpkdYKVsaXMwxPoaKDRCVR8Zg+dzgkm+X9LrONWMF1BlgJCPKK9?=
 =?us-ascii?Q?e9zQC/ja6FFTbTaeo4d47/QdvAwQHsbDrSxIKcFHX3UFtneWw9uK2C8s2vCP?=
 =?us-ascii?Q?WJ6EJrV9cECJfspV2SwLYux+gi61JitAChNWZ0z3kD5YhHrXUMsOAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 06:50:16.9844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7f7dbb-9d04-42e1-0a21-08dd1e6710eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731
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

'add ip block' causes a confusion if the blocks are disabled later with
ip_block_mask. Instead change to 'detected' and also add device context.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0a121aab5c74..182b6288df9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2365,8 +2365,8 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 		break;
 	}
 
-	DRM_INFO("add ip block number %d <%s>\n", adev->num_ip_blocks,
-		  ip_block_version->funcs->name);
+	dev_info(adev->dev, "detected ip block number %d <%s>\n",
+		 adev->num_ip_blocks, ip_block_version->funcs->name);
 
 	adev->ip_blocks[adev->num_ip_blocks].adev = adev;
 
-- 
2.25.1

