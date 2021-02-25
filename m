Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D721C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 05:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164BA64E6C
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 05:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164BA64E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 867756EC42;
	Thu, 25 Feb 2021 05:46:44 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760043.outbound.protection.outlook.com [40.107.76.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 317616EC42
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 05:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbTBRbugYLUWwg5K/NULkwmVNCgo8XkbSO6z4u+pJ1PRmATMdmhzhTiuKVmG9yNiHdKnefBg8NSVola0GJ6P9+exItP8sh8OB4AJsg+DPdt5LYpUyT0W9ZevlXk6zOVKcge6iabVMWTurPh6cnifQtdDiyat+KmmbUPA4nUexU8HaVLXWTiSHjmStvKQi+Pm3UBUW4U5IF6o4IR1rXy4fBxxqWUUZDad9N7kZRtyV8DGM5/gUwPoaXko+yoUm8t5taDKbgasXxcVXz8JbgEa73OYhGy9c6S82VrbKnLMYkatHfpzY+aEHM7uGDP/hUlkDEAzr2TLq0VaptXlyxtRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26MMt2mnyKHs9f1irSX4XxfPERC3NCGKmKKPCyclW0U=;
 b=Ksp8zoe9igeJ3GopDFPqdyD4v3IhnIJfN0xu3zOb3XIoqbQR7uLYRGO6QNzBEAez+HG9AAT1bNG15PpD4wp/Y/xC0CLZ2S6BUP9w51YvSyboQnzkGJiCo0I7tVvTu2nE7FA/wWI1BngrCFvGIB6NFV+Km6UF2wxSaMaPr1RGb49QTL+XbhKdDN+qq8p+m9FZWauiR8z+WPCbq3vDa7eG/Q9Bkpvrho9EWHXUql7F/YpsoPHfNnYR8lOg3HG0mvbbyfbB5Aybqa4upiLgIn6o9/DujDcPC+BFYMepZjX/7HIkFayEvS5FZLwZMZvC3ZDS1MmdaTqggjfoBQihhfVZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26MMt2mnyKHs9f1irSX4XxfPERC3NCGKmKKPCyclW0U=;
 b=oEzJdz+Z/FSwNkwtBASvDrOd2j36vC52PuBaIkGUUxRvsxdJrE6fDBwDsUDDDIGEJ7bzhQFr6LOYc2fN1086XWY2yFkWN/wqpdehgt2dFa2Bpp19tkSeM3dDx/hf03z0AXOjmIlDrzC6sHYbR08vxJ67vB4wbmc1VChPu0HrJxE=
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MWHPR12MB1871.namprd12.prod.outlook.com (2603:10b6:300:10b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 05:46:41 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::8d82:5144:c5fa:ad51]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::8d82:5144:c5fa:ad51%3]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 05:46:41 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: decline max_me for mec2_fw remove in
 renoir/arcturus
Thread-Topic: [PATCH] drm/amdgpu: decline max_me for mec2_fw remove in
 renoir/arcturus
Thread-Index: AQHXCo0G/9d0U8VLyUukS+qve72iQ6poXN6AgAABGUA=
Date: Thu, 25 Feb 2021 05:46:41 +0000
Message-ID: <MW2PR12MB468435B33E38EB49B3C86221FD9E9@MW2PR12MB4684.namprd12.prod.outlook.com>
References: <20210224091055.3410-1-changfeng.zhu@amd.com>
 <20210225054221.GB587137@hr-amd>
In-Reply-To: <20210225054221.GB587137@hr-amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-25T05:46:31Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=152b899e-2ad8-440d-a54e-0a8c5ad0b9ab;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: My manager approved sharing of this content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef95c79a-3cb5-487a-4afd-08d8d950b9db
x-ms-traffictypediagnostic: MWHPR12MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1871DB8CC1C62837F819A277FD9E9@MWHPR12MB1871.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jZ2gDvZWAenpdHp8Wy/ACjC3Vh6h8CIQASjYhsrYkY7k1GbAc3LE/UzLjZixYE6NgbP5K/1b1lvXBqnDEePfyzopjCwDWhHWaND+PHwH8MiBfPx4BGrOtfgjl0aZTJDdDv178vf7REyw8379hDN83iMZ3cjW3RgBQxTVjD9trm19TLrCL1wg0OG+0NWSFJnMXhwlS523p+/FjZLBDBWZYlQB6OzGwjqArQn1kiQnlZbmj06j6kC1m3rmAT9qISo2pJSCzbCjk6yzIJpwYRpdAfi6PANbcLuOo4QOkLxyhR4Nzss3uSLXhQZObLr4qzP0szEQdrMNXKLSqQv52pHpBmlNaS4Cs4EOhCQdO0OS1Tfbu4IcORn16MhIrpg6M6VuNlSSlndgLVypmZN9Spuf6WWRNQltaMC5VmE1PA8jGNN1VeRlHTyf4yuhKl7G36S40Md2T6yd/Z6x7l0k32fsiLg5FggUczVKxlPIAt5FVlXCBk+led0whtGYoqAZybDxwI8wYLyMxfkiZ10HWp2Meg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(186003)(2906002)(26005)(86362001)(7696005)(76116006)(316002)(54906003)(66476007)(66446008)(55016002)(33656002)(8936002)(66946007)(52536014)(66556008)(6506007)(53546011)(4326008)(64756008)(9686003)(83380400001)(71200400001)(5660300002)(8676002)(6862004)(478600001)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?37wnQ/1rQ8J89VhqWX7aQyqAPnHmQGhUeO68ap0MFcyYzMRtfYhJdf2HF42t?=
 =?us-ascii?Q?gUakr8Ng46AMkbZ0gmEIV6PwA+HxhaSH/BlUTd5q/CVgzaTnHSXA1qyu9Wue?=
 =?us-ascii?Q?KqgZ/MFrQ0VsRZyN+JqPt2nYFpCaYVuRvnL9IjzrnJzOVfTJQAQwPB2KhWkk?=
 =?us-ascii?Q?w4oFq3lkTtBYSmjIUpFG3lrk+cJPrbOSouB3xRa35WVZeg1ZVVF0yjVPbXgy?=
 =?us-ascii?Q?BC7sjcednDD7BA/X4rC9a67erzRo7WamMkYT/Yl/IwOqitrFy1wdZ9DrTtPr?=
 =?us-ascii?Q?Afikwsybbu2eLnB6nRGoLQe5DI72rzn9+9AxVtnu2y6SV41hGGF3X7HyX0/j?=
 =?us-ascii?Q?v5hb+M6luPduPufcqfsMXoILuFxSCua0PwAFKD155ICwQd9jy6TghFGMt7kI?=
 =?us-ascii?Q?v25Ux1Rkr8lV9vJaqpW6J/9cJLGl2NHJUwDSsSmXFTiSfLuwAn2y3p3fd+he?=
 =?us-ascii?Q?1Y42yMMVvu180zp53Z6RngNiLv74ZML2p5uKFFx2WSxfh/tFM+TE4a3kpXpy?=
 =?us-ascii?Q?GhnHAcN0Twq7pHcrH/8aldbnvm+Ue28tw1tdkqSp6iOzYxNXtQEkgEY3Zyas?=
 =?us-ascii?Q?L0Zp5jMZUNGAfmQadvYO015pTynis6tztWGR/VJOCCq47AqHlww67IxE98d9?=
 =?us-ascii?Q?XdV+KMFSyx8t8jMWBFKhKvWQ4mIcIlC5SypBhdB5rWxlCTSDLT44p4aZ1I5q?=
 =?us-ascii?Q?MzahUXCnGQ43R8ObJLZwzsF+ycEZ3iBtJyuUQ3GKUEAJBmqoKx472avbB59X?=
 =?us-ascii?Q?R3fw21FZhHaOTD/4hho2ILQ2KCyw9sg32GGwkYMheHx3OJY9iPVf0D7ZZxbp?=
 =?us-ascii?Q?s9jr7AWxwpW72Mc6ZHQIhWVcmpcFXgic0RtT+FCoKpaD+9MtNorvhoaTOG3a?=
 =?us-ascii?Q?PcK6wuRVu3PNo/iKCCkLJbYAZrc95wLyP+3UptVCsA875bRWKRNPVG+5vmTj?=
 =?us-ascii?Q?a8TzpItstp6S4YPH8aKS3tq2yD0buDNdr+uMtZwwOgXYrites/tOIa6XuLra?=
 =?us-ascii?Q?ku8VYQ7/Ce1EYM/JVVWLrwFmTlLzGPOFx2KbyrM4tQtLhlcvv6c52jzbGQrv?=
 =?us-ascii?Q?IAtCiXbdj+d10nfJwOa0nBFq/7tj3reP7361RhxKkqyX+HN22Jtt5mRADRSO?=
 =?us-ascii?Q?ltH7/rz8+WDauKBuEqa36VLrKLLL1G2h/RcglXkFZN+Lw7ufxCBT07vuos28?=
 =?us-ascii?Q?ywktIycrzHEsjhg00nE4RxpsJvAW6DRRBodaBYbOlyH8iICSLdEWI+1k4CDL?=
 =?us-ascii?Q?HFSQ18WyALa2Y1PI0iT8PINFO4w2Zc74LjVxS6AAZ80qP582isu39DQi8g3/?=
 =?us-ascii?Q?MeFpGpqKmL9yKGMKirk86R58?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef95c79a-3cb5-487a-4afd-08d8d950b9db
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 05:46:41.0703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AkLzbL+Mkz7xkVhrlCe9kf32YO6qT/Q30RQCemDPQP5FEEbBrEKaBAuTvVgHzP9f1Es4g4n957fyMF95UbdvcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1871
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
Cc: "Clements, John" <John.Clements@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks,Ray.

BR,
Changfeng.

-----Original Message-----
From: Huang, Ray <Ray.Huang@amd.com> 
Sent: Thursday, February 25, 2021 1:42 PM
To: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Clements, John <John.Clements@amd.com>
Subject: Re: [PATCH] drm/amdgpu: decline max_me for mec2_fw remove in renoir/arcturus

On Wed, Feb 24, 2021 at 05:10:55PM +0800, Zhu, Changfeng wrote:
> From: changzhu <Changfeng.Zhu@amd.com>
> 
> From: Changfeng <Changfeng.Zhu@amd.com>
> 
> The value of max_me in amdgpu_gfx_rlc_setup_cp_table should reduce to 
> 4 when mec2_fw is removed on asic renoir/arcturus. Or it will cause 
> kernel NULL pointer when modprobe driver.
> 
> Change-Id: I268610e85f6acd9200478d0ab1518349ff81469b
> Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 2f56adebbb31..300a07227597 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1890,7 +1890,10 @@ static void gfx_v9_0_enable_lbpw(struct 
> amdgpu_device *adev, bool enable)
>  
>  static int gfx_v9_0_cp_jump_table_num(struct amdgpu_device *adev)  {
> -	return 5;
> +	if (gfx_v9_0_load_mec2_fw_bin_support(adev))
> +		return 5;
> +	else
> +		return 4;
>  }
>  
>  static int gfx_v9_0_rlc_init(struct amdgpu_device *adev)
> --
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
