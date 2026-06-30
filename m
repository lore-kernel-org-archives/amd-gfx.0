Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26587C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 04:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A22AD10EAD1;
	Tue, 30 Jun 2026 04:54:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="esc1Sdni";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012003.outbound.protection.outlook.com
 [40.107.200.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B6610EAD1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 04:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3lTHqpCOYnJ4MfhY/1q2uLiEZRM6H9muTOsNVG/i9ernV0cGHGc5FW54FxbMryVGuUeeV0qY/QW9Y27PNT4IZjeNL7rHp10mSKTmOKNPOMM0T1qvZRYS8KmLFRfmDLJoqR78uxieBer795v++1R4l4aSUFj9WTYV+E2i4mnuAcjJLjb+VnGhiNIcqYma2+c18r82g2/xsJzan6lMb6LQieWFyb4WGT/vOpuXJD8FEOzE37m8OHpD7sJiFuSIK80XGamAwjxYfvLcRTZ7LiSsQsUvUk1SuCauyb+JTsYX0sUz+zm6C6W4zzf5+idhCjZeUOI9PeEAFONKCGRNGo4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYrnmZjnBIQNKcleglKlAVci63KrtGCy3wZgWmVcdQM=;
 b=A2PyqAUuq7K21s6YsiHyXAFZo1NTJj31HsGE+qsBQATYBzM5WP9cwArRYnbjyKXqMRJmnNsw8iJWlWgbJIXW8tXaml9YSGSBSovTL0Fuq9HiNdFqYN6KEbLU3NLz2xn71a33we1Pkp6+4349j/dncld67kDuVhDWrngkDRZN7BX/+Xqul1nq6GO537jeZYliBkR1vd5CDO+DLCcJifXhkTdE3rb4RAhPgzTEDDi+I++jptg4KqLHuHVDqI5edwtUSJPpe/4mTmgT9mkTfN/ATjO0ehq4eCAoP1HwDxKYbt8DGH4w6ENYzNhBCAp6/K1B8BbixUjWR3fyPRa+qp40Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYrnmZjnBIQNKcleglKlAVci63KrtGCy3wZgWmVcdQM=;
 b=esc1SdniVB7mTN/uln0n7aRI9YHafydV/YaWPO2EE7PNIQu2g5m0ZhAxo0lj4mVedLlsseu7Fi3OSaOkryVsbGiNU3rFYSSM5RhjbhgBJ4uNFpclIRCsA55AnzL20hEmeHdNfIgBH4G4vrM+tbcQI9oLGv91nETpM8+DHn4lwmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:54:34 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 04:54:34 +0000
Message-ID: <4929fedd-486b-4958-85f2-4e4552bfa868@amd.com>
Date: Mon, 29 Jun 2026 23:54:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] drm/amdgpu: Disable JDPG on VCN5_3
Content-Language: en-US
To: Granthali Vinodkumar Dhandar <Granthali.VinodkumarDhandar@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Pratik.Vishwakarma@amd.com, Suresh.Guttula@amd.com
Cc: Kanala.RamalingeswaraReddy@amd.com
References: <20260630043655.1284069-1-Granthali.VinodkumarDhandar@amd.com>
 <20260630043655.1284069-5-Granthali.VinodkumarDhandar@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260630043655.1284069-5-Granthali.VinodkumarDhandar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0223.namprd04.prod.outlook.com
 (2603:10b6:806:127::18) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a976e85-1481-4b8b-2a9a-08ded663adbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 6PKI1xc8N14MAJrflQowKSnsua0TJTdhQj0BEqubk/6K+gs76SozVacAFagfLpGwQiEUqarfMZbMPfHIyQzDSzAkpiPR/kKW4hJnt6/DRBlse0q9KtqF9r7L/cJ45rgvulx477WTTAbPlj3fB7w93ycfjss4YCc/6pu/LBBVBanE6qNmszc9C1aktrn2ua4jiFwjTElAnhFvL3+fdKTVB+KGSAW+3akesX+7zsMZzNE4yu9mrQcZITGwG8+Hi6VOFZBqR79/iwq5b0OgafpYD5FYOhNveS43OkFU+qIJ89gMUIP3gc76xUCIKv/qDdm0YE4gIexcTINoEoMVDIwsW88MmaFw45nGkv11teuL7LuGr+nsDDsxOtjdCeuvSjPgrDYTFuXui8G7Md1ysM4Pnh2etGp8Sy6uXI/Aeto3B2Eih8brs+MlNycDU6OOdpsDHpOw5MraguCm27WqEjBvbgOY5ZQazd7oWnbtrj5ykukwVLBEDR9jbgaTwg/2zTuvrWi0dLihIP1ALmURlOpi4iIdCdy1Ui2ppo3pPCtKIN72CfuGyN1cMgvLs97xuJOEV7CsIhBfMM5TjTwWdA8V6D3H8zrVjTSzw4wYrX+s150o/sKYUd5PhEs6TIMCefH1fJlgBhJL5nxCVJdYTmH8oXfnNq/YD6lgC28gzMlDSHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MS9vaEZ4YWlNU2FJWjdIU0hPK2VKN2g5M2tZdGw1U0FJeS8waFFjVDAxdzZz?=
 =?utf-8?B?YTkvd2JrcTFXL2N5aFQyam10cFkrMkEzKzU2V1FuQm1PR1MxNjhZRWJLM0Fk?=
 =?utf-8?B?L0xwZnFzSENmVEpJaEJKbHZlS2pXZUZ0QjZ2OUFqVVB1cXU3bkQrV0xleGtz?=
 =?utf-8?B?OE5wR1IyUXljMnB6aUI0RWQxYmZpNWNTRUxsejV5RURveERDaGMxMTFkL1J6?=
 =?utf-8?B?dHJWUWNlcUZGRGlmckZ2c0xDRFJWeWVHN2FKRzJocDZmdkFiZVNCTmxmcWI4?=
 =?utf-8?B?T2FoTXNjVkpiNmgwdmJRdDBwcTVxMENYYXpKTGRFbzJKS3VTendhNUtaeDFT?=
 =?utf-8?B?MWJQeTRtdk1kT09qMFVyZThuSEQ1bmNiZHAvSTl3bTEvaS9CYkVXcUJvU3lC?=
 =?utf-8?B?TFg3RVN5SlpqbkFHT2RmOVZMRHJQNXIzeE15NXF6cjUxVElUWmd6TkdKZXlT?=
 =?utf-8?B?Yy9SSytxckkwNUhES2JFbWczSzQzd281UHZBNnNPNisxcS9rMG44US9SVUxU?=
 =?utf-8?B?YTRWUGNHNFFNRXpralUvUmZIejYyNEZxb0NEUDFJUFhOWDcycTBDcGFSVU9C?=
 =?utf-8?B?M29FRmI0cTVBTElLTmxlMXdHa2w1SmM5TWVnN3BTMHpxanNBS1ZJZ1RSTFFM?=
 =?utf-8?B?ZkJDWDFtbFVlMEM4enNDOTEza1kwNXdjamJVT0tQSUFVaVo3bG5KTXVaVnpi?=
 =?utf-8?B?SXdXR2R0MDhldDIwTEtpUmxPbHJIZUFQUlZueHBJa3hDcWc3RWtOaTJpdXFs?=
 =?utf-8?B?Q0J1K0QxNzlnRVJiWmw2WHdRS1ZrdG50TDhPdGZIbVdEZUtWSEdlMXA3TEdt?=
 =?utf-8?B?eG0xMWFZNFdLQVJhOW91OHpCeTdsc3hoNHc1T1BJZkdHYlpBaE1mSi82SUhE?=
 =?utf-8?B?d1A2V3lrVHEyQzdIZVpTbUp3U2FQbnVDeHBNVTZrWWdlUU1oYTQvS2NMaTVy?=
 =?utf-8?B?S0xnb0Q5M1dHRk5sOWNhaTRXb0JvaEo2WGREMUQwenQ2Q09Ta0pJM0JPK2hY?=
 =?utf-8?B?WmV0TkZYNTlNajFJNVYxNDhMTW9sQlo2Q2tFbTVnTW9YUEorbnlnSE5BQnpN?=
 =?utf-8?B?SC9CQ05GN0NPQzd5aFJJZWJNUWkvbUpEQWRGVlJ0WXZCdzlNeVpUdFFKWi93?=
 =?utf-8?B?UXpYWEdzVHc5MG1xZnlHdkhWTWZna203bGluamw5bDZUTHhwak5LbEJkeDRz?=
 =?utf-8?B?NVU1QTkzK2ZkaVI0S3B4NVJPLytFSjhqbHA1eGJMNFlLbExnVC9sL2c4SFZ0?=
 =?utf-8?B?WEZ3R1o5dHArZjJnV3pPTko1S1VDV3JaNEczbWZTcW9uenUvQnBGSnplVi9K?=
 =?utf-8?B?T2VaRmdsRGhKck95K2xRRUI2MU9kSW9BaUg1UGtjM3Y5QnZ0NjFsLy9TTVlG?=
 =?utf-8?B?RkgrSUdsWTNqMk5CWHFlT0drcCtBa1Q1K1hjZjFucUZNME4yRi9WcVYwNlpv?=
 =?utf-8?B?SDJJcEIrNTIzQm1zV09jeEpreHZ4VkpGQXo2UzhiV291ZW5TV3lNR3MxdjBx?=
 =?utf-8?B?RjcwMHpsTkhIZUJScm1uUXduWXdSNEpkZFFtZW9NTEh3THBlREloSVBoVDBs?=
 =?utf-8?B?YVVkNHlzSmJFakNRTllaSlg2OUNvMXNwZE1KeEsyR0pOZDNGVzZNRnR3Zm1v?=
 =?utf-8?B?bVpTTUUzZklyMDJFSWpUdzZvck9KRVBlTlJEVWEzQnVNUEN2aWxGdmFzM29B?=
 =?utf-8?B?eW9Cc3dOWXMvSnVXQUhmdjNiK0FBZWJsWDV0bERSK1hwTWtpUDUrWnY3UGNW?=
 =?utf-8?B?SWFWV2RKOXJjdTVMajc3eWtGaFZYTkk3WHFQcUhDRk1sTWxKbjRXbDRKK2g4?=
 =?utf-8?B?RWxHc3daelREWkZ3c0RQdHpZTlJYRUlaUHdzY0l2MTdiakRYUzB6WTVjeXpV?=
 =?utf-8?B?OHRoUW1oUzJXanUzOW9JNy9XaFhmSlRvZEhjb2RNTm9aZCtVWE5RK0w4RHo3?=
 =?utf-8?B?QXJTeU00MzNkUlc0NVdDNi8rTGlmdWNISWdhT213bDA3dzhJZ1RCNWFLQVhv?=
 =?utf-8?B?UlpSb2FDVFFMSk1GMlBqZWpCeFovbzd1MTJCc2s5L1BQTkZZc2x0Um1tNUl4?=
 =?utf-8?B?bHpSZmZDenFmNXhyVmJ5bk1EUDZ4Nk9oNkRKUlk0Qk50MzVFRUV2K2U4N1d4?=
 =?utf-8?B?cldzdklUWEhERDdMZU5sVEMrWFBjUFl5VmVxeHBTMi8xZW0vNnJuQXAvQkt6?=
 =?utf-8?B?eVptalg1M0NBb3JkeHIvZ1V4MWFkVy9hTlhTUUJJaUt3MUVKTDJOU0JvcWRF?=
 =?utf-8?B?c3F4MHNic1FXM3dUZExwdTVxeGdiRTBlR0RaT2tIMFcvM3RBdDJrOEpwL2dS?=
 =?utf-8?B?cEY0V3BkZzVoT2kzeC9lc0tIY0ZkSFNKYXprOXpOaW1ZUnZPR0xCUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a976e85-1481-4b8b-2a9a-08ded663adbb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:54:33.9297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHRnJO+0bhwH8jSVJmkvKeGU2LsFbpsm2mWNkmnktRAEEkNbiYUkRHYxUsgKz/wCejEr3b4f2hac8GIPBHCuvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774
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



On 6/29/26 23:36, Granthali Vinodkumar Dhandar wrote:
> From: Suresh Guttula <suresh.guttula@amd.com>
> 
> JDPG does not support on VCN5
> 
> This patch will disable JDPG, because DPG is not correctly
> copying the JRBC Read/Write Pointers (R/WPTR) from the PG
> (Power Gating) block to JRBC.
> 
> Signed-off-by: Suresh Guttula <suresh.guttula@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/soc21.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index a2733d1637f0..e0b80abcd075 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -862,7 +862,6 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
>   			AMD_CG_SUPPORT_BIF_LS;
>   		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG |
>   			AMD_PG_SUPPORT_VCN |
> -			AMD_PG_SUPPORT_JPEG_DPG |
>   			AMD_PG_SUPPORT_JPEG |
>   			AMD_PG_SUPPORT_GFX_PG;
>   		adev->external_rev_id = adev->rev_id + 0xF;
> @@ -890,7 +889,6 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
>   			AMD_CG_SUPPORT_BIF_LS;
>   		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG |
>   			AMD_PG_SUPPORT_VCN |
> -			AMD_PG_SUPPORT_JPEG_DPG |
>   			AMD_PG_SUPPORT_JPEG |
>   			AMD_PG_SUPPORT_GFX_PG;
>   		adev->external_rev_id = adev->rev_id + 0x40;

