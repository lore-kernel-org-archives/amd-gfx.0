Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26828C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 08:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEEA960F23
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 08:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CEEA960F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 865486EB0E;
	Wed, 22 Sep 2021 08:37:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C196EB0E
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 08:37:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hc/WmRQ8++Ab1GwxJXHriIcQG/nUGfcxB8yrzi7k3ocObj3WF1lHEEQzkLjNhG271+kBpWW6+ORQupkB/tUljYpOiv0iFboj3sJvCZsMH4UMJA0HziCZ9ECh2BE8eGQERdlAs88FdbQvZF2D6lPPygdt6go9pKYyJU5Do+cMg/dvEE8SHLzkslrofSU2tNriiO8nG2zdwuJuIsl9bA1ym3viot0SwHLbmnTUyUmdbm7rXbCgMUc9j4f0grnwGP9lkfU6ghv8VhZJjPfeuw47AAafbq+GfYA86rHNiXFga4RxkU+LIOIrezrXf46NNYPYmij+cRoVrQa5B2pwEaZgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=CVUvS5POk+Vy4r2cbEF+dyCQ0jUq5I7VgLsZ8SyY3Hw=;
 b=DSqYGSKgE56LFPRWx1JQX9SyDMXUc1rNTbLw36GWorly+z2ulf5dNwIQmmq4D6LRjWchpx1EvCanMLsq1EqmQGBsEhjc0/c6+nCDpnzAPqkAN5BMIryjXw44b5/5rQMWjOUYtEbML2H0HoGMiIsM4DvUk8SruuGN13oGxPA0W/aWyrqvdhwvio/cFxqR3qY1b883HjwMCC4QrBSg4vZ2WBBOM704M0tT5Xd4xUqbAJBIIHD+HBDjv1nmrR9olhulx9jc2xlCFHwHZBr53xvhdaYKtnm9dwqmI8dSaelUVmhMivglOi7gSUiFHZNf5TjGbhCTa5ckiABs6iG8ecJ7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVUvS5POk+Vy4r2cbEF+dyCQ0jUq5I7VgLsZ8SyY3Hw=;
 b=Y8hYGHTjhBAuS2SrxtA/WQQY/0BLXiMRhLBlfkfv9XO/oxJa/ew2whsBds8sjXu/fCmqupuHzWR2Z/2oGZB/hBotOwU88mJK+ne5INjqi8H6qaJDkiZTH6doO18Li4Fw2q9+A8qazNrREmgowJDJClDxDSfqsGxR311egiFU8II=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 08:36:58 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57%7]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 08:36:58 +0000
Subject: Re: [PATCH 52/66] drm/amdgpu: store all instances of IPs in the IP
 version table
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-53-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <a79eb161-0076-0644-7165-9c9bd209585e@amd.com>
Date: Wed, 22 Sep 2021 14:06:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210921180725.1985552-53-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::24) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 08:36:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbb8da95-0a4e-4b61-14a2-08d97da423e7
X-MS-TrafficTypeDiagnostic: DM5PR12MB2582:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25829710813DFFC70A8B18FC97A29@DM5PR12MB2582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FZR8bUh6aeSAp+FDT7qmHIGC7RWprk8mh05WD5xJnAbPDJiKX4OoPmXL2BgX02lQsKTVlRGi8uBKUVWC2ZH0Rg3s+LxYgloCrxWH0MkGl5Nbn112eRfczptOyyowSZQ+WhxsBJd1TknWS+nKM8S10V9xnSG0gGhDvMtIyx3UBPbBO1YBKFwYeX+fusBz0uh3YQf9YF3x4g3Nv6oBTOMK6Ii6lz+bjQv3/ZsrLhNar4oszzL7bJz4Nj0a8gsxZQH32kqS8/cWR6Ek/si08CXbNDjKqJ7RRfCjlqn62eeIIG3nIJTZrluWzj0xH6q3F6hAOX1kU2dH6bNOC/jBp/v5eucsgBKGbgdYfdFTTDaQoOnXUmINvn7rTgKVvEz2fQ7Deu+HXXBbO79PqaMD+OVDtnOZ/Zc1/pknoP62KKnKtTWsvy1URTB7h6H0T0NF6hgc4QUfp+VwJB8T8KyN9pyI/OWTfnkIEHexOSgs2CWg+IEwXApbxJtmhzDVMvGh8tJ5Br1ajgMr01HPRUrCvDeixJXwFKJClubUn45AvJy3KLiaMLcnWELE1ikUZQDjqoXmJWwjg6mGPSUmX8MJwHh9DMkGVb4nPPlmRWrXoiVrJ+OAffBN4VzP+aIX5v88R0hDkZLBFH7nW81t+qpbvlsrKgXe0RKhD3qrMrOcFGSkxfbYmCSyeSy1hHvzznMEzEtp5A7skn9RUOC1pwwOJJhkFSMkhDGvS6j4sEkOvVDXD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(508600001)(31696002)(316002)(31686004)(66946007)(66476007)(66556008)(38100700002)(86362001)(956004)(2616005)(53546011)(16576012)(6486002)(83380400001)(5660300002)(26005)(8676002)(6666004)(36756003)(8936002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXZnVVBGSzUwNkt3WUVaYmtOTFdhUjRuaUVyblJjSndwNXFEMHYxc3NQWXNX?=
 =?utf-8?B?RWxBblBpN29mLzk0b01RVnN3ZDI4aW9SZkl4aEVpU3E0MWp2Z2FaV25YUlFN?=
 =?utf-8?B?NDhGaERyU0pRN2s0YkRPaXpBcXNHelFLZ0lVa1dqbFpmTE83Z3lhWE9Ob1R2?=
 =?utf-8?B?L1dEck1tZ2I2V2xQbzJnQlNyUk9ZNEhTbzNvWVhJNGpqOWhhdGtSMFFDU09h?=
 =?utf-8?B?OVB4U3VodmdQcFgzZkxxbmtWM2IvZ3o3bndEcHg4ZnJoaVpka0YxSGpBYWha?=
 =?utf-8?B?Q3AzYU02VFRob3JYZXZtRURNUnBVS09vd3hkR1NWcm5lV0d2bnJHWWNGZE9l?=
 =?utf-8?B?RE1kdUkvK2VUZGFDNVJqOS85SVM5YmVjL2UwVkNsWGtDZ1BUdWo5ME9lZGVy?=
 =?utf-8?B?Q09xK2Y4bWsvWEVGb1lDTmJIRndrVGo5K0hkMDd4M2FPSEY0NGF1NzA5VUZp?=
 =?utf-8?B?SkNKeGI5Ti9tUEhJQ2lRalRsR241ZzRVdEJLbTJxMlRGN3RVTC9NWFhjb0J1?=
 =?utf-8?B?SzBxTy85YlhOdU8zSEZCb0JSRjRBRUYxVGNEUmNGaXBSUTZCNTlZRWE2d2d6?=
 =?utf-8?B?SkM2K2NNd3B4ZFdCY0xNYlN0SUZkTXErZWg4bGtSbTAyVU9oTHQva1NZeU5D?=
 =?utf-8?B?Y3VUVUxCNTQvRTVWVEF6MGhZUjh5dDRnb0pwY3lIbTlxR2MzZURwbFlSVHdz?=
 =?utf-8?B?YXFMd015SmtDS0FXRnZrblcrYU42K3puYVNLV09ZYnlSV1llOUNsaFFYV1pm?=
 =?utf-8?B?eFNmU0duRGtiRGptUUxJWHhBMHlnYlBST3d1cmRoM040ZzdzdlpNV09TVDUz?=
 =?utf-8?B?ZjhTaVRIYjgrbmJZdTlvSHY2R0g1VDYwMWhvRWtSekYwdDdPc0E5QzFsZGxT?=
 =?utf-8?B?Z2JuK04vOGE3OFl2QVRJU3RvdEFVRDRvY1NxQk85R01OQkJEa2lLaWU0b2t1?=
 =?utf-8?B?RjBQampabzUxMS9nWDAxMm5FTW5tQmtmRlp6OXZvZm11OUk2SzlTcG5McmZM?=
 =?utf-8?B?a0hNZVRLNFRhTDNKT1JkaGlMekJNMGJWemZJNzRka2RrZnpzZ0psNzVFenVC?=
 =?utf-8?B?NWlvVGVwT1hLYzhyZEsvNjRzdFBhNjBtNUJQdS9JWVZxTTZHeGtqV3B0Vk5M?=
 =?utf-8?B?eGVLOHVOZ3JyWGw3MTRhcjBLV3VUejZRNGl4cU1kZkNTMzIzTUYxb0ppM29F?=
 =?utf-8?B?MGN4N2k3aWNEY1NTbC9MRWNFWmFlT3ZvazQyaTJ1ME5xN09zeHNXQXAxWVRa?=
 =?utf-8?B?UUNhZkE5TmJQMm03aDN3SVE0dVR5RDFOVWMrM2dWTUZmYVNXZTZFQmlCZUNR?=
 =?utf-8?B?ZzdITXJiOVkvdy84eFpsSkh4NU9wUFdGNmh5bVU0azU1bW1NQ0dMeGZSemlh?=
 =?utf-8?B?SkJMcTd2dzZSektlczR0UUMwTktweHJadUpXcE9wUGdTeDY2dHZTdS96aDRC?=
 =?utf-8?B?dmFIYlJSeVZZS0xiU2ZQQnpLa3NDUUNTUzhDeFVUKzg3SGFwUGdrUFZOa28y?=
 =?utf-8?B?b2I0OU1YZS94anNZSmJiWS90azVvaUk1dE1YS094VVFhcXdWY3FVS0xFQi9M?=
 =?utf-8?B?VkVwOWJFYVhYYlovbmtkblNCZFk1ZWJNTWZmblVwMDZBUkd2aldtNmJxUlRm?=
 =?utf-8?B?RUVmZUFJVmZqeEI5MHQ1L1JyZm5WZ3FzVFVZRVNhSW5HSjFQS0QzNWovSURV?=
 =?utf-8?B?T2NPZ1ZTemN5d1cyVy9nMjRxSTI2Wlc4Z2xlcldoRTg5ZGZPNUZNNllvQUtw?=
 =?utf-8?Q?tvO2IuaSCl5st6ZHdFhRI//9AuV3ddScafzGTsD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb8da95-0a4e-4b61-14a2-08d97da423e7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 08:36:58.1949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBcTKUXjp7FvvOQyaBiAyiHNgpNGFGBPTTLcu9BJSLK6yn2pnnyc02cYRHpL+vWs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
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



On 9/21/2021 11:37 PM, Alex Deucher wrote:
> Use the instance to increment the entry in the table.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index e3b4578872f1..572a634f7a1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -364,8 +364,10 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   							hw_id_names[le16_to_cpu(ip->hw_id)]);
>   					adev->reg_offset[hw_ip][ip->number_instance] =
>   						ip->base_address;
> -					adev->ip_versions[hw_ip] =
> -						amdgpu_discovery_convert_version(ip->major, ip->minor, ip->revision);
> +					adev->ip_versions[hw_ip + ip->number_instance] =
> +						amdgpu_discovery_convert_version(ip->major,
> +										 ip->minor,
> +										 ip->revision);

There could be multiple instances with the same hardware id, right? For 
ex: SDMA in ARCT/ALDE. They don't have discovery table now, regardless 
does this hold good in such cases?

Thanks,
Lijo

>   				}
>   			}
>   
> 
