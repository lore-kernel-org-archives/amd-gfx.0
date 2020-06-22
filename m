Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2913BC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 15:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBBD02074D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 15:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mmGGTL6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBD02074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B7F46E854;
	Mon, 22 Jun 2020 15:46:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 433DD6E854
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 15:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=il97uQOHUPuMN6LcLHmuW9rR/ZOGpFeMj2Ht7SFrCkXyJ5UATNFah69Q+gfgG7AWmIaHyQ6KWaha/3sdso9IGZXtjJ+iINtEHFSJTU2d3jM7Ca4GwJP67oMy+lpzTbNZroppE2Ih0VjItEs2dp3+gHNBpaxpGZ58BOg3klpDPeoaR7xq0TgO6+8z8t4rR3y5HmJ16SR7JaKdYwJTn19uuMEFDDmsIXMeYf7RO/myC5F8u74Ieorf6tX/rKGVbi0c2u12aZuPl7nygPv0uqMboHjSXg1BLu5tE4fi2bhWc9zGzZE5OOHAJ8sHC1ttXxzR1/Wh6i5GL3DWLo9+oaAh3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGrrQjhZ4J7Y89QvE8DLiHpfCkxvOgK9nGtVg9Md0Wk=;
 b=J2Qi+ZHadLW64W4VaO7QSMaLkevvlZwbsc1HGv4ozAnu0oT0yXadrKh4V5sQfPeQdYq7SriNw0G0ZQoUMla+jbOOQrlvt0xHI+E+dseD/+GVeqyw568Bp2QVuXEiv6sbB66IrIv7ls473FIM8/m09eWpcKAzx2+08jbff+Y2CZeBO8YYVgZ0IKosOfKvvzPtOdoBILon7r4ZQB594okykpxwgwBhozVIHAwM8NziPs7LdbAoGxw4dwP1mzEpAFnu+HupgWQWPzqe9T0nWRYjEglQFJRYUHfcejXvl6ldspgZdV4bejGk+EWKN4WqJPjLnBwHWeiK+EiiBYsXBxT9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGrrQjhZ4J7Y89QvE8DLiHpfCkxvOgK9nGtVg9Md0Wk=;
 b=mmGGTL6a/aXWYsPpzjaYGisQecreZgDfxchtzhpwX08YOfD4L2c0ivlm0wZtXeCAF0owVL7aFLf5eRDkCK3MpCxPpzRfvSVAwZ5VNCFqnN92uhnaC33uH2h3nREJfRpamPiQAhvK7xhkERu+oWiGLIzeZd6M/ghFv0KEQ2nc71Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3778.namprd12.prod.outlook.com (2603:10b6:a03:1a6::11)
 by BYAPR12MB3574.namprd12.prod.outlook.com (2603:10b6:a03:ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Mon, 22 Jun
 2020 15:46:41 +0000
Received: from BY5PR12MB3778.namprd12.prod.outlook.com
 ([fe80::a866:94ec:65f:8015]) by BY5PR12MB3778.namprd12.prod.outlook.com
 ([fe80::a866:94ec:65f:8015%6]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 15:46:41 +0000
Subject: Re: [PATCH] drm/amdgpu: backlight rescaling to original range
To: "Chauhan, Ikshwaku" <Ikshwaku.Chauhan@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20200616214958.120051-1-ikshwaku.chauhan@amd.com>
 <MWHPR12MB1471F9307450227A9068B0049A970@MWHPR12MB1471.namprd12.prod.outlook.com>
From: "S, Shirish" <sshankar@amd.com>
Message-ID: <333fe01b-0af3-41a2-15c5-0b8f22329e7d@amd.com>
Date: Mon, 22 Jun 2020 21:17:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <MWHPR12MB1471F9307450227A9068B0049A970@MWHPR12MB1471.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: PN1PR0101CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::17) To BY5PR12MB3778.namprd12.prod.outlook.com
 (2603:10b6:a03:1a6::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.85.182] (165.204.159.242) by
 PN1PR0101CA0055.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Mon, 22 Jun 2020 15:46:39 +0000
X-Originating-IP: [165.204.159.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca397c25-11dc-4a83-10e9-08d816c3751f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3574:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB35742640321CC4A0E6AA99C4F2970@BYAPR12MB3574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 84ETRi07FTJLTZ2ranLwhlfID0DYGtbM4cqR11Ze+2IUESMI2BRODnhP/sLqtyKpnGrf1eR4lowr/gDYfTKZTB2ZlTV1opaU+1McfJxj8sI+SCOmYP74O3DaEVkC6YVEcDTQ8OufCIK9J194Ad5xAmeTQM6cwiT8RQpb16quT+lei5KtsNjA3m8vlQK9VNxWIjbX5n6yMvu9m6qYk9d4P9E2ZB7k8ze3ymNW4EitdPwzBqwGzEUfSnKyIWTl3StldTyFpbO/VN2vpBTGDsQy55dqVxAW9KepoqEHJgjLigNYKvUcfg8t93GGsU4E5MWvhsdsJmvRdSy6ZdP03Wj+dSQIsZ74UH9VHfxv5pPhbHr+Q/JDrHqi76BKlQi5huccr4m9eg9BqorD2dTeVbR1zGJi0PV1dvTTFO6CuqIQM3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3778.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(478600001)(31686004)(6636002)(45080400002)(66476007)(966005)(53546011)(52116002)(31696002)(186003)(26005)(66556008)(8936002)(8676002)(36756003)(5660300002)(16526019)(956004)(2616005)(66946007)(4326008)(110136005)(16576012)(316002)(6486002)(83380400001)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: icx7EkhlexvgvzIJuNBoxKLb+yjcRyOex4uxVltfx89SCv7KPRSE3uyR8S2if68wJWdS3vghbbHX2NGgftEKsQVYvqCgozsB0Q1Vfnh42qAQfwPCPCecVYWkABaUMwdMC9eJTJSnHkW1JYOAzIDiazEGrKkX9aMqjzVi1ksWin4MPpiXp55yp6yUDsvqEDqhb5fxJD5ysObgLPb548VELiDWFjKRvtOPj3IS4Y2UdNb3PAgWTAl4EvHQJ0YE3gSr7kxrQ9KPbevN7VS3H3QsAeakOFIiAKp/sHraRjeFuMAFPZJoaOgAqn0o66tRj4szcqpsGQVQGycVWyMjK0+HaB5MUpc2T1Yxhz9geMDu0hQRgeKWizGT23rzGy36GLk0s/Jv+iOSO4VZBMd0Z03xe6ITC0+4dh5sYmL+4qt+e8vw4cz1Dm7rphJ2HvOHpfDfKKvMuMEJ7JV42qYMv401ym+L0s062s8NlTsuTNQfwSM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca397c25-11dc-4a83-10e9-08d816c3751f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 15:46:41.6296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaHp0xBierr4guKTbmI3+AXJRT+TqhqS1d/ChErVGSNYjPAvKVXUdKQmxGj0R/JSbdiyKlk4ND9aoDMSUiipOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3574
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some basic nit-picks inline.

On 6/22/2020 7:34 AM, Chauhan, Ikshwaku wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Hello All,
>
> Could you please provide your feedback for this patch?
>
> Regards,
> Ikshwaku
>
> -----Original Message-----
> From: Chauhan, Ikshwaku <Ikshwaku.Chauhan@amd.com>
> Sent: Wednesday, June 17, 2020 3:20 AM
> To: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Chauhan, Ikshwaku <Ikshwaku.Chauhan@amd.com>
> Subject: [PATCH] drm/amdgpu: backlight rescaling to original range

Since you are touching display folder, the commit message should point 
to "drm/amd/display"

Also the commit message is not clear, can you correct it to reflect what 
this patch is doing.

>
> [why]
> The brightness input is in the range 0-255.It is getting scaled between the requested min and max input signal and also scaled up by 0x101 to match the DC interface which has a range of 0 to 0xffff. This scaled brightness value is not rescaled back to original range(0-255) when we reads it back.It returns the brightness value in the range of 0-65535 instead of 0-255.
>
> [how]
> Rescaled the brightness value form the scaled brightness range 0-65535 to input brightness range 0-255.

Please provide a sample output of backlight set & get values with and 
without your patch to understand what this patch is fixing, better.

Regards,

Shirish S

>
> Signed-off-by: Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 40 ++++++++++++++-----  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  5 +++
>   2 files changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9ab0d8521576..73b0a084e893 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2881,7 +2881,8 @@ static int set_backlight_via_aux(struct dc_link *link, uint32_t brightness)  }
>   
>   static u32 convert_brightness(const struct amdgpu_dm_backlight_caps *caps,
> -			      const uint32_t user_brightness)
> +			      const uint32_t user_brightness,
> +			      enum convert_backlight flag)
>   {
>   	u32 min, max, conversion_pace;
>   	u32 brightness = user_brightness;
> @@ -2901,12 +2902,18 @@ static u32 convert_brightness(const struct amdgpu_dm_backlight_caps *caps,
>   		 * 0 to 0xffff
>   		 */
>   		conversion_pace = 0x101;
> -		brightness =
> -			user_brightness
> -			* conversion_pace
> -			* (max - min)
> -			/ AMDGPU_MAX_BL_LEVEL
> -			+ min * conversion_pace;
> +		if (flag == set_backlight)
> +			brightness =
> +				user_brightness
> +				* conversion_pace
> +				* (max - min)
> +				/ AMDGPU_MAX_BL_LEVEL
> +				+ min * conversion_pace;
> +		else
> +			brightness =
> +				((user_brightness - min * conversion_pace)
> +				 * AMDGPU_MAX_BL_LEVEL)
> +				 / (conversion_pace * (max - min));
>   	} else {
>   		/* TODO
>   		 * We are doing a linear interpolation here, which is OK but @@ -2940,24 +2947,35 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
>   
>   	link = (struct dc_link *)dm->backlight_link;
>   
> -	brightness = convert_brightness(&caps, bd->props.brightness);
> +	brightness = convert_brightness(&caps, bd->props.brightness,
> +				set_backlight);
>   	// Change brightness based on AUX property
>   	if (caps.aux_support)
>   		return set_backlight_via_aux(link, brightness);
>   
>   	rc = dc_link_set_backlight_level(dm->backlight_link, brightness, 0);
> -
>   	return rc ? 0 : 1;
>   }
>   
>   static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)  {
>   	struct amdgpu_display_manager *dm = bl_get_data(bd);
> -	int ret = dc_link_get_backlight_level(dm->backlight_link);
> +	struct amdgpu_dm_backlight_caps caps;
> +	int ret;
> +
> +	amdgpu_dm_update_backlight_caps(dm);
> +	caps = dm->backlight_caps;
> +
> +	ret = dc_link_get_backlight_level(dm->backlight_link);
> +	ret = (int)convert_brightness(&caps, (uint32_t)ret, get_backlight);
>   
>   	if (ret == DC_ERROR_UNEXPECTED)
>   		return bd->props.brightness;
> -	return ret;
> +
> +	if (ret == AMDGPU_MAX_BL_LEVEL || ret == 0)
> +		return ret;
> +	else
> +		return ret+1;
>   }
>   
>   static const struct backlight_ops amdgpu_dm_backlight_ops = { diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 1df0ce047e1c..d54fc00148f9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -60,6 +60,11 @@ struct dc;
>   struct amdgpu_bo;
>   struct dmub_srv;
>   
> +enum convert_backlight {
> +	get_backlight,
> +	set_backlight
> +};
> +
>   struct common_irq_params {
>   	struct amdgpu_device *adev;
>   	enum dc_irq_source irq_src;
> --
> 2.17.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CShirish.S%40amd.com%7C346bf19d8b154ef1060d08d81650976c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637283883029643196&amp;sdata=ThmKQHfhlWqYWTi1LBojaQvySj9sMLXqw9xgsgGZe3Y%3D&amp;reserved=0

-- 
Regards,
Shirish S

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
