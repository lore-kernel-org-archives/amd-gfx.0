Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B88C27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 10:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70BDE10EC02;
	Wed, 19 Jun 2024 10:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HHkFDDrU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5FBE10EC02
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 10:05:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grZ9mLNQtq7gqEcHUPd3bT8VjmGDpG5GQZs27X0TdLFQ/9rM92LECafn67P7xjhp3oB4jSoAaUt9khtQnXRtl9u41OWBeUYnLKMQ/wF1tdIOo56BeDuWtTSn9Lo36c7A+g94gjoZtxDmua0MrWyLI+anNPiybmMd7FG/T0H+P/TgAYzyVXKvrTowFCBSfTvt4ff1hbAJgFhh0XbDRoU40XdAzNqJEzPzTeC2y5HZbFuXv2rD1ikkmKqERAlBVoOAQopqnOxlqRECbPQ1xlKRRf+O8I2rO3F0I4Uft8nSS6kdpxTUJV1w8bMwzQ4yMb/+2iKk6j4OPzHR3+MraKkjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wltIdSKQvJKUZGvoGbWVv0nI8lEyZO25OKZDJO1xG8Q=;
 b=YmqctEddKsgU2r2DBgNgqjayAs/YXOGqf7qNzfls7A3oKH2kMtGxB7a/aSFJqL7aH2uz6+FMswMYdLESl5CjchK5w0Y4T0k+BKwn1SRXX8AjCrKdzRWquJRKThPhymMPL7E0JocYDf8RE4+nIzConjCyImHWUO1VxpAOUst4GVa1eQQLooTX+NWzAvNe8dlgLyyT5TAk77ujPw2wBeLyH6WpYZiINwo2L9k6KZdWOAmWdp3e7TRRi3QbYFe5g4rYvy1A2qboX2Q3uIIHR6B6va2OBnk67sypO+KpHbnSn89x6F2eYSpsJk99HkTxX4Z3pGQfsIXXeuNTcrZWr4TC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wltIdSKQvJKUZGvoGbWVv0nI8lEyZO25OKZDJO1xG8Q=;
 b=HHkFDDrULp4URnANxl0A8US8OnEvY7Q6/lnyYYXr+bhHMLfgVJuhxI3XJieUU7bVdmbK+JCfDORcX+qsu9pYQ1hNFMW6zJlwL6VjQ2Leqzl8k6TApsFD7hefwxS4nefSIUxM20q4ENAXPhbNatYNqsEZYvCS5fdw9htHwflmCNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 10:05:03 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 10:05:03 +0000
Message-ID: <b55b50dd-4847-417f-aa24-65040333b98b@amd.com>
Date: Wed, 19 Jun 2024 15:34:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: part I - normalize registers as local xcc to
 read/write under sriov in TLB
To: Jane Jian <Jane.Jian@amd.com>, Haijun.Chang@amd.com, Victor.Zhao@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240619095526.1387723-1-Jane.Jian@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240619095526.1387723-1-Jane.Jian@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: b61c8a59-f02a-4d3e-00ca-08dc9047497b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1FoVnFxK01DRjJUQklOVU1TV0xvbHNOaXZFSUVPZHRIZ2p2S3c3N01LUTRY?=
 =?utf-8?B?TEgrZjlFTkhkWFJRS1o4Q1FLNkM2OTdvdTV1RDc0ajB3RmhyUElicjM4aU91?=
 =?utf-8?B?b3c5eXJpV3dmcEJDSFpVbVlsQ3YzZmZvWXlFblZYenBESUVFZ0ZyTHp6WUVU?=
 =?utf-8?B?djhZTDNMWjdJaG01S0JndDRBNGFaaVdDQWJlUk5DcnVIeTlZd1ZpbXZXSXh6?=
 =?utf-8?B?VGc5WkVVSHNhTExNQUlQZm96MWVseUxic3FxYllzQ1VQNmNBajFxZUU5dXBu?=
 =?utf-8?B?UUp5QmZkbmQyak1EaWRlckg5NkROQzA3aWo4ZVV4ZXJuS09iVkhjclh4OUc1?=
 =?utf-8?B?MEpYMk9jRGlDVmh4eUtJeEhVZzhpMzZZWXJCQjNNUnp4b1F3Rkk1MnUyVHhs?=
 =?utf-8?B?MjdSdDVPQjZ2OWpLbnUvQnVwMCtld2lseG1OREpLdWdIWlVLei9pZlNpeU9O?=
 =?utf-8?B?M3ZnSmxpMzhDWTFSblNpUEF0THNTT2lQMmNiL0VlazJ5UDEyQjZ4bXE4ZW1r?=
 =?utf-8?B?VThxMUFGR2J4OS91RVQ3aG5wQlR4MlpDQ256V0gxZHZxNVBZcTNDOWNvMWRC?=
 =?utf-8?B?d3JpUWVSMFd3WXF1MWt4L0s5VEpwQXk3czVmM0dWUlZoc1MwejhnRkU4dnNV?=
 =?utf-8?B?bHMrWFV5YzFjUXJjTTVwMzBndkpyekU2VTBpSkZxYUJsSkpEdFgyVE5uZVBF?=
 =?utf-8?B?UFp5clNZUTFRczErZTQ1SEZFNlRnNTRWdC9LWm8vTUxBSEphVUFyb3pSZG9D?=
 =?utf-8?B?Zko3NmdDaFc0S2FXbjd5ZXZQQWI3QTlEZ0phUUNKNGtuamE1dW9YbjNTZGN2?=
 =?utf-8?B?dFNRWXZlRkJESVhQRDRZVnQ2bTlaUitQSVEvdVFiS0FDR1IzVE5tZkxGT2t5?=
 =?utf-8?B?ZVMzTEtRem5tYjhrWERDcFczQnIzQkl2ZWdrbjFVMTk3bFpJbFQzZTVsMnA1?=
 =?utf-8?B?NUJvc09KMVFwWTMzSU9oZHoreXJRWFBpNnY3SVh0MHF2K3YzY1BMajFWMGZV?=
 =?utf-8?B?R0prQmFVN2F0TGE4dG1SOUpqUm14Qko0UE1BNndRK1lwaklOYzZZM3BTTUNu?=
 =?utf-8?B?cFlRNWhza3IxNnVnUkdLSjk2SzIvK0cvZHlvR1VIWXRrWkdPeEhTQ1I0Tzh4?=
 =?utf-8?B?YlRGUHM3Qll1RnNWMyswQTZ2UHJUR2hBRGd2L1BrcW1kSW5jMXJxUWJ5b3Ns?=
 =?utf-8?B?TEk0NllIVHkwME1iSlMyaWRteTkydlY3ekJ0N2E4dit3Uk9HSXduZThoVzVG?=
 =?utf-8?B?WGRpSWdqTHQvYTd3K1AzREF0Q2tFS3VFUWxDZzRTQWJiaTh0RVpEOTh3S1Ay?=
 =?utf-8?B?YVAvb1lad3JJa1o4MTBxeU5JV2Z3elgvQkRMWFZmcWFWREt5RERRcWU2TW9G?=
 =?utf-8?B?RUtGVXhHVmQwYmkrclUrZnMwT2hvWmNDdHVWVVVwSitjR2JMdVZsUDQxN3Fp?=
 =?utf-8?B?amJSSlVVMVJtemtjd2ZHanBNTHhuaERmQXB4MG9QcTZaUTlkRHlGNXprUXdR?=
 =?utf-8?B?VDl3UjBhM0RTb2xBTmUybU9yenlEN0VZbmdjOUtLdFJkSWpITDYrYVBZeSt4?=
 =?utf-8?B?OXBTTkxzTFl2M3hSZjlwYitqUGo1N0pwMWhTTGFFUmJJaGdZbTBpL041dERj?=
 =?utf-8?B?NG9HaERnc3ZsbS9SRU1OdW03ajk3OW8wU3F5MVJ6UkZKd0ViUW5kVmZiYjdl?=
 =?utf-8?B?amlQQ1ZFbjhNMFR1dWQxOUQySU9wa0lZZmNiaDdnMmVlRCs3UUJrTURlVzRP?=
 =?utf-8?Q?Qb/MvZ0VWB9fG7xqUj8+/7wWxXPrtR9SV5tjLxb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SCs0L0tLdStpbTA1dWVJNFN1aW42TUxWb1NJYWlLQzQ5akdYS244VC9OMFV6?=
 =?utf-8?B?aDhGMFBacTBBbVE2Q2Q5Sy9GcWpGOFlrMzlQTms1bFRjYXRSZ2p2NkZJSndw?=
 =?utf-8?B?SmszK1NJYW5abEJweTBxMnNHenhsV0RQckJ6R2orRlhxUlRLMXdLNnJuc29B?=
 =?utf-8?B?dGZRY3dYTm9EODRobzBZbEhWMFNDUkc1Snl3a28zbW80ZmtweFNDazIxM1Fn?=
 =?utf-8?B?OUtVN08vdjVnZmRkNVJFbFJnNTllb3hyczl3M1VNR05Dd0o3bjI0U3lsQzh4?=
 =?utf-8?B?SGlsSEw0bTAxTGFSVEpmZEF4V3Z1V0s5eG1kVk1QOUhKUXBiSVBuWlRvb0Y5?=
 =?utf-8?B?TUJJU2NRZUJXNzJCU01RMkwvZUloa2NRbHpBSlMvZUJ3dGRER1NTRXNtb1Z3?=
 =?utf-8?B?bytIUEFJRUp4Yks5a3hSc2JscGpFM2dJcWJERWJBaTVXODVLQUNROG9VbW5D?=
 =?utf-8?B?YXFWSlBuZWVVYy9zejNRZzZOdlpJYVdyVysxSDcwelQ2T2djT2ZvNm9mVXVa?=
 =?utf-8?B?MFdKaEY3cE80MmU1eHVHWlhmVWU2Q21lK1prZmdKeUFDL2gvR3p2NDdYcHRD?=
 =?utf-8?B?UkpSb0ZzR29LUjM5djNKMjF3QWlxUXNCVEU2cldYOUxxUGxEZ0tnT3RxbUJI?=
 =?utf-8?B?cTE3bk5jL2hwMFM2N2xrdE1JY2xyYWVFRmJsTGZDKzVMRmQ4V2t6TERMWHY3?=
 =?utf-8?B?cUt4dC9ZYW1PUC9QUWxHaGd1WG5zQ2tBOSt3VGlrMHkrMEdzeTFCUHRTTXZa?=
 =?utf-8?B?Vlg1SVBpeWxINXpvbXh0UlVrWmRBditRYm8yZE9yTjNuYzZSdkNTSjB4ZGQw?=
 =?utf-8?B?MzBLdWFFK3JNejNFSWhkL2FtL085V1NJUnNnY3g0Yi9WRTE0VGMrekVibzBF?=
 =?utf-8?B?b2NJY1FhZVV3bXd4aU9CaWU4MDdSWXlha2ZISkR1WjZvcGVpSVlIZk5VY0VG?=
 =?utf-8?B?Qks4ZC9qMFFMdmJIaHlDc3pFMU1HS0ZrUWRWRFZtbEtRTXovY0tqeGZMbzJq?=
 =?utf-8?B?WS9tekszeUNJazV3dHM3WDU0ZjV1R2FBZ3YvaVlGTDFVV1dCenoyMEpkbTlC?=
 =?utf-8?B?dGkzaUtsNlVobmd0T3hEVU1nenRkSGRzVzNoN2RKT1ZxM29SV0hjSlIrMGxs?=
 =?utf-8?B?dGVvUGQyRk9BYUhpYkVZNEVTeVVWWm01dnllaFhKRXdOeUdYc3h5K2JEcUhX?=
 =?utf-8?B?TUw2Q2lHTThpdVp1N2FVRlprYjhvdnpuWWMzZmREMlNlYnExRHdsTklzNDI0?=
 =?utf-8?B?NFQwelRFOXhsTkpnYkN1YWQ4SENtU2VsbGVEaWF4ZWp2N1VlV2w2a3VVZ3FZ?=
 =?utf-8?B?NEpDUnVjbzljbkVuQm55L3ppdHd0WG5YQms1dFl4MEFCUTJjWkF3eXBMQ1Ar?=
 =?utf-8?B?VTYwVjZ4OFpGYW1vT1lEZVBiaGVHOHFpQmJVRGszWW54SmEvbWpEVExyb1hl?=
 =?utf-8?B?enNtYkJLUGNoQnJwWDdiZERWSG16Umc2WkwrQTFLeW5CS2krUENZTDlhTTNJ?=
 =?utf-8?B?ZXEzREdmc0ZFdGlQcFpSeVJ3aG5mUDQrOVNOVGcvTGxYdnI0ZzRMRHhNQ0pL?=
 =?utf-8?B?TlFReWk4U3ZyaUEwM0E4ZDRZbllGM0NEazVyYnQ2OCtwS2JyS1YyWXpqZWl2?=
 =?utf-8?B?QWtxV1VLL0o3YUdua3orbFFiUGdjTzdjNjRLcTJtc08ybkovZkZTSWM1S3dZ?=
 =?utf-8?B?S0NQNUFDSmRwK0lGSGZzaUJPOHZTMkNKOS9QZGtMVHZGNVkvS1lhVTJLbHlT?=
 =?utf-8?B?VEh4d3NQaDcwU2RQWFRIWnUwMDEzUHdqbC9BZCt3QUVDR3pSR3NiMlM1M0t4?=
 =?utf-8?B?Q1NtWWtOZ0lCaDJmT3ppZFR3L0lrQWtodTk0Z0RVZUpMODdRbk4vQ3o0R2h1?=
 =?utf-8?B?Z0lzZE9VbkNpTENIaXZmMmUva21UbGNUVDBoK0RvVzFidzlseDFScnpNWExL?=
 =?utf-8?B?cDZxNytYQWM5ZzB3R1QwMmRISmxPRThQd1NtRldPU0J6RGNOamFyazFGcVQr?=
 =?utf-8?B?bmNjd0tJQ1gvTEY1dTNJWXo3RG4wR1hkdU1xNDVmU0pYL1RWSnZWK0J4Uy9C?=
 =?utf-8?B?K2p3RGduNDhqdmIzVk5GdVZDTE94UW5RTmppeGFUOU1PcUFhaW43L1J4Qkl5?=
 =?utf-8?Q?e152jEtsecFaBId8du692KH02?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61c8a59-f02a-4d3e-00ca-08dc9047497b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 10:05:03.3448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BWi0oW6IqaPK5cA/pBMjPcK9EffWdPnlLTvJO2VIWZK56bkYe1PWoqoZM5Bm4Jg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153
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



On 6/19/2024 3:25 PM, Jane Jian wrote:
> [WHY]
> sriov has the higher bit violation when flushing tlb
> 
> [HOW]
> normalize the registers to keep lower 16-bit(dword aligned) to aviod higher bit violation
> RLCG will mask xcd out and always assume it's accessing its own xcd
> 
> [TODO]
> later will add the normalization in sriovw/rreg after fixing bugs
> 
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 10 ++++++++--
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |  1 +
>  drivers/gpu/drm/amd/amdgpu/soc15.h         |  1 +
>  drivers/gpu/drm/amd/amdgpu/soc15_common.h  |  3 +++
>  6 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 083f353cff6e..da8d3669cc23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -632,6 +632,8 @@ struct amdgpu_asic_funcs {
>  				  const struct amdgpu_video_codecs **codecs);
>  	/* encode "> 32bits" smn addressing */
>  	u64 (*encode_ext_smn_addressing)(int ext_id);
> +	/* normalize offset to keep in lower 16-bit */
> +	u32 (*normalize_xcc_reg_offset)(u32 offset);

Suggest to rename to normalize_reg_offset() and add enum
amd_hw_ip_block_type as well. If required, the same callback could be
used for other IPs also.

>  
>  	ssize_t (*get_reg_state)(struct amdgpu_device *adev,
>  				 enum amdgpu_reg_state reg_state, void *buf,
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 2c9a0aa41e2d..3306df74457b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -1085,3 +1085,12 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
>  
>  	return size;
>  }
> +
> +u32 aqua_vanjaram_normalize_xcc_reg_offset(u32 offset)
> +{
> +	u32 normalized_offset;
> +
> +	normalized_offset = offset & 0xffff;
> +
> +	return normalized_offset;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 88b4644f8e96..fba2e4ad58db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -853,8 +853,14 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  	 */
>  	if (adev->gfx.kiq[inst].ring.sched.ready &&
>  	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> -		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
> -		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
> +
> +		/* Select lower 16 bits to write in local xcc
> +		 * for MMHUB it uses xcc0, NO cross AID reg offset
> +		 */
> +		if (AMDGPU_IS_GFXHUB(vmhub)) {
> +			req = NORMALIZE_XCC_REG_OFFSET(req);
> +			ack = NORMALIZE_XCC_REG_OFFSET(ack);
> +		}
>  
>  		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
>  						 1 << vmid, inst);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 8d16dacdc172..31037f068902 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -927,6 +927,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
>  	.query_video_codecs = &soc15_query_video_codecs,
>  	.encode_ext_smn_addressing = &aqua_vanjaram_encode_ext_smn_addressing,
>  	.get_reg_state = &aqua_vanjaram_get_reg_state,
> +	.normalize_xcc_reg_offset = &aqua_vanjaram_normalize_xcc_reg_offset,
>  };
>  
>  static int soc15_common_early_init(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
> index 282584a48be0..0d405a474283 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
> @@ -124,4 +124,5 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
>  void vega10_doorbell_index_init(struct amdgpu_device *adev);
>  void vega20_doorbell_index_init(struct amdgpu_device *adev);
>  void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev);
> +u32 aqua_vanjaram_normalize_xcc_reg_offset(u32 offset);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> index 242b24f73c17..43887836377d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> @@ -210,4 +210,7 @@
>  #define WREG64_MCA(ext, mca_base, idx, val) \
>  	WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + mca_base + (idx * 8), val)
>  
> +#define NORMALIZE_XCC_REG_OFFSET(offset) \
> +	(amdgpu_sriov_vf(adev) ? \
> +	adev->asic_funcs->normalize_xcc_reg_offset(offset) : offset)

May be something like below to take care of SOCs which don't implement
this -

(amdgpu_sriov_vf(adev) && adev->asic_funcs->normalize_reg_offset)?

Thanks,
Lijo

>  #endif
