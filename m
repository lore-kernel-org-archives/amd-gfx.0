Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F266C282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 11:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A032E10E1E9;
	Mon,  3 Mar 2025 11:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dZ0y8r98";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B42B10E1E9
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 11:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3AMxKYa+BmTGach8BnLXuve/sYGgWDMOXQUK1bj0jGMoeygtiNE1jbXS/x2RGnbofa4EKov1ygZ6gTCzD+XMiyEQM/9Cic3xj/ppThdTmHhv+G+g7XphzMo6p96uABByojz4fmcTyN83xqEVc9WSuNKKW3fSUg0/2JDqBdlWhvHTGf0xb3H8yZW4zhpxwThpJsRuCODwjKmSV7YdULeNwTd+QF5RjCb9y2A8rRV2FY4h+gSJ/Ue3MlXuNJEcQLYxLVohK9uWhbl3r5cRivfwVqiZFqk2Cp4dZnv9oauV1x7tr/gBKMQhpOmtDlZyBuJljqWGmXTppyGH7l4D1f7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDUZRyVRKaiEXo6xdn885h2sL8JvqB0AlFNytOyygxQ=;
 b=HsrUtpP5P2rWqjn9qxnDCYxwrDooy8zqzwlsI3jTcFZWA7jIimGHGuFaFImYGMbNUvE3rwRA3Ttph+043gGt7FWukVWZDsYwn7v/ql5ddEaGTeCqLIEFsRKiuQ6ZZ//9ENK7c0tsx7X1MOOxj9WD0TnwBMGRnoEYBGAlWuTDSct2Ayumuf5ZtrkdWF0BmyZRchB0mGzy4LdzqApkEVZjRRWBFnuKPLbfYOBUgs6E8OEO+WYjsdyYnlfUg55+//muDBzkzv//NfX2DlHV7/BucTzGX3gyBHSCMRlyxANbdJ+01X2SCOo6bT2v7dCjTcC01PytNPBJSwSDQeAGQ1W5Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDUZRyVRKaiEXo6xdn885h2sL8JvqB0AlFNytOyygxQ=;
 b=dZ0y8r98GuqguwarwrCoku8VlS+AHZr75F9p8bJh14Wzcjl18u97TWEZd/kKMUQxExKbp/6hCcRg7v3Y7BqmQhLFsoJSZXCyfP4uuDuCih8sO3Im1A7C+d/0K+Dz0wrumr7YpkG7XDfDP/rdLV22B9iT6s/UmMnNPG3/5pjNq9Y=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Mon, 3 Mar 2025 11:59:40 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:59:40 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 5/5] drm/amdgpu/userq: remove BROKEN from config
Thread-Topic: [PATCH 5/5] drm/amdgpu/userq: remove BROKEN from config
Thread-Index: AQHbihqaKLNfKHbIfEeZOLQ5gvKEArNhT7uQ
Date: Mon, 3 Mar 2025 11:59:39 +0000
Message-ID: <DS7PR12MB6005AF0B4E9BC29C3D9E9E9BFBC92@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250228195411.2530147-1-alexander.deucher@amd.com>
 <20250228195411.2530147-5-alexander.deucher@amd.com>
In-Reply-To: <20250228195411.2530147-5-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=75005976-869e-47b9-b45c-2e35fa60868d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-03T11:59:21Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB8190:EE_
x-ms-office365-filtering-correlation-id: 9bd8dffb-d09f-40ba-2c5a-08dd5a4ae0ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Lfxbh4+mazBT7h4ZwIQ5qEzAI4JwrI9riDbZghv8jg/x+llb4T/RkG0B4Lj4?=
 =?us-ascii?Q?dtlUA4qanrnq5OsiJJgvRYamkuBiMBxeEjf6u99yX1U1DC+ltcCk8QKVe0FY?=
 =?us-ascii?Q?1hZM/VNanMbuww39bco+QXuP/zQNA3lZ38no2G3Q5TYhMI/KZMqqnlqxvlKm?=
 =?us-ascii?Q?ePuQ2dZjzGN5xfuECv/Pl7hpHd98/C2IZYV3B1FDHnvCM1mT+x3ORFKsz1M0?=
 =?us-ascii?Q?FVh1U0FTiiuPa2f+Hz0xU0A79f/jlHYOS0EnsJo047nrAPpuKepp72h+TOwv?=
 =?us-ascii?Q?3L2f3MOx0vhWSMCkB7atT2RyICAO8re+fEzFEmt+hvLk2fmGPYW0Mo6y8PWa?=
 =?us-ascii?Q?Qj4Y1zf00saGQmTx3TBlpkuJCVQ/ccKsR2AkC9/5eBEhdM8y+z8vbJ2o22F9?=
 =?us-ascii?Q?zeeQZFUsdAjnMSO+v25x6rZsGx6ZMPqOEGZ/ZR6WBdacwuPbo1TJJV6m0HWp?=
 =?us-ascii?Q?rmMVJvcYahbf4mdSvfnSP8Td8y04fmSszRYFJmtMyoL1z1D1cF3vQcKjz1/0?=
 =?us-ascii?Q?VHfjSw+FH5c2x7NKSrL5toZB/HuG+R6PkhaEc9zW+VaMbcONPkQnu+n6nQfN?=
 =?us-ascii?Q?g2NB1fPsfyIIq4N093jAX/nF8qOWhx/zTsInPMxB8H0F7l6+gRC4F+yrYeXe?=
 =?us-ascii?Q?v0iSDAHg/PMvfzXsZK+S3NX5SacuWhdz+3KMv/KVj9WHeSqSMdHgjD4CaZLA?=
 =?us-ascii?Q?yYUhTGImGILaPay0wf0yJliuxdZM0etbgb//JyN20k6eheVFC/YKj13cNp4q?=
 =?us-ascii?Q?L1HnayXuBUMF5AS5z86Ee+qUKy6htb52a02WARRT9xldI4xq6f6BJSZZhRea?=
 =?us-ascii?Q?rg+NLreo4tAW2EZ4AgVZXlT3B5Zc+omxDyuuElVA2wV8Whe7f5femT4Mu5JF?=
 =?us-ascii?Q?G8lbqjFWu1POlZHXPOY91J9CrgD8yxKO5oUvXh+eQTKY9r8uFLzunno8Z3Ci?=
 =?us-ascii?Q?TbUoaPDrh2b6dmoyvkBIyOYIeqzTuAyw9euLOjw+7UpjKCblC+d2pcoDR7ay?=
 =?us-ascii?Q?yHf1fubDKCtSDEAeun3uxtCiYaZ9jgwYCPGaPcO/TqGJEsLWYd0weRawSFS7?=
 =?us-ascii?Q?1Vv0KFZRnXyPgRpcx/9cPWO0arj0MmO1mfEMmWcEze71KSmhEMQ7cT6CKMpp?=
 =?us-ascii?Q?lDJgbaY7YijIhZ0vZ7OL92vYQKmR40vQGEc725hzF/BfCO23OQU0Q+WDDjDC?=
 =?us-ascii?Q?D2xdjxCAY3RyAk/VPicaPlPRkD4/U4eo/oKMWfJuDT0xmrLF0znNMvOfkI6o?=
 =?us-ascii?Q?SW0L3K612DSH3Zp2DJ8JDwQ54kl9mqOOxI0bLqFnWMmQ1DV1farzpy3rWQDX?=
 =?us-ascii?Q?BACtjM3CQrbNSsAFArjSQSSyGq8s1ktlMUYfOOTNJ+WmU1TFPFVwQeh/DtqP?=
 =?us-ascii?Q?14+pp9hHs776e2wDLsVnMIVnLMu4xhL2lt33WQO+c3kupmTbW9KF+QvNKRhX?=
 =?us-ascii?Q?wXA7obbYbU20bzFHXYONN3esmUb1oGFs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vM+UU5jj+kCE2n8Xz/N2qIF6My3CClnDOZOBhqje5Phoj3GcjIVidfE5WeaO?=
 =?us-ascii?Q?50t1AyK3fmWWyddghznZacUqe4Pz6ALO0zBYzcfy7nnrrH/EZFr8fpveDOFq?=
 =?us-ascii?Q?sAhpIL7fdxzf9Y545nlUyBqKQl7MKUu8kQ3J2iF/If/PMEB78sJjcQpSBm/B?=
 =?us-ascii?Q?3EnK2PvJzI/eNLSPWmnHcCxVASpjnKb1nwSA6PyedZ3vzOoQpmyGAg9qMUAM?=
 =?us-ascii?Q?RYdEtkS7WMtGG6YVEkV2vF+kdzHOxUxr5cx14gi5tz/CJO0TcLo21EqEORPb?=
 =?us-ascii?Q?nOCSq1nNt6r+Il7Ws6VbzW0/q9vsx4MNzyDlvd3nHi+3bMrHuH6u9QfPW4mc?=
 =?us-ascii?Q?52+pVcePmynNJ/uxPVlBCuQYsDnZiBdXm2pvJW54hO+5D3oXJ2rbsVo+YIJq?=
 =?us-ascii?Q?jDd2i/IGfxXu28FNTFGdfzEjqpcDte5C91XeRYoNj6vxxzLM2BFXmPO8yEMS?=
 =?us-ascii?Q?/upW/YlRIlhvqCjI1pC4C8yTE4rfuTGpHP8kFGOb9MWwsRWk7mv6eaTbM8KT?=
 =?us-ascii?Q?Usu9qCXUj4QMSbuH/TVSYgaIRu809/gdzllnBayzkIYBQ/6YaFZ6jt9IBM/A?=
 =?us-ascii?Q?ymP+57pDZ5gZVgLYK0ofvcjrQ46Lk9dcaaF7cYxJpORUgGrBU/M8LZAGnrT8?=
 =?us-ascii?Q?Om4mu6plk6k2/1qNh3SGdxstPljXcNtL6VfCraeBeK6yHXPH0g/f3Rh1pIiS?=
 =?us-ascii?Q?yXNmBv1sZURr5vlyx40lk8t4t7qZk3io1GQLLO+LvG5nuxavk6d1KZ/sO+1c?=
 =?us-ascii?Q?Bgv26IyNKGGPbMsdflrNYTbNdDZhLNN8QturkUYHSy5X689XN2FQwrFw54gf?=
 =?us-ascii?Q?+xd9/3xAI8ZUJHtzg8Mn9b4hjHn42IEDM8x73yiszTCl79GzqNQpQ5wjZwiA?=
 =?us-ascii?Q?+rDMmnM7969yLkvClxui+kxQzFjDzHxngMruqOrV+J4s6mnnBjcB9eiWJMGd?=
 =?us-ascii?Q?5bWB/54SphVIlOWwEvYWuwUtbLgnyGT0JsQZXjiwafNVxJwEi97LAIwql8LR?=
 =?us-ascii?Q?IquECfQZctNg4xA8B3LoxGB9nf7+GMgfRjLvRZb72LUHh8tVFute9RpVw06L?=
 =?us-ascii?Q?f+NZg2j+Ksb0KSSTrZWkuLrNhLqV/ZLMRf5/e3B11JljaMNh8EO4V/5fuXMA?=
 =?us-ascii?Q?TL8XXBcIYT4Nw1lFLoo0vH+vIB/6u6bwuf3AWHIjItXsDzfMKGKGMivkBA27?=
 =?us-ascii?Q?iKaHyb4+7aF37XmxCcNBgfltebvAeWFrIMr5VEXbQIWSFiNwYRE70pIZI6Y0?=
 =?us-ascii?Q?Vm76fvq4ZTBIM3II6NcpUOsyPSLscbyOj4Qwl4+vFA3kNcmp+XjzceiY1iJI?=
 =?us-ascii?Q?Ak5+ouu+UNW61poH2sc9f0kBDtofFObpi8zkhvM9dAy9qfXB5m71l2KniY0Z?=
 =?us-ascii?Q?rNsue83yTJ32LaqKw14oSCrdDraq3pB1xVl7SuUcLFxNQgwZjN6jG5wDRDkz?=
 =?us-ascii?Q?YzvQCDD0CJ7kVvQ/II+6KOfh5xivDOfOix+I4eodkCdsqnvnAwv65w070rWK?=
 =?us-ascii?Q?QCFFvb4p6CNThs+5B4KiFqiUpag7TfHDoH6EvW/uksTVDlRzUBeR94d48YyP?=
 =?us-ascii?Q?neHETL7Q+lenk3fa58U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd8dffb-d09f-40ba-2c5a-08dd5a4ae0ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 11:59:39.9838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Do9iXYrfphHJ7lXeVQWpEPvAvPMZ7sAqhtn8f7uiBYiQPJWq1V+NmOH0p8a+8s11
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190
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

Question: Why use the CONFIG_DRM_AMDGPU_NAVI3X_USERQ to guard all the vario=
us GFX user mode queue enablement paths? It seems more generic and reasonab=
le to use the config name CONFIG_DRM_AMDGPU_NAVI3X_USERQ.

Except for that question, the series patch is Reviewed-by: Prike Liang <Pri=
ke.Liang@amd.com> .

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, March 1, 2025 3:54 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 5/5] drm/amdgpu/userq: remove BROKEN from config
>
> This can be enabled now.  We have the firmware checks in place.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig
> b/drivers/gpu/drm/amd/amdgpu/Kconfig
> index a614320114796..23c014da0f324 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -98,7 +98,6 @@ config DRM_AMDGPU_WERROR  config
> DRM_AMDGPU_NAVI3X_USERQ
>       bool "Enable amdgpu usermode queues"
>       depends on DRM_AMDGPU
> -     depends on BROKEN
>       default n
>       help
>         Choose this option to enable GFX usermode queue support for
> GFX/SDMA/Compute
> --
> 2.48.1

