Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB90C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 15:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23432613DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 15:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23432613DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4F516EEC0;
	Fri, 14 May 2021 15:28:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F346EEC0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 15:28:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CA+jCJ3jmmNdit6zbLshvq1BxGYXSCacorM5/kefkOAic4II/EKeuK60bVyvFkcCDCtBjpIR3dPiVtvqDoOc3l1rBuaA5MDwRqOaZUAbXl877OBcsThSMMCEG3pVJHms5njixjsh+Nw8Z+6ho7QwoicVVJbiYIDggareZixDpPVd9vTCfvhMV5OQCYugccaibfJYqFCJrfHPxMiUVpuU9SgVWMDAe+1s6jQnKPjMdBEiUEKv1RwoWh8BlMyMyKckLPHB4pgNj02L23OOrmJ5vk9w2O9mHNxiTAI6e5o+Lhx4LGsWXmXTiX7ealiuCp0N0JZmXyIZcnkvdXMFph34TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDkTYx+N0WLcZRUlw6OPGMRFprZ5ZNZWMsENS0SIGKo=;
 b=UI9zu78FhyYP/VeJMjiyBFfHlEpqS6dwWYa11QYkMWz2etctlmFPtCl2sj0D1+8QRSJ98Eg35h0MwkjX8yytG5FkNg1vl7/k8vu7qGmvZbvZBtcaTaCAMZz5jPLFZ2erKrZ2+uPlrAFruI0ZNWlKAX/IvA0y8PFf1jkMFcyNalhNG/w7iDgx2tSRiYhISPx6f/eGCYZWrnr8xHavRyiLj5Cx5uP44ieDOA3CCEc5WRhTvpSUucBLb1ZEcRMjN/BZARRDc/jMkN2TFKwVlxn5LVNNaN/85H95HE1RqlDmLPf+6WaJPXMwHjzwLERnQ5rVhrSYQ8zXXM+P2YNkUAcLBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDkTYx+N0WLcZRUlw6OPGMRFprZ5ZNZWMsENS0SIGKo=;
 b=S4DOvsnXtSdYXxfxL2fU0wiHdtBhqnhvlyzzyEblQ8BLtrp8Ku2ZwPVCBg1EBFmQzMQOXPH/dhBtnv8YzKU8VvlHcXcI3lim9K67ZtACYMzk4XzvdRq3PyZ61skokXPLkArbrdZDuQJ6x6othH9iI/uAdcWV2ZSsxRdrqD/1qrY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR12MB1760.namprd12.prod.outlook.com (2603:10b6:300:112::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 15:28:01 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25%4]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 15:28:00 +0000
Subject: Re: [PATCH] drm/amd/display: Fix overlay validation by considering
 cursors
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210514114734.687096-1-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <857025a9-2ac0-ed37-bc9e-a2be9e1780a9@amd.com>
Date: Fri, 14 May 2021 11:27:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210514114734.687096-1-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN1PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:408:e2::22) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.37.165] (165.204.84.11) by
 BN1PR13CA0017.namprd13.prod.outlook.com (2603:10b6:408:e2::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.11 via Frontend Transport; Fri, 14 May 2021 15:27:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 807ed00f-9fe0-4ce8-ea06-08d916ecdbc9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1760:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB17601D3DEE7B4F63B86806438C509@MWHPR12MB1760.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:23;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9MGWdrxvuuUMWu6NPDmxh9RTpqibI4QN5WV780yzbdghBIcdMdIuaKsyrhMS37rnWA9xoB5ffVpadu9wR38Aeo5tNqMcpIU8Rg0Zjxm9tjIxFN2NZwpEDJ0tijxYs14jMU91nwWTknuUISuP2MvJUlOtX1chzh039FXzey33E1f2dmQdEBw12/IyBrR+rznWKux6+ootIi7Jd5yQR2OPlHJ6OQ1sKLk1y3tLokQTd9F8UliuEe7678LK+8mid9ckJHbZGfShfSaYSyOf/xzB9j5yzl4jZqCyGhURxVHoF4pBh5irpNd51cUaMpoclBtIel7HylVLgZXl5S7bqJa7LI26wgHa5aa5iyi0eUJHxGmDao6ymhq9ux4h0WzEuxo/J3s0Y+YQr7+23CLGt33zpi+1xoVBQteh1ZRlai0ywi6RvVhdYy5SssSU9pFiZZL9Ny0EYKBq4+vcfSudSvXtKMl4ccpT4zNCD7OCpqOO2QFemuhuzF+LgyRczbjxqTnTVhjzmRLh3Up6eUfOmxnFrUh6ugImLVbD4R8bgSGPFVA7eY4VxKgoGq+bWnz/bc1rwWFPh5L09Aki0pSojcffuw8hgD9LUC/XQwQAxfxC1h+pEjC3UQdBtTsswx/zqioMj0XBOjFYkuBntRnUg8PSJE2LlnSIfMbWzdam5MA8pgvEc4QyzpG7yoO25xRJFKqX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39850400004)(366004)(396003)(31686004)(8936002)(44832011)(956004)(8676002)(36756003)(6486002)(2616005)(54906003)(316002)(86362001)(16576012)(5660300002)(6666004)(53546011)(26005)(2906002)(31696002)(478600001)(186003)(16526019)(4326008)(38100700002)(66946007)(66556008)(83380400001)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MkhxRVNLalBHZ1lZbVdCTFlYTHBWSjltR1NCOTdwY2c0ZCt6eGFkSzlsNzhD?=
 =?utf-8?B?ZCs3VitEdXUwRDgxS3hiL3M2UzBJYk5PSFAwRVQyZHZsS3cxNDMzL0RhMUds?=
 =?utf-8?B?VDducUF5U1oxNmNTZW9VYzNyNWNySzlBWjk0cjloK1ZGbllPeXFxb2Y3ZVhW?=
 =?utf-8?B?MW5LbDBEdFh0alJXT21VS2ZyMzhOK3ptc1ZZbDA0dklqTm8zUTZaMUtJcDZ3?=
 =?utf-8?B?c3pHTFREQmdQT2xPR2RkN0p0MWdoaVNQR05UeS8vbE95eFFUeVZnUlV0YUw2?=
 =?utf-8?B?ODJMbTRQamZIQ21kbW56U3UwOUxyUnY3Z3dSMkpVMGtRYmVjRjNLRE1TdkZv?=
 =?utf-8?B?Vyt0RG0venZ3eXdOcCtTMWlpNzZla3pKOVZsY3R0SjNsUmR4bDJCQWNBU0Ex?=
 =?utf-8?B?UGVtREZVOFU2WW94WUJ5UEkvK0tDK3M5c0RhRHVxamJzZ3ZiQm83N2M0bWtN?=
 =?utf-8?B?REpDekpZT3hyZFJvVHp4Nk9mVGo5MVJZYUZHeFEwcDZuOFNWdWkxREMvZUJV?=
 =?utf-8?B?MTZ3bWJXOHRqQWFyNnkwdTlDM1NkWTBRUUlCYTFmY09HTDVTWE0zZ0JFRVZw?=
 =?utf-8?B?V1YrNGVNRGZnbG1JZjdUQStOeHg3dHJnZ015UG1oZ3RtRXZjQW03OTJBaEp5?=
 =?utf-8?B?VHhlMnhLRFA2UW8rc21rTU1vdnlzYzl6YUZ1TThCb1BxSzYyMjdPQ05aR09w?=
 =?utf-8?B?QUpsQVhmekc1L0hhR3JRa2FaSitxYlREL2grZWI5K2VqdmlqWVo4eHJISU02?=
 =?utf-8?B?Q1QzSlZVRXBpbm9yZWRnMU9hSmVucW81eGxqMHFRM2FxUCtSZ2wyb0Q2V0JT?=
 =?utf-8?B?dEJDRmNYNWhMMzNDTVc3NkJlRzZBci9LQVRTRDZVNHFpekN1WllDNnVwYjdj?=
 =?utf-8?B?UFloZHlkSFlwZi9FR3Y2RE1IRUwwVWRZN0hxajJESVJ0amM4YkZYZ0VJcXZS?=
 =?utf-8?B?VUFuM0dRaWdIUU1PRmJ4cXhPQW8zRDJialBEM1lwazcrUlhkMFdSMzIwd3Zu?=
 =?utf-8?B?eVFjZDVsaFJWTWpEWEpQSEw2V1ZZakJHbkJrVzdaUVUwRkVTaE41OGgvKzR4?=
 =?utf-8?B?dDN6K1p2VW1UdzNOcmhMOXV6TTEwWFdUc2NkNksrT1ZUYUcvNEFldkNUVUts?=
 =?utf-8?B?TFJLOERJaTFvZ21hZ0xwcXNpbzBGRnNhUXc4Qjkxa0xYTWFmazZZQU14dS91?=
 =?utf-8?B?WThEN1IrVFljQ2JSdGYzUUc4cFZjOGpTOUlpUFlrNkE1K1B5Yi9CbnM4R3RR?=
 =?utf-8?B?UEloejlJckhQSnNuN0JoMmRSOFd6dmNYZEJEVmFLWVdpV0ZHTnBQMDhzVzMy?=
 =?utf-8?B?Nm5ENEF0WDArcjZpNWJ5bFVKY3lNSkprakFZbWRURGpSZTg0MjErT2hKeHJE?=
 =?utf-8?B?b1BwcVNzbVZXbUQzclBKTXE3ODZ2Ly9KQUQyUjBWUWVLY1VqNUJBTzBFWGs0?=
 =?utf-8?B?enVLZ0lHL0YzZjBZME9DVU5nc0ZkdURxNkNXSlFtTUI3c0VKY3BtRkQvek9T?=
 =?utf-8?B?K0Q3M2lRcit5TjZDMGh4U0hUUjdsSms1R25namlmelpRd21QOUV2YnJGSFo4?=
 =?utf-8?B?WVRsNGRFR2FpQ0wxZUYyVGF1QWN3QTltbE5vckMrSVlYdFhna2MyUWc3VFls?=
 =?utf-8?B?aU9LY2xJbDFWd1RVaGxxaEJxbmxiZnFHYytJcGFlem5JRmtnVll1YjlkUTJ3?=
 =?utf-8?B?STNpNkxEYTErOFU4aVlMRFUwZGR3UnI5U2ZtSG91MFY1alFlVlQ2NHptR0Fm?=
 =?utf-8?Q?4Ya2dl+7whkWIvY5QKosinlpLDyqIgjgRIZYbbm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807ed00f-9fe0-4ce8-ea06-08d916ecdbc9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 15:28:00.7561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUdva2Z5v81FL/Zws16k8zk4MBWOOg8jRPg+6N1QTt2ZkquAEnpRP7Jrrfrf6FEJPj/VkB8cjw/j4vLnDlJkWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1760
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
Cc: "Tianci . Yin" <tianci.yin@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Nicholas Choi <nicholas.choi@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-05-14 7:47 a.m., Rodrigo Siqueira wrote:
> A few weeks ago, we saw a two cursor issue in a ChromeOS system. We
> fixed it in the commit:
> 
>  drm/amd/display: Fix two cursor duplication when using overlay
>  (read the commit message for more details)
> 
> After this change, we noticed that some IGT subtests related to
> kms_plane and kms_plane_scaling started to fail. After investigating
> this issue, we noticed that all subtests that fail have a primary plane
> covering the overlay plane, which is currently rejected by amdgpu dm.
> Fail those IGT tests highlight that our verification was too broad and
> compromises the overlay usage in our drive. This patch fixes this issue
> by ensuring that we only reject commits where the primary plane is not
> fully covered by the overlay when the cursor hardware is enabled. With
> this fix, all IGT tests start to pass again, which means our overlay
> support works as expected.
> 
> Cc: Tianci.Yin <tianci.yin@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Nicholas Choi <nicholas.choi@amd.com>
> Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Cc: Mark Yacoub <markyacoub@google.com>
> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
> 
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ccd67003b120..9c2537a17a7b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10067,7 +10067,7 @@ static int validate_overlay(struct drm_atomic_state *state)
>  	int i;
>  	struct drm_plane *plane;
>  	struct drm_plane_state *old_plane_state, *new_plane_state;
> -	struct drm_plane_state *primary_state, *overlay_state = NULL;
> +	struct drm_plane_state *primary_state, *cursor_state, *overlay_state = NULL;
>  
>  	/* Check if primary plane is contained inside overlay */
>  	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
> @@ -10097,6 +10097,14 @@ static int validate_overlay(struct drm_atomic_state *state)
>  	if (!primary_state->crtc)
>  		return 0;
>  
> +	/* check if cursor plane is enabled */
> +	cursor_state = drm_atomic_get_plane_state(state, overlay_state->crtc->cursor);
> +	if (IS_ERR(cursor_state))
> +		return PTR_ERR(cursor_state);
> +
> +	if (drm_atomic_plane_disabling(plane->state, cursor_state))
> +		return 0;
> +

I thought this breaks Chrome's compositor since it can't handle an atomic commit rejection
based solely on whether a cursor is enabled or not.

Harry

>  	/* Perform the bounds check to ensure the overlay plane covers the primary */
>  	if (primary_state->crtc_x < overlay_state->crtc_x ||
>  	    primary_state->crtc_y < overlay_state->crtc_y ||
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
