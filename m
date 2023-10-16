Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4240CCDB474
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Oct 2023 18:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7F9610E00D;
	Mon, 16 Oct 2023 18:13:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB44410E00D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Oct 2023 18:13:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwTZiM6+ty7URue2Ir6FlBAkbI1j3KIhlHaqLw3m4i7PanqupGMOcOa91dRAwqjxEmsYt0HmFOWHT3Vv6X7RHuEEELz7n1t9aXoi6lXgPOFMs9QrIfER8bhbc7NwmRQ/DCiii3FsDlQvGts+3pbTFSmNZmYnugljMKyKtQxYnhKjOLDO0gzFG+vOkWnPNn1Mszfxup2EZ/9Hg3HPM7wydikJ+R+Xp4zi+CPWm04LsJUU2/NvZDK1kl0G1iGKD+/CdE270F/e/vOVnixQcznZiJiBSrQQagU4PzJqOX3oIVMSvGRzK6f4hBAefBRf/3uQMvU9mArbhvbudI7X5DDI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+AJmlDAJ1SR9fnZHWdgWcZLKPqw/mrrpQ/arVL5uqQ=;
 b=ZxCBFJ48j20+BOfausEYoesiYvm2ZbFfGJHEFL4LNVbD56QXHy2l9IAGScpdmjAZlUWxs+6O+OTOAcBW2Xxp11aSr8+ZUHTT+gQaUaGbg81WsLVTcxzaUNiOP69PAL7yKZfli9eUCb/GeBFRW8EvqQkd0HGLdGIgC9iH7wyTVkuK1O25oNt03s5LnnQQpeF53TEXEFc6fnt2XFSIMLPie87C5pw5KqRoWVrJr1KyrRFvCIIgA+kw+ZgJJBRxu8c+5Q0yl+lspx7LJ8B3gU6yTnT6tOS3Eq+ZoBVDRX/Sc+MRyMENcKYcddmJLLPYbJBnwyoPTtof2gkWMvFg6iTmlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+AJmlDAJ1SR9fnZHWdgWcZLKPqw/mrrpQ/arVL5uqQ=;
 b=ttsBDBZ3fMhdVZC5hLwpgryu8Whn3VbH2B8hpvc59bG4LXJKCMv71n4nVO2punkWsnPDd+qyvpv1QPbjwJy+7Nx/hYmkXw2fgKqn9UZyupze/stCSfyf/oGbwTgzDFlC1PjUrAsg4XSZiaG0Z6rdFaYSP7oYG3SBoIxdl7qihlk=
Received: from DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 18:13:16 +0000
Received: from DS0PR12MB8813.namprd12.prod.outlook.com
 ([fe80::6f10:aadc:69ce:f097]) by DS0PR12MB8813.namprd12.prod.outlook.com
 ([fe80::6f10:aadc:69ce:f097%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 18:13:15 +0000
From: "Zhang, Bokun" <Bokun.Zhang@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4 1/4] drm/amd/amdgpu/vcn: Add RB decouple feature under
 SRIOV - P1
Thread-Topic: [PATCH v4 1/4] drm/amd/amdgpu/vcn: Add RB decouple feature under
 SRIOV - P1
Thread-Index: AQHaAFFMxR7lV8cYXkObXG+x4wMbqbBMs/cAgAAEGa8=
Date: Mon, 16 Oct 2023 18:13:15 +0000
Message-ID: <DS0PR12MB881338F78D839B7E027697A2F4D7A@DS0PR12MB8813.namprd12.prod.outlook.com>
References: <20231016165255.2760-1-bokun.zhang@amd.com>
 <e339101d-736f-45f1-989c-0ff6732dce61@gmail.com>
In-Reply-To: <e339101d-736f-45f1-989c-0ff6732dce61@gmail.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-16T18:13:14.306Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8813:EE_|CH3PR12MB7764:EE_
x-ms-office365-filtering-correlation-id: a5b6cdec-8648-4f00-6776-08dbce73910f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J+ZiBaXlDqPlMQGYR26mIxVl7afmFBglicXuz75UcZhAgCKbFGrGryT7NJjGLPzkKQdTLVVep29hm7c0iTqwOfdCr+88ldIHauQYU5slwkrWaOgq1u47gYuhz3EQ3lL2u2p3TTqh5JASMxTAHJC3M0Hrt7wPzPiA4O07ql9EwJDLcJe7/6HIz7XJ8ACLyazT7jaYn5GYrOyU7n6nHuZAhvuXTrZIwcfohGDPtYwcxBFN53QH6NGiX2sJHb3jW/jIJBofxghYAB/015V0W5ZTG0d1OTTQTmXGEb0cUegSx3V7Rr3+nPpvrwozod8Z/HWA/Dy6oPL3artqvKKnAeBR9x+MgpFVoU8vw38ZJk6GRONkBRg/a/8X31RMHn8qy0tXkqQptIPfXqKNaaJO3mbXQKsu5tCSBN3H4neK7+9WJmw8VlSjO8fwOb8aP6aqbcR5ParuN3TX7pDZbgStbbU/ubDRys6Y72VIWT5CqsYBLzoVf1REfahti0HfZye6C9ojaeAHTxQGP3TODcTZzH7uGPyDwNANTVPuOLbdcXix3itifkEyRhZ2Iz/iC7GLMWTbSrfU7vCsP6u5Jr6yMm/+WtlQ5cm9AnwnLtUFvyk0RvQWO9ga8vJhd1Nj49mM6762
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8813.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(19627405001)(122000001)(38070700005)(83380400001)(38100700002)(71200400001)(7696005)(26005)(66574015)(6506007)(2906002)(64756008)(53546011)(66556008)(66476007)(66446008)(316002)(478600001)(76116006)(66946007)(91956017)(110136005)(41300700001)(86362001)(33656002)(9686003)(5660300002)(8936002)(52536014)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wp2TmpDOszOTVLQGfKXYM9vtWKVPuor1bSFXI6qkSLw9QA75H/Rk2DM8DM?=
 =?iso-8859-1?Q?yy17IJwyX3pT4/Xw4945aQrLm4fAClWIjByngcILvt03d8KvwS69jw+QWb?=
 =?iso-8859-1?Q?GuU7y7Ogj2DrVi3UoYgonle0u1JxfRqTj7vbfakOmoI0M0/C5G8co27KjJ?=
 =?iso-8859-1?Q?bOE1N2L6YgtpPUq+ZQBpXRs/bUvpHDzp2IojGO4zazArAo++oA5FkR4uRW?=
 =?iso-8859-1?Q?+vSW8tPF6RgmtaUQguALgk9QLMeu4T1DWxprqwmjBQYYzRO9QkDyg42g2m?=
 =?iso-8859-1?Q?MQw4mv5syCGBpHQPQgA9tw1OI05P7UJX5LheVKPzB7MYjXoIIduX87FQL4?=
 =?iso-8859-1?Q?nlaQYDxF9SlTz6ZRobcLVdCrTlNwANgF44trBeYHB3qeox2mC2z1zJ5t2y?=
 =?iso-8859-1?Q?Xw1xpHcItsSIs9Z6lpq7r3SVHpi94gZsUCE1tBo/hlyCMOOSgbobI2DBRa?=
 =?iso-8859-1?Q?nvco57Oh/k7hfKo3HYd7+YLME5tvstwgsTW9g31tQRhcfPasC42L9ffztK?=
 =?iso-8859-1?Q?bYnUdgOVJicgFJMfPUzZ4yAYvspoIliNNY8+JJ83k8oKyUXbBntarVPJWw?=
 =?iso-8859-1?Q?pZKwrDo9IkaI8pyka2+8UW3kt8jiwTWTVZrPk3109eN+TvOlZBJ/fL7kuq?=
 =?iso-8859-1?Q?A3jr5UKDWGI2FCU2Gb2FR3Rk6RJEMRirybY7TqhlPdBUPGzoCAMvPVqpK9?=
 =?iso-8859-1?Q?H5U/xc6jOvr/+OQJC/N4wckSrFuwPgVN4sJN6tR9jBvbbOXUTuGL4mgD+m?=
 =?iso-8859-1?Q?dzCkNN8AYVevda/20D30K0MkZ0jY44Qt9PLYP3P6fQi7PcsA72CnqRUMUW?=
 =?iso-8859-1?Q?1bWZ9/G+Xph8YM0KdEiGRheOO4Gas6kPvbPSLVQu2RhNVFtRYn+paOXnee?=
 =?iso-8859-1?Q?fUuk4f4X28z35ftQ2oSaI9wGlOLBj2AHyemZl5hu7IjVIwkOgi/Y1IvGk4?=
 =?iso-8859-1?Q?wrhy51wtTdsmo3r/qYxkymLFOPCljqqFW9v+m2aCSErkmd9J1m0BBfkNq+?=
 =?iso-8859-1?Q?RJ9nT3cPNhmNg5cQKkwmEiWekTgRmyDsAoYBRYaq+KaoLCrY9DUNWkwyeT?=
 =?iso-8859-1?Q?+nlH01ClJJNFzJ3A88gMAn8YQfXXC5qB34ja36HTHHFDMkq6vjzHhJJVmp?=
 =?iso-8859-1?Q?ZsyrWdiAKL4Y+MUI5CbChC38SKsv75y4FKi/pNhVcW3FVnJRNu1dPdDuax?=
 =?iso-8859-1?Q?yJmjxylEekY7GEES1xOvfiZKsiO7yHS+N44xmCjZBCZDYnUCXzWC91wdC4?=
 =?iso-8859-1?Q?hHyaL84/03pmHj68XM4ls8D5Gerq5Rh+xIA/zHD0UjsxWGNmjFJ/tQ/q1F?=
 =?iso-8859-1?Q?moZe+p6F0PFnEfik0Iy2Nu0Gnzj/EyZ5LztWgHaxcbM9dg9HSL6epwj9oY?=
 =?iso-8859-1?Q?618k3XEXvOYWG/NUnnhlmOvUmHXeUiO8HnsriLoWGXypg5Vqdsb9q/ESWB?=
 =?iso-8859-1?Q?UAsr++lT/GwBPY/WhaS6coKLlVSkQM++4jOdrYT3tqwij4Yl/RpmzjwPja?=
 =?iso-8859-1?Q?HeumbrE+0g3d5Ts2R3ZgVHkemTNCRZTWy//dP40+h7IR7wBCfSdREiX30k?=
 =?iso-8859-1?Q?pae2fzebM4M+Jgy1+oLAVi1BlmvPoCvlGm1m1+5LagpW7RfHtvQ1OIHrx4?=
 =?iso-8859-1?Q?ztpi6Mo91uM7Q=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB881338F78D839B7E027697A2F4D7ADS0PR12MB8813namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8813.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b6cdec-8648-4f00-6776-08dbce73910f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 18:13:15.2559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ucDgIveMHde2iAiQQoHFbaZT3HgTV94NOCu1zflFllKnktT1D8/3yH9fU/+WFLF2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764
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

--_000_DS0PR12MB881338F78D839B7E027697A2F4D7ADS0PR12MB8813namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Hey Chris,
    Yes, we use bitfield as flags to control certain features.
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Monday, October 16, 2023 1:58 PM
To: Zhang, Bokun <Bokun.Zhang@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4 1/4] drm/amd/amdgpu/vcn: Add RB decouple feature und=
er SRIOV - P1

Am 16.10.23 um 18:52 schrieb Bokun Zhang:
> - Update SRIOV header with RB decouple flag
>
> Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgv_sriovmsg.h
> index 104a5ad8397d..51a14f6d93bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -90,10 +90,11 @@ union amd_sriov_msg_feature_flags {
>                uint32_t host_load_ucodes  : 1;
>                uint32_t host_flr_vramlost : 1;
>                uint32_t mm_bw_management  : 1;
> -             uint32_t pp_one_vf_mode    : 1;
> +             uint32_t pp_one_vf_mode    : 1;
>                uint32_t reg_indirect_acc  : 1;
>                uint32_t av1_support       : 1;
> -             uint32_t reserved          : 25;
> +             uint32_t vcn_rb_decouple   : 1;
> +             uint32_t reserved          : 24;

Are you guys using bitfields for SRIOV guest<->host communication?

Christian.

>        } flags;
>        uint32_t all;
>   };


--_000_DS0PR12MB881338F78D839B7E027697A2F4D7ADS0PR12MB8813namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hey Chris,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; &nbsp; Yes, we use bitfield as flags to control certain features.</d=
iv>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Monday, October 16, 2023 1:58 PM<br>
<b>To:</b> Zhang, Bokun &lt;Bokun.Zhang@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH v4 1/4] drm/amd/amdgpu/vcn: Add RB decouple feat=
ure under SRIOV - P1</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 16.10.23 um 18:52 schrieb Bokun Zhang:<br>
&gt; - Update SRIOV header with RB decouple flag<br>
&gt;<br>
&gt; Signed-off-by: Bokun Zhang &lt;bokun.zhang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 5 +++--<br>
&gt;&nbsp;&nbsp; 1 file changed, 3 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu=
/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
&gt; index 104a5ad8397d..51a14f6d93bd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
&gt; @@ -90,10 +90,11 @@ union amd_sriov_msg_feature_flags {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t host_load_ucodes&nbsp; : 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t host_flr_vramlost : 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t mm_bw_management&nbsp; : 1;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t pp_one_vf_mode&nbsp;&nbsp;&nbsp; : 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t pp_one_vf_mode&nbsp;&nbsp;&nbsp; : 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t reg_indirect_acc&nbsp; : 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t av1_support&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; : 1;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t reserved&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 : 25;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t vcn_rb_decouple&nbsp;&nbsp; : 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t reserved&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 : 24;<br>
<br>
Are you guys using bitfields for SRIOV guest&lt;-&gt;host communication?<br=
>
<br>
Christian.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } flags;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t all;<br>
&gt;&nbsp;&nbsp; };<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DS0PR12MB881338F78D839B7E027697A2F4D7ADS0PR12MB8813namp_--
