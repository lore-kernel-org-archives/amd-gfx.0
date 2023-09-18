Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C74EC46CA1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Sep 2023 16:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F15E10E07D;
	Mon, 18 Sep 2023 16:11:12 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1ACB10E07D
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 16:11:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gynBvt5r4BotZqVRhpn4cdUcc1k1NwfjRcGApBlqSriUrS2YJBFYQ+F50sRsvfDZWF1wmoyx3zzmnIiNK3cpGXdeKOdkYiZ+0U1GxmoRAeaKU2ys1AWa4c5dHlN2N6JhfS7V+UOqhPm9pkitp1COTUErR6fsbX0v019sDd6fj52IWFl8hEeGsr2GM9xhu4uc00mT2kst3q+Y7DTGziM0NDojw6IiO0GXrfzEeU8fDKpx8fo6w2aiW+vml/187zNrsj6qs4weQiZ7/kaLuoX3JzGKmAkoWSLPScEbvDGTUdYAWUfDDfQ1oqm4XF4UpYD4X3zqx/qR6ndATCceTuuLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idYihcKidHGj/LWDzJeAWNnlmqclqcv4kGi+AtuuL9Y=;
 b=gWaDDWKjHKTI2pK8U02rE+r8/pnNAEYzhAA3UK1Qx7QRJdDLsrfobFUNkd3vvTv/lqUxtr76fnA+PLpGDe0lj0yqJpAx6fCgi4zaxYYnXh2PRkBqHQQ9691jTk/ia/xwcmSVZHeDAaSibEKVzv3tTONViutQIOEb6fLs4+z7NlTC2aW9aW3tAUHTlJzrTqPBnChfcWbIaUc6ZvE6TYZJj1GUQEayLQbB7kXHRrflYzeIC47uo+MZthnPo3wzBK6oGiJeRlrfc/DWLKUHZlZRMm9AdCXYTm3xh6XjQbtzZ2oMgIz/YkUiThQwdikj5QYiJUJGZ3RbPsHrVYpk0AkDng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idYihcKidHGj/LWDzJeAWNnlmqclqcv4kGi+AtuuL9Y=;
 b=5t3VHEhvqMst2Gv7S8IlI/+8v4c7dDApiWVABe5fCZCD2TVH2cgNT9PHOdgCkbIhmrlXZSujwImGKCWyPSCVpvzIFpJjy7ONBWkpQRQmG5BsE4k6dQxxi37pMAIY0n23bqELuVPmxAoEczEteiRtsv6uBoSwe6SRtV/1ugD1pkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB7530.namprd12.prod.outlook.com (2603:10b6:208:440::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 16:11:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 16:11:06 +0000
Message-ID: <cc3c54d9-e68e-dc98-843b-de059ab97571@amd.com>
Date: Mon, 18 Sep 2023 12:11:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: Use gpu_offset for user queue's wptr
Content-Language: en-US
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>
References: <20230915025213.2463291-1-YuBiao.Wang@amd.com>
 <81a73442-2d27-eab8-4dec-cb1a6d179ab3@amd.com>
 <f82d33ef-3ace-0b74-04ab-9ce646dfb0bb@amd.com>
 <DM6PR12MB30353CCF8557B6F8C9A80E87E5FBA@DM6PR12MB3035.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <DM6PR12MB30353CCF8557B6F8C9A80E87E5FBA@DM6PR12MB3035.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0220.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: d76f9a96-9312-40c3-b295-08dbb861dcf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /58CDGPZT8jQqmPu694++SLl4N0AYn8YurXDbiPhKfp53SoRgHXmlCJTr5x7geAORPUPMc1s+neARFNesFH0uwrXRO0Pn5D2fIIuV7QrSiArMQDbH28p3QNNSkbGZY5i9cL15BMfKldokO3XKhAmF/4PEksOLkeNg/vF/rae9Q9q8hjPR5cxt0M9OdOg2dt+j84y+GV4qZ7oA0Ku9hkq8nrWcD8+undhQ/ghNmciiQHTeATGDOnJYyGqG5/labVN07XP8EVEM+X5FAt+w+9cGzHXwkEPpVfa7GX58h/7Z+2c46iDZkCIOYlCFS/8r4jovFaDSIOsuUL2XsX20VRRFBq/AC1MFJhThreg54bDWYouOr/O2LFOG+0xqQiaozUsBev4QAdu0dXkaecX36YyTrwQBXYLYXYGBIKMCuehSgHm4dP/Mhw0OWdwaAQOPcg6oxyLzXGDjmY7cnir4i0R8xA14/XC+3JUcwUo+CWsbM9W5ERzvbWhdy0LhxFHiYD8dGRIrNzkLtk8sOLsad42jZnoU5b3RNOnsTPwA18AZ/hmZJsy5myeRCATZflfSTvyq0QwwJpQJs9JnzG9H6ZqL07yB9LGYhlt/55TlNBwdnxgkiHhKH7ev68sDHIIuv6WsOep7kIzk+BYCxUWjh05tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(39860400002)(366004)(346002)(136003)(1800799009)(186009)(451199024)(6666004)(6506007)(53546011)(6486002)(6512007)(478600001)(26005)(2616005)(66574015)(2906002)(44832011)(66476007)(54906003)(6636002)(316002)(66946007)(66556008)(110136005)(5660300002)(8676002)(4326008)(8936002)(41300700001)(36756003)(86362001)(38100700002)(31696002)(31686004)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGVaV1pvbThXc0F4dGVOZGhjNjc0c245VVZYTGwyeFVvRy9YSDZ3RW9RTkNq?=
 =?utf-8?B?UlpjZmRsZVF6ajFzWFZSME9oSUF3V0xuTlVZT1J2d0lzWXpMUThpKytlZ3JJ?=
 =?utf-8?B?VWFKVXNnWlBOSVZZcHhOS0d1TFo2K2ZIMXN0UEhWREdJSWdlc0dld0szd0hK?=
 =?utf-8?B?dUxpRUxnZGNNWlQ1K0xQd1R5L09JeG45UDExVXkwOVRNdzB4WEEzVUlEQ2Zo?=
 =?utf-8?B?d0hqYk5ibytqS3YveFVmSDdDZlA1RXg3bVFpQjlvd3d2Q2tMQzBxdjc2Z3FW?=
 =?utf-8?B?eldEci9sZXBpQUxoS3pHcWV6elBxcXJvUkg3M3dieG1LNGtCQW5UcUVJQUZK?=
 =?utf-8?B?OWx4S1B6SUQxeHJGZktON2lWNUd1MUFFd1NreTRiS3VCZURyOFpoQ1VEeTZM?=
 =?utf-8?B?Y3I5YnNvMGY2N1Q5VXF4L0hSVlJaS1UwUnZVamo0ZlB3a2VtMzBBVE1LeSs1?=
 =?utf-8?B?cmsyaWZIK281VEM3cWIxZ3lkYTR0dkxycGlmcDBjc2xoUm5aWW9CZTJUa0tx?=
 =?utf-8?B?UHJLM0k5NGhBREtabS9aMEJlYVdoN2xnN2ZTZjFIMjZNUGpmM1ZERzFySW5i?=
 =?utf-8?B?dkJoY1lDL1RjaXBHUGRET0lTNWNJNkpPaGE3N1M0SlpJdU1YRnI0djAvUDhG?=
 =?utf-8?B?WTVGcVp4dU9lWU5PVVVPYUJHQW9tVXlQUHFQTTJHWEtvd1dSWkZmTk5LY1JG?=
 =?utf-8?B?L0p5c0hOdWxQU3hXcTNkR3lBYzdHSXUzalJjK3hqbmpBV3p4WVlPdnJkeHZt?=
 =?utf-8?B?Z0V1dGNrUW1YYTM0cGtZay9kWjZzUXM0ejFjOTZ6dllCejdyMEZYRlgyb3J0?=
 =?utf-8?B?S1BOZ0V0dmFmRFZUT0h0STFMa2xkZXRnZkh6ZkdNYS92c0NxajJ1bi9WM0Mv?=
 =?utf-8?B?d2hRbWZ6Q2g2c0xKM1J6S0J4VHhENUJRV1pjV3lYREJxWXVxd0pqbXhrQ1B3?=
 =?utf-8?B?b210M09kaDBhWUF6TmlGM3VocUlja29GclFpL1JIbmN0OTlRZm1YalNJaVpn?=
 =?utf-8?B?bThQclFuQ1FmZVR5Y0J4TTdtU2RmaUJWNmFnd2NTRXltODRGZTNTQnRGN0xr?=
 =?utf-8?B?bTRSTG1ZTzhXZ2ZFNUJCa2ZlSkVMNWRpK1lSdFd3V3F3c0NaYlZpVFB2YXp0?=
 =?utf-8?B?WFlPK2FHZFpFeExMMkJWU0hueVBYcEN6SU1NRVVraEwxc21YdndPMk5ZT1Bn?=
 =?utf-8?B?Nk9kZ2g4dEtCNnBydWNSOXIxckNwZFpZekZycTJjTkhKemNETzV3MDBleVFY?=
 =?utf-8?B?L0kwMjB6QjdzS004Z0J6YnVCdFRvRWJPcU1abUowYm1BU2dheHVSVGYzbVZx?=
 =?utf-8?B?NXNoTnVRdkZJTzdUTXU1UUF6R2dGRHNPYTYzNkJQMVlPNDhxZ0d3ZEx3MW8w?=
 =?utf-8?B?cVMvdWRnREthZlFRSHU1cUJDN2VScDRqOFJHQ0IyVnc4OWU4NkxaQmFMaWdR?=
 =?utf-8?B?YWZ6alhaemMyVmxzQWE4VjZqdWFLaFJoZkR6YWlpVzVyMENGQTE0SDJwNDE5?=
 =?utf-8?B?cGFsSEk0N0tXck94eVpXdjN1TUZaZUQ2NWVZQS9yWmw5QWJNeUgxRVdrVzNE?=
 =?utf-8?B?bHY5WmVRVzUvckZLOGtjTWt2aDNJSVpXV0JGWlZDd3E1eEloVHFQRXpVSXdN?=
 =?utf-8?B?VWhnUjlUeXl4NHRaaGk1Q0VYbFU5UzVmMkIwOTJMSFhjQzVONUJTOEZEYWp6?=
 =?utf-8?B?bnJRQm1uM1JGazlhUThTNkxzWlhwUkxJQy8xcXA3NkRFalJlWXVkNDRzb2FY?=
 =?utf-8?B?NEhtTWhtWFNyUmFHZVBSVzFVQk9ibUE4R3ZPVDFBNzc4STJYYmpKSUUyZEVk?=
 =?utf-8?B?TkNONHY2V2RETE1kL1NEVjJaekpSb3k0aXF3L05MV3R3SGtvRld2RTA3VUhh?=
 =?utf-8?B?SjZpNW1Fc2pyN1ZmSFJhcGw5Skl2S0xsVUsvTk5QaGMrRTM4cGlXbm9iYXVR?=
 =?utf-8?B?RElITnplNEFQOTBuM0dCR29BRHhwMkpwc1N5R3d3US9Lc1U4OEVtOU5vNWdw?=
 =?utf-8?B?TWR4MkhmK0xmOEtJak1DVmFwVkprRUNTOXJUWGRscXdIamFqTFZsNlQ3Ui8v?=
 =?utf-8?B?YTZRcytsRjExMEphWXB3SUVaWlFFWlFHRjkzQW9jbXdHSUNDWHRkSkVxNDlT?=
 =?utf-8?Q?M0G7FNwHyUUzps2goLx3/COqT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76f9a96-9312-40c3-b295-08dbb861dcf8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 16:11:06.3601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oEXAZN5Lh51Tj4/6bRSTeDn3OkqOg3AveZZeCu2ciu2j0NjHf8497ISKj/MNFGTuR+v7KZihxqulJpsUUhn/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7530
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-09-17 22:14, Wang, YuBiao wrote:
> [AMD Official Use Only - General]
>
> Hi Felix,
>
> Yeah, I believe that we were always set gart domain start as 0 before.

Thanks for confirming that. The patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Regards,
> Yubiao
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Friday, September 15, 2023 10:54 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Wang, YuBiao <YuBiao.Wang@amd.com>; amd-gfx@lists.freedesktop.org; Sharma, Shashank <Shashank.Sharma@amd.com>
> Cc: Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Kevin Wang <Kevin1.Wang@amd.com>
> Subject: Re: [PATCH] drm/amdkfd: Use gpu_offset for user queue's wptr
>
> On 2023-09-15 2:50, Christian König wrote:
>> Am 15.09.23 um 04:52 schrieb YuBiao Wang:
>>> Directly use tbo's start address will miss the domain start offset.
>>> Need to use gpu_offset instead.
>>>
>>> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
>> Felix and/or Shashank should probably take a look as well, but of hand
>> that looks like the correct fix.
> Looks reasonable to me. Why did this not cause problems before? Are we just lucky that the domain start offset is 0 on the GPUs we've tested so far?
>
> Regards,
>     Felix
>
>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index 77159b03a422..36e7171ad9a7 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -216,7 +216,7 @@ static int add_queue_mes(struct
>>> device_queue_manager *dqm, struct queue *q,
>>>          if (q->wptr_bo) {
>>>            wptr_addr_off = (uint64_t)q->properties.write_ptr &
>>> (PAGE_SIZE - 1);
>>> -        queue_input.wptr_mc_addr =
>>> ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) +
>>> wptr_addr_off;
>>> +        queue_input.wptr_mc_addr = amdgpu_bo_gpu_offset(q->wptr_bo)
>>> +wptr_addr_off;
>>>        }
>>>          queue_input.is_kfd_process = 1;
