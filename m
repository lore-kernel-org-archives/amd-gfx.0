Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779AFC77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 01:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B927E10E05C;
	Wed, 17 May 2023 01:22:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B2EC10E05C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 01:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3BOrUhwVxXWLqdyul0H753s2VWp9t/2qSLdFNXqSMUoNQszojgs9x2gwz323DaqEGtW7By+gIIO5BhqJkQw3MF5Mc3DmVdzt2NBO5icQ+DJOPd3O1Mpmix/dYnML1jFnE4QYSxEN1v2JBQpZiaTBrMCtpSL7fdEQ9IAzY5B3rCC0anF9S3ZpBVJqG5rYRVyoSRUUZP97dxXyC6h6zZWhm1wjRkJP/dXOKEm0qAEEWaSzTi5DceMHJtrTRY1B60T1KGHVDt23rk3VAOLb6WXvZbD4xq8FbqpYBjherNHmtC4eack9/L4889VI50Bm6tK7PylvwOcEuyJLCqCshWqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkeeEoDX0TV3n3aEc2sYeJrHq/90bEPHEmoXxOwCZVU=;
 b=lc/NiGlOlYu9qV8rM1T+3oaHQmrTVAosqPBinNlDu8Qeen1ce5joIAil5WXqmXYxa+gxLH7ioL543nEPJsmTrWQOZjkw89NpBajgGDzInd8XsRs1S9EjUqKuuoJNUrjwK7hAlGosM8GKzUgSmlRjxVaXUABy3grKEmA2yUkZhzH+bRNa0U8rvDZ2e5iJ8lZZn312OPHpc8K7yOR4O9qqus7OOlpYNqTImtkJNdZiCvEnUjJIUQ7VD7H+CLQvd+8wLyqwZ7mqR6loTwS+b4lT73PIaihZEqy+6Y8oDsHgttodqmwh5YAoAhP49ZmZN9+RvxZFgjBHsnlWELnwfWQ+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkeeEoDX0TV3n3aEc2sYeJrHq/90bEPHEmoXxOwCZVU=;
 b=5dDCUPhjm2DYEe8Do49RuM8aeHfsJw2rPfrQVZdQmgeUSe9ZyQhLjAcJnN/n/xEhNO3V4slBb8en3NJ8edAzfLHqXh4NyBwuR3EewwFlxsr7dP3reHVfmnOxqzFSPiSHBRtlzaOWCOWV3alaZ2wZltXTpYTA8BfYnSv89ZEN2CU=
Received: from BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 by BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 01:22:54 +0000
Received: from BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::b67b:3d67:6ce8:301d]) by BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::b67b:3d67:6ce8:301d%4]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 01:22:54 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/vcn4: fix endian conversion
Thread-Topic: [PATCH 1/2] drm/amdgpu/vcn4: fix endian conversion
Thread-Index: AQHZiDv5kCIZaSAaQ02ozcatnOUHy69dq6iw
Date: Wed, 17 May 2023 01:22:54 +0000
Message-ID: <BL0PR12MB246555573B99E24DBC6EF09DF17E9@BL0PR12MB2465.namprd12.prod.outlook.com>
References: <20230516211811.2979728-1-alexander.deucher@amd.com>
In-Reply-To: <20230516211811.2979728-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2465:EE_|BL1PR12MB5319:EE_
x-ms-office365-filtering-correlation-id: 5b00907b-4f78-4dc4-bdfc-08db56753d76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F+zIR4BFO7Fz/DKKDMn7FWlRfA5JKUP/VDS6c7d3wB4gQUMn2Du/4qTyNQziafDqRunkGpxEmGC/s2iImlqwGLTsIIhclZkz0BlWao44zudWzV31DGOLpHF3E+W4PDz4DrrZAx5jauIBhE405iEa2mEYRWrHTIF1yGe5cxsgTpJANoDrRXn0m3yoL35OBtpu1gjZVz+CN+T5JmfNYsRfhFGVbP34pBBmcZ6D4rrz2W7CuKadjuyPsUjJsg7DqoD6M6Rty1rBlNBOHHoKC1fOVQnD0cK+VxFRyBNrXXaltIHMxNw8fcZyEw4KQ6G+3FkRdsePAvu0EqMyEpjZzJS2OJtYY8AvSFl9XGDcxILSiQjnQOPh53wA+jmWW+VVqSLVNGdJRKpuKrdALQIRZoaUm/3OO5rwrNNsG09LSaFI2OXHem0f9w2MsDQXeTcLd+JH1bXepHvqYDMQ491uTHpa/Jc2wMMSFk3jaw2D7WEHFvfCKpl03HSOGdZgxMtFJKdpblHnwBL+VPuIerueHVWWHRekI5WGBY5tQUlogB5Ng2SC3Y8m4ymRsRBNm4G6EiPjnO80y0lBYveIq5vDjW/2UxPr5LlvdAFMsT/trgw2xBs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2465.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(7696005)(86362001)(53546011)(83380400001)(186003)(9686003)(33656002)(38100700002)(6506007)(38070700005)(26005)(122000001)(52536014)(71200400001)(8936002)(8676002)(5660300002)(76116006)(64756008)(66446008)(66556008)(66946007)(41300700001)(66476007)(4326008)(316002)(2906002)(55016003)(110136005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+BZYmtejefT7lV5JfMxqcUNb9j9kIhp1VsLZlzJfHn/onHAI3IjITy0x/3l9?=
 =?us-ascii?Q?4uVFLgXmVlxmKaDsxAITRdsFDndDojdYXH/G3Ux3nHn8yxlYBlUhEbXG88bq?=
 =?us-ascii?Q?JfaMHr9x6umVGEbacNaxo3PJjGWSGUpZ7trJ3V2/CTgyVZDLjhlG+aJpw3WM?=
 =?us-ascii?Q?IDtw77bEIwhgprcihv24AVJKrYA1NFcO+ROBPMFG3xiTVYZjQWOgRgM5Z4AN?=
 =?us-ascii?Q?RjXpmfdlnj3BbZqFYCH96stiS7M1/WOKo+xu3ng0+8oYUFTmgz71HVHoqT6m?=
 =?us-ascii?Q?yJ2VLTSd6azselYLzGESH79v7sm7VzZHN7tkM0rR6wcSRR1kORHu5EHjD510?=
 =?us-ascii?Q?qisdk1UAdrWg/4ScTEWK3/c2FGBmfyudh1aps78bGzPBIHT3Um1l/sd7wvzt?=
 =?us-ascii?Q?m+1TBfGStlTZwtOEnn8Xa3P3/RZtRhLGRPWJvHJBFciPBwm9dIgXM/Db9SnY?=
 =?us-ascii?Q?PTcOGCgV3EgEy3P0Hs7jC1GGc9ea204DTGowbbWFd3sLNnDFrHqYjl9w0Qfk?=
 =?us-ascii?Q?ChQjEMsOJ43ITSx15pc66lhNkjrbO0e2Jqfitn+a8+c2Ri0DXJKJJdrZl8eJ?=
 =?us-ascii?Q?th1Ve8vr2M5L21CfKThaILwe0Ae3cTBsb2+TF1KSj8ArEFBW5/dc3XzPVVNn?=
 =?us-ascii?Q?+lhOIntbYI8IpeAFts/pJpz95GASWWU435ZPfjdCnjE4Y7rgPzQnLEYieSin?=
 =?us-ascii?Q?BDsscJ3IMzQ41s/zmV0L3X13bZGi+Bl4E1VnX2JJVSwU8GwOsurr4EYjs5Ls?=
 =?us-ascii?Q?67GHhCZykhkEM+hw/vOMSUbbRcTjZWJuV9JZNlTmSVatz9joNHaa5310ubFp?=
 =?us-ascii?Q?BXIn87n5Yphj0YMXMJ71xNJThxyLJatPnfKh6UVhBZ6n7/29R8h+KBEJ3vnh?=
 =?us-ascii?Q?H+bE77sfgi8UDRZWk73ThQANwTzfrQMSWaHww8paUV2TgfDR8iEBpPxne1xp?=
 =?us-ascii?Q?2ko2O5NSSb4fSVWTBTW4rkcnFKbQig+wkglqF4xoQImBUCN0bPpBl1uCZW65?=
 =?us-ascii?Q?OD1iccnM2cYYTuHmwkH4K7RZaQ950kdbfiguFGm5WzGv4VWu0t/Ivk0H8dPK?=
 =?us-ascii?Q?kWZ3dqy/vhEGfnraAoQg5QZ0m/qiqmhWQ4RD3bjUhwpUXCRhBnobp/U5RZZr?=
 =?us-ascii?Q?6+t22+o+DdxoWafmyKKpmZRNrDC8F8ksZ9IFAB3J76A/XpNDlmG2ZDNU2GUi?=
 =?us-ascii?Q?KTcX4jkc/WLbFtIjdFBfj/lo+ihIUsuOCZ0LyHy/F0PXwDe2+AiOc5fKldWj?=
 =?us-ascii?Q?lgnHHRMGSFOwFGkAPjBanrhwB/G8RCgCPnTRsbmcG8+zUB7V6iY4SkblAICC?=
 =?us-ascii?Q?MkXeE2ph8i37rcDDD67ZlRY4hVD4NMTRMQWGJXpAKmLNeebLbE4e4X9TzbK3?=
 =?us-ascii?Q?jX3Vpy0PYmt3BjNVrr2QdEKbeal8Ep5IHr4Xjn34pvGh06wrDyopk9TIaNf5?=
 =?us-ascii?Q?xsr4utC8OLoulZ1b/h/ZEuZmz7JzvRRYanDY+SDduTjyJ39jWUtCCObU3kop?=
 =?us-ascii?Q?grfD0icL5aMUfXd6SgQjA/ui+/G0G9UaE+TcLBj8dWj8FwIhrCqt1Y+rwGt8?=
 =?us-ascii?Q?7ocATEnACt6Nx3IqM/E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b00907b-4f78-4dc4-bdfc-08db56753d76
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 01:22:54.5331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q52rqxHJV1SyZ/HWLHhvgaE2jp/X5cH8kZkk5etq+F2qteKxEVOiwrO17GeDKxbPnUNwt0cFINfjajp5R2ddng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Guchun Chen <guchun.chen@amd.com> for this series.

Regards,
Guchun

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, May 17, 2023 5:18 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu/vcn4: fix endian conversion
>=20
> sq.is_enabled is a byte so there is no need to endian swap it.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index c77ceaf53dcd..339842382a1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -124,7 +124,7 @@ static int vcn_v4_0_3_sw_init(void *handle)
>=20
>  		fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
>  		fw_shared->present_flag_0 =3D
> cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> -		fw_shared->sq.is_enabled =3D cpu_to_le32(true);
> +		fw_shared->sq.is_enabled =3D true;
>=20
>  		if (amdgpu_vcnfw_log)
>  			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> --
> 2.40.1

