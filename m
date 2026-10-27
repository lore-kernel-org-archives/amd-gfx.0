Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E8606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SqNgEeRt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3174C10F843;
	Tue, 27 Oct 2026 21:45:44 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F3210F843
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 21:45:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+BGLBruj/1fd7nW7pM3H68c++0f1qrnqlxM+MAo4Qc6qBXcQbFtpKL87J2q/iZ3gE41Eo8dJu8KLjSWJ/yb9FsQQXt/07XMtN6F461LAUmoeZwl/QXCP52px3onJT3bj4aoES5rN/gzpEzdwWiT5LG6ju0u3cyuakejDo5QT7Een0g3p3yHF3hLqfkPaKVtCbxuWcHfmBWOexrWWZYYJ+ipVxpDCCn13h15PdgJ4DdqAb27zE1VJtPjL0cmWwuZhySWO7O7Da9HhxAg6wUetVUhHFRd5LdVjKvhRR3pOZ2NBvBrlh/KJFhL3T1EDbrhD+kn4oVtFhkZIM2GaOAdpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFZIkhEJmoy+xVtl3JBmmIY7szWtygT8iquXZrENcyk=;
 b=yBk7rTOEi8OuCE0j/ghEvFqzSuX5XWHpyAnRTCWKkSebwgKe/MsXg0n58JtWSIobivW1tU4XKSAS2SP4t4OR12IMqP8Oh/rIyiEY+qX8euvl50bhn6Rgtv6HjbW9P31NwtjMi5zIOcdNrBU1u9LjuYarQZEQyzx87psi8X7BudBelruT0Ik9Y11AuK7qDPjrI1AvH5bNtKxezTC2yDewPIkH9M6I+/jizKjZ6tl4bwkdrxODAVnbUW+2y/VJ2zQ0kaWFwTsOZskdomjPBqISTb4AvZ7ve5BSVgI3O7L7kTpeaPx9Ie+1TxYvcUKk1rDEYTM8HTzsXab8RJWJi/QBQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFZIkhEJmoy+xVtl3JBmmIY7szWtygT8iquXZrENcyk=;
 b=SqNgEeRtsWYH6go5dC6Glq7auoTe/WalKN6A4clAPP514pBhfaNuP3BVSie8mxqW85ftRld/Tdtg/Y+ZCA04qdz2skRbD/IoDX4LPX6mTPlCJxtaqiWWIk4S7735gWyxf978VisF+pCcP0dAUW4x1yVUj7/2/+MysOc7Er8IIIQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CH3PR12MB8901.namprd12.prod.outlook.com
 (2603:10b6:610:180::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Tue, 27 Oct
 2026 21:45:34 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:45:34 +0000
Message-ID: <d4f68dc2-5675-4270-9e9a-616a4ebc9152@amd.com>
Date: Tue, 27 Oct 2026 17:45:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 6/8] drm/amdgpu: Enable UALink loopback mode
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
 <20261027195913.1794477-7-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261027195913.1794477-7-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::13) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5f5672-0bc2-48d5-f047-08df3473a176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|18002099003|261026121527099003|22082099003|261022075727099003|261022105027099003|261021123027099003|11063799006|261021121427099003|4143699003|10067099003|261009223027099003|261026140227099003|56012099006;
X-Microsoft-Antispam-Message-Info: UgXo+GvbQYjfDz0XjB/CHNDn+MrzVQZ9SbCkGA3TyPMsbd5D/UhP5E6Pc7b5G4Rlh1DWfZDyt02dxf7DiJFgWcAlPcUVVKuyUe5JgPb/3RmFfJWdKvNWxPce/swhJ6DSdc9/gUA9cjBhSZV52xv6Al42FI60sgy6qCesSA9nWOQ4Fnw20V0ms59nCKCXT5qpsav+H+4j+dvyVkSKtvH1D1DFvkPyOeW2CU04uJbiVOZEphJDNjoGWeSswl4LVhExaVCP2OnA0IFNENM4b1mbnO0oWL1YUFuPEYnIgu+C92gyvVOfzTdCjvcbg0i8jdlp1QHEV9MFJp/Tfln7jQOVSl0EPiibLSoLfCN5n7tPJK4D9Afi13Mm8XQOtwoFCcGDmJR5esvrd+TTfoinvoOnm+wUBATIJOpDf+rm8dvjGs4pJuXuvvNxx3s51BWyb78biADQEfridenSuIqoIpmYHT3D9aG9dueahbcoVtfkFAdSkTa/PYxXOReC7h7Y4kzdqbNQ3kHEgXtj8DTnN8aQoHuUGC3obZCh4KbxwzpaPrwTf74EtV/ZS4fVqgh93HSS8NaDJI2qIlnJodFfEbtRu4jn39rCpEcrptCJ0f9QLyXWOOSYvXjHtsVdilcO7BPAPH57GR7qma3b9sz0A0fSMenUUQbrC7qD+QHi6gtiA5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(18002099003)(261026121527099003)(22082099003)(261022075727099003)(261022105027099003)(261021123027099003)(11063799006)(261021121427099003)(4143699003)(10067099003)(261009223027099003)(261026140227099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTFRYXNJRUU5dWZ6djVzOUlQYkl6TWYzRCs2WFJtU0poNHArM1lwZ3ZMbWVT?=
 =?utf-8?B?bkZoL24yUitJeEExWCtYaDQzekVQODJqTWJHSWh4WitLdUR0WFJLUnQ5Q3dh?=
 =?utf-8?B?TVUrZXhacDkzY2FsVGcrdnljMVA0NFRtTFpiYUZDbnVaTi94dEllS2VycW5D?=
 =?utf-8?B?VjQwdVNTb3Q3Wk0rcjdJSFRXUWNwMGtIbStZMEZtQ250L3pEMTV2V2plWjZJ?=
 =?utf-8?B?WkxBMEg0Nmk4WTRHdGFUZlBkQjhSd3BEZFY1aDllMHIvNUdWdXdjR3lGMjVF?=
 =?utf-8?B?QmhhS0Q4SlpBTmhYRlJRc0MxZ0d0NVpON1FMcmNna0IwK2l0NFltNEFjNkVo?=
 =?utf-8?B?bldoa0d5S1E3WUdtckd4STRrNGQ5Q1lHbjhKUnBvdVIzTWJGcjhRZmpHRVA3?=
 =?utf-8?B?YU1nVkkrVzFUQ0RoQmQ2RDNHV09GOEFUeXZCSkhBblJKdFA0aTdmQmRMUnp0?=
 =?utf-8?B?Y3F3R0VIMEV2TVZITjNzMWxOUWJsQVNuQmZTU3hSeXg3aDQ2dGQ5alY5Y3JK?=
 =?utf-8?B?WFpjd1FKV3lFVVl6MVE2NDlUbDZJL3pKckhpYldKUTJ0d1g2K1FwcGM3SkVv?=
 =?utf-8?B?MFlzSkFvcnJBZ01vY2ZIcDhnY1NoeS9mUHV5UnVJQVNGcVdTSk05YXRsclNM?=
 =?utf-8?B?a243bkUyT21HWUl1N3J3MVFhWW91Y1UyU3ZyV3VKZEVLU1R2U2pKUlVFK1Fh?=
 =?utf-8?B?WFUyN0xqWU1SZGxmT0VQa3FmVWlid2ZyRndMRERGR01uOTdQekhIOVVJSGVn?=
 =?utf-8?B?Qkw3V3pCQllnTzg1NjdNV2ZKdE5heUc4RzVkVm8vc3hjQ3NaT3VPMzhrMnhN?=
 =?utf-8?B?K0RFYUV2Sjd0czlSaG1lbnNZenVUWEtnemx1RFJ5c2tQdkozZWlHdHl5U3dr?=
 =?utf-8?B?QU5JV0dYVFE0M1ROU3dScGtzcU1VTVRjUWpqMW9vUkZVUzBhZHgyNXI0TDJz?=
 =?utf-8?B?VkQwRHE1VXJnVnJVS1NzdXI5bHZHNkpydmQvcTRmaFlTR2J2dktBSGEwNlNj?=
 =?utf-8?B?dGpQc0l0cnZzRU5pYnJvckdxb3Y2T1ZjUWZ1NWh0ajdFL2h2T3c0VUplSHlq?=
 =?utf-8?B?RVRJdDZSTmJaa1VIWkZjZ3p0ck5BU3BMOThEaUNjT25OYXJwRlZyVUV4ZWp5?=
 =?utf-8?B?aVh1TW9QV09rRXkyY0Rra3d3Y2ovS09ydmhaVktjc2YrSnNlUCtHRXQ1WVBF?=
 =?utf-8?B?bFd1Y2s3NDVzdjJicFNFeDZyM3BPbmZlZ0ZtWFRpd0VWanp3UzFRNER6Nk9Y?=
 =?utf-8?B?TzJWcFpBWUMvampkRTdsZjVMQmc0TnZXcStqMnI5cGdhYWNvL0g3Z2ZFbGFm?=
 =?utf-8?B?RkNrQlZZQjU4ZFZCamgrUWFQU0RKRHZBRFlYanZPYktjVW1XeGxKeDhPV2gw?=
 =?utf-8?B?VkdaR2NpdjFvZThmaXVzbkM3blFqUEQ5Z0lqN2Vidi9PNmxnZlljL3h0bkFD?=
 =?utf-8?B?czNDSTFUMytOcHpHSlg2OXlGOUpCM0dYOFhURTluMVEreS9FYVF5aHBjNWR5?=
 =?utf-8?B?Mjh1R21EdG8zaFJoYUlzekdhL3JQbEpmcnd6L25za05iK1VnVVlxRER1MUN1?=
 =?utf-8?B?WEZidEFvVHZMbzVoUFJYTjAwYTVENVdidnVWMzdjUTl2NlNVR0JiQVJYdE9M?=
 =?utf-8?B?azlWeGhFOGJsRDU5NW9vWkdYRXovckkwLzZrOHFIb2FUTG1oNkphL2RWaFRQ?=
 =?utf-8?B?LzdCRkJ0RmUvWUtGSWxiaFFidTBZNVRjVzNqWnZJTWQ5UFJ4ZUgrUjBJMFZL?=
 =?utf-8?B?RFVQUEUzeGZiSGJRTEpJY2o5bGQ3WG1lY3ByMm5IUU9LU29CQzFMUHN4VEVy?=
 =?utf-8?B?QXQ4TTRtZjgzc29zN2pVZVkyVWlHUHRpaVVYeVQ1cDRDQTlDeTQ1UkxYSDhG?=
 =?utf-8?B?MGdYbmtGVS9OY25jZDg5ZStRenIvelhrYlRGL1JNcTY0VjRLYWg0Z3RjRjl6?=
 =?utf-8?B?aHRQdjhIamdrZTJ5T0NsS1dLMTV2Sm9SWktrTHVSblMwL28zRHUwZ1ZvTGti?=
 =?utf-8?B?KzJzbkdxZ3V5M0ZVMmwxUi9XaU1yL2g1SXNBcnYzYXkwbCtrMk0rbnV4UDE2?=
 =?utf-8?B?TVVnY1NtZFh1MzdwcXlMRTIxNDEwWGV2cllvRGM2djJhaVU1a01KSHUxS1Jn?=
 =?utf-8?B?WEo3aFZXNzAxaGJSeUVnZU14U2tkS25XcU1QTFRveUp6eTVvQlBUSjU0QnZ2?=
 =?utf-8?B?Y0k0WXlCWk9vVFlkK1RHdGhrczBrb293SXh5VllkYjRlZHRyRmVRYm9UNGo0?=
 =?utf-8?B?NFZXcVlWTWFEY3d3UXY2QVdraVplWXkwdHRGTVJBd1pTT2hXM2JSN0N2eXc5?=
 =?utf-8?B?SlBMNmNxMG1OaUVONDhScmlLc2swVm80VW0vVXU3Q05hbmlYQzNYZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5f5672-0bc2-48d5-f047-08df3473a176
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 21:45:34.5645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWulz6u2DBKeScO/205fJXCAe2HL/M6vdniUSAfNASFxoUuJjMpCqzWoRqC9hQg5ylKRNRmYOwVLvIIy+5M5uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27 15:54, Mukul Joshi wrote:
> In UALink loopback mode a single GPU acts as both the exporter (accel
> ID 1) and the importer (accel ID 0). This lets the existing tests export
> a BO and import it on the same device, traversing the UALink HW
> pipeline.
>
> Add amdgpu_ualink_loopback_detect(), the single place that decides
> whether loopback is enabled. It runs right after the UALink info is
> queried from PSP, before any per-peer setup. When loopback is enabled:
>
> - There is no user-space agent to configure the pod, so synthesize the
>    pPod/vPod configuration with both accel IDs active.
>
> - Activate the device directly instead of through the cross-GPU vpod
>    activation path, which needs peer GPUs and a user-space vpod commit.
>
> The mechanism that requests loopback mode is added separately, so
> amdgpu_ualink_loopback_requested() returns false for now. The normal
> activation path is unchanged when loopback is not enabled.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 128 ++++++++++++++++++++-
>   1 file changed, 123 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index e6272446ff4f..14b9c05a0f0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -63,6 +63,7 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>   static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
>   						 u32 sender_accel_id, u32 dw0,
>   						 u32 dw1, u32 dw2, u32 dw3);
> +static void activate_accelerator(struct amdgpu_device *adev);
>   
>   #define STRIP_NPA(addr)						\
>   	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
> @@ -93,19 +94,130 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
>   }
>   
>   /*
> - * amdgpu_ualink_loopback_init - set up UALink loopback mode
> + * amdgpu_ualink_loopback_requested - check whether UALink loopback is requested
>    *
> - * Called once loopback mode has been detected. Allocates the ordered
> - * workqueue used to emulate exporter->importer interrupts in SW.
> + * There is no mechanism to request loopback mode yet, so it stays disabled.
> + */
> +static bool amdgpu_ualink_loopback_requested(struct amdgpu_device *adev)
> +{
> +	return false;
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_detect - detect UALink loopback mode
> + *
> + * This is the only place that decides whether loopback mode is enabled. It
> + * must run before any per-peer setup, since enabling loopback changes the
> + * accelerator IDs returned by ualink_exp_accel_id() and ualink_imp_accel_id().
> + */
> +static void amdgpu_ualink_loopback_detect(struct amdgpu_device *adev)
> +{
> +	if (!amdgpu_ualink_loopback_requested(adev))
> +		return;
> +
> +	adev->ualink.loopback.enabled = true;
> +	adev->ualink.loopback.exporter_accel_id =
> +		AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID;
> +	adev->ualink.loopback.importer_accel_id =
> +		AMDGPU_UALINK_LOOPBACK_IMPORTER_ACCID;
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_populate_info - synthesize pPod/vPod config for loopback
> + *
> + * In loopback there is no user-space agent (AIFM / xncmdclient) writing the
> + * UALink sysfs nodes to configure the pod, so populate adev->ualink.info
> + * directly. The layout is fixed and known: a single GPU alone in its own
> + * physical pod, presented as accelerator ID 1 (the exporter) and also owning
> + * accelerator ID 0 (the importer). The values are made self-consistent so
> + * check_vpod_info() would pass and amdgpu_ualink_metadata_init() programs the
> + * importer's ring buffers / GART NPA mappings / MP nHT receive metadata.
> + */
> +static void amdgpu_ualink_loopback_populate_info(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ualink_info *info = adev->ualink.info;
> +	u32 exporter = adev->ualink.loopback.exporter_accel_id; /* 1 */
> +	u32 importer = adev->ualink.loopback.importer_accel_id; /* 0 */
> +
> +	/* Physical pod: this GPU is presented as the exporter accel ID in its
> +	 * own pod. ppod.size must be large enough to contain both the exporter
> +	 * and importer accel IDs. ppod.id must be unique within the system
> +	 * (matters for 1P4G, where every loopback GPU is its own physical pod).
> +	 */
> +	info->ppod.accel_id = exporter;
> +	info->ppod.size = max(exporter, importer) + 1;	/* == 2 */
> +	uuid_gen(&info->ppod.id);
> +
> +	/* Virtual pod: mark BOTH the exporter and the importer active so the
> +	 * per-peer setup (amdgpu_ualink_metadata_init()) programs the importer's
> +	 * resources for the importer accel ID. Preserve the address mode queried
> +	 * from firmware if it is valid (keeps source-identification HW working),
> +	 * otherwise default to source-aliasing (MI450).
> +	 */
> +	info->vpod.id = 0;
> +	info->vpod.size = 2;
> +	if (info->vpod.addr_mode >= AMDGPU_UALINK_ADDR_MODE_MAX)
> +		info->vpod.addr_mode = AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS;
> +	bitmap_zero(info->vpod.active_accel_bits, AMDGPU_UALINK_ACCEL_MAX);
> +	set_bit(exporter, info->vpod.active_accel_bits);
> +	set_bit(importer, info->vpod.active_accel_bits);
> +
> +	/* Only the exporter (this GPU's own accel ID) is a local accelerator;
> +	 * the importer is reached through the (loopback) remote/NPA path.
> +	 */
> +	info->n_local_accels = 1;
> +	info->local_accels[0] = exporter;
> +
> +	/* Mark the pod vpod-configured so the activation path proceeds. */
> +	info->accel_state = AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED;
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_activate - bring up the UALink manager for loopback
> + *
> + * The normal activation is driven by the sysfs vpod_config/commit path via
> + * activate_local_vpod(), which derives the local accelerators from peer GPUs
> + * and runs a cross-GPU integrity check. Neither applies in loopback (the
> + * importer is not a separate GPU), so activate this device directly.
> + */
> +static int amdgpu_ualink_loopback_activate(struct amdgpu_device *adev)
> +{
> +	mutex_lock(&mgpu_info.mutex);
> +	activate_accelerator(adev);
> +	mutex_unlock(&mgpu_info.mutex);
> +
> +	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_ACTIVE) {
> +		dev_err(adev->dev, "UALink loopback activation did not reach ACTIVE\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_init - set up and activate UALink loopback mode
> + *
> + * Called once loopback mode has been detected, after the initial pod/vpod
> + * configuration has been queried into adev->ualink.info. Synthesizes the pod
> + * configuration (there is no user-space agent to write the UALink sysfs nodes
> + * in loopback), allocates the ordered workqueue used to emulate
> + * exporter->importer interrupts in SW and activates the device.
>    */
>   static int amdgpu_ualink_loopback_init(struct amdgpu_device *adev)
>   {
> +	amdgpu_ualink_loopback_populate_info(adev);
> +
>   	adev->ualink.loopback.wq =
>   		alloc_ordered_workqueue("amdgpu_ualink_loopback", 0);
>   	if (!adev->ualink.loopback.wq)
>   		return -ENOMEM;
>   
> -	return 0;
> +	dev_info(adev->dev,
> +		 "UALink loopback enabled (exporter accel %u, importer accel %u)\n",
> +		 adev->ualink.loopback.exporter_accel_id,
> +		 adev->ualink.loopback.importer_accel_id);
> +
> +	return amdgpu_ualink_loopback_activate(adev);
>   }
>   
>   static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
> @@ -495,10 +607,16 @@ int ualink_ip_late_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> +	amdgpu_ualink_loopback_detect(adev);
> +
>   	scoped_guard(mutex, &mgpu_info.mutex) {
>   		amdgpu_ualink_info_set_accel_state(adev, adev->ualink.info,
>   						   cfg_state);
> -		__amdgpu_ualink_activate_vpod_locked(adev);
> +		/* Loopback has no peer GPUs and no user-space vpod commit, so it
> +		 * cannot use the normal cross-GPU activation path.
> +		 */
> +		if (!adev->ualink.loopback.enabled)
> +			__amdgpu_ualink_activate_vpod_locked(adev);
>   	}
>   
>   	if (adev->ualink.loopback.enabled) {
