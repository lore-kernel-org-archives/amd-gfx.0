Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F72CC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 11:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1929F6109E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 11:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1929F6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C116E7F5;
	Thu, 26 Aug 2021 11:54:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 001E96E7F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 11:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKmK4XEtzLc5DtN3T4ZyF5dvhJ2yGuvEeKKUSgKQA0WVLuJa0llPOCv4AgEozjvFYg4tmizVWuN2XXEgMfQ6b0sndThCvhD1ZoTOWzeD779xzVyxBZQHvMVg4KbMVwp2ZBWdlkZ5tMLx6p8leSKOAcZC5l0H5BHFSnjhAI3PEAh6Nj2fMvgM/nMTu690edclUyypw1Sl5dUSxDQRC3EAYJi/KYlkNOG/I5KTJ5ON+1se7b4R/y6PkjdiUQOaY3/JJgDJt7yM7f3tt6tG5qcJsSDBr6FOYcQDdmN3DQks1Gz+5Cl2+W90FmXVB/E/oNij8zNBejE+U2U/NAdAotiStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUntKNgBihHZ7S52vNGrkJG/TlYl+8YSLzfq5XR7lBY=;
 b=QrTpl5SxQw5hglE/L8DTs3GsidgoO8j2EzlKJ4Kjvmn8PS6BZphcNJSGg0CA+uztnIqP+eDIIRMxM15fua1muWWIrRBdid5eFUARToZwvNbDrlDO1rkj+h4Nvo+rxUnVs3zC2IoyH7T8wzYA967fpzXC0xmdHdBWvjzfS/F1L1BOvl2cHoO1RwVf26ERFdYF9EnAA4CV2yJLabe4trT3LFiHt+MFT778b4wPtIseziO1sxIcnoCjkre26jsyrDDdO6+hBdHzUFboMCMC/B6c7QA//iyZul5pDt+fcY+n0XJNZsDReL07TVsjPF72UXDmTED8ClhRRSLIxLUkx+ejIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUntKNgBihHZ7S52vNGrkJG/TlYl+8YSLzfq5XR7lBY=;
 b=U61En6M/SdGiMaT+Xe0K3vEfQDYnxWuaTDN7fkbyZ4cWQi6X5jjwyq1pVCtUPq7h33Bx5GFsLy0MamUjL5i/V9+kioc6p9Fw4HQUnANOQnU8tS3vVfN78syeTyYchcTlCfkU8/mjd7xAJXZvrnUU2qLwcn2mRoSPtDFedTi8nOo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5025.namprd12.prod.outlook.com (2603:10b6:610:e0::24)
 by CH2PR12MB5514.namprd12.prod.outlook.com (2603:10b6:610:62::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Thu, 26 Aug
 2021 11:38:52 +0000
Received: from CH0PR12MB5025.namprd12.prod.outlook.com
 ([fe80::4193:5457:4a18:780b]) by CH0PR12MB5025.namprd12.prod.outlook.com
 ([fe80::4193:5457:4a18:780b%8]) with mapi id 15.20.4457.019; Thu, 26 Aug 2021
 11:38:52 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu/vce:set ring priorities
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
 <20210826071307.136010-3-satyajit.sahu@amd.com>
 <259a72ff-5c7e-7f1b-67ab-4aa47ee4c875@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Message-ID: <16588165-2e49-c761-6716-ba77ec82358c@amd.com>
Date: Thu, 26 Aug 2021 17:08:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <259a72ff-5c7e-7f1b-67ab-4aa47ee4c875@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::34) To CH0PR12MB5025.namprd12.prod.outlook.com
 (2603:10b6:610:e0::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.68.104] (106.51.20.251) by
 MA1PR0101CA0048.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend
 Transport; Thu, 26 Aug 2021 11:38:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d30fdbd9-c92d-4b9e-1a98-08d968861426
X-MS-TrafficTypeDiagnostic: CH2PR12MB5514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB55145AF9EBB8A014EB153720F2C79@CH2PR12MB5514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ttGZzIEi8PylbLQu76gpN1NWpG0Z3n/eMMbmM9U2bter3S49WRk5Uphzd7km38oR4fYefWBLpCeBJFMugSiYpZHNEQ4DjCC0hLZX7ZvxVp59+CNAkjeu7RjWa4xhL4FdohQgdEUprRwRioKQ4HthQswz/TcdxVzO+pkbLGXNm8gHRNiR6Q34lpHdpCRWu81CInP89Sq18mMAk8YLs/j+IFAjNQMbwO9bFHnakEAJf55hMWT+WL4jgyM3B8Z2S7BnR503cp7P3rQp2DA9sthnO8iAbgYAtyxtrTBUM6baVFJPyWbFtyni/AROkcAPXLKriOzMw+5k77uGnLqED7u9T/T4mqDfXQPyBYMGDwUNqndcPEq82NP8nx2JjPnTMMpjWSTTY+j2AK59PLVdoOTKwFTpu5ytK55Dg57gQt6WUhxA6wh/zRHRg1vGiICaF8raMm+fKpXD9xm4AiPLHDlCjS3BtD0eur9kVQbgQUSLijChwH8AP1Gstg3NiyRwBRubQ2EJk5UvjDZo+RAtznBrSOsUB5v7w0Yl8lQGgr2y1g/skNF91O8Gd8xhUL0sRO8HStn3OXqtUiGYe3i5RrBdPwLSl9e8fPr/dsoSlklJscfObOti8ql3oApJKWytenuaxDuNd8dX4gFZ6wPE7ZNjsHag0sdjbqpIiCc4W3A+FNUz+meIH8iiz4PBXo5ndf9/OKsni4t1OR7f71s7X+V/4YxCmvEf/89q5+Cwr6kC5uFelVw/V1N7tXZrIJc2Iwa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5025.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(55236004)(66476007)(66556008)(26005)(186003)(478600001)(53546011)(86362001)(8936002)(8676002)(66946007)(6486002)(31686004)(31696002)(36756003)(83380400001)(38100700002)(2906002)(1006002)(6666004)(316002)(5660300002)(4326008)(2616005)(16576012)(956004)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3Zlck56MFBnWEtGMml6M0FicmtCdEc5SFRraDRtQUFyQVZjdzB2dkVqdHZn?=
 =?utf-8?B?eFdIOG5FTE91ajdVRk1JY1hLSmw5RTJpbXBGUi82Ly8xTnlWMmVDUG53TEtQ?=
 =?utf-8?B?T0o5djhjTVUwcStIUlpZQUtLcEFHQTVZcE5YUjFyQ1pDdDdIWTBxMTRQK1JS?=
 =?utf-8?B?V3JLcmxpZHF1YUlQN0JIMjNWTkNERnVWWEk4TmRMQ1ZFY2N3b1FLV0wwUmk5?=
 =?utf-8?B?UUJrYlIyWE1UbGhvbWZteDFSZzRvTWZ6aDFFdGM3ZGFzcDZmZnJ1VklZV09i?=
 =?utf-8?B?d2RUUnVnMkJFNlk3czBZSmVtdW56MXZ5SDVURExzZXZyQWNSOXBQNDVQVDFk?=
 =?utf-8?B?R3N5LzBiaHo0SzgwL0ZnQ1VHejM3WTRpcVRrbGI4MHFCVDQ4ZDhuYThYWWRF?=
 =?utf-8?B?N3NVdDlWSTNVcTc4cmVkV0M5dTVnM21pYXc5UjQvZjFrZXRwVHJpTFA0K2RF?=
 =?utf-8?B?Ri9ka0gvY21McGVtWXEzNHY1OW5KZ1VQZlY5MS9yVm9Id1V2bEp2VmI2WUtq?=
 =?utf-8?B?b0dvbFo5MVIvL1MxcFZTQk4vV0Z5U1Uwd3V5Y0puK2FkMWhVYVQwM1RNZmht?=
 =?utf-8?B?d2xRbFBEYVVNaHRyS2s0MkxWS3hJeUJkL3hSV282bVptelpXbFFESnAvcHFH?=
 =?utf-8?B?dFhsNzY2eDdEL3NRK3l1RUpBb2J5bXIyNjh4b2JPb1AvM2M2MDZHWTV6YUxS?=
 =?utf-8?B?cTZ2VG13U3ZoUll4T1ZOdFRob3puUWVLS245VDJxLy96MGFudTZkVDhWOE53?=
 =?utf-8?B?c29NWElvYTlPM1MwM3pVaWNzQTgvb2R3Nld3UGI5SWlCNUd6STdrTkUraC9v?=
 =?utf-8?B?bmVnL2NPSGszRTY4SjNjZEZwWG1ENG0vZnlpRGVIM01hZDZwT2laWmJZYm5K?=
 =?utf-8?B?dUd6UDFSUVBuZmpoVWIzUmd4dUdZaHBTMno0cFRJZTM3UW9DdUduQVQwMCs1?=
 =?utf-8?B?YVFPT3JzVStGZGF2U3RVaFV0cWpDYldoUnhEak1NZURaVDM1dDU2aEU0Rkt0?=
 =?utf-8?B?WGVld21tdlVyZlZOR20yS1A5YkcxTERWZDlwNUoyd0pVcEd3VTUyb1dVY2Ev?=
 =?utf-8?B?eE5VcXVkVGUvbXhxckxnR1VUZFg2MkxLRm5aM25GQ2lSQjkxaXJOK1JoRHM3?=
 =?utf-8?B?SkdHcHhBdExveGZ5TFhqblpVOVYxTm5VcGdBMVh0WFdrdUl4ektiLzh4dyth?=
 =?utf-8?B?TFdWcCswUjhpVXRvL25lVG9NdWR2ei85RU9INkVBeFBQUDRWa0syaUhSRzZj?=
 =?utf-8?B?dXJrL0U1WmVUR1NKM2hxM1NFbUd4d1QyRk5Wc1VObnlPdWhaTXpISWxpYjR1?=
 =?utf-8?B?bE9VWE1Eakg0MGh0amd4Sk9BeCs3QkZMRXpkRzlEWVV4ZVkybFRxeHlQeXF2?=
 =?utf-8?B?cVp2cFJvazBJSTBxbHFHQ2lTS2xid1VrR0EvOENzdkJra0x0M3ZxRU44Nld6?=
 =?utf-8?B?U0RrckNwYmhFaEIrRWppaDNoM1FzTHc3cVMvUktiVm1qSE42UnNFcTIrZkpr?=
 =?utf-8?B?dHcwR2VEdmVEUkVlYTROT3hwODQ1WjA1NmN3TUI0NytiNGZac0sySW9mR3Yw?=
 =?utf-8?B?U2U2bXdCVjRjRjg3OHdHemptN2p0TktRUFRsemlYZFFmbmZxVWtwcUNyNXd5?=
 =?utf-8?B?a0JaVHlQdjl6cmp5QnBBYmxlbDUzNmdvcTF4L29SMlhEVzBhSWlHY01NWjdp?=
 =?utf-8?B?OHI0UzRlMHRvN1QyUDg3cGJCV3dTcm53ZjVLcit2RHZkV0NQZ0VldXNZWHl4?=
 =?utf-8?Q?Q5NqCyUWkXqKKZ209KTy/y9ctTKDBJye43aAwBm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30fdbd9-c92d-4b9e-1a98-08d968861426
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5025.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 11:38:52.6486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Llu4WZFyEsuxYUhDbfEVp/BtMuVcafCE6Y/fRgoPQoA7wqUlABdJOwbyuYEZnlAu1ToE8YIkEATthob77ujuPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5514
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

Hi Satyajit,

On 8/26/2021 1:51 PM, Christian König wrote:
> Am 26.08.21 um 09:13 schrieb Satyajit Sahu:
>> Set proper ring priority while initializing the ring.
> 
> Might be merged with patch #1, apart from that looks good to me.
> 
> Christian.

Actually it was my suggestion to him to split the patch in such a way 
that all IP sw_init changes to go into single patch, as patch 1 was 
getting too big with that.

If it is not a problem with Christian, LGTM
Feel free to use: Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>

- Shashank
> 
>>
>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 4 +++-
>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 4 +++-
>>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 4 +++-
>>   3 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> index c7d28c169be5..8ce37e2d5ffd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> @@ -431,10 +431,12 @@ static int vce_v2_0_sw_init(void *handle)
>>           return r;
>>       for (i = 0; i < adev->vce.num_rings; i++) {
>> +        unsigned int hw_prio = amdgpu_vce_get_ring_prio(i);
>> +
>>           ring = &adev->vce.ring[i];
>>           sprintf(ring->name, "vce%d", i);
>>           r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>> +                     hw_prio, NULL);
>>           if (r)
>>               return r;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> index 3b82fb289ef6..e0bc42e1e2b3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> @@ -440,10 +440,12 @@ static int vce_v3_0_sw_init(void *handle)
>>           return r;
>>       for (i = 0; i < adev->vce.num_rings; i++) {
>> +        unsigned int hw_prio = amdgpu_vce_get_ring_prio(i);
>> +
>>           ring = &adev->vce.ring[i];
>>           sprintf(ring->name, "vce%d", i);
>>           r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>> +                     hw_prio, NULL);
>>           if (r)
>>               return r;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> index 90910d19db12..931d3ae09c65 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> @@ -463,6 +463,8 @@ static int vce_v4_0_sw_init(void *handle)
>>       }
>>       for (i = 0; i < adev->vce.num_rings; i++) {
>> +        unsigned int hw_prio = amdgpu_vce_get_ring_prio(i);
>> +
>>           ring = &adev->vce.ring[i];
>>           sprintf(ring->name, "vce%d", i);
>>           if (amdgpu_sriov_vf(adev)) {
>> @@ -478,7 +480,7 @@ static int vce_v4_0_sw_init(void *handle)
>>                   ring->doorbell_index = 
>> adev->doorbell_index.uvd_vce.vce_ring2_3 * 2 + 1;
>>           }
>>           r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>> +                     hw_prio, NULL);
>>           if (r)
>>               return r;
>>       }
> 
