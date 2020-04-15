Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E6CC2BA19
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 13:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBCB206F9
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 13:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hDsUkFII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBCB206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5A086E974;
	Wed, 15 Apr 2020 13:36:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B66F6E95F
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 13:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0o6A4tQzt2hjil3QiXJHFA64x8K3ldL8OtRjWe4pYNgeuPfj7TF1lWxCGE9Zo1EQGeaVaKxMsfwq4yAgkXLh0kdEvaRTKOClrTCgz5kWEdFyw/2X+rANOccDm0EaU9hplB4VOg4nFGWpckuC3awT6n/fh0+CbskZ3uKXZ/ocPEAD/NSEZLYwtWJ7xvbPAKVUMI28/fbMFaPMsPGbOaTrvA99KzKkjl4BpnqPOSuC6gQGPH0ZrXyyFw8x5oXTWqlV5TrmSkC6Un4hNuvSNWAnRYoZ2j7JoMWoy82fMZ/VzGtVT0OZ10v+teZ8/8Ru0oy8eUi8r8gnEkd3d3flDT2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiV1r69ZvXtcVCo14fTbLBOwXOgUleBB/KnOSfintT4=;
 b=UN/8BvFJFzJLAcc+RnfwLO9aLVnRA+Hlgwr8CZJ21lIKFnAjk8ABd2Q9FLZJO8lmsu8tmB0YE/qNKUNU/OkuPP+6O7X35ROtxAbvT/4qgydwlgUN64yKjHky4/wMHJzh8xE6mAr6gHr0Urg9fRgc1swfgGS6UWGcUMDhb0DOHjseYsL/M88zdmCffLWu/Ae9r0rEjGdZSTNvFpqRdxC5AGW8Y9kIxD0lS/yjZfLAGpRvtlR9DhAPzWZICVFk41e8qCxwpCtahmpW+hxJ0toOh3TEquf2dk+RsrZsCBEV2q/qK8nSirmAvQH5oYuK6BM9T5PM17JxNbVXUZdPQK5K6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiV1r69ZvXtcVCo14fTbLBOwXOgUleBB/KnOSfintT4=;
 b=hDsUkFIIbKygOpqCfF3c1vWI+u4NH2Yh+0VAcB+fQ0lKgRdirScZwcSRfKrugAZOveOJdOVpeV2wHPvvmEGpuuAKZu5NQJtgExNRS9ft6bTfmy/dHOO82x7qsqJ7nM3gG7a80Kkhe+eHfWVmWWwo1PX9gdFC26MIGtscEDcjgXc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Amber.Lin@amd.com; 
Received: from DM6PR12MB3050.namprd12.prod.outlook.com (2603:10b6:5:11a::14)
 by DM6PR12MB2747.namprd12.prod.outlook.com (2603:10b6:5:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 15 Apr
 2020 13:36:45 +0000
Received: from DM6PR12MB3050.namprd12.prod.outlook.com
 ([fe80::ccad:a531:d193:987c]) by DM6PR12MB3050.namprd12.prod.outlook.com
 ([fe80::ccad:a531:d193:987c%7]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 13:36:45 +0000
Subject: Re: [PATCH v4] drm/amdkfd: Provide SMI events watch
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1586899842-28131-1-git-send-email-Amber.Lin@amd.com>
 <46d5b0c3-2fb3-932e-2ec7-216d693a63d4@amd.com>
 <BN8PR12MB30418878CCC5D2FE5103248DE1DB0@BN8PR12MB3041.namprd12.prod.outlook.com>
 <7442ee3e-9d91-d886-af22-cf00f9ab23a4@amd.com>
 <MN2PR12MB4488B378A20AB052F3A93564F7DB0@MN2PR12MB4488.namprd12.prod.outlook.com>
From: Amber Lin <Amber.Lin@amd.com>
Message-ID: <04d21092-3366-99fa-c792-291b1a7a859a@amd.com>
Date: Wed, 15 Apr 2020 09:36:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <MN2PR12MB4488B378A20AB052F3A93564F7DB0@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::18) To DM6PR12MB3050.namprd12.prod.outlook.com
 (2603:10b6:5:11a::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.38.185] (165.204.54.211) by
 YT1PR01CA0109.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Wed, 15 Apr 2020 13:36:44 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d202808-d31a-41e7-54ae-08d7e1420a0c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2747:|DM6PR12MB2747:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27476523432EB9CAD4BA6770E1DB0@DM6PR12MB2747.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3050.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(16526019)(186003)(21615005)(26005)(16576012)(31686004)(53546011)(19627405001)(956004)(86362001)(966005)(2616005)(31696002)(8936002)(66556008)(5660300002)(66946007)(498600001)(66476007)(110136005)(30864003)(2906002)(81156014)(8676002)(52116002)(19627235002)(36756003)(6486002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1z3qkSGYGPUGutdbmQonwcEVd8NvBSGZr0YG/ACfYRBxqxAB32N6sGhyiqSb9Ylua0aPO4OKbz+dNR1bcuZwhZ7Cuc7ma6l26IIitnWB80Bf1gPvBEgoPzmzO29AyyQgMObwSGKjEFaehdtrUCWKdp4ThFbuzXcQsjI+xDWBW863Gsm7NYiDGcp8szBDhHW/wbdH7cuMhf//SCAcgaAaeR9DIEYpV1iRuI+87/qptkHUMW6WTmMWSWvZJfmTGfy1whIb89X+c/onUX4uNxKT4VZT+QpeetN6gejhlP0ZEwb0SK0HHvmSZ8MHku1O15TstfMcBSm3CKVZ6RcRx23bYTe/u10mdDWIJnkdfxQTk7Xd2+YPz4RaeKKSsnjkP7xgitLAmYkqPCl8oJurAtJ3PwESGYQOEzlWZUvO8XiTRN2W261zMCzD4BPMlB1WN0TtlYpsD2GXkRvdXe4Jekc2F7zMyEfqX4JWT+4W1B4CoF2Yh0cDamHBYC8hXjmlOWHtY5bINDH/EPeElDgUn1mGdA==
X-MS-Exchange-AntiSpam-MessageData: FlsO5bnhLuv4tvqu+U18l+xZZAdMuu4GGYR5tRQOdCfKEOsgcOfbjYNr+323w3XeUGTZ4MpYwKYGW36Rfk/Pvv9gB+yGYORgryy46HCQohMnQsI0f39wmjpzQdjLyFhq8QHZMwn9hj/KXfrT3Foabg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d202808-d31a-41e7-54ae-08d7e1420a0c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 13:36:45.3023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tg9ToLllwsIVN0BY8xDbbGxpVNNilH0gJKCZF9iLnbWTGV1cSs9sY9IJTLf6VVsq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2747
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
Content-Type: multipart/mixed; boundary="===============0913704188=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0913704188==
Content-Type: multipart/alternative;
 boundary="------------1B2D3B198AC459769530DE50"
Content-Language: en-US

--------------1B2D3B198AC459769530DE50
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Thank you Felix. Now I understand the problem of global client ID is 
leaking a hole for potential attackers. I didn't take that into 
consideration. I'll change that following your advice below.

Hi Alex,

Thank you for the link. It's helpful. I have a question regarding the 
versioning. One topic in the article talks about how the userspace can 
figure out if the new ioctl is supported in a given kernel. Is it 
correct that with dkms driver, we use the driver version coming from 
AMDGPU_VERSION in amdgpu_drv.c, and in upstream kernel we use the kernel 
version?

Thanks.

Amber

On 2020-04-14 11:03 p.m., Deucher, Alexander wrote:
>
> [AMD Public Use]
>
>
> Some good advice on getting ioctls right:
> https://www.kernel.org/doc/html/v5.4-preprc-cpu/ioctl/botching-up-ioctls.html
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Felix Kuehling <felix.kuehling@amd.com>
> *Sent:* Tuesday, April 14, 2020 10:40 PM
> *To:* Lin, Amber <Amber.Lin@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH v4] drm/amdkfd: Provide SMI events watch
>
> Hi Amber,
>
> I understand that different processes can get the same FD. My 
> statement about FD being unique is relative to one process.
>
> The main problem with the global client ID is, that it allows process 
> A to change the event mask of process B just by specifying process B's 
> client ID. That can lead to denial of service attacks where process A 
> can cause events not to be delivered to B or can flood process B with 
> frequent events that it's not prepared to handle.
>
> Therefore you must make the lookup of the client from the client ID 
> not from a global list, but from a per-process list. That way process 
> A can only change event masks of process A clients, and not those of 
> any other process.
>
> But if the client list is process-specific, you can use the FD as a 
> unique identifier of the client within the process, so you don't need 
> a separate client ID.
>
> Regards,
>   Felix
>
> Am 2020-04-14 um 8:09 p.m. schrieb Lin, Amber:
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> Hi Felix,
>>
>> That was my assumption too that each registration will get different 
>> file descriptor, but it turns out not. When I started two process and 
>> both register gpu0 and gpu1, they both got fd=15. If I have process A 
>> register gpu0+gpu1, and process B only register gpu0, process A gets 
>> fd=15 and process B gets fd=9. That’s why I added client ID.
>>
>> By multiple clients, I mean multiple processes. The ask is users want 
>> to have multiple tools and those different tools can use rsmi lib to 
>> watch events at the same time. Due to the reason above that two 
>> processes can actually get the same fd and I need to add client ID to 
>> distinguish the registration, I don’t see the point of limiting one 
>> registration per process unless I use pid to distinguish the client 
>> instead, which was in my consideration too when I was writing the 
>> code. But second thought is why adding this restriction when client 
>> ID can allow the tool to watch different events on different devices 
>> if they want to. Maybe client ID is a bad term and it misleads you. I 
>> should call it register ID.
>>
>> Regards,
>>
>> Amber
>>
>> *From:* Kuehling, Felix <Felix.Kuehling@amd.com> 
>> <mailto:Felix.Kuehling@amd.com>
>> *Sent:* Tuesday, April 14, 2020 7:04 PM
>> *To:* Lin, Amber <Amber.Lin@amd.com> <mailto:Amber.Lin@amd.com>; 
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> *Subject:* Re: [PATCH v4] drm/amdkfd: Provide SMI events watch
>>
>> Hi Amber,
>>
>> Some general remarks about the multi-client support. You added a 
>> global client id that's separate from the file descriptor. That's 
>> problematic for two reasons:
>>
>>  1. A process could change a different process' event mask
>>  2. The FD should already be unique per process, no need to invent
>>     another ID
>>
>> If we want to allow one process to register for events multiple times 
>> (multiple FDs per process), then the list of clients should be per 
>> process. Each process should only be allowed to change the event 
>> masks of its own clients. The client could be identified by its FD. 
>> No need for another client ID.
>>
>> But you could also simplify it further by allowing only one event 
>> client per process. Then you don't need the client ID lookup at all. 
>> Just have a single event client in the kfd_process.
>>
>> Another approach would be to make enable/disable functions of the 
>> event FD, rather than the KFD FD ioctl. It could be an ioctl of the 
>> event FD, or even simpler, you could use the write file-operation to 
>> write an event mask (of arbitrary length if you want to enable growth 
>> in the future). That way everything would be neatly encapsulated in 
>> the event FD private data.
>>
>> Two more comments inline ...
>>
>> Am 2020-04-14 um 5:30 p.m. schrieb Amber Lin:
>>
>>     When the compute is malfunctioning or performance drops, the system admin
>>
>>     will use SMI (System Management Interface) tool to monitor/diagnostic what
>>
>>     went wrong. This patch provides an event watch interface for the user
>>
>>     space to register devices and subscribe events they are interested. After
>>
>>     registered, the user can use annoymous file descriptor's poll function
>>
>>     with wait-time specified and wait for events to happen. Once an event
>>
>>     happens, the user can use read() to retrieve information related to the
>>
>>     event.
>>
>>       
>>
>>     VM fault event is done in this patch.
>>
>>       
>>
>>     v2: - remove UNREGISTER and add event ENABLE/DISABLE
>>
>>          - correct kfifo usage
>>
>>          - move event message API to kfd_ioctl.h
>>
>>     v3: send the event msg in text than in binary
>>
>>     v4: support multiple clients
>>
>>       
>>
>>     Signed-off-by: Amber Lin<Amber.Lin@amd.com>  <mailto:Amber.Lin@amd.com>
>>
>> [snip]
>>
>>     diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
>>
>>     index 4f66764..8146437 100644
>>
>>     --- a/include/uapi/linux/kfd_ioctl.h
>>
>>     +++ b/include/uapi/linux/kfd_ioctl.h
>>
>>     @@ -442,6 +442,36 @@ struct kfd_ioctl_import_dmabuf_args {
>>
>>        __u32 dmabuf_fd;       /* to KFD */
>>
>>       };
>>
>>       
>>
>>     +/*
>>
>>     + * KFD SMI(System Management Interface) events
>>
>>     + */
>>
>>     +enum kfd_smi_events_op {
>>
>>     + KFD_SMI_EVENTS_REGISTER = 1,
>>
>>     + KFD_SMI_EVENTS_ENABLE,
>>
>>     + KFD_SMI_EVENTS_DISABLE
>>
>>     +};
>>
>>     +
>>
>>     +/* Event type (defined by bitmask) */
>>
>>     +#define KFD_SMI_EVENT_VMFAULT     0x0000000000000001
>>
>>     +
>>
>>     +struct kfd_ioctl_smi_events_args {
>>
>>     + __u32 op;              /* to KFD */
>>
>>     + __u64 events;          /* to KFD */
>>
>> The binary layout of the ioctl args structure should be the same on 
>> 32/64-bit. That means the 64-bit members should be 64-bit aligned. 
>> The best way to ensure this is to put all the 64-bit members first.
>>
>>       
>>
>>     + __u64 gpuids_array_ptr;        /* to KFD */
>>
>>     + __u32 num_gpuids;      /* to KFD */
>>
>>     + __u32 anon_fd;         /* from KFD */
>>
>>     + __u32 client_id;       /* to/from KFD */
>>
>>     +};
>>
>>     +
>>
>>     +/* 1. All messages must start with (hex)uint64_event(16) + space(1) +
>>
>>     + *    (hex)gpuid(8) + space(1) =  26 bytes
>>
>>     + * 2. VmFault msg = (hex)uint32_pid(8) + space(1) + task name(16) = 25
>>
>>     + *    When a new event msg uses more memory, change the calculation here.
>>
>>     + * 3. End with \n(1)
>>
>>     + * 26 + 25 + 1 = 52
>>
>>     + */
>>
>>     +#define KFD_SMI_MAX_EVENT_MSG 52
>>
>> If you define the maximum message length here, clients may start 
>> depending on it, and it gets harder to change it later. I'd not 
>> define this in the API header. It's not necessary to write correct 
>> clients. And if used badly, it may encourage writing incorrect 
>> clients that break with longer messages in the future.
>>
>> Regards,
>>   Felix
>>
>>       
>>
>>     +
>>
>>       /* Register offset inside the remapped mmio page
>>
>>        */
>>
>>       enum kfd_mmio_remap {
>>
>>     @@ -546,7 +576,10 @@ enum kfd_mmio_remap {
>>
>>       #define AMDKFD_IOC_ALLOC_QUEUE_GWS            \
>>
>>               AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)
>>
>>       
>>
>>     +#define AMDKFD_IOC_SMI_EVENTS                 \
>>
>>     +        AMDKFD_IOWR(0x1F, struct kfd_ioctl_smi_events_args)
>>
>>     +
>>
>>       #define AMDKFD_COMMAND_START           0x01
>>
>>     -#define AMDKFD_COMMAND_END             0x1F
>>
>>     +#define AMDKFD_COMMAND_END             0x20
>>
>>       
>>
>>       #endif
>>


--------------1B2D3B198AC459769530DE50
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-1252">
  </head>
  <body>
    <font size="&#43;1"><tt>Thank you Felix. Now I understand the problem of
        global client ID is leaking a hole for potential attackers. I
        didn't take that into consideration. I'll change that following
        your advice below.<br>
        <br>
        Hi Alex,<br>
        <br>
        Thank you for the link. It's helpful. I have a question
        regarding the versioning. One topic in the article talks about
        how the userspace can figure out if the new ioctl is supported
        in a given kernel. Is it correct that with dkms driver, we use
        the driver version coming from AMDGPU_VERSION in amdgpu_drv.c,
        and in upstream kernel we use the kernel version?<br>
        <br>
        Thanks.<br>
        <br>
        Amber<br>
      </tt></font><br>
    <div class="moz-cite-prefix">On 2020-04-14 11:03 p.m., Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB4488B378A20AB052F3A93564F7DB0@MN2PR12MB4488.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p style="font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" align="Left">
        [AMD Public Use]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Some good advice on getting ioctls right:</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <a href="https://www.kernel.org/doc/html/v5.4-preprc-cpu/ioctl/botching-up-ioctls.html" id="LPNoLP568680" moz-do-not-send="true">https://www.kernel.org/doc/html/v5.4-preprc-cpu/ioctl/botching-up-ioctls.html</a></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Alex<br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
            behalf of Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a><br>
            <b>Sent:</b> Tuesday, April 14, 2020 10:40 PM<br>
            <b>To:</b> Lin, Amber <a class="moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com">&lt;Amber.Lin@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Subject:</b> Re: [PATCH v4] drm/amdkfd: Provide SMI
            events watch</font>
          <div>&nbsp;</div>
        </div>
        <div>
          <p>Hi Amber,</p>
          <p>I understand that different processes can get the same FD.
            My statement about FD being unique is relative to one
            process.</p>
          <p>The main problem with the global client ID is, that it
            allows process A to change the event mask of process B just
            by specifying process B's client ID. That can lead to denial
            of service attacks where process A can cause events not to
            be delivered to B or can flood process B with frequent
            events that it's not prepared to handle.</p>
          <p>Therefore you must make the lookup of the client from the
            client ID not from a global list, but from a per-process
            list. That way process A can only change event masks of
            process A clients, and not those of any other process.</p>
          <p>But if the client list is process-specific, you can use the
            FD as a unique identifier of the client within the process,
            so you don't need a separate client ID.</p>
          <p>Regards,<br>
            &nbsp; Felix<br>
          </p>
          <div class="x_moz-cite-prefix">Am 2020-04-14 um 8:09 p.m.
            schrieb Lin, Amber:<br>
          </div>
          <blockquote type="cite">
            <meta name="Generator" content="Microsoft Word 15 (filtered
              medium)">
            <style>
<!--
@font-face
	{font-family:PMingLiU}
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:Consolas}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New"}
span.x_HTMLPreformattedChar
	{font-family:Consolas}
p.x_msipheader4d0fcdd7, li.x_msipheader4d0fcdd7, div.x_msipheader4d0fcdd7
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle22
	{font-family:"Arial",sans-serif;
	color:#0078D7}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
ol
	{margin-bottom:0in}
ul
	{margin-bottom:0in}
-->
</style>
            <div class="x_WordSection1">
              <p class="x_msipheader4d0fcdd7" style="margin:0in;
                margin-bottom:.0001pt"><span style="font-size:10.0pt;
                  font-family:&quot;Arial&quot;,sans-serif;
                  color:#0078D7">[AMD Official Use Only - Internal
                  Distribution Only]</span></p>
              <p class="x_MsoNormal">&nbsp;</p>
              <p class="x_MsoNormal">Hi Felix,</p>
              <p class="x_MsoNormal">&nbsp;</p>
              <p class="x_MsoNormal">That was my assumption too that
                each registration will get different file descriptor,
                but it turns out not. When I started two process and
                both register gpu0 and gpu1, they both got fd=15. If I
                have process A register gpu0&#43;gpu1, and process B only
                register gpu0, process A gets fd=15 and process B gets
                fd=9. That’s why I added client ID.</p>
              <p class="x_MsoNormal">&nbsp;</p>
              <p class="x_MsoNormal">By multiple clients, I mean
                multiple processes. The ask is users want to have
                multiple tools and those different tools can use rsmi
                lib to watch events at the same time. Due to the reason
                above that two processes can actually get the same fd
                and I need to add client ID to distinguish the
                registration, I don’t see the point of limiting one
                registration per process unless I use pid to distinguish
                the client instead, which was in my consideration too
                when I was writing the code. But second thought is why
                adding this restriction when client ID can allow the
                tool to watch different events on different devices if
                they want to. Maybe client ID is a bad term and it
                misleads you. I should call it register ID.</p>
              <p class="x_MsoNormal">&nbsp;</p>
              <div>
                <p class="x_MsoNormal">Regards,</p>
                <p class="x_MsoNormal">Amber</p>
              </div>
              <p class="x_MsoNormal">&nbsp;</p>
              <div>
                <div style="border:none; border-top:solid #E1E1E1 1.0pt;
                  padding:3.0pt 0in 0in 0in">
                  <p class="x_MsoNormal"><b>From:</b> Kuehling, Felix <a class="x_moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">
                      &lt;Felix.Kuehling@amd.com&gt;</a> <br>
                    <b>Sent:</b> Tuesday, April 14, 2020 7:04 PM<br>
                    <b>To:</b> Lin, Amber <a class="x_moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com" moz-do-not-send="true">
                      &lt;Amber.Lin@amd.com&gt;</a>; <a class="x_moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                      amd-gfx@lists.freedesktop.org</a><br>
                    <b>Subject:</b> Re: [PATCH v4] drm/amdkfd: Provide
                    SMI events watch</p>
                </div>
              </div>
              <p class="x_MsoNormal">&nbsp;</p>
              <p>Hi Amber,</p>
              <p>Some general remarks about the multi-client support.
                You added a global client id that's separate from the
                file descriptor. That's problematic for two reasons:</p>
              <ol type="1" start="1">
                <li class="x_MsoNormal" style="">A process could change
                  a different process' event mask</li>
                <li class="x_MsoNormal" style="">The FD should already
                  be unique per process, no need to invent another ID</li>
              </ol>
              <p>If we want to allow one process to register for events
                multiple times (multiple FDs per process), then the list
                of clients should be per process. Each process should
                only be allowed to change the event masks of its own
                clients. The client could be identified by its FD. No
                need for another client ID.</p>
              <p>But you could also simplify it further by allowing only
                one event client per process. Then you don't need the
                client ID lookup at all. Just have a single event client
                in the kfd_process.</p>
              <p>Another approach would be to make enable/disable
                functions of the event FD, rather than the KFD FD ioctl.
                It could be an ioctl of the event FD, or even simpler,
                you could use the write file-operation to write an event
                mask (of arbitrary length if you want to enable growth
                in the future). That way everything would be neatly
                encapsulated in the event FD private data.</p>
              <p>Two more comments inline ...</p>
              <p>&nbsp;</p>
              <div>
                <p class="x_MsoNormal">Am 2020-04-14 um 5:30 p.m.
                  schrieb Amber Lin:</p>
              </div>
              <blockquote style="margin-top:5.0pt; margin-bottom:5.0pt">
                <pre>When the compute is malfunctioning or performance drops, the system admin</pre>
                <pre>will use SMI (System Management Interface) tool to monitor/diagnostic what</pre>
                <pre>went wrong. This patch provides an event watch interface for the user</pre>
                <pre>space to register devices and subscribe events they are interested. After</pre>
                <pre>registered, the user can use annoymous file descriptor's poll function</pre>
                <pre>with wait-time specified and wait for events to happen. Once an event</pre>
                <pre>happens, the user can use read() to retrieve information related to the</pre>
                <pre>event.</pre>
                <pre>&nbsp;</pre>
                <pre>VM fault event is done in this patch.</pre>
                <pre>&nbsp;</pre>
                <pre>v2: - remove UNREGISTER and add event ENABLE/DISABLE</pre>
                <pre>&nbsp;&nbsp;&nbsp; - correct kfifo usage</pre>
                <pre>&nbsp;&nbsp;&nbsp; - move event message API to kfd_ioctl.h</pre>
                <pre>v3: send the event msg in text than in binary</pre>
                <pre>v4: support multiple clients</pre>
                <pre>&nbsp;</pre>
                <pre>Signed-off-by: Amber Lin <a href="mailto:Amber.Lin@amd.com" moz-do-not-send="true">&lt;Amber.Lin@amd.com&gt;</a></pre>
              </blockquote>
              <p>[snip]</p>
              <blockquote style="margin-top:5.0pt; margin-bottom:5.0pt">
                <pre>diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h</pre>
                <pre>index 4f66764..8146437 100644</pre>
                <pre>--- a/include/uapi/linux/kfd_ioctl.h</pre>
                <pre>&#43;&#43;&#43; b/include/uapi/linux/kfd_ioctl.h</pre>
                <pre>@@ -442,6 &#43;442,36 @@ struct kfd_ioctl_import_dmabuf_args {</pre>
                <pre>&nbsp; __u32 dmabuf_fd;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */</pre>
                <pre> };</pre>
                <pre> </pre>
                <pre>&#43;/*</pre>
                <pre>&#43; * KFD SMI(System Management Interface) events</pre>
                <pre>&#43; */</pre>
                <pre>&#43;enum kfd_smi_events_op {</pre>
                <pre>&#43; KFD_SMI_EVENTS_REGISTER = 1,</pre>
                <pre>&#43; KFD_SMI_EVENTS_ENABLE,</pre>
                <pre>&#43; KFD_SMI_EVENTS_DISABLE</pre>
                <pre>&#43;};</pre>
                <pre>&#43;</pre>
                <pre>&#43;/* Event type (defined by bitmask) */</pre>
                <pre>&#43;#define KFD_SMI_EVENT_VMFAULT&nbsp;&nbsp;&nbsp;&nbsp; 0x0000000000000001</pre>
                <pre>&#43;</pre>
                <pre>&#43;struct kfd_ioctl_smi_events_args {</pre>
                <pre>&#43; __u32 op;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */</pre>
                <pre>&#43; __u64 events;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */</pre>
              </blockquote>
              <p>The binary layout of the ioctl args structure should be
                the same on 32/64-bit. That means the 64-bit members
                should be 64-bit aligned. The best way to ensure this is
                to put all the 64-bit members first.</p>
              <p class="x_MsoNormal" style="margin-bottom:12.0pt">&nbsp;</p>
              <blockquote style="margin-top:5.0pt; margin-bottom:5.0pt">
                <pre>&nbsp;</pre>
                <pre>&#43; __u64 gpuids_array_ptr;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */</pre>
                <pre>&#43; __u32 num_gpuids;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */</pre>
                <pre>&#43; __u32 anon_fd;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* from KFD */</pre>
                <pre>&#43; __u32 client_id;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to/from KFD */</pre>
                <pre>&#43;};</pre>
                <pre>&#43;</pre>
                <pre>&#43;/* 1. All messages must start with (hex)uint64_event(16) &#43; space(1) &#43;</pre>
                <pre>&#43; *&nbsp;&nbsp;&nbsp; (hex)gpuid(8) &#43; space(1) =&nbsp; 26 bytes</pre>
                <pre>&#43; * 2. VmFault msg = (hex)uint32_pid(8) &#43; space(1) &#43; task name(16) = 25</pre>
                <pre>&#43; *&nbsp;&nbsp;&nbsp; When a new event msg uses more memory, change the calculation here.</pre>
                <pre>&#43; * 3. End with \n(1)</pre>
                <pre>&#43; * 26 &#43; 25 &#43; 1 = 52</pre>
                <pre>&#43; */</pre>
                <pre>&#43;#define KFD_SMI_MAX_EVENT_MSG 52</pre>
              </blockquote>
              <p>If you define the maximum message length here, clients
                may start depending on it, and it gets harder to change
                it later. I'd not define this in the API header. It's
                not necessary to write correct clients. And if used
                badly, it may encourage writing incorrect clients that
                break with longer messages in the future.</p>
              <p>Regards,<br>
                &nbsp; Felix</p>
              <p>&nbsp;</p>
              <blockquote style="margin-top:5.0pt; margin-bottom:5.0pt">
                <pre>&nbsp;</pre>
                <pre>&#43;</pre>
                <pre> /* Register offset inside the remapped mmio page</pre>
                <pre>&nbsp; */</pre>
                <pre> enum kfd_mmio_remap {</pre>
                <pre>@@ -546,7 &#43;576,10 @@ enum kfd_mmio_remap {</pre>
                <pre> #define AMDKFD_IOC_ALLOC_QUEUE_GWS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \</pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)</pre>
                <pre> </pre>
                <pre>&#43;#define AMDKFD_IOC_SMI_EVENTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \</pre>
                <pre>&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOWR(0x1F, struct kfd_ioctl_smi_events_args)</pre>
                <pre>&#43;</pre>
                <pre> #define AMDKFD_COMMAND_START&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01</pre>
                <pre>-#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1F</pre>
                <pre>&#43;#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x20</pre>
                <pre> </pre>
                <pre>&nbsp;#endif</pre>
              </blockquote>
            </div>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------1B2D3B198AC459769530DE50--

--===============0913704188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0913704188==--
