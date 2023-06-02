Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2357C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 15:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4552610E048;
	Fri,  2 Jun 2023 15:05:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 293FB10E048
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 15:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXt7fzAPib3afe5swIKp4S8Iq4tg01g3pg7gqs5rQwxZSSmPVQhRqC0KbGJ5V5za+EvzTvqE7u1RbzZTltVvLZ0jRrHpAnOHwcVTHOKyLkGu6ZA6gPu0ev0dUa0d2/qiA2owZfgAr84cuIYFHaQlPlkXJPd4dde2h8BX+eClA3g7En6YhRhHyhrEJI4AkNU8JRRDXnC2pmPZIAuQI9+MmrrmMfXWRwz4TiUfdmdKh1QbtpivVkecoGuPRa+FwH/CTMB9LjrHaEOp8VMHaC7ATZ3EURefRQyFLkQ+ifc0oBuyHwoTpx/UhWQqZNUHpWIDspaErO4+Eb+Ul0aIPLmymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb9g0bGcrsxaVWef34qVVQ7JjyDcr8FHFpgjgLPas9M=;
 b=DhJOdn7tExCHI8LKrGotKlEMhkeXDjrwRhb9DTTm9yj8u45m5wiRmevPyTFiiteAtO1n9+CubGyIer79CHiI4tyRBOjmlsmKvMwttoQfiljdqHw2jdEnIB6GH1NomcLPOYGPV6zoFvpfFjM376JEoYuLDZgeeepERRkYS2I+YiFBSxArF2oc/sdd4oyJRRtl/J0wvTNQD0GVKtlp9vhi1o345Ul5ONXy50kIdO6ZIV8qtobt/ibnmS5q5oChD4ESbF1k6Y0j8vPuJNT69fTSiCjtA3wdbF2pC1mfFy/rCRit3yi00Ya3xHv0iJrFAY+9ySlNEMpqT7Z2aILxOPN4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb9g0bGcrsxaVWef34qVVQ7JjyDcr8FHFpgjgLPas9M=;
 b=BjiKOk/8OHxDuqR4tITjKJ6e5GWAduk9NygPfKJHVu27q1/YUX+T97JQ2X8eUMRPdF4gCynMvjoRx3VoX8jeGxdXiZ5gf6ZSg9LYkNq6iuF58FG4pjgRYDSyeVSB7f7qG1QhtW7QPWsBDria/fiEZT5oDM1DCyLKyZi5LDjiOEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 15:05:54 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%4]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 15:05:53 +0000
Message-ID: <fb48be92-de1c-4648-dbb6-e9ebd11d75e0@amd.com>
Date: Fri, 2 Jun 2023 09:05:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/display: Fix up dcn30_fpu.c kdoc
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230602083727.1568346-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230602083727.1568346-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:408:f4::11) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 3997c544-6972-4f9e-fd29-08db637adc44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9FeadxNHaOKhUM4uosjUiE6XBTOPDXspJPgK1Sbb9Tcfx/ZdDPwp7atNbvTg5aFC4IlbS/0GraxXzJ1i+QJdagHgCeETOC/9xraJp7Au6sbl2Ff4BxLrNbwX9RhQPplWsrXcT9oOqlDZrLrkWluYR/Hsl4/VbV488xm0sR/EUlNE2URxeAJGauvhn7ixHhX537Vl/OsGfJ8odorHYQBzBow0mXhfAKq8OkXDpa/NglDDKDEQCkLEzHGJjEqSjZ+wC0XLRK4v8SG7W8P6mZrD2ip5dvEMDf3Tmau4wz2r3CCqtKnDrU0CnpkAzk23tQh5lYNkHc4eRfgfyfGp51wqR5ZcsKawUg2AsXeQfNVlJmlnWJLHPBWX+CA1tWSQbKJRCGy7ATdTsoxwJuo+ovl3HpdXclzAnAODwhgztMnZ/CYGs7XEFqJMvKWvkg11D71IACvk1bUOP3+shuebL0OJxW/XPfnrZiMQbMsw9nGS+nwMgScUFlrPgJ2RJbAD9ZMePSx382D8kkyj+m9pLfPcpjWjfgVoC40vdzR0ym0adxHg5ChWrhmiiufZnS7d9QatGkdnK8GobE4MPs8ZgN1Y16dlrnjfrolXNf4+eSs2ctqzPh9OLMdy+ehgxQBLDs3WSb8flp2BJ1cBW5F6W8Acw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(4326008)(6506007)(6512007)(53546011)(186003)(6486002)(2616005)(83380400001)(41300700001)(5660300002)(316002)(2906002)(8936002)(8676002)(66476007)(66946007)(66556008)(110136005)(86362001)(478600001)(31696002)(36756003)(6636002)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFdPdE82bmFaMFpiT2JCcWgvRGFtYXVxeTd3RmNFNTdyemhETkg0anFuUGNR?=
 =?utf-8?B?ZkpnblNRRVVwVG1iNXRSdjlDOXZmOVFkUlpqL1lNSW10UFY0N3RSTURIbWFU?=
 =?utf-8?B?M1U0YUovV3NWRmY0a2ZmNHYzdnhkWEZBNHg3VjYzRmxjazhWU3krakhvZWxt?=
 =?utf-8?B?REtBeDMycURua0U0UW40ZHJPaGd4b1ZDZCtiUk1HaXp1N0Q1R2UvMEpaNU9w?=
 =?utf-8?B?a0RFVkJPQXFIbG5iNXEvblMrc2lDYlJHMElYdkRJc3FBSURiL0FnNDVySS9z?=
 =?utf-8?B?MmNWQUZFOVJlVnFCZ3JYVk9wQ3pRamhZZWpLN3ZBNkx1RDBpeEFhRzZmU3ky?=
 =?utf-8?B?WVIvQmliK0lCQ1ZlUkJxNDlBZ3lMRWV6TnFhZ3MvNzFzTFVLWmdJVVF1UTIx?=
 =?utf-8?B?NUFqODc3WkVDN2RUNEYyK0tCMVNkUUJwYnF5T3pCNnllTnllQUp1NENiRlNW?=
 =?utf-8?B?Y0NFdVlBYVVoNnQvV3oxelc3N2RpMXNDZmgvWklPSWx3anpRMzIyb1FkTDJG?=
 =?utf-8?B?cVlNTkdtU2MxYnRJN0pMdjNPYVEvQVg5cjg3UllXdE5BQjFJL2hXS09ibGNq?=
 =?utf-8?B?bVpZbEp3WG9nUnN0cUIySTZleDVPSWYwdmJDSnRnRUdibHNOT1ZPQUZzQ1E0?=
 =?utf-8?B?K0NrbGZlZUVJRDFkY3NtYmlGM3ZNMlZJajQxMm1YQUwvR2w1UFlDaHdySDBq?=
 =?utf-8?B?eGErL3h2Mnp3eUkvVS9lQWdxdTdOOFFGcG81SzFzcGhUblIyVmtLbFNuQ1d0?=
 =?utf-8?B?MzBjc21HWlE4Y0lzWjdhVFV4UTFnRHk4b2dJblNTWVQrU0J0eFZjOEF4QTlP?=
 =?utf-8?B?S2JUZDBWV3c5Wk0xUFBlZlU4RmU5T093UGlvOGY1Z0RYc2lpYWV0MEwrMzNW?=
 =?utf-8?B?QnJrVXhMN05YVlJjWGJkdnJJU2JML3d4aXR0bjdCbE9jUVVMYjN4ZDQ0QWpw?=
 =?utf-8?B?THBSbGpEUGpoclZCWGptcE1MclNBdGJhbUJqcXpFZmpGclN5RGxRSTZZQXEw?=
 =?utf-8?B?V0kxUUhHcWtPOEhCdXFDQUwyV2ErRkhwc2tDWk5TUDY5S1prNDdxNzAyTkF3?=
 =?utf-8?B?L1Q0cjFjYVhFTnlvekg0V0hzOUUySUFnM3h3ZWhuL1VQQjZmRGhlTVlqWlA3?=
 =?utf-8?B?T0wxSUd3a3FRQkxsa2NXR2hqTG5uaVdSUFJSbTJscGpXM3lOUzN3aW9uQjU1?=
 =?utf-8?B?bFZ4OU5rY3ZIT3JOdk14aGQxdW90K2RkN0JBbmVnQTlaejduaUlwbXhQMHZo?=
 =?utf-8?B?K1U3bjFpS05YSzZTby80N1o0QmtldnZXUHVkK3RwbndVN1dISDNIT1NaeDI4?=
 =?utf-8?B?UUhLMzI0K3RyRzdpelFZRmdTVHp5dmZTTWRFRGROa3RYNkpKNGhvWnhRR1J1?=
 =?utf-8?B?c3libXlDSTh5ZEczeEJadXhQSzl3MUdXa1g1WmFXNUNMZlFCZnI2UWhEbHZh?=
 =?utf-8?B?L2p4OGZ2cnNlQWxTakJPTE5iQlZwMEtlZ2JhUmh5bStBZTRmUEpGTFV1aTJq?=
 =?utf-8?B?M2JGampZRnlQNjdnM1AwM1N6MkUzclMxdVlwOGFwNGZ4R0ZUemJaUEdnLzNE?=
 =?utf-8?B?WTQ3VWVlZXRLU2M5MzdnQk9WWmhzdUdBQ3VreHN2UWhzT0Z3MmY4Qi9VRVF3?=
 =?utf-8?B?WGtEK2gvQkZaaVc1bUE4M2VCVXFPcXB1QUhEaHpiZVNEd0VCeDBDbVpIRDdr?=
 =?utf-8?B?ME1kVXViaVJPbnF6UzQvV1pCNS80Y3ZsVWdrYnR5MmNnbDdqOWY0Y0wwa09z?=
 =?utf-8?B?M2VUekZWMEFYSk9OTlVPeks5M1RoYzUzeHBtVU0xSzQ5U0E5bTRQUkZXMlhK?=
 =?utf-8?B?a2VTYWU4UTZTQk5CdWZqY3RjT1Y5Y2c3OFBlOU5nS3A0Z2twWnRSUVh5TXFy?=
 =?utf-8?B?UlFNbW1KWjQ3Qy90Tm02SElTbjVkWGtOT3QrY2FJay9QbGVHTERoTTJiZ3Nh?=
 =?utf-8?B?OVNoaVA1cmlrUFJqeDdoRVNVRml1OEFReXJiU00vWHJCNDFZbXRVak1jWU9v?=
 =?utf-8?B?RE51dE1aeWhpRG9ZWGFMUDEwcGtCeUFMbkl1V3prUDc2enJoOXozRnVFMFJU?=
 =?utf-8?B?NWZNZ2lna1NpdzE2dStXM2s5dm5FMkg1bEduTzVVY1ZaZ2hGZW9UMXlRS2do?=
 =?utf-8?B?QlVVZVJwM3ZiZHpwRjFSNXU5VmhQU1ZyakdxVUNZWTZISEVJSUZ1cXBrU2lo?=
 =?utf-8?Q?Z+YRx6fHDhsr2NeVobHVEejNIZTm7+C+qVMM6hmdBU52?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3997c544-6972-4f9e-fd29-08db637adc44
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 15:05:53.8422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyf34lOtB8lLfxoxH2FQlTbwdWgl5lTJZkve/Dl4euak509XXIDkSVngRSBm3CXAsSOzk0AW14bUXYS+TrfL6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/2/23 02:37, Srinivasan Shanmugam wrote:
> Fixes the following gcc with W=1:
> 
> display/dc/dml/dcn30/dcn30_fpu.c:677: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Finds dummy_latency_index when MCLK switching using firmware based
> display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'dc' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
> display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'context' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
> display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'pipes' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
> display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'pipe_cnt' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
> display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'vlevel' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'

I didn't know that gcc also highlights kernel-doc issue, nice.

btw, I recommend you avoid the use of the keyword 'fix' in the commit 
title since some upstream scripts look for this keyword; use fix for 
something that fixes a bug. In this case or similars, consider using 
something like 'Adjust'.

Thanks
Siqueira

> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> index a352c703e258..ccb4ad78f667 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> @@ -674,10 +674,19 @@ void dcn30_fpu_update_bw_bounding_box(struct dc *dc,
>   }
>   
>   /**
> - * Finds dummy_latency_index when MCLK switching using firmware based
> - * vblank stretch is enabled. This function will iterate through the
> - * table of dummy pstate latencies until the lowest value that allows
> + * dcn30_find_dummy_latency_index_for_fw_based_mclk_switch() - Finds
> + * dummy_latency_index when MCLK switching using firmware based vblank stretch
> + * is enabled. This function will iterate through the table of dummy pstate
> + * latencies until the lowest value that allows
>    * dm_allow_self_refresh_and_mclk_switch to happen is found
> + *
> + * @dc: Current DC state
> + * @context: new dc state
> + * @pipes: DML pipe params
> + * @pipe_cnt: number of DML pipes
> + * @vlevel: Voltage level calculated by DML
> + *
> + * Return: lowest dummy_latency_index value
>    */
>   int dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
>   							    struct dc_state *context,

