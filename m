Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F457C35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 08:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D683C10E501;
	Tue, 25 Mar 2025 08:13:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w4dG7u+e";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8817010E501
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 08:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZR9yMrA9tDEZQ7aEfDVnTuYuLBW36JgEoFAAtaAFtakc9Q8VmSMCIzhYOVCFznpnwhjolryNSnm7On06hCVUVvWiKkWtmgiRs8u97Z9AMJu2onSInBZvdEkrDGWZZR0X8tUGDDRkXJKkAgRuyxbU4XObKpVnKLo8YR/dTOkRQ4qjqQ1yGbdKAULdNQSTSKdRKRGgkckkf4MBarpPin3+F9DbJOa1ipwmzIE3t4z7NOP/1obKyef8c+sUE4DueycwP+cxcQUYelcp0z59mE9rAw7afrtd5BfTnvOM9Xba+Wgx24McQIoemAp0CE1FXOJUFak7h37Lo2Ko+StJoFxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRu3zlTVvfgO9i0wntPdiWXEzQTayXJ0hXO07tXcskE=;
 b=gBVVehij0agDqgV+6Mvets4PcySr3iUdxjapZvB0aHpr2TARXKMbEGTzY27P+TyUqGblXuXamI6JH6fa+xn6J/sJy0mLFRjTbFbLATnK+BUOo0R6Mdizyz9nRN/DngzxRozQL04s3VfM4AdkD0WSgrRDy1oOaOM7xSGEtnAKAj1Rw9DsFaAa9uk7Ny7izVpQAFL8+ROW0KfglWWDg4xJy/2udfifTxGzgz4hsPEQ4ITZEqD5WjDWR4My90Y2MQFihUvprZ+8nz085V62+RsEPxZjXLUdmmlhj+GgVuA2vCAGidwaPyK1rH9x+6RRsDnRt+YbgsghyFx/1qq6p35v+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRu3zlTVvfgO9i0wntPdiWXEzQTayXJ0hXO07tXcskE=;
 b=w4dG7u+eZN8NgnrNrOmjAuMkaLQtbhIKVy4OLqFgXpS5/qHW71Ge40cTMhWl5dOvB0H0URSkUH+ZjRW0eWOLXaAfPcDpjPwXgr0vlI74gu8yzBx4YjQcrPcpsw3udjc4ngo0SKsbTFcp2YBHrsMXV6aLNrltlsADrqmbsosUy6M=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CH3PR12MB8332.namprd12.prod.outlook.com (2603:10b6:610:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 08:13:45 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 08:13:45 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Paneer
 Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: store userq_managers in a list in adev
Thread-Topic: [PATCH 1/2] drm/amdgpu: store userq_managers in a list in adev
Thread-Index: AQHbmbiZI1uvqd2r10q6Tptwfs9gb7ODhpSw
Date: Tue, 25 Mar 2025 08:13:44 +0000
Message-ID: <DS7PR12MB600558F9AE6AFA491D593C2CFBA72@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250320165249.1238463-1-alexander.deucher@amd.com>
In-Reply-To: <20250320165249.1238463-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=3f275026-7de1-45e2-94de-5289fd68fd26;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-25T08:13:31Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CH3PR12MB8332:EE_
x-ms-office365-filtering-correlation-id: 60f4df2a-36b7-43c3-03a4-08dd6b74f651
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?a1FNpWEBF1fYzZZgTgp+kmYNGxaT/KPJWk9GMoYZiLkIzR5QZA5hhmQSa7gC?=
 =?us-ascii?Q?z4jqnwjp/haPEeUsqP57jhuRAf+HgCna/atGRivuCEqr/VK4pz5a3CX0RSQ0?=
 =?us-ascii?Q?g+QbfcjdXb7vDcTK28N9/aLPU/mglkEORjxWCK+XkEOxfCipwbAj/mk/ldxH?=
 =?us-ascii?Q?lRZwxyje/UIvIY36fjzlgfSybHuGxEoGPoeJHhqseOGN1Rt/eg2nmctGIk33?=
 =?us-ascii?Q?lPjHnD1whQwxV+pnoMtx5O5KVnBLTSElLPslNTQXsv31QB2xhkHlgfoQabEO?=
 =?us-ascii?Q?AqTK3vCbwW+jdQ22/107tclB26RZo8XvdQJ9HAYjWcjZfEFns9mPlgQ8zxRy?=
 =?us-ascii?Q?/etCmgg49KSjdYTwngi1U7pqndRfmUHQ31NgvGNuApP+kJIyl0JInhGnMwG2?=
 =?us-ascii?Q?bf2JXud8wQ/e8H0658ZcvhXAG0f4wqd+3oFZu1WW3nwd/avXAsBR6xkSI7p5?=
 =?us-ascii?Q?0Z9E9clbbaJZSZYqfq9+vv+gf05Dli1Gn3XqedIP68wiWoUafXqJoRGnMgeQ?=
 =?us-ascii?Q?p/P/vhhxZN7URBhF9+E5xOOfy/kT6Z9rUktJqPycdiK0hss0W6TELCJkqnXK?=
 =?us-ascii?Q?XdeEQQEb9+RzAP6Fc5KI9Q9+v9mN1PsSgc4tqevLCIE9rwvZv9FYpfbahS9r?=
 =?us-ascii?Q?fAIogR//xHM58ijbQ0dngJWBfSaNGlSN4/o9ycmbqOYt7VYpgRrH2jksAvYS?=
 =?us-ascii?Q?rQDje6UaZ9PvIjrS/h8q4LUCZGu1ZR/ES6Fk91JRv91MjiQI1HMBMu+lSO/7?=
 =?us-ascii?Q?h2/vW963QKylkx2YqxfYQs1Eqlawb+5xCRKy2C4ZnvEU/+oaFUt5D6ixHobE?=
 =?us-ascii?Q?TuGTr7phCpyVtQWneZQ9e+mTgIrsY0KfoQzI3Uy6s3Kg6OL1oSem5JLIeClx?=
 =?us-ascii?Q?5sWi/DwGO6OoaiPZB6ruxFMQJCfP8xY1sCnrBLj9QqjfvYzWGBhMFEbBpx61?=
 =?us-ascii?Q?YHeoTeGeSEGTjniLbhsFKk3wGBIlAMeP+e+Ka6Kb1ICoyN1gPySNzIr3rtng?=
 =?us-ascii?Q?KZKC5emCBicLxDZVLaDfPvnlbQRHZSwiKhroPxgDcHyVkGdthdXgOJitwgmi?=
 =?us-ascii?Q?0roInOlWLN405V07WhPOsLofLFQ7b4ToHKw73lcVmuIE6TkUBkUoxsbsvdYe?=
 =?us-ascii?Q?+560websKjxi566FcU7DuCpYfJauScj5SA2q7lS0rmZO2OmAXYYQ604znXq3?=
 =?us-ascii?Q?FMZBvCAUxK9qNmrdt8F0JzXCsQVjKqeDaCrv8k1XQdk8fSpCO/tSIYIds4hr?=
 =?us-ascii?Q?Ro0cnYXAPtPxxBFwtSWVAlVO66IjE4s4/6sPtcBqPUI0P2zfJXkHx6zQ60+j?=
 =?us-ascii?Q?ndDD/vlEz6laEtVZdSQd2LoFEjvMX+fXvvLRI5BnC94MebkqnIQQOn6SuPvy?=
 =?us-ascii?Q?ZYWtz3aX+fx8P5qvflLm2Q85iQ5sWg4RVD2q2Ckmb1YVh/p1hkJmavdDs673?=
 =?us-ascii?Q?G8bldywiOB6sVqXBqnHAXd0Gzl1Semrh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cRyNMG+Ju8eQfGddKGqO178+LaZblKw1g3EogiyZMt7mOWHNgeSRck+KWwTO?=
 =?us-ascii?Q?6yr2n7cT85OuttZ6PpmjCzIOFfYQEZ0E5BKCVt6BdYGP9O0pBkiWKZ40poOJ?=
 =?us-ascii?Q?ZYYVReBWO+5JDH2zX/KUCrYXT/I4BASWIy3M6sNzMApyA22keHoEleLxmlcW?=
 =?us-ascii?Q?RF8hO2voX/bli285yZ4lBGjqq/JwTfd8o3giqRsKcscwtHK4pYLNx/7VO4I3?=
 =?us-ascii?Q?7qE6z8F2bzXlo3/eQMgCryDnM0sMIn4Krp+J8RinqRKlio6yGiJrIyNScEjn?=
 =?us-ascii?Q?x1GhjcfTzz1FJQSYen/BiIcQ1vZ/Fw0Ubia5R+4jq9JZtrILVMGlWAp+YQwz?=
 =?us-ascii?Q?ni2i0vr+X3npYO1EUNewLA2B1b768KAEEYDuSg6rIVnOwrsod7allUSfZfRm?=
 =?us-ascii?Q?F3uYqFE5hCE9XzDLvikWAjeiwdKNfQXG2eAcmnPzDRXWmkBDR7ymDCwkOc3O?=
 =?us-ascii?Q?sQdbLQWfaWKqp8YU9CaRKHNbYpYzhZJTd6SvSrXTC9lMMPuphu/ipJCDg7x6?=
 =?us-ascii?Q?KOR6glKvvWIJG1cu/eKZUYSpz+bu3U7sp8/68+W3P83QZNJEbslXrc2O7x28?=
 =?us-ascii?Q?OC3D9cpv5sMTCDXB8e+mS7X6f2hJG3/GQPgqxvKC6k1N9Jpd4PxKyBO8oiHz?=
 =?us-ascii?Q?xa0zfvHQIMVXIV32BW7kBpk03XWZBg+31TslKKLrRdgIXRzmgipvl5WJKmxU?=
 =?us-ascii?Q?2rEhQ7OIC/SyAau7MLNmpltI/Tv35uMB0cg9WFVvph3pmPc1ZfDC5bt2gzQl?=
 =?us-ascii?Q?d0kse9XE/G1EjWbb3E2iVpixJ9cPKsNXjW0cJxvAKqqxIuOjY0YT97SYHx1g?=
 =?us-ascii?Q?SzZ1TufE3C2HzxMgqtSzozZ4qLM053ZwSaF1MfNw/Mx/nB9PzpK42ZxC/UIq?=
 =?us-ascii?Q?PBNaPF9Eh4Rr2I1aPXu5c9zcXzJMt0f3tJ4qJ28hU0gPaf5UPzkWo8Y9uEaJ?=
 =?us-ascii?Q?1aIDM16xt5TcBo7br69cgIjrJstMPqRngPdYr9w5KUTg+bru4xBJS9CYUtpW?=
 =?us-ascii?Q?6G5/80116OPRJjYJjnmPfCfwueTj5CJG97prOPjs6Qj14ei0mqBYgyFP4zmz?=
 =?us-ascii?Q?R1A+pvs2iZmFORcN49HUkgJKvVmwIb33OegcLrf0KsT2iJoxuhnsBu/rKBWJ?=
 =?us-ascii?Q?pPXOY5sHv3H3Vp6Hp/MmTtvrcCzMCNoWGvsnpHyWWMBhZIXHjaRD5bU+xb44?=
 =?us-ascii?Q?BQfVrA9xvZIw8Z9k2iEWLVCDkAtHwIWwutgPQrRPr0lvYXRk6qcH+GZIKjyK?=
 =?us-ascii?Q?pMU+RMgBC6q1BRw2GY9G06py3a3bAdVOXssi70+1NZssJbnqGu/GiL1jM+bb?=
 =?us-ascii?Q?jQcKYThBZ19TChgWMdfng8rWR+iy3nLXgnR413iskYWZOauQSQ0tUSKqfTYe?=
 =?us-ascii?Q?cPh2emGUTlM5bohV6TTQPuoWPtq0M+TXYFZMvI2BQpvcxkUypoXCiaA0Qwr8?=
 =?us-ascii?Q?45EDf1dTyrKtMngC6Z9QMF9Jo8Oh3oRow1c+40jHPZi/arXoIM1FrHbSvDXz?=
 =?us-ascii?Q?uJbjd5CminoOOwZQZ38WE7JdP2wzrPjhDDg1Tvr50+zFxcxccYsurdiyPnJz?=
 =?us-ascii?Q?1yKLhNC05TRy5gvYcwM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f4df2a-36b7-43c3-03a4-08dd6b74f651
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 08:13:44.9090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kOZvg3kguQr3MksrPMgjVC7pv9zMdziMhGdn3bzD08ecgLqVF9QBAKGiLF74s6Hc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8332
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

Here it may need to test the uq_mgr list to see whether it is a fresh list =
before adding it to the userq_mgr_list; otherwise, it may add a duplicated =
uq_mgr list. I have sent a patch for that check.

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, March 21, 2025 12:53 AM
> To: amd-gfx@lists.freedesktop.org; Paneer Selvam, Arunpravin
> <Arunpravin.PaneerSelvam@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: store userq_managers in a list in adev
>
> So we can iterate across them when we need to manage all user queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 15 ++++++++++++++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  1 +
>  4 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 4f770a362048a..28cfa600b798f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1228,6 +1228,9 @@ struct amdgpu_device {
>        * in KFD: VRAM or GTT.
>        */
>       bool                            apu_prefer_gtt;
> +
> +     struct list_head                userq_mgr_list;
> +     struct mutex                    userq_mutex;
>  };
>
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *ade=
v, diff --
> git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0396ac30c2a4f..526c5aa32825a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4299,6 +4299,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>       mutex_init(&adev->gfx.kfd_sch_mutex);
>       mutex_init(&adev->gfx.workload_profile_mutex);
>       mutex_init(&adev->vcn.workload_profile_mutex);
> +     mutex_init(&adev->userq_mutex);
>
>       amdgpu_device_init_apu_flags(adev);
>
> @@ -4326,6 +4327,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>
>       INIT_LIST_HEAD(&adev->pm.od_kobj_list);
>
> +     INIT_LIST_HEAD(&adev->userq_mgr_list);
> +
>       INIT_DELAYED_WORK(&adev->delayed_init_work,
>                         amdgpu_device_delayed_init_work_handler);
>       INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index a02614cbda36e..b89bfad52abd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -365,6 +365,9 @@ amdgpu_userqueue_create(struct drm_file *filp, union
> drm_amdgpu_userq *args)
>               goto unlock;
>       }
>       args->out.queue_id =3D qid;
> +     mutex_lock(&adev->userq_mutex);
> +     list_add(&uq_mgr->list, &adev->userq_mgr_list);
> +     mutex_unlock(&adev->userq_mutex);
>
>  unlock:
>       mutex_unlock(&uq_mgr->userq_mutex);
> @@ -661,14 +664,24 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr
> *userq_mgr, struct amdgpu_devi
>
>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)  {
> -     uint32_t queue_id;
> +     struct amdgpu_device *adev =3D userq_mgr->adev;
>       struct amdgpu_usermode_queue *queue;
> +     struct amdgpu_userq_mgr *uqm, *tmp;
> +     uint32_t queue_id;
>
>       cancel_delayed_work(&userq_mgr->resume_work);
>
>       mutex_lock(&userq_mgr->userq_mutex);
>       idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id)
>               amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
> +     mutex_lock(&adev->userq_mutex);
> +     list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +             if (uqm =3D=3D userq_mgr) {
> +                     list_del(&uqm->list);
> +                     break;
> +             }
> +     }
> +     mutex_unlock(&adev->userq_mutex);
>       idr_destroy(&userq_mgr->userq_idr);
>       mutex_unlock(&userq_mgr->userq_mutex);
>       mutex_destroy(&userq_mgr->userq_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> index 0f358f77f2d9b..ec1a4ca6f6321 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> @@ -76,6 +76,7 @@ struct amdgpu_userq_mgr {
>       struct mutex                    userq_mutex;
>       struct amdgpu_device            *adev;
>       struct delayed_work             resume_work;
> +     struct list_head                list;
>  };
>
>  struct amdgpu_db_info {
> --
> 2.49.0

