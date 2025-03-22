Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAEEC35FFC
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 17:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F26E010E133;
	Sat, 22 Mar 2025 17:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uSpPKoyR";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95D7410E133
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 17:34:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpZcmxHu5nyNz2h14jkdGbaMZLDN4QkRxS7YUaaLXeVBFEXg1yTVmtTyU+DXUGmaGa7jwFdq59mx3F8s52tVFGuMF58N8y7Dqkwc1bQnIxSXvNf0ynYDaKUWWheP1bP716nW4jjdXP0H//4xtHrx3yuP+i7Ay5O3QQ8/w3gTwal0ODP4ZF5qDJ+O2jtPP9hSyzCdYrqzKzfUryhoSLlKHZAIn8SEY87dfUz4VwE6dNMNfRCeNgY3762eCzCoJAyCeri8Ess2GqCQO2ah5rWG2R2OqjpvzSbM8OPTpyAzipSomG6PA1xMMXybgFYaJKlMINM1vVBP2/zaD02ESn6Dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyapoQSk8JSJHCLrUwme1Ac5QJWWD1+8bpVFAWKhPGQ=;
 b=NmLUohhNYjIah11IcOQy+5Md+NUwqQijWJup7VvQ+hHuipWPXgOMftnG2aLWxnS/rVsUQBIpAnDOFNV+n6fmxJMRrm3CXfVsG8G8bMNvAYr/mNeAtaBTTHJwpeN4L/5NYpw708YMTTXg9lk4MQWlC+p8U6vrVxiekafpye7PJtVk9yUFOjaYL4VMlplVOisYAhSGti9V+GaJiRvu1MdLeD2qbmzOLJ7p61AeoMHtc5nR+dLWYZ3U8KooHVAElJyji4u2FgREnQ0w1Q2n8hwPpZXYAPsA4vV8aZzfHh1K8uU7B9kB9jww9/X6wCdYZIbWL12Y/E5mAJkyxnGqr2f1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyapoQSk8JSJHCLrUwme1Ac5QJWWD1+8bpVFAWKhPGQ=;
 b=uSpPKoyRcVVovMbBn9zJczTx62/D9olyaWUzLU/0zNmIUxf8UA5Izp11btnr3SRaED0FwIvc+cfRrg1nBhszIerahOWsaqb9F9kRr+KhTDXqojSdzBzMb6GAOdKuhxtVwYJz1JB5JLugYsclC2ck0dHCazWu6KJrD8rWmFpQ81g=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Sat, 22 Mar
 2025 17:33:43 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%4]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 17:33:43 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Increase KIQ invalidate_tlbs timeout
Thread-Topic: [PATCH v2] drm/amdgpu: Increase KIQ invalidate_tlbs timeout
Thread-Index: AQHbmzQulJ2wkx9GHkWUIs9BADYMjrN/aqFA
Date: Sat, 22 Mar 2025 17:33:43 +0000
Message-ID: <BL1PR12MB5898FF49FE21FD437BF8D76F85DA2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20250322141007.13380-1-jay.cornwall@amd.com>
In-Reply-To: <20250322141007.13380-1-jay.cornwall@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=f2f8f434-aabc-4fc0-b944-2d5909552422;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-22T17:33:32Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|PH0PR12MB8049:EE_
x-ms-office365-filtering-correlation-id: d87b0587-1b9b-4212-d036-08dd6967b140
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OxKt1oc2OuFvGoQ4gZEEqjVkaYXP0D2zbzoVQOr5Cea9Hdth7gEcwP0+Nu8S?=
 =?us-ascii?Q?YIuUxUH2anoc5hx3K55WAAI6NMfSyfX14FTItnaIGClaiYfG8Y3MPse2nn3H?=
 =?us-ascii?Q?4Dc8YnmLfxSttibrZr+IafMqC0eNUldB92avO6epVKO4p8n8oCFcd3UcNtUr?=
 =?us-ascii?Q?1kHSwUgNPLn3wZXVDVLs2oPnQkWaJWiX8aqxcvoDsscDSjQRhtpT+UtF03/B?=
 =?us-ascii?Q?A4wg3XLpM0fx1gaCTcA8qnW6cuOX39ZTLQSJbjSzSH9GrbDS6UblzlGYMm1r?=
 =?us-ascii?Q?IhA6b9wOIQmxtYktYNjD/YbEl6HCYlz62zWJK5wiM8BEUBL8xVskqR2ERFx8?=
 =?us-ascii?Q?fwjIxjwV9eyq1BfBS3hhjnxS7xkuAjLBEejfR7mHHqNLCheeNqdTOwehz8dE?=
 =?us-ascii?Q?5opuCcY5GoLc26WKEmPms9YI2bP0YJtc+HKGLJ5ZmasOLgvlRzFZxLHRkT+z?=
 =?us-ascii?Q?6G668+Kk+UtNIVncdGRQU/xocrS8g5MNTEnl/KZW1lraUmWPAJIhjHaa0TZD?=
 =?us-ascii?Q?i7YUNvwHLc6BiqI8v6x0Ke8KZfaKFkPhf0TZm3cbLXcunzySxa/VFV6f7vAc?=
 =?us-ascii?Q?YaTjx3HmgH2Xuv+P0ikOBtcyvEKpAsNPXEgzxHe7ZbmBzurikO0KZ+hFs6ne?=
 =?us-ascii?Q?7PPFPOG+0fDDPedFD0M5ChLEMmK4DyEwlnGhNizPuD1vI9mE7//3lITZ8U7w?=
 =?us-ascii?Q?hLjzKB6nDOYSJb3LMJtKZ59GG1FxUbKqDJJFDcx1LNhW3e8LoauJU4iZXHOe?=
 =?us-ascii?Q?mjxIocmKFMJDKa34pCdP0Oa3NBtcgDEV6n9vj6CqQMG6VYQwpbP3vP2ItSqw?=
 =?us-ascii?Q?lC6JNNQjb5CtWEyPWquRVj7zm8n7V6N7ebcu55vZ1Y1zCb9f9R3qn95PRoEt?=
 =?us-ascii?Q?+v/RgPJTCdKmi/G6qE5tSILBFjSCizh6jj4ZnoNu1GFNqR4WOrbiJrHI43Y2?=
 =?us-ascii?Q?anUacZ7Hxzqj2JCdznY79mUzxuUo3rokCGVe5uUUMVQrosxABgBxQlM3mvkU?=
 =?us-ascii?Q?c7GQAt8TSmBOGk9NTaDNF0W632Bcb+NMx6TTs8eu0r0pBWAxltMHWpSUBogc?=
 =?us-ascii?Q?q2HPSQHmZ/RsBqEyCMifw8vG5O9qt8AB7qBuH+/ZlDPxACcAYgiO0S7SVts3?=
 =?us-ascii?Q?0yTcBuvI979+lEH0AbsPwdbQNb+oa3MVWVK16v04416HEJkB7T5FgmJpdDrw?=
 =?us-ascii?Q?r9UkNtQhfbRviAoKuibXruB0K5OsVDh4dyGg0wHSq7juDRH5oVoi7xM/oLTc?=
 =?us-ascii?Q?PWws020Qoy4+T4ACkwxbCDpeCta62MVBG1fP+Pzfj4e0PiS4gqbOIIofT2ND?=
 =?us-ascii?Q?ttyX/HDc4i86ERFnjXyShV+ARfDlqXXKliY6Jgu7f88Osq/B1JHugWFHLZr/?=
 =?us-ascii?Q?FYupke01SfBbYFGXzwVxks1CvbBI2AuBAWPW0B6/OxiK0pM72PuZGDPWQulw?=
 =?us-ascii?Q?pakhOv8cBkKsvLc/N7tbDq8hmrJbkAuT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qlBVnAQNbXXxXqCL3n/FXKTo3MZIoJM+Ru214KIFcIqjxryFLbV4HYvjK1LJ?=
 =?us-ascii?Q?JBll9tI24roEIqrPLQMOGiUIfOEE8rRMpriwzWB3cEfmBXdAYNVvZ/xMksTH?=
 =?us-ascii?Q?Hlq4RHyqb9gXTKe5QGIIQAsEeYWhjk+ac85qtMejh0lD3OsGkHfCCTZmTjj1?=
 =?us-ascii?Q?U6j8+e8XJ83L7l2o+xU/P45LrpdbrylyyN/Wa3Rz0ACl/4gnBaBnJhG1tWUm?=
 =?us-ascii?Q?C9epvoxZDGteVL4m/3YyPIUjXkZHpztckWBwV0xzPjn5Q/bRaTynr7te6lCq?=
 =?us-ascii?Q?KFhCLAx03I0/fwSg4hGcGhn+xqy3GmPRC+09on3ks+G28X3GMiTqZotzS23q?=
 =?us-ascii?Q?nKw44S9tF2QBeiVx4IHlbBo8+XcR/buxzdkQDKYsv84073iaXtdGwqw16oOU?=
 =?us-ascii?Q?JiOJIaZmvEaIU09LRqGnQZzDCuLBc/UesMiW/3wuydk6hiOEJkXAiiyJOnQS?=
 =?us-ascii?Q?bUbab9rSGJVyfbl8fK6aWQpv5du3Pnmd7aI43y88j1gLXwQd2wzjtbR9y65x?=
 =?us-ascii?Q?Frg2wmYMVH40R5jxCiWzKHuMziuuzNkRLhyj0xkXtph1fJ2Ww1QmDEeULcsQ?=
 =?us-ascii?Q?AgxMh40OUNEpyprqNDb8+riG0GvLuvnUgFfjZbS3KEPcH1nj9GT6b1oSMhJw?=
 =?us-ascii?Q?R8JByrABivm3LoftvOGqlA66kFoI7+pBiI6ENarIHNd777hsPEGCeJLo2c5t?=
 =?us-ascii?Q?kmYTLeBhvsZlo998WMHFAzSs5QCZZezOoOe+Uu+iHRHsW9ZLSzhUTAfcXMvm?=
 =?us-ascii?Q?PVPzSebpfCDL3AY3i7FfGuS8X3HKz4rgzH+PPKcrhbgAU9LxA8AVkRcTgDDa?=
 =?us-ascii?Q?4Utxa2rae1z/3BfpXxTmuwn7TAbg0rWraXaNWbiTql2emAGbLaCnmPkb1deJ?=
 =?us-ascii?Q?XPw32F9pJTdO8ahrpRGVotNi90KSGTm83TGdgQy28tfae2MP0dpJhqhcRD9B?=
 =?us-ascii?Q?hx50Rf3sEpcHJL9TOgvvT48Ktx/Jc5Lqu2xr5QHgEjDf1FXcX2BwAGZ1a//H?=
 =?us-ascii?Q?g32TVYnLb1qZawMT4RtpbLKD0MxC7deM51HjWwDlbax/4wjZPSGVQ3OIZ0kz?=
 =?us-ascii?Q?2Y3t0dRSNtk4HKo/pvT1BuUpASGOZE2MC3N0yWzK3IkykayYlTvSJwUdwgFD?=
 =?us-ascii?Q?h9I2KTyHVMj+Z+pq+fY2CjLY5Wq47aLvpNZZptPNEFNXOr+ZWSEbeoB00864?=
 =?us-ascii?Q?2un39EJ5ltINv5PS2BJ9KpcpFzQIJkN+3S+tWPagNpYv5RUf1p5ef2VZyY6W?=
 =?us-ascii?Q?PvV3fGf0Wa6gJqjvB9hhkcN4BAaS9XJ/08p3vwzggqih/Cweq9pswEW0ioqn?=
 =?us-ascii?Q?RoJb0u9pU1xvSPVdS8PkoHKK6UsnwfkR+a4LRHqj0FKdAOE3LQ2vXDjTCl+z?=
 =?us-ascii?Q?8c0qAeIy/my+7dX/yvUFMocNyZNS/mVuqRoxtMLb6WKZ0OcLxRvNh4UFKjjr?=
 =?us-ascii?Q?Wap/yHuHTtDGq+ZSRQaF9mrgdRRvobco0OKToLIe2or2VWCn48F1NZpDwnHF?=
 =?us-ascii?Q?w4J1iWScibequxvzF/j5766vdrzCzVfU8OpYEA02D5ghMy7MWykM6b6Yrfk7?=
 =?us-ascii?Q?rk82j4XwZfD/Mqm+PGQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87b0587-1b9b-4212-d036-08dd6967b140
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2025 17:33:43.2787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Ae2zT5Apc8QztpHu1sYyLnJ7taRYiQLoDzdQiZO/GlE5DBF03qCH6u5qRj7Oyr8zkWRR/0pQ69647OdzFQz9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049
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

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: Cornwall, Jay <Jay.Cornwall@amd.com>
> Sent: Saturday, March 22, 2025 10:10 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Russell, Kent
> <Kent.Russell@amd.com>
> Subject: [PATCH v2] drm/amdgpu: Increase KIQ invalidate_tlbs timeout
>
> KIQ invalidate_tlbs request has been seen to marginally exceed the
> configured 100 ms timeout on systems under load.
>
> All other KIQ requests in the driver use a 10 second timeout. Use a
> similar timeout implementation on the invalidate_tlbs path.
>
> v2: Poll once before msleep
>
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 16 ++++++++++++----
>  2 files changed, 12 insertions(+), 5 deletions(-)
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
> index 464625282872..c46e36a0cd9c 100644
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
> @@ -761,7 +759,17 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
> amdgpu_device *adev, uint16_t pasid,
>
>               amdgpu_ring_commit(ring);
>               spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -             if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1)=
 {
> +
> +             r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT=
);
> +
> +             might_sleep();
> +             while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
> +                    !amdgpu_reset_pending(adev->reset_domain)) {
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

