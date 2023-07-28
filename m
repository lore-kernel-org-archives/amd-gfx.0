Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF01C001DC
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 02:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB4F210E1ED;
	Fri, 28 Jul 2023 02:39:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D0010E1ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 02:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TK/8AJkQiymPFYgVd1w0NxH8vd+KBLFjW0CXkdjwl0Z+k0UKxmMB7qB3zbLKL810vNxka2knudj0/utZj1WvCIPvIGByMAUz0eyZLe/Lm5iHBFCcwqgO81v2BOE7xluPnesQIS0k6wq3PkdjQwavmoUhRpKoeaHICP02VIAEoYSrkK8smOB6lN40ikVoFdr6BXau5NCDItzmJfvnRtiwtxPxePKWytw/Z9luUw1PMMgCd34zEu4+AcIc5gwjw8S7pYmuRqx0ai0KtBfJ6OcEByg6bGLsq/gjrZHqXtODyJnUkya188iuCqA4vD9ChzIw2/luINH76FDPcMT8FmU4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAzz62W5j0OQi2ALsBFGzVM2yxRpoTDuBGvvCRkGu1s=;
 b=m4CNXoeK9PwjNAueeI0kaDRM7+dllwaUsI1EkTABk1as2OYlxbniexdBWMUWFLpOfuqNGH8ekBmcF4VIliRxn3L2DMeKiVDj7ZcMywKp3nDt3inj4rrVUYm8F9mz0hH55iQrTa8wcnzG1yUiv2uWZFpw6KHmnTKAC5b/Gvr979+meryP6gUFdDxYaoNii9cy88EMxm3mi7jHV16xNTbgFD7zd0mN3vzdL2ZAPOQw4mkgT6P1loVzXoSMrOWuJjvK0kVHdrYy9+18jx/ZFJU4Eg1+6gj4bF+Q38I/w/3888wxhPVEim/Edc9yy4TkZPXuvhu4FAQi+WnM/HsfM02rsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAzz62W5j0OQi2ALsBFGzVM2yxRpoTDuBGvvCRkGu1s=;
 b=AMe6h3s/TdrCuAb+vwPHVHtCyRHVtZdyhW6AHXV6cs5VayE796tq4XZ003tr+CgY2j38WxSip8i35kxnleRiPOmSyjbfKC8Dv/krXCohMGubw0tpWY2MmhYwrxTrtdLEXUnxuWB+u9y/W/O2gO/ny7ZsfrL+qq3XesmPOpJehx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 02:39:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 02:39:12 +0000
Message-ID: <99aa09fc-4f63-0529-c029-a4f5a8f49bf0@amd.com>
Date: Thu, 27 Jul 2023 21:39:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amd/pm: skip the RLC stop when S0i3 suspend for SMU
 v13.0.4/11
Content-Language: en-US
To: "Huang, Tim" <Tim.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230728010504.532158-1-tim.huang@amd.com>
 <e751765e-9ec2-83e0-90f6-c7d96943dac2@amd.com>
 <BY5PR12MB3873A8ADD1B0CE858527D041F606A@BY5PR12MB3873.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <BY5PR12MB3873A8ADD1B0CE858527D041F606A@BY5PR12MB3873.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:5:190::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8717fe-82b3-4555-0b19-08db8f13d3c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GIre4yR3+J1SJ9Q/fskMVYM26wmbIxo7iBJqHUUZGxiQjKbfAEJ7IeC3eW/c1dnUTVhFoMzTMVTd4+SMuVyzQLzo+dzCVS6KwGzz/GfUR2je7guAr19T7ZlsVtNnSdoXL0e5wh+W67yTmWGRgEDhMcf4BsIeF7SSL0RI587+pf7oiA+TjZNwJYojuMk71uWbU5uyJc1Qr+M8mNmgH0u/xV3oiMv1KEkWV+Bl5jPcwXmhAHh/R5Rt3zyCqNGwh13NN1GWb5xPG/tajZ71pw8hR5XTVW1P2+L9zT6i9BbFeqJm9o04WKtHjs7bvaQRIWHU+YVW7ae2ShbV0Aa2b9HKRwCwcxctAfax5Ij08aoEd4zKJcvBiq6tEidhcSrZLcd422f/PWZKzPS9quDvH0rWO2+vD1X1ZKE3AtrCsFGbhjjtvPALnGOtZbcDL7LLoKRTClUjB8hBgBJnaVI/YF48QHxacHIUq4SNUiGgEdBcrJwe2lutoTZUN/LvnZvBE3Byw0FjENtAmgsMbJGrlWTfvhflQfwx5h0D+QM7jE2GZ0B0q/WAi+BiIUsbBcn+b2yxJF5uS3mYj+wGGf1kYWQUcY1+l8h1qoG/5r+JG4ELG1AEYqFVbi5stCi7g7LeaMl9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(86362001)(31696002)(36756003)(31686004)(2906002)(110136005)(478600001)(54906003)(38100700002)(53546011)(2616005)(186003)(6506007)(41300700001)(44832011)(966005)(8676002)(66946007)(6486002)(6512007)(316002)(66556008)(83380400001)(66476007)(15650500001)(5660300002)(4326008)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTB4a0FaUHRDS0JNZ0hKWXhjLzc3ZkpqRVZUWnBEZUhLRVN2ZUpPcHoxcWM4?=
 =?utf-8?B?NVdtMC9HQ3RuYjJ1N2ttbkxXYkw5ekRHRjYzcUhCQU5PZloyUURrZ0hGSGdv?=
 =?utf-8?B?dFFDS1VYOFRCNkkvODJzdlJ1ZUN5bnFiMC90WVBvUnhEK0tnNjYydVlWSy9k?=
 =?utf-8?B?dGNJcUgwNVZDSHN0UFVmcG5FNTZpUDFQNlpGNGEzZzN0U0ZhZmpud1ZXSjJJ?=
 =?utf-8?B?L0lsbFI3RnptR0N1RGFLcGk3S1NlTkxZKzBzemtSUE92K0g3a0dnSnJOYTdZ?=
 =?utf-8?B?TWwxci9nUGIvRlAxUSs4MGxLUitHMGc5VGkvckNaYzM3Z2VabzR4bFZCR1lO?=
 =?utf-8?B?QnVSMHA4Ynh5UGFhaFFyVE1ubUNqa2ZSU0VUNlhHajhvMFZYSEJ4YTl2MHRQ?=
 =?utf-8?B?OXZsTXR2dHV3YUVHWW9vRXM5S04vY1YyTW1xRVVvLzc4eU90ZGN3dFdDRXYr?=
 =?utf-8?B?OUwzdVJPeXdPT2VUR251aFV0dVVXc1dlaTBmSDhCb1hMY1FVcnhmU2NjeEZk?=
 =?utf-8?B?eTJJbXc4OGsvZ2ZuQkpFTlFLK3VGTXBhaW43UW45ZUVKdWxFdjFCeFdWRU9n?=
 =?utf-8?B?U2FtM0hsR0N2RmJwM0JBcnBwcFMvaDVRYllYdzEzU1lkdDdaR3hEbnRnNzl2?=
 =?utf-8?B?MUNIVGJqUXJESy9yQ2wvaFFCTDZNRXMzUkN0SGtMNmhGc3AvM0RKSXBnWmxM?=
 =?utf-8?B?OWNyQ1pXTDJTVWhhbXk4L0Z3bWVZaUdmRzR3R2hXajNBWDh5MWJjbXNUNkxn?=
 =?utf-8?B?bXJYZkdqUjZoT2ZUZHJzY08wZjFsNDFxcWszQVdXMGpMcUpEczErcnRKdWZa?=
 =?utf-8?B?Y2NpR3BaalAzdFFsTktXRk5HNXdXUCtiQWUxMEhHcGQrbk1Yc09BbTAwQnhu?=
 =?utf-8?B?S1BTQlE2ZHpNb3lLdEpLeTd3b0pFZlE0OXhTZnpmZW1jWHl4UFNuNkRaVTJI?=
 =?utf-8?B?SERremhMSnFMZ2NWTUI1bGVpSVU4YWo5V2RvSG9EZVFoZmx6MDdxa2JWN2gx?=
 =?utf-8?B?dm5oQ2hMajlmZmFQVzJiNW5GYUJpU3R3SisxTG1ObkNEOG53cFV5ZEhReDd5?=
 =?utf-8?B?VStBRE5ieHBOWUxab0FUamdYRzFIYjREL2ErWWc2QlB0K0laRE1ZVWFVUytT?=
 =?utf-8?B?Q1J5bjlId2RHODYrNlFsUWFHSDVZY1UybkQwN212ZSs1NXBlRTFlMG1XQTlG?=
 =?utf-8?B?cUhFdUQ1QXVOaVFVc3dJOGNQTWtOZmQyZ1JXeS9sMDVWL09OdFVSNkZ3dWlQ?=
 =?utf-8?B?VmcrcElPQnBpbk5aY2FCbVNsdzlFTW9DMHp1SkRUL1ErMWNudzljenNmS082?=
 =?utf-8?B?d20yK2VaL2dSd21kNWFldU1PaDVLaVR2VFpMSURqWVduaHZtYy9xeDlXRDhO?=
 =?utf-8?B?OTJNcDdhc1kyYWRGY2FMN2ExZjh6dlBwVHNqWmQvVFhZZFF5Y0s2UkUxZ2tF?=
 =?utf-8?B?Uk91N2x6M01icGR5VEdJd0RGNW1rZU5rM1htckRkNzRVUGdlcEltSXR6aVpz?=
 =?utf-8?B?bXc3TXNCN1FJN28vMkpJTmlTN2plODdVUm5RaU5qSlNxWlJyMm9BRVVCelIz?=
 =?utf-8?B?N3dobW9tZHBGNE91WHN3VExPNXhDU3Jmd2tKaHV6MnJld3BuRldBZTk0Mml6?=
 =?utf-8?B?LytNY0hiMTVQMkpnK2dsZ1RIWVpGdzBpaHZNM3ZUVzQrNVl6aXhCUGozWnl1?=
 =?utf-8?B?a0N3VFd5RnRwVExOZnZ2UGxJQkZ2MDdUT1V0V2RlSk55c1JGTTVMVFMyV01n?=
 =?utf-8?B?bEp5MWtmZnNSckl0RDZzUERDcCtVNDRFT0hJU1g5Ni9MWVUxU0syOTRxL1Nh?=
 =?utf-8?B?R2p5aUwzYWNIblkzbldKclhZbW5ZWnYveXI3bmVjR0Q1R2Q2ODV5d3oyZDI2?=
 =?utf-8?B?MFpraXowMmtzVWNReUdqZlJiMXhqZ0tnb1dkRWVhc2xaVms5RUhNOXRhc091?=
 =?utf-8?B?Qk9iUEdKbDB0Y2dodHdweGZaOXpDeXpDbDZFdDRIdHhlc2g0ZTZHVmNmaEJD?=
 =?utf-8?B?WHc1dkpsdG43S2RoOG8xSTc1bXBYMHlVYXlwc2Z4bFRZQ0J3TE1kRkFhY0Qz?=
 =?utf-8?B?ZXdzbjZBVzRQamJ5L0ZLbld2NUtHVnlzbklibks5MXJ0dlZERmk5Y2wxdWcx?=
 =?utf-8?B?SEd1U296SGplWXo0aEttMXlNVU9vdDltbjFVcmozTTVxbzlPRWE4Vk1LNHNn?=
 =?utf-8?B?Znc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8717fe-82b3-4555-0b19-08db8f13d3c9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 02:39:12.5793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQIkqMV4PoCZFdM/qulIQLNud6Hcu90LxxQuv3Bo29dqEZjVpM0ETS+G0910UcDbc6fKZXGOSywhDkwNZmGcag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/27/23 21:21, Huang, Tim wrote:
> [AMD Official Use Only - General]
> 
> 
> 
> *From:* Limonciello, Mario <Mario.Limonciello@amd.com>
> *Sent:* Friday, July 28, 2023 9:14 AM
> *To:* Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan 
> <Yifan1.Zhang@amd.com>
> *Subject:* Re: [PATCH] drm/amd/pm: skip the RLC stop when S0i3 suspend 
> for SMU v13.0.4/11
> On 7/27/23 20:05, Tim Huang wrote:
>> From: Tim Huang <Tim.Huang@amd.com>
>>
>> For SMU v13.0.4/11, driver does not need to stop RLC for S0i3,
>> the firmwares will handle that properly.
>> Conceptually I'm aligned to this.
>> But, just to confirm, have you already run some testing with this
>> with current GPU F/W, BIOS and either 6.1.y, 6.4.y or ASDN?
> 
>> I checked with this on my side and saw success but I'm fearful
>> that it introduces some of the fence expiration problems we
>> had in the past and I'm just not seeing them for some reason.
> 
> Yes, verified based on current BIOS and latest drm-next kernel and the 
> working FWs as the latest FWs
> may have some new issues.
> For this patch, it is asked by the FW guys, driver should not touch 
> RLC_CNTL in S0i3, let RLC FW to do that. If driver programs RLC_CNTL to 
> halt RLC, RLC cannot go GFXOFF exit sequence.
> 
> The fence expiration should be still there by the delayed GFXOFF , but 
> this patch should be useful to help debug it as it avoids the system 
> hang when the issue happens.

So in that case you think that when the driver programs RLC_CNTL  but 
GFXOFF was delayed sequence was going out of order and it triggered 
system hang.  But now with this patch it will not hang but fences expire.

It makes sense to me.  This patch shouldn't be any "more" harmful then.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

For the delayed GFXOFF issue maybe we should revisit my previous idea 
for flushing GFXOFF requests.  IIRC the most recent version was:

https://patchwork.freedesktop.org/patch/537888/?series=117965&rev=1

> 
> Best Regards,
> Tim
> 
>>
>> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index ce41a8309582..222af2fae745 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -1581,9 +1581,9 @@ static int smu_disable_dpms(struct smu_context *smu)
>>   
>>        /*
>>         * For SMU 13.0.4/11, PMFW will handle the features disablement properly
>> -      * for gpu reset case. Driver involvement is unnecessary.
>> +      * for gpu reset and S0i3 cases. Driver involvement is unnecessary.
>>         */
>> -     if (amdgpu_in_reset(adev)) {
>> +     if (amdgpu_in_reset(adev) || adev->in_s0ix) {
>>                switch (adev->ip_versions[MP1_HWIP][0]) {
>>                case IP_VERSION(13, 0, 4):
>>                case IP_VERSION(13, 0, 11):
> 

