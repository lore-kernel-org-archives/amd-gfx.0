Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEA6D2FFEC
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 11:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F96F10E356;
	Fri, 18 Oct 2024 11:15:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VlBPmvx/";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC12F10E356
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 11:15:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geMwoU7MhDOZXVxgxuQsz911ii6taG3BDOLpaNPreDNrvDo2WRQcLsToCk07QDzlmwgM/DtQM3U0okGPatXQEtzwS2PEHXzHt9C3dWofuSaa9iO/T4rdr9M5oJ/qYB23tkyfsbE0azsnm9sM6SgRqfdbnqzYnUfH81Qc6cmJD5DhRTDgjiPZtgp+Eik+Lda8Iw/75+WGRwOSbUhtuK5rpTqBkRfPU0Inj8nQVJZvtDDM6VI85lCjz2vYqyeV+Xo9HSH3Sah757rA5GZr3TniBOmuXUYxEoOZm/Y5AAPJBCtI1hPNA1mWEa5lruhpOnpYcQqojY8YBbxliEq6cqUCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/EYNu0cBau33ajZyuzA/VMrMdDETVFJhxoE4nT/WUE=;
 b=bQAJI5EafAly8mXbP1uod8MSzv5/jq0YO4/Wf+uksquiPEI1pMWxHi22FDITknUB5qRMqIG6DIXKPd+OZzSwH8qWJRs/WunSCzbOjXrjjELI+V3Lm1HuPcbxwPBi4BRgWHYBnXK56zbmLJ2a5lYRJ/AEMMNt04v/NvCXubmIUpljkkk0S1H/n4wIAI2F6yGgoD9+ms/zZK78xGJMT2YLn5j4PVXDuOD9F01zJ7F0TTGTfgq/Es7bCeNf9HRcZFMqvxZgz1xqQWC8IJGkz5UtwocIenuZ5z30qilMjXC5ILmXJMPJL26SzVx72he9d2CbZ7t2kkJopDQHClAm07bXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/EYNu0cBau33ajZyuzA/VMrMdDETVFJhxoE4nT/WUE=;
 b=VlBPmvx/iWGH9CueV/xZxxgdA2r8rlITm5d85CpUrWc/mRPf5/soi6GmUKRcNU3UAPjuj0Dw2zBvsvp6e+zox4itNYxTXIgLiXEFYqZeCPSsCeVzVs7Y3MEfNanlDdtZ+7xMZKWWFZ5oo36mIB9Pej0WeAOCEeD3cX1W2JiWsB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 11:15:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 11:15:28 +0000
Message-ID: <cb199135-77eb-41d6-a87d-e3bfd456db82@amd.com>
Date: Fri, 18 Oct 2024 13:15:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/12] validate/clean the functions of ip funcs
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017162531.1551442-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241017162531.1551442-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e9ac80-02d4-4950-00fd-08dcef662ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXkrT0xSN09YQS9XQU1INjMyU1hwRzErTGFCZlNoeEdxRXZidDBCYUNVQllq?=
 =?utf-8?B?QVR4QzNndUFOVytDY3MzcU16V2xyVDhVaUY4MUFXZUx1NUJnZHJST2l1bmVX?=
 =?utf-8?B?WkFKQnNhS2w3UWpidnJOUitxVjNDeWdxcWxXVzZCa2RtbmNYNENBNzF0eDVC?=
 =?utf-8?B?NVRuSWVxTzBHNG5zNk9RcHhSdkFQNnNWQVBJdVpjaUNSRVNGem1qbk50VDhS?=
 =?utf-8?B?QW9vZ2ZtVk9iOEJSdVA2V2JyQTBaR2NXRlhnTzlpbTlVcWp0N05FdEIwaENw?=
 =?utf-8?B?TTFkWndKSUtMdW5PTk1UVlJWbVFHZ1NGcWxuZ010MW9rTS8rV3duQTNZL09w?=
 =?utf-8?B?R2RBeGRlMlROZTdPVmFmOFpFL2FuWVVKd0J4bFdMWElSUlozRkptQlozYVBB?=
 =?utf-8?B?Y2FOVDBZNVBjbks2b2UwWWNXMTJ2UEVkTkNzb2RxRitOMkRMMVN4c2dCQWRh?=
 =?utf-8?B?R1JUK2NSY1VxVUg3RDZUbHJ2dmZ1M21LSHV1Nmp1Y1RtTnhRSGdPQzgzMVRs?=
 =?utf-8?B?MHJTS3pEQmJVODIrT2NJek5ydmE5bnZuclhCS05KNlZXMHFLbEpUYi9oWFAw?=
 =?utf-8?B?dGlueitMcVBURElNVmVWdlA4TGFSNTRUc0xVT0w2YVRXY2JlTTZodndUbnhH?=
 =?utf-8?B?RVRjeEV0c2dHRTg5QjBYZ3pxNWxaMWkzUzZwSHhRVkx5Qm5Mc3RUeUZOeGho?=
 =?utf-8?B?R0FKb2d1U0dnekFqNmJiaHZjdUtRTDUyUUpYU0ZhSkRYTjQyVWNlVXJ6Vlpr?=
 =?utf-8?B?ckFubDR0dm00c3QyZVNOUTU1L1BDVndNQlJURTR2K3FMeXNoQTdibndKNW0x?=
 =?utf-8?B?OE1rM2dncXA3U0xiSmlrSEJsbkNQV3ZDYzNZOUIwS0ltckNQZWlaRGp2K0RR?=
 =?utf-8?B?STdYNXdRODgwV1FWcGk2WTdLVkhkT1Buc0RNd3hRUEhFT3pRcDBmcEJEdUVR?=
 =?utf-8?B?dkdhU2VBUVJDZmhzUHBLamFqMDdpTHZ2RFplVHdVMkI0anZoSDYxQlhYam1R?=
 =?utf-8?B?OXFuaXdhN011OTB5YTluZ05idjgxMXN5VzNENmlLRUNQR0lOcmttNlJLYmJx?=
 =?utf-8?B?a3NKbHRNYVhMMGlRYjIzSTBReTNqQlJWQVNWQWRPbWFzWkg4bi9zQ1dkVUtr?=
 =?utf-8?B?em9jMk5rY3dKR3JUTEdzV0lsSzBvVmJtMytuSjlBRnFNN3NGOGdWcUNGWVpy?=
 =?utf-8?B?VnFFVjNFV0FVeW9mTURmbHZveEpxSDVFYjJsOHZMc3ZHTmUzT3NwVkd1bW5G?=
 =?utf-8?B?bUdZUkN0cUQ0QXZYYmxSNlFYMjNYQU9hek10WGZBclRjemM2N1ZTQ21VUTFL?=
 =?utf-8?B?SlludDFBOHFtc0Q3ZTU2UFhxYVN4UjlWRXIvbmVyL0VoNkt6TCtMS3hVRmY4?=
 =?utf-8?B?VzgwdWJvTWpxQXFMc3Z4NmNFKzBwMC9Eb2xzOW9UNEhiREk3VWk2QnhHRkt2?=
 =?utf-8?B?S2xFTW50WHhheVgvQ2tmTkE1NGgrWWIwTGJ0ZDRzTmw3bjVSRnIxU0tyOC9R?=
 =?utf-8?B?QThKRVRmd1RybTNlUk4yRE5PVXQxd01BOWVKblFSbGdsQ0lDbWwvdTA1R3N6?=
 =?utf-8?B?cWl2OXZzUjdrbVRTZVBiM2RSMENkdEtDTk9xeU53ODlUcEZTanpKT0ExVFcv?=
 =?utf-8?B?c0hldnBFbTlJczFwaGRXRmFEL0JiOGVhaXVMck84VjJaWVpwY0xrdDI4N1d4?=
 =?utf-8?B?OG1CQmNtZ0RNTStVVTdHUU5OOU9mbm9zQmRncXNqdVMySW5ndU9qR09jUEtP?=
 =?utf-8?Q?L5Sxm8LshGo6Br059fLJ2Bs2jGeWcDE3t9xOLDN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVhsV2tvakN0ZXoyN01RNUp0QzNNdW12Y1hiWmhJK0FqWkxWNEh0YWk2MVlk?=
 =?utf-8?B?NHY3TW8zbVZvMGRZUXl4MjJNazk4YzI4S1h5TnMzTGlFWE9ObTV5cXNNQVlr?=
 =?utf-8?B?OW1VUVRDcGY2ZGhxRXNrZkFpaWVzbWNWNUVDSjNXWmZ5Z21pN2VpelFOMGJC?=
 =?utf-8?B?bmc0MHM1dmRzTmg2QTJESnpINjNLYTVHUjQveXpWeVBxdFRxUVp2eXdXUktn?=
 =?utf-8?B?SUY3U1J4VWltWGJ3aGJUdmcvSEVwajF2L1J5TWFpOVNaZldreTNsRmpERVR5?=
 =?utf-8?B?eFNUOXI1RmIzSVRVQXNNTjRNVDIzUkdqQTkwVWlHamJWK0JrNjBJTUgwa1Jq?=
 =?utf-8?B?VllEZUhvdWdKZm9IQUZEOUpqcndwWWs4MVFuYWx1cUJjQ0JLdXJPc0NYdDRL?=
 =?utf-8?B?RDNWRXcyOTFwL3BzVkxxL05qdU5LdExuaU5ocVlFR3haWlUvR09IbzRKcXJ6?=
 =?utf-8?B?M1F3QVBsdnEvVzZNQWo5OUxMbkwxVXpZQ1k4TDk3WloxbmJDYmNIaU1ZNG9O?=
 =?utf-8?B?STVpK05BS3dXNDd0eVl5SlpKdEFuSEtXOTJCbzJqaDdCS0VYaGplQW1CL2Fp?=
 =?utf-8?B?Tm16THRFOEFSZE93UnFUbi9tSHAwVkFTU201M3F2NzVob1VMTXJtclBud1hm?=
 =?utf-8?B?U1lMUzdjbFlueEVyZHlYU0tVcFlRY1RrY0ZLaDdWei9RZzZSelVSRjQ4WmZY?=
 =?utf-8?B?cDRka04xV3VOSEFjS0VJeHg3VEVsTzNac0FJaFJnMXpyMGF6Vmg0TTlFd0hK?=
 =?utf-8?B?Wjk3Tm5BWEg1VnkxbkM3WE45dGF1bk9oMUxxUTBhbi9tRnJqM2VKQ2d1NHNt?=
 =?utf-8?B?Y0R2UFpKamVjRlpKTEdxZ1pmU2UvZ0FQVDRlTkRoa1RXTEpuU3d0MFc4aU0r?=
 =?utf-8?B?cjQ3ZXNlS3Bha24vSUhKWWdoaEtPdXlyaXRJWmlDbTJNTjNtV0svMnljMDlj?=
 =?utf-8?B?M29jOFF2MVhNV3dBcEk0dHB1YzRneG1wYmo4a25rN29PM0dTaXJHdU1jVjEw?=
 =?utf-8?B?dVkvd3hoMTRweXR6b3JsMUFoUWF0Q2dtUXR3ZDFwdEFST1UrYW5tWlV1bmlw?=
 =?utf-8?B?SDBQTjFKN2hzNnZ3RmZmaEdKT2JFNEJTNjI1ZTNGZHU4TUdGWnZ6Y0x2WFIx?=
 =?utf-8?B?eWJ6RDRXNVpvbFUxSzdqUU1ZdWd2djc5dHdvcWdCYVNBMlVXVndtU00xL1h2?=
 =?utf-8?B?NzNkeGg5QzR6ekU0S1lDUzRkMXNiSXlVRGo0WEtCU0Qvb2oxVHUreG1BUkl5?=
 =?utf-8?B?MDRXVzUwV1hTUmtlQ3BGVDdDVnFtbGJMcmpabi9wMUFXWXBlUU1tYlhuaWE5?=
 =?utf-8?B?eEVOdzVWUEdOUlJHKzk1WS9JWjViYlcrQWE0S2s2T1NaeVYzL00zRU1nWFdq?=
 =?utf-8?B?WnY2ZExSWU1ZTWdIRitmRExXazg2QzlLSWVQWE5XdVFxeVBpeXFzRmQzaVV0?=
 =?utf-8?B?VElnNXVWL25SVGErb2gwQWh6eGJzTWJYNHNIZU9oY2k1ZU5hSnpxczJZeXJr?=
 =?utf-8?B?OWlZRnRQWDhrQ2t6VXlWYmlkRkwvZlRibDRuUisrZi9ocWhzTSt1cm1GUlFZ?=
 =?utf-8?B?R2d4VnJybk4vUk9hNkRLYkZHZThZM2VuVDNJL0NycTRuUjB6ZkxFelVUci9t?=
 =?utf-8?B?Mkw3czdGcmswa1lCWC94QzJJZVBuY2lmcHFFWGhKRngrMm5tSFdjdTN4Zmxq?=
 =?utf-8?B?MjNHMk9KQ09Oc0ZVbVgxMTFaWitTTFhFRjRIb0tEUSs4NjhwcnVSeEU1djg2?=
 =?utf-8?B?cGYwY1pvQlp0N0JxYmRBQU03M3oxWWhKMkNvejh3bUtPQWVqZG43ZTJRSTRT?=
 =?utf-8?B?TjYvL0VDamFhS3YvZFdRUjJsQkFuQmhqeHBQaDMxZGhVQldkZHRmMUZobFZo?=
 =?utf-8?B?MGROY0VuNDU5UG5ZY2hiZjFaSEsxNmlydDhRSU15VnI4Wmw1djhna0JEcjVK?=
 =?utf-8?B?dDJLa2RObldWWkp1clNxb3BvVC8vQmdINXl5SmFydzJvd1MyTjhQZ0kzdjV2?=
 =?utf-8?B?SldTN21qMDVGdVNaS1ZQdndaUlIveDZHR0lQcUgzRldzWXFMSWZtaGM3U1pm?=
 =?utf-8?B?Y2hwSTVja2ltVU1xMURSbkN4VzZZanFycjdVU3c4bVJqbms3VWx1dThtZmUx?=
 =?utf-8?Q?BxYEbFT5KopUTCopeL01FRQtj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e9ac80-02d4-4950-00fd-08dcef662ba9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 11:15:28.0473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccWDksrA1rYz3/Qed1mhyxd6QKmrG2749/Tw9lCXWiEmCEUDQSJgs2vZ/15iRIif
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
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

Am 17.10.24 um 18:25 schrieb Sunil Khatri:
> v5: Fixed review comments. Dropped hw_fini patch and need to look
>      further why such functions exists. hw_init/hw_fini are mandatory
>      functions and we should have a valid definition.
>
> v4: hw_init/hw_fini functions are mandatory and raise error message if
>      these functions are not defined.
>
> v3: Added 2 new patches to clean get_clocking_state and hw_init
>      validation.
>
> Sunil Khatri (12):
>    drm/amdgpu: validate hw_fini before function call
>    drm/amdgpu: add helper function amdgpu_ip_block_suspend
>    drm/amdgpu: validate suspend before function call
>    drm/amdgpu: add helper function amdgpu_ip_block_resume
>    drm/amdgpu: validate resume before function call
>    drm/amdgpu: validate wait_for_idle before function call
>    drm/amdgpu: clean the dummy resume functions
>    drm/amdgpu: clean the dummy suspend functions
>    drm/amdgpu: clean the dummy wait_for_idle functions
>    drm/amdgpu: clean the dummy soft_reset functions
>    drm/amdgpu: Clean the functions pointer set as NULL
>    drm/amdgpu: clean unused functions of uvd/vcn/vce

Patches #1, #6 - #11 are Reviewed-by: Christian König 
<christian.koenig@amd.com>

Patch #12 is Acked-by: Christian König <christian.koenig@amd.com>

Patches #2-#5 have some minor nit picks, but look good to me in general 
as well.

Thanks,
Christian.

>
>   drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  20 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |  16 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 120 +++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |  23 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   5 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   9 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |   2 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  19 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   2 -
>   drivers/gpu/drm/amd/amdgpu/cik.c              |  15 +-
>   drivers/gpu/drm/amd/amdgpu/cik_ih.c           |   3 -
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/cz_ih.c            |   3 -
>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |   9 -
>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |   9 -
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |   9 -
>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |   9 -
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   9 -
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   6 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   6 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   6 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |   3 -
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   3 -
>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   3 -
>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |   3 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |   7 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |  14 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   7 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   7 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   7 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   7 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   7 -
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   2 -
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |   3 -
>   drivers/gpu/drm/amd/amdgpu/nv.c               |  14 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |   3 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   3 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   1 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   1 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   1 -
>   drivers/gpu/drm/amd/amdgpu/si.c               |  21 --
>   drivers/gpu/drm/amd/amdgpu/si_dma.c           |   3 -
>   drivers/gpu/drm/amd/amdgpu/si_ih.c            |   3 -
>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  26 +-
>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |  18 +-
>   drivers/gpu/drm/amd/amdgpu/soc15.c            |  14 -
>   drivers/gpu/drm/amd/amdgpu/soc21.c            |  14 -
>   drivers/gpu/drm/amd/amdgpu/soc24.c            |  12 -
>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         | 275 ------------------
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         | 274 -----------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |  10 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |   5 -
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |   1 -
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |   1 -
>   drivers/gpu/drm/amd/amdgpu/vi.c               |  14 -
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 -
>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  15 -
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |   8 -
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  14 -
>   78 files changed, 99 insertions(+), 1094 deletions(-)
>

