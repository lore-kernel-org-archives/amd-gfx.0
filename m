Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4CBC79FB6
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 02:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A9B10E578;
	Thu, 10 Sep 2026 02:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JDqzfvGU";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E8BC10E578
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 02:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijKjJG3N377Q/KYzsD+J49KZLFhf3qAT7VlpAYdx86CvHkRmbfz4mvpK5QklRTRyVO7U24EG6EyeyTYTQ5aJt+gqmggjLHbwei/ltOgYXbCPLEq8oTmjO7FsR47Fj+SxypAEzjsjdv8rWgwsbxGjEV6W6zBJD3Aa5xO9cgMYu2VCGhXQiyxXSkKCa60WOCdKoYLAPoQCZOa9fYw6aRO5GedepUz/jc+tQOD60xZRwAI4RINqjvxmnuaDoH8RRVVMf8G4ZUx3EGyMeg01kc5QZE0LE1Bq5bpzmHs6soXrxVi/pVgK5fVGkTK9M+cM3jOUN4tJ63a6UobXSFR6Kw8bPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1P+HdRl8o3YZAWDaczutrAEyVla18EntHISYyIg4c4=;
 b=tkCmq3btILM//2qf7HBR2Z1XPqlw0LaGV7wS8so44lNcAS1t+MSvoa3NHpyKbak9e2MqU77pXT13tbh2c4sHsBJRDzttY9rpFQBGAVTLBj5cv3q9yC/HrPjEqAwPDhYunzxb6uH9GJj8zy6KgtS2EIn0e6NAQUdacz0Adsc+pj8BBBHGHIuSAp2reqAep6F5czbdTEgq7L3TVAqC0ad6qfuyJnM2MlfP3lLJSsDuCueQ3TuPXPBhXSvakcWcDJHjqemLNJSvwl1fpX1iVzckPLTnBSWY07Cm4AN5pd6QINMUtQvnasFNxV0p7cr+6p2JMeG8tfLI9zqfv15GSkU3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1P+HdRl8o3YZAWDaczutrAEyVla18EntHISYyIg4c4=;
 b=JDqzfvGU7e0Ny0oqWCIn+mlOe8rTbBW56ZYEXA5ISf8VH7iuFJDQYx2ViqLT3/Uu3+mSYfNjmJfMuJ7cN8XusphuMrAiPpvit7e3/6U6uOvkzYUrntHsPG95sLd7IZww2ZrkSAJIFiD0u2Ohi5uVbI1R3Jh5qdsvwh9ytq4omCs=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.14; Thu, 10 Sep 2026 02:12:33 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 02:12:33 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: filter out idle userqs from pending
 signal list
Thread-Topic: [PATCH] drm/amdgpu/userq: filter out idle userqs from pending
 signal list
Thread-Index: AQHdPsf17ak+rga4/kegOAAoyhK8a7bHFR1g
Date: Thu, 10 Sep 2026 02:12:33 +0000
Message-ID: <DS7PR12MB6005898EE36C46A47E01DBA3FBBF2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260907125343.647133-1-Prike.Liang@amd.com>
In-Reply-To: <20260907125343.647133-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-10T02:08:58.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CYYPR12MB8855:EE_
x-ms-office365-filtering-correlation-id: d0a74ff3-969e-43fd-6449-08df0ee0f9c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|11063799006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: cYqdHp3j9QgEySbwGIlBZSHSpZYqHlCGaqFRvdNac0LZl0PENEhFUz0w0utuzcv7E0kk1A40uxA6svv2580+5/npdttl0fdkRo1iGjcfbnRbsIMK6ekxipHkbRdfr+IEoswJt45YmPPgtnIXdHjRu6MO07SrJTQCuCfK/nVZKoBuNdoU+P/i27kvY91upla746MxCVuB7qRZVS4GIiPbi6Va+B83WUvMopNEI58WUfP0csM5bngfTKlsLl2k1gDiOY+9+oE4HWg2HIfi5pBts3kjdhIzni0ldvJHEOweDarJuPF6o8LBKPdn8cEIUtgh/O+VvGlCJlWVAz/rf+IhpCKSBEuUf8KrvFgXJwFUlm5NnMNIknToEsqZhHI43jIoZkNiHfNcslvXoCngS0jnm8NK28FU06eqU7/H442fZ7bdmPqLNXIzCZ+lUkv4bICrugEm+U5qtlyxtc4RQLdq+W8gGp7ZMlgIRcq89IKfj8SAcIB4gryzAOpjv/LmWjoXwmJ6N8MuCOcx6KaUoBZFQhbY/hNT82LLY3hHMZ1+oltpl57HNty0f9ixZ6eZhBAXu+n2GCmSt3P42VgiMXZs6WWxoxkiNhWalP3k7CTHKmJUFoU4XQwwNYX7YXUitFH8f5mcyQ/XLHt/N0nK1N3ttA/BCpvzGGqIRAld7bVBybG3LYEuJB9Hk6c4OGhR4SR1GFWLYYSfQN0Y0+rTWmNCMFs7bOYzxOM3u0ht/D6f508=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eUsmH3BUziPAo0/W70Ti5QmFzKaJt04vL4jnS5eZZi39BK43Ic17XBNM2+iK?=
 =?us-ascii?Q?iayOkUIqjN0sb/LMczGZxzj9mJ7+a+4iEi0cicOLujvSOaFDPUbE9GWj+K/v?=
 =?us-ascii?Q?Kof3mljfpXQBVLNpaZ06vHL3cGM9+y5WgiB6Q643P+fUMQQOainFQJdEvMVH?=
 =?us-ascii?Q?+zjXZswXuuZhEOO9RLxb1LAH7b/5fxS0OzohHCgYQ++MN79IcwHw/wHfNM+B?=
 =?us-ascii?Q?gHGvFy9oPVB9yMeQQXnlsdBkULZn9CzaeBZHeQt/X5PZ392yi1yRBz7VUOwa?=
 =?us-ascii?Q?BrgTvfOGcUq+PJ7vYPUpRl83mk1SgWfdwa7VJIAJb9nT6Hod1bORCZLnC9kD?=
 =?us-ascii?Q?PE4L5jBmkDynncD0BhzzvwxHNk9AzFDyXk7CgMaT+AwSc4ULXSoBm3jFky2J?=
 =?us-ascii?Q?WK27PjK9UTTzvm8d+u0bojSw2RDgYWnakhN9waJAucYqAC2iUA50hLR6JqX+?=
 =?us-ascii?Q?IxFsrm26nOaR41PNI67Fv2EUtlx/wDtfIqUDskj53k0/ybLE17QeuJaOebYO?=
 =?us-ascii?Q?jzUfv3AMdDk6v9TS9morzotULn685LVV71cDpisFjxYPq0bwUdWj2sa7A/gt?=
 =?us-ascii?Q?WghW75Tq5czv8Mm5+A6QB9mqAaqgFQ+A8aaQEZgTyY9GHTZNahd4RDOifje2?=
 =?us-ascii?Q?l2IHfrslXVph6Gc/F6crjz+sHSAtxI2C8+swLFZnkxvwcX3Q8HmFA7AegZyu?=
 =?us-ascii?Q?Br27uKyZf+ehxE79ABq2ITx1A9xi8lB04L9Khn14lEzF4RDCFXuzxeJD9DdW?=
 =?us-ascii?Q?i2a3dBmaWru81nQTd6l7cvjXF7sfiCOecyoC651GmpHi19t4L/fm1qp6rKSY?=
 =?us-ascii?Q?yXBdnFhTU03pDDSJUU+pxZanSrpySbrNQo7ePLc2MdcRodMuF6zmpT05HCPY?=
 =?us-ascii?Q?MlHDHZcBQqKJ9FLMrIyVp6B0mw9Vj+3JoPK1bsbpzI9h4TumMiPZBW87iGmb?=
 =?us-ascii?Q?1SIMRn19Z4rbn4IG0IsN9REQ5uALH6katgdK+PVaLaL4sDSWUKixUTXHu86Q?=
 =?us-ascii?Q?A/vjGu0rvfzYuQmlKcgu1SOlGaIaQonTA64FdZYrHOSGS9LenUQyLmYE+RRw?=
 =?us-ascii?Q?/khVvsild4mAtd2VLA2eAr9HRkWWbM0JnGFajs3pgsCX8uECIAf5FH0jQjCR?=
 =?us-ascii?Q?grt1rm1dEQu0O6e5Ww5Ptj7j2SMqxjJY0UcSwLBc5uZ16Rlep80GEKdf4IEv?=
 =?us-ascii?Q?rvCxJaws6mMJJjFO5iuR/My5PdRtSC+GpPuLpjte5gB0pCqJCYJZsfZ6HYf2?=
 =?us-ascii?Q?QnOhufHxYQbT5i8SnacKJvWkq+kVuTucptjm2EcvecgARGTi5zFAJ7sw16d0?=
 =?us-ascii?Q?3VGErc3eQWerA7v3Ca7g2E5XP60Kn85Zxn/smnlB+PqZxV7Ve7uEP7uE8a7y?=
 =?us-ascii?Q?Uk3EAQikizZF6jnAdQWyruy9WoFReHTdl/Ui3P95a8nVb0XjNRJKgaWhhzWs?=
 =?us-ascii?Q?PTPh87Hup99hbBi5MsrTWefeOMfldOYEgg1/NniQ7zzCcyPBQk6mA3apYyGD?=
 =?us-ascii?Q?T4YmysMK4is+ZIYjTsB5yqfE8uOa3OpzzX24texbFoype4JVuP6wtct7/q3w?=
 =?us-ascii?Q?n78dW9kzRms7nQsYt8kE77WnwuE7Gb3LZ/qIcK9ra1YOqjBm9OTOxE9BiRHY?=
 =?us-ascii?Q?p3K+ZXa7G14jRPR9+gpqNewpDq4CHMP+aepxH9nJ1zLYm+dRIasmi3zOg6mz?=
 =?us-ascii?Q?hXfMBmiiFHZP7El99qojZaxEc/YdDuyZrP6oeRoi/AJa7lbN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a74ff3-969e-43fd-6449-08df0ee0f9c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 02:12:33.5478 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TAEsoKdYJy2QwrNrbf2kNmUeeo2UGUALyrOHoJ+Kl952gN3vcUCLP5+i20N4mOW0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855
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

This will help on identifying the idle userq from the pending signal fences=
 list and cancel the detect hang worker timely. Please help reviewing the p=
atch and move it forward. Thanks!


Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Monday, September 7, 2026 8:54 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu/userq: filter out idle userqs from pending si=
gnal list
>
> As for the empty pending fence list case: after cutting the userq fence d=
river's fence
> list, if no pending signaled userq fences remain, this should be treated =
as an idle
> userq condition and the hang detection worker should be cancelled accordi=
ngly.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index c270635c907b..2f38872dcef6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -162,8 +162,16 @@ amdgpu_userq_fence_driver_process(struct
> amdgpu_userq_fence_driver *fence_drv)
>                               &userq_fence->link);
>       spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>
> -     if (list_empty(&to_be_signaled))
> -             return -ENOENT;
> +     if (list_empty(&to_be_signaled)) {
> +             bool idle;
> +
> +             /* distinguish: was the fence list already empty? */
> +             spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> +             idle =3D list_empty(&fence_drv->fences);
> +             spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
> +             /* 0 =3D truly idle, -ENOENT =3D pending submission*/
> +             return idle ? 0 : -ENOENT;
> +     }
>
>       list_for_each_entry_safe(userq_fence, tmp, &to_be_signaled, link) {
>               fence =3D &userq_fence->base;
> --
> 2.34.1

