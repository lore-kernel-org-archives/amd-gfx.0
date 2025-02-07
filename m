Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DEEC02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 10:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EBE910EA9E;
	Fri,  7 Feb 2025 10:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iuCj5NWz";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5105F10EA9E
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 10:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjOo8FNuTHGn4CfEz1feAfbd/iDUfypDe2mLvt7r+cZcVnVNXOQzHKhRaGP/vwdeYMtNa46fB9vPAQSJZG75PzNXaM+M7k2hY1XFVnZnD0W/sr7dRRvXtNYnGP4xbaGqFOeM7Fh0GHrIJBmzF0gEbXa8CpiqKBfNE2/rpQGXnOMvvLmwP9z2ceYrCdpckaC9iZVX9XgQ4ZY4rkgwRXh9y1twbLg+2uFmlS53vbftsBG2VkQvZQ6AUZ+D4k9pTvasCkzYxtuZPNbSEP+C6p0d9yF9sldM9sNGcLsudx7XqWun6g8N6j8x1P8H/v6WHUP9+g+NnTM5e3VN7G6iwcIdng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWpmSEsl72c9TSYUIP3p/dN3nxKDQw9AVsULsj2oXls=;
 b=r7d92/o2d5tZIcaM1Ae9MB4Bw6ESqQb6DbavhXB+OKbHyiKtOYBXYK04IekjUAsNfCeUTQ1zbuoECmo+su8p+GnQBWqP84VBGqWYK9uzoNEsrh2NfGhV+Y9qNtSnWgAP5cfzrN8xqAuvMm/KKUk51fuMNosW4KRtE3Jn2OoYQSDgcb7oVlSge3h0N9fYJsvQ1FofTwK3rrgLar8+/srZuDGlvmDQh87p+Upp6QV8izKoxM5O79+Vs4dJAQD87aetRGw1mzewp/aZmjpmtUevWfRo30s1SZokjHMhx323bG6ltWoQhbQkUCTUeQ/S5oQACa+jTEHgz5NkgIddfZmluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWpmSEsl72c9TSYUIP3p/dN3nxKDQw9AVsULsj2oXls=;
 b=iuCj5NWzw3XJEtdeUefl6DQwaup78zQrIMWcmm89hkER4WT2y3JLXQlaNLhiURri3SPcgW7+lVbyHgQUNiGk2tvqmBAgMVZ+6CVv5BgbQYWaCZr3sE05aXLq+y8amEhcmaVbzJMlDxiG48y4/JqLcMm/WiIIqArkCLQZlEi+FRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA3PR12MB7951.namprd12.prod.outlook.com (2603:10b6:806:318::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Fri, 7 Feb 2025 10:37:34 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 10:37:33 +0000
Message-ID: <e10eeb8d-69c9-4db7-8124-51495cf15614@amd.com>
Date: Fri, 7 Feb 2025 16:07:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 4/4] drm/amdgpu: minor code style enhancement for smu
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1738910203.git.gerry@linux.alibaba.com>
 <751aa892683cad234865404eccafacbbb73cdf6d.1738910203.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <751aa892683cad234865404eccafacbbb73cdf6d.1738910203.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA3PR12MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: b70c606d-6054-452b-c390-08dd47636e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2poVk1jOU1MMGNhdk9RejVMRGRuVk9yY2JNKzUya3RNQU9vOFE4Vkdna0JW?=
 =?utf-8?B?RGQ0dmgwK1ZWUktPemZJSFAra1NVY1pWMTNlc21ZLzdVOVpBcGpHR2RtREpm?=
 =?utf-8?B?Wjd1a1JpNld2L3FFRS9iSjFFc0l2YWVQM25hYlB3cmYwWm80R3ZhZXkxbVdY?=
 =?utf-8?B?am82NkJLdi8xamFuTGFtSDZPN1dUQmVjUjlCcTh3RVJ3c25zWW1UWGsydC83?=
 =?utf-8?B?d1d5Nk5qWm92OUlSdUpGaEIybVJ6OFpLQi9VbGtCZ0xzMnU3WHpoYXlnclhq?=
 =?utf-8?B?NjJPMjc4OWtiNkNLYU9EaTVEclRBK2trb2FpcXRGajZHc0dOMHhBaDNVb2h1?=
 =?utf-8?B?YkxWbXYvSTBBaWVkVWFEWnV0TVpBRlRLMkVZL1lpV0Y3ZmR2ZUNVT3pBS3Y2?=
 =?utf-8?B?NXMyeVFCbyswdExPQzdYK2MvZUY5K0t0R3FTMkFrSDQyeDkvbmVPZ29tVkgw?=
 =?utf-8?B?TUdoUjJ4aE02Z1BUN2xhNERBVlRQUVNObDU1eklnZWd6c0hQb2RGbHlMcHBu?=
 =?utf-8?B?OTdrMmIwaUJHelFzVEYxRFMweHhJa2RyeFdrQm45MGxTY3RuZWl4UFdJYndD?=
 =?utf-8?B?eWhUQ3VOQ1pTWkZUVXAwUThsQ3FuMHBmOXlDSXUyWXd1YklTR0lLQ3Z5MmNF?=
 =?utf-8?B?aDA3aGN5NTdISTFCVUp0TWtaS3RYYUhkSWxSWUs4UzMrdi9obXIzK29vRml3?=
 =?utf-8?B?S2h5aUtja3EyMkorOFlGSVBMazg0Z3YxK1NvbFhwZ1R2dXh5aHlTTnFRQndR?=
 =?utf-8?B?Y1Z3aTAybGFYMGpDKzZzdTNvZTNlQ3hXUkhPOGZ2UWNXMktLQ0c5bTVWRFhX?=
 =?utf-8?B?aVZCU3RDK00ybjFzTXFScW0yeDVCMUo5UURwa0k2dVE0MUE0aDVIek1PMEZO?=
 =?utf-8?B?c2dpZFh4VW5pSksxNzIrZkVEMmJlYVR2SDFQN2NhVFFVS0xKekJwQW5WL21k?=
 =?utf-8?B?QnV0cDRWd3Q0ZXp3aFdGL0VVVi9UMWtNUFVqTFZTanhlQ2psZkM2c1VMOFNq?=
 =?utf-8?B?Z1RMS1AybUpWR2VhTlBvVnlVSTBmam84Y0NhVW0zdzZLMDB1Q3cyYmhBdlhM?=
 =?utf-8?B?WjhXYjJJc1hKeS9XRFB1bGFXR1VqRWFXYXJWdDBCYU1PZGNPckI5VzZaaHFO?=
 =?utf-8?B?czVBNVF0Smg4RWFiUVl6ZlpidUM4c04zWEU5anZ5VllqaWUwNUo4NGpyWUE4?=
 =?utf-8?B?b2o3NmIxUStOeXBUL3lMazlMRHZlNDJjVVc1dXViSDhTWFRUMmd1Tjc2QUpK?=
 =?utf-8?B?Q0tNSFIyb09INHMyaWh6b3V1ZzlZb29xdHA3bnE3U244cFNJV0pFcVg0eHBq?=
 =?utf-8?B?c1pDOGVFUlFQaVU5OFd0a3pENUtxVUQ1dHZmNGFGZE56RXhiV2lBY0RMTExK?=
 =?utf-8?B?TVNhd1hQWDFpZ0hvZGdmRlJSeGk2eGxWb2xqQzJjak45Uk9TeGJ3M3JGelUr?=
 =?utf-8?B?Umxjck55V1dzRGVTZFNic3FRcjBqN3dOSjNING9qVm50UUgzNXh6NGJiVzBE?=
 =?utf-8?B?UWQySHdnSG5GVzVBTEFhb1pNd0hxVUNhMjhRVVpGdGJRZWQ1UnRLRUo3MHda?=
 =?utf-8?B?Wi9SRjBGVWFHS2pFK3F4dDFaZzIycTVzNHhMYVp4TUpNWnhIdzJtL2psNmYx?=
 =?utf-8?B?TUxKVTd6bGlMTk9sNUNCNHNyNUMwUHFDVHBycXE0UFRzNTI4WDhUakVOSnNh?=
 =?utf-8?B?bmx6UGlKNFhNTzNoSDU2VEJzUlRoOFIyd2t3c1B0TkVuV3k1UEdqa1RYYVFv?=
 =?utf-8?B?cEYwMVFBOHVnWjRENk5CVWpkUGVTaGxzT3FxQXFHV3JXNFplUDY5bzh5Mng4?=
 =?utf-8?B?aTZvMnU3ZzhlR3lPbVBWTXJyQUNXQlNaTVc0MjRCKzU3ODRqMG9pU2dhTlFM?=
 =?utf-8?B?bE5jV0FDU2lFOVJkSmZxQ3RFbnVhMUtYZ0l3MWZiOUhGUzdxUW9WWG9HVlRF?=
 =?utf-8?Q?GXjCPyx9o24=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2N1VjlrMUd2VWpRTVJ2NGxINjQ5S2NIVkpHOTA3cHBhdzB0ZUkrcHZaMzRq?=
 =?utf-8?B?dVFibXpjbmx0UWdMUEJZVXBVcEJORDA3VE5SeTNHc05Rb1FSSlY1Rmh6WjI1?=
 =?utf-8?B?RlBub0xrSnhuTnhmc1F1WUNrdExIMFg1aDJ5M0pyTHliMUEwNERocDJvZ3h0?=
 =?utf-8?B?WDdxRTFiMGNJWmx2Z2kzVzBBOFQ0MEx5NUZhR2NjNWZxOFZ1T3pJQis2akN4?=
 =?utf-8?B?S1hrUS9pbnRQVG92dVB2VDZNNVhTODF4MGxpV1I0YkRNcXVMZDk0cUJReXdP?=
 =?utf-8?B?Uk1WNUgyQ2FNVmIwN25ITUd5bENKMWRNQkRtUzA0N3pmMWlkOEJKNzFKSm8v?=
 =?utf-8?B?RXd2MFFJYWhIRCt2SFNOblVmOSs0MmVqQW1GcUVsWnJudC9rSk5TTGRzYkUz?=
 =?utf-8?B?bCtjZGJCM0xKbU50SE16cVl5YmNNY05UVnZTSEJGZkZnejExUEJyR1BLSC9a?=
 =?utf-8?B?bDFsN09NbFF3UlRyZ0puWDZqSzd4UmozQkdvZWVRVTdGSXh2dkJPSThFU0Jj?=
 =?utf-8?B?YTVVZ3RHYzFvRzRJRHk1UFZzTHBYeUJWSTkvNUZIQVJHQXJzWkZuZkZ4RzRW?=
 =?utf-8?B?WTRPRkhkS2FFRUVick04Rng3bkJYbTlmRktrWnVTS0hQTUE3VXg2Yzl2b1ly?=
 =?utf-8?B?RmtkRkEvaTIvRk1RZTlpanpDd3A0dXgwZVdRVTFpSXVkaWdGbnVVL3NaREpC?=
 =?utf-8?B?UXExM1dPU0lhM2tPYWRJbTBNNnVIWFp5cHFaR1pIZVJGbXdNSStqYTFwYU4r?=
 =?utf-8?B?cWtvRnZDdzl1eURvVzd4ZUVSS0Fzcmdsa3ZRZHVpYXpVOEE3c0RMRzZsVjNL?=
 =?utf-8?B?RThMNTE5KytrMFFaZVdaemdyWkRFa0IyVXRyQ2l3RDZJYUhlRW5hcy84OFNP?=
 =?utf-8?B?bzVpampmK3NQQW5jWHNaWS9QeXZzeXdnU3QyMHVlWVZwbVozNEs3dzB1aXh0?=
 =?utf-8?B?Y1B5akxMaG5RZUpnZkg4akl3TzljdFZGeWZJdFoyU0xPcWpkMkxENFJaMXRk?=
 =?utf-8?B?eHJ0d2pXamVrMHd2QnBoM1gvQVRnSTVrMElJL3RreFR6NExFTzU1d21Mck5Q?=
 =?utf-8?B?YTZCQ1R3VmdWT3ZWNGRSL09PWEVobnZXNm05NzlINytlNnk4WDFZR3V4V2E0?=
 =?utf-8?B?akNnSy9oQVJYdXBMM2Q4dlQzT2xwSFNRRmZwS1BLeVZUSENVQWdMdkJBWStz?=
 =?utf-8?B?elFJMFNQSEdFL0hVOUNPcFlpcm8zWkdvT01PWS8wRVVZRlk3b2FMQmhSY1lR?=
 =?utf-8?B?NEhOc0JLeUNLQ29sWjZWbldBTVN5WHBWLzdlVVRoRFFlVCtIQ1lTdjUvZUNE?=
 =?utf-8?B?TmM5SWtnSWQ4b2U4SzRCaXJ5UVVyQ24rRmdOMWs4Mkk1UEl1bS94dWc0Tjhl?=
 =?utf-8?B?SkM4WHpEbS8vSzhEODBKVmtxclpINDQ5Ykc0Qk9xblhIeWI5WmFxbytsakJq?=
 =?utf-8?B?YmVWOVRzQlNiWnRFNStkbGVVQzlUYW0yamdqM1Z1YmFRWlk2Y0tKdy84akNw?=
 =?utf-8?B?SnkxdFVCLy8ycEdoeThOQTd5S24wcHFmbDI4V1FHQjBFNHFRU1NYbGprdENy?=
 =?utf-8?B?NnFtTGd6NURiMlFHcWwrVmw0bFg2VWtONXJOZWJwQVVsVngwaCtVcG9tRE92?=
 =?utf-8?B?NjkwaExKc2NwZ2xwUmdEODFaV3RKR3FzdXh4TVdxZk1XTUFPVGxYNzNKWXEr?=
 =?utf-8?B?MEtYZHc1ZEsyNmdlWUp2QXVhOGJuK2ozT29ycFlCRVgxKy9TamxkcDNQM2s3?=
 =?utf-8?B?SEttWjlyQ2ptRWlocWx3WHJOWENHMlhGcTNoRGN1bkRzMnBhOW9pWkZhZWdH?=
 =?utf-8?B?bUdVSDJLdjFWS3FUc2ZLOVcyZnhzRmUzUVpwV3hGZGVqVC83TUpvU0N4S2pq?=
 =?utf-8?B?SjVoeE45YXA5aWtDY3ZqWU1mN3FPODhPMHJFTXNVS29QOGZFTUU2ZXBxTWFN?=
 =?utf-8?B?NzRpS1hEMkRFMG5qQjY5T2FEUy9jQkVqTGhxWjJlVE1JcFhBZGE4Q0grbWNn?=
 =?utf-8?B?TzRLRXp1ZEtzcDFMTVhPMDhHR1NDT294MnlQUWwrazVuNDZMWlNwOGRBZlB0?=
 =?utf-8?B?bmtEeGhnYmtYcFhDcUtpVXE2VFNsREI0OWx5RTM0SC9EbUEvUHRxMjl1aGND?=
 =?utf-8?Q?LRcDeLObrHEUG5z5kvYlC7HPs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70c606d-6054-452b-c390-08dd47636e29
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 10:37:33.6236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EtHj/WJKv7ECsAJFcspVF28Jhcn0CKPEI2w+IwqTn6rGNKaPlY6nR7d+tTndw0h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7951
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



On 2/7/2025 12:14 PM, Jiang Liu wrote:
> Minor code style enhancement for smu.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 08b42c7a4ad1..51e7bd4d3444 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2153,7 +2153,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	struct smu_context *smu = adev->powerplay.pp_handle;
>  
> -	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
> +	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))

This is already taken care in another patch. Rest of the patch is fine.

Thanks,
Lijo

>  		return 0;
>  
>  	if (!smu->pm_enabled)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index da7bd9227afe..da55d66099fb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -3524,8 +3524,8 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
>  	.init_power = smu_v13_0_init_power,
>  	.fini_power = smu_v13_0_fini_power,
>  	.check_fw_status = smu_v13_0_6_check_fw_status,
> -	/* pptable related */
>  	.check_fw_version = smu_v13_0_6_check_fw_version,
> +	/* pptable related */
>  	.set_driver_table_location = smu_v13_0_set_driver_table_location,
>  	.set_tool_table_location = smu_v13_0_set_tool_table_location,
>  	.notify_memory_pool_location = smu_v13_0_notify_memory_pool_location,

