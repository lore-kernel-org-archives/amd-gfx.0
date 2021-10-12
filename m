Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E325CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 13:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB1446101D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 13:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB1446101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 223096E993;
	Tue, 12 Oct 2021 13:55:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B4076E993
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 13:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3A6ebADDLQmZxp3CHpfJ6/RpnwNGLQ+gP4voe69w1/XHDsJf73wHcYsXcxkdos/M27OsGWl47hCHpdGcoqR8xgAVYkXPfsji3om3iuSmq0epGR/IT/Du3PGSOVznoCuGUr3a4tYriEL8LpPUsrHgW/V4c3ma6HucLPQ/ljb3oz2gGuENB7gry0mTajRe0ZDFVh8GPxsNPD7UXKACFhJddwEF1FZog4D8cS7W5YWLG7ET3p5vfdVO2lq1iYgPJkr/AJmjgcTdPeBfJPt+vWEj4UcGiLbzX3Rxc6UUi3rv3Mh6t5zheT18o54khYwQDthz9IP7C5/V7w/1qeyNyyzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2oHtSCYhJPAMwtjmG5gWXWfnJ1ZBEMZz/XC0aSzlI0=;
 b=F1w0N83YviwWS/PUz6b1aZwGOgIIlqYgcJ3sgRI5SSXxBpQntlt1y516ynDUdsDXWIo8wEm0RD7bYAqQ+J/xQpqLXRd54lok6gUE7VhLqOlTlxo+CuC5YmYZzdrlAOxaDdr3bBOcqUXt4Yc9SSVLOqaPkF0Aut2mHIedSqMlpB8otkC97mXPIYJ+oYx3jUAt9Vt3yRLK467Z+X4YS2BbWmDf76M3SXYG2tWwRTQVo6uwlDJrLZs4sLxZmGBH+jpJucNuhzPeEpgye635r6qXxVDI4MUEYZz9WuJ8ClaRdKxxWujub3Za2xj/DoZE8CdTRFCheOp+NWHZ5ohTGv7I6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2oHtSCYhJPAMwtjmG5gWXWfnJ1ZBEMZz/XC0aSzlI0=;
 b=ywPAv8BtjtGOwNTbuXAv+XtaY1nyd1fVWvNsRKCzOnDzTq29r55GDNnONomp6uDYH697JKG+jcQx8th4WdlKFSsOn/q/DRrqCGZBlCP+/MIFLa+p+32ejKtwuO4z+gICz/L+afbg+LaFIDa/7BBiJpzpBtCa+aDuKKHqjP7m1rM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM8PR12MB5495.namprd12.prod.outlook.com (2603:10b6:8:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 13:55:09 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3%7]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 13:55:09 +0000
Message-ID: <ab43f0c0-8c1c-9312-9b2a-2e1726157c10@amd.com>
Date: Tue, 12 Oct 2021 09:55:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] drm/amd/display: Enable PSR by default on DCN3.1
Content-Language: en-US
To: "Vishwakarma, Pratik" <pvishwak@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211008161415.4296-1-nicholas.kazlauskas@amd.com>
 <09d8abec-7e83-a83f-e53d-ae827b753e7a@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
In-Reply-To: <09d8abec-7e83-a83f-e53d-ae827b753e7a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::8) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
Received: from [172.31.16.161] (165.204.54.211) by
 YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25 via Frontend Transport; Tue, 12 Oct 2021 13:55:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e06ad46-cd3c-48d6-738d-08d98d87e752
X-MS-TrafficTypeDiagnostic: DM8PR12MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5495A26E5C718104ED0E12C7ECB69@DM8PR12MB5495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cPSu4YNPSmtoZoggoYetMHvO8gJX6fcw/nfo3Njcii4euNcBhnSYowyJARKLWbQg7liv9u6nYA9Qxak+zURAIbT/OoQ4EQRU9Zho3Y/JC51ersoieQhIQ9o20QTthyVve7KCZrB1FIY9lf8HkT+5d+mKpxuEeBLJkgF3e/CXFgksw2tugaIMEAISzCFtuCZjx32n23JcrufxF3iQvq8gGjKcDwFyjY6+QCXvsz5/bxijSYqeSwNPX/PYXm2s3nsxMdAniXGZYR+Y10Ag9moliTIVb96sfQunbg1PICbfp0KzO3jxJCVbsMsaN683/oq3vFTgThZ+yz80Os2ONxHRr+S6SMt1dOH5/qAXyxnpDPxgUPHIvG/NENUYmQUco7E3bmWA74kdUh4z6ptAXKCT0A0odentTnvleqZrKLRZOKPU0EYF1SAgPMmj9RmG7KOBva8OcUArAx2DBmzOCKrrQfXGBRzadwAfI/5nxFvVRAUKusYypMjhDbqI27iVAW6QftEqtrkgDLihuyGcVTbavWcKBvFI4DEAjeH2YxLXZ7oX7+KLplZ7+L1WlPKaEpfjEZi4uk1zcd8YvfUQvSVisLr7dTeM0vb8UDhB7nsIzVIWTQIwSkhUBGZAc3BqTVK75+H3uoXapvO8rVx9W67iABDc1AaZHNYTM9lpg62xgRQEgWuf1aAGbuFqIFRmrIncDUHuusZ5K1GwdgxkVF4KuzBKZ0MDESC2qHPTLWRpfos=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4001150100001)(2906002)(31686004)(53546011)(508600001)(36756003)(8936002)(83380400001)(38100700002)(8676002)(26005)(186003)(6486002)(31696002)(86362001)(66476007)(66946007)(956004)(16576012)(316002)(66556008)(5660300002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjdoZlZGbDBBUmN4TFI3M0I1Y1F2SzJUenFieW9WbFQ4eG9IOHlxU1BXNkVa?=
 =?utf-8?B?UWhRY21FazEvNnRobDljTVY0d0VTMXcyMHVoQ1dzcjFRV2tsZkxkaFNzWmNu?=
 =?utf-8?B?bGwvVzNHZVVqNllJTkpLZkZoK3FhaHR3MWdWZEdrMUFRNnAvL09XOHkrTWZL?=
 =?utf-8?B?RUlRM1h1eVpSdjI2R1lidDRxemxZcHlocFBzbXhSYnhnVHZYVFUvMjhETGFw?=
 =?utf-8?B?bXJJaEViT0o4VXcwMnhOOVpwNGlzb3VqL0p3UXNvYkhvaitiWjUxVVFackhu?=
 =?utf-8?B?R0FpZ044bUZyaVhDYjltRTNXUkRoSWNuNXhmZjRqS2RtaVVQUWwwZDlkTzBE?=
 =?utf-8?B?TWgrZW1Hekc3dlNwRzkyYk81d2t0VlY5SDM1MFRIRWMyTkdlWU1MdDFSdjVh?=
 =?utf-8?B?Uis5WnpHUVhCem1BRzg5bnVoaVF1QTZQSjZDbmpkZDVCd1QvT0h5WGZycnkz?=
 =?utf-8?B?Rjg5ZFF6ZWQvWnZLcEIyVFRXNy9Pa3o1b3pkeUdsalpVOUo1bUR3eDRTMVVP?=
 =?utf-8?B?VTUxZkNqOXB2Wm1hOUhVUU5ISVl6TGxkRlF6QlluRXBNWlp0RmwwOGtpZ3Q5?=
 =?utf-8?B?V21BVFRHcmJSeWxaNzk2YXYxY2VQU0Nob2JUTzdGZ05OTElwcjY3dFQwUHdq?=
 =?utf-8?B?WUQ2TVpDS25vM2ZEa2tsUlA0ZFlFTFlFejl0NkxGQk5TeVVlVmxXOEhBOXkz?=
 =?utf-8?B?UXRQamFJUUdQa1FLQmhyOUtQNCthakJwQ1FhSDZOb2ZKSmpjZjZNOExhN3FZ?=
 =?utf-8?B?OTk1UlJSaUMzZy9HT1k5ck1mWWVQTDN4YzBKQnZjSFdPN3NkYkUrZVBNanh6?=
 =?utf-8?B?eVBTRDdhR1hlN3FaSXFWZzYzVEUwODhLYld3emdaZjRCZ3J4UnFHZC9Zc2Vw?=
 =?utf-8?B?R2hyMFg5SjNidytOZzMvcyt2c3V2anFjNVNFRjRHOGFUWlYyUytGUDNpSFY2?=
 =?utf-8?B?ZlBLNEFiMm85Ynd5dGpxWnFJeEhKYW1KYnByQVk2RnFxcVROcHVkcnBCTy9W?=
 =?utf-8?B?ZEwwREs0SXU2cEFJbFJtZHQvd3RRWkp2WDQwb2dPU0hBOWhRdWloc3RvUmZh?=
 =?utf-8?B?WDMyZDFEN2FmWDNyQ3JrQURzZUFDcU1aUVVoLzlZMlJrUENqaC9qazZNNURP?=
 =?utf-8?B?YmQzeERFL2I0ZGxWdHJ3bXpJS0ZTSGk2ZUZXWTdCaG8rWk5qQU9kR3VKNGFJ?=
 =?utf-8?B?TUNubDdqd1N5UFozZEJQTGJCTGdiRis2eTlURzZpUlBvdHRKZFl3TktjNmF6?=
 =?utf-8?B?SHU3dHdZQno5bFRzU2ZNUG8vYkZwclBEeTcxZ0pteWVCTzJGTk1GTDU5S08w?=
 =?utf-8?B?ZS9UVlRjeUtIYjFXS0J6S3hhRnJaVHVhcElyK0pEQlUrdjFTR3RPdFJ3OG1a?=
 =?utf-8?B?aUdtZFhaU2h1cDJaTnlMZS95UWhTU3NUN0NDek1xMjllbktBb01qZDVHb0lX?=
 =?utf-8?B?MC8wUGZTWHBtUXZuZ2ZZSktsbzlYTjUxcGlaUExnaGo1bm42QXJpUFY0VFFM?=
 =?utf-8?B?MXJRNGduV1pGcjZtMVJTajFoc2VNMEVLN1JPcFdyOFFZVU9QMFVtN0tGY0ZJ?=
 =?utf-8?B?YndhZmlnUmcrVkdOVjRiVkI2UkxxMlhQaC9pRzRSQzMwcUcwSE1aVjI2R0tw?=
 =?utf-8?B?ZjEvcEMzWm9wRTBhYXZ2TWE0OWFGOXgvdUYxM2xlKzdsN0NDNVhwaTZXcUc0?=
 =?utf-8?B?OFFaRnFFMXh0TkxKMnB2UmNyRlFULzhScWs0ZjBCdnZEYzRlOHBDL01qTlNy?=
 =?utf-8?Q?LYXS/g2Zf51Yl82GzZ/qy0rmvRXHhqQfJ6zAU/i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e06ad46-cd3c-48d6-738d-08d98d87e752
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 13:55:09.3176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxFKzjFqvVIU550A7RLuUQWxIceVpfdselzW2K42VHfwt3JhQU/HSwVdKEr6vGcHaDWaGjwHcmteMdwFv0Tl4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5495
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

On 2021-10-11 1:04 a.m., Vishwakarma, Pratik wrote:
> 
> On 10/8/2021 9:44 PM, Nicholas Kazlauskas wrote:
>> [Why]
>> New idle optimizations for DCN3.1 require PSR for optimal power savings
>> on panels that support it.
>>
>> This was previously left disabled by default because of issues with
>> compositors that do not pageflip and scan out directly to the
>> frontbuffer.
>>
>> For these compositors we now have detection methods that wait for x
>> number of pageflips after a full update - triggered by a buffer or
>> format change typically.
>>
>> This may introduce bugs or new cases not tested by users so this is
>> only currently targeting DCN31.
>>
>> [How]
>> Add code in DM to set PSR state by default for DCN3.1 while falling
>> back to the feature mask for older DCN.
>>
>> Add a global debug flag that can be set to disable it for either.
>>
>> Cc: Harry Wentland<harry.wentland@amd.com>
>> Cc: Roman Li<roman.li@amd.com>
>> Signed-off-by: Nicholas Kazlauskas<nicholas.kazlauskas@amd.com>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 ++++++++++++++++-
>>   drivers/gpu/drm/amd/include/amd_shared.h        |  5 +++--
>>   2 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index dc595ecec595..ff545503a6ed 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -4031,6 +4031,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>>   	int32_t primary_planes;
>>   	enum dc_connection_type new_connection_type = dc_connection_none;
>>   	const struct dc_plane_cap *plane;
>> +	bool psr_feature_enabled = false;
>>   
>>   	dm->display_indexes_num = dm->dc->caps.max_streams;
>>   	/* Update the actual used number of crtc */
>> @@ -4113,6 +4114,19 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>>   		DRM_DEBUG_KMS("Unsupported DCN IP version for outbox: 0x%X\n",
>>   			      adev->ip_versions[DCE_HWIP][0]);
>>   	}
>> +
>> +	/* Determine whether to enable PSR support by default. */
>> +	if (!(amdgpu_dc_debug_mask & DC_DISABLE_PSR)) {
>> +		switch (adev->ip_versions[DCE_HWIP][0]) {
>> +		case IP_VERSION(3, 1, 2):
>> +		case IP_VERSION(3, 1, 3):
>> +			psr_feature_enabled = true;
>> +			break;
>> +		default:
>> +			psr_feature_enabled = amdgpu_dc_feature_mask & DC_PSR_MASK;
>> +			break;
>> +		}
>> +	}
>>   #endif
>>   
>>   	/* loops over all connectors on the board */
>> @@ -4156,7 +4170,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>>   		} else if (dc_link_detect(link, DETECT_REASON_BOOT)) {
>>   			amdgpu_dm_update_connector_after_detect(aconnector);
>>   			register_backlight_device(dm, link);
>> -			if (amdgpu_dc_feature_mask & DC_PSR_MASK)
>> +
>> +			if (psr_feature_enabled)
>>   				amdgpu_dm_set_psr_caps(link);
>>   		}
>>   
>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
>> index 257f280d3d53..f1a46d16f7ea 100644
>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>> @@ -228,7 +228,7 @@ enum DC_FEATURE_MASK {
>>   	DC_FBC_MASK = (1 << 0), //0x1, disabled by default
>>   	DC_MULTI_MON_PP_MCLK_SWITCH_MASK = (1 << 1), //0x2, enabled by default
>>   	DC_DISABLE_FRACTIONAL_PWM_MASK = (1 << 2), //0x4, disabled by default
>> -	DC_PSR_MASK = (1 << 3), //0x8, disabled by default
>> +	DC_PSR_MASK = (1 << 3), //0x8, disabled by default for dcn < 3.1
>>   	DC_EDP_NO_POWER_SEQUENCING = (1 << 4), //0x10, disabled by default
>>   };
>>   
>> @@ -236,7 +236,8 @@ enum DC_DEBUG_MASK {
>>   	DC_DISABLE_PIPE_SPLIT = 0x1,
>>   	DC_DISABLE_STUTTER = 0x2,
>>   	DC_DISABLE_DSC = 0x4,
>> -	DC_DISABLE_CLOCK_GATING = 0x8
>> +	DC_DISABLE_CLOCK_GATING = 0x8,
>> +	DC_DISABLE_PSR = 0x10,
> 
> Don't we need a corresponding check in amdgpu_dm_init() to disable PSR 
> in runtime?

The check is `if (psr_feature_enabled)` above.
> 
> Also, how does it handle conflicting declarations from feature mask and 
> debug mask?

Feature enable mask is used for older ASIC to allow PSR to be enabled.

For both old and new ASIC the DISABLE mask takes priority as a debug 
option for disabling PSR support.

Regards,
Nicholas Kazlauskas

> 
> /BR
> /
> 
> /Pratik
> /
> 
>>   };
>>   
>>   enum amd_dpm_forced_level;

