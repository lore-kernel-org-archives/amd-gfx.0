Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB7DC3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 09:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8835A10E36A;
	Thu,  8 May 2025 09:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y3QTBHpm";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC36C10E36A
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 09:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXHd+DEhjTjVddnqXdb+Jt43BizaOKuRoOz6ZgOuKfwcWwA02dXOE3lY8DxhG3idlVD49AGJamYS17GHkindLxDgXJf5ocIRkhfl8+BbDV7lInR/eTIkCCQMSLlhu1TWQGj7/iKTxljAabcdwbGWUZxrKPLB3MoNszB51UPZWNV56/3DqZJAohX7wFCNIlLDE38XSkE3DKIg41IFCfEedD9txFLch/7iPZG9eEt1nMhrZCN9h2ZrGo598GNnEbO9v3dnMrOQShx/ZJoXYlYiEJUxEcplKMXKWfOrOkxRACbx+jggeZ57dK7H+MBXBvDg+9eWCb7pQ4uFzQamUhbIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1h9tbkJJYeF/MJO7OnLKU3p/G4rfpjAHVVabyOaX0yU=;
 b=xsLHzeaTKCgOcKorsaqGZKbtiWo/DvAic7Sp0Vlp7I6uUZc6aq21zRYIjGS4NyVnVLXBMCfOoWG8yghvththDVs/SA5Kw7UostuSroe0JSfx5WGpWqrDULcJ/khA/seQHtkrqnrY3KZ6BI5xF98dNdtFYZCUAt6AZu/Gut8yCOswFozgCWoF83G5xXqhDuml1LEcBC9XDV7/JR/w62Xq/F2tfhH5sVY+Bwb9SGC23+H+6W6J2Ros3QJvBtMZ93nV/Ic/vC6KotuKUbpvc5YAsNcPD691xrDut5Lz49LQdvGvPWoazZ1/t9+cmBINPlKtVb5qy8YXDhDzVNDvv33/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h9tbkJJYeF/MJO7OnLKU3p/G4rfpjAHVVabyOaX0yU=;
 b=Y3QTBHpmEVTnT9P5ii+Z0+5r+ifdKHfX2znIKq+H6M/wsPWn4wfifsdwHngSwdgiQWiYVDU7oU893+TUA1R0T9gcKRvfCexdGzUHJkI+t3DwGSxIAkJ811X1iHGfmPtp8hEq5J9ZupDbE7UDo40XGQAnZqvBiT0iPmY4E1EFpZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 09:24:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Thu, 8 May 2025
 09:24:02 +0000
Message-ID: <089c7ecc-5795-4090-af55-da8437654a81@amd.com>
Date: Thu, 8 May 2025 11:23:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: csa unmap use uninterruptible lock
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20250507213900.26723-1-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250507213900.26723-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:208:fc::41) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aca6f50-858d-473b-597c-08dd8e121265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0JaS28wekxCaHl2dVAzNEZlQXdZNm1HWmVJeVl6WmZjaHhpT3pOUFQwRkQy?=
 =?utf-8?B?Tld1aTZsZHlScVI3OWNnZUFHNUhXOEhTbDBNMWlpQ09WWkNCOWlsSE9nam9O?=
 =?utf-8?B?SnVOdFAzOGtENnkzTktxTGhyS1NVMUlNeUZtR2tSNTJNazViOVBtNHE0UnJB?=
 =?utf-8?B?eUZQVTdjdmR4aDF4MGdrdmlnNWMvK1prc3VvdUluVzRKRm5UY092Sk1PL0d6?=
 =?utf-8?B?YmZxbFNtUytSeFFZSkRKSlc2L3NuN2NQOXJxVVRXQ1dmS25DbGdDWDZuVnc3?=
 =?utf-8?B?cjVlWXUwaWlneGZSa1ZvRFU3Z2R3MVYxS3kzOUMrQTJ5MFBrOUl6ZTB4L1RF?=
 =?utf-8?B?N1h3WGdtZ08xWHk1d0FaR1JDWk9iaTRNZlExdmpZS0gyRTRuOEsxRnRmVUp2?=
 =?utf-8?B?MytqOVRjclVJNURvK0x3Sk0wbiswV1ovVmNmK0NDWnRMeHhiUnVSdU9KdWhi?=
 =?utf-8?B?MS9RU3hBUEZxcDhCejNqdnRnZWt2d21NTGhiQkVZdG93RzJoNSs0azVRTVVp?=
 =?utf-8?B?TnFNV0dWVlBvbThhZnR3OWNMYmNhNlk5QWFITXYvY0RXZksvU2hCOHFGYXBY?=
 =?utf-8?B?VWI0bkxOLzdoU3JGY2NCVzlCTHlNSk1qalllOE5yM2F6N3hXN2JybWVSVzJl?=
 =?utf-8?B?allPcVJFajhsRVJNNG5DeWZHU0ZDLzh2TTNUaURxWlF0aWhpTDUwREt0NDVm?=
 =?utf-8?B?TlhRTHBBeWJ4K1hkUS9MVW9XTUZzbnVNZFVucEsvTjlDMzRCNnNhWUhJcTVU?=
 =?utf-8?B?TE9mWWpsYUVEK0F2ZWJEdkdPVEtnVGsxL2luTGk1R3E0U2xsTmlweXhMUjZk?=
 =?utf-8?B?UnUvZ3YxMjMySnE4TUlJaFZ6a0gxMGV1eUUwV0NEVjBPYmpLTjVVMmtaMk8y?=
 =?utf-8?B?ZjQ4Q3p5YnA2amxodm96Tmh2RDZyRERzRGkvSUxkWjg5QUhrcmFBSzNLMkZM?=
 =?utf-8?B?bkM4cHExSjRxMzZvNHJMN0J3YlVyZTEyRSs0VlZZYUdOVmwvRS9tdmlHTjY0?=
 =?utf-8?B?YTNIdEJVWDBuVUpISHhHY3VkWDNyVCttNktsM3lNOUluWkNwQ2dIQ2EzL3c1?=
 =?utf-8?B?SkozSUlYdGJQYjllWWFobWJXZ2pUbUZWL0dlWmZwZUNmRThKUUQ3Ymd5aFpm?=
 =?utf-8?B?MjNZSFJwL0JMRTlybmMySFRkMkk0d0QvaW5DYmxKRGptSjNXbEt1emxGUnI4?=
 =?utf-8?B?bG5XVGpFeDRBdjIyNEtXVytrOXRndFJEQ2lsUDdOOVJOWVVUWjFpY3dpNTli?=
 =?utf-8?B?Q0QwdjZiSjhPQUwzWjI2Vit3ZHlMU3JTdkN3Q25PaGRtZnJVVjV5dHE3TDRV?=
 =?utf-8?B?TmxibTNsZVhzaDY2N3BqWWtOVHBpWXRXMmhTYTZBUVgwR1ZxK003Ly9mQWlt?=
 =?utf-8?B?VVNQTzg1S25pRU9weWkzc0pVZmpsL0tLNERtdFJNOWtZcnJtMS9ibTU4N2Zr?=
 =?utf-8?B?ZVhmMklKN1p0SmcrYXo2Mm5JVFhIOE92ZTArSWNTZ096dGlRUnAzMzlCdEpm?=
 =?utf-8?B?K043VEJkeGYvYWJMdXRTaGM2M2ppQmVEd09tK0xLbkFKVEJrTmxma2ladUlv?=
 =?utf-8?B?Nkkyd09hRVExdHhKOEpCNkR2N09Gbi9uL3JHU0ZCdmxoWXV3MDdZYmorRjdU?=
 =?utf-8?B?Y0VLRXRhZjFWUEVGdmY1TmJkbko1YUw0K2FDY2pOL05hcDZQa3gvTkVHQngw?=
 =?utf-8?B?blRETlVQa3hUNEZuVklTV0xrbElkU04yNExiMjZWdzhOZ0ljaStuaDY3cE4z?=
 =?utf-8?B?TmhJYXhtcS9ERWFqNlNDd0ZucEtYczhIZ0w2VnVvNWk3YjVxUzhPcm14V1dD?=
 =?utf-8?B?OCtWR1hFVU9LWUhtSGNyaVdsWDN5Z2ZLUnBpd2paajVHQ0pQWWZFSnY1NWxv?=
 =?utf-8?B?L1BjVUxnazJpRFFPWnRoSCtsNUZ3dlBkOG84bVE0eXhLUkVVZGZMWmVLNjZi?=
 =?utf-8?Q?rf+U38GemhQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGZTS2NxaVR0czZNR0xtenoxZWUwc3ZXWWxULytUS3FBMWxxMmp0bmQzcUZu?=
 =?utf-8?B?OGZ4R20vVlBmdTZGWkVnL3ZPUkRDcDJlYUx1VnFxWHRQU0JMQlFCWWVIWGpy?=
 =?utf-8?B?OStlMHhHNkVud0Q0RStWdkxpTjVzT1hZTHRUWlhVTTZibGdXdzBkb3E2RXFJ?=
 =?utf-8?B?RlFmdkFoQTNwb1M4U0RiR3lYT3YzUUFab0JSVU1IVmJWSXVvcVhEZ29tNEhH?=
 =?utf-8?B?eDY4aEFCOGVETXhiT3ZFcFRxQ29PY3NmV1llTWM5VGl3VWRMT0NCOFRCZXhM?=
 =?utf-8?B?UG1tQU5yRENRY2hBK09nQTArTzhpbTZxbjZ2WGFpZVZzOHEzdmdGNHBrQXBv?=
 =?utf-8?B?TkFiM2I0dUREUVg5OUZOZ2swTm1HYUN3YVNNWjRmam1wSWVCd25mWGJJUmlk?=
 =?utf-8?B?MWN3V2JDOWZvQUZ5SWZKQkdObjRMb2RsZHQwbUdpZnIwenh3bDNYc3N4ZXlO?=
 =?utf-8?B?SG85Mk5SRlc0V1E0ZjNiRm1jNDV4V3l2a0Qza0JFQXJTU0ZSMC91R1lVQjlz?=
 =?utf-8?B?cTFicE1zMG9pTGF6VjI3YWgxd0pRS1hqOUdUNW5CaXFPSkl3U0xJRFlwUHlS?=
 =?utf-8?B?MThXVWhWMVpCRXIrcmJ3SjZsZitWaitsZHJTZWNoZXVOcURtcTlCYnJPN3Zn?=
 =?utf-8?B?QUpWTGdTSWprWHpLZUxtSkswWVZOL2lBbGh0dVFLYmNsRmd6M1lzdnlIamN6?=
 =?utf-8?B?Qk5JOUlZR05pRWVSMWxWY1ZrUnowU2tZazhTd09mVE83VWhtS2RRU2xpS3R0?=
 =?utf-8?B?QTFWTnlsc20xdVRZcUJwUkM5em43OHFDNG1aYkNwUTNnZ3U3QUp2amdyZXBW?=
 =?utf-8?B?MDFUdFJzZDk1bUNXdzBkdUgyeE9EYTMybjhXejdkZFBNLzBrWHBIQVJHbXlk?=
 =?utf-8?B?VFZkaW10bjlDUmM4cFEzZWdZT2FISXNRYmQvU3RLMXNJMlk0eFhydU5qdFIw?=
 =?utf-8?B?WVJWRFlxNUZoR29PTmhETzgwZktEUnl6VWc1cm0wamsybXZOc3hxODRMd3la?=
 =?utf-8?B?NjVPZU9qODRQOXQ1RUduSU5sOVVzTUp2NUFSMGxnR3ljaXR3RVZFczFHQ2VO?=
 =?utf-8?B?QnE4aVpSYktkaTZHWHMzSnA5Vk9lOExVSjlVMytDT2FRK2tCQThoeEw5TkVE?=
 =?utf-8?B?alM5NVUyemJtWmRyQmtJQUlGWWVsMlZiakJYU25Ya09ERFVnRlRaMHJmUVlw?=
 =?utf-8?B?anBaU2cvNkxCT2RkMnRUaTV0ZmZLVnVUak05VmNjVURzei93QSt5eXExSUUy?=
 =?utf-8?B?WHlvK2NRMERLOHlURlB5U01NWmRRZCszNTd2NXdzM3RLQTcxRC9mZVNGL0hY?=
 =?utf-8?B?ZDFQR1k5QlJHWDNkYW8xQUF3Qm0vNUEwSnY5UzJ4MEkwZFJwNXg5UWN3bFA1?=
 =?utf-8?B?ZDBjRnZUNHB5aCtNbkQ4b3dvRktvS2JIdlduRjNMUTNhTkVweGs2czlLOEly?=
 =?utf-8?B?Q1czZ2c5elVuejBZKzMvcGNVckYyNWRnUktZdTg2VFp0RHN1Slc5VEZ0QzdL?=
 =?utf-8?B?MkwzaWRnNFNCNWJ3ZGhZOGcwcmZ6SkpVNlBTR0RWZ2JVeU1wc3RHUW5CZzZ4?=
 =?utf-8?B?VTUzZitoREhtdDdINXlQZkVCeVZxamRyM05TNU9BU0xmWHAzaHUvK1dqTktS?=
 =?utf-8?B?ZXJNdmdwQ0htZExLS1J5cW9sRjJLWTZpRXJzc3BGZEZ0Z1hrNHFNa09pTHdv?=
 =?utf-8?B?ajJpN2VRQkl3WFlWUk5XWEZSdWZhbWE0S3lZNXRpS3pVRlhlaFAvdW1yQXVn?=
 =?utf-8?B?RXErcWVJNU9CRkkxSmlnMmZkOEJyekRJN1pDeHI3amp3Y2pubzJYVnhGcUV6?=
 =?utf-8?B?bHFJRFZNZ0IwSnAzYTE5MVlCTVRkbUNIcmUzS1VYcUZGa05UWkJ4eEVsaWpi?=
 =?utf-8?B?VWlZRUpmRnlQTjlCK0lSOHROYnFia21FVlhDSDJrNTFvZXVXQ2VXOFRNdkd0?=
 =?utf-8?B?anBkN0Z4NHJURGFxM25lbkpKSmsydWpmbnB5Y3VlQnJtVEtRMndudlQzVXNU?=
 =?utf-8?B?emFFZXd3RjU2S2R4cXRPanF5NDNkUTE1S0ZsNzVKTEovbkc2L29tREViQmUv?=
 =?utf-8?B?K2s5dFZwVDhFQTVmY0wvSU9DSGtCTEpld282U1dMTXBTN216M0l2YTlEYTUv?=
 =?utf-8?Q?FoNERFMCy1ZfVj3C59wKarcIh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aca6f50-858d-473b-597c-08dd8e121265
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 09:24:02.7347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlspapC8xpu6MDLqg1moBPsNPTvhA6HSVH9p4hZ2YJfawuKmm4CdliQJnEfFV/vu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
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

On 5/7/25 23:39, Philip Yang wrote:
> After process exit to unmap csa and free GPU vm, if signal is accepted
> and then waiting to take vm lock is interrupted and return, it causes
> memory leaking and below warning backtrace.
> 
> Change to use uninterruptible wait lock fix the issue.
> 
> WARNING: CPU: 69 PID: 167800 at amd/amdgpu/amdgpu_kms.c:1525
>  amdgpu_driver_postclose_kms+0x294/0x2a0 [amdgpu]
>  Call Trace:
>   <TASK>
>   drm_file_free.part.0+0x1da/0x230 [drm]
>   drm_close_helper.isra.0+0x65/0x70 [drm]
>   drm_release+0x6a/0x120 [drm]
>   amdgpu_drm_release+0x51/0x60 [amdgpu]
>   __fput+0x9f/0x280
>   ____fput+0xe/0x20
>   task_work_run+0x67/0xa0
>   do_exit+0x217/0x3c0
>   do_group_exit+0x3b/0xb0
>   get_signal+0x14a/0x8d0
>   arch_do_signal_or_restart+0xde/0x100
>   exit_to_user_mode_loop+0xc1/0x1a0
>   exit_to_user_mode_prepare+0xf4/0x100
>   syscall_exit_to_user_mode+0x17/0x40
>   do_syscall_64+0x69/0xc0
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>


Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> index cfdf558b48b6..02138aa55793 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> @@ -109,7 +109,7 @@ int amdgpu_unmap_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	struct drm_exec exec;
>  	int r;
>  
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +	drm_exec_init(&exec, 0, 0);
>  	drm_exec_until_all_locked(&exec) {
>  		r = amdgpu_vm_lock_pd(vm, &exec, 0);
>  		if (likely(!r))

