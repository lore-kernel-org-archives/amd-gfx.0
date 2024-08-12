Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B320C3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 14:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9235E10E244;
	Mon, 12 Aug 2024 14:34:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QF5EF3ew";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6912410E244
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 14:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hytnc8vv8DXQOgiGAlDAMLON1hG6FSPTFOdzfwl0nA3iEmo9HytsVdgbVweDUQXda1wJ7Sz6QCmcXQaGzO00I+K7b7ddhJfKitPGafDIbyNHqdaJaS/XWIZNBxp66IrHSZBq+MxletRys45xf+8xYxl+xuruAwV7dD55xPw+jfSoflxZgC5NUgAPDI4sRuRE4NmaNg6diWdt97S0qwOakfhrIyHo1gIkB+pi+84mX7UBTQjHvvYHU9vf6Y6O7e2g6c5mUeaFuVOGzuS8kkIZMh7fTzr8i1PtlO8JKB8TP9o6PLA0I5tbC7dBZ5WL9mAtpjzO8s+YA2a9c2WvG6qYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rhy3s6/ED0aRgzNFiiJSoUOLYTd2anOxrAOzOjYq/BQ=;
 b=rwwaaNc+6c9zWr3RPF9/GvllgnpsOYTNFQCYnm9DkEhnv3HUIPTpOzESI8P4vADV3LQNATEyWiD5+/WvfYqfhsL5DuQaOie9YBIrkKlmPjcwWfbA0sfbOJ/oRRCwJJYjn+yosHqJSSviMmAx3iP06QwjMNEpuzvAvRUyY84nFnextDHaCz8HMiVwarqevathqH+Jjqksi8p7XvAm5mAOBxnBjoUCvPQfcGNOsb3rWo0VSF5tW4EbuSS4cyE6AMQ1CSoIrI2QQCrJ2AlSbuWuUHLTxW4yf7ywYbXdJ+ymMowPDbvHuIyyNW2l8OvPHqG7mohJ0w6sm8fy77bSf6icEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rhy3s6/ED0aRgzNFiiJSoUOLYTd2anOxrAOzOjYq/BQ=;
 b=QF5EF3ewxYhtxiyHG5DRLsZ/4u6YOeJV7gvAmbeFQqhXwjEL8CcLQC96R1Yn7i6v0xuaK8EK6eoJvPUwwfgSNfv6ywWbGpkwOojEWe9Ii/RkM2CbmVPNEh/w7IAE0R0muyYDeU+s0oosYi0miZksyT3anHqAU5TKtq7H/O8F8iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB7476.namprd12.prod.outlook.com (2603:10b6:a03:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 14:34:13 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 14:34:12 +0000
Message-ID: <71a30c6b-15f2-40be-9c55-092108f81a68@amd.com>
Date: Mon, 12 Aug 2024 20:04:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Disable dpm_enabled flag while VF is in
 reset
To: Victor Skvortsov <victor.skvortsov@amd.com>,
 amd-gfx@lists.freedesktop.org, zhigang.luo@amd.com
References: <20240812142309.1539884-1-victor.skvortsov@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240812142309.1539884-1-victor.skvortsov@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: c9934ca2-659d-49d9-8013-08dcbadbd5ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1g3U3V0SnlMYUVmVjBTekQzbnNlZS9QQ0dTRklHYUNKVjZOeDJGMHJLbS9i?=
 =?utf-8?B?NXlDY0lTQTEzbkcveUVQUVY5a1dqdXUwVUlTZnFNM0VtTEJ5b0RndDlpZEht?=
 =?utf-8?B?Zkd3dlZRL2ZpRUpGeHhHc3dZZGNSYlVGTitndlZ1Uy9Sd2NqLy9NcG5uUzMx?=
 =?utf-8?B?TGNUZStuSGwxaWsxVzRKUEp1elN0ME05MWlES3BxUGFKZS9oMExjUVh3MFRy?=
 =?utf-8?B?ZFZYd0RRRjMra1M3YXZScjQzaDRyNFN1b0JUL29OT2hQalFHSWZJRTNIZ3N6?=
 =?utf-8?B?ZTNjSXJEbTJ6TGtwQlFCSkFXOUoxNGg2NmFGOHlhazhSZG9DTS9ONGtLdlNV?=
 =?utf-8?B?RHpaMjZmSU9FNjZlQ1kwN3NOYTdPOUMrWHE3UzlwWXVMSkdtUlNPdURtQ3Za?=
 =?utf-8?B?Q1JjYTlSQXBxdkZCTUNRYmZOMTZiVnI1bnBxVGh4U3VYeXdjOWYzM2RsK0Jz?=
 =?utf-8?B?aWMvUUlnUWhyMDIvR01jU2NEVS9VeCsyYTFCNHdUSStjVHplbUljVy90VzlM?=
 =?utf-8?B?K3FxVkZWNWRmaUVGN2I5WEZuem1VdTJ6dHpFRjM4MW1Cdld4UVRqV2FkTHNj?=
 =?utf-8?B?bXNTNDZUd3o0ZFNWYktHSzFXZ1ZvVFBOek94bURnTTNIRDBLbG5ra1JlNlAw?=
 =?utf-8?B?cU0xU1ZGRXlHZWJ5c2JsSUNYMEl3Ujg1dlNjeFBWR0JoNzR4Sjk5RUJvd01v?=
 =?utf-8?B?UnJKRFVCM01rYW9hYTBZWTNwTVJ3MU9JaWR3VzFpWGEzcFBIYmxWL2x5NExv?=
 =?utf-8?B?MnFGcDB5ekVQbmlvUFVlUSt2SVk3ZDM4cFdJUVVpVFZPSHR4ZlVCYWtzUEZ3?=
 =?utf-8?B?NDZSOVJQSSt2Mk9Celp5TGVQM3owYXRvT2tWcG1QSUJmRGFFTzJJejFwQ055?=
 =?utf-8?B?ZVJKcXo3ZlZzUDRCZEJ3NlF6S2REaVFDSDdzUDBhT1ZQcUgwMlBURTFldDFa?=
 =?utf-8?B?dVcvd0p2Y0hhUFhLK1VWV3MwUUtMN2J5K0VzRDFOc2VRbzFRZkVIcW1JYVRR?=
 =?utf-8?B?bHdld25PbDgyTndWcHhRbnRTUU1lZEo1YUZKTm4rblN4M0haNGJmby9sRlNH?=
 =?utf-8?B?Rllmd0hOaDBuWkxtNS8rRmQ3SVQ2ZGRySU1nOUpnclZWWEd0REZuME5BWmor?=
 =?utf-8?B?cXVVTmlCMlJvdmhYazhraVNHdlVmNjJZZTFBVG0rSVljVnBwZDlsbnpqekFV?=
 =?utf-8?B?T0NqTHEzb3VXbHdOL2NiRlB3S1NvbHdIQVJSdlo1VWdyYWVQTzJwdWMxNDdn?=
 =?utf-8?B?Z3VXcEhuYksrQW00UmFlc3JLa2RhalZUeEJJdnJqM1NONGdlajZyM00za0xP?=
 =?utf-8?B?eHJLUEJzWFN0d2hPK2tKeDh5NjNKbG1IWXo0SnBJL3E4NGpCWmpTM002bTJG?=
 =?utf-8?B?VVBDVUFLZjJLTXphWE03b1Z1LzJvZmlhN1pERVZrODJSM2taSGtyTzE0ak0z?=
 =?utf-8?B?Vmo2RWcxTHFGUmRDeFRiQXBkM0pYTkxpRmQ3Z3BKSzBIU2hNdm41MDJhKy9J?=
 =?utf-8?B?dTdTUDhuYWNkZUdkcWZBYmxLdmYvRE5SUnh5elpzb0NhTG54REhibkoxN0pI?=
 =?utf-8?B?OWo5NzlwUXUxczhUblB6RGthSy9UTlBVMi9lMXZpL0FCY1JRa0taSHpoYjEy?=
 =?utf-8?B?WVBuRUpBMDBFRDl0YzJDRnpIaExQbVVuSDJIQ2RMWW5pblRTbFlISnhxcUw4?=
 =?utf-8?B?dDhBaUd1VGI0alBwMEhUR3RCUTZNdUE1amdNcmw0TENKbkJMVytwVDMzck14?=
 =?utf-8?B?Um5nRWtNR0xlRjhmdGlNTzB6aWxDZExQd09taURDZlFDMWk0NDNTOXlUYkty?=
 =?utf-8?B?QndBYkZldE03RmpTdlRqdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzRlbGI5a2dWcUZ6NTkxcDNFOEpmWjBJbkhnSkhxRlhudW5qcng2TWVzenpl?=
 =?utf-8?B?eHg0SWVuV3owczFwVEFLU0JyM053UHZFZjN0MEordDVDb0lOYnJ4eUNuTWpo?=
 =?utf-8?B?cm1TZlNTOWh2UmJ0WVo0MDRHRjNOMWhJSkFmejZEZG9PWmxKUlVyVmxSL3VP?=
 =?utf-8?B?aWxERWVXN0g1VkhjNFE1Q3cycFRKc3hCYmFMam1jSGZldkovTENxTnp2YU9Q?=
 =?utf-8?B?UjdIWnJqRGFNeTRtdXk2YThoc1BOTWtjajkxQm1HelZmWmUxcUh0ZGxzT0FV?=
 =?utf-8?B?bDAyRG1YN09xb01NRXBJOVZOUUFmdUdESnhod1BVd3hlQ3JRMlhxTzE5bXZi?=
 =?utf-8?B?Q21DSTFtVHpVOEUyWU82aDlxZzFjMDFtMktQaEZYMHlTbjVtVHFJYm5HUzB2?=
 =?utf-8?B?aThCcVM2NlRtT1d5RnRKdFFtaUxWWGEyWkJLb0xSU0xxNFF2elc5SW93TlQ2?=
 =?utf-8?B?elZqQTJjWmV5bEdJb0pubjlyK0V3NXJjRDgvWWNGd1R0QTUxTkhkTUcvV3Rn?=
 =?utf-8?B?eGVPWWQ0NW5wcDJ2dXhldmlZUjJZY2NaSDk1cVVFT3VEa3cyQjFnNzF6VWdN?=
 =?utf-8?B?ekhYRURUWlkvLzViaDR5ckFVSm83VzVZV1BIRmhQQlo0WkhDdU1iWHJGZEFO?=
 =?utf-8?B?cmxRQlYvOGQzN3lNb2h5RkZneWN3aHUvN3VtTmo2MEhhbmV6cXMvbVhqSDhx?=
 =?utf-8?B?OUJlYkRNVEFuZDF4UktyTVgwa3NrS2Jjbkh6YnpEWjZlRmJqSDRhT0EwSmxy?=
 =?utf-8?B?MFhWdHlDV1daTWlEU0ZRcnA1TnFKYUIxV0JwMzFUZmpUeDM0L3lXbkVHYkFD?=
 =?utf-8?B?L0FaZTQzOVI2N1hKSDVDSXI0RUFBRk1WU3EwclRBdzV3dCtrVm1MQjlpRDNr?=
 =?utf-8?B?Zy9YUkxSVjhkRnZmS3dpTmFIcFpJNnpMRXBCV3dXYTN4VzdTTVFSWW5pNXli?=
 =?utf-8?B?ZWE5U2dLbXVGZ2lxYWcwNWNzWHF3OWtYaFRvWXRFUnVob0JJNDFxQnd3clB6?=
 =?utf-8?B?UUEycWxIZjNhV3AxT0hIa2ZaRU9FazFJUSt4ZmJZQjlEaVRpRlM1QlNlRFdE?=
 =?utf-8?B?TlVNVURlUHdPUlZ1d0ZZRW0vQWI2T1RRb2hOOGpoZndrVHp6UStmMkZycGwz?=
 =?utf-8?B?b3VaZ1R4dnRweXdRWHN1TituOTgxdytkOUpCQlI5TzV0RUJXOVk3Uk1DdGI5?=
 =?utf-8?B?WThwZjlMSFVaRElZa0hYNDdlRTBrZkp4M0pNNFkyblg2aGZUMnZpYTY2NXZw?=
 =?utf-8?B?TWkyenJPSjFOWXJRM3dnS1ZHNW44MzV2a1JpbG05Y3NzVm92WlZRZU5lTDJG?=
 =?utf-8?B?SUdibUNNUHVleWVPZ3IwcVFBaHpWdGRadkp4MzdsQi9GTjNVdUp0WWczd2hy?=
 =?utf-8?B?QjFBRUJ3SVVLRnhDY2JleE5uaHNxR3JrWERSYVZGdE9lZWVwM3l4SUtBWGJo?=
 =?utf-8?B?bTkrVFE2ZkxZbkFlOGxuNW1kSm4rYXJjVEV2MzRab0N1QTF2NTR0RXhRbktk?=
 =?utf-8?B?cEtnSXNyd1pPSmk4cUk1K3lhMWhIeVpnbjByNUFiUkxnTlk5MndUYmZ4dzVU?=
 =?utf-8?B?dEdmSTg2L1RZYlB2aW5Cd3JleVZCQzJCQURUa1ROWll1TFl2dDNFZGxKb0hr?=
 =?utf-8?B?aWZRanBCLzMzQzVrNmcyZUU5RkkyQ25ZSUViTk9HTDlyMm9sbjJ4Zm5vS09i?=
 =?utf-8?B?RmF1b3RCRG51UkdhSGMzcjJYUFNwMk5sbjY3MHoyRVU1Rk02bjJrUE41YURC?=
 =?utf-8?B?bDh3M3F2My91ZUtNN1J2WFp5SzlhZ01WdWlVVEdLVkNnZUZQK3dIbjZYUmVz?=
 =?utf-8?B?VjJIaHZhZHpMUlljekpoYkxJUmxCQzN0NytSZGI5aFlxT2hLV3ZiRHpTVFo3?=
 =?utf-8?B?ZjdseUt0NDdiY3lad2REYllhTFFhclpUOEN5cytHRWJldEJleGc1WmRzem1L?=
 =?utf-8?B?WEdxczdCTHU5NU56K2h2eXJYVFFLMTJsQjhNalNmeThEcGN4bGNaODJGbmk0?=
 =?utf-8?B?L0JVUG5KSVg3RnFVUlAzc2M5cnNBQVVkS2RWdVZ4S0MvMGw5VHUwUW1CVk16?=
 =?utf-8?B?dFU0ZmdkU1V2bGlsb1ZkUGRKQjZIS1hLUjFMaU1KTWswdjFWNzNiMEd3MlZ4?=
 =?utf-8?Q?x00pIE23A0puxNEqpVd618PVG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9934ca2-659d-49d9-8013-08dcbadbd5ba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 14:34:12.7772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbP3JmJ6pTQWqDIZuKdwhUDLHqY/Mb5MYASALYzCtinygwcD7P7nZNFDisFxa3RG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7476
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



On 8/12/2024 7:53 PM, Victor Skvortsov wrote:
> VFs do not perform HW fini/suspend in FLR, so the dpm_enabled
> is incorrectly kept enabled. Add interface to disable it in
> virt_pre_reset call.
> 
> v2: Made implementation generic for all asics
> v3: Re-order conditionals so PP_MP1_STATE_FLR is only evaluated on VF
> 
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 6 ++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c       | 8 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h       | 1 +
>  drivers/gpu/drm/amd/include/kgd_pp_interface.h | 1 +
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 6 +++++-
>  5 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 29a4adee9286..a6b8d0ba4758 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5289,10 +5289,8 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>  	if (reset_context->reset_req_dev == adev)
>  		job = reset_context->job;
>  
> -	if (amdgpu_sriov_vf(adev)) {
> -		/* stop the data exchange thread */
> -		amdgpu_virt_fini_data_exchange(adev);
> -	}
> +	if (amdgpu_sriov_vf(adev))
> +		amdgpu_virt_pre_reset(adev);
>  
>  	amdgpu_fence_driver_isr_toggle(adev, true);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index b287a82e6177..b6397d3229e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -33,6 +33,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_ras.h"
>  #include "amdgpu_reset.h"
> +#include "amdgpu_dpm.h"
>  #include "vi.h"
>  #include "soc15.h"
>  #include "nv.h"
> @@ -849,6 +850,13 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
>  	return mode;
>  }
>  
> +void amdgpu_virt_pre_reset(struct amdgpu_device *adev)
> +{
> +	/* stop the data exchange thread */
> +	amdgpu_virt_fini_data_exchange(adev);
> +	amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_FLR);
> +}
> +
>  void amdgpu_virt_post_reset(struct amdgpu_device *adev)
>  {
>  	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 3)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index b42a8854dca0..b650a2032c42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -376,6 +376,7 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
>  		      u32 offset, u32 acc_flags, u32 hwip, u32 xcc_id);
>  bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
>  			uint32_t ucode_id);
> +void amdgpu_virt_pre_reset(struct amdgpu_device *adev);
>  void amdgpu_virt_post_reset(struct amdgpu_device *adev);
>  bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev);
>  bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 4b20e2274313..19a48d98830a 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -218,6 +218,7 @@ enum pp_mp1_state {
>  	PP_MP1_STATE_SHUTDOWN,
>  	PP_MP1_STATE_UNLOAD,
>  	PP_MP1_STATE_RESET,
> +	PP_MP1_STATE_FLR,
>  };
>  
>  enum pp_df_cstate {
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 8b7d6ed7e2ed..9dc82f4d7c93 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -168,7 +168,11 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
>  	int ret = 0;
>  	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>  
> -	if (pp_funcs && pp_funcs->set_mp1_state) {
> +	if (mp1_state == PP_MP1_STATE_FLR) {
> +		/* VF lost access to SMU */
> +		if (amdgpu_sriov_vf(adev))
> +			adev->pm.dpm_enabled = false;
> +	} else if (pp_funcs && pp_funcs->set_mp1_state) {
>  		mutex_lock(&adev->pm.mutex);
>  
>  		ret = pp_funcs->set_mp1_state(
