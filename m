Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C7FC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 19:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 105C1233CF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 19:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105C1233CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C05F6E50C;
	Thu,  7 Jan 2021 19:43:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ADF66E50B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 19:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNUTTMKYgrD0Wi3LHyHXufyXabaRye96Q2AN3Qby00PxWZZo1ixD6ItTptDnPWLeavVno4W+C3SVKLLgKTivtkUKq0tGfIOo3z4qBd/mdy5JQ8e9LHvPCdymuoygSWuqV0FUUCWVrW4100VRIQhFQcMZTrMemnfBQH6XBp9d2o4wF7IiCN1OmUmeXyu5qF8HsPzLe584CCk8VwcAELj8VfsXV/vvMq9Sd609DZ+C6uDqJR43oePBraa0AzTNq3SK154I2T178XPoSXhu2xOEaGL18QvHVQWSpUgb2/MH7AMzUWzIS+LaK5m+BjMqjnBYWQJPJdgYSqE+VG9FOA30Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aok+qtFJFxV4JVwDnzN+sPCqaaUSCQou7Y8hvJP15tU=;
 b=Zg+St2jNlsKIo+1R7K4gaykWeer51YhwZBcUiSN6gme15iUMi1do6ALgp9uj+s+rMvtaItPJusF/saV/TVBPECf1yJr956am4PiydzS8t7DXpecN0WbzBG+YV3LH5YRlXTyP6N0SuZO6ay0DGKDmerEFcI99lDvXxnBGA0R/FksGFmFOz/gjbzRIta1VwBhS2MNebeRl1Labxhe6hHqfitF2DY5qhwe8bFD+CKrJHTQbi1jyj/IAgg2u1gsgzp2JTTugdVuHXVmM/VtW+GWWCufkYvb3RJ4JB6a0BXikpj15sGDa78Hh3vvrLmvTw2AbE3jEfH0TrWJsqTDGJCaC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aok+qtFJFxV4JVwDnzN+sPCqaaUSCQou7Y8hvJP15tU=;
 b=tohEZfgzU5HfElmGAW+FMxi+vT2ReO58VoTALeSpw6kl+rZg7Z89IFeRnqwSuTlJcUrChqM2qNk2v8B29GvdRMFTZc92bIzUKlYbgCB+v2/xBpbVZ5OBYSWH2TGkZtHX0H63bgFw3NhNL8m+7gOhL53/YdAYnEPzt9zfLoGUuTA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM5PR12MB2565.namprd12.prod.outlook.com (2603:10b6:4:b8::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Thu, 7 Jan
 2021 19:43:54 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::24ac:3d8c:c5ab:63ad]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::24ac:3d8c:c5ab:63ad%4]) with mapi id 15.20.3721.024; Thu, 7 Jan 2021
 19:43:53 +0000
Subject: Re: [PATCH 2/2] drm/amd/amdgpu: Use IP discovery data to determine
 VCN enablement instead of MMSCH
To: Bokun Zhang <Bokun.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210105225427.19570-1-Bokun.Zhang@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <b011e768-ac0c-0f2c-eca1-7f9b4d70a8e9@amd.com>
Date: Thu, 7 Jan 2021 14:43:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210105225427.19570-1-Bokun.Zhang@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2088:19:6ee9:17cd:c08e:4022]
X-ClientProxiedBy: YT1PR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::13) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2088:19:6ee9:17cd:c08e:4022]
 (2607:9880:2088:19:6ee9:17cd:c08e:4022) by
 YT1PR01CA0074.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 19:43:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3cc208e2-f7b8-4828-7648-08d8b34490b5
X-MS-TrafficTypeDiagnostic: DM5PR12MB2565:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25658C4FC4DDEB6C5613EC9BE5AF0@DM5PR12MB2565.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6oCEN1B8RBaxP9pHsj6nUmPT+1ES+DjFxgzDzxROMAjMs8oIFavFoRQWpZHInIcLUpNJzwSel0CVc9lOFJ967AXcbCN8fCG93oZDaW4s2BFsGpSzZ1slmZrgCEW/ODxoswLgBdDARukE6NXFybtT2e62Narg/D5aaMOfuh2CCIeY3mBpV6MmNiAK7T2Cq1HsDRlqaH+SPGJCN6za4GvPPFsjc2KVvG+vpHkjNAZUSMxx1uVB6g7zr4POUT73rgMBjp3fKuqZHN5aN5jVPNl6FQjvdnXhvp1d3qZLsaT1MM7v173NPXc6h3Jvf4cBNj7IuFWlEyNQC53VHQe/hWDY1cfU9mOTd4/EdPmHw3dATH/lGqj3Ck9t1OTyUe4zjpmNt8xyTNuFnEcUCeIh/L4LBsh5ZS9n+2ue0auqqpn9dAI9iClK+tnG2nJbTT0vWZ2icWY+pJGA4VEr1yRJmnZ/+TC0qQxSJzJBbUQckT5bUECsUZEFg5CPHh4I0kEjt4m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(83380400001)(52116002)(2906002)(16526019)(36756003)(8936002)(316002)(186003)(6486002)(31686004)(8676002)(44832011)(53546011)(86362001)(478600001)(66556008)(2616005)(66946007)(31696002)(5660300002)(66476007)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Si8va3pUSFF2c1NCcEE4Vy9JOHdzeE5OYjFZNGsxb2lzdk5SK0ZPbTN5TS9U?=
 =?utf-8?B?bHRGVlpvbVhVVE0wTElyVUFyMzdpZ1lybmVDR0FJaTJjak04N3JYV1p6NmNh?=
 =?utf-8?B?UzZmQk80QkxuRjJEU0Rtd24vUlRzaUFRM20yY2k0R3RtZnRrdEV6V3p2NHF1?=
 =?utf-8?B?eUk4RkQvWTU1Vlk1RFc0amJ6UGx4bUxEL3hFUVMvaWhKekhTek5MRmxLNk9W?=
 =?utf-8?B?NUNRLzFCQ1hhdUJqNTZEaFpzbzVDZS9LUlkzZTV1SEt1c0srdmkxQ0NUUmlT?=
 =?utf-8?B?T01BUWpxc2JDK0s4ZGRBY3JQSXdnV29FM1FYWk9ad0E3U3dOU3l3UjViZjRm?=
 =?utf-8?B?akZFcDZ4czFEWmFPUHM1SGJVTDNBV2JYSDVkZFZ3ZHJCK0lLZDVvck96Vmx1?=
 =?utf-8?B?b0dDSU8xN1plQWRKbHJvd0h2VEtVZDIycjlVMCtqb3doY2ZmV1M4dHlVeWdU?=
 =?utf-8?B?dElUTTlseXduK285UkJGYnkxaHc1a3pzZERyUzJFNzQvR0dSeUZlaHM4OHBN?=
 =?utf-8?B?QzVyZHRKWm9qMnlZd3VzRHpWY2lPdm9OM0MvbmR0S01DYzdUZStqNktLS1ZW?=
 =?utf-8?B?UzV0cUlGMHlseVQ3eTBaemFnMnppWXZkMWpzRytqc1FrSmNROWJhUW1zV2Ra?=
 =?utf-8?B?d1VqS0RaSTd5Tk82WklHenJSMnorV0daTUhuMEZnR3R0ZmRVNU95SDE4Y0x5?=
 =?utf-8?B?bk1hYS8yTXBld1hZczZ3U0prWDRJYUxZc3NDd1gzSWRPTXRTRFZGdStIQUdY?=
 =?utf-8?B?bDM2a0hlWnlvL1J2UUEwOWh1MGxyeXJvODI5NXJHUllHL3FhZTA5a1QxQWI2?=
 =?utf-8?B?U0ZHVUd6cHFPRDJyak1KNnN4TlJuWUx2Zm9nTTVYa3dEU2o0Y3ZXTlc4Q1BE?=
 =?utf-8?B?aFhGVU4ydEJ6NlRLZmxUVlpiNTNiL2EvaVlsWm9wVUxaZzkxSUYrSGswb2dT?=
 =?utf-8?B?eHJVUHoyMDNUc1M2a1FZQXpnU3dxbUtXZEU5NWcvNnJHVEQ5Z0dZaUtVbDBS?=
 =?utf-8?B?UHNTOHRYWkltTmZ1eTdoWWkvZU43blRsL0JiOXRuVlBaUU93NzlFcmhMYktM?=
 =?utf-8?B?WnF5TWVFVS80b0NUU0R6TkZRdjgrY1hoSU5ZWlY5VjVvZGhqWXpKblp2QU9s?=
 =?utf-8?B?M3hBT2ZoYmVDNXIvMWxoNmMwQlc3UnVLVElZTkQ1bk9rdk9UekhPY1lCVU9o?=
 =?utf-8?B?ZStlelNLQUxjUGRXRVZMZE9qam9KMEh0TlNtNDBDOHVqelZuUUtPbFBMYVVK?=
 =?utf-8?B?NXhBbk9ha096ZTZraUtyTmdiQ28xdEZnUktRNnZPelVWdFFXMk1WZE81SjJD?=
 =?utf-8?B?RXl2YXNaajVocjJTWWY1emxDN1Ywd1c3b005T25tQzNVUjZaVzIyT3hXdXBo?=
 =?utf-8?B?ZWhSOU02REM1Tk1GM296N092YWk3WXJReDVvcUlsK3E4YkhhZ2JYNmhzZTNy?=
 =?utf-8?Q?B1oHBAGC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 19:43:53.8735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc208e2-f7b8-4828-7648-08d8b34490b5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JMrt8ICZR3yqmC6a3THMP7nLpua/hTP66jZuzW55BdrYMLFF04PJA97q9IpnLHh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2565
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2021-01-05 5:54 p.m., Bokun Zhang wrote:
> In the past, we use MMSCH to determine whether a VCN is enabled or not.
> This is not reliable since after a FLR, MMSCH may report junk data.
>
> It is better to use IP discovery data.
>
> Change-Id: I8b6c32c34017b20dcaebffdaa78bb07178e9d03c
> Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 73 +++++++++++++++++----------
>   1 file changed, 45 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index def583916294..02cac6e33219 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -27,6 +27,7 @@
>   #include "amdgpu_pm.h"
>   #include "soc15.h"
>   #include "soc15d.h"
> +#include "soc15_hw_ip.h"
>   #include "vcn_v2_0.h"
>   #include "mmsch_v3_0.h"
>   
> @@ -60,6 +61,17 @@ static int amdgpu_ucode_id_vcns[] = {
>   	AMDGPU_UCODE_ID_VCN1
>   };
>   
> +#define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
> +#define VCN_BLOCK_DECODE_DISABLE_MASK 0x40
> +#define VCN_BLOCK_QUEUE_DISABLE_MASK 0xC0
> +
> +enum vcn_ring_type {
> +	VCN_ENCODE_RING,
> +	VCN_DECODE_RING,
> +	VCN_UNIFIED_RING,
> +};
> +
> +static bool vcn_v3_0_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance);
>   static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
>   static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
> @@ -311,18 +323,26 @@ static int vcn_v3_0_hw_init(void *handle)
>   				continue;
>   
>   			ring = &adev->vcn.inst[i].ring_dec;
> -			if (ring->sched.ready) {
> +			if (vcn_v3_0_is_disabled_vcn(adev, VCN_DECODE_RING, i)) {
Since this is for SRIOV path only, and this doesn't apply to bare-metal, 
so please rename the function to something like xxx_sriov instead.

Regards,

Leo


> +				ring->sched.ready = false;
> +				dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
> +			} else {
>   				ring->wptr = 0;
>   				ring->wptr_old = 0;
>   				vcn_v3_0_dec_ring_set_wptr(ring);
> +				ring->sched.ready = true;
>   			}
>   
>   			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
>   				ring = &adev->vcn.inst[i].ring_enc[j];
> -				if (ring->sched.ready) {
> +				if (vcn_v3_0_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
> +					ring->sched.ready = false;
> +					dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
> +				} else {
>   					ring->wptr = 0;
>   					ring->wptr_old = 0;
>   					vcn_v3_0_enc_ring_set_wptr(ring);
> +					ring->sched.ready = true;
>   				}
>   			}
>   		}
> @@ -1266,6 +1286,29 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +static bool vcn_v3_0_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
> +{
> +	bool ret = false;
> +
> +	int major;
> +	int minor;
> +	int revision;
> +
> +	/* if cannot find IP data, then this VCN does not exist */
> +	if (amdgpu_discovery_get_ip_version(adev, VCN_HWID, vcn_instance, &major, &minor, &revision) != 0)
> +		return true;
> +
> +	if ((type == VCN_ENCODE_RING) && (revision & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
> +		ret = true;
> +	} else if ((type == VCN_DECODE_RING) && (revision & VCN_BLOCK_DECODE_DISABLE_MASK)) {
> +		ret = true;
> +	} else if ((type == VCN_UNIFIED_RING) && (revision & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
> +		ret = true;
> +	}
> +
> +	return ret;
> +}
> +
>   static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
>   {
>   	int i, j;
> @@ -1283,8 +1326,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
>   	uint32_t table_size;
>   	uint32_t size, size_dw;
>   
> -	bool is_vcn_ready;
> -
>   	struct mmsch_v3_0_cmd_direct_write
>   		direct_wt = { {0} };
>   	struct mmsch_v3_0_cmd_direct_read_modify_write
> @@ -1476,30 +1517,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
>   		}
>   	}
>   
> -	/* 6, check each VCN's init_status
> -	 * if it remains as 0, then this VCN is not assigned to current VF
> -	 * do not start ring for this VCN
> -	 */
> -	size = sizeof(struct mmsch_v3_0_init_header);
> -	table_loc = (uint32_t *)table->cpu_addr;
> -	memcpy(&header, (void *)table_loc, size);
> -
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -
> -		is_vcn_ready = (header.inst[i].init_status == 1);
> -		if (!is_vcn_ready)
> -			DRM_INFO("VCN(%d) engine is disabled by hypervisor\n", i);
> -
> -		ring = &adev->vcn.inst[i].ring_dec;
> -		ring->sched.ready = is_vcn_ready;
> -		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> -			ring = &adev->vcn.inst[i].ring_enc[j];
> -			ring->sched.ready = is_vcn_ready;
> -		}
> -	}
> -
>   	return 0;
>   }
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
