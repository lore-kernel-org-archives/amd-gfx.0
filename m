Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43533C47E48
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 14:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBBF613C7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 14:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBBF613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 869176E873;
	Thu, 15 Jul 2021 14:43:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 529C06E873
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 14:43:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGmHBmwnW8JU1gRNqLaWIlFID3d0MkUrcW7rbNSoUGym9qvk9VWtjGBbI1KAISBzTYX2PtrsABEk/RxkR1PDg9NbzYYGuqTJWrwYRGP/Qw6/Az0vOtdCeUcQMW6WijPsv89YDzqLav32YHAGd/gOUOj9333oHWQHtmRgmJ0L4Q0eboayILjtRvO2F6ns2uBXfLuFRsXNqtxf7cNVDG81pUmz5uTX88JByPK6Im89/XaMoZvsll9c7/q1CXtFYELJuBQ/+VKtC6cr5ljraq6MtUOQ5GMKUF1h5dXlK/ucrk/3IdLIKAzhFO3gkATuvEHd0EU+bjgnOVhkQx7oMScNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkV9I+3eGPNCnMFhHfKg7gqhYWbOBsFUyLImrzNzGcA=;
 b=O+EoxWXVwsGxRFMOS+TXr40CMz5eGrk38s0ST1T4LSb8y12+7iItolcwnmx8wGAy+8i4PInNOuZLkaYuLRdvx7gTpfgJq7efqOZSYoiDWCuKQXtxeDxHxmZhkyhUQzOJ5qmi+d/MtyQj1RTnhXM7Rur2aHwdW72gtZ+27Ujitg0+xSmOlTasqCg/eeTLfDvbWaLc1xbiaH92dX4eKnS7G4H3cnwSts6J8ZPORWSbWZM/cAPN9pHuDx0zTbo/vP1a8N5UWv9o4GEU0SDeK3MRKkLMzCIqSXht2Dts+F4lh+sqDzkLiMPAviPytfth3lAEiFUxd0h+tcmVBmRu+j3pFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkV9I+3eGPNCnMFhHfKg7gqhYWbOBsFUyLImrzNzGcA=;
 b=VoXoT9SYrd9Okq2UwJCZNM4EqVgQm67obHQzT1B444iNbMM1REPIutWONa7HJAyii99ZQw3C0uV4sYKM50VJHNEnubJfN6TylsVCnYNDG+gNQCdTF/ZYo7ZtCO9kwQHzZ7tI3i3agRSsmTDi/mUnUxZ2XIAqcXeaUVzEtcU9xrc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 14:43:19 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 14:43:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Put MODE register in wave debug info
Thread-Topic: [PATCH] drm/amdgpu: Put MODE register in wave debug info
Thread-Index: AQHXbWKnFLXqxNdiZUWovU03bz4XSKtENIQM
Date: Thu, 15 Jul 2021 14:43:18 +0000
Message-ID: <BL1PR12MB5144DF176997AAE0D58223E6F7129@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210630034712.304515-1-Joseph.Greathouse@amd.com>
In-Reply-To: <20210630034712.304515-1-Joseph.Greathouse@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-15T14:43:18.218Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50ed0720-c7ca-4a47-39c1-08d9479ee2ef
x-ms-traffictypediagnostic: BL1PR12MB5176:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB517602C926F5B8A84425B58BF7129@BL1PR12MB5176.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SWlUZv5wX2qRfMEOEQrTd43Tt60RLh8SLmpGUtK2BPAdIvkZap/YZPGTmk8ag4hQ3U5woPTXDWcwtyThe+PSFHndJY/7OfwggWeFxbe4avnHl70G5B4fy9bisC9M1hcRRDjA4Qu4OHh6pjEn813/tiKtHu1VvVfER5maRqm0h6V+pGPk34JDXyXSh3y+Ny8+nmyH5oyetYAPjOvL2aUw5/+hrBj6HI+oHZTSN1evhmlj5H36VpnKJLkaugp8Wdg26jrXIv5K9BSBA1i+htu+s0huqESMWgqV/7q3jp/ELjDD89Re9aungmU6xXqo9WhP4g7fR7KcThDLDWWwI4S9HF1qWo97RozDgXvk+HEl8OaEASKWmAf3G8k+HbI2qTwbeVS3FV/JwPtaO9uHlar+dqpVrJg0fYuoyAz9VgfmtI8jC30OsC4st/uGritjLbdvhgAItrmjewu7tcTogRRn6uakk40TNQkGPTFLii2tdteiSsVT0DXPOMuvn6v8n/z08BE3mSbeKMJuK0ut6r9X3ZsBmsCrI6B6wsQ6GBvZdq68msJM/O6or1sUh+T62sPte4aM8xstUvATFnxuiStEQ0XOWXPoV46WRnssd5I6gr/VXujd3lWH3QJgTsrirFBTBENAIfY9yoyF9lOpbrez39rb1AmGv4SqOxRf7BzqCl6zhMDjo6v7y82633UanLKEhwvSqkMYv9cp4pIZWSrIKw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(122000001)(26005)(38100700002)(110136005)(45080400002)(8936002)(8676002)(6506007)(53546011)(9686003)(316002)(2906002)(966005)(4326008)(478600001)(19627405001)(7696005)(71200400001)(55016002)(66446008)(64756008)(52536014)(186003)(66946007)(66556008)(66476007)(76116006)(86362001)(5660300002)(33656002)(166002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aP2JW7rxCOFNycUy8mwWAgzkjQiK3CdTxTm4SkGmjrBxtGR3sXO67dZRkXXD?=
 =?us-ascii?Q?VkGcmjRqUdNygj7iQ7/Odoavr7qWqCCGQMHH/qVSOzCFnm4ggfQinNqdZTbf?=
 =?us-ascii?Q?aUA3cpY5jWbmvahWZXGzzyXXDPJeF2FQQEkyKL7NMzz9Gqo6UsTS+xNYDY/z?=
 =?us-ascii?Q?rC4HRHHtq39+PfVRWdQMWlDBjA8fwlzZCbZ6PtD/BYqOmuaJSSmkAo6yAFNd?=
 =?us-ascii?Q?z6ed/cRy/YiAlEaI5duv2QJULGpr40FbMP35+TXJ2cHSD0HVf71muCnUaoC5?=
 =?us-ascii?Q?nMfZu9oPqeOCFbr871wdDzoXyZ4vGsGFe59M7ND0/ycXfc9gLA16hVUhedgU?=
 =?us-ascii?Q?nk3WdzdidHMm2NzriT/asXZ3IGiOaH+CJtTmBRYDSG0cnUtECFzjA1odTyGn?=
 =?us-ascii?Q?kb4rdrYkxaMOos+MVr5a8n/rKVjGcYGkWRjAfoEgOddyeCJbY5aTzh3l7Fkw?=
 =?us-ascii?Q?KcREyIeg9W/XcYweUIl+J/mhyaS018NIGj8pd43Z92uQp949Slryjq4vf7dS?=
 =?us-ascii?Q?jMRWHZKED9cf52vakbbB6BTWqNrz+IibVf48Wstw/KPC1ypP9dFpFJZc6ccX?=
 =?us-ascii?Q?SkhZOjEcKrd7pjaPjDXTtc29SgLa+xNgd3/D1IasCmOM4CaRMYJOWx6fYjN4?=
 =?us-ascii?Q?A2Ed4Z6AKtEXKNy2LTfVJETnfm1BN4RyQqRTZzaKwmExEXTHDQ67qiQcHfXn?=
 =?us-ascii?Q?uCw9V2cUJy9Kq6TWowbSZOR3MPX1NsCk2df4ccrWVY/Q0d/a4RItoyi2oYm9?=
 =?us-ascii?Q?Nqy2yyB/2HJ/k/HS/N0TAoa1Zgv5kKVrPz5uXNnt3bamlbcUDK6z5/7ldxyx?=
 =?us-ascii?Q?9SaOP+WVDGo+h1sIxV5JyqmLmwbnxuNvg0LxYoo4ie7bF6OXc+OKkHcd51zB?=
 =?us-ascii?Q?Ss9oREgrELix5V93EpjYJZ4WnNBWW2XNTCXkhaFYffykRB0Xrh/iNDlOYbbF?=
 =?us-ascii?Q?Fmg2Tcu9Fb50GdGmws2I3Pz56xCASdvX12bM3PbZtwVZyDRiUj/j6TFOhOr4?=
 =?us-ascii?Q?LGrw6EJrhGJWL9GDRdIRybCs/lqR+fs8OrvpjerHJSUQFm+s4jQhgxntkm0J?=
 =?us-ascii?Q?cM5OkGwPEura/Zgyl1CB9+zsg4EnP52WxIOCeD+oBJBA9ItUnGXMN3blxtTs?=
 =?us-ascii?Q?YgcEkj49z492EOjtpP2lhI0SK65KChDnoPXGxxB31VF5Ed4TV6xocfN8ofDl?=
 =?us-ascii?Q?B4o3FAi1Fnjq1xGz7ZmTXCS4/nH76qmtcqKtK0q+e0OEQhtN77FxIhOoYA2s?=
 =?us-ascii?Q?ZxHmKsy3+fCSbTbaV3zZruWBIp7FMrC2Clckooc1whjRtNbrPaKlVRWWW4xc?=
 =?us-ascii?Q?ZqL3N7Z9eWvVrpOj+ZCquq2J?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ed0720-c7ca-4a47-39c1-08d9479ee2ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 14:43:18.6732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oyY8RLHxXnrnRFSJQVpbi3HaoFMQR8mdbdCNrGnLTw4L9XrmMXadz7vl6+Fy1ZzHqPzDwDc7rWuPEs7PNyX1nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>
Content-Type: multipart/mixed; boundary="===============1454011890=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1454011890==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB5144DF176997AAE0D58223E6F7129BL1PR12MB5144namp_"

--_000_BL1PR12MB5144DF176997AAE0D58223E6F7129BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

As far as I know, umr is the only user of this and it shouldn't cause any p=
roblems there.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Joseph G=
reathouse <Joseph.Greathouse@amd.com>
Sent: Tuesday, June 29, 2021 11:47 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: StDenis, Tom <Tom.StDenis@amd.com>; Greathouse, Joseph <Joseph.Greathou=
se@amd.com>
Subject: [PATCH] drm/amdgpu: Put MODE register in wave debug info

Add the MODE register into the per-wave debug information.
This register holds state such as FP rounding and denorm
modes, which exceptions are enabled, and active clamping
modes.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index ff7e9f49040e..abcd418e51f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4517,6 +4517,7 @@ static void gfx_v10_0_read_wave_data(struct amdgpu_de=
vice *adev, uint32_t simd,
         dst[(*no_fields)++] =3D wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS=
2);
         dst[(*no_fields)++] =3D wave_read_ind(adev, wave, ixSQ_WAVE_IB_DBG=
1);
         dst[(*no_fields)++] =3D wave_read_ind(adev, wave, ixSQ_WAVE_M0);
+       dst[(*no_fields)++] =3D wave_read_ind(adev, wave, ixSQ_WAVE_MODE);
 }

 static void gfx_v10_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t=
 simd,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v6_0.c
index 3a8d52a54873..6a8dadea40f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3027,6 +3027,7 @@ static void gfx_v6_0_read_wave_data(struct amdgpu_dev=
ice *adev, uint32_t simd, u
         dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_=
TMA_HI);
         dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_=
IB_DBG0);
         dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_=
M0);
+       dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_M=
ODE);
 }

 static void gfx_v6_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t =
simd,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v7_0.c
index 685212c3ddae..37b4a3db6360 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4198,6 +4198,7 @@ static void gfx_v7_0_read_wave_data(struct amdgpu_dev=
ice *adev, uint32_t simd, u
         dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_=
TMA_HI);
         dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_=
IB_DBG0);
         dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_=
M0);
+       dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_M=
ODE);
 }

 static void gfx_v7_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t =
simd,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index c26e06059466..e0302c23e9a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5279,6 +5279,7 @@ static void gfx_v8_0_read_wave_data(struct amdgpu_dev=
ice *adev, uint32_t simd, u
         dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_=
TMA_HI);
         dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_=
IB_DBG0);
         dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_=
M0);
+       dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_M=
ODE);
 }

 static void gfx_v8_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t =
simd,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 044076ec1d03..d42363fcf068 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2080,6 +2080,7 @@ static void gfx_v9_0_read_wave_data(struct amdgpu_dev=
ice *adev, uint32_t simd, u
         dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_=
IB_STS);
         dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_=
IB_DBG0);
         dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_=
M0);
+       dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_M=
ODE);
 }

 static void gfx_v9_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t =
simd,
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C759ce25bce8547f9527008d93b79c854%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637606216512835302%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DhE2DN4im0BGjDhOCb86o7DBKpNZx%2Bf3T51GrSe5YNWY%3D&amp;reserved=3D0

--_000_BL1PR12MB5144DF176997AAE0D58223E6F7129BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
As far as I know, umr is the only user of this and it shouldn't cause any p=
roblems there.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Joseph Greathouse &lt;Joseph.=
Greathouse@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 29, 2021 11:47 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;; Greathouse, Joseph &lt=
;Joseph.Greathouse@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Put MODE register in wave debug info</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add the MODE register into the per-wave debug info=
rmation.<br>
This register holds state such as FP rounding and denorm<br>
modes, which exceptions are enabled, and active clamping<br>
modes.<br>
<br>
Signed-off-by: Joseph Greathouse &lt;Joseph.Greathouse@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c&nbsp; | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c&nbsp; | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp; | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp; | 1 +<br>
&nbsp;5 files changed, 5 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index ff7e9f49040e..abcd418e51f1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -4517,6 +4517,7 @@ static void gfx_v10_0_read_wave_data(struct amdgpu_de=
vice *adev, uint32_t simd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, wave, ixSQ_WAVE_IB_STS2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, wave, ixSQ_WAVE_IB_DBG1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, wave, ixSQ_WAVE_M0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wave_read_ind=
(adev, wave, ixSQ_WAVE_MODE);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v10_0_read_wave_sgprs(struct amdgpu_device *adev, uin=
t32_t simd,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v6_0.c<br>
index 3a8d52a54873..6a8dadea40f9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
@@ -3027,6 +3027,7 @@ static void gfx_v6_0_read_wave_data(struct amdgpu_dev=
ice *adev, uint32_t simd, u<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_HI);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, simd, wave, ixSQ_WAVE_M0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wave_read_ind=
(adev, simd, wave, ixSQ_WAVE_MODE);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v6_0_read_wave_sgprs(struct amdgpu_device *adev, uint=
32_t simd,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v7_0.c<br>
index 685212c3ddae..37b4a3db6360 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
@@ -4198,6 +4198,7 @@ static void gfx_v7_0_read_wave_data(struct amdgpu_dev=
ice *adev, uint32_t simd, u<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_HI);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, simd, wave, ixSQ_WAVE_M0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wave_read_ind=
(adev, simd, wave, ixSQ_WAVE_MODE);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v7_0_read_wave_sgprs(struct amdgpu_device *adev, uint=
32_t simd,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index c26e06059466..e0302c23e9a7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -5279,6 +5279,7 @@ static void gfx_v8_0_read_wave_data(struct amdgpu_dev=
ice *adev, uint32_t simd, u<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_HI);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, simd, wave, ixSQ_WAVE_M0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wave_read_ind=
(adev, simd, wave, ixSQ_WAVE_MODE);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v8_0_read_wave_sgprs(struct amdgpu_device *adev, uint=
32_t simd,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 044076ec1d03..d42363fcf068 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -2080,6 +2080,7 @@ static void gfx_v9_0_read_wave_data(struct amdgpu_dev=
ice *adev, uint32_t simd, u<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, simd, wave, ixSQ_WAVE_IB_STS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wa=
ve_read_ind(adev, simd, wave, ixSQ_WAVE_M0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)++] =3D wave_read_ind=
(adev, simd, wave, ixSQ_WAVE_MODE);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v9_0_read_wave_sgprs(struct amdgpu_device *adev, uint=
32_t simd,<br>
-- <br>
2.20.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C759ce25bce8547f9527008d93b79c854%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637606216512835302%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DhE2DN4im0BGjDhOCb86o7DBKpNZx%2Bf3T51GrSe5YNWY%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C759ce25bce8547f9527008d93b79c8=
54%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637606216512835302%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3DhE2DN4im0BGjDhOCb86o7DBKpNZx%2Bf3T51GrSe5YNW=
Y%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144DF176997AAE0D58223E6F7129BL1PR12MB5144namp_--

--===============1454011890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1454011890==--
