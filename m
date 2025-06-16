Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC55C71155
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 15:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073DF10E3D7;
	Mon, 16 Jun 2025 15:05:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jpNVcVvZ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBE2610E3D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 15:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4klPBYDSQ88OfgAyQllr6FVzBdHW1bT1Z7xDSZ3PNgorzvcCQZqDxfxMa3TXtg5V4KMEHTr7QcTXxOzNmg34O4eyBzr9lkkwtDxZl3oSIFF01JljDHEjq61O5WdI4qrh1lzZyMLiY37WmlaY1fJk+6fURqJntqpSza3BogrR56HWk/FybYwFNQ4OEoAX9Vmzsjuib63heF4JbUPOhWS7sImnZi0NFm2WdvPhMPUpo3xyM1d81rXvZtpgFDHLUidQ9RA53OvoU4Wx7AGoMEGdrT5fcRwJrpYMbCyoHkO5GVURuV/SEQG8mAZ1vmpCEVpay8lQDZ/B1Q2dJlQ/cieMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS8n+F4dbe5ZL9k5ZJe0t/gjtjVd2nUKFa+YTLXjan8=;
 b=H5axIi7zcR4B6k8WhdrWLwFGhLhZcEr6pHjEJOpKvWaKeFX+kqwvk36INHiifB5/Pn8Yzv87cq2eS03yDLcQ1Z8FZ6JSylT/C5TWzwGEsi9z0Vxc3dL0/FNlbwbQ3rCBpW5VOL8Ks8H+iewcia2cQdXsSMs1egkrrB+dNvFzZTvCN6YMEximhDcTssTbTiEpyrqDAGqra1zCAZ7Yhknu4xrd1Nv526M4f4/N+0h6tz0TmsZy69ZyciUqz1zRMSahlVAYpk6eFyz8jsGX9XiVxbj6mBjrJQsufKrds/mmK/pmX6J74LnIgyH+RPM+Plb32J9GQ/5TIZT2pFkcnqGgZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS8n+F4dbe5ZL9k5ZJe0t/gjtjVd2nUKFa+YTLXjan8=;
 b=jpNVcVvZs8Z3EylpsF56daCzc3tva6JrWrCyNj5XqR0Tm5278DoHoD/iz3VwTbcXUxVjgZUbFeMkLQAYPdAkm9r1+ROHHhvGqmCcfy4cQ7mhocpp0NiFG9Lf36eMgxMvPA5Yo5zjKNAbQhnh4joTYCqotqnEPdddzgYs0tFBXEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Mon, 16 Jun 2025 15:04:58 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 15:04:58 +0000
Message-ID: <ca06a3e8-cc16-4b98-99ce-7271c3efeb47@amd.com>
Date: Mon, 16 Jun 2025 20:34:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu: Fix SDMA UTC_L1 handling during start/stop
 sequences
To: Alex Deucher <alexdeucher@gmail.com>, Jesse Zhang <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian Koenig <christian.koenig@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>
References: <20250616144030.3497914-1-jesse.zhang@amd.com>
 <CADnq5_OpAaiBZaxU6RxNRvY3wcpz5WhDzX1iscuUnsu7gebrhg@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_OpAaiBZaxU6RxNRvY3wcpz5WhDzX1iscuUnsu7gebrhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3b130e-ec28-42c2-2eb3-08ddace728da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDlqUW5ha1dLT0dJL0JCU2xTVHlHZWRSS3oyUFBvM0xESzIwSytrSHZNcFBR?=
 =?utf-8?B?OGwxa25ON2gzekZLMjZlb3hyRjI5Sno3Skp3SXdaM3RQSnBtdU5mSEVNWjdR?=
 =?utf-8?B?RkpqL1JoTUNyYkIvcDkvZFk5TzBwN1VTRElkekx1M1ZPK1laM0FPczdwU0g0?=
 =?utf-8?B?TC9kK2JXUWRsVDg3TXJpbjU1RjZydlpTTm1kQW0vdnVvN2xET0M4ZzJqUXVt?=
 =?utf-8?B?dDBkOERZd1V0WkROK1Rqc3pOMzVkZlRkU3lDZ2o2dHVQaE5scEhZTWJ0ZnRw?=
 =?utf-8?B?OFZWd0o5d0dvV1A5MDcwSENXekhGcFZEV1Z1OWZsYzlSVHhjcE0wREtEUEdn?=
 =?utf-8?B?RDRtSXc0aktmblpOR0FzbzExdWtDWUNqWU5IanRCTWZFMFo1anUxYk4xc0NJ?=
 =?utf-8?B?K0E0eUVnUzJuSGQ1Vjl5UU9BbnNNUEI5S09hZU9HMTVDYWg0Q2VyNm5iMDVN?=
 =?utf-8?B?a0lCNWhnazQ3WmxOTnBIZ0N0SVdKUWNGMldsNW1Ra281M1ZnUzJTUERFSHR1?=
 =?utf-8?B?dzJtS0hTSGlHNjVOYTkxbEgwaXNGOXFIV21PZmZHeEx2eVhQQWpoNHJHN2RL?=
 =?utf-8?B?YnEzNTlXVmt5cHNsbzV1QmVCeXhFdGdzKzJIeHdWSkxweWxhYjVUUStyVHNm?=
 =?utf-8?B?bEYwSU54R1lCVXZhOVZpR29CUkpvdEVVQjhzQWJlMHFpcnFxK2JKc0lnQjIv?=
 =?utf-8?B?WHZraHptMG93WENranc3clJJbUwySkdsUStmckcvSXFoUWhaWWJIdTdkSi9T?=
 =?utf-8?B?NDNUUVU2SEtqVmQ0YUttUkV4eTl6aFU4VUt5cUh3bWdHUEtyTHVyYm9PLzFv?=
 =?utf-8?B?QXIwc1MzajJZRTZPa1ZRZWlnZTUvUkVueWFuMXpZVEluaG81M2JMV3lqZXli?=
 =?utf-8?B?NndBU1BXdmwzMmN4V3JHMmZVUUVUbHNSdFRHc3A4RDVjd1pPbHhWRllpWWsy?=
 =?utf-8?B?cnJqVW5OYk9HVzIwZUg1QjU1Zm9TMi9oOUdpcjZCbkw0Y2cxYzhNRjNWckZH?=
 =?utf-8?B?SEZqb1A3VnBFaldkaHhGMEZHaVFLYUFNTXhxQ3YwanBOZFZid1I3NE9XcVM5?=
 =?utf-8?B?dEtNUlVIRDJPZERqUEZiNGVqWloybmpPaUhZZDVHT1pRMWpPQkh6S0JSOGdU?=
 =?utf-8?B?SVEvVEloYm9CTFpRTmxKcGtOWUQ1aWhXVHk2TEkrcHZHL0hQWkJIb0VLb0xj?=
 =?utf-8?B?ek5uUDdhenpiY3FLT3hDcjFuYWNOdXN1SzZNQjl0UFoza21CdmxSSHJJMW5x?=
 =?utf-8?B?YS9pZzY3aTcyT3R1T0YxZFhTTlR5TlNrZHlzdE03SkhibXRWM1NIMjZNNklB?=
 =?utf-8?B?eHNpcGs1dFNHaG1sMjVZdDRma3RBSUFKdng4aEN5ZGFaV2lWWGM5Vkk4d2tR?=
 =?utf-8?B?TUdOY3pnMUtudWF6TFByeXJPZXlic0xFa3BEWFNXWFozaktzK29VM0R0bGlV?=
 =?utf-8?B?ZXIrUjFtYk1tMTRhcU1RT3k5SmRoeHZWT2drSkN0LzQzTWRZbDlBak1VZTdS?=
 =?utf-8?B?cytJVlJ4VlBrQW1VdENrYTdYellMMUdIUlRRT3g1TytQandwVGtOV3VLZDF4?=
 =?utf-8?B?d2VoR3AyK1Jod0RXeVhxOXNiSlpOa2V1L0xZSGRsc3QzOEVDZVZ2dkVQUDF1?=
 =?utf-8?B?YU5BL0tsTDN1UlhueGplNTFqL3BZLzlKK3hZMTdmMEEveVhjZ3kyaGR5SEU3?=
 =?utf-8?B?a3BqWGNkZVgzNTNMY3o5SGl3NjNRanZaRzgyalFOWWRQSkJUS1BMams4T0pW?=
 =?utf-8?B?cm5QWG5oMjNaeDIzWXRqeTB3cnJCb0NoUnZzaHlkSW9XTU9zUTVtZzRtMVVD?=
 =?utf-8?B?UUFwQWNoSW1oK0N0anFSaSs2VDNEdHVLeURoVjZWNnJ1VTlDZTJ3c2NFK3Ri?=
 =?utf-8?B?Sjdnem5wZFBNVnQ0ZUpiSVB0QjRyVjd3VWVMMVVCbkZhSHJOUGNVTEk0eG9n?=
 =?utf-8?Q?pA0uGRGezwM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFdITTJ4Ym5jVjcyR3BRQVAxT2h5UU5ndjgxT2Mwc3FtKzZBbmVEVllBa2JP?=
 =?utf-8?B?cWtvWmIveS9aTm9jOGZLYkpGdWRhd0pHN3g4Q1RqSWVYLyt4RDVGajNCQkFO?=
 =?utf-8?B?cVhDWisxbnRWcTRIYkJpekRhRkpueGJNL2JhSXVYZVFvT3pJZGZNTis0dlh5?=
 =?utf-8?B?c1pPVldKQmZqZGxFYWQ1VFNpS2E4ckM0SzBhMlR5dHp4Vms0OGVDMmp0Rkdm?=
 =?utf-8?B?SUhGTGJxbnJjMy9hTFBMSGwwNko2TjFWeS94MlJtU1Uwb0xDeXJORWR0bC9M?=
 =?utf-8?B?WnNTd0pqMzlvOVJyRElZQ3ZnZ0NoK0RLTUhXVkl0OThJSzNGMUgwRDh6RmtK?=
 =?utf-8?B?V1NnbDJ1d1B4WExHQTd5dnFLY0Vqbk0xeGZ6Zy9Db1Zqd21lRVNBM3QzdWlZ?=
 =?utf-8?B?cGsvUzVHME1kRlpQZm1xT3VzL3RxTWtuVE5rM3NqWTdZTmhMNXdQazZCVmRT?=
 =?utf-8?B?RWZHZmNTRENoZmR0SGlvMjNoTThqZy9pcGM3ZU9UdHNUb0JHbHB1Ujdka21j?=
 =?utf-8?B?U3RuSzNOM29NeXhlbGg2THZ2czg0SWFlNlZRRkdmb2FpbmJDQ01IejViYzVv?=
 =?utf-8?B?TlZQaDA4YUhKcWc0Um1NOFFLR2RDcHVlS0N5RjExRG1PenJmMUFFdkFWcWVG?=
 =?utf-8?B?YnFOTFlRSU9sNGhuM201eVEwL1ZhVFU1M21KNURydDdqNG5Vc3p4OXlUeVpi?=
 =?utf-8?B?ZkgzWTh1d2FsY2RHMm9sVDhyMjdUVEJlZEROQ0FJZDY4Wi9EZnRxTUExUTFW?=
 =?utf-8?B?Ny9qM0FFazJxWjkxR0pCMHZydXBGQ2JsK0tyVUJLNnIzeGN6V2RxNkdsajVU?=
 =?utf-8?B?RCsxUWw0UUluamUzdGhybHg3WDRNbWgzK1FYYk9JaktWREtFcWdpSXU3UFYr?=
 =?utf-8?B?Vm54NWJvRmo4dTVoc3BFT0d5UlQyLy9Dc1hrWkY1bHFKdnkwMlhFYm9QQzZw?=
 =?utf-8?B?SjVkaUtqbm4rQXZOZHQvUlNXL3hXcTlQaGVodFVvdHY1ZWFDcnd3akg4YnhW?=
 =?utf-8?B?azRmUWJMc20yNURFU0g3OGtxamRkQXNJYm9JaEtVMGNpLy83U0p0dGw1YTB4?=
 =?utf-8?B?TDA3OENjL2VSSnBidVFpVlZtNHdKbVc3d1RWR3dPdGQ4dHFYOG5yazVvZkJt?=
 =?utf-8?B?cXQxUGpCeTZpOWgwYzI3aGc3M1c0THJDUTRZL2FjUWFxYVlRQmV6UnYxSWl4?=
 =?utf-8?B?RFdHei9zMTNLTDNEME9YZWpOVkk2bkFVanZ2aTVKZTdPRlR5V2ZVNnhkN00v?=
 =?utf-8?B?d0VVdHNBSzcwOGVESlg3QWozbHVZb1VYVXlyVTZKSjFqb1dHQm96eHZ2emQr?=
 =?utf-8?B?SVpuL00wbmRYUFlvYlhRK09lNnErRWgrT0VTTmdoUkN2bnNzNmYwbFgvMWhz?=
 =?utf-8?B?bU9lSkZ5TFJOczJWd01CMWZiY0E4U0VkdHJROUFMUUJiOENUU3JSSnpEUWhE?=
 =?utf-8?B?dWphWEIzeWJjYW44Q2FCSWR4eHhmbks5bkxCUkN3R3B1THlUbUJPbDVUcnJ6?=
 =?utf-8?B?eHpET1EreFVpNlM5V0MzTjRKNTdOR0didXlhYUdPdHRpUDJMak9TSFF2Qm5Q?=
 =?utf-8?B?UndFN3hqZnBkay9tVVMwckd4Z3Zyb0JjaG5qc1BUcmo3dmFDdWE0Sm5LNnFn?=
 =?utf-8?B?YVZGSWJ2TEZkaGJwUzVTWkpoVUk4TThwYXJ4TDRLQjR3T0FMZHJqb29pMGFO?=
 =?utf-8?B?VzdFTTlzVkY4cXh5VnBxNjdlcFlDU0JJZUJreWoxRHVqeVBCZURZRFptYlNO?=
 =?utf-8?B?NHRtcFhPNGxHQUF5Y1VBa0ZqdDM4VjkxYldteUdwOU55TUYxaDR2dVZMUjJl?=
 =?utf-8?B?UFZMRnFSc09WYS9Jb3VNYlNicnFGeDNaUC9LZ0NQSVhkMDN6bjNTSzFqaGds?=
 =?utf-8?B?TTFkeEsrWHBXRjdJcmVWMTZhbUoxZmFxUHpReUtHVm4zaWdDS1VEQnUreTFK?=
 =?utf-8?B?QTExSTV4eEZ1bFdPQlZOY01qMnF5REpsbnZ3ZzlNSE84ME1ybXMxMmtSTGFH?=
 =?utf-8?B?WVlSMm85VlRYYlRNZXVmaDZib1V5K3J1LzhqK1RVWjBMSCtRTTYrVkViWWxP?=
 =?utf-8?B?TGNNbUloaitEMWJ6V2FPby9vd0cyRlJQUzZNaUxObStIdVVHOGtVZ0owWXU0?=
 =?utf-8?Q?+eFIuveuunV6Xic3U0Ksa6iK5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3b130e-ec28-42c2-2eb3-08ddace728da
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 15:04:58.4649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTK774PAEgOCVoYoGDh6j8ePEZr7DeFzERtkDt8eZmFemIo7AViy/6zU0tegt8Lx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
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



On 6/16/2025 8:28 PM, Alex Deucher wrote:
> On Mon, Jun 16, 2025 at 10:47 AM Jesse Zhang <jesse.zhang@amd.com> wrote:
>>
>> This commit makes two key fixes to SDMA v4.4.2 handling:
>>
>> 1. disable UTC_L1 in sdma_cntl register when stopping SDMA engines
>>    by reading the current value before modifying UTC_L1_ENABLE bit.
>>
>> 2. Ensure UTC_L1_ENABLE is consistently managed by:
>>    - Adding the missing register write when enabling UTC_L1 during start
>>    - Keeping UTC_L1 enabled by default as per hardware requirements
>>
>> Fixes the commit 7f03b1d14d51 ("drm/amdgpu:
>> Remove sdma halt/unhalt during frontdoor load") by maintaining proper
>> SDMA controller state during initialization sequences.
> 
> Proper fixes tag formatting:
> 
> Fixes: 7f03b1d14d51 ("drm/amdgpu: Remove sdma halt/unhalt during
> frontdoor load")
> 

The default reset value of that field is 1. Keeping SDMA unhalted but
rings disabled shouldn't ideally be a problem - should be similar to the
case when it's loaded also.

Thanks,
Lijo

>>
>> v2: Correct SDMA_CNTL setting (Philip)
>>
>> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> index e6af50c947a1..52157acab55a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> @@ -492,7 +492,7 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
>>  {
>>         struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
>>         u32 doorbell_offset, doorbell;
>> -       u32 rb_cntl, ib_cntl;
>> +       u32 rb_cntl, ib_cntl, sdma_cntl;
>>         int i;
>>
>>         for_each_inst(i, inst_mask) {
>> @@ -504,6 +504,9 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
>>                 ib_cntl = RREG32_SDMA(i, regSDMA_GFX_IB_CNTL);
>>                 ib_cntl = REG_SET_FIELD(ib_cntl, SDMA_GFX_IB_CNTL, IB_ENABLE, 0);
>>                 WREG32_SDMA(i, regSDMA_GFX_IB_CNTL, ib_cntl);
>> +               sdma_cntl = RREG32_SDMA(i, SDMA_CNTL);
>> +               sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA_CNTL, UTC_L1_ENABLE, 0);
>> +               WREG32_SDMA(i, regSDMA_CNTL, sdma_cntl);
>>
>>                 if (sdma[i]->use_doorbell) {
>>                         doorbell = RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
>> @@ -997,6 +1000,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
>>                 /* set utc l1 enable flag always to 1 */
>>                 temp = RREG32_SDMA(i, regSDMA_CNTL);
>>                 temp = REG_SET_FIELD(temp, SDMA_CNTL, UTC_L1_ENABLE, 1);
>> +               WREG32_SDMA(i, regSDMA_CNTL, temp);
>>
>>                 if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) < IP_VERSION(4, 4, 5)) {
>>                         /* enable context empty interrupt during initialization */
>> --
>> 2.34.1
>>

