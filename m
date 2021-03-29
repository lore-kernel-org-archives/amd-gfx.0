Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC39C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 16:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3B46191F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 16:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3B46191F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFFBD89C1B;
	Mon, 29 Mar 2021 16:52:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F66389C1B
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 16:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Anj+cbYEgF4dUOiAnAFCALDX91xZi6SIXb330fB9kedXlRWrCyeE6TZ0E1MhkomFUbSXEMjOau2msRolNBokk/BrD/P4Wo6uYV+4uZrdc2LUKIvKLitOsBpxvK7c0ncqG/K6rUd04jEtKIwWY8S0bNeaZCi170jAznxBxscqbd49BskqNPxWVoieVnin/EjD/BZmeYDXndBEFMPy6OByp89JpCeItfFHcfplcZivBCPX7C+0ZNaQcacfrM6mhFuGKF3BkmKifKcyuIvSWAYrfKUQqsJ7qQMywbGI7GOPus5dfozcTgYE5hSW1M6XN8fvNtLJle+REc9dkFGfnhZeSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrQWStlShCaSjp/yTOEYvp5V+hVTUJNZQS/1HT9bVhY=;
 b=ezLMiwduOLKIqzSr0SFecok14fAIMIp6YZn/f6YyfYf3lmjMGycuXMZ9CckAbQOMmTh2lTExmsZTLq2TNUJKJS4Te5EU1dVkpoF8idHySTrmPJ3YpVc0OIXuooVzY1FmIMtAXwtmyTuw1OZFaBqZFN63rgvlP+JdUbDD7PHGGO6HDu+Ey4zBs7hy1bEBQbNSgOBBcI5stC2h1Wzm5JgIXJu780lISDGwndDKlVfdB7iJ1yi/k0IQ+4WMvCi+TokKAH1557eB3X9yC78E8CXzU7tPqyvQ+5c4KN2mFAVw9/0v19pN1xBmNEu20xkYQyX1JLhXh2ptPYqS9cd2gEGXOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrQWStlShCaSjp/yTOEYvp5V+hVTUJNZQS/1HT9bVhY=;
 b=fXZmNGk/dN0CBF5U0bYkmrfUpyq+3+HzXbZ59dFRggYNJvm0XyS0g+9SzTERKuja/oWeOAaMm6+pnBiuCrBU/rCb7WZbySCylC/rH6kuG2Q4CidmbnkHKuYxWK4ymiMRT4Mx8EMonmssWdclxaT7B8Jpoq6yoBLs7PxYU1SbxOw=
Received: from BYAPR12MB3319.namprd12.prod.outlook.com (2603:10b6:a03:dc::10)
 by BYAPR12MB4613.namprd12.prod.outlook.com (2603:10b6:a03:a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Mon, 29 Mar
 2021 16:52:48 +0000
Received: from BYAPR12MB3319.namprd12.prod.outlook.com
 ([fe80::5c85:b374:b772:e848]) by BYAPR12MB3319.namprd12.prod.outlook.com
 ([fe80::5c85:b374:b772:e848%4]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 16:52:48 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Li, Mike (Tianxin)" <Tianxinmike.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Update L1 and add L2/3 cache information
Thread-Topic: [PATCH] drm/amdkfd: Update L1 and add L2/3 cache information
Thread-Index: AQHXJLlvjdVTeAsYIEOA96Voy8KVfKqbLbCw
Date: Mon, 29 Mar 2021 16:52:48 +0000
Message-ID: <BYAPR12MB3319F5D506CB4D686B883FA2857E9@BYAPR12MB3319.namprd12.prod.outlook.com>
References: <20210329163327.7172-1-Tianxinmike.Li@amd.com>
In-Reply-To: <20210329163327.7172-1-Tianxinmike.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-29T16:52:45Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=7c8ee366-a299-424a-8b61-1bdb63ae6572;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1c80:6680:1ce3:c0e8:9025:b222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb6269ab-d27a-4fae-0477-08d8f2d3155b
x-ms-traffictypediagnostic: BYAPR12MB4613:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB461313E9944B56C9BFA1D7F9857E9@BYAPR12MB4613.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vn/CFMLu+onUzQGWPaPpW3/oX+XZjNmtUNd9oMFkON/l//vl6aq9r5NnRIuZ+PBxgLLj854/jsHnoOkZHcmy31Fx4B5T9ietxIdLnc9OfLxFgYRdnlkZ32wK/wgN1IY5EZKcRqJSB3M3eZbsGUCbE3sI0rytuI2XgUYB7SUwVUyIvzZsly3WsTzMnjYa1IlwfaR/NP79f33CirJbA3A8C/OyvP2BQi9CBiJJYXUu0G+/TtyQMMQcjR7LWu8V/Wvks2qun6kdkytsDgKW799lf/pHlGM2jCPbCyKhEwxpSieCs4vY8aPjIiHpVzpIobeOXTSzeENybcpmDyyJOd1EnfmVFTGn1o54IK88vr/t2w/RALJq49+jNwWbL7Mx5hAHzkzMKXNup15BYx/MNUx/n/i4GGZvrBp5YlzNVRF8RS6K9iUDCfjLUfMuFwyLAqN8EWqS1CVAyhVuCqM/Utwe5CE2p2qjff2jcfQ5Ns/WVioqhGftj2h+DU6ARNhq0kT71rvdJ3RGLUT5mm3XA9lSoaA5+XeV7F2FZA6QWc60OA7nAIUQtZ+7jtzYocEXL0NTMJyhsAYDDGNVDfgLuX+mxQIW8/KLpD8L8Ge3cnw/p46W+YuCnjKdy1TCln2IBiMZ5IAjEUtIumkhnU3lR5sxIUSJMTF2z/CwZXoXsnM+Jgyt5sLtR0mHRXhNTtrL1x/rzs2gJjyU4eNmQosyxbwgJwq3rqcPLKsTf1M3kYL8frQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3319.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(86362001)(5660300002)(30864003)(8676002)(76116006)(15650500001)(66946007)(966005)(52536014)(66556008)(55016002)(9686003)(71200400001)(38100700001)(4326008)(478600001)(53546011)(66476007)(66446008)(7696005)(64756008)(186003)(8936002)(6506007)(83380400001)(110136005)(54906003)(316002)(33656002)(45080400002)(2906002)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zgYM786/WKyAwwJfgbduGD66BTLIli/G5mAqeekgsjtrY9fdxbJ0znYvdOgN?=
 =?us-ascii?Q?dsUSfTOV6qA60UQ3MAMZ/aPpu0gZJfqvv8pVw17WWln+OWb60a5gaBK2h+N5?=
 =?us-ascii?Q?+3tlPulysCmYghlNmtRA37OzgqojOgeTGAnsMVOF9E/x5R3KB9CRO+sOccT4?=
 =?us-ascii?Q?RyEOiJ/KPNJyq0ayUO7X9616UOsW1JQMuEHGLEnBlxqGpCytgPiyrWEtxHKB?=
 =?us-ascii?Q?naa1GYqKsqb9Ty8mZNU8anG2HdwLTY3JIXceYwtMyW+Xf1KvsTjRQppMQFQC?=
 =?us-ascii?Q?ZAKwIvgn4uv/kg4q9k0RXz9Ds5T/goa+hz8GMDz48UGZGN2Y78uiqPDOR32X?=
 =?us-ascii?Q?CLRcjkFkjEBzvqcyAlOn/gHIpNglCkEe7faoqoxreQl/tjFsOFT9XW2mx0Ec?=
 =?us-ascii?Q?TuTwdqpfp3UofdAXSOYZz44J55cVXbBqeAjOyeXXtKMZhWRzpWx3OdG6Qd4t?=
 =?us-ascii?Q?t7hIMnefkRailo8I9nAFMeQT5KgA3+h4CrmYz28/ase5x7yclwrV5JxKg4L+?=
 =?us-ascii?Q?wJD9bZDvN7ZlLemzMQrhMELyKHRotFyOIs9DVf0WASU4T51ePa8TjnyDNALU?=
 =?us-ascii?Q?RovVLFJvw5AsewAn7riWNapS5I+VEMyKmofj1is8i3UVYCekTX7ate2/FZgI?=
 =?us-ascii?Q?Bdvgf9k4TnImgbsy6ykUIM8P62h6/9eqC2oy/2RAf1ejeO+36+5Bca4mre7/?=
 =?us-ascii?Q?fTUC9OQSSXC1ce1DvyLqXBBCmkolGkONkdIfdNG83ITZEoCoJ3WkTXwgW0l+?=
 =?us-ascii?Q?1bVIhetcQ/GQqk93VOXUZRxFLUebewjqN0qiqAvNS0/uCUmfJ373chNsFRF2?=
 =?us-ascii?Q?CgUD2A5gmkWEl1Ek6O3/G2zl2CP4Gi4QGsM7aVJZHSWYkzv4HkWQ1R8X0VsR?=
 =?us-ascii?Q?ky3EqHN4Wx6AyvveE4GuMJ53cZ/quo59NUBeQdkFl7AIlWTUXMdiLpfIH5a+?=
 =?us-ascii?Q?eZ6tijJ2cVMgoFeCI5OTqxbJfbrw9C78Ar/BbwJE0vHteSAw01na2SOY/vsq?=
 =?us-ascii?Q?dHm9CNiA7AGpymJ7fZhFOpIfJ20gA9PYQRpl6IP0aPiRH4K4pkVuACYjoO0N?=
 =?us-ascii?Q?izxwYDrnj/laKKMRqDnPr61kA2JKIPjRatBlDOwFG2tEHHA6Em8geAIoZKgS?=
 =?us-ascii?Q?7Q6XOUoRUc13B69gfT5+//7zfIP1987/LgJILNenqzOPnDKmawHbQ21zS3J2?=
 =?us-ascii?Q?vbM138tXRXGd+g6Yxvkv+epWwFShXAz/jQ9HHRJkzuuYhEB2v8dIzHg9bfhN?=
 =?us-ascii?Q?havlJXkUhtLM7DgeHii9tsuF8ZPb7rFrWm3v2w5C+oeBzSzLpZ/kdbpIy9dd?=
 =?us-ascii?Q?0dnl7m+m0L2BWTmYN98LdwbaSSTyYPhUZGLwsNv83LuzDx7wP2TOw2DF0v2K?=
 =?us-ascii?Q?ZJFru93it+KeCMZNlqrqUWQfjJ7O?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3319.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6269ab-d27a-4fae-0477-08d8f2d3155b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 16:52:48.0524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: er0WB9R9OY9XOSBvoa9qYPKAeQXMRnlcNbBxelPXQW9kaIg3hMKsz43pZqN/vyZu8jMJtAL59VQwcAjYixd2Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4613
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Li,
 Mike \(Tianxin\)" <Tianxinmike.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Some comments inline. Don't address them yet until someone else reviews this more thoroughly though

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mike Li
> Sent: Monday, March 29, 2021 12:33 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Li, Mike
> (Tianxin) <Tianxinmike.Li@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;
> Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdkfd: Update L1 and add L2/3 cache information
> 
> The L1 cache information has been updated and the L2/L3
> information has been added. The changes have been made
> for Vega10 and newer ASICs. There are no changes
> for the older ASICs before Vega10.
> 
> BUG: SWDEV-260249
[KR] Take this out, the upstream community doesn't need to know about our BUG IDs
> 
> Signed-off-by: Mike Li <Tianxinmike.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 749 ++++++++++++++++++++++++--
>  1 file changed, 699 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index c60e82697385..eb30324393a8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -55,7 +55,7 @@ struct kfd_gpu_cache_info {
>  	uint32_t	cache_level;
>  	uint32_t	flags;
>  	/* Indicates how many Compute Units share this cache
> -	 * Value = 1 indicates the cache is not shared
> +	 * within a SA. Value = 1 indicates the cache is not shared
>  	 */
>  	uint32_t	num_cu_shared;
>  };
> @@ -69,7 +69,6 @@ static struct kfd_gpu_cache_info kaveri_cache_info[] = {
>  				CRAT_CACHE_FLAGS_DATA_CACHE |
>  				CRAT_CACHE_FLAGS_SIMD_CACHE),
>  		.num_cu_shared = 1,
> -
[KR] Unrelated whitespace removal

 Kent

>  	},
>  	{
>  		/* Scalar L1 Instruction Cache (in SQC module) per bank */
> @@ -126,9 +125,6 @@ static struct kfd_gpu_cache_info carrizo_cache_info[] = {
>  	/* TODO: Add L2 Cache information */
>  };
> 
> -/* NOTE: In future if more information is added to struct kfd_gpu_cache_info
> - * the following ASICs may need a separate table.
> - */
>  #define hawaii_cache_info kaveri_cache_info
>  #define tonga_cache_info carrizo_cache_info
>  #define fiji_cache_info  carrizo_cache_info
> @@ -136,13 +132,562 @@ static struct kfd_gpu_cache_info carrizo_cache_info[] = {
>  #define polaris11_cache_info carrizo_cache_info
>  #define polaris12_cache_info carrizo_cache_info
>  #define vegam_cache_info carrizo_cache_info
> -/* TODO - check & update Vega10 cache details */
> -#define vega10_cache_info carrizo_cache_info
> -#define raven_cache_info carrizo_cache_info
> -#define renoir_cache_info carrizo_cache_info
> -/* TODO - check & update Navi10 cache details */
> -#define navi10_cache_info carrizo_cache_info
> -#define vangogh_cache_info carrizo_cache_info
> +
> +/* NOTE: L1 cache information has been updated and L2/L3
> + * cache information has been added for Vega10 and
> + * newer ASICs. The unit for cache_size is KiB.
> + * In future,  check & update cache details
> + * for every new ASIC is required.
> + */
> +
> +static struct kfd_gpu_cache_info vega10_cache_info[] = {
> +	{
> +		/* TCP L1 Cache per CU */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 1,
> +	},
> +	{
> +		/* Scalar L1 Instruction Cache per SQC */
> +		.cache_size = 32,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_INST_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 3,
> +	},
> +	{
> +		/* Scalar L1 Data Cache per SQC */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 3,
> +	},
> +	{
> +		/* L2 Data Cache per GPU (Total Tex Cache) */
> +		.cache_size = 4096,
> +		.cache_level = 2,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 16,
> +	},
> +};
> +
> +static struct kfd_gpu_cache_info raven_cache_info[] = {
> +	{
> +		/* TCP L1 Cache per CU */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 1,
> +	},
> +	{
> +		/* Scalar L1 Instruction Cache per SQC */
> +		.cache_size = 32,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_INST_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 3,
> +	},
> +	{
> +		/* Scalar L1 Data Cache per SQC */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 3,
> +	},
> +	{
> +		/* L2 Data Cache per GPU (Total Tex Cache) */
> +		.cache_size = 1024,
> +		.cache_level = 2,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 11,
> +	},
> +};
> +
> +static struct kfd_gpu_cache_info renoir_cache_info[] = {
> +	{
> +		/* TCP L1 Cache per CU */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 1,
> +	},
> +	{
> +		/* Scalar L1 Instruction Cache per SQC */
> +		.cache_size = 32,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_INST_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 3,
> +	},
> +	{
> +		/* Scalar L1 Data Cache per SQC */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 3,
> +	},
> +	{
> +		/* L2 Data Cache per GPU (Total Tex Cache) */
> +		.cache_size = 1024,
> +		.cache_level = 2,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 8,
> +	},
> +};
> +
> +static struct kfd_gpu_cache_info vega12_cache_info[] = {
> +	{
> +		/* TCP L1 Cache per CU */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 1,
> +	},
> +	{
> +		/* Scalar L1 Instruction Cache per SQC */
> +		.cache_size = 32,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_INST_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 3,
> +	},
> +	{
> +		/* Scalar L1 Data Cache per SQC */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 3,
> +	},
> +	{
> +		/* L2 Data Cache per GPU (Total Tex Cache) */
> +		.cache_size = 2048,
> +		.cache_level = 2,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 5,
> +	},
> +};
> +
> +static struct kfd_gpu_cache_info vega20_cache_info[] = {
> +	{
> +		/* TCP L1 Cache per CU */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 1,
> +	},
> +	{
> +		/* Scalar L1 Instruction Cache per SQC */
> +		.cache_size = 32,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_INST_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 3,
> +	},
> +	{
> +		/* Scalar L1 Data Cache per SQC */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 3,
> +	},
> +	{
> +		/* L2 Data Cache per GPU (Total Tex Cache) */
> +		.cache_size = 8192,
> +		.cache_level = 2,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 16,
> +	},
> +};
> +
> +static struct kfd_gpu_cache_info aldebaran_cache_info[] = {
> +	{
> +		/* TCP L1 Cache per CU */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 1,
> +	},
> +	{
> +		/* Scalar L1 Instruction Cache per SQC */
> +		.cache_size = 32,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_INST_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 2,
> +	},
> +	{
> +		/* Scalar L1 Data Cache per SQC */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 2,
> +	},
> +	{
> +		/* L2 Data Cache per GPU (Total Tex Cache) */
> +		.cache_size = 8192,
> +		.cache_level = 2,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 14,
> +	},
> +};
> +
> +static struct kfd_gpu_cache_info navi10_cache_info[] = {
> +	{
> +		/* TCP L1 Cache per CU */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 1,
> +	},
> +	{
> +		/* Scalar L1 Instruction Cache per SQC */
> +		.cache_size = 32,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_INST_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 2,
> +	},
> +	{
> +		/* Scalar L1 Data Cache per SQC */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 2,
> +	},
> +	{
> +		/* GL1 Data Cache per SA */
> +		.cache_size = 128,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 10,
> +	},
> +	{
> +		/* L2 Data Cache per GPU (Total Tex Cache) */
> +		.cache_size = 4096,
> +		.cache_level = 2,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 10,
> +	},
> +};
> +
> +static struct kfd_gpu_cache_info vangogh_cache_info[] = {
> +	{
> +		/* TCP L1 Cache per CU */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 1,
> +	},
> +	{
> +		/* Scalar L1 Instruction Cache per SQC */
> +		.cache_size = 32,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_INST_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 2,
> +	},
> +	{
> +		/* Scalar L1 Data Cache per SQC */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 2,
> +	},
> +	{
> +		/* GL1 Data Cache per SA */
> +		.cache_size = 128,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 8,
> +	},
> +	{
> +		/* L2 Data Cache per GPU (Total Tex Cache) */
> +		.cache_size = 1024,
> +		.cache_level = 2,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 8,
> +	},
> +};
> +
> +static struct kfd_gpu_cache_info navi14_cache_info[] = {
> +	{
> +		/* TCP L1 Cache per CU */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 1,
> +	},
> +	{
> +		/* Scalar L1 Instruction Cache per SQC */
> +		.cache_size = 32,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_INST_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 2,
> +	},
> +	{
> +		/* Scalar L1 Data Cache per SQC */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 2,
> +	},
> +	{
> +		/* GL1 Data Cache per SA */
> +		.cache_size = 128,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 12,
> +	},
> +	{
> +		/* L2 Data Cache per GPU (Total Tex Cache) */
> +		.cache_size = 2048,
> +		.cache_level = 2,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 12,
> +	},
> +};
> +
> +static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
> +	{
> +		/* TCP L1 Cache per CU */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 1,
> +	},
> +	{
> +		/* Scalar L1 Instruction Cache per SQC */
> +		.cache_size = 32,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_INST_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 2,
> +	},
> +	{
> +		/* Scalar L1 Data Cache per SQC */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 2,
> +	},
> +	{
> +		/* GL1 Data Cache per SA */
> +		.cache_size = 128,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 10,
> +	},
> +	{
> +		/* L2 Data Cache per GPU (Total Tex Cache) */
> +		.cache_size = 4096,
> +		.cache_level = 2,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 10,
> +	},
> +	{
> +		/* L3 Data Cache per GPU */
> +		.cache_size = 128*1024,
> +		.cache_level = 3,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 10,
> +	},
> +};
> +
> +static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
> +	{
> +		/* TCP L1 Cache per CU */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 1,
> +	},
> +	{
> +		/* Scalar L1 Instruction Cache per SQC */
> +		.cache_size = 32,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_INST_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 2,
> +	},
> +	{
> +		/* Scalar L1 Data Cache per SQC */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 2,
> +	},
> +	{
> +		/* GL1 Data Cache per SA */
> +		.cache_size = 128,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 10,
> +	},
> +	{
> +		/* L2 Data Cache per GPU (Total Tex Cache) */
> +		.cache_size = 3072,
> +		.cache_level = 2,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 10,
> +	},
> +	{
> +		/* L3 Data Cache per GPU */
> +		.cache_size = 96*1024,
> +		.cache_level = 3,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 10,
> +	},
> +};
> +
> +static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
> +	{
> +		/* TCP L1 Cache per CU */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 1,
> +	},
> +	{
> +		/* Scalar L1 Instruction Cache per SQC */
> +		.cache_size = 32,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_INST_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 2,
> +	},
> +	{
> +		/* Scalar L1 Data Cache per SQC */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 2,
> +	},
> +	{
> +		/* GL1 Data Cache per SA */
> +		.cache_size = 128,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 8,
> +	},
> +	{
> +		/* L2 Data Cache per GPU (Total Tex Cache) */
> +		.cache_size = 2048,
> +		.cache_level = 2,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 8,
> +	},
> +	{
> +		/* L3 Data Cache per GPU */
> +		.cache_size = 32*1024,
> +		.cache_level = 3,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 8,
> +	},
> +};
> 
>  static void kfd_populated_cu_info_cpu(struct kfd_topology_device *dev,
>  		struct crat_subtype_computeunit *cu)
> @@ -544,7 +1089,7 @@ int kfd_parse_crat_table(void *crat_image, struct list_head
> *device_list,
>  }
> 
>  /* Helper function. See kfd_fill_gpu_cache_info for parameter description */
> -static int fill_in_pcache(struct crat_subtype_cache *pcache,
> +static int fill_in_l1_pcache(struct crat_subtype_cache *pcache,
>  				struct kfd_gpu_cache_info *pcache_info,
>  				struct kfd_cu_info *cu_info,
>  				int mem_available,
> @@ -597,6 +1142,70 @@ static int fill_in_pcache(struct crat_subtype_cache *pcache,
>  	return 1;
>  }
> 
> +/* Helper function. See kfd_fill_gpu_cache_info for parameter description */
> +static int fill_in_l2_l3_pcache(struct crat_subtype_cache *pcache,
> +				struct kfd_gpu_cache_info *pcache_info,
> +				struct kfd_cu_info *cu_info,
> +				int mem_available,
> +				int cache_type, unsigned int cu_processor_id)
> +{
> +	unsigned int cu_sibling_map_mask;
> +	int first_active_cu;
> +	int i, j, k;
> +
> +	/* First check if enough memory is available */
> +	if (sizeof(struct crat_subtype_cache) > mem_available)
> +		return -ENOMEM;
> +
> +	cu_sibling_map_mask = cu_info->cu_bitmap[0][0];
> +	cu_sibling_map_mask &=
> +		((1 << pcache_info[cache_type].num_cu_shared) - 1);
> +	first_active_cu = ffs(cu_sibling_map_mask);
> +
> +	/* CU could be inactive. In case of shared cache find the first active
> +	 * CU. and incase of non-shared cache check if the CU is inactive. If
> +	 * inactive active skip it
> +	 */
> +	if (first_active_cu) {
> +		memset(pcache, 0, sizeof(struct crat_subtype_cache));
> +		pcache->type = CRAT_SUBTYPE_CACHE_AFFINITY;
> +		pcache->length = sizeof(struct crat_subtype_cache);
> +		pcache->flags = pcache_info[cache_type].flags;
> +		pcache->processor_id_low = cu_processor_id
> +					 + (first_active_cu - 1);
> +		pcache->cache_level = pcache_info[cache_type].cache_level;
> +		pcache->cache_size = pcache_info[cache_type].cache_size;
> +
> +		/* Sibling map is w.r.t processor_id_low, so shift out
> +		 * inactive CU
> +		 */
> +		cu_sibling_map_mask =
> +			cu_sibling_map_mask >> (first_active_cu - 1);
> +		k = 0;
> +		for (i = 0; i < cu_info->num_shader_engines; i++) {
> +			for (j = 0; j < cu_info->num_shader_arrays_per_engine;
> +				j++) {
> +				pcache->sibling_map[k] =
> +				 (uint8_t)(cu_sibling_map_mask & 0xFF);
> +				pcache->sibling_map[k+1] =
> +				 (uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
> +				pcache->sibling_map[k+2] =
> +				 (uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
> +				pcache->sibling_map[k+3] =
> +				 (uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
> +				k += 4;
> +				cu_sibling_map_mask =
> +					cu_info->cu_bitmap[i % 4][j + i / 4];
> +				cu_sibling_map_mask &= (
> +				 (1 << pcache_info[cache_type].num_cu_shared)
> +				 - 1);
> +			}
> +		}
> +		return 0;
> +	}
> +	return 1;
> +}
> +
>  /* kfd_fill_gpu_cache_info - Fill GPU cache info using kfd_gpu_cache_info
>   * tables
>   *
> @@ -624,6 +1233,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>  	int mem_available = available_size;
>  	unsigned int cu_processor_id;
>  	int ret;
> +	unsigned int num_cu_shared;
> 
>  	switch (kdev->device_info->asic_family) {
>  	case CHIP_KAVERI:
> @@ -663,12 +1273,21 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>  		num_of_cache_types = ARRAY_SIZE(vegam_cache_info);
>  		break;
>  	case CHIP_VEGA10:
> +		pcache_info = vega10_cache_info;
> +		num_of_cache_types = ARRAY_SIZE(vega10_cache_info);
> +		break;
>  	case CHIP_VEGA12:
> +		pcache_info = vega12_cache_info;
> +		num_of_cache_types = ARRAY_SIZE(vega12_cache_info);
> +		break;
>  	case CHIP_VEGA20:
>  	case CHIP_ARCTURUS:
> +		pcache_info = vega20_cache_info;
> +		num_of_cache_types = ARRAY_SIZE(vega20_cache_info);
> +		break;
>  	case CHIP_ALDEBARAN:
> -		pcache_info = vega10_cache_info;
> -		num_of_cache_types = ARRAY_SIZE(vega10_cache_info);
> +		pcache_info = aldebaran_cache_info;
> +		num_of_cache_types = ARRAY_SIZE(aldebaran_cache_info);
>  		break;
>  	case CHIP_RAVEN:
>  		pcache_info = raven_cache_info;
> @@ -680,12 +1299,24 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>  		break;
>  	case CHIP_NAVI10:
>  	case CHIP_NAVI12:
> +		pcache_info = navi10_cache_info;
> +		num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
> +		break;
>  	case CHIP_NAVI14:
> +		pcache_info = navi14_cache_info;
> +		num_of_cache_types = ARRAY_SIZE(navi14_cache_info);
> +		break;
>  	case CHIP_SIENNA_CICHLID:
> +		pcache_info = sienna_cichlid_cache_info;
> +		num_of_cache_types = ARRAY_SIZE(sienna_cichlid_cache_info);
> +		break;
>  	case CHIP_NAVY_FLOUNDER:
> +		pcache_info = navy_flounder_cache_info;
> +		num_of_cache_types = ARRAY_SIZE(navy_flounder_cache_info);
> +		break;
>  	case CHIP_DIMGREY_CAVEFISH:
> -		pcache_info = navi10_cache_info;
> -		num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
> +		pcache_info = dimgrey_cavefish_cache_info;
> +		num_of_cache_types = ARRAY_SIZE(dimgrey_cavefish_cache_info);
>  		break;
>  	case CHIP_VANGOGH:
>  		pcache_info = vangogh_cache_info;
> @@ -709,40 +1340,58 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>  	 */
> 
>  	for (ct = 0; ct < num_of_cache_types; ct++) {
> -		cu_processor_id = gpu_processor_id;
> -		for (i = 0; i < cu_info->num_shader_engines; i++) {
> -			for (j = 0; j < cu_info->num_shader_arrays_per_engine;
> -				j++) {
> -				for (k = 0; k < cu_info->num_cu_per_sh;
> -					k += pcache_info[ct].num_cu_shared) {
> -
> -					ret = fill_in_pcache(pcache,
> -						pcache_info,
> -						cu_info,
> -						mem_available,
> -						cu_info->cu_bitmap[i % 4][j + i / 4],
> -						ct,
> -						cu_processor_id,
> -						k);
> -
> -					if (ret < 0)
> -						break;
> -
> -					if (!ret) {
> -						pcache++;
> -						(*num_of_entries)++;
> -						mem_available -=
> -							sizeof(*pcache);
> -						(*size_filled) +=
> -							sizeof(*pcache);
> -					}
> -
> -					/* Move to next CU block */
> -					cu_processor_id +=
> -						pcache_info[ct].num_cu_shared;
> -				}
> -			}
> +	  cu_processor_id = gpu_processor_id;
> +	  if (pcache_info[ct].cache_level == 1) {
> +	    for (i = 0; i < cu_info->num_shader_engines; i++) {
> +	      for (j = 0; j < cu_info->num_shader_arrays_per_engine; j++) {
> +	        for (k = 0; k < cu_info->num_cu_per_sh;
> +		  k += pcache_info[ct].num_cu_shared) {
> +		  ret = fill_in_l1_pcache(pcache,
> +					pcache_info,
> +					cu_info,
> +					mem_available,
> +					cu_info->cu_bitmap[i % 4][j + i / 4],
> +					ct,
> +					cu_processor_id,
> +					k);
> +
> +		  if (ret < 0)
> +			break;
> +
> +		  if (!ret) {
> +				pcache++;
> +				(*num_of_entries)++;
> +				mem_available -= sizeof(*pcache);
> +				(*size_filled) += sizeof(*pcache);
> +		  }
> +
> +		  /* Move to next CU block */
> +		  num_cu_shared = ((k + pcache_info[ct].num_cu_shared) <=
> +					cu_info->num_cu_per_sh) ?
> +					pcache_info[ct].num_cu_shared :
> +					(cu_info->num_cu_per_sh - k);
> +		  cu_processor_id += num_cu_shared;
>  		}
> +	      }
> +	    }
> +	  } else {
> +			ret = fill_in_l2_l3_pcache(pcache,
> +				pcache_info,
> +				cu_info,
> +				mem_available,
> +				ct,
> +				cu_processor_id);
> +
> +			if (ret < 0)
> +				break;
> +
> +			if (!ret) {
> +				pcache++;
> +				(*num_of_entries)++;
> +				mem_available -= sizeof(*pcache);
> +				(*size_filled) += sizeof(*pcache);
> +			}
> +	  }
>  	}
> 
>  	pr_debug("Added [%d] GPU cache entries\n", *num_of_entries);
> --
> 2.25.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.or
> g%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Ckent.russell%40amd.com%7C53330de655544e41b01a08d8f2d0
> 90a7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637526324888770585%7CUn
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6Mn0%3D%7C1000&amp;sdata=TCbRNbJN3LGMyYt4miQgFb1lX56tZ4nAyNAf6R%2Blj2c
> %3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
