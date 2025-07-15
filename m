Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719FCC83F1D
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 09:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE1710E1F1;
	Tue, 15 Jul 2025 09:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aKQhUUZW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF1A10E1F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 09:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIEfhh7TRodDyM9cmkXHT7k05il78mEQRCU9e4UEVxhJ0ThdZPZ21io9+fFRdu4zBGokVTlIUuUSkjnMtSmxYNdBAsZv705npfV7CP2b5zsw5XBAfUYufbi5V6IbVYOR/uQJVpWxoXm/06V1S/yqijAylxUXHvVhXpnBbuPavur24m2m+tLSl/YHcsx8Zd0MVgo/A4qrhrO49Jl7oaxQtTTMU1SAneaSIDBcaQbzigbH0sb715mGq4lrJwDDQZPNbUMDfcXHBHNMfvwRPfNvGSbC1FL+lSNcUjbFRw1aS0qjceaWIa+UDMle4InT1Jmzy5kl/MLlA8b8v3x4Apg9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfqymjFd9GNp/CrtL18RiwIsRdKLGx1b9KdPzb34FpE=;
 b=LcqGq0bAn2d3fIg/qbuF9MPfrJXe0CqrEzn7NiFLdsuUKuiCdsfEqEMavaZXlou3RczjxiGbkIEKdbQhSnQaNajhpNhL3zzfPsUCQ0XFrxX+A2o7l7XNDdpocQfeWSeGEBk11ykLHkgwv4oknfLYbAkqxalj9WIUmDLTICYieZSVVQhAZ0INhlDrj3+1BO29BCXWw9vLpB3/IBeCFtw/R2THT+Yew0i9TUUYPoARSRGMu0gLsAM2BKA1H6rdRcC13YTlmteZbg3l/tXemQGNyRRyVi3Qm0GBcMTPTEbj7ILnEryJwFobmfwubg0WmmTjGJSr+yARHwvVHzjbVsAGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfqymjFd9GNp/CrtL18RiwIsRdKLGx1b9KdPzb34FpE=;
 b=aKQhUUZWeOJb4y+PezsFMtfhKwaTmVMCchEhZhAnUb9mnogQaZ2MmPBhwUUv56MvSLYOEgp2DpmwVUWkUsAbf6UmI5AZzCVgXE5k1hYf+kX+Vfd9wP8OPXkD6fyFsKtS1DDrwbvzp+etCkeUCW4ywpGZGuxS3B3eEK8sYmeh0a8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS5PPFC9877909A.namprd12.prod.outlook.com (2603:10b6:f:fc00::661)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Tue, 15 Jul
 2025 09:49:36 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8880.023; Tue, 15 Jul 2025
 09:49:35 +0000
Message-ID: <bfbc0f0b-22f2-46c0-83f0-91a199ec1a5a@amd.com>
Date: Tue, 15 Jul 2025 15:19:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Increase reset counter only on success
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20250714052218.1523140-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20250714052218.1523140-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:269::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS5PPFC9877909A:EE_
X-MS-Office365-Filtering-Correlation-Id: dc0f525f-07b7-4aba-74bd-08ddc384e808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nmd1cCtwYzV2NmxHc3kwcjViYmxYSkNvangrRHFBNkcrbVY5U1dBVkNqaVB6?=
 =?utf-8?B?V1VRL2s5VVhyT21OYVNOTnRudzVON2xwVVBRSXo0eXhCd25hOGlqbndVMVR5?=
 =?utf-8?B?L1FVN2U5aWNrZ2QyZVBPejNOOS8wdC9YYkRTbWFzMW5kMUNyMHQraWovZlVj?=
 =?utf-8?B?cmc5UzBuajI3YjZrejhFMGdpa0FmS1lZV2tPeUdTQzFqZ3dKVzVDR0hFVEQy?=
 =?utf-8?B?M0JibUxMTXpIcnBRMHoxNklCMEVQQzBHNlBWU25yWE5kOXdWMlovc3k0MG9H?=
 =?utf-8?B?QzRGMThZdDlDQWIvSnBNdGFMK3NkTGtuVjhuQjU0cGExMDdxa05uanZLQm1i?=
 =?utf-8?B?dDh0NDZjMVJsV1N5VU1uekQ2OFJjb3QvQXNrcTBwQmtvdlcvMzFMNHBkZDQy?=
 =?utf-8?B?bUxNTEZxWFk2QXpvYldsd1gwWmdtWmhxbVZmMmZxTDhjZEU2a0c4a0NReGFV?=
 =?utf-8?B?MzJnZ0RDN1c1QmxZVElMMHJzQ2hhcFhUUkJRMFhpNG5UbkRHNThwMWNyK3E2?=
 =?utf-8?B?bWYrSUVmRW1BQ0FoLzB4cHpLQXkveDdaWlFIdTBxRWxLVGNQcG1qYnhwSitR?=
 =?utf-8?B?Und4bGlKTmdaTU55SzhyY2R3dXZIbzB4cGtGOUVVVVpvZmR3TC9MZW8vL2Ux?=
 =?utf-8?B?V0lPN200amUxZm90WFFRZ3lTY2ZOQ21aOTN0MXVYN2lTQjZHSFFlWjllNFVy?=
 =?utf-8?B?U0I4ZDMrVlVBTXhWaURBWGlQdEYxTkhwVXFSQVJKQ0F5VjRYS2dVd0x4TTJp?=
 =?utf-8?B?VXVBaFBpSHRYcW5JUG4wd0hiT2crVGU3UTZhendvbGZ0dExaaTRLMHdVZWN1?=
 =?utf-8?B?dHE1d1dCUzZXR25xYjlTV1FidVp5bWwzWVNQU1VZRzVkcWMwL0dJcVVvcWpW?=
 =?utf-8?B?MGIwUEdHT0tYVTNLUjdLVS9sQ3NPLzd2VUlXSDNUVWgrcGE1Q0E2VlMrTTY5?=
 =?utf-8?B?em9xSFlobmxpbGZJMGFydXNSdW1jZnZKZnVUdFZjbGtyN2lxQXlCSFlPOCtm?=
 =?utf-8?B?czkxdzZVYjJLZ0l5TGZhVmRBYVphNlB4TCtOWDZUVHlrNHdTOHVTbzB0NTQ1?=
 =?utf-8?B?T3lQTlVDUDZ4RGR4MWhER0ovSnVrdXZQRGdrdmhjN2g5Q28vbUxka1RpVnhm?=
 =?utf-8?B?ekpKY09PVUlMVlB4TGhRUlFpMGVORkVsOXdtODVVMHlQQlRPaFVUODQyd3ZE?=
 =?utf-8?B?eElNSXpRdWZPNm9vZE1Eb3hKUUdvRGx2S1lLZ3UyTklNc0pkRUtTRUNtY0dH?=
 =?utf-8?B?ZThyYVpBYnlCdEdqTDhncWI3SG12Mm00TDZETFFudzF5OElRdEh4eTQzc0Q1?=
 =?utf-8?B?TVlRdDRPRWh1ZlNZVmFtWW5DODcyUWV1a2ZBRmtDYjF2WWpESHJndEs3b3F4?=
 =?utf-8?B?UDFEcEh6SzRUd3VvZHFCUkFvaU5mcmJiNE53SVRHbCtqK3VEL1JZVUVpaEEv?=
 =?utf-8?B?LzRPdExFQ3QzbzduVGpaMXhJVmdrN3hMTWUzZEtZRFFTdlFkcWdlU1l1SzVt?=
 =?utf-8?B?VndwODNqY2E0L0ZJNW9WWE91Q1drSGx1THJ5Y3RsZVRFQUt2NzlIZEtQZVRw?=
 =?utf-8?B?WTgyNVA4UUxNRXZXYVdBY3NGbG5Nbm9lRGs3V3JOcmhaYWdXcWVod3luWS9h?=
 =?utf-8?B?VmMyN2JSeDdTR3lYVG42dUhTUkRpOXMwWHg5VmhUSXpFZlRyVTFWVzM3MU90?=
 =?utf-8?B?Y2dtLy9nenluM1Yrekl2TFp1MHhTcEF6TndLMk5jVjgrdVpqYVdtaytlOXR0?=
 =?utf-8?B?MGI4c3JCalhLeHl3a0xHa0dWS0N3dk9Xek1LNEVYb3FMOC9keCsyckZyb21s?=
 =?utf-8?B?Tk5MZEFFcFB5M0VacmNFL2pEMzhUdzZtelhzUUpEZTQwL29wKzlvQVZUbCto?=
 =?utf-8?B?Q3hoam0weUpPTTEybWpHUmwyY0lDVFZZUS9YZEdiekgrZWQ1SzJtK0FUUWxl?=
 =?utf-8?Q?wk513ASuzMs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b09ZMVZoV1EyaS9LM0QycG1EbzQ3TzFXY2ZQdVFCc1Z5NkRZb0tPSCtBWVNp?=
 =?utf-8?B?TkcvZEh2cng0eWQrY00yRklrTU85KzVJMVRET0dTdFJKdldFY0JzZTJBSkJG?=
 =?utf-8?B?bEdMcHFMS2FLWWo4QWFPUUxVRnY5YWhuVzFmamFlUTh5T0YrNC8zZVM0TmNt?=
 =?utf-8?B?TUxDbXZWRFRjUEFDNjJybVR3OVAwWkFSa1FHSE9NMElQa2pqMGJEb1Vjc3ov?=
 =?utf-8?B?NmNkdFY0aWRBNHhNK2Y3QlVuMTNMQXcwZkFVRlUzamdRYzZNZE10NHYvUnRD?=
 =?utf-8?B?Vy9rdUZKWnp5U3hrdm0zanpKNzZFaVE5bFlZSjJGUEFjSGJ4dFpyUU1lV2FW?=
 =?utf-8?B?TkdyZGlvTEtLZjNVZnc4U29UYk14SVBWVTJJY2FlOHBoV2xZczRpb2pNa3F4?=
 =?utf-8?B?SStEV29ObFpQMmZ2L1VLZTNobUw5Q2dNcHRRMDY2bkZycVQ1WFh4bzJRLzNM?=
 =?utf-8?B?MXQ2bUZJeEpkUjFqaVVESlg4aUZTVjg1Rmp5dUFLeDd2WXNpVmNyaDVJVHlx?=
 =?utf-8?B?OHRBWXpTTUlBaEd3SXpoaVBPQUxhUU5ML3V1a25QRk8vWmI3UVJGdzBUeDRv?=
 =?utf-8?B?cDlyK3RJL0EvMDJLVXJzRDBLbHM0bUZiVEVERmJpaVowWkJwRHZUYXd2NGpz?=
 =?utf-8?B?RWFWbFptSEZmNXJpYngraVlzQ3FwLzZGM1FrRHUyeUpBQWVhNVV4YXpuMVNu?=
 =?utf-8?B?bDNSYjI1L2paeTlkR3hzZDZOZm9oSmQydmlaYUxYKzBrUFBKdnJqWWgybDUx?=
 =?utf-8?B?azBKN0RsWGg4SVJxWEY4c2JVb0MvTGdINDVoeENIWkJBdmo0bENvZXREZ0Vh?=
 =?utf-8?B?RlFmMW8zMVhrVU1ZajBsdmZVNklKZGVTdStyWnNxSVRZOHc1LzdLdFI3Umly?=
 =?utf-8?B?ZWdTLzBzclozV0szbFNtVWRuZEVmUHVsN1A2eFU3bGJLTDErZjJ3Wnc2Snh3?=
 =?utf-8?B?T1FUNkhDRlFxTHh2MXIwOXh5LzVCUlpkeDZWOUtaY3IwaEQ2QU1OL09QR1Zv?=
 =?utf-8?B?MHZwUkdsMjZsWXAyQmxnSWErSnZSSklFb3FubUN2K1FWbk9QSDRXMm5FZHRk?=
 =?utf-8?B?UlZ3TUUzZkN5UUpNd282emFjM3JEdVhnN0pxSjBMaWN0UG5oOHZKVHQ4MVVB?=
 =?utf-8?B?VG9nVytpMEJPRmlTTzZYWTl5VzUvNWkxVVVHb0E2YVF3bGs1NWsxbWdWL1BH?=
 =?utf-8?B?SWV5bDM2ZlRxeHBaY0U3OHpNM2pUbk9CcjVKcDJJVk1ZSzBlZlNZRXZjd05I?=
 =?utf-8?B?L1J6bGZIL1ZySXltV1dyVzlyNmFOTDFHQnloQUpUVWdjR09GTXgwSWUxWkk5?=
 =?utf-8?B?dnJWKytXakF2NlMvTlU1a28xWlR5R2ZMekVEWndrWm91Z2hJQkNuL1pnZFBS?=
 =?utf-8?B?VVNlM2FQTk1sd0Z4dFFpa3cwQ3pnVUd5dWZtbUVaNTBUWnF2ZDVGMmsxVXVE?=
 =?utf-8?B?MGpLb1I0ZDgrTENDeU5qVTMxd3IzRWl6T2NMVGVvVFFRT1ZyaVFaSTZrMkNw?=
 =?utf-8?B?dmlWVGVwRGJhUjFibFBkOExLUkNRdThyVGwrckhKeWY1dXZHclpkLzVwM1Rn?=
 =?utf-8?B?QnJYLzZDT3BSUEZZbVZwM1ZxZzNzdndidXpGdWZaTEo1ZnN0R3hsL2JpTXEv?=
 =?utf-8?B?c1p4Tk11cVBpeHQ3OTU1SFdHT0haQzBXc2svQy9jMjNnM2l4OU9lRUcxSjRL?=
 =?utf-8?B?K2pSVFlMV2Y1OWlqZzIyc2EvQXNpaVRGV2JXNklDZCtORFVpSU50UkYrT0Ev?=
 =?utf-8?B?ZXpzWVdJNTErakFkWEJOSFB4RUxBUS9lSTYzdUIzbGtHWmhIdko3MFlDbnlX?=
 =?utf-8?B?YnR2R0Y1UHBsUnJRUW5BbFovQmVYMjhkRTVwNGw4T25GaUFhTWxTaVQ4Zk9S?=
 =?utf-8?B?V1I5anhjdEN6Y05kMCtLWmM4dTBZbTN0UmIvbXV5eWZ4R1A4Y2F2SVZkTklB?=
 =?utf-8?B?UmM0ZmNEOE5XdHFUeWNKaURvV3pMdEJTenZaS25SOTd0Zlg4alVwb0lldTRP?=
 =?utf-8?B?WHVtcCs1SHVnRHFSYmtKVzFuM0pQeWNsbGQ4U1BmRGRNZmVTOWJ1TEc4bG5l?=
 =?utf-8?B?bnI2M0FPTm1GUHV4cGQ5SDdLekZDOVE0L3ppTHNCSFdrR2kvU1BkOUJhNmV2?=
 =?utf-8?Q?P/TW9mmluADk28h5Ahe2V76Br?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0f525f-07b7-4aba-74bd-08ddc384e808
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:49:35.8394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mILraCY/0F9/3SqKDBZRWINKsI/M6IiF3TKIfeL4ucvZ8QEs3lSg1iv039CpwcjU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFC9877909A
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

<ping>

On 7/14/2025 10:52 AM, Lijo Lazar wrote:
> Increment the reset counter only if soft recovery succeeded. This is
> consistent with a ring hard reset behaviour where counter gets
> incremented only if hard reset succeeded.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 426834806fbf..6ac0ce361a2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -427,6 +427,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
>  {
>  	unsigned long flags;
>  	ktime_t deadline;
> +	bool ret;
>  
>  	if (unlikely(ring->adev->debug_disable_soft_recovery))
>  		return false;
> @@ -441,12 +442,16 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
>  		dma_fence_set_error(fence, -ENODATA);
>  	spin_unlock_irqrestore(fence->lock, flags);
>  
> -	atomic_inc(&ring->adev->gpu_reset_counter);
>  	while (!dma_fence_is_signaled(fence) &&
>  	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>  		ring->funcs->soft_recovery(ring, vmid);
>  
> -	return dma_fence_is_signaled(fence);
> +	ret = dma_fence_is_signaled(fence);
> +	/* increment the counter only if soft reset worked */
> +	if (ret)
> +		atomic_inc(&ring->adev->gpu_reset_counter);
> +
> +	return ret;
>  }
>  
>  /*

