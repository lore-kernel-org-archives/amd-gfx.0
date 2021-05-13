Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05461C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 16:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7466A61435
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 16:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7466A61435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE706ED27;
	Thu, 13 May 2021 16:23:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A9E88E87
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 16:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6FfyTnY9BFabG/q9a59s/Tr9j2WCO0pZ7L1/JLfyqLUrey6ZT1mgOhW/LC9uT9z4HhsvtF+ChRZNrHKWSCQKC4EYvHKRerovXM/vapZEa+nKE8rkBB7w8M8nYY+R7P9q3Cuk9xaaFRBmyrMBdf+bdjDYQzjXqn5iPyd21Jw7KSsuwjvgvO5P4W4GqxIko+NNI5L5bxT4sXGwR1R775i//0Pvcp+lci0j84IDkeyO0ebS33YA8pStc3/WGB3IzP+7qG5QJysUICC5d5IX9Y4w2BBDC8ou6pEQ6WFtL38lhW11LqmrZbSPDLw1qc0w0sSPV3Uz0aIT3BKvumjOi/keQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TLE8aGEoRqFWo1p/W7higyXHiowxj9LgMCM6BtNncM=;
 b=kkZtCZ+D8jjwprJ8gzEppDNgCaOr76fVk4eeHMqpANXTdZSeruIjclWdsAq6AyRoKy0Fk8BgsMbBZCgkMLewsIzUMHty27IOffTHdGqA43d8U+2OvTlJ3mbesuLQo2jz+cR78ZTExgMotS8b1zpw4iY6rG6/kIh7FBGab+0CNuc0bzZMA4WRijmOmhQGRWlSWvMorZf1i8CgVOgE92Zn63LRrJmzDBj+b3xRSgCTzGeG6dQYFEnEKdn37vOzCmWTDnPlOWXnEz3RqikfVg8T6fTqg55oqzmjB5vkDiWGC9fBS1wY1FFXbLc5FYxzSw1H8MtUSiHVQBPxg4IUqoXteg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TLE8aGEoRqFWo1p/W7higyXHiowxj9LgMCM6BtNncM=;
 b=qXrRsHLcpK8KM4d/YpA8cg+aQ+CE/0xGQnq/MwswZtYRHjbN2pbk2MXa8V9tgYR2ELN67GTHOu1S9BTr6Avyw14zNbnURsaQND3IyX/wRxK+kyrSVVn2kVMXr/9fg3MG6LAV6bVa0GYAWc2CW55hLjxCbnDgQGWNMFRlaBeW/vA=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5428.namprd12.prod.outlook.com (2603:10b6:5:35c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 13 May
 2021 16:23:10 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b%6]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 16:23:10 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdkfd: disable kfd debugfs node of hang_hws on vf
 mode
Thread-Topic: [PATCH v2] drm/amdkfd: disable kfd debugfs node of hang_hws on
 vf mode
Thread-Index: AQHXR898diKJQQZCikicxQ+LUuL/RqrhkuYAgAAB9yA=
Date: Thu, 13 May 2021 16:23:10 +0000
Message-ID: <CO6PR12MB5473385A8A961A262F9667BDA2519@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20210513080839.35077-1-kevin1.wang@amd.com>,
 <c5a43b1b-cb2b-fc17-c956-166abdfc2231@amd.com>
In-Reply-To: <c5a43b1b-cb2b-fc17-c956-166abdfc2231@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Felix.Kuehling@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-13T16:23:10.308Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [112.65.12.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce6e07e9-067c-424d-ce90-08d9162b6672
x-ms-traffictypediagnostic: CO6PR12MB5428:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB5428337D905AD6C4E274830FA2519@CO6PR12MB5428.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ic9TqW2dWU18nUwOOqtgjbgBNJPBwD17dnEN5LOkb+Wb8M9LiVq5XsWfqrmbPEzwycbxw8J7M09Rt8NW1cLHyX9zfCYlAngURFu/uN1+rAJGLWel3BDo+tRr34XSmgt6BkcE4RIJRcX8PTm4oxcoN7u1JeMlpqaMqprHJ0j1+NoisbQXZG9wT+AJd/ayUkbjuKZrS2aLUce2/HgUvtORc1yGjlBE2s0IAd9KwiAevZONFjXRLCMuaIZyPnJ20nbQalyixk4H+pHzNP/2u6+esuU3rhxX3dnK8snIXfdDDVIdbMmZFtc1KjqLLVyhL+8akLk5QZxcjWQQxnoRQJj4hkt2gr+Pd0Tw3Lzn8iLMWm0FSopAiZrJ2w91Y/zA9hrn3/u1ZWUrjkAPyCSd/ZlqH5uwdxYOSFn9bnVO14Cm5Q1RezYG64HzCfTj8c4cVOqNrLj4HsZwnSNv2wWmM4tAgg0lIttqjtMmDKf+yWBdvm03hK1tOOwQnSppyFNwklPTRsTdCcwdEJB0xF+OMCGvUADflUYBMMjxOOjcyFvQyNzi9jwNVlX1nQqPpq1TMub37oGlN0DeWwMPA81JGNfd59Hgx5xCN3TODT0PxyhDGrM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(8676002)(316002)(478600001)(55016002)(26005)(110136005)(54906003)(86362001)(53546011)(6506007)(2906002)(7696005)(4326008)(38100700002)(19627405001)(71200400001)(122000001)(5660300002)(76116006)(91956017)(66446008)(66946007)(66476007)(64756008)(66556008)(33656002)(186003)(52536014)(9686003)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?g0VrgjCMqk1SbQIcYeFGC07m3gbh95Xft/CXFckc6TYbBytgUuu7LczcSY?=
 =?iso-8859-1?Q?wfeMqTuPkizeqAP+PRIKPDTxlWsgcqLRd8R/eUiEECUQODJntC1lcU3U0g?=
 =?iso-8859-1?Q?um1q7jSXPasocfxPndPxLXH/O+KTgicH5EJqtT9vQiWHYKo+iHEBGysK/m?=
 =?iso-8859-1?Q?KAX8/OUEbEMlQg08xgkrC8SlKOB59F/Xy1lSOQxQGKgRrmPAs4nwQJeMip?=
 =?iso-8859-1?Q?NIrlujaQ8hs4PQGXZvnBjtWqpFbURqxzwDHbbezpWThB+RTAcpcB6YF4oE?=
 =?iso-8859-1?Q?VbNoSP9y7x6vg2iavoPe0bzrjtvWfgscpLAXwE7YLfooUxvOOmNwgbGpVF?=
 =?iso-8859-1?Q?vkGKv1hNtmhBAZuD7vfUbSaRZaDWqxq85Sjs/0TOTvp0Gu/6mtL5nAzXg/?=
 =?iso-8859-1?Q?BlhFiISgQQ/Me+LBKGimRvJwzeeWi7yKsaHX6uyT95zwkBIFRg1U8SSlot?=
 =?iso-8859-1?Q?DK0jOiB1dDxAKbpYkk9LK+4srUZxLlvDc9bWl/wsBVckxYZv1CrsrNOO1o?=
 =?iso-8859-1?Q?OUaWOxoW2brsK46uvJtqgeHeuZFXuD+APn2W7uDYiKPP+jWWHUwo8gQqtY?=
 =?iso-8859-1?Q?G0pjRFY6hYc1y/yB7+rNcRdjGJBIPghtuuWueRCMUj8qvziPBM+IXz45kl?=
 =?iso-8859-1?Q?2J1IFrLsVugPUbtwSPavcTSfbJGS7IPHYDywOR9yghfQ3OyU7goWzo+Nq3?=
 =?iso-8859-1?Q?3Wh1DLu5yoZO8TcPt2xydZGwCVLMjIkaWNaX2t3wTG8Ymg1Eo99Gtv6MMU?=
 =?iso-8859-1?Q?P1DVaaWpOXhDj+CJphBbgA2HWjALTPrk12QcLuPjTkqCj2hM7IOlxPqjGd?=
 =?iso-8859-1?Q?fDKkO8TjLgC6aeB5ia71OCQLPJoY/pNfBJJUq72mUyPPsPoVEUT0vMAA6Q?=
 =?iso-8859-1?Q?Tfaj1bU/SEGy3V5Jx2Hyk9CsaBENQ3m4zSG/s7jKUuK3kz+hhbyFcFAB69?=
 =?iso-8859-1?Q?hXEDtwYUclfynrOnAaoAiIvWT9+FbQbUmYQfFrJ8RwPizdjs4i/OBwIDCc?=
 =?iso-8859-1?Q?UOYP6LBo2ywiEUlUf1KfV+mc9uEQjfub3chwgGQh3WIsAlO2/yNkM+FKGs?=
 =?iso-8859-1?Q?v0Kc1LX2IdBeWDTwcqggnPX7IwU8DRtHpwfnYL2fy+vG/SRHbvtN90mwNX?=
 =?iso-8859-1?Q?Tmn01L4WnL9wtH+gJO3dejV+kpaq1NJ4Ip6Ej0cLzbBTfy+nsGWhShIyNB?=
 =?iso-8859-1?Q?XmwHnFsUYAuZhMuBInTqBg8qXGBJtW6H1RzxjnameeAaFXYsfP8tr73TZr?=
 =?iso-8859-1?Q?xsvfcVRRzPjSi2cCPqE4UBDZ6X/h/n8atRBuoQIBrzs/caKLvn/mwhfb1D?=
 =?iso-8859-1?Q?sCWwDHmzG4j/ylgM0Vcd+W4sZMTxPOyylJeTGIyQnpW8x6Y=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6e07e9-067c-424d-ce90-08d9162b6672
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 16:23:10.6008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71JsCwidnlwfh5l+rX89jLCA4XU8BzW+l8nnVc056A15cpWKiFLG2wHY9xcso3wb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5428
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
Cc: "Min, Frank" <Frank.Min@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1191517803=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1191517803==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CO6PR12MB5473385A8A961A262F9667BDA2519CO6PR12MB5473namp_"

--_000_CO6PR12MB5473385A8A961A262F9667BDA2519CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

thanks @Kuehling, Felix<mailto:Felix.Kuehling@amd.com>,
I have also noticed this problem, in the multi-GPU environment, there is no=
 working well.

Best Regards,
Kevin
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Friday, May 14, 2021 12:01 AM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Min, Frank <Frank.Min@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: disable kfd debugfs node of hang_hws on=
 vf mode

This won't work. the kfd_debugfs directory is system-wide. So you cannot
have a per-GPU criteria for creating it. You may have one GPU that
probes successfully, another that fails. You still need the debugfs. If
you have multiple GPUs probing successfully, you only want to create the
debugfs node once.

The hang_hws file requires writing a GPU-ID to it. So if a card doesn't
probe it won't have a GPU ID, so you won't be able to hang that card
through the hang_hws interface. So there is no need to hide the file
altogether.

Can you explain why hang_hws should be disabled for VFs?

Thanks,
  Felix

Am 2021-05-13 um 4:08 a.m. schrieb Kevin Wang:

> v1:
> the kfd debugfs node is rely on kgd2kfd probe success,
> if not, the kfd_debugfs should not be created,
> and the node of "hang_hws" should be disabled on vf mode.
>
> v2:
> also move kfd_debugfs_fini() into kgd2kfd_device_exit() function.
>
> 1. move kfd_debugfs_init() function into kgd2kfd_probe() function.
> 2. disable "hang_hws" debugfs node on vf mode.
>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 7 ++++---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c  | 3 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_module.c  | 3 ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 4 ++--
>  4 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_debugfs.c
> index 673d5e34f213..f9a81f34d09e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> @@ -88,7 +88,7 @@ static const struct file_operations kfd_debugfs_hang_hw=
s_fops =3D {
>        .release =3D single_release,
>  };
>
> -void kfd_debugfs_init(void)
> +void kfd_debugfs_init(bool is_vf)
>  {
>        debugfs_root =3D debugfs_create_dir("kfd", NULL);
>
> @@ -98,8 +98,9 @@ void kfd_debugfs_init(void)
>                            kfd_debugfs_hqds_by_device, &kfd_debugfs_fops)=
;
>        debugfs_create_file("rls", S_IFREG | 0444, debugfs_root,
>                            kfd_debugfs_rls_by_device, &kfd_debugfs_fops);
> -     debugfs_create_file("hang_hws", S_IFREG | 0200, debugfs_root,
> -                         kfd_debugfs_hang_hws_read, &kfd_debugfs_hang_hw=
s_fops);
> +     if (!is_vf)
> +             debugfs_create_file("hang_hws", S_IFREG | 0200, debugfs_roo=
t,
> +                                 kfd_debugfs_hang_hws_read, &kfd_debugfs=
_hang_hws_fops);
>  }
>
>  void kfd_debugfs_fini(void)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index dedb8e33b953..aa9154a8410f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -649,6 +649,8 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>
>        ida_init(&kfd->doorbell_ida);
>
> +     kfd_debugfs_init(vf);
> +
>        return kfd;
>  }
>
> @@ -884,6 +886,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>                        amdgpu_amdkfd_free_gws(kfd->kgd, kfd->gws);
>        }
>
> +     kfd_debugfs_fini();
>        kfree(kfd);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_module.c
> index 5e90fe642192..6b9f735c55ea 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> @@ -61,8 +61,6 @@ static int kfd_init(void)
>         */
>        kfd_procfs_init();
>
> -     kfd_debugfs_init();
> -
>        return 0;
>
>  err_create_wq:
> @@ -76,7 +74,6 @@ static int kfd_init(void)
>
>  static void kfd_exit(void)
>  {
> -     kfd_debugfs_fini();
>        kfd_process_destroy_wq();
>        kfd_procfs_shutdown();
>        kfd_topology_shutdown();
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index daa9d47514c6..f3ddd8c5b11e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1174,7 +1174,7 @@ static inline int kfd_devcgroup_check_permission(st=
ruct kfd_dev *kfd)
>  /* Debugfs */
>  #if defined(CONFIG_DEBUG_FS)
>
> -void kfd_debugfs_init(void);
> +void kfd_debugfs_init(bool is_vf);
>  void kfd_debugfs_fini(void);
>  int kfd_debugfs_mqds_by_process(struct seq_file *m, void *data);
>  int pqm_debugfs_mqds(struct seq_file *m, void *data);
> @@ -1189,7 +1189,7 @@ int dqm_debugfs_execute_queues(struct device_queue_=
manager *dqm);
>
>  #else
>
> -static inline void kfd_debugfs_init(void) {}
> +static inline void kfd_debugfs_init(bool is_vf) {}
>  static inline void kfd_debugfs_fini(void) {}
>
>  #endif

--_000_CO6PR12MB5473385A8A961A262F9667BDA2519CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
thanks <a id=3D"OWAAM892348" class=3D"_1OtrSZdhKXVv3UhaivrdJ4 mention ms-bg=
c-nlr ms-fcl-b" href=3D"mailto:Felix.Kuehling@amd.com">
@Kuehling, Felix</a>,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I have also noticed this problem, in the multi-GPU environment, there is no=
 working well.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Friday, May 14, 2021 12:01 AM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Min, Frank &lt;Fra=
nk.Min@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amdkfd: disable kfd debugfs node of hang=
_hws on vf mode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">This won't work. the kfd_debugfs directory is syst=
em-wide. So you cannot<br>
have a per-GPU criteria for creating it. You may have one GPU that<br>
probes successfully, another that fails. You still need the debugfs. If<br>
you have multiple GPUs probing successfully, you only want to create the<br=
>
debugfs node once.<br>
<br>
The hang_hws file requires writing a GPU-ID to it. So if a card doesn't<br>
probe it won't have a GPU ID, so you won't be able to hang that card<br>
through the hang_hws interface. So there is no need to hide the file<br>
altogether.<br>
<br>
Can you explain why hang_hws should be disabled for VFs?<br>
<br>
Thanks,<br>
&nbsp; Felix<br>
<br>
Am 2021-05-13 um 4:08 a.m. schrieb Kevin Wang:<br>
<br>
&gt; v1:<br>
&gt; the kfd debugfs node is rely on kgd2kfd probe success,<br>
&gt; if not, the kfd_debugfs should not be created,<br>
&gt; and the node of &quot;hang_hws&quot; should be disabled on vf mode.<br=
>
&gt;<br>
&gt; v2:<br>
&gt; also move kfd_debugfs_fini() into kgd2kfd_device_exit() function.<br>
&gt;<br>
&gt; 1. move kfd_debugfs_init() function into kgd2kfd_probe() function.<br>
&gt; 2. disable &quot;hang_hws&quot; debugfs node on vf mode.<br>
&gt;<br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 7 ++++---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device.c&nbsp; | 3 +++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_module.c&nbsp; | 3 ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; | 4 ++--=
<br>
&gt;&nbsp; 4 files changed, 9 insertions(+), 8 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_debugfs.c<br>
&gt; index 673d5e34f213..f9a81f34d09e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c<br>
&gt; @@ -88,7 +88,7 @@ static const struct file_operations kfd_debugfs_hang=
_hws_fops =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release =3D single_release,=
<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt; -void kfd_debugfs_init(void)<br>
&gt; +void kfd_debugfs_init(bool is_vf)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_root =3D debugfs_cre=
ate_dir(&quot;kfd&quot;, NULL);<br>
&gt;&nbsp; <br>
&gt; @@ -98,8 +98,9 @@ void kfd_debugfs_init(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; kfd_debugfs_hqds_by_device, &amp;kfd_debugfs_fops);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;rl=
s&quot;, S_IFREG | 0444, debugfs_root,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; kfd_debugfs_rls_by_device, &amp;kfd_debugfs_fops);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;hang_hws&quot;, S_=
IFREG | 0200, debugfs_root,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 kfd_debugfs_hang_hws_read, &amp;kfd_debugfs_hang_hws_fops);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!is_vf)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; debugfs_create_file(&quot;hang_hws&quot;, S_IFREG | 0200, debugfs_root,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_debugfs_hang_hws_read,=
 &amp;kfd_debugfs_hang_hws_fops);<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; void kfd_debugfs_fini(void)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_device.c<br>
&gt; index dedb8e33b953..aa9154a8410f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt; @@ -649,6 +649,8 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,=
<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ida_init(&amp;kfd-&gt;doorbe=
ll_ida);<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfd_debugfs_init(vf);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return kfd;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; @@ -884,6 +886,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
amdkfd_free_gws(kfd-&gt;kgd, kfd-&gt;gws);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfd_debugfs_fini();<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(kfd);<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_module.c<br>
&gt; index 5e90fe642192..6b9f735c55ea 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c<br>
&gt; @@ -61,8 +61,6 @@ static int kfd_init(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_procfs_init();<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; kfd_debugfs_init();<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; <br>
&gt;&nbsp; err_create_wq:<br>
&gt; @@ -76,7 +74,6 @@ static int kfd_init(void)<br>
&gt;&nbsp; <br>
&gt;&nbsp; static void kfd_exit(void)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; kfd_debugfs_fini();<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_destroy_wq();<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_procfs_shutdown();<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_topology_shutdown();<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/a=
md/amdkfd/kfd_priv.h<br>
&gt; index daa9d47514c6..f3ddd8c5b11e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; @@ -1174,7 +1174,7 @@ static inline int kfd_devcgroup_check_permission=
(struct kfd_dev *kfd)<br>
&gt;&nbsp; /* Debugfs */<br>
&gt;&nbsp; #if defined(CONFIG_DEBUG_FS)<br>
&gt;&nbsp; <br>
&gt; -void kfd_debugfs_init(void);<br>
&gt; +void kfd_debugfs_init(bool is_vf);<br>
&gt;&nbsp; void kfd_debugfs_fini(void);<br>
&gt;&nbsp; int kfd_debugfs_mqds_by_process(struct seq_file *m, void *data);=
<br>
&gt;&nbsp; int pqm_debugfs_mqds(struct seq_file *m, void *data);<br>
&gt; @@ -1189,7 +1189,7 @@ int dqm_debugfs_execute_queues(struct device_que=
ue_manager *dqm);<br>
&gt;&nbsp; <br>
&gt;&nbsp; #else<br>
&gt;&nbsp; <br>
&gt; -static inline void kfd_debugfs_init(void) {}<br>
&gt; +static inline void kfd_debugfs_init(bool is_vf) {}<br>
&gt;&nbsp; static inline void kfd_debugfs_fini(void) {}<br>
&gt;&nbsp; <br>
&gt;&nbsp; #endif<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473385A8A961A262F9667BDA2519CO6PR12MB5473namp_--

--===============1191517803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1191517803==--
