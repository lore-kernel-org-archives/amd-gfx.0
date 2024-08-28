Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019B8C5474A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 06:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF56910E4B0;
	Wed, 28 Aug 2024 06:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KgVQDKN0";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C104F10E4B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 06:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFXqZYv8P/tk9hJ5u1xtocgRuK0pwf5hWg9G3OGMwMWXJ+MrIjrDGKdyCk+lDykBSYr9CzWODyjPLL5SDDE5M9iRajHhDD1lL9yXaM0P2gSky4s8J82plPy8p2uZBsi0vDY7AGZdAAysFOZCz80H7+3tQLw+KRPJvyZPMWc2lo1JL40DUtKgmuOKAZ3NJtStiRaShB3tbh34qZ+qYPCYNcsFTzVZpu0fbL/e8zY+zz1Zlg/RKNoocBhRu+HUazW7r33eBjImNQ+2fTGp3//5fO6c5z3n4nhT24WbtcVfS38LVh+6RPzOlZtoUZ76Ke1vscqrOGgQW44zLUYKku6b3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFrLcKqc5FNwhCSwAPGtm+OIyRDZiQ+ud6F/R0Hy5zc=;
 b=rB1VCm3Yoi/W5vNjHgFim5/AAFYz4/n2rofCbqnpd6myBJU0BKWXpi10TaP+cTu+dNx4U4khevZnl0Hd+CuwrxHhOuW6ClhFzVQQYTP4ZrQrWPrC9HdkzgJ6IZMqZuonC12VCtQGn421UqUEQ08ll6XNQve8gDjoiDVGELWOhxcEAl7jj4sbNjk0o6iIao235UKRxmvSyeCIR7/TdA+w/2ieakyQ/gPm2FJaAce9elIWHJGCOwnPsqHQQz6VnLdOJgAQRylQV+fR/iB0SdzjvJ5Kg+FxbpMi0peEQcb9GbvqjOgx6QYTPVPqYZZL+JmFITE1RRtf/dtN9WY1UV1LOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFrLcKqc5FNwhCSwAPGtm+OIyRDZiQ+ud6F/R0Hy5zc=;
 b=KgVQDKN0tDink8aqLxlD0c5f8pyHIU9CnY77Qd7gkBnRCR83Fj502q63i9oIgwTRuGSfJYzjdvILVmHCBR+lRd3SvyKZVd5cKlaDyRxyrjBqYTskrDDTOtBCLEXXFRXGvJE4bZKRzxxXiwH66qyyCN/mmvVhT5BihnxVNPyHy6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 06:44:44 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 06:44:43 +0000
Message-ID: <4de381fb-71c5-4364-993b-27666b7cfa29@amd.com>
Date: Wed, 28 Aug 2024 12:14:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com
References: <20240828052004.2889428-1-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240828052004.2889428-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e3f03e-c792-4b08-cc76-08dcc72ce616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bk4wN2FFUzBjUkxSblhsazJadm1HazNzbk1rMWFDV1N3SjN1OGFLeWFBRGx1?=
 =?utf-8?B?Skd6MHdyZUQya3NlWnBIMkw1OEdTaHROalNQamd4ODVYREwwb1gyZUZMTzdt?=
 =?utf-8?B?RjFHMS9XRWpnbnFyR1RjVlhOclRTbExVZWpXeTFaaVpTTit3QlY3ZFdsMzVD?=
 =?utf-8?B?OVFPdDMvUXQ3ZmxodFZjZ1pCc2g3NHhHNUduc010L2U3SUJSYVBWZXM2VE9G?=
 =?utf-8?B?cENVM0l1VTgyN211UXhQQmVwWXgxUlRhajNJWjdPN0tjRlBFN3E5cWhkZFE1?=
 =?utf-8?B?OXp3Y3pBbDNEZEh1RTdCV09wS21lYVhTUFVaSFpScWdreFNiRXZOVmlVZmt4?=
 =?utf-8?B?ajFoWlU1MVNVUE5TbENLaXh1KzFoMmM5SGFXMi9iRCs2TjViRTE4dWVRUGhv?=
 =?utf-8?B?WXhkRzI3T1Jmb1c4K1dKcG1CTmRyaG5OSCtYcjdKVno5YklnNkpUVnBWOVVs?=
 =?utf-8?B?UmJyUlpxaW91NWkwUUY0MzgxZW1oaFJCZzh2cllRc0FQd2dSWmJZVzNGRGo2?=
 =?utf-8?B?TE5uQ1lWcDQydnVEREhQMHpRbzQxRjc0NG1DaklrQldZUDljUjdvNkpnOGM5?=
 =?utf-8?B?NWZBdklJdlNyTFBaY2xvU3BPdFpKdUNCay9CdnZEaG9GSjNVcWJTVzN4UTFT?=
 =?utf-8?B?T3RoblIxTVZHQ2ZveXBaZWNFdExzTVp5d2JjSUUyYmlEdDBNVEFkVVhERCta?=
 =?utf-8?B?Z1hUR1kxekRRN244cm9QRHh3MlhRbzJuNDVZYVhIaVYvcHp3aEl0ZzdGcEVB?=
 =?utf-8?B?T3lWN2NYaXlPa0xnL0EyU2dkN05zaEN3Nktxcm1hWng3RENNd3FUUEJpZ25Q?=
 =?utf-8?B?YTBxNWJWTllGYmozRlU4ZXYwZFJxNmlncUJlSG1Edk1rZUE5Nk5OVVh0N0dn?=
 =?utf-8?B?Mlo4OUl4WlhkMDY3cGZsdlQrR0ZNc1ExOE03akZJa1kzZ2xDeHRUODQ1TWhZ?=
 =?utf-8?B?aEgxN3krbkNBUm1hQ1lTaUhOU1k1RWZhcGpkZTd1OUdBVUxyMmpId0R4THpo?=
 =?utf-8?B?OUZrcHFpMklUQkxqZDE1dTJxcWgxbVZzVW1ab1RGeFdsOXRCTEdwU3k1Z1dL?=
 =?utf-8?B?ait4NFdSRU5ENzR1ekZhbFhzTHZ4YXBscGo1WjI5MzNpT3AweG5aWDZKKzRK?=
 =?utf-8?B?b2UzU2w2NUtnOGJzSXdCeGxCUjd5RnpMSml0b0pmNFIwSmlRM1JHbytLRnJQ?=
 =?utf-8?B?QSs2N0FwUzBoMjlGbTBVMnM0amswa0crMHZXSmxxZ0FTclVLM2phYlJMRjMy?=
 =?utf-8?B?WnFkaEk1aWJGRk5qTkg4dXc0SzRrdVZlOUxJZnJPcnpTcERQK09TL2R3NFl1?=
 =?utf-8?B?TzA3WEN1Yk5OVWJnei96emxKWEk0VFJGUHg2TXBDM3N1bmFYZ1p0L1J1R0VT?=
 =?utf-8?B?THd1YkxyMXg3cFhncEo0bU1GR3FBaFA2d0Q4VXRIWFlodkI4cnA4YnFnZHNL?=
 =?utf-8?B?UkF3SVB3ZTJsQ1MwOUR6QjdwazNvcjBWbUs1SWVQUWpVcm9Wek9vVENWWlpi?=
 =?utf-8?B?VGJhQUhMSm93dndJTWFvWk9RSEJsd2ErT2kwekpBaENRSHBVRHB6dmN3dmNq?=
 =?utf-8?B?eE9sNXJsYTBXak5oTE0vcmR4ZHhWU3lETHBNenkyZit6MjhzTXYxTVhScjVu?=
 =?utf-8?B?RVVSbzZRM28vQ1BMSlFzcGhINnUvdjAvM0cxZWdORmVCR2tFM1lrbVgzaSt2?=
 =?utf-8?B?UzlDKzBUZytOQ1R3UEE1YlozTFN5ZWNOeHpwV2xmcXdlVlVLZHhRWUsrdnND?=
 =?utf-8?B?bDhLdDcvNk1FN214M0MyYWVuaWkrMXV0dG9mSzJETjhJakhBSGhPUmE5ZG10?=
 =?utf-8?B?UFp5cVJ6aUpqVUwwdHZCdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjJJdkNnbjNVdVpwaVdqVjJCaXBUTG1WS1gyT0pRcHc1TGZ6UjFoT3pkOXpN?=
 =?utf-8?B?akVnVnRYY2hxRTdreVVvN0p4dHBDYVRtRUFMZkl2WUg1S3F4Mkt5dm5ySm1U?=
 =?utf-8?B?YWdDOGZiQjhxN3hzUEcvUW5EQnJHa3p2Smx4UUVwSzRlUmttWWhSRGhwNzFV?=
 =?utf-8?B?ZHlnUzZVTzdVaTBXYkY0NzZvNFMvZ2QxQVV6cm1SZnlwZnNWRzk1U3JOWk5U?=
 =?utf-8?B?ai9pZEkvbFl2T2lqemIwK1NUc00xRUNBYTBYZU1pTTVMcC9uRnJRUmhVSFRs?=
 =?utf-8?B?N1FNUWhCSVVVRmNKc3dncVUySnZGTVB2ZVh6NmEyVE5yNGNGcE10VTFYUlY2?=
 =?utf-8?B?V1E4UzFCTGkrd0pSWWRsRHRkTUdJTmJMdnJtSTh6dURBS0RUdWxnVXd4MzZk?=
 =?utf-8?B?b1pCZU5TRk54Y01sSXYzVjNpS0VPWFBaRnN1NklkM2gyMDFUbUVFMlorRFRx?=
 =?utf-8?B?TTB6VjdKWUtVWW5KNFhMT3hqbG9tUTNqbkhSemFGNWNaNnR4Uko2OGxqM1I3?=
 =?utf-8?B?NXdJTFFyT2dZR0RhS0NUcFNWSFh0Y0NKYzlmVXREbE9NUzB2NXh5ckRaTjVI?=
 =?utf-8?B?K2NiQUdtODRpNzlXMTVuQm9oUDhaUExZOWxzZUhGWURSOVBlTEo4QlgzR2ty?=
 =?utf-8?B?MDlLZnJpQUNrMHpYNWNBN1orVDRzbXhocnZZUHBSUk1FUzNTN3dNTVNMU1dz?=
 =?utf-8?B?VlpIZ2QzRmJ2TDF6dUhJVmFDd1RTWmIxZjlIVDlERW1IWFBBb3dMUnFkMmFM?=
 =?utf-8?B?bXB2RXhqckNDKzFqVnJlY0d5a3IzVWxkVFpuclNON3lCOVAvVkRrMWttVmdo?=
 =?utf-8?B?dlNIWjhWbmszWkVHTUY1YkFveEJuRFc4S3BwMW9kc1FVT0NGc1gvNEd5TTRN?=
 =?utf-8?B?a0M2dFpITUVIVnRUS2dKUndhVlk3WkNxWGdMeDg1REplWEVnYndFbksyL284?=
 =?utf-8?B?MHdsbkJGc21NR25NUE8rSjRHeG11dXVkL2dCRVh0WHFIdWpFcUJ3YmsyZTNX?=
 =?utf-8?B?cGhiT3hUemptaDkvUUppeDF2RlErZ3NpYWcyay9TTm52dUZ3bjJJdU9PN3pP?=
 =?utf-8?B?TW12RHd4WjJUcXB5bm92OFRBVlFqUWpUckRWN0RaUERueGpiNWNEWlpOOExK?=
 =?utf-8?B?RDJUMnE4Y0lUK1dWSGZmODhNdW13b1podHl0SmVDVnR2YjR6YWw5TlozTThU?=
 =?utf-8?B?Y2RKQ2NBcGlObC9hOVBVYjk4eFZ3d3NtSjVUQTE4aFFjTG1Od3BXMzI3N3Ni?=
 =?utf-8?B?R1JTWUhndlUybTJQaGRzY1NCY3h2YnB2T2FNbnU4YkVkOWNTU2Q4eU5zNENy?=
 =?utf-8?B?V1AxWEpsMVFsank3RTZ4SEQ2TFgzVmRUcThRTllnMEZqU2R2SnlQbzNNZVNy?=
 =?utf-8?B?ejJGTkJ2eGgwN2JqNktsZGxqL1UrWVc2N1JuMWZIRHBiQnI2dENLOE5LTUZE?=
 =?utf-8?B?a1FhSElhN3cwVWtrY1NHSTRYVEV0RjRnMUZpMXIxenpwemQ4QitTZkYxTUZx?=
 =?utf-8?B?aTZvTEVJZU45OURQdnhXNHBnK09MM1NRU2VEQWVqZ205cHdFekY0UnBTeFo3?=
 =?utf-8?B?c0ZtWXlUM1ZTcDlJS2NNMElOclo3QzIzMkxLSG9DWW5kQXFELzlnUlVlZnly?=
 =?utf-8?B?Q1JsVTJ2TDZZRDZ2ZldUOUovSVZkcVlDQzhwZGlsc3lTRTlGVU0xOTdDaXJS?=
 =?utf-8?B?dHNtQjl5VllGQW5tUEs3V25qVjNEVC9OcXoyV0JqRWJkQTM2ZmNIWUFUODhC?=
 =?utf-8?B?cTVqbmNBbTN4RS9MWGJwQXM0dnowT0pQNFpweHU2WmdOLy94N3dCSGt1WUpF?=
 =?utf-8?B?TmFxQmNXY0tmM01HZXFmc0IxYkJJaWNDWmdYWk5wUmh5TysrV0lDTUczT0t6?=
 =?utf-8?B?c3p1NE5vazlsc1ZqT0lsVVlNZitkUXdXSE0xM0daWnZLbHZXTWxqaGNLMzVU?=
 =?utf-8?B?T1JUTGQ3UlI2MjdscVFnUlF2ejBzYm55Vlh4WEt0bWNyQ2I0aDFpWWhJT0l0?=
 =?utf-8?B?R0UxL2tlcEcrWjFoVWR1c1dHckxKSkNEbUc0TzhEZXJpakY3MVd4TzRBYjBy?=
 =?utf-8?B?MnNwUjY2MTByR1RpMHpleWdQU0p3ZnlNRXFQQmxJS1RLNlZ6czR6Z2VwU0dY?=
 =?utf-8?Q?ty3CGxlScKtDxqxQxD+5QUNrp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e3f03e-c792-4b08-cc76-08dcc72ce616
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 06:44:43.5955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/rglwv4Epif2H+TiMosVq+4fIQWR5SMmEM21kpEIgDHId/cRWuBeu1WQI7qbjyV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433
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



On 8/28/2024 10:50 AM, Prike Liang wrote:
> Implement the compute pipe reset, and the driver will
> fallback to pipe reset when queue reset fails.
> The pipe reset only deactivates the queue which is
> scheduled in the pipe, and meanwhile the MEC engine
> will be reset to the firmware _start pointer. So,
> it seems pipe reset will cost more cycles than the
> queue reset; therefore, the driver tries to recover
> by doing queue reset first.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   5 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 139 ++++++++++++++++++++----
>  2 files changed, 124 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index e28c1ebfa98f..d4d74ba2bc27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -143,6 +143,11 @@ struct kiq_pm4_funcs {
>  				   uint32_t queue_type, uint32_t me_id,
>  				   uint32_t pipe_id, uint32_t queue_id,
>  				   uint32_t xcc_id, uint32_t vmid);
> +	int (*kiq_reset_hw_pipe)(struct amdgpu_ring *kiq_ring,
> +				   uint32_t queue_type, uint32_t me,
> +				   uint32_t pipe, uint32_t queue,
> +				   uint32_t xcc_id);

Missed the addition of this callback in earlier review.

The implementation below -
	Doesn't use kiq to do a pipe reset. It's looks like a direct hardware
reset. Passing a kiq_ring here or defining a callback in kiq  functions
doesn't look required unless a pipe reset through kiq is available for
other hardware generations.

	Also, it uses pipe reset as a fallback when queue unmap fails. So the
callback eventually is not used.

Is this really needed? For the below implementation, it seems a private
function like gfx_v9_4_3_reset_hw_pipe(struct amdgpu_ring *ring) is good
enough.

Thanks,
Lijo

> +
>  	/* Packet sizes */
>  	int set_resources_size;
>  	int map_queues_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 2067f26d3a9d..f47b55d6f673 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -166,6 +166,10 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
>  				struct amdgpu_cu_info *cu_info);
>  static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
>  static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
> +static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
> +					uint32_t queue_type, uint32_t me,
> +					uint32_t pipe, uint32_t queue,
> +					uint32_t xcc_id);
>  
>  static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
>  				uint64_t queue_mask)
> @@ -323,6 +327,7 @@ static const struct kiq_pm4_funcs gfx_v9_4_3_kiq_pm4_funcs = {
>  	.kiq_query_status = gfx_v9_4_3_kiq_query_status,
>  	.kiq_invalidate_tlbs = gfx_v9_4_3_kiq_invalidate_tlbs,
>  	.kiq_reset_hw_queue = gfx_v9_4_3_kiq_reset_hw_queue,
> +	.kiq_reset_hw_pipe = gfx_v9_4_3_kiq_reset_hw_pipe,
>  	.set_resources_size = 8,
>  	.map_queues_size = 7,
>  	.unmap_queues_size = 6,
> @@ -3466,6 +3471,101 @@ static void gfx_v9_4_3_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
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
> +static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
> +					uint32_t queue_type, uint32_t me,
> +					uint32_t pipe, uint32_t queue,
> +					uint32_t xcc_id)
> +{
> +	struct amdgpu_device *adev = kiq_ring->adev;
> +	uint32_t reset_pipe, clean_pipe;
> +	int r;
> +
> +	if (!gfx_v9_4_3_pipe_reset_support(adev))
> +		return -EINVAL;
> +
> +	gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
> +	mutex_lock(&adev->srbm_mutex);
> +
> +	reset_pipe = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL);
> +	clean_pipe = reset_pipe;
> +
> +	if (me == 1) {
> +		switch (pipe) {
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
> +		if (pipe)
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME2_PIPE1_RESET, 1);
> +		else
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME2_PIPE0_RESET, 1);
> +	}
> +
> +	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL, reset_pipe);
> +	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL, clean_pipe);
> +	mutex_unlock(&adev->srbm_mutex);
> +	gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
> +
> +	r = gfx_v9_4_3_unmap_done(adev, me, pipe, queue, xcc_id);
> +	return r;
> +}
> +
>  static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>  				unsigned int vmid)
>  {
> @@ -3473,7 +3573,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
>  	struct amdgpu_ring *kiq_ring = &kiq->ring;
>  	unsigned long flags;
> -	int r, i;
> +	int r;
>  
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
> @@ -3495,26 +3595,25 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>  	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>  
>  	r = amdgpu_ring_test_ring(kiq_ring);
> -	if (r)
> -		return r;
> -
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
>  	if (r) {
> -		dev_err(adev->dev, "fail to wait on hqd deactive\n");
> -		return r;
> +		dev_err(adev->dev, "kiq ring test failed after ring: %s queue reset\n",
> +				ring->name);
> +		goto pipe_reset;
> +	}
> +
> +	r = gfx_v9_4_3_unmap_done(adev, ring->me, ring->pipe, ring->queue, ring->xcc_id);
> +	if (r)
> +		dev_err(adev->dev, "fail to wait on hqd deactive and will try pipe reset\n");
> +
> +pipe_reset:
> +	if(r) {
> +		r = gfx_v9_4_3_kiq_reset_hw_pipe(kiq_ring, ring->funcs->type,
> +						ring->me, ring->pipe,
> +						ring->queue, ring->xcc_id);
> +		dev_info(adev->dev, "ring: %s pipe reset :%s\n", ring->name,
> +				r ? "failed" : "successfully");
> +		if (r)
> +			return r;
>  	}
>  
>  	r = amdgpu_bo_reserve(ring->mqd_obj, false);
