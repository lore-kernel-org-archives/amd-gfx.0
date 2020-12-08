Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F28C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 15:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6950023AA9
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 15:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6950023AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE1CF89165;
	Tue,  8 Dec 2020 15:54:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA63C6E959
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 15:54:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMbxaTLv13ntcDp7/1eTRv8lK6KQdnBVy5oA8/6XpV/KMhOPhPokstzKLWcn6iTTr6Vm/IHUw66iyocGyFjmMxMo5cEzeq+i5FC9QCt8b0B4a0swF/0azdDg/TpXBuV9uWlrHEcd22pBU/sguIWbQcxZnRgGlvs/pZ1bM9mciBgISbyOr5XIGOAdz4i2KqkXS3XvLVpY84VrybQMP1XiBdvqf9S4J1iegMWC9BM0ZYHcjTwcM4XeCbYSSATEPqi2Ml+rjWslgLC+ZEQYwUOlZu+8kSPTGc/wqgd5uU2xJqavP2DL8uUG4u71EsFzA9WaNG6xUsEXVe959Gm8sF+Wmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXnCrxWNP26040+XaJy1g/wbm8sd7XWH5cxPm4HA0Pk=;
 b=Lbz0mFRuqiV6S7sL3HC8i9mS8TgJ6PkZVF0wz5Z4po1JjtugYbtXNBpH+WMXiE0ZeMv829qXRQ6MiZbe5KAbjVs0N8/R3ekNprHEGyPZ1kT7rvdv1COAwoMT6rMEEbTvkuUyoNeZuwPQ7500t6eH64n2g8MRajc7Eybg6RP+9DLsuMiAPsUr0pAaev0IqGdhwn2oh7Q3ftKzArcat/7PepYb7footBgEE8FZtC965g0lTBb+Pxc9pKo7gbsTJEUqhZYOueLH0Q+cKgAWY0B507lIiP6pVpGp/6uJnGOUTLZSyPqQBW1TYoALNx/L+avrr4hPOB6nHVvfrcIwU6KxmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXnCrxWNP26040+XaJy1g/wbm8sd7XWH5cxPm4HA0Pk=;
 b=nuJyhBlLn2rJX/OpbNjWtFaS5BjCYW1ZwuyIHpISx/yLqzXzsQHmeJVbk1MRRlMavveKdWCIWRme3KNH3HL3/eHU6+iL6s3NYWrT1FZbV+wM5gMR9rGCeZcmoXVyU2PhPOhP/GFfPnVrDL5l56A3dVDCsGsOI29VV9mADEcA5Lo=
Received: from BN8PR12MB3281.namprd12.prod.outlook.com (2603:10b6:408:6e::22)
 by BN8PR12MB2882.namprd12.prod.outlook.com (2603:10b6:408:96::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 15:54:29 +0000
Received: from BN8PR12MB3281.namprd12.prod.outlook.com
 ([fe80::b98f:7fbe:826f:b97b]) by BN8PR12MB3281.namprd12.prod.outlook.com
 ([fe80::b98f:7fbe:826f:b97b%5]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 15:54:29 +0000
From: "Brol, Eryk" <Eryk.Brol@amd.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] drm/amd/display: Do full modeset when DSC debugfs is
 changed
Thread-Topic: [bug report] drm/amd/display: Do full modeset when DSC debugfs
 is changed
Thread-Index: AQHWylDAVal6RTRn2Uyxsco96l5pxKntX9Xk
Date: Tue, 8 Dec 2020 15:54:28 +0000
Message-ID: <BN8PR12MB3281864CD2E9A997013213D1E5CD0@BN8PR12MB3281.namprd12.prod.outlook.com>
References: <X8pTRcVIEnhyFFoX@mwanda>
In-Reply-To: <X8pTRcVIEnhyFFoX@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-08T15:54:28.502Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1774214a-3cce-46e6-38ec-08d89b918bc5
x-ms-traffictypediagnostic: BN8PR12MB2882:
x-microsoft-antispam-prvs: <BN8PR12MB2882717DAE9F0F023FB6F739E5CD0@BN8PR12MB2882.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /wVJGqejg/5NOZ+DbhIyTWf5+BqT0iFMxAPWeTwUecYBOpvBSLy1iyDL6MrljqeSBkfd8HFKaz3DIKZRjMBWTuf0yyNJYttC+FG8epUb16iWQREGonSgNVlfz1wBUT1GZnA2Hw4/YxBRth5DaPVW51NwYRnYwtCTBsMU7je4tx0phKsHLQr7jUkWph2tOXlZzGUB9PR+Hd1IujS5Rnpy+PWJdkDkJ/m3rv4EtRqiut66Z8rR6D3OYuUbvWZugCKICfEnqZdcsmZFodXCapgW39wFTApgqu7ZoGBIxoZEix+EcZ6zoW2py4LbX/fx4vnT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3281.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(33656002)(86362001)(83380400001)(6506007)(186003)(52536014)(316002)(71200400001)(53546011)(9686003)(66556008)(64756008)(8936002)(2906002)(76116006)(66476007)(7696005)(4326008)(55016002)(6916009)(66446008)(478600001)(5660300002)(19627405001)(8676002)(66946007)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pzpnfNcPY6FEbrj8e5H/u9b6gxzXkHvnHEs0STJhEUYS/+y7JIO71iAn1A9S?=
 =?us-ascii?Q?o/eUhcwTeMLaz5U/lj41m8T1+orQFfIkMbWCHs3Gm4CDhWGSbLxsVBrv3Jj/?=
 =?us-ascii?Q?T71mGkBUg5bWgewoxuRwCSSVaMgFCkrmO+C/04ygbRg1r3YbpOsN1Hg/3tl/?=
 =?us-ascii?Q?NXLXnFJ/M7AxElsex3SPdiOxyVR1GWcP4fbBsIpYTIZl1vdfgX3iSVS8jpFW?=
 =?us-ascii?Q?3cxWkxbDX2lI0vObrDKcbG7sOhSwuIUoSZnIl72cpjFzvw70GwnjgGBEsx18?=
 =?us-ascii?Q?53SHvA+XsME6AEiLH9J6M9UKplBsxsoX9+mHjRc2W4aX5YUhv5a6Z+R+5CyQ?=
 =?us-ascii?Q?Md0TmBrX5b6cfAghvRenGMTtM76CWteER72MpDAvINfwgEpeXb06Hxj9Ajdo?=
 =?us-ascii?Q?7t4v5q+OrYd50mhBxnewABNCNOaYcYiSm7cLrYyDNZFdUtgE8Q5pRlwWM+dO?=
 =?us-ascii?Q?ZZc+LKc5Yvfo2R7xcKrtCG04ZbH2XAU8GLqI3//FCD1OZ+4DlAKQt8IzAw0+?=
 =?us-ascii?Q?uYDo6zLVV+jmBfOjNWHEREshk1w3FyAat1Fyao8PuG44yssMo7DjmlmuLQoB?=
 =?us-ascii?Q?Q3xWVdJGGqqswKCO6jU954Sf0o4ZNyVC6MefKeEurssF0LNAyyCaXmPj9Loi?=
 =?us-ascii?Q?ggkaJn/c4u9bI6GjSqfIfhl9hdBsvT0gThHXE2d1PjVDwO6rwlotscTOXzSx?=
 =?us-ascii?Q?H7+7XvIEEfsrE4JmaOaFH6N4JXWwGIVZ2Lk9qqWW+how47nD3CTcFH5wwUQF?=
 =?us-ascii?Q?vIkS2AV5VzfLDWlECIgSPcvsK8SPWc9+5KT+yP8N6FXYN3YjUSkfxEzla+sa?=
 =?us-ascii?Q?77xFqkfnVMRcgXmzfe3cAWbUa1Uhn2UFp9XITkMzpRiok9txURJwC8lwvJ5B?=
 =?us-ascii?Q?eaKw3pNMMdeQw8vAgTqfI07xiFd9mlCvbQA97NCHVUhvoVI9IWUqy23d0S+T?=
 =?us-ascii?Q?Z9xzaDSmwsr/BLZzEKS4L+/5XJygW/IqPZr3wmf3hbE=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3281.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1774214a-3cce-46e6-38ec-08d89b918bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 15:54:28.8817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQm2vVUhvwTnS1HTmImJ7FkC93Q5ayTJMbgdY1zwfFtJmvFTGfr4CYPpP/tT5Pve
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2882
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============2093759334=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2093759334==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN8PR12MB3281864CD2E9A997013213D1E5CD0BN8PR12MB3281namp_"

--_000_BN8PR12MB3281864CD2E9A997013213D1E5CD0BN8PR12MB3281namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Dan,

Thanks for catching this!
I've removed the extra NULL check as it's not needed.

Cheers,
Eryk Brol
________________________________
From: Dan Carpenter <dan.carpenter@oracle.com>
Sent: Friday, December 4, 2020 10:18 AM
To: Brol, Eryk <Eryk.Brol@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [bug report] drm/amd/display: Do full modeset when DSC debugfs is =
changed

Hello Eryk Brol,

This is a semi-automatic email about new static checker warnings.

The patch 115a385c08d8: "drm/amd/display: Do full modeset when DSC
debugfs is changed" from Nov 19, 2020, leads to the following Smatch
complaint:

    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9335 amdgpu=
_dm_atomic_check()
    warn: variable dereferenced before check 'new_crtc_state' (see line 931=
8)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
  9317
  9318                  if (!drm_atomic_crtc_needs_modeset(new_crtc_state) =
&&
  9319                      !new_crtc_state->color_mgmt_changed &&
  9320                      old_crtc_state->vrr_enabled =3D=3D new_crtc_sta=
te->vrr_enabled &&
  9321                          dm_old_crtc_state->dsc_force_changed =3D=3D=
 false)
  9322                          continue;
  9323
  9324                  if (!new_crtc_state->enable)
                             ^^^^^^^^^^^^^^^^^^^^^^
This is already dereferenced

  9325                          continue;
  9326
  9327                  ret =3D drm_atomic_add_affected_connectors(state, c=
rtc);
  9328                  if (ret)
  9329                          return ret;
  9330
  9331                  ret =3D drm_atomic_add_affected_planes(state, crtc)=
;
  9332                  if (ret)
  9333                          goto fail;
  9334
  9335                  if (dm_old_crtc_state->dsc_force_changed && new_crt=
c_state)
                                                                    ^^^^^^^=
^^^^^^^
So hopefully this NULL check can be removed?

  9336                          new_crtc_state->mode_changed =3D true;
  9337          }

regards,
dan carpenter

--_000_BN8PR12MB3281864CD2E9A997013213D1E5CD0BN8PR12MB3281namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Hi Dan,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Thanks for catching this!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
I've removed the extra NULL check as it's not needed.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Cheers,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Eryk Brol<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dan Carpenter &lt;dan=
.carpenter@oracle.com&gt;<br>
<b>Sent:</b> Friday, December 4, 2020 10:18 AM<br>
<b>To:</b> Brol, Eryk &lt;Eryk.Brol@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> [bug report] drm/amd/display: Do full modeset when DSC debu=
gfs is changed</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hello Eryk Brol,<br>
<br>
This is a semi-automatic email about new static checker warnings.<br>
<br>
The patch 115a385c08d8: &quot;drm/amd/display: Do full modeset when DSC<br>
debugfs is changed&quot; from Nov 19, 2020, leads to the following Smatch<b=
r>
complaint:<br>
<br>
&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_d=
m.c:9335 amdgpu_dm_atomic_check()<br>
&nbsp;&nbsp;&nbsp; warn: variable dereferenced before check 'new_crtc_state=
' (see line 9318)<br>
<br>
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c<br>
&nbsp; 9317&nbsp; <br>
&nbsp; 9318&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!drm_atomic_crtc_needs_modeset(n=
ew_crtc_state) &amp;&amp;<br>
&nbsp; 9319&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !new_crtc_st=
ate-&gt;color_mgmt_changed &amp;&amp;<br>
&nbsp; 9320&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old_crtc_sta=
te-&gt;vrr_enabled =3D=3D new_crtc_state-&gt;vrr_enabled &amp;&amp;<br>
&nbsp; 9321&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; dm_old_crtc_state-&gt;dsc_force_changed =3D=3D false)<br>
&nbsp; 9322&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; continue;<br>
&nbsp; 9323&nbsp; <br>
&nbsp; 9324&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!new_crtc_state-&gt;enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ^^^^^^^^^^^^^^^^^^^^^^<br>
This is already dereferenced<br>
<br>
&nbsp; 9325&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; continue;<br>
&nbsp; 9326&nbsp; <br>
&nbsp; 9327&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D drm_atomic_add_affected_conn=
ectors(state, crtc);<br>
&nbsp; 9328&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp; 9329&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return ret;<br>
&nbsp; 9330&nbsp; <br>
&nbsp; 9331&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D drm_atomic_add_affected_plan=
es(state, crtc);<br>
&nbsp; 9332&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp; 9333&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; goto fail;<br>
&nbsp; 9334&nbsp; <br>
&nbsp; 9335&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dm_old_crtc_state-&gt;dsc_force_=
changed &amp;&amp; new_crtc_state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ^^^^^^^^^^^^^^<br>
So hopefully this NULL check can be removed?<br>
<br>
&nbsp; 9336&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; new_crtc_state-&gt;mode_changed =3D true;<br>
&nbsp; 9337&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
regards,<br>
dan carpenter<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN8PR12MB3281864CD2E9A997013213D1E5CD0BN8PR12MB3281namp_--

--===============2093759334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2093759334==--
