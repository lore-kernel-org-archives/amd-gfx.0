Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1B3C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 09:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63E2710E357;
	Tue,  1 Nov 2022 09:58:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A8710E357
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 09:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKrIzKhnvBNQIM+GDMwmvFJKNqnuefojYW4WUAgBUhX4Z+49h0Po0OUAELoXJ9L/lZ/u0aFH0hM9bWnQpORKyVojDCbYgjIF3YwDK99qqBrPwANtYUythSYK7dF0EESY6iL4HDTbNNlt4pMoD8z9EzvHgZdZqFeK45Lqxdl/CG9dHLxrYktPLBjtbn+7D9+5TyBnt9k2cXhv/FGrwBFKxcwbsb9Ul+mOLsOMoE56H+VsBOg9ZlGwGKCV4L76/PB6Eus4LOXg5Jz2YvZguejUV/NbmOmyYSUk/K5eP3RU8Jy/2ONHa+GAhw46q2DTCoEjyDm5WEEWcXUH0jAO1q9ujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5d3YHAmw8Lp/qsRrbgy6i1vHOItI8piRIOR1BlXp6s=;
 b=hdbZF2dXJv+HGrz6S0zkgzIUUpvRn2BETwcAReecuANsbuqbOLElTsRmvs9f6LJWWP6dbIsjpbDUy4S/bRsZABjy6HmuiZZErxjPIvawBzbvdFFrLsLAl7K+WZHPEvSaXPPTCrkxEJX/E5fN4rEl/IBi+6DHoTd2r1NJQ+0eJF8vgNtgyKtb5r81rZsEsg37xrToUv+JjaSxpNNT1sUma0TTzTpHTakg4uydNvx65Q0qLMBe7oLI/K/+jONzSifd3s2neXpYY5fnEZQD9g0edigLfkkXAnC5YIMhh8Cz5wzuXuMfWk76t9ooaG6bPgZlkvFuEu7mBRRuOaaluJtisw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5d3YHAmw8Lp/qsRrbgy6i1vHOItI8piRIOR1BlXp6s=;
 b=tA/bor2aLAzKd5B6QNV9jFjjh1iRvr47lwiHEO9jp4geUJUsLRheuUiX8hZuotqABGroCV3MmWPJ9BfAuSVrcQuaDe5pPVbpP+nTfNlMLXQq1lMg1bggRmhN2H0GKvm8pdficoz3yi6QUs0PRHoecM1UaIFWftebJTRwslxjfVA=
Received: from SJ1PR12MB6338.namprd12.prod.outlook.com (2603:10b6:a03:455::19)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 09:58:36 +0000
Received: from SJ1PR12MB6338.namprd12.prod.outlook.com
 ([fe80::cc8f:5b1d:8c42:5439]) by SJ1PR12MB6338.namprd12.prod.outlook.com
 ([fe80::cc8f:5b1d:8c42:5439%6]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 09:58:35 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Subject: RE: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
Thread-Topic: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
Thread-Index: AQHY4tFVpYvpMYHRLUurvXDdtV25kK4oe3YAgADSeqCAAJAjgIAAC0PA
Date: Tue, 1 Nov 2022 09:58:35 +0000
Message-ID: <SJ1PR12MB6338730B8B54AD01E4FEF86BF4369@SJ1PR12MB6338.namprd12.prod.outlook.com>
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <20221018090815.2662321-4-jiadong.zhu@amd.com>
 <e5544150-5eae-7dae-b5db-dd9539df8198@daenzer.net>
 <DS7PR12MB6333A815A3C3EADFFA303E4FF4369@DS7PR12MB6333.namprd12.prod.outlook.com>
 <5a11969c-0996-8755-472a-11f9cf1705d1@daenzer.net>
In-Reply-To: <5a11969c-0996-8755-472a-11f9cf1705d1@daenzer.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=55bf97ce-fd6d-4266-97d9-f64bd3fc561d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-01T09:51:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6338:EE_|SN7PR12MB8025:EE_
x-ms-office365-filtering-correlation-id: 95a95d9d-d46e-4104-d25e-08dabbefa454
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CS30AbfsHqftaG2RWFdvjTJKGy1PcvFekzU4p9GaoBNvwfO2NRgNgocpCyxdlCTGks4+enK+jvDRJ5g/rxBKSuD2zCclMpKiOUahe+kU085WVA6YaEZFKRmt/Mrhyz7Uu2k+YSk4/nbacRRyK8XZZnxN2C4TEj0IrLwqWxkoB9LAFMONjMjFtdT/6/yBRxxxPaUOZHKIiikixTuMSMvz6kevLrI9Rwf2Pnni7+dyH+Iu5An5A98xQ/QYTAVfAClRTyzp/oYYf6wI72dpFem2sK2/nA94YYKo+V7/bYJegwkxihRwd0+LzaEnb0NgvVsW9Bkweh6vuBSD++smiqg5kR5ILATjDg32zGaeggmW8d/xghenTGsMaVctCXQZr/UJVPFJK95p2YdV+TmgY0VhlB7L9jLzGugNEV/HMbOCkBTnGK4AyoHswNlc284ar80+G/xWG6jsK8S4A4gPH+2I+DnQlrWUyTRFqZy4EqAqou8SGe0+lYXuKpsqwQGf8Xg7hg+FmRW/VBGW5GJQwjPN852o7wNbdhGLCdbegf4kN0u7SYrKlL5C+ZR0W1ZNFVRSF16fLJ1YGSA+ySvq00jDssSu37151K+1eZ4g08rXlazv/14WJ8VWjqY/E9Dj3WuVJDjfjBc0rwqA675+vNzAnAFRsf0tcAzyMYL+Rr1vB8syj33SD1q8VGAxAunYNKtccvn23otnGxOfrOgDZ3rqG8egWLJkTO6Jvo8Oq5HOQPxdcT22kVSrrPTingcdsrZaTzg3ixyzkuKImPZkN5ZBwycptZsXWBXuTg3Sc9u6vwY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6338.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199015)(86362001)(6916009)(122000001)(33656002)(38070700005)(38100700002)(83380400001)(2906002)(55016003)(66574015)(8936002)(186003)(7696005)(53546011)(6506007)(9686003)(26005)(478600001)(45080400002)(66556008)(4326008)(966005)(41300700001)(316002)(64756008)(8676002)(54906003)(5660300002)(71200400001)(66446008)(66476007)(66946007)(76116006)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?El++Jcoybs3FJDCKJ49bBvlAZwI6jJuQLIdKFGJQ8N0dtDs6uP8bkMo4fD?=
 =?iso-8859-1?Q?o3hhZucE/jl3I/ETEcvw1iIJ8/rDZcr70Y9hqBaDpm78WLxvQMtdvwWY7P?=
 =?iso-8859-1?Q?3jJWolJCR+Q1aMBUBMLz4mYsexrwCS/Smf5ArgyUaumLcRSefmzGRMQqze?=
 =?iso-8859-1?Q?BNmdrtsQOeHEzoxBJPP0y/JmrbpaXBmnLJwPhlsYXMM7v4JE6hf4kjSFXJ?=
 =?iso-8859-1?Q?YkjAdA7PthohGxGJwJ4SWB+xawRg1imb9KVrexMXEC9KmBelqZaEHiypKe?=
 =?iso-8859-1?Q?iwHzBdYlNZQTgmNijdp1rOZAtMF6jGE7ymuRITZHFlF4r6EVWOycUkMiXx?=
 =?iso-8859-1?Q?XcqkdMi+PKli6luOIl1W4Bm0gKMAQJ1XqmjOYjiL5sg8UTvkodxIWC1gn9?=
 =?iso-8859-1?Q?nbGL8C071w7U18IRzWA2QOF4HNPIv52WdaDkQSGIqwuTBlQWZSeD9y/b48?=
 =?iso-8859-1?Q?tQNkxWKiXjS2pXoRlvhsJxNinr0ac69V1bkCoG7C7yOau1HPuM+wS7DcOH?=
 =?iso-8859-1?Q?qV6384Dsa33u0qYCnuia/c7l/wQO2O3V7lCMH6npeKP8Vl4MQIsjm66n9N?=
 =?iso-8859-1?Q?Gc8oylglZU6Eg8a65FfwfIs7+cjDjto96OrMuTBkjcd4a7zDAlf4cCMFRh?=
 =?iso-8859-1?Q?l1x464Gyx1l56s0hruOhMvn/peb++87TVA5P8QgKi2py7MeGanBp0LOD4g?=
 =?iso-8859-1?Q?t9OEqVLQ23DSfbkeoZ0kE62WjVbTQpk+Ohz5uqV5tY8YvAL6U9CUO20Ytv?=
 =?iso-8859-1?Q?wzT07lY5AtdV76Qew5oQIGajeeQf4oIVZVsJ/GKOfbdrOwPyS1v0oYJfig?=
 =?iso-8859-1?Q?Z9QOqcwS3AXTY9me/FQELGVE4FIggGe8UtEst7eSjTOSfWq6fIlJ8Uv5G0?=
 =?iso-8859-1?Q?5nghXf2efLc9jxV9uo0lsRSGjqJQRqPKhGUuLKfboR1nX+EukR/wGyJdRL?=
 =?iso-8859-1?Q?1Vk/mF61cr4f/GAbZb1koFdHIcpkKIT6SDUG33laCWQ2BcyZvx8ewn8llt?=
 =?iso-8859-1?Q?d9wVYLAq972aX7WXuFxHiHvl0sJ1srMkavC+nrkvfOCMgw7dVHkp2mCQr9?=
 =?iso-8859-1?Q?I9x7J6uYUP7ktk9YhAN4RrpexXlm6rr1TbwjfIw0pm4OHqftSIgTm8S8ie?=
 =?iso-8859-1?Q?dlPVOJRv6dHboLnQCe3gWpkvFLamX0FCbdkVyFUEuyo+GifU3M0oxtmiY8?=
 =?iso-8859-1?Q?pKlYgeY/oy/h9f/GpRw9aBlvxdZwEOiegKDgeMwbnnfGQ3tsNWEmN2qLpp?=
 =?iso-8859-1?Q?ql2RTOoTIx/W0Cjx6jcRcrdMFHVhfdBI3lrMNSUP5LeuTtPFT1SnnF1hOE?=
 =?iso-8859-1?Q?tXg2ITxqbCF+lozzV+RPzcwPPa9aOWb59H73WOfHGoD93hvBHYXn+v5cDy?=
 =?iso-8859-1?Q?nGRufGdS+T65SbTB1r84S43cgOjbs+8sOF5vgl6wgAHG1wAR7b3YjoYJjB?=
 =?iso-8859-1?Q?qMPwyXWAyd1L8ZEY8ksUXA63AnEbfU92tQ32/gRnl86wcReY89/BMiaEsB?=
 =?iso-8859-1?Q?iVbnY4mSuqgdtQDtp0eCBOkvLC4Ondp59+xMk5wcOE9otTrH6wjUAabGrS?=
 =?iso-8859-1?Q?yPYxhK2S8hQArUjChzWZelx71cVG4e+es8HRp8XJ35VK9/+fFdRqFFwP8e?=
 =?iso-8859-1?Q?Bv4J9efVA18vF/BItDhpij7qby82fgTON1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6338.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a95d9d-d46e-4104-d25e-08dabbefa454
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 09:58:35.4477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AseW9WQnY1ZGLPe8LP4m+ylntywoIv59xd94LJmATWq28fwATbifHjC1GrVUm2kIHxqUsrsh8ApuSDpI4SwiYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

>Patch 3 assigns preempt_ib in gfx_v9_0_sw_ring_funcs_gfx, but not in gfx_v=
9_0_ring_funcs_gfx. mux->real_ring in amdgpu_mcbp_trigger_preempt presumabl=
y uses the latter, which would explain why amdgpu_ring_preempt_ib ends up d=
ereferencing a NULL pointer.

It's weird the assignment should be in gfx_v9_0_ring_funcs_gfx instead of g=
fx_v9_0_sw_ring_funcs_gfx.

[PATCH 3/5] drm/amdgpu: Modify unmap_queue format for gfx9 (v4):
@@ -6925,6 +7047,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_f=
uncs_gfx =3D {
        .emit_cntxcntl =3D gfx_v9_ring_emit_cntxcntl,
        .init_cond_exec =3D gfx_v9_0_ring_emit_init_cond_exec,
        .patch_cond_exec =3D gfx_v9_0_ring_emit_patch_cond_exec,
+       .preempt_ib =3D gfx_v9_0_ring_preempt_ib,
        .emit_frame_cntl =3D gfx_v9_0_ring_emit_frame_cntl,
        .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
        .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdg=
pu/soc15d.h

Thanks,
Jiadong

-----Original Message-----
From: Michel D=E4nzer <michel@daenzer.net>
Sent: Tuesday, November 1, 2022 5:11 PM
To: Zhu, Jiadong <Jiadong.Zhu@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Andrey Grodzovsky <Andrey.Grodzovsky@amd=
.com>; Huang, Ray <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@=
amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)


[ Please don't top-post ]


On 2022-11-01 02:04, Zhu, Jiadong wrote:
>
> It is a macro defined in amdgpu_ring.h, calling function pointer preempt_=
ib directly:
> #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
>
> The real ring's hook is assigned  in gfx_v9_0.c:
> static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx =3D { ...
> .preempt_ib =3D gfx_v9_0_ring_preempt_ib, //please have a check this line=
 existed.
> ...
> }

Patch 3 assigns preempt_ib in gfx_v9_0_sw_ring_funcs_gfx, but not in gfx_v9=
_0_ring_funcs_gfx. mux->real_ring in amdgpu_mcbp_trigger_preempt presumably=
 uses the latter, which would explain why amdgpu_ring_preempt_ib ends up de=
referencing a NULL pointer.


> Here is the eglinfo on my board, I have once built mesa component
> (22.3.0-devel), which may update the libEGL_mesa.so

Looks like EGL_IMG_context_priority is supported (it would be interesting t=
o see if it's listed for the Device Platform as well, but there's probably =
no reason to assume otherwise). Strange that you can't reproduce then.


--
Earthling Michel D=E4nzer            |                  https://nam11.safel=
inks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;data=3D0=
5%7C01%7CJiadong.Zhu%40amd.com%7C89dc4843c4674e7c706a08dabbe91326%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C638028906976834499%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30=
00%7C%7C%7C&amp;sdata=3D8Ow2Lx890iYmhsih0ZFqgOYg9ciGz%2FjJLF3p7hhAtc4%3D&am=
p;reserved=3D0
Libre software enthusiast          |         Mesa and Xwayland developer

