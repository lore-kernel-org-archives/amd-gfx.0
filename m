Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D96ECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 05:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E21F110E3B1;
	Fri, 16 Sep 2022 05:18:53 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00EA310E3B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 05:18:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6Zf32qQr13rTnYOBjLknFZf1LjzWgbgio96Sh7KaoGEK0oz4oDoZdNRD4y9MqVUUJ16OjOwJSz6iKizeOPcoJ0q6tNRMiXOqOJRxOQLbThLYBG37Xzjb6QFoQ1cmetWXdlEObwcQItmVKfzf7EGCTcI8B+4K3Jrx1BXk+klwMyPCCZewQNeZbUs+VKhIAhWG+IsB8l/7vcLASJaJC+VpgOK+yYSSbUfmPxtC4WugcNTVaD+YuzOUbYoVLTSTZkHbydJPAPzCVFkDNlagG/Q7XYs4J1zHMUFzNaAIUA63mIFTap/wfb4AVM1W4fL9h6wlNnybhmjZeS5a0tNUXlz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbehtlGGXA77Pdafy6ohLujkqFZaIqkqXGgEUFkTYhE=;
 b=bd2F9d6sqma7sXObaT36poV3uYIq8D2MsRDw+lM5lI3ipbBK2l/Df7l2p00KrcLzsVJHZPZF5IzgQmKHqi0v9/cBUSE5rWDkHnW3nUuqs3tq2iOffH50uU+4LM4bjRayimKBpxyUIklLkIWsYLRU6Rh+WKox4G9PjakIF+8dX8W1Y3kZ3G8DaODgl3khYgIIufaCIVvelxX4gC+GyVOP6jUm1OIB6tgtUHJw8rXxlAVcU3iaVKq61TygoGbq2NYI+QjYFwSiaApuEmfN8KCdq1I3fjx6UitDDfAStRgZiD3bWdQirBC+HiCoJTZxyr/yjMRBZnO6dTr8ETnVZ+Sd6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbehtlGGXA77Pdafy6ohLujkqFZaIqkqXGgEUFkTYhE=;
 b=Sf7YUMrolFuThZJ3apAQ0LkQ87fcJ5B5oubiLPGm0XTiSJq1MQ5leg9X+5oIh6PCprlWoEzp9MSBZ5K06xgQgw9UgZij/w915CSmZAIhT5H9SeghHmc4NkCJ1OMbGnfnJvK6gABk/u9fWSS6tZE5LeVKDymIFqRCLRIg/MIn398=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH0PR12MB5498.namprd12.prod.outlook.com (2603:10b6:510:d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 05:18:48 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 05:18:47 +0000
Message-ID: <3ee47f74-fca4-f78c-9235-972d4543d880@amd.com>
Date: Fri, 16 Sep 2022 07:18:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220914101025.366954-1-Victor.Zhao@amd.com>
 <DM6PR12MB4340D28D9D23472D571727D7FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
 <1ea8528f-fb55-e8b1-73c8-bf8935f9870c@amd.com>
 <DM6PR12MB434047014434C43396BB2D31FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
 <e7eadc0d-c9a6-8a12-bbd7-5dd3277a7754@amd.com>
 <fc7f7d5f-3d63-234f-1864-ab365d6e338d@amd.com>
 <378f971b-9ee6-5fb3-4143-f20b873d0b4b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <378f971b-9ee6-5fb3-4143-f20b873d0b4b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH0PR12MB5498:EE_
X-MS-Office365-Filtering-Correlation-Id: f605fb62-73da-46a0-8efa-08da97a2eed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUOC52CS2RUMHz8PC0Y/7c7dIOv0KrRA8ZKIAI57e/Ge25KoVrNJzSjChnA/Up73UWFfNsk8f+d6BcsgLdxcVFkHd7KynP9P4mXhoTsum9KnCgsRzSu4MhoUp4+FSZHLV7lu4EPwxGw7E1MtPyQmY50rWdCS8tO9sibrzuJ1ym6lTgA7WbUnceyiKFGJ5qfmsMDuxdgQiJqz7Kvbsv0eA2ww+SKfRDJ23DqOhCfng78PH3V1CqoSI+xl9yP67Ff0yuWSeg7QMvto1+tuYkZbcU4VceV/pfMT2ErgXtbQrL8spl0w0CoFPMoDXvqdlrXM3HDG+fjfSZpUQcbhE0yNAbFw5APjA7ve4fWYJRBR3I93lXxfjeJEHZRAjMNlHGc9wuYSEb9NkWw9Y4Akhl3V8/nKfbYmMh2QQEdqSrjja5jrat4WkRNnVhvBZAvUTAzBLFAEsan2pTPvi61NqtO3v0hms9XPGROdKz6xlPCC5i6sDwOxEq3TloJQCwCG2QdgCQyhXrE+xFxbe5uMJkDy7iTNp+djy5f2P5uYlLSNmomssQJSVqqF4zn+nGNb6Hbkx1WAeajb5Hf0uiRLBz6CuL14yD0FQ0yZ0sqPjD5qMBKuMPL8u+f2O045l69wEPME5f8xjbsx+gL6+AT608x1mJhoOHhYxJ4HXXxebU8xNLSmtNRiOr3aIsY9GG8ycu+k2bDxyvKoqT8oQD+aVGBmrATzw+1+Hi6qFx6mE2YWp+BGg7TwMHc+T3Q6ZqfaR0Uek8lxDrke1BCJm0ddSn9p24l8HMHVvT4VpsdmkpGtiwEoROkPT6lQ4NmOiP1AJLjc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199015)(38100700002)(8936002)(6512007)(2616005)(31696002)(53546011)(86362001)(6486002)(6666004)(478600001)(41300700001)(6506007)(186003)(83380400001)(36756003)(4326008)(66556008)(66476007)(110136005)(8676002)(66946007)(66574015)(316002)(31686004)(5660300002)(2906002)(509564003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlZHclo2UmpZaUZaY0RQa3cxcndOMHJVZVZDNVVKNDZxdVBZUVNFS1JXWmxk?=
 =?utf-8?B?eTArM1cwTkFydzZXb2RUd0VVd0xidEdGZ0MxZ1NWYUtwelBkMm5FekpQM3ds?=
 =?utf-8?B?ZmhQYmZOWEhxdWFSdXRwWlBPbVR5TkZ3UG9peWJxejJUYTEvMkZvYndtZE1X?=
 =?utf-8?B?c29NM1dmYmVNOWs0SXlyQmZ2b29tS1JRemR1ako5cFBIWTU0a1dRckVUQ0hJ?=
 =?utf-8?B?N0ptNWw3T1J5SjN3bXZPTk90dDBUY1ZlSmZrRmJCRmFVUE1GemlubDdIU1Qy?=
 =?utf-8?B?cm9wcTZkeUN1Z2xmQmRDc3hwaGJFMEZKbXdaNmZBSU1HZEdsQWNyWVNZYUli?=
 =?utf-8?B?NjJGWU10ZFpFR3hjcGppL2hLRmdQeU96UVRxbzVVa2JTMFV3amViTHV0YTVK?=
 =?utf-8?B?QmZEMGFoaXFjR2hxUlh1WUNYR0tydmQ3c3VaSzR0VDNkWktiK3EwSFVEZnU4?=
 =?utf-8?B?RGdWTUFPRm1TR3Q0cWozNmM5V1V5alMrMWdYNHZSUFFtS0YyS1JFZCtsaThH?=
 =?utf-8?B?SndEMG1VS3Y2TGhsWWd2NmpyL0xHMCtETzM0RUk4WTlSNUlBT3E4UFE0dGho?=
 =?utf-8?B?UGJCWmhBczRQTUQyRms5c2Y0SG9DUnpBWlk3dXFIUnJBMUlOVFF0WjlmZmho?=
 =?utf-8?B?bjBJZWNkR1RZRkZ5aDlUSE5hWHhydS91aVdTaHJZcXUraWl1ZzFmTm4zL05H?=
 =?utf-8?B?dkdUTFZBaHNNaENSMDZkblBrOStNekRGSEV1NWRvOTRwUjhub2RUbGVkNzY0?=
 =?utf-8?B?bWJYb2ZDck5OZ21kR3l3Tm01WHBHcGk1S0hMUVdGWW0yZGxsUHUvOU9ycDBj?=
 =?utf-8?B?d2RCSzI1YUEzS1gwaWF0OCtHQWNEWXNTaTd6WU0xS0MrNmJkYnl4UzNCMzAr?=
 =?utf-8?B?MFQ2a0N4dUwyeFFmM1A2REdFNDduUnFPT3BHdjNyYWIySEFIQnJrRVZRaGcy?=
 =?utf-8?B?eFI0OEo4d3o0YjVkeHh0N2JXL2o2ZHpoT1d3enNjczVZSTZEakFQeXBvL3pU?=
 =?utf-8?B?WGxFd3N5SEQvbFBydmhaQlZPaURmMWc5blBibmx2eVd3Zy9PdVdVVkNxWTlp?=
 =?utf-8?B?anNRSG9GMzlxK2M5ZmVaSW9qd3BPRGJKcmJ4K05mQjBnQzFUYjBFK1hGME5n?=
 =?utf-8?B?a21wbjJMN2lEZEZmQXdYY2l1NytyY1dtU0dlL05CS3BMU0RYcVhCRjNOYkps?=
 =?utf-8?B?U1JvU21ienhoOFNSYkpsQmkvSk9SZnNFbnlyZFRTUFZVSk9hcEgyTjBVU2d1?=
 =?utf-8?B?ZWdvRDl0ZDNML2grUWhrM3JzTTgraGhrcHlESy9NYzBhREVJa3NvekhvNTVu?=
 =?utf-8?B?dWI2VFJ6TmE1STUzWkZQWTlEVDBrN2ZURGIxKzc5V1F3Ry8rL0pFd0NSNXRa?=
 =?utf-8?B?WFoxdUJubzFsNlN1VGxTampnb0xndEcvcXo4cTZCeWRCdmd2VGI3TUkwQzRC?=
 =?utf-8?B?TFhsQVYwU2U2UC9GOTVHMWJKRHVMcFRtOURZRGJremhPNVJnaWYyTXpBNUV4?=
 =?utf-8?B?UXJ6b1IxNEhSMndySjg5Y3ZNMXBpR0tZTXExRk5BcW11cmphUnM0d3ozSUQ1?=
 =?utf-8?B?U3N0ZkFVL1lSRUdDcTgyUlFBVkYxOE9rdzZtMG1mc3ZPbXozL0hjUmlVNmp4?=
 =?utf-8?B?aFZKSUh6Y2Zyd3RsS3lIai9ZT1ZDOXNUaTRZMWpRTm1QWnd5MkcyMktZTjg1?=
 =?utf-8?B?SGt5V202K0JQZFVFcEQ0aHJnV1FlaVQ2NVpadVlWN0QwSHFUMVhoRGZwa0JT?=
 =?utf-8?B?OEQyeDAvanlaMDhhbEZ1ZlhCdVFKTmVTRXhjaGMrWkVyQ2FkNzhRWWxxYXJr?=
 =?utf-8?B?bVRhWmd6S3pzeFNBdEo4UC8xdHczWkc4dVRLOEtPVzRrWEplUlh0MWdjaEhn?=
 =?utf-8?B?QmdpY3JPRkZnUy9vM01uNnFPcmptSUdkdS9hd05EeVFMZGhGekZvWitvUE92?=
 =?utf-8?B?Vy8waFJLbzhpOFg0UWwyWTNuaU8xL0dVZURqb05mSTI4Uy8vWUNCZEw5LzVy?=
 =?utf-8?B?alp5QVZtTjVqRG5vTFZCblRFWGFvYkhOUDNOdC9KVmg0SjNyN3ZTU3N5Vjg0?=
 =?utf-8?B?MGdRTHZBdG9jdXBtRTNzQ1lBWDRlZy9zcll0RTJubWNYNTFiTmc5Wm12ZDZ5?=
 =?utf-8?B?SDlMUFRDeVlPMldyK3M2NGF6SHVwOGcxS3F4TUFLSmpkRjhxMnVqdEVLU3RX?=
 =?utf-8?Q?R7xBVNgubXzOveOwHKSEZHRuqfCeEwYufyGpuSUaMUCR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f605fb62-73da-46a0-8efa-08da97a2eed8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 05:18:47.8230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5zS94QkDVpvwcUkh4y+Vj6yuHSvdmhSE4T4vaL7GJWNKi1Fl56ucWVbJ2jNc26a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5498
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.09.22 um 22:37 schrieb Andrey Grodzovsky:
>
> On 2022-09-15 15:26, Christian König wrote:
>> Am 15.09.22 um 20:29 schrieb Andrey Grodzovsky:
>>>
>>> On 2022-09-15 06:09, Zhao, Victor wrote:
>>>> [AMD Official Use Only - General]
>>>>
>>>> Hi Christian,
>>>>
>>>> The test sequence is executing a compute engine hang while running 
>>>> a lot of containers submitting gfx jobs. We have advanced tdr mode 
>>>> and mode2 reset enabled on driver.
>>>> When a compute hang job timeout happens, the 2 jobs on the gfx 
>>>> pending list maybe signaled after drm_sched_stop. So they will not 
>>>> be removed from pending list but have the 
>>>> DMA_FENCE_FLAG_SIGNALED_BIT set.
>>>> At the amdgpu_device_recheck_guilty_jobs step, the first job will 
>>>> be rerun and removed from pending list.
>>>> At the resubmit setp, the second job (with signaled bit) will be 
>>>> resubmitted. Since it still has signaled bit, drm_sched_job_done 
>>>> will be called directly. This decrease the hw_rq_count which allows 
>>>> more jobs emitted but did not clean fence_drv rcu ptr.
>>>> This results in an overflow in the fence_drv. Since we will use 
>>>> num_fences_mask in amdgpu_fence_process, when overflow happens, the 
>>>> signal of some job will be skipped which result in an infinite wait 
>>>> for the fence_drv rcu ptr.
>>>>
>>>> So close irq before sched_stop could avoid signal jobs after 
>>>> drm_sched_stop. And signal job one by one in fence_process instead 
>>>> of using a mask will handle the overflow situation.
>>>>
>>>> Another fix could be skip submitting jobs which already signaled 
>>>> during resubmit stage, which may look cleaner.
>>>>
>>>> Please help give some advice.
>>>
>>>
>>> How about the code bellow  instead ? The real problem is that we 
>>> reuse a dma fence twice which is not according to fma fence design, 
>>> so maybe this can help ?
>>>
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> index 8adeb7469f1e..033f0ae16784 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> @@ -164,6 +164,10 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, 
>>> struct dma_fence **f, struct amd
>>>         if (job && job->job_run_counter) {
>>>                 /* reinit seq for resubmitted jobs */
>>>                 fence->seqno = seq;
>>> +
>>> +               /* For resubmitted job clear the singled bit */
>>> +               celar_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
>>> +
>>
>> Upstream will pretty much kill you for that.
>>
>> Re-setting a fence from a signaled to an unsignaled state is a 
>> massive no-go.
>>
>> Christian.
>
>
> Is it worse then doing fence->seqno = seq; ? This is already a huge 
> hack , no ?

No, it's as equally bad. I don't think we can do either.

Christian.

>
> Andrey
>
>
>>
>>>
>>>                 /* TO be inline with external fence creation and 
>>> other drivers */
>>>                 dma_fence_get(fence);
>>>         } else {
>>>
>>>
>>> Andrey
>>>
>>>
>>>>
>>>>
>>>> Thanks,
>>>> Victor
>>>>
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Thursday, September 15, 2022 2:32 PM
>>>> To: Zhao, Victor <Victor.Zhao@amd.com>; 
>>>> amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey 
>>>> <Andrey.Grodzovsky@amd.com>
>>>> Cc: Deng, Emily <Emily.Deng@amd.com>
>>>> Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>>>>
>>>>
>>>>
>>>> Am 15.09.22 um 06:02 schrieb Zhao, Victor:
>>>>> [AMD Official Use Only - General]
>>>>>
>>>>> Ping.
>>>>>
>>>>> Hi @Koenig, Christian and @Grodzovsky, Andrey,
>>>>>
>>>>> We found some reset related issues during stress test on the 
>>>>> sequence. Please help give some comments.
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Victor
>>>>>
>>>>>
>>>>>
>>>>> -----Original Message-----
>>>>> From: Victor Zhao <Victor.Zhao@amd.com>
>>>>> Sent: Wednesday, September 14, 2022 6:10 PM
>>>>> To: amd-gfx@lists.freedesktop.org
>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Grodzovsky, Andrey
>>>>> <Andrey.Grodzovsky@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
>>>>> Subject: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>>>>>
>>>>> [background]
>>>>> For a gpu recovery caused by a hang on one ring (e.g. compute), 
>>>>> jobs from another ring (e.g. gfx) may continue signaling during 
>>>>> drm_sched_stop stage. The signal bit will not be cleared.
>>>>>
>>>>> At the resubmit stage after recovery, the job with hw fence 
>>>>> signaled bit set will call job done directly instead go through 
>>>>> fence process.
>>>>> This makes the hw_rq_count decrease but rcu fence pointer not 
>>>>> cleared yet.
>>>>>
>>>>> Then overflow happens in the fence driver slots and some jobs may 
>>>>> be skipped and leave the rcu pointer not cleared which makes an 
>>>>> infinite wait for the slot on the next fence emitted.
>>>>>
>>>>> This infinite wait cause a job timeout on the emitting job. And 
>>>>> driver will stuck at the its sched stop step because kthread_park 
>>>>> cannot be done.
>>>>>
>>>>> [how]
>>>>> 1. move amdgpu_fence_driver_isr_toggle earlier to close interrupt
>>>>> before drm sched stop 2. handle all fences in fence process to aviod
>>>>> skip when overflow happens
>>>>>
>>>>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 
>>>>> +++++++++++++--- drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  6 
>>>>> +-----
>>>>>    2 files changed, 14 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 943c9e750575..c0cfae52f12b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -4610,8 +4610,6 @@ int amdgpu_device_pre_asic_reset(struct 
>>>>> amdgpu_device *adev,
>>>>>            amdgpu_virt_fini_data_exchange(adev);
>>>>>        }
>>>>>    -    amdgpu_fence_driver_isr_toggle(adev, true);
>>>>> -
>>>>>        /* block all schedulers and reset given job's ring */
>>>>>        for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>>            struct amdgpu_ring *ring = adev->rings[i]; @@ -5214,6 
>>>>> +5212,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>>> amdgpu_device_ip_need_full_reset(tmp_adev))
>>>>>                amdgpu_ras_suspend(tmp_adev);
>>>>>    +        amdgpu_fence_driver_isr_toggle(tmp_adev, true);
>>>>> +
>>>>>            for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>>                struct amdgpu_ring *ring = tmp_adev->rings[i];
>>>>>    @@ -5228,8 +5228,12 @@ int amdgpu_device_gpu_recover(struct 
>>>>> amdgpu_device *adev,
>>>>> atomic_inc(&tmp_adev->gpu_reset_counter);
>>>>>        }
>>>>>    -    if (need_emergency_restart)
>>>>> +    if (need_emergency_restart) {
>>>>> +        list_for_each_entry (tmp_adev, device_list_handle, 
>>>>> reset_list) {
>>>>> +            amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>>>>> +        }
>>>>>            goto skip_sched_resume;
>>>>> +    }
>>>>>           /*
>>>>>         * Must check guilty signal here since after this point all 
>>>>> old @@ -5240,6 +5244,9 @@ int amdgpu_device_gpu_recover(struct 
>>>>> amdgpu_device *adev,
>>>>>        if (job && dma_fence_is_signaled(&job->hw_fence)) {
>>>>>            job_signaled = true;
>>>>>            dev_info(adev->dev, "Guilty job already signaled, 
>>>>> skipping HW
>>>>> reset");
>>>>> +        list_for_each_entry (tmp_adev, device_list_handle, 
>>>>> reset_list) {
>>>>> +            amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>>>>> +        }
>>>>>            goto skip_hw_reset;
>>>>>        }
>>>>>    @@ -5276,6 +5283,7 @@ int amdgpu_device_gpu_recover(struct 
>>>>> amdgpu_device *adev,
>>>>>            if (r && r == -EAGAIN) {
>>>>>                set_bit(AMDGPU_SKIP_MODE2_RESET, 
>>>>> &reset_context->flags);
>>>>>                adev->asic_reset_res = 0;
>>>>> +            amdgpu_fence_driver_isr_toggle(adev, true);
>>>>>                goto retry;
>>>>>            }
>>>>>        }
>>>>> @@ -5711,6 +5719,8 @@ pci_ers_result_t 
>>>>> amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>>>>        set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
>>>>>        set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
>>>>>    +    amdgpu_fence_driver_isr_toggle(adev, true);
>>>>> +
>>>>>        adev->no_hw_access = true;
>>>>>        r = amdgpu_device_pre_asic_reset(adev, &reset_context);
>>>>>        adev->no_hw_access = false;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> index 8adeb7469f1e..65a877e1a7fc 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> @@ -287,15 +287,11 @@ bool amdgpu_fence_process(struct amdgpu_ring 
>>>>> *ring)
>>>>>        if (unlikely(seq == last_seq))
>>>>>            return false;
>>>>>    -    last_seq &= drv->num_fences_mask;
>>>>> -    seq &= drv->num_fences_mask;
>>>>> -
>>>>>        do {
>>>>>            struct dma_fence *fence, **ptr;
>>>>>               ++last_seq;
>>>>> -        last_seq &= drv->num_fences_mask;
>>>>> -        ptr = &drv->fences[last_seq];
>>>>> +        ptr = &drv->fences[last_seq & drv->num_fences_mask];
>>>>>               /* There is always exactly one thread signaling this 
>>>>> fence slot */
>>>>>            fence = rcu_dereference_protected(*ptr, 1);
>>>> Those changes here doesn't seem to make sense. Please explain 
>>>> further why that is necessary.
>>>>
>>>> Christian.
>>>>
>>>>> -- 
>>>>> 2.25.1
>>

