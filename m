Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B510BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 17:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E20E60F6F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 17:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E20E60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A736E18E;
	Mon, 25 Oct 2021 17:30:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD116E185
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 17:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvHg6fXYW5Mo5Lhc8MS9MASI/x4QGTaC3X+ADDzFdVRM6DLj9h5jemo+hLm2a+fm6E8DQTcU5rrjwLo3bT+DRUWkocM9sZOXK7PkaKczefrBmEbyxi2KWm+6PaGOzqsfWyjNmkdvwlrLQtYUcSvPLT+ZSMkhASIcacOtkjVT6aSnd4jaVDARhPfZVqpPaqUqxVkj8QkNOzb8l07p2Nssoz/uBmkwcokNmOV09QmFpCtsOd0zBm6y5xPV5Zs4zNRSQg7Ebou9b/sZLTxi9E+r0PhBDBAgO0rwsbi8bdjvC+qDYpSvbeM2nfC/CQnQmaow8DVAODnfitdR11L20tFYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BJU/bFmg889PgLzT7L3MD8Kzr6IPL5SZl2McU6DDe8=;
 b=L6PH9jnOYHAPqIy5xE4GemyTQjvztjZX2f8imFJnMPltv4dQf5yE2LZp7An8y8p7JdKZGt2XqFeKmvRIo5NZ6JUp8os920qOImiG4Q5xd4MA+Ngmmu519aJzs3bXqKaXTFxJIVXnNya6hkYXjG03flAJENbsBlAWst3TTVaCCnvJd6W2qjHoX2jCdD1CoDc4aRi3/zt0tbl/ADrCwBZKXDdbJd/IiqSwBJn1Q3Ql7FUy5rh1Hqrr2jRzFqv3g0ZBZT1SDSmtMsKYOEhaowuPbSWDukZiVO2ookTlmT2I9VGeWL/Htk57U00r1sa3qqz9bmRFpsV0t2LXd/B+hR91HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BJU/bFmg889PgLzT7L3MD8Kzr6IPL5SZl2McU6DDe8=;
 b=KoUqM4TosRkdnp7IeqAUlLg0blFpckLxEwJTIT083HHhKhrKGXAr1EkXJ1ELvswSx81id5QRniyIPc7um07r0Rtw6R3WHUxjxvO7dWSjOVz0A/BWJTdyZH3+92yfcU21JN4GhRj8GupAu3b7MhLISqKEpeMR5ZanDK80n6rgFX4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 25 Oct
 2021 17:30:30 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 17:30:30 +0000
Subject: Re: [PATCH] drm/amdgpu: Restore information reporting in RAS
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kent Russell <kent.russell@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>
References: <20211025160220.51401-1-luben.tuikov@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <879b6aec-1dd0-116b-9822-7fdf5bf568ef@amd.com>
Date: Mon, 25 Oct 2021 13:30:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211025160220.51401-1-luben.tuikov@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0216.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::27) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YQBPR0101CA0216.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:67::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Mon, 25 Oct 2021 17:30:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1939001d-316f-4a83-260a-08d997dd23f7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3114A07630570FCDA01D496692839@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iS4uIiAuTu0IUL5dD/Iu1hPhER805r7HxdwUB+Za0l2Kvgn6O+Ds8yOoSZaI84IfUwnZw5YMADGjo0hJ6BhBnjs/vxzzS4xDBnaT8AHkEa8l5ZuasTc8Ph6JfEh78rPJgcffbpkjNOXjLF/0kRlYJyPN2ad2x1VLEzql1U827eyOwlTzYfYccy7ZzoEakUFfDQ7LYH6bLV+CHrUrUVheEjCfZWqmDGd85PyzdprEgVRnr3NCLai4Dx2SwjPUzOdfdZJ0PaI9y+1HscqnV40WNpYU/HLhjhBkSr2jDqaJ6Q1pPL0NJyDujAGVL2+5lV3IJOXjT17nWc92wAsVM77UcOuITAvNEJK01o5+TPtvhZdvfYQ4hCL7cXzXh0bLZxwESA8WOw8P1ygyKhMvgITt2FtfseE6LywIcQ/B7gWew350Z5SG04BqFfwJC6MswxHlj4i0WSH1GWDLEMZuNBujX/NPfmO5m0AZoK8B9x1ROD6+B9Ddhr8RUzp/WXZtpkwszl/k8M7fqLuS5P3zts9AlZe53e2uv54j3IBebGHJatND0mOAoTs8T8VdgBsIEnSpBDZJ+zT3++bqeFmpR0p9bWtzOTsT/9Oo+7aUsmzz5YDv1Jdsy5Waox9HdG5Dv5hHl+INJa7iugyKG+0dlGLBCSufbYX8ZGKbeIDm7zREcdkhd+RxauAZPernrsaceD+bYACNYLQExQPjrY6GqozXKhol79BN8r7y8Dl3WHHYBDrQiyNdqwMne+h3/7mOKEq/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(5660300002)(6486002)(26005)(44832011)(4326008)(508600001)(31696002)(66476007)(316002)(54906003)(8676002)(83380400001)(36756003)(86362001)(8936002)(186003)(66556008)(4001150100001)(2906002)(16576012)(38100700002)(956004)(66946007)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzdGdXVMcmtaSE16b1JiZ0Y1S3dUN091NzhPWHFucWJKZFdoZE5ULzQxNkRE?=
 =?utf-8?B?S3pLZUpoeFE1Z2J1SjY0M0hmWDluMUlscjZtT2k2LyszaXFVN1RzSzdmL3Vv?=
 =?utf-8?B?MU1UWkw1UGtQbFpPS1FZQkd0UzJaWFFvaUpCcFZSTHBrQ2ZTTFNlYUNCcFI0?=
 =?utf-8?B?WXVxQ1ZLSVJ0enJUUUQ0YWMycXVSVkZwQjNXSUMrM1JjZW5ZTmdOemxmdmpK?=
 =?utf-8?B?dm13OE5GRDZmZVBITVhCaldHVEgwZ3ZoTGRaMitQLzVuTUNOTjBRUEgwK1dp?=
 =?utf-8?B?cThxYi9pQktVSk0yWGVBQ202OUFPeWxqOE0vK2xVcWpXVlZLWjBycTZrSDM1?=
 =?utf-8?B?VUFINE5JS1ZSTk5laW1pSjhiN3ExazdLVHZuZVdQQXNWVUNDdktKb1Y1SUMv?=
 =?utf-8?B?WElINnNNYXU0OXRFUTdPeC84MGVoYkxqVXFtb1hMd2VCY1UzNnZVaWVRbHFa?=
 =?utf-8?B?aXVZdlpIOHdYN1dWSm5Cclp3YnM3eWtWdE11aHIyY2RkZzFUY0xhNFdaTnVt?=
 =?utf-8?B?S3J3VmdkWXJIY1k1VURpcEo3QTdXQzRORVNSRmEyMmZzMFBqcTNyN2gyTDMz?=
 =?utf-8?B?U1RISnVWcC91SEJGS2FwaENyZ3V1MlVBYWt0OUJTNFpYTWxKdFBBWmhMRWZi?=
 =?utf-8?B?MVhOU0t4eVdySHh4cFUvY1NjdG9meDIwdUJJOTB0dmFXS1prckk3YlEwbDlF?=
 =?utf-8?B?M0dTS2RJZ1B0ZmE3RGVhK2t4RkQ0RUpTSHExZGpBc29GUmZ3UG5LNWZoTGdB?=
 =?utf-8?B?YkQ3dnlBaXovQnBid2ZHcDFaM1A1MHZ5VWk4OFB1NmY0dUJXbHlBTG9DOTBX?=
 =?utf-8?B?ZE1WVHprVmRqWE1EM0ZqTzVudGRLc1lKZ004MzlORlQvK0tQSzd4RUpFMGZm?=
 =?utf-8?B?YlNQZDJ2OUxyWU43aHNKTTVNaEhLUlJuS1h6TUZZbk1WT1lyWmdCQVJrT1Rl?=
 =?utf-8?B?QXkrdmFtUi9KRkNQL0hnamp5SitLbnFjNjQwNEM5WnJtdWlkNGZTYVJsTmlF?=
 =?utf-8?B?dmxSUnhYOWIxbTRnUFNkZU96WDNHbnNEZmVJL3BhTERQM1pEV0ZpTnpIOGND?=
 =?utf-8?B?ZHBDSXFpb2hGTnlMaFFyL0hBR3NSeTIxQXVONUpQbi9oS3JDNzVBbVZpSUNz?=
 =?utf-8?B?K0JRVEYvYlpsblJjUmI5clJ5R0t3b1J4VTdhbW9UVnJnUm9PNm1paFpBTjgx?=
 =?utf-8?B?aEVHaHkvbWNZMGJ4WFJoaTVIUURLTnBLcUVzZElyZktVVWczQ2xjSU1uTWF4?=
 =?utf-8?B?d2NDWGVSRVh2cVBFdEVnWW5teDVnK1hoRzNjRERmc0VEYS9PWXllWFJYUTZ2?=
 =?utf-8?B?S2N2MFBhMlRBQ2VLdGtCTDNZckk1UjMwdFcwVk10RGwzbGlFRHhWK0NzQnph?=
 =?utf-8?B?cmdiQ2VSRzNVd2pMQWVtb1FjK005dm42Zm5ETWhoSGIvUWVZV1BpNnVETWpj?=
 =?utf-8?B?aG1yQ1k4bDVKTUU2MTV3Wkw3QTAyd0Z6R0tiMU1ScjVrRW5PVVlUa1FXUGQ4?=
 =?utf-8?B?WTBEekU5U0JUVDZjbVlldlAzK2U3M2kyQkhWdkJIY3J4aCtCZUtpVmNZRjVx?=
 =?utf-8?B?N3RxTjNnWmJwZXNXU2lacjlDQlZMcGFyM3AveWIxYzlkRGwvelhrTVEzdW5v?=
 =?utf-8?B?Z25ldU1sQ2t3NE8rRXJrblVkb0FEWVhFeXh3cDMwa2xTZC83cGxrRVpUZCs4?=
 =?utf-8?B?LytUUjQyS0V6NlQ1TjdJcldhYVQzZ085UnlOMDl5M1hWUkpFdnRINW9OYVJy?=
 =?utf-8?Q?A3AReR3DC/M66kFT9aCAB/lJ1VBysqaytZRJkL9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1939001d-316f-4a83-260a-08d997dd23f7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:30:29.9630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KnbRWcv+x4x/GdKxZDQZlK5m6QSr9HoZyZdkhtDDGE0oIDMtIIlhKmCdtnEygmBj+knjDOpA4k3miAwHf+/Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
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

Am 2021-10-25 um 12:02 p.m. schrieb Luben Tuikov:
> A recent patch took away the reporting of number of RAS records and
> the threshold due to the way it was edited/spliced on top of the code.
> This patch restores this reporting.
>
> Cc: Kent Russell <kent.russell@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Fixes: 07df2fb092d09e ("drm/amdgpu: Add kernel parameter support for ignoring bad page threshold")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index ae64ca02ccc4f8..05117eda105b55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1112,7 +1112,10 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>  				res = 0;
>  			} else {
>  				*exceed_err_limit = true;
> -				dev_err(adev->dev, "GPU will not be initialized. Replace this GPU or increase the threshold.");
> +				dev_err(adev->dev,
> +					"RAS records:%d exceed threshold:%d, "
> +					"GPU will not be initialized. Replace this GPU or increase the threshold",

Splitting messages across multiple lines is usually discouraged
(presumably because it makes them hard to grep). I think checkpatch will
treat this as an error, while a long line is just a warning. Therefore
it seems that long lines are less bad than split messages.

Regards,
  Felix


> +					control->ras_num_recs, ras->bad_page_cnt_threshold);
>  			}
>  		}
>  	} else {
>
> base-commit: b60bccb408c831c685b2a257eff575bcda2cbe9d
