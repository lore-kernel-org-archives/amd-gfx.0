Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B055C76188
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 21:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD2D10E1F0;
	Wed,  5 Apr 2023 21:03:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2049C10E1F0
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 21:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUY9wKw9GAgxjj5EQ9/6xq57rV6L9xz4c5kSvS1lUI7VsDZBS+o7WCZRAhAYvZr2ItNxf2yhLlHRu2OqMYJBihjEwtNoMuff1HXHpsWFb6iKVrOexSgaILJxScUp6AKT3E4M2A+sxZBYn7lF59EiLkgvFENnT8dM7LV6D7y+OSlNo+q+Z5VwcoVfKIenaoStdJwQC9wCirUWli3wZdP7fc3fQmQzejdXMvGIUR8OZPxG48ZcbKzRst6OFPhLyO1Crg+hWth20wdS2684r2kX/3wJKeAYCEj3XTGQq1q5dBaOV6Y+cnxUfIVuKDnND3Appof6Fhg8H1tFOwYUxWJCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbL5geXVyzwf1pFJolvbqLN8VTHqGCsnvVvbQ/CUKtY=;
 b=n9yPKTML7kafjw5I8smagwzXhDJcpAGCny4rj6yWJFHq8kPST6VIldd2eUVCR2HCy4dadDtZDN7/2GDKoxZGfIwxzvzSIdko+EOUW8FOhMkE9pcTD3iu6X2bLbXLrCA8EJVJGWYQMk+XMUGU92tHx9kQRDYs0ir4BirTLUkbclkOa6BoqgzPAE2lfmOqk4l9zimN4zdbVnMixFBOFPS216O2GUBpdxUB53/yj/003k2l559eTLEciEGep/Iz+AzWlEG5LNAh9dLR5v2VGUjK49cr7O2BVaAxqd9rPHXJv5gPS/8vdf9R0EBCLl+fk0PhuScTCAGG9gJoYCZ1vK48kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbL5geXVyzwf1pFJolvbqLN8VTHqGCsnvVvbQ/CUKtY=;
 b=YCasdlGEjJc7xWEM2GuVRAfGQ2/3M6EYDsaNAd1ts7wsP4rg1d+bQ/v6E8Bkfo7/IN0H6ZYO21Vr5yzqrg1CX8hAS6a2hDjiUdBjZwIGCLukRV9J5QCpsD5H37cmm/RUNxzAAIjNAJ25gv4NArOi8tSIKvmfTseTLIEjyt5RjpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CH0PR12MB5090.namprd12.prod.outlook.com (2603:10b6:610:bd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.30; Wed, 5 Apr 2023 21:03:32 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 21:03:32 +0000
Message-ID: <76d4719d-b2dc-5f91-6f0f-252b6ed4b8b9@amd.com>
Date: Wed, 5 Apr 2023 17:03:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amdgpu: Fix warnings
Content-Language: en-CA
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230405094540.2935900-1-lijo.lazar@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20230405094540.2935900-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0427.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::18) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CH0PR12MB5090:EE_
X-MS-Office365-Filtering-Correlation-Id: a81d0016-15c5-4d8e-2c0a-08db361936c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Edb1AFqmzcdB0R6gnNKyu7Owal/4QIbBgM7Dfmc3YM8ez2Ha9X5EPGhqmR5UqP8BsTM3VG2D8wqYxPHcns9Rf1TRYD01IgEk9mS4l9MHS4x5xHhx9d/Y6Oo0RYfn/3MV1NFRjOTcQy3PctBs5JRag88bkT0/3jbWei8plvQmZoRwhPL9hgEuylWpKsaOoN0Bqjatja1LoHQM37WLAYVTKHiDeC4F0JSUn5XhR/po/HZphqfot1OQ+tLp3Uz8L2SHdi4749j6U7nifPM6JSQfTTlFyyzda0gxidQBxWvXu1NrZIMn/+f5i/qa5t2XmWjmfvtRbyuRPRUVkoPkbiir0pYieL2p45NbbBQIEnToIsEwkNpbFuqaqmWzBfrlR6n+lXQCzsg5eRtItb2ColjOEM7vO/HcbkidDBp/260ApP+B5YLYSl+3zVVJnp7QYxpnx1pU1dogjaYwZ1BLkgG+ACDr8VuJqkXCpfwsrQvzyZR6CGgBB+H2P2MxC097YawADwfNFGPNH//0Dd74ewFgizqkK5qN6v12fIV3aN67ITknRi/AATI+xF3PoDA6p9ArKB/oiP0v8jXinWYw6yaNGeTplCji8HaydCx5JEdncex5WQYRujYUHXAuqXR8HlFHq+FPzJ0GjoG/Z5fbXeRAcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199021)(31686004)(83380400001)(5660300002)(38100700002)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(44832011)(2616005)(41300700001)(2906002)(478600001)(86362001)(31696002)(186003)(316002)(36756003)(53546011)(6666004)(6506007)(6512007)(6486002)(966005)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDVnSzNrWktMNmN3N2xqNWhZOUUxMGt1UjRrUFJLdGhNRTgwYjI2cTRJaWpa?=
 =?utf-8?B?U012V1g4c1lzQlJ0TVEyVDJZSk1MZEE3dCtiRFRjckdYYzJJK255aVVMTXIz?=
 =?utf-8?B?MW1PTkhKZUpxb3EvNWV2eEg1akxDV0VYWGJVc3NaSTBQSmJDSGxROFArcGw1?=
 =?utf-8?B?NFo3ME1vcXZaL0xGMWFiWkRjZkErTDB3VUNJbExXTEpTVTVvVExwTHVqZkk2?=
 =?utf-8?B?aVZmU2pSWnFhMkJDTVBIMzZ2SWtFWnhwM08vbENqMkNjbERMRHFITHVjYkxQ?=
 =?utf-8?B?YkhtWDQ0NWFlb3hyZHp0Q3dUMjFrclRtdktEMTQyS0ZMbkpGbjV6SFBwaDJw?=
 =?utf-8?B?Z1pEampmT3k2TDNzMTBUMEhYMWRwV0YzK2JENmovMEU0OEkrN2RFNGNvZnNp?=
 =?utf-8?B?U0ZPTExsc0o1Y2RKSVVjcjBGOVNNRUpWMi9TV2tMT2JrdjN5ME02cloyejF4?=
 =?utf-8?B?SlN1ZkVQSmZ2alBCVmRnUkkybVkvWTZRU1JjR3lLZ3NmZVRkQ2JwVVhYdEJz?=
 =?utf-8?B?WGpwc3Yra3N2c2ZnR09EdEg1RTJDMUwvT3dRMG0rVXBrOVYvNE1rQzFIVWx0?=
 =?utf-8?B?RXRrQ1g5bXphV3p2TzRXVElrc0FDaGQ1YUpLdmd5RzNoMXA0dG9uSHBLbk9U?=
 =?utf-8?B?bzBmT3FLMXE5SXhLNlNYVlVPNEVFbDJTaTM0UWlydEZFcWQrR1RSM2lZQmp5?=
 =?utf-8?B?OElyOHVyL1hkNUIzRFBFVWpIbnQ2WVJ2ejIxeUpxNXdLdDMzZHgyVXFkODMy?=
 =?utf-8?B?TTB5aFpRNC9nNjd5VWVvc0xCaFpDazVWSDZYdmU5YVBqTVJKSzhUZjhKNSs5?=
 =?utf-8?B?aUdhclk1NDFZT1MrUjJmcjJ4Ym5ZaDkzc3dHdVUxVHlOUkZua1I5OUlKUVVM?=
 =?utf-8?B?UVpueXNNSEl2MW1xN1ljQnZZSGgrT3ZkaDgwdmhtUDN6OUQ3K1JtbG40L1c3?=
 =?utf-8?B?UjVrYnJnRkhUMTQxTDI0Rm1QUjl3eGVQdk1WQUpJRHFRaVFWUkl2K0hMSnpY?=
 =?utf-8?B?T1h2Q0EyclYwazEwdjNHRzFxMFhPeis2cEIxakdES2JnRE9YTU4rZnlCVU0y?=
 =?utf-8?B?bXZYMjVFa3FLUXA5WVZtS0NGUDVPelpTZ3ZOd05QeU9UK1FDL0RKazA4WmRO?=
 =?utf-8?B?OTNub0FUMkF0Y1d3L0NKVStxUm9LRGNWaHk0cEswTEJHb0kwNlMzRnEyVWRS?=
 =?utf-8?B?TUpVenNMWlZCZHl2VVcwNjB1U2NyVjlrWElYZllvRXBid29CNUdnQytncy9C?=
 =?utf-8?B?Ulk2ajRsOVBkNjZ2eEs4Uml6OHdiZ3RSRjEySUJtd09mWkNybktRY3BTWVpq?=
 =?utf-8?B?aFZQeHBaSDMrb0lqNDNuendtb2czNDVQZUtjU1A0eWptT2g2Q2lzRmRWQm1a?=
 =?utf-8?B?QklnMmVENEJSQjNqNEFQRnVRN0Z2MWRvMEpXdCt5S3hLMmZSSzFoS1AvV2RF?=
 =?utf-8?B?UjZnVTNzdThFcmk2c3J2dGVGWnlpTFdIelBkSXhUc2dST2w0ejFSNkZjWkN1?=
 =?utf-8?B?NHd5WGQ5L3ZJMDBZU1cwcUlJS3k4cjNWYU9BQTRkMm9IZDd5NmxPQWtwZFBp?=
 =?utf-8?B?Smt5dFlDTHB5Y0pRdmlCN2w1SXhnK3VQeVduNENWcGxadjA3MXExYmpXNnpG?=
 =?utf-8?B?dEZOdi9wdWh0WHFONlJma0NiSDFqd29OamE2dXBUaDFDbjRYMHBSM1RldjRL?=
 =?utf-8?B?dmxEZjJlNDhTc09oTTZQM253SUdIUXRvNXVpbHJVRmhBNURjeWE4NG5CQ1N3?=
 =?utf-8?B?RCtrMFBoUERKdStSMm12Z0swaFQ2U2xFN3ExcHZ1bTd5ZFdhVXJLSnU1UG9u?=
 =?utf-8?B?cmZTWWZ0TlkzcTVpb1BVNmgwS05xU3NGM3BpaHdabHgxUmRJN3pOcEZBUHBM?=
 =?utf-8?B?bFVqMjA4bFpzZmdrSWxNWStHZGUyUnNUNU9pWmx1cFdocUJuSUhlSTYzK0JW?=
 =?utf-8?B?VThJWjdSek0wVlJYTlFSR1BWc0E1Um9zdk52eFQvQy82QVR2TUZWWTFTSlps?=
 =?utf-8?B?VEZDakdYUVpvcys3enI5dkJPWmhHZWF3OERhbWlQakJ0ZmszR1BUSC9lZDJT?=
 =?utf-8?B?b0FtMENVckxQSHNzWkR5aUxyY0cwYk5Mbnczc1lHTW5ZYzFrWXFJV2N1aGY1?=
 =?utf-8?Q?sNA/YPZk2YZ+5+s1j3wfb8gJM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81d0016-15c5-4d8e-2c0a-08db361936c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 21:03:32.5925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+ef4Q1zM4R6crZimhnVsXgnIU1oFDbWI7CSypCuwN4At7avlrK24fqow/BMqdxO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5090
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
Cc: Alexander.Deucher@amd.com, kernel test robot <lkp@intel.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2023-04-05 05:45, Lijo Lazar wrote:
> Fix below warning due to incompatible types in conditional operator
> 
> ../pm/swsmu/smu13/smu_v13_0_6_ppt.c:315:17: sparse: sparse: incompatible
> types in conditional expression (different base types):
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303082135.NjdX1Bij-lkp@intel.com/
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index bbac4239ceb3..376d14de7602 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1241,7 +1241,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>  	((adev)->asic_funcs->flush_hdp ? (adev)->asic_funcs->flush_hdp((adev), (r)) : (adev)->hdp.funcs->flush_hdp((adev), (r)))
>  #define amdgpu_asic_invalidate_hdp(adev, r) \
>  	((adev)->asic_funcs->invalidate_hdp ? (adev)->asic_funcs->invalidate_hdp((adev), (r)) : \
> -	 ((adev)->hdp.funcs->invalidate_hdp ? (adev)->hdp.funcs->invalidate_hdp((adev), (r)) : 0))
> +	 ((adev)->hdp.funcs->invalidate_hdp ? (adev)->hdp.funcs->invalidate_hdp((adev), (r)) : (void)0))
>  #define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
>  #define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
>  #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))

