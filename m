Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EB1E77197
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 03:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 490B689496;
	Mon,  6 Jan 2025 03:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="po5H/C2L";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA58F89496
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 03:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAtYOxepv1IK5pxVg2WIrAC/Woew3yID0XC01/cNsc3XVszuGa2gRMN8T9/0OUBSjOU3gpvVjMureTOo1XZ4qhUMUqZow0Nm/AeOTJF1zicQdm2lRIREncdTKGOlmLnamYiBneCYG2kwPnVzpB6797ljdoNTDs0XCeMwc8nEZ83/scwZj+GVqwZIIQW/sNeauc2YpEpuk2SxD5Uvjdiw4WnrRHmeIqPCSEKMItRz41TcZSg3GwqusbTB7QmaN62g4pswOA3m0IMCWNIGd+XiSScHGF+RQlGvNyTljQ7lVPd2Ky0njSHP0C2bT5zeQeJttCqYvMXp5TnTHAihlfC/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8dhXFSuC98hBlPifAlchvqqG+8jcYxh/Ab+zJB8Gs4=;
 b=DVtlfV542u+xm7U0rcU+wJtIPSbDYS9MeXnTQVIK3m/fi1kLqc85R61IXAndPeLK00qXCXp8nBibI6iQ2YqxAhuRqKVlOR46yfeXJb0d7Uuoq4g52y9ZluUnw51MCQR2GHX7sK/K28REMl+y+2zMUzg9s15/bQTYpFSQ6HWi+WZ6NDgkXS9gkvhdPfSCHY0riCYl6d8tRdumB+SAgz0RYdRpQlSfMJM428/vFi6ihR2r7bibJdz6YsXJp5fJKVhVOUHY/WHBX13YnWXOjwd4k/vd3uldy3IagEfrKJO3oF4T4TzQfYEwfJJr2uZ7iyaRe3bjRRXKEozOTcRFhBAarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8dhXFSuC98hBlPifAlchvqqG+8jcYxh/Ab+zJB8Gs4=;
 b=po5H/C2LztzHHLwH0UBYK07gWFnxDIeksoNYvy/VMsJfoffvuL+60REMpaoJtuurxyMM86rkszBRFinsCyGaW9Y4UtxJo+L6V+j0U/VgU62M5CIwqNufT/L734quSQ0owTTj+ghzl0I5DCLcOuc3vLqAU8X1te6mf9vSLyEs2tw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 03:03:37 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%5]) with mapi id 15.20.8293.000; Mon, 6 Jan 2025
 03:03:36 +0000
Message-ID: <dbef9084-4939-4400-82b2-529d12718703@amd.com>
Date: Sun, 5 Jan 2025 21:03:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: add CEC notifier to amdgpu driver
To: Kun Liu <Kun.Liu2@amd.com>, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com, aurabindo.pillai@amd.com
Cc: Alexander.Deucher@amd.com, richardqi.liang@amd.com
References: <20241230081501.93823-1-Kun.Liu2@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241230081501.93823-1-Kun.Liu2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::19) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e572d06-434c-46ad-49bf-08dd2dfeb62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVl1dk5TNVdIcHhaRzFxTVoxUS9RMjRTeW5MbTdBZmtBMGpwTmRpbXArQTZs?=
 =?utf-8?B?MEFGNUZDOTBGZFBrSUU4RGdIR05yWkUxQVQrdElKYmdnZUM1dmVSVnpzdmpZ?=
 =?utf-8?B?OTRwejhuc0xTREFwdVBlSUpXUEpwY09WdmhEb0VQVjV5Y3UrRzZvSncyS1k0?=
 =?utf-8?B?WWtoZnFYNEE2YjlFd2Q5VEdBbWY0NVdNc2dUc1BOcXgrcTVaUXRPSnF3a3do?=
 =?utf-8?B?UHlQd2g4aDVzaG1wc2I5QVpsY25SeWhoQ1Q1c1RrdTBMY3JNWVRtWTdUeDI0?=
 =?utf-8?B?MzhrVS9XT2tOWSsxa1NvZmJTM2ZWU0M0dEZSSmhTd0VQR1JHWkNvSWJCcnor?=
 =?utf-8?B?OWxPMjhyQW9VZ25iUFgvSTNCcjRWN0VvQVdrM3pHK1lMVVVDNjNtNUdOWXNo?=
 =?utf-8?B?YjVHNFAvditEQUl6QmRDdVJsMXcwZTkxWkVseDNDaFlFVFRMbmNQZ3NlK1U5?=
 =?utf-8?B?bFRkQ1RYMEZveUdZREExV3hEZE1zMFV2elQ5dTAvQzFaQUFBemRYVlR0eFVy?=
 =?utf-8?B?Q2tTTzB5Z2h2RmczVHIrYnB0RnI0bEZKYkFaK2NVM3hybUNpa0o3WHJMaDhL?=
 =?utf-8?B?MERld3ZOdkROQVVQenBiY3RqTDh3c0tNb1I5ZU85c1JCbGwxUVJMQmJEU0FS?=
 =?utf-8?B?OTNzYnlxVjdNQ0QvVWZMWWY3VVJIeG0xdWhFbkY2b3JoRGswSThlVkM3czA2?=
 =?utf-8?B?ektIVHNXL0MxYnErUmFJTzN6SG1KNXFWZUlya0hwdGdXRDhvT2UxbkMwRWdu?=
 =?utf-8?B?Nm5xbXdqeHZjajhmSDg4Q1k3QXowalh4dVQwdDZTTSs2alJFM08ydC9jRm8z?=
 =?utf-8?B?YlJrbWQ5VFdnT2dMRklzMUhuazl1cktOQm0zbURwc1dZZ1dKdk9Wd0ErOUR6?=
 =?utf-8?B?MmlJVTQyVW02TFRKaVB1RWgvOWt5V1hyL2VUTElwcWcrVnJhQ1I1SzFQTVV6?=
 =?utf-8?B?cUprOEM2R2JrSGNBaElIRnVmckpRTHlTSDFmZzhLQWowdGNqTVNqa2FPVjYy?=
 =?utf-8?B?YVBGZFp1ekQvVVlTZk50bERZbzRsT3paS0xNWFdrWGhhOWV6ajcraXZpbDht?=
 =?utf-8?B?UmY4bXZ1b0x1MHBZUnMxYXdZRGU5WDFlK3NlV0VGM2RZT1VKRVkrQ3lSVzY3?=
 =?utf-8?B?ZnpjQmI2WTNnSlNhbTU0UisyQU9objN1LzVPR2s5NHk0ZkQ4azlhTmkxa1pu?=
 =?utf-8?B?MnRnWFVEZnFIaDI4TlI2RDVHT2h2OEFBTnQrY1VMbklyb0M4aGFoL0FFczZv?=
 =?utf-8?B?YnV3Z2Faam9jYllNZWNPU2lGSHlpRm1LSFdVQ0I1aFZMR2NQZWIzbFUxSWxR?=
 =?utf-8?B?Mk5XTkNTbTFOZGoxVnNQVmJCU0pRd1ZJeFNhTXlMRnBBSE5vc1JVaUZJY0V1?=
 =?utf-8?B?TU1rcEN1WGRZQyt5SlUzNkFyNmJoTEtpOVZPc3JjV1ZMT1pqVWJXVEl5bVFm?=
 =?utf-8?B?cW5XdVpmTjNhSTRJWjk3dDd4LzAzTUNpZjJYU2RKK3liT1kxMVJSS0dqQ1lS?=
 =?utf-8?B?WS9ZeUtyTHorU2V6SHY1VjJqR2F3eGpseUVFS0hsanZ2MmxVTXJheSsyQzEw?=
 =?utf-8?B?RmtVaklhV0xlOWlZTUZvU3dOZ3RlQkJUV0tpMUFQYjVoYU9DakZBL3puOTk4?=
 =?utf-8?B?TGlwbXVSVFRFNGNodHlpY0tEeDlyVDVnL1ZUVW83bkxUUnU4YmtCMkczWkkx?=
 =?utf-8?B?NVlEam9VTVNrU0VYTmpTaDIwbHNKOW5mbVRhVTQ0YU4zVjNPMVQ5T3pvZmJO?=
 =?utf-8?B?NGk5eXNGVmxoNWNweVROZzRIWWNMc3dqRlFPVm1SQUJBSCtzamJrN3FGVytn?=
 =?utf-8?B?OHp2Z2dyRmt3dU80enloQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6095.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2l4b240Unk4ZGdqOW9oc0xmZ1EvVzR4M0hYajBlWFZZUGtZM2ljUUtxOGM5?=
 =?utf-8?B?RzFCcmxwd1QrQlNNVVRYcWoxQjNiNXczVHRrYkpaOTVSSjlIOTNaSzhseVdG?=
 =?utf-8?B?N0k1c3VtNTNkb3pJa1JldSs5Tm12TjhwZVU3V0pOYnFjMzdyUXdkNC8ybGVJ?=
 =?utf-8?B?RHhidmJYYkxOUXhEaU1vNTN3M1FJZDlrd3NXZWl0eWVWZUVuQU13a2J1K01V?=
 =?utf-8?B?RjdZTTdqMkw5UkdNVTNpci9BaFpFT2JrQzhvV1RXOTErQkxuRGQzK25sZ0RB?=
 =?utf-8?B?UDZmcHE1dXVOdTFJOWU1ZGNCVlJsMzBac0syM3dMcHlIVzd0WGlEWjFzcjVS?=
 =?utf-8?B?WFRYc1YzanZPMWoyM2l5dUtBY0o3THVBY05DME0wbmtlRE1vUTNpdlcvKzB1?=
 =?utf-8?B?ekNKZjVLUEhHazUxNFhUL0YvTTloNXE2NW9pem9UVmtzd01UQnBwbG9PZ2Vz?=
 =?utf-8?B?UEZteGpMSWh4U3R5RU5MR3JjMjhtemR1aVVhMnNkRjVKTUE1ZFdQTlF5cXFQ?=
 =?utf-8?B?NTdSbisvRmIrQVVIUHVodzMzbU9abW1ybit2V0N6MFkyL3ZmUlBpYjNJUU44?=
 =?utf-8?B?bU13QlBQRGphTE9TaU1hdE9IVERQdCtST0tnUTkrSy9McTVlUmdHempZZ24v?=
 =?utf-8?B?SjVRNzE2YVQ1NU5TU3FMLytaemxnU3Z1WU9EcGN6WnVERkNBN3RjWUYxM2R2?=
 =?utf-8?B?M2IxVzFyQTNzNUwxV1hmUGw1S1VSYW16RGNGMDcyZWhlajV0azlYR2R2WE5W?=
 =?utf-8?B?TitBUjVPNFhsc1oySVBvcWxTSTlLbHJRZTBxUFhPNUFZZXBzNno5MllCVUZC?=
 =?utf-8?B?TXp6dzdrVWJFT2VLcHdoN05rV21VcDdheGZYZ0xUb05qbklqUzJNbWRzRHJv?=
 =?utf-8?B?MUs2QUk4VTVpdDJBNmNjN3A0WXh4TFNmTTdvcFBOVE5EN3JYQXpITzlEZVN2?=
 =?utf-8?B?OXFvSG0wdGxTRkE4eHFtVDQ3RFRKQ01mREVNSGJ0aFY4WmJXeUpnd2VkTkVC?=
 =?utf-8?B?cTJ5WTZTV2lPT3NidXVpWEE3N0d1Z2tZU2pxSHJUeTdpdTE4cUcwR1cyVkxC?=
 =?utf-8?B?RVdlQmRTcmZhc3hVUkRGam5yUzkzTGxwUGViZERRUW56QW5Pa1JmNXV4Y2J0?=
 =?utf-8?B?dmI5VWRGL3pMSlVEU3lhbVR2bWh3bS96T2x2NjZhUHFyeDdoazVNT0FKT2FR?=
 =?utf-8?B?ZmVJWms3WTI2d0tvdVRTeUJoMFAzUjVaYmJieGVKWVcwOFl0S0xabVVDUVhC?=
 =?utf-8?B?TUVtSXd6cU5kYmFFUjZidy85M0dwZ3krbEdTUXIza0pCaHU3TmZEYmhkSGRl?=
 =?utf-8?B?ZkhTR3FwOUNKY0VCc2hOUFBrNXY1OHl1VnZabDhwd095K2FPc0JPamF6Q2R2?=
 =?utf-8?B?STNHc0ZoaXl2Vko3TS91WklpTE9YOW1mekFvQ2ZzWmJaMG00ckhTaktSYy9K?=
 =?utf-8?B?TzZzMXI0TWErUmZkcCtZVXJCc01oakQ3blV4ZkVKeUxZdkpteTExWTQybk9O?=
 =?utf-8?B?Vm1EZVk1cE9kbHI1aVRqTDNFejhqN0pQU093Rk1qVGwwMWszVlFRa2dmSklo?=
 =?utf-8?B?Mm4rZ3JZK0pFNW9YaC8vWlB6Z0hEYmw2V1A0UWlTRGNJYlA5QzNZeVYyelRN?=
 =?utf-8?B?enh2MU5rQ3VjYU52L3pIc2hRaVNNeHQ5cjRBeGoxd0VaL2VNaExtb3VTeEg5?=
 =?utf-8?B?YkszZTY2SStVZW0vK3VUbnNMOEg4d0dLTENrUmI3TGJnZkc5dVR1QTFzZVNx?=
 =?utf-8?B?eWF1RFYvbVBrK1lRaENOTzhnbis2VWJwcW01ZUR6V2hjcVUwMVBFamFPbFFo?=
 =?utf-8?B?Z21XZG1ydy9RdVN2U0tiZDVSOVdwYTgzMUMrSEpoMDFucTdyc014dkg3RXNL?=
 =?utf-8?B?bGNCU1U5RTUvSnZTZDJSTUZmcW8yL2lkaWVhOFZJYm1BYUEvYkxJWFRPVjBQ?=
 =?utf-8?B?N2g1WXREbnhqa3ZzSEljTjlzUzF5M3RoeVMzR1pPTkFETlNQUk5zMnVxcExS?=
 =?utf-8?B?ZU5VOGYvcVltUyt6dm91SUhWT2dRU2ZTb0JDdUR6ZGpnb083dEtCWE9uV2Ft?=
 =?utf-8?B?YlYwRnlYRXBFNGRYdXVMa21TZ1krZEp4aXRBY0ttbXNPUDN4OEZ2eENzelBo?=
 =?utf-8?Q?CS5TVuPhMDB1ZnQ5hL9ZY9O8m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e572d06-434c-46ad-49bf-08dd2dfeb62c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 03:03:35.9392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bhe+IXD8zkRUs/R203hof285YqpxKVSuZw6a6DgSW2KRLYMpfktl+G77AJX56AOlo8wOElbT8MYGVoC7nTpfdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909
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

On 12/30/2024 02:15, Kun Liu wrote:
> This patch adds the cec_notifier feature to amdgpu driver.
> The changes will allow amdgpu driver code to notify EDID
> and HPD changes to an eventual CEC adapter.
> 
> Signed-off-by: Kun Liu <Kun.Liu2@amd.com>
> ---
>   drivers/gpu/drm/amd/display/Kconfig           |  2 +
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 82 +++++++++++++++++++
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  4 +
>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 66 ++++++++++++++-
>   drivers/gpu/drm/amd/include/amd_shared.h      |  5 ++
>   5 files changed, 158 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 11e3f2f3b1..abd3b65643 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -8,6 +8,8 @@ config DRM_AMD_DC
>   	bool "AMD DC - Enable new display engine"
>   	default y
>   	depends on BROKEN || !CC_IS_CLANG || ARM64 || LOONGARCH || RISCV || SPARC64 || X86_64
> +	select CEC_CORE
> +	select CEC_NOTIFIER
>   	select SND_HDA_COMPONENT if SND_HDA_CORE
>   	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
>   	select DRM_AMD_DC_FP if ARCH_HAS_KERNEL_FPU_SUPPORT && !(CC_IS_CLANG && (ARM64 || LOONGARCH || RISCV))
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 85f21db6ef..3bd93cc14f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -97,6 +97,7 @@
>   #include <drm/drm_audio_component.h>
>   #include <drm/drm_gem_atomic_helper.h>
>   
> +#include <media/cec-notifier.h>
>   #include <acpi/video.h>
>   
>   #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
> @@ -2746,6 +2747,54 @@ static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
>   	mutex_unlock(&mgr->lock);
>   }
>   
> +static void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector)
> +{
> +	struct drm_device *ddev = aconnector->base.dev;
> +	struct cec_notifier *n = aconnector->notifier;
> +
> +	if (!n) {
> +		drm_dbg(ddev, "failed to unset edid\n");
> +		return;
> +	}
> +
> +	cec_notifier_phys_addr_invalidate(n);
> +}
> +
> +static void hdmi_cec_set_edid(struct amdgpu_dm_connector *aconnector)
> +{
> +	struct drm_connector *connector = &aconnector->base;
> +	struct drm_device *ddev = aconnector->base.dev;
> +	struct cec_notifier *n = aconnector->notifier;
> +
> +	if (!n) {
> +		drm_dbg(ddev, "failed to set edid\n");
> +		return;
> +	}
> +
> +	cec_notifier_set_phys_addr(n,
> +			connector->display_info.source_physical_address);
> +}
> +
> +static void s3_handle_hdmi_cec(struct drm_device *ddev, bool suspend)
> +{
> +	struct amdgpu_dm_connector *aconnector;
> +	struct drm_connector *connector;
> +	struct drm_connector_list_iter conn_iter;
> +
> +	drm_connector_list_iter_begin(ddev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
> +		aconnector = to_amdgpu_dm_connector(connector);
> +		if (suspend)
> +			hdmi_cec_unset_edid(aconnector);
> +		else
> +			hdmi_cec_set_edid(aconnector);
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +}
> +
>   static void s3_handle_mst(struct drm_device *dev, bool suspend)
>   {
>   	struct amdgpu_dm_connector *aconnector;
> @@ -3017,6 +3066,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
>   	if (IS_ERR(adev->dm.cached_state))
>   		return PTR_ERR(adev->dm.cached_state);
>   
> +	s3_handle_hdmi_cec(adev_to_drm(adev), true);
> +
>   	s3_handle_mst(adev_to_drm(adev), true);
>   
>   	amdgpu_dm_irq_suspend(adev);
> @@ -3289,6 +3340,8 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>   	 */
>   	amdgpu_dm_irq_resume_early(adev);
>   
> +	s3_handle_hdmi_cec(ddev, false);
> +
>   	/* On resume we need to rewrite the MSTM control bits to enable MST*/
>   	s3_handle_mst(ddev, false);
>   
> @@ -3598,6 +3651,7 @@ void amdgpu_dm_update_connector_after_detect(
>   		dc_sink_retain(aconnector->dc_sink);
>   		if (sink->dc_edid.length == 0) {
>   			aconnector->drm_edid = NULL;
> +			hdmi_cec_unset_edid(aconnector);
>   			if (aconnector->dc_link->aux_mode) {
>   				drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
>   			}
> @@ -3607,6 +3661,7 @@ void amdgpu_dm_update_connector_after_detect(
>   			aconnector->drm_edid = drm_edid_alloc(edid, sink->dc_edid.length);
>   			drm_edid_connector_update(connector, aconnector->drm_edid);
>   
> +			hdmi_cec_set_edid(aconnector);
>   			if (aconnector->dc_link->aux_mode)
>   				drm_dp_cec_attach(&aconnector->dm_dp_aux.aux,
>   						  connector->display_info.source_physical_address);
> @@ -3623,6 +3678,7 @@ void amdgpu_dm_update_connector_after_detect(
>   		amdgpu_dm_update_freesync_caps(connector, aconnector->drm_edid);
>   		update_connector_ext_caps(aconnector);
>   	} else {
> +		hdmi_cec_unset_edid(aconnector);
>   		drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
>   		amdgpu_dm_update_freesync_caps(connector, NULL);
>   		aconnector->num_modes = 0;
> @@ -7042,6 +7098,7 @@ static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
>   	if (amdgpu_dm_should_create_sysfs(amdgpu_dm_connector))
>   		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
>   
> +	cec_notifier_conn_unregister(amdgpu_dm_connector->notifier);
>   	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
>   }
>   
> @@ -8278,6 +8335,27 @@ create_i2c(struct ddc_service *ddc_service,
>   	return i2c;
>   }
>   
> +int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector)
> +{
> +	struct cec_connector_info conn_info;
> +	struct drm_device *ddev = aconnector->base.dev;
> +	struct device *hdmi_dev = ddev->dev;
> +
> +	if (amdgpu_dc_debug_mask & DC_DISABLE_HDMI_CEC) {
> +		drm_info(ddev, "HDMI-CEC feature masked\n");
> +		return -EINVAL;
> +	}
> +
> +	cec_fill_conn_info_from_drm(&conn_info, &aconnector->base);
> +	aconnector->notifier =
> +		cec_notifier_conn_register(hdmi_dev, NULL, &conn_info);
> +	if (!aconnector->notifier) {
> +		drm_err(ddev, "Failed to create cec notifier\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
>   
>   /*
>    * Note: this function assumes that dc_link_detect() was called for the
> @@ -8341,6 +8419,10 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
>   	drm_connector_attach_encoder(
>   		&aconnector->base, &aencoder->base);
>   
> +	if (connector_type == DRM_MODE_CONNECTOR_HDMIA
> +		|| connector_type == DRM_MODE_CONNECTOR_HDMIB)
> +		amdgpu_dm_initialize_hdmi_connector(aconnector);
> +
>   	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort
>   		|| connector_type == DRM_MODE_CONNECTOR_eDP)
>   		amdgpu_dm_initialize_dp_connector(dm, aconnector, link->link_index);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 6464a83783..4c1942652b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -671,6 +671,8 @@ struct amdgpu_dm_connector {
>   	uint32_t connector_id;
>   	int bl_idx;
>   
> +	struct cec_notifier *notifier;
> +
>   	/* we need to mind the EDID between detect
>   	   and get modes due to analog/digital/tvencoder */
>   	const struct drm_edid *drm_edid;
> @@ -1010,4 +1012,6 @@ void dm_free_gpu_mem(struct amdgpu_device *adev,
>   
>   bool amdgpu_dm_is_headless(struct amdgpu_device *adev);
>   
> +int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector);
> +
>   #endif /* __AMDGPU_DM_H__ */
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 6a97bb2d91..922f329175 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -25,6 +25,7 @@
>   
>   #include <linux/string_helpers.h>
>   #include <linux/uaccess.h>
> +#include <media/cec-notifier.h>
>   
>   #include "dc.h"
>   #include "amdgpu.h"
> @@ -2825,6 +2826,67 @@ static int is_dpia_link_show(struct seq_file *m, void *data)
>   	return 0;
>   }
>   
> +/*

I would make this kerneldoc (IE /**)

> + * function description: Read out the HDMI-CEC feature status
When converting it to kerneldoc format make sure you follow all the 
other syntax.

IE

hdmi_cec_state_show: Read out the HDMI-CEC feature status
@m: sequence file
@data: unused

Returns: 0 on success, error on failure

> + *
> + * Example usage:
> + * cat /sys/kernel/debug/dri/0/HDMI-A-1/hdmi_cec_state
> + */
> +static int hdmi_cec_state_show(struct seq_file *m, void *data)
> +{
> +	struct drm_connector *connector = m->private;
> +	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
> +
> +	seq_printf(m, "%s:%d\n", connector->name, connector->base.id);
> +	seq_printf(m, "HDMI-CEC status: %d\n", aconnector->notifier ? 1:0);
> +
> +	return 0;
> +}
> +
> +/*

I would make this kerneldoc (IE /**)

> + * function: Enable/Disable HDMI-CEC feature from driver side
> + *

When converting it to kerneldoc format make sure you follow all the 
other syntax.

IE

hdmi_cec_state_write: Enable/Disable HDMI-CEC feature from driver side
@f: file
@buf: buffer from userspace
@size: size of buffer from userpsace
@pos: position in the buffer from userspace

Returns: size on success, error code on failure

> + * Example usage:
> + * echo 1 > /sys/kernel/debug/dri/0/HDMI-A-1/hdmi_cec_state
> + * echo 0 > /sys/kernel/debug/dri/0/HDMI-A-1/hdmi_cec_state
> + */

So by exposing this to debugfs you potentially introduce a case that a 
user could call enable on an already enabled device or disable on an 
already disabled device.

I think this is generally not something we want to allow.  Perhaps could 
you check for

'aconnector->notifier' being already set in the "1" case and already 
being "NULL" in the "0" case and return -EINVAL?

> +static ssize_t hdmi_cec_state_write(struct file *f, const char __user *buf,
> +				     size_t size, loff_t *pos)
> +{
> +	char tmp[2];
> +	int ret;
> +	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
> +	struct drm_connector *dconn = &aconnector->base;
> +	struct drm_device *ddev = aconnector->base.dev;
> +
> +	if (size == 0)
> +		return -EINVAL;
> +
> +	if (copy_from_user(tmp, buf, 1)) {
> +		drm_dbg_driver(ddev, "Failed to copy user data !\n");
> +		return -EFAULT;
> +	}
> +
> +	switch (tmp[0]) {

What do you think about using kstrtobool() instead?  Then you could 
support a variety of inputs that people generally use for boolean stuff.

> +	case '0':
> +		cec_notifier_conn_unregister(aconnector->notifier);
> +		aconnector->notifier = NULL;
> +		break;
> +	case '1':
> +		ret = amdgpu_dm_initialize_hdmi_connector(aconnector);
> +		if (ret)
> +			return ret;
> +		cec_notifier_set_phys_addr(aconnector->notifier,
> +				dconn->display_info.source_physical_address);
> +		break;
> +	default:
> +		drm_dbg_driver(ddev, "Unsupported param\n");
> +		break;

Shouldn't you be returning an error code here for the default case?

> +	}
> +
> +	return size;
> +}
> +
>   DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
>   DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
>   DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
> @@ -2837,6 +2899,7 @@ DEFINE_SHOW_ATTRIBUTE(psr_capability);
>   DEFINE_SHOW_ATTRIBUTE(dp_is_mst_connector);
>   DEFINE_SHOW_ATTRIBUTE(dp_mst_progress_status);
>   DEFINE_SHOW_ATTRIBUTE(is_dpia_link);
> +DEFINE_SHOW_STORE_ATTRIBUTE(hdmi_cec_state);
>   
>   static const struct file_operations dp_dsc_clock_en_debugfs_fops = {
>   	.owner = THIS_MODULE,
> @@ -2972,7 +3035,8 @@ static const struct {
>   	char *name;
>   	const struct file_operations *fops;
>   } hdmi_debugfs_entries[] = {
> -		{"hdcp_sink_capability", &hdcp_sink_capability_fops}
> +		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
> +		{"hdmi_cec_state", &hdmi_cec_state_fops}
>   };
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 98d9e840b0..05bdb4e020 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -344,6 +344,11 @@ enum DC_DEBUG_MASK {
>   	 * eDP display from ACPI _DDC method.
>   	 */
>   	DC_DISABLE_ACPI_EDID = 0x8000,
> +
> +	/*
> +	 * @DC_DISABLE_HDMI_CEC: If set, disable HDMI-CEC feature in amdgpu driver.
> +	 */
> +	DC_DISABLE_HDMI_CEC = 0x10000,
>   };
>   
>   enum amd_dpm_forced_level;

