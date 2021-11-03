Return-Path: <SRS0=5wqy=PW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A8DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 02:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936FE60EB4
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 02:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 936FE60EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05AB36E241;
	Wed,  3 Nov 2021 02:32:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F36D36E241
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Nov 2021 02:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=no9Zyq1I99lWMpGA4wu4xya/VdLewu+ge83PrtsfroRILHtHVt3Djawtd6tsZN7nsNZ587uvfP3qqIXinjEOsRJpTcAVYwht7u0ADLlVOklfP/Qqs3flmRUt81K7Q2QTi9hofJO6ZjXeCVKe7+FcY5uBq68BTPw/fXDZUxv/XL5LMeoa/h1i8tBlu0hcUrCyEMz/xhLYaCs+AQzfyYFQcZKu5wAAnZaZgIsaEd2ZYXg55lnu9U9ZygFBtKJUFqSq+0oC27ELCgbWr9zxpPDx6embXBf6Rf+1IRkT5HS+tZk0I3qLF3cYVUFhWC8MR93XKlAIsaAM0Elwl7o1+vORuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/AYPtbLpo1rWBDobLmM7lRgTf+LJI3z6Jx4jY4PL68=;
 b=kONcWF5YL4moQ9Vr03YyGzH3qncq85n3RtEJkpjhEGktesE/EH8OQ0NELcrTIHid9qytrcvbq2Z5bJVPH8cwilJ9KFttoZ4d4YrKwQfN3Q4WME3iCoaGsZNzXaCueQet4dDnMV5vsi9rDhJFxgxAoiihagoB3Q9pBJHIKEor7Q1CdbQzj6CWwzYRPUKsJaxR/rwyJiPLiM9/yKupQ2ksiTrpLK6YrXLxcxQ9TcXdaq9b5o2UGaYN3pZ2+cL1AGWVulomaqiMU1XijabfV8bMw+uXH+F/gOJoV0/eWUzNYqTnsRl9bmyqcOdTBVyDtYa2f5QOrUnDkNOxIzl+igq46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/AYPtbLpo1rWBDobLmM7lRgTf+LJI3z6Jx4jY4PL68=;
 b=3h4GnJ73OEGY1FbogQifgKeknSyaye8tPEDlZE9tnsLOVx0qaI3GM2Duuc/Aaj152PeAU4/mtk0Rkt1e+zr7UB9+axs1gXXrH6r4gR8Af1MmLLDxyG1YpTerjQpKOh5wxQzTavD6IBC29jlyDYUMirOSyrsrO4Q2JXa1oDCnoxI=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 3 Nov
 2021 02:32:47 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::214d:f77:ca81:51b0]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::214d:f77:ca81:51b0%7]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 02:32:47 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update RLC_PG_DELAY_3 Value to 200us for
 yellow carp
Thread-Topic: [PATCH] drm/amdgpu: update RLC_PG_DELAY_3 Value to 200us for
 yellow carp
Thread-Index: AQHXz8bi//vnLrnz3E+HuKYTDQIOoKvv9cQAgAEfnsA=
Date: Wed, 3 Nov 2021 02:32:47 +0000
Message-ID: <BL1PR12MB5237B16BE137E1F036BEEF22F08C9@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20211102085118.1465543-1-aaron.liu@amd.com>
 <YYECgG+FxkFioTxm@hr-amd>
In-Reply-To: <YYECgG+FxkFioTxm@hr-amd>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-03T02:32:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bd2d502f-7a18-4343-a811-d8aa7b64d470;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a1c1ba8-8e76-4c19-e6eb-08d99e723938
x-ms-traffictypediagnostic: BL1PR12MB5271:
x-microsoft-antispam-prvs: <BL1PR12MB5271D7122DD87965313BEFFFF08C9@BL1PR12MB5271.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rRhyCJ1cTyHZ9k+sUZtN1iacVa467pGla4pUAQ3Db1chaAICpBaLhRZIDM2QcpFRx4qBFR4FrN/Gj9U/xrtjioPtPmUT60VoumQYWGDdMNOeiOd50dDf7B6BR7EcnMA6YNE6nvtGpvYh5NyH4NB4LIdTaZNt4vHJ2uN8j8bearnVdhQlh4duI6Cl2urxZwkOAn9Ntqdnb2sVlE0gD7MoXyUYtrn66LGNdjuDH42DVH7RqztJYrd5GssdTL6zrCgrxVz3FF4/ciL9N1zAHrG1TB2AdeQ2FFf1tz/rUxSA2wzql4st4rh0xwcpA5qASj5gJYVZFAL5+OqseymgOMwCJp0cbVTuRmGCTKb1YZYZ3ppbXYRtqDatwBVPH11Tab28NCfc4IfY27Nc6RKUUCjs7fLeE337cRcqGBBqqtCK0zhCEMh9gRKq3MbOGyzljQYU64qNaO0bEyRByLNpTp3+Z/TBgX74pZ/qucS3gKBMCBYHs+gRgPIQM+aYVHcO1nUNs9LPrBYTyd5GXinIJwK3ECEuOx5m9gvD1NFbx05kaOtdE9/Gu0PDWxX1tSk8xhXZ1U2WtqxlUq1UHSf4UqldqlJ9lWoGV4r3mtO8OoiZ32a7F3TdqdlREFvX/9xM/s49Q7Ju5R6ZGxk8tVQHyrCwvvGwMbJQVwXqfo6CbIinjuK1nX7oktqMunPrvaCgJevzh0JdRM0jEVw+ji+FATe4Iw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(15650500001)(71200400001)(7696005)(6636002)(122000001)(2906002)(186003)(52536014)(38070700005)(26005)(8936002)(8676002)(38100700002)(86362001)(55016002)(76116006)(66446008)(5660300002)(53546011)(6506007)(54906003)(6862004)(9686003)(4326008)(66556008)(66476007)(66946007)(64756008)(508600001)(33656002)(83380400001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R+/Sm2/iD66MZIM5x0vBHKQkPyvkNeUk5GHLRAhZiiV+3ChVwlq3jdhLOvWy?=
 =?us-ascii?Q?gQIIomWIreXcDr2c9mYYOizQNbCdk2DjXuOKNsBFtfDJTJzP7tc21gd7w++m?=
 =?us-ascii?Q?ROIDvvXiGeU0eUB8YdMTf1P4cMAc3mwGGDSMaxQxS1J3jvY3Nhz8ko7PZGJX?=
 =?us-ascii?Q?OIGVmovynrLvpfLkXjdaI8c7N1lHYpuBXv7dbn2x6iiDz1qzVDEAT5tbvcfa?=
 =?us-ascii?Q?InkNHd85LPDvuSU2WSChCQulpJkTR6PaDUh9ifu15y/X5bbIHsbVDqlipuPA?=
 =?us-ascii?Q?0puxBBM1NB5COnl7UVigJsLDkvxWY63GZ/gjJDaOu+3wnT2Ojq9X5lqwwyCH?=
 =?us-ascii?Q?OZQ97zH2yQ1yqMCpGP/Ug4cDoU5QeaScHLKBT0RRC/uRLzIbTUiTekhbcTeV?=
 =?us-ascii?Q?qbi1EBtFzHA7kUQJ8QE4hGjnR5UfsJb9ra+1CnPYiUtrINklv9WGPvBhQYYd?=
 =?us-ascii?Q?aqGYH3E37G2mZXjeTmLUM7Utqv9X4FUkmoMMkaRbZknYQGTu1XzCP127skAh?=
 =?us-ascii?Q?rcqktFrQPCGIXRrHt1ap6NsiiRMy/iFPHfxnBeqzk5P20NIUqvJ0OQy3SWGN?=
 =?us-ascii?Q?L/UZvn7oxoy6jCrqo8Z29j2epDwkbm5JAahw2uZ3JccEru2xNLuw5OxGQm+R?=
 =?us-ascii?Q?nlXTroVqGPRQnKb8Y3Lk9Ua9bUQljryJdn0kv1nkEj69RjRNnr4WUsS052CZ?=
 =?us-ascii?Q?Xywcb1vBSfdanVnLXVYL0RgAEulODgT3V34CBNCDrzeFkqT3OPvUfNtgSjCQ?=
 =?us-ascii?Q?dN0J4Uttcof6Pg4q/eoLTmQDYEqZ7qfdej7OhbBqn9MCjm/dGRQwf6/ILlFH?=
 =?us-ascii?Q?vTvxi52PX0737zbI9EyKl5eD2yljipxJLxODk4Zmllua1L0ouwovbNV1a3i4?=
 =?us-ascii?Q?RF5qxvBXmq+LBZ5tlSJ7l0yAyzcNtjD0h02+BS0KCNJMDFgrrvQockW/HOQ1?=
 =?us-ascii?Q?lJi07+UwCLsRknmq2NioowVIJ7wzKQPxwabt61MASztE1+QohJ1cC0jr+IMT?=
 =?us-ascii?Q?4GI/KXR5zSN3J/XzSP8bh1F69a/BupToURtqmApElCcqnhifVCKVUP5P55A2?=
 =?us-ascii?Q?jd4Jfzz2kk499XMT74o3p0CUbCiIT7gOnjhr68xO6Z6U9ynOpXp2y0dCCFP6?=
 =?us-ascii?Q?Aey4q55BcUo/GnhH4KJ7Sml4U9rtQ0JMTZ6MQj7NVSo50r7A2N+Jhs+bHshj?=
 =?us-ascii?Q?iMjHxmR1Zpa/WRCc0GcmTeI/hTwrxM6y+Caq7M39yP2mZ5WiaTOY+HuRtGko?=
 =?us-ascii?Q?yHkvUkrCVNfDlf8N5rHfj4+n2DjJjCmKEgonWiRxqfhGN88zqH9GHWWVZhpC?=
 =?us-ascii?Q?iltc6DMXIvtyCbxoS4nkBlGPZD+YKVoFdW34eHII2v/jF+/5M2iNRffybQrb?=
 =?us-ascii?Q?MSlqIhjWIv0f0M34LIpa5P/M+F7txROagFI9sk556Qkac64ceP42/h/TRA1P?=
 =?us-ascii?Q?eOvtsHt8Pn4N+WYSTqHYvMAbROCCw0YEdjOC4/kKFi3X2KNZzBUznPcp4/Hp?=
 =?us-ascii?Q?SEyCmphWNf0b+owHVwFiGBadsq2OE5O6nnbpOByJ9ki/YiqdeVvZTR2ZFK2e?=
 =?us-ascii?Q?B6QDm6X6+Olao7VHQaQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1c1ba8-8e76-4c19-e6eb-08d99e723938
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2021 02:32:47.0557 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOfcXFV+/QeU44C1EwRcAMp94ey6mZ/V8+dlmieqjNVNOz3mwb/jLfoF392r/vAM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Ray,

That ROCR issue is caused by CGCG(NOT CGPG).
With this patch applied, the rocr issue still exists.

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Tuesday, November 2, 2021 5:19 PM
> To: Liu, Aaron <Aaron.Liu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: update RLC_PG_DELAY_3 Value to 200us
> for yellow carp
>=20
> On Tue, Nov 02, 2021 at 04:51:18PM +0800, Liu, Aaron wrote:
> > For yellow carp, the desired CGPG hysteresis value is 0x4E20.
> >
> > Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > index 90a834dc4008..b53b36f5ae92 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -8316,11 +8316,8 @@ static void gfx_v10_cntl_power_gating(struct
> amdgpu_device *adev, bool enable)
> >  	if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
> >  		switch (adev->ip_versions[GC_HWIP][0]) {
> >  		case IP_VERSION(10, 3, 1):
> > -			data =3D 0x4E20 &
> RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;
> > -			WREG32_SOC15(GC, 0, mmRLC_PG_DELAY_3, data);
> > -			break;
> >  		case IP_VERSION(10, 3, 3):
> > -			data =3D 0x1388 &
> RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;
> > +			data =3D 0x4E20 &
> RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;
>=20
> Acked-by: Huang Rui <ray.huang@amd.com>
>=20
> Is this patch able to fix the cgpg issue in ROCr test?
>=20
> Thanks,
> Ray
