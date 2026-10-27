Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6295606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 03:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WGTfmp47
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D3B10E07D;
	Tue, 27 Oct 2026 03:42:52 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013020.outbound.protection.outlook.com
 [40.93.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F72610E07D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 03:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnMToKaBgmVE/LAfHDd+EqD3D9pex8wTqMNahEYgmvhzly7GtTcxdKRleyYpxTWk3jhdpG953w1DwRSu90/HgNEGS9Y6lZgzc50mURYZ3DBxCZVnVNcScHzw5SYiAAT3PEdlvkAV+Al48ctPQUt+Pm6Wa8ELSFZ8s4goYvTjNLdlnR4+2uArFHfp2vuXXmp/NdJUt2wh1/U8stxqTQCoVd+kgcirvMbcY1U/ZnP8Pgqe7zbi3PhcsPeUcD1bTmWsqfuDDXTUvl7iHf6kGIN5CFcqMescZLBXN1hh/yw4jheU79fZEvvDOE38gcnALtTpkLZgSTzgLmApEU8TtiguAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3219eN/hxZetfknv1OvBMLirPxLgbU8/uRlJmQCipg=;
 b=jk+WNr7TGgN8O8ROwhM+DoIiH71rY4I/y//emrw5Aqp0LdTfrKTszpQnmgQFoPs+5HoTTmAQ3w1at+f9yH8KrmQwjchXMeeEVpgbZ8Sis7st7njbOmGWGgsV/uoxVL+1REyFtlspBSvFnHcYD90oIjNhZB8mZ3B7i1szWeA9BR4fCcd3FY/zqpOM5GHaUQhEEz7+sun+2t2QA0+Y/2AcYP5Ibsnqp7qdg9vZ6TKNY4gq6qf9HWSnAP5j6E8OiaIPNS9JARMDDMK9xNawZjW7uqNnlRtwXDdDiQfLFObg68ZL86IPh0z7kkA3U9EW/Ey9bSgq9k9pQYickR5HTZ4GIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3219eN/hxZetfknv1OvBMLirPxLgbU8/uRlJmQCipg=;
 b=WGTfmp47yLW7EKrkbU0g4JdkWLX98xLiO+B2FpHQx1Zhx4QqVs/McZ5fdEC/DBgEac1ngoA4NiLATS1zfA4+BHq1o2tbfw3IpQY1K2z9NOJZS3HhmUnTWnpyZPuijqz6TQAz8x+bKdGVVQqP1SMf9bTe9d3nnkGe+5qivyD3iNQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PHXPR12MB999258.namprd12.prod.outlook.com (2603:10b6:510:3ca::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 03:42:43 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 03:42:43 +0000
Message-ID: <cc576171-525c-4698-a269-8b7ab3133cbc@amd.com>
Date: Tue, 27 Oct 2026 09:12:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Add UALOE and UALINK IO link types
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mukul.Joshi@amd.com, Harish.Kasiviswanathan@amd.com,
 Alysa Liu <Alysa.Liu@amd.com>
References: <20261026213820.2979770-1-alex.sierra@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261026213820.2979770-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0101.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PHXPR12MB999258:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa0a121-67d3-402f-70a7-08df33dc5bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|261026121527099003|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|10067099003|22082099003|18002099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: LePQwvPxoKzKXlkYULUuxOyAApIRONyVwkyWDW4TBFrAPAta9Fozf9xECY6oy2TWMAf5o5Odn5sCtQGkCXAwOm21DNHksQi1H60RobQ6n8Lr40Vu3n4F3gSO9dBmLEysuFkhy4SvlAGUEsUKwRdi1jwJxKtUgcVxOID9kXSB0lOlQzhlAZr1RlcHyJffUuVeTHS6TdsKxqGwb7XewJTHoOJJsTUdnB52Mvj7FUK6ZXrjeramNLPHLo8XvcBzImFltJuNWu5KoX78TNuL8Xwqm/U+cz0XDnq0bWnJc8Jm/FMlgnBUn4CyscQ9cKvV/TsOk0k3QD8RZRbd5iXRSFl4L3EOT0Gsfam2htu5EZ76HvIqzi/CxjVBx0pnR4/3+qzAxTRggYZ6ljp40hZtIMNhtbS7scNFbvN/D+nLhSbEcSuI1GOAd6FEU566ch0d+rdzLV1ap8BFYX5w+13+IIrffrSWuLgjJJTLdnfTpvfUx3cMuTl7b65UJ5GzEvlmMkmvJ4PEwur+zwp1tufn8lCH+9/A2jqPEcH55MGtT1pV5V3ISbdbDiCvQDEDOLmfQbKjNVVkzu3uw5ix3jOwP18fgcpO8uCe56cWOukD0YcZtZqONzdt099+v3WljWadQPiyr1/RY8WvgkkEbCN9m2GhMlP/JQEthY4GOnwkG/pKiH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(261026121527099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDJrUjdoMCtGT0ZWSWN1cWNZZzV4Y24vUlNrdmZZWmtVbUF0TmpkRTZKSW1a?=
 =?utf-8?B?SDlDOXRZS0pjaUNXZ1F5NDBpWlhaczJad3ZiYTBGZE9RY1BIQW8zV3B0b3NG?=
 =?utf-8?B?MmxxU01QUkhDbmpXQzYxRHJWWlNvTFFRQnh6YlA3ZzFoQ0hhQVF0Z0ZjLytK?=
 =?utf-8?B?S29ZSUJxaE5jWHZRQ0ZJV1plZW80WnNpNnVkUGVMMjhSOXpMUWNvMWRQMHQ0?=
 =?utf-8?B?MEtLQWU1YnBtSGxlOGFkZkl0WmNRaE8vc2tKRElrM1ZYdWxhRC9kUEtsL25l?=
 =?utf-8?B?Z1BlSEQrSnRGMTJVczBVQ1N6bmxaSU5tTFhCR1N0MlVIRndHN0krYUYxVjk3?=
 =?utf-8?B?OUlnM0ZhRUwzWk9NVTVsUHVqc2M1VDhlRkxsZUdlc2RsRWszSXNpOFRHSWxk?=
 =?utf-8?B?WmIxZWMweVE2aWFPWkgvdXNhZHNpMm1lSm5kdVV1UFhIUDdJU3dqYmYzS2gy?=
 =?utf-8?B?ZXBscTZlaTh5ZWxGZzE2WEFOamZxSURTcnhNSms1amFGYXc5Vmd4eUNVY2VY?=
 =?utf-8?B?ZGhyaVNGb0xJN0oyckpLMGVNdktBWG1UUnNRQkwxTlBTajNoU2hQc2VWeDJh?=
 =?utf-8?B?aGxqaWEvUksyR0U0V2dhQWpEM2cwTHVhS3dSLzVoSTRZZnNCc2tvUUc4ZTBC?=
 =?utf-8?B?c3oreVhjVVZ6bEdLTW9ZUG9RRW5vciswTjlMRlpsSWdXM2Z5QWZOSS9WZXJy?=
 =?utf-8?B?YU1LQitJc3NTdytTbkNtTmFQVkY5LzQwWWFBSk93b1ZhdXVsL1pVSEdGb0dX?=
 =?utf-8?B?VkVKWE92eW5TOVlCZkMrTXU2TGhWN2F1SjdoTGpaTTUzUzJxaGx2TVJoK3A3?=
 =?utf-8?B?Rlpnbk5LV0pFZmJ2cHdDTEJsR3JQWWJERmQrUG4vdW4yb1dJNVZBVWVOeGJQ?=
 =?utf-8?B?Z1FIUnhXa1Rnb3NRaHBzMnptdkRzOE5SZXlabi9rZE1WR29kWngwS1hkTHBG?=
 =?utf-8?B?akFqUWppeFNkWldDMGF3RGErMVhXSGVjYVRKYS9GVkhKYmhNUHJpT0VUNDFO?=
 =?utf-8?B?UmlVMHJ4NFRUbU5QTVhpVklQK1ZRVXUxaHZYM3pVb2M2akpjOGlWZXRlMGVK?=
 =?utf-8?B?SFNQMGlKYzc2YjF1L081bVJsQkF1Mys3ZWpOMzhlQ2lXTFVxbjhJSzVHbGtx?=
 =?utf-8?B?UVJNeWtzWTVqemxnVFdBWUNteHR6T01IeDl4Tys5bkRERGlNUUFaZ3pnNjJJ?=
 =?utf-8?B?RWtoblZmVkx5TG9UWTB4VUQzNi9VeU1xckNLTzA1eW03RzNvZkZxOGVOWmpZ?=
 =?utf-8?B?dGdDZnZtcFhPL0JHeEFCZ3NBT2lOenFxZ2hHRTYxLzdJWTBYd2pFMkpsOVJ3?=
 =?utf-8?B?VUVQeVJqd2VmODdwUGQ1dnpqSCttSWF0U1F0UFFQdHltcEFlSEVnU3VoN0RQ?=
 =?utf-8?B?RG91bFQ4cy81VDRNYXZraVZ4czVkcTJmc3gxWmVySDVYaDh1TXZCZ0x1SEZM?=
 =?utf-8?B?MkVZbk44ZFQrUTBuc0FpOG9hcmxYUWhMckVIT1plRis3RmNMZmlUY2lIcXNv?=
 =?utf-8?B?Z1VWKzU5MUhzTVJLZEVTR2lKZkxFWUdpSEpMcW5CNzI4NUJHRTNNWFBDekNQ?=
 =?utf-8?B?M0tYUmYwL3lycG9uYXlxMmV1ZGJ0Zll5T3hMaERlclRXR2VWR2h0T3liRnRB?=
 =?utf-8?B?UXZ1UkM2RVYxK3ZWMzFCY09xK2NvTGRkTFlrMmlXR0U4bThXeGszd0VNUzNB?=
 =?utf-8?B?dzhkTWMyWU9DbG5iaVQ4SnRuQ0IxMXFlSGhsZE1xWTJkdGlRZDYvVUxyRVB1?=
 =?utf-8?B?dHlsMEJPcm82Vkg2Zjg3Rmd3d0pXWHhnbzF2SDZFbWFiNTdHSG5nN3hMb2pk?=
 =?utf-8?B?TXJ0K29rUytYZU9XVmI2K1lYT01xRVlTU0xneWJ0NXY2clRJUHJSa2FGSFF6?=
 =?utf-8?B?QXR5VUYyZ25zQlFXL29Pbm90M2ErdW1IVXZrdm81YllZMGZoNlZaZDlYbXl4?=
 =?utf-8?B?Q1ZHSCtXUUptUVpoYmNKZE1HYmdwa21oU0tFVGV6MHJnR3FOb1FNVW1OOW1N?=
 =?utf-8?B?VGxCRXQzem1PWldRT0hPL0d1aEFKYzlKcnlEREFWb1NxSUFyMW05SDZYN2d6?=
 =?utf-8?B?Sm01S1VVcHpCQzYzUENRdmlSa1lYYTM2Yks4TkIxakp5bjRqengrMUhhdmFh?=
 =?utf-8?B?Q2o2Z0RaUXV0MktWVlorUnFvOU5KRlNza2hPeVBWZjZyb1YxeWt6OS80R3BJ?=
 =?utf-8?B?VzRMWEozRTIra0IxQnZpV1R6NlFiR3Y0NjJ5WFZxUFJZOVRGUm04VXNHM0o1?=
 =?utf-8?B?bUF1WHBHRlJBclhXTXFRSlZLQUlLb0ZuOW1QR3QwM1VmU1Y2WUpxZnUrdWVV?=
 =?utf-8?Q?apau9o9tx/q5Hs6eTm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa0a121-67d3-402f-70a7-08df33dc5bbf
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 03:42:43.6458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUOURt4cE9bcv8nucN1QchEOyUc+TYfNZweRVnnDUuo6nt1DB+JeN3HVUsQNAvPe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999258
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 27-Oct-26 3:08 AM, Alex Sierra wrote:
> From: Alysa Liu <Alysa.Liu@amd.com>
> 
> When ualink info is available, report the specific link type
> (UALOE or UALINK) instead of XGMI in topology sysfs.
> 
> Signed-off-by: Alysa Liu <Alysa.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 18 ++++++++++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  9 +++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  6 +++---
>   include/uapi/linux/kfd_sysfs.h            |  2 ++
>   4 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 7725956e4b08..0583624e5897 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1254,7 +1254,7 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
>   
>   			if (props->iolink_type == CRAT_IOLINK_TYPE_PCIEXPRESS)
>   				props->weight = 20;
> -			else if (props->iolink_type == CRAT_IOLINK_TYPE_XGMI)
> +			else if (crat_iolink_is_xgmi_class(props->iolink_type))
>   				props->weight = iolink->weight_xgmi;

Should there be different weight values for UALOE vs UALINK?

>   			else
>   				props->weight = node_distance(id_from, id_to);
> @@ -2229,7 +2229,21 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int *avail_size,
>   	sub_type_hdr->flags |= CRAT_SUBTYPE_FLAGS_ENABLED |
>   			       CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
>   
> -	sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
> +	if (kdev->adev->ualink.info) {
> +		switch (kdev->adev->ualink.info->link_type) {
> +		case AMDGPU_UALINK_TYPE_UALOE:
> +			sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_UALOE;
> +			break;
> +		case AMDGPU_UALINK_TYPE_UALINK:
> +			sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_UALINK;
> +			break;
> +		default:
> +			sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
> +			break;
> +		}
> +	} else {
> +		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
> +	}
>   	sub_type_hdr->proximity_domain_from = proximity_domain_from;
>   	sub_type_hdr->proximity_domain_to = proximity_domain_to;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> index a8ca7ecb6d27..ce78484f94a5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> @@ -257,8 +257,17 @@ struct crat_subtype_ccompute {
>   #define CRAT_IOLINK_TYPE_ETHERNET_RDMA	14
>   #define CRAT_IOLINK_TYPE_RDMA_OTHER	15
>   #define CRAT_IOLINK_TYPE_OTHER		16
> +#define CRAT_IOLINK_TYPE_UALOE		17
> +#define CRAT_IOLINK_TYPE_UALINK		18
>   #define CRAT_IOLINK_TYPE_MAX		255
>   
> +static inline bool crat_iolink_is_xgmi_class(uint32_t type)
> +{
> +	return type == CRAT_IOLINK_TYPE_XGMI ||
> +	       type == CRAT_IOLINK_TYPE_UALOE ||
> +	       type == CRAT_IOLINK_TYPE_UALINK;
> +}
> +
>   #define CRAT_IOLINK_RESERVED_LENGTH	24
>   
>   struct crat_subtype_iolink {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 8689f4110afc..1863a944d44d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1473,7 +1473,7 @@ static void kfd_set_iolink_no_atomics(struct kfd_topology_device *dev,
>   					struct kfd_iolink_properties *link)
>   {
>   	/* xgmi always supports atomics between links. */
> -	if (link->iolink_type == CRAT_IOLINK_TYPE_XGMI)
> +	if (crat_iolink_is_xgmi_class(link->iolink_type))
>   		return;
>   
>   	/* checkout source dev has atomics support on root. */
> @@ -1572,7 +1572,7 @@ static void kfd_set_recommended_sdma_engines(struct kfd_topology_device *to_dev,
>   			inbound_link->rec_sdma_eng_id_mask = xgmi_sdma_eng_id_mask;
>   
>   	} else {
> -		uint32_t engine_mask = (outbound_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
> +		uint32_t engine_mask = (crat_iolink_is_xgmi_class(outbound_link->iolink_type) &&
>   				num_xgmi_sdma_engines && to_dev->gpu) ? xgmi_sdma_eng_id_mask :
>   				sdma_eng_id_mask;

This may not hold anymore for SOCs supporting ualink. Instead of 
dedicated sdma engines, probably everything can be shown as available.

Thanks,
Lijo

>   
> @@ -1601,7 +1601,7 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
>   
>   		/* Include the CPU peer in GPU hive if connected over xGMI. */
>   		if (!peer_dev->gpu &&
> -		    link->iolink_type == CRAT_IOLINK_TYPE_XGMI) {
> +		    crat_iolink_is_xgmi_class(link->iolink_type)) {
>   			/*
>   			 * If the GPU is not part of a GPU hive, use its pci
>   			 * device location as the hive ID to bind with the CPU.
> diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysfs.h
> index 0b6ce2f3c887..b11f9bcae7f8 100644
> --- a/include/uapi/linux/kfd_sysfs.h
> +++ b/include/uapi/linux/kfd_sysfs.h
> @@ -114,6 +114,8 @@
>   #define HSA_IOLINK_TYPE_ETHERNET_RDMA	14
>   #define HSA_IOLINK_TYPE_RDMA_OTHER	15
>   #define HSA_IOLINK_TYPE_OTHER		16
> +#define HSA_IOLINK_TYPE_UALOE		17
> +#define HSA_IOLINK_TYPE_UALINK		18
>   
>   /* Flag bits in IO link properties (matches CRAT flags, excluding the
>    * bi-directional flag, which is not offially part of the CRAT spec, and

