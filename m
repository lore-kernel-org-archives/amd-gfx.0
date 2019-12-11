Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A8AC2D0C6
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 14:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5154A2173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 14:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Vi9Qmcxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5154A2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE9C86EB5C;
	Wed, 11 Dec 2019 14:04:54 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680088.outbound.protection.outlook.com [40.107.68.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC056EB5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 14:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXikD7BABks2lnDkGBDdWQNs/USHGgwTicrfE2Hw4dIqbjSQX+b44xueGAcw3Ns0SWGnj9QexRu2zg76ud7DCvQkSTIkSzxn0/TCYRYcl02V2Xj93bgAdIYqjE4AnMTjx0SDpSDQjXSVzl7Js/L+JhnmVuGEKwDjkKKFdN32jibvingxT8JSTvl9Uh5CKwHw3IuS0sUSGr/ZMtC39AhOCQ86dJnAiIC/tp9dAFHixkunATAN5OW8XvKqKX48WNhNnPxGYXObqjBdgV9kAtmhGyuGP2Q64L/CkQHm9wdWGseH94YiA1FYT401oH1R9yttVmoSAj3sP8jyCvBYzKQPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mhQYbH6BDdhIkMeU5I9uUSbQHPxEd27cWivncfr5jI=;
 b=k0/IZOgp9Dc7JuP2j4ybUHqIh4Q+osXzotjLovrztovxzud3odfpCmMP0n1kfzzlf1AZbjTTpxF3QOeWAZkKxm/6zKuAI+0HE/m+HDk4StZ/rkzImvoCHblkUwDzKQgztM+MeyS+82mqR/ARxjbSh3mDg8WDTWQuomi3s+UQ7ScZt5CkAtMnF8DXoyAKt4hXp2p0bUOu968ePHaFfYI0ZIrEZPua1VWkDf3Am0TOzlETueEFzZRaFBFTTWX32GqxnpRn9Hkxfx62VT93zvgxA8zxooW68q0+A0ycYfgEecgxkbQY3UzjFIIHNlTJ5l5B8kNFy9+Dd70zSo6dNJBDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mhQYbH6BDdhIkMeU5I9uUSbQHPxEd27cWivncfr5jI=;
 b=Vi9Qmcxwcgrr/rkHYkTY/X0Yqa5Z3NK8mwXNIXQ+4wn8QXy9NQKD2ALlGA5gtrwFqvTlrHTB9sjEwbEv/4Yn9bav9pO5CUeL3PY18Ck0QSC4hn83g1n92kOClb+zBfCThQBmui2JMO/jHW1t6VNcDzwFZoOepQyt+uBwPMOmPBM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1632.namprd12.prod.outlook.com (10.172.56.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.18; Wed, 11 Dec 2019 14:04:49 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80%12]) with mapi id 15.20.2538.016; Wed, 11 Dec 2019
 14:04:48 +0000
Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support for
 XGMI
To: "Ma, Le" <Le.Ma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <157d7671-803c-4f6e-f77c-9738f32905e3@amd.com>
 <MN2PR12MB428532FA663C99770AA71263F6430@MN2PR12MB4285.namprd12.prod.outlook.com>
 <5b505116-17aa-383d-5cdf-246663a1f4f9@amd.com>
 <MN2PR12MB42855B198BB4064A0D311845F6420@MN2PR12MB4285.namprd12.prod.outlook.com>
 <2c4dd3f3-e2ce-9843-312b-1e5c05a51521@amd.com>
 <CH2PR12MB4278F9759EF24F29A85D7D23F65D0@CH2PR12MB4278.namprd12.prod.outlook.com>
 <0cf9f58a-3ce4-2a9c-cb1a-db3cb13760b9@amd.com>
 <MN2PR12MB42855296AE5C7EDA968AA442F65C0@MN2PR12MB4285.namprd12.prod.outlook.com>
 <a38e95ac-ca7e-20fd-0c2a-4d4310e8599a@amd.com>
 <MN2PR12MB428581A895E0C2B26542CC1DF6580@MN2PR12MB4285.namprd12.prod.outlook.com>
 <b44fcb10-d1ed-c93a-8010-5b62aae74545@amd.com>
 <MN2PR12MB4285B04000E228E467F8004BF65B0@MN2PR12MB4285.namprd12.prod.outlook.com>
 <6942e47f-fcb6-0fa4-fdf9-4c0ad936ef90@amd.com>
 <MN2PR12MB42855499B960506C3BA62198F65A0@MN2PR12MB4285.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <d64f892c-44af-ff72-e581-f10853896271@amd.com>
Date: Wed, 11 Dec 2019 09:04:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <MN2PR12MB42855499B960506C3BA62198F65A0@MN2PR12MB4285.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::19) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-Originating-IP: [2607:fea8:3edf:e127:d9a5:14ce:f419:6ca9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 622f6d2c-2e78-4785-6ab1-08d77e43156a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1632:|MWHPR12MB1632:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB163210740D80433EB1EB6ADDEA5A0@MWHPR12MB1632.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(52314003)(199004)(189003)(30864003)(6666004)(36756003)(6506007)(2616005)(81166006)(316002)(33964004)(8936002)(478600001)(53546011)(8676002)(52116002)(186003)(110136005)(81156014)(4326008)(31696002)(66476007)(5660300002)(6486002)(66556008)(6512007)(2906002)(66946007)(86362001)(31686004)(6636002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1632;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8m7hTI4rUbdOd6/ZXMX68nfJ5C7Tg9brq/Liv1dr3ATFCIyVhgwMH+fueYA/SNVhCaaLq63mqxUh/7ShbwSU5RFjIRa2UQes+a8ROBgCy4fj85guynfLULCJdc+Hz8KdLRk0RD8HybNO0M/ZgZaexgOlc3qEBuSo3Vf1lljANJnpoeSNLHX2GuFETu2PR056I8c5+vVqRKNVEHD1hLm1ZGx3BeSn31GJ/omXv2J/fYmQtJoEoC8otwr6xDeVt59/fg1PHzERbiM1wKw2NDlzPveDGG0zQomIGusVGC5fgNKPUO0zBfN8XzUBlBdXM1XaHTtObDJyCak+VEvefTyuH4JW1DPQOVvD1TbXlerdcPsiWROPt2KBd1IG17h4Jz+Q7TvD7SjkbRo7IaQRyxIbeHuRMr4SnaQ3a2l2n60vlKwO60qK6JjurY2g86HvNYcmSGCtILW9oWrnwgxsBlzjXvyReyAOz3R8qiaRjcHBX0BJRP7OPKy7xDOEOCfz8hAMjDZYWLWwJedB20rmd3noAw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622f6d2c-2e78-4785-6ab1-08d77e43156a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 14:04:48.7936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZgB4G9SV1+6rVzdpazmCbXuzt9gG3F3bUTsNS8R3GVcbLL0nJ2SWaVy9WaTZEJvrHThgz5tVsXXnVZXjWiSmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1632
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: multipart/mixed; boundary="===============1101037849=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1101037849==
Content-Type: multipart/alternative;
 boundary="------------0170881B69F893845BCEE423"
Content-Language: en-US

--------------0170881B69F893845BCEE423
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Great! I will update the patches to also use the barrier in PSP MODE 1 
reset case and resend the patches for formal review.

Andrey

On 12/11/19 7:18 AM, Ma, Le wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> I tried your new patches to run BACO for about 10 loops and the result 
> looks positive, without observing enter/exit baco message failure again.
>
> The time interval between BACO entries or exits in my environment was 
> almost less than 10 us: max 36us, min 2us. I think it’s safe enough 
> according to the sample data we collected in both sides.
>
> And it looks not necessary to continue using system_highpri_wq any 
> more because we require all the nodes enter or exit at the same time, 
> while do not mind how long the time interval is b/t enter and exit. 
> The system_unbound_wq can satisfy our requirement here since it wakes 
> different CPUs up to work at the same time.
>
> Regards,
>
> Ma Le
>
> *From:*Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> *Sent:* Wednesday, December 11, 2019 3:56 AM
> *To:* Ma, Le <Le.Ma@amd.com>; amd-gfx@lists.freedesktop.org; Zhou1, 
> Tao <Tao.Zhou1@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhang, 
> Hawking <Hawking.Zhang@amd.com>
> *Cc:* Chen, Guchun <Guchun.Chen@amd.com>
> *Subject:* Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset 
> support for XGMI
>
> I switched the workqueue we were using for xgmi_reset_work from 
> system_highpri_wq to system_unbound_wq - the difference is that 
> workers servicing the queue in system_unbound_wq are not bounded to 
> specific CPU and so the reset jobs for each XGMI node are getting 
> scheduled to different CPU while system_highpri_wq is a bounded work 
> queue. I traced it as bellow for 10 consecutive times and didn't see 
> errors any more. Also the time diff between BACO entries or exits was 
> never more then around 2 uS.
>
> Please give this updated patchset a try
>
>    kworker/u16:2-57    [004] ...1   243.276312: trace_code: func: 
> vega20_baco_set_state, line 91 <----- - Before BEACO enter
>            <...>-60    [007] ...1   243.276312: trace_code: func: 
> vega20_baco_set_state, line 91 <----- - Before BEACO enter
>    kworker/u16:2-57    [004] ...1   243.276384: trace_code: func: 
> vega20_baco_set_state, line 105 <----- - After BEACO enter done
>            <...>-60    [007] ...1   243.276392: trace_code: func: 
> vega20_baco_set_state, line 105 <----- - After BEACO enter done
>    kworker/u16:3-60    [007] ...1   243.276397: trace_code: func: 
> vega20_baco_set_state, line 108 <----- - Before BEACO exit
>    kworker/u16:2-57    [004] ...1   243.276399: trace_code: func: 
> vega20_baco_set_state, line 108 <----- - Before BEACO exit
>    kworker/u16:3-60    [007] ...1   243.288067: trace_code: func: 
> vega20_baco_set_state, line 114 <----- - After BEACO exit done
>    kworker/u16:2-57    [004] ...1   243.295624: trace_code: func: 
> vega20_baco_set_state, line 114 <----- - After BEACO exit done
>
> Andrey
>
> On 12/9/19 9:45 PM, Ma, Le wrote:
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     I’m fine with your solution if synchronization time interval
>     satisfies BACO requirements and loop test can pass on XGMI system.
>
>     Regards,
>
>     Ma Le
>
>     *From:*Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>     <mailto:Andrey.Grodzovsky@amd.com>
>     *Sent:* Monday, December 9, 2019 11:52 PM
>     *To:* Ma, Le <Le.Ma@amd.com> <mailto:Le.Ma@amd.com>;
>     amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>; Zhou1, Tao
>     <Tao.Zhou1@amd.com> <mailto:Tao.Zhou1@amd.com>; Deucher, Alexander
>     <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com>;
>     Li, Dennis <Dennis.Li@amd.com> <mailto:Dennis.Li@amd.com>; Zhang,
>     Hawking <Hawking.Zhang@amd.com> <mailto:Hawking.Zhang@amd.com>
>     *Cc:* Chen, Guchun <Guchun.Chen@amd.com> <mailto:Guchun.Chen@amd.com>
>     *Subject:* Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset
>     support for XGMI
>
>     Thanks a lot Ma for trying - I think I have to have my own system
>     to debug this so I will keep trying enabling XGMI - i still think
>     the is the right and the generic solution for multiple nodes reset
>     synchronization and in fact the barrier should also be used for
>     synchronizing PSP mode 1 XGMI reset too.
>
>     Andrey
>
>     On 12/9/19 6:34 AM, Ma, Le wrote:
>
>         [AMD Official Use Only - Internal Distribution Only]
>
>         Hi Andrey,
>
>         I tried your patches on my 2P XGMI platform. The baco can work
>         at most time, and randomly got following error:
>
>         [ 1701.542298] amdgpu: [powerplay] Failed to send message
>         0x25, response 0x0
>
>         This error usually means some sync issue exist for xgmi baco
>         case. Feel free to debug your patches on my XGMI platform.
>
>         Regards,
>
>         Ma Le
>
>         *From:*Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>         <mailto:Andrey.Grodzovsky@amd.com>
>         *Sent:* Saturday, December 7, 2019 5:51 AM
>         *To:* Ma, Le <Le.Ma@amd.com> <mailto:Le.Ma@amd.com>;
>         amd-gfx@lists.freedesktop.org
>         <mailto:amd-gfx@lists.freedesktop.org>; Zhou1, Tao
>         <Tao.Zhou1@amd.com> <mailto:Tao.Zhou1@amd.com>; Deucher,
>         Alexander <Alexander.Deucher@amd.com>
>         <mailto:Alexander.Deucher@amd.com>; Li, Dennis
>         <Dennis.Li@amd.com> <mailto:Dennis.Li@amd.com>; Zhang, Hawking
>         <Hawking.Zhang@amd.com> <mailto:Hawking.Zhang@amd.com>
>         *Cc:* Chen, Guchun <Guchun.Chen@amd.com>
>         <mailto:Guchun.Chen@amd.com>
>         *Subject:* Re: [PATCH 07/10] drm/amdgpu: add concurrent baco
>         reset support for XGMI
>
>         Hey Ma, attached a solution - it's just compiled as I still
>         can't make my XGMI setup work (with bridge connected only one
>         device is visible to the system while the other is not).
>         Please try it on your system if you have a chance.
>
>         Andrey
>
>         On 12/4/19 10:14 PM, Ma, Le wrote:
>
>             AFAIK it's enough for even single one node in the hive to
>             to fail the enter the BACO state on time to fail the
>             entire hive reset procedure, no ?
>
>             [Le]: Yeah, agree that. I’ve been thinking that make all
>             nodes entering baco simultaneously can reduce the
>             possibility of node failure to enter/exit BACO risk. For
>             example, in an XGMI hive with 8 nodes, the total time
>             interval of 8 nodes enter/exit BACO on 8 CPUs is less than
>             the interval that 8 nodes enter BACO serially and exit
>             BACO serially depending on one CPU with yield capability.
>             This interval is usually strict for BACO feature itself.
>             Anyway, we need more looping test later on any method we
>             will choose.
>
>             Any way - I see our discussion blocks your entire patch
>             set - I think you can go ahead and commit yours way (I
>             think you got an RB from Hawking) and I will look then and
>             see if I can implement my method and if it works will just
>             revert your patch.
>
>             [Le]: OK, fine.
>
>             Andrey
>

--------------0170881B69F893845BCEE423
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Great! I will update the patches to also use the barrier in PSP
      MODE 1 reset case and resend the patches for formal review.</p>
    <p>Andrey<br>
    </p>
    <div class="moz-cite-prefix">On 12/11/19 7:18 AM, Ma, Le wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB42855499B960506C3BA62198F65A0@MN2PR12MB4285.namprd12.prod.outlook.com">
      
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
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="msipheadera92e061b" style="margin:0in;margin-bottom:.0001pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
            Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
        <p class="MsoNormal"><span style="color:windowtext"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">I tried your new
            patches to run BACO for about 10 loops and the result looks
            positive, without observing enter/exit baco message failure
            again.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">The time interval
            between BACO entries or exits in my environment was almost
            less than 10 us: max 36us, min 2us. I think it’s safe enough
            according to the sample data we collected in both sides.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">And it looks not
            necessary to continue using system_highpri_wq any more
            because we require all the nodes enter or exit at the same
            time, while do not mind how long the time interval is b/t
            enter and exit. The </span>system_unbound_wq can satisfy
          our requirement here since it wakes different CPUs up to work
          at the same time.<span style="font-size:12.0pt;color:windowtext"><o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">Regards,<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">Ma Le<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext"><o:p>&nbsp;</o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span style="color:windowtext"> Grodzovsky, Andrey
                <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@amd.com&gt;</a>
                <br>
                <b>Sent:</b> Wednesday, December 11, 2019 3:56 AM<br>
                <b>To:</b> Ma, Le <a class="moz-txt-link-rfc2396E" href="mailto:Le.Ma@amd.com">&lt;Le.Ma@amd.com&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Zhou1, Tao
                <a class="moz-txt-link-rfc2396E" href="mailto:Tao.Zhou1@amd.com">&lt;Tao.Zhou1@amd.com&gt;</a>; Deucher, Alexander
                <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Li, Dennis
                <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a>; Zhang, Hawking
                <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                <b>Cc:</b> Chen, Guchun <a class="moz-txt-link-rfc2396E" href="mailto:Guchun.Chen@amd.com">&lt;Guchun.Chen@amd.com&gt;</a><br>
                <b>Subject:</b> Re: [PATCH 07/10] drm/amdgpu: add
                concurrent baco reset support for XGMI<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p>I switched the workqueue we were using for xgmi_reset_work
          from system_highpri_wq to system_unbound_wq - the difference
          is that workers servicing the queue in system_unbound_wq are
          not bounded to specific CPU and so the reset jobs for each
          XGMI node are getting scheduled to different CPU while
          system_highpri_wq is a bounded work queue. I traced it as
          bellow for 10 consecutive times and didn't see errors any
          more. Also the time diff between BACO entries or exits was
          never more then around 2 uS.
          <o:p></o:p></p>
        <p>Please give this updated patchset a try<o:p></o:p></p>
        <p>&nbsp;&nbsp; kworker/u16:2-57&nbsp;&nbsp;&nbsp; [004] ...1&nbsp;&nbsp; 243.276312: trace_code:
          func: vega20_baco_set_state, line 91 &lt;----- - Before BEACO
          enter<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;...&gt;-60&nbsp;&nbsp;&nbsp; [007] ...1&nbsp;&nbsp; 243.276312:
          trace_code: func: vega20_baco_set_state, line 91 &lt;----- -
          Before BEACO enter<br>
          &nbsp;&nbsp; kworker/u16:2-57&nbsp;&nbsp;&nbsp; [004] ...1&nbsp;&nbsp; 243.276384: trace_code:
          func: vega20_baco_set_state, line 105 &lt;----- - After BEACO
          enter done<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;...&gt;-60&nbsp;&nbsp;&nbsp; [007] ...1&nbsp;&nbsp; 243.276392:
          trace_code: func: vega20_baco_set_state, line 105 &lt;----- -
          After BEACO enter done<br>
          &nbsp;&nbsp; kworker/u16:3-60&nbsp;&nbsp;&nbsp; [007] ...1&nbsp;&nbsp; 243.276397: trace_code:
          func: vega20_baco_set_state, line 108 &lt;----- - Before BEACO
          exit<br>
          &nbsp;&nbsp; kworker/u16:2-57&nbsp;&nbsp;&nbsp; [004] ...1&nbsp;&nbsp; 243.276399: trace_code:
          func: vega20_baco_set_state, line 108 &lt;----- - Before BEACO
          exit<br>
          &nbsp;&nbsp; kworker/u16:3-60&nbsp;&nbsp;&nbsp; [007] ...1&nbsp;&nbsp; 243.288067: trace_code:
          func: vega20_baco_set_state, line 114 &lt;----- - After BEACO
          exit done<br>
          &nbsp;&nbsp; kworker/u16:2-57&nbsp;&nbsp;&nbsp; [004] ...1&nbsp;&nbsp; 243.295624: trace_code:
          func: vega20_baco_set_state, line 114 &lt;----- - After BEACO
          exit done<o:p></o:p></p>
        <p>Andrey<o:p></o:p></p>
        <div>
          <p class="MsoNormal">On 12/9/19 9:45 PM, Ma, Le wrote:<o:p></o:p></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="msipheadera92e061b" style="margin:0in;margin-bottom:.0001pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
              Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">I’m fine with
              your solution if synchronization time interval satisfies
              BACO requirements and loop test can pass on XGMI system.</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">&nbsp;</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">Regards,</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">Ma Le</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">&nbsp;</span><o:p></o:p></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span style="color:windowtext"> Grodzovsky, Andrey
                  <a href="mailto:Andrey.Grodzovsky@amd.com" moz-do-not-send="true">&lt;Andrey.Grodzovsky@amd.com&gt;</a>
                  <br>
                  <b>Sent:</b> Monday, December 9, 2019 11:52 PM<br>
                  <b>To:</b> Ma, Le <a href="mailto:Le.Ma@amd.com" moz-do-not-send="true">&lt;Le.Ma@amd.com&gt;</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    amd-gfx@lists.freedesktop.org</a>; Zhou1, Tao <a href="mailto:Tao.Zhou1@amd.com" moz-do-not-send="true">
                    &lt;Tao.Zhou1@amd.com&gt;</a>; Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
                    &lt;Alexander.Deucher@amd.com&gt;</a>; Li, Dennis <a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">&lt;Dennis.Li@amd.com&gt;</a>;
                  Zhang, Hawking
                  <a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                  <b>Cc:</b> Chen, Guchun <a href="mailto:Guchun.Chen@amd.com" moz-do-not-send="true">&lt;Guchun.Chen@amd.com&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH 07/10] drm/amdgpu: add
                  concurrent baco reset support for XGMI</span><o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p>Thanks a lot Ma for trying - I think I have to have my own
            system to debug this so I will keep trying enabling XGMI - i
            still think the is the right and the generic solution for
            multiple nodes reset synchronization and in fact the barrier
            should also be used for synchronizing PSP mode 1 XGMI reset
            too.<o:p></o:p></p>
          <p>Andrey<o:p></o:p></p>
          <div>
            <p class="MsoNormal">On 12/9/19 6:34 AM, Ma, Le wrote:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="msipheadera92e061b" style="margin:0in;margin-bottom:.0001pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
                Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
            <p class="MsoNormal">&nbsp;<o:p></o:p></p>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">Hi Andrey,</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">&nbsp;</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">I tried your
                patches on my 2P XGMI platform. The baco can work at
                most time, and randomly got following error:</span><o:p></o:p></p>
            <p class="MsoNormal" style="margin-left:.5in"><span style="font-size:12.0pt;color:windowtext">[ 1701.542298]
                amdgpu: [powerplay] Failed to send message 0x25,
                response 0x0</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">&nbsp;</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">This error
                usually means some sync issue exist for xgmi baco case.
                Feel free to debug your patches on my XGMI platform.</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">&nbsp;</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">Regards,</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">Ma Le</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">&nbsp;</span><o:p></o:p></p>
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span style="color:windowtext"> Grodzovsky, Andrey
                  </span><a href="mailto:Andrey.Grodzovsky@amd.com" moz-do-not-send="true">&lt;Andrey.Grodzovsky@amd.com&gt;</a><span style="color:windowtext">
                    <br>
                    <b>Sent:</b> Saturday, December 7, 2019 5:51 AM<br>
                    <b>To:</b> Ma, Le </span><a href="mailto:Le.Ma@amd.com" moz-do-not-send="true">&lt;Le.Ma@amd.com&gt;</a><span style="color:windowtext">;
                  </span><a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><span style="color:windowtext">; Zhou1, Tao
                  </span><a href="mailto:Tao.Zhou1@amd.com" moz-do-not-send="true">&lt;Tao.Zhou1@amd.com&gt;</a><span style="color:windowtext">; Deucher, Alexander
                  </span><a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><span style="color:windowtext">; Li, Dennis
                  </span><a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">&lt;Dennis.Li@amd.com&gt;</a><span style="color:windowtext">; Zhang, Hawking
                  </span><a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">&lt;Hawking.Zhang@amd.com&gt;</a><span style="color:windowtext"><br>
                    <b>Cc:</b> Chen, Guchun </span><a href="mailto:Guchun.Chen@amd.com" moz-do-not-send="true">&lt;Guchun.Chen@amd.com&gt;</a><span style="color:windowtext"><br>
                    <b>Subject:</b> Re: [PATCH 07/10] drm/amdgpu: add
                    concurrent baco reset support for XGMI</span><o:p></o:p></p>
              </div>
            </div>
            <p class="MsoNormal">&nbsp;<o:p></o:p></p>
            <p>Hey Ma, attached a solution - it's just compiled as I
              still can't make my XGMI setup work (with bridge connected
              only one device is visible to the system while the other
              is not). Please try it on your system if you have a
              chance.
              <o:p></o:p></p>
            <p>Andrey<o:p></o:p></p>
            <div>
              <p class="MsoNormal">On 12/4/19 10:14 PM, Ma, Le wrote:<o:p></o:p></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p>AFAIK it's enough for even single one node in the hive
                to to fail the enter the BACO state on time to fail the
                entire hive reset procedure, no ?<o:p></o:p></p>
              <p class="MsoNormal" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><span style="font-size:12.0pt;color:#203864">[Le]: Yeah,
                  agree that. I’ve been thinking that make all nodes
                  entering baco simultaneously can reduce the
                  possibility of node failure to enter/exit BACO risk.
                  For example, in an XGMI hive with 8 nodes, the total
                  time interval of 8 nodes enter/exit BACO on 8 CPUs is
                  less than the interval that 8 nodes enter BACO
                  serially and exit BACO serially depending on one CPU
                  with yield capability. This interval is usually strict
                  for BACO feature itself. Anyway, we need more looping
                  test later on any method we will choose.</span><o:p></o:p></p>
              <p>Any way - I see our discussion blocks your entire patch
                set - I think you can go ahead and commit yours way (I
                think you got an RB from Hawking) and I will look then
                and see if I can implement my method and if it works
                will just revert your patch.<o:p></o:p></p>
              <p><span style="font-size:12.0pt;color:#203864">[Le]: OK,
                  fine.</span><o:p></o:p></p>
              <p>Andrey<o:p></o:p></p>
            </blockquote>
          </blockquote>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------0170881B69F893845BCEE423--

--===============1101037849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1101037849==--
