Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD5CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 16:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3529510E28C;
	Tue, 18 Jan 2022 16:49:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A41510E28C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 16:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2O2n6HYDv3wCtGsaTNz+nVZHi7F0UVo3+IovwpgJzOcva/kqkEqFwNZ9eL4cDmeQtStBWlXkE8Ci5XeJ1dHntGmgKEp6HxTfQJrjnsbGsdagPIjIkoYtBZ+6U1jriVE3nBXLnyRoB5XNaT6MOPIezaaIdHov1lXKYzF/WhR/nF5jeCHCXaUCE5lzQeocDqJpnqLFwN5pkY7+y9PgrvUu1o+OpekUr1KOm02GMPEoRPc1Fz7Wbpj8Z6B9ybfoZYeTfcRpzt4xFF6vEdOR2m7qYSqUnRbF0z8Ih9UClUXHgiWEbAW9ZUxxbIQ2eH3dEJiKmJ0s2x2g5T2J8MnpJRklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eMYtJ8vEv4EXDOjGwVPGfm97pj54yL1dX9fkf7Cbrs=;
 b=EWtRp2ef/DOWan/kx4mn3DjRvYFyH2TeTi38Jbp8ZTrZ+iLpcfiCez6AMrg5oXafMlvQLcCdI1htAlKJfknMHlmhBSOAl3i/l3+LYm8Tmd4x4Vqtp3B9GRaoGY1/76nKKV6LuTf85HDgve/Z3Dt0w2lCr9r3WmGNB3JrWrB/7Xvp2Vds58bKGSW9heucnO79Zqd/cXEa6upFej6UrPbdkm2mHYPdwuVmT6E3Ws+lGJOC4q59kCtS6Ogi9roPDIt/zuwM2V8ts/pU1SobFxHGEFTL9a7eOVeDf28zcD/07SOG1I8RkNvNo5NvKmCfaalGqR3BxnxVafF/CjXAiv/FGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eMYtJ8vEv4EXDOjGwVPGfm97pj54yL1dX9fkf7Cbrs=;
 b=eVHiL2Bi/eqcggIO/mKfm5bnH+dBWMOMdSJgjRWcdksLfa0O4xnUAMbNsgfuVHU9qVeVUgj9ZYi6Dt1Fdfexvtp8BVm+nvxtTlpByIGGt39h/tcDJpMsQN0WEpgzbvx0cMaSL+bDTIzaGIBdSBkpeJFE3+Q7b92d0tTzH/mUkNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM5PR12MB1802.namprd12.prod.outlook.com (2603:10b6:3:109::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 16:49:08 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98fd:4e9b:b4d6:64a3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98fd:4e9b:b4d6:64a3%7]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 16:49:08 +0000
Message-ID: <46372b6f-0bb0-72e6-766b-b43afc2783c7@amd.com>
Date: Tue, 18 Jan 2022 11:49:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amd/display: Copy crc_skip_count when duplicating
 CRTC state
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Mark Yacoub <markyacoub@chromium.org>, Leo Li <sunpeng.li@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20220118164004.601780-1-Rodrigo.Siqueira@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
In-Reply-To: <20220118164004.601780-1-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::31) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf71110a-42ac-4302-70c3-08d9daa2722f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1802:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB18021A6ECA5391B5CA491F6BEC589@DM5PR12MB1802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FlvwPtnE91UkjXESULZUWcpwPOdrSW7wiIdUYfPjoXmxvadiC8//rP6PIfCI04bPZR7r9z2Vglp4QUaVUO69UjLsqPusjJlomUZ3eqq5wQHls/KknXFLT+19btdBJb+dqP7t4N3ovNfQGIm/sHV/Ke8LSMqnc9qQUQ8YamwCkHDJR2vQGWo5Np5oVf1dqoS5XTOfvPPr/E/5LCyBznVjjBA6hAG4EMlF842ATNcvEW+r630WLtbq6HH7OtJjXkmBmNscOIC4kf0eZC1r+Dm8wf6iftHHFZNGU2RrnHpaA7eq2+FiEq2P/4biuTSEkFihb5QJWAiiCFjQ3ExaHIEwXg/slCFnu83C2O9HuA293RnqHZNtc+9BFz7X2d7ISdpkVZBhFgAomnZeHGVF9Z1tNHviCjI//tNQvXs6Q6JpYJq4Wtn3d8CIospdnZiXSrwdlah//ArGw/6z7O/HmNj3bXeH6quqThU+D/ckcAN/Cr5+3uO4Gr8+dSxE7YYb0ClXdYwF1jI5cE+pcz3Sp04llXvF11evOJYemTpBXU8F1JParZ7tn6jBS624XRm6zPCGZAaikKXnaxiB8zf3AB2g3xER7Gr0CIxO2Mj1Si6SYyoX+Tqz792+xyTrk4epF0GvpOncxjd3nskzYCaH+/XmYYnJqbxGsuvRukfXRwweQiLpm9eVXuF4r94UX/97SIAfpsa0iNzXWgblbuZmq3PGgbFBd/vueWnxWuCUpE93mIIytTBRgjQyb+/C1cV7PKDE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(6512007)(508600001)(6486002)(66476007)(2906002)(6636002)(8936002)(5660300002)(66946007)(2616005)(8676002)(66556008)(186003)(31686004)(110136005)(54906003)(26005)(36756003)(316002)(83380400001)(86362001)(4326008)(53546011)(38100700002)(31696002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elRrdExPSzg5bnd1bE11Wjh5dVVZbUU1S3JWMS9aY1ZUL3FwQ3dmMnUvYjcw?=
 =?utf-8?B?SVU0R0VORGJ0MzRJazk3ZUVzcndZL0JveWNXWW4xRmttZ3FVclUvdk5hZ3B5?=
 =?utf-8?B?dTNIeks0dlVKYkszNE9lUUs2ZlNTb2NSRlBCRzM1TWZVMnd5V2h0bjd6RnUy?=
 =?utf-8?B?c2hVbjZjOVJZRkl1MHd3dG1MbDQ4Umc0cEk4Nkthcy9qTU5nUVNWeUprMlkv?=
 =?utf-8?B?S0tQQ1hoem9xWTN0QTdLNG9PRm9ZU3pKUlB0My9XOTM3aUJ4Qlhia3l2TTR0?=
 =?utf-8?B?bFN5L0ZIcUQ3c2doNnE2N09WR2UrbGpMTiswd3F3cFArdlpEOWYwb2UyNHRL?=
 =?utf-8?B?SVduY1plM3lIY0JGSGdPSm5GQXlIU3dZdHh4eTBVdDdITDFObGY2eWtTcXQz?=
 =?utf-8?B?WWF1OGJES1hYb1B3SC9iK085ZFJoVUV0UGRGZUIzRmJjVzE4Skk4UllKMllq?=
 =?utf-8?B?aTZKTFZJQTRicGFnYWJ6bjU2RmRQa2F0ZVFyNWMwNlk4TzNiMG1SS2xidmNa?=
 =?utf-8?B?cldReXZDZDRtQW9TazRBM0I4NzdsL3dadDZsbWt2aWdHbmpNMHcwRk5pczhF?=
 =?utf-8?B?RDQ0QnJtQi9QcnRmRGQ3bFdIZDFla1BvV3RqbS9pMnEvWnY4aXN0Q3RyWXFF?=
 =?utf-8?B?QVhSZlFScCtpWFFuZmdSRy9MTSt6eU5EVUVLdDhmOS9LblBhMHBCVFllbjdN?=
 =?utf-8?B?NTdDc3l2d2xtTE9RU2RtVndtaml1b1pITk5UNGxzc0hVMGZlWkw4bWE5d1Ay?=
 =?utf-8?B?K1J3SDEwdjZwOEdVRzBiQmkxblM5ckpvSWNiQmpwMjJZaFhsOTBkMzNIbkxr?=
 =?utf-8?B?UmdVaTNoNTI0MDdURXQrOGx4QnlBVEdGNTFSQXQ0VytxV0o4dFg2QUlGU0Vw?=
 =?utf-8?B?K3JLSmQyLzJoS1JQeHo1NFRJSU1Pbkl6aitkdXdPRjRnekgyUEZ5Z1hOd0F0?=
 =?utf-8?B?c21UUkRubGEwME5pbmk1L2JFTXpBekovbm9TazhKR0RVeFlvTStjbEc1Tm14?=
 =?utf-8?B?eFVwMHBMR0d2bjM2eUxYWFFjaDVPbTZXSEJoVEJsWGN4L0svdithRE90Z09O?=
 =?utf-8?B?S0tZZkVCNzBOOW11MEMvdlBWbFd3ZjYrdk9BQkRJeDAyaXpZZ3pzQ0I0QmV4?=
 =?utf-8?B?dk1OcTl0MWxuN3pLbFA3Q0xCREhpaXlBK1NpQWlmRW9rb3dnMVJFN2dVSDlj?=
 =?utf-8?B?MktCbnhobWN1Q1B3aFFMQzhDbEZ6azN4Z2psNEQ4cGtMN0hKem5sSFNmeDhl?=
 =?utf-8?B?WVRsK1V6Mlk0T29hbGl4bk9DdUYxS0hZbmtreVNWUGo0dXQvaEFIcHpMa0Vv?=
 =?utf-8?B?eXNHa1ZaWkNETjQ2SmxkTXRPR0dQazJ2aW05aG9KV3Bhc2VvemFPQUdEdWNt?=
 =?utf-8?B?L3E0cXd6MzlpV2JYVnJkNVpFMlJiYlEzZkxkODEvellWTkh1WWd2MmRzeC8r?=
 =?utf-8?B?VjBMbDFsRnFWYktxOGxEL01EYmVMeGIySW1SWEp3amJtQ0ppVHFjL1l5R0ZH?=
 =?utf-8?B?bm5CelNYN1pQYlp3c2lURFMxaVU5WUkvSC95ZkFGUS8xcDhiWHZOUWtlaFdO?=
 =?utf-8?B?UUN0QjFCQUJtNnUyVWlYZ1ArSmtpM1NwZGZLUEVhZzl5dExpS2N5b2NBaElM?=
 =?utf-8?B?YXdBeHdJNS9TSEc5M25HS1pmay93Q0xsTkhCR3VDS1dWaHZNeUk1aXg4NDJF?=
 =?utf-8?B?UHduM3ZMVjcxb1BiK1hDYy82N0NXaGIwWGFuWXNlU1lsbGhyVE5DWU9MZHQ5?=
 =?utf-8?B?VkJMK1p2ZmNicTR1TWRSQ3BHaHBVeDRyMVdlWXMxN09XQkljSTlXbGJ5aHJK?=
 =?utf-8?B?bVp2SXpnYjdGRGlDbkdoanVGSDhiVnZyZUtmNU80SmV3VUhZcStBTDREaElj?=
 =?utf-8?B?MXYvbVZlb0JudE5vaHpZcTlaRDA3UUtjY3g3eU5yZ3BIZm9kRXBGekpDMlRC?=
 =?utf-8?B?SUZqRXVhTWJNRWxxbXF6RDM5c09oMzQ0bCs0dEk1eHdjaStVZml2NlowWHFs?=
 =?utf-8?B?Y1UyRU9hb1p6bkd1TE5lMVk2Vm8xWTRUTStRcU9VSVF6cWFvK3NtYitSQnk0?=
 =?utf-8?B?SWppYnNTWnRPbStlMVNnK0p6V040SE5CVDVheHpQcHFKdGNOY3lqZExwTCtm?=
 =?utf-8?B?dXdBdytOdnZHSUdtNjA1MFQzdFhJQW1WY1NxV0FWS1JFR0NLTW9ZMVJFdDBC?=
 =?utf-8?Q?lHaJiy5UKHbrWXT6ALNG+8M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf71110a-42ac-4302-70c3-08d9daa2722f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 16:49:08.7353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6dkjqeAiRj8LxIBjP+ab/pMS7pHpJvK/MkgGC/VlDVDxp3YrHZ54uztUDuJ//dMp5zQ9HGjIQ4ZX0CvlMXBPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1802
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
Cc: Nicholas Choi <Nicholas.Choi@amd.com>, amd-gfx@lists.freedesktop.org,
 Hayden Goodfellow <hayden.goodfellow@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/18/2022 11:40 AM, Rodrigo Siqueira wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> crc_skip_count is used to track how many frames to skip to allow the OTG
> CRC engine to "warm up" before it outputs correct CRC values.
> Experimentally, this seems to be 2 frames.
> 
> When duplicating CRTC states, this value was not copied to the
> duplicated state. Therefore, when this state is committed, we will
> needlessly wait 2 frames before outputing CRC values. Even if the CRC
> engine is already warmed up. >
> [How]
> Copy the crc_skip_count as part of dm_crtc_duplicate_state.

This likely introduces regressions.

Here's an example case where it can take two frames even after the CRTC 
is enabled:

1. VUPDATE is before line 0, in the front porch, counter=0
2. Flip arrives before VUPDATE is signaled, but does not finish 
programming until after VUPDATE point, counter=0.
3. Vblank counter increments, counter=1.
4. Flip programming finishes, counter=1.
5. OS delay happens, cursor programming is delayed, counter=1.
6. Cursor programming starts, counter=1.
7. VUPDATE fires, updating frame but missing cursor, counter=1.
8. Cursor programming finishes, counter=2.
9. Cursor programming pending for counter=2.

This is a little contrived, but I've seen something similar happen 
during IGT testing before.

This is because cursor update happens independent of the rest of plane 
programming and is tied to a separate lock. That lock part can't change 
due to potential for stuttering, but the first part could be fixed.

Regards,
Nicholas Kazlauskas

> 
> Cc: Mark Yacoub <markyacoub@chromium.org>
> Cc: Hayden Goodfellow <hayden.goodfellow@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Nicholas Choi <Nicholas.Choi@amd.com>
> 
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 87299e62fe12..5482b0925396 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6568,6 +6568,7 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
>   	state->freesync_config = cur->freesync_config;
>   	state->cm_has_degamma = cur->cm_has_degamma;
>   	state->cm_is_degamma_srgb = cur->cm_is_degamma_srgb;
> +	state->crc_skip_count = cur->crc_skip_count;
>   	state->force_dpms_off = cur->force_dpms_off;
>   	/* TODO Duplicate dc_stream after objects are stream object is flattened */
>   

