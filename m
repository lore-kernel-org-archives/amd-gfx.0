Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B42CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 10:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB5BE10EA71;
	Fri,  7 Nov 2025 10:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AVdoaXTv";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EC8510EA71
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 10:35:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIUW1K0aBxoKAmuZ0TrErgV7V7Ku2r1vjTZw5kOmx/sozCopud2tG+zTsUJQaonGX33pOGzus/61lSi885/yOo3ADNUf1YdOgPB0P3BCAwjYv8mnqBn7fonJFJLBjLY9vf/ITcV5OQDvTHksw4vFaxVkjnOzTIZBIhhX6doYagxp1XG+OmvQzFvy1vaz1YK1o9b9mD5Evb9J/ds6FnJaAo2jreInTJ353X0GbyWOv6HVbgvY+6QavH+Zof5/Ja6lpT/zCbhcEo8j0NM6Wq4h6019RcrpM0W6k2HuDCbSfgvbdOFEkKqSuaClKstknU5CPbq8h2rvied3adei7Ry15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=US9Ez4wQUxPBT48PKtfMPLRj22UEL2HFXzp8tPYF2R8=;
 b=VH/UwbNVoDDr4kBJCGiM9Cu/h/osgG4uvgBWxr1+emB7YfCBfcGTtxTU3eOCqhuq1niUUtMb6TTzrB97i9LTGRhWjRT6LSsc0V7iqzNlT/pGLaHkWDh+/eS6sY8MOdGpi19Bvc5OJM9cHPqoPSh5ykvAKvd0TY9Ce9nXpoRAmlApnPSA56BDRb2Rd0l4yYma5PB17+fh6f5w4BU8/DbpueO8GWQ/ZHUYPgev2KWjYFqab2IH72YZ0sWLWXGEOfUAQS0MrdrucJl4dKaFassZ7FEigfe2yJa0UcSjYQo5cWZW2DF8VupRnHgQrJ5pxxFVCzLZco+NQw0a3t6ynVkrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=US9Ez4wQUxPBT48PKtfMPLRj22UEL2HFXzp8tPYF2R8=;
 b=AVdoaXTv+x3akE4IjtVcepBU2C1hyZF4PiAumfJ/CE7Tca0sLm0XY/YdtEmOy4vZ4C5YFYcj8o9RhAR1FpUz0UWeacVFrj3qj+ImnHHlvikHyOdJNL2UHK55ymOeGcBNVFhpFdpYtk8yCQ7mnEL6FUPfqCgoFfTUc6vRIsjO4tM=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SA3PR12MB8024.namprd12.prod.outlook.com (2603:10b6:806:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 10:35:26 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 10:35:26 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Check if AID is active before access
Thread-Topic: [PATCH] drm/amdgpu: Check if AID is active before access
Thread-Index: AQHcTx/0GLojJUlwoEiXHDKh1rZ6g7TnBipw
Date: Fri, 7 Nov 2025 10:35:26 +0000
Message-ID: <DS7PR12MB60710060D11AA1F15031E05A8EC3A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20251106131848.943373-1-lijo.lazar@amd.com>
In-Reply-To: <20251106131848.943373-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-07T10:35:17.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SA3PR12MB8024:EE_
x-ms-office365-filtering-correlation-id: 458a7e09-abb7-4183-4cd8-08de1de95d80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Jpa9EskElOgVeh9tgY9KW0TbW1HoKQGV1DjXO6t746bZU10SYHW3fBQBIq6u?=
 =?us-ascii?Q?ZMTkI2LzqNHZUxngyfRRVww8nY1jti/b28zw2XByZZAxJvD/wwrPWDN5DCuX?=
 =?us-ascii?Q?QLfOd4ayy5OXOpvWmpCV3OE32mjNBTnVJxYuar9/Y5eLrtoUutjS9zw9wnVZ?=
 =?us-ascii?Q?nepPEMX+jEO44HvL9JAZozKQyr/RFxNBOACuTcDo2CPjuw+IcBuNrXK81nHF?=
 =?us-ascii?Q?H0AeCuHyzdCDwU+yO6sWg5LUJt7pd57cZTPG4uwv8R2qkOnaCiDKUZcA3kJE?=
 =?us-ascii?Q?W/2Un7GRQ03EIUZDfzJK9d8XVgcvDENmudHV1hy/4tGxpMXJxIsvJx2yYgGN?=
 =?us-ascii?Q?LiWJNm/ah7jWUq5jVzB4EUINBmN4HgclnyrCRp3/m93AjlTNtRaUWqAwHo1u?=
 =?us-ascii?Q?VuiXrA3iQONAYFEHb29F0jPvrPC/eHra00e6H9ZIwdq9Y78CkUOG1DSMIMCw?=
 =?us-ascii?Q?YZNL44ys4PqXEhn2u0Z81ZXa3PL+g+HsitONuv2yquc9DLpaRENYlRAneo+Q?=
 =?us-ascii?Q?BbfTHy+tKvEcbd+9m1Z/V4xe1XltQGOaiQJtA2vzrLMH1zA3JBEHS8zLV6qH?=
 =?us-ascii?Q?itrEAzLAYHcZ9x666FLtbnZXw2XBYQkn+7nLbqElU232/CMuB7w/fqSHR1Dc?=
 =?us-ascii?Q?FgaWm9XA8WwfoASi1YDAeq22htLMo9/OPWmniDal2ymeASAqmBSwd99lRy99?=
 =?us-ascii?Q?SGM8Qm5hUVo3eMnLRBNYUB6Y5RgaiwjMq15al57ROaVM2aqKeLUuvsLO8K1m?=
 =?us-ascii?Q?QzHNQHf5hNVQ2m8xQ0MYqI4hq7xoqrUUzFfUhCRtf+0kHP755kHz6gr31rT/?=
 =?us-ascii?Q?l3AG13hxA5K1G9ONndn/jAB9UpFskhfUYR5FFqNMiqN0Xk8Y14I42GAfFvm0?=
 =?us-ascii?Q?07sGmj2g56okxV1+7+4rcxr4JUsZL3Vl8ONy4q5Wrs81Y+TKagimdJQtey6u?=
 =?us-ascii?Q?PntZlo/eXNpp1DcJvd/LfBAzuUjeY0evKL0DfIz8o20mVCYlcJ3SgAjUz7yz?=
 =?us-ascii?Q?GWnMFi5Wo+r35BL9FmkfWrhNSYHPRCOkXqVhEopZxMcPGll825s0f1rxJW8X?=
 =?us-ascii?Q?xcPbl70dvNEb4XxQ2AT3PhbKo7YkCe4uWzVSuYZBwEm9vzBuTmlfxnJHedge?=
 =?us-ascii?Q?Z9Y4QnBnRyx8H+VJ1u5ZgD02++HHMAw/OyKTfTF46++B8FSAAYoqbbKmRVLA?=
 =?us-ascii?Q?VKWbPJPyAkzsq4GOiiMGWc7nnt9PXtA3rBa3/DPVLmc5AbVDPDgX5VHnZWo2?=
 =?us-ascii?Q?YnisAqf9jL5tTRC5+ACvCEOkMw+8vWnBEs95cYg7Az1xa9sZyzn+0DQ5Q6nd?=
 =?us-ascii?Q?JtfPXfakmbOqPLOJ9R25Yw4LHcPJ4MYvExzDfIxKiwyzd3v+HWns8hGpKIqk?=
 =?us-ascii?Q?c386MzuywASt6SqGathl2By64ybt5lmcDl1XqcWGJ7GlctPfyA6tpJmPvwDt?=
 =?us-ascii?Q?E59+3iVtrFScIkBr5u81I1xt540TAxLszEssyTZLtp9tdgDwbKmcO8rjJfHR?=
 =?us-ascii?Q?pDzmq/el6jbLlz1uyhRdzgdEIBj+hh9OObZd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HBc1mt0NT8P7/dEMB5pqJsUcjb3DhmYePD91cT0PIFPS19UqtSkLJRegEJnQ?=
 =?us-ascii?Q?9iyuENrolQc6NRKOw64GQKuwStaL6Dt3mlNwApKwf/bmqHb0D2DQxo7gYTbb?=
 =?us-ascii?Q?k+qUNTAEBIDrMY2Yd1uaQMz/dpmq4ERRJ0TZaDY72k/gCe7Sfqnklc28P78r?=
 =?us-ascii?Q?WxHBS1Uu3wAdV0Xcl2/PjHv/v220JYiMlDDeZh6t9oBnN5kJYjtcONwxh0dg?=
 =?us-ascii?Q?ShuJZEsi6XQATL4wju2qXsH1SkpucpjzUJTvAQWyx4u05l/tQ+bTwl26obAv?=
 =?us-ascii?Q?+DHnlxr0BWtBKctsWatq4f6ERoWy4OkRws6BxTDFuknvZQitCzM5rGWtXKab?=
 =?us-ascii?Q?eSAdrE05FehHaytHFTZSw+IQ2q3VLY6resyDcOKTFs3YWLHrfqb72aR6Pop2?=
 =?us-ascii?Q?/DXxaG4RglXR+r43Ki7aOn+UwNwCdoVjp7TsbscBmjUYGj5RglFodvxSTgx2?=
 =?us-ascii?Q?KSHOL5DFInZHJwStUnkR7cKQNa2z0DHxdx6nDs3UUV/9RhKU/SoWrqHwmHvm?=
 =?us-ascii?Q?WKi421rk8L4Wei23bo23pJdpwreil+g4pKgdlziGorI5f38tzGPuG+LyCgBu?=
 =?us-ascii?Q?ay8ZzFbgSHxRNvTmW9h1r7pGVGCD2uuvCkeUxr1rmH3tjXqLTq4LR2l8C9R2?=
 =?us-ascii?Q?0/sQhEnL41lRbdOlNPo0EwvbUpbVitsyzEXqZ5HkzDAL6VQbK+1MCfNdJAPt?=
 =?us-ascii?Q?X8n9ZJECLtZEocE2x7IiZPZYNYc/9S27wpUFQFGUlxZuBUHbo+MIHIFh8EjU?=
 =?us-ascii?Q?hrg/LwjwHr7y770ux+nqERNiG7DhfGFpUi1mcfp7PtnXCn+pI+2JmoZQXZcM?=
 =?us-ascii?Q?+DzK8mIldExjxWt6yXU3JIXOvoM9kwouaRhUWuxqeC6pJ8gw30Om/+ukdQIa?=
 =?us-ascii?Q?JPobCygAKUnjMXTMLjC3NZqqib2NZyUzgTf1JDowJJduJ9QwOeAtUFc4ZWZm?=
 =?us-ascii?Q?HNS+WuPTIMHq6LTEBYCQCJOH9QgIZu2/qzT0sgxL3/2umIUysVHKcyGtOrwE?=
 =?us-ascii?Q?VbvODlrRKxpl88tEq1CJzt+kANdM1SE9TEkukmtW/0XIn1JCshmfxpVbUzXX?=
 =?us-ascii?Q?5+FORwIzAfENdTV2JzZxu/Wkrtecvt6dCAaecBW4kvdYWpnSl2h1aQTsZJTz?=
 =?us-ascii?Q?/Pnm3WojYaUHX4w04u6YpzVk82ejttF9R2yklwf0lOr/ayUHz6AY/xo4iosj?=
 =?us-ascii?Q?VQw9n+zvWd/qIch/ogi3g/XJyrpeDNSDahraWaFjbxBbuyHVjjWTn229Ptsk?=
 =?us-ascii?Q?ii5xrfXVEJ22jA7D/XX0FMfCfNkvXD7ex0e5BFd/mBiXDtGjtWsOCJylKBYX?=
 =?us-ascii?Q?UiSpDwE6KoiIj4NnSlD1/x5NMBsd4rAMyL+GIygBCAJRLBfXrtDWQAHEOGFz?=
 =?us-ascii?Q?lFptJOAF7Ki3HpMkTTT2r9QXn6HsEvUyQQBeZi97Sn/LmYnasuUyMbPa7IAw?=
 =?us-ascii?Q?T/T9UaCppTZOPZu6rRSN+OZo+Ju9qtBn9pbSOLglzUITopLgMiI4uwRC3kBx?=
 =?us-ascii?Q?HSkoxz79lrlemUQrxdPkHEdXjSb0rqPDVxzP3E1R8kyuWSpduWd3H2857S7d?=
 =?us-ascii?Q?uFdu6gKIMK/y0yabalw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458a7e09-abb7-4183-4cd8-08de1de95d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 10:35:26.6232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: onZbMqtjTYoUsEW0CrMFJddnvgMkDc4Stw5nHxOqz2ZB7108ext4pa/qnYPy1v24kDSwrOiWwlW58yBYayp2fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8024
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, November 6, 2025 6:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Check if AID is active before access

Access XGMI registers only if AID is active.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 1823ce74b990..10e42b0ff7a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -336,6 +336,10 @@ static u32 xgmi_v6_4_get_link_status(struct amdgpu_dev=
ice *adev, int global_link
        }

        i =3D global_link_num / n;
+
+       if (!(adev->aid_mask & BIT(i)))
+               return U32_MAX;
+
        addr +=3D adev->asic_funcs->encode_ext_smn_addressing(i);

        return RREG32_PCIE_EXT(addr);
--
2.49.0

