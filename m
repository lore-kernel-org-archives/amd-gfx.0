Return-Path: <SRS0=lW8h=N3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956DCC433EF
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Sep 2021 11:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC7160F6D
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Sep 2021 11:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3EC7160F6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD938986D;
	Sun,  5 Sep 2021 11:31:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA6728986D
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Sep 2021 11:31:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWpYN2+tgPqufFkHsrA7ozAEk2OirIojHirBJtLyjoxOpu5ZzNU7TNhBSDo67yhhkRfAgKV3WpfcIHb/9CjVGMF66x8TAHe2Trf66mENtZIiOvqorwmYuBI2OymzhyHuKJPGAk6n2F/hVmp4vFUXq8BwSWZ421vD4sIvVWtcy2jovOD74Hl0i7ZArT6pi4GEOJRNtWxV7S855vaRS1Kqfkl9AYJ1KKTwE+k4E0KqomNuS16bykqWcjfW498jr0M+fHMh10YNwTizqKzARSDGUNu4JgJXcocMmnn4iwpsTlXPIiCvDL7WGBE3YHivQFkd00FjdFwRG29ZL0xrCkym6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=h6f+IujZ5vKouIHRg5Dt97jkkOIQBrMsB/CkhgFFsD0=;
 b=i3H4t1Sl71VWi80kHzZpjoZf8OLf2ld9tCSUA/DxeETZFNa2XIvUWzRhHcpDjczbWgWXbDS8sNkG4Ga4s8llGa7ipC7ZimojZSns7sEYg+WnlvRDYfA0uMXov9Zd0OxNqNJobcft7eYU0SLxUKC1rg5e/uhAWmndYTT5EFXzxM/3pL/vCGsdb71qUxz90Z4fjuSRbDeHEzjp/GLpbEk32/PjszbriQ3CAE694IX/6d2ezS5/2ckXCROwk9xE9lu5BCjL//53d6p02h2JPQ1/SrqwzZxn7cJiupu1JkiVjHqxP/fh4CAbcEe+B1gba1LtvZMPkA10udKuIF6xa6559g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6f+IujZ5vKouIHRg5Dt97jkkOIQBrMsB/CkhgFFsD0=;
 b=HD7UshqF1lJzBx3Mx3OFajvfBr3erJgUZpljMwpuaGCpYUah2rUCLW4kyyFa8bsTDNVQq7xIcVsTpuBwrG7tf88PQtvVDh7MwlumJg7XilIbeARp8uR2kqoDEmTH9iao+E5NSvCiUwOcwmNZLI9Zw4slCuyAA5LD8Sz5CO2kTGI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5344.namprd12.prod.outlook.com (2603:10b6:5:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Sun, 5 Sep
 2021 11:31:31 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4478.025; Sun, 5 Sep 2021
 11:31:31 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup debugfs for amdgpu rings
To: "Sharma, Shashank" <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20210902114459.3866-1-nirmoy.das@amd.com>
 <20210902114459.3866-2-nirmoy.das@amd.com>
 <e3a13fd6-f3f3-7980-14d6-b93948053535@amd.com>
 <29a155c4-085a-442c-08f7-50ea56f831d6@amd.com>
 <ba709b1d-5eeb-e748-811f-fbea728ab0b9@amd.com>
 <82d8e743-1b0f-daa9-3bda-fc791dd1795e@amd.com>
 <7370b0d3-a179-1138-bbc7-728dcd131498@amd.com>
 <1b7ec90e-752a-3111-c226-25ec1d3c385f@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <0db529ef-e19f-550a-ae01-bed1a586765f@amd.com>
Date: Sun, 5 Sep 2021 13:31:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <1b7ec90e-752a-3111-c226-25ec1d3c385f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR0P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::10) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f23:5200:fcc7:c2b:1dea:dfd2]
 (2003:c5:8f23:5200:fcc7:c2b:1dea:dfd2) by
 FR0P281CA0075.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Sun, 5 Sep 2021 11:31:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cc33218-7440-4c97-5250-08d97060b56a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5344:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB534495E2B9E144495DE561D18BD19@DM4PR12MB5344.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52MwefIllRo5Gk+ThwcGCPjDooudlgZGO/rRbSSvw3YcVCJGqMxgvnIWVzC0C4TOqrGxwlYw1DtZGg5B8O3Gf77ZJm5he5+2e8BfYqtiXetAZuJfOBVT6SdYZMGkLpsh4nB8EGV7CMhWO58cBDSi0ZIHEcVig1uUcu8rd0iYr2Jwb2yDbxOgKxdgl4+CEwURB2GitSDaAyVKKpjJ1QDB1khuW9WFUeOX7aZF6weXniBkPaHbppRF2sdDsFCVZ3Vdjou00+tgq7Gj8tn5wwDfR1OpTvoN5Fc1puY+E2NWqVf5I6rPkYgs6MnNlhwpLbZaGAIh4RaYHDn99Me5q0Clr/JHKsfJ0i428BVpsapTilVynH96mavLiU+IbTT3MOqHlf5cBcENo2R89eVouu/Z9SeKcJJ+zrPxmvFquhrmXSsMGo8eH9/zyEiqOg/6zcAnkLSdGIREuq9GKKoInbq8HIqMO7hjrVGzTkozkAt5FRbJQgp7Fn2+hLqLLL+IRCL5t3FhbYxuHVUImDD02VJJD7AESAqYz4J7c7vRZqSTFGEuxTl5sGGivy8VAPBujlLmMi0bRslntpfxm0QEjmgVvUGPqmcpTp1ECKywRhm2Kz5mYDe1dzEKChKwuFnvT8XVYm7I3KYWKVYg1fvNZVJflXocBkMAGTuwbUxtKCH5Ekhlf6eenqu2O+LON6vU1fXlJ088bF7vVIdnjdifFVRDdCWdBGBNeGongPK+OksHBQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(53546011)(86362001)(38100700002)(5660300002)(83380400001)(31696002)(2906002)(316002)(36756003)(31686004)(6486002)(4326008)(8676002)(8936002)(2616005)(52116002)(6666004)(186003)(66556008)(66476007)(66946007)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk5Sd0p1N2xBd3VZS2J6dUhhR1oyM0hJMGlRMWdVS3lmY3FpdDNOeWtCRVZF?=
 =?utf-8?B?eWx1d2UvaFQ4dVRuSGtJYXAvV2NiVHBiTVhJSVRseDROc2x3S2xPSmZ1dlhl?=
 =?utf-8?B?RW1xdC9aV0F5bVkrNEE1Tkpxa0Z3QkNRSHF6WnpEVS8rV3hyNXQrTWtjQ3ZE?=
 =?utf-8?B?ajBxdDEyL04yZ0d6cHZjR1ZKZWx1YUhFWGQyZzQ4RW11dFozYmMxTU1ubVFS?=
 =?utf-8?B?NTlaYUJrWkl4NEkwVmVPTHVySnpMNVp3SW1SYVRzT0lZK00zMVFicW8vdEZS?=
 =?utf-8?B?b3hJUC9sNVBDYmJpeVZ0bmdyenVWRThCdlBNOUM2akNudGRmM0tOdnU0M3hZ?=
 =?utf-8?B?R09XVzRaaHM1Yng3OVN4d2RtK1hWYUFuY25DWnF3T2V1eVQzWUpJcTFtUUpk?=
 =?utf-8?B?TGgvMGEwVk05cnZaZHlla3FCdFcyVERHSmsxbVRIeWJQdHM0cHZyM1Jucktr?=
 =?utf-8?B?SldJRmszK0R4bFBybGZGQUlCeTJjWFNFZEwzTXd6L3dxR2pIWk1QSDUyMUtN?=
 =?utf-8?B?enFWdkEvMkJtZG8vdVh1aHQ0WFhHa2VUb1A1MVBZS290TUdONmtBZUpsWWZ3?=
 =?utf-8?B?elI3SHNMWjhYbUg4MXZreFJ5a3g3Z0RwWENpQlpjaU9FL0Rsck5BN2JaMXhN?=
 =?utf-8?B?TFRtaWNPZVI0UXhId2VHREdBSHp3ZHZyT0JYVVNIT0ppREorTVBQem8yanl5?=
 =?utf-8?B?Z1UraTBsbG1VeGNXSWZCVVN0ZFpaaENySUMxR3A3MUMwV2JCU1hBV2FPNUNo?=
 =?utf-8?B?SjJiZGF3OEtQTCtKZXpyaktFT1RndUdKQkt6alBsaytWOWdHSXNLcjJCZ2Vr?=
 =?utf-8?B?ZUxSMUlsTWc4OEg1TzRrbDRGOERRKzZERnBFdU1tMzZkME9rT0F6eisrUEJ6?=
 =?utf-8?B?VGNhcFkvNHRGRkVVdlplQlUveGhyVCswVTlpY0ZFOW1hbTNhcFdkQWdyd0cz?=
 =?utf-8?B?emJNaFRUb2U2OWNNV1lSK1FPV1IyMklyaWtrRzQ1QkVMeGNCL3VzZW9INmtz?=
 =?utf-8?B?ZlJUTVVZNElIejB3cjUyQVF6K1N2dkwxYWRUR3hXNzMvemFmODlON0U4VkJL?=
 =?utf-8?B?dTg0Y0h2UHpETTVzWEM4NlVUdUhmU3I4c0VuNmdVaklZMmtlOURxeEhseEh3?=
 =?utf-8?B?N056WkRSNFhsaWp0N2pWKzlTTlE0bzZrVnBkdENGRUdXc0FZNkdUMWtXMEhW?=
 =?utf-8?B?clJEdmpoRU9NYXVBY3FSRGV6WUpvSEZJSDhWZVErdWFPNWNVa3RKSU9FK1Jo?=
 =?utf-8?B?QzJuc1BMUmFNUk02WEhhUkJGQ1F4ak5hYVl4TVZmdkZHODRjUTJwbHh3V3ZO?=
 =?utf-8?B?cXZZTFlzcUwrTDk2NmlXNkNvekFzSUYvU2phNExZUUF2ZVYxaVE4Zk4xVElS?=
 =?utf-8?B?Um9maUl1bWFpd0QvUDBldnkwRWExRkVFMU1nUy9KTklXd2NuUDlBemlEVm9x?=
 =?utf-8?B?ZGVYbENDZWdjMDhubTBCTFZIL1BqZ0J3ajU1RHAxcDk5VU1aTzlPUGZQZzdR?=
 =?utf-8?B?OTBiTEhqL1k4K0t4VnFyV2UxZ2RhamlPdXI0dXRJTVdPODVqS242SHJBRGNL?=
 =?utf-8?B?WXVYSWFMYXk3OEtaNDVjdGNmNzJOOWp5K1MyOHVJUlI1cWxXcDJFZDJ0VFFy?=
 =?utf-8?B?eGxqTExFYVlUU0hvMDZZVzJHNElUWU1jWEFlYS9ySHVxV01CMkg1NzZtR0Fx?=
 =?utf-8?B?dmZNUUl6cTU5bHQ0cEdtS044NE1lbWNnR0QwVm45Yk5yZ0lCYjEwWEtlbDlx?=
 =?utf-8?B?U3lONnQyOGZiSWVxSmJ1Sm1zQ2s5eVl1VTh4K0toUDFWcXo2UGhrU3M0MmFN?=
 =?utf-8?B?MlNqRnJ2eG9EUEJoWkd0QXhRWXlkamIxWjJqazc5enhob3R6a1RzNVJwM3VS?=
 =?utf-8?Q?MbmPMMeRpo8mZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc33218-7440-4c97-5250-08d97060b56a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2021 11:31:31.4283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qscVrL1v1kWjazcXi0p7mr/9vc9vYTMmC2v3eLyVa9qvtKsCaghcGGUgOzEOn34V4o8oDADsKO6/JUanVZF6nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5344
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


On 9/5/2021 10:03 AM, Sharma, Shashank wrote:
>
>
> On 9/3/2021 9:44 PM, Das, Nirmoy wrote:
>> Hi Shashank,
>>
>> On 9/3/2021 5:51 PM, Das, Nirmoy wrote:
>>>
>>> On 9/3/2021 5:26 PM, Sharma, Shashank wrote:
>>>>
>>>>
>>>> On 9/3/2021 1:39 PM, Das, Nirmoy wrote:
>>>>>
>>>>> On 9/3/2021 8:36 AM, Sharma, Shashank wrote:
>>>>>>
>>>>>>
>>>>>> On 9/2/2021 5:14 PM, Nirmoy Das wrote:
>>>>>>> Use debugfs_create_file_size API for creating ring debugfs
>>>>>>> file, also cleanup surrounding code.
>>>>>>>
>>>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 16 +++++-----------
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  8 +-------
>>>>>>>   3 files changed, 7 insertions(+), 21 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>> index 077f9baf74fe..dee56ab19a8f 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>> @@ -1734,9 +1734,7 @@ int amdgpu_debugfs_init(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>           if (!ring)
>>>>>>>               continue;
>>>>>>>   -        if (amdgpu_debugfs_ring_init(adev, ring)) {
>>>>>>> -            DRM_ERROR("Failed to register debugfs file for 
>>>>>>> rings !\n");
>>>>>>> -        }
>>>>>>> +        amdgpu_debugfs_ring_init(adev, ring);
>>>>>>>       }
>>>>>>>         amdgpu_ras_debugfs_create_all(adev);
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>>> index f40753e1a60d..968521d80514 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>>> @@ -415,26 +415,20 @@ static const struct file_operations 
>>>>>>> amdgpu_debugfs_ring_fops = {
>>>>>>>     #endif
>>>>>>>   -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>>> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>>>                    struct amdgpu_ring *ring)
>>>>>>>   {
>>>>>>>   #if defined(CONFIG_DEBUG_FS)
>>>>>>>       struct drm_minor *minor = adev_to_drm(adev)->primary;
>>>>>>> -    struct dentry *ent, *root = minor->debugfs_root;
>>>>>>> +    struct dentry *root = minor->debugfs_root;
>>>>>>>       char name[32];
>>>>>>>         sprintf(name, "amdgpu_ring_%s", ring->name);
>>>>>>>   -    ent = debugfs_create_file(name,
>>>>>>> -                  S_IFREG | S_IRUGO, root,
>>>>>>> -                  ring, &amdgpu_debugfs_ring_fops);
>>>>>>> -    if (IS_ERR(ent))
>>>>>>> -        return -ENOMEM;
>>>>>>
>>>>>> Why are we doing this ? Why to make it void from int ?
>>>>>
>>>>>
>>>>> We tend to ignore debugfs return values as those are not serious 
>>>>> errors. This to sync with rest of our
>>>>>
>>>>> debugfs calls.
>>>>>
>>>>>
>>>>> Regards,
>>>>>
>>>>> Nirmoy
>>>>>
>>>>
>>>>
>>>> I am not suere if completely removing the provision of return value 
>>>> is a good way of doing it, we can always ignore it at the caller 
>>>> side, isn't it ?
>>
>>
>>
>> I just realized while making the change debugfs_create_file_size() is 
>> void return, so we don't have anything useful to return in 
>> amdgpu_debugfs_ring_init()
>>
>>
>
> Ah, it makes better sense now. Probably just a mention in the body of 
> the message that we are moving from debugfs_create_file() to 
> debugfs_create_file_size(), will make this change of return type more 
> logical.


Yes, I have that "Use debugfs_create_file_size API for creating ring 
debugfs file,..."


Nirmoy

>
> - Shashank
>
>> Regards,
>>
>> Nirmoy
>>
>>
>>>
>>>
>>> Yes, we are currently throwing an error msg and ignoring it. I don't 
>>> have a strong opinion regarding this, I will send a v2 restoring 
>>> previous behavior.
>>>
>>>
>>> Thanks,
>>>
>>> Nirmoy
>>>
>>>
>>>>
>>>> - Shashank
>>>>
>>>>>>
>>>>>> - Shashank
>>>>>>
>>>>>>
>>>>>>> -
>>>>>>> -    i_size_write(ent->d_inode, ring->ring_size + 12);
>>>>>>> -    ring->ent = ent;
>>>>>>> +    debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
>>>>>>> +                 &amdgpu_debugfs_ring_fops,
>>>>>>> +                 ring->ring_size + 12);
>>>>>>>   #endif
>>>>>>> -    return 0;
>>>>>>>   }
>>>>>>>     /**
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>> index 88d80eb3fea1..c29fbce0a5b4 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>> @@ -253,10 +253,6 @@ struct amdgpu_ring {
>>>>>>>       bool            has_compute_vm_bug;
>>>>>>>       bool            no_scheduler;
>>>>>>>       int            hw_prio;
>>>>>>> -
>>>>>>> -#if defined(CONFIG_DEBUG_FS)
>>>>>>> -    struct dentry *ent;
>>>>>>> -#endif
>>>>>>>   };
>>>>>>>     #define amdgpu_ring_parse_cs(r, p, ib) 
>>>>>>> ((r)->funcs->parse_cs((p), (ib)))
>>>>>>> @@ -356,8 +352,6 @@ static inline void 
>>>>>>> amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>>>>>>>     int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
>>>>>>>   -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>>> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>>>                    struct amdgpu_ring *ring);
>>>>>>> -void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
>>>>>>> -
>>>>>>>   #endif
>>>>>>>
