Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD9606A33D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=koEdfhp1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB43710E159;
	Tue,  3 Nov 2026 22:07:38 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F5F10E111
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 22:07:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZMSyaUX4Tg/U62n/27sQ8Q0/694gwKi31VIM6v1il/h+gOHjR+3ReBSPCx1H+Gerql5yyQb6d0jqSiX8SDSnBnG6TFKbfq3Vb6j5i505W2SrJDRTB3ZWLnQlvji7VUpfYgpQ54C0WR3aL1HSwrbEu7LrBB+5ynJkcE4yQTVih4VOgmLi7sSCtIyYV1bVhiAQ9lvBIssZz8ss9qcUzM/+c22IKCfreg2M72qOg/vw0cCdgZLx+uYqREtroDMwShcCTxcOZjYWc6BCc99O08/uTIDpT3Umhcei+8wMMorz1Skt49mUCy5DI3BRiLSX1uqeJhbRPNZE7kAXEJgkAsi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdZUo4EL39GSpgYdP5/h0c0yRNM9IMY7+b0GuGkusao=;
 b=hLamhAMHp7ho6BbOQH/CjltrRuDMILldQdhnPpsjpfeQeYx5bo4+Q8QL3uXj6EKX0qOo00XPKKlvi3fANdbg9A6QgcOadBY2ozGKkrAVp8zZcQAilyjHYGQe1J5rtI3s9qq2LVhksyQo+tRapbtLGWMCCRxLkk+3BbeRMoSlm7sEUwx7znxtTSV0IZml/WpHDPhdOP14CyZeKhethYm0S1l7z0z00Vo0C1khs8wG9joWFNLSjKLVAgxVaP2UbSJKP6eHmQUPf31r3VXgC2ep66L5nFk4oMIBqh0tUD9zuhNSLdo/+S2JZIADgttlQntPl7rC/xREg5hXXENIPOzdbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdZUo4EL39GSpgYdP5/h0c0yRNM9IMY7+b0GuGkusao=;
 b=koEdfhp1JeJqrH8Bk4Nmb9P9ULBMkKOtS2mAp+AXfPWQlUaBMHfk5s/DyINdY2dfIiOd2o75LHadMJPysSkylEY69gVfD7twoAj7aIJs/aarbM1ZBylp6txcfyWfXlfaBVHydmXelvi8QjoOoTmnTX4YAQEmAiPzVQrzyjNS60E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by BN7PPF7C0ACC722.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 22:07:26 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 22:07:26 +0000
Content-Type: multipart/alternative;
 boundary="------------0kR6Kn5AffOJDKCAAER8cxCX"
Message-ID: <125be237-9e6c-4690-9151-dbb535249f93@amd.com>
Date: Tue, 3 Nov 2026 17:07:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/8] drm/amdgpu: Support VMID 0 GPUVA completion WB
 address for UALink
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
 <20261102160125.2743750-3-mukul.joshi@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261102160125.2743750-3-mukul.joshi@amd.com>
X-ClientProxiedBy: YQZPR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::29) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|BN7PPF7C0ACC722:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b381ad-bb7e-4ed5-918d-08df39f6d82e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261102123227099003|11063799006|261022105027099003|4143699003|56012099006|261009223027099003|261021121427099003|261021123027099003|261102130727099003|261026121527099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003|6133799003|3023799007|8096899003;
X-Microsoft-Antispam-Message-Info: 6GsugRxTNTJQvwYnQNGpNURIb1nBbAJ7ThHW1hPZeOBga8yq7A9fwLyvXvfyuhfZJ0vLK0Iwv+/K7PbgdASLGdH66Z3QyzHKF28UUKI6yHEpO8kLSsqV3amwtgLRp3cvOyxCKZSOOPOWrX0MBx3uMd3SAM71GnxiHurYqRn+6lTUeXogHUqNhCmAu6pFbkScvdTZq+xcUw1ad9fahBoVi1wrKfa6EP5XKfd3oOB+ihwm/36zrw1unl+ag6bH/T1Mr8hb9e0gQRfg7zl+DzrmMvrhuoZKLm1eUuQvUTt1+DRvfIDcA0XuPdCK/3WA+7X9qbVWq7nE80GO2lRB+Lv/Hj25B0pmp/jFVR2KkFN5IeHflR83Y5gjbonnSBCM892q3H4Mq4DCli82TuHt29m0RCg2V4RnEpdjYADqpTKcvy/eZHjv+CSJxXxH4rvYz8/JV273hogWLcByXLTxTW500evQ40Duple0nfeBT1ZvALRHHX8eXgIpzD2Jut3ZYHkaHEjE6hex/wOlh6Nf3+SP+g0QP5RINtjFbh/K3hxjKnBnwZfad0/+lY8U7kBO4gBMyJ3vq+YxR8nflLDbyHqH+XNMtnbyZKdgn2xhpdeMEL4mZOopjgztxm7pHxJ724JBUGACnu3VDfLOWqdvuPECubhNOwDguEZPIRdBcTOr0Ak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261102123227099003)(11063799006)(261022105027099003)(4143699003)(56012099006)(261009223027099003)(261021121427099003)(261021123027099003)(261102130727099003)(261026121527099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2F0RXFRSm91dkEwQmNHcHRWQ3QxLy9mV2ExRzg4d3JQcXhrTktDaDVzREU1?=
 =?utf-8?B?OWdwcHovclJ2UTdWbWdKOVNOVzYxTndVNTFaNkZiTXJGTm1zajQxV0FYbWRt?=
 =?utf-8?B?QWxualplTytxOC9yRC8rYjBmK3NJL1V3bkFSUXFSN0hSeDJZMEZqcUREYjNq?=
 =?utf-8?B?ZWhVQjNZWWxZTUFDamlSaG5nVmh0YjNZZGJSdE9PODRsTllnMFhQWU4xaERv?=
 =?utf-8?B?Ync4V1dROG1FUFI2dzZYVm9rSnU1L0d0bmNWL3BGcURKZ3B6NVNNaTRpYnlO?=
 =?utf-8?B?NnJlZGUvWGxKakxEa1h1WFM5RGR4THdsT2l4d1hnaVF6U1NNb1NGV3RDNWRn?=
 =?utf-8?B?ZnhvUy9xajAvU3FuZlVIcWJsb1pNbUlMVDl0TDZDWEU2ZGxEUkd4SWE5Z1ZH?=
 =?utf-8?B?Z2ZJOWszTDh3L3FtYnNmUnBIeGtISGd2dmRkY1JndUU4SWpYZEN0Nm42dUly?=
 =?utf-8?B?S2NscVAyUlllb2xLOGRrOHhiaU1aRTdzUm1QTmNVUXhiMmRGd3dTZWFzK1hn?=
 =?utf-8?B?UzRUdmV3c2NnM0dFODJUc2gwKzc0Q2dKakxSa1JHUjI2RWdUQlJMQ3NpQzVm?=
 =?utf-8?B?THZUS0Rsb214a2dXeDJ4WDNPcm9JSWovdFl1L0ZQR3lxRTlmYmFtQUNidWhU?=
 =?utf-8?B?MWhpcUN2ZlJrZ2lrcWZlM0ZZc0RNYlBFeU5ERHpjRUYxdE5OU2xWbXJHanE0?=
 =?utf-8?B?ZGw1U3dXTUhuK2RhL1hISVFlTWFDOVNSNDJvdWs0UFRBU3RENkcxVUxhaEVB?=
 =?utf-8?B?TDB4UlRpcEJxNG5ZeWs0cTUwVTVVOWVxVWtpdTkzN29UdW11WUNySDVCNFBJ?=
 =?utf-8?B?WVdRRWdFWTMxWlJ5UDEyYnJkb04rbkJjQXZka1hKR3hQZDN1ajJwZzVUM3Mv?=
 =?utf-8?B?V0s2UTBHRkFyM25ONnhGbFh1cWdlRTRVVnpXV0NoeHc0TzBuYmZqYnBCeEZI?=
 =?utf-8?B?UVN0UzRnMFRDNXN5ZzNYUnNmaUxsNWNVZ2htUlpocEpsYkE4eDBGK0hjbXRH?=
 =?utf-8?B?NTYxSDhBeVlhOWgxWG5wOUNsMnB4M0RKTGp2anE5WmpJVHdlYUsyVmdmWXBq?=
 =?utf-8?B?ZWF6a0NqVkVxdXduK3gvVzhyMGx0QWNvV2lwVjBqOHlhT2tnUnRTd0ZjV0Nz?=
 =?utf-8?B?RDhhaHRhWk53RE1xd0hQVERkZWxYSEtXTHQ0UXRWcmltblR3d3lPaUhuNStQ?=
 =?utf-8?B?bU5vMzhBSGF2QUxPY2xkUXZSQU9ueU15TlRDT0V6cVlLczNocnYwQ05rLzZv?=
 =?utf-8?B?RlNlWGlFZzZ4bXdCRzduM0YxWlhvTVBtUnhpaW1Fd291K09EektGaWZpRzkx?=
 =?utf-8?B?UGFMSCt2OS9henpZQ3NCeWRoTGc2OXNXZ3Y2YlN4NUMxV3g2QWhpVldiNkhV?=
 =?utf-8?B?bWJsaWZvWGRRY3BnWTBwZmtqT1grNXAweklTZEc2TFZ4cVZVUzZkbjZ6U2Vi?=
 =?utf-8?B?aG9FT0NhaUxCOTlDWC9lYzRQdVlnMG1UVG1SR3F4aHpoOEVZZFZVQmhadkdI?=
 =?utf-8?B?bWhKSHpoa1NoNlFrWWFraVF2QmVuVEZsL2RkVks3Z2NzZkFxMHd1dWlTYmJY?=
 =?utf-8?B?R3hOQmVaYVoxU3Nwc3JqelNNa0xRMldVL0RFc2NMVFhVNnRScnk0ZlZZbmhP?=
 =?utf-8?B?OTc4am1FYlVJbjFxUDlxZDIwQ1FHUE1MNlludXdRVzNwb01pbitjQk53N3hT?=
 =?utf-8?B?OEtPVDRhVGNkTC9ZcmdmNGNjT0pFQTR6TThUUnlQbFoyUEpMdnEwWWt3SCtX?=
 =?utf-8?B?aG80dXFTenMwYjhJalpFMkxlSnBFV2l2Z0Y4ek9JQ1NBbU1hTWxqRDFKUGV4?=
 =?utf-8?B?bzFlcWNlQ2M3dXpBalU0OUx6QlhncngwcWQ4TTUzekVuM2UwSmU4MFFCOWlj?=
 =?utf-8?B?ODBPakJLM0hlQVJGVzFjNGZQUTdMcTZTZ2hFc1U1NnYydituZGpBaVBZbnRa?=
 =?utf-8?B?eDdJemtXL2xBcTFsU2RaVkgvTkFaeFQvbVVMWklCdFlsTDdQd0FLSkV1TVBs?=
 =?utf-8?B?eGRsTnhQRFFkem5rWmJlS29mZ08xWUFvTERBendyRGs4bkxmNFQ1bjBPUXk0?=
 =?utf-8?B?ZDkrMEJacFhndDBpK05rTVJ1bTZJN1BKb0VrTzBWaU5OUDFKSFcwSDVUenNQ?=
 =?utf-8?B?MGxHVjJDdTczdHJHZTN5QW1QWlh6RTJLYU1vdjJ0ajVKR08zMFBnTFVTUDlM?=
 =?utf-8?B?MXpmaFNOS0UxbGRHZkVtQzFCeEsySktYTDFTUlJoT29taWl4ajlZRmlrMHdx?=
 =?utf-8?B?NFA5VlFlRjQxbGJqVVFrQzhPdGRwS0JEcVZINkpVclMzOFhyaWkvaE1qRkVP?=
 =?utf-8?Q?MrRMPgzfDDQai9wRtZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b381ad-bb7e-4ed5-918d-08df39f6d82e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 22:07:26.3564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEQWFCoBXM6pz5nxE1rDonidrjKOKFlNno01OOR++ghzsSQ79USYoMNJv+TgwdJV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7C0ACC722
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------0kR6Kn5AffOJDKCAAER8cxCX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-11-02 10:47, Mukul Joshi wrote:
> The UPDATE_WB_ADDR remote command hands the MP nHT FW the address it
> writes command completions back to. So far that has always been an NPA.
>
> The FW can also take a VMID 0 GPUVA, selected by setting DW4 of the
> command to 1. Return the VMID 0 GPUVA of the writeback slot from
> amdgpu_ualink_get_wb_addr() alongside the NPA, and use it in
> UALink loopback mode. There the HW only carries importer -> exporter
> traffic, so the FW cannot write the completion back over NPA.
>
> Outside loopback the NPA is still used and DW4 stays 0.
>
> Signed-off-by: Mukul Joshi<mukul.joshi@amd.com>
> Reviewed-by: Felix Kuehling<felix.kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 48 +++++++++++++++-------
>   1 file changed, 34 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index a98d5bbf0622..29a787979af2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -5652,9 +5652,9 @@ static void amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32 wb_data,
>   
>   	*cpu_addr++ = cmd;
>   	*cpu_addr++ = wb_data;
> -	*cpu_addr++ = dw1 & 0xFFFFFFFC;	/* lower32 wb_npa */
> -	*cpu_addr++ = dw0 & 0xFFFFF;	/* upper32 wb_npa */
> -	*cpu_addr++ = 0;
> +	*cpu_addr++ = dw1 & 0xFFFFFFFC;	/* lower32 wb address */
> +	*cpu_addr++ = dw0 & 0xFFFFF;	/* upper32 wb address */
> +	*cpu_addr++ = dw2;		/* 1: wb address is VMID 0 GPUVA, 0: NPA */
dw0 and dw1 shouldn't have changed — I don't see any difference. Am I 
missing something?
>   	*cpu_addr++ = 0;
>   	*cpu_addr++ = 0; /* metadata */
>   	*cpu_addr++ = 0; /* metadata */
> @@ -5868,7 +5868,7 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>   static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>   				      u32 remote_accel_id,
>   				      struct amdgpu_ualink_wb **wb_cpu,
> -				      u64 *wb_npa, u32 type)
> +				      u64 *wb_npa, u64 *wb_gpu, u32 type)
>   {
Since wb_npa and wb_gpu are mutually exclusive, this function returns 
one or the other, never both. I'd prefer to keep the interface as is and 
check whether loopback is enabled inside it, returning the corresponding 
wb address.
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
>   	/* The GPUID encoded in the write-back NPA address is the routing target
> @@ -5881,15 +5881,17 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>   	u32 accel_id = ualink_exp_accel_id(adev);
>   	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
>   	uintptr_t wb;
> -	u64 npa;
> +	u64 gpu, npa;
>   	u32 offset = 0;
>   
>   	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
>   		wb = (uintptr_t)remote->rb_cpu_addr + rb_size * remote->num_accel;
> +		gpu = remote->rb_gpu_addr + rb_size * remote->num_accel;
>   		npa = amdgpu_ualink_npa_addr(adev, RB_TYPE_TAILPTR,
>   					     remote_accel_id, accel_id);
>   	} else {
>   		wb = (uintptr_t)remote->rptr_cpu_addr;
> +		gpu = remote->rptr_gpu_addr;
>   		npa = remote->rptr_npa;
>   		npa |= (u64)accel_id << AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT;
>   	}
> @@ -5902,9 +5904,11 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>   	*wb_cpu = (struct amdgpu_ualink_wb *)(wb + offset);
>   	if (wb_npa)
>   		*wb_npa = npa + offset;
*wb_npa = adev->ualink.loopback.enabled ? gpu : npa + offset;
> +	if (wb_gpu)
> +		*wb_gpu = gpu + offset;
>   
> -	dev_dbg(adev->dev, "source %d remote %d wb npa 0x%llx\n", accel_id,
> -		remote_accel_id, npa + offset);
> +	dev_dbg(adev->dev, "source %d remote %d wb npa 0x%llx gpu 0x%llx\n", accel_id,
> +		remote_accel_id, npa + offset, gpu + offset);
>   }
>   
>   struct amdgpu_ualink_wptr_fence_cb {
> @@ -6068,9 +6072,9 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>   		ualink_exp_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
>   		remote_accel_id, int_wptr, tlb_wptr);
>   
> -	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
> +	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL, NULL,
>   				  RB_TYPE_REMOTE_INTERRUPT);
> -	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL,
> +	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL, NULL,
>   				  RB_TYPE_TLB_INV);
>   
>   	peer->interrupt.wptr = int_wptr;
> @@ -6104,7 +6108,8 @@ static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
>   	struct amdgpu_ualink_peer *peer;
>   	struct amdgpu_ualink_ring *ring;
>   	struct amdgpu_ualink_wb *wb_cpu;
> -	u64 wb_npa;
> +	u64 wb_npa, wb_gpu, wb_addr;
> +	u32 wb_vmid0;
>   	int r;
>   
>   	peer = &remote->peer[remote_accel_id];
> @@ -6116,13 +6121,28 @@ static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
>   		return -EINVAL;
>   
>   	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &wb_cpu, &wb_npa,
> -				  ring_type);
> +				  &wb_gpu, ring_type);
> +
> +	/* UALink loopback: HW only carries importer -> exporter traffic, so the
> +	 * MPNHT FW cannot write the completion back over NPA. Hand it the VMID 0
> +	 * GPUVA of the writeback instead and flag it in DW4 of the command.
> +	 */
> +	if (adev->ualink.loopback.enabled) {
> +		wb_addr = wb_gpu;
> +		wb_vmid0 = 1;
> +	} else {
> +		wb_addr = wb_npa;
> +		wb_vmid0 = 0;
> +	}
> +
then wb_vmid0, wb_gpu and wb_addr aren't needed here.

> +	dev_dbg(adev->dev, "remote %u ring type %u wb %s 0x%llx\n",
> +		remote_accel_id, ring_type, wb_vmid0 ? "gpuva" : "npa", wb_addr);
>   
>   	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, wb_cpu,
>   				       amdgpu_ualink_emit_update_wb_addr,
> -				       upper_32_bits(wb_npa),
> -				       lower_32_bits(wb_npa),
> -				       0, 0);
> +				       upper_32_bits(wb_addr),
> +				       lower_32_bits(wb_addr),
> +				       wb_vmid0, 0);

                      adev->ualink.loopback.enabled, 0);

Regards,
Philip

>   	if (!r) {
>   		ring->wb_cpu = wb_cpu;
>   		ring->ready = true;

--------------0kR6Kn5AffOJDKCAAER8cxCX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-02 10:47, Mukul Joshi wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261102160125.2743750-3-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">The UPDATE_WB_ADDR remote command hands the MP nHT FW the address it
writes command completions back to. So far that has always been an NPA.

The FW can also take a VMID 0 GPUVA, selected by setting DW4 of the
command to 1. Return the VMID 0 GPUVA of the writeback slot from
amdgpu_ualink_get_wb_addr() alongside the NPA, and use it in
UALink loopback mode. There the HW only carries importer -&gt; exporter
traffic, so the FW cannot write the completion back over NPA.

Outside loopback the NPA is still used and DW4 stays 0.

Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 48 +++++++++++++++-------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index a98d5bbf0622..29a787979af2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5652,9 +5652,9 @@ static void amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32 wb_data,
 
 	*cpu_addr++ = cmd;
 	*cpu_addr++ = wb_data;
-	*cpu_addr++ = dw1 &amp; 0xFFFFFFFC;	/* lower32 wb_npa */
-	*cpu_addr++ = dw0 &amp; 0xFFFFF;	/* upper32 wb_npa */
-	*cpu_addr++ = 0;
+	*cpu_addr++ = dw1 &amp; 0xFFFFFFFC;	/* lower32 wb address */
+	*cpu_addr++ = dw0 &amp; 0xFFFFF;	/* upper32 wb address */
+	*cpu_addr++ = dw2;		/* 1: wb address is VMID 0 GPUVA, 0: NPA */</pre>
    </blockquote>
    dw0 and dw1 shouldn't have changed — I don't see any difference. Am
    I missing something?
    <blockquote type="cite" cite="mid:20261102160125.2743750-3-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	*cpu_addr++ = 0;
 	*cpu_addr++ = 0; /* metadata */
 	*cpu_addr++ = 0; /* metadata */
@@ -5868,7 +5868,7 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
 				      u32 remote_accel_id,
 				      struct amdgpu_ualink_wb **wb_cpu,
-				      u64 *wb_npa, u32 type)
+				      u64 *wb_npa, u64 *wb_gpu, u32 type)
 {</pre>
    </blockquote>
    Since wb_npa and wb_gpu are mutually exclusive, this function
    returns one or the other, never both. I'd prefer to keep the
    interface as is and check whether loopback is enabled inside it,
    returning the corresponding wb address.
    <blockquote type="cite" cite="mid:20261102160125.2743750-3-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
 	/* The GPUID encoded in the write-back NPA address is the routing target
@@ -5881,15 +5881,17 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
 	u32 accel_id = ualink_exp_accel_id(adev);
 	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
 	uintptr_t wb;
-	u64 npa;
+	u64 gpu, npa;
 	u32 offset = 0;
 
 	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
 		wb = (uintptr_t)remote-&gt;rb_cpu_addr + rb_size * remote-&gt;num_accel;
+		gpu = remote-&gt;rb_gpu_addr + rb_size * remote-&gt;num_accel;
 		npa = amdgpu_ualink_npa_addr(adev, RB_TYPE_TAILPTR,
 					     remote_accel_id, accel_id);
 	} else {
 		wb = (uintptr_t)remote-&gt;rptr_cpu_addr;
+		gpu = remote-&gt;rptr_gpu_addr;
 		npa = remote-&gt;rptr_npa;
 		npa |= (u64)accel_id &lt;&lt; AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT;
 	}
@@ -5902,9 +5904,11 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
 	*wb_cpu = (struct amdgpu_ualink_wb *)(wb + offset);
 	if (wb_npa)
 		*wb_npa = npa + offset;</pre>
    </blockquote>
    *wb_npa = adev-&gt;ualink.loopback.enabled ? gpu : npa + offset;
    <blockquote type="cite" cite="mid:20261102160125.2743750-3-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	if (wb_gpu)
+		*wb_gpu = gpu + offset;
 
-	dev_dbg(adev-&gt;dev, &quot;source %d remote %d wb npa 0x%llx\n&quot;, accel_id,
-		remote_accel_id, npa + offset);
+	dev_dbg(adev-&gt;dev, &quot;source %d remote %d wb npa 0x%llx gpu 0x%llx\n&quot;, accel_id,
+		remote_accel_id, npa + offset, gpu + offset);
 }
 
 struct amdgpu_ualink_wptr_fence_cb {
@@ -6068,9 +6072,9 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 		ualink_exp_accel_id(adev), peer-&gt;interrupt.wptr, peer-&gt;shootdown.wptr,
 		remote_accel_id, int_wptr, tlb_wptr);
 
-	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &amp;int_wb, NULL,
+	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &amp;int_wb, NULL, NULL,
 				  RB_TYPE_REMOTE_INTERRUPT);
-	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &amp;tlb_wb, NULL,
+	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &amp;tlb_wb, NULL, NULL,
 				  RB_TYPE_TLB_INV);
 
 	peer-&gt;interrupt.wptr = int_wptr;
@@ -6104,7 +6108,8 @@ static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
 	struct amdgpu_ualink_peer *peer;
 	struct amdgpu_ualink_ring *ring;
 	struct amdgpu_ualink_wb *wb_cpu;
-	u64 wb_npa;
+	u64 wb_npa, wb_gpu, wb_addr;
+	u32 wb_vmid0;
 	int r;
 
 	peer = &amp;remote-&gt;peer[remote_accel_id];
@@ -6116,13 +6121,28 @@ static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &amp;wb_cpu, &amp;wb_npa,
-				  ring_type);
+				  &amp;wb_gpu, ring_type);
+
+	/* UALink loopback: HW only carries importer -&gt; exporter traffic, so the
+	 * MPNHT FW cannot write the completion back over NPA. Hand it the VMID 0
+	 * GPUVA of the writeback instead and flag it in DW4 of the command.
+	 */
+	if (adev-&gt;ualink.loopback.enabled) {
+		wb_addr = wb_gpu;
+		wb_vmid0 = 1;
+	} else {
+		wb_addr = wb_npa;
+		wb_vmid0 = 0;
+	}
+</pre>
    </blockquote>
    then wb_vmid0, wb_gpu and wb_addr aren't needed here.<br>
    <br>
    <blockquote type="cite" cite="mid:20261102160125.2743750-3-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	dev_dbg(adev-&gt;dev, &quot;remote %u ring type %u wb %s 0x%llx\n&quot;,
+		remote_accel_id, ring_type, wb_vmid0 ? &quot;gpuva&quot; : &quot;npa&quot;, wb_addr);
 
 	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, wb_cpu,
 				       amdgpu_ualink_emit_update_wb_addr,
-				       upper_32_bits(wb_npa),
-				       lower_32_bits(wb_npa),
-				       0, 0);
+				       upper_32_bits(wb_addr),
+				       lower_32_bits(wb_addr),
+				       wb_vmid0, 0);</pre>
    </blockquote>
    <br>
    <pre wrap="" class="moz-quote-pre">                     adev-&gt;ualink.loopback.enabled, 0);

Regards,
Philip</pre>
    <blockquote type="cite" cite="mid:20261102160125.2743750-3-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	if (!r) {
 		ring-&gt;wb_cpu = wb_cpu;
 		ring-&gt;ready = true;
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------0kR6Kn5AffOJDKCAAER8cxCX--
