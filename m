Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B160EC25B74
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 17:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0900510E785;
	Mon, 13 May 2024 17:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vJD2n1LK";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D55910E785
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 17:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgYmwXfzH2qGdr3MhSsW/bJi+XQalNQttybkHPA0V6qtRofooUM+8PwiynliItyruprg4C+9G+fjOO7uPgRTU+i16UVIY3Z8SeW2yxgxOOlOFKvGUgYjp3jpYAmlERAc82dTq9o+Z2VUIK8r8k/ACMNZdQUKfgAANJkdjBhXorTFkUx0JxOrxw2o5wmQk1uiqbe3A42mMsl3WTyWqhwV9fqJIgibeGCwGnM9oiSUAa6RhP3pU8Xv7EmVxPHl8W3UqL1bJi5kKdfdo0+lmP/xFBd9W0UOLwF+uH630p+XGTyM3dQrCo+0nE/Ur/5+PKXbuR1T6KtpC/Tidl2jn7hgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0CO9zfV5/IhoCEqFFcudMD/Ivq7NbCjI+tXvOFvPnA=;
 b=mVTaaWmZhAIbsx4Ee0Z1JmIb0TVhWbT+4EXavCchopDJZiBxdVJJVfUqllEAmZDB5J5g+1oIMVwiyjuXiomWVu6aWdvfVNum21Axbn/EaU/QpmtNFUCEUzsUo550J8dWlO1KbT3Rcsy2U6xoAF3lOEfaSZLFKWLphY1eYgXMKI++k/GNoSSN6MzKMUbvkLFfeKEWWgeMJfcah73c9DUHTZEdF1RY+EH/d5pasuCaBa0tg49FUEKjUkLTVXrXpPn7tVY9EfeY8FRPe6iG0m3RxlgEk9AUpyT0ENbxiiZuOF2YOkY4IOD7/kcI0UtGPtHkIQZZrEsVv6PYQ3m3E48MmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0CO9zfV5/IhoCEqFFcudMD/Ivq7NbCjI+tXvOFvPnA=;
 b=vJD2n1LK4QdMTgZt2icKU48FuBBdjlE/LEBDng/7XaETRKZyr1PdOKvrNkYatbb1hjG7wUm+E4Lj09Yh06xSkjuQ9qvYBNF42hhm/rR/SmmDvs0JfQvHaSSZdYEMrxl1zSEoa6Chqegvgj3bv2Iv8wQwUEFBn4he/3t6ukFVLyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 17:43:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 17:43:51 +0000
Message-ID: <f49c9171-bed8-47ce-a2e7-0a91a4f231cf@amd.com>
Date: Mon, 13 May 2024 19:43:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: remove irq disabling in vcn 5 suspend
To: David Wu <davidwu2@amd.com>, "David (Ming Qiang) Wu" <David.Wu3@amd.com>, 
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com
References: <20240509184032.1463021-1-David.Wu3@amd.com>
 <ee168145-3baa-4d87-b92a-b0f696a7d3d6@amd.com>
 <51404285-759f-44f5-9e38-2144206e7c0c@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <51404285-759f-44f5-9e38-2144206e7c0c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ef0ae7-80af-4f2b-0580-08dc73744095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0wyMWJEdkFRakRQOVNhaUZaS3NwQnhUUC9scXNQbFhoWDZaZmU0Sk8rRU1Z?=
 =?utf-8?B?YTF0WWZ3UGlIaWVsaHE4R3Y5dmI3bFhaY2ZPRXRHd3JZbCtLT0dkRUFhb253?=
 =?utf-8?B?VVR4ZEhDYmEwNE9QSGo3T2VtWFdmUkhuaVVpSWRIdFEzSzloMUsycUlKUGFt?=
 =?utf-8?B?MVF4SnFobVBINmc4cEVtSGsxWjJ6djZpajFQQno5bjk1bmNlNDFzK0FTNWxR?=
 =?utf-8?B?KzNQdERuUzM3V1B2RE9TVzdhd3dzcnZVOGJYM1d5aWVrZEUvVU0wVEQ4ZS85?=
 =?utf-8?B?dGV2OGJVd3diRTgzZFZ2SDAwWkdtWmxha0oyZXJ6TkZnaXJUWGMvclRZN2pM?=
 =?utf-8?B?RlJZMWFGSVJPc3pWZ2VNNW5BbEwvazUxT3lpNWxwN0hyNXhqNVlFcnIyQlgr?=
 =?utf-8?B?LzhscWtWMWc3THFkMVVyZFFYc1laYmZpRFp5cHFIOUs1YjlrZXptaGJzWWxQ?=
 =?utf-8?B?MEpFaGZVcXNXeHp6NUhzNTBLZHZiaGxidTNETTBoMWQ3SlBvZEswSjZvY21X?=
 =?utf-8?B?WEhRbW5zYVdMU0NuaHlxMmY1REM3Ti9qdVdXWTdCaWdwUXZzNlFXWE1OZVdH?=
 =?utf-8?B?a1R2WnBjKzRSYVlRYWg5MlVGRmxzRm9MQXdJVnRtc3p0OGQyemJ3T2hac2t4?=
 =?utf-8?B?WnpBWDZrUWdQR1RIWUNBTnF5RWIxMXgyZ2FTdmUvZndHS1lBMVNPOS9sdHRz?=
 =?utf-8?B?dnZxWm02dmVJdlRJOC9LQ0hvalBnUVhiY0tzWTRGYnhLUUlTR2UyTE5Keklq?=
 =?utf-8?B?cndxMnNYM09iREJBU08zSll1dGNsNXh0c0UyTXBJMkdpY3VtVGFWUmxrdktY?=
 =?utf-8?B?WEhqaGRZZ1k1UlU0ajRjWXhtRFB0eDAyQnhnRDZzc1FkVzhUL1VyWXl0VDlS?=
 =?utf-8?B?WUUwcmx5WlhERHR2MmlKQjN2cGg5RVN4elowaWRiWSsyTUhXRjg1NWJMaHpl?=
 =?utf-8?B?TnFodE9hNnZsVEViaCs0eTlHM2h3MkhmQjhDcnBLWGVQVE5IUGZhWldOUFBL?=
 =?utf-8?B?L3RYK005SjgwbUtmRnpIbVlWV2RBVEdhbFBLNkZyY251alNxTU82alU0dndC?=
 =?utf-8?B?T2JZRmNCa1lIOEJMeXZJL2h6elhSZU5HeVkwaWFES25HMUYvKzhyNTgyT2FB?=
 =?utf-8?B?RVA4dEZLeU4rZEtwa1dPTG9RSnJib0tPWFM3clRQbFp5bEZvSWxhOU5PUSsv?=
 =?utf-8?B?N1VxVGtCU0RGV3l5WmZJRW42ZGN2eTZuOWh0RzRrUFNwM2c1YzRFR093WExw?=
 =?utf-8?B?TCtMVUtSbGFRUDBtdktZUXJ2a0RRREtTSXB1YTRiZTZHaWtqVlRVb1JCdnh4?=
 =?utf-8?B?Y3NkU3FVZGR1NEpPRTVUa2JQaTdISHdmR0llc2l3TXVWK0h1MDB2bThhYXFN?=
 =?utf-8?B?MGRGb1NySTg0T3pCUnk2Q2FvNUJmV2VLaGxEWTExNWZFZmlSMy9hdDZ0UVBP?=
 =?utf-8?B?MDRHM2h4WlViWFh3ckwrcElvYm81c21kYzgza1RWN3daVEowaTQ0YUR5b3la?=
 =?utf-8?B?REFxbWo2bVhBdzJGOFd2MzVyQ1FvVmRTdGNQWDA4dnNCZi9sRzJpRmwxRnF1?=
 =?utf-8?B?R2VMQjcwT1RHZTdsT29oWXRXSTlZN2lMb1h5dEtUUGN0Z0tXSTBPSitIR3ZN?=
 =?utf-8?B?MEIvdmlYa2ZUK21hQ2JNT2hPMTBLK1Y3Y2NmY0xOaUZLRTVNcE5XZlR4QXQ2?=
 =?utf-8?Q?GXFuxlrDjToKNxowroB2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2VYV0NkZEZLSnpRVHdYSnkrU1hIcnRva3BINWFjbW82V1NXWUNmYjl4OGRH?=
 =?utf-8?B?V0Rqa3lYOUU1T0hKTmpEOTQzM29SYm5NVklQMENLNC91MkNJblRoa2toc3U0?=
 =?utf-8?B?bkNZYnBRVVBIR3VQR21ycEo4TWVTem9nNllKVEtSMlMwT1g1UFBIUzZKOFk3?=
 =?utf-8?B?MWp3V1UwOWRVVGcwdTRBM3Zzd1pnYkNpZUU5czVRZnZsWUdrajlwOW5EcDU4?=
 =?utf-8?B?ZEZsU2dNMUtwb25ZVEFOTFVDTk5CaStHWE9DVWtNV3VINmVvazZiOXd1Rzgr?=
 =?utf-8?B?S1NQQS91Ui9uY1dKcmpRcng2eDdmTnlTblVVb1VicGlic0Y0NENaSEZpTXMw?=
 =?utf-8?B?NWlxTTVyZWYvL2o3TjF1M1NDdDdQQ1BrUVh1UGp4NURlSmFidFlOc3c1V1lH?=
 =?utf-8?B?Vjd3Z1kzbkgwcDhHZnZlY24rR3BlWHFkVlUvM09OUC93ZitzdmlSTTZFRVZl?=
 =?utf-8?B?UmZJTy9OdE5wLzdlY0R1alRvbjhtWU84ZjNyKzhYeHlwdGVPNzBINEJaZHB5?=
 =?utf-8?B?dG9XZmFWZ1Vxa1l0QkRCWGlVTFhlaGNTVDNpanR2MXJpd09tbVFXcmJSaGlm?=
 =?utf-8?B?T1pBNkJDOXFKbTRyOVRtYkdQc1BqcTlWZEV0VEJDTDdINVprVlRkME1oMklI?=
 =?utf-8?B?eUFFejJXQS9Uam5lVVV4eEl6TGUrVTg3SEZjaXIzMTV5MUhpRFEwcFlFaEM0?=
 =?utf-8?B?ZS9aMm5xUStFQWY4by9VektwQnBDTUhnQytXYzRoZGpPaXc4UENtc1k3RWVP?=
 =?utf-8?B?YnNjdStWRUducyswa3ZXeUVUN0MvTHRLWlV4TUdIa1AxdEhXMkx4aXdFT0Y2?=
 =?utf-8?B?T0t6UFlPV1N6aHFydHZQZ0d0eFVuR1B2b0VwV0J3a1RxQitnSHl0REFpd0dF?=
 =?utf-8?B?UXgrNDZzaXRHVGRlYi8razVMT1VrdWxHcTZsSmxsT1h1V1dpWFVlclFUQjBI?=
 =?utf-8?B?Y0c5SGdidk80a3VuOTVMMGEwdmNHbmpuYXdiaEVtRURzRGNMYmt0K2RMdUdl?=
 =?utf-8?B?bWtCcEtuN2g4VWVxeTVmRmVVU3dQQndCVzlvZFBqTDdtSmlhS08zSU9kbUlP?=
 =?utf-8?B?MHlzNmdCSG83RUZJMVdNYTVVcXN1L2ZqZ1VkbzF5Njg3OXJYanQyMDZDOFdJ?=
 =?utf-8?B?UjBZcklteXhGd0c0cmtsVDVJK2xkdGxSbGJHTEIydzJiN0RLZSsyamNBUjdX?=
 =?utf-8?B?NEJLU2RrNHlxemc4T1dSSGd3OXd4VkRzbzhxRURSdnZLbEdBdVhXRm1uOStQ?=
 =?utf-8?B?NzdzK2treHpEamdadVNoMzJ4UW5qR2VEaWlTSE5odzhFb0JpV0VQUXNBRytB?=
 =?utf-8?B?ampwenc0Znl3SG5Bemg2VEdjd0dDdzQ2MkxrdVo1MTV3RWZEYnNsRk16Uno3?=
 =?utf-8?B?Sjk3eG42aTZhR0loYWtYZFh1MXUzaERwYUVvVW8wWDNpQ1ErTks5bEdXbFl0?=
 =?utf-8?B?SXZkUjRWY3ZtYjcxL3Bod2lpMk1NVVllQzU0MkxDaUlWNWhWUCtmakdCSHdN?=
 =?utf-8?B?Vmx0VnJyalY2YTBFQXoyRHBObHZHNHMvZmZFWTNvT3g4YkVGUElZMGtKckdX?=
 =?utf-8?B?NmxZTm5GNk1mNFJpTzZZd3NmajB1VEdxVy9iRG9KMWExZWdOQ1NONmdwQ2w0?=
 =?utf-8?B?bytMamFPZXZkaDk1d3JOSTBWNGllRjZReVNrWkgvZVFyditUOWdBQUZSMUdn?=
 =?utf-8?B?NEs4ZFNjVWZCc3VnVTA3ZHRCYkZEcm1TVE4rcSs4d3hJemZQN0FzeUhIRUx0?=
 =?utf-8?B?RGlaVURDODkyWERXajJza3lqWENjTUtzdHVQSXRtcWN5UXgxYUg5Z1lPcFUz?=
 =?utf-8?B?M2ZNc2J4bUszUXVJN0EyRzM5VnVyKzQ2TG8yTnNiR0xuNXY5aHRONS9DZzln?=
 =?utf-8?B?cHNhTFV2dE1CQStmWGF3b0tCWFZTRE8zK1l5YUkzN0M3TEZrWnlsNzFHYnh2?=
 =?utf-8?B?QkU5a2VCMFhybmFJOUMzTDJYOVFJM1hyQTlUcnJaeDlTNlVGVFRLaWFPdFV3?=
 =?utf-8?B?VjlzVEFiaGFMRkw2NzZ3WmdBem9TSVdJMEQxa0JrbWtNVGNvWEMxQnAyVTN1?=
 =?utf-8?B?d1l6eUdWNkpDRk9nSGxrVkwxVW55MFBWRFVsQnBIMnBlT3NaRnFRMy9XM2NE?=
 =?utf-8?Q?zy8CccUJUEmWcMyCXyMpDwC5H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ef0ae7-80af-4f2b-0580-08dc73744095
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 17:43:51.7980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGP/GhSLxmYTIanXaY6eIw2eZF0kYmP65K3sYkrO/DqJRggMl73YsxLNOJUbmjEK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
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

Am 13.05.24 um 19:41 schrieb David Wu:
>
> On 2024-05-13 13:11, Christian König wrote:
>>
>>
>> Am 09.05.24 um 20:40 schrieb David (Ming Qiang) Wu:
>>> We do not directly enable/disable VCN IRQ in vcn 5.0.0.
>>> And we do not handle the IRQ state as well. So the calls to
>>> disable IRQ and set state are removed. This effectively gets
>>> rid of the warining of
>>>        "WARN_ON(!amdgpu_irq_enabled(adev, src, type))"
>>> in amdgpu_irq_put().
>>>
>>> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 19 -------------------
>>>   1 file changed, 19 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>> index 851975b5ce29..9b87d6a49b39 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>> @@ -229,8 +229,6 @@ static int vcn_v5_0_0_hw_fini(void *handle)
>>>       for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>           if (adev->vcn.harvest_config & (1 << i))
>>>               continue;
>>> -
>>> -        amdgpu_irq_put(adev, &adev->vcn.inst[i].irq, 0);
>>>       }
>>
>> Looks like you can now remove the whole for loop.
> I realized that but there is a new patch added inside this loop to 
> cover the suspend/resume issue.

Is that added in a later patch or did you rebased your patch ontop of it?

If it's added in a later patch then it's better to remove and re-add the 
lines. Otherwise you can get a mail from automated scripts that you have 
dead code.

Bit annoying but the documented way of doing things in the kernel.

Regards,
Christian.

>>
>> Apart from that looks good to me,
>> Christian.
>>
>>>         return 0;
>>> @@ -1226,22 +1224,6 @@ static int 
>>> vcn_v5_0_0_set_powergating_state(void *handle, enum amd_powergating_s
>>>       return ret;
>>>   }
>>>   -/**
>>> - * vcn_v5_0_0_set_interrupt_state - set VCN block interrupt state
>>> - *
>>> - * @adev: amdgpu_device pointer
>>> - * @source: interrupt sources
>>> - * @type: interrupt types
>>> - * @state: interrupt states
>>> - *
>>> - * Set VCN block interrupt state
>>> - */
>>> -static int vcn_v5_0_0_set_interrupt_state(struct amdgpu_device 
>>> *adev, struct amdgpu_irq_src *source,
>>> -    unsigned type, enum amdgpu_interrupt_state state)
>>> -{
>>> -    return 0;
>>> -}
>>> -
>>>   /**
>>>    * vcn_v5_0_0_process_interrupt - process VCN block interrupt
>>>    *
>>> @@ -1287,7 +1269,6 @@ static int vcn_v5_0_0_process_interrupt(struct 
>>> amdgpu_device *adev, struct amdgp
>>>   }
>>>     static const struct amdgpu_irq_src_funcs vcn_v5_0_0_irq_funcs = {
>>> -    .set = vcn_v5_0_0_set_interrupt_state,
>>>       .process = vcn_v5_0_0_process_interrupt,
>>>   };
>>

