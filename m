Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716F3C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 033D610EEA6;
	Thu, 30 Mar 2023 14:54:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF02E10EEA6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH0Hua+g5OD9GhlVz8v0RMHI0fD8GMQu9YsTMPmE7u3bMBh65txn6iyolY/2N9h1HMAzvUigKVK6EXk+g6+swZ+uPd2jHA97mONvIcVYNOdbp6sQ0UjCT2qjNxK3vZXIrzmuXZIR97bThMmkCOylITlGASIDwmoFhseGLfGd6/qO8e1jB/Numg6IkvkVpRkV+7I+oQgsHsQGLQ+RyfklbdBVecz6X23NkoePtVuFwYioNut0pXN98dLcj7VYvSM4Bmub1tK9BWLBloUDlzIMIXfo37EvRsFpuK7FPAFFuqP2q8oe9NzrNvRRQ7q8lJj1Qk65VzMKBXgzoi3tH2mnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeGWM7E3JfwcAS+se0ZCYmIw4/0jCvbIarePdBKjyx4=;
 b=BaHVyqrZNj2ZcGlCs+NhaIcYYNxO/Sg1LciiZucK46zgHBhuTpS9ix5v+J8uH1bO86LW5JuZNcDnEdGJyD1IT64Pe4vbsoI2dcuv4kFAD1NlUtoi2AyQESBhO8tJ3/O0JcjzzWs5rukHngmHK3pv4XzCn6yEil7BAQ2NsmRFU7d3Oa+AfyDlX+Tth3+uoGzanH7klHJ5pQ2JoF+pDmK1h3mknkfIgxIu92Jp7EH1yCiEIouJHb++F4dINNA5Za7+sOwQ5HWzzYb6R90+I9X7oaoAnNCpeiCv+6TkIrIH7/NUxuCtJprmcZqohwGth0gujuGeKAP1vLf93f8WgJuaZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeGWM7E3JfwcAS+se0ZCYmIw4/0jCvbIarePdBKjyx4=;
 b=LhKZNHwM8Zwd93j3EXF5lfqJ1JmUuP82/M56tQ9wurZ6pY+aCD2mlZDGTpTljPujJIzY3X8TJLq2dmk5pv0VZYIQzmLTAP3eznvzZwfa9TtHW50oFyoy8khB47dU4io8pozTe//tI0C7XR3JyZKt2PLxWw7T/Jh8E7OK6JasT7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 14:54:46 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 14:54:46 +0000
Message-ID: <19aacfb9-9d3d-f6a0-0351-0b1e40852bed@amd.com>
Date: Thu, 30 Mar 2023 16:54:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 08/16] drm/amdgpu: initialize ttm for doorbells
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-9-shashank.sharma@amd.com>
 <CADnq5_NAo3mFUrGX3OH++RRAzjkModPnTsV+w8CAgF5QgKcaOQ@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_NAo3mFUrGX3OH++RRAzjkModPnTsV+w8CAgF5QgKcaOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::15) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: d12352e0-9738-4b12-cfe6-08db312eb40f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ib+0YqGQ78hcQJ4aN7GBHdw2kQO48PJE12vNYWRRNKxN5uA5CTNGfofupKzUqvtxDSWlXQ9vUG2pLErqelPq718EnCl0viVtlHEsMzbQhBGR4E4yL9By9VjycrE7oUmIVl967DfEXNnsc1ZhSr5J2zMeqb5Irp0obI22PJxDVb3KBlsCwMseACraCxtutx5nlx3GGFEPeHVaCwo6lRU8LsOGxtP2U68nCxGbq/CI9jnCMYXNjYnt/NuL4U3l5da9avKtRXbMVDy809Nf60eXEL5UZXU9hut4c2mO20mH2cD9aHm0LaaqHujA5yLo4wvwby/Vjk9rWzyAbRLJ+IbdZn6yr9zpSt9eci+1niIYud1em9lAWV2gRdCtwt/mix65CHIa4egydB6EMG+h20ldz2qvcAmu7tqKkGwku0CTbtZO/E0pH23TUPoE9yen4/bp6Pt5GzUGvHMK0XaxUsYv9Eiq3D78rHfHIZaOIOu+7Z9XXpVZX+aY4GXRGixoGG6NmItziP4Vpc8XJem6r/zSCEys6DpNp2jJuRipIMF8eBrTGAcXvv993aXuLbHcorgYXNp3cmG9TgRWKnO4ZlbQyjuCJ8S+w0I5y8krwVjRI7N28QLhX44habUavvCcOKD/ILsVi7JZY7OKpphwTuQn5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(53546011)(2616005)(186003)(6486002)(26005)(478600001)(316002)(6512007)(54906003)(6666004)(2906002)(6506007)(44832011)(5660300002)(4326008)(8936002)(38100700002)(66556008)(66946007)(41300700001)(66476007)(36756003)(6916009)(86362001)(8676002)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGZHWXR5U0ZTVTFlSjdITy9ZVFpXL2tFSitTTHkwUmJpUzlKSjZRWFFKeXZ2?=
 =?utf-8?B?WnNVTStqZGlaTmthZENieFFBenp4UkJnQ2xqREhRd1hrNnM5U3NaTXFnalBk?=
 =?utf-8?B?cHhFaHJMcEVQWmlKWnlVRG9iMEUrcGdWWWsyVFFlMlFXTjR1QXc2ZWdVVTls?=
 =?utf-8?B?UDR6a2ViTFh2UEJyVUpsL1ltWUtmUmlxSkkzZnZpSGdPODlkRUcvam1vMFg4?=
 =?utf-8?B?Y1lLVXJjVHlseWRlK3o1SDhLRDF3SFc3OGIvNFFjZFR6b3NYQ2NmYks2aVUr?=
 =?utf-8?B?Yi9qVTdNdURNWTIyc1dJcnNkVzNlMWNBZVAwWVZyMTRoRlhYbTU4WTlmb2I0?=
 =?utf-8?B?OXZBSlBxRkNMeEhMN0plcy96OEtsR1JJM2E5QUpndE11ZzNtUDF1ckl1U3cv?=
 =?utf-8?B?anAvNzJsdDRZekwxRm9FckJLY0VsUTBBb2xxOGxCdkI3Q0QzeTNKbU9nUjl0?=
 =?utf-8?B?c0ZuYS9qYVduQ1dKZjFiY1dRWUlqMVZQWWx1dVZLZklCODREc1dpV3BPcnFP?=
 =?utf-8?B?d3ZmWUxvOFcySkk5a2J3b214aEZ5dTE1RmZ3bnNuMFZZQXNRQTh4UVdrVjY4?=
 =?utf-8?B?clp2R29GYjhmOHJubmpnVEpiSVNzckZHanBqMHRiUVllTDZwMUtFVXZEanRD?=
 =?utf-8?B?M0tlOXVsZFZWRmZwVExsYzNrUkQvOFBocUZNcjd6UmhpSDBZclEvQytxQ1Zp?=
 =?utf-8?B?OEFvMkRkSmU1bTl2cXNEaHRjeE82djlHYUo4NkJIVjhRYXBuejVtb0l0S3pV?=
 =?utf-8?B?WjM3QTdrbU4vcTVqZ3cwSmdnaUh4Mzc5SnZyMDE4Y0Nkb3FRSGZ3RDZUNzQ1?=
 =?utf-8?B?VEFIZGVydUdqazdralBBZFdKNjU5bStzcExYRTJGcis0VkpvOEl0cGRvc2px?=
 =?utf-8?B?S2V5Y25OempMaG5zaThwU0pjSFg4Mk5ScEZnZlg1SjU4K3o0ekQrbGRRZ1VV?=
 =?utf-8?B?Wk9XZG1lZlpsSWFQL2dvbUI2dlpCTzdnQ2JDVVdLWUUzSDJNdUtweU1neldH?=
 =?utf-8?B?YTRSTmFqZGhWVDVoc0RoL1RnZmhYWTNMTUZudEY0U2NxbVBqMzJ3UW5YU1h1?=
 =?utf-8?B?Qk5VQ2lwZzRZSVYwVVl1aE95bm1wTHVyLzl1OUNTclB4eUUzRklqQjV6M3Q3?=
 =?utf-8?B?TllhejdORUJ4Y3FVTkROY3h2Q2ZEVzRrNVNvcVk0elRaQlNTeTZMTzRGcjV2?=
 =?utf-8?B?WEFLaHJMOVRXTWxlS3ZSYjJyTE9tWlk1YXBEUXpiSnFsQmJOMDl4RjhCV1lN?=
 =?utf-8?B?ZUdtT29KYTJHWXhGbGF5KzY1RFhBQTlLZWhLVSs2WmttdGQ3dHFkcERaNHRj?=
 =?utf-8?B?OFEvYmR0aFB3QmpOL2h4ZTJEL25Zclk3ZWtEcmpDbFBjT3VYQlRNaitaeHVs?=
 =?utf-8?B?Rk4wZGFSaFErQXAzUlFQckhpYjA2YS92Zk9RaTVuSFloRmhNYnQ5bUdwV3Jp?=
 =?utf-8?B?dXhJUWxua2hpeEFhbWhva0l4K0N2RUtGSHM5SnpsV3VVWnJwdDIrL25GTEVS?=
 =?utf-8?B?dnBsSkVLZFZFaXZWbjRsbUJsc3VwZE8wSjRONllWZ05HUE5oUWpuWFFjKzBh?=
 =?utf-8?B?K3hZaDZQZld3M2VVNm1TLzFOMkFnMEg1bll3NmliVUt4dzVIQzBSZHI5TzdF?=
 =?utf-8?B?WUY1bEltWUl4SmxTY2ExczZjaXVZWUFyaHI5SDBqeTJqRzBVaXVwOHRac2d1?=
 =?utf-8?B?VGk4M0tOWFpPZ0lUSGZzb1p4LzJsdDFJUnpaYUJvZGkrQ21RN2Vrd0pKWFhY?=
 =?utf-8?B?by8vTWFvbzV3bW93cUFQUitjR1poQmlZQUpoN3hBS3F1ekpSMnk4em8xQ2tQ?=
 =?utf-8?B?dzJrdTk2d2hpRHdWb3NZalBUU2F1Sk9zT3pmb1B5azNVV05TNVJGWkh3amhz?=
 =?utf-8?B?cTcwb0RRSktZR01OZm9HdzcyQnpkR2pUYytEckk4ckN3V2JJNzFlalRhN0Vx?=
 =?utf-8?B?Vy9na1A3bVFkVlZIUzFMckdXVUdISVBhOHhrNlJVbWVXVXArQzhJK2pySFZP?=
 =?utf-8?B?eWZUemlseEJnOUMzVm1meHJCQ01zL0w2OThPMGRFb3BqTGlyaUtvNlFYK0xD?=
 =?utf-8?B?NzdNbFp4alVnY3RCM0V0REhiQldwNk12MDdXWmxzK1dTK0tNRm8wRFkwd2xQ?=
 =?utf-8?Q?r8ijtXyM7yelOMWFjPuodo9ko?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12352e0-9738-4b12-cfe6-08db312eb40f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:54:46.5141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwRCXqMZs/92V2lk2o/GpLTTHtQElz3zyWansg1j8FyPH0nndNMbnHvPxRrS01tJOBn3zy+W5B+IP0hXIzio5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 16:33, Alex Deucher wrote:
> On Wed, Mar 29, 2023 at 11:48 AM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch initialzes the ttm resource manager for doorbells.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 6f61491ef3dd..203d77a20507 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1858,6 +1858,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>          DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
>>                   (unsigned)(gtt_size / (1024 * 1024)));
>>
>> +       /* Initiailize doorbell pool on PCI BAR */
>> +       r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL,
>> +                                   DIV_ROUND_UP(adev->doorbell.size, PAGE_SIZE));
> In practice this would never be an issue since the PCI BAR is always
> at least 2M, but I think we probably don't want to round up here?  I
> guess large pages would be a problem, but so would going beyond the
> BAR.

Agree, will take care of this.

- Shashank

>
> Alex
>
>> +       if (r) {
>> +               DRM_ERROR("Failed initializing doorbell heap. \n");
>> +               return r;
>> +       }
>> +
>>          /* Initialize preemptible memory pool */
>>          r = amdgpu_preempt_mgr_init(adev);
>>          if (r) {
>> --
>> 2.40.0
>>
