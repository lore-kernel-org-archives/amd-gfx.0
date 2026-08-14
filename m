Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C699AC5DF72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B91810F6FA;
	Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3wIMEQFm";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012067.outbound.protection.outlook.com
 [40.93.195.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C04110F6F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8Of6XnkTWi9m7GJbqIGPjaRF71Eb3rMrDK2+TKLSRQ0GXCUqhF4nnrPPi1AiB16vXqvTXbceV1lfz3hp2du6eUN0O8cr2MI2k/qSjPTM7u7LqlUc2ZeEvxk0neX1YvQd7l9Osi0gjRxzpnMUedCo0I9yLRqV20enw5ZrVcJBqqg/P0SEMEQnBqZcGYKDPLWpCwTQL4pqml89ocna5yEnrXDhcI7ZAi60zZtVoWoACzxDnioXDF28uEq3DMR0ZR7BLdoEXmg7Qx2kozhrLG+7kjCZQY1ybjn0efzrz/JpL+qdCPPi1t04wYKZh9azwWlsd1+IQPJfWjnRgpQmvGYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFeKdLAadaKAcylojle8iuz35Rr83x4aOUiP6c8crHw=;
 b=LNCz2guD0phz2Srwf0kHUx4dedcFqGvsPHIPmmFZU5tOV0YeB1WEoP98oAmnGIjWV/0eBv9mxK6Dr5fylirqgqqCtKZmMaSg1szRX8ucU5WiVwepEhC5oPzSCo/FfkgvNvaSLwe0TkgEtUhhKI3HrDgxkPlPPsf3VW9MzjwCf7zANFGcU+iOphCmvxme8eFXB/G+IWLvTPY/ebN1IdKfD5Vwi2HR/C8LBfHHSz7WZ4D2tl5oRNOApGU2TBiOPRsODDM1x1LKtwb84Rs1JC9Qnbq61GB06KVFTtLlGCKMo9aEs0OWpraC3fXeY30neUwLNu1WcQeDVesd+KzuRKLCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFeKdLAadaKAcylojle8iuz35Rr83x4aOUiP6c8crHw=;
 b=3wIMEQFm3rbenBVgCc1TY4fuldyQ5VinawhpOIReAxLV7+q3/oHrkNcRcngtzNbEhYiMhqojvgH2eqouobjI51iIG7MJ+5Y26WZEFujq6GhJOp27Z3WLkjfCi36+x/od5r5DHm2MLjoSjVMotGfQ1U1nTltNhr8ndE5kKp/S1fg=
Received: from CH0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:76::16)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:20 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:76:cafe::38) by CH0PR04CA0011.outlook.office365.com
 (2603:10b6:610:76::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:13 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 026/109] drm/amdgpu: Handle ras interrupts using unified
 interface
Date: Fri, 14 Aug 2026 17:01:23 -0400
Message-ID: <20260814210246.3067612-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 3931d3b3-0ae5-4eb2-75d1-08defa477876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: h0Hgvf776uvizQFjH2PKgSrNUEci7RKLJ11KpMF+aKzCOubI/0iSJRiDhzgHPhUKNDcV/NE8ZCq8U834QCPt+3u4Lk3GiTOYLr+6ayy4360lfyzQGCkSW4F6ffGYzRlwntQFi88IbxJp9qYfu+majExJ+UFIlndfpqWRLQcrXw2UgrW6/O4LkZ0QljGxf19qpTlkfPd5ZHQ30M+KBoUvxz2q49Jf4h/jo76jydO4wPLCKjtFuAS5K6IMRSJvrKxC2dw8CaGSzQll3iUPWKC6LFdFNlZEl0XeOsef/FXlzORaMy4CJvU8VD0HWmvjsiMxakagyuM0yEcFTt3eX+DhZBdKw9Jn37OVlAPXKXGCuSe46U5KIP4ahIUPDC4Nl46O77EK2gd8drlicavIlVMXWwPL1QqTPwKFUIL4WHE6b9KKRzEOjzDeZqka9C8eVcmKGILl7g3PnumqpvoZeBN4Buok6WovPtgxcFqsx+U8e/nGjgKLw1plOuiNvn1xdAEW4F8/jGkmWKOHH2uWQztBsRq0RtOBbTnT9HSOCI2m8Ny2Igbd07Jyy8J2EIhg+ImEDs1xCqvJ24AyDXYNQnU/U2Ey5tqZgxMUdPLcmC7O+tdlwEYAlN4GXGvj5oXaCuoLb/XL9m8wCjqAx5zrAbjpBP9dryH9aq167PXG5Q+UnGQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oVveOBpXnyvg4pCy1qkyy1pFZAUZtk5NfnOy+8SctLLYuhJhMWZrpaBGky4LKCs+tvHhnZPz24nOkfCw4jqJEz3qdyYqyWXHlCGpPlJG3d8ZyWNMeBDRM/nzeiNbcj9S3Pt5D+MHj7KNbNW+zzbHAdoarnzAcBMxvB6ZM4p8VU6i11VDBhsffB1UlTuFZcff9DajtI4F2aDNlUcd7VPNETcTxr7jNhGTaB+ygVIRLP+jAIcu+DMOnRx5RN6SNuZYKu+wptwOOWUXJQEbdf9YlNXfmPRUC++WDFnR5VlegLE+tF8NpZK/zftt0WwWTcIl4MKMF9SbW+/+rlvDdCIbZHwPeQ/OJsr/0oxvNWBEZFcq6+lV2R5c5DscgbBMHSZd7XKsg1Nddfh9FQfE+z+JjnbPhBGgrlCd7aDF1SjQ6hY8oDsAMqXkWnpRLMpHmaMe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:20.3301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3931d3b3-0ae5-4eb2-75d1-08defa477876
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Handle ras interrupts using unified interface.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 35eb87591740a..378921a53b9a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2393,9 +2393,7 @@ int amdgpu_ras_interrupt_dispatch(struct amdgpu_device *adev,
 
 		memset(&ih_info, 0, sizeof(ih_info));
 		ih_info.block = info->head.block;
-		memcpy(&ih_info.iv_entry, info->entry, sizeof(struct amdgpu_iv_entry));
-
-		return amdgpu_ras_mgr_handle_controller_interrupt(adev, &ih_info);
+		return amdgpu_ras_mgr_dispatch_interrupt(adev, &ih_info);
 	}
 
 	obj = amdgpu_ras_find_obj(adev, &info->head);
-- 
2.55.0

