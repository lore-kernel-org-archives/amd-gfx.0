Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B25C433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 20:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D3A613D8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 20:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D3A613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD986EC5B;
	Wed,  5 May 2021 20:27:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D2A86EC5B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 20:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIvcHR5+NxVMd4lgmC9Nf5EG4d/+lklFK+IH2AZvr4SiepJ5kUKc2kBY5FL09gXZs2U+KQSPacJhLMRgRuE7Bx7r1eqtPfrAeX4a3jRkPWMHv6JsE1+8NkFGeJIO+VRrQsj8TbQxsKyj9yMrd+I6ycypGZI9IoE3HR4CN8N+R8DwcMv3uP5glZeKrMF5FCAQ3A9EgZpeU9A7Sb94DLwnfp5HtEGkV9ugmeUtHfY0bCx2VgTUZBMLOZZ4MLfpGCXK0AaolkCP/24MD0lOP9OTtkEZLuT1SKP36cM0wIYy2QwLo0IglzPKVeKWiQ3UOcU27etR8ItVynVv4ttqHhmErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Tm/pGvtnfJvIBm75yr3O8GsWKi7g61XF4hAwwUCOU0=;
 b=lm7uOc/V3pCiKW+8w5QyC/qEFYHXxCh2kETrt7PTTQLIq+pBqPLglaE2bz9kL7FfqNLaQCjw2MYNoxClWyU71r9D1KCnGPutKOWE/YehjI7/IaPQU18wVWIPOZ3tlpSTCpRVTHPu3CljwcoSEiN/ZpTtkJBshBIts41Fj9VfdcTcuOOE/ZxoVlCYo/vCCkDVjrplUB6sRi1T+fVvZQfAqYQKsNAnB/4K9LUv/vsWsKTng2l6tOmjqaE6cdExwFs4acfQpi0HooJBwb3+gIgfRiMnu/XpZUlE8vT3FsHlwRuzZiNHgo/4oIp+VKvsu7tbtdSh6J7TAtb0G8AEzzKoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Tm/pGvtnfJvIBm75yr3O8GsWKi7g61XF4hAwwUCOU0=;
 b=frNcNL5c9Lc/emnXZAizdDcAwP6Cd/U27kxceyHFxmgh0AZ58UBED5CqCISuQWgwZWRZt+O+y/Epqg3nacdurCsbLnU+G/nAKlFJNHv+Gf0F2vA8E+X8T2ohf1a3qb6TLbZ5vUQd6X5YVRZCUuTr3+OE3OL9l7m5Fv6/DY+ag3g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Wed, 5 May
 2021 20:27:53 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4087.039; Wed, 5 May 2021
 20:27:53 +0000
Subject: Re: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210505135134.8229-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <59604a1d-7a34-c044-ef80-0141ddb00a39@amd.com>
Date: Wed, 5 May 2021 16:27:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210505135134.8229-1-jinhuieric.huang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::16) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.39 via Frontend Transport; Wed, 5 May 2021 20:27:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dfe3330-7a9b-4680-56cf-08d910044286
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5052A6AA7F8ACC96829EC51692599@BN9PR12MB5052.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: czJXLIWdX7wN/lCo5713J2bQeUoY7kqnbECmjK03fFLIgDOBSZHvJNbAcqOIMfsGecqzbjcd8bdKKiJ3khbi1ZuJMghOqJlhbYXtIsNqWlyXSsmBxpoXm1xO7mtx0F/OQDuxzNDDA4zywRawx1c+Sz29TlSwilSvgq7ExIwwa4ZDl1aEDk/t38hsv0XzFvgEH3OAo2uakTnv9YFRBowSbDgM7BCA5haHXjvzlkxHzWyVYYReVy+PBPk0PcX7byTy2FP6F5xeU02LYdpdrDn79SXsuSBECLRQ2ZcP8pFWDdqh7g6Dabu9FMkcVw2d5Al0o7XDAiQ7V3Wb31iGVcPU+WdluG/HKsQdFSMqZ9iilYkJzaag23Sy6yYQ7x3lQh/rxcaPUl/rpa9xGg6pbjbz/90jIc0leoGBZzrvQZEty28EuL5Hu4jNpoTrmK4FYUuYllRZPmKGF9ybHbtkhvO84oy0qx6zObTUgtkxHihLjytFis+aSBS2lKeKFLXx4ngAR6O7+P94XmbnEi6JJmuRUa8gWZR/av5tERuBVBoi2XBnGAoZi2gfkH2w90lBdbiHMf1dgaifMptMTJ8u2DbQgfwLftz5TMo79IlgpHLxKkTASSjj9LCxHufLXIR/T2e5xE9zUjnm3eQP7R8iCZKFsXHTfp+/6fTvrINKACPviNfxAaGVKkIg2SfSD0t97eI8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39850400004)(396003)(376002)(346002)(366004)(38100700002)(8936002)(66946007)(5660300002)(36756003)(44832011)(478600001)(31696002)(66556008)(6486002)(66476007)(86362001)(83380400001)(2906002)(956004)(2616005)(186003)(16526019)(316002)(31686004)(16576012)(26005)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eVdWdGpEcElTSk9DMDhjbVU1bS9MV0hac3Q3UHlUVHNBSDQyUFZnUHJRMU1r?=
 =?utf-8?B?bXpIaWN0UkQ3S1hzUmdMWGN6QWhPdDJHRE1xcHVhNEd5T0JGTGdxN1B4eTE5?=
 =?utf-8?B?R1F6SkNCNUkxbWJMSks1R2x5TmY5cWdSQUpJaVZxUUthNk1SN0VMc2dCYXdX?=
 =?utf-8?B?aHdLcGNkY0krU3hvcEtqUGUvYXhqR2JTMzVkLzlzaWp5WnlXQ1ZQb1ZoL3F4?=
 =?utf-8?B?TWc4NEFmSERUYlExNjFvYlc4VVEraUx5Y1NYZ2h1YXgxeTMxRzVxUWV1bEtn?=
 =?utf-8?B?VTFvcWw2cUxjRWNzV0ZCLzBzRG1lU0FDRkJucFJIQlN5WngxVzJwUEQ5UG9h?=
 =?utf-8?B?WEsrWnRGTk0vdWdQQ2k4RmxpOHptNWp2Z3RaZU8xTEwxMm94dWpWL0svTnVF?=
 =?utf-8?B?Vm5EckxuQWVMYlJ1Rjdla09XN1pDQkdYaGhrL2JBdVBTN0RJcko0RjZJbENQ?=
 =?utf-8?B?dnp3cjNTQnpYak9MR3k5TmZoazc4WGZ4YWdRMFNldUhNbDZRVlNsMkhyenZo?=
 =?utf-8?B?TGd0V2FCeVByNWlrZUxJbHNZdVRmR2EwcktkbWMwdmdVMXZUWXROUENYb2gy?=
 =?utf-8?B?TTFYdmcrZzROWHdlT3hhUUQwd0dJRWxsLzVSVXlDL0tsclprRVdPR3J0anhp?=
 =?utf-8?B?SWRnNFNpU3lPZTZjcHk0eUJDanBJZDBOM2xHOXFiODQwN1R0Y05EYjNrSDlI?=
 =?utf-8?B?MHFOSnRIU2N0b01sRW0zUnYzZ244bExCTFJtUmw1d1p3Nk1NblRobUhVNFpr?=
 =?utf-8?B?WXRnUHJpWHBBTjA5N2JmOWZXeDFXSHV4cTZpcjFUTlVOR3Q5RVh1NjY4QUpR?=
 =?utf-8?B?WC9IamxIWTZGOVhHWExBZktWQlBoT3pnanVQTG9hd2JaVWFzakNwVndsZ3Fw?=
 =?utf-8?B?dVcyOU1oU3p1eTVYZ0tFTHVyK1plM3lkQ2o2TWJsT2hWY3FORnlaZTdqcXY3?=
 =?utf-8?B?blZZeVlmc2d2Q2k5QkxuTXVnWnh1aHRHOXdUYkp3ZFkzbEtRc0N6eDZFYktX?=
 =?utf-8?B?Zis5NGk4WkhhRmVLcnVBT0lNenVNekEzL3dKaUoydGtBWmNvZW1yVllPMko2?=
 =?utf-8?B?M1c4aEtWL3NuczZMRnY2Sm5jSkJDMEM4bUxpQVN0OGVaTkkyV1YzZVFRWW1M?=
 =?utf-8?B?U1NoaGVxNEdqeUFtSjR2ZVFkU3JjN2lrRmsyUmZWTEQxelBiQ1huK21DM0wz?=
 =?utf-8?B?UWdyL0dqNTUyY2hGUEhIaHhGYm93Qk9wVEtWU0ZQVEJndUNnT01Sa3NaZ0Jm?=
 =?utf-8?B?T1paYVNkOE95Zkh5OGtqRGZ6MWN1Y2J1bzl2anZYZXlWTFZTVjdpYmFSdExB?=
 =?utf-8?B?bWc1TlB3TG5ZckFKMFkxcXpqVTlmZVNYSUVxS0MzOWxLdWRIV0QwVVgreEwr?=
 =?utf-8?B?NHEvVnhOenpDVWRoQzlUZDQwQS81TEpldHZ6UldPdTBtcW9IMmlxeEVDNDBN?=
 =?utf-8?B?b0hqMDVLKy8xbVlrcWJUL3FsWml1bUtqaGx0OGc1N3E3ZHRIMGdIb0hVRlhD?=
 =?utf-8?B?Vnd4WkVuVzNMeGdBbWxMRWZlSGhXNGg2NjM3K2ZVT0gveVZwRzY1MjJpN2p3?=
 =?utf-8?B?MVEyaXkwQitIeUJ1OXdaZ3E3SXMvYlVVNUVlQmYrNzA5M1dmMUx3MERLWnRa?=
 =?utf-8?B?UXU1d1FBL1NRVC9vS29QeWVpVm1ZbitOZitBOExPSm1CYnlHcHV6YXo1TFlK?=
 =?utf-8?B?QTlseFBsNStVWml2citNUjBCSjBuT2Yyem9KV2E3UXhnVTVtTlhMMWZBa0ls?=
 =?utf-8?B?KzNLdzRqV2c0ZXpiZVVmNURRdm9WbGVEbHhUaXBGVU1xOHIxaklWME5kTDJG?=
 =?utf-8?B?dmgyaHlWejlDWmVpQlZxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfe3330-7a9b-4680-56cf-08d910044286
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 20:27:53.2635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iM+++wVKciLhaFeY6hqRxiaarvAk1dH8vRYz5X591hEOtXevHByY3BGVLK+hmfv49T6kfIFr9tMrne1gOY0eTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5052
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

Am 2021-05-05 um 9:51 a.m. schrieb Eric Huang:
> In NPS4 BIOS we need to find the closest numa node when creating
> topology io link between cpu and gpu, if PCI driver doesn't set
> it.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 91 +++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 38d45711675f..0972b1014d6f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1759,6 +1759,92 @@ static int kfd_fill_gpu_memory_affinity(int *avail_size,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_ACPI_NUMA
> +static void kfd_find_numa_node_in_srat(struct kfd_dev *kdev)
> +{
> +	struct acpi_table_header *table_header = NULL;
> +	struct acpi_subtable_header *sub_header = NULL;
> +	unsigned long table_end, subtable_len;
> +	u32 pci_id = pci_domain_nr(kdev->pdev->bus) << 16 |
> +			pci_dev_id(kdev->pdev);
> +	u32 bdf;
> +	acpi_status status;
> +	struct acpi_srat_cpu_affinity *cpu;
> +	struct acpi_srat_generic_affinity *gpu;
> +	int pxm = 0, max_pxm = 0;
> +	int numa_node = NUMA_NO_NODE;
> +	bool found = false;
> +
> +	/* Fetch the SRAT table from ACPI */
> +	status = acpi_get_table(ACPI_SIG_SRAT, 0, &table_header);
> +	if (status == AE_NOT_FOUND) {
> +		pr_warn("SRAT table not found\n");
> +		return;
> +	} else if (ACPI_FAILURE(status)) {
> +		const char *err = acpi_format_exception(status);
> +		pr_err("SRAT table error: %s\n", err);
> +		return;
> +	}
> +
> +	table_end = (unsigned long)table_header + table_header->length;
> +
> +	/* Parse all entries looking for a match. */
> +	sub_header = (struct acpi_subtable_header *)
> +			((unsigned long)table_header +
> +			sizeof(struct acpi_table_srat));
> +	subtable_len = sub_header->length;
> +
> +	while (((unsigned long)sub_header) + subtable_len  < table_end) {
> +		/*
> +		 * If length is 0, break from this loop to avoid
> +		 * infinite loop.
> +		 */
> +		if (subtable_len == 0) {
> +			pr_err("SRAT invalid zero length\n");
> +			break;
> +		}
> +
> +		switch (sub_header->type) {
> +		case ACPI_SRAT_TYPE_CPU_AFFINITY:
> +			cpu = (struct acpi_srat_cpu_affinity *)sub_header;
> +			pxm = *((u32 *)cpu->proximity_domain_hi) << 8 |
> +					cpu->proximity_domain_lo;
> +			if (pxm > max_pxm)
> +				max_pxm = pxm;
> +			break;
> +		case ACPI_SRAT_TYPE_GENERIC_AFFINITY:
> +			gpu = (struct acpi_srat_generic_affinity *)sub_header;
> +			bdf = *((u16 *)(&gpu->device_handle[0])) << 16 |
> +					*((u16 *)(&gpu->device_handle[2]));
> +			if (bdf == pci_id) {
> +				found = true;
> +				numa_node = pxm_to_node(gpu->proximity_domain);
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (found)
> +			break;
> +
> +		sub_header = (struct acpi_subtable_header *)
> +				((unsigned long)sub_header + subtable_len);
> +		subtable_len = sub_header->length;
> +	}
> +
> +	acpi_put_table(table_header);
> +
> +	/* Workaround bad cpu-gpu binding case */
> +	if (found && (numa_node < 0 ||
> +			numa_node > pxm_to_node(max_pxm)))
> +		numa_node = 0;
> +
> +	if (numa_node != NUMA_NO_NODE)
> +		set_dev_node(&kdev->pdev->dev, numa_node);
> +}
> +#endif
> +
>  /* kfd_fill_gpu_direct_io_link - Fill in direct io link from GPU
>   * to its NUMA node
>   *	@avail_size: Available size in the memory
> @@ -1804,6 +1890,11 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
>  	}
>  
>  	sub_type_hdr->proximity_domain_from = proximity_domain;
> +
> +#ifdef CONFIG_ACPI_NUMA
> +	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE)
> +		kfd_find_numa_node_in_srat(kdev);
> +#endif
>  #ifdef CONFIG_NUMA
>  	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE)
>  		sub_type_hdr->proximity_domain_to = 0;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
