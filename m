Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6087C7EE30
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 03:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3606A10E179;
	Mon, 30 Jun 2025 03:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="at54Kh2v";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ECDE10E179
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 03:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ddh4Ryw1k3znTuFd2sSPnhnyMS8lRoa5AqCe2TSqu0gsBClkcPXbEAocTMD4c8escULj0GbfDrPmQ/gzVOxJjI1Ui8QUxqJ67QM7VlsBTEOdmf625mIpVUv944w7QrikAKhBEPj/Gfywv09owPNXC0xac1t+VlOg9vAwOy/9jw8LGg+zQmY9S4g6wQbrttem9mNvjn22i+fBmu4OEcYG8HivIjUdGR7E4d7Vc9KcJbw7KXUFFCjWA33SWsuhCj2y5GyEnMKKWlb6oeKsUAEzUgacCBTyjkeLc3eWvOvvW+PrDHy2LKG3P5TWVNlJhAFMET4tMai5CR7OoDi4ZMFXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CI/ZuJAy4tbTzg5Xd89O7mu4KPx6UuNys3m8RUkzToY=;
 b=d+nu4rEQ6CzyheOPD/Sx11wLN+HwLqoy6qiA6nMwdwIGHxqNxyisY6KEwsrBaSkhkRn0xnGNN5EGCPrYyt0CGixS4eyeTtCrIQA+IYM9wyabb817WSCDYtdNCYkoP8p8F0x9nwAYEdlKx3j/7DMF623vZqni1RAMmSbrkKcPmaF2s2rkgBT2YSmIOZC39zAGs5QcUzYncQF6kaWIJD6rWR/DJirTgwsWaNzrvzC0CSOL+HU+ctt5u8kcjTqcX/68oRYP2KITiTt/KDa2KSDdFTYYidukEOMZjJG1orwnTEYgW8ZxHg767DKcZroINBL1vnpVqNVg1lpzmezWodtQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI/ZuJAy4tbTzg5Xd89O7mu4KPx6UuNys3m8RUkzToY=;
 b=at54Kh2vX+6FoUuw/s66C1lAvOURAkVpAFe+UyGMXFnhgZ0vL8Qv/RF0yyX96vYQP6RzVF6Y4pOgiwuF3p13Ui+1pHiDgK5BglrZYFeB1Wr+xIbeNyd+3oKmYmCYlx0YKxSYEUGbV+fzWo7Gtw/gsI9cGdmujR5kSfqi92lo/mo=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 03:06:54 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 03:06:54 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, kernel test
 robot <lkp@intel.com>
Subject: RE: [PATCH] drm/amdgpu: Fix code style issue
Thread-Topic: [PATCH] drm/amdgpu: Fix code style issue
Thread-Index: AQHb6Wtv7L/js+8klU66PWHIpoQEsLQbBTKA
Date: Mon, 30 Jun 2025 03:06:54 +0000
Message-ID: <PH7PR12MB87967E0C4251D6578BCE3DFEB046A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250630030214.282854-1-cesun102@amd.com>
In-Reply-To: <20250630030214.282854-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-30T03:06:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS0PR12MB7536:EE_
x-ms-office365-filtering-correlation-id: 6c96a81e-f9e4-41da-b2db-08ddb7832b09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0FlrKXjq/oGgQhYjNANZPHe4v8CDc4F2DvDXyObM4FPN5tsh6H1Ace5ecD08?=
 =?us-ascii?Q?0tniIh2Y3sfUdg+DiFLjalUVitTqyySPeV284GJoSQDV/6mATaYTppgc31f4?=
 =?us-ascii?Q?dzHPVDBcqPXNrBKp6K/T2J+/GkiOwqkJrko2mv9BSo6lUHssU/FHdkidRq59?=
 =?us-ascii?Q?JPSUtng6L6H/qstmYNbc4Fk0P0BQRkNGkU3td06NYTjYV3dTWBFnu2OUF/wT?=
 =?us-ascii?Q?dT9XjFHycO4lveuzEHXesYrkdD4q1is0pB6r9VWNHZ+XfzYZy6CDQuj+vEwC?=
 =?us-ascii?Q?6CQNp8quNdUKgtGu21wCmEvd2On4Vy97osPrWuWrP8T1NcM9wN+19GO0zWR9?=
 =?us-ascii?Q?1UYyMUKU+yhr11kcvF3XlzAl+etB5qie8Vo8jbHrYaOr5Tj7Li5hvKvKc7fl?=
 =?us-ascii?Q?FHeH5V6bu2GHTS8hpkzK9pyH+JxCTlCxMHhCdH9MZWLPUS44a0eU0hhFoN3f?=
 =?us-ascii?Q?pi2g49cx1GvGCcw6uO6+X/bzwa9Jc7oauokOMMro0Ot25ofwNgOPewcr2syF?=
 =?us-ascii?Q?RHP15rHvtu2aIYv96l0SogIGEQuJih3GL37fDAkTcBFXZ5C/xNlMZxPk6tJM?=
 =?us-ascii?Q?qV6Zh+BJw9mXSvWjaEYTacz34p+hoUS8DW/5u3QmjHYokA6Pq24Xa37JlAdB?=
 =?us-ascii?Q?N1hbjyKx8CSBQrhafI6q0zR5/0YUxVszYtriIUZHtQhNBuVOi6UhbCCykDzj?=
 =?us-ascii?Q?k61PvDO28xjSqRSzSB45e0Sd2syoTuui7uugv8A/1LkizYm/X2sGdpe0FNdL?=
 =?us-ascii?Q?H+M51I0AcPrmgFxUMfqzgzrn8sJ16eLQNJBlqXknhkt0y0MPO49HiPtbRcmj?=
 =?us-ascii?Q?OI7llPMUAcCdx16TJpAI9Dd2b1dUzapUzgiR6yCYSHV2wPejahyBUSBZYmoq?=
 =?us-ascii?Q?gajlA2mIaigMOCNFpcu+Hb2j5q32tzkcsnh9VBUUt7jDBl92Du/Q6wRBFf8j?=
 =?us-ascii?Q?4GmOQnjsKJ7XJUzK6/iNOenSx55bmMo+8Ofb7wVrZtMwlTQDtwTs5/MAqzM9?=
 =?us-ascii?Q?LlSxs+UimLVb1UAmmLxg3+dNsNdtF+LEahAtZHK12Hd+Rq6wXTYeo8/vzW9s?=
 =?us-ascii?Q?Z6DeN1iEXb4o9+ff9iMlXELqDO/Nqs9T6wiEkrocAs704eYt0T93OQhJpADq?=
 =?us-ascii?Q?HskBxcYdNPiNL8dfdIM1CykIgFmenmEs3Plutml1A2W2tPtS+kyCyxvfT1hu?=
 =?us-ascii?Q?RSryAr3vqVCdDXEYIl4VtqHfbC4ypcujMFYrTgblCBu6mTGidwu/gDCmiakg?=
 =?us-ascii?Q?F0PgWwqGv3I73FaA7ly4uuBHwz3fgFlzEMF36HaZgFfDmjYmbK4FJmyqobHB?=
 =?us-ascii?Q?WoDtEzyodUmxMZtY3TJXQYxpADk4ipqeyGNBsyyhrKypniWyG8LP5aWaKCaE?=
 =?us-ascii?Q?2lEBo5ZqBqOhjMPdFm45XgFS0jjJa8Eetfe3ydpLk1LvCw7yInOOeHWbGSY5?=
 =?us-ascii?Q?2Mr3h4Wol+tM/BCeXmtLF8zQH/cr4VE9tP+ODk4UhmX74KaCcS+qED6kR/O9?=
 =?us-ascii?Q?Mos2yaqWfLF+CFs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e61e/YWCBB2rxTJz8e8sZEywIy+IMbOt0jRB1HMOTePkCRlj1hczhAJX/EJC?=
 =?us-ascii?Q?wzdrT/65uRP9/6PT/yJ1lZXsXpokuSR9hNitvJ9j/5fYqD3a/yJY7EAp9g0r?=
 =?us-ascii?Q?gl+1ABpnW6mmbiWthFPv4vi11AODaGbd8BympwA1JeyfiB97UNKbKYTWu80Z?=
 =?us-ascii?Q?aLD+mk+Kl2VQjyhCiQ0a6sSO8Vn4p3tG+qQAIhvgpaph4dME2RTpcDa3dOte?=
 =?us-ascii?Q?87em997k5HXTTLs5oaovOwHNaM41VKy7wcmgdPC5TKdZ8tYIu01jWj3T8XBx?=
 =?us-ascii?Q?WqcPGpo7v6+rTdKWLJjmIy9v0b4N2zj37pqK9x2Nnw5bCEF3+7BXpAFFHDRQ?=
 =?us-ascii?Q?iQa59tB05SITVFJ2llFHkup+GnX0XpK60kw5BAKYW7gEbSDIQNJF9WWgM/rf?=
 =?us-ascii?Q?DOWEChpxdDPGlsSZ4xbIKYfqeeaHwNs0xSyEbHdJxbqmk/q34qpSqU9cAFkJ?=
 =?us-ascii?Q?b+mMM5Om0ZjzBk6wZ0dB8XAIZJp2sFLPAYKmoYiJ6nSYlSw1nn0pnnTeQCP1?=
 =?us-ascii?Q?pVDubrl9xSSj4ZnnhEtIXnzXVjxdSjRWvC5U1gleArVOYoWHZh2K89ry5py9?=
 =?us-ascii?Q?h4DXts5mnC7266Hqxl+P+psxkSGwbh812OT44nq1MytI6ToM4JKTdQbRpPig?=
 =?us-ascii?Q?jPWclRRhwrDJfwxartzqoLO1sBm5q054kd4kvtKEnuXuDqPBznchCIPGNa/q?=
 =?us-ascii?Q?5Z3bB3raoEceZoHupN/Nwh6didUSNjWBfgf4b/UCXnzCdFeHSfM3UtytY8gS?=
 =?us-ascii?Q?o8LP1RFy/7poXKUKS24Cw3xWvox3F4XL0W/WhINia7PpDtY9ny4hE9yEnNmw?=
 =?us-ascii?Q?VF+bTE+4w4XtGoF7Ug4/3cr3Eyrc5svG/Jv53XO5j4TjMfHJ5Rb+MATvha/g?=
 =?us-ascii?Q?K+e6MgLeNfPh9yUbmlCJTtTmuTi6Yfyds+OdZ2iA41NI7rEvMysU2DSGtSyn?=
 =?us-ascii?Q?bessg5tbETMTZNL1NS2ivdt+6tjL3x5bug8t+WCeqjIG1ANg+OLmk6ER1Rae?=
 =?us-ascii?Q?03CBDFndbf3vQ6qKoV/SKt0n2MSLugd8YKqv0dRDXpSo9PiHxaQ75HsKCr+d?=
 =?us-ascii?Q?Jjjj0ChqPqql8ZejMItzR75iS6GVQzZYqsXiEFHUseyOp1GhvL9XVwj465wX?=
 =?us-ascii?Q?o+BRPX/mP+DURgsEmI6FP7Zcc85qKkaZUvAc4vycaRp4JfLT6ZJ3y0hlMYKp?=
 =?us-ascii?Q?iDaYfEFocdouqbt5f3SIlab22xm95Bh2705tlPfFv1ofTApcLcgjXinRGwFq?=
 =?us-ascii?Q?p+b4siU4CHew2bn4FgD8LDyT3n76/4XEUSaeC0BMSG1+wPjEJa8mquVTAVcV?=
 =?us-ascii?Q?4FNjcssHvq5LtlmaziHsyye84eR/2XCVGFM17fe9k7oTQQJp67aoeu4HjJlL?=
 =?us-ascii?Q?HbsvPVPyzDDIPVuzJRDAwTm7o09Q3deJcushzYokHBC785wCR4uHAYL6Z/MX?=
 =?us-ascii?Q?0ZHtnyo4rr2DHCXN7u1XLL0qzbntmCcFyO4nxFZn0YXLLpDqPRE98VNZkgtH?=
 =?us-ascii?Q?uH1ItZwv5fpwruwoac86PPEfCJz1opqq1uL1Si7LDma1TunqMxhj5i6XAfRq?=
 =?us-ascii?Q?kReSc1M/+7Rjur8FlAU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c96a81e-f9e4-41da-b2db-08ddb7832b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 03:06:54.7025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpaYNRiz0MPrvHtT705wMz2XY5DdKXGQsn/axk79ZI2PQI9wAnNCtg9eTf7ak9D3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ce Sun
> Sent: Monday, June 30, 2025 11:02 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>; kernel test
> robot <lkp@intel.com>
> Subject: [PATCH] drm/amdgpu: Fix code style issue
>
> cocci warnings: (new ones prefixed by >>)
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6088:8-9: Unneeded
> >> variable: "r". Return "0" on line 6141
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506281925.HHIpXiO7-lkp@i=
ntel.com/
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f13439404760..a9e8ac63a514 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6143,14 +6143,14 @@ static void
> amdgpu_device_recovery_put_reset_lock(struct amdgpu_device *adev,
>       amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
>  }
>
> -static int amdgpu_device_halt_activities(
> +static void amdgpu_device_halt_activities(
>       struct amdgpu_device *adev, struct amdgpu_job *job,
>       struct amdgpu_reset_context *reset_context,
>       struct list_head *device_list, struct amdgpu_hive_info *hive,
>       bool need_emergency_restart)
>  {
>       struct amdgpu_device *tmp_adev =3D NULL;
> -     int i, r =3D 0;
> +     int i;
>
>       /* block all schedulers and reset given job's ring */
>       list_for_each_entry(tmp_adev, device_list, reset_list) { @@ -6202,8=
 +6202,6
> @@ static int amdgpu_device_halt_activities(
>               }
>               atomic_inc(&tmp_adev->gpu_reset_counter);
>       }
> -
> -     return r;
>  }
>
>  static int amdgpu_device_asic_reset(struct amdgpu_device *adev, @@ -6414=
,11
> +6412,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>       /* We need to lock reset domain only once both for XGMI and single =
device */
>       amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>
> -     r =3D amdgpu_device_halt_activities(adev, job, reset_context, &devi=
ce_list,
> +     amdgpu_device_halt_activities(adev, job, reset_context, &device_lis=
t,
>                                        hive, need_emergency_restart);
> -     if (r)
> -             goto reset_unlock;
> -
>       if (need_emergency_restart)
>               goto skip_sched_resume;
>       /*
> @@ -6830,7 +6825,6 @@ pci_ers_result_t amdgpu_pci_error_detected(struct
> pci_dev *pdev, pci_channel_sta
>       struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev);
>       struct amdgpu_reset_context reset_context;
>       struct list_head device_list;
> -     int r =3D 0;
>
>       dev_info(adev->dev, "PCI error: detected callback!!\n");
>
> @@ -6857,14 +6851,12 @@ pci_ers_result_t amdgpu_pci_error_detected(struct
> pci_dev *pdev, pci_channel_sta
>
>               amdgpu_device_recovery_prepare(adev, &device_list, hive);
>               amdgpu_device_recovery_get_reset_lock(adev, &device_list);
> -             r =3D amdgpu_device_halt_activities(adev, NULL, &reset_cont=
ext,
> &device_list,
> -                                      hive, false);
> +             amdgpu_device_halt_activities(adev, NULL, &reset_context,
> &device_list,
> +                                           hive, false);
>               if (hive) {
>                       mutex_unlock(&hive->hive_lock);
>                       amdgpu_put_xgmi_hive(hive);
>               }
> -             if (r)
> -                     return PCI_ERS_RESULT_DISCONNECT;
>               return PCI_ERS_RESULT_NEED_RESET;
>       case pci_channel_io_perm_failure:
>               /* Permanent error, prepare for device removal */
> --
> 2.34.1

