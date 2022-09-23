Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C225C6FA82
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 11:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8978210E88F;
	Fri, 23 Sep 2022 11:23:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 500F010E84E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 11:23:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO6y8V/UjQL5GLlMtSi5QIGCW2EdyXO2nOipsg4YoaFShmqfJ/DsNyI7/Trj3ZLNnJQQ/pHMfwGoTiktc8TjSq3qX232Yx7b8q6v0ONTWW+7yOW38I3YZZYzjq+nZtmH2Tbt0V3SmIr6iQCUvnLZ5VSTxfTNniIkBld+Wy2EX4gwCncJRWUvLUgj/ibXUoV+CGXiKVG/hcIFKo+vOIJ+oxbs/DfxomFsqlcsgGXb8pnblEAKfVqZKxha5o09dMQYOVyN53adJ0sUeS3IGTTxoxBLyMVPJlakho2vSTFXoOysJbVl24cIcu91k0VgkRKtaBlpk6dxkljSB60TZYZidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZM3tlXPDuM4s4qze5GpkVv/GmbDiw3vZuZRo7vYmno=;
 b=nGnoNrOI+2F2H9BYW9R9FeFMhxvmwRH5WfSLC/rFojPiqIfXQLe9PyJb392GLED8mQ+dRRlUCJoi6Xv6N92U1jRKzdIzFB7udl/X3nUb1sxGtowC0Vkq2nkm4mNAVqBeo4iuh3qxBq94fgs5VoDAkjOXmCEmow+l+SFVLSVnJDvrOGQWKrYb2+0+IxiNlk+W8PBQ1I0bm+pqEX5naTUD+10gSPHfA2KPaS/tHy86GJfGTAG2iL8w6PP736eZgwRlv0XERnEN0z/J1g9963E5CQmy7uzv3zutIPJkwoHrJQSHCO+8cBW31c4iYS2fZGWsiVRsQWcpuN3GtR2CCXiL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZM3tlXPDuM4s4qze5GpkVv/GmbDiw3vZuZRo7vYmno=;
 b=Vnq4H9Tm+9uaUO38Sj6yWtC68/aUOhqn9JuPa2+JnSqmnvukRW6dSlR+79Auy1lD0LYzbWLOTeXu1n88DHs1fIuDjhpUd0Lu+oNGy1erYRkOCT5yboXecpQpcY4gJFlxVviQ81aevTyrf6ZHoBPkvz1+kxUpw4my6Ly3TFN0HFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 11:23:20 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 11:23:19 +0000
Message-ID: <c173fa11-1f9a-62ef-7b01-41daf4acb766@amd.com>
Date: Fri, 23 Sep 2022 13:23:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/5] drm/amdgpu: Implement OS triggered MCBP (v5)
Content-Language: en-US
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220921094117.1071106-1-jiadong.zhu@amd.com>
 <20220921094117.1071106-4-jiadong.zhu@amd.com>
 <14ab09ae-0a80-1702-f446-4fc32681ff8c@amd.com>
 <DS7PR12MB63330816ABCBFBBF4A94C622F4519@DS7PR12MB6333.namprd12.prod.outlook.com>
 <af86b904-2966-5650-6bb2-ac3e0bd6bc31@amd.com>
 <DS7PR12MB633345FE5F53E5B667554F46F4519@DS7PR12MB6333.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB633345FE5F53E5B667554F46F4519@DS7PR12MB6333.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0402.eurprd06.prod.outlook.com
 (2603:10a6:20b:461::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA0PR12MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2e72b3-0af3-4d9f-05b8-08da9d56049e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qUXfxdDe+7TtJ8t9Sqg9RJ8aXDMoF2iLh3COP9C/qkPhUUeHt5VAi7UXaNYeFHU0qi83wIz6PnYoEGB6jAiiQvkO80Wk4PWWRrI9SK11sLAtkRnnwDndIo3F8AuClv40OKYUm7K/14eeD6xD9jMOwJRoHSp6BUUe0PY6EWjwjj3yPHxz7XQaWynSZaxi7tuVLqysJNxPLbNBRLGgY6u8tpaMCQcMNLq7kWeBcLUWTKqttHOumBOPzHRvsraQqylr45AFwHtsICdy5NhPLnYwbB2j0G5osOU5h7wob0rO7cazMIo0SIX36MOW0l62Pevau2Huc27sUywEJCwBn6SR0tUr6iQrjGvtAC621pL1u9Rr2/WAHFYfeOVdTs9DFn+EWgJUtsMeMq6Z2y9bbejBfwrkWyKHV1MTRTyMC1NzSu2Za5zdCeR0XAxqmnUKtlzuwRtVM/KvQ751zUvWuweP3uSj7q2rbEJeTM8WbHpIx4uC63FK2xYrL93OIna7D8Z9KsN68Fow47XC3q1Bj6p9tXRup7uErFfJJUVknVNOWs5VLl0BSgZAHUSp44PnBA7e93hUsmDo2nBZh/Cb/+0fV08In1qQzXf2UJR4YfXHTRySzpo8guy2Nakjq8jlUMJ9Ed0f+jtBVXV9hdgdVR6mMoXOtdVkj88BKsMR9OmjhjQU68BE8SF2rYWRR23X6tbkUPuifIIIT0xcDlAE9LAhdW81CmlpYAvqkStf2lh4ifxdYJufLEi5IqQx5TiiPDkCtgk50d8ivfG+5GwQ7o6+Buen/2x+Wi/CZf7Ciz6j3n8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(6506007)(6666004)(6512007)(41300700001)(66556008)(66946007)(53546011)(4326008)(66476007)(478600001)(6486002)(8676002)(86362001)(316002)(54906003)(38100700002)(83380400001)(2616005)(186003)(31696002)(110136005)(66899012)(31686004)(30864003)(36756003)(5660300002)(2906002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elhuMXhxcFNscm4xazdoU0xZc1FJYW85cFU3M2cxVkRvQ3BLVlkxcTN1SGtC?=
 =?utf-8?B?andHc015ZlVQbGdzUndDY1FZd1A2OXhpUVRzUi9WMGRGcElEZ0pERGJ1TkY5?=
 =?utf-8?B?eVFmMDArZnh0M2FkQWdVdE1EUktWRCtJbzB2WDVXZWZTOTdaR21IcmN6U2tz?=
 =?utf-8?B?cC9EV054VEcvdDREcDgzQ21iaHJaM094QjVwdFFkaWhXUzNlbFhRYmxQNnMr?=
 =?utf-8?B?VnhHRHVqOWd3TWZPVUpFNks5eXQybmphNmVWaVp0YjRoTVBjMEhURlFqdkJI?=
 =?utf-8?B?cCsxajFCNkxBY0tMQmo1dm9CTEJRRU51ZlR1OG1SS0FwV1VoT0J2ODkvWlRX?=
 =?utf-8?B?aUxDVXRRS29IVzdZRm94SStMRWZFK1ozenR5QW5WYTBicWlUdVF5UnBXd1F2?=
 =?utf-8?B?Z0ZYUnliT05BYUovZGdreVNNMkZwMUdFdzlVU1ExRmRST3Q4a3NCNEl4YUha?=
 =?utf-8?B?SVgvYjBQT2I2Z2h0b2lYalB5QkE2bnZKM1VJVTZaN2Q5UVl2dTJ3dVB4S1g4?=
 =?utf-8?B?ZEFTeDVyNndiK1NmN0VtOWxyOEthKzIvcFNpbDNHNWZsbU1FWFVkQnpXVlJE?=
 =?utf-8?B?Zmt2b1pieW5VM2oxZUc5NjF3VFNHaE8rMFpiQnkrc3FqZld3UzJ5R0JDM3pP?=
 =?utf-8?B?ekttY3J1YVBsTXZEMW9NcFBtZmVRdzVIdnM3RTZxZm5ZTjNOVjJlcE1PR0l0?=
 =?utf-8?B?bFBiRHoxQWxObzF4ZlVaeFFvUCtocFN0WUplWTZZbCtlRmo1YWtIWTNwVDFT?=
 =?utf-8?B?cVdVanFFYi9MYmh0YUVpMUtScXhzU1M3TFVBVGtFMUJ2YXlZU1N6TWxqNnJ4?=
 =?utf-8?B?aVdZcmk5ODVMeVgxTGNpZGxYdjhXMm9VOGlHK1ZXbUo0Z3FSbEdHVWtkSVdL?=
 =?utf-8?B?M2xLVEdyQmpaVlIzUy9qYmlzU3NJbm4weUwvSnZBKzIwaXlRN2I4cXZObDlr?=
 =?utf-8?B?WXNwbytWRFJnQmFJSFl0YzFiZDFsTXlKNmtBRHlkcjF2WGhValhHcVQ0Ny9a?=
 =?utf-8?B?RmtEQjBkeGJHSG9Db3RJRERzQ2xWK1V5K0VhRTY4dDR5N2NpeUZWWlFERHNz?=
 =?utf-8?B?V2tpSUZCVDhtL3VPNTBTekw3ck5ibzdIYVpMQ0pwdDEyOEI2ZW1EejhJd3Qv?=
 =?utf-8?B?dmNWY0Znc2lnRjA4Y2V2M3VYWVF6aXlOYTVkSFFzeVZJQVBNc0dMaWFmVHFi?=
 =?utf-8?B?U28yWGFpODlVVWE2OVRBQ1dCQUJjWDdPQWRwOWRUVWlYUVZjTHhxdFFyWWRL?=
 =?utf-8?B?N0sxSzFTOWo2TUVDcWIwaVdTa2VnM29SYzVVYTFxNEFHMllUa3BPY202b0Rk?=
 =?utf-8?B?QXBPeEZ2ZHBSaDAzV2R5R3RybXFCdmRQTEJpYSt3YWM2c2JPa0NQV1JwMDJ6?=
 =?utf-8?B?Qkh0ZnRMeFpiLy9MYmdYL1BXd25kditqQ3FrVHV3ZFpFWUJDK0VOQmtuSUJ4?=
 =?utf-8?B?aUUxSWpBRWZjeXV0YTd6VCtoSWZod1FJYzh4U3FLV3h1VFpDM3NsaTZyZ2Rv?=
 =?utf-8?B?WU9Wdlk4dVpJaDI2VHNSUCs4c1E1bi9Eb3R3VEJmVjBwcWdXbVc4cVJuTjB3?=
 =?utf-8?B?TFI0UkZYN0t1VG43TzJNMHoxOEJmRFJ0T3N0dFdWQXJDSHVGWU9JU3hYZHJl?=
 =?utf-8?B?em9mREViMTJub2crZmpSa0g2V2lQZ1RUaktCUDRzcldoL1RvRlJzU3hldjNs?=
 =?utf-8?B?VkNpVFpxNnJhc3FZQ3BJejNkcmZUTE5pT1psa2s2U1JTTjNBamo4U0RReG8x?=
 =?utf-8?B?ZzBJb0lHMTc4V05sRXdpY3pZTDYvT3pNaG1HaFVOQXplTEN5VXZxRFlxQUkx?=
 =?utf-8?B?S0szbUVrczVMS0RFTFh4MVNDY0JhdVg5RXUzMHNGU0YrWWs5NUNEb0QvSTln?=
 =?utf-8?B?a1FsdUVZS2s4dnBiRmFzNm5qWkdLL3g3R0JQSVZER3YzalFFd2tvSDc2R3Bj?=
 =?utf-8?B?MjBUTFgxekRGYlpYbjY0OUtIYlBoY2NtejlYOEp2NFR1OFo0V0kxd3NQSzlY?=
 =?utf-8?B?b3A0bG82ZDNsZjJBblh0R0RXbjRMZW5hWi92YTBkYklsRmxlWVdVWWNDK0xo?=
 =?utf-8?B?NWZXemJhV0UxM3puQ2RvUGRrT1JneVE2RjM4ZVM0QW5lM0t5aWh3UUpjODQ5?=
 =?utf-8?B?OEZhamhETzVlcUlpU2ZYcnF1YnhmbnZFdmtzZHNjeG5UVVRtR3VUNHJxNlFX?=
 =?utf-8?Q?2grDTWn2/ypACdAZ0TbDrZ20E9rBpdi4ZP2J9ENUUH4W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2e72b3-0af3-4d9f-05b8-08da9d56049e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 11:23:19.8903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pagJ/JYgnqZJTBPs+8jT9gt0jpAaPOjlGix8CCx/UihQgIF02bK30HCBkgulYNIh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.09.22 um 12:51 schrieb Zhu, Jiadong:
> [AMD Official Use Only - General]
>
>>> +     return need_preempt && !mux->s_resubmit;
>>> Well what exactly are you trying to do here? Finding if a lower priority ring has unsignaled fences?
>> Yes, we are peeking the fence_drv data at the time high priority ibs are going to emit. The result is not necessarily accurate because we would check the fence after preemption complete.
>> Please use amdgpu_fence_count_emitted() for this instead.
> amdgpu_fence_count_emitted calls amdgpu_fence_process in it.  We are in high priority ring schedule task while calling amdgpu_mcbp_scan, amdgpu_fence_process on both rings might lower the performance.
> Maybe we could add a function in amdgpu_fence.c to count_emmited without amdgpu_fence_process?

Good point. This also not only lowers the performance, but is 
problematic for correctness since dma_fence won't signal from the 
interrupt handler any more.

Yeah, feel free to remove the call to amdgpu_fence_process() from 
amdgpu_fence_count_emitted() in a separate patch.

>
>> Also what is the check of s_resubmit state good for here?
> The resubmission happens on the low priority ring shed task. Thinking of the situation that two high prio ib requests from high priority calling amdgpu_mcbp_scan, we don’t want to trigger preemption twice when low priority ring has not resubmitted packages.

Mhm, I'm not sure if we should complicate things like this and rather 
just use a fixed low and high priority ring.

So the flag basically means that some low priority work as still 
preempted and waits for re-submission?

Regards,
Christian.

>
> Thanks,
> Jiadong
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Friday, September 23, 2022 6:13 PM
> To: Zhu, Jiadong <Jiadong.Zhu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Subject: Re: [PATCH 4/5] drm/amdgpu: Implement OS triggered MCBP (v5)
>
> Am 23.09.22 um 11:24 schrieb Zhu, Jiadong:
>> [AMD Official Use Only - General]
>>
>> Inlined.
>>
>> Thanks,
>> Jiadong
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, September 21, 2022 9:01 PM
>> To: Zhu, Jiadong <Jiadong.Zhu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Grodzovsky, Andrey
>> <Andrey.Grodzovsky@amd.com>
>> Subject: Re: [PATCH 4/5] drm/amdgpu: Implement OS triggered MCBP (v5)
>>
>> Am 21.09.22 um 11:41 schrieb jiadong.zhu@amd.com:
>>> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>>>
>>> Trigger Mid-Command Buffer Preemption according to the priority of
>>> the software rings and the hw fence signalling condition.
>>>
>>> The muxer saves the locations of the indirect buffer frames from the
>>> software ring together with the fence sequence number in its fifo
>>> queue, and pops out those records when the fences are signalled. The
>>> locations are used to resubmit packages in preemption scenarios by coping the chunks from the software ring.
>> Maybe change the subject a bit. The MCBP is not really triggered by the core Linux kernel.
>>
>> Maybe write instead "MCBP based on DRM scheduler".
>>
>>> v2: Update comment style.
>>> v3: Fix conflict caused by previous modifications.
>>> v4: Remove unnecessary prints.
>>> v5: Fix corner cases for resubmission cases.
>>>
>>> Cc: Christian Koenig <Christian.Koenig@amd.com>
>>> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
>>> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
>>> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
>>> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c       |   2 +
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c     |  91 +++++++++
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h     |  29 +++
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     |  12 ++
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 186 ++++++++++++++++++-
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  24 +++
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  |  27 +++
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c       |   2 +
>>>     10 files changed, 372 insertions(+), 6 deletions(-)
>>>     create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
>>>     create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> index 85224bc81ce5..24c5aa19bbf2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> @@ -59,7 +59,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>         amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>>>         amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>>>         amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>>> -     amdgpu_sw_ring.o amdgpu_ring_mux.o
>>> +     amdgpu_sw_ring.o amdgpu_ring_mux.o amdgpu_mcbp.o
>> This functionality is spread over to many files. Probably better to move this into the amdgpu_ring_mux.c as well.
>>
>>>     amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> index 258cffe3c06a..af86d87e2f3b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> @@ -211,6 +211,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>>>                 }
>>>         }
>>>
>>> +     amdgpu_ring_ib_begin(ring);
>>>         if (job && ring->funcs->init_cond_exec)
>>>                 patch_offset = amdgpu_ring_init_cond_exec(ring);
>>>
>>> @@ -285,6 +286,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>>>             ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
>>>                 ring->funcs->emit_wave_limit(ring, false);
>>>
>>> +     amdgpu_ring_ib_end(ring);
>>>         amdgpu_ring_commit(ring);
>>>         return 0;
>>>     }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
>>> new file mode 100644
>>> index 000000000000..121b1a4e0f04
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
>>> @@ -0,0 +1,91 @@
>>> +/*
>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person
>>> +obtaining a
>>> + * copy of this software and associated documentation files (the
>>> +"Software"),
>>> + * to deal in the Software without restriction, including without
>>> +limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>> +sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to whom
>>> +the
>>> + * Software is furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be
>>> +included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> +EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>> +MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
>>> +EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>>> +DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>> +OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
>>> +USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +
>>> +#include <linux/delay.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/firmware.h>
>>> +#include <linux/module.h>
>>> +#include <linux/pci.h>
>>> +#include <drm/gpu_scheduler.h>
>>> +
>>> +#include "amdgpu.h"
>>> +#include "amdgpu_mcbp.h"
>>> +#include "amdgpu_ring.h"
>>> +
>>> +/* Trigger Mid-Command Buffer Preemption (MCBP) and find if we need
>>> +to resubmit. */ int amdgpu_mcbp_trigger_preempt(struct
>>> +amdgpu_ring_mux *mux) {
>>> +     struct amdgpu_mux_entry *e;
>>> +     struct amdgpu_ring *ring = NULL;
>>> +     int i;
>>> +
>>> +     spin_lock(&mux->lock);
>>> +
>>> +     amdgpu_ring_preempt_ib(mux->real_ring);
>>> +
>>> +     for (i = 0; i < mux->num_ring_entries; i++) {
>>> +             e = &mux->ring_entry[i];
>>> +             if (e->ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
>>> +                     ring = e->ring;
>>> +                     break;
>>> +             }
>>> +     }
>>> +
>>> +     if (!ring) {
>>> +             DRM_ERROR("cannot find low priority ring\n");
>>> +             spin_unlock(&mux->lock);
>>> +             return -ENOENT;
>>> +     }
>>> +
>>> +     amdgpu_fence_process(ring);
>>> That's usually and extremely bad idea since fence processing should only be kicked of from the interrupt handler.
>>> Otherwise you have interrupt handler and this thread here racing to signaling fences.
>> We have to block low priority ibs copied to the real ring and check the seq no signaled here.
>> I will refactor to use the trailing fence irq to handle this.
>>
>>> +
>>> +     if (atomic_read(&ring->fence_drv.last_seq) !=
>>> +         ring->fence_drv.sync_seq) {
>>> +             mux->s_resubmit = true;
>>> +             mux->seq_no_resubmit = ring->fence_drv.sync_seq;
>>> Don't touch any fence handling internals here. If you need to know
>>> which fences are signaled and which aren't look into amdgpu_fence.c
>> I would use amdgpu_fence_count_emitted in irq hander to meet this.
>>
>>
>>> +             amdgpu_ring_mux_schedule_resubmit(mux);
>>> +     }
>>> +
>>> +     spin_unlock(&mux->lock);
>>> +     return 0;
>>> +}
>>> +
>>> +/*scan on low prio rings to have unsignaled fence and high ring has
>>> +no fence.*/
>> What exactly should that comment mean?
>>
>>> +int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux) {
>>> +     struct amdgpu_ring *ring;
>>> +     uint32_t seq, last_seq;
>>> +     int i, need_preempt;
>>> +
>>> +     need_preempt = 0;
>>> +     for (i = 0; i < mux->num_ring_entries; i++) {
>>> +             ring = mux->ring_entry[i].ring;
>>> +             last_seq = atomic_read(&ring->fence_drv.last_seq);
>>> +             seq = READ_ONCE(ring->fence_drv.sync_seq);
>>> +             if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT && last_seq < seq)
>>> +                     return 0;
>>> +             if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && last_seq < seq)
>>> +                     need_preempt = 1;
>>> +     }
>>> +     return need_preempt && !mux->s_resubmit;
>>> Well what exactly are you trying to do here? Finding if a lower priority ring has unsignaled fences?
>> Yes, we are peeking the fence_drv data at the time high priority ibs are going to emit. The result is not necessarily accurate because we would check the fence after preemption complete.
> Please use amdgpu_fence_count_emitted() for this instead.
>
> Also what is the check of s_resubmit state good for here?
>
> Regards,
> Christian.
>
>> Regards,
>> Christian.
>>
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
>>> new file mode 100644
>>> index 000000000000..0033bcba8d03
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
>>> @@ -0,0 +1,29 @@
>>> +/*
>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person
>>> +obtaining a
>>> + * copy of this software and associated documentation files (the
>>> +"Software"),
>>> + * to deal in the Software without restriction, including without
>>> +limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>> +sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to whom
>>> +the
>>> + * Software is furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be
>>> +included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> +EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>> +MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
>>> +EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>>> +DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>> +OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
>>> +USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +
>>> +#ifndef __AMDGPU_MCBP_H__
>>> +#define __AMDGPU_MCBP_H__
>>> +
>>> +int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux); int
>>> +amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux); #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index 4eaf3bd332f7..94362c39b73e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -574,3 +574,15 @@ int amdgpu_ring_init_mqd(struct amdgpu_ring
>>> *ring)
>>>
>>>         return mqd_mgr->init_mqd(adev, ring->mqd_ptr, &prop);
>>>     }
>>> +
>>> +void amdgpu_ring_ib_begin(struct amdgpu_ring *ring) {
>>> +     if (ring->is_sw_ring)
>>> +             amdgpu_sw_ring_ib_begin(ring); }
>>> +
>>> +void amdgpu_ring_ib_end(struct amdgpu_ring *ring) {
>>> +     if (ring->is_sw_ring)
>>> +             amdgpu_sw_ring_ib_end(ring); }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index aeb48cc3666c..36726c28a806 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -312,6 +312,9 @@ struct amdgpu_ring {
>>>     #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
>>>
>>>     int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
>>> +void amdgpu_ring_ib_begin(struct amdgpu_ring *ring); void
>>> +amdgpu_ring_ib_end(struct amdgpu_ring *ring);
>>> +
>>>     void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
>>>     void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
>>>     void amdgpu_ring_commit(struct amdgpu_ring *ring); diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>> index d6b30db27104..70dd725432d4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>> @@ -24,30 +24,59 @@
>>>     #include <drm/drm_print.h>
>>>
>>>     #include "amdgpu_ring_mux.h"
>>> +#include "amdgpu_mcbp.h"
>>>     #include "amdgpu_ring.h"
>>>
>>>     #define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ / 2)
>>>
>>> +static struct kmem_cache *amdgpu_mux_chunk_slab;
>>> +
>>>     static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>>>                                   u64 s_start, u64 s_end);
>>> +static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux,
>>> +bool is_fallback); static void amdgpu_mux_resubmit_fallback(struct
>>> +timer_list *t);
>>>
>>>     int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>>>                          unsigned int entry_size)
>>>     {
>>>         mux->real_ring = ring;
>>>         mux->num_ring_entries = 0;
>>> +
>>>         mux->ring_entry = kcalloc(entry_size, sizeof(struct amdgpu_mux_entry), GFP_KERNEL);
>>>         if (!mux->ring_entry)
>>>                 return -ENOMEM;
>>>
>>>         mux->ring_entry_size = entry_size;
>>> +     mux->s_resubmit = false;
>>> +
>>> +     amdgpu_mux_chunk_slab = kmem_cache_create("amdgpu_mux_chunk",
>>> +                                               sizeof(struct amdgpu_mux_chunk), 0,
>>> +                                               SLAB_HWCACHE_ALIGN, NULL);
>>> +     if (!amdgpu_mux_chunk_slab) {
>>> +             DRM_ERROR("create amdgpu_mux_chunk cache failed\n");
>>> +             return -ENOMEM;
>>> +     }
>>> +
>>>         spin_lock_init(&mux->lock);
>>> +     timer_setup(&mux->resubmit_timer, amdgpu_mux_resubmit_fallback,
>>> + 0);
>>>
>>>         return 0;
>>>     }
>>>
>>>     void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
>>>     {
>>> +     struct amdgpu_mux_entry *e;
>>> +     struct amdgpu_mux_chunk *chunk, *chunk2;
>>> +     int i;
>>> +
>>> +     for (i = 0; i < mux->num_ring_entries; i++) {
>>> +             e = &mux->ring_entry[i];
>>> +             list_for_each_entry_safe(chunk, chunk2, &e->list, entry) {
>>> +                     list_del(&chunk->entry);
>>> +                     kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
>>> +             }
>>> +     }
>>> +     kmem_cache_destroy(amdgpu_mux_chunk_slab);
>>>         kfree(mux->ring_entry);
>>>         mux->ring_entry = NULL;
>>>         mux->num_ring_entries = 0;
>>> @@ -67,6 +96,7 @@ int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>>>         ring->entry_index = mux->num_ring_entries;
>>>         e->ring = ring;
>>>
>>> +     INIT_LIST_HEAD(&e->list);
>>>         mux->num_ring_entries += 1;
>>>         return 0;
>>>     }
>>> @@ -82,6 +112,9 @@ void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>>>     {
>>>         struct amdgpu_mux_entry *e;
>>>
>>> +     if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT)
>>> +             amdgpu_mux_resubmit_chunks(mux, false);
>>> +
>>>         e = amdgpu_get_sw_entry(mux, ring);
>>>         if (!e) {
>>>                 DRM_ERROR("cannot find entry for sw ring\n"); @@
>>> -90,13 +123,19 @@ void amdgpu_ring_set_wptr_to_mux(struct
>>> amdgpu_ring_mux *mux, struct amdgpu_ring
>>>
>>>         spin_lock(&mux->lock);
>>>         e->sw_cptr = e->sw_wptr;
>>> +     if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && e->sw_cptr < mux->wptr_resubmit)
>>> +             e->sw_cptr = mux->wptr_resubmit;
>>>         e->sw_wptr = wptr;
>>>         e->start_ptr_in_hw_ring = mux->real_ring->wptr;
>>>
>>> -     copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
>>> -     e->end_ptr_in_hw_ring = mux->real_ring->wptr;
>>> -     amdgpu_ring_commit(mux->real_ring);
>>> -
>>> +     /* donnot copy the ibs which have been resubmitted*/
>>> +     if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT || mux->wptr_resubmit < wptr) {
>>> +             copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
>>> +             e->end_ptr_in_hw_ring = mux->real_ring->wptr;
>>> +             amdgpu_ring_commit(mux->real_ring);
>>> +     } else {
>>> +             e->end_ptr_in_hw_ring = mux->real_ring->wptr;
>>> +     }
>>>         spin_unlock(&mux->lock);
>>>     }
>>>
>>> @@ -159,7 +198,7 @@ u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_rin
>>>         return e->sw_rptr;
>>>     }
>>>
>>> -/* copy packages on sw ring range[begin, end) */
>>> +/* copy packages on sw ring range[start, end) */
>>>     static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>>>                                   u64 s_start, u64 s_end)
>>>     {
>>> @@ -183,3 +222,140 @@ static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_rin
>>>                 amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start], end - start);
>>>         }
>>>     }
>>> +
>>> +void amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux) {
>>> +     mod_timer(&mux->resubmit_timer, jiffies +
>>> +AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT);
>>> +}
>>> +
>>> +void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct
>>> +amdgpu_ring *ring) {
>>> +     struct amdgpu_mux_entry *e;
>>> +     struct amdgpu_mux_chunk *chunk;
>>> +
>>> +     amdgpu_mux_resubmit_chunks(mux, false);
>>> +
>>> +     e = amdgpu_get_sw_entry(mux, ring);
>>> +     if (!e) {
>>> +             DRM_ERROR("cannot find entry!\n");
>>> +             return;
>>> +     }
>>> +
>>> +     chunk = kmem_cache_alloc(amdgpu_mux_chunk_slab, GFP_KERNEL);
>>> +     if (!chunk) {
>>> +             DRM_ERROR("alloc amdgpu_mux_chunk_slab failed\n");
>>> +             return;
>>> +     }
>>> +
>>> +     chunk->start = ring->wptr;
>>> +     list_add_tail(&chunk->entry, &e->list); }
>>> +
>>> +static void scan_and_remove_signaled_chunk(struct amdgpu_ring_mux
>>> +*mux, struct amdgpu_ring *ring) {
>>> +     uint32_t last_seq, size = 0;
>>> +     struct amdgpu_mux_entry *e;
>>> +     struct amdgpu_mux_chunk *chunk, *tmp;
>>> +
>>> +     e = amdgpu_get_sw_entry(mux, ring);
>>> +     if (!e) {
>>> +             DRM_ERROR("cannot find entry!\n");
>>> +             return;
>>> +     }
>>> +
>>> +     last_seq = atomic_read(&ring->fence_drv.last_seq);
>>> +
>>> +     list_for_each_entry_safe(chunk, tmp, &e->list, entry) {
>>> +             if (chunk->sync_seq <= last_seq) {
>>> +                     list_del(&chunk->entry);
>>> +                     kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
>>> +             } else {
>>> +                     size++;
>>> +             }
>>> +     }
>>> +}
>>> +
>>> +void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct
>>> +amdgpu_ring *ring) {
>>> +     struct amdgpu_mux_entry *e;
>>> +     struct amdgpu_mux_chunk *chunk;
>>> +
>>> +     e = amdgpu_get_sw_entry(mux, ring);
>>> +     if (!e) {
>>> +             DRM_ERROR("cannot find entry!\n");
>>> +             return;
>>> +     }
>>> +
>>> +     chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
>>> +     if (!chunk) {
>>> +             DRM_ERROR("cannot find chunk!\n");
>>> +             return;
>>> +     }
>>> +
>>> +     chunk->end = ring->wptr;
>>> +     chunk->sync_seq = READ_ONCE(ring->fence_drv.sync_seq);
>>> +
>>> +     scan_and_remove_signaled_chunk(mux, ring); }
>>> +
>>> +static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux,
>>> +bool is_fallback) {
>>> +     struct amdgpu_mux_entry *e = NULL;
>>> +     struct amdgpu_mux_chunk *chunk;
>>> +     uint32_t seq, last_seq;
>>> +     int i;
>>> +
>>> +     if (is_fallback) {
>>> +             if (!spin_trylock(&mux->lock)) {
>>> +                     amdgpu_ring_mux_schedule_resubmit(mux);
>>> +                     DRM_ERROR("reschedule resubmit\n");
>>> +                     return;
>>> +             }
>>> +     } else {
>>> +             spin_lock(&mux->lock);
>>> +     }
>>> +
>>> +     /*find low priority entries:*/
>>> +     if (!mux->s_resubmit) {
>>> +             spin_unlock(&mux->lock);
>>> +             return;
>>> +     }
>>> +
>>> +     for (i = 0; i < mux->num_ring_entries; i++) {
>>> +             if (mux->ring_entry[i].ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
>>> +                     e = &mux->ring_entry[i];
>>> +                     break;
>>> +             }
>>> +     }
>>> +
>>> +     if (!e) {
>>> +             DRM_ERROR("%s no low priority ring found\n", __func__);
>>> +             spin_unlock(&mux->lock);
>>> +             return;
>>> +     }
>>> +
>>> +     last_seq = atomic_read(&e->ring->fence_drv.last_seq);
>>> +     seq = mux->seq_no_resubmit;
>>> +     if (last_seq < seq) {
>>> +             /*resubmit all the fences between (last_seq, seq]*/
>>> +             list_for_each_entry(chunk, &e->list, entry) {
>>> +                     if (chunk->sync_seq > last_seq && chunk->sync_seq <= seq) {
>>> +                             copy_pkt_from_sw_ring(mux, e->ring, chunk->start, chunk->end);
>>> +                             mux->wptr_resubmit = chunk->end;
>>> +                             amdgpu_ring_commit(mux->real_ring);
>>> +                     }
>>> +             }
>>> +     }
>>> +
>>> +     del_timer(&mux->resubmit_timer);
>>> +     mux->s_resubmit = false;
>>> +     spin_unlock(&mux->lock);
>>> +}
>>> +
>>> +static void amdgpu_mux_resubmit_fallback(struct timer_list *t) {
>>> +     struct amdgpu_ring_mux *mux = from_timer(mux, t,
>>> +resubmit_timer);
>>> +
>>> +     DRM_INFO("calling %s\n", __func__);
>>> +     amdgpu_mux_resubmit_chunks(mux, true); }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>> index e8ee34e6b9a5..f6fc0afa3cc7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>> @@ -35,6 +35,7 @@ struct amdgpu_ring;
>>>      * sw_cptr -- the position of the copy pointer in the sw ring
>>>      * sw_rptr -- the read pointer in software ring
>>>      * sw_wptr -- the write pointer in software ring
>>> + * list -- list head for amdgpu_mux_chunk
>>>      */
>>>     struct amdgpu_mux_entry {
>>>         struct                  amdgpu_ring *ring;
>>> @@ -43,6 +44,7 @@ struct amdgpu_mux_entry {
>>>         u64                     sw_cptr;
>>>         u64                     sw_rptr;
>>>         u64                     sw_wptr;
>>> +     struct list_head        list;
>>>     };
>>>
>>>     struct amdgpu_ring_mux {
>>> @@ -53,6 +55,24 @@ struct amdgpu_ring_mux {
>>>         unsigned int            ring_entry_size;
>>>         /*the lock for copy data from different software rings*/
>>>         spinlock_t              lock;
>>> +     bool                    s_resubmit;
>>> +     uint32_t                seq_no_resubmit;
>>> +     u64                     wptr_resubmit;
>>> +     struct timer_list       resubmit_timer;
>>> +};
>>> +
>>> +/*
>>> + * amdgpu_munx_chunk -- save the location of indirect buffer's
>>> +package on softare rings
>>> + * entry -- the list entry.
>>> + * sync_seq -- the fence seqno related with the saved IB.
>>> + * start -- start location on the software ring.
>>> + * end -- end location on the software ring.
>>> + */
>>> +struct amdgpu_mux_chunk {
>>> +     struct list_head        entry;
>>> +     uint32_t                sync_seq;
>>> +     u64                     start;
>>> +     u64                     end;
>>>     };
>>>
>>>     int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct
>>> amdgpu_ring *ring, @@ -63,4 +83,8 @@ void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>>>     u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
>>>     u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux,
>>> struct amdgpu_ring *ring);
>>>
>>> +void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct
>>> +amdgpu_ring *ring); void amdgpu_ring_mux_end_ib(struct
>>> +amdgpu_ring_mux *mux, struct amdgpu_ring *ring); void
>>> +amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux);
>>> +
>>>     #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>> index ec50793aa54d..4809ecf76180 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>> @@ -26,6 +26,7 @@
>>>
>>>     #include "amdgpu_sw_ring.h"
>>>     #include "amdgpu_ring_mux.h"
>>> +#include "amdgpu_mcbp.h"
>>>
>>>     u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
>>>     {
>>> @@ -58,3 +59,29 @@ void amdgpu_sw_ring_commit(struct amdgpu_ring *ring)
>>>         WARN_ON(!ring->is_sw_ring);
>>>         amdgpu_ring_set_wptr_to_mux(mux, ring, ring->wptr);
>>>     }
>>> +
>>> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring) {
>>> +     struct amdgpu_device *adev = ring->adev;
>>> +     struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>>> +
>>> +     WARN_ON(!ring->is_sw_ring);
>>> +     if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT) {
>>> +             if (amdgpu_mcbp_scan(mux) > 0)
>>> +                     amdgpu_mcbp_trigger_preempt(mux);
>>> +             return;
>>> +     }
>>> +
>>> +     amdgpu_ring_mux_start_ib(mux, ring); }
>>> +
>>> +void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring) {
>>> +     struct amdgpu_device *adev = ring->adev;
>>> +     struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>>> +
>>> +     WARN_ON(!ring->is_sw_ring);
>>> +     if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT)
>>> +             return;
>>> +     amdgpu_ring_mux_end_ib(mux, ring); }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 9596c22fded6..b7e94553f4fb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -601,6 +601,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>         if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
>>>                 return 0;
>>>
>>> +     amdgpu_ring_ib_begin(ring);
>>>         if (ring->funcs->init_cond_exec)
>>>                 patch_offset = amdgpu_ring_init_cond_exec(ring);
>>>
>>> @@ -661,6 +662,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>                 amdgpu_ring_emit_switch_buffer(ring);
>>>                 amdgpu_ring_emit_switch_buffer(ring);
>>>         }
>>> +     amdgpu_ring_ib_end(ring);
>>>         return 0;
>>>     }
>>>

