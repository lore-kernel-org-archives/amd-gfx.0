Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB81C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 15:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0424F11250E;
	Thu,  2 May 2024 15:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lcYHnT/s";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D7711250E
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 15:36:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epBPfXi7uFf+bmA8mXF5G3vQ0fpPkhherBLY4hXkOBLrFz5h3GlNaWVlaYH7N/MNxcIzi8l0+x1yC6/H0gUpWd5dzzDZ6xIyXDe3kqV0MicTAyScaFFK9WYKcmGk5fsoe9O9DJOdRUtDMwCJyj1xoHogbM9jZkxTSuAEGe3S+wLL+0xZ9HMiQt31+kP4nodC1UJxjx/0pscnkU6YDMxsBJ6NwiWNl1kmG4WSgOLwg+0K4AjKY0Vg5Gujy3V57wnXCJKc8kTbsJBniv5baHaVtYeeRnIFRMi++7cD+R9iAYh5l86XOxbXiNfPaWzoRVBl8FOOj1Wgj+spjL8YoL4MBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXdUwuy2kwW5sHj8Kfu2bGCEo831M6l1qnUNgLgUou4=;
 b=eLdxSzk/mYtBJhvhHGLmX475vneNU5UiMGjWZlTi5K8NLNRzpIRXV6lrXsKMYUAwFI149hDmWULXOw6X6SQMHyphFW4BRDQnW4xg/lxU3CIy71RxXLsh64lfHyWE2AjklgURiy+xe93Iyda+4tLBYcBkik7u9GUhoRbs1V4RV7ZGdNco+4S+l+o6vbppMuNR/Mk20dGX+PtWgpdv+iMrIcYic58y6LZJ1xkum7hpvSMyTZEBFwS/0VYpdDRxVg5sCpF0WsYVTMzWurgcQ1MYxIBiFAEGFe6pbRSKzMfufZuMLaT7dAieGXHfHSDhfMb+9KCxJw6adonKLdBsn5VLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXdUwuy2kwW5sHj8Kfu2bGCEo831M6l1qnUNgLgUou4=;
 b=lcYHnT/sJVdNTCDRotj2eoB3EXSfeqv1V/x96+9qbZYnKpUwp3u0J5GFuGpwZXeAPHgTAAgMotn1O37ERcCM8SyKwppjVJKW6yY8kVG8e5+qA71YdkW8+jQIPyzoFzl6r/rRFgkCpePYQHS6f/4s8sEPqSsbtLDeYo5bcACpz4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MW4PR12MB7430.namprd12.prod.outlook.com (2603:10b6:303:224::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Thu, 2 May
 2024 15:36:23 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 15:36:23 +0000
Message-ID: <c10e9d8b-7b0b-9f5d-ae7f-516cfa4c6f95@amd.com>
Date: Thu, 2 May 2024 17:36:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 08/14] drm/amdgpu: map wptr BO into GART
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-9-shashank.sharma@amd.com>
 <c493094b-a5d2-43a0-937a-75accba93136@gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <c493094b-a5d2-43a0-937a-75accba93136@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::22) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MW4PR12MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 686b45f5-51fe-45d7-c6e2-08dc6abd9f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFhUc2lCL2hzTDBLV1ZLcCtBMTVUbFcycTNlRFhiSjRaamtWQndwMzRoUmkw?=
 =?utf-8?B?NnEyOGk1ZW1ORi90Rm0ybk5PbmpUdjhnc29remExMDArSEZla29menNJNWtt?=
 =?utf-8?B?SFM0Q1ZPOGNrZWlaV1I4bXBqVnM3TFpHQy9VVVN2OG9qSjlxZ3NOVUx4QkVL?=
 =?utf-8?B?NGprTk95VG80cEdYRjVUTGsxY2Y2a2hBMkx4ZlB4c2lxYmE3blF3d3VYVzRu?=
 =?utf-8?B?ZzBucUc0cDRCQ29EZjcyeEtQSERydGgvczJHdGorRnZQMWxSV3dOeWJWcFRC?=
 =?utf-8?B?Tk9lZ1FKK3krczdHOXlGU1ZZTVo0T09QMWpERmtSdExzVmlHQXRQeGJIbGM3?=
 =?utf-8?B?eTFiaTB3eW9xcHZnS1M5cXhmRVQ2WjA4UWJHbGlwSUxlWmhsNWJOcFoxT0Jo?=
 =?utf-8?B?MmRNb0R3b0RFK1VuMWI5eXQzb0VOb2JVWXRpc3NsNFhSU0tBK2QzZ0o0bnBV?=
 =?utf-8?B?ek5vYm1uN0dkUXNEZVZNVllhSjMwU0ViclQ3QzVoTC9uelJqRmV5SHQ4VzFE?=
 =?utf-8?B?bkpzTUE0bnJOS1cwYU1UQzBpWVgzNEJHb0VuSFFjRnZib1Btd1cwY1VLTWpC?=
 =?utf-8?B?K1JqVHhnMW9jQUx6bGtlOWNiVmtndU9TREo4UG52aG5vOHMySy9tMVZYNVdL?=
 =?utf-8?B?ZUJTcnZUOVVxYWZGb2pYZHpMakpQeXpYRFFiOFpqbS9ZZ3k0TEM1ME1Damdh?=
 =?utf-8?B?enh0K0hYcStjbWdzeDJ1U0xUREQyajlTQWlTTDB5czN2RTZtQmI0OCt3VmNh?=
 =?utf-8?B?OFNNUHNzdzdGVXhHOTJZdzJ6TmhyMFBqYVR3S2ZUR01rSjN5eUh1TEpjQUVZ?=
 =?utf-8?B?ZS9sWlFvWUF1ejRnY0xQR1hWSEQ3RXJJTzM2U3VLT2xCZkpQN3NrazJLVkE5?=
 =?utf-8?B?UEpPSUt4RTZxd3BmZG5SYW9KYW5tMmU5R0RGQXlIc2hyMTZUeG1hdDExSEZr?=
 =?utf-8?B?NVp0SkhwYnNwSUs0Z3FOdVN3MzRlNmpEQ014YjNTMjlKd1dxblJ3UmRhc1VW?=
 =?utf-8?B?cXlUL1FhenlTcXZ4TzQxdVRvUEZsSlRGUU1IQlNOQjJ4SXB1Nk9KWFFBU05O?=
 =?utf-8?B?MkhHRjcwWHc3dURHRlJBZmtSaUxIc2pwVFl6YVpjY0ppWjRZUXZFTlVYaE5T?=
 =?utf-8?B?c3RJRVM5ak9Sb00zY0VRZU55VjY2V1dtamRSbVVxV3Y0SGdOTlcwaHJOaXg1?=
 =?utf-8?B?amo0Q0ZIUXI0Ym1jV3ZlbzZyeEtuOHN0VThOTE4yR2NJYnBjdzlHUEVuOW9L?=
 =?utf-8?B?b0RVd1lLa2pNc1dIVFdNUlNnUjB5Ukp3ai9jb0FKdGpyZjBVblZ3SVEzWTB1?=
 =?utf-8?B?cS9YeXI0b1ZYVFBvMDlwYndzVUI1NDRzaXNWQ1Vidm5XMUxaZnpqRS9tVkxu?=
 =?utf-8?B?bXRYR0MzUHRoYkFYMkhZY1ZQbzdISUNjcHdnRUY3bEU4SlFjRG5adlc4NWM2?=
 =?utf-8?B?TFhaWW05ejMwNktua3RndVFCbGxxbm52akdzdlFOemhmaFFiMGtMYnZ6MXVL?=
 =?utf-8?B?djZsSWo0N244cmlHY3ZCRHFXdkVZVWNFQ0xaV3IvOXpkUXpzMHRpQURDMEI4?=
 =?utf-8?B?b2Q2bTU2TTlsdVNudkVBYXUyUE1RMDBUZWxZdW1nWlRhNGpKNzRHSEJJS3Nu?=
 =?utf-8?B?ZWtTRTNpUThPUjdCWjdvenJaakwxbEJMVFh2Zk5NUUo4OVNueWs0ZURRQkhP?=
 =?utf-8?B?WmdPaG8xblF0MjF2SUVYT0FwODZGbndraGRBUmxkaGZXb0MvZ2Fvb0hRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGptZzZWRW0rODR1MzFzR1owMjIwQ0hOUERHeWxBREVuajVveUdPYloyZDlY?=
 =?utf-8?B?ek9mbll6VmQ3b212ZGExcTltVHNuaHZobVoyNk9mQlZHNWxpTHBNUnJEeEtE?=
 =?utf-8?B?N0FmZlZrUlJIQ2NDQk9xWU9lVUNwcDQxc0JpY2kvQm1kaVF6KzRxQmxXRVRH?=
 =?utf-8?B?ZUt0MFRNR1lZUStla1VCK0lUb0hueDRkWWhMTEUyRzE5bktzWWozdVRVcnRu?=
 =?utf-8?B?V0dBR05TeG85bFZxWmgyMDh5aEJFdFRiYkxEY3h3NXNVdkxWdlh2Sm1RWXV2?=
 =?utf-8?B?QnBVbytiUTQyd3lsSFlib1BqK0xnbC8zTlJvbTBHeGlHMnBGamlTbTBFZFB4?=
 =?utf-8?B?SHV0bUxEeXVXZzg1Nm5uclVvT0FwM0Z5bGZtejFUWmRsbG0rSWV3SFZYUVF4?=
 =?utf-8?B?eFQ0d0Y1cGo1NXFTWDkzV2tLRStVeGlOTU8vU21HL2VYK2h4ZlJJOU0vNVps?=
 =?utf-8?B?Tzk2MU96bzdZTHJQQlpPRDZLUWJ5MnNxR0pyQTROVis1MjRlSXJsYTFKd3h2?=
 =?utf-8?B?MGxDaDBPekFMRUF6VzR6dVdQMFFsS3RqUWo4Z3E5TzFDak5udURzOW94dnFq?=
 =?utf-8?B?RW9BR000VGJUL01sRWNFdUFmVzFMRlU4c0JVajl2TzkvNVBrdU9NMmNFeHR4?=
 =?utf-8?B?SE1yTDIvYStMTDJEa1pNUzVQS2ZtYmVvbUt0UHNIZWZCcENYajNDUXMxdVNn?=
 =?utf-8?B?U3BVbWpuQXIzV01sVUQwTnVFbjQzTFFlenJVaWpnWVR6cGRRRHFSdmpObG02?=
 =?utf-8?B?bnZrazJoVWNmVFB3WFhRZHMxOFF3TWdzcDV6SmozeXBYTHZiSnJFYWY0Ujd0?=
 =?utf-8?B?WmRBYnpSU3RLb0lobHUwUU43QjNMenlFMEVMQXNpV0tPQWVuUENRUXlmL2x0?=
 =?utf-8?B?ZUZTN042MlVIbGN3NWpKdC93OEJmdk0xVWw1MlN3SDVJWndQclVadm52d2tT?=
 =?utf-8?B?dGpHLzJPbktKVTgyNzR2eWdncW5UWjc4QXFyRVo3Y1FvcFcra1hDVlBGRXNG?=
 =?utf-8?B?RGtlWk8xSXhDSlI3YUZ1Q1VBbmNPVFhXS1dGZzhyY1llQk0vSExvQzdpQTR3?=
 =?utf-8?B?OWFWY3FZNDNKSjlkMVJMc0MrNTRObzNjNzErSnlFaUxlK2tHOXJvNm44UWVG?=
 =?utf-8?B?UnpuYjV6eTlKZjVtUVU3clNpUUp4ektHdEFHNnprR3NTeTQwRHQxeEwzbzVn?=
 =?utf-8?B?aUhKQjVoOENVR0ZWTDlDWm9vT3ErcE5qUk9KZnBpN2U0UnBpSHcybkhCbTNm?=
 =?utf-8?B?WXVPSEoyb2MxWDBJWEdrOEY5aHFWSGtueWZ2MWV5aDd0LzV2VmhrSnhwS2lS?=
 =?utf-8?B?c3Nnb0JlbEVGWENWKzNoVDQ1VkI2NjNNb0UrbzRUS1ZjTkVrZmx0K3Q0b1dO?=
 =?utf-8?B?Q0g0V3VKY2lrbGZlOWo1bzlBbTk1RCtRWHVEdUF3THhOcHNLZGRCQTJQRkxK?=
 =?utf-8?B?UXcyN3FPNUhkdWhYMnExcDdVakozVnJxaDVFM3MrM2VWcWtqd1doRGUxQ1Vp?=
 =?utf-8?B?Q2l5dUJFTjI2Q0NEZndkSCtBTTZ0N0E1cEFHWjRjZVJXdEtidWthRzlyY0w2?=
 =?utf-8?B?Szk1bmFCYzgwQnYvUXAyRktZZHlCR0prd0ZIMnVaZUdyb2xIdUl5YkpqdVln?=
 =?utf-8?B?OU9kMHk5OTRMZzk4Q1dUOXVBRlh4aVA1WHluMC9lSUFvai96N2cwZFdTTWQ0?=
 =?utf-8?B?S0UxcGdLNDFncDFLcWpUdjd6aGx4REpGRzZDZzgzNzlyRUJOVVdZRmU1OWtD?=
 =?utf-8?B?NHhXeG45cHVYSHBPWjNBMnpTNy8vTE9rVTB6Ni9lbndrTXRQZ2t1R2FaTkVl?=
 =?utf-8?B?ZDVSOXUzK2FJK3pUcHR1V3lDbG9KWHAxU2ZlV2x3TlE5M1JnZHJuYUkxdWlu?=
 =?utf-8?B?bTNWSENRRFZBV2hYckN4Yy9ISktpTS9xcjFNdURQVkpaNG9RTWZGZlJXcE9r?=
 =?utf-8?B?dDNxSi9nUVozZnBhekFqL2NsSGpCS3NsTWN2SWNsZmV1dVdvOHZvYnR1VGxv?=
 =?utf-8?B?ajJOb2hjUlFIUjVZclBnallaSEpCbjFzbjZNMEw5SXBES0JKeHd3b3Bicmlr?=
 =?utf-8?B?L0c3aFJXemRBY1dhZnFOTGhqODVQa3lYbEZuSU41cWpIT2xYbm55NWtibVVi?=
 =?utf-8?Q?Y75979R0mRC5+McC/+Idp3syB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686b45f5-51fe-45d7-c6e2-08dc6abd9f21
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 15:36:23.4167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfBGI79eszHGaC9Wdtd9L/UvF8vpp+voUuUz5Ht3oyPhvZ5b56qr/CLDcWSTKjZYutIdgeTH6HHEoG1WKcVh3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7430
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


On 02/05/2024 17:18, Christian König wrote:
> Am 26.04.24 um 15:48 schrieb Shashank Sharma:
>> To support oversubscription, MES FW expects WPTR BOs to
>> be mapped into GART, before they are submitted to usermode
>> queues. This patch adds a function for the same.
>>
>> V4: fix the wptr value before mapping lookup (Bas, Christian).
>>
>> V5: Addressed review comments from Christian:
>>      - Either pin object or allocate from GART, but not both.
>>      - All the handling must be done with the VM locks held.
>>
>> V7: Addressed review comments from Christian:
>>      - Do not take vm->eviction_lock
>>      - Use amdgpu_bo_gpu_offset to get the wptr_bo GPU offset
>>
>> V8: Rebase
>> V9: Changed the function names from gfx_v11* to mes_v11*
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>
> The patch itself looks good, but this really need the eviction fence 
> to work properly.
>
> Otherwise it can be that the BO mapped into the GART is evicted at 
> some point.


Noted, eviction fences will be following up soon.

- Shashank

>
> Christian.
>
>> ---
>>   .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 77 +++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>>   2 files changed, 78 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> index 8d2cd61af26b..37b80626e792 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> @@ -30,6 +30,74 @@
>>   #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>>   #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>>   +static int
>> +mes_v11_0_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct 
>> amdgpu_bo *bo)
>> +{
>> +    int ret;
>> +
>> +    ret = amdgpu_bo_reserve(bo, true);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
>> +        goto err_reserve_bo_failed;
>> +    }
>> +
>> +    ret = amdgpu_ttm_alloc_gart(&bo->tbo);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
>> +        goto err_map_bo_gart_failed;
>> +    }
>> +
>> +    amdgpu_bo_unreserve(bo);
>> +    bo = amdgpu_bo_ref(bo);
>> +
>> +    return 0;
>> +
>> +err_map_bo_gart_failed:
>> +    amdgpu_bo_unreserve(bo);
>> +err_reserve_bo_failed:
>> +    return ret;
>> +}
>> +
>> +static int
>> +mes_v11_0_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
>> +                  struct amdgpu_usermode_queue *queue,
>> +                  uint64_t wptr)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct amdgpu_bo_va_mapping *wptr_mapping;
>> +    struct amdgpu_vm *wptr_vm;
>> +    struct amdgpu_userq_obj *wptr_obj = &queue->wptr_obj;
>> +    int ret;
>> +
>> +    wptr_vm = queue->vm;
>> +    ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
>> +    if (ret)
>> +        return ret;
>> +
>> +    wptr &= AMDGPU_GMC_HOLE_MASK;
>> +    wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> 
>> PAGE_SHIFT);
>> +    amdgpu_bo_unreserve(wptr_vm->root.bo);
>> +    if (!wptr_mapping) {
>> +        DRM_ERROR("Failed to lookup wptr bo\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    wptr_obj->obj = wptr_mapping->bo_va->base.bo;
>> +    if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
>> +        DRM_ERROR("Requested GART mapping for wptr bo larger than 
>> one page\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = mes_v11_0_map_gtt_bo_to_gart(adev, wptr_obj->obj);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to map wptr bo to GART\n");
>> +        return ret;
>> +    }
>> +
>> +    queue->wptr_obj.gpu_addr = 
>> amdgpu_bo_gpu_offset_no_check(wptr_obj->obj);
>> +    return 0;
>> +}
>> +
>>   static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>>                      struct amdgpu_usermode_queue *queue,
>>                      struct amdgpu_mqd_prop *userq_props)
>> @@ -61,6 +129,7 @@ static int mes_v11_0_userq_map(struct 
>> amdgpu_userq_mgr *uq_mgr,
>>       queue_input.queue_size = userq_props->queue_size >> 2;
>>       queue_input.doorbell_offset = userq_props->doorbell_index;
>>       queue_input.page_table_base_addr = 
>> amdgpu_gmc_pd_addr(queue->vm->root.bo);
>> +    queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
>>         amdgpu_mes_lock(&adev->mes);
>>       r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>> @@ -187,6 +256,13 @@ static int mes_v11_0_userq_mqd_create(struct 
>> amdgpu_userq_mgr *uq_mgr,
>>           goto free_mqd;
>>       }
>>   +    /* FW expects WPTR BOs to be mapped into GART */
>> +    r = mes_v11_0_create_wptr_mapping(uq_mgr, queue, 
>> userq_props->wptr_gpu_addr);
>> +    if (r) {
>> +        DRM_ERROR("Failed to create WPTR mapping\n");
>> +        goto free_ctx;
>> +    }
>> +
>>       /* Map userqueue into FW using MES */
>>       r = mes_v11_0_userq_map(uq_mgr, queue, userq_props);
>>       if (r) {
>> @@ -216,6 +292,7 @@ mes_v11_0_userq_mqd_destroy(struct 
>> amdgpu_userq_mgr *uq_mgr,
>>                   struct amdgpu_usermode_queue *queue)
>>   {
>>       mes_v11_0_userq_unmap(uq_mgr, queue);
>> +    amdgpu_bo_unref(&queue->wptr_obj.obj);
>>       amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
>>       kfree(queue->userq_prop);
>>       amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 643f31474bd8..ffe8a3d73756 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -45,6 +45,7 @@ struct amdgpu_usermode_queue {
>>       struct amdgpu_vm    *vm;
>>       struct amdgpu_userq_obj mqd;
>>       struct amdgpu_userq_obj fw_obj;
>> +    struct amdgpu_userq_obj wptr_obj;
>>   };
>>     struct amdgpu_userq_funcs {
>
