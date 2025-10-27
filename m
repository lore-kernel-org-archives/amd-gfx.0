Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CB9CCF9EB
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 16:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE6E110E15F;
	Mon, 27 Oct 2025 16:24:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B4r0k59b";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E87A10E15F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 16:24:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3JYSNY90AmMI7XVocR039O6ibRhyifqJqnbQNab+6SBundp0OzCE4jpdyy7eDPROglVbZEIQT0qOXrod3SfjScTuAkMU+ic1RvspB/i3849WTXRzYbHQXbWSE6fKT6gz7ZXvCCkoCCvf+bi1rnIMAgJWYU/2NxTHZRK6DMKVoiQ4R4uPreVn5/YolI9j/QFwi6hubUTyM+B8cPuxYfgN719jCrq/xu2mbb8NqoZsQGSbhhsShNzTKtZwx2ZHHiQfCcu9HvUHM5ZYnDQsMYqST04kLIpww+VqbAvzrVxYXPLENXIpM0folDg9JhL4JxrWN42pCwwqHXVbVhVYx1R9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzFhV8iCfV8B+bsoxuXYDzJXw46GC/LdbXzYUeGXUXQ=;
 b=TRDDWQ4jICwJCKYKuONKYDWBvPWmTyr2sczOLPVq96KBvjirg0WRXIt2zYoHC3mhj9z97wDNnzji2j9dHF/OlwGRaKLJvFXtHEssBzc4qthaPJ9SWQn9mPlWTVZi4ak7ZQJWgLT7tiFVtrqwMcMXjkRZBLiPQZER6fQfgNPAV0stko0rXmCdB8vbLO3xDPPN7lxXIDTM4ePdMT1yr2gpSvPMD58wDp/zH08L5/7mwF6rnkYGLZ/0CH2KFBA3plg+wtLWHNH0MfYUxJkIZ3A0m1eFMAclkYs5asCDvPetIZZ42iLKcRCn93qKOmhBvjONh4AjHNMel1PPWR0obTBqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzFhV8iCfV8B+bsoxuXYDzJXw46GC/LdbXzYUeGXUXQ=;
 b=B4r0k59bwtMSzlbBp8n/yDjigG5lxAwgK43ydn2adjDU+LAc5j14McEl1W4pv5Izs25Ft5vrLRB4GAb/vZjRuDVIflPjASCEX4J3+msF1WMJAafYgoEGo6vpGtZF1+P2T6IePxrEX7oGLPuTNIXGworY6VjGd1wMDyCNcrMmAwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 16:24:14 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 16:24:13 +0000
Message-ID: <10d6a962-01e0-46bc-a46c-da626f8a2708@amd.com>
Date: Mon, 27 Oct 2025 21:54:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Update invalidate and flush hdp function
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, KevinYang.Wang@amd.com
References: <20251027162113.3284600-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251027162113.3284600-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0245.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0238f8-0424-4b7a-15a3-08de15754416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVgxYTBUUk1SSndIWFU1SWJSd1hEcXFhNXN0ZjZKYnU3RzNkek9CbkJkR2g5?=
 =?utf-8?B?SXBjSjV3UDBGZmsvVlFTSEtObEtsT1pwZmN6bUhwc0g4OGc3VXlnWkFKYVNm?=
 =?utf-8?B?RGNDM0JRdzhjT08vY081RUtxUWw1SGN6d1NSalN1Ym9BRVpwczVmSFZZRnVs?=
 =?utf-8?B?ZE8vN05VZUN5RFdFSFJJd0lTTXFwTmdJQnVDaEZZQlBIeVA3dEhmMkRmaUEx?=
 =?utf-8?B?am85SFc3OTZmL2lsSTFEekUvRHFLSk9yL0M3NjcxYXFKNi9nZ2VSa2FDdisz?=
 =?utf-8?B?QllTWmJ2ZVFDSDNCSDg0REhxR0E1dGRtVnRxczUyd2dLYmhqK0lqUDA4NE03?=
 =?utf-8?B?K3pSNWRNci9xSlltWlNQbmFMMjdnaHlFZnowVVNTQmxWVzFZdmxrOEEyN0FK?=
 =?utf-8?B?UnFPaEx2VXJ2TThmZzV5VEdpdjgxbGFQTU83WFlma2hxbktvM2VSTzFpaVRM?=
 =?utf-8?B?SkJCSlh6OW5NVlVNLzQrVk9zbW1DZkdrSGM4UjIvUGp6bzB6WnFvb3lzNnBx?=
 =?utf-8?B?b0tjYS9hT0ZzSkVIa2tmRGIvQzlyeGFuRU5GZVdIZ1BjeXJ0dHRoSDdsS3pP?=
 =?utf-8?B?ZWgra0VKWXJ3U1NyVDAwbXcyNkZib3NpNERXaU9JLzV6a2JTYURLWkhqdENl?=
 =?utf-8?B?ZzRPVVZuTmZRQ1d4d3lsQ2taSlVOcTRiUHl6UXJ6OGtoRjNTdEh1RkFjVzNm?=
 =?utf-8?B?Rk1ZUHJERG5SSjBwMFFNZTBkeU85NmEvUzc3QWdtVHVWVFZ1VEp1T0JTSU5Z?=
 =?utf-8?B?aW1oMUR2dmIwaTdwWjVWSExQbEFaSjFDUUF0aEt3Qk5hdUwxMFp2andrUnRL?=
 =?utf-8?B?Z2xhVVlyRjZaNXVpbWdtVkJvQ3dHcmRteFVzU2QyYWlhZUhLZFBXSzJBcEk5?=
 =?utf-8?B?NFgvaFdFWUZSczFJcnMrVkEwMzBrNE51SWZDTFVEVmlsRmhiZ0xzb0g0ZEFt?=
 =?utf-8?B?WjNoT3E2MlNscjNXQXZDY1VHbnZSR2Zwei9sTDVHLzFiUi8wNWJWU2VybDB3?=
 =?utf-8?B?d0JjMDV2K3pXanlPdksyaUpneTFyS0pJNUs5bGFOcGpkTE5lb2hhYlZpa1k4?=
 =?utf-8?B?K0NKWVoxMnhlL1dMbzBXRDlyUWZDTnRJS2pkTXhrK2pTVmRNRERqYnhGUHpN?=
 =?utf-8?B?NnNGQTdXeE1IbW8zUWg4UlZoN1JyenFoQlN3d0lYM1pQcjNjM291cXpudGcz?=
 =?utf-8?B?U3RiSE5KVzV3aDk1T05SSGpseFl1K0FWQlNmVXREbmtkRUZnY0FTMzRFa041?=
 =?utf-8?B?ZFpqK1hzMDlFdWNXZkpabi9vTTd5RTB3eDVVeGZ4Vm5qWlV4dlRDOUNEZTVx?=
 =?utf-8?B?ZG9CbWJNdHNMbC9yWkk1TEFSYkU2MC8ydkp6eXk2dm95V3lPaDZmNWIrWTV3?=
 =?utf-8?B?Tis2WXlsTU5LZ1RpcHFsUEZLSG5XQ2orR2xJMVpmc3lWc3pORFBUZ0VCNy9H?=
 =?utf-8?B?NXZwdW1IRy9NVEFCL3JXaGkyK2JwMjZLNzFJOTlRQkJEalN4N0dFV3l1dkEv?=
 =?utf-8?B?M3NHd2llTFJ5cmJvVUwwb0xGUnVWUi9IRVlsUkdlT0JTRmYwSDFpWmowN3Vx?=
 =?utf-8?B?WWJEV2NHdjRSNHh6MjgvZlFDdnlZSXQ0enF6TEF0VE14SC9IM3lEVkVpY2Ew?=
 =?utf-8?B?OTFpeE0zcGZNbWhZN1kwZVJBcFNhWHNXSGl5cVdkVDZPMUI1NHNMRDRFZDdi?=
 =?utf-8?B?T1JHOXZzWjYxZjltdDdmT2tuN3dIVGN5ZE9Zb281dmhlMm9pRUxFSjZkVlJh?=
 =?utf-8?B?OEJmSEhwa1Jnc0twcFMrZHRCMkM4ZWZCaDViaCs5VVpNblJVRUhkZUJZOTFk?=
 =?utf-8?B?TGxlRnVseUJwQ1lRM1BTdWpqdWw4ZmdlVkEzSEo5YzBDTEZlaHdEemRhVGZt?=
 =?utf-8?B?QVlBK1NuMjdzTS9ITW9Qc3p5VU1TWTV3WCs0OGZsTUh1OTgzNHBzaWFDcDJR?=
 =?utf-8?Q?BsEGuwJtNQN1rKxAzqJuDy/M/tmcbKrU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REpRSU9KNlhqbjRQN0Rtck5oK3lqOEVEeVJGTHV4N3hHa2tBYVpTUFUxUW53?=
 =?utf-8?B?SDM1ai8vUzlWKzZYVEl1RUZBWWtsMm1pZHZob0tISytKMWhoOVowVkRnUVpE?=
 =?utf-8?B?eUNIUnVNN2d1QkdwaTRzTDBKZW1hZjh0VTdPS2loRksvM3RuUDB3T0c1MmJC?=
 =?utf-8?B?WEJvSXl1ak00bTQ3QTZ4UzVRWDArVmI3NXExS3poWDV6SlFXaXdGeE1vZHJy?=
 =?utf-8?B?ZmhDZW50MVBLQnFHMFJiMm40T1VRMTVDUXZYWnhEaWtSRVREbFdraDVidHpL?=
 =?utf-8?B?Y0YyMGtEK2EvYXFGYXR3S1dmN1pPa3Erb2MyelY0Y3F1T2VvRUZoNzQ0Mkdr?=
 =?utf-8?B?SEVPbGVDSE9XZC9vSlVobTRzajNHdGIyeXpsMlhJbDJ6OVRqMGo5eWUrZ3du?=
 =?utf-8?B?aGljTFNuQUNzZ2tRbFdNS25odloxS09ZK2RHaGZwQnJVdW5pS2haWnBXZU5D?=
 =?utf-8?B?WVI4QXJyWGpGTXFJcS9GNytmOERVS0hCN21vVEd6WGpSaVhsTEhXeGJWRzRM?=
 =?utf-8?B?NEhYcnhhR29XdUQ5Y1FSWlFDdjRleGJ1R1UwSEpab0pYTzJYWXQ5TEo5bGNC?=
 =?utf-8?B?M2VlTDFZUCtNMTJwY3UzWUpyWDlYOUV6c3pST1RrcnJCczdHR1NOVTVsTERq?=
 =?utf-8?B?enBLUGlBQ2ZSa3ppM040NWRhOHlMc0RiZjZiL3l1T0tvZ3BYY0twY1huQ0Fy?=
 =?utf-8?B?VzA3ejk4aEhaSnV4SXRBT3VlNjN4ZXNEWVpBR0Y4UmNNR0ZWK2FiNWhrd2FF?=
 =?utf-8?B?eXBxVm0rVFJUZGpMNTI4cmkyclE1R21sT2JKQ0ZOVkVXNHF3emJzWWpVODMy?=
 =?utf-8?B?aFU2ekM5K2NhZzV0U0pFRFRBam9mWnNnYTdVdGZPOTF3cmUxdDIxZjJCOU94?=
 =?utf-8?B?bzdQTXpyZHFUR0VVR2JtQ2lETmp0MDlNdHREbWltTHhxaFdiUkFVWUV5WjBp?=
 =?utf-8?B?b25EQklveGNXaWxyK0IxWXlzU3JRL09NeVZkQnlEMWNvUUJRaFlWd2ZvUytW?=
 =?utf-8?B?QStJOUFHQTBJUnNEV2VPUzRtSW5MTFVUNUxiZytvOW1RR3FZNnRsZVRSRmNF?=
 =?utf-8?B?Q2FVZnVJS1dkOUE3QzRhY2R3anBmT05CUDlPSmdra01TcVd2L1hqTjVCMFlP?=
 =?utf-8?B?d3pJQzF0VjVTVlU0VHgxcjRXVnMrK1l3R2haRHVURXluc2tvSjdpN2ZsVFdE?=
 =?utf-8?B?d1FJZi9seWFISTY1QnJFVEtpazIvZ1NGSjFGN0g0cisrOUs2c0hxWlNlYmh6?=
 =?utf-8?B?NkljNXhxc1hCMnkwTlR2QVB4di9HemMzemczWERUZmhYaHhpcnBwK3RncXIy?=
 =?utf-8?B?ekNkMTZ2SGpEcjk3aXdDeW1jMUFQRk9lV05qNVRIWjJtbEtzTHI4bEtQSThj?=
 =?utf-8?B?cjQ0Y0JTc0VlRkpSTWdRR0Vtcm5kNmZtVEZpWitvYlB3RmhkYkRJbHRyQTMz?=
 =?utf-8?B?WCtMT0V2ckI1cFRSVG9ld0h3TmRsam9wQUdBc1RYOUZmbHIxejY4aDVvWVZS?=
 =?utf-8?B?YVRPdjlZaDZJaU1ISFpicWFTRTlFOUdPOXVRZFVYdkFoUHFRWEtxQnNpMHQw?=
 =?utf-8?B?dHF2R0lXRG9UcVc4R1l4Z0tuK0c3NHBGVFdWODQzTDNvMG1ycklYSUtpYUdw?=
 =?utf-8?B?Mm5aSGo2dU55MGUxSWdPeHIrVlNSSGdJbElKNEtCQ2VBbmhzQmFxb1lTNEhP?=
 =?utf-8?B?dFRmbS9WREtCSEJ6emE0MHg5bFI5b284TEdHbWNmZkFYWE9BaE5qUVRubStU?=
 =?utf-8?B?NU1veUxXZm5sL2N1aG9kZ0lWVXhROFNLTE1rcFBzSEVNZTVhU3NEd2xVeWVu?=
 =?utf-8?B?WXdMS1h1TlNFc1NUOGxFTVBFUWNxLzdpQ0JnREVQMWhMYnZLZENFNXlxVTRk?=
 =?utf-8?B?VFpveHQxVENkNUpkaUZWRS9UUGFsM3JvYkZBQThSZStqWmloWmlaRFYveUtl?=
 =?utf-8?B?R1FRcmN2RjYwaEFHVmtrMTlyWjhBdlFPSUF0azdEOUszWnVjVGVyZU5Ybmxt?=
 =?utf-8?B?ZDhoempURWJLSllURDJSQUg3bUcwUWVYcWV3VVdlcW4yVi9Ob3pMcFZZWVVD?=
 =?utf-8?B?MUVHS1NzcjJwTEV1R3ViUTJRMGNOSGl1b1F1QUQ5MTJYYW5lOVdTMXZkSGha?=
 =?utf-8?Q?6icyCsD7VnzDF+bdfC+RVjNaP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0238f8-0424-4b7a-15a3-08de15754416
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 16:24:13.5826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVM6+uVVfY37+u4c7DeSCKpje9YPphhTOVN7eMf4IIsTxB5UIrNQ0jrXtEkxgRXF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140
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



On 10/27/2025 9:51 PM, Asad Kamal wrote:
> Update asic_invalidate_hdp and asic_flush_hdp function to check if ip
> function exist, if not return void
> 
> v2: Use else/if (Kevin)
>      Update function name (Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  7 ++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 16 ++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  4 ++++
>   3 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 50079209c472..d1137d8beca7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1539,11 +1539,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   #define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs->read_bios_from_rom((adev), (b), (l))
>   #define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asic_funcs->read_register((adev), (se), (sh), (offset), (v)))
>   #define amdgpu_asic_get_config_memsize(adev) (adev)->asic_funcs->get_config_memsize((adev))
> -#define amdgpu_asic_flush_hdp(adev, r) \
> -	((adev)->asic_funcs->flush_hdp ? (adev)->asic_funcs->flush_hdp((adev), (r)) : (adev)->hdp.funcs->flush_hdp((adev), (r)))
> -#define amdgpu_asic_invalidate_hdp(adev, r) \
> -	((adev)->asic_funcs->invalidate_hdp ? (adev)->asic_funcs->invalidate_hdp((adev), (r)) : \
> -	 ((adev)->hdp.funcs->invalidate_hdp ? (adev)->hdp.funcs->invalidate_hdp((adev), (r)) : (void)0))
> +#define amdgpu_asic_flush_hdp(adev, r) amdgpu_hdp_flush(adev, r)
> +#define amdgpu_asic_invalidate_hdp(adev, r) amdgpu_hdp_invalidate(adev, r)
>   #define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
>   #define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
>   #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> index 6e02fb9ac2f6..5a60d69a3e1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> @@ -66,3 +66,19 @@ void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
>   				      0);
>   	}
>   }
> +
> +void amdgpu_hdp_invalidate(struct amdgpu_device *adev, struct amdgpu_ring *ring)
> +{
> +	if (adev->asic_funcs && adev->asic_funcs->invalidate_hdp)
> +		adev->asic_funcs->invalidate_hdp(adev, ring);
> +	else if (adev->hdp.funcs && adev->hdp.funcs->invalidate_hdp)
> +		adev->hdp.funcs->invalidate_hdp(adev, ring);
> +}
> +
> +void amdgpu_hdp_flush(struct amdgpu_device *adev, struct amdgpu_ring *ring)
> +{
> +	if (adev->asic_funcs && adev->asic_funcs->flush_hdp)
> +		adev->asic_funcs->flush_hdp(adev, ring);
> +	else if (adev->hdp.funcs && adev->hdp.funcs->flush_hdp)
> +		adev->hdp.funcs->flush_hdp(adev, ring);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> index 4cfd932b7e91..d9f488fa76b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> @@ -46,4 +46,8 @@ struct amdgpu_hdp {
>   int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev);
>   void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
>   			      struct amdgpu_ring *ring);
> +void amdgpu_hdp_invalidate(struct amdgpu_device *adev,
> +			   struct amdgpu_ring *ring);
> +void amdgpu_hdp_flush(struct amdgpu_device *adev,
> +		      struct amdgpu_ring *ring);
>   #endif /* __AMDGPU_HDP_H__ */

