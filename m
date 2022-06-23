Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B4AC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jun 2022 13:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE7E010E771;
	Thu, 23 Jun 2022 13:36:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82BEE10E771
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 13:36:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ky7RMEW6ieqT7oqD9VVKzheHP6QTkj4aJw0UA+MxuFuneF7Zihz1KQiumMS6Bv3vfCaxzMDyrYUSUuE1wpgl8c42QeeeS82n6UsZsYxxaSA00fSfgxDqtoTkwf6TRREnpuOlPSGBF78GHdEk1ZoEm5by/lE8e/McJb1lHzxpbqojyos7zUoNc9zcceYVMLcoDWs/L0WxoGZflXatZcPan+fv/oSnEorvLfZQfK9yZQ8s5i4CUR+FOWHZWQCeU5GOqPuPbZ7hpE9SDJv4iCGrkQxX8OnK4ifMO3tSOsw2FHIjKGeYHfo4nsx06jqTzwv9Mup4VI/FESb3sMGeWBeZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Olh/0H/0s9/1Y43XRWzsZDk/K4bw0hi7FYYLCLqJ8Lo=;
 b=LSQ+aCsv4YqMA8r8U4OGS+UlyYj6aRl8iwkp0VZhEczOxdK+cmvW/+ezhlWNcckFSEuFZfwfc5wCeuWrG5Zeb/njrWiQpK9fnBB7NGYn1/DtryVtRyVPHq9pdHs3SZDhZwO9OBMf6hC3qpyYwe4ktAsKNXqzsS+dctRHgNKb1GSZAd0MiboWhH3odveS6B2yf4leewZRVQiI3CuS++gghMBarP9ZgEMfFT5ztUwx1n8JxrwoMaK8dTcVpMZDnf/NRoKwM6Dp37HZkXPQbZA9nq5I7gtptG7zsiDL+5vLh5FYPE8Qo6sTVpGXzs3HVsWOgzNAamZWbUZrM+q1aOgKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Olh/0H/0s9/1Y43XRWzsZDk/K4bw0hi7FYYLCLqJ8Lo=;
 b=3ijVnBBR+qfnO3bCr9U7mjMuSC40I5MnwcVy6+f3IA2XTxfX27qz2tO8Vc/klETJTGktycWGFvgIBTlPNjGhP65XbHcUZus4k15N5U7pXPMccixW0GWTxTbrYlVA9lYwpm5BhTNNY17CYb4WZtr8qB7qmri+3ZuNNQA7A4zuBVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Thu, 23 Jun
 2022 13:36:28 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f55b:be13:11c6:d9dc]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f55b:be13:11c6:d9dc%3]) with mapi id 15.20.5373.016; Thu, 23 Jun 2022
 13:36:28 +0000
Message-ID: <36774b6f-0cd0-0141-42ee-e6c605cb2e17@amd.com>
Date: Thu, 23 Jun 2022 09:36:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Revert "drm/amdgpu/display: set vblank_disable_immediate
 for DC"
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220620223835.1038109-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220620223835.1038109-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::20) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c45dc3ee-3f37-41a3-e661-08da551d602c
X-MS-TrafficTypeDiagnostic: DS7PR12MB6335:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB633573D670ECCD82231C11598CB59@DS7PR12MB6335.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQagxHhv+XcgaFcqSey0ozNHuem2F5aQTdN9+GluMy4jJk42x86dwSREpvAmXiS6vHxFL4bFZtY0LkoWQtzIe/x3icxT+u8dYbwsljmXz025XS5EL1Xo8+raZEgucUWVxmuUQ6dTwU2wzbkLQSIL/6BQ55JuGOoT5ESnTZ2lm3QjY8RVW8IkDCKO9Vk62tso6wba1W9O44xHBCfQY1D+ozMmHXpumkuw8SG7Dwhx3BOCyuABZsVbjd2P7tpUpMetAf6QS/y+A2sc3v27a0FrphlgSs7srunkcXZ/AuQLGwBRlTJ6QvBsQ2mXa+rEvfutWKz4w99nqZUeDgtLn+1K4GKDMXORq8vrrY3jWVYizC8JmZqLGlsznOphdYQznaM7vG9mVY5+9xUbf1FDm3Vx5jpmBx+BEfi9bL8YjLGtM+nu08ifL5Weih/fG8fU4iQ9LDg7F9v7jb9L/SaXJ5kRRKiG2hjiYvLNzk/PsASutccbuA8tGaIrwBSCkMIhv3kgXV2fpaQuTw7sSQGXFU43GA94mXE4VXgzcoGYih6Q90CJ2l2egu36K+muUI3iYiZdrvQiBlmkCMdLWGZ9SOc1gIWX9eoOZ1ypMsns4tv3CYnwKFHdXM6E5RlEVHSsYP5LDRB7unmC/0y/lUX1bOoEeWeIuRbZRxQIi/Nj17t+KA1a1A3O5llEvNQcAsic7vomlAqIusJ8diUPCSaxIV6kZtHLNyIQ1SNFTW2G0mFGvmCuXSE/SytDh6GmuKNKP4vg6SqYGjFirL13MHZ/z9VGXaQRyykY3m+6B6On5eIfnMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(6666004)(31696002)(4326008)(44832011)(66946007)(8676002)(5660300002)(66556008)(66476007)(86362001)(8936002)(26005)(2906002)(6512007)(53546011)(186003)(966005)(31686004)(6506007)(316002)(38100700002)(2616005)(6486002)(36756003)(83380400001)(41300700001)(478600001)(14773001)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUI0L1ExZHZaUWZSZmhpK2g0VktId1pKR2JlMTNoOHM2MjhKSU1tTUovQ0V5?=
 =?utf-8?B?UmdMWi8wRTV0alI4UzdDT05EN1hDT2FySXlzM2RDQlJDVW43VzVKZGdaY0NQ?=
 =?utf-8?B?U1Q4UU9jaVE1cGI1aHg5d3RvT3BOdEgwM1ZCdFM1Z0pDVnp6NEFidDFDZ2p6?=
 =?utf-8?B?aTFNWjlzbGFKNGNadUN3cGpyOU1Selo2QmpWYjRQN016KzJiSDBLaXhGckdC?=
 =?utf-8?B?bGZWWlJFbDNpYnA1eDk2cDl6T2lzY21weVB5LzRpaVV3TWpqUXVxa2hzS2wy?=
 =?utf-8?B?aG41UFlvbDdTT2ZUMHJhNEcweHIzWVdRS2Rmai9GMnlvU2xlZUYzb05mVTZB?=
 =?utf-8?B?ZlovKzBBL3VzZkJRcSs2MEVPMUtyUUhXVGZHeWpIUUJCRGlSNS9pbzBOS1R1?=
 =?utf-8?B?Ym5TaWU0ZEpLWGVvZkFtS3Fjb1VJN3NDS2ZwNWVTYjdpa0dFOWliTUhSNU5v?=
 =?utf-8?B?dW5FK0VkZ1d0anhGZ0JURHA5bTQ1ek5IR1piME9PL0RRMnRGaGpwR3lWZHNE?=
 =?utf-8?B?SC96b0pSU2VHZUdUMDJ4eTY2ZzM5NVZrYURWMzJ6czFhYWE5MzNwWEx6UTVu?=
 =?utf-8?B?aSt2b1ZLdUxjd2wzRlYyMzd3eVNyYnRtUFFxdXZuWHBIdEQwY2xaeVQ2Z1hh?=
 =?utf-8?B?MWdWSmY4R1dQWWVoQnN2UFc1VjVOR0wrQjJLT2pteXpNVE5FMnlZdFVUTlkr?=
 =?utf-8?B?MC9pMnpKU1VhUGp0eWMzckhkM1lrZGkzYTV4M1Mzb3cvc0pJSUtac2FiRlh6?=
 =?utf-8?B?STg2SnpsSnV2V0I4RVhpT0VVVS8zaFBZWTV1OTkrZFNJYm9TTXpLY0ZQNmND?=
 =?utf-8?B?eHllY0lQNXg4UUxXRUlIamlkaU1wSzJRdjB1V3l0dzdEVEdFMThoZERIZEpx?=
 =?utf-8?B?N2FCaVAwa0FzRG1BcWtnVGFWbWZNOWJwVkhpVDE0dzBpUjI3c09oZjRnM0xp?=
 =?utf-8?B?QnJRbm5IUVZrV1dUK3VvNXNLV2lHc3lSZkUwazlicUpkcGdaVExBOGtMem1D?=
 =?utf-8?B?dUVKUWh0cFB1ZThldlk3WDN5QWRxdmpzUnB5TGVRY2VLNnJRSjIrREg0NW5k?=
 =?utf-8?B?T3RvNlhYc0R5YTE5S3d3aXZ3SmVVdTVoZitaTXdJcm5hbkMzV0ljZE12anc2?=
 =?utf-8?B?d0w3dDB2Nk9GeHRKVzNBT0dOeVBPRTlsZlpEdkxoWklzSnFySGR6ZDZzNDJa?=
 =?utf-8?B?TnFKYURLbDgwT3NkQ1ZDUjlsOW95NFJaSDF6dThpWi8zTVNxNWRmLzcrczVR?=
 =?utf-8?B?ZXJlaGpUeVRYWk9ESzI3eU9GblRrckwvYVlQSWxMd3FkSVlpRll1c011VDha?=
 =?utf-8?B?TXZ3anplN2g0U2NCaWd2V25INVdyMFFZclhJcitiakhueGZoNDYxZnVxbFZ3?=
 =?utf-8?B?UVFwWEhyMVExVlp4YTBqVGQ1dEdvK2NNMEhXbGNkWEltK1dzbkUxbjdRMmZP?=
 =?utf-8?B?eE1PN0o5ZFAxTVZodkxaTU9mbzZjeVpBMUdzbVdNQmZtU2hNUVdFT2VKcTZt?=
 =?utf-8?B?VVBqelkra0h4cTlYMmJkbVVvblF5UHdaeGNRdmRCTEYzY1kwRkdwZ0kvWVFp?=
 =?utf-8?B?V0MvNGxXK29zTUg2ZFlwZnI4RjVUNmNtYnBxeXBvNmRiaHIzL1NyWDR1Kzc1?=
 =?utf-8?B?SkNDWGhuRmJPSkxmdFBhTTY4aHExRlkxNXVxUE5Pc3dFdElaS3NMcUZQUmk5?=
 =?utf-8?B?WTVybzNESW1GMWhsSlRLOW9peFBEWmRpQ1lweWhrYXZnNFNoczhVd0NIT3o0?=
 =?utf-8?B?SUw5TlExNE9VSGttM2tSOHJXaGM0M25Mc3dFT3pnMXpSWDFFMmFXaVlzQXMz?=
 =?utf-8?B?Wm5wcm5UZFp4eVNHYlhOSnVmZ2VpQjJRL0t0UXFQQmNqUmlBSklPOWozOGFC?=
 =?utf-8?B?VFB2WmZJUkZ4WDZod2I3TzkyWXRTbGh5akNPUnh5WGRRTzVWaDBRSXRZbk9w?=
 =?utf-8?B?Yjl5ckxhaUMrbFlqWFhUWHRFbERoNklCa1dPYnBsS3VrOWZqMVo4SzNEZ2FW?=
 =?utf-8?B?K1ZjMXJHMmQ5eUNZd3F5aEg3bGZxM3lISkxtV0dseTZyejI4YW9ldm55V0k1?=
 =?utf-8?B?bURFdG5xR0xBYUUvUGZwRU5uRWZ6NGZBN1ovZkV3eEw0YkVna2JGRXdwU0lj?=
 =?utf-8?B?UGRxeXZqY012WTZueFlwd0p4NzFyd1RPdjB6bHVZbnNHNzJhamJIaW13dGsx?=
 =?utf-8?B?T3hpOHZHOW5mNjZJdjB3bHlkSERiVHJKT2Z3a1Z1YjJYUDdFNGg2bTh6R3Q2?=
 =?utf-8?B?cXJmUGV1NE1VRUYzaEhJWkJhWVhWNGxmRExPa0EvUmtQSS9LNWFOT0lJa0Zr?=
 =?utf-8?B?ODBmeSt0VUpQU0pUWjFJRml5S2NBZ0tnYXJJZjMvYVQzdEV0eTltdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45dc3ee-3f37-41a3-e661-08da551d602c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 13:36:28.4657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSmIENH/4jr78IuK+H2yxrMAQJLAlYh6hZmQF+pYQxjJr/WBIHESyGqGmcgDbdv0Z0iaI0C+RX9bcONZSHVqFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335
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
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-20 18:38, Alex Deucher wrote:
> This reverts commit 92020e81ddbeac351ea4a19bcf01743f32b9c800.
> 
> This causes stuttering and timeouts with DMCUB for some users
> so revert it until we understand why and and safely enable it
> to save power.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1887
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c           | 1 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index b4cf8717f554..89011bae7588 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -320,6 +320,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>  	if (!amdgpu_device_has_dc_support(adev)) {
>  		if (!adev->enable_virtual_display)
>  			/* Disable vblank IRQs aggressively for power-saving */
> +			/* XXX: can this be enabled for DC? */
>  			adev_to_drm(adev)->vblank_disable_immediate = true;
>  
>  		r = drm_vblank_init(adev_to_drm(adev), adev->mode_info.num_crtc);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c2bc7db85d7e..24959cb85c48 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4293,9 +4293,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  		}
>  	}
>  
> -	/* Disable vblank IRQs aggressively for power-saving. */
> -	adev_to_drm(adev)->vblank_disable_immediate = true;
> -
>  	/* loops over all connectors on the board */
>  	for (i = 0; i < link_cnt; i++) {
>  		struct dc_link *link = NULL;

