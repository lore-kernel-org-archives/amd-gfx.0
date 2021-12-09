Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C2EC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B90610E74A;
	Thu,  9 Dec 2021 16:53:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C4410E116
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 07:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQ5DsYcodPbeR0n3GgEsQauQpo1iORu/SS7ahHkKI0IFKoZa2IzprBzRX9f6D1sj/7Q1VGqk2Sf4Ya/ZsJ5IL7F4w6lHM2GzX9EVlCv/zo62+YRVhNTQJHv291lQN0tA4kAL5KRLpiDAztuNJ414nQ9ILjASpk46kjmBDuS0zZPI/dRH6EFUDbauMKfzDygLZV2Zzqv610VhVIpoa1IknVEo7iZ0h2NVl2DxORCXzyuhnE9WO3H40RPaFHhdgqBzSVTP1T4LqvuRwV5iATC8FHOcmXCkP2/tNlIOL8LCRF01bo3KXBbreaQyc2fl+MBv3BaVaHEUyn1OLoIK7aqdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKXR7H6cO9S/woIXIb8ER08ZQwXXqDWRLy5SC9Nu9cU=;
 b=fA+H10u65+scOUdLlWcRbHvNmj41TUEaG9be3tGyEH4OyGOpN35Ju2I22I/6d5CBC3g3hhYGo7i+YT53GKzaSyqxkl+1pF210n5AnTzhqUuH2VKKPF/lp0Sned9d+9zKCq0B0aBNsx+n6yu1ad+lJ76eqfkXmCJgKQERt2myXNG7G5ySlNgwFTfhTkPNo88unM2oC9Cq2szl+C2XYWaPXoG4xIc0mJqqkIIVBRHTrpOIh8rBKqrypSZKvAkMD+KFVBEPjmlyH8qD8nIU7/ORzQzJA66ZvjKQZC6k9tytBj1wtTTyykuz34rK4xgFrabQo0GpQN4ASCR1Q461pWlv/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKXR7H6cO9S/woIXIb8ER08ZQwXXqDWRLy5SC9Nu9cU=;
 b=uBbzW6Pp+UAGizMzt7IVfqSfokbEnnwHwnonAqsm1H336Qa0m7xN9wgoN5hO4ZdNylHCXqrEbZcXWQpDumPdiGlWiB4buCVH5IaoOotC5+Tffc+cMPLqFz5BHKKfS9feEGsTM6nL7CiuaP/mSg+YgmIPcyUZC6nqclYF+wjPcnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 07:04:58 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 07:04:58 +0000
Message-ID: <57d07f89-3469-8e39-d557-eb61675f34a2@amd.com>
Date: Thu, 9 Dec 2021 12:34:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] drm/amdgpu: fix incorrect VCN revision in SRIOV
Content-Language: en-US
To: Leslie Shi <Yuliang.Shi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211209052542.1163521-1-Yuliang.Shi@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211209052542.1163521-1-Yuliang.Shi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::20) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0548360c-f196-4367-2988-08d9bae235bd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB35953C4167E9662C68B079C697709@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0dokXtAJef+bfLUZmLxc/2epK/5BNBeFJLwYrucNrR8TjWGLM5Q4dy5E6xLNDstHncArWsQA73vl4TpSpVKpHpVorJMKVtpTuWGelweMnrP9Wchg3wIZDEZAL6hkcy00u5Tkn/bVtKJuEiOTOJWKCh6IxJgn2xjfXYYsp2AuiZ0am/oOl5WI1A5O+6w0cXXbKsGGXDDPPylok/D/MUP1mOiQ3Cvi09CGzBMsz7EzGB+n4bjEFW2MubFp5V6VeA8bo7SmcKjsk+0RaHUyoDedQXKEkc9VeGaB4CrBggabcImhhfayHNRsZO69T7K5X8Ny3LDcRJMOAswJrwRvZBZMbLjq2K1lAYxC2rZpn6V62A+zHdX52pbnGPwn57chIvJpppDyTM3elXYohejpcyijznDgtjErhCpHzNTmwrAiflidZhXMH5M2UH+Rby/7i2wXF8eYfzgL3JNgRyq5Qit2OGPZOjBowy3UWHZJiJqrdn1t4l837onjN2hv+GBqkEbRg1AaABcL8hXP7FAiwjqDxs8JIOjsOeT0Gr9QwIdZ7hw7VtQ1DYilBs4CLXKM7YtLgPS/Wi48dqq6g/NlSxXJBtzLAl7XBe2FLZWHEHy8r2vh8TQS0ksOEg2BNEXRICR9ZL1wKqU4LX2hz0WTsIGMD3w+OigxQ4u/xJhyKsvPcWLnU2OLm1ujDi4LmkVuALOCGvuXKnC7uzcoYCFAZw2vAk2mblMVNV4eZbAygswtffM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(6486002)(31686004)(86362001)(508600001)(5660300002)(83380400001)(6666004)(4326008)(6506007)(53546011)(8676002)(8936002)(38100700002)(26005)(66946007)(6512007)(66476007)(31696002)(186003)(2616005)(66556008)(316002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVRkMjlrQ3RPczRnUGx1cktRQk5xekpJNG1aOWpqRnNHUkdHTTBWTjhaMGx6?=
 =?utf-8?B?Nk5TZ2p3L3Fic3Y0cGVKTXBGRm5MWGpjTDl4WFBWZDIvdXdOemVJclpjK2dr?=
 =?utf-8?B?QU1iRGlzeVB5SFh6NUlmSjBQWG5Cb0VPUjRNa254UWVWQU52YVc3TnRYcXNU?=
 =?utf-8?B?NktXR0lDVndBVXI1TTYrSWFXMkZZa0dOQ0o1bmFJcS9tUGJ1UlFZTjZralg1?=
 =?utf-8?B?U2xIMVRpakRsZlFhN05iK1BBR0p3SjdwSkdBcm5nUTdGeXVwa0RPTTFnV1NB?=
 =?utf-8?B?WDZHa0kwL2gwYWd2YmlvSDVtaHN5bjIzUUVqdi9TRjRqUVFJUGJNRDZmQ0hK?=
 =?utf-8?B?dk12akRJc1lnbzR4d2RkT0ZTejNuaDBlVFpYM0JOdzRwM3Q2YzVvRW9IT1Z1?=
 =?utf-8?B?bVZjMEZlQ1lDMGdsODJ2YkNzbVZCRyttSFIzYWhwQWVFTG1EZDlFWGpsTSsv?=
 =?utf-8?B?UGZFSGU3dk96RTZkaHNWNTgwd2N0Q0Y5K2xNeUdHT3FjZGpEYXpMMk9rOEtC?=
 =?utf-8?B?ejRDRFRJMEJYeVIzdGI1eGlsalN4NklxTUdVUVhpaFNtN05VV3dETTdia3FZ?=
 =?utf-8?B?TEphRjhFcU5kajFoNVJYWEZudXFneStMdGZFbzZzY1NXSjFDMUZjRDBMMlZ5?=
 =?utf-8?B?UUhuMjVsb3VEZXc0RmhROGk3bjFDNmpPbzJQZmd6a3QzSi8rNHdkc0YyWXBN?=
 =?utf-8?B?bEo1OE9TUzJIZnZFQlBZdXpTZCtuUjlDcjUrMjVpay9SaEwrNncxRWdzMUFB?=
 =?utf-8?B?dFMzMStjNC9HQWd6L0o2MjFrTXlSeUJVdWFpdFYvQ0V2a2JOcmlpaXZ0UGdR?=
 =?utf-8?B?cEl4b1ZhTzd5ZlFuREFTd2xKZnJvZk0zOGZ2RlFOVHhkLzlGZ0pzbXZFcWFB?=
 =?utf-8?B?MDZiTU4rbC95OThTVThuQ1dnajE2d1dzZ0dFTmN4bE1peG81am9jemNuZHdm?=
 =?utf-8?B?enN2SzJRMzZkc1Q4aHFaNjFsblNFK3RhRnA3N1BTblA2TTVjZUl6bFhZZHpM?=
 =?utf-8?B?bzVpNWUxdEpIQ0Jkc3RaSTVaeDZRVWhaYitqNm5KWXkzTUxxRUNlM0lIQjZI?=
 =?utf-8?B?ZzZYSUwrWHl6R1hmblY3VlF2TnNxNGpYYVRkdTNhejVYM2p6UjZxQWNZcHR4?=
 =?utf-8?B?Wkdrb3RGYWZzekJER0lGaGMxREJsbFYwbHdGL1FpRitUY040UmVhNDFkek1U?=
 =?utf-8?B?RUFWVERTMGtkNmtGZTYwZktiWFQ0V2VFdW9JZGZoNC8vSmRweFFwM3hkaGha?=
 =?utf-8?B?bmMyaGUzWGFnZ3VkMTJJcnBtS2wydWxndnB1bDNyTzB6QmFXZHNkK1J0YU9h?=
 =?utf-8?B?eEgxTHZuM0N4aVdkL3VZMnJ0MEhNNURWS3FpV2s1TXVLTExvQTRKT0l2TWRz?=
 =?utf-8?B?WTdIaFVJNzVDcTFUT2tpNDdNTS9POVdjeWhycEkrNDZ0NVZxNXNMVjIzOXEx?=
 =?utf-8?B?UFFSSHNIVmVBV0NZY2dNSHNEcjRZa0l1QmVsd0pnSExvbUJya2lZbUJDTnFF?=
 =?utf-8?B?aUpiUXhKWkNNeW1IcW9FczNrZ05pd0dFaFlVKzZxQkg2emNBUFcrQ292bW9J?=
 =?utf-8?B?amxId01QdmxuVENrM1dYMEFMS0hjVFR3ZGRLOVpEdHJ0YWhHazMwaUQ1UDdW?=
 =?utf-8?B?N1phMVNEZkhUdW0zeWRGZmZ1MzVFRE9vM2QxREtOY0s1Zzd3U0NSS244TUdH?=
 =?utf-8?B?Ukd5TTNFd0NSSWt6Y21DU09KZFhXZnZlcnFJeVJhRE51T200NUJzcGx0Nmdh?=
 =?utf-8?B?YTdZYUcydzQ1QkFaY3RtbXhYWjlybGlNWXQydHN3U2NWVFpBMS93b0NFektV?=
 =?utf-8?B?YzRzZzUwRDN6VjBobklnMmFqTE5sYXBTS1pFb2x0bnNpYWxLS2ZJNzlsNjMv?=
 =?utf-8?B?OG5DNzdCeXI4QThPMXpkREhIbFFmcWhyNUIrK3ZpaU9teVdQZmthZ2RBbUlu?=
 =?utf-8?B?d2ptdjBMcENHaTdtbmhTaHQrTm5xTmhVYUMvT2Z0cU5pclorQWFHSWJwR0pV?=
 =?utf-8?B?SUpyK0pBQ2F5VjZXZ0xJbUI4R1doeDZ2M05OZWlzYW56WjMvKzlYVTdFNkRx?=
 =?utf-8?B?ODN6bmhkUkdDbFRsSVVRSXAyMjVkVFp6dURPR1hCSlB6SnBTZURWUUhtY1dO?=
 =?utf-8?Q?WZpk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0548360c-f196-4367-2988-08d9bae235bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 07:04:58.0628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZseLRHGSG587Q4NrqUgjAVYZ/4FXzpIPueLnwen5YrI/or8KI10iZDrqjLte2x1X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/9/2021 10:55 AM, Leslie Shi wrote:
> Guest OS will setup VCN instance 1 which is disabled as an enabled instance and
> execute initialization work on it, but this causes VCN ib ring test failure
> on the disabled VCN instance during modprobe:
> 
> amdgpu 0000:00:08.0: amdgpu: ring vcn_enc_1.0 uses VM inv eng 5 on hub 1
> amdgpu 0000:00:08.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on vcn_dec_0 (-110).
> amdgpu 0000:00:08.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on vcn_enc_0.0 (-110).
> [drm:amdgpu_device_delayed_init_work_handler [amdgpu]] *ERROR* ib ring test failed (-110).
> 
> v2: drop amdgpu_discovery_get_vcn_version and rename sriov_config to
> vcn_config
> 
> Fixes: 36b7d5646476 ("drm/amdgpu: handle SRIOV VCN revision parsing")
> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 13 +++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 15 ++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  2 +-
>   4 files changed, 8 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 552031950518..53ff1bbe8bd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -380,6 +380,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   				  ip->revision);
>   
>   			if (le16_to_cpu(ip->hw_id) == VCN_HWID) {
> +				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
> +					ip->revision & 0xc0;
> +
>   				if (amdgpu_sriov_vf(adev)) {
>   					/* SR-IOV modifies each VCN’s revision (uint8)

I guess, it's fair to remove the above two lines as well and keep the 
below logic also under common code.

Thanks,
Lijo
>   					 * Bit [5:0]: original revision value
> @@ -388,8 +391,6 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   					 *     0b10 : encode is disabled
>   					 *     0b01 : decode is disabled
>   					 */
> -					adev->vcn.sriov_config[adev->vcn.num_vcn_inst] =
> -						(ip->revision & 0xc0) >> 6;
>   					ip->revision &= ~0xc0;
>   				}
>   				adev->vcn.num_vcn_inst++;
> @@ -485,14 +486,6 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
>   	return -EINVAL;
>   }
>   
> -
> -int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_instance,
> -				     int *major, int *minor, int *revision)
> -{
> -	return amdgpu_discovery_get_ip_version(adev, VCN_HWID,
> -					       vcn_instance, major, minor, revision);
> -}
> -
>   void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>   {
>   	struct binary_header *bhdr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> index 0ea029e3b850..14537cec19db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -33,8 +33,6 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev);
>   int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
>                                       int *major, int *minor, int *revision);
>   
> -int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_instance,
> -				     int *major, int *minor, int *revision);
>   int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
>   int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 2658414c503d..38036cbf6203 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -284,20 +284,13 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>   bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
>   {
>   	bool ret = false;
> +	int vcn_config = adev->vcn.vcn_config[vcn_instance];
>   
> -	int major;
> -	int minor;
> -	int revision;
> -
> -	/* if cannot find IP data, then this VCN does not exist */
> -	if (amdgpu_discovery_get_vcn_version(adev, vcn_instance, &major, &minor, &revision) != 0)
> -		return true;
> -
> -	if ((type == VCN_ENCODE_RING) && (revision & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
> +	if ((type == VCN_ENCODE_RING) && (vcn_config & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
>   		ret = true;
> -	} else if ((type == VCN_DECODE_RING) && (revision & VCN_BLOCK_DECODE_DISABLE_MASK)) {
> +	} else if ((type == VCN_DECODE_RING) && (vcn_config & VCN_BLOCK_DECODE_DISABLE_MASK)) {
>   		ret = true;
> -	} else if ((type == VCN_UNIFIED_RING) && (revision & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
> +	} else if ((type == VCN_UNIFIED_RING) && (vcn_config & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
>   		ret = true;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 938a5ead3f20..5d3728b027d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -235,7 +235,7 @@ struct amdgpu_vcn {
>   
>   	uint8_t	num_vcn_inst;
>   	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
> -	uint8_t			 sriov_config[AMDGPU_MAX_VCN_INSTANCES];
> +	uint8_t			 vcn_config[AMDGPU_MAX_VCN_INSTANCES];
>   	struct amdgpu_vcn_reg	 internal;
>   	struct mutex		 vcn_pg_lock;
>   	struct mutex		vcn1_jpeg1_workaround;
> 
