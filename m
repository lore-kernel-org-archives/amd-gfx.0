Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A47DE82CCD
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 19:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB1610E5A3;
	Wed, 27 Sep 2023 19:57:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABF2A10E5A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 19:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkwipBIVl3qbzqQPLRirIgQcJYCvSZ25cxmnqonpeq8zVpf+vd0miB4+VqcwEVRFzSXEVhdvdXl4BlO+UlLtBByO8feWq7reG2MxlHjuvyE7G0M1aoJCpP6uGG83WxYSsLQmf/wawvzzTgXSvIaRNbSmUxm9q4qb4kR3+O6Tjfj41KSoyx3fGsfnvDW3zjJOOTTV/OJLy2OSKfeQzkzMoxJyTGdS5BNP+i2VJP2blHLiJ8YF9BppT5Nay0vkUilf6HNeDexJE/4sCkdoqqbDrReLhdR3311wcUftlC3ROGFrWZtxIYDhqt6C8c+DWc8saxmlF2lfrD65yBPpAcL6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgoZvsxHNuf6dKqcU1wDQDIE2xI+o9bX1hLJhlGeO8s=;
 b=DSh8TYdoEUFF0CBiZThvP2neQTvgaNDAWRF/iwM1j3NPvVyvQr+TZ71FL9br1RqqTGwhryWt3PuhRtLsULuYY8nR3vYTY4ctyFggCglODqaTdn8vj9IpNLmr8ohk3ekp+yyhjQTAsDsrJgRHyL5cFNOdN2HSpRzbfmM0qT7ZYzy6BvxY+H/9Vch+/GeKWseARu7uHurP0ioPanKIGADL86vHxVrGByQEk1sBl7zL4m2JFvXEh62jeDNnND06LAhePczxxpkuIJL3DeYMIgVzQX6UZu9WwBXT4iZvk4JJoAdbS8KSzzoNXkrkYbpkRIUlfDUh/A6cNGe8xg/kTcpbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgoZvsxHNuf6dKqcU1wDQDIE2xI+o9bX1hLJhlGeO8s=;
 b=4lKhkXBjREJyWN1PxsC+X/N/CWQgoNd8i/HtU3EZXJM8gMqhpE/6fCYMEGkQyWaxf9/+AeGB/iU9wttw4XGF/8NVZveAws/iUgjnETsNJWiwxZ7HJsTNz/qOe7zlyRMdKI8nX98arVgex1KrV95VOU5HO1O1ZBXRLxdVoM0WMFM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29; Wed, 27 Sep
 2023 19:56:59 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 19:56:59 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: Disallow managing power profiles on SRIOV for
 gc11.0.3
Thread-Topic: [PATCH] drm/amd/pm: Disallow managing power profiles on SRIOV
 for gc11.0.3
Thread-Index: AQHZ8CbkmINSx0B/WUeGXBDt6p9aY7AvGSNi
Date: Wed, 27 Sep 2023 19:56:59 +0000
Message-ID: <BL1PR12MB51443C04808B256FB43643B5F7C2A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230926030859.3046382-1-Victor.Zhao@amd.com>
In-Reply-To: <20230926030859.3046382-1-Victor.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-09-27T19:56:58.464Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS7PR12MB6007:EE_
x-ms-office365-filtering-correlation-id: fa2959a6-b43e-4523-4d05-08dbbf93e8e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: klp87ZHwIrvql4JsP+hPZJ8XetH6VZTHQfTF2MOfUdRGomEKHoK76wOsz76vtrvoBH9BR+dINAZoW0G9+9PSBn9hPKODBYesqkH8BXizgdtziFrrReyCl4+W/THJmZoeDFwOGUVsgO75JH+9laZQbo9orgbSc9KULwjadQekF5OmT3jPqWp5PSgG2Kbl5IG4h60dY/PqoS+Bv91kqC+nCJ3WTsp8WyQ3zAaX0mIXWdN15gCbQunb2hFSoLcL2cNL5d/gBHImNAS+Pt/i6jLoLyRJOUk8xpqYXY6eu0NUmTrgStZevxwL8wVQbx5vVcbymrUPzakkUBgOCRDowPssF9wgmAtWO84DTG+pi+ePTPoY3JS4yIilxjMJDV9bstd6hSRXco++xWML+tl+zi28Fx604uOSgu0SwSr//xkn77+QVAkfYBI/EP0328iAxpus4TkqM0ZCre00JfH22NQI/snNnmHAxrmuSJkbCAhMppY9LY8X9Pb8hjb1MhieYojay4+pI/2Rv+1SxC+iiNbjPcsn4dGROuyyXj8P+hYh4j2nRbIFtkkP+Tr5ucAxrQ/+KYELnoIoNK7kWgIRj42ZGYK7noCsGQTxhkjHl5TAizP3R6IqIg3z1gclQ1oV0wYu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799009)(451199024)(186009)(478600001)(19627405001)(55016003)(33656002)(9686003)(41300700001)(122000001)(2906002)(38070700005)(38100700002)(86362001)(5660300002)(8936002)(66446008)(8676002)(71200400001)(52536014)(6506007)(53546011)(316002)(64756008)(66556008)(76116006)(66946007)(83380400001)(7696005)(26005)(110136005)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R1PR2Q99ZuqcS1S1YImE5eEkFT5shU6iJqb9OBYgGb+j3OsI542xuIj9QMSN?=
 =?us-ascii?Q?p80NNHC/AmzBvn9mjfhTgHOId0VBV5kq+uLvT35W5we+wIEHdFwFdjhVyDPG?=
 =?us-ascii?Q?0Gkme0UvnFHWLKGy2VsKP7i7ufAtdYhJNKPrbgmhuLB7G0TwF+2wvcdj8IId?=
 =?us-ascii?Q?q3fYnKcDAWXAA586fqAptL8eEyHAZSO4phoxVcMfnbpQ0S1TcIvNCwKkZdH+?=
 =?us-ascii?Q?oU1hjOEthOnoc3Ek9puFDG3QVbnruE3W02j/6IM8NeFwyWTdaM+xPc8/SzMd?=
 =?us-ascii?Q?+xYSZ5fDMnY2uXMH5iN/AvWQUlLK6lRjwCKB/pjXJJ+6sJh3LtCMpkuBFh4t?=
 =?us-ascii?Q?2xEoz+FZXysmd3SWJ1U7Abja1Y9VJ8PDdIVA0bZEOArfrMfHpSqWpKUzcOb0?=
 =?us-ascii?Q?eVgxzkMo8XuUhhX1RXqCFZV5dvm+rGwtsQFETUtTsNVOemj8p6R0zEGIgOVo?=
 =?us-ascii?Q?VoCgYUWI2AMGNNHbCDy21WSGi3dVXTzXfWA/w/d86v29fby58nPs6u+8wOiO?=
 =?us-ascii?Q?U6qXtRINOqd3mBo3KsTGocV/CQNHADnAqe//rXtdX8RVrxQx3fUIRh1IyFLk?=
 =?us-ascii?Q?Oz2L2OgHYHsXSB484pCdP7Vu4ZLyhbwwMzIqbdfkbqA35XaLiolxoba3aP3x?=
 =?us-ascii?Q?uPLXRwyARyQLS0JMM0nFeSklrlrr3UWNbMgZGLulby4Dno36FBJUY0yvEmdd?=
 =?us-ascii?Q?rh7F5cJoeJxTq5GAw5YJ/7vI2FoTfxhZMQ+AI7HpDR6nK6b7i+Kamn+vLNjd?=
 =?us-ascii?Q?6F8RflD2AogfJxcCVyiNMvLl5Ny1qdhskyB9mzQv/LWhGaobPJhSlo7h3fhf?=
 =?us-ascii?Q?1PCpqQcOkDuWuW17bJYAvrzy3+bJW5L+SzrCSxCCX/sv9JT2TSgv5YSbnZ3s?=
 =?us-ascii?Q?ktbZ1O0u3iQINhFU1HVrLkMsblCgtGCHqEtI4rYz1fQlHRlD1wLenYmzIAHB?=
 =?us-ascii?Q?xxbj6le/u92OR2YPPQjvNuiBAlJjJjr4H60FspsBFBCzvPfeSqOMIRwehmv5?=
 =?us-ascii?Q?/Fv9m3+n0da1hwjB7MpyNRGkgH1nhNrGVjdTLbgzpoo0aZQJ0eIB90vfj7Xd?=
 =?us-ascii?Q?ANFrcku2nfW3VXrVAXT0PNrrbeREubjBY3o+mZNdkhQ3s0vnuHS5/WhFHYI4?=
 =?us-ascii?Q?IEyu550A0e2/ytlT0mAQ5XTtPkzHw91Fal+l9HNUeGEhNiSBn5EKoSHfz1BR?=
 =?us-ascii?Q?0f4U74UWxIcB2Dhg8cQGCsxzDJUs31JRdG9N73+HmrLJKpnnNQRBRiBn2/YP?=
 =?us-ascii?Q?cSyS0SWEB/fCTeX8yT3FMV2mfKbwKiwpdJrRfn9+2weVDYu7qRqVfxPCB75E?=
 =?us-ascii?Q?jDKyn29jHhNl2InXV81E1VPoerErPvPBX5lhF7uRtJCDGxOgmySeuy2tAKtu?=
 =?us-ascii?Q?hkiv4/DUmnkVQHEUG824ciVtoTdjuYAynL9YJhKAz+ZCt1/8sJoGeYUxHbN0?=
 =?us-ascii?Q?DjxVtvcwlqmc9Khp450VrvJbTuyBmqFmHDuHjrLD0JZjiq+nx0YgteUTCC8M?=
 =?us-ascii?Q?VZjqjdNixvnSiAb2iNDFVO++Dj2yMK6McjMjipcetHroB6coZYCAThwWMIAR?=
 =?us-ascii?Q?ofXl/M2LPRdvIZ24PVE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51443C04808B256FB43643B5F7C2ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2959a6-b43e-4523-4d05-08dbbf93e8e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 19:56:59.1170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gNjIFKqbIQ+siSZUBYQOykIk73sc6HTRJGwPwAuZoz0bOB9gEAGX0k4vLKZjx5d821E9NZUdbPturr0Cb83aVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
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

--_000_BL1PR12MB51443C04808B256FB43643B5F7C2ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Victor Z=
hao <Victor.Zhao@amd.com>
Sent: Monday, September 25, 2023 11:08 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Victor <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amd/pm: Disallow managing power profiles on SRIOV for =
gc11.0.3

disable pp_power_profile_mode for sriov on gc11.0.3 as not supported
by smu

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 2d19282e4fbe..b6f32d57b81f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2122,7 +2122,8 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_
         } else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
                 if (amdgpu_dpm_get_power_profile_mode(adev, NULL) =3D=3D -=
EOPNOTSUPP)
                         *states =3D ATTR_STATE_UNSUPPORTED;
-               else if (gc_ver =3D=3D IP_VERSION(10, 3, 0) && amdgpu_sriov=
_vf(adev))
+               else if ((gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
+                         gc_ver =3D=3D IP_VERSION(11, 0, 3)) && amdgpu_sri=
ov_vf(adev))
                         *states =3D ATTR_STATE_UNSUPPORTED;
         }

--
2.34.1


--_000_BL1PR12MB51443C04808B256FB43643B5F7C2ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Victor Zhao &lt;Victor.Zhao@a=
md.com&gt;<br>
<b>Sent:</b> Monday, September 25, 2023 11:08 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhao, Victor &lt;Victor.Zhao@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Disallow managing power profiles on SRI=
OV for gc11.0.3</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">disable pp_power_profile_mode for sriov on gc11.0.=
3 as not supported<br>
by smu<br>
<br>
Signed-off-by: Victor Zhao &lt;Victor.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 2d19282e4fbe..b6f32d57b81f 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2122,7 +2122,8 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
pp_power_profile_mode)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_dpm_get_power_profile_mode(adev, NULL) =3D=
=3D -EOPNOTSUPP)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (gc_ver =3D=3D IP_VERSION(10, 3, 0) &amp;&amp; amdgpu_sr=
iov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if ((gc_ver =3D=3D IP_VERSION(10, 3, 0) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_v=
er =3D=3D IP_VERSION(11, 0, 3)) &amp;&amp; amdgpu_sriov_vf(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51443C04808B256FB43643B5F7C2ABL1PR12MB5144namp_--
