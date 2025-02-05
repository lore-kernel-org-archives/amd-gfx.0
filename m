Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BACBC02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 15:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D84110E7E0;
	Wed,  5 Feb 2025 15:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jTPMztjs";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D7A10E7DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 15:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hX6O27gih+M+SmLGUrvVCEDiAFPdQ5pVYsoqAsnP6xgJs6xFeFcZR+Nc8leRJ27oZOv1JqSnzPC5/0yYvom1TtwW6XqXu73vYrpnfzHph0TLbIkE4mzJQnWpwBA35RJJJdbd1DgSL3ddbEZM4tk3Yh2aP/RFns+1cEsmSQYbzErfBCAKMihPh34ZyOGvlS2PXGQzmHQJdyo8CU6i1jgphpGbWHUemjoybfjvCG33Z8wQWbgQfo30yUJfdQLoAV78VGOltajfd4v6MgE/q/+fzK1ezfrzT9kXtoGsmPCA/PGW4plcOJ+WLC+F4UAZdpqwkfofxYSi98beweQxpfxyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64g4Z1TuOlWcY+5CcFSdGPxp97grifpPDVhqyDqbOV4=;
 b=WT5DeGcCQYCtBj9aEf0JPq6FWEzuLJN5xEvh+vU73poZkdL4tqPLtIFeVX1Mp8GTnE040MHyRwKrHaiFfwhHgkUzFAIq1wZsK/Zghx4pPqrxVccYy7LrqzqgLAhfIW3+IGFXMNnRF5WtErxCwVR45jaK4D2jAT285ihQ094c92SM/YVteuhraCEWzf2nhkSkSVoFIHyiQuUin+XzZS6LtquDsCDEwpMqAAhluGHXdN3aNdj8Td6HMRavqpf3u5dnkj2o/Opvr5nKO3MTy92FDGh0811qYZHl1tkDBOpC6wi+x2riH9kJNfP0zAGGvT2Jqcssh4AWRonKYfS+OiEf+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64g4Z1TuOlWcY+5CcFSdGPxp97grifpPDVhqyDqbOV4=;
 b=jTPMztjsu6fuGnzL9A31XMD5MNtLq/AN4V4e3qxOkg9dbloJ4+lV3AVUrCGkHpjISUpbrSbO8xxijc7RL6ynhH6UBS0x6PVoSwJzQQp+tW5GpofVhX2nWwooctvB8bsKi3GwxOHeaDSTiMDdBZ2/P9wRxzEDBBVDQnHeVKedDds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 15:05:06 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 15:05:06 +0000
Content-Type: multipart/alternative;
 boundary="------------j0yF8n0XbyblKuiEC89pYUPL"
Message-ID: <aed1bcfa-6a50-43c4-8172-c806e5c333d7@amd.com>
Date: Wed, 5 Feb 2025 10:05:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/44] drm/amdgpu/vcn5.0.0: convert internal functions to
 use vcn_inst
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-20-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-20-alexander.deucher@amd.com>
X-ClientProxiedBy: YQXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::16) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 333612b2-6b8a-48c7-eca9-08dd45f679b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjJqNS96aFgrSEc3NmU3QWppNWpuUDdQM1dTRW5ialdWRlpKdnJzY1o4L0JM?=
 =?utf-8?B?bERsU2JBNE9UQm95SG1reUt4MjQ5MjdBelJCYlJqbkdKTW54TEt3MThnY2ZC?=
 =?utf-8?B?NlMxRDd0Tzc3NlEyTWFSOHZ5WGMxVzVUd0V2a2ZYbmNzdTFhdktXcjluMENC?=
 =?utf-8?B?UXVNUFZva2hJK0d3dWFUOEk2YkRhMVBsQm5ieDBQL2RKR0JwT1Z3L3lsUElO?=
 =?utf-8?B?aEg2cE9BZWxSVUplV3o2Vk1NVGNqWDVwbEhkRTdDcHo4SWN6RTV2QXpXcURS?=
 =?utf-8?B?N3c4V242RlUwU2RuRlN4bXU0YTVmYXNmNzZ2WnQ4ckVJY3FnWFRzRXZqcjM1?=
 =?utf-8?B?Yk4yTDJMK0xxRUIyYXE4VGo5SndzNk04T1cxZEFrYmtlYThQeGk0d0tvdnA1?=
 =?utf-8?B?Ti9HaG9TS0NFb0tqSXBld2JUOWFSd3JSWWdSSVRYd3NjQ0MwM1dKUW1CVjR0?=
 =?utf-8?B?RlVZOWpBYndPSmFKNm1HOWJxVFBWWWFTczhhaTZ3YTAwcVJtT0gydHZYT2gx?=
 =?utf-8?B?RXFPZ0I1eHdyZFAvRzc1Sy9VNnpKdmlhU3EyU3N5bkN5ZDdWM1c3STFrWWl0?=
 =?utf-8?B?T1liQXFZTTB4RjRZcndaRjluQVorOFZOMDQ0dUM5amljaUdlam4waTUzVGtU?=
 =?utf-8?B?WXRQZWdZT1VJSytsby9yVjVSYjRWSDdHaEQ1SXJDRHEzTHUwY1JpNWs3MWhN?=
 =?utf-8?B?MmxKeWhBbmJIY0hNblpnaGRxY0JtQjlrMndMSU5OZUJwbXl5ZXdGQVJCTzJG?=
 =?utf-8?B?REp5Q2hTaUIydHROS09saXFHUE1hVDdKWjdRWkI1bUhWYUJHWU94bWQrQXJF?=
 =?utf-8?B?YmQ2ZHJ0QUY2c1NMME1iV1JySnhDRS9yVnM4RlVPTGpPRS9OdGxpRC9oSGRU?=
 =?utf-8?B?ai8zZUlWZGFtMDhNNC9MSjRiZDk2N2FpL3ZzU3dsVmhFZmpJMVdxeHd2ZkR6?=
 =?utf-8?B?NzZ6cWRZVzFUamt1V293NVJxUitJZExyelBQUlY3TUlBVEhnSk9DODJNYjVB?=
 =?utf-8?B?TEZVQld6OTllWnZtNXpGWktSSmdRTE9RZFNrVmoxQUdqWjRhcUNLMjdvN21w?=
 =?utf-8?B?MWdiVjF3ai9MVzRsOUEyaGVIVnRYNXRNYmNIZXE2cmlkQWZIMjBLaHptUDFk?=
 =?utf-8?B?K1k2UmtCY3VNSUFocTRhWCtHS28wck5uYkora1dVb0Y3amVmNnUxNytCdWZQ?=
 =?utf-8?B?d0l3K1l2ckRVQVBsaGZ0YXlHc1NVZC9GalowSlVQaEV6cFlFMmRPQmtnbU9L?=
 =?utf-8?B?cUk4bitpb2UxU2xwTGdnVElKajFqc3kwUkliWkhuTjlpNVFOb0czRHRMQlR0?=
 =?utf-8?B?eEZvU200cjRBZ3FVditxejQzUThTSnpOcTRNa3lxRkJjWkg5T1FRblR0d0tx?=
 =?utf-8?B?WlpoV2hQUUxidjFKTnJyUHVMd2MzU0F0Rmg3cmp3MEU2SXJpQlV2alcxa1Bx?=
 =?utf-8?B?WkRkM3QxRHBPbFRTMFRteXBac0QwOTJKZVU5OVZwLy9sTSsvR0w4NTNCRCsr?=
 =?utf-8?B?cTdTYXFEWFlRRHVvNDFObUNaSGQ4Z2toYTRQekRTZXZVemZwRFprbGVrUkZ5?=
 =?utf-8?B?VEd0SWJuRFQ5ZGFscUtBNzVBa1YvUHJUODhLZEFPcXBzK1B6QUpRU0szZkNl?=
 =?utf-8?B?QzZRcnY0Z0x0aFZPUHdISXMvWmN3TnpkdnFwRm9pSTFuM21BR1IyWHZUYXA0?=
 =?utf-8?B?aE1qSEJud1JVSzJ1SHc4blh4dmttc09wM00yRHo4aWg1T3RzOXNYSzFtWUlM?=
 =?utf-8?B?R0dBUjY2dGFQSFNMK3dNSmJYbjNiMElWOFd6S1FQVUhrRGtERWtTd2JSSENO?=
 =?utf-8?B?N3FRNkx0L2x3bUZSa2R1blBVWHVwbWFyWGwxRzhJUkVYQzhFMlZ5U2swS0dy?=
 =?utf-8?Q?6iG55rGJ52Sih?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXJUZzJWdkF0U3dmYnJ4YS84TDBwd2c3VkFIc2Q4QjVheEVXV1BEeWx1SnBN?=
 =?utf-8?B?SUdaWnMrMEswRFZFVjcyOS9wZlpLYTFudVcrLzFlK3hqZEhyMHJVajh3ZldY?=
 =?utf-8?B?RHlLSGtzcmxtd3E1VGYxZkwrNklEQXhVNHJJUmRLYWpOVVNEZjI5RmhjdGw0?=
 =?utf-8?B?R0lyMFNONzVRYThwUkt0WUtseWRSTFBSenZwM2taU3I3WjN1MXpsMjFHdlho?=
 =?utf-8?B?REt4SmdUcGNRbWo2VU5EWWp6czcvMVNkM0VMTkxWbmJEdzlZOUI3Vm5iKzNX?=
 =?utf-8?B?aVNMQndPSVc4SXVlMy9jNHN4KzY3Mll3SkVmcmdLZVlZKzZHUnpqWW13WHph?=
 =?utf-8?B?OHc2a3cwMVM2UkFXZVlYazY5c1Y1TmQraGNBZmZ1dXNzTGxnajVzcVZtQjRV?=
 =?utf-8?B?V2EyMlA4elVLckhYbVlZeHJUbXdldkpvQ0ZaNkVtc1F1VCs1eTBtcVJ5eExv?=
 =?utf-8?B?Q1A4RlU2bkxZQ0ZXN1c1TzNBSzVZRUFsUDdoWnMxS1ptNk11bVFQUDEwUTh2?=
 =?utf-8?B?Y0k3V2lucTdjU1hYcUVLVS9iNEx0aUQyVWE5SGU1ZlFuZEhOcUVqcFlncTJL?=
 =?utf-8?B?bjJ0a0JZdU1DZW1mWnlzNXZIVDgraThMbVkrTE1BTGpEU0lqS1Y4K1NENVd0?=
 =?utf-8?B?WDNjMENoU1RFckx2MEFZUFQ3M1EyS3hnT1NTTnpZandRalYwYlh2bGpIZi9J?=
 =?utf-8?B?K2hDQVpIb21HZFkwK3N5YW5ybFVid2dIV1ZpWjhZcmhoc0dhTXFuK0YxWE1I?=
 =?utf-8?B?bFVqZTUweFRQbkdrK01kaTdwOWZyOUlZaWJKeE9GbXliN3NuMWtHL0FBS25a?=
 =?utf-8?B?U2NKbStZYzdTR0wzOWhMY1Z5QTkzbVNVZm5WSnhPMFh1eGc4SEk2WURsTnd2?=
 =?utf-8?B?WlBaL01IUzFVVVVwS1JQMkcxWkU3REQ1MU1LenRneE5WTXVKblFxRitRK1BH?=
 =?utf-8?B?c2xxY1EyV3ZXNS9GbzV3ZEpObmw2ZTVONVJNNXBkbnFva3FVN2FIZkNBU25E?=
 =?utf-8?B?TU9QOWgzbFZaVmRyOVRJZzZmWXl0YzlmQXVnUkJaZzdVOWlXcmJvSk1FWWF3?=
 =?utf-8?B?VmxMQ1pRUUZXSmZrSld3YTRsNGdzRFdCWC91ZDVqSEhXaEZHdGVEMEpZSnBB?=
 =?utf-8?B?RzdDY1k0KzhjKzJLSTI0N2ZHako5b1BCeTMyL2lQNkpnZW1YN3VpOHY0R0sw?=
 =?utf-8?B?cExaVCtNRGwvN3FTY2FhNjdjVE5WYUdwRitoZHNyTy9pQkFnZ1I3WmcrYUpy?=
 =?utf-8?B?OE4vczdKMUNCUkVBZU1Ka3BzNUdYNHVyMXREWk1tSmRRZlFPQUdtTmpKcmhL?=
 =?utf-8?B?dnNRVWRzbG1mZElhQWhPdk1BUjVUd0dSQkhCM0MxRTFJS2JFRGdGRXJXMEtE?=
 =?utf-8?B?Um5GOGVYd1QveTVxeEladStGVU9JZTQ0VC9ieEo3dWNzbU01c2dVTTRWaVR0?=
 =?utf-8?B?MU8vMytrQWxpcXJFZFBCMHMxL2wyNDNPNUYvV05WTEdXWllTRzM1YmhZNCs4?=
 =?utf-8?B?Zzd5UlNQNmR3K3BiVTJmYlM1WmI3TlNlWHloZHR2cWgwczF5VkRkZi9iY3hO?=
 =?utf-8?B?ZzlNVVVCWVdDQnVveVVYcEJidU1EaGVwc0o0QXJ3NEp5TS9SQVhKaVZuTnRQ?=
 =?utf-8?B?U0tRakFGRVVnS3QzN0RCRmRmTG45a05DMU9xLzFWTmZMRERoU0lxek1EUS90?=
 =?utf-8?B?djREQitFSVg0SVhLQ25HOEJ0TkFsVndXWERNbWx5Mit0dk9sU0xYSmE1elFs?=
 =?utf-8?B?WjBkYVp6NDljbXJLK2E2dFJlUW0yOUxSaWJpeHU1L1ZRTkNKOGZvUVZCSWlS?=
 =?utf-8?B?Snk0VjU3bGJkSHdDZll6V2lrYnhiMHIrV0lTazE3ZzFVZkNFQS9WU3FYTUVk?=
 =?utf-8?B?UnQyK1pyZ3hMSzZmQjdnRnEzZ1NHMGdOeXBZNG5FdWpGeXRLdHlvQWVJSTRx?=
 =?utf-8?B?YkRVSlFtWVlFeEtKVG9OazJlSS9hYklPMEVyQVpKdTVIb1BPSVBWYk8yWTk1?=
 =?utf-8?B?cGlnV3AvQTFvaXIvWE9MSzBvUHJjNjNPOUhLVGZPRjR0dC9DaXkzaTVaWlBu?=
 =?utf-8?B?bFpYQkp3VjZIMnp5NzZSQkpFQWNYdk1hTmNkdTZ4WnZjd2FNSldZeld0amc0?=
 =?utf-8?Q?qGe6j+7oALvSchf45/WBVSQmb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333612b2-6b8a-48c7-eca9-08dd45f679b5
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:05:06.4397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8IoVNhoNbvw9oHmd/oKECzG6V+sq8eiEB1eGnoYUd3T4PC8UxvyXTAt83jHgd05/cAKKjt9D08n9nbRj3srig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

--------------j0yF8n0XbyblKuiEC89pYUPL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Pass the vcn instance structure to these functions rather
> than adev and the instance number.
>
> TODO: clean up the function internals to use the vinst state
> directly rather than accessing it indirectly via adev->vcn.inst[].
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 99 ++++++++++++++-----------
>   1 file changed, 55 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index d3e4d02c12a06..a71960d899e38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -367,13 +367,14 @@ static int vcn_v5_0_0_resume(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v5_0_0_mc_resume - memory controller programming
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Let the VCN memory controller know it's offsets
>    */
> -static void vcn_v5_0_0_mc_resume(struct amdgpu_device *adev, int inst)
> +static void vcn_v5_0_0_mc_resume(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t offset, size;
>   	const struct common_firmware_header *hdr;
>   
> @@ -427,14 +428,16 @@ static void vcn_v5_0_0_mc_resume(struct amdgpu_device *adev, int inst)
>   /**
>    * vcn_v5_0_0_mc_resume_dpg_mode - memory controller programming for dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    * @indirect: indirectly write sram
>    *
>    * Let the VCN memory controller know it's offsets with dpg mode
>    */
> -static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> +static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +					  bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t offset, size;
>   	const struct common_firmware_header *hdr;
>   
> @@ -537,13 +540,14 @@ static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
>   /**
>    * vcn_v5_0_0_disable_static_power_gating - disable VCN static power gating
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Disable static power gating for VCN block
>    */
> -static void vcn_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v5_0_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t data = 0;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
> @@ -604,13 +608,14 @@ static void vcn_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev, i
>   /**
>    * vcn_v5_0_0_enable_static_power_gating - enable VCN static power gating
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Enable static power gating for VCN block
>    */
> -static void vcn_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v5_0_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t data;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
> @@ -650,12 +655,11 @@ static void vcn_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev, in
>   /**
>    * vcn_v5_0_0_disable_clock_gating - disable VCN clock gating
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Disable clock gating for VCN block
>    */
> -static void vcn_v5_0_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v5_0_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
>   	return;
>   }
> @@ -664,15 +668,15 @@ static void vcn_v5_0_0_disable_clock_gating(struct amdgpu_device *adev, int inst
>   /**
>    * vcn_v5_0_0_disable_clock_gating_dpg_mode - disable VCN clock gating dpg mode
>    *
> - * @adev: amdgpu_device pointer
> + * @vinst: VCN instance
>    * @sram_sel: sram select
> - * @inst_idx: instance number index
>    * @indirect: indirectly write sram
>    *
>    * Disable clock gating for VCN block with dpg mode
>    */
> -static void vcn_v5_0_0_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel,
> -	int inst_idx, uint8_t indirect)
> +static void vcn_v5_0_0_disable_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +						     uint8_t sram_sel,
> +						     uint8_t indirect)
>   {
>   	return;
>   }
> @@ -681,12 +685,11 @@ static void vcn_v5_0_0_disable_clock_gating_dpg_mode(struct amdgpu_device *adev,
>   /**
>    * vcn_v5_0_0_enable_clock_gating - enable VCN clock gating
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Enable clock gating for VCN block
>    */
> -static void vcn_v5_0_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v5_0_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
>   	return;
>   }
> @@ -694,14 +697,16 @@ static void vcn_v5_0_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
>   /**
>    * vcn_v5_0_0_start_dpg_mode - VCN start with dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    * @indirect: indirectly write sram
>    *
>    * Start VCN block with dpg mode
>    */
> -static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> +static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				     bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	volatile struct amdgpu_vcn5_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
>   	struct amdgpu_ring *ring;
>   	uint32_t tmp;
> @@ -741,7 +746,7 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>   	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
>   		VCN, inst_idx, regUVD_LMI_CTRL), tmp, 0, indirect);
>   
> -	vcn_v5_0_0_mc_resume_dpg_mode(adev, inst_idx, indirect);
> +	vcn_v5_0_0_mc_resume_dpg_mode(vinst, indirect);
>   
>   	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
>   	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
> @@ -793,13 +798,14 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>   /**
>    * vcn_v5_0_0_start - VCN start
>    *
> - * @adev: amdgpu_device pointer
> - * @i: instance to start
> + * @vinst: VCN instance
>    *
>    * Start VCN block
>    */
> -static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
> +static int vcn_v5_0_0_start(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t tmp;
> @@ -814,10 +820,10 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
>   	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v5_0_0_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
> +		return vcn_v5_0_0_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
>   
>   	/* disable VCN power gating */
> -	vcn_v5_0_0_disable_static_power_gating(adev, i);
> +	vcn_v5_0_0_disable_static_power_gating(vinst);
>   
>   	/* set VCN status busy */
>   	tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> @@ -848,7 +854,7 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
>   		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
>   		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
>   
> -	vcn_v5_0_0_mc_resume(adev, i);
> +	vcn_v5_0_0_mc_resume(vinst);
>   
>   	/* VCN global tiling registers */
>   	WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
> @@ -944,13 +950,14 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
>   /**
>    * vcn_v5_0_0_stop_dpg_mode - VCN stop with dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    *
>    * Stop VCN block with dpg mode
>    */
> -static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
> +static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
>   	uint32_t tmp;
>   
> @@ -974,13 +981,14 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>   /**
>    * vcn_v5_0_0_stop - VCN stop
>    *
> - * @adev: amdgpu_device pointer
> - * @i: instance to stop
> + * @vinst: VCN instance
>    *
>    * Stop VCN block
>    */
> -static int vcn_v5_0_0_stop(struct amdgpu_device *adev, int i)
> +static int vcn_v5_0_0_stop(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
>   	uint32_t tmp;
>   	int r = 0;
> @@ -992,7 +1000,7 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev, int i)
>   	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		vcn_v5_0_0_stop_dpg_mode(adev, i);
> +		vcn_v5_0_0_stop_dpg_mode(vinst);
>   		return 0;
>   	}
>   
> @@ -1045,7 +1053,7 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev, int i)
>   	WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
>   
>   	/* enable VCN power gating */
> -	vcn_v5_0_0_enable_static_power_gating(adev, i);
> +	vcn_v5_0_0_enable_static_power_gating(vinst);
>   
>   	if (adev->pm.dpm_enabled)
>   		amdgpu_dpm_enable_vcn(adev, false, i);
> @@ -1271,15 +1279,17 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	int i;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
> +
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
>   		if (enable) {
>   			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
>   				return -EBUSY;
> -			vcn_v5_0_0_enable_clock_gating(adev, i);
> +			vcn_v5_0_0_enable_clock_gating(vinst);
>   		} else {
> -			vcn_v5_0_0_disable_clock_gating(adev, i);
> +			vcn_v5_0_0_disable_clock_gating(vinst);
>   		}
>   	}
>   
> @@ -1291,15 +1301,16 @@ static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
>   						 int i)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>   	int ret = 0;
>   
>   	if (state == adev->vcn.inst[i].cur_state)
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v5_0_0_stop(adev, i);
> +		ret = vcn_v5_0_0_stop(vinst);
>   	else
> -		ret = vcn_v5_0_0_start(adev, i);
> +		ret = vcn_v5_0_0_start(vinst);
>   
>   	if (!ret)
>   		adev->vcn.inst[i].cur_state = state;
--------------j0yF8n0XbyblKuiEC89pYUPL
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-20-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Pass the vcn instance structure to these functions rather
than adev and the instance number.

TODO: clean up the function internals to use the vinst state
directly rather than accessing it indirectly via adev-&gt;vcn.inst[].

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="markpsh7afcgm" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-20-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 99 ++++++++++++++-----------
 1 file changed, 55 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index d3e4d02c12a06..a71960d899e38 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -367,13 +367,14 @@ static int vcn_v5_0_0_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v5_0_0_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v5_0_0_mc_resume(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_0_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
@@ -427,14 +428,16 @@ static void vcn_v5_0_0_mc_resume(struct amdgpu_device *adev, int inst)
 /**
  * vcn_v5_0_0_mc_resume_dpg_mode - memory controller programming for dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Let the VCN memory controller know it's offsets with dpg mode
  */
-static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					  bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
@@ -537,13 +540,14 @@ static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 /**
  * vcn_v5_0_0_disable_static_power_gating - disable VCN static power gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Disable static power gating for VCN block
  */
-static void vcn_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t data = 0;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN) {
@@ -604,13 +608,14 @@ static void vcn_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev, i
 /**
  * vcn_v5_0_0_enable_static_power_gating - enable VCN static power gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Enable static power gating for VCN block
  */
-static void vcn_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t data;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN) {
@@ -650,12 +655,11 @@ static void vcn_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev, in
 /**
  * vcn_v5_0_0_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v5_0_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
 	return;
 }
@@ -664,15 +668,15 @@ static void vcn_v5_0_0_disable_clock_gating(struct amdgpu_device *adev, int inst
 /**
  * vcn_v5_0_0_disable_clock_gating_dpg_mode - disable VCN clock gating dpg mode
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  * @sram_sel: sram select
- * @inst_idx: instance number index
  * @indirect: indirectly write sram
  *
  * Disable clock gating for VCN block with dpg mode
  */
-static void vcn_v5_0_0_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel,
-	int inst_idx, uint8_t indirect)
+static void vcn_v5_0_0_disable_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+						     uint8_t sram_sel,
+						     uint8_t indirect)
 {
 	return;
 }
@@ -681,12 +685,11 @@ static void vcn_v5_0_0_disable_clock_gating_dpg_mode(struct amdgpu_device *adev,
 /**
  * vcn_v5_0_0_enable_clock_gating - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v5_0_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
 	return;
 }
@@ -694,14 +697,16 @@ static void vcn_v5_0_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
 /**
  * vcn_v5_0_0_start_dpg_mode - VCN start with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Start VCN block with dpg mode
  */
-static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	volatile struct amdgpu_vcn5_fw_shared *fw_shared = adev-&gt;vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
@@ -741,7 +746,7 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
 		VCN, inst_idx, regUVD_LMI_CTRL), tmp, 0, indirect);
 
-	vcn_v5_0_0_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v5_0_0_mc_resume_dpg_mode(vinst, indirect);
 
 	tmp = (0xFF &lt;&lt; UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
@@ -793,13 +798,14 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 /**
  * vcn_v5_0_0_start - VCN start
  *
- * @adev: amdgpu_device pointer
- * @i: instance to start
+ * @vinst: VCN instance
  *
  * Start VCN block
  */
-static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
+static int vcn_v5_0_0_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
@@ -814,10 +820,10 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
 	fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v5_0_0_start_dpg_mode(adev, i, adev-&gt;vcn.inst[i].indirect_sram);
+		return vcn_v5_0_0_start_dpg_mode(vinst, adev-&gt;vcn.inst[i].indirect_sram);
 
 	/* disable VCN power gating */
-	vcn_v5_0_0_disable_static_power_gating(adev, i);
+	vcn_v5_0_0_disable_static_power_gating(vinst);
 
 	/* set VCN status busy */
 	tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
@@ -848,7 +854,7 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
 		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
 		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
 
-	vcn_v5_0_0_mc_resume(adev, i);
+	vcn_v5_0_0_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
@@ -944,13 +950,14 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
 /**
  * vcn_v5_0_0_stop_dpg_mode - VCN stop with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  *
  * Stop VCN block with dpg mode
  */
-static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
@@ -974,13 +981,14 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 /**
  * vcn_v5_0_0_stop - VCN stop
  *
- * @adev: amdgpu_device pointer
- * @i: instance to stop
+ * @vinst: VCN instance
  *
  * Stop VCN block
  */
-static int vcn_v5_0_0_stop(struct amdgpu_device *adev, int i)
+static int vcn_v5_0_0_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 	uint32_t tmp;
 	int r = 0;
@@ -992,7 +1000,7 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev, int i)
 	fw_shared-&gt;sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-		vcn_v5_0_0_stop_dpg_mode(adev, i);
+		vcn_v5_0_0_stop_dpg_mode(vinst);
 		return 0;
 	}
 
@@ -1045,7 +1053,7 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
 
 	/* enable VCN power gating */
-	vcn_v5_0_0_enable_static_power_gating(adev, i);
+	vcn_v5_0_0_enable_static_power_gating(vinst);
 
 	if (adev-&gt;pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
@@ -1271,15 +1279,17 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	int i;
 
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &amp;adev-&gt;vcn.inst[i];
+
 		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
 			continue;
 
 		if (enable) {
 			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
 				return -EBUSY;
-			vcn_v5_0_0_enable_clock_gating(adev, i);
+			vcn_v5_0_0_enable_clock_gating(vinst);
 		} else {
-			vcn_v5_0_0_disable_clock_gating(adev, i);
+			vcn_v5_0_0_disable_clock_gating(vinst);
 		}
 	}
 
@@ -1291,15 +1301,16 @@ static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 						 int i)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	struct amdgpu_vcn_inst *vinst = &amp;adev-&gt;vcn.inst[i];
 	int ret = 0;
 
 	if (state == adev-&gt;vcn.inst[i].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v5_0_0_stop(adev, i);
+		ret = vcn_v5_0_0_stop(vinst);
 	else
-		ret = vcn_v5_0_0_start(adev, i);
+		ret = vcn_v5_0_0_start(vinst);
 
 	if (!ret)
 		adev-&gt;vcn.inst[i].cur_state = state;
</pre>
    </blockquote>
  </body>
</html>

--------------j0yF8n0XbyblKuiEC89pYUPL--
