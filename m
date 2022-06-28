Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99375C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 14:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2430710FD66;
	Tue, 28 Jun 2022 14:53:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32FB310FD42
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 14:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUBuUDw0ajFQaGf9ZvWfEGgtq5OlqRvs5V4gSefV8iL8onydLrsVU2R9RwFuWpLAX2nf1DovZws63ockwV866Q+Yh4vIC9KNVDbBU46+OECaxa/8e7BJRnfadT6FElibSDOw0dowZrMX3QaMiacVtHfZQxcbmHOTOeWmmrSMpTOnIGrP8KS6082liRWO+o259BCC+NkpRVv7O1v+dk/9d1EoahjUNfEB+/r8N1YoB2fMZSQ9ngzmg8/DLx1bsXw/MR79tI/fwsUvbjV1crhSB7rKWOYHni6i0/W2NIRYq8MeLi0ACTxebjpab3Vx0nWgzzC2upvn0h8+Mzhpx1zxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJMtG8gJHOYOTMYvMGj4b3YwbPYiA+sOYo2tCgutf4U=;
 b=UOFIuQpxOQ5/xDt5L0un94aQki+YFkyR//QvXkH7eTpJ2DNXvTtoH2IbLXq6w7bUU/99RHU3zcsjnqymjj1dH5yDWcTKOIwcQ5+VA7sfs6FzYjOvxB9HiB8T2s0YlxquwRWAIVneFO2hkXAR7CbccfTCtOtHrUk/mrb1rHtMMnQv95gQ4UYQ/5PGP5llgDJjYNVY5rtBuvBisg/MfJhAnCkvDnOjfLd6U9IaOxzpTX5ATnGBr8q3edvOIYqELSK5BGO3VfWSKWKmYxugmRL4ZLz3kPwEI+O9gEAN2n/6JoMQOKcBXVcegccxywqnBD77CXMKeL+iB4sgYyG+xc8l1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJMtG8gJHOYOTMYvMGj4b3YwbPYiA+sOYo2tCgutf4U=;
 b=tMoB0GPKoC/qKrmz2FAbO5zJrGxpohCeOOFySA16FtNELTlHt29tGTsHT7HSp7zUUBN6sr0i6nEn6Hgepb/PKCs0jAn9zn6URquqQwIt8/aIqwXhO6Cbx0bQ+lPyX8kMz5eSisO56FnH4gDEpSDi9TqypfkFxaOqUNLxnZMb7Xk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM5PR12MB1482.namprd12.prod.outlook.com (2603:10b6:4:a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15; Tue, 28 Jun 2022 14:53:22 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::85a:3075:1744:8317]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::85a:3075:1744:8317%7]) with mapi id 15.20.5353.020; Tue, 28 Jun 2022
 14:53:22 +0000
Message-ID: <63d76489-0980-b176-6efe-57deae1f9f3e@amd.com>
Date: Tue, 28 Jun 2022 10:53:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu/display: reduce stack size in
 dml32_ModeSupportAndSystemConfigurationFull()
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220622144756.1890683-1-alexander.deucher@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220622144756.1890683-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0024.namprd06.prod.outlook.com
 (2603:10b6:208:23d::29) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30e96d99-f97c-471b-f194-08da5915f220
X-MS-TrafficTypeDiagnostic: DM5PR12MB1482:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FBBqc9ODhjMBr7sfKodbqgmaFP7+vZBtPzVlrRBsnR7tx1ahnvZgdEEtDA9SrwOIloipVuSzflR3+yFceRxI/nGbgNKmXVhrEFmX7fWU2DLUGM6b3Z2d+9Odu0xsC0YyWEetRUyNOKe8B+k4jmCXryE9S0pnj+iIgJJ+K6so7DeymOm+LzdPtqboA5o7nFSvSadByS3nODQr8IJ/fIGMxHuKj/B8CDoCPwnbLCx4kmwkQ55JVwTlhOKLmI5FaHaUO4yc2v8viT3/qf3Wy9SresSPCuKI3u7KnjwZrbHgXGemiiIY6a3cymaBxOf8X9Yi7AOW0ZxJLt2IWT+85Ve8rDQmOUAdIT1yettHjvdU130K9jhP9kaykMm2voWXV5u3ZbxU+qUv3yYYfv1inqtNA2iad5tzH5Ag+FUR5QVWgtjxytgEIKmrXkz6BfWUR3bdDFI/JuLgZ2LqsGJskTNMuk3geL6BRrLwKYgwK9bLfukdlvhz1jtQGFn3yhUwGWJT5MeCTvNd0eho7g4UFATjzgly70ZrzRQ1FngFjx2HFTLO5q/e24ygnFTib0koNNH3QdjBvhtaQKgcMvoum97wfar1gvkGMIs/08EPM1XC7+3yD1MqGP3h0kvdP48YqovJyfLTwnTLjWtHqIOTxXKJtrxB/QfYpqZ4eGgISWD/nfaVoGkMtxuW/h7bOhfYN0NvHQ8EvPVB5vAW3QFD1yWXQwu/vansjnzmmqJ/2V9WkjChJZAXOO0fsaNQQzYKrN4+zVSgEzh4zM9AfcH5nLX+1H/7hx77orrjHGup2VmqAPKeqCUcrnMJlgKbqg03mj8rE3ZGiLWxrfGunebgWEpawm0fVwixuVXa3WJ4ltbuY6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(31696002)(38100700002)(86362001)(8936002)(26005)(66476007)(5660300002)(53546011)(30864003)(6512007)(110136005)(2906002)(36756003)(2616005)(6506007)(316002)(83380400001)(6486002)(31686004)(4326008)(66556008)(186003)(8676002)(478600001)(19627235002)(41300700001)(66946007)(213903007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEJ0cDlPUk9KMFRLczZSbWNIbVNiaUpkdy9uYkV6TkV5dWFpZzg1UktsQjh6?=
 =?utf-8?B?aGRyN2N2SUR3OC9sRVQwYTBWSlpXVkVPM2tGRTFQenJDMXk2OWg3N1k1NHN2?=
 =?utf-8?B?Syt2YTBGY0cwWnFkb0JFa3ZhakxmR1VBZ1Z4UjFlR3hydmo5Wm5TaGEwM01Z?=
 =?utf-8?B?SHk0aU44Q1NwQ1dhOTdjTUVZRjg4dVZFdW5jVE5aTitwQmRGODdSV0ZQOE9Z?=
 =?utf-8?B?WVlZVmhXNWZ5N1VPVmVUdzVVa2o4UVRFN2hkK2NHcTBjWm4rM0hvYjd5SFVR?=
 =?utf-8?B?UFN0TTJNN2RvZU5jSHF2TEQ1aC83T3VpaWptNE1yOFRlcWR6ck5mUVFQaFlo?=
 =?utf-8?B?R1dhbDhBKzlHdkhjc2doZFZ5bmw3Tmh2elFGWWMwTG8yVjZQQnpDOWMxUmRN?=
 =?utf-8?B?YkZvVk5DZEpUcmNZbkRSc3V2ajAwVlQ2bnhURFJiN01rRVpESEVTMVpPVnV4?=
 =?utf-8?B?R2ZvUVhkL0xJRFMrNTFzejdXK2ZORGxycUZKWTk1NVRSbXprT25KeEtKcXcv?=
 =?utf-8?B?SHlicUo5V3Fyb2xGQVFPbmdZM1FGRjgydHhORURWWEZkY2g3Wm5xWjVPcCtq?=
 =?utf-8?B?OHE5aXpjQ2NrQVk4bDB1cUxXZ0VUdXV5YWt2NVFIeTRvcjl1N0pFUlMyZkZY?=
 =?utf-8?B?akRMRU1abTNNdFRrRVg3WEZnTkNMdUNZT0VXZ1kweTFvLytRa2s3ODNxNEhK?=
 =?utf-8?B?YkFFZUxFZWhvU0RPQXRPQzBTdzVWSWtqek9zd2p1M21uekdIc2swWHp6RXdH?=
 =?utf-8?B?TmRUYlE0aEYrcDQyelBnN2VzZWtxQTZoOUVOWkVIRStOcXJ0VDhXSmsxcTRq?=
 =?utf-8?B?a2htREIyeXpVNjM1NGU1TVQzQmFCM0prOS9iTUI3bGRNclVDdHV4Vm1qYzF1?=
 =?utf-8?B?Tm1mNWNsakMrVkd3RnltYm44ODVQUTI2N0tzVFBiUm4vZFN0aHZMSkJjTTVI?=
 =?utf-8?B?QmlWcTlINElKK1ErbVBTY2htTjZoRG9OV1BWMUFqbHVyendUVmtvbVBhWlp6?=
 =?utf-8?B?SlpDTGRhWGZKd2hueTd3NVFKMUtoR0cxU2NGNHZKajlITnZXN0p2U3ZFQzF6?=
 =?utf-8?B?ZDFuNjNMM1pXMC9hVy9Wa05US0dRNDZjTTBCd3JIV2JjNEpPSVN4TkRjV0Z3?=
 =?utf-8?B?VkRwdmYyNmRIVW0vNklRNEx4RjJ4Sk8wbjZRTC9DTFNvbWlkL0QwV0ZHSVJ1?=
 =?utf-8?B?blgzNzc0S3pkMndseWN4R1NjemhjN2w0cjY1Q3JtdDNCcDBjVDlmWDhmSG43?=
 =?utf-8?B?VlI3NVZZVStNelZjV2lRRTVjTk1hK2c4ZW9VN05iQ3dGeENFVmEzczNrQVJN?=
 =?utf-8?B?STlGbnN5VWtMd21MOVlQbGJ3dTQvVVFOc2JwbW9hZVI3TVgwUVF4d21COEdz?=
 =?utf-8?B?czdVbWUvM3dPY09TVWRoeDBvVlQ1eTNpRXNjZTRUajkyVXM2ME1ueXJmZ3Fl?=
 =?utf-8?B?UHYrZ0Z0MnNzZEFjZVhjdDFLdzl6UWpvKzlGaHZKZEx6SVhVSkthN3JMOHZL?=
 =?utf-8?B?NEQ5cjNVWElrcGxzOWMzZ2J6RWg3YUhIZUJiVThLYkpuU1NVbUdrWEpobHZu?=
 =?utf-8?B?dG0zNnNJbDhZVUx5cXFwOTNrb3FhKy9BUkdMbkRxZzIyVXVmWllDdWdURGsw?=
 =?utf-8?B?S0ZQcWdjek1uTXViaENJaHpPc3lickIyUS9TR0dKSFVmdWdWTWpTZHZhV0Zx?=
 =?utf-8?B?NXErRzlpRThJVVI5cXFXMWp0Q0tlTC90VFNaSDRvOGRlTlZ5M053YTIvN0s2?=
 =?utf-8?B?TkFnemluY0lGMk9QVVNPdlJsaG1uaUI0OXdJK3Mrb2E4cERLUW82RXA3d3E4?=
 =?utf-8?B?bnBLUVJ4bExISjNnZHdiK3NybndFU0g3bFdhZFEzdCtXZGVmdGZ5SXNJZVRV?=
 =?utf-8?B?YUdkTXRiSTBrUm1QUWVPMjYxcGV1T2VWelV2bUtzUmJWOUE5UEJNYVpWbVNa?=
 =?utf-8?B?TEkyVW9QSmY2Y2JFMGx3RkJTR0dwZXJzZ05iRXpyQjhmUnRyMWRSbFJ0OHF6?=
 =?utf-8?B?YVRPUngrZUh0N3JLMlNFS2xWRjQ0TVJ5b00ydEcrTlVtaWRzVGlSVjViOGN0?=
 =?utf-8?B?dW93a3ZUSUIyYjNYOUFCSi9nQ1FaWTMzR2srRnRlYmxkaXFUZVVWVmhGQzhw?=
 =?utf-8?Q?nT+yXsS7OylJfrpv+6TrCMQUk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e96d99-f97c-471b-f194-08da5915f220
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:53:22.0433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAvOQH64WBjqsAQlMpn2OHOD31iyINKjJoryovLIwhObMSxTFsl/+nd02SSVSRXpb6pcV21SMB0dVhtU0+DlaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1482
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
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-22 10:47, Alex Deucher wrote:
> Move more stack variable in to dummy vars structure on the heap.
> 
> Fixes stack frame size errors:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3833:1: error: the frame size of 2720 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>   3833 | } // ModeSupportAndSystemConfigurationFull
>        | ^
> 
> Fixes: dda4fb85e433 ("drm/amd/display: DML changes for DCN32/321")
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../dc/dml/dcn32/display_mode_vba_32.c        | 77 ++++++++-----------
>   .../drm/amd/display/dc/dml/display_mode_vba.h |  3 +-
>   2 files changed, 36 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> index 510b7a81ee12..7f144adb1e36 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> @@ -1660,8 +1660,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   
>   void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
>   {
> -	bool dummy_boolean[2];
> -	unsigned int dummy_integer[1];
> +	unsigned int dummy_integer[4];
>   	bool MPCCombineMethodAsNeededForPStateChangeAndVoltage;
>   	bool MPCCombineMethodAsPossible;
>   	enum odm_combine_mode dummy_odm_mode[DC__NUM_DPP__MAX];
> @@ -1973,10 +1972,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[5], /* Long            DETBufferSizeInKByte[]  */
>   			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[6], /* Long            DETBufferSizeY[]  */
>   			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[7], /* Long            DETBufferSizeC[]  */
> -			&dummy_boolean[0], /* bool           *UnboundedRequestEnabled  */
> -			&dummy_integer[0], /* Long           *CompressedBufferSizeInkByte  */
> +			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0][0], /* bool           *UnboundedRequestEnabled  */
> +			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[0][0], /* Long           *CompressedBufferSizeInkByte  */
>   			mode_lib->vba.SingleDPPViewportSizeSupportPerSurface,/* bool ViewportSizeSupportPerSurface[] */
> -			&dummy_boolean[1]); /* bool           *ViewportSizeSupport */
> +			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[1][0]); /* bool           *ViewportSizeSupport */
>   
>   	MPCCombineMethodAsNeededForPStateChangeAndVoltage = false;
>   	MPCCombineMethodAsPossible = false;
> @@ -2506,7 +2505,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   	//
>   	for (i = 0; i < (int) v->soc.num_states; ++i) {
>   		for (j = 0; j <= 1; ++j) {
> -			bool dummy_boolean_array[1][DC__NUM_DPP__MAX];
>   			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
>   				mode_lib->vba.RequiredDPPCLKThisState[k] = mode_lib->vba.RequiredDPPCLK[i][j][k];
>   				mode_lib->vba.NoOfDPPThisState[k] = mode_lib->vba.NoOfDPP[i][j][k];
> @@ -2570,7 +2568,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   					mode_lib->vba.DETBufferSizeCThisState,
>   					&mode_lib->vba.UnboundedRequestEnabledThisState,
>   					&mode_lib->vba.CompressedBufferSizeInkByteThisState,
> -					dummy_boolean_array[0],
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0],
>   					&mode_lib->vba.ViewportSizeSupport[i][j]);
>   
>   			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
> @@ -2708,9 +2706,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   			}
>   
>   			{
> -				bool dummy_boolean_array[2][DC__NUM_DPP__MAX];
> -				unsigned int dummy_integer_array[22][DC__NUM_DPP__MAX];
> -
>   				dml32_CalculateVMRowAndSwath(
>   						mode_lib->vba.NumberOfActiveSurfaces,
>   						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters,
> @@ -2733,32 +2728,32 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   						/* Output */
>   						mode_lib->vba.PTEBufferSizeNotExceededPerState,
>   						mode_lib->vba.DCCMetaBufferSizeNotExceededPerState,
> -						dummy_integer_array[0],
> -						dummy_integer_array[1],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[0],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[1],
>   						mode_lib->vba.dpte_row_height,
>   						mode_lib->vba.dpte_row_height_chroma,
> -						dummy_integer_array[2],
> -						dummy_integer_array[3],
> -						dummy_integer_array[4],
> -						dummy_integer_array[5],
> -						dummy_integer_array[6],
> -						dummy_integer_array[7],
> -						dummy_integer_array[8],
> -						dummy_integer_array[9],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[2],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[3],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[4],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[5],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[6],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[7],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[8],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[9],
>   						mode_lib->vba.meta_row_height,
>   						mode_lib->vba.meta_row_height_chroma,
> -						dummy_integer_array[10],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[10],
>   						mode_lib->vba.dpte_group_bytes,
> -						dummy_integer_array[11],
> -						dummy_integer_array[12],
> -						dummy_integer_array[13],
> -						dummy_integer_array[14],
> -						dummy_integer_array[15],
> -						dummy_integer_array[16],
> -						dummy_integer_array[17],
> -						dummy_integer_array[18],
> -						dummy_integer_array[19],
> -						dummy_integer_array[20],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[11],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[12],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[13],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[14],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[15],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[16],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[17],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[18],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[19],
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[20],
>   						mode_lib->vba.PrefetchLinesYThisState,
>   						mode_lib->vba.PrefetchLinesCThisState,
>   						mode_lib->vba.PrefillY,
> @@ -2772,9 +2767,9 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   						mode_lib->vba.MetaRowBytesThisState,
>   						mode_lib->vba.use_one_row_for_frame_this_state,
>   						mode_lib->vba.use_one_row_for_frame_flip_this_state,
> -						dummy_boolean_array[0], // Boolean UsesMALLForStaticScreen[]
> -						dummy_boolean_array[1], // Boolean PTE_BUFFER_MODE[]
> -						dummy_integer_array[21]); // Long BIGK_FRAGMENT_SIZE[]
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0], // Boolean UsesMALLForStaticScreen[]
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[1], // Boolean PTE_BUFFER_MODE[]
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[21]); // Long BIGK_FRAGMENT_SIZE[]
>   			}
>   
>   			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
> @@ -3197,7 +3192,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   
>   				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
>   					DmlPipe myPipe;
> -					unsigned int dummy_integer;
>   
>   					mode_lib->vba.TWait = dml32_CalculateTWait(
>   							mode_lib->vba.PrefetchModePerState[i][j],
> @@ -3294,7 +3288,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0],         // double *Tdmdl_vm
>   							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[1],         // double *Tdmdl
>   							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[2],         // double *TSetup
> -							&dummy_integer,         							    // unsigned int   *VUpdateOffsetPix
> +							&dummy_integer[0],         							    // unsigned int   *VUpdateOffsetPix
>   							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[3],         // unsigned int   *VUpdateWidthPix
>   							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[4]);        // unsigned int   *VReadyOffsetPix
>   				}
> @@ -3323,7 +3317,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   				}
>   
>   				{
> -					double dummy_single[2];
>   					dml32_CalculatePrefetchBandwithSupport(
>   							mode_lib->vba.NumberOfActiveSurfaces,
>   							mode_lib->vba.ReturnBWPerState[i][j],
> @@ -3346,8 +3339,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   							mode_lib->vba.UrgentBurstFactorCursorPre,
>   
>   							/* output */
> -							&dummy_single[0],   // Single  *PrefetchBandwidth
> -							&dummy_single[1],   // Single  *FractionOfUrgentBandwidth
> +							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0],   // Single  *PrefetchBandwidth
> +							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[1],   // Single  *FractionOfUrgentBandwidth
>   							&mode_lib->vba.PrefetchSupported[i][j]);
>   				}
>   
> @@ -3457,7 +3450,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   					}
>   
>   					{
> -						double dummy_single[2];
>   						dml32_CalculateImmediateFlipBandwithSupport(mode_lib->vba.NumberOfActiveSurfaces,
>   								mode_lib->vba.ReturnBWPerState[i][j],
>   								mode_lib->vba.ImmediateFlipRequirement,
> @@ -3480,8 +3472,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   								mode_lib->vba.UrgentBurstFactorCursorPre,
>   
>   								/* output */
> -								&dummy_single[0], //  Single  *TotalBandwidth
> -								&dummy_single[1], //  Single  *FractionOfUrgentBandwidth
> +								&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0], //  Single  *TotalBandwidth
> +								&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[1], //  Single  *FractionOfUrgentBandwidth
>   								&mode_lib->vba.ImmediateFlipSupportedForState[i][j]); // Boolean *ImmediateFlipBandwidthSupport
>   					}
>   
> @@ -3534,7 +3526,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.SMNLatency = mode_lib->vba.SMNLatency;
>   
>   			{
> -				unsigned int dummy_integer[4];
>   				dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
>   						mode_lib->vba.USRRetrainingRequiredFinal,
>   						mode_lib->vba.UsesMALLForPStateChange,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> index 9ad49ad38814..10ff536ef2a4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> @@ -196,7 +196,7 @@ struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCal
>   };
>   
>   struct dml32_ModeSupportAndSystemConfigurationFull {
> -	unsigned int dummy_integer_array[8][DC__NUM_DPP__MAX];
> +	unsigned int dummy_integer_array[22][DC__NUM_DPP__MAX];
>   	double dummy_double_array[2][DC__NUM_DPP__MAX];
>   	DmlPipe SurfParameters[DC__NUM_DPP__MAX];
>   	double dummy_single[5];
> @@ -207,6 +207,7 @@ struct dml32_ModeSupportAndSystemConfigurationFull {
>   	double DSTYAfterScaler[DC__NUM_DPP__MAX];
>   	double DSTXAfterScaler[DC__NUM_DPP__MAX];
>   	double MaxTotalVActiveRDBandwidth;
> +	bool dummy_boolean_array[2][DC__NUM_DPP__MAX];
>   };
>   
>   struct dummy_vars {


Hi Alex/Stephan,

I applied this patch, ran a basic set of validation and ran a couple of 
IGT tests, and everything looks fine; with that, feel free to add my 
reviewed-by and merge it:

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

However, I still do not understand why I cannot see this issue on my 
side. I'm using Clang 14.0.5, enabling DCN in the config file, but I'm 
never able to see it.

Thanks.
Siqueira

