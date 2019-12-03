Return-Path: <SRS0=OLW4=ZZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,HTTPS_HTTP_MISMATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497CCC432C0
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 17:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157232073B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 17:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157232073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D59E46EA25;
	Tue,  3 Dec 2019 17:29:36 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800087.outbound.protection.outlook.com [40.107.80.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 676246EA25
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2019 17:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4vkCnJESvo8J5WXMy87JTLtZnZZvC2vJ0X3ihhMnKdlrbpd011grG7JHKb5D3wPVCF/1oLFNZUX2Y90mUKMaReRbXI5R1mRVnQI+i1VKDPip3am2QqYBY+hhmS/IOhbPys+D+OHp62Ahi0DwDACBglj85g+rg3PIQ0q5QtXEzURfLwvJJujeEOfjIv8KtJztCDA0XwI8ILAwlcWLv4FPOWiVi4bcy3wUuc2sSwEZ0CjTwIJL3ld+eXbp8/KNF7aUUu8Glkfgk8JHYJLVhiBEBksJgLnTbVItL0Vhb3i2jxpKFEbdCLu4NNC68+ZJj63bkdFO4+4PxPKn35fwDNIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6SLI1xFN6LXNmhhcG2+YSdc3DTiQNVfWZep8YRpXcU=;
 b=GvWM3MVGqQ4PvW4sY/I60xoS0G6RBUfblEgaMyauPJrYumqTYTuPtobwGiqlRIORZk5V/EGsHGd7E4rBMXHnxdY3An6S24hKeaMazKz+1n6xm8k6e6JFmv4ue+QjAZFgFDkyg0FD9bdHq+uGguCaDEHGjAriTt8JqcE2E7QoEXSMYbNXdX99WyFLgSmiVIrT3gwbAopFlFRK4y6DzXRi2XHYMweyyn6wZw0+OKBuFp326TnISrV6uHNRZxltoeH/MpYLJ/Q0W6+pHQ+whUeO9CjN0LbKqBMYw+iDVfeX2Vst9GTLh/A8Cya3aoZ0prrFDjfx6Cqohd/cJPsPQAoVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2533.namprd12.prod.outlook.com (52.132.139.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 17:29:27 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 17:29:27 +0000
Subject: Re: [error] Drm -> amdgpu Unrecoverable Machine Check
To: =?UTF-8?Q?Yusuf_Alt=c4=b1parmak?= <yusufalti1997@gmail.com>
References: <CAGzVRjxGE5p3AVQf=dm4ubBrKgbTagr4QrUJo=bPmueNSyjecw@mail.gmail.com>
 <1b8f92ae-6faa-49a4-8b38-6bccec006b68@gmail.com>
 <CAGzVRjyz7P3uiCgyFX=zZ4xzKwN+X2i8y7oabNkLBU4CnRpBmw@mail.gmail.com>
 <ec0b6313-1a5a-8195-84da-ee549f82f142@amd.com>
 <CAGzVRjzELaG_CToBxUWzh+kadp3qUQY6RQSGHMO1W1eSs+d-_w@mail.gmail.com>
 <ee330d5d-047e-8342-9c40-c547dcc7a17c@gmail.com>
 <CAGzVRjxFx-+Rduwm2ejxzkNnCQq_pyT9k0LO1z5_MSq95EmOxQ@mail.gmail.com>
 <CAGzVRjzDKaA96VqXq=W3jUDJga3Fc=vWOm_XQE9e6WTTNujXaA@mail.gmail.com>
 <e295f685-a46b-dcea-ad65-627f8839da2b@amd.com>
 <CAGzVRjz-EEZDamT3OvJ8r9ERd7gNLdjBwaOisnQ9pY_MPKAKyg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <80c63f19-d1a2-1310-c93f-9f4e292cffef@amd.com>
Date: Tue, 3 Dec 2019 18:29:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CAGzVRjz-EEZDamT3OvJ8r9ERd7gNLdjBwaOisnQ9pY_MPKAKyg@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0152.eurprd05.prod.outlook.com
 (2603:10a6:207:3::30) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe76f19c-fda5-40fb-a036-08d778165890
X-MS-TrafficTypeDiagnostic: DM5PR12MB2533:
X-Microsoft-Antispam-PRVS: <DM5PR12MB253332B5AD21D8331A67074183420@DM5PR12MB2533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 02408926C4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(6916009)(8936002)(386003)(6246003)(606006)(31686004)(86362001)(31696002)(65956001)(99286004)(66556008)(1411001)(66946007)(14454004)(5660300002)(966005)(6116002)(66574012)(45080400002)(16586007)(30864003)(66476007)(316002)(478600001)(8676002)(2906002)(81156014)(81166006)(37036004)(25786009)(2616005)(36756003)(46003)(71190400001)(14444005)(5024004)(11346002)(446003)(6666004)(6306002)(236005)(229853002)(6512007)(6486002)(54896002)(4326008)(186003)(52116002)(7736002)(58126008)(33964004)(6436002)(6506007)(76176011)(569006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2533;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8qs1YnaJ60meKcQF5dsDLnH72jZQLJJ1Nz0KykYrXIsZzKxpcU5G1z0duuN9+RA92fTpruqVFnN2FalnsvDzd56qpy6XcAJW/qz4GSNn3k5/ZJpKlygbE33lGMDgV4oLGS/YSMEGJW4ufOp43k/YStRA+chs3xkfpFPugyV+iQXq2cx1eHdoCv3dvTKknILvK/5kw/FREL/W1/Q4K2Dg0OY2kHM3VtxCpk01MUsztDOY8HoBGDlTR1pr3QDri5OzyhweFgIJNNj6P9x5OwZwHb0pyddK7J6QdpN8sqn43B00XmlR0MDfYKNYklWpJDi3KzwJdpLU5lKl9FotO93CzLe9y4pEdi4gF0+XoB1BgLv9LCtcjzO3yIKtWshFglI7og/x5P/Oj8oxhdzsRLzQFJrnyGauuyCgX9qeEiXPw/I4Qk9LkUqQWEMu65tydSgAFcnb76XHnd76PBnjWUysqXwdnugFgcKCPop1kMORNIg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe76f19c-fda5-40fb-a036-08d778165890
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 17:29:27.3878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+pDvxOMnZOy66QAGd0MAiAM170ssiAm+8sEUGQ8pfQJjIi1Tl6IDKJ1xziwmerk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2533
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6SLI1xFN6LXNmhhcG2+YSdc3DTiQNVfWZep8YRpXcU=;
 b=uMWxnOAeCbPfQCZnVc3N3p2I6VXmUAcVwDciXfrVGs7GtuIJ8nJIibOFeQwtLBdjhv00XgrF+MV/rZkNFvPHSctYkddC4p94O8apVxLAUFwdEZLXjo74+EQWJcOcHLIPZY6A5tj9VB8666JUAihh6/hmtLDZftP2fl+YSg2gvVI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1576035964=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1576035964==
Content-Type: multipart/alternative;
 boundary="------------540460194482394818D16F20"
Content-Language: en-US

--------------540460194482394818D16F20
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> Right now I am trying to increase MMIO size config to 512 MB
What you could try as well is to use the size 320MB for the MMIO. Those 
ranges usually don't need to be a power of two (only the BARs itself are 
a power of two) and this way it might even be easier to fit everything 
together.

> By the way I wonder how can I get at least VGA output from GPU. Maybe 
> I can get a text console on screen or something like X server? Do you 
> have any recommendations?
What could maybe work is VGA emulation, which essentially means text 
only. But no guarantee for that this really works as expected.

> I am just wondering, does modern gaming motherboards have more than 
> 4GB PCIe buffer for this job ?
They don't, resources are dynamically assigned instead.

See on x86 you usually have 1GB 32-bit address space where the BIOS 
shuffles all the mandatory devices it sees at boot time into.

Then when the motherboard has multiple PEG slots the BIOS also 
configures a 64-bit address space which is usually rather huge 
(256GB-1TB). Since the the VRAM and the doorbell BAR are 64bit BARs on 
the GPU they can be mapped into that as well.

This way you can easily have 10 GPUs connected to your CPU.

The problem you have here is that U-config doesn't do this resource 
assignment automatically and you need to configure it manually.

Regards,
Christian.

Am 03.12.19 um 13:50 schrieb Yusuf Altıparmak:
>
> Hi Christian,
>
>>     0001f000
>     Exactly as I thought. The hardware does support BAR resize, but
>     unfortunately 256MB is already the minimum.
>
>     Sorry, but there isn't anything I could do from the GPU drivers
>     point of view.
>
>
> Yes unfortunately there is nothing remained to about GPU side.
>
>     The only good news I have is that 256M+2M+512K+128K=260M address
>     space should be enough for the GPU to work, maybe that makes
>     things a bit simpler.
>
>
> Right now I am trying to increase MMIO size config to 512 MB, I hope 
> that should help me. By the way I wonder how can I get at least VGA 
> output from GPU. Maybe I can get a text console on screen or something 
> like X server? Do you have any recommendations? I tried this GPU with 
> my own Ubuntu 18.04 and its special driver. Everything worked fine.
>
>     But you definitely got an interesting use case here :)
>
>
> This is the worlds the most interesting use case I think. I can't 
> increase MMIO size because U-boot freezes. I can't decrease it to 256 
> MB again because driver does not accept :D. I am just wondering, does 
> modern gaming motherboards have more than 4GB PCIe buffer for this job 
> ? :D
>
>
>     Am 03.12.19 um 11:31 schrieb Yusuf Altıparmak:
>>     Hello Christian,
>>     My "setpci -s 0001:01:00.0 ECAP15+4.l ECAP15+8.l" output is;
>>
>>     0001f000
>>     00000820
>>
>>     Regards.
>>
>>
>>
>>     Yusuf Altıparmak <yusufalti1997@gmail.com
>>     <mailto:yusufalti1997@gmail.com>>, 2 Ara 2019 Pzt, 19:31
>>     tarihinde şunu yazdı:
>>
>>             Most likely not. There is support for resizing the VRAM
>>             BAR, but usually you can only make it larger and not smaller.
>>             Please give me the output of "sudo setpci -s 0001:01:00.0
>>             ECAP15+4.l ECAP15+8.l" if you want to double check that.
>>
>>
>>         Okay I'll try it tomorrow. What does the " sudo setpci -s
>>         0001:01:00.0 ECAP15+4.l ECAP15+8.l" command exactly do ?
>>
>>             Well you rather need to ask if anybody has sample PCIe
>>             configuration for GPUs in general. That problem is not
>>             really E9171 related. You might want to ask NXP for that
>>             maybe.
>>             Sorry, no idea if that is correct or not. You need to ask
>>             NXP for help with that.
>>
>>
>>         Okay no problem. At least I know what is the missing point
>>         now. The problem is probably because of the .dtsi and u-boot
>>         config files. Memory ranges are overwriting like you said.
>>         I'll ask nxp to take some sample PCIe configuration for GPUs.
>>
>>         Thank you for your interest Christian.
>>         Regards .
>>
>>>
>>>                 Am 02.12.19 um 14:32 schrieb Yusuf Altıparmak:
>>>>
>>>>
>>>>>                     I attached my dts file.
>>>>>
>>>>>                     System is working fine when GPU is not plugged in.
>>>>>                     *
>>>>>                     *
>>>>>                     *This is the last console log before freeze:*
>>>>>                     [drm] amdgpu kernel modesetting enabled.
>>>>>                     [drm] initializing kernel modesetting
>>>>>                     (POLARIS12 0x1002:0x6987 0x1787:0x2389 0x80).
>>>>>                     [drm] register mmio base: 0x20200000
>>>>>                     fsl-fman-port ffe488000.port fm1-gb0: renamed
>>>>>                     from eth0
>>>>>                     [drm] register mmio size: 262144
>>>>>                     [drm] add ip block number 0 <vi_common>
>>>>>                     [drm] add ip block number 1 <gmc_v8_0>
>>>>>                     [drm] add ip block number 2 <tonga_ih>
>>>>>                     [drm] add ip block number 3 <powerplay>
>>>>>                     [drm] add ip block number 4 <dm>
>>>>>                     [drm] add ip block number 5 <gfx_v8_0>
>>>>>                     [drm] add ip block number 6 <sdma_v3_0>
>>>>>                     [drm] add ip block number 7 <uvd_v6_0>
>>>>>                     [drm] add ip block number 8 <vce_v3_0>
>>>>>                     [drm] UVD is enabled in VM mode
>>>>>                     [drm] UVD ENC is enabled in VM mode
>>>>>                     [drm] VCE enabled in VM mode
>>>>>                     ATOM BIOS: 113-ER16BFC-001
>>>>>                     [drm] GPU posting now...
>>>>>                     Disabling lock debugging due to kernel taint
>>>>>                     Machine check in kernel mode.
>>>>>                     Caused by (from MCSR=a000): Load Error Report
>>>>>                     Guarded Load Error Report
>>>>>                     Kernel panic - not syncing: Unrecoverable
>>>>>                     Machine check
>>>>>                     CPU: 1 PID: 2023 Comm: udevd Tainted: G   M
>>>>>                      4.19.26+gc0c2141 #1
>>>>>                     Call Trace:
>>>>
>>>>>
>>>>>
>>>>>                     _______________________________________________
>>>>>                     amd-gfx mailing list
>>>>>                     amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>>>>                     https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Cchristian.koenig%40amd.com%7C561d9d3206ff46d338ad08d777ef717c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637109742603335427&sdata=DstGsDW0X7ennQoF1vg%2FYLGAStF4p1dAeMFhzsAFc1I%3D&reserved=0>
>>>>
>>>>
>>>>
>>>>                 Christian König <ckoenig.leichtzumerken@gmail.com
>>>>                 <mailto:ckoenig.leichtzumerken@gmail.com>>, 2 Ara
>>>>                 2019 Pzt, 15:28 tarihinde şunu yazdı:
>>>>
>>>>                     Hi Yusuf,
>>>>
>>>>                     Am 02.12.19 um 12:41 schrieb Yusuf Altıparmak:
>>>>>                     My embedded board is freezing when I put E9171
>>>>>                     on PCIe. What is the meaning of Unrecoverable
>>>>>                     Machine Check error about GPU?
>>>>
>>>>                     Well see the explanation on Wikipedia for
>>>>                     example:
>>>>                     https://en.wikipedia.org/wiki/Machine-check_exception
>>>>                     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FMachine-check_exception&data=02%7C01%7Cchristian.koenig%40amd.com%7C561d9d3206ff46d338ad08d777ef717c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637109742603345420&sdata=NtHiZmL7me4JRZR4L9KHZzpD8Zcn6caURVvtiDSgHsE%3D&reserved=0>
>>>>
>>>>                     In general it means you have messed up
>>>>                     something in your hardware configuration.
>>>>
>>>>>                     Could PCIe settings in .dts file cause this
>>>>>                     problem?
>>>>
>>>>                     Possible, but rather unlikely. My best guess is
>>>>                     that it is some problem with the power supply.
>>>>
>>>>>                     If it is, is there any sample PCIe
>>>>>                     configuration for E9171?
>>>>
>>>>                     The E9171 is just a PCIe device, so the dtsi is
>>>>                     actually rather uninteresting. What we really
>>>>                     need is a full dmesg and maybe lspci output
>>>>                     would help as well.
>>>>
>>>>                     Regards,
>>>>                     Christian.
>>>>
>>>>
>>>>
>>>>                 Hi Christian,
>>>>
>>>>                 At first, I am using NXP T1042D4RDB-64B which has
>>>>                 256 MB PCIe buffer according to its. PCIe memory
>>>>                 range was arranged to 256 MB in .dts file and in
>>>>                 U-boot configuration file. Driver was giving error
>>>>                 with exit code -12 (OUT_OF_MEMORY). But I was able
>>>>                 to reach the linux console.
>>>>
>>>>                 [    5.512922] [drm] amdgpu kernel modesetting enabled.
>>>>                 [    5.517065] [drm] initializing kernel
>>>>                 modesetting (POLARIS12 0x1002:0x6987 0x1787:0x2389
>>>>                 0x80).
>>>>                 [    5.524507] amdgpu 0001:01:00.0: Fatal error
>>>>                 during GPU init
>>>>                 [    5.529296] amdgpu: probe of 0001:01:00.0 failed
>>>>                 with error -12
>>>>
>>>>                 Then I canged 256 MB to 4GB in .dtsi and U-boot
>>>>                 conf file. I also changed 64KB I/O size to 1MB .
>>>>                 When I do this, I wasn't able to reach the linux
>>>>                 console because board was freezing. But driver was
>>>>                 successfull at this time. I already mentioned
>>>>                 successfull driver console logs up.
>>>>
>>>>                 *this is lspci -v when GPU is plugged and Memory
>>>>                 size is 256 MB.*
>>>>
>>>>                 root@t1042d4rdb-64b:~# lspci -v
>>>>                 0000:00:00.0 PCI bridge: Freescale Semiconductor
>>>>                 Inc Device 0824 (rev 11) (prog-if 00 [Normal decode])
>>>>                         Device tree node:
>>>>                 /sys/firmware/devicetree/base/pcie@ffe240000/pcie@0
>>>>                         Flags: bus master, fast devsel, latency 0,
>>>>                 IRQ 20
>>>>                         Memory at <ignored> (32-bit, non-prefetchable)
>>>>                         Bus: primary=00, secondary=01,
>>>>                 subordinate=01, sec-latency=0
>>>>                         I/O behind bridge: 00000000-0000ffff [size=64K]
>>>>                         Memory behind bridge: e0000000-efffffff
>>>>                 [size=256M]
>>>>                         Prefetchable memory behind bridge: None
>>>>                 Capabilities: [44] Power Management version 3
>>>>                 Capabilities: [4c] Express Root Port (Slot-), MSI 00
>>>>                 Capabilities: [100] Advanced Error Reporting
>>>>                         Kernel driver in use: pcieport
>>>>
>>>>                 0001:00:00.0 PCI bridge: Freescale Semiconductor
>>>>                 Inc Device 0824 (rev 11) (prog-if 00 [Normal decode])
>>>>                         Device tree node:
>>>>                 /sys/firmware/devicetree/base/pcie@ffe250000/pcie@0
>>>>                         Flags: bus master, fast devsel, latency 0,
>>>>                 IRQ 21
>>>>                         Memory at <ignored> (32-bit, non-prefetchable)
>>>>                         Bus: primary=00, secondary=01,
>>>>                 subordinate=01, sec-latency=0
>>>>                         I/O behind bridge: 00000000-0000ffff [size=64K]
>>>>                         Memory behind bridge: e0000000-efffffff
>>>>                 [size=256M]
>>>>                         Prefetchable memory behind bridge: None
>>>>                 Capabilities: [44] Power Management version 3
>>>>                 Capabilities: [4c] Express Root Port (Slot-), MSI 00
>>>>                 Capabilities: [100] Advanced Error Reporting
>>>>                         Kernel driver in use: pcieport
>>>>
>>>>                 0001:01:00.0 VGA compatible controller: Advanced
>>>>                 Micro Devices, Inc. [AMD/ATI] Lexa [Radeon E9171
>>>>                 MCM] (rev 80) (prog-if 00 [VGA controller])
>>>>                         Subsystem: Hightech Information System Ltd.
>>>>                 Device 2389
>>>>                         Flags: fast devsel, IRQ 41
>>>>                         Memory at c10000000 (64-bit, prefetchable)
>>>>                 [size=256M]
>>>>                         Memory at <ignored> (64-bit, prefetchable)
>>>>                         I/O ports at 1100 [size=256]
>>>>                         Memory at <ignored> (32-bit, non-prefetchable)
>>>>                         Expansion ROM at <ignored> [disabled]
>>>>                 Capabilities: [48] Vendor Specific Information:
>>>>                 Len=08 <?>
>>>>                 Capabilities: [50] Power Management version 3
>>>>                 Capabilities: [58] Express Legacy Endpoint, MSI 00
>>>>                 Capabilities: [a0] MSI: Enable- Count=1/1 Maskable-
>>>>                 64bit+
>>>>                 Capabilities: [100] Vendor Specific Information:
>>>>                 ID=0001 Rev=1 Len=010 <?>
>>>>                 Capabilities: [150] Advanced Error Reporting
>>>>                 Capabilities: [200] Resizable BAR <?>
>>>>                 Capabilities: [270] Secondary PCI Express <?>
>>>>                 Capabilities: [2b0] Address Translation Service (ATS)
>>>>                 Capabilities: [2c0] Page Request Interface (PRI)
>>>>                 Capabilities: [2d0] Process Address Space ID (PASID)
>>>>                 Capabilities: [320] Latency Tolerance Reporting
>>>>                 Capabilities: [328] Alternative Routing-ID
>>>>                 Interpretation (ARI)
>>>>                 Capabilities: [370] L1 PM Substates
>>>>                         Kernel modules: amdgpu
>>>>
>>>>                 0001:01:00.1 Audio device: Advanced Micro Devices,
>>>>                 Inc. [AMD/ATI] Device aae0
>>>>                         Subsystem: Hightech Information System Ltd.
>>>>                 Device aae0
>>>>                         Flags: bus master, fast devsel, latency 0,
>>>>                 IRQ 17
>>>>                         Memory at <ignored> (64-bit, non-prefetchable)
>>>>                 Capabilities: [48] Vendor Specific Information:
>>>>                 Len=08 <?>
>>>>                 Capabilities: [50] Power Management version 3
>>>>                 Capabilities: [58] Express Legacy Endpoint, MSI 00
>>>>                 Capabilities: [a0] MSI: Enable- Count=1/1 Maskable-
>>>>                 64bit+
>>>>                 Capabilities: [100] Vendor Specific Information:
>>>>                 ID=0001 Rev=1 Len=010 <?>
>>>>                 Capabilities: [150] Advanced Error Reporting
>>>>                 Capabilities: [328] Alternative Routing-ID
>>>>                 Interpretation (ARI)
>>>>
>>>>                 0002:00:00.0 PCI bridge: Freescale Semiconductor
>>>>                 Inc Device 0824 (rev 11) (prog-if 00 [Normal decode])
>>>>                         Device tree node:
>>>>                 /sys/firmware/devicetree/base/pcie@ffe260000/pcie@0
>>>>                         Flags: bus master, fast devsel, latency 0,
>>>>                 IRQ 22
>>>>                         Memory at <ignored> (32-bit, non-prefetchable)
>>>>                         Bus: primary=00, secondary=01,
>>>>                 subordinate=01, sec-latency=0
>>>>                         I/O behind bridge: 00000000-0000ffff [size=64K]
>>>>                         Memory behind bridge: e0000000-efffffff
>>>>                 [size=256M]
>>>>                         Prefetchable memory behind bridge: None
>>>>                 Capabilities: [44] Power Management version 3
>>>>                 Capabilities: [4c] Express Root Port (Slot-), MSI 00
>>>>                 Capabilities: [100] Advanced Error Reporting
>>>>                         Kernel driver in use: pcieport
>>>>
>>>>                 0003:00:00.0 PCI bridge: Freescale Semiconductor
>>>>                 Inc Device 0824 (rev 11) (prog-if 00 [Normal decode])
>>>>                         Device tree node:
>>>>                 /sys/firmware/devicetree/base/pcie@ffe270000/pcie@0
>>>>                         Flags: bus master, fast devsel, latency 0,
>>>>                 IRQ 23
>>>>                         Memory at <ignored> (32-bit, non-prefetchable)
>>>>                         Bus: primary=00, secondary=01,
>>>>                 subordinate=01, sec-latency=0
>>>>                         I/O behind bridge: 00000000-0000ffff [size=64K]
>>>>                         Memory behind bridge: e0000000-efffffff
>>>>                 [size=256M]
>>>>                         Prefetchable memory behind bridge: None
>>>>                 Capabilities: [44] Power Management version 3
>>>>                 Capabilities: [4c] Express Root Port (Slot-), MSI 00
>>>>                 Capabilities: [100] Advanced Error Reporting
>>>>                         Kernel driver in use: pcieport
>>>>
>>>>                 *AND This is PCIe dmesg message when memory range
>>>>                 is 256MB. It's also giving same message when memory
>>>>                 range is arranged as 4GB;*
>>>>
>>>>                 PCI host bridge /pcie@ffe240000  ranges:
>>>>                  MEM 0x0000000c00000000..0x0000000c0fffffff ->
>>>>                 0x00000000e0000000
>>>>                   IO 0x0000000ff8000000..0x0000000ff800ffff ->
>>>>                 0x0000000000000000
>>>>                 /pcie@ffe240000: PCICSRBAR @ 0xff000000
>>>>                 setup_pci_atmu: end of DRAM 200000000
>>>>                 /pcie@ffe240000: Setup 64-bit PCI DMA window
>>>>                 /pcie@ffe240000: WARNING: Outbound window cfg
>>>>                 leaves gaps in memory map. Adjusting the memory map
>>>>                 could reduce unnecessary bounce buffering.
>>>>                 /pcie@ffe240000: DMA window size is 0xe0000000
>>>>                 Found FSL PCI host bridge at 0x0000000ffe250000.
>>>>                 Firmware bus number: 0->1
>>>>                 PCI host bridge /pcie@ffe250000  ranges:
>>>>                  MEM 0x0000000c10000000..0x0000000c1fffffff ->
>>>>                 0x00000000e0000000
>>>>                   IO 0x0000000ff8010000..0x0000000ff801ffff ->
>>>>                 0x0000000000000000
>>>>                 /pcie@ffe250000: PCICSRBAR @ 0xff000000
>>>>                 setup_pci_atmu: end of DRAM 200000000
>>>>                 /pcie@ffe250000: Setup 64-bit PCI DMA window
>>>>                 /pcie@ffe250000: WARNING: Outbound window cfg
>>>>                 leaves gaps in memory map. Adjusting the memory map
>>>>                 could reduce unnecessary bounce buffering.
>>>>                 /pcie@ffe250000: DMA window size is 0xe0000000
>>>>                 Found FSL PCI host bridge at 0x0000000ffe260000.
>>>>                 Firmware bus number: 0->0
>>>>                 PCI host bridge /pcie@ffe260000  ranges:
>>>>                  MEM 0x0000000c20000000..0x0000000c2fffffff ->
>>>>                 0x00000000e0000000
>>>>                   IO 0x0000000ff8020000..0x0000000ff802ffff ->
>>>>                 0x0000000000000000
>>>>                 /pcie@ffe260000: PCICSRBAR @ 0xff000000
>>>>                 setup_pci_atmu: end of DRAM 200000000
>>>>                 /pcie@ffe260000: Setup 64-bit PCI DMA window
>>>>                 /pcie@ffe260000: WARNING: Outbound window cfg
>>>>                 leaves gaps in memory map. Adjusting the memory map
>>>>                 could reduce unnecessary bounce buffering.
>>>>                 /pcie@ffe260000: DMA window size is 0xe0000000
>>>>                 Found FSL PCI host bridge at 0x0000000ffe270000.
>>>>                 Firmware bus number: 0->0
>>>>                 PCI host bridge /pcie@ffe270000  ranges:
>>>>                  MEM 0x0000000c30000000..0x0000000c3fffffff ->
>>>>                 0x00000000e0000000
>>>>                   IO 0x0000000ff8030000..0x0000000ff803ffff ->
>>>>                 0x0000000000000000
>>>>                 /pcie@ffe270000: PCICSRBAR @ 0xff000000
>>>>                 setup_pci_atmu: end of DRAM 200000000
>>>>                 /pcie@ffe270000: Setup 64-bit PCI DMA window
>>>>                 /pcie@ffe270000: WARNING: Outbound window cfg
>>>>                 leaves gaps in memory map. Adjusting the memory map
>>>>                 could reduce unnecessary bounce buffering.
>>>>                 /pcie@ffe270000: DMA window size is 0xe0000000
>>>>                 iommu: Adding device ff6000000.qman-portal to group 0
>>>>                 iommu: Adding device ff6004000.qman-portal to group 1
>>>>                 iommu: Adding device ff6008000.qman-portal to group 2
>>>>                 iommu: Adding device ff600c000.qman-portal to group 3
>>>>                 iommu: Adding device ff6010000.qman-portal to group 4
>>>>                 iommu: Adding device ff6014000.qman-portal to group 5
>>>>                 iommu: Adding device ff6018000.qman-portal to group 6
>>>>                 iommu: Adding device ff601c000.qman-portal to group 7
>>>>                 iommu: Adding device ff6020000.qman-portal to group 8
>>>>                 iommu: Adding device ff6024000.qman-portal to group 9
>>>>                 iommu: Adding device ffe100300.dma to group 10
>>>>                 iommu: Adding device ffe101300.dma to group 11
>>>>                 iommu: Adding device ffe114000.sdhc to group 12
>>>>                 iommu: Adding device ffe210000.usb to group 13
>>>>                 iommu: Adding device ffe211000.usb to group 14
>>>>                 iommu: Adding device ffe220000.sata to group 15
>>>>                 iommu: Adding device ffe221000.sata to group 16
>>>>                 iommu: Adding device ffe318000.qman to group 17
>>>>                 iommu: Adding device ffe31a000.bman to group 18
>>>>                 iommu: Adding device ffe240000.pcie to group 19
>>>>                 iommu: Adding device ffe250000.pcie to group 20
>>>>                 iommu: Adding device ffe260000.pcie to group 21
>>>>                 iommu: Adding device ffe270000.pcie to group 22
>>>>                 iommu: Adding device ffe140000.qe to group 23
>>>>                 software IO TLB: mapped [mem 0xfbfff000-0xfffff000]
>>>>                 (64MB)
>>>>                 PCI: Probing PCI hardware
>>>>                 fsl-pci ffe240000.pcie: PCI host bridge to bus 0000:00
>>>>                 pci_bus 0000:00: root bus resource [io
>>>>                  0x8000080000010000-0x800008000001ffff] (bus
>>>>                 address [0x0000-0xffff])
>>>>                 pci_bus 0000:00: root bus resource [mem
>>>>                 0xc00000000-0xc0fffffff] (bus address
>>>>                 [0xe0000000-0xefffffff])
>>>>                 pci_bus 0000:00: root bus resource [bus 00]
>>>>                 iommu: Removing device ffe240000.pcie from group 19
>>>>                 iommu: Adding device 0000:00:00.0 to group 24
>>>>                 pci 0000:00:00.0: bridge configuration invalid
>>>>                 ([bus 00-00]), reconfiguring
>>>>                 pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>>>>                 fsl-pci ffe250000.pcie: PCI host bridge to bus 0001:00
>>>>                 pci_bus 0001:00: root bus resource [io
>>>>                  0x8000080000021000-0x8000080000030fff] (bus
>>>>                 address [0x0000-0xffff])
>>>>                 pci_bus 0001:00: root bus resource [mem
>>>>                 0xc10000000-0xc1fffffff] (bus address
>>>>                 [0xe0000000-0xefffffff])
>>>>                 pci_bus 0001:00: root bus resource [bus 00-01]
>>>>                 iommu: Removing device ffe250000.pcie from group 20
>>>>                 iommu: Adding device 0001:00:00.0 to group 19
>>>>                 pci 0001:01:00.0: enabling Extended Tags
>>>>                 pci 0001:01:00.0: 4.000 Gb/s available PCIe
>>>>                 bandwidth, limited by 5 GT/s x1 link at
>>>>                 0001:00:00.0 (capable of 63.008 Gb/s with 8 GT/s x8
>>>>                 link)
>>>>                 iommu: Adding device 0001:01:00.0 to group 19
>>>>                 pci 0001:01:00.1: enabling Extended Tags
>>>>                 iommu: Adding device 0001:01:00.1 to group 19
>>>>                 pci 0001:00:00.0: PCI bridge to [bus 01-ff]
>>>>                 fsl-pci ffe260000.pcie: PCI host bridge to bus 0002:00
>>>>                 pci_bus 0002:00: root bus resource [io
>>>>                  0x8000080000032000-0x8000080000041fff] (bus
>>>>                 address [0x0000-0xffff])
>>>>                 pci_bus 0002:00: root bus resource [mem
>>>>                 0xc20000000-0xc2fffffff] (bus address
>>>>                 [0xe0000000-0xefffffff])
>>>>                 pci_bus 0002:00: root bus resource [bus 00]
>>>>                 iommu: Removing device ffe260000.pcie from group 21
>>>>                 iommu: Adding device 0002:00:00.0 to group 20
>>>>                 pci 0002:00:00.0: bridge configuration invalid
>>>>                 ([bus 00-00]), reconfiguring
>>>>                 pci 0002:00:00.0: PCI bridge to [bus 01-ff]
>>>>                 fsl-pci ffe270000.pcie: PCI host bridge to bus 0003:00
>>>>                 pci_bus 0003:00: root bus resource [io
>>>>                  0x8000080000043000-0x8000080000052fff] (bus
>>>>                 address [0x0000-0xffff])
>>>>                 pci_bus 0003:00: root bus resource [mem
>>>>                 0xc30000000-0xc3fffffff] (bus address
>>>>                 [0xe0000000-0xefffffff])
>>>>                 pci_bus 0003:00: root bus resource [bus 00]
>>>>                 iommu: Removing device ffe270000.pcie from group 22
>>>>                 iommu: Adding device 0003:00:00.0 to group 21
>>>>                 pci 0003:00:00.0: bridge configuration invalid
>>>>                 ([bus 00-00]), reconfiguring
>>>>                 pci 0003:00:00.0: PCI bridge to [bus 01-ff]
>>>>                 PCI: Cannot allocate resource region 0 of device
>>>>                 0000:00:00.0, will remap
>>>>                 PCI: Cannot allocate resource region 0 of device
>>>>                 0001:00:00.0, will remap
>>>>                 PCI: Cannot allocate resource region 2 of device
>>>>                 0001:01:00.0, will remap
>>>>                 PCI: Cannot allocate resource region 5 of device
>>>>                 0001:01:00.0, will remap
>>>>                 PCI: Cannot allocate resource region 6 of device
>>>>                 0001:01:00.0, will remap
>>>>                 PCI: Cannot allocate resource region 0 of device
>>>>                 0001:01:00.1, will remap
>>>>                 PCI: Cannot allocate resource region 0 of device
>>>>                 0002:00:00.0, will remap
>>>>                 PCI: Cannot allocate resource region 0 of device
>>>>                 0003:00:00.0, will remap
>>>>                 pci 0000:00:00.0: BAR 0: no space for [mem size
>>>>                 0x01000000]
>>>>                 pci 0000:00:00.0: BAR 0: failed to assign [mem size
>>>>                 0x01000000]
>>>>                 pci 0000:00:00.0: PCI bridge to [bus 01]
>>>>                 pci 0000:00:00.0: bridge window [io
>>>>                  0x8000080000010000-0x800008000001ffff]
>>>>                 pci 0000:00:00.0: bridge window [mem
>>>>                 0xc00000000-0xc0fffffff]
>>>>                 pci_bus 0000:00: Some PCI device resources are
>>>>                 unassigned, try booting with pci=realloc
>>>>                 pci 0001:00:00.0: BAR 0: no space for [mem size
>>>>                 0x01000000]
>>>>                 pci 0001:00:00.0: BAR 0: failed to assign [mem size
>>>>                 0x01000000]
>>>>                 pci 0001:00:00.0: BAR 9: no space for [mem size
>>>>                 0x00200000 64bit pref]
>>>>                 pci 0001:00:00.0: BAR 9: failed to assign [mem size
>>>>                 0x00200000 64bit pref]
>>>>                 pci 0001:01:00.0: BAR 2: no space for [mem size
>>>>                 0x00200000 64bit pref]
>>>>                 pci 0001:01:00.0: BAR 2: failed to assign [mem size
>>>>                 0x00200000 64bit pref]
>>>>                 pci 0001:01:00.0: BAR 5: no space for [mem size
>>>>                 0x00040000]
>>>>                 pci 0001:01:00.0: BAR 5: failed to assign [mem size
>>>>                 0x00040000]
>>>>                 pci 0001:01:00.0: BAR 6: no space for [mem size
>>>>                 0x00020000 pref]
>>>>                 pci 0001:01:00.0: BAR 6: failed to assign [mem size
>>>>                 0x00020000 pref]
>>>>                 pci 0001:01:00.1: BAR 0: no space for [mem size
>>>>                 0x00004000 64bit]
>>>>                 pci 0001:01:00.1: BAR 0: failed to assign [mem size
>>>>                 0x00004000 64bit]
>>>>                 pci 0001:00:00.0: PCI bridge to [bus 01]
>>>>                 pci 0001:00:00.0: bridge window [io
>>>>                  0x8000080000021000-0x8000080000030fff]
>>>>                 pci 0001:00:00.0: bridge window [mem
>>>>                 0xc10000000-0xc1fffffff]
>>>>                 pci_bus 0001:00: Some PCI device resources are
>>>>                 unassigned, try booting with pci=realloc
>>>>                 pci 0002:00:00.0: BAR 0: no space for [mem size
>>>>                 0x01000000]
>>>>                 pci 0002:00:00.0: BAR 0: failed to assign [mem size
>>>>                 0x01000000]
>>>>                 pci 0002:00:00.0: PCI bridge to [bus 01]
>>>>                 pci 0002:00:00.0: bridge window [io
>>>>                  0x8000080000032000-0x8000080000041fff]
>>>>                 pci 0002:00:00.0: bridge window [mem
>>>>                 0xc20000000-0xc2fffffff]
>>>>                 pci_bus 0002:00: Some PCI device resources are
>>>>                 unassigned, try booting with pci=realloc
>>>>                 pci 0003:00:00.0: BAR 0: no space for [mem size
>>>>                 0x01000000]
>>>>                 pci 0003:00:00.0: BAR 0: failed to assign [mem size
>>>>                 0x01000000]
>>>>                 pci 0003:00:00.0: PCI bridge to [bus 01]
>>>>                 pci 0003:00:00.0: bridge window [io
>>>>                  0x8000080000043000-0x8000080000052fff]
>>>>                 pci 0003:00:00.0: bridge window [mem
>>>>                 0xc30000000-0xc3fffffff]
>>>>                 pci_bus 0003:00: Some PCI device resources are
>>>>                 unassigned, try booting with pci=realloc
>>>>
>>>>
>>>
>>>
>>>             _______________________________________________
>>>             amd-gfx mailing list
>>>             amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>>             https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Cchristian.koenig%40amd.com%7C561d9d3206ff46d338ad08d777ef717c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637109742603345420&sdata=PO02mQtDBnkAdNfCn%2Fp7QmKX8IbJ7zke8edrfhsM6Mg%3D&reserved=0>
>>
>


--------------540460194482394818D16F20
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">Right now I am trying to increase MMIO
        size config to 512 MB</blockquote>
      What you could try as well is to use the size 320MB for the MMIO.
      Those ranges usually don't need to be a power of two (only the
      BARs itself are a power of two) and this way it might even be
      easier to fit everything together.<br>
      <br>
      <blockquote type="cite">By the way I wonder how can I get at least
        VGA output from GPU. Maybe I can get a text console on screen or
        something like X server? Do you have any recommendations?</blockquote>
      What could maybe work is VGA emulation, which essentially means
      text only. But no guarantee for that this really works as
      expected.<br>
      <br>
      <blockquote type="cite">I am just wondering, does modern gaming
        motherboards have more than 4GB PCIe buffer for this job ?</blockquote>
      They don't, resources are dynamically assigned instead.<br>
      <br>
      See on x86 you usually have 1GB 32-bit address space where the
      BIOS shuffles all the mandatory devices it sees at boot time into.
      <br>
      <br>
      Then when the motherboard has multiple PEG slots the BIOS also
      configures a 64-bit address space which is usually rather huge
      (256GB-1TB). Since the the VRAM and the doorbell BAR are 64bit
      BARs on the GPU they can be mapped into that as well.<br>
      <br>
      This way you can easily have 10 GPUs connected to your CPU.<br>
      <br>
      The problem you have here is that U-config doesn't do this
      resource assignment automatically and you need to configure it
      manually.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 03.12.19 um 13:50 schrieb Yusuf Altıparmak:<br>
    </div>
    <blockquote type="cite" cite="mid:CAGzVRjz-EEZDamT3OvJ8r9ERd7gNLdjBwaOisnQ9pY_MPKAKyg@mail.gmail.com">
      
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        Hi Christian,<br>
        <div>
          <div class="gmail_quote">
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
              <div bgcolor="#FFFFFF">
                <div>
                  <blockquote type="cite">0001f000</blockquote>
                  Exactly as I thought. The hardware does support BAR
                  resize, but unfortunately 256MB is already the
                  minimum.<br>
                  <br>
                  Sorry, but there isn't anything I could do from the
                  GPU drivers point of view.<br>
                </div>
              </div>
            </blockquote>
            <div><br>
            </div>
            <div>Yes unfortunately there is nothing remained to about
              GPU side. <br>
            </div>
            <div><br>
            </div>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
              <div bgcolor="#FFFFFF">
                <div> The only good news I have is that
                  256M&#43;2M&#43;512K&#43;128K=260M address space should be enough
                  for the GPU to work, maybe that makes things a bit
                  simpler.<br>
                  <br>
                </div>
              </div>
            </blockquote>
            <div><br>
            </div>
            <div>Right now I am trying to increase MMIO size config to
              512 MB, I hope that should help me. By the way I wonder
              how can I get at least VGA output from GPU. Maybe I can
              get a text console on screen or something like X server?
              Do you have any recommendations? I tried this GPU with my
              own Ubuntu 18.04 and its special driver. Everything worked
              fine.</div>
            <div><br>
            </div>
            <div>&nbsp;</div>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
              <div bgcolor="#FFFFFF">
                <div> But you definitely got an interesting use case
                  here :)</div>
              </div>
            </blockquote>
            <div><br>
            </div>
            <div>This is the worlds the most interesting use case I
              think. I can't increase MMIO size because U-boot freezes.
              I can't decrease it to 256 MB again because driver does
              not accept :D. I am just wondering, does modern gaming
              motherboards have more than 4GB PCIe buffer for this job ?
              :D<br>
            </div>
            <div><br>
            </div>
            <div><br>
            </div>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
              <div bgcolor="#FFFFFF">
                <div> Am 03.12.19 um 11:31 schrieb Yusuf Altıparmak:<br>
                </div>
                <blockquote type="cite">
                  <div dir="ltr">
                    <div>Hello Christian,</div>
                    <div>My &quot;setpci -s 0001:01:00.0 ECAP15&#43;4.l
                      ECAP15&#43;8.l&quot; output is;</div>
                    <div><br>
                    </div>
                    <div>0001f000 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br>
                      00000820 <br>
                    </div>
                    <div><br>
                    </div>
                    <div>Regards.<br>
                    </div>
                    <div><br>
                    </div>
                    <div><br>
                    </div>
                    <br>
                    <div class="gmail_quote">
                      <div dir="ltr" class="gmail_attr">Yusuf Altıparmak
                        &lt;<a href="mailto:yusufalti1997@gmail.com" target="_blank" moz-do-not-send="true">yusufalti1997@gmail.com</a>&gt;,
                        2 Ara 2019 Pzt, 19:31 tarihinde şunu yazdı:<br>
                      </div>
                      <blockquote class="gmail_quote" style="margin:0px
                        0px 0px 0.8ex;border-left:1px solid
                        rgb(204,204,204);padding-left:1ex">
                        <div dir="ltr">
                          <div class="gmail_quote">
                            <blockquote class="gmail_quote" style="margin:0px 0px 0px
                              0.8ex;border-left:1px solid
                              rgb(204,204,204);padding-left:1ex">
                              <div bgcolor="#FFFFFF">Most likely not.
                                There is support for resizing the VRAM
                                BAR, but usually you can only make it
                                larger and not smaller.<br>
                                Please give me the output of &quot;sudo
                                setpci -s 0001:01:00.0 ECAP15&#43;4.l
                                ECAP15&#43;8.l&quot; if you want to double check
                                that.<br>
                              </div>
                            </blockquote>
                            <div><br>
                            </div>
                            <div>Okay I'll try it tomorrow. What does
                              the &quot; sudo setpci -s 0001:01:00.0
                              ECAP15&#43;4.l ECAP15&#43;8.l&quot; command exactly do
                              ?</div>
                            <div><br>
                            </div>
                            <div>&nbsp;</div>
                            <blockquote class="gmail_quote" style="margin:0px 0px 0px
                              0.8ex;border-left:1px solid
                              rgb(204,204,204);padding-left:1ex">
                              <div bgcolor="#FFFFFF"> Well you rather
                                need to ask if anybody has sample PCIe
                                configuration for GPUs in general. That
                                problem is not really E9171 related. You
                                might want to ask NXP for that maybe.<br>
                                Sorry, no idea if that is correct or
                                not. You need to ask NXP for help with
                                that.<br>
                                <br>
                              </div>
                            </blockquote>
                            <div><br>
                            </div>
                            <div>Okay no problem. At least I know what
                              is the missing point now. The problem is
                              probably because of the .dtsi and u-boot
                              config files. Memory ranges are
                              overwriting like you said. I'll ask nxp to
                              take some sample PCIe configuration for
                              GPUs.</div>
                            <div><br>
                            </div>
                            <div>Thank you for your interest Christian.</div>
                            <div>Regards .<br>
                            </div>
                            <div>&nbsp;</div>
                            <blockquote class="gmail_quote" style="margin:0px 0px 0px
                              0.8ex;border-left:1px solid
                              rgb(204,204,204);padding-left:1ex">
                              <div bgcolor="#FFFFFF">
                                <blockquote type="cite">
                                  <div dir="ltr">
                                    <div class="gmail_quote">
                                      <div><br>
                                      </div>
                                      <blockquote class="gmail_quote" style="margin:0px 0px 0px
                                        0.8ex;border-left:1px solid
                                        rgb(204,204,204);padding-left:1ex">
                                        <div bgcolor="#FFFFFF">
                                          <div> Am 02.12.19 um 14:32
                                            schrieb Yusuf Altıparmak:<br>
                                          </div>
                                          <blockquote type="cite">
                                            <div dir="ltr">
                                              <div class="gmail_quote">
                                                <blockquote class="gmail_quote" style="margin:0px 0px
                                                  0px
                                                  0.8ex;border-left:1px
                                                  solid
                                                  rgb(204,204,204);padding-left:1ex">
                                                  <div bgcolor="#FFFFFF"><br>
                                                    <blockquote type="cite">I
                                                      attached my dts
                                                      file.<br>
                                                      <div>
                                                        <div><br>
                                                        </div>
                                                        <div>System is
                                                          working fine
                                                          when GPU is
                                                          not plugged
                                                          in.</div>
                                                        <div><b><br>
                                                          </b></div>
                                                        <div><b>This is
                                                          the last
                                                          console log
                                                          before freeze:</b></div>
                                                        <div>[drm]
                                                          amdgpu kernel
                                                          modesetting
                                                          enabled. &nbsp; &nbsp; &nbsp;
                                                          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</div>
                                                        [drm]
                                                        initializing
                                                        kernel
                                                        modesetting
                                                        (POLARIS12
                                                        0x1002:0x6987
                                                        0x1787:0x2389
                                                        0x80).&nbsp; <br>
                                                        [drm] register
                                                        mmio base:
                                                        0x20200000 &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
                                                        fsl-fman-port
                                                        ffe488000.port
                                                        fm1-gb0: renamed
                                                        from eth0 &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; <br>
                                                        [drm] register
                                                        mmio size:
                                                        262144 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
                                                        [drm] add ip
                                                        block number 0
                                                        &lt;vi_common&gt;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br>
                                                        [drm] add ip
                                                        block number 1
                                                        &lt;gmc_v8_0&gt;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
                                                        [drm] add ip
                                                        block number 2
                                                        &lt;tonga_ih&gt;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
                                                        [drm] add ip
                                                        block number 3
                                                        &lt;powerplay&gt;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br>
                                                        [drm] add ip
                                                        block number 4
                                                        &lt;dm&gt; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
                                                        [drm] add ip
                                                        block number 5
                                                        &lt;gfx_v8_0&gt;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
                                                        [drm] add ip
                                                        block number 6
                                                        &lt;sdma_v3_0&gt;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br>
                                                        [drm] add ip
                                                        block number 7
                                                        &lt;uvd_v6_0&gt;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
                                                        [drm] add ip
                                                        block number 8
                                                        &lt;vce_v3_0&gt;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
                                                        [drm] UVD is
                                                        enabled in VM
                                                        mode &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br>
                                                        [drm] UVD ENC is
                                                        enabled in VM
                                                        mode &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; <br>
                                                        [drm] VCE
                                                        enabled in VM
                                                        mode &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
                                                        ATOM BIOS:
                                                        113-ER16BFC-001
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
                                                        [drm] GPU
                                                        posting now... &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
                                                        Disabling lock
                                                        debugging due to
                                                        kernel taint &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp;<br>
                                                        Machine check in
                                                        kernel mode. &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; <br>
                                                        Caused by (from
                                                        MCSR=a000): Load
                                                        Error Report &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; <br>
                                                        Guarded Load
                                                        Error Report &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; <br>
                                                        Kernel panic -
                                                        not syncing:
                                                        Unrecoverable
                                                        Machine check &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br>
                                                        CPU: 1 PID: 2023
                                                        Comm: udevd
                                                        Tainted: G &nbsp; M &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        &nbsp;4.19.26&#43;gc0c2141
                                                        #1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
                                                        Call Trace: &nbsp; &nbsp;
                                                        &nbsp; <br>
                                                      </div>
                                                    </blockquote>
                                                  </div>
                                                </blockquote>
                                                <blockquote class="gmail_quote" style="margin:0px 0px
                                                  0px
                                                  0.8ex;border-left:1px
                                                  solid
                                                  rgb(204,204,204);padding-left:1ex">
                                                  <div bgcolor="#FFFFFF">
                                                    <blockquote type="cite">
                                                      <div dir="ltr">&nbsp; &nbsp;
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                                                        <br>
                                                      </div>
                                                      <br>
                                                      <fieldset></fieldset>
                                                      <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C561d9d3206ff46d338ad08d777ef717c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637109742603335427&amp;sdata=DstGsDW0X7ennQoF1vg%2FYLGAStF4p1dAeMFhzsAFc1I%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="LI&#43;MHxdQ79XviUt7U25NGxePxF5GHr8DzfleWzM1wVgVPCeOO13L4lMvhsljyAun/1DXsD/8b1LVr9HJo5PjUdlz2DXwuad&#43;dVqKYaCVFhfAQg8YQj8RymHPRdyRcHUJx0VKuF2NbQop9iulQvanGlIC4TNpHPzD82L5ij0aF48=" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
                                                    </blockquote>
                                                    <br>
                                                  </div>
                                                </blockquote>
                                                <div>
                                                  <div dir="ltr"><br>
                                                  </div>
                                                  <br>
                                                  <div class="gmail_quote">
                                                    <div dir="ltr" class="gmail_attr">Christian
                                                      König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;, 2 Ara
                                                      2019 Pzt, 15:28
                                                      tarihinde şunu
                                                      yazdı:<br>
                                                    </div>
                                                    <blockquote class="gmail_quote" style="margin:0px
                                                      0px 0px
                                                      0.8ex;border-left:1px
                                                      solid
                                                      rgb(204,204,204);padding-left:1ex">
                                                      <div bgcolor="#FFFFFF">
                                                        <div>Hi Yusuf,<br>
                                                          <br>
                                                          Am 02.12.19 um
                                                          12:41 schrieb
                                                          Yusuf
                                                          Altıparmak:<br>
                                                        </div>
                                                        <blockquote type="cite">
                                                          <div dir="ltr">
                                                          <div>My
                                                          embedded board
                                                          is freezing
                                                          when I put
                                                          E9171 on PCIe.
                                                          What is the
                                                          meaning of
                                                          Unrecoverable
                                                          Machine Check
                                                          error about
                                                          GPU? <br>
                                                          </div>
                                                          </div>
                                                        </blockquote>
                                                        <br>
                                                        Well see the
                                                        explanation on
                                                        Wikipedia for
                                                        example: <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FMachine-check_exception&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C561d9d3206ff46d338ad08d777ef717c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637109742603345420&amp;sdata=NtHiZmL7me4JRZR4L9KHZzpD8Zcn6caURVvtiDSgHsE%3D&amp;reserved=0" originalsrc="https://en.wikipedia.org/wiki/Machine-check_exception" shash="yH8t&#43;Sp5b481PBht09smBd2&#43;B5oAV6uscEFNvj3gy52au435liHaVIWkjOCqehPP2UMERBsBRkIPL1DgVD09MsaDd7N9vuzDNbFuzqmC1Td0/F/EC3&#43;1Lsf0HkbxiSvkXeBOPAjgai7fd6uuZucJT6wbZcofMAF9rSXszileiJo=" target="_blank" moz-do-not-send="true">https://en.wikipedia.org/wiki/Machine-check_exception</a><br>
                                                        <br>
                                                        In general it
                                                        means you have
                                                        messed up
                                                        something in
                                                        your hardware
                                                        configuration.<br>
                                                        <br>
                                                        <blockquote type="cite">
                                                          <div dir="ltr">
                                                          <div>Could
                                                          PCIe settings
                                                          in .dts file
                                                          cause this
                                                          problem?</div>
                                                          </div>
                                                        </blockquote>
                                                        <br>
                                                        Possible, but
                                                        rather unlikely.
                                                        My best guess is
                                                        that it is some
                                                        problem with the
                                                        power supply.<br>
                                                        <br>
                                                        <blockquote type="cite">
                                                          <div dir="ltr">
                                                          <div> If it
                                                          is, is there
                                                          any sample
                                                          PCIe
                                                          configuration
                                                          for E9171?</div>
                                                          </div>
                                                        </blockquote>
                                                        <br>
                                                        The E9171 is
                                                        just a PCIe
                                                        device, so the
                                                        dtsi is actually
                                                        rather
                                                        uninteresting.
                                                        What we really
                                                        need is a full
                                                        dmesg and maybe
                                                        lspci output
                                                        would help as
                                                        well.<br>
                                                        <br>
                                                        Regards,<br>
                                                        Christian.</div>
                                                    </blockquote>
                                                    <div><br>
                                                    </div>
                                                    <div><br>
                                                    </div>
                                                    <div>Hi Christian,</div>
                                                    <div><br>
                                                    </div>
                                                    <div>At first, I am
                                                      using NXP
                                                      T1042D4RDB-64B
                                                      which has 256 MB
                                                      PCIe buffer
                                                      according to its.
                                                      PCIe memory range
                                                      was arranged to
                                                      256 MB in .dts
                                                      file and in U-boot
                                                      configuration
                                                      file. Driver was
                                                      giving error with
                                                      exit code -12
                                                      (OUT_OF_MEMORY).
                                                      But I was able to
                                                      reach the linux
                                                      console. <br>
                                                    </div>
                                                    <div><br>
                                                    </div>
                                                    <div>[ &nbsp; &nbsp;5.512922]
                                                      [drm] amdgpu
                                                      kernel modesetting
                                                      enabled.<br>
                                                      [ &nbsp; &nbsp;5.517065]
                                                      [drm] initializing
                                                      kernel modesetting
                                                      (POLARIS12
                                                      0x1002:0x6987
                                                      0x1787:0x2389
                                                      0x80).<br>
                                                      [ &nbsp; &nbsp;5.524507]
                                                      amdgpu
                                                      0001:01:00.0:
                                                      Fatal error during
                                                      GPU init<br>
                                                      [ &nbsp; &nbsp;5.529296]
                                                      amdgpu: probe of
                                                      0001:01:00.0
                                                      failed with error
                                                      -12<br>
                                                    </div>
                                                    <div> <br>
                                                    </div>
                                                  </div>
                                                  Then I canged 256 MB
                                                  to 4GB in .dtsi and
                                                  U-boot conf file. I
                                                  also changed 64KB I/O
                                                  size to 1MB . When I
                                                  do this, I wasn't able
                                                  to reach the linux
                                                  console because board
                                                  was freezing. But
                                                  driver was successfull
                                                  at this time. I
                                                  already mentioned
                                                  successfull driver
                                                  console logs up.<br>
                                                </div>
                                                <div><br>
                                                </div>
                                                <div>
                                                  <div><b>this is lspci
                                                      -v when GPU is
                                                      plugged and Memory
                                                      size is 256 MB.</b></div>
                                                  <div><br>
                                                  </div>
                                                  <div>root@t1042d4rdb-64b:~#
                                                    lspci -v<br>
                                                    0000:00:00.0 PCI
                                                    bridge: Freescale
                                                    Semiconductor Inc
                                                    Device 0824 (rev 11)
                                                    (prog-if 00 [Normal
                                                    decode])<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Device tree
                                                    node:
                                                    /sys/firmware/devicetree/base/pcie@ffe240000/pcie@0<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Flags: bus
                                                    master, fast devsel,
                                                    latency 0, IRQ 20<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Memory at
                                                    &lt;ignored&gt;
                                                    (32-bit,
                                                    non-prefetchable)<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Bus:
                                                    primary=00,
                                                    secondary=01,
                                                    subordinate=01,
                                                    sec-latency=0<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; I/O behind
                                                    bridge:
                                                    00000000-0000ffff
                                                    [size=64K]<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Memory
                                                    behind bridge:
                                                    e0000000-efffffff
                                                    [size=256M]<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Prefetchable
                                                    memory behind
                                                    bridge: None<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [44]
                                                    Power Management
                                                    version 3<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [4c]
                                                    Express Root Port
                                                    (Slot-), MSI 00<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [100]
                                                    Advanced Error
                                                    Reporting<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Kernel
                                                    driver in use:
                                                    pcieport<br>
                                                    <br>
                                                    0001:00:00.0 PCI
                                                    bridge: Freescale
                                                    Semiconductor Inc
                                                    Device 0824 (rev 11)
                                                    (prog-if 00 [Normal
                                                    decode])<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Device tree
                                                    node:
                                                    /sys/firmware/devicetree/base/pcie@ffe250000/pcie@0<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Flags: bus
                                                    master, fast devsel,
                                                    latency 0, IRQ 21<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Memory at
                                                    &lt;ignored&gt;
                                                    (32-bit,
                                                    non-prefetchable)<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Bus:
                                                    primary=00,
                                                    secondary=01,
                                                    subordinate=01,
                                                    sec-latency=0<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; I/O behind
                                                    bridge:
                                                    00000000-0000ffff
                                                    [size=64K]<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Memory
                                                    behind bridge:
                                                    e0000000-efffffff
                                                    [size=256M]<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Prefetchable
                                                    memory behind
                                                    bridge: None<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [44]
                                                    Power Management
                                                    version 3<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [4c]
                                                    Express Root Port
                                                    (Slot-), MSI 00<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [100]
                                                    Advanced Error
                                                    Reporting<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Kernel
                                                    driver in use:
                                                    pcieport<br>
                                                    <br>
                                                    0001:01:00.0 VGA
                                                    compatible
                                                    controller: Advanced
                                                    Micro Devices, Inc.
                                                    [AMD/ATI] Lexa
                                                    [Radeon E9171 MCM]
                                                    (rev 80) (prog-if 00
                                                    [VGA controller])<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Subsystem:
                                                    Hightech Information
                                                    System Ltd. Device
                                                    2389<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Flags: fast
                                                    devsel, IRQ 41<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Memory at
                                                    c10000000 (64-bit,
                                                    prefetchable)
                                                    [size=256M]<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Memory at
                                                    &lt;ignored&gt;
                                                    (64-bit,
                                                    prefetchable)<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; I/O ports at
                                                    1100 [size=256]<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Memory at
                                                    &lt;ignored&gt;
                                                    (32-bit,
                                                    non-prefetchable)<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Expansion
                                                    ROM at
                                                    &lt;ignored&gt;
                                                    [disabled]<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [48]
                                                    Vendor Specific
                                                    Information: Len=08
                                                    &lt;?&gt;<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [50]
                                                    Power Management
                                                    version 3<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [58]
                                                    Express Legacy
                                                    Endpoint, MSI 00<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [a0]
                                                    MSI: Enable-
                                                    Count=1/1 Maskable-
                                                    64bit&#43;<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [100]
                                                    Vendor Specific
                                                    Information: ID=0001
                                                    Rev=1 Len=010
                                                    &lt;?&gt;<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [150]
                                                    Advanced Error
                                                    Reporting<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [200]
                                                    Resizable BAR
                                                    &lt;?&gt;<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [270]
                                                    Secondary PCI
                                                    Express &lt;?&gt;<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [2b0]
                                                    Address Translation
                                                    Service (ATS)<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [2c0]
                                                    Page Request
                                                    Interface (PRI)<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [2d0]
                                                    Process Address
                                                    Space ID (PASID)<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [320]
                                                    Latency Tolerance
                                                    Reporting<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [328]
                                                    Alternative
                                                    Routing-ID
                                                    Interpretation (ARI)<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [370]
                                                    L1 PM Substates<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Kernel
                                                    modules: amdgpu<br>
                                                    <br>
                                                    0001:01:00.1 Audio
                                                    device: Advanced
                                                    Micro Devices, Inc.
                                                    [AMD/ATI] Device
                                                    aae0<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Subsystem:
                                                    Hightech Information
                                                    System Ltd. Device
                                                    aae0<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Flags: bus
                                                    master, fast devsel,
                                                    latency 0, IRQ 17<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Memory at
                                                    &lt;ignored&gt;
                                                    (64-bit,
                                                    non-prefetchable)<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [48]
                                                    Vendor Specific
                                                    Information: Len=08
                                                    &lt;?&gt;<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [50]
                                                    Power Management
                                                    version 3<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [58]
                                                    Express Legacy
                                                    Endpoint, MSI 00<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [a0]
                                                    MSI: Enable-
                                                    Count=1/1 Maskable-
                                                    64bit&#43;<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [100]
                                                    Vendor Specific
                                                    Information: ID=0001
                                                    Rev=1 Len=010
                                                    &lt;?&gt;<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [150]
                                                    Advanced Error
                                                    Reporting<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [328]
                                                    Alternative
                                                    Routing-ID
                                                    Interpretation (ARI)<br>
                                                    <br>
                                                    0002:00:00.0 PCI
                                                    bridge: Freescale
                                                    Semiconductor Inc
                                                    Device 0824 (rev 11)
                                                    (prog-if 00 [Normal
                                                    decode])<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Device tree
                                                    node:
                                                    /sys/firmware/devicetree/base/pcie@ffe260000/pcie@0<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Flags: bus
                                                    master, fast devsel,
                                                    latency 0, IRQ 22<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Memory at
                                                    &lt;ignored&gt;
                                                    (32-bit,
                                                    non-prefetchable)<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Bus:
                                                    primary=00,
                                                    secondary=01,
                                                    subordinate=01,
                                                    sec-latency=0<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; I/O behind
                                                    bridge:
                                                    00000000-0000ffff
                                                    [size=64K]<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Memory
                                                    behind bridge:
                                                    e0000000-efffffff
                                                    [size=256M]<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Prefetchable
                                                    memory behind
                                                    bridge: None<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [44]
                                                    Power Management
                                                    version 3<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [4c]
                                                    Express Root Port
                                                    (Slot-), MSI 00<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [100]
                                                    Advanced Error
                                                    Reporting<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Kernel
                                                    driver in use:
                                                    pcieport<br>
                                                    <br>
                                                    0003:00:00.0 PCI
                                                    bridge: Freescale
                                                    Semiconductor Inc
                                                    Device 0824 (rev 11)
                                                    (prog-if 00 [Normal
                                                    decode])<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Device tree
                                                    node:
                                                    /sys/firmware/devicetree/base/pcie@ffe270000/pcie@0<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Flags: bus
                                                    master, fast devsel,
                                                    latency 0, IRQ 23<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Memory at
                                                    &lt;ignored&gt;
                                                    (32-bit,
                                                    non-prefetchable)<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Bus:
                                                    primary=00,
                                                    secondary=01,
                                                    subordinate=01,
                                                    sec-latency=0<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; I/O behind
                                                    bridge:
                                                    00000000-0000ffff
                                                    [size=64K]<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Memory
                                                    behind bridge:
                                                    e0000000-efffffff
                                                    [size=256M]<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Prefetchable
                                                    memory behind
                                                    bridge: None<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [44]
                                                    Power Management
                                                    version 3<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [4c]
                                                    Express Root Port
                                                    (Slot-), MSI 00<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                                    Capabilities: [100]
                                                    Advanced Error
                                                    Reporting<br>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; Kernel
                                                    driver in use:
                                                    pcieport</div>
                                                  <div><br>
                                                  </div>
                                                </div>
                                                <div><b>AND This is PCIe
                                                    dmesg message when
                                                    memory range is
                                                    256MB. It's also
                                                    giving same message
                                                    when memory range is
                                                    arranged as 4GB;</b></div>
                                                <div><br>
                                                </div>
                                                <div>PCI host bridge
                                                  /pcie@ffe240000
                                                  &nbsp;ranges:<br>
                                                  &nbsp;MEM
                                                  0x0000000c00000000..0x0000000c0fffffff
                                                  -&gt;
                                                  0x00000000e0000000 <br>
                                                  &nbsp; IO
                                                  0x0000000ff8000000..0x0000000ff800ffff
                                                  -&gt;
                                                  0x0000000000000000<br>
                                                  /pcie@ffe240000:
                                                  PCICSRBAR @ 0xff000000<br>
                                                  setup_pci_atmu: end of
                                                  DRAM 200000000<br>
                                                  /pcie@ffe240000: Setup
                                                  64-bit PCI DMA window<br>
                                                  /pcie@ffe240000:
                                                  WARNING: Outbound
                                                  window cfg leaves gaps
                                                  in memory map.
                                                  Adjusting the memory
                                                  map could reduce
                                                  unnecessary bounce
                                                  buffering.<br>
                                                  /pcie@ffe240000: DMA
                                                  window size is
                                                  0xe0000000<br>
                                                  Found FSL PCI host
                                                  bridge at
                                                  0x0000000ffe250000.
                                                  Firmware bus number:
                                                  0-&gt;1<br>
                                                  PCI host bridge
                                                  /pcie@ffe250000
                                                  &nbsp;ranges:<br>
                                                  &nbsp;MEM
                                                  0x0000000c10000000..0x0000000c1fffffff
                                                  -&gt;
                                                  0x00000000e0000000 <br>
                                                  &nbsp; IO
                                                  0x0000000ff8010000..0x0000000ff801ffff
                                                  -&gt;
                                                  0x0000000000000000<br>
                                                  /pcie@ffe250000:
                                                  PCICSRBAR @ 0xff000000<br>
                                                  setup_pci_atmu: end of
                                                  DRAM 200000000<br>
                                                  /pcie@ffe250000: Setup
                                                  64-bit PCI DMA window<br>
                                                  /pcie@ffe250000:
                                                  WARNING: Outbound
                                                  window cfg leaves gaps
                                                  in memory map.
                                                  Adjusting the memory
                                                  map could reduce
                                                  unnecessary bounce
                                                  buffering.<br>
                                                  /pcie@ffe250000: DMA
                                                  window size is
                                                  0xe0000000<br>
                                                  Found FSL PCI host
                                                  bridge at
                                                  0x0000000ffe260000.
                                                  Firmware bus number:
                                                  0-&gt;0<br>
                                                  PCI host bridge
                                                  /pcie@ffe260000
                                                  &nbsp;ranges:<br>
                                                  &nbsp;MEM
                                                  0x0000000c20000000..0x0000000c2fffffff
                                                  -&gt;
                                                  0x00000000e0000000 <br>
                                                  &nbsp; IO
                                                  0x0000000ff8020000..0x0000000ff802ffff
                                                  -&gt;
                                                  0x0000000000000000<br>
                                                  /pcie@ffe260000:
                                                  PCICSRBAR @ 0xff000000<br>
                                                  setup_pci_atmu: end of
                                                  DRAM 200000000<br>
                                                  /pcie@ffe260000: Setup
                                                  64-bit PCI DMA window<br>
                                                  /pcie@ffe260000:
                                                  WARNING: Outbound
                                                  window cfg leaves gaps
                                                  in memory map.
                                                  Adjusting the memory
                                                  map could reduce
                                                  unnecessary bounce
                                                  buffering.<br>
                                                  /pcie@ffe260000: DMA
                                                  window size is
                                                  0xe0000000<br>
                                                  Found FSL PCI host
                                                  bridge at
                                                  0x0000000ffe270000.
                                                  Firmware bus number:
                                                  0-&gt;0<br>
                                                  PCI host bridge
                                                  /pcie@ffe270000
                                                  &nbsp;ranges:<br>
                                                  &nbsp;MEM
                                                  0x0000000c30000000..0x0000000c3fffffff
                                                  -&gt;
                                                  0x00000000e0000000 <br>
                                                  &nbsp; IO
                                                  0x0000000ff8030000..0x0000000ff803ffff
                                                  -&gt;
                                                  0x0000000000000000<br>
                                                  /pcie@ffe270000:
                                                  PCICSRBAR @ 0xff000000<br>
                                                  setup_pci_atmu: end of
                                                  DRAM 200000000<br>
                                                  /pcie@ffe270000: Setup
                                                  64-bit PCI DMA window<br>
                                                  /pcie@ffe270000:
                                                  WARNING: Outbound
                                                  window cfg leaves gaps
                                                  in memory map.
                                                  Adjusting the memory
                                                  map could reduce
                                                  unnecessary bounce
                                                  buffering.<br>
                                                  /pcie@ffe270000: DMA
                                                  window size is
                                                  0xe0000000<br>
                                                  iommu: Adding device
                                                  ff6000000.qman-portal
                                                  to group 0<br>
                                                  iommu: Adding device
                                                  ff6004000.qman-portal
                                                  to group 1<br>
                                                  iommu: Adding device
                                                  ff6008000.qman-portal
                                                  to group 2<br>
                                                  iommu: Adding device
                                                  ff600c000.qman-portal
                                                  to group 3<br>
                                                  iommu: Adding device
                                                  ff6010000.qman-portal
                                                  to group 4<br>
                                                  iommu: Adding device
                                                  ff6014000.qman-portal
                                                  to group 5<br>
                                                  iommu: Adding device
                                                  ff6018000.qman-portal
                                                  to group 6<br>
                                                  iommu: Adding device
                                                  ff601c000.qman-portal
                                                  to group 7<br>
                                                  iommu: Adding device
                                                  ff6020000.qman-portal
                                                  to group 8<br>
                                                  iommu: Adding device
                                                  ff6024000.qman-portal
                                                  to group 9<br>
                                                  iommu: Adding device
                                                  ffe100300.dma to group
                                                  10<br>
                                                  iommu: Adding device
                                                  ffe101300.dma to group
                                                  11<br>
                                                  iommu: Adding device
                                                  ffe114000.sdhc to
                                                  group 12<br>
                                                  iommu: Adding device
                                                  ffe210000.usb to group
                                                  13<br>
                                                  iommu: Adding device
                                                  ffe211000.usb to group
                                                  14<br>
                                                  iommu: Adding device
                                                  ffe220000.sata to
                                                  group 15<br>
                                                  iommu: Adding device
                                                  ffe221000.sata to
                                                  group 16<br>
                                                  iommu: Adding device
                                                  ffe318000.qman to
                                                  group 17<br>
                                                  iommu: Adding device
                                                  ffe31a000.bman to
                                                  group 18<br>
                                                  iommu: Adding device
                                                  ffe240000.pcie to
                                                  group 19<br>
                                                  iommu: Adding device
                                                  ffe250000.pcie to
                                                  group 20<br>
                                                  iommu: Adding device
                                                  ffe260000.pcie to
                                                  group 21<br>
                                                  iommu: Adding device
                                                  ffe270000.pcie to
                                                  group 22<br>
                                                  iommu: Adding device
                                                  ffe140000.qe to group
                                                  23<br>
                                                  software IO TLB:
                                                  mapped [mem
                                                  0xfbfff000-0xfffff000]
                                                  (64MB)<br>
                                                  PCI: Probing PCI
                                                  hardware<br>
                                                  fsl-pci
                                                  ffe240000.pcie: PCI
                                                  host bridge to bus
                                                  0000:00<br>
                                                  pci_bus 0000:00: root
                                                  bus resource [io
                                                  &nbsp;0x8000080000010000-0x800008000001ffff]
                                                  (bus address
                                                  [0x0000-0xffff])<br>
                                                  pci_bus 0000:00: root
                                                  bus resource [mem
                                                  0xc00000000-0xc0fffffff]
                                                  (bus address
                                                  [0xe0000000-0xefffffff])<br>
                                                  pci_bus 0000:00: root
                                                  bus resource [bus 00]<br>
                                                  iommu: Removing device
                                                  ffe240000.pcie from
                                                  group 19<br>
                                                  iommu: Adding device
                                                  0000:00:00.0 to group
                                                  24<br>
                                                  pci 0000:00:00.0:
                                                  bridge configuration
                                                  invalid ([bus 00-00]),
                                                  reconfiguring<br>
                                                  pci 0000:00:00.0: PCI
                                                  bridge to [bus 01-ff]<br>
                                                  fsl-pci
                                                  ffe250000.pcie: PCI
                                                  host bridge to bus
                                                  0001:00<br>
                                                  pci_bus 0001:00: root
                                                  bus resource [io
                                                  &nbsp;0x8000080000021000-0x8000080000030fff]
                                                  (bus address
                                                  [0x0000-0xffff])<br>
                                                  pci_bus 0001:00: root
                                                  bus resource [mem
                                                  0xc10000000-0xc1fffffff]
                                                  (bus address
                                                  [0xe0000000-0xefffffff])<br>
                                                  pci_bus 0001:00: root
                                                  bus resource [bus
                                                  00-01]<br>
                                                  iommu: Removing device
                                                  ffe250000.pcie from
                                                  group 20<br>
                                                  iommu: Adding device
                                                  0001:00:00.0 to group
                                                  19<br>
                                                  pci 0001:01:00.0:
                                                  enabling Extended Tags<br>
                                                  pci 0001:01:00.0:
                                                  4.000 Gb/s available
                                                  PCIe bandwidth,
                                                  limited by 5 GT/s x1
                                                  link at 0001:00:00.0
                                                  (capable of 63.008
                                                  Gb/s with 8 GT/s x8
                                                  link)<br>
                                                  iommu: Adding device
                                                  0001:01:00.0 to group
                                                  19<br>
                                                  pci 0001:01:00.1:
                                                  enabling Extended Tags<br>
                                                  iommu: Adding device
                                                  0001:01:00.1 to group
                                                  19<br>
                                                  pci 0001:00:00.0: PCI
                                                  bridge to [bus 01-ff]<br>
                                                  fsl-pci
                                                  ffe260000.pcie: PCI
                                                  host bridge to bus
                                                  0002:00<br>
                                                  pci_bus 0002:00: root
                                                  bus resource [io
                                                  &nbsp;0x8000080000032000-0x8000080000041fff]
                                                  (bus address
                                                  [0x0000-0xffff])<br>
                                                  pci_bus 0002:00: root
                                                  bus resource [mem
                                                  0xc20000000-0xc2fffffff]
                                                  (bus address
                                                  [0xe0000000-0xefffffff])<br>
                                                  pci_bus 0002:00: root
                                                  bus resource [bus 00]<br>
                                                  iommu: Removing device
                                                  ffe260000.pcie from
                                                  group 21<br>
                                                  iommu: Adding device
                                                  0002:00:00.0 to group
                                                  20<br>
                                                  pci 0002:00:00.0:
                                                  bridge configuration
                                                  invalid ([bus 00-00]),
                                                  reconfiguring<br>
                                                  pci 0002:00:00.0: PCI
                                                  bridge to [bus 01-ff]<br>
                                                  fsl-pci
                                                  ffe270000.pcie: PCI
                                                  host bridge to bus
                                                  0003:00<br>
                                                  pci_bus 0003:00: root
                                                  bus resource [io
                                                  &nbsp;0x8000080000043000-0x8000080000052fff]
                                                  (bus address
                                                  [0x0000-0xffff])<br>
                                                  pci_bus 0003:00: root
                                                  bus resource [mem
                                                  0xc30000000-0xc3fffffff]
                                                  (bus address
                                                  [0xe0000000-0xefffffff])<br>
                                                  pci_bus 0003:00: root
                                                  bus resource [bus 00]<br>
                                                  iommu: Removing device
                                                  ffe270000.pcie from
                                                  group 22<br>
                                                  iommu: Adding device
                                                  0003:00:00.0 to group
                                                  21<br>
                                                  pci 0003:00:00.0:
                                                  bridge configuration
                                                  invalid ([bus 00-00]),
                                                  reconfiguring<br>
                                                  pci 0003:00:00.0: PCI
                                                  bridge to [bus 01-ff]<br>
                                                  PCI: Cannot allocate
                                                  resource region 0 of
                                                  device 0000:00:00.0,
                                                  will remap<br>
                                                  PCI: Cannot allocate
                                                  resource region 0 of
                                                  device 0001:00:00.0,
                                                  will remap<br>
                                                  PCI: Cannot allocate
                                                  resource region 2 of
                                                  device 0001:01:00.0,
                                                  will remap<br>
                                                  PCI: Cannot allocate
                                                  resource region 5 of
                                                  device 0001:01:00.0,
                                                  will remap<br>
                                                  PCI: Cannot allocate
                                                  resource region 6 of
                                                  device 0001:01:00.0,
                                                  will remap<br>
                                                  PCI: Cannot allocate
                                                  resource region 0 of
                                                  device 0001:01:00.1,
                                                  will remap<br>
                                                  PCI: Cannot allocate
                                                  resource region 0 of
                                                  device 0002:00:00.0,
                                                  will remap<br>
                                                  PCI: Cannot allocate
                                                  resource region 0 of
                                                  device 0003:00:00.0,
                                                  will remap<br>
                                                  pci 0000:00:00.0: BAR
                                                  0: no space for [mem
                                                  size 0x01000000]<br>
                                                  pci 0000:00:00.0: BAR
                                                  0: failed to assign
                                                  [mem size 0x01000000]<br>
                                                  pci 0000:00:00.0: PCI
                                                  bridge to [bus 01]<br>
                                                  pci 0000:00:00.0: &nbsp;
                                                  bridge window [io
                                                  &nbsp;0x8000080000010000-0x800008000001ffff]<br>
                                                  pci 0000:00:00.0: &nbsp;
                                                  bridge window [mem
                                                  0xc00000000-0xc0fffffff]<br>
                                                  pci_bus 0000:00: Some
                                                  PCI device resources
                                                  are unassigned, try
                                                  booting with
                                                  pci=realloc<br>
                                                  pci 0001:00:00.0: BAR
                                                  0: no space for [mem
                                                  size 0x01000000]<br>
                                                  pci 0001:00:00.0: BAR
                                                  0: failed to assign
                                                  [mem size 0x01000000]<br>
                                                  pci 0001:00:00.0: BAR
                                                  9: no space for [mem
                                                  size 0x00200000 64bit
                                                  pref]<br>
                                                  pci 0001:00:00.0: BAR
                                                  9: failed to assign
                                                  [mem size 0x00200000
                                                  64bit pref]<br>
                                                  pci 0001:01:00.0: BAR
                                                  2: no space for [mem
                                                  size 0x00200000 64bit
                                                  pref]<br>
                                                  pci 0001:01:00.0: BAR
                                                  2: failed to assign
                                                  [mem size 0x00200000
                                                  64bit pref]<br>
                                                  pci 0001:01:00.0: BAR
                                                  5: no space for [mem
                                                  size 0x00040000]<br>
                                                  pci 0001:01:00.0: BAR
                                                  5: failed to assign
                                                  [mem size 0x00040000]<br>
                                                  pci 0001:01:00.0: BAR
                                                  6: no space for [mem
                                                  size 0x00020000 pref]<br>
                                                  pci 0001:01:00.0: BAR
                                                  6: failed to assign
                                                  [mem size 0x00020000
                                                  pref]<br>
                                                  pci 0001:01:00.1: BAR
                                                  0: no space for [mem
                                                  size 0x00004000 64bit]<br>
                                                  pci 0001:01:00.1: BAR
                                                  0: failed to assign
                                                  [mem size 0x00004000
                                                  64bit]<br>
                                                  pci 0001:00:00.0: PCI
                                                  bridge to [bus 01]<br>
                                                  pci 0001:00:00.0: &nbsp;
                                                  bridge window [io
                                                  &nbsp;0x8000080000021000-0x8000080000030fff]<br>
                                                  pci 0001:00:00.0: &nbsp;
                                                  bridge window [mem
                                                  0xc10000000-0xc1fffffff]<br>
                                                  pci_bus 0001:00: Some
                                                  PCI device resources
                                                  are unassigned, try
                                                  booting with
                                                  pci=realloc<br>
                                                  pci 0002:00:00.0: BAR
                                                  0: no space for [mem
                                                  size 0x01000000]<br>
                                                  pci 0002:00:00.0: BAR
                                                  0: failed to assign
                                                  [mem size 0x01000000]<br>
                                                  pci 0002:00:00.0: PCI
                                                  bridge to [bus 01]<br>
                                                  pci 0002:00:00.0: &nbsp;
                                                  bridge window [io
                                                  &nbsp;0x8000080000032000-0x8000080000041fff]<br>
                                                  pci 0002:00:00.0: &nbsp;
                                                  bridge window [mem
                                                  0xc20000000-0xc2fffffff]<br>
                                                  pci_bus 0002:00: Some
                                                  PCI device resources
                                                  are unassigned, try
                                                  booting with
                                                  pci=realloc<br>
                                                  pci 0003:00:00.0: BAR
                                                  0: no space for [mem
                                                  size 0x01000000]<br>
                                                  pci 0003:00:00.0: BAR
                                                  0: failed to assign
                                                  [mem size 0x01000000]<br>
                                                  pci 0003:00:00.0: PCI
                                                  bridge to [bus 01]<br>
                                                  pci 0003:00:00.0: &nbsp;
                                                  bridge window [io
                                                  &nbsp;0x8000080000043000-0x8000080000052fff]<br>
                                                  pci 0003:00:00.0: &nbsp;
                                                  bridge window [mem
                                                  0xc30000000-0xc3fffffff]<br>
                                                  pci_bus 0003:00: Some
                                                  PCI device resources
                                                  are unassigned, try
                                                  booting with
                                                  pci=realloc<br>
                                                </div>
                                                <div><br>
                                                </div>
                                                <div><br>
                                                </div>
                                              </div>
                                            </div>
                                          </blockquote>
                                          <br>
                                        </div>
                                      </blockquote>
                                    </div>
                                  </div>
                                  <br>
                                  <fieldset></fieldset>
                                  <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C561d9d3206ff46d338ad08d777ef717c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637109742603345420&amp;sdata=PO02mQtDBnkAdNfCn%2Fp7QmKX8IbJ7zke8edrfhsM6Mg%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="C81ZeEKfoqYW2dnrx4eCa429dSZA1OppA6t2KTKH7fSJ6FaXQmwy/zvwE&#43;1SiaIQWOO5Wv&#43;UQeipKB9pjyjPA0OnWrCoFncSHVx31cY1aCGk68jabo9wT/ULDVFvDaUmqmPrI0MDhRP/kioWYGvvrJWS2zR6T4VTF2Sb7W0U4b0=" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
                                </blockquote>
                                <br>
                              </div>
                            </blockquote>
                          </div>
                        </div>
                      </blockquote>
                    </div>
                  </div>
                </blockquote>
                <br>
              </div>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------540460194482394818D16F20--

--===============1576035964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1576035964==--
