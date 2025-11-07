Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825EBCCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 09:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2611A10EA46;
	Fri,  7 Nov 2025 09:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R0M1THvQ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E7E10E040
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 09:26:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOPLIbfs7jtECEYbNxtiCw2kdxpEBWUFKyStiLdN+kKrJRfJ4e1O0uQsd7awizzqZLHBWCMaLGdtgWCBsAuRiiP+DMd/P1aBBY28oatBX/ERUEkjMcaxiwizGCEEphBZIiOGY9wgg7Rgm1S0EBME3AvmjZhqXwQYW35fbPR6OmKC5DmIxYjBWa4By4VNYMYNKZbao2sct5kTD4SYUrB1cLnIcYk0zMO4YVL/jkiqc46dvp8MvJp4oM/FSOFI/DDgLj2Fy3kNh1FzeHmXFLdTHIOuLDdiTpi9HeejtUdVfCaCpVV1K8HAq42iGGDrjLso2PBkaxUZx00153WKNXTHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXxiAPduWgyiO16e7ZdLqSLDnKe+y3QiRjBHavfc+U8=;
 b=wXv7fKyQFe4uhTMF/alKUK0i0nrS+1TgrPR6bhxLBToBDv2At35VlGSt3laT/+FAQRFsQU4ngiK1onhyzJ4W+uYeohW/l5SHImFI0drE+v0i2b9kOTzbmnoFGv5JGUwRIWXFDRfs4tFP1JzemrK71zYd0CJTHQK/yTcO086U2QnWGhpBUA/BOC7Ug5+11g9dUBVW9WNgRzeaz67b2PZuIoG5lZxYtJAknI/2OkWctPuOTsZ9qfyuDtaHDuBrp7hve/eRMLuqBauBP6JOu88Yxt/RKM4yJ4ODT6udsoQrY+PyS6wrjxzBdDpUVJNfjUKYZRJck6vSloxlL4f5kJHswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXxiAPduWgyiO16e7ZdLqSLDnKe+y3QiRjBHavfc+U8=;
 b=R0M1THvQ1AS81jH0zqDIvULY1mUcWfQSN1hTF0pu+uTtvXrKAuDfvES81uq56k9IUa0FnXg80m/E9fSUfY9yiyb3VTJqwTJ0KzRY6r8mEHjOTi1ggRGxsDg/AcP6sx6hmhoe04AoE257BbSiBMWgO5X+7qR6nfKgOeto2HSqA4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 09:26:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 09:26:02 +0000
Message-ID: <0512a9b1-1ab0-407e-91c3-f496a55dcea8@amd.com>
Date: Fri, 7 Nov 2025 10:25:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] drm/amdgpu/vce: Clear VCPU BO before copying
 firmware to it (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
 <20251106184448.8099-5-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251106184448.8099-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0473.namprd03.prod.outlook.com
 (2603:10b6:408:139::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8b4ba0-d376-4fbe-233a-08de1ddfaafd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFhWK3JTclNlSWd3YmJzRGZhbmtsL2o3V1V2QWRvUWwxS2xJWEV3cVM4NHlj?=
 =?utf-8?B?S1pVOEJtVWJ0K2hqcU1pc3IzT3Y4aDYrMjBhWUlTemlzYmo3ZUpnbERWSmJR?=
 =?utf-8?B?bmpHZS9nTHF4WVg4d3hTbUZlNzJiN3NIbmlFZ1d0dmZFYTRMdWdXbWZqQ0RX?=
 =?utf-8?B?NW43OUJpeS9vOUczeHpnT0hiK3ZZallkdTdQUFEzUGZpSVh4NERrR1YzTmlt?=
 =?utf-8?B?MmF5czVYU1hURHJlVGVORkRtMWNrWk02cE5oWHFsQjNzSlNpY25pSzZYTi9u?=
 =?utf-8?B?R2o1S2lqc3pNVDJKTXZydWx4VSt2aVorNUoxK251UG80ajRDN2tBZTFHdW8v?=
 =?utf-8?B?YVkvUjZBd3hZZG82ZldoOGtIQmZWVGhndXA2WVN2VFExam1QN0tMVVNWUy91?=
 =?utf-8?B?L0JuNFVKTitIZldCRUY4T0cyZEk2bE9xR0JVY3F5VnE4aEx0MWFQUG0rRStD?=
 =?utf-8?B?S2k3MGhWaXBidm0waGdkWmhwak1QbE5HZW5HbEdlMHB6WHhnKzU4dzdnNDVi?=
 =?utf-8?B?ZThsbVlXNXFPOUFRNXpJWkFUNEZlalpmNE90ODRTanJNVFlUUEU3Tm12YU1H?=
 =?utf-8?B?K0tLVW1MeFpVWFBnYi9KdUJLc3ltY1RmUjFHQWFzZVloSkFQQ3FITnlodndo?=
 =?utf-8?B?djQzcmJwd2k4WHdOL0hhZElKREcwdkd5eEl4NFVRak45RGVTengyeURIQjJX?=
 =?utf-8?B?bzdFa2lHVndZZmk2YnIydEpBS0NwOXVybUErcFk1TkJJUG9Pc0N0SUJOUmZP?=
 =?utf-8?B?cUVyVDQ0VkxmNFJWWWd0Zm1WalBmY0RraU5uOWtSSFh0NDZ6Nk9lN0xVczFx?=
 =?utf-8?B?R21DSVY1QTlQcUlBc3F6bnV2eFJWSGo3MFF2MFp6d2h3NWErUUxqVGNHN0Fw?=
 =?utf-8?B?NHNmNEVqNHRwWHVQUEtHUmRRbVRCeUZiZE9nSUZOWUIvMDFIaFk2YlhJNkNq?=
 =?utf-8?B?dmZ1cUUrQXZRVWhLeFQzNURJTDNQRlQyMlZ3TlhxY2JieUxwNXJ3V0J3NFg2?=
 =?utf-8?B?SHBYS3lSMVZvV1FSZzluRHhrSEVvMm14Z2xtM1pzMiswMGRPdlFMelkrR0t5?=
 =?utf-8?B?dkhXZ25IeTdTQzhYaUdSRTdTMllJZU1pTEZ5ekhkS3pOR0o4UW9vZnFUc2Rz?=
 =?utf-8?B?NFBpOHZENEJ6ZDYzdVBLNCtHeVJiR0MwZGNYeFZyTnhBLzZuWEhHbUlHNG9x?=
 =?utf-8?B?dkhndSttL0NNb1FVWHJZQXEyc0ZJYTNzMmRuRGJhRWRzeTJZVGsrMDkvNWxs?=
 =?utf-8?B?L1lhWVFPaC9jWVhZSEczK3lsczVmTGpjNHFDTVBkam5MVy8xUnovcDc5cmp1?=
 =?utf-8?B?S3pHekRQWUMyWXA5S3lEUTZFRnlwSGYySng1ekFVekgxMVdsWmJ4SUcwNUVP?=
 =?utf-8?B?b3BuU3dLTHNxMS9UZ2pibk5IWmVQaG9rT24vYWVmVDB2L1dCSG5leDhFSEJ2?=
 =?utf-8?B?Y0Fob25VcGlaL0FRRmU2NzJtSVdQUXlkUUpOaVI4Rno4eW9JU2hKa0pmcUx4?=
 =?utf-8?B?YTRhaWdVZzVtL1l5dFUvYmxqcVFSSlNKbEhBeGFEcm0vbU0yUU9pMTdhZmU0?=
 =?utf-8?B?LzF2RTJYVWJJQ3BQNGJzek9aeFk5MGZEK0pmV0g4UEczdk9pR1ZyNVpkdTg1?=
 =?utf-8?B?cWJGSUptdWZtSGpZNGdSeUlycHZoT3BMdmQ1RGxpbXJ4c0JyZFNFWHR1a1BB?=
 =?utf-8?B?K216OHR4bDRtT1VPYzY1ZTVscnBBbXNjWDByNWZIdXZ3b1hXay9GWGRUUFl6?=
 =?utf-8?B?QUV6TjZQSW1xNkNhNko3NWxzMFNXMXIyUkNFS1FrR0hZQWdhNjBVRm1OZ2ZL?=
 =?utf-8?B?ekFlM3RqK20yNERhcFdXUHhqcG1YTTBMdi9TUDkzRWRFVkt3ZGJwMHhCZEdi?=
 =?utf-8?B?cWF4V2h2dCtaeDJRL1ZxNmMvNTVFZTdIdTI2NSsvZjRQRTVwQUhiZTJkdXBG?=
 =?utf-8?Q?J9Et6cAa5J1G0AGIeboPCK2PVfDuE+le?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHlRckVqVWlkT0NmbE92SlpIU01JRHExNFJkWFNhYmhaSVVMb25MTE8wV0sz?=
 =?utf-8?B?eHRnUy91Y2k3L0M5Rms2T3YxSEg0am1nd3YvZFZsaGZVK2FtY1FNd0VvWjlK?=
 =?utf-8?B?TWd3RmVmai9KTFBTMFdwQmwyV1d6bVhZbGIwRW0veW5NY0Y1TjF1OC9XZDBz?=
 =?utf-8?B?eTFUK3k1dWZVQU5JN3hOa1l5VGtsWEtyM3dWcHRCeUgyb0RhZENGSU5QK1Ur?=
 =?utf-8?B?Z0JIQWJxU3d4NEpnWVpjR0didHhKNFlCb0hNTGZKK3ZKL2JTc3JkMzFFQlBa?=
 =?utf-8?B?QXF0cTBuQ3BuVCt0b1QzcjVESHkxNkdWcWgwKy9NVlR5NWVqMlp1c09Ub0ZV?=
 =?utf-8?B?cy83U3ZCaFNwc3VMK0xiRlNEUFFCWE9mZDA5aFBSVFRMdXhsOVBhS0NHaS9D?=
 =?utf-8?B?VG12Z2ZzWmQySDA5TS94QkhaVjRjUm15NmRFUWVHMDBlMFhibUNHcCtGTDNm?=
 =?utf-8?B?NnRPd2ZOL2VKVm90ODZ3NC9LdmRwUEIySE9YWDdSQ3ZqM3k1SEtjcUZ1c1ZG?=
 =?utf-8?B?akg3SElHM280UXhSTi9qU2ZudzVNWFd2Rll5U2FrNEhXSkttMnU5akhkVkxq?=
 =?utf-8?B?T1Vkdkx3ZzFhcFNabURtcDRJM0VycGZGTFprTDZmNUJLMHpQWTQ0WUU2VkR3?=
 =?utf-8?B?V3hxRUt6RU1BcDRxZGJKYno2UUE4YzFzeGtLVXJ2c1ZFY09sdUQxWHdrU1Nj?=
 =?utf-8?B?TGRaM05IQ2FmRGRYMk8vbVhsbUljbXhlM3NrUTgwZDZnYk14M0NLVFAweVI2?=
 =?utf-8?B?eHJVdEJoRkQ4SmZ4SkdpMkZNaDhHUEpmRXZXd0YrSUhUWHpHUXYzV0lROFVw?=
 =?utf-8?B?TFBJdk9UendqTGd5RTV6Q1V3QzJSMFh6bVVjOE1WUTFQcFNreDM1Q3F2SExm?=
 =?utf-8?B?UXRjWUJIMmpidWZ5UW8xWG13SGpVbTErdzI3OGJGS1NVeEtVN3Y2ejYrbEpt?=
 =?utf-8?B?dWgwKzF6TmtET2pBM1dyYlpkRmpid2ZLUlYwbXdCQ3VvUVlWZjI1Y3NEdGRw?=
 =?utf-8?B?MjZKZ3pac2tJMjBLOTVlS2tZRGRZR0F6ZjVubm1pQUxTMDdVVTZVcFNxbjA1?=
 =?utf-8?B?eUxtdTRTc0VvT2k5eXkrcDcrL2ZHNzFEc3l2UmhEZnd2M29Ub3ZyK2FnNW9U?=
 =?utf-8?B?NkkwWTVVekNmaXluYWhwd1B3OGZtdDhqWit0OVB4SmVQcmMrMWRQcXJrcnp6?=
 =?utf-8?B?a3NRbnF5ZjVXSmNCei9LOXZLeGt2RnM1UkY2YVRlUlV6YlNjMVFDcDNkb1dG?=
 =?utf-8?B?NkpCclc1bzJBd25RTlEva0xMQXpKNkp6aUhvOWpIdFpvUkVuRVJVQzZJNWFp?=
 =?utf-8?B?UXdmaCtZZlMvNW9KQ1JpVWdHN3RmdHltUmY3b3FrcGQ2cHVSRm5jWTdleVVF?=
 =?utf-8?B?WG9DUHlHSEUyZm45NEdtSWhsYU9uek5aL3YwdmpMMVpsZ0pSSU5qdWF4TnRS?=
 =?utf-8?B?STR2UlYyZy9GTmZBMEpzTG9CZWY0alh3YUV1dUVNQ3B6OGhwVisyNVVWc0V4?=
 =?utf-8?B?S3JUc0ZxL3hmd255NVY4S0IxSDh1ZFRWM2lkTTMxQkVQeDdMVUxiS25yU2pa?=
 =?utf-8?B?SVdhdWRWQ1NreVVqQVU5aGt2dEsvR0JqYnFDNWQwRHg0YXhHWTZ6dUM5Ky92?=
 =?utf-8?B?WWxzV05XVXNUc240d0gzaDhQNU96NXNLL0RQZFdpZ0lxeTZSeHBBYnM2Y0VJ?=
 =?utf-8?B?emsvaGZVNTBQaUlDdkZrU2lhMnQ1UkU4MTFHWmc1cGQwRHhydThCejN6cWEw?=
 =?utf-8?B?dDF1Rll4d2ZHMCtPUzNPaDYvVHJseVVxTVZqWHhXOXJRdXpqWDZGcEJ3czY2?=
 =?utf-8?B?T3FjZU5uelc3clRhR1kydDI1YlVpdnVQRHloL2ZKRDN6TTF2ZGY4VC83Q1A2?=
 =?utf-8?B?VURGcDljbWFMYjFCck1kczExd0VPdHRXQkxzcVQxTmdIMWxZSlhueCtOd05m?=
 =?utf-8?B?WmwzN3Z5eUJQa2JRQkZHdzhFdGFWSnpPd3hCSmJteDJyMGpycGtycENQTmMw?=
 =?utf-8?B?blJXSHJxOEdWMEJaMTZ1cFdnVnR3ZkxEM1JzRTlsZmpCa2VPREMvV0ZObFFF?=
 =?utf-8?B?eDlGekk1TkZMaXB4MVluVGtMTWRGY0xRSFRGdTQzMWVHN3dJcEJVbEZnWUVW?=
 =?utf-8?Q?N+yqXDT6X0t9bi8cViL8m45GH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8b4ba0-d376-4fbe-233a-08de1ddfaafd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:26:01.8954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQCrlX40SKHjYuskqexjLvqbHuZx3Cti6TJZJ3+S2dRg2D6D38ll2KzuNbECnOdp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
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

On 11/6/25 19:44, Timur Kristóf wrote:
> The VCPU BO doesn't only contain the VCE firmware but also other
> ranges that the VCE uses for its stack and data. Let's initialize
> this to zero to avoid having garbage in the VCPU BO.
> 
> v2:
> - Only clear BO after creation, not on resume.
> 
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

For now this patch here is Reviewed-by: Christian König <christian.koenig@amd.com> since it addresses a clear problem and potentially even need to be back-ported to older kernels.

But I think we should clean that up more full after we landed VCE1 support.

Assuming that it hold true that VCE1-3 can't continue with sessions after suspend resume we should do something like this:

1. Remove all amdgpu_bo_kmap(adev->vce.vcpu_bo, &cpu_addr).
	As kernel BO the VCE FW BO is pinned and mapped on creation time.

2. Rename amdgpu_vce_resume() into amdgpu_vce_reload_fw() and add the memset_io() there like you originally planned.

3. Also add resetting the VCE FW handles into amdgpu_vce_reload_fw().

   E.g. something like this:
  	for (i = 0; i < AMDGPU_MAX_VCE_HANDLES; ++i) {
  		atomic_set(&adev->vce.handles[i], 0);
  		adev->vce.filp[i] = NULL;
	}

   This way the kernel will reject submissions when userspace tries to use the same FW handles as before the suspend/resume and prevent the HW from crashing.

Does that sounds like a plan to you?

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index b9060bcd4806..e028ad0d3b7a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -187,6 +187,8 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
>  		return r;
>  	}
>  
> +	memset_io(adev->vce.cpu_addr, 0, size);
> +
>  	for (i = 0; i < AMDGPU_MAX_VCE_HANDLES; ++i) {
>  		atomic_set(&adev->vce.handles[i], 0);
>  		adev->vce.filp[i] = NULL;

