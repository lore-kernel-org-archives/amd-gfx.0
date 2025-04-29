Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855FAC3ABAA
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 09:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2287010E3FA;
	Tue, 29 Apr 2025 09:04:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Een0Bkxb";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE70710E3FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 09:04:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKl3gFEoQhPS2ytN2Dq9lx8ctOuS/8ffg+17W7hkuV2CRD0MS7rHsoMVlFO0KbTv2WhEulaFg6iNN1muGnFZ7qhpeSFDIha5yVuHIOptGJO42raMewyTjJSk18ExK8ASw3IH/9Om4X/cl/s6MA+jbnBVc3dofbjM+xriRwmLBcFfHEnv0DGnOS30xeO4AXBQG2DWIl66I82GpyDRbFWmQzSc/nwvEzmLpNpDRMBypHYSgWqfjPAsmiYKlrC5usn+CucdX3rRISiRJoDYURffDaUMzOFIkdf+UXFmiqOmg8QqHo/1ikmdtQSIvSiV3bwLAyQ1PovEF496tqGufIYeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaAkArVw505YBQkyXiY3O6t+CZfmO/a5zxYUbqsmVSk=;
 b=dtcrtuwwzlnkdy7NSA+KERVIsVzO6AVtj0hbeckhdvgElav0XKQMiVvEltA5uRB9rNji7gRup5uin+skvof8hQOWZCgK1Hq1SMd5V8dyrq13vyNd6pIFSvccsEbgd3wpCLZQJDWUxhnu+wnPxcyHeHoudLI5P8iB+ELNcGZtXBmMLSEs/qECiiUcspvojZHuJOA0tYF0T93L/4x0Hq0FDm+jYy6L6EYBCTibxpQbrJ4jcu+8+3ZW8FNaBEbYbEIzJyoWbPh4gypWKzrlWiddrOzB8R0sMXC5/grqf+QldjDI5BpVuP4OYaMFavgYRlfcFx6Gjw0/5dKPEqNv7baerQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaAkArVw505YBQkyXiY3O6t+CZfmO/a5zxYUbqsmVSk=;
 b=Een0BkxbVp/kKLZxsr+hIHk3jsFvjMFfTSnU1dPnbSQIv0qjdzHlk+/D/bBUYZQisDDl1AHBDIh4eZx3oIV+LhZT9xZA1FjG/FGbK8GyIjKoGGzEnKSR0Kq7xdgjp5vBaZ5D+Byxkv+1nEEoDZ1RfUEpc98IfaSwshquE4jU8MA=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 09:04:03 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 09:04:03 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Add support for leagcy records in eeprom format V3
Thread-Topic: [PATCH] Add support for leagcy records in eeprom format V3
Thread-Index: AQHbuNSUANFmmHij/Ui8QLmjMrpo87O6VoAAgAABLtA=
Date: Tue, 29 Apr 2025 09:04:03 +0000
Message-ID: <MW5PR12MB5684B2000B58EB14048AC397E5802@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <20250429070121.299873-1-ganglxie@amd.com>
 <PH7PR12MB8796DF080D6D991A7CC37ABBB0802@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796DF080D6D991A7CC37ABBB0802@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=277a55aa-6944-400b-8930-8ac0888aa38b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-29T08:51:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|CH3PR12MB9099:EE_
x-ms-office365-filtering-correlation-id: 128eece8-1ee3-4c82-b7db-08dd86fcca0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?X2Pf+KhNmic1k2yxVUBOQWBouYeaNwAE+EddoX6Ss2Hq3kahwoqJdBfN1kD6?=
 =?us-ascii?Q?VsRFRCMPKGGJwVYiihFYC5d3GNTnFOsx8o03+vkr/tfH2G8FV4gNESxS9K2M?=
 =?us-ascii?Q?IuKgCfoq1/1sRnRpf10NL4nydlYgp2LfiWNEp+fcIed8H2IV25ojZ1H2tinN?=
 =?us-ascii?Q?CEMSyMJ79xV6pgfMx4O3RzHv1AHNa4DhYo9KnqNAI0cQ1llgER/zv1ZoOkZq?=
 =?us-ascii?Q?UyvON505lXqWSmqmFKaJgF3fbexn3OT8waf4IUgDHDY/FviP0ImotQ36IZI5?=
 =?us-ascii?Q?tGfP1+6vwd3F4IeF4jPaIazlJiVy957t7LzWKhHgSciewR1HgcRSRQCindBe?=
 =?us-ascii?Q?yQCAU8SMTeHX0IhhC6XcYLu0cBdMbPmoK4lEj4aqfzDBDXMoWiNPcDVuemzf?=
 =?us-ascii?Q?dmcEnStvceX8lM7nb0nej1hqPakpzjGvava5L8Pkr5fxWR40J0P+0QBTjFi1?=
 =?us-ascii?Q?aaevlJzG4YHrl6OH6ZEiT7jRCJNNMN7eJlIA2mMpZNwmXQWWr0u+yIe3clh6?=
 =?us-ascii?Q?fJOIoRsK3EOYZS/jaJvOq9jSSDbbOJelOix04b+wXfxfjrC9qmiiuo+g2KsX?=
 =?us-ascii?Q?QNmk9itTtqUb78ezEG/CWJ+Q5YJXp71SBmAzqhb07DAwYmnIs5lUqjiFygHd?=
 =?us-ascii?Q?AoyYVox+rgVj505l/+qppG4XXuOaMItA7ret7Btk1hvMLuKBDvolSdpE9HaC?=
 =?us-ascii?Q?n+Jyfgy6efA8ZLIojyzy2s4QcQRuxt+NajxW0BybzYzY/CTFx/ugPTBFE6CM?=
 =?us-ascii?Q?pVLCt8pqgGmwtIdYLLGwy/nsBvk8GybH7StwkGjq7Y1x57/hg9Jx1DQLYQzy?=
 =?us-ascii?Q?bw9Bj5bHU2944glM4kecSOCdAvehqvZ1SA7Xuov3GxAgrIcKEaPaDCT87j0n?=
 =?us-ascii?Q?ccuRKx+hMO48CKu62geqfZgzAULwfK8cVKWbKcR9gXPmgNi0D4pmj0urXWw4?=
 =?us-ascii?Q?hovfz2SOgVIJsW7wJnRn0e1PXZ/aMKxdYg335PVMqgUEwfZPnOP3WRV8I1Jx?=
 =?us-ascii?Q?5KDOvCbu3lhtNnCGLbvGjROV3WOb/f8TXlpZ4EEyF8me/GT+uGzrj6CtWtBT?=
 =?us-ascii?Q?tpsKbtMkDkT6afTg/jrYMADp+daYi+YZdURz6ZEC4cGksrQ9hUBaIj9Ge5ir?=
 =?us-ascii?Q?l2UjspL7FeIGusV+L9HZJvEUwhPwbQ90IkIyfrur3JBI9Sd/Q7jtqL9dVLCt?=
 =?us-ascii?Q?f6ujp8beVks2FgVbJiLVZLT26DS4xukHTlp0Q1HYBXmvUg23fivubfnrMfTY?=
 =?us-ascii?Q?c0SRGvCeaSwZzKDfgosXvD5LEc1NV93BSb1TmlNmOImd7BXgyVc4UQWMru5i?=
 =?us-ascii?Q?ynRvPmalcQ3gtODaAYRPRWde1SBbDphtCSh7TFDC96AUo+Jvn4GCPslgrAAz?=
 =?us-ascii?Q?BR2quZOeko6op9A4Tw+CIVtu7pw4F3e0HW38ovRaxXQ+FcO5Y4c8Tj6shtjn?=
 =?us-ascii?Q?s0aA2XS1MQo5EtLGKYfjhASJRhyUG3nBzQ4oKYp1h2jlDpaMKlxB1w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eU6k3sVxgf/WDh1Egnfy0bWYUwyVMXEsixngxsZ1SN/Xv4znKnGMIxmxUzGD?=
 =?us-ascii?Q?RrcNkaRR54VTCl2Ci6eublfYSugm8Nh3/tPyOliw8doGqrZj0EjFS0anTx4R?=
 =?us-ascii?Q?7F5zYuzNuI600R+AvXy0WF0mmQHNbZjtyA3xdB//vKgCUnW4PQfD4eim/B2w?=
 =?us-ascii?Q?MUAhx+QSdnO9MZm/h2UYsqP7B6yRN7sIBntACt0CAcFU3WvVkbw2CIA5vrrD?=
 =?us-ascii?Q?GgjiElwEAy3DlutAxCt7tw71exg5zr3/TwI3FNB5GoAw8vsg8XLbIoZBpbVN?=
 =?us-ascii?Q?2XYMz0Q1wgnX1RtOMfrS+XAaTLm/q9vvyrx4WZ5w5B953FHKmmb0RqMl4jyu?=
 =?us-ascii?Q?UOL4GCY8OznWbG57jxufpzAfFKV9EB5kfwrCrnkpQpHPFsIJr6S4QzO2/uSg?=
 =?us-ascii?Q?cV3vPyDXTnLGTnanXaWLTgh6rZhBRhaHLknA31QyGyybV6bB1lHD0k6YJAaJ?=
 =?us-ascii?Q?3NatNNI8/Dk5HrM7ZNbu4En+1ZxxbtYgNJjwlenK9KqJlD6/HLBKmegc10h3?=
 =?us-ascii?Q?9zA0KxnMx6biFR2uijMwJIWLWOv1ZVRHgLvivdtPw1Qzqqe6/hbx1xZLaOHR?=
 =?us-ascii?Q?bBfa6m4n5Q4O7oih3fF8tCHnsy70gQ4WZXElgnnm3T+55pEQxNzHieakIg/O?=
 =?us-ascii?Q?wUzFDBf3s6EXbJ5tBA7WCIWp/R72w8hcWD2a89wn2Dt964Ayk0PS35BXySD6?=
 =?us-ascii?Q?Rkg4Rl+oDZX+y6s2jmPX4ktGZ1O/5Tr3oKfU8vfM8MYd8wOPlRhxUThmhJcj?=
 =?us-ascii?Q?j/xTecEZ1zJ4z6y/iJvEax2YuoHFEM3dYoRAv94EVB+AgmybhM1+v8TsPir3?=
 =?us-ascii?Q?f3y59Rkr/9OEXjG0Gaw0RiY71O2ACIUCp2t2ybnsPZSM8Rz8qtNhZvMf7jHJ?=
 =?us-ascii?Q?xGJu66qItsz2p2N6GxPehq8VijaULWG8/WH6/AiP9OffAuL32rHeg9rvZzP3?=
 =?us-ascii?Q?5GWDRG5hrDyPFGyF/7QABDFVjWar90kWhibtxqUTVIUE2MpOvuodZ584uFWk?=
 =?us-ascii?Q?FTI+CCyj/ss1bywt71fESdWyW5oRp6qA25xYi0gQRYbfAN1c4bvTUwTrMV2V?=
 =?us-ascii?Q?MppvYwNqQufKpTPkzGjCk+67j6Aw0+AULOYVnIcblfIdvKON0mdwtDpR/6bQ?=
 =?us-ascii?Q?nbwYO0T+ZYi7y5VaLl092TAPtOmh3169xdS4PIIdw8jsvDwmK5M3D21WmQNy?=
 =?us-ascii?Q?KjT8xmj2hSRitRmFhk/LnClQ6KKa4Kbm9Kvz7FAAMqmkytBBWrkRUzMTgx78?=
 =?us-ascii?Q?1eoCjE5UkdkMPRYUlc/NbMZPioVob3OGdjmDBRkvUnikZLOI0wvFNYfMEl/f?=
 =?us-ascii?Q?4k92prFKYaNS5NZC52Qg8Lgif2IwBiWd8bqDqhpvWraLeOKtdYKn3NmHiEJy?=
 =?us-ascii?Q?oHJsSh1qNlxoHIyY7l2Ne/ErfUuKdCeHghfwM8iwWKcrdD7KBDQc0pDuVVkG?=
 =?us-ascii?Q?J772M5KcvYgOpIVEmla9cGC9UiZigyYAUU6YG5zWUhboXCTAJsggiIlDDwEd?=
 =?us-ascii?Q?EekOyCoiYAlJ4EhAwNtCht4A1/sVxhvlSl/WmnMU2+chx0bAu7XStCO4WHMW?=
 =?us-ascii?Q?mKdL1/CYCiSU6HIzVok=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128eece8-1ee3-4c82-b7db-08dd86fcca0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 09:04:03.6114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aKH7HbY0JxFZTIHvq2hAwQqPwewmXg03p4nk0DSEJ3FusKl99oJCBT1lkHBC5qpORd36I0mNdgpIfHXFvqpaRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099
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

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, April 29, 2025 4:53 PM
To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] Add support for leagcy records in eeprom format V3

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Tuesday, April 29, 2025 3:01 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick
> <Gangliang.Xie@amd.com>
> Subject: [PATCH] Add support for leagcy records in eeprom format V3
>
> After eeprom records format upgrades to V3, records that have 'address
> =3D=3D 0' should be supported in NPS1
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 73
> ++++++++++++++++---------
>  1 file changed, 48 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e85143acf3a2..4f4e12452ecc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2881,6 +2881,17 @@ static int
> __amdgpu_ras_convert_rec_from_rom(struct
> amdgpu_device *adev,
>       save_nps =3D (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
>       bps->retired_page &=3D ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
>
> +     /* if address=3D=3D 0, the rec must be a PA rec under NPS1 */
> +     if (bps->address =3D=3D 0) {
> +             if (nps =3D=3D AMDGPU_NPS1_PARTITION_MODE) {
> +                     if (amdgpu_umc_pages_in_a_row(adev, err_data,
> +                             bps->retired_page <<
> AMDGPU_GPU_PAGE_SHIFT))
> +                             return -EINVAL;
> +                     goto out;
> +             } else {
> +                     return -EOPNOTSUPP;
> +             }
> +     }

[Tao] better to add an empty line here.
[Patrick] will add this empty line

>       if (save_nps =3D=3D nps) {

[Tao] is possible that both "bps->address =3D=3D 0" and "(save_nps =3D=3D n=
ps " are true?
[Patrick]Yes, all of the "address=3D=3D0" records have save_nps=3DNPS1, so =
when loading the records in NPS1, save_nps=3D=3Dnps. But it does not matter=
, I check "address=3D=3D0" ahead of "save_nps=3D=3Dnps" , the code won't go=
 to "save_nps=3D=3Dnps"'s checking at any case.
>               if (amdgpu_umc_pages_in_a_row(adev, err_data,
>                               bps->retired_page <<
> AMDGPU_GPU_PAGE_SHIFT)) @@ -2889,6 +2900,8 @@ static int
> __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
>               if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
>                       return -EINVAL;
>       }
> +
> +out:
>       return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
>
> adev-
> >umc.retire_unit);
>  }
> @@ -2903,7 +2916,7 @@ int amdgpu_ras_add_bad_pages(struct
> amdgpu_device *adev,
>                       &adev->psp.ras_context.ras->eeprom_control;
>       enum amdgpu_memory_partition nps =3D AMDGPU_NPS1_PARTITION_MODE;
>       int ret =3D 0;
> -     uint32_t i;
> +     uint32_t i =3D 0;
>
>       if (!con || !con->eh_data || !bps || pages <=3D 0)
>               return 0;
> @@ -2924,28 +2937,31 @@ int amdgpu_ras_add_bad_pages(struct
> amdgpu_device *adev,
>       mutex_lock(&con->recovery_lock);
>
>       if (from_rom) {
> -             for (i =3D 0; i < pages; i++) {
> -                     if (control->ras_num_recs - i >=3D adev->umc.retire=
_unit) {
> -                             if ((bps[i].address =3D=3D bps[i + 1].addre=
ss) &&
> -                                 (bps[i].mem_channel =3D=3D bps[i + 1].m=
em_channel)) {
> -                                     //deal with retire_unit records a t=
ime
> -                                     ret =3D
> __amdgpu_ras_convert_rec_array_from_rom(adev,
> -                                                                     &bp=
s[i],
> &err_data, nps);
> -                                     if (ret)
> -                                             goto free;
> -                                     i +=3D (adev->umc.retire_unit - 1);
> +             /* there is no pa recs in V3, so skip pa recs processing */
> +             if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
> +                     for (i =3D 0; i < pages; i++) {
> +                             if (control->ras_num_recs - i >=3D
> + adev->umc.retire_unit)
> {
> +                                     if ((bps[i].address =3D=3D bps[i + =
1].address) &&
> +                                             (bps[i].mem_channel =3D=3D
> + bps[i +
> 1].mem_channel)) {
> +                                             /* deal with retire_unit re=
cords a time */
> +                                             ret =3D
> __amdgpu_ras_convert_rec_array_from_rom(adev,
> +
> + &bps[i],
> &err_data, nps);
> +                                             if (ret)
> +
> + control->ras_num_bad_pages -
> =3D adev->umc.retire_unit;
> +                                             i +=3D (adev->umc.retire_un=
it - 1);
> +                                     } else {
> +                                             break;
> +                                     }
>                               } else {
>                                       break;
>                               }
> -                     } else {
> -                             break;
>                       }
>               }
>               for (; i < pages; i++) {
>                       ret =3D __amdgpu_ras_convert_rec_from_rom(adev,
>                               &bps[i], &err_data, nps);
>                       if (ret)
> -                             goto free;
> +                             control->ras_num_bad_pages -=3D adev-
> >umc.retire_unit;
>               }
>       } else {
>               ret =3D __amdgpu_ras_restore_bad_pages(adev, bps, pages);
> @@ -
> 3040,21 +3056,28 @@ static int amdgpu_ras_load_bad_pages(struct
> amdgpu_device *adev)
>               dev_err(adev->dev, "Failed to load EEPROM table records!");
>       } else {
>               if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
> -                     for (i =3D 0; i < control->ras_num_recs; i++) {
> -                             if ((control->ras_num_recs - i) >=3D adev-
> >umc.retire_unit) {
> -                                     if ((bps[i].address =3D=3D bps[i + =
1].address) &&
> -                                             (bps[i].mem_channel =3D=3D =
bps[i +
> 1].mem_channel)) {
> -                                             control->ras_num_pa_recs +=
=3D adev-
> >umc.retire_unit;
> -                                             i +=3D (adev->umc.retire_un=
it - 1);
> +                     /*In V3, there is no pa recs, and some
> + cases(when
> address=3D=3D0) may be parsed
> +                     as pa recs, so add verion check to avoid it.
> +                     */
> +                     if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
> +                             for (i =3D 0; i < control->ras_num_recs; i+=
+) {
> +                                     if ((control->ras_num_recs - i)
> + >=3D adev-
> >umc.retire_unit) {
> +                                             if ((bps[i].address =3D=3D
> + bps[i +
> 1].address) &&
> +
> + (bps[i].mem_channel =3D=3D bps[i +
> 1].mem_channel)) {
> +
> + control->ras_num_pa_recs +=3D
> adev->umc.retire_unit;
> +                                                     i +=3D (adev->umc.r=
etire_unit - 1);
> +                                             } else {
> +                                                     control->ras_num_mc=
a_recs +=3D
> +
> + (control-
> >ras_num_recs - i);
> +                                                     break;
> +                                             }
>                                       } else {
> -                                             control->ras_num_mca_recs +=
=3D
> -                                                                     (co=
ntrol-
> >ras_num_recs - i);
> +
> + control->ras_num_mca_recs +=3D
> (control->ras_num_recs - i);
>                                               break;
>                                       }
> -                             } else {
> -                                     control->ras_num_mca_recs +=3D (con=
trol-
> >ras_num_recs - i);
> -                                     break;
>                               }
> +                     } else {
> +                             control->ras_num_mca_recs =3D control-
> >ras_num_recs;
>                       }
>               }
>
> --
> 2.34.1


