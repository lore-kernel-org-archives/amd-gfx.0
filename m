Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753F6C48BE0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 14:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B1F6100B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 14:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B1F6100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66AC6E083;
	Fri, 11 Jun 2021 14:32:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C6D6E083
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 14:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du8/ckoYpbUKCVeBy9z+KtVhGDT+I+WDjaHBqIMuzYJXcFHDEcE5lWphbH+QX3+5qEE+xHw5beTjU5Ky0idQB1ns2SfvCx21IPg/RzfOR7rs4G/EYJ/rYrssysCrc7A8pt6nIrNZwBut0kfcxr2vBZOWHmmUamQMBVzZoo7P6DPFbRIpjc3eAkfDDo57aNFcjFAjzcc1tGtKQUAw368mzh1kSBFUNegsauLJSh0/VvafFX9HcRxn85Rf79PsK5dmQBn6ro6bVaeJTagyE00RnfMORJ+lmMbisq5Zvsl1cu+qGyEZrL0knFNnXVRYSSxnUti7f6WSC4P0qzKRYYXMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50pnptGT5GXd5uIGGmT5oOPnrWVZzWMuwIk6t4Z9XBc=;
 b=fHLwvLkNh0i+L77y4vsuzvJYqiF4Pfkzg0ZXLzS717WIRAlqxAjTlgvyYaQ6d1K+chZOm1HC05JWtf+3kq8fHZYkrFLRKMnOPTcDim1ZfMAh8iU1Bagbr/xuht+lyiHUUvSAMk+jHL97mTloQHKPLulojp0YW1Ugsy2QFq91cw/gqHWaK58HU+S/G7MXRfjaoLEcRgGnAFSxI/FKO1mHzmsioPnJ+lub2z5L8HwiN+5DE2yDPx7j+DVekDI2eriRsOxt7QjG6O/4cYf8DEUWVCzefGXu9kkqFl634q/SqcHbl590WU0lKhPS+RWEVn2892xtq3jgYxXjGAMlv+NMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50pnptGT5GXd5uIGGmT5oOPnrWVZzWMuwIk6t4Z9XBc=;
 b=TbewON4hFOM1DnqBh5PxP/1RfNro3ObnQCMh4Le0UWZHAMsFE1ETh+s9Apn9iWRmDXppkHA4/17Uo44nKLWd1yW5pgyeMNHiRB/vI+7jQXRURfpVog1ymEdNqjmeD8aK5uFVTOgvF4dvR7+lcgIF8s1tiaSdrPTDrP0y4bUHCE4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5212.namprd12.prod.outlook.com (2603:10b6:408:11d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Fri, 11 Jun
 2021 14:32:53 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 14:32:53 +0000
Subject: Re: [PATCH] drm/amdkfd: move CoherentHostAccess prop to HSA_CAPABILITY
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210611033204.32224-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <efce7e30-b6a8-567f-30e7-0b5fa79ba0a5@amd.com>
Date: Fri, 11 Jun 2021 10:32:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210611033204.32224-1-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.203.225]
X-ClientProxiedBy: YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.203.225) by
 YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20 via Frontend Transport; Fri, 11 Jun 2021 14:32:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bc7827c-58cc-4281-c591-08d92ce5cbe9
X-MS-TrafficTypeDiagnostic: BN9PR12MB5212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5212BC6382E9C971F076E7CA92349@BN9PR12MB5212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJVzzzlJYqvxEw8EvoFAuj5DhkAFzaXpLtRpSorXO92tna/2i4fQbYaVIJSfDaTXSrAykTDThkKdqKhO+zMuHiHX2GLeK06L5Y+6FQq0tVVsniJAwPb/J2GHbL6vpdR0075doMpjTphWhislLezbhVNM5DvfI0bennRArNutSS93IHG9MASp6z/wuD+uTebLSoSWtWvpeKRgLkP/L+sOzAj2JsiaQyIPQtJwXt3OItvVdN7k3YpM1ZqplkkFBgAgSWlubNd9P01SDghPSMDuvBqYpKh0ZiADPZl10QAkKwNlFEqRSUlsyAuk7Y+sU5/RGCkIgOn+CqPy4+w4fuVv2MFECc9mcq4L5VHp59I/M9LL4SesgCovrJe7Wy63FwQoRX/ZIhbMvnGP0FHQ9lnyoUSCjjP6V6OoFtdrSJEILFG4OGamu/Xs7Xix1gE4j9bxBxq4euPXz4MDyzldk1v0JOLtvj2zodbLtn6c76Q5vpruVWgQbPOy/J1RGifwFXq2hvLoV+syp15CilxI0eXtCItsubJ8wZcAioaFn/NRuZPsRH9iuk+SUrmbjHccKDO8AbIMwxWqaEA3bsdQUCm9CpRaj610O4SEXDaQ6AmMQgFhWL2UvZ5tYpuP+L1g0a7LqGteblGn9zGvVgUYvKnCl/PT8odIGsiywVhtlBO0TMwEOI4L9i++/xRWXxGG1ylO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(6486002)(36756003)(44832011)(478600001)(31686004)(83380400001)(38100700002)(8936002)(8676002)(31696002)(66946007)(66476007)(86362001)(186003)(16526019)(5660300002)(316002)(26005)(2616005)(956004)(66556008)(2906002)(16576012)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWFZSDdyck5RV2M5Zm13OGV6V25ZNG15KzlVRHU5STM0L0d4UVA2Z2VYcnNU?=
 =?utf-8?B?bnpVSE9DQU9RTFNCYU5RUlRQU0F5NmlVSnRpc1NLV094QzRHa2FjLzlTK1F6?=
 =?utf-8?B?ejA4aW5vVzNleFNneGZpczRxWThKZm9HZUYrc3Z5TlFsQ2N6K0hIZ01PN3NI?=
 =?utf-8?B?VlNoUDRPWGxkQll6anhjU1hDMVJkOC9uUTlVWTIzdlhVUmF6RVd6cnBDRFNj?=
 =?utf-8?B?MUl4MHo3SXZaZTkzRE9zcWt0ajM0SldhVnM0VStKdW1JMHcyZGphOGhFcWlm?=
 =?utf-8?B?OUNCc3duTWliakcxaGNrU1JQTVhnUU1hQi9JbnZYUjNqREtSLzhlRjNPUkVB?=
 =?utf-8?B?V0lhc2FEWGhNVmZIbFFOLzFvNERBbkVqRnczSGJicXZOT0Z5WHVsRmwya2oz?=
 =?utf-8?B?aU5GRGw3V0hTOUwvRWVqTXoyd2JYMmJyV3NMbnVxOHNxSGN4a3hIZ1RPNUhO?=
 =?utf-8?B?TkQvUSt2TEQyT2ZGTzFxNmwvY2Q5S0NSNWtwQWxLT3RFVURRUmg0dUpjbGRN?=
 =?utf-8?B?YU9mZDdqUms2ajBHcnVhWGZjeTZiYnh5Y2xXWVRxdVRscGRNcUVPWmdMV1R6?=
 =?utf-8?B?NGNoS1VOc2t4dnc5NW5FQUpXNGpVVlUyYmkyVzVKbC85L2ZyaHhUcTJMaGJB?=
 =?utf-8?B?RVliRjQybWZOVVRlT0hnUVQvZ1FCSXdZdFVuT1Q2YTNHTnA3c1NDRUZ0MGdI?=
 =?utf-8?B?YUl5cU1rdkRpYVZnQzM2UXlKdGZ4am02UVNMM1F0Tmt5L3M1SkpxQkhrd2hZ?=
 =?utf-8?B?Ulk3SWkyRS9xUUpES21tM0Y0b09nNXFOVFh6UEVuY1V5b0NhRVVSOTRLYURG?=
 =?utf-8?B?aVJOQ1E0VDU3ZFlUUzlhYTBIYno4aU1Oc3Bwa3JNeTY0cmxkb2xyWVR2Zzkx?=
 =?utf-8?B?YkFVOGwydDE2bXJQM0JxaWNlZzBaUS9NbkJ4MFUyTi9wSXhhNGJLSFFYN0Zo?=
 =?utf-8?B?ejlKYm4wOEtpdEp3Tk82b0p2emFqSHB4SVRVOWtLdjgrZ0FIblhRRVBXa09M?=
 =?utf-8?B?VzIxbEFPMFhvblVhaW00SVFEWWNld3l4bDBoek0zT1ZzOURmK0JNMjlEL0M2?=
 =?utf-8?B?cTAwcTUvSkE4Mzc1eFFYY2xUNXA1MWEyV2ZoUGFmcVRMM3ZZamU5TGczNWpH?=
 =?utf-8?B?OGp2USt1OTBzRDBVTWY1dTlJWHNFa0NsQUkzQUlqemNsZVltbkFxMkkyQTY3?=
 =?utf-8?B?OTR2WXI2Mk1URWVPY1ZNWENtV1MzOFZkUWFvcFFUTXFIL0dzT1hlS2IvOFFQ?=
 =?utf-8?B?U3RoUWRqTjJTYUFEVEU2OUZSL25YRDVxMk5yOS9ZbjVqY09WdFc2Z01wdFJa?=
 =?utf-8?B?cVNtbjNFY1hUZXlaMVJpZVpsOUJNaVlrQ3E4VHV5WEZsY2ZUN3BSRktNZUZj?=
 =?utf-8?B?a0kyYlJtSnRSVFU4dEwwRlErNGpEMWhlaWo2aXJxYzM3TG1vOTdwN1p3Qnh3?=
 =?utf-8?B?cmJPdFhXZ0FCZFhDYmlxSmNxL3g5enVKSllMaFkzTTlmYzEzcnJEbXNGalJj?=
 =?utf-8?B?RDlNUkhzdzFCMThNUGFIMWRlSzBiVExHR0xUWUFseXNiaXhXZncvd0pKcjhi?=
 =?utf-8?B?MDlFd2dYUVlML2p2K2g4OGRQZ28yV3BiRnE5cXJueDZNTFpMOGtMTEFxK0NB?=
 =?utf-8?B?NUJteEpLeUYzSEFTWlBvZWZJSEUxQUU1NzB1akNlLzdaYnVRZDhQaUJFbGNS?=
 =?utf-8?B?UVJqSDFNbWN4dThKYTNuUFY1d3RsS3AvSEp3RG5oY0xKVXRrSFArK0IyWHhJ?=
 =?utf-8?B?L2hyNkM3eiszRDdnNXZMWGV2bjFJeUs4SzJ2cjd5bHNTUDYxNjNRYkNobjMz?=
 =?utf-8?B?OWRqV3lmNVBBSzVoTmU5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc7827c-58cc-4281-c591-08d92ce5cbe9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 14:32:53.2502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3YFGu+O4yGJAk0B4+fVpOzeJNXs8Kackyx106hDhKNScueO3ErKJkWJ1KagyyCv/2L7OYKe+WVTGsSdNEhuKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5212
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-06-10 um 11:32 p.m. schrieb Alex Sierra:
> CoherentHostAccess flag support has moved from HSA_MEMORYPROPERTY
> to HSA_CAPABILITY struct. Proper changes have made also at the thunk
> to support this change.
>
> CoherentHostAccess: whether or not device memory can be coherently
> accessed by the host CPU.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index 6bd6380b0ee0..8b48c6692007 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -54,8 +54,8 @@
>  #define HSA_CAP_ASIC_REVISION_SHIFT		22
>  #define HSA_CAP_SRAM_EDCSUPPORTED		0x04000000
>  #define HSA_CAP_SVMAPI_SUPPORTED		0x08000000
> -
> -#define HSA_CAP_RESERVED			0xf00f8000
> +#define HSA_CAP_FLAGS_COHERENTHOSTACCESS	0x10000000
> +#define HSA_CAP_RESERVED			0xe00f8000
>  
>  struct kfd_node_properties {
>  	uint64_t hive_id;
> @@ -101,8 +101,7 @@ struct kfd_node_properties {
>  
>  #define HSA_MEM_FLAGS_HOT_PLUGGABLE		0x00000001
>  #define HSA_MEM_FLAGS_NON_VOLATILE		0x00000002
> -#define HSA_MEM_FLAGS_COHERENTHOSTACCESS	0x00000004
> -#define HSA_MEM_FLAGS_RESERVED			0xfffffff8
> +#define HSA_MEM_FLAGS_RESERVED			0xfffffffc
>  
>  struct kfd_mem_properties {
>  	struct list_head	list;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
