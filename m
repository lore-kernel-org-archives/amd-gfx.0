Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBD4C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 06:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA21110E02C;
	Wed, 27 Apr 2022 06:33:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3333210E02C
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 06:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dT7AxfkMuP11Q9KCyL3+yk/SsTk2qlrL1jDYUkJ5wMP6aqg4TXNfFsGW7B16oDtJDKlucUld3sHutSWVZRY/7n8bNrB2MouByNotIWlhdlz/2xge6jCemLZaMuemJt455zYxNeLZSUsLBNsK9zDDdl6il5czqVi9+FFNg4WM+Rp8WaU6tqKQdJlPAHag9akAyO9bgn/wwJ5wpnoDOMRId9OAM0td7PIbyryes8FNWyX6X0ZmAt9hsVPjM3OF5e3zqx07QB5MnOKWPySyT2GofDS6R1yivOnLBkzpL4aLxGXRRVhYZ4lAfuNWeuZcs5I4Qp2seBD77nYxtRbdYF1jbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbZDsyr0BV16egNET3hY2BzQwdE815qAhcB9xleNIn0=;
 b=YbHGrgdMzLJwglzxUEgeOrRtVikgtc3BALEthClu9BqtNy6JTnztQOvf0KZQcvy12JHhsd7Cwvv6TilM6jeEZU8U1Hc/p6iBu4tgl8uCmqJ4SWg5/x0cHNmAbStnK2KT/jlyihqZ9i+DhEZksVtK+zlunxsrY6H+JM43w4VnwM+uscCrLUAkai2gyBmk11Q8xrXe7WljpQluzRsUbpZHiOi77U14k5AvJ2a8fUmerWs3WGZSOxDupDdhj4KltdG6bJYjKoVWxvcMzPRWcCEffC5L/oM0usItz9ZpbyYkE1xt3K9iX29AsraUsQ+J+fmK4TBxEtns3b+JQIvv3RuHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbZDsyr0BV16egNET3hY2BzQwdE815qAhcB9xleNIn0=;
 b=wRXEjY7Zaya8xQH+UnuVh9ms/4usMy5aIs54CTREMUXQJWboz0aTkP0oMX8vWEUwc00PW8pa2XvSW6jfzFBT1wTPW8xoeZ6E+/mZ6MSYE2sL75m/5tRlvLQ0PlxeNqwJs1X2ffq9kwv+a//2tvz11HgUgrDaV2TGSr/MdMNyjeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 06:33:06 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 06:33:05 +0000
Message-ID: <685cbc01-6acb-a980-7358-b1e815dd0f36@amd.com>
Date: Wed, 27 Apr 2022 12:02:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled during
 s2idle suspend
Content-Language: en-US
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1650869553-28976-1-git-send-email-Prike.Liang@amd.com>
 <1603bd63-71f0-87a6-0d18-339bf43568c4@amd.com>
 <BYAPR12MB3238D716386D4F0E246F2189FBFA9@BYAPR12MB3238.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BYAPR12MB3238D716386D4F0E246F2189FBFA9@BYAPR12MB3238.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::13) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4098b71b-6e61-42ca-b4ed-08da2817c927
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4048B309B30D504DD2B9CFCD97FA9@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lOaRBVqSvIAXm7UUONOa5ZpUEfppqmhBGJGNmo8cHtZYWW4XgdPUX2xNkM0K0UQDtQhAaKgBcrO0przvLm+fo1CGR7VIeBt5XYCerZNnwdfCkEe/LOZkOEC0XNVV+ok6JjJAnzeswNOjg7CtZ4Bj4F7LeyrHp914kGACu+tlPvxYILt7C/KdpCRB0f/+4KwMaBj+uf09kSNsTmnGmf4MOGUuvYLxR7bW+64izi4lChSI3Ic02Am12XXIe4+ROqX5fJ63FSqDOw8Hi2roqNqPvWSSGnWexvA7/aGLIfDznit1HTHtOaA3/kPYxZ2WEZb3fZz/2U0EqNCfhK0ndB00zxA1i7sSWTSnISC681+gcrscLrjgy3fUaWPJvJwh+FysjCVlTY/vlCUYBrob6XKSYNxFrdueJsp3J/uj4l5nvgO3Ko1hSlJJnukmyJ8CTof7TZulUTTI1RLdZHfPLfee0EwHr6SOq5HY7RlrTHKpT4MRnsDV947efIabARoh5TPUfqr4FO5oQi+9H6mypynpm9uI0NAJt9pu+LMM0Vo6gBaepM+wsoOls2FgaSilzEhMgUJLvLrY3xj4MTTgPHCNzCgCQXgaU3K0RIFLpiuRAcosWy3HqyQTilRTs+HliH/l+u2QqMuGRxBjvk4SKBjxn6681iDqg7oKcUcV+a+7vTNeazdG39LKVFnqbX0rJayT7kBUgjnL1flqzhyvl02pWXORfsjs+gHclAG9gZRoRtXLb/9eHUFu18COP9feRWA1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(54906003)(38100700002)(36756003)(5660300002)(15650500001)(316002)(110136005)(2616005)(31686004)(6666004)(4326008)(8676002)(66556008)(66476007)(66946007)(86362001)(186003)(26005)(31696002)(83380400001)(53546011)(508600001)(8936002)(6512007)(6486002)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUFlMWdUUE9UZU9oQjZuaDRrUzhUZVFtK3RJY2laRmhpSThFVjIzejEvZkhU?=
 =?utf-8?B?cjRSZ0hsdGlQVWNxNGtSaHhmbG5ra1R2cDN2eTlEZXZ1bzk4VlBSY2RUZm9y?=
 =?utf-8?B?bGVjdjdCMTFyd05kRUM2Nnl2WWltS2d3WncrWkFtTDhPVU5uWmZrWlBJVGxn?=
 =?utf-8?B?UktuQWlaeTErditHSFJ2WkRBVlNYRnlFbGh4SWI4S2RxSUVCWHhOMlpZbTBX?=
 =?utf-8?B?NXV3TU5tTjFxY3ZOYlhXOTBTK1JKTEVkRkJWWFVKMjF0Q25NenhIQ1dFWHN0?=
 =?utf-8?B?OWgwcWJneWFHczRsZWRLRU5Iem12c1NoNzVxKzVGYmJyMXZpZzhiVWZ5aXdu?=
 =?utf-8?B?T2ZuK00yWGd1cWRrK1o3aWN0UHU5RURQTVdhOC9pYkRTbndkaGdBQ3NTSmV0?=
 =?utf-8?B?cEM4ODg3b2VSbENDVmNxKzlaNHh6S3hoVk9GdHB3dHE3Q21KZkZKUzVWR1Iz?=
 =?utf-8?B?TDZYeHlYNHFIN0g5Sk9iN2x6VXc4anBEQzVFTUErNkdVcklHZGQwU1loMm5N?=
 =?utf-8?B?cUcrNTNmR2dGYU5oTXRDY1A5UnVzN0V0MzFJekpSS1R3TDdtbHI2SzJkVUlV?=
 =?utf-8?B?a2tVc0QvMjJmdm8wNE9JT3c1S2twV1pkNXYvVTlOWnFzTEJOcytZSU5IR3hP?=
 =?utf-8?B?Zkxsemh3MEsvRmFQSURQZ3lUNU1JQkVsMjExdTVJK04yMlZ0WjNXL0lnMnJ2?=
 =?utf-8?B?L3k1OWxLYk9oZFZEY0gzSlhwc1lnZE5aL2ZLU296TWM3QzdITTN2OXZKRGtV?=
 =?utf-8?B?cmNmR2hNc0JHK0d5UVZLeVYrb3FVRUxvZkc2NnpnKzdHSFNQOHdvcGJQWTRz?=
 =?utf-8?B?eW81QW9COFFRZ2lXS1BRUU0xOVRySXRJYnpMN08zWWFsclVMNzVSM0lJanNQ?=
 =?utf-8?B?L0h6NDhZMHZjaTZQYUpLcityMXViYXlGbkFrYTdrY0VxbzJHT2xSdkNONnlj?=
 =?utf-8?B?UFRoYml4aC81cEJTNkoxRWxNb3UrSno0OUhzOVZYRWdJd3FjdUVEa0liOHB6?=
 =?utf-8?B?V00zOCtoRjd3blh5NDlrWVRxblFjWHpwVm5zMk9UUkNlL3VJNklyQXk0eUpX?=
 =?utf-8?B?VjVGaFFuRUZsYUc4cWxDSnErTGphQVlPRzd5bVU3ckt6WHNWWkRYVys5YUh6?=
 =?utf-8?B?TmZISUpUSTZhcU1xY3U0NWoyditvdVZ5YWE3NmxPYmZxaE5MNmNRMzMwbXpE?=
 =?utf-8?B?WjBlbzNINllYSkg1dThWTmtlQUVoL3JicEE5Q04rTHNJeE43UmVuQkpNU1Q2?=
 =?utf-8?B?dHBEd0tkRm5oOTlMN1dHczhHTk5RNjBsRGFjSUJMbFN2SlhSS1BDNkUvUGhN?=
 =?utf-8?B?T2tMb0lvWTJOMURPVHFBb05JQ1ZpRmhWNkhRalNWN3JrVXh0aGtaLy9Tb2lp?=
 =?utf-8?B?THgwK2JsSWp3ZmJTSVlDWmtSYUdkZWtWcmZTRTV6RXcva1QyNUw1S0pEekpT?=
 =?utf-8?B?TmZpMllNZmJnUXRTcDR5V3gzMHNDK0ZwYjNOVjI2OUdxc3VWVU1WL01BMlRz?=
 =?utf-8?B?V3N6Um8zVngyeE9uZDNWMEI0ZTkrdTViNTRhNmNDdjhEMUxQUzBCTllyVDAz?=
 =?utf-8?B?WXBzSHFpeG5YWlJkWEUvU2RoQ2JReVh3bE12SmI3cEt3NlpIQ2ZNU3JTMVJW?=
 =?utf-8?B?QXo0T2hjYXZ1T0Nja0tuWE5wYWFldXBUMEJVd2htbXZMbXdzdE8wWFJuTW52?=
 =?utf-8?B?aUVkQkN5TlJIS3YzQWRJcytxQzltdVFEVFJuaWZ6cGZrcnRRSzBIUFhobmF2?=
 =?utf-8?B?VG12MTFNdyttcTBKdGRNbDJzWm9VanplNXZsV3hTeERIcGV1UG90VWZGL1VD?=
 =?utf-8?B?SjJwbzVyeWZvOHVGTVFoQzVLVGVJZ0FkNHFCNERNSFRITXNKTlR1bUhqRTBS?=
 =?utf-8?B?c2cvdkQ0SkV5dDJISWdzMDdvUkZzZUErM09YVlNKKytRWG5MUjF5UThGZXYz?=
 =?utf-8?B?ZHc2RDU4UXloQmFiV1BPVEE2U2Fqc3ZrdmF0WHhvd0pWcm10STRjcDlSek02?=
 =?utf-8?B?M0N0NHlDMkpDYy9aMHRZSUloa3UwS3lhN3plV3M0a2lnZWRUVlo3UmZraXBv?=
 =?utf-8?B?NFpvVFk2c005QWJBNnJRc0ZEQnlldmk0MHRBMGRvNjhVZy9UUkdlVloxL0Vx?=
 =?utf-8?B?SUJFUHlGWTEzQkwzTWV3K1N2V3B5ZVkzekI2azlQa3hXYU41RXB5TWZUMVBL?=
 =?utf-8?B?VmtpenlUSU42aDhCMDlaYTMwNDgranRsR1J3dVRpM1oxMHJYek5VZmNOUVNi?=
 =?utf-8?B?Vk1QNU8zZUZGWlZncVRtaGVFOXYvUmsyQVhoSDdKUXlSeE85NzFlYldpc003?=
 =?utf-8?B?VzdZQjd2ZmtSWVU2RWZ3V1hZaG40VXVXRk1Qd3RVZGdyMzNtUVVYQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4098b71b-6e61-42ca-b4ed-08da2817c927
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 06:33:05.5215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkx+FBnqe/RYGwx3AwBnsMUhbxiSgnWZRndRzXrugG7ufSAACjZ0S9O/77q1IKKl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/27/2022 9:44 AM, Liang, Prike wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, April 26, 2022 7:19 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled
>> during s2idle suspend
>>
>>
>>
>> On 4/25/2022 12:22 PM, Prike Liang wrote:
>>> Without MMHUB clock gating being enabled then MMHUB will not
>>> disconnect from DF and will result in DF C-state entry can't be
>>> accessed during S2idle suspend, and eventually s0ix entry will be blocked.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> index a455e59f41f4..20946bc7fc93 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -1151,6 +1151,16 @@ static int gmc_v10_0_set_clockgating_state(void
>> *handle,
>>>      int r;
>>>      struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>
>>> +   /*
>>> +    * The issue mmhub can't disconnect from DF with MMHUB clock
>> gating being disabled
>>> +    * is a new problem observed at DF 3.0.3, however with the same
>> suspend sequence not
>>> +    * seen any issue on the DF 3.0.2 series platform.
>>> +    */
>>> +   if (adev->in_s0ix && adev->ip_versions[DF_HWIP][0] > IP_VERSION(3,
>> 0, 2)) {
>>> +           dev_dbg(adev->dev, "keep mmhub clock gating being
>> enabled for s0ix\n");
>>> +           return 0;
>>> +   }
>>> +
>>
>> This only ignores clock gating requests as long as s0ix flag is set. As far as I
>> see, s0ix flag is set to true even during resume and set to false only after
>> resume is completed. Is that intention and is this tested to be working fine? I
>> suggest to keep this specifically for suspend calls.
>>
>> Thanks,
>> Lijo
>>
> It reasonable for also not reenable the clock gating on the s2ilde resume since clock gating
> not disabled on the s2idle suspend. 

Generally, the CG setting registers are not in always-on domain and the 
register settings will be lost once it goes down. Not sure about the 
state of this particular IP rail during S0i3 cycle.

If the CG settings are driver-enabled, we reprogram CG settings during 
resume - amdgpu_device_resume->amdgpu_device_ip_late_init -> 
amdgpu_device_set_cg_state. This logic prevents this. Maybe, it works 
fine during your testing because it's done by FW. If the settings are 
programmed by FW components, usually reprogramming is taken care by FW.

Thanks,
Lijo

Have merged the fix for not blocking s0ix support for some
> upcoming asic and meanwhile still need dig into whether the DF C-state, MMHUB DS or BIOS mmhub power gate request different on GC 10.3.7 introduce this issue and then make a generic solution for such this issue.
> 
>>>      r = adev->mmhub.funcs->set_clockgating(adev, state);
>>>      if (r)
>>>              return r;
>>>
