Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D98CCF9E5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 04:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A02010E22C;
	Thu, 30 Oct 2025 04:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="14SPQu89";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5154010E22C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 04:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOem76bu5Hlf9O7poPJN4e/WGa2tc2ZvvxntT/nkUdpXYaW+3MBU782rQajhnG9zZQiqHVO2mvQcS0bPrdiQKcWpearxklf2rwDkCJqNEK4dYCSekZbMBgv3FOTPEP5sUPFM+E/E1UZGzatARqyVcKPz5yzznOWft8R5ab7ITNBm7p3Igl3wvtj9PvpnPsDuiotZoIXJw95ykPgtMogETXAa1ESBOrgfSpVnEDRcdKNMAEV4b7Ijqqxmp8JymE6/BFxyHie3UGEkLdiuu5KyVrWxHICmAzCXqKYMc9YQdMci+IjCQPW5Cx1Dfvd5s/7t42uaa7q0fNbOiDL5+9bWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fgzy9h0Vn3sFNdCLseMDXvBsd0comV78hQ/Os5DO/8A=;
 b=K/LGDu1Db/JottzXCewO+pm76mODK9MkbNNlsNU6+XvtY5CV1rLKavk4mKgPRZtuxE/OSwKqEiHoz1C+tk219i7+Ac0ctoBjVJ7cEKfsSi2NEc7z0VlbGQchpNVMrhTLa4g5U99RI8OJigB+30d2A/RNqHxVAixYKf5Kf8+MZhQFIHgTp53bRmkMvL36qORVufsmS1c65FtILj/ee64POdeXj8U+EsFxs3AXRiM4QTehOmsr8mRk43Gj/7jfD0u2qMteLp751xfy6T6uzbPMoT0xNbmepObxG6iT1ec7SoXF9g2rqEoV7zCHMmiGAB7WgqVnBplWpJ07WEUv3wvNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fgzy9h0Vn3sFNdCLseMDXvBsd0comV78hQ/Os5DO/8A=;
 b=14SPQu892+aC5NiWljLc5RdYgKuLtnwhFEgTtUkGVhVXsSqHRvOD33xe9FJNGkZDDFb5nFKubnDARq2+62OHY3G7XjwMOYjKZ0mXWMVuljUUo373yZxuc8FeBQM3nVoR1AZRGfSolirpMqS6bnz5qlTYPVislevXo94dNFCKYqA=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 04:02:43 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 04:02:43 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Clement, Sunday" <Sunday.Clement@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Fix Unchecked Return Values
Thread-Topic: [PATCH v2] drm/amdkfd: Fix Unchecked Return Values
Thread-Index: AQHcSDwPv7Mp5Of3qUKI0WgJSXduWbTaExbQ
Date: Thu, 30 Oct 2025 04:02:43 +0000
Message-ID: <CY8PR12MB74357151C43646E7CCBF88CA85FBA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20251028185235.3192159-1-Sunday.Clement@amd.com>
In-Reply-To: <20251028185235.3192159-1-Sunday.Clement@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-30T04:00:59.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SA3PR12MB8764:EE_
x-ms-office365-filtering-correlation-id: 4cd2621f-7df7-4451-d1cd-08de17692d51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6LWtvBvmnSY4MhAzg8hLnag2ulD+5HcdENHl18kG7ZaASwk+WlVJcbr19whe?=
 =?us-ascii?Q?8w7K4T5fz9kDaf8rTV7+yG1JNTDortBkBeffkv3jrUZx/tVlEGCbDPNmWAaG?=
 =?us-ascii?Q?Qk5TDi2E2C08/8kJbkvkKLMs+Lsfi3jqpoBLfX4I51Rk8uNWer9iGlbHAZiX?=
 =?us-ascii?Q?Mh24R8rTAzUqF9oBMXlpQMjQ28QuukYIVRsOT4A7XMZkm8iNzYWZZcpZVxu1?=
 =?us-ascii?Q?8ewhjxrH4Sg+hM9D+IPqNcpl3IOkwmys4zg069QzYhyKw+LMW6Ie8AJpzZqw?=
 =?us-ascii?Q?CzK58hWqMB/qaB8rgSugt8oQO5eUdyeYfEDE10nxV+Egdrv2fYv947TrdcfY?=
 =?us-ascii?Q?eUOPhahVdNjm7DYiQP0xiJu7ZPg3IfftxV7ZydfhhDgiISb629SaTDiF2GDZ?=
 =?us-ascii?Q?1Q4ZUkwGKP/cl4O/984Bq5t3SM2UL7K+gW/T0so5hdmt1fu5RIYvASvnwiGa?=
 =?us-ascii?Q?u/iVXZiNc4kB9/aJEM+v+mZEhztAxT4ipOAHf9Fgq1qXv8fFhIiDYRT3eG2o?=
 =?us-ascii?Q?MczDM6tUAU0ONAcpNbkPchdyuoO4Wignzq0EmFCtTNumSVYrwCwjo0Gn4bjI?=
 =?us-ascii?Q?kQeiYq88TijBEPZeFixq2NFLdpX1zKc19Bfh+DF54s8D9ycUiQG9f5+x1npp?=
 =?us-ascii?Q?KcjAXHlYE0/bLAQRwNXn9W+b/AskJPlgdDG4B/8Axki1MXpR6qUQRX4tBHZL?=
 =?us-ascii?Q?TXzdQ4Yc2M+R2IIqb1p1gxz878YdnMCH4q4Z7OQ7H0zdBb4oJIo8NU6gwHSD?=
 =?us-ascii?Q?1/079WEmP3f3khO55ogyGp9FUrdhQRwS4mtRmFIwbwW7vZXw96Vb6alkHo6U?=
 =?us-ascii?Q?lmOzMO30nylPMMWL8a0AHwS6pWEdS9YfPjVr2MELI5EgIIKPpBZ8qsA5BEd/?=
 =?us-ascii?Q?Oihx4Pp8Jh9NoeHzoMsuyX7kCyP4xmBr+uOfkSD/u+2t9zX05F3L5X9bRCdt?=
 =?us-ascii?Q?qoi/hFDyOmt+mOXn5S19lWhXXqWI7QODiC7Y+W/fQJdTncHdk9QndMUfO31A?=
 =?us-ascii?Q?IwXOX8tSdSS99fhOjuMuRsyW5JQ9Xrku0FBu16UlumhcSTCH0LHRE7/+MSrL?=
 =?us-ascii?Q?C05yme7+O+xQHarx8dxfLHi56Q3pEVGN1EsKS/DCBN5k7Q7+v8Na9iSuQiUF?=
 =?us-ascii?Q?/JikxTNqeasyHGXG+P6a54Zc1aKmmJwYSRaSmHdrAd3iuNzDx14f1V2NaYZx?=
 =?us-ascii?Q?pqFZfE1/QwsL9N1P2ZZJ29vNxpRLqKMEf7SPioRiPDGuM6e7RgIiWqS5fd5o?=
 =?us-ascii?Q?eJfH5MiZdJmj9GE6FQcBUP6XvSSLHudtWEK5sPKO5B4VVAf0M7AJx7tgeWIS?=
 =?us-ascii?Q?2zy67qB8qPhk7gczphFsRmAJZNBhYvB36mAV49WJB32FSj29nSB8ktEFf0zt?=
 =?us-ascii?Q?UU5qO303u3LHJFbwpq8Y9o/JzAq+1CTmDdsTl5+FNnHJljD1NcyLoBRBwbOj?=
 =?us-ascii?Q?0+EuLCORuKmOUbV2BjEu+6/ctIwryqaRlO9za7wNuKm5MMFc3/Ts4YyFdv1R?=
 =?us-ascii?Q?sEmJPknLXzqoAqR94GoOvV+eWr+fXthEfDUK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h41yVrd+5JtUPGv36a1teBkE9Mb9aSM97z1dwuySUME0PVtnTGcF5GfUn6z8?=
 =?us-ascii?Q?PqQIpCcKHYq8v7KS7cbU+22eMkPYI45+lgJQiyIBWXWhbzYKRY0KgP5X910Q?=
 =?us-ascii?Q?thIf93P1v/J+dZDkXE1R18F1t8dOCVlorcHJRBLFeMtK4h3jKn+1WmcTRFVc?=
 =?us-ascii?Q?ShpRsSYz0RBT9RwKJAddwE3uP8cFNmWifJizJ968hkkXqDEGDceECgA27Gh9?=
 =?us-ascii?Q?fEgEyzHJnGGaOaBlMWB5Dhe9Wtl7WDhf3HpFE+A3DmdWHgMrS+bb9DyB8xRE?=
 =?us-ascii?Q?V8Gt9SVu+Lh4An4ubnLib2sSJ8llfUrw0f0y4PLI0BAGSmHyecBb/L2mJPcc?=
 =?us-ascii?Q?DhTZIPAYCDQot2z50oUYDDTWAZLydw6OHfkfyo1zarI3em8GSv4pKgleO84E?=
 =?us-ascii?Q?lLwDXTRA99ZcE5/AEzSpDDuez57xD7/bk2f3BVzFYRjPkHZxuIulIdQ7bBtr?=
 =?us-ascii?Q?U41eypepFtDsZFZppCzOB61SXfKnE2+/42kT81VH4lBS0aORLfBes9DIk38h?=
 =?us-ascii?Q?sKDRnCpkvltTYsZUwaKC+godL9ULAghNs3WObd2nSvo1Mnpbr0poPHSaHMld?=
 =?us-ascii?Q?vAZTbLp7/0dScoRWqfj7q2plv9BNnFT9gHgqrXplGz9C0UDGPYCaU8SIaaQz?=
 =?us-ascii?Q?LPhUzXanOst/TKGLIc7m7u8M4EZZkh9Ifav6uoQ9Oe3/KsUwwlic2RWDv+UA?=
 =?us-ascii?Q?AQbOSN5XQ5tR810+sx4XdeGL5RZ662WQR73681Fo1GDBIX3SLLdMwJbQfBda?=
 =?us-ascii?Q?M4w1160XdLox+LaQcHbtEBGTxTdXlhuP68I8nwIX8gZvqMjdPJzo5XBoLs2b?=
 =?us-ascii?Q?1wJ1Od5rii/S0GkOz/CbYRt7XcTQNIA6ouwUMzFJvl6/lueAqSTmGHdam0Qd?=
 =?us-ascii?Q?rojKGD6q60DAs6gm8R2KV5M1m7/GnPxVdxxjDsPuTlDyoKViNDY9AVGDPhb4?=
 =?us-ascii?Q?2hdpykzAW8Voo91HvMhPmbW84EtuvYMm/VH4GC0JoObUQEioSqXY44WKf5he?=
 =?us-ascii?Q?xYoRdqDGeNjsJcqkJLqIFDSCslnk3PCj+LoUIIJ41Arsz7C16hqwsQJbfwbQ?=
 =?us-ascii?Q?50df3A+YuxbblkdCzr96OoyWQlHfkuAde+SqhFdz0+EU5UGPvRdyO1GTBRCE?=
 =?us-ascii?Q?0vnvNTU1HWDs/B+/34BUXnWNCio9C2Ea7G4eDphHDRpIWHWJ4TcbiA2jA2Bi?=
 =?us-ascii?Q?/wzl7Vwe5SQ/VkTG+T0Pdrm5BgReKaaWHE1yKkowWMlalCzpXzpVHPSX1VB4?=
 =?us-ascii?Q?qemf5QZOSK2UnaxDTtfCF/i5HKob4sWAgHv6w9KbFvFL6GtuPVvEQ1ON2dId?=
 =?us-ascii?Q?crg7OUoeoGb5oAc0b8WcTsCo9MJ9C9dqT7olQbziVY+W9FjZj3y/50n2uDaf?=
 =?us-ascii?Q?WgH7yzE4EUZIG/YnHh8VssV3HzDZHrq3tqdvgk/RlhRlXZwwY4aZy7Vl8Sne?=
 =?us-ascii?Q?o95vt8gkR2TsSj5MJMXE4IX7XJzASJCT0ScW/zUswWTQAXU0Yfml8Ub/v1DQ?=
 =?us-ascii?Q?egUw9nfncEyJWDxPb0cfBNRlDjJMw1+55dM8WylBVtfSYnzqAErtV5y46D5y?=
 =?us-ascii?Q?x/W8LovMZmfW05okQa0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd2621f-7df7-4451-d1cd-08de17692d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 04:02:43.2301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odekWQt2DejYCwd8TcBAqmkIHm6q70xXpkB8T3mjV7px53FKL+kYZXQ7gK9peAct
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
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

> -----Original Message-----
> From: Clement, Sunday <Sunday.Clement@amd.com>
> Sent: Tuesday, October 28, 2025 2:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Clement, Sunday <Sunday.Clement@amd.com>
> Subject: [PATCH v2] drm/amdkfd: Fix Unchecked Return Values
>
> Properly Check for return values from calls to debug functions in
> runtime_disable().
>
> v2: storing the last non zero returned value from the loop.
>
> Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>

Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 0f0719528bcc..22925df6a791 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2826,7 +2826,7 @@ static int runtime_enable(struct kfd_process *p,
> uint64_t r_debug,
>
>  static int runtime_disable(struct kfd_process *p)
>  {
> -     int i =3D 0, ret;
> +     int i =3D 0, ret =3D 0;
>       bool was_enabled =3D p->runtime_info.runtime_state =3D=3D
> DEBUG_RUNTIME_STATE_ENABLED;
>
>       p->runtime_info.runtime_state =3D DEBUG_RUNTIME_STATE_DISABLED;
> @@ -2863,6 +2863,7 @@ static int runtime_disable(struct kfd_process *p)
>       /* disable ttmp setup */
>       for (i =3D 0; i < p->n_pdds; i++) {
>               struct kfd_process_device *pdd =3D p->pdds[i];
> +             int last_err =3D 0;
>
>               if (kfd_dbg_is_per_vmid_supported(pdd->dev)) {
>                       pdd->spi_dbg_override =3D
> @@ -2872,14 +2873,17 @@ static int runtime_disable(struct kfd_process *p)
>                                       pdd->dev->vm_info.last_vmid_kfd);
>
>                       if (!pdd->dev->kfd->shared_resources.enable_mes)
> -                             debug_refresh_runlist(pdd->dev->dqm);
> +                             last_err =3D debug_refresh_runlist(pdd->dev=
-
> >dqm);
>                       else
> -                             kfd_dbg_set_mes_debug_mode(pdd,
> +                             last_err =3D kfd_dbg_set_mes_debug_mode(pdd=
,
>
> !kfd_dbg_has_cwsr_workaround(pdd->dev));
> +
> +                     if (last_err)
> +                             ret =3D last_err;
>               }
>       }
>
> -     return 0;
> +     return ret;
>  }
>
>  static int kfd_ioctl_runtime_enable(struct file *filep, struct kfd_proce=
ss *p, void
> *data)
> --
> 2.43.0

