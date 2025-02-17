Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3239C0219E
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 10:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC4110E248;
	Mon, 17 Feb 2025 10:01:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cxYtugiW";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F8D010E248
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 10:01:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULJvfxSTHYBUMV66dbBsCW+dJv2IzIC8WJDNa71U6sYnJEi+9ll/yy/+vear3t0ULizRMEAzFGhL0pOAf/XtqeUYMsBkVC7zeqVfTcUA+egcJWdfmg+dNrO2ze2OFX6sriEn8hEUg1EVEgzUFDo4YZ+Ul18UMyqeanWsB2Jb4KWtSjiiBJ6G7dGcs5JpbmZhmlc3ffF4dWNYooB2jCUONQGuQGrRtPF6j5ZJhSZdIZ8T1DfGwfAYMOkTUQKuk03U6/Y9wxC1pXHhC/v7RnAWA4W1dmYRYR1c07/z3iMGHNSE57CLtf7Pu4VqhwRHytwnBbmYnFVrcVZp3deZbRIA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwkN0gXy//WQ3Qa22jFyieTIzjDE/d5XsZpilFuWbAU=;
 b=ICRUpuZ/EakBQgIxzIpq1/FkIKaV/TyVeQsCLPlmA78H3/jo1Iwi5gXjawFxsVw/bo0oq0vcO0bDNVS8vHz0J1gfFm1VpijLIBBlZB6CdngPdf02FrNDNDx5tG6yfViS7tWiBtJ+1UsjbAgH+SNvMd9tb0fbpwL6ujyhPHkvtEFSXDu+/WQFddvt3a/+k8gJ4yOpYHy8BSPrDElFLw/lq25NbDh2xTUEzvMNqkmKL0jnHGI0OhkikKki9RdMoQvzMjOIbHEorkqRLhwhV0NcYO5Ah3oys+Z3eYu7NeOoIzH5AJJNw/CZMT4sVi+K6Y+mUbnuoTZpPFUQOGbum8yE+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwkN0gXy//WQ3Qa22jFyieTIzjDE/d5XsZpilFuWbAU=;
 b=cxYtugiWMuW04w2x45i0miRHkSrEZF0/stMM0L655y3LHL82WlcPrAxX0VDlJjORSkhralriDvguB4Fn+/dKf2bYsBjBTRiwWg1bhLQu7zL2eYLTnyipEFzu/BsXU9FS+7LKGypyCgLwhGqyMtXT93xSqrZBHEyZ5uoIYQ5zqOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Mon, 17 Feb 2025 10:01:01 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 10:01:01 +0000
Message-ID: <e1396ed7-68bc-48dd-9043-03e86f577b1c@amd.com>
Date: Mon, 17 Feb 2025 15:30:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu/pm/legacy: fix suspend/resume issues
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: "chr[]" <chris@rudorff.com>
References: <20250212161129.2712730-1-alexander.deucher@amd.com>
 <2d8664b0-0765-4538-8021-05e306adcb97@amd.com>
Content-Language: en-US
In-Reply-To: <2d8664b0-0765-4538-8021-05e306adcb97@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::26) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c9487c-0fb2-4d06-678d-08dd4f39fb86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1FNdXdMR1JMTjJOcDRsbExYTDBxeHovOUNVMjI2VjZSMk9ma3l4ZDgxeTRw?=
 =?utf-8?B?eTEyVVhrN1JxckJSQXRoSW1sdTBwM2d6bWpDS0Y0TUx2WS9mNnZQY3hYRXF5?=
 =?utf-8?B?TnlUanh5SXFsVitmOFEzalRGRmVOTHJDSjVCTGpPd0VxTVBBZmRGdGhzMDd5?=
 =?utf-8?B?SFBPYXZYR09NdDcvYi85bkQwdkhIelhqWUFweHpNbVVuUStJbkRpWldWK2t5?=
 =?utf-8?B?VWI5eGExMmgyMDQ1ckdPS1pJTjRZeGMvdFkxYjV6MHNzQVc0eFJVMTJxbGtR?=
 =?utf-8?B?dWVoWGhIaU0rVUV4eDdVeCtRZXRhRXNqUVFENW9XSTFOK1UzVzRQdi9GWEtG?=
 =?utf-8?B?MVNoRUNieFJTbW5pMEpsYWRvcGlQUytqZVdSak9HRkJnQko1QzJqa0VHV1hJ?=
 =?utf-8?B?MjROU2hwM1d3YllhWHVvZ1pLczZwNW5MdEpoZFpHc244K1JDaEpXdTVDMW84?=
 =?utf-8?B?cFlyVXNySTlYcGxWSkdzY3pTd0c1SEoyNUUrM3l2VjNqSFgzRGJ6bFNpQndq?=
 =?utf-8?B?Q3FDOExYSWxuR0daTkdoSm9uNVQ5SmNzazhrVE5aYTBvaWhuSEl2YzBqSEVK?=
 =?utf-8?B?aVVXaDBvS0hiSzBMNkhwN0hEZkVEbGk0enBvUEVHYWs5U2lSQmZ0aWFDcFZp?=
 =?utf-8?B?S1ZKNURNSU1iditBQjBXUDRrZ0ZIRzJVcHZSMEg0bXhYWlYwZ1FzdzRCQnVw?=
 =?utf-8?B?YnhRNjBCRFpVbnh1bHdZWGhHZUM4ZWpHNytLVjhHUGRQby93SXBSU01IbkF1?=
 =?utf-8?B?SUFEQmlrTWZwMHIwR3c1ejY0YnZKUFVPREtENjNOSzhZTzhwYjJHWnNKRkZs?=
 =?utf-8?B?S2Y1a3UwQlhLZFNvelpMYWJPY3ZGVFp4QklvbkordEtNVEQwQ3E1dDV6T3Iy?=
 =?utf-8?B?endWT2xNMFp6QXlNQTNJdzFWSFF2Z3NNREhMd2xuVTJ1aVFlOFRCczZMcE4y?=
 =?utf-8?B?SCtXZytXZWxnNGt6RVk1dlB6WW00N2Q5M1hPc2FKdUpSeFNkSXJ3U1p1ZkNE?=
 =?utf-8?B?UGlmZk9ZWlREZ2ZNRUhndHVvSDBzTm1FVWcrQ3JCV29JZlFCSlIrNnhycnBF?=
 =?utf-8?B?bGpMTVR3UkNnKzNtU21xMGszSitGTDNHaHJwZ2Qzc2NieXorRi9XUmtTYjVj?=
 =?utf-8?B?WENmNHJtNm5oUEZhb2VCTGtEMCsxMmQ2bzRsTWZMNEp4QS9VaTl0bnVveWJn?=
 =?utf-8?B?SHQzZU9GN0xhUGgrSm9GN2ljcFVJb3BVZzhIeFFQbjlLdUw0WldwbGlnWUhR?=
 =?utf-8?B?bEI4ZHQ1TzhlV0tzQWFPV0YvMWR3ZEgxN25YcDUyYk50aWp0eUZIVlh2cjlW?=
 =?utf-8?B?QU8zckdZWXBzVVcvSTdhUHNBZ1FySVlsakpZNzgwcFJnU1pMVUxPVUhyL2dU?=
 =?utf-8?B?NzNhd1AyaDRvUStkNUlIdFp1ek9vY1ltNGRmOWZqcHB4aW5SWkMyTUhtSi9I?=
 =?utf-8?B?elFxR3QrTElnMFk2K1FoaUErZjhGY1I1aHgrQWtxaFZNVHZDcnJKamxEZXBR?=
 =?utf-8?B?aVdQMFlvK2FrU3hLc3A1TUlWWWFRTmVQelhnY2NWcWJzSGtUVUExaGRXUS8w?=
 =?utf-8?B?aXhCajR0bXVnNlBIREtsZ0xlVkx0UC92czFDLzlpVGhHbUx0TmJ1RXF6QjRS?=
 =?utf-8?B?bXliOElycVhobTBsaDVKWU1QZHBXOEFsbHdDR0ttT3RVMmk5VTNGNTJWOXRD?=
 =?utf-8?B?VmpucktOT3JIUnFUanZIQWo3ZEpGWFZUZmVQbXFSTkZCZlgraExMNXh6V3RZ?=
 =?utf-8?B?cWVJcGcvejNhSE9CU1V6UnZMOXc0b1JsZXJtV3d0eDFjNnpTa3VQNTNHdXRz?=
 =?utf-8?B?Ym8zc3E3N0xQaGFiaEx5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzFUWmdjM0NncDFySDc0V3F1b3BaMWpMbGVkNmdnb0VNZ3REZ3hMQ3NBb1lm?=
 =?utf-8?B?YnJBNm44SjY5V2tIaXgvWjVRMFo0eHZZait6cjBELzRoQ2ZwT3dJM284YTQr?=
 =?utf-8?B?Y0RkVFRITFdKWnFtU0gvdEVQemxNVlduUFI3SDJHbGU1WUFIVnJidTZZWHN3?=
 =?utf-8?B?ZUxTQnlvUVplWllJN2RvVTRpZFhkM2Y2ZHRZZ2NVTDE2KzJTZHdtSk9DV2xC?=
 =?utf-8?B?QXBoUTRmYzJlemZGcFZvVGN3VVZFV1F6RlNMY0NMV1RiOWhDK05IN2hMV24w?=
 =?utf-8?B?WjExbVpNd0lZaXVyRDRkZXFTZ0pnbDU3ZG8wUmhaL3ZPTW12blovQWhLc2x0?=
 =?utf-8?B?L2hzS2NxelQrVUVFTENFN1VzZ2hEZHRNdm52bVErVEhEVG40ZDRISUpiNkdP?=
 =?utf-8?B?UE15dE82M3Z0c3VHNVliVGhCZENiSHQ1S1VUcjdpOFBzcGZ6TUViM2M4TGRG?=
 =?utf-8?B?VmVxUVMxUUNEN1BMY0JVMFE4TWNxbTBrQThyWkJjdDJNRld4NzZmdmV1bm9I?=
 =?utf-8?B?R1lvMHN6Q0lRRWh0dFllZk5jUzd0cU43eUNzdWluckd4R3dnM29tbzRqQUNC?=
 =?utf-8?B?dko0T1hlWUdnQ1pYRFE2eEp5UFpKWXB0Z3ZnNksyZWJYUzlvQjRrU0VzTCt2?=
 =?utf-8?B?MjFSWkY1YnI0VG9ORnBWOUY1cXNsT2xWMHUxWFpTM3VZOXo3ZHpEOGQ1YllU?=
 =?utf-8?B?RmZ4aXJMSFBQejl4SzdEK0tDbXM2ODRpMjArVVFEdTBzR1F3UzhqcVZ0OU5M?=
 =?utf-8?B?VmhTQjh0Yk8xcitBME5seVdseEY2RWhVREs0bThVaWRZTWljbmRVcVIzck1J?=
 =?utf-8?B?VEM1UE8xM3luVkFRMzV1M3hucmZFY245RmxNRmpoeXphS3dSY0t3cXpTTk1E?=
 =?utf-8?B?cmVHRUxUVldKd2dOa1BObk1RSWdkV0I1SEM1M1VCL1J6WWpBMkl2KzFNUDAy?=
 =?utf-8?B?S09IREFmRWNTdTZJWm1vdDNEMnpxSDJJMEVnVzZNRFBIdGpneTdsa01BbU5T?=
 =?utf-8?B?REFVK3Via2ZvaEsvYlpwaUNZMXBJUS9SQzZkdVRDemhCRFFpMXpHOXVqTWk2?=
 =?utf-8?B?ZERWUGZQT1VCV090THo3a2YxWkNjcFRmbE94dUVaeVVsUk96Y1JvemlQbjRy?=
 =?utf-8?B?VW9sNk9zbDQxSTk3akk1ajR5NHNoUVA3NmtpQ3RlYWE5a014VTRGTnBRd2x0?=
 =?utf-8?B?R2VkbEJxZFpRWGNBelB3dk5UTzdUWllWSkRrdUMzSXUveHpFMWZWVXZDMnVE?=
 =?utf-8?B?dVd5UXY3YkNQMnlYUmVWcWl5RWR2d0NFUFd3Vlh1NUlhSHdoOUhPdTJ0MkMx?=
 =?utf-8?B?N2xvYUxMQkVaV0k2L2RSaU5KZWdyaFBSZTdVaXpDNmNybFlPdi91ODBvYTZS?=
 =?utf-8?B?bWtJcEpDM3N2eEs5VjYveU1MMXA1Z3hWVE16UGcyVVpkaTdleU82Mzd1SVBw?=
 =?utf-8?B?OUQxTGZRTTd3Sk1LVUk0UE1UeGdraGNOV3MycnQ4RVhuYUtIZjQ3ajRwNGdr?=
 =?utf-8?B?ZFh0WXpsUU1nRGIvTVp5cEw2b1pIU2k0TEZuZk9YWUE4enRMTlJJTnAzdGQr?=
 =?utf-8?B?YUU3MEpMQWplbmsxaEtTQTdyTU1TM2xvQ0ZOTlh1eFVISkloM3FtME01Zi9C?=
 =?utf-8?B?ZjZ4WVNCWG9od2FPbzVNNlgvbWNaek9LVk1aSkhlREtyK1RQNmJQY2p3VHdB?=
 =?utf-8?B?RWhNTnQvYlhvL1VBS3dGaUovc1RjYWg5R05vaG8xVTlvVGVqMHF6dFR3Q0J2?=
 =?utf-8?B?aGRzOXZzSTAxV2wvSEZXOXdtdTU4dEI5VDhWWk85ZlAvbGxTZFJmTGYxdkli?=
 =?utf-8?B?cHhXSHJ0Yk9DVjhOVXQybE9xMjVnV1dNVENsc1ZscTFuZEZSaTZ3cHFBWnFG?=
 =?utf-8?B?T29yS0VtL2thNVJ5SFRkVXJQVzViaVJEMWxjRUh5UWFETGFnVW01MUV3V3dm?=
 =?utf-8?B?VHlvZFlTNTJTdUEzSE43SGFyamJoc3J1ZTZQVGJXYzdaeFcySFpjazJQZ0NL?=
 =?utf-8?B?UzBBcVpybmZ0clEwSUFKbGJBZXVMajRDWnBPZ1BZa1QyaGZEN2p0bEJZeWFi?=
 =?utf-8?B?M1VZbmJDaHpwOGtFWklNbjc4T3EybytUM29lalBZRXNGMGR4TFRMejVDbStU?=
 =?utf-8?Q?sdYkt8e03w4pct5GrLKuCEdXf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c9487c-0fb2-4d06-678d-08dd4f39fb86
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 10:01:01.1219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oD1qewy4QO0xP8OgltIlqsTAMLnYp9wEEEoK0pv0IvSAduwWAGhXDMpOWxgqthN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731
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



On 2/17/2025 3:26 PM, Lazar, Lijo wrote:
> 
> 
> On 2/12/2025 9:41 PM, Alex Deucher wrote:
>> From: "chr[]" <chris@rudorff.com>
>>
>> resume and irq handler happily races in set_power_state()
>>
>> * amdgpu_legacy_dpm_compute_clocks() needs lock
>> * protect irq work handler
>> * fix dpm_enabled usage
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2524
>> Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in amdgpu_dpm.c")
>> Signed-off-by: chr[] <chris@rudorff.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    | 19 ++++++++++++++----
>>  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  2 ++
>>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 20 +++++++++++++++----
>>  3 files changed, 33 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>> index 67a8e22b1126d..db0d3d4dba685 100644
>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>> @@ -3042,6 +3042,7 @@ static int kv_dpm_hw_init(struct amdgpu_ip_block *ip_block)
>>  	if (!amdgpu_dpm)
>>  		return 0;
>>  
>> +	mutex_lock(&adev->pm.mutex);
>>  	kv_dpm_setup_asic(adev);
>>  	ret = kv_dpm_enable(adev);
>>  	if (ret)
>> @@ -3049,6 +3050,8 @@ static int kv_dpm_hw_init(struct amdgpu_ip_block *ip_block)
>>  	else
>>  		adev->pm.dpm_enabled = true;
>>  	amdgpu_legacy_dpm_compute_clocks(adev);
>> +	mutex_unlock(&adev->pm.mutex);
>> +
>>  	return ret;
>>  }
>>  
>> @@ -3067,10 +3070,13 @@ static int kv_dpm_suspend(struct amdgpu_ip_block *ip_block)
>>  	struct amdgpu_device *adev = ip_block->adev;
>>  
>>  	if (adev->pm.dpm_enabled) {
>> +		mutex_lock(&adev->pm.mutex);
>> +		adev->pm.dpm_enabled = false;
>>  		/* disable dpm */
>>  		kv_dpm_disable(adev);
>>  		/* reset the power state */
>>  		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
>> +		mutex_unlock(&adev->pm.mutex);
>>  	}
>>  	return 0;
>>  }
>> @@ -3080,18 +3086,23 @@ static int kv_dpm_resume(struct amdgpu_ip_block *ip_block)
>>  	int ret;
>>  	struct amdgpu_device *adev = ip_block->adev;
>>  
>> -	if (adev->pm.dpm_enabled) {
>> +	if (!amdgpu_dpm)
>> +		return 0;
>> +
>> +	if (!adev->pm.dpm_enabled) {
>> +		mutex_lock(&adev->pm.mutex);
>>  		/* asic init will reset to the boot state */
>>  		kv_dpm_setup_asic(adev);
>>  		ret = kv_dpm_enable(adev);
>>  		if (ret)
>>  			adev->pm.dpm_enabled = false;
> 
> Need braces here as well since else part is with braces.
>> -		else
>> +		else {
>>  			adev->pm.dpm_enabled = true;
>> -		if (adev->pm.dpm_enabled)
>>  			amdgpu_legacy_dpm_compute_clocks(adev);
>> +		}
>> +		mutex_unlock(&adev->pm.mutex);
>>  	}
>> -	return 0;
>> +	return ret;
> 
> Possibility of returning unintialized value.
> 
>>  }
>>  
>>  static bool kv_dpm_is_idle(void *handle)
>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>> index e861355ebd75b..e06c25c945007 100644
>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>> @@ -1012,6 +1012,7 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
>>  	if (!adev->pm.dpm_enabled)
>>  		return;
>>  
>> +	mutex_lock(&adev->pm.mutex);
> 
> I think taking this lock should happen before the dpm_enabled variable
> check. Otherwise, it could happen that part of this sequence might still
> go through after a kv/si_dpm_suspend.

One more comment - probably it's worthwhile to cancel any scheduled
amdgpu_dpm_thermal_work at the beginning of *_dpm_suspend.

Thanks,
Lijo

> 
>>  	if (!pp_funcs->read_sensor(adev->powerplay.pp_handle,
>>  				   AMDGPU_PP_SENSOR_GPU_TEMP,
>>  				   (void *)&temp,
>> @@ -1033,4 +1034,5 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
>>  	adev->pm.dpm.state = dpm_state;
>>  
>>  	amdgpu_legacy_dpm_compute_clocks(adev->powerplay.pp_handle);
>> +	mutex_unlock(&adev->pm.mutex);
>>  }
>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>> index a87dcf0974bc1..c40ec4f74afb0 100644
>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>> @@ -7786,6 +7786,7 @@ static int si_dpm_hw_init(struct amdgpu_ip_block *ip_block)
>>  	if (!amdgpu_dpm)
>>  		return 0;
>>  
>> +	mutex_lock(&adev->pm.mutex);
>>  	si_dpm_setup_asic(adev);
>>  	ret = si_dpm_enable(adev);
>>  	if (ret)
>> @@ -7793,6 +7794,7 @@ static int si_dpm_hw_init(struct amdgpu_ip_block *ip_block)
>>  	else
>>  		adev->pm.dpm_enabled = true;
>>  	amdgpu_legacy_dpm_compute_clocks(adev);
>> +	mutex_unlock(&adev->pm.mutex);
>>  	return ret;
>>  }
>>  
>> @@ -7811,11 +7813,15 @@ static int si_dpm_suspend(struct amdgpu_ip_block *ip_block)
>>  	struct amdgpu_device *adev = ip_block->adev;
>>  
>>  	if (adev->pm.dpm_enabled) {
>> +		mutex_lock(&adev->pm.mutex);
>> +		adev->pm.dpm_enabled = false;
>>  		/* disable dpm */
>>  		si_dpm_disable(adev);
>>  		/* reset the power state */
>>  		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
>> +		mutex_unlock(&adev->pm.mutex);
>>  	}
>> +
>>  	return 0;
>>  }
>>  
>> @@ -7824,18 +7830,24 @@ static int si_dpm_resume(struct amdgpu_ip_block *ip_block)
>>  	int ret;
>>  	struct amdgpu_device *adev = ip_block->adev;
>>  
>> -	if (adev->pm.dpm_enabled) {
>> +	if (!amdgpu_dpm)
>> +		return 0;
>> +
>> +	if (!adev->pm.dpm_enabled) {
>>  		/* asic init will reset to the boot state */
>> +		mutex_lock(&adev->pm.mutex);
>>  		si_dpm_setup_asic(adev);
>>  		ret = si_dpm_enable(adev);
>>  		if (ret)
>>  			adev->pm.dpm_enabled = false;
> 
> Same 'braces' comment.
> 
>> -		else
>> +		else {
>>  			adev->pm.dpm_enabled = true;
>> -		if (adev->pm.dpm_enabled)
>>  			amdgpu_legacy_dpm_compute_clocks(adev);
>> +		}
>> +		mutex_unlock(&adev->pm.mutex);
>>  	}
>> -	return 0;
>> +
>> +	return ret;
> 
> Possibility of returning unintialized value.
> 
> Thanks,
> Lijo
> 
>>  }
>>  
>>  static bool si_dpm_is_idle(void *handle)
> 

