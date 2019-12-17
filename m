Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12820C2D0CD
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 20:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69D5206D7
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 20:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J4Kx/Tho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69D5206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 511236E117;
	Tue, 17 Dec 2019 20:12:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC3E96E117
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 20:12:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro3kcbYAAMhalV12nquYFLKDsK3LJDYruX0NGHFXfnaoEBEatywta5zyRDJVSAwmXaXhQ6caEbI8jwMKms6lBCCf9Y+BKfC0vAXXNdE2nYagqfC5UaH2nzCAbZXleuslWEoOp5z3Dvze+rPlf+wlvqDnPGNbLA30d1Rm4MtgO6TeM3WDyyAYUnDszK5r2EtJPcpSp+QIvX2jo0ryVABM3GAr+o/3wSpjYhrtSWFHIIxGD/r10yh53ZmRSXU9xv0EGyDBVQKxIYEsHCMgH3Zg4qfvd+txQLD+pskoUxo71vO6Tg6X7lP4Zc9gA+TGRTdpPbgOIBkBtDEc5f/I1Bl8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8PanVUvFv7mtTbf52FnmuwgLnYg2y3fN7YrXsPk/mM=;
 b=MfMws7OmRpr6JxHQx8XJt7EBnK80HqVuVOajRea1OBLQ0n58YlXA3nCxzsjnfPyuIsrJa/LEr2znN+iJiLTy9Gd3kA39DEafMx3PEs1oE3TiQn67csDKu+vEZ+RqiYBRCpirDoGCwiAzkKkQtaQQbrVK7DLSWi0m0Jhj8C2D1MsxzHmSwC6R8phplD2LNrzjh/FkCoFvpQ98VH1G5/1B648ibCnBKXyiTcVHmvnwEaRiWx2bqLRV09k9DT/EMSz2kzZGiiiYdC7fOxiq31fnLiWL1wfVqjxj/Ihon3XuOK5afiM0DPTvjzPo1BUT8ePeQ/697WJHQKG3c8dZLAgMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8PanVUvFv7mtTbf52FnmuwgLnYg2y3fN7YrXsPk/mM=;
 b=J4Kx/ThoU4+rsr/iGCrRd1F2mWqi7u0TYIsRnMBDNVmdyaEQVqCwfkzQgG471rGfFWANBpUWDVeItUN19YnN0EGHFE52J0EDt+yYuZbNe1S43XzRK2wVBNwdllNXmxFP0bkMfTpo9gfJDLxD0G95+AhcqMzK3HJM4LgCkfyJzAE=
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1598.namprd12.prod.outlook.com (10.172.50.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 20:12:24 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 20:12:24 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, Alex
 Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/5] drm/amdgpu/smu: add metrics table lock for navi
Thread-Topic: [PATCH 3/5] drm/amdgpu/smu: add metrics table lock for navi
Thread-Index: AQHVtOoAnVlqN1UQn0a7ifeVWH3MAae+rY+AgAAVJ0E=
Date: Tue, 17 Dec 2019 20:12:24 +0000
Message-ID: <MWHPR12MB135854C67A678F3C67B8054AF7500@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191217145505.1319348-1-alexander.deucher@amd.com>
 <20191217145505.1319348-3-alexander.deucher@amd.com>,
 <7ba97448-11fc-c506-1750-18b6440ff971@amd.com>
In-Reply-To: <7ba97448-11fc-c506-1750-18b6440ff971@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-17T20:12:23.874Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5312256b-3cb3-4d30-4e7f-08d7832d6e84
x-ms-traffictypediagnostic: MWHPR12MB1598:|MWHPR12MB1598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1598E0FE88BC1AE94C723C64F7500@MWHPR12MB1598.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(189003)(199004)(66446008)(76116006)(66556008)(66946007)(5660300002)(66476007)(64756008)(71200400001)(966005)(186003)(8676002)(9686003)(33656002)(19627405001)(86362001)(52536014)(316002)(8936002)(7696005)(81156014)(81166006)(2906002)(478600001)(55016002)(6506007)(110136005)(26005)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1598;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4UwV31ozngXuSUSrufgf/kaMcI7yzDo9TFEW60i0VbPukk2wQx8M6TA4+tjAkV9Z0Ra7YfLqkMBLjDp6DDbCwLSFuhTZXfaj4spk0ViVewJbywtwdE3Ke7nV8B98cpoVXBO+a+kex4YY/o27J5HGGOFu06PO3TlEjE4seqqf4d5dbybmHesf+heX5xJRLTvDXodK7sZ/eYvNCbpFXED5OuF7D2EkDjN00H/vgr4GoSNoj/JB80l2NCWdDQJdYXEoT41NkMBOVY64zlSWeFOGON+mCIqGE6XmUPm3zgjK+Xyt3h+lQkSB3m6VgJ0kxLLZZQKNnS/qrMgrphY6CUTXvydjQDwSDfJmRDEVvknlrJ6D9K6lUFv4PKdaYTwU1JoJHMDg7GtBhEbEdLVOsebNT7ZN6tBmRgfb8fIWT7SWwOfCIXFUcTYGNM0Fo+7MYxeAv9LoEDoUdacd8u9Y/ET7IDFLZnJ4wUMpn244oS7bAu0=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5312256b-3cb3-4d30-4e7f-08d7832d6e84
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 20:12:24.4727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IenzIWZI9iYFG4HeWKyglhQJoqAqMMgro9cSdEac+l7bYaknQ8e5NlbGiy1SLXiKtNAs19AYx2Au1sXoIvtUiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1598
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
Content-Type: multipart/mixed; boundary="===============1148441500=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1148441500==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB135854C67A678F3C67B8054AF7500MWHPR12MB1358namp_"

--_000_MWHPR12MB135854C67A678F3C67B8054AF7500MWHPR12MB1358namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

yeah, they need some fixes.

Alex
________________________________
From: Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>
Sent: Tuesday, December 17, 2019 1:56 PM
To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 3/5] drm/amdgpu/smu: add metrics table lock for navi

Hi Alex,

Isn't this patch missing something like this:

    pr_info("Failed to export SMU metrics table!\n");
+   mutex_unlock(&smu->metrics_lock);
    return ret;

to release the lock in case of error?

Regards,
Pierre-Eric


On 17/12/2019 15:55, Alex Deucher wrote:
> To protect access to the metrics table.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/900
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm=
/amd/powerplay/navi10_ppt.c
> index 15403b7979d6..102fddda925b 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -564,6 +564,7 @@ static int navi10_get_metrics_table(struct smu_contex=
t *smu,
>        struct smu_table_context *smu_table=3D &smu->smu_table;
>        int ret =3D 0;
>
> +     mutex_lock(&smu->metrics_lock);
>        if (!smu_table->metrics_time || time_after(jiffies, smu_table->met=
rics_time + msecs_to_jiffies(100))) {
>                ret =3D smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
>                                (void *)smu_table->metrics_table, false);
> @@ -575,6 +576,7 @@ static int navi10_get_metrics_table(struct smu_contex=
t *smu,
>        }
>
>        memcpy(metrics_table, smu_table->metrics_table, sizeof(SmuMetrics_=
t));
> +     mutex_unlock(&smu->metrics_lock);
>
>        return ret;
>  }
>

--_000_MWHPR12MB135854C67A678F3C67B8054AF7500MWHPR12MB1358namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
yeah, they need some fixes.</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Pelloux-prayer, Pierr=
e-eric &lt;Pierre-eric.Pelloux-prayer@amd.com&gt;<br>
<b>Sent:</b> Tuesday, December 17, 2019 1:56 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 3/5] drm/amdgpu/smu: add metrics table lock for =
navi</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Alex,<br>
<br>
Isn't this patch missing something like this:<br>
<br>
&nbsp;&nbsp;&nbsp; pr_info(&quot;Failed to export SMU metrics table!\n&quot=
;);<br>
&#43;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;metrics_lock);<br>
&nbsp;&nbsp;&nbsp; return ret;<br>
<br>
to release the lock in case of error?<br>
<br>
Regards,<br>
Pierre-Eric <br>
<br>
<br>
On 17/12/2019 15:55, Alex Deucher wrote:<br>
&gt; To protect access to the metrics table.<br>
&gt; <br>
&gt; Bug: <a href=3D"https://gitlab.freedesktop.org/drm/amd/issues/900">htt=
ps://gitlab.freedesktop.org/drm/amd/issues/900</a><br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 2 &#43;&#43;<br>
&gt;&nbsp; 1 file changed, 2 insertions(&#43;)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/=
drm/amd/powerplay/navi10_ppt.c<br>
&gt; index 15403b7979d6..102fddda925b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; @@ -564,6 &#43;564,7 @@ static int navi10_get_metrics_table(struct smu=
_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *sm=
u_table=3D &amp;smu-&gt;smu_table;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;metrics_lock);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;metrics_t=
ime || time_after(jiffies, smu_table-&gt;metrics_time &#43; msecs_to_jiffie=
s(100))) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)smu_table-&gt;metrics_tabl=
e, false);<br>
&gt; @@ -575,6 &#43;576,7 @@ static int navi10_get_metrics_table(struct smu=
_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(metrics_table, smu_ta=
ble-&gt;metrics_table, sizeof(SmuMetrics_t));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;metrics_lock);=
<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR12MB135854C67A678F3C67B8054AF7500MWHPR12MB1358namp_--

--===============1148441500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1148441500==--
