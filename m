Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA57C636C9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 03:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFD661029
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 03:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFD661029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87BB86E8E5;
	Wed, 21 Jul 2021 03:15:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E79A6E8E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 03:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG+2jOwr2NPObN2RYqJG6zCkGw6OZd6FI4aAyCOJJnYbC/Nnl8C8A1O52rfoRX7psrpnRHVvcOpnKPadHbAjMT3uKKnKSZv/hbSTW6IRR++7XC8XZfrpetObQtfgWaoLdKjxp/DQFsAC6tbWEv2cO6fsoBO/nDj1WEvl7Nu0WU9nWmAoNVmPnKqwUnzCTliTg+BAs2mWQpI6JqEOiV6SWtKpNIKP4ObMjKZ29BPOCbvKjyJReeIrHUykqkr7yXyri3XqqR5cVHv08CPetgdUFRUpUjxKqh2j8C2lwy8SIi1DqKF5sfanlPybZdjaFwo74FdEfPFaSPWnC8mCcftHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2R80KB/pDgx04w4WaLdYANKwckQjPWhwone7hvcQhM=;
 b=OJxE2qEVFP5V+mxWFuFgZfFAotfakzLWVU9VjK/gbxBg6XwWxKxY4sMmKwyLrDGMG6akHDvJog564ChX2fKRLDHHVX8S84aMGcdWqx5HURlnjKx5OpdFuumuS6zPtsSbwXSk80ZCUbYxiK45dpkUJhRL1Bmx92J491T9BnWJW48NxmJHDUvXPpPgRDsAAwUw6z9YLXOJihOdNYIJJoMMjA5fYxdCxpQRRtstGX/59HYvIaGoATpma3dFCBvRl2X6OqY0xS2+iXj9NJyhcYvH2Bedgr+o1oVgZVmiwiOxzUkoOnc65+tz2l//T9tkXUuRtlpHQo7CEzPuPY+vSzN3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2R80KB/pDgx04w4WaLdYANKwckQjPWhwone7hvcQhM=;
 b=kAeJxHSsoF36W0SA3bJeVD+Dm6sL/GHdguy/6QbMMUDgz/JoNATwR7wxH/9OwbgwDQqSv55mipVg5XXH2Wr30snl7lftU5QPLC6xoyI5Yxavu1UEaamlLV/ethbG3fJBBzjIM3S8GS8bDpfn64xxwhLKbdaPlDJigYnT3SGks30=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Wed, 21 Jul
 2021 03:15:03 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::4dc4:47b8:c368:f872]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::4dc4:47b8:c368:f872%6]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 03:15:03 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/gfx10: fix mixed declaration and code warning
Date: Tue, 20 Jul 2021 23:14:47 -0400
Message-Id: <20210721031447.2333109-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-ClientProxiedBy: MN2PR20CA0045.namprd20.prod.outlook.com
 (2603:10b6:208:235::14) To BN9PR12MB5146.namprd12.prod.outlook.com
 (2603:10b6:408:137::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 MN2PR20CA0045.namprd20.prod.outlook.com (2603:10b6:208:235::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend
 Transport; Wed, 21 Jul 2021 03:15:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed1d48b5-e759-4b18-0c1b-08d94bf5bb76
X-MS-TrafficTypeDiagnostic: BN9PR12MB5068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB506891FBF460ACEA80480E87F7E39@BN9PR12MB5068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7S/cJjbEXk6fwIF+yvy2geqOdnhzjtU9oRdb4nscxVi4Yx8MbCnqF0BrmliFYDjgXi47BW8ZNA38PJ+Ewp8jenJfftt7Z4n03nyEabf/7peQ21JpLROAcmof/6x0wyM2jQ0PXUYOS/35pImlYXE6eGA7x3UumVCuLVmXrVkEQIm3ILbBAAv88kDsSZXSZbkxU51JJ0fNHHjvYQNcRy75A2LKpKYiprEqtU0cV1+wb9b7x9nc/JjeVM1u1eqA3aAoHveWtfC1DaP+tRPXCnbGYrUDcuzdtiACaLJNP7bY/GXRxSn94v6teDXvExnMQH1DvwY5CoVO70L/RRUE3fTzYJDiCfZcQADUJ7imTLbsEIfVbFDTyR3ai++h+YbAjq8yO4ew2r40nXiTiWb2QDQAygS4j4TqbEaJo/3dAN2WnPam3UadyrNtypbWEHgNW/ds1j2yDZZwzI9lnmBwada6kxKe3zOJ7YxB8xw89gK6ga4ZXAkCZmLYTijMMMUa5Drr+IeXwGKErXfxBrStSklrLghH5lOlEZEWuLM8tlpgx8AS9YQeWq7N7hqqWdDD9X3p7BEmcYKUtN/rWSrAHezdC7QXQkbIiKvgwBbYQOrIuVvijjAV9+OUYLecVQK4Sy5vJozDt0JXrhjbF1iSs5UcuIYwXOTZ33H2eFcttctWyTl3vUVEJNwt2v+thU5ck5tWS8irXAHTQXakpiSoNfiuNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(1076003)(186003)(6916009)(2906002)(8676002)(4326008)(5660300002)(6486002)(478600001)(52116002)(26005)(6506007)(86362001)(38100700002)(38350700002)(6666004)(8936002)(36756003)(83380400001)(66556008)(2616005)(6512007)(54906003)(956004)(66946007)(66476007)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LFY69Botb8D5KXP5OFEHVlMkkmCw/BPRaOmeODxXZt7Pyz1IMKnet+5pUnLv?=
 =?us-ascii?Q?RlZT76aMtchO4XQrrQJEIs/rafsZ1Kfhw/6MVXy4VD1fQJKznwTxyZMYVTHl?=
 =?us-ascii?Q?rgqg+zxNIdPa41Zh/rWIax6dNlkfvqqRLBZEa+kqn4fzBs8Pkqg3knyZ6xJp?=
 =?us-ascii?Q?OrkyBVZEuuHUIckgRX+yuayN8Wtxdi2bp7PMY82F7HuqHitihr2RhMf/o7HG?=
 =?us-ascii?Q?v1Y01IahruT8MXOKrSzcTFKq+4SADt/IRrBuGy/RL+97l4PCIWur+hcemtGH?=
 =?us-ascii?Q?0nzXvJhMkQQrIngi377ycuG7Uh64DjF0lUSVQV8mizT2HGAiTR1PEbV4ZrMq?=
 =?us-ascii?Q?q0iGuhFMxcRizAziPJhqhLfQJgkesFeYvAdTgj5QQc+A6SfuKRNGfAebFXaD?=
 =?us-ascii?Q?UQT2Rqc0UZHZDnoxA1Ll7GdjMnWe8IKCcjjGyFyc1AhPd0S7aNaR+yLe4tq2?=
 =?us-ascii?Q?kGp7vD4KBwMOs3Kd5j+QC1XxSJwiSg4G+xftlEQ0XNGXOMSNI6jcXrB4smhc?=
 =?us-ascii?Q?dMBu1WaT8FQ9JZszW4YqV98f+u3z5ys/lcjr7FVltXSJmvbsBy6fxgl9+ohp?=
 =?us-ascii?Q?LXfk5UpQt0UqDGoT5jEqIpbl71qnP9+EGrBbhJlwsv/tnEg45ScpYobEEJMG?=
 =?us-ascii?Q?crWK7ByqXOV4KJJBQUiUD2aykHcQhE+RLVAjxb/idgy7zjh9iYVXgx9yQaBD?=
 =?us-ascii?Q?Xd7mKYtOAaBJpcORsl7yYlM+0DiBTema79wPHqoOja/RQ4FKpnn1zSl6EoOD?=
 =?us-ascii?Q?gu4mYfZkZtz7sxJv7g+3TbTuo+7cP7DWeWIl0r1S6owR+b7Pt9ydpP5bXSK0?=
 =?us-ascii?Q?w3cbeNJrJogJp514PxJtYNQSxRpQTSYRi/qoSpeaomUOmPNKybszuOKErGyn?=
 =?us-ascii?Q?Lpj8aug1XL7UsOsUWDxBb48qN5F+aNszkdthKkfMNudpO5dfvSaztFeoGg2I?=
 =?us-ascii?Q?Hi5DuIZ30D3pJpF4FXkhvjdxlQgC411cS+URxgU0bD/tQs10gIos51TBvZ8e?=
 =?us-ascii?Q?DW1uTiqRraxkE53vzyGq/YozhsQRuEk7vMuzg4PWpuhVGWaP4l2b8Ui7G4g1?=
 =?us-ascii?Q?t1/eLpsCbnH2IM+8YZykjxjNuhrGvk38Pwbkp2MYkY/PqYzL6/j81K59Bb9W?=
 =?us-ascii?Q?w50OwE/EepCGTpCVVQUj998dDeovx5wlD3/M0SpPVQWqFDWA8PvD+JaHZAE/?=
 =?us-ascii?Q?VqyAS2ZkHUVvvSw8S2qWssYhM5BuW8ARFu3zQfL7X6FYjCTJzJQ9g//LoOfx?=
 =?us-ascii?Q?EUr/EAhwTUoMyAWIZhHqA+zFRpC3DyGGitAnVGxxN3KBSkVyY1xjYBSlYd4c?=
 =?us-ascii?Q?UXvCUdY5xjAePfZUquumgIPF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1d48b5-e759-4b18-0c1b-08d94bf5bb76
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 03:15:03.6789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pegMGVgaG7lL4QiOp1TFCfbEkhqN7rHNan61hFESz1PFfu+txBCDIhqK3fCCJJ/QkxkFeTGabaBYysZzNb57+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5068
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Roy Sun <Roy.Sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move the declaration up to the top of the function.

Fixes: 631d55e089eaa8 ("drm/amdgpu: Add error message when programing registers fails")
Cc: Roy Sun <Roy.Sun@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ca06fb137cac..d102cfd36ba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1493,6 +1493,7 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32
 	uint32_t i = 0;
 	uint32_t retries = 50000;
 	u32 ret = 0;
+	u32 tmp;
 
 	scratch_reg0 = adev->rmmio +
 		       (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0) * 4;
@@ -1526,7 +1527,6 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32
 		writel(v, scratch_reg0);
 		writel(offset | flag, scratch_reg1);
 		writel(1, spare_int);
-		u32 tmp;
 
 		for (i = 0; i < retries; i++) {
 			tmp = readl(scratch_reg1);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
