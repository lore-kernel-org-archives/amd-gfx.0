Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F12FCAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 08:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5B4C10E22A;
	Fri, 19 Sep 2025 08:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DkDJuA3/";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010057.outbound.protection.outlook.com
 [40.93.198.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A264510E22A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 08:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjU/kkCgCo8fwx9MLtQy/B9NcE+72G6zrzF5cfOb8OHo+XyyjmJpi/QeGVR5mWmKzZdn5r54L44rIOv9joM1qqlpwThKDArnbWKJ5XEI4FMFwCaHiYHYluxGPsJhAiwJDZVI/kNo4LO2f5JKGr9iR+ZA2aELTcLC7QXZA5GAXAlkJZgSpE8Lx+egNQytbM7bo9j9uQqs3VHY2oZwHbOcpeP/GgL6AlyZsfz+Cn0cwQ5QnNv09Uh3Wm6Lwop6s8VKPvFRnZuNaDrgY33BN48Z7zWIveHseN4d9SacFXKEq7Kpv/iH4uQ4WT/5S4r4LeQrmcGyCzumriTOXzaBVn5C6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jn+QISJSuzAzA6NLzS20Gvr2dhErJNCwOHzoOfCWVUE=;
 b=pgONL98kCjBtwbGZg2/mn6BvJJEhXzMbP3fSgBN9mD/PiGYkI4ueuxrh4/OnmzJYL7chuykg9VjFSu7lBVnQz+bxQPMXp0WMDbW8EsAKFKCcGNna/VpOWkDJ2AA68zzyc65mC3xFoT4oWZw8a6HQ1EX7Xv2HIDJhK+FBX0dO19tVdNnLXqaUYi/VoQg14vIjFJiOsV/2XoA9rQXhvAUB+xd8HZWVFFtHEC7FMAH0G5HFrI/Vbhrs0HxUEeY4P9zfOjEOhN+RJdVX8JzczU+V4oEvktdf0ZlsOl5l8g4K3ap2k/d/xnlqpJDpL1wduopyRmWU/74NzeTtNW0+hghddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn+QISJSuzAzA6NLzS20Gvr2dhErJNCwOHzoOfCWVUE=;
 b=DkDJuA3/qyz47kl62TIu/uag31MHyyfWz0DtrVZclr92EQQpFnFwiDPDdsBka0Ajfzvlarci9G6guMXojnIzw742byRVyCAC9z9+zSekz7S7NRctj9cb2/Z24SBZDd8ysHL2rd3EmxqYeHGPWDW06L0UAp46F56Wg2Pjfl9GKOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:34:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 08:34:29 +0000
Message-ID: <5b347c07-9c99-43cc-a7f2-21d43343028d@amd.com>
Date: Fri, 19 Sep 2025 10:34:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] drm/amdgpu: add userq object va track helpers
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250919081113.2797985-1-Prike.Liang@amd.com>
 <20250919081113.2797985-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250919081113.2797985-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0421.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: c8185862-9b73-42a4-dfbb-08ddf7575950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0Y0TUFQai82VHVQQmlIb3dqbzVtSnFHLzZueWVOQTVEL0FURDlwZVhCWXEv?=
 =?utf-8?B?ZUNybC9Cc0xETjhSeGhONy9BeGNTOGxEdGFtOGUwUVExNHRmNUNMWnBVQ0Fu?=
 =?utf-8?B?bE0vTTliakZTRkJwTDI5V0oxWnJSSUZzRGpGOWhQU3FOVGYwRTRSRS9UMExI?=
 =?utf-8?B?djQvcUtJbW92SXhUeTFzUHozUDRJUlpkVUFxc2tBMHd2K1l4MU1oZ0JWR3Bl?=
 =?utf-8?B?Uk9tUWlEM1lta1VsdGZYaWxjYisyMkpmVG5OSXM4WTFkOS8zTVh2aHd4QmJ3?=
 =?utf-8?B?WGZVL0NqcWhMcU5GcjI1aXFqRHNESmVJcXZmenhzK2dLeWIyZDdPNEdXSUdN?=
 =?utf-8?B?MVVHdy9QRElHbDAyMG5sMWlJc0tHSDRvMmRBTndvRUYwSG9Pd2kxYU5hRXVv?=
 =?utf-8?B?V2RNeU1ZVlpjWmZyQ2RBVlNQSzZBeDJwVXhwc1VuK3NTS01MZU9BTDlJeEFH?=
 =?utf-8?B?bXJLc2xRUy9RSWxCRlY4ZlE5c0Q5ZUNMYmp0MDZoMCtqWlFWMDd4K1ZrdGpF?=
 =?utf-8?B?dTZNY0xaUnVUbzhSckZaRWVudXo2VytYWUN5K2cwbHBuaWtCUnlBNDF0RTIv?=
 =?utf-8?B?L2tLbDFqR1RkcFh4YVdscE5neTlFMjlsZGhoRitpZTZuSXg1VVd2R1pRTXlh?=
 =?utf-8?B?d053cmU2SmFsZTZCV1hZOHpjb2RrUExCQXB1TnFDYXpBN1NwVEJSYk9EbXFz?=
 =?utf-8?B?R3VqblUxOU1ONEFjUDBYQ3ptYmlrYlhWaHZlZSsyaFdDNlNHdmg4NmE0VTI0?=
 =?utf-8?B?NGtBN3pra2M3TmZnRVIzcDBKTGhqcUJsMGdtUlZvNkpiVmlSclY1QUY4Q0s0?=
 =?utf-8?B?SGpkMDZXcmJHM0lQZlBlbWxBNGlYYVNMN0wyRHdrTWh6bS9HYTRyajd2MFd6?=
 =?utf-8?B?azAvOHZvNUtVb3FYdTZBSXF5L2tOZ0wwZDdaSUJCY3Y5bUtpYWFGanBuNGxl?=
 =?utf-8?B?R2QvTGpKUmNSUldqNEYvWmpHc0l3VENtQXI4c1dJWCtkNDU3azZpK1pRS0hB?=
 =?utf-8?B?NDBGeFZyOWNId05pSmwrTWdQUkV1cmVZd1dEQ0hZRGlaZm5wcXJkY04xMVJF?=
 =?utf-8?B?eG9KdCt4Ukh5eXpaNDFsY2NnWWo0VWRmR3lvMExsNVNmOWdCQm9QenFDcXlX?=
 =?utf-8?B?aTRVYUdPMmNYbXUxVWl5ZlRZUHFUbTdPNE1KSW11Wmo4VysyN0tqSnlSdUFS?=
 =?utf-8?B?ZWg1ZXJiWjk0RkJJb3NWSGMxZ0xPWVJOS085Z0lPaVpFWEE5UDloakx0NWtk?=
 =?utf-8?B?OGZ6aXFhdDJlZ1dQa0dCdnNyaVF2d1V6KzBRSngyQytIclFSaGh0TWNaY0d2?=
 =?utf-8?B?TWhXU0ZUYm9oWGRITG80aUtGSW1PZEN2aVlSeDkvN2laT0lqYXpvbGdRNkp2?=
 =?utf-8?B?a2Yva0tBMC9UTFRtZjk0NURpTW1QZjJMTS9OTFBtWDNJOU04YldjNWg2MTQz?=
 =?utf-8?B?UG4xN2JNTE1WMHhoOFlyQlhaRHdGaS94eTNqVW42WXkyOWpSS2FNSDQyTksz?=
 =?utf-8?B?NzR2TDI3bGsxa2RYZ0pLNzVpYm40anIxY250N01TOXRtbm9DWTVsbGN0akxq?=
 =?utf-8?B?VjZSWUZzUlZST1RiU29XOVY2Ykp6Nk9VUU0xVUFtS1phZE1oY0lQbUxjMzJq?=
 =?utf-8?B?QTAxdCtVNzdCUHNkcUpnbnZGQ283Sk00Skp4N1phaEUxYW5vZjF3WTVIbmdJ?=
 =?utf-8?B?MExKbVZDMGxXVENqUTFmazZqaUQya3lrdG1CeEQwZzA5U0FoUHc0MHpVTzZw?=
 =?utf-8?B?Wjh2eDZ3K1BjdGFXUFRYMFduRXprMjVuZjV3eDNWSmZrbk44dFZmV3FTNnYv?=
 =?utf-8?B?alh4OVlBU2NNSTN6QW01MmZQWTVFM3dNamkyRFZNRUFKU2RGK1BENTNwaE5h?=
 =?utf-8?B?V3ZWNDBtRTBzQXpnbFdyKzFuVkhvZkxrMnU4ZzV6Z1A2Uk9IbXlsNG5TdTI5?=
 =?utf-8?Q?MpvTYub8EMY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUxoSng5TG5pcXlmS2pXZVIrQUhoQ0dYZkVJSEtpOVR0R0JlaW45OGlKazZL?=
 =?utf-8?B?aC9OLzNlV0dWMWNoM1M1TGpwcThjMzNyMmNJOUFqblNsSjVzSUg1OGdZVlpi?=
 =?utf-8?B?d2NmSU1vZ1Z2UEJIRWRLbHpQd3hkUFRIZThmZVA4cnFtSTVtT2JucDRnMWZx?=
 =?utf-8?B?TlRFVjlHVThab0Y3cGdHaituOXo3T1RCNEZjVWhuUXlJZEpHRzFWQk9WVlMz?=
 =?utf-8?B?Q20rczAwRWVWbFI5N3IwVld6VzY0N3h5a3k0TElDNzJteFZvb2xBWU1RaTV3?=
 =?utf-8?B?RnVDZ1hHQTZpZ2h0MGFOanhCalJTRlFlaVpUWXp5b0NUc242WlRrRE9xWjll?=
 =?utf-8?B?R3dPQTdBcjNZc2VoazBCR3hScHFOdjQ2UVp6d3FQa3NnVXZOd0dsK0FXWk8y?=
 =?utf-8?B?dTJNTEdSQWZDR25ZVHVncXZkYkNvRGNOSXkxUkNOUi95K1FPcnROZ1lpd2c4?=
 =?utf-8?B?UWwyK0lYN29XZXpYWWx6WklYandSSU5nSDZUUXQ3QzBmbXMzLyszcTFjemZh?=
 =?utf-8?B?VlR6YzkzL3cwWUF3ZExINEMvNjBNeXFUNmpRQ1BNOUV5YXpGNzRiZG01d2Qx?=
 =?utf-8?B?eXhOaDJwa29EVUtmUVhoYk1weHNmQ3ZKS1MzZ2ZsV2JjczlXN0NULzd0My9u?=
 =?utf-8?B?Z05rbWx2VzBJVG4vMUZpa2hVR3RXSGlTTEJaSmFCT3FhRHA3aGU5VmN0T0RX?=
 =?utf-8?B?T3JYNVpsU05wb2VVOEdSVHhHTlFkNUhvcjZuY1I1dUZDTXZ6SE1EY2MwQXhj?=
 =?utf-8?B?ZmRnL25tTUFhRFpLTld0VWJVclM4K3RTYkQxQUxxQmNvTENQc1I0d2RVTHps?=
 =?utf-8?B?N0Jab0hLZ1p3aHlKcTNNVjVDMlhTVmxKeHZQQUE0Z2Z6blFXRngrTTlTVWk1?=
 =?utf-8?B?bTA5OGRtc3JZdzBLKzBVU1NlbENiQmRyUCtFNXd3ekIyRmo5MTU5eHNIL1FR?=
 =?utf-8?B?Y1dpaXZwa3RhVUR2MEZ4THV6WVFCSFNOYmlPbG1BNDZCV1h0Mi9KUVpGQWlq?=
 =?utf-8?B?YVlQY1U0bWVMOC9QTHNyalhHUU9YUnpNTnVsK1lwZjdkNHNtQlVtSmF0OE5p?=
 =?utf-8?B?eFl1c3VqMFczNzdLNUxCY3cxVDZEVUVMTzMyU01UMmJmK3RMWUNtT3BMR09Z?=
 =?utf-8?B?U2VycWRDQTNvTk5JTjZRNitaS0tSSjlTeUZkK0pOd2taaFdCUXIvQ2h3c3Bn?=
 =?utf-8?B?OFRYVVgrMXpLWSt2VHNCclpUQzYrakR0Z085WTFYaWc2eXBJbjBCZ0Jwckli?=
 =?utf-8?B?eXBRa3FLQmNnN0tKQUNVckh5YkM1UC9TWHpGVHhUc0UwYnJUSk5DRmJ0enNq?=
 =?utf-8?B?Q0FLczFtTm82SEJBc2xvY1NjN3pTQ1lSVXZBSjcxbE1ZV2JiVmdnOXNpVmJY?=
 =?utf-8?B?WFZTeHh3a0s1YTNhWlhGRThlTVl6WE5Eb2R4eG1SMUdkZkVDQjhydjEzV2J5?=
 =?utf-8?B?bEUxOUpkRFFaWmtmdDhQcmdwNkFRRWlqd01LRWxvK3hvdFcvMklaRFRPRmNp?=
 =?utf-8?B?WEtqbitrcUg0amF0d3JVSHlDTEtPeG16Zy80YldydlNJQVBxUkhQaVdhMnp4?=
 =?utf-8?B?dlYzZHVhWklDZDhkKzNObVFhbXdlTzQzcU56ZW5GQUNIZjVDNFg3VDdrZklo?=
 =?utf-8?B?VlNudUs0QktXY3pFMVFxOEtaSnQ4SWgwRk1USWJVQmFiN2haRTJUZFRuc3V1?=
 =?utf-8?B?MjJsaC9mcXRlQUFvbndNZnVYRVl5TTd1cWlpNm5rNUllTElXT0p5M2l1YkFx?=
 =?utf-8?B?STd0N0d0TzFwY2VNcUtzTFZqVGtocHZjck9YenEraTlJa2dGU1piWW1ZanBM?=
 =?utf-8?B?Z3BnUTRXVE1LeFppVWNhdnl2SyswOHFzaUttVWdSaGJCTHk2MXBzK0xFR1Rx?=
 =?utf-8?B?cjBEMHRxdERnbGtObjZNblk1elo0bVpwdjZSUEVSZ0VlSWJyaUcwc0lNVUNt?=
 =?utf-8?B?Y3V2Q3RyRzdLMzNTeXdSTnNRSWFBNFFwNlU5TE95ejRxWlV0bUExVjRENnNi?=
 =?utf-8?B?Z1lhbmxvc2d0bWQxWTZmeU4yRXVZOGdGZGpxay96bXZYbWJabFVUY2UwZW1B?=
 =?utf-8?B?Ri9xVFFJQ21nRlVuenNMZG50SnZNTE5xZ3JYVTlMajZpRGhjUVB3VzdBQUMy?=
 =?utf-8?Q?EymBvHaEWlK/xn1ViY9cJbKon?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8185862-9b73-42a4-dfbb-08ddf7575950
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:34:29.2501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzYbh/5mhgfycjocdKYJfmio6hWBZpYhEwjlGJc38GX7A6JPQsZxsCJVyYg/aBCs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994
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



On 19.09.25 10:11, Prike Liang wrote:
> Add the userq object virtual address list_add(),mapped()
> and list_del() helpers for tracking the userq obj va address
> usage.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 71 +++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  | 12 +++-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 ++--
>  4 files changed, 77 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 656b8a931dae..52c2d1731aab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -96,6 +96,7 @@ struct amdgpu_bo_va {
>  	 * if non-zero, cannot unmap from GPU because user queues may still access it
>  	 */
>  	unsigned int			queue_refcount;
> +	atomic_t			userq_va_mapped;

For now that works, but I think we should just make that a flag which is set whenever an userqeue needs to buffer and never cleared.

Regards,
Christian.


>  };
>  
>  struct amdgpu_bo {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index af7753bfa27d..99e51a8ff62a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -44,10 +44,30 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  	return userq_ip_mask;
>  }
>  
> -int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> -				   u64 expected_size)
> +static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
> +					   struct amdgpu_bo_va_mapping *va_map, u64 addr)
> +{
> +	struct amdgpu_userq_va_cursor *va_cursor;
> +	struct userq_va_list;
> +
> +	va_cursor = kzalloc(sizeof(*va_cursor), GFP_KERNEL);
> +	if (!va_cursor)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&va_cursor->list);
> +	va_cursor->gpu_addr = addr;
> +	atomic_set(&va_map->bo_va->userq_va_mapped, 1);
> +	list_add(&va_cursor->list, &queue->userq_va_list);
> +
> +	return 0;
> +
> +}
> +
> +int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
> +				   u64 addr, u64 expected_size)
>  {
>  	struct amdgpu_bo_va_mapping *va_map;
> +	struct amdgpu_vm *vm = queue->vm;
>  	u64 user_addr;
>  	u64 size;
>  	int r = 0;
> @@ -67,15 +87,43 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
>  	/* Only validate the userq whether resident in the VM mapping range */
>  	if (user_addr >= va_map->start  &&
>  	    va_map->last - user_addr + 1 >= size) {
> +		amdgpu_userq_buffer_va_list_add(queue, va_map, user_addr);
>  		amdgpu_bo_unreserve(vm->root.bo);
>  		return 0;
>  	}
>  
> +	r = -EINVAL;
>  out_err:
>  	amdgpu_bo_unreserve(vm->root.bo);
>  	return r;
>  }
>  
> +static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
> +{
> +	struct amdgpu_bo_va_mapping *mapping;
> +	bool r;
> +
> +	if (amdgpu_bo_reserve(vm->root.bo, false))
> +		return false;
> +
> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
> +	if (!IS_ERR_OR_NULL(mapping) && atomic_read(&mapping->bo_va->userq_va_mapped))
> +		r = true;
> +	else
> +		r = false;
> +	amdgpu_bo_unreserve(vm->root.bo);
> +
> +	return r;
> +}
> +
> +static void amdgpu_userq_buffer_va_list_del(struct amdgpu_bo_va_mapping *mapping,
> +					   struct amdgpu_userq_va_cursor *va_cursor)
> +{
> +	atomic_set(&mapping->bo_va->userq_va_mapped, 0);
> +	list_del(&va_cursor->list);
> +	kfree(va_cursor);
> +}
> +
>  static int
>  amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
>  			  struct amdgpu_usermode_queue *queue)
> @@ -184,6 +232,7 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>  	uq_funcs->mqd_destroy(uq_mgr, queue);
>  	amdgpu_userq_fence_driver_free(queue);
>  	idr_remove(&uq_mgr->userq_idr, queue_id);
> +	list_del(&queue->userq_va_list);
>  	kfree(queue);
>  }
>  
> @@ -504,13 +553,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto unlock;
>  	}
>  
> -	/* Validate the userq virtual address.*/
> -	if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args->in.queue_size) ||
> -	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
> -	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
> -		kfree(queue);
> -		goto unlock;
> -	}
> +	INIT_LIST_HEAD(&queue->userq_va_list);
>  	queue->doorbell_handle = args->in.doorbell_handle;
>  	queue->queue_type = args->in.ip_type;
>  	queue->vm = &fpriv->vm;
> @@ -521,6 +564,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	db_info.db_obj = &queue->db_obj;
>  	db_info.doorbell_offset = args->in.doorbell_offset;
>  
> +	/* Validate the userq virtual address.*/
> +	if (amdgpu_userq_input_va_validate(queue, args->in.queue_va, args->in.queue_size) ||
> +	    amdgpu_userq_input_va_validate(queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
> +	    amdgpu_userq_input_va_validate(queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
> +		r = -EINVAL;
> +		kfree(queue);
> +		goto unlock;
> +	}
> +
>  	/* Convert relative doorbell offset into absolute doorbell index */
>  	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
>  	if (index == (uint64_t)-EINVAL) {
> @@ -546,7 +598,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto unlock;
>  	}
>  
> -
>  	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
>  	if (qid < 0) {
>  		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index ded33fe76e1c..f19416feb7ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -48,6 +48,11 @@ struct amdgpu_userq_obj {
>  	struct amdgpu_bo *obj;
>  };
>  
> +struct amdgpu_userq_va_cursor {
> +	uint64_t		gpu_addr;
> +	struct list_head	list;
> +};
> +
>  struct amdgpu_usermode_queue {
>  	int			queue_type;
>  	enum amdgpu_userq_state state;
> @@ -67,6 +72,8 @@ struct amdgpu_usermode_queue {
>  	u32			xcp_id;
>  	int			priority;
>  	struct dentry		*debugfs_queue;
> +
> +	struct list_head	userq_va_list;
>  };
>  
>  struct amdgpu_userq_funcs {
> @@ -137,7 +144,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  						  u32 idx);
>  int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  						   u32 idx);
> -
> -int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> -				   u64 expected_size);
> +int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
> +				   u64 addr, u64 expected_size);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 2db9b2c63693..673dfbbd95e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -298,8 +298,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>  			goto free_mqd;
>  		}
>  
> -		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
> -		    max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE)))
> +		if (amdgpu_userq_input_va_validate(queue, compute_mqd->eop_va,
> +					max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE)))
>  			goto free_mqd;
>  
>  		userq_props->eop_gpu_addr = compute_mqd->eop_va;
> @@ -330,8 +330,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>  		userq_props->tmz_queue =
>  			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
>  
> -		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
> -		    shadow_info.shadow_size))
> +		if (amdgpu_userq_input_va_validate(queue, mqd_gfx_v11->shadow_va,
> +					shadow_info.shadow_size))
>  			goto free_mqd;
>  
>  		kfree(mqd_gfx_v11);
> @@ -350,9 +350,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>  			r = -ENOMEM;
>  			goto free_mqd;
>  		}
> -
> -		if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
> -		    shadow_info.csa_size))
> +		if (amdgpu_userq_input_va_validate(queue, mqd_sdma_v11->csa_va,
> +					shadow_info.csa_size))
>  			goto free_mqd;
>  
>  		userq_props->csa_addr = mqd_sdma_v11->csa_va;

