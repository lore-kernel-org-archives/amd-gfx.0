Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B939C001B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 21:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5BBE10E045;
	Thu, 10 Aug 2023 21:56:22 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2300310E045
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 21:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qo0JHC8ijnn9Tt/V6AUXPHwVn28msOz2YLR1TWKaJwtJnUze3HvZCyngJo8dwN2eLyaImnh1NWjtLMtTjw+3w6T1xM47BCuO9yPy4WmphoC4OQ+DFvG8e4KNm7kOVOrCEf89+sJNDZumPnoS6k7njB3RF+mRAHhSU2wgbKKIUatcYZP06HrlyWzIOTuYkDTd1XLHYMEdguezOrKi5smnoWLxZYmT77cjS3RyppqCjPwCDrmIt+mlBQON3Ewup01yrW4Pb3VPvqYPkKuCHeNngTa3gPuLJQx7CkzfvZbykLEaJPofOUDq1VOYg+v2LVhjFqum6m9ywvkL8jV4Yfivzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ireiIGNt1pUF5QE7VcWz+htRrB7MI2j5EPBahgbUCaY=;
 b=NlglPRXaVFMoiYnzuxbrCMb5YsYn4Ysyk0EneKPwGxgDHPSE34CvvZgywmI7jDwf0V/Buw7j8rr4JTHwAtpRUQZNWbMvaeZbKecQLplIaBtfJPHDDxyqoXIg8UqSUjmze1VL1Xf0r4b1HlNUxS6uHwgXJbqhdWYfT+OuKLK6tXom0Tvg7QphhbgI50YO+DZusVOg2dg+yPcn3eHPb9o7EoJFkfr3seQmBIFlw0ydah8TKYZQrH95b51ROZzSXbEEYhVg0mdygNVl4FNfuKJa+PDJ+QSGpSbbV4ahQtfSvJrqnN/YPqrrtWEe/jCqMwP6Tov/4l1b7NdTZlMoyf5BAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ireiIGNt1pUF5QE7VcWz+htRrB7MI2j5EPBahgbUCaY=;
 b=qmBKG8fbdagVIrmDTvax4lT++QI+yFFiRGLtIuGLnEmwPIpjJQ5qb14C5ZwoBfflPSX52+S9H7x5dsoxif3i1sFa4zQqeC9VI4JtjPX7QIACOsHWzP70xRv7R9M59n2CLe67WN1KOagc71FCPLlCJJsN5J+fabkinpxbH0aJl2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 21:56:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 21:56:17 +0000
Message-ID: <aa5536b7-822f-3656-443f-46ac415659bb@amd.com>
Date: Thu, 10 Aug 2023 17:56:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: fix address watch clearing bug for gfx v9.4.2
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230810204744.195416-1-jinhuieric.huang@amd.com>
 <0a20bc13-312c-15b2-ea40-33cce76bb8eb@amd.com>
 <CY8PR12MB743551930E66E2C84AC089688513A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <a6f589e3-4023-31eb-6df9-1118f48b39ed@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <a6f589e3-4023-31eb-6df9-1118f48b39ed@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 8887935a-4182-4e20-da31-08db99ec9fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4UfmtVmLWEqMOdE8ptGYRbtcMLOOTN4k6zJB9+k2QXFQrB27BdI7xrsCXlsbmydAq7vVebn6/RuEzjXRDIGO3jHtfWNgzpN67kvJJHVpS69Vcn2VYIWuzCtT/aFHWJaxGumnEQ7UsqGNJQ8ZpPfvshPaecK+qSmhIg9uNbFAFo903n2uRfoHYMpb84+x/Ty/DMo6C8xSsSBHSvGp4JosZ0G0slEdzrrNTWT2Zz+E45dAmINrB3cTskIskRrXieGnai7UvGFf6wdTR20hFWB6FEDtXdUPH1/qdx3bas7hmEnhMvmehyttK3f2ksncMOCy+FaUYGRdXbC8ZQaLNASt+eVCggmfULtxuyipjR+aTy/5il0bmjVLjIeAiDd73IxDoftrI+o8QkWnZxFMw9HT8foKJ8B7AK6QpFPXz/9sPiont3Y+o05jcrVWdjrd2tTtbRmQBsEwr1366yYsLBJ9e3udqRo3IKODQ1OMK8zczZTtlirY20UjEfT31NBMwYgNzxSY6vaphhGC+FAtzEK8wjJlrlI6Gw+gmrFVdv96quxcvi7PKto7SrQzfsDxar1b0H1ZrBMFgbpdgDEqa83DuL8z9b0VAn+uP81zrkiWtOOGLSv/P5lTt25/2jGLNOxiNGfFoZjMgqtMCDYbVMJXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199021)(186006)(1800799006)(31696002)(86362001)(2616005)(2906002)(53546011)(36756003)(6506007)(26005)(8936002)(8676002)(83380400001)(478600001)(6486002)(316002)(41300700001)(36916002)(5660300002)(31686004)(110136005)(44832011)(6666004)(6512007)(66476007)(66556008)(66946007)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elJxWmdRYUJxVHRsNmpNRGxCRGJReGNUaFM3WTFrYXRZNFhoV2dvTXpqZWtv?=
 =?utf-8?B?RzFCb3ZQMWYvRjhTcTg4UmJxeHdreHlQZVBNVGs5cDVLdU5nbDRUei83Q0hh?=
 =?utf-8?B?dkd6N0RBVHExNElJZ29jRWRPczY1ZDhEYi9YQkJEaHgvc0I2RkxjekZZMC9K?=
 =?utf-8?B?Tlg3Z0NURVZ0UjMyRkdhTGV5L0VJc0RKNlBhR0xOMlJLUHhhZzdvK1F6OGpx?=
 =?utf-8?B?S2VJRTcvemZZREd3ZGtKWTJSOXJOTWNOdHZseThKNklHTUdaS2xLODRUOGpC?=
 =?utf-8?B?dVIwMWEzc3RMZkhTQ0RCSHd5WVptTDNkMmlyeXlPOFRFRnVFY3ZPZU83dmtl?=
 =?utf-8?B?YWplNkhzMXNOYlRidjdjWGFqS3ZQajJwdnloK3k5cW0wUXFOWTdsUXphRy9o?=
 =?utf-8?B?Qk1EdXZPbVFmVFhsUjc0c04vQmV3M0laMFp2SHRFcUFwUDZKVmNSeHpsa3RQ?=
 =?utf-8?B?UmYva0hCQUlJYVV2ajVFUDNqVVRBK0Vidm41d1lDOWI2R24yVXNYZ0hPVCsv?=
 =?utf-8?B?ZE45WVFKTnd4Y0ZXK1hGOEwzRi9CU0tmS1psSnVsN0dsSmd2UzRURUVxOVl6?=
 =?utf-8?B?SDZ0cllZWnE5QWRrb3NzZnJQVW5GNE92dUkzWnJ6V2ErKzJHa1FZa3dIZEdq?=
 =?utf-8?B?aXlFQzlCK0FkOWdtSC9sdm5qWU52dVpTWUlEUyt6TkQ2U0k1R3QvNXJLUFd0?=
 =?utf-8?B?U3RTSExUL09JNHlZUHBLdEJKaEcxT0NtNnE1RTNxbzh5QithL3h1bGgyUGR5?=
 =?utf-8?B?bE9ETjVPTEp6aE0wR3EzL3ZHWFpvNjdIemxDak1lSzd5a3NubVNablZ1SXJk?=
 =?utf-8?B?cWRKSnErMWlUNTVob09tOXlpMyt5aUhQd2dtdWdtTFdlanhnMzIvcitySnJL?=
 =?utf-8?B?WU9NMkszQzRPL0xXYnNTQTgrMm56OXdHc29odmg0UFRSVEk0S0U3OHVWTm1H?=
 =?utf-8?B?NE9kaEhaUm94QVhsUjcvNXJEVVFzdTZyQ3FXZGdMYWEyNUt6RWdEM0tkZVdt?=
 =?utf-8?B?d1V6di9OZCtQN0M0WE51QmpudXFFaVdwMi9RcFoyckZxMnMybGxDa2RJc1BM?=
 =?utf-8?B?eWVOZG1lWlEzaVA0a3NSek5ObHAxQkFDMVdaSVpYU2FmVTY0a1Y3aDFGc3l6?=
 =?utf-8?B?VG9XS29JTWlreDI1SHdKUXcrb2ZTTzhiWGNaMVJybFF3VEFRc0lmWjVidTky?=
 =?utf-8?B?cWc0cDdSOHkwQWlxMzdoWjlsWitWYm4rcURxOEtURnM3MGZ1dTdvb2ZXai8v?=
 =?utf-8?B?QmFDaWFPN1JDVWd1UUE1V3h1Z0hIVEl2NkNBQmo3MzJlQTE2WHoxT1h5STVD?=
 =?utf-8?B?MW50Tkc4ZU1VUy9yQnpYcTFuNDdlSWlPNWZSN25zMHhFWnIwdDJGYm5uM2cr?=
 =?utf-8?B?dVV0WU1EUGpPZXdKcVdMQU05eGwyM2NXRTc0SGgzNVRpaEUrR0JuYlA0Z2Z6?=
 =?utf-8?B?NTkrM3U5cnZUZUFwOXQwcVJwOVoxZERsL1B0b0VYaktLRE9wRWl3SG1XcEJF?=
 =?utf-8?B?SjFxM1RqYjN2VDFlU243ZTdzMG1kQXpaK3ZYUFNZdUx1eHh6Ykt4cm15VzI4?=
 =?utf-8?B?eUxZTmJEZGxrbnhnS3VWSndZOHY0VHBNNnJYclp5b2NGM2JKd2dYWFppMjRY?=
 =?utf-8?B?aHlCRk9HUVNXdkdnUDlDZDcyYWVwUFJGa1Y3T0x1T0dlendCZ3N0VVRmV1pL?=
 =?utf-8?B?TFJYVjlyK2VaSHB2WXUrY0J6aXVCS1JXK1ZSWGRHd3lqM2VMbFYwcEl4MWR1?=
 =?utf-8?B?L09QcmVRaXNFYlVNZkNhVjRoVVpsNjJ3akFET1pGZEc0NVdFTzNSb2o4ajV2?=
 =?utf-8?B?UUJPc0NxUzVSemlERlFZMHhFdm9SMU5sNG9XSmVXNzJTTDJFSm15bVp0b2tk?=
 =?utf-8?B?T1pQMW1PNiszVlV2REhCVVowTEh5ZFM2TnN1WnlpenZHYjRlTzk5dk8rQlJR?=
 =?utf-8?B?VnV3TjVwNmFoZCtBU3hEbkFRSk05Y2Iza00zeHhTREZnTDdoRWVFTWtCQnFz?=
 =?utf-8?B?TnVsODY5V0R0cXd2N2NvYitOK251bXV0UFVLYWpQeFV6M05qcE5xeGpPak9m?=
 =?utf-8?B?b3RCdHBCTUNLNVZRZG1ZZTROQitJM2JwbUU4ZTRDa3VuWmxoVnZsWmRLU0ZN?=
 =?utf-8?Q?6SfzN6stfRQBL+n8tGrTMb99l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8887935a-4182-4e20-da31-08db99ec9fbc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 21:56:17.6140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iY3F8ujNz5bd5IqYsQgOA0Ebs7GkiBkbPFT8d/o++n5b+7R5zIifMmBuAzo/QIY3X5NHBEPL2Ug1Ss80sFMZ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
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

I think Jon is suggesting that the UNMAP_QUEUES command should clear the 
address watch registers. Requesting such a change from the the HWS team 
may take a long time.

That said, when was this workaround implemented and reviewed? Did I 
review it as part of Jon's debugger upstreaming patch series? Or did 
this come later? This patch only enables the workaround for v9.4.2.

Regards,
   Felix


On 2023-08-10 17:52, Eric Huang wrote:
> The problem is the queue is suspended before clearing address watch 
> call in KFD, there is not queue preemption and queue resume after 
> clearing call, and the test ends. So there is not chance to send 
> MAP_PROCESS to HWS. At this point FW has nothing to do. We have 
> several test FWs from Tej, none of them works, so I recalled the 
> kernel debug log and found out the problem.
>
> GFX11 has different scheduler, when calling clear address watch, KFD 
> directly sends the MES_MISC_OP_SET_SHADER_DEBUGGER to MES, it doesn't 
> consider if the queue is suspended. So GFX11 doesn't have this issue.
>
> Regards,
> Eric
>
> On 2023-08-10 17:27, Kim, Jonathan wrote:
>> [AMD Official Use Only - General]
>>
>> This is a strange solution because the MEC should set watch controls 
>> as non-valid automatically on queue preemption to avoid this kind of 
>> issue in the first place by design.  MAP_PROCESS on resume will take 
>> whatever the driver requests.
>> GFX11 has no issue with letting the HWS do this.
>>
>> Are we sure we're not working around some HWS bug?
>>
>> Thanks,
>>
>> Jon
>>
>>> -----Original Message-----
>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>> Sent: Thursday, August 10, 2023 5:03 PM
>>> To: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; amd-
>>> gfx@lists.freedesktop.org
>>> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>
>>> Subject: Re: [PATCH] drm/amdkfd: fix address watch clearing bug for 
>>> gfx v9.4.2
>>>
>>> I think amdgpu_amdkfd_gc_9_4_3.c needs a similar fix. But maybe a bit
>>> different because it needs to support multiple XCCs.
>>>
>>> That said, this patch is
>>>
>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>
>>>
>>> On 2023-08-10 16:47, Eric Huang wrote:
>>>> KFD currently relies on MEC FW to clear tcp watch control
>>>> register by sending MAP_PROCESS packet with 0 of field
>>>> tcp_watch_cntl to HWS, but if the queue is suspended, the
>>>> packet will not be sent and the previous value will be
>>>> left on the register, that will affect the following apps.
>>>> So the solution is to clear the register as gfx v9 in KFD.
>>>>
>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 8 +-------
>>>>    1 file changed, 1 insertion(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>> index e2fed6edbdd0..aff08321e976 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>> @@ -163,12 +163,6 @@ static uint32_t
>>> kgd_gfx_aldebaran_set_address_watch(
>>>>      return watch_address_cntl;
>>>>    }
>>>>
>>>> -static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct
>>> amdgpu_device *adev,
>>>> - uint32_t watch_id)
>>>> -{
>>>> -   return 0;
>>>> -}
>>>> -
>>>>    const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>>>>      .program_sh_mem_settings =
>>> kgd_gfx_v9_program_sh_mem_settings,
>>>>      .set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
>>>> @@ -193,7 +187,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>>>>      .set_wave_launch_trap_override =
>>> kgd_aldebaran_set_wave_launch_trap_override,
>>>>      .set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
>>>>      .set_address_watch = kgd_gfx_aldebaran_set_address_watch,
>>>> -   .clear_address_watch = kgd_gfx_aldebaran_clear_address_watch,
>>>> +   .clear_address_watch = kgd_gfx_v9_clear_address_watch,
>>>>      .get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>>>>      .build_grace_period_packet_info =
>>> kgd_gfx_v9_build_grace_period_packet_info,
>>>>      .program_trap_handler_settings =
>>> kgd_gfx_v9_program_trap_handler_settings,
>
