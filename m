Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24547C43462
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6C661059
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6C661059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E5C86EC7C;
	Wed, 12 May 2021 17:32:11 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D53516EC7D
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPpkOIiM7o4R5jnBoYDLYmt6hHiGAwzOcVxJltgtdXsm6H4vakPMiC5tJeebVTt0eNgd4dbTpKOBJ2cdm/u+bdZ2gyiu0fwaJ5C0ki4CQt7S9bSjfcE8gN/9CMkvo2J037T/R9SOYS1uKgaSBdWEnloI2I/RoeB3zuJKPmSlFaGxxGyYuUv9jRdjPEdhV//MsLYaRUIiVZZPaeMqdng2oxsezpkdJ+6vs7BF3yYOUzsrOScxnE8N9n7QYnqFduuMbAYbeZ+YP8fOfa9T17sOh/2H4WuiV8pFAtkYqeE3JSXLmfFdwqudV+sHjoLQ7/uoyXtT1GtYHhp3GSnEy6L6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT+vmT4bdew8Sh8OpfSVFjK1qOfrRvfem9MX2RTJQc8=;
 b=Ky0RIC7inFPoJDpb/+lGLV6Ojjmn7i51Vyp5XBqZOKk58WzWU+ZtnCcICFrPAYTufkq8lvtWcAi/nrXf/AU1+gWBk8ZZdHUuPdTU8emuUXougcA339Nh97x79kJDTX4IWHW+tGv2rdgHrMoEVyeLjbserbTbitpXDuLeFyeQb2zYzZanxUYXZz4a+2G+1AxsOha2GxlkLlXbQpZBLskwttYTpKb041qJaHAnQAgHhunZy7Kiysqy0FIuuhpHOVEiUtGsWveRzanJp8ei7xCs/YcANzy82KxgR0y69NWaa+yIbyJPolmhw6Zh18V6w/UkNDhD3FAkyja+QuFR8xQPZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT+vmT4bdew8Sh8OpfSVFjK1qOfrRvfem9MX2RTJQc8=;
 b=GG9sp5U6R+LKLTOOagyMd0B3aaneRuRYF36hkTZQH8Xad1btpUhm1FnjJU4lmMEk+0L2QqONkOdY+cJnMsmQEHhewkkMYSFqv6gAxTG61esh8SrjhBr96VKz1wYgalImbIWIehb4b0AN39UM12Lwv0zbRZtOV5qi1yuRrsCKieQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 17:32:07 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:07 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 36/49] drm/amdgpu: add cgls for beige_goby
Date: Wed, 12 May 2021 13:30:41 -0400
Message-Id: <20210512173053.2347842-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2e67232-516e-45fb-f896-08d9156bcb68
X-MS-TrafficTypeDiagnostic: MN2PR12MB4079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4079957E5A2370A7481526ABF7529@MN2PR12MB4079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qOZRyQG22gNc0/Vk5jL2TdJgFp4gXuToKSP4S2ND3NsuDLxldw/eam3j33Jz5zEXdrr0RYZZabnDF1IerMpidkon1GUusd5xGTOyk5q93z+Ph5jGCX40xpe7B3A48wBqApnqDmqj5Jz7r+MSi6DyORYEqRlrHFstROg6/rgMAsvW8CADSkvDa7jiRk0up8Ay1hq97dOLj1vpAga7TR5cTOb4XC8DvimAdqCV5oTGWheR8zn5ES58MbaLAmPE+cIgXdb7JIy5lNjDvPXNprb5/YD4L8v+/W+zB5mildz+7xlJlFf2vjtAEshnJO7vxo+g/Dbp36miJXUyUEnUkfQFg4LRweEmGuFmOxulfzRDsxlkeRUjiEAQIbHltqhIQbV7GuJ+9f3sn66/J9kBeLvjxAIXvuI7LJNPb0Um7z/D52ke3DVTR4xmTqUfTh5d/G9fAH7X4ClnnLlvjhDUkVJawn+JeD/qrPxVVFfkAOAlpmdjl0xoIW38DLjPj2sXeWjsLnE9klzx/yLPCZVI4t/OhD1uJAWbURsKQHn8ylm+dHsmnnbLHWX8XyDma7jWX0sfDXRwV7hfvD4Lp+WAViLjm81l+yZnNa6XHhPeXxHCYmJz/hkv/ynMJaZc8/B72ko7LK6Bcj4i6nHxqvK7LhVRxQZI2Q4jGZDDE5zrz9R6jb1bf8xLwqq9igz5rANZeaLL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(8936002)(6506007)(8676002)(86362001)(4744005)(26005)(16526019)(186003)(52116002)(2906002)(956004)(66556008)(2616005)(478600001)(38100700002)(66476007)(5660300002)(66946007)(36756003)(38350700002)(6512007)(6486002)(316002)(54906003)(6666004)(1076003)(6916009)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uloYzco6U440AyUjuid6TTfSaXiAg9Ch5KXEMbNadPn4n8dkztWLEwTOQJvt?=
 =?us-ascii?Q?uVCIrfQYrBKgVg6k+E0Mgl7WlEOYz8ZeOzRqPqefEiqqWxNKsNiHFf+estEi?=
 =?us-ascii?Q?4vZzWkip0K7nUpXzkBRth7l3Sa2vsRtctJQPH5v1Iy+XJpx6OGhOtObZem2k?=
 =?us-ascii?Q?ej2IF7VEoSbf+3+uZUj6Gdwol+rus/CCjBibqvu0MiHX79MzMGBQjaAiFBga?=
 =?us-ascii?Q?B52rkspFAo3/PHZTOy1BnD4tV61MaRvGVHNtd6ceSffC2PvdFvpWByuGLHoP?=
 =?us-ascii?Q?Y/SgA3h/hCYly5QRhRSNP79EW9PDo12PMeOFowyC0eU9o6DlGGuq6/GlFVvA?=
 =?us-ascii?Q?3xYhtZA11mp176UX6oQeg1BlV3NRPhKTwi5Ee9ODiyPrKBkX/XU2UesVC9gP?=
 =?us-ascii?Q?/XLII1JjF7ESX8DRW/iDRQloYat1rPLkuUm++JjMFnKtxNF2VKGP/XyCU3o7?=
 =?us-ascii?Q?sAaLpwj0WbaCVXmagFaa+2hZkdQz0V3DdKMc5+ZD9zhlpgjexC0a/p3GFtJy?=
 =?us-ascii?Q?8Xhf3Buu536BI9EjLj9dkq1VwbmzxMrmO2B3r//j0fxn9Ise5a6lsXTboV1R?=
 =?us-ascii?Q?Z7eRPy0yQBDvXydS2Zo+G6JBmI7pfBoyjgFF8OEhUqLj8JzLoexYixjHeLC6?=
 =?us-ascii?Q?zIIPsCeSPHLRJ4WJATSRxp/L84B5ZuOxju0/GtHdUvW1YeHSt3wanc7WyY/h?=
 =?us-ascii?Q?qjuNtSlhVS2AuwIsgPt9FqoJ6SFLoqGg8znamVrQBc8OzO46JMFrUHmnpJKr?=
 =?us-ascii?Q?er67lUpr44vqwbjQkm81wcaxAa3Cyz/JMkobKU+AYFbwRCghL78DIYukJXxR?=
 =?us-ascii?Q?xLJjO0CCodiTp1v1rBpj9d9QnKrFdEKPA1R+vnabGkNQu3PtLAxP0kGcs0Y2?=
 =?us-ascii?Q?dIbTsxtsjp6HuEYNghagSo9RMgnyhPkZojoBjcCUJIT0mLRLPpUNHBsUkhe8?=
 =?us-ascii?Q?bWGKxz/sFuYwDRlj3IEJke+NA3FunKjHgzekR4/OTwihjf9EQikeAFWbUAnH?=
 =?us-ascii?Q?ZVXpNUUi9WqMkWjPtI2KPAE09W3NUMtJqP2fN4e4g+zxGK/7oRy2+uv40F4q?=
 =?us-ascii?Q?H+XzK8AQFSOLSr3yR6MvgoYF+LtJrVm9RYUkx74lMPPVtMrqmxVeHnPpuG+2?=
 =?us-ascii?Q?70gHKE9xm/uh6Pr4dg9ShUJ6IOFfk+S37sIagPZhhD/i98zi8JePYJ7FXHzg?=
 =?us-ascii?Q?qPPU0Wu23LTQD/86pp4yirUqki5wXPeO80Qc2wNrBvjTUXQsGftAeK3HaW0O?=
 =?us-ascii?Q?jjGJgRuu5mCh5PR3F8za0/kMFRvLlrkyhD+c3qIKh53gnLpnn2VTQBW1vxaW?=
 =?us-ascii?Q?nJo3WVoEluXYHPAVdyGd5xAD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e67232-516e-45fb-f896-08d9156bcb68
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:36.9049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqO0foJ6jYggI3Y5iKkFmPW/qPdTmtHQlmbY4OUjeNyWDI54vJIPdmN2xWB8ROSRD1EGkzFm1rTCQLCuR1puTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jack Gui <Jack.Gui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Enable cgls to improve the runtime power efficiency.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index a059789b00ae..96c7374b93ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1174,6 +1174,7 @@ static int nv_common_early_init(void *handle)
 	case CHIP_BEIGE_GOBY:
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_GFX_3D_CGCG |
 			AMD_CG_SUPPORT_MC_MGCG |
 			AMD_CG_SUPPORT_MC_LS |
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
