Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81C6CCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2AF10E1C9;
	Wed, 29 Oct 2025 10:19:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KJmi3nZq";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012037.outbound.protection.outlook.com
 [40.93.195.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D77CC10E0B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dodTtdIahR/osPjt1xRX/R0OQ3B0vu0Y1LmvOvx/V8I4rVfcWjir9HHqCTWup3lk6aRlEio6r0Ugct7CJ0kJTNk/LYH7XJ8gnmXwGnuhun/aCdbfCOLHLKdylxDXzj1Gb7Ab5kqtpHlpw92VnzLXQXrxuZq8fSJPpZVZNxNdZLS1nqLkunktwWaNRpvyxdtJhvL9akfI9f2T1DRp6giSVppny8ODCNpQFFhKqQI7iYdXcyOT97OQ4YBMSdJzp6pIUU2t1PH0f5Z8WIMPEfrfSXVrjghUS22w3KOAlk/bw7AWbWQdnzr7cJo8Ev5/zwYisRM7Okuy0VFMO9kA5MzNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX0PmUVz/Gg2D1WseorQlFZSurWXNgSzNDjCfVZRDU4=;
 b=PIjqAA/dsj/Oq77Puwwy1A1+wKd5OmccmQp6zPf6YOmP9OdxbG+rWK1IHpDbjKX2igKiAkbdRjsKjNVN5zSrG/X3ntuYrJz0znABr5D7fOMNQugZhKXj8EsfodQw8wsEKI0Ov8B5ZHAiP5ApLNJaK12fQ9bdS59mn45TYlwGhacfQRyPEbUoBQrGjqBqoJ9I/nQ6kQuDqxgC6q2Z2UbiVJVDrinjJ6Np5dyPtRPHAk1w1Li6Evk0Gbf2t+sd9+ccqkSTvRI+jX5BDZX1z+SL6vrWsbcj539o0NkL5VR4RHH8HxbrS95ScKeZt1fYeknw6IYERtZEihzFNDXzKm553A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX0PmUVz/Gg2D1WseorQlFZSurWXNgSzNDjCfVZRDU4=;
 b=KJmi3nZqrX993QBOUev7diux/aA4IPO3rm3QKS8AubBDCwk54r3D2Zmcn7vFSPDRe+4yVKfUwtCZFmx4+3MTnj2PLScKwPIZeAI1tYke1NIZiUDyr32qlz2L3AdX/PsvS0pCVxGkBKtWSsSacA7D+AcuflnyC6CUzn58BmfciMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 10:19:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 10:19:23 +0000
Message-ID: <baa0105d-3b37-4e63-8232-4f45976a3e7c@amd.com>
Date: Wed, 29 Oct 2025 11:19:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] drm/amdgpu/vce: Clear VCPU BO before copying
 firmware to it
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-6-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251028220628.8371-6-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0328.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: c7af30b6-d5f0-4b9e-38a0-08de16d4a15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUluZmoxTlBCRll3dDRWNjFPbVQxVEdtbW5vcEliVERDYUtXYkhXeFFlYk5z?=
 =?utf-8?B?U21WNmFObTlSdmJrVWkrRFNleDh2K2hrTC91YXB1SFBXVEF2UURqZHFRQ3BG?=
 =?utf-8?B?czZXMVZuRXB5UktIeDQ5WGU2ZWZLdWVpQzcweWRNV3JSVWZDazJJVjhSeURZ?=
 =?utf-8?B?NkZHcUFJaXBaNml4Zm15VzN2a09xL1JwQ0FOdUlka1B6MVcrd2pwbEVHSmVS?=
 =?utf-8?B?SlRybFAyb3owMDA5cmdDR2hiTEhtYjNRVDdETFdYSVRUeDVxNnVMVHIrNjNJ?=
 =?utf-8?B?SitJT2VhUjhrb2F5ZWcraDNwMjZDTGxKS25pZFY3cE4yQmYzWWIwaWxHdmMz?=
 =?utf-8?B?Z1JnVWFIT2RVVVg1OTlpYzczcGsyL3NIaVc4SlErSy92OU1XQVRrays1Slo0?=
 =?utf-8?B?eUgvSXRHejNMa0RHdzJsNEE0bDc5OE4vTTNjS3BHRjFmY05ZalpJd1l3a0dv?=
 =?utf-8?B?QURzemtXUHduY0d1RllOR0U0akE1bDhoMHhZUGRrNDdNMmxaOW1LK1JOZjNh?=
 =?utf-8?B?enpPVzRaRUZOQUJ5Nmx2WTM2ejdUYktlbjRtRC9haEUrZVByN3dKZFkrbjZQ?=
 =?utf-8?B?MkNJb0dMb3BOTzdDV2dQRXR2RUlTZDlyWjFodThmODc3dWx2Q2J3STFhU01a?=
 =?utf-8?B?V0ZYWkg2YjM0cUliWWNTS1NaeWErL0JiV0hoNjlCOE11SkR3MHU3aU5lc20y?=
 =?utf-8?B?LzZSdDZ5TnAxKzMzY2VIOE5tMnVSWmlYSURPcnRXN3dDNVpOWklqcnFDMHhi?=
 =?utf-8?B?TERoaTBCMVhOVUFCeEJPNlA1UFdURHc4cWQvSG81cEdBZlRSZkg0NHN6bVdn?=
 =?utf-8?B?eHNKTFFvT3pqb0pIdDRCMkh1UmppSTRZNEJjSHpRbDVBK2d5dFRnWjAwVDV1?=
 =?utf-8?B?YW9DRDVkM1ZoTUJZY0NuSTBrcSt5aDRjTnVoYXZINWlSZjFiNVVpcU02TWFO?=
 =?utf-8?B?bUFvQTdVRzNCbXpPcVJjdTViN1czalJmUWQvN05pQlFpL3BxMTNtblMxaHND?=
 =?utf-8?B?OEJBQXk3RkY4bllwaUFvNE5LRkRNeE1ia0tZSG5RNUxTSnlCaUErSDkrM0xX?=
 =?utf-8?B?dm9wZVp0RnVJUHhxalp4Wm1YRG1sUUJQdzhoTzAvbUhwbkxoMlo1R3BrQlQv?=
 =?utf-8?B?NGZYdFh4eXJRTG5CL0srRk5DSktqTkwrZlYyMFFkZDVneFZGbjZvd2tsRlBU?=
 =?utf-8?B?L1FsZy9VdXV3ZXVCN0R4ZlF3UzA2WWZHOWIrRWdwWitWT2tXcWVRZkpBY1Rr?=
 =?utf-8?B?WnJpd3U1QmVSa3hJSFlScTh2aEl6cEFzUDBYRHVnenlyUkQ5NU1Qdnk3SjM5?=
 =?utf-8?B?WFJONy9jemI5M3hNQ1puNkFFR3V3Y0ZidnZtaXZRb0RnMlJGeDNuNDlLekg5?=
 =?utf-8?B?c01BSGI2M1V0YzdsZkF6eW1iVE9PZThIUmxKTURHWXVmM2FCbzJScCtEVDM1?=
 =?utf-8?B?MjQ5N1k3YVVrd0VKZk5QekcxZFJHR2RXY0ZIL2tud20rWWFxT0o5elFvbmFi?=
 =?utf-8?B?Tk9ab3FRRmhyVTVHdnNLWGVyd3VmcDFXTURTY2lYL1MwNWNhSEQrZlptbTdH?=
 =?utf-8?B?SUQzN0l5eDVHQml0U01oazBneEdkYjhjNzlTbDlvK2FqaTY5aE5zS2V6Mld1?=
 =?utf-8?B?eElwNCtGQk5YOSthRlRGSVFlRTgwWVc5cU5IZFBUSHlyK0E1L2hLOUpMZiti?=
 =?utf-8?B?TzVjTFBid0RUV2YzS2o2UXNsbzMyZlVHUElJVndRbzZhMnpDODFYRFpvTkps?=
 =?utf-8?B?T0Y4Q0ZZMU5aMEVDMUpySUJVd0ZGeFF2SmpOT25YMUNndFdoYjFiMldCZm1o?=
 =?utf-8?B?TEFvZllSK3dUamZka280R2sweEJVYzVmeVdUWUEwTmYxMWhTWEx4azFSamVj?=
 =?utf-8?B?eWg4WmVUeW0vQ0x5TWI3Ykk3WjRqRlBjMDZxcDBJaWltdXF2ZnFIRkorZk15?=
 =?utf-8?Q?wQZb7rOij7BoJlsydt11+Qy/W8o3/26+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnVpQUQvc25YeEpjZkJWU1c4SkJDZGIwaU8xa1RWYWFMNm5jMENOWnVxZzRW?=
 =?utf-8?B?eE5HcXpaZGN3OGxnK2hTRWM4ZjA4UkpMalIvU0dVSmtnM0hSaHdNU04xWUxE?=
 =?utf-8?B?eWVGL0hkcmRQYlMyaldVTVhEK0VpZUVUUlNNYWZCYUY4aEo0SExLc0ZxSWh6?=
 =?utf-8?B?akRDQ0w0YUhlcHhqS2RpVUdCWHY1Zkp1VU9GV1FIbWFMeU16UUc2QjVVaHlv?=
 =?utf-8?B?VUF0OUhpZWNqa1EvV1F4b0xyMVVoZ3V0SEV3VnhCYURCczFZL2NVMW4wL0dp?=
 =?utf-8?B?aEF4cDJzZ1ZvREd1MnpjSjc2Rzl5QzlkRm9HU3ZoeG96aXYyZHN4TzlrTmxH?=
 =?utf-8?B?NGhTY2RudCsxd0twUUREaWRWSngzRkdJWm14dHBGZ0hqVnlzUkFYcFBFRDB5?=
 =?utf-8?B?d1l4MjRDTGZTYnpiL3lOWU9TK2d4NXdBT0JydEh0S0NHVWFNeEhnajR6dEZC?=
 =?utf-8?B?MGZQazNWcXNTdUVjV2c2R041ZVhxNEdBb0tCOTZObDlybXFRQU5yMlJ4Tk5W?=
 =?utf-8?B?MEJNTGxMRGNEaFJUY1ovbFFHait1VXNCVzVoaEtsdUl3cEw3Q3FYVkFhSERY?=
 =?utf-8?B?SVhYMHNpYlNISzMxSmEvaTFBL0J5OTFueFM2TXBDVGU5MkxqOEs2OFJIajlT?=
 =?utf-8?B?KzZDTnNrTElVejczV21kSmZWbnZYMFg0SWk1LzNlWElySXpmQk1xMzNkUi9w?=
 =?utf-8?B?OEhIZGgrT3ZrYmVVNjZkZEJJYnh1MklhQkZ4VmtpVm13YUprVmZYSmdIelAx?=
 =?utf-8?B?ZEw5UUp6TG1MQmQyYkdlY3d2cmFiM29PWXU1b2VRcW9ybG00MGRwWkEyWDA2?=
 =?utf-8?B?VUUrTTE0Y1N1RHBVV1Z6MXFQYXlMMWZQd2NYUmp1MnJzcHNJZUlraG5vZklm?=
 =?utf-8?B?VHhucFIzUUZDT2dkRTk0MnM1M09GemE1bjNJY2RMbS9PQW5EclBLODNNWXJO?=
 =?utf-8?B?UWtKcUpJd1A5UDJlckpmTlRrVlRzWHNvYUZ5YVFHLzRtdUNkb1hBd1M4azVN?=
 =?utf-8?B?OWE5RUZhWC93bzV5N1p0VStuU3Y3K0xMc0VMSXhaRDZNVFVkWFBNVVlocG54?=
 =?utf-8?B?akNsaEZ6LzQ3R2MyS3RBenVPRnFTQVp5UHdFVlI0c05NTG1ybG5PSElOZEU3?=
 =?utf-8?B?UXEwalZBT252QWp3MlVXeGkySGcrbFI0NC90S09aR2t5RXF5ZjBkMDFiWHBK?=
 =?utf-8?B?UjRieVVNb3B5U3lwaklnN2Foc2E4VGdEQ3FnRzlBZEtJeVdIRzBEcTFNVkZZ?=
 =?utf-8?B?bHcvU2NRTHJFWkZJM2NWalVyQkhrMUl0QjVnMVBoSFBlb0YvVDY4a0ZnWXdl?=
 =?utf-8?B?Q2lwejFhcm9SeCtVcVgyNEdpdjREOVNSR2c3V010bmxZa0tHMlArYWFFYUp0?=
 =?utf-8?B?SXBNQVgwWmxPaXRvQjBJak5WL3VjNGNsZlZQdmJ4SHlDZlRxWGkwVWRIMkJ5?=
 =?utf-8?B?RFpZUytOVGxTUE16RE4zMWZtNjNPTFpIV3llOGVBQTZ2SFBSS21PempHSG5i?=
 =?utf-8?B?a0JwSDZ2Y1BVYTAxNkFHVmR6TkYvMmhSaGk3eFpyc3hQbytjdkZyWkNDQXpN?=
 =?utf-8?B?WW1HNU9kVVc5ZTVkL2VmelFhK3IyRW50aG54eCtvVU9pb0Z0OVE4bW1oV3FG?=
 =?utf-8?B?c0ZPWjlJUzgza2VKUHl6ZWF6K2xway9xNWo0WTFYOFJNTkxHSk5SOG56VVAr?=
 =?utf-8?B?aHhuQXVaaUJ5Q1RJOGZKRzFKeUdzWE0rZjVOL3VPSDZIVUt0OGFjMHFWSlA1?=
 =?utf-8?B?M1A4Y21YQmRWOVFrSDlGMnBPRWgxSHM3elFPeGptWFBDK29VZFNuRmZRbTRy?=
 =?utf-8?B?SHNPcTAvWE5RWmhMWVlYZjNUanlGOTY4U3owRVBESkdZcTM5dGFUVi9zUlJV?=
 =?utf-8?B?Z3hoN2R2THdSVVU3cGc2UWU4UGh0azNXUGpaQlhId0dwY3l4RWdRa3UvajQ1?=
 =?utf-8?B?UGFXaVZOdFZrcmloMXBFUVFCdmNPaU8vSlRFWFJCaXBVbkg2TEVmZGkxVnEy?=
 =?utf-8?B?UFdDQ2Z0bDJXMEdIeElTWUk1MmE2TUdqcE9HNlhXRi9YNkNNZkwzb0xxYzZo?=
 =?utf-8?B?bGF1Q2VLQmFvUFFOcldOQTRPZDRmY0RhL1MwU0k4Y2V6aUJwMEMyb3lrVW5t?=
 =?utf-8?Q?60LeSNiZIODlvWYITSl0/YZ9c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7af30b6-d5f0-4b9e-38a0-08de16d4a15a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:19:23.1940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjTzBJGpwuVLQijKVk7q8UAbAuAswPoJntvlCBigMw3FTj/KW8KQQHsJ1REd3Jss
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418
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

On 10/28/25 23:06, Timur Kristóf wrote:
> The VCPU BO doesn't only contain the VCE firmware but also other
> ranges that the VCE uses for its stack and data. Let's initialize
> this to zero to avoid having garbage in the VCPU BO.

Absolutely clear NAK.

This is intentionally not initialized on resume to avoid breaking encode sessions which existed before suspend.

Why exactly is that an issue? The VCE FW BO should be cleared to zero after initial allocation?

Regards,
Christian.

> 
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index b9060bcd4806..eaa06dbef5c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -310,6 +310,7 @@ int amdgpu_vce_resume(struct amdgpu_device *adev)
>  	offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
>  
>  	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		memset32(cpu_addr, 0, amdgpu_bo_size(adev->vce.vcpu_bo) / 4);
>  		memcpy_toio(cpu_addr, adev->vce.fw->data + offset,
>  			    adev->vce.fw->size - offset);
>  		drm_dev_exit(idx);

