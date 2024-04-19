Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B59C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 05:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4534210F970;
	Fri, 19 Apr 2024 05:28:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s+mEgjD+";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB37310F970
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 05:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEkOTqoN/Rj/Pm86XqrG1nD8XnVGLZvf/nh0Itvd9YCu76jML1S5mmAJkQJTctAXtkYghvVtlIT1L4QgOWWYMY88nfxfSCeYHz/iPxHimmnKVZj01UWoYxd+CB/8L1b2Bk6r391zDU6pq6LcjO+PAJfe80bgf0rQTJpTCsYa+9clFhW5rxnX16VvCvJaIu684viE9DxcxYFPiKtetmUYuh2WmBi3Ge7zVG3f9ujaANWyvMlsYSgZwsnjEnV5tUU17ff4x+wsL4JlMNZLNdlGvrGLehgUUcrZn2eE1y6bTNgbhavuxbk8i6Sb0wEF7Jctfb8X4s3vrTn/TLYdtYAQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1whKGZechO8pKdIl3P2X9AfAWnsB3foVQMpW51FbQXA=;
 b=CmSfR5jXQQxQS3UtFutHe+UJZMqyD/0Doc7tpzUSxs6BM4rSEYBGApUOMPwY9McMmmplHxHj5m6Cj6O2+0zhYp+pdL5TRvFpez12PJujXZj+6edXQ4QQgf9/y/LAefQ5zvjdnHEUcIu0XQh+lqDXvUf/hNqiDY+YyofkE9TxemGw2dWAE3urwMmD9E+39XPiZ88mgxFIh1zmelHZPhogQAvndSr7RRIUTmcZDG5geSI8H3sql65cepXRTCFxv46niYmoVSol5451BF21JlwhfxrHaA+8G0E9e9dQhAf0FDn666kFM7nm0X+lRMqXbP35dVmPRo31vwxlXfeTOmuZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1whKGZechO8pKdIl3P2X9AfAWnsB3foVQMpW51FbQXA=;
 b=s+mEgjD+kkZAb2Bs+KuLtU6ngwoYEoV3SC/m1gVUqvM9o6xWHlQBTDImm8GgaDvnhRomGKBCKY0bNxi+5c58JDzUN/scm4TgScY4dl3/QrCzryvgykTbxeOf/iDVVs6OevGhQ2AkTNcHzio7JVNz4dg30cJav989yNZ07/sj42A=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Fri, 19 Apr
 2024 05:28:10 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07%6]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 05:28:09 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Lee, Peyton" <Peyton.Lee@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, HaoPing (Alan)"
 <HaoPing.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vpe: fix vpe dpm setup failed
Thread-Topic: [PATCH] drm/amdgpu/vpe: fix vpe dpm setup failed
Thread-Index: AQHakU6GXfP0gVJnFUyb1mxxQylriLFvEfLg
Date: Fri, 19 Apr 2024 05:28:09 +0000
Message-ID: <MW6PR12MB88982CC9881A9FD3AB33B869FB0D2@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240418051244.2329177-1-peytolee@amd.com>
In-Reply-To: <20240418051244.2329177-1-peytolee@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e8502ef4-77fa-4153-8522-8835023a59a0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-19T05:27:40Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|SA0PR12MB7479:EE_
x-ms-office365-filtering-correlation-id: 82e3e79e-1099-47e3-fe87-08dc6031800e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?RIHJmOei0jF0Ts57N/aIHX0bqATVtGk9lYffIGbI2uo3i9W9Kjm9StAUsUHJ?=
 =?us-ascii?Q?v9cD++w14gUtNmV6l/FC4YHWDKgrLxAgc8TfJBYU79eT4vqawBUEI7yuNj2d?=
 =?us-ascii?Q?X0uWRCVLFWnFIvTlez+Itifw30qn86/3ASoIJZ4k9WPSIJsSBqLz0IATH5L9?=
 =?us-ascii?Q?Nn2Pd+ALzD21dekBte/D3WNFDs08j5spVl7VYyFGE3/fMUg9qe8c9l1ezM5s?=
 =?us-ascii?Q?hKRwqeBg1YO5HTWfoh5prL0oIQAVNzibgi0uLzDp/GzVPbJfVKQPjmAKU/rs?=
 =?us-ascii?Q?+iTOg8EZIFkfECpjXPfFqIRwVpibsqWkmA0u7ITniTiNGBxWiaidINXcPZqv?=
 =?us-ascii?Q?3a/hVu4h1ZAyvCkaWL1h9pkDMiv2sePXmn9iCqOrrJwmpYGAQ5c4fpApVZkD?=
 =?us-ascii?Q?0Xjt5s8ydjfufrvqzBgT3qt2Kdwv9VNVgJ6SADlKd3cEaMtLSPeQ+CbAabBw?=
 =?us-ascii?Q?zNQrgNBDd3VjvqmJqknxM6IOEISYDOA9rIBQrV6P0H6Z2dobYPN6boQ5VmCS?=
 =?us-ascii?Q?R5h1eHrsS44og0EK9PtlzlbsFbsCOZBQiuwrOQxTsHJeF6Qsbcqz/3BrFynf?=
 =?us-ascii?Q?ujTmQjdRYC5AfxSiGJFyHQ44lnwp77WWu0Dx3rtgMACRZKvxWJWjTfPfmUda?=
 =?us-ascii?Q?DYEkOOFN8VVqleol/i53YHe9C0DavYSVHKzJznnnTVVVzWx3BWQd/VyRuYGc?=
 =?us-ascii?Q?40CMC7p/NqRPxgvDgA5MJKpmk+y02c7SINB6sr5pSM2jdyY4pDigM1QL1TFx?=
 =?us-ascii?Q?zQNAPskkdexlImBcErmp2VElxCE2llBLqMG0rkf24zJHkw+Ch1LrVvueO4wn?=
 =?us-ascii?Q?04FEBBq65VpCxqYKvR8+7/5sJ1thto2SOWkXojmG9Z1Plx9KeH/2velTMwyO?=
 =?us-ascii?Q?zuOIj/0eQLF77pA7xQI60PD2EboTAVooOH5VYc4/Z0Fl4lhUHt/u3mTq3MVg?=
 =?us-ascii?Q?N5o2O2TEdXFm2S0Pcz/rncZLtf1XoEt49oEZh3ZTneAGxuUkXBkQIFUBBPUE?=
 =?us-ascii?Q?mINXSZY3PnUspdlqaKu205ehmB3qqtRXoHgaf3s3u1R7NsE5qSCTtyATwr3F?=
 =?us-ascii?Q?8iVyEm2AWnMfsNYLxReXLL5EMSLvbTsSWtNqszsvs8TY+vAtvGc7GJoi05pq?=
 =?us-ascii?Q?1/oJiOopB3KMuxTkO50z0JiwVd3X7WH+FmUn8BP5Z9QWZQTs02UzoM0UAC2I?=
 =?us-ascii?Q?7xeVN7tq4sYoMLy442gDZTFHF+WkMqX2q9ZXTk+v9/AnpaxBjJ/3rR1Oaniv?=
 =?us-ascii?Q?M114RjBZpdjb//0vOK03ziO4sNCO0q6WfNnggw+eMT+49NphQnDz3kMfSfaq?=
 =?us-ascii?Q?KOgaiCQa3VJYUL+LODA2oUWtxpJ/rW+tZkEMYFUo7p0AUA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mDgp6oo1SwT32nDUB6TL0GsZdpLFWUweVclWF/PcBkZ/iqYlUVPJNI8LdltQ?=
 =?us-ascii?Q?Jo3lO2HluDMvkkI36eQs7kvY4HIQS36Yu9ya/JMoA4KCQNHw+l3C89XOcSjT?=
 =?us-ascii?Q?mnd1SJP7G3/+6bamo8PV6X8Rcx/D7oI/7ihOKw2gU47GOS3yyhqmc9v4onjT?=
 =?us-ascii?Q?ghtmWtLf5H3Kb/wk/Ui+Q28ILHyO5SuLpz86pc3YFBW/ce7b6Tq+Vo9WutVj?=
 =?us-ascii?Q?KvTRP2frsC6klTEoSMjdDrnFdwBAB/RYdRwwHSwh5gW6XueSlwZQHwXjsNlm?=
 =?us-ascii?Q?KlAdZgfhs6NDYl96RRWfHNHoMm3x9hVDrx/U9tMnqggVx6KZHJHEtuJx28km?=
 =?us-ascii?Q?iyuHNQDwtP27OnlF/shwu2zJXuX0dITAR9DH6vs0PJx5LtG+L7/irE62kELh?=
 =?us-ascii?Q?hTkCE/lydcwJuOMkdbtCL56H3RqHdjDE6IYirkInsyaxtqx1qAVtjk1ibRlB?=
 =?us-ascii?Q?aQT2r6ROUrsfvl6id/QwWEv5Q9m+ZTw4ZQ6eq/lzmrkmK0dkT+T50I2JG0dp?=
 =?us-ascii?Q?RpvpZP70ezbi7/RwV9oq4DVdrDP/vu3IDkn9jMXRl46EueBiryGT1MPMHxhJ?=
 =?us-ascii?Q?WQuJ2fM93T0rDr4t1cxoSvE/xDSUsfk6XKYgxC8n3wLT8jJiw5PPjGm3rgaa?=
 =?us-ascii?Q?rW20iwOCXi92wwjmAY+YDwzHLNr6TrM1qQVUjGjQUnTgA4rRJz21mKN9GSq4?=
 =?us-ascii?Q?x3lNvxPA/6R5i+lBhOhJWw9LzX3bBlApBKL8C03Uy7G3nH62IcAY97M83Mh4?=
 =?us-ascii?Q?T5ORqJA68178icXwSFMyTI0S27lHk2vWxxWZNGU2+quJwm+UuZdcWTiWCcFX?=
 =?us-ascii?Q?Q1VE48BWktL457WmHqPh/HxqEi1B+nPeU689j1RFa0h2zk5xj/+ubc3/lgVY?=
 =?us-ascii?Q?FpANJdnKQ4/Lt4gGgpbEV3IDvyZj8SKVA+ZOZGAvdyNbxHtR2sIXUzYT8SMp?=
 =?us-ascii?Q?Lo35eSpeXhdy/kOyeimnJWIoYqGuE8auyObCChiTnpWg3AtYgDf2/usYPuFa?=
 =?us-ascii?Q?OkmPf0K3A6fkNa717/kYQfKmDqnHkc5L/K3S1B6oFnAUD8oEVNUZPpJN5Oz8?=
 =?us-ascii?Q?lSGLbKYdcq9St9yfKocdvBJ/SznkI5rVwgnLye4Mn4FXYq8NCNeV3vcdE4iw?=
 =?us-ascii?Q?Q6/UBGJHvBvowhf+LTpXoK3a/KZWTyCrcnMtcwaez3WCvsyEztQMsGDuRP4X?=
 =?us-ascii?Q?ArmKbFIWXpB+vpfI9Bhz/+4z1GLn23NIZNFpFW2aMPpamj0SWBI1UL4wvruo?=
 =?us-ascii?Q?uGcTJTmTpUr5FdCPoslrXdqzi6rFhQDg252vjcAvab6ZhWTujNcBQOwnRtxf?=
 =?us-ascii?Q?mQNEeNggWYtZHO5S7aPZ//dxw3noAl+CNsa4UvzAfVC1mCBoPSaHUuONtTVI?=
 =?us-ascii?Q?z0c04NrovwMCwKA+ID1lwV4GagU3cpknS9AN7Yt6SHNVd0+vRa9iuEXP1Few?=
 =?us-ascii?Q?dsL/DoUfPmsW2zFJY8nMaICm18qHaTi2qUJ4bRjlN21oFVE1wH2CTE1EGXbc?=
 =?us-ascii?Q?9LNUzwQ+IL2WMmVcjQvmIBgmoJosEDCy4+HBFBXlFxhB4QZ7d1CPu3+MD0a2?=
 =?us-ascii?Q?Onm9Xp4BbULHCyW0pXg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e3e79e-1099-47e3-fe87-08dc6031800e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 05:28:09.7502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNwufsKAAdCiLsqcnB9ATyHyhH/4Zi6NiGwFfz+2p67QAqH+xrYN0SzHLdpjtWimun5tHiL9kdXhAsM0Y4Z5wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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

[Public]

Reviewed-by: Lang Yu <lang.yu@amd.com>

>-----Original Message-----
>From: Lee, Peyton <Peyton.Lee@amd.com>
>Sent: Thursday, April 18, 2024 1:13 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, HaoPing (Alan)
><HaoPing.Liu@amd.com>; Yu, Lang <Lang.Yu@amd.com>; Lee, Peyton
><Peyton.Lee@amd.com>
>Subject: [PATCH] drm/amdgpu/vpe: fix vpe dpm setup failed
>
>The vpe dpm settings should be done before firmware is loaded.
>Otherwise, the frequency cannot be successfully raised.
>
>Signed-off-by: Peyton Lee <peytolee@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c |  2 +-
> drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c   | 14 +++++++-------
> 2 files changed, 8 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>index 6695481f870f..c23d97d34b7e 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>@@ -205,7 +205,7 @@ int amdgpu_vpe_configure_dpm(struct amdgpu_vpe
>*vpe)
>       dpm_ctl &=3D 0xfffffffe; /* Disable DPM */
>       WREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_enable),
>dpm_ctl);
>       dev_dbg(adev->dev, "%s: disable vpe dpm\n", __func__);
>-      return 0;
>+      return -EINVAL;
> }
>
> int amdgpu_vpe_psp_update_sram(struct amdgpu_device *adev) diff --git
>a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
>b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
>index 769eb8f7bb3c..09315dd5a1ec 100644
>--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
>+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
>@@ -144,6 +144,12 @@ static int vpe_v6_1_load_microcode(struct
>amdgpu_vpe *vpe)
>                       WREG32(vpe_get_reg_offset(vpe, j, regVPEC_CNTL),
>ret);
>       }
>
>+      /* setup collaborate mode */
>+      vpe_v6_1_set_collaborate_mode(vpe, true);
>+      /* setup DPM */
>+      if (amdgpu_vpe_configure_dpm(vpe))
>+              dev_warn(adev->dev, "VPE failed to enable DPM\n");
>+
>       /*
>        * For VPE 6.1.1, still only need to add master's offset, and psp w=
ill
>apply it to slave as well.
>        * Here use instance 0 as master.
>@@ -159,11 +165,7 @@ static int vpe_v6_1_load_microcode(struct
>amdgpu_vpe *vpe)
>               adev->vpe.cmdbuf_cpu_addr[0] =3D f32_offset;
>               adev->vpe.cmdbuf_cpu_addr[1] =3D f32_cntl;
>
>-              amdgpu_vpe_psp_update_sram(adev);
>-              vpe_v6_1_set_collaborate_mode(vpe, true);
>-              amdgpu_vpe_configure_dpm(vpe);
>-
>-              return 0;
>+              return amdgpu_vpe_psp_update_sram(adev);
>       }
>
>       vpe_hdr =3D (const struct vpe_firmware_header_v1_0 *)adev->vpe.fw-
>>data; @@ -196,8 +198,6 @@ static int vpe_v6_1_load_microcode(struct
>amdgpu_vpe *vpe)
>       }
>
>       vpe_v6_1_halt(vpe, false);
>-      vpe_v6_1_set_collaborate_mode(vpe, true);
>-      amdgpu_vpe_configure_dpm(vpe);
>
>       return 0;
> }
>--
>2.34.1

