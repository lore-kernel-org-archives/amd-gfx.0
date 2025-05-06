Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D22C3ABBF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 09:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7582010E61F;
	Tue,  6 May 2025 09:20:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wxHWs5z7";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 006D610E29B
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 09:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7DVlatKYikJ+X3w1PTG2+fNnxJfROxwqsg5bJKog0m3xr+Yef2+MupdP6ztvvrk4LdiaqyNSsPx864ANojhQxs8LqM7y8P/9BBdZ/jcIl2CSdbS8KCaiPBm3aAZcwkDbMIjePRKwn/oPWoXjlY7WU7PnZH1iOA6wAr9PjjepHXLl4tNY2u/ct9dntjkfHD3q0xZJOOTvYB81EhjsnbIDJ+iMl9tYo7JaRP/W9jaYBdvWi76NVqfLsvoyQyaoe1EvWG9Y/5jw1W2/RKEs9+T9f7XsFHGEZVF/E2ZyZ96C9zXwdd09ho/tUUKnSZI5r2i9/jMD4wQKbMSwg8uFJVo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FARbED+sgRRc04BT4zI7C43+AIBtPOznXrgjl6jMO4=;
 b=s0hc8Tc1oGlKY62WbJC8gM3Mmr8xmukzl4E7R8ovtV4RsAU0ddHjXHI9ydPPDHl47v8xga848LIgq0pftH7ziMVyrTOtaEb6ZK0AbBGmy1JVOnlKjNMrkWwyfRoU1SadeMryF+NV0ItOc1blsvtpj5upUPZcsLl305xl+IVek2ZdaHbDWeSVxZvSTn0x6mTueP0u+auGZ4vMG+tX/2hDGjFJcDWbPG6Mnx+xaQwOab8GomRGNxgV92DLwQP2HlUu62hGgoOWDbssX0uJOq3s1XZVoL4puQH2HV4t+c8Th8Ed6yX8WOPSDMLz8CeUHgMt7vGiEV5UFT6OdakLxI2Cnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FARbED+sgRRc04BT4zI7C43+AIBtPOznXrgjl6jMO4=;
 b=wxHWs5z7chRZ/Xvpfjv8Sz3529hxgFkxNQEtmgCG9GFYGtaIuTYGJsnNlDwls7ByQzx3gYj8oKfdt+/GhfTqNrvVGSVzgrDv8o7eYpOPm2msAFR32bJ8bzf/ayE/WTXfvbpTQKRKAdFezTNGgl+06ERmzBDP01KFUawdMwi1bTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 09:20:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 6 May 2025
 09:20:35 +0000
Message-ID: <2102a6a3-5426-48ad-a128-9be7035a0b8c@amd.com>
Date: Tue, 6 May 2025 11:20:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] drm/amdgpu: add mes userq reset callback
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20250430154809.2665473-1-alexander.deucher@amd.com>
 <20250430154809.2665473-3-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250430154809.2665473-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: e14084f6-b3a7-47f4-ac45-08dd8c7f41e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjN0V0hLU29kS3Z6MFpVUXd0MVhIOVlhK1BCaFh0MTJVTUwyRDNYNXA4QjJp?=
 =?utf-8?B?YndHbnhBdDNqQS9aQy8yd1NHalVzZmRvQ0w2Zmk2YWhua3FOay9vVXJ6RjFz?=
 =?utf-8?B?MDZJVVpYengyeXhFNjdyYmxTbUhKcTBnRnptekhtRS9OaU4wVlBHVndocHFz?=
 =?utf-8?B?QjVIWVd0blY3QXd3VDkrR0pGaGtDV1VkVU1vMnI1OEhsZmJQZ3ZjZUdkQVJw?=
 =?utf-8?B?cG5EbGFTeFpFTWY4T1ZBdUtab1VTRlF2RFBOaWYxVm1ERlc1eGczcDhaY0ZO?=
 =?utf-8?B?clBWaGJHdm43ZzNBTUxhNlJ6cFBVTnNCV3VvS2hTRzBKYjYrM0RxNlU0OG5n?=
 =?utf-8?B?alpzaGJ4Y1dweHhzMFhDSk0yd042clFBRGxnRy9WdjFjSjVDK3k5UXEwbVZZ?=
 =?utf-8?B?TUFBMENieHVMcjRJbFg2eDdydE5hUTBQWEg4UExGMWtOMjFsbFo5N3A0WGho?=
 =?utf-8?B?R0Z3T2wxRWVvZzFvd2R0SkFqQ2ZWN3ZpaHZSczJySTcrR2JvMHJ3TnRTOUZ5?=
 =?utf-8?B?bDF0K3pmcy9pMVlhYWNaRnU2dys2cUExcURRKzhoUGJ0cW5lNjZKaFdvQlpx?=
 =?utf-8?B?R1d6czUvMHVBOWdoTzl1RDJ5ZnlET040STBsVkZEWkpiektpQ29FSGg3Zlow?=
 =?utf-8?B?QjRDVWFXUTVNWlNyVzdsNEFqd21lL1I1NndjdDhGUlQzMXk5TURrc2trbHFp?=
 =?utf-8?B?VUQ2dG5SVjdSZnoxRExTMVhxMjlVUmd4UHE1Q29ZdFBpdXFFMi9wQ050Z3Vr?=
 =?utf-8?B?OXcrcUY5enNaMkl5MEh6ZzRaUFdaQkxGeExNVFIyUTM1bjFpYXpPbHBTZW4y?=
 =?utf-8?B?bWoxRVV4Tm9TRk5JQXZpOGMyQTl2ODZFS1h0aTZOaTd0WTZncGU2d3dVekR6?=
 =?utf-8?B?dWJuTXBPNTgvYzd4K0ZGYllmU21mQkxFOUVSRS92a3NJYVh1cm53ZUtHWTU3?=
 =?utf-8?B?MXRvNmZ0QzkxT05rK2d2SU96RU5IbGtwNTlsRVk3SkREOTl0MnV3RlN5Mmxw?=
 =?utf-8?B?WW5wL20yWk5GOFJ2OVAzUnU4VHhRRVNuS0sycStwNDZWQStiZ1JlM2dYOVYx?=
 =?utf-8?B?blpyYy9FWHJCU2NkYVdSSnAvai9WMGd4ZGpXbFlrNHhkdVNpOTc5S09QMExN?=
 =?utf-8?B?Q2l0UGZMQjFRMUt0QWd6aXRacnk0ejZrdVBUUis5Zk5lQWJoaEdHTTJBczNL?=
 =?utf-8?B?Q0owOFNINGlJR2cvQnlyK1kzZFRUUHVXY3BRbWhzWVZwbHpDeit4RjR1UVV2?=
 =?utf-8?B?NDFndlhPakMyNTVncFFvZ0JESENkWHRGL0NVZGtwZlhsUGN1T1h6WHAxdS9H?=
 =?utf-8?B?TkxPZFRoY29ZTlczYmkyR2UzbjRyaitoVzFrdFl0RWd6SU1CSnRtcVBhVG5B?=
 =?utf-8?B?Z1NvY1pMREZ4L1dqZW44dVVCUGZ0Qk4wQjVxYmR1M3pWdi8vU0Z4T0pqUktj?=
 =?utf-8?B?c3BnMUs3OGdzUmRNcW5jM0RWK2UwVEc4aXJEWlk3ZXI5TWpHMHJCSzRKMkpY?=
 =?utf-8?B?anZLdWZ3ak9zbHRTa3NFRXZFTzhub25GQmRiWmRVSDJRSStDaVpsK1lqbGE0?=
 =?utf-8?B?MWk3Q29XZlVWSkhIQjBQcDZzL3BhVkF3eDI0bUdNd2NkTm9DUjh6dE8zZWR1?=
 =?utf-8?B?OXBSUU53d1NrMWhRcEpSR3F1L2NSTmlmeXovR3lDNUpyaGFjdTd3WXA2QlRZ?=
 =?utf-8?B?STVxeWZvdlAwVmFJVW55K2UydFNPRnpPRE1sSXpyR0pLNEpveWhKMkZIbk1B?=
 =?utf-8?B?YlJuc0JINHBndy9tVFRpQjVxdU0rY2dhWWhBdTdxNzJXNHQ5NGE2Q2xhNnJp?=
 =?utf-8?B?bkYzWFNYTnQ4dW15bHpab1p2dmdBYmtZdWNVem5INFpsQit6YUVCSlpNajJG?=
 =?utf-8?B?eXRxSkVCenVxNCtKVTloWmFPeDZoKzRSc1VUNytldjg0enZhVGpTZjRDajRN?=
 =?utf-8?Q?TNFed02vA88=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWlYc1hvUmZwRnBsOGE5bHhrWUVGTUR5ZWVMbGs5eW03dk1POXkvT3BxZEdx?=
 =?utf-8?B?ZXpjUCsvdVZTMjB6VXREeldPcW90Qi9heGsrVk1UK3BsYkxCQkRhM2EwQTg2?=
 =?utf-8?B?Q2w4dyt5SVp1aDFoMWh0S2crR3pXcHBmQXdJQTNOWGJpeUlSWW15cGpRVUE4?=
 =?utf-8?B?K0NQVzBZeFdzdlg5YmIyL1BtTGgyZk5kQ2pSMkNtVkdNcmVKYWFXWGdWcjJr?=
 =?utf-8?B?RDI4RStiQjhMVVc5Q0ROVm5DWGZEbFpFTk4xeGZmblFjZ0pjM0VRa1p3SW84?=
 =?utf-8?B?QldwSjlVcUQwS2ZCSFJjL3lXRk11QWtrNXJxMzZOYjRISW83L1RzRUQzNmRk?=
 =?utf-8?B?SEFJOElORXpIUzJQWHBtRnhxRFFjV1V4MlQ1TXUyckl5VnBxajJzcTR6a0Y5?=
 =?utf-8?B?bXN1Wmx0anlmKy9IWHdSdlFvZ3hRaldlam54QlkwOWlXUm5rZG5JUmFlblN4?=
 =?utf-8?B?bUVLRDlyYzRtVHNkT2hCbFIxbmJxSkRWd3I4M0lxWjJhMnhQTm00QlZ2NHVi?=
 =?utf-8?B?alJWMFZFNlc2UzZLTWZoZndOUnEwekZXQVpLaThkQi81R3FOTGVLMExVWE1W?=
 =?utf-8?B?MWxWenNKeTBkWFczWDcxWUYvYjRZQXQ3KzQ4LzBTQXMwaDVJR1hVWnpyczZL?=
 =?utf-8?B?ZjVMaURVRzg0TnBWMnRIRTNobXJIWW13TkdPTHRkRVFwNTRjeFR3cWgyeGpZ?=
 =?utf-8?B?UGRxbHlGNlc1S05wWVozOElKcmIwNTFjTis5QzlYS3FOOTFQVGtOQ3hzdGJY?=
 =?utf-8?B?MEZrMWFzbld4TFVCWWt0N0FhUWVnRzBDM0tqVUN3SGRhNjFSUFJUMHVub2FW?=
 =?utf-8?B?MVZKdjBEckw0eXhsWVl1U2VEMVdUbnVPR0l3aUZZVFdtanprZ2ZERWRCMGtT?=
 =?utf-8?B?QkZYdjVvUW1rdWUyN2NHcE1Nd2pITkhSNHdwWFRMMlNwY3NDNERYT0ZoYWdu?=
 =?utf-8?B?bWdXQmY2a0FKLzBKUlNva293bjdjK1BSd2pjcmR2YlBrUFZRNlp5V2dmRDNt?=
 =?utf-8?B?Tm92cVA2dm1BOFVBalk3b3pZaHFFL2FlR2Q1TFNoYWY3Z2FReXA1c2xWeVR2?=
 =?utf-8?B?MlN0SU9Cc0VqT1hnZjhqOEphU3l5MDFpVy9UY1ZabnIzd2FDN3BMS1pWQXZq?=
 =?utf-8?B?MVFqUG5nU2R4a2ZxMzd4UVhOUzVybWRvMTZOZEVXSWh5VXoyeE50eG5JdEN2?=
 =?utf-8?B?ZVhLLzduZWZKNW5PSVEyVmJ1SGNtcHpIT2wvZTErTjBCaDI2NWt6UVNjWExy?=
 =?utf-8?B?VklPdWlwY1ZaK05PYTRlQ3oxdFBkRXpISm4zMlpLODBJYVFtY0Z1dW5WaVls?=
 =?utf-8?B?ZStxamNLNDRpbGFrZEQ4aUpKT2RQQ3A1YW1DSmtBS2EzejdKcWdMMjNnSVU0?=
 =?utf-8?B?QWpPSjhJeWZiQTRiT1ZuU2gwZ3Y1RnBTUTZKd2RiRSt4VTlYZUFUTndqMVlT?=
 =?utf-8?B?cjBXdURzOHdGZm1DSTlxNkFwZVMweFQ4dCtBUGVEZ1BrYmdRMHNhSnBCWnR5?=
 =?utf-8?B?SVpJTEd6dEhaK1BCR016akluRjMrTnNHVzJ6TjNEclU1RDhsWThmWC9IUXl1?=
 =?utf-8?B?YmJrb3YwOEQrV2tjTG05WHo2U2dWR0Q2MVJoL2hlRVdpTU9JWUo0d2xjalFM?=
 =?utf-8?B?WnNhejBqY0k3KzRCRGJNR1NrVDBxYVphNisrWEFqV1h1QjlRTzgzRVFBbHBQ?=
 =?utf-8?B?R3ErVlk4NURZK3lrcTVvaGRROTBIU2pUdVVxY056ZkpjNHprNGNvNVFNWFBk?=
 =?utf-8?B?VERCYU1lSmFRNU52TWRUbGZZYjl6dU54T2JTUzNSbHVIbEZ2ZFdDQWxXUkdz?=
 =?utf-8?B?VzUzcDZ0elhRWVM2VU5TMGZuYjRteTdHM3IvZjhuSXloeUFVODhEWDlxRDZ2?=
 =?utf-8?B?VURRWGVjQjRSZmRTbUkzTFNsSHJrc09EdjJyM2oxYm9IeUNFSXBSUENMbkZK?=
 =?utf-8?B?elVxTStvYS9IanQvQmxyTktkN0lzVGhSL2g0aERTMWtWYWlnNEw2aFhwYVJM?=
 =?utf-8?B?djZoNU1QNkZZSlEva3RLWXY2NTFPWDN1eXFMUzIvUmp2YWJiOE42ZG1XMlYx?=
 =?utf-8?B?ME8ycGpUSFoxbVkwOU5lOWJFZmwyYjU0aFdyckxWMW9GeWdkQ2xScSt3dlp2?=
 =?utf-8?Q?KR5JX9/slc6wNtCNvCkmZJr97?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14084f6-b3a7-47f4-ac45-08dd8c7f41e8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:20:35.6098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hm7K+jyGlf7RSDLLlDVgFylDpE4JWQbosDFs5UJWuDSO98sOu+tFaQxkGla3Nc6z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278
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

On 4/30/25 17:48, Alex Deucher wrote:
> Used to reset a hung queue.
> 
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index d6f50b13e2ba0..650fdb68db127 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -347,9 +347,30 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>  	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>  }
>  
> +static int mes_userq_reset(struct amdgpu_userq_mgr *uq_mgr,
> +			   struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct mes_reset_queue_input queue_input;
> +	int r;
> +
> +	memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
> +
> +	queue_input.doorbell_offset = queue->doorbell_index;
> +	queue_input.queue_type = queue->queue_type;
> +
> +	amdgpu_mes_lock(&adev->mes);
> +	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
> +	amdgpu_mes_unlock(&adev->mes);
> +	if (r)
> +		dev_err(adev->dev, "Failed to reset queue, err (%d)\n", r);
> +	return r;
> +}
> +
>  const struct amdgpu_userq_funcs userq_mes_funcs = {
>  	.mqd_create = mes_userq_mqd_create,
>  	.mqd_destroy = mes_userq_mqd_destroy,
>  	.unmap = mes_userq_unmap,
>  	.map = mes_userq_map,
> +	.reset = mes_userq_reset,
>  };

