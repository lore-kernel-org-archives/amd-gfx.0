Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D8FC43331
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 16:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B556D2077C
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 16:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B556D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FBE96F74E;
	Thu,  7 Nov 2019 16:57:03 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700089.outbound.protection.outlook.com [40.107.70.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CEC36F74E
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 16:57:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAe8GukvOOtawSwoE2o1A5vRv19S58d/ygbTpL0ANhYV6InkvVYVAhxOSVwyK3cn/Y7n0br3tNtl8/2CDriei7CNcpzA5c0ZiggwK6n9nrWVim5CtoQAuZRQstcYPsGrDTOA34+4F7SyECmZvRK9OwDL8bF/za4G51VAkvQl3AowxNX53hXIJKwWMu6I3l46r7W83qnWwM9Egzv3xrnsLibMWWY0pApIbT6T4i94HhuJIYr0hZxDsQ2oTyJwc/QOag9kjU0DzHHE469EQ90DUx4efUVUFAAFrc4M4tHnELO53tT/9n61YgLzJ080en5aLX+Jl2BWQA4cPF2IxVnO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm18Fn3iFegnzC3MPEjWVDuYr8mcddmHWRcyra3D4yU=;
 b=XEeXcOfJX5uqRCs2feSHGxHnl5DQ2pMviS0bGfnXHXm1YsYzWzPkiXbIILSiQPtY12eHeguw38TufqEpoN4qOybDnrEVspzJ8BD9Va6Nw+MzfxCOGD4SthiCKxcROXPI7uzdghimHdepSAovQkuJCuI8W1M81Kih5SResJ9omXEjGBjNSpGjkAJ7VjHrbb8FUlsCf+NKepYRWSJ/KiQ7Bg5yq8SSJYxBFKygkka4iDUirjXC8mlXePsZj93e/3DkSdS+Bi4JLdVpluYx+LKd8W5Q1vSW9jspQ9Cacin3G3C2ecD6EHB78/ybWavAtHi06vxUpJIyFwJR/MCx6uqWFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Thu, 7 Nov 2019 16:57:00 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 16:57:00 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Hawaii
Thread-Topic: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Hawaii
Thread-Index: AQHVj4CkSMtAMFLs5U2ND/zZPFxaw6d/LUyAgADMBUo=
Date: Thu, 7 Nov 2019 16:57:00 +0000
Message-ID:
 <DM6PR12MB2778C141CFEA0006DA2CEC6DF0780@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191031001739.10764-1-Yong.Zhao@amd.com>
 <20191031001739.10764-2-Yong.Zhao@amd.com>,
 <31102345-20f7-1b0e-dd2a-f7984b253a07@amd.com>
In-Reply-To: <31102345-20f7-1b0e-dd2a-f7984b253a07@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 106c9088-d7c5-4a31-1972-08d763a381a7
x-ms-traffictypediagnostic: DM6PR12MB3355:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB335566399D68AC5DDA0C06DDF0780@DM6PR12MB3355.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(478600001)(229853002)(81156014)(14444005)(76116006)(91956017)(81166006)(86362001)(9686003)(54896002)(6436002)(55016002)(256004)(4001150100001)(66446008)(14454004)(6246003)(25786009)(2501003)(8676002)(52536014)(66946007)(66556008)(64756008)(66476007)(186003)(486006)(316002)(19627405001)(110136005)(66066001)(33656002)(74316002)(26005)(7696005)(102836004)(7736002)(446003)(11346002)(76176011)(53546011)(6506007)(476003)(8936002)(3846002)(6116002)(5660300002)(2906002)(99286004)(105004)(71200400001)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3355;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7eYkjQbbpaT5O8IdHik0VSIQle6jqi7Q/ECw2NXa1eFTiGO+vsajv+Vd3DRCDRS1G5m9NRjtHqyvpZtAegiUmepLCv0F445dSXbMpawanAHK7y7IgeNYMs0k+S3sklYAk1V1BjqvYjZjBkJlaffuWdDUZ6yr5HJjmoTanOKuHSYYAiDXzSU8FquHLdf4D2GkzRaxVU+RR2MP/JK6g65spQ0APpHezmqTcV4drEpwIo5Tjl/2GZE3cAQoT5rESPK8Hr5ecNuwf2FCENNzVAFnsm7hOTDesdEP/gQkYniR46mAZq38wJ27Xg7ZKpRm6q9+UE5oBHCT2CJB0CNM2BtH5+FWS9gZ1nUsFu91m62fu2OJjCf0E4ikHGJj/DwUp/3LF+XT3LUYBTn0fjX9X9tDmDuqV7C1AfxeLvLkL44KqGP1CsnXZHDt/erxQqVBXaVT
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106c9088-d7c5-4a31-1972-08d763a381a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 16:57:00.0766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82x14QgfPis0wKYN7esrny3p8S16pbI3OJLJc8D6J4i1u1gpMGBq9oYRgZolCfTR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3355
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm18Fn3iFegnzC3MPEjWVDuYr8mcddmHWRcyra3D4yU=;
 b=xFRAIIGrO0nIuOzF3xhDEPrkHaHE8GIHzynQthBkvViUbxvWkCqwuIweVjBzNvXtOvmmpQC3WbyBChVhD1zPwOHm45JTc+MwUAnslWh8KRadmjlDkRwJCY9I8dOEEX80WSzqJH7jkehfOVhpbr3fmNTRixuGVSHfDO/njR68MSg=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0676136989=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107165700.YxKdbIa8RmGqhcl1EEcIQUKsBwFRbcGg7tcF9TYWjQY@z>

--===============0676136989==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2778C141CFEA0006DA2CEC6DF0780DM6PR12MB2778namp_"

--_000_DM6PR12MB2778C141CFEA0006DA2CEC6DF0780DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Felix,

That's because v8 and v7 share the same packet_manager_funcs. In this case,=
 it is better to keep it as it is.

Regards,
Yong
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Wednesday, November 6, 2019 11:45 PM
To: Zhao, Yong <Yong.Zhao@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Haw=
aii

On 2019-10-30 20:17, Zhao, Yong wrote:
> release_mem won't be used at all on GFX9 and GFX10, so delete it.

Hawaii was GFXv7. So we're not using the release_mem packet on GFXv8
either. Why arbitrarily limit this change to GFXv9 and 10?

Regards,
   Felix

>
> Change-Id: I13787a8a29b83e7516c582a7401f2e14721edf5f
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
> ---
>   .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c | 35 ++-----------------
>   .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c  | 33 ++---------------
>   2 files changed, 4 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c b/drivers/=
gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
> index aed32ab7102e..bfd6221acae9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
> @@ -298,37 +298,6 @@ static int pm_query_status_v10(struct packet_manager=
 *pm, uint32_t *buffer,
>        return 0;
>   }
>
> -
> -static int pm_release_mem_v10(uint64_t gpu_addr, uint32_t *buffer)
> -{
> -     struct pm4_mec_release_mem *packet;
> -
> -     WARN_ON(!buffer);
> -
> -     packet =3D (struct pm4_mec_release_mem *)buffer;
> -     memset(buffer, 0, sizeof(struct pm4_mec_release_mem));
> -
> -     packet->header.u32All =3D pm_build_pm4_header(IT_RELEASE_MEM,
> -                                     sizeof(struct pm4_mec_release_mem))=
;
> -
> -     packet->bitfields2.event_type =3D CACHE_FLUSH_AND_INV_TS_EVENT;
> -     packet->bitfields2.event_index =3D event_index__mec_release_mem__en=
d_of_pipe;
> -     packet->bitfields2.tcl1_action_ena =3D 1;
> -     packet->bitfields2.tc_action_ena =3D 1;
> -     packet->bitfields2.cache_policy =3D cache_policy__mec_release_mem__=
lru;
> -
> -     packet->bitfields3.data_sel =3D data_sel__mec_release_mem__send_32_=
bit_low;
> -     packet->bitfields3.int_sel =3D
> -             int_sel__mec_release_mem__send_interrupt_after_write_confir=
m;
> -
> -     packet->bitfields4.address_lo_32b =3D (gpu_addr & 0xffffffff) >> 2;
> -     packet->address_hi =3D upper_32_bits(gpu_addr);
> -
> -     packet->data_lo =3D 0;
> -
> -     return sizeof(struct pm4_mec_release_mem) / sizeof(unsigned int);
> -}
> -
>   const struct packet_manager_funcs kfd_v10_pm_funcs =3D {
>        .map_process                    =3D pm_map_process_v10,
>        .runlist                        =3D pm_runlist_v10,
> @@ -336,13 +305,13 @@ const struct packet_manager_funcs kfd_v10_pm_funcs =
=3D {
>        .map_queues                     =3D pm_map_queues_v10,
>        .unmap_queues                   =3D pm_unmap_queues_v10,
>        .query_status                   =3D pm_query_status_v10,
> -     .release_mem                    =3D pm_release_mem_v10,
> +     .release_mem                    =3D NULL,
>        .map_process_size               =3D sizeof(struct pm4_mes_map_proc=
ess),
>        .runlist_size                   =3D sizeof(struct pm4_mes_runlist)=
,
>        .set_resources_size             =3D sizeof(struct pm4_mes_set_reso=
urces),
>        .map_queues_size                =3D sizeof(struct pm4_mes_map_queu=
es),
>        .unmap_queues_size              =3D sizeof(struct pm4_mes_unmap_qu=
eues),
>        .query_status_size              =3D sizeof(struct pm4_mes_query_st=
atus),
> -     .release_mem_size               =3D sizeof(struct pm4_mec_release_m=
em)
> +     .release_mem_size               =3D 0,
>   };
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> index 3b5ca2b1d7a6..f0e4910a8865 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> @@ -336,35 +336,6 @@ static int pm_query_status_v9(struct packet_manager =
*pm, uint32_t *buffer,
>        return 0;
>   }
>
> -
> -static int pm_release_mem_v9(uint64_t gpu_addr, uint32_t *buffer)
> -{
> -     struct pm4_mec_release_mem *packet;
> -
> -     packet =3D (struct pm4_mec_release_mem *)buffer;
> -     memset(buffer, 0, sizeof(struct pm4_mec_release_mem));
> -
> -     packet->header.u32All =3D pm_build_pm4_header(IT_RELEASE_MEM,
> -                                     sizeof(struct pm4_mec_release_mem))=
;
> -
> -     packet->bitfields2.event_type =3D CACHE_FLUSH_AND_INV_TS_EVENT;
> -     packet->bitfields2.event_index =3D event_index__mec_release_mem__en=
d_of_pipe;
> -     packet->bitfields2.tcl1_action_ena =3D 1;
> -     packet->bitfields2.tc_action_ena =3D 1;
> -     packet->bitfields2.cache_policy =3D cache_policy__mec_release_mem__=
lru;
> -
> -     packet->bitfields3.data_sel =3D data_sel__mec_release_mem__send_32_=
bit_low;
> -     packet->bitfields3.int_sel =3D
> -             int_sel__mec_release_mem__send_interrupt_after_write_confir=
m;
> -
> -     packet->bitfields4.address_lo_32b =3D (gpu_addr & 0xffffffff) >> 2;
> -     packet->address_hi =3D upper_32_bits(gpu_addr);
> -
> -     packet->data_lo =3D 0;
> -
> -     return 0;
> -}
> -
>   const struct packet_manager_funcs kfd_v9_pm_funcs =3D {
>        .map_process            =3D pm_map_process_v9,
>        .runlist                =3D pm_runlist_v9,
> @@ -372,12 +343,12 @@ const struct packet_manager_funcs kfd_v9_pm_funcs =
=3D {
>        .map_queues             =3D pm_map_queues_v9,
>        .unmap_queues           =3D pm_unmap_queues_v9,
>        .query_status           =3D pm_query_status_v9,
> -     .release_mem            =3D pm_release_mem_v9,
> +     .release_mem            =3D NULL,
>        .map_process_size       =3D sizeof(struct pm4_mes_map_process),
>        .runlist_size           =3D sizeof(struct pm4_mes_runlist),
>        .set_resources_size     =3D sizeof(struct pm4_mes_set_resources),
>        .map_queues_size        =3D sizeof(struct pm4_mes_map_queues),
>        .unmap_queues_size      =3D sizeof(struct pm4_mes_unmap_queues),
>        .query_status_size      =3D sizeof(struct pm4_mes_query_status),
> -     .release_mem_size       =3D sizeof(struct pm4_mec_release_mem)
> +     .release_mem_size       =3D 0,
>   };

--_000_DM6PR12MB2778C141CFEA0006DA2CEC6DF0780DM6PR12MB2778namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Felix,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
That's because v8 and v7 share the same <span style=3D"font-family: &quot;S=
egoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 14.6667px; background-color: rgb(255, 255, 255); dis=
play: inline !important">
packet_manager_funcs. In this case, it is better to keep it as it is.</span=
></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important">Regards,</span>=
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important">Yong</span></di=
v>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 6, 2019 11:45 PM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function =
for Hawaii</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2019-10-30 20:17, Zhao, Yong wrote:<br>
&gt; release_mem won't be used at all on GFX9 and GFX10, so delete it.<br>
<br>
Hawaii was GFXv7. So we're not using the release_mem packet on GFXv8 <br>
either. Why arbitrarily limit this change to GFXv9 and 10?<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
&gt;<br>
&gt; Change-Id: I13787a8a29b83e7516c582a7401f2e14721edf5f<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c | 35 &#43;&#=
43;-----------------<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c&nbsp; | 33 &#=
43;&#43;---------------<br>
&gt;&nbsp;&nbsp; 2 files changed, 4 insertions(&#43;), 64 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c<br>
&gt; index aed32ab7102e..bfd6221acae9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c<br=
>
&gt; @@ -298,37 &#43;298,6 @@ static int pm_query_status_v10(struct packet_=
manager *pm, uint32_t *buffer,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -<br>
&gt; -static int pm_release_mem_v10(uint64_t gpu_addr, uint32_t *buffer)<br=
>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct pm4_mec_release_mem *packet;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(!buffer);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet =3D (struct pm4_mec_release_mem *)buf=
fer;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(buffer, 0, sizeof(struct pm4_mec_rele=
ase_mem));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;header.u32All =3D pm_build_pm4_he=
ader(IT_RELEASE_MEM,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si=
zeof(struct pm4_mec_release_mem));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.event_type =3D CACHE_F=
LUSH_AND_INV_TS_EVENT;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.event_index =3D event_=
index__mec_release_mem__end_of_pipe;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.tcl1_action_ena =3D 1;=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.tc_action_ena =3D 1;<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.cache_policy =3D cache=
_policy__mec_release_mem__lru;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.data_sel =3D data_sel_=
_mec_release_mem__send_32_bit_low;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.int_sel =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; int_sel__mec_release_mem__send_interrupt_after_write_confirm;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields4.address_lo_32b =3D (gp=
u_addr &amp; 0xffffffff) &gt;&gt; 2;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;address_hi =3D upper_32_bits(gpu_=
addr);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;data_lo =3D 0;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct pm4_mec_release_mem) / =
sizeof(unsigned int);<br>
&gt; -}<br>
&gt; -<br>
&gt;&nbsp;&nbsp; const struct packet_manager_funcs kfd_v10_pm_funcs =3D {<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_process&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =3D pm_map_process_v10,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .runlist&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_runlist_v10,<br>
&gt; @@ -336,13 &#43;305,13 @@ const struct packet_manager_funcs kfd_v10_pm=
_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_queues&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_map_queues_v10,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D pm_unmap_queues_v10,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_status&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D pm_query_status_v10,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =3D pm_release_mem_v10,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =3D NULL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_process_size&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D sizeof(struct pm4_mes_map_process),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .runlist_size&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_runlist),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_resources_size&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(=
struct pm4_mes_set_resources),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_queues_size&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D sizeof(struct pm4_mes_map_queues),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues_size&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D si=
zeof(struct pm4_mes_unmap_queues),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_status_size&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D si=
zeof(struct pm4_mes_query_status),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct=
 pm4_mec_release_mem)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0,<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c<br>
&gt; index 3b5ca2b1d7a6..f0e4910a8865 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c<br>
&gt; @@ -336,35 &#43;336,6 @@ static int pm_query_status_v9(struct packet_m=
anager *pm, uint32_t *buffer,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -<br>
&gt; -static int pm_release_mem_v9(uint64_t gpu_addr, uint32_t *buffer)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct pm4_mec_release_mem *packet;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet =3D (struct pm4_mec_release_mem *)buf=
fer;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(buffer, 0, sizeof(struct pm4_mec_rele=
ase_mem));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;header.u32All =3D pm_build_pm4_he=
ader(IT_RELEASE_MEM,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si=
zeof(struct pm4_mec_release_mem));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.event_type =3D CACHE_F=
LUSH_AND_INV_TS_EVENT;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.event_index =3D event_=
index__mec_release_mem__end_of_pipe;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.tcl1_action_ena =3D 1;=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.tc_action_ena =3D 1;<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.cache_policy =3D cache=
_policy__mec_release_mem__lru;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.data_sel =3D data_sel_=
_mec_release_mem__send_32_bit_low;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.int_sel =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; int_sel__mec_release_mem__send_interrupt_after_write_confirm;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields4.address_lo_32b =3D (gp=
u_addr &amp; 0xffffffff) &gt;&gt; 2;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;address_hi =3D upper_32_bits(gpu_=
addr);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;data_lo =3D 0;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; -}<br>
&gt; -<br>
&gt;&nbsp;&nbsp; const struct packet_manager_funcs kfd_v9_pm_funcs =3D {<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_process&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_map_process_v9,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .runlist&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
pm_runlist_v9,<br>
&gt; @@ -372,12 &#43;343,12 @@ const struct packet_manager_funcs kfd_v9_pm_=
funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_queues&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_map_queues_v=
9,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_unmap_queues_v9,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_status&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_query_status_v9,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_release_mem_v9,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D NULL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_process_size&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_map_process),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .runlist_size&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_run=
list),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_resources_size&nbsp;&nb=
sp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_set_resources),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_queues_size&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_map_queues),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues_size&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_unmap_queues),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_status_size&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_query_status),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; =3D sizeof(struct pm4_mec_release_mem)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =3D 0,<br>
&gt;&nbsp;&nbsp; };<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB2778C141CFEA0006DA2CEC6DF0780DM6PR12MB2778namp_--

--===============0676136989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0676136989==--
