Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC2AF8D74B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 14:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE96510E20B;
	Thu, 16 Apr 2026 14:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZIUa4Upx";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010009.outbound.protection.outlook.com
 [40.93.198.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E20810E20B
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 14:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0SetNdYdtVJbgb1ffH7TQ2uN63aqYUHAuVBjtvr65zS3ON5hNXjuGvdrFhNudnhi/3zDy2stqqzRO1iGCEviGbO12t7As0uZjsrT5mt52gdNLEmTNFP3/wnlZ0q4X3ZQkShDWGNM0jHxt/fdqqQ+r1xnTM14jL2P6lEUZC41MlNMzFhoug/4nKT0fB9WHSkgnKn8nNiinLsNtiV/LVUNuF4hyovR56YAlIBf2f5ZappkJJOgBpMowCvZAUL1jWOgElX7M8P8UARBsgHHNXBRAkDmjVsLTqYvaqPzJnfV9qcR2VH7jg2d5YyE9NZIPwFFI3NUFYziT2fFvss/DKBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xXqjKch6vtN0unDXHLpEEcdjTH3Y9CBSnAyHfLhFDk=;
 b=HBQ72dNE+3YvrU9e7pCxaCGTQgdCaBYr1McUN0Y+6Y5B0/i7lrNLCquRyXPcKg/XWElvc/G6pfGB/9qKtMRcBYbPzff4BI+U3RBr9v0sv58zBSUN8vzJCwtR+3qTkPTw5pa8j38HVxqg40KQpyl+r4fiyRTAne4SdFuOsU8fXJecCzXdZmBhFaRpq3k4MnH+1JnaGctL4AmhR1yV4kABHr2dw42S8rCLpEsyNI26GbOdFTdbW4l6OlWMjbEShthH8BLxPYtRuTJDyaooWelKtiJJE5/bubrcVbP+pfppU2AV4Bm/8mdw60vIm8VRgKnWwO9sGXcxmuwk9JnT73To5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xXqjKch6vtN0unDXHLpEEcdjTH3Y9CBSnAyHfLhFDk=;
 b=ZIUa4Upxuytn6gYLgnp6pzj8/NV0i2uBI4TWL+vb1uvg/6vrqphT/Ra6q9dJ+46H2Ml6BvAsMeLf26WqPGZvX9WGW5QatBrOb1iEqg02hjO2v19zEfQ3zpPLXSY9dBudNSWJz41+Ib5VhVo26zwuFMe2OyDJEkFsqEnF+KfxZek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS2PR12MB9712.namprd12.prod.outlook.com (2603:10b6:8:275::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 14:29:14 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 14:29:13 +0000
Content-Type: multipart/alternative;
 boundary="------------wWeI0kBbTs4yj0RUV2n590UU"
Message-ID: <116df723-1d80-489d-ad72-3e2f16e3f19e@amd.com>
Date: Thu, 16 Apr 2026 10:29:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: OR init_pte_flags into invalid leaf PTE
 updates
To: Siwei He <siwei.he@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, harish.kasiviswanathan@amd.com
References: <20260414184819.612245-1-siwei.he@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260414184819.612245-1-siwei.he@amd.com>
X-ClientProxiedBy: YQBPR0101CA0279.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::10) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS2PR12MB9712:EE_
X-MS-Office365-Filtering-Correlation-Id: c501080a-e8e0-4a1f-5af8-08de9bc487ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: wItse14gC2p4lWzn7D73DXO0NuNbjGoBSU2t4EdHmrby+vumvIf/qaXA9S/PcBJLdLyY6tYbhVRmzx4bizkMPRtn7n/d4DlRI795+zwF3LElOPE+O8W4gK3vsKXlCjbIWphyV8m165njn3L9lJ+tqUwrLmnhWk7Jgg2pJX/CbtfgSnM+pA0Y4wrmvjMzLFQDco89BcPm6akmVgB7RN+onae+ga/kkJ5y8aHTyJIDoXYA70SvjoJBaOHyD5Nh/qyuy+nkIbfAZOnXw0SOeczEyPnrGpDs37wkalDq6e8yHoAaFhNEvr07hHEG+uibFhHF9ddyJLCER5Bie3P9/dLlSuF9FBv3zO4aC2dn4N1ZJs40kXQ7lUukYstH3+lmdT2MwaBzpMEj0lJVIajhG8D1cjhhgNutUHFUOkcYinor8mlJnImIZPWPpA1M+jE+tnxMrNOKaqHoDGTYyhZePUoJeYe5G037nO1I9RmLe5mEdlFxBReRzDq1gMFSuCUXEQlUqyA4uwwaADZR8xSB4b3qjC984xaWxHxn/Sa1T5LRsUhdOHWd3q+hW09VHEiCw7HDPDjr3hKRRkeIRF3HurJ5mMnT3lPf6MjCzq7k2tlt0RDpGbDUMtdmviVls7qd21gBOTcZgxifSVh83bEHaYROlfbINVnAweuXRsvKmGEDs6LCm5xLWjs3eKF6JhXPeFBSda+r/V2DnSs6qXVXK5+zhcKittV1zi7A0ov+oN+GLV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjBkTm1HUHU0VGI1SWZPYU8zNWtRSWpoVzZlWTd1dnRiTkxGZW9vK0JmdEtv?=
 =?utf-8?B?eHJoQUt2L0tIS3VqRlZkWjNPRm1WOGdqbFV0UHN5dTdDNWYrRldCemlZMTNF?=
 =?utf-8?B?eHdnM2laRXV1b3FIcG16bDJGVDBMSXJidnhhS2E2L1hOWWx4SDU1QnpRRDhF?=
 =?utf-8?B?NzNBVEtaZGxKYlp6dCtyTG1Tdk8xRzFleVovMElhMVkzeU8vbzUvU2VldzRK?=
 =?utf-8?B?RFJzWlNCem1NdU1EUmRGeTN4V0dkcnluOU1UdENWN0tIR2tocXJFc21qMzFJ?=
 =?utf-8?B?aFplYnZJR0FwVG9CQkFnL09TbWJ1OVFrTVlGRmJPQUF2SFljV0txNk9GTjU3?=
 =?utf-8?B?VFN0VloyRjFTSXJQMTV0Rys3eHBEVG5RdkNOMVlpRXNMckxmNERvdEpSbVhx?=
 =?utf-8?B?M0hoRHN1Rk5icXF1L1J6RHY2dk5ub0NUQUxzTWZzVENheWJHcGNTVll2SmRF?=
 =?utf-8?B?NGxOY1RGa0piQjEyZGNkQ3IySEJFQXZFeDZ1emVXMVRicUJyV1RPRmlTYjJR?=
 =?utf-8?B?bmpBMEJrb1ozQkRUZ01yczVnQVVKSHBpVmxzKzg5L2FtNDJjalY5SUk5ZHg5?=
 =?utf-8?B?U1ZKRnFDaEhlNE1mZlREeVlqOTZvZlc1aTk0UE5XbXEwUmkrWklxU2F4enlR?=
 =?utf-8?B?QlRhL0JYd0ZkcUlHd0tXNnl5VFZycStuNDNJTUJYK1EwMnpEUUI1UjBuYnlk?=
 =?utf-8?B?UlEyeWo4bFdYZUVWZERKMlk2RkcxWnJhU2dCUEVEVGRoZGlUTUZnNTdIb1ky?=
 =?utf-8?B?MjhXZVlGUlVvQ2RZTDZMVGszT1VOM1FTVGd5eHFiMmFJMVg0QXZ0VlBqZDRl?=
 =?utf-8?B?OGkxWHMvaHdkd0hzT3psNVoyQkxoZ0xqa3FScWRrNDZ4WmxmME4xbFVuVW4v?=
 =?utf-8?B?S3E2NG9SU2dPL3FYYURMcWgrb0hEUEFoNjRYWGEyMTNKcG85Z2g5QUxiZjhq?=
 =?utf-8?B?dEw1eXhkRTNiSUozVnlwNFBLV0ZSZy8rZGhNUGhoZkZFbms0VVUwRElUSDFE?=
 =?utf-8?B?OXkxSTRmRU8xRWVXdllFOVpjTWNyd1R2bzB0dElXYmhXcmpxNlRsR2Q2M2Rw?=
 =?utf-8?B?K3VaZ3lrQjBwL25lZ2k0dklIN0p4N2RYUFp5ZGZ1b0hPMmNpcjl4RWthZy8x?=
 =?utf-8?B?MmRTNnRtdEJoMmQ5NjRTd2xjaGZOSm1ZdmEweUw0VWxOZ1IyV0ptT0t4T3lS?=
 =?utf-8?B?dTA5b1NwUFY0ZXhEL0tnNUtWL2pUNFRNZnFqb1FPVmxLRGVhQ0xiMzhrY1pS?=
 =?utf-8?B?NXZ4L2FSSlpQWGU4bGF0Sk83QUNWQ0hldnBVNVJ5Y1BVMUN5VzJQYitaTDZt?=
 =?utf-8?B?RHM3Y0k0NkQranh6UEUrYkM3Vk5uTm9MdTkrS0g4akw3eHlBMFYyWGRuOE4w?=
 =?utf-8?B?anNTRlAxM1VYLy9qNlhudkNZRVl6c0hoVWhaNlJxT01yeFJBUlJmSmR6U2xo?=
 =?utf-8?B?MTM2S2dVa2RXcVgzZmZINThhL0NFaElCY1ppSGdpYkExUDVxZnR3YmRkS0ZP?=
 =?utf-8?B?WGZISGRycFR0OGhFOUNwYzBLRGJTdVBPOTg4ZnR2dHZ3U05OckxEbXlNT2hq?=
 =?utf-8?B?aTAzSythYjJ3eEU1M0pxZXJpL3EzcVVMekh2ZXZBMjBObysrSVBHaXFFejFY?=
 =?utf-8?B?aHhLaC8vOWlnd09jemRwcXljUXAxdnJ2U2krL3pEa1dndjNKeFpiN081Tmt6?=
 =?utf-8?B?VWpZMkdab3BqZFViWFBVblpQWnA0YlIrVEh3SXI0elNHZDZkWnFYYnVFOCtn?=
 =?utf-8?B?VGRZK1hYekhxYzVYOFdBZHZZSmtXVWM4QmJibDBJMTBzdEV4L3g2Rmp0Rm9D?=
 =?utf-8?B?TFRyallFVEVTaXBWQ0tQQy80VnFsb3hpWFpMZkZSSER5c2VuaERsa2oxanNa?=
 =?utf-8?B?WVlTc2pjam5rSHc1bjhCUklsZ1RFN09jd0NVQmpXTGd0QTRwVjB3M0RxOVg5?=
 =?utf-8?B?WkJIRjA4V2RSVkJUU21IbnZmZDNmR1RkUmVITzdHSFp0YUxFVmlRR21zaFhq?=
 =?utf-8?B?R0pyVU1LaktoMW5qV1BNUDRTU09odWZ6dmtCT3VYRHhZelNvNkszTHJpb0hp?=
 =?utf-8?B?N2FRNHhHVmJuOVlVeU1aSm13T1c3SVY4bVBBSWVwZkRwbEw4aGpQVDd3bzBy?=
 =?utf-8?B?dUdBM0pHSE1qNmJVY3lCbFZQRURWNmRpMjkxTVpEd2JGcUhBU05zMG1XN2Vm?=
 =?utf-8?B?ZVhidFlSSzRjK2UwbDI2NUMrUmZRODVreVVEalNOdmxRYnpBVkVQVFNYdWRW?=
 =?utf-8?B?WVE2RnlSNkRtSGdGU1FaRnl2UC9TS3gvUU5ZK2YyclFPaEpNczdqbmxwVys4?=
 =?utf-8?Q?q7di2WeBezZXm229SB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c501080a-e8e0-4a1f-5af8-08de9bc487ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 14:29:13.2843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYGMAHiHqHZDuGGYqoA1gQ/77Uw5+N96SciKaXqYhh50utPAmY4CN5kG4klj7vlo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9712
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

--------------wWeI0kBbTs4yj0RUV2n590UU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-04-14 14:48, Siwei He wrote:
> Invalid leaf clears that only set AMDGPU_PTE_EXECUTABLE match the old
> GMC9 fault-priority workaround but omit adev->gmc.init_pte_flags.
> On GFX12 that includes AMDGPU_PTE_IS_PTE; without it, some cleared
> PTEs can fault as no-retry and bypass the SVM/XNACK handler when a
> VA is reused after a BO unmap.
>
> Apply init_pte_flags in amdgpu_vm_pte_update_flags() alongside
> EXECUTABLE so range-driven clears (e.g. amdgpu_vm_clear_freed) match
> amdgpu_vm_pt_clear() for leaf templates.
>
> Signed-off-by: Siwei He<siwei.he@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 31a437ce9570..a930f1522f96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -693,8 +693,11 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>   		   !(flags & AMDGPU_PTE_VALID) &&
>   		   !(flags & AMDGPU_PTE_PRT_FLAG(params->adev))) {
>   
> -		/* Workaround for fault priority problem on GMC9 */
> -		flags |= AMDGPU_PTE_EXECUTABLE;
> +		/* Workaround for fault priority problem on GMC9 and GFX12,
> +		 * EXECUTABLE for GMC9 fault priority and init_pte_flags
> +		 * (e.g. AMDGPU_PTE_IS_PTE on GFX12)
> +		 */
> +		flags |= AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;

Looks good to me, !(flags & AMDGPU_PTE_PRT_FLAG(params->adev) handles the NPA mapping update case correctly too.

Reviewed-by: Philip Yang<philip.yang@amd.com>
  

>   	}
>   
>   	/*

--------------wWeI0kBbTs4yj0RUV2n590UU
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-04-14 14:48, Siwei He wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260414184819.612245-1-siwei.he@amd.com">
      <pre wrap="" class="moz-quote-pre">Invalid leaf clears that only set AMDGPU_PTE_EXECUTABLE match the old
GMC9 fault-priority workaround but omit adev-&gt;gmc.init_pte_flags.
On GFX12 that includes AMDGPU_PTE_IS_PTE; without it, some cleared
PTEs can fault as no-retry and bypass the SVM/XNACK handler when a
VA is reused after a BO unmap.

Apply init_pte_flags in amdgpu_vm_pte_update_flags() alongside
EXECUTABLE so range-driven clears (e.g. amdgpu_vm_clear_freed) match
amdgpu_vm_pt_clear() for leaf templates.

Signed-off-by: Siwei He <a class="moz-txt-link-rfc2396E" href="mailto:siwei.he@amd.com">&lt;siwei.he@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 31a437ce9570..a930f1522f96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -693,8 +693,11 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 		   !(flags &amp; AMDGPU_PTE_VALID) &amp;&amp;
 		   !(flags &amp; AMDGPU_PTE_PRT_FLAG(params-&gt;adev))) {
 
-		/* Workaround for fault priority problem on GMC9 */
-		flags |= AMDGPU_PTE_EXECUTABLE;
+		/* Workaround for fault priority problem on GMC9 and GFX12,
+		 * EXECUTABLE for GMC9 fault priority and init_pte_flags
+		 * (e.g. AMDGPU_PTE_IS_PTE on GFX12)
+		 */
+		flags |= AMDGPU_PTE_EXECUTABLE | adev-&gt;gmc.init_pte_flags;</pre>
    </blockquote>
    <pre wrap="" class="moz-quote-pre">Looks good to me, !(flags &amp; AMDGPU_PTE_PRT_FLAG(params-&gt;adev) handles the NPA mapping update case correctly too.

Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a>
 </pre>
    <blockquote type="cite" cite="mid:20260414184819.612245-1-siwei.he@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	}
 
 	/*
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------wWeI0kBbTs4yj0RUV2n590UU--
