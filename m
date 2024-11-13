Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A57FD462A8
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 14:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10E2110E713;
	Wed, 13 Nov 2024 14:20:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tgJxWlFG";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F67E10E713
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 14:20:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wly28qwFpvhgwjTpHwJ8AnCVRb97umI4m3Q3Rlju3cujOR9qCBYy7NZwFmua7sdFHg3oUV3AxnpNRHvRPLDT0QWMxEMTxwFfScWcwE/7bSTILTV9ICNj8QuS5iHpSNLwJUsRCj4N+eyGniLc+Clnr9FZeh2mMY028npI3oXh7evRzNiMf03HyHntQEwnQU7tA83njQcOSXB4DI9EvVK0W/8PdX/BEF6Vp4Jg4zp3317a6/KrbaLLe/tF19UiMdTUpMXgSi8Qggr4fWAQGCGFvYtY/2hmE9NqcQsc5u0TV260mJ5Xwo3wfkDpWtLoBp7R5WBjAbSuD7kZpMA2Dhw2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcog/iQxlLXNpCsJi95owuHJqSuiOq3PX3CeVTLp+mU=;
 b=jk1mFhjHKgv+EOUg94vYgSPfasrIwpOYLmWnch19FTQpg4pTGv6cnnAwSsHo/ISdTOTNw7yg8tG85sy+5C/Ze4UJBCcHWsQc/wSS3RDd2zCQrb4RZc4HRjcMjvqhqXym+COOZF4XbzrAwbUllFLP2n6CDbgkVrc8elO1/jC1HYAg2T+vurrlu0PKmBRPLUmhE6bpQ9mBxYCNV2z+1Dj59WH5L8u/DrhyJo0UPbsrYlPjtogggacbAPS0n365q+MpzLFeoJewlou0IvvW6mA2GOjfCN45f6llnJ0vZAyCO3YEwmhDfsK5L/ScPfuwi2tK/xBWwUPfPSaCqPr+lOe6TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcog/iQxlLXNpCsJi95owuHJqSuiOq3PX3CeVTLp+mU=;
 b=tgJxWlFGxVrtZmfRrNF+as/GlcfwjVHyxwXXRtei/Sg8WbzBmTaAOa5DBltj2WoLi43HqVN9WbXD+Yudp+Bec2kZiBRUSBtghpn5RWo/Gx3/aBaqnCakdScEf3vB0Z+oxB8QFhwj8FzdhFLN0mkbQdSEKfKvd4/rsRsomZ0ha7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 14:19:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:19:56 +0000
Message-ID: <e04ecd40-5026-4be5-a0dc-d276f117ddba@amd.com>
Date: Wed, 13 Nov 2024 15:19:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "tvrtko.ursulin@igalia.com" <tvrtko.ursulin@igalia.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20241110154152.592-1-Yunxiang.Li@amd.com>
 <20241110154152.592-5-Yunxiang.Li@amd.com>
 <5d1c88a5-9802-4bb7-b76a-5e501847ced1@gmail.com>
 <SA1PR12MB85998D24DDB5EB93AE88E5A1ED592@SA1PR12MB8599.namprd12.prod.outlook.com>
 <92be210e-b552-45ee-9322-1944a4bfd325@amd.com>
 <SA1PR12MB8599C03D7B92F3B24976552AED5A2@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB8599C03D7B92F3B24976552AED5A2@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: df62fc16-bdda-424d-1f51-08dd03ee3fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bngvYUhPb1o1R1FzWGhNZ3d6aWF0ZTNTa3VlUjJkb1JCdVEyam5qZmNBVmh5?=
 =?utf-8?B?K0xzS3Y4VStWRUQ0MzR4ZVAzTXVTamdsWGR1M3ZmRWpuTzNsZWpPeDFHZHcv?=
 =?utf-8?B?a2R5RDVmaC9YUk5FNkFrOU4reW4yeVo2Y0d0YXhNMDluclo0YmNSWFFKRFpv?=
 =?utf-8?B?eGw4bE5KWkVJcEJRT3E1UGtDc3NxR3ZiMWhkYlJuVkRtTmJvR1VvbVBYTEV4?=
 =?utf-8?B?eXJlSXJhbDAxdk5Ub2JMWjdCR1ZCdHNFVnJUaWhtanZjdWpCakxzcEJOZERm?=
 =?utf-8?B?WXVTUjNxUWQzL29IbFBPYzVEUXg2am9NQ08xWmwwV2J3WVU5YUI3UXB5NndI?=
 =?utf-8?B?WEsySFE1Ylgybm5QUGlLbmtnLzVFM1FjR2lPTmJ0eWlyTVVhYzlSNURwQ1g2?=
 =?utf-8?B?c2R2UXM3R2VSMlNQY1BsSmZnelY5eklQU2tyQTR1aGUrN3U3bGtMSkZ1QzBt?=
 =?utf-8?B?T2tITXE3eTEralVtYnNWTzVQR0hBaG1oc05EaVBnUldVSmF4dGhpaHZ0ck5U?=
 =?utf-8?B?SXlSRGM0bVFjZDFtZ2hodDZ5czJjcDNMWmJhT28rYzhyaTJvZEZFREhCTjVR?=
 =?utf-8?B?bUJtNzBRUDFJcUNsYnVsbHhjcFdvcTF6V1ZleFV4Q09pRVN1UHE1TkpWRkly?=
 =?utf-8?B?VkQybEJKc25QTk1jVTlwdytUUlVQMTlGSDY0NXR4WEt3MXF1QVhwVnhYNGlj?=
 =?utf-8?B?d25mQUE4TGlNcmEzYkNlWEpsYUQzQkVKS1N5WVVlRlZ3S3Z0NWNqL3hXbTlL?=
 =?utf-8?B?azhmZks1dnpnYUNUY2dZMHdlWjMrTmR5d2FwTENXRmlFS2RNUXZkQ2VLRjRn?=
 =?utf-8?B?Q1RDK05Mdmc0ektDVi9CMExBUlpmeFNZOVNBdTJZT3Z5UWNsakJjbnhZb2xV?=
 =?utf-8?B?V1NteTZ4TTZmV3VlNG1hakJpQ2FOM1h3MUZnSnAwUG1VM1d5MXlvM2lkVytZ?=
 =?utf-8?B?VGdYYVVzQnFuSHppUks2aEc0WVR0eC90MFNpUzVVeEF6cDY0WWpYUjJ6SFI4?=
 =?utf-8?B?RVJaUStmdFRkUEUzMTdWeHoxbW9zR3FwbkxMcEk0S0FBdGdxMHZ1cWdVSmNO?=
 =?utf-8?B?RDBCSERVRlJqOXFObjFkc1pUenVNcXk1TmVpSFE5TVg4clhkaDkrQXlXZzFC?=
 =?utf-8?B?YmNjUFYrazBxWjVVQXhqdUNoWk5LLytRRjNHQkxCQU5ZMTJaZ2tndkJDRnQz?=
 =?utf-8?B?TkkrN3ZOSWM1bDNtbzBXVTZTWDF1Q3BIYVV5RFV2VWtNYURrYlB2ZEI4TVYz?=
 =?utf-8?B?ZGJaNzBSNVViaUQyN3JBQ09VcFN6SEI4YXpreDlKV0JQS2FoSTl1elFLaDBz?=
 =?utf-8?B?Ulg5dDRkVjNvVkd4UzVTYkNndS9nRUxjRmVEVFBrRWFwR1NGK05oMm00bjNh?=
 =?utf-8?B?M0RabXpaSUF0alF6NFl0cHJBa1pUckhjMW9BWGdHUUxvWEc0dzhNUjNzbzU3?=
 =?utf-8?B?cEliMXdXTTllTTRPUFJ2Uzl2a21HaHNxWDd5ckYrSXVsMnphOEltYUpiNHMx?=
 =?utf-8?B?L0g0SThtcnA0eGFHWUcveXozcU0xUUNhbjIyakZQOEJxM3pCMW9waXphQUh6?=
 =?utf-8?B?OEtSVVptZDZFNnpLUzA1TlZUa0MvczJVRHdlYzlZbEVMWlVxUWQwcFlBblRl?=
 =?utf-8?B?VFh6M2ZGcG1GdzRIU1NBY2YrNi9DRjRCbjMrT1UyUEd2YUZxN3VucTBCME9J?=
 =?utf-8?B?ZTUxeEMwN3pUVVVBRjdKY3NkR0pLVCtTN1ZKZTJJbzJubkdQZGdORllXVjBO?=
 =?utf-8?Q?ot4xemGZdpVhSRS0vxTN+WHQHo5uxxQrK6SNCtI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFExNGJxRld0aDVuSTBxc0RJNzRLQW9pdTNjcHJMb2d1NTZZRU9WQkNad2Nq?=
 =?utf-8?B?N2pYMTEwaDF3SjlUUm4xb0thNHZBS2p0TTZjR2U4OWRTVVBEU2tOczFSV3hp?=
 =?utf-8?B?b0xGbzE5WVBXSDNneHR6cW1ML2VtVmtRb0U3YlRwbEVmN0JmaVZoV1lsa2pL?=
 =?utf-8?B?bHBoaEE1RUhQQy9IczRNc1M2MkdWR0U1QVRveFAxNjdCa1BzYmlVeVdCY3ds?=
 =?utf-8?B?U3Zqd1ZBUmJqSjNjeTBDamFXcmg0b0h5dlZpOS9XejVhNnZJQi9PZEFiK3ZH?=
 =?utf-8?B?d1ZyS1ExTVZwc1p2TXdIS1ZhS1ZFc3JxZkVqTlluWnVDUnBvQlZnWnNGelY2?=
 =?utf-8?B?R0JENTFUKzlHREhJUTZJTzZObFRiMnpvTXQwZW9teThGbGtIQzdRMjdKamhl?=
 =?utf-8?B?YnNQU25mT2tkek1WZWVwUGNoQit4VGt5VFp0MEJlV2xZMHJEZkZNZGtDcGVo?=
 =?utf-8?B?WkNzNXFOcGdJVXB5UjhNelpPUWFqKzhzQTBuZmtKSkF3Ky9HamZFcHlOMTVo?=
 =?utf-8?B?Z3FPT25tTzcvT0dEQUorTGI4aWRlMlhIOUVXZVNuWkxWVVBFUFNEZEpZV3JH?=
 =?utf-8?B?L0FST001RW9YVXdwbUhWazZNZ2p4SE9HSFdRZE1wUWlCNkQyWE1CNUtNalZU?=
 =?utf-8?B?QXI0UDZYV2U3RDQ1VDR5eHZiblBmbzFHakNWNlNOWG0xUTQ5cERadnEwcjQ0?=
 =?utf-8?B?WUpleTJQVTR5NmUzV1dycHVvR2tReFNJMkdqME8wQ1UyaURoajMwYlhkUS9i?=
 =?utf-8?B?aDRXNW5oeDhiWVVZUHpsK3dQM1EyMm1jcGorTXNjQnFjR3p4RDNSS0lCMDdh?=
 =?utf-8?B?SWlzU25ZTHE0UFNYejJOYjh4NFUvb1BwNmI0T3RZYjlEd3JlWnRzU0dWdllK?=
 =?utf-8?B?OWN4Nk1DRHZteWNFUXZ6MDFYaWRieFZoZjBTaElQRjNrVW9nN0Q0Y2tqa2l2?=
 =?utf-8?B?UFZPdE1uTDN4NmgvMWUyQXdzRXh2aDZRUmZ6SU1QMlJXeXR4MndnM25xWHBU?=
 =?utf-8?B?eXhtM3pjVDdvTlVkd2ozandlR1dIZmxqeTZ3cGl5YmN2bm1TWXdyNGdqTHg0?=
 =?utf-8?B?UVh4TXhuTXliOFZ3QkdzempaVzJld2MzT0tacEkrdnoySWtkU043LytTN0Jp?=
 =?utf-8?B?cGU0ejdMSElrTmF0dEcwaHlQT0RSSFNLOVB1Zm9ERWJTKzEzWFJ0UFBvTWVU?=
 =?utf-8?B?R0VjMFZMcVc3c3RsR09iUDYrYW0yM0FwSDF4YXNNekFnbDAwV1V5MEl5OEp6?=
 =?utf-8?B?UEFSdjBCcHk1V2p6ejRIYTk2TGtyRENNZnE2ZUEwdWdLTnVGSm85dWlFQ05X?=
 =?utf-8?B?aXltRDVDY29vU1dSQTZVOWVrRFFTcTVMeTFKbGR6UmtZV0s3T3JhTW05VGZu?=
 =?utf-8?B?aXpzbXZBb1AzZmxLdW8wVkJuSjdhSE9ieU00ZFZ4ZGpvejh1VW1DRy9KTzZO?=
 =?utf-8?B?aG11K2hKeUFZeHYySk0vdkdvZU9FV1ErUW1DT0xEc1dybDFTUVMxV2dXWFJy?=
 =?utf-8?B?aTRmcTlyd1hEN0txMlNBQWRsWW9LYjhqWjMrSUx0YmVVVjNETVA4azlUUmFk?=
 =?utf-8?B?MXR2UHFZUzhXMHlqa3RZR3RkVlNUTUxYcEE0b3ViYVY3SGo3Vm5nZGthWWtV?=
 =?utf-8?B?MnIrQ0JTNGRHZUdlTVVDRFY1eVNDK0w3V0lBb0hiQ1h6S1BSTDdtWlBDYmpY?=
 =?utf-8?B?SEM1TlBxeXJCVmxUanh5b3lWTVEvdGgzSFVUeWxoNEhMMzFpN2lRVk8ySEJu?=
 =?utf-8?B?MTVuRFNsMTlTNkthQ0V2YjZCNm5hbVN4Szl0TUptZEI1RVgvaEdib09zUzJZ?=
 =?utf-8?B?ZnlRS1ByUUZQY0VyckJUTlFMQ3ZKTmlnK0JkSkNPTjZRc281Q3htYzE3dmZ4?=
 =?utf-8?B?eVdOZ25oN0RMWkFJN1l2Q2JlUTZ4ZkJCUTZZVE1PT2RmYTFQd3YyMCtZcGN2?=
 =?utf-8?B?VFpVWk1YMkdMbFl0TE5hTkRPa1JKYTlzMmczS3pkTml5K2l1ejFzV2ZzNWJY?=
 =?utf-8?B?aUZicVNLWks0U2JWU0ptcEhNL0FvSzEwTUphVzFaQ2RLaTkrYzJtQktqeTRP?=
 =?utf-8?B?VG82Z2hVVlJKMXVvNFhLSE5vOG9ONjVMdTJkM1R3RG1ZY2wvZHRXa1BHWHo3?=
 =?utf-8?Q?Ue9Khv/gHJEaQ8znCgiuBSj7l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df62fc16-bdda-424d-1f51-08dd03ee3fe2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:19:56.7977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSVUZiNS4SxtpvqowQM/ZMmwE0hqKcP7Pvt1ciS/w3haDMgztgwxKW85mt/8XqJc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813
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

Am 13.11.24 um 15:09 schrieb Li, Yunxiang (Teddy):
> [Public]
>
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, November 13, 2024 3:49
>> Am 12.11.24 um 19:16 schrieb Li, Yunxiang (Teddy):
>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>> Sent: Tuesday, November 12, 2024 5:54
>>>> Am 10.11.24 um 16:41 schrieb Yunxiang Li:
>>>>> @@ -2612,7 +2707,6 @@ void amdgpu_vm_fini(struct amdgpu_device
>>>>> *adev, struct amdgpu_vm *vm)
>>>>>
>>>>>       root = amdgpu_bo_ref(vm->root.bo);
>>>>>       amdgpu_bo_reserve(root, true);
>>>>> -   amdgpu_vm_put_task_info(vm->task_info);
>>>>>       amdgpu_vm_set_pasid(adev, vm, 0);
>>>>>       dma_fence_wait(vm->last_unlocked, false);
>>>>>       dma_fence_put(vm->last_unlocked); @@ -2660,6 +2754,15 @@ void
>>>>> amdgpu_vm_fini(struct amdgpu_device *adev,
>>>> struct amdgpu_vm *vm)
>>>>>               }
>>>>>       }
>>>>>
>>>>> +   if (!amdgpu_vm_stats_is_zero(vm)) {
>>>>> +           struct amdgpu_task_info *ti = vm->task_info;
>>>>> +
>>>>> +           dev_warn(adev->dev,
>>>>> +                    "VM memory stats for proc %s(%d) task %s(%d) is
>>>>> + non-zero
>>>> when fini\n",
>>>>> +                    ti->process_name, ti->pid, ti->task_name, ti->tgid);
>>>>> +   }
>>>>> +
>>>>> +   amdgpu_vm_put_task_info(vm->task_info);
>>>> Please don't move the call to amdgpu_vm_put_task_info().
>>> Is keeping the task_info alive a hazard here? I could copy out the info, it just
>> seemed a bit wasteful.
>>
>> Ah, now I see why you have moved that.
>>
>> IIRC we need to free up the task info before releasing the PASID, but that info might
>> be outdated. Need to check the code.
>>
>> Does it work if you move the message further up or does the root PD then break
>> your neck because it isn't released yet?
>>
>> Thanks,
>> Christian.
> It needs to be after root BO is deleted. I think there's a way to go from pasid to task_info but not the other way around, so it should be safe? It's okay if the pasid/pid/etc gets recycled before we get here and we print outdated info since it's just so we know which application we should use to try to reproduce the bug.

Double checked that and the order is actually incorrect right now and 
your patch here is fixing it!

The call to amdgpu_vm_put_task_info() needs to be after the call to 
amdgpu_vm_set_pasid(adev, vm, 0) or otherwise fault handling might use a 
freed up task info.

So feel free to completely ignore my comment, you're actually fixing things.

Regards,
Christian.


>
> Teddy

