Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95446C54EBD
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 20:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351BB10E500;
	Mon,  9 Jan 2023 20:23:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1618F10E4FF
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jan 2023 20:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3cfSzFw+H5hX9UI6ghm2ntDZbraHRa4dVsMVIkVvvz89agtq1+aXhIz5oTj4TynmFchplkfwp94YQLh2htbKM7L4W9bm0nBSwQtoc/D46e3/RO36EAEs7DfshC6x/Y+HutwM4/R1t2IJkf4SgdCKZl9j0N7D3HZWul3LVaZNtvIRFaHI117SHQvVz4pV5jMHa9tod0mmRyDoFYciesP014bQwxf5tWAkkGmrJBSnIVVh38JqDQv895XQ09TcH93PDOA6j+HvP78ceX1AmIl8FBGPIAx1K80Aw+h4p2YgLn2xXSYUeDXA/cC5O4JmvXKNnfjyP2KCmp+dVXnGojcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQVTC5aaxpApYRjmQeNIxMGw3FGlDtlMcWdrLfU/hOw=;
 b=ksgUaieO8+dbyLAqIJ6y3VApTPuAdc3aJwN5MCsPD/wv9sxi9kmpthpCQaaruUNtBIuL3VUOBLWwclRkCZFwC7ceD06zoX9f3QkqB2xjnF/srVNgElD/qu0IeDOQDRF3RH84aliM7bry696Cqex+jRXVW7uMXIVI7WBi/HfG8lzAsozFx94tlMe+vgAJtCpH1p/pI98gCzXr5k2FBM5Z5tt62wy0LEq1gfW1RYylFi9Gp2RTGsdWrJuYFTR70ORSV0lEQoRO6KLUCaEne/g6MCkZeteodexT4dYyB4ra/IF/vuqg4KraVs3flEgEWsPci0YmYm5BDoUwEsv4Lszs9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQVTC5aaxpApYRjmQeNIxMGw3FGlDtlMcWdrLfU/hOw=;
 b=IiAKf5XbMDfOQFCQswZ0FXqhngOCdWrvUooo3YTEHElJltdlN+/z4MV9sPb6Q4oeShp1tYJMi74UyNpq1BHm58VvnCJg/BUx8WsblTA8IqWrc1WiNooTgJm4uDU9p6hm4cqrkogz6eqbOwnD3vfkoAzGShwYRUVEStk3g+8tHSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 20:23:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%5]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 20:23:03 +0000
Message-ID: <e8d73f0b-8b99-2f5a-4eca-bf9453da58dc@amd.com>
Date: Mon, 9 Jan 2023 15:23:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdkfd: Add sync after creating vram bo
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Eric Huang <jinhuieric.huang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230109192743.133767-1-jinhuieric.huang@amd.com>
 <ebef9ae2-6b9d-7bd9-5b30-8935009b3260@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <ebef9ae2-6b9d-7bd9-5b30-8935009b3260@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0346.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA0PR12MB4525:EE_
X-MS-Office365-Filtering-Correlation-Id: ae473f57-6165-49c4-5beb-08daf27f4f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AMsIFjFXWWL7xC7PUjc6Ie/StbbE8ixkBhUFhDvxlOvEuhjx5OoAUw92lduXrMEL2O6L/yCQeVCkipSi3uY/jYffr27AQQIYIV3hiFjum2oBRzOhXFVk+AgbF+6NCcM9HrSpt0GvpCcfvnAqRGgdlCd+/EqHZfufq1ee9Z2cNEuqWhIcE7GvLmiyiquy9sx/u22hna+gM03wpcOUIXZSFIhjiQM51iOpPD8AIUWdryZpPQbdFwshH4+SFhaG1z5zXUpseHLBflPivBFGlY1DDcwOO6a9l7f41Jyeg4WF7Q73lOfBeNg2K3ULxFHkqylTtxLW67wx44QeJjQQBYJTY1cXczO/QaiC6Ke+vtTjrzAlViipgvDFk5j9Gvx5P0sXBF/1Ao+k6/US2oe1V1D3sQ6Z6WdPLt1P8snv9jFUjoLMLI18J1xb+ci4l0SnGdNDN8V624QSDYXuRpIf6pbIxwsx7ACEhp4+dz+6WJFmzqZKZKmECEGOW+ThsrpE2UWtd1KtW3lD1pVqS8dbMMbQZURJbcxj4dN5HCOHvEjyZIsyRQ/I3xX/JzbWVv2QqEh/otcMdT42pt3yk7W+JqYmO/hAERyvB4Q3Lvp1ZVNxXtwcXmSibLAO0jvIIzp5u7n7nJu1Kw+bcuXInB1ILDNmpr7/72NI5pJ42f6ahtg6pv+qmxVHh1g9EZOz/rLDOV/f71lA5ypACR0v2FVb0NI9bj70ipHOLC0vEDZ/pqY2lek=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199015)(8676002)(316002)(66946007)(66476007)(66556008)(110136005)(44832011)(2906002)(5660300002)(8936002)(41300700001)(36756003)(31696002)(6506007)(6486002)(53546011)(478600001)(38100700002)(2616005)(186003)(26005)(6512007)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU1teU1td3R3YWptYUVWdVhPSGY4SG82RVl2WkhvNUdzd3doak5DMUNTb2gw?=
 =?utf-8?B?MFk2OXh3OGtkaG5Cb240OVpOZis1c3cwdi9qRUJYOVdlYnI5aFlMamU2eHM2?=
 =?utf-8?B?c1p4Zm1XSFVZSlhrYjB6NmVEZzhZbnRaNkx0U09GVGJDOXI5cVNUaElsMGdR?=
 =?utf-8?B?d0xhMmJ2ZjQxYzVqZTZRa3h6QlRpOTBVVnF6MU1Fci8wcXN4Z0VzMXlyWUNs?=
 =?utf-8?B?UVVmdWEwY3FmZEk0NEZGVU9xRlB6aVhqVU1JbnZmMWJlblhaREZ1cmFRT21R?=
 =?utf-8?B?Sm9vS3dJbVhEak1zQXpXMGZ1d2tYZmk1SHRZVGh1VUNUb1FnemVtL1p2Tnh2?=
 =?utf-8?B?TmdOR2ZJclpUVnlFOXB3SEZlNGVOMml4R1pVbncrQ2JMMmZycWo4OGpKNmsw?=
 =?utf-8?B?NUg0VTlQZ1h5TlM5bTc1S1FUdTFQbUduL0E0SWJqSlhRTktuaUNyS0Noemgv?=
 =?utf-8?B?MGxJc3M0dGJFRjM4RE9pWnNqR0ovOTN1emxUeEkrWFJvTHBYQnd3dzF5dGlo?=
 =?utf-8?B?VDRpNk9HcTlJZytlWkxvUStVeDVoWGZRQjJmQjZPNDIySmV3cjNWajZaTDdr?=
 =?utf-8?B?OUEybzJDWlZPaEN3QUZ2cXBzOUVwUEFmeCtzOTUzdjhwZVdITFhwN2lRSEFj?=
 =?utf-8?B?OXhKRHI2SDV1eURMelhKaE9YaHhKY290V2Z6c0Zlb0NXRGI5dlpKdW9SeW9s?=
 =?utf-8?B?NythR1ltNTc3UUZZR0xkcHhqKzdmd0FvSVphQ1Bwa2VWTHBHa21Ha2JuK0Nv?=
 =?utf-8?B?a3BTVWpOV3ZFTTJ4NnVYc1BTcWtrRi9LVmZXYkJlNFJTOVVIMkFRd3BOSmlh?=
 =?utf-8?B?NmVLcUlyN0VIZ2Nad0RCSFU4c1R1T3N3QlRFL003R2FNNVFMOWMrdFRGQ2cw?=
 =?utf-8?B?Q2ZEcVY1RnhVcmJ5M2wzZmNVbjUxZEl5TEN1ZmY0eUFJcnNoUzBoYmRQVStB?=
 =?utf-8?B?Skpmay8wS1RTUU9oMFBTTWcxay9RWkxCU25jRWx4VzZkRTY3OFhrcjVqdUxY?=
 =?utf-8?B?MSs0NVNveW5lK0ZWaGUybjZXaGlINDZ4VU1JekNWR2FMM2JwQUhlSEhwOTFX?=
 =?utf-8?B?UzhDWnloc1Z1a0xPdGNldGhKc0x5Wk1EU0VLNE1LYXMwWUREdTkxVmZXUXRw?=
 =?utf-8?B?ZGpwZC96b0p3RU9lbUVYRlVOb3BqZXJNcWZUbUt6ZUdpNFhFMS9sejUwM2l1?=
 =?utf-8?B?bFJYNVNGdlY3QTI5YmhQOGMvTlZ3bEtCVVRKVzRzZjFDUDVrU0xvQmo5bnpY?=
 =?utf-8?B?b3hjQS9NRVFCMjVPYnpkR2RhVnJxNmJsVkVOYzZHVG5ORHRyTGtmT1RYbko0?=
 =?utf-8?B?dXMxVlpzVDZNdkVEaFB2L2tNRkg1cXgzMzloeWRzcmdpNmZJWGY1WWw0azd0?=
 =?utf-8?B?SU5neHNSaGRsVk1IbTIxTWIrWXhFb2REYnZiZytpWkVXQTNVMDd2S0dHN05i?=
 =?utf-8?B?UlNvaThDMFZTb0lVT3JhYnNGREhkVEREZ0l5Z0oydm9WUktxMWdWZWJsa0hM?=
 =?utf-8?B?VTNPcEZjNDVqeUIxVFdzdmlocUpkcy9pUFRiYlhPWXorWHhQM28rNDMvT01v?=
 =?utf-8?B?L2ExYUI5VXpSa0xvRU9JNE9OaTlMWENYNW5IQnRydTh0MHVmV1dReUVEa2Q1?=
 =?utf-8?B?Sm1GZFBWd09uU25tOXQ2Wmx1djlkZkxBdHdZRWpVUVduMnpwYTNMb21vbWt2?=
 =?utf-8?B?STJlRWlDOUpTekQyMXFPU0tFcXJtT0wrS3VqQWRvM1M2Njc2YldOY24xSUhj?=
 =?utf-8?B?em1nZVAvMDZUdFczaldHRDJUdklHbTVpakYvMS9OdWRRaUd2ODBXT3EwT1hV?=
 =?utf-8?B?dFNjNElmMVppajI0UzZZRDJXdFhtSm9UZUd2ZVNYQUcvZ2YyYThUY05sTCti?=
 =?utf-8?B?T3d2em5CZmZtbFg0aVM2QnNQeWs2ZEZTNUdPRVk5ZmlBMm91L0tweGN0Z09O?=
 =?utf-8?B?Z0dTVlVxOS9aT2hIZCtDZVZEck5VaGcyODFrN0JwT3BKQUFPQW9wYVhjeDYr?=
 =?utf-8?B?K3BlQ3dUZGNoU3FUVzk0elVkMUw3U3FVdmJCV3JkekdkN2JKSVE5NU9pT0Vk?=
 =?utf-8?B?dGQ4RkMvdTRoZUoyTXloejZaS3lCZm1QT3NsWWhKQmFERXdiNU5jR0ZHVmw1?=
 =?utf-8?Q?C4ZErDEzL1OMKKTxhPzPDp8cb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae473f57-6165-49c4-5beb-08daf27f4f4d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 20:23:03.3615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++5VuTz4o0L1blhJtJ5euIPEXazLwME/2kBJVr3+RKSdmGXrVv0TK5OQfoYzBMsPPIL6nOo+7BJRhTIozOWSmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
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

Am 2023-01-09 um 15:18 schrieb Philip Yang:
>
> On 2023-01-09 14:27, Eric Huang wrote:
>> There will be data corruption on vram allocated by svm
>> if initialization is not being done. Adding sync is to
>> resolve this issue.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index b8c9753a4818..344e20306635 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -574,6 +574,13 @@ svm_range_vram_node_new(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>           goto reserve_bo_failed;
>>       }
>
> Thanks for catching this bug, we could optimize as clear VRAM is only 
> needed for partial migration, ex pass the clear flag clear = (cpages 
> != npages) from svm_migrate_vma_to_vram -> svm_migrate_copy_to_vram -> 
> svm_range_vram_node_new.

I only see one call to svm_range_vram_node_new, and it passes "true" 
unconditionally. What am I missing?

That said, if VRAM is not cleared, there will be no fence to wait for, 
so the amdgpu_bo_sync_wait call is basically a no-op with a little bit 
of overhead for creating and destroying an empty sync object.

Regards,
   Felix


>
> Regards,
>
> Philip
>
>> +    r = amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
>> +    if (r) {
>> +        pr_debug("failed %d to sync bo\n", r);
>> +        amdgpu_bo_unreserve(bo);
>> +        goto reserve_bo_failed;
>> +    }
>> +
>>       r = dma_resv_reserve_fences(amdkcl_ttm_resvp(&bo->tbo), 1);
>>       if (r) {
>>           pr_debug("failed %d to reserve bo\n", r);
