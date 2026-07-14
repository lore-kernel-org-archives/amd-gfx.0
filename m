Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2CFC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 09:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BBFC10E68C;
	Tue, 14 Jul 2026 09:29:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QFjZG8+Z";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012041.outbound.protection.outlook.com
 [40.107.200.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5882010E68C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 09:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mp7dl4mxOxyxUWdMvjdtXLq6dQQ0y7GuVB1DaV69qzaZbD3+t3uP0P/T/53Nucvfu26SLSFuRTRzHiia1MWEOESy6uii9vjJGaD6ixWEVdtloHTUDNscGmCe1qrCrp3rColGWGP3EQWkFyp2y1eb/tkWt+3DxUYcWnjLwS8lx5szQ4I/pYCLMlLLfXX0xvtHem5v/n5DN7kc76WC7jV2P2Jy3aAzRGWMNL6m4n26zpDSmBGmosTMVMAZIWeoxW6RVlIegtfaSnl5zLPMjjbK3gzV9ALzBvxg9z+ylV7BbSDAg7vFzxYT0qWSZL3Qa/3vjfzcOOneXKrN6lZwsOi13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1w6nMwpPZAv3v3lSuCLL5tsUXQ2M3haWDHl/hb78aQ=;
 b=Ak0r8aHl7U8IYJbRE9Ch638snvr2Eq7ORMG8ejWstJ0M/hRV+CXiFLi+u08mCXggcZM1T5sJQJ1jltQraALf5MLeW8KsEB4gSc1H2Sxv97syBvMbsBHq98wOCRk5OorkTlBjLWMwaF+gK5OePzVi70YJt1JWxiFpaGr6/Lm83+mvvgi8oQqQ1H6mwkjDA5qVat5TTWwRaFLkWIutfH8byJR1idcsZlvptTiy/0gknmh/QSjF7evKgFBZz2UvIkycpLkG1/YOYNBB3R00ptuJsY0+4hn0quoT1HhkJq6BI+ooPds5+P+1pA45Hk0dlbdp4rnMRRZX6aSSGh8UsXBnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1w6nMwpPZAv3v3lSuCLL5tsUXQ2M3haWDHl/hb78aQ=;
 b=QFjZG8+Zaw8ssysG9nRlTpACD88vug3B/R3ALmlXgviDl3WsF4NbWIL/ejd8LWhqi9ljTqxUy02P3XQFe6e0JUU9DbZz+pHIbY8zVufkndvEjGhpvENi3QAUv2D+Ptsanqd6t1OMPPPo8BRM5WmB76pUwZGZqwBIlvmNdWctOe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 09:29:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 09:29:19 +0000
Message-ID: <8964b5b8-e649-4026-ba76-8e0d5a88139b@amd.com>
Date: Tue, 14 Jul 2026 11:29:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] drm/amdgpu/userq: properly account for resets
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Prike Liang <Prike.Liang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
References: <20260714080220.3395155-1-srinivasan.shanmugam@amd.com>
 <20260714080220.3395155-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260714080220.3395155-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0344.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a13259-8d63-4156-ac93-08dee18a61c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: r0Oi4S1mFgXuHz5sw2VAFjhDAzn7e8nBBhh1ELLWl3qbO+PcsGEKEnPJrlm1YeNz2zhI54B14toMKKvUphKWC+kHTb4Ox5yUCuNsoEbLkm/0SWQGYvjNUgsbUiWp/Aj0n4ENsxFqQE0tdLJUlBcyRDglSllixldNGcgl/Ohg1EEepYUiYKaj5GrI3SOD/7EMJGBKw7SJ57ksnOkFDeW1X39qNe6avOtuRVudmPKDhIZ77zBuVglQ7Kg4gBgJom2Q0l2lOfinEZcp0dChAH2826dzIUrwsQrhP6BphEJF4eILBVRifRN4qgcA1e41yrPtXuWDiv835WFZlp+3TNrdkA9HqOFlC13PTpRSo68KMq4QXjBd1FYdzC38P1YCEi5KQ2FeqwJgbUbvcPsfo1hHElK6rYDC1uR+eRf9wJfEHPH7FiwEYgGTY6ktGFVM3K1MUCvwWOkc/EEMNZ0IawouW19TWusBc0udKIyuXTULAn7PczfE+XACO2gQCjVNWlFRtj7vHsaHuegzfJpRdQO3ByUsEnCN20ymX8CLMBAPv/Bm38jbD/3VQl4RruRMuMDZcdU1WgvLed68/R3vGK8GZNTywwXTtSDm7mi+xVqjWMImrQtUJKvmNEkP/+aUWragR2TpGaWp+RSjtNkooVi/X07fUXN4E+jRZe9LuUzDh5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWl1RmNMK29HbGN1eHlESmpjU294U0RWR2dSR05lVzhVQmRvT0toRDh4OGEx?=
 =?utf-8?B?a2ZxRXM1MWs5LzdlcUlIMDlidVRmQWVvbTNhSzd4Nmx1NmRyQWZSMGNoU1NN?=
 =?utf-8?B?YzdmZEFtWkpXbDRlZFZUWkc5SDRnbW1yL3hYV2Noc1V1amszdlR1UDFrTDlo?=
 =?utf-8?B?K0I0YVJ5bFBUeVJqVEpnMGVnK3ozUjAzNTBRZWRMTW1OT1p6UGtXSUVzY0FV?=
 =?utf-8?B?aUxTK0Ficm5IYVNQMDJBTlE3d1Z1OWpmV29MNEovb294Z21rZncrL1pTczA4?=
 =?utf-8?B?YzJBQ0RFbytIYkFpYXU2cWpMZUM3RmdQRTc2ZndTVzBrQ2p6ODlsTXdvZUNz?=
 =?utf-8?B?SFRtL3kyMFEzVy9HQThjYmRvY0RVUFNmZVI2eDMrUDdxWEQxMkNwK0dMMFRU?=
 =?utf-8?B?cEZ1RGw1QVpWYm9SUU1NaGVzQzB2MzFha1kvK3ZBWkhZQVh1KzE4VURZV1V1?=
 =?utf-8?B?SDhZbm00ZTdkWGZaeFRvR1U2RDBoRm53WGs5ZVFOTUxaNUU5WlgvM0QwWkZa?=
 =?utf-8?B?K3Q4clBzNVdaNGk2N3JpbXIwWUFNdi9GUGZPTStsU1hMWjN0U0tIdVlTelMw?=
 =?utf-8?B?eUlCNU9KcE9teEFaL1pRL3hQcHYzQXNpalpJMmJvQU0xeEsrL1NKUGFnTEdF?=
 =?utf-8?B?L1IvWnpIZmRTWTRRVTJGQ1lyWWZYWnRiNmR1cVdCSXFvNytEN240b0N2c3lQ?=
 =?utf-8?B?LzNybHQ5WlgzRC9NcHpLVnpWTmh6VjIxemUvMVdFUkhoT1NJdFhQUmh5UHBv?=
 =?utf-8?B?cC9oVHJOSGNOUUJmVW9OYlZrUFdxdFRScHlaclJINTZPcTVUZjB0alFMcGl3?=
 =?utf-8?B?Q0dZczZUS2tDYndaL214c0ZWUzlJTXY5YThNRVpkT25JN3Y0NnpPaUxIWFd1?=
 =?utf-8?B?UnJUeStOS1hLeFVGTENOdWJWRXZaeEN4OWFERDczYnpOTjd1L1FsQXdrOS96?=
 =?utf-8?B?dCs0VzRxWmVtck1GS201dlNBVm83cFhzeUM3alAzclVINXFRZzl6RnpOOGYz?=
 =?utf-8?B?M0k3RFhSWkNtOG5ES25Tb3QrSGw0dTZEc3JMcHJQTExvWnpaeEZVeU1lazRq?=
 =?utf-8?B?VWRselVNb2NmY3liUDBIREJnUE1EL2J0YXhSTlBrU3RVVUwreFhPSjdBMG9s?=
 =?utf-8?B?Qi84YW1LUWYzNHJHWlR6Nzl6WXlvWmpQNzdDK1BaeUU1Q0dJNng5VllSMS9u?=
 =?utf-8?B?a3JNRmE2dmtBZHJIU3ZzSlNrWTUwcUYxbnc3RnpFdjF3cVVTY29kMHIvOWtE?=
 =?utf-8?B?TndPKzlaQWNQSzJQQmxZalphdlFYSStmcGlmZWhHMGNvblRmRGJZeWdiK3Y0?=
 =?utf-8?B?aG5MOFRQSkRGamUvRVNGNDNRMFlNSlhnb3h6b0tqWkdhc1FnZlVuZzV4Ym9M?=
 =?utf-8?B?NUxIYTBNZ3dKV01KMkNxUmkyZHpYZVlvemlMM0hrSnZyUVNrWmFTR3dnTjdw?=
 =?utf-8?B?SU5sblRzWFNjZHdnRmhtVjluMmQ0dTd0NVYrT29nMmJKWUozZjhlblVHTGlk?=
 =?utf-8?B?NHRZQWpzMDVEdG10enhiYkdzeURlSnVHajBMYjFUb05UaVlxTDlCSEx2RDl1?=
 =?utf-8?B?UENlMmd0M1pMSkMxRlpMd3FPTkR0T3h6akJDOTh4QnVXdStNb0VuNDdCOUdn?=
 =?utf-8?B?RkxacFU5VGlCdG5xOFVNekdqZzVyT3RhaGdOb256dG0vY1BGbFZZS1ZXRllK?=
 =?utf-8?B?NmJBWk05a0loaGdPeGovZk1ILytuL0xuc2NYb01vVHdycUJpV2NqSjhENy9n?=
 =?utf-8?B?TEdYL3JZcnp2RGNreDRrQldNRE0rQUVHYVlQeG9yTjk4aENJQSt0QUZyZHRm?=
 =?utf-8?B?Vkx6ajh6K2hNK1VhTzh4U3orS1lDQ3ErOHdjR1dFUFl6eDUvaGQ4NjQzVFNS?=
 =?utf-8?B?YkxhMm5XK0VmRTk1YUZRcEs4R0hGZnFremdTeko5bnFKTDRvWk1IZ25OWlM4?=
 =?utf-8?B?SHpoZ2xjN3dEMnlnbWNoUksxZk1sRlV3Z3ZBMXBoREdnRWFzRVFwZnRoUGN6?=
 =?utf-8?B?WHVNUTgvZjAvam1UZzRCK2lBY0s0c0FzNkhSOEJHaTRvelA3Z1luMm9RQ3JH?=
 =?utf-8?B?SFRaSXdnbmViS0FQME42QThWZUJMUmVaMXdGSlpQOXN6MUh2U3RrRnQ5WUNV?=
 =?utf-8?B?NHlFM2s4R3JZRGkvT2hLS1J6ekFCbkZGS0JKKzZSRTl6cThkVU5UTXFOaWdv?=
 =?utf-8?B?WksyVEg3cEQwQjU1NHl6azZaNURSWHhkVFdOdkZOSUV3cHQ3RHFrUEF6d3pq?=
 =?utf-8?B?Nk1mQ1p4enVSN0ZjRW05aGh0OUwxc1pPNmZxTk9pa1owYllPb2NqSWdOR3dv?=
 =?utf-8?Q?+baNLS0BfjWesa9Eue?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a13259-8d63-4156-ac93-08dee18a61c7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 09:29:19.8525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMB7988HaxSWQ/uSFTl/an6GraeFGiduIVSz62JcD4T3FlqZtc+01TBw/ptBojoN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/14/26 10:02, Srinivasan Shanmugam wrote:
> From: Alex Deucher <alexander.deucher@amd.com>
> 
> We need to increment the reset counter, force fence completion,
> and set the wedged event when a user queue is reset.
> 
> mes_userq_reset_queue() handles this for collateral damage, but the
> caller needs to handle this directly for the original guilty queue.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Cc: Prike Liang <Prike.Liang@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index ab3ef3a9f655..fb0d335875af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -167,8 +167,13 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>  							 queue, NULL, NULL);
>  		else
>  			r = userq_funcs->reset(queue);
> -		if (r)
> +		if (r) {
>  			gpu_reset = true;
> +		} else {
> +			atomic_inc(&adev->gpu_reset_counter);
> +			amdgpu_userq_fence_driver_force_completion(queue);
> +			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
> +		}
>  	} else {
>  		gpu_reset = true;
>  	}

