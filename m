Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9262FC4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 05:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E87910ED50;
	Thu,  2 May 2024 05:31:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3OXETfGl";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 826B810ED50
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 05:31:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyTNUmwDL4nTVnwd4j877btNT/k7H03NkNBB+bj92aGkTsCPYF33N7k5E8wxYluBD1c5ILZtD+ce4EIX9bl81f8Xm0sUw//NyOjrrKNKcUHBO9fZEjKbtaRqWXAaeC/GHGAfGhQnq1l+68mV2Y8FyuCNsmPgxz3G/vfN8fyZNFEcuraqTcNHG7+PSxonAyWCXEcCNlcE7JY4TiFKsZ4sPaN2ruS9QaFe/1jFVnuZ6cOI0jm+zYeCXaA2Sfi/XsUADCcwa3ewvrYZSReITp+QwbT5dWfZWcbHDhk6q2BscZICvSCl9t4pvxbcpIKN5FK3eJB0JviN+QGxtAA3RzkRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBANQJsSfg0AXZJipEbifSLtGuVnTjUxHdkerMDpakk=;
 b=BP74O/Oxn7f7b8v+3r7ea9pfQrE4TzeYaI7z4uPeUwNa1VrqP8fOe/1fxXPs+M3foT4pP8HWERfzS4GsLTNwGOFYE2jpNtznV/suXCtpGbjtePdDl/ojRn2iLYwcpK9CPB5we34qS8ae2tgtxDXLVS1vnqDSsMQ/CGWuhnAS9cJ7ZbW6XlTKG/32mHHOBQkrIOu96Qxh3z2shHaEYAnWVMn3r/52QywKiSvQS1kzypmb2L7VbEuexi/DLas+wFq7HUlLRt6DT5eIZQfeK26ev/Qe69GZLdRYvq2t1/288DdlsyhGTcrRFcqQljk0cjvQ74V+brgANzz/jx8sJANYtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBANQJsSfg0AXZJipEbifSLtGuVnTjUxHdkerMDpakk=;
 b=3OXETfGlINbcP5efmIJQQ6I2iTRd9zpmmtPiVvpeeNx0UgumEYlkeg3NiWgC65lZxcQbpx/47GekrPQLILs2bq0nHzmGgB2wPUs0Qrte3LQk/VYMTEFqqTf9Z2V2qQSOfUHHWw8RVSSNlSm/8siTkiKrBbc1Eam3OVtQxFihtxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 05:31:38 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 05:31:38 +0000
Message-ID: <53cfb00e-c41d-7ec7-561e-370cba54748e@amd.com>
Date: Thu, 2 May 2024 07:31:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 08/14] drm/amdgpu: map wptr BO into GART
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-9-shashank.sharma@amd.com>
 <CADnq5_NcuAT643x5tUe34fJUT0QG7f3WEwmf6VyL8VeLnsQo+A@mail.gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_NcuAT643x5tUe34fJUT0QG7f3WEwmf6VyL8VeLnsQo+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::9) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: 758a4ceb-908d-4a7b-e6c1-08dc6a69237f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ymw3TjdjOUp1cG5vMjdwNWhIMlN3U2Z3K2REaE5yQTdPaUdCVUl6WXY2S2Nl?=
 =?utf-8?B?Y3p6eXUxbkZxb0lSSVpLZHRieER6WUt1YVlKYjF5dFlWa211cFlCL3p3WURq?=
 =?utf-8?B?SC9UMGs2TjZJaC9uajMyV2VzS25jSkxCK05pM2Z2UUwvTkNMV3hqQ2kweFd6?=
 =?utf-8?B?YXAzc0dCNmxsbXhJalRwRE5uL2pmMWhzbFdrRkVGRG4yUmlac1BaU3M5aDNS?=
 =?utf-8?B?Y0RVT2luQzZ4aWFSK0VpdStOMzhaYTZRNkxNZVE4N2k1anJRTmlTMzB3VjNI?=
 =?utf-8?B?U3QrUUxxUkpVWHhOTVZsS3pIL3poeW05Z1BjSmVONFpXVlg5bDQzZDBsWjds?=
 =?utf-8?B?RjRiWXJEUUs4MVJMOGNDVC9mU3JFSi9QQkJReFBPdE1RNXF0eUFoU0dkUXhx?=
 =?utf-8?B?ZXYxMG9ReVgvUisxQk9yL2hZMFQ2MTZqQ3pDTmM2TkpmOVQzRVBLT0lGNkNM?=
 =?utf-8?B?M05HSnBDRFFwNG9UVkh0ajFzaG9iRmhJK3lKTnhaMEdtTUQwZ0VpMEtId2RO?=
 =?utf-8?B?NEJUQnczTFN6YzJyZkUyWTFLdWhoYnV6Mkg5MmErSy9oK1UwVXJoaHdsZkRs?=
 =?utf-8?B?d0pyZFlTOS9wSkg3NVRVdDQwdklqdE5RMCtjWTNaNVlmcUhNWExpRmpTNmdp?=
 =?utf-8?B?ampZNWQ0UUtETjJSTis3QmxqV0Fad3ZkVy9EWE1SanZ5U21Velc3ZTlFRGJB?=
 =?utf-8?B?dU1mbkxKNDZMTENlUHZLVGpFQ0tZSTFrYWpZUWZvVGdvMUxlQkVWOVhSdno0?=
 =?utf-8?B?ak9sZSt2WFBQdUtQRnMzOGhQemVGSjQzSWZZMUIwYU5yOFFQZzVHekNuUk55?=
 =?utf-8?B?elVvQlRQblRmamxkZHRjL0FjSzJqekthUkcrQzJGY0FPcHB3SlBQSzZMTWlm?=
 =?utf-8?B?OVBPNElhTWlTY0Faei9uQ3U3dUdoY2l2aW1CRGtzY0c2TEhxMTQ3SFVVYTFj?=
 =?utf-8?B?dXIxUVVKTXdYZU10Z3pwbHkzc2J2UXZGYVp2YkZOaFM0cTRjb3hiRThMWlVI?=
 =?utf-8?B?bzhKMnVnMEsyRmhxSjZJYUt3SW9EcFVrZ0JHMkUrNHFLdHNLVjFXWWJSVHpK?=
 =?utf-8?B?K213MmFCVFFidEl5RWpQeERLa21kVXR6T3hyL1RBWmlPQmFYZmVxNTNycXps?=
 =?utf-8?B?Q2VrVkxtRlJENEhtenFzMUxVTHRheDJ1VEJMQUQ2anNadG1aalh0NkVPQUdu?=
 =?utf-8?B?VmUyRm5sdmpGcUNIaGNPV0E3a3R4dzNBUkZaZFl2Y0U1U0gwUW5MZkRlY3Qz?=
 =?utf-8?B?Z0F1Y0tTeEI5ZStFMzhEaGFHNTU5MVlnZGgvUjM4dHZJT01MalhxSVIyTHZP?=
 =?utf-8?B?ZEhnN1J4TnNUS21tS3pkNmw1TWNvNFBBamVuS1d2R0hmcDUyLzZHMnU0YmVZ?=
 =?utf-8?B?SWN4UWNudnpXVEcrZHd6SWtwUmgyUGtzbGpzc0tQTVRhOG1BclFndWNjdWtX?=
 =?utf-8?B?TEkyOWpxTWxqOHZvSk5DRWdMeXY0WnhlR0wxMGVRd2dHM0hObi92UjVFLzdq?=
 =?utf-8?B?TS9DYUJva2ZjZCtoVlNPdU9HaDdVbUVkV0hrTVZQK2lmUFBFSGxUb0pnU0J6?=
 =?utf-8?B?bWRRYXBZZFh2NnpOTTVTZ2hkWHV6OWVUUk00cFBTNXhqM3ROOG43cnFjcmhN?=
 =?utf-8?B?S3dOZ0xqWk1BNGxIMFRiVG9PTk5aMGFOZTNZREw0blNpWHc2eVBmd2ZqVDFV?=
 =?utf-8?B?NFNHbHRGQnp0TXhOUUpZU0dEOFZac2k2ejNYdGxHVmt2NkNmWDhOdnV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjN0cTBxdkU2dDZXSFF3bVhmUFRGbVFxQi90bDdHVVJaNlRLRmdhS1krSCtG?=
 =?utf-8?B?OFA4Mmp3VFF2a2ZpdDVMUWtRRWwva3EzWTlFTldRcGJsSXFEUHNkbllELzhS?=
 =?utf-8?B?SkpUeitBbUdsYit3Z2NmcWwxVWEyNytXMlVsTHJsQ1VpR1hlTGZWeG1jRURL?=
 =?utf-8?B?OHhTb1plWkhHbVhoL1VPNEZVM3RBbHN1RUNtWnNxaXJML3dkMysvNXlDQVp4?=
 =?utf-8?B?enVETG9ySkdjcUdRSlVNUmszcXFSS3Q2NDJWbmxCNWRseElNR2RrM3VkRkZh?=
 =?utf-8?B?OGNyUElnM0cwTVFHV2hRdUhkSXE3OEFKWXd2N05XTWJrMS9DdlREQ3dkdFA1?=
 =?utf-8?B?Y2NXQlovWVdpRHF1bGVvUmNLRGJvdjJ6d0p5Z2FxL21tZ0JSZ2wyNCsyalI4?=
 =?utf-8?B?WU9xcGNwRG1oNkJpVC9sWjdYcHd2MVZlUFA0TzlwdktDRzdlUUc0dE41Q1c0?=
 =?utf-8?B?aE5QampXVWFzcWFiczFMZHBvV292NzNQR1UxTmFKK05pSkl2UDBtQjkxL1M1?=
 =?utf-8?B?L3pCUXZsbTJ5Nzl0cGhjNXlleUVZdUU4Tm93akNndFVWamFhclY5RG9QZity?=
 =?utf-8?B?dTVFTW5BdjVDU3dmTmQrMnpLRklreHZYRWcxa1QzTmdLSTNxay9qRW05bWpS?=
 =?utf-8?B?dWdJR2VxSldaU0hFRCtCM2pxR3dSQXJoNEMva3JVN2xpUWNvenRFdG9NUlBl?=
 =?utf-8?B?MDJwbHdxTjVpcGIwUytManFKK0N2Tm00S01BYi9RNnk0Zi9pUTdtT1RmRU5O?=
 =?utf-8?B?WjllMVNPYU4rUmNvOGFBcmJxTmJyVTIzTVpTU0NUeWtEUlJRc2xWc09rL0o0?=
 =?utf-8?B?bS9rVjd3ZXdZZHFLcmUyY0tpK2l5dDhKdkZBTXdGNm9QMGU2YkRsYm5VaDk4?=
 =?utf-8?B?QzRCOEg4Y041SjhtcGRNMUZqZDFlNy9hL0txdCsxVVVyOStSeWdtODh2bU14?=
 =?utf-8?B?d0FpU253SUxtVnhHWFhzempubjNkZFZ2NzVKNnhlb1l2R29FWE96RlMrRngv?=
 =?utf-8?B?R0FBVkVLdFpJcjgvS3VpY1piL053c1JpTkRQNFVXT0F3bkcxS1FJZkMwY1do?=
 =?utf-8?B?aFF6Q1RtS1oxenBmMm9Wc05YcEtDTlFCZ0Y1ek5vMEljVVhtcFRYaSttU0kz?=
 =?utf-8?B?UDJEdklHM3liS21uM3NMZ1ZncGpJdzVRMUg5MjZKK0JydFg0dlIwbFBEV2Zq?=
 =?utf-8?B?YVFaUWxFcDgrSjdmdUFQMlF3b0RvOFBOOVZWbEZRZEpZelAwRWdTcU1WSTIv?=
 =?utf-8?B?bm9XNktYOUM3OFBOVjQ0MXZXKytBeVE3ZkUweUEycG5xd1YrUXMzZ0ZBajNy?=
 =?utf-8?B?Yktub2d3S0ZmZ1R1aWRVYTgrUzVMSVlsQnVzeW1yMkdLNGZuSWU1S1A4V3dL?=
 =?utf-8?B?Ny9iMHcyUkNwYTgrdWt0OUlKS0c5dGlmVjZHMGxkS0xnNDJhQkM2SmVjNnBK?=
 =?utf-8?B?VHBLSHhjdmp5Z3BRZkJwbVlZOGhaMkpBMjF0QVNWcUNxY29NaW5mRmZUWlQz?=
 =?utf-8?B?RGFZdHd5L05ObHI0TytQY1NRSHRmczVOSmVPYzFlckhIdnVORnMwU0xVVVJk?=
 =?utf-8?B?c3JPWUtVcnZVbktZVG1oNHB5YmQxOVZKd0ZnM2RvRXdXa1duazVMNnNNVVFZ?=
 =?utf-8?B?Wi92dGJHY3V5aUIxTHcwTys1dTdlZUNodDdpRU5GeUlkVkNrTlVHUlEwak1x?=
 =?utf-8?B?cHd0cU83SUxRM2FBUyt5NVFkdG5JSGliUm1YZWRKQ3JOK0xwMnV0STFtYThZ?=
 =?utf-8?B?WS95YXZNdzZFbXRvcUp1KzhiYUdhQWZod3dlV01ab1lITEozZzRibng1UDR4?=
 =?utf-8?B?SVRDRWtZclVjV2FqUFF5ZEJRa2psbjdkR3RIS0dxWEVXa1VDTHpQSzNndGhF?=
 =?utf-8?B?NEdMcFU5ZjBqbmxyODZUVTAxSFBndW1yeXd0RGN6QTRZL1FFTi9pL0N6Y21i?=
 =?utf-8?B?M3grYlFNNDEzVFMxSUw1Z0NndWxFdnN6YmN4b3VxRkIxWUpENkV1VmJJRk9F?=
 =?utf-8?B?QjlhWnV5c2NySWlrV3ErQnJ2YjlIeGIvTEVyR3dFK0R6YVQwdldtQnF2OUor?=
 =?utf-8?B?N0VUVDJIaWtKOFRqbEd3V3hCT0ZTSFN1NTlnZ0lDTkQ5Z0plN1NpSzlZYU9D?=
 =?utf-8?Q?7YCgdvCjI1NWoERZUfnBgIZxJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758a4ceb-908d-4a7b-e6c1-08dc6a69237f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 05:31:38.1716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83Vjj8KI9xefEoIH9xfkSyaELky9kV0hqeBMQOuosxn4AeKZlP2BLGuIU1bh9VGCVppOvFZ57Zl+bsHMrIccxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758
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


On 01/05/2024 23:36, Alex Deucher wrote:
> On Fri, Apr 26, 2024 at 9:57 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> To support oversubscription, MES FW expects WPTR BOs to
>> be mapped into GART, before they are submitted to usermode
>> queues. This patch adds a function for the same.
>>
>> V4: fix the wptr value before mapping lookup (Bas, Christian).
>>
>> V5: Addressed review comments from Christian:
>>      - Either pin object or allocate from GART, but not both.
>>      - All the handling must be done with the VM locks held.
>>
>> V7: Addressed review comments from Christian:
>>      - Do not take vm->eviction_lock
>>      - Use amdgpu_bo_gpu_offset to get the wptr_bo GPU offset
>>
>> V8: Rebase
>> V9: Changed the function names from gfx_v11* to mes_v11*
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 77 +++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>>   2 files changed, 78 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> index 8d2cd61af26b..37b80626e792 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> @@ -30,6 +30,74 @@
>>   #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>>   #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>>
>> +static int
>> +mes_v11_0_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
>> +{
>> +       int ret;
>> +
>> +       ret = amdgpu_bo_reserve(bo, true);
>> +       if (ret) {
>> +               DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
>> +               goto err_reserve_bo_failed;
>> +       }
>> +
>> +       ret = amdgpu_ttm_alloc_gart(&bo->tbo);
>> +       if (ret) {
>> +               DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
>> +               goto err_map_bo_gart_failed;
>> +       }
>> +
>> +       amdgpu_bo_unreserve(bo);
>> +       bo = amdgpu_bo_ref(bo);
>> +
>> +       return 0;
>> +
>> +err_map_bo_gart_failed:
>> +       amdgpu_bo_unreserve(bo);
>> +err_reserve_bo_failed:
>> +       return ret;
>> +}
>> +
>> +static int
>> +mes_v11_0_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
>> +                             struct amdgpu_usermode_queue *queue,
>> +                             uint64_t wptr)
>> +{
>> +       struct amdgpu_device *adev = uq_mgr->adev;
>> +       struct amdgpu_bo_va_mapping *wptr_mapping;
>> +       struct amdgpu_vm *wptr_vm;
>> +       struct amdgpu_userq_obj *wptr_obj = &queue->wptr_obj;
>> +       int ret;
>> +
>> +       wptr_vm = queue->vm;
>> +       ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
>> +       if (ret)
>> +               return ret;
>> +
>> +       wptr &= AMDGPU_GMC_HOLE_MASK;
>> +       wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
>> +       amdgpu_bo_unreserve(wptr_vm->root.bo);
>> +       if (!wptr_mapping) {
>> +               DRM_ERROR("Failed to lookup wptr bo\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       wptr_obj->obj = wptr_mapping->bo_va->base.bo;
>> +       if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
>> +               DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       ret = mes_v11_0_map_gtt_bo_to_gart(adev, wptr_obj->obj);
>> +       if (ret) {
>> +               DRM_ERROR("Failed to map wptr bo to GART\n");
>> +               return ret;
>> +       }
>> +
>> +       queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset_no_check(wptr_obj->obj);
> The wptr virtual address from the user may not be at offset 0 from the
> start of the object.  We should add the offset to the base vmid0 GPU
> address.

can you please elaborate a bit here ? wptr_obj->obj is already mapped to 
gart, do we still need this ?

- Shashank

>
> Alex
>
>> +       return 0;
>> +}
>> +
>>   static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>>                                 struct amdgpu_usermode_queue *queue,
>>                                 struct amdgpu_mqd_prop *userq_props)
>> @@ -61,6 +129,7 @@ static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>>          queue_input.queue_size = userq_props->queue_size >> 2;
>>          queue_input.doorbell_offset = userq_props->doorbell_index;
>>          queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
>> +       queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
>>
>>          amdgpu_mes_lock(&adev->mes);
>>          r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>> @@ -187,6 +256,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>                  goto free_mqd;
>>          }
>>
>> +       /* FW expects WPTR BOs to be mapped into GART */
>> +       r = mes_v11_0_create_wptr_mapping(uq_mgr, queue, userq_props->wptr_gpu_addr);
>> +       if (r) {
>> +               DRM_ERROR("Failed to create WPTR mapping\n");
>> +               goto free_ctx;
>> +       }
>> +
>>          /* Map userqueue into FW using MES */
>>          r = mes_v11_0_userq_map(uq_mgr, queue, userq_props);
>>          if (r) {
>> @@ -216,6 +292,7 @@ mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>>                              struct amdgpu_usermode_queue *queue)
>>   {
>>          mes_v11_0_userq_unmap(uq_mgr, queue);
>> +       amdgpu_bo_unref(&queue->wptr_obj.obj);
>>          amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
>>          kfree(queue->userq_prop);
>>          amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 643f31474bd8..ffe8a3d73756 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -45,6 +45,7 @@ struct amdgpu_usermode_queue {
>>          struct amdgpu_vm        *vm;
>>          struct amdgpu_userq_obj mqd;
>>          struct amdgpu_userq_obj fw_obj;
>> +       struct amdgpu_userq_obj wptr_obj;
>>   };
>>
>>   struct amdgpu_userq_funcs {
>> --
>> 2.43.2
>>
