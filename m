Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B358C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 14:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA4E61450
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 14:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA4E61450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4894C6E4A6;
	Fri, 30 Apr 2021 14:06:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79FBE6E4A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 14:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGYksTHptIetsvcwocKT/DHGFdetLM3zn7lVem5Fpt7Np0brNKP7TmrFhJC7uoJQsJdtfSUyWq7JoOacYaCEpMmcP9QTTv/sDeLYd6ioVs0CPg5AbA52PCOJUB7wntwhZgneTyXdyJaMj7F1uoKvJ6duhmoDT/ax52raYIpS+uyEnlu2OPdyc7wNQh3DZsAyVGjP9dKncIYGRnCnoGlWBoNn1odfrBPuQ9yM1NvXsh2y5bcoMuDQ7IjElsVr50OvvIkfAXUf32sejWwk5BU2bI4dEUZtAxIvAN9iXrjdR9rIna0Jas3xPQKw1LgfIrXDAM8DXfl5MRIM9xqnwhCxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhkEMe4BZJusjobKtB1GWq3bq2s+DC/p6EwW+UmO5IQ=;
 b=a3BjtX+3J9wiJqeg2I7rKefoZN3z5CiDUrL/n/PB/1ayh+l44hyUHcbwzBKqIJzgBWR16eJ/cCFQJYlgRmetJgaFxdSdex+TWCk+nXlyaCPsGwyV7+Dq5bjl3v2bdYYnhknVbZkZKQs4LqhNbAD7xBbRi+Mny5RGVu4V+0UoytiLSWUk2c/heLjfIpYc/iqzy28WyIEMiLLlVudQhBcO8ifYj0b4Jy8ypI2Eng8OvHrEJs4OLl1uTnZvwZUQEv910z1Rt9XzqoFJARhVjjeQ1gLrCmpxZ/B83MIBcn2fAEO2LAPV8R/OI20LDENxiZ78J98xGv4H3lrdXN3wZWvGBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhkEMe4BZJusjobKtB1GWq3bq2s+DC/p6EwW+UmO5IQ=;
 b=ksWAo7J33Hpq16foIRbFXnVH6TeJBj9lg6wKtovsUOnKZ7Ca+YpgYNPjUe5S+oRgCqBs6Y8lMdnHrhiRxEUdNh8NriSr80nL/Znfhf4hREQvIruQnbf4rCPLjVTfjvRYHLf50WwPbNYKrbWC8dYuLvsgZ24n9lr4PfXsT3Z5Jf8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM5PR1201MB0140.namprd12.prod.outlook.com (2603:10b6:4:57::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 30 Apr
 2021 14:06:17 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510%10]) with mapi id 15.20.4065.030; Fri, 30 Apr 2021
 14:06:17 +0000
Subject: Re: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
To: amd-gfx@lists.freedesktop.org
References: <20210428151154.28317-1-jinhuieric.huang@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <5ca292d3-409b-802e-a618-66ef01b10821@amd.com>
Date: Fri, 30 Apr 2021 10:06:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <20210428151154.28317-1-jinhuieric.huang@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2048:122:150d:2265:cbad:a5fb]
X-ClientProxiedBy: YTXPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::22) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:150d:2265:cbad:a5fb]
 (2607:9880:2048:122:150d:2265:cbad:a5fb) by
 YTXPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend
 Transport; Fri, 30 Apr 2021 14:06:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b09a0df-4c2a-4968-c39b-08d90be11f7e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0140:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01400BCB33D45035087A9FD8825E9@DM5PR1201MB0140.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/0T8Vo8EFBGfax5PgTRD1Kmaa0fpzjj9QFjoxvToQBXM2qSjUbXvRDri0Uiw34kQb+7NJTLqOVKy94kNxecjiymH723oO3TTthmbwo0D9kSdZkRR9B2mGVSeSzwlSW6JVUZwH3UL7FV6GeIIoDpKalR7iJ+1ZpqG8AYBZYr8JQqWl8W/oNpKTn9Q6UeB9ssOdSqMEwTzuze2vjVzJzmX28MUJlvR9u4yQ/ggTQaLlGzFvZRiSN0hWj2qzin+4ffMuUsHrHLTjukKClsapkEQgLv3nszWl0FN/+Vjm1gua/pXuu0uqJSoA974/LDSanPPRv1yb2MUON0DhhFWpTjN0akS/kWJdhMqRlCaYJq30an6ZN48IpjarEWE3wy+ueg6M492WwoXTChPsCfoxEiBPI0W3R1khA/LNPmK01+OKrdCxRI+hJJHZKAPFBJi09YNiCDtWcmv8O2unn5MrEP65+1991hCJ6c8ZdGiA4vhpspjiGLv+Ao64mn7BOPDMswk2CobsiW+9PGY6nbusm6N9sUZq1eqt9cbgWvJhos1Fy793qTvEei4EXyllMH1sxNXWqC+157EU8/bEY8YFf9RAm7jwGs1DUPR/MwvQcQCBZfYrOU7ol3hUsggNVHjqWDDySYRQiAQU9+ifTo03eKbI+uuhPLaQL2YuGpV06bPmqiiW4vixuhz8aJjj0RA5re
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(2906002)(66946007)(66476007)(8936002)(66556008)(8676002)(53546011)(316002)(6666004)(83380400001)(6486002)(86362001)(38100700002)(31686004)(31696002)(6916009)(186003)(2616005)(36756003)(5660300002)(16526019)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bHRHRUVsVzd5R29jcHI2Q0x3WFBJTk5pbTh3ejJzMVVqZ25VeS9nYlVBblB6?=
 =?utf-8?B?aWFNVzdabWNQRHNSdGM1dmhzUmJBZnZKcEpsVzFFN3orNGJteTV1dlhwbUlZ?=
 =?utf-8?B?ZG5NaUJveG9IY1ZKeWNGSzBQck9jcTZNdEF2MGo0UkR1VytWczdqem5HOUV1?=
 =?utf-8?B?WlhQWlVsbkw5cFNXbElSZlh0ZlZrWEtKaEFMZ3g4bUVVRktUN2VCUUpJSUZQ?=
 =?utf-8?B?Y050ak85dks5dlhrVk1sdXVId1hRZGhaY0tGNXBmN2JBcUIxRkQxRTBJYmJr?=
 =?utf-8?B?SCsrUllOM3lVTnFDVFFHVzBLZlhGWTdCeGZLWWswRWVtS2dySUNVZ2pGV0l5?=
 =?utf-8?B?NElhMHNkc3pSaVdCTER4U3FYYUgwQ3JzQ0RIYlFWTTZjcUtkanV4aUJ2WlJu?=
 =?utf-8?B?Y3BuVVJma3RQcmhIeXNyeDcyeEtXY2JlSndsQmNSWkpKUksxYlJmUklUUHVR?=
 =?utf-8?B?YUQvRFQ5a3RXRGhoOGNnQ3FvSEJIbDZROXNMcnpwcnhlRHBoajFqYXFlUHNS?=
 =?utf-8?B?MUkyMm9OdmIrZ2xyT3lLMEdwbzhmWUpmQStxSjlOc2s0MlR3NG5WOWxRSDc4?=
 =?utf-8?B?VThVYkpWbi9lbEFBTzhUY1FhYTZoV3lTQ3JDYlNGdFFCVGE0YnAwSExWTFBC?=
 =?utf-8?B?OFlnQ3ZLQXhtV3BIY1R6MVJybUVhUWVxY1k5cEZVQVk4U1ZFOVhtUVVQdzNv?=
 =?utf-8?B?Z3R4MkZvZzFpUHM3bGxDd1VKbElsdTNZaDl3ZXdlY2ovK0l1dXNadk5sc0VR?=
 =?utf-8?B?QmZ6a3A4VmlKTmNRYi8vM0t5UVNjb0s4MjdlUW1qSURkUnJuOWtyYVl1VGYw?=
 =?utf-8?B?UTQzaVlaMTZrS1NPbjl5c0V5dVdOcjVueXFQMm9DbTd1ejhLdnMrdmpQdXVF?=
 =?utf-8?B?bDZ6OUx0K1BSNG1IVjZleHVSckFFZjdaZlpnNzRDcHlLdTFOSlZXalJZMUh6?=
 =?utf-8?B?d0V4dEhvWFlqSFZnZ3JGRFZsYzlQVmNta2RBYUs0dDd5QUg1SVl1YU9uNXAv?=
 =?utf-8?B?Z054NkxKMW94RS84OGpBemVHYjVlWVh5TVhtQkZGUHl0Q2dTc09IVnliem9v?=
 =?utf-8?B?Z0tBNDN2TFVmOWpqdU5oakpGTXFYVzhDVUNJVjNrSDF3VXcwSkk1VnhCaGpN?=
 =?utf-8?B?Ly8rSkdZUHI0eUZsazlsOVA3K2k3L0w1QWNqUm5IaHlaVEQ2Q2JLV2luR096?=
 =?utf-8?B?NDU5UjVXbUpYbmhqazZHZ2piemgrY2R5THJLOTY1aUFySm9COWgzVFFRdnM5?=
 =?utf-8?B?am9kdHBaQzZpK0wvSUx0cVcyV3Z5YVkvR3NFZ0xXK0lLWDI2OWxmT1Z4RWlw?=
 =?utf-8?B?anc0QWt4S2g4ai9Yc0x1bTdGWm5KTVV5bHhiblM3SXUwUGI2Tm5oZW9VTzhL?=
 =?utf-8?B?M0tUSWRXY2VVN1NSMHIwWkJ3Yml3UlhmbHJMSVdHek5DQWRiR1RhUk1PUzJU?=
 =?utf-8?B?Z2lLbklKSGJIUnF0Q2JjZmVzM216dWluUEZaR2tFN2JwQXlvQ01kM04vNGFH?=
 =?utf-8?B?WEUzWXlkT0txQjZsSXQyVlRNVDVQQkh5eDZ2OGxWaHdrYVQxVUtRQWpNSzlx?=
 =?utf-8?B?QXNEYmo4amJweFFvSWs5Uno2OGZrSGgvN1lZYXNMdzVVRG11RXNzNk54Nko2?=
 =?utf-8?B?aDZoQnVmVUxJcVU5cWxwWG16TW5GdWl6dTJqSkF0OFgrNGVZVE53Ni82NE1E?=
 =?utf-8?B?UGE0UGJuSDVvemlaVnJTZkV3ZzJqTVVYVTkwR2hWWWoybjQ4amp0cTlYajl0?=
 =?utf-8?B?K1FIVUVwTmRhcWlqQWFYa3ZmTGRNM0hhaEJDbkloY0F2dGpLZXh2N3V5WVBv?=
 =?utf-8?B?TWVadjVZOFBMU3pDSzJ3aE1wNFp6cEt4clhTUXhGUjlZL1krOG4rRGZiU3JV?=
 =?utf-8?Q?2JfihxSS/NhUp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b09a0df-4c2a-4968-c39b-08d90be11f7e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 14:06:17.5583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSnviH2NaacB987IIhbqEUmqNXTSlNcY9bQGYat2Tdm96ngj/vV80Fdnsot1RKYj9brDMzLcmpgzEXV97jmM5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0140
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

ping...

On 2021-04-28 11:11 a.m., Eric Huang wrote:
> In NPS4 BIOS we need to find the closest numa node when creating
> topology io link between cpu and gpu, if PCI driver doesn't set
> it.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 94 ++++++++++++++++++++++++++-
>   1 file changed, 91 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 38d45711675f..57518136c7d7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1759,6 +1759,87 @@ static int kfd_fill_gpu_memory_affinity(int *avail_size,
>   	return 0;
>   }
>   
> +#ifdef CONFIG_ACPI
> +static void kfd_find_numa_node_in_srat(struct kfd_dev *kdev,
> +		int *numa_node)
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
> +
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
> +				*numa_node = pxm_to_node(gpu->proximity_domain);
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
> +	/* workaround bad cpu-gpu binding case */
> +	if (found && (*numa_node < 0 || *numa_node > max_pxm))
> +		*numa_node = 0;
> +}
> +#endif
> +
>   /* kfd_fill_gpu_direct_io_link - Fill in direct io link from GPU
>    * to its NUMA node
>    *	@avail_size: Available size in the memory
> @@ -1774,6 +1855,9 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
>   			uint32_t proximity_domain)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)kdev->kgd;
> +#ifdef CONFIG_NUMA
> +	int numa_node = 0;
> +#endif
>   
>   	*avail_size -= sizeof(struct crat_subtype_iolink);
>   	if (*avail_size < 0)
> @@ -1805,9 +1889,13 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
>   
>   	sub_type_hdr->proximity_domain_from = proximity_domain;
>   #ifdef CONFIG_NUMA
> -	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE)
> -		sub_type_hdr->proximity_domain_to = 0;
> -	else
> +	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE) {
> +#ifdef CONFIG_ACPI
> +		kfd_find_numa_node_in_srat(kdev, &numa_node);
> +#endif
> +		sub_type_hdr->proximity_domain_to = numa_node;
> +		set_dev_node(&kdev->pdev->dev, numa_node);
> +	} else
>   		sub_type_hdr->proximity_domain_to = kdev->pdev->dev.numa_node;
>   #else
>   	sub_type_hdr->proximity_domain_to = 0;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
