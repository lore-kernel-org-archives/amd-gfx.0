Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3291BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 17:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF5B60F70
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 17:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECF5B60F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 668896EA37;
	Wed, 10 Nov 2021 17:31:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B816EA37
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 17:31:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2iwj++ilMV4MfHjqaMNiW2QytteJszZfrcX1Juj098+mhOgLSZQegYiStro1ErHoGeiWIWqOMSXkTp4p0rAb2mEDpcOg6oNAcA+ijUttz1roXjt+mTVAvjBc5rGQfBXvGQj8nrNwg38rYN4wHysdB3dV+J34v6GRS/EHuNIbjZ/NLaOc0OEwNYMDZDP81+a8R7X4jBPym6SlW3CC+hOzYAatOZ9fGWYWTFJnR3/lQn92YmSIMr81uaucZuZdUr945FSL+IGr/E9Wfr+jMiu4sjYLzwzCPlbSkwoMAv81Yg69t7qCz6h4AgjIjIpXX/Ip2JJYGBkVI1Qb7xV/TgD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbvpkbu0VYt8wyvtqkXJ1ioowzZoPERSSEEj8OxdDc4=;
 b=iMMw+Bt3w0H/mK1ZK7mEWW0zhVOS+lKcg9/8nFs9XtH2q1ffGNsLolW6zj2NxNQOYCUcZmVzCHoOGBlguZoXob4y7pmIkLu3AqBBhHncNO6DoVyJGCvMgSglnoq/+INUdDtbMyv72Ur+nIsmtNGjIJ7ekn/ldc9S8xFopmBL2g4zX28okTac/v20dUUv5sPa2EZDZXR8yaYncPcQdJm9Gt7SGlmBRn7ZlZknStDJ4l4I5koWXrjLZWQUe2+DSKmhPX5SDtBd9BGqm4u8DZMrsaPrzCgYX8qUWP9NkjrBIwiGjUyS4nwIHbTPXC6ub2mshBD0UVyZH1U5tQea8xI1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbvpkbu0VYt8wyvtqkXJ1ioowzZoPERSSEEj8OxdDc4=;
 b=KA/f4oNGePLsWoob8WVNnRmL9iJcF1mxMA5T1JtKVbQ+zPWBpHB5MWAhA5N5A11LD+f8GgbgeKdnYkGbw79YfCk3hppHHhY6zCPTyu6IYMgyQ2CPayMFv/rgKx8waYo5Jy7EjDO7qK0zBSHfw1ULM8zEkX/eFAu4mVAowOQyvW0=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:73::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Wed, 10 Nov
 2021 17:31:15 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea%7]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 17:31:15 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [RFC 2/2] drm/amd/pm: Add support for reacting to platform
 profile notification
Thread-Topic: [RFC 2/2] drm/amd/pm: Add support for reacting to platform
 profile notification
Thread-Index: AQHX1fuIO9/BQCsWxkeg1QIbxGmYD6v83zWAgAAOR4CAABX6sA==
Date: Wed, 10 Nov 2021 17:31:15 +0000
Message-ID: <SA0PR12MB4510F4D9040A7EDA54FC73A8E2939@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211110062343.10041-1-mario.limonciello@amd.com>
 <20211110062343.10041-3-mario.limonciello@amd.com>
 <CADnq5_MGbOh_Xbg6y4hH6qrSok_YKMj0c4Ma6ZKAE835cm2-hw@mail.gmail.com>
 <DM6PR12MB39300185FB03556E914290C297939@DM6PR12MB3930.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB39300185FB03556E914290C297939@DM6PR12MB3930.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-10T17:29:49Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61b37896-8d81-44db-43b2-08d9a46fe5e8
x-ms-traffictypediagnostic: SN6PR12MB2687:
x-microsoft-antispam-prvs: <SN6PR12MB26874C2CA3E974EB60DADA2BE2939@SN6PR12MB2687.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uYaQz8csobpE+zzycuRZRZ6dAx6LY3eCj8dcg5y/h3IMxpO0AY8hyXxiO29hXN1ovt83mGWExJVR6RopXnerytWIXRs13LCD3lfnyKTvukB+erB4h0Dll7GwH1M09dZqdPzgr7isg2En9hcJEy7prNdG3udkOyznFB2B8mNjeKjnyrHfHPVL9d6duW1sfAErptrZsPXaMd6WhMy3UgezGi0qmkcT/ghqL2Y/7Nm+L/htpXQtW+s3fkum3uMUTInj7ZsdmDLtad+DVMaZ/p811yemSuwcosFED4MBBele63KbDlu+msbuEObYQ9svbgklLjaRVa68tBHjbK7knyjom1f7tF0vv8O2f79zIRSVmWUUt630AftDH/fsQ95GzvuTjkFukRpcNxBB0sGr//Z3+FgwSsHz4gzw0Lm2eUuuer7aO1AddKzj17FoFti0/dj/BrhOk8VriugzJNmOetiXS1gFcp4bd8pUy4WkUVH11lkTYBGxpt2iXKV+Ak3JOqXsD23dviUj+gJwl+9NVRx4vtAebv5VluBoT85/xirQhcvICl92iF+n46M5XwqKLZDDu0A6961hraZtCnTqwZaQhRnL0Y9M4Oi+J56Q+u1THlRCxXLxcFfj3aJvwLrqs8lroapN2K968bcDyM7SQbxzaWuoEXu5aFfRbJ4ip8rSay1EcXtv1zCt6CSfCf8F/Xgmbb5u4wtztpxa1rXfkwwC6Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(2906002)(15650500001)(4326008)(66556008)(508600001)(6506007)(53546011)(5660300002)(26005)(66946007)(52536014)(64756008)(110136005)(316002)(76116006)(186003)(66476007)(7696005)(71200400001)(8676002)(86362001)(33656002)(8936002)(9686003)(38070700005)(55016002)(122000001)(38100700002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W2Xr4bqi/TPBllL7a3J1EF1txy008eNchj7GJoJUq4JKRdnvR1P0w4edjahh?=
 =?us-ascii?Q?iJr5jR4oXdsDhEZtmqYWoP/jkzuYqsukgbCW5HzIaygixXNLL73zEWkO0eGq?=
 =?us-ascii?Q?tFn8eUJDXIQ3VXi6O++HPllLzI5MVmmlFph6ySrqqUJnaMaI4akJ3bYYtzhv?=
 =?us-ascii?Q?GGatktQUbgPsppCgQN6TEG2XhsAUOGglUnLIflorZ+NQniR17hsWOKTzyMHE?=
 =?us-ascii?Q?8Eo16FzqG1y9CLyEQi6QJhNg2Z7n2VVKAmgxsYK1LsxPJZkTwlIZ+G52Akbo?=
 =?us-ascii?Q?iIveFXkUplU9NCBStoKOTRf9nAiEWC0Ul8ufLlwNDUOA3j8Ce4/BMAEjhiMT?=
 =?us-ascii?Q?1Ov1WqJi2OXvTGqQko1alSqvNNTuuKny3bdsV8dXrZ1A/ju34wbFU77MxIHo?=
 =?us-ascii?Q?8RNwZyXd7svUUGYDfxnixKY3FLvQKUSMEkTRhFX4NbFVRDzdSD8/dlfsi9pR?=
 =?us-ascii?Q?i34aFRPXl/Yr9wJ8hBI2O1XcFs2S87KcRI81O6Ut4e4ok1uVjKPVsFEl/NO3?=
 =?us-ascii?Q?FCAKItUTfNtdhds72puimDzCq5VHyzJzDsyk0Rr37ysqNsqzbyGIFCTSQ+cC?=
 =?us-ascii?Q?ToFEk+VRyvEs/GxAybXmV5AA3DUZAzgXwh05UANNOeAIJgoLw5NXWyImZ6C/?=
 =?us-ascii?Q?76u/NQLvnQhIH/sO9PHmxPmnxhgx00Ry2Gh58oJ7c4SoqKTF8qXlXazP2fgp?=
 =?us-ascii?Q?UpHWckeYLvNSDXaLHefcOjKCBgOrcWpkC2bb1Nek6rSnXy0W+Z3cymgKJSmC?=
 =?us-ascii?Q?Gfv0HNLRJTrA6VjwljkiyNsiwavMv+SyWltFCzwZWu/OU2Wpa1rzsPMMpfJb?=
 =?us-ascii?Q?NLcGdzltIoDE6Qx+i4KPjkPVQGoQswr50FOGXW0WRPrcsPPP99PiZIzPk1+v?=
 =?us-ascii?Q?IRgFhscl3fh5MEXFYZ0K6UAC/pCmme9KnfptBzLuCtoRJgsK5uW5iYJiloUl?=
 =?us-ascii?Q?L+MVC3ZIN/Hyy6cJHjcyeqMAQ3uSQ3GEK4qKvnwmtTzlQLVIXKzBdbJXEvCb?=
 =?us-ascii?Q?ts9Pys5mQJAgLQ7N5vUBf0BERzZcIVoXelXNBnu0Mgw6Xa27F98eEfWjuJcf?=
 =?us-ascii?Q?Gyd0RCFHlXKfctQcHPUkmF4X445pK2mTEB9cfONNqaDzUIkLDzvRyjfDDklm?=
 =?us-ascii?Q?kBmmLIqztvc85IFnpQxr3YRB4ptVb7dWH1S0DFt0tS5BNtDbYWiP0CbVmuDX?=
 =?us-ascii?Q?robXr86vx1MyXLVqSk0LnLin7RHMAccGT6r+wyGElZJP+T0TF9oCRJ2JKlGO?=
 =?us-ascii?Q?FjwnK1Esy3MhGkP48vFJMEdTHXutBYCGL/iiy6L7TOfAR05PqogFEFheiM3B?=
 =?us-ascii?Q?zNYT7O0Xts7joKodLQRuWRZINRxNCkHvroa9jHvAMJhaxTdNMd1NYLdT2pK3?=
 =?us-ascii?Q?/gZC1FL9TE2Za9+QaT8EczN9ZEab9V6tsmjkXXcujcXKp18GhAFCzbfClrR/?=
 =?us-ascii?Q?NWsOTpcSs2r1t+F5/lkITKHDD7JQ7+zb5CrVXdmrXGZUoxB/cUoBGEYD300G?=
 =?us-ascii?Q?lBmBqNnwlkQ/P838PeBrl5/4JjIZJt/68r42gKFJIvAlZyHrrjWULsjGJ1GG?=
 =?us-ascii?Q?0mLmMxom1cwF4efjNediiVEIob/CsWUZZa7khJ1eQz2850YB/tzThyx6+qoo?=
 =?us-ascii?Q?1fxHOgpWKsIxqa60fVvwV7c=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA0PR12MB4510F4D9040A7EDA54FC73A8E2939SA0PR12MB4510namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b37896-8d81-44db-43b2-08d9a46fe5e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 17:31:15.4259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UyMFM2EU5FZ8MT2LrazbZsAgOyywMlZ7eJkO+9B9bWsNhh4o+SQNjthReI/ckJcA/8fMCxBCUztpZhJsron1SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_SA0PR12MB4510F4D9040A7EDA54FC73A8E2939SA0PR12MB4510namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

> I don't think we want to force the performance level.  This interface
forces various fixed clock configurations for debugging and profiling.
Ah got it.

>I think what we'd want to select here is the power profile (see
amdgpu_set_pp_power_profile_mode()).  For this interface you can
select various profiles (BOOTUP_DEFAULT, 3D_FULL_SCREEN, POWER_SAVING,
VIDEO, VR, COMPUTE, etc.).  These still use dynamic power management,
but they adjust the heuristics used by the GPU to select power states
so the GPU performance ramps up/down more or less aggressively.

Which profile mapping you think make sense?
My guess would be:
"BOOTUP_DEFAULT" for balanced
"POWER_SAVING" for low-power
"3D_FULL_SCREEN" for performance

Since recently we removed that interface for YC, and some earlier APUs don'=
t do as much with it.
So I wonder if this is only really valuable to do this callback for !APU.

> I feel it's better to leave to platform vendors. For ex: for APU cases th=
ey may have implementations in which their BIOSes talk to PMFW and this mig=
ht be driving something else here.

Even if changing the heuristic for workload as Alex suggested?

> Also, not sure how to handle a case like, say a laptop with Intel CPU and=
 AMD dgpu.

I was actually thinking this approach where there are platform profile call=
backs is best because of that specifically.
It would allow an Intel CPU system to have a platform profile driver implem=
ented by the OEM, but then still notify amdgpu dGPU to tune for power savin=
g or performance workload.

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, November 10, 2021 10:05
To: Alex Deucher <alexdeucher@gmail.com>; Limonciello, Mario <Mario.Limonci=
ello@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [RFC 2/2] drm/amd/pm: Add support for reacting to platform pro=
file notification


[Public]

I feel it's better to leave to platform vendors. For ex: for APU cases they=
 may have implementations in which their BIOSes talk to PMFW and this might=
 be driving something else here.

Also, not sure how to handle a case like, say a laptop with Intel CPU and A=
MD dgpu.

Thanks,
Lijo

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Alex Deucher <alexdeucher@gmail.com<m=
ailto:alexdeucher@gmail.com>>
Sent: Wednesday, 10 November 2021, 8:44 pm
To: Limonciello, Mario
Cc: amd-gfx list
Subject: Re: [RFC 2/2] drm/amd/pm: Add support for reacting to platform pro=
file notification

On Wed, Nov 10, 2021 at 1:24 AM Mario Limonciello
<mario.limonciello@amd.com<mailto:mario.limonciello@amd.com>> wrote:
>
> Various drivers provide platform profile support to let users set a hint
> in their GUI whether they want to run in a high performance, low battery
> life or balanced configuration.
>
> Drivers that provide this typically work with the firmware on their syste=
m
> to configure hardware.  In the case of AMDGPU however, the notification
> path doesn't come through firmware and can instead be provided directly
> to the driver from a notification chain.
>
> Use the information of the newly selected profile to tweak
> `dpm_force_performance_level` to that profile IFF the user hasn't manuall=
y
> selected `manual` or any other `profile_*` options.

I don't think we want to force the performance level.  This interface
forces various fixed clock configurations for debugging and profiling.
I think what we'd want to select here is the power profile (see
amdgpu_set_pp_power_profile_mode()).  For this interface you can
select various profiles (BOOTUP_DEFAULT, 3D_FULL_SCREEN, POWER_SAVING,
VIDEO, VR, COMPUTE, etc.).  These still use dynamic power management,
but they adjust the heuristics used by the GPU to select power states
so the GPU performance ramps up/down more or less aggressively.

Alex

>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com<mailto:mario.=
limonciello@amd.com>>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h |   3 +
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c  | 105 +++++++++++++++++++++++-----
>  2 files changed, 90 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index b85b67a88a3d..27b0be23b6ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1097,6 +1097,9 @@ struct amdgpu_device {
>
>         struct amdgpu_reset_control     *reset_cntl;
>         uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_I=
NSTANCE];
> +
> +       /* platform profile notifications */
> +       struct notifier_block           platform_profile_notifier;
>  };
>
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index 41472ed99253..33fc52b90d4c 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -32,6 +32,7 @@
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/nospec.h>
> +#include <linux/platform_profile.h>
>  #include <linux/pm_runtime.h>
>  #include <asm/processor.h>
>  #include "hwmgr.h"
> @@ -200,6 +201,33 @@ static ssize_t amdgpu_set_power_dpm_state(struct dev=
ice *dev,
>         return count;
>  }
>
> +static int amdgpu_get_forced_level(struct device *dev, enum amd_dpm_forc=
ed_level *level)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +       int ret;
> +
> +       if (amdgpu_in_reset(adev))
> +               return -EPERM;
> +       if (adev->in_suspend && !adev->in_runpm)
> +               return -EPERM;
> +
> +       ret =3D pm_runtime_get_sync(ddev->dev);
> +       if (ret < 0) {
> +               pm_runtime_put_autosuspend(ddev->dev);
> +               return ret;
> +       }
> +
> +       if (adev->powerplay.pp_funcs->get_performance_level)
> +               *level =3D amdgpu_dpm_get_performance_level(adev);
> +       else
> +               *level =3D adev->pm.dpm.forced_level;
> +
> +       pm_runtime_mark_last_busy(ddev->dev);
> +       pm_runtime_put_autosuspend(ddev->dev);
> +
> +       return 0;
> +}
>
>  /**
>   * DOC: power_dpm_force_performance_level
> @@ -264,29 +292,13 @@ static ssize_t amdgpu_get_power_dpm_force_performan=
ce_level(struct device *dev,
>                                                             struct device=
_attribute *attr,
>                                                             char *buf)
>  {
> -       struct drm_device *ddev =3D dev_get_drvdata(dev);
> -       struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         enum amd_dpm_forced_level level =3D 0xff;
>         int ret;
>
> -       if (amdgpu_in_reset(adev))
> -               return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> -               return -EPERM;
> +       ret =3D amdgpu_get_forced_level(dev, &level);
>
> -       ret =3D pm_runtime_get_sync(ddev->dev);
> -       if (ret < 0) {
> -               pm_runtime_put_autosuspend(ddev->dev);
> +       if (ret < 0)
>                 return ret;
> -       }
> -
> -       if (adev->powerplay.pp_funcs->get_performance_level)
> -               level =3D amdgpu_dpm_get_performance_level(adev);
> -       else
> -               level =3D adev->pm.dpm.forced_level;
> -
> -       pm_runtime_mark_last_busy(ddev->dev);
> -       pm_runtime_put_autosuspend(ddev->dev);
>
>         return sysfs_emit(buf, "%s\n",
>                           (level =3D=3D AMD_DPM_FORCED_LEVEL_AUTO) ? "aut=
o" :
> @@ -405,6 +417,59 @@ static ssize_t amdgpu_set_power_dpm_force_performanc=
e_level(struct device *dev,
>         return count;
>  }
>
> +static void amdgpu_update_profile(struct device *dev, enum platform_prof=
ile_option *profile)
> +{
> +       enum amd_dpm_forced_level level;
> +       const char *str;
> +       int ret;
> +
> +       ret =3D amdgpu_get_forced_level(dev, &level);
> +       if (ret < 0)
> +               return;
> +
> +       /* only update profile if we're in fixed modes right now that nee=
d updating */
> +       switch (level) {
> +       case AMD_DPM_FORCED_LEVEL_LOW:
> +               if (*profile < PLATFORM_PROFILE_BALANCED)
> +                       return;
> +               break;
> +       case AMD_DPM_FORCED_LEVEL_HIGH:
> +               if (*profile > PLATFORM_PROFILE_BALANCED)
> +                       return;
> +               break;
> +       case AMD_DPM_FORCED_LEVEL_AUTO:
> +               if (*profile =3D=3D PLATFORM_PROFILE_BALANCED)
> +                       return;
> +               break;
> +       default:
> +               dev_dbg(dev, "refusing to update amdgpu profile from %d\n=
", level);
> +               return;
> +       }
> +       if (*profile > PLATFORM_PROFILE_BALANCED)
> +               str =3D "high";
> +       else if (*profile < PLATFORM_PROFILE_BALANCED)
> +               str =3D "low";
> +       else
> +               str =3D "auto";
> +
> +       dev_dbg(dev, "updating platform profile to %s\n", str);
> +       amdgpu_set_power_dpm_force_performance_level(dev, NULL, str, 0);
> +}
> +
> +static int amdgpu_platform_profile_notifier_call(struct notifier_block *=
nb,
> +                                                 unsigned long action, v=
oid *data)
> +{
> +       if (action =3D=3D PLATFORM_PROFILE_CHANGED) {
> +               enum platform_profile_option *profile =3D data;
> +               struct amdgpu_device *adev;
> +
> +               adev =3D container_of(nb, struct amdgpu_device, platform_=
profile_notifier);
> +               amdgpu_update_profile(adev->dev, profile);
> +       }
> +
> +       return NOTIFY_OK;
> +}
> +
>  static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>                 struct device_attribute *attr,
>                 char *buf)
> @@ -3506,6 +3571,9 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev=
)
>         if (ret)
>                 return ret;
>
> +       adev->platform_profile_notifier.notifier_call =3D amdgpu_platform=
_profile_notifier_call;
> +       platform_profile_register_notifier(&adev->platform_profile_notifi=
er);
> +
>         adev->pm.sysfs_initialized =3D true;
>
>         return 0;
> @@ -3519,6 +3587,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *ade=
v)
>         if (adev->pm.int_hwmon_dev)
>                 hwmon_device_unregister(adev->pm.int_hwmon_dev);
>
> +       platform_profile_unregister_notifier(&adev->platform_profile_noti=
fier);
>         amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
>  }
>
> --
> 2.25.1
>


--_000_SA0PR12MB4510F4D9040A7EDA54FC73A8E2939SA0PR12MB4510namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;background:white"><spa=
n style=3D"color:black">&gt; I don't think we want to force the performance=
 level.&nbsp; This interface<br>
forces various fixed clock configurations for debugging and profiling.</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">Ah got it.</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">&gt;I think what we'd want to select here is the power profile (see<br>
amdgpu_set_pp_power_profile_mode()).&nbsp; For this interface you can<br>
select various profiles (BOOTUP_DEFAULT, 3D_FULL_SCREEN, POWER_SAVING,<br>
VIDEO, VR, COMPUTE, etc.).&nbsp; These still use dynamic power management,<=
br>
but they adjust the heuristics used by the GPU to select power states<br>
so the GPU performance ramps up/down more or less aggressively.</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">Which profile mapping you think make sense?</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">My guess would be:</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">&#8220;BOOTUP_DEFAULT&#8221; for balanced</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">&#8220;POWER_SAVING&#8221; for low-power</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">&#8220;3D_FULL_SCREEN&#8221; for performance</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">Since recently we removed that interface for YC, and some earlier APUs d=
on&#8217;t do as much with it.</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">So I wonder if this is only really valuable to do this callback for !APU=
.&nbsp;
</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">&gt;</span><span style=3D"color:#212121"> I feel it's better to leave to=
 platform vendors. For ex: for APU cases they may have implementations in w=
hich their BIOSes talk to PMFW and this might
 be driving something else here.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">Even if changing the heuristic for workload as Alex suggested?</span><o:=
p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">&gt;</span><span style=3D"color:#212121"> Also, not sure how to handle a=
 case like, say a laptop with Intel CPU and AMD dgpu.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I was actually thinking this approach where there ar=
e platform profile callbacks is best because of that specifically.<o:p></o:=
p></p>
<p class=3D"MsoNormal">It would allow an Intel CPU system to have a platfor=
m profile driver implemented by the OEM, but then still notify amdgpu dGPU =
to tune for power saving or performance workload.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Wednesday, November 10, 2021 10:05<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; Limonciello, Mario &=
lt;Mario.Limonciello@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [RFC 2/2] drm/amd/pm: Add support for reacting to platf=
orm profile notification<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">I feel it's better to leave to platform vendors. For ex: for APU cases=
 they may have implementations in which their BIOSes talk to PMFW and this =
might be driving something else here.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">Also, not sure how to handle a case like, say a laptop with Intel CPU =
and AMD dgpu.<o:p></o:p></span></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal">Thanks,<br>
Lijo<o:p></o:p></p>
</div>
<div id=3D"id-f61421a9-d54c-4f81-aa61-517d64763a14">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:13.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><strong><span style=3D"font-family:&quot;Calibri&quo=
t;,sans-serif">From:</span></strong> amd-gfx &lt;<a href=3D"mailto:amd-gfx-=
bounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt=
; on behalf of Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">al=
exdeucher@gmail.com</a>&gt;<br>
<strong><span style=3D"font-family:&quot;Calibri&quot;,sans-serif">Sent:</s=
pan></strong> Wednesday, 10 November 2021, 8:44 pm<br>
<strong><span style=3D"font-family:&quot;Calibri&quot;,sans-serif">To:</spa=
n></strong> Limonciello, Mario<br>
<strong><span style=3D"font-family:&quot;Calibri&quot;,sans-serif">Cc:</spa=
n></strong> amd-gfx list<br>
<strong><span style=3D"font-family:&quot;Calibri&quot;,sans-serif">Subject:=
</span></strong> Re: [RFC 2/2] drm/amd/pm: Add support for reacting to plat=
form profile notification<o:p></o:p></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">On Wed, Nov 10, 2021 at 1:24 AM Mario Limonciello<br=
>
&lt;<a href=3D"mailto:mario.limonciello@amd.com">mario.limonciello@amd.com<=
/a>&gt; wrote:<br>
&gt;<br>
&gt; Various drivers provide platform profile support to let users set a hi=
nt<br>
&gt; in their GUI whether they want to run in a high performance, low batte=
ry<br>
&gt; life or balanced configuration.<br>
&gt;<br>
&gt; Drivers that provide this typically work with the firmware on their sy=
stem<br>
&gt; to configure hardware.&nbsp; In the case of AMDGPU however, the notifi=
cation<br>
&gt; path doesn't come through firmware and can instead be provided directl=
y<br>
&gt; to the driver from a notification chain.<br>
&gt;<br>
&gt; Use the information of the newly selected profile to tweak<br>
&gt; `dpm_force_performance_level` to that profile IFF the user hasn't manu=
ally<br>
&gt; selected `manual` or any other `profile_*` options.<br>
<br>
I don't think we want to force the performance level.&nbsp; This interface<=
br>
forces various fixed clock configurations for debugging and profiling.<br>
I think what we'd want to select here is the power profile (see<br>
amdgpu_set_pp_power_profile_mode()).&nbsp; For this interface you can<br>
select various profiles (BOOTUP_DEFAULT, 3D_FULL_SCREEN, POWER_SAVING,<br>
VIDEO, VR, COMPUTE, etc.).&nbsp; These still use dynamic power management,<=
br>
but they adjust the heuristics used by the GPU to select power states<br>
so the GPU performance ramps up/down more or less aggressively.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Signed-off-by: Mario Limonciello &lt;<a href=3D"mailto:mario.limonciel=
lo@amd.com">mario.limonciello@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h |&nbsp;&nbsp; 3 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp; | 105 +++++++++++++++++=
++++++-----<br>
&gt;&nbsp; 2 files changed, 90 insertions(+), 18 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index b85b67a88a3d..27b0be23b6ac 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1097,6 +1097,9 @@ struct amdgpu_device {<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_co=
ntrol&nbsp;&nbsp;&nbsp;&nbsp; *reset_cntl;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_versions[HW_ID_MAX][HW=
IP_MAX_INSTANCE];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* platform profile notification=
s */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct notifier_block&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; platform_profile_notifier=
;<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static inline struct amdgpu_device *drm_to_adev(struct drm_devic=
e *ddev)<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/=
pm/amdgpu_pm.c<br>
&gt; index 41472ed99253..33fc52b90d4c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; @@ -32,6 +32,7 @@<br>
&gt;&nbsp; #include &lt;linux/hwmon.h&gt;<br>
&gt;&nbsp; #include &lt;linux/hwmon-sysfs.h&gt;<br>
&gt;&nbsp; #include &lt;linux/nospec.h&gt;<br>
&gt; +#include &lt;linux/platform_profile.h&gt;<br>
&gt;&nbsp; #include &lt;linux/pm_runtime.h&gt;<br>
&gt;&nbsp; #include &lt;asm/processor.h&gt;<br>
&gt;&nbsp; #include &quot;hwmgr.h&quot;<br>
&gt; @@ -200,6 +201,33 @@ static ssize_t amdgpu_set_power_dpm_state(struct =
device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; +static int amdgpu_get_forced_level(struct device *dev, enum amd_dpm_f=
orced_level *level)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D dev_=
get_drvdata(dev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D d=
rm_to_adev(ddev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EPERM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_suspend &amp;&am=
p; !adev-&gt;in_runpm)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EPERM;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(ddev=
-&gt;dev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;dev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-=
&gt;get_performance_level)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *level =3D amdgpu_dpm_get_performance_level(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *level =3D adev-&gt;pm.dpm.forced_level;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&=
gt;dev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-=
&gt;dev);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +}<br>
&gt;<br>
&gt;&nbsp; /**<br>
&gt;&nbsp;&nbsp; * DOC: power_dpm_force_performance_level<br>
&gt; @@ -264,29 +292,13 @@ static ssize_t amdgpu_get_power_dpm_force_perfor=
mance_level(struct device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dev=
ice_attribute *attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)=
<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D dev_=
get_drvdata(dev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D d=
rm_to_adev(ddev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_le=
vel level =3D 0xff;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EPERM;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_suspend &amp;&am=
p; !adev-&gt;in_runpm)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EPERM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_get_forced_level(=
dev, &amp;level);<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(ddev=
-&gt;dev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;dev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-=
&gt;get_performance_level)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; level =3D amdgpu_dpm_get_performance_level(adev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; level =3D adev-&gt;pm.dpm.forced_level;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&=
gt;dev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-=
&gt;dev);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sysfs_emit(buf,=
 &quot;%s\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (level =3D=3D AMD_DPM_FORCED_LEVEL_AUTO) ? &quot;auto&quot; :<br=
>
&gt; @@ -405,6 +417,59 @@ static ssize_t amdgpu_set_power_dpm_force_perform=
ance_level(struct device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; +static void amdgpu_update_profile(struct device *dev, enum platform_p=
rofile_option *profile)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_level level;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *str;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_get_forced_level(=
dev, &amp;level);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only update profile if we're =
in fixed modes right now that need updating */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (level) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_LOW:<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (*profile &lt; PLATFORM_PROFILE_BALANCED)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_HIGH:<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (*profile &gt; PLATFORM_PROFILE_BALANCED)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_AUTO:<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (*profile =3D=3D PLATFORM_PROFILE_BALANCED)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dev_dbg(dev, &quot;refusing to update amdgpu profile from %=
d\n&quot;, level);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*profile &gt; PLATFORM_PROFI=
LE_BALANCED)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; str =3D &quot;high&quot;;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (*profile &lt; PLATFORM_=
PROFILE_BALANCED)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; str =3D &quot;low&quot;;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; str =3D &quot;auto&quot;;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(dev, &quot;updating plat=
form profile to %s\n&quot;, str);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_set_power_dpm_force_perfo=
rmance_level(dev, NULL, str, 0);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int amdgpu_platform_profile_notifier_call(struct notifier_bloc=
k *nb,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsig=
ned long action, void *data)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (action =3D=3D PLATFORM_PROFI=
LE_CHANGED) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum platform_profile_option *profile =3D data;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_device *adev;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev =3D container_of(nb, struct amdgpu_device, platform_pr=
ofile_notifier);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_update_profile(adev-&gt;dev, profile);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NOTIFY_OK;<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static ssize_t amdgpu_get_pp_num_states(struct device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; @@ -3506,6 +3571,9 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *a=
dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;platform_profile_notifi=
er.notifier_call =3D amdgpu_platform_profile_notifier_call;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; platform_profile_register_notifi=
er(&amp;adev-&gt;platform_profile_notifier);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.sysfs_init=
ialized =3D true;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; @@ -3519,6 +3587,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *=
adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.int_hw=
mon_dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; hwmon_device_unregister(adev-&gt;pm.int_hwmon_dev=
);<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; platform_profile_unregister_noti=
fier(&amp;adev-&gt;platform_profile_notifier);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_attr_rem=
ove_groups(adev, &amp;adev-&gt;pm.pm_attr_list);<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_SA0PR12MB4510F4D9040A7EDA54FC73A8E2939SA0PR12MB4510namp_--
