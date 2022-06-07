Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3D5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 14:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EC4F10E07A;
	Tue,  7 Jun 2022 14:50:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83EB910E07A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 14:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCoua2mszs1E6ROhYOgVOsiOVC5j9U0Ws8L+Gy7MxkjWUPU/dqEqcCx4ADSb3AhR++Wb2o8M/5Lhz3fH4KkcVngFsg/QD/Sev/VvdW4QFFW9ckqkCyo855X16Ov3vbwnxd7ZCbUQ0Eyp5VT+kEj5gRmk2921Md9fP9qv2WWf2vy//+RzIcukQRAeTc0d36z38PDUxmGf21a0AYfYjC+Y0jbCFQ1CF1gFzRpkTVxBMGyqgGqmLg1DASvliLkx9qBanzt9EbJ3i1C4MiAsnn1fkapoZlAmGzSy/nbuaVMwm5kh2cYHJCUxzhObxT5t0EertEz2olFM2OFA/EobW1mzSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3o9TwYylbcF044kPIII8cYcpkPeyN2FemQ+doXdPo80=;
 b=cwqm+1nvB4y58d6UD4ghEiIxNkCMbYLFHocQFaO7d8t3Zqt4i98ehWOSWFxeAax6UvoIrn/JMcsGiZsJ2UCjsH28/YXzKXEDXcMK9HXGXzH4fpr3U/8UP4s53Jrs1RZHSud8EKI61JjT/duEVP6EIVY4RigGucpZ1VcZtydW+r5LxOLLYxXMXVs3YNqfGv3jHyxvwdM775PTjMVuTYAd0UspfxRfasii9901IbdTDX9ED95F4Wq8p8TF5rHhpb5y/QGeN2BtFswURPBC8JN9skFXH+5DqCNcfK7vRXbSN26uKIPGOUA/f/reY/jBCPSKM5PHy+MuxAWRbWOG7DqhpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3o9TwYylbcF044kPIII8cYcpkPeyN2FemQ+doXdPo80=;
 b=MfBh/UI/FlpezOQHEk7dB8sy1K+VWBpSrAZ3yKL92XuyiqcCOjb7FruIH7yusauyqRpt8qIWoKj0y7FCQQaQI2J+PYSaBdgmvWVZTMy0XkdNr3NfTgaUFMOz0dapnZf99xbFiF7efj40pJZMO2Lw24xHviRwVPoJNpovPpb4yyU=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB3546.namprd12.prod.outlook.com (2603:10b6:5:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 14:50:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 14:50:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Add fw version for 10.3.6
Thread-Topic: [PATCH] drm/amdkfd: Add fw version for 10.3.6
Thread-Index: Adh6GnCehdqG02mRTeC6U2QKMn0rNAAY2c86
Date: Tue, 7 Jun 2022 14:50:15 +0000
Message-ID: <BL1PR12MB514463378545DC24A38DA345F7A59@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <DM4PR12MB5152E4FE7DB27155C242620BE3A59@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152E4FE7DB27155C242620BE3A59@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-07T14:50:14.613Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5840489-2c1d-417b-6249-08da48950834
x-ms-traffictypediagnostic: DM6PR12MB3546:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3546F965465AB3DA33B18221F7A59@DM6PR12MB3546.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XjbLjNlRrdz/s06cOIeCaa8giBIF6/Na569V17uy+6UoXvoic0zRDUACfK9A00Ff/aNNUbE319RzROJVHr6onsPtzUOFRhoM92A23HMW6GX9T5+M5ITURbtit4+dCsVJaZ3hLo4qupnzydYadmtxLn5gh8YK80DK4o30LXOLVOcQSe8x6WPtsBcqB2s16Wa0MTraDERxQIgoE9PLAraejbnciXGiXZ3e/9Shvz4YhikE+7t/nPugxL6pKHOZcN1TvMjzzDLPv8nsg4fkBe4tOS3RMNi+27DSAw6xYWT/nd0tYdqJLp/l7tnTRqfsnpqGNVUwHi8GEVt1SF6hcJyhNnB2/bsbQZ6VCgYrxQAUcru6RSaEt4VQ6g5kkqQPpfBpM1kX2WAmIHbYLcx1fx0JFApOg2cAmb6ftdYiTC9IFvhQeTh/yJ8dpwwYS/eBjVyxbWtMJSUFyLK3i3MnF887qndzDugK7p90l5LE0M0rxjUrEVVtfk3uCxZIN8oOeMP+MPXMrYs0KIJUNL9dIOFv1uGmfyRdqyor1CJvrYCRAQBLqQJsV26IukUWpio37t3Tue6p87Kxh3xRN1a6ifE21i0bQ1Oe12BOIH7V0zec+6HGQZXxdacCt5ZAynnrrLl121ldIFO9H9NWapctafp/xqJZRYCG3YbSN0Rx5NSfGOkSaznVQLHvv4qSGg7zbvUUwearo1TpThultIrKtqngVA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7696005)(6506007)(71200400001)(54906003)(76116006)(66946007)(8936002)(5660300002)(66556008)(508600001)(52536014)(186003)(64756008)(110136005)(4326008)(8676002)(66446008)(66476007)(38100700002)(26005)(55016003)(19627405001)(53546011)(33656002)(2906002)(122000001)(316002)(83380400001)(86362001)(19627235002)(9686003)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zokzmF1RvQZRNcNmZXQLp6zaqR2wjxn1WrpTUabX5ptXPKNrvpYmvnYVVzg5?=
 =?us-ascii?Q?Rmlv56z4jpUsEWPEUySNk22VL5eho/bWGFziBZDjtGwBLVFoGEkbhhsRSGbY?=
 =?us-ascii?Q?pBi27+pY0ot+4vh7nRfQmxHkuy/kaLZAh/3XFzVOpkT0sls/F/d6We+uoJoc?=
 =?us-ascii?Q?B/f+cmyNpH5ETtj+iiqXqEWNJ4smPxbgh0YM8rvfdU4uTWwZoe+YbxwFZiLP?=
 =?us-ascii?Q?WxFSpB2n8lXoGXIbq7GpaHmP8RMVm7/4kZyLoxlnYza6RAQXcpUjQRpSGRHE?=
 =?us-ascii?Q?D0GlDQn6M0TBB6elrun5e4NXz0ffsCqZ2yxc28SJEOdbgqTm8i299hGAWNG3?=
 =?us-ascii?Q?RIQxBLXfgLJ9eTgpencNWBPbr0IjoAzja8pXvUd0ffQpveTsAPJDMrGO0Gb2?=
 =?us-ascii?Q?qkBDzPR6Z99fC0fGM4UcCSM88SlCuLnhmxIK7gxhD0+W3XK63BIpPxWiu2z+?=
 =?us-ascii?Q?Unz/Ft4+6/o37dqJlsul2imtDzmtOD6gbWnB74jhFHFVCm6s0k01ncVDkv2+?=
 =?us-ascii?Q?xdcPvxE1PkS1QUbMs6zVw9ImEaT/xtOpClVz3mQ/wS49KrwhGCz91Vt2Nyk6?=
 =?us-ascii?Q?cQWAjsvQ287PnSuZPRRgV6Z7ZLn8YY5S2n1C7cKjdtFuXsy76kQNJWkbykgG?=
 =?us-ascii?Q?EfEUMK6o7Znol6HupsuIBDtfhrWbBr/2hLc2O3q+5AGmFyO3mLmXRT6HBqLt?=
 =?us-ascii?Q?SvGD63jJMa1CNhZcU46dM+7sOxBrJ1XcjPtxbZbW91R5nso90x/6aG2eDTGi?=
 =?us-ascii?Q?XDPqFIyUzGaY364vKMokH2AWCQCr3XzR5nUby2LTJfnZPgYhaOakw6CGpy1r?=
 =?us-ascii?Q?qzPM+/fL5ATtCV2lBrPMX+KIZLKmsrxROACSeAGFz1r9UUrSrJf5nb77D+nZ?=
 =?us-ascii?Q?ZqAOq1wIaYdbZSgh6nv8rGxedQYbUVviCEaRp0//69VGS9UXQs8l14zKzGou?=
 =?us-ascii?Q?JA2ob+ibzKYyWrH7d39ujXSBez/MX48cpTe4uulIgV3YkUVIdCjNkoPr18uY?=
 =?us-ascii?Q?TbyQMWD6Y3HKB3wtGNClUmr4sEkD90lskaWfQDY9m7v7b+UOB4n7cZpMZ73Q?=
 =?us-ascii?Q?zRK7gvYDjeNgUvh901g4qFdbFtfU/3ySHUNFUHgVl43+pEuHMAOICfeMaghh?=
 =?us-ascii?Q?HR0JH/UpLc+5oVH5UVIYAKUxkWZbNG5f47x02HE2GwPLlnNM93/zEoi8DUHf?=
 =?us-ascii?Q?EzwwatRqQw7Ca147gdAjaIwPzh5YnqZvbI+re7WWOb+0lQZqlqkhOtjfV/Gj?=
 =?us-ascii?Q?8294NKWlt5O2n5CUZ2UVcc7UUsCuywl+ybdXD+u15Y7MLcYhP13IiHF6Fx1r?=
 =?us-ascii?Q?Kl7x1PMHRdShpf158/CfspnJbHwqD20dwmVr8HJjJQOgfBCtr6JyeZ2vQ52n?=
 =?us-ascii?Q?JkcNL8Hy7eDEEocBg1cxWyt+2jyv8xPJhDX2XqG5jAL49e1B5L7EJ/TuLxbb?=
 =?us-ascii?Q?ZpNw85/a3n7N1DtBTOk8zI8s5KLqLhXSZYmPQwto5VVTpb0tw/tZBtayJtgI?=
 =?us-ascii?Q?uoklnvRXFTZA8tZIavssLnFPqxasGZx8emolY/2ziLGSSE2N7UTmgdqNt9BV?=
 =?us-ascii?Q?Qwkzkto7K42APeqRSd9VyvRmfrPuLnWny0UWqLIksYJSTaS+vUPLxD5WNDd7?=
 =?us-ascii?Q?TyP+ff8NYKn1N6QEDXtpwa3Fh9R5XMCuxMuYCZ15I9bTzIFKK/RM3rpcXYgh?=
 =?us-ascii?Q?Ee+P+gKXaRaR2b7G3F9mrdg4BEc2wdJdyxs5Onwh1O1d560ph2dQ7iojDxlD?=
 =?us-ascii?Q?hXP8hUC/5g=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514463378545DC24A38DA345F7A59BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5840489-2c1d-417b-6249-08da48950834
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 14:50:15.0699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVLg8YR7t3ok6XTtqt0KnBqSi+2ULpl/sPNonfkcrr2K2fUD2CzLKS/6WW8mgM2Z84t4VgSmDO+vsxVgsNcjQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3546
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Chang, David" <David.Chang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514463378545DC24A38DA345F7A59BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Does this need an update for GC 10.3.7 as well?

Alex

________________________________
From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Sent: Monday, June 6, 2022 11:20 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario <Mar=
io.Limonciello@amd.com>; Chang, David <David.Chang@amd.com>; Kuehling, Feli=
x <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Add fw version for 10.3.6


[AMD Official Use Only - General]


It will happed error on loading firmware.   we need add firmware version in=
formation.



[  309.650118] [drm] kiq ring mec 2 pipe 1 q 0

[  309.652595] [drm] VCN decode and encode initialized successfully(under D=
PG Mode).

[  309.653402] kfd kfd: amdgpu: skipped device 1002:164e, PCI rejects atomi=
cs 18<92





Signed-off-by: Jesse Zhang Jesse.Zhang@amd.com<mailto:Jesse.Zhang@amd.com>



    Reviewed-by: Alex Deucher alexander.deucher@amd.com<mailto:alexander.de=
ucher@amd.com>



    Reviewed-by: Mario Limonciello mario.limonciello@amd.com<mailto:mario.l=
imonciello@amd.com>



    Reviewed-by: Felix Kuehling Felix.Kuehling@amd.com<mailto:Felix.Kuehlin=
g@amd.com>

    Change-Id: I9c8d70071efdfce85c860ebf19690d52fb8d2383



diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c

index f8635e768513..bf4200457772 100644

--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c

+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c

@@ -182,7 +182,9 @@ static void kfd_device_info_init(struct kfd_dev *kfd,



                if (gc_version < IP_VERSION(11, 0, 0)) {

                        /* Navi2x+, Navi1x+ */

-                       if (gc_version >=3D IP_VERSION(10, 3, 0))

+                       if (gc_version =3D=3D IP_VERSION(10, 3, 6))

+                               kfd->device_info.no_atomic_fw_version =3D 1=
4;

+                       else if (gc_version >=3D IP_VERSION(10, 3, 0))

                                kfd->device_info.no_atomic_fw_version =3D 9=
2;

                        else if (gc_version >=3D IP_VERSION(10, 1, 1))

                                kfd->device_info.no_atomic_fw_version =3D 1=
45;





--_000_BL1PR12MB514463378545DC24A38DA345F7A59BL1PR12MB5144namp_
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
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Does this need an update for GC 10.3.7 as well?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Jesse(Jie) &lt=
;Jesse.Zhang@amd.com&gt;<br>
<b>Sent:</b> Monday, June 6, 2022 11:20 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Limonciell=
o, Mario &lt;Mario.Limonciello@amd.com&gt;; Chang, David &lt;David.Chang@am=
d.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Add fw version for 10.3.6</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
span.x_EmailStyle17
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-family:"Calibri",sans-serif}
@page WordSection1
	{margin:72.0pt 72.0pt 72.0pt 72.0pt}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:b=
reak-word">
<p class=3D"x_msipheaderdf3d92d6" align=3D"Left" style=3D"margin:0"><span s=
tyle=3D"font-size:10.0pt; font-family:Arial; color:#0000FF">[AMD Official U=
se Only - General]</span></p>
<br>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">It will happed error on loading firmware. &nbsp;&n=
bsp;we need add firmware version information.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">[&nbsp; 309.650118] [drm] kiq ring mec 2 pipe 1 q =
0</p>
<p class=3D"x_MsoNormal">[&nbsp; 309.652595] [drm] VCN decode and encode in=
itialized successfully(under DPG Mode).</p>
<p class=3D"x_MsoNormal">[&nbsp; 309.653402] kfd kfd: amdgpu: skipped devic=
e 1002:164e, PCI rejects atomics 18&lt;92</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Signed-off-by: Jesse Zhang <a href=3D"mailto:Jesse=
.Zhang@amd.com">
Jesse.Zhang@amd.com</a></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp; Reviewed-by: Alex Deucher <a hr=
ef=3D"mailto:alexander.deucher@amd.com">
alexander.deucher@amd.com</a></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp; Reviewed-by: Mario Limonciello =
<a href=3D"mailto:mario.limonciello@amd.com">
mario.limonciello@amd.com</a></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp; Reviewed-by: Felix Kuehling <a =
href=3D"mailto:Felix.Kuehling@amd.com">
Felix.Kuehling@amd.com</a></p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp; Change-Id: I9c8d70071efdfce85c8=
60ebf19690d52fb8d2383</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device=
.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</p>
<p class=3D"x_MsoNormal">index f8635e768513..bf4200457772 100644</p>
<p class=3D"x_MsoNormal">--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c</p>
<p class=3D"x_MsoNormal">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</p>
<p class=3D"x_MsoNormal">@@ -182,7 +182,9 @@ static void kfd_device_info_in=
it(struct kfd_dev *kfd,</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gc_version &lt; IP_VERSION(11,=
 0, 0)) {</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* Navi2x+, Navi1x+ */</p>
<p class=3D"x_MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (gc_version &gt;=3D IP_VERSION(10, 3, 0))</p>
<p class=3D"x_MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (gc_version =3D=3D IP_VERSION(10, 3, 6))</p>
<p class=3D"x_MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;device_inf=
o.no_atomic_fw_version =3D 14;</p>
<p class=3D"x_MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; else if (gc_version &gt;=3D IP_VERSION(10, 3, 0))</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;devic=
e_info.no_atomic_fw_version =3D 92;</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; else if (gc_version &gt;=3D IP_VERSION(10, 1, 1))</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;devic=
e_info.no_atomic_fw_version =3D 145;</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB514463378545DC24A38DA345F7A59BL1PR12MB5144namp_--
