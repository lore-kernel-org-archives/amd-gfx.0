Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FCFC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 09:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F69561130
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 09:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F69561130
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3592E6E197;
	Mon,  4 Oct 2021 09:42:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF766E197
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 09:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRQ1DdrxxKt5SUzkUZhzrhGD5XY+m3LyHeeOvxLwSL/7WRsAVteQ74Enpd4+3q8iSc7JK3KzUs5LvhSAYPNxppDw3+NDY3X7fzpImKKtzB1fU/52PiajpHTIEVcIHTUqMfcvuAjBh1K7WHMMLAcVVWGMMI5gREjzZ405HOtpj01pEXJMRXlVU+Q8AR5nMYQtl4UiXFcxdok8c1qCZ4fb2Uwi4GOz+P8jL0L8W6ksQINQ+wJS0fBYjErRamODRSDFqCXt01oF6ljGLjHYD3r68R5iNwdnAS77c7oTUpCuH7Ey+1rVItRFrh6dhYANkG0fByVwdNR+Lw2Y/E90jktfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkR73CVS4F/dHwEZf5Zx7Rb/6rExzxn3KZiD4fcdGI0=;
 b=ezf3PZYBsUNEg8W1JI1ERrXZQKGua8rilEKXYih34i3RpqOuHsomaYPcFiWHm18bRsNTJKQ3itbZddn3r/N93IbaAa2fegv9zhY2EacnmmMKvlnWFcT+TSbE+1Fc0f1ulzsVXYA5g86YC6aLZxrVkJ8HvW533VVjKSzSY4Aq4GyMzNET1kSf3DLtCdtkYbFjE3C6zZZxeYTnPrSSby2YMczSNxIAjT03giiN/egzgZUwubfhoOvBwIgZIB+gBF7fRG3ItDINjNMtfwuSYMpQkd2mAX4CHSIPM6P1/hYbSob3Bfo4Wtpr+fQ5RP0Gig6adzChzZga6UZpBHSqM0pKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkR73CVS4F/dHwEZf5Zx7Rb/6rExzxn3KZiD4fcdGI0=;
 b=bBpSNxHtqZLGuh0EM0goA40xDPXYNzxTihYDXJOOZPAxf8LsFG+Y763hyaUj2W1TeLNH8t/Nyg0/y/ukS1BzfoYLuDVGnR3VPp7+QqlF+XJzW3eSBLQdtod5TwSgtwH51jMxfbW3iqI3GWs3KTX9RvbhP6Lb+Dv/jJqVcsHTtMY=
Received: from BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19)
 by BN6PR1201MB0017.namprd12.prod.outlook.com (2603:10b6:405:53::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Mon, 4 Oct
 2021 09:42:29 +0000
Received: from BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::84b6:69c0:9fb7:cd1d]) by BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::84b6:69c0:9fb7:cd1d%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 09:42:28 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
Thread-Topic: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
Thread-Index: AQHXtELZo07wLtaE6kqRLoUB3h9VLqu5ljSAgAFqRICAB5x5QA==
Date: Mon, 4 Oct 2021 09:42:28 +0000
Message-ID: <BN6PR12MB11875C3AC679F399E01C5D12C1AE9@BN6PR12MB1187.namprd12.prod.outlook.com>
References: <20210928082819.205231-1-yifan1.zhang@amd.com>
 <20210928082819.205231-2-yifan1.zhang@amd.com>
 <11cc6ad8-5c08-6846-930b-f935c1e29936@amd.com>
 <DM5PR12MB18849F60DEE73D7FB8E20017E4A99@DM5PR12MB1884.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB18849F60DEE73D7FB8E20017E4A99@DM5PR12MB1884.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-04T09:42:25Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63186d20-0e43-456f-73b5-08d9871b47dc
x-ms-traffictypediagnostic: BN6PR1201MB0017:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1201MB00172AE0DDC9EC72903CD0BCC1AE9@BN6PR1201MB0017.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qX+OzjPwT2suxkBEEp5mLI3gehAW9Ybgo+tDuMghHR7jbVWmrNv6qZZS+d/yI6REkuaXrdfXCrFKinDpw+XuvWSWjB3uHAvUcsLXTrzRBTlYzuRcztU8I7bXNyaJQbAl25jFJeele3QExS8QZ14bmJbxQAW6CDu/Uci5MHJYIjLC6m0/kmwIs4k3jdQLTKs25oAfElUpcvCsKrTSc4SRgj4yWTKcPg1mUQsj7CggDOzzcdAD3pCy7PIi7iD3Aw3JIQQHqXE2QU9F+jMnZFfUeO+tFRierhEzSbEeOEj7/tbtW3llR0tRPnVGk43II6WMTOTTLUL2TTxXWM08dA9GmQyKf1GYjXGmHbDwYG2AU3Iizo7ef64n4e37NbbjUAXhHt/z+dFpK2sfxqcmS6JlQnbKOk+bA7w2p2Wcy1Gd3Ggc19ZZIYQH0fL950uMU4d7uPo8gBDSMUmkkwjPj5qphPqJcXA3oz9NlwbUuMx3BV6rPb3O8lO9k+sY7oZBXuDRLif2U2XAenVZOnKo4nvi1lKYHpogPnb22o9ZC2GWrx6MHws9yb4BUHrQIXkxLgexX4wlzDmB6B0VWK61TPascaqRek2NFiB2sCo34agAywLktdTi7a0/4VqygHZMhLK4p/Lnyt8zWek86x/WMyafzxkgwxQrGhZ3ghCXIJREERfKFwEpHzPV3EPk2rNeSpuLirZvGzWabKF6I/m4yrHMxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1187.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(52536014)(66946007)(76116006)(2906002)(71200400001)(83380400001)(64756008)(66556008)(66476007)(122000001)(38070700005)(8676002)(508600001)(38100700002)(110136005)(9686003)(55016002)(316002)(66446008)(5660300002)(7696005)(86362001)(33656002)(53546011)(6506007)(26005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Saa5ig9Vjb7JYuhA7WHfv0EfjWTRmyWwLaUIVvQBhSdV/jP9HyWHbG9jEG6i?=
 =?us-ascii?Q?g+UAOIRP7p/ZR3cjVlT5OybioL8j2n/Elq4qZVuJTnwh4nu1zvt4wG2r9f6F?=
 =?us-ascii?Q?8zPVBoyDesW3WDPmVm6dektPUuWG0UOIwg10KllY7bygnjylaySQ6Ex/wtyu?=
 =?us-ascii?Q?d3WIWIpc5RmVEbJsPV2Vx/XNdtQftyKwWXrKAzT9K+8PZXvoAlreqArI+uvT?=
 =?us-ascii?Q?kSlTMDehYeIg5X6XF/X4PDCzjE5mnwyGmB18iLDswMnNVzZh9laIKFC4bVB+?=
 =?us-ascii?Q?Gq9EIKZg+fAT1wULUI17rBI19ZgJSHnpeKrSd4NnniuOMY6VWOHh+Nq0yhDE?=
 =?us-ascii?Q?7XBCZC4onS9N6VVtkY9XvDCtey2RM4I1nXwZgFg6TnTnT45opviGk2jVxB/S?=
 =?us-ascii?Q?xk9gU+iHJSKFl0+b9l8xJIJ2kQZMjmQHU7oKRKYtQbjnkM43rYOOoyfBSEpU?=
 =?us-ascii?Q?0DT2GpSH1P6klHI3ZRdv5jtDO/ULmreCYkRX/IIFh0akUXxW8PTWSdb4e8Se?=
 =?us-ascii?Q?5UQcU4mdVPfz4ahQ5wj8Dkdfz5rCwEJSh8bxmXU7+PiqtlETxRb8i523srN2?=
 =?us-ascii?Q?7SpjHOGELX8wPSxU+9UD/4DkHrKsqc5mblWMshDJTtqt4FEn01V0pCTQ2Tao?=
 =?us-ascii?Q?HJhHxlfw6ADPZewu5/45fmk1r8JwsG4/X32E2SJFnsgvjOkRCB5bHzg0qH8j?=
 =?us-ascii?Q?Usqve5Cc1m+OaCOTU7c83sMWtTCPz7CwhWMDXtFT5oErsKOIFWiwzkP7zSbD?=
 =?us-ascii?Q?y9nM4Zu923VFksP5Co7jw+DS7wi8gicIfkyD+mI3qRHx3/8hR/vma8x/iv75?=
 =?us-ascii?Q?SKLKCKB1sa73S5p+4JumkS7vsDiju851y3F7XRw+GQpdDfaOgPcnGGd3YohG?=
 =?us-ascii?Q?12Vo6zUovwjlT6O+WEGI0xtvrwFQENQgn4tcceGItYhEwQl6zUE5Qzd6yuTM?=
 =?us-ascii?Q?VBpJfhCFwKjbytmhFLY2+lxns2n8IfhW6WIt+ejOKAn5ud05drhh4e/Q44YC?=
 =?us-ascii?Q?psLU494zFO4unsBy13tMeSjk3acct5Tnzmq7YYHCFse0uprkP6GH1qGNTHbL?=
 =?us-ascii?Q?d2PzSk9V+RjS1qBJY06iNxU6QpliWU423lldG5TN/zSFALgpTacPCYBSiEmr?=
 =?us-ascii?Q?jYqdBB45j7p/vug5M6JYNN2M9ZEc8M8JFMzPaERdYWz5ZkNeXXAVUM80DFMZ?=
 =?us-ascii?Q?WwJxb2rkBGVIqj+8LWj7+jxoEpPUqv0/BPnfk1gxqxytwBaVO7lkmsIHe1AK?=
 =?us-ascii?Q?/tvrc6cJLeI3boFuZVK9TW2GprnKZMYkBxmFEmAHDr7mS3BJLIUs+yXSGFVH?=
 =?us-ascii?Q?LTpZG/yYDRCy4noPyjplmwtp?=
Content-Type: multipart/alternative;
 boundary="_000_BN6PR12MB11875C3AC679F399E01C5D12C1AE9BN6PR12MB1187namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63186d20-0e43-456f-73b5-08d9871b47dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 09:42:28.7293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzRD/6BMjV073i0mZaaEVdhmP51zD9u3rTZuay9gRNqyzzlQDay5vQOT7J3tc31K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0017
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

--_000_BN6PR12MB11875C3AC679F399E01C5D12C1AE9BN6PR12MB1187namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Felix,

After sync w/ James, we agree that this patch series could fix both our pro=
blems, and he verified this patch series will not cause regression of his p=
revious issue. Do you have more comments regarding this patch series ? Than=
ks.

BRs,
Yifan

From: Zhu, James <James.Zhu@amd.com>
Sent: Wednesday, September 29, 2021 9:19 PM
To: Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Yifan <Yifan1.Zhang@am=
d.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init


[AMD Official Use Only]

H Felix,

Since the previous patch can help on PCO suspend/resume hung issue. Let me =
work with YiFan to see if
there is proper way to cover both cases.


Thanks & Best Regards!



James Zhu

________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com=
>>
Sent: Tuesday, September 28, 2021 11:41 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com<mailto:Yifan1.Zhang@amd.com>>; amd-g=
fx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lis=
ts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Zhu, James <Jame=
s.Zhu@amd.com<mailto:James.Zhu@amd.com>>
Subject: Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init

[+James]

This basically undoes James's change "drm/amdgpu: move iommu_resume
before ip init/resume". I assume James made his change for a reason. Can
you please discuss the issue with him and determine a solution that
solves both your problem and his?

If James' patch series was a mistake, I'd prefer to revert his patches,
because his patches complicated the initialization sequence and exposed
the iommu init sequence in amdgpu.

Thanks,
  Felix


Am 2021-09-28 um 4:28 a.m. schrieb Yifan Zhang:
> This patch is to fix clinfo failure in Raven/Picasso:
>
> Number of platforms: 1
>   Platform Profile: FULL_PROFILE
>   Platform Version: OpenCL 2.2 AMD-APP (3364.0)
>   Platform Name: AMD Accelerated Parallel Processing
>   Platform Vendor: Advanced Micro Devices, Inc.
>   Platform Extensions: cl_khr_icd cl_amd_event_callback
>
>   Platform Name: AMD Accelerated Parallel Processing Number of devices: 0
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com<mailto:yifan1.zhang@amd.=
com>>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 4c8f2f4647c0..89ed9b091386 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2393,10 +2393,6 @@ static int amdgpu_device_ip_init(struct amdgpu_dev=
ice *adev)
>        if (r)
>                goto init_failed;
>
> -     r =3D amdgpu_amdkfd_resume_iommu(adev);
> -     if (r)
> -             goto init_failed;
> -
>        r =3D amdgpu_device_ip_hw_init_phase1(adev);
>        if (r)
>                goto init_failed;
> @@ -2435,6 +2431,10 @@ static int amdgpu_device_ip_init(struct amdgpu_dev=
ice *adev)
>        if (!adev->gmc.xgmi.pending_reset)
>                amdgpu_amdkfd_device_init(adev);
>
> +     r =3D amdgpu_amdkfd_resume_iommu(adev);
> +     if (r)
> +             goto init_failed;
> +
>        amdgpu_fru_get_product_info(adev);
>
>  init_failed:

--_000_BN6PR12MB11875C3AC679F399E01C5D12C1AE9BN6PR12MB1187namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader9f8d35bc, li.msipheader9f8d35bc, div.msipheader9f8d35bc
	{mso-style-name:msipheader9f8d35bc;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheader9f8d35bc" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Felix,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">After sync w/ James, we agree that this patch series=
 could fix both our problems, and he verified this patch series will not ca=
use regression of his previous issue. Do you have more comments regarding t=
his patch series ? Thanks.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BRs,<o:p></o:p></p>
<p class=3D"MsoNormal">Yifan<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhu, James &lt;James.Zhu@amd.com&gt; <b=
r>
<b>Sent:</b> Wednesday, September 29, 2021 9:19 PM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Zhang, Yifan &lt=
;Yifan1.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device =
init<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">H Felix=
,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Since t=
he previous patch can help on PCO suspend/resume hung issue. Let me work wi=
th YiFan to see if<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">there i=
s proper way to cover both cases.<o:p></o:p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">Thanks &amp; Best Regards!<=
o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">James Zhu<o:p></o:p></span>=
</p>
</div>
</div>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehlin=
g@amd.com">Felix.Kuehling@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, September 28, 2021 11:41 AM<br>
<b>To:</b> Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com">Yifan1.=
Zhang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;; Zhu, James &lt;<a href=3D"mailto:James.Zhu@amd.com=
">James.Zhu@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device =
init</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[+James]<br>
<br>
This basically undoes James's change &quot;drm/amdgpu: move iommu_resume<br=
>
before ip init/resume&quot;. I assume James made his change for a reason. C=
an<br>
you please discuss the issue with him and determine a solution that<br>
solves both your problem and his?<br>
<br>
If James' patch series was a mistake, I'd prefer to revert his patches,<br>
because his patches complicated the initialization sequence and exposed<br>
the iommu init sequence in amdgpu.<br>
<br>
Thanks,<br>
&nbsp; Felix<br>
<br>
<br>
Am 2021-09-28 um 4:28 a.m. schrieb Yifan Zhang:<br>
&gt; This patch is to fix clinfo failure in Raven/Picasso:<br>
&gt;<br>
&gt; Number of platforms: 1<br>
&gt;&nbsp;&nbsp; Platform Profile: FULL_PROFILE<br>
&gt;&nbsp;&nbsp; Platform Version: OpenCL 2.2 AMD-APP (3364.0)<br>
&gt;&nbsp;&nbsp; Platform Name: AMD Accelerated Parallel Processing<br>
&gt;&nbsp;&nbsp; Platform Vendor: Advanced Micro Devices, Inc.<br>
&gt;&nbsp;&nbsp; Platform Extensions: cl_khr_icd cl_amd_event_callback<br>
&gt;<br>
&gt;&nbsp;&nbsp; Platform Name: AMD Accelerated Parallel Processing Number =
of devices: 0<br>
&gt;<br>
&gt; Signed-off-by: Yifan Zhang &lt;<a href=3D"mailto:yifan1.zhang@amd.com"=
>yifan1.zhang@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----<br>
&gt;&nbsp; 1 file changed, 4 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 4c8f2f4647c0..89ed9b091386 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -2393,10 +2393,6 @@ static int amdgpu_device_ip_init(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto init_failed;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_amdkfd_resume_iommu(adev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto init_failed;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_ip_hw_in=
it_phase1(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto init_failed;<br>
&gt; @@ -2435,6 +2431,10 @@ static int amdgpu_device_ip_init(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.pendi=
ng_reset)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_device_init(adev);<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_amdkfd_resume_iommu(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto init_failed;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fru_get_product_info(=
adev);<br>
&gt;&nbsp; <br>
&gt;&nbsp; init_failed:<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB11875C3AC679F399E01C5D12C1AE9BN6PR12MB1187namp_--
