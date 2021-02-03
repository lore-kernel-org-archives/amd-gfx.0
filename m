Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C4AC433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 14:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 522DB64F4A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 14:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522DB64F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA476EAAC;
	Wed,  3 Feb 2021 14:22:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C966EAAC
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 14:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSjV8bzjquF1F5hUbCsrCE+WpQi/ASX4bTvS2a6DJkHz6HzI9jdOzMjzDl5uimZFSAK26/rrymUxz983Dt/2+XtLNxZNmrkplp07LbECAUUogoXj7AyiQWD8ges+oGeLKqKJLaedDAa2ERPj45XKV4n+CuiwfDmdOgQovoSeVfN2lr7SzPgZ7T12fjpAAPpPiQEHlAuGpSU+mFt8qF6wt41ds7T6rovQsvFcSC5Fs9F8592oTDY7xJnvwmwB+U2+w1bGAD0bOd/PzKrZCTA0zpaYkx0+/vOS5BqEFZ0Ej0h56l5EkZ8oFkNUkHMIoaTlPZQ4GDxKSABShb34sQODqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg/5HCsIwBqqWLKNAvvMUZcXNGeDffZXDl4kMTUe0Wo=;
 b=Gv11CAkEiFTsvNRv4qqdWD8Q4jhZoXTD51saF5qW2rONGUQBaDbNQDV7aN4LsrrethmnIbIMBIDaxQ3qQRChuD55og+MIHNdeMcH77ZNvlY17Eg248W6SFIDczSNWeYetsx2lS6Pg3wXuCJcJlrafeeAGejbM5QcZtBPnRUaXGnQtyx+H8s29Tp0z5ZQIDgH5QpFWSLxP9BAnboaBNnkKTB4AJ17pBHopanG1fplGlBwsBvgiZL8tb2KAOtwpqXzxCz2cP6b75iOyAfYUoGaRwax29nxeKLIdjplXSqXZ6tDQGuDEWP4ZImm1JXKn9P7q+lU1dnmfa3A9642IMWbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg/5HCsIwBqqWLKNAvvMUZcXNGeDffZXDl4kMTUe0Wo=;
 b=HWayzofuyVapWCFTEaFF71jWJlncDStsDIZk5DfCLvpbjokkB4wXW7tZILPbSrYiWwzpxU/51ajtdovGgvMjmUJWpG6RK1FX8WwjVxyL2sq7Ore8GLbfchGZkC5thzxgCjggq5k8prGcy3UxoPnY43kFVT/YXspWYzewzcG61RQ=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3311.namprd12.prod.outlook.com (2603:10b6:208:100::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Wed, 3 Feb
 2021 14:22:35 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 14:22:35 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: optimize list operation in amdgpu_xgmi
Thread-Topic: [PATCH] drm/amdgpu: optimize list operation in amdgpu_xgmi
Thread-Index: AQHW+hEEItAp+Am7/0CYzGh7p6QV0KpGc9YAgAAHb2I=
Date: Wed, 3 Feb 2021 14:22:35 +0000
Message-ID: <MN2PR12MB3022039C72A11296B2805417A2B49@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20210203094259.21899-1-kevin1.wang@amd.com>,
 <9de00808-c40c-e1b2-4d6b-d1a73ed4a30b@amd.com>
In-Reply-To: <9de00808-c40c-e1b2-4d6b-d1a73ed4a30b@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-03T14:22:35.588Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e8f31a1-a0c8-4147-d221-08d8c84f270e
x-ms-traffictypediagnostic: MN2PR12MB3311:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3311BDF67CAB2EB0D42DEDC2A2B49@MN2PR12MB3311.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iJePQvz5mXhTmckwoS+XuxUy7+E36avPb+Y77CFXLo6T7fj42H2gmDDE3tBd5amUjsEGZvsM798Zo6J3N+pkGgTfxNjisfRVGiRIJVo4WLqxfd/D0WBkiZumIys6t2kHiOBhiEVCRDk4rrdzt7dU848+te7TLViMo+wMhz2Dgw1vmpdG+SVZs6qOpFkp1GySQ8RdA61E9J8n7tNi7UIB6qmHXy9aZSQ+JEw1cPYU/iATd6gShl3AOCag51OZG1mJUlDbRPmTn9hGWYuOEwBAxlKiUX6mb3gKqKv/DnGWrhN2TlfptCA5bNtiMuJkgalC/0S3hrluh3jv0krWYCxhNuzLlPZtbFnJ6HrKSqawG8v3K6mpFZqctwhaALiWfCUwRlgtfgwzqIUVziZ/njAEfZ8dsB2VVgfpi65Ddgng+sS9cXfqOLnnCkT5ChdbPHoASvJ073LUcmVuDD/cF/P1fRwdfRk7P3i9LAtFzM6sfIjO2XnHZqKnBJg0ZvpKLSADQNeDt1XyK7Wa1RhnF+rP1w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(71200400001)(6506007)(110136005)(316002)(2906002)(83380400001)(66946007)(66476007)(66556008)(9686003)(53546011)(76116006)(5660300002)(55016002)(19627405001)(7696005)(4326008)(64756008)(91956017)(33656002)(8676002)(186003)(26005)(478600001)(66446008)(52536014)(86362001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?fPNwPi15+26LvCkXbBh9q88VwiQqE77ezN7DgDQ6dpd2V6QFrHJlR2K8Qx?=
 =?iso-8859-1?Q?rN3juIl/yEnIlcJLhGkYxBpvds0kMootUbYUrpdGBeoe9xFdphWlD0yugw?=
 =?iso-8859-1?Q?OIuBAFD9XaCu/51+QM2OMACNTdVRNT6ddEV3K3h4TPUFWNl5a2pypbwTaU?=
 =?iso-8859-1?Q?M0xlYIt1LBSU4oAdt3O6o46PLeUlDJMgOaCicbWT7RZZo4Xr4E4g/52rva?=
 =?iso-8859-1?Q?Jv7h9Gx+e6H9s1hCoEeZBJcX8zboV+6C7eNBRtBmwIQhp1ORpaeTiqifOC?=
 =?iso-8859-1?Q?7B00JjHTk593Q9cDBcejJFLpHF7J8HQTc2pg9CLrvzDfPNfFD7H9Dp9jHL?=
 =?iso-8859-1?Q?+PBYyOKfbfcJ1AoYH3KIeA/9LSMXwefUnMWZ1M1bLRWI07AYwvdU1tr9Lz?=
 =?iso-8859-1?Q?lCDTiHitZ4HgjbJ9/2JySWoqU5iVdmdGlABUcG/+mYt4HEU7RObKoiKapv?=
 =?iso-8859-1?Q?2Wk10vwVf4CJZ/ul+k7UnQbCHF2VUfG5+lTj95/MwU7X+vaLff/4pMdDuI?=
 =?iso-8859-1?Q?FHEzKp32YFDywI5QXjtBsxY56JsbwHRLBGl2W3H3m2vJd31WHlbtB8+Pwz?=
 =?iso-8859-1?Q?9gB65ZibcFJf1fdUp4Toq8GJDOKDwevA1SneWNo9w6Y85EpJHnOEkS2NVm?=
 =?iso-8859-1?Q?1UpWennfg9m/XERnS93fE/KcwF20geVqyYbqx/AI5fbvxcjSWQCHRCQdRG?=
 =?iso-8859-1?Q?4YHSPPUaq5wM1HXz0/MMKrx5a54bXb16ot+dNTESj9sff+h55OKyB1Vhe1?=
 =?iso-8859-1?Q?d0V55oOqHTDv/Fy7qB9ncRjE8/eFX0JqZKG9x1jPO1BhI2nBtnBNFVCjau?=
 =?iso-8859-1?Q?D+RAzYXtE6ASAXRvkC15tcLkbRWk4dV16S9n8pMXDkbz5EGZIfXPqDwF9V?=
 =?iso-8859-1?Q?aOmH4c1zyYSE/MOUjAioaEhfKMHb97BZC/HSanANn9INoo6eDiymjcOw8I?=
 =?iso-8859-1?Q?4M1kP4gJ+WtzSGwLeFebuQZqCKizbrYzFtSDPGO+w4tFvbJdnhPdv/K1Hi?=
 =?iso-8859-1?Q?Konr0bLcBTgFCfOPixHccPJPvxpfvjE0VNKvMMnGJbKH6HDrJZCdz3y6Ny?=
 =?iso-8859-1?Q?sLCZE1a5vh2koGEGnaoXrORgtnvEDa9TVUa4V9JQC1A/?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8f31a1-a0c8-4147-d221-08d8c84f270e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 14:22:35.5100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6JubnETLafUS7gvMZEQrCbuFhZyfkOxgvkI8Z2ybwP6Y8AE30z1O2p8a6lNlrwq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3311
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: multipart/mixed; boundary="===============1668978630=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1668978630==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022039C72A11296B2805417A2B49MN2PR12MB3022namp_"

--_000_MN2PR12MB3022039C72A11296B2805417A2B49MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

thanks Felix,
I will continue to optimize related codes in the future.

Best Regards,
Kevin
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Wednesday, February 3, 2021 9:53 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: Re: [PATCH] drm/amdgpu: optimize list operation in amdgpu_xgmi

Looks good to me. I see some more redundant code in that function, if
you want to clean it up further:
>         hive =3D kzalloc(sizeof(*hive), GFP_KERNEL);
>         if (!hive) {
>                 dev_err(adev->dev, "XGMI: allocation failed\n");
>                 hive =3D NULL;
No need to set hive to NULL. The condition above is only true if it's
already NULL. Also you don't need to print error messages for
out-of-memory errors, because kzalloc will be very noisy if it fails anyway=
.

>                 goto pro_end;
>         }

Either way, this patch is:
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Am 2021-02-03 um 4:42 a.m. schrieb Kevin Wang:
> simplify the list opertion.
>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index 541ef6be390f..659b385b27b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -324,7 +324,7 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amd=
gpu_device *adev,
>
>  struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev=
)
>  {
> -     struct amdgpu_hive_info *hive =3D NULL, *tmp =3D NULL;
> +     struct amdgpu_hive_info *hive =3D NULL;
>        int ret;
>
>        if (!adev->gmc.xgmi.hive_id)
> @@ -337,11 +337,9 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct=
 amdgpu_device *adev)
>
>        mutex_lock(&xgmi_mutex);
>
> -     if (!list_empty(&xgmi_hive_list)) {
> -             list_for_each_entry_safe(hive, tmp, &xgmi_hive_list, node) =
 {
> -                     if (hive->hive_id =3D=3D adev->gmc.xgmi.hive_id)
> -                             goto pro_end;
> -             }
> +     list_for_each_entry(hive, &xgmi_hive_list, node)  {
> +             if (hive->hive_id =3D=3D adev->gmc.xgmi.hive_id)
> +                     goto pro_end;
>        }
>
>        hive =3D kzalloc(sizeof(*hive), GFP_KERNEL);

--_000_MN2PR12MB3022039C72A11296B2805417A2B49MN2PR12MB3022namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
thanks Felix,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I will continue to optimize related codes in the future.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Wednesday, February 3, 2021 9:53 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Li, Dennis &lt;Dennis.Li@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: optimize list operation in amdgpu_x=
gmi</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Looks good to me. I see some more redundant code i=
n that function, if<br>
you want to clean it up further:<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive =3D kzalloc(sizeof(*hi=
ve), GFP_KERNEL);<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hive) {<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;XGMI: allocation failed\n&=
quot;);<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; hive =3D NULL;<br>
No need to set hive to NULL. The condition above is only true if it's<br>
already NULL. Also you don't need to print error messages for<br>
out-of-memory errors, because kzalloc will be very noisy if it fails anyway=
.<br>
<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; goto pro_end;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
Either way, this patch is:<br>
Reviewed-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
<br>
Am 2021-02-03 um 4:42 a.m. schrieb Kevin Wang:<br>
&gt; simplify the list opertion.<br>
&gt;<br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 10 ++++------<br>
&gt;&nbsp; 1 file changed, 4 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; index 541ef6be390f..659b385b27b5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; @@ -324,7 +324,7 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct =
amdgpu_device *adev,<br>
&gt;&nbsp; <br>
&gt;&nbsp; struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_devi=
ce *adev)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *hive =3D NULL, *tmp=
 =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *hive =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.hive_=
id)<br>
&gt; @@ -337,11 +337,9 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(str=
uct amdgpu_device *adev)<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;xgmi_mutex);=
<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!list_empty(&amp;xgmi_hive_list)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; list_for_each_entry_safe(hive, tmp, &amp;xgmi_hive_list, node)&nbsp; {<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hive-&gt;hive_id =
=3D=3D adev-&gt;gmc.xgmi.hive_id)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; goto pro_end;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(hive, &amp;xgmi_hive_lis=
t, node)&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (hive-&gt;hive_id =3D=3D adev-&gt;gmc.xgmi.hive_id)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto pro_end;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive =3D kzalloc(sizeof(*hiv=
e), GFP_KERNEL);<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022039C72A11296B2805417A2B49MN2PR12MB3022namp_--

--===============1668978630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1668978630==--
