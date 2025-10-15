Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E69CCD185
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 21:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A471F10E079;
	Wed, 15 Oct 2025 21:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yDwK5SlD";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C63C710E079
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 21:45:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kt1Kcv1PjxxXQfKTW22iO8V6RcRhZFeGrXLj/JskHX4DCUFB+eqJtLDqewPS2Vui6FOHmlda5Z4FDwFaB57eZJD1KWg4yj0X7CGR+oOsIxeHPfA9jtrsqsnoJMvY+zNfya6P6XHnMNyx7BTt3txHPwNEdvhGAId/Ng5NZv58yn7SVFXgJH0Ogt0YwF3SoL463L2aAGjPHXUwInwYoVS4amVT0skPnOpcRN7fnKoKDTR+bTrQLBYVQwHiuXeg/A5NPrIjFPwsYjSg+K7g/Oap390NEu1qRF9n2e8AQIE08mY8rBn5HnIJu6Znce4gzA5Uadq6OQzBoTqhlEegQScvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkQe3Ct4E/TmgqdUn2OXl0eIGTyr7kffEiDXynz/ODM=;
 b=N/vK2fAV974v6aRPlKf4DUx8JqNGSTinvMIQx7Ob7qzUiei7Rkos/SEraLkWIxNjylZPALwqjTkHvETP9WuhOCRtqN1AGMBpRa8cCosUU5V8GvHsnbyHujnEGAjP5Gb4jtxwHvqiPR9uADrfis+qPdI5ey+V/4vTL3wy1ArvXB9mI4fEVepmvGkE3G8oI136MoR6wEbj2LEGlLlOece3yyWr6DeHDdjbqXHexbd72eB6M6n4F899Ps6s7VMfrccnirtKx8I5zc2pIB7MT7OdRdz/tI4YealWJQ/K9dyr2CYk3l5n/q1eEEUq9ihwYAFyw3zHgH4sqULAHZPVU05bTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkQe3Ct4E/TmgqdUn2OXl0eIGTyr7kffEiDXynz/ODM=;
 b=yDwK5SlDpk9YQqWvj0tMyTJc06foLIIktfnA++XXZzp1tMYLPWocS1V8otks22hFjGsk9Tv6VfB3G299VbIZCuPXVxtICUsIzv3YzNY84dvz4bF9Oh3B3KEwAG4m2qSPEzyQaonCWiGWYRkZT8kgY+lUz/UMm99EnzYqE/YbcMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH1PPF931B95D07.namprd12.prod.outlook.com (2603:10b6:61f:fc00::619) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 21:45:40 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 21:45:40 +0000
Message-ID: <42c82bf6-e100-076f-18a6-43a50e758d8d@amd.com>
Date: Wed, 15 Oct 2025 17:45:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] drm/amdkfd: Fix false positive queue buffer free
 warning
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20251015201134.2540-1-Philip.Yang@amd.com>
 <682f9477-ae2c-4022-be84-620cb02e388a@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <682f9477-ae2c-4022-be84-620cb02e388a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::13) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH1PPF931B95D07:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd008de-b782-45c5-4169-08de0c342f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWJxTEtVaERKKzhDeDlLWHRGSW56aEo1N01lcTBIWU1FRFRHYVZ2Z0ZzaG5I?=
 =?utf-8?B?STNXSTdCRHpjcURhZ2RwU2crVjJsSE0zUjVXSXBGbC84eDU2NTY5N1NmSW1V?=
 =?utf-8?B?bGZUYUFBdmtOeG52SFBIa0VCbjNkZE9OYzNEbXFwbVYva2xPU3dxY1J0cEtF?=
 =?utf-8?B?MkMrMGMxbVkwVVJNMGhRc21wakx3dHlud1BaK1dJNnBady9STURHUEYybUVw?=
 =?utf-8?B?SkI5L1lyMmcrMFRQL1YxdE9NMlRDcGdlbnpsd0l1N3p4TW5NUFVaU2lobU9I?=
 =?utf-8?B?eWZkK2RrZXUwQUtzUC82WStDcURFT2RHa2RuNEFUdWhwZy9TckM3SXBBRDVx?=
 =?utf-8?B?T2h6enRjcjBkYnFSVlVJbVFQc3duZnc5ZVJyWWREdW95RHFnd2crUGw1d0xU?=
 =?utf-8?B?bTZxMVBjcjhIUW15TmVSMlh5Z1NickViWkVIU0Q2bXFWNzBOYlA1OWF1Q205?=
 =?utf-8?B?d1JRc1RodFFpcENDazhQTjZxdS9Lc3dCdzhYL2pvSS9YSEZsNHVuSnpSdnFR?=
 =?utf-8?B?SU4rSXlURGN2LzU2aHRWQVYwR0YzeHM2czRuSnBBQmhRanNneUsrSkUvQ1ZK?=
 =?utf-8?B?TnRJcWpTUHkxSWNOa0VJRXFjejByYWxKRUZiZldiRXkyK0YvU1NOMjFaWDB0?=
 =?utf-8?B?TmtOOTlNM1Q0RnNIbXdFVTE3Qi9neEJQTVNhZW9ndXpyK3IyenpCMFByN1h0?=
 =?utf-8?B?ZllvU0hqaHdOZHZLWENWeHlBV2NwNEZOcDRyYng3WG5xdmRFN2lSc2k2MElP?=
 =?utf-8?B?MmpRK0xteFJ2M1NOY1dLTFpSSFU1TWhyb2tRMlV0QnpBODZ1TGhDcUE5YzFU?=
 =?utf-8?B?eEppYWIzN1g5VUdXRkV6aEVMMFAveU1FOEw3dmhTbWRORk9TQkVYcWhXS2sx?=
 =?utf-8?B?SGt6Qzd3UENYemRFY2tXYXBTMUgvNWVHM0tUQkRXZGxacSt4QWUxZTJISXBy?=
 =?utf-8?B?QzI4QVNMZHQycnM0eW5hWDNnditXQXQ3UEFmdWVpd283TXcyV1V0Ylh1Rklj?=
 =?utf-8?B?NWRCZndCd2d0U3pZb1ZuTkw2aWRhTTJMRVdiaEloSzB1MWExbmVrZ1lQZDBD?=
 =?utf-8?B?bS8xOVFRYzJXc1BiSFByVHVVdzdOS0U0djlXbFdDa3g5Tm9RdjVoQXY5ZHVk?=
 =?utf-8?B?OXJqQWtNQytmYzVqcVE0bVFwQTI0RDRvb3lPVWU2ZlhWOElETWNWWStxdHo4?=
 =?utf-8?B?eEVhN3pxM3c0Y2t5TWdzbHJYek9Ub2dGYTlMaU1kbUNFRUZVZUV1TmtTYWpY?=
 =?utf-8?B?cmM4QlJPeC9PWit3OFNLWnJQcGlWTXMxcVpwYk5hQm53Ni9qQ2xHNGswdUtu?=
 =?utf-8?B?Wk5pRVhZRHcrdUhCc2VjS29tY0RYeDhkMGdqZUh5c0wxaWV6dUs4ZEZpMy9n?=
 =?utf-8?B?WFgyMG9RaGd0V1NjMGJNaXFUdDNuK2JkLzRQcWhrSFZabkxQM1QrNjRtOXZj?=
 =?utf-8?B?M3ZQUUVmSmZ0Yk55UWM0aHF6ZWd3ZEVUTldEYVlqMTl5MUNXTHdZdFhXdTY0?=
 =?utf-8?B?VEZ5b0xlbGMzWUlWbDM4NmVYZE9LN2UwelJ0aS85cGRYZ3hVV1ZOWGY1eGs3?=
 =?utf-8?B?bWpWaGtoa3FacGMwUEVLOTBqQU96U2JnNDhlSmVIMlJGYThySW9kN3BXNTVP?=
 =?utf-8?B?YWJvUzR5Z0NhSitiMENUZ1lIeU5OYUNxb1U2aUduZkRqd1p3ejlHYm5QckND?=
 =?utf-8?B?TVlQUGZiVlhsN25QWnM1MWpvY2U1K3BUMDd1Q2lvRlFlZXhLam93MVN0T0l5?=
 =?utf-8?B?UWxGUlNwdncvQkJKdXR4dkN2ZzNtZ0FMaHN3TTRwcGN1TlQ1ckRTbDJYM29l?=
 =?utf-8?B?aHBZZkQ3SXU5Ty9aN3dzRVdMTUtVd0N5VE9DYWlraEhmQ20wN2hHanpWMmsz?=
 =?utf-8?B?RFpSSnE0ZDEzajIzYnR0bGptOW9rbHpoL0V0ZkRmZ0I0K3BnSW5lbC9zZzJ3?=
 =?utf-8?Q?NzokEBFX2GJ78oVQbJp3f6qpSL8ll5SI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2Mwb0wrNHNPYzkzUjgrTElrZVRxRzBPSVorSTQwYWhjaE5xNVlYN2t2Kzcr?=
 =?utf-8?B?aVA0WmJFR0F2N2xIcTZCcnRCOE9HRnRFQTQxKzZWa3dUK1FHbnM5TndYZWMz?=
 =?utf-8?B?emQrRUVLNnNScGFlY2FLWTRIamloQ3NSZzhDa083QUhCV3ViWjQ0WUhQakZ2?=
 =?utf-8?B?VS9UcW9zZjhzdk5iMERpRm83Vm51dmQrS1pqQTB5ZUVFZzJBRkhRMXRyNGdS?=
 =?utf-8?B?SGZVYk9wdHEvZ05iZDhXblhialg2M04yeTQwUTJvWXQ4MTJmNTVTZ05aeUJV?=
 =?utf-8?B?clcxb0FTYWFyZnJOOXpVc3kwZ1VUQTNBYi9wNGl3eGtJZTNIdVAwUFk4dGVB?=
 =?utf-8?B?c0lpOFhiakkxR01EUmtNdkh5MGJMOFdhWXhvK1ZNd0hDMXN2U3hRK3NUeUVn?=
 =?utf-8?B?S0ZJTDhqUXYwMmtCNUUvWXNTaE85SjZFN2YvUkxldUNxVzdqRDcwcmJxY3Zx?=
 =?utf-8?B?cXJoblhqOGxZSFpoRGFjNUxNSC8vVkJ1Z2VPdE8ramQ1a3g1V3ZJbFlYelhy?=
 =?utf-8?B?aWdPZkc3REpjZ1BzdXZvcjhZVzhOM3pGMWNQN0FWSEVVeDJPZ3dCQVRVcEl3?=
 =?utf-8?B?OUY1MjZiVFBJaTA1K0xvOTdhSmd2THBXeWU1aVBacUdjdHNoQjRRUktKRFFT?=
 =?utf-8?B?RUtKVUxFWm85YW9oWndoOTRmdEdTOVAxaHY2eXNMSjZlRXhzdVNWVlVYTGI1?=
 =?utf-8?B?dEhVV0Y3UDhFeFgwWUJQUGhmTXVkMmJiWkkvbkErNHVnQUxTb0EwZ3c5TFoy?=
 =?utf-8?B?VmFOT2NpSDhjSlBmM1JCZTNPcUN1Q2pwaXAreGRsTDNTZzZEZjdCZ0dNK1Bk?=
 =?utf-8?B?b2lUcWErUWNCU2NSQnFCc0FsVXRWaXFSVGdCc0FSK2Y5NTJ2QW9OVng5dG1k?=
 =?utf-8?B?L3QrYW9Jalh1WUFudVE5M2VyOWRxbU9ZbWorZzEyYVhCNDZkcjZhb2EwN2ZB?=
 =?utf-8?B?R0ZuV3ZpNHMvYysrTUk5dHQzYmJZY3MyMGhvTXdJNEtZVGhsa0JueHFScFVv?=
 =?utf-8?B?dTNJSmVad3dac0g4UWF3ekdsNXoxYnIzTTJOSHdwc1B2aWhvYnc0NVpIVEF4?=
 =?utf-8?B?bDhTSWllNXMwKzNnaVErREhyOGM1azU5TE0zRlAvRm0xdDVpR0E0OXBTaCtK?=
 =?utf-8?B?OGVKM25WZ0JJanM5Mm9ZbUxUbUk2UlVubnBHM0N2NElpOXFmMm1sazlCdEZ5?=
 =?utf-8?B?T1V3WC9GYzFhRWFQdWloUWZrWXl3MmV3cWRIdFFWbFhMang0a25UNWxFOVBk?=
 =?utf-8?B?T1c3Q3FPTWxOcng3WDZSOWhiMERiTlg5eXlSNlFYUE9LMFF3ajMxUnpyMklw?=
 =?utf-8?B?UWU4aWQ1ZXdRZERTU1NrMVY1a3dIbkF6YmxuOWJScHJkZEYxcmRmTXRzN0Qw?=
 =?utf-8?B?Q0lValhxSTNYTGFwaVhnLzFCYVFKbXN6dTNQc3BJejl1enBjMUpsRGFhRWRF?=
 =?utf-8?B?ZTE1YU5yTmlkbjBzUWNsVVErVDVnZ0FzM2dvRDh3NC9yTCtIQmdwZUZlTXNu?=
 =?utf-8?B?WW50OFVIVzN3Zm1sZWlFbFB3MXBjMlF1OUtTZ2hXbVNoTTdTN1VOZUZqak5B?=
 =?utf-8?B?ZE4zVkpnR2dIOTZnQ243RDd6a2Ntbk4xWHhnS3orTWk5UkVjdDByckhMTjhi?=
 =?utf-8?B?eExNenpSbi9ORG5rUWdxN2tZQVB6MGF5RExQYjBHYnZUWnFtSXc5U3o3QkN1?=
 =?utf-8?B?MWMySnVVNCtTQ2UvZ05nSVNHVDc3UERUQlMyWE15KzBaRUtIUHJ2QjZodzM1?=
 =?utf-8?B?aGl4NG5GcHVWV1VyeFc1bTQxSXZ5cmplS0pCMXlkdVZuY0QwWnpmS1JTUEY5?=
 =?utf-8?B?cHRPYWRKeE8vbHNmaE5KeUJpQllBanpYbi9XcE5KeElqTzk0Tml0Mmd2QUtl?=
 =?utf-8?B?RTlQa1g2YVFiOWVyVkphdkkvZEpXeXM5VDZ4ZUk5MVNOcFJtaXZJaS9pZUJ5?=
 =?utf-8?B?alI0eXgwU2tzZGVUV2FUMjNHaXE3NGtqWVcveHAySU53V0V3SzFDNmE3SzBE?=
 =?utf-8?B?cTVVUllzY2FraE50UW5jdTlKYzJWdnJ1MVdwK3FXRk5URGJIc0Ryd0RVT3Yx?=
 =?utf-8?B?dlRQaVU1dzQwTnRPSTloSUVhd1VHK2R5RVFYYStnS0RFUHdDWjJrclpRUmU2?=
 =?utf-8?Q?Vul4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd008de-b782-45c5-4169-08de0c342f6e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 21:45:40.8210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uNlGuB23awVMqdmCdo0ZJBQrXOQgPTWhxc4j+hKVHCpvSXzCjnY+12SjHPsvuVs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF931B95D07
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


On 2025-10-15 17:01, Chen, Xiaogang wrote:
>
> On 10/15/2025 3:11 PM, Philip Yang wrote:
>> Only show warning message if process mm is still alive when queue
>> buffer is freed to evcit the queues.
>>
>> If kfd_lookup_process_by_mm return NULL, means the process is already
>> exited and mm is gone, it is fine to free queue buffer.
>
> But another question is why a prange is still alive, its kfd process 
> is gone?
It is application process exited, kfd process structure still exist and 
available. The issue is race condition:

    do_exit
       exit_mmap
a.          mmu mm release notifier, schedule kfd release wq to destroy 
queue
              unmap_vmas
b.                mmu_notifier_range(.. MMU_NOTIFY_UNMAP...)

the step b is executed to unmap CWSR svm range, before step a kfd 
release wq destroy queue.


>
> When unmap a prange the queues that use it should have been stopped. 
> If not, there is problem somewhere. This warning message need be sent 
> no matter kfd process exists or not.
>
> I think a real problem here is kfd process need be alive as long as 
> any of its resource is still alive. In this case since prange is still 
> alive its kfd process should not be released(p should not be null). If 
> not we need wait all pranges from this process got released, then 
> release this kfd process.

kfd process structure is freed in kfd_process_wq_release after 
svm_range_list_fini.

Regards,

Philip

>
> Regards
>
> Xiaogang
>
>>
>> Fixes: b049504e211e ("drm/amdkfd: Validate user queue svm memory 
>> residency")
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 4d4a47313f5b..d1b2f8525f80 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -2487,7 +2487,9 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, 
>> struct svm_range *prange,
>>       bool unmap_parent;
>>       uint32_t i;
>>   -    if (atomic_read(&prange->queue_refcount)) {
>> +    p = kfd_lookup_process_by_mm(mm);
>> +
>> +    if (p && atomic_read(&prange->queue_refcount)) {
>>           int r;
>>             pr_warn("Freeing queue vital buffer 0x%lx, queue evicted\n",
>> @@ -2497,7 +2499,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, 
>> struct svm_range *prange,
>>               pr_debug("failed %d to quiesce KFD queues\n", r);
>>       }
>>   -    p = kfd_lookup_process_by_mm(mm);
>>       if (!p)
>>           return;
>>       svms = &p->svms;
