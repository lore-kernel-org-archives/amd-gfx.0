Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BBCC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 17:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C27B810E3EB;
	Mon, 24 Jan 2022 17:08:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C4110E3EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 17:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3w5S/jFDVjTxWLQxh39EEXToXipcEF0kfi6d69s9mqT30bYVPG56fau6pvIukUxjnmu1DA343WHk93WPCHs8E5U89/Nlc7CDh7XRPxvJtNYJ+RXcmB4Jw4oFATHFkEO8bUZIBhtDLERf9Tzt6QugbjS91t7uV7brSYHZjMgnVqOUiV8/iC4FWkQHHAwZMRzwsvoJCkT5c3r1I4FzsxOGekKghj+jRmre8tjSvaghX98kvLmMFP1cGpxFbM5AU/S83YFXzsGnYU5Bx2/vmuIABxqsgtk/nJ3pGC2KCsK5gQjcml8L0Dm4sj1uMmNuxOKB6MOfg2YkP314CD2ZyZ9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oP2vSzc26ejbWi0TwDW2cdMYx05DmP6PP80bwjZvkY=;
 b=hqkUt7n3hdytDVsfeDHKEWEgNOGsl591XG4LmmWEhZWL82qJV/Pdcp52LmjZeVSUMdCrQ67f2tBGo5GL8lML6R92CDoMzN5MMo2UCRtyoyZ/O32853NiVvcXGp8m0cE/Szi8ZvY3cshnlQS9jmVngwCWYAbod9FE7NZLJJ2rkZT0NWgo0f6c3nciZVjscrXnCKNtU/AHmpWp3Jh5Et8apPtJyysYN8oL4AewXrWJqSSgcc9VEN/dqda5Ur+TczYbSO95QW6O52dqZg5lCs8VsyP2kcnA5LtZ5PCohHn5+2j8lJ59iFM/GIt45RTnIHISkWDf6KgTw9UnjlXVcM/rcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oP2vSzc26ejbWi0TwDW2cdMYx05DmP6PP80bwjZvkY=;
 b=05s9UsW0nmf5KDnPuMlxUKoSrr0sTDz7D7mF+sN9j/l50qPYky6IFv29Aw+ZDHiapykdkWlP0X+1Xjq5t4N5KtWHt0/xP/xCImOIVDfsFVyZLo+GT+JBO+6Z7M4+TAyQDnTuUgOspatA4qHjpo4w9R/UWDDfwvLBcCRKiqls90M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BYAPR12MB3605.namprd12.prod.outlook.com (2603:10b6:a03:ae::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Mon, 24 Jan
 2022 17:08:03 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 17:08:03 +0000
Message-ID: <805198f1-35b2-2e75-4dbd-9b38079bde9e@amd.com>
Date: Mon, 24 Jan 2022 12:08:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
 <e3a18180-7c02-c10d-157e-8c4b6c6736cb@amd.com>
 <d98e2702-fe42-dfd3-64d6-0eb67a07ca7f@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <d98e2702-fe42-dfd3-64d6-0eb67a07ca7f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::20) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38709273-8ae9-4329-1d08-08d9df5c1485
X-MS-TrafficTypeDiagnostic: BYAPR12MB3605:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3605FCF041E890AA2EED07C9EA5E9@BYAPR12MB3605.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzZ8Jirf1hwj6dbuM/NPcmryb454JYVs3O99BQJog4iHSSJ+EZcCZYX0Tbp1NgkeQKyAk9LIYmbK56cOnQJ3eVh17v1NEmllleM8HVdvELvsFuwsUhpYuiERsi3czJQDaVFRok6prQUJUrjp904peX4ShLiFjpvNg86m2tykuzSlcTvNYIkHiLVqHziyAFKjTCWRFT7Gnimschc6hDaTTUlRUNJfZS3Vm5XJa4CEA/kanJ4mZ/GAhG91XHyQ1Vi2/HbulKSPYmrsGXcGubotMaIoNdzo+JWnb1YRqOtOygrXMvkU5MGs344ZsMU7hms0Y3AqQRkXNvcgvf6M9XIDX/7aqCOKo3MahWlMWniYHFwolTQ9GdoosFiv3aM82aa5QZr2d4Gh41CXFoTvxuYzGFSOeM6aGW4+SAAiZTafOws1eNTy/KcbiqVdfTkqJDTMC7Cx8T7BIH8HFzWFNnkqHpUmEP+l7ikAVos74UmT0q2IxWfXLi7h6zaBkiZuRPlGVKG2X8n05QL1iS9AYj9a74NNF3YDGU2HJ97Oingw6o/UxbpTujzQAIIblWSC+PJBCUYEbZlAtY0odqwTcJFm+u8oqPzTIhYyV+xe3FRjZ0rucogKQ6Dt7vqYWg4ZDb6T5GJFbCWLinSbuPBqkYzkPEsCqxFdTu3adpEAD0FIlDKVDBKUTs7ymKqxpnnLMV9W/L6ETMEYOCduBhC+lXucqvR1Ug+kP+LR6MI1xaqxTN6xmezOueAxkkbE9DQqhKyM0FLaTVKVjeK08vnW0giu11FfbWNDnjvksTsBf/5tV1I4FUBAm1XcA46I9mvdQ21QpcOCLQy3vc1xPLxtYkpXBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(110136005)(36756003)(31696002)(31686004)(186003)(2906002)(6506007)(8936002)(38100700002)(83380400001)(508600001)(6486002)(66556008)(66476007)(66946007)(44832011)(4326008)(2616005)(316002)(6512007)(5660300002)(966005)(86362001)(53546011)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEJ3S0labHIxTWhnemtTRDA5K2E2djFCZ3NiUXpwWGlDZjd3bE5qNm5pQm5U?=
 =?utf-8?B?YXpWYzFOWDVOTU90bExMb0gzWC96eHlCbUFGdzMzdXg4UDlXK0FvbEp1ajli?=
 =?utf-8?B?U0s1d1RRZHg0UEFYTitTblg4OGE3SkNPTk44NnZ3WURvR00rdzFJS0hVdmY1?=
 =?utf-8?B?S3ZoNW5FK3NiQ2gvMEhFbmdmcTI0UnJ2aEFQamxYb08vaGRmaTd5dGtDTlM4?=
 =?utf-8?B?dEtJN0NpbTdiV2x5QlQyUjlWcEFkOXVhMjlJRzJ0YW91TVpIZTdqa0RCbjJN?=
 =?utf-8?B?OXQ3R3RQOVYyRlZuR2pDVzUvNDU4UUFpaTVFQUJHenRxejlSMzArQzEyQW1M?=
 =?utf-8?B?Z0hTSjl0QXZrM21RMlJmN0NZZUFtMHJGK3pxUnUwN3VZZ0R6UkE4NGFTdThI?=
 =?utf-8?B?WWdvbVdKMkVPVVQzNlc3OWt3S0JBdGh4UWNlendRaWtxTSsvTlhscVc0cWxG?=
 =?utf-8?B?YnlVVVQ4ZmVvYy9wVG9RekpqN3lSRTNZcTNtMEljUHZHaWcycmlicEMvZklt?=
 =?utf-8?B?RTRpd1I4Ni9KNW1JR0dDcHNON05GdDg5RDRJeDZHYzhybW5DUTFuM1JIeUEr?=
 =?utf-8?B?QUdIbEJsczFBcC90Mm5SQTdnSGQ4ZFJzNGl3dUprUDlkZHhzU1VQb0t5c0pG?=
 =?utf-8?B?R0ZGdmVjb0pwZEFCQzZLMFJKOVdONk1KVm9SU2VjR1p3TW8zVUpUSXVHd1Mx?=
 =?utf-8?B?YmcyUzNFK1JCQ3hjMFFmSk5sTWlsUjdxSlJUMVJDQkw2UmZTOWNFUkdPSk1s?=
 =?utf-8?B?aEx4bXdYeW02Nm90ckVNbklLZXpHQjArUWViZFNJUFg0NkYvUWc3U2RPZkNO?=
 =?utf-8?B?b250N1puNCsvT09YZ00rekowTXB0endhbTU2Mzd0V1IyQ3dzN2RwQTYyaHFS?=
 =?utf-8?B?SXJVWmRGc1RrVWVXeWMyZHpmYUdMSVFtWncxRmNBRkFPbEpNVVlCVzYwckJa?=
 =?utf-8?B?OVNzQ05UOWtqWk9rYndMTUNJQ1prMnJkM1JrdjdpV1hMNDJVTVBVbktMLzdH?=
 =?utf-8?B?cjlQWFlDalEwNEFMWXRFc3ZudHlGYmNSSG5hTVVUcjJEZ1BCanJLVUg1WmVy?=
 =?utf-8?B?MmFVdGpDdFR2dGRoanVSNUhudThCSzMvMmtYM2lzbSs5cFN1U2p4MUxSZitF?=
 =?utf-8?B?S2w5ZXhzdno3Z2dtTTJKWFlRTlc2R2w4M0RkMGcvejJIQ3VVbE1vM2pLaGRx?=
 =?utf-8?B?YUZvK1ExME1jMXdtZnF1T2o4VVhmWUc4VWIvZFVIb2oxU0ZDUWVIZlJNZDZq?=
 =?utf-8?B?Z21MbDJTQW8rU0RYNnkrSC8waUI3cHJ3V0JncEE2di91ZE5LdVVQNkZvdmRn?=
 =?utf-8?B?bXBQRDI1VER5NHlhVkJuTnZhMnh3OFBVNHU5SGlDR2dRa0plVG1GSmZuQ05h?=
 =?utf-8?B?N2ZLRzNDVDVJRmY5NmcxOTd4eExSR2w5TTRud2NoZE5SUHNuTWlvZ3c4U3NF?=
 =?utf-8?B?aGlCaEtlcW03R2xMc1NvT3NzYmpGWkRiRExMY3d4b24xU0M5VzNMZy94bDZP?=
 =?utf-8?B?OFVoRC9Bb1VCZ1pCMnpUdEd5MThFQ09ka1BTV3Yvck9oeFdVWDY1c0o3cEcr?=
 =?utf-8?B?WHpwKy90Yko1NXN0RnY1MjJyTHlQODhOanNhTnZYbGxRM013d1gxdVpjM1Ev?=
 =?utf-8?B?RER0U2xOREVXb211RENaaDQvcDk5S293Zlhickk5QVBWVEZEK0tFWWF1ZVQ3?=
 =?utf-8?B?ZWRWVjhaYnl4TlRkanNQV1RQNUptREtUcmpnSk92WWd2MFlrMVhXV0pUWCtV?=
 =?utf-8?B?SUIzdGw5ZUpJTldXOHdTVGM1UzVON2ZJV2R0VklRVWdPWjJJZ0dCdzhlUXJG?=
 =?utf-8?B?L1pnSzBBanR3M01mL0c5QTFQQUE1UkNxZDdJSWhucWlIWktpL1ZhWTZDWXZQ?=
 =?utf-8?B?RE5oS052bHFzSzNpK3RlNjVIck9BeVR2TTdzNllSOXh2ZHNpTHo1YUt2WmNx?=
 =?utf-8?B?Y0JZVlY4bENuZkdjUThuV1BiVFE0VE5kOG9DM2VFbWZwSUhlMTBveEl0R3cv?=
 =?utf-8?B?K3FYWmhLSHRxS25RVFpSMCtZMUFlQ2hrTXE2VE8rUG9QSnNYbGg0Zkd5Nm5j?=
 =?utf-8?B?SnZXWkhxOFoyV0NXeFJuZW1seXhlY093empUSVJRcHJ3SFUyZzdKME9taGE3?=
 =?utf-8?B?c3pScGkwTVRZZTYveFYxQW5EZUFUNlBYMERQSUY2cTFadFRLbWFzOHRrQ1dr?=
 =?utf-8?B?c3ZjclF1Wjd1aFBrWEdVWG9yQmwxdlNZSFBkWXQ1NWc4Ry9TbncvTFl0Smpl?=
 =?utf-8?Q?fdChxRdQnhY8M3+sT/yQsk3VVPi5+2fW+49rdbLySs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38709273-8ae9-4329-1d08-08d9df5c1485
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 17:08:02.5920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElXBO3O79DenwyqAaXIdy/Ovn37cTwwA5jJOCSoEN+x632jI+78CP6AZjkYM2Ovo9UhJ3fGCMDaQ77MJqBaUIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3605
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's just an infrastructure you use when you need.
I never tested it during reset i think but, we deliberately did it very 
self reliant where you simply iterate a FIFO of the dump through PMI3 
registers interface and dump out the content. It currently supposed to 
work for the NV family.

In case you encounter issues during reset let me know and I will do my 
best to resolve them.

Andrey

On 2022-01-24 11:38, Sharma, Shashank wrote:
> Hey Andrey,
> That seems like a good idea, may I know if there is a trigger for STB 
> dump ? or is it just the infrastructure which one can use when they 
> feel a need to dump info ? Also, how reliable is the STB infra during 
> a reset ?
>
> Regards
> Shashank
> On 1/24/2022 5:32 PM, Andrey Grodzovsky wrote:
>> You probably can add the STB dump we worked on a while ago to your 
>> info dump - a reminder
>> on the feature is here 
>> https://www.spinics.net/lists/amd-gfx/msg70751.html
>>
>> Andrey
>>
>> On 2022-01-21 15:34, Sharma, Shashank wrote:
>>> From 899ec6060eb7d8a3d4d56ab439e4e6cdd74190a4 Mon Sep 17 00:00:00 2001
>>> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> Date: Fri, 21 Jan 2022 14:19:42 +0530
>>> Subject: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
>>>
>>> This patch adds a GPU reset handler for Navi ASIC family, which
>>> typically dumps some of the registersand sends a trace event.
>>>
>>> V2: Accomodated call to work function to send uevent
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/nv.c | 28 ++++++++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
>>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>>> index 01efda4398e5..ada35d4c5245 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>> @@ -528,10 +528,38 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>>>      }
>>>  }
>>>
>>> +static void amdgpu_reset_dumps(struct amdgpu_device *adev)
>>> +{
>>> +    int r = 0, i;
>>> +
>>> +    /* original raven doesn't have full asic reset */
>>> +    if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
>>> +        !(adev->apu_flags & AMD_APU_IS_RAVEN2))
>>> +        return;
>>> +    for (i = 0; i < adev->num_ip_blocks; i++) {
>>> +        if (!adev->ip_blocks[i].status.valid)
>>> +            continue;
>>> +        if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
>>> +            continue;
>>> +        r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
>>> +
>>> +        if (r)
>>> +            DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
>>> + adev->ip_blocks[i].version->funcs->name, r);
>>> +    }
>>> +
>>> +    /* Schedule work to send uevent */
>>> +    if (!queue_work(system_unbound_wq, &adev->gpu_reset_work))
>>> +        DRM_ERROR("failed to add GPU reset work\n");
>>> +
>>> +    dump_stack();
>>> +}
>>> +
>>>  static int nv_asic_reset(struct amdgpu_device *adev)
>>>  {
>>>      int ret = 0;
>>>
>>> +    amdgpu_reset_dumps(adev);
>>>      switch (nv_asic_reset_method(adev)) {
>>>      case AMD_RESET_METHOD_PCI:
>>>          dev_info(adev->dev, "PCI reset\n");
