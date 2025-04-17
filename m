Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BC1C369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 13:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDBAE10EB1C;
	Thu, 17 Apr 2025 13:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WCdQWVU7";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 999E910EB1C
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 13:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bq1WGx1xWkdPRMgR81p8v/XJh42+hqm7XozRTC1PyjAb45brvzXbEoJyYIarx6UhVGWt5hpEYxfau1ic3MrstWoLMBdos18GLZp+wzeETG5ULSUvbPQapArgxKLicl6G9O4e44LvYaMzVuJGeeCOeAsmqmsfmOHhGTRpv3TY+Zr8ezkTf5L2rpZghpySWuSdvsqJT25WtGne3cJghAR0dCzeFjkjrcc9k2DnCYN089jf3WoMNHryGAuV3TSiOpTOjeFmgq/izRxiIIC9w0NIwtHos8DejVKTTMJGaS8GIiCnBcgnMVxFmMbG8m7e4BT0bYxWvckZ0EX19b91leOWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQI1AC1hyDKwToOn6gUVov/gq8I0z3pEknlY13bNJBM=;
 b=edwrqaU36nADMApwP/VUDTjjG/0fS27tQ/EQSYJtM8oXI9qENU38HO7jdKkKlrF5VFgbhPNPosSArenc4+tRJlbif2+aeq6gK0x/gBVYAcADEgYnpzrp3b3fX/opsrSdT1xZxIBRDiRqghu2zFZf2V+Roha3YtHFuIbm+zn1RTMYEL8gd/8wMmfVJHyssYM0YwMXWnOHacVx0wR4vPRGmzSXPOAIfghRoob9HVZ4jMD2sE5a5MGdQjwDEPXgXw0BHN7rSx8lKCintqIMefznINkllFx1M/kUCxPMjEVL4kJgeI3lfkH8BOzajVnjX0uECV54f0QiBnqs+LXKc6vyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQI1AC1hyDKwToOn6gUVov/gq8I0z3pEknlY13bNJBM=;
 b=WCdQWVU7GUE2Glp6NcTG9NaEt88y9Q3C4tkjzEV4HYjeHLsx6TDOP92s6nK5Aft9GWlRZfLJNQ39MC7+6TsPbkwmVfKbbTgw472elbJ2/fnzpGAbao9MF3MqPMrecl0eHU3itum4jobJ2c1X3xUXYR9x+k0h0K68HU17z0LF5xM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6164.namprd12.prod.outlook.com (2603:10b6:208:3e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 13:57:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%6]) with mapi id 15.20.8655.025; Thu, 17 Apr 2025
 13:57:09 +0000
Message-ID: <094e983a-38b0-4a05-8b65-50a7f2f4ef56@amd.com>
Date: Thu, 17 Apr 2025 15:57:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/amdgpu: Don't pin VRAM without
 DMABUF_MOVE_NOTIFY
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: yang.su2@amd.com, hao.zhou@amd.com, asher.song@amd.com, pak.lui@amd.com
References: <20250417133352.1204510-1-felix.kuehling@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250417133352.1204510-1-felix.kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f39718-e9bf-4bc1-ac8b-08dd7db7be94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHlxbGxuOEFvUnlFU1BLSmFVM2l0cnRkeUhrYVpOME9jL0xUb3N4T0JDL3BJ?=
 =?utf-8?B?M2FrRk93RzBoR3FlLzVTNzVwNHZ4VTRjay9QdkNlREVjWVY1RTRMdGRLQkYw?=
 =?utf-8?B?ZGU4bjlQd082R2QwenNJWmdXemNGZ3NpUHRQeFByNjhsNjVoSktNNWZVYTJn?=
 =?utf-8?B?bzVQYzlDMHJGODh6dHM5a1dUVFplcm5BamFFVWFnUjZpSXNJQUFaSE03ajEr?=
 =?utf-8?B?dzMzeEpYaGVOOXFQUk43QTBzdFh2MVdSZmlMNkV6NE9SZnE2MUJ3QkdWcVdw?=
 =?utf-8?B?dXc2cTF1MW1sdFFHQ1ZWTjRaZTd6TVhwWlRpTU9pdmdaanQyaW9mL2EzRDZE?=
 =?utf-8?B?cWtvM2JuWEVaTDVkOHlEdGYxd2xrUEVYQmxLREliRXlEOE1YYzJHdUNmMHJm?=
 =?utf-8?B?Y2ZkQ0tpOCs5UTJXNlJ3cnhWRmZwaVg1MGRpMzFSWVVtVExUY1FMRUxWUGh6?=
 =?utf-8?B?N2ZsWVhqOUZPODI4K1JnV2sxNDQrYTJuM0t3MStOZWZzNHJEUHlJSGtVNWZC?=
 =?utf-8?B?enZ4VXdZd08wTE1sT3JWdUd3V2plMW1BYzdTNkJXQVFIU0JDTFBpbE13TzVj?=
 =?utf-8?B?VUo5VWdZSE5IL2FVTWJOTStzdHJjUGdUbzk4TE1VazQzNTZNTDcrcWpnQmZX?=
 =?utf-8?B?Ti9LZi9JUk5XTEQ5R0QxWW1TWW9VRW5yVy9TdmI1TlNPV25VUVpOR0t2cDFi?=
 =?utf-8?B?Q25GNjA2SGwwVGdjQTRqZTdnTWJRK3l2WEFzZlBuc1p3bG93b2F3ZldOdjcr?=
 =?utf-8?B?eWs2R3Z3ZytOTkNkVXRGb2o4eFp0amdDdmpaUXRoRVpHbHlkS0psTHN0b2Ny?=
 =?utf-8?B?Vnp2RFY4NDRSYnFwdTBaYXUwbHVjblplK3RsbWM2RzdxZnlsOFFIVEpKbVI1?=
 =?utf-8?B?T0p0cnI5bi9NSGd0YUlWS0RUOSt4QnNHVGZGUW4rM2VLY2xiL1FRdU5QSitp?=
 =?utf-8?B?bkI0Wng4TEtwdUs5em1sMTRKZjUvQ0FtNS9aeW1zTHYyV2JvMFNIa3dqdUxP?=
 =?utf-8?B?cjZCTjNwL3hKNjRES2I4Zk11RkVGbFVTU2RRUGxWN2pOQUJWTnUvQWpubnBI?=
 =?utf-8?B?dm1Dd0FGK0FySUh0emRQRTV3aVNrOVg3ZVBXbFA1OGJ0MWZDNWdPVlVITU9L?=
 =?utf-8?B?SkVSSjNJSHlIdEVVeUdRUjZKR2JvY3NBZ1VjWE9VRHE3cVRKL3Jha2JVYWtn?=
 =?utf-8?B?UVFNYjQzbkRFczJqRUNQVWRyTHBJWS9EZmdVNENSWmw5VHdjS2hqY1p0LzB2?=
 =?utf-8?B?QjRWNTc4dTRJOWZibFVCMjA4VlkwcWhjcEsyVko4OWtEUnJNOUVhVkdEalZJ?=
 =?utf-8?B?bENoSk0rTVV6K0hlMkFOQ0R3NThFS1d5NlFqWTMzZHlYY3RlSWZBNGRMV0pl?=
 =?utf-8?B?eFNzSWFFd3BuSlVCU0g4VDZKaFdUaWc1dysvSFJoemJsOGMrdFdkZlhWTFc2?=
 =?utf-8?B?cmpqVXprSU1mR3Frcm5FeC83MEQwMDVOdEhaQnYxKzc5c2tEcTh3eXpIWXVx?=
 =?utf-8?B?enpvY2VxNUFvY0o0bmIxcHdVWEEwaml1UmxwWDBtNEtEc3F4TmxIQkRwYWFS?=
 =?utf-8?B?cEVJZkwxYllqRFFESjJsRTh6V0owMVMwelB5T1p0S28xejNmVmJyeVJlUmZE?=
 =?utf-8?B?UFVIYkc4cFNDV2piVUkrZDBWcWYrZnFxVkI1eXNPLzhON0VBc2t6OXE4TG01?=
 =?utf-8?B?RSs3V0pyTUM5ZGh0OUFTR1pJMFE4MXJiNUJYa1lRWEh3em9lYUlWaTlTMlhn?=
 =?utf-8?B?QXczQ1ZlUGxQSzViMXRBeTNNNDAyVE9NSEUzSXkvbTFFWEY1RjdyUWtlRzBt?=
 =?utf-8?B?eHdhQk1PbWQyQ01ZVm1iWTc3dU44MG95YWJQQnUxZHlLbDRFb1RBekcxbnRQ?=
 =?utf-8?B?OE5Oc0IvazVINU9WNURMRTRtcWJpMEI0SlF5QlRreG12SU9JTlRaa0xHd08x?=
 =?utf-8?Q?MHHfqaJtvwg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDBRMmhQVThubEpYYTZUSEdsbWFqMjcrVURvbVVEaUlsTWt6ZzhQMFB0S240?=
 =?utf-8?B?ZjhVclU1emM5NkZEZkZOQ1RzcG5YOFhROVIwZFo1SUhyZjg3S012Y1NOT0xY?=
 =?utf-8?B?UkUzSmN5T2xyZHNIa0JQSTJaSUh4aG5vblhyVXJWem9qU0VOeWx5bkhQSFVO?=
 =?utf-8?B?bi9LVzFmM2xvVjl0V1ZSOE9BR2JuOVpRTHFkZllNNGZ2UUd2NExiYldHeXRz?=
 =?utf-8?B?cXJjczZqOUdFVGdzWkpSZ3NoTXlTMWRhcXF0MERCOWtQYm1rUU9QY0J4UmhU?=
 =?utf-8?B?cDJwRXRuWllkcXlGUE1UZ3pWWldoYk02Y3pWNGpHYUF3OCtOTnVrREFkRlVn?=
 =?utf-8?B?Z01CZU56ZkQvaFhpSG55OGVnalpVcjlOZXhFUnhZemQ4UlJ4SFlNdzdsQ2Fq?=
 =?utf-8?B?TElxaHNqTm9GcVhwSjNLTENyY1F1bkdqYzRJdnpaaXNBdHQrRTFROVFUWHpv?=
 =?utf-8?B?dWVaODlmcHgxc01JZXBCMmNHMUxnVmMxTGlkWStxS0hVb3dsTXFkcitpdE9n?=
 =?utf-8?B?RU0vcFNMcS8ydWlDWHJMVjlLbHd2aVRiV3RNbjlpbmRxUlBENUxaa0xnNzlj?=
 =?utf-8?B?Z2p3eHRjbDVyV1ppREdOaXgxWWkycDU3b1N2VFdjdER6R2k5QlA3RDBqOFRE?=
 =?utf-8?B?bXllK29ORUpNYndraGJBV00wZ0dCL3lWeVpUYzZXYnQrZzVrZ2k0K1dWQy9P?=
 =?utf-8?B?aTRDOU5tbWJHeGlEMVhGUWpCT0gvZXVpVVo2TXY2RDhESjZhVEZpVFk0K2xF?=
 =?utf-8?B?L01HSE12L3NiT2JadDc0cUdBK1hOb1ZiazR6bUZUUXpiR01sNCtCWmRGSGE2?=
 =?utf-8?B?NUhzem13T0lmQ1pzV3pTWE5WbFRwSGpTZTF6UW5rakFEVHA2bDNrZzJLTGFC?=
 =?utf-8?B?Sk9RakI3TWhWbEdmeXEwbjMvbi9CNis4WmV5NTVuQ3M2aE4yRU5mWVIxZUJt?=
 =?utf-8?B?WW5ZbjIrMXpPQk16MUpiQXZqdUNRMjRONm4wZ1VBRktseVIzMmxCRWpCdmdL?=
 =?utf-8?B?dUxlS2ZtT29OYURqV0pxbVQ2WEE1OUpUVXhTTTVuUk4xQjBJK1VEbW9yRjI3?=
 =?utf-8?B?QUtmc1RUbjJhUUUyVXB2QTlxV3VWMkhlOXF3eU9pc0NxUWd3UUw5dVpOMWMz?=
 =?utf-8?B?QTBIUitrR2daa0dGbW5pbGVDY2pZYXV6a0F3bWJrUnF0dEI1RG96RHpzd1VF?=
 =?utf-8?B?Uzkrb1BybUV0RGtvM0laL1FFTGpsbTBSWVVSSExwR0hSY3VhcStUVWFJaC8y?=
 =?utf-8?B?K0cvRWFzZllQaVdnaVRWcllzMlY3WEpBOFJnMDFVNzNnRkNnS0JDNnd2SlBU?=
 =?utf-8?B?MHNQczMxSVdkUVFnVy9YNjZXLzJTTWJJQ081REg2bnc5SEtaVHk0a245bnF5?=
 =?utf-8?B?dFR4NzZWQnloK3I5eTlpZndXRWVZUDJPZzhwbTlQcUN4Q214NWs2OE1ZbGN5?=
 =?utf-8?B?SHp6MDFMTk5GKzNoZDlETjhkM1dtcDM0Rm5qOGZ1bG5PcnNYblE3R1hMTEtV?=
 =?utf-8?B?Z2JQclRoTFZjZVdxb1lHaUJwTzdjaG53NklibFYyMTNuVnBCeVN3RGkycDRF?=
 =?utf-8?B?ejFBakt5UEcwQWZVYnNRcmx6QWRxanM5TlVDZlJIdjlkQUJpOFFWSWN1OTVH?=
 =?utf-8?B?cTcwMjFpMno2QThrelBsaVdzYUtWUXg5L1RiaXZHcTFMcDFSRFpPYWJ3STFt?=
 =?utf-8?B?Vmh2R1lVK2xEcXpWMEE5N0V0RkZzWVZaTkpUY1A2ZzJLTGk2dHRJM1FTOXYr?=
 =?utf-8?B?QlM3anp0K2pUcit3OGkwZWxiYXRnOGUwM2R4SktHVlVqSUVQZGFjcVRiYnNU?=
 =?utf-8?B?b29UWTR3Q2Y4eWh1OFFMNHI5TlYxU3M4UWJxUEtacklQZ1RLU2V6Tkg0YXpV?=
 =?utf-8?B?TXE4UEpKV2xWUmd6Y05QOVBHdkh5Z01OamhUdEJzQ1g1Qm4vQkVhcmVqc3Zs?=
 =?utf-8?B?Yi96dWJRdDdNb3FDblkvSTRrRFl4YmJJalpwRFdSMmk1OC9pNjZLOUI0cGNr?=
 =?utf-8?B?ZE1CVm42UkNiQ2hWNTUzSk1sdjlSL2pkeTRCWUhkL0UyeVhpRTk3MG01TVpI?=
 =?utf-8?B?RWU5Undia3VaUFF0SnU5YmRyd1dwZnhMQVBDekxkSms1Nmdpa3pyQ1FpbDJX?=
 =?utf-8?Q?3GKcBKF5geiO+pPyXAtzGQQrk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f39718-e9bf-4bc1-ac8b-08dd7db7be94
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:57:08.9116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrhEFfk3JMOv9vR7bPQ7BGL4ooBm5FZXXZdiKRpXoOoi2aBExh3sbGkC1rsWrNkc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6164
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

Am 17.04.25 um 15:33 schrieb Felix Kuehling:
> Pinning of VRAM is for peer devices that don't support dynamic attachment
> and move notifiers. But it requires that all such peer devices are able to
> access VRAM via PCIe P2P. Any device without P2P access requires migration
> to GTT, which fails if the memory is already pinned for another peer
> device.
>
> Sharing between GPUs should not require pinning in VRAM. However, if
> DMABUF_MOVE_NOTIFY is disabled in the kernel build, even DMABufs shared
> between GPUs must be pinned, which can lead to failures and functional
> regressions on systems where some peer GPUs are not P2P accessible.
>
> Disable VRAM pinning if move notifiers are disabled in the kernel build
> to fix regressions when sharing BOs between GPUs.
>
> v2: ensure domains is not 0, add GTT if necessary
>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> Tested-by: Hao (Claire) Zhou <hao.zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 667080cc9ae1..3c2c32a252d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -81,17 +81,26 @@ static int amdgpu_dma_buf_pin(struct dma_buf_attachment *attach)
>  
>  	dma_resv_assert_held(dmabuf->resv);
>  
> -	/*
> -	 * Try pinning into VRAM to allow P2P with RDMA NICs without ODP
> +	/* Try pinning into VRAM to allow P2P with RDMA NICs without ODP
>  	 * support if all attachments can do P2P. If any attachment can't do
>  	 * P2P just pin into GTT instead.
> +	 *
> +	 * To avoid with conflicting pinnings between GPUs and RDMA when move
> +	 * notifiers are disabled, only allow pinning in VRAM when move
> +	 * notiers are enabled.
>  	 */
> -	list_for_each_entry(attach, &dmabuf->attachments, node)
> -		if (!attach->peer2peer)
> -			domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
> +	if (!IS_ENABLED(CONFIG_DMABUF_MOVE_NOTIFY)) {
> +		domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
> +	} else {
> +		list_for_each_entry(attach, &dmabuf->attachments, node)
> +			if (!attach->peer2peer)
> +				domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
> +	}
>  
>  	if (domains & AMDGPU_GEM_DOMAIN_VRAM)
>  		bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +	else if (!domains)
> +		domains = AMDGPU_GEM_DOMAIN_GTT;

Please drop that.

We should probably use allowed_domains instead of preferred_domains and return an error if none of them work.

Regards,
Christian.

>  
>  	return amdgpu_bo_pin(bo, domains);
>  }

