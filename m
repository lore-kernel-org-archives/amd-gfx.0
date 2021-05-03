Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BB3C433B4
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 19:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469DF6115B
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 19:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469DF6115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39B796E134;
	Mon,  3 May 2021 19:56:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A8056E134
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 19:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d00vBd2KRLRsaAlhQFQvv0nWyC22pyZK57UWLyK0jETCQCfWVCxchkBvWIMBx7KM84DF/CbT8UmSqj88AI0A0I7y/ZVLznZso0JaJ/bbydg8Yo7sHW6EVfTTdzbUQXxR9PdM+WfuF+VlDRbC6Ut8nK2W/5qgYwG93a4MmRJpD8hxQ0Q1pRdwUEsXTKwgd6ma7MsqP0ysePedNbFkZYs2lg54OxJgupp+0MHFaGOEECndx7t4IZ+heBedb9DhPbGoYZUTdEEF1C10kzEP+NuwdTfegcu9jC9c28ojHkFISHfZcXFU/U4MGusSzVVp4XrODEGiKuWdECngJ9jrnPi1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oivgc978/uPkpUgc63T9B8LVT8h8uBtydocAMQf5z6s=;
 b=n76Az0cnsGzRu7zR+c5qkWzqO/tK2aWbaO9Yp2eJxNGgKs7t0dTPaf5tOt2qrl5On/M4OSWusL8CXEacAzj5TeHkm4l8p4zilVJC2fy19UOboDDc+qr78YxDmvjS+e7biG9wabVRyfoZ7ov2uWoueTya/8IdNigSKz0i004VVKBzdinsXzkaP0mpHE4omP0KWO/bLsg8YcXr3vZyVHHYnD5sKIcfysvCZcqzT4KbTzoAX1tpvJUyNr8i5pXjMGAhhgk4HfcuafuQtjExvv5cKCwVxjnznwh/PPqHHAgsqj8jr/tKzk5VYef9mrBJLBShrvNZWbKoC7rlswh8rIEecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oivgc978/uPkpUgc63T9B8LVT8h8uBtydocAMQf5z6s=;
 b=ItkljoZ0eRHbCimzkcW5fwta6ryacouTfruhZMLY1x/4IBOrsVoF+v9LnTi3ssAWIeod56JqULXYhMx9b2a0eu2wFkbVU3gP7oSnHZii04icU9q9leQlOLEq3zvUJvRvgDhC3HFZhvOXq+On+TgDdWwmyhq0KeChdxR4wuP4xcI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5098.namprd12.prod.outlook.com (2603:10b6:408:137::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Mon, 3 May
 2021 19:56:49 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4087.039; Mon, 3 May 2021
 19:56:49 +0000
Subject: Re: [PATCH] drm/amdkfd: fix no atomics settings in the kfd topology
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210503194932.121989-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <6974a016-8e48-c2fb-8428-eca00a95e001@amd.com>
Date: Mon, 3 May 2021 15:56:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210503194932.121989-1-jonathan.kim@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::9) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.40 via Frontend Transport; Mon, 3 May 2021 19:56:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b855e360-7a0f-4d63-c5aa-08d90e6d96db
X-MS-TrafficTypeDiagnostic: BN9PR12MB5098:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5098159F915E87BF20DBA61C925B9@BN9PR12MB5098.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYfikELHFNyiR+Qz54hMCMOcyiWuIwkt91zkp7oax6zvd+6R/bigIH4jo5muBcLCWJMtvCJe9lJUxpbEt2M+Vrh4qyXirkHV1BVl6UZ5GJB1xcv926vNjnQOAkU5TF3Qg+OGdk/H/oHZ71SjQ9khjpJo3ocs0lnJ/q3hqLgMMY8CiK756lmLJUucTEpBtDTEg+CrREOTiOhK3+eAAAiXKsb5Rx+E17OXUeolxcOfCZGwvg/cXxv4RJciVV9WAqcDm2H+isS2q7FLuAyDmt/VMI/P7y/QAK2CWT/vQWZleVgf8E0G43sKNOvOKtENN+QwiWdhbIafQ1rdGa3QeS/gFPBHOD9aUJYBLx7W4qlQS3qQcMqHNOY4eubJQG22n4ldjFPo7rFXrR2vUXgmOYXMscdxnUXqOvxJ97NI0nFLIJnyjvpdsrifMyFHmlhIuhikdNDktIOAqwEgp6Jatr74sqqomUbz5vNIXDD50lhpajrvJ9IWStwAZMj6PmVLVnbPGpDsZ/8v0kOqQo5tzdJ6YTiQO1DUYEVuiV6MppISGID66UoFFQaOI7FmHOToS3r7ylDmxwKQsArUEP2GlS4KoCJzOM06VSlImmmhrDTvx5t2ZPyQWrWIf6QxrhFKFjQ8FwgQ8OgRnnxpzVXJHODHT9jTY4mppyp7ZApb6ZBysjQ9FIp+WQiyXJ9rQHk4id0L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(38100700002)(36756003)(31696002)(31686004)(6486002)(478600001)(8676002)(66476007)(2616005)(66946007)(86362001)(66556008)(2906002)(316002)(16576012)(8936002)(83380400001)(26005)(186003)(44832011)(956004)(5660300002)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VDhzVTQ2MnNjTkhCQkZHdjZkeHd4MUgwcXMzcG5QMVpXeFBSNlRlRTh1TDB3?=
 =?utf-8?B?cW9EeFdrV0phQ2prd2UyRURpUGtSOUE2R0EwK284T1JYaWM5UHV4b05aMmN1?=
 =?utf-8?B?VU9hdVZkQ1djbkN6cTRGR0d0ZEl3dGd2c0lEUC83TWtLQTZtKyttZWRxMGRG?=
 =?utf-8?B?YkFZdTlEaXVOb0VyVzQ0TENKd2s3bzc1M3U0R2NZbnRZR2pwdFRYWnJVWFZt?=
 =?utf-8?B?ZW1IM3k2TFRlazRvOFphZmJyVWx1aWt3bXpCSGdXVytYNnowNHhQZy9sdVRn?=
 =?utf-8?B?Ympwb2RaYng3d2QrUUExUXJnbDduM1FodGtSdjNGZUIvamdWbjZKWURiRDl6?=
 =?utf-8?B?RW0zM09kb0xHOFJBS1VJOFFORnJjbElBVDVMNVpZZGh4N2p5L3NWdThqbVdQ?=
 =?utf-8?B?RkpjY2tQdXRtUFBxN1NWVTliQlkxN2hhQkZxK1dYaUtmbUhUdnJhUHByaVk3?=
 =?utf-8?B?REpiTi9GKzhUYlJjS2dJUVBOUGNFWGNKYUtTTGVNMWI3OHYvYVFlZms2VlhW?=
 =?utf-8?B?WHN2c2VXZzU1Vnp2ZW1BSmk3TGcwNTJiUTRmeHQvZXBybWN0RFZiOGd0NStm?=
 =?utf-8?B?WjRZZzk4NGpHV1JtS084cU5zT0RqTTJvbG1HUUNvempCMWVUekxBWmJCRjRl?=
 =?utf-8?B?RDAyUnJ1MFlTMjVwODhRNXM3Q1BlSHZ5Q0wybUptcXh4d2pDcnJFTWtHMnUr?=
 =?utf-8?B?MWlnM2lVaU8vcllqWkozN1gxM2RwQ3d5UWwrQ3o2NllXTldwZ2loMmt4UGV1?=
 =?utf-8?B?V3BESm9iMDZUZWJLWTBaMERQaHB6eTkyak5yL3NsMVZERXIvcldSVTJKNUJz?=
 =?utf-8?B?RTRsWUhhWVlLcVBVZmwzaGV6Ty9TOUFuSDZPbEVKdHVCNXlOeWJnNDRNYXFr?=
 =?utf-8?B?WXBhM1F1YUtUTkVkNFA1Qi91S29HbnBCbjRKNzBmWjhGUlRTYVQwZFRtczZa?=
 =?utf-8?B?RzhSSjdNZmRlTEFZcndKVmFpZ2xsZk1mUjYzWmRpeTFXZExmdlc4V1JXcHll?=
 =?utf-8?B?YVorSjgzSEVjdFFqT1lkNC9KbkQvdG5SS3Jmams3MWJuNVBkUzQxRDRNN3A0?=
 =?utf-8?B?LytYSTZuUkpSQUJKbnZ2SkdBd1BhVFlOZWRKWWxmam5IeUw3ZGlrYUNZTFo2?=
 =?utf-8?B?ZnlwNi9kN1dSdHRmUzNHRU9idTBxQ1Z2dXhVMEFzL001MFYzRkJ4Ky9rL2hs?=
 =?utf-8?B?dmZTTmpDQUUvbnBFdzN1L2lMWHI2dzl2VTdnQ0puMStFMlUzMjk5dkdDWkRT?=
 =?utf-8?B?ZVlhQ2lGUTlLaHZ1aGRGQ2hBdDRnd1BSamR0T3Z4cjFxNnY4ODRzMUpFTDM0?=
 =?utf-8?B?LzRkYnBmQVp6M3lPUmJXTkxTc3ZtWFNWMXZrZWJZanZtbkRJMytQZmh6T2pz?=
 =?utf-8?B?WWQ2ZmhMV0RTZEhDaThwbTA2YklYeFpud1FmRzNMNkE5Y1hMZ214R1pYYnRW?=
 =?utf-8?B?c2c3UzJySm5xekRiTHVjeGppTUY5MGRlZlFFN2FXeGxEMHZFYVQrNkQ0Lzda?=
 =?utf-8?B?UnBkL1dTNzl3Yi9DMkJXdkw3OGQvcGZoaE95TmlFZFB4eXBubmpCODlqUEl6?=
 =?utf-8?B?QXBZdnUvQnZsempQVmd4djJ6OTc1djlsUEpESjNVU2dWTXQyWTBVL1BPUTlB?=
 =?utf-8?B?dVZRNGQ5WURXSndpNkpjck5pZXBRaW1ZcFVBZUxBUVRBU3lvWjdSOXZYRmxn?=
 =?utf-8?B?ejROOEZ4SmJKMWNvczR1ZGlKUklhTW40MDNSQVhRN3FOS2Z0Z3RqbklyeWU4?=
 =?utf-8?B?ZlR3bGpEazQrb2lVbzRzcEdIWisvQVBuQkxOQXJHZjBsVnYvL3B0Tmt1b2NK?=
 =?utf-8?B?Y21BcVZRS0JRL0d2UFVyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b855e360-7a0f-4d63-c5aa-08d90e6d96db
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 19:56:49.6388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pumbEXCxTr0Vu1vp2TYIMy0to3232ASVJHpFRMHlpkdwOojx0bGbmMbMfp/SgZDdvEZtOLbO0WKHpirg6uQdaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5098
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

Am 2021-05-03 um 3:49 p.m. schrieb Jonathan Kim:
> To account for various PCIe and xGMI setups, check the no atomics settings
> for a device in relation to every direct peer.
>
> v2: apply suggested clean ups in main loop.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 61 ++++++++++++++---------
>  1 file changed, 37 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 30430aefcfc7..fb4f718a1148 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1192,47 +1192,60 @@ static void kfd_fill_mem_clk_max_info(struct kfd_topology_device *dev)
>  		mem->mem_clk_max = local_mem_info.mem_clk_max;
>  }
>  
> -static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
> +static void kfd_set_iolink_no_atomics(struct kfd_topology_device *dev,
> +					struct kfd_topology_device *target_gpu_dev,
> +					struct kfd_iolink_properties *link)
>  {
> -	struct kfd_iolink_properties *link, *cpu_link;
> -	struct kfd_topology_device *cpu_dev;
> -	struct amdgpu_device *adev;
> -	uint32_t cap;
> -	uint32_t cpu_flag = CRAT_IOLINK_FLAGS_ENABLED;
> -	uint32_t flag = CRAT_IOLINK_FLAGS_ENABLED;
> -
> -	if (!dev || !dev->gpu)
> +	/* xgmi always supports atomics between links. */
> +	if (link->iolink_type == CRAT_IOLINK_TYPE_XGMI)
>  		return;
>  
> -	adev = (struct amdgpu_device *)(dev->gpu->kgd);
> -	if (!adev->gmc.xgmi.connected_to_cpu) {
> -		pcie_capability_read_dword(dev->gpu->pdev,
> +	/* check pcie support to set cpu(dev) flags for target_gpu_dev link. */
> +	if (target_gpu_dev) {
> +		uint32_t cap;
> +
> +		pcie_capability_read_dword(target_gpu_dev->gpu->pdev,
>  				PCI_EXP_DEVCAP2, &cap);
>  
>  		if (!(cap & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
>  			     PCI_EXP_DEVCAP2_ATOMIC_COMP64)))
> -			cpu_flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
> +			link->flags |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
>  				CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
> -	}
> -
> -	if (!adev->gmc.xgmi.num_physical_nodes) {
> +	/* set gpu (dev) flags. */
> +	} else {
>  		if (!dev->gpu->pci_atomic_requested ||
>  				dev->gpu->device_info->asic_family ==
>  							CHIP_HAWAII)
> -			flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
> +			link->flags |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
>  				CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
>  	}
> +}
> +
> +static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
> +{
> +	struct kfd_iolink_properties *link, *inbound_link;
> +	struct kfd_topology_device *peer_dev;
> +
> +	if (!dev || !dev->gpu)
> +		return;
>  
>  	/* GPU only creates direct links so apply flags setting to all */
>  	list_for_each_entry(link, &dev->io_link_props, list) {
> -		link->flags = flag;
> -		cpu_dev = kfd_topology_device_by_proximity_domain(
> +		link->flags = CRAT_IOLINK_FLAGS_ENABLED;
> +		kfd_set_iolink_no_atomics(dev, NULL, link);
> +		peer_dev = kfd_topology_device_by_proximity_domain(
>  				link->node_to);
> -		if (cpu_dev) {
> -			list_for_each_entry(cpu_link,
> -					    &cpu_dev->io_link_props, list)
> -				if (cpu_link->node_to == link->node_from)
> -					cpu_link->flags = cpu_flag;
> +
> +		if (!peer_dev)
> +			continue;
> +
> +		list_for_each_entry(inbound_link, &peer_dev->io_link_props,
> +									list) {
> +			if (inbound_link->node_to != link->node_from)
> +				continue;
> +
> +			inbound_link->flags = CRAT_IOLINK_FLAGS_ENABLED;
> +			kfd_set_iolink_no_atomics(peer_dev, dev, inbound_link);
>  		}
>  	}
>  }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
