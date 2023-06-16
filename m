Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8503BEB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 04:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E111A10E595;
	Fri, 16 Jun 2023 04:36:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 603A210E595
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 04:36:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+ykiqvzBZH4c3/afzbB6VjAgPzflEN1r4GYSaOZg7d4RJgZ2kJ9OuMTE2Nl+lKmVNTZFUZmEUzie+vWTgmS18MOWqq3sp/jC1I/4cb0nKbLNNHTmkrEbQny/TOJPHTV5wRFrmfRkDQpWgw2D1jBLRMZl6gAO0cQ6+8lYTQ9GxC2A+sko8QbXABTPWG9AEwIig/wMRtbNQfqDE1T7Zw9rxBOr5ABL8rYeuix7M+8wlpGwCucTy18CAvjNeTPAQW0THi78chkrSykOXotbwL9eN61g5Jo35nvwfkUWrLu1dCDRshwTAXif0iO83lsqwHEWIRvUvyjJ9XzbCmOTCGoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLSDhKtKk3jTUetFi4zcrzcYk4jlN3uTdBMdB0tXSIw=;
 b=gPCuXAw7GVeyEVfLmL/JQMwqmPHtz+XI6gJVOBG0ND1A5IRlkWrwL106SB9HMPej8ywcqkoVyDLDCTGexcy3e+qQUG+Mx95k7tTftetFQAzKS/tcJkTAPETn4N9Crq/oSEfxnMnTpDrpgdnfo1HItJtb8ZSXddIXi0h14GNmj+dM/Qs6QHZGFE1EJQNia3LqA08m4EHxPjN3xgMEMTvdUD18vr1vGUW1cmYcH5ga/4qxXBviRY36hFjR76uvMcMXac9K4sc9ibouVS23ZPLO4e1fw13pmlT31zlG0owloGa6kulVNy12Xq4o1zkFeYcoKBj4vBtdOAa2NM0GEPtRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLSDhKtKk3jTUetFi4zcrzcYk4jlN3uTdBMdB0tXSIw=;
 b=wsKQuR59TV5k6TdoHp3nEkXqkSFN1BvxsAw516o9t4lAyuJvz9f9JQAGXQMvScVdPPCTxty+HDjfwMuWfKncgJA2UWv1CAgMFk5iKiKcJgHVxSgV0ufDAqdx2TpZrxCM7oPXp6RFfRlhEhCBdJvxX6jQfBJhwZJ4J8Kv6aCcGIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 04:36:17 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da%5]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 04:36:17 +0000
Message-ID: <60100ce7-d3ce-fd4a-e9a9-bbbca9705c26@amd.com>
Date: Fri, 16 Jun 2023 00:36:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: set coherent host access capability flag
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230615225442.11083-1-alex.sierra@amd.com>
 <d32ef44a-a963-0063-743c-559921a9d314@amd.com>
In-Reply-To: <d32ef44a-a963-0063-743c-559921a9d314@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::28) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 055453be-79a6-4a64-dcd4-08db6e233994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKf1KiC+7tdDvIjmK5qLKaQnxdNMOGeX26iQYv219SlCI8RG9SlNUiloHqLHJJxqfNIA6cLySIqPUyIjJffzuxPkvYAwRlpumA+PpHM8Huh/mRVSJCwdRCEdAtavBGW3eBUAKZp2kxXMqZ0LbKB6sLzEydNYrqc5dUTEwVZMLLzgp0YHjoHM5V3AcyHJh0jk7Prt4QxRJPUbgef4evC2Aqz5cwAOzbe1PGErwSVos46LPcJ292QIEI85WpzlRzOwTu86c3O3SUWM9HqvPDtsi5TeBZKdX5xyFBqpiqkh+GmayGMmopKSPEQUOJAsbKnH0m87WIscRy992cIVHxcGR9S8oVwwyEhJSJi9t3bCR/VVGYDqrQuOEZ/pa74pwuLFCQ518NQv88qQANkAtH2oOYSddpD+w0CXaC0MCU+CWfb22UUrp8meu+MF7NNPoWXHd6QeDtvDGrZ885WNmoS4bJQzbmYJVblj6ZEAJwkzYKOIKS1++QOjaIUqux4vRwXWkJyCYwEMGRy+UHjWhZItNyqO8osh8TxmuJ5Wt/x0vwqQE9yx2E718mFVMyzbumgAamm2qlypg/G+Tnwef0wjx3AaU0X9Z3Qrpbj0WXdYbqW2a5jinkC88VrZsJOhBP+JKYYqpVIEHFjdg0CY2DcHBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199021)(31686004)(83380400001)(6486002)(2906002)(44832011)(31696002)(478600001)(66556008)(66946007)(316002)(66476007)(8676002)(4326008)(2616005)(5660300002)(8936002)(6506007)(86362001)(26005)(38100700002)(186003)(36756003)(41300700001)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnBlMUNFMnpHRGVyMFptTXUxcWk4K0Q0TDNkWFZOUXlVR1FsQTN0cnlWZGRq?=
 =?utf-8?B?VU9ZaVk5NXUrdS9VUFpmckMyd3dGcnhQVng3akRxSHNIWTRXZmwrZjIvbStk?=
 =?utf-8?B?N080dCsvcHBvVjJzRkd3NnRpQlFrRVBwd3lhMjB3Z2NpV0E5SkdLK1FJcEF6?=
 =?utf-8?B?UzRBbC9odkpFblZmWkxzRmxYUTNKcXRFWlUwK25TZGFoWmFLdEFxZGd6ZDlx?=
 =?utf-8?B?bm1DNkp1N1BNSDBNRDU5ZnExZ3dNaEVuUXBSWVpwRDI3eStRbGI5S0I5UmFS?=
 =?utf-8?B?UkNCK3ZRSWl1cU84YUlkeWlFVlAxdnhoZXEwSjN1QUE1dVFHUk1kRVd2engw?=
 =?utf-8?B?d1dvQ01EYkI1MGdNcEg3YUppZStUSWlRT0ZwYlQzUElFak50QmdYN1pUQWg4?=
 =?utf-8?B?VU5Ibk5ueG9FWVgzNnhRaU1EMmQ4UGxzSEpGSklWS3pLKzB4UHdyb2lkUUh6?=
 =?utf-8?B?TnNNbGJvZ2ZqN2RsTElPL1JML2x5UUlIOE5XMThsMlBnVVlUdE1GUG9OVzk3?=
 =?utf-8?B?RE5US09OOW1NUi9jMWQxdnJiaXpFMUxRb2pRT0lhRENoMEtoR21HVE1NQUFk?=
 =?utf-8?B?aTMrMFRQKzh2RFlNUGhreUFCNzdtd211Zk5qbHdkOXNUekJFL0FQRjZhcTNF?=
 =?utf-8?B?ZllWNDBPaUhURmhOdHBUeUt6Q3ZvU3BCeVNackRTUE9ybTlNUk1KN0NZZ0o1?=
 =?utf-8?B?VVZLOGcyUXNkSnBmMVlWTHl3SlF3TmF2aGFwc3lCZlpHSHV5V3B2eGJvNUMy?=
 =?utf-8?B?a1NCSUJvaVRWbXZlS3hZdlJqT1dVaTJnYzhDZjY3WEhBSkhQVUZXTWxUcGVu?=
 =?utf-8?B?ZE9pQWNVd0Y4YlhVdzJVd2JkZ3NoTHM5RjVWRlN2SDZYYk9uSWRaR3VTdHp0?=
 =?utf-8?B?SXFzS2xXOHJHYzFLTXlaazJEWE5KZWhPZm5QOTNPVVV0VkhTbTVHbzVPaXRW?=
 =?utf-8?B?LzRvVnh4S01kMzNjYkxlb1BNV0pvZytXaGpuRWhlems5QVovSEdHMXAwcnRu?=
 =?utf-8?B?ZWJhVEpXeFBQQ09sV2xPOWZibVNEcjlHcTlVdU5lWVQyR2NMMUd5V21NdXRS?=
 =?utf-8?B?MCtvcWN6YmRhc0t0RFFrNkE1NUtvNUc4OUtGNEw2aGJ6VVpxOUR6WU1zZGkv?=
 =?utf-8?B?UGRSamR2OWpRam5TWmtrYi9rbG9PWWpTWVhTcWR6cmEweW5UUmlnclQwM0cz?=
 =?utf-8?B?cENnVnlqYkxLTEdoaTYzSFpaeENnUTMrVmtPM3AwbHczMnE5RlNpYjFHOWlJ?=
 =?utf-8?B?NzZzbGUycEk5cTZxVWNMcGNvU0pDMnRVL29LcElkelVoRzdPeVNkTWtqajQ5?=
 =?utf-8?B?ald4c0lPS3cwVzI0VzJLUktGS2o3ekpYMERBSk5kcTRUbm5HTWtFTXVRcUd6?=
 =?utf-8?B?OEYvUldCQXlxVDg0aWtVY1J0NlViSUNZK2c5aWJ5YlZ5aml1dzEvUjVXOVdG?=
 =?utf-8?B?RnlzZCt6ZFJWcHdpUERaT1JhS3JaNFVYclUxRlpad2tabDNrL1ZlU2dhZXZM?=
 =?utf-8?B?ZUQwMWNiSkdyUDVVRHA3eTd1YVBEcnNUQUxIcTRjandYMzdINDVKKzNXZnJ5?=
 =?utf-8?B?MnkvQ1ZVellzU2lpTVdqRU5YWlpSbjVUZWhOT0lNYlFTQlhiRVpHR2VHc1dG?=
 =?utf-8?B?T2NDSG5GbERKT2kvZE9XeFBncSs4YWpCY2xzeDNEZEZmYzFUL2RBditNSHJV?=
 =?utf-8?B?Z2NTU1JhWkFrMktJVEtQZnVSZnZxRHdReDZKTkxqK05zQVZmdnFJMEdhZFRj?=
 =?utf-8?B?QTRkYWJKMnVNR0VxR1VGYTZjZzBBTWVrQ2FvNDlHekNwbjQvQ3M4NzJ6MHRh?=
 =?utf-8?B?SHoxK1VReWhaY0puWHVxRm91ek1pa1dDV2VPcXJzVDNKV3VWWExaYzFkckZv?=
 =?utf-8?B?SnF3c3ROVFRtMTlPRWo2N3lpa1doMUR4RW1OUG9NRE0rSllxZytFdEFHaTRo?=
 =?utf-8?B?VmRZL0hNUlRnb3cvSHBqeHV4QjU2Q3ozZGtZaVNtdXVQQ0pLbmpnREhmYk1X?=
 =?utf-8?B?OFVzVHE5cGs0eG51eEZMcVpMRWZ5OHlZRnVTWHM5ZXlVWFYyNDhYM3VWWnhq?=
 =?utf-8?B?cWlLakhPdUg0RlJ2bGNpMVhRenZ1OWFTOTF0ZXBnbm1uaEhyakdLb256UFZU?=
 =?utf-8?Q?kP6sy/RQY4kZpy/XVn8WSIKDF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055453be-79a6-4a64-dcd4-08db6e233994
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 04:36:17.2989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NRFPg1U3OYxgk1tDYlIO4tOHSWh4N51G7HtQpnbCZJxS8sW7V0JNRntrTZ/vcOWFk7qE82n64V6a2HhAAgldQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
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


Am 2023-06-16 um 00:29 schrieb Felix Kuehling:
>
> Am 2023-06-15 um 18:54 schrieb Alex Sierra:
>> This flag determines whether the host possesses coherent access to
>> the memory of the device.
>>
>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index 90b86a6ac7bd..7ede3de4f7fb 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -2107,6 +2107,10 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>>       if (KFD_IS_SVM_API_SUPPORTED(dev->gpu->adev))
>>           dev->node_props.capability |= HSA_CAP_SVMAPI_SUPPORTED;
>>   +    if (dev->gpu->adev->gmc.is_app_apu |
>> +        dev->gpu->adev->gmc.xgmi.connected_to_cpu)
>> +        dev->node_props.capability |= HSA_CAP_FLAGS_COHERENTHOSTACCESS;
>
> I believe this is not true for "small APUs" because they map the 
> framebuffer as WC on the CPU. I think you need to check specifically 
> for APP APU.

Never mind, I read it wrong. You are checking the correct APP APU flag. 
Just one more nit-pick, in the condition you should use logical OR (a || 
b), not bit-wise OR (a | b). With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Regards,
>   Felix
>
>
>> +
>>       kfd_debug_print_topology();
>>         kfd_notify_gpu_change(gpu_id, 1);
