Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE20C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 20:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E4620768
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 20:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pdFbqMQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E4620768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F08066EC1B;
	Fri, 14 Aug 2020 20:20:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4837E6EC1B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 20:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNCbDaZ6gK6Vns1C+w5S6m6H6r/UNLKVmoGcRcFDDBJJCQRDjsKtIM5b4B+aG86leYQsdx8uirW5EM25dBMGlQTkzCigvkifUsMhN/zJDmAMriXxsUyXQH2Rf5smxcKJH1JsfEpZ8QdljzyMBuceiwtfWbtU8uwWxNaK1ZoUT1gYu3wNcp2cb4DrZV4R0pJ0n+7dPq8PdGMiBB72hh5bPwRSmwd/5BBJL2WepTEj5CHWx0cX4g8apD42CiQyi7k2Dfr5SrIbJO/cH+95N6rmwoXqbX+KB6umWjMZ4islSrbDlNNlwRn5VLjIbJ1I7Pt/Hrh785ee52y2GNUroLdr6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBva45qwdMxhn1ll83L9DOSKwVh1YJvovfWIPMCDIu4=;
 b=VtBApAmKLaRhi74C/hzTtx2WfaCmBTaZl63nktJup1qNuI9SYMz/zfBzlzpOdrUgqGtEm0+HkNvBzZt3zIvkfgWAfU7JQlKpO/nRbzXVP15HAJXNMou9QOYIqLmQVhQbaP1meM6hNv5hN3fIx3O9Kvtjm8i4nl6Wwu5fTCH8wpwitogP6wsUyKbQ9eIlRaM6UlFQ/Pg4KA4IEw3uaMXZRiV5agwGeYt+sageyealinUeUWU6vMeul5uPEWqsch7NryVt4ltKkstFFuRxOROiG8skqezrcXNsXbeFx3kM3ZN9G7ZbduILu2m2En2nXEBv+1Sul1xpqa+fdJqVDOniow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBva45qwdMxhn1ll83L9DOSKwVh1YJvovfWIPMCDIu4=;
 b=pdFbqMQl0HyO7LVDv9FoyQo4zHAqXImfIv3aHpiAZfoWXOFNZ3qHfc7LlAR+M0F8tnHXohmPlVnltdMiuJXF3h0RtG7B396zOatSPJIoS8Wl7znlIeUZZACe47ShTrfYjfNg5EQbB8aQFzKe8GSVO/OlfU/jVfuMWydTEZc+fQI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB2357.namprd12.prod.outlook.com (2603:10b6:4:b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Fri, 14 Aug
 2020 20:20:19 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 20:20:18 +0000
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: add initial support for pci error
 handler
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200811133053.71123-1-nirmoy.das@amd.com>
 <1795711a-9261-2cb4-642e-44bc25afc9ce@amd.com>
 <9770d7a3-0d4e-f609-4530-991154ef1a49@amd.com>
 <b6e878c0-bade-77a5-fda7-6be234c2f6b7@amd.com>
 <50cab62a-e8d4-0e0d-438b-b274c09d0972@amd.com>
 <1fb93957-e1c7-779c-953f-c575a0b6c74d@amd.com>
 <f63c9053-e473-2d5a-635a-39c8d8b905c1@amd.com>
 <cd54cb41-9dcb-29a4-2e72-088a89d44e6d@amd.com>
 <3d93f01c-6bd7-edfe-6e02-51687e446d18@amd.com>
 <CADnq5_NhPJ8+QsAfzHEha-1i_B0UcgwFA-X0P-NAskUhZzmZPg@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <87f76e32-eecb-ed6e-b117-e5402c944638@amd.com>
Date: Fri, 14 Aug 2020 16:20:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
In-Reply-To: <CADnq5_NhPJ8+QsAfzHEha-1i_B0UcgwFA-X0P-NAskUhZzmZPg@mail.gmail.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::14) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0075.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 20:20:18 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ae43a9cc-6ea0-4df3-ed05-08d8408f7683
X-MS-TrafficTypeDiagnostic: DM5PR12MB2357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2357C122D75FF55BA5C0427E99400@DM5PR12MB2357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UVvGFt0XrS2/2Pf2WkBKmQyuFZM0tlT39GuHrQWgiTY5PuPAcMbzjR6xcyav4y/xCukKGAu/IhkduV5pq57jyZC4jH4unuCL/vT1msyewsz9lyRqS7PS19a6yOtxQr7Jhpo/b36NVFsMsXIX/P8FV2bRgBz/f/sBKT9F+oMmBCkrWpejnXKAAeu1K1Nzb+KoacnFbMoKMnJJ242wIvVPIlj9tC0m1l0Fbpt4i3w81MTz//f/koow9Rz5/wqHizw+e504M3gDC2MVSl9hqiqBaIrUsfSWwJ7dXAhZ/18sQgY3JxcnX9HL+4e/YBfnP3AdVN/3VHgXJW+mevvwiymbJkPSCyLf/Oc1Kj34AujxOwVB9ZVSwTcYAdactT/n15zU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(6486002)(16526019)(478600001)(26005)(53546011)(6506007)(86362001)(186003)(52116002)(31686004)(36756003)(83380400001)(4326008)(66556008)(8676002)(66476007)(2616005)(956004)(31696002)(316002)(54906003)(6916009)(5660300002)(6512007)(8936002)(66946007)(2906002)(44832011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: I8a6/a17zMPryfzYMtf9vX5ThxZS414+0l0DrGQhauHye1RGWio3b0lvYpUYQvhCycnkwJuRpq1BjzGTvxYb+PAU39btzQvLzb8m4335mPjKSe/RZLwGvfD5JlXED8kfSQWu+o19t0QzAEVBTeEdOsGuZPXkHxdZPXnICaTDXBToGPXei9KKOK6C/NTpIGSqN3YF3EDLhj/eco3nRQjQ6SeoMIil/QU62yJMe9Ju2uNyCrZ7gEuTEZxxOMCiqGdF5PIOD2EK7UQT2dAQwleCxKsJpI21eOw1OOctTth9De7yeylgZn+ww2E9MwqyA7rwQX2QE5rtKfj+qVghlBHqHNMXoMNhRSFDTIWWcO8sP2qJbqAj1BHk/9NqwZHWdWienHALWxUk62aSpQgQxweiI3gTZlb/k/YKdFI6StVIOZllLnJG/yVvRjfc9bScMggWZ2xi0dD/qlNZiY1Q2/EI1IJDdrshYudq6lcaUOYBM4IJiP4FMoa3gZa/nOg5eLp/mExlxDcbPREevwDaYmniO8M5IKmgAiXYvEuvot1iI3t+o73QLJ1Dzbw+c1Vh1wCEEC8GNokpItH44IUP5lX6Oa6/fsSoP5SSPmShyOtWZoWg55rnoRyTFX+UmRzfDHhpYgWgOa3zCIesLLjly7Lh1A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae43a9cc-6ea0-4df3-ed05-08d8408f7683
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 20:20:18.8032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTP4+vjMvYDtY2/7NfaEEXIEAEGp8lNba/nf3ax/fKjZzLlPR8SVwXdmd8B6MxUy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2357
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Nirmoy <nirmodas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Nirmoy Das <nirmoy.das@amd.com>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-08-14 4:10 p.m., Alex Deucher wrote:
>> I see DRM as more of a unifying layer (perhaps long term), as opposed
>> to a *library* which LLDDs call into. Then LLDDs would provide an interface
>> to the hardware. This will help us avoid many of the deadlocks and
>> synchronization issues which were outlined in a recent memory presentation.
>> It will also help us avoid code redundancy in LLDDs.
> 
> We are actually trying to move away from that model.  drm started out
> as a midlayer and it caused all kinds of pain.  E.g., some drm devices
> are usb devices, some are pci, some are platform devices, etc.  A flow
> that worked for one didn't always work well for another.  In general
> we should follow the driver model for the specific device model of
> your driver and then use drm helper functions to deal with the core
> drm functionality.  E.g., drm shouldn't be in the business of dealing
> with pci power management.  The driver should interact directly with
> the pci subsystem for that.

Ah, thanks Alex for the clarification. So a library of sorts--got it.

Regards,
Luben
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
