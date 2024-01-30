Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28001C47DB3
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 01:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2551112C6F;
	Tue, 30 Jan 2024 01:51:07 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E84F5112C6F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 01:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=med1/r9oOtzsNHTfMfEb928zvkedC2kwqeTBbI93RiGkPr9HQrZgLreUSmidnuEetR8E1E/yfx2zfWxc2QbEm8+4iAT7ElFve4VYO3CMHM7xKblPA0eq7KZfByAHYwreDT0GjuygdlTzQ4uV12AgsOnBwDuUy1Jn2Qyvdyo7iCQ22Lv2tQ5cZNW/+50+a80FVmh+5SCa2WHgKRj5TTeT/WvzPVly2i1Ry+41WyoFVkQHpL6HQg1M+gPN+F39xZlDSTQ/mMYCNDP/Ai84JuWwC6ipb6RXjmW/p1fim92+00DcH85dmeCBYQ2Wb8hOXJVB2UJdZ99vxEGFj3cI83ytUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzMuyY/X7VzGcgAod+qNY6uMyNZvmpTaf9Er8sF/tqw=;
 b=fzNDEuytPNxM0mon1N1q/fsy6hNOcPcl/NO4YJlUXrj8rEQtW596zjRCcj6khUC2RjHofCqW5e+VNoDkLDBYa4mSDXnD8xoOLH5lWoSEfRMMhaFGnK1PzslEZCXhAoaZlrJp9Ok3N619hB37+Qne0yWyQXyYVYANC0THAXzPpCsAz8fGQ0YKycO0kbBPVrNXhTbbUZHsk8TSjTY73pJpluUc9N1OYJZJ5rM7trOzm20K1AJJMg/+m531oAiQ9++zNVOdDfyZEheHcXRfUt8gKllHMSZybhhe0iYSVnaBnmXhmlXLwClRp87AC56c3Vp8lw2uN5xLEvO1M9yqOHqcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzMuyY/X7VzGcgAod+qNY6uMyNZvmpTaf9Er8sF/tqw=;
 b=awgu10umSoT47VfMkm+4FRkVZop1i/zts9pbg5NN9eYeyXHt3tm9IV+i4hUdCDjJPRaoQJL7nWljM1FGzLMStGKKXjokdDz5rUjvTA6d/sT3umF9PKrjiQNC3ssXh+b01yEUGcZHjKaqNzn0wo1wV7QCgyhrCZIrPs4J550vDLw=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 01:50:45 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::2481:719a:5a7a:d6ad]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::2481:719a:5a7a:d6ad%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 01:50:45 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove golden setting for gfx 11.5.0
Thread-Topic: [PATCH] drm/amdgpu: remove golden setting for gfx 11.5.0
Thread-Index: AQHaUpKVQSRkw8hqAUGR5QYm2Lwt6LDxl3yw
Date: Tue, 30 Jan 2024 01:50:45 +0000
Message-ID: <MW6PR12MB88988E86CA0A49E7E5D8248DFB7D2@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240129090611.2716545-1-yifan1.zhang@amd.com>
In-Reply-To: <20240129090611.2716545-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9324b9b2-eff4-479d-bb86-169d0527fb84;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-30T01:47:49Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|PH8PR12MB7133:EE_
x-ms-office365-filtering-correlation-id: 683ebfe5-40f8-4792-f7cc-08dc2135e000
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P41VkQUgVyYS6cwY9FkSZjn/BsA5XJnJK22BGi0o80oweQ+5XmvwSqxrdnZOui8zIUzlXh8aBHrPR6qrwMPq1bvO/Y6gFOUIbOwvdUT3ZKyFmKGIgngFk+MbDd6fNB+TEsH/fngDtKp8jWpZLgGzKVsWgnJVLPGJUHs1DlmeCUy+Thf+zKZbhbROkhQfiy+6GH+mLTo14PlVLBLjf9IYo8ajSPp4vi2d8WMhrIXnuoAeETzCjzc/xJdOGRi2Ew+Zx6MPeH4UCHtXifyteeA/FfMpzZLIUdsqwMg/gjFicC3ULFd4UKnuQYuWU4+Vy4aotctdY7IzpEWL5oDl2Kr+pHp78Xo8GykYlFgNsj2+pQo+dg8bAjQUHh+yOpXHOw/BOjLZ9oXTAbE4SO99LqeLHfqUTtVheaGldfjFkwQ3DB/dK1VFi3DeCPLrhvp65WpvY54U3n7+w/p+6xOkHYtsrEk8ctMsZ+AkOEV2TY4g20r4JO9g3TDsn7awp8ap/oRBDv1EGCDjoWQyN3GsYm90ZNmKs9C7z2kVHdlxQEnmZCZUTcbnKxMSXQ9Y3F/A4m3fDyNKwpFVkVkeqCFiHqHA3nNCaFPQzS+jtNkwk9MifIw9BQxKEjKvKNvLSUAgImeW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38070700009)(41300700001)(2906002)(5660300002)(33656002)(66476007)(64756008)(66946007)(66556008)(54906003)(316002)(76116006)(86362001)(110136005)(66446008)(9686003)(83380400001)(6506007)(26005)(38100700002)(55016003)(478600001)(71200400001)(7696005)(8936002)(122000001)(52536014)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?knRSg36Tcq/A/dEL50Jsag7g/Uhld5xPZpCklfD+AkOOU0bpo4I75aUfwSKX?=
 =?us-ascii?Q?L1LkKTo5aoF556FmDj5tOQwqh4m/S0evmdF+v03H9YUDg1wNrJQjiS/C0P3e?=
 =?us-ascii?Q?O2ljfnSWz95/WqGIbMnRCRMElw7mFRfcTCaFrdDFDiWG2tLmttRJCcqNe8Y4?=
 =?us-ascii?Q?f2bclpKMCTJRAjivelOXI7IMyeA0vUKmikFoNeUg+Gl0IuzVBoplO253gGeH?=
 =?us-ascii?Q?Myj24GFYZDVDNkPqNloH6Z24V+V28woG/jSorrUtOAVHCayNaZ3PggHzZnQ4?=
 =?us-ascii?Q?WXhd3UwFeHjjm0/RfkCZ8mCmHaxdXRaYARF/EfzRu7T7zhQvqiZuw4OJ0cU1?=
 =?us-ascii?Q?LWql88dUHtCjnPcWJ1y3MPbv4rTjAHHWHD+BF4eaM/OpxuFF2qUatJ4iQ0f8?=
 =?us-ascii?Q?4XEnNKSJ4kbSXZxy4qa8+MBNKWk2lypS1TQJgY2g6uMer6JKtMJ9ZI+hYndL?=
 =?us-ascii?Q?vOifcgNVZFZwGFH6ScSRt+k+idyEb9K63+vq+o7hV7dHGlHtQwfbSpMqZ3M3?=
 =?us-ascii?Q?hR2prnzUQ4/69s3IBYuyh6DR9cVI/UKiKsMJnqGKG6di2E3zf0ciGNX4wCgo?=
 =?us-ascii?Q?9q/nT3hmTzsUlR+TwlzoYl/qx8/lgsZxmp7heL3nebR/XrHQOK0dObYHSYKA?=
 =?us-ascii?Q?a+8SC6KQx1IPWriKebwoDgZ1wRYYU6bVCICSTCEHZW24XKCcUlbYKVXXQDkt?=
 =?us-ascii?Q?fSygeh4tkBfSTaQPWOMfW5cqX/AidcgbrFm7IfwQmJmczTjzpd7FkyRVSEvn?=
 =?us-ascii?Q?/LEb3eecc9YLGfdmmvL4Rn+t5EZAbxVQiuXjyb563tT6sCht7y8yrSrzZhyi?=
 =?us-ascii?Q?98FhdwUCygonh33Ci6/8+tqhlzk92CfbJZmoXWFTDdprxJ5/WG9c93LyYXxJ?=
 =?us-ascii?Q?bhOSpMl3YJeW1zA0RQosV2WPD5F9eSwG//4EgsyvlaGEtb7/Eq4vJn7pqVxf?=
 =?us-ascii?Q?1tAcmjw6UsCK5ndwIm511zdqJOnYnZtaSMJwOpfLZKbXoixMgQrgpkWUjoqz?=
 =?us-ascii?Q?AaNKCy1kHiMudbJiWSa+KuO7yUXPGwKszbMSCg7zk6WJ1VAka8h+jyAIdltL?=
 =?us-ascii?Q?TcqKBlVmoRqVhTUlDJCdfl3wd9Ze1INYi4AL9uc2xsL2ZBCxglgacduRzlzi?=
 =?us-ascii?Q?fVZce/8Rh20Hw1UD4bN5z8GalMr47vIKPa/jYXpwQRu/dK3z5m1jOf3qcRKW?=
 =?us-ascii?Q?h0zbc2lbsb0nDegbzzhZYZ5DBsLUIT/W8IlMB75xB2FMG9RPf0YsBeeYu3zf?=
 =?us-ascii?Q?iYkfUWG2eMDEY0/gFGtLMDPnEQ70eb9z51b8KQDUPEWHWcAKdHomV4IE5jNA?=
 =?us-ascii?Q?dEaiTV+2KnM46fVsEVnYr7b8QIW8u5RbxFUvIveVdat2spKU3YIehU3buPIf?=
 =?us-ascii?Q?n808eMS6tbyulWUdrVece561xDEXo7fLXghxiBY8y4zYuaz80Rf//rpT1FFG?=
 =?us-ascii?Q?ZLbLGq6QqEWOXSHAAAoCJGv09g2BHyI4x5ZNEh8E8Jv7AUmgMmIuK9j+HgMz?=
 =?us-ascii?Q?3iVNVxGBn/ShLALoa/83V9FV3hh2eTkxIYGeZ+MiiRETduLl4nXC65znX5Ui?=
 =?us-ascii?Q?k/KazNbNl1mfi8gvNS4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683ebfe5-40f8-4792-f7cc-08dc2135e000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 01:50:45.4727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyWcwIVWgzcZ1HHLrvN//FkhSrDxDi+4NIFkw7NbKU4jB4hDZ4KdqWmdCAyAUZafeF8Hj4szj2m1yUyWFOGwLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

>-----Original Message-----
>From: Zhang, Yifan <Yifan1.Zhang@amd.com>
>Sent: Monday, January 29, 2024 5:06 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Yu, Lang
><Lang.Yu@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
>Subject: [PATCH] drm/amdgpu: remove golden setting for gfx 11.5.0
>
>No need to set golden settings in driver from gfx 11.5.0 onwards
>
>Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 32 ++------------------------
> 1 file changed, 2 insertions(+), 30 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>index c1e000010760..4e99af904e04 100644
>--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>@@ -90,10 +90,6 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_0_me.bin");
> MODULE_FIRMWARE("amdgpu/gc_11_5_0_mec.bin");
> MODULE_FIRMWARE("amdgpu/gc_11_5_0_rlc.bin");
>
>-static const struct soc15_reg_golden golden_settings_gc_11_0[] =3D {
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL, 0x20000000,
>0x20000000)
>-};
>-
> static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =3D  {
>       SOC15_REG_GOLDEN_VALUE(GC, 0, regCGTT_GS_NGG_CLK_CTRL,
>0x9fff8fff, 0x00000010), @@ -104,24 +100,8 @@ static const struct
>soc15_reg_golden golden_settings_gc_11_0_1[] =3D
>       SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_SC_ENHANCE_3, 0xfffffffd,
>0x00000008),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_SC_VRS_SURFACE_CNTL_1,
>0xfff891ff, 0x55480100),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL_AUX, 0xf7f7ffff,
>0x01030000),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xfcffffff,
>0x0000000a)
>-};
>-
>-static const struct soc15_reg_golden golden_settings_gc_11_5_0[] =3D {
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regDB_DEBUG5, 0xffffffff,
>0x00000800),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGB_ADDR_CONFIG, 0x0c1807ff,
>0x00000242),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGCR_GENERAL_CNTL, 0x1ff1ffff,
>0x00000500),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2A_ADDR_MATCH_MASK,
>0xffffffff, 0xfffffff3),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_ADDR_MATCH_MASK,
>0xffffffff, 0xfffffff3),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL, 0xffffffff, 0xf37fff3f)=
,
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL3, 0xfffffffb,
>0x00f40188),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL4, 0xf0ffffff,
>0x80009007),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_CL_ENHANCE, 0xf1ffffff,
>0x00880007),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regPC_CONFIG_CNTL_1, 0xffffffff,
>0x00010000),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL_AUX, 0xf7f7ffff,
>0x01030000),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL2, 0x007f0000,
>0x00000000),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xffcfffff,
>0x0000200a),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regUTCL1_CTRL_2, 0xffffffff,
>0x0000048f)
>+      SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xfcffffff,
>0x0000000a),
>+      SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL, 0x20000000,
>0x20000000)
> };
>
> #define DEFAULT_SH_MEM_CONFIG \
>@@ -304,17 +284,9 @@ static void gfx_v11_0_init_golden_registers(struct
>amdgpu_device *adev)
>                                               golden_settings_gc_11_0_1,
>                                               (const
>u32)ARRAY_SIZE(golden_settings_gc_11_0_1));
>               break;
>-      case IP_VERSION(11, 5, 0):
>-              soc15_program_register_sequence(adev,
>-                                              golden_settings_gc_11_5_0,
>-                                              (const
>u32)ARRAY_SIZE(golden_settings_gc_11_5_0));
>-              break;
>       default:
>               break;
>       }
>-      soc15_program_register_sequence(adev,
>-                                      golden_settings_gc_11_0,
>-                                      (const
>u32)ARRAY_SIZE(golden_settings_gc_11_0));
>

Remove golden_settings_gc_11_0 may affect all gfx11 ASICs.

Regards,
Lang

> }
>
>--
>2.37.3

