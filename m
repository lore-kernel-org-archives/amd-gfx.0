Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C763C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 19:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E59B10E5FD;
	Mon, 10 Feb 2025 19:24:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="seainbDA";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCBE210E5FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 19:24:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+HCPC09m5tbumXkC2Xnn3AdTTJKHu56bbtTfDcsJYxFxWMAQorZOuVWFbzaIzXO0V66JMMRaiKMXUYCo28ipV3wmICHfVeLhSmcMZve+RPMsbgPzOWcJXlOkbRAf1PmzJ5ztDu+JgqkEK0hNG6lfAUrk9me51NnOcKCEEzV7oC5qlhUaVjoWmfZ7ga2AVwn3YRskxGEcv2FL1VbLWUyvecicb04+p5xb5u3dFaCDLgBd/x7QLISmHrCy0LOZ7DZuXoGUaCq8lVtY8gwgAS5CRTGFbptG3sp/2Dzpzlcq3dsoZJ9qMRgpbw2bIQEv/aniXtvEFCd4gFJ3GnNsHqnxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3air2QQthn046DMQ8xkDIX2KuiZzhVB/WIf+y5CmkWo=;
 b=m1UD8YuTHsC+JONLgr1+bn7WL5J3IB85OE6v0TNwRm8CsK/H3uNwaS0dsDEQLqG7XpZdlailjbgGMUMpful2Zm7CRxCSEx/8QF4ttD3aTf8dXzpd1vCYHdkKjC34IkjnEVL/ul1xAn5djm0pMAL52l2G9k8n2fQyhN0aiYytnymU0P3ujsLvop2mujXZijotGISie+ZbNwHQG8H9v0QnQQTvwxGPiOIPNxB1Qel9KOms6j9eiyOLTlANLjglFucoRIZHubqG5Cf5qOZF91r+FT+mJyJhl8fluBFvhtEX7AzWQBXF/gaZkbZfaWdPAB4K8H0Z8WXIDXfuxoyk1UkVsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3air2QQthn046DMQ8xkDIX2KuiZzhVB/WIf+y5CmkWo=;
 b=seainbDA7uohZC7u2X7Urd0WAKtCK3iz9rU44VI0jNZdsftRKw0hK4iSOcS00ENla4X6El5Z7lfQPnhWynvU2vZMHJN24lo1o0pHbZlgvJjKU2oace8f50EMamhfTH0AgJrFXUfFCe2OQFxgViGsJades9N2Zf1D6rxlhdhIlQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 19:24:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 19:24:41 +0000
Message-ID: <db44b482-2e61-414d-9c6b-9a1199e0a2f3@amd.com>
Date: Mon, 10 Feb 2025 20:24:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] drm/amdgpu: Add ring reset callback for JPEG4_0_3
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250210142548.2321625-1-sathishkumar.sundararaju@amd.com>
 <20250210142548.2321625-3-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250210142548.2321625-3-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: fd130583-cc55-47ad-bd59-08dd4a0890fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2NYTU9QSFJjN05hUXFFMktETUo0OFN0K2pSZUh2YUZCdzFpR3ZHNHM1WUly?=
 =?utf-8?B?ZlhuTmE0M2xIMks2R1pjTnhKelBiZk1sZzlaZDhEMG03anJIa1NmK1QrVlNh?=
 =?utf-8?B?eUNkTFpSNFdDYjBGaFZGQ2FpU0o2RXZ6alpwcEh6REpqNU1YejEvdFBsU0JJ?=
 =?utf-8?B?dW94RDV2QVY5aW5yaWlObDYxUUdERzFsZ2ZKV0N2UzFDTlZWY0Z6bG1DUG43?=
 =?utf-8?B?cUJlbG03YmxLS3dIYndIMXpxL1loYVJQWGc0b250SmlxQzhLVHcwTWh6VlJo?=
 =?utf-8?B?OVQvYU5COTRwamJNSFNQUS9PM1ZQYm9Tc3VnQkM3aWZMVFA2WUNSMDZTWkhN?=
 =?utf-8?B?VFl1aGhJMk5sb2k2Z0h0YUNEdVdWWVRidmJHT2FuREdNQmZCSkdXWXJnV0JV?=
 =?utf-8?B?MUpiZ0JyblRKMUlvRXdsWnhlMkZ6NVhWUUs3TU9NMSt1dnI4NVAyblhzQ01y?=
 =?utf-8?B?Ti93Ny9yUlpDejVBWTV5UURaelVTOWdsWHNlamVHVWRRdm9ZOW43aWIwaU9D?=
 =?utf-8?B?bnVDVTNyY2RKdmJYZFp0Uk9CREZNVWFuWjFpOUg5Qk9qV3czL0pyL3BBQ25k?=
 =?utf-8?B?a1NmUlZXaXIxeUpNTXltY2ZBMTlrVi9CSTJWQWJ1cTFPV290WmNYSlp0Rkcz?=
 =?utf-8?B?RzRxQzRrM2UwTEk3cHVNWE53RWdhZVBtQjltZUs2MDFpZ040aUlHQUN3dEVs?=
 =?utf-8?B?R29yZlJIOHFLNjVoTWdGTitCekttd2RpUlVJTjNpdTJpWXEyT09hcE43UnZ1?=
 =?utf-8?B?UXh6Tm4vZmdyUmNTbnhYOFR3dklJK3RTWjAzTFNJN3hCQkt1V2FoWlhiaEVK?=
 =?utf-8?B?djl2S05RZ2prb3g2QzlBclZkRjZGUXNnbEZEK1dIR1FLWElod3B0YnA1Wkpw?=
 =?utf-8?B?cVNWZFkyQ2t6NWlGYXlxa3NFdC9hVzZTUkQxVGVsT0x1UGVBUTJOL0tuRDdS?=
 =?utf-8?B?K1VXcDZ5V2JFWUtoeEx0YXlSQm9UZzEwNXEvSUdBSktaRnBQWnAwdm9tZWZm?=
 =?utf-8?B?dThLWU8rRGFyd0loRnJCblA0VC9ZdXVFb0J5bXB2L0w1NDZ0M0IvRGtodEhI?=
 =?utf-8?B?bTRYa2RDMUlkSk43dVpQVTVKQzhxQklwMWxwdjdKVGJseEpZZk9lT0czZzU2?=
 =?utf-8?B?RWo1VkFETjY3QXNjSFJKbmFJT0dRYzlZd3laV2dQbW9MUzZiOUVTcytXQVQv?=
 =?utf-8?B?T1ArdlNpcnZ1ZWxDQ3FrVTFsbFVzZE1Qa3RJYjNLdW53NjRiampQOGt5bnZz?=
 =?utf-8?B?ejhCendhRGI4Ky80dW02QyszbVJLS2JZZDNzS3dad09Zak44YTdKWEVFeVEy?=
 =?utf-8?B?VE1GUC9EYklLZDh5U2VRSnhRN1BrY2lOeVJna0xxMEVNOTExb25jL3VZcWZW?=
 =?utf-8?B?THJQZWhqTXZ3VkN4VEllOEJnbmNzUE1mUE85eFdlcjFFMXcxRkFsb0F6WU4z?=
 =?utf-8?B?blV3KzRDN3FsNCtQc1ZUNVVTcFZFYW14L2pPdlN2U3NLZjdwanJ2T096YWt4?=
 =?utf-8?B?MGN3ZEg5Y3RDQjJXK1ZUUXJNbGYwcWhFRXZtWnBkQld2Y21oYTZTb1dnWTFU?=
 =?utf-8?B?cXh5SXpoOGdxM01JelB4WUdZVHZ2QnE4WlFTMGNTdkg2ZmVzU2ViN0plMU1J?=
 =?utf-8?B?L1lzWTVMSXBUNTZpdUVJNEtVQ2JONGxRMG5XNndLRHIyUkRvUlFBYzlzQ1U4?=
 =?utf-8?B?U25YUEpTbVJ1WVd5RnZ2a3FVK2M0NWJ3YUFWWWY5dHIxU3pyMmIyeUZOZjl0?=
 =?utf-8?B?bGtjWXo5WnlmdWtrdTM3Nm1OMlRIaGtmWWlQd3dJTjg5M1o0S1k5TkJjbmxi?=
 =?utf-8?B?OWdHWDU5SkFXbHh1L0pnUkRzWkZNWUJBc1N2MUNuUGk5b0JkR2xGeUc1SS94?=
 =?utf-8?Q?i5uZEtwr+pAaT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnQ0Um5LSFNxR0ZyMldhdmlHVHNTa1RHbkhMeFdaK1grZmh0dXZleW84SUVN?=
 =?utf-8?B?bGNMamRHbXV4YjdPWk9WOWNjNTVPS20xQm41TEhrSFRtZFBtTTZiL2xnNHIw?=
 =?utf-8?B?aU9tMmVCVW9RMmQwVmtNQXRqdTVwOU9MM3NzVUZMdERJY2d2WlUwWi81d0Y0?=
 =?utf-8?B?UFkzVGswcHdvRTIzbDdNYzVuWTVhdkVmNWlUcng0endmR01SZEFJWnd1NFFt?=
 =?utf-8?B?cDUxQW1qOVVVcjZwZDRSdHJJU3BQdWhFWHV6TjVlL3lBblVBMTk3azQxK09q?=
 =?utf-8?B?SzVieWdUQ2h3RmhJYU5QdXQ0YUk3eEFUSG9PU1VjejAvc2U0cVE1R2RUNU5j?=
 =?utf-8?B?cGlJcnZLT1VTVFJmVitXVUI1azV4SDVoY1dXalVyZXVFb2lhZ01ibUpzTUFr?=
 =?utf-8?B?ZEtXZy80U3k2QlBuR2FkbkNQODhMeFpuMlRlMnZUcHNzeWJSZEFLV09WVy96?=
 =?utf-8?B?djdyanFiQk44dU9zWFVVK3J3Wi9Xak1WdzI3NzFLcjU5aG1FZHZ5N0tPaFhj?=
 =?utf-8?B?QldNMk13bmZIUysybDBqU3BpTGtSOGdKRE05OWM3SlRyZXFiVTYzNUxNdGd3?=
 =?utf-8?B?dWVGR0lYR1JYbFdTZllxVEt1N2NBYnJXcElvczdMa0JvNlEvRVpxZmYzRm9w?=
 =?utf-8?B?VzVJVXdQa0VtbGFURmh0RXFPVFNxZngzWUNpZlRLRHdtYS9PYmd6QVR2VHBC?=
 =?utf-8?B?L3VSSkxPeEdQdm1KaWhYdlNicmpXbzNtSVJPemVTOXI4anpMcHpiUzFyMi9K?=
 =?utf-8?B?VE9vU3dXUHMvcERwZklxblo2MmxUbjlmMDVmbXVmZHVZWVRiZm4xaE1MaXdY?=
 =?utf-8?B?aUJHZUtiQ2h5MWNHRjJ0MGlXYzJZbzBVek41Uzg3c0pkTEJhTlhQeEU1MFZM?=
 =?utf-8?B?T29uRzdzeW95MUlybkpGaG8xT0ZydG03Q2ZmVlVjYTgvM0kxN1JsMDFyM1Z1?=
 =?utf-8?B?dTA5cXhlTGdXNTM4WHIyM2dnNFZOenFZcHNLejZEN0tLMkZvRUdKYUFNTVFG?=
 =?utf-8?B?aFNuZ0pXSk1DZUhDSG5wbG42MHcrdjZndENSd056RVRlRXNRdlBLdWtlamRr?=
 =?utf-8?B?YUpObGVMbDdYWmFTTHQwT1RwS0hHd2dEVDA4SWtCdWhQZHBycU1xOFlDcnVo?=
 =?utf-8?B?UmZRWGdaN056S0MyZnRIY1JZaE5YZTQzejQwZU1yckZZSDZianFTcElxSHFQ?=
 =?utf-8?B?UHNjaUQ4MlA5VGd6UHRMOEV6UEg4VTZCUHkvdCszZExhdnVydjhnTWRPMzc3?=
 =?utf-8?B?Z3lodGV6bVFmTW5LdzRjZ3Z6YVkydXJ0blZIYTRINjZVVHE5MmJRUUdxbk9a?=
 =?utf-8?B?ZTQrb2RKaFAybXlmaFd5cEFBejVGckpVUC9ndHZGOTJoNFVSa3hIWVpSeDNp?=
 =?utf-8?B?Y0ZWYjNhZ2xuZDcvaThXU1c4YWZmMWJkS3hyK3ZJNCsvV2ZweFU4ZjFjWWM5?=
 =?utf-8?B?UTFTT3lLK1hCaERFUzUyeWFjd0kwc2hSWkQ0NFdKbnBCQy9QTzJGVzRpbEIw?=
 =?utf-8?B?SnJlNTZ3KzRKekFMS1VYTGV5WHFuYkhqUWlKR2NIRnYvcFBKVld6RzVBaitL?=
 =?utf-8?B?eGVMOXBvRjZuZ0FONGJEOE1vN3RqS3NIWS9LRWZtZHM2UkxaRjRnbjVINVlT?=
 =?utf-8?B?UFM0VGdpZCtVeXU2cW5rUGVDc3IxMFdkVU11QlJsMm51cjlYWTJ5V0ZScGYw?=
 =?utf-8?B?aXBOdC95Ri9qSGdoZWhMbU05b3Z1WnJzdFJ2NW5jTC9sVkZSdmRPa29waUlu?=
 =?utf-8?B?bFg4dW9uSXpNZDBrVTA3WFJ1aXpVSEZnMnkzQnhHaktiWnFRRHl6SlN3OWNR?=
 =?utf-8?B?TWNZUmVvYVpIMnErOS9iYWh3SytlY3kvUS9JUmREckd3MTc1SFJJc1pRcHlh?=
 =?utf-8?B?elJMS25pSkU3cnV3Y2ZhcHVxeTJxNCtMcVkzQ3J2WmdqMnd4bkJHRlgyeHNq?=
 =?utf-8?B?dUZLLzM1cjh2VEZnK284QUVkeGp2QlpBK0I0MjkzS1MxcklUSU1ZVkxBL01v?=
 =?utf-8?B?Uis0YUNnNDY2UEsrbnpsOW5RQ1lKQlk1djhTSjV5ZFBBM00ydGtPME9wUXpm?=
 =?utf-8?B?a0NxZVlvcEJMVWt5ODdieGhNMTk0Znp5ODJKL1BKcWViRXlrUTM5WWduVG9Q?=
 =?utf-8?Q?jR54skoCBNNkpG1CEPdPrFkrA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd130583-cc55-47ad-bd59-08dd4a0890fd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 19:24:41.0573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaTpD8QnqaYsi6FCOBXEui44u1rQlp8AKuLNCARW6Bq8eLrCiCABVhgr7JdpN7ox
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716
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

Am 10.02.25 um 15:25 schrieb Sathishkumar S:
> Add ring reset function callback for JPEG4_0_3 to
> recover from job timeouts without a full gpu reset.
>
> V2:
>   - sched->ready flag shouldn't be modified by back-ends (Christian)
>   - use drm_sched_wqueue_stop()/drm_sched_wqueue_start() instead (Alex)
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 69 +++++++++++++++++++++---
>   1 file changed, 63 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index be0b3b4c8690..b6168f27addd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -204,14 +204,10 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	/* TODO: Add queue reset mask when FW fully supports it */
> -	adev->jpeg.supported_reset =
> -		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
> +	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
>   	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
> -	if (r)
> -		return r;
>   
> -	return 0;
> +	return r;
>   }
>   
>   /**
> @@ -231,6 +227,7 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>   		return r;
>   
>   	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
> +
>   	r = amdgpu_jpeg_sw_fini(adev);
>   
>   	return r;
> @@ -1099,6 +1096,65 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +static int jpeg_v4_0_3_wait_for_idle_on_inst(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring *r;
> +	int ret, j;
> +
> +	for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> +		r = &adev->jpeg.inst[ring->me].ring_dec[j];
> +
> +		if (ring->pipe == r->pipe)
> +			continue;
> +
> +		/* pause work submission on this core */
> +		drm_sched_wqueue_stop(&r->sched);

Again complete NAK for that!

A HW backend should *never* mess with the scheduler front end whatsoever.

What exactly is the requirement here? Do we need to make sure that the 
JPEG engine isn't touched by the scheduler at all?

Regards,
Christian.

> +	}
> +	for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> +		r = &adev->jpeg.inst[ring->me].ring_dec[j];
> +		if (ring->pipe == r->pipe)
> +			continue;
> +		/* wait for idle on all cores except on the hung core */
> +		ret = SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, ring->me),
> +						regUVD_JRBC0_UVD_JRBC_STATUS,
> +						jpeg_v4_0_3_core_reg_offset(j),
> +						UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
> +						UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring *r;
> +	int ret, j;
> +
> +	if (amdgpu_sriov_vf(adev))
> +		return -EINVAL;
> +
> +	ret = jpeg_v4_0_3_wait_for_idle_on_inst(ring);
> +	if (ret)
> +		return ret;
> +
> +	jpeg_v4_0_3_stop_inst(ring->adev, ring->me);
> +	jpeg_v4_0_3_start_inst(ring->adev, ring->me);
> +	for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> +		r = &adev->jpeg.inst[ring->me].ring_dec[j];
> +		jpeg_v4_0_3_start_jrbc(r);
> +		ret = amdgpu_ring_test_helper(r);
> +		if (ret)
> +			return ret;
> +		else if (ring->pipe != r->pipe)
> +			drm_sched_wqueue_start(&r->sched);
> +	}
> +	return 0;
> +}
> +
>   static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
>   	.name = "jpeg_v4_0_3",
>   	.early_init = jpeg_v4_0_3_early_init,
> @@ -1145,6 +1201,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
>   	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
>   	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
> +	.reset = jpeg_v4_0_3_ring_reset,
>   };
>   
>   static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev)

