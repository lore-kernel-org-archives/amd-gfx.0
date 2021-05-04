Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4110DC433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 14:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F3461186
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 14:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F3461186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57D126EB13;
	Tue,  4 May 2021 14:35:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23EA46EB13
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 14:35:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klHw1p0QpjF6NdRq4VuNQuiOlT6t2o+2OkK0pbu5+ms0dStKQtiCuF+QhrYamKEz9dKa3SwP6RAvxa3qg8USFqjlyNxdPy1YJql7+5pBYX0BPonnEfoRRzvTUXE79ZMfilWUUcOy6EE5iO3xPCqVedrjU6vB2U3VfuVH00h/8VeTEQJNjizRqns6URsTLggeLcCqOzQmpT8wBK935ylOnFpg5kZ02xSCOG0SFeQMd/EHTSZTHL0AAcJireViAjcneEct9QQpRukWQiAWEPMK5Ky6U3b7Rl5mKvKOhIfZv+vqSO7LUcOpklc0W/mlpvOj1AvU0USHWWZz+e7raxmIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpBe8Rt43F7LQkDgahpoFPW7YvfkJFtBlunJzcM5rqI=;
 b=WcZMgb67tVV1gZKHAODD7X8syvxknLbqP0Qufw5KHU0cCjX2hU1xvKFLMWUosJXTpMQeQWU1shIb6pOG6ujmLoWwb8i4BB/0eUwfzHDFZL2LFlmGLOg/2U+j3bvRbe02865DTiq5KgAn/AqMB7dAvefeRjnZ5t1PPHLOucOedbh1kxtmJmul5V3E48Pe1HnMJaGJc0iasrSFf+H5bJz5MxZnR5QgiSHdzEm4tS/NGxZg8lLtwPOGxrwkRyM9WksEMC1VqbAybW3j20JRPwV0TAOQAiSLpJ5nxU6KkjjZg8Rtlqxhgd5IvZvpmCTAI1FkkXza3c62mkjvn7MBdvx2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpBe8Rt43F7LQkDgahpoFPW7YvfkJFtBlunJzcM5rqI=;
 b=uCQF6xyizdEiTNzoH4Zo55juURS0jGnZTWG0Upxylb1UzTszQ4Lyuz/97OVzQP0mAKDdnXFYASI3SJRu7JH6ydFP9z5K3L508bnSfYu+8CKUSOStO88mwL7UEHWbi/ODxtEVtypaaB4YgVg7zmMgUV6CIN83fYgP0TP500qlKB4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 4 May
 2021 14:35:41 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510%10]) with mapi id 15.20.4108.024; Tue, 4 May 2021
 14:35:41 +0000
Subject: Re: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210428151154.28317-1-jinhuieric.huang@amd.com>
 <MN2PR12MB4549A0F3CDC8BF13CF2D115A975A9@MN2PR12MB4549.namprd12.prod.outlook.com>
 <39a370c3-35e5-64b3-716f-20fbcdec49e8@amd.com>
 <MN2PR12MB45495C464A09AB31CE635986975A9@MN2PR12MB4549.namprd12.prod.outlook.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <c0b8db9d-4048-3e22-a924-9970a70964c7@amd.com>
Date: Tue, 4 May 2021 10:35:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <MN2PR12MB45495C464A09AB31CE635986975A9@MN2PR12MB4549.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2048:122:150d:2265:cbad:a5fb]
X-ClientProxiedBy: YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::27) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:150d:2265:cbad:a5fb]
 (2607:9880:2048:122:150d:2265:cbad:a5fb) by
 YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.39 via Frontend Transport; Tue, 4 May 2021 14:35:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8be3cf31-d381-4f74-89fd-08d90f09e485
X-MS-TrafficTypeDiagnostic: DM6PR12MB4281:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42818010A1CD2EDAAF6B0BAC825A9@DM6PR12MB4281.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xN7DtDLqvlKCq/v5fE5ZUI7Vmr4qT75jnujBXxYfDc6tHaJu/IjFfOmM9zzW8BFiBFM/822cdlM+6dg3glQlaUDfVpI0dGAfXCPshzUNhAMYzIn9mtyrIF/qPI8ONf2CUHAVBj4IiKpynfE55QFpuzPQJDz4GlWuRGZbSAA0IbO8hcz+OAG1D4EuQ+vLhqrE+J/J7vr5L1zN7M/CXA5v7NR1RUCWu6YCfj54E0vze9csfZGVQFFj6+/i/QWYEaUzZ1O8SEtlOezHM/RQJz+Krp8l0k4flrr1x6U9Mu36RptjbbxVjT+4/mdjtPiomRD+lRa8hV435C+xXbxmgYgmHtRQvUddz3088R3yFQkuudwfpM7BZCHqdCAKjU4PB75P8MfZXztM6BgaK2wmZS1mM+PXQiiW7imxGDbga/FwK6m7qn+EPS44U4XlNjkoiJyOR/uLisQCEDhX8j6GO5NZ+cgg8SeJuxI3wH9yR8g+zKzQ9IIqvLFUCLzefh4jNZ6nuNQqbwyeFljvdi9F3eKoXaU+1VljnPfz0eEcP65Mm4oO/L6vlqXkKhoE8tbVlb4CklAcD4Q6hRXbVFe16/2gnnLxg3vIHMHPxGVgi20HeD4ClDmgtQ203Xw6RStcmd9ZcINV2x1OE6+9AE49JIA+oaRWV+zCLXBIaTMqTiLwKIjgssrfzJVi3HHvflQ9AH2CvNCzxLAvnsaVLpHnHJSX6hY+0Iu02VUBsKa5bf+KSYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39850400004)(136003)(376002)(346002)(53546011)(36756003)(33964004)(66556008)(66476007)(5660300002)(31686004)(2906002)(31696002)(2616005)(6666004)(38100700002)(110136005)(166002)(316002)(83380400001)(8936002)(86362001)(186003)(8676002)(16526019)(30864003)(966005)(6486002)(45080400002)(66946007)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q0tPTXFDK0hvU2x3eTkvRkozNEx1MVNRdVF4aGZZdjZSTGVCbVJicmVBK1pJ?=
 =?utf-8?B?NEZTVTBucERYeC9ydlNoL0tEbW8xRC9GakplMHpiUUVvZTNDbU8rYisydDY1?=
 =?utf-8?B?djVWRmg1bDZEazM2OHFJYlh3NlNScENqbkwrYTNsRytwWlJQaTJma21pZFRn?=
 =?utf-8?B?ZTZxWTZvdFE1VkNpR2U1YlRhRHdGNVhlQmViRk9ITzdmbzB5a1dZU0R3VEhw?=
 =?utf-8?B?cVVyUUJxTVhyUFFPeEZsYmlyK2o3dFlMTmVLLzVwa1BVcDU2Ukw1ZmlwNGJl?=
 =?utf-8?B?dDhlY3ljM0VOOEE2ZUM1VE1KaUdtMlBtZTlkMGc2ck1IRmNlNjJKTWtvcDVG?=
 =?utf-8?B?OEJaM1ZCdUhiWnlqVWNKYzFORlo0UzhMbFVDaW8velFrY204RHNCd1VUOFN3?=
 =?utf-8?B?MVVEQUMveWRodnI1NEZQM2lrVThmWEV2V3dZWGljODI4eXFCOExMenFaL20x?=
 =?utf-8?B?a0Z6VHp4MUJPRkllbHYxN0JLZmtQZ2FPa0ZQRDRmT2kvNHFVc0s5SWdIbjha?=
 =?utf-8?B?emZlU2hUN3dEZzlMcmVxK2JqV3I4akNyU2xzSmhRa1IySmpiakJ6azlXMTI1?=
 =?utf-8?B?a2RuVElWb25xRDBUZmxHUVMybFVoREQxajZ6bFdSbWhZcjNSeGRSTnMzci90?=
 =?utf-8?B?NVpsTXB6WlgvV21uYUNVWnFYamlYK2FucE9IRHFUZTFIdnF0ZzZRMTgxdVRZ?=
 =?utf-8?B?SXphdmhmMnBSQWJpVzhYV3hZQkhTRXhJSEY3S2NYbjFQVDU3bU1TdStoTUQ2?=
 =?utf-8?B?YmJ4Tng0SE1TSGdoZTdOQ1NqeEllbDl6ZnB3UkpxZStJM281dWc0dVJ3OTVM?=
 =?utf-8?B?OHZJcC9DbVRVYkxVZmlpQVhtN25BVGFLMkJ5akpWUzFEOWt0RlM2NnhJUWlM?=
 =?utf-8?B?VkcremFLN0dWYk5Fa0lWN2ZYcTM1aHBxM2djSVNtTDFySzY5NHdvaGd4V3JL?=
 =?utf-8?B?OTJaTkpCNUpsc1N1ZW42Tng0TWNuY3dMMXptODFPcVVydGRCOG1nVTBqdFpU?=
 =?utf-8?B?Q0dnQ1p4VS8yVFptc2wrRVlMeGRpaWYyTTF3R1FPb3BYVjhIVm8zQ1gyY091?=
 =?utf-8?B?WmczN1duaUE5U0dqTmpNdnJsWEdvNDdtVzM4QnJQMXRqQkhMdEZLNXEzVXdE?=
 =?utf-8?B?VjA2Z1RJL3UzWGJ1aS9xTm9WYmtwdzJ5SWpFNk41YmQ1TXcwTzRlYUx4SDVB?=
 =?utf-8?B?ajJENmQ2NmhPQU5DTm5Sd3RoUy81YTZRVHJkOE01UjdmSXlMZktiMk8zWlNh?=
 =?utf-8?B?QnMxVnlNaVp4OXEveVZ6cUl5dThkWGIwTzhoT3poaXlETWFLUzVTQzNlR3d0?=
 =?utf-8?B?TzBkZ1Q1OGgwUUNhV3RIbVlzVEVkREhGY0VNdHdLY3h5M1R6aWtVKzY5MXlP?=
 =?utf-8?B?R0ptMWxEM2xqYVYzSE9ZV0xKNWdPQW5kYUd2cTZ1KzJGdUMxQ1dXN1RzVXQr?=
 =?utf-8?B?ZUpxeEdFMHhnbUU4NDJvVlEwRWV0SDg2UDVKYUEvQnNmdndxdm9yMUs5TU14?=
 =?utf-8?B?OFhVc2NQMXpNMFdRZ2RVUXJCS1ZYVXhGMHBFUXdRQ2pjWWRMTWpnNDhGakNW?=
 =?utf-8?B?RXkxYUZsOVFCODNVM29vdEhDb3FwUWcxa3BHcitPWFNoanp2V3lFSUVvOVFK?=
 =?utf-8?B?L0xPS2JRSDQ3UCtoc1NIOExIbXhUa0VDeXRZUXRHa2dhaFIyMnRRUlpzYlFq?=
 =?utf-8?B?V2dpRkYyNkE0eVlNM1dxdE9pOGorVjNQZnZVaEpualZlZExkSUlDSTNtajE5?=
 =?utf-8?B?V0lINnkvVUdJOUNGOXBTUUNIMHRnT3hRblpwVUluQVoyV3cxYnBpMGJBNUhl?=
 =?utf-8?B?RWtZYk1pTXNTTUx4eUw3cUxLZTBIU2NFR3pGVGFPMjBBUFFQck14NmhqTTFX?=
 =?utf-8?Q?Sg8ouTmhfnsoZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be3cf31-d381-4f74-89fd-08d90f09e485
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 14:35:41.3984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRi3ossKKXaIOKY3l0QRDI3BMipx2OSKeqZqTeFvoZgz5Vx6oG3ue6lhAlgvQ19oVJofGd3LxfFlia9zMvjuJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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
Content-Type: multipart/mixed; boundary="===============0531826629=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0531826629==
Content-Type: multipart/alternative;
 boundary="------------7A0137C13D76DFB0F94A2E82"
Content-Language: en-US

--------------7A0137C13D76DFB0F94A2E82
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Good point. Thanks.

Eric

On 2021-05-04 10:30 a.m., Lazar, Lijo wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Converting using pxm_to_node and then comparing against pxm value 
> looks a bit odd. Shouldn't the comparsion be between equals - node to 
> node or pxm to pxm?
>
> Thanks,
> Lijo
> ------------------------------------------------------------------------
> *From:* Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> *Sent:* Tuesday, May 4, 2021 7:30:44 PM
> *To:* Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
> Like I answer Oak's question,
> "For GCD parsing, the relation of GCD to CCD is defined by AMD, generic
> parsing in srat.c is considering a GCD as a new numa node which is not
> suitable for our need."
>
> GCD's pxm domain will get a wrong numa node which may be bigger than CCD
> domains, so I have to do a sanity check to correct it.
>
> Regards,
> Eric
>
> On 2021-05-04 3:46 a.m., Lazar, Lijo wrote:
> > [AMD Public Use]
> >
> >> *numa_node > max_pxm
> > Why numa node number is compared to a proximity domain? Since you 
> are already using pxm_to_node() API, assume that should take care.
> >
> > That also will avoid parsing ACPI_SRAT_TYPE_CPU_AFFINITY structs.
> >
> > Thanks,
> > Lijo
> >
> >
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
> Eric Huang
> > Sent: Wednesday, April 28, 2021 8:42 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> > Subject: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
> >
> > In NPS4 BIOS we need to find the closest numa node when creating 
> topology io link between cpu and gpu, if PCI driver doesn't set it.
> >
> > Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 94 ++++++++++++++++++++++++++-
> >   1 file changed, 91 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > index 38d45711675f..57518136c7d7 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > @@ -1759,6 +1759,87 @@ static int kfd_fill_gpu_memory_affinity(int 
> *avail_size,
> >        return 0;
> >   }
> >
> > +#ifdef CONFIG_ACPI
> > +static void kfd_find_numa_node_in_srat(struct kfd_dev *kdev,
> > +             int *numa_node)
> > +{
> > +     struct acpi_table_header *table_header = NULL;
> > +     struct acpi_subtable_header *sub_header = NULL;
> > +     unsigned long table_end, subtable_len;
> > +     u32 pci_id = pci_domain_nr(kdev->pdev->bus) << 16 |
> > +                     pci_dev_id(kdev->pdev);
> > +     u32 bdf;
> > +     acpi_status status;
> > +     struct acpi_srat_cpu_affinity *cpu;
> > +     struct acpi_srat_generic_affinity *gpu;
> > +     int pxm = 0, max_pxm = 0;
> > +     bool found = false;
> > +
> > +     /* Fetch the SRAT table from ACPI */
> > +     status = acpi_get_table(ACPI_SIG_SRAT, 0, &table_header);
> > +     if (status == AE_NOT_FOUND) {
> > +             pr_warn("SRAT table not found\n");
> > +             return;
> > +     } else if (ACPI_FAILURE(status)) {
> > +             const char *err = acpi_format_exception(status);
> > +             pr_err("SRAT table error: %s\n", err);
> > +             return;
> > +     }
> > +
> > +     table_end = (unsigned long)table_header + table_header->length;
> > +
> > +     /* Parse all entries looking for a match. */
> > +
> > +     sub_header = (struct acpi_subtable_header *)
> > +                     ((unsigned long)table_header +
> > +                     sizeof(struct acpi_table_srat));
> > +     subtable_len = sub_header->length;
> > +
> > +     while (((unsigned long)sub_header) + subtable_len  < table_end) {
> > +             /*
> > +              * If length is 0, break from this loop to avoid
> > +              * infinite loop.
> > +              */
> > +             if (subtable_len == 0) {
> > +                     pr_err("SRAT invalid zero length\n");
> > +                     break;
> > +             }
> > +
> > +             switch (sub_header->type) {
> > +             case ACPI_SRAT_TYPE_CPU_AFFINITY:
> > +                     cpu = (struct acpi_srat_cpu_affinity *)sub_header;
> > +                     pxm = *((u32 *)cpu->proximity_domain_hi) << 8 |
> > + cpu->proximity_domain_lo;
> > +                     if (pxm > max_pxm)
> > +                             max_pxm = pxm;
> > +                     break;
> > +             case ACPI_SRAT_TYPE_GENERIC_AFFINITY:
> > +                     gpu = (struct acpi_srat_generic_affinity 
> *)sub_header;
> > +                     bdf = *((u16 *)(&gpu->device_handle[0])) << 16 |
> > +                                     *((u16 
> *)(&gpu->device_handle[2]));
> > +                     if (bdf == pci_id) {
> > +                             found = true;
> > +                             *numa_node = 
> pxm_to_node(gpu->proximity_domain);
> > +                     }
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +
> > +             if (found)
> > +                     break;
> > +
> > +             sub_header = (struct acpi_subtable_header *)
> > +                             ((unsigned long)sub_header + 
> subtable_len);
> > +             subtable_len = sub_header->length;
> > +     }
> > +
> > +     /* workaround bad cpu-gpu binding case */
> > +     if (found && (*numa_node < 0 || *numa_node > max_pxm))
> > +             *numa_node = 0;
> > +}
> > +#endif
> > +
> >   /* kfd_fill_gpu_direct_io_link - Fill in direct io link from GPU
> >    * to its NUMA node
> >    *  @avail_size: Available size in the memory
> > @@ -1774,6 +1855,9 @@ static int 
> kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
> >                        uint32_t proximity_domain)
> >   {
> >        struct amdgpu_device *adev = (struct amdgpu_device *)kdev->kgd;
> > +#ifdef CONFIG_NUMA
> > +     int numa_node = 0;
> > +#endif
> >
> >        *avail_size -= sizeof(struct crat_subtype_iolink);
> >        if (*avail_size < 0)
> > @@ -1805,9 +1889,13 @@ static int 
> kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
> >
> >        sub_type_hdr->proximity_domain_from = proximity_domain;  
> #ifdef CONFIG_NUMA
> > -     if (kdev->pdev->dev.numa_node == NUMA_NO_NODE)
> > -             sub_type_hdr->proximity_domain_to = 0;
> > -     else
> > +     if (kdev->pdev->dev.numa_node == NUMA_NO_NODE) { #ifdef 
> CONFIG_ACPI
> > +             kfd_find_numa_node_in_srat(kdev, &numa_node); #endif
> > +             sub_type_hdr->proximity_domain_to = numa_node;
> > + set_dev_node(&kdev->pdev->dev, numa_node);
> > +     } else
> >                sub_type_hdr->proximity_domain_to = 
> kdev->pdev->dev.numa_node;  #else
> >        sub_type_hdr->proximity_domain_to = 0;
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C96808a6aab7b40861eeb08d90a580524%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637552195438132467%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ipBmGTX%2Fokto1zRuQ8jlDA8p%2B8BOjHZa5WGGKNJszEY%3D&amp;reserved=0 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C96808a6aab7b40861eeb08d90a580524%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637552195438132467%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ipBmGTX%2Fokto1zRuQ8jlDA8p%2B8BOjHZa5WGGKNJszEY%3D&amp;reserved=0>
>


--------------7A0137C13D76DFB0F94A2E82
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Good point. Thanks.<br>
    <br>
    Eric<br>
    <br>
    <div class="moz-cite-prefix">On 2021-05-04 10:30 a.m., Lazar, Lijo
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB45495C464A09AB31CE635986975A9@MN2PR12MB4549.namprd12.prod.outlook.com">
      
      <p style="font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div style="color: rgb(33, 33, 33); background-color: rgb(255,
          255, 255);" dir="auto">
          Converting using pxm_to_node and then comparing against pxm
          value looks a bit odd. Shouldn't the comparsion be between
          equals - node to node or pxm to pxm?</div>
        <div id="ms-outlook-mobile-signature">
          <div><br>
          </div>
          Thanks,<br>
          Lijo</div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Huang, JinHuiEric <a class="moz-txt-link-rfc2396E" href="mailto:JinHuiEric.Huang@amd.com">&lt;JinHuiEric.Huang@amd.com&gt;</a><br>
            <b>Sent:</b> Tuesday, May 4, 2021 7:30:44 PM<br>
            <b>To:</b> Lazar, Lijo <a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com">&lt;Lijo.Lazar@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdkfd: add ACPI SRAT
            parsing for topology</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">Like I answer Oak's question,<br>
                &quot;For GCD parsing, the relation of GCD to CCD is defined
                by AMD, generic <br>
                parsing in srat.c is considering a GCD as a new numa
                node which is not <br>
                suitable for our need.&quot;<br>
                <br>
                GCD's pxm domain will get a wrong numa node which may be
                bigger than CCD <br>
                domains, so I have to do a sanity check to correct it.<br>
                <br>
                Regards,<br>
                Eric<br>
                <br>
                On 2021-05-04 3:46 a.m., Lazar, Lijo wrote:<br>
                &gt; [AMD Public Use]<br>
                &gt;<br>
                &gt;&gt; *numa_node &gt; max_pxm<br>
                &gt; Why numa node number is compared to a proximity
                domain? Since you are already using pxm_to_node() API,
                assume that should take care.<br>
                &gt;<br>
                &gt; That also will avoid parsing
                ACPI_SRAT_TYPE_CPU_AFFINITY structs.<br>
                &gt;<br>
                &gt; Thanks,<br>
                &gt; Lijo<br>
                &gt;<br>
                &gt;<br>
                &gt; -----Original Message-----<br>
                &gt; From: amd-gfx
                <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> On Behalf
                Of Eric Huang<br>
                &gt; Sent: Wednesday, April 28, 2021 8:42 PM<br>
                &gt; To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                &gt; Cc: Huang, JinHuiEric
                <a class="moz-txt-link-rfc2396E" href="mailto:JinHuiEric.Huang@amd.com">&lt;JinHuiEric.Huang@amd.com&gt;</a><br>
                &gt; Subject: [PATCH] drm/amdkfd: add ACPI SRAT parsing
                for topology<br>
                &gt;<br>
                &gt; In NPS4 BIOS we need to find the closest numa node
                when creating topology io link between cpu and gpu, if
                PCI driver doesn't set it.<br>
                &gt;<br>
                &gt; Signed-off-by: Eric Huang
                <a class="moz-txt-link-rfc2396E" href="mailto:jinhuieric.huang@amd.com">&lt;jinhuieric.huang@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 94
                ++++++++++++++++++++++++++-<br>
                &gt;&nbsp;&nbsp; 1 file changed, 91 insertions(+), 3 deletions(-)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
                b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
                &gt; index 38d45711675f..57518136c7d7 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
                &gt; @@ -1759,6 +1759,87 @@ static int
                kfd_fill_gpu_memory_affinity(int *avail_size,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt;&nbsp;&nbsp; }<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; +#ifdef CONFIG_ACPI<br>
                &gt; +static void kfd_find_numa_node_in_srat(struct
                kfd_dev *kdev,<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int *numa_node)<br>
                &gt; +{<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_table_header *table_header =
                NULL;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_subtable_header *sub_header =
                NULL;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned long table_end, subtable_len;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; u32 pci_id =
                pci_domain_nr(kdev-&gt;pdev-&gt;bus) &lt;&lt; 16 |<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_dev_id(kdev-&gt;pdev);<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; u32 bdf;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; acpi_status status;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_srat_cpu_affinity *cpu;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_srat_generic_affinity *gpu;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; int pxm = 0, max_pxm = 0;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool found = false;<br>
                &gt; +<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Fetch the SRAT table from ACPI */<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; status = acpi_get_table(ACPI_SIG_SRAT, 0,
                &amp;table_header);<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (status == AE_NOT_FOUND) {<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quot;SRAT table not found\n&quot;);<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else if (ACPI_FAILURE(status)) {<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *err =
                acpi_format_exception(status);<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;SRAT table error: %s\n&quot;,
                err);<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt; +<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; table_end = (unsigned long)table_header +
                table_header-&gt;length;<br>
                &gt; +<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Parse all entries looking for a match. */<br>
                &gt; +<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; sub_header = (struct acpi_subtable_header *)<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((unsigned long)table_header
                +<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct
                acpi_table_srat));<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; subtable_len = sub_header-&gt;length;<br>
                &gt; +<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; while (((unsigned long)sub_header) +
                subtable_len&nbsp; &lt; table_end) {<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If length is 0, break from this
                loop to avoid<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * infinite loop.<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (subtable_len == 0) {<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;SRAT invalid zero
                length\n&quot;);<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt; +<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (sub_header-&gt;type) {<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACPI_SRAT_TYPE_CPU_AFFINITY:<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu = (struct
                acpi_srat_cpu_affinity *)sub_header;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pxm = *((u32
                *)cpu-&gt;proximity_domain_hi) &lt;&lt; 8 |<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                cpu-&gt;proximity_domain_lo;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pxm &gt; max_pxm)<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_pxm = pxm;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACPI_SRAT_TYPE_GENERIC_AFFINITY:<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu = (struct
                acpi_srat_generic_affinity *)sub_header;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdf = *((u16
                *)(&amp;gpu-&gt;device_handle[0])) &lt;&lt; 16 |<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *((u16
                *)(&amp;gpu-&gt;device_handle[2]));<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bdf == pci_id) {<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found = true;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numa_node =
                pxm_to_node(gpu-&gt;proximity_domain);<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt; +<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (found)<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                &gt; +<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_header = (struct
                acpi_subtable_header *)<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((unsigned
                long)sub_header + subtable_len);<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; subtable_len = sub_header-&gt;length;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt; +<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* workaround bad cpu-gpu binding case */<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (found &amp;&amp; (*numa_node &lt; 0 ||
                *numa_node &gt; max_pxm))<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numa_node = 0;<br>
                &gt; +}<br>
                &gt; +#endif<br>
                &gt; +<br>
                &gt;&nbsp;&nbsp; /* kfd_fill_gpu_direct_io_link - Fill in direct
                io link from GPU<br>
                &gt;&nbsp;&nbsp;&nbsp; * to its NUMA node<br>
                &gt;&nbsp;&nbsp;&nbsp; *&nbsp; @avail_size: Available size in the memory<br>
                &gt; @@ -1774,6 +1855,9 @@ static int
                kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t proximity_domain)<br>
                &gt;&nbsp;&nbsp; {<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct
                amdgpu_device *)kdev-&gt;kgd;<br>
                &gt; +#ifdef CONFIG_NUMA<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; int numa_node = 0;<br>
                &gt; +#endif<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *avail_size -= sizeof(struct
                crat_subtype_iolink);<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*avail_size &lt; 0)<br>
                &gt; @@ -1805,9 +1889,13 @@ static int
                kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_type_hdr-&gt;proximity_domain_from =
                proximity_domain;&nbsp; #ifdef CONFIG_NUMA<br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (kdev-&gt;pdev-&gt;dev.numa_node ==
                NUMA_NO_NODE)<br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_type_hdr-&gt;proximity_domain_to
                = 0;<br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (kdev-&gt;pdev-&gt;dev.numa_node ==
                NUMA_NO_NODE) { #ifdef CONFIG_ACPI<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_find_numa_node_in_srat(kdev,
                &amp;numa_node); #endif<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_type_hdr-&gt;proximity_domain_to
                = numa_node;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                set_dev_node(&amp;kdev-&gt;pdev-&gt;dev, numa_node);<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_type_hdr-&gt;proximity_domain_to
                = kdev-&gt;pdev-&gt;dev.numa_node;&nbsp; #else<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_type_hdr-&gt;proximity_domain_to = 0;<br>
                &gt; --<br>
                &gt; 2.17.1<br>
                &gt;<br>
                &gt; _______________________________________________<br>
                &gt; amd-gfx mailing list<br>
                &gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                &gt; <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Clijo.lazar%40amd.com%7C96808a6aab7b40861eeb08d90a580524%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637552195438132467%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=ipBmGTX%2Fokto1zRuQ8jlDA8p%2B8BOjHZa5WGGKNJszEY%3D&amp;amp;reserved=0" moz-do-not-send="true">
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Clijo.lazar%40amd.com%7C96808a6aab7b40861eeb08d90a580524%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637552195438132467%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=ipBmGTX%2Fokto1zRuQ8jlDA8p%2B8BOjHZa5WGGKNJszEY%3D&amp;amp;reserved=0</a><br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------7A0137C13D76DFB0F94A2E82--

--===============0531826629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0531826629==--
