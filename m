Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6EDC3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 20:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189B610E023;
	Tue,  3 Jan 2023 20:09:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB7810E023
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 20:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKdmshMxT0SOSS/4MZGtpBkml58jx4BhkVSbTG2CJo9NoXB1WU+yu4Kl4bcUvlUOKf1wgvUxFZp33GQ4V/Nn4LhdcSN+xKqRtZUR1bjFtQ6MrusmjxrQdntjJMZYyjudnwX3E09jCuSgkbMIrOTxLDnOt7Xty+w3nHNhjXpEuVVv6V3p8YXIUfEDcK3R/ZFPvTJvaqDQpQ6F7VeLQ7daimpTVxwHmAJrxmkZcKQCt4jjGWBe3bzDndgY4RW6BgNnOrJayjN7VkJCliow6MbvXfhoSYRqiC+F78t5SllUnAUukAmE4gpEhblV8axwJTnYqqWEX1aQzv+4G1mVDTvhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvL5RJYxC8Awc7NSep8xPYYQyOrkrbxecolXN5NDfi4=;
 b=EN3H8EVg+LZLMF0Wu6k21CKC9NACGNDC1bHvH+yR7G5e3CKXPiFE14NwFsQ02oyqUyBbDw39Qc+UqAljjffwkZASZGaXPHqmjRMoS9XGv+yAwmqE7JGcOGs1lLhgRI943rdb7cSXkMjREau3Z25WZ/oi2js2RqUInzB0G2DvGbrvPUabF5YQlJgkSNkVN3xttvWizq8toKmCIDeytxqGGE8MGN2MPyPEijpEZOa4xXvQ3G71RxzIzVykckoqSH9bd15vWSXrW9IuzklLuB4fx/GS70r3Ybv1t1SRM61A+DhFeTVe5qkH7QeYXi6AwdWGcryBjoEdSaAVl1H4Ijb/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvL5RJYxC8Awc7NSep8xPYYQyOrkrbxecolXN5NDfi4=;
 b=I6ouIgGIEPlIoUG+nLEHBdGZ2dcsn5P9qha5nMSF7+eUCSfbaP9kI2QPUdJgwhjIZAnXi9iFi0z92ludclkFOgSu7CmFyyqHX9eELQTV7TVu/5IZrvPUIMIT0Pow5Nb+3+lc6O2TZOW+lsBZKxZihTQYwp/Oy4Gffovhq7j8vro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 20:09:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%4]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 20:09:07 +0000
Message-ID: <da02afed-1695-f44f-5ed7-3364a177b8f9@amd.com>
Date: Tue, 3 Jan 2023 15:09:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdkfd: simplify cases
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20221227171020.106726-1-alexander.deucher@amd.com>
 <CADnq5_ORmj8T83Xq08PLoHi-_zN4vZaXWpRw=Z4SXsqVEaZwGg@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CADnq5_ORmj8T83Xq08PLoHi-_zN4vZaXWpRw=Z4SXsqVEaZwGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: 29778c73-e4ad-417a-74ff-08daedc65e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31iT8qaItjBb5/eqDV70riRuzl9mi9VqWbyNIq7wI9TP4hxXAQpE6LrnKDCwy2Fp0h5ZCI1DYFvOMBAjzADyFaHIPzAH2tToYRnyIyZzBzrCbZXu15UQ5aX/u9Y4482TYkYidoT3CjvQGaTAgVMzWLi371NK1FBLu8ia7fQGBoJlSrfsRKztpT0P7mQdoYccFywmzu6Mwp+I0dWelqLKSPeSX1MHH6GxBeiGD0H3DLtRzyEUEh7HbfxE2TkQV09EJh3e15McnodDGI6n6DFoM7V23bLvX4KnzVx8fSdH7lSIE0Kb1kyHK4BLBEV7LgObujJgP1g87EdB4TEB3PqLORoxr0go3TuTm39/O//k73J2mGSBVLbY4lrE0BPZF5ggxl4Wpce82/UevqqSNbLJSXhJrB1BUfLem21dg+EBwNe25qE+N9t0OT/uJHyHlGbf/Vef18jJq6MoWaqG/2eOMf4iiXblAT3AN01+LOx6YLutfbozVu4XW8dghyLux5GzDIIqsdKJHBSLyaGJ+u+2tJ3sQInDuVOJ9QooOJs1gtxeV/kcizwNQMbqOmGNj9jL5Ph2DbvjSVvRl4TtGyVjAagIRqNy/sL0NnfE7j0hPoXo7JkA/2Ces+nwSYRJ8A+Wba330ZWZ5vZRi4kg2T9xLTMpY3eNRBXw+cBj14ZAHYnhoz/0rejEDTRYcUIUwsypoP5ZvRs3Y5P3dr/kUNnD0giLGvrYGAYRyTEZHbkqJxKq5DNgTElWsVFkUPmoUAH3Yshr25kkLAXmevdv9+UdCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(83380400001)(31696002)(86362001)(8936002)(38100700002)(2906002)(4001150100001)(41300700001)(44832011)(5660300002)(53546011)(6506007)(4326008)(186003)(316002)(26005)(6512007)(2616005)(478600001)(8676002)(66476007)(6636002)(66556008)(110136005)(6486002)(66946007)(31686004)(36756003)(22166006)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVc4T1hrVFNHLzhJZmZOL29oNXZkalJVU0VIZlN1dkRoUWY0eG95RWdWOVpx?=
 =?utf-8?B?UUEyUi90RkVlY2xybTJpK2ZoWWpqUXcxcUdCUGhldURtQVJTSk8zY01PVUls?=
 =?utf-8?B?UXh1cUxBY3B6bVJuRVRwOTFRNWlhOEhJdjhRTXc1ZXd2dmRVSDRGaHhsN0NU?=
 =?utf-8?B?TjNNamdOYWhuR25vREs5RDFLeCt1aWVVdk5DMERwdW5hY01QSUJrZlUyY3A0?=
 =?utf-8?B?RFNsL1I5dGxzeHlUYUNUQ2ZNVFNLTkZwZlF3bHlOY2VEaHJaYXYzc1FtWGtx?=
 =?utf-8?B?QVgvNm9VbzFrSHhpcElzOWpSc1lkYnhzWC9aR0FuY3NEcVhRL1JXaEhMU1VE?=
 =?utf-8?B?b1J5dzhUUnVqbjJxK1U4WTRRWWpxUHBzeFJCdFlKTk95MGdSUG1VMTRJM2xR?=
 =?utf-8?B?NXhTUkV5YW93VDFQeERnYm9JcXRUK3B2Zk1iL3pNTExhOEpXYmIvYUljQVVK?=
 =?utf-8?B?SG1wckluTllDUmNYRmVMOU9RRWcrRUg4NWVoVkV3bEhXY1lmdXFaRjZWUWZG?=
 =?utf-8?B?SndwTlJMeDBTWTJPYndFVEc1Zmh0MVNjQVUxSXl4akxDWWdVWmxBMHBHaTRG?=
 =?utf-8?B?L3JHNmtmYWhteGxUcm9TVExYYkNPVHpONHUxR1BQR042anJHQ0tpeXRBYnl0?=
 =?utf-8?B?MnhYdXhBd2ZBVmpRTXkwSkN5ZnBEUmdNc1kvVE44N0lkRS9YT1lLdUhSYXl4?=
 =?utf-8?B?empwOUVNbG5Vb045UzUrNzVvS09lcllDSmI0dzVGVW9ZdDVlNWdha1piTENN?=
 =?utf-8?B?Wlh4RHZBUUsvbHVhL0JOQVFzM3Q2bFVSVDI2c2xuSit3bWM0cytrMXJTanJB?=
 =?utf-8?B?c0pSWEFyK0hHUXBHaEtmUWNwRFlsTW56QzdIeDNhRzRBREZ1L0kwSG1FZEor?=
 =?utf-8?B?UGg4U3IvUDJ5L25uVUp0VkdlaWxvRis0cVhHbmR2UFNMSVFQYUJoZldDS2NE?=
 =?utf-8?B?L2ZpRndQVDI1WDZxb2pNdHMza20wYW9qRU0rcW1Bdyt3c3JJTXNFT2crNUxD?=
 =?utf-8?B?U25FM2Z6aCtRejdudHdTV3E1dGFGdHduOUJmRkF3OXEvTlQ1d0NpOUxRSjIz?=
 =?utf-8?B?dGRmaVJwalRBdGIybDYzdnZ1bCsxcFBHTUxieHlxMUpYV3Q0SnlEVERSbVJ1?=
 =?utf-8?B?anpKTldRUEZuS1hpa1UyQ2RHbEIwQWZzVGVOZGV1N0FGajRkekNHTklzRlV1?=
 =?utf-8?B?Nzd2Rk5OTXE2bGs2WDA4ckxCWDkvQVJUVE5XdFU3dzdtMW5Dc2hoNXhKamkv?=
 =?utf-8?B?K1g1RVZXVnB4UHJwY0pPSTBYZWdUcStBalRrTEhjbU9TSWNjSExKNS9HVjJ2?=
 =?utf-8?B?aUNZbE9kTnllK3ZYRnlNK0lka0hNT2hnc0tLbDhFYmYzd1NqTURmT3ZpSDNH?=
 =?utf-8?B?YTVWamh3UkZ3dUNETUsxbFV2V3VPOTFKZVpxWmdHeTF2RnRkUEVqMXUvSHIv?=
 =?utf-8?B?MkIvUkRkUEVMY3JSZVBtaGROUFBvU1NEWHFWWFR3eVBXRENBaHF3S1BJSEJs?=
 =?utf-8?B?RVFqUmMxalZJZWlMSmk1K1RGRE1wbDg2Y2J0azc5Uzdaa0RQcG9WeDJzT0pU?=
 =?utf-8?B?VUZLWUhQa3dHcDZqWXVEK3FpNnRwTmVzQ3J3TjFsd1pXbU14TmRBc2lsanZU?=
 =?utf-8?B?QTd2TmgxNGN2SUVtZUxyMVhCL1Foa3h4akkzQ3BuM3JEbFNJbHpyYWEzM0Y0?=
 =?utf-8?B?RlhpSjhYaWRSdC8vZERPWFJ0dTJ3cUp5ZW1TcnVKN3dIZkJLQXhCSnBzT0dH?=
 =?utf-8?B?dWpaZWxTdlV3N1VuQnZlc1FUbTV5Z2QxMjhkZnF4Qm4xNzBVVnpONVNsVUxh?=
 =?utf-8?B?Skt6YzdHYmpsVWVCT2dzemJJTWF1WkhwSlRMS1l5cDZKdFlyd0dVaEUvblJ6?=
 =?utf-8?B?SzJET1RHQUxyZUg0MXQwdm4wTTJmUHM5YkRlS2NpQnUwTU01R0FrdDVDQVBv?=
 =?utf-8?B?eHQ1OUdyWHNRb1hwTFBHdTBlRjhhRGM4bU5WR3R0WGo2UDFrbmJRZ1BRN0Jk?=
 =?utf-8?B?aE15ZWpYbld1cGl1MUVIQXVxQnRMckR0ektFK0lIUHNUNFBnMnNBemE5dUlW?=
 =?utf-8?B?YnE2NkRna1NTb3lrcGtYcDlvTTZJUk1sYVkxQkVxeUcyeExQajl3L0F3Tm5y?=
 =?utf-8?Q?9kOXdvsLVsEwUewj5wVo2m7Wn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29778c73-e4ad-417a-74ff-08daedc65e72
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 20:09:07.2401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vMqnfENlA33fbv+/UpgAPEF5M9AQdMx+6mPC7beUtUCE9/jEt42455GngWAWVYjTpTtrs3rn6AK+VrMgUw3hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-12-27 um 12:12 schrieb Alex Deucher:
> On Tue, Dec 27, 2022 at 12:10 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>> A number of of the gfx8 cases where the same.  Clean them
>> up.
> typos here fixed up locally.
>
> Alex
>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 11 -----------
>>   1 file changed, 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index 091fc2bb8ce5..521dfa88aad8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -263,23 +263,12 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>>                          f2g = &gfx_v8_kfd2kgd;
>>                  break;
>>          case CHIP_FIJI:
>> -               gfx_target_version = 80003;
>> -               f2g = &gfx_v8_kfd2kgd;
>> -               break;
>>          case CHIP_POLARIS10:
>>                  gfx_target_version = 80003;
>>                  f2g = &gfx_v8_kfd2kgd;
>>                  break;
>>          case CHIP_POLARIS11:
>> -               gfx_target_version = 80003;
>> -               if (!vf)
>> -                       f2g = &gfx_v8_kfd2kgd;
>> -               break;
>>          case CHIP_POLARIS12:
>> -               gfx_target_version = 80003;
>> -               if (!vf)
>> -                       f2g = &gfx_v8_kfd2kgd;
>> -               break;
>>          case CHIP_VEGAM:
>>                  gfx_target_version = 80003;
>>                  if (!vf)
>> --
>> 2.38.1
>>
