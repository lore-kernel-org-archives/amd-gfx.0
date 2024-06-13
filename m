Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37110C27C4F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 08:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD55710E980;
	Thu, 13 Jun 2024 08:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yCN5rHvb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8519310E980
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 08:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qzw7gL1MGoTrkR10WOJxrz6dWXUig0agVonh7WV0bD0CkgiwSPh263j0uwsAvtVTHmIJfd0HdeiHrDPVvXfoRBHeho0CemUbR6AUjjMUdciKwY6KvU4FdcBQqNP2y4yTPkFU1tdxXLFp+0gtuJFsT34plzaHEnk3J+n9jRrzfSkZrrXpG+MDYG3dkABfrSY0bWobo1CHEpI6PgSGZDUnnMpwLotESOjStKm2RVHdODoCpvlnnp6eWx1+9En3nj+OX2++8kimIeyvnNOPf8mTA8g9XZCf/XlVOKqpOWwwSZ2Cy8BGa4FsN1srsXO+b097ixdssUX5ryXtcDEuPn4gAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlOLaEQflm7Pobv4Mi7dolUwVxUOy9Wxi9JnpM1+17s=;
 b=Qm9aqU4TW9RGQTfVFikx/EeRitmJWcK/UqdXYxbuzb2r0BqbrS+NxO60P03vyiTX/Fhh+rhw3z4nBdh9vPPZLt8xIVjGSXpKfMgV766KQYJpzhhzU5ONoy2ajWkSKDShH8f1efxhY3h4qGXNMMySUt7y+o91u8Xk7AnOp8XQcseqTp20o1hISvtuaFt65iFfCJ1nqu+88Wroeg2PM+S83Ky///VkV181U4MyadIDq0fksoMV9tyGrxOlSsuuDQdqGgPK69ze0d5ygJdQVF+Ds41zd+S+lUi1BNaAGEW4SyfLrbRK+D8sJl0GjB0OD5JgUMzGvC7WkxTexfF5FRCeBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlOLaEQflm7Pobv4Mi7dolUwVxUOy9Wxi9JnpM1+17s=;
 b=yCN5rHvbklZGSxJkR0EBXMekAYHIdIGVXns+KKazi+3mHydAsotDnsRtuPhyTg+zXNHYhfJNZsjOFS2GIvQRunvxP1eE0CD2JWHRfTHtNK7xD6898b2rU0pt1wrgsPN5rQdEDZgaSBcwSp2yfLTtf3Pn6f5OxYOnx/RGRgaRoAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.21; Thu, 13 Jun 2024 08:11:26 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7677.021; Thu, 13 Jun 2024
 08:11:26 +0000
Message-ID: <4acda2ad-5eb5-44d2-a5f9-ab70eaa94a89@amd.com>
Date: Thu, 13 Jun 2024 13:41:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu: add condition check for waking up thread
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, Candice.Li@amd.com,
 KevinYang.Wang@amd.com, Stanley.Yang@amd.com
References: <20240613022504.81787-1-YiPeng.Chai@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240613022504.81787-1-YiPeng.Chai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe4ebec-1edd-4496-51df-08dc8b806bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rm1QWll2ZTB4Z3NXRmVpVlBiQmFIdnlTKzBJMmFNOWNhUkdOY1A0WGNSWVRj?=
 =?utf-8?B?QWJzemF4bVczeitOeVJrSG1iV1RSbXd5bVFhUUhneERwWnB3cG9qRFU1MWgy?=
 =?utf-8?B?eTBFUk5mMnQxb1drdmFqUEpXa3BBa1JFbGlpWmFDOFR4aTVZWnVyQjVpd1FR?=
 =?utf-8?B?YkpOaVhKTWVMK2MxK25TTGc2RHFlRDVSNGNnU1NFekJsZU9EcnhGM05mUVY4?=
 =?utf-8?B?T0FvbXo3QmQydExCU0xyZmk5NmR6b0VaSmNJVXI2d3lWaWd5VnJNVXp5MndG?=
 =?utf-8?B?M3NPQnZZR2xQSXlJQVlWcXJ0ZGl3MldBN0xsVUhyUW92dDZXaHROem5pVC9T?=
 =?utf-8?B?VUNHOXBtTldUR3VRNXF1Y1BtZXRnTWlYaWpHK1pZY2FBRTUvYk03ZUVxRXhN?=
 =?utf-8?B?K3hoMFU5OGZQbmFtamtSVjlWVS9GVW5aZi9CVVk2WGx4K2JMWFovSjhQUmJU?=
 =?utf-8?B?MGVST2NlcUNuR24wY2lBOU9yS0U4ZVZuVUlDNk81aXJWbGs0bnV3TVVRR2hF?=
 =?utf-8?B?ODVuL2lpS0JzenNJNEFUQis5ZGt3SVFtbmYvejZrTXg0SDlTTU1OYUFLWXM0?=
 =?utf-8?B?QVRjR2ViR09HNm9XQmFDSmJDUjd3NmFZRHN1bEsydkhZOE0yNDdoajNsU1Jy?=
 =?utf-8?B?SkcyRm14bE1teTFPRDA4N0x0c2pDTFdheVhlMjU3S1VhMEpyczcrbk9wMmFz?=
 =?utf-8?B?MVY4VTgySDVxM3NadEtqYXMya01MeUxzbWNHRDU4SWNmMlpmejJuY21GaENk?=
 =?utf-8?B?akM0VkpaSFM2NXVqOXphd0pzbFNQMm9qZyt4eHlLNzFwcDdPeEYzc2pTZXpQ?=
 =?utf-8?B?WkU1M2svNkZLZGRldTR4cjBLSmU1eEhtb21mNm1pRVphZks5STRUREo3UzhD?=
 =?utf-8?B?MUZ0eXFWMWZWK3VESVIzNWpOVk5Kb1BJQnZUNFo3MTRhbFc2a1M5N2xWR2ds?=
 =?utf-8?B?Szcyc0xRQWFkcmc4Sm9vaFZ3NGd5RzlEQzJRTzRPYUpyRHhkTHVQWE03dGVV?=
 =?utf-8?B?VUtVU3FZYjI1VldISTVnNUozZ0s2RU1GZjdHaUhNbnJCQkkxQkM3eXo1SVMw?=
 =?utf-8?B?UHAzRWtoclVwc2tBZEVRMjlVNjlFNjQydlF1OHZ3T0pWSWNMdXl2cTlWa3o5?=
 =?utf-8?B?bC9VeHRMa0R3N2l3b2cyU01kMWVYUVNoM3cvRDhPYjVCVkN4NVZrQ1dDUlZ4?=
 =?utf-8?B?T3IrZnkxbE8rU2dSeG5NSzE0am9wV2hzb3gzQmdycEorY1NndVhKT1oxTThN?=
 =?utf-8?B?SkdPeGR2c3FVSjhWWVdvZGhVQVFsRjNKdEhsQzBGQVkyaXZnMjRXRzZPcHRB?=
 =?utf-8?B?YW9PZ1JVMml4V0Z3clo2M3BQcDRVUGgzeGorb1ZWWWwvOGY2L1Y3WTIxZnlo?=
 =?utf-8?B?UTJuV2tmTmtpdEE1SUwreURuWDcvc1NwZjE0V0lvWXBNTkFBQXhrckRiK0NC?=
 =?utf-8?B?eENIWUtzN281NVl5Y3pka1VrTWZINGNuU0diS2JhVWphZDN4KzJyZWMrSnZX?=
 =?utf-8?B?SDhiUlRoU1c0NzhYTlpZQ1RkSVoxa1hsdnhhTE5lR1graTZvWDkzUm5tZWFH?=
 =?utf-8?B?dUh1Yk5BQUpEZm5lNWN3UkJtN1pnOVFtY2VCS0VZcHZIWkExenNBOFFwaVRI?=
 =?utf-8?B?RHNjaTI0Q25GbnQ1cU1zell6WmI1eFkzQnR6OTE2bkdFWWNsL2VSeXlZODJm?=
 =?utf-8?B?MSt1RDZWbkFXSFdmQnNwNnQxTDlzcFlsNGYyaGRKSnMvbUZJS3hhQkxXQjFw?=
 =?utf-8?Q?DWEJpzkoHTxW//kT+5wwIf6FAbsNFFbBbWrpIHz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(366010); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk4rdTBUZFNwb3Nsa0JvbW9hU3crWTJkNDRPclpnMmV1SFVmL0hRYUJrcFNH?=
 =?utf-8?B?UEhlNDRnWHdRRFBvRnNQK1haNEw4blVoaWwwRkNTVGJvYjdsRUJOOXB1OVY5?=
 =?utf-8?B?SG1pdjlQR3p5U0VIWWx3Kzludi9XZExuSm9yeFFVbEt3ampzK0ZNR1ZpeS9B?=
 =?utf-8?B?ZUwwaXlUZkgyOCs2aGowK3plUlkvdVh5Vmk1VzlMRGU0VTV6bmI5SnBGd3cy?=
 =?utf-8?B?S1JkQWc1Q05ISUVBNWJ1bnNnWDRhekVZVXBzaVZDQ25NSmVQU1ZlNGttcmtS?=
 =?utf-8?B?aW9XV3FvdGVDdzhYV2hualNidzVHZkMyOGgzbzF5bGpCOFdrRmVKOFAwYllE?=
 =?utf-8?B?cHR2cTVZT2VZbFBHZ0N1azRLWmhwUll5UDExOTVBbFgyR0JXb09pRHhYVDhX?=
 =?utf-8?B?cXlZcGtIUE1BL0hpYXpUQ2loZE9oQlZtdUJ2TWt2cGZ3OHBPZ1FBekNCM0ZK?=
 =?utf-8?B?My9sSjNhMUE3TGdkWHlxN09xMkx4Z1MzeTRLQm5nMUdZZ3dvTFhLSVpIU0Zt?=
 =?utf-8?B?RDIvYWdQMDFHM0c0NHpXMW01U2NyMk10eFdMejJBby9OSmZxSnFpb0JHdGZB?=
 =?utf-8?B?TDI4aUVwQ1RGWXhybUVwcFA3dXIvQWQ3V2hNYzZCY1JwaGsrUXdOV2NpS1c2?=
 =?utf-8?B?RHdTUllmVm0wQUtsWFRVTytNa0dhS0tVY3puSUZqbGh5dlVhWEh5dkV2ZHM5?=
 =?utf-8?B?YWtXWnMvYzcwcjF0Z045ZWlPRXlvMzJIL1E3Sy80S0lkaXVxZisxYm5EWkky?=
 =?utf-8?B?Q3VGbDh2U0E3T3FoWUdQSkRhUlR5YzFXVFl3MXp1V2o0Y0d3YnZHVngzT3BG?=
 =?utf-8?B?d2wwTUhob082MndKUlhOOWNySWZwQ3Zja1EvZTJEaW0wTUd4a1l0a3N4Qnho?=
 =?utf-8?B?dlA0NGdaK1BGaEVjaFpLYUYxVkJnYnVHd0Z2VHFITFNhNkZyL3BzK3dMQ3FP?=
 =?utf-8?B?MUV6eEVEaHFKQ2h3M3ZmRHE4SjFwMjdPempPbEtoQVNqVWU2YWZWM3kvZnNM?=
 =?utf-8?B?TGxDaDBlV2xuYlhUUUVYNXM2S2lmMk9RbERyREJPdHhZZTVBSVhWc3RTZHFx?=
 =?utf-8?B?RFVKWkNjeDJTSml1MGFmbDh2dWVKS2l1eSsrSmFUaDdhQkQvN29TRE13bHFU?=
 =?utf-8?B?Y3hnQWwzVVhVeWxUWFhzdjEzNGVWUTNDeTZUV29POVY5N21tcWR2ODBKZ3A2?=
 =?utf-8?B?Q1hDZHNRcEE4cy9IQ1lEcFFXUXJqTEVjNHd5K0l1YUFLNUVhRVJOWm1wcllS?=
 =?utf-8?B?cXE2MWxXR0pJWnE2SFk0MnpkdStYUWxlSU9mbWE2cXdhVGthcStoa2tCTGZw?=
 =?utf-8?B?ZVQyRUJGS28xSmcyc05hNzJxVDBoVFFXWmpoMzVVRHQvbGZQNXhLMmpuNjFP?=
 =?utf-8?B?aWlFKzlEeVU2SEY0YWlDU29idmdteDhBMnc0UWVZY1dpSzZkYXh6NWJZdjE4?=
 =?utf-8?B?bUVlSzZyb2Yvc3FMbitwOUc1K1FWNjVLd2ZySGtHQzdLQjJ1LzNSZnJxWWEz?=
 =?utf-8?B?aGIrZVVuOG9nTnZOdmpCV3pnNTdsdkpTRWg0Q0NOVEZFY3ZHeG1JRklVZG1r?=
 =?utf-8?B?OHJZbFRFaytSUE1mZmJtUTN0bXFNRG5MSzhFQlVGLzZuZTFmU2kxRkErTndh?=
 =?utf-8?B?ZWpSY1FJUmt4QlVxTnkwL05va3VKeDVzRFFBOFpUNDd3dS9wM015L3ppcnNq?=
 =?utf-8?B?b0VOSndBRmtMNU1YUGQ3NVQxVGcwLytDck5KS1dNaWVmZzRFcEpsT05PbE1W?=
 =?utf-8?B?QUk2SXR6MlYzMkxsVEM5RkIzR3Z3cFYwWXZZLzlIMWZVdWJzMUpGRDBKUWc1?=
 =?utf-8?B?QlllV2hidEhKY0JjV2pBWjJrM0oxWE9VTlozVkpvckpydkoybDNJb1IvZTMw?=
 =?utf-8?B?aSs4RCt2ZXJ6a0VILzZJUmNsc1FkUGgrTWgxRzAyUUhIQW1BamZETDRSQUdU?=
 =?utf-8?B?K05FWXNySEJjaGpqM1p1SmVTNjgzQWxSNkJVTnJ1VDlTWEd6d204WGxLVk1q?=
 =?utf-8?B?MUpOaEFlMllwdnJ3SzUreHprYU43MzJzUU1VY2U0UkxHUFQ0Y29RVW9zc3d0?=
 =?utf-8?B?V0Nia0JpOHljc1B5UzJ6TWIwbXozZm1wTzQzTjhOc1NzazNZWGlsWnc1cXpz?=
 =?utf-8?Q?/ybz8SD5R6ENIAf9U55hAUnj9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe4ebec-1edd-4496-51df-08dc8b806bf9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 08:11:26.6869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sl2PgCCCHwKQS5CIA/cCFiTNUdzrAve9z+atcU5Rqqi/LgQI37HeVpSlqstD0Pv3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766
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



On 6/13/2024 7:55 AM, YiPeng Chai wrote:
> 1. Cannot add messages to fifo in gpu reset mode.
> 2. Only when the message is successfully saved to the
> fifo, the thread can be awakened.
> 

I think fifo should still cache the poison requests while in reset. Page
retirement thread may try to acquire the read side of reset lock and
wait if any reset is in progress.

Thanks
Lijo

> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 18 +++++++++++-------
>  2 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index d0dcd3d37e6d..ed260966363f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2093,12 +2093,16 @@ static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manager *obj
>  	if (amdgpu_ip_version(obj->adev, UMC_HWIP, 0) >= IP_VERSION(12, 0, 0)) {
>  		struct amdgpu_ras *con = amdgpu_ras_get_context(obj->adev);
>  
> -		amdgpu_ras_put_poison_req(obj->adev,
> -			AMDGPU_RAS_BLOCK__UMC, 0, NULL, NULL, false);
> -
> -		atomic_inc(&con->page_retirement_req_cnt);
> -
> -		wake_up(&con->page_retirement_wq);
> +		if (!amdgpu_in_reset(obj->adev) && !atomic_read(&con->in_recovery)) {
> +			int ret;
> +
> +			ret = amdgpu_ras_put_poison_req(obj->adev,
> +				AMDGPU_RAS_BLOCK__UMC, 0, NULL, NULL, false);
> +			if (!ret) {
> +				atomic_inc(&con->page_retirement_req_cnt);
> +				wake_up(&con->page_retirement_wq);
> +			}
> +		}
>  	}
>  #endif
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 1dbe69eabb9a..94181ae85886 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -293,16 +293,20 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
>  
>  			amdgpu_ras_error_data_fini(&err_data);
>  		} else {
> -				struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> -
>  #ifdef HAVE_KFIFO_PUT_NON_POINTER
> -				amdgpu_ras_put_poison_req(adev,
> -					block, pasid, pasid_fn, data, reset);
> -#endif
> +			struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>  
> -				atomic_inc(&con->page_retirement_req_cnt);
> +			if (!amdgpu_in_reset(adev) && !atomic_read(&con->in_recovery)) {
> +				int ret;
>  
> -				wake_up(&con->page_retirement_wq);
> +				ret = amdgpu_ras_put_poison_req(adev,
> +					block, pasid, pasid_fn, data, reset);
> +				if (!ret) {
> +					atomic_inc(&con->page_retirement_req_cnt);
> +					wake_up(&con->page_retirement_wq);
> +				}
> +			}
> +#endif
>  		}
>  	} else {
>  		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
