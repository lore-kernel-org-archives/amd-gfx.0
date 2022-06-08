Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E18C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 13:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A30811231B;
	Wed,  8 Jun 2022 13:56:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B46F112303
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 13:56:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qp/EWAQUH1ztOkFoMAE93GbdD8oel8grHLG2eo0Z8ZaVCmlUE2tJrtcxgY8GPra4wjKYNJL7DfHum6OP0LkNIx0kc4uJoZPx3s8Bi5WxD4GamwUcLAvYOqqPVBReuj2ioCgeSzO1emAUdi1dgZmuw3LcZIXUI/o41DtatLXXBv6SA72YLE8iMis09MEinIVyhxJtnLy7VvE8wIPf8NDNM7YPBPmFI7PxwsDEbw9rOJwBhxfyLRTwKCKlepLq0MWs9MAkaICHFy0G6iEvDofvrWVaAOkH9NyLO2GEWQHwQ9wdJwGDyTtxRNcVItHs5yN3eYQM2Jt8+VjpB+2uly5ueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DzhCIKmQcbNv8+YuVfhHKu0xU5b/ffXikCmxZgbsyA=;
 b=kvTTaHl4DGm2pFgAAGRzXzYKNF2SwW8Xn3BmIVSMbpGPi+VOYifBlIn96LCBNp9/7a50Y5nY8bRK31ewKxp7JRjSHzraq2/Yv3juAhFwq4x5fD822KZkw3LLNGLpKntUjTF8sig66BwgtvMS04Dmd3BglNyz5kZPnWgqqZsSPuSa7Vj9DVdlSqaFJg2bDIM19IatC+wsImRiOzY5wj2grZz8Uik9asg1b7tcHixI3rfgDXhcdv0IVUjR2bbpm4omLJ8Ox4KZ8SAFSSdgIJRvv4tlY9gHgyys1hgmeBWHMmAXesnmm7esMAtec5/xCutUWU/+Pt+0WI8qta2K6rhwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DzhCIKmQcbNv8+YuVfhHKu0xU5b/ffXikCmxZgbsyA=;
 b=1GZkU8hGBvHVV6EvPN9k7Si1aCYATAipLQKneW4NrEZjpz7oqzwloZE9ftuTJK2ZG6K6BTi5D4WljJ2a/TeZHzS0ZP1IU4kmFNOqg0sV1oJFc3hjAv0Gi+hM7kCNSWiJ2igiXt9ie0CMCkYbHuqlZs+JbMTKHUSj3wJUElXQQQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.19; Wed, 8 Jun 2022 13:56:14 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::c89d:e4eb:6abe:38fd]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::c89d:e4eb:6abe:38fd%7]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 13:56:14 +0000
Message-ID: <d7bf7614-be3d-cfb5-69a1-b7b57b3e49b4@amd.com>
Date: Wed, 8 Jun 2022 09:56:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu/display: Remove unnecessary typecasts and fix
 build issues
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20220607094004.946093-1-chandan.vurdigerenataraj@amd.com>
 <639ad722-f32b-0d50-4244-ae6bb0b15f23@amd.com>
 <4d10989e-337e-e906-bfde-7065fe8ca0ec@amd.com>
From: Leo <sunpeng.li@amd.com>
In-Reply-To: <4d10989e-337e-e906-bfde-7065fe8ca0ec@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0107.namprd02.prod.outlook.com
 (2603:10b6:208:51::48) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f237f495-a3a8-45e7-1cfe-08da4956a6ec
X-MS-TrafficTypeDiagnostic: DM4PR12MB5940:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB594036D5011DE174D553780482A49@DM4PR12MB5940.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IncauMfw5vdbsBf/KM7FnzL5u9uPEwBOJdI4ATqOT78PIcnW7YDIed2w3v+LLcgXWsY7wTB7PWyTKJRady2j9jif/31ZgBhWgO+qa9btLJ64rYDHiamlpV07+nBKQg5UhHcd47bKrGjCJj0QtEE9kxuOCYdNFHGzAiYBoiMKVi7Um3L8ue9Y4nZ3eyH6wa4I/IEBZdxVO79N05pGMv1/4WYOjzujP8NYz9BlMIMvXrtBLNWsRQJARCLD3Y6FAiYrp5SuDeYQ/fPmVk5FAlk+io8suC6Lj97rAXR+lt5nH1wpi/0xjMyr5+hyiMdfqDFiBn8i+91SVYSRWd7KmF5b8n3OC1JkAp+gAWYuJEqu/OKoa9jmU08nS4oJ8oSxbJWUBx9jaVqyLfAv4gw0BjLXYW3wiE8L4oDUMapKnl1vMXeAso1SVO7yDWQv/orn+DiZH0a8Go3I3M+ZAwbZmw02xHEgGMW2O009q1FJrJDmt6ju+sZ82y/3W5s9Optdr/NJA+dVqFPmXvCRQdJlSWpXmmB+TVXZWPNzbJvgOe1sMXaotDaMq8oEUQeghIcbf408DlV7AL+U0FAbsgjIrMIJ9i7Wqyg7l/2k9N1L6rPZhsfTZh3s2JrsVI3uE4juOVnBza7sPyCqXZfVlTaeDguftFEG7Yt2dGmvmlV80+GxFb/W4ArDoK8U/C8y3C84DBIMxLezzvEolU+KiZC1WourDuk7SvKh0cfZ53pLEcdkTXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(83380400001)(53546011)(8676002)(316002)(31696002)(86362001)(6636002)(38100700002)(4326008)(66476007)(36756003)(66556008)(31686004)(66946007)(186003)(8936002)(5660300002)(2906002)(110136005)(26005)(2616005)(6512007)(6486002)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHI3cHVwWUtuSXNFc3dtbXM4bnJqRVF3NVhVZ295U2xhSW1ZL3pRd1ROVC94?=
 =?utf-8?B?aXAvT2pobEhSZEl3eHYzYm1OalVEcGZsZ3NvMktyV3k0TCtZNW04bW41bUhI?=
 =?utf-8?B?ai9ISlJFTlp4dWJuanFRdXV2REwxa0o4UVJ6blZWZ3FXa3RZbUxjaVlxMHY1?=
 =?utf-8?B?VFVSSExHZzFKZGozN3AycGRtRnNrNjFJdm9MTHd3V3dFdGs4NGZ6cFBHSHNU?=
 =?utf-8?B?RXBMLysvbjREUkhITm01SjhlZVdSUnJ4U1BuNnM2b1JscllUalhSOU4yTUJK?=
 =?utf-8?B?Z0J1NWVGRFFCcjVpMTJQK1dOTlo0cUJ1Z2JkK3J4blR3VmNxU0pUc0ltQWxR?=
 =?utf-8?B?VzA4dUo0SVllazBYOVhlZW9wbkRZbGVhWWszbHFqQUdkanFHMk1qbmxpaDZH?=
 =?utf-8?B?Qmh2K0V1T3VJaU9XWkp1eFh3R0Q4MWVxaDRJZlpmZHBDb0tXNzViYU1pdVgy?=
 =?utf-8?B?eGdvYmRCc1RKRTNzTk9NbFh5bEU0L3VieU5VZTdVQXhTbFlUNjdPL0toNEdh?=
 =?utf-8?B?TXpydzMrZzZCa0lTTUlabFIxaW1LbXFBU2xMcHFsK2RoaGJGUHRadjkzVXNa?=
 =?utf-8?B?TVp3TVpHbllLVHVocDc2OGZwWmdoQWRGMHVENmVob2dYb3l3SHQ1b0xzZVNR?=
 =?utf-8?B?NnVaM1pSTTdweUpIb2UrcE9leEZNdmFEcmFqbHRBYTJiR2NQRmRrc2tUUW5G?=
 =?utf-8?B?SERsYWVwaFVuMjAzRkdZVE00amNXQzhlZzZNUTNsSGk0SjBkVGt4K3pIc1Iz?=
 =?utf-8?B?MFRBWUZWOXduckF1NzA1K2RjZWg1R0l1U1FmdXh1eWFGUUwzdlJaU0w2aksr?=
 =?utf-8?B?Qkg3WGRia0ZvTmF6U0pvQ29lVnEyejNibklLclROZmZ6TTFRZzJ2L29hWHJX?=
 =?utf-8?B?eUQ4OWxXR0g0Ykh1U1pPR2p1QXphSDJvNkltOUFQMEFDVEdERnVXd1dmS3Uv?=
 =?utf-8?B?azZ4b3FpVDByVFp3WjJGeit0T05XQjhRZnFJL1lCU2VuTVBvSkIzY3J6UUpW?=
 =?utf-8?B?TE9JNitvQ1lUTFhUendaaHlDbWVFeVlZUkF5eCs3cHZtYVdzWWFyK25sMG1h?=
 =?utf-8?B?RUpiWnZkek82QThVR2lxS3lTa21iR2hXZnBaZEhzQzZ4ZTBhUUZaTEEyK2Rn?=
 =?utf-8?B?S2dOcnRiUmQ2ajJ5ZDlGN3p2NVFoa2RXd1VCMWF6TU1IWGVaVmlJK2JZQW5S?=
 =?utf-8?B?WU1VSTlPSkovZ0dxMUlKQWhCbjVyWm1HWE11bnMrWEZlYUdEV2xEVk5sREZG?=
 =?utf-8?B?VUdrNkl3OE96Yk5EVU1sUFRuampBeGduUVdLcGs0eGRobWxVMWRLUW03ZTU3?=
 =?utf-8?B?cW12V2hDUHpGNGdlbGFSdlJSNlF2WSt6VCtjVVppNnRaUVB2RTBVMjY4R2ZC?=
 =?utf-8?B?TGY4VTRBYUkrTkhBSU1rR0RaYnBxWWZZMHViQmdWMitmOStKNmxTTmtMR0o5?=
 =?utf-8?B?c1Bmc0Y3QktBS3hFU0JORmkyOUU5NE1GYUw4WVpIZUxtN3k4a2RkZjJSL1pp?=
 =?utf-8?B?VGdTZ2hXNWU0Qkdka3dpRTlOYzM4YmsvVkM2dlJtVVprckdJaFVQcEdKR2ZE?=
 =?utf-8?B?WjRRaHQ4d0hqQVJLQWVjRWpXcFZqY3orQndLVW9WWURaWmVta1hIdmU3Sldq?=
 =?utf-8?B?QVUzOCtXVW9XbkdIYm1KRXFLWkdFOVhZcHdVNms4VkMxMEZNMzdENGswODFh?=
 =?utf-8?B?bnlLVjJnb1hQdXMyZmZpSmdyOVIxL1lkWFU5UVExZndoWHBPYXc3Z1U3Z1Aw?=
 =?utf-8?B?OGNVSjNaWnduc1NldGtmbEs1RTVpcnhnQkhVcHRnc2I2eEh1TFVuOVgrOWEy?=
 =?utf-8?B?MkQ2Z0padXZxTitBM2F6eiszeG05Z0VoZGRCaGQrMGwwdEp3TjdFNlovVk95?=
 =?utf-8?B?a3pWcFV2djFFMURpS0R1ZDQ3RnZxQkRrTWlsSnUwaGVkaEphM2VLY2ZJMTZU?=
 =?utf-8?B?c3FTaWp0L3lNR0c5RGJvVlZoRHptTllpajFGZFJqVXMzUUN3WnFEOFpCUm5S?=
 =?utf-8?B?YlMxWWVUU1hSbWVWeWs4dy81OVluVkdrZHRYQWpwL2FjazkwUHJvU2VXYkFR?=
 =?utf-8?B?Sis4MjFHSWFkOWJZTHlZai9IN3BBTllvVmwrMUVJQkFGS0ZJSWIzZGxiMjdG?=
 =?utf-8?B?NVVwbXo2bDZBT3oxQlRGbHdkODlEdktya1hzV1VBKzFJcE1oRm5EUS9wN3ZC?=
 =?utf-8?B?RGpFN2cveG1oRnhJakVXa054N1hnT0hpZHlmMVlmWnBYeTVqQlhMSzBRTW8r?=
 =?utf-8?B?WkVKc0hGOHlIYnhSMXJoUXpwTjN5ek1oSDk0Qlp0RzdadGpFVktacWkvVTBk?=
 =?utf-8?B?a1BSYkZuUlFnMUNLeU5VK2owdkdJckVJQjFHMkVZN3RMK3kzaXptZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f237f495-a3a8-45e7-1cfe-08da4956a6ec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 13:56:14.4394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5aaUxfjJ0gjJUuIYmjvi9PD+yfZNpEaljGK9vp7y/NWXkNSKzZv+S4uD+6XqvnX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-07 13:58, Aurabindo Pillai wrote:
> 
> 
> On 2022-06-07 11:34, Leo wrote:
>>
>>
>> On 2022-06-07 05:40, Chandan Vurdigere Nataraj wrote:
>>> [Why]
>>> Getting below errors:
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1414:5: error: implicit conversion from enumeration type 'enum scan_direction_class' to different enumeration type 'enum dm_rotation_angle' [-Werror,-Wenum-conversion]
>>>                                  mode_lib->vba.SourceScan[k],
>>>                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1744:22: error: implicit conversion from enumeration type 'enum scan_direction_class' to different enumeration type 'enum dm_rotation_angle' [-Werror,-Wenum-conversion]
>>>                          && (!(!IsVertical(mode_lib->vba.SourceScan[k])) || mode_lib->vba.DCCEnable[k] == true)) {
>>>                                 ~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> 2 errors generated.
>>>
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5484:18: error: implicit conversion from enumeration type 'RequestType' to different enumeration type 'enum RequestType' [-Werror,-Wenum-conversion]
>>>                          RequestLuma = REQ_256Bytes;
>>>                                      ~ ^~~~~~~~~~~~
>>> 18 errors of similar kind
>>>
>>> [How]
>>> 1. Add typecast at relevant places
>>> 2. Move the enum RequestType definition ahead of declarations
>>>
>>> Signed-off-by: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
>>> index b77a1ae792d1..5828e60f291d 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
>>> @@ -1411,7 +1411,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>>>                   v->BytePerPixelC[k],
>>>                   v->BytePerPixelDETY[k],
>>>                   v->BytePerPixelDETC[k],
>>> -                mode_lib->vba.SourceScan[k],
>>> +                (enum dm_rotation_angle) mode_lib->vba.SourceScan[k],
>>
>> Hi Jay,
>>
>> This seems fishy, dm_rotation_angle and scan_dirrection_class are very different enums.
>> Comparing dml32_CalculateDCCConfiguration() with CalculateDCCConfiguration(), it seems dm_rotation_angle is new for DCN32. Is passing vba.SourceScan correct here?
> 
> I agree. It should be typecast to scan_direction_class

From the build error, it looks like dml32_CalculateDCCConfiguration() wants type `enum dm_rotation_amgle`, but vba.SourceScan[n] is of type `enum scan_direction_class`. The error is complaining that we're implicitly casting from scan_direction_class to dm_rotation_angle. In otherwords, this was an issue prior to Chandan's fix.

I think we'll need to address this separately, but for now this fixes a build on chromeos with clang 14 that I've been able to reproduce. Elevating my ack to:

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!
Leo

>>
>> One more comment below.
>>
>>>                   /* Output */
>>>                   &v->DCCYMaxUncompressedBlock[k],
>>>                   &v->DCCCMaxUncompressedBlock[k],
>>> @@ -1741,7 +1741,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>>>       mode_lib->vba.SourceFormatPixelAndScanSupport = true;
>>>       for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
>>>           if (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear
>>> -            && (!(!IsVertical(mode_lib->vba.SourceScan[k])) || mode_lib->vba.DCCEnable[k] == true)) {
>>> +            && (!(!IsVertical((enum dm_rotation_angle) mode_lib->vba.SourceScan[k]))
>>> +                || mode_lib->vba.DCCEnable[k] == true)) {
>>>               mode_lib->vba.SourceFormatPixelAndScanSupport = false;
>>>           }
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
>>> index 6509a84eeb64..07f3a85f8edf 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
>>> @@ -5314,9 +5314,15 @@ void dml32_CalculateDCCConfiguration(
>>>           unsigned int        *IndependentBlockLuma,
>>>           unsigned int        *IndependentBlockChroma)
>>>   {
>>> +    typedef enum {
>>> +        REQ_256Bytes,
>>> +        REQ_128BytesNonContiguous,
>>> +        REQ_128BytesContiguous,
>>> +        REQ_NA
>>> +    } RequestType;
>>>   -    enum RequestType   RequestLuma;
>>> -    enum RequestType   RequestChroma;
>>> +    RequestType   RequestLuma;
>>> +    RequestType   RequestChroma;
>>
>> This might need a wider cleanup, enum RequestType is defined in display_mode_enums.h and is already included in all the display_mode_vba*.c files I've come across. Unless I'm missing something, we shouldn't need to redefine RequestType.
>>
>> That said, there doesn't seem to be any functional change, and it fixes a build error. So
> 
> I'm unable to repro this error. Are you using clang? If so, which version ?
> 
>> Acked-by: Leo Li <sunpeng.li@amd.com>
>>
>> Thanks,
>> Leo
>>
>>>         unsigned int   segment_order_horz_contiguous_luma;
>>>       unsigned int   segment_order_horz_contiguous_chroma;
>>> @@ -5350,13 +5356,6 @@ void dml32_CalculateDCCConfiguration(
>>>       double   detile_buf_vp_horz_limit;
>>>       double   detile_buf_vp_vert_limit;
>>>   -    typedef enum {
>>> -        REQ_256Bytes,
>>> -        REQ_128BytesNonContiguous,
>>> -        REQ_128BytesContiguous,
>>> -        REQ_NA
>>> -    } RequestType;
>>> -
>>>       yuv420 = ((SourcePixelFormat == dm_420_8 || SourcePixelFormat == dm_420_10 ||
>>>               SourcePixelFormat == dm_420_12) ? 1 : 0);
>>>       horz_div_l = 1;
>>> @@ -5527,11 +5526,11 @@ void dml32_CalculateDCCConfiguration(
>>>               RequestChroma = REQ_128BytesContiguous;
>>>       }
>>>   -    if (RequestLuma == (enum RequestType) REQ_256Bytes) {
>>> +    if (RequestLuma == REQ_256Bytes) {
>>>           *MaxUncompressedBlockLuma = 256;
>>>           *MaxCompressedBlockLuma = 256;
>>>           *IndependentBlockLuma = 0;
>>> -    } else if (RequestLuma == (enum RequestType) REQ_128BytesContiguous) {
>>> +    } else if (RequestLuma == REQ_128BytesContiguous) {
>>>           *MaxUncompressedBlockLuma = 256;
>>>           *MaxCompressedBlockLuma = 128;
>>>           *IndependentBlockLuma = 128;
>>> @@ -5541,11 +5540,11 @@ void dml32_CalculateDCCConfiguration(
>>>           *IndependentBlockLuma = 64;
>>>       }
>>>   -    if (RequestChroma == (enum RequestType) REQ_256Bytes) {
>>> +    if (RequestChroma == REQ_256Bytes) {
>>>           *MaxUncompressedBlockChroma = 256;
>>>           *MaxCompressedBlockChroma = 256;
>>>           *IndependentBlockChroma = 0;
>>> -    } else if (RequestChroma == (enum RequestType) REQ_128BytesContiguous) {
>>> +    } else if (RequestChroma == REQ_128BytesContiguous) {
>>>           *MaxUncompressedBlockChroma = 256;
>>>           *MaxCompressedBlockChroma = 128;
>>>           *IndependentBlockChroma = 128;
>>

