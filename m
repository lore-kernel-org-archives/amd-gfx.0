Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B52C2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 19:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2331C20661
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 19:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JXaDpeEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2331C20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7ECD6E8D2;
	Thu, 30 Jan 2020 19:05:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 458FA6E8D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 19:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f26zQI6I3l5t+uLIgLEJn+LfUNHfkUA3q8i96rMP+Qg4Agc0BHN4wPhYp7n3TE1WJDpQ9shZUSA08rSFNyDSlvTgytenEFPdEfJBnoLYzmmCAGAKWljBLgljZBWx+FBJ4i1cV69HiVahl23OHZjadJ8VHF3DHBFwNyhM5ctcS3cbeJIMJrlQ+ecfiglSenp//p0kKuuPX9O0EfF/fTWqo2g+Q/G53d7f6yrCuF4tmGRUeSdzSySgHKvJEG5R0uggUUhbsIh/sXnDleHZfPKiRCn0MaLuULqFEZtRMpveuSDvsmGAs9vpzsp9/oRBiNGGbv8ddoKzdVDUBWshzouUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnU95ExwxsRyERJAwj1uP20rZjNEtqwrNTNPhG+751k=;
 b=R0EFA56R41/p7hgPx1AML0QINgE34gLUqhIpu/HATFO6bdojmBnJAcYZh47j5MjRF+LJAlEP5/0ripzHP3xU8PmyOHtpfy6KGkXu1Q8RF7g5lT9UFhA/95LhXscHIoZ7GIlUtgFNl925Rr+HsyBo0j5M00V3noNPRqukJxoo21bc0mK6jL0X0YEq/uUkkv4ZAhXqO/AhWXak0lFLjEd7zDjenhNeDPlXWacTdIrxoeNZ0TG/cAkmmGu3sVL46eezu0a9QLO7ctY9CB0eN5Yyi9qjd206a+j5ymyBEkYd14NDP3OiIm6lejnWmH0DNvQ9KnrbCCm2K5L5UcSv97fn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnU95ExwxsRyERJAwj1uP20rZjNEtqwrNTNPhG+751k=;
 b=JXaDpeEaLAZ/6ZPG4rmez8mABszxx+YgKRgZvElIRkuhP8He6wIsdAy7qHcALk3QW4tFdns+OT7lFarbk8z9b84IR6rfFQt5YFZGObzNcvE2GnH6tBN6D+W8/Jht4H5YHtm9EW6ASnkjFqX7kNURzXQAuQGRxyFsQu8t0p370dA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from SN1PR12MB2366.namprd12.prod.outlook.com (52.132.194.147) by
 SN1PR12MB2575.namprd12.prod.outlook.com (52.132.194.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Thu, 30 Jan 2020 19:05:23 +0000
Received: from SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80]) by SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80%7]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 19:05:23 +0000
Subject: Re: [Patch v1 3/5] drm/amdkfd: Introduce debugfs option to disable
 baco
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
 <20200128012923.25536-4-rajneesh.bhardwaj@amd.com>
 <CADnq5_N+cMAWFyi0GdUer0AkU2LNSjrnb7i9Z4O07CR5V04FaQ@mail.gmail.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
Message-ID: <01c4cef2-dd70-b556-18ce-de9fc16ffd7b@amd.com>
Date: Thu, 30 Jan 2020 14:05:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <CADnq5_N+cMAWFyi0GdUer0AkU2LNSjrnb7i9Z4O07CR5V04FaQ@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::16) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
MIME-Version: 1.0
Received: from [172.27.232.179] (165.204.55.251) by
 YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Thu, 30 Jan 2020 19:05:22 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e75a16b-2306-40c3-527b-08d7a5b75b93
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:|SN1PR12MB2575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2575A00687B772D29E6A14AFFE040@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(86362001)(31696002)(2616005)(956004)(5660300002)(4326008)(26005)(53546011)(6916009)(66556008)(81166006)(66946007)(31686004)(52116002)(66476007)(81156014)(8936002)(8676002)(16526019)(6486002)(36756003)(16576012)(186003)(54906003)(498600001)(45080400002)(966005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2575;
 H:SN1PR12MB2366.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nttjlbgap6ERPb05BCiz0pvLo6P4r1kSq/aSUA9lXgsVg0wc8ZqE2p6JS4Wnq35UWK7xQsBeSBTkvhRYVxcgxIm7RBLr5Ka5iRYRaGoxmukT8dDf5I8iaGG0LzW78rV9KQ289PZj3BkJ1CTc54xXvLS9m1xl5MpXGVNgGXbXj2MPJwDSB2ONLO6kH60FWMywJFYArkcRYTbiiC8PzvJMYFsyUteXL6e4+Rlod0dwbANNYrR2w56Ue1OyGHOv72k2PdcYmFHze5LgSFpW/8CbgviyHgwGciBUW8732IuV2a3YSw24XozfaZt8wYwq0v9cPiPKFGzNJVNEp5VqNzn16ndE62lAwgQC5uUactoL7lZgYcp+PGNu+6xdTDFg69SHMMYlcphlcwWYK10+7QGo4A6bFz+9F6Lg90vi207+pd0USI50otpNsW0OZ7wVLwoNJ82QbjHzNRJkWxtMugNIbiP+6qpE+pr8Eh79tk06+3xmHPs0ijwkY6ax1VBMKP4O
X-MS-Exchange-AntiSpam-MessageData: qD9bgVEg8hj9Gz7cZkc6pZ7KfH0fmVe90RgUwkRWtvjmihyNoo3r46Ap5EwvlYf203/zHA1mbqNwiIxn+WBR7DO+pHF58G4slb8viSMgbyhXbCGGZBKLTIiuzXZ0y7S83z1T6BnuH/8roGN687yURg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e75a16b-2306-40c3-527b-08d7a5b75b93
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 19:05:23.2832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMKaY9FXuTB5dhJa6ipzFqjfCwpVqDnSvlTtf6Ozrleo1G7iUiySTLA0jZ2NN7FHeOCFVnKt4G+7WHxYmxQ/OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex


Thanks for your time and feedback!


On 1/28/2020 3:22 PM, Alex Deucher wrote:
> [CAUTION: External Email]
>
> On Mon, Jan 27, 2020 at 8:30 PM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@amd.com> wrote:
>> When BACO is enabled by default, sometimes it can cause additional
>> trouble to debug KFD issues. This debugfs override allows to temporarily
>> disable BACO for debug purpose without having to reboot the machine.
>>
>> However, in some cases one suspend-resume cycle might be needed if
>> the device is already runtime suspended.
>>
>> e.g
>>
>> sudo rtcwake -m < mem or freeze > -s 15
>>
>> or
>>
>> by triggering autosuspend event from user space, by doing something
>> like:
>>
>> echo 6000 > /sys/bus/pci/devices/0000\:03\:00.0/power/autosuspend_delay_ms
>>
>>      Usage:
>>
>> echo 0 > /sys/kernel/debug/kfd/enable_baco and run
>> cat /sys/kernel/debug/kfd/baco_status to verify whether BACO is
>> enabled or disabled by kfd driver.
>>
>> It should be noted that while enabling baco again via kfd override, we
>> must do the following steps:
>>
>> 1. echo 0 > /sys/kernel/debug/kfd/enable_baco
>> 2. sudo rtcwake -m < mem > -s 15
>>
>> In this case, we need GPU to be fully reset which is done by BIOS. This
>> is not possible in case of S2idle i.e. freeze so we must use mem for
>> sleep.
>>
> I think we can drop this patch in favor of just using the standard
> runtime pm control.  E.g.,
> /sys/class/drm/card0/device/power/control


Sure, i was using the /sys/bus/pci way to do it and found it was not 
easy. Since this sysfs exists, will drop the patch.


Regards

Rajneesh


>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Crajneesh.bhardwaj%40amd.com%7Cfdaaf630ee6548c6bd9108d7a42fe314%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637158397891190611&amp;sdata=3jE9jZbbw9IiCu7geMeCCsTC4u4tTdippeWYeSnX3oE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
