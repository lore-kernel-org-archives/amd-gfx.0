Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B878CF8854
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E9C10E06A;
	Fri,  4 Oct 2024 18:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2WDs3hZf";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF9E510E06A
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUBiwluCMhIA/aTZpylOIEN4bJflHOhZb0WkDzoT1rIjonXJs81WNUs99HxVuDmm1UD8Wekt+NMgGcO1VT/GEp9UnTApEySn2X/txT1B6U2O8iv5l8CpsqK7ocxpxC+RwCCpw1P+droBjvhxuOWLDCx+K9mRYpgk8mUcl4UUrp1zUjC9H8AzArLL5aocYJeu+cZNu83aSALahUNer8TKOK3KrOupTL2+q3qMygfOUmXie3SWH/houM5aWOLlBzWwGVAidVmy2dQP0BPEGj3XdOvlxt0FWk0qrcvHEJdW5R4X/jAzKfx/bqMaNzunixPb49njT01oC6di5p/nERCPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5b3wzTpXWkRjyuTtIgxm2lDkSU9ZmfUiUDAK3R0/DM=;
 b=U433Vdi1xPjMul+NCVZKLs4mpHM4NGKNGxqFFVfa/7olJd1qkjbfXUmW5Qq/FZD4tVCSkmNcWFjumyqXdvqjt8wuvOIdHHp9R0OEyrM87kwoWEMO6pm1Xw9k4n4duzmydA49y+oe79kA1oO4uvhEP034quqOzFrRe5QO+xAdciz1CrP3TjRJ9DEAUO2RD8RU4FBXKpvXjyVs4naJQmOi1AYb931N5QEhb1JE/hDIFL/AN9JtQ4cWIm103bgRihA6/A3+aSqkeDwh2RdcxGXKhpCbH2mf+NQ2AyrU6CdJglBo3Sl6VLQz54XSdbYb6yvWVN/kG/ZDtMc4Hl1nkU5cBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5b3wzTpXWkRjyuTtIgxm2lDkSU9ZmfUiUDAK3R0/DM=;
 b=2WDs3hZf5tG71dHdiTIOb6K2jlapOu4rpRW/QGYZ96V1XKJ3CAadNgwyNPjhjkfsyFLgDsv8zl7cjcwl0AwF2Uz6aw33MXPGce/92Doljt6WEhcoo1VO1ANMHlS4HxaI6mNOzzS6aN5/GkhaA5hoyvUIR/d8Ysz57H7cRw1kQZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) by
 SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 18:52:56 +0000
Received: from DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7]) by DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 18:52:56 +0000
Message-ID: <1380c0cf-823d-4816-9264-b65bdd892dd7@amd.com>
Date: Fri, 4 Oct 2024 13:52:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Move gfx12 trap handler to separate file
To: Lancelot SIX <Lancelot.Six@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Jonathan Kim <jonathan.kim@amd.com>
References: <20241003193127.723149-1-jay.cornwall@amd.com>
 <a1ce00ca-a98a-4b2b-a241-3277edf43d4e@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <a1ce00ca-a98a-4b2b-a241-3277edf43d4e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:806:27::10) To DS0PR12MB8413.namprd12.prod.outlook.com
 (2603:10b6:8:f9::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8413:EE_|SA1PR12MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 662b49de-6433-4f7e-c3aa-08dce4a5c27c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTIzZU5JQmJOQVNiUWxFZnJRMnZHaE5CQkFGUUplY1lnSWhPZWx6ZnZaYnJy?=
 =?utf-8?B?Zzd3WUVoaERiK2JFTmFsKy9xOUoxZEs4eEVOa21veFNBVkFmSjN5SEUrMHJZ?=
 =?utf-8?B?YnFGNno1TUUxbHpTT0pFY3EvbnBMcllwOUJFeFhQRHUxck1Rd0pZRkNPdmR0?=
 =?utf-8?B?SGs2S29qdlJ1U1BSNDFxek96YnNkd1pOb1ByU3BtZC9EbWZQbE1oZjY3b096?=
 =?utf-8?B?a2NrYzZ5dGQ0RWtxdGJJSGNYRFRYWnRPYkNXYjBIOUdWcWlsT0tzb2V5dEJl?=
 =?utf-8?B?MktHcHNLYmovWE16OHNaSWsrTGY1ZXU0UFRlOEZjTitxb2tpektRSVZObGZp?=
 =?utf-8?B?SUNyZkhkcnBsSFlSQlk5TE54ZURTaUhYc0ZSSUlvQmRJZ2M4T21uUjFhMG9r?=
 =?utf-8?B?R3cwWFJmK2lMQmRxYkJSZGtCN2xZWGlJbjhyYmVsK25mQUdmTy9BMWczWjRn?=
 =?utf-8?B?ZDBZN2J3ejhwL1U2Y3ZZNGNtYlZTMmZqY3RMd0Nnc0o2YmdzUnRoM1JQYXdH?=
 =?utf-8?B?Y3N0WEl5R21sTEp1NDFTUFM5TFVKbVFZdUREanRPL1BzOCtCNkJleCszTUUx?=
 =?utf-8?B?alhZNngycXpiMklyeTMwR3l6Y1lSdGFkRjFrWGF5cVlETTZTbjNCRDBUK1J4?=
 =?utf-8?B?RXNQZXhXMFN5M2RxWE83aE9raTJuU09jdk1RSVJocmZ5REMyQVhYV2NEMzNU?=
 =?utf-8?B?Uys3clJDZU4yNUtYL1NxaVZnYlE3MzVPS0ZFK2NYSlpJZVg4akNpRGJQNDhX?=
 =?utf-8?B?NEI5KytKRjM0YlErK3BrRW9KTlNZdXlKdm1WZnBRN3VIMTM3bFVKNHFWYnlL?=
 =?utf-8?B?dlZUaHp2SytpZXQzelg1Ulhib1YrWlVETFlZa1hOdnhmODg0YTZIVCtmQVY4?=
 =?utf-8?B?Z3orNEJIRXpPNjhjWEd4dlhZWjdDK1orRzVGbk01VVVGVG1NK3R6MFZ4MjF6?=
 =?utf-8?B?bHZTd2txeFpiVFZ5RE15cGxlTnppMnFsdSswWmRDTjl0elRGbTlxWGZDcjIz?=
 =?utf-8?B?V0M2dXpTdUNvUSs1VFFsQVI2NDlGQllLYVNDUWhrR0NlbTJYYWFYRlRtbi85?=
 =?utf-8?B?UnlnbmFrVWRpYzZQeFBKQ3V3NnN1RVhYVFdSZys4NXdIQmt2S0I2NDhFUnVI?=
 =?utf-8?B?STc4MDJBUFhoZ1hXTkNLZXJvTUNQeitsZ3pCZE1FK0Y5Tk9JLzhjT3NNaEh5?=
 =?utf-8?B?UVUxRWZXQ2hzNHlmLytHdTNTbEJlVVNZWmN1d1JSVXhiTUFBVWpBdEJEem4y?=
 =?utf-8?B?bVJBcDNJRGNkazhiMkhpclVkMnltbm9wdnZwTFhqYW8vT1hSMzBKTlRCT0xh?=
 =?utf-8?B?SHhTbjZVeGNIMEZXME1iL3BPc1cwdzZhZlNZU25rNnZZMDNxaWxuWWRvTE1m?=
 =?utf-8?B?RVAxUDFiZG9MY09LYjdiVE5Ib0ZnamVMSjNFV2ZOZngzcXllYzcxakNZaUlB?=
 =?utf-8?B?STExQTBndjliVHR2blFuVkd5RDFiY2VseEVWbHBuQk9LalJ1SVFoQlZXNWR6?=
 =?utf-8?B?N05xM1ZBT2RrMmQ3UW9LTEs3NjhmUVBoemJhWU1HbzllYmFwSmNiL1FEeEhx?=
 =?utf-8?B?ZlZSclY1UGVYN3Qwc3RYRHV6RVE3d3pyc3R4cTEvUkxDQ3dWeGl1Sk9BT0tP?=
 =?utf-8?B?LzlQWHpsVXVUOEExYmJZRmlwVXB3and3eTJsL2Fka1NJRFlpQlFtdUY0Qksw?=
 =?utf-8?B?UC8xdHhzdlZLWE1idW9BT0h2WTY0NHRXSHU1OW11dFpWdFZEaWRTYzlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEJ0MTh0UXpjQmZsYkJYNmdyNmRRZENEenU2OFRmektvdFpvVmpTbytXcEZJ?=
 =?utf-8?B?TnM1bFIvVTBwQXlmOU1yQjJ5OWFqNmhta3lWY3hGOWxVZlRkNFFBK3JrdkJ3?=
 =?utf-8?B?QWtKS0ZjVG8ybU5LTFNGb3dseU1NeG9pSVZvbGNhbVlXb2YrTWdCNHVxYmRn?=
 =?utf-8?B?VzRTcmZoTFhFODJZWDFGVElzWFhQSVgrZ3ltalZsQ0FyT1JDTmphbVM3WkdY?=
 =?utf-8?B?dzRDU0JyT05Cd3Fac2pONnpFVW5FQWZodlJYdVg2R2x5dnR5T1AzL2E5ZXpK?=
 =?utf-8?B?c3JtcmRUdlJGSHZzeWNYOWExUnY3RnJqTVBVU3BiZGdKRG5hcmlnRGZWaFU1?=
 =?utf-8?B?YTk1SkFYcndVd3F0Mk1iNld6enpSa0pCc1hkNWhDODN3UFJ3Z01wUFRKekFu?=
 =?utf-8?B?cEI3T0dlbVgvR1FkUWJqdWx6YlBlMXlkV2M1ZHNJK3ZSMm5JSll2YmExNzVO?=
 =?utf-8?B?WW1uc3RqZXo2eWdnT1RMVUkwRTFSbkdhd3drZElpd1RyajExZUxqNmJOQXBE?=
 =?utf-8?B?N000OGk2ck1sRHZxS3FqZG5XQ25meUNWQXdYR0Q0bFEzZ2dqVkIzL3Y1cGY4?=
 =?utf-8?B?WG1IQXpDTUxDQzVDV255NmdxRnJ3ZGl3b0oyVTA2bXpVYTl3WUJoWEdOUmVY?=
 =?utf-8?B?SE1uSXhIeE1RbVkvVTR0eSt3d05DM1FVOWY3U3NISy9GWkZCa2tzS2N1bmxj?=
 =?utf-8?B?MjhaWHFmdS9QeW5oOHFDV2lYRk5xb1VDM2s2VGoyNCs5WUtiRzFISlEwVkw5?=
 =?utf-8?B?Rm4zNGFrSk0ya2NIcE9uaHZGWHcwZGJ4bUFxZG5ncllvMG03YnhFejBuYzQ3?=
 =?utf-8?B?dUI4ZWEzcTNvTDhwSm5aQlNxU1ptMmkydnluQkxNNWM3Wi9UcjVPQ1BhVWUx?=
 =?utf-8?B?aDI3RVhMR1lDYmlqd1FhQTNZTERZMDU2ZWJObGJYM2IxU00vdVNVYkZMa05x?=
 =?utf-8?B?VVYyUjZvOGU5YnpVaURoQnJSbERWWlZGUC93OFoyY0RFdDZ0V1JqSGVUenNK?=
 =?utf-8?B?UUdxdEpIeGJJZENsS2RJUHQzVFlUdG1iMmxWNW5MNjI5VnU4dVpEbE0zcTkw?=
 =?utf-8?B?MjFNVlJxMWNISkpxempFbU45RE51UkxkcWdlV2NwUU9oUTc1OWRyL3BQeHdt?=
 =?utf-8?B?c3lOeTNpYnVwaWVjZzgwaUIySmFPWDhFb0xBTzNSL0IvOTluWXlmUUkrcWdN?=
 =?utf-8?B?bFNuaTh3RWFCNmNMUkgxeXZuS2tMVlB1N3VYVHFhSmR0VnhvTFJwNmd2d1p2?=
 =?utf-8?B?TlV5M1NaZVZDWDNCd2h1RFNMcERVMnBMKytoTHVkR1JTSTB4NWtTYkFoWU5T?=
 =?utf-8?B?TS9LRnlMamVydVhHMlRFT3JZb1o5VllvbWlJZE1paXJlZWpaM2xXS2xERnhs?=
 =?utf-8?B?STlMRldvRGkxK0h0bmIxM0E3ME9YVUpwZWpHc3pjcnJseDd6SXJlaGF4MFF6?=
 =?utf-8?B?NkpuZDFydnhxOU5nWlFhVThGemNaa3JmNmlOQTlCQ042K2VOQUhob01ZVU9G?=
 =?utf-8?B?OXJzVmdLSWpEek5FZHZPUjNORGlvMEt3eHVTWFhwcWJWbGtTNC9PUnNPYms4?=
 =?utf-8?B?bE9GeHptYkIxZWoybms2OUkvZzA4QXNscG53ZTgzZWwyT1hpd1dxUUh0Q0cx?=
 =?utf-8?B?d2diNlJlKzJNM3lrL3NNd3hjUU45a1R0Nlg5YVF4N3lsandSQkd5NWp0YW83?=
 =?utf-8?B?REp3c1ZLdWsvYjNJTnhtS1JmUWRCRmJKdVpraTh2cG1WRkFKcGZiS1pGYUor?=
 =?utf-8?B?MGU3Skd6L3UvSVVPb0ZsZjV6NXZGbUVEVXI2bFJUUWdpWFpMNE1XMnhqRU9q?=
 =?utf-8?B?bjMrdE9PVFpxV0Y0TEQ1eTJVQTNsL21pT09LSzMvNUFJUVlNQnowV1E1M1dV?=
 =?utf-8?B?MENyY0tILzZEZ21FaUpUTVh1SnZ0RzFJWHNOVjBDeXYra2g0ZlJLcEs1bDhP?=
 =?utf-8?B?bDExc3FNcWcwRWtUOGc1UWw1NXl4QkRiNnlMTGxVSGtXZ0RyQnpKckFyYTlY?=
 =?utf-8?B?RnM0d0k0THhrT3h3dVZSNk5iTVVWVHpPSlEvM3pUamlCNkwxMk02MjhHc090?=
 =?utf-8?B?c0FRMTV3SEdRdXlmVlIvRzRDUm1GUFZUbm12OVVWa1NwTFRHQzFVeU02Wkpj?=
 =?utf-8?Q?RQ9Yv2POQkO7W1Ir3hIffE8xh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662b49de-6433-4f7e-c3aa-08dce4a5c27c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:52:56.5183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqZZO41Vuh+2Kapt9vlW/XzMYoNA3AxGSRI5z8TMtDOaUN2q5aAjrBEy/r3q3BAHnTW2DDN0u2Y+yZ13PCRCdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725
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

On 10/4/2024 04:42, Lancelot SIX wrote:

>> + * Copyright 2024 Advanced Micro Devices, Inc.
> 
> I am not really sure bout the year policy in the kernel, but all the 
> content here is dated from before 2024.  The vast majority is taken form 
> the cwsr_trap_handler_gfx10.asm file (copyright started in 2018), and 
> even the gfx12 specific part have been introduced starting 2023.

I don't really know either. I looked at other files (e.g. 
kfd_mqd_manager_v12.c) and we appear to reset the copyright date when 
they're forked, but I'm not sure if that's an official policy.
>> +    // If the PC points to S_ENDPGM then context save will fail if 
>> STATUS.HALT is set.
> 
> STATE_PRIV.HALT.  Also, I am not sure this part is still required for 
> gfx12.  That being said, this has nothing to do with the rework, so 
> removing is would be outside of the scope of this patch.

Yes, I'm avoiding any binary changes here to simplify things. There will 
be some follow-up work which changes the binary. This patch is laying 
the groundwork to avoid merge conflicts later.

Will fix up the other comments. Thanks.
