Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E336C0218B
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 10:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B20C10E55F;
	Tue, 21 Jan 2025 10:53:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qKo96iTd";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B124310E55F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 10:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCBL+aQIoUcOF9EMwJstsn3Uv7G8zYw4nCwkO6n5pYCQqO7aCje4hzSRd4pnwD66Kzj4Y7DlAb0UM0Fawl3KK+ARpbJwu6NUgf6AGiyhAD/nExiYRqFhUXa6v+1hUfRiqDo4QawM6U5kd8EJJqxz5n+TlzlMhFnJEo8uGujBupeaznJfBrG0FFC/zjI5Cqt+JRrcQ0+pBBCLh2vaeCgfo37UDvCVTybJa8Fj3KgRD+vNCxILvIdNiq1H5zi6obr7kI/rpoknqPjnITmD7+kWNiMxWOTrmrbTdxxJvrlOE8iO8RRiCT1yKX9MaSeZGlbVGANE46VDkmGbNsiOpCQnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EAcxcfAGuoL5DRh6EWSngmv+K2ojWZuH6anvO3V12I=;
 b=xQihb99xs3eaKWovvcRAg+A5frM+l1+P9ffqzaoN1096R/EvPBu3GsxOmJhpqS7s9v8fb28gnJ1rNJszi5vxOehcn7+3+hDE13rmh6n1NgwHDHHf/1ttJuhFdxbTPLz36w1V9gm0RCDtB9EnNzCF4fkOrRHxu0e6r1dAuUjZB4bwsSBlVVdL0bd8mVPesB0HK5Hqi1r3GFU8TDrSMYiXKEyUZR+9+tD3p2dTIwaXh76ZGiZnf/WPzMB5QVSSwrRp1K8DF//kQLsa9EPuZljlmweT9aH5u608zJHG9tVjdxDkKi/v8Csr/wb7tREfSIsXpZyZt4K8OmXa7uaYc4FATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EAcxcfAGuoL5DRh6EWSngmv+K2ojWZuH6anvO3V12I=;
 b=qKo96iTd4m/cGwS+tEBdRNEFeyZFPOcmjhBdQkkg8ghrf8ZjZtXVkMASXALk3CPOsUZHYWpcLz/zIMh8C+6b7DttLnCZxF3OcAz1htUasOYw7G6lX4VxEbaUBLQiqjDUFfawUbWXNqje20UDOXoggO9w2O78yI6e4KFvymfAkaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 10:53:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8356.014; Tue, 21 Jan 2025
 10:53:08 +0000
Message-ID: <498ef4ae-f549-464f-a77f-090a91973ecc@amd.com>
Date: Tue, 21 Jan 2025 11:53:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: remove variable vm in function
 amdgpu_ib_schedule
To: "Lin.Cao" <lincao12@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250121065002.1143246-1-lincao12@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250121065002.1143246-1-lincao12@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2c83f7-e21a-489d-b2c4-08dd3a09ca6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dU0vdmFTTWw1MWtVWUFBdGhIdGNVZ0RsQjJ0aENsTmZWeEVtWXVWcHBjSzNa?=
 =?utf-8?B?ckp1QWpFYlhEd21pazFYTElnSEVidGsrUDBBUitHQ2U2ZkZ5dWJuMk8vQThr?=
 =?utf-8?B?bTI2VFlrUm8wcnBqVW0wTXRlS2x1MTZnU0h4Z1A2U3R2di9LWTgzdjN4YVEv?=
 =?utf-8?B?aTFEdS9UR251Ymd2M1ZaZU8xZW9KUUw2ODM2ZC9lMDFvVXI1K3JmcHF1aFZH?=
 =?utf-8?B?TStWY1hldy9KOS9VbG93UHlpZ25DN0JBMnRKL3ZSU2JLclpJeVZSSWVIV3hk?=
 =?utf-8?B?VUhyV0sydEFyeGhrNWFaZTdIQ0Z4Y0F2dXhUc2YxVHA5V1IzSGlmVEJNTVpo?=
 =?utf-8?B?c1d4OE5hclloMlloMXgvZEpjYVdZWnY5WW05cjNQNUxiVldPNjl3NERaNHRY?=
 =?utf-8?B?cU9abjh6Q2htZUxKRFVLaXBBRUFYeVAxejY3RFF0NFFLNlhHUTJtVnhCekFW?=
 =?utf-8?B?TTVXVVNQZEJtdldjS3JQOU42Y1VCZTlLVVNKMzhwa24xUkFXbldEaXhUeE9P?=
 =?utf-8?B?V2pvS3A2N3dSeGEyaERqeXF5dWw0M2dMQXhQYkFNY3huU2NncHliZjhjak9V?=
 =?utf-8?B?MmR4NHFEdnplSjIrSmk2NTlaa3dXdkdRMUFMRXRTcGl6RXBPMmZ0YWtwbTVO?=
 =?utf-8?B?ckF0NmJMU3VmeFl5MEVkYWRIOVUrQ21Td1U0NDZIa2RhY2VYT3ZmaG9oRVJl?=
 =?utf-8?B?c2grOElNazF1Y3VtT3pYVXl1TUNRWmNFYzZ2SzE1OWRVY29md3JJUlo3UkZu?=
 =?utf-8?B?WjhmODBER0FsMjB1STR4ZkxuRC82MVFZd0JTdnRsMkZkeGJXem1LM2VGdFdh?=
 =?utf-8?B?dzlHT3A5elg4TFA5MnNRc1RiOWFoV2RtWkJ2OGpBVkVqcVM5ZnB1ZUdPRGY5?=
 =?utf-8?B?SU1zV1BoM3E4L3loRzhYL2pXY2cvaWZrdHRuMTB5eUpNQ1ZDcUxSVEVwcFlT?=
 =?utf-8?B?NExscEN2b2pzaW8zVG40UnhkZ0FaTHBPR1J2Q3FzeTJBYVIrTGpRNUJpZlky?=
 =?utf-8?B?SmR1bWs4TGNSMGF6L2VZUmdEUGxlSm1kcDJEZUlBTGh5b2RHaHBlY21GVncv?=
 =?utf-8?B?dTlTN1ZxOW1rSEFsT2pFVjEvL3hYZ3U4SXF1V1NBcHg1eUlrUWZjWXg2N3Rr?=
 =?utf-8?B?S2JyWGoyMzVUL3NzSVZ4ZkNJcjhmMVhjaW9HT25xc1VkWnU3NnFYNmdQSGhh?=
 =?utf-8?B?cG5Tdis5T3I4VzUwaXd5MVkxUkpQMlcveVdqd004K3d6VG1UbXV1WXF1bzF5?=
 =?utf-8?B?TmlYU3o2NXptZlgxOTBtVEpXcjlrUW1YdUlsVzJZWXFuUklOZFNvLzE0ekVo?=
 =?utf-8?B?Q2hFS1RCVHZNcWsraW9aK1pDSTZydkZsNVFYL1JOaWJKZ1hZR3F4RWpzUk1k?=
 =?utf-8?B?a1FiZzk3MFdXeTRDMmZweVFoMXlWWmFxblI0NUpwMnduT1AzeVFGU09pSGNj?=
 =?utf-8?B?QTE0L1RVZDhKbko0U3QvSjJjbGxCZXNIY1lzWkVnUWxMUDRtL3NHbTUwaml1?=
 =?utf-8?B?L3ArYk5LcENObzNvaHZaREVoTEV2TzFhODVDS2JHQ2NVQzJtUzVQeHFkdytO?=
 =?utf-8?B?R2svSUdZWFMwSUJFTnZqQVRzc0JTSms3ZE0yUk9JUXh2K1ZJZTlodUFaV25S?=
 =?utf-8?B?YmVMdTVuQmZ2cXVLQTkxODBBUkNxUnZndlZrK1lQQXJvSEFtSUJmTWROL1gy?=
 =?utf-8?B?QVRZbC9QcVdtNWtRWHhhU3dyZURIMVRCSXdGeGQ2REMyMEtaRThha2FLbXlD?=
 =?utf-8?B?QlZXN3V0ZlM1N2ZEVkpyVjk4Wk1aYzJHcWVlUmR4MkdmeFdBd3dQazhqeUpw?=
 =?utf-8?B?VGVYKzR1a0xaL0JKYmJITGhDbzl3MzdVYk1KbmUyNEJuOWtzcjVvaXlmRmRE?=
 =?utf-8?Q?BL5+vrQpZZJUB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWd4clgxRjdNLzlwUnFMVS9VVDlRcG9LVzNPMFpXaUtlS0Fld2FLVlNYUHZY?=
 =?utf-8?B?ajl1T0FLbWcrSzBQQ1YvdTBLMWFvM3NtQVdyK0U3enljRlNsYzEvTzEyaEt2?=
 =?utf-8?B?ZWhlN1hJYXBJWlZwb1A1UU55K2tET2lqbU1WdWJRRXV6TkxQMzNBSTJYRnBp?=
 =?utf-8?B?OHA2WnJwV0dERUc0YlZtQ0x3M2pyTmEyTjlsZzFTbVJYcHlRY1lEdmNpOWVt?=
 =?utf-8?B?Q01GWjJHWUtaYlhIRTB6THBjTVRXUnVQeGVXMHl5b1M5aVR6MzFEMGszYWhP?=
 =?utf-8?B?Y0VzeldQaWZSRFZXUHdDSEpibFJibGFjS0x4UzNpWDB2WDJLV24rVTJqR3gr?=
 =?utf-8?B?aVdyRC9DcTBWakd5VGhaWitkOGVDcnVmT1YzOXF2dVZ0Vkdxbndod3FCaGdT?=
 =?utf-8?B?dXNJbXk4aWcxb3BGdGZQeW03bTRreStscU5DeFVJQjhIeXJVYlF3dGNQd3g5?=
 =?utf-8?B?VytrQnBWdjMzQnFDOHpyWnJWaEJOUnlCblZjSDRXZllNekJnLzZoTnlyU2p4?=
 =?utf-8?B?cGFXejVoaEdVZzhDT2xOWHVydUVWYmtRWHpGRUIxb0VyTVNRd2VhNjJ1ek1t?=
 =?utf-8?B?cHZ4dFBaQVVtZVgyQVlQRUZZb2J5MmZTTEpwMVl6STd0SlgvTFczRVdpeFh5?=
 =?utf-8?B?NEZOTkdWVHl3akJERGs4YUFycHRxQVMrYnJWaGJiTERBWXNoS1JDY3FtSkp4?=
 =?utf-8?B?ZWJzeWZyc3diSWd1OEpmNnJoTlhiUXBhR3pKQVVsMmVJS25tcXJESnRiakZL?=
 =?utf-8?B?eW80THRnUUltSmZWdGZYVnZqOU1QTkZWcGIrM0F5NHpJT1pyUWpXQ0V5Yzl6?=
 =?utf-8?B?WkV3ODBzQkt0cXhIN05BVDhXUHFkbFpwR1JlYUhvNVVMUzF6YU9ET2ppbkpK?=
 =?utf-8?B?ZTlPdTlYb0NSZ1ZqRE45dGxJeTRkVWU2UVZwVkZaSEJCcGhaRzFYQnRubXJ1?=
 =?utf-8?B?QnUrOGhpcTBDSlNMbWhyckk0bnFVazNxWk1WK2YxQ2J6N1J1OVBmamZ0MGFZ?=
 =?utf-8?B?YmkyUDhPUHhjSzF5RlBDS3hqUWNSZjdrOHh4N0ZnMWZaZGtxTzdMTHY1dnBN?=
 =?utf-8?B?ZjBMMUx3ODR5WUNLSVpnWVFtaVQ2SmpiNDZhK0E0Vm5rb2FaQWtmMGRYMHNk?=
 =?utf-8?B?dHZ2L2h6U3RZSkF4MjBtdWJBZXNjSktMRHZZU2xpMmZKdTBETzRlbmNRSzBs?=
 =?utf-8?B?NEFuT1NnUC9NRTBYcnFVQkpZbGNkdzBicjVPZG56d0V6czZFNy9KWlJQbkFq?=
 =?utf-8?B?TWFhK2NDaTBMcGxpSnhLY09rQWppdzhFZXRSNDcyRXZ0VEh6RGJ2dXVNa1JL?=
 =?utf-8?B?bEs5VzZ4R0x6TnN1QTQyY3BLSmliWVNCcGFURllId2txRHZZSGNoeEFFZlZp?=
 =?utf-8?B?TnRTa014M25zUzAyM3pJbWRkL2FsOVltM3VoUFIwa0p3OFNNdytUemJnYkVu?=
 =?utf-8?B?TEJCVXgrQmd1a2sxWmFXV1B4cVJ4dlk3aDBOaGMrZVd3Q2RSZXRmTTU1d3I1?=
 =?utf-8?B?Z0dVdWo3eWRqZlorTTVTVDVhdGpNZytUVXJJeXJsTUk5R2s2RGRXd25ON2lZ?=
 =?utf-8?B?OEZzQ25hOG9id1NiaXhKdkhtVCszNGdHQUpMRVdTbUoxTjNjNUpWenQxN0pZ?=
 =?utf-8?B?N0JyWEpvU1FZTFd5Wm8xVGZWeG5SVUhlT0xGdHlrTCtHVWI4cTI3THI0bkZn?=
 =?utf-8?B?Q0hYeHdsZExsUnRpOEF5bTNOWjVmQjhkWDEwZnpZYzhpZ1hpSU9yZlNNd1gx?=
 =?utf-8?B?U0ZqVWlkbmhDb2JuTVFzUGN0c1A3T1lFemhiV2U1VTJ6VmVIY3F4dkxGcllE?=
 =?utf-8?B?ZlI5TVVZTjdjREdvK2pndXVQSktoU2ZESDdUdVA3djRyZUsxOW00T0pIeFAx?=
 =?utf-8?B?YmZVQVpQaThSeUNCY3ZKZVZYeFp3OHc4NGk0K3dKa0lDNHl1dVhWRzZ4QzFs?=
 =?utf-8?B?Y0lCRFczTXFRRTRUc01RWHBCODlMbmFvNFBrMWJRRllLRnBDSVlMWTIzQW84?=
 =?utf-8?B?cVpUdFFydSt6R0hOSlkxdHdpcHEvcWVQeGhKSlgrQkhmMnNlMzROS1JZQjNQ?=
 =?utf-8?B?Lys0V1RpTUdlZHJqUnhGeXZGdDhDNXlKTWRRK043ZTlBZ2c4endEcmZQbGpm?=
 =?utf-8?Q?bG4g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2c83f7-e21a-489d-b2c4-08dd3a09ca6f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 10:53:08.3189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMFnzeho1o7L4jy/nv3BNc+zhuOQhES/0BNmGkcRV6rgD9tcRDztO3aZFvhhr4WG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738
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

Am 21.01.25 um 07:50 schrieb Lin.Cao:
> use job && job->vm to check ib has vmid and use job && job->vmid to
> check if switch buffer should be emitted
>
> Signed-off-by: Lin.Cao <lincao12@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 2ea98ec60220..af908932b8dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -129,7 +129,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   	struct amdgpu_ib *ib = &ibs[0];
>   	struct dma_fence *tmp = NULL;
>   	bool need_ctx_switch;
> -	struct amdgpu_vm *vm;
>   	uint64_t fence_ctx;
>   	uint32_t status = 0, alloc_size;
>   	unsigned int fence_flags = 0;
> @@ -147,7 +146,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   
>   	/* ring tests don't use a job */
>   	if (job) {
> -		vm = job->vm;
>   		fence_ctx = job->base.s_fence ?
>   			job->base.s_fence->scheduled.context : 0;
>   		shadow_va = job->shadow_va;
> @@ -155,7 +153,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   		gds_va = job->gds_va;
>   		init_shadow = job->init_shadow;
>   	} else {
> -		vm = NULL;
>   		fence_ctx = 0;
>   		shadow_va = 0;
>   		csa_va = 0;
> @@ -168,7 +165,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   		return -EINVAL;
>   	}
>   
> -	if (vm && !job->vmid && !ring->is_mes_queue) {
> +	if (job && job->vm && !job->vmid && !ring->is_mes_queue) {

That check here makes no sense any more since the VM is already cleared 
when that function is called.

Please completely remove this check since it is superfluous in the first 
place as far as I can see.

Regards,
Christian.

>   		dev_err(adev->dev, "VM IB without ID\n");
>   		return -EINVAL;
>   	}
> @@ -297,7 +294,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   	amdgpu_ring_patch_cond_exec(ring, cond_exec);
>   
>   	ring->current_ctx = fence_ctx;
> -	if (job && ring->funcs->emit_switch_buffer)
> +	if (job && job->vmid && ring->funcs->emit_switch_buffer)
>   		amdgpu_ring_emit_switch_buffer(ring);
>   
>   	if (ring->funcs->emit_wave_limit &&

