Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1268C3F2C0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C75246A1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FWwPr0yZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C75246A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BACF16E0FC;
	Thu, 27 Feb 2020 21:14:03 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750089.outbound.protection.outlook.com [40.107.75.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0666E0FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 21:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vwibk9yJtEoNmWvSAnj0O6NZEqhkoFy8sWnqZGiTaKPMsDprXwL+QF1QtljRWC4ogPrbIFjQctTzym94LZrbAttwDHjSbkoGC+jw8gEVFfUkn9+siT+jFDcuaKG5c9542fm+Jvaq1Koonm7ggR2sz/F+Z9CgwYfwyHsQfksyIsSJ0YyD7jY9aRf4izrp4GVnbYUOQcIBJXFshfyjPIFxy/cDbsP1RL88Pk6J0IHgtXib7BAdtgxsx88fZM76oE+c1rcCL5Srih+ANzyEWN0ZgIbBNkgckZL0xAUvIx46DR1j8q+f3mXaCNdLKapywiEeMyERuGzTyZlC350OtSs6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gxq6d/hfpS/Twva12c0Ifj3tSHiiFodgqA84FymuIYA=;
 b=g6K+XmPNGQcEpMy5h464WySK99YGTzEWfBFd9IF62rXlOvbtERHSIXSNY+3pD1YJJ4dq9+YqaaSDS3jTs8mabpzv8x0gwjfjRRTKwzTcUwroADNxaLAi5SgIZ/kTSrjboFvC6VAFLoZlYTMP61U5MOCjfSlTAyp6zxX94+LjLqxpKf9uWxU4qG4eFpEzz4XwAKlXsZ40vrtkZjmAeO4BeRiGp1geSHhEH0zzjbYxPYJkespYIRtotELfU0M1ZSv3SoVknMeFyV1uhRqmHonGx0krTIP19T+DDtG2n+pChfNIK6OgHSNh9Simg0GlkfINKLNgN2PWH4DUjZLxNShXag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gxq6d/hfpS/Twva12c0Ifj3tSHiiFodgqA84FymuIYA=;
 b=FWwPr0yZ23ic0L68oAXVM+BMwsOmeCSA3F03bEICSonMM40dXkjJsnyMkI77sERmYCJP9kTTa7V/2GQo5ltaL2XGzs/s4A1cLjxLgY6wFZLGzfrvfxT2mb0uY0v+6Jr6bNKTmo05Z6cG1VUYtVVvOJyrsB2rpSpgrivcw8h/d1w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB2374.namprd12.prod.outlook.com (2603:10b6:4:b4::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Thu, 27 Feb 2020 21:14:00 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 21:14:00 +0000
Subject: Re: [RFC PATCH 2/3] drm/amdgpu: change hw sched list on ctx priority
 override
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200226203730.4621-1-nirmoy.das@amd.com>
 <20200226203730.4621-3-nirmoy.das@amd.com>
 <2c8957cf-f4b5-2b65-acb6-d366c2fbc656@amd.com>
 <CADnq5_PPqDGn2rP6ep6aEHgjow5mkKUp1=FLLo_mDn-QEsN1KA@mail.gmail.com>
 <31b82a5a-4767-1a4b-b74c-61179a52b9e8@amd.com>
 <CADnq5_Ofp64uFjWQzzVdyc0tKPU+KsOm8um5AYWgJsLAuf25YQ@mail.gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <1c9b765c-3975-6d8c-9f8f-588bbd05bcbf@amd.com>
Date: Thu, 27 Feb 2020 22:17:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <CADnq5_Ofp64uFjWQzzVdyc0tKPU+KsOm8um5AYWgJsLAuf25YQ@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::6) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2a:b800:8c:b0f3:cb6e:896b]
 (2003:c5:8f2a:b800:8c:b0f3:cb6e:896b) by
 ZR0P278CA0019.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 21:13:58 +0000
X-Originating-IP: [2003:c5:8f2a:b800:8c:b0f3:cb6e:896b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b39c1dde-a256-40d2-9fc2-08d7bbc9f6b9
X-MS-TrafficTypeDiagnostic: DM5PR12MB2374:|DM5PR12MB2374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2374D7EDD40308184F11A6178BEB0@DM5PR12MB2374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(189003)(199004)(6666004)(8676002)(4326008)(6916009)(5660300002)(31686004)(478600001)(81166006)(52116002)(8936002)(66476007)(81156014)(2906002)(186003)(36756003)(6486002)(66556008)(2616005)(54906003)(316002)(66946007)(31696002)(53546011)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2374;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4BWHbPdS9uweYLrjoli+3PlNA1u4lEoqEm28iQUjp5HoTuZscV/9gD028xmg8iOVfh02WCZZag90ONOtgWUZEROtzlazLTwUuPz19PGehGbHBR+K+IbNaUoAdyT9kN/rw2w5KK1scjuKOZbnbcz1m4ZvPdQGkH6k+TmbWCDoD3gc7R+eOyQPehyh68n0zMZAxmKrO5eU75QJkDfviXc4Ut08ncCHCOC1H6+HswBK4d8O6WcTk+ZCjYjCoxFV6syoWJ3eyx8lurHOQa5ke3ySQRRb2FQ5n5ZXgcckmrFJ6ReRbXpXVY3kEq+1Ea4AwawGKanHoD/sLSEeC/0k3VrMsexW4qNmufqwI0M+IePB0FnYbbToXzdV6V8xzHS9VHVHty3nrovVDufSyNEp4fR+7I1pgcBQGEu9JcUVHhwhBFEUpgMblHg14xOcjRXJLFUL
X-MS-Exchange-AntiSpam-MessageData: I8W5i+Zc7DQEycZk39ukh7OQsEXpu0Q5/QdiQ9Azoik0+aUGX+W8QfImoXuD4/0tsI5LlPIzFBcDp9W0MNqNgFwEoEtSPSPfq7zOcQX+/FwHMNvNMqldebRQG9NfIQJp8qONRCcb+nwXB1w/1eHzU319mz7h2yHny0ag2h69gAaujMIB+p5js9ptxuYraehNsCCcMkGQekA3yiVFKCjdRg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39c1dde-a256-40d2-9fc2-08d7bbc9f6b9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 21:13:59.9834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NW8yevTkiOLVXIE/7kPyKceeAA/FUiEAi8kMdypwlZ9G0JDbmTVUc/ArfyYjn3vc7QuX9WXmB0D0QAWKblHCXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2374
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
Cc: Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Huang Rui <Ray.Huang@amd.com>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/27/20 10:02 PM, Alex Deucher wrote:
> On Thu, Feb 27, 2020 at 3:28 PM Nirmoy <nirmodas@amd.com> wrote:
>>
>> On 2/27/20 3:35 PM, Alex Deucher wrote:
>>> We shouldn't be changing this at runtime.  We need to set up the queue
>>> priority at init time and then schedule to the appropriate quueue at
>>> runtime.  We set the pipe/queue priority in the mqd (memory queue
>>> descriptor).  When we init the rings we configure the mqds in memory
>>> and then tell the CP to configure the rings.  The CP then fetches the
>>> config from memory (the mqd) and pushes the configuration to the hqd
>>> (hardware queue descriptor).  Currrently we just statically set up the
>>> queues at driver init time, but the hw has the capability to schedule
>>> queues dynamically at runtime.  E.g., we could have a per process mqd
>>> for each queue and then tell the CP to schedule the mqd on the
>>> hardware at runtime.  For now, I think we should just set up some
>>> static pools of rings (e.g., normal and high priority or low, normal,
>>> and high priorities).  Note that you probably want to keep the high
>>> priority queues on a different pipe from the low/normal priority
>>> queues.  Depending on the asic there are 1 or 2 MECs (compute micro
>>> engines) and each MEC supports 4 pipes.  Each pipe can handle up to 8
>>> queues.
>> After some debugging I realized we have amdgpu_gfx_compute_queue_acquire()
>>
>> which forces amdgpu to only use queue 0,1 of every pipe form MEC 0 even
>> if we
>>
>> have more than 1 MEC.
>>
> IIRC, that is to spread the queues across as many pipes as possible.
okay
>
>> Does it make sense to have two high priority queue on the same pipe ?
> Good question.  Not sure what the best option is for splitting up the
> queues.  Maybe one set of queues (low and high) per pipe?

I think a low and high priority queue per pipe should work well AFAIU.


Nirmoy

>
> Alex
>
>> Regards,
>>
>> Nirmoy
>>
>>
>>> Alex
>>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
