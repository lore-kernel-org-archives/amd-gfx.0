Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C05CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 21:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CAE10E8D7;
	Wed,  8 Oct 2025 21:02:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l9DJcuPO";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE2110E8D7
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 21:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gM2QMQyMNwyBugCxffNRQvi2d9eDiOTpkL3mxEaPKA6T76j3z04WvNy/5YaeF59rsGRezVB6ysscCz6O6nDTY+LEFdhufbOfv22ppvbEyEm8Yrevf3JXd9vXYtLvSENDMyRwXt1gUQQAq7dgZ2wNTqOLznT1hPdZ3pEjplCG6uDinWQzi5Dx/65sPTkf8VUD4n1GzmpVExu5DySDMkYbSu4S3bCEnh0O3am4GhrQJ1QMDPxOQBHioW70f9smFGQYttUPHgMHVhBTL+Ueab34m9xgcMGZmyqUeyDSU8FFsWF8MFIQjNQDrAArYA5AgIm1sGsDuokzgm60MFcE07yM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRMH+mFT6k1yTUaHDU1GHLWAAFy1Yjw43FdPlaOzfQA=;
 b=x1hTxOeGvEZO3IHIgSWPuOJ5i2BotzkrNs/3+VvLWHwftez0CPUK+tYhwkoliqyAEK+bqYGDjJQmc/4SHIEWrmJdSfZY5HF5Sun1TDMcyh7l/w8/p+s6Eaq3c9303W/oaOzcgr1D7wgv7f1nHVGE0POyci4j9pdsiaspKe0h3G3mDvoRc5O2su1hQXwmCDgpA6Q1+PePP9bUMWpRKzo6fe+2xy0E3/Zbv8lVB9rwKGnWd/Hy5yppWE0ae0Mis8tXnAjAAZg56O6RjnKwMxVdfw/NTH43WXkTbGmrc6qhr/HKkuryWBvHGzy4HHmB4CyZYS6u1nCSc7I2XreGMkXlVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRMH+mFT6k1yTUaHDU1GHLWAAFy1Yjw43FdPlaOzfQA=;
 b=l9DJcuPO/yDXYTbmvDECNYBU2WR44tRN74B15ZNlo8JecnT8pS9HZIfbw199chIWFcFUfJ3Ze9gJBxQByu33fjEAyA6WzawMqkZfNsRUMBwIhFMVtQVRqtwpcmLOB+Awqz4RDqibzf06tmqroOPFTrIwP2PSrQC6ski/IeVth2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 21:02:28 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14%6]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 21:02:28 +0000
Message-ID: <ffba264c-0a64-43ab-87ad-ded497358118@amd.com>
Date: Wed, 8 Oct 2025 17:01:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/23] drm/amd/display: Support DAC in dce110_hwseq
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, siqueira@igalia.com,
 christian.koenig@amd.com
References: <20250926180203.16690-1-timur.kristof@gmail.com>
 <20250926180203.16690-14-timur.kristof@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250926180203.16690-14-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d76859-f510-445a-0a76-08de06adfcc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUhFalU1dXEzVzQ1MWxUVTUycDg2Z2t1eGNvRUJSbEwrZXdMYVRKa1FCci9i?=
 =?utf-8?B?RXBmSnl4UEczMjQyM3FERUdKaVJwSkRqc3ZFVUpNUWlSZTk2MkhFQUFDa2I4?=
 =?utf-8?B?TlhPS2UyNjBwNi9WRGZSelRSaHN3OVpDSEFiZWYyb01ZQjF3MkNPSTk2aVpB?=
 =?utf-8?B?OFlBTGtvZW42aCtQeDRKdWwweWZPOGVTSENyY0xjeGxhUVpZZWpVVHlyVE05?=
 =?utf-8?B?NWJGczZFUjlwVm1YYWJYMTl6VmpXZDVhTHFrMzlGaHlxOFZPRWFHQTgwZHM0?=
 =?utf-8?B?WjFtZ3piWkl4N3VFMUxUZWd0WUJrUmR3RjFsSlRxem1HYjRjMEYzZHNPd081?=
 =?utf-8?B?dFBXZllHT2pjN05VYklCVGUxbHRiZjR0K1Z0ZkozRnlCcndjVmNVa0lobC95?=
 =?utf-8?B?cnlWVlI3bVJkVEhmUXVaV3N6c1JlTXh1NUV6a0x2c3ZZQXJPU3BYYnNLTUFq?=
 =?utf-8?B?d09Tb0tkc1dEK3JUdENoaTlvbjM3Ym9HMllURXN6WThxcDBsZXdqYkJieXMr?=
 =?utf-8?B?YkxXK2FNWmp6Z2ljSXpscWlWSktzMDlGUGhBT2kzR0pTYytKQ0hRdlJ4VFVJ?=
 =?utf-8?B?SngrN2Rva3RTMDBLeHdiVDNDbTZCQk5lQ2VkRlN2SDRHQzRpQTN3ZWh2N3ZQ?=
 =?utf-8?B?c295clc0TUFlQnJsMVRNcDIrOE5zc1pVVDZPeTc3NEpFZUFWcVd6MVZvWkcw?=
 =?utf-8?B?SVh5ck5FWHdkQ0doWlJFQzIrVkRZYmhrUkl2NzgwRTMvdWJBRjdBbGVjS1JL?=
 =?utf-8?B?TzkzTGtzQVdHNTB1eGJURTIwYW52V3ozYnlpQWxZWE1BVTFRZndMTFNLd1Jx?=
 =?utf-8?B?QmpleFVscVBxaDFNZm50M1lPMFdOc1pmTCtHZ3ZWNyt4NmM0dk45NGpUQ0hj?=
 =?utf-8?B?S0JlbUtXS2dWdUVxQVAyc3lUNUVVZ2hYWGI0VWErRE5qMGdPVUhxSEQwRDE2?=
 =?utf-8?B?MzZENHMwdnBZQnA4WmVSN09xUW5GL2FOTVozV1NrNjlkSXE1aHh4cEJIbWI3?=
 =?utf-8?B?ZXBPZlV6UzR5SEdUbGJrZVVXRGp0enhaVU5SQkhJczhldlVURjgwa1NSQjNV?=
 =?utf-8?B?bjZML0NYMDIwSXRvYVp3b2ZzUVdtUDEvRk14WDVUbDg2eGNUZWNQZVRNSXNz?=
 =?utf-8?B?alZLM2JhdlpxdFdKUFhKVk92cDlrZDhEc0NibXphRmw4aytBQWZVTHNIUHZz?=
 =?utf-8?B?ckloNlFOcHdZeGlia1JtdHl2SnVkUjR4b0g4U3hsSXU5QzhJZVQ2SmVjK01D?=
 =?utf-8?B?WFNlak9ZNlhvMFZNbUEybCtVZG9VNjdOUHNVcXpHSGU3alJSMk9wVDJNYlIz?=
 =?utf-8?B?SmFGOWpOc1d4cC9rVkNKZ0VPT3QwMVA5KzVucE5RVHdxSFp6bWlKVmxUM2sy?=
 =?utf-8?B?MUx2SXgzT0FQVlJpN3VuemZWTGpIMll6NHY0SEFZWU54TnoySEQvbDJZWlpk?=
 =?utf-8?B?c25iMnN4WFJmMGV4RUhBQWdyWVJYKyswS2Z4R0ZMeEFOYnhEbGJQYnF2V2hY?=
 =?utf-8?B?TnpSTnAwWGRGQWx0SW50VWV3NzJCdHpxZ2dPRy9GRTUyMk5LOHY2SlFROFVY?=
 =?utf-8?B?akh5NmY2VmluYzU2MjVXSyt5cjZPcEZVUWxNRzVtRHN3SEd1WHo4MmF5dlQy?=
 =?utf-8?B?RnZqbVRMVDh0OTNjbFgxSVZFTzJzRjRSMVNkaWZRLzNVOE9ydGJ3YWZRc1Zu?=
 =?utf-8?B?T0tBa3BsNUxTSTRoQkFpUHFoVFZST3VENGdWZTZXT0ZseUY0dUZnTFBJbEJv?=
 =?utf-8?B?YkZPb2VoQ2FGVjlwUzhOL29xYkh1eTdHWkhIRlpBNjJrOFlCL24zWFl1a05O?=
 =?utf-8?B?WmVGdWlxSjBON1JTNkV4Zmloc3A4R1VmVEVQMXdtV0R5ZDRhM1RLcGc5RHZV?=
 =?utf-8?B?dmdKK0x3RzBoUzFsb3IycytIbExSSnN5MjVpNUFTSXVxTDdLa2trU1hkb1lo?=
 =?utf-8?Q?t6ISPQjeykT1eI66izzLZkvjG6GaC2+a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXhjK2xWWi9wd1l1RjlKRFNTZldmcEtnR0h3TUJ5ZlNkMDVWNWMwWHM0OTRK?=
 =?utf-8?B?ckpGVENYQzd4UUtNSjN0MDFOY0F1NGRvMmRid3owM3h5ZGlTYjN4TTR3Q1FW?=
 =?utf-8?B?TFdqbUl0SWdWckRLNDFRWkpnY1pCV1h5RlNjOUlYMERGM3JCN0RIZ0x2WVAv?=
 =?utf-8?B?NXh3TGxUeDN6Sk1GdUY4OVV6UTZqWGRSWExMZ0lGcVBta1JDR0tXY1pDWFdv?=
 =?utf-8?B?Wnh1UUs0cFBhUzJLSSt3MjQ1RGh2T3lDNlNpZXArUVVRQlNoUE1jcUI0T2s5?=
 =?utf-8?B?bUxiZEZqaUp4SWtWNEVrT3QvaUxTUGszTGs5dGFSTGRPek9hd0VsWEtPNzNI?=
 =?utf-8?B?ZjNHNDlTdTZySzg3R0JPK25taHFSZFZMNmxVUm5lTjBvWmZQSVc4empEc2ll?=
 =?utf-8?B?NmhxK3FFWkxYclFwaVlNWTdCaTZTeG1lbUFBcEwyOGl4NjlsdGtPSVNQdity?=
 =?utf-8?B?Ni9ieGQxNkVwalVWQWFOY0gwVVlvQmxoYVphK0RlQVZsak0wcUpRWGxHM1BU?=
 =?utf-8?B?K1BWT21qMXJwZ1g2MnBEWmE0c2NOK3Ryb1VDbVVYZ2QwODdtNEwvY25LRHNE?=
 =?utf-8?B?cDVvRmlST3l1Z0hselBpN0VicEJzOXZkaE1GMkNxbHgvUkV4c2h0RjhLM1lY?=
 =?utf-8?B?blBhWVBrMDV2R0drdUxLWCttTkFFYzZKRjJGeUt6RTV0TUpjMjNxd0drT2tp?=
 =?utf-8?B?RTJxOGtMQXdmaVVvSlp4RForVU5ycDFNZzVuTG9VeDdmQ29qUkhjY3pEVFhD?=
 =?utf-8?B?ZmQxUWcvaFo3ckltc0oza2JBVzdTdTZIT0preVFHT1BLdXFwVjhQZ2lPdDdU?=
 =?utf-8?B?TXBHTWNFelhtSDNLdy9IRHNvVEppYkNIQnREY0o4TCtJaFRuY05Bek5GMXFM?=
 =?utf-8?B?OWhWaEtabXFWcGoyZHBLM3c4N1hLTzVRNzhkb2N2ZFNuVXJTclJqWC9xWGtW?=
 =?utf-8?B?a3lCZFlJNGVmY1NZeENoNG1MMmdINnIyUDJQVmk0dXVZU3VnZEtyUXZsVFh2?=
 =?utf-8?B?eGJmVThIM29HWXFtM2JGMHVwSWhOb3g1TFNoMW1rZ1poVVgzZjBnL0NXUVdy?=
 =?utf-8?B?cDY5SDF5WS9xQ0tlQTYrK1BYMTh1UVhuM1JnS01FYzdaQjNORWgyNE5FWWZj?=
 =?utf-8?B?SklhcklJV3ZjUElZNkVHU294Z0tUTTFTdlYxMFFxcDRCUFFDUWx4eVlYckIv?=
 =?utf-8?B?SzlRWm95SFhsR09ONFBJOTBMZitUL05semhES3hIbnF2Tm94NGxuMjliNHlv?=
 =?utf-8?B?TUdGYVB6T1plN2RXMUxJbkJsdExTNWVTVkF6ZExEWmtnZ2tKN1dFSE1abWZK?=
 =?utf-8?B?aEtybTE5WW1WRGJnRjNoZ1lNSDFPWGUzM1JjcnVmSnY1L09ldEJ6V2ljMHlB?=
 =?utf-8?B?Yk9xS3d0dGlGRk1UZkdPY3hvYkN1T3pGdm1raXkrYjRnNWxnQ3B1dFFQRnQ3?=
 =?utf-8?B?VVhIYkZ2MVRpWmNaSlBMOUEwR0tzQWFuYmp2N3NuRnI0RUhKQXp1VjlqYWVw?=
 =?utf-8?B?ak9iK2FVL0pRczYyM1U5bm4wUlA1d1lIRjdPTE5OSDBSQWQvR3RuTVp3YVBG?=
 =?utf-8?B?bDF4dXRxcUpJN0VUNFF2UlNTeUEvbXR5YUxHc1k5ZGtRL2FnV25mK2I4VnRN?=
 =?utf-8?B?aHE3V0l1L2N3T2JvcDJCTXRkZjJOMU5DUlY4a2I4L2VmdDBsdjdFVXVDcTA4?=
 =?utf-8?B?M2c0b0x2OTBXMlJVWFp0RFBxaTkydGd4OWxEVm9veEx3aU5EbER0TzZlK0NN?=
 =?utf-8?B?YitHdDRNcDh4RjR2UU5hZ2RMK2VLeFZ4bklDZ2J6VFdYNEFJME1EK0txRHpn?=
 =?utf-8?B?N1U3WWJ6Y2hKcFpubnE0RUhsa0R6OTJ2bE1zQTlIUkpjQVJQUzdvcUsvTDBU?=
 =?utf-8?B?WUVQSXZudnBlYTVRSElFbXFEU21YRURCTGpydE05ZGhWdyswbEpyOTFxMG8w?=
 =?utf-8?B?QUVJYjZYSHp0WnoxUDYrZE1tOTNJdkYvSVpiTVZVaCtVZXZMK3FJTkNqQ29p?=
 =?utf-8?B?Z1R1SERCSWp2UUpTOWtWSnVFSEZYckluVStZRGtUVnhLYUNtTlN6Z0xvUU5s?=
 =?utf-8?B?clMxWDVIVVpFeHp0cm44WjljODRCcExaeHd4b0s1TDBRZjk3b1ZncXBTdDdS?=
 =?utf-8?Q?OkoD6zkXwSFkV+fAk/uqVH4Yq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d76859-f510-445a-0a76-08de06adfcc0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 21:02:28.4008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6ZWvMzqwH1SvcCUOmQii/zHetDUr6eBiZe5ip0xdeNvVGXDhgglXp9qITFDUGRIepESpIO758MBqO9jL09yRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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



On 2025-09-26 14:01, Timur Kristóf wrote:
> The dce110_hwseq is used by all DCE hardware,
> so add the DAC support here.
> 
> When enabling/disabling a stream for a RGB signal,
> this will call the VBIOS to enable/disable the DAC.
> Additionally, when applying the controller context,
> call SelectCRTC_Source from VBIOS in order to
> direct the CRTC output to the DAC.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 75 ++++++++++++++++++-
>  1 file changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index 24184b4eb352..975913375d05 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -659,6 +659,20 @@ void dce110_update_info_frame(struct pipe_ctx *pipe_ctx)
>  	}
>  }
>  
> +static void
> +dce110_dac_encoder_control(struct pipe_ctx *pipe_ctx, bool enable)
> +{
> +	struct dc_link *link = pipe_ctx->stream->link;
> +	struct dc_bios *bios = link->ctx->dc_bios;
> +	struct bp_encoder_control encoder_control = {0};
> +
> +	encoder_control.action = enable ? ENCODER_CONTROL_ENABLE : ENCODER_CONTROL_DISABLE;
> +	encoder_control.engine_id = link->link_enc->analog_engine;
> +	encoder_control.pixel_clock = pipe_ctx->stream->timing.pix_clk_100hz / 10;
> +
> +	bios->funcs->encoder_control(bios, &encoder_control);
> +}
> +
>  void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
>  {
>  	enum dc_lane_count lane_count =
> @@ -689,6 +703,9 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
>  		early_control = lane_count;
>  
>  	tg->funcs->set_early_control(tg, early_control);
> +
> +	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
> +		dce110_dac_encoder_control(pipe_ctx, true);
>  }
>  
>  static enum bp_result link_transmitter_control(
> @@ -1176,7 +1193,8 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
>  		pipe_ctx->stream_res.stream_enc->funcs->stop_dp_info_packets(
>  			pipe_ctx->stream_res.stream_enc);
>  
> -	dc->hwss.disable_audio_stream(pipe_ctx);
> +	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
> +		dc->hwss.disable_audio_stream(pipe_ctx);

Nit: this hunk would fit better in Patch 7.

Harry

>  
>  	link_hwss->reset_stream_encoder(pipe_ctx);
>  
> @@ -1196,6 +1214,9 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
>  		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
>  					       link_enc->transmitter - TRANSMITTER_UNIPHY_A);
>  	}
> +
> +	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
> +		dce110_dac_encoder_control(pipe_ctx, false);
>  }
>  
>  void dce110_unblank_stream(struct pipe_ctx *pipe_ctx,
> @@ -1581,6 +1602,51 @@ static enum dc_status dce110_enable_stream_timing(
>  	return DC_OK;
>  }
>  
> +static void
> +dce110_select_crtc_source(struct pipe_ctx *pipe_ctx)
> +{
> +	struct dc_link *link = pipe_ctx->stream->link;
> +	struct dc_bios *bios = link->ctx->dc_bios;
> +	struct bp_crtc_source_select crtc_source_select = {0};
> +	enum engine_id engine_id = link->link_enc->preferred_engine;
> +	uint8_t bit_depth;
> +
> +	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
> +		engine_id = link->link_enc->analog_engine;
> +
> +	switch (pipe_ctx->stream->timing.display_color_depth) {
> +	case COLOR_DEPTH_UNDEFINED:
> +		bit_depth = 0;
> +		break;
> +	case COLOR_DEPTH_666:
> +		bit_depth = 6;
> +		break;
> +	default:
> +	case COLOR_DEPTH_888:
> +		bit_depth = 8;
> +		break;
> +	case COLOR_DEPTH_101010:
> +		bit_depth = 10;
> +		break;
> +	case COLOR_DEPTH_121212:
> +		bit_depth = 12;
> +		break;
> +	case COLOR_DEPTH_141414:
> +		bit_depth = 14;
> +		break;
> +	case COLOR_DEPTH_161616:
> +		bit_depth = 16;
> +		break;
> +	}
> +
> +	crtc_source_select.controller_id = CONTROLLER_ID_D0 + pipe_ctx->stream_res.tg->inst;
> +	crtc_source_select.bit_depth = bit_depth;
> +	crtc_source_select.engine_id = engine_id;
> +	crtc_source_select.sink_signal = pipe_ctx->stream->signal;
> +
> +	bios->funcs->select_crtc_source(bios, &crtc_source_select);
> +}
> +
>  enum dc_status dce110_apply_single_controller_ctx_to_hw(
>  		struct pipe_ctx *pipe_ctx,
>  		struct dc_state *context,
> @@ -1600,6 +1666,10 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
>  		hws->funcs.disable_stream_gating(dc, pipe_ctx);
>  	}
>  
> +	if (pipe_ctx->stream->signal == SIGNAL_TYPE_RGB) {
> +		dce110_select_crtc_source(pipe_ctx);
> +	}
> +
>  	if (pipe_ctx->stream_res.audio != NULL) {
>  		struct audio_output audio_output = {0};
>  
> @@ -1679,7 +1749,8 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
>  		pipe_ctx->stream_res.tg->funcs->set_static_screen_control(
>  				pipe_ctx->stream_res.tg, event_triggers, 2);
>  
> -	if (!dc_is_virtual_signal(pipe_ctx->stream->signal))
> +	if (!dc_is_virtual_signal(pipe_ctx->stream->signal) &&
> +		!dc_is_rgb_signal(pipe_ctx->stream->signal))
>  		pipe_ctx->stream_res.stream_enc->funcs->dig_connect_to_otg(
>  			pipe_ctx->stream_res.stream_enc,
>  			pipe_ctx->stream_res.tg->inst);

