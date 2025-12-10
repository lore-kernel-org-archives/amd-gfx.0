Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5648BD3C90D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 14:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E480A10E1DB;
	Wed, 10 Dec 2025 14:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QhTTSq3C";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8077510E1DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 14:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuqQ0RJVsgDynScDQJ7WvNErZt0IGMFaoVAxYbPIbAGPsdDz2ixJ/XO9CkejLTxtrSxyBGVGuQI41bMp6DqEQOB/hBJBxn24ME62wox6cMMCPvCxG50ygqbZUB0MPWxcpSYTW3YVeW0QwpLwMC12lyosdgNw1m8qoBIcoNdwhJRuSdhPeJ9K3YjpsBKPWhqriq2kYniOT+jC8IB3pnOMRRvlww3WswJZjVne88a2Muk10/7JYLJ5TCDzJStNVvavDNH8RqoqWMLGmQteCRQpZei6I3cthltpYpv5uR+OwP0xfACBeepkcPaPIEEmBPlrKuyTZ7ANH2rRyzutoMlYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GscQnNpeyGN7dHGn4ltVnVPN1rxzy/IJdAmsWvcjCyE=;
 b=pjAVmWV2yM6LVxZylWl9OuxMNdb7m+b9lZeaiU8hF5tzjY9Dxs+o4oKjs+nXj85Kufhvroav+Xrhli08DQPPHpw0gQ6cjbEJsx+yzIdwrR8LGtnJho8zUi7LKUb6453QoIv4Dxi3y4gsCEvqDh6TV+5YmRh+HbsGTvnsXKBz1SYGNekB/vsrw6v7wul79cwW4LDzs7nBLFY4A1RS6FPoFTHPWOVC/B8hv7rLec9DOp4HtRgsaPsadP0dMPd7Yfk+91xqLN2HwkmTqKLnAN+nmM57Ju3v63O5lMfStizwbuuBKFoUj4UXixCXJhRRlYVAg6aG4S73kZCI4MTW36zOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GscQnNpeyGN7dHGn4ltVnVPN1rxzy/IJdAmsWvcjCyE=;
 b=QhTTSq3CTsDN+Te/l2E4hoNGN3vO7U2R0F3SDIXuL9UkdH8a44gQflOcQotyiBxYqTjxHGiNAFT5Cuz2ppav2t4bslVzhjjItpiejklRj1zAc76K6xN4s5UOqMMCgBHMQxT7a2+kCAuQcKD6dHFx0eJWMJuVZEvAUTA375J7LjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 14:11:51 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 14:11:51 +0000
Message-ID: <cfd82f70-cc30-4761-8162-0762afe65a7d@amd.com>
Date: Wed, 10 Dec 2025 09:11:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Unreserve bo if queue update failed
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251209203657.440714-1-Philip.Yang@amd.com>
 <0e0acd6d-ab5d-42ff-8b6d-c531b708e2d8@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <0e0acd6d-ab5d-42ff-8b6d-c531b708e2d8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0174.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::23) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 95efc008-d7d0-4513-e51e-08de37f61075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXZsSTJKUzQ1RUVYTTNscjd5dmRmR1NQU1V3SmNObVhNbUFiaEo3RUVkT2Y4?=
 =?utf-8?B?aEdVYlJYdlFuUXQ3cU9TQ2JZaHhJcGpBeXJmL1lpaFJVVWlLWDkwSVlQZHFx?=
 =?utf-8?B?b1ZXM0pkTGtINFJuMXUxQlRlai85ODM2K2RjR3VLcWdpZEVlaWpRbXRrYVh5?=
 =?utf-8?B?R2poNXk3ZC8ycWhSZUpJKzVoUW5xOVUvclNwdUVPRWJnL21yNjdPalBnWnJR?=
 =?utf-8?B?bmNEdlM0VVc4aXZ1NnlDWjBzQk9JaGREZ0dvS21zbkxBdUt3VmkvRk5wMUJC?=
 =?utf-8?B?ZDkrQk03UVdYQ20wbCtsVCs0NlZpMFFhQTl1Tkx1R01oSkNFcmFwVStLQ0NO?=
 =?utf-8?B?cUVKb0xxRHNMMWRudlhGWk8wa083dkZnNE85NWVVYWZOTVZrRWRZVW90N1pz?=
 =?utf-8?B?ZXVpYTkwcVh4YTlBTTNZVFRzSHJUYXc1enhLMjZpVHlOR0ljejJBMUVhWGdF?=
 =?utf-8?B?VjhsMlVqaG90VmxDblNFMk5wU0hIQUZCYWVnQTFWUUVscm1seDZ1UUlCcjBZ?=
 =?utf-8?B?RVBTdUYrelVPWVZRU1FKaG1wZkpQaUpVYU9YazYyd2JzdnBYVDBkYzlmMDRN?=
 =?utf-8?B?bStWd0llRGx2UnM4NlVPeERxNDl4TFc1S2c2azdWVzhkb2Z0ZzF0aVovNURp?=
 =?utf-8?B?eno4MU80cjJXR2o0bC9oOGMrQzM1WjBDNUFMMmg5YUN6bythTWVtUlVvUE15?=
 =?utf-8?B?SS9aRythQUFQcnVzMnZwN3BCVzFLZXpVejFQT3l0QzI5c2RYZUhhbGY3anY0?=
 =?utf-8?B?RWxHSzFyaXJOYlU3b2pJcDFCMkhna0V6RHlFR1lacEVWMDFKOEVCVDd0RVdv?=
 =?utf-8?B?OFVGN0FwalFpS3lPNHg4Nnp2NytDRHpDQng5c0t0QzlRYWFHZWhWRUpubmNr?=
 =?utf-8?B?dXNoMC9DNUFvUk96cjJWZkYwcHlqdlkwbmRvRGlPNTMyQ1ZVZzNYVS9BQity?=
 =?utf-8?B?RUlhZ0lXL1RUcGNWRmZHbU5oK1kwL3FIVnVXV3NBeGxhOTdscGFRMytLSnF0?=
 =?utf-8?B?ZUdYcE0vNXFhTmN0V3RYNFc1SklZTFUrb3hPNW5zU0FzMnNtNHFlcGxHZ1lZ?=
 =?utf-8?B?YWdwOFl2dXRVSkJtMWc1T050eEZ1WWEvUCs0Z3Y3d1pVZ0pTNVRHem5uaHJX?=
 =?utf-8?B?RUxOK2I4MFM0eWwwTmtCNDU5a2xMbUVkZFE0aDNtM1Ewa294YjBIc2RYbDlX?=
 =?utf-8?B?MFh3eEg0aWpvS210d3cvYUwvNnYzeHpDTGdJRE9NSmFFbDBIUnNkcTh2Yjhl?=
 =?utf-8?B?U09TcHRBSWM1STZLdTNsZjZvRk52NWZPMzJpZ0E4VzIwVUYxWjFySnVmSFh1?=
 =?utf-8?B?aWlJRXU4dVJsZDJuYXRBT3Ztc2cxdm1TbFJpdTFUSU5tdlhiNTYvemdHbVNt?=
 =?utf-8?B?MVlEcEN2N0FOdlhjLzNEU2RKbytrUkNROFRmV2tRNTlReHhZWUtYaWFQeGhi?=
 =?utf-8?B?aGFsSTdzd3FucDBKMWhjMEtnSnpMMVpiT1JFVnpmVWFkUG43ZTQ2ZHkvd1NC?=
 =?utf-8?B?RDNRQkcvMmZqT2FtM2J6RG5JeWYyU2ZKSVJKTTJqSlR2UDV5U041MzBlN1pS?=
 =?utf-8?B?bEZlcTNLU09LQTE2eWs0UktUcHhyR3NmR0lnWjExTzY5amxFWnZ4VDA5TjNU?=
 =?utf-8?B?UzV6c1V4VzNQamgxR0VrN2o2eDI2WUdjNmM3SjdkeUVndFc4c2xRbnhvRGZZ?=
 =?utf-8?B?TmxtRzhIZGp1VmFuekNlZFplSXBuaVJCWitXYnZXSmFqUWtiVTVxRWw3NXdw?=
 =?utf-8?B?S3Q5dkNzRVNqUmZkb05pOXVacTQ0MzdUVzZiYXBsUGR5a0YyRWwwSnl6QzZ3?=
 =?utf-8?B?QWViRXNENU4zRkhqckRqdjdnOVRzaDdMU3d3cnAwZVgvc1UrSk5oTXBCYjYw?=
 =?utf-8?B?Y2llazhaMU1zMXc2cTdQc3FQSGdHb2lNUnNyQTF4WGp6WXFqTCswUHNkSHdh?=
 =?utf-8?Q?LSSZzUPKGNg4FbDgI+boEzpE6uP8/9hn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ly9oeHBBWWFOQWNlYlJYRVU5cllZaUY1ZmNNOThKUjdMRVJKOGowVjlkNDJs?=
 =?utf-8?B?RWtSNzV5SUVHYTJoVFJPRC9md0NnVnk5SjBCQXVNNjRhdEJ3TWd5SDNjY24r?=
 =?utf-8?B?dUl5eFhuZDAxRnRPNnZUWTdMb0EzTXlVckE4Mk9IcW9FUHpsbjdpaFZ6S213?=
 =?utf-8?B?dy9UcDBhSjZ4ZG9yaTlXYkg4VXA2WFRFc25PUlBhcHN6a2lGL1FCcDJtRVVu?=
 =?utf-8?B?MGNnMWFMb1hFOFdZMWJnandQNnFFTmRSampCeGZEbjFqTlY1UmVCVFEvM01I?=
 =?utf-8?B?QzQ4dzVDdjltQURET1VoQzJKeEdNdEpoSkVxRENPRVZSOWhuR0hTZ0lCSHM1?=
 =?utf-8?B?RzEvNDhqVE03VUtIaDNJdUdQVUk1MDc4Sm5KZWNoUndsaXlaNjlCdG40TWpK?=
 =?utf-8?B?UklFS0h0SFlUbTRNREdGVWVObDFTR0hSY3Iva0JIdkRCSkhmZ0JlNWU3T2lT?=
 =?utf-8?B?VnlSMXFYNTBTdVhYSWhTK2xwK3cwUThENzdWT0NiT0FlZEowWXQ2YWpwRktM?=
 =?utf-8?B?Z09pZHYxNytrUUduYjh6S1BkcmpEbTJxKzNKV1lIYnNXQ0pSN1d6SWZLNGVw?=
 =?utf-8?B?Zk5ab2ptdXBwcnhRVExKVFU5ajQ3cWYrS2FROE5IU1czZmxBLzZWU1hWaWpN?=
 =?utf-8?B?emM5SjNxa1V1bGVwQWE0MTliZ0VBM1F5MW5BUTV1MkJLWUZBcG1MeHFZcFpo?=
 =?utf-8?B?OWExMVZUdjJkYXFDVmx2dmRGMGExQlp4dG9hNkJvU2xEaVNnM04xOG9iU2dz?=
 =?utf-8?B?QzdmZ2hLQ1BxL05oSkQ0a3VkZ3BpSHVWcHh6RURlVUFUOEh4NDhINFNSS0hG?=
 =?utf-8?B?VHlVSnBMWWFnK3QxaU9EZnBKc2N4bFpsT3BrSmJOWkpmTURsZXBuR3V1Vlla?=
 =?utf-8?B?Tkx5OTd6d0NzbnZOMmlDOUVEWGhCL2FhY2c3UldBV0V5Mm9sTEpCMkRxQnBP?=
 =?utf-8?B?UDVoQWkyNGpzZUFqckxrR1BPbEpXR29DczNJUzZwWkF3eXV6T3M3aytWYUpB?=
 =?utf-8?B?YkNXeXJBSUpHTTNRTFk4aEdSenVqZmxBcGd5SDZjWVU0Z0xrNHdGbUNtOXhy?=
 =?utf-8?B?UDkzL21IQ0h3RWlhMExjYTBSQlJJMjRRMlBmZmdKSytSV0xpT3VpRGMweWtz?=
 =?utf-8?B?bTd1MkUzdXVJcUcvY2RZNkdISmUzYWZhQ2hYdnoyTm9NYlNPT2tvTkFFcXY3?=
 =?utf-8?B?VWxJRDJIYkxub1RFOWV3ajQ0ZjdPM2hQM25uTnRuR1V3NHNxSHJJeFJYR1JY?=
 =?utf-8?B?dTlucjE3VWlPWHJrUFVYTG1zaHJ4VDduM2pZcERtbm9kMm9KWW1jNzBVNHFu?=
 =?utf-8?B?VkYxRFJqNWIwMVlsUEpxakRLY013Y2JzVG9ZWm5FOTdrSnBVK21VSHdjV3h1?=
 =?utf-8?B?NEh5d0JQNzFseUlqcWhteGV6cXBBbG1RUVByOVVQOUNMUk15UldXVVV5c3pR?=
 =?utf-8?B?L3BTTk5CVkNSMXhTRnlFU1B4K1V0cmZWdEk3Y1NtU0ZndGR3NTV2V2o5VDdV?=
 =?utf-8?B?YTZ6cExjYkxCYkVFUEcrOWtQYTlnMVNuRWdGN2U1WVZFeE11RzlJUGs4dFU3?=
 =?utf-8?B?NkgvdFh5ZkhwOFVPcDZKdzZmMUx3ZERmQWx6cHNabEtFbnZFaStJa29WOTJy?=
 =?utf-8?B?MTlnc3dhK1ZFMU9ZUmM5S25jWVM3UmNHTWhIOGR0ZFhDOEdKYTIydFc3cE5T?=
 =?utf-8?B?SUpaUFpncjRUak5HZ0Q5RlUzSXZ6ZlFUM2xwaTFWbUpkdWdldHdJVWFpNW1X?=
 =?utf-8?B?Y0hDa2gxNkFiYkRnMVV6YXlkZjE0b0g3eFpsbzcxR1htNisya3NyNGJ2U0lV?=
 =?utf-8?B?UTRRb3M2bWZLTkhxVWF1SDhHVytrNEJFT2FHWkhHekovZ0pVbWxCbGpzWkFi?=
 =?utf-8?B?eklaQ2tvOFBBbmxaSnJnclBRU0hwOWtMK1V2MzdDQzhEaUtJZXc5QmRHekVG?=
 =?utf-8?B?TWtubXdvY25jQ3RMMDlFSzJnTzBMRTRJd3U5cWNRZzVxdlZiN1Uxcncyd3hH?=
 =?utf-8?B?clFBa1l5dnF1R0VxQ1YySkErdlh0S21sU1IxWVdpdmtUR3BFYndmcTBVYjZB?=
 =?utf-8?B?dW1rbkxzRHJoVjhwbjg1cE9qNGM1UVJtbGZXK3BXQU80MDJrcllPYWZ3RXZ4?=
 =?utf-8?Q?yG1u2+/LEM4WCaTEwQctQZiJA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95efc008-d7d0-4513-e51e-08de37f61075
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 14:11:51.2411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPIulw5HI22dxFiE9iacZ0Ck5pBeE5wI+ERSaS3IL9L3FuFQZXFbj6dhU8UovoZD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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



On 2025-12-09 17:13, Chen, Xiaogang wrote:
>
> On 12/9/2025 2:36 PM, Philip Yang wrote:
>> Error handling path should unreserve bo then return failed.
>>
>> Fixes: 305cd109b761 ("drm/amdkfd: Validate user queue update")
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> index 232103742712..6babdf025359 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> @@ -592,6 +592,7 @@ int pqm_update_queue_properties(struct 
>> process_queue_manager *pqm,
>>                        p->queue_size)) {
>>               pr_debug("ring buf 0x%llx size 0x%llx not mapped on 
>> GPU\n",
>>                    p->queue_address, p->queue_size);
>> +            amdgpu_bo_unreserve(vm->root.bo);
>
> but why need have amdgpu_bo_reserve before call kfd_queue_buffer_get? 
> kfd_queue_buffer_get just check if mapping at addr exist, it adds 
> bo_ref and mapping->bo_va->queue_refcount. Then after immediately call 
> kfd_queue_unref_bo_va and kfd_queue_buffer_put.
amdgpu_vm_bo_lookup_mapping access vm->va interval tree, this requires 
to take vm lock.

Regards,
Philip
>
> Regards
>
> Xiaogang
>
>
>>               return -EFAULT;
>>           }

