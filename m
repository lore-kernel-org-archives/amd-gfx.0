Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1FEC3DA4B
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 11:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B2310EA6A;
	Wed, 17 Jul 2024 11:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L4Wzo1lf";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 783F910EA6C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 11:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQPlLyaovpK/UR/Vj3C9xV5CJ1Cpf/CNMYqWmKA4X2z3kCeEwoUMVCybk463OkAA845J+VgIWzg+4J+NUjAYkVYewvnGYMrvIbmhc4mKbH9BpPeJuIgcG7jx1RJL2rmHHZCXSEJdteEsoHwMbSTSnRAqcw/CUIqiC3Ou77irMJK3D6/Ia3JnKpPG4r5LVJmUwAgFUBKtNuFnpea+wtRph2RmpgT3yaJ4mzABvh/3Tygqk74PJ1Ip+sqlllKtSGtUg6JQLbW1qO+pVG3CZTraKZ28A2ku83GcZGp8w580lEC8qlYh4pFV45iEVRF/NlwYsFWVzX1jzC6OjGcI/j/COg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u689l4GKRoVCSCNRousdhf/xl7djVGt69wmVlBALSJQ=;
 b=XbPAjQoTt1K4Nfr2mQACfgP9n3CiXQUNyXOhIanjdgDFH/mc7lAVq0EKrMahGJzeu7ysx/e31/JenydepKXZ05pfzQQ/yeARJdl9JASCByjs1RYgl/UwvYmLcJbJk7ShhC4WVLrAgZiZ5MyQQV9MmwRTYQZa7F7wkohWwifI1wtVUum3Hnlb80vlK41YTlzE83TC0qFkEuOmuxKX6ftx2VgszAunoLDq9ekLZR6LxnWEF+tusPBUlhrL+JZS1qCWQz5H+n59dVjZxLabCFJIzSUTfOI2IK5jDHN5G0W6FuPv89hLAmb8Go4SxtQmPRqvhA7LsCMiyUKOG9xwdyDb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u689l4GKRoVCSCNRousdhf/xl7djVGt69wmVlBALSJQ=;
 b=L4Wzo1lf3nMZX3RhJmjafbj5i2fKJV7QxcXTMLvgwrOiCECDfPcaGM1p5kbPzZQEc9PKTAMhrD/3AJBL2xsrs6RlJMhowe15s0Cid7GcWVLbAGKht2ux+dv/bfS0kQQVWfRpNmIHnhbKpG3mopXhRC/bPZLA/2rOk0TZa59adl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.14; Wed, 17 Jul 2024 11:08:09 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 11:08:09 +0000
Message-ID: <75ff4608-4b2c-443f-acd3-0b97682a9403@amd.com>
Date: Wed, 17 Jul 2024 16:38:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/vcn: Use offsets local to VCN/JPEG in VF
To: Jane Jian <Jane.Jian@amd.com>, Haijun.Chang@amd.com, Victor.Zhao@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240716084703.196194-1-Jane.Jian@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240716084703.196194-1-Jane.Jian@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW3PR12MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4dae0b-1edb-4a2d-11ec-08dca650bd92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkRoQngxSk1NejZNWFRnaGNjUFYzRVVoMkhGSVZZaTluMlN2b3QybitxQWx6?=
 =?utf-8?B?Ly9oS3BneUtkZjlqdEFTRXB0SlJJeXJhRUVxUjY0VGtDTmloK3RHWU9MTjFL?=
 =?utf-8?B?Z05wNWsxcUtieVlXbDZlWXkya3Q2d1ppai83ZVRCUkNQS2dyOGdMd20rYTFW?=
 =?utf-8?B?alUzTGYyQjhCdks5TS9FV0RzWlp4WWpkZFNvbWhPbit2bERObmY4aVE5MWZr?=
 =?utf-8?B?UnAwemVTa2t3Smg1VU9EN0FKeHBTWHdGL3FvcXlBVkdnQk41ZXovQmpUWVVs?=
 =?utf-8?B?Zi84R0hXRkhMc1RFd1RqZnVtejJJVko4ZGkrNzJvYTc3N25qeEFyaTIyNmRM?=
 =?utf-8?B?cjFWV1Q0azFNZmhNakVMeElQYkVmejl1Nm51WGl0c1dMY3dINllGVmFKdjBM?=
 =?utf-8?B?V0NNSkFLK2pCY2hXaWVzYmZZMFJoeHpjaVBWYWUxQkJSbGZmVUdDN0N6cWZW?=
 =?utf-8?B?L1hwTlJYUzNVMWVDUVlTTjl2MjR3SUM5OFBmM1BzekRlc0tJRS91Y1hJQk1v?=
 =?utf-8?B?bXgzUmRiQmNmQ1Z5Q1FxaDI1cXFsVVA1OXF0ZnVnNm51KzVVTnNnTlBRVktv?=
 =?utf-8?B?UUwwSmpYbWJ1OUlUMzhiTi9QSGNEckNjZ2x6UVlZOUh4Ymh1UEdDOEdaa2Qy?=
 =?utf-8?B?c0xRa3FUVU9SZ3Jra1Vkbzhyb2FHYmJ4OEpvUGU2MWMvZGdjcS9FTFhiRDQ1?=
 =?utf-8?B?OWxFdjdUd24za2dzL3MrM1UxZGNTclR3TkJTL3BCOFd1MEZZVnYyY3VBTmV5?=
 =?utf-8?B?MGtURXI1U2k0YVYzSzg1Sm9QS2pYOHFZTnBhaUZTQXdxdGVEQTA1Skwzenpj?=
 =?utf-8?B?QUhTRHpQZzB6eHNGcnFUdjNpdzJxVzZ4QVVoTkVWaWVXdEdXRTFmYmlGTldZ?=
 =?utf-8?B?V1EzZEdxZzBHNGdjTDJmTUlvMHdGeUtNaVFWbnN5cFdHSEN0M0JxYkhKZkFI?=
 =?utf-8?B?R3NQaE9FYmk3eXpmRWZldklIYTRyYTFOMFg2clNqNjNweWdaMXI1WnRhV2Yx?=
 =?utf-8?B?S0lpVkYwT2RZbEhTaWFzcXFkRkFaZXYybklNdG5zamNoY1hod3ZJYmZsME1o?=
 =?utf-8?B?V0lCQU02c282bzMrcDM1dFFWNk5nOHpZRFdoUzZWUmQ1Q0tFb3dmM252YXNn?=
 =?utf-8?B?VG9IR21GaCtLWVp3ekVQQ1Z0NXFmNlBETjdkNzNVQ0MrQ0lGTXBUMWgvTjJM?=
 =?utf-8?B?S0kzNHZWMVBTMU5vUTJyZ3NwblNpY05Ybm5PSXcwOVJqOGlrdTU3QytCM0dB?=
 =?utf-8?B?WnVTZG1iWHBvWk5GSzBnL3RUdkVKWktzV0ZQQklKNU9RellTVld2OXN6V2xM?=
 =?utf-8?B?VXdHaUdEbGRnTDllM1FEb1pXeDZQOFNSRFBYYlhveWg2UlZZOTA5aWhESUFR?=
 =?utf-8?B?VDJQS3NQdmF0UkFyc3VQV2w5Sy9jVXhQTE1pQ2J5MlZxYVpwcFM4YWdKaTBY?=
 =?utf-8?B?TVBkUDM2bUNlbE8yY2Y3Y1RiQzlrc3NpbEltUjcwNjdaZm5zazRBMGNjWlNF?=
 =?utf-8?B?TTFHQkx0Z2F6UHVvQ0xHa0QrelBGRit5bnlEQytsc3dydlpNeEdCb1Q4M0tO?=
 =?utf-8?B?RzYrL2tiUlhERVRkZEFlZjNjZ1UzdXEvNnd5ZmEzMTZEeTB0bnpOTnhXcUlj?=
 =?utf-8?B?UTR6eGtMZnpBekRMSmNTZTZNbW92NHpJSWt0dGlTb0xZd005T2VYWHBuVmZv?=
 =?utf-8?B?R2ZnVEJnL1BOYmNiQWNXYk9BVjRCcGVQSUZzOEZNRVJBUWR3dFkxQUIzcGMr?=
 =?utf-8?B?d1ZKNEIzNG9DVDRUc2hyWm9jeWVTVWZmWUkrdlVZZ0FvbUxkcW5ObjJJbTRV?=
 =?utf-8?B?dVg4T3J4OGdYRWVFSHJTdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3Y0Rkp2SnJxRFBSYTltbXVlMGRYSGRCQUpyZE93d013N3NqcmxLdFhwcWE2?=
 =?utf-8?B?cWRhWEVldVFxczNTVXBhUy9rcjNOUm96NjhwNWtUN2Yyc2hrNThiajdqdEhR?=
 =?utf-8?B?Ni9ZbTBNK2tvam11VmlZZEE1bzlWaHRBQks3TVUySVYzMVNNdE5iMDFuTUFH?=
 =?utf-8?B?UXM4Uk5ieWsxTThnem9tV3FrQ2xiMk5zaWRrL041ZS9HVXd6MGxrWEFrclNE?=
 =?utf-8?B?Vk5sNGlkbVprVTJuWWJON041RDlmS0Z2cjd3emdUaW90UTZQVk1OMlNWQm1r?=
 =?utf-8?B?MGVnRFpxcjNoSjFzVFB4Y05mdVo4dFQyUm1LN0h3K3V2emVPaDRJYXNDYm1x?=
 =?utf-8?B?TmM2bmRMQ21Cd25vdG0zUDFQQUw0dTVxYjRZZnRDME9vajNXMFJnWTB2Tzdx?=
 =?utf-8?B?djB2ZCtZRzAwOXN2YjNlYVVheDZuZTFuYllObDV3d25ab2RiaEJTUWYrWTF5?=
 =?utf-8?B?MG9jektVNE1uMGw3YVpvQkRING1pM3VuQnREUjRlM1NWTXhFWVJiUk9aZFVt?=
 =?utf-8?B?NjJBUFRVdnN3VFBCdVpBb3BJRlVDeHA2TU5RZTFCc2J5dFZqMnB1UFNESFda?=
 =?utf-8?B?ZGFabFNiblVMRW9oRmQ0ODlWTnhWYzhBczlYNU5oeXYwOGIvcGIrdkR3VkVD?=
 =?utf-8?B?YnowWkxTSjRCS3lySFh6MUVoUndlNGc3cWRvUEgrZkZsSjRIeEgzdDdDZXpE?=
 =?utf-8?B?TWJGc2lFWEt6a3cyQVh5bkZaQW4xNTJWY0JiVmJYVU9VS2VDNG1idjJVK0Vt?=
 =?utf-8?B?R0N3eGRYdFAyRENxTEtuKzdsSlVXWmFFYmxSK1N5RWtpbGNVU2FOMDl4UzUv?=
 =?utf-8?B?Z256UDhtQjc5cER2cENZVUpSVHlJZFI1VERZSUR0KzEwcGZyRzV2clBaaVA0?=
 =?utf-8?B?YjkrNjQ0anZRUVh3NC84Z2d5RHBSYkJXN21ndXd5UzJKYmtKSWN4cklnSUdj?=
 =?utf-8?B?YXRPZjFpMWFoT0ZkWUVHT05VU0NHREhFRWxzRGVmOVNadGZBcktZQ1JHMnZw?=
 =?utf-8?B?RkYraVFKVWsrNHRGNlFnS2NPUkZhSVZRc1hYZmhjK1k4VmNZdlR3ekoxUC84?=
 =?utf-8?B?K2NBaU5LdS9BZ0ZiZzVSL3ZyMHFob0tsb2UvaHN0YTYyWjVxOFJleTRNb2cx?=
 =?utf-8?B?MVM5Q25haFBYUHB2R2VpU0VlYUFhR25wMDdYNUVoWExlUllSZmNZNnc1VEpt?=
 =?utf-8?B?TlJtK0dGYXI3K2JYZWNRMS9yWlhyTm94WW1LQklJMVRVSk5lVEpFc0Rxb3R4?=
 =?utf-8?B?bnl1Q0RjY1IwM2pkTG93cXR2RUl4VnhXWmpOcnQ5c3RoZ0VSSG9GUTFJZVg4?=
 =?utf-8?B?STJSdGlGM0EramJrSm52c1JGR0wrQXdYcnd0cFZ3WXpNWlhWZWJTcXJ0Sjhq?=
 =?utf-8?B?aWpyNzNocEVMc2c1ajNpMHlqMnpKdVBxdDRKdnBQSXZtUmQycEJTUXNFUGdE?=
 =?utf-8?B?aEVNZEFMcjRkYzVndFgydXJBUWFiVFZndUtVb0oxbnFNVlRmR3AwV2tuRkRT?=
 =?utf-8?B?NkpLMTB6OWxCOFIvZnBMTHZlZXhlb1RqUXUybFBIWVJ6RVpGN29qUnlkUExZ?=
 =?utf-8?B?dVZYMTJPSG9nRmJNaUExMXNPdGkwbVV0TGJTeHF2OVpWcGxEUmdab3h2Rno0?=
 =?utf-8?B?TzJ3eHJiRnowM1gyaXZhZjd6Vk5BNVZHR0pwR1pXQkF3Vks3bG1HNTd6WUh4?=
 =?utf-8?B?ZUh1cHFIaDVCa3htWUNwdGZkMnZSVFg0QWNPRUp5STVZTG5MS2FhSWlWL0x3?=
 =?utf-8?B?YVJlMWJZVjU1cTJGQWZMQlpXWWl3VnZRWkVtSFlaTktSTm1aVmR0SElkNTlt?=
 =?utf-8?B?MkFaQkNGbmFyN1VDUjByTHczUDBoL1NXVXZqVDdmdUNZNGVNbFArMThCcnpO?=
 =?utf-8?B?Ykx0bjA1L092VkZrU1g3Z3d2bjllYVpZUlZoQnNqMW5MaHc3ZThtZ1FIcE5U?=
 =?utf-8?B?SVgrRGJXKzNwRmdyd1IrbzAyVk9ja2JTdmE1UFBnUzFmKzc1QWFQTmZTVHl2?=
 =?utf-8?B?czR3L0Vja0RWTVQ4cG1mMkl2RUpSbnFnWFJNQ1kwNTdNVmIvaC9VZzVPaVdJ?=
 =?utf-8?B?Z2RvK1FwVTRoZTlQLzJjbGgrVzkvc2MwSThtbUdkUCtoSGtNOFRtVnNYOUZT?=
 =?utf-8?Q?vMybINBjbQfNyJdDEr9CTmKQd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4dae0b-1edb-4a2d-11ec-08dca650bd92
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 11:08:09.1486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6eaGF7m8TB7W3qkC3Zx/EKVSelumKJJ815kizJiS2sVKj9D0ZeUYjVqCVVTTX9jl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
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



On 7/16/2024 2:17 PM, Jane Jian wrote:
> For VCN/JPEG 4.0.3, use only the local addressing scheme.
> 
> - Mask bit higher than AID0 range
> 
> v2
> remain the case for mmhub use master XCC
> 
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>

This patch is

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 19 ++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 46 ++++++++++++++++++++++--
>  2 files changed, 60 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 30a143ab592d..ad524ddc9760 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -32,6 +32,9 @@
>  #include "vcn/vcn_4_0_3_sh_mask.h"
>  #include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
>  
> +#define NORMALIZE_JPEG_REG_OFFSET(offset) \
> +		(offset & 0x1FFFF)
> +
>  enum jpeg_engin_status {
>  	UVD_PGFSM_STATUS__UVDJ_PWR_ON  = 0,
>  	UVD_PGFSM_STATUS__UVDJ_PWR_OFF = 2,
> @@ -824,7 +827,13 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
>  void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
>  				uint32_t val, uint32_t mask)
>  {
> -	uint32_t reg_offset = (reg << 2);
> +	uint32_t reg_offset;
> +
> +	/* For VF, only local offsets should be used */
> +	if (amdgpu_sriov_vf(ring->adev))
> +		reg = NORMALIZE_JPEG_REG_OFFSET(reg);
> +
> +	reg_offset = (reg << 2);
>  
>  	amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_RB_COND_RD_TIMER_INTERNAL_OFFSET,
>  		0, 0, PACKETJ_TYPE0));
> @@ -865,7 +874,13 @@ void jpeg_v4_0_3_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
>  
>  void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
>  {
> -	uint32_t reg_offset = (reg << 2);
> +	uint32_t reg_offset;
> +
> +	/* For VF, only local offsets should be used */
> +	if (amdgpu_sriov_vf(ring->adev))
> +		reg = NORMALIZE_JPEG_REG_OFFSET(reg);
> +
> +	reg_offset = (reg << 2);
>  
>  	amdgpu_ring_write(ring,	PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
>  		0, 0, PACKETJ_TYPE0));
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 101b120f6fbd..9bae95538b62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -45,6 +45,9 @@
>  #define VCN_VID_SOC_ADDRESS_2_0		0x1fb00
>  #define VCN1_VID_SOC_ADDRESS_3_0	0x48300
>  
> +#define NORMALIZE_VCN_REG_OFFSET(offset) \
> +		(offset & 0x1FFFF)
> +
>  static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
>  static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
> @@ -1375,6 +1378,43 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
>  				    regUVD_RB_WPTR);
>  }
>  
> +static void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
> +				uint32_t val, uint32_t mask)
> +{
> +	/* For VF, only local offsets should be used */
> +	if (amdgpu_sriov_vf(ring->adev))
> +		reg = NORMALIZE_VCN_REG_OFFSET(reg);
> +
> +	amdgpu_ring_write(ring, VCN_ENC_CMD_REG_WAIT);
> +	amdgpu_ring_write(ring, reg << 2);
> +	amdgpu_ring_write(ring, mask);
> +	amdgpu_ring_write(ring, val);
> +}
> +
> +static void vcn_v4_0_3_enc_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
> +{
> +	/* For VF, only local offsets should be used */
> +	if (amdgpu_sriov_vf(ring->adev))
> +		reg = NORMALIZE_VCN_REG_OFFSET(reg);
> +
> +	amdgpu_ring_write(ring, VCN_ENC_CMD_REG_WRITE);
> +	amdgpu_ring_write(ring,	reg << 2);
> +	amdgpu_ring_write(ring, val);
> +}
> +
> +static void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
> +				unsigned int vmid, uint64_t pd_addr)
> +{
> +	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
> +
> +	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
> +
> +	/* wait for reg writes */
> +	vcn_v4_0_3_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 +
> +					vmid * hub->ctx_addr_distance,
> +					lower_32_bits(pd_addr), 0xffffffff);
> +}
> +
>  static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>  {
>  	/* VCN engine access for HDP flush doesn't work when RRMT is enabled.
> @@ -1421,7 +1461,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
>  	.emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
>  	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
>  	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
> -	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
> +	.emit_vm_flush = vcn_v4_0_3_enc_ring_emit_vm_flush,
>  	.emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
>  	.test_ring = amdgpu_vcn_enc_ring_test_ring,
>  	.test_ib = amdgpu_vcn_unified_ring_test_ib,
> @@ -1430,8 +1470,8 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
>  	.pad_ib = amdgpu_ring_generic_pad_ib,
>  	.begin_use = amdgpu_vcn_ring_begin_use,
>  	.end_use = amdgpu_vcn_ring_end_use,
> -	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
> -	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
> +	.emit_wreg = vcn_v4_0_3_enc_ring_emit_wreg,
> +	.emit_reg_wait = vcn_v4_0_3_enc_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>  };
>  
