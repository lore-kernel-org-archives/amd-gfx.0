Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F2CEB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 12:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A7D10E42C;
	Wed,  9 Aug 2023 12:28:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB9210E42B
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 12:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAk0Zpq3Eubv/0WMBc+vQb8bSGhr83YIHJSoqyvCep79wCIccSOwx5ZBcoMJu1IhVh1ImhOlql1BojO05xbFSITj61KTzMu66irUj9GJGL0yNsa/AJDDmI/c8PG2VC9L5qkRDH1xxk/ZcWhpWTONSYZO5fWZuGwmQ4qsB5jQMtloJhxkwXiQVvgTcHYIlyrBP5wKxsL2lXV7VXyTpUr4e+pyGvke2vsFfh6d0BT5PUONHuC6+fVzOxZW/QDx9nr/Kv4K1LrdQSYWhe65DwcnE19utYWSUdffDhOn+szSmbV+k30rVtX2WMctwJphptQnVtil9bUeLyw0Rbi0XK/qQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx4lH/aq/1yk/1VL4vaklzbH9HPsSJRkznbtJvn3vtI=;
 b=aiE89ttniMDyXkoOGAYdOkbhx/wBppCnVbhshazEjbGyd0vch3xnljnVrTpev1YLN/CtDU2EFnAm22XnNgvcLiX2VPm54n0Htf5cH7i4DwrBDuaF6cOcvC64JZCqD4qNHmPrGxL53MvhJ9OKVMYEgBHWz+/ieIPyg/Y/aaxTgi+aeWZuPSnpA3YpIJ4AUqvtvrsW2d/CPRvd0HFKAmRJgSUJQq4cC1gbKQpkPUUX0mwbCDgMdblSayhWV5RH3qhGyXoKCqGNCRpT97M/BBTWn9/CaQIhrowAyE3ejBb5CX0v0Gm+3u2Ta23GfiGMRc2swJ08/R0YQHb0D076nENJEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx4lH/aq/1yk/1VL4vaklzbH9HPsSJRkznbtJvn3vtI=;
 b=5ZfBEDs7CbHAgrY7DAXBevGULPT8vZdrBPyG0cIeW6Zu3n8mU9ZbckNruCJVgVUvyJGwZ5OqZwY+vS8Jkzab5LfK2ZlSTGN+4vLMdavWCA+WjA/YWgsOKDzr/xXFrH4R9zzJsZMLG4EJMW5PRIduTnboViOrXV58vJagEXXWAvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10)
 by CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 12:28:32 +0000
Received: from SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::a1d2:8170:526c:490d]) by SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::a1d2:8170:526c:490d%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 12:28:32 +0000
Message-ID: <d98258e6-ae06-f353-0fc8-a2add9cfb1e4@amd.com>
Date: Wed, 9 Aug 2023 17:58:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] drm/amd/pm: disallow the fan setting if there is no
 fan on smu 13.0.0
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Kenneth Feng <kenneth.feng@amd.com>
References: <20230809101235.285114-1-kenneth.feng@amd.com>
 <CADnq5_Ot96o8RdopafMVOT6jZKgfkuxTOT4CVQJ6k8aBVPNBSw@mail.gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_Ot96o8RdopafMVOT6jZKgfkuxTOT4CVQJ6k8aBVPNBSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::13) To SN6PR12MB4621.namprd12.prod.outlook.com
 (2603:10b6:805:e4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB4621:EE_|CH2PR12MB4102:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d48fc2-6a6c-4e95-4b55-08db98d4246f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHMioKR9l3uULHmKqMECtRZRWSt2Hj6eYHwbPmGLVdkUKah1lrJOC6KtACcGdumlVJuEeQjVbTfwo9bMxlFWzJ9DoogfyHP6fP3EmDy23L7alCV3JvcouHfTdRdmuHWPInIvaLzprtL3tjmZQdLntZ65mzMxlTHeawPeMXpsNRx7/pU9514v2HSo6dPnX/sPQn17vGRKLtmtzIomnOe5snONRGc7Jn5BM2UgyOTi37171Zoxz/Aw0qWnUxZ036gb/PJ02y/4V3eJk2sjPaAm9V+C8FtMRyzThAB/6Ilub+IxtBPpjD721p6SrHXc4+033rshr+5GpaJhfa/k8xi3dlnMDhTd8ZEbLGrpKEfKfNAa5Mer6eDZFJa6buAm+CA55D71RsWY/IW4m9dVTTsoNjiR6VpxdrcyQ0dZ91TMLtD+p7l9mBObyWgYa6CZ1kwaaVc1n3O2+XGoodPwFbruZ6t+9ck67LCwsVnBlMnVMRt2k7xTn3B3CfuGUhI4g4sxmAx9rzrNuidrarkMJolP/XKlOAVsK5B34wpBZarDxTuhJtMAdHlIGmjOJzs/eIMswwj2b90fH2xuJkcdWzeDbb+/zJ7BcR9YsN0feu1j2w43sbERrSW0qNAh4jev7O9AtaNBHDAeBhVMaKvydJXvjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4621.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(39860400002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(31686004)(83380400001)(478600001)(2616005)(6512007)(53546011)(26005)(6506007)(8936002)(66476007)(66946007)(66556008)(41300700001)(316002)(8676002)(31696002)(4326008)(2906002)(6636002)(6486002)(6666004)(36756003)(38100700002)(110136005)(86362001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXBFN2h0V1h3RTR5V0ZNQmFPNHk5ZzdZSGFHUGtSdUExdEIzOTlEV0NuZDF6?=
 =?utf-8?B?Uk14YVUzTEZiM1drdTRHVWljU3VQbnEvWlhFYjF5cGlEb1d0OTVBZ09GQ3h2?=
 =?utf-8?B?S3BBblg2WnJLSWd1ZFNya01ib21ZaTNZUDA5Um1RK0dKQll5dGZwRUMvejJ2?=
 =?utf-8?B?eTdJSERScXdiTzFrQ08wMmcrZ0x0clhRcisrNUc3ekNuck9CZFRjRUtZWWZz?=
 =?utf-8?B?VU5KYlJmd01ZY25DaG4vK1dBdlQvcWhLWFl5d25HZUlGN29nbHZhUC8vQXc4?=
 =?utf-8?B?aXhVdVFtSHZWcVdrb3RyYlNHU2hUUnFHcGVpVXNVV0RVdXFyUFU2WE9VL0k4?=
 =?utf-8?B?cDliLzRoQUNrbTRQMEliMmJ2VWlWV3FLT3ZXK012YXdoOGFpbnA2T3Vkb0sx?=
 =?utf-8?B?Y2lZb3FoZm43TmdJTWxvbzhsT0FYSk5ab0JqbVZWM3ZMODNkeEtyZjNXRXg1?=
 =?utf-8?B?QTFkb3U3NXgxUFZyamNpczVINVE4R05ZSmVMZ0Vtcnc2NUJ6K2VIZkJOSm5J?=
 =?utf-8?B?T2IrcHFUVHV5STdWTjdsZ0hBNFRyOTV3SlNGWGJGbkxYZk9QSUl3MVZOV2hK?=
 =?utf-8?B?SkFEK0pnZkJQZnpaU0NpUEVDbHpiYkIvcmxHUzEzSy83Wi9JQXJ2SVlCbFhh?=
 =?utf-8?B?Q0ljTXV6VHJPaHhLcnBsUHR2T0JJMnJkVkJyM3BIYkFSeTd1NWNJN01pd1hj?=
 =?utf-8?B?Z09DYXphd2VaWXArTzlPVXdBOXF0eWl1VkpISDR6VmRyQ0w4THVmaDkvWmcz?=
 =?utf-8?B?bng3dFBwaDZaUVFBNVJ2eFAvWkxsQVhYSzB3TUNFMXc3dzFWcTBKTE9wTUg3?=
 =?utf-8?B?YjhvKzI1S3cvdE1WUGJrczk4THBhZTVYeE1xMWVkclluV21XVDkyOHNOckw3?=
 =?utf-8?B?U2tEeGV4UmJsMUdOL2FNbVhtMnlMclF2eWZHQlVzMWtqUjdhR0dSanNwZXJw?=
 =?utf-8?B?ZXRuMklMVFY4NlhraUlySEhRcVZsdDhoamc2OTZydDg4RHp3cWxXQ0dudXF3?=
 =?utf-8?B?WFhmNDZvcTg4emFTY3ZIb3kvYm5GVFNkUjF3MnlOVE13d01yR2lVSzhGUDZU?=
 =?utf-8?B?UythbG5qcHc0QytVV1hJcGZaZGNqQ0dFa0tFd2d3ZFFpK2tVb1k4VnRoZ1pI?=
 =?utf-8?B?a1NJakVlWjR3endCcEFzcmFrRmtvN053VXBYOUpuc1FRaXF6RUtvNU1TQnNq?=
 =?utf-8?B?NThrOHF4WlBHcDJIZlE3akhaM0w4WUZpMC81TlhpYU9GU2ZaRGNDeE9LM0Jn?=
 =?utf-8?B?ejMvZ1l3L3ZSNW43MGhTZldObEt5ejUycTJEbmZMcEtlRXRzRFNwd0JBcU1P?=
 =?utf-8?B?VmRTR0JhdmhYNzdnWnpNc0MzdVFjb291M3Mxb1l5V0tJdzE5dmdJS3Bldysx?=
 =?utf-8?B?Mzhxb001dkVuNDArZ2VVRE5JVFo2TWJvUFNnWlQ3VUJUamFvcjFpbEE0TU4x?=
 =?utf-8?B?bWwzNGd4YzVSY2VzS09WektrM0ZyNjhxSEJPWWl5SHBPclV5VmdPdnFCQlVP?=
 =?utf-8?B?VEZEWVl0ZjZ5YVE1UHJodkZwRzE3YXFsdTlIUHc4RE41QjJ2MTRUY3BGZUVr?=
 =?utf-8?B?b1VFQ3ZaaUZZVy9Fdm90TmNmNFdZUm91bk9xSE1FOTVGckkrbXdtZHlEcFRl?=
 =?utf-8?B?aGNJUmVVU01IQ1hXUEJUb2pBaFNHcjBkb0lNcFd0NWJjZytPNTZUcG8zdFdC?=
 =?utf-8?B?ZnJpN21CWit0WkxIaWhVcCtaZ0c2N3ZqVndxbHNiSUF6eXhRUVRaOUx1QmRQ?=
 =?utf-8?B?NDlRMVZ4aFJQWFF2c1VNaUh4NG5ueGpjTnlGaGduQ0hWYjJxK2Rhb0dMQW5m?=
 =?utf-8?B?a05TTG8ySVhUdllqQ2VCaWRaNlpRZ1BweUh4bkN0am9pNmxCYUloMDlHRldN?=
 =?utf-8?B?eGlVZmYvajJxd1RUVmd0S2gzZVJ6Qy85MHUrNHVEYmdMWDRCZC9MSEZaMm9q?=
 =?utf-8?B?bElwOTNEL01aLzVJQ0RzbzVwRmNvbTNBNGJOUUJRT2JkMEQ0WlZSNnVvdE02?=
 =?utf-8?B?cGUxS0lCaTNJelg2QnMwdjRmaEVOWmxOaWt4bHdYdzFYYmtRTDdJNkxjUXVV?=
 =?utf-8?B?UG9vc0Qzd2I5czdRQUxaa3FoblM5SmVIS0FqMXJlZXlSNFFFZVZBTEJSZUpL?=
 =?utf-8?Q?eExn/KbNv9b7XM4qA1Tt91zb4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d48fc2-6a6c-4e95-4b55-08db98d4246f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 12:28:31.8772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cAISz4H3hf6ESDRga9Ex1HNRPckWGXi82c8FZ10zj0mwM4ITlV/d280FPVGmYMn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102
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
Cc: maisam.arif@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/9/2023 5:50 PM, Alex Deucher wrote:
> On Wed, Aug 9, 2023 at 6:12 AM Kenneth Feng <kenneth.feng@amd.com> wrote:
>>
>> drm/amd/pm: disallow the fan setting if there is no fan on smu 13.0.0
>> V2: depend on pm.no_fan to check
>>
>> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> 
> You can still read the fan speed though right?  Don't we want to just
> not expose the ability to manually set the fan speed?

If PMFW is not controlling fan, there is no guarantee that the cooling 
solution (any other external one) is using GPU's fan controller itself. 
In that way, reading the speed from controller doesn't make sense.

Thanks,
Lijo

> 
> Alex
> 
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> index fddcd834bcec..0fb6be11a0cc 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> @@ -331,6 +331,7 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
>>          struct smu_13_0_0_powerplay_table *powerplay_table =
>>                  table_context->power_play_table;
>>          struct smu_baco_context *smu_baco = &smu->smu_baco;
>> +       PPTable_t *pptable = smu->smu_table.driver_pptable;
>>   #if 0
>>          PPTable_t *pptable = smu->smu_table.driver_pptable;
>>          const OverDriveLimits_t * const overdrive_upperlimits =
>> @@ -371,6 +372,9 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
>>          table_context->thermal_controller_type =
>>                  powerplay_table->thermal_controller_type;
>>
>> +       smu->adev->pm.no_fan =
>> +               !(pptable->SkuTable.FeaturesToRun[0] & (1 << FEATURE_FAN_CONTROL_BIT));
>> +
>>          return 0;
>>   }
>>
>> --
>> 2.34.1
>>
