Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74441CF2592
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Oct 2024 01:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D15FA10E1F9;
	Mon, 14 Oct 2024 01:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TKrqc8Pz";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE2310E1F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Oct 2024 01:55:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHvPRlId+MUMqfq2chcoQu4oCacsoTAAHpHT6UHlC/umVRMzWleMvndgO2hkF+a61nZn7k+r6JdUqukFvVf+r7AuHfSMmMjvzhSgQiGJ4h0XRfFnzAoRYufMXIwql0g9cf9Ci0HPe5289xavILfXEK4TjxrNUJh0IAKtLxsReIWRGD1dr/Wx/K8am45M4n6MtJexUXVELLWdHiphkNKctUaIBJswjsN3vwRsB3vRqmGBx9RwtkitGnIH0Mst2k90h1JVZ/z/NYAaeO07ZSXpttrqJFgexfjnzW9DzWGMl1dp5gOj4kfUHhdtjdNSJyruXb6qVazvCicboAu7aXjV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3RSxwFgiCf/4xI9GHRHsw/mkbU/Z1BTqRbW+37lNzw=;
 b=SmoMnmnawjjwbYG7K1dZBsxUjc/F36KcgNKX+u0snUlFXf97goFBI6DZjSNjudJhrdn/LZi3yen597GO9DeX/KX5kcWqSHI7/cDXKzhtJHWw4fUaVFU3eCCz/CeNhT8PBAg5tpOZEt001DiTanuAK5l+fU+3pS/n8iJ4grEWpn3K9vkhPaRbSBdVck8ykKcqw04JAf6+aKmBl7hhrCwoTi5UZmcpSbR7FBFmf+tZgbdbNmVqSr8pljPWMbktKIbCl1vQAAhaEhs33WPYegMDy+SjminkGyylCMv49GUrPveElQUVAjAPmOxUNPqXEMzpWHt4ZngsC+KuVbuO4KE9Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3RSxwFgiCf/4xI9GHRHsw/mkbU/Z1BTqRbW+37lNzw=;
 b=TKrqc8PzZht1Ces5YR1sD6gwT6Uf+JcWfT5cmTL84GrbA3HNbfVBwZO5jRmtoYpe14O8bVXN72FIbJ/8SM3cuHelbNwD7ZK3jKNHuO3LimWLfJhFVI7e2SwxvOFTReskfllDqmIMIMK8pxf0Gkpw4e/vZ+6KAd4zf0qBQqeepPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 01:55:36 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%6]) with mapi id 15.20.8048.018; Mon, 14 Oct 2024
 01:55:36 +0000
Message-ID: <2da699ed-634d-4710-9539-a28ede17c41b@amd.com>
Date: Mon, 14 Oct 2024 09:55:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: change kfd process kref count at creation
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, philip.yang@amd.com
References: <20241011144155.120290-1-xiaogang.chen@amd.com>
 <c7d42fc6-6164-4080-a90a-b53bd7cd796f@amd.com>
 <15671ab9-264c-4a4e-bb28-8c4da30271b9@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <15671ab9-264c-4a4e-bb28-8c4da30271b9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0111.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::16) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: b50abc46-fa08-4fa4-67db-08dcebf34bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2ViMSt0d0FaRm1hbWdpZUVOL09TSFRSS0k1MnRhQjlqS2d1bmoxN1Z6b3dQ?=
 =?utf-8?B?TmcyMTVUSUYreHVvUnovWUZ0ajFlQUxYbGJ1OHJjNHQ1dys0LzdnZDlRbDl0?=
 =?utf-8?B?ZGQ1NXdaWFBSTkNYOEdHOXUrcW8zUTRmL1dwUjh4VWl3YnRiUHVDZ1VHb2JK?=
 =?utf-8?B?MlNTUjZwUEl5VlMxN2tkeU51TlVxbS9UZUY3M3BDcnlzTEN4NUtTZTJ4emRM?=
 =?utf-8?B?T0p6djlYbmFxL29idHF5Rk5nT2w4enUxMWU1VkoxYmRhOHlXdjNYeklaUkVB?=
 =?utf-8?B?RStYQlZRUDByUXNNOXE3a0xrSjlLSkhWSkhiMDEwK1RjN0wrUjRpSVZHb1l2?=
 =?utf-8?B?M05tZ3pOSjJZTmpmS0JlNVlFL3V2d0ZhNzcva2V1NkZFaWszV1NVS3R1VjJj?=
 =?utf-8?B?SkJJN2dZUk56UU13UXVROG5wS1A4VVZSNFZWdWNqRFcrQWhQZTVRT3hEUmhN?=
 =?utf-8?B?QWJ0TG5NNVdVdmppVVowV2FwOHphQ1BmOWFBOGk0TWxUZTZYa2ZXM0dWRGdW?=
 =?utf-8?B?U1VXazdPUGlDQzlGekwwV21ZejFVRkNGQ2g2V1pJVmFjTTZjeWJNZGxiQzZl?=
 =?utf-8?B?ZGpWTW01Vzd0cEZtVjk4aUREMTJkTXlkcGhMdUlmM0JJUVRldW9uQU9uRFBZ?=
 =?utf-8?B?eFhlcEkxaHZFaGlXeTBHTERSdVNkekRUaFIxQjJGZWxBTjJyVXNna1BrYldn?=
 =?utf-8?B?NXduUmJQemoyR1BnT3Q4YVhKWCtjeDJaWEh4ME9nM1VBT0RBdmEzN1puckRa?=
 =?utf-8?B?VUJpRjBiZjJIbTkrbkNXWFBQVU0zc3d6eXBxbC82N1lKQTdleFQyZHAxd2FU?=
 =?utf-8?B?dm0xMjNZR1o4SUt1Y3Z1b0pxaGpSMmJ4MllyaVo2eWNVNjU2Y0h5VGpuajFF?=
 =?utf-8?B?bEEwK1BxcUJUUWNyUmdnWkc4Mk9EYnI5blhyTUNBSmphVHdza0Z4OHBrckJD?=
 =?utf-8?B?U1FHcDZTdmRkb0dnUGlkNjVvOE1YOWNhNDlXUnBqOXMrT0JIUVZvMXVibWE0?=
 =?utf-8?B?Vktjcmlic3NSN21OUFhaSW5QRnNDU1lpL01TcjJrd3p0UG1oSm5SaEI1enhz?=
 =?utf-8?B?VERyaGhWanhHNXMvYzhzOWNrcnBPcTM2cSs3VVlYSnVjb1JJek13NUhVK3dH?=
 =?utf-8?B?Z1RIOEZtZjluT1czUWVpOUczaG53OFpLeTh0Uk54R1VOaDU5VUlwQ2RPMVV2?=
 =?utf-8?B?Qk5seHFpQzl2NGphRmk4b3NOMjZtM3EweHMxdE9GRXIyQlUzTnplRm02c3NS?=
 =?utf-8?B?S3FTcXBwVTVpVmFYZDVBSTRCaUtjK3pLQm95WDlJL0hNcVArRDJtbFpjcVUv?=
 =?utf-8?B?ZHJHQjJmbTlvaldKLzRqYlkvREszK0J4WmdaVFVtV3hDblRVRitRcTMrL3NI?=
 =?utf-8?B?eE1jTytHeTdxUEJGUk5WZ2cyeGt0ZFEvWDVWanM3bzRUOW5VdTdnWUhLaXhS?=
 =?utf-8?B?YTFLZEcvek1LK0NPUU4rRUlaTzZZT0FLVVcvbkQrQTcrNmhUdzlpcnVUcTFY?=
 =?utf-8?B?L1UrQVp1TXRCRVdTc3ZuWmlGU001QnN0Um1odmUxbkdTbGpxaFQ0ZDJ0NEZ0?=
 =?utf-8?B?OTBqZk5LdEVWeHRZNFlxOWMwcUQ3eWxpWnN4NkMxSS9ldEsrR1NCc3I4Kzd6?=
 =?utf-8?B?VEw1bjVzbWtjVFJSTG9GTW1Nb2V0VkRWL0NZSUdBaUhhZFNtd3JGclFuN25T?=
 =?utf-8?B?Y1lqV1hFVXFWY1BQNWR5bWZvZzR4SElTbFZqTEhOMitHa1Q2R05qdFpnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3BVTFFGSjhaTUY0TzNETGtKTmxlMkJCd3FVeVpiYVRjMFZFMHpQUEt3YzBx?=
 =?utf-8?B?ZnhSaDlMS29qOWxDeVgrMHk4RVZ1aDhicmVEUE13b25TTis1UUlBdkcvZ051?=
 =?utf-8?B?UXNqR0lDeXJhMmM1MFNGL0VaS3ZhWHpudnR2VWVpai9Nb1MzOG9qN1QvOGJ2?=
 =?utf-8?B?bkM2RnAyRWY1aDFzZHQyNlp1eWthZDc2aWZwbnpkUlZubmoxSzZPQXBwVmxP?=
 =?utf-8?B?clMvdUxraGhQODM4K01BY3d1THRHTmNSczF5alBxNFRxY0M5d1pTdDBhMk10?=
 =?utf-8?B?VURTSHI0cytEVmR5MFl4SmVyb25OQjNWbm8rN2lUSlBXUWl3Tlp1eW9pZkxr?=
 =?utf-8?B?elVhdndjamhwSndYMnV3VGlxYUZ2OFRBcWZvcTZTRHF0dGRFWlA2UEFZaTFH?=
 =?utf-8?B?Y2hVVGd3VFpDemNlbkRoRXVEVmFKNjIzUjA5YVJ5Nzk1SlNaSHlvcHBrV0ND?=
 =?utf-8?B?b3dYMWtIVkxQRE1kSG9kd1hBbk5iVko0QSswelJ6ZlUvRzZjRjFWQ2UvMXdC?=
 =?utf-8?B?Tlpnc2ZVdWU4eGtSMk1sRVpOWFdVNEZaeDNlTG4vVTNaVjgwOUtiNlhFa1Rn?=
 =?utf-8?B?L3dmTml6N1MxYXV5OXl2U0ZydGZVR2NhWDI5cVQyYnFYZVJneWVIZWlzZHpR?=
 =?utf-8?B?UWdRRURjOWxtd1gxQVhqQ1VqVnZaRFpiMThwclNLVitOQ3NrZSt0N2NrUkRT?=
 =?utf-8?B?anBhdE5ncVVHSU9qZzhtUWRrWHhZaGVDT2JxTGpEMnMxd1ByKzRzdzNpZDls?=
 =?utf-8?B?Uk5xN2VCcnNKek40d2JxTVBMaDFvMkNrbWJtRXBVbm1YVHRnbVJBb1VndVdT?=
 =?utf-8?B?azJUbmNLM1dKYjVXUzRiN2E5VkRvNHhUYnoyK1NlRWRmSGI2SGJSeWp3cW5I?=
 =?utf-8?B?SGdobnZKMCthK0lZS0RQWk91dGFENU9BSm1MM1pvejdqVlZJYzB0UXg4S1JF?=
 =?utf-8?B?ZUMyaDFzS2owa3BWTDdhQnJ0Ny9GYlRqV0FDQmdnQlgxMEpzRmxoWGRkQVBP?=
 =?utf-8?B?ajl0SmZDMHp0NDkyYmdMSGpuM2x4azFyWXR6R2pHNGRFSWZPN2lnWXpidDNw?=
 =?utf-8?B?clFvUEdGMUhWNU5DY0hkMm9icTREN1BEN25yMEg3VUd0bkU3d3Zjejd3SXU1?=
 =?utf-8?B?dnQyVUdESnBpUDNKUmtRWGxWYzlSVHRpMHErMEtzNTgzTW5YT0c5ckxmeXg0?=
 =?utf-8?B?WWlvc2hYOWVhMFRzam9OWXlGV0t4Tk9JSUs3Tm43MjVROFZWUFYvbVB4dlpz?=
 =?utf-8?B?VE82dzQrVG1SZGRmbEk1dGpxM2xJbGM2dXhvSUpLYnlNT0Z5V3BiNGhEZVY2?=
 =?utf-8?B?NUxNQjB6dzZ4dlBIODY4OHhDN01ab0hpei9IT0U2anBRMHNxTDR0eWRjdUs4?=
 =?utf-8?B?bGFsSlluNU91SkZrMHNQbTE2Vk5PcHYvWFpnVkwrRWhhYWMreHNDM2RyMWti?=
 =?utf-8?B?M3crQjhZQ1ZZOUt5dmt3U20yVXFDMXpqb1UzZ2o2MlNTOWFvOHMwRkVmQ2hS?=
 =?utf-8?B?TDZlSmVKdWsrUGV2SVFGcHA0cHZUbitpeUU2aVFxd0JXNHluQUxSK1BJN040?=
 =?utf-8?B?ak9jWTcwUTFuNk51KzR6b05SZmI4K0UwZE5IWHY3TFRXRmhjZS9IaTYrQWRP?=
 =?utf-8?B?QlB0RjFpL1NNeDBsMDVZQjAvRzhpbDRhTzZzNzNvdEcrNEdOSENralkvUytG?=
 =?utf-8?B?NlArWEdGa0dZSjRrWVEzTHVqQy9kdlJpV0Q2QVBaZERiK1EyY2FndHlMb2xW?=
 =?utf-8?B?d3lLcHZTT1BCUFNtaEMvMkFqeWRyd0VENEtpbkdsd3pVd1JGbUZnQWdNcFZn?=
 =?utf-8?B?OWJFU25WT0J6dHJ3KzFWU0ptb1lhd0ZQSjUvbmpObFhGcU1YajZFbzV0NktG?=
 =?utf-8?B?TThJUzhlSUhoN2d2OEoxdDFGZElBSjZkY0lKV3Y2NXV1dVMvN0IxV2VaZm05?=
 =?utf-8?B?bnpDTW9sR1hoR2xpQ0FOSkhtKzRaWlJEcklqcUhaV2ozZDl1QThURTc3anpY?=
 =?utf-8?B?ZTQ0WFl0WnN6WENscjFRdllkN1NVQzM0cUtpNVd1ZmUxRFJ6enhBcmZQaDJU?=
 =?utf-8?B?ZHZ4bS8yNlBCWjhwRHlqSGcvWXgwNkc5L2ROcHJSVEtNK3gzYm5wWll3QlB2?=
 =?utf-8?Q?JDsZTg1Rh3LbMf2rreqsOfWRL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50abc46-fa08-4fa4-67db-08dcebf34bd8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 01:55:36.3994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUDztGtIeKEHxv08hdntG+h+ChWsM5gxw/hd/vo3NHpzE2S1iC5UzO/vwkYBi5pHU56RNAqwOE5osLChp3ORuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174
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

On 10/13/2024 1:30 AM, Chen, Xiaogang wrote:
>
> On 10/11/2024 9:56 PM, Zhu Lingshan wrote:
>> On 10/11/2024 10:41 PM, Xiaogang.Chen wrote:
>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>
>>> kfd process kref count(process->ref) is initialized to 1 by kref_init. After
>>> it is created not need to increaes its kref. Instad add kfd process kref at kfd
>>> process mmu notifier allocation since we decrease the ref at free_notifier of
>>> mmu_notifier_ops, so pair them.
>>>
>>> When user process opens kfd node multiple times the kfd process kref is
>>> increased each time to balance kfd node close operation.
>>>
>>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 15 ++++++++++-----
>>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index d07acf1b2f93..78bf918abf92 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -850,8 +850,10 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>>>           goto out;
>>>       }
>>>   -    /* A prior open of /dev/kfd could have already created the process. */
>>> -    process = find_process(thread, false);
>>> +    /* A prior open of /dev/kfd could have already created the process.
>>> +     * find_process will increase process kref in this case
>>> +     */
>>> +    process = find_process(thread, true);
>>>       if (process) {
>>>           pr_debug("Process already found\n");
>>>       } else {
>>> @@ -899,8 +901,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>>>           init_waitqueue_head(&process->wait_irq_drain);
>>>       }
>>>   out:
>>> -    if (!IS_ERR(process))
>>> -        kref_get(&process->ref);
>>>       mutex_unlock(&kfd_processes_mutex);
>>>       mmput(thread->mm);
>>>   @@ -1191,7 +1191,12 @@ static struct mmu_notifier *kfd_process_alloc_notifier(struct mm_struct *mm)
>>>         srcu_read_unlock(&kfd_processes_srcu, idx);
>>>   -    return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
>>> +    if (p) {
>>> +        kref_get(&p->ref);
>>> +        return &p->mmu_notifier;
>>> +    }
>>> +
>>> +    return ERR_PTR(-ESRCH);
>> this cb should only allocate the notifier (here it returns an existing notifier ),
>> so I am not sure this is a better place to increase the kref, it seems coupling
>> two low correlated routines.
>>
>> kref is decreased in the free notifier, but not mean it has to be increased in alloc notifier.
>
> Who referring kfd process should also un-referrer it after finish. Any client should not do un-refer if it did not refer. That keeps balance in clean way.
I think we already do so, see any functions call kfd_lookup_process_by_xxx would unref the kref of the kfd_process.
>
> The current way is using  mmu's free notifier to unref kfref that was added by kfd process creation. Ex: if not use mmu notifier there would be extra kref that prevent release kfd process.
I am not sure this is about paring, current design is to free the last kref when the whole program exits by the mmu free notifier, so it would destroy the kfd_process.
MMU free notifier would be certainly invoked since it has been registered.

Thanks
Lingshan
>
> The final kref is same. The patch just makes the balance in a logical way.
>
> Regards
>
> Xiaogang
>
>>
>> Thanks
>> Lingshan
>>
>>>     static void kfd_process_free_notifier(struct mmu_notifier *mn)

