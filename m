Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A1AC54E5D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 15:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA81E10F49D;
	Tue, 12 Mar 2024 15:29:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W2SZf3V+";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DC3A10F49D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 15:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtwtgjvDjj/p8/Rc5upwRE/oFew7Hf9xZppE92CU2woPnbPFKj/bBkA0Xqyijwk82kHW/CSnBwNjd5A7+6BhXLh5nL03zLwrCZWyA8UB2aI22urfaYgehUt9MmDoE+oNo7ZnYuyDqxd8U3Zj/zfRUDXqraJUictDm/jenWCyieFUr/2UsjMKzmQO3kCBg2Wm+yHX1SvQVFwHaOLgzGz1ZkbS+6aJyrWIs636BCZwQ8nxWKMKaPAI5iynjr+DSJzPBkxCLoNCovGnjXoui2fZpDVnK0lWsQeszRda5kp3dMPhVXRmeEJ7WvvWiyEJ/YURW5ZbCD8TU6SU70FemEM78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSwYcmeCNJMPQO4OIl3XfiI4V8dWNn8qA4GWHzyXFYM=;
 b=mJlrHH3GJjxwxNwdmAVg2I4yxmiah7oXepJXpRqBgY3G1YEzZg/x/GllJTq1CB6Rve+J22iDVg8W2XbnRMyTAw7+XON71NuaN0AKr+ag64Djps5XmvsOTlc8RzpJGuwfDh+PBbZKXlZkEKk1232qSn78eY1PyiKU5r+Vq0u9aVjjT0tWMhUbZfpT1Oc0r71+bPxiMJ/vgd+MfrxCJxYLFz6Qs6Ov8L6QpmbdHkvYwx+dz1uQ1ABIDLLUkMaEfs/gYTURHVYHcP+zD3pMzMr6WlJx7f2+giiMRSrK4T/22W36uu8Vg0dCZnZbncI7sOdxpUuX4gc03mLaaaBCU1eD8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSwYcmeCNJMPQO4OIl3XfiI4V8dWNn8qA4GWHzyXFYM=;
 b=W2SZf3V+nNvoP23/LRwv1yrIVBXsajXNtXCVKx+jIFXPWOfqQm7APA79a8Lt5VaWBvDNY7fHHogJAncGtm5+4fFDoQ4MEoOOmO+zgIJUBW0YAL9kERkT2OmJ064+4gkIMiNvupLCa1ngTvbjLNxQL7C9Ze52TlnjkiQtZIPaHT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH7PR12MB6906.namprd12.prod.outlook.com (2603:10b6:510:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 15:29:01 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::8d12:60ee:8dfb:daef]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::8d12:60ee:8dfb:daef%4]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:29:01 +0000
Message-ID: <97384480-823f-47c2-8d9d-53d6ca4b890b@amd.com>
Date: Tue, 12 Mar 2024 11:28:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Get min/max vfreq from display_info
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240312134728.14046-1-harry.wentland@amd.com>
 <CADnq5_OsR1VpobKpDLhr+uKSBT05MUs42B1_PbazRT=P7AyASw@mail.gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_OsR1VpobKpDLhr+uKSBT05MUs42B1_PbazRT=P7AyASw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0178.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::21) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH7PR12MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b3107c-adbd-4121-767a-08dc42a9247f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kp4HbYHf6w8I7iBBFg1GcNdh5PLx52WPH1r5EWCdcVZziyma6JwingPyfoP/TLs8PyQHHCemi/w0vKfwf5YvmjRVDbS9NJF1QfL6jIeZI+7FwX0SR3MPTpGD6KuVViUReNRt0Xatoctqyh3sprtL1kjfBy0GpuhFAipZxJuGse1zEM245fwRSU6PdEBxNvb/c95GHsjmR5QFeSN3+P0VgWhFQD7P0SferKG9MBg6Hr4MHN7UjerBtS8zri/1+h4wEY00T+Muc4hKu8WmUMwH5apTZsbf1D6xGLapseZzxPISMCH0OZZ2PCn7yYQ/EFigxWYx0eg9gS2L7kHjvSVRpesPy690cbjDbJSpOBGeYCzqcK7dDBxwlbTC3R9H0d0CMkCvkWjfxLEK1iSvzeiLm7JrUaRm+xx+aMPvVgdszc6+bRRXYkBqH5+hALd4qQDXQTUNbov7jTAcAhlH7PLXoGZYjStfaUh8rUhbyEz3EW/cE7wJB94BkcfyvPF2m22QBKYPDKSOO0PP5eawaUYfYrNIStdeIkAy+mtZ7mYX6BOragXRSvL5KfH0XlsOyHuQAm3NaXNwYpKPN20v6hAcGpI7wcHVchWw2v7H7U2ckBxisa9rg7vMAeNSuuUhUqqYrnkDRzNb0V/boKXgHwTocfRqJr5ZcQDZQsY0y52zxx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0hUemZuOWVWY2JjbXc3bit4bG1BZGF6NHFtY2ZiUkxKNEpTdUJueG1zOUFI?=
 =?utf-8?B?R2ZORU5kc2krUnBabHcyaSt5UnlhRlh4bmFvSTlvT05UdkpVYVVzMlNwVUxL?=
 =?utf-8?B?WlZrakl1V2c4UXdNQVRZS0tocTFoc2NqaGR1cVNOQXZVZHlNOHlBMDVXZGNU?=
 =?utf-8?B?UW1FdzRmUEZ2alZPb1QvWW9WMks1OGVmRWxlUFpsR0lrNG1WNDlMZlRRczVy?=
 =?utf-8?B?QTJOVDExL3dvdnlKOVhZbk5saUlRSHhuK09sZ2FuVFV1QWlzakpIZTZjeVds?=
 =?utf-8?B?dFdBRGk4RzQ1VmlJdExyRGZ0ellUQ3grLzUwUDR0OFNuaVVGc3ZmdHVEOVZJ?=
 =?utf-8?B?VHNNODF5cmUxYWs1TllIODJ5dGV0TysxK1lnWmtXSTdNWWZGcytIMncrYmsv?=
 =?utf-8?B?VzJnK2M0NXBsOWpiM0JUaXNoWS9ITTdKQXhJaXVsMUhKUE9VVnNTS0FGOTRp?=
 =?utf-8?B?NGdCekdUYnMzU0RRMEZnWWZ3bHRYbjQ1clV1UndkZmFNc0ZGRWo1bXZVVmV5?=
 =?utf-8?B?MThucGt1WS8rZFg2clBnMkR1ejFxK2NiK0M5SmtWYVllVy9QZk9kSERqVUYz?=
 =?utf-8?B?Znc2MHAvcjFsQnRiSE5WUWJFRHpUWTd0REliOTdDcUJpZUxLUWw2VmYreHA5?=
 =?utf-8?B?NGJXSVhOMXdKaVZleEgyN2hudGJkRXhFRzFUY2lvYmxTdW55WTBURUh3NDdm?=
 =?utf-8?B?VldiMzJwQWozaFBkRkw1NlRLZHladlBPdGhZZkdqRjJqVDgrL3hDWllhaTVh?=
 =?utf-8?B?U3pmMWluSFRSWXJNZEJSV2RQNkFqbC9sd3dxaUlVNjRORUxDSUZWdTYwWmNr?=
 =?utf-8?B?S3A3RVBBa1FwREd1Q1RGNjMvZHY2ZkVua002QTlHcEd6d1Fmc0YvaC9sdG16?=
 =?utf-8?B?VGdRZXdSSGdsTHNvcUJyUEdlbVgzTTE2YXdzVm9uNktpMER2TGVURzRlbWZz?=
 =?utf-8?B?Q1lxSy9pOXY3dmdEbStFUGo4VVNLTTJjWlR0VGZpU2dSdFRjNktRTDE4VEVT?=
 =?utf-8?B?bFdYcThidmxGak5aU3lHM25oYXhTV3dBY2dtd05wVTVPamJ6dHhmMGFxUnFi?=
 =?utf-8?B?T1dEbGFJSTdTamZtT3JPdCtDTTBjYmg2MUVHVzFSRnBJMUFLVGFTei9JWmVa?=
 =?utf-8?B?Um9wOVNLUWk4cDJDeDE4OWM1VGNMNGNDdFRTVktzRVdNYnJOUWFJMkJUU1FE?=
 =?utf-8?B?TitVQ3FaMm1OZEpwNGY4ZkIxLzcxRnViU041RCtqb0hjb2NoWEkvUU5tZUdT?=
 =?utf-8?B?dDFtMWRKNHVaTDFqbVJTR3JwRTh6K3ZUbm1USXFQWVR3Y003NUNOTk5zcXlQ?=
 =?utf-8?B?Z2lIcUttNUdneHZCSTg4aGRwdHZma3pxeUtxeGNtdVJ2OFpWS2ZDTmplQWho?=
 =?utf-8?B?TVRNVGtjcGpIZGJJTjc1RDVmR0laenU0K2c2ZGdhandqdVA5eDNHMUhyZGd5?=
 =?utf-8?B?anlaU2lMYktPTUgzUkduS2h1a0JGV21OUW1FR3d3cit5TEZOTVU3bmdxMEVR?=
 =?utf-8?B?K0FjMkFOeVNBQzY0b01QQStXcGd1Nld5VEdUb0tkZE8vR3NhYitqWXI3MVQ5?=
 =?utf-8?B?V1NqZDUvVStNT0ZCL3ZMaUl3eGJKYVkxNjREMDJvOGVxNXhwa0xOSjlZYk02?=
 =?utf-8?B?SmNjekpzbXJ6V3lzaXgvdmRsUlNGVGl5MzFBTHdUd3pwYWQ5ellSdDlVK3dy?=
 =?utf-8?B?TmN2RVpxbTBLMVlRcDNCU0pWRHRUVjY2cWt6Y1VjZWpxZE1Vc1M2S0NCUHc3?=
 =?utf-8?B?NmJZejVHV0RVbHdjNXFRektrcHBxYVV6ZzA5all1MlIxMUFjL1dCa3Y0OXhz?=
 =?utf-8?B?bDU1OWcwbERneUdTTDVjWExTM2dQTWhEMGduQTN3cy9KUzBYMER5YmtiM25i?=
 =?utf-8?B?NC9LT0hPOXVrL2RSWG5HbXp2UjZHKzBZdTFpNy9Na08xZWlvcHNPb3FaSE5C?=
 =?utf-8?B?aGM2b0FZRk9lK3RhZy9BU3pxOWkyYjlDanVOOS9CTGNiNk5jRVVvekFVdlJa?=
 =?utf-8?B?NVBoWUIvV3NDbnRkZml1dTJ2VXFXd1pOKy9vcWlDUy9KUGFTL3BiUmorRzdI?=
 =?utf-8?B?T0NTSElOZ3Y5YzhNQ0s0K0FBaUZwMlY4S3dockMxZUVSb1g3Wi9HSjRmcWpN?=
 =?utf-8?Q?31vRzYqGg8SmM5XqokKsXsXtQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b3107c-adbd-4121-767a-08dc42a9247f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:29:01.1134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qx3omfTzBted0XoenxFT90wROLUjruCGCWMEc2a4xM+cMZ+c0G87rF1ccSv6bEeq5kjLxBCSUwiiZZDmL+3CWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6906
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



On 2024-03-12 10:58, Alex Deucher wrote:
> On Tue, Mar 12, 2024 at 9:57 AM Harry Wentland <harry.wentland@amd.com> wrote:
>>
>> We need the min/max vfreq on the amdgpu_dm_connector in order to
>> program VRR.
>>
>> Fixes: db3e4f1cbb84 ("drm/amd/display: Use freesync when `DRM_EDID_FEATURE_CONTINUOUS_FREQ` found")
>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index b1ca0aee0b30..cffb2655177c 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -11278,12 +11278,15 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>>
>>                 if (is_dp_capable_without_timing_msa(adev->dm.dc,
>>                                                      amdgpu_dm_connector)) {
>> -                       if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ)
>> +                       if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ) {
>>                                 freesync_capable = true;
>> -                       else
>> +                               amdgpu_dm_connector->min_vfreq = connector->display_info.monitor_range.min_vfreq;
>> +                               amdgpu_dm_connector->max_vfreq = connector->display_info.monitor_range.max_vfreq;
> 
> Does this need special handling for DRM_EDID_RANGE_OFFSET_MIN_VFREQ
> and DRM_EDID_RANGE_OFFSET_MAX_VFREQ as well (similar to the code below
> it)?
> 

get_monitor_range in drm_edid.c already handles it. I'm actually wondering
if the "else" and "edid_check_required" case is still required now, as it
essentially just duplicates the drm_edid code. But I don't want to rip it
out in the same patch and without a bit of testing.

Harry

> Alex
> 
>> +                       } else {
>>                                 edid_check_required = edid->version > 1 ||
>>                                                       (edid->version == 1 &&
>>                                                        edid->revision > 1);
>> +                       }
>>                 }
>>
>>                 if (edid_check_required) {
>> --
>> 2.44.0
>>

