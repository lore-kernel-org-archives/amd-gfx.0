Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34A4C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 15:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 391FC10E084;
	Thu, 29 Sep 2022 15:21:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF73F10E084
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 15:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oB4hz7TRzIgpM+Qg7VwQIiFPrkmt/aCJeDnNXS9tTml8wFEW8BVzdA7vl8CryhLmMGQKkRvSpsQG/D4IA7ZECWJ7u63LDW/yO9nmbZrQ3xvH2DYivkJalONVv6PTV2u6q1u4OMFPwJyxghZh7DH0nN7ExlE2HvXKzFKLO0dml5FOqrvBtIIlSsPDpYPsEFRsGPCAL8AYVKw06NGK3hPEY9VKqdqUTu1T0ZTNtu35LeOoUDs579iQeeb5sN1FVxWW+phdKjAZIOT6WMQh3GXMo0JndgWsuotajeWC49MdrW4Ug32cGGlOcCzIcDZCOAfLjHZu/yMwJou+6DiP7ISdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dA9P6wzhlQzd9J3oVmkvno8h3uF3oolSON1SCcCQzh0=;
 b=LjaIEiH7re0z+cKij3qeTC/aOEyAahSPPk1Tm1MA0akw6/I2YM1/+NitJ3t/D0sEU5jJO6HFHSpkWU82060w596bBUeFTltxG8ZGOM/+VtFLksgrDA6zxX5OVxn1F3su7fF9hY3VUqFhZNR38E5UkXj8+rPhxHuFKhPp3R1ZLWSh9fa7kdHmPHf+FT7Qp55CkX6MJx9TYLSAMIs4FNPA3LrtsxfjBCnhaEtGrO2dJdGSvEAvE1ZOr7xyIzuIT1czd5q6bmCfAHQ3bPcM9WMKU9sgCjZPuzXI4KebTGgCed974GsoNfBNklCjXwuPlmNlYbTJ8cDwtI9yGDx11zx3fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dA9P6wzhlQzd9J3oVmkvno8h3uF3oolSON1SCcCQzh0=;
 b=WSJL0CPK9d4CVbV4J8Ds4FEnwyI404/Ed48aU6HZEefAaJPz3O8qcdwpdbluYivSsEX4VPs0RNuFbT1sXgOEsYVML/P5e5hkzwIRlebQet5B9cm8mUs94euVbqjbZxHyRqYjmDN2v5zy2eLN4WeUFyjn4Fbu0fSG8IgIJxq6PTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 15:21:25 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9033:772f:1339:75f6]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9033:772f:1339:75f6%4]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 15:21:25 +0000
Message-ID: <12b0eba2-b4be-9cab-6ec0-fc604392e904@amd.com>
Date: Thu, 29 Sep 2022 11:21:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH v2 0/9] Enable 3D LUT to AMD display drivers
Content-Language: en-US
To: Melissa Wen <mwen@igalia.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, alex.hung@amd.com,
 sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com
References: <20220906164628.2361811-1-mwen@igalia.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220906164628.2361811-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:610:33::24) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c9c87e-06eb-42bb-fc75-08daa22e45dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VWWjeQatbqbVACae+MKrlzWmQDnMgONa2DAQMGG1JH4+xNBewTJcn0X694b3IS4WYDXuIVLR/Ozi+sSTrgf3ZHzcPJs1JiIqYw38dC3jJaLzrGNILZNLhDP99RwYlJ95kyAZ5DJDdsriRji8QOR5ApArZa/v2FWlanNtvBianJZSeCu8VqwBW5Zc+eY++8D0vhIoywYodJeSZBmCJ9KMcGJQdLk/g++JqfnDAYoblz5ew0OXmda/S8PUY8PsmLWFrOgc3uX/P+M3qOkcbRvv71oJZVihuA3P7epW0+XalCNItkF8ZH4IzaUvs406XV0yjedItVAyK3rkoLN5EIWO1AlfhlF8vDolWXzMgvq3VK03Jgq2lGGYNg87X0JnW3KJ76O1b+iK2JOTk+UCJSIlOMPcEH9D0Qlq2+QJUGdIgG4xAygT9OTk2815dH+m3uE/8Jqsto4wB+V5c1JZaikGt5Ee9qCdiz65x3elQPQSQQHqhZ4SMkYYoeKJ7bV7WcGfWSXhyt1FtpLdftFexxWBKGeCu9Ob7u5dIg5iDsbv+QOd2BgtYGP9aLDR46UL56om+fWkRz3alMXK8XRwkRFORQcpLtkvHJd22ZTRWPYZpD57chTaOG3s8jKsbmZXe6co0Qt+2M6xMvujJMHfJcyG/2wvJfoxl6wcCx+dDRdOcaE8I57+2LFiw4Ht2msgBceRSJ7JEOUZfvWnvSJwdyruY0vXgM4BfoIxVbB4syVXB/ANwdEul64idtcjdz4KZpgVNs2qhthAgPXFLz35ldddtwCn2KKrnLnaXib4PGhOJDdprdAsHoNPPN4qpYbtTIIB/yGWv0FNi4EdpVTiBTCEAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199015)(8676002)(36756003)(4326008)(66476007)(186003)(2616005)(6506007)(31696002)(6666004)(316002)(6636002)(86362001)(66946007)(53546011)(6512007)(26005)(2906002)(478600001)(38100700002)(66556008)(8936002)(31686004)(44832011)(966005)(83380400001)(41300700001)(5660300002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWVhd2tyMEZ1TXhScTJGWjFTS1M5OVF4d0JTNHdjbk1wRkZhOGxpdWpnYktq?=
 =?utf-8?B?UUpSTkpic0l3VFprZi8rR2VnZVdxdTRKOTBUaC9HeW5QeXdIY1p6UlRHV3Vp?=
 =?utf-8?B?OTl3WHJNcXcwclgxZG1UcXZIeGFrOWdwczU0N21jemNaZ29ERGd6UTVTNEha?=
 =?utf-8?B?MUduMk1PSmNIS3RyZjMvR3RiQnh0Yng2VkxCdEN4QkNXeFVGVllQeDJCRXhB?=
 =?utf-8?B?S0FRblBRUVpNUWU1K1hHTTREUko5aVdCRUNXSU9DbnJ6MGdTL2NtYTV6Z1BR?=
 =?utf-8?B?QjNPZnBJWUYvTUt3ZXRiYm9CNFJmU3RpUmFyWmxyM1JYS25kbTI2cmhlT0Mz?=
 =?utf-8?B?NEJ6WDFodFZIdmhSbmtDSW0xOGxPMHZhUy9HbWlEMEJoOVd4QkZDSlZodGpL?=
 =?utf-8?B?RGpYd3BCSUNjUkFoOUhDaTdBTDk4TCs0Um9mM3JJRXFzTUJKVWlYbFkwbFd4?=
 =?utf-8?B?Rk45MDg3d212Q3VTS0RnSTlsQVhPTlJsLzhGU2ZDeTdmZ3M1S1VnUWpvdHJm?=
 =?utf-8?B?c0hzbkpWRUJaeFB1WWdrRU45NGFlTTlhSnhJSXZ0TEFTM0h0cjVnQml1T2Zy?=
 =?utf-8?B?bVRTWlUvekVsN3VoVisxemNic0htQmRTajFWVVVET2NrSDV4NEh6aGI2TEZ2?=
 =?utf-8?B?VlR2czk3c3pIbnRSWkZ1Y216YmI2RWVsMFJLQXhkUCtsd3N5cmUxKzRkWC9F?=
 =?utf-8?B?WDVWNjdCQlFaaGhMcjV1clRpVWdNekFnbDdMUy93bUJ2RzdNWG51d1cyWGN5?=
 =?utf-8?B?OWFhRk02ZGtNa3lJVUpnL0E3emlYZitmRkFVTmJ0eXg4dUpzbHg1MlpiRHlO?=
 =?utf-8?B?L0ZUWUZ2cDBjYjFoalg0WkRVK1Z1MnU1T2VKeEZJdDRWYlJvUUxWSkJnZmQ2?=
 =?utf-8?B?RXVHWTdhUXIySGN5YjhkK3pvNWZGZWZMZyszOGhxVjhjMGFHK2dFakptSlVh?=
 =?utf-8?B?UEdNcGlFQTdJL0t4TTR1S2p3VHlVTjZWcnNIRFAwUjdGRmRzY3BaNFkvWFo3?=
 =?utf-8?B?UVM3VjVUWkZvd0pNNFd2eXRHM3pDUWZ6eWNON2xZUGlmc3BKVnExYTQrdUZB?=
 =?utf-8?B?ZWIzbThWaUNQNnl5QTN5K1hDWTlBQ3NSalYyNHVHbzI2MmFRQlFrSU1TMWZn?=
 =?utf-8?B?bjVlM082RmlOMStQaDdMMUkxTldhc2NWdjI3ODNScFkybURFc0tBRFgydmkv?=
 =?utf-8?B?d0ZLUVczS21HVDlFKzFRUWtPYnZyQXJGa3Z0dHg2eFpHcWVEZHdrUVZzZ3Vs?=
 =?utf-8?B?MUNnMzM4SDFJNDdDME1DQ0I0UGg4RXA2Z2c5KzIrTHZ2SDNreTBlRE1GNXND?=
 =?utf-8?B?NDBNb1lESWVhakd4Wm1tRjRuaG9iUXRvWTAydUtXdDEvK3o0TzRnMTR6MlBi?=
 =?utf-8?B?OTljUlZmNy9wSkFLczhUYmk0SzZ6dkVEWVJuRXFzYXZTSGU3Y0dGVnpGWC95?=
 =?utf-8?B?cEg2bW03dElneDdVZzNIRXhJWFhVRGc3WmplZjVQRjVSMWlLcEJsYXJvVWVx?=
 =?utf-8?B?ell1ZzZIZlJQSUFMOCtqcmhreXBvT1poalExRnV6U2JQNWZLZkJ4MVFyNVA2?=
 =?utf-8?B?WDg3cDI5T0FDZ0hVTXhuN0EzejVMT0h2QnViYitRbE16V1JjM1FkR3RtdFpi?=
 =?utf-8?B?MUNReWV2OVVVWVhUQjNTWXU1a01DMHNwMnpUMlE1emluc2VQK3pEMDRCUWVK?=
 =?utf-8?B?OFFobFVGUHNWekUwaW9pNmNjS3lUMGZmNU9FR0JDaXM5TTdpN2ZDT3J6andC?=
 =?utf-8?B?MHowR1pGZEh1azJTSk55UkV1WlFrcklTK0tvdFFWdUhGdk9vY2R4di9vc1d2?=
 =?utf-8?B?STZOWEZPTUlUb2o1dzQ2a3ptZk9ranNVRjEvZk00UnQ3WEVUUCtORnVxU3R4?=
 =?utf-8?B?eHF3azZQbmZBS2NsNmNCL1d5OXFrYWdMODYzV0t6Q2UzNEVaOFI0Ung2eElZ?=
 =?utf-8?B?Q2tnTWJ4cFhiU1ZvSkhyYUxiY1k0eVpQYnd2eDRGVjh3S0ZqejJrY2RwbFQ4?=
 =?utf-8?B?SUl6ZjFmdmRldmFsUFhUSmdhRmYrM1dvOTBlWVFpZTdHbUZJU01SZmVaUUpT?=
 =?utf-8?B?WUdXendMM2FMZ0tIUmF1dk1UTk4vaGJYeFV2OFJXQTNZNkhuMDQwVDlJdWRl?=
 =?utf-8?Q?EhLtIr129HEf8GR6RbJ7A9KMk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c9c87e-06eb-42bb-fc75-08daa22e45dd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 15:21:25.2748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceDwjo4pb63+f8xxJozdX26siXGgi74jk6hDOVe0Stwww4EPd178dE0DisCJxdT/Wj8mE9oIShNsGnooCxFAQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
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
Cc: amd-gfx@lists.freedesktop.org, nikola.cornij@amd.com, kernel-dev@igalia.com,
 bhawanpreet.lakha@amd.com, nicholas.kazlauskas@amd.com, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-09-06 12:46, Melissa Wen wrote:
> Hi,
> 
> From all feedback at [3DLUT_RFC] and an extensive AMD driver
> examination, here I am back with a first attempt to wire up a user 3D
> LUT (post-blending) to DC interface via DM CRTC color mgmt :)
> 
> I'm following some specific approaches to handle user shaper LUT and
> user 3D LUT that I would like to validate if the path taken is correct.
> 
> I used a modified version [igt_tests] of Ville's IGT 3D LUT test to
> verify that the shaper and 3D LUT programming is happening. However, I
> still have doubts about hw behavior and DC MPC's current implementation
> for 3D LUT.
> 
> Despite some initial patches for code cleanup and DRM interface, my
> focus here is the inclusion of a user 3D LUT in the Display Manager,
> which is done in the last five patches of this series:
> 
> - drm/amd/display: enable DRM shaper and 3D LUT properties
> - drm/amd/display: update lut3d and shaper lut to stream
> - drm/amd/display: add user shaper LUT support to amdgpu_dm color pipeline
> - drm/amd/display: add user 3D LUT support to the amdgpu_dm color pipeline
> - drm/amd/display: encapsulate atomic regamma operation
> 
> Things to take into account:
> 
> - 3D LUT (and shaper LUT) is only available in the atomic pipeline (I
>   didn't work on any implicit conversions that are done in the legacy
>   path)
> 
> - Therefore, I'm not doing any implicit conversions for shaper LUT
>   considering the input space, which means: it's set or not. When there
>   is no shaper LUT, it's set to BYPASS, but unfortunately, it seems that
>   the BYPASS mode for shaper LUT is not supported in the current DC
>   dcn30_set_mpc_shaper_3dlut(), since it returns false when
>   mpc3_program_shaper returns false (no params). Is the combination of a
>   user 3D LUT with a bypassed shaper LUT accepted by the hw?
> 

AFAIK this should be supported. The current DC code is centered on
use-cases for other OSes but I'm not sure this is the key issue here,
though it might explain why things won't always look as expected.

mpc3_program_shaper will program the shaper LUT to bypass when params
are NULL. It will return false so dcn30_set_output_transfer_func knows
no shaper LUT is set. The reason behind this is that shaper LUT and output
gamma tend to work in tandem.

If you have linear content incoming and want linear content on the output
side of the 3DLUT you'll need to program both shaper LUT and output gamma
LUTs with EOTF^-1 and EOTF respectively.

(Btw, please watch my HDR presentation at XDC or look through the slides,
as I'll show why the current DRM LUTs can't represent EOTF^-1 functions.)

In your case I don't expect you're operating on linear content. Your content
will already be in sRGB, so shaper LUT and output gamma should really be
both in bypass mode. You might need to debug dcn30_set_output_transfer_func
to make sure it's doing what you're expecting (and add new logic if needed).

> - I also see in dcn30_set_mpc_shaper_3dlut() that some bits need to be
>   set in lut3d_func to have the 3D LUT programmed on the MPC block. In
>   this sense, I used the dc_acquire_release_mpc_3dlut() function to get
>   the lut3d_func from the resource pool, but I'm not sure if the timing to
>   acquire and release the lut3d_func from the resource pool is correct
>   (and if I can really use it directly or I should make a copy).
> 

There are a limited number of MPC 3DLUT blocks (shaper + 3DLUT) available.
Acquiring and releasing them in DM is the right way to go about this.

Unfortunately dc_acquire_release_mpc_3dlut can fail. For this reason we
should run it in atomic_check. Unfortunately this function operates on
the current state, which makes it unsuitable for atomic_check.

We need a new function that does what dc_acquire_release_mpc_3dlut does
but takes a dm_state->context as parameter and operates on that instead.
Once we have that you can call that in dm_update_crtc_state to acquire
or release the 3DLUT on a CRTC as needed.

> - Still, on this topic, I use for lut3d the same bit.out_tf to update
>   the stream in the commit_tail because it triggers
>   .set_output_transfer_func that is in charge of setting both OGAM and 3D
>   LUT on MPC. There is a chance I got it wrong here, so I appreciate any
>   input on this topic.
> 

This looks correct to me.

> - Finally, in set_output_transfer_func, AFAIU, even if a user OGAM is
>   set, it won't be programmed if the shaper LUT and 3D LUT programming
>   are successful. However, if shaper/3DLUT programming fails, OGAM can be
>   considered. Should DM only accept DRM regamma if no DRM 3D LUT is
>   passed, or allowing the programming of both is still desirable?
> 

I don't know why we skip the OGAM programming when shaper + 3DLUT are
set. This doesn't make sense to me. As described above, the thing with
the shaper LUT is that you might need to sandwich the 3DLUT with two
1DLUTs, one being the shaper, the other the OGAM. Obviously it depends on
your intended transformations on which of these you want to program but
in general I would expect we still need the ability to set OGAM when
the 3DLUT is programmed.

> Regarding the other patches:
> 
> - drm/drm_color_mgmt: add 3D LUT to color mgmt properties
> - drm/drm_color_mgmt: add shaper LUT to color mgmt properties
> 
> Here, an initial DRM 3D LUT interface is exposed to enable the entire
> kernel path and is only available for the atomic pipeline. So far, it
> only includes the LUT data and its size, but improvements on this
> interface may also add stride and bit depth [VA_API].
> Additionally, I'm aware of the current work on exposing a color pipeline
> API [KMS_pipe_API].
> 

Alex Hung will send an RFC on a pre-blending 3DLUT. Similar to your patchset
it's not fully where we need it to be but he has a good definition of what
I think we'll need to describe a 3DLUT accurately. His proposal is missing
the shaper LUT, though, and I really value how your patchset is figuring out
how to combine the shaper LUT with the 3DLUT.

Thanks for your work on this and I hope we can chat more at XDC next week.

Harry

> I'm including some minor changes in this series that I made to better
> understand the current DM color mgmt behavior:
> 
> - drm/amd/display: add comments to describe DM crtc color mgmt behavior
> - drm/amd/display: remove unused regamma condition
> 
> ...but, there are other code cleanup patches that I'm not including in
> this series to avoid unnecessary noise.
> 
> You can check the entire work here:
> https://gitlab.freedesktop.org/mwen/linux-amd/-/commits/drm_lut3d
> 
> [igt_tests] IGT exploratory tests here:
> https://gitlab.freedesktop.org/mwen/igt-gpu-tools/-/commits/kms_color_3dlut
> 
> [3DLUT_RFC] https://lore.kernel.org/amd-gfx/20220619223104.667413-1-mwen@igalia.com/
> [VA_API] http://intel.github.io/libva/structVAProcFilterParameterBuffer3DLUT.html
> [KMS_pipe_API] https://gitlab.freedesktop.org/pq/color-and-hdr/-/issues/11
> 
> Let me know your thoughts.
> 
> Thanks in advance,
> 
> Melissa
> 
> Melissa Wen (9):
>   drm/amd/display: remove unused regamma condition
>   drm/amd/display: add comments to describe DM crtc color mgmt behavior
>   drm/drm_color_mgmt: add shaper LUT to color mgmt properties
>   drm/drm_color_mgmt: add 3D LUT to color mgmt properties
>   drm/amd/display: encapsulate atomic regamma operation
>   drm/amd/display: add user 3D LUT support to the amdgpu_dm color
>     pipeline
>   drm/amd/display: add user shaper LUT support to amdgpu_dm color
>     pipeline
>   drm/amd/display: update lut3d and shaper lut to stream
>   drm/amd/display: enable DRM shaper and 3D LUT properties
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   5 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 297 ++++++++++++++++--
>  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   6 +
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |  10 +-
>  .../gpu/drm/amd/display/dc/core/dc_stream.c   |  13 +
>  drivers/gpu/drm/drm_atomic_state_helper.c     |   7 +
>  drivers/gpu/drm/drm_atomic_uapi.c             |  20 ++
>  drivers/gpu/drm/drm_color_mgmt.c              |  89 +++++-
>  drivers/gpu/drm/drm_fb_helper.c               |   5 +
>  drivers/gpu/drm/drm_mode_config.c             |  28 ++
>  include/drm/drm_color_mgmt.h                  |   4 +
>  include/drm/drm_crtc.h                        |  24 +-
>  include/drm/drm_mode_config.h                 |  25 ++
>  14 files changed, 495 insertions(+), 44 deletions(-)
> 

