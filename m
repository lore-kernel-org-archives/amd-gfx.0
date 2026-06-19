Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40173CD98F2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 17:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B29E210E0E2;
	Fri, 19 Jun 2026 17:42:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AO2DEYZ4";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA8610E0E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 17:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyJTpDCyQEgZQYw8++SgZHpMMVEIQnnbyfE0HVUhBJrbU76Hm/kUMuEbWCpoIk3mTbkdSn6nVOmI0S63ZbMSZGQr65nPfjB+ZoHHAx6CgSUMvMl4NjckJLfuNX4Mf2xozP5iksuhH80Ak6Mhx3zXvdjd+U89c+Nd7dxMKoS7mT1mUct0GVWYcTFfxq0PSrv2VFpBNK3thMj4DNnzgODa9S4UWMoMFykY7GMzfgHWMf8cp0C7ItT3vBgpFnq2RmesecBeKgekKKP0cE99Gc7MJxzwEEzUuFBgv0Ouo+uSXKzl/KoTvfpEa79VuajrhV1CUjuUfsVhHm6BNqcaXFzODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPEBEzq2wRVeC7mTlMoOAnEDYmN+5GAgSkjH+wOWIiQ=;
 b=xFz0maMPiuFfAzcb3aqCwBMv9d3zZe9arE2SD4NQX3YFybXPOtxLy9hnpYeOtxuD+D3gqnSb5CEsOXCGVqHZ+1RRcLt9Tct5zWCyJWco00aqfhdXxHJnIhc4sdNRykIW2Z5FfrHvtjUz/m/wxf8Wb/qYlx3u6c9wp8huGDG0jNirHag9Nm1hH/3KLMTRkNGQjTCtgZPDzH0q/iaeRA2PoD9bnAOFdtJHtGZv0u18iX6U419efiHjc2X0yMb4+gOM1zpfOoVHtxM3oEAZV8uIdGyMpavZMietCQAMbFUNtO4djw9PGscElksnOTdSm1eur9bXF3XhgxelYYsgcyC2wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPEBEzq2wRVeC7mTlMoOAnEDYmN+5GAgSkjH+wOWIiQ=;
 b=AO2DEYZ4nI+zf64p6PwPXuji8b7xmCO4Mwzhfn5X315T7sQIXYu2NQhVXowJKjaStbxlWoZxV7VoOLr4eU065BNKXRHDecICFq8NgdRvuwvUZgEly5lGO/X7Y+hQ2MFm8Cl19Zzpowv2u1vwY8t4Tov2pEvBohVcW2wBFbFDTaI=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by BN7PPFABD533732.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6df) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 17:42:29 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 17:42:29 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "alexdeucher@gmail.com" <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdkfd: avoid PTL confused warning message
Thread-Topic: [PATCH] drm/amdkfd: avoid PTL confused warning message
Thread-Index: AQHdABFCsQkaArFSjU+UPI4RCcFpT7ZGJZgg
Date: Fri, 19 Jun 2026 17:42:29 +0000
Message-ID: <BL1PR12MB5898A25A157D3BC6DC6DF9C785E22@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260619172937.112275-1-jinhuieric.huang@amd.com>
In-Reply-To: <20260619172937.112275-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-19T17:41:31.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|BN7PPFABD533732:EE_
x-ms-office365-filtering-correlation-id: d06bd6c9-741c-44d7-6f04-08dece2a2264
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Ojdzre7v1KqmwO2mapmVPy9eqJvx37Af6xEDw74doT7mP582okDh5iMxTYU4Bozuhg9CvdySse+gU6rVmwl4+ePgGm3jRjzx/K4iUAwI0GdZNi2exrF4UupaHqudLstsMWJljlfZrh28dRv/Qhd4w6OFyJf5DYFQExo37uxkC8EqCYF033yfvYudVTDzkLx32GgyIjEqAooOATJZcUy053BIp6gcYZo4ulY7+xtdm0E1dVhVVR3mOJmJflrZHX2f2LJP70D2V8KJHZY1jDS5iii8bnD1VzTgVXQNw3G1dpWBGGiHBzN8ewht49COZCr4qbYlEJH+51Wf+/xVHNhLi9JLs4//lGiTmVbypDO4edoDkw9Je1DnF/tx25tyDhV369wKtaYX4XjMd4ojsOdaWUZj/isTvQH9dICn6JneKOZpx+2E9LoOFXNuCJ1RE2k8L1/ZCfdjl8fynDi+L6kvJGE+VjtAPsO4M9h9jHz20oyQG8kosPRKp/vFFFJ0GKEmPYnjVn+lZLfJBSVQIq9zNb0iEULj4B/HhFlWA5daNoy4ikQLZ+PnsjbQHlGOJ9uDkRgyqG+TrukYZ69FqtSCOHQAhXs5PpfdiznoK/Dxxsty9VYXsW2+GN9evfet89Cd2IIaYuahUPofk5Hw7ppHorTRTr4sJ6pIDJJqeacqvlCI6Q+xfroKhWHFkyC0ukK5dAMP9Rj8gaVu2z3cLAMdfgxOWgSgCnQhY58BI00bF0U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WKcMjRn4VJ5Z/XKzEEUKWKn5SjUdALHzkVMXVvTbOQQgcDSUS/ig7UEpybnh?=
 =?us-ascii?Q?ut6+ZpEZTVXNbMW3iQEJGC6yNvF290DejaN56w3pUQlroNjDuX9phPf9arvH?=
 =?us-ascii?Q?j/j04l6hJ7JItUYL5GcwjD+Nw69UqKLhHzNzjdAOEeDmwQ+Oqkx4q/A0MIB8?=
 =?us-ascii?Q?XYAAvUKguMXal6TbjKlDsuneQRsK3qWma0d+2M3PDR5r4SDuM6nIysADKNOX?=
 =?us-ascii?Q?08vn3+DXHF9gI6mLSf/kT2PHhm/Lb2qCme31Kt2h9zhNLzdKVWUMBqGk/tTu?=
 =?us-ascii?Q?6m1Z/A0f0/2N3Jx3AgvdKzesxwG7WaB9/mOw8UtwPaf/SNvrHN5iv9Ji7aI0?=
 =?us-ascii?Q?GnrbT+FhvZXVVpHPrcxnsNdDRBniTN/giz00bcdR+JrT3pPpEru9RXH9XI+n?=
 =?us-ascii?Q?fhIKQtYlNWcUN9vzEslSoEKAZGjIDQpmy+YfNOC1U/gnKLKAGNXiIlhpLXyy?=
 =?us-ascii?Q?3HRKWlBqRpsIsk0HqlmMDCcgiNLW5Dk4SReoEAdlGYPyg1H4VUS9/rBzJWzb?=
 =?us-ascii?Q?Ab4Hscao++IGmCsnYWBMMtXDkaQF1RurQBCg+wDo/LxBECR+Lr4KSt4I2AyR?=
 =?us-ascii?Q?H+V7sgF9LSF/wvbCa0VlYEnZ/swlbt9FV4fWiyb1JVrGmJRo3pVfA1F2K+Cf?=
 =?us-ascii?Q?igXJemrXuE5Ak7dsPxHulsfoNMspFP3Qqc+4tixCfLeohyx06RM+QzrUj5ww?=
 =?us-ascii?Q?74KiJ8G4HDyF7BtIIXrl5eoPDT/I3MeCgay/nYzYO6RK28tWhRK6QL9JAaU+?=
 =?us-ascii?Q?m6iMVD42gDXdFdeJEYgB84GKsSwnQMVJLYx8EjptKBgf899IUXMhIQeu29lE?=
 =?us-ascii?Q?Rz+uU9dmDoOGvrFhj6BuoJ2TlzqpAS/1nZRmyUKYiHfg8ogXQ0rjW8khl4CM?=
 =?us-ascii?Q?70Kk0SuaO2EhMIYmRXVto2wxG93Y3iT8ItD9nwjsfGgQvz5AAnsF98d+n2Li?=
 =?us-ascii?Q?1zJ5R7H+fjDe1i7pV6bvV9Ak+sytg3/RXkElq0pdAT4mPQuWEP9OXu01PAHa?=
 =?us-ascii?Q?dIa9qhUBegWNBDwtWRjqEYi9f2eDk0Q+Nwsv5AJj9ezfwLRCDdOEmiAKYi4a?=
 =?us-ascii?Q?5CUmMttg/Wu/cCpRXyS/eMNBcc4suw71e6Ksw+mqf74AI1/M95q+qtKmIjUX?=
 =?us-ascii?Q?G0XwkBgA+YHicXrlg8LapLZAt+/8pFS+7F3CcUcATDMFGjiFL5RGOFMFXKgg?=
 =?us-ascii?Q?t4pZpmpoAyBILBLrEjCbR6R7tbKwpe7y9Ew67aMCfLjCqEtUdRQSc/p85QJS?=
 =?us-ascii?Q?NarfWQjpILCKkWdRgCqc+Pdbq7UnL2kax3PHNvnZSkoWH0KNS9IsXKZNnalu?=
 =?us-ascii?Q?c4xckpElqmNWKOg6Dggj267jgv9Ej+4Ett6MnlXqhnnXpNt6nokofFV1H+sX?=
 =?us-ascii?Q?kDmMKjiNeXjIHyHNwoP1/3oC9H/DkVcoSTIDal4BS3KEqiUosGT1VpfEUqQU?=
 =?us-ascii?Q?4N8wGenAZiQyco8s6vHvmPqkewLEP1mOnbS5oEwK/N6x6Bs++mrSDKxlvPrt?=
 =?us-ascii?Q?7uVwCtz1U1Kg8iuIvISe6ebt3gFZClrqAPjzpPGQ5Klx7lvYSN3GAWPEpgX8?=
 =?us-ascii?Q?DTafE9kRon1Tq8v6qO6VdlnZysBHvsGCetESh7MbYJKgVuTmthoWleq5Lpi6?=
 =?us-ascii?Q?AEpCpSAquHR0F+/CbbCNthwAcOs1vAVeIz7JWieD/SJ7HteA4XQpLiZ9gD3g?=
 =?us-ascii?Q?+ZhYb4mC/jdsywJP+TYnNt5hR1Neto/XhZ/WqSc1+o2t+/2M?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06bd6c9-741c-44d7-6f04-08dece2a2264
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 17:42:29.3689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LGlwdK25Da2fnPRVnuoLzMlsbJJGCDU2dVaW6EKKs7CwFr+LyGMLMNnu56ZB/pX+ZhuAWwxrQxgB1nhWa22l+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFABD533732
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

AMD General

Looks like it should work. The only time we call ptl_control is from disabl=
e_request or disable_release, so we should be able to exit early in both of=
 those cases, covering the existing flow and also not sending invalid dmesg=
 warnings. Thanks!

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Sent: June 19, 2026 1:30 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>; alexdeucher@gmail.com; Huang,
> JinHuiEric <JinHuiEric.Huang@amd.com>
> Subject: [PATCH] drm/amdkfd: avoid PTL confused warning message
>
> PTL is a special feature for gfxv9.4.4, but the warning is
> always appearing on other ASICs when rocprof is running, it
> causes confusion, so move hw_supported check earlier to
> avoid it.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 575b13b557af..ab9e53dc8deb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1783,9 +1783,6 @@ static int kfd_ptl_control(struct kfd_process_devic=
e
> *pdd, bool enable)
>       uint32_t ptl_state =3D enable ? 1 : 0;
>       int ret;
>
> -     if (!ptl->hw_supported)
> -             return -EOPNOTSUPP;
> -
>       if (!pdd->dev->kfd2kgd || !pdd->dev->kfd2kgd->ptl_ctrl)
>               return -EOPNOTSUPP;
>
> @@ -1804,6 +1801,9 @@ int kfd_ptl_disable_request(struct kfd_process_devi=
ce
> *pdd,
>       struct amdgpu_ptl *ptl =3D &adev->psp.ptl;
>       int ret =3D 0;
>
> +     if (!ptl->hw_supported)
> +             return -EOPNOTSUPP;
> +
>       mutex_lock(&ptl->mutex);
>
>       if (pdd->ptl_disable_req)
> @@ -1833,6 +1833,9 @@ int kfd_ptl_disable_release(struct kfd_process_devi=
ce
> *pdd,
>       struct amdgpu_ptl *ptl =3D &adev->psp.ptl;
>       int ret =3D 0;
>
> +     if (!ptl->hw_supported)
> +             return -EOPNOTSUPP;
> +
>       mutex_lock(&ptl->mutex);
>
>       if (!pdd->ptl_disable_req)
> --
> 2.34.1

