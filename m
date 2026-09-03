Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFA6C624D6
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 02:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7508B10E065;
	Thu,  3 Sep 2026 02:33:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4DccO1Xf";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BDAE10E065
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 02:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tcqq2E1LAGWdpfCqQZAOHB8berQiIMeE9g5tx32rsFEj1f+SS6iO4AYvasR8sz1t/MXwyE5az7xyFCS1tVY+aVFhHI2rKITjrOk8rOIlAMmoFZgrLlXim/ylwgxVRu8shqOWPutRfjTTbcr4CHdf70eDxu/8u9+q+MaEYxc183akHqLs0C+lFOGzXWbtlEbE13LnAMfjh/pZt4qsr8eNI+sWNEUC+gyEjErPO6YbkyUV5nWxicpJyrGA5mPNf0T4s9Dbhgw0lTaGKH3cRRlpN4dDmkTV9C9D107bFCra+vwAEIfy0ItXBpOOgkM8Kl4di2q1BUm22141nWSoiHVu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jk7QlNatlSsgZ0LJvpXBHxkn4EARz+FdlJVJeVvw0GQ=;
 b=QJN3m1eRWCDWGvgO5SLB2KWpgA5dO2L3ToJc6+tLVGOuXUYdrrNctkcvHtVcCKw0C6laN14R1tdleVzx7U1WaFxpplq13Qct3FrHzslAxoBAJV29btsw9Bw9YvT4WO+Y7iXzKs5O944cCdJN9QesSDhz9bOSguU7AunQjWuPtDq8mWGnCzetf3SVBzhUu+4Z1li3ruvl39UOrV5qP8kcHwYU/q+EU7pE7ZskTzSNI52plN8kQNFCkq/XyHM4O7IN7w6TkpBBl1yMAfUMGMwCi1wp/785aGJUTaBKgF/E4FLDzQ7E59GF7e8ucW2s7qxPgh0/muErK+9K0K8QjhpZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jk7QlNatlSsgZ0LJvpXBHxkn4EARz+FdlJVJeVvw0GQ=;
 b=4DccO1Xf58R/JdMJwDRfW1eeetc2L8ShU4rIrgm3GBAUOUIrhMqhsyKOi+K8kR5yqiwTU8QsH3Jsdnx5O8epHXw8SShOWoGNL5f3Ac78iP4MYfjHIZBuW1AFFV9hQlzfV8NxWm7f1DzPsQO3r30Fhcd+8u8OM8R4Mk5sw4xudYc=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 02:33:32 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 02:33:32 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/gmc12: drop duplicate gmc.init_pte_flags
Thread-Topic: [PATCH] drm/amdgpu/gmc12: drop duplicate gmc.init_pte_flags
Thread-Index: AQHdOyQNCQBjtg3BgEmRw/N6annDBra8It0Q
Date: Thu, 3 Sep 2026 02:33:32 +0000
Message-ID: <DS7PR12MB6005295E8C718195187C5827FBB62@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260902214241.2903550-1-alexander.deucher@amd.com>
In-Reply-To: <20260902214241.2903550-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-03T02:33:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB8494:EE_
x-ms-office365-filtering-correlation-id: c64be6a8-998c-4de1-dd30-08df0963bf19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|18002099003|56012099006|11063799006|22082099003|38070700021;
x-microsoft-antispam-message-info: Iw1Ph1QZfd0M5KCYQCE3PLl5URa5RHmiCv3VWDvXejEUaVKH/ArG4lE9CqRtsxyM5UZBmIjo06z/Nq51wlQpVGXSz3KlGiQ/F5RaickseG2zPgaO5wj5iOJNeXUh8IImBXbGTlg1NfvV2g7T2s5s39T1p0EpShIE2LMrniEOxvrHGQsg7NDFFOYdu2GnVr+DJvSC+/NhmffaLN4lil8v9I6z0MwaBVpmn3eK0ILXBtoZeOjUzPI5HcWCMYZ8V35Ci2hwiEbhsXIWbR834/ZNAxG6dDPQusM1Yes2a+d1hW39t65rON/irZnsJJS3sy9N5kMc7ZNdQwt3x0dItYtg2xE2Ml0T/kyWcw5xu+xGJ0qwHJVML7xH8GN9609oCqYa8KaNW7h38LJV9PswT9rpehJxKhk4QOZPak7H9drdEori1lYSNrnLs2JiVl8OgQolaVMYoZ1oFKhS0CPMO+6nedHsYsHXyUruNloBaXy4qAqTY1d8uNdGP6bMCbEt0v1YHtpWZSleMUvn2i3rhia2iGmmFebaguaxaXo7Bb8G+jMS78Rp1n7RSl3vcX4Q+AOlPIgHcNFsAJrJjTXMOAwglon1HiPSCMSMTkemkvuywIJs5xU+rVFBSCF3rOwm422krG5IYMKdaYeTNYw0G3vCxyZGyVls7Uw4iq9t5kSU95SoBoBYQXz5I+hunKlKuTxPwTHh+qrX9Yw7UVvy2iv3dHIyyxODf0MAI4ZkVdnBtIw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(18002099003)(56012099006)(11063799006)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9RK67D2EHDUPBg4g9l86LEC2Jl9nS89zmXu7VRztkg/j3sTg2yO+EtTuFrWO?=
 =?us-ascii?Q?Ty2H/bGc27g/ReToYcrpB/LaGG7TsQKesRakbBi/usNg664sJgqPh07nIzia?=
 =?us-ascii?Q?WL5vVKxTVlD8fbFMiGDUD7LUrDTYmmznW6YgcvrzlvlNLan9dPTHJdCX+4+3?=
 =?us-ascii?Q?WTGcmYHHh6qh6kXx5kaYxRCslPXWdN+BVBpRbNlcmSTT+DpZI9tUZUNqGiOt?=
 =?us-ascii?Q?ksu3ivIl1EiarcKyoeMTQPkHmcqj0WoRFB194ASdjdhro/bg+gWiDMLkHoC+?=
 =?us-ascii?Q?HHIvLs2mvwPqJWxrjZHuG3jmHbqeDGQAHxa1x3x8vMec5L/ChCb9nm4Vst2U?=
 =?us-ascii?Q?QYTL4pohhsUx0EEAauLmY0itjLht6rT+YWgG9hj2ZFdMcY/j3xPxSiyphwOD?=
 =?us-ascii?Q?T88xHF/s+hPeI3osR0isf7+f1n/bFeDEHI4l0dUJ3N/P5pTIIlexiZPZkAEm?=
 =?us-ascii?Q?GA4HzNGvPA+Oja4z/syoem/OE4DaEWPwUd9ADz3qe0v8L+ue/1NZVw+4RInF?=
 =?us-ascii?Q?NzvZEwFeiVSn9wyazOuFXkQdRZrMvxU+iG3ggcYdyfxm1t/rdKrYyZTgR1OC?=
 =?us-ascii?Q?XJC+uFjXIgiL1q/7wf/46BVmEnDCjMPlIdny6uGkLpvw4yXpDY9VmF/tYsnH?=
 =?us-ascii?Q?EqrcF7x0Y5bEaj4ncAD2rJf8iMoJx3auF6+A14aYkn7XBDclYPFBkmYUbJv8?=
 =?us-ascii?Q?gGUJxEvtqARCeys1X3P88rM6UNA4iwcuy/kB4Nrboh5+LDgCdVd5wXbUNHhG?=
 =?us-ascii?Q?eA/aPU9sZiiPmphUJ7l8BQZmPmY5MUmLtYG3NxOPLoxt1mUQ6yIXUC74Dmf9?=
 =?us-ascii?Q?FxtXT0bllqFF6gUmLJ6jLdfBtEwGcrJ13E94mWV51cmVJL37xlJgkU0VCeVi?=
 =?us-ascii?Q?YlYocc4dUv6NSVEGe/W/llI8MRqEwTqSvOMDjyg8kHq9EERKS+w/VRN+n1hR?=
 =?us-ascii?Q?GVVry+05xrICoAmho+loXPH+JaRLogVKItMAnaREGBHTOx25YgTSCv787GAI?=
 =?us-ascii?Q?Eyd0bdmwv/453Vapg003KqYQFR2JyC3V+3qWfhZA5aL6IFD8xRvF5xqlnb0b?=
 =?us-ascii?Q?MHmC+0391XOutZRnZFkkVy0Zb04WTZYv7N9ljUCUR9TeEBT5AHpp4QtfusN/?=
 =?us-ascii?Q?tX7YUms1o/zJMWvQqS+WB+0RkPp8kxXFdGVMOebLVNf0ML06Ynm3bvWYgS7q?=
 =?us-ascii?Q?FTmWgcoK6o3VZaPHcyUKXDm0Ny0jGRoelFR2Ud4AB3oVYjdOvpjajQng1ZOv?=
 =?us-ascii?Q?UHykLLzTOIenToTYdOROvOv0mUhdcGudQcL6NKHTypjZZZ1UqTWMyTMiCx/F?=
 =?us-ascii?Q?DvwOCdhWCdY7UZNO70NFK8HMwMAe4FvcRl2FPwPvvI5EA6X3f7b+m6qyvWOF?=
 =?us-ascii?Q?kCEQGlrjsKT2NM55Z8l/76KnqvXXHuiSjzCzSpF5I49EqEW7/nk+Dakj+OKR?=
 =?us-ascii?Q?bOIbylGC2g9AFpnIaSRUwzFFma0vzk/kLfdORN8z14Ny4jTizsSOsq7nUqFa?=
 =?us-ascii?Q?jLERftQgSF94tgJfyrn+f6Ty6hafr+I4AxWn6Kc8jMmZQJNc2clVmFWJYkMJ?=
 =?us-ascii?Q?Dyq6jM2can5I0yqVmArxOsg4erZ+MrQL8YYQunmqdNF+wiGHOLOZy/T0nAZN?=
 =?us-ascii?Q?XdISdhRnm3swOrfTwN1nWSZC1SKIlqagV3lNrqHFCUE3xG0JJdMZhHFMVOkC?=
 =?us-ascii?Q?piD012Zxpeoq88f/Ts635ArRsQZqgrIAkCsEJMaMOb5D8xiN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64be6a8-998c-4de1-dd30-08df0963bf19
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 02:33:32.2415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1adMx161/x7lkUrm/spdtJ6rs2rO6nkop8Eodv4MmOXah9TWju3y+twMP/TRUoaj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, September 3, 2026 5:43 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/gmc12: drop duplicate gmc.init_pte_flags
>
> This is now set for all GMC 12.x variants in
> early_init() so drop the duplicate setting.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 0cc73982ed6f9..b6cd6babb035a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -861,7 +861,6 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>               pte_addr_mask =3D 0x000FFFFFFFFFF000ULL; /* 52 bit PA */
>               dma_addr_bits =3D 52;
>               adev->gmc.translate_further =3D adev->vm_manager.num_level =
> 1;
> -             adev->gmc.init_pte_flags =3D AMDGPU_PTE_IS_PTE;
>               break;
>       default:
>               dev_warn(adev->dev, "Unrecognized GC IP version: 0x%08x\n",
> --
> 2.55.0

