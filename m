Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00FCC33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 15:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13F320678
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 15:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PzrWkScc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13F320678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4803B6E101;
	Mon, 13 Jan 2020 15:59:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538E06E101
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 15:59:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C90eBfHwEyuPYi9ym9ZsgmeVt18SnfgoWVjB8ozc30+aG3At+OqjpRzI7orXxn/s007S/bz+2oqyQ2oKxskX6evqWOWV2ZR7nVOgSz1pcGpPp7f6Id/MXyaKlGgTMueOjli6wIBfjWhyVN9X3gvNqFPK5vi/3IJusLZbGedVFaXY5j0L2GgV1dHR44yBq21qLRgrgrrjwoosm+xYl24aXJHXxghBUUUZGWzhsi7skAmFWWo3Tjhjwbsgc+es+0IehAHv2tA0hArsWD4fxAz0KsCk/xj0jriNcPbIj9bc+BGFarTAFFKOlJmb79KjICDq7PQ1cVqmpuxroEhVWx0teg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUZwATkXPomdmifBIFSisQOABAszkEq4J8aHR/76en0=;
 b=iWdH9jCjmLgRf9V9pAiGNvH43hhCHC4Z9fia/dC/URfSc3z+F8QVhqRtjTPBM7OfJqX4G+m2K56H5l7TmDySwbQu+aRvxJjmwhyMEKP+JLrVaKlP9HeIhOTdyO31DpknRAWvtAzY53qGDdNwndbzrbDfTm7GcHZXvi0xLQ3j0CTfsyl0subV2D/Mseic484EkSJ3JNw4D7emRBa0N0jr6c8EzoGBaMcvgI2g8Q3lkXDceYJK+4Tp5VvhbVemPsbH+PVhsUSE3tuJIeHD3nugrlG7vEmopQdRToCFCqlxskYHv+6+C9ij+VSlo8tYjMcc8X+Jf3dtgxFe5VoJSi17Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUZwATkXPomdmifBIFSisQOABAszkEq4J8aHR/76en0=;
 b=PzrWkSccraWXXEp/6dc8ZgS/6YVyZHMiVEoh8jMtBXuthw14Ug37fkVfzfv6fHbuDEkrQecNNBcYCp3ymOrKd+Ofsr9HVdRYY9aY0vrroJ35szhKi0odOqL+ifHTwuLa3o7/BO/zSRL6918PQoTc+1sfxPUrCSMoWrAiblguTrc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3902.namprd12.prod.outlook.com (10.255.238.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 15:59:01 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 15:59:01 +0000
Date: Mon, 13 Jan 2020 23:58:53 +0800
From: Huang Rui <ray.huang@amd.com>
To: chen gong <curry.gong@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: reading CP_MEM_SLP_CNTL register using
 RREG32_KIQ macro
Message-ID: <20200113155852.GA4057@jenkins-Celadon-RN>
References: <1578910582-4505-1-git-send-email-curry.gong@amd.com>
 <1578910582-4505-2-git-send-email-curry.gong@amd.com>
Content-Disposition: inline
In-Reply-To: <1578910582-4505-2-git-send-email-curry.gong@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR02CA0141.apcprd02.prod.outlook.com (2603:1096:202:16::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10 via Frontend Transport; Mon, 13 Jan 2020 15:58:59 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a8120ae-176f-4b52-3360-08d79841818b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3902:|MN2PR12MB3902:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3902938A8EBDD4DDB4BC87E6EC350@MN2PR12MB3902.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(189003)(199004)(6862004)(26005)(33656002)(186003)(33716001)(1076003)(52116002)(6496006)(5660300002)(16526019)(6636002)(4326008)(316002)(9686003)(45080400002)(66556008)(66476007)(6666004)(956004)(81166006)(478600001)(966005)(8936002)(55016002)(66946007)(8676002)(2906002)(86362001)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3902;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXcOnhGZ7ZzQFmbNNgW2LihGK8rUJKezU1YJu6AA0H3N9lgM02dyHfpGONXeBDgoU6Ktdm/IEaqpIe7vXkuqM84N5Eel0fGrslw784yS7Sgqzdv8Z3dxnRa02N9T5xu6hBCocg+OBwcrkOhHQO5EAC8brc/Jcm4RwjF+ffe2kdu27EfGcpbwqlFF5pGzkKp6uhCo+6eQhUZ24AzYBhlH23zhs8+khwwQSp2FyQIlnh5n/06NH4bpERljJ+apdr4qkWhXdpU6rbeMN55EicmcNTQK4HmPq46Wjipd+mRzMTRGKzlQBW59n0DLOZ/rWxkGU9+9M8mQ8g5j6y8Yd4RTaHym2LZ8bpz15DzKDiUrmVmUJjAgu+lCI4zNaV4Ilcw3Us3v5QMAmz3uppxSxZCbHwnQESy+qsm1DoKa2lk//rxmLTncmZqzf1P8GBa2gHY8b8R9WYL7KRCh3Dg2KtXRsPvj6OZmBoTb6KQxN8XG+t0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8120ae-176f-4b52-3360-08d79841818b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 15:59:01.1433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOmnVMfouqAHp0M9sUgwv+0BArQzZUBv+zrI5BiHXRTwCp3cs3K6MkHuKNV6NBmR9HCcDIkrkg0TqEbnPcWFHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3902
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 13, 2020 at 06:16:22PM +0800, chen gong wrote:
> Reading CP_MEM_SLP_CNTL register with RREG32_SOC15 macro will lead to
> hang when GPU is in "gfxoff" state.
> 
> Signed-off-by: chen gong <curry.gong@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e3d466b..a666086 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4702,7 +4702,7 @@ static void gfx_v9_0_get_clockgating_state(void *handle, u32 *flags)
>  		*flags |= AMD_CG_SUPPORT_GFX_RLC_LS | AMD_CG_SUPPORT_GFX_MGLS;
>  
>  	/* AMD_CG_SUPPORT_GFX_CP_LS */
> -	data = RREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL);
> +	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmCP_MEM_SLP_CNTL));

We should use kiq instead of mmio access for the whole
gfx_v9_0_get_clockgating_state().

Thanks,
Ray

>  	if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK)
>  		*flags |= AMD_CG_SUPPORT_GFX_CP_LS | AMD_CG_SUPPORT_GFX_MGLS;
>  
> -- 
> 2.7.4
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7Cc8b2a8c2091f4336ee5708d79811af07%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637145074034487948&amp;sdata=emUuTvGn3FGbQGrIs%2FkoR3d0YAQYvHUjBqA5cYlkL2g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
