Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA03E77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 20:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD24710EA09;
	Mon,  6 Jan 2025 20:53:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M5sDIVks";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52DE210EA09
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 20:53:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQI3aQloAQvnsQ7j7wgRE8+eg/kMUai68K5JEtaN6iUN0gV+r8QhjuXDq8DwHUmbQ3lbkkSEj4AZwWJMNYVHGM4exp5Fq/uLtgQe/yGsqF8kTkoDx0oVKPm94a3IB5skK/Qy6IfkG1mO6BGNfFejlvQd6GGbsdflREc1imaP7Eomumf7cms81NsUFfR9Sv6vJIZnJPpROpJcBomIF+H1PXaDy/AvRoMX4RPCn5hgjWJFt18i08Jr5mPxE0ElVnVK22Kvwlyl7sO9EjT0qTZ9FbU5qo+xa9VWd7IDMJE3LySbz7xalIIA2fVGh373CdCOyWkyS4a3kePTk7+sBxP4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjX2OrMs/0CP9GTxEdI08s61jAOovM/km0k8ow2Iu7M=;
 b=CD3bomLTW4Q1kmAmSmYoyK31ZGwgHnlbcfJcwKD/pMDZ7vCp1TBg3KAmIMsUFx+UIuIDnapE62zLEK9K95dA74OyqdEzf6UdmL0pegzEODmtrH0vtwYgmkOgyp19C9UKpW8YkSAeKMblNmR4tgBuxC2ClcjbtDWohZjKNpNzw19U5AS1DieGXa1nCRloASN8oNNXOYJABbuTCdPwmZccuXGFb1NeB6JnAcVRzBDtuK/t7U7Y6FRYi13KvTbqwTbsLJuq6SuT4WhPqPbPY9UyW5C9yU48BaQ+Hz/c/TAcrOfo0CaP3JOSg6zOVwqm6LTYapfV0utsvkiRafsyv8rHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjX2OrMs/0CP9GTxEdI08s61jAOovM/km0k8ow2Iu7M=;
 b=M5sDIVksYESN0oiB0GpwbWEtBJqQT01iI/WdGJEvBYwuvOvanUCqrM18tyTT//YTEjdlGVcCpSQ1yd1y1PNW4NlVmKGJxhtXlKyhDRAWRdq4Ndh/nzSnNFHPJfpB81+HVxnbtsm1PLU6esvkUi00J+usT2aWZHf/b4c6GLWAbTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.17; Mon, 6 Jan 2025 20:53:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8314.018; Mon, 6 Jan 2025
 20:53:21 +0000
Message-ID: <3d7d3dd9-6c0b-4377-a131-75952d85a90f@amd.com>
Date: Mon, 6 Jan 2025 15:53:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix partial migrate issue
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250103000644.1398643-1-Emily.Deng@amd.com>
 <4af83c37-0a9b-4b15-bfdd-6b8511b93a36@amd.com>
 <PH0PR12MB5417768A1EAFBB5BCFFC85BD8F102@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <PH0PR12MB5417768A1EAFBB5BCFFC85BD8F102@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b95cf1-571c-4d5b-9160-08dd2e942797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkNCa1JUNE5ROG9aYjNMZmxJTXBtTTlJekZMa0EzS0VtYTdjSExMSVhLRXlW?=
 =?utf-8?B?SlhuZjNZR3NNNjZZVUtLWTlSMGN2bm5yNlVsazhqL0ZZa1hzUUlvYml2Q240?=
 =?utf-8?B?SXBFOEpJZ25NTlNLUGY5VFp4REtWNkZSRXpNbE82cjAxM3RKMzJvSmtnM08y?=
 =?utf-8?B?OHNoUjhxQUZOb1NWOERNSlU5T2lBT2pSSWJnT0R3S0ljT2todVFtQTduSXhF?=
 =?utf-8?B?c3FWQ0dkMjUyMTNxSmVPWnYvT1NnNTFiTThOcW13VXg1U0dPTWJweWkvRCs5?=
 =?utf-8?B?ZU1zNWNzc25LQ2llb1pwWDRKQ3ZIb1YzQnFpQy80WENpeGIyVDZqajRnelhI?=
 =?utf-8?B?VXV6ckp2cHNkSkJIUEszeHFLVC9wVjd3UVMveGIzdDU2dERnTCsza1Z1ajdx?=
 =?utf-8?B?dk5BVkFQK3NYd1dVaWhoeDM3SUp4Yi84N2IvSlBLN3YvZk1XTzAwQ3FiaHg4?=
 =?utf-8?B?UHA0eTR4THRkZmRjbU9sLzBPLzIzTkx2Q21ISmhWQWF6MCsrZm9DTnJzbUV3?=
 =?utf-8?B?bUZHcnJHUDFDMW8wbUk4VHpYUzlURUVjUXp0VU1xOE9Od20vVVRxOVZUTUN5?=
 =?utf-8?B?RzArOHFIVXlKcDI5MTRsTFlmSXRtYzJRa2xDaFVGakMxd3NreisybUZkdlhq?=
 =?utf-8?B?V3d5RllUbUdZZ29nWEdEVEw1czhNR2wyNTJ6MnlLYmRQUmJNZTBZcXlBOTM5?=
 =?utf-8?B?cXFZRnlLT2hkY20zU0pSYWZaSHBlM3czbHkrRWRjRWduVDhvMXIxa2dvY0xL?=
 =?utf-8?B?Z3RMK3F0MXprcG5menpFbU0zcW1HaG5tSG9McWlTQUUzWThOZDVhK2x4dlE2?=
 =?utf-8?B?MWJrYzdHbk5OS3BRZzVaMUY3K3B5V3FjRytyQVZHVTFqTFJhTGp2U0Fia0lC?=
 =?utf-8?B?TkFtbnkrYlBVWWRCNStsV0NITWJ4SGJyWlRPYkErYnI2ektQTEVXalVTNXha?=
 =?utf-8?B?c0xmOStzV3daVklsQ05la0pLWVh4NFhXdlFPUHVVK3JXR2ZMZUdFc3FOZTI2?=
 =?utf-8?B?cVkxMDYreVpZVzcrcVIxZjVtbWpMMHRlb1ZmSktaWStBRDhNL3RTblNLdDVm?=
 =?utf-8?B?TVZ0Si9EbkRleTJ1YmRIYWdXWFFzZEtKd2N5L0VwOU9JbzliMmFRanRQck93?=
 =?utf-8?B?T1lkNmxZcTJGUlB2d0s0RUViUWZhblkvMFRVc1pFTnczaDhqNTgrZWNITndv?=
 =?utf-8?B?QnBiNFlJck1rRGFmREQwR3JHYUdmenp2ZHdnc2ZtaWpCdk54TXM3RlJyL3oz?=
 =?utf-8?B?Zkhib0hETTM5dDVEQk04ZkJYUXRpKzhaVTZOckY0WFV3YjBsd0ZEU21BUm9M?=
 =?utf-8?B?dzI3bnRSZ0I4dGk4RXNOMU9CbXRiRkFSQXBoRGRqeGJCSDhsZ2VNVUJURExp?=
 =?utf-8?B?blpNY245YUdOVDZxYThWVFJYcGVtOWRjdmVsTjlVU3ZQeWJOR3dQZStHTGhn?=
 =?utf-8?B?Mmc1dXdkM21JQ0NXeWZWamdyN0p5WUwrS1pEZGRNaFFzS3Fjbk5FR2N0ZS9w?=
 =?utf-8?B?aURScnptTGhtaGZBSk5aK3g0MEoyVFd5WGpid0NHWHE5d2dSTkVsaENxNW52?=
 =?utf-8?B?UmpwZE5GYkEwTE1mc1NJUnlKRHVmb2QwYUVWWm45MHdra1E0enBRVlkwRjA1?=
 =?utf-8?B?T3BxRE50a0locE54bnUzZXhuWTkzcE9sUGRJa1cvTTcwU3JWVnJKNHVnY1FL?=
 =?utf-8?B?TVd6TUFxZWt2Uks4YUs2dStSeWxaYVR4NGZVbmhkN1hURTRSMzltNWlMS2lV?=
 =?utf-8?B?MDdEQlVCSmxxVmNSaDBCb2VHZHpjRGxtT3B0WkFUeFplcm1YZmVDTit5WmM3?=
 =?utf-8?B?VUV0TmhIL1BqWXh2T3Y3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Znd2VjdZbDY3VkRlNysvbnFmRTNnaWxEaG5sdXVCWGZqbmtadkNSNUxLVXJr?=
 =?utf-8?B?bC9lUW9hV1ZkMXVicEVQa0k1TEFqYWNhUVdQSDh2NzBQYy9Gbk01RlFMa3lx?=
 =?utf-8?B?QlBhWWxOR0JueiszSjJVSTAzU0NIa3BpbHc2S29tNmR4MytJSkpCQzZ1bXVr?=
 =?utf-8?B?OWtZRnZERXdhWHdFazIrM1I0ZmQ0QzZ0U2dsQjZaV0kxdmVXSlFQNDJKUmVP?=
 =?utf-8?B?RHh6SU13UHpScTI1WkM2YkxlYTNhYldpMTJFK3pZdHUrdncxUUkzbjZzdCsv?=
 =?utf-8?B?b3BwQkxwSnk3R0JnRWtTWlRrSlhXd2plbys3UVpkcTJ1UnVieHJxS1A1cUJ5?=
 =?utf-8?B?K2p3d2RDRVFiZ0k4ZWMzL0JBMVp0SlhSNEtHeTRwS2M5REtvZXlxbVQyWDkx?=
 =?utf-8?B?S0VOcVkweW9lWXJncEw4ZmMxRXFQNHUya1l2eDMzRzVyRmczb2lRUGlPNnFq?=
 =?utf-8?B?cEMyei9Od25xUzE4S2xrZk5xd1FyNzRLQmNIWlVwWklBUkhvMGVmOHBoKzM5?=
 =?utf-8?B?TmRKQUxFQXV5YnR0djVqZ3krenZTcUFobCtYbFV6N1huZERrV2JYUXNOVzBQ?=
 =?utf-8?B?TnZNWnliVFdnQjJBOHgrRy9SbW5PbXV6eGNuNGM5VkMvcVdSdE1TbWthV1U5?=
 =?utf-8?B?U25qNEFHV3ZFWi9kQ285YndnRmZzdGFpZ21OVnEwRWxxZXY5ajMxMU5sMlRx?=
 =?utf-8?B?cml6UGRiSllRRytaRjdSakl4MUxVQXJhcDhnVGlkTEsvQ2R4dW9QZndpWGVY?=
 =?utf-8?B?WFV6d2xVODdoSW1Tci9iV0NjelZhdFlPeFlLZXNjMmxlbXR1R3Mvd3p1aFBH?=
 =?utf-8?B?eGVGbGJmMm5hMmtGb1NYVTcweUYzSGhLNXpiblBUSFdQYWJGSUJRNGxDaURl?=
 =?utf-8?B?ZTNMWDJsWUo1VXdsQ3FpRGQ4d2Y3cG1vNmRhaDF3eitRSEY3cXJQUCtLcjB1?=
 =?utf-8?B?cnlDTW1jNmNhdzV1bit5NHN6MDJISXJVbmdFaEpIcTRmSlhKRXVrTUpNc2hy?=
 =?utf-8?B?VHlzWE5sU0JMeHp0SFhHcnVoVnNHUE1GNWlQQ3lxSEw0QVFlbDRDTkdDekRl?=
 =?utf-8?B?ZStzUE45MVlMTVRXQlcvTlFWczNzSk1sMllnQ2xnU0U1QXp3S1NMeEJrMzVO?=
 =?utf-8?B?Qk9pTkhZNlJMTnUrbHIvcTd0Q1kvRkNPUUdNbUxrbThKRVQ0MjR5cWJjSUFO?=
 =?utf-8?B?UUt5ZGwyVHdSc2gxM0c5SUdJbUcwWEFGV1lwQW50WFFxT2VCekZWN1h6K0Z6?=
 =?utf-8?B?RkdlMVJySDNYQUVzZk5BMGYrMFBDZDVvazdZZG1NMzY5M0xwOTFZTU9ZN1p0?=
 =?utf-8?B?S1JvcXphb3Q1MlNJeWl2eTlqckxiZkxiV3Iyeis3YjJydm1lUzhkcWFPQU01?=
 =?utf-8?B?WWFmc2NJMXkyNGtkMmN5b2l6UFZWbmVVWDhzNlpvK0JFVDRZaGFUdTYrMnpI?=
 =?utf-8?B?VDBjUjhFWE9IdnlWNWRwRzVRYy9HNFlld2xKRTB4ZExNSm1ud2swUlp1amlp?=
 =?utf-8?B?TUNNQ1JLajAvK1JZZG40OHFBS05yWXZkdGIzK0MzNDc1ODZLdkpsNjgwbzM3?=
 =?utf-8?B?ZDVzNmxYUmkwbmFIenoxSTZLcVZFTnJtWXRlRnJDYjdIWUJ6RGdXUWdwVUdC?=
 =?utf-8?B?UFFvaVFpL1pYUllmLytQZUtFTE4vYmlzWEY5WkNiS1FrNXk5aThMYU4vOHBK?=
 =?utf-8?B?V3lYNlpQMEI5Y0JKVExWRDd5MVJHTThHUERIV2hNTFY3SzVEMmlOdGVjQjdk?=
 =?utf-8?B?V0F1WWlYNUpOZkRmd1ppTGV1YUZvMXJWaHJjUkk5V1VjVG1YekFrTXJPUVYv?=
 =?utf-8?B?SGJlczZRV2t4SlJ2Vm5JSzJxTC9MSGxDUTZ3VkcvUGRnNG5HQXBXNWtRbVhm?=
 =?utf-8?B?SG1WdDJWLzltSG9RTXl0eDhacVRZQTdUVUN1RU40SDFtbWp2UlBKY05zMVF5?=
 =?utf-8?B?WkhHYUEzcUhDNUV0VE9DcWY0U3ZMcXpwUDRDY09VRjBHb1NieEg0d3dNdTdF?=
 =?utf-8?B?TnFwTjhXaGZucHFDM1dhTHpmSDg2b1l0OUIzTlVPKzRJVWltbUdVUTZTWUhm?=
 =?utf-8?B?R01rUnVsTkRQRGx6RHViUytQTE4wVXZjQ292SHNzZGZDbDIzZGU3RnF4eVNI?=
 =?utf-8?Q?JIfrK2d4oOHSgN6pluspcQ91t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b95cf1-571c-4d5b-9160-08dd2e942797
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 20:53:21.2995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1+ahTE2NtH507Qf118p7/VoQA162H/1fTD4V985gb16URo+wKf65hZ+gUseoKQo0gva1fBCO1lFsjT2x0iQaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
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


On 2025-01-05 20:45, Deng, Emily wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Saturday, January 4, 2025 7:10 AM
>> To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdkfd: Fix partial migrate issue
>>
>>
>> On 2025-01-02 19:06, Emily Deng wrote:
>>> For partial migrate from ram to vram, the migrate->cpages is not equal
>>> to migrate->npages, should use migrate->npages to check all needed
>>> migrate pages which could be copied or not.
>>>
>>> And only need to set those pages could be migrated to migrate->dst[i],
>>> or the migrate_vma_pages will migrate the wrong pages based on the migrate-
>>> dst[i].
>>>
>>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>> Good catch. But I think it's still not quite right. See inline.
>>
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> index 4b275937d05e..5c96c2d425e3 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> @@ -278,7 +278,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct
>> svm_range *prange,
>>>                        struct migrate_vma *migrate, struct dma_fence **mfence,
>>>                        dma_addr_t *scratch, uint64_t ttm_res_offset)
>>>    {
>>> -    uint64_t npages = migrate->cpages;
>>> +    uint64_t npages = migrate->npages;
>>>       struct amdgpu_device *adev = node->adev;
>>>       struct device *dev = adev->dev;
>>>       struct amdgpu_res_cursor cursor;
>>> @@ -299,9 +299,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct
>> svm_range *prange,
>>>               struct page *spage;
>>>
>>>               dst[i] = cursor.start + (j << PAGE_SHIFT);
>>> -            migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>>> -            svm_migrate_get_vram_page(prange, migrate->dst[i]);
>>> -            migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>>>
>>>               spage = migrate_pfn_to_page(migrate->src[i]);
>>>               if (spage && !is_zone_device_page(spage)) {
>> We should also check (migrate->src[i] & MIGRATE_PFN_MIGRATE) to catch only the
>> pages that are ready to migrate (i.e. not already in device memory and not pinned by
>> someone else).
>>
>> Regards,
>>    Felix
>> The code " if (spage && !is_zone_device_page(spage)) {" is already checked whether the page could be migrated or not. Because after called migrate_vma_setup, for those pages couldn't be migrated it will be set to NULL.

The page may be non-NULL. If the MIGRATE_PFN_MIGRATE is not set, the 
page could not be collected for migration by migrate_vma_setup and it 
should not be migrated. See 
https://elixir.bootlin.com/linux/v6.12.6/source/mm/migrate_device.c#L470

Regards,
   Felix


> Emily Deng
> Best Wishes
>
>
>>> @@ -345,6 +342,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct
>> svm_range *prange,
>>>               } else {
>>>                       j++;
>>>               }
>>> +            migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>>> +            svm_migrate_get_vram_page(prange, migrate->dst[i]);
>>> +            migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>>>       }
>>>
>>>       r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
