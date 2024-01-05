Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC74C3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 09:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D81EE10E58E;
	Fri,  5 Jan 2024 09:39:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB0810E58E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 09:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htz75rOkBrB/NC9TNcburxgbgSdMQn23MlO5XKuQ9PLqBS52A3ChANuw56+ee7ld1VLdCOjfWLdGyvCglYdO5vlmKReg8sIkxgwcSYsFq1mq16kDqiRjN05E92SznpY+EaNSajwaZi67EERUFLfohArg66EM/uUOnw9nEbcFClRgoB3wvskAkfOVWRjw2Iefuawy2wO+9m6o/10P3F6fyKb90VJutx5UPaiMkjm9BQWIuxqlBNYjzkVv/oTomDlPoloeQJXiqoBkSFJ1Rjc/1vAMfUAShPFaY2Gd1nXbM9oGHJHNmdR/TKAxi2V59GXmOIN3oD5BXL6KzGHnXYpjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/K8dLCZvnRpNZg0629jYOFA6Nphrmo3ZZmqYfmSELDE=;
 b=ApmpsGeU4iXPU3ErH98Od7ehbSl2zhhHvGup+C3HiUEs1RMGAv07iIdvtaJKu5KquBmEd4T5A8SH75UfjuB8Ic3EhRjJ/pYuekLjbtLK8R1Uustk8Xi+rmaMk0EgGSZmZhIa1A4oiLMh8Mm3jq/L8VuBpPtxmBBhKcfBDYTiKrSXD449F9EktrR6K8ERHuZZr57wlJgvT0FzSeMnLnhP473ja41HowIyZ92Pdu90y8MqwrliGnWLOteIg7kKUR7w6ShRLhr5XW4WsarN/pWMFXK0VSbO8kIVCLiFa3bAvH1sO436pQPOdVuE8Y8oKJfNyCuxTZEFxPtWHqgmw46Tjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K8dLCZvnRpNZg0629jYOFA6Nphrmo3ZZmqYfmSELDE=;
 b=xyW8zv62IEgKR0Q04yZILjbl43cmK/GNhi3TajA7UW0ECZqJSyByntJue76qiH5nY1HDfsh21g1WRKudBT1Ktb88sROS2XWK/qsKMOWXPPriznDtCWbMShd6uJi5ghu+tdXyiRpJlGPev7BDNmk81HzfqAEOIUt+bSMtGWtcc1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 09:39:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 09:39:51 +0000
Message-ID: <a1ad78cb-724d-4961-b17b-c7632db54c21@amd.com>
Date: Fri, 5 Jan 2024 10:39:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix with right return code '-EIO' in
 'amdgpu_gmc_vram_checking()'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240105032326.2643607-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240105032326.2643607-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB5488:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d366546-dd79-40aa-02f9-08dc0dd243ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ko17xemb72KWLWKNHnRLi7Lx7bm1VKXXPuXK5c+D/Q85U3IxAlMt/e3VKOZnyOqz8RMyIJPjr+PQnkYXuQWjtsZVZp2V7nqX/8N5aJ3ZTEH7R1vxZ2IjoB68Rmuo770TZSRLMw8VbXNcD9AgM4mAdpfaHnNquTSz7B8Kq1tjwtAY2hwz7TqYYBs5uHiiiAlpQI2BEbvlnwFHNwgMk1nbWW04sQj0c5CPmn6IUvJBocK08g1k5YNJrqWIJ5f5pK1uNpisbjxfv46wY/R8BJmM0SIGbZge75nqPk1cXNXXlAB/hDMa0Mt9y0mFqhKRY6EXZ9jlS8Xbb7cMj66pHYBxZXg4bFpL7ZHeD1hKnXwVb+QdcN4WD5DNO8NY4pKO58XzQB3ySZPigrrbHdUG2r0WYRIZFrsOP6XnS3oAw6f7jpyiajrBC77cuFwhL+zGkWvY6SuYPM5ZU624i45tTvfkYMS47x0Oo3pSwtxm5DeNPSTXHVM8s75Bws/PZOeMh8gCIrjrXOkGytlH+34rH4LlsZqbtYcI2JAJgThlD0kRtqlsjpU6HprFANL9O3NoPfGvGQKlROPBSFa27doXLSDcpWgyse9aCpiQ7cubsNAQVXiOCEuZGuBYoOt8cuc78dJHgDfEpayUbj+oCJ17SqNUmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(2906002)(478600001)(5660300002)(4326008)(41300700001)(316002)(54906003)(36756003)(66556008)(6636002)(66946007)(110136005)(66476007)(6486002)(6506007)(8936002)(8676002)(6512007)(2616005)(86362001)(31696002)(26005)(83380400001)(66574015)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmtMcWNFZWMveU1CbytKMWZaazlIRmRFekRDT2hpNm11RFl0cUJMTHBYaVdD?=
 =?utf-8?B?WmF0MThuTU0rR0VQZ2krbEFqWFVSakI1N1hrWldTcUJRVmVEOTVJU0ZWdFAw?=
 =?utf-8?B?eGU3OVM0Rmh4OTVaNGhqdlpvNW5XdGF4aUR3UkVKbSs4OU5JSS9USmZtaXNV?=
 =?utf-8?B?c090aFVobTBoYkxGdnMvWDMzMnAwRnZ0OWNoOWhZWjVjRDNYcjZ3Vm9JREVY?=
 =?utf-8?B?eWJ5THF3c2ZickJVa2Z4TXJMTmJzTGgzYnB0VE03RXpzU1ZVWTZJOHNOTmtT?=
 =?utf-8?B?R0JNUmVlN29FVGVNdWNaWWJIY285WTk5cEJ2U01IOWVsZDRqNFE1M3hKWGkw?=
 =?utf-8?B?aEdVQUtWTFR1QXVIMzg1L2E3K1dMUmhoZTdiei93R243M2FDWU93bnpIaEx5?=
 =?utf-8?B?VTlJUXdaczVlSEVUVU1zWW5mMVgwck9hbTU2MXZtSTdSVjMvUnpVYUg3RnZN?=
 =?utf-8?B?YWdpS1NnOENia3lyZXFHdjRMbUZIYkN2dGxwUk1kdUxULzVZNG42MkRjZkUw?=
 =?utf-8?B?NEZxMERpUE5hMDBwekVRYWpVYmZnL1JCNUdGdm1NOUpXblNZWlRDK0t0eCsz?=
 =?utf-8?B?WVdhcGduSTlJdWpacTVlTW50R0pqL25wOE5HRmVtNWNIdWIxUE5oeFVsUHc0?=
 =?utf-8?B?dkRhV1FBS1hYZ21oL2hhQktYWnREeWJPT09pVlFKamIvV2lVbTgvMlhNZTVr?=
 =?utf-8?B?MVpGU2V4d1dRSmZNZ0ltVnJNQ1lsYnpHQ0RKNExCckhZbkU1eE5DUUR0WHlz?=
 =?utf-8?B?TDBCQzR0S1JJQUtHQlhiL0tqSVYvMThKdXNBLy9VSHVBM3VLZFdjWk9rbTJu?=
 =?utf-8?B?djhPR2dzMkFRZnpROWFmYVhxTGhYbjRRd1BmSjRLNjl3ZkdJVlRwemVjL3Vz?=
 =?utf-8?B?MjdCeHk1czhFZTZ0cmpqS2IrdmJPUGthdVBWdWg3SnBHL1BuN1JiQlNyaThY?=
 =?utf-8?B?bnMvd1dqR3J6dW05QnY2MGlxMm02bHRNY1J5cTFIaFV5N2VWMkYybUhjQ1JE?=
 =?utf-8?B?LzVhZ1UxUzBMWXl5UlZacEJid3N2YzJ1c0pyNFVQZmQvTVA5VFZFdVVsUzdO?=
 =?utf-8?B?NTVOWENONGhVU2tpQzdkcDN1c2ZYN0RxdGVmeEhVRk5LRXJrMi8ycWdtUThw?=
 =?utf-8?B?Q3hxdmdTdWhTbHkzOW5nd2VHeWdjQXlMT0lDbDVZOEM3RW13TW1WbGR0RHhy?=
 =?utf-8?B?b29jU1h6ak9iUkVwc1YzRmxWUjIvdGs5d1RER2hmL3phOFhaM0s2SnRuTFZz?=
 =?utf-8?B?eW8yVDUzNVpkaWxkK1VUQUt6bEFrNlVnc3cxU0tTLzIrMVFTV28wWE1kZWs4?=
 =?utf-8?B?Z1ZiSElRSDUyQndIUGgzREZwdTVQcUlYcTljRndwUDQ3cmRNczlRMUJlSE82?=
 =?utf-8?B?RFUzdkJEeVNONEZaYnpZaUV4OE9xMDFDcGRwMlNZYlh5VE1Ea0tuZ3RERFQ3?=
 =?utf-8?B?TjJGcnJvT2VmYVhwS2dLa3UvbW5hU0F5K1M2Mm5JeE1PemEzSkxWOXRMbnhu?=
 =?utf-8?B?OUhESXVUcnRiN0Q4YlRFd2xrcUJ4RW9WR0g1R0pvYzV1cHhPck51M1JuVVA2?=
 =?utf-8?B?eUg2TDRpYXBaNGgvYzEwS09kZTc5aGRleFVNUWd5aGFSWCtrY0VrM041WEh6?=
 =?utf-8?B?SG5oR0NteEtqWHdGbUVUL3YvMXFPcjk0Mit0MlEvcVpsT3MyOE01Y3FXSFRw?=
 =?utf-8?B?T09Nc0R2MTFXaG5iNmFxWERFcjY1c3U1SndGTmVrS1JoZUt0V1NTYmFEanFS?=
 =?utf-8?B?b1lhdzMxek5xc1pqSFZ3Vmo2UFMrM2NndkticmxoSzZrU1JDU2FTdGZMTzlB?=
 =?utf-8?B?Q3NKOEt0bnQ0V2daR3A4cG1BNUtkZXJoNFhCeEJUN3JkcUhIWmIyR2xnajR6?=
 =?utf-8?B?em11NW5QbzVoU3l6Zm80b1FrQW9zV2Q3UkpyaWJEdXhoWkVtcUoyOVY0c1g0?=
 =?utf-8?B?WUxhR2g0TytuSU5Ya25HNlJUTGk1WitRRFFQdFR2VnpHdy9Lc25rK21vN3NI?=
 =?utf-8?B?K2l6ZTlraWYrcWtNQ0MyUzZzL1lneG9VQXRlcWRXNWI3YUV3OTNnd2RFVnhj?=
 =?utf-8?B?RjRVOVlLVVhRZllYemU5RSt4MVpzUTFhVjF2SExjYkJScDlEd0tzV1BLM1A0?=
 =?utf-8?Q?Ayua8hBjY5mNx8gJLwsBQzeJa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d366546-dd79-40aa-02f9-08dc0dd243ea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 09:39:51.4659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Je0CCdsxZoXWZAQ6gJRR852v8GTIZE/zsXsqVYBqp7s1XhE5ZnbBYevWbrqB4D+q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5488
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.01.24 um 04:23 schrieb Srinivasan Shanmugam:
> The amdgpu_gmc_vram_checking() function in emulation checks whether
> all of the memory range of shared system memory could be accessed by
> GPU, from this aspect, -EIO is returned for error scenarios.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:919 gmc_v6_0_hw_init() warn: missing error code? 'r'
> drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1103 gmc_v7_0_hw_init() warn: missing error code? 'r'
> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1223 gmc_v8_0_hw_init() warn: missing error code? 'r'
> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:2344 gmc_v9_0_hw_init() warn: missing error code? 'r'
>
> Cc: Xiaojian Du <Xiaojian.Du@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>
> v2:
>   - release temporary buffers, if memcmp() fails (Christian)
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d2f273d77e59..55784a9f26c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1045,21 +1045,28 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
>   	 * seconds, so here, we just pick up three parts for emulation.
>   	 */
>   	ret = memcmp(vram_ptr, cptr, 10);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		ret = -EIO;
> +		goto release_buffer;
> +	}
>   
>   	ret = memcmp(vram_ptr + (size / 2), cptr, 10);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		ret = -EIO;
> +		goto release_buffer;
> +	}
>   
>   	ret = memcmp(vram_ptr + size - 10, cptr, 10);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		ret = -EIO;
> +		goto release_buffer;
> +	}
>   
> +release_buffer:
>   	amdgpu_bo_free_kernel(&vram_bo, &vram_gpu,
>   			&vram_ptr);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static ssize_t current_memory_partition_show(

