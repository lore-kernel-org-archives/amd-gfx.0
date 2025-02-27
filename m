Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFFDC197BF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 19:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC38110EB7A;
	Thu, 27 Feb 2025 19:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vPKLar8M";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E518410EB75
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 19:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYw7DmZrbJV34e0tGc/f2jBO0wAWenl9mwiFejY5APazmbUbb+w5aVDstM6Oxdyb3JV+lSO0gBGroQEkdPZHS525VIU1k/Oq8ItGsLzSUh+VI062BWi4CynjE87qkUfErC6bByr5A49vS0WR9w8GZR7VO8Wx2oWTNTeSO/uB8WuXnCHoS49TaNdNQWIErLjdcV5yVMNMdUm2C3BmQ7bKaUBF7dAQ+qn5Redd5gO9P9lDV8i5uzNeCIzlNLZVfyzm973Kz8Ot/7h89XLSgcWVFZ5TTwo179dVB2P+1Pk8BYImPbB3fKaAte+wM5yy0WAwXfeoC4N1xv6av27+gun/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQz1cDD5ejmuqOwxPgi1R+nSY4YHQAWYwaUDGKT3LZg=;
 b=EE4ashUnVw/XX+C66IONVMPkOFU5xjxyT98dQSGE/3A+LBsUUtnbF8JFlCMj8m/VT0j32roY4+0ETpTZl7NL56n7Cazmc9X31zX68pMe5QoA4Gjz4K62aWQw6Ckm7RcQzdLWrbyflQjsRhDfyinaf5V9oajAK4wSWXCPjtlyvIPQSLxvye/GNVuk68fsWZN2Karn9EG0cZ6gA1A0ckaeTS0ng/MuuoJ+Sbe3abTU8bvI7N7EyIYwEEo76l5bg6T6hwxxdojP1vWdf05O95cGF+2ufwdsMxrgGU7O1Yroq14IGdmouozOHyZ2u9Gv35tRsuAimDXAB/VaSU0022Flhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQz1cDD5ejmuqOwxPgi1R+nSY4YHQAWYwaUDGKT3LZg=;
 b=vPKLar8MxNnPVKn4SevRjnkf8bpsZuNHdN+OUXDFHFwpJO9IpUBXT4UcGNrHMLYbzVm0PcZVwh805kNCwdleYC/CjrREe3ysp/bIIjxz27+cv7ZLRyijdhVADWyK9b+7PeFWKBdHYZ6tC4SZcucw6ZQAWwj2VqfrIoA4GQLUAuU=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 19:47:14 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 19:47:13 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH 1/2] drm/amdkfd: Add pm_config_dequeue_wait_counts API
Thread-Topic: [PATCH 1/2] drm/amdkfd: Add pm_config_dequeue_wait_counts API
Thread-Index: AQHbiIPya2asP4O4M0S/VpiDZtE2+rNbht6A
Date: Thu, 27 Feb 2025 19:47:13 +0000
Message-ID: <CY8PR12MB7435A4BED4D1DE5C876F5AF085CD2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250226192303.48552-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20250226192303.48552-1-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=8a490587-367a-4bf9-a148-12005f208f08;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-27T19:15:30Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|PH7PR12MB6979:EE_
x-ms-office365-filtering-correlation-id: b6afc945-b674-4544-1b7d-08dd57678878
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?wfI0B1XqoZPjUYVRfsvM0UOWsbLsup5X5dCCyYuxyohG58QSPeqGdouQKMTU?=
 =?us-ascii?Q?m1xoJLdRuHelDxJgClTas01iNi6PF1NdGIFRkYX9yXgC1+VuNw2lMKhcr1PN?=
 =?us-ascii?Q?MmfiRoX2KD6l8e3XZdI8FHDe5PZto8wAg/pTUqJFGGNXU9MxWtsqj89uW5c/?=
 =?us-ascii?Q?f887HhdQty+s6HC4+zFKWr3U3rT+6GOQ4qsM6fMdffYhVth1PtkLZg/7LQ/M?=
 =?us-ascii?Q?cbXSKibPmzBeI8hvxv4FblMMOGbRKniBlfRSq9nvyAgs3gh5sG7Eu+jLqeVu?=
 =?us-ascii?Q?YdzNP8oMWZ3G2j1yOneXIjMEoWWI1wPbQbLlpePWf7NXYAPqRhDtCl+OgD3h?=
 =?us-ascii?Q?WyLMKUrlJiN/2LSCQMnY2FN+xbN3/GtQEKLjyGNaxUz90uIE0bc5ueYCxrSp?=
 =?us-ascii?Q?2qah4znUZc8opAq86VKQxcBQZ0UWyolRYT2Q+4SWQqS/u+G1H9z4/pEhMxzm?=
 =?us-ascii?Q?2U6Hxiau12ah9rofL4GeUln7b4Ue/b6DgW3PTXsnvxIX51XUZbIlw4rLb7pU?=
 =?us-ascii?Q?urvuoNyhC5fj1GD+R8YdHuvQi5Cp6AM3zjURQlu3tRO1Uzj9AiB6tcg7WvJ7?=
 =?us-ascii?Q?rhH2Ps8O0yhCHNkRbSLFyHvsufRrFCtzZK6cJpVqICbkKUyS+qMXJ94yYLox?=
 =?us-ascii?Q?KOqW0Jlz0HwAdWPBLxUejOvA7wNmVafsLK/QumuZcio3+AlejRc+IAeXd6US?=
 =?us-ascii?Q?d7BZGgimz3UzxRrMaOaB0dJBWTfvG9TgQMQmZZdMUlC/4Dl8KcuWT4EnFk16?=
 =?us-ascii?Q?njJIZqfSiWQXoYD6Na563G0lLcAxnoFx22mR45hZs0FJX6XW1eQMK7WTRuMr?=
 =?us-ascii?Q?bXC7q2pwrchUHLZCAb1dyMFzPjMT7Z6xnyIAzxAJNYqHh8x92cAVBvprH6Eq?=
 =?us-ascii?Q?UfAqX11wIxnxhsyMOZo558A2oE5DK3gxTYV/x8fOvENaBA6bldoUWcs55Qjm?=
 =?us-ascii?Q?y87cxxFKN4zhuP7tqrCTWsxkvTFxrnVMWz0Xi8inkjknCwmQ40cEP5qU+mjp?=
 =?us-ascii?Q?KmYNieTLbnSu1/7gVSMGcwxj6fuxe/IG08cWnog09ut62NMWOq7UHhbPHbIb?=
 =?us-ascii?Q?BZtjD5scnPZ16RkgO/vQOqAalXCh8XJB1Yv4DCPM6G13mT6PBjdZaM6H5AX1?=
 =?us-ascii?Q?Xho5RLJ1QrOCNADIHM8z6kGewTkd3ErIn31Y4PhVoorybGspo92IE7HFGxaS?=
 =?us-ascii?Q?E0YGh/LUrXkqQLghfHl9YkiuEclk+/W4/j3b3JymW77a2+j0Bktsbnah2ONZ?=
 =?us-ascii?Q?z++eL/bRKI0xX3pifUMR8Vk7Wr9NT2My5Rxiu2qYdoBiMajLSbdLHorxEGFa?=
 =?us-ascii?Q?vjRDmz2TuZAmxeyniqbcSkzjvjO0EZLY/jY/RqvlH1zQDqwRhug0AR+XF2i2?=
 =?us-ascii?Q?iBdAYo1GNUqgdni7gti3rbrHMWWKR2fH3YtiibMLl33RVq5k+SwskZwT6jZv?=
 =?us-ascii?Q?7FBEGyclrQvOzEkTnM+59iI191cLdguQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kQ7tQrYQhlpPhH48dgGtKbOUJBXTe8A7hl/J0qnU0chzAhbZfjfscThtzb4Y?=
 =?us-ascii?Q?WwSoMgwskTm5AFWKUup4tHWsjdYz6wpb0aoIbvRpZ/999UlGvsg1URdleYYH?=
 =?us-ascii?Q?UQEYVC0bNmXJXfk7BmoV8s5CjfXhuoLpKwpO54RVgbzTsVhc7aQdEIkiWTK5?=
 =?us-ascii?Q?iiA0Urtdwuqqt5rObPS2PPDrLOyE9OpF2WiVYX/rxP9j9aR3J65e5JIPOdWb?=
 =?us-ascii?Q?/Mo6aGKr6MsWDtH/vMszK8Zc04Oh/gR4V/MEWMNDp7KI9uEeOiTukEAOOYod?=
 =?us-ascii?Q?PPCi9tVsL3/TeuVEZboFzS/R3HEL7tTXGJ5uffAATkKj3oqGVJoAn2MOUT9M?=
 =?us-ascii?Q?NAVDEZYJEIXb3ML4UQcgSfjpNYPqKkAUFIxYuAwXchyG45tdxIOhcQP6xRml?=
 =?us-ascii?Q?xAmB4+BU4Id6OkswwWiYOZ+rGqa1m/ZIYnGPNpGLRyipflYWQjK8zxYYRrtw?=
 =?us-ascii?Q?3zdjijTqgLTOgBDZtZ/5xTTKZdG8RHvZ21a9bfmcAowovZe+pD9bVl16uAMs?=
 =?us-ascii?Q?1WGPizHIXasPvIg5jZRvPT+XdKrvrMhh7wV8ZZGWv+aR3Q5FNgr0N5UAgftG?=
 =?us-ascii?Q?Iuv3uZfl1LAXrz5f96BaD5QWDB3Tj7J1kFuX/kHvpFTPwz3kPNl460jjZApJ?=
 =?us-ascii?Q?sv47Nlm//cBVmO5Vi00EzLy+X0Smj+6ao/KlBEqBhzYsEv8KQyYA9o/4wznH?=
 =?us-ascii?Q?3k+fgwGvBW/PZrjFm6OikUo4zC4+lm0vwAkQz2zf3XdiXTncBvpHIOfDEDhv?=
 =?us-ascii?Q?G2elTuV84t5xFwZEo4hdsXWqH/uEdU1h6NkISn5m7hI4EywkjVr2WQX5dyUq?=
 =?us-ascii?Q?gP6x0loAeM6OGV4ez35SfeHrVlAmlB02/3d47iyxDkbGDZgHJ184xp3D6Vfc?=
 =?us-ascii?Q?jPgJ7vTU21lghNvzVCb37C6HfX3bI9PE23P/DfRTPC8hT8O72+GCeMz/AIkq?=
 =?us-ascii?Q?TV3+MLCh5YQjMEp0+dPVdecL6oNmTsqI6dtIRYZnElJfDZ9H75xGX7zrAYnx?=
 =?us-ascii?Q?gRD8Pueh/CN0JbIpXLCmevWqn/skYtECi7HElA5qxrTXDUQ3wj6xJbcD240P?=
 =?us-ascii?Q?urglqjnjv1USjlXGm+c6f7RO/Ke5q/uKyPAj0mwPan3idEfiWIT7mNjdjmVg?=
 =?us-ascii?Q?9rEypy0vEtBBCzyHSqaW1htCRLD21YxEpIx87sNK5RvFwgYjBvw77ubwSVcX?=
 =?us-ascii?Q?EZ0QBXnon5OLww4BPhBDQ7YnzxrPs+b+TSZYSzbi+Fexl7g315OSb3YVbtrX?=
 =?us-ascii?Q?gOBQ74NkLCDTYUENvJFVW/UIaUkO0N7EBKXusZIuto8o5yT8PR/yE8geDvYI?=
 =?us-ascii?Q?5/yf+3PSdacgm/ndlIjAtax2bl1CkKKfmuT5EnrlAmtX/Hyiq76vXfzrI8nN?=
 =?us-ascii?Q?ZgieD/noIuYrbI48SY5snSnF/r14k/kcoITKX/dIozBJUmtgLk/7dIRMh+4g?=
 =?us-ascii?Q?+9+0FjRt4WyrtLFjjeuavyenjWetgY+llNQa9NH2xIddradkC5TIcLiKfxz7?=
 =?us-ascii?Q?whfJF8v/wtr7uOV4HJjqjPCrNEnbaDl+OyqpygDJGt0ySStNF+Eb0bI852zH?=
 =?us-ascii?Q?4nJ+QagvuX5ofI1Sv1o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6afc945-b674-4544-1b7d-08dd57678878
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 19:47:13.8954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDGw2TvLdqHFtqdQWwr4ebRD/w0c9CypOrfkEA1rWaiDkGdhXJICOP2rTW11RDcp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979
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

Overall lgtm.
A comment and nitpick below.

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Harish
> Kasiviswanathan
> Sent: Wednesday, February 26, 2025 2:23 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH 1/2] drm/amdkfd: Add pm_config_dequeue_wait_counts API
>
> Update pm_update_grace_period() to more cleaner
> pm_config_dequeue_wait_counts(). Previously, grace_period variable was
> overloaded as a variable and a macro, making it inflexible to configure
> additional dequeue wait times.
>
> pm_config_dequeue_wait_counts() now takes in a cmd / variable. This
> allows flexibility to update different dequeue wait times.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 45 +++++++--------
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h | 11 +++-
>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 26 ++++++++-
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 56 ++++++++++++++-----
>  .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 28 ++++++++--
>  6 files changed, 120 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 94b1ac8a4735..cc7465f9562a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -42,6 +42,8 @@
>  /* Size of the per-pipe EOP queue */
>  #define CIK_HPD_EOP_BYTES_LOG2 11
>  #define CIK_HPD_EOP_BYTES (1U << CIK_HPD_EOP_BYTES_LOG2)
> +/* See unmap_queues_cpsch() */
> +#define USE_DEFAULT_GRACE_PERIOD 0xffffffff
>
>  static int set_pasid_vmid_mapping(struct device_queue_manager *dqm,
>                                 u32 pasid, unsigned int vmid);
> @@ -1745,10 +1747,7 @@ static int initialize_cpsch(struct device_queue_ma=
nager
> *dqm)
>
>       init_sdma_bitmaps(dqm);
>
> -     if (dqm->dev->kfd2kgd->get_iq_wait_times)
> -             dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
> -                                     &dqm->wait_times,
> -                                     ffs(dqm->dev->xcc_mask) - 1);
> +     update_dqm_wait_times(dqm);
>       return 0;
>  }
>
> @@ -1844,25 +1843,11 @@ static int start_cpsch(struct device_queue_manage=
r
> *dqm)
>       /* clear hang status when driver try to start the hw scheduler */
>       dqm->sched_running =3D true;
>
> -     if (!dqm->dev->kfd->shared_resources.enable_mes)
> +     if (!dqm->dev->kfd->shared_resources.enable_mes) {
> +             if (pm_config_dequeue_wait_counts(&dqm->packet_mgr,
> +                             KFD_DEQUEUE_WAIT_INIT, 0 /* unused */))
> +                     dev_err(dev, "Setting optimized dequeue wait failed=
. Using
> default values\n");
>               execute_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> USE_DEFAULT_GRACE_PERIOD);
> -
> -     /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
> -     if (amdgpu_emu_mode =3D=3D 0 && dqm->dev->adev->gmc.is_app_apu &&
> -         (KFD_GC_VERSION(dqm->dev) =3D=3D IP_VERSION(9, 4, 3))) {
> -             uint32_t reg_offset =3D 0;
> -             uint32_t grace_period =3D 1;
> -
> -             retval =3D pm_update_grace_period(&dqm->packet_mgr,
> -                                             grace_period);
> -             if (retval)
> -                     dev_err(dev, "Setting grace timeout failed\n");
> -             else if (dqm->dev->kfd2kgd->build_grace_period_packet_info)
> -                     /* Update dqm->wait_times maintained in software */
> -                     dqm->dev->kfd2kgd->build_grace_period_packet_info(
> -                                     dqm->dev->adev, dqm->wait_times,
> -                                     grace_period, &reg_offset,
> -                                     &dqm->wait_times);
>       }
>
>       /* setup per-queue reset detection buffer  */
> @@ -2261,7 +2246,14 @@ static int reset_queues_on_hws_hang(struct
> device_queue_manager *dqm)
>       return r;
>  }
>
> -/* dqm->lock mutex has to be locked before calling this function */
> +/* dqm->lock mutex has to be locked before calling this function
> + *
> + * @grace_period: If USE_DEFAULT_GRACE_PERIOD then default wait time
> + *   for context switch latency. Lower values are used by debugger
> + *   since context switching are triggered at high frequency.
> + *   This is configured by setting CP_IQ_WAIT_TIME2.SCH_WAVE
> + *
> + */
>  static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>                               enum kfd_unmap_queues_filter filter,
>                               uint32_t filter_param,
> @@ -2280,7 +2272,8 @@ static int unmap_queues_cpsch(struct
> device_queue_manager *dqm,
>               return -EIO;
>
>       if (grace_period !=3D USE_DEFAULT_GRACE_PERIOD) {
> -             retval =3D pm_update_grace_period(&dqm->packet_mgr,
> grace_period);
> +             retval =3D pm_config_dequeue_wait_counts(&dqm->packet_mgr,
> +                             KFD_DEQUEUE_WAIT_SET_SCH_WAVE,
> grace_period);
>               if (retval)
>                       goto out;
>       }
> @@ -2324,8 +2317,8 @@ static int unmap_queues_cpsch(struct
> device_queue_manager *dqm,
>
>       /* We need to reset the grace period value for this device */
>       if (grace_period !=3D USE_DEFAULT_GRACE_PERIOD) {
> -             if (pm_update_grace_period(&dqm->packet_mgr,
> -                                     USE_DEFAULT_GRACE_PERIOD))
> +             if (pm_config_dequeue_wait_counts(&dqm->packet_mgr,
> +                             KFD_DEQUEUE_WAIT_RESET, 0 /* unused */))
>                       dev_err(dev, "Failed to reset grace period\n");
>       }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 09ab36f8e8c6..917717cfe9c5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -37,7 +37,6 @@
>
>  #define KFD_MES_PROCESS_QUANTUM              100000
>  #define KFD_MES_GANG_QUANTUM         10000
> -#define USE_DEFAULT_GRACE_PERIOD 0xffffffff
>
>  struct device_process_node {
>       struct qcm_process_device *qpd;
> @@ -359,4 +358,14 @@ static inline int read_sdma_queue_counter(uint64_t _=
_user
> *q_rptr, uint64_t *val
>       /* SDMA activity counter is stored at queue's RPTR + 0x8 location. =
*/
>       return get_user(*val, q_rptr + 1);
>  }
> +
> +static inline void update_dqm_wait_times(struct device_queue_manager *dq=
m)
> +{
> +     if (dqm->dev->kfd2kgd->get_iq_wait_times)
> +             dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
> +                                     &dqm->wait_times,
> +                                     ffs(dqm->dev->xcc_mask) - 1);
> +}
> +
> +
>  #endif /* KFD_DEVICE_QUEUE_MANAGER_H_ */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 4984b41cd372..dd19ae40f0ba 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -396,14 +396,29 @@ int pm_send_query_status(struct packet_manager *pm,
> uint64_t fence_address,
>       return retval;
>  }
>
> -int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_per=
iod)
> +/* pm_config_dequeue_wait_counts: Configure dequeue timer Wait Counts
> + *  by writing to CP_IQ_WAIT_TIME2 registers.
> + *
> + *  @cmd: See emum kfd_config_dequeue_wait_counts_cmd definition
> + *  @value: Depends on the cmd. This parameter is unused for
> + *    KFD_DEQUEUE_WAIT_INIT and KFD_DEQUEUE_WAIT_RESET. For
> + *    KFD_DEQUEUE_WAIT_SET_SCH_WAVE it holds value to be set
> + *
> + */
> +int pm_config_dequeue_wait_counts(struct packet_manager *pm,
> +             enum kfd_config_dequeue_wait_counts_cmd cmd,
> +             uint32_t value)
>  {
>       struct kfd_node *node =3D pm->dqm->dev;
>       struct device *dev =3D node->adev->dev;
>       int retval =3D 0;
>       uint32_t *buffer, size;
>
> -     size =3D pm->pmf->set_grace_period_size;
> +     if (!pm->pmf->config_dequeue_wait_counts ||
> +         !pm->pmf->config_dequeue_wait_counts_size)
> +             return 0;
> +
> +     size =3D pm->pmf->config_dequeue_wait_counts_size;
>
>       mutex_lock(&pm->lock);
>
> @@ -419,13 +434,18 @@ int pm_update_grace_period(struct packet_manager
> *pm, uint32_t grace_period)
>                       goto out;
>               }
>
> -             retval =3D pm->pmf->set_grace_period(pm, buffer, grace_peri=
od);
> +             retval =3D pm->pmf->config_dequeue_wait_counts(pm, buffer,
> +                                                          cmd, value);
>               if (!retval)
>                       retval =3D kq_submit_packet(pm->priv_queue);
>               else
>                       kq_rollback_packet(pm->priv_queue);
>       }
>
> +     /* If default value is modified, cache that value in dqm->wait_time=
s */
> +     if (cmd =3D=3D KFD_DEQUEUE_WAIT_INIT)
> +             update_dqm_wait_times(pm->dqm);

Conditionally store the optimized default value for WAIT_INIT only if confi=
g_dequeue_wait_counts succeeds.

Also does this permanently leave optimized settings in HW different from in=
itial golden settings?
Not sure if this kind of footprint matters in the end.
I'd assume that anything like a gpu reset, driver reload or dynamic partiti=
on change would reset those registers back to non-optimized settings anyway=
s.
Can't really think of a situation where this would be a problem at the mome=
nt ...

> +
>  out:
>       mutex_unlock(&pm->lock);
>       return retval;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index d56525201155..9cb21af1d0af 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -297,23 +297,51 @@ static int pm_map_queues_v9(struct packet_manager
> *pm, uint32_t *buffer,
>       return 0;
>  }
>
> -static int pm_set_grace_period_v9(struct packet_manager *pm,
> +static inline void pm_build_dequeue_wait_counts_packet_info(struct
> packet_manager *pm,
> +                     uint32_t sch_value, uint32_t *reg_offset,
> +                     uint32_t *reg_data)
> +{
> +     pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
> +             pm->dqm->dev->adev,
> +             pm->dqm->wait_times,
> +             sch_value,
> +             reg_offset,
> +             reg_data);
> +}
> +
> +static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
>               uint32_t *buffer,
> -             uint32_t grace_period)
> +             enum kfd_config_dequeue_wait_counts_cmd cmd,
> +             uint32_t value)
>  {
>       struct pm4_mec_write_data_mmio *packet;
>       uint32_t reg_offset =3D 0;
>       uint32_t reg_data =3D 0;
>
> -     pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
> -                     pm->dqm->dev->adev,
> -                     pm->dqm->wait_times,
> -                     grace_period,
> -                     &reg_offset,
> -                     &reg_data);
> -
> -     if (grace_period =3D=3D USE_DEFAULT_GRACE_PERIOD)
> +     switch (cmd) {
> +     case KFD_DEQUEUE_WAIT_INIT:
> +             /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU *=
/
> +             if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev-
> >gmc.is_app_apu &&
> +                (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, 4, 3)=
))
> +                     pm_build_dequeue_wait_counts_packet_info(pm, 1,
> &reg_offset, &reg_data);
> +             else
> +                     return 0;
> +             break;
> +     case KFD_DEQUEUE_WAIT_RESET:
> +             /* function called only to get reg_offset */
> +             pm_build_dequeue_wait_counts_packet_info(pm, 0, &reg_offset=
,
> &reg_data);
>               reg_data =3D pm->dqm->wait_times;
> +             break;
> +
> +     case KFD_DEQUEUE_WAIT_SET_SCH_WAVE:
> +             /* The CP cannot handle value 0 and it will result in
> +              * an infinite grace period being set so set to 1 to preven=
t this.
> +              */
> +             if (!value)
> +                     value =3D 1;
> +             pm_build_dequeue_wait_counts_packet_info(pm, value, &reg_of=
fset,
> &reg_data);
> +             break;

Return -EINVAL on default case for safety.

Jon

> +     }
>
>       packet =3D (struct pm4_mec_write_data_mmio *)buffer;
>       memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
> @@ -415,7 +443,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs =3D=
 {
>       .set_resources          =3D pm_set_resources_v9,
>       .map_queues             =3D pm_map_queues_v9,
>       .unmap_queues           =3D pm_unmap_queues_v9,
> -     .set_grace_period       =3D pm_set_grace_period_v9,
> +     .config_dequeue_wait_counts =3D pm_config_dequeue_wait_counts_v9,
>       .query_status           =3D pm_query_status_v9,
>       .release_mem            =3D NULL,
>       .map_process_size       =3D sizeof(struct pm4_mes_map_process),
> @@ -423,7 +451,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs =3D=
 {
>       .set_resources_size     =3D sizeof(struct pm4_mes_set_resources),
>       .map_queues_size        =3D sizeof(struct pm4_mes_map_queues),
>       .unmap_queues_size      =3D sizeof(struct pm4_mes_unmap_queues),
> -     .set_grace_period_size  =3D sizeof(struct pm4_mec_write_data_mmio),
> +     .config_dequeue_wait_counts_size  =3D sizeof(struct
> pm4_mec_write_data_mmio),
>       .query_status_size      =3D sizeof(struct pm4_mes_query_status),
>       .release_mem_size       =3D 0,
>  };
> @@ -434,7 +462,7 @@ const struct packet_manager_funcs
> kfd_aldebaran_pm_funcs =3D {
>       .set_resources          =3D pm_set_resources_v9,
>       .map_queues             =3D pm_map_queues_v9,
>       .unmap_queues           =3D pm_unmap_queues_v9,
> -     .set_grace_period       =3D pm_set_grace_period_v9,
> +     .config_dequeue_wait_counts =3D pm_config_dequeue_wait_counts_v9,
>       .query_status           =3D pm_query_status_v9,
>       .release_mem            =3D NULL,
>       .map_process_size       =3D sizeof(struct pm4_mes_map_process_aldeb=
aran),
> @@ -442,7 +470,7 @@ const struct packet_manager_funcs
> kfd_aldebaran_pm_funcs =3D {
>       .set_resources_size     =3D sizeof(struct pm4_mes_set_resources),
>       .map_queues_size        =3D sizeof(struct pm4_mes_map_queues),
>       .unmap_queues_size      =3D sizeof(struct pm4_mes_unmap_queues),
> -     .set_grace_period_size  =3D sizeof(struct pm4_mec_write_data_mmio),
> +     .config_dequeue_wait_counts_size  =3D sizeof(struct
> pm4_mec_write_data_mmio),
>       .query_status_size      =3D sizeof(struct pm4_mes_query_status),
>       .release_mem_size       =3D 0,
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index 347c86e1c378..a1de5d7e173a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -304,7 +304,7 @@ const struct packet_manager_funcs kfd_vi_pm_funcs =3D=
 {
>       .set_resources          =3D pm_set_resources_vi,
>       .map_queues             =3D pm_map_queues_vi,
>       .unmap_queues           =3D pm_unmap_queues_vi,
> -     .set_grace_period       =3D NULL,
> +     .config_dequeue_wait_counts     =3D NULL,
>       .query_status           =3D pm_query_status_vi,
>       .release_mem            =3D pm_release_mem_vi,
>       .map_process_size       =3D sizeof(struct pm4_mes_map_process),
> @@ -312,7 +312,7 @@ const struct packet_manager_funcs kfd_vi_pm_funcs =3D=
 {
>       .set_resources_size     =3D sizeof(struct pm4_mes_set_resources),
>       .map_queues_size        =3D sizeof(struct pm4_mes_map_queues),
>       .unmap_queues_size      =3D sizeof(struct pm4_mes_unmap_queues),
> -     .set_grace_period_size  =3D 0,
> +     .config_dequeue_wait_counts_size        =3D 0,
>       .query_status_size      =3D sizeof(struct pm4_mes_query_status),
>       .release_mem_size       =3D sizeof(struct pm4_mec_release_mem)
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 59619f794b6b..4c8026947a73 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1392,6 +1392,24 @@ int pqm_get_queue_checkpoint_info(struct
> process_queue_manager *pqm,
>  #define KFD_FENCE_COMPLETED (100)
>  #define KFD_FENCE_INIT   (10)
>
> +/**
> + * enum kfd_config_dequeue_wait_counts_cmd - Command for configuring
> + *  dequeue wait counts.
> + *
> + * @KFD_DEQUEUE_WAIT_INIT: Set optimized dequeue wait counts for a
> + *   certain ASICs. For these ASICs, this is default value used by RESET
> + * @KFD_DEQUEUE_WAIT_RESET: Reset dequeue wait counts to the optimized
> value
> + *   for certain ASICs. For others set it to default hardware reset valu=
e
> + * @KFD_DEQUEUE_WAIT_SET_SCH_WAVE: Set context switch latency wait
> + *
> + */
> +enum kfd_config_dequeue_wait_counts_cmd {
> +     KFD_DEQUEUE_WAIT_INIT =3D 1,
> +     KFD_DEQUEUE_WAIT_RESET =3D 2,
> +     KFD_DEQUEUE_WAIT_SET_SCH_WAVE =3D 3
> +};
> +
> +
>  struct packet_manager {
>       struct device_queue_manager *dqm;
>       struct kernel_queue *priv_queue;
> @@ -1417,8 +1435,8 @@ struct packet_manager_funcs {
>       int (*unmap_queues)(struct packet_manager *pm, uint32_t *buffer,
>                       enum kfd_unmap_queues_filter mode,
>                       uint32_t filter_param, bool reset);
> -     int (*set_grace_period)(struct packet_manager *pm, uint32_t *buffer=
,
> -                     uint32_t grace_period);
> +     int (*config_dequeue_wait_counts)(struct packet_manager *pm, uint32=
_t
> *buffer,
> +                     enum kfd_config_dequeue_wait_counts_cmd cmd, uint32=
_t
> value);
>       int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
>                       uint64_t fence_address, uint64_t fence_value);
>       int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);
> @@ -1429,7 +1447,7 @@ struct packet_manager_funcs {
>       int set_resources_size;
>       int map_queues_size;
>       int unmap_queues_size;
> -     int set_grace_period_size;
> +     int config_dequeue_wait_counts_size;
>       int query_status_size;
>       int release_mem_size;
>  };
> @@ -1452,7 +1470,9 @@ int pm_send_unmap_queue(struct packet_manager *pm,
>
>  void pm_release_ib(struct packet_manager *pm);
>
> -int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_per=
iod);
> +int pm_config_dequeue_wait_counts(struct packet_manager *pm,
> +                     enum kfd_config_dequeue_wait_counts_cmd cmd,
> +                     uint32_t wait_counts_config);
>
>  /* Following PM funcs can be shared among VI and AI */
>  unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_size=
);
> --
> 2.34.1

