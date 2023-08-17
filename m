Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE012C2FC29
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 13:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D557B10E487;
	Thu, 17 Aug 2023 13:44:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 867E610E055
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 13:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OakUDiI6xalkficlzwXHbJipSebJTqj6Wr+ZRLHtioo5SllywxyKewhdwUKb7zxnF1rY8ESO09yxZfEt1Sp1CH+9oEnl6+FSoc2VUqKR6O4jkeSDVNpb6yMIzfu7We5bjlnH2agI+kg8asA+RE+xlTxNjay/rii4cVNTMVlAyEMGjksD6gCnGNHvGRNQ7s76Jb/V6ze8c94ZhPb1nYeO250m9+mAmG+nOFhnBUhCPVJS1W4/0T+53x4slZcOUQLsHvCUTc0oRagW2zArNmNhYMgrNW3FrcO8Jkr683eX7mj5ulIo6ET6jHi9Rm5m1Q3RvjpvwuzOaQc8cpUMBZbpbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyXnNce6ZJLG2ENXqdNbkXXzBEZB55vGnxr3JjWR4Ek=;
 b=oZtxsm7vwqQA70Q5PmTmGvPFxgNq8mj6Yx98qjyxQn0fq0yUuzlUKGn4qjB5M3DCPR5pCfULzQHFn5+DZpHfonLbT/YNABMePEHzrGhBENeDQsuYbBG2B3nv/FMqKtHwy0VIwEAd3d1mO3fF2NRRq52KY6cPQWbzZ2gpWVfIB77T4Xtk20aeR6/4AACOz2Bj2ghr1Y8SWD6DDIQQ7Zll7Jjr/SfCYFtcRmxuyplmMmUtcxp5wKdBXLq0TLVsI9KIA4H6m+0gTbUnF9qKYIS6obwFo6G0l6B9zPHiQMlVrsZvmhxUu7m1yWYKtN2c2aG4WG5Ukg441d+XGOg6VTRdGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyXnNce6ZJLG2ENXqdNbkXXzBEZB55vGnxr3JjWR4Ek=;
 b=BTrnB/oIoYjBaH+dbMeN9GhtY0VLVEinfH0tVtklkGUpl3tFzovVKPUU8DiNg7xUs6GOXCeUy29cuE3Z7ziTlBA/Se2d4S6l9GytNHpp4iCG6Csa1MgWP49xxzHI/bROCSV+IHQIpv8aid2ll7017w6nOTYh0HdSyz4Rq/+1Mmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 13:44:47 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::236b:d4e2:6fbf:6c2b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::236b:d4e2:6fbf:6c2b%5]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 13:44:47 +0000
Message-ID: <13e88b5a-9db5-4a21-97ae-3bdc910456dd@amd.com>
Date: Thu, 17 Aug 2023 09:44:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] amd/display: add cursor rotation check
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org
References: <20230817105251.103228-1-contact@emersion.fr>
 <20230817105251.103228-4-contact@emersion.fr>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230817105251.103228-4-contact@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0095.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::29) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: eb782162-ad73-42c2-d405-08db9f281ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fb9Te/sMyjRUJT6Wcnj4cpqAcDIYdBNXntxliDsq6DCAYe/UKw2m2aM54HVadvxDKz9d440NQ/vaBF9Qq7hWJ4BRbeq6yjo6uMiKI8VMz3OSyIQ2N0kJ2Tigob1myZTqekSPtduJpl6TYqtNd0vSHfl3VAig6H7A+25ylfZ66ann58CSPMYpZ+U0+bqFzF+S5+U2DzaQR5rep36vYuThP1E0WJtzTs44yjjZH3WEa34iXwqmHsnTLr+gx50+CK3hzLBPFqAs4QRyokUyTDMqnXPA2fQySnYvK/eYOmZz7FiFfypUHDR1vGFshqyJEL7/kJd5N7UGK9bfSCLn+CXZex07gCvaqypu0UfCeJnDzXGY/IA42sdTJZIHZXaAEkzXzqbFOa9cyoSxby5xmbHlWBvmlROuNeH500GTBf1sV5iQjQImJaM0cy/lPaDhnNsjbPI/vm+fnb4tS/aQjECjZA6zxGvDAGmNqHVTxkDaxnfloDsKZWzJMsTI2yAUNnC1eksIS2Tbhhah4zf6DVUyiHmz3RF8doMAKKFdnWQOmvNFaYcStXWKuGzmI+cbUpZKUugvoiGwxvwwTgGQrU+0C7g9ruNuJJvXipPBq3qqia7ROTpiyneGoAxYWNveNRGWEKaaTCpCs9nblX9oaqPJXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(31696002)(2906002)(26005)(86362001)(478600001)(6506007)(36756003)(6666004)(2616005)(6486002)(6512007)(53546011)(44832011)(5660300002)(41300700001)(316002)(54906003)(66946007)(66476007)(66556008)(31686004)(4326008)(8676002)(8936002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckNVbTdYOS9LeWhJK2FRWkdVeUJpMnpyTXFlV3hXMlFnMUJvZHE0NEZJYzhk?=
 =?utf-8?B?TUN6aE9JYjV1U091dWlObWUxakRzaUQ4dXN2dGRvTVNIaDZkVU1MZVV1V1ls?=
 =?utf-8?B?Z2lMc0NZQlUrYlBXK0JPRlkzOXRHUEgvVW92THdJa2hMT0hjMnE0cmR0NlBN?=
 =?utf-8?B?SjJ2d2RaaDZLNTdyMHAzNFFzdzBRUjR0eDVyL3A3UG5vRzV0TlhManhwR0dC?=
 =?utf-8?B?RXpNTkVoVWU4MkgwamwxOXdvVzNmWmdDTTdCenMxbmpGNFY1NmdnOG5KdC9R?=
 =?utf-8?B?N1o2SHJsdFkybnBYb0M2eXhFYi9ZTVJjZHh4WXdOaDZyV3EvZGxNWkdsWkJy?=
 =?utf-8?B?U2dqM3V0TzZxL1FpRXpjdTR3UkNUeEtlZ3cxSDB5TVFvdE9FNTVnT1prTk5O?=
 =?utf-8?B?NFJnbFFRSWh0Tkp4QU9pQjU4RFFVWllMZE5iamRSN0crTThha3hsSjhFL0E0?=
 =?utf-8?B?YkFKckV5eXNkcHhJZ0VTRnFManpGUXdoUHJJcUFHNDd4alBsSlVld1E5QTBL?=
 =?utf-8?B?bE0wemx2L2lCQkJHTmVaMDJDMThJOFU0WjA3YnlTZ0xOU3d0ZmtsMnJvUFRi?=
 =?utf-8?B?LzRNNGZFRzV5aU1nU21MWUM0QktmcTZmMkNxL0NETVJleDdkNE9wVGJNay9S?=
 =?utf-8?B?NVlOancrQ0RxSm5lblp6VEQxTUVjUnFna21iQm5ZUnRycTYwMEEraVZ6ZGY0?=
 =?utf-8?B?TmN5TFI4WXVzeUg5SXZlRFVwdDBsa1k0Z3JhdzIzMDZ4K1F3WlMrSUFYdjhU?=
 =?utf-8?B?TCt0VTZGdnRXa3VLTEE1dkEvNjhIWWRlbUlxVU1UdUVrbzB5eHErcFFENlAx?=
 =?utf-8?B?SllUaW5kdkpCbDhldjAzTWU5Mk9YdHY1c3RHemV5SnJZVC8wQi84N3pMS1Ja?=
 =?utf-8?B?dGYwOEVJdk1EdzUrYy9DdFU0U0RIRmVCYTBEV1dOYjlybVM0cjFKeXFhdXhS?=
 =?utf-8?B?YlJjSXFzekRKclBVMkYxQUIydTNOOUhkWDJWUzRvdklYOEpMM0tEbENvZ3gx?=
 =?utf-8?B?WitmVHp3WjREOG1lR0hKSmFyRy9lY0h1WkxFMEJKQ29GOERtSTF2dWxOWWJi?=
 =?utf-8?B?S2VJcEVaLzVFMjBvTUJBNVQvSzZ6N0pZUmtiQ2w3cjQ2WTVsWCtKWXAwQ0kx?=
 =?utf-8?B?UkNlaTJnbUx2akhGRTdsVEduWm9wQVNNK1lRRm9Od2RKVW1VdEJOTEJucjhQ?=
 =?utf-8?B?azZaak9FOWNtSXRMVi9pTGU0MFBBN3BaOXBXQkxqeGRKL3RQQ3pkMXk5ekg2?=
 =?utf-8?B?TW5pNzM1SFM1WWdoVGRlYWhDOEcyQVpyams2MGZvRzNYUGZTWmVGdDZITVNm?=
 =?utf-8?B?TUU5K2VVd3ZvY0FMckZ2R1ovQmNRdHd1L3lnVFhyaTlmZTAvVVBzdW1xM1N2?=
 =?utf-8?B?SlNDaVFkSzM1WTB0TGpKU3N1SzVBVDc2OEpxbTk5TEdPMFZtZGRyWnRnMkow?=
 =?utf-8?B?WlpVeGk2YU1YdjJOMU4wNGZjQnl3Wlo0K1FKby9Fa0hOaDQrc3dDQUgrWkJl?=
 =?utf-8?B?a2VkZFNSZmFTTkV6aFAvcWh6anZRYjc4L3UyaGljQU9FVXJPZ3cvVFplMFha?=
 =?utf-8?B?OUxQR1I1TWNORWFIa3ZKRkVCalhGaHgwbWVDVWIrTUxIS041TkROSURkNFRk?=
 =?utf-8?B?RnJOR3J2cENLY1lyN0VVdzRFS0U3anpablBUenAyV3V6cWt6NFZMSTdiU2hF?=
 =?utf-8?B?ZzNoOWRicjZxcHBHbGxaK3VoUmF5R2ZUZDhQTzFCM3pqck9kakZFc3NGdERI?=
 =?utf-8?B?dmNTN1BIcE5IRGlFdzdxTHgvakJQb2ZUR0JBS01mdHBQNHUrZEp6cHo3cUpI?=
 =?utf-8?B?QlBxbnAyM1IxM2gwbXZ2cmFyYnQ0c2tFNUpLN1ZmQmxnMFN2VmY3a2E4eTNr?=
 =?utf-8?B?ZXhvWnN6NFMrejF2SHZUOFhXOGRkVnE5RVBmVDUySDVTc2Rkay9KSldLbFpZ?=
 =?utf-8?B?U0dDbHRrejVISmdTMmFBOHdBZ2RVM2ZBT0U1V21adlROci9ZR3BaSytwR2s2?=
 =?utf-8?B?UXM1VEQ5YndRb1prK0RhMTFUekFaTFpEOG91QWhkeW5KMFg2VytKTzYvQ0tN?=
 =?utf-8?B?bEJwK2toVnBJQURuQVZibVBlRUwwS2FKdmZ5RmlXMW5BUUZHVm1DaExLQWl3?=
 =?utf-8?Q?LoQpdueS50YqPC/qE/zglFmf3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb782162-ad73-42c2-d405-08db9f281ec6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 13:44:46.9013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9eifTIADjxK8BFT5f7R3sbnmACYvUvSRFn9sHiHdRJOWXVRroEWa7MqDzl6xjchWCskAkpVBxUbqTKLc+pP1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-08-17 06:53, Simon Ser wrote:
> The commit 1347385fe187 ("drm/amd/display: don't expose rotation
> prop for cursor plane") removed the rotation property for the
> cursor plane, assuming the cursor would always be displayed without
> any rotation. However the rotation is inherited from the underlying
> plane.
> 
> As a result, if the primary plane is rotated, then the cursor plane
> will incorrectly be rotated as well even though it doesn't have a
> rotation property.
> 
> To fix this, check that the underlying plane isn't rotated.
> 

HW cursor works with a rotated screen on KDE on AMD HW. This
looks like it will break that.

Harry

> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Michel Dänzer <michel@daenzer.net>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index df40f74f5a15..aba01255ba12 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9867,6 +9867,13 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>  			return -EINVAL;
>  		}
>  
> +		if (new_underlying_state->rotation != DRM_MODE_ROTATE_0) {
> +			drm_dbg_atomic(crtc->dev,
> +				       "Cursor [PLANE:%d:%s] can't be used with rotated underlying [PLANE:%d:%s]\n",
> +				       cursor->base.id, cursor->name, underlying->base.id, underlying->name);
> +			return -EINVAL;
> +		}
> +
>  		/* If this plane covers the whole CRTC, no need to check planes underneath */
>  		if (new_underlying_state->crtc_x <= 0 &&
>  		    new_underlying_state->crtc_y <= 0 &&

