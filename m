Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6FEC34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 08:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDFBE24654
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 08:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hZ+sSf0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFBE24654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F246E9B9;
	Tue, 18 Feb 2020 08:50:09 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 391C16E9B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 08:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIj6nPzkQMidzc0hROFp2oSJqnkaNGWZrrt9KGhFbhBBULjPiFNDY6XXzws+Xxp9ne5wcyOZnkHpoHRiRCjrSyi9n4g4G59sA0S/mLYgtACUB7n037mRfmsSXYHw8FgVko+dGCto7Rj84b1vgZ7G7ugC1KZIlHW5X6Mkgax9KseKG/7pV41CoIGjTZzp0OzwY5LPQ37+87wSr0YjZ0srn9oZ/AWZGtVA2t0CJe4EA6lcu7TqRxDqpoD9mr9b37Pd5e9JxKX8GdTxHMSET+iGr38NLmyQIddIuLXCJ22YFxGzVRq6ZNem5vsMOvSFHH4XtA+Cks31WaLfjuI1Xodc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOS02GggWNbdxIZM/glHjVCwOaPdMEHwE90Pndzkr8Q=;
 b=loovo2lE3ddeDZ4JtMdkJCq0C/bZnecJoWGfLzb13Kglgdp9/j8wFj/a04AN1wncOgm25yzPD/Vp6E2t2voaMuEf/CAB7fNjclKuOaH6GxUr8cSNVURYTN4Qvy2F3tI1pOlCQwH6LGq7tb7vIL3/7hehRK62aBU7+yV+ezxKoZLMAqCgKw9/bk5cDXPAyl5WA15AythKCeSvEi9gIx6kxnZLDtuCcEyZpTe8LJwSZ9wanyY5ekiMy7/uGdrpVHk3tkckp3jqBWmhxHnGenb9ITRD9yzatrtgNgVAU+phFqLw/qxXv+rYcql0L4Meg/pP1OlyMo3yOfOUCKXmyt7iKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOS02GggWNbdxIZM/glHjVCwOaPdMEHwE90Pndzkr8Q=;
 b=hZ+sSf0kAxHaAzaZRKQvnhOLOmX/499Osm1dqicPi+9aYIwNmzSEsINkmVK2ogrxZ1NQfnM2Zm926nmElGk6K9pzl8q7lsDaHkIwx590/eFsxs1PqMih2G2TPzbbExOufwUjBpLt3SDvSlYgtBh3Y94KERO2+tgLw12KRPzA55Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1196.namprd12.prod.outlook.com (10.168.237.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Tue, 18 Feb 2020 08:50:06 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2729.032; Tue, 18 Feb
 2020 08:50:05 +0000
Subject: Re: [PATCH v2] drm/amdgpu: fix the wrong logic checking when secure
 buffer is created (v2)
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1582014600-7147-1-git-send-email-ray.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <879e7606-eedb-5b54-5600-8132df620933@amd.com>
Date: Tue, 18 Feb 2020 09:50:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <1582014600-7147-1-git-send-email-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0026.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::39) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0026.eurprd02.prod.outlook.com (2603:10a6:208:3e::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25 via Frontend Transport; Tue, 18 Feb 2020 08:50:04 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3fe7f6f-2ecc-4f15-93fd-08d7b44f8cea
X-MS-TrafficTypeDiagnostic: DM5PR12MB1196:|DM5PR12MB1196:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1196332C6D1C92D72616F15A83110@DM5PR12MB1196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(189003)(199004)(2616005)(16526019)(186003)(316002)(86362001)(36756003)(8936002)(31686004)(6486002)(81156014)(8676002)(5660300002)(81166006)(52116002)(478600001)(66476007)(31696002)(54906003)(4326008)(2906002)(66556008)(66946007)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1196;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7F1AD/OL8ZwgZVRcwo9rM0hu6EaD7ocWXjxUUrM7tEIK687pggUYE4679PxtS/9JSH453oATUPQyoZ1C8ognWgN2KSoJ7vgyxswQWGzs+utAR5UTqSTKXzqvVjYHkF2ic5GLqblXM97XOGWUiPzRzR17at/zu8t7m0fKq+Sfd4h1ciGI6aElGgI5oGDTyYU53R6j3aWAOI3vo5vG/94Szyp8HwKZpEF//N1ANjUqKc0DqLZ0lJzs6hm/RljR/34JAqOMOLu/Iw9ENJrYI+nisYrLr2+/WmTcoSuN2JLaxPSxmBWsqeeONK0gJxUOozFoC0w+/P9a2+X13PmuDhCCBp/mjde58YuEu5/c3u4m4j+h+mflIwAZdtZhO23r6G3kIum8LmBOfm220p/NaNL1LiPYj/Tlheeme7ZBj/xmGe2OSpdz5b/vQbOnAUJ8SvCf
X-MS-Exchange-AntiSpam-MessageData: NBy2saLPI3ks0ffppyboFIbBy+NSh0vxm5v/nlThAjqVadFBSHaViLm/VnV053SDOKqaQ6gbz58MryiwWCKhdDfgrOyJQlJIcJkHLnAPgg08VvAD8umW0PC46tbgLQitTGI9nrfZjkwh94wjW42hzSCE4FL3CF5W8fjBPL5bbRCratz8AoUGjHzWx/SF5S219S6mht12U/8V6KBLWzBYlg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fe7f6f-2ecc-4f15-93fd-08d7b44f8cea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 08:50:05.8063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PsNp4WJ9U+H4BpebB1iv92J7WMCH22M3y3aPWllvuk9bJRJ1DBzQOGJxcHIwgOb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1196
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Aaron Liu <aaron.liu@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.02.20 um 09:30 schrieb Huang Rui:
> While the current amdgpu doesn't support TMZ, it will return the error if user
> mode would like to allocate secure buffer.
>
> Fixes: 17d907c drm/amdgpu: implement TMZ accessor (v3)
>
> v2: we didn't need this checking anymore.

You misunderstood me.

>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index b51a060..5cbc63a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -235,11 +235,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
>   		return -EINVAL;
>   
> -	if (amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
> -		DRM_ERROR("Cannot allocate secure buffer since TMZ is disabled\n");

Only the error message should be removed, but we still need to test the 
flag.

E.g. in general we should never log that userspace sends invalid parameters.

Regards,
Christian.

> -		return -EINVAL;
> -	}
> -
>   	/* create a gem object to contain this object in */
>   	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
>   	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
