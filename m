Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DA6C5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 16:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBD810EBE5;
	Fri,  1 Mar 2024 16:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T838v/lE";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6512810EBE5
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 16:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbzIhWpCfisJcmsJiotCfwzX9djOFIE0d2G6ZIbcmGw9dpikXQi2iVm3QWPFPXKUFTz7C+nblB4r4UqDtgd7LQCUTDuEcS2D0eKT/f523LfcLZIHIRqYDLEomo6ZkjTROAisIpaBsVoPRzM0oT5mXP0a96k/oDa/1ZE5IkgiHB8ustuKJ3nHqA/hxPhU9jiQXWsu6PDAnJygQTdlb/U1Ns46zwMYaUkj8+wNV/rCOSFvyVzkdQ1b/wtuCavdcDEdXMb6esDQ5S3R73BiLMWYtLevgtQHau2zpuYy1AbhMtFc59Arf325zrt7ehRqOtaSaJ4lOCXlSMdjjAUM0uXO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SadDghCnLFDa14gzMopyxzZMf8mD4I213vfifgJVW4k=;
 b=PZlALGhGr4GWqyCaWvtXiewvo/FNcXx+Z7dNTox3PdwwPs9j7ASRlm6yfKp+J/Y+aPgNGDrd9D/p5dlny4WQ86qfp/WwuJwieVDxU0MRHxg0wZ/p7e2t7Vg+wSp518QIYx0nulcRqMrICLb6YbvfhEW7dBdLgCBBU3dL11D8gLYd3zmsbZYibBJZEExwWx1DXANgne/1n9KvF2YYkL6EyXKUd33juLpES+48nxh8jYWEpBY/LzlyMohimZNP3TF6EDpGLLnUiD42q/S23DGyhEHupDfybvNCQHc63YHiYmkE5Vqk8eKmVd5fbyMAoduKZMJxqW84gDRcot72oigGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SadDghCnLFDa14gzMopyxzZMf8mD4I213vfifgJVW4k=;
 b=T838v/lEtUFeKtLclVeEZ8iyPXXUlL+/rHr71nt0lQBj2GPg5UOiE/bX2n+oKSEC26hnwLgV6CDkWBzQaLqefgUuLPTbSQzy0k+FVatfzVSDX41tn9C/7LdspzF80CcO4BI2kw4icIDqahwDOJEeunpbqJvsmqtyQNyOjyrXt/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 16:42:39 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6c3b:75a3:6af2:8bf4]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6c3b:75a3:6af2:8bf4%6]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 16:42:38 +0000
Message-ID: <b5ded736-d240-439b-8808-5a19397fc6fa@amd.com>
Date: Fri, 1 Mar 2024 11:42:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: handle range offsets in VRR ranges
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240228211154.3498505-1-alexander.deucher@amd.com>
 <CADnq5_N5P35-s3Gy3ziNCQ1P4a1AhYReDe-J432w8ZtUkDcPrg@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_N5P35-s3Gy3ziNCQ1P4a1AhYReDe-J432w8ZtUkDcPrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0294.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::18) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d8b2b6-dee5-4d0f-5896-08dc3a0e9b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I7F42j6okn3c2zZbLkCAwGFG+4QgBrGYmQfF48g3koJ3rtTL/0TPOP05SaOnFw2BZ54q46Ke05pyn3G6BzrnvDHN01TELng/gOlZy9Z+9uJu5cTDke0sdqsebYwt/3lWn9SjkhVGmRtjH6dwsGElM30iNmtFFg3fRIU1XceIH2ET1AoObNZy3Qq7U11p8P7FtrukDlu8iRZwBilyavsAl55rRTtjmOi0IzrkWsSSkPZJI6s01J54PTY9bC5xRShXcqWxpAhy8IhvTjTcM7hS1aMjYB4izCy0q4AC6wgmz0F5FHnLcCwfDDZ6c4GBUgfJmH818AggSYKzObvWXAK379NKJhsAPZ4l0+cXITBjc//EKA+oS/tXQFx7MaSKAxH/DZnA+29ZGS0vKgCp9cVqLq7Lo5vZuorK45qgwoxAPPAwXqL633dcjRFMByn5ueX7H8v+iz0QjBjyMBaG6SvU4GgYJrRLlYkeH484Fpu5BhOhC21R0S9f2lidfUjBPNjtFAwSero70r+OI/b6WxMZ/uarfS2w8R1MgkKgyfjR6VQpwbfSYhCqQlNu4QsLSxQNUy7V9sfyrTf9cqWV6nZAhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXc2d20wUUM1MXdhdExETWJZa0lnVFdteFE0R2RBelNSbFJSL2ZzTzRGbUR4?=
 =?utf-8?B?Y002OG8vR1oxdGhJNytMQ2dZaXJlOXJNTnJwQTRFdkRhWXk1WEFGalJGWStV?=
 =?utf-8?B?eVlrYml6V2hnc3c4UDdJWnRsYWZHRFR2dmNweVVGR2pSZ1hiMmQwUXFwQ2JM?=
 =?utf-8?B?aktvcUxsd1JlM3lkUG5Qd01haU9WM3lVZS82Y3hGWUU0dXhPNkVhVWtUcXND?=
 =?utf-8?B?c3p4a2VaQTZ1VGlidHRMOEFtRkRydDNtZkplSXZEUC8xQ0Uwd3dpTWZJemts?=
 =?utf-8?B?SStEK2JRbVN0S3ZCVDVwb3NmYm1NckFrMHJGV0h1aGZSQ01QU1pOM2NWMUFW?=
 =?utf-8?B?OUx1SUpVYjUwS0hITEdvb3ZidFVLazJzVFVmTDg5ZGFjajNkM3FIYnd6T3lL?=
 =?utf-8?B?akwyN3JselFhU0NQYmdxVzRtTWZHTXBUSkFuUG9LcUUzNVVITVZGUWxxVER1?=
 =?utf-8?B?WjR5S0JJL0JBZnZsMzJsQjA5M1dQVVQyQkNVOWhhV2J3RjlqQ3QwQXZsYnVt?=
 =?utf-8?B?SWdSdW5peWxmWTQvYStwczZuamtoNHdIUFBIV0JNMWZwWDFjakVxdnBIWm5R?=
 =?utf-8?B?ZjVibjU4eGJsVXZXR1ZwTUhTcTNDdkdhUjdWUCtxQnc5WFk4bjFxb25mUUdB?=
 =?utf-8?B?RExSWDRkV3JKMzF1OVFTU1dSY0pzT1J3ck5VbzBVejh2eEdpZ2dDeWIwTEhS?=
 =?utf-8?B?VEFzamRDeHFKT1p6WUVlQUNETXNwalpVV2hxK2J4UFhhaG04WTZvODJNMVl3?=
 =?utf-8?B?U2FPUG5qRlYzSUV6OWtBdnRpYzBuUmV2N1JEK2drTG1ONHZyankyTDZxelZ5?=
 =?utf-8?B?YTYxVHpaTC9lTEoxazg3L04xMkU5dmxGY2R2MWhkc0dUVENDRjlMQVR4V1k1?=
 =?utf-8?B?U1ZHVmxKUUVCUmVnZzFTbXJEMDliR1pUM0pRMWVEdDJ2WWxQdXBFUGRGYkVa?=
 =?utf-8?B?bHNMU1BkandpMDZnVCtKdTY2MlBnd1ZVVWoxQlFlSTRXUm56YUx5T0gxdklB?=
 =?utf-8?B?TVc5c0JNZG5NL2h3bTAwSldaVDBLVE8xQjRxdG1rQXVWQUd5Z2d0TTdQRTJJ?=
 =?utf-8?B?bHZJeTQyUkpnR01obDA1R28yNGMzam9QaFdXeWdJbGgzVjZNWTdkNkswVVZ6?=
 =?utf-8?B?YTR5NXlLNDlhR3RCUklzaTVTeFE1a0pWYm16T1dkV0NYZURwZjVKYXZCRm9R?=
 =?utf-8?B?QkY3bDhSbUhQMWlOWmhPOWVGdUJLVjYzWEtVd1FTd1VOWXV2Y2xSZnZKdlBU?=
 =?utf-8?B?ZjFYcElmWTc4TlZzUFRiQWpXdGZXeCtwQ3hrL09rVmhpTkw2Zm54T3ZlR2tk?=
 =?utf-8?B?RWcwbjhxSnp3Y0NQekJYT3FLZGorSmNNOTlnQjdtVzhMTTZNelJJNUlRZ1Bn?=
 =?utf-8?B?dFZZQWFubk51aTArdFFYVEtmSEIySHJZT2dZRUhQbVRxRXhYcE5oZjhmZEE1?=
 =?utf-8?B?elk5RmRDbmRvSU4zUEFjRlJFYmV0NTM0by91UU03T0NxbWdhL29BMWdnTHVZ?=
 =?utf-8?B?QkZkL2NZaUpXM3BCODIvVG55Z2FXRklPQTJLK0Z6bm1RSGVyeXhyVU5WbmRV?=
 =?utf-8?B?NUJPNGtma2h3QUpCZW93Ylp5SmVGTVFKQ3p2VFdOUThXM2FGU09zc0RwWlp2?=
 =?utf-8?B?VkZTaUZHZGVoVThLb002WmhpOC9oUHNkNGNXNnh6VWkxNjF4OHJJcWJxZHNM?=
 =?utf-8?B?UVBiVDJVNWFsU3FrOGlzblRLNDNTWThaSktrSUVOWEwzWHYvUzl3c1lWM2VW?=
 =?utf-8?B?QUsrRVhCdzhKUU9qdERjSWhoY2w0WWgwTXJseG1RQmw1dUptQzlRVnY0N1h0?=
 =?utf-8?B?QStTR0dhYVJjRHltUFBlWExkd3luWk4yOHBsaE9WWlI2SzZkMFI3SEh4bDNj?=
 =?utf-8?B?RHBaZGJvS0RkNy9XdDlyWnhLUGxseVk1cHpWQ01tMEltOFVzU0Z0VTJodmli?=
 =?utf-8?B?WUZiZExQOUpFY3J4dGRicnBVYXpRY29XNGRaY0ZOUWU5S0h6VUdIazNqYjV6?=
 =?utf-8?B?V05jYjYyZ1YxaUZRZEpQY3JwUm9GcTNFUnVqNkpOYjBkd2xhUC9uZ3Z5Yi9O?=
 =?utf-8?B?UWdwb0JoeG5tb1VpOWUrRlF1eFpNaWlhNTJISE5lWUExdFZpL3ltN2pnSkdE?=
 =?utf-8?Q?ic2biJLwRdcTDzHVx6t2ch7Zx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d8b2b6-dee5-4d0f-5896-08dc3a0e9b20
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 16:42:38.9026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TS7RJqIKcb9fQdn7ZX2Z6i5AlR56eyt064BoWfrU3arYcnctSmljfnji9WnIkrFbZR8KuXtl+eDPwicgHdKrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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



On 2024-03-01 08:55, Alex Deucher wrote:
> Ping?
> 
> On Wed, Feb 28, 2024 at 4:12 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> Need to check the offset bits for values greater than 255.
>>
>> v2: also update amdgpu_dm_connector values.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3203
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

>> ---
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++++++++++++++-----
>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 32efce81a5a74..4e4cbf2e33dd2 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -11292,14 +11292,23 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>>                                 if (range->flags != 1)
>>                                         continue;
>>
>> -                               amdgpu_dm_connector->min_vfreq = range->min_vfreq;
>> -                               amdgpu_dm_connector->max_vfreq = range->max_vfreq;
>> -                               amdgpu_dm_connector->pixel_clock_mhz =
>> -                                       range->pixel_clock_mhz * 10;
>> -
>>                                 connector->display_info.monitor_range.min_vfreq = range->min_vfreq;
>>                                 connector->display_info.monitor_range.max_vfreq = range->max_vfreq;
>>
>> +                               if (edid->revision >= 4) {
>> +                                       if (data->pad2 & DRM_EDID_RANGE_OFFSET_MIN_VFREQ)
>> +                                               connector->display_info.monitor_range.min_vfreq += 255;
>> +                                       if (data->pad2 & DRM_EDID_RANGE_OFFSET_MAX_VFREQ)
>> +                                               connector->display_info.monitor_range.max_vfreq += 255;
>> +                               }
>> +
>> +                               amdgpu_dm_connector->min_vfreq =
>> +                                       connector->display_info.monitor_range.min_vfreq;
>> +                               amdgpu_dm_connector->max_vfreq =
>> +                                       connector->display_info.monitor_range.max_vfreq;
>> +                               amdgpu_dm_connector->pixel_clock_mhz =
>> +                                       range->pixel_clock_mhz * 10;
>> +
>>                                 break;
>>                         }
>>
>> --
>> 2.44.0
>>

