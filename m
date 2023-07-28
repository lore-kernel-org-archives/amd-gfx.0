Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DEDC0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 02:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C15710E638;
	Fri, 28 Jul 2023 02:21:51 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4BE10E63D
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 02:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9aUF2M4ugoU3VjvnJzWT571lorPswObdYu7GKElSYeb8l71NmDW8IOZft3p0EsdI57l6DxDp9CpfbhzUVy5hHXt9Cpg/VdcH9a7eFaulNKJR6/+GORwhknf8n6+PF7ZviUxxgp2jOzhZFPthXxbNAnxaUAS1doCkY+5hCkA0ZTl5LlZOq2haBSjqwrdSYn5eQz9xO7GnOGTwfZtsTD+PIUz6HF5hoShXNHM0qAgt6AEU0vNOz3KR+eSjdTdusD2UL2QD3l+k0kdT3MMtKrpNr5JUaK/LxmhnaZ8zggf8wiIRiDD76LdnC/bZ0xVMBSJxu7d1/bLx7Savl67Fi+8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fge0LBUFOYxOgUARJZIfJaRjYjzs2jf5GHohNjdV8Xo=;
 b=f/zcQ/UMgesOaBwLDww1FixeYa0/8jsJpiYhdZMhUeb/CiWgtT+PdLHjeuYlzmMMW08fRHCbNAdD66PLD7o8WnyuewfxwKx4uKFG5weme7hsHyWldXjOGQxsqWWIqM9n5CMYWejHoedjZVMTJNtRo6+sdV3sUKpzDSB10rYynLfA3T2gogfH+3I+ha6CxiIRMN6yqzPpB5HbO6ddpvUhmzVFrtXxTXQoV3h8w6wFG28Vp3vApI9GQQOJ/KGKVo/pAMw5CMdtLH0XQ0QP5eq7SwpPdJo/2ERPoeTY8U6VK7Rm/6azU3I16c2vxc8clrEp8Jr9ctwCz/oEQSznIC4hsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fge0LBUFOYxOgUARJZIfJaRjYjzs2jf5GHohNjdV8Xo=;
 b=CZiSgyGJETe1aX2Wqe0wRHovztxNA9HatRfkuhKLO4+z0qUfKqPeotqCrymDwaoDWMZJ+AhRoexqH1qBTBXAmpd0s357OCe8UuDB4ILasoHygvxh9FyF90PCoRYvaTFdxt1oPl/0ll7qqIqc6gM7WdUNZfL1GjoGj/zLDRjiEEM=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 02:21:45 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::151a:deaf:fc88:ab6b]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::151a:deaf:fc88:ab6b%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 02:21:45 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: skip the RLC stop when S0i3 suspend for SMU
 v13.0.4/11
Thread-Topic: [PATCH] drm/amd/pm: skip the RLC stop when S0i3 suspend for SMU
 v13.0.4/11
Thread-Index: AQHZwO/cPE+4GwfmvEWxlR2Jigotna/OX9MAgAASFu0=
Date: Fri, 28 Jul 2023 02:21:44 +0000
Message-ID: <BY5PR12MB3873A8ADD1B0CE858527D041F606A@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20230728010504.532158-1-tim.huang@amd.com>
 <e751765e-9ec2-83e0-90f6-c7d96943dac2@amd.com>
In-Reply-To: <e751765e-9ec2-83e0-90f6-c7d96943dac2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-28T02:21:40.224Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|BL1PR12MB5045:EE_
x-ms-office365-filtering-correlation-id: e0d2938a-bd10-45e0-186c-08db8f116387
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BGkh9nr+A/jHznP3Red+NMY1hymCGVIIz5QPeqbHbglZnwW7et3GK1DW4pkqtywuU1ZxD3Mw+yQsUORLebhFqNz+A35E2TzhhWuAXlk23z4eM7TgDNPfypni6H+i+4+JAdhN8y0GIYmhSsZnmZcIUfq5AnvW08PjkMrWghJwbNIrGFhSycM23RlOhmz3QN1X08MzVF+Ynl9xU5Ynk5QTvUxrQ3Q7CNJmSCmcXDji7eltlHApDT/cO3wBiN6s5tUtH80P8vPJwxjH1Uy9P49pqVb2lO7+bPFUYCbVuHs8qsboEvEPUzpwq+bnakDfQhIhP/pPWbnij5gA9e3ETTBs9Q7TcTvQIjZyeIP5OT4YTyUv2eaiN3y36OQt2NQ5FkfezDxw3StkAgAbkFc0czWvzW4IPXyhFcacXL3cCyHqTK7wfVJ1YvrZ+2kSTLb1z2mM0MbY+/LeSSJsn/w+McFmNio2EGSpRfusTDvcmeR6g0evql2goxjehxl7gGO4yc+SeCEnesaY0/4yK/MuCEV3dQZqPjO/iZ8UaHwHxOYnEEDHcEJ6WGfmnECPR4bIlyBe7FV1DuIGGAezrbLwsTLeh4OEBsvx13g92kjHc5fS7SI6hIjfF683nZBNQ0vbRci5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(15650500001)(2906002)(41300700001)(316002)(52536014)(8676002)(33656002)(8936002)(5660300002)(86362001)(55016003)(38070700005)(9686003)(53546011)(6506007)(26005)(478600001)(7696005)(71200400001)(83380400001)(186003)(19627405001)(38100700002)(4326008)(66476007)(66556008)(76116006)(66446008)(64756008)(91956017)(110136005)(122000001)(66946007)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RrmZqOjYyx0O81h9NO75pVx8gwrZAewk17JMC1zspSunIxVBqeWCtO1viD?=
 =?iso-8859-1?Q?Poip44/4oN1vj4FZ4Xkd4fuAi58oNWtFkAU1hgiRUL4s7ulUP2so0Vu9BW?=
 =?iso-8859-1?Q?hE0D3Dw+qIMChZmGFjZVJqZIEthBx5YCIVks/xMx56SsrZq52Qn5C1m2g1?=
 =?iso-8859-1?Q?l2TdVvR34zdwZ+qJD7eiEWPFt1b2JhtEvbjoyi6SPucBisKI6BZMjzsZN4?=
 =?iso-8859-1?Q?rbOcIE3NNE1F2ypSDgTvvIs7MrzJ/e4Mo2COWmWaekklMeJRVuOADn4cgj?=
 =?iso-8859-1?Q?AEHBEkTsuMNG/AkTQ+RXNaoiivvS7F+jH6Duwk5Fw9naD2JNrrgq+gOJ5T?=
 =?iso-8859-1?Q?aZICKa2Hz2I3AhyouF0fq7j4fR+8lQ68cbKkSjChUZhIgrG94yFZeDIpWj?=
 =?iso-8859-1?Q?o3sVgVSothxY36V6d97mSKBjFxmB0E0GxscuzzC8Ap5OtlHVmg32HqL2S8?=
 =?iso-8859-1?Q?4EoL1XS9p9kI6BUWugHUlAYcvQcTkJgqY869xtQFvDOWaxXs9mabig/BcB?=
 =?iso-8859-1?Q?+TFJlUNMhLWi3ymvNwu7Os2rvFjy6nDKiMYLKXnMZO6UjrzyqS+h+bkIGP?=
 =?iso-8859-1?Q?q829OB5sP/aKKYzmwp2oFapN96sf9mUxO3OvKJBj1tajwDGHurAB0P5FlU?=
 =?iso-8859-1?Q?l4+3sVCieIg5S1Sjnl9/Ye5OznBkzJ/t+dNcSSBi5d1qOGzDnnZ/34j6vE?=
 =?iso-8859-1?Q?MvRXkBg2uMawabWrg2ZpB2SfheTicxChg/1/P7JUmoW0VoofG9woDjgkq3?=
 =?iso-8859-1?Q?7KHpbnsZCNRMsD31CBxoYorsOnRmtF1eW9Ef4Hyn6HGUrLYfcIkWjk8j+D?=
 =?iso-8859-1?Q?9EkZ2Z/aeanus6NanqEt1Nu8ZNdSEjd+LiXlhAGOVtTHgwVYXEUf6Bro/7?=
 =?iso-8859-1?Q?W1HjNd19jhcGt7t75s0T3rYi+vAI3oDcJdtslUb3vZspg9AvBk5JHqv4un?=
 =?iso-8859-1?Q?NI4lJD5qA9ghnTi4WoYBYBXV64Xok6lwcwNc1350HRjguQrkyX+gFNt6x7?=
 =?iso-8859-1?Q?IqYacoqwfTtDMm3ws0T5eJHj0F5aWk72fgVANUr6eM/6tRgK5/3FWcmwai?=
 =?iso-8859-1?Q?9DMqRt+6sgOq3MWUfOCy8xyPbyoNYNDiKL46iTwTEi8+m8DvuEHiZNKWN0?=
 =?iso-8859-1?Q?5/FPGmHAb5XO4IGSzQoBdiQjSLVHHkwMoXDdJ8KQiAmQi0vDfddknO0ODd?=
 =?iso-8859-1?Q?OQhW6NXh0h1exa7MlGobt1PtwYAaY8tM7Uq293SzkvKGnkqe+RFZXo5g5p?=
 =?iso-8859-1?Q?rUpvu7k7mWxgzmBdfm+dA2FY8QMG8v0QO3gvLDMaY68PePVncqAnluY9PY?=
 =?iso-8859-1?Q?B3CHkBQXST/T/teeEWRK+TZ0aNZxLKtMaFs917ORKSmBczCU/Z7KLDa9Xi?=
 =?iso-8859-1?Q?QoReHXx4J0govP5Jvxcfv3vmpbKF8oqwFLiDVfG8vkRZ7rbJ6fDkZpCQW2?=
 =?iso-8859-1?Q?m3Rdm95i6SyFAwFqXUX53iP7FdodIaR/LAyiHupI0p6p5vVVm+x46qSE1Y?=
 =?iso-8859-1?Q?yIMFlr1F/DUwxxm1ljHG42F6YB9VatY6yGoKjtPy4l50kR23axhulKdSoO?=
 =?iso-8859-1?Q?ugQx/F1BikBS6Wq4Z//1zYo8fWzJNkKKYqmBOyhn9IicMKouQEyQ7cPloT?=
 =?iso-8859-1?Q?eiDNFPXQOrSU0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB3873A8ADD1B0CE858527D041F606ABY5PR12MB3873namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d2938a-bd10-45e0-186c-08db8f116387
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 02:21:44.9650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkGX+hYTE9Lag2Xb7qpJ9LagyAVkRDzOGB6pM8sv+n+W6vgPZplfiX8u4F2nD3/JP65i+YJl90mmDrb8P6+P8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BY5PR12MB3873A8ADD1B0CE858527D041F606ABY5PR12MB3873namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Friday, July 28, 2023 9:14 AM
To: Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>
Subject: Re: [PATCH] drm/amd/pm: skip the RLC stop when S0i3 suspend for SM=
U v13.0.4/11

On 7/27/23 20:05, Tim Huang wrote:
> From: Tim Huang <Tim.Huang@amd.com>
>
> For SMU v13.0.4/11, driver does not need to stop RLC for S0i3,
> the firmwares will handle that properly.
> Conceptually I'm aligned to this.
> But, just to confirm, have you already run some testing with this
> with current GPU F/W, BIOS and either 6.1.y, 6.4.y or ASDN?

> I checked with this on my side and saw success but I'm fearful
> that it introduces some of the fence expiration problems we
> had in the past and I'm just not seeing them for some reason.

Yes, verified based on current BIOS and latest drm-next kernel and the work=
ing FWs as the latest FWs
may have some new issues.

For this patch, it is asked by the FW guys, driver should not touch RLC_CNT=
L in S0i3, let RLC FW to do that. If driver programs RLC_CNTL to halt RLC, =
RLC cannot go GFXOFF exit sequence.

The fence expiration should be still there by the delayed GFXOFF , but this=
 patch should be useful to help debug it as it avoids the system hang when =
the issue happens.

Best Regards,
Tim

>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index ce41a8309582..222af2fae745 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1581,9 +1581,9 @@ static int smu_disable_dpms(struct smu_context *smu=
)
>
>        /*
>         * For SMU 13.0.4/11, PMFW will handle the features disablement pr=
operly
> -      * for gpu reset case. Driver involvement is unnecessary.
> +      * for gpu reset and S0i3 cases. Driver involvement is unnecessary.
>         */
> -     if (amdgpu_in_reset(adev)) {
> +     if (amdgpu_in_reset(adev) || adev->in_s0ix) {
>                switch (adev->ip_versions[MP1_HWIP][0]) {
>                case IP_VERSION(13, 0, 4):
>                case IP_VERSION(13, 0, 11):


--_000_BY5PR12MB3873A8ADD1B0CE858527D041F606ABY5PR12MB3873namp_
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
<br>
</div>
<div id=3D"divRplyFwdMsg" dir=3D"ltr" class=3D"elementToProof"><font face=
=3D"Calibri, sans-serif" style=3D"font-size: 11pt; color: rgb(0, 0, 0);"><b=
>From:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
</font></div>
<div dir=3D"ltr"><font face=3D"Calibri, sans-serif" style=3D"font-size: 11p=
t; color: rgb(0, 0, 0);"><b>Sent:</b> Friday, July 28, 2023 9:14 AM<br>
<b>To:</b> Huang, Tim &lt;Tim.Huang@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/pm: skip the RLC stop when S0i3 suspend=
 for SMU v13.0.4/11</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText elementToProof">On 7/27/23 20:05, Tim Huang wrote:<=
br>
&gt; From: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
&gt;<br>
&gt; For SMU v13.0.4/11, driver does not need to stop RLC for S0i3,<br>
&gt; the firmwares will handle that properly.<br>
&gt;&nbsp;Conceptually I'm aligned to this.<br>
</div>
<div class=3D"PlainText elementToProof">&gt;&nbsp;But, just to confirm, hav=
e you already run some testing with this<br>
</div>
<div class=3D"PlainText elementToProof"><span style=3D"font-family: &quot;S=
egoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, Bli=
nkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; display: i=
nline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255)=
;" class=3D"ContentPasted6">&gt;&nbsp;</span>with
 current GPU F/W, BIOS and either 6.1.y, 6.4.y or ASDN?<br>
<br>
<span style=3D"font-family: &quot;Segoe UI Web (West European)&quot;, &quot=
;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica=
 Neue&quot;, sans-serif; display: inline !important; color: rgb(0, 0, 0); b=
ackground-color: rgb(255, 255, 255);" class=3D"ContentPasted3">&gt;&nbsp;</=
span>I
 checked with this on my side and saw success but I'm fearful<br>
<span style=3D"font-family: &quot;Segoe UI Web (West European)&quot;, &quot=
;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica=
 Neue&quot;, sans-serif; display: inline !important; color: rgb(0, 0, 0); b=
ackground-color: rgb(255, 255, 255);" class=3D"ContentPasted4">&gt;&nbsp;</=
span>that
 it introduces some of the fence expiration problems we<br>
<span style=3D"font-family: &quot;Segoe UI Web (West European)&quot;, &quot=
;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica=
 Neue&quot;, sans-serif; display: inline !important; color: rgb(0, 0, 0); b=
ackground-color: rgb(255, 255, 255);" class=3D"ContentPasted5">&gt;&nbsp;</=
span>had
 in the past and I'm just not seeing them for some reason.</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof"><span class=3D"PlainText" style=3D"=
font-family: &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;=
, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sa=
ns-serif; margin: 0px; color: rgb(0, 0, 0); background-color: rgb(255, 255,=
 255);"><span class=3D"PlainText ContentPasted0" style=3D"margin: 0px; back=
ground-color: rgb(255, 255, 255);">Yes,
 verified based on current BIOS and latest drm-next kernel and the working =
FWs as the latest FWs&nbsp;</span></span>
<div class=3D"PlainText" style=3D"font-family: &quot;Segoe UI Web (West Eur=
opean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Robo=
to, &quot;Helvetica Neue&quot;, sans-serif; margin: 0px; color: rgb(0, 0, 0=
); background-color: rgb(255, 255, 255);">
<span class=3D"PlainText" style=3D"margin: 0px; background-color: rgb(255, =
255, 255);"><span class=3D"ContentPasted0" style=3D"margin:0px">may have so=
me new issues.&nbsp;</span></span></div>
<div class=3D"PlainText ContentPasted0" style=3D"font-family: &quot;Segoe U=
I Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; margin: 0px; col=
or: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
&nbsp;</div>
<div class=3D"PlainText ContentPasted0" style=3D"font-family: &quot;Segoe U=
I Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; margin: 0px; col=
or: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
For this patch, it is asked by the FW guys,&nbsp;<span style=3D"margin:0px"=
><span class=3D"ui-provider fy b c d e f g h i j k l m n o p q r s t u v w =
x y z ab ac ae af ag ah ai aj ak ContentPasted1 ContentPasted0" dir=3D"ltr"=
 style=3D"margin:0px">driver should not touch
 RLC_CNTL in S0i3, let RLC FW to do that. If driver programs RLC_CNTL to ha=
lt RLC, RLC cannot go GFXOFF exit sequence.&nbsp;</span></span></div>
<div class=3D"PlainText" style=3D"font-family: &quot;Segoe UI Web (West Eur=
opean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Robo=
to, &quot;Helvetica Neue&quot;, sans-serif; margin: 0px; color: rgb(0, 0, 0=
); background-color: rgb(255, 255, 255);">
<span style=3D"margin:0px"><span class=3D"ui-provider fy b c d e f g h i j =
k l m n o p q r s t u v w x y z ab ac ae af ag ah ai aj ak ContentPasted1" =
dir=3D"ltr" style=3D"margin:0px"><br class=3D"ContentPasted0">
</span></span></div>
<div class=3D"PlainText" style=3D"font-family: &quot;Segoe UI Web (West Eur=
opean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Robo=
to, &quot;Helvetica Neue&quot;, sans-serif; margin: 0px; color: rgb(0, 0, 0=
); background-color: rgb(255, 255, 255);">
<span style=3D"margin:0px"><span class=3D"ui-provider fy b c d e f g h i j =
k l m n o p q r s t u v w x y z ab ac ae af ag ah ai aj ak ContentPasted1 C=
ontentPasted0" dir=3D"ltr" style=3D"margin:0px">The fence expiration should=
 be still there by the delayed GFXOFF ,
 but this patch should be useful to help debug it as it avoids the system h=
ang when the issue happens.&nbsp; &nbsp;</span></span></div>
<div class=3D"PlainText" style=3D"font-family: &quot;Segoe UI Web (West Eur=
opean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Robo=
to, &quot;Helvetica Neue&quot;, sans-serif; margin: 0px; color: rgb(0, 0, 0=
); background-color: rgb(255, 255, 255);">
<br class=3D"ContentPasted0">
</div>
<div class=3D"PlainText" style=3D"font-family: &quot;Segoe UI Web (West Eur=
opean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Robo=
to, &quot;Helvetica Neue&quot;, sans-serif; margin: 0px; color: rgb(0, 0, 0=
); background-color: rgb(255, 255, 255);">
<span style=3D"margin:0px"><span class=3D"ui-provider fy b c d e f g h i j =
k l m n o p q r s t u v w x y z ab ac ae af ag ah ai aj ak ContentPasted1 C=
ontentPasted0" dir=3D"ltr" style=3D"margin:0px">Best Regards,<br class=3D"C=
ontentPasted0">
<span style=3D"margin:0px" class=3D"ContentPasted0">Tim</span></span></span=
></div>
<br>
&gt;<br>
&gt; Signed-off-by: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++--<br>
&gt;&nbsp;&nbsp; 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/d=
rm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; index ce41a8309582..222af2fae745 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; @@ -1581,9 +1581,9 @@ static int smu_disable_dpms(struct smu_context *=
smu)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For SMU 13.0.4/11, P=
MFW will handle the features disablement properly<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for gpu reset case. Driver involveme=
nt is unnecessary.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for gpu reset and S0i3 cases. Driver=
 involvement is unnecessary.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev) || adev-&gt;in_s0i=
x) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP][0]) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 4):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 11):<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB3873A8ADD1B0CE858527D041F606ABY5PR12MB3873namp_--
