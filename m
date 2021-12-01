Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7CBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 10:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68E46F451;
	Wed,  1 Dec 2021 10:46:31 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF7B36F451
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 10:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=he7I5ayFwT3BroLA8UqsDOIYa/V2zxylzfqLUCc0bBbnZeM+jeM7Jjw3kj6KoHSjOdrhK3kSfl+a+zXEIzzHcNxZG9kR/Rly1Jvtpms7bkW7RCZKyZO6BG5D+7Unx2eR/GmQrFjUmwaBw5foEOzg+xyyejLROnbkAqw4nBoGbNz0sw4vACrvOdmjdN0Gcsk/qKAKPi47IPi+nZi1VHkuAdHtlCASAqy3qBW4VkI11fZCQ2Wzatp8jrT+wz2BY+PxZXPLFeMN4wuJCHfwlgJ1DlSVzJc3L+V9iUOHA3THGSrfXxbHWb4g2KCDZt6Tc3MhB2iaJzkEfpcCwzhVPSoINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFGdlBCSWgpmvv24+Ld59SnYMfMlVu0XrfspZaO28uI=;
 b=oCgMlOxDyQVMZkg4z2SvPpuYsbF0pIKzRtlXyWi61BdTewpWR19q8/M9ba/suzwwnXwvlYfPDSePS1W62+CffXW9HRxLLdkNFn96yYy/CmBbIhg7J4piWVbGH83CXQ9tETmFdbyr1MzZuhrhhKZyjaKXJ7/9dWQVWe7Z6JirEt8j606TgkJjrrAY03EHcRYvW1ok45/ujMzMKbaPyROlvdmnuMDc+HTwjqfeQMIEm5eVT9Iaw+ZJeM+KRtqph2x69hFrehnOvMGO0sUcdh5pm2oAcUr0ZXAUsm7akUlV3kKiRMPcp3xyRv4zx4U/KvNtwljua/OeguVMucwZ5JB/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFGdlBCSWgpmvv24+Ld59SnYMfMlVu0XrfspZaO28uI=;
 b=XhduvPVq01CE+HkEJprY/AH5Yo1ZrUhyZgb+z6bLBc9PvXKe1rEnm+wbXTCZq2sF4NCua6HnW8lVO5KvSEUmBl3jlWKbXNKrGaMQoZ344FfyTTzi6wZzyjZIaxejlicdckg+cdsgwfSPNLjE7RNwZzggO4Pv1dRImWNfJw5RcdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Wed, 1 Dec 2021 10:46:28 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 10:46:28 +0000
Message-ID: <fbf8277b-27e1-03c0-3f9b-ee1defd7fdb2@amd.com>
Date: Wed, 1 Dec 2021 16:16:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] drm/amdgpu: add support to SMU debug option
Content-Language: en-US
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211201092458.3348858-1-lang.yu@amd.com>
 <1f8f87f7-acac-acb7-5e1c-8baa643de7b3@amd.com>
 <DM6PR12MB42508C1A0E5EFA6D522C02D0FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB42508C1A0E5EFA6D522C02D0FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::26) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BMXPR01CA0016.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.24 via Frontend Transport; Wed, 1 Dec 2021 10:46:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 681b2373-b059-47dd-dbe1-08d9b4b7d416
X-MS-TrafficTypeDiagnostic: DM5PR12MB1657:
X-Microsoft-Antispam-PRVS: <DM5PR12MB165708D36152D5D6B384FB3E97689@DM5PR12MB1657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vODrAGXb6LD72kMIgPMiIsvrUgjnFBURiU2h8o7qWR4rqRwCll1XcAByppu10W/nyeo/FyL/fjUuB2F456JYM026sNJJzItuCFCWkeqjT/BS9flrrz9+tVu9pDyW9JvPHGW57ZDa/XBYtVd/aOvP10Gvu/g2glYqtiNC9tNrnIuWsArEBGmXaI9KkQeEukDDfRy/D041ceJeKKIcZZtfMY5tBQoLubuCqCBsCMKLt28QDvQBR4orIQQh0SWBVpQqtVh2ycBYOnnqEtxWCE4XWZr3oQ44T7b2VFfTEP8iwfQFYB2sHXZV5qCuYclEbackcI5+U5Wp3HI9GcAoB5hqqC7MwDJww//8xVGxF95R8W//TIGeQeTz6aIg/oeLFJajqaoN+RvRdpU+Yj1hMt7wxxAGs5B47oIynLCRc15AzH18Gv2cFmBqSccEH/ByV+1x3U++p1LZRg1OYWZL5h1Cj5UbgA6zcUh3TtQc4vvKBklEd/EGCs8HhiwUJoECa4kUuYAU38484HfQY8P8FvgGuKX3hf1eIh87Ii/b4EWxK5cv8WX1rwOyy+Nxox/37YSBv0cOSCCKEHslZdkpLFv5mUMuU/3Y3cBI94N1837+awXAaIgbkX6vqEtkv8Ql6GnccuVyA2AT6Pm60gK9JX9Yu6EIBjj7fOJlmRl71CBh9J3PT0d0T/c9iUZoFb887aGnn8O/8p3ESnv5HQ5uTFrimUN0SzmNicOhjCPjKTqvO5heX2KdFi46cJ7EZN3FDiUF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(54906003)(110136005)(16576012)(316002)(8936002)(31686004)(83380400001)(6666004)(38100700002)(66946007)(956004)(31696002)(66476007)(2616005)(5660300002)(8676002)(36756003)(26005)(6486002)(86362001)(186003)(508600001)(4326008)(53546011)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWI5cS9oOFdUdmNpbGRDanExSnFsZzdkK0pnTmdYUm4wOEhEY0thTDV3cmVs?=
 =?utf-8?B?aitXU04rQWJUSTBmNVo0c0lhcE82NTJyOXVaZFFpR2pkOVFIekxEUVg2VWJE?=
 =?utf-8?B?eFh6WTVCQWRtZXJROEY5SE9lK2VvZGNQSE00L3RUcE9EK2l3cjlVOUxGYWtP?=
 =?utf-8?B?eUJxYnF6VFRiRXZUbW9GY2hhN2FDOEpXZVpoeENwYWQ2RXYwb1NUejcvbGcz?=
 =?utf-8?B?eHQ3ZHcrUlFkT2luYm5pOGZQVnNjcDFVM05tVFZlYURCN292b3dBVlc3MERP?=
 =?utf-8?B?TTZFbTZCK0dPY04vcktFUEJnK1IyVkQ2YWdkUk5kS2tHK2xiZXIrUDQzMnVm?=
 =?utf-8?B?VVJpdktvZFRkUGE1Mm9rUnRVY29rUkx5OGxjeXV4eGYwZEIrYW5mbnU2Zk53?=
 =?utf-8?B?bUJHc0VaVWNWVW5uQXgwVEExRFV5NjhIaDJES3FjT0VCRW80VjRiTGlHbXg4?=
 =?utf-8?B?Y01OYUlzcHJJNHFqOHBaZ2Fxd3hkdjZFZFoyYzhUa0tYdkZja29iLzhjcHA5?=
 =?utf-8?B?dWc0NlZmV1NlZXlpQ21IdzEzRDl4YjluSlpxQ1QydkloNHkzU0ZmdWorbk13?=
 =?utf-8?B?V01OdVZOMjFza05ZT1FpQ3lRRHVkYUFOcGRXRVhKZHlMT3k5SUpjTmlSYUhR?=
 =?utf-8?B?YytZNFQ1TFJ6YWpIaWlvdkIvSXVKTy9zSlQ4NFNibFhiVGxTeDR2SFVBU20r?=
 =?utf-8?B?ekRxNkNtYUtmTWduQkhnQ1dCNVhFcnNMbytEUnplZW5JaHMzY01ETFNVUnZP?=
 =?utf-8?B?Y3Rnbk9meWZZcGlPRngxZmp6TnpERXdnNzk1M1hxVmlhQURwbG4vSWU3MEU2?=
 =?utf-8?B?N0h0aGJCSUZmeXQ5Q1dFMFdMSmtDZEVMaUhEZGlvOWNiNm1yOERCNzdwaHRi?=
 =?utf-8?B?YkIvQmZWb3hUaDBhaWVJTVhxZW9RWHhQYzZoRXdYSEc5TGxheVNuQ0oxK0c1?=
 =?utf-8?B?V1NSRjJ3ajJUelU1MHdHZzhtKzA2aTgwdWlwekVPYkQwZXFIK0IwSFBRNUVl?=
 =?utf-8?B?Y1hLTithV3N1cGk5U0I2WDJDdEdrakJoVFh5MlIyemY3Q2RvVGhiandFOEI0?=
 =?utf-8?B?MHQ5Yk9NNVZ2RGVqK3l4Zm5XcHd3NEE1MTh5VDlDS3ZhSmxya3N6amI1aGxN?=
 =?utf-8?B?RVdWbm9qcGY0T2VhcGtUa0Y2VGdZaG0zZEIrRmd5SGo0eDhFVmhLQ0Z3ZmpW?=
 =?utf-8?B?NzFyM3FqTXA3bTB0Z1Q4cHpTK2ROZ3BlWllOR3ZsN21qbmR3SVhhS2NUOSt4?=
 =?utf-8?B?UTFZM0R2ZndFSFBXbVRNUEVuL3pPZkRQWkd5Y3d2bjRDNFprcDIyV2VXc3VE?=
 =?utf-8?B?OUx2WXBiNkwyWXRGVkVEVFpJcU5TOVZ6MHBaTG9lQ3Ric256SEdhS0NYVGM0?=
 =?utf-8?B?OUNrQUtSdnBEbnRKQm4xbmNxaGVsaHc1U2tHbUh2NjlCOFdRVThNWW9VNWs5?=
 =?utf-8?B?MmZVdWJvQUJUc0Nkc3Urb0RWSGhiZ3lMU0hoRUtYeEtpbWR2QTFVS3FSN1M5?=
 =?utf-8?B?L0FoM2lqZThmMVd6aDJhVU1vdUFYRUZ6dEE0NFdwY2hFNk80a3ZmaEQ4SWhz?=
 =?utf-8?B?NUx1d0tSSi9CNUJOenZNWEN4UXBiUEREL1FYL1J3bXZVNVBkTi9jam5uUGpN?=
 =?utf-8?B?d2xOOTA1cHhmTG1Ud04vL2IwVWdVYWU5OEpnSkxIWFNNb2hnSDVtVFl2Y2gy?=
 =?utf-8?B?czR3aXhSZVF2TTNyT29lcGJTY0djRjJZYjZyUUsxZUhTQTk4blJkazVwWHBp?=
 =?utf-8?B?K0FXa0VxTm9PL1ZxeDd1dE9uYWRDMDJZWVE0RHFKT2VmdjVXdEVNZzVVZWc4?=
 =?utf-8?B?NU8yeGpnRjJ0dFZaVm5UV2RUU1l5ZEJxdE8xLy9teXhhblZ4cU4vaVlJM3dW?=
 =?utf-8?B?ZjNMcXpqc1RpSDRHK3V3b0h3SzQxVlU0Snh1cXY1Mkx1Si9NNGVEaHkydUVY?=
 =?utf-8?B?NFlUZ0twK2E4cFpza203TW9FTFdWZDF1WHdqWTd6dWM4TE05ZDEyRFdwQUdk?=
 =?utf-8?B?M3V4c091ek5WZzQ5bFZGUUdkbmZESjFYRERLMlBHTW5oYmwwR0lPZ2ZMSEpw?=
 =?utf-8?B?TzVhQ3g4RHRsQUZXU2JpYlQzQ1Z0Wm9nNWlxbnhGb3BuOUdtUkxqK3U1NUYz?=
 =?utf-8?Q?yztM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681b2373-b059-47dd-dbe1-08d9b4b7d416
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 10:46:28.3386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkInyfSj+mVYGMOtNLOtraKgFZmasLiYNpmhLyhVGSvxFE5Xe8AGovB77X+IlGvB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1657
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/1/2021 4:08 PM, Yu, Lang wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, December 1, 2021 5:47 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: add support to SMU debug option
>>
>>
>>
>> On 12/1/2021 2:54 PM, Lang Yu wrote:
>>> To maintain system error state when SMU errors occurred, which will
>>> aid in debugging SMU firmware issues, add SMU debug option support.
>>>
>>> It can be enabled or disabled via amdgpu_smu_debug debugfs file. When
>>> enabled, it makes SMU errors fatal.
>>> It is disabled by default.
>>>
>>> == Command Guide ==
>>>
>>> 1, enable SMU debug option
>>>
>>>    # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>>>
>>> 2, disable SMU debug option
>>>
>>>    # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>>>
>>> v3:
>>>    - Use debugfs_create_bool().(Christian)
>>>    - Put variable into smu_context struct.
>>>    - Don't resend command when timeout.
>>>
>>> v2:
>>>    - Resend command when timeout.(Lijo)
>>>    - Use debugfs file instead of module parameter.
>>>
>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        | 3 +++
>>>    drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            | 5 +++++
>>>    drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 ++
>>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             | 8 +++++++-
>>>    4 files changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 164d6a9e9fbb..86cd888c7822 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct amdgpu_device
>> *adev)
>>>    	if (!debugfs_initialized())
>>>    		return 0;
>>>
>>> +	debugfs_create_bool("amdgpu_smu_debug", 0600, root,
>>> +				  &adev->smu.smu_debug_mode);
>>> +
>>>    	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>>    				  &fops_ib_preempt);
>>>    	if (IS_ERR(ent)) {
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> index f738f7dc20c9..50dbf5594a9d 100644
>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> @@ -569,6 +569,11 @@ struct smu_context
>>>    	struct smu_user_dpm_profile user_dpm_profile;
>>>
>>>    	struct stb_context stb_context;
>>> +	/*
>>> +	 * When enabled, it makes SMU errors fatal.
>>> +	 * (0 = disabled (default), 1 = enabled)
>>> +	 */
>>> +	bool smu_debug_mode;
>>>    };
>>>
>>>    struct i2c_adapter;
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> index 6e781cee8bb6..d3797a2d6451 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> @@ -1919,6 +1919,8 @@ static int aldebaran_mode2_reset(struct
>> smu_context *smu)
>>>    out:
>>>    	mutex_unlock(&smu->message_lock);
>>>
>>> +	BUG_ON(unlikely(smu->smu_debug_mode) && ret);
>>> +
>> This hunk can be skipped while submitting. If this fails, GPU reset will fail and
>> amdgpu won't continue.
> 
> Ok, we don't handle such cases.
> 
>>
>>>    	return ret;
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> index 048ca1673863..9be005eb4241 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> @@ -349,15 +349,21 @@ int smu_cmn_send_smc_msg_with_param(struct
>> smu_context *smu,
>>>    		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>>>    		goto Out;
>>>    	}
>>> +
>>>    	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>>>    	reg = __smu_cmn_poll_stat(smu);
>>>    	res = __smu_cmn_reg2errno(smu, reg);
>>> -	if (res != 0)
>>> +	if (res != 0) {
>>>    		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>>> +		goto Out;
>>
>> Next step is reading smu parameter register which is harmless as reading
>> response register and it's not clear on read. This goto also may be skipped.
> 
> I just think that does some extra work. We don’t want to read response register.
> This goto makes error handling more clear.
> 

This change affects non-debug mode also. If things are normal, error 
handling is supposed to be done by the caller based on the FW response 
and/or return parameter value, if there is any. smu_debug_mode shouldn't 
change that.

Thanks,
Lijo

> Regards,
> Lang
> 
>> Thanks,
>> Lijo
>>
>>> +	}
>>>    	if (read_arg)
>>>    		smu_cmn_read_arg(smu, read_arg);
>>>    Out:
>>>    	mutex_unlock(&smu->message_lock);
>>> +
>>> +	BUG_ON(unlikely(smu->smu_debug_mode) && res);
>>> +
>>>    	return res;
>>>    }
>>>
>>>
