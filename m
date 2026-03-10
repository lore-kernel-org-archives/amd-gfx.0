Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7D6FD4F31
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 20:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D574510E2D1;
	Tue, 10 Mar 2026 20:38:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K7FLlbcA";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012047.outbound.protection.outlook.com
 [40.107.200.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F43110E2D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 20:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6e8Qf7Zki2QU+2cA3kcqjgHoDwwHlZNtD0rP8i9iHgvVSdQKU1C98v/a4s2vRF+yfNgpOFSAHzPKud0DlE6dl5zP1s5cabDG83QMF20ymkA5rOhWGiHne/dHo4QiBNL0p35IbPCe6xWFlmNeruOFmIIkTegvPKqr3D9n9vqpMIaoVLfj0ozIyikEngb5khIC8hC3vkoxtxfVMcx2DZx477s8mVSNwp+1r5DCBGfAkXw/1pW8yQ6vyRQG00+j/AJdovdw6R4+0PNpafD6ObGvjwzIaOZd7zk6zm2gHPjgYcbrTUnkKLW7l6gQySYbxJONJir09W9SvrQq8brSQZDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubRa0xElwPQ5rAwDy8PdGZTDKEvCl5WuvDSvkbxVyg0=;
 b=IrUHu+OIrmKAuMd9HkI6Raqxj5vrFY19zv1D+pmwZB2D2ddNikZRWfH6FBwglhydlxUKE3KNlxHLKrrpH2Kc2b/+cEIT6TfR1sqq1t5Ef3dn5zq3XaeYqCjdUXuXrTT5PRO2sS2z8n331FZE4No7GMEnKVgn9xo2rSb3rePJKSNPawe4YjxNKZkU/X3TjTt1AAnKJeyvJCJMHO9zKhjK4CJkTrSaDLHChw6x9RxF9XA9kBYrmH17+fsVdVvTaxaWRRcEv96OvJ0hyOXMcd8nReiZ9YeVqvZaCu6enFkNf5K9oVR1mKckavsG4UmPOuIDt+W/bt98qtomPurRG4IQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubRa0xElwPQ5rAwDy8PdGZTDKEvCl5WuvDSvkbxVyg0=;
 b=K7FLlbcADgjZEj3Ebbe4hSmxVLOGzktDsh+irvRmIpTonF4GuqHBj5WbxONebF+oBNhloqLRk2bn6W7IVf9l3nsTdibv9zFZb8KVXUHVLy7+p+WUkO73RkAY9CsCaNLtrSv7y4kuEf6hWHh02ggg8RDR1BrmM7SC5i3fRNP8G7Q=
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Tue, 10 Mar
 2026 20:38:13 +0000
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67]) by SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 20:38:13 +0000
From: "Xie, Chenglei" <Chenglei.Xie@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Avoid KIQ ring access during GPU reset to
 fix fence timeout
Thread-Topic: [PATCH v2] drm/amdgpu: Avoid KIQ ring access during GPU reset to
 fix fence timeout
Thread-Index: AQHcr+eSouiW8es7QEejVdRZt8DW67WnUbwAgAC4PWA=
Date: Tue, 10 Mar 2026 20:38:13 +0000
Message-ID: <SJ1PR12MB61217E58C7938385842E32478046A@SJ1PR12MB6121.namprd12.prod.outlook.com>
References: <CADnq5_OCRm7oVkr7TY_OCyfSnkPJXAY7ZhjThpEbAauQNz_T_g@mail.gmail.com>
 <20260309170950.1982724-1-Chenglei.Xie@amd.com>
 <36bdc19b-87c3-4ed2-ab60-b1f97cb9c0a7@amd.com>
In-Reply-To: <36bdc19b-87c3-4ed2-ab60-b1f97cb9c0a7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-10T17:39:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6121:EE_|SA0PR12MB4447:EE_
x-ms-office365-filtering-correlation-id: 8f6b691a-0ea3-4c9f-3481-08de7ee4f369
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|13003099007|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: oZkknNdYMmqW1AhiYq1+j7A5t+aTe72tT3rXYBj0SVxO479AM4SiTryUbAq7rnRHfdng2414TYM+qJyvhWqKoMbTVMbzMwDfFrT28Ic5ZyBJ+NAMjJ16OZrxnBOxGtb7wyt7E5T252spb8t7FJBKlx0XirayCcT7itsfr+OFDIwjoPTHLlf3zVYSlWhlK+JqRLHo4Mb4uN72fBHaxk/ZE4PdiXiVZATzSDEq09SZI+DeffPyEVpTPsGqWKKxNSC8b2gGx4xW3R+gf4lqZBjRF5Z0p05KQ9MfBRejiqYMpClQ/eDoq1Rqj/nJcUCJPADusNy4ZFe7863y7yWMQyntajfDpTktiXabEIJtgebVclNanLav4VLNfZpB7nnr1yD6GYG9OK86Sh6bgprV3w6gX9/B5Lhwqi7GdJ4dONI9jREb3Acs7nluozAwMvUDpVhVHiOSLtbqaepuFVn+2nA1CYU2+Y0ZXNrOmO0uFlAk3EU5cPABViQRKc2uVOBAI3pWtjPQ/Ouwe6CUElWZWTlbISNH39fna/QwL7Dcz2dnlMhhU+HdEzxBtFNDqOK4is8LTK9LiIU3K32Ie5tnNxiLD8kZQT8hI4mqXQi+jVWfYQrCazwXCo2QfzkDrr6nrVVOTUNGXg/6KOl6+nTK0nghOasGBcjKPkN896ERR73ShqX5fkzNFLMvu3xgdNrqkd7R3dINSPmNuKEptPO5ZtaEL/7PE+MWmr/7fxz1h/AS9R6rS9RMpLohc9RlfZt4SZn8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(13003099007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r7ViRgVFpdvdsNdqawlX1JqZgY9aVKNTKifPV4nVkDn9qeAnQRLzMxmSPLZd?=
 =?us-ascii?Q?e6xyLNnjvVW65HeMJEt668Bc5NecVIQgtr/gAmk4mVBdwEKIuggVqsDLfO/e?=
 =?us-ascii?Q?zoYsEoz+QENIhQsJfon07oMUD9YXwI9wEWkklXRRCQUhJ8nKVIJo7lt3pv5F?=
 =?us-ascii?Q?SBaZk5rT8yExUHL1pS/k87ZUgLQXilUaVUL2ayF1rhZWqdrsb2JMiG+XMKlf?=
 =?us-ascii?Q?LkZXrWJ2C7cRyWHX6Y6m89gy1Xo0fiU3zwSuH6xboS5MhjDeRVjg/SkU7qqM?=
 =?us-ascii?Q?oJXCR8nhdgRE8ALocwduIcCXPO8vFQwocAHe+zeWpJ3rOJfItzSc0XZ1YL2J?=
 =?us-ascii?Q?zdj8mniA5oV7mXug6hFABnZ5sqn0Att1wCawX6/cmKeMx4Qk/vsrEqEH7kuU?=
 =?us-ascii?Q?UOFyD4jvjZJAIeihFKpAH7wRLK3+MKEGY2WVJb1h1fNZB1LqSOh5U4i063ss?=
 =?us-ascii?Q?U98K/KfbRjsKk6kylpAL72tN+lfsVZh7atCsH2pwEFZH1I4O1h1VYIdi8tHI?=
 =?us-ascii?Q?69TdbwA8fzDKkMrnKuKE+W2sjFKL34Lb5zScNdifaEPVMaLf0Bq12RsLNtDo?=
 =?us-ascii?Q?tJ5LxkQJx/NX+AwMOXQ3frrYKYFJcODBDMfpG2r2umnzalpWwUQLUx1jMojo?=
 =?us-ascii?Q?HFlpOc4BBRlD7GXHCE/0iqkDfIJzaVfV3n59GQwKeskNTWFnV5Mg/UzIjsPZ?=
 =?us-ascii?Q?H+3u2Nj/RKfsCHt7ok5S8Tta7F8/l1g+MwWRR/uVQXUkPlao7ajnMRWeMDVq?=
 =?us-ascii?Q?IWKi0TBjSjDWJ5MsL0K0gjp3YK4+7dui6sQKS00JO06RuNwB36dIbd4b2C3w?=
 =?us-ascii?Q?Paii3tfBptGgrLUx9n5JQYkX+iuqz+nSrV+y3BOm+2jw8uqK1zvNCTvkz0Tv?=
 =?us-ascii?Q?ijz5mPqruResqON/dxjIHqEzyMwMqOcNkB6QmONRFCknviYAX+aA6blNYp7R?=
 =?us-ascii?Q?fsri9Jjnet0O7AgRv73sAYFOzIXYKWpW1xpDMZyYbRxjCNkpCoTQWhUAr1wJ?=
 =?us-ascii?Q?mc6W6eEOePpiuPdXS5hOcw6kJHs37mr8VxwO7Fv6jWbt2d3Q/0HIZSGW2LSY?=
 =?us-ascii?Q?B51u6bpZNWkMpwuZ4hqSyGBlyow+wsMgSMfjw9FOCRMl0dK8aAQyRhXNY9tH?=
 =?us-ascii?Q?RGv4k3cwBJ4JjdQJWkHzOmRvwyUh1UN8OS8CEGyTH7TPdG3HMzdGxukEcyNA?=
 =?us-ascii?Q?82g7TLqQJ6Lr5dA33dlmLVEGaRrp1FqGFjP2t8VePDA8kNcBg6LVw5/i0xgk?=
 =?us-ascii?Q?Svc3uHdMsccPxyzpzg0e2MxhdSCwbPL50Zeh9W2hdMN1W7SwAPtoYQJDdKD1?=
 =?us-ascii?Q?C2WlzklaHaVyuxyKeHGvpdEwyzrWtC3/+0ifCPM/TyLV8f6uHCEIx6eCsXwE?=
 =?us-ascii?Q?zEAUU6hLvpCy+kLisGxBef2GMGOSgRU034vFWFH05Kvm7xtzk7zYKZsKoGrC?=
 =?us-ascii?Q?S3bmPJ6l4t56XhN6rqgitMUDvWmUm0EPJxLq8l5CH1rQ0Q3iIAYFggyTDiZ0?=
 =?us-ascii?Q?oAuPbuwMMKQPxwgWTa86RppT725PO4rpBCBp5SQE5uWUyC4ntwNrfpOSqHm5?=
 =?us-ascii?Q?IyFI9Ciba9WlxKJmyElm+t4AywIzcoArrlDZf13UKhdYVQRae+Q5r/mrkFmH?=
 =?us-ascii?Q?0G8S74xr4/N/CbEBXmFh5tUNd/80BpBvtCB2P4xgaQ09lykFFtrXqTNOKWLL?=
 =?us-ascii?Q?YTBEQPJ4vOTudcf+9slfgEwoIPiVHV9HaL0qvwDwB7edp8LO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6121.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6b691a-0ea3-4c9f-3481-08de7ee4f369
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 20:38:13.4549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xHwLtgKyAWKYJ8FauNK3tGWRyt74n+/5/meargpNQGQ4/3jesuxpm7ojhnk/rUfOa7bYHDZobHhy4IJvMH4fvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
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

>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  3 +++
>   2 files changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index cab3196a87fb1..0021e763b753a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1124,6 +1124,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev=
, uint32_t reg, uint32_t xcc_
>          if (adev->mes.ring[0].sched.ready)
>                  return amdgpu_mes_rreg(adev, reg, xcc_id);
>
> +       if (amdgpu_in_reset(adev))
> +               return ~0;
> +

>Please note that the existing logic assumes that kiq access will work fine=
 even during reset and only could fail under certain reset situations (not =
all) -
>
>https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/a=
mdgpu_gfx.c#L1107
>
>
>Also, there are additional things done after full access is released -
>
>https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/a=
mdgpu_device.c#L5610
>
>May be it needs a force completion at the right place somewhere in
>amdgpu_device_reset_sriov() as Alex suggested and not to simply block all =
KIQ based reg accesses during reset. In baremetal case, it is done during p=
re-reset as we don't expect any more packet submission/indirect register ac=
cesses through kernel rings afterwards.
>
>Thanks,
>Lijo

Chenglei: After the in_gpu_reset flag is set in the KIQ paths, the current =
logic allows a short window of time when HW and KIQ can still run to proces=
s packets before the HW actually start reset. But once the HW reset stared,=
 HW would stop processing and new jobs in the KIQ ring would fail because o=
f that.

If we want to avoid blocking all kiq access during reset, we can have amdgp=
u_fence_driver_force_completion() called in amdgpu_device_reset_sriov() aft=
er -
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/am=
dgpu_device.c#L5586
where the rings are re-inited.

Also, the current logic in amdgpu_device_pre_asic_reset() skips rings witho=
ut gpu scheduler -
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/am=
dgpu_device.c#L5810
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/am=
dgpu_ring.c#L862
So that KIQ rings are skipped and never got force_completion before reset.

Issue should be fixed if we force completion on all possible rings on both =
pre reset(both SRIOV and BM) and post rest(SRIOV only). I will send out new=
 patch based on this.

Thanks,
Chenglei

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, March 10, 2026 2:40 AM
To: Xie, Chenglei <Chenglei.Xie@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>
Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.c=
om>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/amdgpu: Avoid KIQ ring access during GPU reset =
to fix fence timeout



On 09-Mar-26 10:39 PM, Chenglei Xie wrote:
> [Some people who received this message don't often get email from
> chenglei.xie@amd.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>
> After GPU reset, the hardware queue is cleared and all pending fences
> are lost, but the fence writeback memory stays stale. If the driver
> keeps submitting to the KIQ ring during reset (e.g. HDP flush),
> sync_seq advances while writeback does not, so
> amdgpu_fence_emit_polling() waits for lost fences and hits -ETIMEDOUT, bl=
ocking further KIQ use.
>
> Fix this by skipping KIQ ring use when in reset.
>
> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
> Change-Id: I717df52ed0ef0bb51a6901f218191d9837a77f6f
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  3 +++
>   2 files changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index cab3196a87fb1..0021e763b753a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1124,6 +1124,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev=
, uint32_t reg, uint32_t xcc_
>          if (adev->mes.ring[0].sched.ready)
>                  return amdgpu_mes_rreg(adev, reg, xcc_id);
>
> +       if (amdgpu_in_reset(adev))
> +               return ~0;
> +

Please note that the existing logic assumes that kiq access will work fine =
even during reset and only could fail under certain reset situations (not a=
ll) -

https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/am=
dgpu_gfx.c#L1107

Also, there are additional things done after full access is released -

https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/am=
dgpu_device.c#L5610

May be it needs a force completion at the right place somewhere in
amdgpu_device_reset_sriov() as Alex suggested and not to simply block all K=
IQ based reg accesses during reset. In baremetal case, it is done during pr=
e-reset as we don't expect any more packet submission/indirect register acc=
esses through kernel rings afterwards.

Thanks,
Lijo

>          BUG_ON(!ring->funcs->emit_rreg);
>
>          spin_lock_irqsave(&kiq->ring_lock, flags); @@ -1202,6 +1205,9
> @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_=
t v, uint3
>                  return;
>          }
>
> +       if (amdgpu_in_reset(adev))
> +               return;
> +
>          spin_lock_irqsave(&kiq->ring_lock, flags);
>          r =3D amdgpu_ring_alloc(ring, 32);
>          if (r)
> @@ -1298,6 +1304,10 @@ int amdgpu_kiq_hdp_flush(struct amdgpu_device *ade=
v)
>          if (adev->enable_mes_kiq && adev->mes.ring[0].sched.ready)
>                  return amdgpu_mes_hdp_flush(adev);
>
> +       /* Avoid KIQ ring access during reset; caller will use amdgpu_hdp=
_flush fallback */
> +       if (amdgpu_in_reset(adev))
> +               return -EBUSY;
> +
>          if (!ring->funcs->emit_hdp_flush) {
>                  return -EOPNOTSUPP;
>          }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 20e1395b39882..f9db2b17105b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -876,6 +876,9 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_d=
evice *adev,
>                  return;
>          }
>
> +       if (amdgpu_in_reset(adev))
> +               return;
> +
>          spin_lock_irqsave(&kiq->ring_lock, flags);
>          amdgpu_ring_alloc(ring, 32);
>          amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
> --
> 2.34.1
>

