Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69793C3ABA3
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 08:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB29210E385;
	Fri,  2 May 2025 08:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E8jpxPAB";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0723D10E385
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 08:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBoyxRmiuQ7b9QhzEJG1PTqO9p1kmiyzrDB/sqoFYdP06SVME5VwCfiY5MSk80d5MGQpa2VbV193IQm/1uFPavAANuKVJ7Mi/mELQ6DPXnBKePmmXwrbdzCH5J/fnqulFSmDCjyo73p45xE1sjPbpU1DTLVhRKs3BQPm/u7IvRj6xmW290qHc+PJe/3aH/m7VujEumiveAv/hzAaHK6cdF41MaSY2/efBnH7i482VfhGHYttqVIeOc8e8QV19xBDvufdwwn/G4J+Yk7xvmpXhOFU3ebcu4tU7rFJiElR+bByCyGviCwyOdHK9yUZOGAilmfpPJqmQvTcXA912BDSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya3BaDnNa7d5sWDDDBTxQJQA4C6j038aB/f8KyYohAQ=;
 b=lCAdh3644adOUoa1oXw0xqoSwcNYqNp9/w8fT5S53i4eW691uYSPlVoZGHkYbfF8lPXh7o47zLCtzPbi5EAWiJtiwN7INE1QbnNBKegnwEYYoExKG0j/EJSMp/PyYKQTGDc731wr3MK/N7VqHdSL9+BcwNqGXdBruQ/TNbar9TPdJ9J2yJkgyVUmNboajuDkx34IZ89lz/m8QGSbZbfn8stN0Fq/ID6RsxmBqpxzaCejMPv9eFtrvkpKMe+VCvhjtdCgJ54ZbXbVXOdZR5A80bPeICKz4ucQ96W0cDda7jXqkJOtFYrWMU9sTFG7l4KxtpYyuTU4G8D+E63jiUF7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya3BaDnNa7d5sWDDDBTxQJQA4C6j038aB/f8KyYohAQ=;
 b=E8jpxPABoYy2angGt4xdHTRXvYuUuFMaogPvWxFoooNl4CGJ/dhWwX6Ax7PIq6z54lw/GkbRMWspkHo9tLsDyWrSSnYSpWW6eT2QDr7aA/EVsu9srinhnp/evsnMJkaXzforIEH756XVoGYvGqDSdbqsmhJDEbhxzKjDA6mQfCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 08:28:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 08:28:41 +0000
Message-ID: <602e395d-4cd5-4872-9773-6db38419675b@amd.com>
Date: Fri, 2 May 2025 10:28:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to
 total vram
To: Alex Deucher <alexdeucher@gmail.com>, John Olender <john.olender@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-2-john.olender@gmail.com>
 <CADnq5_OMd-oHqPV9cC-GQGjf4OnN7EdvL3T9gopC-rEPMWs0vA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OMd-oHqPV9cC-GQGjf4OnN7EdvL3T9gopC-rEPMWs0vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ec87e6-54c4-437c-dedd-08dd89535823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejRRYnROd3BqbEdnTk45UUFEZW11c2pJbkFuVHdvRHh6U3Zya2JkVjBZOVht?=
 =?utf-8?B?Tlpjc091U0Fodk1idWh3VmRkQzAydHhVeHgraE05NFVzTFc0V1g2alhMVWo2?=
 =?utf-8?B?RzNGYnhQMFE3V29DTWlUaEh1WnNyTWd5TVkxZzhTcFdYUURyN2tzT3JIUjFl?=
 =?utf-8?B?RGoxaHdYOG1Wa1V6U0lxeEQrWlhnNmo2OHNVVXRkR3BMTFhKc1RFMTBwYkdP?=
 =?utf-8?B?K1FQMUVNS0lYZDdOcktMVm93bmpSM21iaExKYTZ4U2EvRncrVWR3Qk1CYmha?=
 =?utf-8?B?a1p6aERXVVlXUlBrOUxqb2xpVGgrYkt6Y1VWMEYwMi9ZTE5qcW9ZbmM0U3VS?=
 =?utf-8?B?c1JReFRxR0RhSlBVb3VCRlpLSUVyZ1hVWHJ2dW9PS05XT1lrNWtUcm94WGJQ?=
 =?utf-8?B?ZUl1NE5UeUgzUTlOWWk3elBXK2xlVXpCdlowUkRVLy9YL1c0Nk1GLzZpaENG?=
 =?utf-8?B?dndXdWRYYUcyUG5MOCsxZm0yMGxQNU5QZmJUSHJkSHdmODVrTEVXbUJkeUp6?=
 =?utf-8?B?dTlwYmtPNk1TaDhWUk1BMUsvUDAzRHUvTHlNVldtdkNHdW5uVSt4VndMYW9K?=
 =?utf-8?B?MndUaXRhaW1sditQNmpMakh3d2JDVFB0bkZodzhNeHJqQTZNRys4bXhucklk?=
 =?utf-8?B?TlZ3ZzJJanZJZ1BYa2lENU5uYmlkUUN4SUpPY0xQZlVvaG9FQVJUY2xvTW5t?=
 =?utf-8?B?K1hzL1hYZjBBZVpFQTFqNVBHeGhYdmI3Y3d6U1BqT0F5QUdkZFlYSGNOMkVs?=
 =?utf-8?B?ZnhENUJGOEtzWDE0WEdId3hlNjdVVnVNYlJScURpbjVnNkRmOWhIR3E3Y2d6?=
 =?utf-8?B?VldreFAyVldPREJkaEdYYjRzeCtDd1JuS0RwS1ZRUDVrTzVLYUY0Zk5vZ21W?=
 =?utf-8?B?RWxDZW5uTDBmN1ZXdTNrM1VGaFVjZDlMOVBPZ3ZPWDFadDN1S0tUd2VMaUND?=
 =?utf-8?B?QVQrR2hiOTFNamdFWDZZWVUvTjhEL1kyUGtqN1BUNjAraHFDSTdaVTRha0dN?=
 =?utf-8?B?ZE1HdUE5ZnNBSitxUGlFY0ZnMmtDSWRNYlBUZktxMTVObG11cUlyOXNscVcv?=
 =?utf-8?B?Yyt6RkQrd215QjdPK2tEMXlYMlRpQVV0aWNONlFlejNWVjVUcmVOanJsSjJI?=
 =?utf-8?B?QjBlMmVReENYYkIvNUphVVRuSnZGK2RReFpRWkV1WitCSTB3dnowazdIKzVr?=
 =?utf-8?B?T0V2ZEVsaFh3SDJXWWo2aEM4QWJyQk1yNytZbzRvWVJMOXNrUklqNmxUdTh3?=
 =?utf-8?B?Yjl0MjltUGRxRUZrMTQzRG4xZEFGMWg4Mlg1dTZ3TjhDbGpMa2tha0FVeDJD?=
 =?utf-8?B?MUpGUHlaTkZrTzRvdjRKa3U5MEhIM3VXbWN1WEpSemxGcVdRYko2ZWJPTXZJ?=
 =?utf-8?B?WHZZOUd4eDdtZFIrdWFwZ1FkY3EvV1l5RXdjSk9JWThPUmNtOFlZeFZ6ajZV?=
 =?utf-8?B?UWNSM1haVU1HNVhJaGhRRDlmYkVxN3cxRHFuaXRSNnMyTGhUd2FCNmJGcUFS?=
 =?utf-8?B?MlhVQVg3ODlZa2lJNWxpS3NmM1BvUUZsRE1SdkdMMFdUUUFod081SmRIMmox?=
 =?utf-8?B?WlF2SmdxU1dsUUdnWXhuRmx6eU9nZDNQY3FmWTIzK2daVWtta3dWUTFORTFn?=
 =?utf-8?B?aXRRQkNIMWlTNGVLUWxnQ21RYWdSZlppT3gwZ2xEclZtTUIxT2hHRmt5YXRD?=
 =?utf-8?B?TU53UjFLMmF5QldlM1JYNUhRdXM5elZZQkpWeUNJdFZXYkg5TFRmZHZrUnhk?=
 =?utf-8?B?L1J0Y3FxcmF6TzhFOFBJajZwZGo1WGtSK0J2RFhkL09RNHZndWJ3SkdXbnNX?=
 =?utf-8?Q?tsW0UM9qWjiWDwZRx2U3XPGYSwHZdBI0NuKpM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjRMSU5vandUTzE2L3kvS1dMUHZoYkJzdnAwZ0pDanNDNDBLcllNMnk1dTdm?=
 =?utf-8?B?REJQU2ZWL25uK01GZWgvcW9TSjROREtjRndCZGNTcUF4WTZCQmlsVEp1N0Rs?=
 =?utf-8?B?di9RWDcwZjdUcWlhRXUzZ3JDQ09xcGw5aXZJYTZNVkFtVksxcWMvTWpKUEtN?=
 =?utf-8?B?Z0JqSGtHWlZmUnI4NVJVUU5XKzQ3OEFkNmw3VThYaXI1eTgrdENneDF1WEsz?=
 =?utf-8?B?K0F1ZnpRQ3BOR1hnSlV2WG02VkluY1kyeWxrV0RIbTl0cFB2ZGJwTkNyQmkw?=
 =?utf-8?B?RTdMVUwxRm1LK3lIWmJCanEzdVFVVFNwdFpzQlFBcFFSVnMzUDZUMThXYVVE?=
 =?utf-8?B?aE11bnZUTUJybXoyNUFPYS9aQ2pKS2E0bzZDaHlMWHJMNWQzb2hYRExLRmRk?=
 =?utf-8?B?bVZ5NlVybGw3bjB2QkZ0NTVvZEV4ZVFJQ1FBd3hEbWJyM0JWMmFBaUR1UVFQ?=
 =?utf-8?B?czBVYzJiKzY2ZmlLd28xaGNLaXVIQmNYY202SUlSWUlCUVBOYXFpRHlsY01s?=
 =?utf-8?B?UVpvbm9qcS9RYklmY0RnaTNqL200SXJlRmwySHZlcnpHKy9SWFppSDJCaWYw?=
 =?utf-8?B?TjFjUDg4VXBsVyttR0JMMzhpTW9jTytmVWJGa3FEODdvYm9qMU10WjFyaXNh?=
 =?utf-8?B?cDNOcEh2aFZCUFZwQ245Z1hySms1N3JNZnZsK0ZoMVd5WmE2bHo5VlBJVXlU?=
 =?utf-8?B?OE1HTzg4QnJVMEJuSktzcWJsNFkrY0gveVFFUVhiUVpIeFJkWlVNNFhlRVpk?=
 =?utf-8?B?b0ZXSGU0TVY0K3pWekFCMFNPbFIzMlJHN3FaUi9adjJJT2VrdjB2SVBBbTBu?=
 =?utf-8?B?ZVdiQnZJOUhQN3BNZWFNZjZpZ2tMc29MMThweHRLbFhLemgxMExkUUtGNmY3?=
 =?utf-8?B?NlY3SUdNZnJybnBwMy9nTGUrcUNtWWxYT2pTbWxPMmVqWXYzWmM3dkJVcXZy?=
 =?utf-8?B?dUp2V2o1L0V6K2dOWnpsclJ0bWp1UW1tT280QlV0aDEwVXhuZ1JjV3BFbkJU?=
 =?utf-8?B?K2lBVVFHaFU2bUh3RVlhTHVtWUhVdTRCQXNQTzB3bDBST0RJem5ZVGk3Qmdm?=
 =?utf-8?B?NFROOGJIdzBrdmNJN1I2cTlqbVkwSW9PYTdQaUxYUTl3VDdZbnJKNlNSZ1dF?=
 =?utf-8?B?c2pobUJRWHI3VE5Mc0RXOUFJN3RRN3ZHSmNCOFBUSDFabTgweDlZNG9hQkFr?=
 =?utf-8?B?WU04RHlBbWg1L0Y3WkNvVjY3U3h2Vm1DbDA5R2ZPTGVGcDNlZkE1bXhxS0ZG?=
 =?utf-8?B?amVmZ1ZYTXlrcGVuVElwYjhQZ0tmZGpXZWtNdytTZmkzSkw4UVcrTVovcTBt?=
 =?utf-8?B?K0ZjbzFPOUo4SE5MbmduSzE1NzhmenZhenBjeHpxUGtoMlkrd0oxcjFGUWZY?=
 =?utf-8?B?U3dTeklPVEd5Wmx2eXVmb0E3S0RtT3lqQmZ2VXhLR2dTbUk5a2hqeGFJUEJC?=
 =?utf-8?B?dlFNYWkxTmVSVXM2bzU2MjlMV0hFVis2WVI2dUVBRWRaUUxSamhPOGgwNjkx?=
 =?utf-8?B?VmpJYk9qZXh3b2EyQ0xFa0VyL3JHb1V4cDZjMUFla1AwTDFlUlQwQWNPdnpL?=
 =?utf-8?B?bWlGZm11c2hXU2lZOXVmSFFGVFVQQ1hkbk5Na0h4c1Jad0NzQjkrbDQ0bWVC?=
 =?utf-8?B?OCt1WnVnTGU5OGZoZ3hlT2VFbkhDV3NjSlpPVmVPMW5WeHBwWHUyeHZtQ09h?=
 =?utf-8?B?NWlvS3VDb0MvZFc5ZVhtUE5ka0xtWVlNS3dOMy81ekFkbHJ2aVVseGEzL2JV?=
 =?utf-8?B?THRKaExaa2pnb011UVNYbG9qSDBuV2pQOHF5OVVpRVY0eTdoREZhSjh4bFBW?=
 =?utf-8?B?aWF2NmRQUHRFY21zVHBiQ2NBU2hwKzRYZkV6ZHNLMkZoaUtVbFVCZFZBRzIz?=
 =?utf-8?B?dnZTSUVMVnlzRmY4bUlPd095U3hlUHdwZmRqcU80RmZHTXZxczlnYnlLcWxV?=
 =?utf-8?B?QzY1RFVCY25Fa1R3My82VlloQnZORnNHbjY5aFRLS0FhenkxKzRXMXNnbkxF?=
 =?utf-8?B?Q0JKeDZXMjFiVEROMEIvMmM4NGFLUUE1RnAxbUpNMDNsVm1VamY4dHBTdVRH?=
 =?utf-8?B?WVVEQnhRT2lVaENlV0EzcWhZQjhJZHdRYkpuUUJOa29QRFhPYTN1QkNvMUdo?=
 =?utf-8?Q?NGWrz9AWSg5Kbp/VRartvHCDL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ec87e6-54c4-437c-dedd-08dd89535823
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:28:41.3011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hlh3tpMXBZlgwLqI14j1NCs2p3X8qQC0JbRCgi421ILA7d/b3g1tRNOjeWTI4zV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906
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

On 4/30/25 23:20, Alex Deucher wrote:
> + Christian
> 
> On Tue, Apr 29, 2025 at 7:24 AM John Olender <john.olender@gmail.com> wrote:
>>
>> The drm_mm allocator tolerated being passed end > mm->size, but the
>> drm_buddy allocator does not.
>>
>> Restore the pre-buddy-allocator behavior of allowing such placements.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3448
>> Signed-off-by: John Olender <john.olender@gmail.com>
> 
> This looks correct to me.
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


Good catch, Arun needs to look at this.

My educated guess is that it would be better to make the drm buddy tolerate being passed end > mm->size.

Regards,
Christian.

> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 2d7f82e98df9..abdc52b0895a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -463,7 +463,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>>         int r;
>>
>>         lpfn = (u64)place->lpfn << PAGE_SHIFT;
>> -       if (!lpfn)
>> +       if (!lpfn || lpfn > man->size)
>>                 lpfn = man->size;
>>
>>         fpfn = (u64)place->fpfn << PAGE_SHIFT;
>> --
>> 2.47.2
>>

