Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18FCCAC598
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 01:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7DD10E05B;
	Wed, 17 Sep 2025 01:14:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GmUQ3PyX";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B0C10E05B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 01:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkOigAoOvsf8luO2GvaSriT8MG5hw7r5PPm4fXwDgWDwAClDLL4gbO7Q6W3ANr/xONosrccTUIHmaZi0L697lFVPPi+K3qvJ516ssmaB9gAEU1gQ1zT4vtj0v18CjLWvxxrpawrDbVFBCOKdoWEpLGmQQz0328NUOTTYPW4Drf7AVWKg61kLgzG9djVH00Wh8aJa95ux94Iqek4SpwjUloDiGp8SbBhsbz5+AnZmezKRNhlUapmC9jGlngX2KHlYrJW4TX9PJw2FvoxHFssVVTieElAhXaOseuT8vkiMWQs/VEiZo48R+0T2GnTYIx5/YHlFTZG+Fmus6s6JHjDfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UA4D06QRNxw5v6HeObLPFfdTFiMJp+nskzB1qTxFSs=;
 b=gDptRmEb312fDPwmgfwu4iacFLA4cthuAnhGWNo5AYja/dVtDwN+308v07XWinngAQCjjKyz02Wcizab2tuj/7s1LqD6XsYMGMuusgV5xmfljF65cC3RtNb1mK66hUyftAK+8o8ceJqaeJ+9p4/2H5KScbOyAasKepj7LHfQBOtqc5R//EY5WMf1Ig7jZak8WC+hFAuQNLIX2eadhV9fLAExY3NLDdjGX93KD58f4TM4QLhGgdevIvfwvBfHtiQjqCSVPt5O4JyKDkaDZO8IUaOFZlEpNgs5hhErfwNz0+0spZdb9XVgocDk7MvpUgRQfNvw5aAwWjdEtcrnFY1cVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UA4D06QRNxw5v6HeObLPFfdTFiMJp+nskzB1qTxFSs=;
 b=GmUQ3PyX0Hdtv+b1V8WYWTACkwfmMw2weougYXltxGmjivcxfPHJJ52sJMku/nt85tEmXtLANrzYDnHdk+p/yfD0jvHtEzt9KNV5eJslFwSEH/PxsJVydcxhHqx+sIur+32N/te1ycINO4Ck05k2SgWDYlgAbDCEIth3RIX+J58=
Received: from CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14)
 by LV8PR12MB9689.namprd12.prod.outlook.com (2603:10b6:408:296::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 01:14:43 +0000
Received: from CY8PR12MB7657.namprd12.prod.outlook.com
 ([fe80::dc50:9698:ac9a:b44b]) by CY8PR12MB7657.namprd12.prod.outlook.com
 ([fe80::dc50:9698:ac9a:b44b%5]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 01:14:43 +0000
From: "Gande, Shravan kumar" <Shravankumar.Gande@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "Liu, Xiang(Dean)"
 <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Introduce VF critical region check for
 RAS poison injection
Thread-Topic: [PATCH 1/2] drm/amdgpu: Introduce VF critical region check for
 RAS poison injection
Thread-Index: AQHcJtYi+GwezBmZUkiRyQD1KAChEbSWkmbA
Date: Wed, 17 Sep 2025 01:14:43 +0000
Message-ID: <CY8PR12MB7657EB9A34E603BF86654FFF8B17A@CY8PR12MB7657.namprd12.prod.outlook.com>
References: <20250819052548.124897-1-xiang.liu@amd.com>
 <PH7PR12MB79881316E7185028A0A972AC9A14A@PH7PR12MB7988.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB79881316E7185028A0A972AC9A14A@PH7PR12MB7988.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-16T06:44:13.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7657:EE_|LV8PR12MB9689:EE_
x-ms-office365-filtering-correlation-id: 47cf3eb2-c700-432f-7746-08ddf587959a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?CwdFkYCuST3/5SoiAWZJtSjeiE+fBj6RplfKrVJAmoBfulY+aU78AWXC/ABb?=
 =?us-ascii?Q?NtITT1Or/at3QwvfA2sem4ZTFB3cM6tlvKI8/wRG+Ly2gjf1va0WF+2qUIGd?=
 =?us-ascii?Q?ljm6af2lYxa31ZYdYnL024iPBkeCiFRM159DW5TiZh6f0C4W6wQ8PSzrzDYU?=
 =?us-ascii?Q?PdPg7zyXL1mHNwgTqLN01Q1CXvud55qsk0E8sK+pduXGZEBdzt/9rxuG5gA+?=
 =?us-ascii?Q?n2JJ+SZB0d4y6veeFWZ4HcRXgjEKgCBEKclF8KmA03FVjGaUvU/D3/1kFxeN?=
 =?us-ascii?Q?fIMs7UxwPBLR8XGCx7yT3uem8rELdbNHA9W2hBC/yID3HFZtW29j6pbqCDg1?=
 =?us-ascii?Q?tG7KWLZ1P3Y3phViixPN5rR0ec2QKhZttMagHOEWDMFq6rftmo6Gi1rLXQf3?=
 =?us-ascii?Q?EiEYCjV9k40rtTY4/iEE7R4ik01Q5V6AF3qccrtq5zQEF0VWodPAFy2R9cdy?=
 =?us-ascii?Q?Y5koUBYNNyz9FuK9Z/FK1je7ScIb8zXA+UTn4WHYS5Y0NwhQ+TvJTGkWC69f?=
 =?us-ascii?Q?igw1WtNfjT9CJOgCjXKdd0qmWB65YF4asUSR1biNfem7GqVvh+weMxggaJXb?=
 =?us-ascii?Q?YX68ZHNHhFSRoQrKOTvGUdtg6av+nHEw1HyE0h+XTWYA0VW0tstgvjmO/lVZ?=
 =?us-ascii?Q?EavkeolVnTYWdKL2K7/HsecyYy8VjR+g37ArkTRhsrjN4HWFX1jxvYHwtp7P?=
 =?us-ascii?Q?gH9l4cfuLzierL/xWXAbFAVjl1bVBliuh5mrWvpMNPVinCCkVrD+eDHvHl9f?=
 =?us-ascii?Q?ScUs0lMvw9v3ZmRj9ZVU4u3lT4Ambm1ytwdPpr51jIwLjghfTsEz5Cj67cRl?=
 =?us-ascii?Q?SH0eS1CGv4XuCEyp6S8liZtvkft82kLgVHWfTI3zwHxgsTP/pU7iPDzHy3zY?=
 =?us-ascii?Q?LtLjSeK+D5q1kK/+NHKZrrSKHu4hsTPeki/n8rXKHmISr5T7+B13sGVOhACg?=
 =?us-ascii?Q?xfmbbVfJizBTV4jTRogVyUnPJ/Cpxus4shr+avAoWVZf/Enl67HHcB/XGG16?=
 =?us-ascii?Q?zmgPu3NSLPOkgPygS4zL11Jr7oZV3sJO91muoVhXFUuTEe/5Fq/ZqdIoEa7F?=
 =?us-ascii?Q?3QM9xpBWb4JUtWXyAJIQADw/bOG3r1CoAzLgHCASTnWtqhVILKvl0ql6Hsi1?=
 =?us-ascii?Q?CSlQ36TXjqdEGD7Cu7H4L2XBE1QvVoUVsw4q4/eNm4rpgtQYkLMoU9l5hHFw?=
 =?us-ascii?Q?u84Um7w4tcB5iQbeoHbZXVDU5M9DKNx18tYZNdpB7XM64hvI0PLXD1qhMK5/?=
 =?us-ascii?Q?drLiFs/nK1Qu2z8hHZQl8gdTViD2uaol16Cc5eyVIVvPZqG8wQZoBECrF4ij?=
 =?us-ascii?Q?37JvdCb2WJ2mldq+1WXG93WOuphYsWf00EyaQ0Q9dRVuqN47blWseV4Pcd3V?=
 =?us-ascii?Q?VF3MKjnOTM00ONifkeQJuTxx+2YkQPCIVAnecwL+au3AuYe2T2kQm6c7FKSr?=
 =?us-ascii?Q?GVoC7e9FnlSWGSnvpufO05LdAQc7BIcBMQmqDHFK5BEgomzSy4PFks/PavlA?=
 =?us-ascii?Q?hAKjrl3UIIVm3RY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RLB5k0PPrXQQvZ1Vct4vGL3Xxzf9A/HnPIacdkZOlaDHsV/hfu9+huiDhbXe?=
 =?us-ascii?Q?ILfycRQILvyFWK3EDRgCdZaAS852VanPXqJxfb7lfKjVJKrtINYwVnWoJN+P?=
 =?us-ascii?Q?odWuMbbbe2+Q085t1wQwWh72W+Bsi5r4WRiDnSreQuTuDxPXtMZ7AVKjTNYv?=
 =?us-ascii?Q?lYorR2VwJ11MdW5wmQMgl8QRnHuRwwgEWagzw2jG7P6zH6KgleskfYrHThUr?=
 =?us-ascii?Q?2xB1zdMQzuM5QugLApIy+Q/ijR86s2hOHpoOaFUTJ62Jm6DFhLBbApS6r0c3?=
 =?us-ascii?Q?TB3wUKMn0E+8B9tuIL/sRS7vG6Ti8edL0IFdcGO4cif3zKV2GYIALqzoM/+u?=
 =?us-ascii?Q?JvPnUg1A0rE2gmtf529+iExZpTfOkwdmmuUH0RGsdKID0kahQtu6sbvAKwJv?=
 =?us-ascii?Q?vODfBOec7onBKtJL5H+v8oYjIwuzBstQ/jOPyrwZ1MpRLq/A6p7b+/zubiTu?=
 =?us-ascii?Q?QC4rROpDLffYBF2m4pN36GqCDFoPrXK2zf5gc/cds929NpdVjky4JL+Ywqpm?=
 =?us-ascii?Q?JuPM38VHtsIkBiVuHoFdn1V0uiMDt7IZn2QhfHUe/+LIyuJgcBDcIzkrZVGY?=
 =?us-ascii?Q?XMtRCxvURyXzwisANiFC3f7ngkD6Z0H2zpm6VKTgNZWxYPjt4pI4OQFN8OU1?=
 =?us-ascii?Q?K/aEtcldF6JMuTRf7Z3nRODUfn3jAegDItEKnSJ9ULM9y922l4nWPz/+DB31?=
 =?us-ascii?Q?w+hhRy7rK64jSybKUpiMsHSwO2TMe9F0UG71gtbCrPUTEowwXK1SrHxIWhr3?=
 =?us-ascii?Q?ACqqKjCSx42PIL42y9xCIxIdjHO4nCk2x7qlbpVX33TxIlq268RdnfVRzgYv?=
 =?us-ascii?Q?ScFQ6UUQ1DjA8cFfhDu9VAdLOdz66nPpOkIBnJ+f0lseU71nl+tx+2lI4ZAZ?=
 =?us-ascii?Q?Vb6rZJrbzMIx0Zis7zNGwdacDrtJ0T8ihQdV27HnyRzzqAKfWZ6AXySwk58+?=
 =?us-ascii?Q?FlUCR783/Nv8T+s0zgL0sWSuT591Gs9C1zhOIX/RqNk3s0dyHHzV0tzYQDW8?=
 =?us-ascii?Q?q5rA2gpKXX/mYpDVmXNLJsuzYOAD58f5v2lUSW1ScdZ1KnSdxVThQTcBm16w?=
 =?us-ascii?Q?IcBSek3Iyw32WayCeiXQ5i7HcxNNpSBZstIndtAcCoOs96pWaF7iuflGKGwT?=
 =?us-ascii?Q?9LC9axK09DOB9nDopshz1aSOL4xS6cVitAgtvPxwH900w33ako0gbIAeDsSB?=
 =?us-ascii?Q?4o016flVqztIsniXsCq3h/ZaSFzTmau/nvFzanP+UWO6wTWsH7JXYOMsEiyV?=
 =?us-ascii?Q?Tp4z5HMzME5qnSGbIQMWOTtxwJ3g6RmW9AzNaC50wXFFW825HzU2vWxyaDsn?=
 =?us-ascii?Q?ScybV8FkR5qIHDyqGEtorMaIIMGWKQ5mppRoaQvV55iLJyNJ/8upWPdkvPRI?=
 =?us-ascii?Q?jkeUAbWueRg0dpV/KX3irGEuKlwvrAhsRhb7bXPBqiWtFeM9EuUMAIjTGHjE?=
 =?us-ascii?Q?Xo+nrz4/B/fFCa8+3OQbckD/nmNkrO0v9Yqe76A48fX4+6SRdHMAFV7xf2SS?=
 =?us-ascii?Q?MBV/lqwlv3qvVUipEfyxhZphFjcHXkHprL+5TC+/5OAQg4ehjVGBljcmO9H7?=
 =?us-ascii?Q?o3k3yIB00gjzVwoYCDs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cf3eb2-c700-432f-7746-08ddf587959a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 01:14:43.5536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YcUpnviKGXBJ0Br3mD/+7WfltTJJ6aZ8jeEqj5JJLujTp6v4tdxDlj9fzuev1blr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9689
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

[AMD Official Use Only - AMD Internal Distribution Only]

The series looks good.

Reviewed-by: Shravan Kumar Gande <Shravankumar.Gande@amd.com>

Thanks,
Shravan

-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com>
Sent: Tuesday, September 16, 2025 2:50 AM
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; amd-gfx@lists.freedesktop.org; Sk=
vortsov, Victor <Victor.Skvortsov@amd.com>; Gande, Shravan kumar <Shravanku=
mar.Gande@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Introduce VF critical region check for=
 RAS poison injection

[AMD Official Use Only - AMD Internal Distribution Only]

The series looks good to me, but still need @Skvortsov, Victor or @Gande, S=
hravan kumar to review.

Regards,
Stanley
> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Tuesday, August 19, 2025 1:26 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: Introduce VF critical region check
> for RAS poison injection
>
> The SRIOV guest send requet to host to check whether the poison
> injection address is in VF critical region or not via mabox.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 55
> +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  5 ++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c       | 14 ++++++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h       |  2 +
>  5 files changed, 79 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 13f0cdeb59c4..3328ab63376b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -828,11 +828,14 @@ static void amdgpu_virt_init_ras(struct
> amdgpu_device *adev)  {
>       ratelimit_state_init(&adev->virt.ras.ras_error_cnt_rs, 5 * HZ, 1);
>       ratelimit_state_init(&adev->virt.ras.ras_cper_dump_rs, 5 * HZ,
> 1);
> +     ratelimit_state_init(&adev->virt.ras.ras_chk_criti_rs, 5 * HZ,
> + 1);
>
>       ratelimit_set_flags(&adev->virt.ras.ras_error_cnt_rs,
>                           RATELIMIT_MSG_ON_RELEASE);
>       ratelimit_set_flags(&adev->virt.ras.ras_cper_dump_rs,
>                           RATELIMIT_MSG_ON_RELEASE);
> +     ratelimit_set_flags(&adev->virt.ras.ras_chk_criti_rs,
> +                         RATELIMIT_MSG_ON_RELEASE);
>
>       mutex_init(&adev->virt.ras.ras_telemetry_mutex);
>
> @@ -1501,3 +1504,55 @@ void amdgpu_virt_request_bad_pages(struct
> amdgpu_device *adev)
>       if (virt->ops && virt->ops->req_bad_pages)
>               virt->ops->req_bad_pages(adev);  }
> +
> +static int amdgpu_virt_cache_chk_criti_hit(struct amdgpu_device *adev,
> +                                        struct amdsriov_ras_telemetry
> *host_telemetry,
> +                                        bool *hit) {
> +     struct amd_sriov_ras_chk_criti *tmp =3D NULL;
> +     uint32_t checksum, used_size;
> +
> +     checksum =3D host_telemetry->header.checksum;
> +     used_size =3D host_telemetry->header.used_size;
> +
> +     if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +             return 0;
> +
> +     tmp =3D kmemdup(&host_telemetry->body.chk_criti, used_size,
> GFP_KERNEL);
> +     if (!tmp)
> +             return -ENOMEM;
> +
> +     if (checksum !=3D amd_sriov_msg_checksum(tmp, used_size, 0, 0))
> +             goto out;
> +
> +     if (hit)
> +             *hit =3D tmp->hit ? true : false;
> +
> +out:
> +     kfree(tmp);
> +
> +     return 0;
> +}
> +
> +int amdgpu_virt_check_vf_critical_region(struct amdgpu_device *adev,
> +u64 addr, bool *hit) {
> +     struct amdgpu_virt *virt =3D &adev->virt;
> +     int r =3D -EPERM;
> +
> +     if (!virt->ops || !virt->ops->req_ras_chk_criti)
> +             return -EOPNOTSUPP;
> +
> +     /* Host allows 15 ras telemetry requests per 60 seconds.
> + Afterwhich,
> the Host
> +      * will ignore incoming guest messages. Ratelimit the guest
> + messages
> to
> +      * prevent guest self DOS.
> +      */
> +     if (__ratelimit(&virt->ras.ras_chk_criti_rs)) {
> +             mutex_lock(&virt->ras.ras_telemetry_mutex);
> +             if (!virt->ops->req_ras_chk_criti(adev, addr))
> +                     r =3D amdgpu_virt_cache_chk_criti_hit(
> +                             adev, virt->fw_reserve.ras_telemetry, hit);
> +             mutex_unlock(&virt->ras.ras_telemetry_mutex);
> +     }
> +
> +     return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 3da3ebb1d9a1..6ca83abd7a4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -98,6 +98,7 @@ struct amdgpu_virt_ops {
>       int (*req_ras_err_count)(struct amdgpu_device *adev);
>       int (*req_ras_cper_dump)(struct amdgpu_device *adev, u64 vf_rptr);
>       int (*req_bad_pages)(struct amdgpu_device *adev);
> +     int (*req_ras_chk_criti)(struct amdgpu_device *adev, u64 addr);
>  };
>
>  /*
> @@ -252,6 +253,7 @@ struct amdgpu_virt_ras_err_handler_data {  struct
> amdgpu_virt_ras {
>       struct ratelimit_state ras_error_cnt_rs;
>       struct ratelimit_state ras_cper_dump_rs;
> +     struct ratelimit_state ras_chk_criti_rs;
>       struct mutex ras_telemetry_mutex;
>       uint64_t cper_rptr;
>  };
> @@ -447,4 +449,5 @@ int amdgpu_virt_ras_telemetry_post_reset(struct
> amdgpu_device *adev);  bool amdgpu_virt_ras_telemetry_block_en(struct
> amdgpu_device *adev,
>                                       enum amdgpu_ras_block block);
> void amdgpu_virt_request_bad_pages(struct amdgpu_device *adev);
> +int amdgpu_virt_check_vf_critical_region(struct amdgpu_device *adev,
> +u64 addr, bool *hit);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 33edad1f9dcd..3a79ed7d8031 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -405,12 +405,17 @@ struct amd_sriov_ras_cper_dump {
>       uint32_t buf[];
>  };
>
> +struct amd_sriov_ras_chk_criti {
> +     uint32_t hit;
> +};
> +
>  struct amdsriov_ras_telemetry {
>       struct amd_sriov_ras_telemetry_header header;
>
>       union {
>               struct amd_sriov_ras_telemetry_error_count error_count;
>               struct amd_sriov_ras_cper_dump cper_dump;
> +             struct amd_sriov_ras_chk_criti chk_criti;
>       } body;
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index f6d8597452ed..00c5db336c0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -205,6 +205,9 @@ static int
> xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
>       case IDH_REQ_RAS_BAD_PAGES:
>               event =3D IDH_RAS_BAD_PAGES_READY;
>               break;
> +     case IDH_REQ_RAS_CHK_CRITI:
> +             event =3D IDH_REQ_RAS_CHK_CRITI_READY;
> +             break;
>       default:
>               break;
>       }
> @@ -535,6 +538,16 @@ static int xgpu_nv_req_ras_bad_pages(struct
> amdgpu_device *adev)
>       return xgpu_nv_send_access_requests(adev,
> IDH_REQ_RAS_BAD_PAGES);  }
>
> +static int xgpu_nv_check_vf_critical_region(struct amdgpu_device
> +*adev,
> +u64 addr) {
> +     uint32_t addr_hi, addr_lo;
> +
> +     addr_hi =3D (uint32_t)(addr >> 32);
> +     addr_lo =3D (uint32_t)(addr & 0xFFFFFFFF);
> +     return xgpu_nv_send_access_requests_with_param(
> +             adev, IDH_REQ_RAS_CHK_CRITI, addr_hi, addr_lo, 0); }
> +
>  const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
>       .req_full_gpu   =3D xgpu_nv_request_full_gpu_access,
>       .rel_full_gpu   =3D xgpu_nv_release_full_gpu_access,
> @@ -548,4 +561,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
>       .req_ras_err_count =3D xgpu_nv_req_ras_err_count,
>       .req_ras_cper_dump =3D xgpu_nv_req_ras_cper_dump,
>       .req_bad_pages =3D xgpu_nv_req_ras_bad_pages,
> +     .req_ras_chk_criti =3D xgpu_nv_check_vf_critical_region
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> index 5808689562cc..c1083e5e41e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> @@ -43,6 +43,7 @@ enum idh_request {
>       IDH_REQ_RAS_ERROR_COUNT =3D 203,
>       IDH_REQ_RAS_CPER_DUMP =3D 204,
>       IDH_REQ_RAS_BAD_PAGES =3D 205,
> +     IDH_REQ_RAS_CHK_CRITI =3D 206
>  };
>
>  enum idh_event {
> @@ -62,6 +63,7 @@ enum idh_event {
>       IDH_RAS_BAD_PAGES_READY =3D 15,
>       IDH_RAS_BAD_PAGES_NOTIFICATION =3D 16,
>       IDH_UNRECOV_ERR_NOTIFICATION =3D 17,
> +     IDH_REQ_RAS_CHK_CRITI_READY =3D 18,
>
>       IDH_TEXT_MESSAGE =3D 255,
>  };
> --
> 2.34.1


