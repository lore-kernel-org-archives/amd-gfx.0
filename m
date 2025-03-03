Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6EBC282C6
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 21:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0457610E4CE;
	Mon,  3 Mar 2025 21:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GDtXGQLM";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 611C610E4CE
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 21:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNEQmP5cN2+zbor1fp+DFLqMO4MtYTZJe7CNlSyS7/mfghN1xr2L878hDu7+W53q/m6lFxBJUN4vLAe6k5sispy55m0C7LurMd1mlhctbF1mRR5m0qbmuNcub7Z1E8B56C7Hbc5fgOT36MQ4A2HwXU7PK5DeKxrfXHcrLZFFF8W/xUEt0CnpCzF6BTLF0fgtJTqtFTS3pEe5pPNam3CjF0RH9O2HFEP+RO4qd8mKw087GfZkE5xsOc/5ptnENlzK216+c5mm5GypPqwTSDtk6fZUwSz4Ci6tX8FhFg7MamjXGXLrslVFi0+ox/1HPMTu0fD6MQBLxZpbYKS9Y0dxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNW7QunhimmKLZxaiQWxEws9mL3oZSYrd68gyTRXiUE=;
 b=hP46GTm9FXDqZreHL0cDpwzid2PgMBz4YqTq6w4l5aA41nL1lzVQKZQvhGq7XVkYqYMSspxXDnNjYm3uHUppBt82lHCK7LennegJzz6Gji0GDay84TXerbKVD21HxkHR7WJZKYKFN5owLXI0Qsz9P9wlV/noUpTaZt03GKPaAGlfOvqJoVFvnImgV6guwLcYIo0rB5pbFYb+Yyam+R88sTsK7Zhl0DS3FIA2fsF7sEVJU5qR0MgO+DBVsfClr2tMXjA7g9/3xgVDTlNr1jCtRw9uuaYak+Q2Enk5db8m9aHZehzirUilfC95SBvAQglAB2CTOL2oihP4Q8LjOdfgaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNW7QunhimmKLZxaiQWxEws9mL3oZSYrd68gyTRXiUE=;
 b=GDtXGQLMTUcruylZGRnpyZvRSc4Z988BFrGyDze1JVHrdKHhfjZvYOxrLHFuqeO1hqJmVV7Y8GLZ2JdqaYCEcF8cp5MS4qBxt9CvgGBXVKgA8kEsgJZLYmblFIgSmgzc/IrAqQhAHWDZMigPYB8hYuuGlECsmG93ICws/gIMJMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 3 Mar
 2025 21:01:52 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 21:01:51 +0000
Message-ID: <f487c2da-fa5f-4186-a556-005617d603b5@amd.com>
Date: Mon, 3 Mar 2025 16:01:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: remove unnecessary cpu domain validation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 philip.yang@amd.com
Cc: jamesz@amd.com
References: <20250303184508.2277310-1-James.Zhu@amd.com>
 <71929ed1-6c22-47dc-9f9a-a4bc15b21629@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <71929ed1-6c22-47dc-9f9a-a4bc15b21629@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: ade0ce7a-d935-48bd-f6df-08dd5a969f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VU94UXlxUDkzTVZYdzZqZ1RjTTQzNVZLL1pLVnRuOERoUUVMOUdwazBiaXFN?=
 =?utf-8?B?eUU4WXQ0VlIra2wyTy9OT21lWmsrZVE4ajJzZEFVSk9WT0liY1BmaTlQdS9u?=
 =?utf-8?B?bHNJa3hTZHNQZ2ZselJmWk5VVHpjSTVpVzM2dVk0SElaWTVTeW5IVFdWNitP?=
 =?utf-8?B?UmFBNEh1UW1mRVBLZmMzVmdaVFprQ085b01qZUpjQ1RtSWl1Y1E2bnZTeXlS?=
 =?utf-8?B?T2xxellVekpBZlBwbU4vRXluSURZMmF6R1p3VjY5ZzZ2d0VNZ0RCekJPL3la?=
 =?utf-8?B?eWZxUVNHVDhNQkdoeWFPV29EOU5jWnhJUjgvcFVCVDdlVlRYVEI3WTVrSFo0?=
 =?utf-8?B?VHZSdDZBemVKK3RWNzJRb0M0b21LbTAvNnJjalRmMWozY20zT3pHemNiaDVa?=
 =?utf-8?B?TEQ2Uk9ZUmFRTXovbngvTVhXS1JjdG10KzFUQmVSRW90UlFQdjVCaUd0dVJN?=
 =?utf-8?B?U3pKVGNxTHdNZTJNcWRtQmIwa1l0empibFFESnRwT1p5YS9vb25EWHBqaWtF?=
 =?utf-8?B?UEJCVzNpdTJoVU5wNkJOWExtaDlLN0tkbU9DS2p2ZXdweHh4Rm0yR0JQc0dx?=
 =?utf-8?B?eHBRTDBaekxRWTdKYkxuS01BWDRCTGZzK1NHMVVSM0t4amhEUlZPRWRaN1Ay?=
 =?utf-8?B?SVVXcVNmWmk5bC9nejROMnplLzJENkRMTzFCakdUUSsxVUd2TU9ZRGQxb213?=
 =?utf-8?B?QWpuWkVZbE5UNkNwLzdQbU5nVFcwUG5rYWVWaTh1S2s4d3l3MjlzaEd1cGNh?=
 =?utf-8?B?UEtza2svdHp0ZzVXSERUd2IxUjQ0K3lFQXZDQkNZVldGbzJqRGZmZjBDN3Jy?=
 =?utf-8?B?SUUwalVmRFl6SmJUVHdZZlZlc1A5RVFYb1dkVkZsekwwamVreWJCV01JbWln?=
 =?utf-8?B?U2lBSjBiRHY5ZUM5SFBUYThPZDRGdWdkVnRIZ2dkT3pDdzJUU0MyVk5Na0ht?=
 =?utf-8?B?RTVscHdkcEVyTFBMK3gxa1NCRTJhSFZEejF3Z3cyby8vRG40bXVmajdwcmxn?=
 =?utf-8?B?aXp5TWVQZURITlNYTis5T3kzamFoYlJvWVNPNXRqY1pTZERyRytkZFpDWE9L?=
 =?utf-8?B?MEwrN2YwcnhITGc2WkhHVmpmb2RQQkREZEZRa0p0Y3JtM21oUDRZY2RtL1hn?=
 =?utf-8?B?amlnMHY2QnZ5d0YxbkI2V3hOdUtHblNTTFRKc3NUS1VDMW5zdWhCTVErWlpK?=
 =?utf-8?B?SWJ4d2VSdlBpR3BaTDRUcFA3ci8zMXZBU3l0d2cyclEwZTZkWDlDeTQ4bVlJ?=
 =?utf-8?B?RFdaRW1sUUtZMU10ODhCL0wybVVMN3M3YnVmcElER3k5NmsydXltckJlMC96?=
 =?utf-8?B?eXlnZHpUelRVaWtWYTMxK2ZjeGdITml2WTZRL2loT2JTY0F4RlpNdUV0d3lh?=
 =?utf-8?B?MzFnVE0xTU1CWlZkM3R5U2FvVWlEZ1duZlZhMGFPQnRhcG9Ec1Y5V2hQamVw?=
 =?utf-8?B?Q0NkVXVMdzVWVGdBQ08yM3JiNS9GNUlBemQzNWR4ZEIzTXZEeDF2bWlzU1Q5?=
 =?utf-8?B?c2lBUkx1RFp6REdxeEsxbGtKdm5IaGlFMlRyNnpzTnI0Q3RDL2kvSlZEWUFH?=
 =?utf-8?B?RkNoL2p3MVN0RFRML25KbWdqRDdKUHJRVmtiVWZLNENaU0ZBOUV5bm1mYW1U?=
 =?utf-8?B?aUVSTlI3ekVSc0Z4ZnJJVXBOWWJvLzByVXVHejM1OXd3WTB1UFJaaWgrb1Y3?=
 =?utf-8?B?OVhqWHpwTzZsQzJkdUhoaitYdTdUOUM2bE50RkE0NzRZSy9xODdYcVg0WmJh?=
 =?utf-8?B?UzcwcWE4U3FqcWtDSUwzTVdIaGM3djFRK01lY1FiODJMSDdVVmx6ZEVNbHRS?=
 =?utf-8?B?bHowZ0RLZVMvVUdoeVQycTJCYTZEZUkrZVJ0UTE4TFh5dmpCdmltemdhZ0dC?=
 =?utf-8?Q?wTMpkEth/2w8X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkFoUXRIZTdmb1RlcGFQOFNMaGpVSE1kZ1d4ckJZTkxSalVNbmVaZEcwUzlE?=
 =?utf-8?B?T3QwVWJHNllvY3BWZ3dZUjJUS3oraDBwa0Q1ZFpHQnMraklpMWh1QWlGbDRh?=
 =?utf-8?B?T1pUbjlRV2I5eWxMNy90and5WEg0Wm5QMWFuVG5icE1HbkthN0xlNnpkZ3Zn?=
 =?utf-8?B?UDFrZnFsNC9VZzdSUlpISWMzRGU2UDNEV0xVRUIxZzNDZ0hsNndaR1JxejlF?=
 =?utf-8?B?czhGUTRkdUlxVlJCTjJkOG1Nd0w0b2pzeS8yWERVNTcvNmMyTFZNU0hCRGg4?=
 =?utf-8?B?T3VuN3JQckw3QlUzUXpiWDNMTlEwYzVTUmhqd0ErT2RDZnN0R0ZuU3ZISExu?=
 =?utf-8?B?SmtzVnFobVRBcStYUnZtU3JIeHkzNXorZWxVdkZLVU9tMHZoSHlWZVJBSlVk?=
 =?utf-8?B?b2VwVW4ray9iWm5XWVhQa2Q0bHBVTkwrVzY5enJYZEtUQytzZFhqWFk4OWZD?=
 =?utf-8?B?MHA5RWVkdzQzZjlzNVBzbzUzMmNNUnI4VmdYcW5QUkVJejRqaGd6VEdVTldN?=
 =?utf-8?B?VkNoSmZ6VmRUS0RDdFhZamxRN09OSmhSZEh1N1BFSnc2ZlZiTkF4Z0dpajB6?=
 =?utf-8?B?a0pNWHRTMXZzOVNhR1QzT3c1WE92YUM1TCtpRUI1TlZmMmp1R1U2dHA3SCtj?=
 =?utf-8?B?TXNBOEVXejZUTjBrOUZ6V3VGWFNBcUJvaHZKaGpuR2p2a2NidG9ycmhBU1Ew?=
 =?utf-8?B?QlVZd1h3azhPR2lpb2lHRngvUVcxdVpXNmNuVDZhV3E2NzByZjVKZkNDQUF5?=
 =?utf-8?B?aHZaakNUd3pKb2tBalpZNTFxbGJIeVFlSXhWbU0xQTZGVGdWb2gzTUZQTDgz?=
 =?utf-8?B?V28rWEIzSzU5bk1ycmFnME5pR3ZWcnZ3S0VOTFRWeWVNUzdKTnQzT2lrTld3?=
 =?utf-8?B?bXByNEdlNjYrcHJwbmZHeHo5VjhPc0tPKzJZYkpJT09uZ2Z2ckhNSkxwR0dW?=
 =?utf-8?B?WlJFUVN5OUZIdWk4SlRHR0plSFV3M2c4V2d5YUEybHA3SHhTVWp5SGd6cldH?=
 =?utf-8?B?VW1pbFpXRHJRbnloMVdDcmJZWHQwd0tqQXBqR1M0RzZNb3VVaXZmNFZoaDc3?=
 =?utf-8?B?d1pYUVIwdDZqNWtWc3lRcHd0WnZNajRScUlLeXRRTFFlMlRabTUxUy96Wnhw?=
 =?utf-8?B?eTl1SEJJUE52NDIxdzNBMDJ6RkhXbmJWQ2Z3aE5YanNKUnZOeDRtZmlLc1VY?=
 =?utf-8?B?ekpNdlF5MjllVmYyOWwwQnpOMlJvYlIrb2dLUzZpdU5RVkVlY3ZWWE5UWEpr?=
 =?utf-8?B?c0RPT2NvS1pvOHE5NlhNR0JMVFo2NDFWSC95azgybXo0T2JDdEwwU3doSFMv?=
 =?utf-8?B?dGVwblhNRTQ3U2JwWlRRTjdNZnJRNkZ1TVhKaUtlNzI2QytDR2w3VXI5NWNO?=
 =?utf-8?B?NWNScU1UUVFJN0Y0ZUJXRkxvbnYyNHB4KzQySWpZaS8wSnRXdWZ3dmExMWJ0?=
 =?utf-8?B?eGU2UXJnMEQyandFTnJXY3phMC95cUV5aUo0N2lQam03bDl4ZGl0dkJzcS8w?=
 =?utf-8?B?Y2pHLyszS3Ntc2h1aVNZQ3NscFVUbmsxNGZQZU5hNEJqM1IvVjcxTzdsQVpU?=
 =?utf-8?B?UmFwQXBpMzlTT0IyeE93cjBHRjFKV25jNnJ3K2Q1ditLajdiZDNVcW92OVkw?=
 =?utf-8?B?dWFqVHFMMk5haXo2elBOb04rSVkwcDRENElFTjNBdXNjTXlvMVBzYkRMVW51?=
 =?utf-8?B?VDFJNmVlbW9BOWpESk1uNlZQZGR4VXBZNndmWkl3SWZsSmc0M1JSWWJYQlZD?=
 =?utf-8?B?bDI3dGJmZW11Sm1rQWNPZUdwQ1ViN0tiZXFjSGFpS2R3TWc4a3dEcFAvZlZ5?=
 =?utf-8?B?RDFPKytwakVMeG93bEdzNSs3WnFWRXhhZW5mYW84V0t1WnFBSnpnRGpmTEVE?=
 =?utf-8?B?TE5LTFNXV0hoN09tYlFabEZueURnNTNhVlNJa3hCcmlHRWtPRllicGNVSkIw?=
 =?utf-8?B?d3RVRG02M3Q2eDRHQUYyVTFUVHV1aFFWWnN0SFVWa2EvMkwxamp5elJ3RDFI?=
 =?utf-8?B?QUt3bVVSNUN4eERBM2NrOXhOcUM3Q2N4ZFc0SzFsdkhzRzAxYW8xQ3lCZFpn?=
 =?utf-8?B?TmJpVEpBcnFJYTk4VEl6RGRFRnhSbXp2eUlRSTdhRU92YVJOb05SYUp1eksr?=
 =?utf-8?Q?+6exrPcupK17zdoza+0Xn7EAz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade0ce7a-d935-48bd-f6df-08dd5a969f02
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 21:01:51.8253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5IRSYINKBTKVZx/LlFAIwycqz0gP0mRxuFi5g8PNcNQll+2Rkiva6pZcsfzNEw9c36ohc/mF3EzXyJZKuZ92A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095
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

On 2025-03-03 13:48, Christian König wrote:
> Am 03.03.25 um 19:45 schrieb James Zhu:
>> before move to GTT domain.
> That might not be unnecessary. We sometimes intentionally move BOs to the CPU domain to invalidate all VM mappings.

We discussed this in our VM sync meeting this morning, and I wasn't 100% sure either. In this case it's causing a nearly live-lock of mutual evictions when two processes share the same BO and have both their eviction fences on the shared reservation object.

I was thinking the VM invalidation should be taken care of by the DMABuf move notifier, so this explicit invalidation seemed redundant. Is there a way we can test or otherwise verify that we're not missing anything?

Thanks,
  Felix


>
> Christian.
>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 62ca12e94581..2ac6d4fa0601 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -595,12 +595,6 @@ kfd_mem_dmamap_dmabuf(struct kfd_mem_attachment *attachment)
>>  {
>>  	struct ttm_operation_ctx ctx = {.interruptible = true};
>>  	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
>> -	int ret;
>> -
>> -	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
>> -	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>> -	if (ret)
>> -		return ret;
>>  
>>  	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>>  	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
