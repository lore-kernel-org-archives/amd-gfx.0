Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9396DC4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 05:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C914C10ED3C;
	Thu,  2 May 2024 05:27:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x78cm92+";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A14010ED3C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 05:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViuWC/iIdGfxCInUaHrFWLoDGfI6kpe1wJicHMPa4STt71d80B7fU8xqFpFxBFmzyFsFKZ1y72SpPJN8TDknnNXN/dYj+R8lt7TI/YbD6KOT/Wr/TIa2RLXks9cwJtmKBYr7MsfuWZhY2lI/T9xpkGlXfb1/f5vPsik+xasjIF2VLtazj6eyXHyAiFcUzqQSjiwIpBgwVljnSq2FcqKm787JB5v/wH9qVwoM5rjXVjUaMGaWVozQ1tNTgBzAv2Qcz98S75CJCtGuQ7S+43jw/Fbkvr7hTiow/mOBzGGtYLs3lC7N/enf/4yU8XyQeJ2B52RNWkp8UoVoT7ndzHmcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/9UayKYJRmf+5B6Z3Ph3ziLO5kxqJZdMG6/FV7VVm4=;
 b=GAHkT/56K1W9L0gCwiX0VXp0gh6sLQ7SfhbtFeFPzmhy49Y+aGalPkTdmz/zYCLNEQqkrOP7bVeyiaNK6f+ChU+Ln/OMw45+MR/YSs+4ElYUsUXjbp/5/UCMwnPTtVRjjge7ubPneXm7NhFptMziVNrgo5OpWNjmOjI4z1CtFVzcD75r9N/ozc9QoQnf9E4J1RYBhmZn7aXoBfkEm6Kb2PfPDcGFTRvDVjnHJK4vkqLTA1WrdrNhGajR++/XjUCkqwxeMy80zb2bjJUjnTIUnaLJLJFVuCwomGGb5r/nm/4n35km3l0Mr8q2q14k6bHufPnoTKavGwJkZS2DkjS+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/9UayKYJRmf+5B6Z3Ph3ziLO5kxqJZdMG6/FV7VVm4=;
 b=x78cm92+cAxOQt8++C/QqPfqMXXpg1Sc360ae9cqTAbPGa6D+XIaFd24LukFqXuyrWQtrglgnBulPurflc3LmypzsQpvIQSdio1podBF12/ZLwHHAgFpTJDhMZIvmmJ4RWzc9n6r86dWodCT76j5gIQFggp8+whtSmtN1y8bgpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 05:27:23 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 05:27:23 +0000
Message-ID: <977a7218-9fbe-390f-fbae-d748ab27a435@amd.com>
Date: Thu, 2 May 2024 07:27:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 06/14] drm/amdgpu: create context space for usermode
 queue
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-7-shashank.sharma@amd.com>
 <CADnq5_P-JA3eEB0wU2n3-iw+q4yfb1Mh4rWPEEjEv61=SmoVig@mail.gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_P-JA3eEB0wU2n3-iw+q4yfb1Mh4rWPEEjEv61=SmoVig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE0P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::17) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2572c3-e320-47d3-9381-08dc6a688bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dm1TajlLdHgyS0p5cUlKWWVDOVhRYTdIQzZsVmU2L1hlc1JQSjlZeExxR1kr?=
 =?utf-8?B?QjROWE5obVFPc2c4c2VlV3dJY3ovNFo4ZkZDWnEzZjBKOTd3ZkkxanNJSGxX?=
 =?utf-8?B?QjEvUGQ5bU12Nit5NDlqRnZzZ05CRlRuOEdmNE42MytCMVdPSmpnUTdtYVdp?=
 =?utf-8?B?RTVPTXg4ZVJXaE1SQ1FJN3ZHMnE2TStUMDZNeTlJVGt3SFpkclBTclFlWFM1?=
 =?utf-8?B?US9yOUhURkVHWDZqdEhISExIY3FnR0hJTUhGbnRSTXBnVGtxOWhZRUFZUUJ3?=
 =?utf-8?B?TEhJdExERXVGVmdyemNiK1I5UndLNjB0YVo5U2tJVFVmT01NNkhyTWxDZmc2?=
 =?utf-8?B?TmtuRThZem5LMTVMVnpsb1B3QktLd2FNcjJsaVdtZ1MwaVJhRTZkdFpnL2Jx?=
 =?utf-8?B?NWpwcjdsVC9MRGcvbVFaY2lIc3pHSURlZ3RJY0M3OVFBUXpwODNnL2xjdmQ3?=
 =?utf-8?B?NXc0M24rcm1RWjRRallaVUdES2JGdTdBdjdHRW1rMVZaU1pVbzBoS1NrK05D?=
 =?utf-8?B?S0tLYXRSTmVwRmEvOUdybmhFNDBGejkxU2FnRVhTaUdoWHBnV04wZC9ycWVi?=
 =?utf-8?B?bzNpaHdPYTJOSFRuQnJOTit1Y2ZaTDNTZUl0NERzWHFNZ1lhdkVnVUY5T3BR?=
 =?utf-8?B?czZnVlVrbEVtSllpQTRqYnQ3K0Vuc0QvY3AyS1dtUHRvSWU5MlZJUk41ODFG?=
 =?utf-8?B?MVc4QittbjdxUVNhSWpVV0sydzdaUzF2SkowcE93bmtUSUJFaU1HT3dsclJn?=
 =?utf-8?B?OXp0Ly9GWHFQS3JlSFZNK09nV1VaaWFpTThKeFpUclprUFNCeStyc0hKa0N6?=
 =?utf-8?B?RGtGVXNuc3VQZDZhQXpXbXNRMWtDMGtrdGRlS2llL1J2ZjJEYTl2ZmwreVFp?=
 =?utf-8?B?UFFCN2Q3S0laQ0lQdURud29hZGp5aVVhUDlaajk4aFR2aTZvZUJ6cCtWejhD?=
 =?utf-8?B?QzgzMHZESTRONlZsQVV3MVZGWEE3ZTUvQkkxcXFWbDN0ZDFRaWFoR0piaVI0?=
 =?utf-8?B?Mml0b1AwZ0ZPdndsMFovN0RQajVhcmtBVGorcmdEVnhzV002TmpWcnljYVZ0?=
 =?utf-8?B?WWsxUnpHeFF4Ky9uYUNRVzZwdHRBU1IxVEprVStzUW1OekFlbDlFbDdXaFd1?=
 =?utf-8?B?cW5peit4WlZVMjUzUVV6REhkSmxwMHZnOVNqWkQ1Yk9JSGg4eVcxekpIakJj?=
 =?utf-8?B?cWNlbnZhM3hXeE8yWHhiaWZYQzFxVi9RM0xqL2oxbHZleHorLzErQU53N0NL?=
 =?utf-8?B?K25NRTNnRGE3QTJJSkZWOFU1RWxOckNwSzNPeFVHNVhRamdLQ2d5SGdDaU05?=
 =?utf-8?B?N3ZvcWIxb1ZoaFZwMVZvUXM5VW9lMTlNWEV5TncxamhQYXhQT1UxMDU4WlBh?=
 =?utf-8?B?WEpHZGs4d3l6YjhuZnpqcURLM3REcHFkaHZVQURsbmZRTEl6VEhSb2tPQ2Ey?=
 =?utf-8?B?dTNtakJUc1p1VU1nVTlseFFvZmVCSjZtU1BhN3A2RXFuNnZ3c2h5VjBaWWxo?=
 =?utf-8?B?bnJpVG5xM3FvR0pscUh2S0JsZGFxZDlvZ3F5N0k3aU5oUzRXL0pZSDg1WmZH?=
 =?utf-8?B?ZGtPdXRkNTFITVBrc2xHdmdMMFpiRTNRSmw3WmhPK09LZDljN1Z4aGdFNXRu?=
 =?utf-8?B?N3ZqNkMwZ1JzaVMvUmVibXBFc2N1ZXpZRVBITHlRRkMrZDE4aEJmTzF4NXNO?=
 =?utf-8?B?QUR4cHJZdlZJSFExSFZ4RXZiUWVFQWNaQ1ZDQXl2YjlNM1BKVEk4SS9nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkQ0ZTFXM29Pa0VrVFhoWEoydVZkcmVNSEk3cWxqNmVjV3p1aW1sUUhaQmF4?=
 =?utf-8?B?YzVqZVFDOFVER1dCSFJlRk1WVFJOUmVlOENUVjg1Rm1TUldCTFdiKzFQYlIy?=
 =?utf-8?B?QTE0UkVtSFhMMlJOaDgvUmE1NDltOUF0ZVVjOFhKUVpzcG1DUTdtRDdrVTVW?=
 =?utf-8?B?U2VwcnRuZDdUZWFtZGZ4L1lSZktoUk8wOEI3WlpFeUUweHJIV3A0YXhpenJY?=
 =?utf-8?B?ejJEQjA3T3k1QzZLM2V5bWRzL0lya3JYeDc0VmEySHFaYXBCUG9UbEJiQVJX?=
 =?utf-8?B?TUMxVmIyNjVXNHdGM21hTTc2NmJYem5oclZyS0pkZmpxbHh1VjdkN1h2WjBk?=
 =?utf-8?B?SU1VQUgxMytzb0syL24vTXgwaUJEUUpZSU5zNytyaSt2VHR1UWgvamhZdWFj?=
 =?utf-8?B?TXRoSUpUalBqUEhVbllZcWNsa2lwUmZKYWNYb0dtZGNaaHZjV3RmWFNXRy9i?=
 =?utf-8?B?Q3ZGVUV3bEJXTDhnOE4zVkJ5Z0V3eFJ4cmlzYnZ5U3REeThMNklTSWpySFYy?=
 =?utf-8?B?NDZTazhXRjZjbUlJM0toeDZKSml0cnMzNUV4V1lYQzNza09yazE4Mkpvb3NS?=
 =?utf-8?B?MUtDSUNOZ2YxYTQ4RFJudkV1OGprVUE0TEtJakZEYWthQ1h5MXRJYTBYSm1U?=
 =?utf-8?B?SFhOOFBtZnVQL2dZQ3FEQU1PdGFQQVlORGxTNlVXMm53dGQ4YWdySVdmVEJU?=
 =?utf-8?B?K1hYSEgydUJxajRPVzZCeHpOajFxckVMeGNZaTZ1ZHJ0THVPdHBMR1FOQWYy?=
 =?utf-8?B?QndnNUFrODlyUjF6b0I3eEtmVkExSXhrczVCYnM4OEZJSHJ1T1NZSlQ2QVIx?=
 =?utf-8?B?ZGY5Z2xrRThsbnRwSlN1eGJhbnJmSVJaM2I2aDFXL0NXeDZZNEliZDNKR0pl?=
 =?utf-8?B?RlpnTzdEejFiVEMvd3dGblExQTJ6SVRQODBtalMrU1VMRzNjZkwvSDFudGdF?=
 =?utf-8?B?NWtiNUp0VytsUzFQNTkxQ094MnBmUGZKWlFiSk5NaTdtamp2VXNqZVlDcCt4?=
 =?utf-8?B?MEZNV21zeUtRNDZDVjZ0WTFyMUVKTG5TajU2dGx2b29ZaFBYUWc5Ujc3MXRu?=
 =?utf-8?B?aUkzeXJwd2J1S09WR25RSGhoM0RjMEtOUzNwRW8zKzRxZzhKR1JkQlYxQ3VC?=
 =?utf-8?B?Mnd0eEJ3VG1Dc3NucU44NVNOK0I1M2ZtUk1vaGYwejRwUVVXd3MxdE83bkUx?=
 =?utf-8?B?MnVNRmV3K3lRd2FISkNqTEJ2SWtKdVNVVmlLNEdOWC9OS2xyWnlCeE5IN3lP?=
 =?utf-8?B?VC9uTy9PZkdKajA4M3V3WEs3b09TYlk0RWxDSndqalhKYktoY3ZzSFZwYjM0?=
 =?utf-8?B?bmJ6bUFqYUJ3dW5XS01tMDBQNndWTzArcnErNXlMOUVqWFQwVmFra0hTemRG?=
 =?utf-8?B?ZzdoMTZ0TVlUUXFQNHNnckdwdGlDZ29YMHdGSDI0WWdPUERzbHNrWVFPT2Nq?=
 =?utf-8?B?RWp2d0F4R2I3TEMrWGhjZU9kNzhFREtPRHBkaWhTK2l5WUZuUDRVNzZWL0hJ?=
 =?utf-8?B?aG1nWEpSeCtkOTJwcEsxRDV4SWQ1SE1STWtkbFBPbEpUaEs4RGw5RUtMVDhz?=
 =?utf-8?B?VFpLSStROHpqU2J1cWQxT1V6S1BnYStkcU1ZbFFQM0pxbWovbTZGc0VtbjQv?=
 =?utf-8?B?dVRsdFF0YzVCR2N5WWpLdjYzenl5eEliUXRFYzByTU9QMmIrYWRRc3MyYTJF?=
 =?utf-8?B?K0syK3M3bGhGdVI0MU13cHljYnF3eFNaOHBsZEZSYm96Ny9RVUhIOWQ3UWlE?=
 =?utf-8?B?WHkxRXkvQm4zQ0pVUkt6TEFzV0QydmFaY0hGVi9hbzNPWkhlWDJUTjcvN1NZ?=
 =?utf-8?B?N0UzSzZrV1FDajU4dHZ3UTR1U28zQXowbHdEWDcxTWJvbE02dVQ5Q3FGMEVm?=
 =?utf-8?B?TklHUEE2NklkWXFtRWU4S0FIS0pOOVkrQVA3bU4zVE9XZTJhcHdrN0pBeWhR?=
 =?utf-8?B?WEt5MVNxYWZ5OERaeDNldUJaTEFHdVN3VFdnQ253d2RFRDAvM2NGcTlHanBl?=
 =?utf-8?B?eWVkTXF1S3lGVXpMUUs4WG1lam5SbDdpS2RyNUxoZkdKdElYVGZCbUZtSngx?=
 =?utf-8?B?T0ZQQ0Fzd1lYNVNldUVTTzZVWWdFQjJ0b2NlUzlpeUFDLzFySk9QckI4TGpo?=
 =?utf-8?Q?Yv2UIlnZ2d4J6/gQCMeiO+UBw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2572c3-e320-47d3-9381-08dc6a688bba
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 05:27:23.5738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B70OSj8Zf1sbVIZ3P8CE6lEuI951rD9PgdUt0BUvFpvQ1OK5Kq24NJ9Extx84PNM7+vY1/yk16mjG93grbCRaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
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


On 01/05/2024 23:11, Alex Deucher wrote:
> On Fri, Apr 26, 2024 at 10:07 AM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>> The FW expects us to allocate at least one page as context
>> space to process gang, process, GDS and FW  related work.
>> This patch creates a joint object for the same, and calculates
>> GPU space offsets of these spaces.
>>
>> V1: Addressed review comments on RFC patch:
>>      Alex: Make this function IP specific
>>
>> V2: Addressed review comments from Christian
>>      - Allocate only one object for total FW space, and calculate
>>        offsets for each of these objects.
>>
>> V3: Integration with doorbell manager
>>
>> V4: Review comments:
>>      - Remove shadow from FW space list from cover letter (Alex)
>>      - Alignment of macro (Luben)
>>
>> V5: Merged patches 5 and 6 into this single patch
>>      Addressed review comments:
>>      - Use lower_32_bits instead of mask (Christian)
>>      - gfx_v11_0 instead of gfx_v11 in function names (Alex)
>>      - Shadow and GDS objects are now coming from userspace (Christian,
>>        Alex)
>>
>> V6:
>>      - Add a comment to replace amdgpu_bo_create_kernel() with
>>        amdgpu_bo_create() during fw_ctx object creation (Christian).
>>      - Move proc_ctx_gpu_addr, gang_ctx_gpu_addr and fw_ctx_gpu_addr out
>>        of generic queue structure and make it gen11 specific (Alex).
>>
>> V7:
>>     - Using helper function to create/destroy userqueue objects.
>>     - Removed FW object space allocation.
>>
>> V8:
>>     - Updating FW object address from user values.
>>
>> V9:
>>     - uppdated function name from gfx_v11_* to mes_v11_*
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 43 +++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> index 9e7dee77d344..9f9fdcb9c294 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> @@ -27,6 +27,41 @@
>>   #include "mes_v11_0.h"
>>   #include "amdgpu_userqueue.h"
>>
>> +#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>> +#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>> +
>> +static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>> +                                           struct amdgpu_usermode_queue *queue,
>> +                                           struct drm_amdgpu_userq_mqd *mqd_user)
>> +{
>> +       struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>> +       struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
>> +       int r, size;
>> +
>> +       /*
>> +        * The FW expects at least one page space allocated for
>> +        * process ctx and gang ctx each. Create an object
>> +        * for the same.
>> +        */
>> +       size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
>> +       r = amdgpu_userqueue_create_object(uq_mgr, ctx, size);
> Is this per queue or per context?  I.e., is this shared with all
> queues associated with an fd?

This is per queue object, required for MES mapping of a queue.

- Shashank

> Alex
>
>> +       if (r) {
>> +               DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d\n", r);
>> +               return r;
>> +       }
>> +
>> +       /* Shadow and GDS objects come directly from userspace */
>> +       mqd->shadow_base_lo = mqd_user->shadow_va & 0xFFFFFFFC;
>> +       mqd->shadow_base_hi = upper_32_bits(mqd_user->shadow_va);
>> +
>> +       mqd->gds_bkup_base_lo = mqd_user->gds_va & 0xFFFFFFFC;
>> +       mqd->gds_bkup_base_hi = upper_32_bits(mqd_user->gds_va);
>> +
>> +       mqd->fw_work_area_base_lo = mqd_user->csa_va & 0xFFFFFFFC;
>> +       mqd->fw_work_area_base_hi = upper_32_bits(mqd_user->csa_va);
>> +       return 0;
>> +}
>> +
>>   static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>                                        struct drm_amdgpu_userq_in *args_in,
>>                                        struct amdgpu_usermode_queue *queue)
>> @@ -82,6 +117,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>                  goto free_mqd;
>>          }
>>
>> +       /* Create BO for FW operations */
>> +       r = mes_v11_0_userq_create_ctx_space(uq_mgr, queue, mqd_user);
>> +       if (r) {
>> +               DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>> +               goto free_mqd;
>> +       }
>> +
>>          return 0;
>>
>>   free_mqd:
>> @@ -100,6 +142,7 @@ static void
>>   mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>>                              struct amdgpu_usermode_queue *queue)
>>   {
>> +       amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
>>          kfree(queue->userq_prop);
>>          amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
>>   }
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index bbd29f68b8d4..643f31474bd8 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -44,6 +44,7 @@ struct amdgpu_usermode_queue {
>>          struct amdgpu_userq_mgr *userq_mgr;
>>          struct amdgpu_vm        *vm;
>>          struct amdgpu_userq_obj mqd;
>> +       struct amdgpu_userq_obj fw_obj;
>>   };
>>
>>   struct amdgpu_userq_funcs {
>> --
>> 2.43.2
>>
