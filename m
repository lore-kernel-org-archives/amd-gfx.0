Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932C3C433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 14:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3E861027
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 14:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3E861027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF316E47A;
	Tue,  4 May 2021 14:00:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B4DF6E47A
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 14:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLyHj3ELTetxyr9+K8bhgrIisTGZfyf1o7ZbkWZ7KMT/OOt26h1gIOlGItL6nH7z7HRFV1jZ/Kqemdw4Cg0B3v3Fc+TK47sH8z2QhK3I2/yllyGVStDTSqVO5rKjRj3aC29vvU9r3pNJmisTIXSTXFpwwL21OCJVd+5DlQ98m/NoNRaOg0Fr6qj6PwCaZPo1+4uwUkP8NDyQUALJmNXxGH5HQkHCB/AS3F9Z6BUFjwLVoHIEb97vMc1h2loBM5QHEzSfeuwnjFMAwXfpAtR1jf++AQiLl6Dc08+PM5IKu/nd5Pf7r/CLuZf/pjJ5IhcNfXFBiUaCuXIo+rS/WzF7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nCIG7KbBreOn2z1T1ABuMgAAyOAsTVkuf1HiM/gNCM=;
 b=P/kbkeYZMP4gLWEFWygz4Xw3oSb86xldt+CqCUsG3PTRj50WSR5h+bBjQ9OaOYWzwmP4dUCnM7S2ldBeHtCk0TXMRnQOpoyLjpVvn2yuPZGk/womgUodMNLyz1L2dk5FZZcG49h7iOItKT/kwxET3vfViJmVZRV0A/EXes2lkh5g8V6JLv82mYQdPN7Se3v65px5WG/Xvg1bBZDqu3GP8xPEahW6879UmBPWxzIqsHUe/dBmFEGwM1p4z/e3GwAb5/nfVMIR2WrCLQbKHB2rXcHNGolshflmkW3xfAYaYsjvtB9xEu5fcEFwijY89utlPFdGswbTQgQmnTiowag73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nCIG7KbBreOn2z1T1ABuMgAAyOAsTVkuf1HiM/gNCM=;
 b=DXKavU1nzYByRfj5qub+w7kF9fcxAzhilk0CvVpaR+3JprXZWOvClgh7sgJA0xbNRoVa5KA6miCYzrL/+0o3ggBFKF/fj8TH40Jk1NuGNchNxU1XV97JXVZc6KGZZMNw1zgxvNfcPSSIsjWqqGCqDnlarJK/zzBZOTm3glig1MU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM6PR12MB2906.namprd12.prod.outlook.com (2603:10b6:5:15f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.44; Tue, 4 May
 2021 14:00:46 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510%10]) with mapi id 15.20.4108.024; Tue, 4 May 2021
 14:00:46 +0000
Subject: Re: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210428151154.28317-1-jinhuieric.huang@amd.com>
 <MN2PR12MB4549A0F3CDC8BF13CF2D115A975A9@MN2PR12MB4549.namprd12.prod.outlook.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <39a370c3-35e5-64b3-716f-20fbcdec49e8@amd.com>
Date: Tue, 4 May 2021 10:00:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <MN2PR12MB4549A0F3CDC8BF13CF2D115A975A9@MN2PR12MB4549.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2048:122:150d:2265:cbad:a5fb]
X-ClientProxiedBy: YTOPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::39) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:150d:2265:cbad:a5fb]
 (2607:9880:2048:122:150d:2265:cbad:a5fb) by
 YTOPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39 via Frontend
 Transport; Tue, 4 May 2021 14:00:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3670f64e-bc54-471e-1dd3-08d90f0503fc
X-MS-TrafficTypeDiagnostic: DM6PR12MB2906:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB290652B046ACBDE5D93B11D8825A9@DM6PR12MB2906.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHYasap38HnpW0Ouz6SYl/1XLD9z0c3uoXamZsrn+pmVEJ7fVEzOMctKOpmWdR2epV7BlDONaM4aj0HT+kVCAZGhwsFZ11uGASJDQwLP5uSIqwjje2T/ykhj1O8BedevD5cRy/PL9yUgqJ+9E+ueQo/zWf8dq6kO9Imvw8LFftSSZxC6FW0QcxsYPRYKBKMCcrIldWfTIF3B1vivzJj2fYq/9ZjaoQBbUTI/V0teoI1akuNb32Z/w1HbcEZB0K/EJVIC+K9Q74aCwNof9/Att1WyfXtn0EU3Tmf3AOoD2Ix2r4p9jU8AUeY+I2hhYKLfMFIAuxWFsx9ga1bCV0VoS6Io6jW2oxlV+6X7BtvCmw56Ol3me9sStKeAmjQGa6TkuBsW9tiSVah+Kzb81Nz0Mjbm4TN4TMWEz3wqGBpSn0+Yn5YvK9BBdY5t3lboAJK6T8128jA0JR/6tr2/hUUKjJGix9bm9OnkM2tgiz9eK/yPdKRAf0HOOlkl9ujlKlKNjwIgsOzI3m40b03sl3PKhV7uHRQ9pad+r8T33U0k31n8YDvXM78roZXOLJHpwqoAZqET2dAD/SWF0ufeVINcrCWs8TqwlN0RzlTE9XEYxpVCVVFl5zK3SOECmcQ2q58H4dxjQdRregXcMS8CiQRaGQuQXbEGIb0bSS66AnR4aJuPIuqJqKwSSz5ulpVrg05TNyYMCLXuisEuwBwFzgaWTAdj68NccfKuVKj5STcdVmA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39850400004)(136003)(376002)(396003)(8936002)(2616005)(83380400001)(31696002)(66946007)(2906002)(38100700002)(31686004)(186003)(36756003)(53546011)(316002)(6486002)(8676002)(86362001)(45080400002)(66476007)(478600001)(110136005)(66556008)(5660300002)(16526019)(966005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WTZJV0hJOHVVSEFJQmJhZHlvY2hYd2VyZ0paRTdpTWdmNXNQVWdsQjZ2QjJY?=
 =?utf-8?B?eGVnSDc3d202Yk5vMFJPcU14SkU5UEpFY0s2THhoYXMvQUhGaG95bW5wUHMz?=
 =?utf-8?B?ZnROeXlTRnM0UWRuQ1lRTXc4VUsrUElIVnRPRG5NSnUzVHhxVTg4UEFncmor?=
 =?utf-8?B?KzNuTk1Ma2RlYm43S01RcVcrQnk0eXlYcm5uTi9PYldsU0l5a3RnTEFSQWx1?=
 =?utf-8?B?VUFLanF5bmY4OFEvL09xS0Q5WDVMWDhnaGhmTUxJUE5wZUdDUDlBcE5ORlRL?=
 =?utf-8?B?Z2tUN0N2aGxvU1Bhc05aNFNxYUo0QzlSeUd3Z21TMUl2TS96ZGg4dE8yd2Zz?=
 =?utf-8?B?TzFmM2RmNGdiOGcvTUt1WWJZR1JHOUlFM3Z5aVlMdzh5OGNicGp1ZDlNRUtk?=
 =?utf-8?B?aFZqRVBaSER6N0NyeTFRZXN1SU9FckdkNW1jbVNGYlRnTXo0RUlkekx0Vzgw?=
 =?utf-8?B?aGk5eVE5NmxWTGJaV3crdDgzb0t5bVM5QmI1d2hqdlFSMVFaaWFJSnpiMHk1?=
 =?utf-8?B?WEgrZ0lPQTEzaTh5RDdKSEVlSHVtV0pSQk5JV3plb0hHdm5KV1R6em5IalB1?=
 =?utf-8?B?enNMNjhQaHdhTGZ3Vmt0ZE9jRERrYlNFRUo3UW9HY3M3SHBVZkFWRXVEM2Fi?=
 =?utf-8?B?aWY4eUpXYmdRMmdvL0luY0pla3FycEt6VFFWdFRBUGlCbVZmYzQ3b25CMEVN?=
 =?utf-8?B?WmgzS3VvUXNpNVlTWitYZkpNNkRsMTQ2RTllbkhPTi9VR3BOUnQ5UHZ2VWhn?=
 =?utf-8?B?QzdueUlyV2I3SDloV0E0aWRaQWREamk2K2h6R1UyZHlZdU95aFZ5Q0FkOWNv?=
 =?utf-8?B?MTRjOWszaEFlYmJnM09Nd0lPYUR5M0hkbjNmSlg0OVpHazY3UjgyODV1QUlB?=
 =?utf-8?B?d29IV1dmQ2QrOUdMUEJsUEhiNVJNYlRKeGRFVkthbGQyNHpTWFdoWlloWlVi?=
 =?utf-8?B?d1lIL0ozQXdmSTdUeFhKc3JWLy8rNmNqYUZlaWhudWJodEwvYU5iL2FHbGRE?=
 =?utf-8?B?a3lnSnZQSDFYNnphTWpMM0EvQVBBdUFSTmNHdkNoSmpSdE5pVEJQOGJ5bGFV?=
 =?utf-8?B?TERQempoR1RZYXNlNmpETTIvaEhJSXZxRXVtU3ZYV1lHTVo0QkorMi8rUDVa?=
 =?utf-8?B?ZUFqY0FoV2l3VldGVGNiQkl5N3lqcCtCektkeGVwMUpFcUw3RXN0Q05KMURp?=
 =?utf-8?B?clJLK2lhWVltNmdyMHZINSszeUlzNXozY2dWYkVqTkRiQXVxb28yZ3pjSXBL?=
 =?utf-8?B?UzQwUU5mN3doTjVuVXR2eFoxS0ozemYxWWkwWit2UFU5V05kL1pSa0hkb2xI?=
 =?utf-8?B?STMxR2ozcFh1WHA2eWtvV1RtM1NDeWVyMk5uWnBKdDZ6YWtPTGxEVVAwWTU0?=
 =?utf-8?B?TDN0d1JjZkZ2RUJ5V3JYNERUeFIzZmRvVUQ3Z3dIeWlETU1KcFhxZStzemJw?=
 =?utf-8?B?YXVobmlCdTcyc2R3RWJhUUcxUEJ3ZEgwdVkrTVJKS2lCdzNLM3JVUmpaUWJD?=
 =?utf-8?B?WVF6SFlhaFR3ZnZiY0hMaGpoSnlGRVo1Qm9NQUt2QmducSt3R2NYR3duaXIz?=
 =?utf-8?B?MEsvUjZ0K2JaU3owamtudVRNdVFhMU9pSVAyZElWcGhxZjVibUw3OCs4TXNm?=
 =?utf-8?B?MExZT0tnd3hwbG5PM0hxZ2VuVTRROGx1b1E1L1k1Y3J6SkFzUmZoNmRlK0ll?=
 =?utf-8?B?cWpXQ2FublhjK0NvTkNUREtzbEkzaG00MDJqa3JmK2RYa2JzcVEzenhNYklK?=
 =?utf-8?B?dXU3V1JNa0twUnVodjdxcmEybVh6TmJhV1NlQ0hoRlY2RzE3RCtLbnBYZUdj?=
 =?utf-8?B?czdiN3EzNHVXTS9RdWFmQ2t2c0RuVERHOGphSWU0K0Fmb0dMOEt1Tkc1SlQz?=
 =?utf-8?Q?BLBr8tMFCG9if?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3670f64e-bc54-471e-1dd3-08d90f0503fc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 14:00:46.7892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbCQGZZX/kqmSHgthDtzM13zRGl8VjR6FN/vn0WM/nJiqNz6yb0M7tnaujhkTHtynaK7Pw2vzRa2Wof+t+NjHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2906
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

Like I answer Oak's question,
"For GCD parsing, the relation of GCD to CCD is defined by AMD, generic 
parsing in srat.c is considering a GCD as a new numa node which is not 
suitable for our need."

GCD's pxm domain will get a wrong numa node which may be bigger than CCD 
domains, so I have to do a sanity check to correct it.

Regards,
Eric

On 2021-05-04 3:46 a.m., Lazar, Lijo wrote:
> [AMD Public Use]
>
>> *numa_node > max_pxm
> Why numa node number is compared to a proximity domain? Since you are already using pxm_to_node() API, assume that should take care.
>
> That also will avoid parsing ACPI_SRAT_TYPE_CPU_AFFINITY structs.
>
> Thanks,
> Lijo
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric Huang
> Sent: Wednesday, April 28, 2021 8:42 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Subject: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
>
> In NPS4 BIOS we need to find the closest numa node when creating topology io link between cpu and gpu, if PCI driver doesn't set it.
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
>   	sub_type_hdr->proximity_domain_from = proximity_domain;  #ifdef CONFIG_NUMA
> -	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE)
> -		sub_type_hdr->proximity_domain_to = 0;
> -	else
> +	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE) { #ifdef CONFIG_ACPI
> +		kfd_find_numa_node_in_srat(kdev, &numa_node); #endif
> +		sub_type_hdr->proximity_domain_to = numa_node;
> +		set_dev_node(&kdev->pdev->dev, numa_node);
> +	} else
>   		sub_type_hdr->proximity_domain_to = kdev->pdev->dev.numa_node;  #else
>   	sub_type_hdr->proximity_domain_to = 0;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C96808a6aab7b40861eeb08d90a580524%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637552195438132467%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ipBmGTX%2Fokto1zRuQ8jlDA8p%2B8BOjHZa5WGGKNJszEY%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
