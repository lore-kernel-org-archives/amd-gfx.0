Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B05DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Mar 2022 16:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADE2011274A;
	Fri,  4 Mar 2022 16:32:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A52E4112747
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Mar 2022 16:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDlDjCNvG0BDEdBh2OeyNHw9tyI5P5cDFUXdEkjRIUupWGEyfNfKvoeeWRlfbo3YykfYXHrRJxJes1pGgvWv7bfWWnu8HFuGlEHU8fmy4NuQeLrCSmTbfnNav3wU949wfbATvnEp9pDJq33EBEAVg1muNvl4l6HQVmFOB8P8211EYuyQUa02XfgJ4wKVnQHsRdgInDNIxOnPw9KLoOiFMNxtf4hQ4pteoF77c1nQ/ige7ZxGnvVOPOMU9lL0rAxyc2Zdd+JSo0Kxre4JI44Vq/QRsLD4xE4jHvI6CCSThFPojy05C3hMuCHR/CVg99Srcfu/sYlGkgW0wX9WxdKraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcRNlvXZ0mMXCn4uqorW96+9yKscs8EKIz+KYlQtgP0=;
 b=l8NteaxJVyrMgVu0fhiwML34IzMbiX7FghoccldKRnzNQ6EoZPqZvdfdnh7agBM3yCk/HnvS+zAPECQHbKiXLltPLXS6CAsowAAedsVDN7hLmZ2qktdGfaBPua2Qidifn68g8+OLCAouUyDUH7IVt5lul3wDuc8EzUDZEcJuzlEUjroMtI72CHhodXAmWiXeAqLrkKQXVgZWIphERwqdh75Oa10EgoF7E7dAZGfn2IqFFLnEPDivRa6NhUscVE0Ru7zAH1+S0I9PqQL+l5vAtmx4YRnOppbyGeAJ3pFqVe/tUs8mm9zhmDANiLQZw27V/NppuC5Vj12qtbuKEG8MHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcRNlvXZ0mMXCn4uqorW96+9yKscs8EKIz+KYlQtgP0=;
 b=rRt140tYhSZLchMuEeQCUSO7zbFCwc2sMKHzkTGCblCfRaj+nE1e75ytLsH99yCNw8FC6rneIC5DPDx5dE0fmN+gv9q4faxYrey/vWuyqWevhJfhiLO0+rJUfY0k8iItXbgH+zeGWK804wSJ0b1V4a9VMw2SIELuseoFSy9ZIFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 4 Mar
 2022 16:32:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b030:b1ba:4eb2:7fb7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b030:b1ba:4eb2:7fb7%6]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 16:32:12 +0000
Message-ID: <93954fba-4e96-25f2-2523-e62381ed130b@amd.com>
Date: Fri, 4 Mar 2022 11:32:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Add format attribute to kfd_smi_event_add
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220304144811.17451-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220304144811.17451-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8af9be3d-a8a8-489a-1d29-08d9fdfc88f7
X-MS-TrafficTypeDiagnostic: DM4PR12MB5793:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5793840357BEE6B51FC2CD2A92059@DM4PR12MB5793.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UAkThVEI/qgpBoSE18r8lgaQdVKGUyVhNzfpFAJiVKWTpVjBrfxlEPQBbTX6ISdfX3NBrbN6C/pCKoVi41ppKVy/7alZYkqorCnCJyWNEmEFZ4uk4qmhjQIdsPeis+5Av5Js2vWD+JHb9jZ4TMGihnd7FsOeinS/Buu5M/WjyVtkCNjtLIl6Kzxmfvuyvf5pBUvrPPdr1+DmpsYqRFLH+KzNqNo7yYGbhdsxBJwwECFNNG4vgzdfwOEILOXSuTDMIEHqrcNeNv+VwNpZgCngrimrHyuDQqDdtZojOlCWOdV2ltHoX4OlbARaLV7A0Dr1ycQDfGU+eJLg7fseYGv3BsAqzX2gvyFM7XAQkMScQc4sUw5NwbscCuI9Yn6+5gqzPgTMK8SdgFl5Fg8x/U0B7jYsiSNnomweZJoC1JTtD47awa2Js9r3ku5sa+Sj6KsUkxUASQqA/0ScIVUClHSIJMOfYzaCK2/abK/jfer+xOmHjP9mLHUWYcd3Bh9ELHbwGkov7eISwdRH1ZBX4Vd1Bmti1FQOxH2WgleB9kgeg47qb+Q/75vTYdg3kNLAtDko4go3AAKqueZoQ26kNmsqiGDWHORsHEKsbw+jCp+4NWOiu7iT8xekODxlVCop3N5sMP03lSeErrxhqGjmfmxDNhSs9+r17FQosEaD6DZTbF34URCiohz9usNZ92Un20PMYyJgVpa0BEnTTBGgq3vANGn0KD0JjaenHMBsezw/jhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(6512007)(2906002)(38100700002)(86362001)(66476007)(66556008)(66946007)(36756003)(83380400001)(8676002)(5660300002)(8936002)(44832011)(2616005)(186003)(26005)(508600001)(6486002)(31686004)(31696002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjV6WG9GTnNoUU5HMDJQc3FyQldON1BmaXd2dmVvbHAxU2I5US9DNnNZWmNQ?=
 =?utf-8?B?ZmwwdW1mSlRCblNZTG1xaWxTM244MUxsT0l3R2lTMkVMdUJQTGk0VmVtcXFv?=
 =?utf-8?B?RGxoL3ZQSUdZbHNVaTd5TVlMbEc5SGxTWTZhVThsTzBaVFIvanJGWWlRcnhy?=
 =?utf-8?B?WjdoVlZ4NXBkelgrU0E3SEJkVXgzcTJMb3R3ZHdJTzVkZDVNQ0YvMDJxSTNJ?=
 =?utf-8?B?SnRkb2UvUXNTaXpPa3JmWEdFOUtFdU8yOGtSTE00dngrZnVDRkw2S1VZeVYz?=
 =?utf-8?B?dHpaT3d0UXFnckV2aDlhbXlwRTI1R1RrVjBHdjE4RS85MlFSeVdLditFUmk5?=
 =?utf-8?B?YS9MbUlZaVdLdlRoNU9aQlRyU3lsTE81M000dER3RzFjMmNEbGI1b25VbWJW?=
 =?utf-8?B?dldJVnUvZWt3aHU3M2NMR2QwWkpWVXVOQWVPckZOMk1WUTBBMmNlVHpWbEdI?=
 =?utf-8?B?QW1MTkMxVlBLMWlSNFA5NzFkZGRrd1g5UHltdFE2YkNNTzVhL1Y4K0djWHhR?=
 =?utf-8?B?L3RzZmZDa3NhejF5WWQ5OGdFdVFaMTUwRUc0MEsrY3ZuRmFVcjRLQ2NkU2Ux?=
 =?utf-8?B?aktyanFLek12VHZTMXUvZzZHYlBvanZBZkkycWF2TGs5TEhwNVlCay9iWWt5?=
 =?utf-8?B?TVBNRVFoemNQTWhOTFoxUzB1bVRoSzNaM2N3cUdhYnpoNDhpcndDLzdRSDRs?=
 =?utf-8?B?d3loY3VKUTVvcnhjbDhXNitTTTNxMWRLVlA1VVl6SG1GeEJrZnhLKzFFRVRu?=
 =?utf-8?B?NEhzNDdsMzFZTmFHUnl1dkZmRStMQ3htaThjZEZGZ2pOakJ4bkcwdWhmMFlS?=
 =?utf-8?B?QmtXMk03NWt0a2VOL281YTJ6eDFKUTZRRElzeWc3b2JJOUJsZnBHaUkzM0xU?=
 =?utf-8?B?d1BPWFhmRGRJeHJhMnRhRm5VMjUvNk52aC9sZXZVUStDblBqS0g5Ly9pNmRW?=
 =?utf-8?B?VzgzS1NWMXI2T1l2MjVyam50bEZkRG9tOCtCa2NHS0JrQ0RETXZWWHFvdDhx?=
 =?utf-8?B?NG1rUFpxY08zWGZiNGIvVzN4Vm1TUjRIWnp5Vnl3VmFkYm1teXRNdDVsaDVB?=
 =?utf-8?B?RzdaRVc0TkhxVHZlK0tSenJZZ1J6ZnQwRjFqTThxeWZMMDlJMzdoWFFBaGFr?=
 =?utf-8?B?RzB4MWVzRlR4SDArSFlCYkh1Y21xYlFHMWtnWThvNHlnYWRBQW81dUpNZUlr?=
 =?utf-8?B?V3NkckQzdWlDWmc3ZEZ5WVVGdGFINm8vc3h4djNFd1BxNmlJR3lCc3VXTVla?=
 =?utf-8?B?OVZPNWFKTUFrVmc2dmtPSFNYa29CeVVHWGVTUDM0SS9ZMWY3Qk9lb0t2VnBJ?=
 =?utf-8?B?cjZoMWVwUkFKZTVyN0FGMUYzbXRDVXpydXV2aTNWT0pBbTVrTmM1bzNEbnFW?=
 =?utf-8?B?dWYzRUs4a1NQUEsvdk4vNEdaMWlqblJFVmtlZlZKdUFPTEN5b3RVYmMycWRi?=
 =?utf-8?B?N0ZtQXR1R2hmb2NtNzhYL0hIL2dlb2Q2amJIOEp0WjdDSTZQcmdaNE5TdmVl?=
 =?utf-8?B?RVpaL2JWTUJwTGppSlJSYWdTRVJhUkx3NEdoRWhoRFljU0ZRci9RamJaTHZ0?=
 =?utf-8?B?SlNoN05nalZQeW5jbXBBejRFVW9xMHVtWExYeGlhMUZtR3BFT1doWlh3Q09T?=
 =?utf-8?B?SkpsWGZweUIxTUpiN25UTUE1R2NKRWpMTTgwbUhiVVFOQjhCRVVZWnZ0ckVG?=
 =?utf-8?B?bXRDMUNyL2wyRm95RjAyVVpXRkFDU2NNU2lsYXhFMGpjOEZ5ZitYOGp6aGh6?=
 =?utf-8?B?T1E3NkM5cVJhVG1pTDQrbzFyYVZ6OGFjdnFQK1pmVFNiU3hOZW8vcm9xZ0ZK?=
 =?utf-8?B?dmJiL2M2bW44SXVPOHF4bEp4YWx3cEQwOGF5VmpMekkrd2p6Z2ZrQmZvTWwz?=
 =?utf-8?B?akE3WGxwbzM0RFB5OHZ3SVBqdUhSNjJSMUFxSGZ6alZpLzFZSTE3QUlqNnVT?=
 =?utf-8?B?bERIeVJPTnpmeUU5YXFIc1V1Q0pxZXBhalVXT05qZnJkY2sydmdoL0ZpRWh2?=
 =?utf-8?B?Ri9VY2d1TXRqWnBLZU9GazVjclRnZVd3cnRwRGJtU1hmNXBYa2NvTVU0aHJx?=
 =?utf-8?B?Rzg4YXExU2ZpczZHcGx5aEZHTGxRbGxCTVVnZ0dHTlVxeG1SN0xaTjFTRzI3?=
 =?utf-8?B?b1VxQ2ZoSzE1NkpGU2p0SWFWdUNUSFMyQklSNlQxeWVWWnNJeTNJVjBGemJZ?=
 =?utf-8?Q?g3QwqstWaaJIXLkhPn3UL7o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af9be3d-a8a8-489a-1d29-08d9fdfc88f7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 16:32:12.5335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfXgD3kjxJRoBYF5gugtfjLws1kSrO5tEp+hGKldSNh/bbFNbtPJPzOxGusMkGkuC5Q1He/nN0aNcESUrZZTmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793
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

Am 2022-03-04 um 09:48 schrieb Philip Yang:
> To enable compiler type-checked against the format string in callers.
>
> All warnings (new ones prefixed by >>):
>
>>> warning: function 'kfd_smi_event_add' might be a candidate for
> 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>
> Fixes: 67e874c2fa ("drm/amdkfd: Add SMI add event helper")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index bba8d9692a4c..02b6b26ee8f3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -176,6 +176,7 @@ static void add_event_to_kfifo(struct kfd_dev *dev, unsigned int smi_event,
>   	rcu_read_unlock();
>   }
>   
> +__attribute__ ((format (printf, 3, 4)))

I see that there is a shortcut for this defined in 
include/linux/compiler_attributes.h. It's just

__printf(3, 4)

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   static void kfd_smi_event_add(struct kfd_dev *dev, unsigned int event,
>   			      char *fmt, ...)
>   {
