Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFE9C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 09:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D440C10EECE;
	Thu, 17 Feb 2022 09:48:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A341310EED0
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 09:48:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mbr5J3cODhugNe39ksDFoCwHneLW0pyyUXozgU+ac4neycsukvn0T1BcsRCpyVY8P2+b5xnU9bZyXRmgJ42xEmKoN4X6DYd3WUx+LDqjM5v3erxzOVRz532W2laPrtMcXPUS8a1OumUyaNDZIVyTPAwKTntm6GbYwJdKhFkVXl3FjnI6fp/jyCGdFDPTk2+LrVf595JB44FettWp0qmcLT+zg04ZOPzs5J7WfRi5ezKF9LzvUUokceju1uQ0cu4/jXgwoEgBkSyaB9GbptFW3U689jvEiVTayA6IO7lIaVyEnKY0QskiG99Eb/ysKYatAKRGX/+hNsTLnaW2Nuzl0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSMeUWq05AJuSkjPtBsRdBtSIEYL3nx7F1xazCXnq3I=;
 b=h1//YQVsnFAcLTX6AX6H1A8jgyba/svD2vwjzyTu5WGZKx7PPfLGD/hWWYgchb2M//5GplUmFsfNv+lWDAjeArwjqGDbKx2KHNKjStQyqrOj4BkB5qjUHq4CsTD4CKW4IV8ifI5WtykYyh7n9nxIPcpoP36FcsJrJqApVwKrf09jwlmq7o3R4XtCX1fnqYkTCQI9vU64900GS3wI7qUQILMOuqTm0BWl25TYFy8aCOkQ84ec1wVMwPJiTQDZKj3h4pbhhGtzs/txHCIqueC8cvRx9NK/X8HCxqyv17b8s37kmVMsM9PCqELp0j3n7e4oUxg6lWvzMXy2W7OJECAlsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSMeUWq05AJuSkjPtBsRdBtSIEYL3nx7F1xazCXnq3I=;
 b=QBGKBlZVICbLdwP7DfjDEg0ws6mAWbwa09p8l1wDPyyGBpXndOdBgHNFSpEfk+ZhEsH6XaNR33yCWSbPgIoBe6QGHjQVimIJdS/IHHrfTy/GGwZ6uIrziMkfg4HZuPqb9jJcFG152INW9AMEPtFxzUKj2WLz1FkKBsGqsBA7aAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN6PR12MB1714.namprd12.prod.outlook.com (2603:10b6:404:107::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 09:48:22 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 09:48:22 +0000
Message-ID: <dedecd79-ca3d-7b1c-595a-a6e5e56d2161@amd.com>
Date: Thu, 17 Feb 2022 10:48:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 "Somalapuram, Amaranath" <asomalap@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com>
 <ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com>
 <d531c825-332d-036d-c4b4-5e2cf39edb52@gmail.com>
 <94eeed88-69ad-5823-0505-dc86b36c4007@amd.com>
 <09a4d26f-04be-2a84-343a-32166d21afd1@amd.com>
 <b19700b6-3f68-1654-a07a-371351fe3652@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <b19700b6-3f68-1654-a07a-371351fe3652@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR01CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::26) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb5a2ede-d124-430c-0615-08d9f1faa2c4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1714:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB171401B9D4C02EE3CFA10CCF83369@BN6PR12MB1714.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfdJ7dbaAY0ttsbLKqphEtOOQogRp1tAryKOzPq4pc2bQP5RnEXulSjVXkb8g2ZHHj7zIp9BmJB1a0tY4p0flqfi+sQEc0tyRpfq1F+wXBnz9765XZmIMCBgyIjNkMY8EdaUeKX4nmA7rzrYDNlOVcmlLTleo3Bp0muRZs6ugJUUm6AhR/tKuNURItr9dsO9keByJmhra802WvYdsRMXVWxqw/2ZX1TaLVKJLYxyIQHfsfXVtkLVOMqSS0jg+a+wh5jx6qZKI97Mizn2eQtR69VDvmVrRpR0J87ki3zbr6ka5qoeYu3bdNB3dBirF9En5mjz+8oqCQ4g7y9rvxqmMTBcvAnbzXYOAbivwiFvBs4yEXG7350jGDl32rpgH80JK/zlNQN/Pe2tFQE0NyUAqBj7YiZ4P6HLzHqKtjObHmB5On6Nw10ie1HCj3N9skbJNab0WmZjF+UFmncyzXsFpxVuQJ6hTCSiu4H6gDtcwIITasSjErpEhF8gYRVFpvgOEDKpIRJfhLZNsSktKkjDYCkl1WesQ/wU2o7QWQJmhrbCoD51MbaQ4wJbAvlXKVa+uuEoTS3A+wlpt1Gge4f6akuoWmlHnz5rLq79NafK54kGF+EwoeOedL8pQB9+s/iKAxlkpYCnEZOghExIeK//+77TOb0TGKtOpH2EC1vImdt+0y/r4+u9f9FrIRVeOP+BmlOaaTRfedSkJI5ppvAZDe83ymYB8uMRF4SVpcURW/EXqM7vivYVBM54+VTXZQyv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(83380400001)(36756003)(66574015)(66946007)(66556008)(8676002)(4326008)(53546011)(6512007)(6506007)(86362001)(2906002)(31686004)(6666004)(38100700002)(5660300002)(6486002)(2616005)(186003)(508600001)(8936002)(316002)(110136005)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0RlaHlHeTJ4UnRoZmRXQlJiVmg5WjhkSTh6Tk1vTTlScEEveWJGOXV3Zldh?=
 =?utf-8?B?a1QySnJEOTJZV2wzUWY4ZTFyTXVTWDFwcUJyS2RyVzBNQW9qazJjdU02WStm?=
 =?utf-8?B?aER3QUVNcmJSVkVwNHRQWWtCR3E0eXpEQTYwTHgxOE5qQTlkdEtpdTJvNG5x?=
 =?utf-8?B?cTF4QW5WOUo5d084MUUxTXg0dTc0VSswQVRYRXdOWDRWMmVySlFRRi9kSG5x?=
 =?utf-8?B?UWYvYms5eU5xbDdpcXFRMUVmdnhJd1VRaVZlaUZJWTZCbXg4RXc0VUVrUXgr?=
 =?utf-8?B?R2pFS0ZiVWFtRnFIekxROUpzc3lXWnM4VVUwSjdUZUppTzRIZUZqWkY3ZFV0?=
 =?utf-8?B?K2dXQ1N0K1Jia3RnRVJVNlY3aWpPemxLV09Vd0RscjBiRDBZR1FnakVabXJP?=
 =?utf-8?B?eEpKR0t4UVE0ZkFFMTJuOERNTkxPcU1vMlFEVmRTMjZuS1hiMnhYZk9pQkVN?=
 =?utf-8?B?dE9IV1FHLy9nS0cyNGhWUHdyMm9NZ2loekZsWWwrb1MxRVB6ZzMyZGVvZjdL?=
 =?utf-8?B?S1hrY0hRU0RJVjEvRzk4eTNFQlY4MkJ0REJHRWNXWGZiWTZYMDFrQmxpQlgx?=
 =?utf-8?B?Ym41bUM3R3ZQQU9TbzIzRUd5YlVISWZIN1NPN2trWUtpWFQ1VWM1R29aWmVm?=
 =?utf-8?B?YmhwRGJaQUIwU0FWR3U3em0rSFBXZDFYK0c2SUdVeVB2ZGMrWnlzRUhzelQz?=
 =?utf-8?B?UW50QnhqQXJHSDVDRFZ5N1dQMHJrbjFaMjNJeHlsRzFPOWwvWGY0S0RQRmV6?=
 =?utf-8?B?eFl0KzRUVXFLOXlUWUppMUgvcnV2bWYzSzlaL1ZlNHo2Z1V1YkY1S3JZQ1cv?=
 =?utf-8?B?S0N2UXIzdnYwbVBpKzU5SmJLTDN4akNrbDZMYTA1MU5GeVVFMmJqZWFlMStu?=
 =?utf-8?B?UmtpRFZoS0lUaDJaTE14Z2RXdXh6ak5ETy8wV3lYbWNtQWlsV3ZWZ2hoT3N0?=
 =?utf-8?B?alJ1c2FLZnhCOXNqZHk0SGcxR2RLUjZrTVYrWlFFSnZiV3o5cHorM0JZdm1x?=
 =?utf-8?B?TlQyWEc3bFpPZ2NkN3dEWXBsTG8xRnJwM1NvOVZTaDQ5TmRnY2dBK3lZLzMy?=
 =?utf-8?B?Ukpvc0pmc3RRMFBBa3FLRldvelcxL0Vlc2duaTh3MnI4bUlqR3RyZUFyU1Yv?=
 =?utf-8?B?eVh6NjBrcnIrTVMzaGU1c3Yzb29pUlQxZVN6NXdsWGUrcG1SaW5teHJnNE14?=
 =?utf-8?B?a01JYk1hWHRLV2xVR0NBYkFiZUpSK3NLODZRd2xNNEJBaFFnNkcwcXFXaEFJ?=
 =?utf-8?B?cmZLaHhZMGllWTFsMlIwYXFVY3FrZW5rZGpLdmtMclVlTjFURk5UNjlyMmY5?=
 =?utf-8?B?UEUvRkFkcVN4MEdFejJVSTZuMjRhSDhndEMrVlJuYWNEUU9EVnBWeFFETUF6?=
 =?utf-8?B?VXM2RTZUSUNVQ2ZnRzduTHZ4QzNTV1hXMWxJTDVxb2I2MW1LTWlWV2pib0tQ?=
 =?utf-8?B?RnhpRVY1SitRMjN1aXBUcm5ka2VTVWpqeUpySGphTU1vZldTZDlmRjUrR2ZK?=
 =?utf-8?B?QzJSeGo2ekUzMEUyQjhmcGNpTFhTaUZnVGJuY2FnbzZvcmNwM01DVFAvN1FD?=
 =?utf-8?B?VkNOc0pVUGdIZkJXOWF6K1FhbWdvL2ZnUFFONUxYMGhDbmZ2ZWM2TGIrVUlx?=
 =?utf-8?B?Y2pxM3dpTG1hcTl4M0o5cVdDd2dGTTk4QWFyVEM0RXp3Qjd2UXhtZkxVZDJ3?=
 =?utf-8?B?RGkrRGRsVnppY1F6OGpRdEFNNnNSTDRQbFMxOWE0SDIrWlJtREVqam5zS2JL?=
 =?utf-8?B?cUsycTVnNStIbGYxdFNtMXdFeWE0ejVVZ3JXWkEwNTRDaENIZEswdEQzUFdm?=
 =?utf-8?B?VEloSUlIcncreFhYK1RwMlZnM0gwR0YzRUpOMTRtOFhzdU16dlZDcFZHRWtR?=
 =?utf-8?B?RVlCaVlxdE9GN050T3UrdUZPQ0FzeWs4MjRseklhM1BBRUVSU0tSSkVKUXZm?=
 =?utf-8?B?TW5uTENYNkU2WmZqQ0FmYnR4emgwNjVHMGZaZ3g0R1NVclVNQmdPLzJ6U01E?=
 =?utf-8?B?UGJyS1Fya0xYV3N1b2FQMDBaREVSZFZYQ3lJZTd5clJKWnhlUEZPUnR4S0dN?=
 =?utf-8?B?amJtSUtuQ2dGc2xzVjVZQWF0SG54aWV3bmhZSjhZQVRqZTdMZzNkV055M1gr?=
 =?utf-8?B?TG4xdHVKRGdTKzFpT003Um1maXB1QmRTcnpGRmMrREtodnhxZ1d5OFBGcVFa?=
 =?utf-8?Q?tuUElXxosh4XoYeojYEIQfs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5a2ede-d124-430c-0615-08d9f1faa2c4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 09:48:22.6853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paTIidGD9O+G7cJW852tmoXWjTmoISkfDhR1yeGkNNUmLEeTBhIUNkKycE7hNIu7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1714
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.02.22 um 10:44 schrieb Lazar, Lijo:
>
>
> On 2/17/2022 1:30 PM, Christian König wrote:
>>
>>
>> Am 17.02.22 um 08:54 schrieb Somalapuram, Amaranath:
>>>
>>>
>>> On 2/16/2022 8:26 PM, Christian König wrote:
>>>> Am 16.02.22 um 14:11 schrieb Somalapuram, Amaranath:
>>>>>
>>>>> On 2/16/2022 3:41 PM, Christian König wrote:
>>>>>
>>>>>> Am 16.02.22 um 10:49 schrieb Somalapuram Amaranath:
>>>>>>> List of register populated for dump collection during the GPU 
>>>>>>> reset.
>>>>>>>
>>>>>>> Signed-off-by: Somalapuram Amaranath 
>>>>>>> <Amaranath.Somalapuram@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 
>>>>>>> +++++++++++++++++++++
>>>>>>>   2 files changed, 100 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>> index b85b67a88a3d..57965316873b 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>> @@ -1097,6 +1097,11 @@ struct amdgpu_device {
>>>>>>>         struct amdgpu_reset_control     *reset_cntl;
>>>>>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>>>>>> +
>>>>>>> +    /* reset dump register */
>>>>>>> +    uint32_t            *reset_dump_reg_list;
>>>>>>> +    int                             n_regs;
>>>>>>> +    struct mutex            reset_dump_mutex;
>>>>>>
>>>>>> I think we should rather use the reset lock for this instead of 
>>>>>> introducing just another mutex.
>>>>>>
>>>>>>>   };
>>>>>>>     static inline struct amdgpu_device *drm_to_adev(struct 
>>>>>>> drm_device *ddev)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>> index 164d6a9e9fbb..faf985c7cb93 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>> @@ -1609,6 +1609,98 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, 
>>>>>>> NULL,
>>>>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>>>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct 
>>>>>>> file *f,
>>>>>>> +                char __user *buf, size_t size, loff_t *pos)
>>>>>>> +{
>>>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>>> *)file_inode(f)->i_private;
>>>>>>> +    char reg_offset[11];
>>>>>>> +    int i, r, len = 0;
>>>>>>> +
>>>>>>> +    if (*pos)
>>>>>>> +        return 0;
>>>>>>> +
>>>>>>> +    if (adev->n_regs == 0)
>>>>>>> +        return 0;
>>>>>>> +
>>>>>>> +    for (i = 0; i < adev->n_regs; i++) {
>>>>>>> +        sprintf(reg_offset, "0x%x ", 
>>>>>>> adev->reset_dump_reg_list[i]);
>>>>>>> +        r = copy_to_user(buf + len, reg_offset, 
>>>>>>> strlen(reg_offset));
>>>>>>> +
>>>>>>> +        if (r)
>>>>>>> +            return -EFAULT;
>>>>>>> +
>>>>>>> +        len += strlen(reg_offset);
>>>>>>> +    }
>>>>>>
>>>>>> You need to hold the lock protecting adev->reset_dump_reg_list 
>>>>>> and adev->n_regs while accessing those.
>>>>>>
>>>>>> (BTW: num_regs instead of n_regs would match more what we use 
>>>>>> elsewhere, but is not a must have).
>>>>>>
>>>>> This is read function for user and returns only list of reg 
>>>>> offsets, I did not understand correctly !
>>>>>>> +
>>>>>>> +    r = copy_to_user(buf + len, "\n", 1);
>>>>>>> +
>>>>>>> +    if (r)
>>>>>>> +        return -EFAULT;
>>>>>>> +
>>>>>>> +    len++;
>>>>>>> +    *pos += len;
>>>>>>> +
>>>>>>> +    return len;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct 
>>>>>>> file *f,
>>>>>>> +            const char __user *buf, size_t size, loff_t *pos)
>>>>>>> +{
>>>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>>> *)file_inode(f)->i_private;
>>>>>>> +    char *reg_offset, *reg, reg_temp[11];
>>>>>>> +    static int alloc_count;
>>>>>>> +    int ret, i = 0, len = 0;
>>>>>>> +
>>>>>>> +    do {
>>>>>>> +        reg_offset = reg_temp;
>>>>>>> +        memset(reg_offset,  0, 11);
>>>>>>> +        ret = copy_from_user(reg_offset, buf + len, min(11, 
>>>>>>> ((int)size-len)));
>>>>>>> +
>>>>>>> +        if (ret)
>>>>>>> +            goto failed;
>>>>>>> +
>>>>>>> +        reg = strsep(&reg_offset, " ");
>>>>>>> +
>>>>>>> +        if (alloc_count <= i) {
>>>>>>
>>>>>>> + adev->reset_dump_reg_list =  krealloc_array(
>>>>>>> + adev->reset_dump_reg_list, 1,
>>>>>>> +                            sizeof(uint32_t), GFP_KERNEL);
>>>>>>> +            alloc_count++;
>>>>>>> +        }
>>>>>>> +
>>>>>>> +        ret = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>>>>>>
>>>>>> This here is modifying adev->reset_dump_reg_list as well and so 
>>>>>> must be protected by a lock as well.
>>>>>>
>>>>>> The tricky part is that we can't allocate memory while holding 
>>>>>> this lock (because we need it during reset as well).
>>>>>>
>>>>>> One solution for this is to read the register list into a local 
>>>>>> array first and when that's done swap the local array with the 
>>>>>> one in adev->reset_dump_reg_list while holding the lock.
>>>>>>
>>> krealloc_array should be inside lock or outside lock? this may be 
>>> problem.
>>>
>>
>> This *must* be outside the lock because we need to take the lock 
>> during GPU reset which has a dependency to not allocate memory or 
>> wait for locks under which memory is allocated.
>>
>> That's why I said you need an approach which first parses the string 
>> from userspace, build up the register list and then swap that with 
>> the existing one while holding the lock.
>>
>
> Another approach would be to just protect debugfs write with 
> down_read(&adev->reset_sem) or reset domain semaphore.

No, exactly that doesn't work.

See the down_write(&adev->reset_sem) would then wait for this reader and 
the reader is allocating memory and allocating memory might wait for the 
reset to finish => deadlock.

Regards,
Christian.

>
> Other than that if apps are trying to read and modify the list at the 
> same time, probably we should leave that to user mode since this is 
> mainly a debug feature.
>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>
>>> Regards,
>>>
>>> S.Amarnath
>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>> There are 2 situations:
>>>>> 1st time creating list n_regs will be 0 and trace event will not 
>>>>> be triggered
>>>>> 2nd time while updating list n_regs is already set and 
>>>>> adev->reset_dump_reg_list will have some offsets address 
>>>>> (hypothetically speaking *during reset + update* read values from 
>>>>> RREG32 will mix up of old list and new list)
>>>>> its only critical when its freed and n_regs is not 0
>>>>
>>>> No, that won't work like this. See you *must* always hold a lock 
>>>> when reading or writing the array.
>>>>
>>>> Otherwise it is perfectly possible that one thread sees only halve 
>>>> of the updates of another thread.
>>>>
>>>> The only alternative would be RCU, atomic replace and manual 
>>>> barrier handling, but that would be complete overkill for that 
>>>> feature.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Regards,
>>>>> S.Amarnath
>>>>>>> +
>>>>>>> +        if (ret)
>>>>>>> +            goto failed;
>>>>>>> +
>>>>>>> +        len += strlen(reg) + 1;
>>>>>>> +        i++;
>>>>>>> +
>>>>>>> +    } while (len < size);
>>>>>>> +
>>>>>>> +    adev->n_regs = i;
>>>>>>> +
>>>>>>> +    return size;
>>>>>>> +
>>>>>>> +failed:
>>>>>>> +    mutex_lock(&adev->reset_dump_mutex);
>>>>>>> +    kfree(adev->reset_dump_reg_list);
>>>>>>> +    adev->reset_dump_reg_list = NULL;
>>>>>>> +    alloc_count = 0;
>>>>>>> +    adev->n_regs = 0;
>>>>>>> +    mutex_unlock(&adev->reset_dump_mutex);
>>>>>>> +    return -EFAULT;
>>>>>>> +}
>>>>>>> +
>>>>>>> +
>>>>>>> +
>>>>>>> +static const struct file_operations 
>>>>>>> amdgpu_reset_dump_register_list = {
>>>>>>> +    .owner = THIS_MODULE,
>>>>>>> +    .read = amdgpu_reset_dump_register_list_read,
>>>>>>> +    .write = amdgpu_reset_dump_register_list_write,
>>>>>>> +    .llseek = default_llseek
>>>>>>> +};
>>>>>>> +
>>>>>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>>>>   {
>>>>>>>       struct dentry *root = 
>>>>>>> adev_to_drm(adev)->primary->debugfs_root;
>>>>>>> @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>       if (!debugfs_initialized())
>>>>>>>           return 0;
>>>>>>>   +    mutex_init(&adev->reset_dump_mutex);
>>>>>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, 
>>>>>>> adev,
>>>>>>>                     &fops_ib_preempt);
>>>>>>>       if (IS_ERR(ent)) {
>>>>>>> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>                   &amdgpu_debugfs_test_ib_fops);
>>>>>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>>>>>                   &amdgpu_debugfs_vm_info_fops);
>>>>>>> + debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>>>>>> root, adev,
>>>>>>> + &amdgpu_reset_dump_register_list);
>>>>>>>         adev->debugfs_vbios_blob.data = adev->bios;
>>>>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>>>>
>>>>
>>

