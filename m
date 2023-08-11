Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B91C04A6A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 20:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D4410E6F7;
	Fri, 11 Aug 2023 20:41:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A022B10E6F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 20:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkQoe8EgHUJKZ/1ziH+ih4SvW6UlaH3nQPDL4tiXEnRpQIMkFmFXxoaGyunCNEv0PhpwGSv6FIvO2onrIOnbKlRZHVkfSFw+qQWx7bNP/guulXTDU/w4VbAQ/duiLrRbc25b12i9SMGunkdDttW+wf0l2rIVHJ8EbIrgsbwg2vVOajWTWhpTFQUNt6RDLTAvTsBKO3Zqztdxn65MqDs6LJgAiwXuNcpS952D7q/p9m9sVAQGWi2ngeBBr0AOJO2qGF/yK3Fj7Xu19h68Mk9aX724RqLbjUmIKR9dAzvTQYTv58EtBLY5OiqKmNrDvTaFu2v/4yWbf8rsmrkKJ27KdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lW3PDl0FqGUcM9kBlKw0VIU4SFVh8JViSfcwiSsaWE=;
 b=YrQgYJXUJMiYUUBCxZsF3OsMjexGrgDX/GbVUv6sboQlyB1EfmaouIXxhKsZoH7ud7uyWtCv8yTT/QD1MzipC9dELEfpw6HCi0Ag9FSP8zTv8B+btQEHjwQVz5KhLaiwmIppobgKvf2CKvHIyZ+GryMZ7QSVc3ekYI/wq0ZLBOmUCBcBLBzLhZHUHQGD6UcaoHq1q9TlYgoHItLntgWaPF6BMYyoEf7ocWuB44Uzvp8ZiSPY2ZTLcD1a1WdPp5y5qY3pYFgW8pDOe2EwWh+FRDk9e5Q+VG+YLh1KbjVe8SgmeBKR51tTm12Ws3p6/BxEaj5UTC1IVDGZIUrbNJGzTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lW3PDl0FqGUcM9kBlKw0VIU4SFVh8JViSfcwiSsaWE=;
 b=yBXOw8Ppyhy6Ho+5Kb3M716BjU4+LQqmSJk71tYaiQH31LcVwUsIGOWoKDtT+oLG2oHgNm4IRNH8Pgkr77TqYtDyvjT+Aadxp6rikrLqjIkyQdZAqygy/NGtgGGfR8ZULePxCuYXPbuc7UNW2UI7Vo9wBBEdl2ReJTpATuYjgow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 20:41:35 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 20:41:34 +0000
Message-ID: <73860fbf-e98e-15a7-836f-47ec2d0a97b0@amd.com>
Date: Fri, 11 Aug 2023 16:41:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/amdgpu: skip xcp drm device allocation when out of
 drm resource
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, "Zhu, James" <James.Zhu@amd.com>
References: <20230811202337.1867891-1-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230811202337.1867891-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f78648d-f81d-4201-a532-08db9aab5a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HT2L1plqynZgw6F412GVzsiOxGOcEXG5lCa+JHGSy+AKLOR7307XrpI2ubqJjS6TGG4h1l2238OCHz8iBQThJyUH+hpdS9j9kseMDrDaYsdbdtcrBfTirPb1H6Y6f97e/sTFoCNHg2A5CihgwjpeZHsDkb1bxDL3bnSUYZVxL7lnDsl3HbLAI2fciZaSuaGiwhIB+HnpE0h/cgr+v0CjB4hD3ShRle2WbIlyXJcFI21hyVdIh5vZ4Q6KPEuWyUwYEW7vpGeYnoS6NvJ8+LkS93GFSa8tBUowJpMW/UtG3zI31jCEPETE0Aqyw85NUaC8FDEXZjm7IBL87wOnOVsfjNakkqKxFD5yeqWSQxWQ5L8xcHKB602yrTtMLI0vboyRIZtuVsyp3lyydaRwsBlPGUEMCjk7F1UA410ODkwQ+H295WRx8smJ5G6X6nsMP61267BQA1FK7SLnQAvRlcfGGnF/upm/27J9zLCXJYwrjZWyga6+rV/WwD/JELTt5WDWKQrPkT5zoDgp6ojLl3YpyLfe1DXMC6oLyTwSG4e7F8r4+VqF7LbXNFV2w+okTkrcGO3D9jvwpuiAnt64SNtg+R4vANFXB31KJ3HSPv+I7uBqn8XtLaQSjFrRVTEtE4wmeLVzsf4ewab0c7bv/C7d7ZAXr7HVUgALkvRouOevjp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(1800799006)(186006)(451199021)(44832011)(5660300002)(4326008)(26005)(41300700001)(2906002)(38100700002)(66574015)(83380400001)(53546011)(2616005)(6506007)(6512007)(36756003)(8936002)(36916002)(6486002)(8676002)(6666004)(66946007)(66556008)(66476007)(31696002)(6862004)(86362001)(966005)(478600001)(316002)(37006003)(31686004)(6636002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azlkNllqZTE2VndVdUtaM2h4MnJodUJGTmpqUWg5UUNHRlgwb1ZFYzdTOGRi?=
 =?utf-8?B?MWI4elZORkNONklnODdManlpWm45QStKVVBUd25HbHJ5U0ZjOEdSRk4rd1NU?=
 =?utf-8?B?ZGZ6VEZOcHU4Y3JOWmJRWmJ6WTQzYmg2cjJIOXVXMFNWeHBrN1M4QmlCRmxH?=
 =?utf-8?B?RSs1VnRFWHFBYUJJdFJlK0NwVzRiejUrZ0MrN0JIV1JiMWwzemt5NFoxeVB5?=
 =?utf-8?B?UTN4YURJYlROQUhUTlllMk12QlRIOUpoeVQ2b1hRbE9PMWFDclJTVytSUDhG?=
 =?utf-8?B?THljdUFOSWpLY2UrNEJxOWh3R2w3YXhtZ3JjR2tjUG1RLzIxdmdITDZPRHJW?=
 =?utf-8?B?dzVYWWNBR24wSzRwOTRXU2lIVTZzNElvSzBTQWhla2w4Z0FZNWpLY01PUWk0?=
 =?utf-8?B?YjRSZ1ZMQ1NZL0xMMXlFTWxFOEs0Vm15QVBSY1JvaDBQQU5UVGdpRTBMMjBt?=
 =?utf-8?B?SzRCOGpuUldaa21rdzNYd2pFZlprUXltYW9zWStvTTNyUnN0aGlrQ2pGLzJa?=
 =?utf-8?B?V282c2FHYTV1VXZ1cWw3RlkvUmFUL1ZjZzZsZWRhem5VY2FDNEJpVnYvdi9t?=
 =?utf-8?B?SWRGWWRHZFBVZzNHRVJiUTlHOFpCaTZiRWZWRlJFL1g4bXR2Q1lIdmR0cmNL?=
 =?utf-8?B?bUMyYXR5Rm9UaVkwaGNWNnpEMDQzc2tTbzYxNFNra3JvOVphTThFVzRRMEpj?=
 =?utf-8?B?VXBhaGluVXV5N2VCendmaXBUTmRJRjFNMjh6VGRHYlYrUnljZlBBUy9DT01z?=
 =?utf-8?B?WGgxdVpVV1RwRnp1bGF2QWZuT04vbDB3N3NFSHk0VmQ0eHVGWGtuN2JiRDlF?=
 =?utf-8?B?NnJHaEZIcFdid0FvTnAxS3BBK3BYbGgxdWFQWDByR0ZGOEJIdTYxWHlEUGZy?=
 =?utf-8?B?NkF3SG5HeTlRd3NQSjQyVThOOWZGR2N6TDZ4QVF6WVg2cmR3M2NOVGNHWGlj?=
 =?utf-8?B?dHZ3RGpDMkUzR0VncHdIVTRTZ0g4MENmN0lUWTFsM2tERHBWMWVWVE4rd3Va?=
 =?utf-8?B?NXVjWFlua0FYcXorRjJBaUliZWw4eEk0TFlpVThtYWJja3p0Zkxmbk9tOG9M?=
 =?utf-8?B?YzdkaTV1eThYY2grcEZUWitJTEUxVXAvQlZaSGFkQzVLZUVVSmc3dlFHaFRi?=
 =?utf-8?B?WXlXV3lqWUlYZHZYQjFhRXhaYmRRZVk1Z1dqcXlRcTNCZGlEOEs0M0l0MTFq?=
 =?utf-8?B?QjBYamlVZGxQamlkcGVCV0lnSC9zRHpxUXgwa3FoZm1XK0ZuVGVaRmpwQU9R?=
 =?utf-8?B?aTl2U2NINGR2RjJzbHVOWGhCYmJLbGF3anVqQitwck8xRzd5S1lYOWJ3bTJa?=
 =?utf-8?B?YmU3VjdXUUlkaUxVb3ZWc3RrVFlxZkFDV0hqaU44RjBJdDBheXVzSTk1Tncw?=
 =?utf-8?B?RFNtZ2tNZ0RuVEQ1bkN5RnJyZ0FwdHNDcXVQVUtpN2F1bmJmMTFKQ3ZBWTF4?=
 =?utf-8?B?eTdnWVpaTk1FTHVraEZuWjVPbzR1clB1UFRSNlBBVDBNMW93ZkpDVG5JUnRE?=
 =?utf-8?B?NXB6QzFmbkpnMmVUalg3QXdLY2xIOVllVm50VkNyVi92SlJLbFdDZ21FZXRk?=
 =?utf-8?B?STV4cmo1OEs4VFFlVjNWQzVOZmVodW9kWWJzd0E3YitZOU51TTllNnV0QWhB?=
 =?utf-8?B?bnhIQnBqM2diSFNHWlF2MGUwbGg4dXBBMWFNOStGelA4SCsxTXZBVzJJNVR0?=
 =?utf-8?B?L0JhZ0VabnlNS291LzNOcmJhVjJTVm5GbU4vd1Jjd3FpT3ZwRmdOUHczSFph?=
 =?utf-8?B?UElobVp2dGV4cHNBelpTT2p2YnA1U0hlc3BGMEZvT2JKbGNsUitVbUYybldq?=
 =?utf-8?B?K2gySTlWait3Y3c4dXFGeXUzZDRqeVNXYWlPbDBaQ3pkZVZLZ1JTR1lKa0Vp?=
 =?utf-8?B?ZEdFQ0ttYTVvU0o5dU9CSHVSU0RBUVA4R3g2c1A0Z0JCQ21URDlOUXNIYk1M?=
 =?utf-8?B?Q3FWOUJDdjZCVUdMSUJyK01pZHQ0dVlOcVpuSittdjFQNC9ubjZ2MHJQbmVM?=
 =?utf-8?B?dEt6YWFDVGtCQVIvT3dndGgvNEk4Ukl6eWh2K050WjAxTXU1Z3FUYU02VHpx?=
 =?utf-8?B?amtuWUg1OUJHZC9CaFVqc0tySFpJVkZBVGFob2tlOGlwU3R0L3VmenhpeTBB?=
 =?utf-8?Q?9MOE+hSoV2CgOYN9lOLvLVnSN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f78648d-f81d-4201-a532-08db9aab5a16
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 20:41:34.7294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4x/+4n2BJNbsteLzKgefQuzzWxnwXszb0/yUaJGBYCEFApDn2nJOZWo4gTnZd8FWTM3HUL4HQwImQWBh6u5eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
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
Cc: Amber.Lin@amd.com, jamesz@amd.com, Harish.Kasiviswanathan@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-08-11 16:23, James Zhu wrote:
> Return 0 when drm device alloc failed with -ENOSPC in
> order to  allow amdgpu drive loading. But the xcp without
> drm device node assigned won't be visiable in user space.
> This helps amdgpu driver loading on system which has more
> than 64 nodes, the current limitation.
>
> The proposal to add more drm nodes is discussed in public,
> which will support up to 2^20 nodes totally.
> kernel drm:
> https://lore.kernel.org/lkml/20230724211428.3831636-1-michal.winiarski@intel.com/T/
> libdrm:
> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/305
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
>
> -v2: added warning message
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c   | 13 ++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 +++++++++-
>   2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 9c9cca129498..f0754d70da5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -239,8 +239,13 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_device *adev)
>   
>   	for (i = 1; i < MAX_XCP; i++) {
>   		ret = amdgpu_xcp_drm_dev_alloc(&p_ddev);
> -		if (ret)
> +		if (ret == -ENOSPC) {
> +			dev_WARN(adev->dev,
> +			"Skip xcp node #%d when out of drm node resource.", i);

This prints a noisy backtrace. Maybe that's a bit too much. I'd just use 
dev_warn, so it only prints your message without a backtrace.


> +			return 0;
> +		} else if (ret) {
>   			return ret;
> +		}
>   
>   		/* Redirect all IOCTLs to the primary device */
>   		adev->xcp_mgr->xcp[i].rdev = p_ddev->render->dev;
> @@ -328,6 +333,9 @@ int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>   		return 0;
>   
>   	for (i = 1; i < MAX_XCP; i++) {
> +		if (!adev->xcp_mgr->xcp[i].ddev)
> +			break;
> +
>   		ret = drm_dev_register(adev->xcp_mgr->xcp[i].ddev, ent->driver_data);
>   		if (ret)
>   			return ret;
> @@ -345,6 +353,9 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
>   		return;
>   
>   	for (i = 1; i < MAX_XCP; i++) {
> +		if (!adev->xcp_mgr->xcp[i].ddev)
> +			break;
> +
>   		p_ddev = adev->xcp_mgr->xcp[i].ddev;
>   		drm_dev_unplug(p_ddev);
>   		p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3b0749390388..0f844151caaf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1969,8 +1969,16 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   	int i;
>   	const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
>   
> +
>   	gpu_id = kfd_generate_gpu_id(gpu);
> -	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
> +	if (!gpu->xcp->ddev) {
> +		dev_WARN(gpu->adev->dev,
> +		"Won't add GPU (ID: 0x%x) to topology since it has no drm node assigned.",
> +		gpu_id);

Same as above.

Regards,
   Felix


> +		return 0;
> +	} else {
> +		pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
> +	}
>   
>   	/* Check to see if this gpu device exists in the topology_device_list.
>   	 * If so, assign the gpu to that device,
