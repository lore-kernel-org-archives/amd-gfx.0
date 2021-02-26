Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A52C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 16:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C688B64F0E
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 16:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C688B64F0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7214B6E432;
	Fri, 26 Feb 2021 16:49:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C2A6E432
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 16:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WapMNUf8JtLtGf9s6/yq8TRo5US+MzX7+UZWgw4novZJ3lzc0apr+wzVmnSZk3HBToMTvS6SX20CwEtj5mStabErFUJc6a8RW3gYIlLRxbPDmb0VmIBSyuBgkNvh9b+xuIk+4qKwKOTJAXjC9VDOaeen2E96EXd9J8ZDezXLkbfsXq6mwerAj/7YtqpsIjOZHWuO6UyuFz38qzScbrH6lPWCI7/DRtrn19b0TNK4YlnuY3HDnmrkyEKy8wpJ0ZedMOH8OXeOlaZyK/bFRoxU++GTK89LUkGX7YGYi6rF8umkERb1Bhw1YSrd2e4uMy+KjIH+5YcmeJUJcE6BtaDVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92f7nzL1ophgJmyUUtVtD91ymxxjOhL1ICqVuqJ8zFI=;
 b=hVKJmOco9affzIhRqkWOQa2XlpHyTcuFVe8v3Qpm508kvUgYvkazkhPbmqaLiZ8kP7yL5qQlZXpSwQrZsn0n4rPx8OWiCqkeWacZg8hfX0062Rkz5wyzIkVCDTdkeDVQ2CTvZmfdXWSi5JMUJCT23LrqgjiA/M6yayl4w9nJKO44FqSAYNAwCEuMItWgmrgy1zpF0k4pKTbeH019Q7WsLsY1m21DywUu6UQbsFmL5x8CpjfSLwYqake9UDOvOia0mhkjptunYmamK1Rf6P/fxudJd+icqB2cBYpo0Mmg9dOXpNRWNa10zXg2QfbJvnT2Qv/N2z58qA6ODkvf1Te2WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92f7nzL1ophgJmyUUtVtD91ymxxjOhL1ICqVuqJ8zFI=;
 b=N3Nnm0Q95znjhGOZs5VwAgJiBRa1noYiP+r4vnbkj5ayHyNfgFEIvI2+84EUVPT7BnpnsVcS/m/B+FfnWxUprL74Ql8DYMqL/uySXAEmDxsBK/4fW2+5hTilmkpo7HrDxinTp1qS6Ddk3exDUffa2l4MKeffQc1kxs/2Wb8UMYg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2703.namprd12.prod.outlook.com (2603:10b6:805:75::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 16:49:35 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 16:49:35 +0000
Subject: Re: [RFC] a new approach to detect which ring is the real black sheep
 upon TDR reported
To: "Liu, Monk" <Monk.Liu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <DM5PR12MB1708D28565B445EABA872A3B849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
 <f65d8f80-a283-933a-82bb-97b415689460@amd.com>
 <DM5PR12MB17086F07E3EAC0C9CA03B94D849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <eb07f03b-0ea4-f9a1-47bf-4e8b65ac7081@amd.com>
Date: Fri, 26 Feb 2021 11:49:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM5PR12MB17086F07E3EAC0C9CA03B94D849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:25f7:b1a0:d070:450]
X-ClientProxiedBy: YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::41) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:25f7:b1a0:d070:450]
 (2607:fea8:3edf:49b0:25f7:b1a0:d070:450) by
 YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31 via Frontend
 Transport; Fri, 26 Feb 2021 16:49:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6108ad04-3ee8-4ea3-60b8-08d8da767f77
X-MS-TrafficTypeDiagnostic: SN6PR12MB2703:
X-MS-Exchange-MinimumUrlDomainAge: lists.freedesktop.org#0
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27031ACA2EB50E157C963189EA9D9@SN6PR12MB2703.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8gveL3MQS+ck0Q354wNyhNwwr19pB102bpt73KGdv/23AvyNGy8hs/2IupbmIt0XBzjhjL0JI39iidHVgVPN9sBwvOm7URh8lArAyCrREEI7lNMiXNAzmc4Tl4/KJ/AQhpuNubF5mnRwRK7w5JvxBS4J+JrjgAakgaQWinQ76QhUXNUJAnuDMlcm+Bmj1Q5GB8Jdf97ECLucYlHvWoTCbk/wuHZFVZYvyOzhJsISkxVQt/JNxS2QXK0ZpaJKZhjwZyFP6qyUh5J20LrG7B9KWghTD0QxvzFyXx6elfsCYdUyz61VoJRiUXCZKRWXsnDufgUyFBx6SmQsUsMidBI6tVKQc6FTZ+lSuhn/6Ptd74rGWryd2ddj8uxaNa5YYWrKfw/rtfx8o1iHTP9TLDf3N6hxg6l20ulbihmw+kPK+TRHlBy0gGqvOJi6cYNCpuDTxLhQ0x/Q4pFhZdXBzmkHyQKCPQuhhurAfcv37WvWQp0YLcR2PK2qAfdGYvYo1fsKMWqblNCS7ZpIpmK4ZFIOuuUIZi7f+UaDc/v4mtO2Fnd7QvMvwnnhYhjdBjyz/uOtBJcCWSxLSfVpt/QTog7LEKne9VjkVLBS+UHEb9ymJg2BZB6lOe4ZQpYJUYb/sCjUjJkW2Daq0kAZvh6f8JUxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(54906003)(31686004)(966005)(166002)(8936002)(478600001)(83380400001)(86362001)(53546011)(30864003)(316002)(66556008)(110136005)(66476007)(6486002)(31696002)(4326008)(66946007)(8676002)(44832011)(2616005)(186003)(16526019)(52116002)(2906002)(36756003)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?komVUO7QppLxiRNw8axMu2xz1pLGBX2Iz4kdCJeaUmwFbs0RSu7tRhY5?=
 =?Windows-1252?Q?nAg2/MoqyfTxzdQ1+7SfM3WyTy6k587rKx4hQyZgHJLJzn5m5ll4t5qY?=
 =?Windows-1252?Q?SzbiUp+OpmZpoUinvRBc74K3FPxv1MTi7tnahx9kwzMq7Tba7x9/ybpA?=
 =?Windows-1252?Q?vhfvTNL/SVhvUenAhkM3jdGnmWOnK5K8qzjdQjGqGftA+OnghFg/XTOE?=
 =?Windows-1252?Q?g7C7Qi9hXSRprXGv7QmzGBzi384a5cNBt96nYob1Jua6T5csvMfLr+Bi?=
 =?Windows-1252?Q?Cayef3M4VZwQUfcr4o5WP/EPM49HKFHGoJ0Gbb+dxQoQyl33VDnylPCE?=
 =?Windows-1252?Q?PdVOIUC7fYecjuUl9MNrXAKJJjf3SxMCcGDccBhlIddZ4fgCtvCnA5kf?=
 =?Windows-1252?Q?m2KjKD8i6r+BcUilzAA0g6VWm4r8Bf/ADWh8yN/jrnhwJYNwdZmHbFVT?=
 =?Windows-1252?Q?LJckkcltOoWkgGr7/WjZvzL/Nbs0dHUxo9ntoA+ZKo/8c43whyKou0Yl?=
 =?Windows-1252?Q?IHpDdFEcHdg4V6sLvI25H8W4bs04RY52R4xzNCoGrNxgfTI73H1v5Qrm?=
 =?Windows-1252?Q?fWsRp1GHHhAcDRPb93HcW0itBF5B1gGEm0a8nZnp+9izZgZh7lNJOy6m?=
 =?Windows-1252?Q?ZheV2rcy5nEzGIgvjDI5U6dOS/tH4HUkWn7L6PHWoZRNq00GXwZuFZd0?=
 =?Windows-1252?Q?g6CHJ4cJd70CX9PtirqFYOHxyMmiFaUMZf4LTss2rhFzbVjapP101g/G?=
 =?Windows-1252?Q?f/yDYw2jeINKaavycG8hhQW90odT38Vg34jesLsHqwk0B+zI2qSqa84X?=
 =?Windows-1252?Q?u7c7Tgt0+xysJna9hf5xiPM5RnTo1Jx+O1Oa29gXy8YdPpC8V0ePp2eB?=
 =?Windows-1252?Q?fEg+gwFEdXlCgeV+UkrETBYaciF7Xp3FIxk0RvUQR83WfJlP5HuTQ61I?=
 =?Windows-1252?Q?kM0SMQAzXxF5gVdm5xjE8IIfzhahqr3ITmGAE0age7wgjI+cIuAEmZkX?=
 =?Windows-1252?Q?Do+bu1e7rAdqwMy1sysWq6HW+wdUi8fL+LNcOwyz49sJRtetvHCqNxlB?=
 =?Windows-1252?Q?RmEyNcstKigw6S7EJkcezhA0tbLwx0m9oCa/oXkSfMjAJ6Azvp9mfEUW?=
 =?Windows-1252?Q?QNqyIOF2msY1VvwzzQiGcZZnh7z1C6aXSlFGB4w4H27GvRBavb6KG3FN?=
 =?Windows-1252?Q?1jSefq6joEDVHz+rggiD69QQxemj4vA3PnfgoMLjC4f9C6A9Bw144Vxn?=
 =?Windows-1252?Q?7Xc6COFLPIAR2Ruyclv6cc5fFqTiZ9Fc44jBDxjf2DMRrp2dg6/WrdMy?=
 =?Windows-1252?Q?gDi+KrLhtitoMVXGcxHX9X0t7QJrXMt/zbXwLjQN4HTjpw5HeEAn+g57?=
 =?Windows-1252?Q?V+bSFcKetW+Vuw/fG9plridWpU0BacCH96Inwyb44xsZ/Ns0VOoADkOK?=
 =?Windows-1252?Q?wWX6PWfrfegnrSle99cUXn6UM2am0wRmJHQIRxXJZbtVVn9MqhcIoiFd?=
 =?Windows-1252?Q?qqFllJyo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6108ad04-3ee8-4ea3-60b8-08d8da767f77
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 16:49:35.5799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LoWSoGXBzuFv7b8PrhPVEKbCGrcgPhe5K2E8KlqPLRqb1qqQiJT4rgeT2XkgsCtc8KdSYEcUzdEUxUaRxkvRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2703
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
Cc: "Zhang, Andy" <Andy.Zhang@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: multipart/mixed; boundary="===============1729830580=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1729830580==
Content-Type: multipart/alternative;
 boundary="------------C68276C20631E7FA9E0200AB"
Content-Language: en-US

--------------C68276C20631E7FA9E0200AB
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit


On 2021-02-26 6:54 a.m., Liu, Monk wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> See in line
>
> Thanks
>
> ------------------------------------------
>
> Monk Liu | Cloud-GPU Core team
>
> ------------------------------------------
>
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Friday, February 26, 2021 3:58 PM
> *To:* Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> *Cc:* Zhang, Andy <Andy.Zhang@amd.com>; Chen, Horace 
> <Horace.Chen@amd.com>; Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
> *Subject:* Re: [RFC] a new approach to detect which ring is the real 
> black sheep upon TDR reported
>
> Hi Monk,
>
> in general an interesting idea, but I see two major problems with that:
>
> 1. It would make the reset take much longer.
>
> 2. Things get often stuck because of timing issues, so a guilty job 
> might pass perfectly when run a second time.
>
> [ML] but the innocent ring already reported a TDR, and the drm sched 
> logic already deleted this “sched_job” in its mirror list, thus you 
> don’t have chance to re-submit it again after reset, that’s the major 
> problem here.
>

Just to confirm I understand correctly, Monk reports a scenario where 
the second TDR that was reported by the innocent job is bailing out 
BEFORE having a chance to run  drm_sched_stop for that scheduler which 
should have reinserted the job back into mirror list (because the first 
TDR run is still in progress and hence amdgpu_device_lock_adev fails for 
the second TDR) and so the innocent job which was extracted from mirror 
list in drm_sched_job_timedout is now lost.
If so and as a possible quick fix until we overhaul the entire design as 
suggested in this thread - maybe we can modify 
drm_sched_backend_ops.timedout_job callback to report back premature 
termination BEFORE drm_sched_stop had a chance to run and then reinsert 
back the job into mirror list from within drm_sched_job_timedout? There 
is no problem of racing against concurrent drm_sched_get_cleanup_job 
once we reinsert there as we don't reference the job pointer anymore 
after this point and so if it's already signaled and freed right away - 
it's ok.

Andrey


>
> Apart from that the whole ring mirror list turned out to be a really 
> bad idea. E.g. we still struggle with object life time because the 
> concept doesn't fit into the object model of the GPU scheduler under 
> Linux.
>
> We should probably work on this separately and straighten up the job 
> destruction once more and keep the recovery information in the fence 
> instead.
>
> [ML] we claim to our customer that no innocent process will be dropped 
> or cancelled, and our current logic works for the most time, but only 
> when there are different process running on gfx/computes rings then we 
> would run into the tricky situation I stated here, and the proposal is 
> the only way I can figure out so far, do you have a better solution or 
> idea we review it as another candidate RFC ? Be note that we raised 
> this proposal is because we do hit our trouble and we do need to 
> resolve it …. So even a not perfect solution is still better than just 
> cancel the innocent job (and their context/process)
>
> Thanks !
>
>
> Regards,
> Christian.
>
> Am 26.02.21 um 06:58 schrieb Liu, Monk:
>
>     [AMD Public Use]
>
>     Hi all
>
>     NAVI2X  project hit a really hard to solve issue now, and it is
>     turned out to be a general headache of our TDR mechanism , check
>     below scenario:
>
>      1. There is a job1 running on compute1 ring at timestamp
>      2. There is a job2 running on gfx ring at timestamp
>      3. Job1 is the guilty one, and job1/job2 were scheduled to their
>         rings at almost the same timestamp
>      4. After 2 seconds we receive two TDR reporting from both GFX
>         ring and compute ring
>      5. *Current scheme is that in drm scheduler all the head jobs of
>         those two rings are considered “bad job” and taken away from
>         the mirror list *
>      6. The result is both the real guilty job (job1) and the innocent
>         job (job2) were all deleted from mirror list, and their
>         corresponding contexts were also treated as guilty*(so the
>         innocent process remains running is not secured)*
>
>     **
>
>     But by our wish the ideal case is TDR mechanism can detect which
>     ring is the guilty ring and the innocent ring can resubmits all
>     its pending jobs:
>
>      1. Job1 to be deleted from compute1 ring’s mirror list
>      2. Job2 is kept and resubmitted later and its belonging
>         process/context are even not aware of this TDR at all
>
>     Here I have a proposal tend to achieve above goal and it rough
>     procedure is :
>
>      1. Once any ring reports a TDR, the head job is **not** treated
>         as “bad job”, and it is **not** deleted from the mirror list
>         in drm sched functions
>      2. In vendor’s function (our amdgpu driver here):
>
>           * reset GPU
>           * repeat below actions on each RINGS * one by one *:
>
>     1.take the head job and submit it on this ring
>
>     2.see if it completes, if not then this job is the real “bad job”
>
>     3. take it away from mirror list if this head job is “bad job”
>
>           * After above iteration on all RINGS, we already clears all
>             the bad job(s)
>
>      3. Resubmit all jobs from each mirror list to their corresponding
>         rings (this is the existed logic)
>
>     The idea of this is to use “serial” way to re-run and re-check
>     each head job of each RING, in order to take out the real black
>     sheep and its guilty context.
>
>     P.S.: we can use this approaches only on GFX/KCQ ring reports TDR
>     , since those rings are intermutually affected to each other. For
>     SDMA ring timeout it definitely proves the head job on SDMA ring
>     is really guilty.
>
>     Thanks
>
>     ------------------------------------------
>
>     Monk Liu | Cloud-GPU Core team
>
>     ------------------------------------------
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--------------C68276C20631E7FA9E0200AB
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-1252">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-02-26 6:54 a.m., Liu, Monk
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM5PR12MB17086F07E3EAC0C9CA03B94D849D9@DM5PR12MB1708.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera92f4c5c, li.msipheadera92f4c5c, div.msipheadera92f4c5c
	{mso-style-name:msipheadera92f4c5c;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:503861270;
	mso-list-type:hybrid;
	mso-list-template-ids:1492292582 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1279491622;
	mso-list-type:hybrid;
	mso-list-template-ids:-1736673670 67698703 67698689 67698703 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level3
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:1655448059;
	mso-list-type:hybrid;
	mso-list-template-ids:-1584207202 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l2:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="msipheadera92f4c5c" style="margin:0in"><span style="font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
            Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">See in line<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <p class="MsoNormal">Thanks <o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">------------------------------------------<o:p></o:p></p>
          <p class="MsoNormal">Monk Liu | Cloud-GPU Core team<o:p></o:p></p>
          <p class="MsoNormal">------------------------------------------<o:p></o:p></p>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Koenig, Christian
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a> <br>
              <b>Sent:</b> Friday, February 26, 2021 3:58 PM<br>
              <b>To:</b> Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
              <b>Cc:</b> Zhang, Andy <a class="moz-txt-link-rfc2396E" href="mailto:Andy.Zhang@amd.com">&lt;Andy.Zhang@amd.com&gt;</a>; Chen,
              Horace <a class="moz-txt-link-rfc2396E" href="mailto:Horace.Chen@amd.com">&lt;Horace.Chen@amd.com&gt;</a>; Zhang, Jack (Jian)
              <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Zhang1@amd.com">&lt;Jack.Zhang1@amd.com&gt;</a><br>
              <b>Subject:</b> Re: [RFC] a new approach to detect which
              ring is the real black sheep upon TDR reported<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal" style="margin-bottom:12.0pt">Hi Monk,<br>
          <br>
          in general an interesting idea, but I see two major problems
          with that:<br>
          <br>
          1. It would make the reset take much longer.<br>
          <br>
          2. Things get often stuck because of timing issues, so a
          guilty job might pass perfectly when run a second time.<o:p></o:p></p>
        <p class="MsoNormal" style="margin-bottom:12.0pt">[ML] but the
          innocent ring already reported a TDR, and the drm sched logic
          already deleted this “sched_job” in its mirror list, thus you
          don’t have chance to re-submit it again after reset, that’s
          the major problem here.<br>
        </p>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Just to confirm I understand correctly, Monk reports a scenario
      where the second TDR that was reported by the innocent job is
      bailing out BEFORE having a chance to run&nbsp; drm_sched_stop for that
      scheduler which should have reinserted the job back into mirror
      list (because the first TDR run is still in progress and hence
      amdgpu_device_lock_adev fails for the second TDR) and so the
      innocent job which was extracted from mirror list in
      drm_sched_job_timedout is now lost.<br>
      If so and as a possible quick fix until we overhaul the entire
      design as suggested in this thread - maybe we can modify
      drm_sched_backend_ops.timedout_job callback to report back
      premature termination BEFORE drm_sched_stop had a chance to run
      and then reinsert back the job into mirror list from within&nbsp;
      drm_sched_job_timedout? There is no problem of racing against
      concurrent drm_sched_get_cleanup_job once we reinsert there as we
      don't reference the job pointer anymore after this point and so if
      it's already signaled and freed right away - it's ok. <br>
    </p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:DM5PR12MB17086F07E3EAC0C9CA03B94D849D9@DM5PR12MB1708.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal" style="margin-bottom:12.0pt">
          <br>
          Apart from that the whole ring mirror list turned out to be a
          really bad idea. E.g. we still struggle with object life time
          because the concept doesn't fit into the object model of the
          GPU scheduler under Linux.<br>
          <br>
          We should probably work on this separately and straighten up
          the job destruction once more and keep the recovery
          information in the fence instead.<o:p></o:p></p>
        <p class="MsoNormal" style="margin-bottom:12.0pt">[ML] we claim
          to our customer that no innocent process will be dropped or
          cancelled, and our current logic works for the most time, but
          only when there are different process running on gfx/computes
          rings then we would run into the tricky situation I stated
          here, and the proposal is the only way I can figure out so
          far, do you have a better solution or idea we review it as
          another candidate RFC ? Be note that we raised this proposal
          is because we do hit our trouble and we do need to resolve it
          …. So even a not perfect solution is still better than just
          cancel the innocent job (and their context/process)<o:p></o:p></p>
        <p class="MsoNormal" style="margin-bottom:12.0pt">Thanks ! <o:p></o:p></p>
        <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
          Regards,<br>
          Christian.<o:p></o:p></p>
        <div>
          <p class="MsoNormal">Am 26.02.21 um 06:58 schrieb Liu, Monk:<o:p></o:p></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="msipheader251902e5" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD
              Public Use]</span><o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">Hi all<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">NAVI2X &nbsp;project hit a really hard to
            solve issue now, and it is turned out to be a general
            headache of our TDR mechanism , check below scenario:<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <ol style="margin-top:0in" type="1" start="1">
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1">There is a
              job1 running on compute1 ring at timestamp
              <o:p></o:p></li>
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1">There is a
              job2 running on gfx ring at timestamp<o:p></o:p></li>
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1">Job1 is
              the guilty one, and job1/job2 were scheduled to their
              rings at almost the same timestamp
              <o:p></o:p></li>
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1">After 2
              seconds we receive two TDR reporting from both GFX ring
              and compute ring<o:p></o:p></li>
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1"><b>Current
                scheme is that in drm scheduler all the head jobs of
                those two rings are considered “bad job” and taken away
                from the mirror list
              </b><o:p></o:p></li>
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1">The result
              is both the real guilty job (job1) and the innocent job
              (job2) were all deleted from mirror list, and their
              corresponding contexts were also treated as guilty<b> (so
                the innocent process remains running is not secured)</b><o:p></o:p></li>
          </ol>
          <p class="MsoListParagraph"><b>&nbsp;</b><o:p></o:p></p>
          <p class="MsoNormal">But by our wish the ideal case is TDR
            mechanism can detect which ring is the guilty ring and the
            innocent ring can resubmits all its pending jobs:<o:p></o:p></p>
          <ol style="margin-top:0in" type="1" start="1">
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l2 level1 lfo2">Job1 to be
              deleted from compute1 ring’s mirror list<o:p></o:p></li>
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l2 level1 lfo2">Job2 is
              kept and resubmitted later and its belonging
              process/context are even not aware of this TDR at all
              <o:p></o:p></li>
          </ol>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">Here I have a proposal tend to achieve
            above goal and it rough procedure is :<o:p></o:p></p>
          <ol style="margin-top:0in" type="1" start="1">
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level1 lfo3">Once any
              ring reports a TDR, the head job is *<b>not</b>* treated
              as “bad job”, and it is *<b>not</b>* deleted from the
              mirror list in drm sched functions<o:p></o:p></li>
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level1 lfo3">In
              vendor’s function (our amdgpu driver here):<o:p></o:p></li>
          </ol>
          <ol style="margin-top:0in" type="1" start="2">
            <ul style="margin-top:0in" type="disc">
              <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level2 lfo3">reset
                GPU<o:p></o:p></li>
              <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level2 lfo3">repeat
                below actions on each RINGS * one by one *:<o:p></o:p></li>
            </ul>
          </ol>
          <p class="MsoListParagraph" style="margin-left:1.5in;text-indent:-9.0pt;mso-list:l1
            level3 lfo3">
            <!--[if !supportLists]--><span style="mso-list:Ignore">1.<span style="font:7.0pt &quot;Times New Roman&quot;">
              </span></span><!--[endif]-->take the head job and submit
            it on this ring<o:p></o:p></p>
          <p class="MsoListParagraph" style="margin-left:1.5in;text-indent:-9.0pt;mso-list:l1
            level3 lfo3">
            <!--[if !supportLists]--><span style="mso-list:Ignore">2.<span style="font:7.0pt &quot;Times New Roman&quot;">
              </span></span><!--[endif]-->see if it completes, if not
            then this job is the real “bad job”<o:p></o:p></p>
          <p class="MsoListParagraph" style="margin-left:1.5in;text-indent:-9.0pt;mso-list:l1
            level3 lfo3">
            <!--[if !supportLists]--><span style="mso-list:Ignore">3.<span style="font:7.0pt &quot;Times New Roman&quot;">
              </span></span><!--[endif]-->&nbsp;take it away from mirror list
            if this head job is “bad job”<o:p></o:p></p>
          <ol style="margin-top:0in" type="1" start="2">
            <ul style="margin-top:0in" type="disc">
              <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level2 lfo3">After
                above iteration on all RINGS, we already clears all the
                bad job(s)<o:p></o:p></li>
            </ul>
          </ol>
          <ol style="margin-top:0in" type="1" start="3">
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level1 lfo3">Resubmit
              all jobs from each mirror list to their corresponding
              rings (this is the existed logic)<o:p></o:p></li>
          </ol>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">The idea of this is to use “serial” way
            to re-run and re-check each head job of each RING, in order
            to take out the real black sheep and its guilty context.<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">P.S.: we can use this approaches only on
            GFX/KCQ ring reports TDR , since those rings are
            intermutually affected to each other. For SDMA ring timeout
            it definitely proves the head job on SDMA ring is really
            guilty.<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">Thanks <o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">------------------------------------------<o:p></o:p></p>
          <p class="MsoNormal">Monk Liu | Cloud-GPU Core team<o:p></o:p></p>
          <p class="MsoNormal">------------------------------------------<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
        </blockquote>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
  </body>
</html>

--------------C68276C20631E7FA9E0200AB--

--===============1729830580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1729830580==--
