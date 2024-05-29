Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC86C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 07:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 324D410E167;
	Wed, 29 May 2024 07:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zgn8LoY5";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C190610E167
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 07:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g92Gvbq/EyiepiyRB7Rs9VtcdDV0e9YvqbU4cx03KN8lQ5Ui2BK2pC9xTXPZdWV8BFFO8TbsELUuHiq1rE1wLscFiWLvLZZUb86aBdelJsD0KPRkDd0iX7sb6JFUcx4cJsm3Vu1S2hnQ1ANx8R+JFqvf5z5okGuiCjUyE5qDFyb3S0w9xzurYiRbDvk3JbHO+FO7HpxrI048LRrPjzHOO8Wov3KWYLbh7/vAPEiTa88ozVPL0vHIP3Jq+Pq3h+OUnY80r/GxlRWR99hcGzKPdR5zzp6j5fbfNZmOPzVF85IiEUeRT9s1UGptjl3epJrGBGFTFx6j/Sn7twojlHZLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdrshWU1x+FYVi5NQGcoKG6krcsLo8R2u8QgddzQgxU=;
 b=YIue0jX3yo984IQobaHac4O1mSvDgU5C6oUL25Wbu8w4K+2Tt2tdzRYoSV5DooPbiZPy9PArV93bPAAneQ3OXntSSUojU+NSNrOlpf0j7f3w/JLUHi78JRdAd+xBbC3dEjAxNextOzH6dPreV1i/me1T1Zyvj7WRmWyQsufp0liFRA3GpJ/N6zFV27LniwoIigwhPRqpuvgE0ut+SBZf2WusFvvEg8oH4HCsuT0FxeZW/yokVosP21+NzrCsA7x38EAnrO0xdkv0jHuYRc+VljYzW1Ifjq8iGyHBTR8N7rLZgTaRvevGl6U6apNXEZyrMGyTAycY5GzA/VDCpiHQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdrshWU1x+FYVi5NQGcoKG6krcsLo8R2u8QgddzQgxU=;
 b=Zgn8LoY5FAn8Dpde/pz/pKb72SK0yK35Nrlj1ArjozfzTNxOeDz4cYnnH3za6KDEmKxP45qfIOJZJeZMfD60vQjaj+jgWab/Ttn7fv3v+ZJ8K4GFA+QEpozQN161HpBweTe9PtR/x/bv/OE2yHVHMLjH9zH96qlQ5noXkOZ0PLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 29 May
 2024 07:30:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 07:30:23 +0000
Message-ID: <6ad1e363-5f22-46ac-b9de-9e4e87a59e9c@amd.com>
Date: Wed, 29 May 2024 09:30:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] drm/amdgpu: amdgpu crash on playing videos, linux
 6.10-rc
To: Wang Yunchen <mac-wang@sjtu.edu.cn>
Cc: amd-gfx@lists.freedesktop.org, Xinhui.Pan@amd.com,
 alexander.deucher@amd.com, Felix.Kuehling@amd.com, "Liu, Leo"
 <Leo.Liu@amd.com>
References: <ebb3b35e631169041e70eb0a7efd6cecef609833.camel@sjtu.edu.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ebb3b35e631169041e70eb0a7efd6cecef609833.camel@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 42591eed-3925-4edf-1e23-08dc7fb133b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFE1V0xEazdBL05oMVhKZDFDbHd0ZmthOEcyZnNVMU1YUi9veWdKd3pIU05B?=
 =?utf-8?B?OFdkYUd4T2NQQWJFZVQvWDFNZlJzMzJBc1VjdDlEcFhubmZjd0NqMU5CVmlE?=
 =?utf-8?B?a0ZMV0FPWTNOYTBOSkFkQ1lPNElJckFxTnp2SGI2N1ZKSTJXbW1RbXFHZ2NQ?=
 =?utf-8?B?M1J6Yi9abzN5ZVhWc2tTMWd6QmZXL29hb20wdEwrYUVZT1ExOVpCR3Z0bjg0?=
 =?utf-8?B?SXRaUWdsUStPRWQ4d3BqK05lanR3a0xTTHVTQmsrckVGbmgra3RVWHN4ZHdB?=
 =?utf-8?B?Tk9HdDc2amxRWHg2aUxJS3djT1FBbTVVTU0zUUNmZDZQSms2bFVsbDgvSmNr?=
 =?utf-8?B?Q2YzTjBWekJTL2RoQWpZMHFKYy84ZHNlM3N1anBZMDNhSllGM1o1MXM1VGRH?=
 =?utf-8?B?V1hSSGRpcUdBSFp2VE0zb09OWm93ZXVPVVdQWlRPN1RZZFYyTWVOR2lQaXZj?=
 =?utf-8?B?RWlxNWQ3TFpyN1JMdTdkcnVHaEd5Zjc5QjFsbTR4RFV4Yi9pd0NLRnh3VlpU?=
 =?utf-8?B?UE9rVDNzdXNiSzJnZXZxek5oOTBTckEvRk8vVGJMRjdXdTRLQlZFQmx3aDNV?=
 =?utf-8?B?VzRiall2eE9zOGQyTXJkbVBYWDZiamdkQ0VEWkZ5eHlYY2orZWRkUlM0Y3g4?=
 =?utf-8?B?RGNhRWJ0L1RTd1VtMmlJTkRSK1dBcWJBWHE0R2VWR0RFL2EwdVRIekZtblJn?=
 =?utf-8?B?OUJLNnNiczdQM0d2Y3FWNjFNTmJNOHRpUURSRVdlc2hBdTFrN1dLdUF3UUx3?=
 =?utf-8?B?MHMyZm5MSlFyRVN6SFl2SHVpUTlpb1N3bjcvSjA3T3loM0VMOE02L2dXcmRR?=
 =?utf-8?B?QjBGSk5GMHh4eHduYWtuTmJzSWd3dFM2RlRhaDdyUzcxdFJ3Q0ROY05sSFNo?=
 =?utf-8?B?TFU1UytGOEZoZS96RE1UMWM4b1FOQWs0cWxsZFd3SzdEQm50ZllWOXNtNy9k?=
 =?utf-8?B?aStDOGtHOVNtZWFleDJMWDB1QVExeldESi9tTG9aemxOYXRsWkd5Rm44Nlpz?=
 =?utf-8?B?VmMyQkE0Y1hodnlaSHF2U1F5WHQ3RG1VV3hxNjA2ZGMwZTJkbTFuRHdxdmlp?=
 =?utf-8?B?dzI3Rld2TVNnTm1uZFpjTWRrTFI4VnZMeW1pTU93OGhwM1k5WWZCWHJHa0Rh?=
 =?utf-8?B?enE3SW1GN1dWSlhlR3crNlZFRnZxZTY1Qi9mZyt6aE42WnBoZ1RoWWFuVzN0?=
 =?utf-8?B?N3ZvZ2VpcnQrdWUvaG9GWUx4L3Z6VmxNdExZamNLY3BNRTRxQmVMZGpoanFz?=
 =?utf-8?B?dlhHS0UrM3hnaEFzVXlKUkQxd1NmakNNNllid3loaGk5TTFuUGRyZ2t1UHl2?=
 =?utf-8?B?ODE3ekhvVzVFMmdwOWZnOXFXWnRQUHQwZ1laM1lNYVZjZDllWFFxMVNpREU5?=
 =?utf-8?B?Y0VWVlBZaEtSU0VGMGN6cUliQy9EYXRwR2F5bFY3NS9XSEhHMlpzUDdkbHdy?=
 =?utf-8?B?d21yZVk5OVJDQzR2d09pNGFIdTFMRGFiTE9FZWt3VlVkVGJJSVJXVHBoNHNO?=
 =?utf-8?B?UXJJemdVUmdyS3pMMWYxbnpuOExZYUs0dnhnLzlkbVZuVzBSWHhZcmFqZXFY?=
 =?utf-8?B?UEhHZDg0MnlJeEpiU0J0MmV1cHV2VDFNTFI5YzNwNVM3cS9MaGg5bm4vTlNa?=
 =?utf-8?B?ZlpyRk9WWWpUNVZqd3V6TXE0QUlINEdqSFdxWXVUd3pEUHNwREJvUDNwTmRw?=
 =?utf-8?B?ZWVKS2tjVmM3SlpBUzQ4WHUzcWlzRURiRXlhRUcxK2E0dEw0T29CNjdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk5rM0ZueDBVVmUzUHVXM0JLYndnamNqNnp5WVJKSDBlMnl1TlBGT1dyTHlv?=
 =?utf-8?B?bUhsaCtLTDJlb3pMd25nU0RBWEdlL1lDSnJsa2QvVXB4SjdkV1lXdExEMmRV?=
 =?utf-8?B?bFQ4VmsvUVVpSEkwYVJnWXAycEVtZzk1MHRFQ3NrQU4wYTlBNVoyUTd1MjdG?=
 =?utf-8?B?b056WmcwbjNLMGkzc1ZkTU1aemNMNkxTbUVza1kvczJEeGRMbVNFUzd3K3FT?=
 =?utf-8?B?YXhFTDRBUVBiREF5UnlhZm9ickxpZTJweGtnMUhud2p4RDl6eExQWktmcGMr?=
 =?utf-8?B?QjJZcW1FTXJXVzlxQWdsSFNmMm9BN0hleXJQZ0oxWVZxK2FVVllTT1dwek5E?=
 =?utf-8?B?ejMxOE1tT2hvcGpVMHd0SFlrRWxmamdITzVUZDhKZktyRXBicG9ENGltbU51?=
 =?utf-8?B?NGtMWWxQT2MvaU1IUDAwK1cvNUpUUURwa1NIalFRbjQ1Y3Q4Qm15cWFQZjMx?=
 =?utf-8?B?NTVmY3hhQkJCUmtJWEhVZjU1bUJpaG9tOFVmTFZXTnV0cnVUREZvL3V0NEtI?=
 =?utf-8?B?K1VHUG9PdWJyTHZSKzQ5eWZxbWpOS1pYR0tZWFdYRWRCdEhjNXpxT2VKMVNX?=
 =?utf-8?B?RVRlZU5kL3owblJ4WDRCVGh4Uk9jeUhsa0JzZ2NXNStMWCtJNU0ydkZlTzZo?=
 =?utf-8?B?TkY2Slh3M29PYlExdUhLbkNKREpsNE9FclhkZ1A5Yk1rSXEzdXRIejkzVEpW?=
 =?utf-8?B?OC82OVBlZjBFMzBXc0x6ZUdUQnBSNTJXc2xla0dxTDZ1WTJhTEpGNUs3WjlY?=
 =?utf-8?B?UHZOd2dWcjdRVzczREtmdEt2YWs1SldnVFZFZkRUL0tkVm45TUY0NkxtbStG?=
 =?utf-8?B?enl5bEI0TkMxSzk0RDdQYlhFMDN5NkR4WVViQXg0RklVdlpHU3lHbUVNenAw?=
 =?utf-8?B?STBkZFNLbDUvQjlQUGFGRWlXUGMwYU85b2V3U01xdS9oRFUySE4wZDd0RFg2?=
 =?utf-8?B?a1BqdnpLTVZZeHpaQmU2ZmxtU1NkTm9pUnlzQzFzUmlEVTViRjZuSi9WWnJq?=
 =?utf-8?B?VWtsYThYN3hHUTRlUlFNU0RWODdSazFJdkdyNytCUkxYZDlpc2EzSXhiczdh?=
 =?utf-8?B?YkZMZWJEczhFU29Cd1NmTDJ1d25IT0RWeWlrQlF6eHpXV2ZFUFVTRFFzempm?=
 =?utf-8?B?OHYrOW05UktrRnRPZUF5TjIwaHdZWHZMaGplWjdkWmYyQytScUg0SXpMaTdE?=
 =?utf-8?B?VVdnSllKeFBWdnBVZzg1bmtYbjV2ZmdSNy9JMEN3MXhOeVpZMW1iWjBsTElK?=
 =?utf-8?B?MCtNMG9pb0tXV21xMlVqNkVQS21BaU9ESWpGVHl3aDk1MkhsUlR4NUowM1gv?=
 =?utf-8?B?MGtGVWs4YVNrWXZCWjYxNUhySjBWOUtSUndPT0RUSG5ZbG90THYrNUFQSU0v?=
 =?utf-8?B?dFpuVTBiaXRjaUhxWGRpQTUvM3pFNytGMnpTVWFkNmY3S29xTnA0VmpvaGE5?=
 =?utf-8?B?V25BMnN4UUdLM3NtbUtpaU5PY1N2cFhkcjgvVUN4ZmhqRFY0NlZPRE5GL1F3?=
 =?utf-8?B?K2hNSkdMbEpTNFcyWCt3U3RCT2svSnRhTHlZRjB1cmNvREJ6eC9vZ044dnl6?=
 =?utf-8?B?OW5SQTFFNjlDNStkUzZMckxyMEF0NDlFVHJuV0doUkNqd09iOXVOeUxMZUt5?=
 =?utf-8?B?dVMwTXJqQSt1Y25PRlU4TXAzQkhac0VYY1hDU0dtMGd4MUprb3VLdlJrNlJG?=
 =?utf-8?B?WDc3bmd5RjhKamhlWFNrSTFLbGZVcjIzMktYbXNicks0c1R1SFZsY2VqMCtr?=
 =?utf-8?B?aFVsQ2VSajJHZ3YydjNhSEROSFViVm5pZmlSdG1aUGRDVGhCdjRYVEVyR3p4?=
 =?utf-8?B?WDhyL2xFdytrN2NPY3orN0Y1TFYwWXhuUllvUnNDVUI0cHZ4bXI4OXVBNHpU?=
 =?utf-8?B?dTJjbFdNVHV5MEs5VXJCZVJDOW1mQ3FJQkFDREJibjB3bnUwQnFRVDBJQStW?=
 =?utf-8?B?cmI4RW51RDhhOFhkUElCZmtNR3BlMU1tQm5ycEFYdzZOMFdqWmVZN3JRVVA5?=
 =?utf-8?B?MXlVcCtUR1dzUXR3QXZlREx6Q3Bnb0J2ZVprUjJzV1dqMzE5UjEzWUFERGxz?=
 =?utf-8?B?RFBUbGFhUElGQU1xWlBPblRRSjZ0ZUhDMHc4NWpuMHZDb3g2TmJWRythVjgv?=
 =?utf-8?Q?oLtDQOzddofJuPcO8G9OkkTzh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42591eed-3925-4edf-1e23-08dc7fb133b6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 07:30:23.5917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43P0AcxG/B/eYeN/sruSFuldseoJ8EkNid+5Gsj7xcaQ5J/XdaGTLbeSmh5p/9cK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847
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

Hi,

when the issue is easy to reproduce I suggest to bisect the changes 
between 6.9 and 6.10-rc1.

On the other hand it's not unlikely that we have a known bug in -rc1 
which will be fixed by -rc2.

Anyway added Leo to the mail thread since he is the one responsible for 
the video decoding engines.

Regards,
Christian.

Am 29.05.24 um 06:05 schrieb Wang Yunchen:
> Hello,
>
> After upgrading to Linux 6.10-rc1 (Mesa is left untouched) I identified a strange bug that could cause the GPU to
> crash and reset while playing videos online with VA-API. The screen would first start to jitter, then flicker once or
> twice, but the desktop session couldn't be brought back. After a reboot I find the following messages in system logs:
>
> 10:13:05 kernel: gmc_v11_0_process_interrupt: 52 callbacks suppressed
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b05000 from client 18
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00103A11
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: unknown (0x1d)
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x1
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b00000 from client 18
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103be8000 from client 18
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103be6000 from client 18
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103be6000 from client 18
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00103A11
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: unknown (0x1d)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x1
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103be8000 from client 18
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00103A11
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: unknown (0x1d)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x1
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b05000 from client 18
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00103A11
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: unknown (0x1d)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x1
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b00000 from client 18
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103be6000 from client 18
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b01000 from client 18
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:10 kernel: gmc_v11_0_process_interrupt: 222971 callbacks suppressed
> 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b05000 from client 18
> 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00103A11
> 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: unknown (0x1d)
> 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
> 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x1
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b00000 from client 18
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00103A11
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: unknown (0x1d)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x1
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103be6000 from client 18
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103be8000 from client 18
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b05000 from client 18
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103be6000 from client 18
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b00000 from client 18
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b01000 from client 18
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103be6000 from client 18
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b01000 from client 18
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:15 kernel: gmc_v11_0_process_interrupt: 236783 callbacks suppressed
> 10:13:15 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b05000 from client 18
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00103A11
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: unknown (0x1d)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x1
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b00000 from client 18
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103be6000 from client 18
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103be8000 from client 18
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b05000 from client 18
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103be6000 from client 18
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b01000 from client 18
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b00000 from client 18
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103be6000 from client 18
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:1 pasid:32777)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2857 thread firefox:cs0 pid 2909)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000800103b01000 from client 18
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: VMC (0x0)
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> 10:13:16 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring vcn_unified_0 timeout, signaled seq=5197, emitted
> seq=5200
> 10:13:16 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process RDD Process pid 2857 thread
> firefox:cs0 pid 2909
> 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
> 10:13:16 kernel: [drm] Register(0) [regUVD_POWER_STATUS] failed to reach value 0x00000001 != 0x00000002n
> 10:13:17 kernel: [drm] Register(0) [regUVD_RB_RPTR] failed to reach value 0x00000340 != 0x000002c0n
> 10:13:17 kernel: [drm] Register(0) [regUVD_POWER_STATUS] failed to reach value 0x00000001 != 0x00000002n
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: MODE2 reset
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset succeeded, trying to resume
> 10:13:17 kernel: [drm] PCIE GART of 512M enabled (table at 0x000000801FD00000).
> 10:13:17 kernel: [drm] VRAM is lost due to GPU reset!
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
> 10:13:17 kernel: [drm] DMUB hardware initialized: version=0x08003A00
> 10:13:17 kernel: [drm] kiq ring mec 3 pipe 1 q 0
> 10:13:17 kernel: amdgpu 0000:03:00.0: [drm:jpeg_v4_0_hw_init [amdgpu]] JPEG decode initialized successfully.
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: recover vram bo from shadow start
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: recover vram bo from shadow done
> 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset(1) succeeded!
> 10:13:17 kernel: [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
>
> A crash of the program playing video (Firefox) is then triggered. It could happen any moment while playing videos. The
> problem is not observed in Linux 6.9, it appeared only after upgrading to 6.10-rc1.
>
> I'm new to amdgpu and I've peeked into source codes but couldn't find a call chain for the error reporting code. I've
> also went through drm-next commit logs, and from my understanding the updates introduced to 6.10 are many and I
> couldn't bisect them all. However, I'm happy to provide you with a kdump or a process dump if you request so. Please
> also allow me to know how I can provide you with more information.
>
> My system information: Ryzen 7840 HS, 512MB dedicated VRAM configured, Mesa 24.0.8, kernel 6.10-rc1.
>
> Hoping to hear from you soon.
>

