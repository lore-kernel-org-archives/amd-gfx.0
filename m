Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E198BC36000
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 19:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B03B10E829;
	Fri, 21 Mar 2025 19:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZFO4Z71S";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98AF410E829
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 19:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbPsMuueWQA8oi7GwTBZw1IV32J1u6R+roYKVlQ8T+dKD7OVzN6/J/9BMAdEdWrqRhY31Y7T/ZjHMoExW01wetvS62UHBnqD+OSXSke+EPl06uQcYlO8UHKC9dQk7j2w4zrEstbD5wfz1qwGrVFBdMafUTa8P6scH287jFp2AVl14DSwYJBhJB3XqPONWGnjyROrGddADhb31uRiPXr2qFKv+9Hf7BUnOGDxsigvL3qX0kjjA1NXwFAy8E/i2p2BJcUin0lUr2UH9rcLvDjYKkRS+aSCPQMmBhZWbnj/EzwheDxe8s7UyHn05lX83zS/Vq4lFkmzTEWyMjD1RLG9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c97QErTu19ZIKwKuuQCeuVeDb2bQOT8vjrdQ+AYB7Fw=;
 b=jBNCtvPwvJFlR4ZSSGHtYd7N8ofSvCEj86/QTDz/AMxkYAVD2FI9dCzj1LuVMweGLTSFvADpwqT4/Hew80bj+zGfx3Cv9hR5k5rOqY9361jnrQ2KhcatYk0AxO1MPyneq6gqrT37zUp3lmLTRE/d5O5lb/7vgNAwBWjrLP5klaeAkvRAwmX7BK+JsSsXhtcQZ++4+QUEMmnVkWralborAtV0vVmtd782aOWnBoNkO8Cq0UzAV+R5G8XzlI2sf2oJfq1bPHqju7ZHRs07l6J9S1dbckTpnbvwNGhk2xId5qpS5Wf3aSjhQUeVdvRfJ2hPNHn9lIivug/LDMPA+X7ZYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c97QErTu19ZIKwKuuQCeuVeDb2bQOT8vjrdQ+AYB7Fw=;
 b=ZFO4Z71S6rvPtD+ZsZG7mBQv2/dl2FfuuuEzedA6tCeJmkC3ItdlLaQR+YfAJgjt1tfDrzVHQN1OBY/dwuUYxhQZF/zxNdapew+7pMp+MpJ+/NWJW6c2ffzoE5YnZQghikVR02J6Ln39hqrhsQiu8pfbyZ66b6sLzYMu+hTZ0Bk=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 19:36:47 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 19:36:47 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Increase KIQ invalidate_tlbs timeout
Thread-Topic: [PATCH] drm/amdgpu: Increase KIQ invalidate_tlbs timeout
Thread-Index: AQHbmo7hCtyA1BbKnE6dg0sv7Frw97N9+vFw
Date: Fri, 21 Mar 2025 19:36:47 +0000
Message-ID: <BL1PR12MB58984DC8346F9D80820501B985DB2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20250321182658.22436-1-jay.cornwall@amd.com>
In-Reply-To: <20250321182658.22436-1-jay.cornwall@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=ac866af9-1f67-4338-90c1-08429e697fd5;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-21T19:36:13Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|PH7PR12MB6785:EE_
x-ms-office365-filtering-correlation-id: 3e9b5ac1-e02b-4674-fb1f-08dd68afb80b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+eDf1OdS3K+nVjBrPU87vVApI3ZGkRi1NSoSmXY8vFS9AlaSaRn7GJYziJqk?=
 =?us-ascii?Q?C/j+jkJj2hjBHqUSwHHXqilfAzUQ1iB5PMOrYd2f5fyW36lxTtz7Xdc2Rt4L?=
 =?us-ascii?Q?6my1s9mOyjUVcxoOMQVrG27gt9UIhHnQvHrjgAdkITRTJtKo6m6bJ2HY5/v9?=
 =?us-ascii?Q?l/3DJmc8hKhBdNAc8cmx3m+aiWWJXZ+btcql4X/mdSyRz1j4xnNNk36F/QRG?=
 =?us-ascii?Q?gktLuGhyhgln01+dIeq6fnZ7UPOC7nyhGnRtJtB95V0YNXpROHLkzTAbIy3b?=
 =?us-ascii?Q?r+9gDBW29Cp+QSzRf9GbCKS5CJdp+EDdIZaiLuPBlud3ujSDi6g4XKe3gNXv?=
 =?us-ascii?Q?g+MS0q77f7o7twlbkRqVctqNujsec9Xxp+xfHs5wAuDiFHjXJGrjQGCn6+MO?=
 =?us-ascii?Q?QLSHUkCjg6/TwAgzDVnRDIYROcnNzWJutEnZQadkPb9Id//4llfWEeCfm1O6?=
 =?us-ascii?Q?JAlnQBgJpj1JpMs1E1AOgjTlHxY2POKymFzupwnFywRPnGrAL5kYpmYcNVyV?=
 =?us-ascii?Q?lNIz9RsaHSF6AfA1fc4bbK/jYJ96gj6CNZ6UR4ym9fiWnMirpuTJbYmk4Nwl?=
 =?us-ascii?Q?o8IYzLEumzp5TXA7u4qaZLHegFG5Sp11ylPG4BXOVeOjzK1Fto5I1JIgsSRv?=
 =?us-ascii?Q?CQLnEIv8vYFanoZLA4j0nXnLxb0WR+jCATpYtxrX3R1nNW1txHQrcC7o/yMU?=
 =?us-ascii?Q?HAx5cONblcJtwM3CN/VZIOXlJANBHM8H+vEidT8RF+yN7anPsK7B0/Uh6v3F?=
 =?us-ascii?Q?1RYH/BY1D9wbk0y3nPrbDlHcQtS04NzNSoH6DFFV8gN1cZg/IxphXp06VaG8?=
 =?us-ascii?Q?AhtJHQy/ZhPHuXBNVng30AtaAe6umR9xPSo56T5ICHb6kboN1mWBQZEKWMbT?=
 =?us-ascii?Q?ODWh2VRTz3qV3SSKsslTlsfOVVZGZO/KqwczSaqx5BgTIPYBTXNGYBxRluJb?=
 =?us-ascii?Q?LkKxcYdnOB4zO+HnUggcXtHLJCvZSkw/qjzk22ko1WtFih38B/LwGc35Cpls?=
 =?us-ascii?Q?q44VcBQmL7QOXoLbX1mNzpUfLpd2MsfQe1785RZskSpjYpo7ECUWMX8eRQ51?=
 =?us-ascii?Q?84erBZMu7IQNl0q6lBA6nBJKS0BMSc7yIM/++TgFgrHu6UAi/MGVQYODmc7u?=
 =?us-ascii?Q?lbXlczuwjEE5zLnfcHx2IBAQl4ML/xbMlgTxAwMMrqIx/FgNNKOPb+txtYnA?=
 =?us-ascii?Q?ezsiyAHXys9DBXMg30vlhrVz5s59EJgYTtHia5P7bMKswFjc43Y0gEURjRLa?=
 =?us-ascii?Q?2f50LE04HNNZUUbwZhzUILNWPORJsSZ0x2QahnaoAinxQYGqNldU9DD19NF6?=
 =?us-ascii?Q?FJ4niGhI5A+vFtaljuuHkcdOezsTOWrddKcWn7WcbWzyEVS1O3Cz/ejLaSwl?=
 =?us-ascii?Q?PMMCRobknsU3dwhFmUjmD7cRq7DmaJap6ybNIkPVjCD3IIT7/8KVpPfNXF/W?=
 =?us-ascii?Q?dLBEv7heK//om3Gc2WQ0IbWBQD9A7KzB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qvpsW2Chf601fQO2bNPI7ypRksA//vmDA+m1TLxDcGQnj/9hkL5ldrBnfnDF?=
 =?us-ascii?Q?oYqXvB7Wavow64onRgEerYyT2aCYiDeZAPlHRFZu42cTRDy0wAjeSysqF3BP?=
 =?us-ascii?Q?VlCainToKcLXpXf9J+eWMoqjBBvP8Y6ihiWwtfIx9UBttdKO7RZwmrxHJvW/?=
 =?us-ascii?Q?Pk08N14H6E7Rgjqxc7NOZDA6AolteGaGnLT9b18CChMvJ+bm4N21MWNYy3/o?=
 =?us-ascii?Q?V24Pqlwi8vxqoJit+FtaQo6ZqdyZgYrEZ8kj7CKrGkAifleRFunMfUdnynEh?=
 =?us-ascii?Q?sRK2JFkKEePcqwQ2LR+/VD4AKAb1T/bZ7pMUy33KMWfP/2I+9+W8wZuSGQs0?=
 =?us-ascii?Q?Io7itL9Dr4z/Ml4eIlrGO1oS7AxeWulds6Yqb0iVOn86qob/GgmSFl+//qQe?=
 =?us-ascii?Q?2uhbhxly5OdlaTi0vGh4aTgN+mhCEFO6EZyvoswOPFIbJb9iDswwLU17t5Zz?=
 =?us-ascii?Q?EiS5AsqIOwuQ0DrFs6Vx+yjrs4muqMEIdRXfS8uA5pGNdSVnrCXHdmIwhhns?=
 =?us-ascii?Q?87peVYMN97r9jGulTDlV5H00jZ4xyl1YeAFm+bseBAeRoETHEIhuMAR/5q0W?=
 =?us-ascii?Q?OMRUb2lOwJp35ADPrM5ymkcZG3GLI4ywAhI/kdaqQm3UnTO3ZAZ3CW5AR3z9?=
 =?us-ascii?Q?9gsnkw0mjUxJb7KoCHWmojXkQ0ZpDoHn5iX6fUcLEY4LZzS8YsHkMGzggx5U?=
 =?us-ascii?Q?L8gcEsVFO31PQX7cvvExDg7gTT6a2+2hLwLGmovIyd8tVaDd2cIud4y63wXH?=
 =?us-ascii?Q?0rVwx0jhcmpahmRuyJuWu2d5jTNvqOdU5Co5aCqleH6sLOck/OGEO0VrbCe/?=
 =?us-ascii?Q?ij4bgvECL1vcvXnICtsBiQ4D/XKXNtrKACawwSMg9/Yi9aB7LWhmKQfvoNFF?=
 =?us-ascii?Q?UINPgcWnQ/T8y0GCxomCOalI/1ULzaDVDQbEuPFwII/N2mAt/2M3BnNf41yA?=
 =?us-ascii?Q?rkl10NqwFElVdNSjbz8QodW3N33aAneW1n8WGGEN4+NgDgJJ6oo+etLX9UUq?=
 =?us-ascii?Q?tWf6Gl1HsI20KcIHFepzRmlMg8S/8Gbb+04YLlKXqI+g7lHkClmfaxp2AEMp?=
 =?us-ascii?Q?N9nOjwOjpSMzbunJadhnCKPcj5Rq5C/IVd6MAjxex49nxoNdq/0tryoEXIYZ?=
 =?us-ascii?Q?ZtPV4zxDpLZeYAPnFGg+yqv69LYjOlYVFSKIwHA7Qini13WTXIYKfQUrMGIc?=
 =?us-ascii?Q?b2TDmhb7GjYLZ9MtefHd35A0NaSAfi1jNgYWnRWEl19dtVR5nMdVOwSUlhre?=
 =?us-ascii?Q?E9XWobBszOi+8TfSoEFqOoZLOmyv8/hC+uGsrsDc6CwP9NWSnBi09UlIFK72?=
 =?us-ascii?Q?5RU4lFZaLwrzf4Mz/qpuVaKRuhhnOsLGCq7utF+EVL8NoxrW37SOR2DcMgKo?=
 =?us-ascii?Q?wPi+x+ELZUMiwikflftWbckJQpbJvAcgmXOaihFjDVeD5UyMaC/9PfqjOUzi?=
 =?us-ascii?Q?qlLYvgIDq/Pu+mQD3to1gU7H5ppyyYg2DS+PToLsxXybXWh6f8EK57P16CFJ?=
 =?us-ascii?Q?ZM/awnNzW0d8hvOM5vg6sdtmXH9xkkk8Q1u48NxAPno1xv/1BYhPVua/o2DG?=
 =?us-ascii?Q?6WEFFneH6tBe8KEc2+Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9b5ac1-e02b-4674-fb1f-08dd68afb80b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 19:36:47.2286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TvAncXZwjuie8qAViSfTTpx+DIwZX/m0Glx1kCuxCDfpXpRICydGamGj86SmhiOCZVR/vnzfOsPftyOkJVQNFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785
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

[Public]

Do we want to actually do a fence_wait_polling before the loop begins like =
in all of the other functions? I know 5ms isn't a big deal, but the other o=
nes we have are all after a single fence_wait_polling first.

 Kent


> -----Original Message-----
> From: Cornwall, Jay <Jay.Cornwall@amd.com>
> Sent: Friday, March 21, 2025 2:27 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Russell, Kent
> <Kent.Russell@amd.com>
> Subject: [PATCH] drm/amdgpu: Increase KIQ invalidate_tlbs timeout
>
> KIQ invalidate_tlbs request has been seen to marginally exceed the
> configured 100 ms timeout on systems under load.
>
> All other KIQ requests in the driver use a 10 second timeout. Use a
> similar timeout implementation on the invalidate_tlbs path.
>
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 +++++++++++----
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index f68a348dcec9..54bf8780f0b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -355,7 +355,6 @@ enum amdgpu_kiq_irq {
>       AMDGPU_CP_KIQ_IRQ_DRIVER0 =3D 0,
>       AMDGPU_CP_KIQ_IRQ_LAST
>  };
> -#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
>  #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
>  #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
>  #define MAX_KIQ_REG_TRY 1000
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 464625282872..047437f625c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -699,12 +699,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
> amdgpu_device *adev, uint16_t pasid,
>                                  uint32_t flush_type, bool all_hub,
>                                  uint32_t inst)
>  {
> -     u32 usec_timeout =3D amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :
> -             adev->usec_timeout;
>       struct amdgpu_ring *ring =3D &adev->gfx.kiq[inst].ring;
>       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[inst];
>       unsigned int ndw;
> -     int r;
> +     int r, cnt =3D 0;
>       uint32_t seq;
>
>       /*
> @@ -761,7 +759,16 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
> amdgpu_device *adev, uint16_t pasid,
>
>               amdgpu_ring_commit(ring);
>               spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -             if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1)=
 {
> +
> +             might_sleep();
> +             while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
> +                    !amdgpu_reset_pending(adev->reset_domain)) {
> +
> +                     msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> +                     r =3D amdgpu_fence_wait_polling(ring, seq,
> MAX_KIQ_REG_WAIT);
> +             }
> +
> +             if (cnt > MAX_KIQ_REG_TRY) {
>                       dev_err(adev->dev, "timeout waiting for kiq fence\n=
");
>                       r =3D -ETIME;
>               }
> --
> 2.34.1

