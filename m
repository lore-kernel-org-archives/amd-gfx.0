Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B81C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCABE6108B
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BCABE6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351786E8FA;
	Mon,  8 Nov 2021 14:57:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C506E8FA
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 14:57:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1imkc8M51HXTmtbBIsxLwcM/X7itAv3hf1zHkbqwlbgVMcPADXnvUrOYrJZHL9yX0Suhy215+hUhXoHRzwsPkCM290RIvFL4cujF7gG+iN9wvIeRDKMuI9XVrJqNQTVQ/kdn81n3iZUH4AW7c+YgOKaGsgOFwso02sva+jCkPYW2L2qPodqTUNmUlaQ3gB8fOky/NT+/yT4lQ/mwM3YuvRMcMJT5lH3qs46kZY6EAacZ6VfQhL8GrBXVQMM5jqC/HcJBFyoFKVPhOvBh75fepyFdNDnBMBYA8OaAnFZhj/Pe9SmNi6yuKqCoqZNQQFaApHTOdqJeRSg4Qm+/UWXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMajw7XN93ll3B7JmAxd3D2keU4nkPRb+EGXFpyjGgk=;
 b=YmIOJpwfBsaFEM3uEeEaH1+macbBrP6/ZeImFWE0/BljeWo8DYSNCsnBdp+7ePGebHglhM9/DSt6vQNXk1CAttVW6kIhpDJ5IoLCpVlqD8V9eZcSibkvlnRtTatuZPHqYGj0rTaKrts0440JJ4SvnV8hp7Tn2M0/bsEny7qZiIj693sMeb49PQpAa/baOdGQtkPbRrz7akvE9X3y3bQYmoFwLoIW0VkJZCuH2GG//MMR/TqHGrDZQpgdE4bIgKSGeZkj8NH2qTOFl+uMK4slBorqAh3EqiWn6bYp8p5LYgqNXyVGT7kBD8bwK+L6Afy3iaEOJNhikcE506uz0TUk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMajw7XN93ll3B7JmAxd3D2keU4nkPRb+EGXFpyjGgk=;
 b=gTPbaCURzZdN0B77i2+zS3A66DmcGHo24AfdE1bjcMhdnFDUuoPTXGR2qoVRSt/SJqyoj0xezF527ce3bDPDT4+SXNBiRSeH1cvTERA06lz12brhq7xxioZ5F9omh4GOXyqnFZug2W9r8E7BdqVF/DAt80tkqCdzbiFUmrnM+cM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Mon, 8 Nov
 2021 14:57:42 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d095:131a:b99a:9975]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d095:131a:b99a:9975%3]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 14:57:42 +0000
Message-ID: <91abff88-da03-695d-e8fa-3096f6e2895a@amd.com>
Date: Mon, 8 Nov 2021 09:57:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/display: log amdgpu_dm_atomic_check() failure
 cause
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "S, Shirish" <sshankar@amd.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Shirish S <shirish.s@amd.com>
References: <20211108084054.11162-1-shirish.s@amd.com>
 <d85871bd-72af-d02d-5c23-f3c13ccbfd52@molgen.mpg.de>
 <af95f11c-c70c-352b-da5a-3a185426d696@amd.com>
 <d4d96a2d-11c5-ab58-efb0-262ef75d515d@gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <d4d96a2d-11c5-ab58-efb0-262ef75d515d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::35) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR01CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 14:57:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 883ff414-9069-4fdd-77f5-08d9a2c81d28
X-MS-TrafficTypeDiagnostic: CO6PR12MB5410:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5410B4E8DD136EFEA5885B298C919@CO6PR12MB5410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78TXEKY0WZtudz6amgDYWc+P2oGJm3d7eNoXoVwWn/Hjfq7bC6cProYEx7oiVbS858d2uY27PX16+GLHLY/7tdEOMsOKw87m2R7MXMQ4UTDbaYJUChNXH/RQrcPikD/okPcXcPogM5e5Lj0uqmEq7rSgMezRhbUdigDqAlIyV2GSAugJjtNfbFqVDQF3EFWukZSQ7m5f57WyD7GwhmJ05xW58Weljmk1SIc73+6ev3Bb8bhOpABEUSZKgo6Ccg86UTowRdkIg01f2yjiKT8nNBiE2YRiV9+/dBtLIqVY/Txr7m6L17rOOFTV0lQZI88sdkJR47rkj1335YIldA9Y9d4lAa9hQ19RuIRg/4dB7I27HsiSnixG11QNH+qez3zbH8zNSdc0aY40Ub2yZXlSxCz71gugK7EEBYSXkMjacVVhDzHcHEJE4H2CL/QfKgd4C8ZV2ce//GaFOOCGRTj4ir5IG7myowJLA8lFbhkuMJ+NGARNiIdSuAdVQ0ME+XR9whRvZ/kTuN60BQKt5crmiB6XXWQvMLbNki5TVMhO8S5p16xGm4dUt3UmsPHMFuqpXk9nG0LyYPXXkoVOqimGh+/KybcqtFpDf/cFwLvrB/di4LdrhX3Z76nxM9sWGIrJeXGz2Zk88Bdid8S4H9ye51WkDlSjllhAdtgZyy1UZ3lFmqTzUw2Vgmq0ltwNzc2rVU01zIXAwo6K+LJu39RMaC7ZGUZrO3S8OhDzVjImmodoGyIjW8CxATnSKeE7ijml
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(54906003)(66476007)(956004)(2616005)(316002)(83380400001)(6486002)(16576012)(38100700002)(66556008)(53546011)(26005)(186003)(8676002)(31696002)(2906002)(4326008)(8936002)(66946007)(508600001)(5660300002)(86362001)(36756003)(31686004)(66574015)(6666004)(44832011)(6636002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnJ6eVJyZk9pK2JqcGgxcjNoS0hLcGs1K2lmUFZ5ell4Zk5iYlFYOWZVS2RL?=
 =?utf-8?B?QkxOQVV2RmxsWGlYYVdrYzh2aTZGNVhqbU1IdXJxdEVFZFRlRWM0YUlSc1JE?=
 =?utf-8?B?M1JrVDJRcm1INmxPVGZwcXlEYisxbVhpMEt1UkU3aUJPZ2hMdFpXTDU4S2NU?=
 =?utf-8?B?U3hPYkh5dWVmd0MrVFo5bkhVVUNYRWxpSW1KZVA3UkN4VGJjVExVeGVQQ2Fx?=
 =?utf-8?B?d2RSL1FlSkVoNVhiVGI5ejJvcHJvcWtQWWVLVkxPa1pEckhuSzNpaWZCVkU3?=
 =?utf-8?B?M1dNYk9mNks0SUdIa3hQNHlwa0F5eHRuQVNHclFmd2UvdFhtZXdqUzBER3ZX?=
 =?utf-8?B?a2lHNUNCOUtrZE55eWZXZ2FzRUp5Q0NHa0JlTENESDhNWDBFbFJsZlpZWDJy?=
 =?utf-8?B?bGUwSENjRzkwWGV0VUg3aExXZEhZYmZ1YU9ndjZ3aUxCVVRHY01WY2dBZGNC?=
 =?utf-8?B?cHF5emF2UTJqeHRKT3NiaEZndmhGWGUvZGxKSVFBSCtyTjMwNEFMbGVNRlU4?=
 =?utf-8?B?VXhsQk0zSytGSVduWktVcHF6bEtNRmNrUExyblgrVUtEaytnMWlFT2x2Ykpn?=
 =?utf-8?B?Y1Z3KzFKVi8vODFHWFlZODVoMGsvQ3BDNFg5Z3Jia29Yc0Y4d09rZ0kzSVBy?=
 =?utf-8?B?K1hvSXVRclRULzFHalduVS9ORzhiUy8yY3ROOElDWVhuS0NjcCtmMFlzTTBZ?=
 =?utf-8?B?YWVUY1hnTldRMXZJQzhQcFdEM01JTjZRR2VrbVlMbm1SeEhVTW5Uajk2OS9K?=
 =?utf-8?B?UlhEVi9rUjhMOUVFSVB5RU9IdGFQNE5UbVNxcXcxc1poZzdOWVlUZDFIZ2tJ?=
 =?utf-8?B?eXp1RXJWMVByQjBub0RsWFB3R2dWOVJwNzVxakh1MFRGK3JaUlMrM2NHWVp1?=
 =?utf-8?B?MDdZbHpDM00zc3MrTjE0RFhjbS9YMVJNUkpaSmZ5RGpGNEozVndDZ3dpYkpq?=
 =?utf-8?B?MzdaNTk0dTN6Z2JCUUFLdUFoaElaRkFOL2hlZEsyeW04RW5QVzBIYnJjODha?=
 =?utf-8?B?VUVzNVVTdDE3bVdLak1IU3htNTJTS2gxMFVvSlFKZHdsSjdFdHNaY1dUcEJq?=
 =?utf-8?B?czhWZkt5Y3JFS3RDdzZLaE1HaGYrb3RkaE9pazhaNjF3UnZ3QTlnMXk1aFZG?=
 =?utf-8?B?a2RNa29ycUwyc3Z6OFRScUNlVlRHd2FWZTRlS00zSXlrNmkzRENlRlIwbWIz?=
 =?utf-8?B?OXhPdnZMYXBXdHZrL0dVOWpwTlFJcVVEMUtydjVOZ2g1cUFkYVlUTWZCNDRH?=
 =?utf-8?B?ZWVQbXVyQTFpa3pNcUcrQ29zWEh4ZVQ0TVFha205REQ2YWRYblF3Y29GeDhq?=
 =?utf-8?B?RzZoaFV3VFNqY2J5a2JvbDVNbmR5Rnk5d3JycW5hK1c1dkk2bTVPSlYrS1R1?=
 =?utf-8?B?aTd3Ymt3bnllbG1QUmE1czFLWTBkQ09ybG9oc0xLcExPZnJGUEpDN1NtazE2?=
 =?utf-8?B?RTBsWStxWHRvQzFLdmlQV2h5Smk3SU1jUHdLSkxGdm9zZVozZWlDS2JuN1I4?=
 =?utf-8?B?OUVLR0FHMnc3Zi9OTmcxNFVLeGxOWDd4TU1JMzdjaUJLYVJOQnI3MEsvQkox?=
 =?utf-8?B?WG1GMEJGWWw0ZE9mNTA2UGc1OGMxdE9SUm1RR3FIdGFMQWpPVXhHU090YThn?=
 =?utf-8?B?MnpNbFUwNVZnN1FZRGFiNVB4SnRrSXNJUmRoTnJJVjB4cTZNRzZTdTJ0ZStJ?=
 =?utf-8?B?Z3l4cm5tVjNtdFlUR0VNZ2NjVU9sK1BWYzFlUUhpdndnQkdqRzFBN1pjQnJK?=
 =?utf-8?B?NmQvZmp1bHJBZXQzOUdhWlhSdmFLbEhsekw3bWhWTXV4QWdFYlNJSUJTNnZw?=
 =?utf-8?B?cTBCYitZUlBwVVpRRHZaUWI2RzZYcWlUSGxaWlloSXVoTlNWOHZ1R0tYMi81?=
 =?utf-8?B?dU1ZQXdCeEU4RlkwSWNRZmFZSWVyWlJaUVFXa05HSk1tM2xBWnFYZnUyb0Y5?=
 =?utf-8?B?S2RZMkQ2aWY3RXRtbEt0RlhoV0ptOHFQNXdXWmpWK3pFT2RPcklQdGhldFVY?=
 =?utf-8?B?ZUxlVVdGejZzM1NsTFBQeW5CdEpqYUIxVXMyVlBVVWdpTSt1K1JtbmNxR0Rv?=
 =?utf-8?B?eXV4MzdXemQrMUVlWit4dTZFQjNwWkZCL3JhRHVrSGI5NHgzM2lUTG5pL0hH?=
 =?utf-8?B?YkJkcjVXM1g2andwRVZyd1pzZGFiZXhodEdWR0FNbE9OQnczRlVUaVpENDg1?=
 =?utf-8?Q?sdezQME9USpDicQmW+Aeaq8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883ff414-9069-4fdd-77f5-08d9a2c81d28
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:57:41.8306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHui0QUr4VbfdgS8fu0a6SFBLOihSMBmMsZlOhQ5JaAjFAYGt/UZxp+xmvboBQg9Q0j6dpR8kfiynHdVBOkuVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-11-08 06:23, Christian König wrote:
> 
> 
> Am 08.11.21 um 12:13 schrieb S, Shirish:
>> Hi Paul,
>>
>> On 11/8/2021 2:27 PM, Paul Menzel wrote:
>>> Dear Shrish,
>>>
>>>
>>> Am 08.11.21 um 09:40 schrieb Shirish S:
>>>> update user with next level of info about which condition led to
>>>> atomic check failure.
>>>>
>>>> Signed-off-by: Shirish S <shirish.s@amd.com>
>>>> ---
>>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 70 ++++++++++++++-----
>>>>   1 file changed, 52 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> index 1e26d9be8993..37ea8a76fa09 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> @@ -10746,8 +10746,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>       trace_amdgpu_dm_atomic_check_begin(state);
>>>>         ret = drm_atomic_helper_check_modeset(dev, state);
>>>> -    if (ret)
>>>> +    if (ret) {
>>>> +        DRM_DEV_ERROR(adev->dev, "drm_atomic_helper_check_modeset() failed\n");
>>>
>>> Does the Linux kernel provide means (for example ftrace) to trace such things, so the (generic) debug lines don’t have to be added? Or is it to better debug user bug reports?
>>>
>> ftrace requires additional tooling, am trying to avoid it and make the error reporting more trivial to the developers, in case there is a failure in atomic_check.
> 
> Yeah, but Paul is right that here looks like totally overkill to me as well.
> 
> And especially calls to functions like drm_atomic_helper_check_modeset() sound like parameter validation to me which the kernel should absolute NOT report about on default severity level.
> 

Atomic_check is also expected to fail as userspace might want to just query whether an atomic_state can be applied.

Debug messages might make sense here and would help with debug. These shouldn't be error prints, though.

Harry

> Otherwise you allow userspace to flood the logs with trivial error messages.
> 
> Regards,
> Christian.
> 
>>
>> Regards,
>>
>> Shirish S
>>
>>>
>>> Kind regards,
>>>
>>> Paul
>>>
>>>
>>>>           goto fail;
>>>> +    }
>>>>         /* Check connector changes */
>>>>       for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
>>>> @@ -10763,6 +10765,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>             new_crtc_state = drm_atomic_get_crtc_state(state, new_con_state->crtc);
>>>>           if (IS_ERR(new_crtc_state)) {
>>>> +            DRM_DEV_ERROR(adev->dev, "drm_atomic_get_crtc_state() failed\n");
>>>>               ret = PTR_ERR(new_crtc_state);
>>>>               goto fail;
>>>>           }
>>>> @@ -10777,8 +10780,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>           for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
>>>>               if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
>>>>                   ret = add_affected_mst_dsc_crtcs(state, crtc);
>>>> -                if (ret)
>>>> +                if (ret) {
>>>> +                    DRM_DEV_ERROR(adev->dev, "add_affected_mst_dsc_crtcs() failed\n");
>>>>                       goto fail;
>>>> +                }
>>>>               }
>>>>           }
>>>>       }
>>>> @@ -10793,19 +10798,25 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>               continue;
>>>>             ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
>>>> -        if (ret)
>>>> +        if (ret) {
>>>> +            DRM_DEV_ERROR(adev->dev, "amdgpu_dm_verify_lut_sizes() failed\n");
>>>>               goto fail;
>>>> +        }
>>>>             if (!new_crtc_state->enable)
>>>>               continue;
>>>>             ret = drm_atomic_add_affected_connectors(state, crtc);
>>>> -        if (ret)
>>>> -            return ret;
>>>> +        if (ret) {
>>>> +            DRM_DEV_ERROR(adev->dev, "drm_atomic_add_affected_connectors() failed\n");
>>>> +            goto fail;
>>>> +        }
>>>>             ret = drm_atomic_add_affected_planes(state, crtc);
>>>> -        if (ret)
>>>> +        if (ret) {
>>>> +            DRM_DEV_ERROR(adev->dev, "drm_atomic_add_affected_planes() failed\n");
>>>>               goto fail;
>>>> +        }
>>>>             if (dm_old_crtc_state->dsc_force_changed)
>>>>               new_crtc_state->mode_changed = true;
>>>> @@ -10842,6 +10853,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>                 if (IS_ERR(new_plane_state)) {
>>>>                   ret = PTR_ERR(new_plane_state);
>>>> +                DRM_DEV_ERROR(adev->dev, "new_plane_state is BAD\n");
>>>>                   goto fail;
>>>>               }
>>>>           }
>>>> @@ -10854,8 +10866,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>                           new_plane_state,
>>>>                           false,
>>>>                           &lock_and_validation_needed);
>>>> -        if (ret)
>>>> +        if (ret) {
>>>> +            DRM_DEV_ERROR(adev->dev, "dm_update_plane_state() failed\n");
>>>>               goto fail;
>>>> +        }
>>>>       }
>>>>         /* Disable all crtcs which require disable */
>>>> @@ -10865,8 +10879,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>                          new_crtc_state,
>>>>                          false,
>>>>                          &lock_and_validation_needed);
>>>> -        if (ret)
>>>> +        if (ret) {
>>>> +            DRM_DEV_ERROR(adev->dev, "DISABLE: dm_update_crtc_state() failed\n");
>>>>               goto fail;
>>>> +        }
>>>>       }
>>>>         /* Enable all crtcs which require enable */
>>>> @@ -10876,8 +10892,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>                          new_crtc_state,
>>>>                          true,
>>>>                          &lock_and_validation_needed);
>>>> -        if (ret)
>>>> +        if (ret) {
>>>> +            DRM_DEV_ERROR(adev->dev, "ENABLE: dm_update_crtc_state() failed\n");
>>>>               goto fail;
>>>> +        }
>>>>       }
>>>>         /* Add new/modified planes */
>>>> @@ -10887,20 +10905,26 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>                           new_plane_state,
>>>>                           true,
>>>>                           &lock_and_validation_needed);
>>>> -        if (ret)
>>>> +        if (ret) {
>>>> +            DRM_DEV_ERROR(adev->dev, "dm_update_plane_state() failed\n");
>>>>               goto fail;
>>>> +        }
>>>>       }
>>>>         /* Run this here since we want to validate the streams we created */
>>>>       ret = drm_atomic_helper_check_planes(dev, state);
>>>> -    if (ret)
>>>> +    if (ret) {
>>>> +        DRM_DEV_ERROR(adev->dev, "drm_atomic_helper_check_planes() failed\n");
>>>>           goto fail;
>>>> +    }
>>>>         /* Check cursor planes scaling */
>>>>       for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>>>>           ret = dm_check_crtc_cursor(state, crtc, new_crtc_state);
>>>> -        if (ret)
>>>> +        if (ret) {
>>>> +            DRM_DEV_ERROR(adev->dev, "dm_check_crtc_cursor() failed\n");
>>>>               goto fail;
>>>> +        }
>>>>       }
>>>>         if (state->legacy_cursor_update) {
>>>> @@ -10987,20 +11011,28 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>        */
>>>>       if (lock_and_validation_needed) {
>>>>           ret = dm_atomic_get_state(state, &dm_state);
>>>> -        if (ret)
>>>> +        if (ret) {
>>>> +            DRM_DEV_ERROR(adev->dev, "dm_atomic_get_state() failed\n");
>>>>               goto fail;
>>>> +        }
>>>>             ret = do_aquire_global_lock(dev, state);
>>>> -        if (ret)
>>>> +        if (ret) {
>>>> +            DRM_DEV_ERROR(adev->dev, "do_aquire_global_lock() failed\n");
>>>>               goto fail;
>>>> +        }
>>>>     #if defined(CONFIG_DRM_AMD_DC_DCN)
>>>> -        if (!compute_mst_dsc_configs_for_state(state, dm_state->context, vars))
>>>> +        if (!compute_mst_dsc_configs_for_state(state, dm_state->context, vars)) {
>>>> +            DRM_DEV_ERROR(adev->dev, "compute_mst_dsc_configs_for_state() failed\n");
>>>>               goto fail;
>>>> +        }
>>>>             ret = dm_update_mst_vcpi_slots_for_dsc(state, dm_state->context, vars);
>>>> -        if (ret)
>>>> +        if (ret) {
>>>> +            DRM_DEV_ERROR(adev->dev, "dm_update_mst_vcpi_slots_for_dsc() failed\n");
>>>>               goto fail;
>>>> +        }
>>>>   #endif
>>>>             /*
>>>> @@ -11010,11 +11042,13 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>            * to get stuck in an infinite loop and hang eventually.
>>>>            */
>>>>           ret = drm_dp_mst_atomic_check(state);
>>>> -        if (ret)
>>>> +        if (ret) {
>>>> +            DRM_DEV_ERROR(adev->dev, "drm_dp_mst_atomic_check() failed\n");
>>>>               goto fail;
>>>> +        }
>>>>           status = dc_validate_global_state(dc, dm_state->context, false);
>>>>           if (status != DC_OK) {
>>>> -            drm_dbg_atomic(dev,
>>>> +            DRM_DEV_ERROR(adev->dev,
>>>>                          "DC global validation failure: %s (%d)",
>>>>                          dc_status_to_str(status), status);
>>>>               ret = -EINVAL;
>>>>
> 

