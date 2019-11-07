Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C088DC43331
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 17:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC812085B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 17:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC812085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E436F75E;
	Thu,  7 Nov 2019 17:33:32 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680075.outbound.protection.outlook.com [40.107.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 129186F75B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 17:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1gk/RDReBkMnmMuX9pZEqO6EusgbEQIR00hTMeplsscLAe5MOeQ9UE9nn60cIKhjEPe2BrNh5YWGetAd5rZC5lW8pqk+0AZqG1glOC8j/8f9N22LqrdTA9Xu68Lk5tIOWfyGyqZpPqKuZtSRLxxt12t/khptoAuaRYvs4w3ME9NcAX1funGDQAPpQGH1ILKeTmiI5ffrgp591nObB+ardBup7/K3fsLWTAk2YmHPQ4F4y779XIKpdIpBhWQYoYz+fQWohbpwt8KFvCluw2wouJ9sJJCmimBwgATecSFrK0EV/e6m7ZNcWXFkHJ+8wJ0ax3jZAcv+Borxmh26GJoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGPs7DzTSkfssEZJSMSRxCruRqc4lzI7PC8R/1zJsh0=;
 b=CwQ9UbpdrqeFA/kRK+ypki6MxmsJDnTeF1TsjMSPPZgCJr6o6j2OQXPGXhZyS3rwTEI3hPlltPgDRCPT6Ge7icObkF3TzNBQMndzwFObWIQzraig732OUp9THEtgA9qfYeZ5vSEDzG6Jcf2/tsbXttatSfcCACgU+8rmvGEg9XptL1LrTj9NFV4mKxgdU7NNPD88ITlJcybCgztt7aZkdG6jbbYLhh3L+PLoDoUROYLOfmjaNtNRZGRcJvArC3m6PoNOR8/j7/ykDM0HNS2w6mIO4NAJUrsGuM8c+J2Jdlfl8BvHXDdYltHuFc2jkz+E5IO8TcLnWaPozcwejKY7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR1201MB2533.namprd12.prod.outlook.com (10.172.120.151) by
 CY4PR1201MB0006.namprd12.prod.outlook.com (10.172.117.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Thu, 7 Nov 2019 17:33:27 +0000
Received: from CY4PR1201MB2533.namprd12.prod.outlook.com
 ([fe80::7d54:3475:ff9b:694b]) by CY4PR1201MB2533.namprd12.prod.outlook.com
 ([fe80::7d54:3475:ff9b:694b%10]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 17:33:27 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Hawaii
Thread-Topic: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Hawaii
Thread-Index: AQHVj4CooXRVzQZmH0qiYB3kyba1qqd/LUyAgADMcACAAAlP0A==
Date: Thu, 7 Nov 2019 17:33:27 +0000
Message-ID:
 <CY4PR1201MB2533087B346C4619F461FF3185780@CY4PR1201MB2533.namprd12.prod.outlook.com>
References: <20191031001739.10764-1-Yong.Zhao@amd.com>
 <20191031001739.10764-2-Yong.Zhao@amd.com>,
 <31102345-20f7-1b0e-dd2a-f7984b253a07@amd.com>
 <DM6PR12MB2778C141CFEA0006DA2CEC6DF0780@DM6PR12MB2778.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2778C141CFEA0006DA2CEC6DF0780@DM6PR12MB2778.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2607:fea8:1c80:d46:25:1c12:1491:5915]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9bb2098e-d152-4eff-c586-08d763a89986
x-ms-traffictypediagnostic: CY4PR1201MB0006:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB000624BA53099E892EDBA56585780@CY4PR1201MB0006.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(51444003)(199004)(189003)(110136005)(14444005)(71200400001)(71190400001)(256004)(5660300002)(76176011)(316002)(64756008)(86362001)(102836004)(53546011)(76116006)(4001150100001)(66946007)(66476007)(66556008)(6506007)(99286004)(81156014)(14454004)(81166006)(8676002)(8936002)(7696005)(236005)(2501003)(6246003)(33656002)(9686003)(74316002)(2906002)(476003)(11346002)(52536014)(66446008)(25786009)(446003)(486006)(790700001)(229853002)(55016002)(6116002)(6306002)(6436002)(478600001)(54896002)(7736002)(46003)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0006;
 H:CY4PR1201MB2533.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GLR4aeHyrEj9xrUxkcKxB8X3XtxN/GN4MuL5LceAgxw060fBrBm5wrYeOZnnPwu8s1UhJNeQE3/mJbSYVPtsyu9Gs6xVyV2gdopNM8TV/ubkyhmYcNCoipWRMii838NUxY6ZkILXrd9XfQ8Z0TAn5jOKWKUDJ19yGXzieH7SAgigzEzVeCMsm24T+GqToYErN0OiSrIum7RRw/pgeG3m7YYXS+3GQOyM8Hbv7sFybx1ceXsael2Pd3IvNUtN8MaWXOJ9yrr9JnqMdRw7dr4T5NGbKfQuoSXsIyuPeOdMP2P3GwpWH/JT4FtD2MYhCY5UOf/7xbpD4iOJS5t3ja0Ygs/IhDdFKjcOfdEWueTmDDUATrlyFv53QjuLnsKP8sVekYYFQ1bf9waXRjm8fk7nvpBjX9agxdvYucSZVsdxLQ8ZAhlg1Pq1Po167Zd9iVsB
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb2098e-d152-4eff-c586-08d763a89986
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 17:33:27.5747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ba+BjtkMU5wI3hhpJ0UHY5XrSg2y+hNArjhIBIe+mKSdYoEOGjZ1ACG0Nn3x5tVO4m26detjoSxmr1aF6MjFpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0006
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGPs7DzTSkfssEZJSMSRxCruRqc4lzI7PC8R/1zJsh0=;
 b=yb3OvRny63Idp3MF8vdCynTiT0CdYvr4PlS9ATe8i+xfx/5qXYVjkYmjFPMpUVaJr58U2VPcfkMFqv9+qal33GbF7xLAgaE4LUXZ+nFe2qZ7uL4QiMmJT+WM86o34yjHCqaAQ9CM07ewHfyO6y80+rQXn8ivFIKhG1fonlYRwtc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
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
Content-Type: multipart/mixed; boundary="===============0961424190=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107173327.ggjZ3dzZpsLB0aT_uwQtcEx9hmQk2wGmdyE0oVt9GXQ@z>

--===============0961424190==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1201MB2533087B346C4619F461FF3185780CY4PR1201MB2533_"

--_000_CY4PR1201MB2533087B346C4619F461FF3185780CY4PR1201MB2533_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I think that the versioning is getting a little confusing since we're using=
 the old GFX versions, but not really sticking to it due to the shareabilit=
y of certain managers and shaders. Could we look into doing something like =
gen1 or gen2, or some other more ambiguous non-GFX-related versioning? Othe=
rwise we'll keep having these questions of "why is Hawaii GFX8", "why is Ar=
cturus GFX9", etc. Then if things change, we just up the value concretely, =
instead of maybe doing a v11 if GFX11 changes things, and only GFX11 ASICs =
use those functions/variables.

Obviously not high-priority, but maybe something to consider as you continu=
e to consolidate and remove duplicate code.

Kent

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhao, Yo=
ng
Sent: Thursday, November 7, 2019 11:57 AM
To: Kuehling, Felix <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Haw=
aii

Hi Felix,

That's because v8 and v7 share the same packet_manager_funcs. In this case,=
 it is better to keep it as it is.

Regards,
Yong
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com=
>>
Sent: Wednesday, November 6, 2019 11:45 PM
To: Zhao, Yong <Yong.Zhao@amd.com<mailto:Yong.Zhao@amd.com>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freed=
esktop.org<mailto:amd-gfx@lists.freedesktop.org>>
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
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com<mailto:Yong.Zhao@amd.com>>
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

--_000_CY4PR1201MB2533087B346C4619F461FF3185780CY4PR1201MB2533_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">I think that the versioning is getting a little conf=
using since we&#8217;re using the old GFX versions, but not really sticking=
 to it due to the shareability of certain managers and shaders. Could we lo=
ok into doing something like gen1 or gen2,
 or some other more ambiguous non-GFX-related versioning? Otherwise we&#821=
7;ll keep having these questions of &#8220;why is Hawaii GFX8&#8221;, &#822=
0;why is Arcturus GFX9&#8221;, etc. Then if things change, we just up the v=
alue concretely, instead of maybe doing a v11 if GFX11 changes
 things, and only GFX11 ASICs use those functions/variables. <o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Obviously not high-priority, but maybe something to =
consider as you continue to consolidate and remove duplicate code.<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Kent<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Zhao, Yong<br>
<b>Sent:</b> Thursday, November 7, 2019 11:57 AM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; amd-gfx@lists.fr=
eedesktop.org<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function =
for Hawaii<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Hi Feli=
x,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">That's =
because v8 and v7 share the same
</span><span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif;color:bla=
ck;background:white">packet_manager_funcs. In this case, it is better to ke=
ep it as it is.</span><span style=3D"font-size:12.0pt;color:black"><o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black;background:white">Regards,</span><span style=3D"font-siz=
e:12.0pt;color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black;background:white">Yong</span><span style=3D"font-size:12=
.0pt;color:black"><o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehlin=
g@amd.com">Felix.Kuehling@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, November 6, 2019 11:45 PM<br>
<b>To:</b> Zhao, Yong &lt;<a href=3D"mailto:Yong.Zhao@amd.com">Yong.Zhao@am=
d.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function =
for Hawaii</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">On 2019-10-30 20:17, Zhao, Yong wrote:<br>
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
&gt; Signed-off-by: Yong Zhao &lt;<a href=3D"mailto:Yong.Zhao@amd.com">Yong=
.Zhao@amd.com</a>&gt;<br>
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
&gt;&nbsp;&nbsp; };<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR1201MB2533087B346C4619F461FF3185780CY4PR1201MB2533_--

--===============0961424190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0961424190==--
