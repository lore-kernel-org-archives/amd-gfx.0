Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8285CC5AD49
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 12:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2522110E50D;
	Mon,  2 Jun 2025 12:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f7X+1k3F";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C1D10E50D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 12:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOVInX6Gu2ej/id9Y48RQ7D7JaCJBajSea/ZekzR8eLH8VTxvJdYvcZg+Spkw8wY9wfNcNo2BtSEIF/KjnwYAfUQ2qFGDEbs6vytt2TbYXCeKWBEpRLJd+u0XDM2u1qhu+z4tHjkD6RQWZrO/jBlKladywUjkTcNnPll0yXs+qPJPS3mLW3zUaRj4+6R7VHPa8FgdQiKDKSIZjdQ1XXQeVZPSoygQ7hgY0qry5VPoug1Kjk9PoMU5dtrEQ/z5MJQYA+VW9pYR1BXuL7AQBJIDB2hJrKNTBTvvUydM6l1zRvG9BkfuUvDfDb4t6GQ0tYPfKzIuHpGyKsZxUmgmiFrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCBkVM/85hPrNJmNPyL6tGzGlg3tA5B6F387kVEvnpY=;
 b=RzMdm0NORcOl4TvIoGa5S7QhF0TQMNLieF891Yyv/PpUzZMKY1CQzbImfBHY8Cx/E0Byvx12CS/+usAPbyveibEffv9CtgO3a5CT2OGDPbtjOrbkCCdAxfAz61Fd2y/9GRnLd/K6qXK+HuoxADaZ58Zx/XDMBV4GiN78M7Rp9oA/r4mLTwPXA9DVJxs89u9rr5GcBRBEmORzvwm2qFXsYVjJalj399keY+aUHV804sgP2i7xFD8LZd0eywMRck1BhH2Q3ytJ3DUT1lBMxnzHKS5ZH2+6iN1T9ez9w15FTXdmzxOxMNLFsNtfnnzJ6S8f9s+N6IKNPyXHqMV3+KlX3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCBkVM/85hPrNJmNPyL6tGzGlg3tA5B6F387kVEvnpY=;
 b=f7X+1k3FkmxsX3NMDWAIfaXmYa5nir1yItnRm7p2h9W3d6jHGFDgFvdDA+Ezt0OpPHrP3bE1DA7Gk7yxForNh4VLobaBcw5bHLCDeQSGi+4N6gvPHCvOX6aaq8JAbhQroFWPs6Kj4rCh8LOtFMrbLuXQJVU9JWIvw+XgN6MFsNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Mon, 2 Jun
 2025 12:27:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 2 Jun 2025
 12:27:25 +0000
Message-ID: <6dc4acf9-197b-46ed-ac80-56b0706c4c15@amd.com>
Date: Mon, 2 Jun 2025 14:27:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Alexander.Deucher@amd.com,
 Owen.Zhang2@amd.com, Qing.Ma@amd.com, Lijo.Lazar@amd.com, Emily.Deng@amd.com
References: <20250529100256.754769-1-guoqing.zhang@amd.com>
 <20250529100256.754769-4-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250529100256.754769-4-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6d2106-e3f4-4b0c-5b9f-08dda1d0d48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3dWdkU0UHJWVXFzRytlenBqMzNXREpQVGM2dTh0MzFMN3grbmJxZ1ZZendW?=
 =?utf-8?B?RmJQTi90S29YWXB3TXoxbU1WMS9KUHJlVnVLeUh6YmFGWWppUkhJVzQyTktZ?=
 =?utf-8?B?alBsaXpReGxXb3BWNHVHemlzMnl1bUpIcEJaeko3NTlSNU5CQlZ3UG5lVWpM?=
 =?utf-8?B?OUxVWEZNZVEwZDFJQWZWYnpYb1Bybkw3RDV6aTArTmY5Y1plV2crVHpibkRL?=
 =?utf-8?B?VlRxM0lnek14M2svbzMvZnlUNVZtWVkvZFRhNC9wc29VYTdTaXkwSy84Zksr?=
 =?utf-8?B?V1hUdjNQVGR2MzVLbmFGeHQ1N2tQamk2a2N2dWpFNkRaOXZCeEVZNHFleFlW?=
 =?utf-8?B?ZExXdS9RbEtRemM2aXlTSUZDMHB3cDljVE1hbFVORG5RVVl3bDZKN2s3QUpB?=
 =?utf-8?B?UFBJaFVqQUZCR0ozN0d1STdnSGw0SUlSUVhsUnZHeEVFbC9lemFtWTlGWUFy?=
 =?utf-8?B?ei9JM1JXS0MxZURpODdyU3NEMHBySjVPQWJEdzZaUGFDZmkyOWo5UFZqSDVj?=
 =?utf-8?B?dUl3M28xK1dwZENiV0lKaTNwVGl1RXF6aU01REQvY1dGUlgycWZiMFMxUGU0?=
 =?utf-8?B?ZjI5cHg2d2lacG9lSDBjKzdHYk5oS0QyaHlUMEV2N3p5cm92Ym9sNEJDdXMx?=
 =?utf-8?B?OTI4R05XdWs4Z29qaHk5VURoU0F5RkNjd0lwRm1GZmJJcExYdklTN2g2L2h2?=
 =?utf-8?B?T0E0ZzVFWGZXSmJjdTRNQzFrSU9ZV1JXNTZ6V2x0ckFLYzVtV2prWXh2ampR?=
 =?utf-8?B?bjdjRWdEbDRYV2xvZ3hobm8xc3p1R1Nia25hNndTZ09JUUZhWXpwMUtYRTdi?=
 =?utf-8?B?WEx4QXRrMjNkVUJIVmdhY3BneEkzbUFjNnkva25HeVhrM0NHWDVlcXpPczFS?=
 =?utf-8?B?MlYzS0pUVG5TSy9aUHJkdHpyMEl1T0k0aHZxYjJhUGZKdGdudSt2OWgyYjRS?=
 =?utf-8?B?WDlnZ0dWRWs0S2dRd0J3enQzNTFDeGpuVU40bjljK2cwcWVMd2dyckJJdXJR?=
 =?utf-8?B?WHR3bzRGY2JkcTQxbGc5VXp1YXZMckxwckFDcERNVWFxNHJJN25hWmdUM2Ra?=
 =?utf-8?B?VTlrb1Z1SExjVUtrSXBmb2FVMm50U0poRXNjclVHcnp5NkJrTGx5U2F2ZDJn?=
 =?utf-8?B?WVZ1aC92WDBYUFJYOHFLTWpoNkhOZXM4UHBsY2JpYVVQaDM2RS91em5mWjZW?=
 =?utf-8?B?VXpablNjRWxrdVRkcW5PT1JZTndtUWJCQkw2MXhpNWpPM2h6eUt1M0hiVkxo?=
 =?utf-8?B?TEZBZlZMMjUzT1NwckVYYVZuNDJKMVBjWXdTM01YUjZveXh2N2RQNjhrbFNk?=
 =?utf-8?B?Q0lMaHY5RUs3NTVsb29zSFdOZGFuK3hOeStmNE9EZCt1YmRsaWdUSnhURUV1?=
 =?utf-8?B?L2VrNUN2WWI3UHNrdnhpbmhtczlDdEhNemp0dk5lQjdacE5lVUkxcWRna3l3?=
 =?utf-8?B?TWFpOFRZVFUraFExSVNOa1N0WVg2TStBWUJnakhuT3UwdWVKU1d5QTRIOGZF?=
 =?utf-8?B?cmJaZ3ZNNldxNGdxUWMrZ284SUVEUnRqS09QOG5zU1dia2dTbm0vWTgvRmNy?=
 =?utf-8?B?RVRtaVVqQXE2dzRoOGM1SnpsczdqV3A3b3UvakFhUExuMFgwTDlaUExzellj?=
 =?utf-8?B?NnpiK0dnSzZQd1hPU3k1RGNBK1RoZ29SbkRSVUU1aTZ0b090MjVmMmNnVk9U?=
 =?utf-8?B?U3BVQjAxdWZBdnNWZzVqcGJ0NmdMdUkwMWZqeTBwRkNKUlFTL1Z1ZHhsMUJJ?=
 =?utf-8?B?LzhjUkNodEkwWlY1RndianVuQUk0R04zb0lGdEUwNFpzZGhLMGFDZ1pVTVF6?=
 =?utf-8?B?UmZ6ZFZISmloQnVuT1I1eEpZamp4WEtqZW5WMVhxc2pmL0s0QU5KQnRYVHJq?=
 =?utf-8?B?UDQvVnhxeWM4U0hjcWVNK09kYVBSSkdoa1QvcURlOEwrQ0x2T3FwNHFiblpJ?=
 =?utf-8?Q?mi9xHZhKfCI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2U0WXJLUkpBYVIyWE44emgvYTR3d3pzT1dzSjNhcnkwWmY2YjYwN0haQjZa?=
 =?utf-8?B?aHloMHdoUFJMZXpyQWF3UHhONW5YaFNIVzdFbDFEeXVjYnpvU2RZSjcwc2ZS?=
 =?utf-8?B?TmMzN0ZkQWExRUl3NXV2a1REMVhuZW9Wb0RZSE51bFlXVUJtMVNLT0V6aWhM?=
 =?utf-8?B?RTVGSzJVbWFBaFA3U1Q0RDVEK2NFNXBReGxITG9UbS9BRnBrT3VPdHdnQTRh?=
 =?utf-8?B?UlhJSEZrbWdoVGx1SGp0ZkVPTldqZ0JzTnp3NFIreExSclpCWjN6T2diTUpy?=
 =?utf-8?B?bm5IYmhVWDIram9GUWtKckZpQlV3dFM0M0J3SCtLVGdCYzMrbU90UmErYTJz?=
 =?utf-8?B?am9nVjRldnFxLzRwREdPb3dsM1NkU3BjelEvcndQRUlsVW1hdC9MVWc3dVdj?=
 =?utf-8?B?RENOTUZDT2x1S3VuSWFkOVQ2ZzUrWDdkZ3k2TytER05UVTM1RU5kS2FabkIz?=
 =?utf-8?B?bkdnNzk2dEpPQ3dqOHJoNHhrT2pMcG5rQkYrcjVlY29LUyt1eW5ZUTI2UmVy?=
 =?utf-8?B?M0VaREdPVmQ2Rm9POVdZOElNd2p3R1V5aG9pM0xHK1JjWUptZXMrcExvVDQy?=
 =?utf-8?B?UWJXMEZDbm9mT0RzaCtpd1RVUVNKcmFwK3lJMFAvd3oyMWhoVWJsQ21pVE84?=
 =?utf-8?B?bk9wa1F2dkFiNGFtVFVLWnVLcHVPMHh3Z2l0cEVzaVZ3Y2ZVdmk2YllHWlpo?=
 =?utf-8?B?emZIYWIwTnE2ZWlmbjNGU3liNk02cDd4R3paV3pZRmJQWUFrc084SVlVRmNX?=
 =?utf-8?B?VnlrU2dHS2NWc0VrNGx3M0xBMGVLYnYxYk4yVEhsUngvZFNMcmZQT2o1OVJF?=
 =?utf-8?B?RUtCYVB3NGJkcFhoaFNqMzdBcWxxSUNuVmo1NEZuaXpvMUNieklzWS9WcFF3?=
 =?utf-8?B?NEFDcWZiYjZ3aGEwSjVtMk42NmwyYklrMU44WS9NSXhZM0IxWVh4cmhETUdm?=
 =?utf-8?B?R1dQak9OaEwxR0k3Y1MrcWdiQW9oUHR3V1JTWjhrU0NTZnNSWU0xMXFuWm92?=
 =?utf-8?B?Sm9iMlR1L3hWSDdNUWhKSXNjOWVtakxBcW1Wam9WNU1zMXZQdWdoMkh4ME9G?=
 =?utf-8?B?c2hYS05va3BhTlVvb0F4Y2Vpc1Z3TkpNT3pxbkkwc3hRL1FGa1FMaWcybWVh?=
 =?utf-8?B?QW5ZbWR4emVPYnJlYnJJcEQ0YXdTQVhEZjdNaVNGb3pjNU5EMldTbDdDN090?=
 =?utf-8?B?ZVMxK01BMGcwTGlpUzVvc3Qvbk5rODJBT3FjUjhTdkovQ3BCODNQZzM2bTNZ?=
 =?utf-8?B?VEVSODlwVnFreWpKa3JRaGJ5NFZYc3NkalFneFVFYVB3U2dnV3JKaWV5V3Ux?=
 =?utf-8?B?ZEFHNW80T2M2ZFkrTFltV3IrTHlTc3VBYTgzb2xxV29PTSs0TlJpaEI0dmd6?=
 =?utf-8?B?MVpiYmpPSEluWHhMZGdwSHdRQmxLT2FoWTludXJRUnJYV3g0T01XOTRuaXdu?=
 =?utf-8?B?UXlDbkQzVmd6d3U2YVRZYytjaUxma3A5R0xkbGQzeVZXZzgvU0JKQUR4Umdn?=
 =?utf-8?B?YkdlSlR6SEVQditTTEsvOWdsc3czYlNHc3h1blh6RThKa1NlN3JQaTEwWTR0?=
 =?utf-8?B?c083VkZtOURDcHJEbTV3Tzg1WEdtWlBOMFcrTnBVZWxyeWxkUi9yUlZSZ1J0?=
 =?utf-8?B?YnpXQysrVUd5N0JUcHJRZnFkbDgwSXNuam1keWVVWDJJcE50QlZUS1lYRUdu?=
 =?utf-8?B?TDZBVWVSWU1SUTFVa1RKSkhKb2hrQVdpV0s4RTBxZmgzUmtuNWpROGlXejJK?=
 =?utf-8?B?b1JzU2RYMjg1VXZiYWJHMjM0NUxOc09Ib0gxemg3YUtPK2pyWXVLSlA2dWVN?=
 =?utf-8?B?NGRHNXVjcjVNS0x0VnVOL2ErUk5yaUlzYmo2bHVheDFERGp6R3VoL29hYy9h?=
 =?utf-8?B?UXdvWXJWaG1rMkVUUDl0YXlKanVIQ0ptZ0wzcExVVXZyUnl3V01BaTFGNnla?=
 =?utf-8?B?N1ZRWWMvSXB5T2NLRFVJalIwaHNhWkZDRGFuTVFRY2puTVVvb1RMSTlXSUZt?=
 =?utf-8?B?ekZ6WFJHaUFML0VVY0ZKbmZkZzFKVWdPZm5JUXptTGwvTG5WQU4vcVBaNzNR?=
 =?utf-8?B?dXo3c2JvS2oyQ0ZMZ1VHa0xhdkV5N3ZWekYyNjR2a2Q5bzQxeWYvQVNCVDM3?=
 =?utf-8?Q?05vGkV+YUariqTCOYnDMKbjpL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6d2106-e3f4-4b0c-5b9f-08dda1d0d48f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 12:27:25.1349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYNgS8P8HQzTFw9CrbecWxn7Yz/xh4olq+gJXW7XC+xBCH6SaxNlPaijUY/dLr2u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283
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

On 5/29/25 12:02, Samuel Zhang wrote:
> When switching to new GPU index after hibernation and then resume,
> VRAM offset of each VRAM BO will be changed, and the cached gpu
> addresses needed to updated.
> 
> This is to enable pdb0 and switch to use pdb0-based virtual gpu
> address by default in amdgpu_bo_create_reserved(). since the virtual
> addresses do not change, this can avoid the need to update all
> cached gpu addresses all over the codebase.
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 33 +++++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  8 +++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  8 +++---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  6 +++--
>  5 files changed, 40 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d1fa5e8e3937..73ff47403743 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -38,6 +38,13 @@
>  #include <drm/drm_drv.h>
>  #include <drm/ttm/ttm_tt.h>
>  
> +static const u64 four_gb = 0x100000000ULL;
> +
> +bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev)
> +{
> +	return adev->gmc.xgmi.connected_to_cpu || amdgpu_virt_xgmi_migrate_enabled(adev);
> +}
> +
>  /**
>   * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
>   *
> @@ -251,10 +258,20 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
>  	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
>  	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
> -	mc->gart_start = hive_vram_end + 1;
> +	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
> +	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
>  	mc->gart_end = mc->gart_start + mc->gart_size - 1;
> -	mc->fb_start = hive_vram_start;
> -	mc->fb_end = hive_vram_end;
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
> +		/* set mc->vram_start to 0 to switch the returned GPU address of
> +		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
> +		 */
> +		mc->vram_start = 0;
> +		mc->vram_end = mc->vram_start + mc->mc_vram_size - 1;
> +		mc->visible_vram_size = min(mc->visible_vram_size, mc->real_vram_size);
> +	} else {
> +		mc->fb_start = hive_vram_start;
> +		mc->fb_end = hive_vram_end;
> +	}
>  	dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
>  			mc->mc_vram_size >> 20, mc->vram_start,
>  			mc->vram_end, mc->real_vram_size >> 20);
> @@ -276,7 +293,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>  			      enum amdgpu_gart_placement gart_placement)
>  {
> -	const uint64_t four_gb = 0x100000000ULL;
>  	u64 size_af, size_bf;
>  	/*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_START*/
>  	u64 max_mc_address = min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);
> @@ -1053,9 +1069,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	 */
>  	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
>  	u64 pde0_page_size = (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21;
> -	u64 vram_addr = adev->vm_manager.vram_base_offset -
> -		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> -	u64 vram_end = vram_addr + vram_size;
> +	u64 vram_addr, vram_end;
>  	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
>  	int idx;
>  
> @@ -1068,6 +1082,11 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
>  	flags |= AMDGPU_PDE_PTE_FLAG(adev);
>  
> +	vram_addr = adev->vm_manager.vram_base_offset;
> +	if (!amdgpu_virt_xgmi_migrate_enabled(adev))
> +		vram_addr -= adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +	vram_end = vram_addr + vram_size;
> +
>  	/* The first n PDE0 entries are used as PTE,
>  	 * pointing to vram
>  	 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index bd7fc123b8f9..8b3c84be7415 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -390,6 +390,7 @@ static inline uint64_t amdgpu_gmc_sign_extend(uint64_t addr)
>  	return addr;
>  }
>  
> +bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev);
>  int amdgpu_gmc_pdb0_alloc(struct amdgpu_device *adev);
>  void amdgpu_gmc_get_pde_for_bo(struct amdgpu_bo *bo, int level,
>  			       uint64_t *addr, uint64_t *flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index cb25f7f0dfc1..32a3987bef80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -76,6 +76,8 @@ static void gfxhub_v1_2_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
>  {
>  	uint64_t pt_base;
>  	int i;
> +	uint64_t gart_start = amdgpu_virt_xgmi_migrate_enabled(adev) ?
> +			adev->gmc.vram_start : adev->gmc.fb_start;


Again, long lines at the start of the decleration please.

With that fixed the patch is Acked-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

>  
>  	if (adev->gmc.pdb0_bo)
>  		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
> @@ -91,10 +93,10 @@ static void gfxhub_v1_2_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
>  		if (adev->gmc.pdb0_bo) {
>  			WREG32_SOC15(GC, GET_INST(GC, i),
>  				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
> -				     (u32)(adev->gmc.fb_start >> 12));
> +				     (u32)(gart_start >> 12));
>  			WREG32_SOC15(GC, GET_INST(GC, i),
>  				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
> -				     (u32)(adev->gmc.fb_start >> 44));
> +				     (u32)(gart_start >> 44));
>  
>  			WREG32_SOC15(GC, GET_INST(GC, i),
>  				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
> @@ -180,7 +182,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
>  		/* In the case squeezing vram into GART aperture, we don't use
>  		 * FB aperture and AGP aperture. Disable them.
>  		 */
> -		if (adev->gmc.pdb0_bo) {
> +		if (adev->gmc.pdb0_bo && adev->gmc.xgmi.connected_to_cpu) {
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 59385da80185..11041d0d4a64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1726,7 +1726,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>  
>  	/* add the xgmi offset of the physical node */
>  	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> -	if (adev->gmc.xgmi.connected_to_cpu) {
> +	if (amdgpu_gmc_is_pdb0_enabled(adev)) {
>  		amdgpu_gmc_sysvm_location(adev, mc);
>  	} else {
>  		amdgpu_gmc_vram_location(adev, mc, base);
> @@ -1841,7 +1841,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>  		return 0;
>  	}
>  
> -	if (adev->gmc.xgmi.connected_to_cpu) {
> +	if (amdgpu_gmc_is_pdb0_enabled(adev)) {
>  		adev->gmc.vmid0_page_table_depth = 1;
>  		adev->gmc.vmid0_page_table_block_size = 12;
>  	} else {
> @@ -1867,7 +1867,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>  		if (r)
>  			return r;
>  
> -		if (adev->gmc.xgmi.connected_to_cpu)
> +		if (amdgpu_gmc_is_pdb0_enabled(adev))
>  			r = amdgpu_gmc_pdb0_alloc(adev);
>  	}
>  
> @@ -2372,7 +2372,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>  {
>  	int r;
>  
> -	if (adev->gmc.xgmi.connected_to_cpu)
> +	if (amdgpu_gmc_is_pdb0_enabled(adev))
>  		amdgpu_gmc_init_pdb0(adev);
>  
>  	if (adev->gart.bo == NULL) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> index 84cde1239ee4..ef3e5bf23351 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -75,6 +75,8 @@ static void mmhub_v1_8_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmi
>  
>  static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
>  {
> +	uint64_t gart_start = amdgpu_virt_xgmi_migrate_enabled(adev) ?
> +			adev->gmc.vram_start : adev->gmc.fb_start;
>  	uint64_t pt_base;
>  	u32 inst_mask;
>  	int i;
> @@ -94,10 +96,10 @@ static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
>  		if (adev->gmc.pdb0_bo) {
>  			WREG32_SOC15(MMHUB, i,
>  				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
> -				     (u32)(adev->gmc.fb_start >> 12));
> +				     (u32)(gart_start >> 12));
>  			WREG32_SOC15(MMHUB, i,
>  				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
> -				     (u32)(adev->gmc.fb_start >> 44));
> +				     (u32)(gart_start >> 44));
>  
>  			WREG32_SOC15(MMHUB, i,
>  				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,

