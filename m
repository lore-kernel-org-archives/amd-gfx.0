Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE77C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426DE61105
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 426DE61105
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C20606E0DC;
	Mon,  8 Nov 2021 14:31:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A3A86E0DC
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 14:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwUcLtGt1UVmO7TtKWZgVfal6oYGMb6DWshjEVYuiVw7nmy7LwawtM+d2f44MYxQvP10K/nOvASFMS356WvkbofvkTuj4DkTDymGAOWogNh4Z5BQ8+uSBN60NqbQMVbnrjKhFlEXeAYivblTg66L2Oz1D/SB//X/tZA1kJ/+rHgWt0mEvPH2plTU7qPQTKGAjt10xH3DfuqsM3iMRWMSAIKKDr9XRVBcvRAXPnTmeo+rR/wklI76EfAwvr4i+24MhCW60PSQUzRhRGTPk3Ka7tEViMXejTvD23RlE3vJ4HlSm4MPLFexsLSCxwtUWT8Cb8LlsOpo/BX4B8qTWWAxLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzTXrCzC9BlFaSXD8vileJomnAT4zYxMnCYV3W8t8mg=;
 b=Bjszro7qakP4fNmePubXw6Gg9fTvcIbcoCkBcEHwwYkxr7RK3u57oz5u921F7pwE+UxLigxiFCCyZa/eml5JdVTjjRvMJQ6KpKsXZJbXOJDpXdLKsvFKkwwphSFqRdHCm7x+7yYhNy8aoZbE//4onXXpOul/Et+T9GRZwa2ucbcCSODDpp52JsxvLwONuzMv23lxXO0+ZK5fFCBXgPhqxNAQIXpFhJA2A411VaSDhaJRdY3qkkbs2jlLzvgD531Rrk0djnArmokDfM8j/6g74LgkA2x8hRKN8/d4WZ7EEno6a5svb0AWaP04idMGUQKj2WZ3tE4I6Pu2fKHy/bzFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzTXrCzC9BlFaSXD8vileJomnAT4zYxMnCYV3W8t8mg=;
 b=tqg9M1yw9X1R/s4Uddtf/zvTUX9+KR2FlZIo5BLi/lgB0/bQy/Ur3MIubBoUX3eo1xN+mp5lvrGHS2lThy10yEuMtxSL5dMwq3vRcoF+WZRSG7E39oihEuX1IkUU4C7SzEBNqX+ZI/SZUf4Sdbn2deWIG7V1gGEHHrliHUdJtgU=
Authentication-Results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1264.namprd12.prod.outlook.com (2603:10b6:300:d::16)
 by MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Mon, 8 Nov
 2021 14:31:17 +0000
Received: from MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::7144:b327:ded5:3f50]) by MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::7144:b327:ded5:3f50%12]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 14:31:17 +0000
Message-ID: <3b70c5f5-dd93-10e3-543b-cdd0ad1a5dcf@amd.com>
Date: Mon, 8 Nov 2021 20:01:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/display: reject both non-zero src_x and src_y
 only for DCN1x
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, Shirish S <shirish.s@amd.com>
References: <20211108081514.9925-1-shirish.s@amd.com>
 <94d54215-6500-e5df-1069-71706431e059@molgen.mpg.de>
 <33c6efa7-3c7e-be2c-6513-f9ec82e63faf@amd.com>
 <1843f7b1-b1f6-71e1-4898-7cec98ff965d@molgen.mpg.de>
From: "S, Shirish" <sshankar@amd.com>
In-Reply-To: <1843f7b1-b1f6-71e1-4898-7cec98ff965d@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::7) To MWHPR12MB1264.namprd12.prod.outlook.com
 (2603:10b6:300:d::16)
MIME-Version: 1.0
Received: from [10.252.87.231] (165.204.159.242) by
 PN3PR01CA0089.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Mon, 8 Nov 2021 14:31:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e91f785d-2447-46b9-de4d-08d9a2c46c7b
X-MS-TrafficTypeDiagnostic: MW3PR12MB4361:
X-Microsoft-Antispam-PRVS: <MW3PR12MB43615EC0DB31987095E4D9AAF2919@MW3PR12MB4361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:209;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZUMpZSJhRggup+gteN+eyE/ONBxDQ0dXeWXZ3HewCUeCifJZipVXVtCV0lSv2E5se2QO5f/B/nkxPu27KtAqXX9O4KgvP1KwSH8obnQJw/ioIgB6E1ZyUZ/A2H9jEPmANrDEIchnrb72HI/inD24BhWMHUiYSzUX/Hsz3/Ea5Jbcuo3/3VVUxcJ2ggvABeWc+fPZmoosxtG0osV39xBumxFauiS7wZY2DDGoufjToZMcLmG0qL7xvkO9SMCyaf1FjPRseQ9EqWuXEQdJwTls3sZpGJJhlD08onCB5qpe18rs/nzB7C1M67zx84G9AXPFhcOBDCk9SRuta0da7u6T8XaNfF1j8ElvYAGlnBPWfOfefCi17pmzrqidWpMCuk26aLVsjdoSwO8d6nQ7DxqYa+s15XYQLSQE1WaJUR5xIdNPgmlff4ggM8hdubfPQpuO4/9AH1T65U7QWT47byJVj3Ctgl/8w3V/zV9HFAzKWJTBh65Z/ptNeAs0CIUm+22BTof89n87aI6XZZGAFLbrTsEluEH8k/8kPC59Y+kNxeKlzzlPxTGu+iqaaiq4iTeVJ13D7uXrHZZeRq//T5Zo/hIFbcFGpfijkZ9+c6oyy2rlN7iMEahKWzLj5ZhOZWJjUq249j1oU2UapDFCAyOZvPD27Lg4kkRJDfJLDXsRNeKJ+5r/gLjOo25fdd83XmNTZoLiCHTyuCbMUW2Q7+ImfmI8yS+U03I+s6GsP5r2v8kvQ2mukGDONLZ+ou2fWQbD9io45xpv3iN2y210TtLkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1264.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66476007)(66946007)(83380400001)(110136005)(2906002)(956004)(16576012)(316002)(4326008)(54906003)(31686004)(186003)(26005)(6636002)(53546011)(8936002)(8676002)(36756003)(5660300002)(38100700002)(508600001)(2616005)(6486002)(31696002)(6666004)(32563001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1RXMkNBYmpxSWxzUm8wT0hDaTZGNkhQb3gvR1I2K1hjWFlNMDNzZzNURWlp?=
 =?utf-8?B?MmtYdUo2SEU4Y3hEM3hzQm5nTDhDdE9NaWhENDhwKzJWWlBFK2hDS3J4NVJs?=
 =?utf-8?B?aWdkQm1qcncreFJ1QVFoSjZwK1VDOE1tZ1k1alR5eXM1bzgvaWVSc1Z0RVF6?=
 =?utf-8?B?eTNMQVFTMld6U2o3aW01MjY1Vkp6NFBWKzJWSzhGRDZOZDZ0cUVTVTk5bDJM?=
 =?utf-8?B?cW5NZXovMFc2M080YXRQMG1iTVRkeTcxcUZsT2NrT3pmdVIwcjh2K0ZhNDRJ?=
 =?utf-8?B?RlYxZzIrc2NxdDZyUHRXSjd2bTJVT0t5OWJOTkhWS1BGZ0FRaytCaGxZQzB6?=
 =?utf-8?B?VGZkcEhPTllCTjVCVjFXZmJqYWVzTkYrUHhwMEZPTkphdUtqUzg2ZFI1U09T?=
 =?utf-8?B?SGM0ZWpzZjFUNGFEeHRQdmhndUNCcG9qL3VRQS9YSW5PeTUxdW1aYUJhcTlM?=
 =?utf-8?B?MEp1U0EvZUNoeVBWeStUNXFIaUVJS2x5SmxZWENTUU5ibko3VXFGQWUyTGxo?=
 =?utf-8?B?NDd5bXZhWUczL0VnNHZrNDNnbnM2RmxNS2t6RVBVTWtRVEVwWkdDSFVJUU0w?=
 =?utf-8?B?Rk1IVDQySGVUUjE1VVFBQjd1a3dueUtTSnJ3RUxnK1E0YkFrWFBIQWI3Szhl?=
 =?utf-8?B?am90cnc5YUZOdFlETUVnMElBRldqZ0tXUjF1THpSTmxKd1ZtL3Y3amVIUHQx?=
 =?utf-8?B?bGh3ZlVLRWdJS2ZCaFV1WnlvUUZ5N1VibGRhSUhXSWRZVGt6VGpjUjYwUDA3?=
 =?utf-8?B?VUhWZGNxWmRxR0MzVjc2UFJldWc3S1FqNXVYWGZrWDVka29QQzBXYjZpRCtZ?=
 =?utf-8?B?OVY0dTJQd0o4NVB1L0xtZ0NsUTdoWFBXbjNXaS9RS1lheWgvSStFeVRxQkdO?=
 =?utf-8?B?eVRsUTYxMDFvY0hyRGZEQkowMnhuUXd6Um12c0QwbkM1WjQ2eWRxSUdHcGRw?=
 =?utf-8?B?Zk5PQk96SWZGeENlYWNPQjQwYnNJWmJJUU93UlZVenY3OStkQzYrNzNVeWZh?=
 =?utf-8?B?TzdzK21vdUswZmRPSjdNZUJLdy9MK1BOcmJPbThZbnFBVFkzTkZ0QmF5clQ0?=
 =?utf-8?B?SGh1MzVEM3g0cnhJS2pXQlNDVkw4QXlRSkFlMmV6WldNRm5UaDZ5dDF0VS9S?=
 =?utf-8?B?MlVXd21LSTcyVGRHNXlVNnBWZEVkUmd0UDkwc3NBbFFFcUZTTGl4Z1ZhNkR2?=
 =?utf-8?B?dUFBMUp3cHRCVU9TWk5HUlBoN0N4SzBCdU9sS3JkeE5kZGlNMWI5b01kZW4w?=
 =?utf-8?B?RVJjdlljMGFBckR1OEVzMXNOOFJFY0FZa1UyVDI0ZmtlS21tNnd0VE5sRVd3?=
 =?utf-8?B?d2tDUGt6anJBenlCMWpSRWJjN1BVRHBTNGk4OEJXOVZWejhzb2p3SzNabHZ6?=
 =?utf-8?B?VS9PcnFlUFVnbTZDMTZoN1krbytTSVpRQ21hNTBxdmh3SzA0alpORlU0YlJW?=
 =?utf-8?B?MHZocjNORWowaHU0RThtRzhpaDJTZzRBaGpaUUpsVWZBRFl3bWlka1RIdzl1?=
 =?utf-8?B?VjM0N0cvK1BYZWNLMGtnYkhEcWRYd1k5NzdiY0xVcVlNM1pUS2djSFVIaFE0?=
 =?utf-8?B?aHh5Z3pyZ042T0lXYWVoeUx6bHVlU09YN3dBTFhNZkh6MlV1TXRwOTBkTVhQ?=
 =?utf-8?B?by91NEdiQW0ycXVHN0EyaGRyN01GcWd6a3hUWElURm9tRUdKS1NadGhpUHAv?=
 =?utf-8?B?UTNJdEppODI1UE5sTEE2TUZiSHVLeGVrSmpDcDJab014eUNxWExBN2tPaHp2?=
 =?utf-8?B?Qlptc3h3RnJjVTh1ek1YV2lrUUxtbzdGaG5mUzFnNEhFSHMxZzIvempHOW1z?=
 =?utf-8?B?N24rZTAzdzRhYkovZXZtOERjY0IyZHhiV1JxL3F3WlFqZnBMK1BaZ0IxZlFr?=
 =?utf-8?B?VjB5ZklTeHVuOFlsZm8zb1VZQXdmMy9LUXVac1pmVDdoNlNaUUFlTWpSSWZK?=
 =?utf-8?B?aUlMZWt0d2FFajlIZTREZnFaK00ycWtubFV6WG5uTFJUVy9uL0ppZjAxUGpK?=
 =?utf-8?B?NXloWFpra2J6Qm1YWHhxclE5ek16SHZRZkR4cGFIQjUvQ2hYcGRaT3VzWEoy?=
 =?utf-8?B?WkdCNlpINmNiN3hOMG55OVF2blA5YlZESmNtYkg0RmtzQUhaam52eFQ1TUdk?=
 =?utf-8?B?WmNuSWVVREppNlhxZHBWZUZxSzV1Um43SFFjVkJEVUNTSDdQY3F1QXRDSGtD?=
 =?utf-8?Q?ArHlRr4a6BfXB7GsRSFxqxc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91f785d-2447-46b9-de4d-08d9a2c46c7b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1264.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:31:17.2050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZmpqZ2pPaZwdfLlTZNF55XcOI8LrgRB80ffi+wR+AFovZGfmtEt70qY72U8YrDVYjBHFwuLE7ribFBBhfn84Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361
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
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Paul,

On 11/8/2021 7:51 PM, Paul Menzel wrote:
> [Which address should be used: sshankar@amd.com or shirish.s@amd.com?]
"shirish.s@amd.com"
>
> Dear Shirish,
>
>
> Am 08.11.21 um 12:11 schrieb S, Shirish:
>
>> On 11/8/2021 2:25 PM, Paul Menzel wrote:
>
>>> Am 08.11.21 um 09:15 schrieb Shirish S:
>>>> limit the MPO rejection only for DCN1x as its not required on later
>>>
>>> it’s
>>>
>>>> versions.
>>>
>>> Where is it documented, that it’s not required for later versions?
>>
>> This is a workaround to avoid system hang & I've verified its not 
>> required DCN2.0.
>
> Please extend the commit message with that information, and also add 
> how you verified, that it’s not required for DCN2.0 exactly. (Just 
> test one system?)
>
>> We generally don't have documentation for WA's.
>
> WA is workaround?

yes.

Regards,

Shirish S

>
>
> Kind regards,
>
> Paul
>
>
>>> Shortly describing the implementation is also useful. Something 
>>> like: Require `fill_dc_scaling_info()` to receive the device to be 
>>> able to check the version.
>>>
>>>> Fixes: d89f6048bdcb ("drm/amd/display: Reject non-zero src_y and 
>>>> src_x for video planes")
>>>>
>>>
>>> I’d remove the blank line.
>>>
>>>> Signed-off-by: Shirish S <shirish.s@amd.com>
>>>> ---
>>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 
>>>> ++++++++++---------
>>>>   1 file changed, 11 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> index 1e26d9be8993..26b29d561919 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> @@ -4572,7 +4572,8 @@ static void 
>>>> get_min_max_dc_plane_scaling(struct drm_device *dev,
>>>>   }
>>>>     -static int fill_dc_scaling_info(const struct drm_plane_state 
>>>> *state,
>>>> +static int fill_dc_scaling_info(struct amdgpu_device *adev,
>>>> +                const struct drm_plane_state *state,
>>>>                   struct dc_scaling_info *scaling_info)
>>>>   {
>>>>       int scale_w, scale_h, min_downscale, max_upscale;
>>>> @@ -4586,7 +4587,8 @@ static int fill_dc_scaling_info(const struct 
>>>> drm_plane_state *state,
>>>>       /*
>>>>        * For reasons we don't (yet) fully understand a non-zero
>>>>        * src_y coordinate into an NV12 buffer can cause a
>>>> -     * system hang. To avoid hangs (and maybe be overly cautious)
>>>> +     * system hang on DCN1x.
>>>> +     * To avoid hangs (and maybe be overly cautious)
>>>
>>> I’d remove the added line break.
>>>
>>>>        * let's reject both non-zero src_x and src_y.
>>>>        *
>>>>        * We currently know of only one use-case to reproduce a
>>>> @@ -4594,10 +4596,10 @@ static int fill_dc_scaling_info(const 
>>>> struct drm_plane_state *state,
>>>>        * is to gesture the YouTube Android app into full screen
>>>>        * on ChromeOS.
>>>>        */
>>>> -    if (state->fb &&
>>>> -        state->fb->format->format == DRM_FORMAT_NV12 &&
>>>> -        (scaling_info->src_rect.x != 0 ||
>>>> -         scaling_info->src_rect.y != 0))
>>>> +    if (((adev->ip_versions[DCE_HWIP][0] == IP_VERSION(1, 0, 0)) ||
>>>> +        (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(1, 0, 1))) &&
>>>> +        (state->fb && state->fb->format->format == DRM_FORMAT_NV12 &&
>>>> +        (scaling_info->src_rect.x != 0 || scaling_info->src_rect.y 
>>>> != 0)))
>>>>           return -EINVAL;
>>>>         scaling_info->src_rect.width = state->src_w >> 16;
>>>> @@ -5503,7 +5505,7 @@ static int fill_dc_plane_attributes(struct 
>>>> amdgpu_device *adev,
>>>>       int ret;
>>>>       bool force_disable_dcc = false;
>>>>   -    ret = fill_dc_scaling_info(plane_state, &scaling_info);
>>>> +    ret = fill_dc_scaling_info(adev, plane_state, &scaling_info);
>>>>       if (ret)
>>>>           return ret;
>>>>   @@ -7566,7 +7568,7 @@ static int dm_plane_atomic_check(struct 
>>>> drm_plane *plane,
>>>>       if (ret)
>>>>           return ret;
>>>>   -    ret = fill_dc_scaling_info(new_plane_state, &scaling_info);
>>>> +    ret = fill_dc_scaling_info(adev, new_plane_state, &scaling_info);
>>>>       if (ret)
>>>>           return ret;
>>>>   @@ -9014,7 +9016,7 @@ static void amdgpu_dm_commit_planes(struct 
>>>> drm_atomic_state *state,
>>>> bundle->surface_updates[planes_count].gamut_remap_matrix = 
>>>> &dc_plane->gamut_remap_matrix;
>>>>           }
>>>>   -        fill_dc_scaling_info(new_plane_state,
>>>> +        fill_dc_scaling_info(dm->adev, new_plane_state,
>>>> &bundle->scaling_infos[planes_count]);
>>>> bundle->surface_updates[planes_count].scaling_info =
>>>>
