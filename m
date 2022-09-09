Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EFAECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 15:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F2F10ECB8;
	Fri,  9 Sep 2022 15:42:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F18B310EC99
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 15:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjvVPYWvZDGtY5tx+GlwpNPLgNQLwGtyz+z3+gHmFjt0RMxEVyhJiAIvSlNqBUClfkcNSIDeBtg54a47QctmFh+Ogy86/c2qRNbgmb8YZJMLEALaWShJfPCU29j1U7L0ITjejDuXbos1VBRBJbJnTlsxB5dIwszdhoqeBfbxOH86om1BCcdPxmoZkQkfKOjN71F3tcPz0U3Fdf/UDqHtvGNLVH92pu02tIFIhmVofWPIwp46nISZ5Ro2b6HKGX39/zp704BONnBpHNWr02uJ8BIWVdDOLx69vu9ApUDbUsCRojKwV9O1gXaHF0LUJlr7n5Sbn7YYRa/J9i4VLfmYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4zU3aoOrX5obEUmVb2jNt+5FBjgdAi7vXFPcu3aDvM=;
 b=MLajPQAyhawAWQG///QJZUcGWukDVOF4Jsalv7PkM0dUkAS40YQoAMiq/S/n41Ep68VRoBCPRHG8C9BoE1d3ZrlrYmC8si2q5OwQaAQ2EF8r5z4UTQvTJ32HfvyMJzNzK6TQBOi75ATYL6UCCD/oSqjdRWQCbLhNWfEiNtBeSjbWDWchXRHosHXhVab2lzCYUGA0zAlwFrstBLaQoIZ+c6O9G0wSoGbKqH+1i5YlPyoGE74w5zPwTNm4LW98xGkGiv6gFVNL8sDi90PmU4oA1mKctT1zax2j1EkXNzkNz+TaUnaqsdhoT0xjSqh3i10WK90xyuu21DOM8YbCdEhHfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4zU3aoOrX5obEUmVb2jNt+5FBjgdAi7vXFPcu3aDvM=;
 b=ml7O8fZqcNLy+dzFOlLfBpTpY2r0s34m7roj3P1vQb2UmT8YPNtvezDZL2f3SGemo+PQdvFvFpYJS5BjPfs6VhF/f3mBCm698cQx+xBwLanBv+GnBEB1W50ZXxEMhOu3qj8ciyvAoNDWQSa01n7icoMaItFeQEGghPJ9OQK5eMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Fri, 9 Sep
 2022 15:42:06 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b5bf:2f0b:c13e:36bb]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b5bf:2f0b:c13e:36bb%2]) with mapi id 15.20.5612.021; Fri, 9 Sep 2022
 15:42:06 +0000
Message-ID: <833f3f80-dd3e-e0de-8941-077777332de1@amd.com>
Date: Fri, 9 Sep 2022 11:42:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Migrate in CPU page fault use current mm
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220909131219.23677-1-Philip.Yang@amd.com>
 <cbb46a59-75c7-d3fe-d200-fbf4ea402870@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <cbb46a59-75c7-d3fe-d200-fbf4ea402870@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0034.namprd07.prod.outlook.com
 (2603:10b6:610:20::47) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH2PR12MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: 46023aa0-4c7c-41dc-4c98-08da9279d953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4J+qvKRPBuy4o/EPqKD2mQpALxIcRABRrhw0PzbeMCrYpEKUPrNImWvqO5Dm+h9sKn25rYMBHwIvuB9GTAJQsN2ofyMO32aK8LbX0Nxw7mrGZc4MQrQHIyaBbVAYbMD284J1d9SXOQz8zIlA2VKt2SXngoG4Lw2psmsrwFXoeMqmTMn7XFXHSnAkWhhLO3J2ebgtzJCE41OfFrba2WehHgEYf/hfG4wlq1yGLdqbuvbGM8J/RUymarg13tTQmf4kmQ+NDT++fJU3WcbZWMvqBO9Zy3Wjie9+EG///Q+i4lz0uHbv+PIMibetZSMNVNAWjejWoTHWghjwYqxnt9meCkWzltdvhDeqxaUMPg5rQUFrBZUdsmV2+Q62X94CJ3AGfW+3Rf5bJjc789t/jDD8fwzSc3MYih+r9txT/7JxmppM4Fl7UmU00I3G2tRtmSlbw2jD57Jm4NL9XtQ7dEOvyemCxwawlX2PhLd4r7p2cPl+bY2qlGDp6nza57wQsfZ675TS2pcLVTtqqa3VVp1Hea4xmvU27An/8SMgtd+aRWVxE62QSblaI7NcJodweO0BZhMQCNAE+VTc8PEgHGsTgy7RLdYZcrgSLH6DzJ5+P+gsXuk4EShJqQXuS7iCeECiOT8Hs9ls3vl4WrIcc1SK15Sa0sk4Av9QSfoHOxS1mJ48r/UDZ8ReDkWuwI4nnFFOPdj7N3DfZ7RgbpDa018lAJVqx0LyBqQtwqiFCyqZXwgzbpy2RGrU7i5MtuF5JFh/uXCsxtIyugkYZzqhhVOAuJwoNquFrSzvFajzq0yu6nA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(5660300002)(53546011)(6486002)(26005)(6512007)(6506007)(478600001)(41300700001)(83380400001)(186003)(2616005)(38100700002)(31696002)(8676002)(8936002)(31686004)(66946007)(316002)(36756003)(66476007)(110136005)(66556008)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0xKanVYS3NtSWp2alZDUmxwd1RmUkJ1VTZEWWZuN0htWGxQcjRRRnZTV1gy?=
 =?utf-8?B?eHJ2ZG82SzE3R2ttajhIOGpqZjdTc0NKVG1Ca3hrZGJBbE14ZFdHSHV2bW5v?=
 =?utf-8?B?QzdrUWJxbUQrMFl0SEpXUGlBS1FOTloxZmZ1Nk44RitodmtzdzZuVEw4M0lP?=
 =?utf-8?B?TlFySDYxV0swYk5IN1JMU1g0RExlY1JyM003cEtSR0Npa2tIL01hclpBVWlw?=
 =?utf-8?B?U0c4SVduUVZLWklqTGg3a3pSUVd1ZHgwbmV5aWladDdhdWFVWmdZV1QrSUhV?=
 =?utf-8?B?QkU2SnMvazAvS0hhVW8zZTcraktpQTcyeFZ0V2ZnTmJRd2dGWnZNRkF3S1RZ?=
 =?utf-8?B?MHhCL2VBWWZDT2VqWFRFUC9MQ1ZKVUdpbWhrcXZlSUxZRGdGRWozRHNPbys3?=
 =?utf-8?B?YzBSRFhrOUZOZDI5NTJRWjBaSU9mc0JzeTkzUzhNaTZUK1N5YW5RbUFOSFdx?=
 =?utf-8?B?YmVhamxrbDdUNW5qaG0rMFFGbmNZUmI1Y0puV3duTHBQRHlVS0ZRbEZISEIy?=
 =?utf-8?B?bStSK3lQb2IwcjhBM2JqU3NkUFoyS0MyVmNGRkNoSWxZQVZJdHV1UUxkcnJq?=
 =?utf-8?B?MjAwSlMvK0Qwdm5GSFFtU2FwY081TWVQSjhNWVNxb0ZFcUNWbGlndmE5Ym5T?=
 =?utf-8?B?eGhVSlZHWS9BUTAvUUwwM3g3T090UGtZazVyQW9nYitLMzBqYWY5VDNnZEZB?=
 =?utf-8?B?SzdtQU9YYlBoK1Q1ZG9DOW1mOGk4a0JjcGJmOExad3M1d0VTa0lUdjJISEFa?=
 =?utf-8?B?bTJ0YXZPSzBzRDl1N1NyOFpNZGl2ZVhXcDNlK2FwdW9rWHRzMjF0RDFuTWF3?=
 =?utf-8?B?ZXFqbWN1R2FTdDBoaytwZnRqWk1ISFRucXM4bXliZS9YQkFKc0liV3lEM0lo?=
 =?utf-8?B?bDJHYi9PNkg5SWFSVEYxUzFlNlVZUk5zZnpjYjZESjRPeTdrQXpQdVVTTDND?=
 =?utf-8?B?VGtRQ1AveVpsR1Yrem5jVlFyNnpnNm1lMGQybGxmbWNmZFRZbHhDVmcxTnBr?=
 =?utf-8?B?UUJtcjhQamhiNklJTUlKWExRK1JQTWRLdkFtTjA5dFZQRkwzSDlCcmlzMndk?=
 =?utf-8?B?WXM0OVZNd2RyTXZQcE9TZTUwYXJiNHlrN1JOVUFnczVST0F3N1pvdk9kRmRw?=
 =?utf-8?B?TkpieEZhUWpaaWZmeVdHRlBLek5HUFlSYWdDdUpnV1JhWHlud3JEOXBDL0Z3?=
 =?utf-8?B?VWFGdmFvWnM4OXgrRXJhUCtYZzRxd1FEaTlpZGo2UFVGb20xSUkrQVdoUFRp?=
 =?utf-8?B?YS91L0czOFIwOFd3anovcC9Hb2pWaUNMZDBCamVoTTlneDNhVGNwVitSVG5o?=
 =?utf-8?B?SGt0cXN0cDBIcFVraWpKeEsvL2xyV0hIZWpPNk1PL01GeFljbVkvaFNMUW5r?=
 =?utf-8?B?TFM5UDg1UHM1cmRBb0VDRFdtYUxHQUw1dnpyWFl6YmlHSkx2U3FEYUlLQzdT?=
 =?utf-8?B?dTZFVmltaHowY2dabzV6NENEdXpIdDMzWnpmQWFORE54dG9YSzFGYnkxWG52?=
 =?utf-8?B?Kzd4bHp6TEh0akYrZ3EvaXVCQ1NpR21Jc1p2MW45Y2FDZ2VYQXUyRGU5djBl?=
 =?utf-8?B?bnV0UkRvN0lKZEFXcncvbHlqTFhOTWpVejA3Z0pNVlFHbDFmNzFCNWsyeGxS?=
 =?utf-8?B?WE5nTHByQTh5NElGWmF5MnZXVnBRZERnbk9sU2pKckVoSGxKb29PK2kxT1ZY?=
 =?utf-8?B?YUFkL2VQTzFWa1hDRUFXUDNYeDJNZmFibWorQWg5d2lIM0xROEZwUlJjRlBw?=
 =?utf-8?B?SjNZeGwrblV2UytLREo0WUY4OWRpZk1BN01PTE45VUdSTDJad25XYmd3eWZh?=
 =?utf-8?B?YWcreE9WL2dCVlpjN01WbXdCMExWSFJhNHZJOVQ0QWVkZnNjUW9Xemk2S1o3?=
 =?utf-8?B?U0tvT2tmTFFodEZRUjNmNkIrNzZKWk10UzV5VGZDbCtZeElVczFZNXNxb0dX?=
 =?utf-8?B?eWU5SkFrMXd6bDQ4RUNwcnN3U0k0eFpFMVhiNXBBKy81cEkrMjU1QVJCVnlI?=
 =?utf-8?B?TnRsKzNlaVRHalJyb3crMVZRTUZkUWg5eGMrWFZFRzdlemcwdDhkWmE1REs4?=
 =?utf-8?B?QTVuTXdzUkxxR0xTRDZmM1Y2NFZJSWhxSHRlS1B1SXZEMStyZmxYRU93akNn?=
 =?utf-8?Q?u2iY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46023aa0-4c7c-41dc-4c98-08da9279d953
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 15:42:06.2565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCVWdUV3U9gGfyUQxiRUnmzYGHvqi8GNLt4fWx6QbzaYSo5LlviDSUHrE9jBbdzf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263
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


On 2022-09-09 11:13, Felix Kuehling wrote:
> Am 2022-09-09 um 09:12 schrieb Philip Yang:
>> migrate_vma_setup shows below warning because we don't hold another
>> process mm mmap_lock. We should use current vmf->vma->vm_mm instead, the
>> caller already hold current mmap lock inside CPU page fault handler.
>>
>>   WARNING: CPU: 10 PID: 3054 at include/linux/mmap_lock.h:155 find_vma
>>   Call Trace:
>>    walk_page_range+0x76/0x150
>>    migrate_vma_setup+0x18a/0x640
>>    svm_migrate_vram_to_ram+0x245/0xa10 [amdgpu]
>>    svm_migrate_to_ram+0x36f/0x470 [amdgpu]
>>    do_swap_page+0xcfe/0xec0
>>    __handle_mm_fault+0x96b/0x15e0
>>    handle_mm_fault+0x13f/0x3e0
>>    do_user_addr_fault+0x1e7/0x690
>>
>> Fixes: 5e5bbf36a2c0 ("drm/amdkfd: handle CPU fault on COW mapping")
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>
> For a quick fix, this looks OK.
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> For a better fix, I notice that svm_migrate_vram_to_ram only uses the 
> mm to look up the vma. But you already know the vma here, so that look 
> up is completely unnecessary. So could you just call 
> svm_migrate_vma_to_ram directly? Then you don't need the mm at all and 
> you save yourself an unnecessary vma lookup from the virtual address.

Thanks, call svm_migrate_vma_to_ram directly works, that was my first 
approach, but the prange we want to migrate may include multiple vma, it 
is safer to call svm_migrate_vram_to_ram to handle this case.

Regards,

Philip

>
> Regards,
>   Felix
>
>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index f62c4561f0f4..1cfa4fcd28b3 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -947,7 +947,8 @@ static vm_fault_t svm_migrate_to_ram(struct 
>> vm_fault *vmf)
>>           goto out_unlock_prange;
>>       }
>>   -    r = svm_migrate_vram_to_ram(prange, mm, 
>> KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU);
>> +    r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm,
>> +                    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU);
>>       if (r)
>>           pr_debug("failed %d migrate svms 0x%p range 0x%p [0x%lx 
>> 0x%lx]\n",
>>                r, prange->svms, prange, prange->start, prange->last);
