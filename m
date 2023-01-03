Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3895AC4708E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 20:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD77789C5E;
	Tue,  3 Jan 2023 20:05:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 392448913D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 20:05:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hz3EmHqyOZ2mDVEJCaywdBgTgMfvn/dAO6tm8SVE53Q91RmSzEWdNweDG29HDFO1tgT6+t0b2Syyo+CxU85rClFwW+3Fj6jOC4ohB5GE2DX95ta+EOPmCOKUCiOMQ7Se2DLKVXTgqfTUv77Oj/rPFGz56Z4eyb12ruNuDE9BjngFzAv/YmbBqpiiR/dgfS/kzjITZFUsRB9JuBQbbMUzRB4RfwcI83Qg1XXja60t8o6EvGUb2VWxBzFyxU2Iu4ThP5ITi5cKxiSSaLtQWBoObeRlBI88w4RjAvG1bQzoldq4/xmR8Rm733rLWMowOdEtxQ+TAsfgbrxAxr4rUWnLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JekTfpbfqwjf2q0IyiX+VAVnwIGXy0tn0V7VKCxP3O0=;
 b=dhV8q2NVhvyeAoWV4UmtA1fle2+HZMJ/2z0fociriBPgLypHJteQEtrN2j+Rclmwo5jsAlDxOLZMmFymcQExrMX4veDCnuL+Y9yGixg0zIkPxpTI6T8+JTl2uEEwF93QkP1X110WsWPccPk5xFxH5u4/WQPJljme+9KH6k4Wv0sW4tFknKsjnWV0FRPRl0VlfAnCVuSy2oDzSYxDw6rGR2bBCkymrPjT/xSRD5effezDoMqMv44StG8GPJtpFT8jDNuNwP79p9opPy+dXPdRVU4r8R+7DrRHiRHUNg9dqmQS8aCN7Wxkvse/7BaSZ/FzcNQjODEt+72h0mYeM0BQXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JekTfpbfqwjf2q0IyiX+VAVnwIGXy0tn0V7VKCxP3O0=;
 b=kjEwTywMkq5mtO91d/n1puxysyzYzeu70pNVHsdRU1Ye7uNpjvsyAQHAGcLmJ8EzExBtct2x0oYnu6zDkjTpwloytFPSQnqigCfCVpyJvHDtHGTSha+ydsFWH3DBB7ebV/gw0AD2jaUel5R0TcLD9FV7XQWEDcgGQaJ9YWPK5qI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 20:05:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%4]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 20:05:30 +0000
Message-ID: <3ae762e3-85c4-ea5d-6b97-79d2028ad570@amd.com>
Date: Tue, 3 Jan 2023 15:05:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC 1/7] drm/amdgpu: UAPI for user queue management
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-2-shashank.sharma@amd.com>
 <97583f26-81be-f6e5-ac62-45a3bca40e43@amd.com>
 <CH0PR12MB5372BF7A0FAE2CAC070D2AB9F4F49@CH0PR12MB5372.namprd12.prod.outlook.com>
 <CADnq5_NxBW+074+sYwuOC11wShDLFFX0Hrsa54m9fYYBWeSpPA@mail.gmail.com>
 <CH0PR12MB5372F9A6C6ED7917D25EC1C4F4F49@CH0PR12MB5372.namprd12.prod.outlook.com>
 <CADnq5_Npi92uYpKNcffh8MXB7Ks0RMkXQwSM2Pfp9TXntVsv8w@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CADnq5_Npi92uYpKNcffh8MXB7Ks0RMkXQwSM2Pfp9TXntVsv8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd7936f-8734-4c32-dfd3-08daedc5dd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/v4gunliqhEXM4bFq8gz7eyTm2SqUKAgS266L1sB/CVGyomeiowkQqBRTJ5d0bbeFM572Vve0zZOEYFi1pPR/vXRnwY2xCDbI3ePUVEaMgnpN9aE7ma/KoAAMPfM+Ms6uikwaSVxYmOqO5ptYlFUG10gZEbx56nrw2kDnxsPmnmsVhZajp01xA3HKtiJRgUc7lrCW1sPcgN0Z/mC0edovCTbxVD5gPMZPq4yEpSrII8tHfu5k7YTu5x/EuNCOAYk0bp+hEGT9vCflL244gXczJEh+wQxOmv27V6m51pPPIwhnmvCcWOEKquOkCoTraP6y1qKF89cNQQI6I+FHG0WKw7DMmMTiOB1gakBqvQjc1I8h9ns/m+wqk0bw2z7ZuBppkXZyd89Bio5PZnzDlGCneCYSPmTDLNJyh2B6M8nU1VspSDQin1dke/g3vzUupPtwfsJpa/PcevyhtZPn5HXs+PW0saIGT32pSur8hB0EY/pnGPejBVMiVWeg652FWhYcrD2pOhHkZYBKYT4FQn4mxFuK9Um9RNxIBpSX9ViUxTJB2rjok4SSaFRLk9UNtwkcM3U/ozRS9ef/S0v9xzbnIyELnbZ+AVW5YoAGJdRgAuZTJU+9aDFlpYtbfBGlvNraFoLKryAUae0D89H220QX9jjRX0agwMgTMYf3EY/A76ogfalY+kQxEzXy5ksTyxfAVloxsmevEr49uofO1Pfiw7Pks2Wi4y88zjGDmzSsn+uAyX959x0Y1By8HcpP+uhR+pOVRY0AQgYMKHEeMtfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(4001150100001)(5660300002)(2906002)(44832011)(8936002)(8676002)(4326008)(41300700001)(478600001)(316002)(66476007)(6636002)(66946007)(110136005)(54906003)(66556008)(6486002)(31686004)(53546011)(26005)(6512007)(6506007)(83380400001)(186003)(38100700002)(2616005)(31696002)(86362001)(36756003)(22166006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVg1blVGYlpDeVpEMkRqRUxITERLbWZxd1VGbDFFeFhHUXJXdVZpMGZKZU54?=
 =?utf-8?B?MW5PZXpVVmdyUlgrOXZTRVc0bUtQTW9PTTNlTlFkelBRQ3Y1VGxGRGtQcjBZ?=
 =?utf-8?B?MFYyMWNldlZEY3RjcXFxSkR4Y3RqbENCL3l5bExtUDREQ3VNQktMTlF1WDQ3?=
 =?utf-8?B?ZzZwaDFVN3ZjY2d0NnYvMGQ3cVNSazFrVUtOM2RRbmVaUlArYUhPRnpLOXky?=
 =?utf-8?B?VVdxMTY4YTBNaFhCcUViU0tVR1dHYTVZS1FSM0RRd1dMK1pKVzViUi95bzl2?=
 =?utf-8?B?ZnVtRm5pTGZvbENHYTJ1eVNwQURiOXU4dWhweVBnT1hYRUhqa1RrSG1uN0ht?=
 =?utf-8?B?aWd3alUzdlRiL3J4WS9MMWZiYnVQd0pJQUpKaVU0V3JVZVJWZ0g0WlVlcGJB?=
 =?utf-8?B?cEE0QUtjakc2N0NITHFtU2labXdxVTJjTUVkdXBRSTU1UEtLbm1CVi9pbk5j?=
 =?utf-8?B?QW9JOFdCekV1NktZcUtrMVl2QVREaHEzVWFydUhad2RycVAyRHZuWVQ5OGJt?=
 =?utf-8?B?bHl5Tkk4VVVUS0QzdHdNOEF2Zms1bVc0WThnRTA5NzFJaVRiQVJ2K041ekpY?=
 =?utf-8?B?RFZYZ1hKOXp6ZWloWG5JODByZDdwTnJFSWd6Sy85MFJEN2FxTmVsWDlSbWls?=
 =?utf-8?B?Z2pjSXJ6OU5hLy9YK2tjVWJCUFZJK0lSay9Mdk11bEpkQkFaZkxsa2pEVUMw?=
 =?utf-8?B?WC9kZWVEWGdlZGhBNDdZSnBDZFR6c1B5TFBkRE5Pak9PTm5TRUtLSkZlUi95?=
 =?utf-8?B?cjE2SitQenhhRFVWU1pmVkM4aHBoY2FzcTM4a1l3dWdOWVp5bkorekpXNGRE?=
 =?utf-8?B?Z1NpSVZyNjNBVGt3Mkt0bFpXZ2FPTytJTzVUTkw0YklTN3Y3RkQwMGsraEpK?=
 =?utf-8?B?T3F2aE0yeEROb1dRR3hOK3h0NWFjcDBRWGxMcDMyTDY2Y2VuMVlVY2dJQjhl?=
 =?utf-8?B?T3N3dnNhWGpIcGxXWkdxMHJYVHpKQjRRN1dlekd6Z1V1cjNpRFVhc1piNVN6?=
 =?utf-8?B?QmpNSEI0ZGJBMG9EQ1hxSy9YK2NEYlRLRzhZeDhIdkJ5enNTa3ZzaU5WK0pl?=
 =?utf-8?B?Mk1EdHlFUUdPTlpVZ1JyZHAzTUFvTzdrd3ltWTRQNEhEQU96b0tvY21PakRL?=
 =?utf-8?B?WGNxS3gxOUFJVnhEVDRNNXU3YnMzM09NdTgrd3VweHYrSGJzcHVkMWRHYkk5?=
 =?utf-8?B?YXZMVnRhSW82b3oyK2hyVXJiOFBvZGJsejhZaU9yQWN2Y2c0QmpHZEpGRGlo?=
 =?utf-8?B?a0FvOUV1cWFpaVY3ek50OVM1QlhRclppN0FBMVYwS29NeHlCVzdvOHVBeGsy?=
 =?utf-8?B?OFY3NTErZ3MxSmpCNTJPRWNFZnNtak9LajlCdXVwSmZaRkJUNHl5VE1FckZY?=
 =?utf-8?B?UUdXdTNFSVJodGJBSGlyUUtUZlY4R3dnK2V5NHE2MlhTYUZLWFowMTdHYmha?=
 =?utf-8?B?UTdmOGJMZkxRRUI3VEtUWkFXeldmZC9jTlRjUUFXbWIxazFpVlI2czV1SFZL?=
 =?utf-8?B?TEYxVXgwK0NYT3pyR1dQa1N5YVkwZS92YlQyNkE5ckJvWUFFZ09sZWF5Wnk1?=
 =?utf-8?B?b21CcW5OUHkvMkNRY1RrZGF6NjRDRE4vUEs0QjNxOUwrdkFKZDNMVE1STm9K?=
 =?utf-8?B?SjFwZC9idFBneFlmZXlleS9VaURqNkV0SmRCRkx4YnloYng2a08zbDA5MFg2?=
 =?utf-8?B?akZYd1p1bU1YZGxwaTBwUHdQL2dTZWFTZFdCTUFKaTJad0JWNGtsbGEwQzZZ?=
 =?utf-8?B?bWNiMEYxVzlERFdHdE5jZGw3Slp2VTUvUDFyWEVaS2wwd1JvdW04YmthUEs0?=
 =?utf-8?B?YXk1V0dISXlGVU5xRHhpMDJZMHJPVW1ZZW1NcGJicFdRT3hhNk1EUjRBd3Uv?=
 =?utf-8?B?Y3Q3dmVCWkxsUmdPQ2tkQ3FpZXZJRW5HYnRjU01LeVZKNUdJeGZZUVdCdGhF?=
 =?utf-8?B?YUh5c0F6V3YzNDVPbml5WG9yRTlSQmwvZjV5dWE4ZWdmRXd4UWlQMktvTExq?=
 =?utf-8?B?MEVVVzM5ZEtLMXV2Q2FBOEJsZjRjMmJDWC80c2JLSytKcGRRTjMrSWdTMnJC?=
 =?utf-8?B?YVZocWkvM3ZJaUhMa0lBTURTZlF3c3RIdEY5Q2tYaWpnN1c1ZHRqUE9EaFFR?=
 =?utf-8?Q?qT2Z3Ft22v+244fdhv4rtZgWJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd7936f-8734-4c32-dfd3-08daedc5dd0a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 20:05:30.0569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQieXZJ/YAUoWsd6t+f2HakE57JAGciqeMmfcB2Kh5dAcPW1CayVOc3EhrSEC35HPC3pLUQFjAM93y3s35++gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914
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
Cc: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>, "Yadav, Arvind" <Arvind.Yadav@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I think at some point ROCr could start using libdrm APIs for memory 
management and user mode queues on kernels and GPUs that support this. I 
think more work is required on the memory management side, though. ROCr 
would fallback to libhsakmt on older kernels and older GPUs (pre-GFX11).

Regards,
   Felix


Am 2023-01-03 um 14:52 schrieb Alex Deucher:
> On Tue, Jan 3, 2023 at 2:25 PM Liu, Shaoyun <Shaoyun.Liu@amd.com> wrote:
>> [AMD Official Use Only - General]
>>
>> What about the existing rocm apps that already use the  hsakmt APIs for user queue ?
> We'd have to keep both APIs around for existing chips for backwards
> compatibility.
>
> Alex
>
>> Shaoyun.liu
>>
>> -----Original Message-----
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Tuesday, January 3, 2023 2:22 PM
>> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Sharma, Shashank <Shashank.Sharma@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>; Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
>> Subject: Re: [RFC 1/7] drm/amdgpu: UAPI for user queue management
>>
>> On Tue, Jan 3, 2023 at 2:17 PM Liu, Shaoyun <Shaoyun.Liu@amd.com> wrote:
>>> [AMD Official Use Only - General]
>>>
>>> Hsakmt  has  the  interfaces for compute user queue. Do we want a unify API for both  graphic and compute  ?
>> Yeah, that is the eventual goal, hence the flag for AQL vs PM4.
>>
>> Alex
>>
>>> Regards
>>> Shaoyun.liu
>>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Felix Kuehling
>>> Sent: Tuesday, January 3, 2023 1:30 PM
>>> To: Sharma, Shashank <Shashank.Sharma@amd.com>;
>>> amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>;
>>> Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
>>> Subject: Re: [RFC 1/7] drm/amdgpu: UAPI for user queue management
>>>
>>> Am 2022-12-23 um 14:36 schrieb Shashank Sharma:
>>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>>
>>>> This patch intorduces new UAPI/IOCTL for usermode graphics queue.
>>>> The userspace app will fill this structure and request the graphics
>>>> driver to add a graphics work queue for it. The output of this UAPI
>>>> is a queue id.
>>>>
>>>> This UAPI maps the queue into GPU, so the graphics app can start
>>>> submitting work to the queue as soon as the call returns.
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>    include/uapi/drm/amdgpu_drm.h | 52 +++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 52 insertions(+)
>>>>
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h
>>>> b/include/uapi/drm/amdgpu_drm.h index 0d93ec132ebb..a3d0dd6f62c5
>>>> 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -54,6 +54,7 @@ extern "C" {
>>>>    #define DRM_AMDGPU_VM                       0x13
>>>>    #define DRM_AMDGPU_FENCE_TO_HANDLE  0x14
>>>>    #define DRM_AMDGPU_SCHED            0x15
>>>> +#define DRM_AMDGPU_USERQ             0x16
>>>>
>>>>    #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>    #define DRM_IOCTL_AMDGPU_GEM_MMAP   DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>> @@ -71,6 +72,7 @@ extern "C" {
>>>>    #define DRM_IOCTL_AMDGPU_VM         DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>>>    #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>>>>    #define DRM_IOCTL_AMDGPU_SCHED              DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>>> +#define DRM_IOCTL_AMDGPU_USERQ               DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>>>
>>>>    /**
>>>>     * DOC: memory domains
>>>> @@ -288,6 +290,56 @@ union drm_amdgpu_ctx {
>>>>        union drm_amdgpu_ctx_out out;
>>>>    };
>>>>
>>>> +/* user queue IOCTL */
>>>> +#define AMDGPU_USERQ_OP_CREATE       1
>>>> +#define AMDGPU_USERQ_OP_FREE 2
>>>> +
>>>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE        (1 << 0)
>>> What does "secure" mean here? I don't see this flag referenced anywhere in the rest of the patch series.
>>>
>>> Regards,
>>>     Felix
>>>
>>>
>>>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL   (1 << 1)
>>>> +
>>>> +struct drm_amdgpu_userq_mqd {
>>>> +     /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
>>>> +     __u32   flags;
>>>> +     /** IP type: AMDGPU_HW_IP_* */
>>>> +     __u32   ip_type;
>>>> +     /** GEM object handle */
>>>> +     __u32   doorbell_handle;
>>>> +     /** Doorbell offset in dwords */
>>>> +     __u32   doorbell_offset;
>>>> +     /** GPU virtual address of the queue */
>>>> +     __u64   queue_va;
>>>> +     /** Size of the queue in bytes */
>>>> +     __u64   queue_size;
>>>> +     /** GPU virtual address of the rptr */
>>>> +     __u64   rptr_va;
>>>> +     /** GPU virtual address of the wptr */
>>>> +     __u64   wptr_va;
>>>> +};
>>>> +
>>>> +struct drm_amdgpu_userq_in {
>>>> +     /** AMDGPU_USERQ_OP_* */
>>>> +     __u32   op;
>>>> +     /** Flags */
>>>> +     __u32   flags;
>>>> +     /** Context handle to associate the queue with */
>>>> +     __u32   ctx_id;
>>>> +     __u32   pad;
>>>> +     /** Queue descriptor */
>>>> +     struct drm_amdgpu_userq_mqd mqd; };
>>>> +
>>>> +struct drm_amdgpu_userq_out {
>>>> +     /** Queue handle */
>>>> +     __u32   q_id;
>>>> +     /** Flags */
>>>> +     __u32   flags;
>>>> +};
>>>> +
>>>> +union drm_amdgpu_userq {
>>>> +     struct drm_amdgpu_userq_in in;
>>>> +     struct drm_amdgpu_userq_out out; };
>>>> +
>>>>    /* vm ioctl */
>>>>    #define AMDGPU_VM_OP_RESERVE_VMID   1
>>>>    #define AMDGPU_VM_OP_UNRESERVE_VMID 2
