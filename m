Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA48C54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 07:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5583A10EBB0;
	Thu, 22 May 2025 07:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="koKFBLlI";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED4E010EBB0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 07:51:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6bu5WpDuK9XNBMVL7/zXTy7TvCx6OyhltoGsBoE9ZGo2uE9YtEXO61+4jPzWLOb0RZlXq+9fdPfV6lljRfASp7G4y/wxY9femnBzwpMM9SQ3BvfAu1PwuZFLljjN73zpUnBul0QMNODzfCiFWts0OppZkRztT3VBkqkrpL6dH1bS36Uz0pCIeSCDie4+jb1UmTQODLGV+vjCqzWfCjRVrKMF3MlfLW9APF0EWzfgSpnAj08Cl6aoQFFTuCOusSHGYytvLlOTV2jMgDCJC3Iynq5ylFpDuX+upN+1Z21x2tai3/u6O0zPpI+EyDOfjt1FiKq55S5MfhCnd6NOSrI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPpKCwi+YEUw++JKdM741jcwwXLio2oReRzkZmZaqxU=;
 b=JX2YgTtAgb2SRaaPJvULY70fMUFMEdDCOSb7EheJLsGnCMJbUImESlzxhMRh5HWPQd/CEm32JHH2yEDPDqUHaySwIP+jdyPFno3rLH8N1oqsaSWI0pXBH8UlyqS7PN2UzOk191CNqrvGbOAY12FMGRtyhxuA3IWYNfETyN/pV4zWaoLB4ObsUHUvHWaR7tAoN1pan31G508ceKkvGGbpphX9RBE+QamDHNwoUACznsNmJF2TZel/JMgYsN/aaJ7lzGy4vzl5bHM0Fn7bIriHUCHFt6KtStI642TO9ReSvZec0oo2iufj4liFZQeMS3P+EQOLWRuhr6Tfc003oT+rzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPpKCwi+YEUw++JKdM741jcwwXLio2oReRzkZmZaqxU=;
 b=koKFBLlIewS4PUJOlu+0GkIt9rNdUSotGLYUHqUJTbjH4UfsoL3tebNF4oG4ePqDhU3NyroglQSGBYAbjFRleF5H2fsDgxyNUfYvWptnAq26rkpOBB33YTCttD/+J4UUO5As+2IcYWplwc6uSoX1vq7LHqs9wkKEn4gSEW5rTVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS4PR12MB9609.namprd12.prod.outlook.com (2603:10b6:8:278::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Thu, 22 May 2025 07:51:33 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 07:51:33 +0000
Message-ID: <128c8400-d3aa-4d19-8d64-fef5c6ae97fb@amd.com>
Date: Thu, 22 May 2025 13:21:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] drm/amdgpu: update xgmi info and vram_base_offset
 on resume
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Christian.Koenig@amd.com,
 Alexander.Deucher@amd.com, Owen.Zhang2@amd.com, Qing.Ma@amd.com,
 Emily.Deng@amd.com, Jiang Liu <gerry@linux.alibaba.com>
References: <20250522034350.433219-1-guoqing.zhang@amd.com>
 <20250522034350.433219-2-guoqing.zhang@amd.com>
 <6955d2b7-2dc0-4161-b97d-5377b6d81a5a@amd.com>
Content-Language: en-US
In-Reply-To: <6955d2b7-2dc0-4161-b97d-5377b6d81a5a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::30) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS4PR12MB9609:EE_
X-MS-Office365-Filtering-Correlation-Id: e091be2e-21d7-4eed-d7b9-08dd99057872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHZDUHU2TE5FUm10cVVJV0kvOTJWc3FKbGk4YzY0UzFQSlZETFd3MUloR1Z1?=
 =?utf-8?B?STJhUTJRVFF2QTIzRFRuamJmemx3cWlrV2FmcENuSkRLQmFQcGxrTW0zandy?=
 =?utf-8?B?RVN1a0VlRDNsSG5QKzIxRGw5Z05nbXQ0TVlSWEdHZlNFZTlCRWdUZER5RFdu?=
 =?utf-8?B?YmFHRnVaMVhZUm5ESGc0OUROVE16a0NNcFE3TTlHa1NSWGY0TGZKOW8zWWVZ?=
 =?utf-8?B?U3NiYVg3dTFEOFZqelNBUk9oaEFLcFJsbmFMWXFSU01yZDlwVlVBS2ZENS9I?=
 =?utf-8?B?RjE1OWdPMXdWNDMxSGlqbGFtRzJQK2UwdlVUREYza0U3WDRVdzBWa0hXTmhF?=
 =?utf-8?B?VXdSN2VHYXh4U2gzcVgwaGI5SnpRSFRZalRoK1EwNXNrNElOTklBVjR0Q1hQ?=
 =?utf-8?B?OHgzNnV1bzc0TVdBNzd1YTlXVGlTN1p1NW0zR3hTNk8xWkUvajJua1hhSjVM?=
 =?utf-8?B?UkdRN08zamt1eXlZK1pUc05WYU1LN2lzV1FGWTRsTG4xTktxR3FQS3JtUWgr?=
 =?utf-8?B?eU9UMVlDbm55YUZNYkdJVFUzY2JmcVdLdXBYT1luWHdmK1dYYXplaTdneFNR?=
 =?utf-8?B?QUd0K2ZudVZIem4vcmN4akZoR1QzS3RtN1RYM1dnK3Z3SDMwa2tLK0Nqdyt1?=
 =?utf-8?B?RXdaR2VqLzBYTTJZa293dE9wckFMYnVYOUFXRGpZakxEM2VneDJ2bStlWEh4?=
 =?utf-8?B?SGpoaHM5Y1hEQW1ZRDRyTkJLNWh6RmFRL2dDUURsZG1oYUR1aHJHMEU0cUVw?=
 =?utf-8?B?M1F3MlUzSlVQMmhlR2dRQ2x6SVpwc3VKb2c1LzFIR09MODNNS3RUOStVbjdk?=
 =?utf-8?B?SGVkanFIL3IraHV6cTBodDJvZlM5Um5odWRucXNMa0d0b29KUkVWSlBkYTBR?=
 =?utf-8?B?YndjemlDd0FSVjJUWVhZc0NkTEg0alNrWnBXMGNSaGIvRW5Felo0bjhuZmlx?=
 =?utf-8?B?Z0FTS3VFNnlUOHExNldWSFd2QUdPMkJBTkNUOFd1V3ZMOG5IUmNmWGo0cWFO?=
 =?utf-8?B?SHk1SXAxaG9SUWNrMUxNVjk0U2NibnBidmdpeForcU5EMkhJUGZxcXpSemZK?=
 =?utf-8?B?Z1FydXRhQUFDTXRGUzFZcDBMcHRQelV3V1MwZ2VXRmFUd3N5RlF5WjhVVHgx?=
 =?utf-8?B?THNwSTZVNDZyVmpEOVFEQ3lqOHljTUhDVUlWenFQbG5rZWdKUEExak9QM0Uy?=
 =?utf-8?B?VjhUSXBCVk94eklCN0tXMklLeUc1MDhMSWNSYkZzNFVubDZqYzYrbnVFbFhY?=
 =?utf-8?B?QWVzVmsrWlJDYkhHemE2TEJRWlN5SHBCdEdCSXFzQUc3ZUVoZWk3bkMyOVpP?=
 =?utf-8?B?aCtMaVpoZU1kSFM5L1JHZ3FqNlNmOXliS0ZNdVRYYzY2aldXZHpEeWFFVWJr?=
 =?utf-8?B?eThTa1dTc283SUhPdTRIZytFaVJnYy9sSG9HOU8zeXQyaGdyQUJBU0liUTVp?=
 =?utf-8?B?MWFmWUZTMFFzQUVpK2d2aWgzYS83d0pWMUU0dmk4YmdiR3Z5ZFRRbHhjc1Rh?=
 =?utf-8?B?SndxNWhYekdrcSt4MHllL3BiVGZPaVVidVJJZmtTYWRGNmZ3TGdWWUplcm41?=
 =?utf-8?B?bkpOQVVOc1VnYWlvbE5oZERmbUpNVmFhTlRHZUdFYVdvMEFDWEw3SFdNTGlM?=
 =?utf-8?B?WmJpaTgxS0lmcTB6NEF4QVBGbTh4ZnFjcWZGaW5wTkQvZU0zU1ZrK1llNnV3?=
 =?utf-8?B?aWdJNDY0Q1Z6bVRDZUEvRDAvd202WFU3UVR6VkN0enpNMDFVRGtVc3pFS2Fq?=
 =?utf-8?B?dlZZeXdpMzR4OVdmMEJpMmkxdU9lOEN3SmRtUmx4dVF0Z0dWSGJ2YzdUbWcy?=
 =?utf-8?B?NklYVXJ6RDBjZGltcWRWczMwdkZzT28yR1BOUHBxVDdnRlFFU2lwVzlyOVlh?=
 =?utf-8?B?N1ZLSEFTVXpQaWtMdXRjTGxBSDdzWk5pU1kzcTFVZy9idGRrY0NvS0ladFRK?=
 =?utf-8?Q?yCF89jdCLHY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmQ5bFFnOStycnNKOU45OFAxbGJERmtmR3c0QUlDS0VEYTdvWHBobDdSblFT?=
 =?utf-8?B?b2tvejhFbjFlUFNkVGlXeFlWTmNlZ0x0aFAwV09LakRaN3ZUenF6QkNUcWly?=
 =?utf-8?B?KzZuaVQyai9WdVdpU3BscGZIMFFtOWtJNEFYWkl0TUVYVThnR3RGYUhabmhx?=
 =?utf-8?B?MmJIaHZ0aXZxbEZLd3lDSy9QanFVbjIzNitGQ1ZhbFJYN3ovY1I1bEFnbnl1?=
 =?utf-8?B?c1Jyb3pSM1NXVmZMSTJvMytONTkzVWZCN1dlRU1YL2dwVFg3a2FKNzhNWmli?=
 =?utf-8?B?K2pwRnpHcXBXYVlkMmtnSUNkd0dwODFCUVJnUHJHUm0vc1k0eFdPZ1hwa0VE?=
 =?utf-8?B?RWRVcndDZkFZQVZDTytkVW5BU2kvR25GU2VsTnVSRUpxVDVoeWF0R2M1RmR1?=
 =?utf-8?B?a1FvazhGbHYweGlYTmQ0VWZRVGlhSkc0M3l6VUNDS096MVFHblczTTF0TGhS?=
 =?utf-8?B?NW92Umg0bzFKNFF4NFpNN3k4Rm5rNnVUTUZBNVJhQ3VrV25iZGplWWRHTWI5?=
 =?utf-8?B?ajRlM3NKNGRNcnFnOXh0SDdURjV3MG5id0hJcUNsMzdsOHUxYkFKUFh0czZ0?=
 =?utf-8?B?UXNMWUM4MDE1cHVrUkdTWStVNTNsMzhqQzJzR1VJMDNldE9adU5Ic29yTXNS?=
 =?utf-8?B?eVVlaFpDMlNlVkpPWFA0cFYzdFJLWlFraWVNazdoYjhLL0JNbkoyVnpOUktq?=
 =?utf-8?B?Smt0eHRCZjRxeWVidFlOYitGeHFTQ3pTd3N2cnU5RXh1QzVZMGRvZkN6SStQ?=
 =?utf-8?B?RXFra2xHbDZLU0hPcnp5citJcmkzbWwyY2h1eFUzeTkwUGYrejd6OXJWRmlR?=
 =?utf-8?B?dXU4cHRKN0lqTG55TXk1WWllaFZWRG5aMVVGdzduWEZ4cG1HbXJVQTYvRFlz?=
 =?utf-8?B?b2JuTVdMOWFTTURWbHkrNUh1Skg2Sk5iSEhKMUdtTzUwSjhDVlVla2ZyR0tm?=
 =?utf-8?B?MUtvRUcvTW9CbTRXejl3UjA2d0htMjZ4V2haaXlITTl4bDNHL28yUWdSVmln?=
 =?utf-8?B?NWZ4TjRGN0RWWTZQM1ZoLzdxOWl2UVRJNFVpdEYvMlRIQW1tbkFUejJoNmZB?=
 =?utf-8?B?aUJIZ1c0b2lFR1V6VWR4Y01FOVUyOHRyL3RvVElnU0RSK1I3eTFlbGRYTjF4?=
 =?utf-8?B?QjZPOXZVd0h3VU9VSVlLVHlQcEtuRE5GT2NxYXV2cVVJenlZTWpyN2YxbEQ1?=
 =?utf-8?B?MUVuVXRwdThVTnVOb2k3WWZFWjh2YXFwY0ZrV0lMZU1SNkVXMzJONmpiOGNn?=
 =?utf-8?B?blFkLy9iL2NmNXZsUnlWRU94Z3pQRXNvMmVoaDR2aVNHQXFOd1RCc3ZmVEdv?=
 =?utf-8?B?VERPL2s5R0NlWUhXaGdJUlljWEVBSlZLZnkwVXhXbmd4a0YxeTZNTWt1b1pu?=
 =?utf-8?B?KzdUZ0lXNWtUQy96eGh2Z3VUN0hyY3h0cFNJblEvd3NNbk1VVEJmdFhia1lk?=
 =?utf-8?B?bVNhZ2VHUHdxS3BRZms3UDdhMmV5NXNIUUkvYWJPanhGOWV1N1Mzd0psdmRt?=
 =?utf-8?B?TWYyVW5nTTFBemNPQVpYN1RyZWlNVFhNRk1zTXFyTGJZT1h2cnBtUjcrN2kv?=
 =?utf-8?B?RFQrbW5MaVM0c0l5cS92SmZtaW45YXZ0bXVkY3J3WUZBOExtUFdzengyR3Bn?=
 =?utf-8?B?d0cxS0lxa1BCQTE1K0owcDcrSXZlM29PeStzZXNOTnN4d2xTU0F5SUtWaEt4?=
 =?utf-8?B?Q3F0ZjgrMkhyR2h6ZnNaczhMcFA5dGhmTXdwSXJSVU85M0Njb3pUT09xSTlo?=
 =?utf-8?B?YmZTWENRMWpaUVdLeUYybkNWV0tyMXBRNlZVdFI4Q3RrRXVudmI4TGRvVUla?=
 =?utf-8?B?clMzYlR3emZrWEtrazBFQnY1SlBTaitHTzVLREJEVk5wU1IrOFZIU1lNdFU5?=
 =?utf-8?B?b2p2ZlIyK2Y4ZDNqeXY2a0xFUWhxd3NUOTI4SFZweStkUVgrZWo3d1R4NHlp?=
 =?utf-8?B?dE42aVVwcE90ZUVkY093Sy9rMGY3VU1FSTRnc3BPK1NLL09id0RhTjBVY3BU?=
 =?utf-8?B?eU1SVEs0VXlYd3VURXg3ektkZk12Si9qRUVPSFJBeDlwYjRoMDhHSmtSK3E4?=
 =?utf-8?B?K3N3TXdUazZjd0lGMlRONlFFQUtra1FNaDIyYVBBZmxRK0ExREh0OWppbGdp?=
 =?utf-8?Q?1b23SIIlnSx0Tf9rDH0T/x5aY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e091be2e-21d7-4eed-d7b9-08dd99057872
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 07:51:33.5148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKI2O8dSO2DtLoUuRBHDKeVELeKrjpUR5mQCuqLZKi5xc6D3jenmRW8ky8WskFHn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9609
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



On 5/22/2025 12:37 PM, Lazar, Lijo wrote:
> 
> 
> On 5/22/2025 9:13 AM, Samuel Zhang wrote:
>> For SRIOV VM env with XGMI enabled systems, XGMI physical node id may
>> change when hibernate and resume with different VF.
>>
>> Update XGMI info and vram_base_offset on resume for gfx444 SRIOV env.
>> Add amdgpu_virt_xgmi_migrate_enabled() as the feature flag.
>>
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  7 +++++
>>  2 files changed, 39 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index d477a901af84..e5bb46effb6c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2732,6 +2732,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>  	if (!amdgpu_device_pcie_dynamic_switching_supported(adev))
>>  		adev->pm.pp_feature &= ~PP_PCIE_DPM_MASK;
>>  
>> +	adev->virt.is_xgmi_node_migrate_enabled = false;
>> +	if (amdgpu_sriov_vf(adev)) {
>> +		adev->virt.is_xgmi_node_migrate_enabled =
>> +			amdgpu_ip_version((adev), GC_HWIP, 0) == IP_VERSION(9, 4, 4);
>> +	}
>> +
>>  	total = true;
>>  	for (i = 0; i < adev->num_ip_blocks; i++) {
>>  		ip_block = &adev->ip_blocks[i];
>> @@ -5040,6 +5046,28 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>  	return 0;
>>  }
>>  
>> +static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
>> +{
>> +	int r;
>> +	unsigned int prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
>> +
>> +	if (!amdgpu_virt_xgmi_migrate_enabled(adev))
>> +		return 0;
>> +
>> +	r = adev->gfxhub.funcs->get_xgmi_info(adev);
>> +	if (r)
>> +		return r;
>> +
>> +	dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
>> +		prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
>> +
>> +	adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
>> +	adev->vm_manager.vram_base_offset +=
>> +		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * amdgpu_device_resume - initiate device resume
>>   *
>> @@ -5061,6 +5089,10 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>>  			return r;
>>  	}
>>  
>> +	r = amdgpu_virt_resume(adev);
> 
> You may restrict this to VF only for now -
> 	if (amdgpu_sriov_vf(adev)) {
> 		r = amdgpu_virt_resume(adev);
> 		...
> 	}
> 
> Thanks,
> Lijo
> 
>> +	if (r)
>> +		goto exit;
>> +
>>  	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>  		return 0;
>>  
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> index df03dba67ab8..532b92628171 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> @@ -295,6 +295,9 @@ struct amdgpu_virt {
>>  	union amd_sriov_ras_caps ras_telemetry_en_caps;
>>  	struct amdgpu_virt_ras ras;
>>  	struct amd_sriov_ras_telemetry_error_count count_cache;
>> +
>> +	/* hibernate and resume with different VF feature for xgmi enabled system */
>> +	bool is_xgmi_node_migrate_enabled;
>>  };
>>  
>>  struct amdgpu_video_codec_info;
>> @@ -376,6 +379,10 @@ static inline bool is_virtual_machine(void)
>>  	((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)
>>  #define amdgpu_sriov_is_mes_info_enable(adev) \
>>  	((adev)->virt.gim_feature & AMDGIM_FEATURE_MES_INFO_ENABLE)
>> +
>> +#define amdgpu_virt_xgmi_migrate_enabled(adev) \
>> +	((adev)->virt.is_xgmi_node_migrate_enabled)

One additional comment - better to add another check like
(adev->gmc.xgmi.node_segment_size !=0) for keeping this only for xgmi.

Thanks,
Lijo

>> +
>>  bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
>>  void amdgpu_virt_init_setting(struct amdgpu_device *adev);
>>  int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
> 

