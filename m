Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64287C28B2F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 10:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095D610E303;
	Fri, 14 Mar 2025 10:30:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nyHFCVWO";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF4610E303
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 10:30:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZaRESyZdTiasBIEE+WNqaYtjTg2Ibd1YVXbKrw7d+UAoOAkMu3D0/R47nIaxfU0Rbyl7nzR09gpg3dB09mY8/g2hDaH8WDPA/vTYGPAXCYupn+nIEn5FtyhxGEVfFoJvDRVyTDFT2lR9cNXm6hfQVxwizO+ZwBj92RPSonUztobMv5TQ5SrXul7XlJNJxZF/0ThKedAr2SoSr8YS9ny4f9XwMFLqq+uTwq1N4IZn9GEGoesuOPWYL1Pv6F1+mIuqAW/bapkQpk6pYBvf6sG3keu9frTF3iNmRbY8zvSeLs1DZeIFADUaZHbXRPsslE+8o6R22cT5CnZyiZ8VhZqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roH+TNt79FwM1F98T93Ee6CCR3xMwvZ232/Vx2mU0Q8=;
 b=ar7tN5yava4skcG09vGgpXf7cAYkHTIMwNUQGk0N0YXEbcqH4NPVu2AlHN0ItMEIS8vrqEFTl4iSFstcqnwM1avPo8evFP0v+Rx6Nnj/L4M/nqQqSfr+Jssp0O0ip+2mih4F/AmtqFI6hF/0gKteLCJRu8eyTQGtiRQIuLyuMgo+vtuy1rNo5Uhpv6YLYK1yeoB9bmmV1Vw4iLgu8cibAjdJQD7cQ/cMwYErtyz3vKp84uOJGH32w75wnVI0xIQTh6HxH+qJtYpkFirmdw26+cQATAMxt8em8ZT0xxXpJqXEGt/2dTY+KYHJI+ZV/fb7cxYULffujY1ngEperP9yEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roH+TNt79FwM1F98T93Ee6CCR3xMwvZ232/Vx2mU0Q8=;
 b=nyHFCVWOmvJDPop2Wd21MzXNHTeZ0NN63VxJA9SR9IaZeCNqQdFjU6d85MJ5rylR7wFeUyJuRcsjbfyTI/hb2AiV5zkGt7RHf8auK44XJZy/X6WW9pITD2Xo0DssLcK3sktfmDd5+LsXwgD7Lm5Me/DdYc6O6LzsP4LeaDKpmso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 10:30:40 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 10:30:40 +0000
Message-ID: <d15f3b87-f6c5-4c5a-b7e0-e5570691d3ff@amd.com>
Date: Fri, 14 Mar 2025 16:00:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] drm/amdgpu/gfx: fix ref counting for ring based
 profile handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Yang Wang <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
References: <20250312141912.10994-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250312141912.10994-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0238.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: db67b02a-b103-4486-bc15-08dd62e3442b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2gzRDU2a0VnakV5UXNoWG4vU1Bna3BFeGhOZFZpamdrbjlITG5LU2xyRncy?=
 =?utf-8?B?UkJ0cnlzUmZBbmlBTHpHTjQrODV5MDdNM2FtaTBXdGU1N2k5bE5lNTRZc3JX?=
 =?utf-8?B?SHpTdHM1Tmh3bVg4bGgwdWxYRDVFZ1krSnYySmhlQmU1NC81Q3JBSndlejJa?=
 =?utf-8?B?YzUxdWhPUGtOcW9NdU41VFZHODZPYS9GQ0Q5REFaV0pkdG1CdFZCZEt1RG5B?=
 =?utf-8?B?MGdFeVFQTXVweHRrTTMvSlgyS2l1alJmNk1hdXBVRDVRcHJidWtIWGRlRGw4?=
 =?utf-8?B?ZzhVR1R5MUhkOTcvdW81Yy9rS0k4ejlhbE13T2pYZGVNdnJ2bU1LbWl2ZE1M?=
 =?utf-8?B?bjFqSFdSTk8wSnJhVFBBTTlZTzlKa0pxR2EzbHpUQUl3RTdmdE9zVWRibHQ4?=
 =?utf-8?B?b3g0YU8vYVd2RGZYeFVTTlNnY1RHOVpFMEI0dFl4UURFa0ZXNEo5S1UxM1B3?=
 =?utf-8?B?OHU5VnZJUndnQ2NOdGZhdWhaRk1kdU1WVHNDa2lkdG1aRmtZYUN0U1JzQUFM?=
 =?utf-8?B?QVQ1VHg0NTFiMnprNFBWaER6czlVNHJwOFRxWDc2VGlCY1VvNnNKRnBPaTZt?=
 =?utf-8?B?WUVGY2xiRW1aZ1FJbVlEbkpscGRqWmxGNXF4c29Yc1FsYklaTnF3dWZIN1B0?=
 =?utf-8?B?UUlCdGE5Y0YrRFFISzZBeUtiM1p4ZEpuamQ3MWJ5M3J3V0k5WFdiWG1FUFFt?=
 =?utf-8?B?UzViMU10TUZqMGgzSW85U0dZMCtXVGwrOGJlcmhET3ErbWxaUTJnRVkyMUd3?=
 =?utf-8?B?S0hEYVBvZ3dIZGRJZUphditUVDFGOTlwL3RPUEZ6Z2ZrMm1ZaThqWUE1dUtE?=
 =?utf-8?B?bmJJZVhLMG9yeFBCRTJWZUJCVU1xNEUwNE1WUk5rZXhVVlo5N1NjRDk3OUVK?=
 =?utf-8?B?U2M1QmovRGlDOU5IVHdWdFd4MFpPU1laclN5aS9xQm0yOHdXRVdkd1Bzb3hl?=
 =?utf-8?B?MXcyUnE3Q1k4MnFBWndPK2Z6Yk5pRHRTalliOWFqVG1BcVN0QlBxaWdwNHlU?=
 =?utf-8?B?aDBFS1J6Zkkyd3FBNTI0M3NBL3VkS0UvYStTUWdWWVJkSVlyNkRoNjFpRlpw?=
 =?utf-8?B?OG1WNHJhVUFEdWpqaEYyYlFMTCtKMDIwdjFCVXUvVVFXbGhnQU9SY3Z1Z3pM?=
 =?utf-8?B?SlBDRExJSTB6bUZuN1dmbnBQU1BoR3NuR2dZN2xieGF1cWFjUmE2MHlEK2x1?=
 =?utf-8?B?T0UwdEN0Y0xnTmVHQlRoVVhEQmpkTnZScW1YVFpMU0JQNEhGU0JIOFZ1Vmpr?=
 =?utf-8?B?VHFicGRHT3U5WGRjSVdLazA3R0J1dUxOd1ZRdXlRNlpjcGJLZFZwSWFXR1hO?=
 =?utf-8?B?Ui9HNHlQckRaR3EyZXNOUFRNSWtCemRYbXl2K1NIV0dLRFZvb0pmTmRmUTk2?=
 =?utf-8?B?cTl6aVFRdTVQS2Iwdnd5aEY4MjNGVTFsYWVDK3Q4TGZDZ3hoMU9sTDNsbnkx?=
 =?utf-8?B?TlRycE8wRkdrbm5rVVN1N1FweWMvUW5aQ01DWTJnUTd3RUNHMlIvMEUzbzI1?=
 =?utf-8?B?S1BmY3VncHFxZTIyZW9DUXZtdWY5b0xmNml4QTdEaDdNNkVaU3FkZFc1TVZp?=
 =?utf-8?B?a0pQY3dRTTd3dDZyWW0ya2EzZm51N0kwSUt0UnBGVjNlYzc2WURLL2NiblJ5?=
 =?utf-8?B?djhXTFNmVnlBU0NZWmRuYU1wMTBqNHpEWWRUTXRTTkJGZFA0T0ZSbys5L3pC?=
 =?utf-8?B?aFk0c2ZsazJnbUVpNlBmS096NE1ieGdTekw5WWMvc1M0ckgzM2VLbE5kR2JC?=
 =?utf-8?B?UXNIR1JYOEhicGUyMU56ZlZhSi9WdnNjQWVzeFVObTVSSm5GUWtxSFVQYmMz?=
 =?utf-8?B?OFhFOTlrd1psRzR3Q0RFMGNvM0wvNVZieVR6M01DTEM1cFU2YTZsc2xWK1ZQ?=
 =?utf-8?Q?DScGENTtb1Fkr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDdpeTFZQzZjZ0ZVVXJEcXAyTkdwNmJ2a1dlY1dCcFRTem9IRXc4OCtlTnNn?=
 =?utf-8?B?R0FuWWFWVjdnSFFaUkpTQ0tweXpLOEVJODVRLzdEY2RTWGJkanRJNk9vVm1j?=
 =?utf-8?B?S1kxb1hnN1ZGcDNrZWk0RFNvVnNpODV4cEN3RHFoOWJHMGtDT3dKRmJpTHox?=
 =?utf-8?B?djlncjJkdHhTTCtjRkduWGxEY1o1aWx1cDdneEJCcG5LbHkxdEVpMzdWT0w1?=
 =?utf-8?B?MVBPeC9ITGVMSkNMd1BLS1hlZk9jRi9FeWx2VUdUWUFGQ1lBemIreWpDUzBr?=
 =?utf-8?B?Tk9SckRkWFRuTlREeElWUTJPeTFyWVdOMWtidWJNMStrVlJmOFNGZUEvbW9T?=
 =?utf-8?B?T2xxQmFCK2ZWczU4MnhNNGZnK09lNWc3bkJjZy9LOFVWVnFLazIyQVUrKy9r?=
 =?utf-8?B?Z002NFY2b2VVNWIwYVRrQ3VFNWhib3ZpWVFyWmZtaGs2ZlRmUE5Ed0hOMXJk?=
 =?utf-8?B?aW13bk5RT3I2NHRjcTFjNFdFU3Fray90am1ZY3R2WS9ZYmRhVFNoRGJqazVa?=
 =?utf-8?B?amlyRDhuK2JZSmZ4MmxERXhtbzRUTkh2alJ3OURnazZpQ29kTnUzQ2Z5UmNt?=
 =?utf-8?B?WlZZa3ZRZ3crdmZVbnpzY05ud2pMWS9KeEMvODFzQXkzVDVNRVlPWWxlSGRZ?=
 =?utf-8?B?bit5UGxJU1ZNQ0IzRGgvU1pTTzhBUWFBUFpxcDdZUUpjVE1kbld1NmhIUlFo?=
 =?utf-8?B?dDJ0S0RGY3FOZWcxMWVSY0F4UVlUNWJNYTlQNUt2bkFBOEhxZkVTZGZnaTNn?=
 =?utf-8?B?cHRtcS9pUjZYMFJKSm9ZTVVTSUN0enEyZFFVUWR5N2xwMFpnZDhMZzd4ZEVt?=
 =?utf-8?B?YUNEamNhMytVUmFoWVJSamlMSUpWQzZYMW8yMG0rcWlET3k2Yzl6a1NNNW9a?=
 =?utf-8?B?ZHdCYXFGOGRTN3dBTkw3TDZwN2MwcHpLMDRqcVZEaDdCOG9rU05INU1OUjdK?=
 =?utf-8?B?SE5vNm1MazQzTGpFWVFucnJFTXdneFFiSmh5YW9rUm5QQTI2NGlBKzR2R21w?=
 =?utf-8?B?aGJmZTVPQkRucXFFR2JReE1SdjNQaFFuSTlYUWU2LzF2a2tQUEkwUmlhZjBT?=
 =?utf-8?B?Rjh3UlZIaEhoUHZYWlQ1Ny9CL0praVRZc2dvS3RXejN1czVJRFdNNVhSbDhG?=
 =?utf-8?B?TFRQc09yamdBWjVhcGxLWmhPeDdHcE8xSWVhZEVrdTNWOWFROTdTWk56M2Mx?=
 =?utf-8?B?ZFZ5QzhOSmd6c3MrWW5rMEN5NFhvZUJXUFpEUmJjUGw0ZGFBWS9qbXRUaGlN?=
 =?utf-8?B?bFpTZXZ1YnNzRkRRTTVEMHpWUWFyRndPUE9IYkJ2UGQvenMrbzZLaG82bDhq?=
 =?utf-8?B?ajZXai9yUFRUbW5IaE52b3JkWkZZSU1vUVUvRC9OTkNiSFZDSktOS0VBaFdW?=
 =?utf-8?B?R2ZzWjliVWhCS3BuTUgxWElFeUEyb3ZDYUg3dU5rdmFUSmROWXpuL3VNeVpN?=
 =?utf-8?B?TFpGVDczRWNHa3NjbG10UkE1eXBnQTg4R3VDeWlZbDQ2KzJLNGIyTld1ckVY?=
 =?utf-8?B?cnpFS0t6ZkkxcSt6dWlvM0VMdUR2c241aHI1RHU3TDZUUStNWEFydjMvWmRU?=
 =?utf-8?B?cUhPR3hZU1QvVXRtVG9xYnVmaVJPeUVGbDdQMjEwUUp2T2g2aGUyTjVtUFl5?=
 =?utf-8?B?Skg2Q2U1OTZybVIzaUtwclF2NDlhc00ydXgzVjRzRFFmc0pma0RHS3Awd1Y4?=
 =?utf-8?B?QUtHWnB0ZGNuQ2k2R2FOL2V0VHJNWHh4amYva1lVUG1vbUJZK3FxYWlVKzZW?=
 =?utf-8?B?cWQ1R2w1QTMwVG0wSFdxeWxOZ3QxSU5lN28vZ0RqbEJuaG8wTnJMbVREUmU3?=
 =?utf-8?B?L0RGdmVpaFZRMm95VU81Q3RaaVZKcFJybUR0Z2pJdlpHdm5wUWVlUXY5bDRU?=
 =?utf-8?B?UFk3UXV2bkV5d3RJa2Y5aXZQeWI5STRLUm5SaWkwRU5XbmduMlpwS2NENW0r?=
 =?utf-8?B?TlhROWUvd205d0R4cDZvWFBVNTVHa1VrM0lMZ0pCNFBPZm01Ukdxc0QwVWVt?=
 =?utf-8?B?Zk1EREwreGd1S3F0TVdzWVE2WW4zWTZPcndwdHFXcFB3cXFlUmxCTm85V3hE?=
 =?utf-8?B?UzhMUUlHY04zY3NNemJ1SDZYQ0lPM1lnZmNVTVN4K1JiSzFQd3BmRVJJV3dP?=
 =?utf-8?Q?dZFOwZ8YhSEvHvoPNmBAIFlUU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db67b02a-b103-4486-bc15-08dd62e3442b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 10:30:40.0752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euWprzj000ZYGQtbyLpG6lhF9K1gOix0x8HRtTeqOga3u2qdd/uC+Mx0bkW9XzlE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744
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



On 3/12/2025 7:49 PM, Alex Deucher wrote:
> We need to make sure the workload profile ref counts are
> balanced.  This isn't currently the case because we can
> increment the count on submissions, but the decrement may
> be delayed as work comes in.  Track when we enable the
> workload profile so the references are balanced.
> 
> v2: switch to a mutex and active flag
> 
> Fixes: 8fdb3958e396 ("drm/amdgpu/gfx: add ring helpers for setting workload profile")
> Cc: Yang Wang <kevinyang.wang@amd.com>
> Cc: Kenneth Feng <kenneth.feng@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 30 ++++++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
>  2 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 984e6ff6e4632..099329d15b9ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2160,11 +2160,16 @@ void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work)
>  	for (i = 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES); ++i)
>  		fences += amdgpu_fence_count_emitted(&adev->gfx.compute_ring[i]);
>  	if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
> -		r = amdgpu_dpm_switch_power_profile(adev, profile, false);
> -		if (r)
> -			dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
> -				 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
> -				 "fullscreen 3D" : "compute");
> +		mutex_lock(&adev->gfx.workload_profile_mutex);
> +		if (adev->gfx.workload_profile_active) {
> +			r = amdgpu_dpm_switch_power_profile(adev, profile, false);
> +			if (r)
> +				dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
> +					 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
> +					 "fullscreen 3D" : "compute");
> +			adev->gfx.workload_profile_active = false;
> +		}
> +		mutex_unlock(&adev->gfx.workload_profile_mutex);
>  	} else {
>  		schedule_delayed_work(&adev->gfx.idle_work, GFX_PROFILE_IDLE_TIMEOUT);
>  	}
> @@ -2184,11 +2189,16 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
>  	atomic_inc(&adev->gfx.total_submission_cnt);
>  
>  	if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {

I guess this has the same problem as mentioned in the earlier patch.
AFAIU, this will switch profile only if no idle work is scheduled. If a
begin_use call comes when idle_work is being executed, there is a chance
that idle_work completes amdgpu_dpm_switch_power_profile(adev, profile,
false). Then this would skip changing the profile.

Thanks,
Lijo

> -		r = amdgpu_dpm_switch_power_profile(adev, profile, true);
> -		if (r)
> -			dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
> -				 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
> -				 "fullscreen 3D" : "compute");
> +		mutex_lock(&adev->gfx.workload_profile_mutex);
> +		if (!adev->gfx.workload_profile_active) {
> +			r = amdgpu_dpm_switch_power_profile(adev, profile, true);
> +			if (r)
> +				dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
> +					 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
> +					 "fullscreen 3D" : "compute");
> +			adev->gfx.workload_profile_active = true;
> +		}
> +		mutex_unlock(&adev->gfx.workload_profile_mutex);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index ddf4533614bac..75af4f25a133b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -483,6 +483,8 @@ struct amdgpu_gfx {
>  
>  	atomic_t			total_submission_cnt;
>  	struct delayed_work		idle_work;
> +	bool				workload_profile_active;
> +	struct mutex                    workload_profile_mutex;
>  };
>  
>  struct amdgpu_gfx_ras_reg_entry {

