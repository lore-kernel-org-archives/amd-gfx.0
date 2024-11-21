Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B10D78785
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 16:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84DAE10E9C7;
	Thu, 21 Nov 2024 16:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xecO6eAj";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F092010E9C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 16:11:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgL7uEJzsLLuwPvW3qFW5UoTkkV1KNRCgBA8XClMLLCXPJAwxmSqRgfknaRcDEoeJFMBwuRiHASQeRQ4Gt1HMGuPrldJRD1YL7VrRJmjMJag4AxCxOOY0vJM1XSAK7RMVDRVv3ZN7l8FEb6Gr+qAMFLJwLnRvpfwLRkzX0J8QdFCZAaMMd0/pQG5QXWwan1FJNOeh4swCAc3EJqvidH4bTrG8QaW+2Cas8uQcA/TDhn5GG75hjOCZtGdp1LKq+AN+F5HW/OL0OelBlSOfG8bC4NPkOEyI/CUOQouCtgMF6Vk+XjQ4AZIjZF9yB1ymh20njoolJQSjkOqRo9GOC8S8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRJZ56YoUTvuwnJwcm5bn4VGar/vbvIBinjxApfhkdQ=;
 b=BG7nYPTlA42ZFLgGIh+EMycwXSNIvKGscfvm7peic8SeCvjhBsR1RMXPbEbDf9D6XJQKwYmFuP7L7/UH5kkyhMB+Ltuj165+qSm/ozXeYXwb/260OoN/T8adkdd2mz6XIAPslfYm6dWNMEb8taJs0rv6UQeAyX+J8KMgpBce9k4+giGPWc5oPpomXDy96AENsLG/D3Dlru6qDD8lrn/LSKDkN/jjNK6cZpnEsWd1KSmtA/rTsdtCZyrb4U5bEqH8J/VLyk0VN57VvPryaxEWRI1LYP+IR9Vxdwc+R5fziSHj/VZy7oRaJ3kdvEWK2tlm8gMFDwEG52focaNvSlehlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRJZ56YoUTvuwnJwcm5bn4VGar/vbvIBinjxApfhkdQ=;
 b=xecO6eAjXgUe9nAXkt8Tq1DmtFH/pBoyIi8p32jvjZ2KY98N41bXa3JftoVHNrHvU9UDLWiX5ew0BijLO/D+WhTvLDPJ4vfK9BvT+oRuHtJp/NzRxcZdwqDF6V5c6N3KY71XWFVLIBBHDy+2Qo+SoDLeuH7CMOzGG/U0sRqfKr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 21 Nov
 2024 16:11:49 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 16:11:46 +0000
Message-ID: <6091a584-989d-4dd6-8d65-e97a63055da1@amd.com>
Date: Thu, 21 Nov 2024 10:11:45 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Have kfd driver use same PASID values from
 graphic driver
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, jonathan.kim@amd.com
References: <20241111193323.278768-1-xiaogang.chen@amd.com>
 <6013a2b2-7e49-49e4-af90-8ea156a9722e@amd.com>
 <d8884052-8b31-4928-adfe-1f5dd5b09cde@amd.com>
 <e34a587c-a215-4212-a452-70afaeb89cb3@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <e34a587c-a215-4212-a452-70afaeb89cb3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0075.namprd11.prod.outlook.com
 (2603:10b6:806:d2::20) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e1068e-3de0-4b08-f01f-08dd0a473282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTFNTEFTMUdGaEdRRWhBQ0dVcUplSmtRV0VmMHpKeFU4NWpMUjR2UmhzR2ZQ?=
 =?utf-8?B?WDR1b01ST2NMbmRlbnNvZjRuN0FQSU5nQ3NxaHJIZFNqNkpSZTEwUFJ5T3ll?=
 =?utf-8?B?eXJPZXFUYWxPODE0Y3ZjdndnbGNvZFRKajV3cGJxWC9TWnFUbUR5dHBIWTFm?=
 =?utf-8?B?Y0R0cUJDZUMzeVRBNlZ4dmpkdDJEUVBLSjVBMjVLUkpXeEJzRkI1MUJZaXlm?=
 =?utf-8?B?SWNqRkpCWjMrWmtISVpBUmlHS09vNlQ0eWlIbVNMbGdzNE9wZEZaY3VKZ1BI?=
 =?utf-8?B?MGQrcFRTT1dlR0owbVpFRUh6MkdzR0pFRi9FVm9yR1k0d2ZpY21qZ0F4Rkw1?=
 =?utf-8?B?VkVJVnFtZkFydVh6aGlPcHp1c2R0MitJUTFEZkQ4RSt4VC9Bc0tCbXcydWlW?=
 =?utf-8?B?ZUFCYnVtNWVFM1F3U2hiTFpGWTNXYkhIYkZOK1dsejVDYm1HZFhvaHpwUlpy?=
 =?utf-8?B?bkwrMWRZZ2s3NkEyYXhKcjl1djI1RlNMNk1hTzhTYWFGdngyenIrZEZEMU5z?=
 =?utf-8?B?b244OTlWWUJJODl0ZXduT1lzUnlxcmVGZDYrL1RobjF4U3Jlb1g2dzJHZVh4?=
 =?utf-8?B?aXZ2OUR3NTFoUTVVZEZ1YTU4eVpWT1VsaG1iUU5JanpVcjRMaVN6YU5XdG9n?=
 =?utf-8?B?eFJUMnNnWTBlS1BwVTRJQnJsVTVXWWZLSGVJbVBlWDFGcUN1WVIrNm8vRTlw?=
 =?utf-8?B?RTF1d09QMzM3cFhVcCs4d0FKdGhlSWtUNGIwU1BLZDkvNVhWTzVSaEVnekEw?=
 =?utf-8?B?VXN2cjZ6bVA4T2NJTTRHM0JOKy9TeXFPT0Z6NEEvbk0xN2kwUVl0M2lXU0xG?=
 =?utf-8?B?RC9MZ1pSbVh5Vkg2YU5nVHBxa0tHY0h5QlRqemFFdDhyUlF2eWVSd3ZrcUtD?=
 =?utf-8?B?KzhGeWxJdUJ3NC90dWRtVHZvSS9iMklrQlp3bGVlaGMweGd5dmRUclU5ZE53?=
 =?utf-8?B?L25XMDJkMDczdkNXK1N3U3ZnZDBBdnlvNStSY05FeEtqZjA1YTF3SXQ0c1R1?=
 =?utf-8?B?U2Q0dDZsMlcwQTE2cG9WOWl4SEM4QTFGcCt6TmRGcW56bk5WOEUvQ29CWmo4?=
 =?utf-8?B?ODRQN2M5Z0h4YWY4OU5VUXFQdlhXWG1lZTB3TEhMVDVMSHY5UUV4K1h4SG5k?=
 =?utf-8?B?OFNzNWlEWUxSTmg5aHcyd25IejJ1d1E0RXJjMDFpZFFod1VPY2l4dTFVSXNk?=
 =?utf-8?B?RnAyR2NnL0xsZHlBNko5SVFKRjB6SkhCdFpWUzR4bms0eHczbUNsTlYzS0tG?=
 =?utf-8?B?cTFkbVlDWmc3QTVrNHlaejV4ZWtIcGxielY5R2c2WVhKbzUyeDU5N3VWZTFW?=
 =?utf-8?B?SVJJMjc2d09jdzBCQmp6TnhKakVUV1h4ZzJYRXdvYmZYMEltRFVmaHpuNFc0?=
 =?utf-8?B?YlFtQURsbjV1NXk5MVhScHA4SmNPWllHeThuRWJpTHJudGgrRGoxbSs5cXc5?=
 =?utf-8?B?aE43L3Nhekc4RVRwVHdrOC9IeUZ3UEZQV0d4UzM4N0d0b3ROeVFMZUUxQkM1?=
 =?utf-8?B?V0FxL05xczE1MXk5TzdmZktkK3lLRkVxdlJJR0lVZFRZeFpaQzJITjllN3lw?=
 =?utf-8?B?TkpDQ1U4YkFFLzFLQU45YWp1WGdKRXJiL2owQ0Q3TE9zN3p1V3llK3NiY1g0?=
 =?utf-8?B?RXRjVG55ZnlYQnJuRkxuc3NyRXVJTUVpMG5yR0ZvRnhXMVlRMUJwVlkxWmJ0?=
 =?utf-8?B?QTRFZVBJWk85ZGd4bENkTE5jNHdoZURVQVU5NTZXZEJDS0ZGT2tDcUwxamEv?=
 =?utf-8?Q?PUkRJP1Dy/sOXkYnK0ghggujW9HLB8rncuj//nN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDVoSHJyZFhQNjdSWDVQT1NXVHVpa09nZTJrMDBUSnUySzd3cTlucFI2QTE4?=
 =?utf-8?B?Y3Ryb1JaK3cxYnZPcUp0eExIdDFKaDArWWlxbEh2U3VGaS83VkhhbnlKZjZi?=
 =?utf-8?B?NGI2VVYxUDhSS2Z0SFBGWHVmRm9UL0Fibis4S2hWekVZbVJBdGJHUFpTella?=
 =?utf-8?B?OTUxd3gyS2tXSlNtbER6VHFScjg2cEl0MlhsVHI4NUZVME1hWU5SaFkzMHJ3?=
 =?utf-8?B?MjFOQ3FDbzhxZWc1YVVwVjhqNjZ0c3o1TmppRFROYVlPa0lBNEpSNHVKdms3?=
 =?utf-8?B?MTdBcmxxN08yeUwvKy9zV1JQbmFha29XRm5RV3kwbFFmM0tabm5JYjhyb3pq?=
 =?utf-8?B?elFmOTNrOEJyQklONW5LVktpSlh6LzgrS3JWSjJOaXZmakhSY3QzOFI5M1BR?=
 =?utf-8?B?VFF5WFp2OHFRaWxXdURyajdxbE5CYW92SW1RS2lwRm50czArZUs0Zm5lcmtF?=
 =?utf-8?B?anNDQ25BbTFJNW9wcXRBWUZJVUpqeENCV0t3bGRWd0ZvZ21vdGtHZml1QnNK?=
 =?utf-8?B?bTh5ZmloY3BqZ3dKNzl3YXJMS2VZbWVQREpCbFJVUGgreVZUQ0I5MjVnTGcr?=
 =?utf-8?B?ckdRekhZZFZsKzFTSExoTUFoU3A3VElsZGRTWUtvTU1IUXloWjNaSFNvWVhk?=
 =?utf-8?B?QXFBSjJERFo2QnJQdGt1cVZlRUI5N1VuWTZwTnVaTXVDS0d5eWFYREFmQWht?=
 =?utf-8?B?anBIS1VEYmtXZjhEekJDZzVNWld3TFRIeXZkbUI2NDRndVBZdWZlZk15eVRY?=
 =?utf-8?B?ZVhFVlJpM2JIZUJmclVEeGZvV2ZhSXhqNUdIZTIvSW5KcGIzelRPTElRYS8w?=
 =?utf-8?B?TWpyRkx6NnNYVXdkQitCWWdkMlpOYU9kbVFIK083NkQzalNJNm5FMXNISWx1?=
 =?utf-8?B?WHJxcndCZ1ZHaTJCK0ZDczF0YmcwVnF1NW5VUko0M2I3Y1VDaE9HOFhXMlZ5?=
 =?utf-8?B?Uk9rM2c2MHRsVUFzd0ZQQnRaYjYzUlZMaUxxQkF0bnBBNU85eE02dGZUMER0?=
 =?utf-8?B?UWUrbkQxSmhGY3hWRUVCUkNBenNVdTlBWWlmK2ZUdFJVZmY3TzZnWkpMYWRy?=
 =?utf-8?B?Q2dFaVkvZEZWYzZ4cHBmajZhMUk1WUhBcWswRjhRVVpNVzI4dTdFR0hldDcy?=
 =?utf-8?B?UEswNzU0dEZnZDFPcE84YXBSOEd3NkRadzRvcVFPMXNsL3dZQUNMMk9wOFlJ?=
 =?utf-8?B?cGMrZG5hK25pK0ROZlhjODMxUFNKVThLTTBGZGtPRTN4eWlpWUtQd3JaenpP?=
 =?utf-8?B?WndJRmpSOS9peEkxaVpzVnlFOXQ1WnhYUzN1QktXWnVpM1JCNDhyYnkzMHRp?=
 =?utf-8?B?K1FOVzNFWGU5NkFudjZkTE5PdHhGNklKbDNDTEU2QWZibnAvdmN0aW9WbE1i?=
 =?utf-8?B?dE5DK0Z0SlA4dGREWkpNYWQ2VElHcm1PS0o4ZzhjczlBMGY2VXRpU1EybGhv?=
 =?utf-8?B?YUZxK3VUb1pFL0dmQ256QnBHVVlQREc5NklicGdHQmpXV25xSkZDZkdaUjVk?=
 =?utf-8?B?TDk1M2FGL1pUaEFVYkJFeC9Mc1FOaDlaWWpCcmZ5TnR2TmdBQkcvc1VQQmk5?=
 =?utf-8?B?dWdSSGJsUFRuZ2tUcE5qdDN4aEs2ekNMODFoMUp4ZmFqVjAvTHI2RW9mSVV1?=
 =?utf-8?B?Z2Z6RjdIempCeXEyQ2g3WElPbGJIVnQ2aUhkOC9UYmFPNnhnKzdhdHNtQ2c5?=
 =?utf-8?B?TUxPa3A4N0g1WkJmam9SbmlJVVlLTm9LSE5CRjFuTWFLVHNhbGtwVDJCSlkz?=
 =?utf-8?B?NGVxd1dGZ3E5Z0VRcm1SOGlXd20zeFEvSEF1dmZPTGZ5dG0zR09oRU5JQzNQ?=
 =?utf-8?B?cTNia05MYjVyeDdUTVlGMHQyZnlZc28wbUI0Qkhsa2UwdTZNc1lrSkJRRzVr?=
 =?utf-8?B?MVlXSUdZeC9VM0IrOEM2L0Y4b3dON1R3OXUvcVJoSlkzSys1dFd0RXdCeXFy?=
 =?utf-8?B?OVgrSmhDNkw0c1BwZjlNTU1VVjNaZjhPSWFBUENOUklMdGFXMVNUNXVEOWNp?=
 =?utf-8?B?K1NKVFJjN0tPR1I1YWxaZVZjc0Fubm4yU2d5NkV2ODh5ZlJKWk9nMklYN3Zz?=
 =?utf-8?B?b25kR1AxU0I0VHRHeEs2dldmMCtkTzZORnhycjFxaFZ2bFBPSVdLS2JBU2tH?=
 =?utf-8?Q?FTdw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e1068e-3de0-4b08-f01f-08dd0a473282
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 16:11:46.4862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28WCgLJdJEy6xgYEXqhAMDRAPJnhY4PkmHxjC2Aj1PyJCfxT2RUSVLZqhC70Mt0E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396
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


On 11/21/2024 9:22 AM, Felix Kuehling wrote:
>
> On 2024-11-20 22:58, Chen, Xiaogang wrote:
>>>>    @@ -1822,15 +1804,20 @@ struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid)
>>>>    {
>>>>        struct kfd_process *p, *ret_p = NULL;
>>>>        unsigned int temp;
>>>> +    int i;
>>>>          int idx = srcu_read_lock(&kfd_processes_srcu);
>>>>          hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>>> -        if (p->pasid == pasid) {
>>>> -            kref_get(&p->ref);
>>>> -            ret_p = p;
>>>> -            break;
>>>> +        for (i = 0; i < p->n_pdds; i++) {
>>>> +            if (p->pdds[i]->pasid == pasid) {
>>>> +                kref_get(&p->ref);
>>>> +                ret_p = p;
>>>> +                break;
>>>> +            }
>>> I think this won't work correctly. The same PASID can be used for different processes on different GPUs because each adev manages its own PASID->amdgpu_vm lookup table. So kfd_lookup_process_by_pasid needs a new parameter that identifies the GPU adev, and you should only compare pasids, if the adev matches.
>> I think it is the main concern here: the pasid used here is global in driver by amdgpu_pasid_alloc(16) at amdgpu_driver_open_kms.  Each time a render node(partition) got opened, a new pasid value is generated. Its lifetime is until render node got closed. A pdd just uses this pasid.  And each adev has its own xarray which saves pasids for this adev.
> I think I had a misunderstanding here. I saw the xarray in adev and assumed that each adev allocated PASIDs independently. But there is also a global amdgpu_pasid_ida that I missed. If the PASID allocation is global in the amdgpu_pasid_ida, then each PASID uniquely identifies a VM your code should be fine.

We use 16 bits to generate pasid, so could have 64k pasid values. 
Suppose system has 64 total partitions and each process use all of them, 
in theory we could have 1k processes.

Regards

Xiaogang

>
> @Christian, we discussed the number of PASIDs consumed on systems with many GPUs and partitions. If the PASIDs are managed globally, then running out of PASIDs is a concern. Do you think we should change this?
>
> Regards,
>    Felix
>
>> Regards
>>
>> Xiaogang
