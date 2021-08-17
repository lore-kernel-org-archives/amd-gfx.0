Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70C3C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 10:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845A460F38
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 10:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 845A460F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D1E689121;
	Tue, 17 Aug 2021 10:09:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9391F89121
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 10:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Op+2DzNwQPcM9uNZomgk4SnN33lt05VCRdG8VZ6fQ+lBRN1ccvgEUXiPDKiVdQ1pKOkRn+V+INsaJzaTuEFP9g0l4PDKE6PwZzzkc8J9icgTaf+c9Q3pF71YmsU7slIt8eDIwpZmvLjTObsX3ennFvjDBacrjAuS1XDxwjRxX0clOf3dQ8GD0Lb6XgTVPqAg+UwkiqReeSPReLZg3JS7kz0+5bl8YVScq8GCow6ztVfz6p/EooB3UZKdS0hctRfFk3fiYnTVZBLzleU465ALnzaA8/i9roIViNOs8YAw1MQZ+j9H02TF4LA80ZEvIP5uFtDM8YXSOsYr+BLlUJqolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srYlJ56WPC8rmSkLab/1+AvAne9ZQ6dM8Ow+sCvQ5Sw=;
 b=amzYXajNed+aPWpWCK63GxCN6+MnRfPCxkixocQjszAZt/X3Cp+NybPUsk71mIwk+IJ0HqVIwJeKK6iLITJ1JCCV3d4/loIRlwLqiAkGALSQjpc6QYzUTaoBaAZAefEdYEsNy+T5qoA9gpdbbuj3vV0esVmWC5cI4chFrbkoq9Pz/FfAtAYK3JutNNMe60dVZluFqZkHN6XjLxiJ07ZEsx6+rxuLK67cNIWoJXqYs8HjWivI6gbcHOetlgiUGfXImwPeuzV22B9hxOpdiUTkH1g/Pzq2JoOgpsDj69HaNFxmRbkFDJJp5LylNxyY0zeNDP6UriIzXTWu2TpHEsdvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srYlJ56WPC8rmSkLab/1+AvAne9ZQ6dM8Ow+sCvQ5Sw=;
 b=2e/KtgM0BZktiOyyVOAWmheICNI3PnnEQUodB1JxrhyCTOjbm3F3+5sL5WZP6PYSQwcNqIdtTMgOg4F2O9D2l1Jwa9q/yKbM8ry6G28OAQST6C0HcKOkCciJ17tj43SGB9f91CwJTZrl3LXxLPVdlGVJbqPl00dBwnsRY1YXJcc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 10:08:58 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 10:08:58 +0000
Subject: Re: [PATCH] drm/amdgpu: properly powergate Polaris12 UVD/VCE on
 suspend
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Liu, Leo" <Leo.Liu@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20210817064005.1437328-1-evan.quan@amd.com>
 <374e0b56-e81f-b4c6-ae97-0ade2c0f5b36@amd.com>
 <DM6PR12MB26198C4D8A712DE7E7EC0580E4FE9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <2bb2f248-41ab-9c39-0881-c4ea97a7813e@amd.com>
Date: Tue, 17 Aug 2021 15:38:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB26198C4D8A712DE7E7EC0580E4FE9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::29) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0144.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.17 via Frontend Transport; Tue, 17 Aug 2021 10:08:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56995e69-093d-4dc0-cd74-08d961670766
X-MS-TrafficTypeDiagnostic: BL1PR12MB5061:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB506106D18910F3A09B84516B97FE9@BL1PR12MB5061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWDG7At91jQdrWzuwmpI8saaalGxApdGYEAR6sBoAps1xNvuMM2qRQ5zAmpLUvOdV8+A+BrhG/2lkeQd859NmHEaLfm/wrc4jB9Vw8t62V08A3eVq4kq9Q3g/50gr4hm/8OAawL308NCtziWGKkAnSOKLn44XBcWHcaWzq2z2CAMck1TfLPdfG3WaVH7Qx1To2Aj0l9OsxO6ozSSC7Is/kV/AlroH8R29TLv+9i3MWM2U1G74wVuDjfX0tcvx90qEo8HH34RlnUHXzZh52NXgwoB4Nd+qH/20yNj6jHcMdOTaA9wi9YVFEsnBO0f8tybSGjry4bT5PEOEVtJrya36UhzWcBNCOLOXPS607xlrom4NE7ZP42iIsVdacMGmwB2eoRPgBkIT9ysfGAzCktqYifsXVt2d8GTphRFdigjz3fAg/FeAKiVaMLuE8773ZR+HsNVTkd/Izo970g4LpTFNIIDgE8aHco9ZA6GYrraNjb9z8L2S7gMSlEAwXD8LPMSLbxOykwNSIOMhhB1IN7mwMNYN5LVuDK7yOoxnmSreIpz4w+C2DbJmC+FdL0At1fGLHZy/VZ/jDv19YF1vVpKjM9+Sylj0l5WGIvEp0+i/gMvhG7KBgVrmLin1gEYsxO7bcX3SMhc4cgNO+LvIm+vQID495MO2Ko2y6qxkfHrRniYt5CPGgWZ45sDup9gYyzx5a3BnFGKDGQibsmEny/wDfBOuB5msqECOmlnc/fZXq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(6666004)(6486002)(38100700002)(186003)(31686004)(26005)(2906002)(4326008)(110136005)(66946007)(54906003)(66556008)(66476007)(31696002)(16576012)(86362001)(956004)(2616005)(316002)(15650500001)(8676002)(5660300002)(53546011)(83380400001)(478600001)(8936002)(6636002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ly9WMmRZbGxZYk9XQkY3QVgyQzZQNlRhRGtMYmJhZUJBVWVDeFlvcFhrQ3oz?=
 =?utf-8?B?T3ZRSG9INzhydld6RUppYUxQZmo2UnI3Z1hIQVp4L1lDV0lQRUR1ems1Qzll?=
 =?utf-8?B?SWNnSHFldjlFYTkxcVpWRy9uSnVod2RWc2xvN25JRFNKcVN4RzN3WDM5aGY4?=
 =?utf-8?B?WUpxRnIzTml2UmxPQUo1TUNNRVhmcE00WWdNRE5qdW5qT3lyU1lHVWlPRUJx?=
 =?utf-8?B?NEo1RmE5bDNCV2gyT1VzQlBMa2JnamN1OUlNUi9DajVjWE93Q2RWZDV0dmZs?=
 =?utf-8?B?ZUkveGFsWStzbjQyL2RENkRvdGJUc3hKcGZwSEhDK3dpMGRadlNGOHIxbnp0?=
 =?utf-8?B?WHM4UVREMmc1WTZDRFJWWjJTdjk0bTZSek9BelE1U1BBeWVpVG5hWnFFSmNL?=
 =?utf-8?B?Qk9Fa3hpeWl5N3o0VDVaMDRnaml2bEF6cDM2c0R0SjlkSnJNZjFPSkZteGFE?=
 =?utf-8?B?K293Y2FPQndsT2lJQmxpM1VqRG94dXJLZUlLWjRFVDBldElxYklBNEhPektn?=
 =?utf-8?B?YWhzTWpjQkdFWjFDQUdHY29hRWNibjgxaWlzdHc4eitVVkh0UWREUnVKL0Rp?=
 =?utf-8?B?MnhQZFpIVW5hSzREa3UzVmNyN2dRdXpXSFpuMVNwaW96dENrWjhobTJtZXM3?=
 =?utf-8?B?aDI4OHpxOGRmTHhqQWo5TVNyMXdxVGFGcHJ3M0FseFo0TUY5aDdidFJqUHkr?=
 =?utf-8?B?aEpIa1RmOUE0bFhDYk12OU42QjlBZ0M3dmowWmV3VnhxV1pKTnVpVktscjZW?=
 =?utf-8?B?cmNyNi95WHAzZ00zY0QrajFROGlHRmVSR2pBY0d5RVZXODZSd2wzUjV6U0Z4?=
 =?utf-8?B?KzFQZ1V2S0NkTHNsMzVUdlRzbFJtTjhINzVyb000OTk1RW5mNHdGTTBDTWlD?=
 =?utf-8?B?K2xKN3JrY1YzdGY3cGRWNkdZT1Nyak1tZ0NtZTRySjQ2OUNoVUg1MlhUTlds?=
 =?utf-8?B?THVlT09nZWM2T3FWbXJ2ODdoNUdmY01QZVJ4M21XWGlkUUpZb0c0azZ4Z2Zu?=
 =?utf-8?B?c0dYdlltUnM3Z2VZNW14N0xQeUdLL3lsZ0RDWDZSZDRVdm1xYWxPSkNYcm04?=
 =?utf-8?B?UXVpT01uNGFSSVppcXpaZjlxK1cxNC9zaXFTbXVpbGlwbDJrb0ZWNE42QWJE?=
 =?utf-8?B?eS8wNkVXL0hrNXNsRU1SelJxOWJaYmhtMkxzenVxR0EydkhXWmY5NGtVaGJo?=
 =?utf-8?B?dWxmdVBrb3A4elFqSWlOYnMzaGZTNmQ5S0lMbENJQ2I5RFNzZnJYSFdvR09R?=
 =?utf-8?B?UHI0eTBObHJvV0V1WWZDZm1vK2ZNVVRLVlA2ZGFVR01mQ3B5MFJ0TG9Jd1l0?=
 =?utf-8?B?V2Z1dG5uWEEvOUtqL3BNc1k3T1BpMEtvWjhDczNNMnZQQjUxZXc5aFRrUTNW?=
 =?utf-8?B?d2lWbDFDZ2p6Q0NJeEhPWGdnOUhGeDlnRTJRUEJUU2xaNncydUZKTkRGeDRN?=
 =?utf-8?B?dm0wV0gzbTllOVNZZTVyblgweklZallhdGRZY051M0xyRnVEd1c1RkZaMVRK?=
 =?utf-8?B?NHk3bFdOMVFMTzQyUWx4dzVzVXh6OUJ4VUI4aXNWL2ljTHZ3MXU1QjJkOGlu?=
 =?utf-8?B?ekk2djhRM21iS2pXWXFQWm9YNnFoc3Q0VWRqZG4ra3pTU3hsT2YwWEM5U0Y5?=
 =?utf-8?B?L2h0RWhxQVhnbkNxV0x3WmxjN3dDSzQ2dW9Ja1FmWjdEdlUzUVZ4NTBBbmhI?=
 =?utf-8?B?WWFTRFdzb203K2dhNFJxVnFDbzRVR3pnaFYzY1RPb2Y3eEJsOEZJVkI2SE1H?=
 =?utf-8?Q?ol/QzlW1sLSQosy+l+jACXA04Y2SlmOPcAeZ+sT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56995e69-093d-4dc0-cd74-08d961670766
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 10:08:58.4733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJZqpiBTuOls2dMWt1IrQPD6zySDYZV53wW1LoyzOVcno705aux4AfDqEc4PCGW7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5061
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



On 8/17/2021 3:13 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> +Leo to share his insights
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, August 17, 2021 3:28 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
>> <Guchun.Chen@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: properly powergate Polaris12 UVD/VCE
>> on suspend
>>
>>
>>
>> On 8/17/2021 12:10 PM, Evan Quan wrote:
>>> If the powergating of UVD/VCE is in process, wait for its completion
>>> before proceeding(suspending). This can fix some hangs observed on
>>> suspending when UVD/VCE still using(e.g. issue "pm-suspend" when video
>>> is still playing).
>>>
>>> Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 5 +++++
>>>    drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 5 +++++
>>>    2 files changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>> index 4eebf973a065..2fdce572baeb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>> @@ -554,6 +554,11 @@ static int uvd_v6_0_suspend(void *handle)
>>>    	int r;
>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>
>>> +	/*
>>> +	 * If the powergating is in process, wait for its completion.
>>> +	 */
>>> +	flush_delayed_work(&adev->uvd.idle_work);
>>> +
>> If running idle is a prerequisite before going to suspend, then something else
>> is missing here.
>>
>> Otherwise, the hang looks more like a pending work launched after
>> hardware is suspended and trying to access hardware. As the hardware is
>> going to be suspended anyway, doesn't it work with
>> cancel_delayed_work_sync - making sure that nothing is going to be
>> launched later to access hardware?
> [Quan, Evan] The reason we chose flush_delayed_work instead of cancel_delayed_work_sync is we think those operations performed in idle_work(dpm disablement, powergating) seems needed considering the action is 'suspend'. So, instead of "cancel", maybe waiting for them completion is more proper.

But it will do so only if the work is scheduled - so it doesn't seem to 
be a prerequisite for suspend. If it was a prerequisite, then the 
existing code is missing that (so that it gets done for all cases).

>>
>> Then this may be a potential issue for other suspend calls also where work is
>> pending to be launched when hardware is suspended.
> [Quan, Evan] Do you mean we need to check whether there is similar issue for other IPs?
> 

Yes, if there are cases where other IPs may schedule a delayed work and 
call hw_fini without cancelling the work.

Thanks,
Lijo

> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>>    	r = uvd_v6_0_hw_fini(adev);
>>>    	if (r)
>>>    		return r;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> index 6d9108fa22e0..f0adecd5ec0b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> @@ -503,6 +503,11 @@ static int vce_v3_0_suspend(void *handle)
>>>    	int r;
>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>
>>> +	/*
>>> +	 * If the powergating is in process, wait for its completion.
>>> +	 */
>>> +	flush_delayed_work(&adev->vce.idle_work);
>>> +
>>>    	r = vce_v3_0_hw_fini(adev);
>>>    	if (r)
>>>    		return r;
>>>
