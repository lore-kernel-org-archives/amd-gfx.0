Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE00C4727C
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 20:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29292208D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 20:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xlJyNuME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29292208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A9B389F33;
	Mon, 28 Sep 2020 20:57:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B50789F33
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 20:57:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JL7y25EQA6XorWlQyKCx8CXZMt2o10Y4Qmfk+dBBCjm1Jsj+OPdOGlZHnF0TYRo8/iZ3U8nvxfL36O6wPpNOOYN8tOpZcn7pZFwtg60RLfRZgYTE5l6qo3wdP2e2WhkMMRTkW31Ulpv5pOdVSNcZFh26ebgCyPup0ykpkRUfsrA2wlwHK0ZrpXOGbPzX7k6MQq7kYJeZ+dW/Pe6Eg4dtfeXQ2ructCi6NH1Umy60Xbf+oS1F5zTE5571XaYoOjzHd0LIOm0Hm8BKQZp1CMd0tXNhkZw1Nqzp18FXIZ0HuMuTNcglUJm2Ys4kxh+ViAxejs+0z7IeeB5rkfAqywvHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMSVaB44pxXvrzYiZ1GTjPBb1LX6lK9xxN2s16noPBE=;
 b=Zb4knY3aejqtPX5USPaxhrhzw7fEmCPSG+78/6ott7RyYkY62UvsDehr4aEh8qQDhFqj7XIJKe88oD1J3pXCKAc7kBiMwd83y2bKeiM4lruZ6jvtPoN8k2vcddI5/oqAUJiC42DiF0NJNvV95Zwp+hYRgKNNXxkAacCZDGV0XWWkYPtc+3ys/IZVjLdgymOygwVCx8tJcojioo/+COIY4B4b7O1Q0WhTnHgjinL6QFwSoFR05hieSn3boocCx9H8AKsa3TmRpIwk6rZjILhrlyaYfLhEKlWUtuXIr7i7+D2AA70iLf+5s9f4w1zu/yYT46urNT0zg5CyCJICx50LAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMSVaB44pxXvrzYiZ1GTjPBb1LX6lK9xxN2s16noPBE=;
 b=xlJyNuMEdbCQnt++GKCJzZj9H63Z7zWxGDbrNUxmjL+c0e7mz3+N/qcpXWc0nJxXZH4qftSgqHqnUnpM32GczELIQK+Svb1LhBcwy4KZTZfoqN9Azxs00xdULaCetOlIHIP3UDzVgclmITJs+77vorSZ3A0MIQaVXoJg+4N+/K4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Mon, 28 Sep
 2020 20:57:06 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 20:57:06 +0000
Subject: Re: [PATCH 09/45] drm/amdgpu: use gpu virtual address for interrupt
 packet write space for vangogh
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
 <20200925201029.1738724-9-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <3623dc99-c36d-d585-d5c7-6ddfe45005f0@amd.com>
Date: Mon, 28 Sep 2020 16:57:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200925201029.1738724-9-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::27) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Mon, 28 Sep 2020 20:57:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2870b42-1677-4651-e7f3-08d863f10ebd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4862:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB486230830A58810A516E02A299350@DM6PR12MB4862.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J6chM99wy4U404vBqN0DinsbXdVbaVX42mk7hzIEh0rayDNenU9pDuhvW6QT/PkRW2v5Jezzew6HlVUZS1GHmsHiIaHswMic+SLixNtQp7LqMOVc2wS9+Xi1WOdlFEQRAkKQzWDGsO8QHqjYw24CB/I59iS8JNUo08tQJdtlLxxBcmWnQX/xPvA1wDTeoRXcMRQtn7XTnw5VKzt1hj55QC7iGhRtRugJvHIYPrK50cHTFmHBFCSHrsK1yc4Pj0F60ugpwwpyP+NdtBaD02UJrS6bhEOrg9OEfm0KCr/ClkSFDG7Pqf1QruebXE8kuNSLIvP5eeQj8L+NtDLfn3VGjUP7QbM7gV8TdC8V1Q8G4reup1pC9P0odY65n14T+ix7Oxu4x0tpVfd/DQ7Qv7b6e1EfF7gZNhE4I/GJWUKXKqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(83380400001)(44832011)(66556008)(66476007)(86362001)(36756003)(6486002)(5660300002)(8936002)(52116002)(4326008)(6512007)(316002)(53546011)(6506007)(16526019)(478600001)(31696002)(186003)(8676002)(54906003)(31686004)(2616005)(956004)(66946007)(2906002)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TXTTugrx42Qhuxw0npp0qw6dOuU4BbFJewkdMePYy/nWJ1S5EcvTRlpTS5GHDAn87NbwB8PZ6LNR0dwelDxdE8/2CRd2pt/2KAw01IE6NFk13mA+ov2tJhj04IQ1eWaHomy/y5sirRRnsXGeCbwVjbEujtF4U09zqJFQGCvVhuHwUfKoLLEHkLAnbVumbwISC+RmrPeK72q09ZD2U1q5YNXlIqY3R3BzrM6nw4OAFqTkzv3wvXZaLffGyQkwQC4pTDDoDwxUshVgY7zpSn6Doo0xhtetPqMatWi25e7elXvOHne4o8ll66R+igQbS3tBYVERwpmrPHBH3hlG3euNZmi9E1pMCr7Wl0aZWLsN6Fht/P+yFWaDTa4EKLh3plUSB3le8PoQt3HFmiIXvUMlvqK1Qjt6Yvw73VIs5NOnCXckX56TD3nJ8sb17fWu63nvZI/iaVgP2nljZ5OzhTk+y1q5JUbrkCcpOZWIGW+rFnWwdHPPwxqzdl9aICGXLJz4tHeEu10jWHVggbxCbITx6ijdKpyCPqMCGiFsh3rM+Z251QY36JHde4XunsqRWmVA9WijBLtVzMGXj/anpSKnpchnHuRCbF8n+KovOX4aNy9qf5jf9DPJ4pp7dmXEOwYjkt4znXglrgK5jGEZUfq/eg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2870b42-1677-4651-e7f3-08d863f10ebd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 20:57:06.1788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRKRiLWhFuo2FAQoa3wuVH4zDXps6Nz6rqNDWJYqFOHGbb1nKgVx6hsCcJmlQkGr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-09-25 4:09 p.m., Alex Deucher wrote:
> From: Huang Rui <ray.huang@amd.com>
> 
> The interrupts are not stable while uses guest physical address (GPA)
> for interrupt packet write space even on direct loading case.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index ce4a974ab777..b66414998c90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -661,7 +661,10 @@ static int navi10_ih_sw_init(void *handle)
>  	/* use gpu virtual address for ih ring
>  	 * until ih_checken is programmed to allow
>  	 * use bus address for ih ring by psp bl */
> -	use_bus_addr =
> +	if (adev->flags & AMD_IS_APU)
> +		use_bus_addr = false;
> +	else
> +		use_bus_addr =
>  		(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) ? false : true;

Previously to this patch, as a one-liner, it made sense to use a ternary expression,
but adding the if-conditional, perhaps a more readable way would be:

if (adev->flags & AMD_IS_APU ||
    adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
	use_bus_addr = false;
else
	use_bus_addr = true;

Regards,
Luben

>  	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
>  	if (r)
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
