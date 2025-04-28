Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208DAC369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 17:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6A310E223;
	Mon, 28 Apr 2025 17:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KOz3sM5N";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370F710E21B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 17:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mp6cBhuIEHDDF8S0XDXKsQSgm3vKQBcH8LLsNCxzTC9kV/v1rPzsnXgBXvbLjruBsGSHjAbPx6wGTvU/oNKorH1h9p7shx+UKwyf9vFjrLzSZb16t/QqLQHdcPqtlX81kBXsx85BlU9Bb2+t9hf7mKSZ5wrvvbbNnKHreNkH9xeWTW5hD/TCUKrX/fn9mQ3gHV3gO6hyhKtwNvx6uPATCf4wx+8IT6cjr1GGH4o2cVtIqH66bC005ZPjQuPWH29i+sxVh9MUBaZtruqoSm/frSFhgU4oZ4S2pYWeVrwrumNR0J811cTQSwWB+PCIgIu7OWGhAYsjPk7TK2npsYSJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8lu8PRULLcktoOrgJzAXD3AeS/fiLroaeV6OBOELw4=;
 b=tvXN3HSd3HQRuyEvQPsDBAgfJRY5b0IYOxuO4EA5GW1CNe4ITnep4mvrUYDP6p3dUYPveNz4oof+kwkiMHEZKht2cDQTa3JN5dqt4FtTo6KtYrJ2TATsMac+lySCa4XqSkKGOMjk43bDSIlHhgyNUmjLApSeLNkoU1kYDXHcBWQb41M4+fDfhx5vE2cg/8XVeC0jzmNXMUY0PwqvyiuO9QPiGUHb046GoIlWLQB3mVWjDiyaOiqg6t8Dbm/XIgaZJrNPtLIP+mMp2zVRywWWYn7YdmywdD4SR5tuZEIJrTxGCs3bUfhhckP8GgvBqybq4h+Nd3DcmY6R4VVEm6YrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8lu8PRULLcktoOrgJzAXD3AeS/fiLroaeV6OBOELw4=;
 b=KOz3sM5NJSVlBewwg6E9+hT6JxjYaRXxjZKwh0ml/rCo3FH3/PjXBISxocfbVCS0IB1mDDp6AVsbzkF1tOc7CCnfiiUvjG1jQy52M5TLO/Hqshhzw63CImlpZg4KJuORcEajCqpA3M56UTZLIEiDaaB9TcxWdD6eIQ3KODtOoYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 17:46:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 17:46:06 +0000
Message-ID: <32a429d4-6792-4da7-ae33-55f01d4dd744@amd.com>
Date: Mon, 28 Apr 2025 19:46:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: fix the eviction fence dereference
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250425070730.4033803-1-Prike.Liang@amd.com>
 <20250425070730.4033803-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250425070730.4033803-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5f3abb-1c97-4211-88ae-08dd867c8d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0JkeEsxdG5CcitzSlBTQ080RUR1UVhOM0tDaXpFMkpXRUM5YmRMSjdtMmpr?=
 =?utf-8?B?ZDdxZjVJN1ZTampOaE5kYVlIbGcxNzlTZE9vQ0RESis2Wm9udjNKdlZ6bVMv?=
 =?utf-8?B?RVE2MkMrMHFwTkcrZGw3TGw0bzkzVDdQczZPVk8zWXE2a3Z5dE5YemNXZFpB?=
 =?utf-8?B?L2RZODlxM1FRbWYrVW9NT0VOQndsaEdPaWVxWmcyUXZjYkpPRjhBVUF3ek1T?=
 =?utf-8?B?N292MUVTVGoyNlBnWHlObXdGaTJMZW54MlZ1WTM0NGZxdFQyVmpyckpPMWEw?=
 =?utf-8?B?STUxT3Vrc01oTTlOSmtIckYrd2l5QkJUeVNHQ1BWWmltN1BaSG9NMUpWNXQ2?=
 =?utf-8?B?RjkwUUJxWlBQemw4VjJsZFBNeWxjV2xoUnBGZFFDSzdFOUJEeU5DR0s0eHpx?=
 =?utf-8?B?WUVNK1hnSzBxL3ZrWmloenlIK2dvQUJrdEEyK3IxTWxqN1hpY2l1eVdNMDdX?=
 =?utf-8?B?NTlWYTVpd25pK2MrN2FUV24rUTU5YUxHQnVQU2NUSzVDYld6cFVPeTUzSnEx?=
 =?utf-8?B?YTNkNEpjTVJ1Z2lyWnd5ZGZLVmlUWEM4Q2huckt3WVRSazJqYW93K3ZRMVF5?=
 =?utf-8?B?amNMV0VHUkxwNk0reDFBMUUvMTdFbkFiU1lrRUJxaU9Yejh0YVJPNnE3Vlgv?=
 =?utf-8?B?QzIwZ09xbFNGZGFvWEpTRGllSG1WcjNGbi9TNmxVeXlaayttUlVITW84d3dN?=
 =?utf-8?B?RFo2YkFOeWZBcjdmb1grVGNTYS8vTnJUQURtTEpFdmg5UEE3ZU5oUG1aRk1L?=
 =?utf-8?B?Nml3VC9mUTF5d3pnSHo4cjcya3hURFppTUdFdGc2MVBSVDlJMFJYbmtZaThF?=
 =?utf-8?B?K1FmT2U4NDdCSFRpWmFWclQ5ZkIwS1FXZXpTTVFPWGJ6Q21hZUU1TXpSL25X?=
 =?utf-8?B?ZC9KQU1aMDZCZktlNzVaektNWHhGaUV6VXFVUURGWTYyNjEydVRhbE1XODhr?=
 =?utf-8?B?cHFMSnd6OWlkaHVhSlU2MkJnbys2VkJERkFxQkRyMlpadTJyamZ4bmtOWXA5?=
 =?utf-8?B?aDl3Q3JjVXo2K2ozL1EydW1EaEFzWjY3bWR2ZTVmd1pLUjA1cS8xSnBZaHd1?=
 =?utf-8?B?TDI1RzJVODRiUUN2RHluT2N0U1J1ZTlyWVNzUDJUSHBIcHJLM2FldXdrTVNZ?=
 =?utf-8?B?Q0c3eHRtbi9uNFo5ZlJEbFg1eWd0ZEY4YjZSdW1RdmZmVFo1dTdhS25JYXpV?=
 =?utf-8?B?cVZaM25xc3lmTTd5WlNaaFAraXFWc3pDZ3VhbzBIWmZPdlh3UVlsek93QWxQ?=
 =?utf-8?B?bVRsbGJ0WGdkNGlPRzUwM3o4OEozeWRvUklLZWhZVTFkS3lSVEZJREdmOWxm?=
 =?utf-8?B?cm0rMWl4eDlYdFVET3BsTE1MWGZtQ2Fadkt4bWYzcCsyYmg0bXJyKzZSUDBQ?=
 =?utf-8?B?b295UzROM2F4TjcyeGVWMjQwZzI0eU0zdmpicVhLRklVQnJDUThFaUlISGM4?=
 =?utf-8?B?UG1lYkpZbTRKcjdUT3JNUk9QeERQU3FoZzBYODZGeEM2clJ4ZXdGYzBFTXp1?=
 =?utf-8?B?NFRXNllsKzgzSUV2UHVLeFdmRitpSXJzVEF3UDY5aGFmdkFBbnhtNWhlOWI0?=
 =?utf-8?B?UVdNaTdNdCtENXB1NXdlU05TbWZQWWJ6SUNkY0l4Nkh0WUdmdE51YzFYc0Qy?=
 =?utf-8?B?SWd4SDdsR0dNV28xOVpoamo3U2k5cnd2cjFDdnZxNXAxMmhoYXZQbjRlTXVY?=
 =?utf-8?B?dlZYTUJvakxJMDVSSG00bVlEUTVnQVkvNlM2L3VmMThua0JtRkhwQmUvQ2lZ?=
 =?utf-8?B?TEF2UHZWYWxpWmdEaWtYM2ZGN0xEaFBLcmxra21wT0JDZ1g0aUhLK0JKLzdm?=
 =?utf-8?B?YVJBSVlCZ256Rys3RlhJVFFuMERCTDdMNHk5ajBtSUgySmMyY0pxVm5zZFBr?=
 =?utf-8?B?K2owKzUwVWZWcFVmV3FzOW0xVWlXWDE2dXlNaUxOak9EMFFmQlB6bkJLd1pi?=
 =?utf-8?Q?fMYwUvoLqkM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVVGWG1PVkN2bkIxVllqTUdSMmFUcDVLZjNlZHdzNUR2Z3hwa2V0QXNzcks0?=
 =?utf-8?B?NDQrODE1MXZLOWxjMTRYaDAxR0h2SnFLYzQwNFZraUdXeFlLOGtoMHFQOEZN?=
 =?utf-8?B?Z2EvWElwMTNjYUFZNDE3RFdHSTdKY1dYd3d0OGRlc3JLeC9HdHpnbkJndkVq?=
 =?utf-8?B?QlgxQXVDZnRZTEhkV0UwSHBhV3pMTmMzVWNncmZVdlZOVXFVZTlCS3R2Qlh6?=
 =?utf-8?B?SGhTQ1hGa1o2eEtWUEh2bldDQmRRVnQ4QzhxQjBQaHNlT3g4SjRJeEVvb1pB?=
 =?utf-8?B?TWdjSSs3QXdMcWxTazNDWjlDUXo4RW0vK0xRQVBDaVA3Q2RQQlJZK1dtNFpo?=
 =?utf-8?B?WDVINkVmSzNLVGxvRktCdUYweERkREhRQlpJS2UxbmN4UHYrNUhNSGJBMjMz?=
 =?utf-8?B?azhjNUxBMno5c3JHUVlXelRFR2NqbGJrQWNyc01lOTdiOXA0cFg3ZCtKMVJk?=
 =?utf-8?B?T1pFN3Z4WmFKZkhYU0ZnSCs1bW1tUTk0NmRmdEZ1SDhvRDRFKzRoK0wvNll0?=
 =?utf-8?B?VDdpaDI2cm9TTDVPTXpxeFdnc01Xczc2VitiS3l2QWJ6T1YwcHp0NmFXNFlM?=
 =?utf-8?B?N2FKck9ySGZoT2dMTHdqR05qYjVuNC9WTmdJQjkyc1BnYWh3V3A3akt0QjBI?=
 =?utf-8?B?c2dQUmpuVStrQ0FsQ0JtczdVTm1XYkxYZEpRUGhkRTVoeWRxby9tT0FNeDE2?=
 =?utf-8?B?MGVUdzRsQndLQ0tKZTgwZnF1L083Z0NVaUNqQ290Uk1McjZSVkNBZjZTZHlK?=
 =?utf-8?B?U09HWU1RUXdCVWYyL0M3aWltU0d2TG96OWdlT1Z1NVBKN3hFZy9rYTRGTFRV?=
 =?utf-8?B?VjBIVHppd1VmUEZncm9hcVh6TlpPeUIrQm1WUHJCWitEMEtzM0tjLzlUcmVm?=
 =?utf-8?B?a0tCS3dQVVJhbkMyVExEOElZZXJUZ25iMmhzamtkWjBrVTN3MFp2d3M4NXly?=
 =?utf-8?B?b0lRKzJiNkZqSXp1RThEZzVIUGltb3ZmWVVJd1hPTmZ2MzJreHd2VGNKSzBo?=
 =?utf-8?B?VHE3ZWVhczdYWGFpczZjNzVSWHJ3L1hKcXVpU2labUZQTjhUbHVra3JScWZz?=
 =?utf-8?B?MFRwZE1uZ2V3VFpTamdlTHhNVUY2Y0IyR045OHlmU0U4d1FrQTdpanh1Wjhu?=
 =?utf-8?B?c2IzRGVaSm03clZsc3FodW5Bc2E3c1Q2L203elZ2K3MwNVB1ZFpIYVdmN3hV?=
 =?utf-8?B?R0lkdjFLY1l1RFVoREppVHh0UURaaTdWU0pTTkx4VFg5dVdNUnZGMExpUGVl?=
 =?utf-8?B?dkN2dkE5V1BKL3R1VWpDeTZkV0hWUElZR2J0UE5EaVZBb1hYSjRVaGEwYjJE?=
 =?utf-8?B?eFJvMW43dmswRE5LQzJUaThBSk9CU3NWQUU0eXFTcGJER29OM1U2SUdINGll?=
 =?utf-8?B?M3ZHNklaM3NhbGZiNlJGc1IwTFBYNzQyUzdxN3VhUVpjdEZlVDRGUGoxY3RC?=
 =?utf-8?B?SmQ1MU93NVdVUW1sUzJwUzB6YS9FM3VXdjh2Y1ZpMWpYV0Y2NkI4OXdZekNn?=
 =?utf-8?B?czV2T3NKRnFjUVlNR09RcGJvd1poenBoVTd6RkxUSytxZjZtS2RCV0phY1Vr?=
 =?utf-8?B?OHZwRjFyWG1xZU9MUW14a0x2NFhNWENGb0ozV09Ob3BFUk5MWmZDWlhoOGlh?=
 =?utf-8?B?T1h3alp5UGZsVDBneXNsSHdPa2hINjczcVhqaU9ja1pCY3FhRGczdlFyblpl?=
 =?utf-8?B?NnI0K3dkWnZ5dlROSTdIcVJJZXBsS2NlenNBcHFxbGlWa0RoaE1tdGpuU1cy?=
 =?utf-8?B?KzQzS2V6dTJrV1ZXYXVDaVl2M3BLemowK1VQNHNNSDk2d25UalpXcWQ1TEc2?=
 =?utf-8?B?TUF3NVgzNXUrZHRMV2JVQzBBcWxKbG5hcTJ3WnFzUEFOVXdOTWFKSWwrK1B4?=
 =?utf-8?B?S0dRcGtnUTFFd1dMaHVOMk41MXZUNGpLOXJ5bzN3aXNGdklxWnYxVm9GQ21l?=
 =?utf-8?B?RTZXQW9HeXBoQTh1K1BCQVkrK0NMQmNPOE1DcjVoeWZMZDY1YXQweTJqSy9u?=
 =?utf-8?B?QUFTMllwaGdMdHJmZlZ1S0twTjZTZGpCZ1dlVzViblArOFh4Sm5hTTB6Ulpr?=
 =?utf-8?B?MERIVm9oMmxuUGpsOXpoQ010RnpZeFlvQTRNYUpFRXQ1anJDRS9rcXgxN1Fz?=
 =?utf-8?Q?PBZLrYtoRF76CLcE6CDkEPQhA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5f3abb-1c97-4211-88ae-08dd867c8d19
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 17:46:06.2098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8uI0qkMqCtxaxNKzjOs9Y0IlEY2z/INiKtdDE925U9DnaxocXL9/Cx4a5QH4RDL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
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

On 4/25/25 09:07, Prike Liang wrote:
> The dma_resv_add_fence() already refers to the added fence.
> So when attaching the evciton fence to the gem bo, it needn't
> refer to it anymore.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 610f447ede9b..d2271c10498d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -189,7 +189,6 @@ void amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr)
>  int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  				 struct amdgpu_bo *bo)
>  {
> -	struct dma_fence *ef;
>  	struct amdgpu_eviction_fence *ev_fence;
>  	struct dma_resv *resv = bo->tbo.base.resv;
>  	int ret;
> @@ -205,10 +204,8 @@ int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  
>  	spin_lock(&evf_mgr->ev_fence_lock);
>  	ev_fence = evf_mgr->ev_fence;
> -	if (ev_fence) {
> -		ef = dma_fence_get(&ev_fence->base);
> -		dma_resv_add_fence(resv, ef, DMA_RESV_USAGE_BOOKKEEP);
> -	}
> +	if (ev_fence)
> +		dma_resv_add_fence(resv, &ev_fence->base, DMA_RESV_USAGE_BOOKKEEP);
>  	spin_unlock(&evf_mgr->ev_fence_lock);
>  
>  	return 0;

