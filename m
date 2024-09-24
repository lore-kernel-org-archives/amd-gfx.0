Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B80ACF9C6B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 15:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43C5810E709;
	Tue, 24 Sep 2024 15:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ITARi97Z";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE6D10E709
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 15:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6DNgzty0sVmviJycTkuYcO2claYN1uibRbyolVx96dAmmvScRBQCd02QrQdXy2AxMB2g9Dt8cee57/35u0YIhgjukyjAJlsHN7+l0v1kaoCddJJFELuybn/KKT7csSdDvOHmGhWSns2YpwaJR3BoaM/orQHITG2XCezJfQ5xrPbnNnX/42MgKziv8t4M33tSGZSi7pkg1Vb4uBsjyw5K4CgoRuUNYZHJDerHykKBUf5AmHnQofW1jkfGgDjeF9KqncYu8DHLIpBvAun1rGekIUKyt+8j3VWL3aMkPWJ12z+glFTZoUjVP3WrmeDMKAr7nt6A6VksZeGcoL+ovQelw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4I9e42NphswuLV3WQkZrrp4vpxueTMLtmk8dyjxZc4=;
 b=hjMCj48uQ+4PTSUCzYdcZkR4bHVaLli1dIFSH2H6E2WsGIvUe4Sx59iJL2s9EG9NCYgz0lFuVOONE3rkZ/Qi5q1mOziFkGTyCVmHJsnaSLnHXBuIzyIc+YDWymPzX0s19Ff1aHtJpOMkKapBUjjT7HY0sHL1bBR6lP1kPsjdZSHkfiU9cmlTWlA9i8DyK9uWR2UBtbL2m+nCY+gkzf9PmH1pftCgchuQ6SZmlFV/2qNwh66DQps4v4TJgw5ekPk6YHpf6PFo7COxC4J/NaYcpHzxLv1LSPg2OEkKhmRPAH6It8gu12XbNTio9OP0YXs6Y9Ka+bbOf7NBM1YjpImhxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4I9e42NphswuLV3WQkZrrp4vpxueTMLtmk8dyjxZc4=;
 b=ITARi97ZMuMJWBSEo0ERcGDO7qd9XL20vprhEwUn/7LiUokJ7m3AZT9QMiHalv9tMp/8AIb1nye5c1gjOeCYFTWG8lKgAjTTrxD2CMveSFgGpTjzlit8AWPwkJmuU2SOc6Zdbt17YHSxwalwo6TyGsxNUb2B45Z3qoVspweacoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 15:21:14 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 15:21:14 +0000
Message-ID: <e08026e6-efe5-4cef-a5bb-fefe9b92acaa@amd.com>
Date: Tue, 24 Sep 2024 20:51:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/amdgpu: Add supported partition mode node
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: le.ma@amd.com, hawking.zhang@amd.com, shiwu.zhang@amd.com,
 charis.poag@amd.com, donald.cheung@amd.com, sepehr.khatir@amd.com,
 daniel.oliveira@amd.com
References: <20240924141549.244754-1-asad.kamal@amd.com>
 <20240924141549.244754-4-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240924141549.244754-4-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 18fc4a41-d49e-4e26-694f-08dcdcac8761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkRrc0dqUDcxNnZvbEoyK1IwL1FaMU1Fc29zMzl2bkhQVnRGeDNUcHlFVm1h?=
 =?utf-8?B?eC8rVStaQTJIbjFtZU93bWlNVHIvaFgxc1pDQ2F3T3ZhR1BIUFlxRFRCaWVn?=
 =?utf-8?B?M1g2Tkk4UnQvR2xyM3F4WnVjdWFhWFoyZ2RmOU9rK2JWV21pMVh2d0F1Z2J5?=
 =?utf-8?B?Y2IxYkxPVTNuQlMyZ2lBQmZlb0hSMmdXRWN5K0VkUVM1Q05QL2wzU0FSMXZH?=
 =?utf-8?B?dktpWDRNN0pjV3JVVTE1c2hKaW11M1RxVmZZMTArQTRpZmFnZHZKaFFPVzJW?=
 =?utf-8?B?NXhOZDJpR0Z1cDc1NjVmY1hMbTBuWEJnakpaajY4NS9LUzVraTV2M3dlaDdV?=
 =?utf-8?B?M1MyaFRKdmcweCtRSnEyVk9PY3pNNlF3QS9YT1UvUHNtUHpNTnRlazF5RDYv?=
 =?utf-8?B?ejNtNU02WEs3Q3VVcU1CZTZaT2xUb2dobkdSRnhLVmMzaVhvSENKQ1pkOEZS?=
 =?utf-8?B?RmpSdUxYSzE2dGhIN0ZTc0FxaXdmS0FiNS9DRFNJWkZ5OEpxb0FUYVRNRlJW?=
 =?utf-8?B?TkhZa2hjMEdLRkRVMjJGZ1RwWEhiMldTTkg1dWdLb0I4UTl3R2x1dDhuT1Z0?=
 =?utf-8?B?dGlmQUROUXBiUDIxbGNuSXEzanVmc3lSbzFIMWMxS3NkWkVyODZzWFVIVDhX?=
 =?utf-8?B?U1NHSDNMVExwZ1NDa3NueUkyY3pUa0hXM0xGQU1CdUJ3anZuTnAvZlJHd1cv?=
 =?utf-8?B?c05ycFp3MjQ0MEZxdUVxNVVYMXhzME00ZUY0Ym81UExMUmVDUzJDSlJHc2Rx?=
 =?utf-8?B?VThOaEdvV3F4U01BYjBGYVdMcDU2WEFzcGh2Wnc3bVVabCt3TTEyT3FPTlR0?=
 =?utf-8?B?MXB3U1RsZjBlK0ZIQjJTUGxyMkE5SCt0WmZ3WWVUK0Q2bmpGcFJ6K2FqeUxv?=
 =?utf-8?B?b1c3TFRoems3SVFJYU15dEhXQ2xUQkU0Qy9wMzdLVjVJZElnTEwvZ0JYRzJ4?=
 =?utf-8?B?RWF0b2gxOEd4MWxLdTJzSVE0UHptSGc3L2R5UDM3YmRYVnQ0UXFCcXR6UWdl?=
 =?utf-8?B?YjVtZ0Z4VkVkbnd3a2FObm9BVnBQQnVyWUN2Q2lGY0s5YmJaaE5BdC9VMUV1?=
 =?utf-8?B?Z1RJOW95dDJ3V1pkbkRyWUl3WDZ5dUJ5bjltTEpUaURsZXowMUNvMDlnNE5a?=
 =?utf-8?B?UEJvNnJ4dzhqSGJ0MDEvdlpTbTlrZXRPVEIwa21vZDlqN3EvUjRESWRuWmxM?=
 =?utf-8?B?YjlzdjN0VUVoSnRjNHB4TzdKUjVhV0lsNUhONTBGQ0RDcEhydWhJNDZQRTUy?=
 =?utf-8?B?NUQyeVNjc0Nia0hnVjlqaTdua3FEWUVhd0RzMnJPVWJ0cC9sL2p6NldsZm5M?=
 =?utf-8?B?SHBzeFdianZLVHpzTVpSNTQ1d1lqT2p3cTRsNVJFWm5rUGRKbm1uL3hsVHBN?=
 =?utf-8?B?dWRFMFJQaGFFS2JhVG9OMEpEeWtQY2FxeEJFZllMUnZ4c1RFQ3ZqRXBYVkhl?=
 =?utf-8?B?RFBMRFdXUDdpYk5tZjhPb2YyYVhnWForUGNqSlgvaDV4WGI1UG5XZE5YcUNB?=
 =?utf-8?B?cDJoTDFPc0JiY0tYUjMrNFdSNXpWN3ZGKy8yeWNNY3V5YnpkNjNqVHlMUkNk?=
 =?utf-8?B?NmRNb2MzYjJESjN1dUxIYU5wMExjMkgyQVJ1VnpoSHpsSGFpMlo1SE1NeUxi?=
 =?utf-8?B?eWdzdTNHcUlBMFJDNXV0RmhqU2NHOEdTN2sxMTRVN0xZdVhuZlJma3FHeW5I?=
 =?utf-8?B?ajI1c3VnNitUZmJzQmwrYmxjM2VGTFBxd0o1VzgrM1VhNEI1a0ZZd2pvWWpJ?=
 =?utf-8?B?VmdSZFVDOHJCd2ZmYzJDVzVIOFRZZVkwOG1XdE5TOUw2YUVNRy85NXBjTm5z?=
 =?utf-8?B?M082U0dQZHlUeFVEbmdhZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFg4dTNZMzdsWjUyS1FSeG1QZEp5SVRrMjlCc3Y5Z3J0N0ZBay9nc2JEb0wv?=
 =?utf-8?B?dEZoUVpwd1pSVXpNR09qQldkNkU2UlZLNGNiMGxSZlBHN3hVNjdobmdDZEVX?=
 =?utf-8?B?NVZPVVh3ajhiWWIyT3lTYmU1enVOTTdWMGhnRk9nVDdUQzlKUit0M3hkaGYy?=
 =?utf-8?B?NFJtSFEwQk1VS2xRV3hXYVFaWksvb053REpDMUl6KzVjQ01uYVhKbzFUZEoz?=
 =?utf-8?B?Q1JXYU83cGdhYnozTVRIc0hVZ0diZnA2TjFrS3A4aFRWMDF4OWx3ZzJlY291?=
 =?utf-8?B?N3R6cFpuVVA2TlVid3M3MW1rSVowbmxtRUtFWXcxSU4xbHVuZ1A1cFBmdlk2?=
 =?utf-8?B?Z0NQSHRJemJLV01wd3l3aXduVDR2RVUrSmxEamtZaEVSNGZSRFM4STdXZmtH?=
 =?utf-8?B?SE5hTHJxaXdyUE56TDhIK0tISjNoOE9CWm1CdEpBMjZCWmp5UzczS0pwUU00?=
 =?utf-8?B?YWNhdWxWYW5qdTNDY0RkUVo4TDJyNjZnNVNyM29QdEltaFcxUG5neXhJVnhQ?=
 =?utf-8?B?YzVBMnY2SFM3WUo3ZGtkaEZ1dklFTDlIZUJ6SVRwQzYzUHFnUCtld0FFNWZy?=
 =?utf-8?B?RFUzMTdXcWFsVC9wZkR0N0pqanZRTldPSmE3ODBUSXNSRFNjOHpQK2xvVy8v?=
 =?utf-8?B?d3Zac29mOC9ZazRwUWhaRXFIekYzRWpBVFdlVVRMN1lSNWJnT1ZGbG9ZYlc1?=
 =?utf-8?B?endqUm1TK1dFSDBwNTJ2QktZMWtaZ1ZDZ0pOenBPRVlseXYxeXVQaFQ2Qktk?=
 =?utf-8?B?UXZEYUZBZ3JQTXltTWpJampEdG5TQ1BzdnZqSzJUcDk4TDFYT0FJaENXMkhI?=
 =?utf-8?B?NktaMXBEL0U1K1pHQXJwMzVYbEcxazlpSlZMZGhSSXBTV2xSUksyTkF3Q2pE?=
 =?utf-8?B?R2hDZk1RRnJmNEpBTnEyY0MrcGkyMmlvVnkyMHpFeWdoQlJrWjFHYVlkOTIw?=
 =?utf-8?B?UWYzWXR5aU5XemxKVTIzcy9hWWtWazlSMW9xaHZnVnJTY1JhUnBVWDgyMDVO?=
 =?utf-8?B?UEFPOWN1QTQySU1Xc2tXZXpwc1J1Q255eFVCelhCNVYyWnBSTDV5ODlGRE1z?=
 =?utf-8?B?WmV6N3ZsV3FQRkdIOCtIVklZckcyalJvY2ZNTG5vdFdobng2SEQ5NmxzV0tm?=
 =?utf-8?B?bFl2cEUrZ2VZQmtiVko0S3hORXoxb2tWWkhQUk83UG9Bbzk2NUc3L3lpYjNK?=
 =?utf-8?B?VXNzZUF2TE1rNjI3UTJ0Z1ZSMVJpOTIyd1d4S2ZFYTNsUDBkTkVFYnoydExM?=
 =?utf-8?B?eFV6RTBvMzhHaXZ4ZWFEYWlEbGk3WGVYSThxMmRYQkYrNmJzdXRVVjdhNmlH?=
 =?utf-8?B?Zk9mNTRzOXdtZ3lBQTdpdDAyVzcvZ2d0cTFpSzZlZFhGZFF0enpQV1p1ZGRK?=
 =?utf-8?B?cVNsazNOZ05sNjZMTktqRDlJODd6cG96MWRubVE5NHVxVGNFaDhtTUdEV1Ny?=
 =?utf-8?B?VjRGZXlnVE8vcW5pNmZlYkJVbGZxLzNwbVFUM0g2b3dPQkppWmpsRUtNbUZB?=
 =?utf-8?B?ZmttdVJXSnViTTRvODV3T2I2OS9JWVlndVhpTW9DNktGSWI3ZStCVkFQY1c2?=
 =?utf-8?B?OElsRzlKd2h2bkJzUytxczBXaVk4bENYak5QdG5GSnBsZ3NCaUhucFRSZlp6?=
 =?utf-8?B?bjdRTlRFV2JUVVU1ckRsZXBLdko3Q2x6SVJzdVphU2Z3NzYyL29Zbk5idFNk?=
 =?utf-8?B?Um1YOUxmMlVBWGsyVlpWWTNZLzRONzlkUVZPd2pPQWl5N2VubzlCUzFnQ09q?=
 =?utf-8?B?SjJVRWsyUkV6R1RDOHkxOTJ2cE1HVit4MUI2b0MreDc3aVVhL2trQk8rS0pQ?=
 =?utf-8?B?UUY4UkxZN21iNnRtVWF0WWVBdTNaNFo5T254WUtkT2pMZzA4ZW9nc1NtQ0RL?=
 =?utf-8?B?SzduNmphc2JtQ2ZSM3phMWNSRytFd200N0FWRXFtL0hEWU5PN21ZTkVsNWFT?=
 =?utf-8?B?bDliSUlFRm9uSGVvVzljKzkwTDJ3NWIvSmwyMnNuclp6ZFFZUXdUNVFHdnJS?=
 =?utf-8?B?ZDlOMjlsRSt2VWs0WGJEVUFiWEFFM3E4RnlMb0liZXJXa0JWb0wycTVsWHRL?=
 =?utf-8?B?OU1VU1BWR3BIcEpEcUEvQlZVMjBRQWtaaWhZU1NkQlR3bXNLZEM2aW1iMFJi?=
 =?utf-8?Q?BkaU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fc4a41-d49e-4e26-694f-08dcdcac8761
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 15:21:14.4585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SL6yt4/VWUVEHhPmjlYunBke3oDaGTlsmDN9xuV9trqOQkj1eYkVHm+w4oPNgHmQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817
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



On 9/24/2024 7:45 PM, Asad Kamal wrote:
> Add sysfs node to show supoorted partition modes across all NPS modes
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 48 +++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index fc4ab1d8c7c9..10daa6a15e5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -463,6 +463,14 @@ static struct attribute *xcp_cfg_res_sysfs_attrs[] = {
>  	&XCP_CFG_SYSFS_RES_ATTR_PTR(num_shared), NULL
>  };
>  
> +static const char *xcp_desc[] = {
> +	[AMDGPU_SPX_PARTITION_MODE] = "SPX",
> +	[AMDGPU_DPX_PARTITION_MODE] = "DPX",
> +	[AMDGPU_TPX_PARTITION_MODE] = "TPX",
> +	[AMDGPU_QPX_PARTITION_MODE] = "QPX",
> +	[AMDGPU_CPX_PARTITION_MODE] = "CPX",
> +};
> +
>  ATTRIBUTE_GROUPS(xcp_cfg_res_sysfs);
>  
>  #define to_xcp_attr(x) \
> @@ -511,6 +519,27 @@ static int amdgpu_xcp_get_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
>  }
>  
>  #define to_xcp_cfg(x) container_of(x, struct amdgpu_xcp_cfg, kobj)
> +static ssize_t supported_xcp_configs_show(struct kobject *kobj,
> +					  struct kobj_attribute *attr, char *buf)
> +{
> +	struct amdgpu_xcp_cfg *xcp_cfg = to_xcp_cfg(kobj);
> +	struct amdgpu_xcp_mgr *xcp_mgr = xcp_cfg->xcp_mgr;
> +	int size = 0, mode;
> +	char *sep = "";
> +
> +	if (!xcp_mgr || !xcp_mgr->supp_xcp_modes)
> +		return sysfs_emit(buf, "Not supported\n");
> +
> +	for_each_inst(mode, xcp_mgr->supp_xcp_modes) {
> +		size += sysfs_emit_at(buf, size, "%s%s", sep, xcp_desc[mode]);
> +		sep = ", ";
> +	}
> +
> +	size += sysfs_emit_at(buf, size, "\n");
> +
> +	return size;
> +}
> +
>  static ssize_t xcp_config_show(struct kobject *kobj,
>  			       struct kobj_attribute *attr, char *buf)
>  {
> @@ -564,6 +593,19 @@ static const struct kobj_type xcp_cfg_sysfs_ktype = {
>  	.sysfs_ops = &kobj_sysfs_ops,
>  };
>  
> +static struct kobj_attribute supp_part_sysfs_mode =
> +	__ATTR_RO(supported_xcp_configs);
> +
> +static const struct kobj_type supp_part_sysfs_ktype = {
> +	.sysfs_ops = &kobj_sysfs_ops,
> +};
> +
I think this is not required. Other than that, this looks good.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +static const struct attribute *xcp_attrs[] = {
> +	&supp_part_sysfs_mode.attr,
> +	&xcp_cfg_sysfs_mode.attr,
> +	NULL,
> +};
> +
>  void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_xcp_res_details *xcp_res;
> @@ -583,7 +625,7 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
>  	if (r)
>  		goto err1;
>  
> -	r = sysfs_create_file(&xcp_cfg->kobj, &xcp_cfg_sysfs_mode.attr);
> +	r = sysfs_create_files(&xcp_cfg->kobj, xcp_attrs);
>  	if (r)
>  		goto err1;
>  
> @@ -611,7 +653,7 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
>  		kobject_put(&xcp_res->kobj);
>  	}
>  
> -	sysfs_remove_file(&xcp_cfg->kobj, &xcp_cfg_sysfs_mode.attr);
> +	sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
>  err1:
>  	kobject_put(&xcp_cfg->kobj);
>  }
> @@ -631,6 +673,6 @@ void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *adev)
>  		kobject_put(&xcp_res->kobj);
>  	}
>  
> -	sysfs_remove_file(&xcp_cfg->kobj, &xcp_cfg_sysfs_mode.attr);
> +	sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
>  	kobject_put(&xcp_cfg->kobj);
>  }
