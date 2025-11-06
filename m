Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45493CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 16:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B003410E939;
	Thu,  6 Nov 2025 16:09:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ThER4Wwn";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 796CB10E939
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 16:09:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1+B6m+YeJBYvDMbzz71tjmpUdBbM5dzAclO9O9Sa2shIiPtUZIbpZz/MU2xEsFW3WNT81HnRTopG0wkmjxSa5HOTwkj2P/U4QMmanwjWFF27NJb3azeU9CdRb0DceDXoBzq76ulBm/QIx25eKlYF0LZohgFC92kw8Rdfncj6RWh4t0m7msa9Pbw3S8ugVUwjKJyUEMffaT8/vTgdQPKyTVG5yLGrUI+35drj8bTXOOd/PlK9db8xFvpFCm5BDxbmLk94UC9jeFidnGw3CD/uEOWpA6OI0CLJzFWBhRjKMEwW2szLl0oA3p0istwnWFikYnybTPVIE03TojI1oon6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgP1unXJr/Uhf2mVqIPwjgv1SPrhFVJUwUjTyVq2hyY=;
 b=EJPuGsAYuAYZvxQg6p1ueMQ9wWdWh9+JJfQkrTrDQ+Me6mIZ0CD3OnvJIOwXeRLXl6dF4EX5+cJNw3rI7KRBAsvTDhritbRRptIeKP9tR0KCVqaxMpdwtCWv9wDn7eM2aFBsMFFAX3d38nSnWUeYB6ohb3pBXgqF+2z3C3sx2IQvk5uAiKQpG+F8kbXlAChK5r+tzNJPgo4YwzFuSMQ3AQrnw1Vv9iCqY1TzHX6SjMjvueM8HN92PZpwyNG0v8SgWEUvWVUvrX7uhduYNS4amnLRxipScWsF7x3tmqdof3NN/k9QCT0gkd9lBw4K24mtCdP/HprCYTNehJVJK748Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgP1unXJr/Uhf2mVqIPwjgv1SPrhFVJUwUjTyVq2hyY=;
 b=ThER4WwnbDLYa3Opa4d92fYskN7iQ8t6X4NocsD9OFP53QTg/5hQ8wunXWmY71meu0TJoujnQbtkoyO+CK0r0+qUBA2Iiq5JDDFWff7sZBMboOQOb+41i4wLl4Ff5kH2h6mFIxXMhtfHwJ7KWnc4QFs1XfRrGLieiBo20aekl9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 16:09:41 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 16:09:41 +0000
Message-ID: <99abe8e6-aa69-41e6-8993-dc6ef164c926@amd.com>
Date: Thu, 6 Nov 2025 21:39:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: Add NULL check for power limit
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, KevinYang.Wang@amd.com
References: <20251106160104.3784249-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251106160104.3784249-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0053.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: b7271512-554a-469b-5325-08de1d4ee451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFdhNkFXRGhmbzVRa1ZrdytyWXorNWdLc1Y2dVRpNm9hYW5na2Rzbk9IeFpy?=
 =?utf-8?B?enE0aDhLS25xQThFUS9LZFd5aVppY3BiS0E5M1Vjd3BvWkQwTVBPY0UwbG9k?=
 =?utf-8?B?Tnl1NU4yTXRGaFNreVV4QkFIbENJYUNDU2NSWm5WUnRUSzJObGp6RksyT1Vj?=
 =?utf-8?B?SXk3aEIvUXA5ajQ2YzUxbUh6UmlDSDFtY2s2eUdxNG5KaWRsdTU5bjhFRE5V?=
 =?utf-8?B?aG8ybUpza0tHTmdUankxZEFiSjd6d3Z4a1BWREJzaElQdWRSdnVQUll6ZXRT?=
 =?utf-8?B?U1pEY1NXTWdiN2lRRnpNWWpZRzE0Q3k5WEtBeDNlb1VUM1pGSHpoSGxwSkMr?=
 =?utf-8?B?WEcvNkxOREh4Vm9XYlV0WVNQNnROc2tkN09ZeDZLanpzRnB2QTZmRWJINlR2?=
 =?utf-8?B?YU0wWFc1UGVsSlR0SzgxdW9malJ3NWVxNXhpRTFoRW1zWEx6Uy9BS3JteWlm?=
 =?utf-8?B?NlJSMmRBc3k4bXVwRmd2d0xrZkt6Wnk2M2V0SndVa2ZvM1M2TGxVREl3VW0x?=
 =?utf-8?B?UFd0QzEyenlGTXhvbHVINEswS2ovVXZ0b2wya3pFUUFoZmRJa09rUE5kWTZ2?=
 =?utf-8?B?RFhpL0MyVWZ2cXdHd3Zlam1KSFRYYytoc2NlUFIvSDd0WWlKa3JSemFjOFJL?=
 =?utf-8?B?T2JNTW0wYllUR1FvcWloeVUvTjRPbjF1Z0RkaFRycXFOT0RRc09HYlYxYVNJ?=
 =?utf-8?B?Z09GK1dJVjdyTkk2QjNyS2VMOC9kZi9SVUsrWjJ3a2FTWHZ5MCtIaXFKT1FZ?=
 =?utf-8?B?VFhYalI3WlMyNWkrSjdaemQxVG5HdlZqR1F5dSswU3VaV1VYUlg5YzgweERO?=
 =?utf-8?B?blBBYmVoWDVXNU9BVkVFYUp4ME1WenJMMklMTlUzcjdFZFVWZmdJRWg0cUR0?=
 =?utf-8?B?R2JZVzRZbDJXZmhkNCtpOEoyc2VGSGVLR1FpZjhiTkdFOTFmTWhvMmpmM1dL?=
 =?utf-8?B?L3l0enQ2cGFBRGtoY0d5MWlUa3MzSTBFQy9NclhPMkluTjdnaHBTeW83MWVQ?=
 =?utf-8?B?ZjZ3ZllwdWtWb1Exc0JxRE9vV0xwbzR1UURFNmc3SzFHMEJZYXA1WFg5a0Vn?=
 =?utf-8?B?bFVET1FWQ1dKMlpNN0ZTVmR4Rlo1d1VMRVhHQ01VUkVPY1RUdjRueFhzQzda?=
 =?utf-8?B?Z3dCLzRtcHdNL2o5U0R2RVpneFJWTFQ1US8wTlRkOGdkamJKckFnUit4aFNo?=
 =?utf-8?B?UVhWVyt6Vkp6QnU0eXBvSlBUWEhFc2FTR1lTaksxalV1amlUL2lJc1dsTEVL?=
 =?utf-8?B?OGZ4bS9jUUxtQytFcHJYWUNhM2hiaE9HLzdQOGdsK3JSbTdwRllVVGxJc09z?=
 =?utf-8?B?U2w3WVUxUTVmYkl5K1J6UmpEWFAzeFhVeWcxUUpPUDVHYm9rc3hSdkVHY0M1?=
 =?utf-8?B?VVVSVitKKzhnRDlaRDVOa2g1MERZdTNkTERSM2x3MVJuSVRNT1l4aGVYWFVk?=
 =?utf-8?B?ejI5M2g0T1NKWDZlZmIyTVU4KzFyaUdFaVR1NE1UbktTQ3hiblBaZ2UzL1ZE?=
 =?utf-8?B?TllnQzJWUlA1K3NVanh5WndDWnpaV0ZrL2NqMmtjSzJYTjdnQStZd1dJVlhx?=
 =?utf-8?B?aDVDaExIQ3BoMk5LRWExMFJKTEVnV3dzYmUzRzRwdXpsQjlCOHRMM0tlR2xF?=
 =?utf-8?B?Tzl0T3pzNEVrWk9xZ2RVbHM0Vjh4Lys5V01yQ21keTh0Y1FHejBQSGN1MkRk?=
 =?utf-8?B?RTQxNEM1V05LVUdDQzhSYjVROWhsZzhtN3hITjFHQTdlWWgwTVNrM09Nbkl0?=
 =?utf-8?B?eStvSURMN1dTNVJOTU5hb3I4cFJRdnNTVEhiMlB4YmtBTzdwVWFYS3pGS09o?=
 =?utf-8?B?Yk5pMmJ6NzVFWGpuQk5XT2NSVHQ3NkRyUVBmNk1kQk40bmJRU1dENUVJT25G?=
 =?utf-8?B?RXVDUXllbVVKeTNmQVZiL1liNktNUmRURk90UFFEcHRDbmhFVlcwQXhCcnBE?=
 =?utf-8?Q?g9SSeXS3HRv8UoFxg4GfFmHtC6ifd7vC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anlBTTlvTHR0alBlTzFDdG5kKzBxSTNUNVdjb1pCdTI0Wk55Wmp2T2ZDaXlG?=
 =?utf-8?B?M0E4b2k3cC9kL3E3akx4ZndjYjVFWjg0MGtHek1GK2JFc3BXcGtlMU9CQUYy?=
 =?utf-8?B?QTExMDJ0QWlyQjh5M0lGNGR0NzVidTdCQjErWEU4VUZ4MHJvTDV3Qk5kYmdU?=
 =?utf-8?B?UGlyZm5jQmd6cEhaOFRLbWxJZFNwMTBwdU54Q3RETkVBK2dFRWxvazRCcTc2?=
 =?utf-8?B?M2xSVktIUDVzT3JHVkx6TW1GSk9EdkpPWERvRXFFZjl4YzNrc0x4MDhIQVJ0?=
 =?utf-8?B?UUFMTVBrRzVDN0cwT0FiTW93Y0dNZkllVnZvU0M0cFZuZm83T2xMa3I4UHlm?=
 =?utf-8?B?Mm0vem91M1Z0ZkNNczRmM0wvdnhzK21KK0JWdUFGQkFadW5raENBb3hkZklo?=
 =?utf-8?B?K3hIc1R1ZElWT0RHdXlOajhQM1hiRXpsWmtYQUhqMk55R2ppU1BNeEVNcVFC?=
 =?utf-8?B?NERSbmVpdklGbHBzSTVPTjlvUjdzMXE2LzA0OTZ5TXRGVmpsWVhwQ3V0bFh3?=
 =?utf-8?B?YVp2bTJOYm41SmJIa09YS0xnTURpeU9SbTVBSUd3aW1tVGRVTHR6WGVVMUR0?=
 =?utf-8?B?M2xrdXR6ZytNZlBtNHp1WHd2TC9qZVBRbHNBOXFjSVpST2hTUFlLL1hoYURh?=
 =?utf-8?B?LzhRYTFhMTY2bW1BYTNTN3lwU1hlYVZPb2hWdEJPRGpBWk1lSEoxcUZJUmdK?=
 =?utf-8?B?RXppeWl6aktwYWo5ZSs4Y296OGJpUVUyNWhvTjJzZFBOMFhVYjgvQzFOMVgx?=
 =?utf-8?B?ZW5FUlVGbEpZeGtBWFhPTUFUNWJzVGRpVmN3TVA0R3kyekQ0cWZsM2I0YjI2?=
 =?utf-8?B?QzBiQTI0TjQxVmMvYkZteGlHTDdXZlU3NzJmbnBVeEJ0MDBXS0RxeHhzRnZl?=
 =?utf-8?B?L0t0ZnVuL1crcHFwSUtaMGhtZ282Z3Byc1pzb1FQYk41cXpJL2pER1Azd21p?=
 =?utf-8?B?Y0llaXMwRExUSnlHRWVHSmFLV2JYMUVyK2dFaHl0SkRzYVVUT2Fac2p6UFJU?=
 =?utf-8?B?eVpybDFmbUVpQzFoeTFjSmFOVkRlTXY3dWlDR2pmWmxOeVI4KzRFNTdaZkRW?=
 =?utf-8?B?ampiVHlGY0hiUVdudUlyVG5LOHJMdlpQWjJWREhwdzVjeHdhQ3hNcUVjdXEy?=
 =?utf-8?B?enQwR29yb3BJUEtlelY4bklUMHlheWwzV1VuSEZIbElFTC96Tk5WWGdXUlUv?=
 =?utf-8?B?L3NQUU1ROTYvYnR4NTc3U0dhbytkSlgvSXRnY0NRMzRJdDhIdElXWitiODBF?=
 =?utf-8?B?dnpxczB2LzZqVFdhNHBlYUhlZTMyNDNVVVhTdjJLYUU4dWtHQ0JxSU1yRlBn?=
 =?utf-8?B?SFU4VDRkM2lPWXBVeURYcEdpV0lXQVEwRmdISTdZMVdUdS9kWHR1MENKdTA4?=
 =?utf-8?B?aDlTQjltUG5KVmMzenVuWkU5bEx5WXBIWFZzMmVWS0ZsU1FFTkdGWHlqQkt3?=
 =?utf-8?B?Yzk2NkFaY0w2NUE5MUtjQ0dRRXRScy84cEpsbTc3V254YXR4elBkazFWSzZC?=
 =?utf-8?B?UXdCTENOa2w5aXY4bkF3Q1NwRzBrMGxNMEF0Z1c4ZVZ5VjZSbWx4V1FPRm8v?=
 =?utf-8?B?TVprM0hNd01aM2NLcXlVZ0NVb3ZsWVpRRXJmKzlYZ3VEN1M4Yk5LZU9sOFd0?=
 =?utf-8?B?Q0dsUXR2Yy9na1p1RTBYZGZWY0J3VXovMEoxYW91aTlqL1B0M3E4Yk5jMnVI?=
 =?utf-8?B?Z01XQ05UTDlVWms5OGpEQWU5V3V3NzhXa2dLR2sycXJpSjFDbVFPN01mQ1Bk?=
 =?utf-8?B?N0NEVFI3eWVyMll3NnZ2Q2o2ZEhISGd2dmg0Mm81OEI0QjczLzNTeHcvK2dP?=
 =?utf-8?B?dkFrckxZWVFYMFh0bEdvMExnemdTOHYreThOU0YwUm5kUDlyeC9hSnY5OENr?=
 =?utf-8?B?ZEJUMXV1NjJBY3VqZG1pLzkrSGRVY1hKak1jSldGdDB6cXBYek9qMFZ2Tngr?=
 =?utf-8?B?SW1hUjJESVd2dUF6UDhCcngvYnRqSTNHOGxXL3VFTURRejdacE5GU2M5MkJI?=
 =?utf-8?B?RE8wTVU4eWZabzFqM3JrSkdLaEtHSmdaSHpTaWRwYlQxR1orc2NhQTE1NXNC?=
 =?utf-8?B?aC9wK1Exc1VGbmZ0YmtuZzIyUmFKVnpZRVEwRXd6UFRUSG1GclZodklzRHdu?=
 =?utf-8?Q?zjCRUHRUotgVJdUCEghC0HRFY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7271512-554a-469b-5325-08de1d4ee451
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:09:41.0497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yebgRRaKkBavG2k4WwcW5sJTuyjFnx1CR/ssWz44WYwjgyiCxT9ZpbuAYHpk4vdQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
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



On 11/6/2025 9:31 PM, Asad Kamal wrote:
> Add NULL check for smu power limit pointer
> 
> v2: Update error code on failure (Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8b49fb86c77b..4a2c3ad0c38a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2907,6 +2907,9 @@ int smu_get_power_limit(void *handle,
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> +	if  (!limit)
> +		return -EINVAL;
> +

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>   	switch (pp_power_type) {
>   	case PP_PWR_TYPE_SUSTAINED:
>   		limit_type = SMU_DEFAULT_PPT_LIMIT;

