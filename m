Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC40EC6FD35
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Aug 2024 08:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64FED10E610;
	Thu, 29 Aug 2024 08:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5VnNXG52";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C9010E610
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Aug 2024 08:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mV1xiVqLTbft24YviOnRg/vGZ5tyxwo0LhzavajdrvKmdwepArIf66f+y6aM58/hSKyPNPbBd0BfxLAcouusrGJME90E0thasvsxhWgNcE4L8LuV1+a6+VosStBxqYOvid9EIarGjSKMmBsFotqwiUwNZZbxNzD3FQANFB9BS/emotu4GWUiM0+f3xYtwvC/UEyMHJkSO7mNkuDv2EUeS2aTxLWsZ7eqjSIciR0YG5dNWYIm25+fnow16r1dsyI4XGm/clWc3zLyj7+2yR33neJ8InrME2mLUWuP9jDabRCfSnZc3c5i9bdOVpT6NcNAwXFrdgQobPp8juH1WrGBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STB4fO83Us+4EdlKKnFdEmucAUjoXhGhPBAf1Anbnnw=;
 b=MZT8LirY0cpXHdSTzHh81Ughkntwrq8SiPIVjKtQwa01qBwPweUZc8jLVRffw7JXFqXoox6iwhPeR+SP43G/X84xqhQH7DqivCiMZM9J4TOMqe8CyRGsgdF+YoagKWLgfvd4IWxBujobvJOjr58ns76txmCgMmw/Re1gJxbMm/XEh5nabB1w6DIMRKlXe+Fl+Y1xlFpCAyXeL1YHAReJ3JSRM3tpuc1NojsK8ypK4gjsYI41IloSPA4stCHvqw/T/YlL8AQS1CYEYJj5OMNUkuTc4dFAL3GRQp9iOpjC7jNiIU6arjkU2K1CdjnQ/eAH8jrdahex3v05a58BA3qqOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STB4fO83Us+4EdlKKnFdEmucAUjoXhGhPBAf1Anbnnw=;
 b=5VnNXG522JNK7tjqGKd1WUkCP+zPH0KKS1uOvk7ZiFa6ZgzUI/VP6rwk2afrptuwWbB39wS4d+eqaDjCR5KpWhwUIOW063dRDS0cId5FtGkAdgO2d7z2szcJFyzxxC4zmmKpUg8eWQ5NKkvjfEcJUAV5y6iPYuRXP/AB2OY0A54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.28; Thu, 29 Aug 2024 08:12:40 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 08:12:40 +0000
Message-ID: <8de31021-f391-4003-8b9f-46ad16ff33a1@amd.com>
Date: Thu, 29 Aug 2024 13:42:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com
References: <20240829034712.2896869-1-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240829034712.2896869-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: bb410138-587a-4631-8299-08dcc8025971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnZRWFgzRkFoaTV2WDNrVkRndU93SkFUbU4weGphSlVxdkRnRjJUY2EvVWZS?=
 =?utf-8?B?NmFmVVB5ZmRlWElyNVNmZkJGeWlNMnFZaU56QnovNWtlbzU1aEg0Q1IxbHF2?=
 =?utf-8?B?NFhUNzRheThWd0VSR1hjaDdMNjhVYXJTVjIvWS84a3l1eVdJOGpsU0VvQWJH?=
 =?utf-8?B?RG5oUTI4TzlZYyt4RTN1bTN5WXJuRjdIQTU1NGQ4V1RXNnNNdnRFSWVDbUMx?=
 =?utf-8?B?RUNmbWx6Yk80ZHR4VHkrZWp1Y3lGdlhQQ285VmFHdWZIdnBwMS9JZlNIaTkz?=
 =?utf-8?B?eWg2Q1Q5VlgrdU01c0k4Z2FiMzUvM3QwWG1WQ2lUcXk2MW1ndGs1b1hzL2Ry?=
 =?utf-8?B?OWswOFRBc2tCOTJrOEYwRnZwM2ZuMjlvL3JRYnpuUUNOM3B0Syt4Q1U4ZURu?=
 =?utf-8?B?cEZudnNidE1SSjNwSVVycmlVVjZtRndMb1ZtbUpHa09EVjJUblZNL2hOdEhs?=
 =?utf-8?B?THh0c0RLYzMvZ0VvM3dPK1RtYW90d1JrRHRIZnBkTWcrbFIzanBHbXkrZFVJ?=
 =?utf-8?B?Z0ViL2hkWUYzQWtSc3E5bFNGS2dvY3BuWDZFNjFEZ0ZPcEtERW5FckloTkFP?=
 =?utf-8?B?aEkyUlNjN1lMQWRWVGsvQ2JsbU1uQWxSbDErTkNkZnpmSzJCK2s4MHBSZUpQ?=
 =?utf-8?B?S05BZVkrQUFHcEZPSnFpc0xqYW9LbjVwUW1iSmdrZWRuczYvb3B0ek00ZGZ3?=
 =?utf-8?B?VnJkOEEwWGVVakxXR3NGbVdFWXJGSGZNUWJXazVnMnl2MXI0MHgzL0w3eWtI?=
 =?utf-8?B?R21pZkRnaEQzQkxIVzJEOXZuRjZtNVpHejJabVdyeFJsWHM0MjV6cStycmdY?=
 =?utf-8?B?M0RJZDVHOFlBSytJd3JUTU5JNHF0aXhnL0Q4dlhnSC9uTW9kR24vUUlYcWQx?=
 =?utf-8?B?ejlqSWd6a0RFUG0vVjZzRk5IQW9WYkJteW9LVFU2T0VrZGc4V0diNnVtc1JK?=
 =?utf-8?B?MHZsYVRzamgxanljMUl0L1M4UjF2VVVsbzREV2FzY1hHaUozVGltYmxzWlpx?=
 =?utf-8?B?WVBPclV2ajlNR3YrUC9IcTR5VnUrTzh5MStvNy83d1pFL1lpdG1tRVhyTFBp?=
 =?utf-8?B?bklvZWZPR095cm52SlY4S05IbGtKaUtLb1MySTJBQ2JkZWJZdUl2ekQ3YkxY?=
 =?utf-8?B?TXVuL0FCeDVGaFk4di9ZZ1BSOE45RnpKMlk1T21CcjdWSThSMDl3K1JoM2xD?=
 =?utf-8?B?OThLS1NIRWFTdlFlVmJ4SlZYUzAzSVBZQXpkeFZpeVNKNWJxUU1jNlBaVTZt?=
 =?utf-8?B?T1pqa0ZPcUpERWhjbWVFZ1Z3R1VmWnpITWk0M3ptRUZ3Q1JrcksxNVhvYmpR?=
 =?utf-8?B?MkpwaVp0Wml2U1huWlZYeXlRQnZhWmNZSnluMnd6Q1l3UW1sajZNaitJV1Bq?=
 =?utf-8?B?aitIRUsreE56akpHM2t5NkpXZHEvVWV1YlFhc2pKaFd6Mk9Rb1QxWlIxYmt3?=
 =?utf-8?B?RDAxd3ZNaXgyclF0dXBYaG81OUNxdk1kZXllSG9vdW5GdVZ0SVVsa09hVDdK?=
 =?utf-8?B?SDB1VVVJd2NWSk5MTEZkZUcyTFNlRXdGMkhmdm1BTjQyQjNyVTg3dTIrL2dC?=
 =?utf-8?B?R2N6SE5oLysvajBENFBFQjlXK0JXL2dQMURIWnRUa292Q0k5ZHhkR0pSbWFm?=
 =?utf-8?B?OXlCZFRQd1pWUjNvbWxUazEwbE05Q1RsWU5EdHV4UkxYRHFVeUhkT1FpZFM4?=
 =?utf-8?B?dDlBajB5emlDbFRrMWFJdEhlWXQ2eE90dGhxS3JSVk4yUG1URDNYZEgybkI1?=
 =?utf-8?B?SWpqWDB3a1BFSThVQi9Ja0pmdXRYWUU3ZlNLTm53YTZqZmNES21uRE1SY1ZN?=
 =?utf-8?B?WGNYRGNyVFlycU5palhqUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czBLS3dkaXFyNFFaS1BlcUVFSjlXQitwV3d0ZHF1dFVSMzJ4Wk43NlNsWngx?=
 =?utf-8?B?NlF1Q0xRRDRMYkd0SmowMnc0NDBHYm1tSkdNQk9kOE1kdDVGSzNiMzZNYkRa?=
 =?utf-8?B?OVpzKysyTnZZSGFpZWlFQUoxR2ZmTkNZa0VNRU03TlBabHIra3RWaVNFVlZ1?=
 =?utf-8?B?b0p4WVI4U1FRKzc3RGVtMXhGY1luZGFVREhJUjR1dkFEUE43M3A5Ym5CYWJs?=
 =?utf-8?B?aWZoL1krTlJBcnhpS2VMZ01YTDZHcHNCaWJlb1Y4ZWYrTEZaQ1J2Uk5UbGUr?=
 =?utf-8?B?SWpPQ2o4enJja2w2Y2RWYkYzUitDQkpweHgwS01vOTlYVVI3bzA3cHZZNkFH?=
 =?utf-8?B?RnNFaDZXZnNHNHNJdUtwenBsQ3Zqd3JPQktYdlZwamJBZnc0bnAvaDJBb1BT?=
 =?utf-8?B?Z1RncjJRcmFpWlI3VGxoUHFLeXE0eTg2bjUxcWxXYnJJUFJvWDMweWpuTDRj?=
 =?utf-8?B?dXdlZ3c4MFVUZHZ0TlhDTnpKODBPREhxYXpuVHFNbjY2anB6ZERVdk1rY3JS?=
 =?utf-8?B?YkF1emx4c3NxbEZEbmVUSi9WNFF1MjcyekxFUjYxb3k2cURwV09NOGQzR3VB?=
 =?utf-8?B?TDNQNDJPbkRaZzdFbmVOeWVueitqb0RqbmJyemwvUU01bC9VbEI2cUNKMity?=
 =?utf-8?B?bml6UGwyKzkwRmJmUEpFZ09kU3pVYkQwVEpMZ2JNVXRidmNhUUliei90RjhH?=
 =?utf-8?B?cXVheFB4a1B4WTdPbjAvVmtxV0NyL3lSV2ZxeVVRZ2xpQ0szb1RqRmJ1dC9G?=
 =?utf-8?B?VHV3U0krVlBOVWQyR0phb05Za1owOSsyVVNVVy9CMWdkZC94SjRkMnBzeGVm?=
 =?utf-8?B?NzVxUGRsUS9OV3VUM1IzbktRam9LQ3V4bmd5aWN5cjVPcVoxQXI0dDF4dVcw?=
 =?utf-8?B?SFozbHl1RHJBUGVnYnkrR1FuYTBCazBPMDRSRXB4WVNHeWFYL2hvenA3TmRj?=
 =?utf-8?B?UGwzSUR0WmVtSWZBT0NscGZVWU9pTUV2YzRQaFRodm4xaDlRa2xROEdFZW9L?=
 =?utf-8?B?R0VZRFVSR25xd1U2b2VnNGVKbjIwRjJNbWNkamMreTJlZzEwNlBRSTgwMWhu?=
 =?utf-8?B?SjBnM1JyVnc1L21DSS9EOFBqZUxxMFZ1RjBEdnRSL1lOTytCQVNsc2E4b3JJ?=
 =?utf-8?B?U1lRb2JSTWZnRHpkTlN0ZExjbUNTQXVXT0ppMGljbC9aZmEvODF1enVGUEZr?=
 =?utf-8?B?RmlqdUJmRjJGMys4dDFMd2V0d0JRZDhxZlFGMFJTT2FSQkJzLys2YnJOZ0tq?=
 =?utf-8?B?OFNmK25lRjZneXNkdEwyMEd2cTg3UEFleFhjWkxtWk03eFhJNzJpR1FXN2xy?=
 =?utf-8?B?TkJUVjg1VUNadUtUblc4a0xCVmNvcFE4clpQL2pGdE9QaUVBMWVMYjBaZ0x5?=
 =?utf-8?B?MU1sRFZ1TWZrSk5OYXNxcnY2OEs2SEhwNFhzaEN1MngyMCtsT0drUUc5TUFL?=
 =?utf-8?B?dWk3TExkVU1ya3pKWmFjdWJNUDV3aUc1K2tnR1MzSVRwRUJzNDhQUzFtMnNs?=
 =?utf-8?B?UEdHM2pySjdCV1E4MVlPZVRkeElyR1R1RjIybWJGTjRoNGVoWHFrYUZLS2dI?=
 =?utf-8?B?bGthZGVSN3pseG9FRk5MZy83bnR4QmxYK3FQejlEaU5LQlU4Vm9VU2tjNWZD?=
 =?utf-8?B?TFdLSjJVTjBjbFJrWGZCZ3RMNWEwNUdXR1IyblIwRFd2WE9mZWZ0ZWJhTlg1?=
 =?utf-8?B?WE4rWEU1c1ozWkM2ZnNxdGV4dUJMTHVWWjZBYTNhQ1V0cnQyUFQrenVSV3FY?=
 =?utf-8?B?cDFrQVRvTGtwSzJBcThLODhoRGxMaTRQUXBBbWVEdmk5RnRXNEs2cmZhUDRm?=
 =?utf-8?B?eDZyK2I2ak5Za2FFMGhaSkU2VURsZ3ZyUGNlMmdlRFIwQ2FFcnQ5cUlmZzIy?=
 =?utf-8?B?TFVDZC9ZTTRoMFJlRmJLMDQ5UjJ3MEJlSTdwSE05K2MyZXIwdkVDUGdjQk5i?=
 =?utf-8?B?eXlCckJTRTJVMm9RMG1FMENoclRodEhGSkUzeEhsSmNVVFVSSGZFczdicVFr?=
 =?utf-8?B?RzNQRUpjUTAxOHNHL1RyMlhCbjZYVDlBdHArR015Z2YwSWJCdlJ3WmNxWVly?=
 =?utf-8?B?eHh3OXJuYytiMkJQMGpKdlI4TkpGNHpHdDloSFMzRm10TDVoQkVCcFdROVEr?=
 =?utf-8?Q?w7OPpdmyGjJIlm9pttWrryxIy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb410138-587a-4631-8299-08dcc8025971
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 08:12:39.9755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfBzQI2DXJJ1woCy2sXdg7t/NGyDvpxxoGLTfSD7O2VvqADxXy6Ot3yAsKWVZQLP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742
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



On 8/29/2024 9:17 AM, Prike Liang wrote:
> Implement the compute pipe reset, and the driver will
> fallback to pipe reset when queue reset fails.
> The pipe reset only deactivates the queue which is
> scheduled in the pipe, and meanwhile the MEC engine
> will be reset to the firmware _start pointer. So,

May refine this to indicate that reset to _start is for the specific
pipe and not applicable for the whole MEC engine.

> it seems pipe reset will cost more cycles than the
> queue reset; therefore, the driver tries to recover
> by doing queue reset first.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 127 ++++++++++++++++++++----
>  1 file changed, 108 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 2067f26d3a9d..26ae62d2a752 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -3466,6 +3466,98 @@ static void gfx_v9_4_3_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
>  	}
>  }
>  
> +static int gfx_v9_4_3_unmap_done(struct amdgpu_device *adev, uint32_t me,
> +				uint32_t pipe, uint32_t queue,
> +				uint32_t xcc_id)
> +{
> +	int i, r;
> +	/* make sure dequeue is complete*/
> +	gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
> +	mutex_lock(&adev->srbm_mutex);
> +	soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id));
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1))
> +			break;
> +		udelay(1);
> +	}
> +	if (i >= adev->usec_timeout)
> +		r = -ETIMEDOUT;
> +	else
> +		r = 0;
> +	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
> +	mutex_unlock(&adev->srbm_mutex);
> +	gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
> +
> +	return r;
> +
> +}
> +
> +static bool gfx_v9_4_3_pipe_reset_support(struct amdgpu_device *adev)
> +{
> +	/*TODO: Need check gfx9.4.4 mec fw whether supports pipe reset as well.*/
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
> +			adev->gfx.mec_fw_version >= 0x0000009b)
> +		return true;
> +	else
> +		dev_warn_once(adev->dev, "Please use the latest MEC version to see whether support pipe reset\n");
> +
> +	return false;
> +}
> +
> +static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *ring)

Please drop the kiq name in this function to avoid confusion. It's not
restricted to kiq.

With those

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	uint32_t reset_pipe, clean_pipe;
> +	int r;
> +
> +	if (!gfx_v9_4_3_pipe_reset_support(adev))
> +		return -EINVAL;
> +
> +	gfx_v9_4_3_xcc_set_safe_mode(adev, ring->xcc_id);
> +	mutex_lock(&adev->srbm_mutex);
> +
> +	reset_pipe = RREG32_SOC15(GC, GET_INST(GC, ring->xcc_id), regCP_MEC_CNTL);
> +	clean_pipe = reset_pipe;
> +
> +	if (ring->me == 1) {
> +		switch (ring->pipe) {
> +		case 0:
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE0_RESET, 1);
> +			break;
> +		case 1:
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE1_RESET, 1);
> +			break;
> +		case 2:
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE2_RESET, 1);
> +			break;
> +		case 3:
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE3_RESET, 1);
> +			break;
> +		default:
> +			break;
> +		}
> +	} else {
> +		if (ring->pipe)
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME2_PIPE1_RESET, 1);
> +		else
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME2_PIPE0_RESET, 1);
> +	}
> +
> +	WREG32_SOC15(GC, GET_INST(GC, ring->xcc_id), regCP_MEC_CNTL, reset_pipe);
> +	WREG32_SOC15(GC, GET_INST(GC, ring->xcc_id), regCP_MEC_CNTL, clean_pipe);
> +	mutex_unlock(&adev->srbm_mutex);
> +	gfx_v9_4_3_xcc_unset_safe_mode(adev, ring->xcc_id);
> +
> +	r = gfx_v9_4_3_unmap_done(adev, ring->me, ring->pipe, ring->queue, ring->xcc_id);
> +	return r;
> +}
> +
>  static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>  				unsigned int vmid)
>  {
> @@ -3473,7 +3565,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
>  	struct amdgpu_ring *kiq_ring = &kiq->ring;
>  	unsigned long flags;
> -	int r, i;
> +	int r;
>  
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
> @@ -3495,26 +3587,23 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>  	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>  
>  	r = amdgpu_ring_test_ring(kiq_ring);
> +	if (r) {
> +		dev_err(adev->dev, "kiq ring test failed after ring: %s queue reset\n",
> +				ring->name);
> +		goto pipe_reset;
> +	}
> +
> +	r = gfx_v9_4_3_unmap_done(adev, ring->me, ring->pipe, ring->queue, ring->xcc_id);
>  	if (r)
> -		return r;
> +		dev_err(adev->dev, "fail to wait on hqd deactive and will try pipe reset\n");
>  
> -	/* make sure dequeue is complete*/
> -	amdgpu_gfx_rlc_enter_safe_mode(adev, ring->xcc_id);
> -	mutex_lock(&adev->srbm_mutex);
> -	soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, ring->xcc_id));
> -	for (i = 0; i < adev->usec_timeout; i++) {
> -		if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
> -			break;
> -		udelay(1);
> -	}
> -	if (i >= adev->usec_timeout)
> -		r = -ETIMEDOUT;
> -	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, ring->xcc_id));
> -	mutex_unlock(&adev->srbm_mutex);
> -	amdgpu_gfx_rlc_exit_safe_mode(adev, ring->xcc_id);
> -	if (r) {
> -		dev_err(adev->dev, "fail to wait on hqd deactive\n");
> -		return r;
> +pipe_reset:
> +	if(r) {
> +		r = gfx_v9_4_3_kiq_reset_hw_pipe(ring);
> +		dev_info(adev->dev, "ring: %s pipe reset :%s\n", ring->name,
> +				r ? "failed" : "successfully");
> +		if (r)
> +			return r;
>  	}
>  
>  	r = amdgpu_bo_reserve(ring->mqd_obj, false);
