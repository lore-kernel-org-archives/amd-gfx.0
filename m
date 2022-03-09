Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4018C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 04:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C7710EAEC;
	Wed,  9 Mar 2022 04:46:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3513610EAEB
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 04:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0RgB6tNaxbSPwyaExH7yQcw7mdOj5IngwO3pgq3bZsIlYR6Za1nnnIU9sQHL8qu5j6WHXUdneJNkYDZpsY5CU3o+Lq4rE3n4DmZYrJWdxgBD9+mtwMxMM4AIoEHk9avaK4PlumkWL469zRQEXZpyTvhn9WdSXmqbtWkwgrGhWklSygdsrMViG2CJt5d4hSApZOhXnZUJYTOvjotm5CqAcvhURv4VWlikb+qh8vhTz31JmfUiHKDjEJUtaAMo0VazNvxwfCVwljLWeoUUrMaa38HUNQCvCksH9ZDlEU+c/LClR44E6XpAr4+1smfLcPmHuGQ6LKmUtykV+8TZA00tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10s7IEBnOKCdN4sFRLk0tfmJ7n7yOKyQ/GhARhdqojY=;
 b=Z6XK8iVrwwYsewhlOBtZotBNMpoy4xZnVvdCPOLSMbxNC4Ub+BeNpOPoV3S1bvMJQQtDTcjiTBKgPmfAbzMuORwy6zWQvrhnKNUOmyFc85xVR2Ard7OfLnalI8AdFtYR+kmTFju6g2ZS6yvSczOyTGHkVJMG5w6cHRQUxItlV6jwJW6dI0mOaF9z2ifcLzBKoCA4lkd2/JVJ8XVwmEb/mbwqAGyxrj6Jk+vVAQe6mqi736w4m7hkA1pM41j2b3QHohdKqWhNehlhuTky9BdI8JRr+casniZefm4Vie3n71o2pWAY9VPqO6unafUtZ4L9ejO2alkZm9fPlYySRoUh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10s7IEBnOKCdN4sFRLk0tfmJ7n7yOKyQ/GhARhdqojY=;
 b=FdAYLrPzmsEciTpUNZkWQ8DO2tsoF0qM9t4E5s1wGuhUt23Ta7lBj6XRqUbQ7YndCqgnHJ/DpjWoMaBkkRJLAqSaLexExqttvFfDdF1Q9ljjc2MEWaPIDgyUdix4EHtcy+6BdfiFtWlE2LSHUI5ukOTQXKlbpTmkHHqPwgkyxBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 04:46:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b030:b1ba:4eb2:7fb7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b030:b1ba:4eb2:7fb7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 04:46:07 +0000
Message-ID: <eb0e327b-8230-d7d8-968e-843b27219520@amd.com>
Date: Tue, 8 Mar 2022 23:46:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drm/amkfd: bail out early if no
 get_atc_vmid_pasid_mapping_info
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220309022242.2625842-1-yifan1.zhang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220309022242.2625842-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1578c16b-7365-405a-fdae-08da0187b985
X-MS-TrafficTypeDiagnostic: MW3PR12MB4521:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB45211A455A75994F3D00C7C4920A9@MW3PR12MB4521.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6b3FR7Nme3EFYxv3d9E2csl4tCUL2RLZXznF5oVboOLPDAy6Jdiih3Hh5cugW1FECHIY0j0z/uz66RiLLIgMT+7/AS60k8hYEmmpfqL7pkZGbWDlOfSXd7kVT4wUCQZub683b+mSM0kTKWydlPV6hhlnV1TsUFBrJhJwS+ucik3tBQqcoLN/yp1+cc4kxz4OwF38vrywI3Pzl47yht7Tpq5+vNTdderDbxurZPRy2rA5MNDB1tFPUH3Z89e9HsUIeyI5vxmBG7N2pd4COmZbBRpY/VbvqAb3Gwri+pw0ynyeNcHsV/+q65Z7BxPBdRCFHnnWuNTjEB5vRVtetTl8PRSskePPENaOifefgeM4FLHQzi/0SxagAvaBgBaGUY4vmEU80yIr6i40nvVCnT3wL9EG0xyS7hdMVgb9QTcle4Xj8bS0ESUCKByFRCrSsH5VOEA1Q9cXyt36iQD/IOua3Gn36ve5cX+vl7Oi5zD2YHPorVWbT9YjOJ8laVvPlihY+FKegTS0xqu1H5Xu+vDDjSNbwWPWun/8pePDNE2+VdL4YINNQGD+kvmCq6uxaDA9AaZL8aIdyJi0qe7RdMfEzhvJNqTg9Ep4L3imo7DtBn+02j0+UdT9UzRTrC9WI6zCXqgprdWDrCB/Oi8IsKICiV5FPnFYR5P3yv6n4s8ByvVtC+YAr9+Q08ehYntnE9GNz42zV4eEXWLg2ZQPiWQ6NHl8fv/OtM0RkXERCFkJmMt56y8wOfsfDjVQv/vAJv+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(6506007)(508600001)(2906002)(8936002)(6512007)(5660300002)(44832011)(86362001)(31696002)(316002)(2616005)(38100700002)(31686004)(8676002)(26005)(66476007)(66946007)(66556008)(4326008)(186003)(36756003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjZwbmpZakpNc25CWTk5RE9zSzltMjRYVlg0ZTRyRVdBSXFvNkNBTEFwUHNa?=
 =?utf-8?B?d1pyY0FzUDVvelFuT3poZVRuYmQxbmpJSkh5bWt1aFRQQlRoN1licXZ4ZGZC?=
 =?utf-8?B?a0VnSU12SlFzczRxamZLZFd5MDJtbStXWXVNOEpQYWVvdjd2STV4dUU2OHMv?=
 =?utf-8?B?RWw2WTNZUEYwZS9DclY5V2NwSGFBWHBURmNDRnZEUUd1UU8zYk1hTStabjV4?=
 =?utf-8?B?aEpxcnBONExuZnhwQkI3R3FTRjlLakxYaFNBekNER05kSFpTSjZPeFNURmx4?=
 =?utf-8?B?MktaQVB1d05wK28yOEh1Tm5ReXNqbTl1bUJWSGIzYlNGNE1NWnZKbzdVczRq?=
 =?utf-8?B?L1pVQmord3I1dEUyUFhtNUYvQVlhYTI0SVRTT0ZqN2dTaE5IaHZocFpBZUJS?=
 =?utf-8?B?Qnd1dVRYMkdteGVuRmovZDcwK05tZS8xbmdYUlIvaW1FQWtNT0JiK1JMbEMz?=
 =?utf-8?B?eG9RdlZOQktocHUwVWhPNWNzRmJBaVdpajVmV2hxd1o3czJFcGs2VVVQRXl5?=
 =?utf-8?B?VFp4UHBOdmxpdERSVXMzNmkxNFAwTkxEa0VUckdmeTRQVW4vbDZTSmd6Z25T?=
 =?utf-8?B?Q2NYbFdDTXMrM0kzUnJIczB2cGo5MEhrSGl2YjRtNTVWWUdzUUFGMWZESkdr?=
 =?utf-8?B?S3cvc05McmMyQmhLUzVnRW1aWFNUM1g4dFZSZkFuOVdGUGkyRjg4R1BybzRG?=
 =?utf-8?B?bU9TQnJDK2RoM1UwNHM0UU1kM1RVYXdVN0FwNHFvSDFOQ01sVE0zeHJNaVh1?=
 =?utf-8?B?b3g0WFFVZ09HdU5obGE0REV6d1NtcHV1NVlyUGdJT3FvQ3Y5N0hRRDFZbzdj?=
 =?utf-8?B?VWVobCtPeXp2eUVUajRjNWxiTTV1SHdacUtiSlpSTWV0ZVNyWHozSktXZlpv?=
 =?utf-8?B?RjJRTndmNGY2Mjhvb3RYZUIxRXZGUURDRG5zZkx4eEFKaUtzNlE5R3lIWXor?=
 =?utf-8?B?Ym1OOGlaUzVzMFUwUTVRNjBqVm82elc5eGs4SHRzdXhNSHBYeGlTUzRhWTJw?=
 =?utf-8?B?Nk8vUjN5UzlueFpsYzlta3poYU9ueHhHNE1WV1pzUjlGQm13c0RJM2xHOFhq?=
 =?utf-8?B?T051WUlZZWhYQk9TdDRkdlo0VkM3dUJOTXMreldubEFXTVIyU3lxaFRvRDV0?=
 =?utf-8?B?THpXUWNCVXM4M01qdysrMjJjK3ptOTl0MGZSSnpxdXZzTnJHVGFtdVZuZW9h?=
 =?utf-8?B?U3k1NUxRNlVRZFRxZkxaNFk4a1IxemFycmF2dCtsbU55VHlERmluZUhTVVJE?=
 =?utf-8?B?M3UwZVcxQ1J0WWMzSnE0Rzc5czBJaUwwOEhMZmNvMjdBS3RSWWYzNStPYTNq?=
 =?utf-8?B?aUtxWWRrR3JBdWFiOTg3amJmODZXenJ1bm1pOXRYNy9HM3psaHpVbHVHaTE3?=
 =?utf-8?B?U2paODZBTFh3blovNmZKMmlhNzVOMlV2RUxsMm5XWUN0YUlZamc0OFl5NVN0?=
 =?utf-8?B?ZlV2eEtiUUlTbng1OEpic1Z1WC9jc2N3R3BFVGN6NThYR0s0cGpYc3UrSHF4?=
 =?utf-8?B?S0xnbWpzcHZmeEJqT3BITjd6cEJyZ3plemhpbDB3aFNWK1FwbTNLS0RRcUV6?=
 =?utf-8?B?U3hGSE9OY0RkVDI3QUdYVzR6YUU4WmwvS29uZHh5QmVjQ20ybUxDdVFMUjJU?=
 =?utf-8?B?MzhBNU1DSERoTWI0aXArc0ZmblUrWWlkVlBtN0hkS1RKM3VBeHBEQ0dIWVhB?=
 =?utf-8?B?Q2JpSDBJT0Y2b2xrOExVVDFyejBNVXhXWHJkUWNTZ1M3NmhOM28ra0s5SGxI?=
 =?utf-8?B?WllJTXBKQ2cweDVIdUlwaFdMcVo5RzN4SUVsODl3aDU3L3E0V21vUlVqcWlU?=
 =?utf-8?B?SXVJcmZWVVJNTGRRa1dERFpOZGhJS0R1WldVcXlJaXl1cjgwZ0ExRkZuYVA4?=
 =?utf-8?B?QjA5WlFwQXBBZ3RDSnlhelBxTEw4ZlIrVGdOT1RrMmZwMFhnQ2NQSDZiQ0JQ?=
 =?utf-8?B?SmRFOEdBWEVYMnZqVHpFdEtrM0hadWl0VEZzc3p2ZkNoQWE0S3Bwc3AwUXpQ?=
 =?utf-8?B?empmczBhS2p0bW91ZExFb0lzci9WYjFLa0RtSmkyZUx6UVh3Mm5Db0xGVTJj?=
 =?utf-8?B?V0xFTWVTdEt2QnlrRjU3aGlGR3RUdjBuejYwWWx5SWxhdHJqRm5taEpYK0RO?=
 =?utf-8?B?UGVqQkZ1MisweWFMSGZnUlNseVBwT3kvY05XclFHbkZXTHVyVVV0Q2dRUjNu?=
 =?utf-8?Q?BGVSbX7e+Vdfj0Ts31n+IZk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1578c16b-7365-405a-fdae-08da0187b985
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 04:46:07.2531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xvru8/5Mgab6g3rEovRhdqJ3O6I6e85h5tUy3vdUU2Gtdw1uvKGUOz9RP+FqutCeNSEVsYJcY/kFNaZ3quO9NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
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
Cc: nathan@kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-03-08 um 21:22 schrieb Yifan Zhang:
> it makes no sense to continue with an undefined vmid.
>
> Fixes: d21bcfc01eb1 (drm/amdkfd: judge get_atc_vmid_pasid_mapping_info before call)
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Reported-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 21 +++++++++++--------
>   1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 77364afdc606..acf4f7975850 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -500,21 +500,24 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process
>   
>   	pr_debug("Killing all process wavefronts\n");
>   
> +	if (!dev->kfd2kgd->get_atc_vmid_pasid_mapping_info) {
> +		pr_err("no vmid pasid mapping supported \n");
> +		return -EOPNOTSUPP;
> +	}
> +
>   	/* Scan all registers in the range ATC_VMID8_PASID_MAPPING ..
>   	 * ATC_VMID15_PASID_MAPPING
>   	 * to check which VMID the current process is mapped to.
>   	 */
>   
> -	if (dev->kfd2kgd->get_atc_vmid_pasid_mapping_info) {
> -		for (vmid = first_vmid_to_scan; vmid <= last_vmid_to_scan; vmid++) {
> -			status = dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
> -					(dev->adev, vmid, &queried_pasid);
> +	for (vmid = first_vmid_to_scan; vmid <= last_vmid_to_scan; vmid++) {
> +		status = dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
> +				(dev->adev, vmid, &queried_pasid);
>   
> -			if (status && queried_pasid == p->pasid) {
> -				pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
> -						vmid, p->pasid);
> -				break;
> -			}
> +		if (status && queried_pasid == p->pasid) {
> +			pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
> +					vmid, p->pasid);
> +			break;
>   		}
>   	}
>   
