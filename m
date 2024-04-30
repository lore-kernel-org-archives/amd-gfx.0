Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D00C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 14:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A55A10E99E;
	Tue, 30 Apr 2024 14:48:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lEQ2heC6";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD0010E99E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 14:48:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5iAljgnoFNlBoPWc0LOTSwvq9mNYBXF+qHGfKEXa/S7jp7S1ik4eu2NeRi/b2fnBBYcNpPifDbd7neq6PvsWLdp132Z8BhWIvoDx41yQUIoWmxWbZG9uqyTFCM/Vr23EnhCp0lW2sMjXbLSXPqAIfh4vBYJAsdDMD0vIHjhDlYornFnmZJinHBJIYLR/t+DJ0DtkWtpyWp/BA2t5Wl96vV7v2tG7B7eRVxgRiFoWDxiWkSqli44zEslvk10FkURdUBMcxNs3M9kCYCwUkk/XU1DQTkRAcHysBSDly0F6mUQwD6s8TFMu68FpXoX0tSJ9TKMZi3CmpwtG2m2ZpYXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6okaqzhiV1HIHfiLoYt7RnowD+EKax2vAP8fzm8JSo=;
 b=kq0U5DvAE20gjDfhRhHV8hpZJHkjKvB1h03VyW0kccx7npq0VU0cXj7CJ04czAv1aUfvch0RCBVZ+6nkM9iGa7bZzTPXAMx0pKrQIKxgzqvWxql7GZIO6OlNDtx1sF3qR6n52zaq/+sssMne7l+/UVMzzClfZZ1U8eocIq4vppWIThoUDQKktaFm0rGpn8RJ9gBBwehRLO46PGtnbmjuH5Mp2T/3wKT3yehU5OueCUaaE5bNECnhqkUrsQqIEu5lufvL6NwXnPimr2u7elcXlgZYttGa8E/NeaXTXZ7oxh0qYEER4gazFmvTWKNNhxbvvfSaK7OGfNsiLNUjf9FUWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6okaqzhiV1HIHfiLoYt7RnowD+EKax2vAP8fzm8JSo=;
 b=lEQ2heC6ZFHS+8goEXse6p27iSEw34tqs9qOlzF2WjyXZGOwum0OB/uFOn6D2es28B1gRlqWyOi4F+cnO7BSPolV0pvRkFbvjwRtapYjDlu2SCgaFATzsrK2bhJKnuqeXDrLHquXouEaxZkPxK8ogR7NLAEKsPI+wBGIGUPj4Js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 14:48:42 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 14:48:42 +0000
Message-ID: <7f0cdeec-07f2-4643-adde-4bb490bafa63@amd.com>
Date: Tue, 30 Apr 2024 10:48:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amd/display: Override DCN410 IP version
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: rodrigo.siqueira@amd.com, alexander.deucher@amd.com
References: <20240430134301.18555-1-aurabindo.pillai@amd.com>
 <20240430134301.18555-2-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240430134301.18555-2-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0185.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::29) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MW4PR12MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa04f01-e66e-45f7-4feb-08dc6924a06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTlCbStETTY1UGpCQUZLMHRYTXRjOU02VzVaVGY5MTgzcGxsY04rT09hb0hG?=
 =?utf-8?B?NlRibWgxa0drTFFjZU9iRzNaZi9MUURMdERrT1JyNDh1aUJHQTFPb3R1cGI0?=
 =?utf-8?B?WjROenBGY25aREFrQlg3RDhxanM0WHdDQVFCbG9tREM3NlZsYXRmZ3NOcEVD?=
 =?utf-8?B?RGh3SDFwenNRVFUwZUhPZVk3NndDZHp4bUVpZy92eHNxYjRQNERva1o4cXc2?=
 =?utf-8?B?ZEI3aktxWEhjUkMxYTVEMEdMbzNKS3ZMN3VBaFFZYnJQSlNMN255WkUvLzNj?=
 =?utf-8?B?MGRqOTE2OHBDRitZU3dYN3NKZnZHT2dodEcvSisxblJqQURUN2MycFBCVzl6?=
 =?utf-8?B?SmlKL0xTeURlcEhINDJERXdQRGhJTHN3Tkw0N3VRcWZ1N09Vc0RLb0hOZURw?=
 =?utf-8?B?amp6bUw2SjNUWEJJQTl3VWZycjd5SWs4d21vR0hhOE41ZXpHSVFnSVU5VGJ6?=
 =?utf-8?B?dk9FY0pWOTkxcGNyVFIyVjZ4V0FnMVhtU1puYkM0Qm9BYVdISFR1Mjl2aFpk?=
 =?utf-8?B?WTI0Sk0zYnU1WGc3VEFidnp4eERzODQxWFVMUjExRXhjN2w1Y3FNNWZRWkdZ?=
 =?utf-8?B?UUNnSUVUYUROcnVncVZDSFhGS0NDVVpqNStJZ3o3MlhyNnowK1N0bkIzamI2?=
 =?utf-8?B?TWlSU2oyQm9aMTJsSDJCckNicjg1QlhuaTYyK3pyR0NDbGhacDk2QUQwcTZP?=
 =?utf-8?B?TGZPL3BYdlhkTDFaS0RyVjlFUndqVmJqU1BxWFFBbWp4M1pQRjJ3dS9tRk1u?=
 =?utf-8?B?TmtUS0xRREcxOTg1UkNzdlJRZDZzSjNXYnR2N3dMMnlEem93NENjalFHRGEx?=
 =?utf-8?B?WVpXdEQ0VXliZ0N3Z0dUYTF0alRZTjQ5NWg2S2Rpb0ZlUGRhdng1TS9EaW41?=
 =?utf-8?B?UGtzaUxIUWdvZTZOYUk3cGQ4RGdjZVE4UlhEam1XOStNNHlhMEpLbGZkTW83?=
 =?utf-8?B?NlFjNGYwMnZqb293cnA1VXA2VVhSUmQzTHloRldhMXNLbExCdFFxK0YxNndB?=
 =?utf-8?B?a3JYVzU5Y3FwZEw5TFl1bXBEZkNpTTZ4cTVKMzFZTHE5Mkg4UkVsOTBOZ2ta?=
 =?utf-8?B?YmE4RWtjWDV1M0Znek4yZWRTMkxMQXBEZ1FqbUR1THlDd3pqTDhLaUhlMXox?=
 =?utf-8?B?c1FQV2ZtemtOR0NpbDZsckhyUklpMnQ3VWdCdGoxa2pob25LdmVpenZlSmNr?=
 =?utf-8?B?TDlTUlZpUFJ5NkJkQ3p4OFFicFpGcVlJaWhrd0dxL1k3SjdLczNBMEcxWk5z?=
 =?utf-8?B?UndYb29WNzhEYitxN3RiRUY3TFJRM05BcG96TDVwc3ZzRGZLL0hta2prajkw?=
 =?utf-8?B?UXFlZXo4MlFhNlVNSytaZ09oQkZsaVVWV2kwR3VYMXUySmF6YUQvclJiNFdE?=
 =?utf-8?B?YnQwS0xVS0NzcEUxd0o1UTlaaVdnRUlMd1VEcHY0akhKQlZaR0lDc0lHMWxF?=
 =?utf-8?B?V1NId1V4Um5GOTRVVDRHUXZnK3RHMXlmWnp0VXNoNExWN0haV0FIaWUrdmEv?=
 =?utf-8?B?cnRLazliR05rcVFBVjl0TTgwV3VGcGlaZGhUNktLaTgvNk1UVUtid2lDWGo4?=
 =?utf-8?B?cW5xV0NHMG9jaGRINWpSOHQveElIbE5DdzBxRnp2K1NURU01aWpiNytjTDR1?=
 =?utf-8?B?R0FaWE5zVHMvUzlVc29xb1BvVDFES0tCcEFBSVBmcTkrRVlTMS9Dd2x2a1NP?=
 =?utf-8?B?Y2E2OXdESzAwTzRMcHNmR2NFR2dWRG54VGFuOTY1OVdIK0dGZldSM3lBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJGTG5xdFdDSDJEd2djbW9kKy9wRy9LZ1N0bmVzcU1xbHY4Q3liU1NzUWhn?=
 =?utf-8?B?UnlZNC9rQmluWUNrWGR2THNnSDhRU2V3S0ljcUJuNGUyUnEvSVRMcXpIL2NZ?=
 =?utf-8?B?L0lialBjU3J1Nm9VTlpqVGliU1QweXp2QmdMSmlRMG41S29EcStKR0RBVGJY?=
 =?utf-8?B?eDY1anl4UHR4M3BtSnRIR2FqT0R0UGk2Ny9oeGtGZ1BFZjZlRDFkRkllV1lR?=
 =?utf-8?B?L25FTHB5R3RMVVZKQjFJUllwRDZYSjdCYmYyRVY4U2R2bFNIRkVHTWMwSWFp?=
 =?utf-8?B?eVQ1RDJWSFhpZC9kbmNGdnU5YnoyTXZwMzBTNVpUMXhKVEFJaEcvUXBqYyt3?=
 =?utf-8?B?ZWx2Z1cwRjBONzcybWs2bXdiWkJhM25SclFwY1piV3lFNFZNYzBES09KSnpa?=
 =?utf-8?B?Z2Fib3h4U05EeFltZ1RLTzBVT04yRHNUTG0wQnVJTlNmU2Z4ZkFlZXFFVlJx?=
 =?utf-8?B?dGlQTnZjWkYxNW4vYmV5dUdLblI3Qk5VYnJHTTRaSyt3S0JUUEVtMGxRdjBh?=
 =?utf-8?B?QTd1b1B5T2UyczJxbVZOZmFKRm9veHlrQk1NRzNqa2NIMWNGbWF0MDF5UG03?=
 =?utf-8?B?czhKNUxod2NlbjFpN0x6d21RRkNGd0JSUlloYnU0OGxZWDROMkRTYlRteCs3?=
 =?utf-8?B?Y3pZQ015WVRNc1F2VU95WjEyTXpJRWNzaTQ1cGNWa2EyWUllWENTejRnMlhT?=
 =?utf-8?B?S21oTGNTeXBzNzg5N2hTWDVmNitRSllpNkRQQVhyR2JmMHhkOFdwQzdOYmF6?=
 =?utf-8?B?MEZXY1RkSXR6cUxIa2pQWUlrSFA4TGtBMkRZRVlLOUh3ZkYvNDNLeWtCdkpC?=
 =?utf-8?B?VVF5M1ZmYjRKQ1R5RGJCMDlJdkJSQ1FxZWxrb2pPZ2M4bnlmWENlb1dzbTlj?=
 =?utf-8?B?NVhJM1FRRHgxMzVlWXl2Um5haW0vY1FTRmtzNnkwZUZQVkpqWXdOMEo0RC9K?=
 =?utf-8?B?elFwVEZaeTRVMUxZZkpBTXVHTGRPbDZCVUZZYXNKdmhPYUNWU0ZITVMvTS96?=
 =?utf-8?B?ZWxTOXZid3cwU3Z0SDFzOVFvWXJBYy9FT3lHYmJyMVA4SDR1NWtkMFM0RFll?=
 =?utf-8?B?UDc1djRrSFJTYjZ1NTZCS01xb3l4VGc3blJodkJBcTJWc0NMalhiaE9SRlpV?=
 =?utf-8?B?OWZkdjNSZzlienk0ckk0K3ZOc3RxSTRZVSsvRWxHYzlPanJ1R3FPeFVkc2hD?=
 =?utf-8?B?L0pjSVU5OHdSU3hQTWFlZThHRWgyb09GQUwvMDJTZ1NobnFZdWNpN2ZwRmdV?=
 =?utf-8?B?NGZEU0F4SXBZYnlqYW5JV2hLVFpZeG5TR0lCbDcyYU1lNURyanVVcFRoNkZX?=
 =?utf-8?B?cHlxOUw1QW1kUUdGQkVzeFdvZEg3ZUxmWkkvSUtNeHp1NGdsems2ZEhjNzFP?=
 =?utf-8?B?Q2lBKzhwN0VxK0ZRZHNPaHBFbVl2K1NRcjUzRU15eHhYbnVVYkViRkdwUFRh?=
 =?utf-8?B?eVdGUFRadFRzdjBrMzRKZ0JPc0s0ZUcwV2QxMFJlYjRpSmNvNFRTRFl2UUNx?=
 =?utf-8?B?c2ZJMmczWERwTkhkblp4dFY5VW5pQ3MxZGdPaDhQS2NwUVpJcGFRanI4aG9Q?=
 =?utf-8?B?RThGZ3lBQUNCcjE5ZklZNkxWUmVvUXhibTB1aXpYNldXUlJqdnc2NXRTU3VQ?=
 =?utf-8?B?MlZMYkxEUklHVUZocTA3WXl2dXFydzVzUnBZcnc2eE52SGs4UG0yZTJQa1V5?=
 =?utf-8?B?OEh6aDRnWGY0MVFOU0ZOUVRERFVTL0o2UHdIWXVJa0l3eDNmOHY1S3pmTFdn?=
 =?utf-8?B?TXRhK1JITTk1V2FyNWZHVDBqRHdYTklDUUk5SlBraCtrdVR4eEM2K3dVTmtp?=
 =?utf-8?B?eERvS0hyeUhjUkhWSWN3MGpnWnVxMVFONXNwYkxObDdpYWRody9UNWtmZlBI?=
 =?utf-8?B?bEJEc3ZsTGNWUE1pdGJhcGRBY0tNa2xkNlJpemVtQUN0VnJ0cEVPeGU5QUFQ?=
 =?utf-8?B?UDNteGFVK2dFbnZtOVBsUVZUcjZOa0MvREtiMkZwWXVPSmlGMFBaRU1pdjNV?=
 =?utf-8?B?Y0JHNjJoUG5GeUdBWXgrT2NZbzNCMjBUUDJGQjJ6bytKcG9ZRDdma2c0aDUr?=
 =?utf-8?B?aEkzZUh2T1E0UFArWXlTbnVhelJtenNGT1d2OTRnaG9vMUcxSk9xUUJNNFJn?=
 =?utf-8?Q?wGbioPbyGpEBXcQCOGp/ld+Tc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa04f01-e66e-45f7-4feb-08dc6924a06f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 14:48:42.7601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8z2PBdBhSjoHZEo8b4siE+fi82znYIG6vJ1SlwnSyRyaNVJznAOXw5xQRo3qOg2iaRzhnUhjE8+j3MgwtbWZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777
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



On 2024-04-30 09:43, Aurabindo Pillai wrote:
> Override DCN IP version to 4.0.1 from 4.1.0 temporarily until change is
> made in DC codebase to use 4.1.0
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index d7f948e84e4f..87a2f15c8a64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1966,6 +1966,10 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>  		case IP_VERSION(3, 5, 0):
>  		case IP_VERSION(3, 5, 1):
>  		case IP_VERSION(4, 1, 0):
> +			/* TODO: Fix IP version. DC code expects version 4.0.1 */
> +			if (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(4, 1, 0))
> +                               adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
> +
>  			if (amdgpu_sriov_vf(adev))
>  				amdgpu_discovery_set_sriov_display(adev);
>  			else

