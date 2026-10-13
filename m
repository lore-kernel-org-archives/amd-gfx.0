Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33266CC6B0E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 07:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C059010F5B2;
	Tue, 13 Oct 2026 07:55:16 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190D010F5B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 07:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amN3ozGXcHHXYm7DfDLocuCcMn5F2dslxLm+AGNVDLvvPeLflObM6BO6zisGMoTX/5Eif+ct6mtC+W16/WJnInOGcr/M1A+tbpx/zHaBeut/k+/figu6bWGlhFGbBSeSXsCdVdVE1H2RefR8euCeeM4dc0TF2352wV+OXmEU8fVyzYBHK5H8jf8MH6HiOU+SE9UXyaQAwpxK0AafQi9UVykTNlKXhN3CTBW+WTavB+iUdYCQZRhPatxod1HILEcRgp3UDDpCFkwvyak8lk9rMftR87eKhPsj09FEI+DtnC3+K2cdyx9eQIIBcJFlhvBxAe68hBT0YLmrlxWMgAjUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=105z8qtDN4TpreQ8j98+TtrXJStYHcsr8XJiI7cLqXk=;
 b=vEH1UxTATXRIN5n7IIB9CqhE4RgSm8zAxRvU2vCUsDEnIHiixJVVknZk92UvCPs2AhaWnxDW2dgeJEIujjXUzBZYXAFgJfZuky7NX2oV6BgD/P1q9bxnZdinuBtkuZXFM1eObQneU487lNozRaN7GZtmHYv/Bn95yix2dUCbDkpccjK2MxlY+pjb4fD5CtjX0A4XogWbUo1nPV4FM83rRBsJJgo48wU0Or2fxtRsKQEvuJgcL3lF/ToxnmcikEYGPLd8UdoNuUcylGviKsaYqU9WbztFAQqkfx9IBHz1pbRz641lBQX57Jswij0pbbNPBAhorOgYxiA02x50Ap6R1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=105z8qtDN4TpreQ8j98+TtrXJStYHcsr8XJiI7cLqXk=;
 b=5kP+pW3nCIGlJAUqKdWnB8/4qZ4OMGwZgEqOShENqrGEPcv0qaef49DzDejtLkdPJPC3Lnuxidfj6DhmqrPEmh3nEptaQKnZmgdsfb9BurtFYqj+MWN2BA1zDsQWwhYWXNHzqSThG1CN/qe+dzyV8SkWV2IgrfoBAft6KPVUcnY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 07:55:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 07:55:07 +0000
Message-ID: <e423d575-787b-4b1f-a6fb-0ee877d23c12@amd.com>
Date: Tue, 13 Oct 2026 09:55:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/amdgpu: reject unknown GEM_METADATA ops
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com, sukhatri@amd.com
References: <20261013013347.2015715-1-Jesse.Zhang@amd.com>
 <20261013013347.2015715-4-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013013347.2015715-4-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ed6d4c-b79a-4e49-0fb3-08df28ff4c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|261009223027099003|261009221227099003|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: lNK23Vs1+qb7TzAHkli3LaYyVF9+ekmoVR6oCMzkuEsdh2nh3q3Qv5xiBf2uKmthtwfs0CW6MFCVsqCHR2I/FKlZw8hotCdLgMdqhJyxeXFPEO1BcRdH0tv8tSB8vrV3LGbFiwLnHMWN8m59DCsH8s9wpx8U0kMLfKvp0xaVa45gq3VQcGWIwY1gNH1AASMhlMmlYfb8ctC+EnlVb5Ggp89j4uwW9E6IP4KICQcRHK6SQjrHTiXsF1B6fB/xViuJxzMzwRNQEg4ysl8UaX5Qs2oMIPnHnpDQS7CnPSeQISSSnE8QOlQGpKQ13r/sxgfXs8RqKxIOaAFmWJCa9+NP3kzWshc/i6NWqSIpkPcVQ1hgjk5LtlowRerz+f3iEcnQK0K20Det53BYzOoANL7ONhJMozPpALkkZo09qJ+kKZNkADb6VxILRXPLNzRS+DSKmvFSLdrOXVoryxeDjYpTBE3/BttAshyRG4/CkDd852frwmMSC2lmRKFRxQTMNq1ogLTfgEElPQDB9mq9qJHISEGjb9cSGazGJqQOnyYxFR+v0o8bljJLzRMHGF9/6v+B75KEiL4nixcp9HQEDiTIvWgBR5RriRf3NI0Q7MB/Y7T/ola0iPb4xEqAdqr31o7VJ6sdrqJp5SHsYBkoEZlUMJtoz5B/4EBs2lZimCbVdYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(261009223027099003)(261009221227099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGpJUXhWb1NZM3ZnR3VGU3BUQU5lY2lPWndNcTR3b1BVSmNsUHRWNlJ1S1BZ?=
 =?utf-8?B?UUQ5NUQvOWFHYTZCU1EyNUdiTXp4N3BIZ3MxeDNFRlBNOFBZNUlOUnJyTm1M?=
 =?utf-8?B?U3hwU3RtbDZ1OWlBYzlSOTM3K0EzRXg2SlZPUGxRTUVoN1p3TCtLWSt5QkI5?=
 =?utf-8?B?Tm51OFdFUERMS3h0YWd6RUt2U2oxMElnbDYvK243Z3RFNVVRNW1SNGdobHlQ?=
 =?utf-8?B?Q0pGOU0rdm1ZaFZwZVZRTXZZZHpsSGpXZU1hbFpjSjE0a0cwT09JclkvNm0z?=
 =?utf-8?B?SkZpRnp0dUg0MThWRlRkKzlYbFJobTFKV0FTYW9vZHRjL3NkV3djUkN3dXJX?=
 =?utf-8?B?NGJpaWpVV2hJN2t0eFh1MnVRMlI5Ri9xeXc2VWl2aHlseTVPUEZpU25JMWhx?=
 =?utf-8?B?UWNVMjg2R2t6R3pjeGxKd2ZMUFpmV0hnb2hhWWljTnVEeFBnZHA3blpDbTBO?=
 =?utf-8?B?ZnY2ZE9NOXNVeEZVTXdwbFdwQVBnVW5XSzhPUUg5KzRrSG1Id0JNUEdZZGtm?=
 =?utf-8?B?ajNWTDdSZjF0ck9NSTNyR3VXWFRtMCtoNjFBVmsvRHpoc1NUQmQrMG5ic1Vy?=
 =?utf-8?B?RjlUSC9HZHFnSU9zVmtGb1JJYjVlZldEYTcrQ0E2VW1SYytRcnAyaDBJZUJ0?=
 =?utf-8?B?WE1TTU92bXprbmp3bTIzc25pamFRbnErT3lPR2dhd3JrbVBJcTd4Q3N6aGxM?=
 =?utf-8?B?RlZGYkxNaHpHSGZUaWdIUEoyRXQrUDUzWFo2VE1lU1RDZkw0UjkwQmdHSmZD?=
 =?utf-8?B?a2htRUY0aTVINldVMWYxNXpjVWlOK214ZlgyeURNelp5MjBra1NzN21JQkh4?=
 =?utf-8?B?SVhCVmFueWZNMTVkaWNIVlEwQmkvN0ZkVld4WFVnKzRBYU4wRldJOG1vc0dr?=
 =?utf-8?B?YWs5cXkzcjRhd0d2S3JBczZOc0xORFMyQUJCd0RKU1BrbUMzZENkRmU1Rm1s?=
 =?utf-8?B?ZmF3N011WkgwSzlzdE5oODFkZlBKUHppNnVoaEgwNlpqblNsTUhtUXB3S0N4?=
 =?utf-8?B?c1pSV29scFBENnlNdSt6YlNJSm1CTUszMC9yUi9wYlc2RXZvV2x3Ykc0RVZN?=
 =?utf-8?B?WXp3RW9zR0pkcmc1Y0JveHhLa0hRRFhCSjF4VGN0aStWTGg1M2QyRkZjWlpQ?=
 =?utf-8?B?VFp2dlR2U1JwZE9jQVJyUmRoc1ZWY29NaGdzNlo5T1dwTFFPK3NDSmgxZVc1?=
 =?utf-8?B?eTViV1ZpN01YTjlXZnhnNGFoYkY4bFd6RUZwU2lRSmt2enM5VkZCZG5JVEcr?=
 =?utf-8?B?a2s5Y1NLUzlQL0ZsbVNHcEdVekpLbklBU3h5dDBhMzhscldKVGJrTThmT3hO?=
 =?utf-8?B?T3d0T2hCNWJBV2tQUVVVTDI2K3V2a1EwblZWYnByWUVQRTkxRE5tbk5UQ0Zz?=
 =?utf-8?B?Z3lXclpxa2Z0QUZ4S0g2NDI0Sm5DcWpwUFROQ2dJYVRYR09iODRUVXI3cUZ1?=
 =?utf-8?B?N3hiTDRmc3hOUmRZMm5QZXlSY3JzaWhyL045NHJyM3lZSUk3RURpbWlNR01O?=
 =?utf-8?B?OU9LQVlrT3cvYm9td3JTZWdnQ2toUzNIMmZQTWFNTjlaVHVHWlI1bEdtU0o4?=
 =?utf-8?B?L1JRN2lsdTZtdmFmNEJyZXJqRTFDSFVwU1lWYU8wdk50WFRVbTFOZDFlU1BI?=
 =?utf-8?B?L2JycDdJd1JoOXhaMFc2bFJHSVVLTlFvd1B2Y1BxSlNVeTRFOE9Kc3VPOFRW?=
 =?utf-8?B?RGdtYzJZSmtQQ0Z1dnZFSWE3N3lnN1ViREdLaCt4bmFXSDdocm1kT1FvaEo1?=
 =?utf-8?B?bS9SaDdvQ2ZkQXFQdHhtWXAvRFA1RllvM3g4c1VYMHNVTWZjQ3BMNlo4RXBm?=
 =?utf-8?B?WmM1OWN4c01QTXc2Q0hWVnZTNnkyNGhkU2lhL29TbGNySDVqZVJUcWNmb2NF?=
 =?utf-8?B?bURTTEdnOWpUQ0NTNFQ4a0FtOFMxT0MwMWgxNUtKazE5WDJEZy9JMEcxNXJW?=
 =?utf-8?B?MWFaWUwvdVpMYTlPY24vMWkxaXFoM0pZZCt1Nkx3QTNQNmJjNzY0WFp3N2xK?=
 =?utf-8?B?Nnp1UWlsUldmT2JRVTZkT1g4SkVmTWRYdGZJTVpGN3pkTnlqZ01rV3dqanVN?=
 =?utf-8?B?TnZESzN6N2pWYTFQTWpJUk9ZblVSYzlZNGE5eWxCek5XUFQ0WElpMnNTcTBu?=
 =?utf-8?B?UUNTNTFIU0RBTEZteW5UVUp1VUNHaExSeEMvRFJRVERHY3NSR20yS3RwZE9G?=
 =?utf-8?B?UHNxTzRhamgzWjVFMEtHZmV2eGpYWlRzS1E5MVJWaDBFQnpIMjNIU2VZR0w0?=
 =?utf-8?B?TDY2T2ZDYWV2ZUxRRTJhU3F6aGJpdWk1TG45NEo4bFF2MlFTbHMxNDVuQ1Vp?=
 =?utf-8?Q?xf0SZupATFUigsknrQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ed6d4c-b79a-4e49-0fb3-08df28ff4c32
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 07:55:07.3325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4No6wbrhIh133BpPatHUQWAHpRV7grFt/c/f4JjiJTOHEH7/ZOmSZ/s6vFQ0r4d/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
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

On 10/13/26 03:33, Jesse Zhang wrote:
> amdgpu_gem_metadata_ioctl() handles AMDGPU_GEM_METADATA_OP_GET_METADATA
> and AMDGPU_GEM_METADATA_OP_SET_METADATA and returns r otherwise, which
> is 0 from the successful amdgpu_bo_reserve(). Any other op therefore
> succeeds without doing anything.
> 
> Convert the if/else chain into a switch and return -EINVAL for unknown
> ops.
> 
> v2: use a switch statement instead of if/else if/else (Christian)
> 
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 0552b17d9aa8..fb60a99f43c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -764,22 +764,28 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>  		goto unreserve;
>  	}
>  
> -	if (args->op == AMDGPU_GEM_METADATA_OP_GET_METADATA) {
> +	switch (args->op) {
> +	case AMDGPU_GEM_METADATA_OP_GET_METADATA:
>  		amdgpu_bo_get_tiling_flags(robj, &args->data.tiling_info);
>  		r = amdgpu_bo_get_metadata(robj, args->data.data,
>  					   sizeof(args->data.data),
>  					   &args->data.data_size_bytes,
>  					   &args->data.flags);
> -	} else if (args->op == AMDGPU_GEM_METADATA_OP_SET_METADATA) {
> +		break;
> +	case AMDGPU_GEM_METADATA_OP_SET_METADATA:
>  		if (args->data.data_size_bytes > sizeof(args->data.data)) {
>  			r = -EINVAL;
> -			goto unreserve;
> +			break;
>  		}
>  		r = amdgpu_bo_set_tiling_flags(robj, args->data.tiling_info);
>  		if (!r)
>  			r = amdgpu_bo_set_metadata(robj, args->data.data,
>  						   args->data.data_size_bytes,
>  						   args->data.flags);
> +		break;
> +	default:
> +		r = -EINVAL;
> +		break;
>  	}
>  
>  unreserve:

