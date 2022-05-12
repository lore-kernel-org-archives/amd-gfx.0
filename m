Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5BEC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 17:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C7E010ECED;
	Thu, 12 May 2022 17:22:50 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30FDB10ECED
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 17:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4z2Z7iblpxfT6CL87ECYFRCIthb08pa1i7w7sd+cgfm1ahFx9NmZ9JEJ/YQox5yXzTIX1t4f6K2riO5QRVnySq1UJXaH61jhkG4CpbfkSr2OR88RnL+1za2jvtR0D+QS/6CFfip0Jr8bplponY9ceHzFgT3+RzKt5RQ5TysLhQD2Eh3OenoX271h71p+yxDfufkecz/xuewoGfmzi3HL/I79dD7KQGBy1asDR9U8Zyd6w40e5TC8IeEHouLUOGOF47HMgLvSvgntK59TwTdvjQwkHYQF0rNqBSzzmX2Zv5nzKDBRw9IiIyUV9IZsmwO8WnV2JZg0LN0mnEQfsipNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epptWC+LRTVnNVM18Hnm5VVtRHZjvdJeRd786SqSz7A=;
 b=JBmOBdYmduzJOW+EzxrvQ1P0ENjyrJ3akw+xk0am5b+RAc0FnkLQ3ZY88mU5IYw2vpEjGrrZRqp0GEv9oemtgSNiatwVSmMcW0OWwN6nIddUQ9eCZ7RyGkH0j6GKPk0sqWTuHcshyTlhLSZUICLDJWKIUs+05BugtFzzXRtXdONabd6a6GdCDyzmmGNss8sA3MEE+rd5qvA8m6pxmFc6LdYylTHzqJoHIlVcDkzxUPPLGHX/wSW0koJCFtkAwQr2xqe4KeZEjycVn42YjiZp94V7HZom1lykFemapFDxB9WNrKxdEQMyTE+c3O/abR7Bloex6rlapw49fQ5Lc6iKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epptWC+LRTVnNVM18Hnm5VVtRHZjvdJeRd786SqSz7A=;
 b=GfNUEZHyvo3YigMruGRx8iCeioKxlZSQQQjDaZBqqlJ3MZL1u5fnssnM4iv28n9RCuwwUf+pVqPauZuw7CTTVJ2r4Hqo5wj0DT+f/S9rtSKfoPFC/uzBmILcbcqiW+cGtWhp1j889OXl2kEAimd99vnjq4B3ZvbmGVXJgdc8MpE=
Received: from BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20)
 by BN8PR12MB3347.namprd12.prod.outlook.com (2603:10b6:408:43::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 17:22:45 +0000
Received: from BN9PR12MB5145.namprd12.prod.outlook.com
 ([fe80::2498:9bac:cf07:b7ec]) by BN9PR12MB5145.namprd12.prod.outlook.com
 ([fe80::2498:9bac:cf07:b7ec%4]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 17:22:45 +0000
From: "Zhang, Dingchen (David)" <Dingchen.Zhang@amd.com>
To: Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH v2 00/19] DC/DM changes needed for amdgpu PSR-SU
Thread-Topic: [PATCH v2 00/19] DC/DM changes needed for amdgpu PSR-SU
Thread-Index: AQHYZK7KomqnLVmpXECXt6NA2BsAMq0Z0CQAgAFLkgCAAFfnMQ==
Date: Thu, 12 May 2022 17:22:45 +0000
Message-ID: <BN9PR12MB5145FCDE79EC4C5600CFCD858DCB9@BN9PR12MB5145.namprd12.prod.outlook.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
 <CADnq5_PZVo0GkkLqnhDA8THxQ2wgqx7zt1cARx+tTnsYo5gAOg@mail.gmail.com>
 <CAKMK7uGMsxAJGaPbPR9fhmdwKgV=hOG73H=Ju0hYU9G=8hfa7A@mail.gmail.com>
In-Reply-To: <CAKMK7uGMsxAJGaPbPR9fhmdwKgV=hOG73H=Ju0hYU9G=8hfa7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-12T17:22:44.108Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8016c83-0a11-4c0e-9ac8-08da343c075b
x-ms-traffictypediagnostic: BN8PR12MB3347:EE_
x-microsoft-antispam-prvs: <BN8PR12MB334791691AC4D02A4FA12B248DCB9@BN8PR12MB3347.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K3SroddrEW43sH6d9Qey8V2Ymz1F4I3KbDTFBh7LWHK5TbrPe2u9Xsj4Pj2Ne/I3e7GyMZlvWPO9usEz+rRa/+8dJS/Txyd8wDk+2lDzmMX6FHMc+ZClRxEALPTZJKjypsdDTcslmy1dX698Ce919Gx4kZH1RnQPykGvAy+5Hsfx7CiZ3IZhc6iiUbtJhytixeU9kRNzsRNh4uEKKwgEnnixU6DAmVvxGcgk/YC2CEeb1GjEpfbLU0/HYT8Mu5d6vPMx8OpIvYbVrXM89kfRvymsi4PvjrWIEdtvXGJL48XsHSlld2sYq8or1eSZIf/BX4ACeokjjEwWertCLdrTZUe91hMZpYQassKkbsobAoW+D79/ouIogoqvRKx1JFlve4mOdjYo/AFZz1nuv239G6ba7dYu2fmRhOr1LsLbxIb8tyEjRcqrC9NtVCWffVx1t/ucgDaZb7+8ojoCjkjtBwoSrsyN8fWmuL80e8lXtURxKZ0LIPSjN3SWDPVDTGu/8dyP6GF4BJ8HB/4C3hYSPCo7NxXTBM/Lj6307FrZVFSqqQHEflaHYGd0y+1Z1nIa4XPFNMvxdeZMPgykmhoUX77ju68JQwI4PjaQxLKfrVDa4mviqMWOp0vOd1YAIqfZ1LRvpFXrMIi3IpOvMScjwpTebfyiUU8AsSE02PM/rOheT4QbYCA3PDx+MURNemHedfV20yFPHuFhVXop7y0QttvHGEDDZvEt+CVMj4gb9aBsVgW0fu5vUruSgXqEtzjS0a/ys9HXmQVqydM5FAIwiYtLddkNjbCO9k45wnW6FgU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5145.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(38100700002)(38070700005)(8936002)(83380400001)(316002)(110136005)(54906003)(26005)(52536014)(91956017)(55016003)(122000001)(186003)(6506007)(66476007)(71200400001)(76116006)(4326008)(66946007)(64756008)(8676002)(53546011)(86362001)(66446008)(66556008)(5660300002)(45080400002)(966005)(2906002)(7696005)(508600001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pyxOrmLJLtNQcToByCiWrhiWl9eoQUf2BLTBx6EWGN+6suaf+oZ+S3T3gB?=
 =?iso-8859-1?Q?MbGtBRBkrt6zT9S/yYo9RncWwynRjMYIjeAI9CzmSrL1lTSJUvigjQn8QN?=
 =?iso-8859-1?Q?nCwRbi9GwSN/TxvXlx1ONBbn02iWDxMp3Lpm6Nd19wckPc7YM0epmziZEM?=
 =?iso-8859-1?Q?sYNadiFYLU4g5uZtwMzo9ax+nWC+TNmaFBOuZXjHs/0vpvuk1oIwYXSQCI?=
 =?iso-8859-1?Q?89+Kj3vZmuJ7ZeoM8ALwF5H7gOrNkP1TntYt2/QwOWafrWwTpcDRM8RqDW?=
 =?iso-8859-1?Q?Ev9gD7xjbPAbasbhNoCnTafjXiUl0k82df+N0TYXIZhkr7BPvIxCpP/9MT?=
 =?iso-8859-1?Q?z9r6ttdCMmhWdBJ1PkZKEJsFfUcQHcIXVGsSxrQNOZC9hAXtqI8/1LnCFP?=
 =?iso-8859-1?Q?+TPy5QW60ktI+vuWJGjUUqGbUcs+bh55nwJEs5ufnJgS320ni2Y8YawYgT?=
 =?iso-8859-1?Q?U3ZQaWFGWysYT59qc0mpbggTcqbmVlRmHH+5ceHD9Yu7W0AX57tQzSKLUj?=
 =?iso-8859-1?Q?5QbecoC8t92AhRhWr8lcFv/6MwK4xoUDXiMwz3hRHJE0E6yws/EKdI8tzr?=
 =?iso-8859-1?Q?aesebr9DqrvBxl2t7+eC+gQGowab/1t4Ry207zzUKRcABKu0sX2k6M5DuK?=
 =?iso-8859-1?Q?aEMVl+u5kddp0ChFdSe/wzs6NbZlZZm0VCHCHMki2cDkvLVDor++uXx+NW?=
 =?iso-8859-1?Q?xom1ZYTePAz+uWdpebIGHPVB0t79FOzg09sSDoaxqPuoyXaprp3qDYYn7v?=
 =?iso-8859-1?Q?W5mcQwmRGTcE4VcS+9jYz7w2aQMS/sUKUZd7AXvPVyiacX/z3+jL3KH1kt?=
 =?iso-8859-1?Q?0J1dD25y7GpnFf73kVyPfA2E08eCvFXiQt24anQIGBFF2U0ZtKe4Yf2xtG?=
 =?iso-8859-1?Q?fySqFWbKdSXQ0NSKmD5xdm0II58gt867teziw2SGePuJakAfcxRp7Tnb/s?=
 =?iso-8859-1?Q?zT6qiiY0qkw7EqT6saFHk3aEmGX35VnsTBAJ5+9kRQl0rhfkrBa6VPa0Mp?=
 =?iso-8859-1?Q?MRr0MzikJxmGW95MObN0exTnzN7G+RL0lG9fR6ikUj9yPrHL8HiMxPtLfk?=
 =?iso-8859-1?Q?Gahyr4oQZmfIMwoQMjhSLmKziQob1e5EoJAOjDqehxVVIG+mtftoIxWWsq?=
 =?iso-8859-1?Q?BPHue0379CCnPwmCHxdBxfCOFoN6ZnBi9pwxmTunyl1AZx4dLLhKdsFT5r?=
 =?iso-8859-1?Q?qagMghmF2ZDya2xF9asPQBJkg4BKL6UyjQK4AxnoqWCmFqOdXSrst0ffg0?=
 =?iso-8859-1?Q?vfrSMKCmOsAaKf3ZxqSvCkaQ5ths9G1FvMhy5agwnHqHGHT/AdItBO6WmS?=
 =?iso-8859-1?Q?ZKYNWE8TFdgJ3r0/OLLVEdupepRCxC8eH1m2lMSlwazZHSOI3eYheDu/sB?=
 =?iso-8859-1?Q?RwfBlPc6O3QbeHufjMpKvKE2Rkc3dJ55aixPS8nY21Kpjp7zgkgJh/JWwr?=
 =?iso-8859-1?Q?PtRXPnnOKAAdbMBNIjSfogTHIzF3ETaePaaBVpwYGKa9kZh7Q0kJMPSBH0?=
 =?iso-8859-1?Q?MRPphKjY73CcADu3ae0bWch2/KE8jYHCB6ot4Bxs8aBr49kMMJKhoyuG2v?=
 =?iso-8859-1?Q?vmZRqnJjriGRMY7zFGAOpSovbtipsdTA72fC6mELNSvHc0+XsGKQIbkZ52?=
 =?iso-8859-1?Q?OkW+S8XlPWelbdya3lZrBGpN3znddaeLu5hLtzIA/4apnkSUHCmCUR5W3t?=
 =?iso-8859-1?Q?WKneRTJiFfzHQeFRr+BJpaimtMAWJRhp2RFRoZaDnxrLVNHTa3+5mXHexc?=
 =?iso-8859-1?Q?BfRrTjD3fR9VuHE4XZtIZHeZcpHMgEu6y60cpCLBiBArhf?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5145.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8016c83-0a11-4c0e-9ac8-08da343c075b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 17:22:45.2316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2cS4E4jeD252sax7o6gKqSHME5ZU/MWwtxmmWa14LRKDj89ypGxcHV/QdPn9G7KWAH35YgrA1LcPsVRaxKFtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3347
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, 
 Jerry" <Jerry.Zuo@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Wentland, 
 Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Daniel

Thanks for your comments and explanations. I replied in-line and look forwa=
rd to more discussion.

regards
David


From: Daniel Vetter <daniel@ffwll.ch>
Sent: Thursday, May 12, 2022 7:22 AM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Zhang, Dingchen (David) <Dingchen.Zhang@amd.com>; amd-gfx list <amd-gfx=
@lists.freedesktop.org>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li,=
 Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.c=
om>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <R=
odrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solo=
mon.Chiu@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo <Aurab=
indo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <B=
hawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; =
Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: Re: [PATCH v2 00/19] DC/DM changes needed for amdgpu PSR-SU

On Wed, 11 May 2022 at 17:35, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, May 10, 2022 at 4:45 PM David Zhang <dingchen.zhang@amd.com> wrot=
e:
> >
> > changes in v2:
> > -----------------------
> > - set vsc_packet_rev2 for PSR1 which is safer
> > - add exposure of AMD specific DPCD regs for PSR-SU-RC (rate-control)
> > - add DC/DM change related to amdgpu PSR-SU-RC
> >
> >
> > David Zhang (18):
> >   drm/amd/display: align dmub cmd header to latest dmub FW to support
> >     PSR-SU
> >   drm/amd/display: feed PSR-SU as psr version to dmub FW
> >   drm/amd/display: combine dirty rectangles in DMUB FW
> >   drm/amd/display: update GSP1 generic info packet for PSRSU
> >   drm/amd/display: revise Start/End SDP data
> >   drm/amd/display: program PSR2 DPCD Configuration
> >   drm/amd/display: Passing Y-granularity to dmub fw
> >   drm/amd/display: Set default value of line_capture_indication
> >   drm/amd/display: add vline time in micro sec to PSR context
> >   drm/amd/display: fix system hang when PSR exits
> >   drm/amd/display: Set PSR level to enable ALPM by default
> >   drm/amd/display: use HW lock mgr for PSR-SU
> >   drm/amd/display: PSRSU+DSC WA for specific TCON
> >   drm/amd/display: add shared helpers to update psr config fields to
> >     power module
> >   drm/amd/display: calculate psr config settings in runtime in DM
> >   drm/amd/display: update cursor position to DMUB FW
> >   drm/amd/display: expose AMD source specific DPCD for FreeSync PSR
> >     support
> >   drm/amd/display: PSR-SU rate control support in DC
> >
> > Leo Li (1):
> >   drm/amd/display: Implement MPO PSR SU
>
> A couple of suggestions from Daniel on IRC:
> 1.  Might be good to extract the "calculate total crtc damage" code
> from i915 in intel_psr2_sel_fetch_update, stuff that into damage
> helpers and reuse for i915 and amdgpu

To expand a bit on this. There is currently a helper for total damage,
but it's at the fb/plane level for drivers which need to upload
buffers (usb/spi or virtual) drm_atomic_helper_damage_merged(). That
one probably needs to be renamed to signify it's about the plane, and
then we need a new drm_atomic_helper_crtc_damage_merged() which
(extract from i915 code ideally) which computes total crtc damage for
stuff like psr2/su or the command mode dsi panels (unfortunately none
of the drivers for android for these panels have been upstreamed yet).

<<<
Checked the DRM comment for the helper `drm_atomic_helper_damage_merged()` =
and
quoted below:
*****
Drivers might want to use the helper functions drm_atomic_helper_damage_ite=
r_init()
and drm_atomic_helper_damage_iter_next() or drm_atomic_helper_damage_merged=
()
if the driver can only handle a single damage region at most.
*****
Currently for amdgpu, the multiple damage clips combination (merging) is ha=
ndled in
DMUB firmware. And the DRM comment shows that the usage of "damage_merged()=
"
helper is for the driver which can only handle single damage region at most=
.

Since AMDGPU is capable of handling multiple damaged clip (in DMUB FW), can=
 I
understand that the group of helpers of `damage_merged()` in DRM is not man=
datory
but optional?



I also think that the split between dc and kms is a bit funny, I'd put
only the resulting damage rect into dc_pipe and do the computation of
that in the drm/kms linux code outside of dc functions (or in the glue
code for dc), since I'm assuming on windows it's completely different
approach in how you compute damage. Especially once we have the crtc
damage helper on linux.

> 2.  The commit message on "drm/amd/display: Implement MPO PSR SU" is a
> bit funny, since if you use the helpers right you always get damage
> information, just when it's from userspace that doesn't set explicit
> damage it's just always the entire plane.

<<<
The current implementation to mark the entire MPO as dirt RECT is not the f=
inal
version. Our next step is to implement the translation of DRM damaged clips=
 to
DC regions and pass to let DMUB FW to handle, which is able to handle at mo=
st
3 damaged regions for each DC surface.



Yeah so that one was just another reason to use the helpers more in
amdgpu for this.
-Daniel

>
> Alex
>
> >
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 142 +++++++++-
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  21 +-
> >  drivers/gpu/drm/amd/display/dc/core/dc.c      |  54 ++++
> >  drivers/gpu/drm/amd/display/dc/core/dc_link.c |  47 +++-
> >  drivers/gpu/drm/amd/display/dc/dc_link.h      |   4 +
> >  drivers/gpu/drm/amd/display/dc/dc_stream.h    |   5 +
> >  drivers/gpu/drm/amd/display/dc/dc_types.h     |  23 +-
> >  .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   2 +
> >  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  64 +++++
> >  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   2 +
> >  .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |   2 +
> >  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 131 +++++++++
> >  .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   2 +
> >  .../dc/dcn30/dcn30_dio_stream_encoder.c       |  15 ++
> >  drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
> >  .../drm/amd/display/dc/inc/hw/link_encoder.h  |  21 +-
> >  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 250 +++++++++++++++++-
> >  .../amd/display/include/ddc_service_types.h   |   1 +
> >  .../display/modules/info_packet/info_packet.c |  29 +-
> >  .../amd/display/modules/power/power_helpers.c |  84 ++++++
> >  .../amd/display/modules/power/power_helpers.h |   6 +
> >  21 files changed, 887 insertions(+), 19 deletions(-)
> >
> > --
> > 2.25.1
> >



--
Daniel Vetter
Software Engineer, Intel Corporation
https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fblog.ffw=
ll.ch%2F&amp;data=3D05%7C01%7Cdingchen.zhang%40amd.com%7Cbf7f256980c04124f6=
0808da3409b3d4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637879513542024=
968%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dtlr9ThR7DPE%2B8wv9e3n7Ud63J=
u9%2FRrka4OdK1KRgeWI%3D&amp;reserved=3D0
