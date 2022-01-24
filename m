Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F281C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 19:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A08910E672;
	Mon, 24 Jan 2022 19:00:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B062B10E672
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 19:00:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzGUqtrVmK/Peq/mmiuRO/+iUCIzspiBPj4un3UVOkMadUKQVbnq/yeI0e2V8GKBQtdJMJJ0GudDv8V44B627+np7i9WloxlDyZxqBJLMM8b7Qtj7zNsl2UUjZFtKMk4q1FeV9jW0o0Sn6+6nDJa9q3v3WqXs3ZQz2XoJZedWPRf49TvRy4HsPYYcJlnT9exxxpgyFhEuAmxLzldy5A55NinOaBabsuwzMBNv/tETytwKpOiNRpeuYJUccGAUdUNaegccUqc52apsC1wknRax0lMrPShNSDgMpw/kV2SvqLqAAwwqg43QZpPK1rA4Qt9EfZS2L8WDCOwGzyKzaw+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6T2cWjU/PhIedT49OKVjLDf8Rpihh2KulB/NSfUqFTk=;
 b=ZCJNVvCTkQgeTwLEG1TuUwZjcsEo/eP8SWkcj4269v5P3GNfdV1a/S9VU/yCjKoarDPxio06ZMMJ2Qf3IVgw3ic2Qrh5R43/MM5NB/V484KR7YN5Cu5QuirvpcizJ4pBDllr28xYsBm2xdqPP1WqhkpxjQJoosS86rjQL+G7fSfoxrrftZWQDyqw0PZagcZNZOOzzMMGC6UqqGpgxovUIXRm17gIza8qedQhP/hfc1OW1tkAztWPUNT5IuFISWF9fVbeuUBd7/A5dVTrXQsjVXTOV2jAxhrBC5IKvP9iPAAFM71/Q1qmQWzS5sneAVpXr5R5ua8NDTbeU2swuLVElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T2cWjU/PhIedT49OKVjLDf8Rpihh2KulB/NSfUqFTk=;
 b=up8XG6XJUjKOo4sEAJHmvkFCcQBdGkuenxKY+iGYr5A9hHCIuwqVHxbooWXeOhlJ3N+DrX+Dezt7UxGXuVYiJ4J9Aw9Vn0lQDsIDN/EB2rh6i8QR3QzNAEBw6ELtOrOMvkySoE4l8x0nK4ECOUD99eLMqVnaeQ+UrAJ7icOk8jA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM5PR12MB2407.namprd12.prod.outlook.com (2603:10b6:4:b4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 18:59:58 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 18:59:58 +0000
Message-ID: <3088a316-04b5-4df4-3053-d98744469b77@amd.com>
Date: Mon, 24 Jan 2022 12:59:56 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: drm/amd/display: Call dc_stream_release for remove link enc
 assignment
Content-Language: en-US
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220124185701.54981-1-nicholas.kazlauskas@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220124185701.54981-1-nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0297.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::32) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43ec79f3-e94a-41b0-90f6-08d9df6bb748
X-MS-TrafficTypeDiagnostic: DM5PR12MB2407:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2407E8CA6755605DD0F6159AE25E9@DM5PR12MB2407.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m5dClOjWguLnTYBKO6lKZqMngx2BjDwt9k2tp6FRpaQGEdbFq7QvG4aEmc3qAB9qx2lme2yv1KOMPWQhZsVP8Sdgwt86jnUKREy+azoS+6WiRKswZi989xUgxfsp4udS9cz1tg5ZyjLecMOZsdti2A0/NLIh0eWWq5MRMTtNiA5c7xFNfYQj57fwpLQFmndbeIfCvGHmZF42Xa7IyQL3k0uxitya0r+3youtaheiDclIGOVzfs+3zH30ZMB2mrIVaYOwRyyrRnZeAzkev67gcZ3A/7MWgBzYBIuGZfritqQWaQV/plppLXxfKkEC1JQvis7KH+8sF4g4ly4ymU1j6L6PC0dsENVBCixrmXHIwTi6rq6CvczUlXoaJzNOq30lac6ijjAedM9OPm2b4C+NiKcJ6gSYiQqBP0zsH95lcom0rTi5EVSdzFHIvKDeHVAc8GnK1KwNCRcPaKlFz40Q63IYnntIK15mRmNS3R7QIEwfbIIT1xYWqZ7+6TmFIz9Nvygn9QUgpMQhPLtMM7jhohTQ08Ff3yeG+ZoIzB9aeuG3YtSFKS2TUI+SC7upZ/8ZwZiaOoeUEQBHG7dEQzA6KgcJernG/NTGoZK93Qy9W5QQOtlmiQQpyvnZz1SIPILECXqRGIDreO0rqhiiymg4WAj4Iyvz7sV9P2a8/awg3I2l3jwI/g0vvGGpdBSs2eaMoYua/S0WF/xXg566VLf9ppLW94Ab7tereihWiElVeD6sxDU3SAZt95qNb8XXznGm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(8676002)(2906002)(316002)(66556008)(66476007)(6486002)(2616005)(36756003)(66946007)(5660300002)(4326008)(508600001)(86362001)(53546011)(8936002)(6512007)(186003)(31686004)(6506007)(54906003)(26005)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z25WUHdTSlhHMHJ2cldBWkpKN1o4VjVLU3ZZUFFDUkozVFNsVTRaU01IcmUr?=
 =?utf-8?B?SlVYYlJxYlVSaHZZV1JiM2h5bkxLU0pETjZEbGpJeHNCb3dVaXRES2dnMTZ6?=
 =?utf-8?B?OEhmemp3SXdIb09rVGtyY3VyTTN0NGUrZmVMemVGUzdsTE9QR1JmY1k2VDhX?=
 =?utf-8?B?ZTRnMmUyOFFCbTBudkFSMnRQOVI5bmREYWk4cFhXNUViZERicHl2YkRmZXJQ?=
 =?utf-8?B?ck1mdzVhODFYNVJXL2JtcjZmTHB3K09TMktWOTZVODM1UkU3NXFMaHd6Tmty?=
 =?utf-8?B?dHl2ME9CbHN2N2Y3NVFIWVYrckVmeWRrSUhEL2lWNmpqQlBpZWZDNytiQTBT?=
 =?utf-8?B?SloxRGN1c1pJenBwd1JCb2sySUV3Smp3aHlESEM4dmJGSkVDMEpSb1puMFFB?=
 =?utf-8?B?VkdGcFhMOEZoTjcyOXVzcEVmcHlEWXhDVmZxWTRBYXpVekxmTVJpdzdIM2RI?=
 =?utf-8?B?dzNneXhERU9qYTF5T3hISkxhcmF2ZERGN3ovOGRYNmUwUURRd1o1dzQ3bS9Z?=
 =?utf-8?B?WVRCWDVCbkFPSXBRTlZSWVJvaU50aTlvTVN1ZkNKemZrQ05xd2kzd0VxNkdZ?=
 =?utf-8?B?UFRRbDFUcEFuQTh3SXptYWkvU1JvSDBtRjA2Mnd2MW5YVU0xelpMK1JET08x?=
 =?utf-8?B?UEdSbUdXb0t6MFVuOWRxZ1UvNEk3V0NZak1MdFY5bkx5UytNUno4ejViK2xG?=
 =?utf-8?B?QzhrdEg0WHl0aGVpdytnSUxVUWR1LzErZmNFT1V5UUlEcDlSeGljY0lnWnI0?=
 =?utf-8?B?alNOOFoydlBnY1o2TUEvbzkwN2MvSTRTY3N5OFJpaFU2cmZqK3gwUUNSVFZt?=
 =?utf-8?B?UzlBdWo3N1JSL2tOL014T3R1Z0xXYVd4U0ZjUDdkYklHNFlTY3pWWTl3b1NB?=
 =?utf-8?B?NVJhcS9Cbm00dFhJRU5oZlUrcHcrVENpeG5JNnk5cTVHcGhXZ1hTUnh4VUVU?=
 =?utf-8?B?WG41TU12LzZTSkIxejdMOUZnYkdkTHpuZlJkc1hoYkRQRFB0WWJlQVJPNWZR?=
 =?utf-8?B?VmMvak5IaXRRdEJYbG1XSE1MMTArcmhlQjdqVytLdTZKRkRmZi9pRDd2ZnQ5?=
 =?utf-8?B?a3BEM2FtWHVoVnlab0JVa3pJTjJzNDdURFdPaGFxcXRjT1RNZW90c1ZUMGlx?=
 =?utf-8?B?VXlVSC8zSjVPNTZsZjN4M2RFUnRGbkRWdDFyM3kzV0RnSDJGUUhjWlI0V0I2?=
 =?utf-8?B?WGFEZ0VoRUF1ck5rcnJoNk9vc3U4NG80MXZ1NjRWbTFybnhUYmhhSVBMRDZY?=
 =?utf-8?B?cXNEU21nbUphakZDSjFQaEJRcEx6KzZKSHVGRG9mWkhpNkkrY09JV0hPcE9L?=
 =?utf-8?B?bmtlWjNTanBTUWppT2ZDNEdHTUovR2JMRWovUWkyMDFyYmxjS1UyNkZtZS85?=
 =?utf-8?B?K0dzNWFBc3h5MmtPS1doSFhnWGZ6aGNCYk5kTit5Rnl5SEJySW5RTGtTeS9S?=
 =?utf-8?B?NGZLMGwycEtIYWNsL0U4SFU4TUVQODgwelcxYXJndWZiUlBnRlQxMHFlR0hU?=
 =?utf-8?B?YUtmVTVrQnFxTS9UazBPbVNzT2o1eUtia0xwV2pIMnBMR1JiMmdhS2I3bzZH?=
 =?utf-8?B?ZnZzNERZcEl0ck53YzROS0Z5TTdHY0REeG1yWS9yNW44Mi80dXdPeUh0V3I4?=
 =?utf-8?B?M2JOd2lIc3hrVXJrNUM3SzBEcG9pS2xBU1lRcndhNXdSQm5DcEhaT2ZMcFdp?=
 =?utf-8?B?aGFwYXdDZ2dVVWt1UmlONGQvNXRORElwamRJTVhwRVpqbkpkRE9Dc2hEYmph?=
 =?utf-8?B?SmtySGJuYk5sbFRtd3RGY1IyMGZCVUlOelNqUWszakdHY1FRYW5GUE9QbDJx?=
 =?utf-8?B?MlBZamU0bVFwWGR2UGtHcWZtT2xuZHFYMW9XbFlsd2xIL1lvNUptWTVBK2pR?=
 =?utf-8?B?bzZlWHJwbVJuRnpUZXNQZjhjTjR0TUV6c3RtamdNelNTVDRSSEZTQ3JHTTZB?=
 =?utf-8?B?SFl2MlFqSDAwUmlCZy94WkRIR0Z3ekdqbEd6MFI0QUF0akpSN1FzSUZoS1g2?=
 =?utf-8?B?ampISTJrYW9KYTBTYXpnTVNNT0Q2MmIxVU9pNzNMWm9EUnQ2d1Y1eHRZb0dn?=
 =?utf-8?B?NDFLNlc4TUdIdGd6OVJaOUh2eTNEODlTeGlOcTJ3V3haN3hkNUpPQlRKd2JV?=
 =?utf-8?B?OU14cnB4Rjd6d1hnSEhXMi84cExXYWZYbDRLbGV6eUtRcTFyNGl0QkJPK3NC?=
 =?utf-8?Q?tR0bW3t2ZQ0J4rYtzmaPQ4o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ec79f3-e94a-41b0-90f6-08d9df6bb748
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 18:59:58.1616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/XvKs18pERJnc5ycH0f05y0f9Gg1VDMYCjZxjioC9p/1S1zKbiUZNz9tc3ZP1ZlneEdytBWbesFMBXi5HvIvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2407
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
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/24/2022 12:57, Nicholas Kazlauskas wrote:
> [Why]
> A porting error resulted in the stream assignment for the link
> being retained without being released - a memory leak.
> 
> [How]
> Fix the porting error by adding back the dc_stream_release() intended
> as part of the original patch.
> 
> Fixes: 2e45b19dd882 ("drm/amd/display: retain/release at proper places in link_enc assignment")

This commit sha is wrong, it should be 
0bb24555858403671657f6dc025d2931e3e857bb

> 
> Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> index a55944da8d53..00f72f66a7ef 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> @@ -122,6 +122,7 @@ static void remove_link_enc_assignment(
>   				stream->link_enc = NULL;
>   				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].eng_id = ENGINE_ID_UNKNOWN;
>   				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].stream = NULL;
> +				dc_stream_release(stream);
>   				break;
>   			}
>   		}

