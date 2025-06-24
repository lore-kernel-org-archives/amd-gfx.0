Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA6FC77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 15:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 158C310E5DB;
	Tue, 24 Jun 2025 15:37:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U9rext9v";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B6910E5DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 15:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcyJuF+f9L6Wdp1aX1wntaNvf+qWOuEJlDJBZ60LdiL69QUiXCh5hrVp/7t1znYy6kIOi6HUDHPno03J0uNGeifA/J5GCBziWtizHt72lGWdAut2YOwy0DQc+oHyrXhogIi4M6kufEYLFnhj+FRquG1OqMrcKl1CTpKABxS2UFvK14mQkIelkYqv1taeHis8pEGARhGsuthOUQm4Bd2GLB76huGYsixea22F6NI/EMQ23HmUT+7RDPUBYWIzOGJ0seg38w+Eed+46DtgCWJYF8U91u4VARElGDg8WXybxV1OAM9MOlKVqtkfPmHBW/1BLOZtTiAVWqjgpcZxY5ck7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4MvaAaPsRLSdyrkTxT9fui3jcMG2QcTTQUU5wSV98k=;
 b=U7GirNxk6fLqcM6RV5c8P2pWWDzqc9wUB0z8o0ar29mnLcE0yb9UA51+Ji1WEP4rOd5gqmlUeAsTl20z5h37XqHJnCKtITI3IX2IAifpbUD0rC1qY+somqJcZCoVnrr3zcGgxBbGD4sRbJndD6V8NOukrpdx0mI5dHghKJk0UAhB7eTIEDJxLhu9gg0kBDGbMqi7WMbISv/3mAyfvNRkRDmdQbkoH5HWgCZcyf9Se1pWQnGZWx7Ss0fh3jVluMOhKBYDx1eFFw1omKWb9kxRb/Z3nXwZVvJba4EeQ4W3x7UxnSeTyxY8GYlH7vK9pDAlyjxDe00oHb9W8c7rZ2xKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4MvaAaPsRLSdyrkTxT9fui3jcMG2QcTTQUU5wSV98k=;
 b=U9rext9vQLmCzW4+LZmcQNnkKPnZKo4ZZJB2sPdqu1saU0HkIWXyXL1D4Lu9qz8s1SQUHeI5zJqIVdAtqxSXi3+cQKQZ3JXiu1XDimaRUHT5xFNQhCzu7CRv76ATRE7KuPLWn540lgqViok8jntyDHvsT9OaVsZSiXc4cCOCmm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.17; Tue, 24 Jun 2025 15:37:51 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 15:37:51 +0000
Message-ID: <c5de58b9-d71a-4a4d-8027-8e7cad34ab20@amd.com>
Date: Tue, 24 Jun 2025 10:37:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Don't call mmput from MMU notifier callback
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20250623165936.6178-1-Philip.Yang@amd.com>
 <77dbf577-d767-48e6-b087-61dfcc478c22@amd.com>
 <0212b140-0c83-71e2-a0ab-f925b2125e98@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <0212b140-0c83-71e2-a0ab-f925b2125e98@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0060.namprd11.prod.outlook.com
 (2603:10b6:806:d0::35) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 824db038-4440-45f4-0694-08ddb3351449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S09hVjU0T1FYVnJUdXJROFJ3a2MzRERSY2VYZTR2ZDZGU1djMzRZeXV0WDY2?=
 =?utf-8?B?Y29zaWpxMU1ObXBIUlFoWlFEcFZHVTZLYWNBWnpZK3BPNWI5cnRVK1dZSUpI?=
 =?utf-8?B?Mm5WeDJaYUJ4SzhMZFd2RmhRamtJYjZWSk92NDd0NThXSFVVZUlCcENKcmpV?=
 =?utf-8?B?OSt0SFQ3eFlNOEd5S2tMTzRaRUcwaDgraFh0alI2NmZPYkkzalNtMzNMSXhs?=
 =?utf-8?B?Si9wa2lGODZ2ODFySUZ5QVluK2RMNjl4djJxR2hYQzJuaUtVeGw2bU9oRm8v?=
 =?utf-8?B?U2ttZGpkaHZSQjJJZDZjTU1rQXZzcGJiVmxaUGEyL2JQT0RzeXZpZTdIeERx?=
 =?utf-8?B?ejlUdlhvVmJpYkJaY1ExM3hRWUUxOWQ1bUtndUdRRGtYYnc1VmNMeHhFa1Bo?=
 =?utf-8?B?YlIzRXVMOEpzNGxkOWNxZVlhZ2VLWjRQcFBFNnFoSDgzdlVRV3JwNzlyWmlQ?=
 =?utf-8?B?cmROVVpuY3NGZTJmTWMxWURDdnlUVzlYcTJLNkhrc2VhY0dmd0lZNDRMdWxX?=
 =?utf-8?B?Qlc4WHRZQnZOcy8yK09VM2NvTnFnSVJjTXhWcHI5N2c2dGQ2Y1RGSWI4dER5?=
 =?utf-8?B?UlI3bzJoSWU5U1BqVVI1THVyMU9kM3lORzE0MDNhQkhTaGQyYU9iSHRQVnVQ?=
 =?utf-8?B?dUppNmVIZ3RKWlpSSDV3RnZMc0NGVERTUm5DSDdHdXhDVktlMlMyQ1I3ZTZR?=
 =?utf-8?B?M3h2aW5Vc01rUTZXMVJuTGlPcXhFRk8wcHJXL0VkR2t3ZzlnTEJ0U25RZDdq?=
 =?utf-8?B?eE8xcnZtd1hMaFJrUE41YTBLUTNlY3IwaVdiSVF0d0VySmt6bjZSUU4zRGo3?=
 =?utf-8?B?UEx3V0h1QmIyczF4ZlBGVUhSbDN1UFZ1Z1RHeGNIVy9XYTRUNkJJeEJHbjYy?=
 =?utf-8?B?YkFRUXhFRllwdTdyUGQzRDJybzg5dGl4eFRGQ3FEV1ozREt4d2FvckJab2pi?=
 =?utf-8?B?dnRSTWxIRVRmNHFVVGVteE10REhNcjAvWUpZWno4eWwvYkxNRm80UE1xQjh5?=
 =?utf-8?B?NTd6QXJxWVkzWjNMV1FJVlcrS3k3cktzQXlNNXFSU1ZsOFdGNjlGdGpWYmdi?=
 =?utf-8?B?VmtyNlFMOTgvd0dvUG1CWUFSSWhWVzZJWjBJUm16L0huVi9WbnowYlhFQ3gx?=
 =?utf-8?B?RWtQUzcvV2tNVjFPcVVjSFNtd05kbTc3b0lhZUdLbG1EZzlkVzlJWERFSGJI?=
 =?utf-8?B?UlN3MEJsbDBRNExJNTNZSkU2UVorR2k3a3NCdWdldk14WndBZ25sL0lVSnB4?=
 =?utf-8?B?bHJNRnV0Zm1JSTNKSlJRR2RzRllaYzVzTU4vTEZ0R0pSRlR3YXZuRVNLdjFk?=
 =?utf-8?B?MTJKTTFSemh3WnJqZFJSV3NxN09BaCtwZFZORUd1R2xHNE93MFh5T0RKSWJw?=
 =?utf-8?B?R0VYV1lnOWxXOW80TU1GaS9qN2ZtTGY2ODQweWowYlA3RlBiOXFPM1g0azZi?=
 =?utf-8?B?YVFnUEhyTWV3NFRnQ0dTSmZFWDRkajhWaFp4bDFyTmhZTlB6N2lMVDdna3NG?=
 =?utf-8?B?RWdlcGtxdmNmVXhLbyt4eFprckpPWkcvS3FoZ0RNb0VUZjN3K1ZIZ05zUm1v?=
 =?utf-8?B?MG1BVWNSdXJUTjVwTVZHcWZCU1FwZktBYndmZ1RxSGF3dWYxVWxQOWl4djFy?=
 =?utf-8?B?MGloOFhpT3o1TXlrd2VRR211cVNuUHNCR1RDVlpObitsMlFkcWtBS1dYUTJW?=
 =?utf-8?B?UUxLN21lRDMvQklFamcrYzRXdzFSa0hkQ0FJRU41SjNXODFzUjB0VnJiNWk1?=
 =?utf-8?B?MzBoekxlcjlQUldVZlZFcGhLTEw2d1QyMmdhOWZVbGdDU29pQnpIK0kzWDR0?=
 =?utf-8?B?MC9UditScG8zOUVZNGNRV2hOZ2pxVGtEOEZBSk12N2liN29kMVRTTlZTekZW?=
 =?utf-8?B?WGQvTmtaMzZsRHhYaXcrVzFxUHljNG5lS0ZMbnJnakYxcEIxekc4MXNvQ2cw?=
 =?utf-8?Q?ab+6S57xitI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enczeDhkRXFwZ2EzVzl1dmppMmI3VTBPR2NPU245VVNRUDVOdWc3RUthQ0ZW?=
 =?utf-8?B?SUFhMHRnMERINWp3VjlDbG1yYWVMVlBvWm1CYlZNVjVKdkJ1MGVVZnlHeFlC?=
 =?utf-8?B?WUdGZ203K0hsZWVLdnp5Nzlobitkd3BQZzJFVzVsTDJOY3dPMFVnVld3TVZO?=
 =?utf-8?B?TlFDNHkwSXdyVkZWTmo5YXFvTHkyZmNWQ0h6M3pNNm1nSzF2OUs5UzhSTVRa?=
 =?utf-8?B?Y2hLTmpxZVdLcmMwcmlXR1dtdGxnWGJ1NTM3aW5FcmErcDM3UW9EKzc2U2pU?=
 =?utf-8?B?N0FDczFSaDBMVWFKcVBwZWlqNGJBbFVZeUc3OGR1dGhvcXlEdGxLSlg5ZSsx?=
 =?utf-8?B?SlBDSzFmVW1MQlI5NHlzVzlyTE9pZ1I4Q1RZYlBHcmw3V3U3QmdwQzhMSEg1?=
 =?utf-8?B?VHBDSHp3UU1JdmdjN2RlY1FQM2o3Rk9ZeHRRRGo0ZXRUeEZDRGJPTkJXR2d6?=
 =?utf-8?B?N1c5dFBwRUdKMkw4aFM1NDNCcEMwQVBxZndrTnI3NFVQWmIyTGVCL2lKektn?=
 =?utf-8?B?LzkrSnJFUDNBNHMwRmdZd2hyRURRYjNTckNPOUc0S2x0SDFzRnhsc2RPWFBJ?=
 =?utf-8?B?VVMyd1MvWGFKTDVjQXo0S1JRYldVU2ZhY0pyOFBXdEMvcUMvcFFsTC9YSnF0?=
 =?utf-8?B?SE1wNURwendwVUpyeGpFbHNhVGFVeVB3SjE2d2ljbDZXNktFRExZRHF5VTVE?=
 =?utf-8?B?ZjdXSU1rdldyZTJZOG5ML1I5V2QxNUg1REZoL3NDTy9IZERrQXZ0bUdWUkg5?=
 =?utf-8?B?L3VMaHZEUkl5Rmh0U1hUOUdHQmJxOXN4QXVPbm9Jeld4MzhRbVdTYSsySkd2?=
 =?utf-8?B?WXBZNjVPL2RIVmhaU1ZlenRycytZaGtDdkRCdnFtNFNqSnZuS2xBc2k0cTVw?=
 =?utf-8?B?RDBNYnBMODR1VTdidHFZa3lhdDNJUEEwNnBwN2Q4Q0E5cXlUVTBuOGZWNGc5?=
 =?utf-8?B?NjVMSnJVa3F4ajZlM0RjVkhDM0VGYVM2VUNNTzNnZ3ZJL0NXL3o2RUdIaTRN?=
 =?utf-8?B?ZExUWjQ1TWtCVDlsY01DMDJhWTExYTI5QkFyTTJiMCs1UnA3MVVPdHZOaDBM?=
 =?utf-8?B?OTFzTGNZdVpQOVkvaVZJOGgzVm9qSDZrd0ZlcDdUYmJHcngzMEd1R1VlQnJ2?=
 =?utf-8?B?RlFJUENQYmk1dzIxK2FYM1hidEVRaERpakhuVHNlMU4xMEpSRS80MTloSFYw?=
 =?utf-8?B?cmRrU0ZhZEtRN0ZaSHZlQkFiTHNyQS9wSFpxemRFTjU5NXBSeExNVnFiMnJt?=
 =?utf-8?B?WktJdjhMZEsrbWxFV3pVczlOMXdBTGREcU1jcVhLbGhoUEdZT0hsZTRHem03?=
 =?utf-8?B?YlYwWkQrZzVDWmJ3VTBCeEM3b21Ed3cxVVJ1OXdSdyt3azFrenNZVzVlTG55?=
 =?utf-8?B?KzAvcTU0L2hQZjBXSHRENUVIc1huWkhJVEIvaldEcGNlbWNQWnk2MVBIdU00?=
 =?utf-8?B?Um0wT0xtcTBCWit5cCtlOFFQZHoreG5vMVpMNnRQWHVXaWZkbW5GUlFOM00x?=
 =?utf-8?B?dnhSeGNmZFFVZ2F2RExsazFkcW1ZL3pMUXdBcXVEUkU5bURpUmoyM2s3Q3lX?=
 =?utf-8?B?dDZtS0w2cUxsbVVSVGtBWkVCQ0JZUnJnM2VaSkZNL0p6TnBPS2JoY1Vnak43?=
 =?utf-8?B?TmluS3orMHVkVnNhdzllY3UzRUpjWkJveExaa1FTcnZVd3V4ZzB4Q00vZnhR?=
 =?utf-8?B?d3FoeXdNQ0VRRVQ1eVNxMlNVM3JURFdaeXRDUjcyb0UwK21MdEhlY1duazBR?=
 =?utf-8?B?dUtmY0ROZUVjOEdIbmoyWkdvUS9nRXZkSGhrVkM5dXBKd2pBK3dxQTk3d3FE?=
 =?utf-8?B?TE5UeVppcjEwUnk4YmF1RitXMHhQZ050WU15cTJjVWlEMHVvQU95Z3dQb2tt?=
 =?utf-8?B?Umt3MUo0cXdXcUFHdlZNOW1nN2FyWTRuSkkwUjNVcUdKNlNGbG40dXJvOUhu?=
 =?utf-8?B?ZXltWVZJRGRHR3p5aXZDRlNGak94cEJmMDUxaWRGdFdSM0dKRlJVb0U2NDRJ?=
 =?utf-8?B?M3o2akIyenJiUTZGcnlIdlhMQVR0U2pCMFFsL0EzcDRCOU1SMGNQZERpQ2I5?=
 =?utf-8?B?aWVKTEpGMlRTbDVYV2VWeTI0azZnSzZ5WXl3UHB5bjltak96Q2hzTGwxSHNV?=
 =?utf-8?Q?hhMM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824db038-4440-45f4-0694-08ddb3351449
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 15:37:51.2896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2A5mzDcqeNr1b3qM/VoLzkUG/twtII77dWux0tJOEm6QI+LaDmYIUMekaWfkqj4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742
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


On 6/24/2025 10:00 AM, Philip Yang wrote:
>
> On 2025-06-23 18:18, Chen, Xiaogang wrote:
>>
>>
>> On 6/23/2025 11:59 AM, Philip Yang wrote:
>>> If the process is exiting, the mmput inside mmu notifier callback from
>>> compactd or fork or numa balancing could release the last reference
>>> of mm struct to call exit_mmap and free_pgtable, this triggers deadlock
>>> with below backtrace.
>>>
>>> The deadlock will leak kfd process as mmu notifier release is not 
>>> called
>>> and cause VRAM leaking.
>>>
>>> The fix is to take mm reference mmget_non_zero when adding prange to 
>>> the
>>> deferred list to pair with mmput in deferred list work.
>>>
>>> The backtrace of hung task:
>>>
>>>   INFO: task python:348105 blocked for more than 64512 seconds.
>>>   Call Trace:
>>>    __schedule+0x1c3/0x550
>>>    schedule+0x46/0xb0
>>>    rwsem_down_write_slowpath+0x24b/0x4c0
>>>    unlink_anon_vmas+0xb1/0x1c0
>>>    free_pgtables+0xa9/0x130
>>>    exit_mmap+0xbc/0x1a0
>>>    mmput+0x5a/0x140
>>>    svm_range_cpu_invalidate_pagetables+0x2b/0x40 [amdgpu]
>>>    mn_itree_invalidate+0x72/0xc0
>>>    __mmu_notifier_invalidate_range_start+0x48/0x60
>>>    try_to_unmap_one+0x10fa/0x1400
>>>    rmap_walk_anon+0x196/0x460
>>>    try_to_unmap+0xbb/0x210
>>>    migrate_page_unmap+0x54d/0x7e0
>>>    migrate_pages_batch+0x1c3/0xae0
>>>    migrate_pages_sync+0x98/0x240
>>>    migrate_pages+0x25c/0x520
>>>    compact_zone+0x29d/0x590
>>>    compact_zone_order+0xb6/0xf0
>>>    try_to_compact_pages+0xbe/0x220
>>>    __alloc_pages_direct_compact+0x96/0x1a0
>>>    __alloc_pages_slowpath+0x410/0x930
>>>    __alloc_pages_nodemask+0x3a9/0x3e0
>>>    do_huge_pmd_anonymous_page+0xd7/0x3e0
>>>    __handle_mm_fault+0x5e3/0x5f0
>>>    handle_mm_fault+0xf7/0x2e0
>>>    hmm_vma_fault.isra.0+0x4d/0xa0
>>>    walk_pmd_range.isra.0+0xa8/0x310
>>>    walk_pud_range+0x167/0x240
>>>    walk_pgd_range+0x55/0x100
>>>    __walk_page_range+0x87/0x90
>>>    walk_page_range+0xf6/0x160
>>>    hmm_range_fault+0x4f/0x90
>>>    amdgpu_hmm_range_get_pages+0x123/0x230 [amdgpu]
>>>    amdgpu_ttm_tt_get_user_pages+0xb1/0x150 [amdgpu]
>>>    init_user_pages+0xb1/0x2a0 [amdgpu]
>>>    amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x543/0x7d0 [amdgpu]
>>>    kfd_ioctl_alloc_memory_of_gpu+0x24c/0x4e0 [amdgpu]
>>>    kfd_ioctl+0x29d/0x500 [amdgpu]
>>>
>>> Fixes: fa582c6f3684 ("drm/amdkfd: Use mmget_not_zero in MMU notifier")
>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 +++++++++++------------
>>>   1 file changed, 11 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 10d1276f8e1c..5fe92f9a1ce1 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -2392,15 +2392,17 @@ svm_range_add_list_work(struct 
>>> svm_range_list *svms, struct svm_range *prange,
>>>               prange->work_item.op != SVM_OP_UNMAP_RANGE)
>>>               prange->work_item.op = op;
>>>       } else {
>>> -        prange->work_item.op = op;
>>> -
>>> -        /* Pairs with mmput in deferred_list_work */
>>> -        mmget(mm);
>>> -        prange->work_item.mm = mm;
>>> -        list_add_tail(&prange->deferred_list,
>>> - &prange->svms->deferred_range_list);
>>> -        pr_debug("add prange 0x%p [0x%lx 0x%lx] to work list op %d\n",
>>> -             prange, prange->start, prange->last, op);
>>> +        /* Pairs with mmput in deferred_list_work.
>>> +         * If process is exiting and mm is gone, don't update mmu 
>>> notifier.
>>> +         */
>>> +        if (mmget_not_zero(mm)) {
>> If process is exiting we not need do schedule_deferred_list_work 
>> neither. I think this part code need be reorganized with 
>> mmget_not_zero(mm) check.
> yes, that is right, we could change svm_range_add_list_work to return 
> true only if new work_item is added to the deferred list, and schedule 
> deferred work. This optimization could be another patch, not related 
> to the deadlock issue.
>>> +            prange->work_item.mm = mm;
>>> +            prange->work_item.op = op;
>>> +            list_add_tail(&prange->deferred_list,
>>> + &prange->svms->deferred_range_list);
>>> +            pr_debug("add prange 0x%p [0x%lx 0x%lx] to work list op 
>>> %d\n",
>>> +                 prange, prange->start, prange->last, op);
>>> +        }
>>>       }
>>>       spin_unlock(&svms->deferred_list_lock);
>>>   }
>>> @@ -2568,8 +2570,6 @@ svm_range_cpu_invalidate_pagetables(struct 
>>> mmu_interval_notifier *mni,
>>>         if (range->event == MMU_NOTIFY_RELEASE)
>>>           return true;
>>> -    if (!mmget_not_zero(mni->mm))
>>> -        return true;
>>
>> Why remove mmget_not_zero(mni->mm) /mmput(mni->mm) here? I think they 
>> are for different purpose from mmget_not_zero(mm) at 
>> svm_range_add_list_work.
>>
> Yes, the mmget_non_zero/mmput inside MMU notifier was added to fix 
> another issue that deferred work access invalid mm, to ensure deferred 
> work_item.mm hold mm reference. But in the backtrace case, mmput 
> inside MMU notifier callback release the last reference and cause 
> deadlock.

You have used mmget_not_zero at svm_range_add_list_work to prevent this 
deadlock. So mmput inside MMU notifier callback should not cause 
deadlock now. mmget_non_zero/mmput inside MMU notifier is used at up 
level to prevent invalid mm being used in all cases. They should be 
still there.

Regards

Xiaogang

>
> Regards,
>
> Philip
>
>> Regards
>>
>> Xiaogang
>>
>>>         start = mni->interval_tree.start;
>>>       last = mni->interval_tree.last;
>>> @@ -2596,7 +2596,6 @@ svm_range_cpu_invalidate_pagetables(struct 
>>> mmu_interval_notifier *mni,
>>>       }
>>>         svm_range_unlock(prange);
>>> -    mmput(mni->mm);
>>>         return true;
>>>   }
