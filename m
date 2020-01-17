Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCEBC33CB1
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 10:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09EF2072B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 10:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xXcvbpT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09EF2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D02B6F4F7;
	Fri, 17 Jan 2020 10:57:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770075.outbound.protection.outlook.com [40.107.77.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 681FE6F4F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 10:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOSNenQLMO/f6KLRB0P/A5AEJTEuEIf00bSqVw8LcZ1qa1VkfXQjZAYNpqG5iZbVLH1y2I/4C+30xofbzZXrtyk/XXJMiU2jhWWCsnEOX+5Q6mMFkEguSAtVWG383fBesZ2SUOWKdbXB+ZwOckMgKrqsfcTDQpgwHocTnVRT0FJnzxYw95Xrc1uDYaIIivoEQWE0xaI3g9cTe0VA4HuoWXKW5ZuOJz1kOWGg4FV5cijMhH0KL/1sYb1W6M5HWD+nNhsoMmHJnZULLA7t6lwWKSkvX74BnXdqBSFofVzXZq22WQMn3LthB51QSG5By+a47Qe+MaVr8qwz5gqxCraJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNIT4w3COAvLa905EpLTHzletQqBCRGL6AaPxSx8kZk=;
 b=BmAEcvSRWuVgjpNB2xYfHYGmuRYsXTYCC0cmqANgZtQs1xovp0fp9h2ZZ+YqLBa3GxiwXF/U6FBqvQp27kW+Y1MdiaiGoaKnsTLNzVg6F9Myt0P9TwN24BJ+qDB9x4C/3CFtdHvkJ5UpcECRXXBcCPoc44wUDxxQHOdLyXTEke+F+JkrQ16/6M2Q/EUsf54qRsIxt+7fnKDlOUpBUzGb+6rbimdtArbXpwGJrZsbqYbcpwGgKzSVQv7j0R53bKpeHH4mVF+N9Dvu/dI9Wn0U82WNz0K1GecxiwGdepH7Gjr70Ad5GGiK+1NJA9oxmfPPofZ7XBbIOpoUE3HathVOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNIT4w3COAvLa905EpLTHzletQqBCRGL6AaPxSx8kZk=;
 b=xXcvbpT31VrGNnuYLF7kZ/YIfCR9Hcfl/PWR+6GzaGvFB77ttvXX6IptWgHBtovcGRsEbq72qRyYdycnlOoRk1x2QFpU3Kovem80P6U5CuPdgFvjYIZa6j55LN68gtCkUZfOh8K2FLgv5DIBbSCfAra43/Lbah2WnaFk/wXd9B4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1404.namprd12.prod.outlook.com (10.168.238.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Fri, 17 Jan 2020 10:57:52 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 10:57:52 +0000
Subject: Re: [PATCH] drm/scheduler: fix documentation by replacing rq_list
 with sched_list
To: Luben Tuikov <luben.tuikov@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>, 
 amd-gfx@lists.freedesktop.org
References: <20200116144320.109044-1-nirmoy.das@amd.com>
 <cec773a9-8040-ee55-c73b-f7165a117696@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <8080c3c5-0d8d-5f85-011a-1edf4074eda9@amd.com>
Date: Fri, 17 Jan 2020 11:59:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <cec773a9-8040-ee55-c73b-f7165a117696@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0030.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::17) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f4c:0:455e:2136:71a8:37f1]
 (2003:c5:8f4c:0:455e:2136:71a8:37f1) by
 ZR0P278CA0030.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Fri, 17 Jan 2020 10:57:50 +0000
X-Originating-IP: [2003:c5:8f4c:0:455e:2136:71a8:37f1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2987f93-681e-4672-5a38-08d79b3c1947
X-MS-TrafficTypeDiagnostic: DM5PR12MB1404:|DM5PR12MB1404:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1404FA9A3AA607CB71AFFEB78B310@DM5PR12MB1404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0285201563
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(199004)(189003)(4744005)(53546011)(110136005)(2906002)(31696002)(52116002)(6666004)(6486002)(316002)(478600001)(66556008)(31686004)(36756003)(4326008)(5660300002)(66946007)(81166006)(8676002)(186003)(81156014)(8936002)(16526019)(2616005)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1404;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXg2Y+W3a/Yxu0MpqKoUzrJnokoqtTS2GQ/YmPbEDCHiHat1vG0lnMfEyD+BAEpCOoW2MVI/bXiH/2Q6ELnooSJxFy1q325Z2bUmGu1Q4FDz/nUclsF8gddYphykwdCA5dtKbQKF4cwvBEvhwEteX01C968/DIGnLOatvSO/J5ARWd1VlrUj1doK6ZR376AlvO8iYSqqYwvj+rGB7RLiT5xHnL/mrEUuFrCBFFdo25SyCCibwbVGHigbw14ACAlJGALrUY7iw87lcIJHNTZLIlQc7HcfpQpN90BgFBWUzXIKYkBXsqTe5j+JsTK+D4mUUJOEvIuwDhCZaK00arxsrsN907aYAeJEdExKKnUh4c2zOzG0JFoqI898MyCyXqAxomrAXpRuP5vt/lm/4MJruuyOBGMf6tsi4XD2QVXyXk5KkIemSobnuWDL5siJA9R/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2987f93-681e-4672-5a38-08d79b3c1947
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 10:57:52.3662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwDYnQiJHCQ9GhkofukHwNcxniKeltb5pc0aIV7Yk7rq7e63Ikh1Z4oJyWogK8IYkAyv30yvdlS8LQunv4dI0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1404
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Luben,

On 1/16/20 6:13 PM, Luben Tuikov wrote:
>> - * Note: the rq_list should have atleast one element to schedule
>> + * Note: the sched_list should have atleast one element to schedule
> "atleast" --> "at least".
Always a tricky one to catch, Thanks!
I will create a patch and ask Alex to squash with this one.
>
>> - * @num_rq_list: number of run queues in the rq_list
>> + * @sched_list: a list of drm_gpu_schedulers on which jobs from this entity can
>> + *              be scheduled
> I had to read this a few times to understand it. I wonder if splitting
> it into two sentences would make it clearer:
>
> "A list of schedulers (drm_gpu_schedulers). Jobs from this entity,
>   can be scheduled on any scheduler on this list."

I don't know, both feels right to me. Please create a patch if you think 
this splitting makes it more clearer.

Regards,

Nirmoy

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
