Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19730CC6B12
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 16:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A12DE10E086;
	Tue, 13 Oct 2026 16:23:21 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A0CD10E20E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 16:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVMegPrY6WbRQpZG5QkPvSo97u4Nf4hygVEODZ1keDUNnGn5bwRzNfqNl8IkHO+DbZ1Uge5rork1WgABHOHHG5KzRxNyN/6LPj4wiTsRAnKAW2GpFF3P/DMz9RRQ7sXMKk0Mhi332StJm34v9r5CcEUH/aH+CmRMhiqdDZl9VJNbQdaVPlraS3BgFap1bOzgZUc2lThEZ+qXa7RdSa0a1bq4HxZhsfu80aSkIhUgKGsYVaS/h17ILEnI9o5Cxk6mVx0BRL597b1hKndDvJGmBjY/h+AU+DjSy7tX7S1O3ELzQyIww7R1QNdcGwsEYzcXPI/5+6FdOM3ueIVDChaFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEyPvPbPw3fTYTpEA7M5ETDQRVTZHmUh25pNRHOWj+A=;
 b=DdDajVkR6IQi/Xd1n5E/V9fxNmsoAsmuItz0W6aUtLIaeKOnk41q/BXnm2wQx6YHj29QSlDevx53FI4OLnoeDSj9lGEpjQlVENXcQ8BQxcFl5q6Kyoqw9+SP9iZf8uDQ8QUTc1Kgeiuh0FzsFeJVyyr/3N3uXMIF31cCUPIRwuN4sJst+FL5ftiTHYLh0NIenpdSg1FLwrF1tkWfXkT4y8S+NutmMaHV50svZuyIbBhaSB0pRDrscDsDVfVlg+xOt1TbxHxwCMu1TfuUvr7P015gjoZl/zMlXIjHQ1yEvkSiDgD5HJ3b4JxJHvGAUnwdQtJg9sB7z2PxV+I2LbNscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEyPvPbPw3fTYTpEA7M5ETDQRVTZHmUh25pNRHOWj+A=;
 b=jJgfCRgixAIXVPcoM4WbXVnITZ58sMeuR35XB2K+H3tzwwFfGLUvj1wWZA30lndqtremmQNMAdelQ7/MeiRXk2MRWYel7pLKchc9b6PG4Ws2dRWvm1raBP5TFIPcNlAYmlqzjipK4IQHO9sL7X9rglfElrlcFtMdwT7/z+ezR6w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by LY0PR12MB281605.namprd12.prod.outlook.com (2603:10b6:404:21d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 16:23:13 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 16:23:12 +0000
Message-ID: <710352c2-906f-4f53-90ed-132b3a352976@amd.com>
Date: Tue, 13 Oct 2026 10:23:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amd/display: Simplify debugfs token parsing
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>
References: <20260924114049.55201-3-tvrtko.ursulin@igalia.com>
 <20261002081041.69497-1-tvrtko.ursulin@igalia.com>
 <70806b81-227e-48b7-a839-0c9092d61496@amd.com>
 <62d736bb-ec8b-470c-a22a-3cf3b97975d5@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <62d736bb-ec8b-470c-a22a-3cf3b97975d5@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0270.namprd04.prod.outlook.com
 (2603:10b6:303:88::35) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|LY0PR12MB281605:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b46dad-c546-4695-fe94-08df294646d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|22082099003|10067099003|18002099003|3023799007|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: hsViDMkWq/6K/plakqFXjPrrtzhsqN/mNUsqUrbc2zLaVaPJiigU6j7U0kjTBILSxTPU2i/WeIS4PFY5/jzbsT8+NwihDhShF++0+4SF40sWXIhICDt9gaiQ9FcJT5DA8ADQ3mcvjOssgAw801K11QtZV0AzwSAhl8ydoaGOdfkwGJhJeb+/5+azCYBGm4d4+ngcFviB/vtcUt2TENVhnW3ghn+B39FkD+PwKmFIY0qksAsiSuAHcJY4+gg0mw+uDqitzZd8PYNxBuN5wcQzlpUNsPV7XgymVN00zdnW/fbMoJvahHG2vSMqJ0eRXX/HzcMZcgVpq7AmcZjAKKfDp+V36LuL/mGQT7/hyM8aBoWWRkkxugyPGFwpQdS1FxM4uOusyLtNOopPpqMXboPH7bvlhwKEr2rnEJU6a4zqY+DINa1whmAfJ2PkKrqMpM9LOc8C/wF7HGWJ/1GbAcbSLRCmQ2gPygkVUhxUgctuVyxvKJP+kuQXlhmid9ufsnIkEX0ZIbXPcKF8o/6S5GYcPpd8/kvcsCUOsYbZP1ZReLnpZExSjyqzH+ptBCNM5XFpWt2Fp7lnIcx15qqRYbBr7aUao7fMYxdnIlkQWpS6hPn3uc5JNKHTKea03meoEHkS88bnskceBTGIm66DdZkPveEqJ5TkT2YYhaI64so1Tsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(22082099003)(10067099003)(18002099003)(3023799007)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDhpUzU5cjVET2NITDUva0R4eklZQVFQU21HRXV3QzJQOGVsS2JKSFVBN2h1?=
 =?utf-8?B?Y3F0cjZqaTJMRGk1aW1TRlpKcUgybEx4ckhoVXBUaVFQSnhQWmdWQldTZmM1?=
 =?utf-8?B?alYrSWlTbHZiNmxyVldkRlZDU09pVUI5UU43RzhUZW1yRHZTMXRuYytTUnJT?=
 =?utf-8?B?bUk5NkhiOVRPbnkxbjVUWU5RVXZNdGxLdTU2bm81V0pVQ0tsWjZWRmdlVms5?=
 =?utf-8?B?MmtCcTVPTldZaVFvbk5PL2hPK2JCb3E5THN1L0M2b2NIVVNhTmhEMWNoQ3Vy?=
 =?utf-8?B?WmlmdkVOOS8xdU5DS05aMHR3dFE4TUN1ZmhKWDFXcE1qRlBYd2o3aUNqcXh2?=
 =?utf-8?B?VWdQNWlVam5UTC9aSG56Vlh4NXRzaGRoejFQQXFuWVVBcWZCTDc2cTZDdytW?=
 =?utf-8?B?MUlPcEVPbVZmSlQ0d29mbGFnbHpSV3lOMEZ1aVNOYjRjTWtOLzBkaDlsZ2g1?=
 =?utf-8?B?YU9iT09QaUQvdkd1KzV0VnlSWjlpUHduaWlYVS9uaitRR1J1RzE3YS9HbHZv?=
 =?utf-8?B?QVoxYU5KdmpUSnd3aVBNVDhOTjVrSjVQVmc4b3NKZVgrT0s1NVRJRy9PSFVB?=
 =?utf-8?B?SDV1S1Y4NHd1QUtVa2hKa0k5cVRtTWxIdkhVOTBUSUF5aDBsL1Y2NHZIMkhF?=
 =?utf-8?B?WW44ZmlveWptZ3hyekY1aXUrRmw2VHZVcFhiQ3ovdkEvUmEyaFVlSGJuV3BV?=
 =?utf-8?B?clZMcm1VMzVaZUhZeTlSanBVNFE5VjQ5K3FRSk1BOHNzcEFleTMyZytxZ1M0?=
 =?utf-8?B?T0llKzhTVGdFVnp1K3p5SDJObkdua0NwK3A4M05GcXQvMUVYc2IyUStlb2Fn?=
 =?utf-8?B?R2pML2RIZWVpTzdKcmtzYmpNMGlsR3BtKzZSVUVRdHlLdnIxaS9jUHFYQ3pi?=
 =?utf-8?B?eW1ZM0tGVzAwS0dHUVRub05WZnE5SHc5bXpTekhJQU93TFRUK3pCR0pPYXA2?=
 =?utf-8?B?WmxnYTN4SGRnR1JObldxSC80bnhaclRkMnFmdi93RGt5YS9lYVhNMXFVSG9m?=
 =?utf-8?B?Yko0VXF6dFl2dlFVR0VyT0EvVnhPRkorVGFyOUJkdjBRc1V6c1psZU5BSkcy?=
 =?utf-8?B?WjRGVFBKQVFhN3A5eUhIYU9iYnZnU3JJV0tBUEZKaGoxcHdVZUljVERST0hp?=
 =?utf-8?B?VDVPdnhRSW55OVNKamxwSk04VHZNbDExVE9uNGlFdUVzSDdGa2VNa014dHRV?=
 =?utf-8?B?TkdHeDNYeCtQM2JhSXgrOTk2a01icEhCRGx5ZDBjMXB6N3kxUVdiRk1SUUlW?=
 =?utf-8?B?YVZxaElxMFgzcUR1V1IrQWNtQmtrVG02NlpDRmdwelNrcjJkazhGeXZBUTk4?=
 =?utf-8?B?RWYzUzZvU21GSm02Tk5SZTR2TGExcHg5R1lYS3NrZ2dmMUNmdWZhZ0N2RHU3?=
 =?utf-8?B?c041VklGWXBRYUZkQ0U1WkI3anI0NTFZNnFoWThsbDVIeG5wYnZDWE43MXRN?=
 =?utf-8?B?UW5qa3J3enhkOHhlQjZJWWo4aG80WFV0Z3h1djFkdTlrUmdVZ2ZjU3JwTy9n?=
 =?utf-8?B?cy9xbzYwUUdWc2VmM0NudTN0N0JwL2FxdHFLcmVvZ3dvaXQwQmlnSkJpYVRN?=
 =?utf-8?B?MERNc29UV2RnaDJpQkQvSEpIN1ptdjh6UXRwazJBRnNOVDRJcGY4UnBTYVlS?=
 =?utf-8?B?NFhCbWZTaStCOGVNWkZzdDRndVZPL2p0MmxnV2JheTFkeHdQcGVXTW82OG5L?=
 =?utf-8?B?ak10Qm5zSUJpenlHWHZaL3BJYlhpZDBsTGtnMWZxdGJOdHRGNVU1UTlWS3A3?=
 =?utf-8?B?b3lpSXlxbk1yVTc4eUl2YmZOdGQ2dk9kbjRRTTR4bUpBM29zeis3aHJucHR2?=
 =?utf-8?B?bjVlV0szUzdrWXRPWGQwZThKbEJlRXV0NC9ZSGdndlU1Y3pHem9IZFFsZkww?=
 =?utf-8?B?NTJEaUc0UFRvSzM5SlF6VHJyV0YzWXBhaUFBWGNtWUtwNXhxU1N4VGUwcFNH?=
 =?utf-8?B?b2RLS05pK0N6M05Yajg0NHdSRFpWVGRZVXVhazJHYUgyZ0ZRRTNBTzgyemgx?=
 =?utf-8?B?WWFkQUVEcGxTbEZ5R1k2RlJKam1sWDl3R2s4eWtOZVg1UTVYTWpuajREdGxY?=
 =?utf-8?B?eWpMN0FPb3owelJqRG9iMUdYNjR6a2w2UFVoLzREaXRLWnNIOHI0aXEvV01w?=
 =?utf-8?B?bnp1cVNDcDJnYUtMMmZDQVVXdVRIVzZSdkdLR1hQNm1wTkdjNFJMQ0lvcjBY?=
 =?utf-8?B?eXNiTWU1QjBzakFyWHdlTWNNTkp1azM0VTFwUlZuRmh0UUZSQ0NBK3RqeS9v?=
 =?utf-8?B?aFIwaWZERE5xTUpwb0hqaTl1OFZ3cGl6djVQRXIwUEZWTC9jWGxjdGs0YWpT?=
 =?utf-8?Q?6ruDUxtXztA8Ms0jFL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b46dad-c546-4695-fe94-08df294646d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 16:23:12.5544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5jvxIBbDc3foFQ0dmaS3w8wEdXFKg3R3wdrtMN1hrpBDJ6Qh5y3wT26OH4+DF3mvWVDEO0DT5Q2lEwqELI7LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB281605
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



On 10/12/26 02:04, Tvrtko Ursulin wrote:
> 
> Hi Alex,
> 
> On 10/10/2026 03:16, Alex Hung wrote:
>> Hi Tvrtko,
>>
>> checkpatch reports the following warnings and errors:
>>
>> WARNING: 'lenght' may be misspelled - perhaps 'length'?
>> #21:
>> always copying a hardcoded lenght regardless of what the userspace had
>>                             ^^^^^^
>>
>> ERROR: that open brace { should be on the previous line
>> #349: FILE: drivers/gpu/drm/amd/display/amdgpu_dm/ 
>> amdgpu_dm_debugfs.c:652:
>> +    struct dc_link_settings prefer_link_settings =
>> +        {LANE_COUNT_UNKNOWN, LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
>>
>> ERROR: that open brace { should be on the previous line
>> #351: FILE: drivers/gpu/drm/amd/display/amdgpu_dm/ 
>> amdgpu_dm_debugfs.c:654:
>> +    struct dc_link_settings cur_link_settings =
>> +        {LANE_COUNT_UNKNOWN, LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
>>
>> total: 2 errors, 1 warnings, 813 lines checked
> 
> Okay I can fix that, no problem. And if I do that I can expect further 
> review ie. AMD is receptive to this type of a change? Or should we 
> perahps do a deeper review before checkpatch tweaks to reduce the number 
> of potential respins? The thing is, AFAIR, I only smoke tested it by 
> reading one of the modified debugfs files so what would really be good 
> if you or someone on AMD side who knows how to use these tunables, and 
> has the required hardware (I don't), would exercise it a bit.

Yes the changes look fine, and we tested in our weekly promotion test 
and no regression found. There are also IGT test 
(amd_ilr@ilr-link-training-configs) that use debugfs and it was tested too.

We will send it to another round of test and reviews since a v4 was 
received.

> 
> Regards,
> 
> Tvrtko
> 
>> On 10/2/26 02:10, Tvrtko Ursulin wrote:
>>> The current token parsing is complicated, conflicting with itself, 
>>> broken,
>>> and also results in a lot of duplicated code throughout.
>>>
>>> Lets simplify it by replacing the two pass (count arguments + parse 
>>> them)
>>> with a single strsep driven pass. The current two passes disagree on the
>>> set of separators and this makes it consistent.
>>>
>>> Then we also pull all of the repeated boiler plate into the helper -
>>> buffer allocation, copying, checking pre- and post-conditions. This
>>> removes a lot of the error handling from all the callers.
>>>
>>> And another bug fixed, lucikly mostly harmless, where copy_from_user was
>>> always copying a hardcoded lenght regardless of what the userspace had
>>> actually written. Assuming the userspace memory was backed it would copy
>>> neighbouring garbage into the string to be passed, or -EFAULT in theory
>>> but probably none of the exercised callers to date constructed their
>>> buffers in a way that can hit the latter.
>>>
>>> There are some behavioural differences though to call out:
>>>
>>>   * Before tabs were counted as separators but never split on. Now they
>>>     become full separators.
>>>
>>>   * Previously argument counting stopped on a newline but parsing was
>>>     considering them as separators. Now they are always considered
>>>     separators.
>>>
>>>   * kstrotol failures used to be logged but assumed zero argument. 
>>> Now the
>>>     code errors out.
>>>
>>>   * dp_dsc_passthrough_set had no error handling and writes with no
>>>     parameters but not otherwise invalid would silently result in a
>>>     successful disable of dsc_force_disable_passthrough. Now the debugfs
>>>     write would fail.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Cc: Harry Wentland <harry.wentland@amd.com>
>>> Cc: Leo Li <sunpeng.li@amd.com>
>>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>>> Cc: Alex Hung <alex.hung@amd.com>
>>> ---
>>> v2:
>>>   * Fixed buffer leak.
>>>   * Improved commit text.
>>>
>>> v3:
>>>   * Undo some over-eager initialization removals. (Alex)
>>> ---
>>>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 540 ++++--------------
>>>   1 file changed, 124 insertions(+), 416 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/ 
>>> amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/ 
>>> amdgpu_dm_debugfs.c
>>> index 969e1361a5da..ee2675909e4a 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>>> @@ -67,76 +67,46 @@ static const char *const mst_progress_status[] = {
>>>       "clear_allocated_payload",
>>>   };
>>> -/* parse_write_buffer_into_params - Helper function to parse debugfs 
>>> write buffer into an array
>>> +/* parse_params - Helper function to parse debugfs write buffer into 
>>> an array
>>>    *
>>> - * Function takes in attributes passed to debugfs write entry
>>> - * and writes into param array.
>>> - * The user passes max_param_num to identify maximum number of
>>> - * parameters that could be parsed.
>>> + * Function takes in attributes passed to debugfs write entry and 
>>> writes into
>>> + * param array.
>>>    *
>>> + * The user passes max_param_num to identify maximum number of 
>>> parameters that
>>> + * could be parsed.
>>> + *
>>> + * Returns zero on success or a negative error code.
>>>    */
>>> -static int parse_write_buffer_into_params(char *wr_buf, uint32_t 
>>> wr_buf_size,
>>> -                      long *param, int max_param_num,
>>> -                      uint8_t *param_nums)
>>> +static int parse_params(const char __user *ubuf, size_t size,
>>> +            long *param, unsigned int max_params)
>>>   {
>>> -    char *wr_buf_ptr = NULL;
>>> -    uint32_t wr_buf_count = 0;
>>> -    int r;
>>> -    char *sub_str = NULL;
>>> -    const char delimiter[3] = {' ', '\n', '\0'};
>>> -    uint8_t param_index = 0;
>>> +    char *buf, *tmp, *token;
>>> +    int ret = -EINVAL;
>>> +    unsigned int i;
>>> -    *param_nums = 0;
>>> +    if (size == 0)
>>> +        return -EINVAL;
>>> -    wr_buf_ptr = wr_buf;
>>> +    buf = memdup_user_nul(ubuf, size);
>>> +    if (IS_ERR(buf))
>>> +        return PTR_ERR(buf);
>>> -    /* check number of parameters. isspace could not differ space 
>>> and \n */
>>> -    while ((*wr_buf_ptr != 0xa) && (wr_buf_count < wr_buf_size)) {
>>> -        /* skip space*/
>>> -        while (isspace(*wr_buf_ptr) && (wr_buf_count < wr_buf_size)) {
>>> -            wr_buf_ptr++;
>>> -            wr_buf_count++;
>>> -            }
>>> +    i = 0;
>>> +    tmp = buf;
>>> +    while ((token = strsep(&tmp, " \t\r\n")) != NULL) {
>>> +        if (!*token)
>>> +            continue;
>>> -        if (wr_buf_count == wr_buf_size)
>>> +        if (i == max_params)
>>>               break;
>>> -        /* skip non-space*/
>>> -        while ((!isspace(*wr_buf_ptr)) && (wr_buf_count < 
>>> wr_buf_size)) {
>>> -            wr_buf_ptr++;
>>> -            wr_buf_count++;
>>> -        }
>>> -
>>> -        (*param_nums)++;
>>> -
>>> -        if (wr_buf_count == wr_buf_size)
>>> +        ret = kstrtol(token, 16, &param[i++]);
>>> +        if (ret)
>>>               break;
>>>       }
>>> -    if (*param_nums > max_param_num)
>>> -        *param_nums = max_param_num;
>>> -
>>> -    wr_buf_ptr = wr_buf; /* reset buf pointer */
>>> -    wr_buf_count = 0; /* number of char already checked */
>>> -
>>> -    while (isspace(*wr_buf_ptr) && (wr_buf_count < wr_buf_size)) {
>>> -        wr_buf_ptr++;
>>> -        wr_buf_count++;
>>> -    }
>>> -
>>> -    while (param_index < *param_nums) {
>>> -        /* after strsep, wr_buf_ptr will be moved to after space */
>>> -        sub_str = strsep(&wr_buf_ptr, delimiter);
>>> -
>>> -        r = kstrtol(sub_str, 16, &(param[param_index]));
>>> -
>>> -        if (r)
>>> -            DRM_DEBUG_DRIVER("string to int convert error code: 
>>> %d\n", r);
>>> -
>>> -        param_index++;
>>> -    }
>>> -
>>> -    return 0;
>>> +    kfree(buf);
>>> +    return ret;
>>>   }
>>>   /* function description
>>> @@ -248,36 +218,18 @@ static ssize_t dp_link_settings_write(struct 
>>> file *f, const char __user *buf,
>>>                    size_t size, loff_t *pos)
>>>   {
>>>       struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
>>> -    struct dc_link *link = connector->dc_link;
>>>       struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
>>> -    struct dc *dc = (struct dc *)link->dc;
>>>       struct dc_link_settings prefer_link_settings = {0};
>>> -    const uint32_t wr_buf_size = 40;
>>> +    struct dc_link *link = connector->dc_link;
>>> +    struct dc *dc = (struct dc *)link->dc;
>>> +    bool valid_input = true;
>>>       /* 0: lane_count; 1: link_rate */
>>> -    int max_param_num = 2;
>>> -    uint8_t param_nums = 0;
>>>       long param[2];
>>> -    char *wr_buf;
>>> -    bool valid_input = true;
>>> +    int r;
>>> -    if (size == 0)
>>> -        return -EINVAL;
>>> -
>>> -    wr_buf = memdup_user_nul(buf, wr_buf_size);
>>> -    if (IS_ERR(wr_buf))
>>> -        return PTR_ERR(wr_buf);
>>> -
>>> -    if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>> -                       param, max_param_num, &param_nums)) {
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    if (param_nums <= 0) {
>>> -        kfree(wr_buf);
>>> -        DRM_DEBUG_DRIVER("user data not be read\n");
>>> -        return -EINVAL;
>>> -    }
>>> +    r = parse_params(buf, size, param, 2);
>>> +    if (r)
>>> +        return r;
>>>       switch (param[0]) {
>>>       case LANE_COUNT_ONE:
>>> @@ -308,7 +260,6 @@ static ssize_t dp_link_settings_write(struct file 
>>> *f, const char __user *buf,
>>>       }
>>>       if (!valid_input) {
>>> -        kfree(wr_buf);
>>>           DRM_DEBUG_DRIVER("Invalid Input value No HW will be 
>>> programmed\n");
>>>           mutex_lock(&adev->dm.dc_lock);
>>>           dc_link_set_preferred_training_settings(dc, NULL, NULL, 
>>> link, false);
>>> @@ -328,7 +279,6 @@ static ssize_t dp_link_settings_write(struct file 
>>> *f, const char __user *buf,
>>>       dc_link_set_preferred_training_settings(dc, 
>>> &prefer_link_settings, NULL, link, false);
>>>       mutex_unlock(&adev->dm.dc_lock);
>>> -    kfree(wr_buf);
>>>       return size;
>>>   }
>>> @@ -380,39 +330,21 @@ static ssize_t dp_mst_link_setting(struct file 
>>> *f, const char __user *buf,
>>>                    size_t size, loff_t *pos)
>>>   {
>>>       struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
>>> -    struct dc_link *link = aconnector->dc_link;
>>>       struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
>>> -    struct dc *dc = (struct dc *)link->dc;
>>>       struct dc_link_settings prefer_link_settings = {0};
>>> -    const uint32_t wr_buf_size = 40;
>>> +    struct dc_link *link = aconnector->dc_link;
>>> +    struct dc *dc = (struct dc *)link->dc;
>>>       /* 0: lane_count; 1: link_rate */
>>> -    int max_param_num = 2;
>>> -    uint8_t param_nums = 0;
>>> -    long param[2];
>>> -    char *wr_buf;
>>>       bool valid_input = true;
>>> +    long param[2];
>>> +    int r;
>>>       if (!dp_mst_is_end_device(aconnector))
>>>           return -EINVAL;
>>> -    if (size == 0)
>>> -        return -EINVAL;
>>> -
>>> -    wr_buf = memdup_user_nul(buf, wr_buf_size);
>>> -    if (IS_ERR(wr_buf))
>>> -        return PTR_ERR(wr_buf);
>>> -
>>> -    if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>> -                       param, max_param_num, &param_nums)) {
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    if (param_nums <= 0) {
>>> -        kfree(wr_buf);
>>> -        DRM_DEBUG_DRIVER("user data not be read\n");
>>> -        return -EINVAL;
>>> -    }
>>> +    r = parse_params(buf, size, param, 2);
>>> +    if (r)
>>> +        return r;
>>>       switch (param[0]) {
>>>       case LANE_COUNT_ONE:
>>> @@ -440,7 +372,6 @@ static ssize_t dp_mst_link_setting(struct file 
>>> *f, const char __user *buf,
>>>       }
>>>       if (!valid_input) {
>>> -        kfree(wr_buf);
>>>           DRM_DEBUG_DRIVER("Invalid Input value No HW will be 
>>> programmed\n");
>>>           mutex_lock(&adev->dm.dc_lock);
>>>           dc_link_set_preferred_training_settings(dc, NULL, NULL, 
>>> link, false);
>>> @@ -473,7 +404,6 @@ static ssize_t dp_mst_link_setting(struct file 
>>> *f, const char __user *buf,
>>>       mutex_unlock(&aconnector->base.dev->mode_config.mutex);
>>>       drm_kms_helper_hotplug_event(aconnector->base.dev);
>>> -    kfree(wr_buf);
>>>       return size;
>>>   }
>>> @@ -599,41 +529,20 @@ static ssize_t dp_phy_settings_write(struct 
>>> file *f, const char __user *buf,
>>>                    size_t size, loff_t *pos)
>>>   {
>>>       struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
>>> -    struct dc_link *link = connector->dc_link;
>>> -    struct dc *dc = (struct dc *)link->dc;
>>> -    uint32_t wr_buf_size = 40;
>>> -    long param[3];
>>> -    bool use_prefer_link_setting;
>>>       struct link_training_settings link_lane_settings = {0};
>>> -    int max_param_num = 3;
>>> -    uint8_t param_nums = 0;
>>> -    char *wr_buf;
>>> -    int r = 0;
>>> -
>>> -
>>> -    if (size == 0)
>>> -        return -EINVAL;
>>> -
>>> -    wr_buf = memdup_user_nul(buf, wr_buf_size);
>>> -    if (IS_ERR(wr_buf))
>>> -        return PTR_ERR(wr_buf);
>>> -
>>> -    if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>> -                       param, max_param_num, &param_nums)) {
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    if (param_nums <= 0) {
>>> -        kfree(wr_buf);
>>> -        DRM_DEBUG_DRIVER("user data not be read\n");
>>> -        return -EINVAL;
>>> -    }
>>> +    struct dc_link *link = connector->dc_link;
>>> +    struct dc *dc = (struct dc *)link->dc;
>>> +    bool use_prefer_link_setting;
>>> +    long param[3];
>>> +    int r;
>>> +
>>> +    r = parse_params(buf, size, param, 3);
>>> +    if (r)
>>> +        return r;
>>>       if ((param[0] > VOLTAGE_SWING_MAX_LEVEL) ||
>>>               (param[1] > PRE_EMPHASIS_MAX_LEVEL) ||
>>>               (param[2] > POST_CURSOR2_MAX_LEVEL)) {
>>> -        kfree(wr_buf);
>>>           DRM_DEBUG_DRIVER("Invalid Input No HW will be programmed\n");
>>>           return size;
>>>       }
>>> @@ -674,7 +583,6 @@ static ssize_t dp_phy_settings_write(struct file 
>>> *f, const char __user *buf,
>>>       /* program ASIC registers and DPCD registers */
>>>       dc_link_set_drive_settings(dc, &link_lane_settings, link);
>>> -    kfree(wr_buf);
>>>       return size;
>>>   }
>>> @@ -740,47 +648,25 @@ static ssize_t 
>>> dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
>>>                    size_t size, loff_t *pos)
>>>   {
>>>       struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
>>> -    struct dc_link *link = connector->dc_link;
>>> -    uint32_t wr_buf_size = 100;
>>> -    long param[11] = {0x0};
>>> -    int max_param_num = 11;
>>> +    struct dc_link_settings prefer_link_settings =
>>> +        {LANE_COUNT_UNKNOWN, LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
>>> +    struct dc_link_settings cur_link_settings =
>>> +        {LANE_COUNT_UNKNOWN, LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
>>>       enum dp_test_pattern test_pattern = DP_TEST_PATTERN_UNSUPPORTED;
>>> -    bool disable_hpd = false;
>>> +    struct dc_link *link = connector->dc_link;
>>>       bool supports_hpd = link->irq_source_hpd != DC_IRQ_SOURCE_INVALID;
>>> -    bool valid_test_pattern = false;
>>> -    uint8_t param_nums = 0;
>>>       /* init with default 80bit custom pattern */
>>> -    uint8_t custom_pattern[10] = {
>>> -            0x1f, 0x7c, 0xf0, 0xc1, 0x07,
>>> -            0x1f, 0x7c, 0xf0, 0xc1, 0x07
>>> -            };
>>> -    struct dc_link_settings prefer_link_settings = {LANE_COUNT_UNKNOWN,
>>> -            LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
>>> -    struct dc_link_settings cur_link_settings = {LANE_COUNT_UNKNOWN,
>>> -            LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
>>> +    uint8_t custom_pattern[10] = { 0x1f, 0x7c, 0xf0, 0xc1, 0x07,
>>> +                       0x1f, 0x7c, 0xf0, 0xc1, 0x07 };
>>>       struct link_training_settings link_training_settings = {0};
>>> -    char *wr_buf;
>>> -    int i;
>>> -
>>> -    if (size == 0)
>>> -        return -EINVAL;
>>> -
>>> -    wr_buf = memdup_user_nul(buf, wr_buf_size);
>>> -    if (IS_ERR(wr_buf))
>>> -        return PTR_ERR(wr_buf);
>>> -
>>> -    if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>> -                       param, max_param_num, &param_nums)) {
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    if (param_nums <= 0) {
>>> -        kfree(wr_buf);
>>> -        DRM_DEBUG_DRIVER("user data not be read\n");
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> +    bool valid_test_pattern = false;
>>> +    bool disable_hpd = false;
>>> +    long param[11] = {0x0};
>>> +    int i, r;
>>> +
>>> +    r = parse_params(buf, size, param, 11);
>>> +    if (r)
>>> +        return r;
>>>       test_pattern = param[0];
>>> @@ -811,7 +697,6 @@ static ssize_t 
>>> dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
>>>       }
>>>       if (!valid_test_pattern) {
>>> -        kfree(wr_buf);
>>>           DRM_DEBUG_DRIVER("Invalid Test Pattern Parameters\n");
>>>           return size;
>>>       }
>>> @@ -878,8 +763,6 @@ static ssize_t 
>>> dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
>>>       if (valid_test_pattern && supports_hpd && disable_hpd)
>>>           dc_link_disable_hpd(link);
>>> -    kfree(wr_buf);
>>> -
>>>       return size;
>>>   }
>>> @@ -1185,29 +1068,15 @@ static ssize_t dp_dsc_passthrough_set(struct 
>>> file *f, const char __user *buf,
>>>                    size_t size, loff_t *pos)
>>>   {
>>>       struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
>>> -    uint32_t wr_buf_size = 42;
>>> -    int max_param_num = 1;
>>>       long param;
>>> -    uint8_t param_nums = 0;
>>> -    char *wr_buf;
>>> +    int r;
>>> -    if (size == 0)
>>> -        return -EINVAL;
>>> -
>>> -    wr_buf = memdup_user_nul(buf, wr_buf_size);
>>> -    if (IS_ERR(wr_buf))
>>> -        return PTR_ERR(wr_buf);
>>> -
>>> -    if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>> -                       &param, max_param_num,
>>> -                       &param_nums)) {
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> +    r = parse_params(buf, size, &param, 1);
>>> +    if (r)
>>> +        return r;
>>>       aconnector->dsc_settings.dsc_force_disable_passthrough = param;
>>> -    kfree(wr_buf);
>>>       return 0;
>>>   }
>>> @@ -1440,40 +1309,20 @@ static ssize_t trigger_hotplug(struct file 
>>> *f, const char __user *buf,
>>>                               size_t size, loff_t *pos)
>>>   {
>>>       struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
>>> -    struct drm_connector *connector = &aconnector->base;
>>> -    struct dc_link *link = NULL;
>>> -    struct drm_device *dev = connector->dev;
>>> -    struct amdgpu_device *adev = drm_to_adev(dev);
>>>       enum dc_connection_type new_connection_type = dc_connection_none;
>>> -    uint32_t wr_buf_size = 42;
>>> -    int max_param_num = 1;
>>> +    struct drm_connector *connector = &aconnector->base;
>>> +    struct drm_device *dev = connector->dev;
>>> +    struct amdgpu_device *adev = drm_to_adev(dev);
>>> +    struct dc_link *link = NULL;
>>>       long param[1] = {0};
>>> -    uint8_t param_nums = 0;
>>> -    bool ret = false;
>>> -    char *wr_buf;
>>> +    int r;
>>>       if (!aconnector->dc_link)
>>>           return -EINVAL;
>>> -    if (size == 0)
>>> -        return -EINVAL;
>>> -
>>> -    wr_buf = memdup_user_nul(buf, wr_buf_size);
>>> -    if (IS_ERR(wr_buf))
>>> -        return PTR_ERR(wr_buf);
>>> -
>>> -    if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>> -                       param, max_param_num, &param_nums)) {
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    kfree(wr_buf);
>>> -
>>> -    if (param_nums <= 0) {
>>> -        DRM_DEBUG_DRIVER("user data not be read\n");
>>> -        return -EINVAL;
>>> -    }
>>> +    r = parse_params(buf, size, param, 1);
>>> +    if (r)
>>> +        return r;
>>>       mutex_lock(&aconnector->hpd_lock);
>>> @@ -1484,6 +1333,7 @@ static ssize_t trigger_hotplug(struct file *f, 
>>> const char __user *buf,
>>>       }
>>>       if (param[0] == 1) {
>>> +        bool ret;
>>>           if (!dc_link_detect_connection_type(aconnector->dc_link, 
>>> &new_connection_type) &&
>>>               new_connection_type != dc_connection_none)
>>> @@ -1637,34 +1487,15 @@ static ssize_t dp_dsc_clock_en_write(struct 
>>> file *f, const char __user *buf,
>>>       struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
>>>       struct drm_connector *connector = &aconnector->base;
>>>       struct drm_device *dev = connector->dev;
>>> +    struct dm_crtc_state *dm_crtc_state;
>>>       struct drm_crtc *crtc = NULL;
>>> -    struct dm_crtc_state *dm_crtc_state = NULL;
>>>       struct pipe_ctx *pipe_ctx;
>>> -    int i;
>>> -    uint32_t wr_buf_size = 42;
>>> -    int max_param_num = 1;
>>>       long param[1] = {0};
>>> -    uint8_t param_nums = 0;
>>> -    char *wr_buf;
>>> +    int i, r;
>>> -    if (size == 0)
>>> -        return -EINVAL;
>>> -
>>> -    wr_buf = memdup_user_nul(buf, wr_buf_size);
>>> -    if (IS_ERR(wr_buf))
>>> -        return PTR_ERR(wr_buf);
>>> -
>>> -    if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>> -                       param, max_param_num, &param_nums)) {
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    if (param_nums <= 0) {
>>> -        DRM_DEBUG_DRIVER("user data not be read\n");
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> +    r = parse_params(buf, size, param, 1);
>>> +    if (r)
>>> +        return r;
>>>       for (i = 0; i < MAX_PIPES; i++) {
>>>           pipe_ctx = &aconnector->dc_link->dc->current_state- 
>>> >res_ctx.pipe_ctx[i];
>>> @@ -1676,7 +1507,7 @@ static ssize_t dp_dsc_clock_en_write(struct 
>>> file *f, const char __user *buf,
>>>       }
>>>       if (!pipe_ctx->stream)
>>> -        goto done;
>>> +        return size;
>>>       // Get CRTC state
>>>       mutex_lock(&dev->mode_config.mutex);
>>> @@ -1712,8 +1543,6 @@ static ssize_t dp_dsc_clock_en_write(struct 
>>> file *f, const char __user *buf,
>>>       drm_modeset_unlock(&dev->mode_config.connection_mutex);
>>>       mutex_unlock(&dev->mode_config.mutex);
>>> -done:
>>> -    kfree(wr_buf);
>>>       return size;
>>>   }
>>> @@ -1814,36 +1643,17 @@ static ssize_t 
>>> dp_dsc_slice_width_write(struct file *f, const char __user *buf,
>>>                        size_t size, loff_t *pos)
>>>   {
>>>       struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
>>> -    struct pipe_ctx *pipe_ctx;
>>>       struct drm_connector *connector = &aconnector->base;
>>>       struct drm_device *dev = connector->dev;
>>> +    struct dm_crtc_state *dm_crtc_state;
>>>       struct drm_crtc *crtc = NULL;
>>> -    struct dm_crtc_state *dm_crtc_state = NULL;
>>> -    int i;
>>> -    uint32_t wr_buf_size = 42;
>>> -    int max_param_num = 1;
>>> +    struct pipe_ctx *pipe_ctx;
>>>       long param[1] = {0};
>>> -    uint8_t param_nums = 0;
>>> -    char *wr_buf;
>>> +    int i, r;
>>> -    if (size == 0)
>>> -        return -EINVAL;
>>> -
>>> -    wr_buf = memdup_user_nul(buf, wr_buf_size);
>>> -    if (IS_ERR(wr_buf))
>>> -        return PTR_ERR(wr_buf);
>>> -
>>> -    if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>> -                       param, max_param_num, &param_nums)) {
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    if (param_nums <= 0) {
>>> -        DRM_DEBUG_DRIVER("user data not be read\n");
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> +    r = parse_params(buf, size, param, 1);
>>> +    if (r)
>>> +        return r;
>>>       for (i = 0; i < MAX_PIPES; i++) {
>>>           pipe_ctx = &aconnector->dc_link->dc->current_state- 
>>> >res_ctx.pipe_ctx[i];
>>> @@ -1855,7 +1665,7 @@ static ssize_t dp_dsc_slice_width_write(struct 
>>> file *f, const char __user *buf,
>>>       }
>>>       if (!pipe_ctx->stream)
>>> -        goto done;
>>> +        return size;
>>>       // Safely get CRTC state
>>>       mutex_lock(&dev->mode_config.mutex);
>>> @@ -1891,8 +1701,6 @@ static ssize_t dp_dsc_slice_width_write(struct 
>>> file *f, const char __user *buf,
>>>       drm_modeset_unlock(&dev->mode_config.connection_mutex);
>>>       mutex_unlock(&dev->mode_config.mutex);
>>> -done:
>>> -    kfree(wr_buf);
>>>       return size;
>>>   }
>>> @@ -1995,34 +1803,15 @@ static ssize_t 
>>> dp_dsc_slice_height_write(struct file *f, const char __user *buf,
>>>       struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
>>>       struct drm_connector *connector = &aconnector->base;
>>>       struct drm_device *dev = connector->dev;
>>> +    struct dm_crtc_state *dm_crtc_state;
>>>       struct drm_crtc *crtc = NULL;
>>> -    struct dm_crtc_state *dm_crtc_state = NULL;
>>>       struct pipe_ctx *pipe_ctx;
>>> -    int i;
>>> -    uint32_t wr_buf_size = 42;
>>> -    int max_param_num = 1;
>>> -    uint8_t param_nums = 0;
>>>       long param[1] = {0};
>>> -    char *wr_buf;
>>> +    int i, r;
>>> -    if (size == 0)
>>> -        return -EINVAL;
>>> -
>>> -    wr_buf = memdup_user_nul(buf, wr_buf_size);
>>> -    if (IS_ERR(wr_buf))
>>> -        return PTR_ERR(wr_buf);
>>> -
>>> -    if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>> -                       param, max_param_num, &param_nums)) {
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    if (param_nums <= 0) {
>>> -        DRM_DEBUG_DRIVER("user data not be read\n");
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> +    r = parse_params(buf, size, param, 1);
>>> +    if (r)
>>> +        return r;
>>>       for (i = 0; i < MAX_PIPES; i++) {
>>>           pipe_ctx = &aconnector->dc_link->dc->current_state- 
>>> >res_ctx.pipe_ctx[i];
>>> @@ -2034,7 +1823,7 @@ static ssize_t dp_dsc_slice_height_write(struct 
>>> file *f, const char __user *buf,
>>>       }
>>>       if (!pipe_ctx->stream)
>>> -        goto done;
>>> +        return size;
>>>       // Get CRTC state
>>>       mutex_lock(&dev->mode_config.mutex);
>>> @@ -2070,8 +1859,6 @@ static ssize_t dp_dsc_slice_height_write(struct 
>>> file *f, const char __user *buf,
>>>       drm_modeset_unlock(&dev->mode_config.connection_mutex);
>>>       mutex_unlock(&dev->mode_config.mutex);
>>> -done:
>>> -    kfree(wr_buf);
>>>       return size;
>>>   }
>>> @@ -2167,34 +1954,15 @@ static ssize_t 
>>> dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
>>>       struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
>>>       struct drm_connector *connector = &aconnector->base;
>>>       struct drm_device *dev = connector->dev;
>>> +    struct dm_crtc_state *dm_crtc_state;
>>>       struct drm_crtc *crtc = NULL;
>>> -    struct dm_crtc_state *dm_crtc_state = NULL;
>>>       struct pipe_ctx *pipe_ctx;
>>> -    int i;
>>> -    uint32_t wr_buf_size = 42;
>>> -    int max_param_num = 1;
>>> -    uint8_t param_nums = 0;
>>>       long param[1] = {0};
>>> -    char *wr_buf;
>>> +    int i, r;
>>> -    if (size == 0)
>>> -        return -EINVAL;
>>> -
>>> -    wr_buf = memdup_user_nul(buf, wr_buf_size);
>>> -    if (IS_ERR(wr_buf))
>>> -        return PTR_ERR(wr_buf);
>>> -
>>> -    if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>> -                       param, max_param_num, &param_nums)) {
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    if (param_nums <= 0) {
>>> -        DRM_DEBUG_DRIVER("user data not be read\n");
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> +    r = parse_params(buf, size, param, 1);
>>> +    if (r)
>>> +        return r;
>>>       for (i = 0; i < MAX_PIPES; i++) {
>>>           pipe_ctx = &aconnector->dc_link->dc->current_state- 
>>> >res_ctx.pipe_ctx[i];
>>> @@ -2206,7 +1974,7 @@ static ssize_t 
>>> dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
>>>       }
>>>       if (!pipe_ctx->stream)
>>> -        goto done;
>>> +        return size;
>>>       // Get CRTC state
>>>       mutex_lock(&dev->mode_config.mutex);
>>> @@ -2237,8 +2005,6 @@ static ssize_t 
>>> dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
>>>       drm_modeset_unlock(&dev->mode_config.connection_mutex);
>>>       mutex_unlock(&dev->mode_config.mutex);
>>> -done:
>>> -    kfree(wr_buf);
>>>       return size;
>>>   }
>>> @@ -2592,36 +2358,17 @@ static ssize_t dp_max_bpc_write(struct file 
>>> *f, const char __user *buf,
>>>   {
>>>       struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
>>>       struct drm_connector *connector = &aconnector->base;
>>> -    struct dm_connector_state *state;
>>>       struct drm_device *dev = connector->dev;
>>> -    uint32_t wr_buf_size = 42;
>>> -    int max_param_num = 1;
>>> +    struct dm_connector_state *state;
>>>       long param[1] = {0};
>>> -    uint8_t param_nums = 0;
>>> -    char *wr_buf;
>>> +    int r;
>>> -    if (size == 0)
>>> -        return -EINVAL;
>>> -
>>> -    wr_buf = memdup_user_nul(buf, wr_buf_size);
>>> -    if (IS_ERR(wr_buf))
>>> -        return PTR_ERR(wr_buf);
>>> -
>>> -    if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>> -                       param, max_param_num, &param_nums)) {
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    if (param_nums <= 0) {
>>> -        DRM_DEBUG_DRIVER("user data not be read\n");
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> +    r = parse_params(buf, size, param, 1);
>>> +    if (r)
>>> +        return r;
>>>       if (param[0] < 6 || param[0] > 16) {
>>>           DRM_DEBUG_DRIVER("bad max_bpc value\n");
>>> -        kfree(wr_buf);
>>>           return -EINVAL;
>>>       }
>>> @@ -2637,7 +2384,6 @@ static ssize_t dp_max_bpc_write(struct file *f, 
>>> const char __user *buf,
>>>       drm_modeset_unlock(&dev->mode_config.connection_mutex);
>>>       mutex_unlock(&dev->mode_config.mutex);
>>> -    kfree(wr_buf);
>>>       return size;
>>>   }
>>> @@ -2959,31 +2705,13 @@ static ssize_t hdmi_automation_enable(struct 
>>> file *f, const char __user *buf,
>>>       size_t size, loff_t *pos)
>>>   {
>>>       struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
>>> -    const uint32_t wr_buf_size = 40;
>>> -    int max_param_num = 1;
>>> -    uint8_t param_nums = 0;
>>>       bool hdmi_comp_auto;
>>> -    long param[2];
>>> -    char *wr_buf;
>>> +    long param[1] = {};
>>> +    int r;
>>> -    if (size == 0)
>>> -        return -EINVAL;
>>> -
>>> -    wr_buf = memdup_user_nul(buf, wr_buf_size);
>>> -    if (IS_ERR(wr_buf))
>>> -        return PTR_ERR(wr_buf);
>>> -
>>> -    if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>> -                       param, max_param_num, &param_nums)) {
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    if (param_nums <= 0) {
>>> -        kfree(wr_buf);
>>> -        DRM_DEBUG_DRIVER("user data not be read\n");
>>> -        return -EINVAL;
>>> -    }
>>> +    r = parse_params(buf, size, param, 1);
>>> +    if (r)
>>> +        return r;
>>>       switch (param[0]) {
>>>       case 0:
>>> @@ -2998,7 +2726,6 @@ static ssize_t hdmi_automation_enable(struct 
>>> file *f, const char __user *buf,
>>>       /* Persist setting across sink re-detection/hotplug. */
>>>       aconnector->hdmi_comp_auto = hdmi_comp_auto;
>>> -    kfree(wr_buf);
>>>       return size;
>>>   }
>>> @@ -3768,39 +3495,22 @@ static ssize_t edp_ilr_write(struct file *f, 
>>> const char __user *buf,
>>>                    size_t size, loff_t *pos)
>>>   {
>>>       struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
>>> -    struct dc_link *link = connector->dc_link;
>>>       struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
>>> -    struct dc *dc = (struct dc *)link->dc;
>>>       struct dc_link_settings prefer_link_settings;
>>> -    const uint32_t wr_buf_size = 40;
>>> -    /* 0: lane_count; 1: link_rate */
>>> -    int max_param_num = 2;
>>> -    uint8_t param_nums = 0;
>>> -    long param[2];
>>> -    bool valid_input = true;
>>> -    uint8_t supported_link_rates[16] = {0};
>>> -    uint32_t entry = 0;
>>> +    struct dc_link *link = connector->dc_link;
>>> +    struct dc *dc = (struct dc *)link->dc;
>>> +    uint8_t supported_link_rates[16] = {};
>>>       uint32_t link_rate_in_khz = 0;
>>> +    /* 0: lane_count; 1: link_rate */
>>> +    bool valid_input = true;
>>>       uint8_t dpcd_rev = 0;
>>> -    char *wr_buf;
>>> +    uint32_t entry = 0;
>>> +    long param[2];
>>> +    int r;
>>> -    if (size == 0)
>>> -        return -EINVAL;
>>> -
>>> -    wr_buf = memdup_user_nul(buf, wr_buf_size);
>>> -    if (IS_ERR(wr_buf))
>>> -        return PTR_ERR(wr_buf);
>>> -
>>> -    if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>> -                       param, max_param_num, &param_nums)) {
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    if (param_nums <= 0) {
>>> -        kfree(wr_buf);
>>> -        return -EINVAL;
>>> -    }
>>> +    r = parse_params(buf, size, param, 2);
>>> +    if (r)
>>> +        return r;
>>>       switch (param[0]) {
>>>       case LANE_COUNT_ONE:
>>> @@ -3816,7 +3526,6 @@ static ssize_t edp_ilr_write(struct file *f, 
>>> const char __user *buf,
>>>           valid_input = false;
>>>       if (!valid_input) {
>>> -        kfree(wr_buf);
>>>           DRM_DEBUG_DRIVER("Invalid Input value. No HW will be 
>>> programmed\n");
>>>           prefer_link_settings.use_link_rate_set = false;
>>>           mutex_lock(&adev->dm.dc_lock);
>>> @@ -3853,7 +3562,6 @@ static ssize_t edp_ilr_write(struct file *f, 
>>> const char __user *buf,
>>>                           NULL, link, false);
>>>       mutex_unlock(&adev->dm.dc_lock);
>>> -    kfree(wr_buf);
>>>       return size;
>>>   }
>>
> 

