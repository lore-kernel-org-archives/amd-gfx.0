Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E234DC43332
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 04:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A52E64EF6
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 04:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A52E64EF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4563E6E487;
	Thu,  4 Mar 2021 04:44:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 510846E484
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 04:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EErvpJEyR77zGYUqSECNfuaN9LU0Vort/ax8P01MQvsVGKZ8JC4s8661h0L5omte2XMPVUj9Ni1OY61/7uGqHk67fyTNVoJ8y5NGR5BHz5EfMYuDyip8ITP3RMAY6HuowHcsK8Vl9gaZCYXlvUEVq32xD9IUFF2R6GFq//zOT92Nic9mqTXH+VdUxPpGKN0uq3nvc6mElwUVcmRPirGPFtGIcsdyJ0vfsyJp3kwF0OYNzBBw6rgwOtkJ+KdUlZbO5HFkVrUnrgdJyzZl5SOxCNQE+xyNHVhmT9aGzwrqM6oLE4NlaN68S5Vt2BzS4nqLDEG1exr/z8cF6SXM5zZ+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TEjWmUUyOQctp3XJpGzEkW5UdFAiuRZUulGdQ7UE44=;
 b=mlEKTGA9+ijtYpilt3Nzo1QaN7MvZ9aF1pah43YcJAfkoTLfHMtduAJJZdadi9ZkGVs1LiPvgSbusBoxSQ53gfAaqqXvr5F5trrn/7azbVUeVvmaS+VYvHCmuSgkNHuuGzhYvqo7K+tdm8W57mNDUvMd5XUjtq0C2wcCHFY863uz5+2TafVo3VyztPmy2Ho8OjU8z014zbz5nH0RkHX/IrZrVGNqiiigA/6hahOb41zEpoeqHTsjeMspj6qcLgRhOz8a6KsdRIDRfnGM0/kKk7JpiveOM7dxYcnVtdU0bxKdr3e9qP6IoIkr4325tfGhLG8NJbESl2YxbUnRGASlQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TEjWmUUyOQctp3XJpGzEkW5UdFAiuRZUulGdQ7UE44=;
 b=EPx7Ufncp7XQaSJQ5OZpYsTcjMoxUXFRcQsd/vH8yIx/tvBZkEyID4ao25PmLd8EZfd5OUhwfAH9bv4JiIu2QBnZPECxvjywk2RfLzQfN5OIQzEhDcq8LUrAGi11bYsaBIqIAS2ZGago6Vx0qZtVxp3jE2eWqvFOnQtixxSxMnU=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 04:44:52 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70%6]) with mapi id 15.20.3890.028; Thu, 4 Mar 2021
 04:44:51 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Thread-Topic: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Thread-Index: AQHXEKqlw1oN/UrV3UuQM6Qp29cRW6pzN7WAgAAIwNA=
Date: Thu, 4 Mar 2021 04:44:51 +0000
Message-ID: <DM6PR12MB460311EFEB28302D41C4CD79FE979@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210304035824.37796-1-Feifei.Xu@amd.com>
 <CADnq5_Njn_yvVasKGcQi61rZbi1cxv-G46iTCH0xojkfH4gFeA@mail.gmail.com>
In-Reply-To: <CADnq5_Njn_yvVasKGcQi61rZbi1cxv-G46iTCH0xojkfH4gFeA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c98cc48e-981b-4d81-a087-f31849ec68f0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-04T04:43:18Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a32d2d0e-51e9-4567-0d72-08d8dec83fd8
x-ms-traffictypediagnostic: DM5PR1201MB0121:
x-microsoft-antispam-prvs: <DM5PR1201MB01219F958266351C24AB6577FE979@DM5PR1201MB0121.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lfaH1esmoxJF1fETflMY6tlpqy+hiTLMyGJ8I9+1OK3Dc+8iJMNi99gIwJVXeOMfgqLJSDUcmV1mAgP3XZrvSvYWnYu0SA6PrcemrSxzYjF6Krr28ChxTBfd07qrepNNcDNGzaouvpMlrj7LDqNGtqbg+TogmoqogFPoQUyWsDkRcnelMNGFAODnLhV7DComrPsH6NsapATSUSqCB7x7kA0T6MBN6cPlhunIbzsWJmLvAS4ipM3nqpq6o9Cl5TERcZJOK8Iv5mMFVyxz8zyW7SoVv6ZFQ8yjdkxeqSi7F1VRTUNE1UKNUT6dDDgyQeCIjyC4T8kKEdYU4A0OMli+X0AquFtKyJBWrSM2kWwCRwfc5lCTJ1x/ygPPo2vN4XPTTw1gVs5XmUij09aBsUcEKwCa//zsD/p2xl7r0dBtdPl5iQdAuHRCr/DBq95MSy2W5XLbtx/h0g0lPFeIlmwAUruknDY7nWCYxiZvqOdp+78YZYveDoNqgz06vSnl34ibGro/+vBev1E8a1uUqmaxtBIxZ68gzlkXlcTE1r2Os09nhY/MMWXb+DHt4ftrl2XIaRHYi+0XN9XwX00hqbwXHg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(76116006)(66946007)(55016002)(71200400001)(6506007)(5660300002)(45080400002)(478600001)(64756008)(66556008)(66446008)(53546011)(66476007)(2906002)(966005)(6916009)(52536014)(9686003)(8676002)(33656002)(4326008)(8936002)(26005)(86362001)(83380400001)(7696005)(316002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rG4IUtF8kxlpundeO2g4tfeM5zKdK/JDhtfLBPrkhhzfj3wc9u3riTQzKBcR?=
 =?us-ascii?Q?yDTjFi37Gi9dga9NjK6i81KgyHk4HbT3R2AWY8sz9gG89ZukzJdabzcJ2nnE?=
 =?us-ascii?Q?Kia6MzgO78o57RHXqcP29X1QHWv/CerxJ0q1Ftzw3HcvLL3Q4xwrT+DhKuU7?=
 =?us-ascii?Q?FxBwyosfSWYaOaCIo/ikc717gN5l6AvDnNPZKi3X1y0yo4U5zhuqq6IMoFub?=
 =?us-ascii?Q?75H8hbHelXFo0elzlYB2j4W9hOXMTvyef2D/G7c/ynd5SIfQ5xITEzi+LqjR?=
 =?us-ascii?Q?DV4l/N3Qqb4MyrhVFNx0n/4E7tZOMeDuPP5MdZrgfS9As1OgEN8UZG5lQnwP?=
 =?us-ascii?Q?fziWUCA0CuRrIyDHEKGGw9iDPmJw0ShpyVkGGaG5JmM0wOyajZSOYMHVM/W0?=
 =?us-ascii?Q?ikW4vsRgZ+g3AhPx4ZU6nidyERmRNTM00HMBgZCgPuInxwZEhDNT79tcVPXZ?=
 =?us-ascii?Q?bO+C2dslk1xfvDO1SkeOSQL/sE3k4Hh1hrREdICpsH6I4wyHKjBIKR1wF/jZ?=
 =?us-ascii?Q?UHb5B0nw9Lwtc2Qcf/LX3ro6IgalPxge/DoDhpJz1M1ydUSfy5OD8l1Bu2zu?=
 =?us-ascii?Q?LDQu/fP+x2N+LUtbti5EaMi5TErKtspw4gkzA5cpwEybgzXQv5mUdjmpARel?=
 =?us-ascii?Q?nlUifnySQyBaib8QafILuuv2bDMkJ4DMq76TI5k8KEUmD1V97mbRq/PZ2NYJ?=
 =?us-ascii?Q?Mdh53Bg6MWgNqyr4JG8G8hXBZrAmxp0YGTuNsGgNCdJTfK5CcnBWjvnGAZiD?=
 =?us-ascii?Q?6ZOxazs34nIhVTRX+xYKemvMNbHrbxvN6uGSTChgTTcR4Tr+CdUeMhDwGNj9?=
 =?us-ascii?Q?9BiaMCTspE9Rn1IbKbuj3vCXE7YBj+1UFxBSJxp+lQC9IIUJB3hm7sbLXTgy?=
 =?us-ascii?Q?3dMxUQp+RJOmqZ+m24I63JVIMGJJ6VUEse3l7HdKcRY5wPZFve6+aUqWHME+?=
 =?us-ascii?Q?yzrjuZy96w02BEBIt5AJY8HR0uBtjSDqpzFOJ7ABDbiqoL6LUITiLYFOxyOv?=
 =?us-ascii?Q?Pb3azPQ6YOsLOPUgXD3Xm1x4m8RWIM74knAtyKnkzwVpq0NZaYnkQPDFFwfV?=
 =?us-ascii?Q?mNMMyouL23lr3ZcfuEG1/ad32rNOiMWoAG6izQOLRKW+FtI3r0Xc1bE0BiRW?=
 =?us-ascii?Q?snVpWL6Y+WU4rNqAsfCCB22GXeOpXUCY8vj+EXmtAFGrcAcWvFqb5dSfZLbY?=
 =?us-ascii?Q?1aL52JRUQ4rllUmPhReq6W5F6jk1O3pygHfKwThoQ+zcNZTeS7/kK0ecuUT+?=
 =?us-ascii?Q?REaTY5k/wup+saro+esoKns5BHM1uyF8mK5Mdd+F9or36zKvBXgoyqsw6gAq?=
 =?us-ascii?Q?CZHCSZok/SPz8VrOq4igw3PC?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32d2d0e-51e9-4567-0d72-08d8dec83fd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 04:44:51.7855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tqaf0tzW0JLeRAG1m9LPTSnDoXW1iPz99v76NPMquvDQi2Tse7MvhrgBBxVvbnBM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks. The VegaM still need to be rule out.

Thanks,
Feifei

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, March 4, 2021 12:12 PM
To: Xu, Feifei <Feifei.Xu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.

On Wed, Mar 3, 2021 at 10:58 PM Feifei Xu <Feifei.Xu@amd.com> wrote:
>
> SDMA 4_x asics share the same MGCG/MGLS setting.
>
> Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 3bede8a70d7e..f46169c048fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2271,21 +2271,11 @@ static int sdma_v4_0_set_clockgating_state(void *handle,
>         if (amdgpu_sriov_vf(adev))
>                 return 0;
>
> -       switch (adev->asic_type) {
> -       case CHIP_VEGA10:
> -       case CHIP_VEGA12:
> -       case CHIP_VEGA20:
> -       case CHIP_RAVEN:
> -       case CHIP_ARCTURUS:
> -       case CHIP_RENOIR:
> -       case CHIP_ALDEBARAN:
> +       if (adev->asic_type >= CHIP_VEGA10){

Need a space between ) and {.  That said, do we even need to check the asic type here at all?  I think this applies to all chips that have sdma4.

Alex

>                 sdma_v4_0_update_medium_grain_clock_gating(adev,
>                                 state == AMD_CG_STATE_GATE);
>                 sdma_v4_0_update_medium_grain_light_sleep(adev,
>                                 state == AMD_CG_STATE_GATE);
> -               break;
> -       default:
> -               break;
>         }
>         return 0;
>  }
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CFe
> ifei.Xu%40amd.com%7C67eba26e9d7a4ea88e9b08d8dec3af22%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637504279325196042%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 1000&amp;sdata=jUa2v%2BB6NICmTSr9Zdt0MQdjd1oIXYOzDYloTzUstz0%3D&amp;re
> served=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
