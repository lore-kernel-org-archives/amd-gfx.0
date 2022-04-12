Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F97C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 00:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E778C10E029;
	Tue, 12 Apr 2022 00:08:00 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2CB410E029
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 00:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhzhCuL7bPgyPIVPO9ItDabOmx+TuGVHPghLFPqqJwILxctaBntX5fkujai55wz9HdmRqHNlS4qscdK649gwHo53MAEhgb2kfSZhRw2vQMK8m36N+mfIsmKhFecFa43yUyYHzAVK2X/5LyXL8ijFRtMRcA6dDHJ3GoOVX5CiJ4TIvQvzTRCs3pDkhmr/QDurek9Krbvo6BykNJqAnEVaZTdhH7Q4dKHyU8ex6jpa7n2d4lCnDGbxgHDEeZ76IOopnj36WbANV3Zbuel9/1iwuu+hY0WjS2GEwVQbLMSAHp7vSqzATTnWzkVfBmYpv4NzzkAyOTMXyyFyLAn00bE+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqZ6s4KWfI6Iz3v8ewxazwnwkkXmf9ZTBqqBZhOSdus=;
 b=hDfUhwuZ80erQu8edbk05jME4HvR/m6pJvPYo7idRwfPOhtrJl3SFC0AssTqkeCAuRwHXYkNtr59BweXftXmcgzJLy6PqGOkHGiYggQs0errYsx5vYGtdnqJnH/R6DYT1Fhzu0kHjNju55zIxKBXfmg9saf7xNHIb5ryEm/xgKyOSdQo4ffJThkK0PHmhurlTpFJCqXE1JDP1O10Xjb2F/XfObFiqZnn70AXicSVjclZlP7fG+0749a8Tm0SBXBvahuJMHz8QZL7n1n4RnYfHWAP9Bp7UKhhW+W9onMSGVWGntCIvBvWtkRJ9wzN8X4FGJrjObNXNe98X6896OFcnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqZ6s4KWfI6Iz3v8ewxazwnwkkXmf9ZTBqqBZhOSdus=;
 b=S5rZlnKCbq+iJnvhwEhze8jN+PBjacYHR3dAV1zSEbRzpA0rvyXQ4pJyH/pURKvepsvmPCyvyIdrIVvpDWGgkI64Dd5TD3sIsSWzAZ3RImcPhmUB4uhEB4Tkn6+Wz5LqQc5v79NSu9zO3gUSE7bDHTAHDTHAJbjYLfjveaRjZoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 00:07:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%7]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 00:07:56 +0000
Message-ID: <e3caa6e0-cc37-41bc-7f68-971c74da0500@amd.com>
Date: Mon, 11 Apr 2022 20:07:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] drm/amdkfd: Cleanup IO links during KFD device removal
Content-Language: en-US
To: Shuotao Xu <xushuotao@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20220408084544.9313-1-shuotaoxu@microsoft.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220408084544.9313-1-shuotaoxu@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa085971-393a-4a34-e39d-08da1c187ef1
X-MS-TrafficTypeDiagnostic: CH2PR12MB4086:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB408656A28EEF2D3847BDFDBC92ED9@CH2PR12MB4086.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8cZS9Tb6SNcK6DqvVuyVSoyVln2d34lhS1Pbuqx7dSMwBp6QcuyJm9SlWAo/a5A+JRCHxZHV20jkeVgZzIZYa41GWDLrGJZrzcuHYk2LdKXLCtFZ67FfBcvjhmdB374jivSwQbfy8AWMUkhO3IQxQ8wtY12oT28CQ0oKD7FtKgv8t4UjK7GTagNI2YP6jV3sxb752U5VrAhs8neugRpJcbyfwE8vcarHmcldwySQGrHW+/8uveauxQ/N7jcK3s54yPx37YAVqWCoVOd5K83iTeRqzTGY8/MeMN1vRCclxOXsUX0uBTL0DK4UzfPmH1CI9C1zAnbkeO/8TPmsVb6It9wYfSgRNSUat4iK2ob8ULxMTG/lNAG1DE/jXps4aPtJUhaNe0pYVg7qItVIYeJmBEUIAOaWHjBVRv7OCnMaoPVa1N44bJri6OHMBob9mX//+3T/lOpXB7TwS31eCh3xyGIuUznyVFp3aHEtcJ5qN6Ockg5VzpvzH8MG47AcImYX51MTtS15OR8pQm4aUGRzfUMxEaMXQKdsg9m+70SiraRm1XBM5FhoagZ6QMKJKI34jq86Q+55J98uxtcHWKKtU/Ph6gID16rsaEpo1eYEsej1Okjcmah2NcTBwjyKTpyfQaKpcNZrL+KvJBHpMyB8ErU1rRNNlgsM0afDMvMHWj5qbhwA6e1DligcKovNLD9+0sGaa/Lpx6eCY9GNxplMyIka+txH6QGddf2JMC2W6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(2906002)(316002)(38100700002)(31696002)(6486002)(26005)(66946007)(66556008)(2616005)(36756003)(8676002)(6512007)(44832011)(6666004)(45080400002)(66476007)(6506007)(86362001)(186003)(4326008)(5660300002)(83380400001)(8936002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0t3VlZoT2luVkJpTFllWk0yOXF3RHFtZWY0M1pxbmRXRzFOWnBOU0Z3OFEw?=
 =?utf-8?B?Qm1qNmxwZVJ1eFkvVHZTeEZSOWJXVVVrbjdFdmdHcE10MXY5SEhTZ3g3U1JY?=
 =?utf-8?B?Z2U0QVRrL3AxMWt1WVZyMFluNzArYmUwcWtaZVU3cEZRcVlGWDN0WGo0d0N6?=
 =?utf-8?B?U2JzRDlMYlE4RmVGb29OczhXZ0x0Q0M1QkxNMnFSL1JQenU4QXh4aHQrUlk3?=
 =?utf-8?B?Zy9hbkRoUEtFUWQyWE5DNFFzcUxnZXFjbERKdjc5YXlDQ29BNlVoc2RES0Yr?=
 =?utf-8?B?Q0hqa0s4K0NubFZ1RlZiYXQ2c3lpYTF5b1ZwejcrNFdXMVFPSWllcVc4K2h0?=
 =?utf-8?B?U1dGSzZTVkpSREhlRDVtWFFQRnNYWEsvMHg5SzQ0Zk5Wd1hUZlVwRnRacjdE?=
 =?utf-8?B?U1YyK2d3OUZnRU1LcFE4RDNwalVnYkNibC85dW10UHZTRmxTVXdqWGp2UnFj?=
 =?utf-8?B?TGdySGxZbjkzYnVMdDY4UGtaNlhkaE9WZjlyUWhKMkpHeUVFTStHN1RlTmY1?=
 =?utf-8?B?ZkNuTUI2VEhNeDhxWlltelA0Z2E3WFBRZWgvd3FZeVUzdW5hanZVQ1dkcEVI?=
 =?utf-8?B?U1UwK1pQVHZRNE9Oc3YxZ3dWV3QyVlgvdXhQeXZDNU1MQXA5WVBQc0VkNU9Y?=
 =?utf-8?B?NkQ4UnRZS3V5MzFWTjUyL1VPeEZ3UUdhRkRvcnZncENXSHlRTTRQa3ZXYStw?=
 =?utf-8?B?Ly9GV1ZuQ01lcWlobXZhT25SdHdtOUZYVHpjNmd3UkhZNjkwNDUyeElyVG51?=
 =?utf-8?B?TGk4UWN6M2s5NUxRVTZKZWUwOHNWa1QvK3gvdWlEa0lXaUVnSHRJVk9Vb3Qz?=
 =?utf-8?B?c244VU5GY2o5TjFOZWNsWlc4cVZET1k1dXhkVGV0bk1QUlpTeTNuajFFL3pk?=
 =?utf-8?B?U2g2Z1Eya01FNDlOMUsraHZvVjdLcmlTQ3pWbEZ3RHptd044MGZQVE93QXhW?=
 =?utf-8?B?RThLQ1NxWElmWVA3cEU1c2txcUVuMUxHT2hPOFE3NFZ3V3NUYnkyRGZ3NGpr?=
 =?utf-8?B?NVRaOTBRb3FMMzhIUjVkY2dHaU5GT3JkcHhwZlBBTDNJOC9UWDFHckwyN0lM?=
 =?utf-8?B?VGR4SFg3SDRFbHl2OFRndkJrVllvenltak54ak9EOVVmYUQydGxnTzU0U3JP?=
 =?utf-8?B?L1VWYzBSVTE1NmRKSlFxODkzTlplakxGTTFsVitoMXhaZ0l6RjZRUk5QUi8r?=
 =?utf-8?B?T2ZyTGhHa0htcHZCWlYyUXBSSVdkclhIdTh5MGVqb2tESGhrOUVnbEx3UzZY?=
 =?utf-8?B?eGJ4d3Y3S0FRaTJYc1IzZWtyVXhOQVJ4Qmp6cnhUa2p4cURQRlpFQTJaRC9S?=
 =?utf-8?B?V1h4WFM1ZE95ZFZ4YUR4Mk0xM2lLZWU4akVXb3h2TVFSSlhXRGVLRDRPbm9x?=
 =?utf-8?B?NlI5em1Nbm5RWTFXT3pVcnFiY3BFRFA3LzJ6UjlYYVduUW92eVdLbzE1Ynds?=
 =?utf-8?B?ODVLMFJqWUs2L3Vycmd3ZFQ2eWkrNy9UMi9aSEU4azNKYURLZFk5aEJiUmtv?=
 =?utf-8?B?SEViczZJcGJKVFM1UzhFaWhualFjT0Q0RmxEVWR3c1FLcXBBMFF6RHp4dUNX?=
 =?utf-8?B?M1ZoUk1aOVVPRUY3S3NDZVFuaW5JbHF4Q3p4UEdFK0FUMnp0TG9kbnNKU3gz?=
 =?utf-8?B?Mk1iY3FHTHBpT0piRlB1OGN6UUhTTStKTVRWckxTdzVUN1RTSVRlMWM5UzVJ?=
 =?utf-8?B?aGdNTjlwaVBFRXl0encrWnVXSFRnS0VvRmxKVWw4VUkrTVVWS3U3RG5RSStx?=
 =?utf-8?B?VnFMdys2MTVTREk3eGcvVWNGN3R3ejl0b2JsVjhOUEtYS1FFbmJEelh2a0dt?=
 =?utf-8?B?b1hZWHFpSGcrUjFrOEZDMVc5MHZBdDgvM1RMcDZKZGdlWmI5T3R5Z1l1VTZ1?=
 =?utf-8?B?RFBXV1lJbGJmSkhuRDNTS0xnZENCZnhncUY2N3FGZmg2RXpVY2dlNE5pcWZF?=
 =?utf-8?B?di9BQ01ubmMrT3E0UjRpb1ZOZDN0QWRuMVBqWmpkNXJPUnRLWGtFakZvNEFB?=
 =?utf-8?B?M3p4cmhTRFZ2T0FsZDdLSEZqcU93NGtUak8yelo3TmZRQmJEVXZPSEU2Y1I1?=
 =?utf-8?B?Q1lTd2w0WkJIOHlZck1oMHRHTWFWOXdRd1NoTWRnRHRZYTVhUmRCVFpwMkx6?=
 =?utf-8?B?bUprQkJTVS9Ib0l6Y0lCbWJ0RjE3RSs0VDBWNlJ6SmR2NDFHalBZUTQ4cS9P?=
 =?utf-8?B?ZTZiaFkrQUdvekhLRy9VQ2pUNTM2UmwwMVRTajhyMVc0aG9xdXhEU3o4Vkhw?=
 =?utf-8?B?RHpVbVdvUnkyY0FVZTVEbGI5Q3RyT0NqbDJrcDR1cDRMRFZKTUdQOXlvSEcx?=
 =?utf-8?B?NFYxT1FJS2toNXBrRmtjZWVQMlkzT3VkWTBkUEZMQmN1VWxwdHpZQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa085971-393a-4a34-e39d-08da1c187ef1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 00:07:56.4813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VliJyAOyJZrXozYXZBFAelCzllLeVXQyt4tdfNejK8yQ5Vr8u23WHuItq+C3Hx1JB+Q4Iw0O8wMkqHNk+iXBMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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
Cc: Mukul.Joshi@amd.com, Andrey.Grodzovsky@amd.com, pengc@microsoft.com,
 Lei.Qu@microsoft.com, Shuotao Xu <shuotaoxu@microsoft.com>,
 Ran.Shu@microsoft.com, Ziyue.Yang@microsoft.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-04-08 um 04:45 schrieb Shuotao Xu:
> Currently, the IO-links to the device being removed from topology,
> are not cleared. As a result, there would be dangling links left in
> the KFD topology. This patch aims to fix the following:
> 1. Cleanup all IO links to the device being removed.
> 2. Ensure that node numbering in sysfs and nodes proximity domain
>     values are consistent after the device is removed:
>     a. Adding a device and removing a GPU device are made mutually
>        exclusive.
>     b. The global proximity domain counter is no longer required to be
>        an atomic counter. A normal 32-bit counter can be used instead.
> 3. Update generation_count to let user-mode know that topology has
>     changed due to device removal.
>
> Reviewed-by: Shuotao Xu <shuotaoxu@microsoft.com>
> CC: Shuotao Xu <shuotaoxu@microsoft.com>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

This looks like Mukul's patch, but with you as the author (otherwise I 
would have expected a "From: Mukul ..." line at the start of the email). 
Did you make any changes to it?

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     |  4 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 79 ++++++++++++++++++++---
>   3 files changed, 74 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 1eaabd2cb41b..afc8a7fcdad8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1056,7 +1056,7 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
>   	 * table, add corresponded reversed direction link now.
>   	 */
>   	if (props && (iolink->flags & CRAT_IOLINK_FLAGS_BI_DIRECTIONAL)) {
> -		to_dev = kfd_topology_device_by_proximity_domain(id_to);
> +		to_dev = kfd_topology_device_by_proximity_domain_no_lock(id_to);
>   		if (!to_dev)
>   			return -ENODEV;
>   		/* same everything but the other direction */
> @@ -2225,7 +2225,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>   	 */
>   	if (kdev->hive_id) {
>   		for (nid = 0; nid < proximity_domain; ++nid) {
> -			peer_dev = kfd_topology_device_by_proximity_domain(nid);
> +			peer_dev = kfd_topology_device_by_proximity_domain_no_lock(nid);
>   			if (!peer_dev->gpu)
>   				continue;
>   			if (peer_dev->gpu->hive_id != kdev->hive_id)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index e1b7e6afa920..8a43def1f638 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1016,6 +1016,8 @@ int kfd_topology_add_device(struct kfd_dev *gpu);
>   int kfd_topology_remove_device(struct kfd_dev *gpu);
>   struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
>   						uint32_t proximity_domain);
> +struct kfd_topology_device *kfd_topology_device_by_proximity_domain_no_lock(
> +						uint32_t proximity_domain);
>   struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id);
>   struct kfd_dev *kfd_device_by_id(uint32_t gpu_id);
>   struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3bdcae239bc0..874a273b81f7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -46,27 +46,38 @@ static struct list_head topology_device_list;
>   static struct kfd_system_properties sys_props;
>   
>   static DECLARE_RWSEM(topology_lock);
> -static atomic_t topology_crat_proximity_domain;
> +static uint32_t topology_crat_proximity_domain;
>   
> -struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
> +struct kfd_topology_device *kfd_topology_device_by_proximity_domain_no_lock(
>   						uint32_t proximity_domain)
>   {
>   	struct kfd_topology_device *top_dev;
>   	struct kfd_topology_device *device = NULL;
>   
> -	down_read(&topology_lock);
> -
>   	list_for_each_entry(top_dev, &topology_device_list, list)
>   		if (top_dev->proximity_domain == proximity_domain) {
>   			device = top_dev;
>   			break;
>   		}
>   
> +	return device;
> +}
> +
> +struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
> +						uint32_t proximity_domain)
> +{
> +	struct kfd_topology_device *device = NULL;
> +
> +	down_read(&topology_lock);
> +
> +	device = kfd_topology_device_by_proximity_domain_no_lock(
> +							proximity_domain);
>   	up_read(&topology_lock);
>   
>   	return device;
>   }
>   
> +
>   struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id)
>   {
>   	struct kfd_topology_device *top_dev = NULL;
> @@ -1060,7 +1071,7 @@ int kfd_topology_init(void)
>   	down_write(&topology_lock);
>   	kfd_topology_update_device_list(&temp_topology_device_list,
>   					&topology_device_list);
> -	atomic_set(&topology_crat_proximity_domain, sys_props.num_devices-1);
> +	topology_crat_proximity_domain = sys_props.num_devices-1;
>   	ret = kfd_topology_update_sysfs();
>   	up_write(&topology_lock);
>   
> @@ -1295,8 +1306,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   
>   	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
>   
> -	proximity_domain = atomic_inc_return(&topology_crat_proximity_domain);
> -
>   	/* Include the CPU in xGMI hive if xGMI connected by assigning it the hive ID. */
>   	if (gpu->hive_id && gpu->adev->gmc.xgmi.connected_to_cpu) {
>   		struct kfd_topology_device *top_dev;
> @@ -1321,12 +1330,16 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	 */
>   	dev = kfd_assign_gpu(gpu);
>   	if (!dev) {
> +		down_write(&topology_lock);
> +		proximity_domain = ++topology_crat_proximity_domain;
> +
>   		res = kfd_create_crat_image_virtual(&crat_image, &image_size,
>   						    COMPUTE_UNIT_GPU, gpu,
>   						    proximity_domain);
>   		if (res) {
>   			pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
>   			       gpu_id);
> +			topology_crat_proximity_domain--;
>   			return res;
>   		}
>   		res = kfd_parse_crat_table(crat_image,
> @@ -1335,10 +1348,10 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   		if (res) {
>   			pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
>   			       gpu_id);
> +			topology_crat_proximity_domain--;
>   			goto err;
>   		}
>   
> -		down_write(&topology_lock);
>   		kfd_topology_update_device_list(&temp_topology_device_list,
>   			&topology_device_list);
>   
> @@ -1485,25 +1498,73 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	return res;
>   }
>   
> +static void kfd_topology_update_io_links(int proximity_domain)
> +{
> +	struct kfd_topology_device *dev;
> +	struct kfd_iolink_properties *iolink, *p2plink, *tmp;
> +	/*
> +	 * The topology list currently is arranged in increasing
> +	 * order of proximity domain.
> +	 *
> +	 * Two things need to be done when a device is removed:
> +	 * 1. All the IO links to this device need to be
> +	 *    removed.
> +	 * 2. All nodes after the current device node need to move
> +	 *    up once this device node is removed from the topology
> +	 *    list. As a result, the proximity domain values for
> +	 *    all nodes after the node being deleted reduce by 1.
> +	 *    This would also cause the proximity domain values for
> +	 *    io links to be updated based on new proximity
> +	 *    domain values.
> +	 */
> +	list_for_each_entry(dev, &topology_device_list, list) {
> +		if (dev->proximity_domain > proximity_domain)
> +			dev->proximity_domain--;
> +
> +		list_for_each_entry_safe(iolink, tmp, &dev->io_link_props, list) {
> +			/*
> +			 * If there is an io link to the dev being deleted
> +			 * then remove that IO link also.
> +			 */
> +			if (iolink->node_to == proximity_domain) {
> +				list_del(&iolink->list);
> +				dev->io_link_count--;
> +				dev->node_props.io_links_count--;
> +			} else if (iolink->node_from > proximity_domain) {
> +				iolink->node_from--;
> +			} else if (iolink->node_to > proximity_domain) {
> +				iolink->node_to--;
> +			}
> +		}
> +
> +	}
> +}
> +
>   int kfd_topology_remove_device(struct kfd_dev *gpu)
>   {
>   	struct kfd_topology_device *dev, *tmp;
>   	uint32_t gpu_id;
>   	int res = -ENODEV;
> +	int i = 0;
>   
>   	down_write(&topology_lock);
>   
> -	list_for_each_entry_safe(dev, tmp, &topology_device_list, list)
> +	list_for_each_entry_safe(dev, tmp, &topology_device_list, list) {
>   		if (dev->gpu == gpu) {
>   			gpu_id = dev->gpu_id;
>   			kfd_remove_sysfs_node_entry(dev);
>   			kfd_release_topology_device(dev);
>   			sys_props.num_devices--;
> +			kfd_topology_update_io_links(i);
> +			topology_crat_proximity_domain = sys_props.num_devices-1;
> +			sys_props.generation_count++;
>   			res = 0;
>   			if (kfd_topology_update_sysfs() < 0)
>   				kfd_topology_release_sysfs();
>   			break;
>   		}
> +		i++;
> +	}
>   
>   	up_write(&topology_lock);
>   
