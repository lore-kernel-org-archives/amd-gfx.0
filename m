Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5BAEEAA5C
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 17:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2678610E298;
	Thu, 14 Sep 2023 17:24:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F4110E298
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 17:24:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf7HteiRfYDOKyA3+EUe/NKNblfmMl0yn3hw9Z4qCIe/y+E6tU1SLhk4bwMh0A67AxbS25N9ZqEhciNbD5V/FLszeFMkZwTRG3SJ6kwaFd2/eEOXiqUhvsKrP12NHDUHrd/1zX2ceurCoYXm9HVKm1AKdxZDhLxv+y/WDxLKDRc9fce8DOPsAqbVRGhToukpUCjKHuxeTRukhYnSvGruAlqelaa4bYAnNnbB/gZLHteqmZoYvZOXYmYtTiIwvRME6ON9UUomTOtqh9j7Naqcqmq3N0U8Ra2H3T2zGK2RHxIcrozkiGuSSSXR4/+iW0BrkwXQEG3uIoV8niBG/a1kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTo7ACuWURhYIuRtE1mXXpJL3tSf5WmVPR9+g2hkEgY=;
 b=XFq2ZplaQYpWmjcD0uCMQTLBMo+X4ABkR22oJibc8AW7heqYb9l453hqECQy9/eQIomtF6oeryeCQxAOukztsqnpk/LaahtLKfWjmPu8MGFqn8dPTSk+mQO1jxmfPQWkcAVQo+YTgxSruWP2YJ6ZCsYtY44FOzBH4f84L3R20tUPhkzPOPGNHCuxOfccAT+QszYnUHeqQ6e7iPAdabrJZnrsfpsfpBNzicnd1BGvySXEsvaOVnCS1R/IruUw4qAh/Ze3lvuk/45O1+qkebx1hCGygL/AKt9137vc62tIMP3pXWX/U8lOgJRYYMZ9lC+MJzytjF8hi1OtGoAfEff4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTo7ACuWURhYIuRtE1mXXpJL3tSf5WmVPR9+g2hkEgY=;
 b=gWXseTjjGuo18NiTsA6JTOgpxanY8zq1nWjYFI1z0EqxaPjhouqWKFak9AKyi1EMN8cwYqeWa2YiaDnjMcuzEVWb0dZL4clTCkvTJrFxoErsmCWnZhi2fTU7PXb303+2fkC1BaJJjNYTBSTf54EduQKonVnnRsbh8I8Yb+1kgTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Thu, 14 Sep
 2023 17:24:39 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 17:24:39 +0000
Message-ID: <2bf0fc75-0ee3-4ee1-678c-e7f26ce781dd@amd.com>
Date: Thu, 14 Sep 2023 13:24:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: Align unique_id format to match amdgpu
Content-Language: en-US
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230914170906.88487-1-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230914170906.88487-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::40) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH0PR12MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: e246952c-c9e7-48aa-8803-08dbb5477989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYv6BwMJyqOjlc721TR5DzLdyUGxXAo2frFv6kFwFloRZrM9NrB+w+hhtXraHwvsyOPchsZhkvolGskSH0qFy7BvgvVK44kkYZHCkVN5y1xBAhhQEGtQ/Yt9E7N2R0gvmfA8dkxErdILTedGEkB4DediAV7JKJeYqzENGkltCi8HGFBd+Ut6BU94wo2sIkLkrDE34b8reqYIhAydPkAgG0ONqYIVQlQAVLZqoiSGRbrzv5R/HomLB4svNEAd+x24E8YTSgSThRarHaNIWsr1dwoN4ir52x/LhWbm3xpWlTyE18YHZLdXZL7rKc22AZtpW+jBXL8SR8Q/AabsTLWW2rK09KjKhbxnH5wq8cHdfNmn3XJTrGpr139pIYVdktkCp1YwQEHIUadDie9eIoXyOXsseXMvdBLhl5znCVHejpjOThO08xEt/vzzZXh/KqeoxBypxIF/6dqQkKaGCGkm1r969ME1ilbSdw8aGnCCXqNwN0tzz613/iX2RLGGN6bL2/95qxm3C8qTKJjEp9LAy7FGzdK2ZVyNDUBqvgyAlh6W4TgumODxOWAfP2Ruz6Shz8S6z11Fmrp/HDT9ijfRaAdqr4ur9sghuOaFSJCx2RL2K8LyYozeCVp2rHANLJRR4srABI9IfazqraQAzqOjsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199024)(1800799009)(186009)(36756003)(31686004)(44832011)(5660300002)(83380400001)(6486002)(86362001)(31696002)(8676002)(8936002)(6506007)(36916002)(2616005)(6666004)(53546011)(41300700001)(26005)(6512007)(66476007)(66946007)(478600001)(38100700002)(2906002)(66556008)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWtGQ2I0Y25GK00wbGQ4amg2NGVacTQxalIwMlRMeVAxWHVvektBMktabnB3?=
 =?utf-8?B?NzJxdDlDVms1bmJHaUVmSlNzbDB3VjZMYXZPQjhHUHVpMXNIK2NFelozNEV6?=
 =?utf-8?B?MjJvVUt6QlVWcU8yam90MGVBRktoMXBGc28wRDNyNEl1SDdkZ3B6Vi8rY2Q0?=
 =?utf-8?B?SGgwYXhQUzhVZEhLMG12SjdVWjV4dEhkT0dGc2VSNGNBTFZvS3g3d080aDVv?=
 =?utf-8?B?dmRTVEdHMVY1czNCdkQrMEFKcXFhc2ZhSzZNNDFDRDhIK1V3QWpGa3B1M0lr?=
 =?utf-8?B?WVdIejJtOFZnTHdzK1EyL1RqbnhWWjl5RW1ncXdVQ1docHZIVktmOE9LeG1H?=
 =?utf-8?B?aWV0NFJSczNpeUEzcWREKytaYTZiTll3dWw0alJ6cjVJS0src05kZXFzVGpq?=
 =?utf-8?B?ZzBuTmFvNWdzM1ZhcGg1TlVZY1VoN1JCeUpnbVd0ejdpaHMvMDVDcEN1aG0x?=
 =?utf-8?B?V04yTWQ5dDRjYlRydlowZ1VLaS9MVVMxK0FReUJKT2Z3ZEhLTWV3TnJmN2lv?=
 =?utf-8?B?RG11cWRvU1FQdGNYMlU2UUk0UGNEa3lxSnNjTGs5dDdCZ3RVcWh0OVpvQjB3?=
 =?utf-8?B?eDJKN2ZYWHF4NlBQWnVEWUZORytJcG54MkQ2MDdyRzFINU9TZzJHZ0hnejFK?=
 =?utf-8?B?MHIzcGI0eGdQd011UkVGdzdZR0hMazcrbmRkRytBTGZmdWFyMHJFbWxYNkM3?=
 =?utf-8?B?dWZRNXducFBhWUlUVFNhU25ObmJFRlZJVTQ0Mlk0MVUycHZ1ckdEUlhuR2xv?=
 =?utf-8?B?UGxyR2J3MkJtdjl2SjI5bWs1dlh5aVVWVTZ1REhZK1dsUENrU0hxTXBhZnFz?=
 =?utf-8?B?V0R0UktVTk9UalJ6azAxaks3dHdZWXdFRTVYRzVETklDMUwxVFYzMERPekZG?=
 =?utf-8?B?WjFoZGNJL2dmbkJxaG5kQmhMdUt6N0NnNTlrRi9OL3dkaDJSeHE1M3R6M3Ro?=
 =?utf-8?B?WUJDcHR0cEdsQU9yaGp6N2RkanVEeldlYXFReTVPQnNDOE1sOUJ1R2ZsODlJ?=
 =?utf-8?B?OFhpd3hvOHVVMi9FMzVFaEFiSFZjVHhJR3U1WHRsRVZSM2liVTNBUW9KdWNi?=
 =?utf-8?B?SEIzby8vUVJlUXMrdEdybmVkK0UyNXdrVENPcUlTMjY4ZjRqekhHQy9kZTVF?=
 =?utf-8?B?cFBoUWx5cHBCZXJ4aFlZYWxFVDd3TGRxMHc3c2ZMSDFZcFhCVEE4N1FZR25l?=
 =?utf-8?B?WklxWTRJS2RxbHIrMk5rcmYzSnh0T3Z3WEI2c0JrKzBQN0tJOTQxRkFQK1lN?=
 =?utf-8?B?Q3ZQUHdkdExoSkdEdzYxMDlHT05ScTlTR3dnUW9BMXRudUEyeituTEg4c2Uw?=
 =?utf-8?B?RE1qcGN4RUdPVFdZOW94d1FtM3VOODNhMUlNREcxZ0kzeERNZ3Q5ekVNRUF1?=
 =?utf-8?B?cFJtRnRMN0hxUkZCVHBxZVcwNXBDa09PU3BKdXdadjJuci9qaWltU2lIY0JS?=
 =?utf-8?B?RVpsY3lnQzllU0hmTWtrQ0pQR0gyeE1rRWw5cVJvL3QvbFg3VDhqc1N5VFJI?=
 =?utf-8?B?UzRCTVhjQ0NuNDM2Zm5YT3dSTktLeVZJNHZ1TlA5YlFTQUo4K0FCMVJJNW0z?=
 =?utf-8?B?QU1YUnR3cUNPcmpYMXQ2bzVZbXJzdWVnb0RRbmp1bi9sR0tQQi9LM0ljbXBt?=
 =?utf-8?B?UUhRdEFOUjVDL2lCeGkzR2krdjBtV3NKNEc0a1dWeHhyN1lydmRXSUFZYWJm?=
 =?utf-8?B?TkpRdTZaQ0lzdjdvbk1OOGRSckI1ZEZxdndWTTBhdFpRK1BESVRIUlV1TmRn?=
 =?utf-8?B?Q1g0RmdqZE1KMlQ1dTI0b3dIL0FZdjRzNHZQMWY4R0Vza2RCYVdoUmprSWds?=
 =?utf-8?B?YitQNlN1dksyR1M1UmZCbTZNRFdqUWhWck5vYitVRE1HQ0ZwTXNKc2NBYSt5?=
 =?utf-8?B?OXVNYlk2TXgvcElxTmExd1Nzd1FHalZWb3dpK1NUdjlqWXRWVVdSaEVUdkZL?=
 =?utf-8?B?NURIVjJFQkFYUytmZnIvZisxbytBQUVhYmtNVWY3dGcrUFQyNFYvVGIvQ3Zv?=
 =?utf-8?B?TmlheDl1RTMxeEdZUk5YaElvOVlSZE5seVhZUEJaWW5LZkkrUjN5RDZtazFn?=
 =?utf-8?B?eXRnSEN6MEN0L2d4MGlFOU9Bc2czaHBmc09YalZnbVR1Q09CYlUyR213UkFl?=
 =?utf-8?Q?wJKyreKgAT0gVbn67rCpjNafU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e246952c-c9e7-48aa-8803-08dbb5477989
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 17:24:39.0989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKTvvxuy7ar8MfbwIkWiTqskDcaK2llASMuVH8yQ5r4af0rcNZMwMCBU+uFvmb5iLf2zWMy8vdTV9CFpkXTnqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5266
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


On 2023-09-14 13:09, Kent Russell wrote:
> unique_id is printed as %016llx in amdgpu, but %llu in KFD. Call the
> sysfs_show_gen_prop function directly and use the %016llx format, to
> align with amdgpu. Don't need to add a new macro since this is a one-off.

Doesn't this break the ABI? Any tool currently reading the unique ID 
would expect it to be decimal.

Regards,
   Felix


>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index c8c75ff7cea8..4dac29cdab20 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -538,7 +538,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>   				      dev->node_props.debug_prop);
>   		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
>   				      dev->gpu->kfd->sdma_fw_version);
> -		sysfs_show_64bit_prop(buffer, offs, "unique_id",
> +		sysfs_show_gen_prop(buffer, offs, "%s %016llx\n", "unique_id",
>   				      dev->gpu->adev->unique_id);
>   		sysfs_show_32bit_prop(buffer, offs, "num_xcc",
>   				      NUM_XCC(dev->gpu->xcc_mask));
