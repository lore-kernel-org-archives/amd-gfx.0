Return-Path: <SRS0=ROs4=M4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F50C4338F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 15:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D7260EE8
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 15:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 39D7260EE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B50616E830;
	Thu,  5 Aug 2021 15:33:19 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 020C16E830
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Aug 2021 15:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2WMzC7lH/84fc0rbMp81/uFKG845LLEx1JPjnF5NA4dHhEFKBD93Uwdl5E4GwkDJe5cus3LVbccTow96WaEkIjhl1R/2h2P1gjq5UoamydFhT3UZ58r8EcMEfIMwb3ZmA0VtQ1IB9ysbR13LFuASp4wbcs+HMj9igsNv98HjcQldhAF1zW0CrW+S2FSY0rlZX6nHqK0cqGrqHTf3tmCkbXbr2ZLBwUqojcmRfoiAcsrJWggbCqcYX4G7iJmGziM5q4NJEh/uIddVyjfGSDI0vfDmWmj1vjcJCMooN+5sWW5p2ERb7oR9E+/nQP14ZuwLq7GXNdej/jyh3aGA4zJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+qvXnodqLGqq4f2fmKoH/sXjTzKkvXDobHmw6WFpWQ=;
 b=EyHLJBDGD7jgaGpIj0NbWxGCn8HU7iUN8MQUaurfXlxivES7QlpYzBwxW3C03Z0iZXbV3C59lpTieF+Abr2OqXG6nDWoxD3TA+m8gy5ksTCf5xWaKA69pb2T33sMdIMiSgGVruN3P/ouQgTD6Kf/+qF/gp5Cmjvr5gyHMUId/7PJZrIJZtyn+9q4wuFNQxPx8JP56YXa9q6zQ4vlnavLmtY0zX09P62QJ8nU/fC4xtIZEwybsP07VTLa+N8V9OwP0x81RjkWAA2HVa+t1gJfIoXgdgYp6WbINEuVvi/ZXw6fVtez7sUN1XIdknJtGS60ZTNq5xaxfiseJBvMRBSShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+qvXnodqLGqq4f2fmKoH/sXjTzKkvXDobHmw6WFpWQ=;
 b=vrkpy3bqq0PeeiyoydiX7yaKm2pM/SLKMs/DIRBEqCLfdxp8zYoax2tlX6VpnD62oqf07ZIvgEQuSXJYM4+rpgGev+8KHqL5kefPmVhiQ/xS1mEE7v8uuZUqEgLXARNdqputjeD12H+9ATsX3vOf8jQnlLy+r6WtqWPKmGQ2hd0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5164.namprd12.prod.outlook.com (2603:10b6:408:11d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 15:33:15 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4352.033; Thu, 5 Aug 2021
 15:33:15 +0000
Subject: Re: [PATCH] drm/amdkfd: Expose GFXIP engine version to sysfs
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210804181738.6339-1-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1ddc1015-208b-c7ef-f2c8-46cdd9f0fe80@amd.com>
Date: Thu, 5 Aug 2021 11:33:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210804181738.6339-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::13) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YT1PR01CA0104.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.17 via Frontend Transport; Thu, 5 Aug 2021 15:33:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa1d3a8c-6eab-4138-9e13-08d958265761
X-MS-TrafficTypeDiagnostic: BN9PR12MB5164:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51646B07A92E993417D0E92A92F29@BN9PR12MB5164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMBVo9Mh/uYFT9c7npj6MGXwf5zCiI9XPdz7mU/nlzh9pOT/ySEG4+4lUB6HJ8sLeWUTlRvT0nbHDN/e55d9+mLf3Tqq46/Vd/01HUWOSV7F0mPf9B/FqWYvnEUz21Cf9Z45MF1FhcGwDMLsdN1sL7gNOPabTgPAY/pq9HMaRBcpKU4dPJoBA57C3b04G9tGs3rtcgyyPxz1+6Oc6N9t5pEnLNgv8OzqAICkP6gldH7g2/YgqzcEs74EFJjXKv9jnU6+bSPy7JM8ZWtTj+vAGjjxyYzYBJ1qLcUUBqnFEEYIdbAG0tV/D6n9SNiRRSrF3ORDkOFILAnofdpLQGVlEARdydItexHjmjg7+1ciFxcfLphzIRhbat/vVhuG2DFtpQ3y21JWS0CcAKEOFcPz5ciq0qKqcHp5zdTaz0dLnPqBTXDq752LxvqdNzwIW1BHyFbrm9D38CkoEjZZyfNOzhtzJyNcXRMJLix8Nq7nUt5EzSVml9MoEmlDVuY7bsC9uxhLmHJAZMgRrAfOvYZCS0sf4k9vRDbD2xbk1lnfthmOocB9C3/WhhkJ7Jh9h591vPt7KF0OVivvhQl9s0My4TyMo3c402OIXQTWKlzMZ8cRUPMdCvE/9KHbTiB4FpzV2zD1QyiGkv70McWZ0mlkE5e2xwQJMcimtaxHTwSb4dV8q9va7jcsxVr8YOASaobAX0IZuzkTyf0SXKydJf++W+TLbs/BCNQj1PJMeoqvnxK5Ef/M9mwPpfVJGcgR+Sbt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(66476007)(66946007)(26005)(8936002)(478600001)(83380400001)(66556008)(186003)(38100700002)(956004)(5660300002)(30864003)(2906002)(316002)(31696002)(8676002)(2616005)(16576012)(86362001)(31686004)(6486002)(36756003)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2ZZOHBrNWFQcEhEUlU0OFdYNHVwRGpPVEllclArQmdQNk81dEJjc09nY1Vi?=
 =?utf-8?B?azNtb1owN2lCOGFSWGk4a0RaZjQrTDZTdDNwalFQbXNibkd2MGRQS0xrUXp4?=
 =?utf-8?B?QzJPOXZRemQ0SlFkcjBUQThibGR2eXZHeGx4SUtLR25mcXQ4eUpDVG5xckVM?=
 =?utf-8?B?a3g0ODVIUi9pWFhqdUJBWEEvZTJ1Z2tBN2NkYWxvRXI1TWRiQ2UrTXpjMjFy?=
 =?utf-8?B?enhzUkN1akJENUdocmNyT0dhT3htVGxkRFRKemlhZjhEUks1bm9iWm1VbWpF?=
 =?utf-8?B?RGdWTjRHb0tzeVlPbDhPK2ZOQWhDeVZMa0d5T1JtcXlVaWtmelBUL2U0NGR5?=
 =?utf-8?B?UzhycW1aVkhOWWQ5a3VuVEx4ZXJ3T2Z3eXpaZEhtNFkrOVZBcEVGelBBUURM?=
 =?utf-8?B?Vk5wZ2xhZGJXcWVHRXpSTE1UZm5pOGpnbGptNG0wdVpwNzVsdnJ3cHkvMHo3?=
 =?utf-8?B?dHBrL1d6V1pub01SZnZaZ2VLcXNHV3hIK3JUVzlOMyttT0Z2NmRYVWMxZFAr?=
 =?utf-8?B?b3R0QXpNVmR4UVJVZmJPckNjUVhOeHNXVjdiOUVFbGNMKzdBRWR5WklrMnJD?=
 =?utf-8?B?S0NGemllc05BMjFCOVQwbUVhbmZkejVnZnhTRkhYSGtpK2hSSmlqVFhnTlhP?=
 =?utf-8?B?c0JBWHVXdXVpbFdDbUhvdkgxN1d5bkVXUlRaT2xVZEZlaGcxYlY4WXBvTWlx?=
 =?utf-8?B?THYwU0FHSFU2eUh0elZPYkpmSmllQzNNSlgrNTVvN2c1YzFhRmY2UWFucXVX?=
 =?utf-8?B?R3BnNlkvU3Y1RU5HK1I2L0ljQ1BOQkx1VFg2d3FkMGwvQU8xUnRLRWFMR0c2?=
 =?utf-8?B?R3hXUGYvWFlaeVljK0NtZFlQOW1IZFI2ODhLWnJWWm9BVlR4OEo2VHpEemNG?=
 =?utf-8?B?OEJBQ0UvUjJOUWVQNHR4SG5icXQ5MXpxT25IcFN3UFFjUnZXd2xlY2txMjVX?=
 =?utf-8?B?NDY3NEx2T3FlajMzSDR2WkR6bjkvd25GalhLR1E0RGlRd3NLS0pVdTFOQlZC?=
 =?utf-8?B?ZnNnUERxRENzNkE3MUY5R0NLTy81citGVUROQnBNZFVlRkRJQ3FqYXFNUEQx?=
 =?utf-8?B?aVVHd1ZSZzFGcVVPQXhZMG1KWnhsQVRiYlJJTFFYOGZmWWFSdEZxUytveW4x?=
 =?utf-8?B?anhUK1BRakZuS2Irdmw5Rmk5bE1Kekh0OWw2Y0RqUXJaSzRiaXlWMit2NDhu?=
 =?utf-8?B?dVNDOVovK0g4OUhFNnR2bk9CazRJajVlVTl3NlRHZTc5a3Z1d3JhK2twZmtI?=
 =?utf-8?B?OU14aXY2RWlhaUh0UkdmdHZPM0JYYjl3YTVXRnFyNVpNaGRFWEtZbUY3Rjc2?=
 =?utf-8?B?eTNCNHZ4c3pjcEo3UFM2SmhiY2ZnZUM2Zng5QURSanJrekovaFk1SmVaRjZH?=
 =?utf-8?B?eitsOU5KMEI5QTVxTEVXQ0ZLeCt1aEM2UVRrQXFwcHpRQkM5aHQza3hyZWFj?=
 =?utf-8?B?ZGpXNkJwMmhSODVxcTJUZi9NZ280VkdLaUZnekJLQzJkanBPeWJCVDJPWGV0?=
 =?utf-8?B?SzBBeDFsc1RWaW5EckxwTWtCbWhXNlkwT0prbG1lSkkrS0Q3QVhSSzhGc3Bh?=
 =?utf-8?B?aEkzSm5JMFVPQkE4RklFRVI1cG9Cc3A0Sit2RWNaeVZHV1JmMlArWkZmaURL?=
 =?utf-8?B?ZWxlSUI5NUIxUE56TXZxdFRoVXZtQTFXM3p1YUkxYVEwbWpiTk5rUC9tWVEx?=
 =?utf-8?B?MHlkdUVMU0ZhY0M1L2Q0V2QxaXRBcTJuVEFrV250czhLd1BDWWhVOWdtZStm?=
 =?utf-8?Q?o9qPtsw5Q2k31fXD+XV7XeNt2vE/J2ViDhrYvv2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1d3a8c-6eab-4138-9e13-08d958265761
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 15:33:14.9633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOS4XYVa4H7/NDM7BiFYLML0/+Ah2nQu6zd1QfgmmWvybaKXaSghwork+Gya2iMHt4Fv+1gyjHRGav4Uty2h3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5164
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

Am 2021-08-04 um 2:17 p.m. schrieb Graham Sider:
> Add u32 gfx_version field to kfd_node_properties and kfd_device_info.

Update this description with the new property name. With that fixed, the
patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> Populate <asic>_device_info structs accordingly and expose to sysfs.
>
> This allows eliminating device-ID-based lookup tables in user mode for
> future ASICs.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 29 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  3 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  1 +
>  4 files changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index b551dd675085..16a57b70cc1a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -91,6 +91,7 @@ static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
>  static const struct kfd_device_info kaveri_device_info = {
>  	.asic_family = CHIP_KAVERI,
>  	.asic_name = "kaveri",
> +	.gfx_target_version = 70000,
>  	.max_pasid_bits = 16,
>  	/* max num of queues for KV.TODO should be a dynamic value */
>  	.max_no_of_hqd	= 24,
> @@ -110,6 +111,7 @@ static const struct kfd_device_info kaveri_device_info = {
>  static const struct kfd_device_info carrizo_device_info = {
>  	.asic_family = CHIP_CARRIZO,
>  	.asic_name = "carrizo",
> +	.gfx_target_version = 80001,
>  	.max_pasid_bits = 16,
>  	/* max num of queues for CZ.TODO should be a dynamic value */
>  	.max_no_of_hqd	= 24,
> @@ -130,6 +132,7 @@ static const struct kfd_device_info carrizo_device_info = {
>  static const struct kfd_device_info raven_device_info = {
>  	.asic_family = CHIP_RAVEN,
>  	.asic_name = "raven",
> +	.gfx_target_version = 90002,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -148,6 +151,7 @@ static const struct kfd_device_info raven_device_info = {
>  static const struct kfd_device_info hawaii_device_info = {
>  	.asic_family = CHIP_HAWAII,
>  	.asic_name = "hawaii",
> +	.gfx_target_version = 70001,
>  	.max_pasid_bits = 16,
>  	/* max num of queues for KV.TODO should be a dynamic value */
>  	.max_no_of_hqd	= 24,
> @@ -167,6 +171,7 @@ static const struct kfd_device_info hawaii_device_info = {
>  static const struct kfd_device_info tonga_device_info = {
>  	.asic_family = CHIP_TONGA,
>  	.asic_name = "tonga",
> +	.gfx_target_version = 80002,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 4,
> @@ -185,6 +190,7 @@ static const struct kfd_device_info tonga_device_info = {
>  static const struct kfd_device_info fiji_device_info = {
>  	.asic_family = CHIP_FIJI,
>  	.asic_name = "fiji",
> +	.gfx_target_version = 80003,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 4,
> @@ -203,6 +209,7 @@ static const struct kfd_device_info fiji_device_info = {
>  static const struct kfd_device_info fiji_vf_device_info = {
>  	.asic_family = CHIP_FIJI,
>  	.asic_name = "fiji",
> +	.gfx_target_version = 80003,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 4,
> @@ -222,6 +229,7 @@ static const struct kfd_device_info fiji_vf_device_info = {
>  static const struct kfd_device_info polaris10_device_info = {
>  	.asic_family = CHIP_POLARIS10,
>  	.asic_name = "polaris10",
> +	.gfx_target_version = 80003,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 4,
> @@ -240,6 +248,7 @@ static const struct kfd_device_info polaris10_device_info = {
>  static const struct kfd_device_info polaris10_vf_device_info = {
>  	.asic_family = CHIP_POLARIS10,
>  	.asic_name = "polaris10",
> +	.gfx_target_version = 80003,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 4,
> @@ -258,6 +267,7 @@ static const struct kfd_device_info polaris10_vf_device_info = {
>  static const struct kfd_device_info polaris11_device_info = {
>  	.asic_family = CHIP_POLARIS11,
>  	.asic_name = "polaris11",
> +	.gfx_target_version = 80003,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 4,
> @@ -276,6 +286,7 @@ static const struct kfd_device_info polaris11_device_info = {
>  static const struct kfd_device_info polaris12_device_info = {
>  	.asic_family = CHIP_POLARIS12,
>  	.asic_name = "polaris12",
> +	.gfx_target_version = 80003,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 4,
> @@ -294,6 +305,7 @@ static const struct kfd_device_info polaris12_device_info = {
>  static const struct kfd_device_info vegam_device_info = {
>  	.asic_family = CHIP_VEGAM,
>  	.asic_name = "vegam",
> +	.gfx_target_version = 80003,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 4,
> @@ -312,6 +324,7 @@ static const struct kfd_device_info vegam_device_info = {
>  static const struct kfd_device_info vega10_device_info = {
>  	.asic_family = CHIP_VEGA10,
>  	.asic_name = "vega10",
> +	.gfx_target_version = 90000,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -330,6 +343,7 @@ static const struct kfd_device_info vega10_device_info = {
>  static const struct kfd_device_info vega10_vf_device_info = {
>  	.asic_family = CHIP_VEGA10,
>  	.asic_name = "vega10",
> +	.gfx_target_version = 90000,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -348,6 +362,7 @@ static const struct kfd_device_info vega10_vf_device_info = {
>  static const struct kfd_device_info vega12_device_info = {
>  	.asic_family = CHIP_VEGA12,
>  	.asic_name = "vega12",
> +	.gfx_target_version = 90004,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -366,6 +381,7 @@ static const struct kfd_device_info vega12_device_info = {
>  static const struct kfd_device_info vega20_device_info = {
>  	.asic_family = CHIP_VEGA20,
>  	.asic_name = "vega20",
> +	.gfx_target_version = 90006,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd	= 24,
>  	.doorbell_size	= 8,
> @@ -384,6 +400,7 @@ static const struct kfd_device_info vega20_device_info = {
>  static const struct kfd_device_info arcturus_device_info = {
>  	.asic_family = CHIP_ARCTURUS,
>  	.asic_name = "arcturus",
> +	.gfx_target_version = 90008,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd	= 24,
>  	.doorbell_size	= 8,
> @@ -402,6 +419,7 @@ static const struct kfd_device_info arcturus_device_info = {
>  static const struct kfd_device_info aldebaran_device_info = {
>  	.asic_family = CHIP_ALDEBARAN,
>  	.asic_name = "aldebaran",
> +	.gfx_target_version = 90010,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd	= 24,
>  	.doorbell_size	= 8,
> @@ -420,6 +438,7 @@ static const struct kfd_device_info aldebaran_device_info = {
>  static const struct kfd_device_info renoir_device_info = {
>  	.asic_family = CHIP_RENOIR,
>  	.asic_name = "renoir",
> +	.gfx_target_version = 90002,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -438,6 +457,7 @@ static const struct kfd_device_info renoir_device_info = {
>  static const struct kfd_device_info navi10_device_info = {
>  	.asic_family = CHIP_NAVI10,
>  	.asic_name = "navi10",
> +	.gfx_target_version = 100100,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -456,6 +476,7 @@ static const struct kfd_device_info navi10_device_info = {
>  static const struct kfd_device_info navi12_device_info = {
>  	.asic_family = CHIP_NAVI12,
>  	.asic_name = "navi12",
> +	.gfx_target_version = 100101,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -474,6 +495,7 @@ static const struct kfd_device_info navi12_device_info = {
>  static const struct kfd_device_info navi14_device_info = {
>  	.asic_family = CHIP_NAVI14,
>  	.asic_name = "navi14",
> +	.gfx_target_version = 100102,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -492,6 +514,7 @@ static const struct kfd_device_info navi14_device_info = {
>  static const struct kfd_device_info sienna_cichlid_device_info = {
>  	.asic_family = CHIP_SIENNA_CICHLID,
>  	.asic_name = "sienna_cichlid",
> +	.gfx_target_version = 100300,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -510,6 +533,7 @@ static const struct kfd_device_info sienna_cichlid_device_info = {
>  static const struct kfd_device_info navy_flounder_device_info = {
>  	.asic_family = CHIP_NAVY_FLOUNDER,
>  	.asic_name = "navy_flounder",
> +	.gfx_target_version = 100301,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -528,6 +552,7 @@ static const struct kfd_device_info navy_flounder_device_info = {
>  static const struct kfd_device_info vangogh_device_info = {
>  	.asic_family = CHIP_VANGOGH,
>  	.asic_name = "vangogh",
> +	.gfx_target_version = 100303,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -546,6 +571,7 @@ static const struct kfd_device_info vangogh_device_info = {
>  static const struct kfd_device_info dimgrey_cavefish_device_info = {
>  	.asic_family = CHIP_DIMGREY_CAVEFISH,
>  	.asic_name = "dimgrey_cavefish",
> +	.gfx_target_version = 100302,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -564,6 +590,7 @@ static const struct kfd_device_info dimgrey_cavefish_device_info = {
>  static const struct kfd_device_info beige_goby_device_info = {
>  	.asic_family = CHIP_BEIGE_GOBY,
>  	.asic_name = "beige_goby",
> +	.gfx_target_version = 100304,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -582,6 +609,7 @@ static const struct kfd_device_info beige_goby_device_info = {
>  static const struct kfd_device_info yellow_carp_device_info = {
>  	.asic_family = CHIP_YELLOW_CARP,
>  	.asic_name = "yellow_carp",
> +	.gfx_target_version = 100305,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -600,6 +628,7 @@ static const struct kfd_device_info yellow_carp_device_info = {
>  static const struct kfd_device_info cyan_skillfish_device_info = {
>  	.asic_family = CHIP_CYAN_SKILLFISH,
>  	.asic_name = "cyan_skillfish",
> +	.gfx_target_version = 100103,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 8a5dfda224bf..ab83b0de6b22 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -196,6 +196,7 @@ struct kfd_event_interrupt_class {
>  struct kfd_device_info {
>  	enum amd_asic_type asic_family;
>  	const char *asic_name;
> +	uint32_t gfx_target_version;
>  	const struct kfd_event_interrupt_class *event_interrupt_class;
>  	unsigned int max_pasid_bits;
>  	unsigned int max_no_of_hqd;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index ef992dd2da3a..98cca5f2b27f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -478,6 +478,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>  			      dev->node_props.simd_per_cu);
>  	sysfs_show_32bit_prop(buffer, offs, "max_slots_scratch_cu",
>  			      dev->node_props.max_slots_scratch_cu);
> +	sysfs_show_32bit_prop(buffer, offs, "gfx_target_version",
> +			      dev->node_props.gfx_target_version);
>  	sysfs_show_32bit_prop(buffer, offs, "vendor_id",
>  			      dev->node_props.vendor_id);
>  	sysfs_show_32bit_prop(buffer, offs, "device_id",
> @@ -1360,6 +1362,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  	dev->node_props.simd_arrays_per_engine =
>  		cu_info.num_shader_arrays_per_engine;
>  
> +	dev->node_props.gfx_target_version = gpu->device_info->gfx_target_version;
>  	dev->node_props.vendor_id = gpu->pdev->vendor;
>  	dev->node_props.device_id = gpu->pdev->device;
>  	dev->node_props.capability |=
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index 8b48c6692007..a8db017c9b8e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -78,6 +78,7 @@ struct kfd_node_properties {
>  	uint32_t simd_per_cu;
>  	uint32_t max_slots_scratch_cu;
>  	uint32_t engine_id;
> +	uint32_t gfx_target_version;
>  	uint32_t vendor_id;
>  	uint32_t device_id;
>  	uint32_t location_id;
