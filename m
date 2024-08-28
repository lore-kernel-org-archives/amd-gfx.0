Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E455C63798
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 19:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1973210E5C1;
	Wed, 28 Aug 2024 19:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mffzMUEz";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 437CF10E5C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 19:43:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jv41eYw2M7kEUfxREpuTwhuUUiurxvhSUFDAv6kFZ/91GMJONsDqs20czeGw/ltX1i+eR3C/RvdTIlxX7lFR5Bpf6SL+4oVcx3zDHbDesyva6B1BFhDcmCEQRpPdq0GHdLQ97gICEz2687MntRTmGvvVW230uRu34lzIJVsKvEJaUwczS2j6oJGJ+VJ0OpXL++FICF3XB77vMxD643s+c9zk3424mm/3ItS9d5tRnPztpDpRpX4yplqPzIsjZ3LZs3cPWbB52IpEuxLVsYsXvz/pWiLh1FVx8djXPltYSEMBMEdJlXp2Z+O/I/njc8uoqDFqYzmeexeeZ0B0zw3omA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcYZEiPjZjKjMcuI/o341UqWPEqDFBs2fvJuIbNFL/A=;
 b=yV2SEb75zj1QrpqE7hBhB9ngm5nnP2ZFryRqLU4tZuprZV5kN7ws4oub+4fk1UWVUvDL2UWEgxpWCMdqSQyhERN4nE6gFxb+IoX9Nmz8OQAWnlXEgUFoQfoTopzSnOsy6aW8e0DoYoXoxZjAaCwPt7Zln4T8A6srQpbFcTNJjQM9rfz+845sK1EwoFR3NPTnIA7+wsNJVPFC3bmCHnU90C8aCvmMyrngoowCE+BiO+gf7Ghr0Vh1lh9Famh5E3eJ8Zj/0cJ1JfMteDs/ViWEz2b7Rcmswwmodj2q45zEfbRpm5OhefeLBwATDEuM2Zds6di/n5vFSSX1Gv5/5hrOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcYZEiPjZjKjMcuI/o341UqWPEqDFBs2fvJuIbNFL/A=;
 b=mffzMUEz2MjYN8+gNThYA0GpqnnSRRn6VWhItWp3y0kxPSzuxqsyJfOW65RDXjaPn2oy4kRiPhiZyxyrwp/d+NrXDUAOnDCNmDMr1m+qKatpffbrQ/YJzdl54ezSKBPWFOgRsdRRW/SvSrSagISlejIt9gowi8uF8fcfnsQkJcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.28; Wed, 28 Aug 2024 19:43:10 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 19:43:10 +0000
Message-ID: <773d3d99-4e97-45cf-a457-51989ba3081c@amd.com>
Date: Wed, 28 Aug 2024 14:43:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW module
 parameter
Content-Language: en-CA
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240826193420.126272-1-Ramesh.Errabolu@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20240826193420.126272-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:806:20::22) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: c84a0cf1-c54c-407b-b5a8-08dcc799a58a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXB1TFRhd2cxa3pWT3BDUWlGa3ROWUV1YVBHR3pvdUM2eDBVbStWYVMyUnhr?=
 =?utf-8?B?algrTG9IejZSRmRLM0NiSWdtSHBFL2kvRWQwbUdLR1Qzbm9uUWpYLzc3NmtV?=
 =?utf-8?B?WmJreDNvV1dXOUhkb0w2eHFxakVMSCt1SjRXczRPZHUvcHQ4Sm1FZlY2MzRR?=
 =?utf-8?B?SFQ5V3BUcTJIeTI2eHU3aFdXZGNjOFpOTDBOWHdweTNTdDNJU1dvWGp1MER0?=
 =?utf-8?B?ZGlvVGJyOWhiL0hQRVVlc0hIU2lseXhUUEhuZEpqTkFlVlRtRHVZSGVwMUtu?=
 =?utf-8?B?OWNNZzRCZjl1dGtrR1pMb0NxSk4wOVR1MWZUQVZrWVFSL054QVVCT1dXaVpm?=
 =?utf-8?B?QTNTUVZGeGY3ckkzWmpqR1hvWWZSVmdCcHhKWTM5NmdzLzcxcjAyZHpBMVRy?=
 =?utf-8?B?WkdoZWtJZ3RCeUIvVW1NOS8zbkZOaXBVdEpiK1E0S3ZWVy9OUGlSNEdzbHN2?=
 =?utf-8?B?OHk4dWhXdDVFVW9EME9CUWg5QjlBL3FHVlcxeEI1ZXVlM05ES1I0eDMvNDZK?=
 =?utf-8?B?anhJV2Y2MXZrVkg2RjMxbW8wVFZXYTM2VzdYbU5nTzFBZFVMQnZ0M3VqbWlS?=
 =?utf-8?B?K3JESSsrajRxSnRjdDg5SkJvZUYvVTRzNHlZci9TdThuWHlia1grNncrWHhQ?=
 =?utf-8?B?K0ZkeHI1Snp5c04rMDZ1c1lwWHVRM2Jpb3h2S1VYaVRpNDh3SXQrdThhZGxw?=
 =?utf-8?B?YzFldjg3M3FYUWVhL3QyWTh1eVE5NEM4dWdTRk1wSXpadHhSRmVFNUFiQ2o3?=
 =?utf-8?B?bm9Rc0oxd3RJTUk2OVJFU2doYk9reEhlV3cvYjFQaFEwQlB4OExrN29yV2Rt?=
 =?utf-8?B?ZlRhTjhuSE9EUHBTT3VnQXJueTNwbGNVTGpqM1psUFowZHZwYy9tT1pOS2lZ?=
 =?utf-8?B?T0h3T1BVbm43SitPSlZMN0orU2VaM2lmbm1xYnNKekkxb2RSeURiMWlhRjJP?=
 =?utf-8?B?cXBQVzg4VkxKd2lpN2JJWEhxb2VUYjc1RDVQc2t4VURRc1VUSEZ4Mm9KN2M4?=
 =?utf-8?B?QkR4S0dGby8rZFpEMGtLWkg3b1kwbkcyaytrM2FKeEhKN3RQTU5Tdk9DUjA5?=
 =?utf-8?B?QVBLZzZJL0FRdk04bWhjTm5Lb1NjMG9hY1pBaXBuT0JoQW5xY0h2eGZUR2ky?=
 =?utf-8?B?RDBrYlZHOHgyRVBrRTZySXU3aGtnMUhvcWI4ZS9uM1BjaWh3QW04MGhzMWtx?=
 =?utf-8?B?ejBNT2l5T0tKcWFocVRjMUVQSytGekxOMlV5b1JhOGVlYXFMRTJ5VWtRNnlH?=
 =?utf-8?B?cXJ1MzVscktxbWFyVkttNVBKYnd3NXEyTGhTY2hGU0xXVWNSdUtkWUVuU2p4?=
 =?utf-8?B?WW5nR2J2QjFwcWNMVWtwNnZFamVrRnBSMjJzaWZSQkdSM0o0SEZ1TFNibnl3?=
 =?utf-8?B?dFVzMnlDUk5BbDJIUHRxMGZoN3JtbHF2azFtU05zYlRLd1p1dXhFV25WWmRo?=
 =?utf-8?B?M3JpVlgzNEhYNTlIdzdRSXNOMDhqV0pUNlRrWnQ2bWFZektnUUlDMXhDRjdT?=
 =?utf-8?B?SWVMWDErMUY5UnlzVmRvWFprWlZnUkZ6NHB3bnd1SG5HZTd6ekZkRis2YUFh?=
 =?utf-8?B?eUlmTlVNWElUV1VVc2tNa2ZsdlpKZUdGV2tXa3RWNzlacUtPdzJNT1BBOFFI?=
 =?utf-8?B?MmF3SEJFOE5uV2hjTmVhT2h5RkYrcDljQUkxT0ZoK1MrV0dMMWovTGtWZ3I3?=
 =?utf-8?B?d1V0SlhRVStuazlYNWl1VkR5cGpXL3ZRbSsrci92R0MwQ29HOFZVZVdUMDJS?=
 =?utf-8?B?Y2s2ZzIyUXF4Z2grN2JxOXRxNVQrby92bDZ0enNvWnI2MzA0MUQvK3JTR25H?=
 =?utf-8?B?dHM1K2JmVDlHSHhzQUpVZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXc2czdUZnZFVzhIWStITXRlYll4UENyQmlUTTZDQTQ2QU9UMzlISXVWaVI5?=
 =?utf-8?B?OVhEZ0gwODJmMEl5bEEwR3NVQkFjc1lUU2paaHgzdEhycktSNUZRTmpDbS8y?=
 =?utf-8?B?QU1mQmgySENPVjFvbXRURjQyUnYySW5Fa1NFOC9maUxzTnhXSzFQRzdmWFRE?=
 =?utf-8?B?Q1ZhMktQRXRqTElBNzlGS2xZVUwySkNKL1gyMlp2KzYwQ0pSUnZPQnBlbHpv?=
 =?utf-8?B?eDRSVXZpaVZMUFZ0aFlzcEgwcGNMQ05pN2hrbWZmVXJXWHhqS0s2L1kremRJ?=
 =?utf-8?B?eTNXZmpuWVZsWGRvcEZhZmNmS1Rzck1vUk44dkxFc1QrNmJsRGhJV3RRaWI0?=
 =?utf-8?B?eVM1aDNzUHU3VjNWQS9DZjJPRU5ZTHFsZkdxcWZlZnd0YmFENW5BK1ZReTlq?=
 =?utf-8?B?ek4wTXBmS2xYSm5GS0tWMHVFYWlKY2dwN1o0dm0xalhid2JkSHZDMWN4UWRu?=
 =?utf-8?B?ZVZSQm1KZnpNVkZwMkVNbTBvNS9yT2ErQVcxK3J3ZUFhYkdLL1NUbHBFRGhW?=
 =?utf-8?B?b0FRdjhtbk9QZlp4SWtGeStNZFlYV2JpSUo2T0ZidDNINXRMU0lUK1NxMXpr?=
 =?utf-8?B?SDUzVU1sNlVSSDZoNmhEdjZ4eElRS0hDeEIvbjlLUWtxN1FVQXhGVGZOaENw?=
 =?utf-8?B?NTJHNEVqMjZJaTJDZ1g2UWdvOG9mSlp3T2U3WTN6M0YyQnJNc25laEoyeGtv?=
 =?utf-8?B?Z011Vk1GNFNFeHB2bzBzZmtOZ3czMjdFWCtXcWFqalQrVk5HSzVHK1QxNDRu?=
 =?utf-8?B?ek00TC9yUy9xVFJYcUIxVWUrVW9FZWM0ZzgrUHFpanNWajVtem5GU2lRNWRp?=
 =?utf-8?B?Tjk4VmJ2UkZTd2JNdExDVG1FWnNIeHBHdXVlaDJ1UDB0Z3dJTjVQcmdYQnF5?=
 =?utf-8?B?SWVLM3ozckx0TGxGc1lZNUNuV3RVMmdUNFI2MnBBWHdrMStKZXN1aCtJdUl3?=
 =?utf-8?B?c0FsMStLemM5aUhIcG5hcWd4d1hYb0ZOR1JDR2tRbzljUmQvL3VyTURZT3Vr?=
 =?utf-8?B?L2tWRWZUL25xdkNxOENaV0QrUms4ZVB4NER4TTNzc3VpR0dFRmFCSS9kMzBx?=
 =?utf-8?B?LzVScEpJVmNZZlF3ZUJqTUJxQzR6c3doR08rYktZTDd5MnF1aENLdVNJQlBK?=
 =?utf-8?B?MStVSitKZXE5RmtoRUlzWEFGNGNjS2wrc1QwL2tVcG9rbk4vcldiaDQveWhr?=
 =?utf-8?B?V3lOOFIvWVBDS2NmUHNTWDRTcjFkVVVaT3VqdGlib3dGTHhRRlJjcVBkMVRX?=
 =?utf-8?B?ZmlHSnFKZmgvcDZpdHlxNkJDb1lGeGxXMWdmU0FZSHZBcjB1VHI3cEJZUURo?=
 =?utf-8?B?TGhpdW14ZVlrOW5ZZlV2bVdYSkNERk9BVkp2L1R0VnBUazhQRnVHRjdTQzBQ?=
 =?utf-8?B?ZU4zMEJFT2lyQlRCNUNtUVcxOTRDRnhySTdzMlRhNUxvbVZCT1VFUktGVC95?=
 =?utf-8?B?aEc1dTl3b1l1RWR6TU5GbGs0WlU4N3gxeTFwNTBnUmgxK2VmWk5OMFVTbGJF?=
 =?utf-8?B?TUViMjgwcDZHaXZuaFVTSUIwWHFrbHphRGQ1ZGs5aUNoaUc3d3Z1MzUwQlly?=
 =?utf-8?B?ZFRlcFVST1lrQzlCa25EdGhrd2F3dWFoMzVCWm1QbWs0elNtcms0ZUdXSTFZ?=
 =?utf-8?B?d1B3T2tWQWtycnlvY2ZBZW9wbzZJeCszeCtMbVBQbGtjVkdoM1orTThpZ3FS?=
 =?utf-8?B?VXdOVUNGekFtVVovU1EvRjIrVnNiR240NHlkWHkwRUpaNFp3LzIxNVUvd0hR?=
 =?utf-8?B?U1ZxZUNOc2ZYelpEM1llWlZUMVV0UG5Cdyt0L0NzRXc5VTRuV0k5MEUyKzNx?=
 =?utf-8?B?eVBPYVYwb3VvdWMrZUluZ2xtVTRTQS9LTXIvdlRuaEUyMHNnVHMrcWxUTzVE?=
 =?utf-8?B?c1B6bkpNVEFPdEFOSHR6MUpFUk5oM09vVG1rRS84Y3JvRnN3NnJwT3BsVll3?=
 =?utf-8?B?R0o0Znp5akQ2eFg3eVlSSmpmSmNSQXc1R2JlR3luNW5mYlJ5NS9ndjRjZml4?=
 =?utf-8?B?NUV6Y1ZNaEwxZ1JteEhWVzcrWmlyWGkzTGdoZXBrY0tRUHhYaFhzSU5tWTJu?=
 =?utf-8?B?UUQ1RkFkYy82THFFU0xPMVBGZ2tqNDdMeUo5cFh3czh1Q0gyVk1QYWw3S2RL?=
 =?utf-8?Q?NfwU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84a0cf1-c54c-407b-b5a8-08dcc799a58a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 19:43:10.2192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7V5ECcMv7bXWguR/pp8CybMecM2cxSesSJ4Vuwcr5XSHNyGPOEbHFzRfQ5tP5Ae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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


Why need this driver parameter? kfd has KFD_IOCTL_SVM_ATTR_GRANULARITY 
api that allows user space to set migration granularity per prange. If 
both got set which will take precedence?

Regards

Xiaogang

On 8/26/2024 2:34 PM, Ramesh Errabolu wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Enables users to update the default size of buffer used
> in migration either from Sysmem to VRAM or vice versa.
> The param GOBM refers to granularity of buffer migration,
> and is specified in terms of log(numPages(buffer)). It
> facilitates users of unregistered memory to control GOBM,
> albeit at a coarse level
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 +++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 12 ++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 26 ++++++++++++++++---------
>   4 files changed, 51 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e8c284aea1f2..73dd816b01f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -237,6 +237,7 @@ extern int sched_policy;
>   extern bool debug_evictions;
>   extern bool no_system_mem_limit;
>   extern int halt_if_hws_hang;
> +extern uint amdgpu_svm_attr_gobm;
>   #else
>   static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
>   static const bool __maybe_unused debug_evictions; /* = false */
> @@ -313,6 +314,9 @@ extern int amdgpu_wbrf;
>   /* Extra time delay(in ms) to eliminate the influence of temperature momentary fluctuation */
>   #define AMDGPU_SWCTF_EXTRA_DELAY               50
>
> +/* Default size of buffer to use in migrating buffer */
> +#define AMDGPU_SVM_ATTR_GOBM       9
> +
>   struct amdgpu_xcp_mgr;
>   struct amdgpu_device;
>   struct amdgpu_irq_src;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b9529948f2b2..09c501753a3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -169,6 +169,17 @@ uint amdgpu_sdma_phase_quantum = 32;
>   char *amdgpu_disable_cu;
>   char *amdgpu_virtual_display;
>   bool enforce_isolation;
> +
> +/* Specifies the default size of buffer to use in
> + * migrating buffer from Sysmem to VRAM and vice
> + * versa
> + *
> + * GOBM - Granularity of Buffer Migration
> + *
> + * Defined as log2(sizeof(buffer)/PAGE_SIZE)
> + */
> +uint amdgpu_svm_attr_gobm = AMDGPU_SVM_ATTR_GOBM;
> +
>   /*
>    * OverDrive(bit 14) disabled by default
>    * GFX DCS(bit 19) disabled by default
> @@ -320,6 +331,13 @@ module_param_named(pcie_gen2, amdgpu_pcie_gen2, int, 0444);
>   MODULE_PARM_DESC(msi, "MSI support (1 = enable, 0 = disable, -1 = auto)");
>   module_param_named(msi, amdgpu_msi, int, 0444);
>
> +/**
> + * DOC: svm_attr_gobm (uint)
> + * Size of buffer to use in migrating buffer from Sysmem to VRAM and vice versa
> + */
> +MODULE_PARM_DESC(svm_attr_gobm, "Defined as log2(sizeof(buffer)/PAGE_SIZE), e.g. 9 for 2 MiB");
> +module_param_named(svm_attr_gobm, amdgpu_svm_attr_gobm, uint, 0644);
> +
>   /**
>    * DOC: lockup_timeout (string)
>    * Set GPU scheduler timeout value in ms.
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 9ae9abc6eb43..c2e54b18c167 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -868,6 +868,18 @@ struct svm_range_list {
>          struct task_struct              *faulting_task;
>          /* check point ts decides if page fault recovery need be dropped */
>          uint64_t                        checkpoint_ts[MAX_GPU_INSTANCE];
> +
> +       /* Indicates the default size to use in migrating
> +        * buffers of a process from Sysmem to VRAM and vice
> +        * versa. The max legal value cannot be greater than
> +        * 0x3F
> +        *
> +        * @note: A side effect of this symbol being part of
> +        * struct svm_range_list is that it forces all buffers
> +        * of the process of unregistered kind to use the same
> +        * size in buffer migration
> +        */
> +       uint8_t attr_gobm;
>   };
>
>   /* Process data */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b44dec90969f..78c78baddb1f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -309,12 +309,11 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
>   }
>
>   static void
> -svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
> -                                uint8_t *granularity, uint32_t *flags)
> +svm_range_set_default_attributes(int32_t *location,
> +                       int32_t *prefetch_loc, uint32_t *flags)
>   {
>          *location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
>          *prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
> -       *granularity = 9;
>          *flags =
>                  KFD_IOCTL_SVM_FLAG_HOST_ACCESS | KFD_IOCTL_SVM_FLAG_COHERENT;
>   }
> @@ -358,9 +357,9 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>                  bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>                              MAX_GPU_INSTANCE);
>
> +       prange->granularity = svms->attr_gobm;
>          svm_range_set_default_attributes(&prange->preferred_loc,
> -                                        &prange->prefetch_loc,
> -                                        &prange->granularity, &prange->flags);
> +                               &prange->prefetch_loc, &prange->flags);
>
>          pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, start, last);
>
> @@ -2693,10 +2692,12 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
>
>          *is_heap_stack = vma_is_initial_heap(vma) || vma_is_initial_stack(vma);
>
> +       /* Determine the starting and ending page of prange */
>          start_limit = max(vma->vm_start >> PAGE_SHIFT,
> -                     (unsigned long)ALIGN_DOWN(addr, 2UL << 8));
> +                     (unsigned long)ALIGN_DOWN(addr, 1 << p->svms.attr_gobm));
>          end_limit = min(vma->vm_end >> PAGE_SHIFT,
> -                   (unsigned long)ALIGN(addr + 1, 2UL << 8));
> +                   (unsigned long)ALIGN(addr + 1, 1 << p->svms.attr_gobm));
> +
>          /* First range that starts after the fault address */
>          node = interval_tree_iter_first(&p->svms.objects, addr + 1, ULONG_MAX);
>          if (node) {
> @@ -3240,6 +3241,12 @@ int svm_range_list_init(struct kfd_process *p)
>                  if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
>                          bitmap_set(svms->bitmap_supported, i, 1);
>
> +       /* Bind granularity of buffer migration, either
> +        * the default size or one specified by the user
> +        */
> +       svms->attr_gobm = min_t(u8, amdgpu_svm_attr_gobm, 0x3F);
> +       pr_debug("Granularity Of Buffer Migration: %d\n", svms->attr_gobm);
> +
>          return 0;
>   }
>
> @@ -3767,8 +3774,9 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,
>          node = interval_tree_iter_first(&svms->objects, start, last);
>          if (!node) {
>                  pr_debug("range attrs not found return default values\n");
> -               svm_range_set_default_attributes(&location, &prefetch_loc,
> -                                                &granularity, &flags_and);
> +               granularity = svms->attr_gobm;
> +               svm_range_set_default_attributes(&location,
> +                                       &prefetch_loc, &flags_and);
>                  flags_or = flags_and;
>                  if (p->xnack_enabled)
>                          bitmap_copy(bitmap_access, svms->bitmap_supported,
> --
> 2.34.1
>
