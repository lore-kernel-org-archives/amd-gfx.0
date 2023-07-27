Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6E8C001DC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 09:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7958910E551;
	Thu, 27 Jul 2023 09:30:19 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A16D10E551
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 09:30:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZlwPpk2PnRXkJPWFZqXsWj8JPKEDYlW9J+WkW2V1KM3QFvamUsuSChx4zK879y0DdmRHLSyUUk/aUvSG4nu1NowwHTtz2HfIz+zgjxP/jpMQsDtysLpA1ZhUkBJyIVh1fIB+JR08WreFnlIQ4SRY14/AFGy6165n1PpIus9J2EflKC1JbZHoCCRgfMQ/dPH4vj3isUoyGNhEo0857JvbrSFfSmvmTm8tDnPdGlp7yRiMhoRA76RD6IoXpxuzD2IPgARfqwkkXxJNLcy3cgHTy02PzNAcAnrwqQYiQhC0oMIRRLFmRdQdgLF7VH//BGyGG31G+P+tCvYzp0kW9BvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jat4cABKU0QqRbvRRVrJFV83m8KzDs1JX/1OtLAJj3U=;
 b=IZGmgTBhK8kgkzkisq1I9tHFbRC3hosEv9i3zHCoCpVNWjeEfzKyv9QL8+hO6wrOMzOq1hdpD/yv3csoVR0wcHptm5fZFfLSU0muHfWRdmIJv5J1pcZ2hTBqz/FwkJrhYSUgV+qDcVxt6A6DlLA0ZMqKvaj8bI+ZdwPcPLQOC5d02VeJFJRjaymiXOhn7Ime68R/5QP4IeDo/8CIGyYce3CTcChTfAPbF8XzDvaI6hwCvIiDqPfGTHaT67xgKyyWaBJwfeDKwyPYIjYkjXXN+sQ2CoqiBvxRET0/rbDLTqxL/mrCsx+2GutME0E3G/cb7TS+JpqtDaqdb3AdYK/yhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jat4cABKU0QqRbvRRVrJFV83m8KzDs1JX/1OtLAJj3U=;
 b=T0OFhOQT34blEx3vsFAs7qKN4lIczR+rnnYIbRLRVbXfmzR3u1GvWYRgAtnRKu7h3l5Hu48yGRTWOHiASl0SKZzXml6r430y8HmLPBTG2oMzPht0Bgx8s+YF3JHBcGeYttpkkBOm4WCae64kNqtS25ojkRK8r931kSrds+/vtPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 09:30:16 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 09:30:16 +0000
Message-ID: <c747870e-dbc4-8802-304e-241069efbdba@amd.com>
Date: Thu, 27 Jul 2023 11:30:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/radeon: Fix ENOSYS with better fitting error codes in
 radeon_gem.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
References: <20230726141636.2474263-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230726141636.2474263-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: f697a837-2ccd-4c2f-7066-08db8e8415b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: riPxD8cyl4n5IVPXOLB3gymBejXdM4s23RMAm0pEBbsnsVPck4Etu5hrKNdbvy3koxo6+MnJGB6yaK1pwqzswC/jkFPnr5quXlmCfZLpQazhDb2zYswtWPT2HD3aonrhWTnMqrxChaOAleXku7aNCav+lya1fp/qBg63l1OvFGjPK+9MH5SOmPBvq4UyiKJS09/TfN5TJ3xU0WukJQI4xT5QBjpKaPJIrfPxGtELczB0ml7+Gu2uaYVi8Xrbk1s08lP6eRzV/Iz7QZxmahv/U5Ntj27BlOPa+FAhdh6ufpHJKNU8tUs/RQdblcdVZa7hIV1UFqYbrcj5qRS4A/OQc23HVfhrwSa1CXyaP4FOEGOVfANGtU/QTSPMPMP+kBU8mW+ViUXusLG4zt2KAQGiVL5J0Rx2xN0WNRI6zy61s7yQjfNfkTjBIDlwghOcxOR+np5v605ShAhTi4do10TFrz2CxuJ4eLoNIPyCdxYt2GhLTvngJ/XwAPkNWRbzeJ0tK9jtpvfv2c9SGYxtGJuK0YT4aQyqR09f8nlgKlrCq4LEgt852oI5xjBL9Zw+aYchxEUzyUf7HJ2rsgAw1cwkSVTYKIKvdogCrcWz6PuS/2p6x5T9GwTN3t29JFn/Oe1vDdDaREblwJiGiXzid3AKrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(31686004)(110136005)(6666004)(6486002)(478600001)(6512007)(83380400001)(36756003)(31696002)(86362001)(66476007)(2906002)(2616005)(66574015)(66556008)(6506007)(186003)(66946007)(38100700002)(6636002)(4326008)(316002)(41300700001)(5660300002)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUZyNkhOcS9iUER4dlYzWFdIM0JVRzdUYVZya0RQbDNsSlI5T2xZVWd6dllo?=
 =?utf-8?B?dUgrT1hlR3Z6WE1oOE1jbTYrYzVsOWJueHl4M2NzenFVbE1BMU5EblFmVzkz?=
 =?utf-8?B?VHBJWlk1eStuZmx2T05pMXlneEF2bFZIQnNRZm1Pb21PZVJWRlJObzR0bUZM?=
 =?utf-8?B?RlhEcWtpNmx0QzBEUEd6NDlTREsxakExZmFSWmNPeDZ0VThVM0U5Y1o4Nk4w?=
 =?utf-8?B?L3c2MEVnQ2oxeE1UOWtOOWZDclNRREVPcVFSWnByTFlMMXlidmNKVG5hcElY?=
 =?utf-8?B?QWFmbk9FdE1DazJ2alFLV0lRbitYbGlSdVNQM09ONU9uRjdYWkFMMnZlQnJ5?=
 =?utf-8?B?WWlWcWxDOWZ5c294SXBmZm5KL2JmUEhseDN4MTdIT1MvOHEvTFRtaVV4VHh4?=
 =?utf-8?B?cWQ2ayt0UzcxdEl3aDUrVXZxUzFYT2xCZ3hDMlRZa2QwYWxQY2hLeXJSeWZu?=
 =?utf-8?B?K2NGY1JJMWxHbUZCaTNyOHhTZHRvY2FrRVZya216Si80dk1OU3FzYXg0NTFY?=
 =?utf-8?B?ZG0xbTh2NWNmWlpJQ0JaNm1wblpOeFpyYk9XOEpVUjhFRk1QaDhzYk5LRTBH?=
 =?utf-8?B?RllFSUltZFhkanVrQlBMbFFYbUhuU0FsUWFRbjJCbTNjdnc5eFBJNjczT1lG?=
 =?utf-8?B?RGV6V043RW1kY1Z5QXZNTjNOdjdGS0ZvcXlieWxSM2g1b1RuajdTYXBSWGFK?=
 =?utf-8?B?ZS9YWUNFMW5GTVltNXNPTkl0d3NMR1JKbS8yK1NzUzRoNEw1ZElKSGNlTVdM?=
 =?utf-8?B?Qmh0ZU0wZjAzV3pHemVvTGtBSzBrODNDbmpOWUpUaEdyTVhuZFZMYVFPKzJZ?=
 =?utf-8?B?eHB3UzdGbGlaWmM5MmFIMXdiNzdGdjl4L3hrdHkySmdXRmNKU05tZWdBL1dZ?=
 =?utf-8?B?NnFBTEt4THlzQlZKUi9nUmc0dytvWnJYaVFQV0JwNjFIVVlvUURUSXR2TGIr?=
 =?utf-8?B?K3BDWHVidDRJMUo3Ull2WXV3cFdqK3ZMWlg3WmhBei9HdXFSSDNtMEJQTkg0?=
 =?utf-8?B?aklhS29nWVowZWR1aTF4Y2wxTS9MbnpLejBmNlp1ZElMVm5aVldWVGhOckdy?=
 =?utf-8?B?UGpWczFPcG9mUjNWcWpocW5WMEkrb1hyMS9Uck5zZmdNSVN6VHJPMWxJL1Fq?=
 =?utf-8?B?UVg5eWN2Um1Jak5UZUtjTDBKVGJtZ2xVTytqd29MZlYwTGZtTHdrODZnMHJW?=
 =?utf-8?B?K1EwQTJCeHRTOU10cHZucjlkVWY5U3Y0VDRXdzJlWmhEeGVhVTN6ZWxxb1Ur?=
 =?utf-8?B?bXRoZW01VkFrMUw2bkc4YnQxbFN5dWNoV2ZKNXdEWXdpVFpPb3Z0UVk1SGRK?=
 =?utf-8?B?eDdIaU1TTlBpbTJ3Qks3L1NCYis0cEszQ3haRlZWM0FqQ0hqMm02VGxaMVgv?=
 =?utf-8?B?Q0I2NGpCdDIxYXdqOVpnRzNlVXNVUkpyVUFtR0ZpNkRMcUVPVy9TQ3VacDVM?=
 =?utf-8?B?V0hsTzhWek5WVWlOa29Sb2NETXMralJtTnUrRDB5QTVRZ0p5S0QrOVh2MWpk?=
 =?utf-8?B?ZWlZSGtpY1MxekxPYlN5N3doVXJnM1Z6ajVsRzFFME1LUVBTN3JJL21zbkt1?=
 =?utf-8?B?bGNSbkwyNnpSbElDSEcwTFRSTW9BOHh4aGhiQUZxTWtwNnZPbnhFR1lka2ZY?=
 =?utf-8?B?cEk2OVkwd2llYTUwRjFjQUxjM1FDUU1yenJWaGV6RmNxZDRaSDZmTzZYejBI?=
 =?utf-8?B?ZDgvZXZ2cklxbFJrTWZyeHB0TUg1M2s3ODRXMUFxcnBmNnFGSW1yTUZjYWJC?=
 =?utf-8?B?OXpObFVrUTRTMzZxYWkzZjRKWWRWZmpCR3ppM0R5bzlVT3o2bzRIWXJwaEFx?=
 =?utf-8?B?ZVVENTR4S3Zyc2wrYU9BektZSndtYUEzek03dUQ1V1V4Mk5ETXpHdnl0WEN2?=
 =?utf-8?B?VEFTNjBSYzVpclhDM3RtZnZXdDV3RTVEejdMaCt3VmNKLzk3VzMvc3pNVFlx?=
 =?utf-8?B?czMwS1Z0bVlsT3ZyWGdDNlI4UFNteTA3OEE5QkZkaXVBTlVYNFN1QVBrcVhx?=
 =?utf-8?B?dnJiRjJUbFY1NmFmZGR4emRsSUF1MU4zNVM0MXJFUFl5SWo0ZDV2QlNYZWVr?=
 =?utf-8?B?aTlnOXdzMmVQWHVlTkRvYnN1c2VITklOZ0VROFhOcmhsa2x3RHNIcGpDTkkw?=
 =?utf-8?B?RUNiaGIwV21ram9nRThRcWNQWktuN2gxUnJKVU00LytmVE1WMlordDBNVEJ4?=
 =?utf-8?Q?j6FiTctRZ44QD8Qle/pSpzM8dIJcJ6x9cijMu6tBcVeU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f697a837-2ccd-4c2f-7066-08db8e8415b3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 09:30:15.6742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJjm0STT/Y570VmS5j2INeW282ixgJEReC4rolTBllisJWyHJzxbUM+X+RdTsKZd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.07.23 um 16:16 schrieb Srinivasan Shanmugam:
> Replace the error code from 'ENOSYS' to 'EOPNOTSUPP' for unimplemented
> radeon_gem_pread_ioctl & radeon_gem_pwrite_ioctl
>
> Fixes the following:
>
> WARNING: ENOSYS means 'invalid syscall nr' and nothing else.

Mhm, it might be better to just completely remove those.

They also allow an authorized client to spam the system logs.

Christian.

>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/radeon/radeon_gem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
> index d0119c5f7eb3..358d19242f4b 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -316,7 +316,7 @@ int radeon_gem_pread_ioctl(struct drm_device *dev, void *data,
>   {
>   	/* TODO: implement */
>   	DRM_ERROR("unimplemented %s\n", __func__);
> -	return -ENOSYS;
> +	return -EOPNOTSUPP;
>   }
>   
>   int radeon_gem_pwrite_ioctl(struct drm_device *dev, void *data,
> @@ -324,7 +324,7 @@ int radeon_gem_pwrite_ioctl(struct drm_device *dev, void *data,
>   {
>   	/* TODO: implement */
>   	DRM_ERROR("unimplemented %s\n", __func__);
> -	return -ENOSYS;
> +	return -EOPNOTSUPP;
>   }
>   
>   int radeon_gem_create_ioctl(struct drm_device *dev, void *data,

