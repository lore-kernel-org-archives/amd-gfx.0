Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCB4C28B2F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 21:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8EC210E27D;
	Fri, 14 Mar 2025 21:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d7HsuUQa";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F68D10E15C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 21:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+IRn+h4OPDFUkem5KdZ8ThdDTKmQhyTD+dUBtVNyQ1Nwp/HFeFAOnOXeWozjZddxjL9daoFXvXHE2b9AxR8PEjD41OEdeAZ8Y5yf9GuBAyi0dLXrNBBxE6+4b58oZSQ1irFigphHGVojX1govjsAg5liPsbEjCRLat9nzM52cqAfbtrJjyd8oCfDste4EH7oKvzDU6GArQ+m+O07ODcZEaRIcAyW3YW3MEeqR7tn/A2ekjCdEmhvLsHUItOOb6XsXoigtbjqSjfnvIlCLAGMr2zlgorplFeP6T6LY01mQrBxuC0PpeaezLLM+aIRYExemA3tRSyY7QvUNUz0ohgrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3H4eMd65bpSWpXnThHmJw7pq1Q8GpbiwRiRyXJ/itf8=;
 b=U33+3+SA7EL4mYSp3aa5P2fE+XFR/ENCZafSnjVAFAR2FwMjNIQHXSTFWsEG+VQJ2p1W8GA2RpNNTiTXmQNNuv/FvdjEnXE/YGQQahTyAu4PS9U7G0pW2se0RPZe0OTWtsUcNwj+H6ICCsyYb+F/IWvW5pF8kp1ILIgZhVjU7lASE+V+4NoI2UyknHZo0o01tTvHTaIeGM2/kptJx5i6QyFOYeXTmTd0tDfcmNWb35Fq9ZmjyuHOLYpAkMpexxMIqYQ7a4lZiCIdFXJTVNFlQfz7psZ2sT5RYr5/4pY2YVOeB1xdtVnsuEcnsMI+3JffN0EyKBe3gdysW/Zs+cYOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3H4eMd65bpSWpXnThHmJw7pq1Q8GpbiwRiRyXJ/itf8=;
 b=d7HsuUQast8caBCig1k2y3VAVUZ2lLIzh0eIgWd9VzVLkSIeAC+Tu0ePb1HuK5g9EB2Erw9ubBscNMkCAezjrSzJV+FMq4zchMgyYablsY0ERD2XtsW93w8NHLGPez1Gfdf8gIbH0PvlbjQzmrkaRFhuQ3SeINurV3qBFPvIdjw=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by SJ0PR12MB8139.namprd12.prod.outlook.com (2603:10b6:a03:4e8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 21:04:18 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 21:04:17 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdkfd: Update return value of
 config_dequeue_wait_counts
Thread-Topic: [PATCH v2] drm/amdkfd: Update return value of
 config_dequeue_wait_counts
Thread-Index: AQHblR7T8kuCR4t2HEaslYyK5n+jBLNzGIIAgAAF8oA=
Date: Fri, 14 Mar 2025 21:04:17 +0000
Message-ID: <CY8PR12MB7099D2903862C6C0943644BB8CD22@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250314202211.251641-1-Harish.Kasiviswanathan@amd.com>
 <CY8PR12MB743573AF240E36758EED60DA85D22@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB743573AF240E36758EED60DA85D22@CY8PR12MB7435.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=02da4d1b-0448-45fd-b918-53eee9f4fbaa;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-14T20:35:03Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|SJ0PR12MB8139:EE_
x-ms-office365-filtering-correlation-id: e1ef0fb2-6a58-4dcf-3a55-08dd633bc874
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?znYJHzokOt2Lz5OVLRd8DGz/YgYIIe62C1c/czgIm27hwF8xxNsJutB5HTVm?=
 =?us-ascii?Q?92r7NAr1gX/KmQ7OlIE/LsH6jixWI0CkRXlaDEIQnsyHePP+wgr4Ix+fT2hf?=
 =?us-ascii?Q?N3N7Q+ly2zvF9tsGWM+x5PL4vmiRHjKxNbRvLxWWM8Z8SQvmgU0cHcZLh2bB?=
 =?us-ascii?Q?JTlQy7HUgYe4kjIbc4fbgqttQ1D36wpHvDJjyBxNwJoBR3ytuG+JvoCe6bx9?=
 =?us-ascii?Q?FD7KONmhP09p/qQGXjhszYsyTbQ4iheJG64ZQV4ibCYqP4M+vZl3kKoHQ0OD?=
 =?us-ascii?Q?Q/RfZj6I8O41kXTykRM2g4gUNMw5iGJFRn3mC26JdPUopkItjjkXhvyxayhO?=
 =?us-ascii?Q?qejiRRs5/uBj7Dm0UsgwBZR6VFhAkLVIU05OLj1EpYYE9Kx63eNuCSEPujCp?=
 =?us-ascii?Q?ovpGNRrRGTZ8wKT2UijkMm7/idfCax90ZyPGfoAbMiQpY+zdHQOaweEaVKmS?=
 =?us-ascii?Q?u2k+8jrDNzNoc3z4mG/eh8Q/Z3GJBK7YCvQ/kj78FVR5JpXXBXR6uU9Uo/55?=
 =?us-ascii?Q?9HzlkL78SXotW0qh8O6slI8sIGFYsgmpUn4vN30382OXfp+5zDbeJRcBsh1O?=
 =?us-ascii?Q?PmZugcCVtRdB4J79eFRksEOIoDc0gHQy1M3DVrkWqH28iszgQciI4fqgPrJ/?=
 =?us-ascii?Q?8Wq4FNuGC44piuGiwUMugazjuSHA6hHXrlELSWiLwwpvmxVLkssWHi9u7sFd?=
 =?us-ascii?Q?Bog1E9O6WfTfhoxCMkr/DEfi/X/i05HPI+WvJJ/9ttws3a1XIVN/hdTjZ6Kh?=
 =?us-ascii?Q?OUORRP+wsb439ieeQ/NHHTle7WjcrU8XwCXToFLCzHwf0rd+5g1BO03PrBRb?=
 =?us-ascii?Q?++oVg7/pbFcFSbvamwC1CJ7oIWo270IVh7SfO+YwFzAGEtThT1I1LyhAVgWY?=
 =?us-ascii?Q?W31H0XjrhBZpaEnCr1vl48oC7t3limFYgIMbIcpnQt/Aiu7nSzBE0c8j04+3?=
 =?us-ascii?Q?N/dbosgC9rbcbYpdyHoH+EfqI0kd0cAMB6ELYrDMGAxAFX/GwfkzIWsH9Qif?=
 =?us-ascii?Q?3jqAX1LpiaEyOZHQEEes9IR88s0sMbHwknje9D2Bcpx6vuuXSe9ZlZHygrw1?=
 =?us-ascii?Q?al8VGNHOqybbmqsq825Sj1SIdWl4IFP0wEYNMUtJFFYdZ1A4rzVXyBhKuOLp?=
 =?us-ascii?Q?eL61m3RXrnW+gmFRHsN9fAJIR19LPV4wFT9rhwtMPBgeG8DqHyRgsJGtnx4l?=
 =?us-ascii?Q?QmAzLV9to0dtwt1HZl8ns1z9F2o4OacMTsH3DmyzyQWe6nM1RBDta83Ka3mT?=
 =?us-ascii?Q?cWDe1krVLQ4Vr+NjFHkTjp1FQ0WO5063p1Azkq9Avdum+xmKCyOhDxp6IuXn?=
 =?us-ascii?Q?hesSygJW2aNTQM7dy9FCgTcZu5nycxhSb1HGvR15Epcc09cLKEogfTuIdZ0P?=
 =?us-ascii?Q?9GxbOY0ghAepnxYFc51VQjCEiVZTebsFRKD5bb57y0Jqhmbq4r/I/UDR5Aix?=
 =?us-ascii?Q?TEwXazW2p2ZW6OyF7ZIDdBwGMMUg1PaH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iabIBgxgNZqsUkWnKJUFiTAbgM7NJIrgZe5VrjzZg3/rfJu679Vy6V+R8Rs6?=
 =?us-ascii?Q?RW7wuAbdrfCamSoLhYPUFqz9U4eJb4C5AM0v2SaRWo1s/CGQz++gzDD9vfH+?=
 =?us-ascii?Q?RkgFDckuQTH1bpx2cyyMrsRgIln0roW6KIyKg2r6Ht9RKtbvmVZqhqkEf26q?=
 =?us-ascii?Q?cbmcLHv0JQsWzGXsMXZX9d5RG3oxd17pdrQfCjTdH90lB25D3gGEGE+AxLnB?=
 =?us-ascii?Q?lvp8y8UHgKmxA7iJ35pWPRPg7UFFIqnBc21L7YfLXVCxxwXQp4GjdFLuKaG9?=
 =?us-ascii?Q?TcYyY7l4bPgZQuiD6BOTSUBhOEA8dOu0m0402RjwPlSeDR96hDvgWuatkXWp?=
 =?us-ascii?Q?iLPnASTzd9TO4UUCD0rLSkENs91XZLm6je9TPI6fqyOZA5NG81NSrgz5RmrN?=
 =?us-ascii?Q?gT+uSRUMYmC8GXjBNgZVMFJ+wK3Np+8VaWholHBLg7HtquDzjH8qseEUBArT?=
 =?us-ascii?Q?IFkP96ClKWKsEEHPYKucHevlucWnqQGAb/P+QplG5M5g6ovB0nXzfd/Raebn?=
 =?us-ascii?Q?nXtb2S1JtxqzYzgg9hc1dGuVVBW1pd+j87yk08aAQmSPVfVH6ZgsVylPlAEa?=
 =?us-ascii?Q?h1gVP1YFzpTMU0CqWwPxxGC5huZ+XJYHk1/wVprEosACH6j5kru8JBDz34xX?=
 =?us-ascii?Q?G9ABiEeTzvtosH1za/fw5bBKuomSkG0U+mvjXpCpO9LYgFIGmEEj3x8xGZV7?=
 =?us-ascii?Q?qu7n28QzCkztUaJ+Adb0Y0z5ZLqQZZeRXtCkfEkorsUnwuKYVsgornfxm/Iz?=
 =?us-ascii?Q?EUf/xF3TsUb8oc27i0NvYuG2dEGeCw49syMzvlApzUCOZqnNEfz5PQyPd2tg?=
 =?us-ascii?Q?OM0yO2Fqa0qN/px4zgsPPtSn/sJwhQvgJ8dMI11spfGN2U4jAMnOq9dlt5qT?=
 =?us-ascii?Q?d3ZIV3b50gcck6sn3k4EgHmCOYnQWuVmtcklgPbH+Ttv5SakR/xiYspiuZ0y?=
 =?us-ascii?Q?2BZONgY5jBqcHoPE21Fx78NpVonwMV9beNnLzQsPlR7BgZ8+GQGfdCO27hbp?=
 =?us-ascii?Q?rTzAPBtG6BFp9Sb9ANouc9VApKmxPjVHfHJEzMg8S8h7wmZe/0LwaKJbdcol?=
 =?us-ascii?Q?BQ10nzs36Tas2cz4dvHDXJYaqAxqqa3JggG8J7G/0414BfDXDPaCd6HUdMHq?=
 =?us-ascii?Q?4j6dNroycqOSE7aVGQwM0fV5WlDaD5VFM97j7w7ZFU7y1FnX2716D9ZIxiEW?=
 =?us-ascii?Q?lfzWLxuIf3mRcEow4q1z/cFHwKA0+pOkwr+K2Uj+0gar0jQckx7tz/ll0uFw?=
 =?us-ascii?Q?tQMr13JHl48OUFXlo/CCpClRbZEFBm2rd4UhipmS+f59UhbBOMKhAHSkoLsO?=
 =?us-ascii?Q?YBaQ39R0BtU90n4F2UWppVhoYdXpJ9Fz7z0P1jg/UwGS6mrt5imYXS0w8u8I?=
 =?us-ascii?Q?1jyoJ/0PyhsKoDEgcF6YTb6had9+bWNj389kb/s8D+QW3TyS4Xi325ZhFbxn?=
 =?us-ascii?Q?44UwC0G546pBOb08fubyU3XrYSahKo5s+piOCQyNjL6RxmtvLdlxqjiKkijO?=
 =?us-ascii?Q?rl2Xu08Wq8Va3GLofQckNJVgFIgfLru5Mo2ApmckohLF0902pEiQ3aABz3cw?=
 =?us-ascii?Q?LoLMZOvFKnCDaIXtJXQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ef0fb2-6a58-4dcf-3a55-08dd633bc874
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 21:04:17.3488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwYzF6UYlz63vNQn6ZhFoiHq0L902EPvT841hyjDfi2YbboN+ykCj7T8QqbL46ojZxaAlQzpkBaHvp82pogHug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8139
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

-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Friday, March 14, 2025 4:41 PM
To: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; amd-gfx@lists=
.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Update return value of config_dequeue_w=
ait_counts

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Harish
> Kasiviswanathan
> Sent: Friday, March 14, 2025 4:22 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH v2] drm/amdkfd: Update return value of
> config_dequeue_wait_counts
>
> .config_dequeue_wait_counts returns a nop case. Modify return parameter
> to reflect that since the caller also needs to ignore this condition.
>
> v2: Removed redudant code.
>     Tidy up code based on review comments
>
> Fixes: <98a5af8103f> ("drm/amdkfd: Add pm_config_dequeue_wait_counts API"=
)
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 14 ++++----
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 36 +++++++++++--------
>  2 files changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 3f574d82b5fc..502b89639a9f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -436,19 +436,19 @@ int pm_config_dequeue_wait_counts(struct
> packet_manager *pm,
>
>               retval =3D pm->pmf->config_dequeue_wait_counts(pm, buffer,
>                                                            cmd, value);
> -             if (!retval)
> +             if (retval > 0) {
>                       retval =3D kq_submit_packet(pm->priv_queue);
> +
> +                     /* If default value is modified, cache that in dqm-=
>wait_times
> */
> +                     if (!retval && cmd =3D=3D KFD_DEQUEUE_WAIT_INIT)
> +                             update_dqm_wait_times(pm->dqm);
> +             }
>               else
>                       kq_rollback_packet(pm->priv_queue);
>       }
> -
> -     /* If default value is modified, cache that value in dqm->wait_time=
s */
> -     if (!retval && cmd =3D=3D KFD_DEQUEUE_WAIT_INIT)
> -             update_dqm_wait_times(pm->dqm);
> -
>  out:
>       mutex_unlock(&pm->lock);
> -     return retval;
> +     return retval < 0 ? retval : 0;
>  }
>
>  int pm_send_unmap_queue(struct packet_manager *pm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index d440df602393..3c6134d61b2b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -310,6 +310,13 @@ static inline void
> pm_build_dequeue_wait_counts_packet_info(struct packet_manage
>               reg_data);
>  }
>
> +/* pm_config_dequeue_wait_counts_v9: Builds WRITE_DATA packet with
> + *    register/value for configuring dequeue wait counts
> + *
> + * @return: -ve for failure, 0 for nop and +ve for success and buffer is
> + *  filled in with packet
> + *
> + **/
>  static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
>               uint32_t *buffer,
>               enum kfd_config_dequeue_wait_counts_cmd cmd,
> @@ -321,24 +328,25 @@ static int pm_config_dequeue_wait_counts_v9(struct
> packet_manager *pm,
>
>       switch (cmd) {
>       case KFD_DEQUEUE_WAIT_INIT: {
> -             uint32_t sch_wave =3D 0, que_sleep =3D 0;
> -             /* Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default
> 0x40.
> +             uint32_t sch_wave =3D 0, que_sleep =3D 1;
> +
> +             if (KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(9, 4, 1) ||
> +                 KFD_GC_VERSION(pm->dqm->dev) > IP_VERSION(10, 0, 0))
> +                     return 0;

From my last comment, I suggested to put this at the beginning of the non-v=
9 pm_config_dequeue_wait_counts call that calls this function.
Then you don't have to make the return value more complicated than it curre=
ntly is.

[HK]: Ah ok. I didn't really want to put asic specific code in there but in=
 this case code it is fine as you mentioned we have already overloading the=
se functions.

Also KFD_GC_VERSION(pm->dqm->dev) > IP_VERSION(10, 0, 0) is incorrect and s=
hould be >=3D because want to also exclude anything with a major version of=
 10.
[HK]: good catch

Jon

> +
> +             /* For all other gfx9 ASICs,
> +              * Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default
> 0x40.
>                * On a 1GHz machine this is roughly 1 microsecond, which i=
s
>                * about how long it takes to load data out of memory durin=
g
>                * queue connect
>                * QUE_SLEEP: Wait Count for Dequeue Retry.
> +              *
> +              * Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU
>                */
> -             if (KFD_GC_VERSION(pm->dqm->dev) >=3D IP_VERSION(9, 4, 1) &=
&
> -                 KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(10, 0, 0)) {
> -                     que_sleep =3D 1;
> -
> -                     /* Set CWSR grace period to 1x1000 cycle for GFX9.4=
.3 APU
> */
> -                     if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev-
> >gmc.is_app_apu &&
> -                     (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, =
4,
> 3)))
> -                             sch_wave =3D 1;
> -             } else {
> -                     return 0;
> -             }
> +             if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev-
> >gmc.is_app_apu &&
> +                 (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, 4, 3=
)))
> +                     sch_wave =3D 1;
> +
>               pm_build_dequeue_wait_counts_packet_info(pm, sch_wave,
> que_sleep,
>                       &reg_offset, &reg_data);
>
> @@ -377,7 +385,7 @@ static int pm_config_dequeue_wait_counts_v9(struct
> packet_manager *pm,
>
>       packet->data =3D reg_data;
>
> -     return 0;
> +     return sizeof(struct pm4_mec_write_data_mmio);
>  }
>
>  static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffe=
r,
> --
> 2.34.1


