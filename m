Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC47BC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 19:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751992077B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 19:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nr5CVx1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751992077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A726E91B;
	Tue, 10 Dec 2019 19:55:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54E36E91B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 19:55:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxCW4kLXJKWXVWR+AhtaWb3IHzwyQSvLBLDBRZUSsrtASUz9QWk1hUtLNaNu6KSygMidAblAYSkkmZvHhIEbDcFz70ca+QHKH6g4sxhiS0X7MwyebEi2e+87iI8VlWf8TGEoTxR92EEtMYa3AgLeJ55Y3S/Xc2LHA0bz9451APhHJihHYDR1VKrIsAIdw6YNnRIgxXHhJo7PizrTi8ce9IH3blimLRAU9QTEuqJ0kkzrk1pDO3P+R9HweFv/1IXOVFmBlqtc2B5h2VNaxrTa+J9FsV2pD+zDIhhgJP6HCDVT0hk1eXE/8pUS+HY3o6WTeQTRAk0LlBJ9M+B3maA4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDmJXATldKrbnwflsnlKqiwsZLyXzsvl2dt2zqVaTWA=;
 b=WuiJqtgQPO/lweD1/4FgZ6W1Vr21noFYpuWo83KqX2LgK/G23G9Mw13qdN0pXDmZXJemj8K/6GRpJUrzBhlMzru4XxnxkH4SrLiXxikkjW4noPOdgVZQV+f1Vbhp6vOyTMUybp3oADbDgcgaeahi55rFumEqTLRh7N8gnG7+boypFOjEVnpq4JL+A7vBz9fPFFnPK5ukOLoQ2GQ4dRXsBuNgHcgG+pvIa4GBKVSAqjr+uey1b4jMdIeS4+5ORVwese56CO3F4PgEv+175/1g4tUPao2/6mr49YKdtPL9YmCJdej+eLPCkbsw5hdDw60LJn+EizYuAJrYk3af0boOnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDmJXATldKrbnwflsnlKqiwsZLyXzsvl2dt2zqVaTWA=;
 b=nr5CVx1mBeDN6zhRk5O8bBbH/BXpAcjyWrCK4d0qvvZhnG/Z/CYJ6qVf0PgKZxNO5oL8DQgC/Cpizem3ztud93MwdQx4RXoiKO+MX/kT0SyB02QMv34eoT+5foq7/SK58nczXFbU9s/b/GZ1Bf8DRVNXgKNiOYppnPbWUB1+DUc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1872.namprd12.prod.outlook.com (10.175.52.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 19:55:52 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80%12]) with mapi id 15.20.2538.012; Tue, 10 Dec 2019
 19:55:52 +0000
Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support for
 XGMI
To: "Ma, Le" <Le.Ma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <c09d7928-f864-3a80-40e2-b6116abe044c@amd.com>
 <MN2PR12MB42859443EA78D08B295AFE0DF6470@MN2PR12MB4285.namprd12.prod.outlook.com>
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
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <6942e47f-fcb6-0fa4-fdf9-4c0ad936ef90@amd.com>
Date: Tue, 10 Dec 2019 14:55:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <MN2PR12MB4285B04000E228E467F8004BF65B0@MN2PR12MB4285.namprd12.prod.outlook.com>
Content-Type: multipart/mixed; boundary="------------50E3D602A9B73C0ABCC3BDFB"
Content-Language: en-US
X-ClientProxiedBy: SN2PR01CA0009.prod.exchangelabs.com (2603:10b6:804:2::19)
 To MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22)
MIME-Version: 1.0
X-Originating-IP: [2607:fea8:3edf:e127:b190:b0bd:5040:9d08]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76bf615a-a23c-4c98-9d2b-08d77daaf611
X-MS-TrafficTypeDiagnostic: MWHPR12MB1872:|MWHPR12MB1872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1872B2DE08BB112437F44A71EA5B0@MWHPR12MB1872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 02475B2A01
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(199004)(189003)(52314003)(2906002)(33964004)(66946007)(52116002)(66576008)(66476007)(186003)(6486002)(110136005)(66556008)(31696002)(316002)(86362001)(2616005)(4326008)(6512007)(53546011)(81166006)(81156014)(478600001)(6506007)(36756003)(8676002)(235185007)(8936002)(6666004)(31686004)(6636002)(5660300002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1872;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6HeCanivXsqiNpnUAaCBTgk1Zse2ilRu5MQAii9ZMWD2ohmj8e+NhrymZSHaYCogPos05IHZXIM7wNuCywDeTXm04El3kJDWd0JMFlTkH5Mc05mXGUGsxrNv5GigWnDapYKuaob6doH81txxqCPomCK9HgKq4jgkBjDgKeVznjhHUYepcMgauFrjOGUqeZGdDCGKXJPK2mUoAfT3IHKlTO6kJA1r6+JdHVqD00ngUiP6UwzdsqS2dWWCoRe3Havyje4p4t56bJrOACeKVmkdx11+knDb3YSE39Gl8HFB1qzXipW6iqbYLl6R7UMx5Z/Vy02lHJ7Xf1QAScZtqc83DxsZ7SH+AARlcmEUW+nhk4+FxxTuYa9Bb0M1WNYqHtgzI9ZKCxCN7VdypuO+W/c+mhDDfZ9K4KYUca7jofW5fKMPlr3C0p7auZq7kxyUcWj+zwYTXZiH6ROoNUTdEamw97GR6n/MSWyH9bhlhL7ZYNNY81Uf+ycDyO1iZ6+sd7GRh7nF9K3V683NjU+ED+CUw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bf615a-a23c-4c98-9d2b-08d77daaf611
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 19:55:52.6644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKh1gjxS9FjCKk88GL0Eg5wFZkipxsa08qIH42hmMLx2GsDD6ZhuDwMOXO+qshTpWLWj8xlQJLTVlUAWT5HsBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1872
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------50E3D602A9B73C0ABCC3BDFB
Content-Type: multipart/alternative;
 boundary="------------DEF9126046D3D5559DD77C0B"

--------------DEF9126046D3D5559DD77C0B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I switched the workqueue we were using for xgmi_reset_work from 
system_highpri_wq to system_unbound_wq - the difference is that workers 
servicing the queue in system_unbound_wq are not bounded to specific CPU 
and so the reset jobs for each XGMI node are getting scheduled to 
different CPU while system_highpri_wq is a bounded work queue. I traced 
it as bellow for 10 consecutive times and didn't see errors any more. 
Also the time diff between BACO entries or exits was never more then 
around 2 uS.

Please give this updated patchset a try

    kworker/u16:2-57    [004] ...1   243.276312: trace_code: func: 
vega20_baco_set_state, line 91 <----- - Before BEACO enter
            <...>-60    [007] ...1   243.276312: trace_code: func: 
vega20_baco_set_state, line 91 <----- - Before BEACO enter
    kworker/u16:2-57    [004] ...1   243.276384: trace_code: func: 
vega20_baco_set_state, line 105 <----- - After BEACO enter done
            <...>-60    [007] ...1   243.276392: trace_code: func: 
vega20_baco_set_state, line 105 <----- - After BEACO enter done
    kworker/u16:3-60    [007] ...1   243.276397: trace_code: func: 
vega20_baco_set_state, line 108 <----- - Before BEACO exit
    kworker/u16:2-57    [004] ...1   243.276399: trace_code: func: 
vega20_baco_set_state, line 108 <----- - Before BEACO exit
    kworker/u16:3-60    [007] ...1   243.288067: trace_code: func: 
vega20_baco_set_state, line 114 <----- - After BEACO exit done
    kworker/u16:2-57    [004] ...1   243.295624: trace_code: func: 
vega20_baco_set_state, line 114 <----- - After BEACO exit done

Andrey

On 12/9/19 9:45 PM, Ma, Le wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> I’m fine with your solution if synchronization time interval satisfies 
> BACO requirements and loop test can pass on XGMI system.
>
> Regards,
>
> Ma Le
>
> *From:*Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> *Sent:* Monday, December 9, 2019 11:52 PM
> *To:* Ma, Le <Le.Ma@amd.com>; amd-gfx@lists.freedesktop.org; Zhou1, 
> Tao <Tao.Zhou1@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhang, 
> Hawking <Hawking.Zhang@amd.com>
> *Cc:* Chen, Guchun <Guchun.Chen@amd.com>
> *Subject:* Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset 
> support for XGMI
>
> Thanks a lot Ma for trying - I think I have to have my own system to 
> debug this so I will keep trying enabling XGMI - i still think the is 
> the right and the generic solution for multiple nodes reset 
> synchronization and in fact the barrier should also be used for 
> synchronizing PSP mode 1 XGMI reset too.
>
> Andrey
>
> On 12/9/19 6:34 AM, Ma, Le wrote:
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     Hi Andrey,
>
>     I tried your patches on my 2P XGMI platform. The baco can work at
>     most time, and randomly got following error:
>
>     [ 1701.542298] amdgpu: [powerplay] Failed to send message 0x25,
>     response 0x0
>
>     This error usually means some sync issue exist for xgmi baco case.
>     Feel free to debug your patches on my XGMI platform.
>
>     Regards,
>
>     Ma Le
>
>     *From:*Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>     <mailto:Andrey.Grodzovsky@amd.com>
>     *Sent:* Saturday, December 7, 2019 5:51 AM
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
>     Hey Ma, attached a solution - it's just compiled as I still can't
>     make my XGMI setup work (with bridge connected only one device is
>     visible to the system while the other is not). Please try it on
>     your system if you have a chance.
>
>     Andrey
>
>     On 12/4/19 10:14 PM, Ma, Le wrote:
>
>         AFAIK it's enough for even single one node in the hive to to
>         fail the enter the BACO state on time to fail the entire hive
>         reset procedure, no ?
>
>         [Le]: Yeah, agree that. I’ve been thinking that make all nodes
>         entering baco simultaneously can reduce the possibility of
>         node failure to enter/exit BACO risk. For example, in an XGMI
>         hive with 8 nodes, the total time interval of 8 nodes
>         enter/exit BACO on 8 CPUs is less than the interval that 8
>         nodes enter BACO serially and exit BACO serially depending on
>         one CPU with yield capability. This interval is usually strict
>         for BACO feature itself. Anyway, we need more looping test
>         later on any method we will choose.
>
>         Any way - I see our discussion blocks your entire patch set -
>         I think you can go ahead and commit yours way (I think you got
>         an RB from Hawking) and I will look then and see if I can
>         implement my method and if it works will just revert your patch.
>
>         [Le]: OK, fine.
>
>         Andrey
>

--------------DEF9126046D3D5559DD77C0B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>I switched the workqueue we were using for xgmi_reset_work from
      system_highpri_wq to system_unbound_wq - the difference is that
      workers servicing the queue in system_unbound_wq are not bounded
      to specific CPU and so the reset jobs for each XGMI node are
      getting scheduled to different CPU while system_highpri_wq is a
      bounded work queue. I traced it as bellow for 10 consecutive times
      and didn't see errors any more. Also the time diff between BACO
      entries or exits was never more then around 2 uS. <br>
    </p>
    <p>Please give this updated patchset a try</p>
    <p>&nbsp;&nbsp; kworker/u16:2-57&nbsp;&nbsp;&nbsp; [004] ...1&nbsp;&nbsp; 243.276312: trace_code: func:
      vega20_baco_set_state, line 91 &lt;----- - Before BEACO enter<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;...&gt;-60&nbsp;&nbsp;&nbsp; [007] ...1&nbsp;&nbsp; 243.276312: trace_code:
      func: vega20_baco_set_state, line 91 &lt;----- - Before BEACO
      enter<br>
      &nbsp;&nbsp; kworker/u16:2-57&nbsp;&nbsp;&nbsp; [004] ...1&nbsp;&nbsp; 243.276384: trace_code: func:
      vega20_baco_set_state, line 105 &lt;----- - After BEACO enter done<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;...&gt;-60&nbsp;&nbsp;&nbsp; [007] ...1&nbsp;&nbsp; 243.276392: trace_code:
      func: vega20_baco_set_state, line 105 &lt;----- - After BEACO
      enter done<br>
      &nbsp;&nbsp; kworker/u16:3-60&nbsp;&nbsp;&nbsp; [007] ...1&nbsp;&nbsp; 243.276397: trace_code: func:
      vega20_baco_set_state, line 108 &lt;----- - Before BEACO exit<br>
      &nbsp;&nbsp; kworker/u16:2-57&nbsp;&nbsp;&nbsp; [004] ...1&nbsp;&nbsp; 243.276399: trace_code: func:
      vega20_baco_set_state, line 108 &lt;----- - Before BEACO exit<br>
      &nbsp;&nbsp; kworker/u16:3-60&nbsp;&nbsp;&nbsp; [007] ...1&nbsp;&nbsp; 243.288067: trace_code: func:
      vega20_baco_set_state, line 114 &lt;----- - After BEACO exit done<br>
      &nbsp;&nbsp; kworker/u16:2-57&nbsp;&nbsp;&nbsp; [004] ...1&nbsp;&nbsp; 243.295624: trace_code: func:
      vega20_baco_set_state, line 114 &lt;----- - After BEACO exit done</p>
    <p>Andrey<br>
    </p>
    <div class="moz-cite-prefix">On 12/9/19 9:45 PM, Ma, Le wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB4285B04000E228E467F8004BF65B0@MN2PR12MB4285.namprd12.prod.outlook.com">
      
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
      <p class="msipheadera92e061b" style="margin:0" align="Left"><span style="font-size:10.0pt;font-family:Arial;color:#0078D7">[AMD
          Official Use Only - Internal Distribution Only]</span></p>
      <br>
      <div class="WordSection1">
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">I’m fine with your
            solution if synchronization time interval satisfies BACO
            requirements and loop test can pass on XGMI system.<o:p></o:p></span></p>
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
                <b>Sent:</b> Monday, December 9, 2019 11:52 PM<br>
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
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">Hi Andrey,</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">&nbsp;</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">I tried your
              patches on my 2P XGMI platform. The baco can work at most
              time, and randomly got following error:</span><o:p></o:p></p>
          <p class="MsoNormal" style="margin-left:.5in"><span style="font-size:12.0pt;color:windowtext">[ 1701.542298]
              amdgpu: [powerplay] Failed to send message 0x25, response
              0x0</span><o:p></o:p></p>
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
          <p>Hey Ma, attached a solution - it's just compiled as I still
            can't make my XGMI setup work (with bridge connected only
            one device is visible to the system while the other is not).
            Please try it on your system if you have a chance.
            <o:p></o:p></p>
          <p>Andrey<o:p></o:p></p>
          <div>
            <p class="MsoNormal">On 12/4/19 10:14 PM, Ma, Le wrote:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p>AFAIK it's enough for even single one node in the hive to
              to fail the enter the BACO state on time to fail the
              entire hive reset procedure, no ?<o:p></o:p></p>
            <p class="MsoNormal" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><span style="font-size:12.0pt;color:#203864">[Le]: Yeah, agree
                that. I’ve been thinking that make all nodes entering
                baco simultaneously can reduce the possibility of node
                failure to enter/exit BACO risk. For example, in an XGMI
                hive with 8 nodes, the total time interval of 8 nodes
                enter/exit BACO on 8 CPUs is less than the interval that
                8 nodes enter BACO serially and exit BACO serially
                depending on one CPU with yield capability. This
                interval is usually strict for BACO feature itself.
                Anyway, we need more looping test later on any method we
                will choose.</span><o:p></o:p></p>
            <p>Any way - I see our discussion blocks your entire patch
              set - I think you can go ahead and commit yours way (I
              think you got an RB from Hawking) and I will look then and
              see if I can implement my method and if it works will just
              revert your patch.<o:p></o:p></p>
            <p><span style="font-size:12.0pt;color:#203864">[Le]: OK,
                fine.</span><o:p></o:p></p>
            <p>Andrey<o:p></o:p></p>
          </blockquote>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------DEF9126046D3D5559DD77C0B--

--------------50E3D602A9B73C0ABCC3BDFB
Content-Type: text/x-patch;
 name="0003-drm-amdgpu-Redo-concurrent-support-of-BACO-reset-for.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-drm-amdgpu-Redo-concurrent-support-of-BACO-reset-for.pa";
 filename*1="tch"

From 8fcefad4194358ad55aba815cab437459f4bb0e4 Mon Sep 17 00:00:00 2001
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Date: Fri, 6 Dec 2019 13:19:15 -0500
Subject: drm/amdgpu: Redo concurrent support of BACO reset for XGMI V2

Use task barrier in XGMI hive to synchronize BACO enter/exit
across devices in XGMI hive.
This also reverts commit b01245ff54db66073b104ac9d9fbefb7b264b36d.

v2: Switch from system_highpri_wq to system_unbound_wq to avoid
queueing jobs to same CPU.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 113 +++++++++++------------------
 2 files changed, 44 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a78a363..50bab33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1001,8 +1001,6 @@ struct amdgpu_device {
 
 	bool                            pm_sysfs_en;
 	bool                            ucode_sysfs_en;
-
-	bool				in_baco;
 };
 
 static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7324a5f..e2b4882 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -67,6 +67,7 @@
 #include "amdgpu_tmz.h"
 
 #include <linux/suspend.h>
+#include <drm/task_barrier.h>
 
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
@@ -2664,13 +2665,39 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 	struct amdgpu_device *adev =
 		container_of(__work, struct amdgpu_device, xgmi_reset_work);
 
-	if (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)
-		adev->asic_reset_res = (adev->in_baco == false) ?
-				amdgpu_device_baco_enter(adev->ddev) :
-				amdgpu_device_baco_exit(adev->ddev);
-	else
-		adev->asic_reset_res = amdgpu_asic_reset(adev);
+	/*
+	 * Use task barrier to synchronize all xgmi reset works across the
+	 * hive.
+	 * task_barrier_enter and task_barrier_exit will block untill all the
+	 * threads running the xgmi reset works reach those points. I assume
+	 * guarantee of progress here for all the threads as the workqueue code
+	 * creates new worker threads as needed by amount of work items in queue
+	 * (see worker_thread) and also each thread sleeps in the barrir and by
+	 * this yielding the CPU for other work threads to make progress.
+	 */
+	if (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
+		struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, 0);
+
+		if (hive)
+			task_barrier_enter(&hive->tb);
+
+		adev->asic_reset_res = amdgpu_device_baco_enter(adev->ddev);
+
+		if (adev->asic_reset_res)
+			goto fail;
 
+		if (hive)
+			task_barrier_exit(&hive->tb);
+
+		adev->asic_reset_res = amdgpu_device_baco_exit(adev->ddev);
+
+		if (adev->asic_reset_res)
+			goto fail;
+	} else {
+		adev->asic_reset_res =  amdgpu_asic_reset(adev);
+	}
+
+fail:
 	if (adev->asic_reset_res)
 		DRM_WARN("ASIC reset failed with error, %d for drm dev, %s",
 			 adev->asic_reset_res, adev->ddev->unique);
@@ -3796,18 +3823,13 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	return r;
 }
 
-static int amdgpu_do_asic_reset(struct amdgpu_device *adev,
-			       struct amdgpu_hive_info *hive,
+static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 			       struct list_head *device_list_handle,
 			       bool *need_full_reset_arg)
 {
 	struct amdgpu_device *tmp_adev = NULL;
 	bool need_full_reset = *need_full_reset_arg, vram_lost = false;
 	int r = 0;
-	int cpu = smp_processor_id();
-	bool use_baco =
-		(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
-		true : false;
 
 	/*
 	 * ASIC reset has to be done on all HGMI hive nodes ASAP
@@ -3815,62 +3837,22 @@ static int amdgpu_do_asic_reset(struct amdgpu_device *adev,
 	 */
 	if (need_full_reset) {
 		list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
-			/*
-			 * For XGMI run all resets in parallel to speed up the
-			 * process by scheduling the highpri wq on different
-			 * cpus. For XGMI with baco reset, all nodes must enter
-			 * baco within close proximity before anyone exit.
-			 */
+			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-				if (!queue_work_on(cpu, system_highpri_wq,
-						   &tmp_adev->xgmi_reset_work))
+				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
-				cpu = cpumask_next(cpu, cpu_online_mask);
 			} else
 				r = amdgpu_asic_reset(tmp_adev);
-			if (r)
-				break;
-		}
 
-		/* For XGMI wait for all work to complete before proceed */
-		if (!r) {
-			list_for_each_entry(tmp_adev, device_list_handle,
-					    gmc.xgmi.head) {
-				if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-					flush_work(&tmp_adev->xgmi_reset_work);
-					r = tmp_adev->asic_reset_res;
-					if (r)
-						break;
-					if (use_baco)
-						tmp_adev->in_baco = true;
-				}
-			}
-		}
-
-		/*
-		 * For XGMI with baco reset, need exit baco phase by scheduling
-		 * xgmi_reset_work one more time. PSP reset and sGPU skips this
-		 * phase. Not assume the situation that PSP reset and baco reset
-		 * coexist within an XGMI hive.
-		 */
-
-		if (!r && use_baco) {
-			cpu = smp_processor_id();
-			list_for_each_entry(tmp_adev, device_list_handle,
-					    gmc.xgmi.head) {
-				if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-					if (!queue_work_on(cpu,
-						system_highpri_wq,
-						&tmp_adev->xgmi_reset_work))
-						r = -EALREADY;
-					if (r)
-						break;
-					cpu = cpumask_next(cpu, cpu_online_mask);
-				}
+			if (r) {
+				DRM_ERROR("ASIC reset failed with error, %d for drm dev, %s",
+					 r, tmp_adev->ddev->unique);
+				break;
 			}
 		}
 
-		if (!r && use_baco) {
+		/* For XGMI wait for all PSP resets to complete before proceed */
+		if (!r) {
 			list_for_each_entry(tmp_adev, device_list_handle,
 					    gmc.xgmi.head) {
 				if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
@@ -3878,21 +3860,15 @@ static int amdgpu_do_asic_reset(struct amdgpu_device *adev,
 					r = tmp_adev->asic_reset_res;
 					if (r)
 						break;
-					tmp_adev->in_baco = false;
 				}
 			}
 		}
-
-		if (r) {
-			DRM_ERROR("ASIC reset failed with error, %d for drm dev, %s",
-				 r, tmp_adev->ddev->unique);
-			goto end;
-		}
 	}
 
 	if (!r && amdgpu_ras_intr_triggered())
 		amdgpu_ras_intr_cleared();
 
+
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		if (need_full_reset) {
 			/* post card */
@@ -4181,8 +4157,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (r)
 			adev->asic_reset_res = r;
 	} else {
-		r  = amdgpu_do_asic_reset(adev, hive, device_list_handle,
-					  &need_full_reset);
+		r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset);
 		if (r && r == -EAGAIN)
 			goto retry;
 	}
-- 
2.7.4


--------------50E3D602A9B73C0ABCC3BDFB
Content-Type: text/x-patch;
 name="0002-drm-amdgpu-Add-task-barrier-to-XGMI-hive.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-drm-amdgpu-Add-task-barrier-to-XGMI-hive.patch"

From da9d5b4ceb7b0f985574617acae71261f9006238 Mon Sep 17 00:00:00 2001
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Date: Fri, 6 Dec 2019 12:43:30 -0500
Subject: drm/amdgpu: Add task barrier to XGMI hive.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 61d13d8..5cf920d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -261,6 +261,7 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lo
 	INIT_LIST_HEAD(&tmp->device_list);
 	mutex_init(&tmp->hive_lock);
 	mutex_init(&tmp->reset_lock);
+	task_barrier_init(&tmp->tb);
 
 	if (lock)
 		mutex_lock(&tmp->hive_lock);
@@ -408,6 +409,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	top_info->num_nodes = count;
 	hive->number_devices = count;
 
+	task_barrier_add_task(&hive->tb);
+
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			/* update node list for other device in the hive */
@@ -470,6 +473,7 @@ void amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 		mutex_destroy(&hive->hive_lock);
 		mutex_destroy(&hive->reset_lock);
 	} else {
+		task_barrier_rem_task(&hive->tb);
 		amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
 		mutex_unlock(&hive->hive_lock);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index bbf504f..74011fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -22,6 +22,7 @@
 #ifndef __AMDGPU_XGMI_H__
 #define __AMDGPU_XGMI_H__
 
+#include <drm/task_barrier.h>
 #include "amdgpu_psp.h"
 
 struct amdgpu_hive_info {
@@ -33,6 +34,7 @@ struct amdgpu_hive_info {
 	struct device_attribute dev_attr;
 	struct amdgpu_device *adev;
 	int pstate; /*0 -- low , 1 -- high , -1 unknown*/
+	struct task_barrier tb;
 };
 
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lock);
-- 
2.7.4


--------------50E3D602A9B73C0ABCC3BDFB
Content-Type: text/x-patch;
 name="0001-drm-Add-Reusable-task-barrier.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-drm-Add-Reusable-task-barrier.patch"

From 34438a766a83002057ac051e3efdcc63eda36f52 Mon Sep 17 00:00:00 2001
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Date: Fri, 6 Dec 2019 12:26:33 -0500
Subject: drm: Add Reusable task barrier.

It is used to synchronize N threads at a rendevouz point before execution
of critical code that has to be started by all the threads at approximatly
the same time.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 include/drm/task_barrier.h | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 include/drm/task_barrier.h

diff --git a/include/drm/task_barrier.h b/include/drm/task_barrier.h
new file mode 100644
index 0000000..858cd7f
--- /dev/null
+++ b/include/drm/task_barrier.h
@@ -0,0 +1,97 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include <linux/semaphore.h>
+#include <linux/atomic.h>
+
+/*
+ * Reusable 2 PHASE task barrier (randevouz point) implementation for N tasks.
+ * Based on the Little book of sempahores - https://greenteapress.com/wp/semaphores/
+ */
+
+
+
+#ifndef DRM_TASK_BARRIER_H_
+#define DRM_TASK_BARRIER_H_
+
+/*
+ * Represents an instance of a task barrier.
+ */
+struct task_barrier {
+	unsigned int n;
+	atomic_t count;
+	struct semaphore enter_turnstile;
+	struct semaphore exit_turnstile;
+};
+
+static inline void task_barrier_signal_turnstile(struct semaphore *turnstile,
+					  unsigned int n) {
+	int i;
+	for (i = 0 ; i < n; i++)
+		up(turnstile);
+}
+
+static inline void task_barrier_init(struct task_barrier *tb) {
+
+	tb->n = 0;
+	atomic_set(&tb->count, 0);
+	sema_init(&tb->enter_turnstile, 0);
+	sema_init(&tb->exit_turnstile, 0);
+}
+
+static inline void task_barrier_add_task(struct task_barrier *tb) {
+	tb->n++;
+}
+
+static inline void task_barrier_rem_task(struct task_barrier *tb) {
+	tb->n--;
+}
+
+/*
+ * Lines up all the threads BEFORE the critical point.
+ *
+ * When all thread passed this code the entry barrier is back to locked state.
+ */
+static inline void task_barrier_enter(struct task_barrier *tb) {
+
+	if (atomic_inc_return(&tb->count) == tb->n)
+			task_barrier_signal_turnstile(&tb->enter_turnstile,
+						      tb->n);
+
+	down(&tb->enter_turnstile);
+}
+
+/*
+ * Lines up all the threads AFTER the critical point.
+ *
+ * This function is used to avoid any one thread running ahead of the reset if
+ * the barrier is used in a loop (repeatedly) .
+ */
+static inline void task_barrier_exit(struct task_barrier *tb) {
+	if (atomic_dec_return(&tb->count) == 0)
+			task_barrier_signal_turnstile(&tb->exit_turnstile,
+						      tb->n);
+
+	down(&tb->exit_turnstile);
+}
+
+#endif
-- 
2.7.4


--------------50E3D602A9B73C0ABCC3BDFB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--------------50E3D602A9B73C0ABCC3BDFB--
