Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAC6C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 20:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7FD710E421;
	Wed,  9 Mar 2022 20:31:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E145110E421
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 20:31:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BY6lPX9sJ3974HTqMR78TOh3dDzSgP4EeXxy92oVHLUvGuYDgrGYsUgfDCSMlawLx337k9sTsFz1wPXhsbkpPCVXbCfqFSAgcERe1T0ihWSfVdH/a9fYGnSgaTkPzicNypCjso43FR9veJ6kgU39c25AFJWdTFxvFbMqV8SOxxl8sWYKuklA07NswyY8LpCLmeBqh1qa7eTnxJ2+dsowDrzKVuewWbQ0Mu42dwJf4JGPe0wL0MhFCe92VH1h7zxHsrb32OXuAO4nGVI9g2YBeKAds09nzEJaWe7w7MzECb7nF5iQyTxq/wraKZyL5tf/eRZvNl7MODp8imLQ2l2WQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu/koW0jN5BwUraex4OaByPoBGi6VhMlKbNHvKn63Rw=;
 b=Uz8zY52Qd25wj8lHCMTs6xbzk6vZgZsDV2s72ZD9sczlx78RFdmy/Td6oRj32qWVWT8iQCrxcpwEJJ9ND6b49Mwf8Ccokb0bhZM1ArzyPR1mBw8Xz3Tt4+1Q2LyPKH37r13hPWttPiXRETg5CNU31WRIgQajElAGF3T+8SRyGUcigG5lhw28r1AdME6GOqSS2fJ+DbYlqz0cxheMHSC/2Q1AD2qgMS//l/0xLT6tOB8gAQ8lYGy0hPPMCGmEKbzP8vC211OLQvyhjESLpFIEIYUWJpMlU4gABGz+JNQJhkMHoz24Agie7zGKB/ICoVp1pTkD7tyMzt6Fy8NrWgVVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu/koW0jN5BwUraex4OaByPoBGi6VhMlKbNHvKn63Rw=;
 b=biIeTebGnvQVkmBTTC62J5K0jCaQo2rcHXYAQe/N8r+fk4K15h+E8dyaMWSACN5T+UONUteBmE/Lnv5KfOzYph4vjjYxWhRyXyPdIwhpSlx0wNrKN4pmjOl4FfHfe5jj/kI2JRe/FO/Z7yJ5wo+unZPYKyN0vdUwih7baxi2Gsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MWHPR12MB1647.namprd12.prod.outlook.com (2603:10b6:301:c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 20:31:05 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 20:31:05 +0000
Message-ID: <6ec536dc-a5d1-85c0-e485-6b489290afd1@amd.com>
Date: Wed, 9 Mar 2022 15:31:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/amd/display: Add pstate verification and recovery for
 DCN31
Content-Language: en-US
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220309191944.46377-1-nicholas.kazlauskas@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220309191944.46377-1-nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::9) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50c2febd-2b58-43bc-4130-08da020bbc3c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1647:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1647AF4A098C60C1AADD49C68C0A9@MWHPR12MB1647.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFiLOzxSfzKgJ41aAxS3EzJlrSZENeqB86lUEN6QQIe1yu40DMbo+whLGmW0kdYtWp17et4OQyepwBp17myrlHS2uFgF7DMThSMXWN57DUnPmUQzxGZnWQg0h96KgqkRf//Fu04YuGWN4Jgb5UfhLdrlCZOkvS8TYPPRd/mDHiTm9re2T99iVARjukgsXIlCOg6ngmvNDIyN/G8UZlovdZDU0fUcssj2//inc5zlBqAJYe7Lpk8U4zOkkQw+wCIhqB1AWTc8xBBvRJRKRzozF2c8gjy6gzkIXo73FF02fFtgomlR+nOmpgb26PYocKZxMtKb4QhDVCQwbT36jP8DGtklBvplBWgsAtAFVuaMUJnJr0ZCPWNtVBQtwbc+iRYu3s/rb7DQo4InIWtamcfIriZl8OZieC3UB26Y8NoRr8FQLF5R04wAdkzsNrCUDB0esNeLuhRZY6fEXnbmHU+l25t1sZWbXYQK/gCxhUfNPFIHg7dKr9v1Dk27BujJu4hsiyq9x2Sgk11xxsVeuH2EEdcG1L2r0D6ALRZvbTEM58Gi+aROxsznCFWChp+AYXS6oLI6vKPtYk5bM24pHLY3nPVa8MloRysWQCVMR+PWsVI6eMNhvB3sw/jjGIqsUbJik/1iW34P1cfqCpVCfGkNIPdGhpH74gTrAWIJ+qUjg1EfAjENORz/t+CIVNPJeukXoZAxTQbk6jNFMATaeB1fXGyrqxi1wCcclE67LcDPWjS88gdmuwwdkAB1UprjkWGo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(6666004)(6512007)(86362001)(2906002)(6486002)(36756003)(66476007)(5660300002)(38100700002)(53546011)(44832011)(8936002)(15650500001)(66556008)(2616005)(31686004)(66946007)(8676002)(4326008)(508600001)(83380400001)(31696002)(316002)(26005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1BQUWxkTlovU0J1NTlPcThwMmNDT2VZaFAxVnNSV2NLN2o1dU5rY0lFRy9j?=
 =?utf-8?B?VktQdVpVOXhEajc2VjA0dmRMTjZURWR6blFYdDE1YWF1dUpKZHdpd1pBN0dI?=
 =?utf-8?B?TWRDUGJFZEpRTzJ3N3RhUEtINVRWUWtmcWNzS21FTXNFK2pieHpNOCtZN3Jz?=
 =?utf-8?B?ODVuQXVTZEV2UFEyQlI4eTBxQzlMQ2g5a1dqM29LK2dOdEswNXN2dnRWWlJD?=
 =?utf-8?B?MUtZTW9DWlB0eng5TWtNVDlmNnZ3RGk1b0E1bGRhajZrbmpwai91Z3k5WEty?=
 =?utf-8?B?S1QxS1N0elg0TDNFTVYveTdRU3FnYmwrMTVZOGs2WGtsYmhSV0xTS21zMDdr?=
 =?utf-8?B?UjVQaGtnYUhwZzdHOEJFU091WEI0Z1BkZVFsMXZrRVBWR1c2WUZyR053bXcz?=
 =?utf-8?B?S1JqTTFxd1dxUVFQNUpVNTVZYVNMUXltRkk3REFHT0pZR0FNSllaS1Bab0dR?=
 =?utf-8?B?L29pejIrODRBZ3AreGtvV0p5dFRkbkZVWU9WV3kxV2lOMWwwQmQzUmlPUmpM?=
 =?utf-8?B?QjQ5bEZHVDZvMjhUSVhkTm1FcUFmbS8rVHRFd2NXaEtPSHY4T2hpVjh1dFc0?=
 =?utf-8?B?enVneEhYYTZCWTdza00zOVFNd3k5YXdPQXBNQkw2UmZxUVRpSnFNeDZpYWlP?=
 =?utf-8?B?WU5oYzRMTWJGbUpUaVRmSXNneEtMQmhnbWd1T0VUZC9YbEpMdVJWRGdBcnZw?=
 =?utf-8?B?YklTRHhBWHBjN0lreWJCYkJHbnhFYStlK2VaWjltMkdXcGEvcEkxNTNaamVy?=
 =?utf-8?B?Z2VoZ2ttVkloay8wMmQ0enEwdVZVbDN2Mmh1NWJPOW1QelJsUm0wTUhNLzc2?=
 =?utf-8?B?bE1yZ1FhWHdSVGk3Wm9LY1lrMzVCYXBTNndRL25laGJFSjJXTEUwMGtidXdL?=
 =?utf-8?B?OXF4MjdydklnR0E2WUtnWlUxSVJhQkx3OU1CK28xV2dNMkowVjJMb0R2MXNH?=
 =?utf-8?B?ZmhVL3h2VTFWdkdHNUlHSWRNOXpEMTM2NGZaNXY0cUkrV1AzSXM1cDB0S1pt?=
 =?utf-8?B?eXFnSzQ4WURZZ2M0M29WWkxybUtoMTducFFyY3dIN3lQeHlMZ0l1SUFBZG1t?=
 =?utf-8?B?TURRdmNySXoxT2luY2JXODRRMDhlaVpaa0tSV1JiWnIyN0dwZ25BaFNYRnlG?=
 =?utf-8?B?b3VjZmZqeVdldityS1Fmc3VuUUVuRFliVXlEd0twbExWY0I1dWdtaEZ4RjVo?=
 =?utf-8?B?b21UTFBlb2l5VDN2V256UTNnWGkvNGh3U2x1Vk9vYUhqWkVEcEZZajFDMFJY?=
 =?utf-8?B?YVdMdEp2SjRmWHUySkFjWVBxSEVkVmRyREhDWUlITmlqOWxoQnNPYWNOMEh6?=
 =?utf-8?B?UkdkV2ZoZmtScnZMOU1ucWRxcVJ3am9tM3ZYQ1R3OWlNSmc2ZzJPNElFMHRG?=
 =?utf-8?B?ZGVQZjVzMkpWcm9KN3ZHM0x6SFVDditxQjM0WGoyL2RCU29WQm9nR2hjRFpu?=
 =?utf-8?B?YUdzREhqeEdTU21BU21oSVcyQTBYRXBSN2FtcXE0V29xbk1FcWJrUUdjWjlG?=
 =?utf-8?B?YWVLbmR0VVZicHZQODB5eCtBS2dlOFpuV0JYZ0h6K1hhLzQ0YVNUdVhFaVVx?=
 =?utf-8?B?Rkd1bGdESVBSQWlKaGZuTWFNRmdkUGhwWkVXMForMlM2WklKVk8wTEVNZEZ4?=
 =?utf-8?B?MVA0QnBEbTF5RXQ2SVdHdnhFaFJHMmNsYm95WEpkZGF5MEdsNHZxNVE4TU9V?=
 =?utf-8?B?Mk9HamRqVmhyWlBJWFVmUUNMRFovc1ByRWM3WVJOVStwRW40Sk5FZG13Nk9C?=
 =?utf-8?B?c1NHZk5PQmVlZHdXaTR1ZE1vYkhhMUZUQnp1R3ZDdkU5dmFzenhySFNaQXNU?=
 =?utf-8?B?N3lOaE5XMm9rMGNzbUZoTGZrWXNHNjlpVG15NitHSE92YVdlaTZDZGNRdnJy?=
 =?utf-8?B?Lzd6cFdtZmVHOG5tdkllK2h6SGkwUjVGN1I0Q1lYS2djTkhuSTcvYzFmaVFw?=
 =?utf-8?B?OElEdGNqeGk0M3dzcDJqMVN0UjkrRktIY3M3OFRJTnpjTEdVZGZsVkNjbVMv?=
 =?utf-8?B?SXdicW1iMTBmaWdkU3hVWnNsN0s2QVhPQXozc0s3WDNMbHdUVCtyZlJidk42?=
 =?utf-8?B?bklHNUttQ2dNWXh2eGlqY0YwamdUOVJZYVpSbkFiZVJ1bHNWU21hMUFEQXkz?=
 =?utf-8?B?dC9vWmNtTldraDNCenExcnQwSitqcGxObGlqdnY1OXBONFlkY3pjUnRsRUdQ?=
 =?utf-8?Q?q8CTZI//btXJSA/dmV3vujc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c2febd-2b58-43bc-4130-08da020bbc3c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 20:31:05.4651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYzEX7WBu483sqpQyEnopLtP0ra7WbqN44QhczgbP64kBnA8QHraCGwahe6c9/sBJdE5f+bn1lkFYDmcCE1jPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1647
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
Cc: Eric Yang <Eric.Yang2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-03-09 14:19, Nicholas Kazlauskas wrote:
> [Why]
> To debug when p-state is being blocked and avoid PMFW hangs when
> it does occur.
> 
> [How]
> Re-use the DCN10 hardware sequencer by adding a new interface for
> verifying p-state high on the hubbub. The interface is mostly the
> same as the DCN10 interface, but the bit definitions have changed for
> the debug bus.
> 
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Reviewed-by: Eric Yang <Eric.Yang2@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../drm/amd/display/dc/dcn10/dcn10_hubbub.c   |  1 +
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 10 +++-
>  .../drm/amd/display/dc/dcn30/dcn30_hubbub.c   |  1 +
>  .../drm/amd/display/dc/dcn301/dcn301_hubbub.c |  1 +
>  .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   | 60 +++++++++++++++++++
>  .../drm/amd/display/dc/dcn31/dcn31_resource.c |  2 +-
>  .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  2 +
>  7 files changed, 73 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
> index f4f423d0b8c3..80595d7f060c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
> @@ -940,6 +940,7 @@ static const struct hubbub_funcs hubbub1_funcs = {
>  	.program_watermarks = hubbub1_program_watermarks,
>  	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
>  	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
> +	.verify_allow_pstate_change_high = hubbub1_verify_allow_pstate_change_high,
>  };
>  
>  void hubbub1_construct(struct hubbub *hubbub,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index bc9dd48258e3..c3e141c19a77 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -1112,9 +1112,13 @@ static bool dcn10_hw_wa_force_recovery(struct dc *dc)
>  
>  void dcn10_verify_allow_pstate_change_high(struct dc *dc)
>  {
> +	struct hubbub *hubbub = dc->res_pool->hubbub;
>  	static bool should_log_hw_state; /* prevent hw state log by default */
>  
> -	if (!hubbub1_verify_allow_pstate_change_high(dc->res_pool->hubbub)) {
> +	if (!hubbub->funcs->verify_allow_pstate_change_high)
> +		return;
> +
> +	if (!hubbub->funcs->verify_allow_pstate_change_high(hubbub)) {
>  		int i = 0;
>  
>  		if (should_log_hw_state)
> @@ -1123,8 +1127,8 @@ void dcn10_verify_allow_pstate_change_high(struct dc *dc)
>  		TRACE_DC_PIPE_STATE(pipe_ctx, i, MAX_PIPES);
>  		BREAK_TO_DEBUGGER();
>  		if (dcn10_hw_wa_force_recovery(dc)) {
> -		/*check again*/
> -			if (!hubbub1_verify_allow_pstate_change_high(dc->res_pool->hubbub))
> +			/*check again*/
> +			if (!hubbub->funcs->verify_allow_pstate_change_high(hubbub))
>  				BREAK_TO_DEBUGGER();
>  		}
>  	}
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
> index f4414de96acc..152c9c5733f1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
> @@ -448,6 +448,7 @@ static const struct hubbub_funcs hubbub30_funcs = {
>  	.program_watermarks = hubbub3_program_watermarks,
>  	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
>  	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
> +	.verify_allow_pstate_change_high = hubbub1_verify_allow_pstate_change_high,
>  	.force_wm_propagate_to_pipes = hubbub3_force_wm_propagate_to_pipes,
>  	.force_pstate_change_control = hubbub3_force_pstate_change_control,
>  	.init_watermarks = hubbub3_init_watermarks,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c
> index 1e3bd2e9cdcc..a046664e2031 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c
> @@ -60,6 +60,7 @@ static const struct hubbub_funcs hubbub301_funcs = {
>  	.program_watermarks = hubbub3_program_watermarks,
>  	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
>  	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
> +	.verify_allow_pstate_change_high = hubbub1_verify_allow_pstate_change_high,
>  	.force_wm_propagate_to_pipes = hubbub3_force_wm_propagate_to_pipes,
>  	.force_pstate_change_control = hubbub3_force_pstate_change_control,
>  	.hubbub_read_state = hubbub2_read_state,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
> index 5e3bcaf12cac..3e6d6ebd199e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
> @@ -949,6 +949,65 @@ static void hubbub31_get_dchub_ref_freq(struct hubbub *hubbub,
>  	}
>  }
>  
> +static bool hubbub31_verify_allow_pstate_change_high(struct hubbub *hubbub)
> +{
> +	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
> +
> +	/*
> +	 * Pstate latency is ~20us so if we wait over 40us and pstate allow
> +	 * still not asserted, we are probably stuck and going to hang
> +	 */
> +	const unsigned int pstate_wait_timeout_us = 100;
> +	const unsigned int pstate_wait_expected_timeout_us = 40;
> +
> +	static unsigned int max_sampled_pstate_wait_us; /* data collection */
> +	static bool forced_pstate_allow; /* help with revert wa */
> +
> +	unsigned int debug_data = 0;
> +	unsigned int i;
> +
> +	if (forced_pstate_allow) {
> +		/* we hacked to force pstate allow to prevent hang last time
> +		 * we verify_allow_pstate_change_high.  so disable force
> +		 * here so we can check status
> +		 */
> +		REG_UPDATE_2(DCHUBBUB_ARB_DRAM_STATE_CNTL,
> +			     DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_VALUE, 0,
> +			     DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_ENABLE, 0);
> +		forced_pstate_allow = false;
> +	}
> +
> +	REG_WRITE(DCHUBBUB_TEST_DEBUG_INDEX, hubbub2->debug_test_index_pstate);
> +
> +	for (i = 0; i < pstate_wait_timeout_us; i++) {
> +		debug_data = REG_READ(DCHUBBUB_TEST_DEBUG_DATA);
> +
> +		/* Debug bit is specific to ASIC. */
> +		if (debug_data & (1 << 26)) {
> +			if (i > pstate_wait_expected_timeout_us)
> +				DC_LOG_WARNING("pstate took longer than expected ~%dus\n", i);
> +			return true;
> +		}
> +		if (max_sampled_pstate_wait_us < i)
> +			max_sampled_pstate_wait_us = i;
> +
> +		udelay(1);
> +	}
> +
> +	/* force pstate allow to prevent system hang
> +	 * and break to debugger to investigate
> +	 */
> +	REG_UPDATE_2(DCHUBBUB_ARB_DRAM_STATE_CNTL,
> +		     DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_VALUE, 1,
> +		     DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_ENABLE, 1);
> +	forced_pstate_allow = true;
> +
> +	DC_LOG_WARNING("pstate TEST_DEBUG_DATA: 0x%X\n",
> +			debug_data);
> +
> +	return false;
> +}
> +
>  static const struct hubbub_funcs hubbub31_funcs = {
>  	.update_dchub = hubbub2_update_dchub,
>  	.init_dchub_sys_ctx = hubbub31_init_dchub_sys_ctx,
> @@ -961,6 +1020,7 @@ static const struct hubbub_funcs hubbub31_funcs = {
>  	.program_watermarks = hubbub31_program_watermarks,
>  	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
>  	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
> +	.verify_allow_pstate_change_high = hubbub31_verify_allow_pstate_change_high,
>  	.program_det_size = dcn31_program_det_size,
>  	.program_compbuf_size = dcn31_program_compbuf_size,
>  	.init_crb = dcn31_init_crb,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> index 7dbe301a994a..89b7b6b7254a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> @@ -1011,7 +1011,7 @@ static const struct dc_debug_options debug_defaults_drv = {
>  	.max_downscale_src_width = 4096,/*upto true 4K*/
>  	.disable_pplib_wm_range = false,
>  	.scl_reset_length10 = true,
> -	.sanity_checks = false,
> +	.sanity_checks = true,
>  	.underflow_assert_delay_us = 0xFFFFFFFF,
>  	.dwb_fi_phase = -1, // -1 = disable,
>  	.dmub_command_table = true,
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
> index 713f5558f5e1..9195dec294c2 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
> @@ -154,6 +154,8 @@ struct hubbub_funcs {
>  	bool (*is_allow_self_refresh_enabled)(struct hubbub *hubbub);
>  	void (*allow_self_refresh_control)(struct hubbub *hubbub, bool allow);
>  
> +	bool (*verify_allow_pstate_change_high)(struct hubbub *hubbub);
> +
>  	void (*apply_DEDCN21_147_wa)(struct hubbub *hubbub);
>  
>  	void (*force_wm_propagate_to_pipes)(struct hubbub *hubbub);

