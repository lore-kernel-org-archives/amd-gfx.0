Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801B1C9EC93
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 14:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E0D10E3E3;
	Mon, 12 Jan 2026 14:27:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vPX3udYe";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F80310E3E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 14:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGwg6u/aCwyV6KwYCT6OqbK4LotPeUisiolEsVo+eVasVNm5+HqyGBMWsHy9Mi0RAacj9WjV0Ra7gTmTewMn+hO6UK4f0VGbZh/6z1mA9L3HNWb5pXErCAi41+Nvk0ChkGmoKSu1C0h0njeNcPCtTL8Bse3gahyEihMgN2kcSbStgrS+N1ClGSMTVZRQmxCL2zge9xnX0+IIs1+qZTAln779VaEXAIPbio6FDU5C2NVsmsTq+F0zd4HO4aeJ28oJe0pxFD5gKAdJO4+xP4gsyQBcoDnxFalGByPfmvXHE3Pwpsy+589L/5l9lS64hN/SPd1WEtL1EzHZ6YjSw8iiUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdPdvONvi/2z+byVD+6zZe02RmuJUDgFECDFLdQ1iww=;
 b=MI44/R3fnezymv+bP8IJijymkoKF1oe6k0LLpmeknrel/KnV90YRUNwhzfn1AguTSgkeA64zpH3xQASTmaWSoyRbfq8Waq4RHbo4D334etsfpa83gZMEUQJUof/eteIkHuewZKE2EakzZe/l3v2HK0mpwF2hoYdH7IuVt4sQhuTX0ZXpT15LZ+A9vPk311MwPhYKs0S5jyWQbGts40ANTLzMLdNGESv6Rsr+Br46WZUc/gOH/EAw6X0eV+n0u9m4AsOyQq5+6+6NKwwxDCJWqU7Ma/E/zIP6121PE+bIO8+qIvb74g7JEnQMlnvttGjgz80pHMr8aZqansNlfD/I2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdPdvONvi/2z+byVD+6zZe02RmuJUDgFECDFLdQ1iww=;
 b=vPX3udYeGVRgtJhHit2M8eHhCY3H1X/koe8SAIJelHC3mMk6YNjfk7pMKXkrtKYFGBNIcCebYX5Rc1BpAn3ud+xGMG2C/YYSL+DEvOuYMHTKUWB6ixlBydaOSy1xdeZd7UFe6deKEvdW4+p37SV4RYR08aBWczFbCwq1g93+gRA=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 14:27:00 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 14:27:00 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix gfx11 restrictions on debugging
 cooperative launch
Thread-Topic: [PATCH] drm/amdkfd: fix gfx11 restrictions on debugging
 cooperative launch
Thread-Index: AQHcb2+nGfjNk8mJTEm5NR+YPjOVcrVOwAoA
Date: Mon, 12 Jan 2026 14:27:00 +0000
Message-ID: <CY8PR12MB74352CEF0FBAA12EF95627108581A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20251217161015.1666802-1-jonathan.kim@amd.com>
In-Reply-To: <20251217161015.1666802-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-12T14:26:47.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|PH7PR12MB8596:EE_
x-ms-office365-filtering-correlation-id: a932e3d8-4d82-4716-b849-08de51e6a600
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VJhCnpmchnYIZADuTrYr+YqyYMwcC0Dlkhb9mcp4hGyVEbGFAbyZmn9gJj97?=
 =?us-ascii?Q?wJcBklj6m/47LQdywp+JO6vLrBh9dpXAMDKjmSUdBFX0bSpDf9I1y1tmNGLV?=
 =?us-ascii?Q?R8oGlxsiGItSXLLRNBmxmbridyMzMUQ1KHenyKVzcOPLnPX7UapeJKGmRQjQ?=
 =?us-ascii?Q?1GjdQJ1GisgrNwJzXuQS0qgSzEGI1CZRsy0eLpXGD5d1eDMlWNjN/h9jYKSI?=
 =?us-ascii?Q?IJolDb9I7NxKVP9bsT9Ack1zv0TfcLaBZSWVoeFtE6I4jD1wkU7sh98xoSc+?=
 =?us-ascii?Q?mNIwWym6nk3iptJG/Wp7O2sd6sG4dIipoYKGSWb7lYCmbxtO4rSn+sqCaprs?=
 =?us-ascii?Q?3gtAkdDt4Opb5WenG6317H0TksUQnLWcuynGk96JE8rQvB6DoQA8XByJiTLN?=
 =?us-ascii?Q?FzxDk9VDn1jEnAtCVOauer5sdq+1RK/d+p3QN5aeTScRrrJd2o3L16ANelju?=
 =?us-ascii?Q?8Awv+KlCZzLq/5ij5pe9yznheEN4VQ9Milx6VC0bcNTjF62XMppBpZWKzIZf?=
 =?us-ascii?Q?fVP7RFZ8YQTFh/7wCU4OWeaDgB74enKf1UkHA9eJv2MMDCEIv9GGzVc6gShO?=
 =?us-ascii?Q?wP9FvY37r8NF6/78FSwSwVKAmeLaWaYk5hkRyyDghKFUfBENZ1buBQ+JBZbX?=
 =?us-ascii?Q?mYJQNbasUtQEisvkLIfeV/2V6oBEk0znyEE5khcLk1+AGCWPAseRvZ5ePsHG?=
 =?us-ascii?Q?7jrAjxdOuXnNcgBah/bPlKwly4hi6jIUS64fKH8FBKyxKX2clnmDE5dFpuFS?=
 =?us-ascii?Q?MQ7ox10dxKZrITO+dhR97qtRJpdLc4ue6Vi7eUufrU+T4iUrPHp4K5N/p7Pz?=
 =?us-ascii?Q?0TZL/kTQzoPYqJDRp4n6zjq17Up15Yu2b8rO23lwgGIXBcl1TuXbQ0W81p3J?=
 =?us-ascii?Q?79huIbrrMLcBloleFduRK8KSkumHTiQsnJNhPyt0MUC2DDi+jnLRVf+r/c8J?=
 =?us-ascii?Q?JCVUogg9+GACKjaAMiH8DLPooIH86XM8r0XZtO01g6TBeJ7NafqobandVOwq?=
 =?us-ascii?Q?OiVnES7G9LgEJkrhaXfhuaCEOCjdALXKlNpHWV/qrC1Qi8yu6mKE5xlSYTZs?=
 =?us-ascii?Q?JX4bPj5ZNnL6lN5gEmw/97TRS3LUQTLx7QFdVRR6llCirxw5jA9zvwkbRlPK?=
 =?us-ascii?Q?6ngC6ctmzDNU5bF1yUuGPDtxak57i0Ahci4y+JRSQI0F1tQ0cOdD6NOQZd2D?=
 =?us-ascii?Q?4QuI4QNTLbHs/CSnyxAB3MApUouB8DEGmw4DXC4z1YvyQaXOAHDNZtEAHGpd?=
 =?us-ascii?Q?WC+5bFeGFh1IVkG48l8+kUewwsF6I82LlvNgJJt2WWn+hdaClP1e8QfcfWSM?=
 =?us-ascii?Q?6oSjb6O0x0PSY2dGj2m+/PmucOGqE9LFDXx4Ob+IkwviE40+E9qor8E7JT/v?=
 =?us-ascii?Q?+PLNa9M1WY2P97E5vHAoEA/Z7s9JDvKP+ithHhElKSoI/WOJmnl1DFrRkQIG?=
 =?us-ascii?Q?RGtrJ5GDKZU9HTNbiEovasBrFixb/6DZUNpzDu6ojBgC33EyI0Jpk3E+NXxi?=
 =?us-ascii?Q?+1m9AB3Z/pjFLnBW7Si8WJdAVXkfeRu4iFmq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kW8Z9RP6dxcawrqmSxZVxNGwo1MK36Q7W+BwcZ3WdbnCO/Svhx5qfXFGu/v2?=
 =?us-ascii?Q?IMPHvxRVfcDLvG45vqUAeU5fPjzR7VqFoFs7hsBgGmOChjuOtPxNSXQ0bRSU?=
 =?us-ascii?Q?hot1HfUxNq+w8chKV58uzlZvLcsPYzqFBob2V0dWcanpoYnT9wxt2sPggPeh?=
 =?us-ascii?Q?tUsqtUu7V/mth9aSectVCR7Xp1MJ5vpwGjJ9u+veh17MjLnEF65K/cYPoeX8?=
 =?us-ascii?Q?OE7RD3wDIa7s9NZh1G3eZvWTGWPDNCS78nfX4G6d/jSaYB/MfW9dj2b6z13T?=
 =?us-ascii?Q?vcpqsQSjv/IqCMPEa+QGQ+CUTzhcjONXQ0Ats5ptiV76fBgHapY8IqMXEgyA?=
 =?us-ascii?Q?6Bn1bLa7zLOW4HXa41Yzjolhhln5stLcPxiZ9SNlGepprbE5/ZWAhoQx5BPL?=
 =?us-ascii?Q?HFP+GHqk8ITaXRrKYvCWx7sLDApqRa8Q5nK1hyDwZi7GncAnSlAngQlu12l/?=
 =?us-ascii?Q?kenbKSOFrIIBkFnXAXPWhGRT8vTJEWuRLyfXbtjq2pGQ6L48t+F4TPaJP7IO?=
 =?us-ascii?Q?TXkOJxVa/w5KuQp1remADdnoDcYQcgUiH+2JHUmEMX2aK01c3aEup2lBpHPu?=
 =?us-ascii?Q?THdZ33u5UKt4Bn+DII79enGsKv9wtY+inZ4X6mG0VrlYvfyjgNeIxyRZieqA?=
 =?us-ascii?Q?E2TbETC/cpobrlhNyolGAcIfeALFNBEdIzx/It+iNnHTa+Gaxv1eFuVhri5l?=
 =?us-ascii?Q?SlVpXDzIpVxtku+8rAx/kQ6yzEzvTmPHnxIFWJsWh8kK/tyaX3NWww72ifLq?=
 =?us-ascii?Q?S+Liux8SuVSpp4a8Ym9iNpfc0wlWT7tDfvxVflcU5coZEdvvcdweTbG3bBXN?=
 =?us-ascii?Q?2SFir1YAjHrwvJlBQgG1YSlcop1IG1MBuLUUPt0/+esHRL6OU3qCd8vW6eaH?=
 =?us-ascii?Q?bi8NhrFwXTObqwAyZdcgBDwFVfrjHpAlngRdxZIMT5V1RFAHn/D4KTtBTUwL?=
 =?us-ascii?Q?PRnyB8aVEaNLDoOrXJ7cmMzR4fcYUDS38Uar2qZ+Gw8AVIv2qVMP7NUK4w9b?=
 =?us-ascii?Q?cyehiKF/C2XgaDVccexyveg5P4UMd3f435V04WObQLSPWw8l7Cu8uOA7Cd6c?=
 =?us-ascii?Q?6Kw1iTNTDGD/fk2AkCaPUYNi13JOD9jF8I8/v6vmBsuGU3tayi3LaRU2W7vC?=
 =?us-ascii?Q?5ukFZptskbd9r/At4CA1bRbGl+X2kP3NYoJX43aNDdB2bzyczHkn3WBq8+Ca?=
 =?us-ascii?Q?aoChlTRd5DW2bi9KRiA1z+W1I+iAbbW/q4CbUhcgNV0ck7vqhC4cz0CzO8WD?=
 =?us-ascii?Q?xuhB+aG5epCsPoGtjmRTE045yDfGZm9sYi/Wl1X3fqD1Pcskb4n7qYane2SZ?=
 =?us-ascii?Q?/YkytkNadFfXZWk2AfFl4F3JmAXKYH9C9EDY8V3XBQcgflOSFRzAGcC6Lwfo?=
 =?us-ascii?Q?9pFGxj0iSPMWgzQ+GNWHw4csJqgYPEBHEuRIy46Qgj3MJ3iwc4M8EmRp0jBA?=
 =?us-ascii?Q?7euMJkmTArssOJTwiaXP7faJ5klyWloj3Apzg6ajSy2qmGOcrrv8SxgxkBC3?=
 =?us-ascii?Q?2Tt6Tg9zVp3ybxrEG+N9YbLYfRaTdRId0lxVJHyoyP+ZyJzjLHTDMlQELDrk?=
 =?us-ascii?Q?LP5CPvpq9r9FMCr/eviAPm/S9gswp0hiF0O1z9R2kPPcmRt4+072qjZhqRkr?=
 =?us-ascii?Q?R3ksUcFTwHgUaHx6Z2LFgUK6W9+uqRXPIeJ1GlUm2CD4qGCRIGvBIs38vzFn?=
 =?us-ascii?Q?TWnGD4Naj+UD2vQRZbowahbc60RUdYHrUzvmfoQyiKWy47tH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a932e3d8-4d82-4716-b849-08de51e6a600
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 14:27:00.2544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJjdFpzTQLZsJiNq0AsdCqaUCAiGP61uueOGDkbnGnxdZ3lrBzKH42BB6rir6N7j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596
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

Ping for review.

Jon

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Wednesday, December 17, 2025 11:10 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdkfd: fix gfx11 restrictions on debugging cooperat=
ive
> launch
>
> Restrictions on debugging cooperative launch for GFX11 devices should
> align to CWSR work around requirements.
> i.e. devices without the need for the work around should not be subject
> to such restrictions.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index 27aa1a5b120f..fbb751821c69 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -120,8 +120,7 @@ static inline bool kfd_dbg_has_gws_support(struct
> kfd_node *dev)
>                       && dev->kfd->mec2_fw_version < 0x1b6) ||
>               (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 1)
>                       && dev->kfd->mec2_fw_version < 0x30) ||
> -             (KFD_GC_VERSION(dev) >=3D IP_VERSION(11, 0, 0) &&
> -                     KFD_GC_VERSION(dev) < IP_VERSION(12, 0, 0)))
> +             kfd_dbg_has_cwsr_workaround(dev))
>               return false;
>
>       /* Assume debugging and cooperative launch supported otherwise. */
> --
> 2.34.1

