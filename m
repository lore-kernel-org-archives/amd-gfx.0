Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1C1C4CECC
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 20:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29EF62070B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 20:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q/8Ch/+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29EF62070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C89216E084;
	Mon, 27 Apr 2020 20:50:14 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750053.outbound.protection.outlook.com [40.107.75.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A6846E084
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 20:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoqhbvbMxxZS1trqe4D32QHHQ1Etzu0C4/b8yGKPIOt6v9JIK1CxgKfE30Lh5QEqdNSOAtVSWPkfQFDwzni2cHrl99TgRxR/ocp0H1icA8pk8Dvg8N8jHazHfkpt+swm6EJ2MMIH1anUhEM4yaSYram2un+LqeBQ5RuJi4y2urZ8sIbho3htLlaQZ9mrNeGUVuIngxrV3SuJXjaJVbbZ4Pf0lKbHO89Qtu1q1fQJHpew3ubQUB3TuGxjYwAY50DrilnCXMm5AwPwe8nOBLtCIjYyhAO86I5SBBczOI4mUwLZqJDOBPcKv7i19EaXtRV2uQ/NrV2YKkDzSnxWCcIIsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLywoWGHIMPFErZIwE3gV2qvxnfEp0ZMGZFHuuz5SPM=;
 b=Dc3HfkLygKrUVQKNxllX0DaqKEzwu/0C6lSqpY4wEQnZ7fYgguvDY6GtfG64/lSZKWOVqZQrPsXBIGplVulUD05dE6BVbQvqQoiYbI1gAFWQIr3PuRY6cTtGc+RBZOiuXQ8wew+Q/dLhTdD1AUzrujbuz4RNaPra8LzXoPQH0sRk0kbGgcO1MP1EZ5L3nWjcVTLwjUuRfO1ehVVpnlFZsb6tlL9TKx+FogzLaNz/toBMEb7XumBGHfv7paN1posDD6siBSTe1u4hyr+1U8PNttZ0UB0b/IbXzUD1v5tA+y1exdglsGXy2m1DcolcODT49alSRH/vdKmWjlQzNVphLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLywoWGHIMPFErZIwE3gV2qvxnfEp0ZMGZFHuuz5SPM=;
 b=q/8Ch/+f0nfdA4Zz84ucA4gI2SuhBHQ4+ZacONjNocXexOHUMgxRkM0GhE/yq7tgtezB8uqixYKvPJjf0f+S9Kbp5PFHiImI4aGBXaHNGPiQKAYE3ZPYBibMuNGAGFTDcdUbvbvwodiP+MKIk50OxJ3VSEGsmajOD+58oEWeORY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4506.namprd12.prod.outlook.com (2603:10b6:303:53::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 20:50:10 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97%6]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 20:50:10 +0000
Subject: Re: FreeBSD / amdgpu / Vega 3, pstate TEST_DEBUG_DATA: 0x0
To: Andriy Gapon <avg@FreeBSD.org>, amd-gfx@lists.freedesktop.org
References: <ded7ad97-cc17-ffda-f476-cc5513e18b88@FreeBSD.org>
 <c264b43a-d38d-89c7-4481-3320579bc1c9@amd.com>
 <a62db7cd-a496-1f7f-fda4-2326441abc7f@FreeBSD.org>
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
Message-ID: <feb01e14-2d40-a794-44e8-c82ef2801558@amd.com>
Date: Mon, 27 Apr 2020 16:50:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <a62db7cd-a496-1f7f-fda4-2326441abc7f@FreeBSD.org>
Content-Language: en-US
X-ClientProxiedBy: BN6PR19CA0113.namprd19.prod.outlook.com
 (2603:10b6:404:a0::27) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:9240:c66::3] (2607:fea8:9240:c66::3) by
 BN6PR19CA0113.namprd19.prod.outlook.com (2603:10b6:404:a0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 20:50:09 +0000
X-Originating-IP: [2607:fea8:9240:c66::3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: af661f66-0090-43b0-0284-08d7eaec9370
X-MS-TrafficTypeDiagnostic: MW3PR12MB4506:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4506356D5C5EAD000BC1E3DF8CAF0@MW3PR12MB4506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(66556008)(66946007)(66476007)(31686004)(8676002)(36756003)(316002)(6486002)(8936002)(81156014)(53546011)(52116002)(16526019)(186003)(2616005)(5660300002)(31696002)(2906002)(966005)(478600001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pd6+5dM1MipR1cxXQZb69Q/po1sf1CU2WzNMz5ICxVEwh8k7CpJQR/HnQhVUVYwas6Rb1uVzsE/pA4Hzx0WDhO57qogJJL5Pxm0y65y163iUQ/a2qWvm7YH0dliUs0OrzY9vyn0xWKYWnKaKe8wTbnLAkTY6qX5LRo2wvhbyXgjLICVYkWqWrJqS/UkL6tAIpXj40fnRa8INycOZpBUNJZOQp4eujgnyFOO2nlG/6S4p6o3/Vhk9/nuzMuljXaBlB0pyLgp5uDsbP5wr0nKox7qoqDbPryQ3ZsXb0IafKeLuH8bJOV+buimJcWqEp1fd8a1X+ONVRtEn2HEMpyEaQp1yn8dUFG26gz4O55Vw6EYJpAjat2HFRwEiPM2GNFtrIB/g0IB/4vuwwcah2uS4qZZGHq2zAF9M9o3BKGD4oySuOSlos+GNX3oS5tEZiB3PuYfEJdsDKXDgYC/d0STc/FJ6GiMdWtAbp/fw0lIyOrlZdvRO278jFXxfBogD0vFJggEVSrPGBRDmj6/BQcbzLw==
X-MS-Exchange-AntiSpam-MessageData: C/9kQ2CvxpjCFVkJikhJzP+Y6iZZ9aCxP+PREva7ZmNKvRL7Gko0GeJV/boLXRBLJWd6unK4t3RvzLToyD2Qw9iYZyu+VXUyRcGJHSAjRtIJiyly2ijmkNWFeSmUKyKYEhTlS2fhoEl/NTxXXU+v1YSrMv3l1rW1/GwSQ6tFATWEnO3CwM+kfWaDou4RtLhUSHI6fLl+YwzcFqdPTxXg+cEtZeaxMs2IKxC1PyRBbzBGNjhrxC8JjiQ163EoemkFPzOe5+K7g3vNb8NFKFDHn8cxL1qV5aqV3nKWHiM7MsZ5hzj6dD1SINj1WR1VusV0wR9fGqHXtMAr7LWhNCEK0GunLMfxsx3Bdj+WO5YerBSpDqHQbyIg2XBje3vFBkEqMLHFT1x7LRHOgo3fhpAaJ6DioxXP1rmjwSFYJ1+t/PHQ9nP+glY0QRQ/6ByOTjg/9AlMEetVGK4T799go3RpYb+x9T4w6ozJjpbmq/CKIWB7Z6aZVj30oH6F16GsB3FPjoIxdKl0B70BegAYFCms+cUWQh4XSKqpC6qta/EWdsmoRwUdbaRQx2IniPyWlD6s33xi13iY8dWMerssfWSmYNr7Pj0XgeGFWFsw91nQXgpX2yaGM7q179S0EcomDnlzfF083mGAQoWuhN16Hx3/kRMKaqKEaD6Mc7Y1avP3ocUDOKr3nLqIdDVDMKDijspTgLZsz0Yx9sLMZhhvQykNjoeY3ZoMY3dforCr+mjK8pgIQL287V0GY6jM/RHcHWtx3ZCnOVqUr/Eh37yOAlVqr4EHtilV3quF7nghNsFNDrX6++h8lgafMm1tHdFx4+BV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af661f66-0090-43b0-0284-08d7eaec9370
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 20:50:10.5157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nErPrSQAN9hMWC4N9XqzmIpBGi96uGfcob3v+UgRWxP+1H35muowhdKQ619rQk2Usc60+sXNVSxgArfpWH1FMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4506
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



On 2020-04-27 4:43 p.m., Andriy Gapon wrote:
> On 24/04/2020 20:22, Harry Wentland wrote:
>> On 2020-04-24 8:34 a.m., Andriy Gapon wrote:
>>>
>>> First, I understand that my platform is not directly supported and probably not
>>> very interesting, but I still hope to get some tips or pointers.
>>>
>>
>> Hi Andriy,
>>
>> yeah, limited insight here since FreeBSD isn't something I'm familiar
>> with. :)
> 
> Harry,
> 
> thanks a lot for your help.  It set me on a right path, although a bit
> indirectly :-)
> 
> Let me start by saying that I was able to fix the driver.
> 
> After looking at the laptop in a dark room I could see that the backlight was
> actually on, but there was no video output.
> 
> So, I went back to comparing FreeBSD and Linux logs, especially around the place
> where "TEST_DEBUG_DATA: 0x0" was reported.  And then suddenly I spotted what I
> missed before.  Linux reported 3 pipes while FreeBSD reported 4.  And the errors
> were about the forth, non-existent, pipe -- I guess, not surprising at all.
> With some additional printfs I could confirm it for sure.  So, then I looked for
> the code where the number of pipes is set and almost immediately could see the
> problem.
> 
> FreeBSD amdgpu has DCN_VERSION_1_01 support ifdef-ed out, for whatever reason.
> Your commit "drm/amd/display: Drop DCN1_01 guards" has not been ported yet and
> CONFIG_DRM_AMD_DC_DCN1_01 is not defined.  Of course, the number of pipes was
> not the only thing that did not match the actual hardware/firmware because of
> that.  Once I set CONFIG_DRM_AMD_DC_DCN1_01 everything just worked.
> 
> Thank you again!
> 

Awesome. Glad my comment helped and glad you found the problem.

Harry

>>> I am trying to get amdgpu/FreeBSD going on Motile M141 laptop with Ryzen 3 3200U
>>> CPU that has Vega 3 graphics integrated.  When amdgpu starts loading the screen
>>> goes black and never lights up again.  I am not sure whether there is no signal
>>> at all or whether the backlight is turned off, but the screen is completely
>>> dark.  I can blindly interact with the system, so it's not crashed or hung.
>>> From system logs I can see that the driver attaches successfully.  It recognizes
>>> the hardware, loads its firmware, detects the eDP screen and so on.
>>>
>>
>> Does BSD have a way to check or set your backlight value manually (a la
>> /sys/class/backlight on linux)? If so I'd suggest checking and setting
>> it to non-zero values, ideally to max_brightness.
>>
>> Have you tried an external display?
>>
>>> The FreeBSD's amdgpu port that I am trying is based on code circa 5.0.
>>> There is no newer version ported.
>>> I tried a couple of Linux distros with 5.3.x kernels and they worked without any
>>> problems. So that gives me some hope.
>>>
>>> I compared driver messages (with drm_debug set to 0xfff) between Linux and
>>> FreeBSD and they look quite similar.  Except for one thing.
>>> In the FreeBSD case there are these error messages that are not seen with Linux:
>>>
>>> [drm] pstate TEST_DEBUG_DATA: 0x0
>>> WARNING !(0) failed at
>>> /usr/home/avg/devel/kms-drm/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c:868
>>> #0 0xffffffff83451633 at linux_dump_stack+0x23
>>> #1 0xffffffff8325a9ee at dcn10_verify_allow_pstate_change_high+0x4e
>>> #2 0xffffffff8325e925 at dcn10_wait_for_mpcc_disconnect+0x25
>>> #3 0xffffffff8325de53 at dcn10_disable_plane+0x53
>>> #4 0xffffffff8325c9f5 at dcn10_init_hw+0x755
>>> #5 0xffffffff83295ca8 at dc_create+0x538
>>> #6 0xffffffff8327a8da at dm_hw_init+0x1ea
>>> #7 0xffffffff831701d1 at amdgpu_device_init+0x1b11
>>> #8 0xffffffff83185177 at amdgpu_driver_load_kms+0xd7
>>> #9 0xffffffff833f138e at drm_dev_register+0x17e
>>> #10 0xffffffff83178dea at amdgpu_pci_probe+0x18a
>>> #11 0xffffffff83456f40 at linux_pci_attach+0x560
>>> #12 0xffffffff80bf68ea at device_attach+0x3ca
>>> #13 0xffffffff80bf6490 at device_probe_and_attach+0x70
>>> #14 0xffffffff80bf8358 at bus_generic_driver_added+0x58
>>> #15 0xffffffff80bf4289 at devclass_driver_added+0x39
>>> #16 0xffffffff80bf41c7 at devclass_add_driver+0x147
>>> #17 0xffffffff83455ae9 at _linux_pci_register_driver+0xc9
>>>
>>> That warning plus stack trace is actually BREAK_TO_DEBUGGER() in the original
>>> Linux code.
>>> So, that makes me think that the problem is pretty serious.
>>
>> BREAK_TO_DEBUGGER is probably overly scary here. It's somewhat a concern
>> as this means power consumption might be higher than expected. We've
>> seen this issue on several systems without any other adverse effects to
>> usability.
>>
>> Harry
>>
>>> I tried searching for "TEST_DEBUG_DATA: 0x0" and I could not find a single
>>> result with "0x0" in it.  Usually there is some non-zero value.
>>> To me this looks like maybe some hardware component is not turned on...
>>> Perhaps this is something relatively obvious for people that hack on the driver
>>> and the hardware.
>>> I hope to receive some hint about what to look for.
>>> I can cherry-pick commits from Linux, apply patches, add additional debugging
>>> logs, etc.
>>>
>>> FreeBSD amdgpu dmesg: https://people.freebsd.org/~avg/amdgpu.dmesg.txt
>>> Full Linux dmesg: https://people.freebsd.org/~avg/linux-5.3.0-28.dmesg.out
>>>
>>> And with with drm_debug=0xfff.
>>> FreeBSD: https://people.freebsd.org/~avg/fbsd-dmesg.txt
>>> Linux: https://people.freebsd.org/~avg/linux-5.3.9-dmesg.txt
>>>
>>> I see that both Linux and FreeBSD have similar messages about failing to load
>>> some microcode components, but I guess that it must be okay since Linux works:
>>> [    4.487381] [drm] reserve 0x400000 from 0xf400c00000 for PSP TMR
>>> [    4.564893] [drm] failed to load ucode id (12)
>>> [    4.564894] [drm] psp command failed and response status is (-53233)
>>> [    4.567891] [drm] failed to load ucode id (13)
>>> [    4.567892] [drm] psp command failed and response status is (-65521)
>>> [    4.570891] [drm] failed to load ucode id (14)
>>> [    4.570892] [drm] psp command failed and response status is (-65521)
> 
> 
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
