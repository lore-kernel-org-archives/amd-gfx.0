Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E35DD41D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 19:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D93710E836;
	Thu, 11 Dec 2025 19:31:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1uzW3xgw";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010006.outbound.protection.outlook.com
 [52.101.193.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21BE610E822
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 19:31:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qe2uFWo/Avc9J4OshcglppJEH71HWuu601w4Ds8K6/i2M9+OfN/+w8iKsLbP4dlcw+6qO9yrObkUix7rYb0cM/i3DAI/lsukKRVxLgsqY/hM2U4uQM6M7CMvz7LBroIJOGmIqWYBP97DRkNynnGyvz2hSMTIZIPil0JFAQpvDmwL2ZYb6arv+GFdOJMfnvZeGVxu9G7vTIA2N2vnAwyo3FLRBXdV0DRjqp3NTLJ0g/pkOM103Gb0QjO41e2ILx0gEIymMeGG8aMLkrsDsqy2tptbjg2nhfWW4asXmCYqrMvnrqpQjEnFGgozyMLKNvW7e+Nsl5rSkX4tLENYW+CKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEQx8ldEF3cy3NjMZY3+PugdnFszII04TkW0Vc82dc0=;
 b=pdt3U1VWZ+6s3aLsT/bcClDDx54sgmMf0vD1mON8sqHu3f3Vb4dc9KRRn7zpjEkuZfryQm7ycdfICNWAk/rK5j5k/23bKTOEOIm01OJbQFC5/G7HvlI5hO/NK1WdZup2bohQdkk37eAZlIWUbJ6L2KofmfLiuwkBgo2oRgvjdg7qJDkfGdz0cMKbKKSxVKF3N4LD5T0FYs78Ex9k6GSi8urp9tmvmfaKty8anA0sSdTt++4125v0w67F5xlMUg1YwcurCaYPKhymw/RbbHa6wzhVPJZOy7xiJmVEig5mmJVf3BLeCLfNiDRh03U0GQyLEc86os+3lsC0mrldiEppCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEQx8ldEF3cy3NjMZY3+PugdnFszII04TkW0Vc82dc0=;
 b=1uzW3xgwmhzCYs/XO3KxM22vgHz/WLoNV80cG/Po26P2Nc5ZfWlSL62SOdNnx/cTbhGIEkUAWA6Y6zP0S3fRbGan6y8+N92Ckwphbgm2lV8yHXvo1xVilbSJIco4zMxSeVkcCimYaL8At0sdZpQVM2zZGIXzppG/ArUq9d53Izc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 19:31:33 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::29f2:4b41:f65f:248d]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::29f2:4b41:f65f:248d%3]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 19:31:31 +0000
Message-ID: <080b0a48-fa99-48e5-874b-a4eec32d252b@amd.com>
Date: Thu, 11 Dec 2025 14:31:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Fix SMU warning during isp suspend-resume
Content-Language: en-GB
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 mlimonci@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, phil.jawich@amd.com,
 Gjorgji Rosikopulos <grosikop@amd.com>
References: <20251210015140.568540-1-pratap.nirujogi@amd.com>
 <db479aed-d96d-414c-88f2-a699accf24f8@amd.com>
 <2aa0eb5d-6097-43eb-bb18-4fc7d793256c@amd.com>
 <CADnq5_M36+bQ_kbfhGLFD3uHxWqAHZcPY93Vkzq=0B=EBm7JLw@mail.gmail.com>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <CADnq5_M36+bQ_kbfhGLFD3uHxWqAHZcPY93Vkzq=0B=EBm7JLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0165.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::16) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: e4594a42-1a5e-4728-ad4f-08de38ebe32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWRXR0h6dUQyV25JSU5LWXBpYkxzaGg2OFFzU2xueVdaV0RPaXdTWUZMUjVr?=
 =?utf-8?B?VW9SN1lleHJ1ODBsOGZxWm16eTNIdUhtdGFhai9sdTN3QktwWnZPdWFtYlV3?=
 =?utf-8?B?U2UxaG8vNFd6cGtBbjMrRSt1VEM5cXorViswMTZOMjRxbUxxR0hwTTBwOTRN?=
 =?utf-8?B?UlVOTFdqQmxVRlJUV1ZQbFNIWTRJcU91czhvMFRtSmVPNnFhQjlIZGdBY1A3?=
 =?utf-8?B?Rm9lblhkdUczRnQ3dUlQR2paZm0vOXZzdlJtTnIwK2c4bzRJd096UW5ST1BQ?=
 =?utf-8?B?L1ZYQWxqaUlldklHMnlZamhsbEpvVnprbkJtUWI3TlExVjdjQmN1WGphckJm?=
 =?utf-8?B?bE1xR1Z5MGQ0MjZaTk5VYTJMaE1PVUFrWWQwbVdlampOa24vK3lacnhCeXE5?=
 =?utf-8?B?R3BGdEZhS2lSWDZRR0w2LzIyeFVlcWJidFBJT0R2cEFSRnhYVHB6QVkzZTlp?=
 =?utf-8?B?YUQ4TU1MbzVQZEx4TzdrREVHRHFLUDNFdGNUMXNod09CUjRUVE5QTmh6aWZQ?=
 =?utf-8?B?ejVKZE1UdHNraHdOL2QrbDNqdWdkVkhMVHRmeVc3UWthZ2xjamFUVXN2Zy80?=
 =?utf-8?B?bEtlSkdpM0FBMVhMQWxVaVhJS3ArQkJ4S1BPT3FPRTlvbFBaYUp3WlVRek5Q?=
 =?utf-8?B?TS8xUnM1WnVWNTloUzZIWFlvYUQxR3FSUExBbE5oSkJrQVFkMkhwdU9NMTdG?=
 =?utf-8?B?bnpqOVRxVDFORm9YU0ttRVlEZEtxWDhJeXhSVmNacDRIZW83MGhleTQ2MEhL?=
 =?utf-8?B?T3dKL2FhWCtVTVBlWXByb29hVWFGMDFrWTdqUTlLZk9iTmovK24zbk0zbzcz?=
 =?utf-8?B?andvRXQ1MVRkUVhlTU5kRGd5Qm15TFVCL09CSUlqcm5FTndKemJNU25oZzcy?=
 =?utf-8?B?U3hjaEtCYk9KeWZaVHRWaUc0QSs2WGxXTnM1TDZXbWgzN1VjZERKTjBCZTdS?=
 =?utf-8?B?OHIyTnNDRk0yME9yUWt2Qkw3OHMvUEtqZ0pQV2owdTFEck1yOU9jcW81NWhy?=
 =?utf-8?B?S0lwa3ZzbkZDeXpCQWJ6ck1IMnFoeGxmQlRNdTBjTlpMNFhiY09TMTFpSWM1?=
 =?utf-8?B?SVNCQ2tuQXNBcllyM0Fpc1hwTTFneEFXdlhvTTdiUEtXb1pCQ3JaZjl5TzYz?=
 =?utf-8?B?amg5Mzd5VFVzUUw5ZlVEWEQ5V2xnNER6S2h2VTZFdXJmaGoyc2llTW8xVHd4?=
 =?utf-8?B?NE51VDRydzRTQ3V6dG1BZGZUZkpIaEtBMkRnWVp0aUc4eG0zRWZyWlVPb1hO?=
 =?utf-8?B?T2lkRUQ0dmY5c0dtd3dhRE5VTlBDLzAzeHVvY3FUZ2FmcTI4Z2xpU21pRXVL?=
 =?utf-8?B?Tmc1OGdQVkY1Nnh4M2g1T05RKzFpd21LdFVrb3M3emRRQW4ralpsOHM0Yjdp?=
 =?utf-8?B?aEdiSmtOemhXV00vQXVMZXVqTWNDY2NxWFcvQU40U0RicE1LaVFqQ0d1QUFN?=
 =?utf-8?B?YTQwaElGK2hScG1JbHc1a2dMWUNWYXN5VjRGTGJaaHIwcXZEWC82eERTRkxM?=
 =?utf-8?B?d1J6OVRyTGRUSURvUEhOY0dkMGZyc2pmNWhTWEVKUU1HdzJzMjZwUXhWQkZC?=
 =?utf-8?B?S0ZUYmVlK2xUcnVCTGx4ZjVwTkx0M2JHMnBydHFsdHM2L1hMUEprdWV6SHdl?=
 =?utf-8?B?WUF0ZWNxcVBQV2Q3NFVRYVVTTUhqN2dHSjBCZkVuSE4wcW5nOGZLWmM5RzNY?=
 =?utf-8?B?TnB5RUtlbzRoVVdZTFJFdVRKYlhFZHBmbCsrd2d3ODEwWGphK0Y2ZHVJeUV4?=
 =?utf-8?B?TW1Sdmw1Q0gwQ3NVdW1IRkdnLzZ1c2FCKy81WjJLYnBSVTdRZjNWb0llOGVY?=
 =?utf-8?B?ZFJ2Z2Jhb1RWT243SDcyRDVrcmdMK3ljYnlBNTBUL0w5ZmFUWEJjUm1naWkx?=
 =?utf-8?B?TXVHWGZJTkhXSTduVkpNSmdKK3ZyU0JnT2lDNG1MaUR1amc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9501.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHVsZEgrSlJjZ1NISlVBZTNPV3NONVdwNWg0a0lYVFdGRmhROVNKWi9nQ3hR?=
 =?utf-8?B?dlZVS0pWdkVqMGZndHVBNnFsMVNOdE5sczRHNElpekdNb2pSNDJBeVBjeHlk?=
 =?utf-8?B?dTNpOVNlU2NmZFV0QkNvTCtucnNibG1Qdk5hWkFNRDdnNE8vUU9nUXQ0TjFD?=
 =?utf-8?B?eHF1SkVwZjdJVVRBOG1VVFlETG5rOHlidVoxZVU1NG43eEFIVktGU1Z3THV5?=
 =?utf-8?B?UFp2Sk5uWHZHNUFZQ29ic1hKNlNYcytvTEVPQmFHM2R1OVF2NytaVm5kYzFD?=
 =?utf-8?B?Mmk2SGVlY3JtM1J1YXEwakUzZHN5TFdQdVI2L3cxcXVTTmxJbkNOQ3FWNHQv?=
 =?utf-8?B?Zmc4S2tOZG5iaVBzMkxWTnBxVC9FTHVydzVrVUZLMmJVWFZySi9lbmEvNk8r?=
 =?utf-8?B?S1VmYldUZU5wUVFSTWdXaUx5eko2NDJtUXZOOCtHSVVEZmNFYmlRajFYaUEr?=
 =?utf-8?B?c3k3dFYreG1PR3BScE5ubUtWa01GNGIzcW9ZZllCaHN3VHg5ZFY1aEUvRThW?=
 =?utf-8?B?T3FxODVvTHBEU0x1NDVLRktZQXpTMGxuc2tJRU5Rd0RONlRTVFE4VVgxbVlp?=
 =?utf-8?B?dEtyWFlGQ3YxZzFaYjJUaHgxZTg5U2JZSmRSRERLdzNmTGU3cmFWR1ZGS1lS?=
 =?utf-8?B?Z3RwNmpJeHNiV0FBbWYyTjBBS1kvSi8yVHNwWHlHbUZMcURxa0R5UGtKVmhX?=
 =?utf-8?B?SFJBRjQ0UjFLMU5GbVdhMERkNFBSUFg1L091QjFBbUIrRnprcjB3Rms3MEpW?=
 =?utf-8?B?SG9jVTN3MDM2TXppT3B5MWF2TEg1L3NXOTFwUmQ5aGg0WnhybXFXNUtxaDRs?=
 =?utf-8?B?cTBVWmhCOWh1NWgxM3ZRU21PbnlPVTVDYVNuaFJQRW95UmlmM2FQVVdna3lO?=
 =?utf-8?B?anQyL0RhdWdQNWptdjczNTlPVmFBTXBtOUs3dll5Wk53Yk9LZzFiOE9SQXVh?=
 =?utf-8?B?ckh4NjVuQStZL0c0V0lkQmZ0U3pPQkZFZTQ3a3pxVHM5VUFUclAzZnhKbXNX?=
 =?utf-8?B?TEQyZG9hdXlWK2lvL0t0eXFTSWFFd3JaSHhYUWpCZ1JDOXo1d0E3NStJemlT?=
 =?utf-8?B?cGdJVXRnamlJWFhpVDc4VGtoMEUwT3phSkFvSnlvSVBpSEFjSCs0SjhFWlFn?=
 =?utf-8?B?L0srZFY3SW41dkU1ek5pdXJyUm9tL2x3MHlCNEFxUjIzdGVENUk5bm9NL1cx?=
 =?utf-8?B?SXBnRGxnSWljOVpPRzZRYWhnaUlvV200cnoyTVFxWGxWTlZCTGh2cXBKSGJX?=
 =?utf-8?B?WVBScjFOTm9CdmN0MUF0Q1U3RGZmWEdMQ1VEZGJmeklzUCtzdGFaZ1RUSzUv?=
 =?utf-8?B?VlQzSDBHU2thQjFDU2ZxeWRoM085L1pseTVvVlUwSTlOWFJ4Qnl2cHZnbjRp?=
 =?utf-8?B?N0VCNXVXTFF6ZjhVa1pHNzZlS2R5QXB5Y3RDTDI0RmF3TTFBOHlpL0hLZW9C?=
 =?utf-8?B?YitZODJneWxOb05sT3FMMXNJaUdMMnpjUjFIeEQxbEtpaElPMmZmby9ITjZZ?=
 =?utf-8?B?VmgrTmZjQnpNV1RteWNRQjhodzI4UzhtbFM4b0dFT1BQMDY0cnhwZDFvSWI0?=
 =?utf-8?B?VkJXY3hBTUdDNm9PNWlwTGQ3VzJhV1VOalV0My9WR3lRVWRzc09NdUZydlZU?=
 =?utf-8?B?Z0lUNExVYmJZcFYwUmNXcngwZHVGa3hKV3kwM0dlMkttdHhadVhHTGtmczln?=
 =?utf-8?B?VmVteVpKd29zNHR6eTBqVytUQnZPeUFTWStNa1RMeUdMcDFNNy9qdXNrbHFU?=
 =?utf-8?B?bnVHWmxoRkZPNlZzZVB6RFNaUXBIZjBMMS9ON1EyZ1l3MTM2SkFqUjE0U1pp?=
 =?utf-8?B?RlRFY1BXUWp5Y3V0N3pUM0pNY3lNeldQV29jQ3E2czllREtaUW80aUpHM2Js?=
 =?utf-8?B?Sk9SY3ViSEFnNTRDTEwrQlhrZStmWGN6dmFlYW5PL084WjFqQ3k5bkM4Z0Qy?=
 =?utf-8?B?NXQyWVRWSlgyWFM4cm9ncEFPWHpsaGFqRXA3Q1NJcWJCRGQ1YjBFaVRmei9r?=
 =?utf-8?B?MDF1V2hmZzhXd0ZjVExrUWgvV0FyV3JKc0ZjOVpnNVZtQm4vNVZYVEdSZ0hS?=
 =?utf-8?B?SjlPc3hvd3lubE1hOXprNk9ZWWxlR1pVUnMrTFFUTmJWZ0EyTGNOc1FXVEl6?=
 =?utf-8?Q?fWSWhOBZ9BRn3j4Qjc2UaKGIf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4594a42-1a5e-4728-ad4f-08de38ebe32d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 19:31:31.5361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSsPv2ObX46Gi3lQ4peA9nAWUoQSrbQj0gNfJZlYbyC4XYMuMF6Pos4CjxA7N4waQupzqHvjGQHJlzqLXzRPow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
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

Hi Alex,

On 12/11/2025 9:33 AM, Alex Deucher wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Wed, Dec 10, 2025 at 6:24 PM Nirujogi, Pratap <pnirujog@amd.com> wrote:
>> Hi Mario,
>>
>> On 12/9/2025 10:28 PM, Mario Limonciello wrote:
>>>
>>> On 12/9/2025 7:50 PM, Pratap Nirujogi wrote:
>>>> ISP mfd child devices are using genpd and the system suspend-resume
>>>> operations between genpd and amdgpu parent device which uses only
>>>> runtime suspend-resume are not in sync.
>>>>
>>>> Linux power manager during suspend-resume resuming the genpd devices
>>>> earlier than the amdgpu parent device. This is resulting in the below
>>>> warning as SMU is in suspended state when genpd attempts to resume ISP.
>>>>
>>>> WARNING: CPU: 13 PID: 5435 at
>>>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:398
>>>> smu_dpm_set_power_gate+0x36f/0x380 [amdgpu]
>>>>
>>>> To fix this warning isp suspend-resume is handled as part of amdgpu
>>>> parent device suspend-resume instead of genpd sequence. Each ISP MFD
>>>> child device is marked as dev_pm_syscore_device to skip genpd
>>>> suspend-resume and use pm_runtime_force api's to suspend-resume
>>>> the devices when callbacks from amdgpu are received.
>>>>
>>>> Signed-off-by: Gjorgji Rosikopulos <grosikop@amd.com>
>>>> Signed-off-by: Bin Du <bin.du@amd.com>
>>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>> Who is the patch author?  If you guys worked together, there should be
>>> Co-developed-by tags to represent it.
>>>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 24 ++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  2 +
>>>>    drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 59 +++++++++++++++++++++++++
>>>>    3 files changed, 85 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>>> index 37270c4dab8d..532f83d783d1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>>> @@ -318,12 +318,36 @@ void isp_kernel_buffer_free(void **buf_obj, u64
>>>> *gpu_addr, void **cpu_addr)
>>>>    }
>>>>    EXPORT_SYMBOL(isp_kernel_buffer_free);
>>>>    +static int isp_resume(struct amdgpu_ip_block *ip_block)
>>>> +{
>>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>> +    struct amdgpu_isp *isp = &adev->isp;
>>>> +
>>>> +    if (isp->funcs->hw_resume)
>>>> +        return isp->funcs->hw_resume(isp);
>>>> +
>>>> +    return -ENODEV;
>>>> +}
>>>> +
>>>> +static int isp_suspend(struct amdgpu_ip_block *ip_block)
>>>> +{
>>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>> +    struct amdgpu_isp *isp = &adev->isp;
>>>> +
>>>> +    if (isp->funcs->hw_suspend)
>>>> +        return isp->funcs->hw_suspend(isp);
>>>> +
>>>> +    return -ENODEV;
>>>> +}
>>>> +
>>>>    static const struct amd_ip_funcs isp_ip_funcs = {
>>>>        .name = "isp_ip",
>>>>        .early_init = isp_early_init,
>>>>        .hw_init = isp_hw_init,
>>>>        .hw_fini = isp_hw_fini,
>>>>        .is_idle = isp_is_idle,
>>>> +    .suspend = isp_suspend,
>>>> +    .resume = isp_resume,
>>>>        .set_clockgating_state = isp_set_clockgating_state,
>>>>        .set_powergating_state = isp_set_powergating_state,
>>>>    };
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>>>> index d6f4ffa4c97c..9a5d2b1dff9e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>>>> @@ -38,6 +38,8 @@ struct amdgpu_isp;
>>>>    struct isp_funcs {
>>>>        int (*hw_init)(struct amdgpu_isp *isp);
>>>>        int (*hw_fini)(struct amdgpu_isp *isp);
>>>> +    int (*hw_suspend)(struct amdgpu_isp *isp);
>>>> +    int (*hw_resume)(struct amdgpu_isp *isp);
>>>>    };
>>>>      struct amdgpu_isp {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>> b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>> index 4258d3e0b706..560c398e14fc 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>> @@ -26,6 +26,7 @@
>>>>     */
>>>>      #include <linux/gpio/machine.h>
>>>> +#include <linux/pm_runtime.h>
>>>>    #include "amdgpu.h"
>>>>    #include "isp_v4_1_1.h"
>>>>    @@ -145,6 +146,9 @@ static int isp_genpd_add_device(struct device
>>>> *dev, void *data)
>>>>            return -ENODEV;
>>>>        }
>>>>    +    /* The devcies will be managed by the pm ops from the parent */
>>> devices
>>>
>>>> +    dev_pm_syscore_device(dev, true);
>>>> +
>>>>    exit:
>>>>        /* Continue to add */
>>>>        return 0;
>>>> @@ -177,12 +181,65 @@ static int isp_genpd_remove_device(struct
>>>> device *dev, void *data)
>>>>            drm_err(&adev->ddev, "Failed to remove dev from genpd
>>>> %d\n", ret);
>>>>            return -ENODEV;
>>>>        }
>>>> +    dev_pm_syscore_device(dev, false);
>>>>      exit:
>>>>        /* Continue to remove */
>>>>        return 0;
>>>>    }
>>>>    +static int isp_suspend_device(struct device *dev, void *data)
>>>> +{
>>>> +    struct platform_device *pdev = container_of(dev, struct
>>>> platform_device, dev);
>>>> +
>>>> +    if (!dev->type || !dev->type->name)
>>>> +        return 0;
>>>> +    if (strncmp(dev->type->name, "mfd_device", 10))
>>>> +        return 0;
>>>> +    if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
>>>> +        return 0;
>>> Could we store the mfd_cell pointer instead and just compare the
>>> pointers?
>> I don't think I can do a pointer comparision to identify the correct
>> mfd_cell, string comparision seems like required in this case.
>>
>> Its because when isp mfd child devices are created using
>> mfd_add_hotplug_devices(), it is not returning the pdev or mfd_cell handles
>> to store in the amdgpu_isp and later use in suspend/resume to compare
>> with incoming pdev->mfd_cell to detect the correct the device.
>>
>> The mfd-core is doing a kmemdup of mfd_cells data passed to
>> mfd_add_hotplug_devices() to create the platform device.
>>
>> https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.c#L163
>>
>> I'm considering to add this function to check for valid isp mfd child
>> devices that are allowed to do suspend-resume, this can minimize the
>> checks, but still cannot eliminate the string comparsion, please let us
>> know your thoughts.
> Can you do something like what was done in the acp code?  See:
>
> commit 4fce6b64ec8bcd0694f221906952d2880ed8ae31
> Author: Brady Norander <bradynorander@gmail.com>
> Date:   Tue Mar 25 17:05:17 2025 -0400
>
>      drm/amdgpu: use static ids for ACP platform devs
>
>      mfd_add_hotplug_devices() assigns child platform devices with
>      PLATFORM_DEVID_AUTO, but the ACP machine drivers expect the platform
>      device names to never change. Use mfd_add_devices() instead and give
>      each cell a unique id.
>
>      Signed-off-by: Brady Norander <bradynorander@gmail.com>
>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Alex

Looks like this requirement is specific to ACP. Atleast for ISP mfd 
devices, I haven't come across the strict need to create the devices 
with static IDs. It works fine even on creating the devices with 
PLATFORM_DEVID_AUTO (i.e. using mfd_add_hotplug_devices). Can I proceed 
with current approach? I will take care of submitting a new patch if the 
need araises to create the ISP mfd devices with static IDs in future.

Thanks,

Pratap

>> static bool is_valid_mfd_device(struct platform_device *pdev)
>> {
>>       const struct mfd_cell *mc = mfd_get_cell(pdev);
>>       if (!mc)
>>           return false;
>>       if (!strncmp(mc->name, "amdisp-pinctrl", 14))
>>           return false;
>>       return true;
>> }
>>
>> Thanks,
>>
>> Pratap
>>
>>>> +
>>>> +    return pm_runtime_force_suspend(dev);
>>>> +}
>>>> +
>>>> +static int isp_resume_device(struct device *dev, void *data)
>>>> +{
>>>> +    struct platform_device *pdev = container_of(dev, struct
>>>> platform_device, dev);
>>>> +
>>>> +    if (!dev->type || !dev->type->name)
>>>> +        return 0;
>>>> +    if (strncmp(dev->type->name, "mfd_device", 10))
>>>> +        return 0;
>>>> +    if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
>>>> +        return 0;
>>> same comment as above
>>>
>>>> +
>>>> +    return pm_runtime_force_resume(dev);
>>>> +}
>>>> +
>>>> +static int isp_v4_1_1_hw_suspend(struct amdgpu_isp *isp)
>>>> +{
>>>> +    int r;
>>>> +
>>>> +    r = device_for_each_child(isp->parent, NULL,
>>>> +                  isp_suspend_device);
>>>> +    if (r)
>>>> +        dev_err(isp->parent, "failed to suspend hw devices (%d)\n", r);
>>>> +
>>>> +    return 0;
>>> Shouldn't you return r?
>>>
>>>> +}
>>>> +
>>>> +static int isp_v4_1_1_hw_resume(struct amdgpu_isp *isp)
>>>> +{
>>>> +    int r;
>>>> +
>>>> +    r = device_for_each_child(isp->parent, NULL,
>>>> +                  isp_resume_device);
>>>> +    if (r)
>>>> +        dev_err(isp->parent, "failed to resume hw device (%d)\n", r);
>>>> +
>>>> +    return 0;
>>> Shouldn't you return r?
>>>
>>>> +}
>>>> +
>>>>    static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>>>    {
>>>>        const struct software_node *amd_camera_node, *isp4_node;
>>>> @@ -369,6 +426,8 @@ static int isp_v4_1_1_hw_fini(struct amdgpu_isp
>>>> *isp)
>>>>    static const struct isp_funcs isp_v4_1_1_funcs = {
>>>>        .hw_init = isp_v4_1_1_hw_init,
>>>>        .hw_fini = isp_v4_1_1_hw_fini,
>>>> +    .hw_suspend = isp_v4_1_1_hw_suspend,
>>>> +    .hw_resume = isp_v4_1_1_hw_resume,
>>>>    };
>>>>      void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)
