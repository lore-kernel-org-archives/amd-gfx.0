Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59832C38A29
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 23:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03FFD2051A
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 23:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="o7c5vPMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FFD2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94FDE6E5CA;
	Tue, 14 Apr 2020 23:04:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63176E5C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 23:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6IReYWnwa1TIiXE49TyQNsCGbGoRkMSLvTfc00ZRvppeI/TRcmb/D+/Gyv/XtBzefDZoeBZkZKcrlH6rWtWaDX6KqpSwhdRCpzEq9+n4Di35adCrfdaBMdh63PtoLOT1fHM7PCo7W3avEdH0Eyby7DFDk840D6JpYCJhmGvLgKiO+qTrdt3PwRbAJ7hwp6lOLUQfDAkj1s1rKs+t79A8bh17RHsDaOglazoY0rBbKZ0UtXn1AdAzIdsXiIFwzxkgGrjCWzHJE/xqSxmp6ktEBPc/brfAKLbdHlq5MSbOCHASSf73YRBN1Txm9deXVCmeYlYGdOA1xbHyzFCqzCPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu5sMIHTlQ+Sg3k+nNJOR++BnKCR7Oeh7LFIPDcbL4Y=;
 b=i214fUrEAvmJ7C/2u3mbWzV1KdFCfSHhZY/1e2MDoW8KiliDK6/mdfThVexlLNupHYRlJwD2CpgJO6cUbMitarXg38o2Gg7HSbuXUPWKtL1XcPM7VHaB9fsUbvICTy5irE/Ka4P4Ix7DaliknHmMvq5efHuK2Ku+ubI06RUmaanb1ssksnSokJWIQ90Os68QgvJLxXhRJ1hfr7HJF4VS8rS6bseL+x+6pwvc/StlXbzCXAJp+jnETOYewHa0FnzLGCDAZXL6SLTYRL2gqPoQ4vB9pBwQM3nb6ZkEhBwkutq82MnnMwTmi4zTt47++Gqf3Dw1aN+7JoEr0H5gl+gPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu5sMIHTlQ+Sg3k+nNJOR++BnKCR7Oeh7LFIPDcbL4Y=;
 b=o7c5vPMY1z9wTgD817IqTYgeIA7pCEe3+WY04efccBq3EZUOyZXKtSuemQBZY1yu6ZXHwtGbWG+IC7NLfRXu4hztDGtce2gYxhzjKbLh4PHMAJzk+vZrBzf2yCagk1cMxrVM1gbEKtw7FW3ItqcdRJInZkEy+ZYX8jFP8LcGGko=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2544.namprd12.prod.outlook.com (2603:10b6:802:2b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Tue, 14 Apr
 2020 23:04:02 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 23:04:02 +0000
Subject: Re: [PATCH v4] drm/amdkfd: Provide SMI events watch
To: Amber Lin <Amber.Lin@amd.com>, amd-gfx@lists.freedesktop.org
References: <1586899842-28131-1-git-send-email-Amber.Lin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <46d5b0c3-2fb3-932e-2ec7-216d693a63d4@amd.com>
Date: Tue, 14 Apr 2020 19:04:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1586899842-28131-1-git-send-email-Amber.Lin@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::18) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YQBPR01CA0046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Tue, 14 Apr 2020 23:04:01 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 938aff9e-33dc-4ba0-d55a-08d7e0c81f65
X-MS-TrafficTypeDiagnostic: SN1PR12MB2544:|SN1PR12MB2544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25440CFF5AA99A1971CD9C5F92DA0@SN1PR12MB2544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(376002)(366004)(39850400004)(136003)(346002)(956004)(5660300002)(186003)(31686004)(2616005)(81156014)(16526019)(2906002)(8936002)(478600001)(86362001)(8676002)(16576012)(31696002)(66476007)(66556008)(66946007)(36756003)(52116002)(33964004)(26005)(6486002)(316002)(44832011);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RAPIRuxfFz+yL0KIie008umVy3VUGf2QAPO8NiWXHbtTSGu4K10fOYIuxgW+war3KzcgvgHP2tjwEYerxeLVN9UJ0IA/z9ePc9C8nC+YMqu3L/+IoNxgQunQViYmIp08SdBSurCfcl5KSFoAzh76bMx4c+xj1WmCDVFUjIh6spLnFUGhruH+53R3qqI/pCRzT5eNTuQmafpEC2nF/4Qt3N5mMR4YLJK9durBl6lyooxiun0x4rgd/suQEQicmcZ8NkxugbP/u+6gXhXBIlbUfA71IoVUG1diH7rhPuBnpan85+88HcLc6Bl6bKe1LLpYF+QRXcw9I4Fks7cmYwpXN5lcg3OJe/u0JiegpZ8si7Xc0tCczp+JVdGYzbx6NtqQR4WEnT+hBBjB3gzyzb/zNldTaF7KUhMTdPrOBXNuBaM81R1mh+Wv+1mpmQasdwtY
X-MS-Exchange-AntiSpam-MessageData: jb5ImsfYnBusYzvxQDJ124TEvMwAmVZKBfzTUcE4POaNVzsSfGtJ6oNG0SEaxifPkJqawsf2ClUPzsi+3SyySqfpKtE1h7boL3PWyQLJPKrT21sTSwXmxEvHlyLNIkUr191rCEw3MbJ0Obg+54Ivng==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938aff9e-33dc-4ba0-d55a-08d7e0c81f65
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 23:04:02.2572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwwCemqR5t6BGpoEkSyTKLZSxOd62wiNSKW/BLfqr/28Bho1laFmTniXCQqSL63kOxgXV7fa2/kvN7IRJ6K43A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2544
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
Content-Type: multipart/mixed; boundary="===============0473942473=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0473942473==
Content-Type: multipart/alternative;
 boundary="------------A67FD94487E380C0F0202119"
Content-Language: en-US

--------------A67FD94487E380C0F0202119
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Amber,

Some general remarks about the multi-client support. You added a global
client id that's separate from the file descriptor. That's problematic
for two reasons:

 1. A process could change a different process' event mask
 2. The FD should already be unique per process, no need to invent
    another ID

If we want to allow one process to register for events multiple times
(multiple FDs per process), then the list of clients should be per
process. Each process should only be allowed to change the event masks
of its own clients. The client could be identified by its FD. No need
for another client ID.

But you could also simplify it further by allowing only one event client
per process. Then you don't need the client ID lookup at all. Just have
a single event client in the kfd_process.

Another approach would be to make enable/disable functions of the event
FD, rather than the KFD FD ioctl. It could be an ioctl of the event FD,
or even simpler, you could use the write file-operation to write an
event mask (of arbitrary length if you want to enable growth in the
future). That way everything would be neatly encapsulated in the event
FD private data.

Two more comments inline ...


Am 2020-04-14 um 5:30 p.m. schrieb Amber Lin:
> When the compute is malfunctioning or performance drops, the system admin
> will use SMI (System Management Interface) tool to monitor/diagnostic what
> went wrong. This patch provides an event watch interface for the user
> space to register devices and subscribe events they are interested. After
> registered, the user can use annoymous file descriptor's poll function
> with wait-time specified and wait for events to happen. Once an event
> happens, the user can use read() to retrieve information related to the
> event.
>
> VM fault event is done in this patch.
>
> v2: - remove UNREGISTER and add event ENABLE/DISABLE
>     - correct kfifo usage
>     - move event message API to kfd_ioctl.h
> v3: send the event msg in text than in binary
> v4: support multiple clients
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

[snip]

> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 4f66764..8146437 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -442,6 +442,36 @@ struct kfd_ioctl_import_dmabuf_args {
>  	__u32 dmabuf_fd;	/* to KFD */
>  };
>  
> +/*
> + * KFD SMI(System Management Interface) events
> + */
> +enum kfd_smi_events_op {
> +	KFD_SMI_EVENTS_REGISTER = 1,
> +	KFD_SMI_EVENTS_ENABLE,
> +	KFD_SMI_EVENTS_DISABLE
> +};
> +
> +/* Event type (defined by bitmask) */
> +#define KFD_SMI_EVENT_VMFAULT     0x0000000000000001
> +
> +struct kfd_ioctl_smi_events_args {
> +	__u32 op;		/* to KFD */
> +	__u64 events;		/* to KFD */

The binary layout of the ioctl args structure should be the same on
32/64-bit. That means the 64-bit members should be 64-bit aligned. The
best way to ensure this is to put all the 64-bit members first.


> +	__u64 gpuids_array_ptr;	/* to KFD */
> +	__u32 num_gpuids;	/* to KFD */
> +	__u32 anon_fd;		/* from KFD */
> +	__u32 client_id;	/* to/from KFD */
> +};
> +
> +/* 1. All messages must start with (hex)uint64_event(16) + space(1) +
> + *    (hex)gpuid(8) + space(1) =  26 bytes
> + * 2. VmFault msg = (hex)uint32_pid(8) + space(1) + task name(16) = 25
> + *    When a new event msg uses more memory, change the calculation here.
> + * 3. End with \n(1)
> + * 26 + 25 + 1 = 52
> + */
> +#define KFD_SMI_MAX_EVENT_MSG 52

If you define the maximum message length here, clients may start
depending on it, and it gets harder to change it later. I'd not define
this in the API header. It's not necessary to write correct clients. And
if used badly, it may encourage writing incorrect clients that break
with longer messages in the future.

Regards,
  Felix


> +
>  /* Register offset inside the remapped mmio page
>   */
>  enum kfd_mmio_remap {
> @@ -546,7 +576,10 @@ enum kfd_mmio_remap {
>  #define AMDKFD_IOC_ALLOC_QUEUE_GWS		\
>  		AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)
>  
> +#define AMDKFD_IOC_SMI_EVENTS			\
> +		AMDKFD_IOWR(0x1F, struct kfd_ioctl_smi_events_args)
> +
>  #define AMDKFD_COMMAND_START		0x01
> -#define AMDKFD_COMMAND_END		0x1F
> +#define AMDKFD_COMMAND_END		0x20
>  
>  #endif

--------------A67FD94487E380C0F0202119
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Amber,</p>
    <p>Some general remarks about the multi-client support. You added a
      global client id that's separate from the file descriptor. That's
      problematic for two reasons:</p>
    <ol>
      <li>A process could change a different process' event mask</li>
      <li>The FD should already be unique per process, no need to invent
        another ID</li>
    </ol>
    <p>If we want to allow one process to register for events multiple
      times (multiple FDs per process), then the list of clients should
      be per process. Each process should only be allowed to change the
      event masks of its own clients. The client could be identified by
      its FD. No need for another client ID.</p>
    <p>But you could also simplify it further by allowing only one event
      client per process. Then you don't need the client ID lookup at
      all. Just have a single event client in the kfd_process.</p>
    <p>Another approach would be to make enable/disable functions of the
      event FD, rather than the KFD FD ioctl. It could be an ioctl of
      the event FD, or even simpler, you could use the write
      file-operation to write an event mask (of arbitrary length if you
      want to enable growth in the future). That way everything would be
      neatly encapsulated in the event FD private data.<br>
    </p>
    <p>Two more comments inline ...<br>
    </p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">Am 2020-04-14 um 5:30 p.m. schrieb
      Amber Lin:<br>
    </div>
    <blockquote type="cite" cite="mid:1586899842-28131-1-git-send-email-Amber.Lin@amd.com">
      <pre class="moz-quote-pre" wrap="">When the compute is malfunctioning or performance drops, the system admin
will use SMI (System Management Interface) tool to monitor/diagnostic what
went wrong. This patch provides an event watch interface for the user
space to register devices and subscribe events they are interested. After
registered, the user can use annoymous file descriptor's poll function
with wait-time specified and wait for events to happen. Once an event
happens, the user can use read() to retrieve information related to the
event.

VM fault event is done in this patch.

v2: - remove UNREGISTER and add event ENABLE/DISABLE
    - correct kfifo usage
    - move event message API to kfd_ioctl.h
v3: send the event msg in text than in binary
v4: support multiple clients

Signed-off-by: Amber Lin <a class="moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com">&lt;Amber.Lin@amd.com&gt;</a>
</pre>
    </blockquote>
    <p>[snip]</p>
    <blockquote type="cite" cite="mid:1586899842-28131-1-git-send-email-Amber.Lin@amd.com">
      <pre class="moz-quote-pre" wrap="">diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 4f66764..8146437 100644
--- a/include/uapi/linux/kfd_ioctl.h
&#43;&#43;&#43; b/include/uapi/linux/kfd_ioctl.h
@@ -442,6 &#43;442,36 @@ struct kfd_ioctl_import_dmabuf_args {
 	__u32 dmabuf_fd;	/* to KFD */
 };
 
&#43;/*
&#43; * KFD SMI(System Management Interface) events
&#43; */
&#43;enum kfd_smi_events_op {
&#43;	KFD_SMI_EVENTS_REGISTER = 1,
&#43;	KFD_SMI_EVENTS_ENABLE,
&#43;	KFD_SMI_EVENTS_DISABLE
&#43;};
&#43;
&#43;/* Event type (defined by bitmask) */
&#43;#define KFD_SMI_EVENT_VMFAULT     0x0000000000000001
&#43;
&#43;struct kfd_ioctl_smi_events_args {
&#43;	__u32 op;		/* to KFD */
&#43;	__u64 events;		/* to KFD */</pre>
    </blockquote>
    <p>The binary layout of the ioctl args structure should be the same
      on 32/64-bit. That means the 64-bit members should be 64-bit
      aligned. The best way to ensure this is to put all the 64-bit
      members first.<br>
    </p>
    <br>
    <blockquote type="cite" cite="mid:1586899842-28131-1-git-send-email-Amber.Lin@amd.com">
      <pre class="moz-quote-pre" wrap="">
&#43;	__u64 gpuids_array_ptr;	/* to KFD */
&#43;	__u32 num_gpuids;	/* to KFD */
&#43;	__u32 anon_fd;		/* from KFD */
&#43;	__u32 client_id;	/* to/from KFD */
&#43;};
&#43;
&#43;/* 1. All messages must start with (hex)uint64_event(16) &#43; space(1) &#43;
&#43; *    (hex)gpuid(8) &#43; space(1) =  26 bytes
&#43; * 2. VmFault msg = (hex)uint32_pid(8) &#43; space(1) &#43; task name(16) = 25
&#43; *    When a new event msg uses more memory, change the calculation here.
&#43; * 3. End with \n(1)
&#43; * 26 &#43; 25 &#43; 1 = 52
&#43; */
&#43;#define KFD_SMI_MAX_EVENT_MSG 52</pre>
    </blockquote>
    <p>If you define the maximum message length here, clients may start
      depending on it, and it gets harder to change it later. I'd not
      define this in the API header. It's not necessary to write correct
      clients. And if used badly, it may encourage writing incorrect
      clients that break with longer messages in the future.<br>
    </p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:1586899842-28131-1-git-send-email-Amber.Lin@amd.com">
      <pre class="moz-quote-pre" wrap="">
&#43;
 /* Register offset inside the remapped mmio page
  */
 enum kfd_mmio_remap {
@@ -546,7 &#43;576,10 @@ enum kfd_mmio_remap {
 #define AMDKFD_IOC_ALLOC_QUEUE_GWS		\
 		AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)
 
&#43;#define AMDKFD_IOC_SMI_EVENTS			\
&#43;		AMDKFD_IOWR(0x1F, struct kfd_ioctl_smi_events_args)
&#43;
 #define AMDKFD_COMMAND_START		0x01
-#define AMDKFD_COMMAND_END		0x1F
&#43;#define AMDKFD_COMMAND_END		0x20
 
 #endif
</pre>
    </blockquote>
  </body>
</html>

--------------A67FD94487E380C0F0202119--

--===============0473942473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0473942473==--
