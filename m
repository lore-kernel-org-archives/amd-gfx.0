Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6185CD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 14:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4186810E5EE;
	Tue, 19 May 2026 14:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aH+sXK/u";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A9B410E5EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 14:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rktrLLghkP1VsyYteI30MQkkDJYyTeoF4L2CBYwPu+kWfKmvd9MP5QZbAFg/D0jFn+wWvgjmfy3pdY1RTwaZ/oxzrjTy5Qvdo/kALgJoNzA0PEYTv+XlFKgnTf+ARsReBkeUk76c0PKatr+/FtnwJOM72ohxL5F1S+fXGjdqZqDUnOfW8VnB4bfOdl7yaCfuJvJHYIwA9bMBgU+TIon2A2/vTckAkQZtMbszSQVVTlrYFe9pAPq+P8MDG6Znhcfh301phemMsvoYCXENYmb3Hpa1KZb7k7ANcIv9hoHrIH9GfhzSEHUsLbb1dxHJfEXyZwwdAeW6FzyBlT05UTJ+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOriBzL1an9WErGlwytOzqdsPcIHxaDa6Bb4mRPxNIE=;
 b=KQE3miK+aR75FrqvX37j1MPLnLP7K0YBVNEwuXVXsWgM886IWMn7daJwhJXUH8GYcdITXPn3CdRHUeMYx+igiIQaqe3paZTl0uGx+/9Il+zZwU98iHJN9fBiVbq3zLFLCLBT/+4gqWCI/PAMR+hPSNhGMrZtGg2CS7ZIfA6tQfkKWhXvUP4JJky4zUGxp5mUtsGKdPRcm8PgBuq15yiG1uvllST60DL5qAuXCbVdMm6pzTSSH3Ssj5s0NVhODg1feD7aEMKksWeZZB7q3328jxYTfm44U48lIqQdlovPkq1uOOmatBuXVDuSEtzy6lUy60uF7EIzB6MHUsT/FG4DcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOriBzL1an9WErGlwytOzqdsPcIHxaDa6Bb4mRPxNIE=;
 b=aH+sXK/ue7lx5d4JJTk/cyNv3dxzJBOB8rKdVZLd3jW/Qvp+eo19Rr9b4g7uLqFI0XI8C6sX8lSZ2JT+c7iVwclvo4S//kEZTVgLV08A1qwr5fpk2Pi45A8Ndy71JVAskfjrdukjnGEL4B9MC1zqc1v4jtbgvVpou9KUnS5z8Gw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by IA0PPFDC28CEE69.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Tue, 19 May
 2026 14:11:02 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 14:11:02 +0000
Message-ID: <ed53a285-01fd-4ebe-b3a2-22cec492158b@amd.com>
Date: Tue, 19 May 2026 10:10:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix NULL pointer bug in svm_range_set_attr
To: Eric Huang <jinhuieric.huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260507200408.208219-1-jinhuieric.huang@amd.com>
 <c842f2ad-c4f6-4d99-8db6-b98a767140d5@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <c842f2ad-c4f6-4d99-8db6-b98a767140d5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::9) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|IA0PPFDC28CEE69:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ef9cea-dce2-4300-6fc4-08deb5b0754c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: a9PS2T5RAaqdt1+Za9iTpv+1wghHIK/LQNUZaetoxa5tavVhZpu2qNYvNj7smGYRv6eJdU0Ol05i/EBVGfETHWEZV1jEP/yXk8iku3H9kNRC7Wb6z04Z2HKI2qQNxEoG1FtC2eUPsUkAuO1RqaC0lqfyx3F8czzy/S/UUKBiqc+DmS0HMq0qtTEymJISUc4S6bV58BYy0OWEwziP7uhy3bSkz+FCGnST6aITxfIqXPKL3d/YLw6ULDcDo7Ku2uyd01k4zBgyByCCImntXdyT6kaw50k1W3Nhl+Oirsa2tL3jnuDD6Bh+j5KeWZvju3kq+W9Gtqf+9pSgNFlhXunFUU0XXCPLQvXW7SGUuf6ox9SY8mHPgVuTN9GG2RiYsSSnAEFoxxwj+xwcfn5joE4q8qazie/ruGMReRYQMg91u3o+wbSfxb4xDXYLz0gatr4tXfaC0hXWvcRqwQfdmlSyFtL7SOc/LdRfRKAmD41kBnPAhYfByhlfYG+wqAfTNbN6zIQ8JdQXDSjSzsxfaLK9pg+lqpL104jQLv5yDBolVU2R7J4As503fsjzZ6q1oAOHK+RvYVkrSTRBXCzvq6qJ80DKn95dVgShTsRzwept3BAqMT6mcAECQBIOV+Cp7k0a4uurTFrezOZIBmKzQ95C4xfsPK9tGeY/9Br/s1yYZ5FfOFLj4kA2qe7bkiB6ZhDT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFNEcjNnek1uaG9Zd1d1ZTgrbnQ5THVPRzRsTlNFRlhlL1RjY2liODNOMWF1?=
 =?utf-8?B?UWQxOXZIWUZhQTdlNDVFTnRZaGVuZm9semZGRWZ4aExjVm1CTXhlUzJBY3lz?=
 =?utf-8?B?dWcxTFVvWmhwT2dhbk1uaUtGenpXcGVoak1oR3JKRUZZTDJUdDlsZlhxWE9o?=
 =?utf-8?B?VGVNaFpZSjkyN01FWE9wR3Y4ZXJQbjZrZDdtWmlPZS8wUkZqUFlFZnpEMTUr?=
 =?utf-8?B?Q1JuSnNtckxsV3Z3eTJHY0Q0M0NzSWNRbHhobFNnYTFLNzFVbDhUVUNibDlp?=
 =?utf-8?B?ZG9Rb1ZBWDlWNmtUQWtXK204ZDEwV082UllMVVoxZ3JFeVpLTHArWXRqeWE0?=
 =?utf-8?B?SFNZWklnaE1Td25JSTJiV3JBdGZQQ2lrbG96bVZoQVhWeDBCcUxINGF1Z0NR?=
 =?utf-8?B?VjNvTzdnWklrVnJHTENRWTBkdDlWY1RmS0U5Vkg2RklpcXlaMExHWk5MdUl1?=
 =?utf-8?B?MFp0dEQ1b082czJzUDlQaEtmem4yazJVTmlIQ0taaVcyZ2RaTENFV292Nzdq?=
 =?utf-8?B?VDFENmpDakJVeThBeExUMnRuQjFtWnlQbXJ4QlU2bUU4bHhWS1Q4U3ZCdU1G?=
 =?utf-8?B?YnNXZmxOZ05MWDUrSXdWRWM5ZzRxRUI4R2VNYzVteUVxT0l6QzdTd2JxNk5v?=
 =?utf-8?B?UDMrTUpjRXU3cWs2VXAxT1hKQmlnK1lVSjlsQ3RLbGwyZ0JObkdyaDBTSXE4?=
 =?utf-8?B?Q0dkKzVYWng0b3hCRG1iUlpwcUprODJRZHZkYXI2UDlsREFPUWNya2pTSHBZ?=
 =?utf-8?B?UDBKQ1NWaHUwZE5Xb1piQnNOOXpPUDFIVWswZmxKZkx2WmlBME1ibFR3YjBH?=
 =?utf-8?B?ZTZpL2crSUxudDFuZmRDdzBvT2ZwcEwxcEVsaEZSZ3cyQjBwSVZIbEdwbWps?=
 =?utf-8?B?YWtXalBjYXA4U0t6U2UyMm5OWTBVNUJOcWFHSnJvNDV6Qm1NbGhEZm1kZWdz?=
 =?utf-8?B?N29KdG5OQ0pqUHRDejRkaHpqeFlNQkN1ZHFqcFZEdkNSdUVhRVloUUdCM0FF?=
 =?utf-8?B?bTZQcTR3K2FMUU53WHlRU2M1RGo3TUxSUzFoOFFsZDVPMlJ5cVpZNVZ5dmtm?=
 =?utf-8?B?Y3A1cG5VcTdIaTg1Qzk1T0J1aFZ2TzJ6NmJrS0Rad3hEeXRvMEdvSXVMS01K?=
 =?utf-8?B?VDlzRTJQOVZwK014YitkOVh4akVyRjZ5bStIejNyL05wQmNQK29HTHhnSHND?=
 =?utf-8?B?RmNQcVNKQVQwa0xJdDFJV0g5ZTI4NDVnc0pFNVh4dnA1eE1MNDY0dWU2NjJT?=
 =?utf-8?B?SWU3aUFQMk85a2FuKzVyQ0hYdUtxUlpsbDFkT2ZFUTdDQ1ZMZDlKQm41ZGZG?=
 =?utf-8?B?OVhsNjdBdnlCdmFvaG9wTFl0S0xRaS80eGRDT3B0SXVidHhzdkNRdEhCTlo4?=
 =?utf-8?B?WkZTMjc4WFpTR0VIQVZMVVI4OFRmcGwwVzUweUs5QU82NiswRW9jOWY1WjNw?=
 =?utf-8?B?QXpUNzhnZDIzUFVPa0svbDJGdlltUmg5TkYrT2FOaUlHQjNPNHJTM05Wdjdr?=
 =?utf-8?B?czhzekJPVzJldERCaUlkOE55NTA2TkFmS2lRVUlGUzFBcmZ6V1doOFVLNDBt?=
 =?utf-8?B?TS8xMk5UdE5qRVpZb2Y1U3NPK0ttZ05uT0VyVVl6eVZQYkllRFdIcC9wNVBv?=
 =?utf-8?B?S3BwdThSUVMwUEtEMi81K1h5ZDN0Ti9FZ2NYM0JTdXpVdVJpd2ZrR1ptcVB1?=
 =?utf-8?B?Y3NXcFp3WFlJNFY2aVFjZVl0OWtqZDR3RGFOZUJNRWlxYjZ1T2orbm5HVmNj?=
 =?utf-8?B?emFuZU41UjRkVVZDY2gvQzhyQ0FrZFpVOTM4c3Q4N1VOQTRIdkRZN2o4RjA4?=
 =?utf-8?B?RVYrQ2lrQTlpR3Q5Wmt4Y0VjdGRNSDVYN0YvdHZDUko1ZDFZYmxUQ09MNkhQ?=
 =?utf-8?B?OEtuS0pZMlNwb0R1SlZsUXVsVWwwL1lQWlBtenRNWm9PRGUzNGZ1cTRGalFj?=
 =?utf-8?B?aUFhL0pkWmNMd3lPTUxFK2E5LzZiMk1RQVZ2by9jbUt2NWRyLzZ6UWZzaURR?=
 =?utf-8?B?MmFDNVJ6bWo3UTE5dGd4THpiL0ViNnhUZXJSQzFIa2FJL0Y0TkYrazllbEJJ?=
 =?utf-8?B?Rm5HUU1PSzkrNXpMYktzM1ZJWmFnY25jSnNVbUE1QXBYY0lvR21takRuQmZO?=
 =?utf-8?B?UVEwV2pGOG95MVlTeUtMeURTbVdTd21ISGdVaFhob0VLQzU4RWJjZmpQdG9G?=
 =?utf-8?B?UTl5cEVaQzNQV2FVcTVXaEovQ0dOc0RveUpkeTlvZjdkTVk5dXJ2M1dEc0Vu?=
 =?utf-8?B?VTdkQkdPZDNKaTdoeXhFK2NlMzZ5VTFLYUNJbnBLOUh6QWRaSnVycXB6dGtW?=
 =?utf-8?B?Rzg4bnlrdk90TGhmdmhGMFRGdzlHVS9NZHBGalV6eTF0aVltc0V0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ef9cea-dce2-4300-6fc4-08deb5b0754c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:11:02.3205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yu1gBEeEuUd9EMXkDOApEs2bP8P/S+6xRshSpT0QkzkMRjRI5eFnOPIQ4Wsso4o9CnhiFjGedsqblPmUasb8KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDC28CEE69
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

Ping ......

On 2026-05-12 11:09, Eric Huang wrote:
> Ping ...
>
> On 2026-05-07 16:04, Eric Huang wrote:
>> The process_info could be NULL if user doesn't call kfd_ioctl_acquire_vm
>> before calling kfd_ioctl_svm.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 25b3ecf85f30..72cfb4a6ab3e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -3732,6 +3732,9 @@ svm_range_set_attr(struct kfd_process *p, 
>> struct mm_struct *mm,
>>         svms = &p->svms;
>>   +    if (!process_info)
>> +        return -EINVAL;
>> +
>>       mutex_lock(&process_info->lock);
>>         svm_range_list_lock_and_flush_work(svms, mm);
>

