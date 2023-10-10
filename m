Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F4ACD68E4
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 03:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D63210E15D;
	Tue, 10 Oct 2023 03:30:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3444210E15D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 03:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAatIVi/jHI/zzzbfKIT/000t70jiSzHLRhm0viQZqTJNrrha6rJbPsRYe+meQzymeAabpvQMJX5n8twHGKT+fIF/FaJq73t5o1K5jxyfeD1KZTL8GeAXNqOTyml1yq9seoeKjR6XG1wR9lPgxjsEdas4bqLVcliJw5koGer1oWUsmPFTWwL+VbmzAj3qcnJKsN+MaFW+581fTZ367t36VXYplrpauGDWQpQ+ZobMXW67f0YmE8EXSHJI/gmIp6xZZco+3nNRO0xmA+BDSXUuGzhRobp1pb9+ykSn+dLH6/iLEAESwEotWvQjlLp0hZzhUsqBlUOJqZsQNr0gOETvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErTjxb2EgisF4EQrt3fKmc+xsUFNx/7Zt8sAkAtmSFI=;
 b=K86SXYwDzobB/a/7Kjk+M0P9doVWudC/8sYQjZ7mK5ONLTyEDoZ/wsDWKoA/w8LlN/neJi1CDxjXDzI9NGdLyyuB45B0yEXxsNOiMWdyfA4yO0cAAMRNOB3LgIhjXXcxMzLmLIwWdvb47ainHwzW66t6o9e6KDLEnRR1VQvJ/GDYAWLBIP1h6wP/TJxrR6LRZfwYGzngsq5IC76ATkysWCj2CWy9/P93BuuzxouJ/+8lyR1V/Af8xR3MLy6ohDPca9z4UCJFZ//RrTZnHpFuHtDosRfLaXCGZ7oCszlyFdqQyTZChfZeNp3qbzxzyAq8VjKd6oRJs+b8hZF9pBBD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErTjxb2EgisF4EQrt3fKmc+xsUFNx/7Zt8sAkAtmSFI=;
 b=298T4IB3yS/bUdN3TqKM61Ks8u0aFJYCd4+WKQv6F35f6Zt8S0Rih3LUJT58tf0G2+dr/nujnwXw7Iwta4HmZxL+399u/inQYxgZN+KqEQgUw8khK1NrrtrURqijWjkxM2jzYISVH2O07LWH7LmNzx0EQByMFL7zc6ePPolyXpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 03:30:06 +0000
Received: from MN0PR12MB6055.namprd12.prod.outlook.com
 ([fe80::d8f4:cd66:a294:589f]) by MN0PR12MB6055.namprd12.prod.outlook.com
 ([fe80::d8f4:cd66:a294:589f%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 03:30:06 +0000
Message-ID: <adb6900d-ee9a-4840-8afd-c8dabc412f0c@amd.com>
Date: Tue, 10 Oct 2023 11:29:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Return -EINVAL when MMSCH init status
 incorrect
To: "Lin.Cao" <lincao12@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231008100627.111795-1-lincao12@amd.com>
From: "Chen, JingWen (Wayne)" <JingWen.Chen2@amd.com>
In-Reply-To: <20231008100627.111795-1-lincao12@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To MN0PR12MB6055.namprd12.prod.outlook.com
 (2603:10b6:208:3cd::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6055:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: e8edca78-6879-4ab7-bdd3-08dbc941324b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /mDYklbPCnO5qG602+3E07fc+LKcsXyGiwZYcU7dvshryYMQUMlEqaUZrrYwu+6HOCRsqYhhARgVzngCTV3DiofuBz0MIh4KX6Hof5mOCZ4IDAT+7JIvxrJo/CAzM//dl0yTiPDkmB9D2hGiBDQDmW8vstAipeI7IxnqRACO4DyvgjaKrZKATSJJpKRPCeTRcQwvqUdTgz+mmJAoIzGqSGqhcHTnNP07BMbZt35n+WBSTsYYfRniUZzXTi7VOgldkCStcW0w1pjaBDyCZsZDc3dQJsnq5mZ6q5Z5CkjoPabZr4Uwcu2pYLfeiFYA0fAmz+zDfkRfWsBeOHdWNAOp+ntvQaQAu9K6aFLxABnOD+MhO4ixEN6EutP3vyg5Mrb0Hx8EhlydgGqCx+fJVUnN/4M5ozOmbrbTt8RAzBzOJxUTHuYPnaF94d7xoPpH6lcGtIPbdjzjpODpOrEnjH/lRHP5WkFjSN/Bth6jS6HC0cZ3L1KsTkFvX7Ot/mD0FAlF8XpufFFNGpawjKP3P7i9FyTHDTd2+blnMvn9vOBwpyVKpHxmXerkrrkRRCwYztBikZSeUd4LVbLnNMsQ9NgLPIM3CMHb5AuZNsQmcYmeuqcOZTtGjz7Wk/6drQGQteYHv6KodRZR0rNC2z3IfSSW0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6055.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(86362001)(26005)(2616005)(53546011)(36756003)(31696002)(38100700002)(83380400001)(4326008)(6486002)(2906002)(8676002)(6506007)(6666004)(6512007)(8936002)(478600001)(5660300002)(316002)(41300700001)(66556008)(66476007)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGhicHpwcEdiUU5LNWEzZURSWE5MWjlNNkp0ZFVjejA2czJraGt1emhEc1JP?=
 =?utf-8?B?ZTQ4S2YrL3g5UXUwdTRQYTBCZ3hVSDFpeGVtYmFqVVQvTVVxRnI5NUNDaThG?=
 =?utf-8?B?TFQ4TGQ0TTB1R2o3RFNSLzFmcGtKQUlrZEUyTE42d3hlME5ZUVg4U0lXaEVC?=
 =?utf-8?B?K044UHBGV0JyVkZhV0wxOGRnRG9nSW5tNkZvNCtMNGJyQVdEcGVKQjFRcTNJ?=
 =?utf-8?B?Z2FwSGY1UUZaMDNWaUoydDdIL3FVRXB6QUpLT2tKUjRGUmNVZU5sTE1ibURW?=
 =?utf-8?B?V05kdUVINzRWSXhvb1pFdCtLeDZGU3hWK1BzWkZkckVlUDJqS3Zka2lSQnJV?=
 =?utf-8?B?MW11cURXYm5sVFdROGpialQwcEpWRjV3NUJKSDk0MU1rbjhobmFPYXhCRGdU?=
 =?utf-8?B?UkJIbVh0SEU2bnZJc0pUak4rWUgrRDlFSlpHTFVoNGZpWkxmcWlRZ29YRjZV?=
 =?utf-8?B?a2NmQ0sxa0VvaXdNczNtTmc0S09LK01kUEFaSTdwbEZpOEtPTmRYcUxVb1BX?=
 =?utf-8?B?Ui9nQ3lFYTJLNFBTRVE5alZYQ1FsT0dpb2FQNFNKUmR2WkR5VzRpSzllTVdk?=
 =?utf-8?B?S3pVNWJjWW12NVduY0hxd3NyK1VSbmRSSE4wbTFVa1JUQmszVkZiZmxVSE9p?=
 =?utf-8?B?K3Jia2hpYUJ5T2JEVUZGNXIvdnhabG1BY05FZkI1TXNsOFFkK1JOVXZzNTMw?=
 =?utf-8?B?VmkxS0F2TGF2SCtIaUhXWGVKYU8wWmVhaFdOK2lMTE9HSk96dlNJVFJlWno2?=
 =?utf-8?B?UjFpQ3RaNTd6eVloOUx4Y2V5NzNKdElsbXpjeXdqK21pNHFsY3hIM01jOHUz?=
 =?utf-8?B?MXUzMkFyenA3bzRuaXM2RlAzU1N4dkJuSytBUnFuVDRDcTFTcitSVkpHRlNm?=
 =?utf-8?B?YkE0SGExSSs0dDdickk0N2NPYkRwUGlGdlFwNlVGeVNlZDBZK1BuekdzajhX?=
 =?utf-8?B?RXNaQVRUUVc4RVVBZVhBQ0RtQjMxekhRaTFGY2NlSXVIbmQxTlA2ZWhGOUhu?=
 =?utf-8?B?aEFuTU9Bc3I1Zzc2UEQvdVVGa3piY0YxT0pCRVlNclRYVXZ0andsNVdhUmVQ?=
 =?utf-8?B?OTUrUzhVZllyL1YzZ3ZsREYvc3h1VWNRWEdvQy9JWnZJaEI1dnF4clkrNFhO?=
 =?utf-8?B?SGRrN2h6RHI0VzB5OFVZdUJlaHBBT29VdkZJeUlReFIyb1VOL2FCc3BKUktk?=
 =?utf-8?B?Ym9nNlpITi96VVFUWW52blRqVU9XWStabEVHVkdUUTlwUDdRVmhBT3JhWHRK?=
 =?utf-8?B?dmdZeW1iU3FjZ2Y1eFV2aERNSjQ5YSt5bkxkWWhkK2ExZERXUW9jV0lsU1lm?=
 =?utf-8?B?Y091dDdXMURjWHIzYkhqN3JPZUZHZk5oOUF3a0RnaEZxbzQyYzBEbkcwSEZF?=
 =?utf-8?B?NFkyejl3UVhocE0vTWJ4VE94dHZNcEgzTytoNDFiWXZZSlA4SmpBcjFDWkRE?=
 =?utf-8?B?UWJmYTlNSTNmMlNIVkRtWk5Cdnl1aStvdkxBb3krcGFFZDR6TXV0TENIbCt2?=
 =?utf-8?B?cFQ2ek9VZHIyYXFjRUx5NHRDMHJHRFB5ZWVNaTIvYyttWjlEMUdUclB5M0to?=
 =?utf-8?B?QU94SkkrUmZoNnJtcWpJb09KVlBZVitPek9uUVRLdFFIQnVOR3lHaEg4ZUpZ?=
 =?utf-8?B?NG0vWTFpWGxlV3hldE5ZbzdqY2tpakxQR1JId3pJTHMzVlR5eDNYU3JKRnhu?=
 =?utf-8?B?SGs3KzZoUTFwYTQxeFVuOE1haDJucG1TYVAxdk92a0gyRWRyc3l3eDM5b3ZF?=
 =?utf-8?B?R3daQXpQVlpuZUVTdmdNeFRVTVpsVXpQMGFqcWpkOVZpcVRUa0xKM3ZqQ2ho?=
 =?utf-8?B?NmlZVENoam1jQzdNQXJBV2JxbnptQzNpeHdDSHRIZUl1dkxxWnJWV0dZSUpk?=
 =?utf-8?B?eENhemY4ZEE4bFd2NXNnMFJGVGtlZlpWTk9FS2lyekR2bjAyMVpienBmRFZ0?=
 =?utf-8?B?TVI2UnEwT2F2Q3AxSENDcTkwUUd3Qm5Pa1V6NFRLc24xVy9wcE9LcDVPNVZP?=
 =?utf-8?B?QVZPaGJNdVVUQm9JRGtYdVVBRlNaSTZLZWJlWGJyYjVhdWlSU2Vjcm1IblNB?=
 =?utf-8?B?dmd4T3dHc2pxQms3YWtzaHJPeFlScVdWa2lLOWdIK2c4QWZyME9NQ09ha0pn?=
 =?utf-8?Q?BtCFpKncRaUN4WdKPNg4RjOPn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8edca78-6879-4ab7-bdd3-08dbc941324b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6055.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 03:30:05.8286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhzE5GujPwAuaS8tRIrGpACFZg/GR7yPD84TUwkgsPbPt7x/+6iuEzaVFYR8ntvvjnet6Pm2/mtEiPixQv17pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853
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
Cc: zhenguo.yin@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, jane.jian@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Jingwen Chen <Jingwen.Chen2@amd.com>
-- 
Best Regards,
JingWen Chen

On 2023/10/8 18:06, Lin.Cao wrote:
> Return -EINVAL when MMSCH init fail which can be handle by function
> amdgpu_device_reset_sriov correctly.
> 
> Signed-off-by: Lin.Cao <lincao12@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index ac614b869aaf..a3768aefb6b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -518,8 +518,11 @@ static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev)
>   			return -EBUSY;
>   		}
>   	}
> -	if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE && init_status != MMSCH_VF_ENGINE_STATUS__PASS)
> +	if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE
> +			&& init_status != MMSCH_VF_ENGINE_STATUS__PASS) {
>   		DRM_ERROR("MMSCH init status is incorrect! readback=0x%08x, header init status for jpeg: %x\n", resp, init_status);
> +		return -EINVAL;
> +	}
>   
>   	return 0;
>   

