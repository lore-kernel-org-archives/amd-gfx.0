Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FF7C369D3
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 11:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DE4A10E1E6;
	Mon, 28 Apr 2025 11:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pNHb5Hfh";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B72710E1E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 11:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2teHeH2gwF3ViEZRZBOukIjjXe1fFgxa0DAjIAaBzQlByMa+SnXXemuiYEiNseFLDaL9pD2U4pIqQ5rKlf4cN0Y3impI7mtGvBc0gRHaBFr2O1F16lMiqA0pgYoUzOwoLUOO2FEF7EEfuf6u+aVUWOuaYiO4gKfiQW7zg0X8RoWdnpV/9I1v/pjZQydxLTWeSAocuY3IJbP8q9zpg2eq8aaSt7K2EcC73F71tfY6H35bCd1Qgj2OZFUe0WXu12UeVEWYfU3yfVWTHPGjY9nETkY9wKCyCzlECH3qIR4WJrIVSAQMt700z8aMbqZvcFJ4f1CrTq8dlKXXiPt512mLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Et88jm1+4ub7kegA5WiENXxypkNu2VDwvi++cNcdF4E=;
 b=oOfAK7ejmGXTAdnqFdo14SaOx1aQ1tdXLfGXh5IUSeTmr8wVBBpu8IgR0So56fwFVw/skEijj3h/oZWJnVUagAS0a/QR014Y5IyLDN6WVZv8Sf8fJ3HpZNGCVLLHePqNOHjeNqRf3SUHF+HwpdVDXRJcgO/63/CctSyaxVdtT5XT6DPjLPE7ZuHCQDqP7KrposiREXLfJBmvgacE0fuCLvRnm1ooAdeIr8Ufj8wfbi34zFWPNitreQ990c3w7VrO1yPY0qU76MAQG0PMCtCDjJrr8e1BSI2peTZCjsutWPhBcQKGajlFr2lqUTa1AKlFx/Uhv83svzovAsU0OrAfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Et88jm1+4ub7kegA5WiENXxypkNu2VDwvi++cNcdF4E=;
 b=pNHb5Hfhdzy4ZpeDnensXa8dpLVxujX4/jylAkRfY49/wZQ6wtxpwjsfMz4e8yzN8PRglcn0n2Y/aTM8MWvzwz7chOCBKlpMkpgemPs0PHL66ukOzULPN6sTbvwWqZA0xGk7LcFXa+TUnHu01qxTT7D1akDtfFn2qTMJBSbcn2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 11:14:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 11:14:20 +0000
Message-ID: <20aa04e5-b091-463e-9152-6e8647afa399@amd.com>
Date: Mon, 28 Apr 2025 13:14:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling
 Last Fence Update and Timeline Management
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250424032123.3888361-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250424032123.3888361-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: 34096232-a088-4814-4323-08dd8645d2e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0c4cm82MmRpcXptSFFOOGdQLzFTT3RMTEc1UWt5dVhGWE1mczAwRllWSlVB?=
 =?utf-8?B?dytsbXFxRDBKVU1POFE4azhpNXE1WUVZSUZiamg0L0d2a0JJckpSdkJuaExw?=
 =?utf-8?B?UldRVk1KcVBSQUd4TkZoS2RheHFuU0ZZMlJ4MXNyRmxWMDcvejVlMEYvYUh4?=
 =?utf-8?B?TmRhTUgzQVBHSW1hRDRKaWNxWVB0eTQ0b1didGF1cTFtR0VXdzV6cHJpYmN0?=
 =?utf-8?B?VzFpalVjMlVSWlJhNDZyemg1TkFlZjU5RVJJUFM0RzRFN3BCc01MT0Ntbitt?=
 =?utf-8?B?VnJqSnNWdHNHZHNKSGdPVGRiSGZJMlF1Z25ySDFScER3enpiYkFSVy9MUEo3?=
 =?utf-8?B?RTdUNVo3OTM3WGowaGNtbkVtNGxEa3laTmc4ZmxPOFJzYmhGZUZ2SnM0NTZa?=
 =?utf-8?B?OEUrOXlwTGJRbTVLZGRlVUpZVUhQaVg1Umw3T2tzV2NNQ2NXZnE5dU1zYU0r?=
 =?utf-8?B?UDVoVkdGd2d3Mlg2Uk52Sm5pRjRHdVY4bXdBSnFiNGIybUlNU0RsNThmVXB1?=
 =?utf-8?B?T0NPdHowNnVDcGorckhWeWxEeEUwOGowK0VZSXFNZHpvMlhaOXJkMVFNd2tP?=
 =?utf-8?B?YVZRRG12VlU2S0Q0cnBnb0hrOXVwVTdKVFJoYUNsZTBJWHVPUmp1NDJweFhW?=
 =?utf-8?B?LytjUk9mckZjV3NoY0hSSVVUZmxSSWZQN2dmQ2ZLYkxlcU1ranV0bk0rRFlk?=
 =?utf-8?B?dWgxdGRTY2NVRTVLakZiTWNqUzl3TG4xOWlZbkViTFJIMjNBLzk5bWxabGRZ?=
 =?utf-8?B?Ylh3Ui9TOHA0anJSMWppVXEzZ0ZnejBqVlpYODNCcW0rck96Zk42THU4TVQx?=
 =?utf-8?B?TGNtWUNuNUY3ZXVtWHhjN0FBWVduS1B4RnhiSzZVV2pZWTg4UHgxbHBKMHpp?=
 =?utf-8?B?a1hxWGRXazN2TVRLSks2V3JLV3NYQmVMb05kN21FMEdDT3hPWi9mcDh2eWFD?=
 =?utf-8?B?YTQwUHhpZjQ1Ri9zOFRXM2JNakRObzVGcktMcWNlN1Y3WUlNM0hUdll6K3JT?=
 =?utf-8?B?V1NwWXhoYXBwd1ZJbFlpS0VQWEdHT1Z2ZER2VGN3dktQc2JrNTRZc3NTeVRT?=
 =?utf-8?B?V1NnbGljQSs4V21uMUZpenR6TkorNWFlT1JvbWN6MnpGRURxMmVTMno1dkJT?=
 =?utf-8?B?Z3N2RktNQ2JHRDdMVFo5bzFmaStIcFZpTFc5OFJtNDFRYTdOcW9neWVUMXJh?=
 =?utf-8?B?T25Jc0NBZVkrRGVBZWhvcVVYRHErZTluSVAydTQzM291Q25lUDhpcG9zRXoz?=
 =?utf-8?B?UjJoWUtDamxRbEJiK1I2TTcvYU1NVlIxYWYwdHBrZmR4eDUyY1d0dW5YT3FD?=
 =?utf-8?B?TkJ4NGVrbEJQanUyb2ZMd1hTVkxBYkdUZ25mcERSc05hRTVqZnZhTlgrZG92?=
 =?utf-8?B?RnZWNThtWkpYMElQaU5oN1ErQkdlUm9aMWRrMG5iRmozbldHSjlMaXMyemNL?=
 =?utf-8?B?YXFNdElIaEJFUGVlNXpwcHNtdXljZThuNk8yQkp5S2hEUndvNWJsRWJzMnRM?=
 =?utf-8?B?QUdEQ0R4QUYwbHZybFhkVy9CS0hzam9wcThCTEtCN1BzMEozdFBKd29GRG9M?=
 =?utf-8?B?dGErL2pvcmdYNUY2QjJDQ0dCWTJkSiszVXdaWXNVdDdzUzRZSEYvOTJldUF0?=
 =?utf-8?B?SXJoUTVGUnJZVmZaV3ZRejVBRE0zQ295dHE2a005NU1lSVpaRTF4REFuWjRJ?=
 =?utf-8?B?cTRQT0QvWWc3VzJYcUU3VUM3TE82clF3ZGNvZVg0cXlNYllHRjZBMmtQMTU0?=
 =?utf-8?B?RVhaVU9RVk05TnpHbndDRU9IWlN3RkNLVnFyUDJlem5OTENuWDRJK0R6UFZk?=
 =?utf-8?B?MTRDa1N2d2dIWHZ1N2tveERjYWxNVmp6V2Zsd2FmNzB0TDE3MVJYZ1RDd2x3?=
 =?utf-8?B?ZHc3bjd5d2NVM2xSNkMycEFDT3U5TEVBcW1tdG80cnZKNlU1SFQwSzNOUWZQ?=
 =?utf-8?Q?IvNmVrPlKSA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmFPN3V2ZmV6VE96aFJwWmFUaXRuUGtIa2R2ZHVKbHNock1JTjV6TGVmQ3Yr?=
 =?utf-8?B?a2xXYzFaekV2UG80WllBTm1uRGVwOWg5bWNGWmNmMnNKQlRlb2ZWQi9OL0do?=
 =?utf-8?B?Q0gwWEdOdzA4OTlDUHFDNm5SMUszQTFTTndRV3ZWa2pRVFVaWWR5emFaaGxO?=
 =?utf-8?B?RVNlYmJNVFNMK0VMbUtxaG00VkpTOGh2MzdpOWJ4dkJBM01zREh1aFUzOVNq?=
 =?utf-8?B?eUkwYWtuR1lCVzlSekN0UHNYanhGMmFHczFvMGNzVHpCa0czL25LaWZtL1Rp?=
 =?utf-8?B?QTJNZW1OcFBJRDBmU2w4eTNLUUV1NFQ3UGExMmVybzV4cjNZWjZHVnZZbFVl?=
 =?utf-8?B?SVhDdDBzakFpQmpaZVJabFRSZERvcmpneGpZNVpkSE5tMS9kOEJJWDVWMFhC?=
 =?utf-8?B?WHI2ZWNjTjF2djViSVVML1ZqdUErVGVxRCtXUXlTZG54NWxaZlZlRmRydnQ3?=
 =?utf-8?B?aW5OMHRVVmp0NDA4bkNTSU1OYWZPUjdMT0JCQXFZaWRnMUh2d0xIZVFLS01x?=
 =?utf-8?B?WldRdm84WnEwSHpFK25zWlhsNFVqVDZSU1BuUTZWOG1VeDlrdkYzMTI0M0xN?=
 =?utf-8?B?U0QrbDZHODdxOXF3NUkrSmRrQkhWOG9Lem9jTXovK2s0cTRpeWlRakpXQUFK?=
 =?utf-8?B?YlZEcml5aldRS2JXVndFRys0M3ZxQUQzVmdudEo2Z1EzaXJxbkpYMDkrMHE5?=
 =?utf-8?B?VlM2dkMyOEljNU53bkZUaU9nOHNNQ2lsQnJRSUlXK2JIRjdBYnpLazdUck4x?=
 =?utf-8?B?NkdoSjFVR0ZQZ1h2QUV4Y3NTc1JyUjRVSGFvdm9wUXVRV1NwMkJZUklYSmVx?=
 =?utf-8?B?cy9vd1lHcXpLQUVLendyL2l2V1huR3gyR1VpdW14ZW9JSlpRU3F6bHBseHpB?=
 =?utf-8?B?dlBBQjVqMlJjUW5TcytQbll4enArdTFSSWh3MVhLRDBDdFBzZ3hSTVdWcjdp?=
 =?utf-8?B?aDhVeUZkeU1sRHRkTnY2ZVl4V1gxYWRGZ2tzYUpUUHVqazJCN0paSkRwV1Mr?=
 =?utf-8?B?WDdRZm1QU0tvZFlwQlVyNWUvbkRzOVRpMk8vN082eGU2M1pINmpNZ3ZWcEpW?=
 =?utf-8?B?Sm1VSEhIeDJRRHNBRklXaXM4aHNuYmowakN5dzAvL3dyTnhxclZPQ05KdVYv?=
 =?utf-8?B?bmhBY3I0YnJvcm13bXZabDQxTjIwUE8rLzI2OHJveDZxM1Nad2tUK2padDZn?=
 =?utf-8?B?Y1VDWFlDaUI3UjgxaDgraldOM1NzTy9mUDhTcEJ5bUpSbHRuQXNGNkh1TGF6?=
 =?utf-8?B?NCsyc29EMG9pUU5rQ2h3dXBXRUhTN2VQWVJ4SEphZnVNRkhCVWhKTlphM2ND?=
 =?utf-8?B?SUlXdi9ORE03UERNaDlmZVZjVWppcXlkMzZ0SU9BUDBhYWE1L2JWZHVHaU4w?=
 =?utf-8?B?LzBVZVZ6OXpUU2Q5dlUzZWdyalhKWmdZOUdGSm80aWtGY3dLSnVreGJXZENJ?=
 =?utf-8?B?bjFMa2RUNjFWNzFEZG9iUGlXalZoQjJyQzRBT1YzMGFXYkUzNDNJZ2g0czdB?=
 =?utf-8?B?WEpLVkZVZWtibjZtR05hOHpFb0lpamhRcU42akUwb1RxMUNsaksrbnB5cDZl?=
 =?utf-8?B?VFJhcy83aTg2REF2UGtuNVdId2kxRjRwL0dvTlFwVU8xL3FtNlh3a25CVURD?=
 =?utf-8?B?TDlPZDBxRG50OGM5S21abGtTSVh6Ukd2dHhWZGtJU1hsUGNGZDNDNVZseDg4?=
 =?utf-8?B?WnZXSEh1QXFKNFBXcE1lU2xSeE1DYm5QdjZXWHlGbWhTUVZyTTRmRUprd3M4?=
 =?utf-8?B?RVdpQk5rMVdSVDV6dmMyV3Bjako2UThyQWpXaFlOYlliV1YxUS9NWmZUcXZD?=
 =?utf-8?B?RHRvNGp0V1orK29oZUdJQkpiQUhlMGFKTlZkUEpua0xaZTF5N1dIVWNqOExI?=
 =?utf-8?B?eVhjUUttblhjbnhnZjAwLytJajV0ZmVNY2pyancwTThXNXdmTzI3RWR5d0hB?=
 =?utf-8?B?eGU3RXYvNmM3TnR5N0xvMGdxZTJMaXlyUk9xYkw1R01UOHVESXNtYk5sU0dm?=
 =?utf-8?B?dVhhdnJLVFFFRlhqeUU1SEhNcTZHVFByc0R5UFFHdHl3alB5UWI2YUtwSDlr?=
 =?utf-8?B?WVN6U0RmRkpRRHJCZnFubm5aNTdxVkVGMHpxMzhkMkJUS3VRSlVZclUyb21q?=
 =?utf-8?Q?6ZeSG07BEprvenPa0VGxM15/6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34096232-a088-4814-4323-08dd8645d2e1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 11:14:20.7975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WcSyTxS31sF5s18lzB6TzEmh0HFu/l4okMVjDyJSmYBeMHg77Y1mtoPyVlBCAyP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426
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

On 4/24/25 05:21, Srinivasan Shanmugam wrote:
> This commit simplifies the amdgpu_gem_va_ioctl function, key updates
> include:
>  - Moved the logic for managing the last update fence directly into
>    amdgpu_gem_va_update_vm.
>  - Introduced checks for the timeline point to enable conditional
>    replacement or addition of fences.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 96 +++++++++++--------------
>  1 file changed, 41 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f03fc3cf4d50..c83947c0269b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -112,47 +112,6 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
>  	return 0;
>  }
>  
> -static void
> -amdgpu_gem_update_bo_mapping(struct drm_file *filp,
> -			     struct amdgpu_bo_va *bo_va,
> -			     uint32_t operation,
> -			     uint64_t point,
> -			     struct dma_fence *fence,
> -			     struct drm_syncobj *syncobj,
> -			     struct dma_fence_chain *chain)
> -{
> -	struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
> -	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> -	struct amdgpu_vm *vm = &fpriv->vm;
> -	struct dma_fence *last_update;
> -
> -	if (!syncobj)
> -		return;
> -
> -	/* Find the last update fence */
> -	switch (operation) {
> -	case AMDGPU_VA_OP_MAP:
> -	case AMDGPU_VA_OP_REPLACE:
> -		if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
> -			last_update = vm->last_update;
> -		else
> -			last_update = bo_va->last_pt_update;
> -		break;
> -	case AMDGPU_VA_OP_UNMAP:
> -	case AMDGPU_VA_OP_CLEAR:
> -		last_update = fence;
> -		break;
> -	default:
> -		return;
> -	}
> -
> -	/* Add fence to timeline */
> -	if (!point)
> -		drm_syncobj_replace_fence(syncobj, last_update);
> -	else
> -		drm_syncobj_add_point(syncobj, chain, last_update, point);
> -}
> -
>  static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>  {
>  	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
> @@ -751,6 +710,8 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>   * @vm: vm to update
>   * @bo_va: bo_va to update
>   * @operation: map, unmap or clear
> + * @last_update: a pointer to a pointer where the last update fence will
> + * be stored, reflecting the most recent mapping or update operation.
>   *
>   * Update the bo_va directly after setting its address. Errors are not
>   * vital here, so they are not reported back to userspace.
> @@ -762,9 +723,11 @@ static struct dma_fence *
>  amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  			struct amdgpu_vm *vm,
>  			struct amdgpu_bo_va *bo_va,
> -			uint32_t operation)
> +			u32 operation,
> +			struct dma_fence **last_update)

That is duplicated to the return value.

>  {
>  	struct dma_fence *fence = dma_fence_get_stub();
> +	struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;

I think you don't need that line any more. But see below.

>  	int r;
>  
>  	if (!amdgpu_vm_ready(vm))
> @@ -774,11 +737,22 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  	if (r)
>  		goto error;
>  
> -	if (operation == AMDGPU_VA_OP_MAP ||
> -	    operation == AMDGPU_VA_OP_REPLACE) {
> +	if (operation == AMDGPU_VA_OP_MAP || operation == AMDGPU_VA_OP_REPLACE) {
>  		r = amdgpu_vm_bo_update(adev, bo_va, false);
>  		if (r)
>  			goto error;
> +
> +		/* Set the last_update fence based on the operation */
> +		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv)

Please use "if (amdgpu_vm_is_bo_always_valid(vm, bo_va->bo))" here.


> +			/* Use VM's last update fence */
> +			*last_update = vm->last_update;
> +		else
> +			/* Use buffer object's last update fence */
> +			*last_update = bo_va->last_pt_update;

Just update fence here instead. That is the return value of the function anyway.

> +
> +	} else if (operation == AMDGPU_VA_OP_UNMAP || operation == AMDGPU_VA_OP_CLEAR) {
> +		/* Assigning the temporary fence for unmap/clear */
> +		*last_update = fence;
>  	}

Which allows that to be dropped.

>  
>  	r = amdgpu_vm_update_pdes(adev, vm, false);
> @@ -839,6 +813,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	struct drm_syncobj *timeline_syncobj = NULL;
>  	struct dma_fence_chain *timeline_chain = NULL;
>  	struct dma_fence *fence;
> +	struct dma_fence *last_update_fence = NULL;
>  	struct drm_exec exec;
>  	uint64_t va_flags;
>  	uint64_t vm_size;
> @@ -934,6 +909,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  		bo_va = NULL;
>  	}
>  
> +	/* Update timeline node for synchronization */
>  	r = amdgpu_gem_update_timeline_node(filp,
>  					    args->vm_timeline_syncobj_out,
>  					    args->vm_timeline_point,
> @@ -942,6 +918,10 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	if (r)
>  		goto error;
>  
> +	/* Call to update VM and retrieve the resulting fence */
> +	fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
> +					args->operation, &last_update_fence);
> +
>  	switch (args->operation) {
>  	case AMDGPU_VA_OP_MAP:
>  		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
> @@ -967,19 +947,25 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	default:
>  		break;
>  	}
> +
>  	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
> -		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
> -						args->operation);
> -
> -		if (timeline_syncobj)
> -			amdgpu_gem_update_bo_mapping(filp, bo_va,
> -					     args->operation,
> -					     args->vm_timeline_point,
> -					     fence, timeline_syncobj,
> -					     timeline_chain);
> -		else
> +		if (timeline_syncobj) {
> +			if (last_update_fence) {

The fence will never be NULL here.

Apart from that looks good to me now,
Christian.

> +				if (!args->vm_timeline_point) {
> +					/* Replace the existing fence if point is not set */
> +					drm_syncobj_replace_fence(timeline_syncobj,
> +								  last_update_fence);
> +				} else {
> +					/* Add last_update_fence at a specific point */
> +					drm_syncobj_add_point(timeline_syncobj,
> +							      timeline_chain,
> +							      last_update_fence,
> +							      args->vm_timeline_point);
> +				}
> +			}
> +		} else {
>  			dma_fence_put(fence);
> -
> +		}
>  	}
>  
>  error:

