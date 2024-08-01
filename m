Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B308C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 07:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC06A10E8A7;
	Thu,  1 Aug 2024 07:37:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OxlcyA8l";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0548A10E8A7
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 07:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XB3GEfzfNP1t1PCSTl/+K/hAnSk3OOLTP3Hedd3UY8vCK8OU6bFEeiW/C8ru5XlHbq03pTPx8zkCieIjHqFITTP0qD/ag+CwTJn8n6J21fHvws+4AXUTU4GNEGC6SdNapHMkUh+Kli1nIeYXy1ZHNHiivEH1coa6OznjKdve27CHe70q5Rynk0d4ImfgaFx8WisNUqfmAZjcrc7r1BJm99TzsNDXE1G3mP4fQEi2Jv5w6/l+Duu0Ds2F2WAfxv9mknqHG5hz4zAJZiZhVO+4fHDDY+xTLjcAbUdSo0utRU0F6DECiu+V4FRlulSrK/ZSaB6FRVxPSgi0YRE4tCnNjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMN69y4fAC6IJOEVpG7zq9AkRK3MVhWY0xYdB6hEkQw=;
 b=TXIbxujPTKJIgml9Q8znrixdhNGoyifCpSr2vNPay+qcDjmJehY/np/2LPcN/WXGLATv/GLgsUwivuYX//LeaxAcaD0uzKkgQf88lGo+X2m1tEDTIEkG/SKfvk9SqySTx0krw10gWSx7iiBmw/IjwjScIREJRg1fnYG4T4DyO/FK9dU/wxUiJj718H4sZSSsVZfTO00Ly0kjeSOehVo/2bJJNG4vKoUo/1GDxoQ9TASw4AAGY3YEDhmYG0L6WcUw7gANLHXfDx6GpYfBn6v96encaRKZDwkcOYSTKBlGTBxsiyqux+YPJP2RhAfhiORWyqCBAiBXJf3SmHZKqbmC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMN69y4fAC6IJOEVpG7zq9AkRK3MVhWY0xYdB6hEkQw=;
 b=OxlcyA8lGkoZEC9dl63gxOaSvINiZX5R0N77KD4ZAaQFlTjjR6Z2YijMvEDvGPPClkKPvU/HuoOljhUnRlx7Lb+p+eI69OYtTDm9D+ejl6xjf/T2VooC/rm/WT2JCL16FYI1UiaumhmVTClkq53/hBWwSD4p+SwWNHvsflwaKnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 07:37:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 07:37:30 +0000
Content-Type: multipart/alternative;
 boundary="------------utAaK5t37CSEWEEpldpOKcN5"
Message-ID: <18c7c805-d2ec-4448-bd25-cdb106aeac7e@amd.com>
Date: Thu, 1 Aug 2024 09:37:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: optimize the padding with hw optimization
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 "Khatri, Sunil" <sukhatri@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>
References: <20240730124332.38030-1-sunil.khatri@amd.com>
 <CAAxE2A5hEezckDEk1jJwFdfddpN1VXJtU+Yp5uXfsM2aiV2Cxg@mail.gmail.com>
 <28927b0d-f97f-451b-af03-943f8c85f92d@amd.com>
 <CAAxE2A7C3fuExvvjTytCR7fYNjoDTDzAqK2JroSihcz6EX7X2A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAAxE2A7C3fuExvvjTytCR7fYNjoDTDzAqK2JroSihcz6EX7X2A@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 97aa73dd-dd59-48d5-31a7-08dcb1fccc83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnpKT2RMU2Z6OURwRW8yZHhoQ0VPaVZ4RkJERjI2RzJFVXVtWHBQZ2lZUGhj?=
 =?utf-8?B?c1dtbFVRcW1oUEptREpRaTZhc0lTQVNuQmlOYXBIWEFCYjFiSk1lTkNvWjV3?=
 =?utf-8?B?T29xVHBsUUp1VHJBbnE2VnZLL2dEVitrWEp4enZqbGVYNXQwV2RVUng1enN4?=
 =?utf-8?B?cXVQZHpKdUlJb0FKbG5YdHcyOXNnTTFiRlR2WXNzWFpyM2xaMzhyWDR1Znhy?=
 =?utf-8?B?UzN0R3YwVmE0cis2U2RPbEgxdTZuUzdDTlo1azBiVUkxcTJTM1FxRWJCU2Fn?=
 =?utf-8?B?MTJIcEp4Q01UVmVKQVQ1eEJQSi9EZU1yVVBjaWdha0hKZmViK0lsNUt3b0Iz?=
 =?utf-8?B?Vmh2aTIvNGRRamFIRk1uREREUmJrV1p6OTBxSW1xM1ZoRXYrVkdMSDVyczRM?=
 =?utf-8?B?TWlxenVpSE11bGNmMGdaR01kZkFKa1VPSjFCR2pVbkx3M0VGdzhnUm5lRWE1?=
 =?utf-8?B?cE9sTmdOdFRkbVlJbnl2QUVqUk9ETlE1bWIrMXJhbmE1eUR2Qm5zL1ZEOWNx?=
 =?utf-8?B?bjhhaEhMZlZWYlFjT3NoVkhyRVFSZUxjT1gxNHRpV1N1UjJwV2FHVzdSQkNo?=
 =?utf-8?B?WTNUNnlWZEY3OTc0U0tjaWdoNlloN2N6dEd1eWJvT1VxelhxaTZBcnZNaWNk?=
 =?utf-8?B?aU9idlFIN3VZNW9KNHZ2MWh5ZGJTNkpvcXBZU0tmQUcvN3JTMmdHRzRqa1dS?=
 =?utf-8?B?YVRjdElZMzEzK1VDSUZVbnRMVCtVRHJjRDR6V3lLZ1pFdjFpdFBnRlNhZGJ3?=
 =?utf-8?B?QUZ3azJmbFNISlhqMzMzeG9JL0JXaWE1QXR2TitRbEN2bVVSS1JyWjFwWHFy?=
 =?utf-8?B?OXBrWTJmMFlrdDZtT2VqU2RSZDM0OW1aNDFaL1ZuVEJaQi95d2gzZG5XVDY2?=
 =?utf-8?B?K0lkSi9vNmtHVHdYdjJyN0MzaFpWVTd1VTQ1bXpjcXdIWjlCV3YxSXoyNkdU?=
 =?utf-8?B?Y1E2eVlpanRVN3lkVDJGbUU2N0NRaUUvUU5UMEQ3SDdVbkhkdTE5SnF2R1dC?=
 =?utf-8?B?Q3N0NDUxQWxXbkxpVUpWSElSd3ZpYVZYSW9Ebll0SUZzTkVjVUE2bTRUeFZq?=
 =?utf-8?B?Nm9QdVFZdVpYdCtVNXJDRFhvVWVGd00zclZaeWplT1VXQXV4WkxMK2NCNUJF?=
 =?utf-8?B?aUp0V3VOaTlMcXlJK0l1dE93SE5CZU4xeGk2UmFnL3ZtREk0bXFORU9ybTBD?=
 =?utf-8?B?QU5nNXpIYlRTU2tvYU8wTmFKQXU4ZEZhOVFYQ0hJbnBUZ3V4VjlNOEtNYWVl?=
 =?utf-8?B?K0FJdG4zL1MyMHJOL3ExdHJMZ1lNdW9TSGowWjFZVS9tLzNaNFFXbXQxNlgw?=
 =?utf-8?B?VXc3TDI5N0lwbHdYTlE0amdUWVhkMnpsTVo5aXBySzZwNUt4WEJqajZSbmFI?=
 =?utf-8?B?SE5leTlPendPcE50MlJRU2cvMjNnWFZSVm92c0xucXRSem5CM2pZRlkxbHJW?=
 =?utf-8?B?a05ydis0VExIUWw3TGd6YjNzYmsrTXg5L2FTaTh3cWVSUUpCMExZOGRqcmYy?=
 =?utf-8?B?N0ROR21LbDlFSnZHWXJPV2pFSklRamRKcDh2NGU4TlQ2Qk1pOUwvTFlLOXk4?=
 =?utf-8?B?dVFMbmMvZWRWNHVVQ20xTXZRRkhXNW1QRjF4VHR6eTUxL0pLc2RxcFdPdFND?=
 =?utf-8?B?aUhUWWhhT1B2ZnlFdE1tTlVaY1hrZy9YbEdsYXRmZjZla2xtS3dwVUo0QXpJ?=
 =?utf-8?B?Wnh4cW9KSGVOSWVFdHVpMHQ0emJvUkp0TmZUenovMStESHJsWGlQRERYb1Bu?=
 =?utf-8?B?eW9oYm9SNklzUmJZWlV2QkpPNzI3MmpkREsxYkRhcmNEbmtzbjJJa3d0QVVH?=
 =?utf-8?B?RHBOQmx2WmtycTVsL1MzZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE9aeUdscXBSVlFtZjcyV3JlTXhBZVZCU1RMS24xcHhiVi9SK3UwZUJWNXNX?=
 =?utf-8?B?bkpwMjIxZTJMMVVqa3M5dlYxWmkzb2syZUZQL0RwYlRtTng2dncrSjBCRmlh?=
 =?utf-8?B?Y0VaVWtrMUVLemQ4Zkg4T1JMU2V6TnRjRGpXQWxFQlZDdExiQVpUMXZRUmN2?=
 =?utf-8?B?c3pIVk4wWFB3bFcwVTRyMW5saUxQUXZQSGpMVDZ6TTFOSWttWHlQWjlYZFJC?=
 =?utf-8?B?RkZlclFRdEs0cG9naXN2YVZXa3M5aERFcGc1QUV2dVlSV014RXRBWlk5YjBr?=
 =?utf-8?B?aS9pRlArWDJUTkZrSGcwWkpWV2s4Vk5HT1ZaL3Azcm5Nazh2a2FQQS81VDhr?=
 =?utf-8?B?SEVvZU4yaFllYUMxS3QrQXBlOThqQ1R5VmRDYWNuY2tMVzhNeE1MYklpa1Fi?=
 =?utf-8?B?RGx1UnFxSXVpZS9DY0dZNWtlVlExSzR3YkRUWTI0ak85NHpJbmQ2WmIvSXV0?=
 =?utf-8?B?NGY2SzNacjVmbysyekVwbDdiN1NnMlNZYTFodmRHMkxqMjkwb05WYzFjT3Jz?=
 =?utf-8?B?OVdFSFFUdGY5bUpLRVlreUdKZlMzU2REVEk2b29XeHNTUHhTSEZsTmhTR29o?=
 =?utf-8?B?Y1puY0NSTU1pL1FDS2FRVVpvUzlYZThGZ2d2V3gvdWs1SldEL2lZdTdqUzN3?=
 =?utf-8?B?dUFMbDRJRDNQVDRwZEN2ZmhIUmFqSWczdFVrMSsyUnJtNHVyMnU5NkpCZEZa?=
 =?utf-8?B?OHVuR2Y0NnJMUUE0d2xHb0k0MjBKV1p3NWF2dU44dHJCK2hLUnI3VmczM01x?=
 =?utf-8?B?alNoRW0ydURwWXVKNjlEc2p3eGljQ2JIbVBjK2lZODFBMEJoZDFBeldjbmlC?=
 =?utf-8?B?U1VITG9ZYVpITC9iWGE5cUJDcWJaY2J2RDlhNDVIWDNTdUxNTE0rZWtBd3Z0?=
 =?utf-8?B?SkZ6b29jbjAvNWlXT2VBZldGVmJzR2ltSStYbHBjbGsvOUN4RUMwWFpEWW1Z?=
 =?utf-8?B?VGFMOTVBeUZlckV4d0J0Yk9hcXorNHdnb3pHWE5vMmZGVzVLbGMwMmk5MVJP?=
 =?utf-8?B?MHBxNkVrWjg5VXJLWEZ6L3FGaDVldGkrd1BOUTNFOGx5K0VJYmFsVUcycVdV?=
 =?utf-8?B?bE4vcnZ3ZUU1eDZSaWZ3bVlzUkRCQW1MakZORWdZTmtSSFU4UFBnaGgzcFY0?=
 =?utf-8?B?d20yMUJkS1FCSkZmcCtZMXFaYWE2TWhzRnRnc0RjSncyYkxiTXU2WGhqWnRW?=
 =?utf-8?B?OUNZaUMyV1M4V1dlODBROXhLaDhUK3RZN3UyNnk0Tm02MmVKLzgxa2t1NXZq?=
 =?utf-8?B?Zi9ZdlhCUXIvOVptancvUWN5Sm5XQmJlaThiOHYrNTlvbEZ4V1dsMnc1NjJG?=
 =?utf-8?B?bVJGOU5pd1hTd1AxVnd5SWJUc3NLWHFFMWdSekhjSFRRR2RjdDRMQWhvRlJn?=
 =?utf-8?B?SXBFaTBMNmF2d2wxV2UybktoQ3JFSkozazBNZUU0MExqMzYzVHpYUWRyeklJ?=
 =?utf-8?B?OEM4OHRBdkNaNWE1V2tuOXA1ZW5yRHE5dTIzZGVRS2NHcXlXTzkydnR0RFdH?=
 =?utf-8?B?Mlc3d25GMExOQW1EbGIxVzNkQ29acE5WcWUza2NUNjRpbTZGbzI5aGRUOHRL?=
 =?utf-8?B?MzB2ZG9ROUVoRUJxdkRoZ2dSNHJyWDBrb2JBQ0pkNHovUm1tMWlHZExrbjFh?=
 =?utf-8?B?K1lDRnBqOTlhVFYybEFFcFNGTjY4ZUkzWW1qMDBuWUNwMmZnYktLR3hxNW9R?=
 =?utf-8?B?T0RxaGZIRTluaEYzbXhFcjZQK3cyKzVhVnd2QkEyamlsM1BNUkt1VGhGNkgy?=
 =?utf-8?B?WlNNd2EvZ0NrVDBHcFk5U3MzWFNkTTJkVTZRcjBwdXNaYW4xM3hBbTBTcVJz?=
 =?utf-8?B?TGJTY3ZFZFd5VlFTamM3M1NqTThZcjFhT2djR1d6MVhzMU5VQ2IyQVQ1NDkv?=
 =?utf-8?B?elQ0bkNjSG9mU0tYay9FaXFRaFZBejVXSzFZWkVMNU5YUG5NTm40S0N2bis2?=
 =?utf-8?B?Nk9jcU5XRnFNbW83RXpISzQwZGFnMlhqd2sveEw0Z1BoMk5ZVFpnemRXWnhE?=
 =?utf-8?B?ejZ4ekw2M3dKbU5UVUIxUVN5SnBwV3RzczU2VzY3MEZsY01oQ1p2ZHFBTytS?=
 =?utf-8?B?dDFsa1djR3RhTm9nTjdTYlVPemZPSC9lZ0dhRWRNeGs3TFFCNHdXMHoyWW5P?=
 =?utf-8?Q?P8K/n6nRtfAp/r97aVFV10Qkj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97aa73dd-dd59-48d5-31a7-08dcb1fccc83
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 07:37:30.1856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69MTcp9oQ5p3sIIVAd5eFzQqlckoOr99eHbtC3YpOqjUIVU4u73Jg4gpf4irRWTt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890
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

--------------utAaK5t37CSEWEEpldpOKcN5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 01.08.24 um 08:53 schrieb Marek Olšák:
> On Thu, Aug 1, 2024, 00:28 Khatri, Sunil <sukhatri@amd.com> wrote:
>
>
>     On 8/1/2024 8:49 AM, Marek Olšák wrote:
>     >> +       /* Header is at index 0, followed by num_nops - 1 NOP
>     packet's */
>     >> +       for (i = 1; i < num_nop; i++)
>     >> +               amdgpu_ring_write(ring, ring->funcs->nop);
>     > This loop should be removed. It's unnecessary CPU overhead and we
>     > should never get more than 0x3fff NOPs (maybe use BUG_ON).
>     Leaving the
>     > whole packet body uninitialized is the fastest option.
>     That was the original intent to just move the WPTR for the no of nops
>     and tried too. Based on Christian inputs we should not let the
>     nops packet
>
>     as garbage or whatever was there originally as a threat/safety
>     measure.
>
>
> It doesn't help safety. It can only be read by the GPU with 
> kernel-level permissions.
>
> Initializing the packet body is useless and adds CPU overhead, 
> especially with the 256 NOPs or so that we use for no reason.

Not filling the remaining ring buffers with NOPs is a pretty clear NAK 
from my side. Leaving garbage in the ring buffer is not even remotely 
defensive.

What we can do is to optimize filling N DWs into the ring buffer without 
updating the WPTR each time.

Regards,
Christian.

>
> Marek
>
--------------utAaK5t37CSEWEEpldpOKcN5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 01.08.24 um 08:53 schrieb Marek Olšák:<br>
    <blockquote type="cite" cite="mid:CAAxE2A7C3fuExvvjTytCR7fYNjoDTDzAqK2JroSihcz6EX7X2A@mail.gmail.com">
      
      <div dir="auto">
        <div>
          <div class="gmail_quote">
            <div dir="ltr" class="gmail_attr">On Thu, Aug 1, 2024, 00:28
              Khatri, Sunil &lt;<a href="mailto:sukhatri@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">sukhatri@amd.com</a>&gt;
              wrote:<br>
            </div>
            <blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
              On 8/1/2024 8:49 AM, Marek Olšák wrote:<br>
              &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp;/* Header is at index 0, followed by
              num_nops - 1 NOP packet's */<br>
              &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp;for (i = 1; i &lt; num_nop; i++)<br>
              &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_ring_write(ring,
              ring-&gt;funcs-&gt;nop);<br>
              &gt; This loop should be removed. It's unnecessary CPU
              overhead and we<br>
              &gt; should never get more than 0x3fff NOPs (maybe use
              BUG_ON). Leaving the<br>
              &gt; whole packet body uninitialized is the fastest
              option.<br>
              That was the original intent to just move the WPTR for the
              no of nops <br>
              and tried too. Based on Christian inputs we should not let
              the nops packet<br>
              <br>
              as garbage or whatever was there originally as a
              threat/safety measure.</blockquote>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">It doesn't help safety. It can only be read by
          the GPU with kernel-level permissions.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Initializing the packet body is useless and adds
          CPU overhead, especially with the 256 NOPs or so that we use
          for no reason.</div>
      </div>
    </blockquote>
    <br>
    Not filling the remaining ring buffers with NOPs is a pretty clear
    NAK from my side. Leaving garbage in the ring buffer is not even
    remotely defensive.<br>
    <br>
    What we can do is to optimize filling N DWs into the ring buffer
    without updating the WPTR each time.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:CAAxE2A7C3fuExvvjTytCR7fYNjoDTDzAqK2JroSihcz6EX7X2A@mail.gmail.com">
      <div dir="auto">
        <div dir="auto"><br>
        </div>
        <div dir="auto">Marek</div>
        <br>
      </div>
    </blockquote>
  </body>
</html>

--------------utAaK5t37CSEWEEpldpOKcN5--
