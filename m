Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E79C83F26
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 07:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B94B010E8B5;
	Thu, 24 Jul 2025 07:58:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ttv4UE4U";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF06D10E8B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 07:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCJn/pjx2Q995fE6BuzcHwxXdx5cuLRpO4e8HO6Uu9tBRkkkXlrJTbDSIHAUVRlADCk9CJ8p8iSryZhuscsbgtjMMZ0XyN0rchp3BieNcB51SwyYPAS2UfZDUvNGvxunTPCZf1H8EkodGnFAtq14TJsoe6HG6U7rbedARn33oRvqwWEZS+8UUUIPiy0EWz0qew+J8i1eE2lrNi2HP9XZP9wJ+90F19NZgR3lKf4JijbaNC3JJazbN21ONhwy4+JYmP7UiuO+Ixx0bWtmR0NBrBSIztXeA4OQN3JmFjQiBNkLlFRG9CyDF1EEkRnQEv2X80FfnuoT7tSFSGdPUWf5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wt9gLRqKNRgAc+a5SHHSgBNmR5USmMx62DcD2z422po=;
 b=gYNEdR5PfWXIpzs9Fn6/JEPAXRY++fLNBWjLn5w7FTCR4ovCRDLGKygwrmYCoPIrLFhZ1Cz1Pz1lUH9uGo1xfNANFX4vY9bfoOHOwwK+btHxariA24U+ljhK+c7XNGtnT2vxKlC0GJ57y68VQKt2bJnqI7qxgNw9QhSXB8qoKNTO6WlvJychCi/TVw3OWo9Iaelb7OPxaBt508u8SCIyyK77ViLz9dcAdehI8Rj4S+jDKTHu1+8rcgsJZoPLpPEeOH/QRwkCk96HbeW/XFla8zPMKf6OCGHXj4Gk0W5gTrLK7zIP8HvlweaWOBow5n2aB/9zcIv3w96kR39A6ex1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wt9gLRqKNRgAc+a5SHHSgBNmR5USmMx62DcD2z422po=;
 b=ttv4UE4ULR9KE9HXCUTQegunr1oDhtvzLXktB0njzqio6yMmaPlrR34CfSs5l16AQ7WHI0A8cPgZI1NUo87Ttf9Vg7cqXfMKUidxZQ0ZmowPkX1lZLERoFAlfAFRmIsiGJprOSkg1ad49fFWGrBSagWyo5eZS6O+KPfzALIdJ2M=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 07:58:49 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 07:58:48 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: fix missing lock for cper.ring->rptr/wptr
 access
Thread-Topic: [PATCH] drm/amd/amdgpu: fix missing lock for
 cper.ring->rptr/wptr access
Thread-Index: AQHb/G4GmDhJ5nkMJkGIxU6Gq4XdeLRA6LDQ
Date: Thu, 24 Jul 2025 07:58:48 +0000
Message-ID: <PH7PR12MB8796166DE31700613AA08F72B05EA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250724073846.3991348-1-kevinyang.wang@amd.com>
In-Reply-To: <20250724073846.3991348-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-24T07:58:42.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA3PR12MB9107:EE_
x-ms-office365-filtering-correlation-id: 52e154bb-ccd4-4b4b-9220-08ddca87ebfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Sw8lyrzMwoK7CpDnkTKbRbInNR9TKnt2oVUAh+knwF685iHOdwi7MnNpQfLx?=
 =?us-ascii?Q?xW1Sp/xXecEy3gAPBVC700SpGKSnRqli8lN1vPr8EKHs94hnoQ2sziHAZ7Ut?=
 =?us-ascii?Q?0APj81HhlM+AKL6lbnarVqRhv3ZHNXahmzgKgCjp7y/HKnHmxVuS0DExRUFS?=
 =?us-ascii?Q?M+Lxf5d1OPWx6nKsi0UIhUkve46JBCNwWgKLvp4HDR+X49w5UKaoAmhk8sJ3?=
 =?us-ascii?Q?YHsiIiEzmgtISFrl4DY1r445yOpV+0Ze6bBl7P8piMXFwj9iLoR0HxMXYmM+?=
 =?us-ascii?Q?B0rq7RNHgFnf+MJ8wphuaMM9iq8nC9mohlzyv3S6GRHUz4+yE/x5pmwykXcs?=
 =?us-ascii?Q?X8xcRFZ5vTVduTV4u43EEjUbpQR3V0t4DAc+tK434Sugimyi5vnM+LKCHVLk?=
 =?us-ascii?Q?okpC+0XOA2I0TzFbduDNNpm4hzyi4o9R06VbIvU/Szx3vJko07X+IC+BgZbc?=
 =?us-ascii?Q?u7oo///mIRrUvmhRxyFIrUce+Yol+RPhdDyUszvZ5eKMB6XvXqsLLz9ViK48?=
 =?us-ascii?Q?LmVV3it6p01iXprtrO1ERlJBGVpEbuUUf8HcaCEkYDSNJJPbFWrXateTZ9uZ?=
 =?us-ascii?Q?yawU7K4/5GwHQ285lLkflD5+YfZmZ9kBMQmj274BWqB/e59D+6PdYzz6OHBT?=
 =?us-ascii?Q?qMrPTCUKyqnsZ7OMtloS2Qs0VOaAur8qOvHWVc4rwasMGt0t9bxKIHA4ccx1?=
 =?us-ascii?Q?n1+RDVOwAIWqh/BVC5wpvd3b+5x9PGBHMuk0v+HTrwmGRdd3o2FJ3bo/Q1pa?=
 =?us-ascii?Q?UY+cFVPJN9v2SPzAjVYv1FWx96Rzm4I7SAotXvYe+Ki0IGyixCDTdwXXdAY5?=
 =?us-ascii?Q?/k+WEyxaZeV9PW1LHa2lW6sD9ItDow3E8ioqIQu+k2wrNH5fESODVnNyV30V?=
 =?us-ascii?Q?eNUrHE5oof//mSNV5xTz/x8rf0heQgXpGOUwje9wdrR1bhHw5iKZdGEy2pxO?=
 =?us-ascii?Q?osJ/yIZb/1ijJIlo/PsL20CRFGn2GVWHAO3jJEk6V64gUkN/bmJrWc0eJkeg?=
 =?us-ascii?Q?F0j5un08AyaBjUBu+AtT7mbkFrQZ+16D6vQJwy0xQeNlmykS8G7nc8ERbkUD?=
 =?us-ascii?Q?fe+77aRKQZhssMbU0EQRqt38orJ9EdxCvS2ndq5YeLL9QcmkXZY5keMoGs1X?=
 =?us-ascii?Q?YNesXo4HhLwz0neU+521OqIUtrziHrS3Ce7fXkx0A+/MhJheQ9G9Bf5AaTxc?=
 =?us-ascii?Q?UchDCEtsfNGT20Fk58yEX34XNHGEYmmjDmKFFMb4Ua/CH++97Yrz3pnt2Ft0?=
 =?us-ascii?Q?FlCSLGB5kPb0gZr6gSI4uYaVgJ0ZcfilQ86uy7QWtbgpTaqYjYpTQYpYtejf?=
 =?us-ascii?Q?NVLzVh23YIrO9HGJiCXHHJPxOgAHKO49Yw7YVjLL2SvtDhYTzygw5NhLGhqo?=
 =?us-ascii?Q?9L+o1IU2zu3lIP6ruQg+R/LLzdxZdMvTX6wE7xGNXvcBR0wHG1v5M8zbvSAV?=
 =?us-ascii?Q?3kTNoNM4YdnQoFixBSw4EJTxoExfEp/la8LyM/zw8DvHldksxXyw+w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bDzkVwtP8vI4yCsyMwUOSS0cu1Yea5nPwMG0zOSkqRVBLGhsvBMY3259kI70?=
 =?us-ascii?Q?ROxh3F5wCPde019NP2ezqRw+EzuGH7ApMe6gya3Y9ykR58vnPUBH3/G0w/P5?=
 =?us-ascii?Q?Umi4rNfdWATpL6/HnQ7+0oIaAmIn0BCxFQe4gi6SrW6vDuzDhZmbyc6C8bZp?=
 =?us-ascii?Q?+q5xd9RmCHfYBcSySg5YhfPx97jQLOHI0Lz6l/JMTnGzOmF9LtD4SXQT/8gD?=
 =?us-ascii?Q?DsXc5w5TO4DaxKkbGXChR4bn1J7H8DARbj4L4l2uHwrh/284QxcVdr8Bx6PL?=
 =?us-ascii?Q?ZtO5szOMm8Jm2IMYlgwbFzAEzroQKJ21lERHJe7aaNnbMhgjd/pPJEXk1yZw?=
 =?us-ascii?Q?JdvCujl0GXHVU8fJTqwkIF1K54vkt47jqDZhAhr2HsBoievrObgecILYIUzY?=
 =?us-ascii?Q?yi/HCkdcTNPK5vfjF2/T+W+WlThuHooBxs9E7P2Y43Vxd6RBuiNFG/msDpbi?=
 =?us-ascii?Q?4iuZMZ4f7WCtVNySF2Sa9gN/dTjmPCfSUxE5Pa1K4OKQAQbKRatPjYSSKkSu?=
 =?us-ascii?Q?K+juAaIhAttb3VuT6Xv8l5GcepPjVC0AW1taZ9PE+3u1erRypbeykXePYfqc?=
 =?us-ascii?Q?fiPOHaHhQw18Xmmrv6Gqti3RZrVKRBCpXf9072d0sncnSST4Sfmke+Zj1awP?=
 =?us-ascii?Q?WZbmszDP/mY7rNffBOKPCkjXJrKGhDg7OBJqwMwCaQeBxU4qXzb7kc+BK/Ve?=
 =?us-ascii?Q?y32Ca6Y4a3MXEbete/BKmeUmneovUb2yLeW5q4n6nfy0nHaekYeh1HBOetUx?=
 =?us-ascii?Q?v/bLtk1u107C7wDAsp10DgfKI3HZ4sbEnf8VIAqF060v5irkTrQKG72ifEyA?=
 =?us-ascii?Q?C5GuZALVLt1TM7f1nVyFcqm3/TtdcbBKKSHaQpS50fa8ok3yvRh+30w+7zXD?=
 =?us-ascii?Q?cOjO8aChw/rrnDRww3csRY9BBNWeB3LJQTiudtyW+/yGrEj0uibbhLJaEIRW?=
 =?us-ascii?Q?GOSoE1eIOkHHotxvIvkN+PSg3WZKEYb7gWbWaLa+kW5JzCtMF/j8bOK8iGae?=
 =?us-ascii?Q?SNJjGaEPmYdXFv3o5zzRvdZ9sUR7XIaZzDy3E1DcD3+ng9bE1JJfczt0N0CS?=
 =?us-ascii?Q?Awy//6pcOiEZsVXdWQJkmA686sucYVH0j9zph5FzOm25hMSuExHY0+Nfen6J?=
 =?us-ascii?Q?2C2oAEW1w29jo8ViJJNE0K8SYbGpW9q6fb3FKSsaaYfYnepfQCG66NXsnqSi?=
 =?us-ascii?Q?MdiM6MQN2UdQi1Oua20XLip/gTEDtmEbT90IoavWOHN2jICZ8aK7E8AhIK9s?=
 =?us-ascii?Q?kBpoC/bFuf6z2bafxglPeGdoLXV+epQm8mUi1iO9cz6mBWru31ALtPt4L79Q?=
 =?us-ascii?Q?oLLJ88BSQ8/lq6gmuU79Dgn9hkdNMFRZEu3sSc3d8bRmtjWnrHQpGAvPg0XL?=
 =?us-ascii?Q?OSTiDRY4zGWyKnRFGiGjBBcm8l5nHDsqkhVj0d6JRSvJMONhhB2Sx5tpsplT?=
 =?us-ascii?Q?OMyOU3sEu9PSzodIawZQFxachtXEe3K0gxxWOPNAU0vIOHbQ/GOCwNel+GSl?=
 =?us-ascii?Q?+09/Qn+a2BcIWvAiZCzI9oaIbED2vRGw2lDhA0DDH52cfDQGGXEPTncT7z4B?=
 =?us-ascii?Q?/KISzelsN9GKrvIXSks=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e154bb-ccd4-4b4b-9220-08ddca87ebfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 07:58:48.5067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPEuoKXfg95TUgPI3WX6IswuUM7W27IDboQbh24rz1j1U65dwd0laxvagk5SUxa0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Thursday, July 24, 2025 3:39 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amd/amdgpu: fix missing lock for cper.ring->rptr/wpt=
r access
>
> Add lock protection for 'ring->wptr'/'ring->rptr' to ensure the correct e=
xecution.
>
> Fixes: 8652920d2c00 ("drm/amdgpu: add mutex lock for cper ring")
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> index 15dde1f50328..25252231a68a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> @@ -459,7 +459,7 @@ static u32 amdgpu_cper_ring_get_ent_sz(struct
> amdgpu_ring *ring, u64 pos)
>
>  void amdgpu_cper_ring_write(struct amdgpu_ring *ring, void *src, int cou=
nt)  {
> -     u64 pos, wptr_old, rptr =3D *ring->rptr_cpu_addr & ring->ptr_mask;
> +     u64 pos, wptr_old, rptr;
>       int rec_cnt_dw =3D count >> 2;
>       u32 chunk, ent_sz;
>       u8 *s =3D (u8 *)src;
> @@ -472,9 +472,11 @@ void amdgpu_cper_ring_write(struct amdgpu_ring *ring=
,
> void *src, int count)
>               return;
>       }
>
> +     mutex_lock(&ring->adev->cper.ring_lock);
> +
>       wptr_old =3D ring->wptr;
> +     rptr =3D *ring->rptr_cpu_addr & ring->ptr_mask;
>
> -     mutex_lock(&ring->adev->cper.ring_lock);
>       while (count) {
>               ent_sz =3D amdgpu_cper_ring_get_ent_sz(ring, ring->wptr);
>               chunk =3D umin(ent_sz, count);
> --
> 2.34.1

