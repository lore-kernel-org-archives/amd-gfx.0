Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE6FC87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 04:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C158F10E4B0;
	Fri,  8 Aug 2025 04:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v20YreXH";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6A210E4B0
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 04:31:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9rbU5k3oqUi+F/SJGKxbLaWCu4Rpn2jEBOY2sGlXcABYibbz60lbR/by17b9e/Rat4pwAwd02555u+22IEzVNhF/mqhXjB8hEcrY+9+qwit7o5frz0BKUag7sP6e9FiQoUhxPk/r4bHUx8zrxRWRqPub+bnql6eALhPF+JeRnqA7BNG6jVazgZIc57E6+Ymp6AkgoDnt/bjXoOXLhQZqFizSWZkz8P06QByQ3/wvhm8huhIb9tg37SZq1Z7KZyTJcvCI8KZcFxTD5EStv1CFUBF54b+fY8uRH7wr9rL1Af1pNWEkxSjWSixexGoF2hhZw64rBUStX+WixmH3Q7deA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwtdz/IncKRxL+hunOdWbm6J/+7zyl1Gar8m92ud26g=;
 b=pUlcue9fWh7d5ebwLGw/2tlu+vIePttVhn/KQP6tsnejScq+N9Zsm1BkTiTQNFUGmTP/uwsi47LZvU9ris3B/pJfTT5Nrz+HLXdcm9qv3KQi0+fz+4CorcmFTvQq0+vxFuzmTqtgSvmyO3ewlb17vt98U/Kzq4wQWJTAuyAYGLanhgbGbCbl5qODFSGVOEAQdyjEarNmY+PpMA0gPM6blIgI5QAqwSMODlqt1HIRfPoUmTKS6e/BXhUwDsniB3JWXAyIaA0d6UiRMbZwnLnCJzHYdFxjFgCodpJONbObAWAMGTHtMc3OFE1HnzGar8Xd7lp7Awr7XBEgAy0aG6ATlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwtdz/IncKRxL+hunOdWbm6J/+7zyl1Gar8m92ud26g=;
 b=v20YreXHjkk5Qvcjrc/wrwIDYDkFyhU9xrHjae7QQYNThNbGOB0tFxS7hieJmlwyFlZIhtIETJzWS7jmJ3EP/fhexFI89OQJ4ZfmiDRWci1ntw1j5mYW73vWygbWXXcYJvvwxCjOjVJeZ6qDYQ9hOIInlhECR/p81nZiEL+iWAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Fri, 8 Aug
 2025 04:31:50 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.8989.017; Fri, 8 Aug 2025
 04:31:50 +0000
Message-ID: <da029fa0-b1cb-447d-8384-7fffc106a5b0@amd.com>
Date: Fri, 8 Aug 2025 10:01:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix nullptr error of amdgpu_vm_handle_moved
To: Heng Zhou <Heng.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, Emily.Deng@amd.com, Victor.Zhao@amd.com
References: <20250808031427.3131402-1-Heng.Zhou@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250808031427.3131402-1-Heng.Zhou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::9) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 730a7424-1888-4e70-18cf-08ddd6347e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0oxUkZRbGRNc09JOVZqMjZOSjhsZXExZ08rQnpRQXh6aHNhcXMvSThLUkl1?=
 =?utf-8?B?bUlLM01TWWFyeE5MT0RCWkxueFF6R2NyTXIxV2t4QmxVSDVBNjljdzdqSGht?=
 =?utf-8?B?VjRqMHo4Z3FMT3pVR1dqbE01OWhiVDhhNUxGZkJiYjcrNnp4ait0Y1k3TG5N?=
 =?utf-8?B?ZVRhRzVlTkgvY0JNYlVzOEEycW1UaU9FbEhaSTRPMGtWakNmSjdqMVRPSU5U?=
 =?utf-8?B?elRTT0trTmYvWW5aWVozR1UyVjBxN0JqT09tQmhnWmlmanZsV2t3eHJXVEJV?=
 =?utf-8?B?NmZCTGdOTjZuM3lBL2Q2dXdaZGJJZ25PTCt2RnErTEdtejVHOThkSktWZG5V?=
 =?utf-8?B?THQ5aDJHelg2dCtUZXFlaFBVRVFXNUNGeGxyMmpidXA4VDE0UzVJRFZSWkpV?=
 =?utf-8?B?cFp4Ynd3QjNEaDM4RjhGamFieFE4NHY2SlRXb09jVW1YZ2ErblVNR2tkZm5G?=
 =?utf-8?B?Sk80VEROaWRYSEx1bjhUQWxkVnk5TWVtdWMzM1VpNjVVVTZYekV5SVViMUpx?=
 =?utf-8?B?ZGM2a0R3Uks5VlgvZzVETDAvSkxBWElIbU1WYXZOL3N4cGhxZDZuSjgwbVd3?=
 =?utf-8?B?NUhJRnpDdXVyb2lGVWsyejBLb3hpaFFzc1dQWm43UytHNWgrVERiMHBPY0pF?=
 =?utf-8?B?b3hiUTBhY2xHVXA4Rms1VWpaUTlnbjdUZG9sdnVzb3ZqdFVoR2NhQ1VUMXdD?=
 =?utf-8?B?U0phZ3VlZmxMNy83TjQ5cXZIZDhQYXByVlVBdzdoUFExY1JPVStwRXZlVk9U?=
 =?utf-8?B?M0xPRThXbDRDeVVGZjRlYWZMQ2NJTVJwV2gvRE84cmNneEZDVHY3M0JIWVNY?=
 =?utf-8?B?TnNzT0ZYY3BQV2ZiZVkwN3NRb1FXc3hiOG01Nml6TEZHWVpOcGJDKzlKNnFt?=
 =?utf-8?B?dmZ6T1VwbnJVOVlkVG4ra1E4bkRTK2pWclRhc3V6dVB4TklOZ2F6OCtGRnBu?=
 =?utf-8?B?NTd1U1ZocDRUak1Eb0EwNnZqY2R2NTIyUGFuY0xKcWpnelJ5Y0p1anFNRkEw?=
 =?utf-8?B?QVpRVEtNWUxhd2lpL1djeEphSXNXMzZFTy9kcXlZbTFQMTdDSFRiRlZSUlNJ?=
 =?utf-8?B?clhBQXR4VlkrNUNQdDNKd1RIUmMzdTNDd21mY1hNWmxMaXh0VVd6amdXR3pp?=
 =?utf-8?B?RzVySkJsNSswVmxNN2NQZnFZNnNobFA5eGszalNFUjNxRkljM1FVWTI1bVdN?=
 =?utf-8?B?ZTJXSDZnY3U4amNjMTU1MDNhbk5zN0c5VjRReC9IR2l4NVBJdzFPS0lXeHhR?=
 =?utf-8?B?VlZENEp6YUNxSHFlZlBRc1NpSVQ0OFFoMHl4aDlneUxqNkpPQVQ2SExDWUFy?=
 =?utf-8?B?aXl2SFh5NDJwQ0hBd056a1daRGRwbGN0ZUVkT0tOUlBkYjJaOHBZaEU3UDlw?=
 =?utf-8?B?eGNWd01TOGFsOElaK1F1bFJ0QmRqeE5oNlcveEhxcHhPVnBmd2w5VDNvK25U?=
 =?utf-8?B?VHoxd24wV3o1Yng3VU9FVU5LUXRrM2xJN0hvU3J0dEdhd21mZ3BDQVRDc3dw?=
 =?utf-8?B?RU1PaGF1am5waXVkQnlZMDk4SXBEczZCSFYxSktRRkkvSXY5ZTVURjVZRjBZ?=
 =?utf-8?B?ZTlMcFJkTFA0SWdXeTdlNFg2U2hIbWFxd1EreEE0UUpLd29xK2tDMmEzTWFS?=
 =?utf-8?B?ZmZaUE01OG5qMTBUY3RITzhRdVRIczJKeUplbWtaa3lpUy9sOGM4UnJMNHJh?=
 =?utf-8?B?R2ZhK2RrQms1MHprWFowdTQ4QjZ2OUkvWURnVFp6Ykc5TGtQOHptRC9rbk1B?=
 =?utf-8?B?UVlDWUo5bmkvSHl0NG9HYmZFRTJ6UkxkUktvKzBkcUg4eXg2dG45cWt1eE5k?=
 =?utf-8?B?R05PSjExdnJYdHBxd0F0WWM3aWdLZUFaWmprbGw4SVZqdGpVQUMwSTIvaUp2?=
 =?utf-8?B?T1ovTXVkbEJDWnBZdTI0akR6ck9XNFJ3dHJwSlg2aDZIcFl5RXgyUDlaNnc2?=
 =?utf-8?Q?69b8LAp0Bow=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUZWMzlQczllSU8wb1QzOWt5MnRvK2FVZ2t2cDdWTXV1cmZoNHNCY1REei83?=
 =?utf-8?B?cWY3V0FMQTFlejYxOTErZG8zTkhhOEo0eUtqVkErQjVlbzVOL2N1cy9QZ0tJ?=
 =?utf-8?B?NDV3ZHJoYUlxTEFpakczL0E2VFFHSnFhV0dHa0lHTWhVWGZtQzNNZ2g3eEw5?=
 =?utf-8?B?MmdKd2YyZmNSaWZ6TlNzUXRTUDZoTmtjLy9sQ3hiaFkzajhJL3pGRnJyVUZq?=
 =?utf-8?B?Tmw4ZlJWSndUZG1kVG45WWdsRHB3UGJSWWNTZUZTTUEzMUlJcEo3TEpQeHZV?=
 =?utf-8?B?WUxhd2xkYXhYeFMrQ0lmYjNOTE9Odi8yLzgveksvZXpnZGZkcWlETUJsU05v?=
 =?utf-8?B?bmxYVFM3NXQ1eXVITmZYb1g5V1RDQ0lqQXlZMVJBMmdZcXBLWExQUHgwdGp3?=
 =?utf-8?B?ZnR4UDRadndHdEhMZ3lOa3BEbXo1S1VCbEE3YXJ1eUc5UExKbmVTYzExcENP?=
 =?utf-8?B?WGd5cGFpZGl5eGc0KzNzUnlUZkdUazdHQS9Mck5QTk8zZEJ0ZVRiVktpMnd1?=
 =?utf-8?B?aXpUengrOEJLWW02c0dNZmdaeGpObkY4T1FRMk0zL2FvejBsR1JXTWdqU09R?=
 =?utf-8?B?amtVSStrMEp6a3U1WlZkQXpjR05OU1NEZmxPY2lac3o0aFV4NlFKRkM0MDVy?=
 =?utf-8?B?MDhMNE9OY09CaWt0dlROUWcvcTYwRW9jOGcvblE2M3U5M1orbWJZbCtuZ3dk?=
 =?utf-8?B?VE5IbUNmMGtXbmFLem03V1J4WlY3SFpKenB6MHNuWmpGTWxkTzhFQTNadGNJ?=
 =?utf-8?B?VmE1Ui9lU0VkRHVReDJUS0dxNzZiT3MyZ0FPa2FjWjdLNmdaRHVzUDlPR1kz?=
 =?utf-8?B?dVVRT1pyRDVqZVk0ZG9vWTV6aFRtZlArRWl6NENMN1ljNGJZMkRmQ1ZrbTUy?=
 =?utf-8?B?V0U2NWlVaU1kbjJlL1E5OGZCQlVaSnBRdXU0amx3YlRmQmdTM29iemU1a1dX?=
 =?utf-8?B?R2hVMFQ1anBoeHB0WlFtMk9UcXV3SjZ2MkhGdnJnb011Q29JU25kN01OOUhQ?=
 =?utf-8?B?ZUt5elVTUlJyd2dMK0lhTFQrNzJ1UFhmYkxkVVMxeTNyQ05rdDk4NTlzRGpk?=
 =?utf-8?B?T1VhOExyYnpETWJWR0l1Ly9RN08raks0ZDZnNENEREpzM1d4Y05qbmFCTSth?=
 =?utf-8?B?N0oxL3p5dVFMVWFRT1hRcnBKY01XWmpRcm5SVFg3ZitwcXlLUTJhdFV2b3RC?=
 =?utf-8?B?K295cTNMWmwyQ29CVEQ1RllyeDZpVmhOclhIeEcvTGZSMkFIeEZrUGFmd1VK?=
 =?utf-8?B?Rk96NFRTSUtXb0NvUkxlaS9VZnRxcUQrOFdtTGVuM0I5WTVjN3UyZDNoRFZD?=
 =?utf-8?B?cW16K2NjektaMENwTkZFQXJvOEhxQ2ZodE9XdVBtaGFQNEhVTzFCeVUxcFZW?=
 =?utf-8?B?V2prUG5VQTRXVmlhcEJKeEs4SEEyOU94Z1o4bWJwcWxoeHVxNkcvNGI5TDBv?=
 =?utf-8?B?VTBaMXlYaVhzV0s5L3JwMHczM1RWdXc4U29iT1lhUGZ2aVV4c2hBenhLU1lH?=
 =?utf-8?B?elFyWTB0MmlTVXREWXF5T0g3ZkNSZWxUTWZJYmttVGtTVnRKRWQ1SjJrKzNM?=
 =?utf-8?B?UzI1OEZnTVBvYy9XUHEzd0tPMlFLRFRkR0gvN00wR0p3Y3FsOFdjaGk2aVdE?=
 =?utf-8?B?TGhoMGJ3MzQrNkJLV2E0VnprSklXVnMwSWRWdXljNXFma05qZE9PaHFIaVBv?=
 =?utf-8?B?RlRqOERPNFhlU1IwM2lWcDZiY1JvelhTMVdmWGg2dFkzM3ZTSFpMYWV4SXc1?=
 =?utf-8?B?WWpObW9ZRXdmSW1PU280elFQc21IVFY2UENxbHVaRWNtS0tYeXdwYi9VRTFN?=
 =?utf-8?B?ZzBNOVMxb3YvSEl3dWx6NzNOL2dtM0Q0Q1J6Mmw2Y3NSeXAwWjlUZ05iVDdu?=
 =?utf-8?B?aHk2Y0JGUmt1bjNacU9wc1Jjd3diNktQTVFrdllrMU1PL0RSeEtVK1V1czg3?=
 =?utf-8?B?Nkh2Q1gzeis2d1pOSmc2YnlQRVBUY094cVB2UDJrZFRhLzVWTDJKOThIUmc3?=
 =?utf-8?B?Y21ZaVZCNFozdEhxT1BXT3JwTCt0a1VHN3YrWHdnREE5NG5Wd0NXY21sSXV2?=
 =?utf-8?B?UzI2dGJZdUJpTkMzK25CK0VXVXNQM3cxODlqNVEvQk5oOWNJWml3a0p5Z1BG?=
 =?utf-8?Q?JC8vSQ2ps3zE0xJkBwjg1xcwm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730a7424-1888-4e70-18cf-08ddd6347e5e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 04:31:50.4214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIH3NgsQ920Il9dQMDsg8s2RGVnYMIInIP00+5rwjYV9nUEf9jD2zEvU0rl+LjM0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391
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



On 8/8/2025 8:44 AM, Heng Zhou wrote:
> If a amdgpu_bo_va is fpriv->prt_va, the bo of this one is always NULL.
> So, such kind of amdgpu_bo_va should be updated separately before
> amdgpu_vm_handle_moved.
> 
> Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 8 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           | 1 +
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 37d8a7034a7e..e795b2970620 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2970,6 +2970,12 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>  		struct amdgpu_device *adev = amdgpu_ttm_adev(
>  			peer_vm->root.bo->tbo.bdev);
>  
> +		ret = amdgpu_vm_handle_prt_moved(adev,peer_vm);
> +		if (ret) {
> +			pr_debug("Memory eviction: handle PRT moved failed. Try again\n");

Though this follows the existing format, better to change this dev_dbg
and add more details like task_info/pid from the vm.

Thanks,
Lijo

> +			goto validate_map_fail;
> +		}
> +
>  		ret = amdgpu_vm_handle_moved(adev, peer_vm, &exec.ticket);
>  		if (ret) {
>  			pr_debug("Memory eviction: handle moved failed. Try again\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 283dd44f04b0..2c2a93f22ba0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1569,6 +1569,14 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>  
>  }
>  
> +int amdgpu_vm_handle_prt_moved(struct amdgpu_device *adev, struct amdgpu_vm *vm)
> +{
> +	struct amdgpu_fpriv *fpriv;
> +
> +	fpriv = container_of(vm, struct amdgpu_fpriv, vm);
> +	return amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
> +}
> +
>  /**
>   * amdgpu_vm_handle_moved - handle moved BOs in the PT
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f9549f6b3d1f..853a66f9fd2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -504,6 +504,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>  int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>  			  struct amdgpu_vm *vm,
>  			  struct dma_fence **fence);
> +int amdgpu_vm_handle_prt_moved(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>  			   struct amdgpu_vm *vm,
>  			   struct ww_acquire_ctx *ticket);

