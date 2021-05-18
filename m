Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46954C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CEE960698
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEE960698
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04296EC06;
	Tue, 18 May 2021 15:52:24 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 947536EC06
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 15:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrB25o2D/d/9Uo5reNsTbGtzibkcdlZiCpDxPFFKl3TEBWnMoKWuq5ey+zUXup/652hzLSktso2mJt6CZtuhBUH4uY9xOV3jTurCoZgikFgsaAD7CCNGDwOkXopBJzwO7t36ROZcg0HV1YmIBsOn1Olxv6tvhJyrwCpGF36y/gyBGFcIY+9GuerJbygx8MPo263f1Al5SC4q6N1YLovIsWnlhXGY8QM2HojXvKcqh0i2VIJHdPSgH/xO50FAS+wFmMykgoth99sJ+lCCRCrQh98EU9mpU1R33rB0c3an7XAKzgKWvbYdKJaABrv5+4u+d0mlbh+WJBHFSxLk4XmwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtUrOiwo4iuxLscaGPnjrdX099zd1zzbncugJIZLN60=;
 b=PcljDYIMEsczCphg3TuGUoxevz8e1eLEv8QRr7xPgkQt3OwhULVtp7/0JZC9VCJCyIXPyYU2tBTup7SgBgI5/ULGXr6Ci0BDXjYurDxPzCzpmWD3BUMcfs0LGzQ1hzhBxyTqVloiA5a4TsR2zHJpWx87TYgF9LFDg1rN5iDbiIaeuHq3nbw5WD/5dQulDPflcIETtiaAyToUOVrD53FGU0MdhpuOMMSEzD73OvOQai5fH9OvOpkHkpz+pdOuOAAjtRGGYPKCJhBpFv8uwFHVXwo8p+RPbdHdLWmQsDwrTFB3NGyoIZkTb0vQb+vHY7OzAjuhsbIRa+DB63bCkNl62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtUrOiwo4iuxLscaGPnjrdX099zd1zzbncugJIZLN60=;
 b=EedoHjIfeNzWznQGeX1TFpjRaPzZ/+9ENHWWHh7ZNLlHXdhUo0VSaTxPnHSyNT0SBoTMPuQsVDh6DwZqcaT1S9maaXGzx2B2fMYRvcMeUWr3mADBwnTVUoWOONjjxgFYJHo0T0Xs7m1TRZxAovotP15a+flfxcYQqV0xXWIgXhA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 15:52:22 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25%4]) with mapi id 15.20.4129.033; Tue, 18 May 2021
 15:52:22 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu/display: restore the backlight on modeset
 (v2)
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210511154411.1281317-1-alexander.deucher@amd.com>
 <20210511154411.1281317-2-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <b8e89353-82a2-5798-5f76-1cfdaabf322d@amd.com>
Date: Tue, 18 May 2021 11:52:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210511154411.1281317-2-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YQBPR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::32) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YQBPR01CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Tue, 18 May 2021 15:52:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a19076c9-868d-40f9-5181-08d91a14ec79
X-MS-TrafficTypeDiagnostic: MW3PR12MB4554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4554DB3D83504C2C4115FF488C2C9@MW3PR12MB4554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:407;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Awv/F0ua3nK/ZqV3YqaWR0tQ07xTxkOMfU0w9bhnZexBMAXazW8XljvmOe7f2L2aLjyNWoraf452AVWrToyEMKMHi5gRtP8Urjy2rOwAIXMlGvNJTJA6X6GalkZDF1xRHNl+xrrb2Jx9BpbEegPZojcXVKwXUcEOxdf87ORG0Z2kByL0almb/5cz97vZnSaHafEo2/Eime+dF1qI2HjXTfvwXEJeL4uGPYhWe+6LoOHxVVq0fbdc6FsCH6v6vHSvVBbsDz4I/OSH+vsOJdOhfGjdKhEQJlhPkGwDyK0HMZ6NuPcFtzpCA/WieB2f8u68Cs1sOnOYjzXkYD194R2W9F7TbUMHSCulNbFDdr3JQong6fGnpLF+KGUOtAo+LaZTTUcZdYm6ylzVhQqd/37kH41gPWKiahF9QGO5vA4LDKHwWeuDzAdQ3YTqP8svMnK5kv/5Dt7miIEaqKi/brWUomeRYsUkGZYY82G8CMYm5XVytphWboPjdB/FprY/DnfpYfpXdKhvohrSFIBb5TacIq+jrZxrj9iYoIZfj10k85Lz3u9YmmoEbVa6cWyP+S6x4Gc93PUcVoh+qgnCvoMRUZjiLRS+823SZ8aA/Zoe+ikOaqWwIijcA0HM+pQ2QjSLDlt8/W2ha1bYynJwy21wxSWDNROBETv1RfqWV2f5di+8MUS/bsEnSyE/njiU/6oZsQlIAGVgIILDaBKBUkcsSIKZv+7OPiG+/S5nOZax8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(5660300002)(86362001)(53546011)(36756003)(83380400001)(26005)(66476007)(66556008)(66946007)(316002)(16576012)(38100700002)(6666004)(478600001)(16526019)(186003)(8676002)(31686004)(44832011)(31696002)(8936002)(6486002)(966005)(956004)(2616005)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c01UN1Rla0hmY1pibUlVVTFzWis0REZtNkFmc3lhNytKN2NLcGJ5c0RHTkNM?=
 =?utf-8?B?VzhYR1N3dFBhRmNrVHQwSlB3WGoyalBEY0ptTHhFak9wcmQ4Q0Y3dWFNeTI5?=
 =?utf-8?B?OHZqVFZHcjFjREVoTUt2OFBoZlJ6MjhJMTh6VjZKYnNGWmVINVVHWGZ3ZWhi?=
 =?utf-8?B?Y0Z2R1ZINmtsRGMzZXh4UUtIamZBU3F0QmN5RGtjUXVDdSt3Y1czeEthS3Ix?=
 =?utf-8?B?R1F4SXU3UlJNSm12QWJHa0tUQlpndUpIdnNJM01EYWRDNzF1WHZsbEtLa1ox?=
 =?utf-8?B?MFRiaURrYXZKMWxqdGNPbDZuWS9ZY0lOTVZuK2Fxc2FZb0xYeHhVM05UVlY0?=
 =?utf-8?B?WTdjVGErY2hDNzR2M1h2MXozOUN4QlZ5TDdtZUxqMTZUWHR0ampYeXQzSS9N?=
 =?utf-8?B?TzBOTkZvRlk3ZlU2dFdKanFLR1NLU0M5c1oybHB4L21mbGRWQ2J2SzhTNE51?=
 =?utf-8?B?WEpKc0JCblFTQjBUUzNLN01TTVBwOXdOdzZJbVpmVS93VUJTdnFwN3pWTHNV?=
 =?utf-8?B?U3pERXZ5LzM1eTdjZ3FDZDlQNGxpVHhYYVc3aEFiZ3JabjB4R3JvNlBNUzZQ?=
 =?utf-8?B?cDhKYmJEd2l0VFprNjdGLzFYRTVQUm5Iak4zR1p6VUtJKzlKem42WHNiVklj?=
 =?utf-8?B?Z2UyMEZRTGNIcDd4RWwxQTlRWDBxZFRuQkJScmNqamZ2b0FFT2hzQmk5Z2Ni?=
 =?utf-8?B?RmtHckg5S3dTQkhlVS9LTHZlL3hkWTZtd2pwUWdTUExXNCs5ZmhFbUtlaWFv?=
 =?utf-8?B?QXJNa0I5R3lZeGN0bm1GdWxSUVhwUzh3OEZUcnhaYTRsYkdYRUhVR1BxdmJs?=
 =?utf-8?B?bWtHTmtOMU1lUTc0YnRYY1hxYnFoaUFNSGtlWENrWUVDdUhzbHdzN00rYVBy?=
 =?utf-8?B?dksxckhNYjJHM21mTHkwM3JuaitMbU1waWZUdEh6dy9ldWswOTlhTkJWR2lr?=
 =?utf-8?B?VGlPNmRHT1UvYmxtNm5mSzdnbUJVWTlMTnRvcXdlNHVlSEYrU3pselBiaExz?=
 =?utf-8?B?b1ZiYWNLRlRiaUNCd2xFT2xmbnM0SDFuYWg2Z3cwQm4xNzNyMzM2V1B5Z3ZH?=
 =?utf-8?B?NHlzYUwycEYwem5IWWhJelBDR1QwYzZkUm9wQjBkallGTy96b1hDMTZtazUw?=
 =?utf-8?B?U3RSa1QwNURhUHJOaWtBaFgxRWhJa3NrODZtc0V4MGxVa1J6YTlDL0hmU05x?=
 =?utf-8?B?c0wwYXBsWWFDd3JCL21ZeHdRamhxRktmaStybHh0RnYwWndFWjJLVTgydXFN?=
 =?utf-8?B?Zk1wZmFxOTJOS2R6WDBGQXJXNGlUZ3ZKaU1pNW1qOW9CSDRsTCtyMFhJMGZY?=
 =?utf-8?B?TDV6YmY2aFpCMlMyMyt2blRJb1NTODVvUVJ5QzN3cDZSWnZvc0o1Skloa2tk?=
 =?utf-8?B?c1lKekJ1RWpGdHFOdmhKSDVoVi9sTXg0Uy9uQWNqcTNLSS9seitnd1VXRm9J?=
 =?utf-8?B?ekwrZzl3c3E2cW1Gblo2ZC83elJVVlQ0OG5vUXYrMC9BTEVGOUJGeUVHeDhk?=
 =?utf-8?B?ODVLdjh3R3FtOXIxbGtZeHQ5dUFSYk4rS0haMmRDbTYzdklHZkVRbzVZOVRT?=
 =?utf-8?B?aVZQSXRMOXBQdnBHdzZlT0xEanY4TzgybjVvUFNaMGJodDhKVGN5L09EdzBs?=
 =?utf-8?B?MjZYUmF4TzZyZlpHQmRkZ3BTNWhtSEUzR3p4S09WNjg1QTJCektnWGtSV2tP?=
 =?utf-8?B?QWJ6K3NCMVNNSUlrajJUMktJWTVhS3ovZUtsRTRBRWpURmMzck96ZkpHMjFz?=
 =?utf-8?Q?TICbW2CHwb1APC6peTi9A6Cx+UKijFi9UZYCJYy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19076c9-868d-40f9-5181-08d91a14ec79
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 15:52:22.0370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gd0jvJcbHhlX9JfTyXK/RAhbSS9k0d02LMoxKIudKs1AR+7V947vun5pmMf6hfoo2ba8IOdGBAsfwSNxa48ieA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4554
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-05-11 11:44 a.m., Alex Deucher wrote:
> To stay consistent with the user's setting.
> 
> v2: rebase on multi-eDP support
> 

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1337>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 167c8759fbc9..979e4dafa735 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9075,6 +9075,12 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  	/* Update audio instances for each connector. */
>  	amdgpu_dm_commit_audio(dev, state);
>  
> +#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||		\
> +	defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
> +	/* restore the backlight level */
> +	if (dm->backlight_dev)
> +		amdgpu_dm_backlight_set_level(dm, dm->brightness[0]);
> +#endif
>  	/*
>  	 * send vblank event on all events not handled in flip and
>  	 * mark consumed event for drm_atomic_helper_commit_hw_done
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
