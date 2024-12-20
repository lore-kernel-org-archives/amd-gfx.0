Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8FAE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 10:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05B510E11F;
	Fri, 20 Dec 2024 10:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="45OCW8+z";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E3A710E11F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 10:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6pMfEAdNMk1iM28m5n2FMFfqtGSQSaQ++KqqT5dgUeG2dghCDkqbhn4Hbzr/vVZnlukbhlCJwaubjihVBG/vAtvPrFPr30SoW0QVUgy7g27HwBAZmy5tRXb6cvui3lsl3+sSZDjXbavHVX/VvhqSuXcxW6Ye1bgklpgzCK1EqUqjhWrxfuLSc0t8g9niHo6VnPIXq5Sdjc+1Ax0qDjkxGKfuQt4JkPfWrCYDWiUjHxPliAzMYgGLX8j/UG3ufTwYdW/2K9+YCJZGNphiHsyfQfQd/1i83NpIyqSAqhgdFsLfZxt1fxv3+cq3nuOmxWfRJIfs2ujLj75DJXSOR2ImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyY1kySaABHw6DLVwIIfrQU6SETAwlRVQBjcURhRptw=;
 b=ECR3OQD80t80O2UWUXd8XJYH65HYU/WYRCRmXZXD6L4woCn1n6MmxQwuDTAkEwDapLH6zj4UyORwOjtzuQBL/yJuirXnJ+vQtqkBOQqD402oh6EsParCQE1po3LG3PqeNKwrFBKM72NMcYu2CUJI2rCiStYZ4tIWhCI8hGsBQ1YwB7XwfLtpbWxgzvA3/AO3TEQ8sX5RQvN4kFekdsY1Lna1PI3qgHBEmpS81sdATPnGcALZvB8ndMrZYVdFkANfKKwyOMOg0DTFLa6QlUdUs9hqj7HlB0TP05clXPIY40R86PZ/+Th3We9r+XqWNfTlaPKCDzkNLpnYHwHJiqxISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyY1kySaABHw6DLVwIIfrQU6SETAwlRVQBjcURhRptw=;
 b=45OCW8+zF+AvpuNbjuXHeByby4t8zRIscYIib+vExWkDpN926BCZae9PNPLiIe6/fheaE+RHNBvaccjYj7/dchWD9bwpA/kWIQkDxsMkJqpBVjroftauKgMUPpgDr63ZmXvf9VTFfPEqGEOwQHr8/WOqaJ/KckwJdLnQx+Yispg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 10:45:09 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%7]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 10:45:09 +0000
Message-ID: <a9e2b6de-9785-4de4-8ab9-57d0aef82746@amd.com>
Date: Fri, 20 Dec 2024 16:15:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/amdgpu: Fix out-of-bounds issue in user fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241219103824.630689-1-Arunpravin.PaneerSelvam@amd.com>
 <22a8d1c2-712c-4c16-a296-81fe342bdfde@amd.com>
 <b4acfc3c-5d91-4b94-8d7f-e653cebc5bbe@amd.com>
 <55e1d859-b614-442c-b0f8-92ed3f7cddf6@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <55e1d859-b614-442c-b0f8-92ed3f7cddf6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: a2532a04-5291-407f-a492-08dd20e35fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXcrOGlNMVdROXM3QVFkdFFFZkM4UWptTG8rRmlYNnlQd1B2RDlxS2FOQlhl?=
 =?utf-8?B?UjN0alVXVUJ6Z040c05aQ0FwS2FMRExrajBjbFBDeFM4WjRXaC9nZ29tNDlB?=
 =?utf-8?B?dGxDeTdUcndFVzRXWkFoK0xJV0VzS0lGMjNoM0lMZ1lOL2hqR3NhNDc4UmpG?=
 =?utf-8?B?cTBCdHQ5Rms5RHcxeVhoMlNycGUrTTBtSFhJOElLQ2VmTmpQNDU4Ykc2ZVha?=
 =?utf-8?B?K2xYdGNzQUJuOFVCRG9OOTZDZGhKOEh2SHFOaUhCRlRPY0Jlb05KNzhhYnk5?=
 =?utf-8?B?UG9Sd1ppaW5SQUVuWUxHdzBJOEp4eFNuSkYvVHhpalhXMkxTV3hObWQ2cnNx?=
 =?utf-8?B?dnFvQjdwUVplQkFwbEpMZmR4eFhqNG1FaXYrZzA0NVZaTmV1VlpVZjdmMHNx?=
 =?utf-8?B?UWdJUm5jMDNHRmE4ZVJaZU5xRXhVWldONWV6Z1NjR1k3Q1JRMEYra2c1UGpp?=
 =?utf-8?B?aWZVYUFTYVloc3hHRW5lU1NjdUdNYjNJNXFpUzdEQXVXdDU1RHM2U0R1R3J6?=
 =?utf-8?B?VFJsQXJxSHNjdTMrZlBuMDJVRC9wbTJLcC9EQklWRmQvSkVkNGwzaU8zMFFw?=
 =?utf-8?B?SzJMcWgwU1pGYmY0dkJsMlRHejJka09DWDNTUHY2OWZxbVY3ZG54RDZ3U1Y0?=
 =?utf-8?B?WkVmamttZmlKaWJmTzJoaGgxMmtON1ZRak1TR1BycDcxQjYvanpER1QrQzBj?=
 =?utf-8?B?OFdsU0RiNVc5RkxrdHdFTkt2b1V2anZVNllMcTVxSUptQ04rSGp5QzBRNVJ4?=
 =?utf-8?B?N043VjlscmNYNXFIY2phUjJrTmNOUWR5MTRvQUlDNnNyM2h0c3loZTlpc1ds?=
 =?utf-8?B?WllvMnp2a0xXL3FDcnRhcC9zaitPYUdyZDlETUdLOEhlNkNEbGRRa1F2cklh?=
 =?utf-8?B?b1dSL0hqVEZEazZveGpKMVhoWnNnRGduenhPU1RqNGk2MXlLb2lTMldqQXJ1?=
 =?utf-8?B?dERVV0ZObTlJQllxSFlkN0k2QnpIend1elhaZ3BnZ2k2Z1o3WUF4ck9MOFJL?=
 =?utf-8?B?L0NqbTFxYmxVbnJxQ1pQczZ5ZE15RCtTdUFDZlVtY21UNXZQd01CemNYM0Nl?=
 =?utf-8?B?MnMwTy9XaWZScHBBN2xXUk1zMWlGY09MZTdrQjc4NEJnYkl4VE1CaVJDUnkz?=
 =?utf-8?B?VkxqVWhwRnNrSDNpek5qU21jWUd6WDFJcnZYcTZHeS8xQkljc2xDYlRxS3FR?=
 =?utf-8?B?YThQZEo1OUFZWVBDQ2FhbmJxTHFSZGUzS1dvODRwQXlPdkJjVk9aaUtvemRt?=
 =?utf-8?B?eVBGUzc1UTZUN09BN1g3Smp2em4xa3Z5MjNvbERrOVY0TytFZnNsbi9vd3Zm?=
 =?utf-8?B?M2NoOHhTc3djZGt1U2d4dlhvWEVISTRMMzVaU0Y5SnhIbzFnTThBY0xQdGZW?=
 =?utf-8?B?L3JrNlVON2lGSTlRMDhHNXRKc1NuT1FUUXNUMVhlRzBwM1o2blVGbEVBbmVG?=
 =?utf-8?B?d2p4YTBtZkhLdTkzaEM5NnEybFdVVU40SEJsZCs3RVRVMWwrNXpYY0lRZUF3?=
 =?utf-8?B?Z3k1SmlvdE42TWJ3UEdLcjVDbmcwVVNVSFdNVUtMWGtXbmtGNWZMaWtOUnp5?=
 =?utf-8?B?T0NMVnFidEE3UGgvS0ZKdTdYT2VKMTBpRzVPR3BDSDVSRFhQZDh4MnkvT0Zv?=
 =?utf-8?B?ZzFTZkhmS3pxMWFQbVkwbWVHRXFVSTNHb0Q5dHc2RHdDWWE2azAvR29KSjVV?=
 =?utf-8?B?cndhTTBzRFVMNFFCVVphdERONkZnUDZLc3Rla1JVUS8wUnM0YnhUOE5mOXNj?=
 =?utf-8?B?aUR3MnBMNEQ4dENhZnVvL2VTWWk1ZjNZQmd0c3JRbUQ1QU1uVGtDb2l2dTBv?=
 =?utf-8?B?Zkhsb1Y3b0crWnhobXJ5eWJqWERoZVpadExoL3BsdGMzNXpqbXI2SjV1OGJJ?=
 =?utf-8?Q?/DsqZYF+A/DxD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXhpUkVIVElUSkQ3akFKS2tSNk4vQmtRMUlIYUVQdzdmYjZJZlZRMmYyM3RZ?=
 =?utf-8?B?TVEyYVR4ZS81VldIS1BrcHA3U1lGZCttTVlDNFJheU5FR253RVgwemFwWXFr?=
 =?utf-8?B?WVZNQmVENXFEQlkwVDFnV2haWVNWOU5aeDhpbVpVY0Zpa3RHNnNmNVk1Y21V?=
 =?utf-8?B?MU9Wbkw5WSt1alBBN2RsV3ExRndoWHhxV2pTRU9ZUVdFSjBzbWhSTEM0VEFv?=
 =?utf-8?B?Y1dYSFlDbjd1SjQrNDl2TmVHdHFlVEltd2hlVjFGVmlDbW1vbkNmVGhSMXV0?=
 =?utf-8?B?a3lDN25iRTQ0SWFkdk42ZWh6Z0I3VFZTS3JBcFlzYmUzTmN3YVE5eVpYU0F6?=
 =?utf-8?B?VnNmSTVTQkhvOEJDQ3ZHMVhzRGVvK2k3dmZKS1NjYXVuK25rWWJKc3BzVU05?=
 =?utf-8?B?enVtTnVXeVo4YWpVOTBqVUVuR25nZ2RydUJGK2gzL095cFNTQzNkYnkwdkxJ?=
 =?utf-8?B?NmxiZXlSRis5eGc4TytEOHJSSHNZem5sT2diRElNUEVTTDJJd3FUVVdaNHMy?=
 =?utf-8?B?bmcwV0wrUmlQWGtBdENVb3hnZlR4a0RRSUk3SUlHNERRcWF4QkZWYVNMT2V6?=
 =?utf-8?B?bjdNZWswc2tkMFZXNFBvOE5qdUpQT2JRN29WVURoaHByekh1S29PN2d2d3Zs?=
 =?utf-8?B?anU1cG1hSWQxY3owTjdUZWI4Z0FLclhyQklxTk83Y3JiOGpzeURKa0p2V3VB?=
 =?utf-8?B?WEpNRlBBRlNvTTF0ZWdwUlVQYWxjaUF6eWxXMSttZTNwcmxOMFplWUJ5SDNo?=
 =?utf-8?B?K0lEcDFJTFMyNFFRL3V5UDVUcjZsQWdRdFRETWlTcWxtL1poanh0ZUkxTTJQ?=
 =?utf-8?B?RXE0VmZlMWlPVWlIVHJ5N3BTNmY3czR2TjYwNTAwYXE4UVVvWVNJRGFrOFBs?=
 =?utf-8?B?WGVvelc5M3VhQWtvOHRxYUxkSUJGR1loa0hXeFpKcS9NVVA4UmZUMjc4Uk5p?=
 =?utf-8?B?a3ptVUpuUU04THhMV1pvemdqUGtoaC9IN0xPSUc4ZUp4cnN6bnBuc0JKa2h5?=
 =?utf-8?B?S0I4aFdBVlEwQUs1L0F5c3o3WlRFcENVY0VDa3NTT1lvYU4wMFNRUnBkQkhp?=
 =?utf-8?B?ZlJJYk9pc2d6eVprREVHblNLK3VFZllYbkpNbmlWaVhxTkhoV0d6N3BrUXgv?=
 =?utf-8?B?VVRlNzc3WUE5cnlWOStvZEtSU2VKSSt3MDIyclZXL2FXZ2wzVVN5dy9iUGJD?=
 =?utf-8?B?K3o2YWR1MGdTa3RDMWZrNFVlblpEaVlsWUFCbnBwcnptSHNMaWdYOVJjWFZz?=
 =?utf-8?B?YkJnNGM0ajJoL2xQTzJqWXhEazRnY2VXN3JCNDdvY096NjVRZ294L2srRzl0?=
 =?utf-8?B?WU5RQjZnS0VkaC9RUVdSK3k3Sm9HT2dHRGNseHhKZnczYTJIcE1xYmk2d1Vo?=
 =?utf-8?B?WXJ5SjVQYXREK1J5YzdZMFNGZGRBWU5EYUd2d1FuZ1laZ2JFNjJPZnpGT09F?=
 =?utf-8?B?d3BRZnIzckRNR0MreWpRa0RQakpWSnVQYlVWUkNJdWlaY1hqcm5MQy9hdnRN?=
 =?utf-8?B?TElsWEpnWWxPd2VnYkJ2M0l5TWt5VEV0K1dGQTdlbHRqcW40WHkwSytBOUY4?=
 =?utf-8?B?ZGpNWVFTd3ZkdHV3N1QwRlBNeVlBeHdSR0xFais4dHUwYzcyYXJKNW1GckEr?=
 =?utf-8?B?R0lKaVZ1ZXhHeFI5U3lqSGlpV0FBNWMwMnVhSDJYdm1QVnk5V0FvK2ZGOHFx?=
 =?utf-8?B?UmZQM1E5UHd1NWRlQTh1ZFVGZEx6dVhyV20zVW5Zckx3cVJYU1FPdG5qZDYw?=
 =?utf-8?B?NHAwYWRBc0hGdEhkVlRWdGtCYVNaSk1DamVxcFpqejJrZzRVYkx4dnF1Mjhs?=
 =?utf-8?B?ZElGVnlYSmJKMk13R1VkZk5ydWloQ2NNby9YVHVJL3lLUnVNOEJVNzR6UXFo?=
 =?utf-8?B?cnp4d2l6emJ2dVdyWFNIRi95R284SFFtZVpDQTlXZHZVRnAyR2s5dUtYSjdh?=
 =?utf-8?B?bFBUM3I3Z3RGYTdScWtoVXlaN3lBRHJvdkorYzVCV29FUnI3WGo3L1pVcXV0?=
 =?utf-8?B?enR6MEFDajQyS0h6YVhtcDA5bTg2MEdzb2k0cWFya2FMaWRZdnQ2NXRveVJU?=
 =?utf-8?B?VklPVnVwbFhIMWE2N2F4ai9tbm9OL010dmRVNzZxb1pNNUJ5alF0eCtvZlpN?=
 =?utf-8?Q?SOkH1X5P16LgMhtHiTIdDB+iR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2532a04-5291-407f-a492-08dd20e35fbc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 10:45:09.5537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+zvV9opuV9e1zn3la1ZtSZb2FguYsDyd+hL7bYeFikZxu7AQQmj1PVFxvJc4QmJuSnzgdfnP5SUEOLvcrrIMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511
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




On 12/20/2024 4:08 PM, Christian König wrote:
> Hi Arun,
>
> Am 20.12.24 um 11:34 schrieb Paneer Selvam, Arunpravin:
>> Hi Christian,
>>
>>
>> On 12/19/2024 4:11 PM, Christian König wrote:
>>>
>>>
>>> Am 19.12.24 um 11:38 schrieb Arunpravin Paneer Selvam:
>>>> Fix out-of-bounds issue in userq fence create when
>>>> accessing the userq xa structure. Added a lock to
>>>> protect the race condition.
>>>>
>>>> v2:(Christian)
>>>>    - Acquire xa lock only for the xa_for_each blocks and
>>>>      not for the kvmalloc_array() memory allocation part.
>>>>
>>>> v3:
>>>>    - Replacing the kvmalloc_array() storage with xa_alloc()
>>>>      solves the problem.
>>>>
>>>> BUG: KASAN: slab-out-of-bounds in 
>>>> amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>>> [  +0.000006] Call Trace:
>>>> [  +0.000005]  <TASK>
>>>> [  +0.000005]  dump_stack_lvl+0x6c/0x90
>>>> [  +0.000011]  print_report+0xc4/0x5e0
>>>> [  +0.000009]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000008]  ? kasan_complete_mode_report_info+0x26/0x1d0
>>>> [  +0.000007]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>>> [  +0.000405]  kasan_report+0xdf/0x120
>>>> [  +0.000009]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>>> [  +0.000405]  __asan_report_store8_noabort+0x17/0x20
>>>> [  +0.000007]  amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>>> [  +0.000406]  ? __pfx_amdgpu_userq_fence_create+0x10/0x10 [amdgpu]
>>>> [  +0.000408]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000008]  ? ttm_resource_move_to_lru_tail+0x235/0x4f0 [ttm]
>>>> [  +0.000013]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000008]  amdgpu_userq_signal_ioctl+0xd29/0x1c70 [amdgpu]
>>>> [  +0.000412]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>>> [  +0.000404]  ? try_to_wake_up+0x165/0x1840
>>>> [  +0.000010]  ? __pfx_futex_wake_mark+0x10/0x10
>>>> [  +0.000011]  drm_ioctl_kernel+0x178/0x2f0 [drm]
>>>> [  +0.000050]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>>> [  +0.000404]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
>>>> [  +0.000043]  ? __kasan_check_read+0x11/0x20
>>>> [  +0.000007]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000007]  ? __kasan_check_write+0x14/0x20
>>>> [  +0.000008]  drm_ioctl+0x513/0xd20 [drm]
>>>> [  +0.000040]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>>> [  +0.000407]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
>>>> [  +0.000044]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000007]  ? _raw_spin_lock_irqsave+0x99/0x100
>>>> [  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>>>> [  +0.000006]  ? __rseq_handle_notify_resume+0x188/0xc30
>>>> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000006]  ? _raw_spin_unlock_irqrestore+0x27/0x50
>>>> [  +0.000010]  amdgpu_drm_ioctl+0xcd/0x1d0 [amdgpu]
>>>> [  +0.000388]  __x64_sys_ioctl+0x135/0x1b0
>>>> [  +0.000009]  x64_sys_call+0x1205/0x20d0
>>>> [  +0.000007]  do_syscall_64+0x4d/0x120
>>>> [  +0.000008]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>> [  +0.000007] RIP: 0033:0x7f7c3d31a94f
>>>>
>>>> Signed-off-by: Arunpravin Paneer Selvam 
>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>> ---
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 43 
>>>> +++++++------------
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  3 +-
>>>>   2 files changed, 17 insertions(+), 29 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index 2e7271362ace..4289bed6c1f7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -122,10 +122,11 @@ int amdgpu_userq_fence_driver_alloc(struct 
>>>> amdgpu_device *adev,
>>>>     void amdgpu_userq_fence_driver_process(struct 
>>>> amdgpu_userq_fence_driver *fence_drv)
>>>>   {
>>>> +    struct amdgpu_userq_fence_driver *stored_fence_drv;
>>>>       struct amdgpu_userq_fence *userq_fence, *tmp;
>>>>       struct dma_fence *fence;
>>>> +    unsigned long index;
>>>>       u64 rptr;
>>>> -    int i;
>>>>         if (!fence_drv)
>>>>           return;
>>>> @@ -141,8 +142,8 @@ void amdgpu_userq_fence_driver_process(struct 
>>>> amdgpu_userq_fence_driver *fence_d
>>>>             dma_fence_signal(fence);
>>>>   -        for (i = 0; i < userq_fence->fence_drv_array_count; i++)
>>>> - amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
>>>> +        xa_for_each(&userq_fence->fence_drv_xa, index, 
>>>> stored_fence_drv)
>>>> + amdgpu_userq_fence_driver_put(stored_fence_drv);
>>>>             list_del(&userq_fence->link);
>>>>           dma_fence_put(fence);
>>>> @@ -221,34 +222,24 @@ int amdgpu_userq_fence_create(struct 
>>>> amdgpu_usermode_queue *userq,
>>>>       dma_fence_init(fence, &amdgpu_userq_fence_ops, 
>>>> &userq_fence->lock,
>>>>                  fence_drv->context, seq);
>>>>   +    xa_init_flags(&userq_fence->fence_drv_xa, XA_FLAGS_ALLOC);
>>>> +
>>>>       amdgpu_userq_fence_driver_get(fence_drv);
>>>>       dma_fence_get(fence);
>>>>         if (!xa_empty(&userq->fence_drv_xa)) {
>>>>           struct amdgpu_userq_fence_driver *stored_fence_drv;
>>>> -        unsigned long index, count = 0;
>>>> -        int i = 0;
>>>> -
>>>> -        xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
>>>> -            count++;
>>>> -
>>>> -        userq_fence->fence_drv_array =
>>>> -            kvmalloc_array(count,
>>>> -                       sizeof(struct amdgpu_userq_fence_driver *),
>>>> -                       GFP_KERNEL);
>>>> -
>>>> -        if (userq_fence->fence_drv_array) {
>>>> -            xa_for_each(&userq->fence_drv_xa, index, 
>>>> stored_fence_drv) {
>>>> -                userq_fence->fence_drv_array[i] = stored_fence_drv;
>>>> -                xa_erase(&userq->fence_drv_xa, index);
>>>> -                i++;
>>>> -            }
>>>> +        unsigned long index_uq;
>>>> +        u32 index_uf;
>>>> +        int err;
>>>> +
>>>> +        xa_for_each(&userq->fence_drv_xa, index_uq, 
>>>> stored_fence_drv) {
>>>> +            err = xa_alloc_irq(&userq_fence->fence_drv_xa, &index_uf,
>>>> +                       stored_fence_drv, xa_limit_32b, GFP_KERNEL);
>>>
>>> That is even worse than what was discussed before. Now you have two 
>>> XAs and the second is incorrectly using GFP_KERNEL.
>>
>> I think the problem here is, the WAIT IOCTL updates the 
>> userq->fence_drv_xa entries between the 2 xa_for_each blocks
>> exactly at kvmalloc_array memory allocation. Though, we are locking 
>> the first and second xa_for_each blocks and having the
>> GFP_ATOMIC in place didnt help to resolve the problem.
>
> Yeah, I agree on the problem. But I don't understand why using 
> GFP_ATOMIC didn't solved the issue.
>
>>
>> For example,
>> kvmalloc_array() is allocating the memory for the count value(say 5) 
>> and before we acquire the second
>> xa_for_each block lock, the count modified to (say 7) by the WAIT 
>> IOCTL xa_alloc() function (by acquiring the same lock),
>> and we would be iterating for the new count. But the memory allocated 
>> would be for 5 entries.
>>
>> xa_lock()
>> first xa_for_each block to count the entries
>> xa_unlock()
>
> When you use GFP_ATOMIC you can drop this xa_unlock().
>
>>
>> kvmalloc_array allocates for count 5
>>
>> xa_lock()
>
> And that xa_lock() and so make sure that the xa isn't modified in 
> between.
Got it. Thanks!

Regards,
Arun.
>
> Regards,
> Christian.
>
>> second xa_for_each block to move the entries to allocated memory
>> here the count increased to 7
>> xa_unlock
>>
>> Thanks,
>> Arun.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> +            if (err)
>>>> +                return err;
>>>>           }
>>>> -
>>>> -        userq_fence->fence_drv_array_count = i;
>>>> -    } else {
>>>> -        userq_fence->fence_drv_array = NULL;
>>>> -        userq_fence->fence_drv_array_count = 0;
>>>> +        xa_destroy(&userq->fence_drv_xa);
>>>>       }
>>>>         /* Check if hardware has already processed the job */
>>>> @@ -300,8 +291,6 @@ static void amdgpu_userq_fence_free(struct 
>>>> rcu_head *rcu)
>>>>         /* Release the fence driver reference */
>>>>       amdgpu_userq_fence_driver_put(fence_drv);
>>>> -
>>>> -    kvfree(userq_fence->fence_drv_array);
>>>>       kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>>>>   }
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>>> index f1a90840ac1f..3283e5573d10 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>>> @@ -37,9 +37,8 @@ struct amdgpu_userq_fence {
>>>>        */
>>>>       spinlock_t lock;
>>>>       struct list_head link;
>>>> -    unsigned long fence_drv_array_count;
>>>> +    struct xarray fence_drv_xa;
>>>>       struct amdgpu_userq_fence_driver *fence_drv;
>>>> -    struct amdgpu_userq_fence_driver **fence_drv_array;
>>>>   };
>>>>     struct amdgpu_userq_fence_driver {
>>>
>>
>

