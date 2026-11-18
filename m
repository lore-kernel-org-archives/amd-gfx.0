Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF1606A330
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BWcdGB0U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D7810EC58;
	Wed, 18 Nov 2026 17:44:13 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F8610FEDF
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 17:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UziwFC/Ti+04ogdvyrPeWIKoDxqO+hXy3IeVZrUnLqdBXGSWFGvPsLAD/AkB+PCTfnYM7QkGwKFZIUoCgiv0sOSf+wZq2XKAyvlHtGDlEs22AKCca4I2pkh+VFDfgFhGP5PalQ3fzh4Vtei2SIf/6xmxRMlwmaAuIzR3cmKHYzYndC3Qq9nDKcBetoK9xpmP+qgkhFNjIuL+IjHLDeajBzlEV9ZzDJKJqK9XC2boo9TYI+Ak4zrNIGEs57t/IedNafWXxydu9x+M7KQCscvCFlCSMwQ6XfEBzrURA6dOv6SvMRPpA6UCXXVZhTez3DZWlZEpVfdPHKzIKfnNKWjB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q16XV6HVvw0fehKFBOidH3eA3QWJuGf2qkmua/ltRZg=;
 b=pbJ3c7vRVAD5F9hmCPfXtkaPUhvZ7t1Xb7efq6LFOXriY2ZLe7iAnG7GxpuMtqaB/uaPFpupcJFiHMAxc+Fr81/F1kD7frZpJE7B7QQCJw16w9jKlnx31V16ekxwSk4QSnjLCEAbBCXAvVKuq/CFIRktSoX2yQGEpr43FuaWjQcaszn42sAmK4pMVSYWrCxESN9+mqjmK8wxWL8ILLFXBH7BTKBYLz2OPUt9lYvKkwL6Bk1+A3vhgfrqPc6FamfKSr0iqHctl3c0Xt5PtBASoJXDuXubqa17ADpDds68hOoM5CB5dO3ETAVZyuNyDLgNPOX4Ej5F2z0DWmYWNgxwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q16XV6HVvw0fehKFBOidH3eA3QWJuGf2qkmua/ltRZg=;
 b=BWcdGB0Uc/cu8y+G7/nwSvrGTdwmN+ocDHa5XAQZTny76Xr34hgS54KwmJIP4cymC5DEI3GjCQWrwOgi46cAMwdIRXZxjJ+Ok/+VhaqB+nzHqAD+oczA9c1xVkKSAfZVUaxTVug+HDCrd6SyHhhzyShVteobqJGT8ZKfT/cSx80=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:44:01 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:44:01 +0000
Content-Type: multipart/alternative;
 boundary="------------Q0QwyZo30kYvgZPQOvcbTrou"
Message-ID: <8dc2af18-5261-4949-9d85-cc869c13fc48@amd.com>
Date: Wed, 18 Nov 2026 12:43:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: Fix a race issue at
 svm_migrate_copy_to_ram() error path
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261118151045.134908-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261118151045.134908-1-xiaogang.chen@amd.com>
X-ClientProxiedBy: YQBPR01CA0165.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::22) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c404814-1e92-428f-ff3c-08df459b87d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|8096899003|56012099006|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: /kXkJSSTQV4xT7Sdc+0emd2FVrB+BGkyM3FNhE96eQaqY1jCwnzmYMeygMh0yUvc4T+xv2SA+7VfnxdLrDTTs3BRdAUcUzW0DkrNqZMuTzP30O5976zCh3DDAJfhdKxkXtpzLJpKmNsPSD3S5ZokBy4bUD1q4mqTtoZXxJaviokOLdPIOOKbGElmnLDL/i6+I6BQLgh4BnE2VJDnJU6jDjR5QiwScYdUQDgMMy1v5v2gLb0XjK5JpTzM2v+13hodTpbewDh1HV1IBkeih2vZIIoAwAiDYOk4C9kY1THK0W3P8qV2HxrFl/JsHvYD2tcWdm+olHr7LqDcH0SR/Znjjd6xXan9TdPGoLcL+4e83M7zbdUcwTu/XQ+mfcePF9jYVpExjXlzXpDMW0tN4FtojJGBQBiGxyyQ80j6y620DzNDVpCRyCWKH6hL2xlT1MT8PNXgNi7944vRWPwj6TfrPk+4JtqzdM9GOfhi6Xh15C3+ZKddYi2hIpwsVVOa3wxMqFi7BUlkMAd47KR7Svii0LjH/ypm4bIfGvxK0rofbf239yxgSEQCziAneAgDf03scN+uNybCrKaFoyZj3qWY55/cmsONw/BKWyYIPPHvuy16/9ASwwkypZlERTEZo5Ca3btrI/tTqBHyeZ1Fz0KyKKCsULuu5f5FNEB/jf7XRB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(8096899003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXJLVW1wT0NiQVVPS2p6ZDBqcDVxTFUycGZISGZQK2xkaW9kTFN0THJNMWJ0?=
 =?utf-8?B?MVVwdzN5SC9nSTdpeE04SVphbmYzUUZra1ZyVHYraU5tbmRGZStSOXV6UUln?=
 =?utf-8?B?cWU5bkM1YW1TeitIcW5qdUxYMWx6aUNBbVMrTmxUVlJONDhiUm90QVcybkdD?=
 =?utf-8?B?dUhSZHJsbVVMa2U3bWsvblRDcFR1V2E3My9xRktEN08yYVE0bm9DSUpXZXJq?=
 =?utf-8?B?OWJvbHRTV1doN3J0L0dXVUtBeXJCd0dpa2R1RU1VSitLUVZlcnE5Z2V1MHNz?=
 =?utf-8?B?clRDR3lkbE5vU3ArSTVhbjVJK2Fhc0VONVRnb0VFZjNGRmJKaTZ6aDNtRUpE?=
 =?utf-8?B?ZFBPWWpzbW0vMXJrN0l3SlZnRlNGU2k4UDd4NHo5eU5lblVONDFIenF1MXVV?=
 =?utf-8?B?aGJHaTR6MHcrTUNUd1pFU0VCN0hUTk9tcUI2WmtFYzdKT0t2dWdMdGVKb0U4?=
 =?utf-8?B?YnJhdk5NS2Vic3N6L1pnU1hLUkR0eUMzOHM1TkhjaTVYWmV0TGVjYmtTWDNi?=
 =?utf-8?B?ZlVWczVndS9LR1ZVdGxIOVh3dlJ5OWFOVzlzTzhaV0ZQUlJNMm1DN3luN2hJ?=
 =?utf-8?B?OVF1T0wxUHhQYklJR0R0aE1KdkRRZm5SS0czcHNHdHBiT1duUXJQbTc2alRN?=
 =?utf-8?B?UE5YWlMvSlVWcVI4cHQrZmQxTENwa0F5RXpJdWRGckFTek1jYktldlBpaWFa?=
 =?utf-8?B?TnFZQ3hSdlBPQUhISi9uSC9wL3hMZk5QVE9KRG56aUhVY3REZzlPYzhJdzFJ?=
 =?utf-8?B?SUtJYVlheit5RmZreTcrSU96eXRnbWxsaTcra290UzYzVDNvNnhWRkNESFJC?=
 =?utf-8?B?S2Y5dnhGMkZ6ODFCVnZkTDJnUmdQMEtxZm1MeGp1NUJhKzhYNEVZN0laMW5Z?=
 =?utf-8?B?ZmZrKzVFTWJSYlNrSjdxdnAvbHM0Q2o5NlJHSGZoUVp5SGIyQmg4YVU3bCsy?=
 =?utf-8?B?RWtUMHpXUERTYndrRXNqdnNSUmM5V2dRcG1RVVpGNFdEYm9sMnRNRlNnWTZz?=
 =?utf-8?B?NnRNK0IvQzJBelNSRHI3aVUrSDVaL0d5U1dpdXVLRDVQVS9lZjhrVE1lb1lk?=
 =?utf-8?B?UlhFNWQ5RElrN1lqRklnaHFXdkNzUUJ5UVU3Ymw1anpNTWQ1UHdMNjZrUTR4?=
 =?utf-8?B?S3J2SE1hRU9Qbys3TXVKV3FORDI3YVhLNHljZjJMME12ZGdFWmNaby96Ukdp?=
 =?utf-8?B?dVV3bTVkNGcxWEVEaTJzWFBOWlR5YkJndW1BT1BHTzdPK0wrMmVrWVZZTi94?=
 =?utf-8?B?QkFPTFcrM0ViVlZxcFV3UldLUWpmRGpHR2dYNUtmZ3ExR0FESis2RXZEVkVU?=
 =?utf-8?B?RHRxTGozS0V0MThZUXBMVDhjeFVkbzRlU3gwNC9DK29VMXFGSWduSmFGK3Zr?=
 =?utf-8?B?SE9CWm10V2M0cFYwOEYySUJPK2hNZWYydFNLVEtjOTl1MHYrVjFWUlMyekFv?=
 =?utf-8?B?VkdCdlNjbnVqa2hHM3JEd1FjWG4rN091VkpqTDN1cWJBNHJTQnVCQlBMMkI1?=
 =?utf-8?B?VWNwU1pNbGdXeFhQZ01RYUxseWNaWXJSQlhRSGd2amh0Qk1XcjBaOTREQS9k?=
 =?utf-8?B?S0hhcXcrWnFvdkg3SjU5ZmhUblhoSEM0VVdTSHRlazJmc0VYL2k1Q05mZHl3?=
 =?utf-8?B?bWdzZTE5dkVCMzNVaFlhaVV0WGhWVUUxK2M3Q0ZITWpzQmErSDFaVisyaDlN?=
 =?utf-8?B?UDBCeHRlRERrZ05wck9McXNjb3dyRDVsaUMwSkhxSUU1NXhkQUZLTkRCdkpo?=
 =?utf-8?B?dFVORzluTnd5WGRyRXZpcWMxVGRwWUtUTW9JL2FSbEthc2hzU0tSWW9xY3Fy?=
 =?utf-8?B?azlVREF3Z0FKMUhTRERuYkk1VnZqWklZRmpPck9RbXlodHFoaGJ2OVFDNVls?=
 =?utf-8?B?Q3RmdlZ1YTRnOWRBdFhLOUY5TkJyRys2MjBWdDNXZjNUakllaEFUbVIxU1lz?=
 =?utf-8?B?MC84ZW5RUmo0bVVVemE4S3RRcjB6VngzVjJNSi8zeE1lc2FxOXgwM1N6T3Mr?=
 =?utf-8?B?eGd4RXBXZTRyNHp2bU5ETFVGSHhNSUhqSHAxM0hqNEpWb1RGbzV6VW0zaHhN?=
 =?utf-8?B?UjFEZUNOczF6Q0k0WDlwZ296VUdxQTdhZG1mRm9KSGhjQXJmMVlxSzlUT0g1?=
 =?utf-8?B?K2I0RTFSSlVnREZta2ZCdXdya1AvNVdIY1F6c1FVcXZtWVFCbU1FMHlSS2du?=
 =?utf-8?B?RFRQc0o5cHBGUVpKQ3orUXJDT28xcG1VNngrYWZuaEhZUnhiS0ZEZitxY1RP?=
 =?utf-8?B?TjRwUUt2Q1lkVG5pZmFaQThEMVJHVXh1M1dzRW5penpVNWsxTmhvRFp3aVdk?=
 =?utf-8?Q?YCS0BI/muYGbZotdew?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c404814-1e92-428f-ff3c-08df459b87d4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:44:01.2748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpuob549fADkRABVLNGL+dkiEveSdDA9f/q3+musuQSULgXEKhZJXS6t56wZXYaF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792
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

--------------Q0QwyZo30kYvgZPQOvcbTrou
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-11-18 10:10, Xiaogang.Chen wrote:
> From: Xiaogang Chen<xiaogang.chen@amd.com>
>
> The destination pages were freed while SDMA copies queued earlier
> could still be writing into them, and while they were still DMA
> mapped. The mappings were only removed later by the caller's
> svm_range_dma_unmap_dev().
>
> With swiotlb, the BIDIRECTIONAL unmap copies the bounce buffer back into
> a page that may already be reused.
>
> With an IOMM, the GPU still has a valid bus address that points at a page
> now maybe owned by another user. Any SDMA write still in flight, corrupts
> that page.
>
> So, wait on the fence first, then dma unmap before release buffer.
>
> svm_range_dma_unmap_dev() sets each entry to 0 after unmapping it,
> so the caller's later svm_range_dma_unmap_dev call skips them.
>
> Not drop the fence there. *mfence still belongs to the caller. Later
> svm_migrate_copy_done() puts it and second wait there returns immediately.
>
> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 8b96e1fe741a..78a2aab81c17 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -716,6 +716,18 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			put_page(dpage);
>   		}
>   
> +		/*
> +		 * Copies queued before the failure may still be writing into
> +		 * the destination pages. Wait for the last SDMA fence (copies
> +		 * on the entity complete in order), then remove the device DMA
> +		 * mappings, before the pages go back to the allocator. The
> +		 * caller's svm_migrate_copy_done() still puts the fence, and
> +		 * its svm_range_dma_unmap_dev() skips the entries zeroed here.
> +		 */
> +		if (*mfence)
> +			dma_fence_wait(*mfence, false);
wait fence is good, but I perfer to add dma_fence_put() here to free the 
fence, then in caller, only wait for fence if copy return 0.

     if (!r)
         svm_migrate_copy_done(adev, mfence);

> +		svm_range_dma_unmap_dev(dev, dst, 0, npages);
> +
This is not needed, as the below loop unmap dma address and free sys pages.

And add this in caller

     if (!r)
         svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);

Regards,
Philip

>   		/* release previous allocated sys pages and unmap dma address */
>   		while (i--) {
>   

--------------Q0QwyZo30kYvgZPQOvcbTrou
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-18 10:10, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261118151045.134908-1-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

The destination pages were freed while SDMA copies queued earlier
could still be writing into them, and while they were still DMA
mapped. The mappings were only removed later by the caller's
svm_range_dma_unmap_dev().

With swiotlb, the BIDIRECTIONAL unmap copies the bounce buffer back into
a page that may already be reused.

With an IOMM, the GPU still has a valid bus address that points at a page
now maybe owned by another user. Any SDMA write still in flight, corrupts
that page.

So, wait on the fence first, then dma unmap before release buffer.

svm_range_dma_unmap_dev() sets each entry to 0 after unmapping it,
so the caller's later svm_range_dma_unmap_dev call skips them.

Not drop the fence there. *mfence still belongs to the caller. Later
svm_migrate_copy_done() puts it and second wait there returns immediately.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8b96e1fe741a..78a2aab81c17 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -716,6 +716,18 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			put_page(dpage);
 		}
 
+		/*
+		 * Copies queued before the failure may still be writing into
+		 * the destination pages. Wait for the last SDMA fence (copies
+		 * on the entity complete in order), then remove the device DMA
+		 * mappings, before the pages go back to the allocator. The
+		 * caller's svm_migrate_copy_done() still puts the fence, and
+		 * its svm_range_dma_unmap_dev() skips the entries zeroed here.
+		 */
+		if (*mfence)
+			dma_fence_wait(*mfence, false);</pre>
    </blockquote>
    wait fence is good, but I perfer to add&nbsp;<span data-teams="true">dma_fence_put()
      here to free the fence, then in caller, only wait for fence if
      copy return 0.<br>
      <br>
      &nbsp; &nbsp; if (!r)<br>
      &nbsp; &nbsp; &nbsp; &nbsp; svm_migrate_copy_done(adev, mfence);<br>
      <br>
    </span>
    <blockquote type="cite" cite="mid:20261118151045.134908-1-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		svm_range_dma_unmap_dev(dev, dst, 0, npages);
+</pre>
    </blockquote>
    This is not needed, as the below loop unmap dma address and free sys
    pages.<br>
    <br>
    And add this in caller<br>
    <br>
    &nbsp; &nbsp; if (!r)<br>
    &nbsp; &nbsp; &nbsp; &nbsp; svm_range_dma_unmap_dev(adev-&gt;dev, scratch, 0, npages);<br>
    <br>
    Regards,<br>
    Philip<br>
    <br>
    <blockquote type="cite" cite="mid:20261118151045.134908-1-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
 		/* release previous allocated sys pages and unmap dma address */
 		while (i--) {
 
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------Q0QwyZo30kYvgZPQOvcbTrou--
