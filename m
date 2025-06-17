Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6902C71155
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 05:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 545D410E4D2;
	Tue, 17 Jun 2025 05:50:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0DxBI+Ry";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7960910E4D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 05:50:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R71yQTpv4JZKamVzKn9tWg3Y+sMsykkzD3cAKLiqJ7OjdyjCXriv6WcX+mKalV0EUOz0uMOALaLSuRjjmrjS2W7irtnq+8Qg+2Z782HrwBDzNKMArQiiPdT913hB6H+IRivb0Bggs+VMdj4e1rISSiuXa1OT8vMtwgj1G3BK/HIupihZU6whOCtDRj2s7+e9uRsSzRLmTQ+pkzuVd7dGONQRgMCpLzX368Th/iaV88PytgDFbbLkjuNsRm09PBMi/DHYIczMYmDVMY54Xpa1uEOzxQye9WgpXZ+l0KTGB4UVrwBAMHVqg7oIpJUpMQfHk7PiLi0Kz7mZzciywAsoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLIYUXBx77z/AGZzh6fzZ/wmR4gJ3VmgLGS8ym5oTHc=;
 b=GwGpjp8iD/HaGCpr+rNs3aVXPr+Dyy0e9OkweFyELjJXldbTSRqqDa7Qw1lHHgSk0Knrd/5sClLG1HTF5/11iGhUH2SZMZUziopSwamXcEGQypisTXqAvevEAPZpumtEZxlzVEEnEMYVYG87cTps1sts21L5jSISwzhv8nZVzM+13sNaZA/VHCkaVPGltsBwP+ECmNBRMUHHM59cjKpoJePGjIz+ioxoNBrbRcwTsY0SrUMauTZq7RtLH3EZwqdJFCaVR/+gPgkojr4OBVOxVD3bIfi3edMTqcPG13iiV79iqnA5QOFeqHrhqi4bYghuAmCE6bB73qM2EnqaVijH5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLIYUXBx77z/AGZzh6fzZ/wmR4gJ3VmgLGS8ym5oTHc=;
 b=0DxBI+Ry5PiwA4Xm1otyO9SSi+ajU/05tz3MhaFXelQuRUgXBJTs6nBZlo3kUBAD/VvbSK9HhI3VzJaH01tV/qi9r//hR91mD2aPphNGCvnttg0C/s/aXKQxd211UK7oMqkfTSbhu81kSL/+2/aFs87I8wPswIHPcUH6cVoMNSY=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 05:50:36 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 05:50:36 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 06/36] drm/amdgpu/sdma5: init engine reset mutex
Thread-Topic: [PATCH 06/36] drm/amdgpu/sdma5: init engine reset mutex
Thread-Index: AQHb3zUo9q2EK1C1ZkO9DE77zqpT8rQG2Qgw
Date: Tue, 17 Jun 2025 05:50:36 +0000
Message-ID: <DM4PR12MB5152ED581B15E675744D47C1E373A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-7-alexander.deucher@amd.com>
In-Reply-To: <20250617030815.5785-7-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-17T05:50:26.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DM4PR12MB5937:EE_
x-ms-office365-filtering-correlation-id: 74400355-64c7-4d7b-c35e-08ddad62e1c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/Hy/rL22QG4uRJ6mf1S9CXcyI3vAlI2Y62m9UAmrmLtdXoBU2fwc64y1k56n?=
 =?us-ascii?Q?qKjZcch14j4+A0g48u3Be+iGUwTjAZPtmEnX388NIHn1qIyjQ49R35+sX0PQ?=
 =?us-ascii?Q?AzydpRQXxc4LE6yZb7gvK8MnyR/EB9RR/ek1riDmpm9Gy3azTiwpkcdyUPhy?=
 =?us-ascii?Q?8mWcvcFiM/v6hlPxQ47MU0VCmkzbOr2ikZfqa5+WM9pI1HB+RWgGEH8YBsgN?=
 =?us-ascii?Q?nuSOfD6NszSRMSmHM8Hm5LLsFY8xP6mKL812QDq+xuxS3RO2OhzOCAZ0nNWA?=
 =?us-ascii?Q?PDb0vkfWxupg2SMztGmPz+wIj5b/Y7osxOOx7AQyj3NKY8CCYfDQFPO7SCh7?=
 =?us-ascii?Q?5XEizw7PqJ6QqInZAZSaZOyHhFln5l43RmULN9HpiBhhOahHkD0tWRK+HLnc?=
 =?us-ascii?Q?3zOpaqdpInkVZyJB2k0rywlJ7hQy2ZEe5NLGf9VhMj31EoWZYUt2lMo387Ii?=
 =?us-ascii?Q?EUzE0nzdkHN++ApxKYm/swRqKGAKWzSdOSxH6Rj9QYJKkttdptlWI8qUhPVf?=
 =?us-ascii?Q?awk2KLgLoPMiD/kC7n3uhty11d3GWmYXYYciOSswL9HXINd5uAFVcb5vwD/H?=
 =?us-ascii?Q?Jwe4AzKPX3xz16kaSveARa5u5c7choPIqQhQhja/r0Nxh66K22ExghVcuH6A?=
 =?us-ascii?Q?R/YfeMr97PjgTHMdcbv1Jx5AJC9PVFZQgRg/TFgU9wgCtoAygfHOOQkkqc9m?=
 =?us-ascii?Q?ceRocAG/brD53cwEJe4ZkMex9yjgL5an1FMgq58QN5VJ1pUVwBQr9xsQyvql?=
 =?us-ascii?Q?UvbsaoDOmqZTbw9BBSe2AipC06zQCC6CXTSqVEl2SOF2STE78pl0cqJBnLS9?=
 =?us-ascii?Q?KFQVFOoueosbY+VWcjwwqMAsihwB78aBYn50zwJYCB8Fi35JC4d6ybBlGYLc?=
 =?us-ascii?Q?kDsNJ64oi9MiVANWz5ocKDlETRltXPqYiPVhOLgkst/zPPa6FtVNi7kbTj3Q?=
 =?us-ascii?Q?z3b/sZlLp10/gUm5aLcv3IjFAKguydJF/YK/A5YCSK4vbeK/4fgSQ9zMCHHJ?=
 =?us-ascii?Q?epWbZbhextUtai8c3xi29CEECB6M4SPpPzHV2FIcu2i1EbJyL0wXw4nXgt55?=
 =?us-ascii?Q?JrLjwB6bxWczp4KDIBTV7wKaFoygdL+jGpfR7rB0ulZFboMVWYoGppLNQQcn?=
 =?us-ascii?Q?kkODEO6MVmN5Yy/lzNlStpM02aWrsWO17hhBzX4PyL8Pnb/OF9dYnYztKbig?=
 =?us-ascii?Q?h5pPaN/7GfifFzp5GXDqd5Ns4VCPHhaTpxUBzQONiAjaEe3BobY4Fu5i8/rc?=
 =?us-ascii?Q?gMPZkBu84i0sSom8KcaTsloo+E1LGa2UJNW5QxMeq17A7adrxKle3/5njjCG?=
 =?us-ascii?Q?rOjSfLFTtwuCWGqlSQqEjBlhcxxMyeXj5XOIHCguKWbablrYJTa73eZK1jc6?=
 =?us-ascii?Q?Tgnkc6V167+/2uL5LAa3yjE9Ve0E32hrIiKOxzFrVCqAeXzCsImbFaO51GLG?=
 =?us-ascii?Q?pV/Wl+eqBMj/f5NS4IfNSCIvW/ehQssJhCGl/n35mi+35DCi/rHYHK6zl0p7?=
 =?us-ascii?Q?CoD0WGf+OWQLCrM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PjK3gPuVOz8eJegNHJc42OqQn3T77yDxAgrzRd6umceXnWQPXd0nZK3jCd32?=
 =?us-ascii?Q?cyVmhwpW8T/CAUgVQAkIkePXwan7FhxAS+dIOkzwWC+3tCLq1WdDRCXvnAFE?=
 =?us-ascii?Q?IDK4iQWWSWwSL9lH2aFvqyJCeLLQY9df6+BQCLvH0vZbr/DsYAvbgCbE0SbL?=
 =?us-ascii?Q?SYM++C1HQeVTlJILso8ICfug8R1wSQJpx3WtiF3J1LU4L3/ecWjWqMRu8AET?=
 =?us-ascii?Q?MkAjWsMjkQBIn9nMt5cJhWdO5rqmpplosumZJpKCylyifwMpMATfiM08w6XB?=
 =?us-ascii?Q?dIxiIAjLusYGrcJ8i4bWOP1wo1ljzsfNvo6J4u4fR0WnGe7VyhiNG/OUkU6D?=
 =?us-ascii?Q?smhL+4TbBzGqdrs+O0EmdJpNQ/ri07Jwf4EtznVC122Brl3G25KCJfvIpfEy?=
 =?us-ascii?Q?F8XO/ZBJNE6XwaWyuZ4pkV1lJ/xz3gGpZAqMted0nGgAi3XtGLipjVnmQmSp?=
 =?us-ascii?Q?OgRJrNJcsmgPIeoUDIccqG86Dss446P3eDZf8NVppi7uZyznAH+pBysmahmn?=
 =?us-ascii?Q?3F3ulnTFNVDZ21ic0DkCbpk09tYgTJNkCXGmcFFnuuZCwsx+KDjMuDFYn3tR?=
 =?us-ascii?Q?GDDCqtwPAMIXTfbcLoxyv9iABJqLdI/rUduA9H7Mj3Zai7RZUXPkZiw6pOU2?=
 =?us-ascii?Q?XX3hPFuki8/6nsCAF8Zp1BbLn2q6+EOj86N36KEMB/WSFJyXZ3EVSKWcSqCu?=
 =?us-ascii?Q?SwnJPnKWdwGFfEXY0eq+WHXZqypd3wAy6P+TSUfzQrYhVMhDG9HIuTBgbPN7?=
 =?us-ascii?Q?ThRcww40dk5Aq86xu3yGi3mfy3ZwY/wz4P/IQF+HoSd/qbbQSwqqVAbiXClo?=
 =?us-ascii?Q?/Z5rZs8HEWc1AYuj5QA8Zj/SuzplV0GSyt/eBoS26kwiXWOxWe79xnnNZrHG?=
 =?us-ascii?Q?VR1D4WUNmJgaFnHQ7TTU2tDdVnqY8hhb+yfQm/Wo7y8KB31mem9XkC0sb0Q7?=
 =?us-ascii?Q?AXKMeSTpRJK9sA+oCgO5Vks4STCiJPpIkh3WKwzn5Th1LajftL0XqObLT82e?=
 =?us-ascii?Q?lq5Qg7N6Otb/9gWfz0hkHPgAawGZr8yoq9oxRcFvFWnzNWC1I1Fb1V/pVRah?=
 =?us-ascii?Q?+LVdGUunRX9YRm8C+LAg9lBGhhhvEqN0XOKfSPL65DsrCi5pbw9xqfiL2JXG?=
 =?us-ascii?Q?A0ZdAdaa4HNKFE8V5pITfsQM3fVyv8jyP65iXGz05vOqvJXzjuEDmnT2iUqs?=
 =?us-ascii?Q?qg5bRX71Xayu1tAIIgUzo4IcPZ284Zxadmu8cxvvnvDt7rnrqwF3Scej4g1H?=
 =?us-ascii?Q?XnHAKNsNScFUF9+vKyvGupUU1XS0zuQLDmxr6PCQH2w+H+RTCjfY2h8XwsrS?=
 =?us-ascii?Q?ZwigwmiSI6RhusUGtxTgFa+q4otOp7p8cOu1vwGt89BxtXPyU7rrVlO7hLOd?=
 =?us-ascii?Q?9/gxPCyvbnUCClNs4IjuVMr0o5lGh5UDkBiP4Zw3CEzB1fvK2v2yKXxaMNBC?=
 =?us-ascii?Q?Cm8gnnIUEJbHGJu+GxPfWHgjTTHYHOcjYbyNhz6i6kx/y+rxEi7b3a6RuiUd?=
 =?us-ascii?Q?/w66S1QRWcFV/Fb5BgFWetBYnW4QeflExP06cxygmATu+n3GZRweAK9KQkZU?=
 =?us-ascii?Q?wB72O1R3V5EpbtaIkvM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74400355-64c7-4d7b-c35e-08ddad62e1c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 05:50:36.1789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RndiGiV6g3qh+MWOxN1bJtt396teqsbX1BJPTV9EWRnS++1LnwdUMKfY2ImiZqqc7RqDatbd6fmkKZuGNyV7Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
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

This patch is Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, June 17, 2025 11:08 AM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 06/36] drm/amdgpu/sdma5: init engine reset mutex

Missing the mutex init.

Fixes: e56d4bf57fab ("drm/amdgpu/: drm/amdgpu: Register the new sdma functi=
on pointers for sdma_v5_0")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index 2d94aadc31149..37f4b5b4a098f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1399,6 +1399,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *=
ip_block)
                return r;

        for (i =3D 0; i < adev->sdma.num_instances; i++) {
+               mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
                adev->sdma.instance[i].funcs =3D &sdma_v5_0_sdma_funcs;
                ring =3D &adev->sdma.instance[i].ring;
                ring->ring_obj =3D NULL;
--
2.49.0

