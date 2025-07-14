Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25F7C83F1D
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 03:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6277B10E1E8;
	Mon, 14 Jul 2025 03:31:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u9Fmnl0U";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFBB510E1E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 03:31:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yW1/YOKYH4vgUTvDofDb7cjV0hPEGT0G/WYiAadORdYfbsGg0MyHX4CToHzdCiWdUQ9UObnqcjXujZFrG7ZuXtmS13JmvSjZxxHvRKPMvaSZh2/+8+a9hN1EjYhBsb0tUN3v7jsscOmdUYGncVM+vnvzqQh3Mtzd10EqPffpXtQebcjIrdd+/52T5vzq4v8FhX/gA+YvMPnm9Bl67u98I8FCZQH5TzwtzS/6mAHDS28hmZ+ZHcxzn4av/EJ6PPkeGUploJYE8jeBuiK01K1Hvh6jVCSabt13f+zeJeuObFci2ccTKymOJyzlbqaNd+XHj7IhhRkjw9XGZewHgC2ZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSejajswUvXZEqLly6R+k2oWwMo/77H+W6Ev40zkhvg=;
 b=MBSn7G/+4Y1egh+jkUD2LbHwHS9i6QTdWpfFRajG81JdS1coGDybKlhtPKqKswuwwnTm9/37rKRxONtFs47PhxNeMKVVqBwYWueYoYKTBQFGoL2hAD6vE92GQUMAVL8Fve8voIYR5fA0V9UIJ7oOQFn1dEeSUqOjfdMyxLsPZBrTfxQqreFfOB2LBrwfWKu1N2aOdIlaLctxQ6b4Rmm6qEZCYNg6luI4qbQMVq33mKTRbd7Cy/OglAg2c5K9bMaR65hi7yzd2uYtgUcflZF72hbR6/n2wA1Bzep4h+S7w0+lh9D7QWm7dGVd3NkSxKBE2Qk/59ParvuCwub8bCUWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSejajswUvXZEqLly6R+k2oWwMo/77H+W6Ev40zkhvg=;
 b=u9Fmnl0UFjEDlaZf8QeuoGe4mp1HoywAgs2MZmIUq4fS5rBb8FZy2xF//pknBYqjwxd8cJggHKFg/cszUHp9e03OOWmxEFcoGh5bv4cbFeG0b6+lBXQE05YRKzoTVdWFT3baYy5EcPTEKGzfPdbTxsPx3jBdsCth1up+74awOPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.35; Mon, 14 Jul 2025 03:31:04 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8880.023; Mon, 14 Jul 2025
 03:31:04 +0000
Message-ID: <1245bd36-dff7-4f0a-abd0-5f92b2890c94@amd.com>
Date: Mon, 14 Jul 2025 09:00:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Use cached data for min/max clocks
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com
References: <20250712042811.1495850-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20250712042811.1495850-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cb3c61-668c-4394-fe5b-08ddc286dc90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTNUVlpxSVpJNVdCc0hQSmQ1MDRKdVF2UHNCV0o0Ni9wQW1pRXczK2ZRTXQ1?=
 =?utf-8?B?UDlVdHU1QUFvcUROQi8zSk9JTm1zSWRKQWRLbEhGZ2ZFdTNSWllDZTFOSlNX?=
 =?utf-8?B?ZTB6dFRqN1FuZTVuZXFIQ3ZWSGpwRkt1eERzRHVscEpVcmQ5QmtydGg4Slo2?=
 =?utf-8?B?d2ppSVFZS3JhcTNEQnp1RHAvMnBmWGlZZzBpMVdDTGJPUmVoT0pzbm11MUNq?=
 =?utf-8?B?MTlCQndvVGhkVmlVY2R3VnhqQ054UGtYS2JST1owenptUm53Ym1tMHNQV04y?=
 =?utf-8?B?Q3V6b3VORHYyZlcrbTNubkxxcGp3TDF5amh2d1NPN0kwbnQrWnRtc0hkcUIv?=
 =?utf-8?B?ZmNHdmM3K0E3YklrWkhFR0dVRnhQelBvVnlJdCttdGFHeFJpc2NRL0Z4dlhK?=
 =?utf-8?B?WnhpZFZ0U1BaUUk4T1Q2ZUZCbHJDWUNFL1R3WGZ1QU9uRHc5Sk9jOEM2Qm9L?=
 =?utf-8?B?R0tVQmVIeHhCcmxUdVhHT2x1bVlOQ1lUT3doZjlZeWZJYzNKaE5Ba0ozRngv?=
 =?utf-8?B?VUVPTVJSb1ZXUllXeldSUG5hN1M3emE3YWNaWnp5MmdzaE8xR2R0NHNkdjND?=
 =?utf-8?B?YkJrMWZ3Mm1JZ1E3VFNpU1F2dlJVMXhvSnlxYzF3TkhMNmJLd0F5YVBKZjdU?=
 =?utf-8?B?eGQrZU56MHFqMWxHMEFBcVRlVVVMT1JZOVJjNDAyR1llaFRKYU1mZjFrWWFL?=
 =?utf-8?B?NlAxR2ZEVUJUaEt1MjBNYzBwTC9WdXNPWURhWkZtQjd2V3dlK2ZUSTA1bEVh?=
 =?utf-8?B?N0RaTTFpMmdWTk9xcTd2NWphZTZRUkVSc1ViWXFFOXgxVjJzeU56N3dmdHpm?=
 =?utf-8?B?RHgvalJiVnRFYnl3ZUZpNURUMVd3SmFvOVNSOGR1U3NCWmphanFHdi82Sm5H?=
 =?utf-8?B?R0RQSURUanhGYUNtUWVtbk9BemVHMzJldkhmRTBRQklRTG92ZDludHJwT2FM?=
 =?utf-8?B?R3BZcUE0bTRoL045UCtVVUlrYkFzbFV2TlRxSXpzVUhrUVNzMnNEM2J0MXB6?=
 =?utf-8?B?cjFSUFRBdGcvWUNkWnF3elpMUE93QWxSTlRLam5id0cySVVqVHRuTTFTeEZL?=
 =?utf-8?B?Y1VybDh3SGxLMVV5WTRiUHVudk5wYjJMRnA2VmRibTFBK0lvZkNSSm1wSk9N?=
 =?utf-8?B?L0R5OWhmTWZBcVoxWnhyYnhmRVpPTitmMnhKZzN3T3NvcHdsNVpVTzVlYlF5?=
 =?utf-8?B?eFRBSGltR3ZCSGJmSFVScnhJL3ZoOWZQR1VGbGY5TVl3RkRlN2Y4NER1M00y?=
 =?utf-8?B?ZHFpdENnTzg1c3lLUFQwZTJ1VHlQU2d1b3M2RTlOVmJ0ZSsrcFNhaGJYOFhv?=
 =?utf-8?B?RXFXNmYxWTdUanhHeUs0ZEhDS3VEODh2VmNETHhobnBmaXVkSnJYdFFYSkVl?=
 =?utf-8?B?MWR2S2tiQ2FkTkljTGVHdmpNbjZ5dHVDNzRldG9JbU4xL3MxVmtwNVBOVFF6?=
 =?utf-8?B?aDFVMUE2aDJSdTFPZnZFNnY5enRXODlTM1BCenVrVzg5YWJ4S2NmSG9Xczlj?=
 =?utf-8?B?S3BOUHBKYVRkNWUzTzV4dUswMEVRZGNKYktrOUlId0JucFJ4aEs5MllrWWpl?=
 =?utf-8?B?VERKZWM1SGFMWWowRko4c2dvR0tPaFdhN042QzJZeGdXTVloekJ2Rm9uenhC?=
 =?utf-8?B?ZGtZM3ZHaHBPZUc4aDYrTk9tY0VRUWtJdVNYeXJzQW5pMkRxTlYyU2daVFZo?=
 =?utf-8?B?RnJpZkdQQmRxdnc3MnZnZmdyK3JFQm9hdmUxWFhhWmU4dXlXY2dtbzc0bUpU?=
 =?utf-8?B?S2VzbktZZHFueURuSUQvSm9aUk5sVTZIODlRVXBEb3dUU3lIOVIxWkJLU0tM?=
 =?utf-8?B?azducENDWVNRMmUydnc0emhKWEtTRDF2SjJhaG9qalN0WVE5Sys0N0tOWk12?=
 =?utf-8?B?Z09jQzJFUlZ2M1ArVll0TUdkVmZ4WExqdlpyQVo0MnM2T2hPbnZSamx2Qkds?=
 =?utf-8?Q?JiggILTM/E4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VSswTTZoOWhqTlpDSllUNXJ1M0hyUERBeDIxaVhyc2dHU3I0ZlZYYjJmd0dp?=
 =?utf-8?B?TDBPbDZ5aFE3cEtwRDlSN2JDb1Uza2kyZTJHV2dMd2RGbmFMY3pUUFNGUk9Q?=
 =?utf-8?B?N1BJdmErR2hLQ3ZCYzFEMzZiNGJQSndIUHZFK2NzOU96NHArQXVIditFMFZE?=
 =?utf-8?B?ZDJUb2hBbXMxTHd1WTQrUGVwRlQxRkNabUFXa2RONzMzMDlBQnNRbHAyU0ZB?=
 =?utf-8?B?SmVsd1hqRlkrZzVGa1o5T0tGYitUL0pRTk1PUndLUk1RVFF4ejFUdCtjWm9B?=
 =?utf-8?B?OXRMWVJvMExHOW10S2VqMUMvY3VydDd3WFI5d1FmTXNUTWJVTmpIL3N1SXFk?=
 =?utf-8?B?REFPT2JzQzl6UnVKWitRNWY1YWNzVWg0UTA3eTYra1NNRk93RWtZY3Nia2ph?=
 =?utf-8?B?cVFvdmV1a0d6ZWdYS2paZ3AyQmZ0VGxEd3F4SFk4c1duQjRXNnR1cTJBbURW?=
 =?utf-8?B?K09mRG9nNjNGSytNeHFRZHczSHV3YS90MG1Ldzh2U2djV0lKalpMRnRqc3FY?=
 =?utf-8?B?dERIYklPQnozYjAvVmdWTzM1ZG9tSE90RjM0aVdseWJvQi96bHY5RUo3bmNU?=
 =?utf-8?B?ejFoSTlNRWxxN3lKNTY0UTd3V0dhdmFnZU8rTUZDOGRwOUF3M05TQTgyMm05?=
 =?utf-8?B?OUZQSFkxenNiU0ZHQnhxcHJkWTl4Ymp4dXMyMTJ5R1g2b25VRkdaKzFJbTBJ?=
 =?utf-8?B?MVcwU1lSNkoxVE13TFAzSlI1ZlRTaGtvUEk0RGd2OERrTi9kMERvcWRna2VD?=
 =?utf-8?B?VTU4WGY3SHB1VHZSRWw5WVNvV0p5eFZrUlpXcktBNk5KTm80djZlY2MxZzl2?=
 =?utf-8?B?dzdQVGk1enZSZWM2MXhHNElUV3YvODc1ODE0cjB5T0pqekJJTitUaC9PdVZa?=
 =?utf-8?B?Vm5iMDd4c2R5bFptVGVIRWw0UER2V01UYkoxRndib3pybGpOc01BaTkzNVQz?=
 =?utf-8?B?enF4eGZKYit5UTYxV1hRNE8xOFNLWWRMcFE2M01PaktYbk5JQTdiZVFkMVF6?=
 =?utf-8?B?SVJXNnlubkEyM2dGbXlUZE5Rd3VXaUNDUWt6ak9jQzlIalgrY09Tc1E0M3VB?=
 =?utf-8?B?NGNHNkxhb1FrVDM5NGtPZEVCaG1VampQaW1QZWFUNnQ1eUt2QXVhaHgvcnJR?=
 =?utf-8?B?WWJzQXdnQmd5QlZCUmZ5emN2UDZUeFQvbWVMaXduZXk3NVFtVUJnMkQyNkFi?=
 =?utf-8?B?UmR5Z0Zvc2MxN0U5aHN1dHpLaUVkNnl5YUdhdWZnRDhwYlk3NUo3WmUvdEFk?=
 =?utf-8?B?WWRhTUc1S2ZKVHVzR2ZqYTgyWmxGMWVYY1JGeW1hREdsWkozd3lTUCtpWlh6?=
 =?utf-8?B?K1lQRHNKc2xRMjE1MGJ6WlR3N005a0ptM0FheU01RjUvcmorWXl5VHoxV0x3?=
 =?utf-8?B?cVhaVlpZSTVwaVhqREZsM3Y2b1BsSzBDNjBCdWVoN0twQWkxU3VYVEtUNUpv?=
 =?utf-8?B?MFpCbXBTSUhPTXNyTklncWJYUUNNSCt4WmJaLzV2Q2szcVFZdVZ4WG14Rk1L?=
 =?utf-8?B?REIxd0RFdGpzT2hOa1h0Mm1Jb05uSk92Z0pvdC8xa0hFTk9MNFJXQmM2eTdy?=
 =?utf-8?B?ZkpaeUhPbW1Qb09MQVhFTWxuNWwvVkNFc2xJNFhoL0tjUnZaSjdadXVkZ3No?=
 =?utf-8?B?SHQ4dkxmMVhuYkl4VGtVbHVkL1ptblNMQ09KSTBTS2JsWGlEdDM1Uk55a0Rr?=
 =?utf-8?B?bWhYZkIrU2VmOHNoM1luV3BYU2kwemRITmdKanRJN2hXMjhNRldBaDRYekVK?=
 =?utf-8?B?QmlhR0cvSXJ0bzNhUkt6RUMzQnJ2NHhYdUxCZ0VkV0p3RWpZSkhENnhuOGc1?=
 =?utf-8?B?dXhGVENhL2phSTNzRUUyU3FkcEJuanBTMVZVS3I0cmJyM3BPWmJXcjhoOUg0?=
 =?utf-8?B?dzRlTlRrWVRlUUU0NlFKU2QycFJ6STNoK1daVWNhV1RXVWEzTExkQU9JR2NT?=
 =?utf-8?B?UU92ZStieVBWTTZhVDZuUndFOVM2TkxxcnZPSDQrbjBKSDVuSlp5TzVpTmFX?=
 =?utf-8?B?cFp2NmxFdEk2cVRqUDkxblQvR0xOSjRlUE92Y1BmQnUwcUhFY3NMMWFUWW9W?=
 =?utf-8?B?a3NoUEFCeU5tcnh6SXhFZE1GZkRKTnNDWkk4eUM3YTFWbmNqTTZxTS9jQlNP?=
 =?utf-8?Q?ZcG8UpqoZsf0JUfWtu8lFvngP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cb3c61-668c-4394-fe5b-08ddc286dc90
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 03:31:04.4301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iF/Y+aQnL1Xt5FqPOLaQFGkLSPw+L29QnHLfzQymLLRHD4ZIFoazO4X6dQR1ZFls
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912
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

Please ignore this. A second version is sent with coding style changes.

Thanks,
Lijo

On 7/12/2025 9:58 AM, Lijo Lazar wrote:
> If dpm tables are already populated on SMU v13.0.6 SOCs, use the cached
> data. Otherwise, fetch values from firmware.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 38 +++++++++----------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 68624afe7d83..3d092fcd77b2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -881,51 +881,51 @@ static int smu_v13_0_6_get_dpm_ultimate_freq(struct smu_context *smu,
>  					     enum smu_clk_type clk_type,
>  					     uint32_t *min, uint32_t *max)
>  {
> +	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
>  	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct smu_13_0_dpm_table *dpm_table = NULL;
>  	struct PPTable_t *pptable =
>  		(struct PPTable_t *)smu_table->driver_pptable;
> -	uint32_t clock_limit = 0, param;
> +	uint32_t min_clk = 0, max_clk = 0, param;
>  	int ret = 0, clk_id = 0;
>  
> -	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type)) {
> +	/* Use dpm tables, if data is already fetched */
> +	if (pptable->Init) {
>  		switch (clk_type) {
>  		case SMU_MCLK:
>  		case SMU_UCLK:
> -			if (pptable->Init)
> -				clock_limit = pptable->UclkFrequencyTable[0];
> +			dpm_table = &dpm_context->dpm_tables.uclk_table;
>  			break;
>  		case SMU_GFXCLK:
>  		case SMU_SCLK:
> -			if (pptable->Init)
> -				clock_limit = pptable->MinGfxclkFrequency;
> +			dpm_table = &dpm_context->dpm_tables.gfx_table;
>  			break;
>  		case SMU_SOCCLK:
> -			if (pptable->Init)
> -				clock_limit = pptable->SocclkFrequencyTable[0];
> +			dpm_table = &dpm_context->dpm_tables.soc_table;
>  			break;
>  		case SMU_FCLK:
> -			if (pptable->Init)
> -				clock_limit = pptable->FclkFrequencyTable[0];
> +			dpm_table = &dpm_context->dpm_tables.fclk_table;
>  			break;
>  		case SMU_VCLK:
> -			if (pptable->Init)
> -				clock_limit = pptable->VclkFrequencyTable[0];
> +			dpm_table = &dpm_context->dpm_tables.vclk_table;
>  			break;
>  		case SMU_DCLK:
> -			if (pptable->Init)
> -				clock_limit = pptable->DclkFrequencyTable[0];
> +			dpm_table = &dpm_context->dpm_tables.dclk_table;
>  			break;
>  		default:
> -			break;
> +			return -EINVAL;
>  		}
>  
> -		if (min)
> -			*min = clock_limit;
> +		min_clk = dpm_table->min;
> +		max_clk = dpm_table->max;
>  
> +		if (min)
> +			*min = min_clk;
>  		if (max)
> -			*max = clock_limit;
> +			*max = max_clk;
>  
> -		return 0;
> +		if (min_clk && max_clk)
> +			return 0;
>  	}
>  
>  	if (!(clk_type == SMU_GFXCLK || clk_type == SMU_SCLK)) {

