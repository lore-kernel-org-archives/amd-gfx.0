Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579C7C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0675310EC35;
	Fri, 11 Apr 2025 16:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H5w8y8Yy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E63910EC35
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUnywQivGvRhd+/J+G1IeGXZui+Cnw276hindPPztBUFcPnQ8TfQnCveCYkNrekFDd4uyRrgBaGvRvOnE/S2vgI+LYfmT2XP+GrVLPd8WpvIJ9+L5zXnhQnfIOwE7iqJaQHJVQCVwDaZSCbhOT7gFIDVwREFNA7iM/VaUX2QAksEozo8humedh9b1hJosni09s+REPsXaS1hvSuG601vKv2/Bt5gDktL5+S7dmhTvqT7s4I7QODQpll8PXIbYJVBPsynXQNUAwTJ7L1L6wmGfhOBoId77Iku9mHke4ZglS9QnD7D3iPQ7JTIhDlkvIp9dpZhth+NP6sHyUL3PJIxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxjwgsMX8LeDaTrXZ8fIcFeohuk622zlZvZBe+Ud61Y=;
 b=IDmn3n1uMRMfgTQKFG87u/ZsGp2dtp6S1PJv6xt8vyq561qIKQ/EEo5WT72RpSa1iIAiDO/XWwg/4SYrBZObqBJb0QbNT3R28bSgdR/NAsRqJPSYNyOnuecL7YuYRsAXGsUWMvmgrAA3FGDu/0e4dhnpFNp4nUnijBJA2/T+eQFACEzGZbGrWmd028LRJcDxIGq/bYo04vAisUsQC4LqJnEemkmsP8zLdPGtKT+l/6y9yMW+qEY1HaWRToeCUFIo9TyZGbjx9OlrXewD+jS/p1uKr85LqurS3M5da9r/SjfmxHUf5fUFsTkXwAqyRE5Tb/eEpYMbyGS8bmK8+oe+qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxjwgsMX8LeDaTrXZ8fIcFeohuk622zlZvZBe+Ud61Y=;
 b=H5w8y8YyeTQzcqA/6sA8ir1cWQiXpg8FAMCKdeQLs/Oq+L8iD62bIlUG8waPRe/7leQAdsoBvIhQdsUb+Tz3j5piLcwJpD/c95w3oMrpFfSluz07St+2RwXrHlNPz9lQlbAeS4+6xadghCv9Ohk5NK/A9iUMfLMsuCs+tBnKDWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 16:53:12 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 16:53:12 +0000
Message-ID: <696a9b39-9fd5-4403-b603-8432279e2687@amd.com>
Date: Fri, 11 Apr 2025 22:23:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] drm/amdgpu/mes11: add conversion for priority levels
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
 <20250410185402.2352109-3-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410185402.2352109-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::7) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a487dbd-c555-4109-b633-08dd79195850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d25jTEQ4NXFybmNxM0Z5Y1lIZ0RDakYvSUp1SGREVEdRNi8zN2Z5THhhZWJT?=
 =?utf-8?B?Sm94SHV2amttbmFPcHFtMU56RjFVQUFvS3BOejlRdllyMFIxYnZpTytTRUYv?=
 =?utf-8?B?dFJmdjZCdDJQaENhL09nMUpoNkdBRFFZdU5BWitrVHB3Qlk4S2NvdnhRbEFL?=
 =?utf-8?B?elVpOVBrM29Jd3JOQ2VaL0NDbGx2UVorNldjL0RCVHVsNUF6Q2x3Rm9aRkU5?=
 =?utf-8?B?TDZDaEpOMDM2WkZxWGRodVZwb0ZYdERFS0QzRmJYTmk3UW5EL2lCSm5YWXRj?=
 =?utf-8?B?WVlGOVlPSW9nWjd4bnhsQWJrS2MzVDNyVkFRSlhiOU1xWlNsSENhbTVVN05x?=
 =?utf-8?B?YnE4Q3g0c2tGSm8xN0lweDVxcjFLV2k5SWNOQU11cVNZUkY2c0tKYzIva2ov?=
 =?utf-8?B?U1YrMTh3bElkYkdRZmZ6bURrdkEweDNjWmEycFhjS2czWXBuWVYzQ1pPYVhG?=
 =?utf-8?B?eUhBbUtsWW5CUW9aZmMzRU05S3hGYlNHdm1YSEdFZ2tweVJVUzJkR3VOZnpv?=
 =?utf-8?B?T3dJRWNYV3VnOXMwdHQyTkdwVis1K3g0N1hiVUZ5VGlzOWFMekxvRVAyS3BX?=
 =?utf-8?B?a2xmdkIvbkxLcVRjRzNucGswZGRFZGUvSmhjWDhUL0Z0MERlWFAwWVJoZXlU?=
 =?utf-8?B?elpuY2hPaVl6M093OGVROWVaV0lWUVVCdzk3dDM1Ym1XZVM1allEZzlteTkz?=
 =?utf-8?B?RjBWVS92Y0FmcmkyNHNiaVRlWUp3OG9IU092RkhhZHl4WGpEbURnUklWQTYw?=
 =?utf-8?B?WHRqMGMzTkJwc2h6Z2gyZDQ5ajRMNlRFbW55Y1VTMytzTDk0U1p2SjN6YlJX?=
 =?utf-8?B?S2VNK1dEV292cmwxTEFXWjhjQVBub3Rrc0dZY0I0TGxyWVZNaG90OU51cGRL?=
 =?utf-8?B?NzVSUFN2NWlBc2k4M2Zwd21ESEliNXVTRWlLY2xYQ3hEeFdZY3BRQVMzZ2ps?=
 =?utf-8?B?bXhHUWUwVjNNNm5BRmovdWJCUUZmWXVBNmg1ME4xYmE1d085dVlkTVo1OG02?=
 =?utf-8?B?Tm5oVGFPYjVEejcvUSt4c1VaUVRaUVNBckhDaURucU9XaHduYXVBTE5iVXRB?=
 =?utf-8?B?ZU9aeXRUdVlzL0JXWHZNSzdmS2RjMzZFbGYvYzNIbUhEWE5yaEN1cUgyRm9Y?=
 =?utf-8?B?N0R5NHIvV29pWTVIN2ZxanY4MEcvMkJ5bndtMTlnOG81TTl4NmNaeHR2WlN1?=
 =?utf-8?B?RkYrT2xVTCszbVczZzlTMVhPY2NpZXBaQWlvZWp3M0doWGtORDY0TkxoWEZO?=
 =?utf-8?B?dSt3bDVmTlVkVkYwRW9wNFNua1lCSkhQd25sMmtiL1YwckRLQ2MrdWJ0dlBU?=
 =?utf-8?B?QzYvQ2IxMUo2Qkc4Q0ZIWUFEeHo4Z2V5OEpBMllqR2RCNzFxVjM0SUtLK000?=
 =?utf-8?B?ZUZzUmU5bnBKeUNTME5CUE53WnJiWFc3QUlmaHhXV3Q0elVZK1NXQisxY0Zn?=
 =?utf-8?B?RHpvbzJZbGxEKzBBMU9KcWYwMVlsdFFXa1c3cEh0WDdXL2c4bTVEWHZlblph?=
 =?utf-8?B?UFlWZ25wb0k3WUE2VFM0UWpKVXVzcWV1cnhlVUNNRjZJZ1VqV3FubHlZVG9w?=
 =?utf-8?B?OE1QcHdIdUtkU1lpMmwwUlp3ejFCUWI4a0s4b2h5UDR2UStCSFJ0cWFnS1Iw?=
 =?utf-8?B?a2VTMmk4MDRtTlVBb2FnUTlyYlRUY0pEV1NKNHVOL21wTE5OejV2cnQyVkl5?=
 =?utf-8?B?MVNFNnU3c1JKYlV0bFczZ1RiRU84Umtya1kwRi9HUGh1VGE4UExVUFFiQnJU?=
 =?utf-8?B?a2tWT3JBM0E5UVZqb09DR2hyZXlsbGZ1RktUZWp2RDQxTC8vU2tNdlVaTEhT?=
 =?utf-8?B?bGhabVo2bWlJUEVBRi9lSU9qYU52YS9vOHlGeXFHaEFQa2JHay9DMTdUMkpG?=
 =?utf-8?B?RFJ5bmV6Nys3L2JRSFphUDhRL2kwdUh4N0hwUnVCcG1hNVJEZi9NMzByRDJY?=
 =?utf-8?Q?7+doOfDNVMI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1I0alVRMDZrM2JmQm9HaXpkMmVyMnoxNUtkNERYRkoyNlJUMWt4eHgzcmF0?=
 =?utf-8?B?L1ZETFprTXFpU1VYSFBTK0tIajhjdEVLN1l0ZnRmU2RBR0xsWTFKMWUwRTMw?=
 =?utf-8?B?MjRic0E1ZjQzK0dPNVByaXhMV2pGUDVQRU9MRXpaVTlyUTFqd0xZdXR3Rk82?=
 =?utf-8?B?K0pTUmpOQkY4aXVna2lRVmREdUw4UjdNWi9HTTNVQUcrcFJyb1RqamxBMTVM?=
 =?utf-8?B?d2ZXSVlMQXgzSlZZNnZxUHMvdVozRlR5Z0xTUGIxcXdjbmJhS08rczZxd0tU?=
 =?utf-8?B?SVhtNFMwZHFPbVRaSHVtUDhvK0NrbHVEUno3dUpYSUJJTGpWYjA5ZUtVbmxV?=
 =?utf-8?B?eXBlRk51bS9jamJFSFNSVFluQ2hJVG1PWHc1d1MvYjlLS1pPWHpvd3VVQy9U?=
 =?utf-8?B?SXdkMnJSYklLUzlLWGNUSGowNlVIb0dQdWh5TzhhYWtBYllFODVYN1dsVVQ0?=
 =?utf-8?B?dlN5bmt3K3AzN0FnZEFXQ1NQUGFzbGlkVlhjMGpmalZtdkdzcEIvbmV0SnVz?=
 =?utf-8?B?TU5neXhYZGUyOS9CNDcrNGhseXk5eGVkbDlMTjZxSkZacm91VEVKdWxhK24r?=
 =?utf-8?B?amVDb2dPNFZFVDFKZVhJdUpEc24yNFhNZ1VHSGkwdmZEZ1FEWWliTjBMNHBB?=
 =?utf-8?B?SUN2ZDQ4RWRERXdHWVVHS0V5bmdvNU1UTkhGSlViN0xrV2N0UUxkcUl3TStY?=
 =?utf-8?B?Q1BwRk1tbHpBWWxrTFZqS09NSUwvWVR6THNsNkNEMVMzK04wb2kxK1kwcXFU?=
 =?utf-8?B?cTF2VndOQ2dLM29CS3VRWkxyaTZ0cHAvNWJoclE4Vkdab3FKclJSSlRTM0ts?=
 =?utf-8?B?RzJMZmJzaWZZaFNKMmNobTBtMXh2RE9HWXBMbXMwc0ZqcSsrTGJVd1E3VVVT?=
 =?utf-8?B?RXJVaHhLdEM1NnVtNXRiSkpjWlQ0em9oOXBuS2d2OU5jQWM3VTFwKzFmVTQv?=
 =?utf-8?B?c1U1clA4NWZpN0JEMFY5eFdmaHB3TE5Gb1k4VGw1VnBaa0YrQ25zSUczQ3Jn?=
 =?utf-8?B?RE5mQmtxaWJLTy9hNWxZY0d0bXNXWXhMZmhITXBwWFczWHBWbm1mOFZkamll?=
 =?utf-8?B?aTRIWUVTTUI1LzFxdGNyblZBc0lGa2k5cVZIRWVvTVNiNmYyMTAxa2U0d0pj?=
 =?utf-8?B?ckVQVGNmaHR0ZHVPb2tMTGF1N1d4SWtOWnFVRmtYVi92c3NVSC9GNUZtNnBR?=
 =?utf-8?B?NHRpYnk5cmg1TThtNGFmbEQyVkpVRExjYTREU2svS0dwQ0JVV0pBdDU5QTlD?=
 =?utf-8?B?ZTQwVFV5V0EwRHhybU5tSHgyeUJadVRxSm1keDMxME9mRTNNZnVYMkpoOEQz?=
 =?utf-8?B?ZnRWN1JjRWdjZXdxZGtnL2RTRTR3bW96eDJ5UXAvdjYxVkJhZmZmMDFmOWF2?=
 =?utf-8?B?cm16Tmp4cW9LLzgwWkVFQnVpb1pKNE9BWXp0TTJ5NmROMzkzVDY3Y3d3Njdo?=
 =?utf-8?B?WlU4Zk1OU3l6eER5L2FjMG5UdVQ0UGttUkRuNnlwaVd2T1c3NkZEVzJjSXd1?=
 =?utf-8?B?OHk1Y3h1NUFIMit4eEFMWDRodHNrSlNwRFM4NEpsTERhOUU1R3FuU0xsUVlq?=
 =?utf-8?B?eklsWnJWUmdtTFZWMGwxaG9iK29ndDN6cVN5WkpidW1sUUxqZXVYNTczc2xN?=
 =?utf-8?B?SHpwQ1VBNC96WldDUFJLSTI2emRuVEdVb3dSb0hKUitEckRXTnNheStxdU1i?=
 =?utf-8?B?R1lsRjFLLytwbkhoVGlmd0daUC9KeHJQdlJMZ3F4M0QwTk5mcXluNEtCTGE3?=
 =?utf-8?B?cjZGWGQreFl5VzF6SGdoMEszWS9xVUI3Qzd2akJSWnNvZ0poR2tZVzZhTkF0?=
 =?utf-8?B?dHFFOGZ0bm9CZ2RYVFVGYnJkSG9CZXk1N0Z2R3BTcTUwSkxnYUJFV0tlZjNI?=
 =?utf-8?B?N3U5ZTRwQmhPbWhGM1hCTWIrYTBqWmd4QlFFVk9WeUhWVHFTaE1OTTZvbWRa?=
 =?utf-8?B?V09JZitsdmhBOXVhSmdHd3ZmRXRRWkFmV1NQeU5Jem8wYWYwcy9HTy9zazNX?=
 =?utf-8?B?amdDaDd3TnFLR3VLUkJtemphUDdrQVpQVnBIM3Z1QmRCUGhoeDBpTTlIOXgr?=
 =?utf-8?B?bzZNZ0kzRStucTJRcEw2aytJamJITDBReTRVMVpmOGZud1VrT3pCSThlcVpm?=
 =?utf-8?Q?qxKcAngLQkrtKMSNHBSshYf3k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a487dbd-c555-4109-b633-08dd79195850
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:53:12.3458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKTRe0BNDuG6iFUd1EQj2F8BI/qHtLBe65wr10G385/nHCDFEuhI82W1xdZK6/zZo0SqUNbNwzTrgos9dzxrDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
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

Do you expect priority level in MES11 12 and probably 13 too ? If they 
are same then we should be using the same conversion function for all 
versions of MES. For now its fine.
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 12:23 AM, Alex Deucher wrote:
> Convert driver priority levels to MES11 priority levels.
> At the moment they are the same, but they may not always
> be.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 06b51867c9aac..b39a538cfc4e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -287,6 +287,23 @@ static int convert_to_mes_queue_type(int queue_type)
>   	return -1;
>   }
>   
> +static int convert_to_mes_priority_level(int priority_level)
> +{
> +	switch (priority_level) {
> +	case AMDGPU_MES_PRIORITY_LEVEL_LOW:
> +		return AMD_PRIORITY_LEVEL_LOW;
> +	case AMDGPU_MES_PRIORITY_LEVEL_NORMAL:
> +	default:
> +		return AMD_PRIORITY_LEVEL_NORMAL;
> +	case AMDGPU_MES_PRIORITY_LEVEL_MEDIUM:
> +		return AMD_PRIORITY_LEVEL_MEDIUM;
> +	case AMDGPU_MES_PRIORITY_LEVEL_HIGH:
> +		return AMD_PRIORITY_LEVEL_HIGH;
> +	case AMDGPU_MES_PRIORITY_LEVEL_REALTIME:
> +		return AMD_PRIORITY_LEVEL_REALTIME;
> +	}
> +}
> +
>   static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
>   				  struct mes_add_queue_input *input)
>   {
> @@ -310,9 +327,9 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
>   	mes_add_queue_pkt.gang_quantum = input->gang_quantum;
>   	mes_add_queue_pkt.gang_context_addr = input->gang_context_addr;
>   	mes_add_queue_pkt.inprocess_gang_priority =
> -		input->inprocess_gang_priority;
> +		convert_to_mes_priority_level(input->inprocess_gang_priority);
>   	mes_add_queue_pkt.gang_global_priority_level =
> -		input->gang_global_priority_level;
> +		convert_to_mes_priority_level(input->gang_global_priority_level);
>   	mes_add_queue_pkt.doorbell_offset = input->doorbell_offset;
>   	mes_add_queue_pkt.mqd_addr = input->mqd_addr;
>   
