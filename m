Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AAFC25B08
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Aug 2022 16:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A7C9A1FD;
	Wed, 17 Aug 2022 16:25:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE666990FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Aug 2022 16:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hARN+gOcCzMfaLHYpDZd6AQ/Dh5UUaLGOygpIkCLqi/1ulY63sPs6TLFBK8IDao9RsDdNj2SJyNYqRcTr9RpXM2cBYc+VKgwS3I1u0rxD9m4brSxCUuITj9pT0axpI0Gl1PPZ9YTijIVUdni5q3IhJ+mb5/bt0YCfgXABVt4NOr8nmEgglC2n3/pnrrrB+G9pEO5BV0n7fkLpDhdU+8sVyUrVwKgXxB5im/He1lfvH+lZp7avqu2Ip6gh0q9Qduf7ZqLRh/4+anqoAedWwKQCVMC3iWbpScqudkJFwL5E0y0aKIlSFUtSeT5R2gbG4sZSIILjo4wVZVnFnG0ynMtCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kFfPKZQdj2RI2WS7mS7iHXSDeTHtEqJh9kwxq+ZhEs=;
 b=Xzocwctn5HioEVO3M/y0TSZtzeb1ZRpztbQQT8HPsVqBpLgNyPBLiS10PBVikNPyXjy859+WOK/RbyY4tgs/2TsQLHjEiGmE3mPX/C7pfoOSU9dzHiicMZeGeWbFbFpGeKEAwqaqoYF6eCvpvbZ/fAxdLkZvNwiauBgEq2HRdTGnw8rNL02bQ3TzD0ciwrt0kiFEQamPzB7xkloZgw8L4T7lI6WdEKUyomFjrCJQGpLPSlS11NpWTBVY76lz4JDRKHAYZq4TPnZUnVvUMur/VrjwHlurNvx+IFltmznMZUb4ZksP4V7rbiBbc4V94QH/HqG8/U53npepUhO44oM6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kFfPKZQdj2RI2WS7mS7iHXSDeTHtEqJh9kwxq+ZhEs=;
 b=gpzmx5GneQ14bLKZgNHkDp2lQJ/P4mst192q96ulA8bqzRVxEEROLxN1zvvuV+Unre31A4OE5o3uXyFILBhtmBbBUT1rNdykzlJvaqNK17KR5e1Fxf7URVdZlBwmp1+58QqiVfm8iP+z757EGtM4H38MFwxbUXxoZXJwnutyFGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5118.namprd12.prod.outlook.com (2603:10b6:5:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Wed, 17 Aug
 2022 16:25:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 16:25:30 +0000
Message-ID: <f1bbde75-c273-9a90-f966-bb670e3b24d6@amd.com>
Date: Wed, 17 Aug 2022 12:25:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: add family_id property for kfd_node
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220817030926.80377-1-Lang.Yu@amd.com>
 <cc0d3857-0839-00ae-e820-863e02d07549@amd.com>
In-Reply-To: <cc0d3857-0839-00ae-e820-863e02d07549@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f55edc85-ab2e-4abe-5bb0-08da806d1a1e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5118:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLnkj1PtKNWhLQk9vreDP2sxegti33TpcCV+Q/DJtX+HnzB5r+0caq4qlYBYoJAc30ICcwvfEj52YrkINNbYcscYpqaMeNfSB81kt+JauKKulR4O4Nf48ltefcvz+J9ZTclhOhe7qweXfvuCqJOQoBGqklg85lM6dRCO0cIgeC5EdiOeCv8Ls2VckY/anZqGQrULGEz0g9I5OyRS7kPOSj/2KB8RH9O3uVor8nGvHN2I4qRg8MUdebyFaBj0fphvIvqGe2fWqCXYN6WyjB6fTLeahvuuJOJHVCVRjAkMRQC/499KbOewYOUAuoqbQMAVUnSSgO9qHBmjyd8vIvlZnAOY4ruD1UOKGssgdBxte5hCCnzRbk8Gwf67Pz/yZaOem5bOl/hMY+72bm5GAjhpSZ1zrsQXC71yNUeKwOTOSLcFj1b3Ro2resRwuDIUFENYnGDGYA1EVlFSd8Jv7CtrgzvlOjEFOI6fK7/lms6018KvluqLVVA9LWk7Zn/A4pdYCI4QUG9+SfYZLSYmh+f+vMrRo9XF9jW9EWCUR2tRvh87Wkg/POXa0q++cMRmj8ZrdwrfiXUN3Q1Buy2cr1oBY/t7v235LfFRhZCMQ37IovL4ADtLT1SoaaE08wEBvs0fFcoeP8W2mG8/EFcaAWi0Z5AyrLmV+L22acnIlKkRsKmMUxuQ1+PoRKaFUXYIYQIX51MnB7NmzOud+hwqwHAUCkVxkCfcuwpvJkbywDzFBN/wG3xGuCUom3/6bZakE7e2qa4hxoTmDLlW0JKzyGPymLlIfbaMzeIlFK0K8L3EdAL+Qi/a6mmvRCbNk0RyuF9aJ452qYzAFPgIatIxCkO8Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(6512007)(26005)(38100700002)(2906002)(6506007)(186003)(2616005)(4326008)(8676002)(66476007)(31686004)(66556008)(66946007)(478600001)(36756003)(6486002)(54906003)(316002)(31696002)(5660300002)(86362001)(41300700001)(44832011)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTQ4a1BCejUvcDJRSUhISTNwNHgrZ2JlN1A2RSswaWZleVBwTmM0bVJlbzBm?=
 =?utf-8?B?SXJ5YmQrOFMzMW9QRnBuZmZmK3Y0YndOSUJZM0RSOEk1eS9LN0FGZWw3OTYz?=
 =?utf-8?B?TWU5OFZZOWtnaFhGeHFhOVJjMUp0dmpUTHNsZVFURlAyQm1iZERERDhJYjQ3?=
 =?utf-8?B?dE9vd0w5RjdsTGlhN3hFZGkwWVRxNHFld0ZubGxZSjRta0hYdjRzWDJnMTIx?=
 =?utf-8?B?dURvaURpYUpMeCtkNGRiZDBFdGQvUElZYUZIUHBuVHBWc0pueUJiTU5tZlp0?=
 =?utf-8?B?d3kwZlZkTzdlRjhSeDM1d0I1L0hxK1gvdkxMSDJ4QjN2TFA1ZXZJNVExU01Q?=
 =?utf-8?B?WTh6L2hDQW9rejhmZUNDWWRpM0VWMzRHZHNPbEdPYUE4OGlEdmdtaTRGWjZl?=
 =?utf-8?B?SXJQT3h3Z3hiQzZpQUIrMVQxVWhWeGJEWFRZL2lyLzNYMkIwWTR5Uld1ZGZB?=
 =?utf-8?B?ck9xK1NjZlpSRHVtKzA5dVFiUHVTdmQ1STk3TCtBaDlnNGNOeXNTL3dGL2NY?=
 =?utf-8?B?QmtVd2hlWmJpZi9UMXVCTEJYa0lYOFJYWkFXZUhQRVVnME01L3pmMTkyQjlR?=
 =?utf-8?B?eDJyN3BQT25xWHZoUEJwUkFvcEtPMEwxbkRoOUc0SXUyb29uZzJJdmRjeE5U?=
 =?utf-8?B?akRuZDVtQTJnRHFqT1pJcFc1NnIvNHc2bURENVlKekFGVTUxcWZBVDhRTnh4?=
 =?utf-8?B?UEMzcUR0dU9OMUt0OU1LTEVwT2NXWHptSFROZy9JaVBIbzBNVkhFKzVjVCti?=
 =?utf-8?B?UXNEWWtRV2t1ckE0ODFyZkF4RGwyZ0Y1MGg3VFpWaXExbjBZaCsveVRXd3FK?=
 =?utf-8?B?V2ZXZUJIL1h6YUlFRlVZUW83L0N5UFRTYUZYT2ZieXFYcnRsYW5JMENHWWds?=
 =?utf-8?B?MWJoZDJPSnh2bFdmVmpvNUVMWDBLbUtQdGVVUjRlaG9tcWRoLy9LQXA4Vnpk?=
 =?utf-8?B?OTdPZFhURVhHa3dqY2s3UVV4UGtiOFVDZjFhdHhPOVVITnVHYVA0U2NFak5z?=
 =?utf-8?B?WW4vVTZHaDFtMHh2L1BLRkZOck0rbHFyZktxUjlTc0gxMVRCMGtFc2x2SmhL?=
 =?utf-8?B?RHh5VVovb2RoZEx1eHpHbFB2Sk1Yem9MeEpPZ1hnM0o1QlN1cjlWSzRpYm9k?=
 =?utf-8?B?NkpWOVNjUVJhbktWbjhLdFVpQTFBRTUvdDluV2NOYlBNdTZmclBoNXRGMkNm?=
 =?utf-8?B?RFRwNGg2MGx6S2JVT2pGaEVsTTR3Q2x0N3daUFJrRUNwOGNuUUxDR0ozcStB?=
 =?utf-8?B?MWw1T1lSamtUVjIxMkRKdTM5Vm9HRWFIbXNjR1h6VGp3NFo2bDB1RVFhZWZX?=
 =?utf-8?B?UFN4WUxWeW91Y1pCdUsrbzFpamJBcjFnSjNOQkZZZ2JncEI3aHNvMmc2eDZL?=
 =?utf-8?B?MDNWK1E1UXlnRVZNVDFER2Q2SjR4U0lQVjJsWks1SlBvYjR5WlJOYmduQVNK?=
 =?utf-8?B?SjZwYUs5OGJiWlVjVFBIb2swUnRMTk9UaC90Rm8xOVg2azNnaWp1VFArSGlt?=
 =?utf-8?B?NlJraXJQN1RVVlI4SUx2V25uSi92eS9hSUt5OTVhblJPQ0g2NXN0TXZPT2xV?=
 =?utf-8?B?RzBxL0pMVXU1ZXBPb2JQSlBRVW05cGttQi9ORlc2WkRBT0k0dFAzaWFOSnpv?=
 =?utf-8?B?d1N6ZWJuNzZiblBhUzhNcFV5a2QxV0ZMSlFPUnliU0YzdC85WThpQUIrenY2?=
 =?utf-8?B?eVhOY2VMSi95Uk02ektSK2Z0T3VuZ1Y5VEpmbStIUDJaSGQ3dEwwWDFRT1RG?=
 =?utf-8?B?d1NybFRzVDdEVFRYb0hXTjVPRlJub3JnM1BYUFdpbk5oUEFjMlI5Wk84bStu?=
 =?utf-8?B?QzgzcURBc3Y1Q2NFcDcvS1FWL3VzWFRoWnM5UGMvNGU3RC9CZHVHT242Uldz?=
 =?utf-8?B?NmEyZDR3L2lnaGRhNTdFMWlxaEczMWs3MDBjbE11eCtoL1FGZUxvUHVZbWxw?=
 =?utf-8?B?b21tZjZmcXgraEVGQ2NQMDArb2FwQzBHY3dVWlpoVE9TOWFTcDlvdXNVWEpj?=
 =?utf-8?B?Q0hHM1p2QmhEK1hlZVd1T2E1OEYyRkhjRWdvRi9IblFqVlhZdzB2SE1oT3Nn?=
 =?utf-8?B?ZDdPTG5obDVoNDRJNnYzU0Z3TWd1MG9LZ0kyV3FRNnJ5U283QVk4OWw3SzhW?=
 =?utf-8?Q?dt9/kTPwKnqXFu4LlbYZ0YinY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55edc85-ab2e-4abe-5bb0-08da806d1a1e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 16:25:30.7771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4p+7HjSD5fIx/5b/W0HkNNwuElHdOQ7ZdhIfY+cqnnQ4sI7PKLnXlqeFF+uXiWfaJxVh5ONer5IbzRzs5qupoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5118
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-08-17 um 11:04 schrieb Felix Kuehling:
> Am 2022-08-16 um 23:09 schrieb Lang Yu:
>> Then we can remove the burden of maintaining codes to
>> parse family_id from gfx version in rocr,
>> i.e., remove DevIDToAddrLibFamily().
>
> I'm OK with the change. But you won't be able to remove 
> DevIDToAddrLibFamily as long as ROCr needs to support older kernels 
> that don't provide this info.
As an alternative you should be able to use the AMDGPU_INFO_DEV_INFO 
ioctl from the render node. The Thunk already has the render nodes of 
all the GPUs. This will work on older kernels as well and will allow you 
to remove DevIDToAddrLibFamily.

Regards,
   Felix


>
> Regards,
>   Felix
>
>
>>
>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index 3f0a4a415907..7e0331e853d5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -507,6 +507,8 @@ static ssize_t node_show(struct kobject *kobj, 
>> struct attribute *attr,
>>                     dev->node_props.vendor_id);
>>       sysfs_show_32bit_prop(buffer, offs, "device_id",
>>                     dev->node_props.device_id);
>> +    sysfs_show_32bit_prop(buffer, offs, "family_id",
>> +                  dev->node_props.family_id);
>>       sysfs_show_32bit_prop(buffer, offs, "location_id",
>>                     dev->node_props.location_id);
>>       sysfs_show_32bit_prop(buffer, offs, "domain",
>> @@ -1690,6 +1692,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>>       dev->node_props.gfx_target_version = 
>> gpu->device_info.gfx_target_version;
>>       dev->node_props.vendor_id = gpu->pdev->vendor;
>>       dev->node_props.device_id = gpu->pdev->device;
>> +    dev->node_props.family_id = gpu->adev->family;
>>       dev->node_props.capability |=
>>           ((dev->gpu->adev->rev_id << HSA_CAP_ASIC_REVISION_SHIFT) &
>>               HSA_CAP_ASIC_REVISION_MASK);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>> index 9f6c949186c1..4ff8dd2c9549 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>> @@ -56,6 +56,7 @@ struct kfd_node_properties {
>>       uint32_t gfx_target_version;
>>       uint32_t vendor_id;
>>       uint32_t device_id;
>> +    uint32_t family_id;
>>       uint32_t location_id;
>>       uint32_t domain;
>>       uint32_t max_engine_clk_fcompute;
