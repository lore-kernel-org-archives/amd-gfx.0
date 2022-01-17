Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F43C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 17:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F21AD10F405;
	Mon, 17 Jan 2022 17:19:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DA1A10F405
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 17:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0S4Vzp8zXGMGAGofGpZiQ+E2KwyrRXfM5eZv3vh7p2wkI/9Hj5e2nu5agVLoNaueEQxl4wtU3FEf4n2RbWGT1xyI9l7cFC8GHfO+i+ozc96Giri5aay5aL3Lltndc2TbggYwxld+jeISZHRCLnHlRjCNbwpiR4KFjIVMsdCnJGvbpQ9TN6RlSAgDqT6WnqWME+8gTz8qDQrdagPYB7wEzSoJs+M3OyXbNjtM1+E9wash5+TFrkxMnHP9wBL1/lSwPiF4wg/52AqK6bHWoukZEeG3tDxH2ukB9MAXXXtAz38+MouEXQNYFl/BM0jMZ/wOOHwhupV0AcUJeVj9VCoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oADdqyjflY0JFcsg6Sh/MiCXoAa+1LuEJVr/uNOL1I=;
 b=OAQgqbUtRpJ+LaoSfe58k8JiZIBbjQ30NqtcwGIC/kRq5lb52vP/uLm110NFYL3PX4NG7P1O5lajYFCPQsLy/epAABPMyHT08SrTp6rWm8UgbCWWZwmxUi+W8mxJIFVx9hgK5LCD+o/7k1qzZ3HvPKjdgQWnz38PpDYIs/dLEEt9G/ZT7195XLP+Ttsgvs8HOeG3fXPkP9QcPxyXuKMB64x2KllVx0VxRlbcvo/mq2yz/uNDC2pSVxRuz/uTbm/wfhqzrDD521JxJJh25FN+s2GzfMylgxyLsCZ+Xj2DY01iuENfkTVRsuJDmekAmv32CxtErgQWp+UVJOIZn24GXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oADdqyjflY0JFcsg6Sh/MiCXoAa+1LuEJVr/uNOL1I=;
 b=pJ5/YmrDJtsKxEf8HvRsGioDTnU26pJEqqTKgJxyBGnC+DuDpE4LBzp4Ze6W+5SJjzXW69Rtd/ypvJQFNkj57dV6bi2eacCgmXmnpYoUUYMBfd8K2mKeV6+szC3axXCv5C9enPThrobbNwG7qgDYbK2JSainj0MGFHVm9u5SQh8=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM5PR12MB1417.namprd12.prod.outlook.com (2603:10b6:3:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 17:19:34 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%6]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 17:19:34 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amd: Warn users about potential s0ix problems
Thread-Topic: [PATCH v2] drm/amd: Warn users about potential s0ix problems
Thread-Index: AQHYByXoBe1P6n6rsEiQeuaYtqn+iqxnfWwAgAAAmvE=
Date: Mon, 17 Jan 2022 17:19:34 +0000
Message-ID: <BYAPR12MB4614363B37C7FCEB7150C29E97579@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20220111200026.15855-1-mario.limonciello@amd.com>
 <BL1PR12MB5157190D878C197F8EBEAE78E2579@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5157190D878C197F8EBEAE78E2579@BL1PR12MB5157.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-17T17:15:10.0000000Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0; MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0801db82-8c6a-41d0-9ae1-08d9d9dd8822
x-ms-traffictypediagnostic: DM5PR12MB1417:EE_
x-microsoft-antispam-prvs: <DM5PR12MB14177A4736197282BCE6BC3C97579@DM5PR12MB1417.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OXu8YbycTYUVtnm5VBwUmN86h1Af5wN+Pd250DAdN2DOg3m8CUmlpR/ZFratY+T0Ybmz9ASCoK9dGplUOmZOTI1SEwE5rSz5pSJw7+vtaceKSPXMnVsXO/DqkJShjRiUQ4//d9D9uuliKdzqY005g/q+tWeBQW0W1c4myCQYkabJhrM7yoaAz+y2W1h69Li9XreafLHX7ci0gHXDmBctAt3SEMi/BpAbwsaGHEpMWlqAIlciy8C6o9YcRh87Gyi2p2w3NOHUbLX5Vvv0SkvS+w6r20SNd4E+NPKUK78wYZtT/e1OEURsFYtuFDh3DntG69t91MnrsGaaiEJXxlVIU36PNNV5aH4MuRz5ySNx6WEUP54HycZ0SStKIVDw+iate2B63a+PoSZAzSSrKPbHoqK6/kqgMIDrbgPcnVqbxmtYJv31RV6wB0fpc55JBBweTeD91ED3BOwWGOmWEnNBVpWpSC7HOS5vfo9MO3buIucxuhupNNgR0Of5lh0iRhOAtlLtXR09N+63wX0UvOMiBsfDEu+POGWm2zG3Howi8BoqSi4FHcXSY/OjSrByqinBoI/eCnfRrRXvTVkzdgMCkQlJftF9n5ARd6G02TNyomxtjCSH+KepS6G5Wx8UGoegQRaoRgw0yZCWVgvTZvjJzqHVKZ+z/0zIQnkmxFIVekRoimYUju/VGChFA6OsCHQCAjKb3+TfqVDtzHMcbBKh7DGNYrkdjtvsPNhHM9ADLcs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(66446008)(33656002)(316002)(76116006)(71200400001)(122000001)(110136005)(83380400001)(66556008)(38100700002)(166002)(91956017)(64756008)(38070700005)(66476007)(66946007)(86362001)(4326008)(55016003)(2906002)(508600001)(7696005)(26005)(966005)(9686003)(53546011)(5660300002)(6506007)(52536014)(8676002)(186003)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MfGVcdiVKdH6uK2X/dIz6c5PPl1g0rA4owMB6mTpO9exzCr28Z6fWKhtxDRv?=
 =?us-ascii?Q?6es+WiH52J0qn3zxQnpM1J2FxwBbLuH1zSMrodeE7mcK/wf1AHCTP2s0YqDB?=
 =?us-ascii?Q?wPmJVsXmaMhVgsC1KVU3m3QS/1FIGMxvC3k1fNOeJlZ2z7Vuz0/kedf6occC?=
 =?us-ascii?Q?cqSiGC/SUFXyFy20kazkMSN4wZYHgLrJSwIbZTecGbw8LplMwp6cA+SP8SqZ?=
 =?us-ascii?Q?ngKwqOQpQQAnxKypL9A2wYC2l3KllDfYPjk8au5kJsrZkC5E7bGGSLob4tP3?=
 =?us-ascii?Q?oJlz5rC4RScHeiKcaDNA527So9sjq1Cl8fxXTUVTNzpMgFFz/pTWe+Hxq5d+?=
 =?us-ascii?Q?LQ95jcq4NKF3/7sR2r1H46nao+8n230iDqjdHO8olRMKeLVveVTa69aevwCX?=
 =?us-ascii?Q?6NqiWz8AhQcy21kakiPvvk+9PGz+Od+aEUO5fMDHwQMtzPKndhwET4AZ7moO?=
 =?us-ascii?Q?4IyW+MnRYL5ZP7534K3+sztkxY75kdmKjgGxMQw58lVH4pM49eHIPHwPwhaL?=
 =?us-ascii?Q?TPY+dLh3Jps22oGDevToQi2arDBcfYUmZoLhEQ/NZyo4RGFnhR3KnEQ+mWUR?=
 =?us-ascii?Q?E2ED1iMcQA/nLHrzzPXpupdsTeqtgeaJCt5xeVrdoWfz7aKmaQL1sZF32Wk3?=
 =?us-ascii?Q?C+iHSA1EMFz2ats4Z3mxDgwj76ltdemHdy1nUFFZ+J53xm7q0o6KxYm5ruXX?=
 =?us-ascii?Q?33OrOJwx+BZbMBA3oKUGjBNpwYse7kM1uxODEum10ElySGZf6JOXXjsfmtT1?=
 =?us-ascii?Q?BIV9C1xziquHl80CH17aPIWUTxv4kXJhSPVoRVouXTExNtzkOXtsEhINMVMd?=
 =?us-ascii?Q?HznztbRHYEEJNc2RkFXAsEAKILY50pK5GOqMeg7VqBMluW4O5ac2sNdViikf?=
 =?us-ascii?Q?a1X56WG+qVOmr0IsJxkhTC8mrqhhkOU100/mVUJQNfoCjHkXZP1bieWB1Yvd?=
 =?us-ascii?Q?4daRVD1DLEGVbyqtiLL884PEcqqMjsUqZzcNTYkQZNo5LgiYVzDHUHDZjz2w?=
 =?us-ascii?Q?2ZMH6pEx2ujESZL5d7nbpJaPywPfwpSdKN1EveCl+pRysYp1Uwm9Art2EAUr?=
 =?us-ascii?Q?4cDwQ5+JIJUMGv+i9xPXN8hCEcG8+9h18oHYYvLz7v3w6iLXELKbR1nyM7/x?=
 =?us-ascii?Q?D7HHh145WQlzl94krtboZm1BulNxwUXQ+6FOc3/UN4P7c8LRDx05ENik/+fl?=
 =?us-ascii?Q?3XZXnk/6uwTNYxtoEks76Kt+3Q77hhQiEKYFt8dkwmrE1wQd1Y8FqgP4Q48Z?=
 =?us-ascii?Q?/NRoVi5G/QZkz/XGTK1GGPAJDWZRiKe71otliWov141kiYUPSXQZ/yWCVah5?=
 =?us-ascii?Q?Jjnh+URgW53G2HLb9GWIJOhydcKyxBG/7zaZefNFk6eqiZeCrOrrEZ6fsTyA?=
 =?us-ascii?Q?AQ+o2ZNx/auYITHfvkYIRAVKbjRwj2YLg1PZBfMbu6SW+I4wHh6vykiz42fe?=
 =?us-ascii?Q?ZX89yd7/mQdAwgWqi6T+JVYI2GUr2TSf/mqDWLXRpQpJe3oTWQ+TifBm9ZzA?=
 =?us-ascii?Q?/l4eP0kjcqTvAsYi1l9fwFzuiVCynT98Is2b3dOJgA5K/H6zV6zaLJNSeGOl?=
 =?us-ascii?Q?BywFltxQHBkJoFq/jtuw1ukQx0ldKhJ9GNIVplkc?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB4614363B37C7FCEB7150C29E97579BYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0801db82-8c6a-41d0-9ae1-08d9d9dd8822
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 17:19:34.3042 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npoeB7Jywj+g1Eg10Mda/aNBBRgm6JI2cNdZwnQYx+RG5puO3vb6BWdmPjUG3/TS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1417
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
Cc: Bjoren Dasse <bjoern.daase@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB4614363B37C7FCEB7150C29E97579BYAPR12MB4614namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Any problem with PMFW sequence in the way Linux handles s2idle when it's no=
t enabled in ACPI?

Thanks,
Lijo
________________________________
From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Monday, January 17, 2022 10:45:44 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Lazar, L=
ijo <Lijo.Lazar@amd.com>
Cc: Bjoren Dasse <bjoern.daase@gmail.com>
Subject: RE: [PATCH v2] drm/amd: Warn users about potential s0ix problems

[Public]

This has been sitting a week or so.
Bump on review for this patch.

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Tuesday, January 11, 2022 14:00
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Bjoren Dasse
> <bjoern.daase@gmail.com>
> Subject: [PATCH v2] drm/amd: Warn users about potential s0ix problems
>
> On some OEM setups users can configure the BIOS for S3 or S2idle.
> When configured to S3 users can still choose 's2idle' in the kernel by
> using `/sys/power/mem_sleep`.  Before commit 6dc8265f9803
> ("drm/amdgpu:
> always reset the asic in suspend (v2)"), the GPU would crash.  Now when
> configured this way, the system should resume but will use more power.
>
> As such, adjust the `amdpu_acpi_is_s0ix function` to warn users about
> potential power consumption issues during their first attempt at
> suspending.
>
> Reported-by: Bjoren Dasse <bjoern.daase@gmail.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1824
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Only show messages in s2idle cases
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 4811b0faafd9..1295de6d6c30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1040,11 +1040,15 @@ void amdgpu_acpi_detect(void)
>   */
>  bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
>  {
> -#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
> -     if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
> -             if (adev->flags & AMD_IS_APU)
> -                     return pm_suspend_target_state =3D=3D
> PM_SUSPEND_TO_IDLE;
> -     }
> +     if (!(adev->flags & AMD_IS_APU) ||
> +         pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE)
> +             return false;
> +     if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> +             dev_warn_once(adev->dev,
> +                           "BIOS is not configured for suspend-to-idle, =
power
> consumption will be higher\n");
> +#if !IS_ENABLED(CONFIG_AMD_PMC)
> +     dev_warn_once(adev->dev,
> +                   "amd-pmc is not enabled in the kernel, power
> consumption will be higher\n");
>  #endif
> -     return false;
> +     return true;
>  }
> --
> 2.25.1

--_000_BYAPR12MB4614363B37C7FCEB7150C29E97579BYAPR12MB4614namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Any problem with PMFW sequence in the way Linux handles s2idle when it's no=
t enabled in ACPI?</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Limonciello, Mario &l=
t;Mario.Limonciello@amd.com&gt;<br>
<b>Sent:</b> Monday, January 17, 2022 10:45:44 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Cc:</b> Bjoren Dasse &lt;bjoern.daase@gmail.com&gt;<br>
<b>Subject:</b> RE: [PATCH v2] drm/amd: Warn users about potential s0ix pro=
blems</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Public]<br>
<br>
This has been sitting a week or so.<br>
Bump on review for this patch.<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
&gt; Sent: Tuesday, January 11, 2022 14:00<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; Bjoren Dasse=
<br>
&gt; &lt;bjoern.daase@gmail.com&gt;<br>
&gt; Subject: [PATCH v2] drm/amd: Warn users about potential s0ix problems<=
br>
&gt; <br>
&gt; On some OEM setups users can configure the BIOS for S3 or S2idle.<br>
&gt; When configured to S3 users can still choose 's2idle' in the kernel by=
<br>
&gt; using `/sys/power/mem_sleep`.&nbsp; Before commit 6dc8265f9803<br>
&gt; (&quot;drm/amdgpu:<br>
&gt; always reset the asic in suspend (v2)&quot;), the GPU would crash.&nbs=
p; Now when<br>
&gt; configured this way, the system should resume but will use more power.=
<br>
&gt; <br>
&gt; As such, adjust the `amdpu_acpi_is_s0ix function` to warn users about<=
br>
&gt; potential power consumption issues during their first attempt at<br>
&gt; suspending.<br>
&gt; <br>
&gt; Reported-by: Bjoren Dasse &lt;bjoern.daase@gmail.com&gt;<br>
&gt; Link: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/1824"=
>https://gitlab.freedesktop.org/drm/amd/-/issues/1824</a><br>
&gt; Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
&gt; ---<br>
&gt; v1-&gt;v2:<br>
&gt;&nbsp; * Only show messages in s2idle cases<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 16 ++++++++++------<b=
r>
&gt;&nbsp; 1 file changed, 10 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
&gt; index 4811b0faafd9..1295de6d6c30 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
&gt; @@ -1040,11 +1040,15 @@ void amdgpu_acpi_detect(void)<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)<br>
&gt;&nbsp; {<br>
&gt; -#if IS_ENABLED(CONFIG_AMD_PMC) &amp;&amp; IS_ENABLED(CONFIG_SUSPEND)<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (acpi_gbl_FADT.flags &amp; ACPI_FADT_LOW_=
POWER_S0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;flags &amp; AMD_IS_APU)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return pm_suspend_targe=
t_state =3D=3D<br>
&gt; PM_SUSPEND_TO_IDLE;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU) ||<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_suspend_target_st=
ate !=3D PM_SUSPEND_TO_IDLE)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!(acpi_gbl_FADT.flags &amp; ACPI_FADT_LO=
W_POWER_S0))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_warn_once(adev-&gt;dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;BIOS is not configured for suspend-to-idle, power<br>
&gt; consumption will be higher\n&quot;);<br>
&gt; +#if !IS_ENABLED(CONFIG_AMD_PMC)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dev_warn_once(adev-&gt;dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amd-pmc is not enabled in the=
 kernel, power<br>
&gt; consumption will be higher\n&quot;);<br>
&gt;&nbsp; #endif<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&nbsp; }<br>
&gt; --<br>
&gt; 2.25.1<br>
</div>
</span></font></div>
</body>
</html>

--_000_BYAPR12MB4614363B37C7FCEB7150C29E97579BYAPR12MB4614namp_--
