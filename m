Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D17C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 16:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FDEC10E62C;
	Tue, 11 Jan 2022 16:17:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D59910E62C
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 16:17:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDZQh85bSwgRmzSWrarSyP2IZOkrfgNMi/2GzDy8vKxDIbilyvlniqGQloNxdLaLZ/ow62csZT4noRWeWOadsjt3cpBUkl0brb1Lj4vLzVZmCWPMlv1Rq34anbm7vgZfCvKMyLSDD8ONLmj+Xd87ED/Odz1FZFhUTMIx0My73NRJTBpY34ochfdZPx2V78LX78i30BM/HymNnIwz38vs+MwFdX6AuPrEGT9DG/8JgmBxi8srFWMLUa1g8bwCF4k4y2qI9r3MahPwzova7gMxJCEe2BvM0mcP9id3gndDsk5TWDRA/QOBJkCNt6qBj43YUIWGFLYiIkwN9dtzJBs3hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0ceI2WLQ4+bl+9+Kcs/sG3GiST6ud8qebUQ706NImE=;
 b=YnQd746lkeC7EtJ/1EirG/A9PHHfEBlCPHpGTgQ+IvdzD4T7NSaR93I0E+8zy0alJIHbeCN388mF+nITopRqnWbGN8HpkWw0E2Lfer16z6ze30+9bSjE5ROB2CWgKFN+J2luJSLr53Uiu6jEp7hE3br8oWyS8af0iIuEzvWu1RemzqNLMDcO6xbPp/BLcY4hFP7ca3DlpcWaZQwJrphFILSNVijaIuMsYjUFa9BV/QP6DY9G6900qoB7uwZD4jHt6+ysznfyuxNcH8h/r1uJx8gdP8wPidV0usXifdS77IjVbVwGc4YN55WS4D/IMyh7iDKR1kS+1rFwd4AdyjN7SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0ceI2WLQ4+bl+9+Kcs/sG3GiST6ud8qebUQ706NImE=;
 b=Pa83aMx+Gx+Fu8Gwi35y++C1u5enwdfidZ2OgF0xWp6/+vQTvCNhwTk2eG36wzZxa3AoP0Vd5p2gfVF1yOJ/5d20EyG+J8rs4hN0HmnQQGc43nVucUHpqrr1u1E32dw8i+oTUc6TILDuhESdAx7H0xXVK47Ig5ZMtmpNovsTSX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB3327.namprd12.prod.outlook.com (2603:10b6:208:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 16:17:33 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4888.009; Tue, 11 Jan 2022
 16:17:33 +0000
Message-ID: <bd73c50e-4a55-8943-d1d9-2b279d39e66f@amd.com>
Date: Tue, 11 Jan 2022 11:17:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] drm/amd/display: Not to call
 dpcd_set_source_specific_data during resume.
Content-Language: en-US
To: "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>,
 "Wu, Hersen" <hersenxs.wu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20220110090652.3759559-1-rajib.mahapatra@amd.com>
 <44d54537-82b6-b1aa-c9a6-8dc6b16440e0@amd.com>
 <BY5PR12MB46434EFB35BC0F88E63B30E3F2519@BY5PR12MB4643.namprd12.prod.outlook.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <BY5PR12MB46434EFB35BC0F88E63B30E3F2519@BY5PR12MB4643.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0282.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::18) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baf0320a-f8a6-4c55-7b66-08d9d51ddfab
X-MS-TrafficTypeDiagnostic: MN2PR12MB3327:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB33270FCFA238E2CD7AF4E7B78C519@MN2PR12MB3327.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30ewT4RMe8PKbl6ZEOEB+SWUQhqMD5oscDDeElhDF1/XftWix9T7th3ExnFi5xLz7l5V0TrQpffAPBmxI8LmtDpbVv/+wXysw9EsaxZyXe+jXyUv0OFB1H2wo8/tDRmnBiYjqKHf55iGYfRgn/yRSSwpGI3BHy6/Ry7Vo6Trio+BS2qyyW/DJ1VMJw+wym3C2ItbGLOAMWNbiCGhzPN/8oAPfOsL43ZQN5/XeOFBhW1cG/1mKmPqWTsTuxK3K4Qv1dt0r8Oe4RwHOneWNFVUg3WWqeFh7s5/00MFcdzDtIV2wNJqI/DwMkSl+7bOWlWgFpj+5Yg/wep4v0EIKQrbBhV5XhVrxoCjrHnMKpRlE+0JEP8THv0VW+g359eaeusShQP0BaX71siwHT9YM2kuSw9Nc27OdBTiFdVtbGEUjuJ1sxeDedyBtyZCtv1rS9z8STkaFVJxce73K2br2NFYpymnnOFUv4YtR1D3HBjEC1CVkQD/KG/iwpbhgymymLuH9SJPSSKIYdOr+JZ29vP9lGp8Cb+7N/5ifWP4r/QB+UsSjoPgD2ztYK2wiyM71cirCqHF0oFIAbKA2QcRoCTITnEUNcObXPjXWqpxPibEL0wa+Rqv2OIevWwxxglGpW5t9wtp5Dee3xOvU02HNt639Rh1ZxRZhrXCpTvri2u1CFq0z/a0ElL+0KDSrawGebcjEIZ8rZb8uiJGTwH+FzRwTZPJTAmi8lGsX1DFZgM5CJ17mQerMyrNIVzqnXsLZ3HZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(8676002)(26005)(66946007)(186003)(86362001)(31696002)(44832011)(6512007)(36756003)(31686004)(316002)(2616005)(38100700002)(6636002)(6506007)(508600001)(6666004)(6486002)(66556008)(66476007)(8936002)(2906002)(53546011)(54906003)(5660300002)(110136005)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3ZxMjBVL0JmZjh3Y01qVEJnVnd1bzJkeXJZT3c1YzdTalpBZFNCYzEzVDBV?=
 =?utf-8?B?ZWRWNERnN3dyWlErdVBZcGwzTXk3RklzY09LVEl2R29HS2wrYVpIUnBPK3o3?=
 =?utf-8?B?M3FubmFXeDdpZTJjcUVQcTZZaVNEa3YydElJZytEaEFCK3daUlRGL0xTWkxr?=
 =?utf-8?B?eG1uY0ErU3lJQ0grdnNGS3Nxc1JQck9QTEJkRWtwMHdkWHdrUFltYS9LdEVU?=
 =?utf-8?B?VnFMc0hLQUczNWVBeUNUdHByUERxQjlWVGNPTFliQVE1elV2eU1xUUp2UHo0?=
 =?utf-8?B?ZloxUEhUMGl5bXdRNS8yY3RzOU11dVdOeG9mZDlycSt4dERqTStzYmZhQkt6?=
 =?utf-8?B?WFBRaEhydy9tRnptL1Znd0NrNVJpYjJOc3ZGbjdqU2hpZ0tselJDZERoczRa?=
 =?utf-8?B?Wk81d1pIbkVGaGRMdHZncnhjVFpoT1ZoSTBsZm1RNEtJUjA4NE9hYmVOYVl3?=
 =?utf-8?B?d0pYTUsrOGdjUWNKa0dDUHBYNjNlOXlnQ2NPQ2FJclZGMTJnazNKTk9oME53?=
 =?utf-8?B?cVRuSFpMeG45NDdSTm5kR0F4czEyV2tBajJBTExFK1JTMElvcUtxdVF5VmMw?=
 =?utf-8?B?ZitUdFN1cWFGcURqK3dPbExVREt3cDdJdVF3UXh1NXBoUzRtODZXL1FyZ3I3?=
 =?utf-8?B?WFp2ZnJybmJueWh5UVJLUkpLN0xjM002S3VkcTZiMjlCMFMvU0ptcm1VK1B1?=
 =?utf-8?B?MCtYb3FhaVF3bG5oTE9rRVMxczE2TllySXE5Zzg2a2lwSGtpZDdEemJrcnRU?=
 =?utf-8?B?Z0ZmdlRoN2Y3SE5DU0ZRamVvb0tBWWM3RjljRHZUQW0vM0s0MXFtKytDb1h5?=
 =?utf-8?B?L3d6RVVWMm9VL2J6V1psU01XRXJ5SGtrYkh1RWN6bHZ5aTc3eVpNNDRmNzA4?=
 =?utf-8?B?WlZsTVptbldGRHh5L2pKR2VrRzdkbFowWU4yL241dERqandYYVdMT0xXNUtR?=
 =?utf-8?B?SGRIRFoyT29ReFRCZUJ3blJYT3ZkMVVJNjJBdUVYL0hjVHBWczVkTmZOczRR?=
 =?utf-8?B?bjNqMXVGRDNUb3B6ZlE1UVUzcktaRDBSL25Wa1NncUtPTWNvZVNpRkY1dEdJ?=
 =?utf-8?B?YUtmMGFwUDd1a2JkTFRXcDhJamM2YVBUMUhoMUV6NUd5cnZPOXFYaWJGVUZq?=
 =?utf-8?B?ZVBOUjdWMmFoWHVvVXFQVUJPSUJaWXlLSUkxQ0hidTdGc2h2THJRMHJybWxl?=
 =?utf-8?B?RlhTdzNpSmNhMjVKM2l6TXFUK0IwT09TWThmd2h5L1QwbUhrT3craUNuNDhz?=
 =?utf-8?B?YnVWbTk0eEl3Z25rTVJTZWlNZXFCcFRxaDVmVXlEK1BxQ0RoUmlsOU1pK0NG?=
 =?utf-8?B?aXRvSXgzWGFHbjYzQ25vNlpycERxWWZ3QnlYQ0M2RGVXNFpMUXBtd3M5bFAr?=
 =?utf-8?B?YkZrWVJ0MGIzSXR0eC9Kck1GSUV5TGJiRlltT3pHVm1CZGhDN3NYcDlvaWxL?=
 =?utf-8?B?ckYwWGNkVmwzNFpPR1pLakVkejRzbU9zQzNHckNhaTdRL1pIMjhJZjBncWhF?=
 =?utf-8?B?NU9FM1RxTTgxT1kzTjNQRlFhNlFZaVcrZ2g2Q1JBVEpSaS9kMlN4OWgxK1FL?=
 =?utf-8?B?Y3AxUG8rNXFyeVlIbkJDUVNpbnpFeHVhMkRoU01WMUN0V0tXd1ZkY1dNWkpw?=
 =?utf-8?B?ZUpmR1AvNzkyQmFPenlhUENnRWtUWjlYbWduY04xenQ5eEo4NmFhMXBBMFpw?=
 =?utf-8?B?YnQ3cTZYZ21sUXcvYm0xeGt4OEZMSnNraHZIR08rcjIzOHB0VDhRamJWRWVB?=
 =?utf-8?B?NXFoeG5aQkl0SU9DZXdEc3lNdm1TZm4xMjVFZUVLNVVlY1VrSUJOUW1lU01H?=
 =?utf-8?B?Zld5bnlrSUlFR291MFBaMnE5ajBkOVA5eDEvTHJsSnlLWWFtWjlnMUpncS9D?=
 =?utf-8?B?eU5ZSi9ERUFmbG5QNkRiU1FFdk9HYVpQNmVUWlhMNHB3SW5sK092YU1uY1JM?=
 =?utf-8?B?SnEvdUp4VEx5RWYzaS9MYXkvQjJnaEdNUHNsWWd3MGVOVS9FMXFHelVLdzdN?=
 =?utf-8?B?MGcva1B5RDVKei9RZWFvdVBIcTBuampiRDFka2pvMFRQWWdRUjk4allCWHUr?=
 =?utf-8?B?eGZQRmhkNThRWHppUE02QS8zV2lvcUJaNWk2T2MxR0xLUTBCT2NaQ2ZZUmhz?=
 =?utf-8?B?VjIzaDRtQUFncndDUW13cmxldGlWR09rcXhDb1BVVkRXQlV5WHZaTVBrcHdC?=
 =?utf-8?Q?wm9f4konBVCrjhsyqA5QQvI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf0320a-f8a6-4c55-7b66-08d9d51ddfab
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 16:17:33.6241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7sh63D+V2mGqWEDOEujE9Rd5G6OOf3Fv5J9c5cQiGRxsN0/GxHHqMdhvvVmQFn4aiBoNAnQaeJp4c2c8jj57Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3327
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-01-11 02:52, Mahapatra, Rajib wrote:
> dpcd_set_source_specific_data is not specific to OLED panel.  It is called from boot-up path also.
> Hersen Wu introduced it in resume-path while enabling OLED panel for Linux in below commit.
> 

If we set it in the boot-up path we'll probably want to set it on resume as well. Though I'll let Hersen comment since he knows this part much better than me.

Harry

> So here, I guard it by calling source specific data only for OLED panel, and I can get advantage of around 100ms for non-oled panel during resume. Hersen night have answer about the issue related to regression for other panels, waiting for his reply about this change.
> 
> commit 96577cf82a1331732a71199522398120c649f1cf
> Author: Hersen Wu <hersenxs.wu@amd.com>
> Date:   Tue Jan 14 15:39:07 2020 -0500
> 
>     drm/amd/display: linux enable oled panel support dc part
> 
> 
> 
> -----Original Message-----
> From: Wentland, Harry <Harry.Wentland@amd.com> 
> Sent: Monday, January 10, 2022 10:03 PM
> To: Mahapatra, Rajib <Rajib.Mahapatra@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; S, Shirish <Shirish.S@amd.com>
> Subject: Re: [PATCH] drm/amd/display: Not to call dpcd_set_source_specific_data during resume.
> 
> On 2022-01-10 04:06, Rajib Mahapatra wrote:
>> [Why]
>> During resume path, dpcd_set_source_specific_data is taking extra time 
>> when core_link_write_dpcd fails on DP_SOURCE_OUI+0x03 and 
>> DP_SOURCE_MINIMUM_HBLANK_SUPPORTED. Here,aux->transfer fails with 
>> multiple retries and consume sigficantamount time during
>> S0i3 resume.
>>
>> [How]
>> Not to call dpcd_set_source_specific_data during resume path when 
>> there is no oled panel connected and achieve faster resume during 
>> S0i3.
>>
>> Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
>> ---
>>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c 
>> b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
>> index c0bdc23702c8..04086c199dbb 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
>> @@ -892,7 +892,8 @@ static bool dc_link_detect_helper(struct dc_link *link,
>>  		(!link->dc->config.allow_edp_hotplug_detection)) &&
>>  		link->local_sink) {
>>  		// need to re-write OUI and brightness in resume case
>> -		if (link->connector_signal == SIGNAL_TYPE_EDP) {
>> +		if (link->connector_signal == SIGNAL_TYPE_EDP &&
>> +			(link->dpcd_sink_ext_caps.bits.oled == 1)) {
> 
> Is the source specific data only used by OLED panels?
> 
> Do we know that this won't lead to regressions with any features on non-OLED panels?
> 
> Harry
> 
>>  			dpcd_set_source_specific_data(link);
>>  			msleep(post_oui_delay);
>>  			dc_link_set_default_brightness_aux(link);
> 

