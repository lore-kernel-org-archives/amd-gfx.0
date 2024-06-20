Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1502C27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 13:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4359410E9F4;
	Thu, 20 Jun 2024 13:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fyzKczpe";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91FD210E9EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 13:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fH16YQKgP+TRw1CX13dnxeHqtjCpuu0c0usXudyYkA7okSixgmndrhuHOMtAjyExzpPpTYj1cDO9cPa4NcZDO1dybLalRXQXZj6HkZrIm+mMkTHOpJpSRwC7nNA8L2QLQG9TFxyFyK5SongQmAz1XH2uPKQBJZYKvILCv+vz05jAStpVssgmYOgEXrCoClIZkC+t7fRg8fPFPLfLflCdRMj6cK5+ph8oos8952DpFlYf3QE9t2Skg3H4hbpFmQfcMlZwiV0ymsI6FD26N8/uiRZRwF2yCCp6/9hk+zdp3OFPfbbuvgOIhwjdJdPz/B8tWeqfPBxyIfuiZubyhFdy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F34Y0ZQpmqHk57ZNyJ0FOdPblnUAnN4sSpbDIDXPkjs=;
 b=DNYYw2XwVU+nfYnhop+6YxIJV+taHXxpcJSzvsebAiVn/vFFQLa7nJPGBniuO7Xt1I+ehySHhP1oFjtbb1pQQG7UybrZZFGazB1jTuvH2DG6AVtPi4pPsDv9mtlNuiRG5tWpaQOOyNVM09cWS3636sxUdrlY+DrtRvx70Dfc6+dCGDX81Zzf2MJ/WLghzk+FxQeAbvDEi5W0EEqP0o3UMN9PseEjiKVlFvvmkGX6LaGiM1YjDbbPxzSfXXxWDxVPUPZt0W2fK0bk4kLJMBgb5nAzcDW5FI93DPX+DegeqoYOkn/+C5kKgbotQtQOKg4lz+7lQMr5jAehp40Q9Im4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F34Y0ZQpmqHk57ZNyJ0FOdPblnUAnN4sSpbDIDXPkjs=;
 b=fyzKczpedDkFV/zjjJoW2U6/va+ZVzeIJwns/w/NfwTPEEe8VM5/eNiyroBc+QGFGv2BsrSH2S6vYwiiABnv/HNrtAZrt39W3Vg4m6MwXb4C9sspw+3L3i4AEvbT7c4OTbh66GLjJLow9XZ0JSJ+ulZUKYbF7EziFdJ4HlOxwAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 20 Jun
 2024 13:36:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 13:36:18 +0000
Message-ID: <bcca41dc-8f75-4ca0-a843-62fa63636262@amd.com>
Date: Thu, 20 Jun 2024 15:36:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/amdgpu: allow ioctls to opt-out of runtime pm
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
 <20240618153003.146168-2-pierre-eric.pelloux-prayer@amd.com>
 <c45283a1-98d2-43a2-a73c-71896464c7f9@amd.com>
 <d2eefecf-656e-4c9c-96b3-717756581cc1@damsy.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <d2eefecf-656e-4c9c-96b3-717756581cc1@damsy.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: fefef214-5b45-4f8f-81bb-08dc912df6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0hHSnROWHZZUy9hYms1dm9TblNvbzlWdmk1V3lFK0VvdEtjUE80bXNpQkJw?=
 =?utf-8?B?dHA0K0lGSWhVdGVHQWRxN1NXU0dpSC9QNEVsYWVpUEdDdTEwVDdneVBUbEha?=
 =?utf-8?B?SjVUREdXMmpOZURYaHE3bEtVMThCLzU0b1NZYkpMT2lZejJtTWRTY25aeXpF?=
 =?utf-8?B?MUdUakNUQzlEZE5rKys2QkRBODVZVG1RQkhUR2l6eDNsNWljTkE2UDNBK3dD?=
 =?utf-8?B?U3BKRFJQMjFDdjBOZDFlRERSSExISzFVc0hnMjE0d3B2bVBiV2NDNTVHMXht?=
 =?utf-8?B?dVp1RzJ0Rmo5RVR0T2h6UVk1b0haM1JiNkVicFNoOFJJckZURUNZempNY0Vm?=
 =?utf-8?B?ZjVQTDM2c2U1bitBV1J1SmZLZzhOTzBIcndHMnBxZ3M5bElWU2FjamJnVUJz?=
 =?utf-8?B?MHdKY3Q4Tm8rNHdVd0FkajNzYUFIa3RZWjJSdGN3ZGJxL1V5NmZWeDAwb1d4?=
 =?utf-8?B?UDVLcC9xcjNXYWRrWmdYcTdMZGpIbzFacTl5ZFR5ZEx5UTFNODJ3ZlVXWEsx?=
 =?utf-8?B?eHlabXBia0dMYW5lKy9GYnE1WmhXYTI0M2tOeHQyU1h5Q1FtUGlIMFkzazVV?=
 =?utf-8?B?TWdBQ3RhQng4MGpQYVBKQjByNG15SThET1hyNjBpeGQrM2lhQkxETUl2Y2Vo?=
 =?utf-8?B?ckJNRE1DV1ZTTnNrQU5Nc3Jtc3NuaVJjZThVUU9jdXV3WGU4bVRQRzA2cXpN?=
 =?utf-8?B?dnRFS2NKZEJIZ0EzUWp2QmxkK3JMVC9vVjNYLzR2aUJVdnJyVkNtSnJNNzE4?=
 =?utf-8?B?RUxUZXhnWTdzaXZKRkhWUFM2UUZ1dzJwaWdWbDZsT2QzN3dWbXE5Mmo1VjZQ?=
 =?utf-8?B?QWxDZXpDdFdpc1lvZ081dFEybm5RTUoyckVIdHlGS2lTc0p4YzRnY2NnQW9N?=
 =?utf-8?B?aFNZSVIrQnhQOFVpenJ6aitHQWJVWjJZUDdBMVdINjlLNFJILy93bVNTQVVK?=
 =?utf-8?B?OENZTmNpZXhtVG9ucUk3cmJGYWM5d1lNeFJMNjVZTHNtT2JmZWdEUzI4Ryt6?=
 =?utf-8?B?Ym94QkwvRFVxZGprUHZCdGUrMkhaeXJDTmpPNHp1MHRMbVRlenBHdkxVUUhO?=
 =?utf-8?B?Vk0rek1pb2M5aGpZYnEyaVNGOEdCWUlWejhkTFlvUGNTTkRXRFFSOHdTMU9a?=
 =?utf-8?B?SDFEbDQ0ZmtEL1djbGd1TGhBclA3Q3h4VzNWY1BkdituQlFpTE5lT3d3SG93?=
 =?utf-8?B?YWxPTDVOaDl1bUdISHFxZENQc0k3KzBCYzVLVG9sbTdIa00yaTJaaXZ0VERV?=
 =?utf-8?B?MUp2ckVtdzgxT05iQjlod0dZb2g5eTQrWjd1TDhYTStBTlNNR2dVSkZsSnZv?=
 =?utf-8?B?RVpOVzJsU3U1ZGp0Uzcra2JFOFF3WmJWS3Nma1pQdkV0UGN4cCt3TWFQbnpX?=
 =?utf-8?B?b0U1VGNtMlE1SDFIaUprL09CV1QrczYwTlNyTE5aMFRaUC9URWtic2ZNZFp2?=
 =?utf-8?B?V09KZ2ZZZm91UUhZdy9hVHFKYVloQWxYOSs5Wm96QnI4NWhSUzhDd3ZCcFhr?=
 =?utf-8?B?T1Z0UTJMdTFpdkE0NWdEQ3JJTXRFbW9uVDdCSlFENDQrWmlVK09FdHhEalE2?=
 =?utf-8?B?Y0lDalNzVE9aMElxSHdVQi96MmFrYlNpdUVyUlJFVnRhWlhMMGR2M2MvMDVI?=
 =?utf-8?B?Zm5MaXdtUmRZZEQyZTM3TFpDZksxc1hjK1I3c0xPQXVqRHBNb0s2dkUzcUdz?=
 =?utf-8?B?NkpXV1ovVGpCaG0xRGJ5NUJCSWQ2YWtHMGh3THR6aWRXTGE4OXJCeXVuRHhU?=
 =?utf-8?Q?e4VsCN4MNY/76PsqVi2jq1W+A9Gro9Bg78GFINK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(366013)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTZjWlNRY3R5bVJNSnJkQXhKaE0xdE9oS0FWT1ViZ3hrSUN3cGZxSmprUkIy?=
 =?utf-8?B?ZEhUc2szQnM3UEZ1eHA2NUVWQU8wSnVVS2p2R0tCRU1ZalhwSW5wWm9OMEhs?=
 =?utf-8?B?eWgvb0p4UFV2VVZydlZnd1ovUTZvMUxxdFFvb3NMVjFabm1hRG9yb25aTG1h?=
 =?utf-8?B?MHZqSjZJOUhGUUdxWHNLaGhhRzBUZHlBM1FRRTJCVW1obkpHTi9nWnlZckta?=
 =?utf-8?B?aHZ0eE83ZVF2MEVJY01IbXJ1T25kMzVTamFrTENBSjhubmh6L3BmV0ZpeTBV?=
 =?utf-8?B?L1pTZ2YwOE9wK0JVNTZKK0hWcGtudXkzWnVJMHdFRlpxbFJRUVo4OTA5ekpI?=
 =?utf-8?B?OU90anJQdnZHczY5SWc3VXBWL0xGVE5iQnlQTkRLU1c1dnlvRmJmTFozdFpI?=
 =?utf-8?B?eFFBNVRRcFA3Qkk1azZ5WDRsckhGdTliWmwrc2lJL2NGdU9tNjNwQ0MyWjNq?=
 =?utf-8?B?TUxuUGo2TnYza2sxdTZZYVVGZnNoakFRRDduT2tpUEd5dFg1Q1JwQmZUcjRz?=
 =?utf-8?B?dUc4dlFueFFrNkU5eWpXMVM0TnpkV0hKcW5mUTJ6NVcyTko5WTBtQUV3T0w3?=
 =?utf-8?B?dHgrWnAxY2RZTlBCNmVSaFhIKzRsdlIxTzZ4clZQdTBmZHJWSUxFeG9HTXJY?=
 =?utf-8?B?My9MdDEzeFcwQktiUG9BYi9BVUZMM2FDRVhTanI0eUVTMTFNV0c1dWtRTDl0?=
 =?utf-8?B?YjUwQmdWRXNaR0lNdHhFalM4ZVlVRVBna1VBb1lWcEFVUHUrSmIvelM3M2xO?=
 =?utf-8?B?bDR1MVUzREJBQTE0Szcrc2RpdVUyVFJyU2YyS2gxQ012c2tYenFHQ2FURGtZ?=
 =?utf-8?B?eDk1b09hYjBuUHA4Ulo1eCtOS1JYcGplTFl4VGc3aUptOWYyQVlHRjRiSDdE?=
 =?utf-8?B?aTNlczc4OWU4U0duVHRxbkhwcXZweUtUMlZpMEI5NjZBbnBHUkg3VUowTkkv?=
 =?utf-8?B?Wkk1dXdqZWwxREYvV0l3czNNZmVJM0dGZk1wVVBHSUY1cW9mRFRQWHNkSGo0?=
 =?utf-8?B?aVk5MmIxZHUwYytBRFdrQkJ5ajhYQ0lnWENGMWY3VjhiWWsxMWtFVWxyeldH?=
 =?utf-8?B?dFdKMTRpZ1dHbW1xSlR1RUdsekhCV01tdFExQUxnRU4zUWZScFAxZmFINDJM?=
 =?utf-8?B?ZWxCWmE3TU5WeS9zWjMxQ1k4L1BjVnphQlBBOThReHBrdm9uMkZwcVA4dXNS?=
 =?utf-8?B?b0VoekhxUEFLUVorM0d5bmI2NVFuaVdmTktDS0FHSFVIanAvUy9CVjBCWTRO?=
 =?utf-8?B?QUJiUFgxaEM5ZEFUNW9TS1Uvems1aVNUekUreG91d1QxeEd0bW56SWFidEVI?=
 =?utf-8?B?aW9GOExEWFRvcURUUkl5R3lXM2NFNmZFNmgwczRGVjg2UkQwSWhuRmNvbml6?=
 =?utf-8?B?V2pGVjRycEpIeGdQcnU3UmFLamw3SUxuVmpCQUFKRzdXbjRmcDh2TEEvUDVw?=
 =?utf-8?B?VXNMMjhiUGhpcC9rcHU5SGdpaFpUZXRSaFdMRFlDMU9KSk1oZFhWU2JKRnhW?=
 =?utf-8?B?ZHpsYmxBNGhHWEJsYjBpZUtHRmJyRS9KQVpIU0Q0LzNYN2xNaUtQWHhkdzlN?=
 =?utf-8?B?SnkrRHdVVWc5OTZxeWhKdy82Wkt1SUNZNnRHOXRLUmFuRkpkTHlmU0tDYlIr?=
 =?utf-8?B?L2JxbWpYY0hzcW8wNnpHMS9ETkd5cEJQTnBRQWNCUWNkWThNRmJuWGpSQTRn?=
 =?utf-8?B?RFhCOFg3dGw3OUV6WjVFRGZKVjEvUXhzZFUzVDVsUkUwUjNWRmdkOTI1K0h0?=
 =?utf-8?B?MmJndVNUZ1U3UVo0aHl3M1RBMUZpeTNBVVJ4ZG1tRWx6aGFJc09qdENLNnd6?=
 =?utf-8?B?bkNvZ3lTUmg4UmhtalV4eU85NTd3NTBjWUhyTy9EODRJOThVRHUzcFZLRTJZ?=
 =?utf-8?B?S3Jyeko5blAxU0RLcktWYkpSMXVYc2pvNTRMK0swQUh3bHhidlRnZllRSmYy?=
 =?utf-8?B?R0JxRGNwK2dzcUFVWmFqTGRPaFhhazRCaWJBaUowRkV0SFJ5UkdnVDJXQTJm?=
 =?utf-8?B?WkhNa0pNK21GU1BuM0R4bHlZSnFXZy9hVG1VSmowelMyemlqMmJYV1Q5WWNn?=
 =?utf-8?B?WVBLNGdWa1J6eW9MRjdNUDJISnVEckR0UmRNcGZGWE90Y29Oa3lLWGFZREVu?=
 =?utf-8?Q?mcPF9j84hZ0k1SX6lPn/+LHqY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefef214-5b45-4f8f-81bb-08dc912df6dd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:36:18.4105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+X9GPCAGBhuSRE5ssD3nuRoMmxnViZyD54TO7unBLcxwZxNrzMd/RXqmNYMUYDg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
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

Am 20.06.24 um 15:06 schrieb Pierre-Eric Pelloux-Prayer:
> Le 19/06/2024 à 11:26, Christian König a écrit :
>> Am 18.06.24 um 17:23 schrieb Pierre-Eric Pelloux-Prayer:
>>> Waking up a device can take multiple seconds, so if it's not
>>> going to be used we might as well not resume it.
>>>
>>> The safest default behavior for all ioctls is to resume the GPU,
>>> so this change allows specific ioctls to opt-out of generic
>>> runtime pm.
>>
>> I'm really wondering if we shouldn't put that into the IOCTL 
>> description.
>>
>> See amdgpu_ioctls_kms and DRM_IOCTL_DEF_DRV() for what I mean.
>
> Are you suggesting to add a new entry in enum drm_ioctl_flags to 
> indicate ioctls which need the device to be awake?
>
> Something like: "DRM_NO_DEVICE = BIT(6)" and then use it for both
> core and amdgpu ioctls?

Yeah something like that. Maybe name that DRM_SW_ONLY or something like 
that.

Christian.

>
> Pierre-Eric
>
>
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer 
>>> <pierre-eric.pelloux-prayer@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 25 
>>> ++++++++++++++++++++-----
>>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 60d5758939ae..a9831b243bfc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2855,18 +2855,33 @@ long amdgpu_drm_ioctl(struct file *filp,
>>>   {
>>>       struct drm_file *file_priv = filp->private_data;
>>>       struct drm_device *dev;
>>> +    bool needs_device;
>>>       long ret;
>>>       dev = file_priv->minor->dev;
>>> -    ret = pm_runtime_get_sync(dev->dev);
>>> -    if (ret < 0)
>>> -        goto out;
>>> +
>>> +    /* Some ioctl can opt-out of powermanagement handling
>>> +     * if they don't require the device to be resumed.
>>> +     */
>>> +    switch (cmd) {
>>> +    default:
>>> +        needs_device = true;
>>> +    }
>>> +
>>> +    if (needs_device) {
>>> +        ret = pm_runtime_get_sync(dev->dev);
>>> +        if (ret < 0)
>>> +            goto out;
>>> +    }
>>>       ret = drm_ioctl(filp, cmd, arg);
>>> -    pm_runtime_mark_last_busy(dev->dev);
>>>   out:
>>> -    pm_runtime_put_autosuspend(dev->dev);
>>> +    if (needs_device) {
>>> +        pm_runtime_mark_last_busy(dev->dev);
>>> +        pm_runtime_put_autosuspend(dev->dev);
>>> +    }
>>> +
>>>       return ret;
>>>   }

