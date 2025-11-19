Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C1ACF2567
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 07:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E03510E22A;
	Wed, 19 Nov 2025 07:28:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UpvJsy0V";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010064.outbound.protection.outlook.com
 [52.101.193.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D0110E22A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 07:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAu+1lj9JuQcs083g762KrWcjcyD1quM9hVgoFI/4zS4VyDBziHusXYROdtQ2cO67pIGeoj8ktzyoGdwEFre4dYEJygPFnPs7zFzxn3MuVObjLCmXeuZdRJpbuP1HYUIZzSIp4EBnWMuXLlK8ZhFLZwa8DjsrSvjbzM+xiSibPUmAzSnWOb+Vx7Ow6zxmPwK707T2XGvTSuoKolFX0v1d1PJj9lJbgJI0gvPWONqs54Aouk260k0N9iA1bKKfj+gJhy+u+7yZVA6nfSbH/A/nGls27WB3Hl6Wb/cT5eaEsQ3VysUPocjouvzVXc1sNdJt3VdR3vakQRJX7HsoimEsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18oqmdkr3+wgpi64uiKq0VI9xRMazc+nReMOGB8XAOk=;
 b=cOkBqMFgWj9/S4YX8TSfiUXiF4Cd6PoYZnYKOjx82MrUYhUnXnc0AXBh20okuorDIdJeYGAmUUTfPQcd5ch8s4qgWO2lRcGujBSUjll0yKWmwPz5i8gU75iC/EjsNmOD07Iesbs+Yl8lXOfz5ivH8j38AX8nRd7rVlTWT/76ew5HyIIxLnWjq3/vfN0/CNnMSvsSc4kqn71icRGy89h67fzG5a1XczlGBAUmrte01k81GVc+tu0E0+APum4zyqVc/c6c7J+YMT3syEu3g+IYisZwtOc+36So+gZh3vZqDw1IuFUlnqlFW/G+cM1CfDNCJx1K5i2iyzYTa+IrHbqUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18oqmdkr3+wgpi64uiKq0VI9xRMazc+nReMOGB8XAOk=;
 b=UpvJsy0VBjN7ZYqZElCfYRumz1f3lN6Kfx3t8UiJVvZj0o75WhhSo6TV2AU0XQEhARELaKk8KmjUqtZa/BG08+3V1lckrQJWq0pv7smdYjGodlH5U5FUpN76xKIDRm0xvcirPNfGw+vRU6zYA7f6cp9OnSmQ3CvSxrS7XMStugM=
Received: from BL1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:256::21)
 by CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 07:28:41 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:256:cafe::8c) by BL1PR13CA0016.outlook.office365.com
 (2603:10b6:208:256::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.7 via Frontend Transport; Wed,
 19 Nov 2025 07:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 07:28:40 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 23:28:38 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: fix the calculation of RAS bad page number
Date: Wed, 19 Nov 2025 15:28:23 +0800
Message-ID: <20251119072823.1456062-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: e74a2064-40eb-4b4b-e143-08de273d42de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HcXxnicjxKt5AxbVVTIk1Pt7KLUv8BT6HxPJr7Jd6yJueaGM5ds/tVuikTCB?=
 =?us-ascii?Q?9iRhYtYwcwJ4ptaeOvMELvAWPxjJMR0mDFcivXh+FAdNMauPf8XuUdNPI3ml?=
 =?us-ascii?Q?BoSW0IMJ/bMuXrZs2P2QjyNiyS5yrrHbtWJLvYxvP4x8wwHZxKmYum6XraJo?=
 =?us-ascii?Q?lmbPYEiZ9ChnAyyld3+UqmGKCk0jQkXfvWKm0TTVQalV+LnZJlWKxjwcm4B0?=
 =?us-ascii?Q?kB0jXrRDmyDq2w7iabCQCLB5glaYMGg3k9AS1D6q8A3dMxlfI1CGjzSUTNQ4?=
 =?us-ascii?Q?Ug5yxNP/8JABqeXcg7BViett9pi5uChfGig34jSSHQiIwWEjylYfljchdELK?=
 =?us-ascii?Q?85VsyrtEkRfkK3sDTQJ52aCwLqIB29V+K9Xj+37IRXRKY/1JRarOyRq+wHdI?=
 =?us-ascii?Q?ydqIuNuPxirIW6R7lLuJwreIPFO4VY5urx970Cj/SAV87U5wgdxQGkprrgFV?=
 =?us-ascii?Q?Yas5eMGkgJTxjYtEcEe41GO/wURvo2C6J01BlhsFfhHCuW70OjqrVRI/V3lX?=
 =?us-ascii?Q?R7oPFe6iewLLzpkhp/nbavHL2QXgB05/RJhDnX9/daTKo0wT2DJI6Agcx4As?=
 =?us-ascii?Q?aUUB0QjlSCkHYsjq28LsRmntnxAU/G4HsVotIuPhuvdkEv9qyAPRqDWB8FSq?=
 =?us-ascii?Q?TYOfYWHKGoigYYJCtRsITP7N9xxJHh+BSBxvYqJfKx5RVAre+rIwZ8hmt66f?=
 =?us-ascii?Q?EOrhTNBYwXNYH7A9MKjl46ioyTY7OMNxnr9dLiQQNoNlVbdCPTmZsXGDx5z2?=
 =?us-ascii?Q?kkTJYRxsppd4nf6ZUfxJz3Zf7CCKFtnLJDxcJWSj1m0XtjdC1GmoUeYkrftY?=
 =?us-ascii?Q?8hoHwJ21LLPYOs0uLT43hW0v8HjggR+IckxZMkGbDUO2itkBCZAMWeJoJdU6?=
 =?us-ascii?Q?FL6TpQUh68skOuWcv+14DrsvGMJy2XMojZTT3OZpMkmu9G6PacWcP3FXuboE?=
 =?us-ascii?Q?sxVeWI1PvVGZFOTZlY+0jegBx40jprGqN0KgZFTQr93F6tHQeRznH2u7vAqI?=
 =?us-ascii?Q?VXDGu0qrMXNm2oB7jU2yqYrbiCIeCg9E/hKCiwn0JXPZ9BWoDsmtvF6Elax4?=
 =?us-ascii?Q?h2D7Sovnj8Y0BsmZhYOi+RyTIBhDYUAbn00UuGGFtS0wNKpg/AGkr00Q+Anw?=
 =?us-ascii?Q?yXLsZ6cKl2AFjlkKxxTaPnERL4y+1fZ/hyANmE/s2f5xmTJ9L97AaavQ0zmk?=
 =?us-ascii?Q?YmJypAReKZkYHZukzpRtxICzl8y0b+rD05yboBpeHZWBzg1GDJ2A+RfUyPEV?=
 =?us-ascii?Q?Yp/JHowz6Y8i/JfzV7JQlL6jlBudUcRqFX5C7E7lEeFbm9e4n4dfceFf4c+s?=
 =?us-ascii?Q?CEBh5F28yVGGg7dn2DxUtd482dE3+d5JSlzJU+i08xJ+D4P3Ty6nZ2lvZWem?=
 =?us-ascii?Q?2fbOtaC4V/+/m4SkAAy/E5ebbv0qqG8wW6Ocw1ucTVO9qn+7iSvBnXlC/8eY?=
 =?us-ascii?Q?M/6bhqtAADTjVLiBqWd4f1YlMpTRm/La3y6ndGj5Lo74wnhnRnwzx4aajmOy?=
 =?us-ascii?Q?tXDuw/FwX3Nb/perPY0iYSNwYL9vIgsAtDeTReuCNYLvObQyJt8zw71Wlx3x?=
 =?us-ascii?Q?MvjmI07P7a5UwvuFbLk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 07:28:40.1159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e74a2064-40eb-4b4b-e143-08de273d42de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056
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

__amdgpu_ras_restore_bad_pages is responsible for the maintenance of bad
page number, drop the unnecessary bad page number update in the error
handling path of add_bad_pages.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 00f890bbe912..b0262fd52b58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3263,8 +3263,6 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 						/* deal with retire_unit records a time */
 						ret = __amdgpu_ras_convert_rec_array_from_rom(adev,
 										&bps[i], &err_data, nps);
-						if (ret)
-							con->bad_page_num -= adev->umc.retire_unit;
 						i += (adev->umc.retire_unit - 1);
 					} else {
 						break;
@@ -3277,8 +3275,6 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		for (; i < pages; i++) {
 			ret = __amdgpu_ras_convert_rec_from_rom(adev,
 				&bps[i], &err_data, nps);
-			if (ret)
-				con->bad_page_num -= adev->umc.retire_unit;
 		}
 
 		con->eh_data->count_saved = con->eh_data->count;
-- 
2.34.1

