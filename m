Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1965DC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 05:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A248010E888;
	Thu,  1 Aug 2024 05:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rSXla83N";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB0F10E888
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 05:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXM7wqAjXjsVHwTy8yasAFAUWFOJfK7PD8d4rfaB+zP4RqegiKPol/AwgnETnFjMW+D3hD2fIbONQ7E6IYgPxpJzpd5VSy7R1SpbBVRQAimykFjYOKMI9/pTOyhMJPnQUJn4MfY3h2AZrflJFDdUfk1LXUJLCxmtNiJKPcF53cts4AyrIoxRXFuhnotDRT9LJ2lm/YMnGG2KEiaDh9ZvtCza6GaeNEKbzIdbIEujRQEXDOGkxR2r7fc/3Hn3EYxS1woNPoicJ0V542KF3K06FfXhdKfZSuHvR8+othhRHttM26NL+nQkWQeejeixQ9ZWotHOyHebfasOvKg5ook9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icIrwle3MofHbm7diCwvyZp9Skk/0pKj/HDJiBB/W8Q=;
 b=JjuPoKJODWoQcAytAuwZWMXrN+rCbui7gGaZPj9DtlxbfjWFpTP/aInSO4i7d/bfi7L3a6jcTQkVNA0oWE6R0l9LaZ7WJ3koayllzWqbitnkXnyC+CDcf/uNKh0z4s2wNWQQYJz53ma+FPDRzd/kO1sgy5EBQJJ6xatSgvLglfZXNsXiyl/EESbZ4REL/15mcv18TqQeHXSMhAeKZa0yV1dIyTGiDk/MZs0NXkZP2QKtL7VEAWzLdulV1yUIPD3iSzQ+UylCLGgzZr64bgAIamAAx/hApoI0MOGGxv9b0BfLzELNV8LbYMPI3ZAs6DPKNLFT/kDBm+qwBOLG9gGblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icIrwle3MofHbm7diCwvyZp9Skk/0pKj/HDJiBB/W8Q=;
 b=rSXla83N0EYuxud/3u2pnfz9e/5vSxOP6w7jxOT4+atP28honsNgyvWV9f+WBtWSCSCsY5pP1EMykESE2j+3cEg6DOq3pfGCMX5nu2Wx52bgXwjXDzbqxjtZONgmeKFN2xyLEc/+LahB+WfQVI9cxewWuqeC9o+NHsNHIiERgHI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.30; Thu, 1 Aug
 2024 05:30:05 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 05:30:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
Thread-Topic: [PATCH] drm/amdgpu: report bad status in GPU recovery
Thread-Index: AQHa4zE2Tg0CpIi6WkOtohax/K0s67IRtyqggAAOAwCAABioQA==
Date: Thu, 1 Aug 2024 05:30:04 +0000
Message-ID: <BN9PR12MB52570AEF77D511EE5B2900FBFCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240731100526.32903-1-tao.zhou1@amd.com>
 <BN9PR12MB5257A5C7FA776D10A6FD540FFCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
 <PH7PR12MB87963EAAD611DFBE5AB79AC1B0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB87963EAAD611DFBE5AB79AC1B0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=60b2d777-4128-49f9-8b5b-a6aaa5eae599;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-01T02:59:07Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB8911:EE_
x-ms-office365-filtering-correlation-id: e4145e10-3ca2-443d-ff65-08dcb1eaff66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SUHQ1TcI57Hur61VDT8dqjkCvCISmVWpJUaoKzrYEccYwJML8OQT/e0kreRr?=
 =?us-ascii?Q?r5pGn/slu4WS4XXP1NV3KgWN498yERpu6qGtogcvFBh+4uM/QrSogAue0vOh?=
 =?us-ascii?Q?0ESjXLB0tLPPwLDfGfRNkaY1PR5MYaJZokWbRFkCNDEtZShmhArNQMiMWQlR?=
 =?us-ascii?Q?sdoVE+MZiRaFbuB6pAu2i5bFKyoUQ9+yolF9VtGdBsMqj0aTKEtT17QycURJ?=
 =?us-ascii?Q?ihbKZk567DEKIlkz1dW+fQw7+q8c1V1FjNvVDHyRALF5ByIYio4k8NVsTiTI?=
 =?us-ascii?Q?7oxspK5nZtud8AjC6ofgd/xpbxC+EN2kKwpeTZVu0T9UztRWLCQiChMzImx/?=
 =?us-ascii?Q?3PNJoAHa3heWGQjzZsia/OEqz71KhTGXB85FM5Aoq61ltWtDaAzkGAnSezop?=
 =?us-ascii?Q?PILyUB/BMihSXIuBEK3SypnXiXnvMPQ1CcacuiDSv5+sO4HnhsrJkCWwKhAR?=
 =?us-ascii?Q?dS4t0sGaxZSlLRO4wT6N6htfSNu9nTr5wD3vh5YWoL9CUuHhL/xhI7edMsoe?=
 =?us-ascii?Q?hGHXlHvrfNOvsEaFrXi4YAFLjOeqQwnlKn9YerVbX087dtvEesqNgKomu7bo?=
 =?us-ascii?Q?DaLl8PMdjFqFcUKtZIBI8CIbdWwpF+t//EQFhVsOVh7D+2Vxy9Ga/FZ3yZSM?=
 =?us-ascii?Q?IAx1CbV3EAkOaUy7oLYLT2nt+U4NBoWm5k/pABljThIn808y6oNmj4baEHqi?=
 =?us-ascii?Q?muGDbum2ZJuYKnV+GxYMMknKMG5/7w4Dy3qFVUa89s+QTqmpo1Y0/OyIxF5d?=
 =?us-ascii?Q?h+t27BL+AeDNMlr1jmxUJtBNGzj26zB83Avt7g67f3ip94AM/1p/azT+T4TW?=
 =?us-ascii?Q?569c5B19Zs4QaQsmQlFxUYb5q30BS34EWD9kjB/MQTdeG4tY8VQ7EWz6DttX?=
 =?us-ascii?Q?Bwyt/UcMWBg6yPPrv4+SMdPuKluspStAJPuZMU3ynM2v0EabrU1hbrikrKCr?=
 =?us-ascii?Q?nPRlrgXdFy7TSfGGTqzCDm8ZvJwLPueSTJ4k2ThVR+wAEVRsv31OR7Wpn1D2?=
 =?us-ascii?Q?TWnQefhTUaPdOuQDwswHa8UkzXmRS3l99NnzbYbB4f4b+GHPHSM6CjLJeiYm?=
 =?us-ascii?Q?S76k07TiwO7odk3Uc/9QU90ZOe8hK5pOlDyuJPENqoiUZMo1WHBzWwMCJ9OO?=
 =?us-ascii?Q?4W8DsiJpRsPsauj9on0ko4SRNZQtLgxb6oXxmhcsrPzryk8+FpXm5IBEXh3m?=
 =?us-ascii?Q?zoFQciiVFm0zuOG5WnRKWvfUC3HqFwmWlOBgS2EHg+eRUp7aao/RhyTQhulU?=
 =?us-ascii?Q?3Hd/2rg8FVn3A6xR9FBueef4USD1W7RihUYwAYOOxb+SNhfXNVoDr/oCE8Zq?=
 =?us-ascii?Q?gEYA87vQO7OCqmAoDUSfcpCYDBVMrD6zh9HIm298FtNwFDJY/NV2hO3gI8Pw?=
 =?us-ascii?Q?TSyS9+wRW8rFWpNtGvU4jOFJ4LZD3PIUdEu0QhMc1qvJUDrCCg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dVkyZvaDdIpm5SYxsvXtrUIg9Xov30ZKWZQSjrf32loYKg9iPxrJEMQeWKPI?=
 =?us-ascii?Q?QUDjmEr4007OAWKejMqrxVODL/EfYc51bgTs3Z4KpLpiPOMTwU75RfHNpdc1?=
 =?us-ascii?Q?0m4ZuaiRsBV1+nPalHfaMiRuzjDrQP1j0U3TANjOjEM0E63nvIMWp95FwrhZ?=
 =?us-ascii?Q?c3kFEH26fntzMNvqHocEV0PhlpibMVATsu5n+yKMVpZ1sdvpKVA+0yLvcvF7?=
 =?us-ascii?Q?VYYN/v+zTKKLhcPlECHdWHAeIuYtk3PWsRcAOt5HxGMuMoH2+CbHXLPsis90?=
 =?us-ascii?Q?IMklWQYIu5nlHvXJlrLm25Za7v0j4m+O2yQIKLWKiEUkX7FTYP3eHzEiDHS4?=
 =?us-ascii?Q?MoJ2J8q6XnHueXNhDB86PD7p8jos1EhgWaHw0ls+LxXSklUxZX7xRhrKZ6lJ?=
 =?us-ascii?Q?h5tFoTDZjlI0HZeHDgBU0NssW5KslX3/YjUkU5wzVqz4UVtXHJJ0QZCVI7Rg?=
 =?us-ascii?Q?2RuOPvmJ5TZekO60OzQ3hGK4V690IVRP0kRqNZX8212F0f1xoDehNbkqZZ/f?=
 =?us-ascii?Q?NttzHRf6bG5NHCPz29d0fgg3y/uIo1qzztUOGV1uwekUc1yRIWy1cdzxHz6k?=
 =?us-ascii?Q?kqIlPQ0X7Cw2rdUHYvT2t/sweLUZZaCrzDzzfWutBmv8ta6cx82VxSe68hKb?=
 =?us-ascii?Q?PHH+/Guu1F1tFUm50gZoVOr0vIe6e7o3g2JkeshmACtAkX4vIChNA3KOp82A?=
 =?us-ascii?Q?HW8KvuG0VGw3gEBNHfELi5c2Tb2sm4Rc+VfLsuVtkdRaa5Itlr96isBnYlgm?=
 =?us-ascii?Q?qq+wmT8FRLYeeUzMopdLWwvKzjS/KPSu060zZtcoZCrKGm7XPEqR6QBdKVyt?=
 =?us-ascii?Q?FLi2TUp21Yjez4Y6qIoN8Lo7z0RFDesxrhXt84hozSqlkyvVGlnGwogRCiTu?=
 =?us-ascii?Q?fV6LhGwPGnQLxOECu3K/7hZQHpi4vT0QhoaVn/jJKbGeXJzrZneCjKXoXZvf?=
 =?us-ascii?Q?kzn/OOdSVub1bRB4IpvX8RTLzpVNvlVJQqvl0y49XciorGP/nBwjVGwDdmqb?=
 =?us-ascii?Q?P8gXyg9Kh0D9QrPsU8iMlUSH0uelH1Lbk++YAAm5rKc9Lhe0lNtA1PFb9tkZ?=
 =?us-ascii?Q?K1Z8gJKR55HnMN3+nTNs5rM8JefSG3Kk1hPeltemLJIMGSULH5lCKdv9Ox/v?=
 =?us-ascii?Q?lNUeF1d+7DNJ17uQHivHu63P3u7Nc/IbQLViNu6lsZmwmWPdTyAu9NZbq9/i?=
 =?us-ascii?Q?uuF2Dk8izXDF1SI4+74kWhgN4ncVCTxyD9vzsphQrgsfgGHybzbwGSvzz7BU?=
 =?us-ascii?Q?3Yw/elVtoUXsU6ty3Gqxl2Eg1wTG08FQAG21GjnJb2fQVvjetgfQI62DpKCh?=
 =?us-ascii?Q?OnTv3Htz31Tb2OE69Dnexa0p7obVzqPjy/7u2GDVQprMlNKI7WGnxch39rSb?=
 =?us-ascii?Q?nNhAQtrKS8rGAGlGR2oTmFJvMv9oNRsl7uIUQgIAWi3bdJ2w9dgifwopyKPx?=
 =?us-ascii?Q?O5sxL9hTxCjc2FRCHfNKxuW0NqMPnOB1GQcphzWOnSWy1fcBcR539XHvjuGH?=
 =?us-ascii?Q?M4gzAkBhaTrT10/mmvVE9YhB2eJQIy52KH1O6YKxnDcENHDaRa/cIXl0QkvR?=
 =?us-ascii?Q?ezF1If1YPzPfIkI8Q8FQYxM5lTNCzQQjoySYSi0X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4145e10-3ca2-443d-ff65-08dcb1eaff66
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 05:30:04.5151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ou6uAcRWcSu3VzSRuB+d5iO6XKf/CK1DF/TrerpwUST2aV1EevgKRI4WMLNsMzteSmQiHNCRZkNzXzsv5/PJ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911
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

Right, it's functional. My concern is whether the kernel message in amdgpu_=
ras_eeprom_check_err_threshold will be printed twice. This is the end of gp=
u recovery (i.e., report gpu reset failed or gpu reset succeed). Check_err_=
threshold was already done before reaching here.

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Thursday, August 1, 2024 11:49
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery

[AMD Official Use Only - AMD Internal Distribution Only]

I think the if condition in amdgpu_ras_eeprom_check_err_threshold is good e=
nough, no need to update it with is_rma.

Tao

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Thursday, August 1, 2024 11:00 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Might consider leverage is_RMA flag for the same purpose?
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> Zhou
> Sent: Wednesday, July 31, 2024 18:05
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: report bad status in GPU recovery
>
> Instead of printing GPU reset failed.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 355c2478c4b6..b7c967779b4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5933,8 +5933,13 @@ int amdgpu_device_gpu_recover(struct
> amdgpu_device *adev,
>                 tmp_adev->asic_reset_res =3D 0;
>
>                 if (r) {
> -                       /* bad news, how to tell it to userspace ? */
> -                       dev_info(tmp_adev->dev, "GPU reset(%d) failed\n",
> atomic_read(&tmp_adev->gpu_reset_counter));
> +                       /* bad news, how to tell it to userspace ?
> +                        * for ras error, we should report GPU bad status=
 instead of
> +                        * reset failure
> +                        */
> +                       if (!amdgpu_ras_eeprom_check_err_threshold(tmp_ad=
ev))
> +                               dev_info(tmp_adev->dev, "GPU reset(%d) fa=
iled\n",
> +
> + atomic_read(&tmp_adev->gpu_reset_counter));
>                         amdgpu_vf_error_put(tmp_adev,
> AMDGIM_ERROR_VF_GPU_RESET_FAIL, 0, r);
>                 } else {
>                         dev_info(tmp_adev->dev, "GPU reset(%d)
> succeeded!\n", atomic_read(&tmp_adev->gpu_reset_counter));
> --
> 2.34.1
>


