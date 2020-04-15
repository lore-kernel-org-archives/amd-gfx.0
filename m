Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381B3C2BB1D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 02:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A42E2076C
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 02:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qvQ04PNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A42E2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 904C86E824;
	Wed, 15 Apr 2020 02:40:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FC2C6E824
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 02:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkTicX8ubURGm2VQZSKBeNnLlPvtKhZdROt4vv8B75yU4BostY89HPGXvENCdLOq3qU++nKwpI2smJeWspSIxwaBiFhOkZAQ3t1MrU4BJ3ibcO3DoOVDMkQ+4tUOQDm1/29TVUFZn/0eEfYXOv6o+0FrxdyCqSu9KH5vnl2OahVBhQu8QxEumGALVE4DTZOH1Vu5tCvOtoePkbQQ63WjEmp+WPCL1vds/hbicU3PP17S4H6kw8dBPL4Erx6gA2LHPLQYkrbRSwsds5TQ4Sj/Khij8gqlJAHT9iuxPjcAmJUxwZhxxkCQ81uEVdYQ22Ldc8a0ji3a5y4XrgEgTuMgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsiTogWaRAinQbIPxwsw5b2JdP6FTG03MQDsAJ6/1tc=;
 b=QZw+Qakgdzt2bK6gk4sSN5hJATHaAIZlFYG4/mVqGrr08DN92y71f3DwAoYKI6gwmZVB06pK7nAiCXpDVYk/it9UAxRWT6GEzddHvfibYhhovpih+MYf2yUMIIAWVcaThSC6wSl/SKqGG7mxi83sAahqzEuIeR9j2pZsGB9l3QQ7Dz6DPdDMQ/1T4E9vPTKvj4LdnyQlY6im7SSKeI0925Cb3fiZyY8daKSsU4CaRk1eGosw/slLAtfjF5J7i5RGzsovyLbjsS7zCnwNgA0w+/vPVd9tT7bPnOuQ+pm0KPzvMcVDC/LAAq54NE772jJyuC5D2oxmwRCrNSpGbIwNtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsiTogWaRAinQbIPxwsw5b2JdP6FTG03MQDsAJ6/1tc=;
 b=qvQ04PNioOAZzg7XV0lcx5TRswBVewfLb1tfU2pCB7T3oKo8EYa3uFYOvXCI3azNkx5BXS7Rq1+s7AcOj4NAWTAFAsed67KfSYAuzi50t/DI+nu0UUTqwC8NbzvVX8D0qzEV6Y5uyKMJc8sv/w4pDO4w1sFaH77VggnMuWm39wg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2445.namprd12.prod.outlook.com (2603:10b6:802:31::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Wed, 15 Apr
 2020 02:40:49 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 02:40:49 +0000
Subject: Re: [PATCH v4] drm/amdkfd: Provide SMI events watch
To: "Lin, Amber" <Amber.Lin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1586899842-28131-1-git-send-email-Amber.Lin@amd.com>
 <46d5b0c3-2fb3-932e-2ec7-216d693a63d4@amd.com>
 <BN8PR12MB30418878CCC5D2FE5103248DE1DB0@BN8PR12MB3041.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <7442ee3e-9d91-d886-af22-cf00f9ab23a4@amd.com>
Date: Tue, 14 Apr 2020 22:40:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <BN8PR12MB30418878CCC5D2FE5103248DE1DB0@BN8PR12MB3041.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::48) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YQBPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:1::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Wed, 15 Apr 2020 02:40:48 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01259ad4-3fa1-46bb-5f76-08d7e0e66803
X-MS-TrafficTypeDiagnostic: SN1PR12MB2445:|SN1PR12MB2445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2445385FEF302FB9215CE3BD92DB0@SN1PR12MB2445.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(26005)(316002)(33964004)(30864003)(5660300002)(2906002)(6486002)(8936002)(31696002)(66946007)(478600001)(8676002)(52116002)(16576012)(81156014)(86362001)(186003)(44832011)(110136005)(2616005)(956004)(36756003)(66476007)(66556008)(53546011)(16526019)(31686004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxxysOU9zJkpL59E7X3xnxoTB3gpPZjG7Y54tpqi5aiCKACJlItLhfY2cOJtjis9qe8h6u5pycwrQ5Wj7vSOIbhpnUPPMzNK1dZQ7iU9ZQ7WxD/FSdXDbKUPjnDeywcksIHYYYOu+iH9Xj6AwqJEXuRDOx6NJZiNXyijab+hWWUXCnbj/DzfE+3Yfi8es0wdIs4zJBrHQezM9H/ONHfwuJZs8hInftAzimGqaybTPdhDAueaR67/i/0XH6+rSENsl/8fH/MEc6hJis9hwb7VumciCa+poGtOY/SMdnZIiUI6hD2wQShZUgLpcKy8oL2/wZ9j1j4l8mG73U99YXy68F4A3ENmy8nPHHSWTNDjOarYkCPz3Wqce67Xm4/d0DMa4vvYy0UhTaCe50P8CcBto2Dybcpdq3DvIx2cc+SFuPaOlOn46yXbQeijNtmRHk36
X-MS-Exchange-AntiSpam-MessageData: bO8R6D16UEH2Y48so5kBHyXmL4M4jXlBJ74uUjhwfk8j+e/sEVSO6vDOzIEzSLDlO22W1gUN6bEhKHvEizRHDsCeHHWLMNlcls+OD2wQftITx2uO4GEBrgFsGs4oukAgL4ntKRLo6mWcupNuFFeqWQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01259ad4-3fa1-46bb-5f76-08d7e0e66803
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 02:40:49.0374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSlMTQl3qSEajU3evj+gU7dMSQu4/++qxMWVHuDe0Sg4TmuQIxbi5QnmSzdphuSI+noCjUwh+SKAUvCd6UoeWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2445
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
Content-Type: multipart/mixed; boundary="===============1123144423=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1123144423==
Content-Type: multipart/alternative;
 boundary="------------108865A27CFE034C60039C4F"
Content-Language: en-US

--------------108865A27CFE034C60039C4F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Amber,

I understand that different processes can get the same FD. My statement
about FD being unique is relative to one process.

The main problem with the global client ID is, that it allows process A
to change the event mask of process B just by specifying process B's
client ID. That can lead to denial of service attacks where process A
can cause events not to be delivered to B or can flood process B with
frequent events that it's not prepared to handle.

Therefore you must make the lookup of the client from the client ID not
from a global list, but from a per-process list. That way process A can
only change event masks of process A clients, and not those of any other
process.

But if the client list is process-specific, you can use the FD as a
unique identifier of the client within the process, so you don't need a
separate client ID.

Regards,
  Felix

Am 2020-04-14 um 8:09 p.m. schrieb Lin, Amber:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>  
>
> Hi Felix,
>
>  
>
> That was my assumption too that each registration will get different
> file descriptor, but it turns out not. When I started two process and
> both register gpu0 and gpu1, they both got fd=15. If I have process A
> register gpu0+gpu1, and process B only register gpu0, process A gets
> fd=15 and process B gets fd=9. That’s why I added client ID.
>
>  
>
> By multiple clients, I mean multiple processes. The ask is users want
> to have multiple tools and those different tools can use rsmi lib to
> watch events at the same time. Due to the reason above that two
> processes can actually get the same fd and I need to add client ID to
> distinguish the registration, I don’t see the point of limiting one
> registration per process unless I use pid to distinguish the client
> instead, which was in my consideration too when I was writing the
> code. But second thought is why adding this restriction when client ID
> can allow the tool to watch different events on different devices if
> they want to. Maybe client ID is a bad term and it misleads you. I
> should call it register ID.
>
>  
>
> Regards,
>
> Amber
>
>  
>
> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> *Sent:* Tuesday, April 14, 2020 7:04 PM
> *To:* Lin, Amber <Amber.Lin@amd.com>; amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH v4] drm/amdkfd: Provide SMI events watch
>
>  
>
> Hi Amber,
>
> Some general remarks about the multi-client support. You added a
> global client id that's separate from the file descriptor. That's
> problematic for two reasons:
>
>  1. A process could change a different process' event mask
>  2. The FD should already be unique per process, no need to invent
>     another ID
>
> If we want to allow one process to register for events multiple times
> (multiple FDs per process), then the list of clients should be per
> process. Each process should only be allowed to change the event masks
> of its own clients. The client could be identified by its FD. No need
> for another client ID.
>
> But you could also simplify it further by allowing only one event
> client per process. Then you don't need the client ID lookup at all.
> Just have a single event client in the kfd_process.
>
> Another approach would be to make enable/disable functions of the
> event FD, rather than the KFD FD ioctl. It could be an ioctl of the
> event FD, or even simpler, you could use the write file-operation to
> write an event mask (of arbitrary length if you want to enable growth
> in the future). That way everything would be neatly encapsulated in
> the event FD private data.
>
> Two more comments inline ...
>
>  
>
> Am 2020-04-14 um 5:30 p.m. schrieb Amber Lin:
>
>     When the compute is malfunctioning or performance drops, the system admin
>
>     will use SMI (System Management Interface) tool to monitor/diagnostic what
>
>     went wrong. This patch provides an event watch interface for the user
>
>     space to register devices and subscribe events they are interested. After
>
>     registered, the user can use annoymous file descriptor's poll function
>
>     with wait-time specified and wait for events to happen. Once an event
>
>     happens, the user can use read() to retrieve information related to the
>
>     event.
>
>      
>
>     VM fault event is done in this patch.
>
>      
>
>     v2: - remove UNREGISTER and add event ENABLE/DISABLE
>
>         - correct kfifo usage
>
>         - move event message API to kfd_ioctl.h
>
>     v3: send the event msg in text than in binary
>
>     v4: support multiple clients
>
>      
>
>     Signed-off-by: Amber Lin <Amber.Lin@amd.com> <mailto:Amber.Lin@amd.com>
>
> [snip]
>
>     diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
>
>     index 4f66764..8146437 100644
>
>     --- a/include/uapi/linux/kfd_ioctl.h
>
>     +++ b/include/uapi/linux/kfd_ioctl.h
>
>     @@ -442,6 +442,36 @@ struct kfd_ioctl_import_dmabuf_args {
>
>       __u32 dmabuf_fd;       /* to KFD */
>
>      };
>
>      
>
>     +/*
>
>     + * KFD SMI(System Management Interface) events
>
>     + */
>
>     +enum kfd_smi_events_op {
>
>     + KFD_SMI_EVENTS_REGISTER = 1,
>
>     + KFD_SMI_EVENTS_ENABLE,
>
>     + KFD_SMI_EVENTS_DISABLE
>
>     +};
>
>     +
>
>     +/* Event type (defined by bitmask) */
>
>     +#define KFD_SMI_EVENT_VMFAULT     0x0000000000000001
>
>     +
>
>     +struct kfd_ioctl_smi_events_args {
>
>     + __u32 op;              /* to KFD */
>
>     + __u64 events;          /* to KFD */
>
> The binary layout of the ioctl args structure should be the same on
> 32/64-bit. That means the 64-bit members should be 64-bit aligned. The
> best way to ensure this is to put all the 64-bit members first.
>
>  
>
>      
>
>     + __u64 gpuids_array_ptr;        /* to KFD */
>
>     + __u32 num_gpuids;      /* to KFD */
>
>     + __u32 anon_fd;         /* from KFD */
>
>     + __u32 client_id;       /* to/from KFD */
>
>     +};
>
>     +
>
>     +/* 1. All messages must start with (hex)uint64_event(16) + space(1) +
>
>     + *    (hex)gpuid(8) + space(1) =  26 bytes
>
>     + * 2. VmFault msg = (hex)uint32_pid(8) + space(1) + task name(16) = 25
>
>     + *    When a new event msg uses more memory, change the calculation here.
>
>     + * 3. End with \n(1)
>
>     + * 26 + 25 + 1 = 52
>
>     + */
>
>     +#define KFD_SMI_MAX_EVENT_MSG 52
>
> If you define the maximum message length here, clients may start
> depending on it, and it gets harder to change it later. I'd not define
> this in the API header. It's not necessary to write correct clients.
> And if used badly, it may encourage writing incorrect clients that
> break with longer messages in the future.
>
> Regards,
>   Felix
>
>  
>
>      
>
>     +
>
>      /* Register offset inside the remapped mmio page
>
>       */
>
>      enum kfd_mmio_remap {
>
>     @@ -546,7 +576,10 @@ enum kfd_mmio_remap {
>
>      #define AMDKFD_IOC_ALLOC_QUEUE_GWS            \
>
>              AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)
>
>      
>
>     +#define AMDKFD_IOC_SMI_EVENTS                 \
>
>     +        AMDKFD_IOWR(0x1F, struct kfd_ioctl_smi_events_args)
>
>     +
>
>      #define AMDKFD_COMMAND_START           0x01
>
>     -#define AMDKFD_COMMAND_END             0x1F
>
>     +#define AMDKFD_COMMAND_END             0x20
>
>      
>
>      #endif
>

--------------108865A27CFE034C60039C4F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Amber,</p>
    <p>I understand that different processes can get the same FD. My
      statement about FD being unique is relative to one process.</p>
    <p>The main problem with the global client ID is, that it allows
      process A to change the event mask of process B just by specifying
      process B's client ID. That can lead to denial of service attacks
      where process A can cause events not to be delivered to B or can
      flood process B with frequent events that it's not prepared to
      handle.</p>
    <p>Therefore you must make the lookup of the client from the client
      ID not from a global list, but from a per-process list. That way
      process A can only change event masks of process A clients, and
      not those of any other process.</p>
    <p>But if the client list is process-specific, you can use the FD as
      a unique identifier of the client within the process, so you don't
      need a separate client ID.</p>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <div class="moz-cite-prefix">Am 2020-04-14 um 8:09 p.m. schrieb Lin,
      Amber:<br>
    </div>
    <blockquote type="cite" cite="mid:BN8PR12MB30418878CCC5D2FE5103248DE1DB0@BN8PR12MB3041.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:PMingLiU;
	panose-1:2 1 6 1 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:"\@PMingLiU";
	panose-1:2 1 6 1 0 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle22
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
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
	{mso-list-id:711004651;
	mso-list-template-ids:506200590;}
@list l1
	{mso-list-id:841353468;
	mso-list-template-ids:-1447530186;}
@list l1:level1
	{mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
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
        <p class="msipheader4d0fcdd7" style="margin:0in;margin-bottom:.0001pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
            Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Hi Felix,<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">That was my assumption too that each
          registration will get different file descriptor, but it turns
          out not. When I started two process and both register gpu0 and
          gpu1, they both got fd=15. If I have process A register
          gpu0&#43;gpu1, and process B only register gpu0, process A gets
          fd=15 and process B gets fd=9. That’s why I added client ID.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">By multiple clients, I mean multiple
          processes. The ask is users want to have multiple tools and
          those different tools can use rsmi lib to watch events at the
          same time. Due to the reason above that two processes can
          actually get the same fd and I need to add client ID to
          distinguish the registration, I don’t see the point of
          limiting one registration per process unless I use pid to
          distinguish the client instead, which was in my consideration
          too when I was writing the code. But second thought is why
          adding this restriction when client ID can allow the tool to
          watch different events on different devices if they want to.
          Maybe client ID is a bad term and it misleads you. I should
          call it register ID.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <p class="MsoNormal">Regards,<o:p></o:p></p>
          <p class="MsoNormal">Amber<o:p></o:p></p>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Kuehling, Felix
              <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a> <br>
              <b>Sent:</b> Tuesday, April 14, 2020 7:04 PM<br>
              <b>To:</b> Lin, Amber <a class="moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com">&lt;Amber.Lin@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
              <b>Subject:</b> Re: [PATCH v4] drm/amdkfd: Provide SMI
              events watch<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p>Hi Amber,<o:p></o:p></p>
        <p>Some general remarks about the multi-client support. You
          added a global client id that's separate from the file
          descriptor. That's problematic for two reasons:<o:p></o:p></p>
        <ol type="1" start="1">
          <li class="MsoNormal" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto;mso-list:l1
            level1 lfo3">
            A process could change a different process' event mask<o:p></o:p></li>
          <li class="MsoNormal" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto;mso-list:l1
            level1 lfo3">
            The FD should already be unique per process, no need to
            invent another ID<o:p></o:p></li>
        </ol>
        <p>If we want to allow one process to register for events
          multiple times (multiple FDs per process), then the list of
          clients should be per process. Each process should only be
          allowed to change the event masks of its own clients. The
          client could be identified by its FD. No need for another
          client ID.<o:p></o:p></p>
        <p>But you could also simplify it further by allowing only one
          event client per process. Then you don't need the client ID
          lookup at all. Just have a single event client in the
          kfd_process.<o:p></o:p></p>
        <p>Another approach would be to make enable/disable functions of
          the event FD, rather than the KFD FD ioctl. It could be an
          ioctl of the event FD, or even simpler, you could use the
          write file-operation to write an event mask (of arbitrary
          length if you want to enable growth in the future). That way
          everything would be neatly encapsulated in the event FD
          private data.<o:p></o:p></p>
        <p>Two more comments inline ...<o:p></o:p></p>
        <p><o:p>&nbsp;</o:p></p>
        <div>
          <p class="MsoNormal">Am 2020-04-14 um 5:30 p.m. schrieb Amber
            Lin:<o:p></o:p></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <pre>When the compute is malfunctioning or performance drops, the system admin<o:p></o:p></pre>
          <pre>will use SMI (System Management Interface) tool to monitor/diagnostic what<o:p></o:p></pre>
          <pre>went wrong. This patch provides an event watch interface for the user<o:p></o:p></pre>
          <pre>space to register devices and subscribe events they are interested. After<o:p></o:p></pre>
          <pre>registered, the user can use annoymous file descriptor's poll function<o:p></o:p></pre>
          <pre>with wait-time specified and wait for events to happen. Once an event<o:p></o:p></pre>
          <pre>happens, the user can use read() to retrieve information related to the<o:p></o:p></pre>
          <pre>event.<o:p></o:p></pre>
          <pre><o:p>&nbsp;</o:p></pre>
          <pre>VM fault event is done in this patch.<o:p></o:p></pre>
          <pre><o:p>&nbsp;</o:p></pre>
          <pre>v2: - remove UNREGISTER and add event ENABLE/DISABLE<o:p></o:p></pre>
          <pre>&nbsp;&nbsp;&nbsp; - correct kfifo usage<o:p></o:p></pre>
          <pre>&nbsp;&nbsp;&nbsp; - move event message API to kfd_ioctl.h<o:p></o:p></pre>
          <pre>v3: send the event msg in text than in binary<o:p></o:p></pre>
          <pre>v4: support multiple clients<o:p></o:p></pre>
          <pre><o:p>&nbsp;</o:p></pre>
          <pre>Signed-off-by: Amber Lin <a href="mailto:Amber.Lin@amd.com" moz-do-not-send="true">&lt;Amber.Lin@amd.com&gt;</a><o:p></o:p></pre>
        </blockquote>
        <p>[snip]<o:p></o:p></p>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <pre>diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h<o:p></o:p></pre>
          <pre>index 4f66764..8146437 100644<o:p></o:p></pre>
          <pre>--- a/include/uapi/linux/kfd_ioctl.h<o:p></o:p></pre>
          <pre>&#43;&#43;&#43; b/include/uapi/linux/kfd_ioctl.h<o:p></o:p></pre>
          <pre>@@ -442,6 &#43;442,36 @@ struct kfd_ioctl_import_dmabuf_args {<o:p></o:p></pre>
          <pre>&nbsp; __u32 dmabuf_fd;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */<o:p></o:p></pre>
          <pre> };<o:p></o:p></pre>
          <pre> <o:p></o:p></pre>
          <pre>&#43;/*<o:p></o:p></pre>
          <pre>&#43; * KFD SMI(System Management Interface) events<o:p></o:p></pre>
          <pre>&#43; */<o:p></o:p></pre>
          <pre>&#43;enum kfd_smi_events_op {<o:p></o:p></pre>
          <pre>&#43; KFD_SMI_EVENTS_REGISTER = 1,<o:p></o:p></pre>
          <pre>&#43; KFD_SMI_EVENTS_ENABLE,<o:p></o:p></pre>
          <pre>&#43; KFD_SMI_EVENTS_DISABLE<o:p></o:p></pre>
          <pre>&#43;};<o:p></o:p></pre>
          <pre>&#43;<o:p></o:p></pre>
          <pre>&#43;/* Event type (defined by bitmask) */<o:p></o:p></pre>
          <pre>&#43;#define KFD_SMI_EVENT_VMFAULT&nbsp;&nbsp;&nbsp;&nbsp; 0x0000000000000001<o:p></o:p></pre>
          <pre>&#43;<o:p></o:p></pre>
          <pre>&#43;struct kfd_ioctl_smi_events_args {<o:p></o:p></pre>
          <pre>&#43; __u32 op;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */<o:p></o:p></pre>
          <pre>&#43; __u64 events;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */<o:p></o:p></pre>
        </blockquote>
        <p>The binary layout of the ioctl args structure should be the
          same on 32/64-bit. That means the 64-bit members should be
          64-bit aligned. The best way to ensure this is to put all the
          64-bit members first.<o:p></o:p></p>
        <p class="MsoNormal" style="margin-bottom:12.0pt"><o:p>&nbsp;</o:p></p>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <pre><o:p>&nbsp;</o:p></pre>
          <pre>&#43; __u64 gpuids_array_ptr;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */<o:p></o:p></pre>
          <pre>&#43; __u32 num_gpuids;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */<o:p></o:p></pre>
          <pre>&#43; __u32 anon_fd;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* from KFD */<o:p></o:p></pre>
          <pre>&#43; __u32 client_id;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to/from KFD */<o:p></o:p></pre>
          <pre>&#43;};<o:p></o:p></pre>
          <pre>&#43;<o:p></o:p></pre>
          <pre>&#43;/* 1. All messages must start with (hex)uint64_event(16) &#43; space(1) &#43;<o:p></o:p></pre>
          <pre>&#43; *&nbsp;&nbsp;&nbsp; (hex)gpuid(8) &#43; space(1) =&nbsp; 26 bytes<o:p></o:p></pre>
          <pre>&#43; * 2. VmFault msg = (hex)uint32_pid(8) &#43; space(1) &#43; task name(16) = 25<o:p></o:p></pre>
          <pre>&#43; *&nbsp;&nbsp;&nbsp; When a new event msg uses more memory, change the calculation here.<o:p></o:p></pre>
          <pre>&#43; * 3. End with \n(1)<o:p></o:p></pre>
          <pre>&#43; * 26 &#43; 25 &#43; 1 = 52<o:p></o:p></pre>
          <pre>&#43; */<o:p></o:p></pre>
          <pre>&#43;#define KFD_SMI_MAX_EVENT_MSG 52<o:p></o:p></pre>
        </blockquote>
        <p>If you define the maximum message length here, clients may
          start depending on it, and it gets harder to change it later.
          I'd not define this in the API header. It's not necessary to
          write correct clients. And if used badly, it may encourage
          writing incorrect clients that break with longer messages in
          the future.<o:p></o:p></p>
        <p>Regards,<br>
          &nbsp; Felix<o:p></o:p></p>
        <p><o:p>&nbsp;</o:p></p>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <pre><o:p>&nbsp;</o:p></pre>
          <pre>&#43;<o:p></o:p></pre>
          <pre> /* Register offset inside the remapped mmio page<o:p></o:p></pre>
          <pre>&nbsp; */<o:p></o:p></pre>
          <pre> enum kfd_mmio_remap {<o:p></o:p></pre>
          <pre>@@ -546,7 &#43;576,10 @@ enum kfd_mmio_remap {<o:p></o:p></pre>
          <pre> #define AMDKFD_IOC_ALLOC_QUEUE_GWS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></pre>
          <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)<o:p></o:p></pre>
          <pre> <o:p></o:p></pre>
          <pre>&#43;#define AMDKFD_IOC_SMI_EVENTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></pre>
          <pre>&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOWR(0x1F, struct kfd_ioctl_smi_events_args)<o:p></o:p></pre>
          <pre>&#43;<o:p></o:p></pre>
          <pre> #define AMDKFD_COMMAND_START&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01<o:p></o:p></pre>
          <pre>-#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1F<o:p></o:p></pre>
          <pre>&#43;#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x20<o:p></o:p></pre>
          <pre> <o:p></o:p></pre>
          <pre>&nbsp;#endif<o:p></o:p></pre>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------108865A27CFE034C60039C4F--

--===============1123144423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1123144423==--
