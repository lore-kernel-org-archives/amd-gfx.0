Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA07EC2BA19
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 15:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BFA2076A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 15:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CG+vYNcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BFA2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB896E0EE;
	Wed, 15 Apr 2020 15:26:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6220E6E0EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 15:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiJcmbrecEgecvWPokMpY6TErE/oQ6f5MzoBshjflGT9ELqELxQ+uE0dIyLxpOXQbZjGQv+AyFRIQQGfvIhmQqLReRY/Tcz1BY+Sc+dF9LXt3xyRCjCloA/VQb96idko/ayVA8Myt0DHs2ImU2a3nB+ar73diYRGDIWwZkbWjDbBIPEJUbOZMDp2ZjIig2+cuOU4139Kwspq1dPEwUCtBw05ZEXlLkoxwAmxF5tFtCyp0PBn3EOBZ7I6TVNN9EtOnEv+TGhIlX3ma4NIB+9hcPtXcOFoK/Qyamd7GGmEpQTgngubj5yCezUFArLsgoobAPgeTSk9EQ9rg+/mFpZ3bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+V4WQsevsR3sR3OJc2rr+ZR1nSIYb6ORXY76NHaf0k=;
 b=lTSx60lmTrme+iTqjkLJtFdzFByDaycZzjU573nivn6Yj1hAfK5eeNK3MBHVTTPrPZqdn2L+mE42PRzBLqOo+X3vQ/ORkRoKaHpc9gs0t7h28alITJxahRz/U7EuVJWpKD7cjPc0q1k5syWzoXlvxsTrnfST1kavTxkruAjOyR3/XUASEow5oDI8DWJ7LDeXIE0bKghGOmNhsypp68xgRhaxTCsWBEPY+JdW+lJjKjmlsm560GyJbwTvDbauiN0sQx2M+Cd47IpY9ZGxTtvcAOxOIHLaETWRYx6zWrIpkvTnh2V+ODHziK976KF4sHLij5i2QSK3DS49ZBBbG6QOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+V4WQsevsR3sR3OJc2rr+ZR1nSIYb6ORXY76NHaf0k=;
 b=CG+vYNcTkq+OOw1lBO3ZXwu9OABMQTYlq3sn3Q0hkfqCo1BmuKX2nI7PyFho0W6DEz1gFCP6Vfew+bk1FRbkyAHFlJhRDsR45YTEVi9TFsPmGq5ZRSxjZFmpthCDAbsQnwTP3kfFEya1ONaJ+Bb89tsqwRPEeubSVglDzUudf+I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 15 Apr
 2020 15:26:40 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 15:26:40 +0000
Subject: Re: [PATCH v4] drm/amdkfd: Provide SMI events watch
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Lin, Amber" <Amber.Lin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1586899842-28131-1-git-send-email-Amber.Lin@amd.com>
 <46d5b0c3-2fb3-932e-2ec7-216d693a63d4@amd.com>
 <BN8PR12MB30418878CCC5D2FE5103248DE1DB0@BN8PR12MB3041.namprd12.prod.outlook.com>
 <7442ee3e-9d91-d886-af22-cf00f9ab23a4@amd.com>
 <MN2PR12MB4488B378A20AB052F3A93564F7DB0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <04d21092-3366-99fa-c792-291b1a7a859a@amd.com>
 <MN2PR12MB44886F41E8D3FCDFD7DED107F7DB0@MN2PR12MB4488.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ae81b04d-1611-25eb-62b6-a32d3420c2cc@amd.com>
Date: Wed, 15 Apr 2020 11:26:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <MN2PR12MB44886F41E8D3FCDFD7DED107F7DB0@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YQXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::39) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YQXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:14::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Wed, 15 Apr 2020 15:26:39 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7076e92-411e-429e-24f9-08d7e15164d1
X-MS-TrafficTypeDiagnostic: SN1PR12MB2493:|SN1PR12MB2493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2493F286014E5CB769D242EC92DB0@SN1PR12MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(16526019)(478600001)(2616005)(5660300002)(6486002)(19627405001)(186003)(956004)(966005)(31696002)(30864003)(2906002)(86362001)(52116002)(53546011)(26005)(110136005)(16576012)(66556008)(36756003)(8676002)(19627235002)(81156014)(8936002)(31686004)(316002)(44832011)(21615005)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KqrXM/9fRhdjFlDySGK1XZHWVGzoXOi4bDj3aZCEt3+vwOsoFv2Y9LSxDDreYLNG4t2jTPpeGf6f06RtRH4QI3YZeLHb122lG4u15NIQgp5cGGSnV5BkUn4jcvjuDv72xe1zJpm5tboFPWOfIKrRRQdPUicSV1qYab82H5KJAAXpRpQ5CrmfGdzH2ReM8UlK8utEwl7KA2sjjtrr0X2G01seRA/K6/m0X0HLeYhj8C6Ft9JmsAVvzh3FHV22eAx8devTv4GRiSaudBYk3RBozEogmIRjopktzZyva+o0PjiTsLwdPyrpJTo6EIhSxCa3I+QaoPTuZmWkL504XEI9Stn9f7sGyyFyzvF4JdDnB4OFkRoWlKLMMtaJqusfz1sBjJzN9OZ4X4r5m1+DGWT+vHP9VIQXc8GCYFlnMRj2ySmE5butoNL1UGLaio7cESfZyIY+EHUMl55FB2Qo98qTWXIbgiNKOm9IcjwcU9Pxx1nNIItOwVP4RWKoC3fVJMKibR/Rvuisk0xQc+4BRT0Q5g==
X-MS-Exchange-AntiSpam-MessageData: fqRDfOD+Wh1RtCHaKizHKuFilrtdFPKf4g5aa8ZHjmuuhBxtE31/m4L2rfWit1XcAw7PzvoF5zFHTlgSsQ8GPb9MGp4gWDWQYD/x87wH3OLc5c3oIgs/YJDysBLDXmD88dxNio4TMRaVRH3oFK0HNA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7076e92-411e-429e-24f9-08d7e15164d1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 15:26:39.8751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWaBndOz3OUejikD16p+G/FoaLHIVKOwN0TbT+mOq2aYE+lQ+xw48tPfB1pBCee1bbXF8E0wHcIVfTcyME1ojg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
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
Content-Type: multipart/mixed; boundary="===============1990085857=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1990085857==
Content-Type: multipart/alternative;
 boundary="------------D74223D6B1EFF019E0F7FCB3"
Content-Language: en-US

--------------D74223D6B1EFF019E0F7FCB3
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit


Am 2020-04-15 um 9:48 a.m. schrieb Deucher, Alexander:
>
> [AMD Public Use]
>
>
> We use the drm major/minor in all cases.  Bump  KMS_DRIVER_MINOR in
> amdgpu_drv.c and add a note about what was added in the comment.

The KFD ioctl API has its own major and minor version defined in
include/uapi/linux/kfd_ioctl.h. Thunk clients can query that version
with hsaKmtGetVersion. We haven't been good at updating that version
when we make API changes. Currently two versions are in use:


Upstream: 1.1

DKMS: 1.2


I think this would be a good time to start a habit of bumping the KFD
ioctl minor version every time we change the upstream KFD ioctl API. We
should skip version 1.2, since that is in use by the DKMS driver. We
should also add a comment block above the version definition that
explains the changes in each future API version update.


Thanks,
  Felix


>
> Alex
> ------------------------------------------------------------------------
> *From:* Lin, Amber <Amber.Lin@amd.com>
> *Sent:* Wednesday, April 15, 2020 9:36 AM
> *To:* Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
> <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH v4] drm/amdkfd: Provide SMI events watch
>  
> Thank you Felix. Now I understand the problem of global client ID is
> leaking a hole for potential attackers. I didn't take that into
> consideration. I'll change that following your advice below.
>
> Hi Alex,
>
> Thank you for the link. It's helpful. I have a question regarding the
> versioning. One topic in the article talks about how the userspace can
> figure out if the new ioctl is supported in a given kernel. Is it
> correct that with dkms driver, we use the driver version coming from
> AMDGPU_VERSION in amdgpu_drv.c, and in upstream kernel we use the
> kernel version?
>
> Thanks.
>
> Amber
>
> On 2020-04-14 11:03 p.m., Deucher, Alexander wrote:
>>
>> [AMD Public Use]
>>
>>
>> Some good advice on getting ioctls right:
>> https://www.kernel.org/doc/html/v5.4-preprc-cpu/ioctl/botching-up-ioctls.html
>>
>> Alex
>>
>> ------------------------------------------------------------------------
>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
>> <mailto:amd-gfx-bounces@lists.freedesktop.org> on behalf of Felix
>> Kuehling <felix.kuehling@amd.com> <mailto:felix.kuehling@amd.com>
>> *Sent:* Tuesday, April 14, 2020 10:40 PM
>> *To:* Lin, Amber <Amber.Lin@amd.com> <mailto:Amber.Lin@amd.com>;
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> <amd-gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org>
>> *Subject:* Re: [PATCH v4] drm/amdkfd: Provide SMI events watch
>>  
>>
>> Hi Amber,
>>
>> I understand that different processes can get the same FD. My
>> statement about FD being unique is relative to one process.
>>
>> The main problem with the global client ID is, that it allows process
>> A to change the event mask of process B just by specifying process
>> B's client ID. That can lead to denial of service attacks where
>> process A can cause events not to be delivered to B or can flood
>> process B with frequent events that it's not prepared to handle.
>>
>> Therefore you must make the lookup of the client from the client ID
>> not from a global list, but from a per-process list. That way process
>> A can only change event masks of process A clients, and not those of
>> any other process.
>>
>> But if the client list is process-specific, you can use the FD as a
>> unique identifier of the client within the process, so you don't need
>> a separate client ID.
>>
>> Regards,
>>   Felix
>>
>> Am 2020-04-14 um 8:09 p.m. schrieb Lin, Amber:
>>>
>>> [AMD Official Use Only - Internal Distribution Only]
>>>
>>>  
>>>
>>> Hi Felix,
>>>
>>>  
>>>
>>> That was my assumption too that each registration will get different
>>> file descriptor, but it turns out not. When I started two process
>>> and both register gpu0 and gpu1, they both got fd=15. If I have
>>> process A register gpu0+gpu1, and process B only register gpu0,
>>> process A gets fd=15 and process B gets fd=9. That’s why I added
>>> client ID.
>>>
>>>  
>>>
>>> By multiple clients, I mean multiple processes. The ask is users
>>> want to have multiple tools and those different tools can use rsmi
>>> lib to watch events at the same time. Due to the reason above that
>>> two processes can actually get the same fd and I need to add client
>>> ID to distinguish the registration, I don’t see the point of
>>> limiting one registration per process unless I use pid to
>>> distinguish the client instead, which was in my consideration too
>>> when I was writing the code. But second thought is why adding this
>>> restriction when client ID can allow the tool to watch different
>>> events on different devices if they want to. Maybe client ID is a
>>> bad term and it misleads you. I should call it register ID.
>>>
>>>  
>>>
>>> Regards,
>>>
>>> Amber
>>>
>>>  
>>>
>>> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
>>> <mailto:Felix.Kuehling@amd.com>
>>> *Sent:* Tuesday, April 14, 2020 7:04 PM
>>> *To:* Lin, Amber <Amber.Lin@amd.com> <mailto:Amber.Lin@amd.com>;
>>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>>> *Subject:* Re: [PATCH v4] drm/amdkfd: Provide SMI events watch
>>>
>>>  
>>>
>>> Hi Amber,
>>>
>>> Some general remarks about the multi-client support. You added a
>>> global client id that's separate from the file descriptor. That's
>>> problematic for two reasons:
>>>
>>>  1. A process could change a different process' event mask
>>>  2. The FD should already be unique per process, no need to invent
>>>     another ID
>>>
>>> If we want to allow one process to register for events multiple
>>> times (multiple FDs per process), then the list of clients should be
>>> per process. Each process should only be allowed to change the event
>>> masks of its own clients. The client could be identified by its FD.
>>> No need for another client ID.
>>>
>>> But you could also simplify it further by allowing only one event
>>> client per process. Then you don't need the client ID lookup at all.
>>> Just have a single event client in the kfd_process.
>>>
>>> Another approach would be to make enable/disable functions of the
>>> event FD, rather than the KFD FD ioctl. It could be an ioctl of the
>>> event FD, or even simpler, you could use the write file-operation to
>>> write an event mask (of arbitrary length if you want to enable
>>> growth in the future). That way everything would be neatly
>>> encapsulated in the event FD private data.
>>>
>>> Two more comments inline ...
>>>
>>>  
>>>
>>> Am 2020-04-14 um 5:30 p.m. schrieb Amber Lin:
>>>
>>>     When the compute is malfunctioning or performance drops, the system admin
>>>
>>>     will use SMI (System Management Interface) tool to monitor/diagnostic what
>>>
>>>     went wrong. This patch provides an event watch interface for the user
>>>
>>>     space to register devices and subscribe events they are interested. After
>>>
>>>     registered, the user can use annoymous file descriptor's poll function
>>>
>>>     with wait-time specified and wait for events to happen. Once an event
>>>
>>>     happens, the user can use read() to retrieve information related to the
>>>
>>>     event.
>>>
>>>      
>>>
>>>     VM fault event is done in this patch.
>>>
>>>      
>>>
>>>     v2: - remove UNREGISTER and add event ENABLE/DISABLE
>>>
>>>         - correct kfifo usage
>>>
>>>         - move event message API to kfd_ioctl.h
>>>
>>>     v3: send the event msg in text than in binary
>>>
>>>     v4: support multiple clients
>>>
>>>      
>>>
>>>     Signed-off-by: Amber Lin <Amber.Lin@amd.com> <mailto:Amber.Lin@amd.com>
>>>
>>> [snip]
>>>
>>>     diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
>>>
>>>     index 4f66764..8146437 100644
>>>
>>>     --- a/include/uapi/linux/kfd_ioctl.h
>>>
>>>     +++ b/include/uapi/linux/kfd_ioctl.h
>>>
>>>     @@ -442,6 +442,36 @@ struct kfd_ioctl_import_dmabuf_args {
>>>
>>>       __u32 dmabuf_fd;       /* to KFD */
>>>
>>>      };
>>>
>>>      
>>>
>>>     +/*
>>>
>>>     + * KFD SMI(System Management Interface) events
>>>
>>>     + */
>>>
>>>     +enum kfd_smi_events_op {
>>>
>>>     + KFD_SMI_EVENTS_REGISTER = 1,
>>>
>>>     + KFD_SMI_EVENTS_ENABLE,
>>>
>>>     + KFD_SMI_EVENTS_DISABLE
>>>
>>>     +};
>>>
>>>     +
>>>
>>>     +/* Event type (defined by bitmask) */
>>>
>>>     +#define KFD_SMI_EVENT_VMFAULT     0x0000000000000001
>>>
>>>     +
>>>
>>>     +struct kfd_ioctl_smi_events_args {
>>>
>>>     + __u32 op;              /* to KFD */
>>>
>>>     + __u64 events;          /* to KFD */
>>>
>>> The binary layout of the ioctl args structure should be the same on
>>> 32/64-bit. That means the 64-bit members should be 64-bit aligned.
>>> The best way to ensure this is to put all the 64-bit members first.
>>>
>>>  
>>>
>>>      
>>>
>>>     + __u64 gpuids_array_ptr;        /* to KFD */
>>>
>>>     + __u32 num_gpuids;      /* to KFD */
>>>
>>>     + __u32 anon_fd;         /* from KFD */
>>>
>>>     + __u32 client_id;       /* to/from KFD */
>>>
>>>     +};
>>>
>>>     +
>>>
>>>     +/* 1. All messages must start with (hex)uint64_event(16) + space(1) +
>>>
>>>     + *    (hex)gpuid(8) + space(1) =  26 bytes
>>>
>>>     + * 2. VmFault msg = (hex)uint32_pid(8) + space(1) + task name(16) = 25
>>>
>>>     + *    When a new event msg uses more memory, change the calculation here.
>>>
>>>     + * 3. End with \n(1)
>>>
>>>     + * 26 + 25 + 1 = 52
>>>
>>>     + */
>>>
>>>     +#define KFD_SMI_MAX_EVENT_MSG 52
>>>
>>> If you define the maximum message length here, clients may start
>>> depending on it, and it gets harder to change it later. I'd not
>>> define this in the API header. It's not necessary to write correct
>>> clients. And if used badly, it may encourage writing incorrect
>>> clients that break with longer messages in the future.
>>>
>>> Regards,
>>>   Felix
>>>
>>>  
>>>
>>>      
>>>
>>>     +
>>>
>>>      /* Register offset inside the remapped mmio page
>>>
>>>       */
>>>
>>>      enum kfd_mmio_remap {
>>>
>>>     @@ -546,7 +576,10 @@ enum kfd_mmio_remap {
>>>
>>>      #define AMDKFD_IOC_ALLOC_QUEUE_GWS            \
>>>
>>>              AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)
>>>
>>>      
>>>
>>>     +#define AMDKFD_IOC_SMI_EVENTS                 \
>>>
>>>     +        AMDKFD_IOWR(0x1F, struct kfd_ioctl_smi_events_args)
>>>
>>>     +
>>>
>>>      #define AMDKFD_COMMAND_START           0x01
>>>
>>>     -#define AMDKFD_COMMAND_END             0x1F
>>>
>>>     +#define AMDKFD_COMMAND_END             0x20
>>>
>>>      
>>>
>>>      #endif
>>>
>

--------------D74223D6B1EFF019E0F7FCB3
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-1252">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">Am 2020-04-15 um 9:48 a.m. schrieb
      Deucher, Alexander:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB44886F41E8D3FCDFD7DED107F7DB0@MN2PR12MB4488.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p style="font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" align="Left">
        [AMD Public Use]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          We use the drm major/minor in all cases.&nbsp; Bump&nbsp;
          KMS_DRIVER_MINOR in amdgpu_drv.c and add a note about what was
          added in the comment.<br>
        </div>
      </div>
    </blockquote>
    <p>The KFD ioctl API has its own major and minor version defined in
      include/uapi/linux/kfd_ioctl.h. Thunk clients can query that
      version with hsaKmtGetVersion. We haven't been good at updating
      that version when we make API changes. Currently two versions are
      in use:</p>
    <p><br>
    </p>
    <p>Upstream: 1.1<br>
    </p>
    <p>DKMS: 1.2</p>
    <p><br>
    </p>
    <p>I think this would be a good time to start a habit of bumping the
      KFD ioctl minor version every time we change the upstream KFD
      ioctl API. We should skip version 1.2, since that is in use by the
      DKMS driver. We should also add a comment block above the version
      definition that explains the changes in each future API version
      update.<br>
    </p>
    <p><br>
    </p>
    <p>Thanks,<br>
      &nbsp; Felix<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:MN2PR12MB44886F41E8D3FCDFD7DED107F7DB0@MN2PR12MB4488.namprd12.prod.outlook.com">
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Alex<br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> Lin,
            Amber <a class="moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com">&lt;Amber.Lin@amd.com&gt;</a><br>
            <b>Sent:</b> Wednesday, April 15, 2020 9:36 AM<br>
            <b>To:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix
            <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Subject:</b> Re: [PATCH v4] drm/amdkfd: Provide SMI
            events watch</font>
          <div>&nbsp;</div>
        </div>
        <div><font size="&#43;1"><tt>Thank you Felix. Now I understand the
              problem of global client ID is leaking a hole for
              potential attackers. I didn't take that into
              consideration. I'll change that following your advice
              below.<br>
              <br>
              Hi Alex,<br>
              <br>
              Thank you for the link. It's helpful. I have a question
              regarding the versioning. One topic in the article talks
              about how the userspace can figure out if the new ioctl is
              supported in a given kernel. Is it correct that with dkms
              driver, we use the driver version coming from
              AMDGPU_VERSION in amdgpu_drv.c, and in upstream kernel we
              use the kernel version?<br>
              <br>
              Thanks.<br>
              <br>
              Amber<br>
            </tt></font><br>
          <div class="x_moz-cite-prefix">On 2020-04-14 11:03 p.m.,
            Deucher, Alexander wrote:<br>
          </div>
          <blockquote type="cite">
            <style type="text/css" style="display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
            <p style="font-family:Arial; font-size:10pt; color:#317100;
              margin:15pt" align="Left">
              [AMD Public Use]<br>
            </p>
            <br>
            <div>
              <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                Some good advice on getting ioctls right:</div>
              <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                <a href="https://www.kernel.org/doc/html/v5.4-preprc-cpu/ioctl/botching-up-ioctls.html" id="LPNoLP568680" moz-do-not-send="true">https://www.kernel.org/doc/html/v5.4-preprc-cpu/ioctl/botching-up-ioctls.html</a></div>
              <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                <br>
              </div>
              <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                Alex<br>
              </div>
              <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                <br>
              </div>
              <hr tabindex="-1" style="display:inline-block; width:98%">
              <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> amd-gfx
                  <a class="x_moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">
                    &lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
                  behalf of Felix Kuehling <a class="x_moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com" moz-do-not-send="true">
                    &lt;felix.kuehling@amd.com&gt;</a><br>
                  <b>Sent:</b> Tuesday, April 14, 2020 10:40 PM<br>
                  <b>To:</b> Lin, Amber <a class="x_moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com" moz-do-not-send="true">
                    &lt;Amber.Lin@amd.com&gt;</a>; <a class="x_moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    amd-gfx@lists.freedesktop.org</a> <a class="x_moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH v4] drm/amdkfd: Provide SMI
                  events watch</font>
                <div>&nbsp;</div>
              </div>
              <div>
                <p>Hi Amber,</p>
                <p>I understand that different processes can get the
                  same FD. My statement about FD being unique is
                  relative to one process.</p>
                <p>The main problem with the global client ID is, that
                  it allows process A to change the event mask of
                  process B just by specifying process B's client ID.
                  That can lead to denial of service attacks where
                  process A can cause events not to be delivered to B or
                  can flood process B with frequent events that it's not
                  prepared to handle.</p>
                <p>Therefore you must make the lookup of the client from
                  the client ID not from a global list, but from a
                  per-process list. That way process A can only change
                  event masks of process A clients, and not those of any
                  other process.</p>
                <p>But if the client list is process-specific, you can
                  use the FD as a unique identifier of the client within
                  the process, so you don't need a separate client ID.</p>
                <p>Regards,<br>
                  &nbsp; Felix<br>
                </p>
                <div class="x_x_moz-cite-prefix">Am 2020-04-14 um 8:09
                  p.m. schrieb Lin, Amber:<br>
                </div>
                <blockquote type="cite">
                  <meta name="Generator" content="Microsoft Word 15
                    (filtered medium)">
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
p.x_x_MsoNormal, li.x_x_MsoNormal, div.x_x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New"}
span.x_x_HTMLPreformattedChar
	{font-family:Consolas}
p.x_x_msipheader4d0fcdd7, li.x_x_msipheader4d0fcdd7, div.x_x_msipheader4d0fcdd7
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_x_EmailStyle22
	{font-family:"Arial",sans-serif;
	color:#0078D7}
.x_x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
ol
	{margin-bottom:0in}
ul
	{margin-bottom:0in}
-->
</style>
                  <div class="x_x_WordSection1">
                    <p class="x_x_msipheader4d0fcdd7" style="margin:0in;
                      margin-bottom:.0001pt"><span style="font-size:10.0pt;
                        font-family:&quot;Arial&quot;,sans-serif;
                        color:#0078D7">[AMD Official Use Only - Internal
                        Distribution Only]</span></p>
                    <p class="x_x_MsoNormal">&nbsp;</p>
                    <p class="x_x_MsoNormal">Hi Felix,</p>
                    <p class="x_x_MsoNormal">&nbsp;</p>
                    <p class="x_x_MsoNormal">That was my assumption too
                      that each registration will get different file
                      descriptor, but it turns out not. When I started
                      two process and both register gpu0 and gpu1, they
                      both got fd=15. If I have process A register
                      gpu0&#43;gpu1, and process B only register gpu0,
                      process A gets fd=15 and process B gets fd=9.
                      That’s why I added client ID.</p>
                    <p class="x_x_MsoNormal">&nbsp;</p>
                    <p class="x_x_MsoNormal">By multiple clients, I mean
                      multiple processes. The ask is users want to have
                      multiple tools and those different tools can use
                      rsmi lib to watch events at the same time. Due to
                      the reason above that two processes can actually
                      get the same fd and I need to add client ID to
                      distinguish the registration, I don’t see the
                      point of limiting one registration per process
                      unless I use pid to distinguish the client
                      instead, which was in my consideration too when I
                      was writing the code. But second thought is why
                      adding this restriction when client ID can allow
                      the tool to watch different events on different
                      devices if they want to. Maybe client ID is a bad
                      term and it misleads you. I should call it
                      register ID.</p>
                    <p class="x_x_MsoNormal">&nbsp;</p>
                    <div>
                      <p class="x_x_MsoNormal">Regards,</p>
                      <p class="x_x_MsoNormal">Amber</p>
                    </div>
                    <p class="x_x_MsoNormal">&nbsp;</p>
                    <div>
                      <div style="border:none; border-top:solid #E1E1E1
                        1.0pt; padding:3.0pt 0in 0in 0in">
                        <p class="x_x_MsoNormal"><b>From:</b> Kuehling,
                          Felix <a class="x_x_moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">
                            &lt;Felix.Kuehling@amd.com&gt;</a> <br>
                          <b>Sent:</b> Tuesday, April 14, 2020 7:04 PM<br>
                          <b>To:</b> Lin, Amber <a class="x_x_moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com" moz-do-not-send="true">
                            &lt;Amber.Lin@amd.com&gt;</a>; <a class="x_x_moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                            amd-gfx@lists.freedesktop.org</a><br>
                          <b>Subject:</b> Re: [PATCH v4] drm/amdkfd:
                          Provide SMI events watch</p>
                      </div>
                    </div>
                    <p class="x_x_MsoNormal">&nbsp;</p>
                    <p>Hi Amber,</p>
                    <p>Some general remarks about the multi-client
                      support. You added a global client id that's
                      separate from the file descriptor. That's
                      problematic for two reasons:</p>
                    <ol type="1" start="1">
                      <li class="x_x_MsoNormal" style="">A process could
                        change a different process' event mask</li>
                      <li class="x_x_MsoNormal" style="">The FD should
                        already be unique per process, no need to invent
                        another ID</li>
                    </ol>
                    <p>If we want to allow one process to register for
                      events multiple times (multiple FDs per process),
                      then the list of clients should be per process.
                      Each process should only be allowed to change the
                      event masks of its own clients. The client could
                      be identified by its FD. No need for another
                      client ID.</p>
                    <p>But you could also simplify it further by
                      allowing only one event client per process. Then
                      you don't need the client ID lookup at all. Just
                      have a single event client in the kfd_process.</p>
                    <p>Another approach would be to make enable/disable
                      functions of the event FD, rather than the KFD FD
                      ioctl. It could be an ioctl of the event FD, or
                      even simpler, you could use the write
                      file-operation to write an event mask (of
                      arbitrary length if you want to enable growth in
                      the future). That way everything would be neatly
                      encapsulated in the event FD private data.</p>
                    <p>Two more comments inline ...</p>
                    <p>&nbsp;</p>
                    <div>
                      <p class="x_x_MsoNormal">Am 2020-04-14 um 5:30
                        p.m. schrieb Amber Lin:</p>
                    </div>
                    <blockquote style="margin-top:5.0pt;
                      margin-bottom:5.0pt">
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
                    <blockquote style="margin-top:5.0pt;
                      margin-bottom:5.0pt">
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
                    <p>The binary layout of the ioctl args structure
                      should be the same on 32/64-bit. That means the
                      64-bit members should be 64-bit aligned. The best
                      way to ensure this is to put all the 64-bit
                      members first.</p>
                    <p class="x_x_MsoNormal" style="margin-bottom:12.0pt">&nbsp;</p>
                    <blockquote style="margin-top:5.0pt;
                      margin-bottom:5.0pt">
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
                    <p>If you define the maximum message length here,
                      clients may start depending on it, and it gets
                      harder to change it later. I'd not define this in
                      the API header. It's not necessary to write
                      correct clients. And if used badly, it may
                      encourage writing incorrect clients that break
                      with longer messages in the future.</p>
                    <p>Regards,<br>
                      &nbsp; Felix</p>
                    <p>&nbsp;</p>
                    <blockquote style="margin-top:5.0pt;
                      margin-bottom:5.0pt">
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
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------D74223D6B1EFF019E0F7FCB3--

--===============1990085857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1990085857==--
