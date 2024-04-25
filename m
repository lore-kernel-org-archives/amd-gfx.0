Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCB9C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 07:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEDF310FC08;
	Thu, 25 Apr 2024 07:16:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y696nFBE";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD1910FC08
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 07:16:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqOjhQ9jxT5HbrfsMhHkwFjX/XWUmWs3jzJSP3o4cPXJqqQrrtZVGP6cutSgXLpucrRHcd+/BZMhY3mOrpKZKb5E6Qu4RGiuiM/TQ+q+MUbLX5PWt+e+m+sF+8OjBkwMA6gQnr82+6MaHhbdTh6DmuL6gDKGadwBQYL8xHJmTgV/1WOh5P4flRLA/EWeCkJFKm9E6eoPqJNjADwe4Gpaa2KnO2VrMMTHxKU8x3smR7KFjIgZz2RA452llA4D+WY9gv/oAiVjHHbBv9mR2JeeMcyTCRPFgvRL89D1X7srQjscwyrqHQvJmAQbzhXMwnVlVadYOR76253rF4z+KLaQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CvNCjCE8Qe3sHZ7fOyNZiw8LxNsWheBW8F9Ejn1SBQ=;
 b=NWIrDcVltzgYbKgHbJxmsxoq1mSeslhf6XQZ+yuQbthI3LEMUNdYmFNyaRZTdfQMWavpGuPkiD0i+H5GojCoOpZl3OmLKnXX4Iwy9Sg3CmF+wp2OhgzxkZL5d7RUBuQ9LWkWsDd4JZK+ftgohyT26t5hriUYGNATkVJqyXJzQcw+FffIRLG4sQ4COHZFXRj72s6MIJFZBBf0dMoTO9OdNmPyft8RX9U9Utte5YYINrg0WB8ilOtNTT90Ejp8VyX8xglxbQybFIax+L5RPaISP7AAahUJmMFiOe3Km6DBjCtnp7rGACgKopt1jqeHBv6raV/hnp7bG2/lNF4k+Kpo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CvNCjCE8Qe3sHZ7fOyNZiw8LxNsWheBW8F9Ejn1SBQ=;
 b=Y696nFBEkZ9uQIYW0kbgrFpIb0RlysvNJjIH3LiYL69COyZEgr/bAS2g9SeC3b8dnSxhwOVZrABjNOLBcRXm58IfzN5Eas7pLq6VjMm0Yo51PFnAO8bPkFur9YLC4NOkteOJf03bERgs+8yqZFC1qwsaYPr87v0s4RScvTDH3oA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 07:16:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 07:16:38 +0000
Message-ID: <ba09aade-751a-47fc-954e-7fcea6fd18de@amd.com>
Date: Thu, 25 Apr 2024 09:16:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu: fix the warning about the expression
 (int)size - len
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com
References: <20240425071137.906773-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240425071137.906773-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0132.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d71aaee-be8f-4fa2-4497-08dc64f7a621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STZjdE56dUdydDArM2o3SFVVY0drUCtScWF2L1Nia2dpcGs0T09XNmxFNkVx?=
 =?utf-8?B?TUZoVitXblN5UDBxdWI4OHZ6SDc2T2dXRmRqVXZ2amMxRVJ0N0gwakpBeHFa?=
 =?utf-8?B?dkxZWXkrUVlvNTN2Q1MrQXFYL0FJeERwbEtIak1QZmpKMHM2cmQ4L3hlMEla?=
 =?utf-8?B?UXVXZnluNGt6cWRwUDI2WituTEVNcW90KzA4OWRXYnNHb0h0VDJDNmFVenc3?=
 =?utf-8?B?Q1BmL28yc3J3bW1WcGVXUGlxemhvRTh3Z0RDM200SlZwYXI2NUt3b2V0bVgz?=
 =?utf-8?B?TG5wNmRVOGVQbjdyMktkVGRmVm41Ty9VaUdqc1FCem4xdUJvRE1qQ1JKcmpG?=
 =?utf-8?B?MTNUUDlZd0orclZQUERibnMxVmtFaGpXcnhsMlBvQ01VNS9HZ1FyMUl0REJh?=
 =?utf-8?B?dUFDUHpER3ZTdWgzMlQ5ZjN2a1pGSkw4aEVLMWxYekRqM3NpRDNiR21sWFFI?=
 =?utf-8?B?c2FtMmdxazRsamhBa2tKYVhXTFEwbUg0RndCajA3M1ArMlQ1WHNZUjd1azB6?=
 =?utf-8?B?aEUrYzJqVEJ5UHkxSDdTeWNwNWNJVnNWc25oVWlISzVlMnpjdkcrYThBdlNU?=
 =?utf-8?B?Q3lMclVXY3N0cElUS3kvKzlGTDVBMU5IVjQ3dTl4T3hCZ2FTVytJRDFjaFdF?=
 =?utf-8?B?MnNxbllpZkJwSGlUdDU5SS9XRlpKZ3RlaHBPanJaTzN5V1RWeTQ3czRoWm5L?=
 =?utf-8?B?Vmt2VjhZRmN2M09CdUNHWXlrTC9wWmFFREErUmNSSkhvNWtBdEd5WW00dllP?=
 =?utf-8?B?aTBldXBpT1VNMUxlN2htSHFCcGF0VG5rdEdSTCtBWmtWdlk4a1JhVWo4b0Nm?=
 =?utf-8?B?UjFCM04raWZ6Vlh4OHJDS2ZBRGdPcUxTVXpkVHd3RGZscFJuN2hXc0Q2elp5?=
 =?utf-8?B?WGFVb0R2QUo4WUQ5UDFwOTBtRmFCTTNrL0JFakRGcjN5NmlCTTk5Z0dETFhh?=
 =?utf-8?B?ajlNNG1nWm5LMjZaRmoyejVvc0RYS3VoUFAyNG5NZ1R4RGxweEdLNFFYVW00?=
 =?utf-8?B?VDQxMnJZZUYrSFZVVklNUzFRbTZBdmJNdHZGV1ZieW1SMkRFTHNTNXBkMUtT?=
 =?utf-8?B?VGtERHZnUVdmZjVKK2plWDhKRzdjenA2OC9CK1ZEVXAxaUxTV1hPMkZzV05z?=
 =?utf-8?B?OVA3ZUdiTUVLek5EM1ZNRHhVUnpTU3RCMmtPL3l6L3BuK2RzRmRiQW1hb08y?=
 =?utf-8?B?MWJKbUI2UjlneWtPZFlSNHF2QXloaXZtWkQzZUhLZnBRak1PenFaZnRVMzRG?=
 =?utf-8?B?V1lUMjZiL1NmYzU5TFE1UTAwZ1NacGJDcG44ZFVDRkVUSGJVMDQ3VmNXZ1ZB?=
 =?utf-8?B?UFMwUHdwMVgrcEpNd2tiMFhNWWVpa0pLdUN6T2hLdmRDYklHa2JWTFhYM0lk?=
 =?utf-8?B?STdtd0FxOUVZbDk1WjFWRjVKWVN4eVFKNWZmSDdFekd6dTd1blJBdTNNQ21z?=
 =?utf-8?B?OUswRUVsMmZ2NVU1ZWhKVXZHZWU5dkxGd2xtQ2xHTTBBMTJwbUJvMnh1QVhG?=
 =?utf-8?B?Yi9EbFl6Uk10RFd1TVZnZldudHA3cHZ3dUZLSExMUnVMRHVURk5YSWFaejRL?=
 =?utf-8?B?NjBnVVlhT0E1Z0h5SGdsQjFFYmZqN01TSTRVUUZObmQ2Uk03aS9OTDdwRDJ6?=
 =?utf-8?B?cDVYczN1azVocjFhNXVkdFNGNzlrbDNYZ01nRUVMbmdvZmkxQmRUUFdBY3Ni?=
 =?utf-8?B?RnBaVmNadFVSWDVFbExNdkdmRndpWXZOcllmNG83djRLOVV3STZDRE93PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU1yRVRkUVRpemFuR2JhMCtyY0Y5eTNIendXb041dFFybFZlZzdQVDQrNDRI?=
 =?utf-8?B?WXI2RmNFcVdmN1FjWXJoWG5qOTdrMjFGcjVxaTVseXlXRmxMUjdhbm42Z1Nn?=
 =?utf-8?B?ZiszYlJDdVVQc0FVeWtEZjV6dFYxS3lwWkZNbUorSmxwL3h2WDhxUDhEdTN1?=
 =?utf-8?B?Y2o5a3g2N3IrS2J3TDYwbnFSS2Q0dHIrWHVvNGE1MFhta0tWTythSmNEK0po?=
 =?utf-8?B?L2dPUXNoZnA1b0R3em5XZjJOSmpDVHA4ZjhuSUY0WmFVUEh1T0F4N1VzTFdp?=
 =?utf-8?B?NVk5bXNLYkNPQUQyVnZNTFBkRGxocWVURXdWdDJJdFF2bGdiZk5JQ1VxbWVD?=
 =?utf-8?B?TjBFdUJvWFVGNFRyMjV1aFg4ZTlQT3ZabFlUNnZuKzZpejVZL0xQZUY5UUxt?=
 =?utf-8?B?N2oySHlsSDhCcUN4T3NEUEJlQzFYSHBqNmN0dWhOK00zdmZGWlRHREhpZ1dT?=
 =?utf-8?B?QnJrRHZ5SnBRRlpPVEo1ZFpNYzhDanZmb1hZQm5DNTRSTDVqdDJ3eVhHUWdu?=
 =?utf-8?B?c0ZWSVpVVkg2cDZxNFg4VG5YbVlVS3BnNXhyeWZtVFNzQkVQdDZ5RGdRMFdP?=
 =?utf-8?B?UUxFTzVxcGVUV3lLQ3NqTE1SZWxQS0NZR0VPMCtpTFYzT3VwZ0NML0VoV3lC?=
 =?utf-8?B?OGJUSmxYVXkwMzZMaldOT1BGeE82QXFIQjZQUllBTDF1QXFqc0VUSERGQlk0?=
 =?utf-8?B?M3FDY0NFcm1FUGM2NUxZZ0NkYlBFeG9XWmNwS29WT1FQSVBhSnFYbEg0emVI?=
 =?utf-8?B?Ty9pQW01RXlaN2NVUTVvQWdkSXJ4MEFhclNCS0NqQWI2MWRIZENXeWpkT0JD?=
 =?utf-8?B?WkprZ2J5Z2NZaTQ2azJRZEVXM084OUdLZTY1SVkxTk44cWV6YkovZC9rZ1Br?=
 =?utf-8?B?WDQzV3Y1MWhvM0RxQjZ2NmdJQUJROTBiUG5kd2treHh5WG11SXhKVDFPZDZJ?=
 =?utf-8?B?NFhEWTJCbHpjNlBtUTljSXNVRW05T1ZNS3drT3FScHVrQUhKMnZlNDNEeGUx?=
 =?utf-8?B?TDVLb1VxT3FxTGRvWVdEdm1ERjV0N00vME1xZVRTd1duUG40RkVicjhpWUhZ?=
 =?utf-8?B?SUhxWEtVWngrMnZOT0I5bk1xWHExWVJuN0JLeUk5Uy9Ea2JRd2dJYWVPenN0?=
 =?utf-8?B?eUVWYzJ2YTBiOU5QUUFLWkgyd3RKaGJiZ0UyQ2VQeDIxREd1U01zYlE0bFFP?=
 =?utf-8?B?bXIxR2N4dGJuYmpGSkd6c3hSRjBXWjhCbVhhbzVzVHUvUkNzOWcrTGp5Qk9N?=
 =?utf-8?B?cGF0ekFjUUdVRWRFSXFlSnhCQU16OTU2OVliM3JWR1ZZUWdiOTlMYnFDSEJm?=
 =?utf-8?B?ZXNVQnVXWDFtNm50ZjhDczNlcjkvaFJhUCt3S0swOTZ6RnhSa2M2TUdrVW4z?=
 =?utf-8?B?VzJTZzZrZCtQNlNFeW5LUUUySEg1RVJKODQ0cFVrdG5IMHRjZDVRVlA5M3U4?=
 =?utf-8?B?czNiOW9Hc0ZDWEJQdlFDdkVtb0dpdkR2WVUydmlIQUU1Z0w5MzM2aW1pOGor?=
 =?utf-8?B?Ymo4aWgySTYyOFJBa0NNUVYweVA3MGdJWHg4VXVuZWdpSWNsSkEvdEx1SVlS?=
 =?utf-8?B?c09TTVBNcTNHbDlsc3ZnZHNKeUpnYmZINTJDRWoyYzd2ZHZxUzBLYUQwUFdi?=
 =?utf-8?B?b1BmZC9sN1JLYlBjTEptRE1hMmsrRnRja2tMaTdoTlpFSW8yZktkU01jUEU2?=
 =?utf-8?B?L0pNSkxUeVZsMnhoV2VlMlhLS21KbHgvYUlWWnQ2MW93QkxtazFqMVJtM1N0?=
 =?utf-8?B?aytmMVFsSCt1bE9oeEI1WGYrbVZwTFJDdVRFS3BWMHN2dXgrb29qcXN1WE5q?=
 =?utf-8?B?U2w4MmNHZDhmTUhnWExnTG80dFZ4Y0RBb3lRNi9idFM4Sk1iblJwMm0za1N1?=
 =?utf-8?B?OGR5YVVMMzdDeExKbVI2ZlZ5YUlmeGVyWHlnOXByYlF2em5yaytpN2tMbEZC?=
 =?utf-8?B?L0dsa21BdHpqRngyMXN4RzNQOEh0ZE5sV2pCcWs4VFFyVlhRVE94QWdFWjBR?=
 =?utf-8?B?Mk9FQWhId3l1VUJWNmN6UmRnV1pUWFhNMkVkMk5jSGQzVTd4aENJRktqRDBM?=
 =?utf-8?B?dDlQQjlhRTZjUitTaCs1eWt2U2kvMDkrYWdtM1RBZUtjcjlBSnRNcUhzN0VD?=
 =?utf-8?Q?NYRFVeY0q45sMUGCewmUosdPc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d71aaee-be8f-4fa2-4497-08dc64f7a621
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 07:16:38.8876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GikcHwZ11htMSy35Tg1NQDgrdTqSbveYp+wZenp7cBjWsf4y6OxBg45ARopkA0W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711
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

Am 25.04.24 um 09:11 schrieb Jesse Zhang:
> Converting size from size_t to int may overflow.
> v2: keep reverse xmas tree order (Christian)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index f5d0fa207a88..eed60d4b3390 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2065,12 +2065,13 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>   	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
>   	char reg_offset[11];
>   	uint32_t *new = NULL, *tmp = NULL;
> +	unsigned int len = 0;
>   	int ret, i = 0, len = 0;

Well now you have len defined twice :)

Christian.

>   
>   	do {
>   		memset(reg_offset, 0, 11);
>   		if (copy_from_user(reg_offset, buf + len,
> -					min(10, ((int)size-len)))) {
> +					min(10, (size-len)))) {
>   			ret = -EFAULT;
>   			goto error_free;
>   		}

