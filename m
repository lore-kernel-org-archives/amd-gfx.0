Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDBCC0015E
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 06:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DF0F10E59D;
	Thu,  3 Aug 2023 06:39:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A11F210E59C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Aug 2023 06:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHy4LPGwMVEU7GNdz8q+m2NBOL+fW9mN/6aXvj++CWdpQGbZ5BMWMAYmkj5dYgkZUQszLXR0tYbxeDlWV/bog+RSwSn+8ZGX4kcuWQvu5jPLGytuhk6/r5aOdmgHY8smdG/ZRjT4tl4ChsEIfN03Y/m6J3hXJHFGW6mVhF3VaPeBUVFNvT5+T8mHhld/5XjYLGaundHzcgm5j/6b28FdRxhFKxCtFtl+G1v2sbVCskXBwk1DDwq0PzGtkPbShvMThOBr9tyKFAzcTgnivwy3VJTtfhlM0iGnE8mW2p+JeqEkOKvC80GkYVCyygG79cNRAUPHwkMrHQcHv97KTaCxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7rUbP52atit2q3dg6VCZpW/sOzC9iGymSEhkHVtAtw=;
 b=P4GIGHtDJRoOiUyjyKwel7OX0oDO7Kdd/0DN52uKk0D/MBX9dEwElN0Ysn+YZ5BZZFWlFWde3EPRrxEWGjKadtxfdbH2IXx2quXA7D6lb2ErBoNxY1ZBNj8d60OTDfcM69z/ZVXdNFHJ98Oy8aJrn4Vg2trvT2nNF1Fy60v2bt8A7Ia7oEW9Kb7aTPuv5wvoCezlLiho8AT8Phki4Qdn68bVAtHf5Y/Dg/L1y+St5SFFRw9bJUOywFgTGqH1mEp5iKQtI2PpwY/VIyqSO3FpTl+fr4Ii1GRHQwH9CqZEjkOfeKhwzJt5r+6ryxBGyC0e8R+oqJJoHQ3w/p+2YgIBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7rUbP52atit2q3dg6VCZpW/sOzC9iGymSEhkHVtAtw=;
 b=nxTplTvYNdNkbU7kjDSJuRCM6M7wyxWC1xGO6s3R6o0zeL8Fdv/cGB42+W+LzfKILCvxm1o+nDHO0Rba77AHh74saZhgajB3O8f+CogwPyqwjm5iw2Bs46e42DiY1FO4HRq/Wz3xcQX5iCv+0Yc951Tk7nRwm0OHWJ9lOwT6UpU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 06:39:23 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 06:39:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Report vbios version instead of PN
Thread-Topic: [PATCH] drm/amdgpu: Report vbios version instead of PN
Thread-Index: AQHZxQBGCaMgQvxVk0ys7fpRZ0BuP6/YIFug
Date: Thu, 3 Aug 2023 06:39:23 +0000
Message-ID: <BN9PR12MB525719C123BBB1440A3DE3E2FC08A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230802051420.238606-1-lijo.lazar@amd.com>
In-Reply-To: <20230802051420.238606-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=982eda83-17d9-4915-966e-9f6b8edad834;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-03T06:38:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ2PR12MB9210:EE_
x-ms-office365-filtering-correlation-id: c34e20f4-d908-4b2a-bf68-08db93ec601f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RcbHblZ+iyQgzGIDUbSRg8QMnrRa/CFwSwJ4Qm5Wl7n2dr6Zy6dZhqwUbe+1A4IV7ORfzmjwmv8YzZlAjHg80d/4uxwqVJJgVkRRFQDjZcp7Q2EstJFeKC5RqAqq+GMD87QPXOlx8DnUKr+lshzFSxvlUFrwWFEuvCpwKoxdLidEcUokdeSSlNck1iSk2hWW0P8jsnSXwsvXwY/K1sYMpAxKoSDSNwAsKgJsu9yDzPSq4+FAbzAFoy/mLC6Z0kkgQ8SpAoS3ReLzGrxZ9GUmKF3iOh96lUiganNljXMDHMXn8DFTR7dVQXBnDaHESzCZ3VHImKUQiXH4Llz83qbwA85AtDz19yHvjI3ivrjqsu4Uu8pYJ8mQugQjzHZjkEdZogpjjcgkaipfu5LDi6Z8VBK12/B/Q/Wdm1WynFHn+wPZuLJUcpU/pII8malZNmzKMEhCUMFvYFyXq31kfbHgg4trqWaND2H+KUzzwVtH3eCNQ4oiopYvaSoj2iV3cO5gTAgD3te+/7fV0yqroH0o1m48mBNW7RtNJ1Q7ZANGm4hsspAzlmksji50tKjhzQqLbv9O87XKrgaCIMa5NYq81cqRwQDEYpNJxQ3mLlHQpDwYrS8vTGUFw/G//zLF84f8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(53546011)(6506007)(26005)(186003)(83380400001)(316002)(76116006)(2906002)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(5660300002)(52536014)(41300700001)(8676002)(8936002)(7696005)(71200400001)(9686003)(478600001)(110136005)(55016003)(38100700002)(122000001)(33656002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E5a+yNzMhBDw/GyGSijuap3nxG5lzxzckP+9dHSVd9BZtML+8iWK+rHYolme?=
 =?us-ascii?Q?9FeyWdFXz050W/vtLD9S9Lg8EHN958FEEzdG3N2c5CDGASKWMRYRQIe7SSYi?=
 =?us-ascii?Q?MGN7lg8jtVgT2U4jIY1EkD/QtOe5RaS1oVebSTnk50DqNvzjDjaxGgov/f9X?=
 =?us-ascii?Q?t5oNy/0PjP/s3IHwme26q6N8I+9wAehdp0FlpqgVw/ktcxCErDRLKB1pp37w?=
 =?us-ascii?Q?zeaWkHVDVhdc+mr/4GEgXMuGd8FRpsMuMt6JQJprXFXF/oJrjzPyzekYmu59?=
 =?us-ascii?Q?X/hwFEJb/0Khov4buMZN72IvEV6GE3ImNTW0QSiEPYUp2dzY7lV7bBP+UW+3?=
 =?us-ascii?Q?WRgNwi/iVw9TTvjQahz76dWidhlsPXL+nqqtCJ8wq5CJoKFnZR+VEuQ/8Ts2?=
 =?us-ascii?Q?R458XcuigdGHolKtszRuvxiIdBmqs8m9xPXl98vsRhdhpD7Af6Z9f+a1WRt1?=
 =?us-ascii?Q?U9y6HYL8TNMhCmjP+/OqnBWRcAwUk0/QEbgzG5wdFgdsvzp0kge+gIPYIKPE?=
 =?us-ascii?Q?RR5GPuusiawfNdsZOH+d/MrM3SPg0vPEmy+hyjJYza9GHZgE3mty0dd22+X7?=
 =?us-ascii?Q?syeSZ74k10F684gXCjsCmlQC2v4s6m8RRSMV8hLqEsMgYyVqwb8K9BGeMrPe?=
 =?us-ascii?Q?4EEzxhsKVtnPO1+fmYmv2C0kTuTKTqFVNsEu06/ppRJ0Pl8BwDcWsXeiTlTB?=
 =?us-ascii?Q?wesI+cdxyu4jiGjFeqhu2BqYUn17I+i8jH0Rny/GnVqQhnKGsLXAliUSf96U?=
 =?us-ascii?Q?wHZho0i0oZSXmLaKdaSs5dNIuz9EHHr+qbD/lviNrKShARFDcTUBoZK1261X?=
 =?us-ascii?Q?5kYuUCtOsz7MHBpuNyVTxC7umhHeXmYiH0NfmsVcJ9vmiBQLaBwlVrf573fB?=
 =?us-ascii?Q?ITZOKcXHheP+NsvrCqa9JyFMUF09YZHO214C/NVqBdnww/c04liJbO8kBNI6?=
 =?us-ascii?Q?JYdB9vyV6C9SKUt/Pmw+kWOWvOi96TlbTCaMYDN2zrFPip+PMeGs+4IEFFu2?=
 =?us-ascii?Q?XFWT+o79ePqpC/du1M8kNmpwAdGPF/pKsuKSFfrqLnFaxM6CwSfVa5ORsZyY?=
 =?us-ascii?Q?WUJBt4ktvtcsYt51bX74gg6iktHDP2+/ozwRvJvwTidqY50A3Yw1w+3v1Jek?=
 =?us-ascii?Q?q/nPLhRnPzQBJdrF+2DjmK0wDdUM3UwHYAIOEHKJl7dhNjgM8bmuKXyv1S8T?=
 =?us-ascii?Q?tY3SkdKomRIfvOzX+WbBV2GYH6Vs+6P9nDdMAom6UJ2XKvlFuxbDRCA+K3V3?=
 =?us-ascii?Q?rrfBP70PMhVRDikbMmAGg5BoqFqaWEZmd/4Bt/VAPcQp72uXimzhAUS1HVpD?=
 =?us-ascii?Q?s6DnI8753M2HLuEDTjuz65H6yk/+4DA3yGUXfj9nMW3UwC+gLz5+33sJD6IJ?=
 =?us-ascii?Q?XQghb5PCLJjoOOFoflY4iqji6seSJPUybLXXM+7ykkuGIRyvNV7HMWQsWF38?=
 =?us-ascii?Q?Ub2uugvFNbGdoSaJNQc5/xGImkgwn1J8/+IQ7Z0O0v06w+phKRoCVfSPw9Do?=
 =?us-ascii?Q?Kuv9oIDY4XHeyhCPQjybeC0eZX4f+IZV/MVqO1NDsCwD6jOhVmkixDLBXkFq?=
 =?us-ascii?Q?5cX01WbfTBTOaPsAfh4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34e20f4-d908-4b2a-bf68-08db93ec601f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 06:39:23.6989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMiO3qYvO+D9fa/oSs1o4hq7IrwAkxyM2Dd9A7TRNBo6e6KdcTC9O0el0g++mJ7l19FFA3pFq/shGh2Ns0jt9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, August 2, 2023 13:14
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Report vbios version instead of PN

Report VBIOS version in vbios_version sysfs node instead of part number.
Part number remains constant for a SKU type.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_atombios.c
index dce9e7d5e4ec..73ee14f7a9a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1776,7 +1776,7 @@ static ssize_t amdgpu_atombios_get_vbios_version(stru=
ct device *dev,
        struct amdgpu_device *adev =3D drm_to_adev(ddev);
        struct atom_context *ctx =3D adev->mode_info.atom_context;

-       return sysfs_emit(buf, "%s\n", ctx->vbios_pn);
+       return sysfs_emit(buf, "%s\n", ctx->vbios_ver_str);
 }

 static DEVICE_ATTR(vbios_version, 0444, amdgpu_atombios_get_vbios_version,
--
2.25.1

