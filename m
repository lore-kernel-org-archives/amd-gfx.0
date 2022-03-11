Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79608C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Mar 2022 00:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 042E910E1EF;
	Fri, 11 Mar 2022 00:06:19 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EC0D10E10C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Mar 2022 00:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDaRsHHwQWFHf5OP9mZjsP1PzJQlgvysXjOFS1GNMy4dJYM3QkCTJGyXMny38gCdJRYGIClB2UdxQ9PmI1cC+WdQk6TEkKlSo3GfH59EOT/FQ3iokLlsKmG2mJCK443OZE0zvCaZnyPoT0gMs5bvxxPZ4Z6en3ub58NaTjkMEydEulbq4NXE2s6CpTwi1vFmP3e3/HHKSoZVYv5pwWzB5iKRJv5dSAOhXJOgu9xRxqnPL8VmuE5gFZ32GtIZ4r/r6XqR/JW/do1lkUvapnskjejkWcGe9fXrjLo1uQtAo8AZhcF+ct5E5Bpe23DHNTigI4Ca/PnpB86qk+hfvNV9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3pKIpVoqPLSvX72umFQsJLRylXPIL8MOvqzZQNNqlM=;
 b=YlbrsIlktpe6dwi4EYY+Lz+jwGqRQaGehC+LUZfE54hC+YcehWQFXHXtyNI1chiUZdqeFkSbg6TrzHiStWkteaGc+wSAQ4ETRmpflay/UylQZOMXXCXt+V6ma6ttuPQzlcCtH9XpkoWSrmxys/x90yFH5mSj4VbBFi9QSwRUoM5x0iguI0RlgeU9WO73fn11vGAj+ZBpaZEDFk9sJw+FkrT5c3XUnGNIvOLoVb5sjRwZhfV1b6N1e53hG9USTqOKvh9PLVPLtWNBr5qrlpjyWGRJvDkKTLef7lXYxBqT6cPa6odNbFLVEI6xlc2HRZZntrJVx3DluvhCp0YNazeIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3pKIpVoqPLSvX72umFQsJLRylXPIL8MOvqzZQNNqlM=;
 b=nhfwf6LrHi0pBGiYqyJwKLDk/pcvg86REs5jFqrWckU+djKbBJWdP/zvCiknMNuEC3DA7WVH885pgHqzGd93zrJ1fyf2MCola6dPqNWv96MoR1gRkP+l0bFDdFSAdSudgaz29cW1nop9n5nZq2HUJ96OEGmyJL+BXHLRs3G/yts=
Received: from DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15)
 by CY4PR1201MB0151.namprd12.prod.outlook.com (2603:10b6:910:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 11 Mar
 2022 00:06:14 +0000
Received: from DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::b8ec:5650:98f1:bffe]) by DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::b8ec:5650:98f1:bffe%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 00:06:13 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd: fix gfx hang on renoir in IGT reload test
Thread-Topic: [PATCH] drm/amd: fix gfx hang on renoir in IGT reload test
Thread-Index: AQHYNIfQ8M4hwkre10qA7Zl4mqcaYKy41UIAgAB5NKY=
Date: Fri, 11 Mar 2022 00:06:13 +0000
Message-ID: <DM4PR12MB52942CFF930BB7283A3DFEA2950C9@DM4PR12MB5294.namprd12.prod.outlook.com>
References: <20220310140439.249268-1-tianci.yin@amd.com>
 <CADnq5_O=taXukBJYMj=fffvZ37ZbpUjHi+70N02U7WNt5420pA@mail.gmail.com>
In-Reply-To: <CADnq5_O=taXukBJYMj=fffvZ37ZbpUjHi+70N02U7WNt5420pA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-11T00:06:12.866Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 559f6df4-bde2-2631-f389-b054d7ba83de
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67ea248f-39ea-4cae-288f-08da02f2f4d6
x-ms-traffictypediagnostic: CY4PR1201MB0151:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB015110DC961541C44CFF37DF950C9@CY4PR1201MB0151.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QjDbXfR9pePT+LMGo/5VazrNHMB5zGGSn883yscHxXrs010VMKIAaTaTFXlEUxqHBOyWQKZvj2TG3ZghjhJ2Tw3iDV9+EgAXs8q8GG9zQPhC1mqxVPsHLt63w4IgtnglsdHeIw5698Kko4VYVQGi8DfRGOm5dJBT/xx0WIgl3Ua4WpBgVVKWMpXN9jJYK7bbxld0o1/Y1o7DY/AESSMGVAI3uIgiH22sAY2L4pgZynioFKzKgygHYtP4H5TxRZ43YpOKD7nGdW6oO6YoDij76+85ZjNP4UXx0UPQNTZBMkQ8krMgEQ6H+0Bo2SpC2bPZpHNfCcVvw0V2ajHAUjNDJq4s1y/PVldSFpJbbCVrIKyxVRUs3peffbBSTiYl66Ep3xr/MLo3ATmlC/miiIQ5+R6S0BpPj4P8xdfpLqrHOUavEFfzONn6GBTQwHklOoxNV62RhmJIsRuKdruN7T+LgIVOgKco3paNQwSYujFEkwKwK2fi+8eCwWevjPnRNqX2+BnF605rqdSZw3ut8xH0UqEW2bmlh5U8hdbIT2v0uivXw/FYAEHJ/vyR1v8zobiLRmypfWIITRI06SGC6Ax1i6pbI/QuQVyXrmr+JMRWsxnO3EeVeCSV+yB7ECITIMNm3cyU/VpK9ogL42wGSTiWqIXc+FnhjZvJIk88sQnxZgMtEGC6Z2IMwzHA2vnH96y4ICFIhB1B2Hw/sb0E8xm7qQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5294.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(55016003)(91956017)(86362001)(64756008)(66446008)(66476007)(9686003)(66556008)(186003)(26005)(8676002)(76116006)(4326008)(53546011)(6506007)(38070700005)(508600001)(7696005)(5660300002)(122000001)(19627405001)(54906003)(6916009)(316002)(33656002)(2906002)(71200400001)(8936002)(52536014)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X6qtWw/c97orpnKhXFyGObVS0+t0OckfF2u7Xcl0wKqmlpB+heqip2/a8Rt2?=
 =?us-ascii?Q?pSKtJR5Oszt4l8XiEIivJS9+OYQ+UEJB1Qx/pzDfGp5cpTdg+xycHzC3RV7L?=
 =?us-ascii?Q?YItHUMK/59o4+MmzElfjn81BzHpGcAt5Q8FYHuFHb9TLYgO/WGf/rvU6zAGq?=
 =?us-ascii?Q?T4zW5UUII3cVrbzT3c1usE19nx2PCE65xlOdw/1yuOiAy2RejzW1p2yomMv5?=
 =?us-ascii?Q?YWfSjG8PVbLMPhEaJMzysqsq85pwhIOH6ROP5tiVd8fn6Wsda+Stf43NGfGk?=
 =?us-ascii?Q?ZrB/XfG+5Gg93DaTr0ImBoVf2ka6/bN3Ev9jT+Gu13XSJvjg2lXBSy4k/S1n?=
 =?us-ascii?Q?KZGV/kq02LLXGROaQypclfqunVUryfI+UcTZH7QfodJgQOjVHDOhznRMKN9f?=
 =?us-ascii?Q?AyGWhtEdLAepUO3ZgedneLguAbgZGUdlYlcF8XcFtdZLkftELZrjVM9nd7Up?=
 =?us-ascii?Q?N21wf34/cehvRa1hvd+IXC/74SbgQlj11TVE48aR302ZIoUme1y3J0TdpVY8?=
 =?us-ascii?Q?F/dPZ0lb1ewayI+UBkIxRB0Mvfl2qw6qrS8C0v68Szw/i4MoJVXGlVUt6cg8?=
 =?us-ascii?Q?H3DCdVtOt+fc7HPul0FZ0tP7VBdO4PY85TsRLXoXxBmNTuPDO/VhkAdHlboM?=
 =?us-ascii?Q?VKEBxtCYMK5zn7+sOCq2Gn6xfwwkVp1H2fC5VjuunyLox1pRLzwg1+fnfHhA?=
 =?us-ascii?Q?WTBSOvXQg1K0tUq6ZG4FY2r9cXrUIXbJqpoGVEqgSourcj1MKq7vu0uvyUKM?=
 =?us-ascii?Q?GInEixTomcHxBQQ0DhzJGNAkfG+Mcg+B1FJYvDvofQbql5+sQHNnaFjUwysh?=
 =?us-ascii?Q?QnJ5brOEEo1YaWIroeApauSjeoSuckabBg7IDCPEqlt63uETQkYsj+obwAYJ?=
 =?us-ascii?Q?w0otPuQ8DKDyX2HSJarANWpCgFcSnCtwivsI6CIqKtv8s1jO4hCH1p7KF1oQ?=
 =?us-ascii?Q?mBpMguaCgQ5U7p2aFf8SxJRuA0U1aMDc8xP4m17KcVpIWeJtzNIWy82PRhsf?=
 =?us-ascii?Q?pCsxbiVib2goUjCRn/2UwGqS2w7UQF40mSdc9jHIW3LWO++k4SJYbEdGmp6K?=
 =?us-ascii?Q?gEl45gSkLyQx1Ddvw1HoC51TQ6zdWoLxHXYgdFXMM7yUrk3+lOIC9xwJTeUQ?=
 =?us-ascii?Q?64UEwUc8h2KipOm1ysXRmXbbTz/4xrtTEVledyfh2hhCWXe3NCD1NktpcII7?=
 =?us-ascii?Q?ab/NhOeGrsWlcvq96MPykfDsl+fRK61yTfPUJgHWxXncHfvUE8FvSoQDPSN0?=
 =?us-ascii?Q?xZE2eGQv+txxJGmkePvVui0sLfsfC2K/zvBlqU2v4T4Fxv7gZAiZgHkiIECv?=
 =?us-ascii?Q?T6pKBLNQ7rM1LD0wPmjzF8h1TEhxhN+m6m7XiMPPFstyIsWD2RCou0i2YWsf?=
 =?us-ascii?Q?Coxe0ItOiMFQtebBQ5TG61TfD45fbGmNPO21MNSO0nX3uHIwbys+AMOkr+7v?=
 =?us-ascii?Q?5M7MrMTgjjfnMyeGNfVU7zkHRzO4FUMSdPdPbbMTyIGTCkLjIh9uqXhGK/ey?=
 =?us-ascii?Q?GTf+VvcnGVj67R9c0kecQMB+CzThRSTOwYMYyerU4NLOTOCJeXr9lhGCgHVk?=
 =?us-ascii?Q?qBAXlP/q98g+0jUopy0NYfMrWBN3mf2v78Y0axbi9WdudR5+4Ssyc7vfWFwz?=
 =?us-ascii?Q?fEabvDkRo7aIDFomPE8fV/A=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB52942CFF930BB7283A3DFEA2950C9DM4PR12MB5294namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ea248f-39ea-4cae-288f-08da02f2f4d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 00:06:13.8426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DmBkpuMoceUa+YZL639CISrDsJb+C/mkSVm20nIGTL6lUNgYPFsaQMiJDAefyRxo6mqSjH/Oy7P15EsEn+qD7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0151
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Liu,
 Wenjing" <Wenjing.Liu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yu \(Charlie\)" <Yu.Wang4@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB52942CFF930BB7283A3DFEA2950C9DM4PR12MB5294namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Thank you very much Alex!

Regards,
Rico
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Friday, March 11, 2022 0:52
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Chen, Guchun <Guchun.Chen=
@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Liu, Wenjing <=
Wenjing.Liu@amd.com>; Wang, Yu (Charlie) <Yu.Wang4@amd.com>; Deucher, Alexa=
nder <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: Re: [PATCH] drm/amd: fix gfx hang on renoir in IGT reload test

On Thu, Mar 10, 2022 at 9:04 AM Tianci Yin <tianci.yin@amd.com> wrote:
>
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> [why]
> CP hangs in igt reloading test on renoir, more precisely, hangs on the
> second time insmod.
>
> [how]
> mode2 reset can make it recover, and mode2 reset only effects gfx core,
> dcn and the screen will not be impacted.
>
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index 496c4a6e23ac..f0713c027ed5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -853,6 +853,11 @@ static bool soc15_need_reset_on_init(struct amdgpu_d=
evice *adev)
>  {
>         u32 sol_reg;
>
> +       /* CP hangs in IGT reloading test on RN, reset to WA */
> +       if(adev->asic_type =3D=3D CHIP_RENOIR) {

Space between if and (.  Also, you can drop the { }.  With that fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex


> +               return true;
> +       }
> +
>         /* Just return false for soc15 GPUs.  Reset does not seem to
>          * be necessary.
>          */
> --
> 2.25.1
>

--_000_DM4PR12MB52942CFF930BB7283A3DFEA2950C9DM4PR12MB5294namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thank you very&nbsp;much Alex!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Friday, March 11, 2022 0:52<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Chen, Guchun=
 &lt;Guchun.Chen@amd.com&gt;; Zhuo, Qingqing (Lillian) &lt;Qingqing.Zhuo@am=
d.com&gt;; Liu, Wenjing &lt;Wenjing.Liu@amd.com&gt;; Wang, Yu (Charlie) &lt=
;Yu.Wang4@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;=
;
 Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd: fix gfx hang on renoir in IGT reload t=
est</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu, Mar 10, 2022 at 9:04 AM Tianci Yin &lt;tia=
nci.yin@amd.com&gt; wrote:<br>
&gt;<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt;<br>
&gt; [why]<br>
&gt; CP hangs in igt reloading test on renoir, more precisely, hangs on the=
<br>
&gt; second time insmod.<br>
&gt;<br>
&gt; [how]<br>
&gt; mode2 reset can make it recover, and mode2 reset only effects gfx core=
,<br>
&gt; dcn and the screen will not be impacted.<br>
&gt;<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c | 5 +++++<br>
&gt;&nbsp; 1 file changed, 5 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/=
amdgpu/soc15.c<br>
&gt; index 496c4a6e23ac..f0713c027ed5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; @@ -853,6 +853,11 @@ static bool soc15_need_reset_on_init(struct amdgp=
u_device *adev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 sol_reg;<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CP hangs in IGT reloading tes=
t on RN, reset to WA */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(adev-&gt;asic_type =3D=3D CHI=
P_RENOIR) {<br>
<br>
Space between if and (.&nbsp; Also, you can drop the { }.&nbsp; With that f=
ixed:<br>
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
Alex<br>
<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Just return false f=
or soc15 GPUs.&nbsp; Reset does not seem to<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * be necessary.<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB52942CFF930BB7283A3DFEA2950C9DM4PR12MB5294namp_--
