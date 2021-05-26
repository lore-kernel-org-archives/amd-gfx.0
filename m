Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1A1C47087
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 03:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D298661436
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 03:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D298661436
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 924D16EB70;
	Wed, 26 May 2021 03:08:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 425D76EB70
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 03:08:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jl8mxrN+qPKO4rOBBk36S597/JcX2KLTaqjmBDMlMzScWtTJW3ABBvXieLVOVcLbvC5kAm2JAHDiyBM7lUh2/aWlKIYDZgPwBbNs60rz4Ds7CIHbqxstZCaamYNS5/eGyoAyyOwiBwhmHWoalByw1PTwjayocr65Xpp1ef75aP1+WfHXu0/KmHVGb3fJlJnyOu5sSi5Vdxgh2XdATBBGx1y8PUtm3NXje5nYf0dpeAmJBShGbQKqOBZtG6PL49iO6m/KiSwSbfacnRSTT+NJ5py/2Cbjse62fET+L0p0OkaEL8/2RHxog6MYtOSWxQ5pwbNeyaC7eIMPCr+FpS+XEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNFJq1tk5jH3ydOSu/0983jq2kcCT2UPUnnIxH0oOMQ=;
 b=oPmfnyR+2/owfdPnreLg9eBM7k9+u7uGSp78Qe4BEy3sjSYh+fnZ1++6c2bH3y2Q1QSGdBwxR5xmBsAFKPE2GjQhPFRt1hNv8VtxKnI7nlddg9m5J2coAGya4C5+desO0bVHFdtg8Rk/CW0wFX1NwJaGevdqJdfBuGsQy47bUjYYAnX/uxs8qEy4Tc3C3DQOeR1pfEyjMRjcaWvg8+A3iLvd3t/KFvNgKdyr1Es1+GaNjvNET5SLmey8QhCbFspSleMB/t8HhD4Re2ffhC445R/Vr3Q6nbxIIV/fGgENB7mwccu25F33RYSzBKazvxQtkGOhY+4mApmqvvxXY/JGBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNFJq1tk5jH3ydOSu/0983jq2kcCT2UPUnnIxH0oOMQ=;
 b=pHwW4QASxa8U5PwfTQ59nSfWZsqtSMTeqsqyzdwbtYFAU1Y0sC8de6MpCUVOBuqwqYBnNrhlDbWQyluhSmDWuVbqzxPcZ01eMF9YGYPhdic5hlmuTgedUYXKaxzrqq77Zd5Vqosshd09/SRMUZRNRMCRpQnj6Q3imGjt6N8WCek=
Received: from DM6PR12MB3196.namprd12.prod.outlook.com (2603:10b6:5:187::27)
 by DM5PR12MB1273.namprd12.prod.outlook.com (2603:10b6:3:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 03:08:44 +0000
Received: from DM6PR12MB3196.namprd12.prod.outlook.com
 ([fe80::2477:9f69:235:8392]) by DM6PR12MB3196.namprd12.prod.outlook.com
 ([fe80::2477:9f69:235:8392%4]) with mapi id 15.20.4173.020; Wed, 26 May 2021
 03:08:44 +0000
From: "Zhang, Morris" <Shiwu.Zhang@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix metadata_size for ubo ioctl queries
Thread-Topic: [PATCH] drm/amdgpu: fix metadata_size for ubo ioctl queries
Thread-Index: AQHXUV+HfLz16r5T/0WzC+K8N9OR2Kr1FftQ
Date: Wed, 26 May 2021 03:08:44 +0000
Message-ID: <DM6PR12MB3196BCBCB8139B3822FDD135F9249@DM6PR12MB3196.namprd12.prod.outlook.com>
References: <20210524115214.26792-1-shiwu.zhang@amd.com>
 <0b5f3072-f2f1-8619-22e0-32f20d4a7036@amd.com>
In-Reply-To: <0b5f3072-f2f1-8619-22e0-32f20d4a7036@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-26T03:08:31Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d3e4a2fa-dccd-455a-97f5-1057cdc3d3f3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb08a679-4917-48a0-f6ca-08d91ff3927d
x-ms-traffictypediagnostic: DM5PR12MB1273:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1273C1D26BDF36DED36C466EF9249@DM5PR12MB1273.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rvVCx6z46fKUtLoDuyGYSS7hD6SLgV6wF2wgleN0fCrLsfgTlrly3NcrDt8UjDKUOokE9pvylDQFBX6YR9sOlz201YFDhjD+WGZHh4wwabPLVg1pWs2qZiFi3zKcDgEDtkie0VF4LxrQ+tAERk3eMZY8zimRLaKTDmM+fG3sv1ST3QEwb2BQrfNO1Oc6ANMKGQhemOqVqb+90rg0IuHXgBsp9WDkoKtNNil+S51YWb+Lys7Dqjcy/YmuLSs+iyhLN0o6Gs0NCDoCQ5v2cdMySjPZH2159QdpQqoFMJ9TVuSxyCXTbS4yYZAs38SNh5iNQ9wpyzuTkxn8worOxAdhNnKDrAN0b/8hRujqtL8u4FKcnBUT8Unc86h8jjYBkprMYopli4sI/HU3OMRKLz1GwGxg0ZIP/3ysO/ysHDM4Ojh9WucQp1VEvS7ZJoewlWXwCk7eIHvB9oCnOjk0Aahc4DO0BivZJGjmQr7OK1ncULNX0Jt4AeXoHDM1fOSbjPLOYjKp2oNDAqSu1TSATiyOs4cQ24pUgS2IEFbeU9DtdP/TkUHF4Yz6izUqbkp0ULEX2EeiSPQ8f2WPlyzL511d2bgama7Lwgn7ZlGlBMerhRM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3196.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(53546011)(66476007)(64756008)(66556008)(66946007)(66446008)(316002)(76116006)(6506007)(9686003)(26005)(83380400001)(8936002)(86362001)(110136005)(55016002)(8676002)(5660300002)(2906002)(38100700002)(478600001)(33656002)(122000001)(7696005)(71200400001)(186003)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?c1FmQWJxbnNqL2UwQjZGQUl5bXZyM1JTNEt4eTAzREdsNVRuVURoWTRyNFhB?=
 =?utf-8?B?eitoQmxKc1NqRnA2TVdrZkYweWFqUy9lM3FWYTZkUmNRVHI1RWFTUnU1UlU0?=
 =?utf-8?B?eUxRRktqVlFMbDBpRGVGdENBcXkyaklFZVA4NjZSQWtwbjFBR1ZGaFJtUXNx?=
 =?utf-8?B?eU1hL3ZreVdOSGw4MUlIQmhZL2lQekdRTnMwWnRTUEorL2Q5Qm81WWtqQ2dw?=
 =?utf-8?B?blpWZWduY25XQ2VwMTJSMTlFRE1kVEpsYWtLUFlJZ2ZmelQvVytCdDFkd1Nu?=
 =?utf-8?B?M1pIUENhYXprU2pDWCtwVzhmaVVxODd1cmRnRDlFaDFDcXpVUG5DY1RzRG01?=
 =?utf-8?B?WC9KMFBvSHpoUW9iNXRLTkVZUTU2MEtXUGR5TDBldklxS2gxOVhoOTVIT1VE?=
 =?utf-8?B?c3MyVzlValZEcVdJVUVVS1lZU2VhNUp5QVJOdGZzVFZ5cTBxektkZGRlSWg4?=
 =?utf-8?B?ZFJFeGxyNmRFcmdWYTNFVGxkTEpQeHNYU211N05kV1V4S2FjOVhUVjgyazQ5?=
 =?utf-8?B?NFFFRkxSMjlidEtXd2d1SE80Wkw1cXJYcGhzN0lKZTlQR1RTREJwTHVob0NY?=
 =?utf-8?B?dXFLZHExR3BYcExtKzJDQllkOVl0c3Z4bDJXRlc5YlIwWmZiK2dRY0U5TmZr?=
 =?utf-8?B?TE42blkvc21naFMyOGpuL1VQMTFsVlIvekgybmVYWUJzK1RuUUJBVzRHb1V5?=
 =?utf-8?B?WUJxUnBpcG10OE5qOFQ5cVZOUXkwZlkrUTI0RUIzQzF6SzVyMnY4S0VYVkcw?=
 =?utf-8?B?T0NZNWhxaG9LWExTMnNQcHc2Y1NkeHZMcTc1eDVGTXFGMGljZ2NrdmQways1?=
 =?utf-8?B?ekNyMklGVEJ5UUxZMFIxMUZLbUJyN3Vya0FEeEs5YytZWEpUdE1mdG5ZN3lX?=
 =?utf-8?B?amlTanFWSFNGNEpNSzc3L0FoU3FmWkhCY2pwbE0wSzN6a2ZpOXRmMEV5VGJh?=
 =?utf-8?B?dTZJUGhLckpWcXYraENQODE5bjIrMGEzejNmYkpFRjh3RVh2RGQrT2xlVWRk?=
 =?utf-8?B?VG5FSGxSWkJNU0Y1QmtzOENtNlNYZjBKczhGd1lwUkRGaStPSGVET3RNd3FG?=
 =?utf-8?B?bDZTdnFlckN5clRVaVN4VHlQNGhJbDlJOWNtTGNTc05qMVFWTXRFUFlNaEdG?=
 =?utf-8?B?QnIrTW1JZElGbktBQkpINWtIaElRbmNFMGZCRHRSUG42MmF6RFBrdHI4S2pG?=
 =?utf-8?B?dXF4VWZ1WkVJU016aFZIeDJlSWEyQnJvaE51bkNWMVZjVVdVTU96eXlmMlky?=
 =?utf-8?B?SVAzaFRRR2VobWVyVTdqOW5VcmpOb0JodytwOWJWYzluQkZncWx1VW5JZUR0?=
 =?utf-8?B?WktLVFJSaUMzVWRuKzVlaWdGRXB5S0d5c2hpb3hKZ200cms1UUhhQlkzSkVx?=
 =?utf-8?B?c1VuVG5xQ3pWKzFLRE1vK0liTmZMd083WThUODdlNlFqRnp4bXE4NEZsVk1B?=
 =?utf-8?B?anZub0Jvd0hlMjkwcFAzQlFtU2RlTGtWRHVodXdSZmFzclhsRVVneU9oTm5W?=
 =?utf-8?B?RVNrYzl0b2I1SnJJa1JkdjNFQWtUOVNxc05TUjVqd2xYVnlKK2NrTDZ3c3VZ?=
 =?utf-8?B?ZW1qZjc1VHdYblRNRFVlQS9ET25iZy94UHJuVHo5cEVsWFgrWXh5TjA3M3dP?=
 =?utf-8?B?QTd1dldFWUtXcXhLQnA4TnhkWHBPVmwxN29BS1NMYytZRWR2TWVKdUd5MVRm?=
 =?utf-8?B?L1VrMVVyZGtlVE1FM3drU2EzK2R4a3BWZVE0cFhxZnhBU1BIZU5SMmx4ang0?=
 =?utf-8?Q?NmoSNSk63suslOaVNZNqBXS0e65ynwgy0oYtArt?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3196.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb08a679-4917-48a0-f6ca-08d91ff3927d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 03:08:44.3759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: beKQcapghogRNb8iSztZglmwbV8N0zhW1TgkzWiiJ7RGwXiJ/pOjMFYbl/vZGEAv9X609d/57JIAKfYOlL52Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1273
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks for the comments! I'll separate it into two patches.

--Brs,
Morris Zhang
MLSE Linux  ML SRDC
Ext. 25147

-----Original Message-----
From: Das, Nirmoy <Nirmoy.Das@amd.com> 
Sent: Tuesday, May 25, 2021 8:15 PM
To: Zhang, Morris <Shiwu.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Das, Nirmoy <Nirmoy.Das@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix metadata_size for ubo ioctl queries


On 5/24/21 1:52 PM, Shiwu Zhang wrote:
> Although the kfd_ioctl_get_dmabuf_info() still fail it will indicate 
> the caller right metadat_size useful for the same kfd ioctl next time.
>
> v2: free the metadata buffer for sg type when to destroy BOs.
>
> Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 3f85ba8222ef..e9f8701fd046 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -95,7 +95,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>   	}
>   	amdgpu_bo_unref(&bo->parent);
>   
> -	if (bo->tbo.type == ttm_bo_type_device) {
> +	if (bo->tbo.type != ttm_bo_type_kernel) {
>   		ubo = to_amdgpu_bo_user(bo);
>   		kfree(ubo->metadata);
>   	}


This should be a separate patch, it is unrelated to the below hunk.


> @@ -1213,6 +1213,9 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, 
> void *buffer,
>   
>   	BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
>   	ubo = to_amdgpu_bo_user(bo);
> +	if (metadata_size)
> +		*metadata_size = ubo->metadata_size;
> +
>   	if (buffer) {
>   		if (buffer_size < ubo->metadata_size)
>   			return -EINVAL;
> @@ -1221,8 +1224,6 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
>   			memcpy(buffer, ubo->metadata, ubo->metadata_size);
>   	}
>   
> -	if (metadata_size)
> -		*metadata_size = ubo->metadata_size;
>   	if (flags)
>   		*flags = ubo->metadata_flags;
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
