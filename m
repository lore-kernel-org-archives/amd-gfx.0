Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4C7C369B8
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 06:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DFC010E32A;
	Tue, 15 Apr 2025 06:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k7kylzfE";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B96310E32A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 06:24:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVlU7W9FjN7NnAoSF/bnKujijthYGbSHFm4sKTXSknN8a/MoZcQfEuZ0uwi3/I19Y958kVQ55paHdmNbgVcNewPhWdcwdHzkLQI1hddHvMcqdKPwXFpV0Q78PS9POc8D4qBseA42EwLeBzBmabHYlrQmj0fbsyhtUb5brLUknkBTSf1GEO8PGwILlqguiZIccwUMPjfuLBbzJd8DsKGPlXClFNkQyXTqd8eIFiI0fr9RM//lyS2vRJE6iE+iZvN/h5nKmOU24M4R8VDRZMrTVql6u40XBc3jstd7DKBzFrupD6zWSraP5Dn3uc0cmE+qU4kpNqexlGJOqd5/krqL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCslS+I/qma45yu2e+WqR2XF0Hr0C5j9OT+Np371Dxs=;
 b=vWP1lmXx1RwZWqw4e1cufZjP/nUJvZDlfKHU+7nndhRxzowTrTpnJqB9HMx8kI9RKE4Yon37bIksvM5EBUQ1y35JPZuUjJymQ5aPHuXsCUTN1KleEVwjCSKmMaALo23YxVcq7M1WaQnKf66NmGRR4wslpz87q1xs2kcndIwjjMLrIbEgM3X+LlNgxy2DJW8GPkcIJKQmchbtrcfp1cMPN6cmk9ehR94ZeTx3jPClcaEIr0ia614lJ2a0Wdn6ZeWFsClTtb7qPi8D84cilCmCG47CAHxCbvNVS8WQ1EstXg10qbRCd6Sr6UA4bc98ZuxDrrwwhc4hvZHLAtBvI0bf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCslS+I/qma45yu2e+WqR2XF0Hr0C5j9OT+Np371Dxs=;
 b=k7kylzfEZnFB0q2qey0PvQNTIdK15Ja8GGGLPBBqHR7Wky/PoMD0bBASHWzTXEmhyLwzag+1Ju4oE2GeCRxYp6cjcqyoxj0wYtM4XRGVGMV18GB4AjSzbALThVqPsIBEVoRVq7mjEk8jgalkBpwuEgEvQV42FkuUNjPb5QcUMBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 06:24:16 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 06:24:16 +0000
Message-ID: <a5ce7a47-2a9a-4b51-a281-bae76e2c581f@amd.com>
Date: Tue, 15 Apr 2025 11:54:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] drm/amdgpu/userq: integrate with enforce isolation
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250414192028.3113100-1-alexander.deucher@amd.com>
 <20250414192028.3113100-4-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250414192028.3113100-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3c1a03-24e4-4d70-f284-08dd7be625ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wlh3SnlPUjBqeGFubFZGZlY0ZVBIOWdrUmFHN1M3Z083ZEhjZlV3Z3pXNnFt?=
 =?utf-8?B?b1RHc0l1Q1lEMDM0cm1MbWNVSkpYYlFHeFU0SGFCMnZyZTBxcHZCTDl0OFV3?=
 =?utf-8?B?RUJlZ21mQkhMRm9ZN29HcFFJdUhPUzV4UUlEc1ZscGk2YlRBTjEwYXMveEIw?=
 =?utf-8?B?UUdQZVdpdURJTERkTzdDdTgvOExPY2JBWG4rSkk1UkRGVmo4L1hpRGVITmxQ?=
 =?utf-8?B?dE1VUEw2Um9Yd0lXQ3hQbEQ1ckR5ZmtUM3poQXBmWkllNGllVnRIWEVPbU42?=
 =?utf-8?B?SmhQalIxTWh1MFhsaTlaWWJVdGJsaC9kS1huTVo0aHBCQzhLRXJiWGtqRUNa?=
 =?utf-8?B?dENaN3l4NjMwaURqcDNNcWlxa0dDdmYzOTVGSFB6ZU84Y0xmNFJSYy81Q0Z6?=
 =?utf-8?B?a2xqRG1Fdi9kMmtmb1liSlBNWkJ1bzlxajdSTTlLWHRiNE85NysrSnRQbW5F?=
 =?utf-8?B?d3VMc3pTSlZzK3pJVU9WeWF4OTNSdjdhYnVBMTRJOGpaaDJXQVlJbmluczA2?=
 =?utf-8?B?c3R4azAzWE9wYjdVZVB5anFsaCtQZDFEQnk5VEFZK1hya3ZSZk5TeUxiZnov?=
 =?utf-8?B?MVBNQ3JoRkxpSjFhWFFMOVFGNmd4Q1JTMnBGakwwNjZjU2lrZmZMalNIZ2lK?=
 =?utf-8?B?RkN4Zm0yRFlVcDZPNG1pbFppYWZNb0kxQWIzSU1BODRqb0k3Zy9wOXFaS0Fl?=
 =?utf-8?B?RCtTa3NGczBtMmIxL01keEtCc08rOEY3ckJMV0phclZlMXY4aFRMUlF2MU9s?=
 =?utf-8?B?YWRwNCsrN3VBcFc0SGkweXNjdkNxcWpNQWFsaGpKSS8vMjdrUm9iVzlGeUFR?=
 =?utf-8?B?QW04ek5hbEpIcm5Bckg2dEtSVEE1aFhqK3I2WnpZQ0hxLy9RTmxSK1VTNEtS?=
 =?utf-8?B?cnBGbW5naE15NmtWTGlxN0dtYWx5bXkySndGWWEzdi9PQmIzbGxONFBaZ1FY?=
 =?utf-8?B?eURJNzlYeG1MMUtTZVdvbDRQUzk5L2tBVkp6aUFENzFoUUpYdm1TOFhRRkk2?=
 =?utf-8?B?ZnJQZ3Z2Mm1zQlFNWjQ2dUgwa2F0OC9qVEZCWEtEWXJmL29MNnIzRjNVWUx2?=
 =?utf-8?B?WFRDemVMeFpJbDBwdVJCZEJIdVcvRjlEdVFBYkpKTTEralhqUWFOWGp0Z014?=
 =?utf-8?B?QllTcTM0QTE1blF3VUEzT3dVYkF0Y3F0bUNTdFZoMHl0dWFBOGlmS2RWVGJV?=
 =?utf-8?B?eFhvTStWNU9sUE4xeFdyczRFc1RpRU5WTmhaOUZHS3NoQjlHZkpVaGR4RG1T?=
 =?utf-8?B?aklYbGVYQnlwbDZ6S2YzS2g5NXg1Nlllc1NYdUhzZGZ4QmpkNS8vUzU4TFpi?=
 =?utf-8?B?QW1EdjBjMjZkaW9SQWJPWFpsR2RNbkc1MTRYSGhYWDkva1dzd2Uwa1g3UlBr?=
 =?utf-8?B?aHc4NkJMUlVhUW5Zc0tUcEc0bG81WEFISndVdHVVSGxxSGZIa0ZBQTdMa3NU?=
 =?utf-8?B?a25NMVYrQ3p5bCtMTUZCYVVsWFhXcy96bHprNTZ6VjJ4U1JnNUFyZUZ3Qmd6?=
 =?utf-8?B?NkVjTWN1K0l3eHNFRHF6VVlrNDA3S2hWd3dENnVCVnlzYW1KQnRodXZZbzVV?=
 =?utf-8?B?L0IyVXkwOTJ3MW1PekZIYUIyK0w2SWp1MEVvWGxFQjhVZWZxRzdwdkdvVHNL?=
 =?utf-8?B?NG40TEY5SDAyTG5NSm9ka3FQL2pTWTVqQlJBY0lwY0xNYUp5WENKVHZuUGdV?=
 =?utf-8?B?dXR1eno3d0RmL3g5U0pVSk5xa2FBT1dFakJOblowNUhTUWN0cGdQTEtCT2Vo?=
 =?utf-8?B?RjhxYzZTdU44d0orN1JSS1NGNjZVb0czeHN0bVJrWFhNZUNzNWloYTBEbXJQ?=
 =?utf-8?B?WlU3SC9hQ3pVM2cxLzNuMmZVVnZxWHFQZkJCVjE4UnRZUXZVT0F1S0l1T0JQ?=
 =?utf-8?B?RnBrNlkxVzY4SVFGZWRzaHdVWmZsL0h5WWZEZWJiUFdJMlFJekZXUXA5eEV5?=
 =?utf-8?Q?/VE7P1MFv64=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWY0MEgvSXJ6R1dGa1VlZnM2eU9kOFN2ZHY1QTNwT0plcFNYM3VGd2RhMjJN?=
 =?utf-8?B?cm5OeXE3alVueUtRVWdhVG5LNlQyOGIxYWRCdWdEUkZTanNVNXBiY1lvVGZ6?=
 =?utf-8?B?ZXhGb0pVMk5nSGVrd2R0NXh4MTFFR2FiY28rcUhycUxSdWVkK3NqbHRSd3pC?=
 =?utf-8?B?NjRqUjRuTXBTRmZXdVIrQTgzWk9pTGh3UEUrenpmZFNleUhXNE1MVVhnc0k4?=
 =?utf-8?B?MDNMZk81cFVoWWlsU2MySWpSaSswUmJuY3pBK3lIbmNXazhab0VrZmJoQmQ0?=
 =?utf-8?B?TmRrL0cxbmx6VEV3UFU1OG5QMjVDS0NUdU5OQUJiNnpXeUVEREt3RUVVMmNj?=
 =?utf-8?B?UmtCTiszUzYzOWQ2RUp0T1phWTZIcWVCeXUvc2ZTVjBMMlgxb1JoeS9EN2dl?=
 =?utf-8?B?MGFRcWRFVWVpU3pOazduT1I5bkF1dHVHajlTV3hVUUtvcmk1WU1IYW5HNEgy?=
 =?utf-8?B?UXBXZXB6Y1dxYVUwNUpSK3lhNHltVHcyRWV1ZFMrOUEwcWRhTFE4U3hPZ0cw?=
 =?utf-8?B?NHBDVENxL25Cbk1nZFVrOC9IS1hIQzdJVU12d1ZEWjc3TzVVM1AxN1Q3cUlu?=
 =?utf-8?B?MnhsKzZOOGRyVUtsZGJCWTRiSkRUUDBrOUJwM2taNFZJVDR3S0h2bzQydW9j?=
 =?utf-8?B?elhRTEk4V29qQUtMUXJwZjMvU0tlWkVzKzNDQ3p5OHhHSnRpUzgvOWlxZVoy?=
 =?utf-8?B?ZVZ3aUgrRmZFRGMyQ3lrQy94Z0ZKTXV6bHBGR0NoRVB6Rm1GaVRRUDRndjNh?=
 =?utf-8?B?SXYwSXNINHFsMWtCd2ppRUkxTjhDa3pJM3g2RGR0bjlzdi9iZEpRUUVSMlY0?=
 =?utf-8?B?eDBNaHgrN1ZIMmVmeVJuUW9rejE0em9RaEVuQkx2ZnZIRXFvSHcyeklCcnV5?=
 =?utf-8?B?UXh3Lzd6azBGOFRXalpsNlA4U2J0OURvb0xTaE9VTGIyem1rUXRJU05pb0h5?=
 =?utf-8?B?V3FKRFhJRWJQQm1wTEgxMGM5Wm9qM1VaZXpUazU1VDlQUForSVhLNHFVMlI2?=
 =?utf-8?B?MThBNCtUVW1FODNtcUZ3MjNsck9qWE45T2VPS0VNZDJHbjZhVnFYeHdnS3Vn?=
 =?utf-8?B?VUtkMkxmY2dSbUJ2U2RqNk5wcDlZZG54ZUtNSzE5dExCdGNWSlBhRXNoUTJK?=
 =?utf-8?B?RDFoMW5qcE85R2hyMC9IekZ1RVNjZmg0bUYvWHA1RHlETzhiTExiaW45OTJl?=
 =?utf-8?B?bG9rNjQ3aWRjVkVGalEyeVRMeWdOYU16NzJOY0dkeTV4RlhlWnZJY1lMK05x?=
 =?utf-8?B?aXlUY3pyUi9DVXFSYTNtRUI1bG5jOG53MWRIWEkrZVFFL2J4SS9BNk5wcE11?=
 =?utf-8?B?alZ2azRPQXo2ZFprb3dscmJMbmp0bTAzVlExVVZtZW5xdEgrQWQ5VnJYd296?=
 =?utf-8?B?TzlsOUh2ZnRZSVhOQ3FNdCtGRHdXK25pQ1ZPWVVmRmZsQmFWMnRjdkhLUTVG?=
 =?utf-8?B?bEhCb3pyM3VCU1FOWG1zM0g2WGc3ZzZ4ckJ5ejc5OTV5M1B3d0RHaFd4a1Rv?=
 =?utf-8?B?c2d1OXJ2aFZEa2VkOW9RNCtVdnJ4aUNxTE5tTHJDVWdva1h3V1ZCY1Bqa1NU?=
 =?utf-8?B?aDVOK1dQMStmNk0xU3lQM0dOeC8wa2JUcGRzcDZvY2pwakZ4MTZ6V05IUlI5?=
 =?utf-8?B?Tmg5VjMzejgvd1R4cnlBd09iQVRwamhKMlh3cks3Qm4ybFNLWkEyQkFiNmFH?=
 =?utf-8?B?a0p4RktUcnpUY1Btd01uTGdBM1VaTzBuaTFXUlRSWEtMLzBtb0VFcUQ5NTNF?=
 =?utf-8?B?ek16cGd3VUlVYnZyaURUM2xZVjVnR1VNOWkreFFqQjh0L3hIYW9vcHlEVmJX?=
 =?utf-8?B?Q09iRWRTa1lvOC80d1hhWEI4alhuTEdRMUZZTDNZN1FYNXZVU3AyOHIycGNx?=
 =?utf-8?B?SmRUMUdIQk9kL3lDYnptdW9mZHZuUFBNUXJWRHVTMlRyZVhrRDFlTll0bkdL?=
 =?utf-8?B?VlZHa0o5T2dnczF6WU8vUXhtL05mT3dVK3ErNzJjMGNMSWpESWtVV29vWHJ1?=
 =?utf-8?B?UjY5MTQ2UFN0amhtV0w1OE5RNWlibmx2c1FsYzMvL0phV1RBTGNxYlhnbXFD?=
 =?utf-8?B?c1kyc1RjRy9EWUdTd3g2MnRZV0E0QUhXQXhDNkhxL0tuK2ZoMUZ3NjhvdUdN?=
 =?utf-8?Q?m6RfeMAwsVtF8Uhtp6CYtH54i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3c1a03-24e4-4d70-f284-08dd7be625ce
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 06:24:16.6848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhwJUBRTbk/4i4Gk4XMD/tyLHp5OdI/2Ht+2xyKOumU3JxSq94eIMc4jXTv5mWJSUtVULouhr5BY0d3NPUP6aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800
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


On 4/15/2025 12:50 AM, Alex Deucher wrote:
> Enforce isolation serializes access to the GFX IP.  User
> queues are isolated in the MES scheduler, but we still
> need to serialize between kernel queues and user queues.
> For enforce isolation, group KGD user queues with KFD user
> queues.
>
> v2: split out variable renaming, add config guards
> v3: use new function names
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index c58d32983c45e..e1dca45a152b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1970,6 +1970,9 @@ static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
>   		if (adev->gfx.userq_sch_req_count[idx] == 0) {
>   			cancel_delayed_work_sync(&adev->gfx.enforce_isolation[idx].work);
>   			if (!adev->gfx.userq_sch_inactive[idx]) {
> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> +				amdgpu_userq_stop_sched_for_enforce_isolation(adev, idx);
> +#endif
>
> Just a suggestion only, I understand the list will be empty but we will still be taking a mutex and some of the unnecessary checks that could be avoided with the user_queue flag check.
> if you still think its ok i am fine with it, functionally its fine and make sense. Also this check #if CONFIG_DRM_AMDGPU_NAVI3X_USERQ will be removed as its not really needed once we have proper drm_info information passed to USER and handled in kernel.
>
> Reviewed-by:
> Sunil Khatri <sunil.khatri@amd.com>
>   				if (adev->kfd.init_complete)
>   					amdgpu_amdkfd_stop_sched(adev, idx);
>   				adev->gfx.userq_sch_inactive[idx] = true;
> @@ -2027,6 +2030,9 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
>   		/* Tell KFD to resume the runqueue */
>   		WARN_ON_ONCE(!adev->gfx.userq_sch_inactive[idx]);
>   		WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx]);
> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> +		amdgpu_userq_start_sched_for_enforce_isolation(adev, idx);
> +#endif
>   		if (adev->kfd.init_complete)
>   			amdgpu_amdkfd_start_sched(adev, idx);
>   		adev->gfx.userq_sch_inactive[idx] = false;
