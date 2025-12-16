Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5395ED637DF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 22:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E39AB10E2FD;
	Tue, 16 Dec 2025 22:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zBdPm//0";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013004.outbound.protection.outlook.com
 [40.93.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB0510E2FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 22:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQpLSOkiRXOD7r8fwMLWX5NsICM1SI2peI5OxqFmZPp61RZ9oRnghq7o8u9v8sd5U3oMoOf8kemUD+8rLCc6Ajt6myj6v/R353ITjZstuYABURJ8D4aAYtizumwUctGlpheua2MfquGYC/pl4VB5AMjnsw3eDEg2Ez+7bYSurO3Orwqdi0Dtl9s/T0R0UbiU1csSlncGucOOc3U5FT6QBml9jnYwq5BRpyFhi5P4sF/G0l6rJC/R0qi6PPAnoFfBD0yvKfiFnbPiImBXnKWlzJSCG/QWPYANe1vu+lAPmQJ5fHIrpzOCFsb3f63hJjV2Qj7dcKWUiLqq83B1eSVpmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3CwDRpHVChX5WOdATXFYrWMmK7kG3VcH8rikuD1vMA=;
 b=XXRcgGXTAmGTfIlQX25ifE9i8hANdRwo6yqrya0pnpq7F//YReh5w/gfIGToWwqSPk4dCi5s5/uVq6AotJUjK14euPGO4quzKArt76VOjrKNCcWsXrki0NlQ5T0fJULjwJRU8FvCqQIlvETW7tQwvdkK9+ngH5yhf5oQ7vbyxCXENtgSwMilgKfn830CGW/l8LSkqWEcTE1emTkKU29pql/MZ2PdRTL2NDZUCyMtr87DkVIdC3zhXe+4pSIgyl0iRwNdI2f8w+FxBTXrc+ps4GuuWNVURqYN5wwwN+94hIaHsqoilrcbrd0MOa3Wj3NpQ6beKtmKNLEoajbHxaP39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3CwDRpHVChX5WOdATXFYrWMmK7kG3VcH8rikuD1vMA=;
 b=zBdPm//0bdhOqMKMQdI/gS+NkUgVOso6+iFYc283sjOeKzmKdmWETxOY9vus07vGnn4ccaw1UkSSc8n/GViXsJztndw9/XEvqGMCp19eJTNlecXRHtsCWmTqLyIZm97ndpHOUSahCUPUPArvELCe2SSscEEg27vliu4dC74dYr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 22:28:00 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 22:28:00 +0000
Content-Type: multipart/alternative;
 boundary="------------MAS81iFxjVLnuf3hrSFayuSN"
Message-ID: <b513f97d-6d40-4ba3-acad-c882cc0bc483@amd.com>
Date: Tue, 16 Dec 2025 16:27:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] drm/amdkfd: Move gfx9 MQD to VRAM domain
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251215165630.1172383-1-Philip.Yang@amd.com>
 <20251215165630.1172383-5-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20251215165630.1172383-5-Philip.Yang@amd.com>
X-ClientProxiedBy: SA9PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:806:27::21) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 46075a81-666b-4a62-1ed2-08de3cf25eca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGo3RDc4NlFHaXFIU2VvN21CZTFybzdidFI3RmR4elRRVDk2L0ttVlZGeU9G?=
 =?utf-8?B?VnhjT3Q0QUJvVi9GVHVXUHB2U0hHemJqa1lMbVBYbldVNDhzeU9KRWVwTkFR?=
 =?utf-8?B?VXNVLzg3Q2pUb1VsNWw1WS8yVGIvSG11YXExbzdPSWlqV3JQcHM2REdrMFJx?=
 =?utf-8?B?Z0duNDBFL3RSSXhFOWRMVXE0VC8xQ0tLVUM0NE42Y3dWQldpN0lxMzZxMkdj?=
 =?utf-8?B?RTdYcXY0WFY1QW8vY2gzc3c2MitScExwaC9UMlNZOFlBL0JDTGYyYTRQZEhZ?=
 =?utf-8?B?c2VzR1dFbXlyalhsMkcvenVqUUFuS2o4NUpDV1BKa2dma0gydmI3V21oUXd2?=
 =?utf-8?B?N1NkbDFlcURXcTI3WWZHWWwvZlJsL1NwSmg5UkRLQlpBbDExVEZ3ODMySlR4?=
 =?utf-8?B?WmdyU3pENXZKUi9sVGE2Zkx5ZGpRVGVZWUdXMjJIbG1NYk04R2gydEJIRThQ?=
 =?utf-8?B?R1A3b3ZTMUk2OERGbkhnMG8zMDRXWmtTc0djaHdNbXdqaUpRVFlZcTdzalhU?=
 =?utf-8?B?SHJsSHhNVmt0QmNCbldpSGFFSmpTZVQrQnA3T0FQWmhFVWxVNW1XR1VWdzlC?=
 =?utf-8?B?U0xxUHJVb09EK3VKZktlb3kwTHErc0FWNUQrS0JsOWpxSVJIOHBxNTI0di9t?=
 =?utf-8?B?RmN2bnl6bzVLaWp2MEtCckVTM0E0N3VJeEdyOTBvSE5LMFQxeTFwa0hsZFJr?=
 =?utf-8?B?NUpscmdBUUI2c2hueHBYUkZwVnlqUlgvMk4wRFBlYmlxcUgxTmRMbmYzTTRL?=
 =?utf-8?B?ellOeGV2UEdhdFMzTkh0cjNZWlNzNStHdmZGTFlKWHhwZUt6M0xLbW1CNW9s?=
 =?utf-8?B?OVdRNDRFLzhDN3Q1UkVNc0FvK3JINnoxWHVnR25WRFJHQm9sZ0RjcnRrd0JU?=
 =?utf-8?B?TkZxeGJyUEt1eVExdk9WOFNvRFZaVmc5MlpPcFZweDI0V000WUs4aldCd05R?=
 =?utf-8?B?K0FaWCtlUTcrQ0x3RkJVZ1dFVmcweUZNRVBUOUxLcGY2UGllTDZPaVVJRXV0?=
 =?utf-8?B?OWNkR1RUUHFOVE1FSWl3RWs2RE9SUU9lZ1MwUEZtNDArQUtwSjhEd0RHNjk5?=
 =?utf-8?B?Sk44QzY5ZHh3a3lVMTR5K1h5bTBwQ1JJMTUrUzBWUlJPY0ZhQldaTkVkNHJN?=
 =?utf-8?B?TjBQRE51ZmxVeHhsTHBlb1ViaS81cGJVTUNqQlRRRFZ6Q0JKVUFKYUZUcnRM?=
 =?utf-8?B?MHJ6SnJsZ2VMNFBNV004Z0tPVWxnUEJQREFoa3cwendWR0dBYzlzcTg2Z1BW?=
 =?utf-8?B?dWs4bS9RQThvQU9Ea3IwaVRlQ3BpN2pSNjdVZThWUmFJRC9rbXJldVhUUnJ1?=
 =?utf-8?B?TVFocXVlUjd4cnhJdEtRNGt2MjZzSXNxUEU1Vk02SFBZMDNQV1dDemVKaXFj?=
 =?utf-8?B?K0l1WkNURjBVWkJjY0xmbldtL0VjNXQ0M2hDZUhhUjhKU2ZBMUtHQ3N3VVlJ?=
 =?utf-8?B?dDg0NUVTZlN0SkEwYzBveDN6cVdtUXpzSW9Qc3pwK1pRY3h2emE2bS9lYzBk?=
 =?utf-8?B?K0o0WjBqcHA1aXVTQk1QbUtQRlM4NnlMcWhUb1NleVpDNEZSQ055QjdXcU5z?=
 =?utf-8?B?eXorQkMwSHdkS05RQmJabm9HZmZHNjZJSXZXTEtXdGZGRFZabEhuTk5MTk5Q?=
 =?utf-8?B?dy9vREJlc2d4S1hSbFhITTNmZEN0NkZtNkFjWXU1TEtaWG9QSHFUTHBLY3dn?=
 =?utf-8?B?c25YMENaYytuRDJnWTlQN0VubXF1bmp2NE1QR0V2M3VScXV4RUhYTFBkeEMy?=
 =?utf-8?B?RGc5cHR5ZWhDNTdQbTVCVHdLNzlnRllkNGdneDI4T1puVGRlZWtUOUxOMThL?=
 =?utf-8?B?aUNkajJHVjFodkloTmhhU2xLWXFzTXR0VWU5b1N0dnF4OWRWZ0I0c1pvc0da?=
 =?utf-8?B?REJJMm0vUlRzNnpxZDdNbHJiaHg5Ri9qSnRKWnVta2dpZ1dLRU56c3NnZGFH?=
 =?utf-8?Q?xHp2LO2JSae/zkFKDo8Pre5iFep3Mry6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDZtMEJ6cHBiM3ZDbXRQcm1oZE5XaDY4cE1kZHVxcVB0WU5NMitJQUt1T3VR?=
 =?utf-8?B?aXV3SUhpcjhqTkRhUngzZVlINjZuNXFLMHhtSzA2cndmeXhRNWN4WGVVNXNq?=
 =?utf-8?B?eWF2SFRNM1NLcXhiZEtOODBVNVBzUzdXS05paUE0UU9QR1RwNmxZQ3lwU0tY?=
 =?utf-8?B?ckN5ZksvaGpLYWhhWTQ4RVQyUlkzZXJYZnF0MjJwZVVmTytXSkRGN0ZCTHpm?=
 =?utf-8?B?RXRySlV2Y0JMcUloQzhJcGFSK0QxRjViUkpSVDR4a0trdXRoV2kyL2xaeGcz?=
 =?utf-8?B?aHM5OGRNdjhuSTkzbVlWTzczY3BPUkpPdG1sRm1sYWRqeFJOMjNEbGQ1czZG?=
 =?utf-8?B?SDNwNUVreWtxajFIdS9WQlJyemo5N2xtcDNNVll4M3hxbTVzTUo1dUlDbDdN?=
 =?utf-8?B?aEYwNmNQdXBiamlwcGNyT3Q1NXJXU1BJN1FpT080MjZES2RXcHNSTGhBdkg3?=
 =?utf-8?B?VjhYbFF4SDFjSTNtN1N2eGNzVzk1bTAwOWRJYWk3ZkpFZExES3hSY0NLWFNj?=
 =?utf-8?B?TC8zenNYMTEzcHZsNVZ3TjJjL3hJdmVtVWNLd0tpNFpqa3VsWXNaTXV3MG9a?=
 =?utf-8?B?cnEyeFpnZGc2N25GeHFKYlEyaGRoeDNwQlNnNlA2THVPaGJJTXJzSk1IWHdR?=
 =?utf-8?B?R0pnWWI4aUplb2tmVHZxVTgwRi9vcG45cEgxbTNJdDAwMEpkRThDbUZKRnF2?=
 =?utf-8?B?VWMwa0xjc1pWR1RCeTVJVVlwSlAxWDFoUmNVdzJnaU1xWXIrTHFYdFlGbmxv?=
 =?utf-8?B?NjVscXhUbG1iZFJybXZSdVJqY2E2VFRkSjlkOFpXSWhmSUZpbnFZWlByTm5R?=
 =?utf-8?B?UHdBeFV6cjRtTlpFTTRLa3E4K3hPSDlGTys5ZnMvTmczc1pOUmVzeW44OUM5?=
 =?utf-8?B?dTRVbFdQdkFEQVpJME8wTGZwN1NIaEs1R0dYRmpyeEVrZVJ4S051bWpCWFJw?=
 =?utf-8?B?cmU3VlYwTCtadGV6S0tWZFlQRjcwdFp6dG0waFR2cWgvOWhFVWtUbGFTUEw0?=
 =?utf-8?B?ei80TkxPb0FWTHB3N01wTmtEUFlkb1padEZhZ3Ruc0txTnpqaUNQb1ArNXRR?=
 =?utf-8?B?QjlpdzYwTGFReFhtbkhEL05wRzN6dDRiL2tRL3R6dkhCZ1ZLSHdTQTcyMVA3?=
 =?utf-8?B?blVwaEZlNU4vNzJFcmxUV1RwbWtORjI2cW5rY2pyZXEyM1NvUmdQRFNPaVBu?=
 =?utf-8?B?K0FJZTQ5cERETit3UmMvOTNsQklUSFluZDRvYS9ZSEJUdjdIbnVyUkNKL1kx?=
 =?utf-8?B?endjT0JLenBTUVh2ZmlKU2lzQUoxZ29rY0ZUcmYrL0dsNEdHUzhGWmZnNWc4?=
 =?utf-8?B?ZmovcHo0Z2FWejlYaGQ3ZkpPMHV2RnVwVFdFRWppakVPZ2dTWldIMUt6THA3?=
 =?utf-8?B?YU53VElGR1BLTGZHRm5WOVBMeUxJblo3dXhIeHR3bUxzQml5WUxhTEdBcWxW?=
 =?utf-8?B?TEVjb1lmYmdBdXlzbWlwbGQ3MjQvYm1KazN6bTlGV2gybkY4V21SUi9YRE4w?=
 =?utf-8?B?aGswU253OTNVV3dxTFY2QlB5Ui9ydGFwd282b2lBakNwMFBlcHZBTWF6VTRj?=
 =?utf-8?B?bGxrVUtaN3MvSjUwV1JSaytpektLcGpqM2FBeDdaUlk3ci9hWndnR2dTWFJI?=
 =?utf-8?B?K2RvdzdTMmt2bkwyQ3Fsc2thRzNxQmNQRXNiblcyWHAxdXdzNEwyZzkrRWlT?=
 =?utf-8?B?TWwyWjZDQUtTaFpKQ0tQWnY4ZFVZMXhULzFSamxxSjlmV0lOQkd2RFRWZ3lM?=
 =?utf-8?B?V294UzZyWDl4ZjZZQzRDNFA0ZW9Gb2lIcUJVMTFycWVZd09QdStOMkhKRDhW?=
 =?utf-8?B?KzUrSENNWElxN3BYN3BhbStMTU9HdE1vKzQ0QUg5SlRXQmJiNGUxSnJSRmpT?=
 =?utf-8?B?dkpFbGtPVFBwMXMvQjl6M29nU3BvWmZtNGJGNVNPTk5vY2liMmVaNTlLN21s?=
 =?utf-8?B?TkVQaUEyZTcrbk9MblFSY2NYZFd1MFRMdUt0MDlxMGRhOHU0YStSeU9JMWt4?=
 =?utf-8?B?Z1A0K1VFa1EyeXpjajZaK2VYSzV1VHh1Q3NEMGh1QnVLeGp2c0l0L1NNL3VI?=
 =?utf-8?B?S1ZBNlhpZm41UWdCZVVPd1lqZDRSRWgwcmQvQmpFN0lRd3UyTnJlL0pSTkYx?=
 =?utf-8?Q?ci2A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46075a81-666b-4a62-1ed2-08de3cf25eca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 22:28:00.6167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wuq7TRq/LilPPT/RRuXX7g8v3bGLgPFFmw0ohS63Z9pqGrDkK5+6+phqwL5jQuFn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
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

--------------MAS81iFxjVLnuf3hrSFayuSN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Can this patch be stand alone ? I think it needs be combined with patch 6.

On 12/15/2025 10:56 AM, Philip Yang wrote:
> To reduce queue switch latency further, move MQD to VRAM domain,
> CP access MQD and control stack via FB aperture, this requires
> contiguous pages.
>
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 090d17911bc4..113c058cf7b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -329,7 +329,8 @@ int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
>   	bp.size = size;
>   	bp.byte_align = PAGE_SIZE;
>   	bp.domain = domain;
> -	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> +	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
> +		   AMDGPU_GEM_CREATE_CPU_GTT_USWC;

Should bp.flags setting depend on domain type: when domain is 
AMDGPU_GEM_DOMAIN_VRAM then bp.flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS?

Regards

Xiaogang

>   	bp.type = ttm_bo_type_kernel;
>   	bp.resv = NULL;
>   	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index d234db138182..14123e1a9716 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -139,7 +139,7 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>   			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
>   			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
>   			NUM_XCC(node->xcc_mask),
> -			AMDGPU_GEM_DOMAIN_GTT,
> +			AMDGPU_GEM_DOMAIN_VRAM,
>   			&(mqd_mem_obj->mem),
>   			&(mqd_mem_obj->gpu_addr),
>   			(void *)&(mqd_mem_obj->cpu_ptr), true);
--------------MAS81iFxjVLnuf3hrSFayuSN
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <p>Can this patch be stand alone ? I think it needs be combined with
      patch 6.</p>
    <div class="moz-cite-prefix">On 12/15/2025 10:56 AM, Philip Yang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20251215165630.1172383-5-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">To reduce queue switch latency further, move MQD to VRAM domain,
CP access MQD and control stack via FB aperture, this requires
contiguous pages.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 090d17911bc4..113c058cf7b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -329,7 +329,8 @@ int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
 	bp.size = size;
 	bp.byte_align = PAGE_SIZE;
 	bp.domain = domain;
-	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
+		   AMDGPU_GEM_CREATE_CPU_GTT_USWC;</pre>
    </blockquote>
    <p>Should bp.flags setting depend on domain type: when domain is&nbsp;<span style="white-space: pre-wrap">AMDGPU_GEM_DOMAIN_VRAM then bp.flags |= </span><span style="white-space: pre-wrap">AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS?</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang</span></p>
    <blockquote type="cite" cite="mid:20251215165630.1172383-5-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index d234db138182..14123e1a9716 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -139,7 +139,7 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 			(ALIGN(q-&gt;ctl_stack_size, PAGE_SIZE) +
 			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
 			NUM_XCC(node-&gt;xcc_mask),
-			AMDGPU_GEM_DOMAIN_GTT,
+			AMDGPU_GEM_DOMAIN_VRAM,
 			&amp;(mqd_mem_obj-&gt;mem),
 			&amp;(mqd_mem_obj-&gt;gpu_addr),
 			(void *)&amp;(mqd_mem_obj-&gt;cpu_ptr), true);
</pre>
    </blockquote>
  </body>
</html>

--------------MAS81iFxjVLnuf3hrSFayuSN--
