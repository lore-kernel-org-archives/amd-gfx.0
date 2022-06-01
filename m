Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355C3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 16:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E56510EF27;
	Wed,  1 Jun 2022 16:40:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CBE910EF27
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 16:40:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RybHlOmhs1tQUxSklwNO1lQKHMmIFcWnaMoaTAHNnj8Cl0uQiMsokfLRbI8uJV/YfJv3GXI/EJpTHiIctuVlsa4/3x51ofihGNvhUi5STHTFjhKmFXfnR0f3Gfjnmjt3DGel0O2GBr3qaz+3zNk1iqgcHUJxqtxt8K1dcMBkMQtT3K4is6rGEt0Yguslk+uU76jpEIdaVsVPFHhg1OM4tW7ZWwKY02A9RI9JLQUqOD2Girv//rbKsnIa4d4dMljfo/cOMEIPhF5Dygi3koCDh5db7oqBxq3/e2UoXVaagq/K1ELUNZYCe9fnDMUdyLIHQPcpShME9Zr4tm763Izl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlhA+cdingmMbnNlZxnwtRVe+NidD2cdH9TafUMUQao=;
 b=X2/Ci+TzUNQ5mgjyDVdmiQrcSUTvVRoUjCUKjjEYhkkI3ewvQFeob0R1qo3wYN9UjiA40RV7yoVeSe70H89IUip3La90n3+JVHWDl5ljnx3PN/vrKf+JRb8UDcbJ21MWBasx7MM6vRuD6Gpo1oyTyRARZR4jCPtsHKt9vIyRpBx0mPBB9dMNYSCKq9CTGxA/0OKV3+Rw2YaLunLSrsTRFLFTeNL5ke5Xyuas8hW6HdqefcZZ+SX508Cjmh93YsOe0NMBx91kayQcR92O5lwZQRvoBwhZtClydlWVcbyLX5LdGw3JVqVKc9XXwD71Asiv8CU2rJvU4fvgPqWXbsnOyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlhA+cdingmMbnNlZxnwtRVe+NidD2cdH9TafUMUQao=;
 b=Ea/LLvOSYHksQVIuURLS0l2s46vmZ6udULt0xJ0M/TEhE73bDmtrNEN0N/afjOMLgHGeS8aC/s53fJGWdl0gX2dJYSg4cyfRb7WMIlIzhVif+/876hhbnY1iKSjExT3yKdEgo1hcwYVlVnVznumxRfxo86+NbZmqQHSNzwN4wkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Wed, 1 Jun 2022 16:40:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 16:40:05 +0000
Message-ID: <990aa220-ba2b-417f-7e7a-85a7df4998b0@amd.com>
Date: Wed, 1 Jun 2022 12:40:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] drm/amdkfd: Extend KFD device topology to surface
 peer-to-peer links
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220531170301.819284-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220531170301.819284-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ecb2a7a-08d7-4b0b-fc6e-08da43ed618f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5745:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5745E4740227A8B6D05017F792DF9@DM4PR12MB5745.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KnlGcvnOuj3Kfq8Xmc3OSKKXDJJm0ZfwFZcg5eolYndeJY314wEFmMmqwmL096hhepGdSvr2HAkhu3GrZzaanKvFB3fwvIO529JqggmALEYQEd2GAfXSfDtISYgcrjZH7zb9HQ6TumdZTh4M0PlG0AC9UQXKHhOQzmGqao3/BYbuwPWqNNC8WJYJ7kzteDm8EssqZRWdUlyWeJa5of6829lZjckoYaNad7pu+gbilniH48PalGEMzvBtzPxbVr6n2oyOH39lrWl9RXtOfsqUBrzSlnERIfwH6NNR0rowcMy9DcKDxNF58BiQ1T6tiWJipBLlrVJvXkm2x2Yn8io3RGMdunols0h49h6WMu/iWy2VBqaptI+GckYVrRmK7dRt8OcwqyR4YhryMLw6C7z7QG3+dNBL/eFbD4lUyliWIdZoScNZWqV8lPhydcGkxM4qLXSjA3IQ2y1GFXD0/fQnrwMnS4cnb3eSMETzh74vgdZonCc15XUdGaRTLCCX/NY6IymEM15v4N5W14oWKwT3mwkyofb42D2kVn7j7YPDLnXhGwulpnvFeMZZmWWAih7jE8O1+TAMb3md+INtDBeQdrDw3aHvmcfrHoadv58NsanaYQdWHF7q8k2xfVuRRRT6sa0SvA5Td2XhVwT4sj0ncuWlDqBKwjBzNfA9f2FUyYs74qIfmweXlxLL6w2uNrhY3niIVNRiRm0m9cRh88vnh4p6/1PGcpHctuM6HoDRcZpAWASdZK8kzKc6hDajNHKk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(6512007)(2906002)(38100700002)(2616005)(186003)(86362001)(31696002)(316002)(44832011)(26005)(8936002)(66476007)(30864003)(31686004)(66946007)(66556008)(8676002)(5660300002)(6506007)(508600001)(36756003)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0d4cy9MWlM2QkIySjNiMit4aFVJTHl6cnlyb21FSXN3c0hZSUR2NWtUa2l5?=
 =?utf-8?B?ekR0NTRFVjZJSXZTQ0JwYmFOQUhlVXZHZnFtMm1BOVljSnVXRWkwbzFTcHAw?=
 =?utf-8?B?cXhhWjNraXo2N0VVenhwOVhuRTR5MVYrN0JnNGRCak90WFRwRFl5MWlvMldU?=
 =?utf-8?B?L1RaWjhnVFJZenJWZEppQWhTMHFQOVNKSGhjQURuWWxVV1VBeVBTNDdRTktz?=
 =?utf-8?B?aGMzMElYZGJodWFtQVUyVi9JcmNueXQ0bjFkY3dnS0RZMENoOEk4c2c2cEpG?=
 =?utf-8?B?R3hHWCtmbjRCZVVacjkrYmFyNGt1aFZZUkNDU0FtSDkvcVVuZVB4Y0EyVUZ6?=
 =?utf-8?B?eUhucE9TUnlTenBQak1pTXNxNXVzRHFVaUc2cXhhemVyVTdYL1RncXhJSzBS?=
 =?utf-8?B?WHJvR2haZXFhOGZQd2pMb3JOY0xTWmVOTWlGU3d3T01VYTAyWWlUZHFPTzlI?=
 =?utf-8?B?cS9uZVNadzBpNG1VRkFNYUtURGpmK0NVU0kxRDlZYSs0RkFvZzJGOHVKNG9a?=
 =?utf-8?B?MVlsNXZGdU9TbjloN0FvRGU5U3IvdmcxMnpXQVlhUGlPM2JRUU8zUGVYSWNm?=
 =?utf-8?B?dWNjbnF5MFVUNDlFRTRLeUNtTTMzaisvN3NYRW51Q1p2ZEFOQlJ5N3phbkJS?=
 =?utf-8?B?L3RKMGpIWC80KzVJc2V2bDhZRERhY1gvZ0FuSGZZK3dkajBwRTFwRStpVzNH?=
 =?utf-8?B?Y0RWQUlGNGVMREhSSWIzMG1yK2pwOXNXZWpYNGF0MTNmb2ZJZmRhT2V1S2Ju?=
 =?utf-8?B?SGxSaEpHdzFQMEovNW9nVWpaYVFXYktTZFpyZnF1UkpJMUM1M2xvM1hyZkNR?=
 =?utf-8?B?dnZtdVVPOWE4dUcvck83Qm1MbXJST0MwWFhtUXo3OTNMY2Y5ak03L0xsbW1i?=
 =?utf-8?B?b25TRDNGbjh2bWVSaDRidDFqM1F6NmdUeFpyWkFxTi9tVlFZU3g4U1FqYUZH?=
 =?utf-8?B?VUl2Sy9LVnZWLzRzOEpqellFb2pxcWxDTW4xTUhXUzJjT05lcnE5cUwrQ3JT?=
 =?utf-8?B?MEFJUTJUVmVsNFMrTlZKQ1FUNUJzWlpOd1JleTJSdzQ2ZzA4c01pSjZ3S0VS?=
 =?utf-8?B?SHVyUlpNM3BkenRqYWh2RzZSdnpKb3loazBuL1lJN3FxVWFxWk5SclBmVWdU?=
 =?utf-8?B?QzV0aEYydTRhVTBnbk9NSDRkbGcxRWNBdVNGZkpXVkhGZlE3TlBqelNVWmk2?=
 =?utf-8?B?aVAxeVZzYVVnRWtiMGtHS3g3ZW9FWEhuR3MrNHhGU3doRlNvRThOMGplT3RQ?=
 =?utf-8?B?RmFWM1picEowSlVjTm1nYVY5RjZPc1I4dy8vVXNFYUdYQlFNNFhRN3JFaWVr?=
 =?utf-8?B?ZHd2a1AveTJyZmh6dTZ5aVdObUM1SVJYVTFsNkh0WUJSVk1CMWdJWUVvaGo1?=
 =?utf-8?B?Y1pqS1hIeXo0TWkzZWMzbTh5TlJZeEdYM1dyNmxRZUdoai80YjNnUE1qTnh1?=
 =?utf-8?B?eUdwTzB1MEIyTm9FQjl3NE9LbWJDVHZ0NWlxcjFLVnZaejZTRVgvaDB1M3JY?=
 =?utf-8?B?NUtCemhScWJtc1JiRUwwN3pONEhNb1NpUDhRaEYvbTZJdG9adFc0YzE3ZUxC?=
 =?utf-8?B?T1VOaVo5VEkzYXpXSlBaZ000ai8xbGRvWjl4UGk3KzNNU2NENEtvb0J1NTBH?=
 =?utf-8?B?NFB3SVJISkVPQW9SWXREOEdtWXM5UE5wS0pRR0lVei9oSm1pTXlaTDNqaFBv?=
 =?utf-8?B?VXdIQVlLZVNZSFVsM0l6ZFlvNXkwcm96S2ZMd0JiM0pxaDg2bVVVWHhNbDhF?=
 =?utf-8?B?L2trMFpwUHBkaVRPNndWZWw4d0NPK3lQM2o4aGxxWUZtU3F2dUszZkZKUGhR?=
 =?utf-8?B?MnFZZDhncDNjb2VCN01zbmxsVmxxWS81NTlWalU3YkdxcnhBaHJINHg2U2dy?=
 =?utf-8?B?c01BVnZmYkZVaXpWeEIxR3c2RmpsYlY1TVc1WGVZRWRaci9jVXFMNlI2dXZY?=
 =?utf-8?B?eXVyQzdZUVBSelVjUUNOZW9yVWpFWTZUeGw3ei9aSmQwU1IxeGF2RndiR0Nv?=
 =?utf-8?B?MVI5MEFkVFQvbWVrejNndjh4Mk9OQlVYUEQ2NlBEL0pEdHlrdzFQYnp4a3Az?=
 =?utf-8?B?bno4SjhsdVIvWCtBZUlYYklLVXRnTEJwVmFtc094N2twOVM2RW11VWtZZnZD?=
 =?utf-8?B?VWpJRStzcGRqckUwL3hMMTRpSGZtUG4xa3VQRnhtMzUwRHExQkpRZXlHZ2x3?=
 =?utf-8?B?YS9BSWJyQ3FrNjNwSkVUSnNKbnkvL1A2eWxBbVdJMWJ4dkozVVdTNGRocGVV?=
 =?utf-8?B?SVFBOWdMZytEMElIVklCMEdJajZ4N0dPOVJOLzQvL0hrRGxDbFJWRW9TOTlp?=
 =?utf-8?B?MjdBUDdybkJNSGFyWnF5eGpDY2lXYVdZZTk4ZlBJRnk3RmpCZGtydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecb2a7a-08d7-4b0b-fc6e-08da43ed618f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 16:40:05.1994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kk7qagCUEZWAAyP5uTJfLXRJAZvTtNGClwXIbxR+JFLMiL11MZdZUEwAoBHk+/20f8pxPPcPsmnlmagdhzLsiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
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

Am 2022-05-31 um 13:03 schrieb Ramesh Errabolu:
> Extend KFD device topology to surface peer-to-peer links among
> GPU devices connected over PCIe or xGMI. Enabling HSA_AMD_P2P is
> REQUIRED to surface peer-to-peer links.

This patch needs more of an explanation.

Old upstream KFD did not expose to user mode any P2P links or indirect 
links that go over two or more direct hops. Old versions of the Thunk 
used to make up their own P2P and indirect links without the information 
about peer-accessibility and chipset support available to the kernel 
mode driver. In this patch we expose P2P links in a new sysfs directory 
to provide more reliable P2P link information to user mode.

Old versions of the Thunk will continue to work as before and ignore the 
new directory. This avoids conflicts between P2P links exposed by KFD 
and P2P links created by the Thunk itself. New versions of the Thunk 
will use only the P2P links provided in the new p2p_links directory, if 
it exists, or fall back to the old code path on older KFDs that don't 
expose p2p_links.

See more comments inline.


>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 332 +++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   3 +
>   2 files changed, 333 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 8d50d207cf66..6bdc22d6f6ab 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -40,6 +40,7 @@
>   #include "kfd_svm.h"
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu.h"
>   
>   /* topology_device_list - Master list of all topology devices */
>   static struct list_head topology_device_list;
> @@ -148,6 +149,7 @@ static void kfd_release_topology_device(struct kfd_topology_device *dev)
>   	struct kfd_mem_properties *mem;
>   	struct kfd_cache_properties *cache;
>   	struct kfd_iolink_properties *iolink;
> +	struct kfd_iolink_properties *p2plink;
>   	struct kfd_perf_properties *perf;
>   
>   	list_del(&dev->list);
> @@ -173,6 +175,13 @@ static void kfd_release_topology_device(struct kfd_topology_device *dev)
>   		kfree(iolink);
>   	}
>   
> +	while (dev->p2p_link_props.next != &dev->p2p_link_props) {
> +		p2plink = container_of(dev->p2p_link_props.next,
> +				struct kfd_iolink_properties, list);
> +		list_del(&p2plink->list);
> +		kfree(p2plink);
> +	}
> +
>   	while (dev->perf_props.next != &dev->perf_props) {
>   		perf = container_of(dev->perf_props.next,
>   				struct kfd_perf_properties, list);
> @@ -214,6 +223,7 @@ struct kfd_topology_device *kfd_create_topology_device(
>   	INIT_LIST_HEAD(&dev->mem_props);
>   	INIT_LIST_HEAD(&dev->cache_props);
>   	INIT_LIST_HEAD(&dev->io_link_props);
> +	INIT_LIST_HEAD(&dev->p2p_link_props);
>   	INIT_LIST_HEAD(&dev->perf_props);
>   
>   	list_add_tail(&dev->list, device_list);
> @@ -465,6 +475,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>   			      dev->node_props.caches_count);
>   	sysfs_show_32bit_prop(buffer, offs, "io_links_count",
>   			      dev->node_props.io_links_count);
> +	sysfs_show_32bit_prop(buffer, offs, "p2p_links_count",
> +			      dev->node_props.p2p_links_count);
>   	sysfs_show_32bit_prop(buffer, offs, "cpu_core_id_base",
>   			      dev->node_props.cpu_core_id_base);
>   	sysfs_show_32bit_prop(buffer, offs, "simd_id_base",
> @@ -568,6 +580,7 @@ static void kfd_remove_sysfs_file(struct kobject *kobj, struct attribute *attr)
>   
>   static void kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)
>   {
> +	struct kfd_iolink_properties *p2plink;
>   	struct kfd_iolink_properties *iolink;
>   	struct kfd_cache_properties *cache;
>   	struct kfd_mem_properties *mem;
> @@ -585,6 +598,18 @@ static void kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)
>   		dev->kobj_iolink = NULL;
>   	}
>   
> +	if (dev->kobj_p2plink) {
> +		list_for_each_entry(p2plink, &dev->p2p_link_props, list)
> +			if (p2plink->kobj) {
> +				kfd_remove_sysfs_file(p2plink->kobj,
> +							&p2plink->attr);
> +				p2plink->kobj = NULL;
> +			}
> +		kobject_del(dev->kobj_p2plink);
> +		kobject_put(dev->kobj_p2plink);
> +		dev->kobj_p2plink = NULL;
> +	}
> +
>   	if (dev->kobj_cache) {
>   		list_for_each_entry(cache, &dev->cache_props, list)
>   			if (cache->kobj) {
> @@ -631,6 +656,7 @@ static void kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)
>   static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>   		uint32_t id)
>   {
> +	struct kfd_iolink_properties *p2plink;
>   	struct kfd_iolink_properties *iolink;
>   	struct kfd_cache_properties *cache;
>   	struct kfd_mem_properties *mem;
> @@ -668,6 +694,10 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>   	if (!dev->kobj_iolink)
>   		return -ENOMEM;
>   
> +	dev->kobj_p2plink = kobject_create_and_add("p2p_links", dev->kobj_node);
> +	if (!dev->kobj_p2plink)
> +		return -ENOMEM;
> +
>   	dev->kobj_perf = kobject_create_and_add("perf", dev->kobj_node);
>   	if (!dev->kobj_perf)
>   		return -ENOMEM;
> @@ -757,6 +787,27 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>   		i++;
>   	}
>   
> +	i = 0;
> +	list_for_each_entry(p2plink, &dev->p2p_link_props, list) {
> +		p2plink->kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> +		if (!p2plink->kobj)
> +			return -ENOMEM;
> +		ret = kobject_init_and_add(p2plink->kobj, &iolink_type,
> +				dev->kobj_p2plink, "%d", i);
> +		if (ret < 0) {
> +			kobject_put(p2plink->kobj);
> +			return ret;
> +		}
> +
> +		p2plink->attr.name = "properties";
> +		p2plink->attr.mode = KFD_SYSFS_FILE_MODE;
> +		sysfs_attr_init(&iolink->attr);
> +		ret = sysfs_create_file(p2plink->kobj, &p2plink->attr);
> +		if (ret < 0)
> +			return ret;
> +		i++;
> +	}
> +
>   	/* All hardware blocks have the same number of attributes. */
>   	num_attrs = ARRAY_SIZE(perf_attr_iommu);
>   	list_for_each_entry(perf, &dev->perf_props, list) {
> @@ -1145,6 +1196,7 @@ static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
>   	struct kfd_mem_properties *mem;
>   	struct kfd_cache_properties *cache;
>   	struct kfd_iolink_properties *iolink;
> +	struct kfd_iolink_properties *p2plink;
>   
>   	down_write(&topology_lock);
>   	list_for_each_entry(dev, &topology_device_list, list) {
> @@ -1165,6 +1217,8 @@ static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
>   				cache->gpu = dev->gpu;
>   			list_for_each_entry(iolink, &dev->io_link_props, list)
>   				iolink->gpu = dev->gpu;
> +			list_for_each_entry(p2plink, &dev->p2p_link_props, list)
> +				p2plink->gpu = dev->gpu;
>   			break;
>   		}
>   	}
> @@ -1287,6 +1341,248 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
>   			kfd_set_iolink_non_coherent(peer_dev, link, inbound_link);
>   		}
>   	}
> +
> +	/* Create indirect links so apply flags setting to all */
> +	list_for_each_entry(link, &dev->p2p_link_props, list) {
> +		link->flags = CRAT_IOLINK_FLAGS_ENABLED;
> +		kfd_set_iolink_no_atomics(dev, NULL, link);
> +		peer_dev = kfd_topology_device_by_proximity_domain(
> +				link->node_to);
> +
> +		if (!peer_dev)
> +			continue;
> +
> +		list_for_each_entry(inbound_link, &peer_dev->p2p_link_props,
> +									list) {
> +			if (inbound_link->node_to != link->node_from)
> +				continue;
> +
> +			inbound_link->flags = CRAT_IOLINK_FLAGS_ENABLED;
> +			kfd_set_iolink_no_atomics(peer_dev, dev, inbound_link);
> +			kfd_set_iolink_non_coherent(peer_dev, link, inbound_link);
> +		}
> +	}
> +}
> +
> +static int kfd_build_p2p_node_entry(struct kfd_topology_device *dev,
> +				struct kfd_iolink_properties *p2plink)
> +{
> +	int ret;
> +
> +	p2plink->kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> +	if (!p2plink->kobj)
> +		return -ENOMEM;
> +
> +	ret = kobject_init_and_add(p2plink->kobj, &iolink_type,
> +			dev->kobj_p2plink, "%d", dev->node_props.p2p_links_count - 1);
> +	if (ret < 0) {
> +		kobject_put(p2plink->kobj);
> +		return ret;
> +	}
> +
> +	p2plink->attr.name = "properties";
> +	p2plink->attr.mode = KFD_SYSFS_FILE_MODE;
> +	sysfs_attr_init(&p2plink->attr);
> +	ret = sysfs_create_file(p2plink->kobj, &p2plink->attr);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int kfd_create_in_direct_link_prop(struct kfd_topology_device *kdev, int gpu_node)
> +{
> +	struct kfd_iolink_properties *props = NULL, *props2 = NULL;
> +	struct kfd_iolink_properties *gpu_link, *cpu_link;
> +	struct kfd_topology_device *cpu_dev;
> +	int ret = 0;
> +	int i, num_cpu;
> +
> +	num_cpu = 0;
> +	list_for_each_entry(cpu_dev, &topology_device_list, list) {
> +		if (cpu_dev->gpu)
> +			break;
> +		num_cpu++;
> +	}
> +
> +	gpu_link = list_first_entry(&kdev->io_link_props,
> +					struct kfd_iolink_properties, list);
> +	if (!gpu_link)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_cpu; i++) {
> +		/* CPU <--> GPU */
> +		if (gpu_link->node_to == i)
> +			continue;
> +
> +		/* find CPU <-->  CPU links */
> +		cpu_dev = kfd_topology_device_by_proximity_domain(i);
> +		if (cpu_dev) {
> +			list_for_each_entry(cpu_link,
> +					&cpu_dev->io_link_props, list) {
> +				if (cpu_link->node_to == gpu_link->node_to)
> +					break;
> +			}
> +		}
> +
> +		if (cpu_link->node_to != gpu_link->node_to)
> +			return -ENOMEM;
> +
> +		/* CPU <--> CPU <--> GPU, GPU node*/
> +		props = kfd_alloc_struct(props);
> +		if (!props)
> +			return -ENOMEM;
> +
> +		memcpy(props, gpu_link, sizeof(struct kfd_iolink_properties));
> +		props->weight = gpu_link->weight + cpu_link->weight;
> +		props->min_latency = gpu_link->min_latency + cpu_link->min_latency;
> +		props->max_latency = gpu_link->max_latency + cpu_link->max_latency;
> +		props->min_bandwidth = min(gpu_link->min_bandwidth, cpu_link->min_bandwidth);
> +		props->max_bandwidth = min(gpu_link->max_bandwidth, cpu_link->max_bandwidth);
> +
> +		props->node_from = gpu_node;
> +		props->node_to = i;
> +		kdev->node_props.p2p_links_count++;
> +		list_add_tail(&props->list, &kdev->p2p_link_props);
> +		ret = kfd_build_p2p_node_entry(kdev, props);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* for small Bar, no CPU --> GPU in-direct links */
> +		if (kfd_dev_is_large_bar(kdev->gpu)) {
> +			/* CPU <--> CPU <--> GPU, CPU node*/
> +			props2 = kfd_alloc_struct(props2);
> +			if (!props2)
> +				return -ENOMEM;
> +
> +			memcpy(props2, props, sizeof(struct kfd_iolink_properties));
> +			props2->node_from = i;
> +			props2->node_to = gpu_node;
> +			props2->kobj = NULL;
> +			cpu_dev->node_props.p2p_links_count++;
> +			list_add_tail(&props2->list, &cpu_dev->p2p_link_props);
> +			ret = kfd_build_p2p_node_entry(cpu_dev, props2);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
> +		struct kfd_topology_device *peer, int from, int to)

If P2P is not enabled, the compiler will give you a warning here about 
an unused static function. This whole function should be guarded by an 
#ifdef.


> +{
> +	struct kfd_iolink_properties *props = NULL;
> +	struct kfd_iolink_properties *iolink1, *iolink2, *iolink3;
> +	struct kfd_topology_device *cpu_dev;
> +	int ret = 0;
> +
> +	if (!amdgpu_device_is_peer_accessible(
> +				kdev->gpu->adev,
> +				peer->gpu->adev))
> +		return ret;
> +
> +	iolink1 = list_first_entry(&kdev->io_link_props,
> +							struct kfd_iolink_properties, list);
> +	if (!iolink1)
> +		return -ENOMEM;
> +
> +	iolink2 = list_first_entry(&peer->io_link_props,
> +							struct kfd_iolink_properties, list);
> +	if (!iolink2)
> +		return -ENOMEM;
> +
> +	props = kfd_alloc_struct(props);
> +	if (!props)
> +		return -ENOMEM;
> +
> +	memcpy(props, iolink1, sizeof(struct kfd_iolink_properties));
> +
> +	props->weight = iolink1->weight + iolink2->weight;
> +	props->min_latency = iolink1->min_latency + iolink2->min_latency;
> +	props->max_latency = iolink1->max_latency + iolink2->max_latency;
> +	props->min_bandwidth = min(iolink1->min_bandwidth, iolink2->min_bandwidth);
> +	props->max_bandwidth = min(iolink2->max_bandwidth, iolink2->max_bandwidth);
> +
> +	if (iolink1->node_to != iolink2->node_to) {
> +		/* CPU->CPU  link*/
> +		cpu_dev = kfd_topology_device_by_proximity_domain(iolink1->node_to);
> +		if (cpu_dev) {
> +			list_for_each_entry(iolink3, &cpu_dev->io_link_props, list)
> +				if (iolink3->node_to == iolink2->node_to)
> +					break;
> +
> +			props->weight += iolink3->weight;
> +			props->min_latency += iolink3->min_latency;
> +			props->max_latency += iolink3->max_latency;
> +			props->min_bandwidth = min(props->min_bandwidth,
> +							iolink3->min_bandwidth);
> +			props->max_bandwidth = min(props->max_bandwidth,
> +							iolink3->max_bandwidth);
> +		} else {
> +			WARN(1, "CPU node not found");
> +		}
> +	}
> +
> +	props->node_from = from;
> +	props->node_to = to;
> +	peer->node_props.p2p_links_count++;
> +	list_add_tail(&props->list, &peer->p2p_link_props);
> +	ret = kfd_build_p2p_node_entry(peer, props);
> +
> +	return ret;
> +}
> +
> +static int kfd_dev_create_p2p_links(void)
> +{
> +	struct kfd_topology_device *dev;
> +	struct kfd_topology_device *new_dev;
> +	uint32_t i, k;
> +	int ret = 0;
> +
> +	k = 0;
> +	list_for_each_entry(dev, &topology_device_list, list)
> +		k++;
> +	if (k < 2)
> +		return 0;
> +
> +	new_dev = list_last_entry(&topology_device_list, struct kfd_topology_device, list);
> +	if (WARN_ON(!new_dev->gpu))
> +		return 0;
> +
> +	k--;
> +	i = 0;
> +
> +	/* create in-direct links */
> +	ret = kfd_create_in_direct_link_prop(new_dev, k);
> +	if (ret < 0)
> +		goto out;
> +
> +	/* create p2p links */
> +#if defined(CONFIG_HSA_AMD_P2P)
> +	list_for_each_entry(dev, &topology_device_list, list) {
> +		if (dev == new_dev)
> +			break;
> +		if (!dev->gpu || !dev->gpu->adev ||
> +		    (dev->gpu->hive_id &&
> +		     dev->gpu->hive_id == new_dev->gpu->hive_id))
> +			goto next;
> +
> +		/* check if node(s) is/are peer accessible in one direction or bi-direction */
> +		ret = kfd_add_peer_prop(new_dev, dev, i, k);
> +		if (ret < 0)
> +			goto out;
> +
> +		ret = kfd_add_peer_prop(dev, new_dev, k, i);
> +		if (ret < 0)
> +			goto out;
> +next:
> +		i++;
> +	}
> +#endif
> +
> +out:
> +	return ret;
>   }
>   
>   int kfd_topology_add_device(struct kfd_dev *gpu)
> @@ -1305,9 +1601,23 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	INIT_LIST_HEAD(&temp_topology_device_list);
>   
>   	gpu_id = kfd_generate_gpu_id(gpu);
> -
>   	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
>   
> +	/* Include the CPU in xGMI hive if xGMI connected by assigning it the hive ID. */

This looks like an unrelated change that should probably have been 
upstreamed separately.

Regards,
   Felix


> +	if (gpu->hive_id && gpu->adev->gmc.xgmi.connected_to_cpu) {
> +		struct kfd_topology_device *top_dev;
> +
> +		down_read(&topology_lock);
> +
> +		list_for_each_entry(top_dev, &topology_device_list, list) {
> +			if (top_dev->gpu)
> +				break;
> +			top_dev->node_props.hive_id = gpu->hive_id;
> +		}
> +
> +		up_read(&topology_lock);
> +	}
> +
>   	/* Check to see if this gpu device exists in the topology_device_list.
>   	 * If so, assign the gpu to that device,
>   	 * else create a Virtual CRAT for this gpu device and then parse that
> @@ -1362,6 +1672,8 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	dev->gpu_id = gpu_id;
>   	gpu->id = gpu_id;
>   
> +	kfd_dev_create_p2p_links();
> +
>   	/* TODO: Move the following lines to function
>   	 *	kfd_add_non_crat_information
>   	 */
> @@ -1507,7 +1819,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   static void kfd_topology_update_io_links(int proximity_domain)
>   {
>   	struct kfd_topology_device *dev;
> -	struct kfd_iolink_properties *iolink, *tmp;
> +	struct kfd_iolink_properties *iolink, *p2plink, *tmp;
>   
>   	list_for_each_entry(dev, &topology_device_list, list) {
>   		if (dev->proximity_domain > proximity_domain)
> @@ -1529,6 +1841,22 @@ static void kfd_topology_update_io_links(int proximity_domain)
>   					iolink->node_to--;
>   			}
>   		}
> +
> +		list_for_each_entry_safe(p2plink, tmp, &dev->p2p_link_props, list) {
> +			/*
> +			 * If there is a p2p link to the dev being deleted
> +			 * then remove that p2p link also.
> +			 */
> +			if (p2plink->node_to == proximity_domain) {
> +				list_del(&p2plink->list);
> +				dev->node_props.p2p_links_count--;
> +			} else {
> +				if (p2plink->node_from > proximity_domain)
> +					p2plink->node_from--;
> +				if (p2plink->node_to > proximity_domain)
> +					p2plink->node_to--;
> +			}
> +		}
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index 4f80d2ea1000..2fb5664e1041 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -38,6 +38,7 @@ struct kfd_node_properties {
>   	uint32_t mem_banks_count;
>   	uint32_t caches_count;
>   	uint32_t io_links_count;
> +	uint32_t p2p_links_count;
>   	uint32_t cpu_core_id_base;
>   	uint32_t simd_id_base;
>   	uint32_t capability;
> @@ -131,12 +132,14 @@ struct kfd_topology_device {
>   	struct list_head		cache_props;
>   	uint32_t			io_link_count;
>   	struct list_head		io_link_props;
> +	struct list_head		p2p_link_props;
>   	struct list_head		perf_props;
>   	struct kfd_dev			*gpu;
>   	struct kobject			*kobj_node;
>   	struct kobject			*kobj_mem;
>   	struct kobject			*kobj_cache;
>   	struct kobject			*kobj_iolink;
> +	struct kobject			*kobj_p2plink;
>   	struct kobject			*kobj_perf;
>   	struct attribute		attr_gpuid;
>   	struct attribute		attr_name;
