Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9034FC02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 13:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 416D810E830;
	Thu,  6 Feb 2025 13:42:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QHeBq1ee";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8084510E841
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 13:40:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3cWAadiKJDMawZXCekfyRzhleaClwG0XYsn8U+GODnRQJtKAUBHaXaBSGz6hE48u5XCyQ2uCKe1n0MvwMoKaQp9ID/H9G+drVd2Dm5uk0TyTCpOq5Rmqzea56aDLNBPGoHoQ9FTScfuEkD1ih5JnPIAux5z29MR0Elo7h1GP2x2cKrlUVLTnlU6hgp3CxHjpM6h+j8RFtBLork61ISd2/SWEdvahtut1e3pL6OSC8NJZjqyKCNdRk7r0Ih7aUyt7IfCbYqCAEAGPxSICFPXOjmyfWVxezVH2SSwOO6URWUp2C9Nkel2DFjAwVIqrRjZSHnpzXTdZsEIp4WfaR2/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sY8AwTBGZkQhZ2d4Za5O0KVfW2L37lpryZ/RrkPQ34=;
 b=pJJFGLlkjwsg+ydONY7D1QUgdvpiJQK2GS5MN/ld/fB9M7qzxTuaey7Za+iDVVXtsnUrUIkg7KhQ0WF1Gg9YkvmzZe3Nqk2eWHbODPLrnJlohBGnE7cwi2XXkUT03G0fSlXeR38LDlje4018i5uvkKhGGE3Jvf9rquZzpcXUgl4VK55+NvAJ66dNP914jmck3WdG2/KjlWOoJWgr0TSJo6ybwDy2hto51s21atDfbXAKIOFp0itaPWrUo6XNlgwj676faShKzAiITGVTEPqrk64o6e6B0fc8/o6d/BZN7w88VO3fc/Jnxn3+i5xq0v5mJYmLFD0Wy70g/Hm+yy92VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sY8AwTBGZkQhZ2d4Za5O0KVfW2L37lpryZ/RrkPQ34=;
 b=QHeBq1eeIeXFF2HwmF6Dm10HLFoDaJ52DVEZtvm+itjkPH4RjXN8mnVzVC55J5pB29krVxdUxbZZ5x2SXOtNaSm27+GZN5R6OsfWYTcynuaguGYGrCvChaWDmj7BNHoc7WjzTBCgfGOpH5WG7/4+TexvyHB83GOCbyzM3zYN6Sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 13:40:41 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 13:40:41 +0000
Content-Type: multipart/alternative;
 boundary="------------TPZZ0RfSydzEKrM4EJb6DlRE"
Message-ID: <8a2416d4-0dbb-4487-8ac6-f25fd7a7a60c@amd.com>
Date: Thu, 6 Feb 2025 08:40:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/44] drm/amdgpu/vcn: add new per instance callback for
 powergating
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-23-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-23-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBPR01CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::18)
 To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 892ddd6d-779f-4194-ac51-08dd46b3d912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXZPZ2s3YVF5a3ZlRnY5QnlDUXBxY3NoVXZZNml3M083K0pmSkhmRjd5YXJh?=
 =?utf-8?B?SGQyblJ0cGhQb2c3b05GZXVUY2pMMzhjTXo2R3c5eWRseWt6Q3N2bzZQRm1F?=
 =?utf-8?B?WUJwMWNmQ3lzRG1mQzdwQUI1dUVHMlB3WGwyUkg1S3lHQWwyeFVndHpQQkpL?=
 =?utf-8?B?Q2s0QUtaQUxPQ2hiZWdLMFFRUGRSbCt0U0xGa0VlVWRYdngyK1owMGFjMWlX?=
 =?utf-8?B?U1R1TS9BNllzVHRZS2FoR2RUTHllVUwvSkFGVmJ6QjVuUFJySW5DN2pCNFlG?=
 =?utf-8?B?aXU3WkplTHZySXlocFRQKzBUYnJDeGRPVXoyRHRhT0lhcFpFdURuK0psNzFo?=
 =?utf-8?B?TGxtTjVrOWc3SlpWY0ZpMTlXa0Y3ekZVdkRUWmU5TTB0U3JmQnppVUw0MTdC?=
 =?utf-8?B?c0lNVUpPNVRnNGNFUnFZNWdjS1JOTm9kQ0UrOUZqOThyMk16dXNKYlVQeTBW?=
 =?utf-8?B?S3FIVkpKR0IxbzV4Q3p5bTdmTnUvUyt1cFRaN1VFTExpUDJjbW0zRlJtcWFq?=
 =?utf-8?B?R2liTE5KMmhvUHNQbmVNUWxhRXdDOHFJS1dSMlFLam43cEEyWW0xSkx4OXVs?=
 =?utf-8?B?MGlFcDdzYUN1SmFMcXVXQnRTNmtkUitCQjU2S011Q0dDN1ZFOUZxWlFLVko1?=
 =?utf-8?B?UEEzTFhodVpDOUFycUxlNjJ6VnpvWU8rQjBZQUZESWFXU1BBZnFRdUFIQVMx?=
 =?utf-8?B?LzZhSUk3ZEU0bVRDMVhrUWFuSDVHYjlVWWd0bG9RUXBaN1JOWnErVkxESUNT?=
 =?utf-8?B?ZW5vc0Q1d3ZlM1J1SE1EQUphWHNmSVVCS2ZrWTQrWGFFa2xLbHE4WDcyMUt0?=
 =?utf-8?B?VUNneG9IU213MXV2WXpUZGJSOGZFYjRyRGJNaXgySG1uUW9TczVscHVCd0tO?=
 =?utf-8?B?STAvMzlSOXJ0VUFmVHV4NmR1ZkE0bmxpcE5RaGlPejZOSTBCOUl4clRTZVpE?=
 =?utf-8?B?cUZnbW02dGpEa0JPTExYS0ZEbFg3Skk1UnJRR3dQOUhWR1Y2aWM3a2J4eW1q?=
 =?utf-8?B?bEppM05QZDhyTHRTcE9TSytmMm5LTjR5NEVNbzdlODZUMG5aU1lkMUExQ0tt?=
 =?utf-8?B?ZFRqMk5ad29PRTVIUSt3QW9LOS8ralBvNVRlOVQzbkFDWkZIN2tEUWxIcWpS?=
 =?utf-8?B?clh0SHlXUUNLWFJuWE82TXNSazU5MGc4VHlYZEJRRWRLaXdRMmZXWHl4L3Q1?=
 =?utf-8?B?MmdtM1FjMnM5MkQvcUczYXJNL1dYY0o2VXc1VzhaTys5UUtjdCtMUFFoNllw?=
 =?utf-8?B?a1hmQklCaXJ1RE4vVVNWcUEwVW1GdTBjK0tnd2k0OVRpU1ZxMmRrSGFFWkha?=
 =?utf-8?B?NXRhZy9kWmpxRndnOHlNZ2dwK1NnRm9VSWRXRTFaa1I5ejFOVCt0UmJEZVl3?=
 =?utf-8?B?Q1NhNjdEdmtMRi9xOS9jU1BPMHlpTTlVenc0UW11K3NZL0Q5WVlLYlBHSXND?=
 =?utf-8?B?SXZwNW1LK0NWNkFLaG1MczRFMkVhQTBjKzJMQ0N4dVJPYThkdi82Y1Y5VUtj?=
 =?utf-8?B?QU1BaWZ2RWdWWWJmQTVoa212Zm52R3NKZkk2V0RnbVh2UDgzMkxTR21zNHQ0?=
 =?utf-8?B?eWsrOStFOFYwUEFuWDZQVXljK0pIRWUyMkdqbTBVK3dENkE4K3pqVWQ5SVla?=
 =?utf-8?B?VEh2M1lTNGZsS3YwQktySFFlWlZQajNyOTZhL1NNdERCalhTRXgwZXJoYndQ?=
 =?utf-8?B?UGlDVS9GRG1rZVBueVpnejRuTWZtQWtxYWRyQ1licHhVVG9wUXdVeUQ1V3R5?=
 =?utf-8?B?cTJNZmhSUktnc29PRkFBSUxpTGNGVXF1RzVpVkhMcEU0TkttTWlxZmYrNUtq?=
 =?utf-8?B?elNyYTdxSXZuSFhaTi9jT3ZqVCsya2Q0QXBKL3dvb2NvZ0RUMjd5aEdQOXNQ?=
 =?utf-8?Q?Euixf5da4JOBk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzJKSW5ybnR4a2F4RFdNeGdsTmcvTnczNEVTTElHWWtGajZGR25nUElEdnJ2?=
 =?utf-8?B?a3QrNG5ETXFkaVR6UTdsM0pMUjNzREpZOFFjVnZYZmpxNEJRSFYxcVR4czJK?=
 =?utf-8?B?SFRRaFZncG5RamdJWjZySWxyWHdvaTZUa1JabnF5SkZCeE5ZSXdkVk5UcXRL?=
 =?utf-8?B?QWNhZFVEYjZpYmpxL3UwZ0NvU2xUS2RmZWJMU1k0b0xqczVCcWxacVBsbWIw?=
 =?utf-8?B?cnNmQ2c2MjZTWEZFdjhIalRpeGxqV2sxNHF6S1VXS1c4ZHFMb0VmYXpydnVk?=
 =?utf-8?B?aXk5VW05YWdqeEgrQUlHVC8yQWI4c0dXT0F4NThkbGxxNDVrYThYaGFEOEJK?=
 =?utf-8?B?dWx0cERvc1NCNVFTcEFBakdQemlmQ0FoTUlBNXpabTg3S1BtMjQ2bVhuemxo?=
 =?utf-8?B?OEZ2OTNCc0RJV08xdFhseHBoVzVDYU51aFZDbmpwdEZVREQzbDdqVlVURjc0?=
 =?utf-8?B?UVd4MnVtNEZ5dUhFMFBHeTY5eHB3WExTSW1KcDNBdXMyazFrZ3dnbmNOMENG?=
 =?utf-8?B?aE9KdmpOUG1TY3JGWGcvYkpZdEc0dEIyVFhUY0ZZWC9WZG5sR0dWWjdpZk1B?=
 =?utf-8?B?QjhVWFV5U3lXYjdqelMyK2h2WVRLOVZaQkdHVmo3K0J5bC9TKzRnSUlTQWtO?=
 =?utf-8?B?N25IVUNteGt4bHovREVhWERsZEp2enVXT04zK2xHSG96VThYcDhMM2FmTGdi?=
 =?utf-8?B?TnZhbC9FVkhBdXh2RDlIbGlPYUNMaFc1SyttWGw2V2RLUUhGVFZwckh6bEJP?=
 =?utf-8?B?YWpVdXFSdnhMbU1Eai9PUEowZFZUSUE4SndOTUxvSWE4bFJrT3BBVUZFdCtP?=
 =?utf-8?B?Mmx5K2NaSDVac1RxakxxVFQyM3JhWW4yNGlFWUZoOE4weEpKQjBmWGtVOXlC?=
 =?utf-8?B?MzdXQ0RqZTdEQmZUUlhZWUJhVkpId0FQSHlNY1dSY3phdmtHNDNVVk9oWjJ5?=
 =?utf-8?B?VXYxWXRCOGVPYnkzb01TMWNXTk4yOGRDeUxQWmM3VS9DNm56YjVEV0VSMXV2?=
 =?utf-8?B?V0U3SjdwZnVLNGQ0NTBRUHBqZThqQ3g1T0g4TDdzczMxcldLb01odHA4ckR4?=
 =?utf-8?B?d3p1YTExSWkzQjNOMWdmNGg2cVJoZmZWWk01enJ4Mks4a2Zac2lsOEIrQ1RX?=
 =?utf-8?B?b25tUGZ0VEQ2ME5UNmQycFNTVzB0NkxhNldFUjRQSWFoRzFHTUM2TzAzdFps?=
 =?utf-8?B?bVJLY0ZxQzM4am9Fa29lb1NFazYrcDgrZ2JIYWZIUEI4b24rdFQxYmE3R2No?=
 =?utf-8?B?dWwrTjRIbkhxRUFvV0IvR0NRdm01b0pFbUorQW05WVFybFdXVWdtZlE4WlVv?=
 =?utf-8?B?YU5IL1NjWlRGam96c1gzRVFWM05pMHR5U2YwVmwvbUx0M0NaSWV6T0J6SXFL?=
 =?utf-8?B?aXlON1dFVmR6bU5DOGVnZ2pUdTlCVjhJQnlKajgyU3VsR0RUamVsM3UwZXgw?=
 =?utf-8?B?bHJQN2N3b2NXcWVqRDFCZ2pjTHRxOHRKenZzRmVtQzlld04vSWxraC9Xd3Z1?=
 =?utf-8?B?S015TlBqNHVNblFyQWthMzNlWStud2F5YXp5ZUladDlTRW81dVpzbldCSVlM?=
 =?utf-8?B?d3l5anB2MnhQYlNaeW45K3ZVTVpFT0lKSC9VcUZFS3RFMXdtdU5aWjJYQkFu?=
 =?utf-8?B?QUtWZ2FwT1g4TXBCWWUxT3cwQlQwYXdUbUdnRnllaStkdkxjUjZaNFQ2ancw?=
 =?utf-8?B?U3BoUWZJVDVsQnBGUHRJMXFyYnhLMUhKZitoVE1iVGg1TFRkWm52VmVOYzNT?=
 =?utf-8?B?bFUvV0NnQjhFUlVOQ1psVzUxNGRlckxpQ0hoU29Vd0VybmhMVXNFL0tTV01G?=
 =?utf-8?B?TTJxclBMcFhkaWd2STNHQTV3eDRZeEM1SDU0cnRzczhnQ3d6dTFHdDROVEdX?=
 =?utf-8?B?cHZBVXNBMUNVeXpLdU56d0dvZXFoYkpETnNFbisvL2dBWnFpTGRiMGQ4NVU1?=
 =?utf-8?B?NW9RZi9rcHkxcFJjZXV0VFE1TG9kc1lweE84RnZ6SUdySVkybHhQc0J4LzI3?=
 =?utf-8?B?SWs0TmpiVFFPS3Y1SE94ZUMzRGFtUHdZdmNKMWcyMWk4d1N3SUdiRlFuTm1p?=
 =?utf-8?B?SWpsNys4bUc3OXA3UlovOU1VdEFyZk42WU1JU1JzOGNvZmt5M1pBZi9TNWp5?=
 =?utf-8?Q?EDmGgkenT5EM71moQGpbWlVzd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892ddd6d-779f-4194-ac51-08dd46b3d912
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:40:41.3335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcsqBVUtwEhQVgMVBPMp2tHQVudhD/C9LkB5eRmcXN363kQuR0gPQWrwhrkl19EqAI6ESeYBYnzjE093fD+MMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410
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

--------------TPZZ0RfSydzEKrM4EJb6DlRE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> This is per instance so add a new function pointer for it.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 8d34e3814ab19..508fa022df78c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -329,6 +329,8 @@ struct amdgpu_vcn_inst {
>   	struct mutex		vcn1_jpeg1_workaround;
>   	int (*pause_dpg_mode)(struct amdgpu_vcn_inst *vinst,
>   			      struct dpg_pause_state *new_state);
> +	int (*set_pg_state)(struct amdgpu_vcn_inst *vinst,
> +			    enum amd_powergating_state state);
>   	bool using_unified_queue;
>   };
>   
--------------TPZZ0RfSydzEKrM4EJb6DlRE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-23-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">This is per instance so add a new function pointer for it.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="mark5quw442ch" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-23-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 8d34e3814ab19..508fa022df78c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -329,6 +329,8 @@ struct amdgpu_vcn_inst {
 	struct mutex		vcn1_jpeg1_workaround;
 	int (*pause_dpg_mode)(struct amdgpu_vcn_inst *vinst,
 			      struct dpg_pause_state *new_state);
+	int (*set_pg_state)(struct amdgpu_vcn_inst *vinst,
+			    enum amd_powergating_state state);
 	bool using_unified_queue;
 };
 
</pre>
    </blockquote>
  </body>
</html>

--------------TPZZ0RfSydzEKrM4EJb6DlRE--
