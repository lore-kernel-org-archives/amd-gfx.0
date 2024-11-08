Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0472DD5E14A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 09:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A44410E94A;
	Fri,  8 Nov 2024 09:24:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l4srksNY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA72E10E94A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 09:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8n/WOoxH7LgoDr7OtX+93kQLByrlGCD5mmQsXHU3VTfyZMOrY8EVaivHNyDYhW47MiyxVYi925VN5cwjiAUzy3N3KlmNKFPSI8GC5nhelvflJ66L6TqLbT7g16xWtHkXvbcdZKb504TXm8NbsxZfuLM+f0VZbrgmbrc+IFb/oEs4ORoaUzH4IUrbxg1wfJZnaKrSaYvh62W2hKkmhccb8wcXRPT7kYeaD02294DVbrApYt7QHUu+rfGZF4IgLD5RrCvMGx4cRoiU2EWryK+S9lit5qLM0HisIRxehdqtEAE4Tgi4PPuJuPKfBoSbo7UmmnfySVW4Oc+mxZ9TelzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbAHSLyk1hNQ8mfi8VZbjHgVn8BRdjLIBcXdw7yBg9M=;
 b=jbqyW5ETLtSOAF2hoEH7/7+6CmPmbmd9qTl6mChbQITikN8Tg53UehIe7mcSPyVuMbL9Xeq3M53yXo4U0GTuFlrpC91uMMYljqH4oBOn0HAtDQIbF3bnXp36PeeUBq1HPVI5dAlRRb7AqE4Of/nCxiBaOdIZekfzUpEMrvBakvokIKWOzdULMFhhvy5MiVbe1X6cHBUDu0yni/CYAihkaEgNY5w7ClpX7BdCcoy1nlu0m+xWTpCHzZygzdBbLA6nvEyGrlu151iE4CREKZF5Ws9pkYhhhJvPa0P/DoqHZzBfpuECMImD33Gop+wqplHviVbCclVGmer94K5iDqYL5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbAHSLyk1hNQ8mfi8VZbjHgVn8BRdjLIBcXdw7yBg9M=;
 b=l4srksNYQP5OLd9nDTowCBP9e87tfuujZgCpZy0F2UttTa3tfMJUgwQr683jCbc93wGjvp+h2+97WSP2W9wRVVh/lFVTy5qFl1T6tC4krxWjInWT+ZHRVj6tSce2uOwnQpLN8TBWKTy9geqIunjMP1db7eibkW8AupIwaZI5jsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Fri, 8 Nov 2024 09:23:56 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 09:23:56 +0000
Message-ID: <62872043-100c-4164-b167-d8e4e67b811c@amd.com>
Date: Fri, 8 Nov 2024 14:53:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix warning when removing sysfs
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
References: <20241108022148.588761-1-jesse.zhang@amd.com>
 <a3df1093-598b-4d05-a403-4b5b3a4715ba@amd.com>
 <DM4PR12MB515268BFD84AD610E285A86AE35D2@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB515268BFD84AD610E285A86AE35D2@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PEPF000067F9.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::30) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 7421b3c4-19de-499d-cf6e-08dcffd711d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFBlSSt0RnJEV1I1cDltQlExVzBrdGZSNlg3eEVZSGxaT1ZKdXE0ejU2b0NL?=
 =?utf-8?B?dVExTmZJd2tMOGhmTEZDcFczcGdhdy82ZFJpQWxGenJwcklKUjl0ZHNYZEEw?=
 =?utf-8?B?R3VNUGk2Nmw0aFZPRENoV2g0aVB0Q3NDeVQxL0FzdkVwWkdZWVRGSG55cHo1?=
 =?utf-8?B?b1VNVFRBaGRhMFlmTEpYbFFkYndXTnBCQllLcmM4OVBtbmd5RE02VmVGTWpB?=
 =?utf-8?B?UTVaOGRTWU1XRWljWk40VDNtZEdNSUVpUmtpUSt5c1hIYUhheDZHNXVJdnhQ?=
 =?utf-8?B?bnhQc3VuVVlHK2lkRFJ3SGpWTTUyYTZVZE9sSzVZTmJ1L0FiR3pwQlRzWE5Z?=
 =?utf-8?B?andVTUY0QnVFYUNjNVNRYS9UQndLNTFXM2o0b1dDRWozbFF5aUY5bkxGcFEz?=
 =?utf-8?B?WGgwMmlMNGNYdTRzcnpzZGZ1UU9HR3d4Q0pjR0ZyYzhNc0Y4VkhTK3I3blRY?=
 =?utf-8?B?eUxzWmRtZEF5Y3lWVlk1dnU2S1RnSjRRZ0lWd0h0aThSQ3FaRy9pUnNxRmlq?=
 =?utf-8?B?S2YyeTViQ0FXT043SE9aNFdMYmluT3VoSnBIdXJQTTBaeEhsRndtMDdxbjY5?=
 =?utf-8?B?eTM0TVVjNldaVWF3REV5VGMwbFRoenZGcko2eEdsYjBUeGNNU1o0MnloNHAw?=
 =?utf-8?B?UXZNaXk0QkxBeGUyMEJuZ3pxbG9yRmllMlZQcXk4T2VXNE5MSVJPaURNTUdG?=
 =?utf-8?B?NlZFNVRvQWNEOTFWeWNvd2FnR2Q4bTVVRnptWWhTK010ZDdFS1NHMVRybHhR?=
 =?utf-8?B?STFQaWFGRnRGUGdYTEErWkdWRVJBMTFBMEhPMDdzT2tSbzRiU2JjV25tMm9R?=
 =?utf-8?B?eE5ScHhuSGc2OVZMZ3RNMER1OXRGT0JLc00yWjdiZ2NoRURjWm82S1NqSUJ1?=
 =?utf-8?B?eVBnek1jV3hHWFcyZktTeGtvY2VKaHF6OVZKeGlpNGVKa1ZIanJXYlZSWkpq?=
 =?utf-8?B?dWRnaFRWWnNkV0VwWlJEOG5nVC9uREtxRmhDNkQ3akltNWdlRXI0T2lnSVJt?=
 =?utf-8?B?M3FMUU1DRjdVMzNLeU5SU3JGdDZsTUcrMzQ0Ui9JWU1NczJoTEY2NzlCWU5Z?=
 =?utf-8?B?YmJjQzljbzdxRXU0d3RkSm1wekNqM3F5eVgyVEY5VVlmbzJCMzVEK3lqVkRM?=
 =?utf-8?B?V1dic3BWWTRlMkdVa1FKdGZpS2I1bkl4cTZlZHJWWXVUZzFaN3JnSDl4NTRp?=
 =?utf-8?B?UmNyeFYxWHhGMlo5Zk9wbEF0R3gwMGk4cHJZV2RwLy9TU1U2elNrSHE3eUtu?=
 =?utf-8?B?ZTZkU0JFbnVzanBqd2dmZDFxRGJEOG9VZDRPa2RYK2JuaWdTVWFkY3VhSFht?=
 =?utf-8?B?d1RDTEkyam93ZEx4czk5bEdxVW1WTHVsZjZBQ2R1UWV1ay8xV2pyaXAydTNx?=
 =?utf-8?B?bVYrVGJCWUlmdGt3T093b3NybVNJQ1BxM2RCamp6Yk5ScG9RT1VudDZSZ2Fy?=
 =?utf-8?B?RW5lUk5tdmM0TVpKakpoWVNDVDFjVTNNWS9HUjg0dk1UMUJuckdkcS9jbXlV?=
 =?utf-8?B?VGgrSVYvdW11K2xadWVZUkZ3anczdVZJY09hUkdsOUY1aUxDdnczdjZjVGtj?=
 =?utf-8?B?V1g0cDJ1bzVLQ1R1R0wrazg1akpLYU9od0JUb2kyNHp6Yzg4ampibVpONSsv?=
 =?utf-8?B?cHlGMk1BWnJac0o1ZkRaNEd0QkhsQi9MakZsNkJzTmVjU1NIMDFGamVmZDlz?=
 =?utf-8?B?NzBpcHJWTW9CU1BKNG1lT2JqOHJNWXZTbDB2NC93ZlB6VUJDdEJ2Sng1WXJR?=
 =?utf-8?Q?F4/yVFHP4XRlZ547NuZLMg4Ot4++RFiFwzNJGBb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1JLWjhKS3ZOTlE2YW1RNDBXU3M4RzJKRVMwZWFTQnBLdFU4RHhyOTNMSFFF?=
 =?utf-8?B?czhEMCt5Y3drOTg2MFVJREZNM0lJTGpsci9GNTZVUFdoNk5sSFFIbFkyZTF3?=
 =?utf-8?B?ZTNFc282NDI3WStqRC9LSGhXMXVidERmMjFnWVFnZjdOT3J1VXU1ZzNyWUxO?=
 =?utf-8?B?T3Z3OERMSTB5a1IxVFhVdGxwOEs3cU5FQ0pqUUpVa0FiYWFUd3pKdm5oSGxB?=
 =?utf-8?B?NjdYS24vVHJ0TkhJMmtvYXBBOGRkT0JRdXpCS2RhV04xYXhNREowV2F5SHQ1?=
 =?utf-8?B?cnF5b0V2dFhHaWVpY0lHVTZNc2VFWGd3L0xYS29FbVFHRVlqZGNFcFoxREFF?=
 =?utf-8?B?RGI4Z1RIaHJSV1lGRFpaOFd5TUQzTVlaY09TRUpERXhyZWlnZEFuaC9xQStG?=
 =?utf-8?B?YWZGRk5Rejc1MDZuSnRZMHlPUFpONmpuYUpDVjJPQkxkR3VYU3BiU0tGVitQ?=
 =?utf-8?B?czhGV3ZNREs1RjBtd0JObzVxa09jT0VobTRWZ0dqaGI3ckxEdTM1ZVBxV0lM?=
 =?utf-8?B?VCtBU0djdGVHbUQvd095b2lEYm9hMHVmS0VDYzVlZEU1eVgwemNJc1hIeGhV?=
 =?utf-8?B?Unp3bWZSY3NBWXo2OTBweHkvWTFSVlVCdlFyRlNsT0d0TEpBZGsrMnNBSE9n?=
 =?utf-8?B?RkpkYTFKcVR3SlBGL2gwZTcyQ0VSR1FsOWlVMUVtNmNxczJCQWZnZ21aV1Fn?=
 =?utf-8?B?Q29IUUpxSi9YU21VR2N2T3ZtMnNmYUtuQTJsZXVtOVZESlpodndVZ1B5b2Fv?=
 =?utf-8?B?dEtiQVVHblcxZ1g5K2JYNUlIL1lRUVpIWXpUMCs5NHhLY3JYcUtFMCsrRlVm?=
 =?utf-8?B?ejZsb1hPcXlqUGNTVm45clRIdjl4Nm9iazMyajRsSHVubTFYa1kvUzZ3SjYx?=
 =?utf-8?B?N0RST1FvK2VneHArYkRYS05XWHFHSkUzMzhYRnVtYzg1MkVQN29ZcmY3RXlw?=
 =?utf-8?B?VXJyUTN5UGJyTzdJOU1PeWxBVEZVeWNId1FPV1lUa3JwRFdVK2M1QVBWb29i?=
 =?utf-8?B?U1RudEJTWVgrWG5kL1o5cUVMU1h4QnkxVXlGcUU0QlZrY1ZLUitQZzBGc2ZK?=
 =?utf-8?B?UWJsNG5MYUpEeVM2MHg2THpmUGgyNFFKWWhjYjZZVysvZlZKRERmdUIyajR3?=
 =?utf-8?B?NDdTWWF1Z0Z5Z25wUGFMUUJldDV6SEQ1ZWRIU21EVWhyRWRyaEhoUFJVN2tR?=
 =?utf-8?B?ekV1b1ZWV3pKaFNQSytueXZNaFo4bkxNQkpSZzNIRGx0TzBaMkwzcmFrWDJ4?=
 =?utf-8?B?TnVhdVNEZ2E4LzBtWmtLVStyQjVsYUdKcVptQm1QeDl2d0NsM3BBSmtLUllw?=
 =?utf-8?B?MVFNZXFBeEZaSUduWHJCTCtmMSs3U0YvSVZLcEhiN0FKR3hlaGxIaENHSGpP?=
 =?utf-8?B?c0tDaGF1WGM1c3pySmEvK08yRytnRDl5TUxYOFNoY2s3TEZndTZMaDRtSDFl?=
 =?utf-8?B?Nk1WK1prblN1dVdCY2pkOC9sZUJrSzBHckt4VE5GOGRoVXdBdjFqeW1pdWpu?=
 =?utf-8?B?TmlvOEZFdCtwaWdEa3hXS3NsSUIyK2x5MUgwSjRQc3VtbFNwbVVnckt2NjV4?=
 =?utf-8?B?SXM3SFYzeFR0TWlyYTNLQ3llREJLSndIZGJ0b085cFJ4MVhyb0pHZVlhSklF?=
 =?utf-8?B?dlUyaGJPTzdoSG9TWDhTdWVPOWRMa2d6aFhOaFI3V2tERjBhZ21MQnd2ai9C?=
 =?utf-8?B?NjZ2alp1aWo4KzRMM1N5WXFQb0gzamZKejRhNDB4OUpPZjIvQVFucDZHcm12?=
 =?utf-8?B?NzNSTFNsMnRFdy9uSlR0ang0K0FOZHRkVUtMemMweldhMHN2TUo2M3BDem5M?=
 =?utf-8?B?VFVmM25EZGlHZGVSUW9jblRZdkFXZzA0MjJ1MHpINjRQTnNFV2Q2ZUN0SExU?=
 =?utf-8?B?NHN2eTBoZ3ZoTm9CTFA2MytzcVh0dnV5N3ZvUE9RakRQM21ZWDJ1QzZpcnc2?=
 =?utf-8?B?a0xmaXhZN3VEUWpOelhiaTFuVkI0TGRpL2Q5T2RjYVpuelFtVzk5dDdEZ2o4?=
 =?utf-8?B?T0k1VkhiZDZGUHZwZjJrT3o1YUhpZlUrT3FZZGRTVm1zRGozU1BOcUtTeGNu?=
 =?utf-8?B?MTBnSUxXYmlvTjF4Y0twRklXVEhaODNYM3RJdjhDOFM5dU1JeWNmK1hqT1lI?=
 =?utf-8?Q?MyHs9gqg/TzEFk0jbjm+Wf/DX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7421b3c4-19de-499d-cf6e-08dcffd711d0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 09:23:56.5011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61UQ1Db38Yum3ll1de98gbEn6IS+767ow/utJFkKEuAOKiY/64KFDWjDhI4INVy2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242
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



On 11/8/2024 2:45 PM, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Christian,
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Friday, November 8, 2024 3:51 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: fix warning when removing sysfs
> 
> Am 08.11.24 um 03:21 schrieb Jesse.zhang@amd.com:
>> Fix similar warning when running IGT:
>>
>> [  155.585721] kernfs: can not remove 'enforce_isolation', no
>> directory [  155.592201] WARNING: CPU: 3 PID: 6960 at
>> fs/kernfs/dir.c:1683 kernfs_remove_by_name_ns+0xb9/0xc0
>> [  155.601145] Modules linked in: xt_MASQUERADE xt_comment nft_compat
>> veth bridge stp llc overlay nft_fib_inet nft_fib_ipv4 nft_fib_ipv6
>> nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject
>> nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
>> ip_set nf_tables nfnetlink qrtr intel_rapl_msr amd_atl
>> intel_rapl_common amd64_edac edac_mce_amd amdgpu kvm_amd kvm ipmi_ssif
>> amdxcp rapl drm_exec gpu_sched drm_buddy i2c_algo_bit
>> drm_suballoc_helper drm_ttm_helper ttm pcspkr drm_display_helper
>> acpi_cpufreq drm_kms_helper video wmi k10temp i2c_piix4 acpi_ipmi
>> ipmi_si drm zram ip_tables loop squashfs dm_multipath crct10dif_pclmul
>> crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3
>> sha256_ssse3 sha1_ssse3 sp5100_tco ixgbe rfkill ccp dca sunrpc
>> be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls cxgb3i cxgb3 mdio libcxgbi
>> libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi
>> scsi_transport_iscsi ipmi_devintf ipmi_msghandler fuse [  155.685224]
>> systemd-journald[1354]: Compressed data object 957 -> 524 using ZSTD [
>> 155.685687] CPU: 3 PID: 6960 Comm: amd_pci_unplug Not tainted
>> 6.10.0-1148853.1.zuul.164395107d6642bdb451071313e9378d #1 [
>> 155.704149] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIOS
>> V1.03.B10 04/01/2019 [  155.712383] RIP:
>> 0010:kernfs_remove_by_name_ns+0xb9/0xc0
>> [  155.717805] Code: a0 00 48 89 ef e8 37 96 c7 ff 5b b8 fe ff ff ff
>> 5d 41 5c 41 5d e9 f7 96 a0 00 0f 0b eb ab 48 c7 c7 48 ba 7e 8f e8 f7
>> 66 bf ff <0f> 0b eb dc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90
>> 90 90 [  155.736766] RSP: 0018:ffffb1685d7a3e20 EFLAGS: 00010296 [
>> 155.742108] RAX: 0000000000000038 RBX: ffff929e94c80000 RCX:
>> 0000000000000000 [  155.749363] RDX: ffff928e1efaf200 RSI:
>> ffff928e1efa18c0 RDI: ffff928e1efa18c0 [  155.756612] RBP:
>> 0000000000000008 R08: 0000000000000000 R09: 0000000000000003 [
>> 155.763855] R10: ffffb1685d7a3cd8 R11: ffffffff8fb3e1c8 R12:
>> ffffffffc1ef5341 [  155.771104] R13: ffff929e94cc5530 R14:
>> 0000000000000000 R15: 0000000000000000 [  155.778357] FS:  00007fd9dd8d9c40(0000) GS:ffff928e1ef80000(0000) knlGS:0000000000000000 [  155.786594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [  155.792450] CR2: 0000561245ceee38 CR3: 0000000113018000 CR4: 00000000003506f0 [  155.799702] Call Trace:
>> [  155.802254]  <TASK>
>> [  155.804460]  ? __warn+0x80/0x120
>> [  155.807798]  ? kernfs_remove_by_name_ns+0xb9/0xc0
>> [  155.812617]  ? report_bug+0x164/0x190 [  155.816393]  ?
>> handle_bug+0x3c/0x80 [  155.819994]  ? exc_invalid_op+0x17/0x70 [
>> 155.823939]  ? asm_exc_invalid_op+0x1a/0x20 [  155.828235]  ?
>> kernfs_remove_by_name_ns+0xb9/0xc0
>> [  155.833058]  amdgpu_gfx_sysfs_fini+0x59/0xd0 [amdgpu] [
>> 155.838637]  gfx_v9_0_sw_fini+0x123/0x1c0 [amdgpu] [  155.843887]
>> amdgpu_device_fini_sw+0xbc/0x3e0 [amdgpu] [  155.849432]
>> amdgpu_driver_release_kms+0x16/0x30 [amdgpu] [  155.855235]
>> drm_dev_put.part.0+0x3c/0x60 [drm] [  155.859914]
>> drm_release+0x8b/0xc0 [drm] [  155.863978]  __fput+0xf1/0x2c0 [
>> 155.867141]  __x64_sys_close+0x3c/0x80 [  155.870998]
>> do_syscall_64+0x64/0x170
>>
>> Check if the sysfs directory entry exists before deleting the sysfs file.
>>
>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 3 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c        | 3 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 3 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c        | 3 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         | 3 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c         | 3 +++
>>   drivers/gpu/drm/amd/amdgpu/df_v3_6.c            | 2 ++
>>   7 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index f7bf5e43f16e..a9f40b28e030 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1773,6 +1773,9 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device
>> *adev)
>>
>>   void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>>   {
>> +     if (!adev || !adev->dev->kobj.sd)
>> +             return
>> +
> 
> You should probably drop the !adev check and IIRC there was a macro to check if a kobj is valid or not.
> 
> I'm fine with the patch otherwise, but in general such checks are more or less frowned upon because it mean that a driver has messed things up and tries to remove sysfs twice.
> 
> Thanks for your input. I will update the patch.  this is a hot plug case. pci bus is removed and
> then unload driver. it will has many sysfs warnings.
> 

If it's specific to unplug, can we mark the sysfs removal sections under
drm_dev_enter/drm_dev_exit instead of this check?

Thanks,
Lijo

> Regards
> Jesse
> 
> 
> Christian.
> 
>>       amdgpu_gfx_sysfs_xcp_fini(adev);
>>       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>>       amdgpu_gfx_sysfs_reset_mask_fini(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> index 642b8c848141..257f4b712f00 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> @@ -447,6 +447,9 @@ int amdgpu_jpeg_sysfs_reset_mask_init(struct
>> amdgpu_device *adev)
>>
>>   void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>>   {
>> +     if (!adev || !adev->dev->kobj.sd)
>> +             return;
>> +
>>       if (adev->jpeg.num_jpeg_inst)
>>               device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
>> index e8adfd0a570a..34b5e22b44e5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
>> @@ -137,7 +137,8 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
>>       if (ret)
>>               return;
>>
>> -     device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
>> +     if (adev->dev->kobj.sd)
>> +             device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
>>
>>       ttm_resource_manager_cleanup(man);
>>       ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT, NULL);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> index 8c89b69edc20..5a595baebb50 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> @@ -451,6 +451,9 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>>       if (!amdgpu_gpu_recovery)
>>               return;
>>
>> +     if (!adev || !adev->dev->kobj.sd)
>> +             return;
>> +
>>       if (adev->sdma.num_instances)
>>               device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index 67264f0be491..2b21b4e5c19c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -1320,6 +1320,9 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct
>> amdgpu_device *adev)
>>
>>   void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>>   {
>> +     if (!adev || !adev->dev->kobj.sd)
>> +             return;
>> +
>>       if (adev->vcn.num_vcn_inst)
>>               device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> index 02bda187f982..2cd642761a3b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> @@ -904,6 +904,9 @@ int amdgpu_vpe_sysfs_reset_mask_init(struct
>> amdgpu_device *adev)
>>
>>   void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>>   {
>> +     if (!adev || !adev->dev->kobj.sd)
>> +             return;
>> +
>>       if (adev->vpe.num_instances)
>>               device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
>> b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
>> index 483a441b46aa..bc7d380f4b0f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
>> @@ -254,6 +254,8 @@ static void df_v3_6_sw_init(struct amdgpu_device
>> *adev)
>>
>>   static void df_v3_6_sw_fini(struct amdgpu_device *adev)
>>   {
>> +     if (!adev || !adev->dev->kobj.sd)
>> +             return;
>>
>>       device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
>>
> 
