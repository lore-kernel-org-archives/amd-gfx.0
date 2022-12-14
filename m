Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B555C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 23:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D7A10E4C8;
	Wed, 14 Dec 2022 23:33:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D4110E4C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 23:33:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkUSxrmsQ35qWXvr3DV74yXrYCqld3qc7c0RT/gs7kpieu5TaERSGM2QVnLSTSDeFpZH0XgHkIENc3QOq71+aexYqb881hRcI7n+vMIEukd9+/jG4ck8CjqNiVse/5+1Cozlu0Gm/+SAPbTVK7xnjljhlGjKIp48bYLsYDTvPnuELZBEozWH0HdUfVn6FltX5rvC7JRGLOHwe5cgq8NXtbxqKJ8eRClkPTnMPeh2hZLzBVJlJL9mW+xDPTTygIf6QxZwmCxqnA3DV1BVIec8qB6j8CoNDNgGX8p/gViebpNHlU1yCRtlukF3dwEelrTs5g4x2xcLkpiTWJDJnCB/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGyBpY5nTLkQ+PP6iwIRfCoIENpCivCg+1GSGMFZDmI=;
 b=gDxD4lmuX4cdTpfJi6dXyweYrsxVqylxcVGZ7v4pwGQHHH3vMiVwAQB6RTps5ElBJfprsmR8fedUQEw+6AcLkCCJnggRsK04iI0apnhs9o59gfj5fwfx9Q3fylkggRATX6ra1sCk/IWnOiTNheZwU+GbVyDU6Tf0ffx592vnqZdbfBQOMeqilJQiJcjlXxMO1C/SQnELa1NpZKESafUSgyCvBv3VfKO7FJnruOIBTLXAu8eAJEneDPtymAuOURJaFJ/pgyOVohvkc3tvGzytOs14F00onttQVeD99tIRf46MNt8EUUvg4F0PrjaY1+H5mgAOm6Byra0o27YXAVnbZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGyBpY5nTLkQ+PP6iwIRfCoIENpCivCg+1GSGMFZDmI=;
 b=k7ehRxF/IRr1Ars8dotJRov+sQxu3ZRpcnqA6QzWgAzjDUTLn/qXUxXaXle2VpeWqHDEnlakKzckkJ+Euq+e5Gif4ym7YZmArk8xD0YNOGVAyChXJIQ+Wdp3e6BJND3sIT93F+Kd1Aj5ZnX5dtH/bz3kiKQ91gmCvdF+1hHkpnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 23:33:09 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::59a:33d2:5505:3a99]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::59a:33d2:5505:3a99%6]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 23:33:09 +0000
Message-ID: <7a976873-033c-461e-c6de-4df01051ec24@amd.com>
Date: Wed, 14 Dec 2022 16:33:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 05/18] drm/amd/display: Use mdelay to avoid crashes
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
 <20221214202141.1721178-6-aurabindo.pillai@amd.com>
 <CADnq5_PKy2+2-5X+zn4Ax2wp1iuiZ7E-r-bQ3cSHifE34FYfRA@mail.gmail.com>
 <2938ab78-3224-4097-f5d1-f64c354e5eb6@amd.com>
 <CADnq5_P83EkSqXxe29diJZ2eJH8-8v308jLRZxJ4f8e7FnEOmw@mail.gmail.com>
 <12eed813-c250-4b14-7497-afbd6a41cf2b@amd.com>
 <CADnq5_OzcwSgC3a5MwX=tdLNAxuSeQiAjei9b6CYq84rhA6ncQ@mail.gmail.com>
 <fb472bf8-0478-0acb-a730-19802277dfdc@amd.com>
 <CADnq5_Pz=JDUaGW3HE17sL0rnkOB9KSVKeNc5u5zn-8QNTNPrQ@mail.gmail.com>
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <CADnq5_Pz=JDUaGW3HE17sL0rnkOB9KSVKeNc5u5zn-8QNTNPrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::23) To BYAPR12MB3048.namprd12.prod.outlook.com
 (2603:10b6:a03:ad::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_|SJ0PR12MB5438:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b570d3-f10c-40ab-74e5-08dade2b8f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTjN/T+wd39SQVuQl+AZJ71ZZaMD3TSLzEKG5QLQ//GbYpVYf7P5mHqlMxlY+KASuvkdU2x1tSMoRZuqmcVhFeYtlnMWQ5aSx03iANjzYyE8jTqjc/VJJegQbDnC/24vRIWHEI6DZRCW9lQedYudjI48jwcA6NTIoHrysBxCeqsU8wqX87eCCZtjUoU/VHJoEAe32xHBuVqe1LHPzs/ccxYxeWK8GZlkS5x8EnzuniMjzNBVC8oT5V0+PfQpX/cecjC7u+BYFChG/zAigSUhSFJ53c0r73cX8/3/VTd3qRZnnPVD4Nx4KOl+HkNNSG0Cw4vFIpbLxtfvAuKSAcP8P/uc9GfdYy1CgFuO8qCq22IKLzi2vjy6G7r3G/N57JRaCbn1IQ5D0KxzfCK/PVsnU+XJTnPlploHPjYdISARb1Iy+UxuMtOApcxfUpjNQ1ROh8HCtDgV8fT5Dh8JUIkV4Lxbo/F5Q/ZdIlCrhDqFGGnWNbjB30aYSSgJ5pbWUkgsTY+Bhd+VCbmTlQv9w0yi00U5yeEHrj6MSSjaro4pPWYgjfJ5IrgbzNPYv5KTv99fEzd/E8Qjy0UbFBjVHv7ot8Ahd8qJLa+7x5CHOD95pu5yIaT/geip+/Gg21J0xL69TqFFBO02hZo2+Q4xWJpRedmhSff5HY4SvXp+KIVI3iq0wym+Rq0tpTnpuh3Mg+Xn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199015)(4001150100001)(8936002)(5660300002)(2906002)(6916009)(31686004)(6486002)(44832011)(41300700001)(316002)(6506007)(478600001)(53546011)(2616005)(66556008)(66946007)(66476007)(86362001)(31696002)(4326008)(8676002)(38100700002)(36756003)(83380400001)(6512007)(45080400002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2FoUnU4SXF4YlFldEZmWHZJR0FCM1BUaWFJVXRPbWhqbXFPaFBVd2Vkcklx?=
 =?utf-8?B?S3BxQnlYS0NPL2tTcmtXbmdyR0wxUW9hTnl6Z25ZUWpCM0gzZW84SFNxdkVu?=
 =?utf-8?B?cDJReEJXcmdIQnFtSmtBUlZSNUswVjFMeFZoQW9tVGRQTklxODd4b2xPcU9x?=
 =?utf-8?B?VXlyU0JSSDBtRWlFM09MRnlpanBxOXVJVmZUS3JyL0NvUXNGYjVoTWo1NkFz?=
 =?utf-8?B?R0tldGFXWlpKcThKRW9wWm8rTmxsYVhvVk9YU0RJRnJBeU5wS2xnZHM3NjdS?=
 =?utf-8?B?SmxiNWN2YXdLMnlvWURFakJHU1JFRTl2OEY5WEd4dTFkaWJieldaRElqL2Ew?=
 =?utf-8?B?SDJiK1pJb0NhMGxMaHFtTlJaYzlXeEhQcm5RdmdKRDlDeklrdnNsbmJLaGdh?=
 =?utf-8?B?TGVUSEJxMzE2K3BReUo1VUhsa3pESGpkSHVMc09KQWRZcnY1S014MGdTQVlt?=
 =?utf-8?B?cXlKclBoNDFQUVBBOGRzREplUWcweE5GZjJHQWs0MkpOd2tUbFB4YUtPNXFR?=
 =?utf-8?B?dlNSb1NPVjNQSWFGT21ZbFAvL2FLUktqNHNKN1hWMWRBc0pNY2c4ZFUxVXV4?=
 =?utf-8?B?eFoxRHVVMDBBRUZ5empsa1ZoUDdlUGNFSEFDcjhpWHZUZXFENkkwU3Vldk55?=
 =?utf-8?B?V0dzR2R0djlpcEVVNzdCMnNjWnV1c21zYW93YVlhVzMvRzZjWlpGbFlUZlFC?=
 =?utf-8?B?YVJxaWdTajNSM1NVSnBvQjkvRkdxUE9nUXJTb1BabWN4aHhGYnlhV2ZBSDkw?=
 =?utf-8?B?SUordlBDY1ZaR0tFM1JkbUhFR2lrcVZoSDM1Wmh0azgxbDd1THlJc0Z6MmRp?=
 =?utf-8?B?Z0JvWU5RSWdoVWJteG41OXBHN1VqaFNORmhveFpCOURXT1ZFZVp2Y2pzb3lW?=
 =?utf-8?B?NG9IbVdzN1hiNjdsNUoyakNEdkdjUk1Hcjhsa2VVRnNrUWU3aEl1VkhMd0Vj?=
 =?utf-8?B?Qk05NGFCSVJobUwyeUNWVW5pWjh5VWsxYjhHY2tueXN5TGJjWHc2SFpBZ1lP?=
 =?utf-8?B?aVF3UUtwRGZSb053TVlYbDV6b2hBRXhXNjZTZkxlZlIyWVJBS0RSU3FWTWho?=
 =?utf-8?B?RVo3a2VWbC9ZYWgrNXhoWk00a3Uzc2F6UU5jQ1c0bUpWdkVaUm9aOEFhek9J?=
 =?utf-8?B?TVM1SHNXaVZ0cmJiRGJwSDFFMGYva2ZEN04xb2kyMTVuYVE1azduVnJVVlhv?=
 =?utf-8?B?K1BTcHZkcmhjbjBtLytHLzdqUWpsbjRPbHZEcjBJMDFaVTZubURxcFpGWUtW?=
 =?utf-8?B?UUhBTklZTzdFMkxXL1BSY0JtZ3hYcDl5Vnk2c1B4SUNyTjQ3bGFqSjZSRERa?=
 =?utf-8?B?VlpxVm9vcDU0M2g0Qmk0SVhLYk1LZXRNb2xKbGoyT24vSnlEaFJaSVFHQytU?=
 =?utf-8?B?T3dOSTRUaDNaUXU0SGd4ZThOcWxGU0ZRci9ubmJBamxUUWU4bjZZRDBCYmNu?=
 =?utf-8?B?ZWN3b0cyWHhJMEZZNzUwTno1aDB5SE8rVVlqSlpBVXhCdFNxNGtzWUk3UEtG?=
 =?utf-8?B?YjI3SGdaK0l2amxieEZOMkNxcXYvQktQQzFGS3Q1OU90ZU5lcFRHQlpaelBj?=
 =?utf-8?B?VSswZ21sY1phYVl3QnM2NXVnaTRwS2RKdzd2WFp2T0pnTUN4bVAxbENoakpQ?=
 =?utf-8?B?YWFENW5VNklEUENXcnFBU29RYWlKbXlORGJXcnVkMEpTUEdFQk1qRWZMRVk1?=
 =?utf-8?B?UWdFUzh5aGtjRmtBY3lLdG44U2RFcU1zTWdpV3hpSmlOeVNIeS9nN0d6ZWpX?=
 =?utf-8?B?OEJoRFN2a3R2dGx1NWZRYmJPTnM5THN4am5NQUVCZDdydEZTMkNrbmhWNXRv?=
 =?utf-8?B?VGZhSCt3dW9heXhWRFplY3VaYnBEK2pNL0J6bldTU2FEcHQrWHdoT2NWTVlH?=
 =?utf-8?B?bUF6Q1FpL21ZUVp0NVdQQ2lGTFh1WjRlWGlEQWVFL0xIOVo1R3VVRUNXOUo2?=
 =?utf-8?B?d2d3UUhtNlpjTThjbnB3QWxlbmcwT0ZMV1dvQXhFNzFralZ1elVnVkZCOTRO?=
 =?utf-8?B?UWVpL0lUd3RMVHBVT2JIbFQ2blo4eStDQmRwWUxPRURzTzNUWFRIRmpqU0dI?=
 =?utf-8?B?RTRjQWh5cHZha0UrOTBYaXZWU0JaWmlCYXhGaXNQUnNuVGhtT092SWxHOU45?=
 =?utf-8?B?MUlXY0RLODNiMWlPUUsrRmFPUGh3TlVRcHpnTkFQaHdGSnI2UGljZU00a202?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b570d3-f10c-40ab-74e5-08dade2b8f24
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 23:33:09.4556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0KvkH/T6dtnS2465t6aP9+Ga3wfmWJ4Sckaa4pBmm2KiZBTyvSug3HHMfce128lT8TMSr7RPwv/3ZtMFwmYLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5438
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-12-14 16:06, Alex Deucher wrote:
> On Wed, Dec 14, 2022 at 5:56 PM Alex Hung <alex.hung@amd.com> wrote:
>>
>>
>>
>> On 2022-12-14 15:35, Alex Deucher wrote:
>>> On Wed, Dec 14, 2022 at 5:25 PM Alex Hung <alex.hung@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2022-12-14 14:54, Alex Deucher wrote:
>>>>> On Wed, Dec 14, 2022 at 4:50 PM Alex Hung <alex.hung@amd.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2022-12-14 13:48, Alex Deucher wrote:
>>>>>>> On Wed, Dec 14, 2022 at 3:22 PM Aurabindo Pillai
>>>>>>> <aurabindo.pillai@amd.com> wrote:
>>>>>>>>
>>>>>>>> From: Alex Hung <alex.hung@amd.com>
>>>>>>>>
>>>>>>>> [Why]
>>>>>>>> When running IGT kms_bw test with DP monitor, some systems crash from
>>>>>>>> msleep no matter how long or short the time is.
>>>>>>>>
>>>>>>>> [How]
>>>>>>>> To replace msleep with mdelay.
>>>>>>>
>>>>>>> Can you provide a bit more info about the crash?  A lot of platforms
>>>>>>> don't support delay larger than 2-4ms so this change will generate
>>>>>>> errors on ARM and possibly other platforms.
>>>>>>>
>>>>>>> Alex
>>>>>>
>>>>>> The msleep was introduced in eec3303de3378 for non-compliant display
>>>>>> port monitors but IGT's kms_bw test can cause a recent h/w to hang at
>>>>>> msleep(60) when calling "igt_remove_fb" in IGT
>>>>>> (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Figt-gpu-tools%2F-%2Fblob%2Fmaster%2Ftests%2Fkms_bw.c%23L197&amp;data=05%7C01%7Calex.hung%40amd.com%7C81664450189542a7bbc408dade27d0e9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638066559844526853%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=M%2BF4H2qddXItPoUZRVyhlc5N8UF1%2FHIh8PpfT%2BCmdZ4%3D&amp;reserved=0)
>>>>>>
>>>>>> It is possible to workaround this by reversing order of
>>>>>> igt_remove_fb(&buffer[i]), as the following example:
>>>>>>
>>>>>>       igt_create_color_fb with the order buffer[0], buffer[1], buffer[2]
>>>>>>
>>>>>> Hangs:
>>>>>>       igt_remove_fb with the order buffer[0], buffer[1], buffer[2]
>>>>>>
>>>>>> No hangs:
>>>>>>       igt_remove_fb with the reversed order buffer[2], buffer[1], buffer[0]
>>>>>>
>>>>>> However, IGT simply exposes the problem and it makes more sense to stop
>>>>>> the hang from occurring.
>>>>>>
>>>>>> I also tried to remove the msleep completely and it also work, but I
>>>>>> didn't want to break the fix for the original problematic hardware
>>>>>> configuration.
>>>>>
>>>>> Why does sleep vs delay make a difference?  Is there some race that we
>>>>> are not locking against?
>>>>>
>>>>> Alex
>>>>>
>>>>
>>>> That was my original thought but I did not find any previously. I will
>>>> investigate it again.
>>>>
>>>> If mdelay(>4) isn't usable on other platforms, is it an option to use
>>>> mdelay on x86_64 only and keep msleep on other platforms or just remove
>>>> the msleep for other platforms, something like
>>>>
>>>> -                       msleep(60);
>>>> +#ifdef CONFIG_X86_64
>>>> +                       mdelay(60);
>>>> +#endif
>>>
>>> That's pretty ugly.  I'd rather try and resolve the root cause.  How
>>> important is the IGT test?  What does it do?  Is the test itself
>>> correct?
>>>
>>
>> Agreed, and I didn't want to add conditions around the mdelay for the
>> same reason. I will assume this is not an option now.
>>
>> As in the previous comment, IGT can be modified to avoid the crash by
>> reversing the order fb is removed - though I suspect I will receive
>> questions why this is not fixed in kernel.
>>
>> I wanted to fix this in kernel because nothing stops other user-space
>> applications to use the same way to crash kernel, so fixing IGT is the
>> second option.
>>
>> Apparently causing problems on other platforms isn't an option at all so
>> I will try to figure out an non-mdelay solution, and then maybe an IGT
>> solution instead.
>>
> 
> What hangs?  The test or the kernel or the hardware?

The system becomes completely unresponsive - no keyboard, mouse nor 
remote accesses.

> 
> Alex
> 
> 
>>> Alex
>>>
>>>
>>>>
>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>>>>>>>> Signed-off-by: Alex Hung <alex.hung@amd.com>
>>>>>>>> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +-
>>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>>>>>>> index 913a1fe6b3da..e6251ccadb70 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>>>>>>> @@ -1215,7 +1215,7 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
>>>>>>>>                              * After output is idle pattern some sinks need time to recognize the stream
>>>>>>>>                              * has changed or they enter protection state and hang.
>>>>>>>>                              */
>>>>>>>> -                       msleep(60);
>>>>>>>> +                       mdelay(60);
>>>>>>>>                     } else if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP) {
>>>>>>>>                             if (!link->dc->config.edp_no_power_sequencing) {
>>>>>>>>                                     /*
>>>>>>>> --
>>>>>>>> 2.39.0
>>>>>>>>
