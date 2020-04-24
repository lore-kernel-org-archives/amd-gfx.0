Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC614C54FCB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 17:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C9A20706
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 17:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z1It31wb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C9A20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1483A6E0AD;
	Fri, 24 Apr 2020 17:22:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 850076E0AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 17:22:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ex9/GvqExUXKcjUodvI6LPNNoB65PAbd20xBSfhVoJJIMbQvbY4ABqmZpTZSkArBooJo3CgwjgXmWAffKlsjaBjc+kRLLl94ABw7IrNrX4xTAPrtKjdE2JlZR3u/h/DvInm/4RETda9dgJsPtRPOl63Eyob2AzfHyj8DQrqjIqy6lIuWGDzUEoA9R8VWm7DK7O1QC6X08wOREbYDO+9wlTQv7ku2fnOBPrB10OlU6b1Y7+NJFQT4HvOZAW3MGZYI2ByGa1RXjS7MyezKiOaovRTBFVAW5KAYsujPrcNq4h3ZVrrFt4h6oTtePl/T7ACCCua1O6nRKypaBtbsIvnBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4K0aDPBqxpu27qXBP56wEOTNM23cWG82dVDL+aqXQk=;
 b=itwgFnTHAPJMm2frwVDyH7EnikYHKT3h+pz2fnkzmXkJvATI+PXtlB9B+K/O5WUjlzEapYeLuekq7XqysFfe/5jFz5nqrFV95s9PwWV3hgUbozYK0c0Pwdr8v5MAjAlbaejG3N2frrfPp+502M60kclPqUFPowM7fhlHaflmSbSFIdpLGu5KpIyslwswsI+yiC37BawNC4W6IsUtIX96HHg7wpCdtsTgLULdqZvwXj9zjzpYkZ2qwFD2B7IqF4+ScK4OpM3flfqCAIap4upQJ6stl6iILAGHAxQVWG/8DEsDfqzvnQMRXV0aSCoWfxSeJ/ep9TmVgWrLn6xbPVuAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4K0aDPBqxpu27qXBP56wEOTNM23cWG82dVDL+aqXQk=;
 b=z1It31wbAty+0N19J5nYPagl6aMuowA6odVraaCwHlWdFCoVKroC7DPtxkk4YWMbETDzD7milNxGMfMjtsnvLAK7kiLk8SVNGF2YB12fdFr0CBI8Gpb3+OllwukX4IkNYu4ST3uOsDAnIYSb3GbF0ehlGVqdGkvfxDgavJNp3uo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 24 Apr
 2020 17:22:43 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97%6]) with mapi id 15.20.2921.030; Fri, 24 Apr 2020
 17:22:43 +0000
Subject: Re: FreeBSD / amdgpu / Vega 3, pstate TEST_DEBUG_DATA: 0x0
To: Andriy Gapon <avg@FreeBSD.org>, amd-gfx@lists.freedesktop.org
References: <ded7ad97-cc17-ffda-f476-cc5513e18b88@FreeBSD.org>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <c264b43a-d38d-89c7-4481-3320579bc1c9@amd.com>
Date: Fri, 24 Apr 2020 13:22:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <ded7ad97-cc17-ffda-f476-cc5513e18b88@FreeBSD.org>
Content-Language: en-US
X-ClientProxiedBy: BN6PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:404:10a::22) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:9240:c66::3] (2607:fea8:9240:c66::3) by
 BN6PR13CA0012.namprd13.prod.outlook.com (2603:10b6:404:10a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend
 Transport; Fri, 24 Apr 2020 17:22:42 +0000
X-Originating-IP: [2607:fea8:9240:c66::3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd92a3e1-51bb-47f3-b23b-08d7e87418c9
X-MS-TrafficTypeDiagnostic: MW3PR12MB4442:
X-Microsoft-Antispam-PRVS: <MW3PR12MB444235FDC1166D7FE83A43A28CD00@MW3PR12MB4442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(316002)(2906002)(5660300002)(8676002)(966005)(36756003)(186003)(478600001)(31696002)(6486002)(6666004)(52116002)(53546011)(81156014)(66556008)(66946007)(8936002)(2616005)(31686004)(66476007)(16526019);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8HenjMZhkvPRL6DM6zTO6hnCoxPy48JaTZ4FiNqcjtEI94me6kMBMisJXwA5bCRSRt+adpRh8D6gBDvRpiol3Wd/BoexwWOHIB6i1SQpnPLetDccX1SzXLJzlhcWtfc5cgiNgZ+QY1DNluvJPmYhHvhTPMHqWIP/yUNb4+a2tBcknWnko6EMbrOh4P8vSDv5h/SB/dKDYSxy9PmOGBCIfVcmAiRQM13nrUkwJ+iU+sWt8aUZBRqE52KPMKNlxc5chV9uLo9ou7ovRfX8YSkymLHrlsheW7mJkchVGECXQdclQRBE6FjEa8/ktOKzUFqEinsslR4PSI5RQe2LznDLRUINI8nV3/KqUjlicJEPhky1iMCrJuSOXh8urnAuY4aqbFAB1Yap49C+pVCFfZ+euihDLJi1UrQ2QYnlXY+xc8dmC9WnboYNPiUkbI+UlCgoEYAC4+xUmEX9K5yfRMOdhGl+ymUval7cW3sQ5oaXazcSPrHlLRJvFuKfygJ9w4S2+7Lnl61QhMEwcF9/geuNA==
X-MS-Exchange-AntiSpam-MessageData: 0Ackaa//HaLxdmykJfEUahUSusvnqQtEiWoCwDG35PuqrXDupihXGKZbQjyqiFvHd26FmlQIvYEUhC5LV4NjScNx6DPl1FzA2Q/dBQ03Tz5Y727rG7O86l2jmFecVOAQXSMa2Ee2pA6edfG5FF02prCfshgqCcMG+AzDbUWzA5A=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd92a3e1-51bb-47f3-b23b-08d7e87418c9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 17:22:42.8983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cA9aKJWA3nZK9R5QAikmnMCC4cPGHYeuGZ6wgQMMLsFCI3OCj1Qfhp//XQ0LlYS4nh5JMiGXQvmim44ZjSaC4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-04-24 8:34 a.m., Andriy Gapon wrote:
> 
> First, I understand that my platform is not directly supported and probably not
> very interesting, but I still hope to get some tips or pointers.
> 

Hi Andriy,

yeah, limited insight here since FreeBSD isn't something I'm familiar
with. :)

> I am trying to get amdgpu/FreeBSD going on Motile M141 laptop with Ryzen 3 3200U
> CPU that has Vega 3 graphics integrated.  When amdgpu starts loading the screen
> goes black and never lights up again.  I am not sure whether there is no signal
> at all or whether the backlight is turned off, but the screen is completely
> dark.  I can blindly interact with the system, so it's not crashed or hung.
> From system logs I can see that the driver attaches successfully.  It recognizes
> the hardware, loads its firmware, detects the eDP screen and so on.
> 

Does BSD have a way to check or set your backlight value manually (a la
/sys/class/backlight on linux)? If so I'd suggest checking and setting
it to non-zero values, ideally to max_brightness.

Have you tried an external display?

> The FreeBSD's amdgpu port that I am trying is based on code circa 5.0.
> There is no newer version ported.
> I tried a couple of Linux distros with 5.3.x kernels and they worked without any
> problems. So that gives me some hope.
> 
> I compared driver messages (with drm_debug set to 0xfff) between Linux and
> FreeBSD and they look quite similar.  Except for one thing.
> In the FreeBSD case there are these error messages that are not seen with Linux:
> 
> [drm] pstate TEST_DEBUG_DATA: 0x0
> WARNING !(0) failed at
> /usr/home/avg/devel/kms-drm/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c:868
> #0 0xffffffff83451633 at linux_dump_stack+0x23
> #1 0xffffffff8325a9ee at dcn10_verify_allow_pstate_change_high+0x4e
> #2 0xffffffff8325e925 at dcn10_wait_for_mpcc_disconnect+0x25
> #3 0xffffffff8325de53 at dcn10_disable_plane+0x53
> #4 0xffffffff8325c9f5 at dcn10_init_hw+0x755
> #5 0xffffffff83295ca8 at dc_create+0x538
> #6 0xffffffff8327a8da at dm_hw_init+0x1ea
> #7 0xffffffff831701d1 at amdgpu_device_init+0x1b11
> #8 0xffffffff83185177 at amdgpu_driver_load_kms+0xd7
> #9 0xffffffff833f138e at drm_dev_register+0x17e
> #10 0xffffffff83178dea at amdgpu_pci_probe+0x18a
> #11 0xffffffff83456f40 at linux_pci_attach+0x560
> #12 0xffffffff80bf68ea at device_attach+0x3ca
> #13 0xffffffff80bf6490 at device_probe_and_attach+0x70
> #14 0xffffffff80bf8358 at bus_generic_driver_added+0x58
> #15 0xffffffff80bf4289 at devclass_driver_added+0x39
> #16 0xffffffff80bf41c7 at devclass_add_driver+0x147
> #17 0xffffffff83455ae9 at _linux_pci_register_driver+0xc9
> 
> That warning plus stack trace is actually BREAK_TO_DEBUGGER() in the original
> Linux code.
> So, that makes me think that the problem is pretty serious.

BREAK_TO_DEBUGGER is probably overly scary here. It's somewhat a concern
as this means power consumption might be higher than expected. We've
seen this issue on several systems without any other adverse effects to
usability.

Harry

> I tried searching for "TEST_DEBUG_DATA: 0x0" and I could not find a single
> result with "0x0" in it.  Usually there is some non-zero value.
> To me this looks like maybe some hardware component is not turned on...
> Perhaps this is something relatively obvious for people that hack on the driver
> and the hardware.
> I hope to receive some hint about what to look for.
> I can cherry-pick commits from Linux, apply patches, add additional debugging
> logs, etc.
> 
> FreeBSD amdgpu dmesg: https://people.freebsd.org/~avg/amdgpu.dmesg.txt
> Full Linux dmesg: https://people.freebsd.org/~avg/linux-5.3.0-28.dmesg.out
> 
> And with with drm_debug=0xfff.
> FreeBSD: https://people.freebsd.org/~avg/fbsd-dmesg.txt
> Linux: https://people.freebsd.org/~avg/linux-5.3.9-dmesg.txt
> 
> I see that both Linux and FreeBSD have similar messages about failing to load
> some microcode components, but I guess that it must be okay since Linux works:
> [    4.487381] [drm] reserve 0x400000 from 0xf400c00000 for PSP TMR
> [    4.564893] [drm] failed to load ucode id (12)
> [    4.564894] [drm] psp command failed and response status is (-53233)
> [    4.567891] [drm] failed to load ucode id (13)
> [    4.567892] [drm] psp command failed and response status is (-65521)
> [    4.570891] [drm] failed to load ucode id (14)
> [    4.570892] [drm] psp command failed and response status is (-65521)
> 
> Thank you!
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
