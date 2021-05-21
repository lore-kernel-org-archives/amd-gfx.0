Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0DCC47078
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 15:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEDA0613DA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 15:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDA0613DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20A976E195;
	Fri, 21 May 2021 15:42:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 786A76E195
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 15:42:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXuBvCn6yc4IEVxgx5+Zfmd8nSeLAu4/LyNHXcnPY8hZWrzlxS4nPIEWmRdMRy/jyGJoJdlgqKCPQRRrc7OOeKT5rp6GMR7CyABIsDarfgZnChl2gcpyju9xQvRApgt0OG2rj2KQtP8polq1eaNIjzJbWY1W71Ba5kQsmGWyb1TNXZD4JlgyddmX3VHfI7Fv72I7vErGkTISmu5aU9V8GWKNXIQKL5zXZ07UP4F/ggTdGkIC3M0YW5oKjaH9zqd1C70beGQGIapasADn06Ypf9mxWX9Ceo1BiE9xPXrW0DP/VJIwLzOQQBaDRFdelJRLx/wUR89xeU92Yl/hFznX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00BvcJ5aM3zEH4gMVxrRFYVQq0+6+pPfmss2ZoP1+k8=;
 b=EXVseQuhc1gh0G9OcYMK9k9iIJ5klM76Z8dj+tFuRKq+wVoB4DpqGKiZlxU3fEmlylKPkumIAyK+3vbPcQ3ei3MfXkOTzXdXg2yYtat7V0ORCaNypsW/sCPNX2PCFK1c4fKdYdeUdko8JeBj40lyiGhIJG4sB4Eo3QA2arXTy7dGXp8LNOLiiFkNleQx3zt6xocOA6rT3UnmgTZBOBSRifpzKI/PYNOWdguO8IpwBGP2vEx+FIuEKmlAefWzfA/ScXDETWVo8yX1kzTtEtSHGCzb8fdo9zOS7hsOrK4meb+I6cWz0WUHqBaEngtY82Kt1vzTids9jnWIPyVSMMsZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00BvcJ5aM3zEH4gMVxrRFYVQq0+6+pPfmss2ZoP1+k8=;
 b=FFJI1zMmM2zc31tb0V4DVpmwsOVcRKQPFvSDQyvQud48XDUeLrf2NTxdwEJ6auKNmY7d2Z0aWeFcbKMymYHUpJkt6bYxRfEAE5VROXCnh8MsUwoOto9G/NrG1Ulf0XuNX+Y3RQmmMo3pwdwAdP66XiAEvpORvHbrTk2KAayn+ck=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.27; Fri, 21 May
 2021 15:42:25 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::acf3:1432:d128:3565]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::acf3:1432:d128:3565%3]) with mapi id 15.20.4150.026; Fri, 21 May 2021
 15:42:25 +0000
Subject: Re: [PATCH] drm/amdgpu/display: make backlight setting failure
 messages debug
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210521040801.1530064-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <5234859d-4716-5b60-0195-772bf978ed4e@amd.com>
Date: Fri, 21 May 2021 11:42:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210521040801.1530064-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::24) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.16.155] (165.204.54.211) by
 YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Fri, 21 May 2021 15:42:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5819aa2-5b67-4ced-c981-08d91c6f073e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5039659178423C712C8F2F39EC299@DM4PR12MB5039.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WgM/o1/8IQ3YolwZNFkRrIHaACMjAM1JY176SOy1uiJT1VYPvnN8/BSQH7bxQT8lzg0I4A9Z5fKcLyOoZCQNEy3p67LZnYK7Cyb95Ezd52wG8eIocUjPFswsI0WV8SmhUTsZhS7WokM12oAKqAVXWUu5cjXK0ye9wxlXaytPsqfkUZAh06bt+V9QlCppCg/mripmUh9HP2m8HD4E7YKaUPen/OkxeoTMpvuQj8TR4/7HFnjFQ2kcFhgIvbrcu6OoPktOIEWwysELLQL9bUqYLPSiEwKUSU3rU9VYDQak1/SOEzTefl9YSunuSj7h5dPdKpuZNn+gm+FbBCOGjlkOflls1Fc6kJSeIDmZcz24xiDjuSnhFLIs/dW6QvQkG3yJedsoHOPwlvwW9PzkRyMyV2eQXOi0E6RcHjYfiF4R0aLyNlqOia48K20czaG50hMB7fBbhuhLlRcH/4H16a0LBh1Jdu7v+rTXMWWONABHowUvSYPFo8ThilfOU0DYkj/dPovpkxBB0Nah7HGb2REIK4aEEbQsWGLl6RxXteS0CkNwVd19y41QrQh6x1FCyVhMQRRQV/Cbzpp0mkNWU7jLSTDcm5ljk/IWKhPL+KnlUbW+7q3KIBRuNJr5XZ1fYJmpWvavhzKs3w0fe2m4k3AuS7410tFWiACCVekqgfKyjslUxxOURn8xFrPesPPzKBR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(396003)(376002)(136003)(366004)(4326008)(86362001)(83380400001)(31686004)(66476007)(8676002)(16576012)(66556008)(8936002)(2616005)(26005)(316002)(15650500001)(956004)(31696002)(186003)(38100700002)(6486002)(2906002)(5660300002)(66946007)(478600001)(16526019)(53546011)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YWx5ZVNYM0RCa213aTVHbkJKd1JYTldCL2xWd0NkSFVrak9qdWZnRDhTaWlr?=
 =?utf-8?B?VHdLb1NNR2s0YTJ0S2pLTU4vc2VuNWFSckdUMzdKNDlQcmN5SUpKc0ZsOHRv?=
 =?utf-8?B?TEg3REYvQ3RJdWFuSFcrM3R6cW9sWVVNeWovdVVDT283UkZLa3ltYmJHU3o2?=
 =?utf-8?B?T2hSeWhleHNYdlFLLy9MNVp3b3FRazI5SGY5aCtoQVFhMk9JM0lVK2NMemR0?=
 =?utf-8?B?T2cxNFVNSFI5OXliOExzNnJhZTFIS2Y0bnFFWmdnQThrRlZkaU0xcWdvVGZl?=
 =?utf-8?B?OUZJZmlhcDIzdkpaek9uRGdGWEFuRXRpM2EwcmNZRkdYQ1I5YzZ4ZnZRNjRu?=
 =?utf-8?B?M0hHM28rSy9qZGM1MUxhV0JSb3htMTlGeGhVUEFNT1JQZjVqWkpUbzVYbmRD?=
 =?utf-8?B?cjg2S3QvWVJBRFkrSU9kQ040MGpudHBRRlI1bUVRTDc1VE9kOHF6cGx3WnIy?=
 =?utf-8?B?OWZhMkQ0MjJSUlFha3hsU3Q3YkMveWZpV09pNjJGV2NHWU9wdXRuN0tSbWE0?=
 =?utf-8?B?dXFXSGIrNDM0UmZpWU00OTZETnpCczBsaWhjVmlFMzZlaE1EZzR3WnpMM0lM?=
 =?utf-8?B?QXBjUXVLSGdPV0ZYOUZtVVZIdk1nbUtXaHFtbnAxaWs3MGlXbkZrb05wdFF5?=
 =?utf-8?B?STZZYk10UmhJS0lDbml3MjMzblBWdDliQitqdlB6ZjA2WnY1dWFUNVBaZjhm?=
 =?utf-8?B?bzg3NysrN2lrcENwLzlRUHVHeFgyNVd1Um9EMTd3Zk1ZQWZ0U2lEci82eTRU?=
 =?utf-8?B?cm9RRlhJWnhHR0U3eUpEbGMwUHF1QmdXOXdYTmMzWEhOSjVmVUNXdGkvWUJD?=
 =?utf-8?B?a1Z2SlFlbHZJZkY4ekZCV3liSklBakYxVy80RzZ1S044a1J6dVFuWVdaSW5s?=
 =?utf-8?B?V3lqWE5KeVBpVmh3d0VidGtaZWJCdWkrSFNjc01UT2NjcWhvSkFXcmVZZzVa?=
 =?utf-8?B?aEJDTHJBVHI3N1VsVGJyUmdZY29GM0tBalluWkloM0dVZFpTZWZEWUVzYVpx?=
 =?utf-8?B?SFludzhGTGVTREtuYWVNS2VZZ2N1ZXhLYXcrS1pwRGlQQ21FUHk1c0VXV3RN?=
 =?utf-8?B?THpBK2YvcGVzLzFqWHFEamk4QStZTC9DRnExZHVxV2lZSmFzazFUS2dsRklT?=
 =?utf-8?B?bmlEcytyUitxdFJsNnM5d3ZhVEVzRmhWTU1xRWw4QlRCaXBXYjhIQ3RGK0ZZ?=
 =?utf-8?B?bFEycWNROWNYQXRsTGYwNWpZa2h6b0JCbGJ5ejIwUno3dkxBQjA4N3IzaUJQ?=
 =?utf-8?B?Z2RTNzRuODEyYlFEZTVHb1FrMys4YVNmZ0YrZzJab3QzMFg3MFJqdW1XdzhN?=
 =?utf-8?B?MHpTakJrNDRIRmdtbEQ4SnVseXFWUnJyRHhwZEFSRGx0YW9idUlZZzl3T0Qx?=
 =?utf-8?B?blcrNG1rNVBUcW1TOTM3aGRQUmdjMGh3SXZMYm5VbDlDQk5ZTWFNUUcrU0Rr?=
 =?utf-8?B?T3U1T3ZlYzRqQVRUUmZFUmxKbW5PN1VWT240aVRtb2lkNm1rN0pzVGNEN05E?=
 =?utf-8?B?RzZmOXFqejE2ei9ZOEdFNVNMUEI3a0VBbzl5YngvK1JSdWpzVm5jNWNyaFhW?=
 =?utf-8?B?WGZrR3dEdlFNQStMN3JKMnlRVWNHOGR6WUV6Qkd0M2xXRmM4dXFSTElHQVBs?=
 =?utf-8?B?U3pMbG5FTjl2SW1Oc2JWdmJlN3d3Z3FkQUs4WS82dnJNTlBQTXd4TEJscmZE?=
 =?utf-8?B?ZWpoYk0yNGJaTTE1Szk5Z3h4aXRGRktDa1lROThtSEFXWUpmTi9nTzlQdEdv?=
 =?utf-8?Q?wflRsfXR5I7yeHJGvX5nAxeCAg3+Og4Xo3ePl8p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5819aa2-5b67-4ced-c981-08d91c6f073e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 15:42:24.9060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKR7hHmb7MZStlvCuyLC40SzEOsQnNWMMGlmd1T7MhEVlF8yxRSKE3eRRcTEKjTrnwL764rH6mCqYEz1anrgmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5039
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
Cc: nicholas.choi@amd.com, harry.wentland@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-05-21 12:08 a.m., Alex Deucher wrote:
> Avoid spamming the log.  The backlight controller on DCN chips
> gets powered down when the display is off, so if you attempt to
> set the backlight level when the display is off, you'll get this
> message.  This isn't a problem as we cache the requested backlight
> level if it's adjusted when the display is off and set it again
> during modeset.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: nicholas.choi@amd.com
> Cc: harry.wentland@amd.com

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b8026c1baf36..c1f7456aeaa0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3506,7 +3506,7 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>   			rc = dc_link_set_backlight_level_nits(link[i], true, brightness[i],
>   				AUX_BL_DEFAULT_TRANSITION_TIME_MS);
>   			if (!rc) {
> -				DRM_ERROR("DM: Failed to update backlight via AUX on eDP[%d]\n", i);
> +				DRM_DEBUG("DM: Failed to update backlight via AUX on eDP[%d]\n", i);
>   				break;
>   			}
>   		}
> @@ -3514,7 +3514,7 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>   		for (i = 0; i < dm->num_of_edps; i++) {
>   			rc = dc_link_set_backlight_level(dm->backlight_link[i], brightness[i], 0);
>   			if (!rc) {
> -				DRM_ERROR("DM: Failed to update backlight on eDP[%d]\n", i);
> +				DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", i);
>   				break;
>   			}
>   		}
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
