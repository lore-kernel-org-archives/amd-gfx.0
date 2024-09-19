Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A310CF3971
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 21:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBFC610E774;
	Thu, 19 Sep 2024 21:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xUcD3au6";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E6C10E774
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 21:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9CF88Dxq751K7QEZ6yPyXNAQijb3zCRCePvv2pgsFCc8+Fkc3IJ//jsEY10cgunMZhgYvp6XGxvhpUXF0sGrp8iGTskQloyJv/XOZb4gjIL6jNIEziHvLmaAxZ3ph0r7Y1UbO/Q1fC0OyoORBGEOzuRHRuks8OBvYNnLnwTg2DKBr57KfsW21x1cDQxHKIF/j/c/JrJCzCRFII6/olgzf9yzaZ4T/kexqVwtATuGRRuJ0KYSaOBysDoOzz1oKlMWz09VtvAUrCshKLut7BhmqQTNT9pImDgoTT524QbcB8ZKuryugLb+PIPszdjlsNcnvTeXkun2DAj8gkORSvdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rY8pfCftMMehLAjPYNU0G2dLJ2i4GyRuv2mPb+EhJeE=;
 b=rzUNpqo4dJTC/SvM7pviiE4thmOp9oGX29nMHucbIodfURG/GAWKBkgSQaZMSUQtbKfEcPn6g3wG4xwn9DJ3zpEdNi0+F71E/Yxkh5V1jrfbrsDnQ0tDqrr0liMiHqQ3hdMIJC3uxVzKMIx2+U2sSeA4lJOozgTMp8wfxCg62BsduFjNa4+tuNxpNVzVdLe0pVk76UYkNK1m2Q4NUJ0SSIcbsp6GfGFYKHSwJtGma1d7rDkll33blR0kFY5blE8+7gsN88F6jnGqDy9qV5DtEVQZKvUTlpsPKKQDjaxAquhLsjO+UCljEmg1FUI0QZAKWcDbPKjYWz0fmSjuv4uX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rY8pfCftMMehLAjPYNU0G2dLJ2i4GyRuv2mPb+EhJeE=;
 b=xUcD3au6rtZYkWHGE0cItshhK2Hi9raeJTEi6E97JqedajvCCe4eTPM4bT2sDfjyYjaaQoBCDgf/WKop0fl0DhM5uwvt9yVZwH6DzOQrX5zLZS1YeiiPApB1xERJq8adAbgVrJ7ZyvDkldppDAWcJ4/tf1Lj3/Xx6pqPjgSbzvk=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.16; Thu, 19 Sep 2024 21:06:26 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%7]) with mapi id 15.20.7962.022; Thu, 19 Sep 2024
 21:06:26 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix CU occupancy calculations for GFX 9.4.3
Thread-Topic: [PATCH] drm/amdkfd: Fix CU occupancy calculations for GFX 9.4.3
Thread-Index: AQHbCruBbQVui0hPx0iEyKDPy0vWgLJfhnmAgAAPgeA=
Date: Thu, 19 Sep 2024 21:06:26 +0000
Message-ID: <BL3PR12MB6425AE615C7DEDC23E45343BEE632@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240919174326.4587-1-mukul.joshi@amd.com>
 <CY8PR12MB70994C6CF136F1F1EADAA3018C632@CY8PR12MB7099.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB70994C6CF136F1F1EADAA3018C632@CY8PR12MB7099.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=45ccd442-91d2-4266-8ed0-2624687e17c9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-19T19:32:12Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|DM4PR12MB6303:EE_
x-ms-office365-filtering-correlation-id: 4a00c458-6d2d-4d94-b02d-08dcd8eeec70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HFTryGT+0dFhX4aNSDBfUCqBm3qjxsRQoAM92L7POcA5+RsWE6u9xe7/tHHg?=
 =?us-ascii?Q?//9Fu0irgqXWnpIjxw7Xn7JJ/ORcYh4x2G8GPaEURrtMqy1sX7/BiSgxu4an?=
 =?us-ascii?Q?jqRlb7N2xTRjkhkjZTyep4zwGc7lYbnfDKXY+U9zmit0lTOciB02KD+f4897?=
 =?us-ascii?Q?xz7qk9TOnqDu1N/+ECF/QtK8RR/HIb9Kfb32zNUi9WqiNlJsPby0sGmwV+fK?=
 =?us-ascii?Q?8D11Kk40S+9q+vPP+ECBgjZaro0Uahg0f06xvLpXTFc1fWVWDFmh+h73FO1W?=
 =?us-ascii?Q?huVMhdmAypN9EVKt7vxPpZ3W1WEjrwhUzG9NZ0GRL6SgVeGHGrFR0NV4770D?=
 =?us-ascii?Q?ym/YFaSGoWfBnJbmzBcoiOShoqLUjXeFG1PfJJHNqmm3HiTc+j6+GZcmqo7e?=
 =?us-ascii?Q?O00l+hWdItgk0Yb9UoUyiLCwhXSHrAVKURxfrrRClZyJWa6rPkIzlc4iYpW7?=
 =?us-ascii?Q?2dM1eGp3R+TPoamCvhzNpBv4VKspvSDX6r3d2Yqkh0QyHg/uAhVIG3yh44JH?=
 =?us-ascii?Q?FCVCSYx6QtwccDowOnvUZqfRYL8ZyU+HQHDWvPBHAX+hP6iLJqenOYXYAYGR?=
 =?us-ascii?Q?xCukR2CVU6M227vo9LzzwXoMXOAgakFrq3oIPT77zGfnIX0F/gj8yOh8PkSh?=
 =?us-ascii?Q?aZNTvJMJX7a2HqudHcyOzFqIRUH2pHIGL7GNDZuAGKrl7lkidmM4X5cML53h?=
 =?us-ascii?Q?Zs2jWbd8Dm1hKoGv80QyAq++CdxL8AfKkyuysheyNAFUTS4Gv7Ufuvi39++y?=
 =?us-ascii?Q?aJbiQ3cj6rDQ6FtjALpUHqD2gwROPudB/E/NYz0Xn55kO5PAXXUcm0FjfPne?=
 =?us-ascii?Q?JnDemXZ+sVxNv1K1CjTtgXDrm+pE5M0HB0Kr8R1aL28OUuT7o1kfXDLYUbAN?=
 =?us-ascii?Q?+NbRfrygZeta0/nkInq+syfUSuHq2oplfQtpNWuU3cz22YcaTQgEEKFqIZj6?=
 =?us-ascii?Q?a3kDrFtnA9dS1qX43YzLXRT3ScVlZ0jswrO18BEjspGcPuoHkEaUkFA7VGGv?=
 =?us-ascii?Q?/Q808rD2lXt0+HTZU4ovLN6JhXTdsxrBDN+ngiMsH9JwyBwOqS6zNFLsYfgp?=
 =?us-ascii?Q?WqSZsRNTcHBsfzVBJK0Wz4Y2aX/lPKUss4Ae29yl/YXPUxHgeUw/hwURmaWo?=
 =?us-ascii?Q?umkVc2KUSGE++q5De+zcgGSHeUz2KlfIUO3Ig2juydp5nVqsBWRPut77B+LB?=
 =?us-ascii?Q?cltdmhrfUEP9jYvVh+Wu+BixK4XpoiSkVbQndHoGXErosbCtgCmh4NSognga?=
 =?us-ascii?Q?0gmJ4l4QA0JuB6bxPgH0cAlSfoh6Mn252bPCxDqc+GQIL7m5aMfh7Pg5NV0x?=
 =?us-ascii?Q?KQ0I2UXwjBwwww36Zj8icKB2C6VxjtKP7gLyDfHsMaeMEqaAtW5s4rCY8wwc?=
 =?us-ascii?Q?QwRFLSBXvBbUNVo4CY2cPI5YANev7gREXN5HoTmdgBvZbAOkAw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pbE2teO4qw4slYhL2xJVpRMWBTVynlZetHv7vLZPykmEUtO8KwmnvvTpsa8a?=
 =?us-ascii?Q?abT1CdF1k3MWcfQiH6TOC+vwJ5OCxOWw78G67jngiH2y1G1LGGQau63i8N0D?=
 =?us-ascii?Q?wBHqStXvd6adEJFzxipG6sr6M1XJLaefcCp0KAlp7PjVFyan0sFtYtSp15xt?=
 =?us-ascii?Q?owcXVbizlFqkKBsr7+PmpFSH94CkKQAIOxq1Zre4QDdxTynBhKL+1NLuTEXv?=
 =?us-ascii?Q?C8LeMDHhf4q/P+zxymKT1qTA9NiHvCFjTT+SY1qiTmfQDoIWEe/xT5scgIuI?=
 =?us-ascii?Q?DOIgoyM7XnoPx37AxY5xRXeNi6SrXuZPIYvsTTEiPSyHDuFLRUgXohicLA5r?=
 =?us-ascii?Q?8bD302b/rnRj82nV1MagkSo3DaCipb44YhrgzNAzGQtXYnJQTPwQXmnVqGIk?=
 =?us-ascii?Q?U/dE0K2Z829qOysK78oHNyIVrMpro2GtgrYQHRd1k3MIKm28Dbf6idLe3FA9?=
 =?us-ascii?Q?Fo6jAF+/GeM2tId6KBkgO3hixKM3fsSVPz3TqbJ3kiDFlmGJ1WF/f7DkmPEl?=
 =?us-ascii?Q?GpO1iZYBB6/oGnn8UULtTzSwyOe2PUxisUhwstwIjYMEAFdLWjfI0BMCrhE9?=
 =?us-ascii?Q?mGoIEaYaV3hxauylpujEcwh8nkhqGFNBNeREDfXWZlabH/Lx+M/vM2xthDV1?=
 =?us-ascii?Q?O6qrgV16oIFRP4NJmQeu0TSMqcnPzIatXZL1crf9JhzpOJSFGevnb88MVoB8?=
 =?us-ascii?Q?roi4862Kvyx7iJV6XRPDK3e6U9DxP9QicSVXu/NZdF1xW5FHIf3g2cMqJjqL?=
 =?us-ascii?Q?wPHw1ADGcswdGavmQEWJNG16GEsPGfcZBn+Otq4BM9w2Om8J5sRCGo/drY0L?=
 =?us-ascii?Q?M9KhFucTqr4sylEGx4lB05/47SdOsl6jkiWU7rJ2Ny2lX540D608W4BJOsR0?=
 =?us-ascii?Q?zc+1r7POVuzn0n9xzuDvz9N3xKB7/QtmNw0Zb+9szEuMHxvQVPdFD5mppx0+?=
 =?us-ascii?Q?ErkmgKQ9hVCxPODU9IvQq9TcG9gyP56KnCiIYMVlvRuoOVs4hoLjNmrnu3Qo?=
 =?us-ascii?Q?c6q4ChHSIr1aJP5lR90gckQvce4g9TyitypgaZZZhyj/5wGiZuNsgH02AhOT?=
 =?us-ascii?Q?CNH3ZJNZQ23les980fJiv1AnygMRbWjj3yEzA0pDSrmNPgncfK1fDwfJDFKB?=
 =?us-ascii?Q?YCc9pVp0uUFHpdSge0smf9zmxz0B3b8iMY2s9mT5TAbxqb5OJnFZmde3eK+/?=
 =?us-ascii?Q?dvTYxo4P20NwSE1yOO8yG7aIvqmZ0KrEancKJXN/LXRmPJz5LCd8hdOdYI85?=
 =?us-ascii?Q?WYcZftBxSxU8khJ6j4EupI+sV740XdixkVM+hAEuSnn2chWn7MWbPINvi8X5?=
 =?us-ascii?Q?AQplpVXAyF+Td8VxAzhZXgmh/If7ITZw1YIhamojIral0MoFEw1FOclnJ13d?=
 =?us-ascii?Q?b1i24t5bOioxUllTXPMXiOrA9HxRx9sAsQAFC9zjZOBabPrbcaihZOdeS6vp?=
 =?us-ascii?Q?1Ibm73keA+94WqG4hTemPReQpTWFkTUicl3gWMZtTE7OSk785qjUdEQHtSdR?=
 =?us-ascii?Q?OeOYM57W4wVZ6oKRIDM4w9hYz/i6X1JsmEht/But/5QX9lBFw6b0aez1wVNx?=
 =?us-ascii?Q?WHhtSGvUbGLU+kinqhM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a00c458-6d2d-4d94-b02d-08dcd8eeec70
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 21:06:26.0194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UhCT4x+LXR3ID9DsBCd2eCUdb38qrPh8qp4hIknU2zIGBjtyuE+M1qBzqsoIv1QLUoL8H2QdMiP/KvjieEZZ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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

> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Thursday, September 19, 2024 3:56 PM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdkfd: Fix CU occupancy calculations for GFX 9.=
4.3
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> This looks like a more robust way to get this information. Few comments
> inline.
>
> - It might be better to break this into two commits. One specific to 9.4.=
3 and
> other to use doorbell instead of LUT register. The second change affects =
all gfx9
> ASICs.
>
To make the changes work for GFX 9.4.3, I will have to add additional chang=
es to access
the LUT register correctly, which will then be removed in the subsequent pa=
tch for all gfx9
ASICs. So I don't think we gain much from breaking it into 2 commits.
What do you think?

> -----Original Message-----
> From: Joshi, Mukul <Mukul.Joshi@amd.com>
> Sent: Thursday, September 19, 2024 1:43 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Joshi,
> Mukul <Mukul.Joshi@amd.com>
> Subject: [PATCH] drm/amdkfd: Fix CU occupancy calculations for GFX 9.4.3
>
> Make CU occupancy work on GFX 9.4.3 by updating the code to handle
> multiple XCCs correctly. Additionally, update the algorithm to calculate =
CU
> occupancy by matching dorrbell offset of the queue against the process's
> queues, instead of using the IH_VMID_X_LUT registers since that can be ra=
cy
> with CP updating the VMID-PASID mapping.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 92 ++++++++---------
> --  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  5 +-
> .../drm/amd/amdkfd/kfd_device_queue_manager.c | 20 ++++
> .../drm/amd/amdkfd/kfd_device_queue_manager.h |  3 +
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 18 +++-
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   | 10 +-
>  6 files changed, 88 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 1254a43ec96b..b8c01257b101 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -950,28 +950,30 @@ static void unlock_spi_csq_mutexes(struct
> amdgpu_device *adev)
>   * @inst: xcc's instance number on a multi-XCC setup
>   */
>  static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
> -               int *wave_cnt, int *vmid, uint32_t inst)
> +               struct kfd_cu_occupancy *queue_cnt, uint32_t inst)
>  {
>         int pipe_idx;
>         int queue_slot;
>         unsigned int reg_val;
> -
> +       unsigned int wave_cnt;
>         /*
>          * Program GRBM with appropriate MEID, PIPEID, QUEUEID and VMID
>          * parameters to read out waves in flight. Get VMID if there are
>          * non-zero waves in flight.
>          */
> -       *vmid =3D 0xFF;
> -       *wave_cnt =3D 0;
>         pipe_idx =3D queue_idx / adev->gfx.mec.num_queue_per_pipe;
>         queue_slot =3D queue_idx % adev->gfx.mec.num_queue_per_pipe;
> -       soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, inst);
> -       reg_val =3D RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, inst,
> mmSPI_CSQ_WF_ACTIVE_COUNT_0) +
> -                        queue_slot);
> -       *wave_cnt =3D reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
> -       if (*wave_cnt !=3D 0)
> -               *vmid =3D (RREG32_SOC15(GC, inst, mmCP_HQD_VMID) &
> -                        CP_HQD_VMID__VMID_MASK) >>
> CP_HQD_VMID__VMID__SHIFT;
> +       soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, GET_INST(GC, =
inst));
> +       reg_val =3D RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, GET_INST(GC,
> inst),
> +                                 mmSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_sl=
ot);
> +       wave_cnt =3D reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
> +       if (wave_cnt !=3D 0) {
>
> Why is it queue_cnt->wave_cnt accumulating instead of direct assignment.

The wave_cnt read here is per SE. So, for a queue, we need to accumulate th=
e wave_cnts
across all SEs.

> There is some inefficiency here. The code is iterating over all queues tw=
o times
> once in kfd_get_cu_occupancy and once more in
> kgd_gfx_v9_get_cu_occupancy(). Is that strictly required?
>
Yes. The first pass (in kgd_gfx_v9_get_cu_occupancy()) is accumulating all =
queues (all HQDs) which have wave_cnt !=3D0.
At this step, we store the corresponding doorbell_offset of the queues whic=
h have wave_cnt !=3D 0.
In the second step in kfd_get_cu_occupancy(), we are checking if queues wit=
h wave_cnt !=3D 0 belong
to the process. If yes, then we update the process's total wave_cnt.
Hope it makes it clear why we need the 2 passes.

>
> +               queue_cnt->wave_cnt +=3D wave_cnt;
> +               queue_cnt->doorbell_off =3D
> +                       (RREG32_SOC15(GC, GET_INST(GC, inst),
> mmCP_HQD_PQ_DOORBELL_CONTROL) &
> +
> CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
> +
> CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
> +       }
>  }
>
>  /**
> @@ -1021,24 +1023,19 @@ static void get_wave_count(struct
> amdgpu_device *adev, int queue_idx,
>   *
>   *  Reading registers referenced above involves programming GRBM
> appropriately
>   */
> -void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
> -               int *pasid_wave_cnt, int *max_waves_per_cu, uint32_t inst=
)
> +void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
> +                                struct kfd_cu_occupancy *cu_occupancy,
> +                                int *max_waves_per_cu, uint32_t inst)
>  {
>         int qidx;
> -       int vmid;
>         int se_idx;
> -       int sh_idx;
>         int se_cnt;
> -       int sh_cnt;
> -       int wave_cnt;
>         int queue_map;
> -       int pasid_tmp;
>         int max_queue_cnt;
> -       int vmid_wave_cnt =3D 0;
>         DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
>
>         lock_spi_csq_mutexes(adev);
> -       soc15_grbm_select(adev, 1, 0, 0, 0, inst);
> +       soc15_grbm_select(adev, 1, 0, 0, 0, GET_INST(GC, inst));
>
>         /*
>          * Iterate through the shader engines and arrays of the device @@=
 -
> 1048,51 +1045,38 @@ void kgd_gfx_v9_get_cu_occupancy(struct
> amdgpu_device *adev, int pasid,
>                           AMDGPU_MAX_QUEUES);
>         max_queue_cnt =3D adev->gfx.mec.num_pipe_per_mec *
>                         adev->gfx.mec.num_queue_per_pipe;
> -       sh_cnt =3D adev->gfx.config.max_sh_per_se;
>         se_cnt =3D adev->gfx.config.max_shader_engines;
>         for (se_idx =3D 0; se_idx < se_cnt; se_idx++) {
> -               for (sh_idx =3D 0; sh_idx < sh_cnt; sh_idx++) {
> +               amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst=
);
> +               queue_map =3D RREG32_SOC15(GC, GET_INST(GC, inst),
> + mmSPI_CSQ_WF_ACTIVE_STATUS);
> +
> +               /*
> +                * Assumption: queue map encodes following schema: four
> +                * pipes per each micro-engine, with each pipe mapping
> +                * eight queues. This schema is true for GFX9 devices
> +                * and must be verified for newer device families
> +                */
> +               for (qidx =3D 0; qidx < max_queue_cnt; qidx++) {
> +                       /* Skip qeueus that are not associated with
> +                        * compute functions
> +                        */
> +                       if (!test_bit(qidx, cp_queue_bitmap))
> +                               continue;
>
> -                       amdgpu_gfx_select_se_sh(adev, se_idx, sh_idx, 0xf=
fffffff, inst);
> -                       queue_map =3D RREG32_SOC15(GC, inst,
> mmSPI_CSQ_WF_ACTIVE_STATUS);
> +                       if (!(queue_map & (1 << qidx)))
> +                               continue;
>
> -                       /*
> -                        * Assumption: queue map encodes following schema=
: four
> -                        * pipes per each micro-engine, with each pipe ma=
pping
> -                        * eight queues. This schema is true for GFX9 dev=
ices
> -                        * and must be verified for newer device families
> -                        */
> -                       for (qidx =3D 0; qidx < max_queue_cnt; qidx++) {
> -
> -                               /* Skip qeueus that are not associated wi=
th
> -                                * compute functions
> -                                */
> -                               if (!test_bit(qidx, cp_queue_bitmap))
> -                                       continue;
> -
> -                               if (!(queue_map & (1 << qidx)))
> -                                       continue;
> -
> -                               /* Get number of waves in flight and aggr=
egate them */
> -                               get_wave_count(adev, qidx, &wave_cnt, &vm=
id,
> -                                               inst);
> -                               if (wave_cnt !=3D 0) {
> -                                       pasid_tmp =3D
> -                                         RREG32(SOC15_REG_OFFSET(OSSSYS,=
 inst,
> -                                                mmIH_VMID_0_LUT) + vmid)=
;
> -                                       if (pasid_tmp =3D=3D pasid)
> -                                               vmid_wave_cnt +=3D wave_c=
nt;
> -                               }
> -                       }
> +                       /* Get number of waves in flight and aggregate th=
em */
> +                       get_wave_count(adev, qidx, &cu_occupancy[qidx],
> +                                       inst);
>                 }
>         }
>
>         amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,=
 inst);
> -       soc15_grbm_select(adev, 0, 0, 0, 0, inst);
> +       soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, inst));
>         unlock_spi_csq_mutexes(adev);
>
>         /* Update the output parameters and return */
> -       *pasid_wave_cnt =3D vmid_wave_cnt;
>         *max_waves_per_cu =3D adev->gfx.cu_info.simd_per_cu *
>                                 adev->gfx.cu_info.max_waves_per_simd;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index 988c50ac3be0..b6a91a552aa4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -52,8 +52,9 @@ bool
> kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
>                                         uint8_t vmid, uint16_t *p_pasid);=
  void
> kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
>                         uint32_t vmid, uint64_t page_table_base); -void
> kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
> -               int *pasid_wave_cnt, int *max_waves_per_cu, uint32_t inst=
);
> +void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
> +                                struct kfd_cu_occupancy *cu_occupancy,
> +                                int *max_waves_per_cu, uint32_t inst);
>  void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device
> *adev,
>                 uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
>                 uint32_t inst);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 71b465f8d83e..784d155d8bcc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -3540,6 +3540,26 @@ int debug_refresh_runlist(struct
> device_queue_manager *dqm)
>         return debug_map_and_unlock(dqm);  }
>
> +bool kfd_dqm_find_queue_by_doorbell_off(struct device_queue_manager
> *dqm,
> +                                       struct qcm_process_device *qpd,
> +                                       int doorbell_off) {
> +       struct queue *q;
> +       bool r =3D false;
> +
> +       dqm_lock(dqm);
> +
> +       list_for_each_entry(q, &qpd->queues_list, list) {
> +               if (q->properties.doorbell_off =3D=3D doorbell_off) {
> +                       r =3D true;
> +                       goto out;
> +               }
> +       }
> +
> +out:
> +       dqm_unlock(dqm);
> +       return r;
> +}
>  #if defined(CONFIG_DEBUG_FS)
>
>  static void seq_reg_dump(struct seq_file *m, diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 08b40826ad1e..e5951589e5bd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -324,6 +324,9 @@ void set_queue_snapshot_entry(struct queue *q,  int
> debug_lock_and_unmap(struct device_queue_manager *dqm);  int
> debug_map_and_unlock(struct device_queue_manager *dqm);  int
> debug_refresh_runlist(struct device_queue_manager *dqm);
> +bool kfd_dqm_find_queue_by_doorbell_off(struct device_queue_manager
> *dqm,
> +                                       struct qcm_process_device *qpd,
> +                                       int doorbell_off);
>
>  static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device
> *pdd)  { diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index a902950cc060..6720bd30517b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -270,6 +270,10 @@ static int kfd_get_cu_occupancy(struct attribute
> *attr, char *buffer)
>         struct kfd_node *dev =3D NULL;
>         struct kfd_process *proc =3D NULL;
>         struct kfd_process_device *pdd =3D NULL;
> +       int i;
> +       struct kfd_cu_occupancy cu_occupancy[AMDGPU_MAX_QUEUES];
> +
>
> You can just use sizeof(cu_occupancy) as it is an array
>
> +       memset(cu_occupancy, 0x0, sizeof(struct kfd_cu_occupancy) *
> + AMDGPU_MAX_QUEUES);
>
>
>
>         pdd =3D container_of(attr, struct kfd_process_device, attr_cu_occ=
upancy);
>         dev =3D pdd->dev;
> @@ -287,9 +291,19 @@ static int kfd_get_cu_occupancy(struct attribute
> *attr, char *buffer)
>         /* Collect wave count from device if it supports */
>         wave_cnt =3D 0;
>         max_waves_per_cu =3D 0;
> -       dev->kfd2kgd->get_cu_occupancy(dev->adev, proc->pasid, &wave_cnt,
> -                       &max_waves_per_cu, 0);
>
>
> A comment as to why you are using only the first xcc_mask will be helpful=
.
>
Sure will do.

Thanks,
Mukul

> +       dev->kfd2kgd->get_cu_occupancy(dev->adev, cu_occupancy,
> +                       &max_waves_per_cu, ffs(dev->xcc_mask) - 1);
> +
> +       for (i =3D 0; i < AMDGPU_MAX_QUEUES; i++) {
> +               if (cu_occupancy[i].wave_cnt !=3D 0 &&
> +                   kfd_dqm_find_queue_by_doorbell_off(dev->dqm, &pdd->qp=
d,
> +                                               cu_occupancy[i].doorbell_=
off))
> +                       wave_cnt +=3D cu_occupancy[i].wave_cnt;
> +       }
> +
> +       /* Update wave_cnt for the number of XCCs in the partition */
> +       wave_cnt *=3D NUM_XCC(dev->xcc_mask);
>         /* Translate wave count to number of compute units */
>         cu_cnt =3D (wave_cnt + (max_waves_per_cu - 1)) / max_waves_per_cu=
;
>         return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt); diff --git
> a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 7744ca3ef4b1..e3e635a31b8a 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -71,6 +71,11 @@ enum kgd_memory_pool {
>         KGD_POOL_FRAMEBUFFER =3D 3,
>  };
>
> +struct kfd_cu_occupancy {
> +       u32 wave_cnt;
> +       u32 doorbell_off;
> +};
> +
>  /**
>   * enum kfd_sched_policy
>   *
> @@ -313,8 +318,9 @@ struct kfd2kgd_calls {
>                         uint32_t grace_period,
>                         uint32_t *reg_offset,
>                         uint32_t *reg_data);
> -       void (*get_cu_occupancy)(struct amdgpu_device *adev, int pasid,
> -                       int *wave_cnt, int *max_waves_per_cu, uint32_t in=
st);
> +       void (*get_cu_occupancy)(struct amdgpu_device *adev,
> +                                struct kfd_cu_occupancy *cu_occupancy,
> +                                int *max_waves_per_cu, uint32_t inst);
>         void (*program_trap_handler_settings)(struct amdgpu_device *adev,
>                         uint32_t vmid, uint64_t tba_addr, uint64_t tma_ad=
dr,
>                         uint32_t inst);
> --
> 2.35.1
>

