Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F2AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 14:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CA9610C8
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 14:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 59CA9610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3AF56E048;
	Wed, 13 Oct 2021 14:18:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6995E6E0CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 14:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4Ht7PsfzJTVFwWU/WeVcV0BYavYji+SA5cI2ZjXkdswbUDtk3pMGmf5rjTvCBP/YCEUPN0NBmkB4961XZRtIEpN5p6mJ77vxijI0YnEYvtT6+IbBXwdNs58CpF9qdMEnrIidmWDjIur/THONXbnSOdVePOnpz/m4BUErhnWYInUWP9kuKGZLgzpcOB6okSSTCpPY5z1YgDNZYEhFe2bxEifhfXqe6akd+cIhnMGYx1Rd0ByC7qLmwrIHFemni+sUKkWg8I6pOYu3Hv9FjXiyDsb5SF1/IdokFZp4yl/bNO6PRolD0xIpOw9hQuTt4HMJ+zpXCdhYTu0DBEgeiZcvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ENO5hmSOIJla3ruPz692s/xhT+V4WzKACoD/OGpqv8=;
 b=ZWzQSeh2IxFG9AvhpfefdGLOv0YyoFJ2Ls076X0MasPtU76SU2g6j+62QR0h8Lhk+oOhS5oxfzWt1I4E8QyCBq0hdlK9hbfR6M+GZWNNYV5bqam5KyH48QbVYl6uOLheRbvbu/uX8vqcnSEwxXeLRygmOz2IdLHJ5jQU/RaIgGbjnlcpvopBAWUwcIPt94QV/Qh1qCpHQwphBJARuJMZ8cxsvn5b1l51xrlpi1rG7OXWmZsrIj0Dls43pD3vr8yGNNpNwUWYLIp7DFVF8luFihcEY4nMDUJnA6HOuriebGzEeMd0H/TtjoTRLnLcqWazoAEaClcYpNRMvkttxfGfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ENO5hmSOIJla3ruPz692s/xhT+V4WzKACoD/OGpqv8=;
 b=P/O4Op2+4ryk+GR6VgSxV5L3SVBP67EvCQDMhFHitLh97Gef7tV7rmhuupZ+Mt/IqzRG6zOW1J7q2hN+7obplaDIqiBCoRn6mQi3eD6muK7P/CxlR/3uskZDBqDgqF7UBz3ISmhLn5XRKT3znLwDetFtXhbOB4uGzv3FTn2fHlI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Wed, 13 Oct
 2021 14:18:08 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 14:18:07 +0000
Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Luben Tuikov <luben.tuikov@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <Alexander.Deucher@amd.com>
References: <20211013031042.53540-1-luben.tuikov@amd.com>
 <858da53c-7937-3ebf-360d-f20f30f825d9@amd.com>
 <CADnq5_MAoug4Ex=Dq0wudhrVz6TyhgQn8JuvVhqt5MMzXCBMAw@mail.gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <6030db37-dcee-7655-14a3-495c64fd45ff@amd.com>
Date: Wed, 13 Oct 2021 19:47:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CADnq5_MAoug4Ex=Dq0wudhrVz6TyhgQn8JuvVhqt5MMzXCBMAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::12) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0050.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 13 Oct 2021 14:18:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f9d7745-b7d3-4650-41d5-08d98e54476d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40417C9D32FFD622D549815297B79@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7BFbXszwCpa9TP4rzjJwCZctZTviNWjQJyJSskbV2FIkoKO7N8Ndr65BMLq2zcJ/jxpV5szOkENBzByNdJ4CbgN18SpnSO9Ra9aIvFaTmK0uTuLg163IYwFZ7A+ef0FA/AR54YPskSjHsCRb+EPSK/aJNc75WPy5xuSbQurfObELkp1VcuneKyppeL1vLvJRM6XhY3B3MHCUfmvInCuZss07Qrbq3Jh43lwUhFDm5eYWIDB6mAFaKLFo5jA3+dF754I9awTcdmB4kTBCcvxX/Lo5TigmZXe9lGit3kkScXw7t4rqQZ0y9Vo1h+OJDiyXhAmYl1O1JNqMA7482F2Xae0VQltNZ1XVUKjuvxSOnExYBAgPU3ZosOsPlCJ/Bsmf9SGOB5YeTiVr9kz5vdQSb4fCFKu9UeYvGb1po2nvLkNOcaggcpT/OFX0AwG2bqksxCfwrheAIHKikEIpCackVgeNU0kMpgh6dzSTtfxokA0LjOAQUONxXzT0pe20eHRwYnRq+u97yzaQhCKyPKKTtIu7v83Y9eYqykI171CtKuCc3ea8kHyYMMHziNEbiqaxeBNK2riQgKY8O3IRHBgFUkecsoXwQYKIASId6r+Rlwx0U27iMm2ujcaHdCNsERe+17N7T4CMvP1UM7KxqSqmYZV7xbKeeccOgzUpVjdFnICK//yT6Bqw1gZj6vuEpyHaqbyXtHOnGr2flcjfDbxpOGrq5pyuGgqHzuJ+WtpcXp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(6486002)(2906002)(2616005)(38100700002)(508600001)(8676002)(4326008)(186003)(53546011)(8936002)(16576012)(54906003)(5660300002)(316002)(6666004)(26005)(66556008)(66476007)(83380400001)(66946007)(36756003)(31686004)(956004)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2UxMUtISThuTTB3V1oyOW9pYko0SjV5a0w5TDVlMnJUSnFOMXVyYVpBSWRC?=
 =?utf-8?B?ZHYwcVNjVnBsNTVybkZSdkV3SXNRclN5OVpiWnQ0cHRQOWVpN3pPQ0pncFFu?=
 =?utf-8?B?RkI2dU1hMDZxYWNoMEtmeVh4ZXNJV1I3MGhxTDVFM3dKUVhxMkd3ekZxekZj?=
 =?utf-8?B?T1hHQVBvVmV6UjJNV01GZ2xBUXIrazFwQzJoWXNCZ3FsVHYxYTFLOHNadmkv?=
 =?utf-8?B?TmxWZmNOa25ZNmlBRVhLNDNjV1JPTGdFNGljMGxUamdiSVF6dVVQUTBLTm9n?=
 =?utf-8?B?Z2p4SnR2c2hjcHMrNDc3STRhM3JNek1oYnJlNXRxc0IwQnN2K1BSRDMzNENM?=
 =?utf-8?B?VVNGVjZyOEFWc29NZHVVYm1HVGV2OFpRMUM2LzdYMVpFOTdtSGhpM2l3aWdh?=
 =?utf-8?B?QVl4dVRQbzR6Z0NBK3owVHdqSUJ5TWo3ckxReERwTjBKeDNYMjN2SFdHYndI?=
 =?utf-8?B?WVZidkhGN3h5NVlVNklEd2xXUjhjOCtxclFvWStlamsrNUVpVkNVWkFiWVNS?=
 =?utf-8?B?WGs1L082MFpNWENKaUJlL2ZRNHhjd3ZURk1ERWdjTTN5WG40L2lnd1o2VGdH?=
 =?utf-8?B?Q0lqSDVWb0pmZXRoUFZ1Q3ZGNDNNWVV4ZW1jMmlBQk5NSHgrZXQ4bnVUUGgy?=
 =?utf-8?B?Y2d4Y3htSmxtMGJTQlZ3N1JpbTRQNWdpbmJQRzlFNHN1NG9ldko0RGsxSGFO?=
 =?utf-8?B?WWs0QXJEaDBKcm5jbk5rMW9UaEhjWmRNVlZSMW4ybk1pa2pzU3hBQ3BlTXpr?=
 =?utf-8?B?SEErMHI3UVBtck1EUWVEVmpqM01INlRwNXJqdzdlV3lxWHpMRzlxVmZzdkU4?=
 =?utf-8?B?b1JIU1hKclRuSFFPQzVCWjVHV05oSWVzZUJjNGJOZGd1TTNlUFpTTVVvUGw0?=
 =?utf-8?B?eFRURGlqTmJwVUFPOWNVUVppNW9sc0pXN0grSTVGR2tmK25FQ0g4UVZUUkFp?=
 =?utf-8?B?TWdsVitlVUFGOTQ2dVY4N1dkbGNQOVY3VlBsazZmd0RxdUVvTmQ1ZlZta1ND?=
 =?utf-8?B?NXh0dDlNZ1ZYYjhVd2c3eHNwTHZaMm5ydm5mVmJZUmt2V3ZwSGxJNTduSmRF?=
 =?utf-8?B?eE8zTndNZXhqaHNCN3pMeXZMMnVIUmVQK2M2N0RML2RYV3N1L1k1T09BL1E0?=
 =?utf-8?B?R3NlemN1aGkwRUE4SmlxSWtQYVBCUVRvU3k5aTRqNG5hQS9zUGhTUjIyMWRE?=
 =?utf-8?B?UFRLRXZhdXluL29jdUg1RGVaMElLek0xSjFzT0NONVQrR0pyQVY1Rk9JUGht?=
 =?utf-8?B?NC9lOWM5VE11YnZnbDM3QTJwY3Z1UFlBNGQzTXRZd29mZUxpS2hEY3hMaFVD?=
 =?utf-8?B?aG42TmFQVGdLZ1JORHIzaVhadXRxa2tLSlVLVktxQ1JhazBQQy9PdE9BNFp5?=
 =?utf-8?B?QlgzN0xOODFsVkE2NmFKYVBFc3dkc0I4UWRhbE8vMGZBeG1xVmJDNldqc1dn?=
 =?utf-8?B?WUE5U0FDSHZQdC9UQ1dvV1hkbTFpKzVxek5CZlhHcWRlMEx3Rk1IdkhrcVY0?=
 =?utf-8?B?RWZoUDEvN2hqdEdjYzd1VnJHYTVCNWNoamRPTWd6NTN2VEtJUUZIN2EwSTAx?=
 =?utf-8?B?YnhncWVHL1cyS0JuVzd6V01wOWtUSk9YRndYd2ZaaldVL3IyWEkrdXlBMTBx?=
 =?utf-8?B?dHdzeUFzd01aeVg5NE5IUWZKOTkwcmNRK3A0YUdQdnBsYldsMUR1bm1yZTBT?=
 =?utf-8?B?a0FlZW54Z0VpY1UwSlpDNDhYTkcrWjJIcEVYWXdyOUJqZG1TTUxNQU1PclJu?=
 =?utf-8?Q?9R0QLLaUTcVRD3RSIKogTmrUwp/zPE93jHzxYVS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9d7745-b7d3-4650-41d5-08d98e54476d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 14:18:07.7744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7db5lDkMy9dqJC/Bif9fZlpWYWSuOJtkOiXgZHGPAIOlStRY7bSbwg3Z3cFPcave
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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



On 10/13/2021 7:28 PM, Alex Deucher wrote:
> On Wed, Oct 13, 2021 at 12:14 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 10/13/2021 8:40 AM, Luben Tuikov wrote:
>>> Some ASIC support low-power functionality for the whole ASIC or just
>>> an IP block. When in such low-power mode, some sysfs interfaces would
>>> report a frequency of 0, e.g.,
>>>
>>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
>>> 0: 500Mhz
>>> 1: 0Mhz *
>>> 2: 2200Mhz
>>> $_
>>>
>>> An operating frequency of 0 MHz doesn't make sense, and this interface
>>> is designed to report only operating clock frequencies, i.e. non-zero,
>>> and possibly the current one.
>>>
>>> When in this low-power state, round to the smallest
>>> operating frequency, for this interface, as follows,
>>>
>>
>> Would rather avoid this -
>>
>> 1) It is manipulating FW reported value. If at all there is an uncaught
>> issue in FW reporting of frequency values, that is masked here.
>> 2) Otherwise, if 0MHz is described as GFX power gated case, this
>> provides a convenient interface to check if GFX is power gated.
>>
>> If seeing a '0' is not pleasing, consider changing to something like
>>          "NA" - not available (frequency cannot be fetched at the moment).
>>
> 
> I don't think this interface is really supposed to be the way to get
> the current clock, although some use it that way.  It's supposed to
> show the DPM states and which are active.  conflating the interface
> with other information confuses things in my opinion.  Why is the
> current clock less than the minimum clock?  Whether or not an IP is
> turned off or in deep sleep or not is independent of DPM states.  When
> the IP is active, it will never go below the minimum DPM level.  If we
> want to query deep sleep or gfxoff we can use the amdgpu_pm_info
> debugfs interface or add some other new interface.
> 

The idea of DPM level is deprecated with fine grained clock which 
provides only min and max. For fine grained clock, we fetch the current 
clock frequency and show it as an artificial DPM level between min/max. 
That itself should have confused users but it is not which means the 
users use the * to fetch the current frequency and not really bothered 
about the DPM level per se.

Also, some ASICs define 'min' as as the least possible freq (that 
happens during a throttle) and not the DPM level 0 min in the 
traditional sense (that is defined as idle frequency which doesn't come 
into min/max levels). It's usually from the idle frequency that GFX gets 
power gated. Showing a * against min in such cases would be confusing 
because that could be misinterpreted as a throttle scenario.

Thanks,
Lijo

> Alex
> 
> 
>> Thanks,
>> Lijo
>>
>>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
>>> 0: 500Mhz *
>>> 1: 2200Mhz
>>> $_
>>>
>>> Luben Tuikov (5):
>>>     drm/amd/pm: Slight function rename
>>>     drm/amd/pm: Rename cur_value to curr_value
>>>     drm/amd/pm: Rename freq_values --> freq_value
>>>     dpm/amd/pm: Sienna: 0 MHz is not a current clock frequency
>>>     dpm/amd/pm: Navi10: 0 MHz is not a current clock frequency
>>>
>>>    .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 60 +++++++++------
>>>    .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 73 ++++++++++++-------
>>>    2 files changed, 86 insertions(+), 47 deletions(-)
>>>
