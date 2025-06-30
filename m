Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1A7C8302D
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 08:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5653B10E3B6;
	Mon, 30 Jun 2025 08:37:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wp9ZOh0b";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA8910E3B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 08:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqRVv33/Q8B1jPmcQzoviADB/U5EU0Ploi1bkMLfqxDkweCKoyfxPRos8EV5xqfcT4g9Au0nxlgkuQoXAxqvxLH6RsL98GorXrPJP91MyovN/tZ1+y0iTd+z9TMqsTPj3fIcBRct3uP45opVzqPjdwqbCuQCN5Ajo64+Qi1A5QpG1uJiqU/KTug16isZ455FcrQTItD31rklmZCyCjy9DyIlVv+GIDa9PdHF/qRO9UiS3RlgDi6NwEAzNWe2pczRnJsl0hv4sxkdIjnb3ATJ3M6fcV1YL7lNdM3DT0W9wKxakQIZZNoDpD0gOG3u8PZkZWycUh2q4vFQ29FQGuIi7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A27gLk1N2UtIXsppmxe4BteIBQxnuAUa+c21eYKNykc=;
 b=MpLzAPvQa4xMqW8bDlcd28Gahxt/y1g7s+S4anWH0ISgSIthu7pN8fAsq54meRe6WgMDdSkwIHQ3Qeeb6QUDRk9n/L1gCi1c8sx73zPfR42g7p06HXfdqn4IIiGKCUq5oU4KpX/aXzER1JUQR9KgFqzh5y0wrlTRN+pLfjPg8ZshNyLTTNRBIPFjHM6r2aXUxr4s/AqZw2ZfVKnkJlMeT4ktx9dIOUngtSzoVk5lbxZhMD3KeizDvKBRK4P5OxLSB7q6ys+VQ/C8h8UbD2NXCYPyBh/udRg/7TVqNYQg/mdHvfg/Dh7RZsTUZKQuv/QV+5M9K4YwglBvZA2RdHcd1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A27gLk1N2UtIXsppmxe4BteIBQxnuAUa+c21eYKNykc=;
 b=Wp9ZOh0byzNUwuoenbvC+wF8/zIcFz2o5lm7n1LzbZHb+rXRKs1d2kLug9ax3m5eBzM7y8dlC9Y2j9EZOZsf2HkCx8NrWhbbDpNOfF/9k8pHyWDLjeBJ6ssaqUUS76mPxo0GkynBwmQcRoN2v8AKC40pFWjkP4pk4kxh1QuDxfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Mon, 30 Jun
 2025 08:37:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 08:37:37 +0000
Message-ID: <39695048-2a48-4c80-985f-0475579781c5@amd.com>
Date: Mon, 30 Jun 2025 10:37:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] drm/amdgpu/gfx10: fix KGQ reset sequence
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250627034002.5590-1-alexander.deucher@amd.com>
 <20250627034002.5590-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250627034002.5590-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0023.prod.exchangelabs.com
 (2603:10b6:207:18::36) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df9d925-058e-4a25-51f7-08ddb7b15dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUkvWmQzQlQ4cUdTTXJIK0VxQ3J1V1ZnZks0YTkwaXZVVzRtb015Mm5Jbkhq?=
 =?utf-8?B?R0pRaS9Ibkc5UXNsaVhWa0dPUzBFRU9QU0xaUjlsREFyTWhpU1VzUnFtNFB4?=
 =?utf-8?B?UWN5NDdWS2p4QldJUjVpMzg1dC8wL1R2am9rdGhodjJ5MHFLUlBkbzJRd05N?=
 =?utf-8?B?aEhscThRMVdJTTBHcW9hbjI5a1RtWnVWanlNUjFueHIraS9zSHJ2T1k2bURG?=
 =?utf-8?B?T0tubWUvaUdOM0toanFkcHoyWlJhNm9jNXVxRUpCVzh3ejhYand3aWUwZWNP?=
 =?utf-8?B?bXdtQ29PZVFjczdSZ2htV2ZBR2prOUF3Y2E5MFRSc21YQkl1bGE2Ym9kbWd2?=
 =?utf-8?B?STFGamJYYlBsM1NZY3RodVd2ZUVPK3ZqY2NBNWFOV1RnZHU1MUlxWHNCeFB3?=
 =?utf-8?B?K0Q0dVMzaHVTY0FLSkVBOVBKNWV5Y1JBSjNhdXRCcGJyUVZrb1l5TTBENTFP?=
 =?utf-8?B?Z0VtWWZ5N09zYWU1VzRNcDkyc0NiazBVWnBndTJqY05ZclNLdGREQjlaa0tx?=
 =?utf-8?B?RXMrRStuNVUyVWRMMGlzWldzQ2pJU0lIV2l1a3JROTU5TVpmNytrc1o4Rmxr?=
 =?utf-8?B?cjUxNm82b3owZTV0RjNMTkpVaks1elRwb1BGOWY5dk52dXNKSFJDMEducVAw?=
 =?utf-8?B?VXZtL09yVjBkL0dVd1JNMzRBSnZYN2FnYklwY3EzamVwbzdQRm0xVndweUtt?=
 =?utf-8?B?Q1MxQzRubDRiQnp4Qi9Yd3JmUzlDV3VFMEZvSHJOL01uSTl5T00razFCMkFE?=
 =?utf-8?B?RDFXdjJGQjdRUkhCYTVjSWhMdXpCaFBPYk9wUGwxY2QxNzNJK3Vmc0hmWmgx?=
 =?utf-8?B?MWdrNE9XVUlsU0N6SXA1QTRuQUFKRzJ6UWZORmhja3BSSjVxU1I5SktKeVdt?=
 =?utf-8?B?MlhSZUZhNSswSFVVQ0l5WkJDbWNEVENGZkNMRHpIR2ZGb2hMWTk2SEd2L3Y3?=
 =?utf-8?B?NFFCSTJJTklpem1HOStaM3BoUTBWeXM4OWIrdWlYM2xyK1hoWmxxTzFlQ3cw?=
 =?utf-8?B?SGRvT084TGNnV2s0RVBzczBHcEZkeWkxWUNIMkJ6dThrK210ZnBDcGtwYm5W?=
 =?utf-8?B?QU5zYktmVXpSSy9RRW5YdWE5M1pPQjk0dE1NQ0pVSEJONktjNStHdGVIVm8v?=
 =?utf-8?B?RHlBSWdpaEc0YlZnVEs5NzVSRGg2bEgzN3g4OFRsRnp6ekNESXN1VGMraS82?=
 =?utf-8?B?eXpKNDQzdFJjbUFadmdxSkNBdE9FT2NMa3pvMkVaV28yQXpEWWNBcnF2MElB?=
 =?utf-8?B?VGN1RHduRjN6ZGdrK1Rsc0ZGeWZCdmNSSFhHNUpwNGVyb05JamlWb2N1ajVK?=
 =?utf-8?B?SGs5Vm56KzRDUkRRb1ZwUFFkS1puRVltaGUybW0rU3VaNnRqN2FBR2g0ditB?=
 =?utf-8?B?RC9BU21FbDc3R0NMRFhMOFlHUzFITjlFeGtWTjVqOEsyYlRtVW9scitCamgv?=
 =?utf-8?B?WUJheW9UU2xVOE9EemtUcU5uaXRvdStqdmNybFFTRG9Za3V3RjNDdTF1QUJ1?=
 =?utf-8?B?TVpROGUxSXlvcmRrNVdib3JlK0oxSUdhdEVZTnRHZkgyWVMvQ2Q1QW5WWnd1?=
 =?utf-8?B?YUg1MzNETlI1RWdDdjR5VGpFNTVpMkpqcmtGSTVMYTVGMm1CWGdWNnJpNnFk?=
 =?utf-8?B?cU9URUg1M1dkYXM5WkgzY1pJcVJ3T2MxQTQzNjBlMHVmLzZWeStKMms0Vldq?=
 =?utf-8?B?L0RZVkZNWEszd3BiMTRDQm1neUNiZHhHUlQ5dG9ORnVKdzg0aDJhYU8zL1NV?=
 =?utf-8?B?aFNNWkNjUFFyWXpnNXAyYkNrZUoyanRnZlA3emJkckpURG4zUFNiYU5vancr?=
 =?utf-8?B?TXcrMUt4TDA2S2ZwcEVPU1BsR0tNeWRWcm5xVWhSaDB1RVZoNDk0SmNWdWFD?=
 =?utf-8?B?UUd1bDg4ZVd3a095c2RQbkkvUEJEV0xMd1N2c2lqN0J6MHZPZUFWUURxeHZi?=
 =?utf-8?Q?NAOGk5C3VQA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2VyTEllSGVhdGxyMlBVN3FMaE5PUE1uaEY0MVh6STJvWlZkNUtVRmxtd0Z5?=
 =?utf-8?B?bE92WEQ1a0w3UEhSanMxeEF1L2JHQy9yeWprbEtqdW5DdUl1alBva0RmRm9H?=
 =?utf-8?B?cDl2ajZpRkIveGczMGlSOFg2ajB1Q0RpOWlleVY2bVF5ZHpUdGJUUzhnTEZM?=
 =?utf-8?B?NGZtNFFhaDRVdVpnZHhJSGRITlh3VW1IMHZob0Z3TUhwbFUxNExCZFgvYmlq?=
 =?utf-8?B?dUo5ZzZZZlRmSS9TUXhLcUowTC9xVWIzTGNwRFo1aHJ2M3NvbWdFZWFUVVNS?=
 =?utf-8?B?YlJEUEoySytubEZYVG9OLzRHMm45MG4wcU4zaDJqekt3d3diK2p4V2J4VGJM?=
 =?utf-8?B?YlFPaXNSdHVsNlhQSUdpcXJvN2pLVEQ1QitqcnpOcmtSZkFkZ3ZlblZOYU1l?=
 =?utf-8?B?NEp5M2J1T3A3Znl3eTZwMkEwdmVlcmZaeGV4VGxOSXFGbFJnN2pPeHFIc21j?=
 =?utf-8?B?K2ppU1lwSm9JODVNNFdTdkJGb292WDd2RS9Bc09vaStVTi9XNlAyRVMzdUNx?=
 =?utf-8?B?OFdMaXJlOXZUZkdMVDdHc2ZTZzdCWUY5R0ljaUZ1WFVoZHZtYnpKNVdmeWU5?=
 =?utf-8?B?ZTBEaTlwbnJkY01zL0Zodkg0RWdvcGFDU2VHSEYvNmE3S25nNUZBa1k5TFVR?=
 =?utf-8?B?TWczY3VpYlFEZlZudWdwdkJkb1luM2U4OVVVeG1pTGJETkMrYUV5QkUwTUM2?=
 =?utf-8?B?YkY0b2I2Q3lRdjhSSjViMWpSYzRDdkVxTVdKak5Xd1B5N1FOYWxHbTlzU3dK?=
 =?utf-8?B?ZFp4KzBoMWJVK1g0dkVMOXo3YW9QWkt2RHQ4VFRQR24xR3Z6WnFUcFNleHJ0?=
 =?utf-8?B?RHdzczdCWWRDRTJndEozQlNRVmFiaVc4VDdKcHJ6WUdCM2hwUEtYcHcwY2pr?=
 =?utf-8?B?K0FaTncxTURhK1Q3MWszeXVOaHV5alFKR29VQy9tb0RMSEFtVXhySnNZQU1D?=
 =?utf-8?B?U2JKcm9tN1BQbVU4WityWUMvMlM0WWRFeHFrNms0a1pnNEM0QjRUL1JqYXgr?=
 =?utf-8?B?Y0dUbVJkalFEZFA3dEFlb1RMa0dzTUNIdUhrNFFpRVg3TDlkTG50QkV3NzQw?=
 =?utf-8?B?TTFrN0dkcmlJcElyb0Z5WmhMNFpJSlVvOUVrOUh2c0ozdkx2MXBwdFg3V3hr?=
 =?utf-8?B?ZUl3a3JPOGU1dlY1U1hFN1RyL1JrWU5ZVHc2WlpldEt5Wm1MblQrNVNWYzNB?=
 =?utf-8?B?bFFWRkdhbi9KL0Z6YjJlK0V0Tkprb0U3YnlXTE5ZeFMvRjhXc0hkV3pLbzZl?=
 =?utf-8?B?RUZ4eHhFeHBsWTRNR3FvYVArSTRTcmdjSHplNTFqcmZEelloZE9FRk5CZU9X?=
 =?utf-8?B?bVc2TkZ3TWY1dTNpR3JtTjhlazM4MnpqckdpZkE3RlZwN0h5blRtTlhxRVZQ?=
 =?utf-8?B?akcxUEp1TFBZUGxka2RsSTFNQUZGU21lQnUxRSswRUNUWUU5c2VjYjlvM3J5?=
 =?utf-8?B?dC80M2QrWW4vbkdLaTE1Q3VNcHhyOFJ2eGwrZ0tVaHlmMVBGVkZjTXlKK3Vp?=
 =?utf-8?B?ME5IaURKMjB2MDZ2L2U5WHBVYzNPVlhPdDVKeDdNUnM1M3QxNlRScHo5VWlH?=
 =?utf-8?B?dkVMUHJEQktpQ0tONmVUT2xPdlJudllpWUo3cm1KcElWazlPQmpDUTNXeE1M?=
 =?utf-8?B?d1N2Wmlub29vN3Z5d2VsdVMwelEydXNhTm5SWStNMkx3bUtQVzdTVUtNaTFt?=
 =?utf-8?B?bzh3MldLaU5JVFlTK0lMQjIzZk5VbzhOZDNpY1ZSWGpmckV2Q2IrNXlmaXRi?=
 =?utf-8?B?NmtlTjdOYzBrVmptN0xVV01HVW9NcklHdExNL1YyMVRIYnlqRjVXQkRNVklI?=
 =?utf-8?B?WkZ6dEd6WXZORHZ6a0FxaXBZWmpwVFZoV1RnRjBFZHZ4S015VDB6azdMNzRt?=
 =?utf-8?B?a3hhR29uS3NIVjFqUGxWSExFNzUvcDZEWHRVbTd5bjhvVGs5YkhuTlNwVGlu?=
 =?utf-8?B?eUxoeS9ka1U4WG5seit3RlU2bnhYajdvMGNxc3pmSHJQNWpoS3Y5czhxRlYz?=
 =?utf-8?B?U0lrSXJrdzB2aWFJUDF3MWNiejRWN0Vqb0lheTAzaUlMQ2tZM0VUL29od0Jv?=
 =?utf-8?B?WTFjZzBxdUpHalQyWHFUZThaMThmRU9VRGR5aS84ZG1oWDRESG0rV0ZzYmZo?=
 =?utf-8?Q?pdTz4Tb1x5DyBL1V24B4fHfKA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df9d925-058e-4a25-51f7-08ddb7b15dfd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 08:37:37.2017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIi0x/fxjnrjlzsY4O8XRxmmRAa0xe2xxTN1O3olOw+527LYmqIsalbSI5Cpm3B/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594
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

On 27.06.25 05:39, Alex Deucher wrote:
> Need to reinit the ring before remapping it and all of
> the KIQ handling needs to be within the kiq lock.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 8c377ecbb8a75..5e099b5dc9a3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9544,7 +9544,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
>  
>  	spin_lock_irqsave(&kiq->ring_lock, flags);
>  
> -	if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7 + kiq->pmf->map_queues_size)) {
> +	if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7)) {
>  		spin_unlock_irqrestore(&kiq->ring_lock, flags);
>  		return -ENOMEM;
>  	}
> @@ -9564,12 +9564,9 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
>  			       0, 1, 0x20);
>  	gfx_v10_0_ring_emit_reg_wait(kiq_ring,
>  				     SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffffffff);
> -	kiq->pmf->kiq_map_queues(kiq_ring, ring);
>  	amdgpu_ring_commit(kiq_ring);
> -
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
>  	r = amdgpu_ring_test_ring(kiq_ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>  	if (r)
>  		return r;
>  
> @@ -9579,6 +9576,19 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
>  		return r;
>  	}
>  
> +	spin_lock_irqsave(&kiq->ring_lock, flags);
> +
> +	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size)) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		return -ENOMEM;
> +	}
> +	kiq->pmf->kiq_map_queues(kiq_ring, ring);
> +	amdgpu_ring_commit(kiq_ring);
> +	r = amdgpu_ring_test_ring(kiq_ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +	if (r)
> +		return r;
> +
>  	r = amdgpu_ring_test_ring(ring);
>  	if (r)
>  		return r;

