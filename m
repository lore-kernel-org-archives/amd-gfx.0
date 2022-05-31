Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA36C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 13:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA666112AD3;
	Tue, 31 May 2022 13:24:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96B4112AD3
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 13:24:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGdcF1bSLj+d6QsmgUEI7ls02SOx9tE/I5nEowsU/aMCLIQmcLsXWXFXNWh5D5TT/b2dwEgvuHgxhihjpvy3BKwVZV0oS3JJ3XCz5MNT4tHe9KIy+RRajbW+YeXSFWKAN4Vr8xBa2lZwdC/S48CcSqoNnIHHOhN2mBjv2fmNhq3Xi+VOBY97ZwaA6bE8t1tCtOLT06jNcjGPuZJNmewSoElci9MKOQSNOFVnFBesVbSo5zFkTM/X0Bo0lMCMKnEJf9gppru6/0JSg+J68qruDpiYcImsvxahitgNDWL5Xpg9xbKsvfF7lOE2ab5sFxnE9dO21gi9cieyK3NwO1y8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ij6owFMrkYRt5TKso+oGOBkHPsweTdTcSKsIQctSEpo=;
 b=nn0hjt6JtTgP8fAwtB45hCWYPAeeQtAAmJHF+FDDhyIDwzjlaPqBjcq1NBjUf6slql9C5xU8HzkYfwsAOGB9PpikTt22TpgKKuUQbAVCx3swTjodw+Upaf1odzb6PDK51YpD8+CuC9KmTzCB5lrtOPL+Dj2ABcV+3ko/FIYXMBN0hvUWEDwQ7cvDolz8bFuXqmBMbv3o9U36PobQXHh/mnjyPoRNQmav8AfYRSpX8iAlNG2OMOEUcTerMv/tP2UY+u8vqLsCMBlQX5Rip954LSQSNwe3MgW0xdk6cUKY8OyiEEQwf8E5m5Q6o4eaYaQnTaLblRC8lS2lS4GAysrCTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ij6owFMrkYRt5TKso+oGOBkHPsweTdTcSKsIQctSEpo=;
 b=rzvBXKKVRDrm1qZobdY5EcIgfHsmcIMhnJygM2zNbDLvsXCOupqtCP9CRRiq8I7v/i+Yae+f7xuk0phRcrhaTklLgVggZ4bnGXe9HNOeL7UP1UBATE2/I9DBLHncA1VvA6zHnEis8pzAFXnpsqDI5HcXfYnFRvtCj5sfPDNfMnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 13:24:49 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 13:24:49 +0000
Content-Type: multipart/alternative;
 boundary="------------MGPEglkxdSo4gc5ENXeEngzO"
Message-ID: <17147b89-4c56-fdab-3be6-0bfccbbb3464@amd.com>
Date: Tue, 31 May 2022 15:24:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] drm/amdgpu: save the reset dump register value for
 devcoredump
Content-Language: en-US
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220526094839.36709-1-Amaranath.Somalapuram@amd.com>
 <483cf4d0-ef9d-ea0c-e0ea-8c006051ba55@amd.com>
 <aeb838ef-ce57-510c-d364-f2b57b1af435@amd.com>
 <MW4PR12MB566785B08BAAFE3386ECD8F9F2DC9@MW4PR12MB5667.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <MW4PR12MB566785B08BAAFE3386ECD8F9F2DC9@MW4PR12MB5667.namprd12.prod.outlook.com>
X-ClientProxiedBy: AM6P193CA0060.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::37) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e22193e7-f46e-4b88-b714-08da4308f00e
X-MS-TrafficTypeDiagnostic: PH0PR12MB5417:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5417992E9120C5B6C1D0C98A83DC9@PH0PR12MB5417.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mr+5LyQ0x5lc/B6lLztR21UXmmyMRcozanONUsTVbzD0hUwkLkjShYjtfAbED5NZvoeWktNDqSv8I74vi8ocBSBa0CtehrPNFqSmReKC44DpvkBG8GA2bFhGKZWiZwr1J3E/HGQebak+iVNYqNKBKwFBsDwhg/MFeWzdo/E7YfYdBx4eyIkq+j0bCpukg/3Jr4z6vznbIESTf7nWC4DSD9g6BtX7A1JMDQdTlZlhl6CzFX7gFldONS9TgavVVm1wjQh+brFo/OBOwFUSored3NCTUqHUV2ngzVxTaztw+DKuXKESw2//vcmHD57xdSZNqX2cI8mNx+s3rrWjVFmtY65EqLWZaXJCNJwXDAEoed8qSt3LjTUfDT6aNGVtFykp1tSw+JiKDla3dpmZlafhBlm64JPirQtj4u74ZG8gtPXttm1iSkvq3xOe9qAcpREEJxT/IUWMJOYkOCuPAFZP9xHY0kSklhjj0tuwBDA/Vf0zr+TofSU8eLzysN5HR1E704wyOGzorkh0uVs09VBC2wsbPYt9NCR+E3wY/15ECqSATqWNFDx/G0euQJLYd6w/1RqIAAldU+/Q9/oWNhyqOdz6EfSz41Lb409Dbdv+gkgJOJGoCAZE/BNgtwKEg4qEPdVFuXCpHpYJloa3zDMe/tpLhI15n2A8tk2RTJNtzcYCrFRwRxzlpBm+6FNwmpIYgvCWSGQW9JHir+JVym6Yevidpa1F1quZHF72yF9pAS7lUqpZ5Bb6QFH9NQBFHvyr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(53546011)(110136005)(6512007)(186003)(6506007)(33964004)(508600001)(6486002)(31686004)(36756003)(316002)(83380400001)(8676002)(4326008)(66476007)(66556008)(8936002)(2906002)(5660300002)(38100700002)(2616005)(31696002)(86362001)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlFGMVdGWEU1MjdtUjRZNlQ1MU9mVmNIdWg0Mk42Zi85SmpnR0FadTJ4NVpo?=
 =?utf-8?B?S1pBWDRXT0FEdWFQWCtZb0VYQjJGVS9aMlh4cEtNdnYxZWR5TFhabVgwYkdV?=
 =?utf-8?B?aVJZbnpkZFlZQ25reVdJT1Q5OVdkdXc1TjBjQ2E1Q25sQ21GU0hSQm80L1o5?=
 =?utf-8?B?TTlGMU1jbS9qUllzR1Z2a0phL2dQRTRhaTJVd1loVmpzVGRtVEFwUmpxdElk?=
 =?utf-8?B?VUZSS2UzQmVkRWcrTFZVNUJScFI2UjcxRmZrSFlEK3JjbDVuZDFUaWtSVEIz?=
 =?utf-8?B?aGNrNFpMcXY0amVyVTJsd1FLOStETE9ZWUpWL0dvZVNvQkZOdDdBdkMyRTJu?=
 =?utf-8?B?M1Y2aFRiRGw0WXJtYmZRclN2MmRYOTlBNDhKVGR2RjJ1OHRSeGd3Z1JuRkZU?=
 =?utf-8?B?eEkzQlZuclExNWwwZDhtM3E4eWR3R05zV3N4R2JROXk4NjYyZE9RNkQwbG1u?=
 =?utf-8?B?Vlo1OFozdVA5WEsvSlZ4Z01yZ2cxOHZaWklZR25rakM3S2xmRnVEN0drM0dh?=
 =?utf-8?B?UFZCRWV1TTdxUDBGSXlzWVBjOW5BcXRjVXRMRjhjNHgwTHMra0xOOWFVUDZP?=
 =?utf-8?B?dFlzT290cXJEMHd1cVZKTjlOZGlpWTBWbWtFakdidlRVZTJFWExidUs3SGlQ?=
 =?utf-8?B?NkQ5S0JqbmsvU0o5Rk5MZ1E5STRldmo2bHZRVnNQYnRnRkFqaTNrVTBGcmRl?=
 =?utf-8?B?UHMxajBlSmtFRkNMQ0FnM0pQdHI0L2RWSFVGc2lBQzYybCtwU1JZdjZUSEZS?=
 =?utf-8?B?NmRsYWFtK25mNVRNdEVsei9ndE9xa2UrY0duOTJCNk5ja2NwTUk2K2NidzA2?=
 =?utf-8?B?dzd6eThQK0x2aUFqZDJNWE9qQWcvbzk4K2JrY25XNC9yaEhWb0hKZXFzOUVY?=
 =?utf-8?B?UUd3bE1rcGNPVkpEQ2hyclRWK2w2YndFWFR6Zk5lK3N4Z0RFNjFOMW4yZDJu?=
 =?utf-8?B?K3ZVWjE4blhDRlp4OVNOaGR5SFg1OEFCZGJwM1k5Z04zYWdwY2tFNjF3QjNX?=
 =?utf-8?B?aVNISnZXWGpDdzErU3VnM1IyT2xlVG92L21vaEpQL1FudTBKYVhZeG90bjdD?=
 =?utf-8?B?cmZtQ0JxWThnMEZnU2RsTnI1VVFrWlYwOTV4N1FBN0tUbkJTSFBGN202ZWlm?=
 =?utf-8?B?R0RhRnVYNVRsdG5TbHVyQXRHdW9GbC9xbURvOUE5ZHZSRXd4VWdWakNieDZP?=
 =?utf-8?B?OFVYZmNyZlVwSzdLOExvTTAvT001MTdlOHQxc3VCenQzOHJ3QW9uajBJenFp?=
 =?utf-8?B?YlpkQTMwM0Jrb3hlLzRYR2Z6YVFld0lWYkhvZTlhOUpMWkgvdVR2aHE2K1M5?=
 =?utf-8?B?S0RROHFIdkJMcnRDZndCK0VkeEY5ZExKV3lZc2kxeTNnY1JFWWJLVmJkMjY1?=
 =?utf-8?B?QUxlRERQS0FXaVdkK20wYjBhSTBqb0wyblpaMW9wd3NOZ3VpT0RBUjc5clUw?=
 =?utf-8?B?RGtIQ1oxS2NGZWdTWDNFcWlsMzhCRTdLYytVRENXQWxRU2FiWWw0a0xpcFNa?=
 =?utf-8?B?TjBlVXBzNms4VisvU2hpcXBNV3hyQXUzZjF0VjB0ZitBMUpNcGY5aWlCRUVB?=
 =?utf-8?B?NDhPRzZSUXVBMllLelVWMmtobTdUeVhFaWRkT3NLMys4bERNL0RxdkJpSkJG?=
 =?utf-8?B?YU5meEtWWDRUbDhuNlRHZ1VNcDBROGxnQ2ZaNnNaUWlxcTR1aTNFNkwyQXkw?=
 =?utf-8?B?Y0FIdlplbWNoaU5nWlRpUFFFRktOblhlMHNxZS9Cd0hJZ0tjR0I3VExXOS9l?=
 =?utf-8?B?NE9JRzhnR1RQTmE1UU16d1dsVWxsUDg0aDR4a0dKZG4zV0dHVlRjRktWN0dw?=
 =?utf-8?B?Tk91Q3lIVVlLZ0RwYTBFYkhrZWx2Vm4vVmMwS0JTbkdTN0VMUzkrMHc4NXdL?=
 =?utf-8?B?K012T2NjY0U3NnBVU0xpS1VYYm0wZEFvZWZkNTJWMmJoMk9pVjV5dkhLcStp?=
 =?utf-8?B?MWZJTEZMY2srZmtZRzAxL3FUanVLcVF6WTl6VXlpdmxSdENFeDc4NWFkUG8w?=
 =?utf-8?B?TVAwMTNMNWJFMEFITHJrUml5Q1BnbE00Rmx1UVh1OG4zcWxiL2R6WE8rMmxU?=
 =?utf-8?B?ckFSdXlUZVc0dHBwMUlPdGxzc2tSNUxnRzg3VkdUTmJHN0lZSGprQkhrMlFx?=
 =?utf-8?B?NVJEaEFMdnhzalp2KzlDL1MyVlFCR0F1K1lZY2JKcFB4R0ZBTVEycUE4ZVdj?=
 =?utf-8?B?NjEwMU1CQnYzb2VVdzMvejlyRzZCYkZ0eGx1Y1RNeDRIRTJKZi9wRGVuMUlz?=
 =?utf-8?B?MnRFREhkY1ROQ3FDNDRHbHBkMVg3TStKbHl0MkIrK3RobDNmSk16ek94N1dj?=
 =?utf-8?B?UTA0ZEt5cWJxaCtjaWR1c2wxaEw1S3NJUWxhMUtZTElsbVI4QnpnVDQwdll3?=
 =?utf-8?Q?zfY14Mm72CM+2+KIlhDBMbU9fwVK1UipaQd/8dcZXfoDM?=
X-MS-Exchange-AntiSpam-MessageData-1: 7LGfxoLpFNu9cg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22193e7-f46e-4b88-b714-08da4308f00e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 13:24:49.7016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7MY3Uc3kS4RlcNErWrSwb8rHQNnEk0JJrRwFpO7S8hPqZ1h2CplLJdaMKEzR+s0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------MGPEglkxdSo4gc5ENXeEngzO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I strongly recommend installing coding style setting for your favorite 
editor.

Those should be available for pretty much every more widely used code 
editor.

Regards,
Christian.

Am 31.05.22 um 15:17 schrieb Sharma, Shashank:
>
> It’s not correct even in the snapshot 😃.
>
> The **a**dev->reset_dump line should start just below the open brace 
> in the line above “dumps*(*adev->reset”.
>
> Check the Linux kernel coding guidelines for extending the line below 
> the open brace.
>
> Regards
>
> Shashank
>
> *From:* Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>
> *Sent:* Tuesday, May 31, 2022 3:09 PM
> *To:* Sharma, Shashank <Shashank.Sharma@amd.com>; Somalapuram, 
> Amaranath <Amaranath.Somalapuram@amd.com>; amd-gfx@lists.freedesktop.org
> *Cc:* Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>
> *Subject:* Re: [PATCH v2 1/2] drm/amdgpu: save the reset dump register 
> value for devcoredump
>
> On 5/26/2022 3:24 PM, Sharma, Shashank wrote:
>
>     Hey Amar,
>
>     On 5/26/2022 11:48 AM, Somalapuram Amaranath wrote:
>
>         Allocate memory for register value and use the same values for
>         devcoredump.
>         v1 -> V2: Change krealloc_array() to kmalloc_array()
>
>         Signed-off-by: Somalapuram Amaranath
>         <Amaranath.Somalapuram@amd.com>
>         <mailto:Amaranath.Somalapuram@amd.com>
>         ---
>           drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 +
>           drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 +++++++
>           drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 6 +++---
>           3 files changed, 11 insertions(+), 3 deletions(-)
>
>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>         b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>         index 76df583663c7..c79d9992b113 100644
>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>         @@ -1042,6 +1042,7 @@ struct amdgpu_device {
>                 /* reset dump register */
>               uint32_t *reset_dump_reg_list;
>         +    uint32_t            *reset_dump_reg_value;
>               int                             num_regs;
>                 struct amdgpu_reset_domain    *reset_domain;
>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>         index eedb12f6b8a3..f3ac7912c29c 100644
>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>         @@ -1709,17 +1709,24 @@ static ssize_t
>         amdgpu_reset_dump_register_list_write(struct file *f,
>                   i++;
>               } while (len < size);
>           +    new = kmalloc_array(i, sizeof(uint32_t), GFP_KERNEL);
>         +    if (!new) {
>         +        ret = -ENOMEM;
>         +        goto error_free;
>         +    }
>               ret = down_write_killable(&adev->reset_domain->sem);
>               if (ret)
>                   goto error_free;
>                 swap(adev->reset_dump_reg_list, tmp);
>         +    swap(adev->reset_dump_reg_value, new);
>               adev->num_regs = i;
>               up_write(&adev->reset_domain->sem);
>               ret = size;
>             error_free:
>               kfree(tmp);
>         +    kfree(new);
>               return ret;
>           }
>           diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>         index 4daa0e893965..866b4980a6fa 100644
>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>         @@ -4720,15 +4720,15 @@ int
>         amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>             static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>           {
>         -    uint32_t reg_value;
>               int i;
>         lockdep_assert_held(&adev->reset_domain->sem);
>               dump_stack();
>                 for (i = 0; i < adev->num_regs; i++) {
>         -        reg_value = RREG32(adev->reset_dump_reg_list[i]);
>         - trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i],
>         reg_value);
>         +        adev->reset_dump_reg_value[i] =
>         RREG32(adev->reset_dump_reg_list[i]);
>         + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i],
>         +                adev->reset_dump_reg_value[i]);
>
> Alignment is showing spaces in email. But its 2 tabs in code.
>
>
> Regards,
> S.Amarnath
>
>     Please fix the alignment with the line above, after that, please
>     feel free to use:
>     Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
>     <mailto:shashank.sharma@amd.com>
>
>     - Shashank
>
>               }
>                 return 0;
>

--------------MGPEglkxdSo4gc5ENXeEngzO
Content-Type: multipart/related;
 boundary="------------qwDkcH01KdwiM4tbb080E1xQ"

--------------qwDkcH01KdwiM4tbb080E1xQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    I strongly recommend installing coding style setting for your
    favorite editor.<br>
    <br>
    Those should be available for pretty much every more widely used
    code editor.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 31.05.22 um 15:17 schrieb Sharma,
      Shashank:<br>
    </div>
    <blockquote type="cite" cite="mid:MW4PR12MB566785B08BAAFE3386ECD8F9F2DC9@MW4PR12MB5667.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal">It’s not correct even in the snapshot <span style="font-family:&quot;Segoe UI Emoji&quot;,sans-serif">
            😃</span>. <o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal"><img style="width:7.375in;height:2.3958in" id="Picture_x0020_1" src="cid:part1.xCh6yMBB.WoMIM016@amd.com" class="" width="708" height="230"><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">The *<b>a</b>*dev-&gt;reset_dump line
          should start just below the open brace in the line above
          “dumps*(*adev-&gt;reset”.
          <o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Check the Linux kernel coding guidelines
          for extending the line below the open brace.
          <o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Regards<o:p></o:p></p>
        <p class="MsoNormal">Shashank<o:p></o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Somalapuram, Amaranath
              <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com">&lt;Amaranath.Somalapuram@amd.com&gt;</a>
              <br>
              <b>Sent:</b> Tuesday, May 31, 2022 3:09 PM<br>
              <b>To:</b> Sharma, Shashank
              <a class="moz-txt-link-rfc2396E" href="mailto:Shashank.Sharma@amd.com">&lt;Shashank.Sharma@amd.com&gt;</a>; Somalapuram, Amaranath
              <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com">&lt;Amaranath.Somalapuram@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
              <b>Cc:</b> Koenig, Christian
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
              <b>Subject:</b> Re: [PATCH v2 1/2] drm/amdgpu: save the
              reset dump register value for devcoredump<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p><o:p>&nbsp;</o:p></p>
        <div>
          <p class="MsoNormal">On 5/26/2022 3:24 PM, Sharma, Shashank
            wrote:<o:p></o:p></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="MsoNormal">Hey Amar, <br>
            <br>
            On 5/26/2022 11:48 AM, Somalapuram Amaranath wrote: <br>
            <br>
            <o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal">Allocate memory for register value and
              use the same values for devcoredump.
              <br>
              v1 -&gt; V2: Change krealloc_array() to kmalloc_array() <br>
              <br>
              Signed-off-by: Somalapuram Amaranath <a href="mailto:Amaranath.Somalapuram@amd.com" moz-do-not-send="true">
                &lt;Amaranath.Somalapuram@amd.com&gt;</a> <br>
              --- <br>
              &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 + <br>
              &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 +++++++
              <br>
              &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; | 6 +++--- <br>
              &nbsp; 3 files changed, 11 insertions(+), 3 deletions(-) <br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
              <br>
              index 76df583663c7..c79d9992b113 100644 <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
              @@ -1042,6 +1042,7 @@ struct amdgpu_device { <br>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* reset dump register */ <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              *reset_dump_reg_list; <br>
              +&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *reset_dump_reg_value; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_regs; <br>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_domain&nbsp;&nbsp;&nbsp; *reset_domain; <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
              <br>
              index eedb12f6b8a3..f3ac7912c29c 100644 <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
              @@ -1709,17 +1709,24 @@ static ssize_t
              amdgpu_reset_dump_register_list_write(struct file *f,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i++; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (len &lt; size); <br>
              &nbsp; +&nbsp;&nbsp;&nbsp; new = kmalloc_array(i, sizeof(uint32_t),
              GFP_KERNEL); <br>
              +&nbsp;&nbsp;&nbsp; if (!new) { <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = -ENOMEM; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free; <br>
              +&nbsp;&nbsp;&nbsp; } <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
              down_write_killable(&amp;adev-&gt;reset_domain-&gt;sem); <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free; <br>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swap(adev-&gt;reset_dump_reg_list, tmp); <br>
              +&nbsp;&nbsp;&nbsp; swap(adev-&gt;reset_dump_reg_value, new); <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;num_regs = i; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_write(&amp;adev-&gt;reset_domain-&gt;sem); <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = size; <br>
              &nbsp; &nbsp; error_free: <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(tmp); <br>
              +&nbsp;&nbsp;&nbsp; kfree(new); <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret; <br>
              &nbsp; } <br>
              &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
              <br>
              index 4daa0e893965..866b4980a6fa 100644 <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
              @@ -4720,15 +4720,15 @@ int
              amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
              <br>
              &nbsp; &nbsp; static int amdgpu_reset_reg_dumps(struct amdgpu_device
              *adev) <br>
              &nbsp; { <br>
              -&nbsp;&nbsp;&nbsp; uint32_t reg_value; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i; <br>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              lockdep_assert_held(&amp;adev-&gt;reset_domain-&gt;sem); <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dump_stack(); <br>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;num_regs; i++) { <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =
              RREG32(adev-&gt;reset_dump_reg_list[i]); <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              trace_amdgpu_reset_reg_dumps(adev-&gt;reset_dump_reg_list[i],
              reg_value); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_dump_reg_value[i] =
              RREG32(adev-&gt;reset_dump_reg_list[i]); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              trace_amdgpu_reset_reg_dumps(adev-&gt;reset_dump_reg_list[i],
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_dump_reg_value[i]); <o:p></o:p></p>
          </blockquote>
        </blockquote>
        <p>Alignment is showing spaces in email. But its 2 tabs in code.<o:p></o:p></p>
        <p class="MsoNormal"><br>
          Regards,<br>
          S.Amarnath <o:p></o:p></p>
        <p><o:p>&nbsp;</o:p></p>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="MsoNormal">Please fix the alignment with the line
            above, after that, please feel free to use:
            <br>
            Reviewed-by: Shashank Sharma <a href="mailto:shashank.sharma@amd.com" moz-do-not-send="true">&lt;shashank.sharma@amd.com&gt;</a>
            <br>
            <br>
            - Shashank <br>
            <br>
            <o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; <o:p></o:p></p>
          </blockquote>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>
--------------qwDkcH01KdwiM4tbb080E1xQ
Content-Type: image/png; name="image001.png"
Content-Disposition: inline; filename="image001.png"
Content-Id: <part1.xCh6yMBB.WoMIM016@amd.com>
Content-Transfer-Encoding: base64

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

--------------qwDkcH01KdwiM4tbb080E1xQ--

--------------MGPEglkxdSo4gc5ENXeEngzO--
