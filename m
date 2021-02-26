Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA746C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 07:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6007D64EDB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 07:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6007D64EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E67D66EDA3;
	Fri, 26 Feb 2021 07:58:06 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760082.outbound.protection.outlook.com [40.107.76.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA6C6EDA3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 07:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZ62UeD30JU0nf2GHjXg3axAmJnbrcK79xfTggH6D09XG8H1RFY8azXFz+jnDFNwdM78Id9yfzBP/R2dd2iNJEQn5AWmcQRO0HUiUxGiAk8tgyJBKTs0ywvQlEM5QkD1cMkNP84LcWIQKkcBa0n3qlJRKnfiid9SPWy8aGhjBw4dppBdcv4o8IMmSrdEfT/pCGXhYqUmhZsvSsaINa1Oe/B+KaAfOjFHH27meIXmT+SNnn4FVKVnn80qiXMJ9ACMB3EDCeDZExaxVcHhpH6BILgFUBtXucSjUg/NLpNWZPJB5ExWy5/BKUH6SiRBH91b31CaY2WFFIMozDw4bUc+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcXQuj7MbEbd89bxwFcSjUxu+tWrD+botGwDv85oGMs=;
 b=c3ZBz9mPBPCHSsvx0EFz8P0KBIa41qPysUxHm/fHbxRH/mC/6V3H+8TT1fzx4FAjLIB0TJgoq56uZ5zPR039rFQY3lXCcukTlFgOui2BYmIZIWReYNJ1AAFSbJGcZ/sbVuosuAgVTiC0l7lppYNCylmavJgGQIKASCN93YJVW/+ZPAD8WODlsyenjpaTHyyBBibMKEProoHHZluczshw0lOldEIHJofhKqMN8k2wjKigcnLxAFV4CLNyc4QY2b4WZhwOQ1sblnnxoC1qcfXrmXDMf+CImzYVxRDeuMz887AVLVjCZ2mbWuKt44/9uvCdYg7uJyxY9WM7Mk5ZgNOCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcXQuj7MbEbd89bxwFcSjUxu+tWrD+botGwDv85oGMs=;
 b=K7Vd3BAT8NBxZYzODHy9Ks1DqYwBnwzjSEsEgY1kQBOKtEX1WG/oNrzp2DHB4AAHM6s3rDyrq4UOpIUqxYCDTA3GKmg1uyUraDYV3Y4d33XTkMfX5ZHK/4xYczZO0T2U3Lyk7h30bxaK0r5TAMvtm53PiByp7oaoU1PZRxavb6Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2451.namprd12.prod.outlook.com (2603:10b6:207:4e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 07:57:57 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 07:57:57 +0000
Subject: Re: [RFC] a new approach to detect which ring is the real black sheep
 upon TDR reported
To: "Liu, Monk" <Monk.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <DM5PR12MB1708D28565B445EABA872A3B849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f65d8f80-a283-933a-82bb-97b415689460@amd.com>
Date: Fri, 26 Feb 2021 08:57:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM5PR12MB1708D28565B445EABA872A3B849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:bcf6:4057:c09:be71]
X-ClientProxiedBy: AM0PR04CA0073.eurprd04.prod.outlook.com
 (2603:10a6:208:be::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:bcf6:4057:c09:be71]
 (2a02:908:1252:fb60:bcf6:4057:c09:be71) by
 AM0PR04CA0073.eurprd04.prod.outlook.com (2603:10a6:208:be::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 07:57:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 345675c7-5b0f-4e70-363e-08d8da2c3aed
X-MS-TrafficTypeDiagnostic: BL0PR12MB2451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2451E05EDBCCBEDBB07B9CA7839D9@BL0PR12MB2451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAakQVXVXTdca/2UvTFSNGujuheUE+6sDihrk5hWhZUAXIz91BbG/CujpULpWNciWeYIUTTrX/HdGZPOsdEjG/JZltEOUvPPc9pItsslIAs3LZoFvkIyNzJsqeDXPVUd+x3zcUk3j0crECJvyoMDjXvc2/cnRDir5Ed6DJT458WqMBhWA+odsALgyvUNqE08AZSn/txLIuSrDjdiihPKFbsH35VnUO3YUXu7bNlsRghjH7twJJhX6ChZ6QzWyS0ry01QNfbnR916HB8k/N0evPJVEJmpxnQE+y0tmJ4mXc7WImPcG5+hzdzGvHMCpsB+31X9M617ErGu+3XglMx+fioa8XS6+o01OIyWQM1oUshsH8nsKiB5WtkTb0/9Dp1VKMRNRUZ78V5g/AOvgHlHsipKfEuZKiuH1p1Cavet5Gid5ddARw1SW53ENtAZdKFx764wPidPfF/qBWl7gDcAbWZ6Cu4G1gpVTCXuArAMXalUOCld4EwblmYe99kEnJP7yM3YpfhUv4K85nkzpSCxQQzC9zNJAwNEfVUeU2rsLulnID3FU0otr81xYG0u6rR/SVr3RraH16LP714LmvRk6dSy+nSL6biLxFDEDCbYarU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(66556008)(8936002)(66476007)(66946007)(4326008)(52116002)(6486002)(5660300002)(33964004)(478600001)(2906002)(8676002)(31696002)(31686004)(2616005)(16526019)(186003)(83380400001)(36756003)(6666004)(86362001)(110136005)(54906003)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Rjk2QXplRHlmQkZxUGJ1dzBjbUhLQmRtQUZ3dHM0dmQ0VEhlZGw5eWZRQTRw?=
 =?utf-8?B?UXlidGlaSWJXTFVqQ2loajFiTHZEc01UYVN3TzJiVm8xR0RUOFgrTVFtVnFE?=
 =?utf-8?B?VnhFc3FiVDYvbTU2cFdzei9iVkxJc2dtWjNrYm84bDczQlNsekRrVzFwSkZu?=
 =?utf-8?B?cWozYWVhMCtGQWdSZzhET2FJblRjazZpOHdvNTNKdHRaYy9GMFNYeTlOQ3Zj?=
 =?utf-8?B?NFhDb3BVYlVJMzdoUDZFMCsyN0tOQ3ZLcWQxUmUrTy9EQnViWjVkREEvNmVW?=
 =?utf-8?B?OWhNMmNqUVZ6bEZEVEhvSVEzem53TWFpMjV3Q1M3KzNUSmdwNjVMUExqd1dP?=
 =?utf-8?B?MzF0UEYyVXI2b1diZ0p2YjgvaEFHVmxCcDVGWEhnWDJvQUlGMzAwdWd3eExl?=
 =?utf-8?B?OUFQMHRBaDd4Z3FVanRTYWVEblQwN3hoTWRRcXFTN1YzNGcxbVJEaGJJZkNT?=
 =?utf-8?B?ZWRBb1Q3Q2RpMExXK2w0aTQ5YVViQzl2TGVQQTRBV2V1V1JBWWdBc2dhdTJn?=
 =?utf-8?B?dGp4RFZYaDhwSGxNVjBDMXdQcFczWitZdnVodCtlZll3VDc5T0llYy9sbnR4?=
 =?utf-8?B?S1JuNk0wYjE4andPZjlyaGhFdVRVc0FMUkMvcmZnbjk0Q3U1Mm9yYm9Zcncy?=
 =?utf-8?B?ZXR0WnMxbHVPSVFlREsxQ1ZkWDdvN2lOKzRJZXZkcUd0VWZHMy9ya1Y5SDdR?=
 =?utf-8?B?dVVXYU1sR3RUQWNqOVJrOGNoUnFCdC9JelNyNW9EQVpHUUduRjBLUmJMdGFs?=
 =?utf-8?B?V003NkZNYjhteHlFS0RKR0VQcWEwOFNiYWhIRjZKQzcwTTVQbXg4NXYwYTdh?=
 =?utf-8?B?OUtqemN6Q1B3ZVU5TitIL3NCSytxbkZZRmo0MVc0cmNSWGVVYnZ0VzI0NDcw?=
 =?utf-8?B?bEt4RTllQldoREFZWTFPbFROQ2h1MVo5a0RUTDhYbGRmeUMrblJlS2t6Vkhq?=
 =?utf-8?B?dG10NFk3UVlvMy9kUTZYNHUrL1RWbXRibTZmMEZWYnA4OGtFZmp1aGdJd2Zz?=
 =?utf-8?B?YzJzRldyRVZZd2JYZ1NkWlpCZXBLSTBhaE5tcUo0TForQVdTRkh3SENPNzZm?=
 =?utf-8?B?WUJNdXowampINHBJRzcxMm1yUWRCS0s5em01TEZsYXFSdmtkUVVlSFhTVktJ?=
 =?utf-8?B?WWwvaFUzVUptVmZtQTdSTDRPY1ZHL1p6ZTh4WGtjL2FxUnhoWWRNZTRJaTBG?=
 =?utf-8?B?TEJsL3FsMjdNM01pRXVZUTBwcWF4c0Q4MmhZbW1OL0hCcUVjbHFLSGVuMFlO?=
 =?utf-8?B?SlVQUHM1Tkkxa0tWRkFobWliWFowSnM5ajA2N2d0Z2o3eGRmL1hVaHllK21Y?=
 =?utf-8?B?S2owUzV2bjNsa090M2ZORWFNY1A4RWlPd0lGam1BMG51bDdVVGhZV0RZTUF1?=
 =?utf-8?B?VXVGNmxham5xdVU5bnNmdWovaUNIb21YdTFRZXBKTDNmSnRRQ3NQWDhRdHdM?=
 =?utf-8?B?NDVCZHgwT0JEOVdRR3pjR29HWi9xVk1TT0ZsaDVFdHIxKzZhdUJETzhBWkhy?=
 =?utf-8?B?OTF2QXZOanFsY2c5aVNsWmhaZzdHcDN5aU1COEFGZWw2MitoVFE5Q0o0anNl?=
 =?utf-8?B?MWlqWE91dXpvekpYQ3pUc1c5citkYXl5NHVLVlRUSXdRdk1MU0dvMlA1VlVD?=
 =?utf-8?B?cHhYazE1MlUrSTdQTVVMaU5oNjNqZkRzc1FJRTVwYmc2MG5XaFNGWXFmT3dH?=
 =?utf-8?B?M1NjNC9NcDZpRHEzYVRFaVJHajYxNVQ0UWxOZ0ZadlJEd1h6bS9ML0pWZExn?=
 =?utf-8?B?Nkl5ckZzU05NK082amYrazVvdHRRMnZWeTF2a0tWZVM1U01EUW14OGltY0o5?=
 =?utf-8?B?YmRSc2w4Y3ZnckdlTkJjbmlDVXM3UzZvRnBuaEZ4Wk4wemVoKy9xaDlXb1NO?=
 =?utf-8?Q?CzOUeEF7zqynW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345675c7-5b0f-4e70-363e-08d8da2c3aed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 07:57:57.7104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Lc3jhdu3acAQmCikKPBwjKC8gvhRmMh3xJwDLSdrRJIUH0FdnkV5eEdFynC1uqU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2451
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
Content-Type: multipart/mixed; boundary="===============0486876014=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0486876014==
Content-Type: multipart/alternative;
 boundary="------------A4130A49B7ECCE1FCE9C8694"
Content-Language: en-US

--------------A4130A49B7ECCE1FCE9C8694
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Monk,

in general an interesting idea, but I see two major problems with that:

1. It would make the reset take much longer.

2. Things get often stuck because of timing issues, so a guilty job 
might pass perfectly when run a second time.

Apart from that the whole ring mirror list turned out to be a really bad 
idea. E.g. we still struggle with object life time because the concept 
doesn't fit into the object model of the GPU scheduler under Linux.

We should probably work on this separately and straighten up the job 
destruction once more and keep the recovery information in the fence 
instead.

Regards,
Christian.

Am 26.02.21 um 06:58 schrieb Liu, Monk:
>
> [AMD Public Use]
>
>
> Hi all
>
> NAVI2X  project hit a really hard to solve issue now, and it is turned 
> out to be a general headache of our TDR mechanism , check below scenario:
>
>  1. There is a job1 running on compute1 ring at timestamp
>  2. There is a job2 running on gfx ring at timestamp
>  3. Job1 is the guilty one, and job1/job2 were scheduled to their
>     rings at almost the same timestamp
>  4. After 2 seconds we receive two TDR reporting from both GFX ring
>     and compute ring
>  5. *Current scheme is that in drm scheduler all the head jobs of
>     those two rings are considered “bad job” and taken away from the
>     mirror list *
>  6. The result is both the real guilty job (job1) and the innocent job
>     (job2) were all deleted from mirror list, and their corresponding
>     contexts were also treated as guilty*(so the innocent process
>     remains running is not secured)*
>
> **
>
> But by our wish the ideal case is TDR mechanism can detect which ring 
> is the guilty ring and the innocent ring can resubmits all its pending 
> jobs:
>
>  1. Job1 to be deleted from compute1 ring’s mirror list
>  2. Job2 is kept and resubmitted later and its belonging
>     process/context are even not aware of this TDR at all
>
> Here I have a proposal tend to achieve above goal and it rough 
> procedure is :
>
>  1. Once any ring reports a TDR, the head job is **not** treated as
>     “bad job”, and it is **not** deleted from the mirror list in drm
>     sched functions
>  2. In vendor’s function (our amdgpu driver here):
>       * reset GPU
>       * repeat below actions on each RINGS * one by one *:
>
> 1.take the head job and submit it on this ring
>
> 2.see if it completes, if not then this job is the real “bad job”
>
> 3. take it away from mirror list if this head job is “bad job”
>
>       * After above iteration on all RINGS, we already clears all the
>         bad job(s)
>  2. Resubmit all jobs from each mirror list to their corresponding
>     rings (this is the existed logic)
>
> The idea of this is to use “serial” way to re-run and re-check each 
> head job of each RING, in order to take out the real black sheep and 
> its guilty context.
>
> P.S.: we can use this approaches only on GFX/KCQ ring reports TDR , 
> since those rings are intermutually affected to each other. For SDMA 
> ring timeout it definitely proves the head job on SDMA ring is really 
> guilty.
>
> Thanks
>
> ------------------------------------------
>
> Monk Liu | Cloud-GPU Core team
>
> ------------------------------------------
>


--------------A4130A49B7ECCE1FCE9C8694
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Monk,<br>
    <br>
    in general an interesting idea, but I see two major problems with
    that:<br>
    <br>
    1. It would make the reset take much longer.<br>
    <br>
    2. Things get often stuck because of timing issues, so a guilty job
    might pass perfectly when run a second time.<br>
    <br>
    Apart from that the whole ring mirror list turned out to be a really
    bad idea. E.g. we still struggle with object life time because the
    concept doesn't fit into the object model of the GPU scheduler under
    Linux.<br>
    <br>
    We should probably work on this separately and straighten up the job
    destruction once more and keep the recovery information in the fence
    instead.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 26.02.21 um 06:58 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite" cite="mid:DM5PR12MB1708D28565B445EABA872A3B849D9@DM5PR12MB1708.namprd12.prod.outlook.com">
      
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
      <p class="msipheader251902e5" style="margin:0" align="Left"><span style="font-size:10.0pt;font-family:Arial;color:#317100">[AMD
          Public Use]</span></p>
      <br>
      <div class="WordSection1">
        <p class="MsoNormal">Hi all<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">NAVI2X &nbsp;project hit a really hard to solve
          issue now, and it is turned out to be a general headache of
          our TDR mechanism , check below scenario:<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <ol style="margin-top:0in" type="1" start="1">
          <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1">There is a
            job1 running on compute1 ring at timestamp
            <o:p></o:p></li>
          <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1">There is a
            job2 running on gfx ring at timestamp<o:p></o:p></li>
          <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1">Job1 is the
            guilty one, and job1/job2 were scheduled to their rings at
            almost the same timestamp
            <o:p></o:p></li>
          <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1">After 2
            seconds we receive two TDR reporting from both GFX ring and
            compute ring<o:p></o:p></li>
          <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1"><b>Current
              scheme is that in drm scheduler all the head jobs of those
              two rings are considered “bad job” and taken away from the
              mirror list
              <o:p></o:p></b></li>
          <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1">The result
            is both the real guilty job (job1) and the innocent job
            (job2) were all deleted from mirror list, and their
            corresponding contexts were also treated as guilty<b> (so
              the innocent process remains running is not secured)<o:p></o:p></b></li>
        </ol>
        <p class="MsoListParagraph"><b><o:p>&nbsp;</o:p></b></p>
        <p class="MsoNormal">But by our wish the ideal case is TDR
          mechanism can detect which ring is the guilty ring and the
          innocent ring can resubmits all its pending jobs:<o:p></o:p></p>
        <ol style="margin-top:0in" type="1" start="1">
          <li class="MsoListParagraph" style="margin-left:0in;mso-list:l2 level1 lfo2">Job1 to be
            deleted from compute1 ring’s mirror list<o:p></o:p></li>
          <li class="MsoListParagraph" style="margin-left:0in;mso-list:l2 level1 lfo2">Job2 is kept
            and resubmitted later and its belonging process/context are
            even not aware of this TDR at all
            <o:p></o:p></li>
        </ol>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Here I have a proposal tend to achieve
          above goal and it rough procedure is :<o:p></o:p></p>
        <ol style="margin-top:0in" type="1" start="1">
          <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level1 lfo3">Once any
            ring reports a TDR, the head job is *<b>not</b>* treated as
            “bad job”, and it is *<b>not</b>* deleted from the mirror
            list in drm sched functions<o:p></o:p></li>
          <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level1 lfo3">In vendor’s
            function (our amdgpu driver here):<o:p></o:p></li>
          <ul style="margin-top:0in" type="disc">
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level2 lfo3">reset GPU<o:p></o:p></li>
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level2 lfo3">repeat
              below actions on each RINGS * one by one *:<o:p></o:p></li>
          </ul>
        </ol>
        <p class="MsoListParagraph" style="margin-left:1.5in;text-indent:-9.0pt;mso-list:l1 level3
          lfo3">
          <!--[if !supportLists]--><span style="mso-list:Ignore">1.<span style="font:7.0pt &quot;Times New Roman&quot;">
            </span></span><!--[endif]-->take the head job and submit it
          on this ring<o:p></o:p></p>
        <p class="MsoListParagraph" style="margin-left:1.5in;text-indent:-9.0pt;mso-list:l1 level3
          lfo3">
          <!--[if !supportLists]--><span style="mso-list:Ignore">2.<span style="font:7.0pt &quot;Times New Roman&quot;">
            </span></span><!--[endif]-->see if it completes, if not then
          this job is the real “bad job”<o:p></o:p></p>
        <p class="MsoListParagraph" style="margin-left:1.5in;text-indent:-9.0pt;mso-list:l1 level3
          lfo3">
          <!--[if !supportLists]--><span style="mso-list:Ignore">3.<span style="font:7.0pt &quot;Times New Roman&quot;">
            </span></span><!--[endif]-->&nbsp;take it away from mirror list
          if this head job is “bad job”<o:p></o:p></p>
        <ol style="margin-top:0in" type="1" start="2">
          <ul style="margin-top:0in" type="disc">
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level2 lfo3">After
              above iteration on all RINGS, we already clears all the
              bad job(s)<o:p></o:p></li>
          </ul>
          <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level1 lfo3">Resubmit all
            jobs from each mirror list to their corresponding rings
            (this is the existed logic)<o:p></o:p></li>
        </ol>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">The idea of this is to use “serial” way to
          re-run and re-check each head job of each RING, in order to
          take out the real black sheep and its guilty context.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">P.S.: we can use this approaches only on
          GFX/KCQ ring reports TDR , since those rings are intermutually
          affected to each other. For SDMA ring timeout it definitely
          proves the head job on SDMA ring is really guilty.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Thanks <o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">------------------------------------------<o:p></o:p></p>
        <p class="MsoNormal">Monk Liu | Cloud-GPU Core team<o:p></o:p></p>
        <p class="MsoNormal">------------------------------------------<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------A4130A49B7ECCE1FCE9C8694--

--===============0486876014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0486876014==--
