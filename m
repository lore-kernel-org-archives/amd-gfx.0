Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F73CA0EEB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 12:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCBE610EB02;
	Fri, 22 Aug 2025 12:58:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d9jQqy39";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 162C310EB02
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 12:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LO37/X40nauOdn5xp/b87rdeX6B04glVNoaCTB30DZPsXRl0MvETNhVh8Xyl/AT3vsmfLjImSPAR1MSTRULNIqu/DoOfQTfkofmJi9AvPOkkmE8jQzxb6HK9e4kYSwxag+g67di5Og1Yl5Sg6H5sOVLZX3LFmGHEM3ALUoP/b22RGtdTQbVe38FFKSUHFM/hb97h6PgqJPIoPAiaek7pyBaoStMFhcNBFgi1/iT+dIY4fHoTEsdwitaoG+1BNi20ubrGkd/w1/2KuR7/J47T7Q1TKJJGr+PiyMnSmFYZj0+yl9JGzjaORdu/+15T+5c6DdFfxP9xBgx5jqv8Ux8d+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1K3Wexz8EgFvNc2G2Yw85tVj/KdB8yQzWR/pslrkSw=;
 b=a6IMjKQB2hWfrDpJlggnIRjY5/MZCNCiIgx1qGD5qjy2APWBpRljkrsirUZzo7T4/mocod8Koz3SxEO3ERvba50sub9Jx4XTiIdCC0dxFzO+ktCo+qcUiOq/xOAA2x6DKH1IuZXDOBA8GDzam6ZzxGhX8LYS9Fuz++VzSnZEEqjXz/nTRx/slSd6E8GH28VPizjgAhKfoZMYpIHGMtqQccd9kDoHJNrLii58kU1dXGUtewwpAlAtc1Tc2jNnZnuQEgXSuMcuVka0n97ax+YzGCHCHCmIgULyOsTu50J5S8Mvkc/syh6uwTApqJN+rUk0avsn4cyoAdJzgGWzI6Y8aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1K3Wexz8EgFvNc2G2Yw85tVj/KdB8yQzWR/pslrkSw=;
 b=d9jQqy39D83ZWZIsWv7suI4IYkNIlKEvqvLP7JyLWHXxmKFmz0xVKJEXZeIgrRa8dOmp6smAlulr2o6rDOLw5uPzPwY3BZ7hnCjZuKL9LO9v0Z/NQBDKxR6rsqJsF9/LAtJXmCZSIaZGCQsUKxTkeG90i64gOvrVILWP+sFrDvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 22 Aug
 2025 12:58:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:58:34 +0000
Message-ID: <af9b826f-4d4c-411c-9694-d9a9e9a36dcf@amd.com>
Date: Fri, 22 Aug 2025 14:58:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/4] drm/amdgpu: Add mapping info option for GEM_OP
 ioctl
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tvrtko.ursulin@igalia.com, Felix.Kuehling@amd.com, David.YatSin@amd.com,
 Chris.Freehill@amd.com, dcostantino@meta.com, sruffell@meta.com,
 mripard@kernel.org, tzimmermann@suse.de, Alexander.Deucher@amd.com
References: <20250813184953.3666821-1-David.Francis@amd.com>
 <20250813184953.3666821-4-David.Francis@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250813184953.3666821-4-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd4a593-a503-4e00-760a-08dde17b9a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2dwOFNJOEYvUHdOTFR0SFV5QTRzN2l0N0JpczN5UEVjRFlTWlhGWFp0UUY4?=
 =?utf-8?B?bndEVTUzTjBZRkdnZG52ODFkREhIM1JGNDBabGtESnB6MU5mMWVMQmtpSVkr?=
 =?utf-8?B?dDV5dnpRcTA2ZWhLdGd1N3Z2OEZpVHNGOVRseDlNRUZJUGsveGlsOENucGFI?=
 =?utf-8?B?dnVtaldJc0QvL3JpbTIrTUhRb2dETjRoa0FEMzJwWFJnOUVHL1Z0R09jY0RM?=
 =?utf-8?B?eEM1NTlDY0V0VEJsNlhWRThwcnlRb3ZWR2ZrczFiSkE1dEpJZ1FDWFJ0cVR6?=
 =?utf-8?B?bTVBcytvaDFRS2p0cEU0RVdEZVI1NmJ0ODNqejlvV2hFbkdSUUxESkgzdUxH?=
 =?utf-8?B?OG1CNnZ0ajVLWVRZSk1LTVo5eWREdU5vWVhnampjSVN4d2NvWkhyNk1yTGlj?=
 =?utf-8?B?TzRUWHBHbjRQT0ZucUNIaHoyRVlCWllxUUxEWFRyMURRbU9wVDdiVUNocEtw?=
 =?utf-8?B?WHdjUklzajhuQmlUaTVBdjI5N1dVekprRXVtTHJvMGI4eFUveno0b29jbG4z?=
 =?utf-8?B?VHhoUndIMUZzLzd1ZjR0MkowR3ZtSE5pUTNpSjllanZRNjlTZU5KTGRqU1hL?=
 =?utf-8?B?N0g2S0pJZmQwbTVkQzJtWGFsYncvaDhUTUFsZjhjanNHZGt0Y2p3SEdkNWlU?=
 =?utf-8?B?SkVaZ0QreXZCdEdpckR4bVFWYTJhdzF6Z2FKdlRaYWhUM3FpbkpQSWU5OGk0?=
 =?utf-8?B?Mm4vY1p4MXlIRncwVFByVFpzUG9ITEMvNUVkZ3p4ZW9KbkFSSUNZQ05IeGlG?=
 =?utf-8?B?dUcvTVZGRUhOOGlTejhIa0U3QnpFR2lzQm5FU05ZR3JjSDdXUlVid3hNWVo4?=
 =?utf-8?B?STNCMlJCVWpIUEdWOWlxLzl3M3JXMjZlQ2wybEs5YlNBQ2FkWlA2UVdkV29p?=
 =?utf-8?B?MStMUWROM2pSeGVETzYxUk5uUGpSMWF4SmYySTRRcTVJT0NQdjlDWlpBNjBZ?=
 =?utf-8?B?UTNvcW1NOEx3VGc3SzFPSnJJRXZHQmtwa1YxZHdJMXBER1Fmc1NMdG51RmJZ?=
 =?utf-8?B?QWJNM1pSUkRJbGJoay9Jd2ZISzVVZGF0TlVnUVZVTlN1cDRHeTFES3VDUW4w?=
 =?utf-8?B?UFZld0JqOVNFcGNJOEk4bnZtajhkelRKZWJZcWlWR0F2c2dVbGxjdG5MZzRp?=
 =?utf-8?B?cjhkNHgzSGJ6bWphRFVPN3lCeWRndTlmMFhZZ0c1TmZuZXpZSVpQOUdGWC85?=
 =?utf-8?B?Y3pwTzI4TTRTVzJVVEdzdXJNNVczKzMrZ2c1SnYrWXdCTEJBeXlKL3EwQ1dS?=
 =?utf-8?B?aE5jZzhkNnBYSy9TQlhEYkd2NFYyOWhyQnkyVVpscDY3ZC9FUzh4ekhWRGZr?=
 =?utf-8?B?emVLblcvZFdQUWcvNExNOVNWTVY2ak9tcjM1QU9KTDREREQxVnpvZ01JeThC?=
 =?utf-8?B?eG9XMHUyZFJnOWlITisyUjFsSlJGUXdMckI3eFhvYlNsektNM1BLSW4rZldm?=
 =?utf-8?B?b0FrQjJwZXZxblBSbm52b0QwTE5sY2piZUhZL3pRNE9BemVTeFJMYUFsYU9n?=
 =?utf-8?B?UFREZWloOE1lRWcxSFpXeVlYRzR5b2ptN0hCZHphVTBwUkVRbVY1alJJc01W?=
 =?utf-8?B?VHJXNjJwZVVidmxYdjRHbXowT0NYWmVEekd3SnB1RFJPNGZKZnBJN21JNE92?=
 =?utf-8?B?Yy9qWkx5Nk83Yzh4ZzdRVFEwcGdXbDFEVm8yeXJSdm01YUxzcTN2S3ZKR3Y2?=
 =?utf-8?B?WE8wTTN1am55ek5MWnVKa251eUkxcmVydzQ5T2tsZXhRWnMxMmZ6MzQyeU8x?=
 =?utf-8?B?b3pLZE4zZ0tnNGZFM29ybXlLQm9jeEtiYVVJZVRDcXhwWU0zdFdMRE1DVFFN?=
 =?utf-8?B?ZGJUV1JFS1NxMXQ2RG1SbVB6Nm5LZTVaZG8vZjRZRWJhZjN6eVBWWjIzR2VP?=
 =?utf-8?B?L2FGVERpbVVFd2JxVUllK1pjRFRPL2pIUFovb1huZ2pMSkZ3Zy85ZlpZL0I5?=
 =?utf-8?Q?1SWN9iyCzRo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnQvQjFic1pPQlhTNkoyUmVJcGs1TmZTaGF3NEJrOUQwTERGdkhuUUxkVWYw?=
 =?utf-8?B?MlZDUk9jREt0dExmc1BYQXpBWldGQmdocnBPZzA3QnZoVFBHcFV6ZDN5VFpU?=
 =?utf-8?B?bDR5cWd6TzNxbGk0S2ZIQlhyM2xiTWdVWHI4MGtOM3Z1SXYyRjZDNXFrM3FK?=
 =?utf-8?B?TWw5eDZqVWJBcXdKM3A0VHpnMEZtc0V6dHNQRVE0Uk1YUFJWczFIR3dSaUlH?=
 =?utf-8?B?Wm4vbzNzek90MmR2a3ZDN1VpRHB5bjJERTdSMzdTRWVEZTFpNndJWlRvdTA3?=
 =?utf-8?B?ZDZMeG4xZ2ZqcDduYlJYOWZyZ3RyK1pPVUhiMzdxMEhnd21QZ3FrbnRqT0w2?=
 =?utf-8?B?VTZUVE9jMktPVFV0WlpnL3FiMmFNUlZBWlRGaVBGN2U1bTMvckFHRVd1d0ZX?=
 =?utf-8?B?QStBc1h1Yzd0MXVXWUZWUHdwSHVwZ25ZOEJrZXBmRFB4T05tcDdkS0lEYjJK?=
 =?utf-8?B?Q01yMEVxU1JCMzhMenp3ZUlORFVnNUNTMU4wTjlnb0dham1OaGc0TUZDcDV5?=
 =?utf-8?B?N2xoRGdFL3pod0htY3lzRG9NMmJ1S0tBSm9EQ1VncEtqMWFEQkJ4MUVTMnlN?=
 =?utf-8?B?aE84QWxLSlorMXFudEQ1WU45QzNzd21mVmg0ZW9JZnBSWU04ZnVMcWpVV1ZH?=
 =?utf-8?B?blEwNXk4ZU5YRWErUDRWbUlNbHZHdFludHZJaXBlYXpuUktKcDQ1T1dMMWxw?=
 =?utf-8?B?KzNTdEdCbWowT2RycEplRVoyWjdBRktxNWRXcTNKMkhkRzBqWEZwR0svb1RM?=
 =?utf-8?B?VkMrNklscGU2QnBPVlBiMHkvYmNVcFg4MnBXMlJQcE1CZ3hPUFlMVkM2dDVU?=
 =?utf-8?B?ZjJDQjlZenFYUzUzeHBjRUowcWU4bWJpd2pTYlAvNCtMallVeXBWM0h2Rlh1?=
 =?utf-8?B?SmZjSGF3aGdtYUlTUnQxN3k1bFVvQ25IM0ZnREppZkhQVlpaa3A5dEk2WXVr?=
 =?utf-8?B?a3lWMmYrRmZjY2k5T3dCcHpYUWR6M2JNWEwxTlJBU2laRUZGZ055bCtTMW9O?=
 =?utf-8?B?d2RNWVhHM055SjU3dCs5TXRGZ0VDS0xkVWkvQVlPdHprdnBFM0VwT01sMUUw?=
 =?utf-8?B?SG1Bem54RzFpa1MzUURnSXFQRnBxblpGWTl0NDFCYTE2VHFlUHNGRVZyOWRM?=
 =?utf-8?B?WVhhMmxicEJyTEY1OUdzU1hKcnl2cDBiQko2R09GaDIrb0pQWHdjdFdNdEdZ?=
 =?utf-8?B?ellLc0Y4WVFwSEdpTnhwRWd1eFIreHUvbncvMVJyYjV1dUdIYys0Tngyam1Y?=
 =?utf-8?B?S1JocEhpOWRJRjlhTUZqYUUyTW9oZjAvaTI0ZWMxWDFHczJTa2lpRWZ4SmZK?=
 =?utf-8?B?alhFWXlGeGlOemhlWmFQWW5CVlBwa0sydktXSXc2Y2d4aFhia2t1OFJ6bkkr?=
 =?utf-8?B?LzJYT0dpT3llZnJ0cjQvd1hrbGlpZzJ4WkNvZW9zTXpjOS90MFJPdFBzVEdt?=
 =?utf-8?B?UXlHaExjVFp6K0R5K3RoaURWMTFoUEIzSE9semM5VnMvNGxrYzFSOHRWeUoz?=
 =?utf-8?B?WWxRV0JLQnU1Yi9Ea0l6endJVXd0QjlmR0lWdzluV0NRRFpNblpnSFFSaHlU?=
 =?utf-8?B?YVNWTWNmUS9DUzI5U0NNOEZkWDErd29kY0ZMemJKQk1qbDcwVFRySWdJc0Uy?=
 =?utf-8?B?eUY0c01zZnNGSWxKSVU5UFBMNS8rWjM5MHkzZkNuYTdHYWxMMzJubTVJTU9J?=
 =?utf-8?B?S2pLZjVHTlBpOHhYOUZYMGpUWjVCZlRuS2ZHL0lBOG1aQnlXVDg1TW9qQWdn?=
 =?utf-8?B?elBGYXUzd2NCMDhBOExYeHJYY1NySTNyQWZvQ0hNbDdiRGhaTEVNZ0NPcGNH?=
 =?utf-8?B?RHZCemNLLzZPU3dtWDYxcEYrOHBqVDRsYU1PcGNoU3NJZDMvUjBURWR5eUl2?=
 =?utf-8?B?OTZnayttVDMzU0k2QkdhZmV4ZWVyTUE1Nnd3b1ZjQlNPZFViVXpMTVZROUdz?=
 =?utf-8?B?d2duRGJxd21XdGVMcWpvN3Z6V1RwZzZ2Tm1hNGZ2ZzAzK3FXcXpYb003ODNI?=
 =?utf-8?B?MHBzUy9GL2pHdHpJOVZwYnFKZUhOckFRWjNnNzRiWWV0bXRlL3hGQzZUQzda?=
 =?utf-8?B?NEpoRUYrQ3B0WmNOUG1HRFpMOFhXanBIL2YxSWZXWFArWEl1YnV3OFBvenFJ?=
 =?utf-8?Q?PWO7a9v38LEzOGZxJcrXfh7FT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd4a593-a503-4e00-760a-08dde17b9a59
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:58:34.5214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeWQ5p+A1JsOuUKRWqbFhlsSsA7/THaEU0CYXkanzbbj9qfe4letI6cRc1J/fL0F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188
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

On 13.08.25 20:49, David Francis wrote:
> Add new GEM_OP_IOCTL option GET_MAPPING_INFO, which
> returns a list of mappings associated with a given bo, along with
> their positions and offsets.
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 87 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 ++
>  include/uapi/drm/amdgpu_drm.h           | 21 +++++-
>  3 files changed, 112 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index d17cc7ba66d4..f66f6e1f1c52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -948,6 +948,89 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	return r;
>  }
>  
> +/**
> + * amdgpu_gem_list_mappings - get information about a buffer's mappings
> + *
> + * @gobj: gem object
> + * @args: gem_op arguments
> + * @fpriv: drm file pointer
> + *
> + * num_entries is set as an input to the size of the user-allocated array of
> + * drm_amdgpu_gem_vm_entry stored at args->value.
> + * num_entries is sent back as output as the number of mappings the bo has.
> + * If that number is larger than the size of the array, the ioctl must
> + * be retried.
> + *
> + * Returns:
> + * 0 for success, -errno for errors.
> + */
> +static int amdgpu_gem_list_mappings(struct drm_gem_object *gobj, struct amdgpu_fpriv *fpriv,
> +					  struct drm_amdgpu_gem_op *args)
> +{
> +	struct amdgpu_vm *avm = &fpriv->vm;
> +	struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +	struct amdgpu_bo_va *bo_va = amdgpu_vm_bo_find(avm, bo);
> +	struct drm_amdgpu_gem_vm_entry *vm_entries;
> +	struct amdgpu_bo_va_mapping *mapping;
> +	struct drm_exec exec;
> +	int num_mappings = 0;
> +	int ret;
> +
> +	if (args->padding)
> +		return -EINVAL;
> +
> +	vm_entries = kvcalloc(args->num_entries, sizeof(*vm_entries), GFP_KERNEL);
> +	if (!vm_entries)
> +		return -ENOMEM;
> +
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
> +			  DRM_EXEC_IGNORE_DUPLICATES, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		if (gobj) {
> +			ret = drm_exec_lock_obj(&exec, gobj);
> +			drm_exec_retry_on_contention(&exec);
> +			if (ret)
> +				goto unlock_exec;
> +		}
> +
> +		ret = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
> +		drm_exec_retry_on_contention(&exec);
> +		if (ret)
> +			goto unlock_exec;
> +	}
> +
> +	amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
> +		if (num_mappings < args->num_entries) {

> +			vm_entries[num_mappings].start = mapping->start;
> +			vm_entries[num_mappings].last = mapping->last;

Those two needs to be multiplied by AMDGPU_GPU_PAGE_SIZE.

> +			vm_entries[num_mappings].offset = mapping->offset;
> +			vm_entries[num_mappings].flags = mapping->flags;
> +		}
> +		num_mappings += 1;
> +	}
> +
> +	amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) {
> +		if (num_mappings < args->num_entries) {

> +			vm_entries[num_mappings].start = mapping->start;
> +			vm_entries[num_mappings].last = mapping->last;

Here as well.

> +			vm_entries[num_mappings].offset = mapping->offset;
> +			vm_entries[num_mappings].flags = mapping->flags;
> +		}
> +		num_mappings += 1;
> +	}
> +
> +	if (num_mappings > 0 && num_mappings <= args->num_entries)
> +		ret = copy_to_user(u64_to_user_ptr(args->value), vm_entries, num_mappings * sizeof(*vm_entries));
> +
> +	args->num_entries = num_mappings;
> +
> +unlock_exec:
> +	drm_exec_fini(&exec);
> +	kvfree(vm_entries);
> +
> +	return ret;
> +}
> +
>  int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  			struct drm_file *filp)
>  {
> @@ -1014,6 +1097,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  
>  		amdgpu_bo_unreserve(robj);
>  		break;
> +	case AMDGPU_GEM_OP_GET_MAPPING_INFO:
> +		amdgpu_bo_unreserve(robj);

Yeah that is not really 100% clean.

It would be better if we use drm_exec() in the amdgpu_gem_op_ioctl().

> +		r = amdgpu_gem_list_mappings(gobj, filp->driver_priv, args);
> +		break;
>  	default:
>  		amdgpu_bo_unreserve(robj);
>  		r = -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f9549f6b3d1f..5a63ae490b0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -668,4 +668,9 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>  				 struct amdgpu_vm *vm,
>  				 struct dma_fence **fence);
>  
> +#define amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) \
> +		list_for_each_entry(mapping, &bo_va->valids, list)
> +#define amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) \
> +		list_for_each_entry(mapping, &bo_va->invalids, list)
> +
>  #endif
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 59b423883e91..bc1e18c06ce4 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -802,6 +802,21 @@ union drm_amdgpu_wait_fences {
>  
>  #define AMDGPU_GEM_OP_GET_GEM_CREATE_INFO	0
>  #define AMDGPU_GEM_OP_SET_PLACEMENT		1
> +#define AMDGPU_GEM_OP_GET_MAPPING_INFO		2
> +
> +struct drm_amdgpu_gem_vm_entry {
> +	/* Start of mapping (in number of pages) */
> +	__u64 start;
> +
> +	/* End of mapping (in number of pages) */
> +	__u64 last;

Size please, not the end. To match the UAPI to create mappings.



> +
> +	/* Mapping offset */
> +	__u64 offset;
> +
> +	/* flags needed to recreate mapping */
> +	__u64 flags;
> +};
>  
>  /* Sets or returns a value associated with a buffer. */
>  struct drm_amdgpu_gem_op {
> @@ -809,8 +824,12 @@ struct drm_amdgpu_gem_op {
>  	__u32	handle;
>  	/** AMDGPU_GEM_OP_* */
>  	__u32	op;
> -	/** Input or return value */
> +	/** Input or return value. For MAPPING_INFO op: pointer to array of struct drm_amdgpu_gem_vm_entry */
>  	__u64	value;
> +	/** For MAPPING_INFO op: number of mappings (in/out) */
> +	__u32	num_entries;
> +
> +	__u32	padding;
>  };
>  
>  #define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)

