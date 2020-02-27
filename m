Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD55C11D3D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 20:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3512468F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 20:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oxw0jWXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3512468F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4AD76E0D1;
	Thu, 27 Feb 2020 20:28:50 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760051.outbound.protection.outlook.com [40.107.76.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F8336E0D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 20:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0ur95AgzME8Mpdg4PaV5OeRmx3GAb8b9xgd8rWpJlwCXn+pLDOGiifLGTrCKCR7m9v5PVUHSAJYZoMErkvCgLOGRYZpXaGpzPso/v9v6eP/63GUl1cOhQHuH0ob8UXwExLbUlRTJrJgmOtlTyc6P/F5N6WegBGBWoMYf68Iec1RW0ZZ+aPWCZkCJEzRk6gT5qx1ytbKALAfUX13NNk9YCU/0x+fpnyTrPKugtriILonKO7c1HWgYQR2S7AmXqG3NWvZCepLd6z9OiRXe7YPRMQLtoGrmN4Uw6RUmGro3VX2FuIeC/17zBtnZ7rXTtcAgn1X2qzWfMtbBH5+VBdEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YaRfpkqD4t4OyMfVPDvPEbu371m452f92MOiM8/bGs=;
 b=cij6Q5YnusPebUYX78czI0Y9gg6ZZGekYmiTpA/ZW3fSG4dYmzzfkfyVnpt2G6puR1Ell/VbSdWe8ZK56BrPn2VwsS2m0ThUmWKfyDtFWe979tt6zqmeZuHIjJN2BQ6KEdJp9iBZKijNwr+o89tX0tWUZSTvlczAZZV4ceZI2LW9ZuTcRmO7ZKHNKPHy8RCqIzCFD8wJ+GshZAs9/e89E47aN2y/wzJkI0kaO9FIY/X0MNa3i8oVZkKDGaQ2CFkg/JTQehxB5eGuHhOrnqy4sxK/xbgxBoa+RWLHiyON/LAHR7voJZVDa3DkPHjbreawAY5GvF8oUcV0jbf7UT8b1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YaRfpkqD4t4OyMfVPDvPEbu371m452f92MOiM8/bGs=;
 b=oxw0jWXg3Hmi9nM6GtH5lrx8FBqtkTHJI4lCcR3ksgPwnEuxMSrpW8XImhehPvHZHEPPyQgf0qhrOZ1/KnuBY5//FnQVlalP/ChJonKIcgI99iDQ8uJncilAhZrkjBZQfNGN98soGH1ibWG/uEHGkE5juuLdkvCH8CIeatCtXGY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1547.namprd12.prod.outlook.com (2603:10b6:4:c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 20:28:48 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 20:28:48 +0000
From: Nirmoy <nirmodas@amd.com>
Subject: Re: [RFC PATCH 2/3] drm/amdgpu: change hw sched list on ctx priority
 override
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20200226203730.4621-1-nirmoy.das@amd.com>
 <20200226203730.4621-3-nirmoy.das@amd.com>
 <2c8957cf-f4b5-2b65-acb6-d366c2fbc656@amd.com>
 <CADnq5_PPqDGn2rP6ep6aEHgjow5mkKUp1=FLLo_mDn-QEsN1KA@mail.gmail.com>
Message-ID: <31b82a5a-4767-1a4b-b74c-61179a52b9e8@amd.com>
Date: Thu, 27 Feb 2020 21:31:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <CADnq5_PPqDGn2rP6ep6aEHgjow5mkKUp1=FLLo_mDn-QEsN1KA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0036.eurprd07.prod.outlook.com
 (2603:10a6:200:42::46) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2a:b800:8c:b0f3:cb6e:896b]
 (2003:c5:8f2a:b800:8c:b0f3:cb6e:896b) by
 AM4PR0701CA0036.eurprd07.prod.outlook.com (2603:10a6:200:42::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5 via Frontend
 Transport; Thu, 27 Feb 2020 20:28:47 +0000
X-Originating-IP: [2003:c5:8f2a:b800:8c:b0f3:cb6e:896b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b471aed7-9f43-4e1e-c4d5-08d7bbc3a698
X-MS-TrafficTypeDiagnostic: DM5PR12MB1547:|DM5PR12MB1547:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1547725FA6AEBBDC3B19895C8BEB0@DM5PR12MB1547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(6666004)(66946007)(8936002)(81166006)(8676002)(2906002)(81156014)(6636002)(4326008)(31686004)(5660300002)(316002)(478600001)(36756003)(53546011)(186003)(66556008)(110136005)(54906003)(52116002)(31696002)(6486002)(2616005)(16526019)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1547;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8u8OVSMVp4GJgySgJHj27q1fHmUUiKw+JUOuf8qKsfFqMqckCdw1SU572u8bOJPAdAbvy1NnU8KubhOQgigdT+yc2EEKCsfTrL+LdKvAc5WHx0Q3DYe7gu7CXnfNvp4tVgBnJGVJqfEk1LvAtO1HlseLxUxQDxYBL6hdSYMZGjFvpsORE/RIVGkkIb5Vfpa7RAyVDtilQFVizykKbWZwb14JSdTDwtipte6N/43KJRWNw4uhRA4+JZ1p41DNfRQyvozC4w3Ed247FYRqhM6hoc2pT/IhPMPfICLm7/dUWLOGulo1Ys8JglE2AE+0znz8d/AROgMPpmzstjMv9GDXrjRca0+TNlNC0NPXsoOPPCIcpS0ez7KY/qI5J5REVfHFXLnnZ7r0HTEmyFGwm7R6A5sdNNH6chFOsdO/Z6xRP8Tbl3pRfmykyMFtf0RygvR
X-MS-Exchange-AntiSpam-MessageData: q5yflWm77ReKeAQi61nUXhSY+SyV7uwpqVzl4PbhWyck8/6ekQIJM4g9EPb1Ypsjpddu1RwWT5vjokmZcAoPY79iwWLlyOlb3yv+L1CMFxqGvaxfiDLiYYrAytBkJcBomm00EVerTe06mjLVCjXx2Yc+UnY2lWwR2uekncOEL7J05tGlXOj6hELGe3TYSZEkmrXCeKrHX555Jt80fRxfxg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b471aed7-9f43-4e1e-c4d5-08d7bbc3a698
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 20:28:48.6529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7LBbXtOsv2VOM4G10MbqJwD4x6uII2SiqiGYEaNrTooigeox9rba+1CCySNZw0A5PNofL4gWpm3BJw+VgRylA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1547
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Huang Rui <Ray.Huang@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/27/20 3:35 PM, Alex Deucher wrote:
> We shouldn't be changing this at runtime.  We need to set up the queue
> priority at init time and then schedule to the appropriate quueue at
> runtime.  We set the pipe/queue priority in the mqd (memory queue
> descriptor).  When we init the rings we configure the mqds in memory
> and then tell the CP to configure the rings.  The CP then fetches the
> config from memory (the mqd) and pushes the configuration to the hqd
> (hardware queue descriptor).  Currrently we just statically set up the
> queues at driver init time, but the hw has the capability to schedule
> queues dynamically at runtime.  E.g., we could have a per process mqd
> for each queue and then tell the CP to schedule the mqd on the
> hardware at runtime.  For now, I think we should just set up some
> static pools of rings (e.g., normal and high priority or low, normal,
> and high priorities).  Note that you probably want to keep the high
> priority queues on a different pipe from the low/normal priority
> queues.  Depending on the asic there are 1 or 2 MECs (compute micro
> engines) and each MEC supports 4 pipes.  Each pipe can handle up to 8
> queues.

After some debugging I realized we have amdgpu_gfx_compute_queue_acquire()

which forces amdgpu to only use queue 0,1 of every pipe form MEC 0 even 
if we

have more than 1 MEC.


Does it make sense to have two high priority queue on the same pipe ?

Regards,

Nirmoy


> Alex
>
>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
