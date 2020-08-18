Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B47C433E4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 16:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3116A2065D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 16:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q0Rg3ri9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3116A2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D1C89AC2;
	Tue, 18 Aug 2020 16:16:26 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700070.outbound.protection.outlook.com [40.107.70.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F4EE89AC2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 16:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c91QgXlSrlG0pNhueYaJ2SgRVYtA6UcpoULU0nTOXrWo+nZblmjuLDYuJcMFzqEilB+RhpvEq1U0XdPvl9dksugs/aGKlu9PYakjpePefxBwR6SfERBg0Mh2yttKUeiA5z2t2wteJzYZsIkiThC4vDWB+17yotht6OPGY301SjOsfP2v34sTy2lMpthaygX25vQLB64d0yIpSG9xaU676D7Wr3sHV2UnqGIzkz54kwntA3Dg9okbSk/UH2DsvL6PE23qGGB+vmwX+3187BUh16U7ehI7i4wo5ZbvKA3EHNtKFwA1nIy2FHU6XgqJ0UvKdJRBUDo1lXTHhQWoTVyYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TJ3N9GJZv6jfawyq8tEbg4aGQTvDtwpQb4lIg2cNp0=;
 b=me6Wp9aJkHK/QUtE7daYRpNu/gw7xNiJFESgbSOLJPhmBtv2/xuWY7G/dj3mOL247Y5fe/6m+36qG398JuB5bjvDzUi0JZV88O+7HFN8LQ/UWGU3jA+JHhpL0itDPJUprGH8+PHaCLbhgl0CXOu18ga8xL0NFnx2XXcOWc4BqoTCabsumOPUQbpGSdGNmzyI6Wjvx4bsMl/WRZitKQqGHPBRjNJyaB3U5tI96VGuevl262N4+TV1ZCpcgrvW/+CoV7a16BzfZp2S2YxCx8WfnFTUlZzXtBsGB/S2eyzV1Cw6zgIMVgPwNZVyWumrZGLykQDr+tfrCC608ij7hWJsrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TJ3N9GJZv6jfawyq8tEbg4aGQTvDtwpQb4lIg2cNp0=;
 b=q0Rg3ri9ETcS8BIaarYZvuWVWAW4h2fR2raDBiaLvoVRNfgWn1p14QDS8EwNC7eUvj4p6eI6VcK6nOhkmjJ1sBqu05HPdR/4NiJkzIz7b6FihmkN+j3/zwv0RT/D5TeH5r2uZnv7EcvHFSWGcR73uXKM72Ja86l9bJNv+Y864qQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2402.namprd12.prod.outlook.com (2603:10b6:207:45::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Tue, 18 Aug
 2020 16:16:18 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3305.024; Tue, 18 Aug 2020
 16:16:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: Re: TTM/nouveau conflict in drm-misc-next
Thread-Topic: TTM/nouveau conflict in drm-misc-next
Thread-Index: AQHWclbuaB2CfqasgkGZnhHDuRfTQqk722UAgAIiWgCAABMRMQ==
Date: Tue, 18 Aug 2020 16:16:18 +0000
Message-ID: <MN2PR12MB44881FCB5A22742190B7E0FBF75C0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <2f7ae285-b51e-409f-9110-534bb68ec0ad@email.android.com>
 <737111f0-3789-5e7d-3862-ca1a7c5050e8@suse.de>,
 <3f600794-7d37-8b3c-a8e9-b0ff1170a61d@gmail.com>
In-Reply-To: <3f600794-7d37-8b3c-a8e9-b0ff1170a61d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-18T16:16:17.540Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 983ed9f6-5b83-43a3-879a-08d8439209ce
x-ms-traffictypediagnostic: BL0PR12MB2402:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB240275B9A553E7B6C14F5DDBF75C0@BL0PR12MB2402.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EzmAWYsUS9/BeacZhXmKhzfN9oDz8hAUKvzOAlhMgLO2YaASN8H8TQRx8z3f1RnljAOtQqc6oOV+a/9Z/5pbsDbwtdQEBTexBV7Ph9mHaSPvtVmGSLRb7/1iZcB7BsSqVJsGoHg6nWw3fsaF7DBtwi8/EcunnQdzAN3QkwfXJHyIi8BR5F4WULg1+T4ZFTvNdWnHjYxGhZaGAwlVxxesHSjB8Gf6fKloSIZV1gcIeJP1xx4Eh+cmd2ixQhJQsbYhYxsfwypvJ2iVEIszgCUUT5VdqPozyayhYpO99yzoUGtDhZkkorpkEj/x35btvpvxfsxcBlWUiG8q0A9LYTW0FC8qudiKGjWzIjPyooNmw7E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(6506007)(316002)(66446008)(64756008)(110136005)(76116006)(66946007)(66476007)(66556008)(52536014)(55016002)(33656002)(166002)(83380400001)(71200400001)(86362001)(8676002)(5660300002)(19627405001)(53546011)(4326008)(26005)(478600001)(966005)(7696005)(186003)(9686003)(8936002)(2906002)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 6NxA5XcwSzxYvP4aHzAMstTvQE/2S3QISILQ42N497Y8SwNozIuRTwQNDtA7RO/sH8SK+ZhRme6eIj46WYFN0y0jVYz6TTMOYCtK1ZAIOg/UVt2s59nuWOksDQ09UjTGI7TaassHn1nEuxtlf/qgqUb4IFz8DqPBfcepS8V2h02jCImGEjriV8+CXzDW/rEnZ+qw/PeBANgZZWpFJcKJE+Qsd7lq++V4jLB3bPFUHvpxAtKxm1lLL5lGHcyPVFE+3yGx+Uh2T1+QT+yTeVQuMF1L1DsKhGjLgPm05c805kRJC1jkScUVKGtOcWFAXXhGBpENwtY6zveTzsZDEk5I134/9m8Vd45sYWDH2mOnOP58qZk6Ci6eiqX21R2zVz0A5vfrvZ9UsisRlmIeyNEsBLQ3MqRHVeJsIlvAFAn90m8Y6CmlBLWnhFPcMru4OGAKEBWoGS0B1VotVO/iYW1J/3huXp7fFBGA/TVls2/Hi81QZLNqN40y0YPZYTxbueArInV3pMUJoTssQm0I9dmlKuAu8XVqV/d7GtxJwHlFkBu7RzREKQard3v51cXi9VfgSr6CLfxv2TLWWiAvuI027m9vnf8aStfFvhi+/08nEvNFsZg3QwPL52bida2/BhmMtfjUtj87OLb4e01aR6vJCQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983ed9f6-5b83-43a3-879a-08d8439209ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 16:16:18.0377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+OduFMis4VCMGFm3927D6i8tfVZ9Mga6B1LVdMJvZBFncdhrI17yMzRec9f+8swEWxEjgNzIOcLDp7V5yzsJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2402
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
Content-Type: multipart/mixed; boundary="===============1948986711=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1948986711==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44881FCB5A22742190B7E0FBF75C0MN2PR12MB4488namp_"

--_000_MN2PR12MB44881FCB5A22742190B7E0FBF75C0MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Double check for mis-merges on patches that went upstream via -fixes and -n=
ext.

Alex
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Tuesday, August 18, 2020 11:06 AM
To: Thomas Zimmermann <tzimmermann@suse.de>; Koenig, Christian <Christian.K=
oenig@amd.com>; Alex Deucher <alexdeucher@gmail.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Subject: Re: TTM/nouveau conflict in drm-misc-next

Am 17.08.20 um 08:31 schrieb Thomas Zimmermann:

Hi

Am 14.08.20 um 18:21 schrieb Koenig, Christian:




Am 14.08.2020 17:53 schrieb Alex Deucher <alexdeucher@gmail.com><mailto:ale=
xdeucher@gmail.com>:

    On Fri, Aug 14, 2020 at 11:22 AM Christian K=F6nig
    <christian.koenig@amd.com><mailto:christian.koenig@amd.com> wrote:
    >
    > Hey Thomas & Alex,
    >
    > well the TTM and Nouveau changes look good to me, but this completely
    > broke amdgpu.
    >
    > Alex any idea what is going on here?

    What's broken in amdgpu?  There shouldn't be any ttm changes in amdgpu
    for drm-next.  Those all go through drm-misc.


It's not a TTM change.

The backmerge of drm-next into drm-misc-next broke amdgpu so that even
glxgears doesn't work anymore.

But each individual merge head still works fine as far as I can say.

Any idea how to track that down?



The backmerge brought in

  Fixes: 16e6eea29d7b ("Merge tag 'amd-drm-fixes-5.9-2020-08-07' ...)

which has quite a few commit. Maybe it's in one of them.

Nope, I have just double checked that I can revert either parent of the mer=
ge and the problem disappears.

I somehow need to figure out how to cleanly revert all patches in one branc=
h one by one and then do a reverse bisect. Oh, sometimes I love my job :(

If anybody has a good idea how to do this please speak up.

Thanks,
Christian.




Best regards
Thomas




Christian.


    Alex

    >
    > Regards,
    > Christian.
    >
    > Am 12.08.20 um 21:10 schrieb Thomas Zimmermann:
    > > Hi Christian and Ben,
    > >
    > > I backmerged drm-next into drm-misc-next and had a conflict between=
 ttm
    > > and nouveau. struct ttm_mem_res got renamed to struct ttm_resource.=
 I
    > > updated nouveau to the new name, test-built, and pushed the result =
to
    > > drm-misc-next. If either of you has a minute, you may want to doubl=
e
    > > check the merge.
    > >
    > > Best regards
    > > Thomas
    > >
    >
    > _______________________________________________
    > amd-gfx mailing list
    > amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
    > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cch=
ristian.koenig%40amd.com%7Ca1aefc1ee22a4e733df908d8406a395c%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637330172275088649&amp;sdata=3DX2ZJUETwoq884X=
tg66sDudjXB%2F3s%2BgRglnh33gpU4Hc%3D&amp;reserved=3D0<https://nam11.safelin=
ks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmail=
man%2Flistinfo%2Famd-gfx&data=3D02%7C01%7CAlexander.Deucher%40amd.com%7Cd40=
23becdee744c639ae08d843885b15%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C=
637333600213437608&sdata=3DpbqERBZPwTFVObebH8KIPIxOtDYrjMu4SIaJ%2FF13cXk%3D=
&reserved=3D0>









_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D02%7C01%7CAlexander.Deucher%40amd.com%7Cd4=
023becdee744c639ae08d843885b15%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7=
C637333600213447604&sdata=3Dr8BFPhKT1KzcpVZQIy0Im4%2Bjb9S75c7doKvtH2FGjA8%3=
D&reserved=3D0>



--_000_MN2PR12MB44881FCB5A22742190B7E0FBF75C0MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Double check for mis-merges on patches that went upstream via -fixes and -n=
ext.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, August 18, 2020 11:06 AM<br>
<b>To:</b> Thomas Zimmermann &lt;tzimmermann@suse.de&gt;; Koenig, Christian=
 &lt;Christian.Koenig@amd.com&gt;; Alex Deucher &lt;alexdeucher@gmail.com&g=
t;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: TTM/nouveau conflict in drm-misc-next</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"x_moz-cite-prefix">Am 17.08.20 um 08:31 schrieb Thomas Zimmer=
mann:<br>
</div>
<blockquote type=3D"cite">
<pre class=3D"x_moz-quote-pre">Hi

Am 14.08.20 um 18:21 schrieb Koenig, Christian:
</pre>
<blockquote type=3D"cite">
<pre class=3D"x_moz-quote-pre">

Am 14.08.2020 17:53 schrieb Alex Deucher <a class=3D"x_moz-txt-link-rfc2396=
E" href=3D"mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a>:

    On Fri, Aug 14, 2020 at 11:22 AM Christian K=F6nig
    <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:christian.koenig@am=
d.com">&lt;christian.koenig@amd.com&gt;</a> wrote:
    &gt;
    &gt; Hey Thomas &amp; Alex,
    &gt;
    &gt; well the TTM and Nouveau changes look good to me, but this complet=
ely
    &gt; broke amdgpu.
    &gt;
    &gt; Alex any idea what is going on here?

    What's broken in amdgpu?&nbsp; There shouldn't be any ttm changes in am=
dgpu
    for drm-next.&nbsp; Those all go through drm-misc.


It's not a TTM change.

The backmerge of drm-next into drm-misc-next broke amdgpu so that even
glxgears doesn't work anymore.

But each individual merge head still works fine as far as I can say.

Any idea how to track that down?
</pre>
</blockquote>
<pre class=3D"x_moz-quote-pre">
The backmerge brought in

  Fixes: 16e6eea29d7b (&quot;Merge tag 'amd-drm-fixes-5.9-2020-08-07' ...)

which has quite a few commit. Maybe it's in one of them.</pre>
</blockquote>
<br>
Nope, I have just double checked that I can revert either parent of the mer=
ge and the problem disappears.<br>
<br>
I somehow need to figure out how to cleanly revert all patches in one branc=
h one by one and then do a reverse bisect. Oh, sometimes I love my job :(<b=
r>
<br>
If anybody has a good idea how to do this please speak up.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
<blockquote type=3D"cite">
<pre class=3D"x_moz-quote-pre">

Best regards
Thomas

</pre>
<blockquote type=3D"cite">
<pre class=3D"x_moz-quote-pre">
Christian.


    Alex

    &gt;
    &gt; Regards,
    &gt; Christian.
    &gt;
    &gt; Am 12.08.20 um 21:10 schrieb Thomas Zimmermann:
    &gt; &gt; Hi Christian and Ben,
    &gt; &gt;
    &gt; &gt; I backmerged drm-next into drm-misc-next and had a conflict b=
etween ttm
    &gt; &gt; and nouveau. struct ttm_mem_res got renamed to struct ttm_res=
ource. I
    &gt; &gt; updated nouveau to the new name, test-built, and pushed the r=
esult to
    &gt; &gt; drm-misc-next. If either of you has a minute, you may want to=
 double
    &gt; &gt; check the merge.
    &gt; &gt;
    &gt; &gt; Best regards
    &gt; &gt; Thomas
    &gt; &gt;
    &gt;
    &gt; _______________________________________________
    &gt; amd-gfx mailing list
    &gt; <a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lis=
ts.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
    &gt; <a class=3D"x_moz-txt-link-freetext" href=3D"https://nam11.safelin=
ks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmail=
man%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CAlexander.Deucher%40amd.com%7=
Cd4023becdee744c639ae08d843885b15%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C=
0%7C637333600213437608&amp;sdata=3DpbqERBZPwTFVObebH8KIPIxOtDYrjMu4SIaJ%2FF=
13cXk%3D&amp;reserved=3D0" originalsrc=3D"https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx" shash=3D"xLe14aGwWJOJT9nppIbAA/DNx4rObDXp7SC2pJZhOGP=
vq60R5rdvfAfYFetOOz1lZwTP5eomqbUKpbRQRtf/UKh3AYVBq/Uyd4fqhUok76UDTMuH2XKIrZ=
6cz7+MT8zb1vS9z+9O/9Gtkr6gPVnHrQkkfPboxmHsZC2nmMZ/ILs=3D">https://nam11.saf=
elinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2F=
mailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cchristian.koenig%40am=
d.com%7Ca1aefc1ee22a4e733df908d8406a395c%7C3dd8961fe4884e608e11a82d994e183d=
%7C0%7C0%7C637330172275088649&amp;amp;sdata=3DX2ZJUETwoq884Xtg66sDudjXB%2F3=
s%2BgRglnh33gpU4Hc%3D&amp;amp;reserved=3D0</a>


</pre>
</blockquote>
<pre class=3D"x_moz-quote-pre">
</pre>
<br>
<fieldset class=3D"x_mimeAttachmentHeader"></fieldset>
<pre class=3D"x_moz-quote-pre">____________________________________________=
___
amd-gfx mailing list
<a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lists.freede=
sktop.org">amd-gfx@lists.freedesktop.org</a>
<a class=3D"x_moz-txt-link-freetext" href=3D"https://nam11.safelinks.protec=
tion.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flis=
tinfo%2Famd-gfx&amp;data=3D02%7C01%7CAlexander.Deucher%40amd.com%7Cd4023bec=
dee744c639ae08d843885b15%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63733=
3600213447604&amp;sdata=3Dr8BFPhKT1KzcpVZQIy0Im4%2Bjb9S75c7doKvtH2FGjA8%3D&=
amp;reserved=3D0" originalsrc=3D"https://lists.freedesktop.org/mailman/list=
info/amd-gfx" shash=3D"Wwkwr+CK7NfcXLMTNUW/gYRiKOckfoc29e0lxKXrsBa6WpgE8Rp5=
kRBA1U23+dswS5OHeJuCSe6k/nrMwx2sFp1qX3hfF5YxhtfikcsI9hMtoVYxTcdfwaHCSwyYniu=
nzlQgvLkL243FjgzTLxKTzwOP43H/EgO9I0fyFKdUSeY=3D">https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx</a>
</pre>
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB44881FCB5A22742190B7E0FBF75C0MN2PR12MB4488namp_--

--===============1948986711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1948986711==--
