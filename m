Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25028C77B6F
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 16:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82C110E5A8;
	Tue, 11 Apr 2023 16:46:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD6A610E5A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 16:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W35IZ3ZMENSdqdKDWDAs77xwg5rTsql9o2cPSfnuphREUoT8Cf56i2Hon4/LrxiVL1p2m3nG8aMYROBkZdDMb6yrbocHn3pTuxgW7w2+lZKTRMrIG5g8TV3Rpk1ya0PAhjz3F7JXyRPQ2mjhrgEQlbSkKeaNMy0aLy3yq02Yby4Czztte9xX/A61ascz+fagSnlW1d02uSicPQPTUZehYdfgaoWm1DBVPTMNN4SPYowqLyQveJei1JEujqbM5ER4/zOEBjBiHfWtDWKfprCeLIPdncYvCkJ/LwsTYt+H01Dz09lO7gbGrlnKYI8AXMJpuUJ0Ob0EmXSV38x1sYZo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5XjAK6O5HJdb8leI02pGD5AMCwGQ/SBGnCBJPnPWcw=;
 b=KE2RRtsKwMAOe3N2YvRXlqlJ1KWscAXTJbHdS9GDNEjlOhJve95gVKz2WMN+4RsD7bKcY8aBnJGh29kpQtypTHAZ8Xa63LHgQEucyrxNkqzHpHVS8DUldf4oSrRtnjRVSqQ57GgLzZVbwLqSHNLGxhgCbMiyIRfs+U46r9YudZzlwmvYesJKFmBiJL1Gne7u8Wo0QrgCbAKYGDLPZTUNCf/7mBAHv/i9pa5KgaTZGC4pwt9HoI40eudBGCg32Xs3gSVUiZFHaPCD0RDnbHjjiTa7MXw3IlybhefD1fso8IwBnzbJ9k8QEmcosowt7nIoBQ6bNP/Foxx9NhTCAcSCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5XjAK6O5HJdb8leI02pGD5AMCwGQ/SBGnCBJPnPWcw=;
 b=TdXzs9neNZAihr382uEpblx5qT94dnRj62gZCOM3LlX09cMNCTX6Ker3VqtFxoidHzC0vO5J0h19dIOOHsZdh1dT4QE150F+mJdjXv6UcVgBCT4yYdzKvLnLr7Epw1SnLdGdkIhF9bLDo8TkViwOUVj45mp1Gu271nMXFWZfCkI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CO6PR12MB5425.namprd12.prod.outlook.com (2603:10b6:303:13e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Tue, 11 Apr
 2023 16:46:19 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::34de:5470:103b:594b]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::34de:5470:103b:594b%6]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:46:19 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: use sdma_v6 single packet invalidation
Thread-Topic: [PATCH] drm/amdgpu: use sdma_v6 single packet invalidation
Thread-Index: AQHZbEW7bJXMEkSjAUy+eKz8cE+Nla8mUaXg
Date: Tue, 11 Apr 2023 16:46:19 +0000
Message-ID: <BL1PR12MB514463EF51FDBC4E10DBE159F79A9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230411071638.279795-1-YuBiao.Wang@amd.com>
In-Reply-To: <20230411071638.279795-1-YuBiao.Wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-11T16:46:17Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3b440d21-03f8-4d10-8d68-d5924e73bc19;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-11T16:46:17Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 5e9e8301-7733-481e-9ad0-d937770ee75d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CO6PR12MB5425:EE_
x-ms-office365-filtering-correlation-id: dfe87143-9b0f-47a1-a567-08db3aac4641
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qzNkwrjOn86cVerYoNlqfg7pFjfGUJp+aZuVJY2LkSH1W6WMOI9QybIx7JGu9sVkv9dwjiA8VXSwBQzdH7wFZTkWgK0qBqR7IWRk26FGCwLSJZoUzi9reiwqeCchsI6+eP6gfQYYdGzeBKz7qlPdxUfa6Uh6BvYTAHLeis7vXOTkoDqe7LPR6puBcmrTaPl0fiRaBg7H+BOir1NhHdE1tN4qbk/UkQ0ksj2Dj5gOH0HKEwT1TtfvbGfNg50skt+SpRr5tuMmnvfV/xuJOJXX6G4sbMEPgocfBJGcJx9N1/kZ4UkxZ8Eh9DDwt5i1WoQpd+Xo9bNLinZE43n+e10GBqq6RjjRqC7gUSmZ8EcvRqQgtrVevF05bdUUglqMiVpWyScCv7ui8uIo+/xIp6iCNdNm1Pk4bqTeW4YkDG8SfgRTcmzgYMA9rfhrGzCwWjuvepfnBdAxp+Ee6KT8olgynWJ4FufqrKfsgmDF247IU8NyAcaRwK7an1pxFMnJgWwkLh8ym1QcxIh7jpzEnBvHFhle02m0Vvn7/emrOCqCsl3+PWDggcM34vQpP9CRlqr1mYtdj9ufWZqXxjj7I5mX++1+SadevrnNHTq2Mq6HeXAEXKSgrJ5CW73PWZ7zwwee
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199021)(66446008)(54906003)(86362001)(83380400001)(186003)(38070700005)(478600001)(66946007)(76116006)(64756008)(8676002)(4326008)(66476007)(2906002)(66556008)(53546011)(9686003)(26005)(6506007)(5660300002)(122000001)(55016003)(41300700001)(316002)(110136005)(33656002)(7696005)(8936002)(71200400001)(52536014)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/+AU2IBpaR1iGkY+T6h4pN7+fwspMeUTCJrJ6hn5udU5UVNW3GRKB/Rg1TJ+?=
 =?us-ascii?Q?uRwkrZfzZRhLmj83FlaFh3y0A0Ta28tCki4DheTAnxCtmZChxjNPm8n0aq9m?=
 =?us-ascii?Q?wz2NYQP74/rJYJ8A3jxiTmO0zm/9r7EII7i7k5UneEEX6wDWBXINGudOFLzI?=
 =?us-ascii?Q?3mWUAx7Ax0yMbjx8fEEAIcFEraAKfkPU/jMxQL9bimGjXvngX5ESRQOX1T64?=
 =?us-ascii?Q?kW5e99ijBo/hPV015EGo/wRhCAqR4sb5aUQblYjGjcJiiIn+be/5yMt9Jd9j?=
 =?us-ascii?Q?7+RD2LJmzV4oGI2rZHIB0KFZ//HpZ73FfnqMOmleRTfExPL7uPq8HIhsKeQD?=
 =?us-ascii?Q?hXkI7axQaZdXV+sj8E2t1RDi2xhMxYcxY0nWdJkI9DcGHmrrRmircSWNpgqT?=
 =?us-ascii?Q?PIR1VQp8O1flKIxnwg3Wgi6QRRXE81bzVeRelcUJDUNQgIx4lQqH4YjeASfB?=
 =?us-ascii?Q?jNg4R6zNKO0T3XSVO3w6Rcj/4hvQdvcvmrwM9oM4wxLCdgiU5MHaR0STtX86?=
 =?us-ascii?Q?5Vaey4LLXVWf9e+3sNMdhNQB6o0ihDk0znIIU6iABsbloxU71jchf7zHhAu8?=
 =?us-ascii?Q?iE7DT2+OSWfyxACnU1gKvzyKXGFOzEBP8sv7Qyy3KafUwOYZlR1BHO45u3wG?=
 =?us-ascii?Q?+f/6G5F5Td0TVSkdaa4/U+JjXqq+MucktFvR1AFWHX4xZf+mpdUnlmgr/8kn?=
 =?us-ascii?Q?YvSaNrjwv58ZPVAdE6LfKR6xS1k3CL8wQes8ui5ANdfY7eqjHyjA3YF0gvMZ?=
 =?us-ascii?Q?GkxMpI8nNlw+NQ7s3Bh2jhQJRWp1MwwRFeQfc/AG3DmNVFqQKHqS/ZtLYoBC?=
 =?us-ascii?Q?IGfG/mF/2GCzIoEg7MakLBMX0+j9MO6DY/JyBxZvry068avUbA8rY/ntSqbK?=
 =?us-ascii?Q?aBNWLID3hYoQhH7vKnuJIw14lsPnS7uU+9Zuc48nVvxrsbvcLZx29iaYayzs?=
 =?us-ascii?Q?nC6n0JnQ9l6jQ9G4URD0ug/xk+xkquEuG7acWBKtwoMgCrQaw8TdC3fg5gSD?=
 =?us-ascii?Q?vE5cnu9nfw+peoaa+WcWVRYid9pINgYB65pJJx9qxoWsnbOyfkJuxxA3uLYg?=
 =?us-ascii?Q?52onmLK30a0Ibywvv/UiCevHY9NFXZ9ktUgJPzZMD0od2jy8I76cF423H9fw?=
 =?us-ascii?Q?NXMx6J1QFYxSjEjdMxymd6nsZeHyTfY5BuHdc/AGCfbKH8qkDKnlxJ+mI5Vp?=
 =?us-ascii?Q?ZOUbtBF5RhVDNg4XoUi4BevFHCa3RqVTloIv1Xpx+Tx/N7ndhei/I5Q9/d2/?=
 =?us-ascii?Q?OtYuaS4KhDwZQ0Wa3N+m1GBGWaRs/+ZVImBvTwPRdIflcGM3A/9I+npGu/mQ?=
 =?us-ascii?Q?HYFkR3LxwZwMFvC/RVeLcXOsi4RajfA5d2RTCaZ6K3N9WAaSjdXz7ydhrnSU?=
 =?us-ascii?Q?2kesuW1/MCWUungZ/dcPa4WazPc0p4zmsifkGb3wCDsbvYe3Mcc544tP9wF8?=
 =?us-ascii?Q?LWt0H2ALoT1tQyOj6ZEjhUVjFsMJ3QwnuXl2RoGEc5Wt4fPGuKGrJ27KWLrx?=
 =?us-ascii?Q?81+qKg/s5KyicWlGR8g3Am3zpaSqNctQWbUqyq5oIFRrMRkYu7yV3jrXMmWO?=
 =?us-ascii?Q?qicNgfwcHA8oQ1sPAWc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe87143-9b0f-47a1-a567-08db3aac4641
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 16:46:19.0526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0DQ2jSx3synWAjlFScPi6fxUV0vpteXjyfUcSUTyRhHQvcqmB6oygtkO8j0PMgzRTyk3EQUjXi5F1OeBA6PxPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5425
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
Cc: "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Wang, 
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, 
 Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: YuBiao Wang <YuBiao.Wang@amd.com>
> Sent: Tuesday, April 11, 2023 3:17 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace
> <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>;
> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei
> <Feifei.Xu@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
> Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>
> Subject: [PATCH] drm/amdgpu: use sdma_v6 single packet invalidation
>=20
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>=20
> Send this patch on behalf of Pierre-Eric.
>=20
> This achieves the same result as the sequence used in emit_flush_gpu_tlb
> but the invalidation is now a single packet instead of the 3 packets requ=
ired
> to implement reg_write_reg_wait.
>=20
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-
> prayer@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 23
> ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 3d36329be384..8d0c8f2cac06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1175,7 +1175,28 @@ static void
> sdma_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)  static void
> sdma_v6_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
>  					 unsigned vmid, uint64_t pd_addr)
>  {
> -	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
> +	struct amdgpu_vmhub *hub =3D &ring->adev->vmhub[ring->funcs-
> >vmhub];
> +	uint32_t req =3D hub->vmhub_funcs->get_invalidate_req(vmid, 0);
> +
> +	/* Update the PD address for this VMID. */
> +	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
> +			      (hub->ctx_addr_distance * vmid),
> +			      lower_32_bits(pd_addr));
> +	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
> +			      (hub->ctx_addr_distance * vmid),
> +			      upper_32_bits(pd_addr));
> +
> +	/* Trigger invalidation. */
> +	amdgpu_ring_write(ring,
> +
> SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_POLL_REGMEM) |
> +
> SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INV
> ALIDATION) |
> +
> SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(ring->vm_inv_eng)
> |
> +
> SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(0x1f));
> +	amdgpu_ring_write(ring, req);
> +	amdgpu_ring_write(ring, 0xFFFFFFFF);
> +	amdgpu_ring_write(ring,
> +
> SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(1 <<
> vmid) |
> +
> SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(0x1
> F));
>  }
>=20
>  static void sdma_v6_0_ring_emit_wreg(struct amdgpu_ring *ring,
> --
> 2.40.0
