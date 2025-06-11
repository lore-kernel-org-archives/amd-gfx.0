Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A379C677C4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 14:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C569610E68A;
	Wed, 11 Jun 2025 14:16:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1SgQuBhS";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDBAD10E68A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 14:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l15G0HhuB+F8kkh6XbBHmhwZt8eHt5z6fYwGEvk2mw4KhoGe9gTN5WiyvBt+cESPxPMe4fmoKNShON+cyD/NfbUrxFQHmLrgEvMU/ICiCq1Qui9RdCo7C+jglLb4+bqsqIJuwmzAL0mw56mSy+3ch3AYGp2atC41ZZSnzSnn/np1OW6V/NmMn8/8tmihxQeywI0zpX4UTdH17jx1GAMFlxBaawwixvVswPVYmgpukd5S8PzSm4ewOZevxCUtvH6EVute0UEwiYe5mEtjN/R21IZ9Z++bzGCu0r1YKXqiQnVENni0jTf0MbQTJ6DLGCQr4JrZFiYRcXlY6OBgvkSaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAep8zESQr/ww2Fd6HSjca6sDgoOEiJLo77z/lgHTzo=;
 b=fVjNjmbSSkGMO/7SfUR8qj/Eepg13t7mu5pCxQNo0chEuVHyXDRfuVayy5EWR/GyjDdukqD2hmp+FuCi80E96zz+I1EmBL3F3eb/GmSfP72jHiUjZrZBwVsG36FRybjjoEqBOfByXIGrWpkAlhfwWAxLTLzBYVxZBtF9eu+PylaZDB4NbdQeQo2Rt3IFHLrlQDsGi4YSHTt16DjBtESQvcNERU7ha5j9goc8znrX8Uwuo9hFuIFuTZozzDSxOgZpF0+S1LvlJn7BsgCLFSixsKCZpNq70hjG7bqCK7zCXeJPCLL53eTIzixa6fXeLoEFvwWTa9qMv0J48lQqzYD7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAep8zESQr/ww2Fd6HSjca6sDgoOEiJLo77z/lgHTzo=;
 b=1SgQuBhSgcVG4R4dIBVpOs0MAe1b+hPIZUUei6tVD1R1Ah54B5c0JU4vMS3kT7SPy+sgOrIG2VbU+x2xhYpqgi7xVoVNkE0e/BDl44wzknBtL75R7Hk6RCYQPSmTgUvFQRCie8/4GZ1nMjkkN/UPmlZZZVMXEA+DTw6iWJvxod4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS5PPFF8845FFFB.namprd12.prod.outlook.com (2603:10b6:f:fc00::66a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Wed, 11 Jun
 2025 14:16:19 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%5]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 14:16:19 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [v4 3/3] drm/amdgpu: Add soft reset callback to SDMA v4.4.x
Thread-Topic: [v4 3/3] drm/amdgpu: Add soft reset callback to SDMA v4.4.x
Thread-Index: AQHb2rhWiDLXKMiAwkG4s5VgejOclrP+ATNw
Date: Wed, 11 Jun 2025 14:16:19 +0000
Message-ID: <BL1PR12MB5144C7228A5E3E4DD1B7ACCDF775A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250611100445.3379455-1-jesse.zhang@amd.com>
 <20250611100445.3379455-3-jesse.zhang@amd.com>
In-Reply-To: <20250611100445.3379455-3-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c97f0270-0191-44ab-9fb1-6e8994f99e60;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-11T14:15:53Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS5PPFF8845FFFB:EE_
x-ms-office365-filtering-correlation-id: 219aed64-218b-4b18-f5e0-08dda8f2894f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FUGPEWQ8c3dyGWHroZVYMmicxlivmK8VLrFalWqM3dBg+hTGCS8etnxuivBk?=
 =?us-ascii?Q?fTxuO4UO3yrGz1p4u+bIQ3L7T/mq0IgBprlLmWB7JvVp3PpfiaNv0fmGN3po?=
 =?us-ascii?Q?koeUYk2D1Nn+ZPUXFk2q21PfDFz2L7xtPm8PaXZrUt+x6BjTm1g2C20drXe2?=
 =?us-ascii?Q?Cistg8ApRjhQlghuGDaMFaMFULbO5mIweuM9R1DkTWT/xQhXsVSoxteIogP7?=
 =?us-ascii?Q?9PznXC8ZIyYV4N/WwfPjz+Zp33aOtToHaXgeOfSsDSP5sA11hVWcNApv85nE?=
 =?us-ascii?Q?C295jHYMHhWyFiZkMrbl/XITmjvd8n94GJAJjd0aGwoC3FZTQp6i2/gNzuLs?=
 =?us-ascii?Q?1B+Cy//YFtcksn7nfnOY9bKABUFqFYmK7EnJi7INfdo5elLcTU9o62vokydd?=
 =?us-ascii?Q?FTLKc0C9K6rKokLlb42CglHD9J6Kt+aLuSQGxKn0lV0rAWMrHJ1tqj0Rgq2x?=
 =?us-ascii?Q?EkZTGAbDqa/BX8cYK5QsS1+rQmIvBKLgwAawCy2SucZUv5qGNwlTU5NRXQm4?=
 =?us-ascii?Q?u6VgnYaEhHMoViVBnS+/+gt6HBFE2enHdwH5GmCI3AUb/wPc6zrAAUwXXP0x?=
 =?us-ascii?Q?d6+6fRJZr4BM/qqYEBFGk0/v+r+GgddNrx9oWr8mmkVGncDH2Ps/02b5d97W?=
 =?us-ascii?Q?XcoL0d50LD1RnTW6Qj1pyovU6RbAqt9dP8pmZnXZocE/zMBPrn6OfiTELIf1?=
 =?us-ascii?Q?QFi65VgLPS9S5T9AxrfSdIl0DDmN6VMxKgLGPXyIYNycgJqEt7bcJ8Pkhx+T?=
 =?us-ascii?Q?BH/wg+c8uHm/oCW/zmGik3PRZqYMyxJynRRu+s5kYHzb+8nIm2wUOA5mcYOV?=
 =?us-ascii?Q?98Ok7eQVouZH5u1kJvmUgV9Jouizax0C9C5jaOG67SYtTb1+QYGm79OJm1yw?=
 =?us-ascii?Q?lEoWjbhckrwggKRSOU5CMiq4d4iBeCB+b6OCdJ6brBZ1uIeiym0KgtG+zbo/?=
 =?us-ascii?Q?eKAFLCoOf64LuAJzbsnr5Wn/+whv1c+Mi8h3N3lOcbMQWnsXsB3wU8W+CjcW?=
 =?us-ascii?Q?YTIEFFGupXX+/gYpN2C2RX/Y4k+IMohEAIudQjC4e19jaxzftVZK3nTYUCON?=
 =?us-ascii?Q?Y94ttD8DJu05cj+jPVWkHCvseTWCtfA4fywsre+zPKqeZfpQolHM5Mn/Emg7?=
 =?us-ascii?Q?6fxfN0Yz6wWftXt6dsaR+ztr3y6DExV88C37HiCf9cDueDwVW4EX0kIihzzQ?=
 =?us-ascii?Q?rDWYwQVmkZMD5oc9bAfdIqOPvCngJTNnQHAWeY0Fp5TqAmF/gf9EfDPYLhsq?=
 =?us-ascii?Q?S2wudUTpOoD8EhwbDeFMm+5lpFqaPHoBiDp2jRIta653Mc92yFJdWQp8He4U?=
 =?us-ascii?Q?N0YfIStjXws6wSp36Vdw9GHbguzSlhpjAqQIYy18hvJK5/6C0I5dOxmCAov+?=
 =?us-ascii?Q?wGMUpIUlvcbPnxIN+Rz1eRI6F3EJBsucnMgl5NGAR40XjaClZi+ngB+CWUTD?=
 =?us-ascii?Q?nO1TVchuCV5WE6aMI+rSvtwZ5HeVI7UnS+wHYKHfmO6c4p+DCWLIJBylRdUm?=
 =?us-ascii?Q?bLRUYZu/zTpMYWY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XfBPThqmpO58UgbwiGn88O2s5xVQt8Uf3OC9RD0yb2oJfB9+5eBj2YhOTjN9?=
 =?us-ascii?Q?MSn+GKG9N6p2na1hyUlibu+8L3AVdKTYtr7pBfWY2J4YSU5uwnUmSpwEPvLb?=
 =?us-ascii?Q?TbwCjyiWc7wr11+Iu6PF074NeNhqkVUxuKCQx9EO9WbAlZc8mG58GtPgFb6H?=
 =?us-ascii?Q?hR6mleFN/tHrbohWUPqgsrQZxEz3YTAVygrDrfb7TbTG9bxAVE7kp9e7IC7q?=
 =?us-ascii?Q?7UNZMBuD3EK6yIYVBKT33Lwni+YM6XpEy8w7pImSRGWtTy6TiIKxzv6y5y4l?=
 =?us-ascii?Q?Epb32WeJG4AhVn271XhkQ5rf5wtclsRf3eggsUrqRxXPkAuekvMiUWAvUIfF?=
 =?us-ascii?Q?sEg/IWEsqbF2j0g4WkONwfX+1xqVUIDtgqaAQAPZo2ZI6FCglmVcc9mUjokW?=
 =?us-ascii?Q?neCKrwyeXo2NBhwzbMSxDlUQRlijeI1cY4JHTXkOmgJuZl8A52UBUjU4RNGi?=
 =?us-ascii?Q?H2zhN9ydy8xXfcmVqpvwm3T8MO02CwOMKBwqFudG9bjdi9w8ELrshyHTavUU?=
 =?us-ascii?Q?qt/dMVnMOjd3+J/8fd9FoQnZRMvgHFqxS3yEHwTorN1ScIJQ0P8l91yXNnGi?=
 =?us-ascii?Q?tWXq73UdshKowMdHCslcopi/oe23eEuc6V+Q22eywadeBrusQfVYlWfSpR31?=
 =?us-ascii?Q?r8PVxdXwV27U18giE2jqvktlmKPCfiRjgh3IYPfaHSvNQkGb+kljmvEDY6TR?=
 =?us-ascii?Q?mMNmdpLAOxq1fQUFCBnz+Axw0wXv7l3cBgyJ1rSMN7SijhYzI0rNSfIHewX9?=
 =?us-ascii?Q?xt8LVggc8W9jQFXrTubCCnS1XttM7BrRHx1xbIb5AyhgFKKY/JoaAVRIpXsb?=
 =?us-ascii?Q?8mmgqnAeIyrEWPAcJtD+IHd3FdL/djxFjIvKvmAogvr85vxb9MCYs22/KOqr?=
 =?us-ascii?Q?qFmSsyWL7b3jtaQJqFQUPwyAr0i5mwKB+9fqWxJmdUUtOX0PpUPjYwGGRzym?=
 =?us-ascii?Q?ocjLMtHzRmD9teBTCCjPu8Twp89gUBk052h4GZj+NCeP/qcU0uUmbWUoN7Eq?=
 =?us-ascii?Q?BS8EfNANsCUUd4xP+PSRsT1QqN6NqQAyaJZApa6kiYZV3Pyhs7u2ZJfP0UW+?=
 =?us-ascii?Q?yuMHWDD7tLN085qxGW7NLhf+7WTGl2qkdAURAdCij4wM1lXqi+Wzrgts0Up6?=
 =?us-ascii?Q?pTQUU4OdvGu5RVAflrXX5/G7lP6+uYTnhvel8GV32z1FwxbkM4pmQSoLCOfx?=
 =?us-ascii?Q?UEuwVcPhXOBeEzer2SNE7KwaP9ImTl8gUwgV8MHnpYA674S8omoYY46OeTGv?=
 =?us-ascii?Q?EqOc0cU6vCfistmBm1VupmAa1KRNFhO6Ez6YEAapRzpv7GHUGXWCVqFnjdxt?=
 =?us-ascii?Q?PWI2wSgnZe9q05LCTE3qag7PAedDfGBkB24kWRi/eYVHsIbtUewmtbYLjq/q?=
 =?us-ascii?Q?EQxAfqqEPJNYBlwM1rPKP4u38eS/sg1D87GPOEGvqTUJ3PuQWLyp8xH5UoVT?=
 =?us-ascii?Q?PQlckKfsVFUfaSrxYeqb2iE+r0geg/acjvjLeXVnfTC16E2C8hnS4O2s2lUl?=
 =?us-ascii?Q?t4U8/AcajpKTj4jmSkgo2udMnbxlyU0hxau+wCxKnxwKWgA4SuDbyg0SH1R7?=
 =?us-ascii?Q?+TtuhUu0cQf/vzgqg54=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219aed64-218b-4b18-f5e0-08dda8f2894f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 14:16:19.5129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ad+RmvNYZw+uOH2HvY56mu1rzfZNloBT29OgFZ8XJqTd3e4iWPI0B/dTQeMQJMqteYGMmAqSduCXq4xB3W2+og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFF8845FFFB
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Wednesday, June 11, 2025 6:05 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhu,
> Jiadong <Jiadong.Zhu@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> Subject: [v4 3/3] drm/amdgpu: Add soft reset callback to SDMA v4.4.x
>
> From: Lijo Lazar <lijo.lazar@amd.com>
>
> Implement soft reset engine callback for SDMA 4.4.x IPs. This avoids IP v=
ersion
> check in generic implementation.
>
> V2: Correct physical instance ID calculation in soft_reset_engine (Jesse)
> v4: keep origin comments (Lijo)
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 34 +++---------------------
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 12 +++++++++
>  2 files changed, 16 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 9b54a1ece447..a1e54bcef495 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -534,37 +534,11 @@ bool amdgpu_sdma_is_shared_inv_eng(struct
> amdgpu_device *adev, struct amdgpu_rin  static int
> amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)  {
>       struct amdgpu_sdma_instance *sdma_instance =3D &adev-
> >sdma.instance[instance_id];
> -     int r =3D -EOPNOTSUPP;
> -
> -     switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
> -     case IP_VERSION(4, 4, 2):
> -     case IP_VERSION(4, 4, 4):
> -     case IP_VERSION(4, 4, 5):
> -             /* For SDMA 4.x, use the existing DPM interface for backwar=
d
> compatibility,
> -              * we need to convert the logical instance ID to physical i=
nstance ID
> before reset.
> -              */
> -             r =3D amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0,
> instance_id));
> -             break;
> -     case IP_VERSION(5, 0, 0):
> -     case IP_VERSION(5, 0, 1):
> -     case IP_VERSION(5, 0, 2):
> -     case IP_VERSION(5, 0, 5):
> -     case IP_VERSION(5, 2, 0):
> -     case IP_VERSION(5, 2, 2):
> -     case IP_VERSION(5, 2, 4):
> -     case IP_VERSION(5, 2, 5):
> -     case IP_VERSION(5, 2, 6):
> -     case IP_VERSION(5, 2, 3):
> -     case IP_VERSION(5, 2, 1):
> -     case IP_VERSION(5, 2, 7):
> -             if (sdma_instance->funcs->soft_reset_kernel_queue)
> -                     r =3D sdma_instance->funcs->soft_reset_kernel_queue=
(adev,
> instance_id);
> -             break;
> -     default:
> -             break;
> -     }
>
> -     return r;
> +     if (sdma_instance->funcs->soft_reset_kernel_queue)
> +             return sdma_instance->funcs->soft_reset_kernel_queue(adev,
> +instance_id);
> +
> +     return -EOPNOTSUPP;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 3de125062ee3..35b0a7fb37b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -109,6 +109,8 @@ static void sdma_v4_4_2_set_ras_funcs(struct
> amdgpu_device *adev);  static void sdma_v4_4_2_update_reset_mask(struct
> amdgpu_device *adev);  static int sdma_v4_4_2_stop_queue(struct amdgpu_ri=
ng
> *ring);  static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring);
> +static int sdma_v4_4_2_soft_reset_engine(struct amdgpu_device *adev,
> +                                      u32 instance_id);
>
>  static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
>               u32 instance, u32 offset)
> @@ -1337,6 +1339,7 @@ static bool
> sdma_v4_4_2_fw_support_paging_queue(struct amdgpu_device *adev)  static
> const struct amdgpu_sdma_funcs sdma_v4_4_2_sdma_funcs =3D {
>       .stop_kernel_queue =3D &sdma_v4_4_2_stop_queue,
>       .start_kernel_queue =3D &sdma_v4_4_2_restore_queue,
> +     .soft_reset_kernel_queue =3D &sdma_v4_4_2_soft_reset_engine,
>  };
>
>  static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block) @@ -=
1745,6
> +1748,15 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring=
)
>       return sdma_v4_4_2_inst_start(adev, inst_mask, true);  }
>
> +static int sdma_v4_4_2_soft_reset_engine(struct amdgpu_device *adev,
> +                                      u32 instance_id)
> +{
> +     /* For SDMA 4.x, use the existing DPM interface for backward compat=
ibility
> +      * we need to convert the logical instance ID to physical instance =
ID before
> reset.
> +      */
> +     return amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0,
> instance_id));
> +}
> +
>  static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
>                                       struct amdgpu_irq_src *source,
>                                       unsigned type,
> --
> 2.34.1

