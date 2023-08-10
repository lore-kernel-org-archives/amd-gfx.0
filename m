Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195F3C04A6A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 17:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80BEF10E5C6;
	Thu, 10 Aug 2023 17:13:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA5D610E5C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 17:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOEFM7jtL2MXnDYH+VwKB2C9/x1JjTnj3/QP4Hab9uJ9/FeI+ZWVCosVn6RUfpGg/IQipl7+qiSTgsj0RAhf07fKhVvS+ha1qo6LKF5gXHTNKdn1vHWbEI+7XGkQl3mXI8Ni7qcl1MvPbPql1fV2iJY7Eu2emDKhzUZr5HC7pCpoGSHZZtPN5uLHCQbOBuiP+KvhF/HAml2TFpiXDbdTswGPoEQGcbdgmBXeNKpA2TGTwQwcnU2yNbXJHQRShbcGUGQH8j1+fm770XiParzWNMBYu4wOVGQvEOBzumwjgGWBXu4GcyduacKJP3RZWMM7eAq6Aehzcf5UJvBLPl4i6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHWb6OzYEzCqyr2/7Yw4I+aRDh8owknniA8bwhKrpgI=;
 b=gTw1b/8MFSVx1RcAhZN+2UrwTQttBGiPo61h/qUTwaNEqJj/OaxApjwnxYRzvtB8aMQiqquiMnkW8NNYFJapmMpPVplD1VATgip/rbxIUjsaDBSfd3oreQ8Qw0Ae/vQGZFz0pl5zX3lFhNn0nj/qLNand6cZN4fPUkTqNX97svmCuync/pGaiuMRTQBWY13Vy0cs9KSChd3w2BM11sEiXsUkG6DqZ0q6UhmcCkd2k3+6+VRe1Uk5PWL1dyaTaYoND6wwHMqO2/EvPp7jlMBejWZJr0dOhUYPGOD4oDy6xgdAfm9PeJcyNyknMB56k1xly/8lAnM67LLm58TdN1rDZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHWb6OzYEzCqyr2/7Yw4I+aRDh8owknniA8bwhKrpgI=;
 b=Vf0NCNIjbhhfBMWdGQNh2Tsjs5+0aI0O4ck4yhS0bx2ikvCDF4G55vczfEcoJ5cjocxeDllAd9JaGY7eEWa8QVA8kzuWZ9Wvd3bhEUnizwBXppwMCPxZPf2HCzKjbmDks+aa8iwAjTqy9vypWKOyi22+fsZJUvNrEM1HVBgrBPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 17:13:49 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::fb96:8b8e:5d70:9363]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::fb96:8b8e:5d70:9363%4]) with mapi id 15.20.6652.028; Thu, 10 Aug 2023
 17:13:49 +0000
Message-ID: <9e2b161c-81a9-da16-7625-784b8460b162@amd.com>
Date: Thu, 10 Aug 2023 22:43:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Keep reset handlers shared
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230810114425.645209-1-lijo.lazar@amd.com>
 <08853e2a-6485-7ab1-bb49-acba97d0020d@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <08853e2a-6485-7ab1-bb49-acba97d0020d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: bde691c5-fe0d-4dab-c6eb-08db99c52974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJudMJuzA6GWu++4IVDwI7LTf7SSUMob1Nrrjc42p7MPcWU6R+IBKNyfUbK5GvnvjhB1vabkX4xNydzuB/2FffelkU0cpb1vH5caySZUHDoW3nsgDd7WCJIpUrrv8P0iBd6kaLXKkJEc0I+ZAAn7JOG6Rwby83nHVzxvDENornsQin0UUjQsyhGXPGLYSRHeklbBPx8mmGWFXenZTHdr0lJDpRehvUddyBlSR65c0Sy0ZziTYvbG4VF1Ut3+Pj6gCOKkpOUTcAN/iph6D/AXWYFKIuymyUu4tYww9B4nhK/5RAa9gPRcCTa4XFLB2SlglkUZ8mFdwtAa4lRZgToBjHnip29agrZ4ZU0B0ZdBMLc2sj8JVWOa7ac7CocR74rBMDh0pIVoI2kP+v7ABlqnNCXpMPMmQTuZ0C8Uy2dKvuJFFXvyVQ2qqdZONtwigUxa5WJV21VvNCHVaMZ3L+jFRc1LTsgf1vHNRdqRRNJTRojTJrfh56b2N0a/ye4QcxyjaFsUU3KmomKLZjmz5wkHKiI06peG2R2P0RLjC5LfsfM46Z+rG9HOC18zzD2ttpPWmJ+OBJKo0Dvv6xT/1Vw60MsFbW+NJwWqmL8Yxiur8+e8d9TbTXobknG+EvKhltHzkYQsRTzdG69vF8Qw6sSw3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(1800799006)(186006)(316002)(6512007)(478600001)(2616005)(31696002)(6666004)(6486002)(5660300002)(66556008)(66946007)(30864003)(86362001)(31686004)(41300700001)(8936002)(8676002)(4326008)(66476007)(83380400001)(2906002)(36756003)(66574015)(6506007)(53546011)(26005)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THdDQlFWWnJGU283Mlp6Ni82Rmp5S1pMUFJrWTV6UmIvREliTi9LYldwcStF?=
 =?utf-8?B?bXkwQjF4L2dzM3lEakNJV3I3YWhoUlJ1NThNQXEvTnJwU0I1d2hIQ3NaaFgw?=
 =?utf-8?B?MGd6ODVJcWRSbk1JUmIyUm0vNGlXRWpNQ2xkV3N3VzcrYUVjWXZaNGVoUVVL?=
 =?utf-8?B?MjRvR3pXSkc4Y24rR21heE9XdTR6VzRxTXRkdCtqejJoSkc0QXJwWE5ZeUQz?=
 =?utf-8?B?NDZsWnJnL0NTbWlmcGRFVGl2a2NMZzJsYkxZZUZKelFwb1lLc3NPUEZLZnlO?=
 =?utf-8?B?bCtSMm5sNzRMZ3ZmLzhERVhoRjhka0JLcmdwQ0hPdUpkV3pNMnphOEUyb2lX?=
 =?utf-8?B?VEFWeHMrMmdEOXh4NjQ1alNHYTFmU0wvQzhzUk9lZzBhaFhMaXREMkVLNUM3?=
 =?utf-8?B?bENYcVhrVzhtRGRZWDFhZThSRGJSMEUxY1lLQUNiMXdrQ3gyWGMvZ0VNS0lW?=
 =?utf-8?B?anNXZlVjRkZjbkxpQ1Fab1d3SXNqZkZTdThQcExHNXJCTTJ1S252VHU3YU94?=
 =?utf-8?B?bnNWdHhTaWcwc21QT1FqWksyZHAxc0xlTzZ6NVZONWFDdjlGU0hGVlBlQUoy?=
 =?utf-8?B?TUQwRldsQTNzS3dqZVFCeVF6QUdKUE9ndDcxd21NdlpHaGorMW0ybTIwdEdn?=
 =?utf-8?B?dFlrbE9oaVM2SHU3L1I0NkIrTks2R3B1bDNWcTV2OHRUak02bkhVcWFsVFNV?=
 =?utf-8?B?cHlSTFgyaEtnZUVNTEs5OEp1UUQvblh5STJzZmlmK25FVVlrUDRDMFA5R1lp?=
 =?utf-8?B?MldnTjNCdXZzb3VjVmFxcWVnd1RkL0t0T3ZnRU1jbEM2d3dIYlFmc0g1S3h3?=
 =?utf-8?B?Q3JlOHpKMEtXeEhKdmM4alpFRVVka1Nlbkk0NnB5WVpTUWVPcXRqejE4d0NL?=
 =?utf-8?B?Mms3RHB5RDl3NDlVMHZsUGlWSXQxU1B5UWhLWXhzODJMNWpYS1FoTFdLQW02?=
 =?utf-8?B?TGltdDNUb295eHBIYzMxa3NpeERzM3Z5SDNaMHNDZ3NESm1uaVFvSGFSanRQ?=
 =?utf-8?B?K2JRRVd2R2ZNM2R2SHcrdjQ2b2xMOFViYUYraFo3dmtENktGdDlBWXdQeCt5?=
 =?utf-8?B?Y3c3U2FacWdYcHZTRENTczNKVHpsd2dXaDltazh4c1RIT3hPYzBjaWF0YzNJ?=
 =?utf-8?B?aElRT20walhuMTRYZnpQSks4WG5aR1RBRXNCMzl6MExTbUhrRW9pcU84OWU4?=
 =?utf-8?B?c0dmMm9nVU56Z09HMGpwMzMydHlIb1NES3FMODVsaFV2NWJ4USs3Nkg1UFlT?=
 =?utf-8?B?TkI1YTY0Z1kzMlhXeFJpSHFrUVpoQ0JzY2hhT0JCWlhEcGUwdDFobHlDZ1Ir?=
 =?utf-8?B?Ny9EL1JPRFRqWFVnNjNsYStJOHRiUzM1QitDVWpqamJDQ3psVExNdTk0Z3hx?=
 =?utf-8?B?SlhuRXlRY2tlS1Q5cFFmanpDWEllNGs0MmR2Nm1SM1RYR3BEMGR6THNLaWpU?=
 =?utf-8?B?d0pwS09BVEl4ZUpPWkRnZ05zdFV2cy84Mk4zN0JPay9ibUhYYXpWMXN6eWlN?=
 =?utf-8?B?VnUxSEFack1vbTVDV2p3SFlRblhrZklQOWpsSjRkSXZPN2o2cmFBamJPVHhC?=
 =?utf-8?B?TUl3ZG5INytTaVoxMUo3NHFkeVJxNVFTUXdQSU4wME0xNkJiU1FBZW83cFd6?=
 =?utf-8?B?T0NWRlYzV29RT3Y5VHJkd2gzYkl3ZFNueGViek4rSWFoLzJkYmdHbHMyY1R5?=
 =?utf-8?B?Z25IeENlaHgzc3VSWk1nZVdmTU9yWE9rVW16TnpxRDlpbFV2UHcvSzU5UGZ4?=
 =?utf-8?B?d2FkWUJMOXZKa3YxbHo0N1RSUDlUcjd2V0JyNkd3a1R4aHlZbWtOQkJGQnNJ?=
 =?utf-8?B?bUQ4T2JlNExQM0hVWTZTM3ZqQm5nQzlnUjBraDVqbXdZb3prTHVRekFmVXRp?=
 =?utf-8?B?cFBBQytaeHZkVCtJUEp4RWRITHVPUGh2aStxOEtEaXZWdzdxY2huTjZhNWRx?=
 =?utf-8?B?aGxPMWwrK3hRRkc2ZzQyamZIcWg1L2tvWGtjRDFkU3FaNEVMRGo3L0h3ZGNG?=
 =?utf-8?B?UG91eUhpUHhDTjJrZEZOV1Z5WVJOT3QzdHlxRW1yQjRTVjJ1NHZIOHhabDdK?=
 =?utf-8?B?Q010N0x4cWl3Wk5NQ2pzZ0xIVE12QkdTeFpQSDVYbVErMHJ3eHVxcFR1TTFR?=
 =?utf-8?Q?kI281sByq2Cyny+wqnbFfXH/k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde691c5-fe0d-4dab-c6eb-08db99c52974
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 17:13:49.0696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRWujZKm4DhS7C8e+XsQ3IH81eZluPEpLSfcwmzpCqf5LXw9Ga6PXcQm51Gu2tY5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/10/2023 8:41 PM, Christian König wrote:
> Am 10.08.23 um 13:44 schrieb Lijo Lazar:
>> Instead of maintaining a list per device, keep the reset handlers common
>> per ASIC family. A pointer to the list of handlers is maintained in
>> reset control.
> 
> Why should this be beneficial?
> There is a global reset handler object for each type of reset for a 
particular ASIC family. Each device has a reset control which holds a 
reference to these handlers.

Earlier, the handler used to be a list object. This creates trouble when 
there are multiple devices of the same ASIC family - the same global 
object gets added to reset control of each device and that corrupts list.

Keeping an array of reset handlers and having the reset control holding 
a reference to the array of handlers makes it simpler.

Thanks,
Lijo

> Christian.
> 
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 19 +++++++++++--------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  8 --------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h   | 16 ++++++++++++----
>>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 20 +++++++++++---------
>>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 19 +++++++++++--------
>>   5 files changed, 45 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c 
>> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>> index 2b97b8a96fb4..82e1c83a7ccc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>> @@ -48,20 +48,19 @@ aldebaran_get_reset_handler(struct 
>> amdgpu_reset_control *reset_ctl,
>>   {
>>       struct amdgpu_reset_handler *handler;
>>       struct amdgpu_device *adev = (struct amdgpu_device 
>> *)reset_ctl->handle;
>> +    int i;
>>       if (reset_context->method != AMD_RESET_METHOD_NONE) {
>>           dev_dbg(adev->dev, "Getting reset handler for method %d\n",
>>               reset_context->method);
>> -        list_for_each_entry(handler, &reset_ctl->reset_handlers,
>> -                     handler_list) {
>> +        for_each_handler(i, handler, reset_ctl) {
>>               if (handler->reset_method == reset_context->method)
>>                   return handler;
>>           }
>>       }
>>       if (aldebaran_is_mode2_default(reset_ctl)) {
>> -        list_for_each_entry(handler, &reset_ctl->reset_handlers,
>> -                     handler_list) {
>> +        for_each_handler(i, handler, reset_ctl)    {
>>               if (handler->reset_method == AMD_RESET_METHOD_MODE2) {
>>                   reset_context->method = AMD_RESET_METHOD_MODE2;
>>                   return handler;
>> @@ -124,9 +123,9 @@ static void aldebaran_async_reset(struct 
>> work_struct *work)
>>       struct amdgpu_reset_control *reset_ctl =
>>           container_of(work, struct amdgpu_reset_control, reset_work);
>>       struct amdgpu_device *adev = (struct amdgpu_device 
>> *)reset_ctl->handle;
>> +    int i;
>> -    list_for_each_entry(handler, &reset_ctl->reset_handlers,
>> -                 handler_list) {
>> +    for_each_handler(i, handler, reset_ctl)    {
>>           if (handler->reset_method == reset_ctl->active_reset) {
>>               dev_dbg(adev->dev, "Resetting device\n");
>>               handler->do_reset(adev);
>> @@ -395,6 +394,11 @@ static struct amdgpu_reset_handler 
>> aldebaran_mode2_handler = {
>>       .do_reset        = aldebaran_mode2_reset,
>>   };
>> +static struct amdgpu_reset_handler
>> +    *aldebaran_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] = {
>> +        &aldebaran_mode2_handler,
>> +    };
>> +
>>   int aldebaran_reset_init(struct amdgpu_device *adev)
>>   {
>>       struct amdgpu_reset_control *reset_ctl;
>> @@ -408,10 +412,9 @@ int aldebaran_reset_init(struct amdgpu_device *adev)
>>       reset_ctl->active_reset = AMD_RESET_METHOD_NONE;
>>       reset_ctl->get_reset_handler = aldebaran_get_reset_handler;
>> -    INIT_LIST_HEAD(&reset_ctl->reset_handlers);
>>       INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
>>       /* Only mode2 is handled through reset control now */
>> -    amdgpu_reset_add_handler(reset_ctl, &aldebaran_mode2_handler);
>> +    reset_ctl->reset_handlers = &aldebaran_rst_handlers;
>>       adev->reset_cntl = reset_ctl;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> index 5fed06ffcc6b..02d874799c16 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> @@ -26,14 +26,6 @@
>>   #include "sienna_cichlid.h"
>>   #include "smu_v13_0_10.h"
>> -int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
>> -                 struct amdgpu_reset_handler *handler)
>> -{
>> -    /* TODO: Check if handler exists? */
>> -    list_add_tail(&handler->handler_list, &reset_ctl->reset_handlers);
>> -    return 0;
>> -}
>> -
>>   int amdgpu_reset_init(struct amdgpu_device *adev)
>>   {
>>       int ret = 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>> index f4a501ff87d9..471d789b33a5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>> @@ -26,6 +26,8 @@
>>   #include "amdgpu.h"
>> +#define AMDGPU_RESET_MAX_HANDLERS 5
>> +
>>   enum AMDGPU_RESET_FLAGS {
>>       AMDGPU_NEED_FULL_RESET = 0,
>> @@ -44,7 +46,6 @@ struct amdgpu_reset_context {
>>   struct amdgpu_reset_handler {
>>       enum amd_reset_method reset_method;
>> -    struct list_head handler_list;
>>       int (*prepare_env)(struct amdgpu_reset_control *reset_ctl,
>>                  struct amdgpu_reset_context *context);
>>       int (*prepare_hwcontext)(struct amdgpu_reset_control *reset_ctl,
>> @@ -63,7 +64,8 @@ struct amdgpu_reset_control {
>>       void *handle;
>>       struct work_struct reset_work;
>>       struct mutex reset_lock;
>> -    struct list_head reset_handlers;
>> +    struct amdgpu_reset_handler *(
>> +        *reset_handlers)[AMDGPU_RESET_MAX_HANDLERS];
>>       atomic_t in_reset;
>>       enum amd_reset_method active_reset;
>>       struct amdgpu_reset_handler *(*get_reset_handler)(
>> @@ -97,8 +99,10 @@ int amdgpu_reset_prepare_hwcontext(struct 
>> amdgpu_device *adev,
>>   int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
>>                      struct amdgpu_reset_context *reset_context);
>> -int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
>> -                 struct amdgpu_reset_handler *handler);
>> +int amdgpu_reset_prepare_env(struct amdgpu_device *adev,
>> +                 struct amdgpu_reset_context *reset_context);
>> +int amdgpu_reset_restore_env(struct amdgpu_device *adev,
>> +                 struct amdgpu_reset_context *reset_context);
>>   struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum 
>> amdgpu_reset_domain_type type,
>>                                    char *wq_name);
>> @@ -126,4 +130,8 @@ void amdgpu_device_lock_reset_domain(struct 
>> amdgpu_reset_domain *reset_domain);
>>   void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain 
>> *reset_domain);
>> +#define for_each_handler(i, handler, reset_ctl)                  \
>> +    for (i = 0; (i < AMDGPU_RESET_MAX_HANDLERS) &&           \
>> +            (handler = (*reset_ctl->reset_handlers)[i]); \
>> +         ++i)
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c 
>> b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> index 8b8086d5c864..07ded70f4df9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> @@ -48,18 +48,17 @@ sienna_cichlid_get_reset_handler(struct 
>> amdgpu_reset_control *reset_ctl,
>>                   struct amdgpu_reset_context *reset_context)
>>   {
>>       struct amdgpu_reset_handler *handler;
>> +    int i;
>>       if (reset_context->method != AMD_RESET_METHOD_NONE) {
>> -        list_for_each_entry(handler, &reset_ctl->reset_handlers,
>> -                     handler_list) {
>> +        for_each_handler(i, handler, reset_ctl)    {
>>               if (handler->reset_method == reset_context->method)
>>                   return handler;
>>           }
>>       }
>>       if (sienna_cichlid_is_mode2_default(reset_ctl)) {
>> -        list_for_each_entry (handler, &reset_ctl->reset_handlers,
>> -                     handler_list) {
>> +        for_each_handler(i, handler, reset_ctl)    {
>>               if (handler->reset_method == AMD_RESET_METHOD_MODE2)
>>                   return handler;
>>           }
>> @@ -120,9 +119,9 @@ static void sienna_cichlid_async_reset(struct 
>> work_struct *work)
>>       struct amdgpu_reset_control *reset_ctl =
>>           container_of(work, struct amdgpu_reset_control, reset_work);
>>       struct amdgpu_device *adev = (struct amdgpu_device 
>> *)reset_ctl->handle;
>> +    int i;
>> -    list_for_each_entry(handler, &reset_ctl->reset_handlers,
>> -                 handler_list) {
>> +    for_each_handler(i, handler, reset_ctl)    {
>>           if (handler->reset_method == reset_ctl->active_reset) {
>>               dev_dbg(adev->dev, "Resetting device\n");
>>               handler->do_reset(adev);
>> @@ -281,6 +280,11 @@ static struct amdgpu_reset_handler 
>> sienna_cichlid_mode2_handler = {
>>       .do_reset        = sienna_cichlid_mode2_reset,
>>   };
>> +static struct amdgpu_reset_handler
>> +    *sienna_cichlid_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] = {
>> +        &sienna_cichlid_mode2_handler,
>> +    };
>> +
>>   int sienna_cichlid_reset_init(struct amdgpu_device *adev)
>>   {
>>       struct amdgpu_reset_control *reset_ctl;
>> @@ -294,11 +298,9 @@ int sienna_cichlid_reset_init(struct 
>> amdgpu_device *adev)
>>       reset_ctl->active_reset = AMD_RESET_METHOD_NONE;
>>       reset_ctl->get_reset_handler = sienna_cichlid_get_reset_handler;
>> -    INIT_LIST_HEAD(&reset_ctl->reset_handlers);
>>       INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
>>       /* Only mode2 is handled through reset control now */
>> -    amdgpu_reset_add_handler(reset_ctl, &sienna_cichlid_mode2_handler);
>> -
>> +    reset_ctl->reset_handlers = &sienna_cichlid_rst_handlers;
>>       adev->reset_cntl = reset_ctl;
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c 
>> b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>> index ae29620b1ea4..04c797d54511 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>> @@ -44,10 +44,10 @@ smu_v13_0_10_get_reset_handler(struct 
>> amdgpu_reset_control *reset_ctl,
>>   {
>>       struct amdgpu_reset_handler *handler;
>>       struct amdgpu_device *adev = (struct amdgpu_device 
>> *)reset_ctl->handle;
>> +    int i;
>>       if (reset_context->method != AMD_RESET_METHOD_NONE) {
>> -        list_for_each_entry(handler, &reset_ctl->reset_handlers,
>> -                     handler_list) {
>> +        for_each_handler(i, handler, reset_ctl) {
>>               if (handler->reset_method == reset_context->method)
>>                   return handler;
>>           }
>> @@ -55,8 +55,7 @@ smu_v13_0_10_get_reset_handler(struct 
>> amdgpu_reset_control *reset_ctl,
>>       if (smu_v13_0_10_is_mode2_default(reset_ctl) &&
>>           amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE2) {
>> -        list_for_each_entry (handler, &reset_ctl->reset_handlers,
>> -                     handler_list) {
>> +        for_each_handler(i, handler, reset_ctl)    {
>>               if (handler->reset_method == AMD_RESET_METHOD_MODE2)
>>                   return handler;
>>           }
>> @@ -119,9 +118,9 @@ static void smu_v13_0_10_async_reset(struct 
>> work_struct *work)
>>       struct amdgpu_reset_control *reset_ctl =
>>           container_of(work, struct amdgpu_reset_control, reset_work);
>>       struct amdgpu_device *adev = (struct amdgpu_device 
>> *)reset_ctl->handle;
>> +    int i;
>> -    list_for_each_entry(handler, &reset_ctl->reset_handlers,
>> -                 handler_list) {
>> +    for_each_handler(i, handler, reset_ctl)    {
>>           if (handler->reset_method == reset_ctl->active_reset) {
>>               dev_dbg(adev->dev, "Resetting device\n");
>>               handler->do_reset(adev);
>> @@ -272,6 +271,11 @@ static struct amdgpu_reset_handler 
>> smu_v13_0_10_mode2_handler = {
>>       .do_reset        = smu_v13_0_10_mode2_reset,
>>   };
>> +static struct amdgpu_reset_handler
>> +    *smu_v13_0_10_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] = {
>> +        &smu_v13_0_10_mode2_handler,
>> +    };
>> +
>>   int smu_v13_0_10_reset_init(struct amdgpu_device *adev)
>>   {
>>       struct amdgpu_reset_control *reset_ctl;
>> @@ -285,10 +289,9 @@ int smu_v13_0_10_reset_init(struct amdgpu_device 
>> *adev)
>>       reset_ctl->active_reset = AMD_RESET_METHOD_NONE;
>>       reset_ctl->get_reset_handler = smu_v13_0_10_get_reset_handler;
>> -    INIT_LIST_HEAD(&reset_ctl->reset_handlers);
>>       INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
>>       /* Only mode2 is handled through reset control now */
>> -    amdgpu_reset_add_handler(reset_ctl, &smu_v13_0_10_mode2_handler);
>> +    reset_ctl->reset_handlers = &smu_v13_0_10_rst_handlers;
>>       adev->reset_cntl = reset_ctl;
> 
