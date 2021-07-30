Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA1AC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 05:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13EAD6054E
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 05:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 13EAD6054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C80B189CDF;
	Fri, 30 Jul 2021 05:01:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E397E6F3C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 05:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONJbp7a5s50LZ5YQEsnfptKLr8bTt32bG92WFQZi/ECTGfaJRws0w2RzhXjm9fAY7ExSTXezCc3mnrkiCRY+Zo9704zumeTcuuitvklZI5QQsLx/wPu26vYjWlxmYkwGLPismkXKYpGy/errqLYN3StSfj3KMwp1d3gQXzYArC8xWBKk6Z4kugAuiBpCerqZoFLhyZQQZv5vI1P2g2Q05ySPO4a1S8ILSeiMuPDAmbD/I9xXnhk/gXHfHDqS0IUrNeub7RrUy/mL9lZJRuzpmb0qKEsFSMfLfKVSoF/ex5ulurNKqJQoXhs9nSgOqNyopd0EgcqEvUxO6OBj297L9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymj6DOHiyuzLGX0mm7iIn1EWFI5PEee5SMTqP683G3s=;
 b=FAy/W+oOYlgdu6+Ibv9Wzkeo4hC6MIZXjbH2Yk+CG1QuXw08H9a1/TYnJAeFRMng3eXCMNmhk5yUFHlOCPLf9EnLJdjUXPw48QyHeOXI7e4L7uz7rfJn/qarZGB3Tx7BcjyX3w9tfhs7u3zEBao1MkAUG7/cS4ExThbQlqUpRE4SAG3SvjQf077mKmrl/1uapS4Mz3UdLl9QM7+rRUlqyvDsrJkxLa068iFoasenm4qOODSX+GcV6CG3RwkMrTWSAdzkP8CIWBm7DfHbb8bKQLI96cFRfaiz+RyXX+leH+FRZmBn+Tnfi+cvikfhp+pJKniQk0svQUiCQDDfm3+2pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymj6DOHiyuzLGX0mm7iIn1EWFI5PEee5SMTqP683G3s=;
 b=YQSJ/ZD1b8Wk0opKu4ufjOL9uisNLv4cZnF7n50HTJmn33mwxDS1hngP4AQd0vN5yuiJ61hX40AXGX7Ay6cMocHp6DIxSrWKaUKvRFQ4vvnVokpf7UJbNZLmxSAY7Ugp6MYLh8P5Oxx5FQosPnOjm5SimI73xGkgdtkEgDiUDHQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5116.namprd12.prod.outlook.com (2603:10b6:408:119::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 30 Jul
 2021 05:01:20 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::e1cb:9940:1924:50f2]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::e1cb:9940:1924:50f2%6]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 05:01:20 +0000
Subject: Re: [PATCH 1/3] drm/amd/pm: Don't output SMU version for smu13 every
 time
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210730024050.248-1-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <5648c894-5caa-ccb0-fec4-6b0d7acb74b4@amd.com>
Date: Fri, 30 Jul 2021 10:31:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210730024050.248-1-mario.limonciello@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BM1PR0101CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::30) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 BM1PR0101CA0068.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Fri, 30 Jul 2021 05:01:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d248ff0-d50f-4b5d-d9b3-08d953171245
X-MS-TrafficTypeDiagnostic: BN9PR12MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51167797CCDF6B91F26697AE97EC9@BN9PR12MB5116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mu1H4UfUJANHEk7Jhfbh6Bf99RKgBqiRiyciigq/4UbqzBkwYGFMJhytDLUJcz+uu4S94y3eUfEImH7LDagqvd25+Ne/65QwW2LZ3j3+4IfNNC0Y/KRIsw5nJ/NNInR7QV/jFzNA3HWVtYPVST28zLX5pRLNQIdEeBEGBrAGJxtlOI0KJ+1P4TRI9rkUHWw7AUWLJesSq435pj7SxZR9glK3BYBE+AT2IwINiBdzL/Ns+coCgG9ScLOpxKsja5gZfe5AdjT/Q/dLdshB7L9IuTQ6aYkG/WXASHOpfSQswVT5Vc6Y2XueT8X+td7MV+s9AMswnFGX7P7kO2MprYVxqxA4ltA6+iklDxRu6M6JZoSaARLZGnrHejrlgI3aGVrIZCl4F38Eecq50v32cyAwH7+jNRst0MJzWRXeAzzd5H6cc9vp04gzo7ZJvJuF+Zz9ARRFf8FNJTSzQ4x4Bc4pH+OiDKc+MkAJaz9jyQeLNsDfaViP8yhLSye8jL+fiUUBJveOx4pGpyIgpy2XvjfFXiQKPSQcbQ2wl6V2a4lE5MDvxBH/9spp3Wkhd5lpXq/6P6h9MImFWv8vb7Ya2H652O5/cN8Oq3M0rVpgn6AOlv2uC7ppr/M7GoHPOFP0QG1f97/z0J7DKDggwhOxhhSn8mTvKVbAN9HyLCJJT76LuYNRuZze9YgL5Et7fdlrmsitu4v+/7Oas4eQ+pDpRPFsqezVtlIJOjRHLHs7rNS7kdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(31696002)(956004)(8676002)(66476007)(478600001)(2616005)(36756003)(53546011)(26005)(83380400001)(6666004)(31686004)(86362001)(66556008)(186003)(66946007)(8936002)(6486002)(5660300002)(16576012)(38100700002)(2906002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkpheWhJbENUQU1EWllxcWlyUjFIS2lVbHJnQlJUZi8wN0kxTkRQbE0rMTJx?=
 =?utf-8?B?ZElVRTZ3VjlCNEZQVVhrQ3o0V1JBRGZid3BSNnNOcFZucTVLNTU0MWtqa2tB?=
 =?utf-8?B?Vk9jWnRZcDNoUEt4Y2RKajVISW5NWHJEOVhWYkFDdnBMTDd4bGxKczNhMmJu?=
 =?utf-8?B?WU5oWU80VEgyVWxPNXRXcTFrYjRIcm1WaWRZUkxwWVQ5NzZReHphalh2VWR6?=
 =?utf-8?B?SllvYUhpWVJ4WjhSeGdjejJtdGJ0TzJpSEFUbVN6RnVXNjlIWVQrRFc0aysr?=
 =?utf-8?B?ZjFCOU5yREdTRjZIRUR6dko5aVh6dktCQnY4UllwMGZmWHNGbWxTS1cxMjRN?=
 =?utf-8?B?cWlseldhZHFGcjNKTWYzYnEwcTFFOThaaWJTekc5OStDdTBzT3ZUWndCWXBh?=
 =?utf-8?B?NTNTZXhXYzZ3czR2SkdmNU54VmppRURrdVkwd0xkSzlLeC9EdEh3RHpsVjNw?=
 =?utf-8?B?YUV1eVNzempuRmNzbGh0RUEyQWJnMzJIdXlxYVRpZmVxUGRXM2JrekNRMnBl?=
 =?utf-8?B?NHJKZXdTb290SFUzR0xoTGwzQXdGYVhtVUFwTTZnS29IV3k0NDczVXZhclgv?=
 =?utf-8?B?WGljWUpIM3NsQkNaSjEvL2Z5YTkvY05NdVBTVDVFTjBTVC9ZUVU4dnBKZ08r?=
 =?utf-8?B?N3JCMUVaTzJHNmN3ZUkvR2tiUndHVjNHcVBBN0Zia0pCN09ScjFKT25senNs?=
 =?utf-8?B?c2NWOUZSRk5ScDFJUlUxaitmZFdoNEI1RzZNRGZSU2VDSlVmaXRqRFpML0Zh?=
 =?utf-8?B?MHFONzdEeVg0TEozby9mODdiZWxuaTVybTNFaDE3anJ0TXJ2RUpkMjcxRGpy?=
 =?utf-8?B?emVJYkR3bkY1RFhqOHpQZ2NsbWZZOURrRWU3VG1GNThhM3RUMDNJQmFhUlRJ?=
 =?utf-8?B?Nm5UMzRWTmdGMnd1R3ZlVmVIem5GMlFXYkM4dDNrdlc1VUVRclIyWE1zVndF?=
 =?utf-8?B?ZFVIbGFSL2Y2bkx0LzM3NHFMSVFSZDJGZW9mYS9tNGNPVTFteFEvWnd5OS9H?=
 =?utf-8?B?QTEyaVFXQ21LRGc4UkZldjhzRTVXVVVCZUVVYjhzdWN1SnNiOGw0c0YxNDN2?=
 =?utf-8?B?b1dxQ1AzM3JmV0tuUWhPejNBeFdZTFhjZC8ySWJ0Q2thOE1iZFJGK2RaOElO?=
 =?utf-8?B?S0s0UThVNUVFY3dBTWVzNHdmSjg5d0lUZXVwTkZCTlkyL25OZVdtYy9hVW55?=
 =?utf-8?B?YmJjZkc3MWdkOGFzdjBvU2l5M0FNeG9GalBGOWwxUXliU3lPRWlaeUtqM3lx?=
 =?utf-8?B?YUtoeUxuMW5XaEFCUyt5ZWd0Mmtrb0VmUFZNd0x4WjNQMkkxSDk1M0tGZ0xU?=
 =?utf-8?B?bDlsa1Y5d3JrclI0L2xZVVVoMUZxbzdtaDN2ZGhyZXl1L2NBQm1WU09qL0FD?=
 =?utf-8?B?SG1pblhjRTQ1UldxaHFMc20zU0tDSlBCU3dpTFlFbnlocUlhc2c0akhnMnlF?=
 =?utf-8?B?dTdjUUxCZDQ3N3NVRk1PNjJ6SCs2TisvSzZqQnBJdDA0bUNoeU5uc2FabHNB?=
 =?utf-8?B?ci9DSkJseStaQ3Z5UjA2ckVkYndLRFZDZUpDcHhiczR1UDcxWlhrZTQ1SWNX?=
 =?utf-8?B?VDkzaGprZGI1UkZJUTdlVmNWaEVla3FXR2gxOGJFYWVqV2hKMFpnd28rMU9x?=
 =?utf-8?B?WGFGNUJLVmxOTHhyZnh4NW95VGY4U20ydGh4Sm90RUR1ZXg0SnBNTEpBUjNC?=
 =?utf-8?B?ZnNPb1pXaXREMUplVUY5bC8vcFlJT0xCUmhrQTNSajBZemFWOWk0V3E4L1hw?=
 =?utf-8?Q?gBF4sQzpWUn1LoviT+YQVeismpFRsGPkLGq/YOc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d248ff0-d50f-4b5d-d9b3-08d953171245
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 05:01:20.8593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIYAb4bWzlmQjurZ7SuUn+p2XfhivQvrJl7FfQi9SbWfUUTqWEi90VWXm9Wg5lbq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5116
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/30/2021 8:10 AM, Mario Limonciello wrote:
> This adjusts SMU13 to match SMU11 and SMU12 behaviors in not showing
> this message all the time.  It will still be accessible via
> /sys/kernel/debug/dri/0/amdgpu_firmware_info
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index a421ba85bd6d..9c99c51740a1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -219,9 +219,6 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
>   		break;
>   	}
>   
> -	dev_info(smu->adev->dev, "smu fw reported version = 0x%08x (%d.%d.%d)\n",
> -			 smu_version, smu_major, smu_minor, smu_debug);
> -

Suggest to keep this at debug level. There are cases like a failed 
driver load (debugfs files are not created) where we need to check this 
information.

Thanks,
Lijo

>   	/*
>   	 * 1. if_version mismatch is not critical as our fw is designed
>   	 * to be backward compatible.
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
