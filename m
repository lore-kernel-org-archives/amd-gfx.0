Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D165C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 02:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE5AD10E155;
	Tue, 12 Apr 2022 02:30:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD3D010E0AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 02:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhGd4B9Y/QKhoblFRDMJIKHj3nDcvi9GG7Kpy6cIHB1QZDqIVwEAXxBieh0hXLnBN/t/ZGhH3Qkw6MSOwLo2hjQ1k4bcqBZ9GhYEjNc9ARFyRPsaTFrWQNWN1zzdrFR4mzv8qYvBZE9CQRvorWWgAQDMmL2hILAZJnfbxFapwn9foxLriLzSHbFKXa4lbc1it6eUQ5bJB0m3mpLdJk/Rp2yjvb/xA6tbJ2+0nOeRiynUKCem1ooyEtsEvO4IJGwLSLgXBgPRJqqq+6B/mpHYRMK1AfWMx9ycg789r0MLIKhVNkqjjp2CLmSO3rFY3Sf/Zr6d2FBLHRI/QcG+mhyOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vltgm+QJv+vYHaBUFwzoxA5uuXruvwhgIsNLbTQH/jc=;
 b=FmbHqSnMAKSwkluiHxfdxDMGOQCYYPgjQfUHGdSkghI+nAmhOH2yUvLTplR5uVY356lRxk6GIP7JwkUlTWIVJSNQtwBA/Hk2aeCCgUofoWRdVAkxCbdIO/3JeypCw9Exk6en8Ozi/KqMeP8MQ6jCIERGzKXuga/iDW0YSxE0/v478A1yBUgrXsSBS7VL3mrWIYlFf3h/IMOLwOG4Llit4ifE6Xt5DuYaW4KrxTg0fmrNCpg8xhGb0VzZxM9dukqa/aRzfZ1jruXM7FSfU5KKeg15zFRAZGEXNO6/PQvyCQKsPY2kInjNdcZdgjnsSZXYqRj5oqtU3KFAxDoUOcl+3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vltgm+QJv+vYHaBUFwzoxA5uuXruvwhgIsNLbTQH/jc=;
 b=Yad/EUMcCqJ7zCyfqzTHa88VJCWnCMNjcNSQbe5XCGaCzfonizvqSVFdV92XHqSuHiI0nD+rzZ0aXv/9ZkkT6iPQ17U/x7U2Tdi8hcZ7uwYPfbnbhcZBwLrd4GO6S370cL5GlQIixdQnuTgM51J1CbhzUIlMjHA1VpNKQ+KVSag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 02:30:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%7]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 02:30:17 +0000
Message-ID: <999f9f96-4c5e-2211-0ff7-0988be3a503d@amd.com>
Date: Mon, 11 Apr 2022 22:30:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv2] drm/amdkfd: Cleanup IO links during KFD device removal
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220412021531.822370-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220412021531.822370-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ae99222-304d-4465-a722-08da1c2c61fd
X-MS-TrafficTypeDiagnostic: SA0PR12MB4575:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB457585F2DB9F30D681E29B1692ED9@SA0PR12MB4575.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RjDMi/7dtub7uFmP7oiE9l8EUpAKfQPY2yUNegXkgYTUgsPNwrIqx+pwZ4R3sfWDkqBVjM0TxedyLh9tN3QOg9qLruXd6RzaMDwB5znuhkzwXVHsOoc69+CLz6IpOn3jDXiv4oJGFjYcTz8vyN81DrGJ+TDC6+WBgUhPnc1RicJYddbUWIzyZSdHDJe7xj4fv5YYOr2+ykgH4PdWCSKTswh13aItDcUCZ/Cd/4f9J9TyppANxVUXDgsjfe/s67lqoedyRNzbUqf1Kr2IO8vGvQcf2RYH/cAcv+2hPax4Hem5tNMsc153JcQSmM3eSL7yUcqHoKWAbSpIMDpRKlYIiCOYaHelEQC6KtGl5SM8hk9eUhnj1YEssyYhlXFSRqtAEB4vDmR29HydizzuZ7K5pxnz2tdHYnFuEjVbemwSjTTno6CkAokaRlvTaU6jPcj7Ri1PvVWsEFiZlGSEcvKPpOBdu7yzvE+ulTE+8aAgrTYTeis3MjgbpuHnNeBvGyZNPm06n4Bb1vvpcFpQa7TdqL6vgLGBApk2LCx0GdU/cWqxwuyPGlLgbDocrzVxfzGu/FcDk21OwoeRBeQHh3QgdaQfPa4Vz9iD19Cl9VodYtuo6JW4DYRb2R4Rnjw5TooRH/7TnlfQrdYcbYudKD6c0cWzPM8T0dmQs0q48J9AiDuvOYGEapa23UCHmZBlAiKT8QT5mQDum5gO6VWsdJ7qyVJ3zgUW+1KHKswOqhL1JVf/ObuqXAi9+8UEmsxcRjkM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(45080400002)(8676002)(316002)(4326008)(66946007)(31696002)(66476007)(508600001)(36756003)(86362001)(83380400001)(6512007)(31686004)(2616005)(66556008)(6506007)(38100700002)(2906002)(44832011)(5660300002)(186003)(26005)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkxuNlZ5bHhFZXhDd0lESFE3QzFIa0VwVmR0b2pqL0NUMW9wN1lzczRYZEdO?=
 =?utf-8?B?UjBBWFI1Q1VNRzIrR1E2MjhSQVpkT09yWWJYZ2g3N0NPZCsxT1BPYWdkR0p1?=
 =?utf-8?B?dGpLWFlrQzN4cHdmOWl5Vk01OU9HSEcvZi93RXJJa0tFZWJmdXR5dFRuUEkx?=
 =?utf-8?B?V1gxRlFKY1BlK1BQbVd6djN4bVFVbGMydTlKTURSTWxaQ0lUZDQ3N2Zrd2Nn?=
 =?utf-8?B?TDVNS2pKTXFOY0RvTWl0OFp5RUE4V0wyOTk1cTVEOFFveTZyRUkzUURrYnR5?=
 =?utf-8?B?eWlVUmxLYktpcUtzNytrRVFNQ0hNdENSVFliWnFuLy84dVZrSW9mdFlFbFlL?=
 =?utf-8?B?OE0rRXdQbXlhRysrWWZXTHV5dUFmOEVkQ2NIM0liTktRQVpneTNrdUpuYTVs?=
 =?utf-8?B?VndyK1RCTlgyU0NFc1RQOXA0QlRSZ1I5YzBoMXBVcm43Q2JkVE5yd20xUVhW?=
 =?utf-8?B?NTFkd3ovT1VwNmwraHpsRTNPWXI5K05maEpwMFNtMG0zblo2OFZYbEZjem5K?=
 =?utf-8?B?UUN4amJOOGZ6NHNROGY4SE9BWHNnR1hYbUpSeE1sV1lKY3hGNGRRdG16Y1ZE?=
 =?utf-8?B?bjExQ04vUkpjeEI4Y3JGTXM3aEtPUUZRQzJkaFVJSms1akRSV3E5NHRPUi8r?=
 =?utf-8?B?a3lJV3I2WkxCdGhudFBOdFYvUWtqNjZ5amF5Q2JTWkYzQk5EQkhlZnd6S0d4?=
 =?utf-8?B?UGRXbDlmWXJVekxOTHlscUNWNTJ2enRwYU1SVXpYR05EMm81Y1VMSG1JK2No?=
 =?utf-8?B?Y1JtRGZLd1JydVdUaWJkc0VXZ0JGS05MYmQ2eVlyUU92ajBxc2VkS2FLYkJo?=
 =?utf-8?B?eTZhQVZpaVdLeHhmYkhVOGxlVEJRcnlvRVNtOFp6OUp3bFpoNk90SUpRZ0N1?=
 =?utf-8?B?NG1hZDhLOEl5VldTVi9hMjEzZ0UyNTFiME1yZlJSc29SMEdNQnN2OVdPZ3JF?=
 =?utf-8?B?Ukh6NzBkRlBSVXJVcFpubmpmejZCdVpCRlY4bk1iUGRvaEt3QkhCTUkzdGk2?=
 =?utf-8?B?dWRqN2dGRmJKL1JqeXpmZ3NEbEloRUE2RUJKckJIUFo0ODZ1aklYWjMyd3ZM?=
 =?utf-8?B?a1JmbmZESjV1K2F0MUtxMHlNZkx3UEo1OWIxQVhFZUpmbnNHc1U0YXhwYlNl?=
 =?utf-8?B?SFFraU9BTnl6YkQzMmp6RDN5Rlh1RDZNaWVQZDdSalNsMWdPK1prY3dpbnVT?=
 =?utf-8?B?K2VCQTBmbVJlbzZvMGY0eXVnU24xR1ZtYU5vRkRMNnFzQW1ZUlJBOVJJTEdo?=
 =?utf-8?B?dTJES0ZwTzVpVlA1bVd2eFV3ajk4azVsVEViVUxWMU1LMXZmWjhaL1FYRnNi?=
 =?utf-8?B?UzBCVjgxUkhFWkZtSzQ0RTZ1aFJsZThpV1pYRG1tcWJSd3E1OEFwbFFjdGdv?=
 =?utf-8?B?Rnd0OFk4SDdQWnRrYWRRTWRvdFhQdlltQlFqQXFrLzVTYXZiYy9OQUY4MWN6?=
 =?utf-8?B?K3hGT3Ftb1FCcjNLaWtIZWhOeEkzczBiQWgzOU5hZktBOERRVyt5aXFOZkNr?=
 =?utf-8?B?V0g0cElzSC9JdDRZUE5HVVdNVnFuc01ZNDljRkFkQmlMTm92ZFU4RGU0WjJy?=
 =?utf-8?B?NlhkVjh6RGFYOFppWWhDKzJBSTVnSExRZ3dtcE1ody95RHJVRmR2VUd5Qloz?=
 =?utf-8?B?Y2RMTE1RZnVsa1NvOGhTaVhvbnRhK3EwUkRFTHdlalNNVWFETEtGVWVqbXow?=
 =?utf-8?B?MlBNYWt0OHFBTnBlbnlsRTBmK3J6R2QwdlNUQmNXUEI4NUJhVGJkeEZHTHR0?=
 =?utf-8?B?YTNlMUhNVlpCTlJZM0dDaEtLM1A2ZmkrR25ueGxsaTFnVUd4Yk4rdkNZdFdX?=
 =?utf-8?B?Njd5Q3hORzEzNGx5VTBNVTJvU2dlWGROY2tOSmVhOGxjWGJCa0FiRkhHMDN3?=
 =?utf-8?B?K09lSThSYU5hMXZpMFZIRUZ2T1c3eTBHNkJNclg5QUpBUS9vK29vNnAzWmxH?=
 =?utf-8?B?RXkvUVJIN2VNZ08zZjFxaU1GdU5QbDkvRXVvb280dnRBZnlLVms0WnFrMGQr?=
 =?utf-8?B?QlFqRzlxQ2Q5dTlyeTlQZW93UjdpQlhDcDlnTGJjY042K2J4QUJOUHpzczQ2?=
 =?utf-8?B?allJNy8wRmR6S0gxMjZ4WFpua0tmOElhZGQxcm9la2ZlY0VGa0hQUS94U0la?=
 =?utf-8?B?T1RmRXVac0l5NUthUjFJWUJnd2puT1BSQ0RIbm02WG02M3JIaUVJaUUvTmZX?=
 =?utf-8?B?aXorK0xiLythOUo4V1d6cDg1cjFsa2taL0M3elBqTGlpMmRYSnRHakVjdzNM?=
 =?utf-8?B?TDRWOEtPdWFiOVE2VGF4S1JNTlJ5YTZTVldoRzRqTEovQm5TUjRzdWxlQWM3?=
 =?utf-8?B?eDhiTmVtQmJmcGNYOVhKZXoxWjhkZ3dsbWxnQmRtVFFkc1VuTWdaUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae99222-304d-4465-a722-08da1c2c61fd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 02:30:17.5279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZOtD5ZPAjvpwUasm5H7wl6enQVeVy9o8M6PZEaovbBYzm551Y2JOnqousoQbNnoaKfXwJ4GqBC9bTAGH5Z99A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
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
Cc: Shuotao Xu <shuotaoxu@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-04-11 um 22:15 schrieb Mukul Joshi:
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
> CC: Shuotao Xu <shuotaoxu@microsoft.com>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> Reviewed-by: Shuotao Xu <shuotaoxu@microsoft.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
> v1->v2:
> - Remove comments from inside kfd_topology_update_io_links()
>    and add them as kernel-doc comments.
>
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     |  4 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 83 ++++++++++++++++++++---
>   3 files changed, 78 insertions(+), 11 deletions(-)
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
> index 3bdcae239bc0..98a51847cd8c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -46,22 +46,32 @@ static struct list_head topology_device_list;
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
> @@ -1060,7 +1070,7 @@ int kfd_topology_init(void)
>   	down_write(&topology_lock);
>   	kfd_topology_update_device_list(&temp_topology_device_list,
>   					&topology_device_list);
> -	atomic_set(&topology_crat_proximity_domain, sys_props.num_devices-1);
> +	topology_crat_proximity_domain = sys_props.num_devices-1;
>   	ret = kfd_topology_update_sysfs();
>   	up_write(&topology_lock);
>   
> @@ -1295,8 +1305,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   
>   	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
>   
> -	proximity_domain = atomic_inc_return(&topology_crat_proximity_domain);
> -
>   	/* Include the CPU in xGMI hive if xGMI connected by assigning it the hive ID. */
>   	if (gpu->hive_id && gpu->adev->gmc.xgmi.connected_to_cpu) {
>   		struct kfd_topology_device *top_dev;
> @@ -1321,12 +1329,16 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
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
> @@ -1335,10 +1347,10 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
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
> @@ -1485,25 +1497,78 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	return res;
>   }
>   
> +/**
> + * kfd_topology_update_io_links() - Update IO links after device removal.
> + * @proximity_domain: Proximity domain value of the dev being removed.
> + *
> + * The topology list currently is arranged in increasing order of
> + * proximity domain.
> + *
> + * Two things need to be done when a device is removed:
> + * 1. All the IO links to this device need to be removed.
> + * 2. All nodes after the current device node need to move
> + *    up once this device node is removed from the topology
> + *    list. As a result, the proximity domain values for
> + *    all nodes after the node being deleted reduce by 1.
> + *    This would also cause the proximity domain values for
> + *    io links to be updated based on new proximity domain
> + *    values.
> + *
> + * Context: The called must hold write topology_lock.
> + */
> +static void kfd_topology_update_io_links(int proximity_domain)
> +{
> +	struct kfd_topology_device *dev;
> +	struct kfd_iolink_properties *iolink, *p2plink, *tmp;
> +
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
