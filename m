Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44781C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 13:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2ABE10FF95;
	Wed,  8 Jun 2022 13:26:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D7110FF9E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 13:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYnTBHzJz+SMRxnfeAX7RKGtm0nwZhwxuZQbfQ4aGh8JUrZ0Z9CTZ06kjamei7wHHj9ESgzfB1ttSm0DytqC2dBfahOS8aulnfsi7pXrxFa+mV9hfwxkWsrMIEdyspal4VlmzzMTgnvKAEY1fPXa6C+cEitllBtPvyEECrBwVWNu0AM2OGbG0V8FrE/w3puxwRThXOyvy5wkMXti4cmAoEuGZP74xKy5mpLavGLAul6jtOZPeOi2pSjBitK6OuuzaeXrB6VeT1nErkxUf8Op6IYvboAQfAelzt/V1oGVUyxhmcXADY2zH/yAcEd2FikdDy53g6R7F42QEzTOkIA8EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daEUcCjZsAXPsxxWV8xfnvyRQKj9gXyG5Vsb6/fXI2g=;
 b=e4IB5zDXM/o0hFn5LgROh0jJhstmI5PnXdqa/j3EJRz2S1u68RhfrB8Mfa1I8B09vA0DG9Nsksq8kI/3uU57+laDvP6e1KOVe+WiDFsFKhVPCbeM0dWhJSj/ik/bLL1Qy2fMfLvrdbLITKDxVZofKwxwWOpnujCk11ko16DxmcIf6lHMKc3uGBU4/3p9xqPNVIzWAQsuG8JCZQjBhEjd0ESssxaa+W6XU1SFOZV73osOLJoJ+7YLNVuitGWZY/Zm+8RR3puT8btAvJA0r8cXy8kk6bUC7TEuhbU7B6ygPEX5QtShGZ9cMIjGb1jh1rc9xsYySkk1spU2NXXygz6HpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daEUcCjZsAXPsxxWV8xfnvyRQKj9gXyG5Vsb6/fXI2g=;
 b=305TBz7DW/H6YN3FPgomPVqKH/tli3hyuqY2Sindmpj1Y7bMjkVp5rQbnY6jZP8yUrpRZawbX7bMREo+M4WDY3xCCx9mqfBtGkcOqkb1ymaHP+FvjaVajPOTxCZq2s36yfgO2OSsRee6l4TavX5AuCkw2am84qZ+9OlRqXC157A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by MWHPR12MB1165.namprd12.prod.outlook.com (2603:10b6:300:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 13:26:04 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::c07f:cf2:801a:e4cf]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::c07f:cf2:801a:e4cf%6]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 13:26:03 +0000
Message-ID: <dd86f651-c1ee-3d80-159e-16fedfcb7d49@amd.com>
Date: Wed, 8 Jun 2022 09:26:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu/display: Remove unnecessary typecasts and fix
 build issues
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20220607094004.946093-1-chandan.vurdigerenataraj@amd.com>
 <639ad722-f32b-0d50-4244-ae6bb0b15f23@amd.com>
 <4d10989e-337e-e906-bfde-7065fe8ca0ec@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <4d10989e-337e-e906-bfde-7065fe8ca0ec@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:208:d4::48) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39242520-d67c-480f-72e7-08da49526fc4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1165:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1165F182EC93814A3525C71498A49@MWHPR12MB1165.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUUBB7/VO9PeMj1mdwNPI79Mufj2AovpMCDu2WBczvDojLGksLAE8R/b4ZcNfT6FMfNbja4acTwjgL6dLpLEJUUGTUM9QLt6uztstBEgNHU4g7pTguzS69pLWD2DZM6yKPn4dU7iLJRgECgLuNYxywShVqjkuYim6XQNBX+5/3wZExNXWCc27weQOnGGesXIrtgupKBOvU/zFly9cnTU6KW9wyVxNGRswyymGCXoQChC8eDTV/SfMDddJa85ZXg8r8DZhOMxHuaPplLyMyiWjw1gESk0I/7VhQDpAaShenDChnlZA3bYE1KID+pcaHtlkC6A727A/eDnrspzXJfVWwK9vjPdOKuci6+iWuR7EwFbXrYkRGd+S9z3pf8p+9ssOmzEVgiHgt8aeC9QzDQhZgUjeGxhj5MhZI5stGkoKC6pp0wGvmcdeSLvbpBaAINHAvrkeurAaWpSGMez2s8DPqqMImc736LukBCxgrcEB2gtONxcO1OnRqFue1A0kQSRaDWhBcUGEOPCdZe9x50FG7r0oFQxJiMYbI5sK5JX0ZtVMXBCypqiPQdlXazOYcUMc1tn4EVIEXYwntsrEaJy1shHdVh+QPsUpCetX6FcIBQBiRfhbegcnZbF0q1KFREoz12Vp/3dvNJ9rrzpBC8R49yuLRnY9D0bkW/ADW52aM4PB287MxM/oyfbR09ApW130OBsW5LMUQLxvlukGHHHCES1wnZxi1+x1AlMsO+SrsVgcAWhSvn1/RAMuwfROulv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(66556008)(66946007)(186003)(316002)(26005)(8936002)(83380400001)(6512007)(6916009)(31686004)(66476007)(8676002)(38100700002)(5660300002)(36756003)(2906002)(53546011)(31696002)(6506007)(6486002)(86362001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGJMbTNiUVp4TzUzazNMOFJ4VzRKeFY0NjBNcGpxT1BuUTFXREEyNDdiQzV5?=
 =?utf-8?B?eTl6b09ZbmE3M1BwOFlLZHJoemVtNmozRE9mWW55S3k2WWRtWk54bk5xaHJu?=
 =?utf-8?B?REdvWk1JODI3SGJOR29NQ0R0VW9hZVMrUzFlSFJ2SUl1REQxWmNxVHdUQ0Zj?=
 =?utf-8?B?UVY2SDFVQkx0dXgxZDZJMHpEbUFsdm4yU1h6YWIvOWpIclFXK1pianpDQjZj?=
 =?utf-8?B?TkIvUENpM1QzMlNvalZqUVhYWWVVWjJpZE5Tb2ZPeHJvUEVXcFVLTnoxWjJo?=
 =?utf-8?B?d0lkVktDOEZpcjMzZVdZYUpLMDIxUnE5eW91TWJFMzdkV29PaThCSDlUbGJs?=
 =?utf-8?B?U0d0SDJXUUEwR2xpeVJvdFY0b3ZUZURoZTNwSzZndERuS0c0VkwySzdUL0M5?=
 =?utf-8?B?VjkvN3ZVT3Nqci9TQ2dEbVp0SU1uUzVVUTFJMEtGVExWUU1LMk1QNUFiaDJ0?=
 =?utf-8?B?SUlUZFlFSjhyZlNKQktidnFyZ0szWkxTaThUNVJiTFg0VU10c2IwK1Q4b1hV?=
 =?utf-8?B?ajVGakVoMktSS1hsd3dhcVVzdkpjbFRnR3R5K2dOVmtmaStEeit3UVBDUC9V?=
 =?utf-8?B?ZlRuZGJDSHk0VG9MSklqSCtpMzdkMWYwb2ZGVkZ3K3UzY0JtNktiYzlJcHNR?=
 =?utf-8?B?R0dieTZrSFp5TkpCbnlrbEJUc3dQQTBXOVJ5NjdXNVRDTEJ3SlduRy95bFF4?=
 =?utf-8?B?MUc5ekJFZkRNNit0eG9KeHNVTnNmYXAyQXd2ZnFsM1hOUmRZVk1lR0I2Mk9O?=
 =?utf-8?B?eUs1WjlPWDg1V0I2dW5VbDRFakljcSs5VmFIaWozcHpNbkpTMzVUQ1FldExO?=
 =?utf-8?B?cGFGS0NJLzUxS3N6aGNBc2dEVW5PelJOMGk2SmVMNnN3OUcvb2FPejNBa21S?=
 =?utf-8?B?UjQ2SjRna2prYzUzblpEVk1qdGlBZTlOVGdxbG1kYmlRNDFyOC9hMjd5SnNY?=
 =?utf-8?B?Z3FKTUUxQzEvN05yMmlnMVdycE14ZzBFOERhdDB3UDl6M3RYclBXWnNNci9R?=
 =?utf-8?B?VEFYTEc1U2llbjYzYVFneUI1Z0x4RXZURnFSNkhoUDFBMEozQkcwT3dOd2Rv?=
 =?utf-8?B?VXQ2czBMVUFGQXV5KzVtelM1emw4V1lwdXJQVHZwRVY3Q3dGdFE2MzNsRGd2?=
 =?utf-8?B?Zmp5VS9UMFJzSGVuNkk4Ylh3ZTl5YVhFZWJrVThPWnp4Q2phTXNrWkdZOU9P?=
 =?utf-8?B?TXlDVzJVWU9vclZrUkQ2Q0ErQ0MvajdDaDlvOTZtZ1dYS2RoZy8rY3Jmb1E2?=
 =?utf-8?B?Q04rbGcwOStwelZHVExxZkcraDVxUXJnR2xJdGNzUTlpM2RCVmt1dmVNNGxj?=
 =?utf-8?B?eEFEdE5hWFpubUU2d2htMFJiYjNhMmlJMTVmVHhCbUt6TGZaU3Y0a3lUK2tr?=
 =?utf-8?B?VzB1WGZoZko3Wk5WUkdOQmttT3hRRGJQanc1Rjd3ajNBWVQwYTZmWWpFYU5P?=
 =?utf-8?B?SFo2dHJGYkcrMnBqZGNyTWtvYWdpYyticEp0RFV5TnFuZ1FnWG1wSnp4M092?=
 =?utf-8?B?bjVvMmJKZGlUV3NsVzRHbU0rc0R2Y2hlSHptM0NGWC84SlVUSzRPM0NleTVB?=
 =?utf-8?B?Y3hnVVVueHZwQS8yUmhUcWQveXJZMkwzbTRiWnpaV241WjFRa0RHOCtDQzZt?=
 =?utf-8?B?TSs3UEZXWThVUDNJcUt4QTZOQkkzcUp0V24zdjZ2OHZsekt3dlJMRktrbGoy?=
 =?utf-8?B?TmtxZzkyZ25rYWhoZENySis5NXl5dXFJU2Fhb0ZNWUdtTVRCQjd2WHpWOGNZ?=
 =?utf-8?B?WDFuNTUxNjNybnNDZmdvNUNsVGJ5UmUrSm9Ha1VVNzlOZUpiRGoyeGhscVIz?=
 =?utf-8?B?WEJXQzhmQS96M0tPNUp5VjFCckdrVDBUTzJXZDJaaUozOSszRFB5MXlBclF3?=
 =?utf-8?B?SkhTZVVFSXUzaDAyL0FLWjJ2ZUxYcU1UaEE2YmgvZnUrWDBVMDRGdmtCNUFm?=
 =?utf-8?B?bzVFMS9pVVlCSWI2UDBTb1ZpMmdtREY4bUlnT3NidkNSWWhjazFnMDA3dXdC?=
 =?utf-8?B?QS93V2Rpd1g2SUVnRlEvS2t4bW9NWC9KTURsUlpzL0lUbjJYaUtYR2VGWkJB?=
 =?utf-8?B?VUZ5K2ZCMlZzWnlSOHRIMTB6OE1veU00ODcxS1pCcENiS1V2M0N3UzRlZEdH?=
 =?utf-8?B?bFJSemh1WTNJZ3lXenR6a2ZSTUJlTjR6NFJwRFJMaVB1Y3F1NzUzSEtFV3Rr?=
 =?utf-8?B?K1BwNkFsRUM2Vm1tUS85UGZpUnhlaE9HT1R2RjFGN0dmSDFXRERWejNyV1NZ?=
 =?utf-8?B?WjZrdURmRllEZzZ6aXR6YlBtdi9QQ1U4czQwcFBWQWRXQmdXZG5ZWE43YXZu?=
 =?utf-8?B?S3c4STBLTlJwRnF6TldaWVI4aWlMTThrL3A5eHpzMkdQR0QzMmprdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39242520-d67c-480f-72e7-08da49526fc4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 13:26:03.9044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqVJ78Rtn9JWxtzz17TXYNmnWBNPuLFu2q/SMjd2eD9p1wMKQ0NBdVd5Yo9PH40pdDMLzir/rqHEE//BCLURcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1165
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



On 2022-06-07 13:58, Aurabindo Pillai wrote:
> 
> 
> On 2022-06-07 11:34, Leo wrote:
>>
>>
>> On 2022-06-07 05:40, Chandan Vurdigere Nataraj wrote:
>>> [Why]
>>> Getting below errors:
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1414:5: 
>>> error: implicit conversion from enumeration type 'enum 
>>> scan_direction_class' to different enumeration type 'enum 
>>> dm_rotation_angle' [-Werror,-Wenum-conversion]
>>>                                  mode_lib->vba.SourceScan[k],
>>>                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1744:22: 
>>> error: implicit conversion from enumeration type 'enum 
>>> scan_direction_class' to different enumeration type 'enum 
>>> dm_rotation_angle' [-Werror,-Wenum-conversion]
>>>                          && 
>>> (!(!IsVertical(mode_lib->vba.SourceScan[k])) || 
>>> mode_lib->vba.DCCEnable[k] == true)) {
>>>                                 ~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> 2 errors generated.
>>>
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5484:18: 
>>> error: implicit conversion from enumeration type 'RequestType' to 
>>> different enumeration type 'enum RequestType' 
>>> [-Werror,-Wenum-conversion]
>>>                          RequestLuma = REQ_256Bytes;
>>>                                      ~ ^~~~~~~~~~~~
>>> 18 errors of similar kind
>>>
>>> [How]
>>> 1. Add typecast at relevant places
>>> 2. Move the enum RequestType definition ahead of declarations
>>>
>>> Signed-off-by: Chandan Vurdigere Nataraj 
>>> <chandan.vurdigerenataraj@amd.com>
>>>
>>> diff --git 
>>> a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c 
>>> b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
>>> index b77a1ae792d1..5828e60f291d 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
>>> @@ -1411,7 +1411,7 @@ static void 
>>> DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>>>                   v->BytePerPixelC[k],
>>>                   v->BytePerPixelDETY[k],
>>>                   v->BytePerPixelDETC[k],
>>> -                mode_lib->vba.SourceScan[k],
>>> +                (enum dm_rotation_angle) mode_lib->vba.SourceScan[k],
>>
>> Hi Jay,
>>
>> This seems fishy, dm_rotation_angle and scan_dirrection_class are very 
>> different enums.
>> Comparing dml32_CalculateDCCConfiguration() with 
>> CalculateDCCConfiguration(), it seems dm_rotation_angle is new for 
>> DCN32. Is passing vba.SourceScan correct here?
> 
> I agree. It should be typecast to scan_direction_class
>>
>> One more comment below.
>>
>>>                   /* Output */
>>>                   &v->DCCYMaxUncompressedBlock[k],
>>>                   &v->DCCCMaxUncompressedBlock[k],
>>> @@ -1741,7 +1741,8 @@ void 
>>> dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib 
>>> *mode_l
>>>       mode_lib->vba.SourceFormatPixelAndScanSupport = true;
>>>       for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
>>>           if (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear
>>> -            && (!(!IsVertical(mode_lib->vba.SourceScan[k])) || 
>>> mode_lib->vba.DCCEnable[k] == true)) {
>>> +            && (!(!IsVertical((enum dm_rotation_angle) 
>>> mode_lib->vba.SourceScan[k]))
>>> +                || mode_lib->vba.DCCEnable[k] == true)) {
>>>               mode_lib->vba.SourceFormatPixelAndScanSupport = false;
>>>           }
>>>       }
>>> diff --git 
>>> a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c 
>>> b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
>>> index 6509a84eeb64..07f3a85f8edf 100644
>>> --- 
>>> a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
>>> +++ 
>>> b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
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
>>> -    enum RequestType   RequestLuma;
>>> -    enum RequestType   RequestChroma;
>>> +    RequestType   RequestLuma;
>>> +    RequestType   RequestChroma;
>>
>> This might need a wider cleanup, enum RequestType is defined in 
>> display_mode_enums.h and is already included in all the 
>> display_mode_vba*.c files I've come across. Unless I'm missing 
>> something, we shouldn't need to redefine RequestType.
>>
>> That said, there doesn't seem to be any functional change, and it 
>> fixes a build error. So
> 
> I'm unable to repro this error. Are you using clang? If so, which version ?

Hey Jay,

I was checking this patch in our CI, and we can reproduce this issue 
with a clang.

Thanks
Siqueira

> 
>> Acked-by: Leo Li <sunpeng.li@amd.com>
>>
>> Thanks,
>> Leo
>>
>>>       unsigned int   segment_order_horz_contiguous_luma;
>>>       unsigned int   segment_order_horz_contiguous_chroma;
>>> @@ -5350,13 +5356,6 @@ void dml32_CalculateDCCConfiguration(
>>>       double   detile_buf_vp_horz_limit;
>>>       double   detile_buf_vp_vert_limit;
>>> -    typedef enum {
>>> -        REQ_256Bytes,
>>> -        REQ_128BytesNonContiguous,
>>> -        REQ_128BytesContiguous,
>>> -        REQ_NA
>>> -    } RequestType;
>>> -
>>>       yuv420 = ((SourcePixelFormat == dm_420_8 || SourcePixelFormat 
>>> == dm_420_10 ||
>>>               SourcePixelFormat == dm_420_12) ? 1 : 0);
>>>       horz_div_l = 1;
>>> @@ -5527,11 +5526,11 @@ void dml32_CalculateDCCConfiguration(
>>>               RequestChroma = REQ_128BytesContiguous;
>>>       }
>>> -    if (RequestLuma == (enum RequestType) REQ_256Bytes) {
>>> +    if (RequestLuma == REQ_256Bytes) {
>>>           *MaxUncompressedBlockLuma = 256;
>>>           *MaxCompressedBlockLuma = 256;
>>>           *IndependentBlockLuma = 0;
>>> -    } else if (RequestLuma == (enum RequestType) 
>>> REQ_128BytesContiguous) {
>>> +    } else if (RequestLuma == REQ_128BytesContiguous) {
>>>           *MaxUncompressedBlockLuma = 256;
>>>           *MaxCompressedBlockLuma = 128;
>>>           *IndependentBlockLuma = 128;
>>> @@ -5541,11 +5540,11 @@ void dml32_CalculateDCCConfiguration(
>>>           *IndependentBlockLuma = 64;
>>>       }
>>> -    if (RequestChroma == (enum RequestType) REQ_256Bytes) {
>>> +    if (RequestChroma == REQ_256Bytes) {
>>>           *MaxUncompressedBlockChroma = 256;
>>>           *MaxCompressedBlockChroma = 256;
>>>           *IndependentBlockChroma = 0;
>>> -    } else if (RequestChroma == (enum RequestType) 
>>> REQ_128BytesContiguous) {
>>> +    } else if (RequestChroma == REQ_128BytesContiguous) {
>>>           *MaxUncompressedBlockChroma = 256;
>>>           *MaxCompressedBlockChroma = 128;
>>>           *IndependentBlockChroma = 128;
>>

