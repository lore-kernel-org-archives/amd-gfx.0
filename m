Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37997C43461
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 08:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49F16145A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 08:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49F16145A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508F76EB59;
	Fri, 23 Apr 2021 08:35:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491306E107
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 08:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDQ8+0+BbJUQ8vIorkepk6pV82Wsxi5T4i68Vw/AXHdPRMNpAxLDxm4p0ujnDa1bZumoPvjI61nUvFLPRKhLLajcZgJ/jES+DFX51+ZQKqMoZ3HEQ13dckQdmGmmE3THSoknXc5z8yoBjYcIHnjn4A+f9hD7wlHvvhNQCo2cCuY7FOYsiYCvYlBNIMNa/NZUg+tWHY5uS5MY91WoG8ir/qk4HwQokBQoSpED3Ne+u0QwAseLjVuvDmETCoTIgsD14MNVpWP/f1xCJONshOei3GYZw/5uLoHPMwpwXrcJ4NqwbcdG1D1ATWp2erW8IJT2PFcxfuqT5aXMTefxS+vXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1axB9VZeIfvnDp9fCsPjI8qgB8YgBgpsSmqvNVFcZE=;
 b=UIs+PA+g8j6cOLfPSdRlVxSKK/KyAXKTFM0kGAEW03qGbZ17us7g+xC4bRJ/iL0H4DmC/K0wKnnOMXlcoaTYmkeIi3Xjvi0T+5VWc6CDiUKVBigV10GZquIK79A9F8ij/iQhCAfn8g0XwSeuhVdOKFUdV2QvJz0m1tGrL5/2BJfVSQlcIwutyrknNBKFYvTV7QzT34ew67Aqu0KopkR5mOyT/sConqMbSGVj6bhzMJpf116IcQodFym5zx2o7F5kN2xFfW4Yk2WTD9d8YB40xe873ju2CiK6UXCg7lxhGmthFu9p954lfGtOqzOnUcNO9U4LlLPqd9gGgv7Tjsn2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1axB9VZeIfvnDp9fCsPjI8qgB8YgBgpsSmqvNVFcZE=;
 b=vMYT4xXURveE48u3yQmZSXXOwaerQWrNrf9qJHi3OJKFZpr+Iv9zth8gdjEg4uyczbxFm13EhZeBpRd3/YwFMe1IHAik4Z1f8hF/ozZLErnoiGYi0EvzLscDyZ7BeryU094r0+zv73vqWyB6mtgrQHZJuKb8NgbDjeWMdfl7XXc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1518.namprd12.prod.outlook.com (2603:10b6:301:11::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 08:35:08 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::f07c:dc0f:e7e8:416c]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::f07c:dc0f:e7e8:416c%4]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 08:35:08 +0000
Date: Fri, 23 Apr 2021 16:34:53 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Enable SDMA LS for Vangogh
Message-ID: <20210423083453.GB1539761@hr-amd>
References: <20210423083010.185478-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20210423083010.185478-1-Jinzhou.Su@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:202:2e::23) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR06CA0011.apcprd06.prod.outlook.com (2603:1096:202:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20 via Frontend Transport; Fri, 23 Apr 2021 08:35:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de5290fa-8b10-4036-5cb0-08d90632b37a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB15183F99CC62EEB97AC06CAFEC459@MWHPR12MB1518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c5j/DuXeWwT4bcpyan+B9hiUS+YhiQYC5Y/w/q1GDB7BPgnCbEzUafCC6JdWbAefrHR2u3d4PgSqqC1p7DCOgvjWS8d1Tke+jlxUgRonRArizeeZZpHBP9BVP35uc88bx3vHpoHAnmEFPiukSDudCOBzQgu+QDSZzR7lZh/ynx3uQ5Ws1R9LFHYDFF4tTSrqTSUXURT2aZXy6QfgKHNq+zeDdxjfKdgNj9OBDLGpTqkUeG5E1tOa3/yjlE9h1z7v0VQVVRJQxSO0h6SlwQ5cPDvwU2HMN5RzVFbOS7vF6aL0AhIHupW89GZ+k3Pky2yIUR3j1MXZ2EQ0nvoo6fi9eN7b8lZ4cVm50eQSWpFD7nsDqjyCUK1f5WuLLEwFljRT73Wf4UR/xdCx8xpcJSQIdWCSh5oj4eN+L41+jaIxPOR32Mm9ZVvNgi8j7pdFjCGjtkIAn8aOeUkgRGktj7ZvME553N4aA/cuj9ovKNMyF8UrbWjir1rZH3NwdD7TJCnXL0KdzSqFiHgh8/X0ZT7dgbf5WpBwBTNXuVm3e2B/05ekBzaoz9spBCCzE8Q/COM8lr1HfddBY8um10omZsscJcwcEUxky2caQBmg7Rz+Bh2pPopKEm3kFq+PnOA/Jh3qrIylgUXf/Bm+IO5YYskM0IJNhtsfrbLf5LMjmMcn9w4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(38100700002)(186003)(26005)(16526019)(83380400001)(33656002)(8936002)(52116002)(6496006)(38350700002)(8676002)(956004)(316002)(6862004)(66946007)(6666004)(66476007)(5660300002)(66556008)(55016002)(2906002)(33716001)(4326008)(1076003)(478600001)(9686003)(86362001)(6636002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?v5HftIrbmb4y5VX5qk3jIX52OuDZ91FdEPYl1XPaz6N8YcVc5Pe2A/Egc6+X?=
 =?us-ascii?Q?fKmaIIyTLDnf98oibxNoYZ+BMT7ReAqCthYAnGucOBZpPZpFDqvGqjBx/dwJ?=
 =?us-ascii?Q?f1Rd45/T9Gthq53EbCYurX6bcgjTo3IqXBV9uCoif74WBSxfZ/WQN7d+PiGj?=
 =?us-ascii?Q?ZVOuxpZiw2SidG5aAaVpI36kZvxldvDa9dZd/MrK1rWEHmH/xwk/jrYGj8JA?=
 =?us-ascii?Q?Grk2Ok8Imrq98wHjT5s44kC/8msY0owWFUF9UK1bkLQV43afsiRMTOciGGlw?=
 =?us-ascii?Q?R1kbmR/4LhrXTSz8s5PrvWfQYnX5OwMD49bFdkTFBnhAK8INmct/nATpjKT4?=
 =?us-ascii?Q?3NBiAvouON+7Pio7dlsHl+4/R/i1EmJR/+Tp1FRNMEv1QhuI1MYqAIH/4xVv?=
 =?us-ascii?Q?n67Ix4axExjlwdwac6lOQ1g7zvBlROsUuiluWvKLCzcBnXDi2R5j/ZBmDL0x?=
 =?us-ascii?Q?P+tfQf4ol54hTpFCf2US7rngFAUkqZwh+A0vxWcuHep49bRZ8s/6RNy0BRH3?=
 =?us-ascii?Q?+EmAD7eLdRbqxEYXvrjm6JEwS83g9R3EhaAeee4uxYLKvPCU6NE9Y6zl08HG?=
 =?us-ascii?Q?eP+KKLl+Ev5hMedU17PgBJxv4INRoLb9+FztHtrW77PwDqih4mmlMekQIe0k?=
 =?us-ascii?Q?EPB2ZYveS9xj+5sugGxYKvc3SVHjK6HJCkhvvjALpypXP8L+yxUY8Txg+Dg0?=
 =?us-ascii?Q?11T7JFVgJ4EkPmOC7VqhOiafFVovV5KpNDJrnZUD+pAbMAf/MOusMzZAxC4K?=
 =?us-ascii?Q?Gt/OUYmwCZNrHpgoHEFHTUyjDWO+yyN3RFNoDmCZPs4wR62SOCwFG8n45WZY?=
 =?us-ascii?Q?BKvUoQBXOBb7r9aB1lw37zJX7wqJByVz9lwbOOUDIRtuG3MkQh4ve6NoixP0?=
 =?us-ascii?Q?rxArY/5KoyEe4gtyBFrCNT1kl8/SL/n7ex90hgblitXSQZeSI0XfRci9/pIe?=
 =?us-ascii?Q?LmGmfHs8VJ1x55dhSJ7tvci7ypOLWhkZl/h20TsPydGZdNyN9vU2dPhuqS+1?=
 =?us-ascii?Q?K7kG8yBW8u+FE05usYEgXyH4R37B/SmIHtkOYv0nYX5W7Tlqhm/IgMIbxZX2?=
 =?us-ascii?Q?rQNsYj5xHvn4wRF4g7Q232NznX/x3njnSWdhXYYAz0VpxxcOX0crcy8yeqoE?=
 =?us-ascii?Q?PWgcEo67Ng5LytSkavbFs0U4hGSvKXK31YDHvUE6Emgi7w3ayrGAtmPtd97a?=
 =?us-ascii?Q?STss8zDxq2v7gC2fA5MvbvYeTqNSq3FrebZSP05n/ShQD/Fl7d6DY/XAJPnY?=
 =?us-ascii?Q?qJB+303ZSKEE2yZ5fQYMcYj/seNn2qdKx1L5rd/RDEJ0pEmrb+qkhY563S+h?=
 =?us-ascii?Q?gTddReZPGxR9mFqW4NEmZqK0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5290fa-8b10-4036-5cb0-08d90632b37a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 08:35:08.1466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5sUea0kWytp9tGzQe95/JStYZNeqIF9i3DxYsBPrMuZSp+aUlVjTrZiMkj0RTdLS8W6IRO0z7YUZ/6+8i13Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1518
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 23, 2021 at 04:30:10PM +0800, Su, Jinzhou (Joe) wrote:
> Add flags AMD_CG_SUPPORT_SDMA_LS for Vangogh.
> Start to open sdma ls from firmware version 70.
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c        | 1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 9c4f232e81c0..82a380be8368 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1121,6 +1121,7 @@ static int nv_common_early_init(void *handle)
>  			AMD_CG_SUPPORT_GFX_FGCG |
>  			AMD_CG_SUPPORT_VCN_MGCG |
>  			AMD_CG_SUPPORT_SDMA_MGCG |
> +			AMD_CG_SUPPORT_SDMA_LS |
>  			AMD_CG_SUPPORT_JPEG_MGCG;
>  		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
>  			AMD_PG_SUPPORT_VCN |
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 4ba7fce4c0b4..7c4e0586e26d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1593,6 +1593,10 @@ static void sdma_v5_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
>  	int i;
>  
>  	for (i = 0; i < adev->sdma.num_instances; i++) {
> +
> +		if (adev->sdma.instance[i].fw_version < 70 && adev->asic_type == CHIP_VANGOGH)
> +			adev->cg_flags &= ~AMD_CG_SUPPORT_SDMA_LS;
> +
>  		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_LS)) {
>  			/* Enable sdma mem light sleep */
>  			def = data = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_POWER_CNTL));
> -- 
> 2.27.0
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
