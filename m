Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505D1C4361B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 08:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1FC20784
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 08:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1FC20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE3289D4B;
	Mon,  7 Dec 2020 08:34:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F0E89D4B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 08:33:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pdj5ioQY31wMPnJmIOZm764gFg4+yhrz6HkK9TXKtP2mHQWNwJPdHpJHdygRtbi6ehEwFlI98WjQIJbj7rUUEfibDa5oBMPlbIfGZvBiCPzab2TpDig13mzmeLnoDLhl98id91Yh6dFHzIiNxkb6lD22FYtC1sTdLR9espLCFFgCeIpDoCGHw1d/UhYtxHfcXlcpC0Eywr/yzGrZQiArCLtVDyHLeGEyjULtg934leAl0nihMHyUIFCNJc3yoTBAvAHie+zjroaxh01Ll34TsVLZy9H0jxdbiEKUxlLqXYVJIPxesiHODEU3nvnSOEL4TzsYmsdlBKQe52z43lNmeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoXsdHcn3fYADgOzSBydhQjMi484q5cywv094acztHY=;
 b=HpYCULWPGLvPYwx1tmsGJn9hr8TSJA2CUvkodNy4EENvfuAW9Pmbp9MWd+K2VPcoqpzvVRNMpYvtLKwRKx8qOlju5s56VJfTCZD3o9JWQv9rHxgm1YwdyCRJhboGeytp2qC4qb7X8J3V95QNYBEodgW5EUC71v8oc6TguE93Um0yYy/595n6T3iWSfStThaS/QrSCPu1ydf+Ds+EaCydBV6ubYY9oomMugQs9Y16u2/D6/AIlEXx1dNOpZ7P9YaF78AO/jg4YLjWI4C5AwoZd0KgpUHE9v73Bsgm0g+4FWZ/Ap1WFib54abKJML4L4SAPvmyLHUeKfMD+LxMwMp7iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoXsdHcn3fYADgOzSBydhQjMi484q5cywv094acztHY=;
 b=px/5VJQ1BiLYGx3irR7JRMyXUAus6ek3AYBEm3HRKkFSC/1CnUQbfC34wrayXIWhV26oVNe4I5ZrJ7RJNYP95vep1wWJnps0inkkg6ztoboTbtlfcv3AjyokrQyjv4NhMpPdtFs0mklfOHgGO22nXYwvV6zBloL6/koa9Nrrm2E=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2976.namprd12.prod.outlook.com (2603:10b6:208:c2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23; Mon, 7 Dec
 2020 08:33:57 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6%7]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 08:33:57 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: change trace event parameter name from
 'driect' to 'immediate'
Thread-Topic: [PATCH] drm/amdgpu: change trace event parameter name from
 'driect' to 'immediate'
Thread-Index: AQHWzGYqCBPjRdfqS0Svp+FhUJzg1KnrS5MAgAACnyY=
Date: Mon, 7 Dec 2020 08:33:57 +0000
Message-ID: <MN2PR12MB30229B554723DA1F31F428FFA2CE0@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20201207065643.29208-1-kevin1.wang@amd.com>,
 <c74e5385-8464-8e19-4f37-bfe2c810fbb8@amd.com>
In-Reply-To: <c74e5385-8464-8e19-4f37-bfe2c810fbb8@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-07T08:33:57.125Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea10c1f5-438d-4fe2-f58a-08d89a8ad710
x-ms-traffictypediagnostic: MN2PR12MB2976:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB29766BF48B5A34939CA8170DA2CE0@MN2PR12MB2976.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pQ4aTyG+CKqAqHmzKbrw3T/hqLLVmhUB+C4FCLjQ5+r2LFfJSHdW/TkXtIRPGQAaiWuIrOcg2OqSBg0ZwFhd6N3vpUhnMKdT/Hxl9QHjp1uIHMA91Rs63TQ+4va+7fVtlEUlCbOzyBTDIwjtKWE9+MN3N7swVV17Yt5g46rYYTQinXM4fLu4BvQ/mJ4Gb2KaFxDQ3be8hsl8gfRU9hAZjam+Fo1IHgv5CVRgVE2l1GwpWm3KX4rHoROBCiI9BMjGoUUpSUr8/4cv+iFvS2CwRYqmxcq9LXzjONL3+D7oeN8FgTM6R5ipK82zgM0E+ZYH4W0j8XU/cAL4j/XZYnE76u/pjle2YvKocV6GmEgszSkA6gEVn/dAy3bYCfByW7z+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(33656002)(66574015)(2906002)(186003)(66446008)(19627405001)(26005)(86362001)(316002)(478600001)(55016002)(8936002)(110136005)(9686003)(83380400001)(5660300002)(6506007)(52536014)(91956017)(53546011)(8676002)(71200400001)(76116006)(66476007)(66556008)(7696005)(64756008)(66946007)(14773001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?9ePG2UL/g3zIZh89/VBgQZBMSnh18HBfC9eBfuEGUgWhS+1uH7B++Gd9WQ?=
 =?iso-8859-1?Q?ud06s+PmJUYOLMGXOjuzM2rG+hfVClj9AgyMiDTSk7rqWcVWFU6VwZoN+6?=
 =?iso-8859-1?Q?q0iey/5eyRIpgMS1vK+wkh9wiJSPLZ0wJgwiB8X6vPQKRjJlQbfXW3Kk+2?=
 =?iso-8859-1?Q?aUfyzQk4ERQNCb3DtP8rOiuWcKNTEmzx7H35HO6Qn0HNBjD9ril+SEQH/T?=
 =?iso-8859-1?Q?+lUdoK/enTAaQ6x1/cWMx7SRbHLq3/8kYoal2D/p7zATwoo7KNF3tjnQpd?=
 =?iso-8859-1?Q?sAlym1V+1K8y32eEtylDnmUBqUfWTrBVhXOH1RIHn2hntu1G+9xyRVRqbC?=
 =?iso-8859-1?Q?Cld95xITScrxEsfj/R488XufnCZFvAUAiJn884ptj4JI+hFluInWbssQjD?=
 =?iso-8859-1?Q?l+g2Yj/kVHJ2xdERUHloHqdwIRl2jDJqETUtCeQi9NeabSysrSw+49q94N?=
 =?iso-8859-1?Q?wLrt2as1C+pTcgWyH6vc64t2bo8LCZHaAQd4r0wrCrJ/mAkX0cuzkPz8Vc?=
 =?iso-8859-1?Q?sy7wofj1kNkPjp3x8VMAv111IdtlB24P3oeLoTuDTK+hYJ7V1HuiIMsra6?=
 =?iso-8859-1?Q?jH6mE5G8bNtte5drBgvA/WcafGXjA0Bac96lDJ6LtAbmG5SLl94NblVBhK?=
 =?iso-8859-1?Q?5l0xTLvMmz2OgJ4NoPlTbaXl+b/xqmkEgBPkpFNDKJXlTydhGlD9SNU8AE?=
 =?iso-8859-1?Q?HsmBpgiyTjazLW63E9W+elr6HamQ+Fi1QRNbucPKIrM4zKJKMdKqNyVw5s?=
 =?iso-8859-1?Q?shge5yqpJvTSuwQWpmXR3moea2sbKmuUtJNMy1i4nOmsFgl63YURs8HMWl?=
 =?iso-8859-1?Q?ILx4+gV1Rq2RjKpAyXggfsSd+daEKigAmH1OumlyHsEL1azYQeEJeKgX7O?=
 =?iso-8859-1?Q?q1z62x5Uf1TseBUwWz2+R4KPLf1tBAVY6LxTyAzUMfQ/b/Xi7HTeLpHydh?=
 =?iso-8859-1?Q?+7d4A+j5FC+PB4k8cutM8XvZD7BWDEMSWKzaMKLszc20XofpBlxIdkJAZv?=
 =?iso-8859-1?Q?zN8WdrWR0xsh5bVgE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea10c1f5-438d-4fe2-f58a-08d89a8ad710
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 08:33:57.5723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7QEZuIZhiL3W2O4wPO2+zIVw7n10vEd2uXIaoJYZgyw/gfjWldft7wjOXrWXJF6+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2976
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
Content-Type: multipart/mixed; boundary="===============1035247337=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1035247337==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30229B554723DA1F31F428FFA2CE0MN2PR12MB3022namp_"

--_000_MN2PR12MB30229B554723DA1F31F428FFA2CE0MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Monday, December 7, 2020 4:23 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: change trace event parameter name from 'dr=
iect' to 'immediate'

Am 07.12.20 um 07:56 schrieb Kevin Wang:
> s/direct/immediate/g
>
> amdgpu vm has renamed parameter name from 'direct' to 'immedate'.
> however, the trace event is not updated yet.
>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
There is a small typo in the subject line "driect", apart from that the
patch is Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>.

Thanks for removing one item from my TODO list :)

Regards,
Christian.

[kevin]:
ok, thank you for reminding me.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 24 +++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_trace.h
> index ee9480d14cbc..324d5e3f3579 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -366,15 +366,15 @@ TRACE_EVENT(amdgpu_vm_update_ptes,
>
>   TRACE_EVENT(amdgpu_vm_set_ptes,
>            TP_PROTO(uint64_t pe, uint64_t addr, unsigned count,
> -                  uint32_t incr, uint64_t flags, bool direct),
> -         TP_ARGS(pe, addr, count, incr, flags, direct),
> +                  uint32_t incr, uint64_t flags, bool immediate),
> +         TP_ARGS(pe, addr, count, incr, flags, immediate),
>            TP_STRUCT__entry(
>                             __field(u64, pe)
>                             __field(u64, addr)
>                             __field(u32, count)
>                             __field(u32, incr)
>                             __field(u64, flags)
> -                          __field(bool, direct)
> +                          __field(bool, immediate)
>                             ),
>
>            TP_fast_assign(
> @@ -383,32 +383,32 @@ TRACE_EVENT(amdgpu_vm_set_ptes,
>                           __entry->count =3D count;
>                           __entry->incr =3D incr;
>                           __entry->flags =3D flags;
> -                        __entry->direct =3D direct;
> +                        __entry->immediate =3D immediate;
>                           ),
>            TP_printk("pe=3D%010Lx, addr=3D%010Lx, incr=3D%u, flags=3D%llx=
, count=3D%u, "
> -                   "direct=3D%d", __entry->pe, __entry->addr, __entry->i=
ncr,
> -                   __entry->flags, __entry->count, __entry->direct)
> +                   "immediate=3D%d", __entry->pe, __entry->addr, __entry=
->incr,
> +                   __entry->flags, __entry->count, __entry->immediate)
>   );
>
>   TRACE_EVENT(amdgpu_vm_copy_ptes,
> -         TP_PROTO(uint64_t pe, uint64_t src, unsigned count, bool direct=
),
> -         TP_ARGS(pe, src, count, direct),
> +         TP_PROTO(uint64_t pe, uint64_t src, unsigned count, bool immedi=
ate),
> +         TP_ARGS(pe, src, count, immediate),
>            TP_STRUCT__entry(
>                             __field(u64, pe)
>                             __field(u64, src)
>                             __field(u32, count)
> -                          __field(bool, direct)
> +                          __field(bool, immediate)
>                             ),
>
>            TP_fast_assign(
>                           __entry->pe =3D pe;
>                           __entry->src =3D src;
>                           __entry->count =3D count;
> -                        __entry->direct =3D direct;
> +                        __entry->immediate =3D immediate;
>                           ),
> -         TP_printk("pe=3D%010Lx, src=3D%010Lx, count=3D%u, direct=3D%d",
> +         TP_printk("pe=3D%010Lx, src=3D%010Lx, count=3D%u, immediate=3D%=
d",
>                      __entry->pe, __entry->src, __entry->count,
> -                   __entry->direct)
> +                   __entry->immediate)
>   );
>
>   TRACE_EVENT(amdgpu_vm_flush,


--_000_MN2PR12MB30229B554723DA1F31F428FFA2CE0MN2PR12MB3022namp_
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
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Monday, December 7, 2020 4:23 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: change trace event parameter name f=
rom 'driect' to 'immediate'</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Am 07.12.20 um 07:56 schrieb Kevin Wang:<br>
&gt; s/direct/immediate/g<br>
&gt;<br>
&gt; amdgpu vm has renamed parameter name from 'direct' to 'immedate'.<br>
&gt; however, the trace event is not updated yet.<br>
&gt;<br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
There is a small typo in the subject line &quot;driect&quot;, apart from th=
at the <br>
patch is Reviewed-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;.<b=
r>
<br>
Thanks for removing one item from my TODO list :)<br>
<br>
Regards,<br>
Christian.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">ok, thank you for reminding me.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 24 +++++++++++=
------------<br>
&gt;&nbsp;&nbsp; 1 file changed, 12 insertions(+), 12 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_trace.h<br>
&gt; index ee9480d14cbc..324d5e3f3579 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
&gt; @@ -366,15 +366,15 @@ TRACE_EVENT(amdgpu_vm_update_ptes,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; TRACE_EVENT(amdgpu_vm_set_ptes,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_P=
ROTO(uint64_t pe, uint64_t addr, unsigned count,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t incr, uint64_t flags, bool direc=
t),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_ARGS(pe, addr, co=
unt, incr, flags, direct),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t incr, uint64_t flags, bool immed=
iate),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_ARGS(pe, addr, co=
unt, incr, flags, immediate),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_S=
TRUCT__entry(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; __field(u64, pe)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; __field(u64, addr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; __field(u32, count)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; __field(u32, incr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; __field(u64, flags)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; __field(bool, direct)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; __field(bool, immediate)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ),<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_f=
ast_assign(<br>
&gt; @@ -383,32 +383,32 @@ TRACE_EVENT(amdgpu_vm_set_ptes,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; __entry-&gt;count =3D count;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; __entry-&gt;incr =3D incr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; __entry-&gt;flags =3D flags;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ent=
ry-&gt;direct =3D direct;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ent=
ry-&gt;immediate =3D immediate;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_p=
rintk(&quot;pe=3D%010Lx, addr=3D%010Lx, incr=3D%u, flags=3D%llx, count=3D%u=
, &quot;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;direct=3D%d&quot;, __entry-&g=
t;pe, __entry-&gt;addr, __entry-&gt;incr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;flags, __entry-&gt;coun=
t, __entry-&gt;direct)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;immediate=3D%d&quot;, __entry=
-&gt;pe, __entry-&gt;addr, __entry-&gt;incr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;flags, __entry-&gt;coun=
t, __entry-&gt;immediate)<br>
&gt;&nbsp;&nbsp; );<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; TRACE_EVENT(amdgpu_vm_copy_ptes,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_PROTO(uint64_t pe=
, uint64_t src, unsigned count, bool direct),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_ARGS(pe, src, cou=
nt, direct),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_PROTO(uint64_t pe=
, uint64_t src, unsigned count, bool immediate),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_ARGS(pe, src, cou=
nt, immediate),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_S=
TRUCT__entry(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; __field(u64, pe)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; __field(u64, src)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; __field(u32, count)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; __field(bool, direct)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; __field(bool, immediate)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ),<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_f=
ast_assign(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; __entry-&gt;pe =3D pe;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; __entry-&gt;src =3D src;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; __entry-&gt;count =3D count;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ent=
ry-&gt;direct =3D direct;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ent=
ry-&gt;immediate =3D immediate;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_printk(&quot;pe=
=3D%010Lx, src=3D%010Lx, count=3D%u, direct=3D%d&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_printk(&quot;pe=
=3D%010Lx, src=3D%010Lx, count=3D%u, immediate=3D%d&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;pe, __e=
ntry-&gt;src, __entry-&gt;count,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;direct)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;immediate)<br>
&gt;&nbsp;&nbsp; );<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; TRACE_EVENT(amdgpu_vm_flush,<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB30229B554723DA1F31F428FFA2CE0MN2PR12MB3022namp_--

--===============1035247337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1035247337==--
