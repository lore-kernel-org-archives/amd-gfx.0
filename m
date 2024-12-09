Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20086E7717D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2024 20:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A135E10E550;
	Mon,  9 Dec 2024 20:34:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W3pR9kxS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC9610E550
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2024 20:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLK+135Au+lJ0SMW543CfGktpwLcIOdHSth38l9GoilWubIa+COvvvbb9oEvKZiKRQWrjo0XgfNmX3swqNp+Mw/C+rJ5kecw20dTTdi0WWzdN2YK9mcj9i6Syrimfp+feuUGEZAYdh4vsvPA/FvJ9mgH/U1JJv0VHxZMMLTFfRiLVlbz1RAT+zTbi64p6atycZieBQlo0f3mGgYOYe8Eh1ou61stocBfLpByKeCa2FSDEjeXKU2Zxi29127Uezm6Subq+Q8JUOQgg9slZPcNq90hlO3RzN0qlv5zIaUFJPGNU/aXOa9bmTi9ePShRAxZCDitYJsVVwcKRfQYISnHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/7H1xkZzStfbicY44i6jdhIuQlg5ZrDgbSWqpqlb3s=;
 b=CAU+0+E0DH3D8wEBCq2TBsVfd3eZAQbYCqOscy7FUpN1a2WyD925EN+1z9tYZRk8x2GB1L7Ila7/n3NrpfRtlYhOXIzoFOp0Y5CHrzX3+oRySTWBG9zwxA4o3B/1e4xqxZixyN1m+Gcx7p53pFXRrhf4O5LofOTepP0j+VH1DcjWRXJ2Ctjxt0rOpNEzb6pQL1qUAH72bdiyjD2Nj3353MeuUNrNtWohkBgCin54MOAtNU4jAmkm7KrJYVYoFU9XUUwFS4TiI5Zf/EB1uTJHK9MZUfC+IHT8EhmBMw9ULnhBCGvcGYT51E0QYN69cV3ryUSoN0FRAJYZccZERzeduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/7H1xkZzStfbicY44i6jdhIuQlg5ZrDgbSWqpqlb3s=;
 b=W3pR9kxSFICQ571Ok8mP/ry7fHnlwm6iG2MsJw9lLuZ1y7NNl+UjdRlNoDnTLjTIDc2X7nVW3cs1cLpDfvJ+Gwzm7EKtnUn3AyYCV7ehxuU6aHu13FiudnlKk5i1TtkAPkuaoxSKhT3PMYpYRZm7/eP+CXOGqQSinXWhQlyW0w8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 20:34:24 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 20:34:24 +0000
Message-ID: <4874071e-b72a-4227-895a-a967d2bf85e6@amd.com>
Date: Mon, 9 Dec 2024 15:34:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: rename register headers to dcn_2_0_1
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: sunpeng.li@amd.com, alexander.deucher@amd.com
References: <20241209154423.1861675-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20241209154423.1861675-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::37) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8aadfd-58db-4595-ac5f-08dd1890de39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVk2bmJMblJmVnE2d0JzcmtxTm1NSk9Ud2lRTEhxTTRyb1hBV0p5VWZYMDJ2?=
 =?utf-8?B?ZFJ4Nk83Ky8vQ2ZkY3I5eHovL21Ja2x5cmNJZEd6UmdtVlA3VVgzNExxSE8y?=
 =?utf-8?B?eUw0SFZsMmVUdXpZaEZaeG9QT24xMm0zZmJ2SmU5MTZsM2hNWUorTkcvZEdU?=
 =?utf-8?B?NjhmaVFFL2xlMWFoaGhKWXhQYlV2RUJFWEN3Y2t4VVlLTWFPdTVCaXJTdndI?=
 =?utf-8?B?emNVYmFtZ0JBZXlxM0pndTE4Mm5MM3lYVFhZclJCV3lHUWxOTVF2TVdJM1VT?=
 =?utf-8?B?cW5RR0VtNVpZSmZ5RmlEYlM2OFF0cEtBb0NDU2tZUi8yYXZETHZqaTM0NnEz?=
 =?utf-8?B?anVkU1ZuSmt3aVpQN0lYQnhSS2phYk5HajdwQ284YlhYcnJwUkdCSWFoNW5v?=
 =?utf-8?B?U1FURDF0YVNnc0dDNDBoTHdiT3Ztc2diNTRvY1hKMkUyZVdlWmtrOTdmRWpE?=
 =?utf-8?B?dzFNMWtDNGhsdktnTWV4a0ZpYmZMNmdZSmhKbVlsNzRoTklUTUV3OTBDK3hZ?=
 =?utf-8?B?N2E5QzlOcTdBRHBqU2hFQU1NOEZuRHdvenB2MGtIMzJHNzZyZkJDMmtNSXNa?=
 =?utf-8?B?T0pCSndOeTNRSnl6SWNra093UnZyOGZNUHlKY05wYndUbm5lQXZkNitxSmJ0?=
 =?utf-8?B?bzRUYmhnaHd4MW9OU0RhbUZJYld6ZGYzNGhpTS9PMGcwenlMSE5TWjNSaEJT?=
 =?utf-8?B?S0JDNXpQWTFPN0FMKzdxVEVacldScTg5L2ZzQWlBNUIvZ04zWTVpWDAyeDBH?=
 =?utf-8?B?cjBVUjd0c3IrTEREVkkrbzcvcFVtNTZpcVlyV0x1MnRncHgzeUVmUFlwaDE5?=
 =?utf-8?B?RUxKNnd1N2diaFBqb0s0RXlIazQ3UWs2NWt0eHZ5UHdFaE1SSklZamtteFc2?=
 =?utf-8?B?N0FVemU1eDlBTXhqTnZnZytnS0swTnA3UWpIZ1lScnRkVmVOSWtnUXFXN2VE?=
 =?utf-8?B?S1hXNG1uN3YxRXFBQ003WHpPOXNCK2pSRXI1d0tuTXVkc05WMUxBL0E4Q2F1?=
 =?utf-8?B?UDZRZW5McU9DVklRYU5DcmwwRS82Zzk5UEJwT2hrUTlqNWJVbysyQ1A5elNm?=
 =?utf-8?B?dTZFMkFrMlRyTFVLMTVuc3d4Y1BnenB5MFZjUVQyZ3ZTRlVCZDJIQXhPVTY3?=
 =?utf-8?B?TGovSGszVHJLVjdkRGRPNmxUcFUzd3prVXQzc1Mrako5YlNMTng4UTNzYngr?=
 =?utf-8?B?d3g3MlpuZmVEY3lQRjByblBNK1J1eGZjRjBDWGtxck5KVzAwa0xyZkc1MjNk?=
 =?utf-8?B?UDBNVk9QVkZuM21aNFRvcUMyOWpsWitKaHFkTFl4Y2VvKzdFSllCdGxORHVZ?=
 =?utf-8?B?RkZab29wa3BST2VWbnN5MDBLN0FtQXY0Smt2YlFMTGsyUjRRb2k1MFJKS0tn?=
 =?utf-8?B?bXpRMVlYclpIS2phM29hNDNUNTBWeTd5WWZ3M1dzdUEwaGpOOHlpQzRCOXdL?=
 =?utf-8?B?bG1GQk0rZ0xMQ3lJTSs3RUlHVTdOV3Jja09FeW1IRWNvOWo1ZUd2ZGd5ejBj?=
 =?utf-8?B?TGRGeEx2alB2Q24zaE1uRnhKY3FMUW5qdzU5WUNQS3JyZ2JrMVNIb3JFYXdJ?=
 =?utf-8?B?djZhM2s0WitzQnh0dWdWVU9qMGpwMkEzWDkvYzlSaThJZjR5QVRtUGp2dHZk?=
 =?utf-8?B?QXZOUmphOFpYYlVDWUZEOWYrZm13SEdMY2k5eUtCSHN0N1ZyL0k4aDI1Um1C?=
 =?utf-8?B?bDNVd3p5UEF1ZU9rOFRJckZHSWFGdGVvWGFTODZNQTgycmxTYTR1SngxZnYr?=
 =?utf-8?B?NkJFWFY0MG9lZGUwSDZGVmJ5THlncFRwWk5FUlFMNUV5WEt5Vi9EcElaY1A2?=
 =?utf-8?B?bFhFcU5rdDZlcjZCUDg2UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk1MdGxNR2hXMGNlTGJOMFZNSnp4bVNsU2owb3dQbkNaNSswQnBncmNHaXBR?=
 =?utf-8?B?WVZQSzhoTGdHazlXbWxWVW5mQnNNaVlENmFHKzNraGhyVzBoQmIzTmZvTStJ?=
 =?utf-8?B?L0g3bEMxVEl1VUtIRHo5dStuWnJlelJ1LzN5ai9iaUZLbFBKMjFmVFBwd2NW?=
 =?utf-8?B?dlkvYXY0MXhYQzVsNVhmSTZqQ0k2Q0FqcitFSEJ4M0ZJZExxdFNmMTN0U3Fx?=
 =?utf-8?B?UHdmWVlIb0ZiODBKa1lEQXVqUGFJUS9ZdVAvcjVMLy82dUhkY3BINzJ6bmxK?=
 =?utf-8?B?ZW43WkttQ0FzNG1oUm01NkY0cVBIRFN0UFJHUWlSTHNCN002RFVCWC9nZTBF?=
 =?utf-8?B?YmZkdld4TWc3K041c1NsYzE5cFEwMFc3aFVpR0VoVEhtUWpqWFdSNWpWTk1O?=
 =?utf-8?B?b1ZGT2tuMkUwTkdyS2N6UlF3LzErazFZRVpodDhzeUhMbEtnQTVINm1MQXlt?=
 =?utf-8?B?MnY3cC9ERW5LRGRxclA5bWVLWjZZL1A4c3F0SGgxVjc3OGp3emhpczFRU0tE?=
 =?utf-8?B?dHE3U1E0WkdKMkQ0UnR6MWcyR0dMMnI1WG9JT3k2ZmpscmNqT3c0Y2lTanNB?=
 =?utf-8?B?NzRKMlFPZ0Y4cUZFdk4zU0lHN1lLNzZ2bDZJaWdHZHFvWWkraHFCNEtlQ1lW?=
 =?utf-8?B?aGVQWDZnMERZWW1aelR0SjR0ZDB3bDl4Z3JuYlAzWktweDBOelc0WHNjdnkv?=
 =?utf-8?B?RGR5UEpFODNibkswQm4zTFk0QTFYU0xBbWF6TDV5TVlQS3QyNjY5MW9JZzNn?=
 =?utf-8?B?VVdSWDFJUEtCWWJuTnlzUnZEMjBjSC9wYnBjOFhIUVFKeDBrbHVicW5DTHh2?=
 =?utf-8?B?cGdSL3JJMk5jV0dSZTlEYS9zWm5WZ0lyaWI1d0o2TU9ya3E1N09NYUNVeGhk?=
 =?utf-8?B?TEdNdGFUTFFJaVRTWjRpTEdYVGlLOWYzVTFCVGxMYmlqdmladGdDcXBKbjBE?=
 =?utf-8?B?TldINW9HVUF3MEw0dnI2QVZGNUpHenMxbmNuOFZjcUN3cG9qcVpKbXNGcmVo?=
 =?utf-8?B?WjVETW84eE0xR3FIOXRBbmZtR0E3WnF2T014bFZERmI0enc0MFIxOFJlWXNC?=
 =?utf-8?B?ZEJQVVF6cTB3T2NZaHFSaDFGZ2hQek5XMzdJTjdqcTVSS1hmMnpUMjA5YXZE?=
 =?utf-8?B?MFpTbUE5c211Z0IzMDJ5Y1VrdW5kbVBBY1BjNjRVRlJJT2NhbWl4SW01dEpN?=
 =?utf-8?B?eTE3cUZiWGUvUS95TSt0ZW5rSjhZMFdPaVRDRzN1RUdSUE44SGU3bGJQR2Zv?=
 =?utf-8?B?RjFQOGJWVm04VU9jbEs2N3Z1R2NCeGZNUnRlNGVyTmJWQlJmSXJ4bDlWeGRs?=
 =?utf-8?B?WDE2VkhITDBOT2g2ZjdUTnd2aFNXcHhRS1lQWDN3RmpCQmZQcjNweU5oaXNO?=
 =?utf-8?B?ajArQXIwc0RtZitzbklLUzM3WDhUR3pLMjI2SmtldzBkNExjUnc2M3F2VVlj?=
 =?utf-8?B?N3RVSDkwdGJSem1oQzJrODRTbUswSCtMMmhBWkhxbEJyN2JXUGJiZFRheEZJ?=
 =?utf-8?B?OTlxMXN5TXlFZHBFak1wdXZJYmxzSzAvVWtZM0xxeUJPQnNwdzVDbS9URWgy?=
 =?utf-8?B?cGw5a1gwVGRZalRISnFoeW9WTDI0eU5KNTZjb28ySG9QelkyZnF4bkpkOGEz?=
 =?utf-8?B?YWxnd1BkcXZUUDdRMTR1R0F4d3ZuNjA2VkdhME5KNGJiaUZLV2ltSTRMWnRi?=
 =?utf-8?B?RGRKdFFiUXpzcUI0OWhpd2Eza3BwZWVzUHo1WlhyWjZjVWVoUzR6SkY1Z3VB?=
 =?utf-8?B?b1BpZldhaDVNajlWY1BERnpBOEJJeUg4am52WVRJRTNoS1ZsaHZTNjR3MHZL?=
 =?utf-8?B?c3BMajlnU2lNcHNLYkdybmg0ekRVQzNRZ0lBREw3ajAwM0JkZWlEdFBITmli?=
 =?utf-8?B?N1Vrc042OHZVZkpQOW5hUzliOGkvNnM0dkJxczNubnZGTFg3Q25laVpuRkpj?=
 =?utf-8?B?RGN6SEhkUlBHcGRLcVB5N0dzM0FSQmV1QzJreXRSSENSZVFSZDJRdzFEMGRE?=
 =?utf-8?B?cGlzRlJ3MlR4QWZMb3NUUlh1K28yNnI3V0pnVnp4bFREQnB3c2ViaEdiUzdV?=
 =?utf-8?B?UWhKc1FtdjE3aVZqeG5LamF5bzVqME9vVE5POVo2aHUwVjcrbGt2NXlHeklX?=
 =?utf-8?Q?BS8T2IRHoiCjKrGIKoMGAZTDg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8aadfd-58db-4595-ac5f-08dd1890de39
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 20:34:24.1541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bxii6gF9esRONBFNciF/bWkS37KrqMfO574r+0R7LL0WxWqkGHP+XIq7CN/7XUHVO2QsQ8o1pxgnJTED31IfQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742
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

On 2024-12-09 10:44, Aurabindo Pillai wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> They were named with the incorrect dcn version.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c    | 4 ++--
>  .../gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c    | 4 ++--
>  .../gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c  | 4 ++--
>  .../asic_reg/dcn/{dcn_2_0_3_offset.h => dcn_2_0_1_offset.h}   | 4 ++--
>  .../asic_reg/dcn/{dcn_2_0_3_sh_mask.h => dcn_2_0_1_sh_mask.h} | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
>  rename drivers/gpu/drm/amd/include/asic_reg/dcn/{dcn_2_0_3_offset.h => dcn_2_0_1_offset.h} (99%)
>  rename drivers/gpu/drm/amd/include/asic_reg/dcn/{dcn_2_0_3_sh_mask.h => dcn_2_0_1_sh_mask.h} (99%)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> index 7920f6f1aa62..76c612ecfe3c 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> @@ -34,8 +34,8 @@
>  #include "dm_services.h"
>  
>  #include "cyan_skillfish_ip_offset.h"
> -#include "dcn/dcn_2_0_3_offset.h"
> -#include "dcn/dcn_2_0_3_sh_mask.h"
> +#include "dcn/dcn_2_0_1_offset.h"
> +#include "dcn/dcn_2_0_1_sh_mask.h"
>  #include "clk/clk_11_0_1_offset.h"
>  #include "clk/clk_11_0_1_sh_mask.h"
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
> index 4fb9cd6708d5..1d61d475d36f 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
> @@ -30,8 +30,8 @@
>  #include "../dce110/irq_service_dce110.h"
>  #include "irq_service_dcn201.h"
>  
> -#include "dcn/dcn_2_0_3_offset.h"
> -#include "dcn/dcn_2_0_3_sh_mask.h"
> +#include "dcn/dcn_2_0_1_offset.h"
> +#include "dcn/dcn_2_0_1_sh_mask.h"
>  
>  #include "cyan_skillfish_ip_offset.h"
>  #include "soc15_hw_ip.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> index d3d67d366523..9f37f0097feb 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> @@ -59,8 +59,8 @@
>  
>  #include "cyan_skillfish_ip_offset.h"
>  
> -#include "dcn/dcn_2_0_3_offset.h"
> -#include "dcn/dcn_2_0_3_sh_mask.h"
> +#include "dcn/dcn_2_0_1_offset.h"
> +#include "dcn/dcn_2_0_1_sh_mask.h"
>  #include "dpcs/dpcs_2_0_3_offset.h"
>  #include "dpcs/dpcs_2_0_3_sh_mask.h"
>  
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_offset.h
> similarity index 99%
> rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h
> rename to drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_offset.h
> index cae1a7e74323..73c5dd5e83d4 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_offset.h
> @@ -19,8 +19,8 @@
>   * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
>   */
>  
> -#ifndef _dcn_2_0_3_OFFSET_HEADER
> -#define _dcn_2_0_3_OFFSET_HEADER
> +#ifndef _dcn_2_0_1_OFFSET_HEADER
> +#define _dcn_2_0_1_OFFSET_HEADER
>  
>  
>  // addressBlock: dce_dc_dccg_dccg_dispdec
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_sh_mask.h
> similarity index 99%
> rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
> rename to drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_sh_mask.h
> index ca1e1eb39256..290d807800a6 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_sh_mask.h
> @@ -18,8 +18,8 @@
>   * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>   * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
>   */
> -#ifndef _dcn_2_0_3_SH_MASK_HEADER
> -#define _dcn_2_0_3_SH_MASK_HEADER
> +#ifndef _dcn_2_0_1_SH_MASK_HEADER
> +#define _dcn_2_0_1_SH_MASK_HEADER
>  
>  
>  // addressBlock: dce_dc_dccg_dccg_dispdec

