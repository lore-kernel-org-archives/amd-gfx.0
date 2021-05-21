Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C1CC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 14:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23BC360FE3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 14:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BC360FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 518C96F887;
	Fri, 21 May 2021 14:23:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 984736F887
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 14:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LD3QofrO4VTgzQOMzszRNCYVsU0KPe2lPcY5rnQc/gIEDiNf59WAGQkDcAUClzdnO58lFOCPO/K/Ofh1QnMWbpJdFpNt1TXs85UbRt99hCnYy/saQt5SlUZjlMYhxIf7wu5V3Ms9Kp3Qxrt5I1kChXOnOZUrL5iYc78KAhf/PIwEX+x0GVfNKB9tRCPUA3d5bJ05fUwFec/+aXGbrGL6eZljIoIncTEiOj7qZilym9/sMG1y4BFTm4JCwKYMZGRJNsIG80miLdwNe6NA/EesoMTrrJEDQyNXnA0D4nuiaQLxprkdc56/BRHHp8cwaBmzN6rByXKBwfBI5BOuCxNDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzyvCtWQqZYOsgKyS4CI3gLrWU67BstCsU8/ATXqEcU=;
 b=UkiRiNpq0Ok8h69Jdy0MEL3kqa5KQVnTa+853NF+Zvsi2U2QRdKJEC+dHOMQ5kRQ7M0YQjpslHp8/QVdtYkF76A0mNzOfXcPWcV0zuFAigS5URT/jyHfIWfsSy3eOOLzYED1hSBcYoY8tzyoUdcpsagVEpi8DANiHFcv9gq3h7ziC6DqPJxw87OiMUIbLQxClySCDQcfEFrF9b3cBD0lEl3bghv7Bvo9sAiSWVDNgnGhhycxXJrvKYYXdWGALdgAoZXYMtXg9HSM03fLSx0agS4SJH+dYu4OPQW1Ckzq5ToVZk8MJIm4rq63TzWVx3WdnAEaEEH1N3N5krixp1CB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzyvCtWQqZYOsgKyS4CI3gLrWU67BstCsU8/ATXqEcU=;
 b=SegjulYg9hYSXodSYs17KSBufYUN/R110GnY1tHKz7AS7AJA3baQFsrt7JH04d96XUxP3FScKbz/D19mIIXJm0Qy0ir4sv2lz/Fjpif1xrN4QB7cCZGrGLzE2Hs/morpYzxzrOOPiE7oiMwNEmMtYnaTBtadWxPQkXRZemAQc7g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5252.namprd12.prod.outlook.com (2603:10b6:610:d3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 14:23:04 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4150.026; Fri, 21 May 2021
 14:23:04 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu/acpi: unify ATCS handling (v3)
To: Alex Deucher <alexdeucher@gmail.com>
References: <20210520155614.309986-1-alexander.deucher@amd.com>
 <1afdccca-8659-8fee-5ec6-17645198f0b3@amd.com>
 <CADnq5_Oo2LSXwc49Kpv7qtvEUZdeivJQ4-BqQsk6FbR5e2wpWA@mail.gmail.com>
From: Lijo Lazar <lijo.lazar@amd.com>
Message-ID: <9421dcca-c513-dcfb-8edb-03b0a8b89a92@amd.com>
Date: Fri, 21 May 2021 19:52:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <CADnq5_Oo2LSXwc49Kpv7qtvEUZdeivJQ4-BqQsk6FbR5e2wpWA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: MA1PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::16) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 MA1PR01CA0146.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 14:22:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e616bb96-647e-4f6a-c5cc-08d91c63f1d9
X-MS-TrafficTypeDiagnostic: CH0PR12MB5252:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5252F59FC9E6D16B7DF9A08897299@CH0PR12MB5252.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiGqv9/ycDdKDxiwHLy7BRHmgBG/qei80sm/+7EtufSo9sB1drXBapkT7aDV8qZBgj3uUVhHUfvekgBbcsnQnGurwTagC6GD1Rfg6D/kGKBtx639494Gd4ZlTVD27X/hYMsqHjQtmIqIrPmFeUD8lajUL0CxEHJ20bHpjYdSMtqc4rIgDQCHBTvuMVCTEzuWZWgQqVeKNiZAklFUQox6Roj8FROYkGLKG4gMUYucxoGwZUO9ZFdL1XRkO15xB4D/s8BxdEN6ilAnoD/HK/hlP7tq+khbJ+XTm6A+sp/mrVxGV05OvJxjh5eClgqYoB6VF+n8Fyp/+ACmng9nd19uZ3OU00NHbO87+Ej/tLRhySqdiR75HS8mEwPxLwiFbARZxvWaxdmsmpUiiSdjDxKfzwmidxH36ClgFzDhMQXqWtNHuW86Lu29semcseq3gZ6XzHSTV0s7u8hwI/aH4eO/M71rqThrcPvow3dhANVKZP5TdJsvxcvCnLNnLveyuJxsKi0ZpjMfXVDIEH7TY1qidQSGLwPfpLe9h4Lq1Y4V4hfTiD+QpNTy1P8DMMdh8u9mB9a6UPHDp/p9MfA16374fvJaXQbVsS9zIe4uOk9uhyjkIeRB9cHq3hoF27ApniZQ4DoocPvNs4i26txm1yCusyBjvy7nkveRM65Z7EuFbkTUf6po9qWj86TW79oh8mqjxFJgOuqEcvpu9RrSD/M0/ugVMIQJfCBqr/zUOZjLl7QuGBJE3UKInDRLrZvhCLZ2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(30864003)(45080400002)(2906002)(2616005)(956004)(6666004)(6486002)(4326008)(26005)(16526019)(8936002)(186003)(38350700002)(38100700002)(66476007)(44832011)(478600001)(52116002)(66946007)(54906003)(83380400001)(16576012)(36756003)(31696002)(966005)(66556008)(5660300002)(86362001)(6916009)(31686004)(316002)(8676002)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aVFRMjViUjA4QXZQZ1pEdE5pRlJGOXlqTlRyUnFJOWJ0K1V0YmFkclNKeHpF?=
 =?utf-8?B?YnpkNmFwZDRZRlgrdzdnZEJ1VWxIY0tNRDBOZWJ3bXJNMWViL2tlbU4vSWEz?=
 =?utf-8?B?WkRlVzdJbjF6TXJDL2Vvd3RKME4wekYwM05iZEpIQ0NPU2szSTR4Zmd2UldI?=
 =?utf-8?B?M0NDZ2JMMnRMUWVDTUlyK2ZKZEN1SjhFSS9PVW5KUEpoYUw2Wm1DckUxeU03?=
 =?utf-8?B?SXIyZC91cXhlNEZaVGE0QUVQd2x0Yk05elFpRG5hbnQxM3dxdE5FTmFtWHVk?=
 =?utf-8?B?YWplUzA2TmQzYnR3RW9BRlRGSXJGVlVvRHZyUzJ0UFlkSGZGM05uOHN3Q2du?=
 =?utf-8?B?Z2EyVE52NU1Wa1AxRUNpN3J4di9lU29UVDNsVEVqSzFoWFdvSmVoNU9xRDI0?=
 =?utf-8?B?MVV5Qnh1YXhUL1hGY3VuelZpTDNhY1B3SmNWVklNbGY1SXQ0M0RWanlrL1Q1?=
 =?utf-8?B?aU1LSXo0UzNyblBFaE13TkV6Q3BWRURjeWFwUWFFWTAxR05id2JmVDdkcVZh?=
 =?utf-8?B?aHpRWGdWcHdzNCtkWHRuMUhsUC8vSjFzeDF2WldZaTU4bE5TbVBQWFo1N2Mx?=
 =?utf-8?B?Rm9CRDZEbVM3dHJnc3ZQSE1iOGxOR2pCNXpqVk1wakx2MkxVMGx4YTNxNGFx?=
 =?utf-8?B?dWFoMmt1WEprNWhGZi9EVms1Sk9QUjdnYkNqOTM2VVR2ZGRuTkFrWnk3Mnk4?=
 =?utf-8?B?M3VKMm9hOTFvNVNiOTBNbkFIYkVpckNvckloOXQvUlMwUEU0aWp0ZlNPWjZ2?=
 =?utf-8?B?SDFYd1BxUm1Ueng3a2FlcjFqYktpUEZUZ0RzaFZ3UjRiVG5Wa0NzSjJOR1VD?=
 =?utf-8?B?UVQzMmpqMWw4UEIzc3QyTHB6dGFjZjJ0UDB1YWRnb3V6Qk5RR21ab05aaWJK?=
 =?utf-8?B?VHlLK3p1OGN0anJwaGhKbU1FVkZBaGgyUGFYcXU0OGlKeFJ5NjI1M0U4T3p0?=
 =?utf-8?B?NlZ6cFltb3NUWVdnNlovOGV3YXc2cGVTbksyUFJySDZUL1Nwa0R4UitEQjJY?=
 =?utf-8?B?WWdmejlkUVRadWxuT3dvZk1mRmR1dXd4SzBwWmtBWTdHQ1Izb2RoQ2pGTEtO?=
 =?utf-8?B?TGdBV3N5L1MrV2UwRWQvVzhnTytPMzc5Y2tHZHcyb3I0ZWFmUjdFZCtqWExo?=
 =?utf-8?B?cnNUZm5laVJWcGFrTTh3anVJRjUvRGFuNmtBVFJnYTZWbmR6ZGZXYmVoK05S?=
 =?utf-8?B?NEdTMGlQNDlJNXNIdGNKWXB6akl1aFJqWHJYc3FnSjlxZGFkRjBHVWM5UEI3?=
 =?utf-8?B?OXEvRzV1MkcyTjB0ckxxQkZNbGRHVitzN2UxbnJVNFBpVlh4eUs5b0h0WGtN?=
 =?utf-8?B?U0NyQll3bG1jaEEvQmF0ZWtzTVNJM2tEdUJwS1FzVlpPNTc2MlFMRjJCR1lE?=
 =?utf-8?B?WjVoL1I0ZVNQUDgvaXM5QXlYUWJJdHNteVY5Ny85QklGbzRLWDArZTQrdnFv?=
 =?utf-8?B?bnRyYWdpbzIyNE9CcVUyZm8raVJnMXN0SkVUS1pxMVJyOEVIeGUrSlArMjBj?=
 =?utf-8?B?RDJMQ1dmWHhaN294NFcxaFF6eWhlUmhydmZwVU9CNXI4emN5WEx6OTVGb2Rq?=
 =?utf-8?B?LzVDTEJCRnc0QVpoNEc3ZStRamZMeVRKM01nRjFmenlKbDRLZnhvMnBHSFcw?=
 =?utf-8?B?RXNwZHV6S2toSkRvQi9wZHdLSWRrMHNsKzMvYTlQZGRBT0cvbmlxV0N2ZkhZ?=
 =?utf-8?B?NnMrNjhCcjdPNzlTTklZbEo4U2xrSUhvKytyb3ZWUXlqeHJJWllJeE5xYTdq?=
 =?utf-8?Q?4biPJeATMNmFozoHwwkqAkXXv8f6ZaAjsRamarL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e616bb96-647e-4f6a-c5cc-08d91c63f1d9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 14:23:04.1018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3gO2EOKFr0hmqDFjQjSXw837G5Cyb4lYEuhz8++0XRZwRZKvtwxlq8rLWCSeVB0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5252
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for clarifying!

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

On 5/21/2021 7:17 PM, Alex Deucher wrote:
> On Fri, May 21, 2021 at 3:12 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 5/20/2021 9:26 PM, Alex Deucher wrote:
>>> Treat it like ATIF and check both the dGPU and APU for
>>> the method.  This is required because ATCS may be hung
>>> off of the APU in ACPI on A+A systems.
>>>
>>> v2: add back accidently removed ACPI handle check.
>>> v3: Fix incorrect atif check (Colin)
>>>       Fix uninitialized variable (Colin)
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  17 +--
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 128 ++++++++++++++++-------
>>>    2 files changed, 93 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index b6435479cac8..ece1aee5a667 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -268,6 +268,7 @@ struct amdgpu_irq_src;
>>>    struct amdgpu_fpriv;
>>>    struct amdgpu_bo_va_mapping;
>>>    struct amdgpu_atif;
>>> +struct amdgpu_atcs;
>>>    struct kfd_vm_fault_info;
>>>    struct amdgpu_hive_info;
>>>    struct amdgpu_reset_context;
>>> @@ -681,20 +682,6 @@ struct amdgpu_vram_scratch {
>>>        u64                             gpu_addr;
>>>    };
>>>
>>> -/*
>>> - * ACPI
>>> - */
>>> -struct amdgpu_atcs_functions {
>>> -     bool get_ext_state;
>>> -     bool pcie_perf_req;
>>> -     bool pcie_dev_rdy;
>>> -     bool pcie_bus_width;
>>> -};
>>> -
>>> -struct amdgpu_atcs {
>>> -     struct amdgpu_atcs_functions functions;
>>> -};
>>> -
>>>    /*
>>>     * CGS
>>>     */
>>> @@ -825,7 +812,7 @@ struct amdgpu_device {
>>>        struct amdgpu_i2c_chan          *i2c_bus[AMDGPU_MAX_I2C_BUS];
>>>        struct debugfs_blob_wrapper     debugfs_vbios_blob;
>>>        struct amdgpu_atif              *atif;
>>> -     struct amdgpu_atcs              atcs;
>>> +     struct amdgpu_atcs              *atcs;
>>>        struct mutex                    srbm_mutex;
>>>        /* GRBM index mutex. Protects concurrent access to GRBM index */
>>>        struct mutex                    grbm_idx_mutex;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>>> index 6cf6231057fc..29708b5685ad 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>>> @@ -72,12 +72,25 @@ struct amdgpu_atif {
>>>        struct amdgpu_dm_backlight_caps backlight_caps;
>>>    };
>>>
>>> +struct amdgpu_atcs_functions {
>>> +     bool get_ext_state;
>>> +     bool pcie_perf_req;
>>> +     bool pcie_dev_rdy;
>>> +     bool pcie_bus_width;
>>> +};
>>> +
>>> +struct amdgpu_atcs {
>>> +     acpi_handle handle;
>>> +
>>> +     struct amdgpu_atcs_functions functions;
>>> +};
>>> +
>>>    /* Call the ATIF method
>>>     */
>>>    /**
>>>     * amdgpu_atif_call - call an ATIF method
>>>     *
>>> - * @atif: acpi handle
>>> + * @atif: atif structure
>>>     * @function: the ATIF function to execute
>>>     * @params: ATIF function params
>>>     *
>>> @@ -237,6 +250,35 @@ static acpi_handle amdgpu_atif_probe_handle(acpi_handle dhandle)
>>>        return handle;
>>>    }
>>>
>>> +static acpi_handle amdgpu_atcs_probe_handle(acpi_handle dhandle)
>>> +{
>>> +     acpi_handle handle = NULL;
>>> +     char acpi_method_name[255] = { 0 };
>>> +     struct acpi_buffer buffer = { sizeof(acpi_method_name), acpi_method_name };
>>> +     acpi_status status;
>>> +
>>> +     /* For PX/HG systems, ATCS and ATPX are in the iGPU's namespace, on dGPU only
>>> +      * systems, ATIF is in the dGPU's namespace.
>>> +      */
>>> +     status = acpi_get_handle(dhandle, "ATCS", &handle);
>>> +     if (ACPI_SUCCESS(status))
>>> +             goto out;
>>> +
>>> +     if (amdgpu_has_atpx()) {
>>> +             status = acpi_get_handle(amdgpu_atpx_get_dhandle(), "ATCS",
>>> +                                      &handle);
>>> +             if (ACPI_SUCCESS(status))
>>> +                     goto out;
>>> +     }
>>> +
>>> +     DRM_DEBUG_DRIVER("No ATCS handle found\n");
>>> +     return NULL;
>>> +out:
>>> +     acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
>>> +     DRM_DEBUG_DRIVER("Found ATCS handle %s\n", acpi_method_name);
>>> +     return handle;
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_atif_get_notification_params - determine notify configuration
>>>     *
>>> @@ -486,14 +528,15 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
>>>    /**
>>>     * amdgpu_atcs_call - call an ATCS method
>>>     *
>>> - * @handle: acpi handle
>>> + * @atcs: atcs structure
>>>     * @function: the ATCS function to execute
>>>     * @params: ATCS function params
>>>     *
>>>     * Executes the requested ATCS function (all asics).
>>>     * Returns a pointer to the acpi output buffer.
>>>     */
>>> -static union acpi_object *amdgpu_atcs_call(acpi_handle handle, int function,
>>> +static union acpi_object *amdgpu_atcs_call(struct amdgpu_atcs *atcs,
>>> +                                        int function,
>>>                                           struct acpi_buffer *params)
>>>    {
>>>        acpi_status status;
>>> @@ -517,7 +560,7 @@ static union acpi_object *amdgpu_atcs_call(acpi_handle handle, int function,
>>>                atcs_arg_elements[1].integer.value = 0;
>>>        }
>>>
>>> -     status = acpi_evaluate_object(handle, "ATCS", &atcs_arg, &buffer);
>>> +     status = acpi_evaluate_object(atcs->handle, "ATCS", &atcs_arg, &buffer);
>>>
>>>        /* Fail only if calling the method fails and ATIF is supported */
>>>        if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
>>> @@ -551,7 +594,6 @@ static void amdgpu_atcs_parse_functions(struct amdgpu_atcs_functions *f, u32 mas
>>>    /**
>>>     * amdgpu_atcs_verify_interface - verify ATCS
>>>     *
>>> - * @handle: acpi handle
>>>     * @atcs: amdgpu atcs struct
>>>     *
>>>     * Execute the ATCS_FUNCTION_VERIFY_INTERFACE ATCS function
>>> @@ -559,15 +601,14 @@ static void amdgpu_atcs_parse_functions(struct amdgpu_atcs_functions *f, u32 mas
>>>     * (all asics).
>>>     * returns 0 on success, error on failure.
>>>     */
>>> -static int amdgpu_atcs_verify_interface(acpi_handle handle,
>>> -                                     struct amdgpu_atcs *atcs)
>>> +static int amdgpu_atcs_verify_interface(struct amdgpu_atcs *atcs)
>>>    {
>>>        union acpi_object *info;
>>>        struct atcs_verify_interface output;
>>>        size_t size;
>>>        int err = 0;
>>>
>>> -     info = amdgpu_atcs_call(handle, ATCS_FUNCTION_VERIFY_INTERFACE, NULL);
>>> +     info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_VERIFY_INTERFACE, NULL);
>>>        if (!info)
>>>                return -EIO;
>>>
>>> @@ -604,8 +645,10 @@ static int amdgpu_atcs_verify_interface(acpi_handle handle,
>>>     */
>>>    bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *adev)
>>>    {
>>> -     struct amdgpu_atcs *atcs = &adev->atcs;
>>> +     struct amdgpu_atcs *atcs = adev->atcs;
>>>
>>> +     if (!atcs)
>>> +             return false;
>>>        if (atcs->functions.pcie_perf_req && atcs->functions.pcie_dev_rdy)
>>>                return true;
>>>
>>> @@ -623,19 +666,15 @@ bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *ade
>>>     */
>>>    int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev)
>>>    {
>>> -     acpi_handle handle;
>>>        union acpi_object *info;
>>> -     struct amdgpu_atcs *atcs = &adev->atcs;
>>> +     struct amdgpu_atcs *atcs = adev->atcs;
>>>
>>> -     /* Get the device handle */
>>> -     handle = ACPI_HANDLE(&adev->pdev->dev);
>>> -     if (!handle)
>>> +     if (!atcs)
>>>                return -EINVAL;
>>> -
>>>        if (!atcs->functions.pcie_dev_rdy)
>>>                return -EINVAL;
>>>
>>> -     info = amdgpu_atcs_call(handle, ATCS_FUNCTION_PCIE_DEVICE_READY_NOTIFICATION, NULL);
>>> +     info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_PCIE_DEVICE_READY_NOTIFICATION, NULL);
>>>        if (!info)
>>>                return -EIO;
>>>
>>> @@ -658,21 +697,18 @@ int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev)
>>>    int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
>>>                                         u8 perf_req, bool advertise)
>>>    {
>>> -     acpi_handle handle;
>>>        union acpi_object *info;
>>> -     struct amdgpu_atcs *atcs = &adev->atcs;
>>> +     struct amdgpu_atcs *atcs = adev->atcs;
>>>        struct atcs_pref_req_input atcs_input;
>>>        struct atcs_pref_req_output atcs_output;
>>>        struct acpi_buffer params;
>>>        size_t size;
>>>        u32 retry = 3;
>>>
>>> -     if (amdgpu_acpi_pcie_notify_device_ready(adev))
>>> +     if (!atcs)
>>>                return -EINVAL;
>>>
>>> -     /* Get the device handle */
>>> -     handle = ACPI_HANDLE(&adev->pdev->dev);
>>> -     if (!handle)
>>> +     if (amdgpu_acpi_pcie_notify_device_ready(adev))
>>>                return -EINVAL;
>>>
>>>        if (!atcs->functions.pcie_perf_req)
>>> @@ -692,7 +728,7 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
>>>        params.pointer = &atcs_input;
>>>
>>>        while (retry--) {
>>> -             info = amdgpu_atcs_call(handle, ATCS_FUNCTION_PCIE_PERFORMANCE_REQUEST, &params);
>>> +             info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_PCIE_PERFORMANCE_REQUEST, &params);
>>>                if (!info)
>>>                        return -EIO;
>>>
>>> @@ -768,32 +804,26 @@ static int amdgpu_acpi_event(struct notifier_block *nb,
>>>     */
>>>    int amdgpu_acpi_init(struct amdgpu_device *adev)
>>>    {
>>> -     acpi_handle handle, atif_handle;
>>> +     acpi_handle handle, atif_handle, atcs_handle;
>>>        struct amdgpu_atif *atif;
>>> -     struct amdgpu_atcs *atcs = &adev->atcs;
>>> -     int ret;
>>> +     struct amdgpu_atcs *atcs;
>>> +     int ret = 0;
>>>
>>>        /* Get the device handle */
>>>        handle = ACPI_HANDLE(&adev->pdev->dev);
>>>
>>>        if (!adev->bios || !handle)
>>> -             return 0;
>>> -
>>> -     /* Call the ATCS method */
>>> -     ret = amdgpu_atcs_verify_interface(handle, atcs);
>>> -     if (ret) {
>>> -             DRM_DEBUG_DRIVER("Call to ATCS verify_interface failed: %d\n", ret);
>>> -     }
>>> +             return ret;
>>
>> Is this return ok? Is it possible not to have ACPI handle for the dGPU,
>> but has a valid handle for iGPU - like ATIF/ATCS functions that exist in
>> iGPU space?
> 
> We are just checking for an ACPI handle here.  Presumably if the
> device were part of the platform it would have an ACPI handle.  ATIF
> and ATCS are only relevant to devices which are part of the platform.
> E.g., they wouldn't apply to a card plugged into a PCIe slot or
> thunderbolt.
> 
> Alex
> 
>>
>> --
>> Thanks,
>> Lijo
>>
>>>        /* Probe for ATIF, and initialize it if found */
>>>        atif_handle = amdgpu_atif_probe_handle(handle);
>>>        if (!atif_handle)
>>> -             goto out;
>>> +             goto atcs;
>>>
>>>        atif = kzalloc(sizeof(*atif), GFP_KERNEL);
>>>        if (!atif) {
>>>                DRM_WARN("Not enough memory to initialize ATIF\n");
>>> -             goto out;
>>> +             goto atcs;
>>>        }
>>>        atif->handle = atif_handle;
>>>
>>> @@ -802,7 +832,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>>>        if (ret) {
>>>                DRM_DEBUG_DRIVER("Call to ATIF verify_interface failed: %d\n", ret);
>>>                kfree(atif);
>>> -             goto out;
>>> +             goto atcs;
>>>        }
>>>        adev->atif = atif;
>>>
>>> @@ -811,7 +841,8 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>>>                if (amdgpu_device_has_dc_support(adev)) {
>>>    #if defined(CONFIG_DRM_AMD_DC)
>>>                        struct amdgpu_display_manager *dm = &adev->dm;
>>> -                     atif->bd = dm->backlight_dev;
>>> +                     if (dm->backlight_dev)
>>> +                             atif->bd = dm->backlight_dev;
>>>    #endif
>>>                } else {
>>>                        struct drm_encoder *tmp;
>>> @@ -863,6 +894,28 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>>>                atif->backlight_caps.caps_valid = false;
>>>        }
>>>
>>> +atcs:
>>> +     /* Probe for ATCS, and initialize it if found */
>>> +     atcs_handle = amdgpu_atcs_probe_handle(handle);
>>> +     if (!atcs_handle)
>>> +             goto out;
>>> +
>>> +     atcs = kzalloc(sizeof(*atcs), GFP_KERNEL);
>>> +     if (!atcs) {
>>> +             DRM_WARN("Not enough memory to initialize ATCS\n");
>>> +             goto out;
>>> +     }
>>> +     atcs->handle = atcs_handle;
>>> +
>>> +     /* Call the ATCS method */
>>> +     ret = amdgpu_atcs_verify_interface(atcs);
>>> +     if (ret) {
>>> +             DRM_DEBUG_DRIVER("Call to ATCS verify_interface failed: %d\n", ret);
>>> +             kfree(atcs);
>>> +             goto out;
>>> +     }
>>> +     adev->atcs = atcs;
>>> +
>>>    out:
>>>        adev->acpi_nb.notifier_call = amdgpu_acpi_event;
>>>        register_acpi_notifier(&adev->acpi_nb);
>>> @@ -893,6 +946,7 @@ void amdgpu_acpi_fini(struct amdgpu_device *adev)
>>>    {
>>>        unregister_acpi_notifier(&adev->acpi_nb);
>>>        kfree(adev->atif);
>>> +     kfree(adev->atcs);
>>>    }
>>>
>>>    /**
>>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C53d11f255bdc4a85b89508d91c5ef6c0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637572016470028947%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Y1MV9LMAGE2dDA8c5iuRzeY3XJPAbNu%2Fka4Ot0vVD2M%3D&amp;reserved=0

-- 
Thanks,
Lijo
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
