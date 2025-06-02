Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A043EC5AD49
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 14:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2012610E523;
	Mon,  2 Jun 2025 14:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kbHWh4lk";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 684D110E2D3
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 14:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipP/itqR8pHd8wUXxVMTqWXWEth5pewyQ+u6x9jjFTQsUIyuPGQ8l/iud7PyS/EO4ouXgu5uauZsdo09PwpxPetmgrt/NVg83YZ8IjKgJWkRnol6gCtgW5ccxYtho8/1qLgaNumkmaJS625SC6w/nxU8wKb+V0rjAagAol0XnpcHo36oixe/yv8gwt26t96gmrHTbuD6KkZdTGR0IjwCE1S4fRT24hw2wnEKxAA4qObpO5Yq/jbHHv+8lqUy7fKy72+XE46ua28fAj7SRyqWDm3FunimIcKk7OprIf3iKupNwNUy/enARh/wXNZyohixvns0tKvpsHMIgkJDrfg6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUkhp+HZbMi/CKpxJGocIwX+LWTwZNJxvaOhQJe+T3Q=;
 b=SVQgXVWJg4N/YtdDMbXfrnK7XZSvbR3wSk3NWMy1P6c97IKOJmvb+oyYOzAM9ok6EBl+rTx3Cxb8cvn3W1eOrzCksjvp9+0D2Tn+vRjg02JXKDbGrYjW5poaRO86wCwQe3T1cyDfLNZgbPhqvztCazS0y5X3h6beHvlCEtG19QvGZza5iYYPxBgoFO091JRcKDPQcN1bYW4Zpa5qz05WQiWYtQsYQRha6A2PD9GcbPsNJtGz1XyXtwpGttWvRj1+2K8fl0b7lNKUWNKEejR1mPDB7fHNM89BPMt+h2vZxB6udZFqHuR4k0epFydPExbR/naiNuBuBpknZH/qOw+qsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUkhp+HZbMi/CKpxJGocIwX+LWTwZNJxvaOhQJe+T3Q=;
 b=kbHWh4lkXr23ZdInVhd7feWmwWKqIHWy/UIruvkQtpzCCz1cTsA0m0qbHpiA3d48JiCpOjpImAkngHW6QO8zpTZkYqpEMIsLXz2kW2+i/Psx9UmpOBgZoXxVHLZan+HS5vKALodsiT2pGboZAtyp1HOY9FUHf3L/rt+gj6i6u7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.36; Mon, 2 Jun 2025 14:22:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 2 Jun 2025
 14:22:22 +0000
Message-ID: <6d3fbac1-455d-45af-8139-644ba8cd5f9e@amd.com>
Date: Mon, 2 Jun 2025 16:22:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/28] drm/amdgpu: move force completion into ring resets
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250529200758.6326-1-alexander.deucher@amd.com>
 <20250529200758.6326-7-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250529200758.6326-7-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:208:15e::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: fe90d8c6-3864-4e20-a89a-08dda1e0e37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHdpMStjazJXMEE2RzhpbEJCaHlpRUpVeGhYSXhPVDBacy9RYWVPTkoySTZs?=
 =?utf-8?B?TWI5bllVRDhmVTA3aENFeFR1czVZckF1SFJuQXJPUVZnR1pKOEpVYmRWeFpn?=
 =?utf-8?B?L0V2citXbDd1VUpnbldNZERtRnVqL0dhL2RTZUQ5V2RqVnVVMXUrUStNUHBi?=
 =?utf-8?B?ZEo0cENNeEcyQStqL3FxWU82LzVwYzBZOHJDcW5lakU3Q1dXaHZrVHRYWnNv?=
 =?utf-8?B?OTk3SnQ1QkIyZDk1aC9Fa1Y1VkNmWGgyRkljU1dOQVdUdExheXN2V2dlTUVV?=
 =?utf-8?B?QUt0SFRBRStXU0dlQzkwZXZCMWZHRlEra05BOUE5L2IyeU0vQjVOM1dRQllH?=
 =?utf-8?B?UUZzcU5JdVpRN3ZoSFNBS3RiM0VtODJoVXdHKzAySWs0RDR6MGFzb2llMWVq?=
 =?utf-8?B?bENxd1EvdXgzeHJtVHlja05qVnQwTUFwdHI5VUltdFpEVzROQ1dQM3p6N1U0?=
 =?utf-8?B?V1d2TC9uTDBIWTYvS252QmlRVFduS1E5Z25uMFRBTHEwNW52dmhiN3o2ZURB?=
 =?utf-8?B?dENQSTZSSm9TZHQ3cGpPem5LTDVaeWx0SUpLZVkwNnB4aFB6YzdUd3grSTBM?=
 =?utf-8?B?Sy8xQ1A0YVc2RGdaZ1hvUHZjOHBiekNSZk0wZk81YzA0RVpaWHhaZFExZHNi?=
 =?utf-8?B?S2RyTmNONEtHd2hiQXZvb3h4VUtiWlNRTnp4emplamUybERKdE1PQnppSHpE?=
 =?utf-8?B?RjJ6VzZmUHZIQ0NJYysxMlp2ZzNRU3IzaTc1ek1VVTRXTm1Lc2p5NncyL3Fs?=
 =?utf-8?B?aE0wV2JwaVlvTHlia0l0SkQxcS82UzJsVUpJTTVRZ1QySnFqTHJ1M2hFN1lX?=
 =?utf-8?B?Q3BaNjNIejc2SmhnTU1WZG83M2ZhYThRdFVBM2FsdGUzbGQ4WkQxUFNyZ0I0?=
 =?utf-8?B?ekNLREx3WDdqdi95RDR5aUd2cTBZM3pHWGM4NUU5WG9iR1BCV25BYnMwclJ2?=
 =?utf-8?B?OFYwK1Nkb0JYMWw4bUppWG44Q1YyRUxFUUNyM2tsUTJWLy9mbEllODF4dzlZ?=
 =?utf-8?B?S0VxYlBjSC91S1l5QmF1Q1FsZStRWVlLUHZ3L1ZOdHNvQWRaTG5TbmJTamU4?=
 =?utf-8?B?eGJYTXRMS3VWdTUvQVpFdkRWcGI0OFNyQnBXcE9yZWFoZS9GSmRlcVp6RVU3?=
 =?utf-8?B?OHEyMkZqU0Q2eFpZYnc3V1VpSmoyM0ZyVUhDRVp5blI1N0VFZERIUDFDbmc4?=
 =?utf-8?B?L2Uyb2l1Q1pnaHIvNWtEZW44SXNGYzdlSStqdE1mTCtYTnRiWXlsRmxjcTI1?=
 =?utf-8?B?THI4RHNwZmNNamVwY1FydmZhV200VVVIY25uNUk3bUZwNjB5cHB0ZGlicmh1?=
 =?utf-8?B?UVByelFONkZVUVU3aFltYlczSG5pVEdyVmk1Q1J5dkN3OVUvYzU5T0hYcE9t?=
 =?utf-8?B?cFQ3ck8vOXhSQ1hneHFVbktzN0p2UVlkUk9jRlo1QUhCU1BhRzRRajlYNGNo?=
 =?utf-8?B?cTlYWjcrYS9rK1B6RG0zQ3I2MEVYRzV4cVpodVN1L3dtWlhlZ09kQWVLK0kr?=
 =?utf-8?B?cFc5UThLbDh1VmlRbVJsRDJsNll2NkRMNjVYc3ZtQ0lFdWV6RTcwVW13bkN6?=
 =?utf-8?B?aVhpdlpMNVZENXU0TFVsNFNhNkdMdzl2Qjl0VUtta0phWXZVY1ZUNDd4ZHQ5?=
 =?utf-8?B?cDMxYU9rTVJJZUt1cUZ3dFVjODdlZzNDVEpsck4zQUJwRHY2MldVRmcwOG1r?=
 =?utf-8?B?ajNzSCtJWXYxUlhmK0dBZkY1d08vS2wrUXlCZkg2SklCWmphM0JyZE16M1hx?=
 =?utf-8?B?K2lZSGJacSs0SEt3VkljcWZQZFNXTklKVlVVVTNhN0o5N0VrM1BubGl6THhw?=
 =?utf-8?B?cTVraldwOEx2a2ZwUHpFSGduSkRRNkJGOHRTMUVjWXNtSnoxdDNqVjRGVjlF?=
 =?utf-8?B?bTVrUys5TFdoOUNlVFVXak9RQklEOUFLalliTlcrMFFYdURMTU9lRnI3SWpQ?=
 =?utf-8?Q?dxE30qf11kg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0RhVy9LYSswck1yTGVUZ1VQbFhZQWNiZG9pWHNyemRhM2JSZ3czSDhsWjU2?=
 =?utf-8?B?ZkRCRHY0SFlNSk5OV2hyWnVwUzVPS3hmVzJHcm53VDNiRDZZUzZnVDBjTmE3?=
 =?utf-8?B?cFpVb0RsVU1RL294ZHh3OVpkcXUyNnB4ZWhxaGJ5Qlo0dDJSdHlHb3REYWdh?=
 =?utf-8?B?UDdpa3BvTngyeUFVeVlpV0x1WFQwU2VvSmVLU0VBM1N3QjlOT1hpV1J1cy8z?=
 =?utf-8?B?MEVObHdtdFpBd2sxMWFuMkg1L1I4cmQzUks4QlY0bkMzRXRZdSs0WVB4MmRy?=
 =?utf-8?B?ZnNiZmZNdUlqMkNUREVBbDlHVUtHMlNHb2syR0NuVTlmQyt6bEk0WXFiQy8x?=
 =?utf-8?B?NVo2WTcvYWhFWWwwWjh3V3I3dFYwUjF3YlVIN3l5L0lQN2thdVlNZmFDSnlT?=
 =?utf-8?B?Q0RnR2lHSE5icDljODEzMWtPYTF5V0VDSUVlVE9MZG1qZG1kSGtoZUlvVEJJ?=
 =?utf-8?B?YWpxRXBZaHBabEc4UHBsMnMzYVJYMHpCQ2VORllRK08wNnNWU1VQQ2hyUFkz?=
 =?utf-8?B?c1lISlZDenYwbzRSeUVOZHM4MHhHN1BEOTAwYmFRZlNUVUFuQzJ5eHdhQnlZ?=
 =?utf-8?B?TjN3VW5vR0Y1NlpGWFRrZnErQmZlVGFycjIyMkxKcFNOZnVzbVY0VXdneVBL?=
 =?utf-8?B?VFhQVUs2NER1Ni9BblBrdXFxZjdnWEQxSEVpaGwrMFR5NXhpQVQzOGpMVHlu?=
 =?utf-8?B?c1lQeFAwMnQ4a0xkWlNwY2xqQkI0S2xwSk9sOWxDRXkvNUpSRTBVZ2ZRc0Qx?=
 =?utf-8?B?am16WENJd1BxN1diWW1UV1Q1VnF0cmdXRis3OUZoNHd2NG5SSUtpMEJxc09u?=
 =?utf-8?B?QzZkQ2xEVEhVQ2FRVEV6OUdNU3oxa051OTZVK1hwWG9tbGgzdmU5MlBKRGl3?=
 =?utf-8?B?RUt0bHZkQ0U4YjJjc01udFQvRW9mRHVaZisxU1lMOEsvU1dVWXBqRjI2Nksr?=
 =?utf-8?B?Y1NIMW1VZVgvMFBnaTVkUHoxTkZhYVM4L1I0Rk1LVy9zWDUxOTVaL3J1UWVs?=
 =?utf-8?B?SG55dE1wdGp2Zks4RXpXVkx2OVVha1dVM1RLRVZ1L0NoNFFNZjRJVDJqVFdS?=
 =?utf-8?B?czdxc005WGNvMDg2SFlYRk1VOE5ScDhCV1VVdVNINGR0ejBOWnVSS1RHKzVi?=
 =?utf-8?B?NlUxUVZLbkpIb29MRzZwTUFnYSt5c2hpZkV2MmF4ei95L29FVGwxeHpkRHZ0?=
 =?utf-8?B?VXBHV090U1RiMUdtZzN1QWw3QTY2RVBtNlpQa3hPQlZLUVZVbjVhWXlmdy9u?=
 =?utf-8?B?TmQ1TzVYRWowR2cxRHVEdE1UdGZLbHZ4c3R5VjUwR2poK0dTbkJtL2RiTHFH?=
 =?utf-8?B?WnNKZXMvMnVuYzc5Vml5UGxKNUNQRjl2Zzk5TEdxYVVuaWprY0hETDE5MHlK?=
 =?utf-8?B?NTlXUGRRYkFtaWdmM3c3ZjhOMHpaL3FhWUZxZ1ZRNXdpdC93cDV4dWx5dmlK?=
 =?utf-8?B?YVdpT3JhRnl4NmwvRmZOK1NpNnlxbDVVS2xPSTdTOTJCbjVKRWtRSmxSUDNE?=
 =?utf-8?B?WjJ5RFlxeVZzQUFQY2VZSlE0TGZ3Q0k3OGY4LzBnSFFqVG4vV1BNaXdqbUpr?=
 =?utf-8?B?OHJKMHZaOUM0N0k4WHl3MTNUU0I5bWhldXJlcXpuVExtYW9pa0Z0TTVNVGlU?=
 =?utf-8?B?cnpSekdHUEl6Mmd2cmIwR1liVFZiM2syaGN6RWN6eW5LYW16aDJxakFLeHlT?=
 =?utf-8?B?RnRUY2N2cmt2bTFvVHBHdjlUMGpPZEtUaVZqeWpEOHltNTV6UXZiaEJXL1NX?=
 =?utf-8?B?QUhqM2VBRjJ4ZmdwUk5RdFFUZjliclM4L3JjSDFBeE1CQ3FlNkYwS0k5NjNu?=
 =?utf-8?B?amxjakEyaXQ3QjQwc2R2dkRBVGhpOTFJSnFUdDBaR1g1UXJ3MlBLRUI4dVdT?=
 =?utf-8?B?R3N0NmJYQmhObk9jSURETVdUbTdjNmdSclk0dUxoQTNWcGVVd0UyRURRQ2RH?=
 =?utf-8?B?OFkvVjg0Vm9kSXp0ZWFtSGM1TGxuZkxXQTQ4cXo3cWlBdG52STV4cThYMU9Q?=
 =?utf-8?B?NHd4TWlOOUV2MFVLdWpVWWpRbnhxY0lPYWRvbm5yVjZmMkhONmwxZXduT1Jk?=
 =?utf-8?B?TDNWNkdINGRTL3Z3L1RwVWJQNEpXZGw4Y0UrUml4WGdyVlp6RHRSRDA2N1I4?=
 =?utf-8?Q?9rXEhZaz4Wkidn1Jo31iwBLzr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe90d8c6-3864-4e20-a89a-08dda1e0e37c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 14:22:21.9623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzAZ3o+lRNdsirYoiNSJlLYT5EuDqd+ckrZd5c4fTX2m2LCISC3ZtgUO0Lq8QGUc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010
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

On 5/29/25 22:07, Alex Deucher wrote:
> Move the force completion handling into each ring
> reset function so that each engine can determine
> whether or not it needs to force completion on the
> jobs in the ring.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 6 +-----
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 5 ++++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 5 ++++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 5 ++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 1 +
>  16 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 0b9086a747c0a..a0fab947143b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -159,12 +159,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  
>  		r = amdgpu_ring_reset(ring, job->vmid);
>  		if (!r) {
> -			if (is_guilty) {
> +			if (is_guilty)
>  				atomic_inc(&ring->adev->gpu_reset_counter);
> -				if ((ring->funcs->type != AMDGPU_RING_TYPE_GFX) &&
> -				    (ring->funcs->type != AMDGPU_RING_TYPE_COMPUTE))
> -					amdgpu_fence_driver_force_completion(ring);
> -			}
>  			drm_sched_wqueue_start(&ring->sched);
>  			dev_err(adev->dev, "Ring %s reset succeeded\n",
>  				ring->sched.name);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 4cde8a8bcc837..336ca44950dfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -768,6 +768,7 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	jpeg_v2_0_stop(ring->adev);
>  	jpeg_v2_0_start(ring->adev);
> +	amdgpu_fence_driver_force_completion(ring);
>  	return amdgpu_ring_test_helper(ring);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 8b39e114f3be1..72d739e38a8ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -647,6 +647,7 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	jpeg_v2_5_stop_inst(ring->adev, ring->me);
>  	jpeg_v2_5_start_inst(ring->adev, ring->me);
> +	amdgpu_fence_driver_force_completion(ring);
>  	return amdgpu_ring_test_helper(ring);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 2f8510c2986b9..7974d04c15e92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -559,6 +559,7 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	jpeg_v3_0_stop(ring->adev);
>  	jpeg_v3_0_start(ring->adev);
> +	amdgpu_fence_driver_force_completion(ring);
>  	return amdgpu_ring_test_helper(ring);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index f17ec5414fd69..9301d0ff2593b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -727,6 +727,7 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>  
>  	jpeg_v4_0_stop(ring->adev);
>  	jpeg_v4_0_start(ring->adev);
> +	amdgpu_fence_driver_force_completion(ring);
>  	return amdgpu_ring_test_helper(ring);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 79e342d5ab28d..ef5075e111300 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -1150,6 +1150,7 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>  
>  	jpeg_v4_0_3_core_stall_reset(ring);
>  	jpeg_v4_0_3_start_jrbc(ring);
> +	amdgpu_fence_driver_force_completion(ring);
>  	return amdgpu_ring_test_helper(ring);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index 3b6f65a256464..858b930d1dd54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -841,6 +841,7 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>  
>  	jpeg_v5_0_1_core_stall_reset(ring);
>  	jpeg_v5_0_1_init_jrbc(ring);
> +	amdgpu_fence_driver_force_completion(ring);
>  	return amdgpu_ring_test_helper(ring);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 9c169112a5e7b..eb78bf04a490b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1670,6 +1670,7 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
>  static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> +	bool is_guilty = ring->funcs->is_guilty(ring);
>  	u32 id = GET_INST(SDMA0, ring->me);
>  	int r;
>  
> @@ -1680,6 +1681,9 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  	r = amdgpu_sdma_reset_engine(adev, id);
>  	amdgpu_amdkfd_resume(adev, false);
>  
> +	if (is_guilty)
> +		amdgpu_fence_driver_force_completion(ring);
> +
>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 9505ae96fbecc..43885dc04b632 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1542,8 +1542,11 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	u32 inst_id = ring->me;
> +	int r;
>  
> -	return amdgpu_sdma_reset_engine(adev, inst_id);
> +	r = amdgpu_sdma_reset_engine(adev, inst_id);
> +	amdgpu_fence_driver_force_completion(ring);
> +	return r;
>  }
>  
>  static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index a6e612b4a8928..ee94e457ee25d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1455,8 +1455,11 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	u32 inst_id = ring->me;
> +	int r;
>  
> -	return amdgpu_sdma_reset_engine(adev, inst_id);
> +	r = amdgpu_sdma_reset_engine(adev, inst_id);
> +	amdgpu_fence_driver_force_completion(ring);
> +	return r;
>  }
>  
>  static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 5a70ae17be04e..86ef0e30a89e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1559,6 +1559,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  	if (r)
>  		return r;
>  
> +	amdgpu_fence_driver_force_completion(ring);
>  	return sdma_v6_0_gfx_resume_instance(adev, i, true);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index befe013b11a78..c9993424b3923 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -823,6 +823,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  	if (r)
>  		return r;
>  
> +	amdgpu_fence_driver_force_completion(ring);
>  	return sdma_v7_0_gfx_resume_instance(adev, i, true);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index b5071f77f78d2..f1ccc6c7be390 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1977,6 +1977,7 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>  
>  	vcn_v4_0_stop(vinst);
>  	vcn_v4_0_start(vinst);
> +	amdgpu_fence_driver_force_completion(ring);
>  
>  	return amdgpu_ring_test_helper(ring);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 5a33140f57235..6ef5944584e56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1620,9 +1620,8 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>  		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
>  	vcn_v4_0_3_hw_init_inst(vinst);
>  	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
> -	r = amdgpu_ring_test_helper(ring);
> -
> -	return r;
> +	amdgpu_fence_driver_force_completion(ring);
> +	return amdgpu_ring_test_helper(ring);
>  }
>  
>  static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 16ade84facc78..1c13ceb3bed8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1475,6 +1475,7 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>  
>  	vcn_v4_0_5_stop(vinst);
>  	vcn_v4_0_5_start(vinst);
> +	amdgpu_fence_driver_force_completion(ring);
>  
>  	return amdgpu_ring_test_helper(ring);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index f8e3f0b882da5..a998708bc0745 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1202,6 +1202,7 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>  
>  	vcn_v5_0_0_stop(vinst);
>  	vcn_v5_0_0_start(vinst);
> +	amdgpu_fence_driver_force_completion(ring);
>  
>  	return amdgpu_ring_test_helper(ring);
>  }

