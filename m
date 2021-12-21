Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24963C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Dec 2021 14:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 794EA113965;
	Tue, 21 Dec 2021 14:36:27 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E2B11395A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Dec 2021 14:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kV4CjEQEemAZ9B4n2ULGpKQINb8e+SzhJfmbQWIx3kzdSftIStXZO/aqf64hnLjiDWYWKtkDtwkwD8Ft1r0tiRJlwIZgmXdhZG1pp4/FDjCu2wmXAyDBKMIxNG3Sky92cIXkxIWsO1DhQwmq0Cq9HKzn38JQd8c5nGmQBrTTAPV+YfBSxv7rM1GN93OG9OPYn9+6VTrnJn7c6t98vd/eOsZWS1KCKnP3djzg5jUhIlp7WOJ0GBtCKD9rM8zhWsBPbTmKPxxDxqaxV3Z3WenY0Sy67xHUn0sjjdX1DjwRwXoE1f7T7LdXv2+oNWazdXfTxvzVIXcm+Cbi4ooXrZe+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnQZut59NxepqTFSt2xCgeQ6iov+TxB/p3WSNamwSX4=;
 b=hYZ5lZRfQrL2seAu78wm6vvDchS9DC2J/ucs6d2Togxf9nh8NH9+Fm5CGNBE8rhf7ZCd73nF8Gvt+TIdYtQ46E1VAi7wADFt86Bkzk7GsiQzM4fe4T9eN7D/mWo/v4AliEOOZDNBUgD4zqGFNSilfIAurKw3fUXhj9OfF2O5Y16ZVkZb/BR5RWxYwxPMxg9/JYoNOh9bhxcpwafM3kMck+eLLctzeDLpW2FcUvjhjmt9xVsHyHteTgY0LJQPd/77tQf3fE1VjAE37tGWSIW+vBI85vjKkkkhFkaal11GHURIHGe6LjNOEI0U4wYPcRfSMPuyNB9rQCLa34GKG7JZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnQZut59NxepqTFSt2xCgeQ6iov+TxB/p3WSNamwSX4=;
 b=Y7NKczJuGeQFzlvxNDOjLr9+JLVsTTcf53YuW83ubADXFFgPUANVrfNeGGQibvnc0d6cL5Rfm8SNXMbCD4oSb3jqhF3gdaZQCA8W9ZLLpUq9/mm6q6kW0C6ms1RQpo0pYhhOSOmA9Ce/fzbqdz3jKKL5LVYC354vh1jcomhdjmM=
Received: from DM6PR12MB4300.namprd12.prod.outlook.com (10.141.186.149) by
 DM6PR12MB3626.namprd12.prod.outlook.com (20.178.31.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.17; Tue, 21 Dec 2021 14:36:24 +0000
Received: from DM6PR12MB4300.namprd12.prod.outlook.com
 ([fe80::ad2e:ee2e:f3a6:398a]) by DM6PR12MB4300.namprd12.prod.outlook.com
 ([fe80::ad2e:ee2e:f3a6:398a%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 14:36:24 +0000
From: "Nikolic, Marina" <Marina.Nikolic@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Thread-Topic: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Thread-Index: AQHX9bvj41WooLnqpEOY/BhGvnfg9qw7vGaAgAFAa0CAAAc5Ww==
Date: Tue, 21 Dec 2021 14:36:24 +0000
Message-ID: <DM6PR12MB4300DD7B8B8F194198F7D6E78E7C9@DM6PR12MB4300.namprd12.prod.outlook.com>
References: <20211220160834.8400-1-Marina.Nikolic@amd.com>
 <DM6PR12MB2858E316736722D6682BAAAA857B9@DM6PR12MB2858.namprd12.prod.outlook.com>
 <DM6PR12MB4300CCD940D7D651D07CBD2A8E7C9@DM6PR12MB4300.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4300CCD940D7D651D07CBD2A8E7C9@DM6PR12MB4300.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-21T14:36:23.811Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 281634a0-4193-1858-ffb8-d2d5938a5e62
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61e29ac8-6d40-47c4-97d3-08d9c48f43a0
x-ms-traffictypediagnostic: DM6PR12MB3626:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3626E266BD1DAB6CC432D82A8E7C9@DM6PR12MB3626.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rPTa7secu4ZZm+HFmdZikMaw5DBSiPx8flEW/NovJ8Lx/He8zYgnMdvN5dm60uZweOMAl+d1xre+/fLplzD3K468f+kaw1lR/dXZn7H5o+oqXdDODDIrAxzpAzzwIEJl+PBMfZ1EGhFdBl2gY84R24xQZxKG51oDqbdvOn0n16KYVf0JCdKuAkt8eXfimEDGPbLszTbUss6EBUXwqHPmgGJXi08dKhfMJmlefgdL+C34n9hjr7z8JjUDvqU7INHoCLxIhvbw5nqH1DaHUop+JdKuFFxYUdSNz3FMTz7uaR6hrslOpnFxam6QFvqcrCL+NMzMMqJd6IdWIv0vYyMG4IA4bULTlvbD79/Vfkepdq91XDuSj7RLQ+SGuYi6tH99p8nhRQvyKMxRCYquCpVzMuszKPlwct+RtwhWQ5bFCL1d2LuomaV0LTEAtLlndhHzMfyToyRpIQrL5OuxgfkPfyy+wE5GZ3kdWTIm+HqvLLVC5RIDYphkp2cTn7lfxKmBTcIwvmVj/OyfQ16tmI/2A15hAn5wDTbb+cYmdpKHZiY1sjbsyV0EeZw2IuzRDxFvobYpZuxcVsT3i66XbofDT/bBCF8RcvZG8cNgDk1M9TgnNKQWDYYzYec1HVRpoUvPdfTqaiF7mWbhATr6sTD4p/cFSeaIdvNYZue0pe3Wh/XB/1SAbLKa2Sq8MEMmoRk3zU11wtYmk8FetL0dbsLTww==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(8936002)(55016003)(66946007)(53546011)(52536014)(6506007)(186003)(66446008)(8676002)(7696005)(66556008)(64756008)(110136005)(26005)(38070700005)(19627405001)(122000001)(91956017)(33656002)(76116006)(5660300002)(38100700002)(2940100002)(508600001)(86362001)(4326008)(54906003)(66476007)(9686003)(2906002)(71200400001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5EVONeBGGWyEZtPLtG8gJdnzStPVlrV3SeHj93KjAS402zIJwtVTW0bzgYaI?=
 =?us-ascii?Q?xY7eaqGA4+7MUb4/mzfFzE+juSHlbbGFqf7Lzv3ZvH+1fNnIHj4Rz/PSrARh?=
 =?us-ascii?Q?0/cVuxHQ3sEo4p9VtjFGOhhS0zDJ5KAhFd2TtbEJLNGnfZ2Va32FGyg+8uOQ?=
 =?us-ascii?Q?mvPl43Ls1e3CeIcwD8RFybtmip32RcHBSpOGpa1diKTbY63+15HAaIWMjEm5?=
 =?us-ascii?Q?AjJAh7DDQG69QGNZjUwydqP6GE8qlXnCBE8vne5HbfD+Neoyn4JL9xWOkhDI?=
 =?us-ascii?Q?Z3ecOQuQkgsB7SToiMZZP1kX5l35rOVfZCsfkJ7USuo4ajpf3t+0uJ9WB4At?=
 =?us-ascii?Q?yZ7sQ7jk5zYSkOTSeIYcNy9jLrGnFqTJBLzZ2LMVrpDe/+pRx8hq7df/YKlY?=
 =?us-ascii?Q?rFIu6Va1CAMRsdJyacEzwGZgL1IzodrLY/zhuFROl2Lky/wH2KB+Fc4kQKQd?=
 =?us-ascii?Q?B/+3dSPNFh0feNUhHLMhh1WZW+wXnFfgmk8SX0FmINtk+KDKwMkBj3Vpg8mq?=
 =?us-ascii?Q?5wLnpd49YOuUXqzl7ablURrhAVRazzEk5jwpAdIU9NKYUAr40ONha6CW/lGx?=
 =?us-ascii?Q?K3QNVDvxEARgWomoRJdWDa0XgEEg8EUIBgV16G3ykNHxUeFLeGklTG//0qSD?=
 =?us-ascii?Q?5kL95kPRIVCdBcKMExYdNS8q8vyM4DK7JZq8IFDxrtMrG2lLchCgcYKOH9en?=
 =?us-ascii?Q?9LVCRMjcIzNoXE/NprAogey3TGp4MsJCMwZ6W376gQRGcXZ06kTpEi8mlnkW?=
 =?us-ascii?Q?/RWaLh3/3Nn8NRDUzKOfFVsJZAhB+bo+y2qj9QfXa0xJZ859vu7I4JaxTjw6?=
 =?us-ascii?Q?guUXRBlPb9baAq7pZUnzcwYOyhCDD7vNc12eexaGDSgEniQA6vgT9m8/dZJt?=
 =?us-ascii?Q?3XLPJTFr393mDMEVbgvpgRm/dMhFz+A/CLgRr8zB2kBT2oysKojeR1cr/Ccc?=
 =?us-ascii?Q?mnK3CND9xCqvlyVk8PHnvYX/Mdi/Y4ppvaF9ieyDqfMIY4PqrVI5KjBGUMYp?=
 =?us-ascii?Q?7tkN4na2YCvktuec/aOVjkHxAMEWNAOiLRe37kWRKxePSOy0Iuj7bg0pE60y?=
 =?us-ascii?Q?GmZhvkr/ZeeIoBWE/EN504xEnXHdzmSWid1314dTkLxz2ioD5/XNvZR/kvsC?=
 =?us-ascii?Q?KN0JTuj9y4QO3xN6Zy52gWvJX7IDPH7fKBY5VpDh2LFwxPBMfkk2G3mE38Pf?=
 =?us-ascii?Q?1D8tg19tSzofi2Jgsvfx7SgPuSps3+pgrLXLvEhR0PUVS23BICme/41812AK?=
 =?us-ascii?Q?oVivsgyPtb9TO3GXblxFQT87wjg4sYn/GVmwyX9bzZpyxoCyb4OjvAGSIO+f?=
 =?us-ascii?Q?1CIGEhVzWNOIxoT6kVVL0ZUoAo8ROfvL8tdZN3K8Odn2cM2i/nS/7umkg1BG?=
 =?us-ascii?Q?SNndGDiQPczy1DV+qeIC+QYEhTNrSNoGFgshI1aTPmMu0rhsPwQyWVxxlKvW?=
 =?us-ascii?Q?aW2LeIqX5gPgwBddBiCBrr6f6N+NXho2QBy9UHjBMY3nPi1CKJKghLsvJpyW?=
 =?us-ascii?Q?E/mTCilx2kO5dCkSittDHa8JNWeaWyRyjYXoe/TifTt7t9fHB/J0xk2rm83p?=
 =?us-ascii?Q?kh1G/VJ4hqDX4nd0Vxy4NyEARVsETKV09fv6HciYtgcL1odWFgHz2vT3FerF?=
 =?us-ascii?Q?DQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB4300DD7B8B8F194198F7D6E78E7C9DM6PR12MB4300namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e29ac8-6d40-47c4-97d3-08d9c48f43a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 14:36:24.3132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UrVxppqo4XIVpEbkxaynYfSi1WwFt1bw+IeHJFDSMUAsK2z3OGtT8aj+ugLRP4BoHlGlSGIad10g9oeiM2tlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3626
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
Cc: "Mitrovic, Milan" <Milan.Mitrovic@amd.com>, "Kitchen,
 Greg" <Greg.Kitchen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB4300DD7B8B8F194198F7D6E78E7C9DM6PR12MB4300namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

From 06359f3be0c0b889519d6dd954fb11f31e9a15e0 Mon Sep 17 00:00:00 2001
From: Marina Nikolic <Marina.Nikolic@amd.com>
Date: Tue, 14 Dec 2021 20:57:53 +0800
Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 permission in ONEVF mode

=3D=3D Description =3D=3D
Setting through sysfs should not be allowed in SRIOV mode.
These calls will not be processed by FW anyway,
but error handling on sysfs level should be improved.

=3D=3D Changes =3D=3D
This patch prohibits performing of all set commands
in SRIOV mode on sysfs level.
It offers better error handling as calls that are
not allowed will not be propagated further.

=3D=3D Test =3D=3D
Writing to any sysfs file in passthrough mode will succeed.
Writing to any sysfs file in ONEVF mode will yield error:
"calling process does not have sufficient permission to execute a command".

Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 082539c70fd4..c43818cd02aa 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_
                }
        }

+       /* setting should not be allowed from VF */
+       if (amdgpu_sriov_vf(adev)) {
+               dev_attr->attr.mode &=3D ~S_IWUGO;
+               dev_attr->store =3D NULL;
+       }
+
 #undef DEVICE_ATTR_IS

        return 0;
--
2.20.1

________________________________
From: Nikolic, Marina <Marina.Nikolic@amd.com>
Sent: Tuesday, December 21, 2021 3:15 PM
To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com>; Kitchen, Greg <Greg.Kitchen@a=
md.com>
Subject: Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode

Hi Kent,

Thank you for the review. Yes, I can confirm I am trying to set this for ev=
ery single file for SRIOV mode.
@Kitchen, Greg<mailto:Greg.Kitchen@amd.com> required this for ROCM-SMI 5.0 =
release. In case you need it, he can provide more details.
I'm going to clarify commit message more and send a new patch.

BR,
Marina
________________________________
From: Russell, Kent <Kent.Russell@amd.com>
Sent: Monday, December 20, 2021 8:01 PM
To: Nikolic, Marina <Marina.Nikolic@amd.com>; amd-gfx@lists.freedesktop.org=
 <amd-gfx@lists.freedesktop.org>
Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com>; Nikolic, Marina <Marina.Nikol=
ic@amd.com>; Kitchen, Greg <Greg.Kitchen@amd.com>
Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode

[AMD Official Use Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Marina=
 Nikolic
> Sent: Monday, December 20, 2021 11:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com>; Nikolic, Marina
> <Marina.Nikolic@amd.com>; Kitchen, Greg <Greg.Kitchen@amd.com>
> Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read pr=
emission in
> ONEVF mode
>
> =3D=3D Description =3D=3D
> Due to security reasons setting through sysfs
> should only be allowed in passthrough mode.
> Options that are not mapped as SMU messages
> do not have any mechanizm to distinguish between
> passthorugh, onevf and mutivf usecase.
> A unified approach is needed.
>
> =3D=3D Changes =3D=3D
> This patch introduces a new mechanizm to distinguish
> ONEVF and PASSTHROUGH use case on sysfs level
> and prohibit setting (writting to sysfs).
> It also applies the new mechanizm on pp_dpm_sclk sysfs file.
>
> =3D=3D Test =3D=3D
> Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.
> Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:
> "calling process does not have sufficient permission to execute a command=
".
> Sysfs pp_dpm_sclk will not be created in MULTIVF mode.
>
> Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 082539c70fd4..d2b168babc7d 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_devic=
e *adev,
> struct amdgpu_device_
>               }
>       }
>
> +     /* security: setting should not be allowed from VF */
> +     if (amdgpu_sriov_vf(adev)) {

You should be checking for pp_dpm_sclk here, for example:
                if (DEVICE_ATTR_IS(pp_dpm_sclk) {

Otherwise I am pretty sure you're setting this for every single file. And i=
s it only sclk? Or does it also need to affect mclk/fclk/etc? If it's only =
sclk, the line above should help. If it's for more, then the commit should =
try to clarify that as it's not 100% clear.

 Kent

> +             dev_attr->attr.mode &=3D ~S_IWUGO;
> +             dev_attr->store =3D NULL;
> +     }
> +
>  #undef DEVICE_ATTR_IS
>
>       return 0;
> --
> 2.20.1


--_000_DM6PR12MB4300DD7B8B8F194198F7D6E78E7C9DM6PR12MB4300namp_
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
From 06359f3be0c0b889519d6dd954fb11f31e9a15e0 Mon Sep 17 00:00:00 2001
<div>From: Marina Nikolic &lt;Marina.Nikolic@amd.com&gt;</div>
<div>Date: Tue, 14 Dec 2021 20:57:53 +0800</div>
<div>Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read=
</div>
<div>&nbsp;permission in ONEVF mode</div>
<div><br>
</div>
<div>=3D=3D Description =3D=3D</div>
<div>Setting through sysfs should not be allowed in SRIOV mode.</div>
<div>These calls will not be processed by FW anyway,</div>
<div>but error handling on sysfs level should be improved.</div>
<div><br>
</div>
<div>=3D=3D Changes =3D=3D</div>
<div>This patch prohibits performing of all set commands</div>
<div>in SRIOV mode on sysfs level.</div>
<div>It offers better error handling as calls that are</div>
<div>not allowed will not be propagated further.</div>
<div><br>
</div>
<div>=3D=3D Test =3D=3D</div>
<div>Writing to any sysfs file in passthrough mode will succeed.</div>
<div>Writing to any sysfs file in ONEVF mode will yield error:</div>
<div>&quot;calling process does not have sufficient permission to execute a=
 command&quot;.</div>
<div><br>
</div>
<div>Signed-off-by: Marina Nikolic &lt;Marina.Nikolic@amd.com&gt;</div>
<div>---</div>
<div>&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++</div>
<div>&nbsp;1 file changed, 6 insertions(+)</div>
<div><br>
</div>
<div>diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/=
pm/amdgpu_pm.c</div>
<div>index 082539c70fd4..c43818cd02aa 100644</div>
<div>--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c</div>
<div>+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c</div>
<div>@@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_de=
vice *adev, struct amdgpu_device_</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; }</div>
<div><br>
</div>
<div>+ &nbsp; &nbsp; &nbsp; /* setting should not be allowed from VF */</di=
v>
<div>+ &nbsp; &nbsp; &nbsp; if (amdgpu_sriov_vf(adev)) {</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_attr-&gt;attr.m=
ode &amp;=3D ~S_IWUGO;</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_attr-&gt;store =
=3D NULL;</div>
<div>+ &nbsp; &nbsp; &nbsp; }</div>
<div>+</div>
<div>&nbsp;#undef DEVICE_ATTR_IS</div>
<div><br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; return 0;</div>
<div>--</div>
<div>2.20.1</div>
<span></span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nikolic, Marina &lt;M=
arina.Nikolic@amd.com&gt;<br>
<b>Sent:</b> Tuesday, December 21, 2021 3:15 PM<br>
<b>To:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Mitrovic, Milan &lt;Milan.Mitrovic@amd.com&gt;; Kitchen, Greg &l=
t;Greg.Kitchen@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have onl=
y read premission in ONEVF mode</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Hi Kent,&nbsp;</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Thank you for the review. Yes, I can confirm I am trying to set this for ev=
ery single file for SRIOV mode.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<a id=3D"OWAAM749892" class=3D"x_J9Y1oNF3ZpoR5LC3M2PHm x_mention x_ms-bgc-n=
lr x_ms-fcl-b" href=3D"mailto:Greg.Kitchen@amd.com">@Kitchen, Greg</a>&nbsp=
;required this for ROCM-SMI 5.0 release. In case you need it, he can provid=
e more details.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
I'm going to clarify commit message more and send a new patch.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
BR,<br>
Marina</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Russell, Kent &lt;K=
ent.Russell@amd.com&gt;<br>
<b>Sent:</b> Monday, December 20, 2021 8:01 PM<br>
<b>To:</b> Nikolic, Marina &lt;Marina.Nikolic@amd.com&gt;; amd-gfx@lists.fr=
eedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Mitrovic, Milan &lt;Milan.Mitrovic@amd.com&gt;; Nikolic, Marina =
&lt;Marina.Nikolic@amd.com&gt;; Kitchen, Greg &lt;Greg.Kitchen@amd.com&gt;<=
br>
<b>Subject:</b> RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have onl=
y read premission in ONEVF mode</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font face=3D"Times New Roman" size=3D"3"><sp=
an style=3D"font-size:12pt"><a name=3D"x_BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt">[AMD Official Use Only=
]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of Marina Nikolic<br>
&gt; Sent: Monday, December 20, 2021 11:09 AM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Mitrovic, Milan &lt;Milan.Mitrovic@amd.com&gt;; Nikolic, Marina<br=
>
&gt; &lt;Marina.Nikolic@amd.com&gt;; Kitchen, Greg &lt;Greg.Kitchen@amd.com=
&gt;<br>
&gt; Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read=
 premission in<br>
&gt; ONEVF mode<br>
&gt;<br>
&gt; =3D=3D Description =3D=3D<br>
&gt; Due to security reasons setting through sysfs<br>
&gt; should only be allowed in passthrough mode.<br>
&gt; Options that are not mapped as SMU messages<br>
&gt; do not have any mechanizm to distinguish between<br>
&gt; passthorugh, onevf and mutivf usecase.<br>
&gt; A unified approach is needed.<br>
&gt;<br>
&gt; =3D=3D Changes =3D=3D<br>
&gt; This patch introduces a new mechanizm to distinguish<br>
&gt; ONEVF and PASSTHROUGH use case on sysfs level<br>
&gt; and prohibit setting (writting to sysfs).<br>
&gt; It also applies the new mechanizm on pp_dpm_sclk sysfs file.<br>
&gt;<br>
&gt; =3D=3D Test =3D=3D<br>
&gt; Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.<br=
>
&gt; Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:<br>
&gt; &quot;calling process does not have sufficient permission to execute a=
 command&quot;.<br>
&gt; Sysfs pp_dpm_sclk will not be created in MULTIVF mode.<br>
&gt;<br>
&gt; Signed-off-by: Marina Nikolic &lt;Marina.Nikolic@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++<br>
&gt;&nbsp; 1 file changed, 6 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; index 082539c70fd4..d2b168babc7d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; @@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_de=
vice *adev,<br>
&gt; struct amdgpu_device_<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* security: setting should not be allowed f=
rom VF */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
<br>
You should be checking for pp_dpm_sclk here, for example:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (DEVICE_ATTR_IS(pp_dpm_sclk) {<br>
<br>
Otherwise I am pretty sure you're setting this for every single file. And i=
s it only sclk? Or does it also need to affect mclk/fclk/etc? If it's only =
sclk, the line above should help. If it's for more, then the commit should =
try to clarify that as it's not
 100% clear.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_attr-&gt;attr.mode &amp;=3D ~S_IWUGO;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_attr-&gt;store =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp; #undef DEVICE_ATTR_IS<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; --<br>
&gt; 2.20.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB4300DD7B8B8F194198F7D6E78E7C9DM6PR12MB4300namp_--
