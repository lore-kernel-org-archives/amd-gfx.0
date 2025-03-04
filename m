Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C586C021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 12:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CAB410E59A;
	Tue,  4 Mar 2025 12:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XoH5Q7wa";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A255C10E5A0
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 12:00:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0XdhFgmApfeuZMVJUPlUAhD6UbqnetGudAHfLSfIDTuTWjiYMGIGDmzXwmae6Mre39Qm+MFzGo+0+4T89SlK8RaKLPB5rTDZIpLM0X9vFSy9XtlN0u5pWuGeoRBfgXxYRPZxg/5/f8s94wksSOgXsXGij19OeA+2ss13hca1MrQQ7a/xqk0y3davhFANXpSoksme9wgiVYNAmAXhQMIPZt6wBoaf+kq3ZXOxVcLeGFJJA4pkjqXMm8gpqHaKcWuNuDDCj+fAH056ZvrklsWO9WyfyrwBccK+3CynxqN2vjwXrDZDCe5AXlOssM5VYNd7msv04vXUeiaZ29ue4a1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7TSunszu7rdlByvFOBdJvW63jIF5AHYb+dpOaOb1XM=;
 b=lhkI5yr9XFTHGCSKtOJo7zV/c6fFsf+TxbukZJHGToVmvSVAd4BR10RHKNrgD2oJXHPPEwmzILY06MPqphH3y36B9FqDyQqSJnjGd44muBV78ALEWoV0lRGXX0W+XCd5/ZwHkcnvaE7gubbTLSKJhr+E1ssNIPbRLQxLkHYILPTb5ktEtLXoljyLdMMlUhYV+TaQMhTbNV+s3uiWNN3gFB6r9PrthZ4KT9Se0LsjLGIdEzvjlHAEGLQehHaXiRiXc1pghiUpBVHyO4GEHNm+f4KEE1byu0Yh3lSNmraDAj8ICt5kSaSgJXehfiXd2YhubCLLEu9R998e3JU4TCrb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7TSunszu7rdlByvFOBdJvW63jIF5AHYb+dpOaOb1XM=;
 b=XoH5Q7wa2ZD/zjVvq97i6AA0E5os7Be7Cd3eD1sp5/zc/iGM75phRa4ObUjJchYyD5fzbXajZ+cNyXACejQpWPxVCuzYOvWJvBxrxgAfd6mzNkooILeMp0Rg3KsIlDZ7Ymq0Ycfk/yagdLPG0EbzxjHE7dLpUay/D/KfHOhADKY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 12:00:53 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 12:00:53 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: move the header to amdgpu directory
Thread-Topic: [PATCH] drm/amdgpu/userq: move the header to amdgpu directory
Thread-Index: AQHbihsHLYdSv+ryV0aa0jR65r8VIbNi5dMA
Date: Tue, 4 Mar 2025 12:00:52 +0000
Message-ID: <DS7PR12MB600584A7ADB71CB8F4134422FBC82@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250228195711.2537243-1-alexander.deucher@amd.com>
In-Reply-To: <20250228195711.2537243-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=8de04707-df6a-494f-a955-d3b05fe39f93;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-04T12:00:42Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA0PR12MB8908:EE_
x-ms-office365-filtering-correlation-id: e64ce966-e548-479d-3be1-08dd5b14369a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?SkRJP/sSxIAk4JLrSO4g37/0G/mlw/RFru0OrwqE3rGln8JtQVlO1Kee+OBS?=
 =?us-ascii?Q?+OGnBo/za7CgDKcIKEx/NFv67RI8sni9jfiQIzBP6k8QkqhKzQpastPDlZZc?=
 =?us-ascii?Q?gMC8uReL4Hxo7VCz6xzoTUR04Yp3SD10KK3ESjQkVmQGJ1MKd/fN7+IwS6e+?=
 =?us-ascii?Q?NPQ0qaHgX9vk961G9SKbyL9HIoLILiDBm82HZ2hLtFl2ZZbBYIIvqc670wyk?=
 =?us-ascii?Q?zbz+ZywLD+JNv3M2Ubs7xPiKM0MTqD1kVJRaI1H+VHrVyAI0tOIJ2DKljx/Y?=
 =?us-ascii?Q?Sb1q8mVL/eHUq9lcgior5Q4WARiH6eiADkGasgoAVm7pSLQrPqRSJLvh4/HK?=
 =?us-ascii?Q?l7VX3zlqqomx8n60oSDZFUM2c7uku56pGbojbuV/IUq0v/Nz0gr52tWUBqwk?=
 =?us-ascii?Q?cFih5UBbrjaU0dgPC9DATHQk0r6Iq2MwIur/94iwxsQCNSQ8O09ZtSMD7vsN?=
 =?us-ascii?Q?xfXIk45xC1f0RHQ03yyexClmtaI8jIB1UDrIxNAbhU06oZl+rosrK8Oi3pmc?=
 =?us-ascii?Q?aZwry0tWGlJUqk+Eah0OPHEORekG669T1zsqeOAAXHpyjIExBYR7FszytC7V?=
 =?us-ascii?Q?ePhwg+OwAB4XeQW/F8lStWUbR6cIJYQPhB7P/n2NUDxepgzXUVJaybvnRjP2?=
 =?us-ascii?Q?HGmSSz+GmAU3NC5nrFFdnOd/qB9NDEoVWRZIXDdcvv88zvsce51gwpOXK/Cn?=
 =?us-ascii?Q?WBPqgpdGuzwBtFsazDQfPaod3F12TyKHsPE0BUmBlwz1/1TcjxFfLa/GCKNb?=
 =?us-ascii?Q?+ikivuuOBNHDPYb2pD+MxscYgFdEntKVF2uzUUBzn9xcxuWVrPIFOMXVhOuF?=
 =?us-ascii?Q?swDdMu89X7VSw1gthV//Ny3fejBczFeEx7SjMALMIigz077aotT1HLDzmVsP?=
 =?us-ascii?Q?zBrvWpnFCyFLEw+OBkbQNSfC/vVFOX/H2Al8yad1fH6qhQj6kfBoL53lNcjn?=
 =?us-ascii?Q?gK28poTgsCBoqraK9sGRsrI5YlD+9SLvif27/KNjxBEOlI7I5AOnMVkEQaAQ?=
 =?us-ascii?Q?0YHr2xb4t3dsXgyX0cilitXDbt+uO5e3n287AfYEjw33B7YtYeSkoyV9gS9w?=
 =?us-ascii?Q?qiu+GP/aUEuEIP20WLjSDJfOBEQOxvOu94ItWaWrjwaLs+8ZU5O1vhWVxsNu?=
 =?us-ascii?Q?BY02dJhyFuKQBudGOsIrOdJfV9rVglp1D1+ldDugDBc4FJiegXAmb+bWq4rJ?=
 =?us-ascii?Q?SH2FJL56+ohWzjX2Sbr9bXoT6Aty4pXZHI2F+tiCZzj7LmhmLcg1GFGD+0LM?=
 =?us-ascii?Q?LrgV8b3S2alc5OZxfOON2Rn9YbXv2pukDTxs8mRXJLsUD4M8kvukAC3Z7rfF?=
 =?us-ascii?Q?bLhg2/JqSrCqnEzHV5quZ1Uk2+959ok2YWYLxmrXnNMN3fgsUu5hQgSF3DjK?=
 =?us-ascii?Q?oHpLbQ5NlSNqbU7BSjFlcpgLOcJr2kACuu72EqX3tGDxM7/Av2Lq+KHAB9sI?=
 =?us-ascii?Q?z/nEH4M1NQI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R4o6aiK3fKli4hYZTdN4MZbehZY+eV2Dd7Eb4Yd5S7OOlcWIQJFmQBCdi05F?=
 =?us-ascii?Q?xsuC1rYpRKkxhTGKBGX7DpmXFuhvQfRdvv2POZSKrHyZ4FA9yd2CFUHSjrOJ?=
 =?us-ascii?Q?lMdujI/tZiQvVRsglbW7GAoyNpA86wS9pfwY3sYd63jEZ2TqyUeGoTji+00e?=
 =?us-ascii?Q?nJXBtdBmZ/U/R3RVTwSrbLaGMY7ZghxYSgSw5nF3TYz88gOGL7oSpDov8mw4?=
 =?us-ascii?Q?G8538xzWDyPxiBYbGIA+WJPsYDRPZWNdNA4tx7LgYuhXoHZvAp7iofqqEbW/?=
 =?us-ascii?Q?3MGxqhp3V2sV4JkOTP09Kx17pjZjaHKHCr3t796JiNlk++vbd3ewM6jBd274?=
 =?us-ascii?Q?9xJ0dM4+a+H9mjETrq3v0Q8Ro2V/tuO6M479f5Lo9/koxcRnrH+iPhZmPawN?=
 =?us-ascii?Q?n/5Y1+X35y2BnylJC6frpHuZ4IwrwXtWoXT8udskZ7Hjyw26PtT6arwpYvsq?=
 =?us-ascii?Q?ByOdSOb8Rl0sTvZIM9jCu3lZFaPO1PnGG10zdGQYEBOYlS34KJnbLZVnPMuw?=
 =?us-ascii?Q?vpEXNp135kbdXRCeQHLcxE/YzUzoRuq4gtXfh82RHa134L5r9K0AIGKJZvbu?=
 =?us-ascii?Q?f5H1+Fbb3zwEyxbSQrlITcpPGaIq+FVp6urLMIaaMyWuRoXUHl4MCRPaBHdS?=
 =?us-ascii?Q?nmYeonkze4+7H4GY7UnHsOhsYdFEVVB3kKPOv3IfSMSLaxapkpAorNUjE0JF?=
 =?us-ascii?Q?+4bFR6BvH8crwaeSgOj5xQU2IUqwwQY0qXURi520Oh+UrtZh8BILMxYg6x1Z?=
 =?us-ascii?Q?OZMtZoVbEODsLph5z3JePIMrEn+rdQEixRfhandl5EtCbljM8XQgNujCUdXV?=
 =?us-ascii?Q?SM/zEZx5BB1rtjlnqmTuwL4hDrzG5f7JJx+2+S8/ggxL48eQWNE+2NNis9bQ?=
 =?us-ascii?Q?1ff9663QHhnWMzoAch8VMT9Z/3UzSe/kDIjeB6KBM6w3UE5/AdUriddQYNQe?=
 =?us-ascii?Q?m54BmXAyHjaebU6SsC3iEcQUB8fYKcWjTS98Uu9PbqlViDJJyZSFAz/43nyl?=
 =?us-ascii?Q?dJXr3qHvF9cVK/FOWepylI3DXI3/hfdDrndiDNfX6IzS8BafpiPNQB8qEFTR?=
 =?us-ascii?Q?oy/8yUE6EPEwTb5iefpgNn3t2uJM6In9/5gSus7ehDJ58WC/ikkFYy9aQZyP?=
 =?us-ascii?Q?q1H8hxXB3vJV40KqYSseY/3L5veaTokIcEoZsUvyj7PY0yarxXHTZoVSrVi9?=
 =?us-ascii?Q?N6oGD3FqhEzZHI1gBH0/rfq3Ha6JDitRSA4Q3UTq+KA9AjCNmcnZCoE8vBp3?=
 =?us-ascii?Q?qQOeR4rqx5JlRyO1HZyPOMG6nJFR5LBYKnDgJWiAbV283ETBz7BR8y4K4Kh8?=
 =?us-ascii?Q?hyW4u7hg+4m9v6OHFpKcc1XUb35dkkL2otyZAKCj00tu3Z4HSYEiMzH5G16V?=
 =?us-ascii?Q?VMf3iTYA9VAiE63GiNfEHAECKSyNvNr/qnLfHxbJzB1Si9PbAnQQf188hON1?=
 =?us-ascii?Q?92ShbhR6H1ajR8YY8PVp/tzkgvVXOD6VCBekbMt7mYzDM+iCI5/OZDDxT7Zi?=
 =?us-ascii?Q?NR8svlovt1SCEZSH5S7vMzsDP6wCwXqIYq/U0vX8HL2uwrFRyZTFqMtw0EtC?=
 =?us-ascii?Q?PemKvU5L4SLB2tECBGg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64ce966-e548-479d-3be1-08dd5b14369a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 12:00:52.9675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Lgj8fxWWUmcQgl+FCJc6wZGpkss1BpQ2qUhgh+8MOAE83FjCxdHEpN8UqgAKQRt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, March 1, 2025 3:57 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/userq: move the header to amdgpu directory
>
> To align with other headers.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/{include =3D> amdgpu}/amdgpu_userqueue.h | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)  rename
> drivers/gpu/drm/amd/{include =3D> amdgpu}/amdgpu_userqueue.h (100%)
>
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> rename to drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> --
> 2.48.1

