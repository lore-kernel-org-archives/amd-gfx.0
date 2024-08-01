Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFADC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 03:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B6C210E885;
	Thu,  1 Aug 2024 03:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hsNpejaJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32DB710E885
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 03:49:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKYSQMPl2kHTP9+ENum1hooumPqD5M7Ohw+HI+HPHy1oO5p3QVOzwSvA6Z/JG7r+ulqpz4DWNxLP1781BuSMIab1F/csk6InfRDhpxuwv3jaH8G/rz/1d3wNkEWObaz9ifM0FiUnXyl3C7IcHcneGNHC18h56ZdVtJKgL3dsoh2N/0NBken8KEB6wkzz/dUFbPvhWYBj6gxwy6LwbxOenvGYHokXuZIxmNjo43lBlBwF6v7tof7Ag89wn+Do4Z6jmNU3oFCdjt56+6CtkqN5kl4yVsmtLTHqoEiqP8iGVHfwSa48XXi7659+acKvmrSDUoXKEzy1r1b2wgQWB2FL+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8RhxCHhR7WdWRiO0f/HydD+NDnTVI0CAA42zKta9kk=;
 b=cP4seaYJaPF+8JyFrH5HrYPk1Cy49F0pdsvWDAv52ongP4A2vYbVJDnaui4/vMX/K7eCo8fHrpP+//o264MfjVLT6p7nXBRKw1oX1489HPIUbsrpIZEtGC9khLFsMagXww7YQ/wWPgfkFIe+Z4NLV9sHkEgue6R+uJIOX3OxJ8vctEAFOHWTz7pEn1DhBHQiDu5fomKPV5eE3dk+s775qEvCk5gvKKeVsfwiFocQE+0x0CnlHXf4FDIVIiQUdCDGeuOKkjgipnAvUqn/dqp2J3UxPxKeukEi6IMdU9WOK4JGdervwrdyKR4ncwrx5RaPTdfOHO099vWuIcesJvjBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8RhxCHhR7WdWRiO0f/HydD+NDnTVI0CAA42zKta9kk=;
 b=hsNpejaJ5xWIq19t6TQk8zwyQyH26JXpbMpha7iL2uk4gFmlPHFwLXk400iZ58I1PUkGSgO2RUfnU8xoeAz1MRiYJWhTq2IYB1aRLdIt4kPXjfrGfHYGRD4BNAjaU2aqa9l0YZGTOkVA+UNWWVHMdxE7mIg8nD08xz0P3XfUm74=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 03:49:16 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 03:49:16 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
Thread-Topic: [PATCH] drm/amdgpu: report bad status in GPU recovery
Thread-Index: AQHa4zExnRuw1cXkP02nZh2cKZwugrIRt02AgAANeIA=
Date: Thu, 1 Aug 2024 03:49:16 +0000
Message-ID: <PH7PR12MB87963EAAD611DFBE5AB79AC1B0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240731100526.32903-1-tao.zhou1@amd.com>
 <BN9PR12MB5257A5C7FA776D10A6FD540FFCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257A5C7FA776D10A6FD540FFCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ1PR12MB6266:EE_
x-ms-office365-filtering-correlation-id: d07a5af7-aa38-43cb-0380-08dcb1dceaa8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TBDyU0hneoZ6P99u50rbiRraM0muYwEsj127Pt8wrEhGMsfMNwxzM/2jaRhi?=
 =?us-ascii?Q?LpJEG/jXHvoGQOl+6hvMYSiIWiBDtOZOFudXRhuYE6AdGTAUki+csCDf0y7N?=
 =?us-ascii?Q?FQVQeRhBG0keGiGT7vyzWsGV49IlkqHnWJkb+MMhUlZ6qmh0jsodF1CR2xc2?=
 =?us-ascii?Q?PLCB7fLGB5Tk+E0d4oJCMXV+vMeymiu6tTAMCnveanJ1eCIBeYUJQErxcnXl?=
 =?us-ascii?Q?XoH1ZzmXAHM0LYjsebwUTL4HHL3UOB4z8Z/NCVwqJq5OsgXazdM2nTVmHA8F?=
 =?us-ascii?Q?eK9hw4snSoGnTh6m9zoXQPBNbNYSoKzK4oJDVjTISygWj9HjzffqKy1A+Y8c?=
 =?us-ascii?Q?K/M8nRG48ABccdIyybqKsypgxyEU1+R2jPLNkeLO8eG43VnA74P/njndzy+G?=
 =?us-ascii?Q?tATMWcAPmpplBJTVpjL+qKo2RvG33iGHL+5pqOYVz+Ob74TRL25V9tQL4GCP?=
 =?us-ascii?Q?PXR6Kr4+0zo9SncJtmEbBRL8jXDauVZSdwi7jMnHdJDqat4zO8UTkokEJ+vW?=
 =?us-ascii?Q?WYH6CWMJ8vKlYIsqHle+Pt86wn5/yr3KqOvRV9ZHnQ44/JCR67JL/6caW4W0?=
 =?us-ascii?Q?u524Yiw/+XgqOj93wgymFHMW7if0MM3+Tj5rGuqf54+S3RaPJH6Xyqb2tgQh?=
 =?us-ascii?Q?Cxh+gfcaEmXyRNti6Jwb1MF88LbMKYFFoCdfKbcGqKMzMfMlKnNTdEC70rcd?=
 =?us-ascii?Q?iXJPbwm+dst9Nj6o0lGrd4SJrw782kEZMgOuuMSV8RxeCLoplS6P0Uwqi8HI?=
 =?us-ascii?Q?qSRWMntm7JVx5nb2DoOzDz29uv6/Gdvk/Wp0BEpXG/JjGXR8cg39eW0wfDWy?=
 =?us-ascii?Q?4g21PKVCWD5e0rndmh8UWIEpYruagfRRuBPLnDTvXUNMy/nCg0lUzHR+DupR?=
 =?us-ascii?Q?RR2d/BKQ0tbN51/HwgwcDHa7+dmvoBaFGtrzIxNw0tTXpicBT8ZZpaC/vdKy?=
 =?us-ascii?Q?sXHULGt+yo4LZQt+KvgTRoqowwwBC3rL8eS0dCtROtuXY0MeoLNTFVtjMcZZ?=
 =?us-ascii?Q?cYC08C0kXRkD0yYdgH4wQ2jtgpyciOPbLLCE34IlHS20EJlOFoQOE0un4WML?=
 =?us-ascii?Q?+TdS08xIb6SWQUMBVoLbuJ03QTp1/4D5vLVf7Ob3rO0qdb4wqRxKcFplQk+3?=
 =?us-ascii?Q?aU8H/wVJqpPTC2x18MmIk8H7JHl/DaumM412zFpXD/Ue0v/wfQ2J7Fu272Zf?=
 =?us-ascii?Q?F/wQjkxeS29SUbcBS0WHfGAVGlI+ZdohGuKsYGGK9BCdh/ZrJjhbqyedSlut?=
 =?us-ascii?Q?G1bMeFxnUgKBdOiGQ+NP026YkbGCdaUmKLGK0zTDgERLfiY3su3KV2CNklyH?=
 =?us-ascii?Q?uHjTQOQUT7nSGkFP0gq04lH1j2Tx3jhklpMQ5GEPktryxengd8w41l/MUOcm?=
 =?us-ascii?Q?d6Mxk23UKgdIxvSJFLAq23Zt85TdcOBZNofZTYq3gIZp4B54Zg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?awLgd6pPrZzcPpoDZmPmVUI2GpJzR4L6OaKaAFusnUNIp9N71wL85pDiVbwn?=
 =?us-ascii?Q?rq3EgZLVMghEijqvUralIZKD+UHlPG81IRnu/v0KLkoJRUxpIb8QA3cqaZbR?=
 =?us-ascii?Q?UF+YAGRQETXn2b+nGtZNoAo8wAkEJeZaITB+8Hpl66DPNW6niFnqFHqA8ojJ?=
 =?us-ascii?Q?uBbE2+ndXZFVIQWUnRDXOKJ8SElSkZGSc9raduB8/fDWdKQWh8v5KTvcOKow?=
 =?us-ascii?Q?x61exrGI2UKECUHttwZ6G5z/9WCvpbOlGdn/QXsi5NGG1A3JRH2VBLYqoUYM?=
 =?us-ascii?Q?r8f2B/XX+mN9XpYBJtSKEpdnJVjMmGNVD2pDPxLQ+Y/j2YoXrVQWpa6KvyK4?=
 =?us-ascii?Q?2kmlO4VehGTKYmRsV4lUaZ6Ao3YtA6ceXAzW96N5hOcnRE8t8QciLd2BZZtO?=
 =?us-ascii?Q?WURdWqn+XtxeOgEP2C/jLKWrylYEpvRxt6+/QIwYf0UZCP/o5NQNeiikqQH4?=
 =?us-ascii?Q?3ENlEkwYguK/Qtvxp8mM7qP/HPZs3stEs3sfxa3Zc7pIzQnFPMFEChIay00O?=
 =?us-ascii?Q?L6j2gtSmSUdVKJQyE2JtjwFiKd9wdQOfoCvWvZ5vTGVhh7RvIMh62ppnUmlz?=
 =?us-ascii?Q?hkxPJ7Dpz+xQgwvOnAweX5fqmZANOkZmV5vDz7B/iBb8guyJgtrv1K1mIpLz?=
 =?us-ascii?Q?uwuWnQo4rIR5lMebTa63cySjwBe7isEINfG73Qg3jhlBViYWWIva/H0TAt+P?=
 =?us-ascii?Q?1btftYABekfLomIiWM84Gmn+7+ajtQtGHcvb+SSypTR0eMjeOk8yj5KoPuQD?=
 =?us-ascii?Q?Njox/jVTcEj1wb3AoYJQ0h725sDemdbGxGIYR2GCjWk2LS9G1Xjrv+NWokok?=
 =?us-ascii?Q?DL+ZQqdzn7Iv+TKc5Ztdz4r5uUrYmZUy4brHkovIFAaRo+h+vjspUFFvtGTm?=
 =?us-ascii?Q?phhyDABTfjwlJeMSQxkvdVtbG3I/CbmhZBnzKUtx/yNt19B1RFrWfAo5uZML?=
 =?us-ascii?Q?Qq3E8jRsjk2NyuIussRd32Ulx10Wt7HNB6AqzSYrLcsKfSquZdBGh85ON4ua?=
 =?us-ascii?Q?jJuqxrkf6FPv1iiyZuzrKEmrCYGeEmvoezwPIUdT4nwJSAxlv6DDgQsFAvXf?=
 =?us-ascii?Q?3uSrPKLDr16jyMLNXX7tiR3Ug9NcLyuWdcIev4eNuFZSjYmIxhd5xjYD7AzK?=
 =?us-ascii?Q?RnnV/qaA828jt6jP32uqSaJMSUOfkJGFJiz30x5vuOJzP8LW11Yl2OZ+R5DY?=
 =?us-ascii?Q?xsYpLFyCBDuspZ+xi4BW8xUu6g/Kz0Elr8OIXkTy1WkUHQ3KFjgb9C898jAF?=
 =?us-ascii?Q?vyTvVQwsKeGBMSSnk7GYj/y1poQb4UlFt1jzWP4VUTTwUE5ZK1drqvOpUKRP?=
 =?us-ascii?Q?U8gealNr7z8sQXKe4+xEJWSIMzYTnqVXzqJfVTyKG1B7KaeaYaIPzGTlG9mG?=
 =?us-ascii?Q?B4JgfweiLlJjQDZVajjKGjRVPAR36LSHKU80DvWxJyAtyeV0uH9F5/FVKiL6?=
 =?us-ascii?Q?9Cp6DSlYCxAXhh8IrYLLdWhSZeQXNuyEmNI7KDrhmQZ+2Xw5XDaLr0SVctBL?=
 =?us-ascii?Q?IawyeaVSU+DkCHTyTyJSMLA7q7i1cd7NSAeK0u/bBhhkxrNYbvUBlUkNF2nn?=
 =?us-ascii?Q?df2p2JbPSKQ04IAypiY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07a5af7-aa38-43cb-0380-08dcb1dceaa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 03:49:16.7545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i+W05WGiqIGTxZluSAAsyI4bHplvPdI4EtlGVIah7XblTRMCX74jTrapQsGAQqL+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zh=
ou
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
> +                                       atomic_read(&tmp_adev->gpu_reset_=
counter));
>                         amdgpu_vf_error_put(tmp_adev,
> AMDGIM_ERROR_VF_GPU_RESET_FAIL, 0, r);
>                 } else {
>                         dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!=
\n",
> atomic_read(&tmp_adev->gpu_reset_counter));
> --
> 2.34.1
>

