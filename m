Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF5BC4828D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 09:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E991131D3;
	Wed,  7 Feb 2024 09:56:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2TbdgO6O";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED07A1131C3
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 09:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFjju+USNUtfYtjUESZmsJjVp9E66l4BDKz+XAwlhkOJYLOUyxz1XrzivBBDLijat+IYzIV3UVXjj16vIhNhouEFgseIQEzOeBFKOxejCpzaowPBDpVdBVXzuiLCVkkZt/1YkSZSgl8gWm8sLYOPIQbzpAWFrX1s0rpj6qZ4kLThuhnMCtN3A0n30KEjIYcQ+UrqAQGBEte3byC0l/yNZIqb5EwsPiDefV91MXxmoV/0dpEYbNM1vczV4xYXpIsABU3DTjIXgRmA7DVmsLET0Hj7YmaaVPAhv9D2dZq818cwz5+XcwSpjMRtnFrL5pZlDZ5obxtBg5omRMhc97uL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEJrI6PdK7iPFag/ciU9E2wPOTbSBud+YvJJsShCZwA=;
 b=Hgteh68hRY1nfBlSq+uqR8Hpc19d5cLZyCBlLrasV2N6DCCxgQeAeXXKG/x7a1Eogogp+6VY3jHnwE3xU+XYytjhE9zbi8VZghzCfHOkTpmYklPuW/qfbKvzXNVWdqgQDpj51ktivWre+Hvmou90MFZSqr/MfOFpL6LAO16+aav7lgfU3444S+9YzzzWKVEN5MEDlor6TrNHiGDiWLbmP5F+eXMynXM4fBGYfa6HQXVuBH7UkI+RBAZaExDeZGsAHKlvOyatrwvKlH4wo+JzGqetwYwnYrX+AOhlqldtOvnhhYT4pPCVtQniQt6B1bjb0EqEMdsQ97AZOz2Vqq0j7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEJrI6PdK7iPFag/ciU9E2wPOTbSBud+YvJJsShCZwA=;
 b=2TbdgO6Ox/PjO8c0yzvwCtj+DTBIpFqQ2l+P2GoHR5Fko30H+H3hE5bXu6vVD2SrJZNJLEHd+BMwVrS7ZZYPaGBKQfbdeFwLzXesesjBDynRofJxrCrDbtIsfBr0TG5m40K/3Eo/ph4/Qkf0Jtui3D0oLgJHVT5k7J5OudCX+TI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 09:56:14 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::3639:e4bf:a222:7dbe]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::3639:e4bf:a222:7dbe%4]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 09:56:13 +0000
Message-ID: <afff380e-698c-4250-8af8-5646ed5763c0@amd.com>
Date: Wed, 7 Feb 2024 15:26:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: denote S to the actual clock
Content-Language: en-US
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240207083333.3815944-1-kenneth.feng@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240207083333.3815944-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::30) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d3d6fb-bc40-48da-5106-08dc27c304f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NC2Q6nVpRDoqXbQrKPnXGveax0Mci6AiLwqoQlJeA4nU3PnoIMfDPpkOZuHBO8atWCRWV5cIQmFZvHcUvOsIKeXQuFX79cv7ftp2JskKQAC1ZvJNZKJ7wd27l2sjB8YGuqLBeBoQB9o6G0rRR4BwE1Mq7zurevr40iw5dG64PR72ZgTUJmOSBzb9OqtttV1oEjDCutCGP7z/xIVbLaBinCFodnlKcPPYJwgZAQtbL0/CciOLhWwN+YQP2tueeAkIE9y9GE+hIra73YzVdw7Y0jtHVDX1XVJ7grmX2ugf5z931zNMXwR1GIZasVwtaSfID44rNzcr9tz3lyxM4Jva2dnTs+OcXSKKviD+hBww/TVglaoBTof74uRqkbVCKmAv7wf7A5N3hgRK+naqi1qHbO3ZaDRHCRxaoBNb1qRHLUoaZikNjJu299lGB2s0Tf4oQbnORPYFZwWrGOgmP47vHSMHhF2hMr3ty3oAo/ZVQdO1wMBlFTT+9c9LrStu7XogmX3ye/eBaJIvpVTn6ahNs6sX5H10mIVsJ1uLR6x6hHbB0IOsnwcnUvs51WU+RuMZEltSjxFDhOWwMUuz8bDnkIGLsMUsyYkDuiPCn4mIvMVsDtWpb1kS9hq/k8yqaBjT5NU/pIkVRs9USkLkKgYY5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(86362001)(41300700001)(31696002)(36756003)(38100700002)(6666004)(478600001)(53546011)(6506007)(66476007)(66946007)(66556008)(6486002)(8676002)(8936002)(83380400001)(31686004)(6512007)(2616005)(5660300002)(316002)(26005)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWFpajArdmoxdmFMWVI2SktRSDEwMVF2U3JYSGlWUUJCWWlzdmdiRXkzMFZH?=
 =?utf-8?B?MXBudUpMUkNDbndISGVuRW9SYXNCNkJBcEsvTXFRNldBdzdzbVMrc0lXQUUz?=
 =?utf-8?B?dUdIZ1NrTGYvY3k3aDJxNXpqUkZWMzA5K3ZFbTBIYjdKWm5KeS9JQ1VmWk5k?=
 =?utf-8?B?ZzNyN1ZKakpQUDFkN0l0WmFKVmxSYXlmVnROYzhLOVp1UnIySWp2KyswTWpa?=
 =?utf-8?B?c3NzQUdpbWFicFJWYzAvZGFvZTJkSVRuT1l0Z3hkK2xDYWZaelNiYXNwNndB?=
 =?utf-8?B?NlRoUTVTd0ljc1psWFo4aXBQeG1BR3JDZURGZUxzOEwzZE9wWlhNR2ZPZEdG?=
 =?utf-8?B?WUZSUjdZNnhLV1NteFREWTF2alpMY3Yyem5JQXlrbGsyRG1xbDhuN3R6aXNM?=
 =?utf-8?B?T25aUWVFU2xTK2tRRmZjRUl2MENZUkZkaStvcWh6N3g2YzBVaVlEc2FtY3RH?=
 =?utf-8?B?V09ZT0w4dHdpcnhBV0FkREd3MHBHWnhzYVdiKzFOY1RPK01iU01MTDJCSTBK?=
 =?utf-8?B?VFdRUzBqWENvaFF0RnFic3BNSGxaZGRkNGFhSU5mSnVEZnEyQlExZGw0Z2Vv?=
 =?utf-8?B?a2RhcnU1ODZoTlFaU0diUDl2UTV5RzRKRjBla3g0NExPanhWc1Z6VEVsa0NF?=
 =?utf-8?B?TGFaRHlFZUdyWG5vTCtoMjBDa0FsUnlnVXJlZndINjcvZlpNSU1OSkZ6Vm5J?=
 =?utf-8?B?ZXhxRWoxZTFBMXpOVWQ0Y2M4Mm5aZlJ4Z01URnBla1d6UmhmUFFOem9BN25i?=
 =?utf-8?B?dlhCb3p3Ym9hSW9hRWxLVE1rSEdhcGd2ZExSYmtzTWpjNTYxTjI1WVhPWWgw?=
 =?utf-8?B?MnpOd2F2Zk05VERVdUx5dGlmSUdOam5uYmJMaHl0UDRCbEFkSTNxNDNtQW8w?=
 =?utf-8?B?ZmI2angya2NrT3BtbHpvelNaYkwxd1VhQm9zQTg4dWNYYm9VL1hlZzR2M253?=
 =?utf-8?B?ajZwUk03b0xNL1E2ZGdFblNxdnp5aXdaSkNMQ2NTRDlCNDRFaGk3VXJLUWgy?=
 =?utf-8?B?akJra2JCVkhBYUI4dzRCRkxrNjVrZlpJZm8wbTJOUUFuQmh1Q1R2eGljU3JQ?=
 =?utf-8?B?MlhYWHBSczljMzB3eTZmVXA1ZVhiZlg1ajdDVUFwMTZtRkVEMzBVb0J4SURv?=
 =?utf-8?B?cGtxaWE5b3pDTm1aeUZ3RDhzL3FwNmRrbGpFRnh3UzBzaXhRSmtJeXhBaktG?=
 =?utf-8?B?NGlwSnViQzdnNFhmbGdkdE1vWVVJM0trUGRxNWN4dE1aaEtWVXV4dXU0Q1Zx?=
 =?utf-8?B?UGRKbGtmbklCekRFaGxYSEVCZU9hMmJCYnArSVBQa3Q0Ty93VjREZTJmTDVa?=
 =?utf-8?B?dUNReWFFS05idHBCNTEyTTFXSERFRy9lTlNVVTFHNHh6MjUrZENnQzNsU3pR?=
 =?utf-8?B?Slg1VmR0WXc0UTE4K2piSjI3NTVVb1pBUG9KQ1NrMTNVM1JVdDZmbWVOVUgy?=
 =?utf-8?B?MFpSeVdhNmQ2TzFKb0hOTHdIMUpkd3laZGZHWVMycmtlOFhOazlxQ2ZnZWMw?=
 =?utf-8?B?bWtYOXdzczdUbE1oMUxveGl3UGNvWHVXeUNQU1YzZ3FtdmE2UUVPSW5UeHI3?=
 =?utf-8?B?KzRBV0VEL2UxTlFoeWswenpGcitPS21aMXM0Y3F2WGRmUGEvOE1FSFlTMkNv?=
 =?utf-8?B?RGVCTWFIREhYeW5rSnJQUmFORDJJSU9XdUhrTStGejltMVptQ09MNXRKRzMy?=
 =?utf-8?B?OFRUTE5EMUo1Q2NHOFV5eVBkWW9PZHljU2JUeVlLdG1FVkdTNXR1Tk5mZzh1?=
 =?utf-8?B?Nm52TG1GbUdVRGdQalZoY0N6N1FqdlE4SHpOVGIvNTJlQUJqSCtZdElldi9x?=
 =?utf-8?B?MU45K1A1TmFlM2dkeENiSHZhbm9odG9ybE0rdk9Zb3YzZTRTbXNsckpnSlFq?=
 =?utf-8?B?U05wa0wwSWtXbzZNYnloeVVtZDd1aElOajFncnVqTlFoUndSWkg1RytNNFVR?=
 =?utf-8?B?dDNBS3dTcTE1d3orcE1UQ0phcUpldCtUWEdRTDBVZWJXenlobW1EZGgzUVRl?=
 =?utf-8?B?Y21kYWNpR09NQ2dqc2F5cWdSd3padDBra0lXRWxZQ2RIZXpiZ1g4Qm1PeW1Y?=
 =?utf-8?B?c3hDaTg1ZFAwV21JM2pmVGJ3ZkJvTE1Xd0Vuekx0cVlkR3hUYm05dGdPV2Ri?=
 =?utf-8?Q?EBBYV+delU9ZJHOPFygm80koV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d3d6fb-bc40-48da-5106-08dc27c304f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 09:56:13.8747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDPUR+UHYIhoTkldpAN8H22vb30cSpRHSMruvbMS2YDKyBq2gY0yf6glG+s3gbzu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
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



On 2/7/2024 2:03 PM, Kenneth Feng wrote:
> denote S to the actual clock in smu v13.0.0/v13.0.7/v13.0.10
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 12 ++++++------
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 2e7518f4ae1a..63a930c4da01 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -1270,18 +1270,18 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
>  			 *   - level 1 -> max clock freq
>  			 * And the current clock frequency can be any value between them.
>  			 * So, if the current clock frequency is not at level 0 or level 1,
> -			 * we will fake it as three dpm levels:
> +			 * we will denote it to S:
> +			 *   - level S -> current actual clock freq

S is not used to indicate actual clock always.

'S' is only used to indicate the "deep sleep state" of the clock. If the
clock is at deep sleep frequency ex: 95MHz, it's indicated by special
level S.

S:95Mhz*
0:500Mhz
1:1900Mhz

If the clock is active and operating as normal ex:1120MHz, the level is
not indicated by S. Sample values at that state will be

0:500Mhz
1:1120Mhz*
2:1900Mhz

Thanks,
Lijo

>  			 *   - level 0 -> min clock freq
> -			 *   - level 1 -> current actual clock freq
> -			 *   - level 2 -> max clock freq
> +			 *   - level 1 -> max clock freq
>  			 */
>  			if ((single_dpm_table->dpm_levels[0].value != curr_freq) &&
>  			     (single_dpm_table->dpm_levels[1].value != curr_freq)) {
> +				size += sysfs_emit_at(buf, size, "S: %uMhz *\n",
> +						curr_freq);
>  				size += sysfs_emit_at(buf, size, "0: %uMhz\n",
>  						single_dpm_table->dpm_levels[0].value);
> -				size += sysfs_emit_at(buf, size, "1: %uMhz *\n",
> -						curr_freq);
> -				size += sysfs_emit_at(buf, size, "2: %uMhz\n",
> +				size += sysfs_emit_at(buf, size, "1: %uMhz\n",
>  						single_dpm_table->dpm_levels[1].value);
>  			} else {
>  				size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 0ffdb58af74e..dbdb50173de7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1259,18 +1259,18 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
>  			 *   - level 1 -> max clock freq
>  			 * And the current clock frequency can be any value between them.
>  			 * So, if the current clock frequency is not at level 0 or level 1,
> -			 * we will fake it as three dpm levels:
> +			 * we will denote it to S:
> +			 *   - level S -> current actual clock freq
>  			 *   - level 0 -> min clock freq
> -			 *   - level 1 -> current actual clock freq
> -			 *   - level 2 -> max clock freq
> +			 *   - level 1 -> max clock freq
>  			 */
>  			if ((single_dpm_table->dpm_levels[0].value != curr_freq) &&
>  			     (single_dpm_table->dpm_levels[1].value != curr_freq)) {
> +				size += sysfs_emit_at(buf, size, "S: %uMhz *\n",
> +						curr_freq);
>  				size += sysfs_emit_at(buf, size, "0: %uMhz\n",
>  						single_dpm_table->dpm_levels[0].value);
> -				size += sysfs_emit_at(buf, size, "1: %uMhz *\n",
> -						curr_freq);
> -				size += sysfs_emit_at(buf, size, "2: %uMhz\n",
> +				size += sysfs_emit_at(buf, size, "1: %uMhz\n",
>  						single_dpm_table->dpm_levels[1].value);
>  			} else {
>  				size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
