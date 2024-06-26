Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A61FC27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 05:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAEB010E777;
	Wed, 26 Jun 2024 05:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lyIsmueF";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E0A10E777
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 05:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvPOSPbSwJuWN1sDpKgm+lBms5tTG+lJti1VttUHUcRonl3p0IUqQS518nhlUYDoVmYoJrbyutwbTkKlqBQ5i9vEfFV6z9wd2aFxhMjntRTm+etsiGzt5heWakWy8rjY0N8ppyirRrnowNiUr5S9FHf8aSe0TrlV2cjTeLnLFV9OiTWkd5H83xLakiRcFH4sTbkqI90In48XUZg5I5L/Cv0TmG1i0xc/e4OJILxwvA0LVvDTJXSbD1iC47hMSlfS7xfs7Bq+8Guhjs28fFcP7SQjdLos8md8ik9Jc+aiP15pXnCZ8RGaItMcjUPJY+v3zqru6efawoGYmtN6pN1JcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMQuAbpTLllV/J2cPNBne33guWHW/n96wi/i4gWrIk8=;
 b=EkoFnxspk3C0jZqW493/D1UVMa2CNSFoqacm1qWA+2EIIcPXb0ROt4R47X0+s7CJksPylPYylZFVi8sKzvXKY9kzr2dyEU35lj7cj0F/vOtDxMRceQM9NNHUGIbjlTTVh0DnTD14IZQ956bWzXGFRdz+1IyhCSC0IOlmoUcsvy4U1hWivktzKrdkqJzpY14qWVG7Fjq2SmO5T/hz0Ig9xGermMs/edzuIIv8OOSA7rMR/yzy9psV8yPvr4fLdxILQViXE2Oe/t9hiAfCfPJ9vVVvDOcCGh8ZWyvctkRQR1s0e1Dd8KCLfzx5K4bKTyJ27zj0vI1j7FehGXhWJPMa5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMQuAbpTLllV/J2cPNBne33guWHW/n96wi/i4gWrIk8=;
 b=lyIsmueFlNBzN+m5mMqZT7+gYUfAGub8OTJDofKbwm4y/R2FkkLP797Kry2v3eRixXPrn3pNql1W/8nLoNhj/8fid7YUB62JyPWyxvASKtwGTlxlaJaSJfWWwt/klzT8WeKH6V7t5+ft15xtVwCawHJGIrW/mD1vEUIoa5A/bPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Wed, 26 Jun 2024 05:47:04 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 05:47:04 +0000
Message-ID: <162d05ba-d7b7-4cf4-9be7-f78c876687fd@amd.com>
Date: Wed, 26 Jun 2024 11:16:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: normalize registers as local xcc to
 read/write in gfx_v9_4_3
To: Jane Jian <Jane.Jian@amd.com>, christian.koenig@amd.com,
 Haijun.Chang@amd.com, Victor.Zhao@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240626030129.2551363-1-Jane.Jian@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240626030129.2551363-1-Jane.Jian@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::36) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: d76e64d4-7e82-4303-8115-08dc95a36864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|376012|366014|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmFZSXBvMG9qZVdZN2RpeXNMaytGaXhRY2QvTVRHWkUxUmh0VXAxV2ZYZi83?=
 =?utf-8?B?aS9WNjRuc0MzNjNYdm1TUEtVSC95eVEzZFhqOGRWZVM0bmZudjI0WlZUZ1I0?=
 =?utf-8?B?V1dkUlA4Y2pUZSt0TUxraStyM1NXSloyc1RMdi91NzJWTjQzT3ppRDVrRk92?=
 =?utf-8?B?d0JmWnZNQUl6SmpVT3FNZDk0cUdGaktMWTNOYXMrdlBJNEsyekhxYkg5ZE1X?=
 =?utf-8?B?SmhFTzNHZ0wxL29nQ0VmTzhqMEVEcEQwZnlxNmxYVTR4ZG1zZE9UK1dKMU5E?=
 =?utf-8?B?Um9WSDloRlNTRVBwS0RtNXlPVmxrU0FjaTNyLzVQdC9rWGgxZlozTWFuYTRn?=
 =?utf-8?B?V3J2Q3dFR1g2dURDNFROa2QxVUtkRVFCcCthSUhVM2FFSVBjZGhGQ2ZRdG0y?=
 =?utf-8?B?eDdWUTVFWTlHWi9HRmZ3MjgrdytOejFhUHNyeE5uQ3h1QVY4L25lWk5uL0ZS?=
 =?utf-8?B?TW1ETzc3UTVNOGJXZWxwclU0cmlIM09UWVN3U3JTaE12NFJsUkdIWmh3c01Q?=
 =?utf-8?B?ck1OSGtPbUsvVEpUM2VERHlpSnpFQ29PNVJSQmFUVEVab0ErZ3pjbmRGTTZ2?=
 =?utf-8?B?VUNsL3Q1d01vUVpzT01EQVFBcXdVT1dIeGdJV3RzMUNEU1VoYkxpL3BtMkRk?=
 =?utf-8?B?L296b29kekkrTHdybVlJR1RnaDNMVVZFUGpNNk9vQWs1RzRvVEFMd1A4dS9i?=
 =?utf-8?B?ZExBOGFVV2FwWXlaN0YrSGs5Q0Z6czBXdFQrWTEzU1ZUc2YrM21xSjcyUGZV?=
 =?utf-8?B?cG1LYnZwZkwvU3g4WUJCczRtby9QZ1JFQ0J6cklraHl1VzA5ZTJOb1llYnFL?=
 =?utf-8?B?Zm5oY05pbng5YTB4cjY5VmtxcU9zTDJJejBML0kzSDl4QmcyM3VNN3JwM2Vx?=
 =?utf-8?B?M2R1dXdYZ3pDTTNObVJNcnR6RFpldlVxTUJIalZacmI5UEUrY1ZkbmNTbG5r?=
 =?utf-8?B?OWRDZzcxQXN6cnBlUDRzdmVSOVgwU3AvN1ZWSFZWRHB3aW5pUDMyWHF1UU8x?=
 =?utf-8?B?TzcwR1pRdXlLVjFKL0VESjEwSWdrRENReFg5STBoeDR1ZGEyMEV6TWhicHdO?=
 =?utf-8?B?cHYxL3dZRndFTHVRRjR3YXhyVWtIZGtWNFVPZngzd1FNUTRPK2hhMVd6Smdz?=
 =?utf-8?B?OEVuWWY2VjVqaXBtUFhaWkJHL05RQXY3TkFsZnExSlNDUG5ZM0M0MXFkZXo5?=
 =?utf-8?B?ejlSZ0V4dXJSUlRyVW45elZvUnE1d25VUkhUb25CTXd3ZWR2b1VKZFpLOEVl?=
 =?utf-8?B?dkxFSUl1NUlpSEV4blVtdDBmQ21VVWo1OFVtL29MM1QzVi8wdFcwdkNlcmNz?=
 =?utf-8?B?MytvUUtpYnRwVUVRL0N0dW00TlFmUEcwRWJEbnFmeEhodTlONmF3TWRUYXJr?=
 =?utf-8?B?d2owQjIzTlZxVmNvd3A2N0RuMXJvc2dpdzl1WVU2OWFWOUdBUEYrV3NvenA2?=
 =?utf-8?B?WVY1dW4zTnlraDNrYnBVaFE3MmhaR3ZoT2hDSHd3V0Q4dy84cmNmVzFLNGR5?=
 =?utf-8?B?a0loYmxQT2w0ZFhJMFlHODc2T01DWkY3SVZha2JxS082QVRkOGMyVXhYT1cz?=
 =?utf-8?B?OVhmTTJ4Z0cxUmlQcjlpb1VkazFyaDREaFNOenRHNnVULzFxNkx2SG9GWmlw?=
 =?utf-8?B?clFPOEE3ZFlQYVRQb1djdkdOcit3VlN0UVpUU2EzMEdrMlFmb3BpUWlUSFd0?=
 =?utf-8?B?akxTRjkzSVhSQVdyb0NYT2ZsUmUyV2ZibUk1cW1jR2lpNDRqd2daT1I2Y0VX?=
 =?utf-8?Q?vJzGFQlXQwjJSIELvFLOV8IiqyCC+Y59hNvCeIv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(376012)(366014)(1800799022); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlNsTEVSbExUWXNWVk1JRHgxY2pVYTN2UDlxQk16ZDRaQlpBaWlkSXhReHBu?=
 =?utf-8?B?WTRzTExoa3pPRUJ3NWpqZ2IrVGNqRjhMMmhTeUZWZjFPM0QyTlliWHd0SzhF?=
 =?utf-8?B?bVYxY3pNcEx3b2xaZUdrZUVyam5ieHM3akFUWjY0VWlkS2pEV0NZODZtRmxz?=
 =?utf-8?B?aXlXYjFxUnN0RTVFUTBrZXhBSVhHcUVKV0VXOTNjSmlkREg4VUl5ZDVlaXBv?=
 =?utf-8?B?bUpxdytZV1h3Qy82VDBReG9JVzJzRlNocW5QeURsNjFyN0owRTk3NCt0S3Fl?=
 =?utf-8?B?SWN2QWVzREFkdmh2Qk93Tm9PNmFUaDBJaXNBQUQzb2hPVkx6dm01OUFmZThp?=
 =?utf-8?B?QUE1Qkk3YTJ0MGRvanBWWjA2aS9Sdldla3hyZU9FcHQ4dnlHajhkQnMwYURZ?=
 =?utf-8?B?MG9vM0VvZ2RiS0R0b1NGejltNWoxZHRpTDlaVjZmdndGTGxhOEdOakhQY1Y5?=
 =?utf-8?B?TDZucUVFeS9WTDFGUDhQZzlZT3B6VmxBQTlHVDErN1ZzazZqWmNKZG00VlUy?=
 =?utf-8?B?cTFBM3Bsc0dESWtkbi90RmZ1alZ3RHFseURKS1VWY1RKRkxoTnZVTzJzRzZx?=
 =?utf-8?B?UTRuWS9TMFlDRUZ4WGVGWm9IUlBZQXNEczBmaDh0VTNyQWpVdEZJRU9PTUhm?=
 =?utf-8?B?MFBYTGxLVC9Vc1R5ZnFQVjlwM05TajZnRXZWQSt6Qm9OWDF1Y0pXNm1Fd2di?=
 =?utf-8?B?WWFRaUxLNlhvd2JNTk96UFZSdUszVzJOYmhuNFcxOEdpcDArREJDcXJkeWVP?=
 =?utf-8?B?RExaUEkzVE1pVFBQd2NQRVltcEhlUi9ONFVYTGFMem1CYVViR2JySzlERktX?=
 =?utf-8?B?MWFJK004cXZpZ1FGT0IycVlkWkpuTXczUEZMRmNmVEVlN2E0RmJMcVhGejd4?=
 =?utf-8?B?dXpIZHhaZWx5ODdlOE5XYjloNE9WczZ5RkY3cy9uUVQ5alBDWklqWTJ1a0Vu?=
 =?utf-8?B?a2VRQlFGbE5vSzZwTGczbTdRbS9MaEhVVmpzY0pVeUdGb0VVRU9FWjBhb3lF?=
 =?utf-8?B?aEo2c3BUdUdLN3M3QzBvUUovZTZTL2dlVDg5cEswZ1pTWmJFSUhoQlU1eDVk?=
 =?utf-8?B?ODRDZzNmZS9lT2pJL3Y3Sm5xVDRHNnYwZ3NMWXFpc1VqNGNON0RISFJ3cjVD?=
 =?utf-8?B?QmQ4OWhWZ2MyQm04cW9JVWNaTWdEdmIvTEpJYURRaldkWUpSMlNmeXd4cmQ5?=
 =?utf-8?B?cWlHQmdRMkE3a0M4b3E1SVRQclpVN2RoNXJ4RHcrOVhlaTNqaldpc1RmVzc1?=
 =?utf-8?B?M3FlbUl3WnFIMG1qNlhoRVM0U3RTcFNPaVoxWlFJdmlmY3FuVXR2ZVhleW9h?=
 =?utf-8?B?c3AxSmwraWxyYzJaMzdvTHpicGtTYjFUMWlBUUNKRWYvMVY0TERGdXJVNEJq?=
 =?utf-8?B?RU40SU53SXZtV2RCMjJQanBQZWJUSmlMWFEzZWl6Uy81LzBybnZvai81cURJ?=
 =?utf-8?B?V2t5OFZGZWdjeDdqSjQvN0F1QkIvUkp1dmNZdjBTQ3U2UlpKSHc1c2J5akEw?=
 =?utf-8?B?RVFMNmN2a09TM1hiV0VMSjVMcEtydVRNY0NRTjJkaUZqN2N1M1RjMjNzalFJ?=
 =?utf-8?B?QXFleG93Z3UyYnJNNG03RWFXZ05jaHRZcjNSZGNjWVR2dHB5ZzB5cllVRmhN?=
 =?utf-8?B?M284UmlvTEZVTFZPVm9BdnQzd0QvRCtrVUNXMGQ2VmM4V1FCZnpwNjNxSGhr?=
 =?utf-8?B?MVNlK0R5dkFiNGtCSmlRNmFSeFhOQzR3TUlnN2xQZUxUV2k1bWNoV0N5bEJL?=
 =?utf-8?B?dU1qUFRTdWNGdWx5ZW01VXdTaDlVYXJNMnpnWVQ3bGJCcUN2NFNrbVQzSktL?=
 =?utf-8?B?T1N2YlVwWlBMNXJPb0h6WGRBSEoybkxxdWhDcDQrVTd2aFIyMFpkY3lCa2lD?=
 =?utf-8?B?RXNQTStFUUlJdkFjRUVZWSt5N0ErWWkrQVJWMWtsNm9Ia05nMmpGUzdDZVdZ?=
 =?utf-8?B?cFRsNXNSZlgwQk1IajRJT1JzekhkMmxaaVZjK0J2Zmd5dTMzRy85UzFYdFZh?=
 =?utf-8?B?cjhyTGEzYWF0dTl1SlllVE8xN1hhb01rQnVCVm02aUpNZ01CVlJJVzA2a0pT?=
 =?utf-8?B?WU9yaU9VWjdPTUlyUzZZU2p4eDFsYTZ0SHN6QXdwZWwvbjlQbEhzOWdqa3ds?=
 =?utf-8?Q?uS7gsfXzNKZ6BD/aTmT7/FfdX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76e64d4-7e82-4303-8115-08dc95a36864
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 05:47:04.7014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8zQlHcpfjtoUXzVGfPVFJIk/vtqO0jb4PyRMzlrOYsIQjSGL8/YSHLnnWiOLsl+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
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



On 6/26/2024 8:31 AM, Jane Jian wrote:
> [WHY]
> sriov has the higher bit violation when flushing tlb
> 
> [HOW]
> normalize the registers to keep lower 16-bit(dword aligned) to aviod higher bit violation
> RLCG will mask xcd out and always assume it's accessing its own xcd
> 
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 29 +++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 8d8763ebe027..87a6a610e467 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -55,6 +55,14 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
>  #define mmSMNAID_XCD1_MCA_SMU 0x38430400	/* SMN AID XCD1 */
>  #define mmSMNXCD_XCD0_MCA_SMU 0x40430400	/* SMN XCD XCD0 */
>  
> +#define XCC_REG_RANGE_0_LOW  0x2000     /* XCC gfxdec0 lower Bound */
> +#define XCC_REG_RANGE_0_HIGH 0x3400     /* XCC gfxdec0 upper Bound */
> +#define XCC_REG_RANGE_1_LOW  0xA000     /* XCC gfxdec1 lower Bound */
> +#define XCC_REG_RANGE_1_HIGH 0x10000    /* XCC gfxdec1 upper Bound */
> +
> +#define NORMALIZE_XCC_REG_OFFSET(offset) \
> +	(offset & 0xFFFF)
> +
>  struct amdgpu_gfx_ras gfx_v9_4_3_ras;
>  
>  static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev);
> @@ -217,9 +225,24 @@ static void gfx_v9_4_3_init_golden_registers(struct amdgpu_device *adev)
>  	}
>  }
>  
> +static uint32_t gfx_v9_4_3_normalize_xcc_reg_offset(uint32_t reg)
> +{
> +	uint32_t normalized_reg = NORMALIZE_XCC_REG_OFFSET(reg);
> +
> +	/* If it is an XCC reg, normalize the reg to keep
> +	   lower 16 bits in local xcc */
> +
> +	if (((normalized_reg >= XCC_REG_RANGE_0_LOW) && (normalized_reg < XCC_REG_RANGE_0_HIGH)) ||
> +		((normalized_reg >= XCC_REG_RANGE_1_LOW) && (normalized_reg < XCC_REG_RANGE_1_HIGH)))
> +		return normalized_reg;
> +	else
> +		return reg;
> +}
> +
>  static void gfx_v9_4_3_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
>  				       bool wc, uint32_t reg, uint32_t val)
>  {
> +	reg = gfx_v9_4_3_normalize_xcc_reg_offset(reg);
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
>  	amdgpu_ring_write(ring, WRITE_DATA_ENGINE_SEL(eng_sel) |
>  				WRITE_DATA_DST_SEL(0) |
> @@ -234,6 +257,8 @@ static void gfx_v9_4_3_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
>  				  uint32_t addr1, uint32_t ref, uint32_t mask,
>  				  uint32_t inv)
>  {
> +	addr0 = gfx_v9_4_3_normalize_xcc_reg_offset(addr0);
> +	addr1 = gfx_v9_4_3_normalize_xcc_reg_offset(addr1);

I guess, this should be done only if it's regspace. Apart from that,
this looks good.

Thanks,
Lijo

>  	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>  	amdgpu_ring_write(ring,
>  				 /* memory (1) or register (0) */
> @@ -2725,6 +2750,8 @@ static void gfx_v9_4_3_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  
> +	reg = gfx_v9_4_3_normalize_xcc_reg_offset(reg);
> +
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>  	amdgpu_ring_write(ring, 0 |	/* src: register*/
>  				(5 << 8) |	/* dst: memory */
> @@ -2742,6 +2769,8 @@ static void gfx_v9_4_3_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
>  {
>  	uint32_t cmd = 0;
>  
> +	reg = gfx_v9_4_3_normalize_xcc_reg_offset(reg);
> +
>  	switch (ring->funcs->type) {
>  	case AMDGPU_RING_TYPE_GFX:
>  		cmd = WRITE_DATA_ENGINE_SEL(1) | WR_CONFIRM;
