Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56CDC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 16:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F86B20707
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 16:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QkM+HFOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F86B20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 464696EA03;
	Tue, 23 Jun 2020 16:40:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58AA16EA03
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 16:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjW1wSNOWiDstdMdcv/iu+zWWFaI9FJl/PZpi/lNRU2q6xMimTAUrGqj1WhSKFSgJuaI+3EvOf5ZGzjifSOTWjulTgaBik+QNfeSkohkvnVW8k6/+HQ0aLd1aZpZY7IEFi+hqExRWvvbWKYhStUbzqqHcRHijcuRYv4BHuG0Ovlk9ap9ynFks8Dj2B5gV0y3lS0FhXlvjIHvXW1PDc4rCsICc8/IL0Ujyzv3x8zPUuFuXCFmY5+gsodRpA+K8hIogeWKoqxssVQ9bZ+0ATfBFsaguN6WMGc0Ua6v+uukYiBsZpKlJfAnAQwoHtp3ry9EllTbGR/HOrD63+TBFENtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po4udfZJeTkUVylkDVY7pxo3lxA5sySeeIkSAmQtVnE=;
 b=Xi2yllkh99q4oR9522PinxaUwq+rrNOed4+2dAHxWViDxSqzp9hIQJG6J7xanLGmtKskrlhaoAEe4XW1MydMOhhAE6WaHrzrfUbYr/65YzjOr5vyU64zsiw1axAY9Ga/nXKgQJjHOTxQvC8MC239/GmKUUEkCN7kCvdYSUPyG0PVvR/pA9XIiWKRxlvMGnOYGpVgNg7/Lxd59NEfUHOlTedmEnjZJJqmIk9zza6fw4cnWMeABvbri5VHxEujhLSPmWSEYhqTMyG7QtKhNSiCTCtIx810Z7IjtAHbLuVaP19p0fUJcV2UWNswr0Ns5rusFZNIt5wsB9w2Uk9GlTdRbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po4udfZJeTkUVylkDVY7pxo3lxA5sySeeIkSAmQtVnE=;
 b=QkM+HFOvfELINSe+q20Zk+SzPlagslFjraceWFCgw8axDomOQNMcELZaEwsgX0yoLiJiY1tnWCVv6/3MXjZSFO2gKdhLPuNQhFyvV2rM3M+UDUtaX9oSdWn1nRC/8E6DpEbar5rk1BZVNrC4JE0e8gH/SSdx/23Ne1NY9Go4Ygg=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Tue, 23 Jun
 2020 16:40:28 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%5]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 16:40:28 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amd/powerplay: Fix DCEFCLK related compilation
 error for arcturus
Thread-Topic: [PATCH 1/1] drm/amd/powerplay: Fix DCEFCLK related compilation
 error for arcturus
Thread-Index: AQHWSXcUXKbR3qEDok6qRI2miYvqN6jmXRqAgAAJ3UY=
Date: Tue, 23 Jun 2020 16:40:27 +0000
Message-ID: <MN2PR12MB44887C5F76DD8E56AC0565BAF7940@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200623155929.2547-1-nirmoy.das@amd.com>,
 <7cec44d8-4780-4a2b-7ea4-8fdbae634e49@amd.com>
In-Reply-To: <7cec44d8-4780-4a2b-7ea4-8fdbae634e49@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-23T16:40:27.384Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.51.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49902929-35a3-4487-f174-08d8179422e1
x-ms-traffictypediagnostic: MN2PR12MB4501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4501459132060DCBF1B8326BF7940@MN2PR12MB4501.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YtHNrXordnbDWFfxiP49MJYbEpgGprvmhKw/t3K+oUoQN1DiIhMTQqHLjLLgdNjtv+iK0ZObjaKWu9hCKFzLIUwZFAx28APY4Ee442nRHs2wZ0WGZg8PAxay/qrqP21yegHWJ4QFcf+0i5k5KZH4IAHF6DFxN1apHX5fa/ciUY0RqOk1q5Mofc3C8qUUXshg3ReYJ+2/i7ZMNizj2R9pBtU1elQLA0MK9A0ODmNXPJMsekRTUMQOkwsG7beTpRwqQEW4DLWm5ce0Lk1TXhbLOSg0DPr32guJiIhe97daXYyuwaWHbJVdi6vjiKtiBktN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(8936002)(53546011)(6506007)(26005)(2906002)(186003)(110136005)(83380400001)(7696005)(9686003)(8676002)(478600001)(55016002)(316002)(52536014)(71200400001)(33656002)(19627405001)(86362001)(66946007)(76116006)(66446008)(5660300002)(66556008)(64756008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 8WODgYsyN0QoylR7yXcPIhNGAihzGsCttP3VRIYnMfcOTKnmL9LuEXs+xqBVIScZy2kY5cf5L8B85quqoOGmBbP0m52kn1A5czAYOHjwpAsDxox0icBvqG5r6Qa5O/TQE6NaOKcJJbysgLsNEhUZlLrMpWHHxKWRpMS18J7kbE0CV6joBLgIXZB+xhMzLPt12lEbtreBqpjUmInqNgJlikpgaKT+VHt32fe23KTGNy11FjSst1yqMhN+0Xk/nKP83ZaIcme+xLXneofGTBvHUEQLcR30OyLDmGwRTSvPJe09mW8rMk2jgRLtOjMBM67iMUUm7HyoJzjUaSNHFYMPBKhggenEiurG/cKmWcY+UhiyAvp7lLa4m1mblq8fvhSA9DDXtdV6ku2D4WXVp6bHlF2LKWIg+Hlcf71e2ZUKiulh4tyel3KpcBxICaaY0EWcCPkxiohlqrp9CUQy7denqwQinFKnHOvFFOvKfiH/QMjHrwdIrUVAVE+vbGWVfiF0
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49902929-35a3-4487-f174-08d8179422e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 16:40:27.9551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3fPz0GxTOHwIf4ethE2SU68cNeHz7hwgTE1u/9+JpURs8OUUissm6JK2tHAV137G79LMGnQJ+LU4AXRMYTsymw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
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
Content-Type: multipart/mixed; boundary="===============0970288948=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0970288948==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44887C5F76DD8E56AC0565BAF7940MN2PR12MB4488namp_"

--_000_MN2PR12MB44887C5F76DD8E56AC0565BAF7940MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

No problem.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Das, Nirmoy <Nirmoy.Das@amd.com>
Sent: Tuesday, June 23, 2020 12:04 PM
To: Nirmoy Das <nirmoy.aiemd@gmail.com>; amd-gfx@lists.freedesktop.org <amd=
-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Das, Nirmoy <Nirmoy.Das=
@amd.com>
Subject: Re: [PATCH 1/1] drm/amd/powerplay: Fix DCEFCLK related compilation=
 error for arcturus


On 6/23/20 5:59 PM, Nirmoy Das wrote:
> arcturus doesn't support DCEFCLK
>
> Fixes: c67c791cd87d (drm/amd/powerplay: return current DCEFCLK on sysfs r=
ead)


Hi Alex,


Can you please squash this with c67c791cd87d (drm/amd/powerplay: return
current DCEFCLK on sysfs read)

I was bit too confident that arcturus changes would just work.


Regards,

Nirmoy


>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/d=
rm/amd/powerplay/arcturus_ppt.c
> index daeae14fd380..d93f8a43a96f 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -962,9 +962,6 @@ static int arcturus_get_smu_metrics_data(struct smu_c=
ontext *smu,
>        case METRICS_CURR_FCLK:
>                *value =3D metrics->CurrClock[PPCLK_FCLK];
>                break;
> -     case METRICS_CURR_DCEFCLK:
> -             *value =3D metrics->CurrClock[PPCLK_DCEFCLK];
> -             break;
>        case METRICS_AVERAGE_GFXCLK:
>                *value =3D metrics->AverageGfxclkFrequency;
>                break;

--_000_MN2PR12MB44887C5F76DD8E56AC0565BAF7940MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
No problem.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Das, Nirmoy &lt;Nirmo=
y.Das@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 23, 2020 12:04 PM<br>
<b>To:</b> Nirmoy Das &lt;nirmoy.aiemd@gmail.com&gt;; amd-gfx@lists.freedes=
ktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Das, Nirmo=
y &lt;Nirmoy.Das@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/1] drm/amd/powerplay: Fix DCEFCLK related comp=
ilation error for arcturus</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
On 6/23/20 5:59 PM, Nirmoy Das wrote:<br>
&gt; arcturus doesn't support DCEFCLK<br>
&gt;<br>
&gt; Fixes: c67c791cd87d (drm/amd/powerplay: return current DCEFCLK on sysf=
s read)<br>
<br>
<br>
Hi Alex,<br>
<br>
<br>
Can you please squash this with c67c791cd87d (drm/amd/powerplay: return <br=
>
current DCEFCLK on sysfs read)<br>
<br>
I was bit too confident that arcturus changes would just work.<br>
<br>
<br>
Regards,<br>
<br>
Nirmoy<br>
<br>
<br>
&gt;<br>
&gt; Signed-off-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 3 ---<br>
&gt;&nbsp;&nbsp; 1 file changed, 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gp=
u/drm/amd/powerplay/arcturus_ppt.c<br>
&gt; index daeae14fd380..d93f8a43a96f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&gt; @@ -962,9 &#43;962,6 @@ static int arcturus_get_smu_metrics_data(struc=
t smu_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_CURR_FCLK:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *value =3D metrics-&gt;CurrClock[PPCLK_FCLK];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_CURR_DCEFCLK:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *value =3D metrics-&gt;CurrClock[PPCLK_DCEFCLK];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_AVERAGE_GFXCLK:=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *value =3D metrics-&gt;AverageGfxclkFrequency;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44887C5F76DD8E56AC0565BAF7940MN2PR12MB4488namp_--

--===============0970288948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0970288948==--
