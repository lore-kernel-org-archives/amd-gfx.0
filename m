Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D600C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 22:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3831A60F4B
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 22:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3831A60F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACB6F6EA8B;
	Fri, 29 Oct 2021 22:34:08 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A82D6EA8B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 22:34:08 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id h16so6117859qtk.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:reply-to:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=phUrIiWh4uIW31L0d3AdeQjbIXdcNaMUt/LLHJ0Wu9Y=;
 b=pB2cXtMUcwqzOU2uuHGyWsdS0Wmo8faeCnL0cCrJA2by+UdVONrkfVzV94+2dlh2Gv
 zhFBSCNViqRDrMzh2LydC+j/BIRtwFJ17KkjysaiorzdlUmJ52drAYkCHRJi3Xrt2VF9
 VdPznIOtX6k1apDvph7wcpdeJ/xfz8yg9vQ93kFvO1Wso26bCGw9pTpfYpa6xndvs7Wy
 kBIhVHSDeEgerCrgwpj44UxRs8wsTokTT+0A61/kwKkWxRTfz/O4eS3qwVtXA7XFe/TF
 eChpen8xNVMUHV5VsBUA8vFxJDhqSob96MuNC8pqc/2pV02Vziw1Z/EwvmWDZu6ECAwv
 qvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
 :subject:content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=phUrIiWh4uIW31L0d3AdeQjbIXdcNaMUt/LLHJ0Wu9Y=;
 b=swOLWXFbknBw8Psxx+uF0Viq9/bAWRrbiaL/zgf/wCcvqOWxrYYnjNiqLynPAP87Ll
 PeTNSoaV9/pAQwfPxf5mhXMa+XIQfcthDFtOqwlKpNWdV3bxyg6be538tkM/Tixws6az
 B9FfoCMREoVleOgLsA/xOMLHyWw9tCLzSMMNJ/4uvISYMaH0xqtnflCp8AAVQFy34RRM
 ULsKfq27MAELu9AiWHW/R8AAOA7xeSTIhJCryaYmtQw+uCWTOWhqpg2YmlIPVmQx8ddh
 TUBuW4eXd5APngJ38yIzRMdT7rze/qwUa4UxpVohIvZa25NoedoNQlNPFDAKmWDaUN3b
 h1Fw==
X-Gm-Message-State: AOAM533lwXXfguzYP+f7sX6+xanr6gmDW88yyIDPvsKclGa3e2ivQHTC
 qZCPe2BVxw8mNLXYBr+Y5Ho=
X-Google-Smtp-Source: ABdhPJyfplRRwp/MLJ1mu6YA7NOarUzmUCOv5Osb1XJU+cmd9Gqb1l951kS01kaLI2dJqsYifFilyA==
X-Received: by 2002:a05:622a:451:: with SMTP id
 o17mr15106731qtx.385.1635546847093; 
 Fri, 29 Oct 2021 15:34:07 -0700 (PDT)
Received: from mua.localhost ([2600:1700:e380:2c20::41])
 by smtp.gmail.com with ESMTPSA id y14sm5203499qtw.68.2021.10.29.15.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Oct 2021 15:34:06 -0700 (PDT)
Message-ID: <8684c741-4604-440e-870b-5ee81bfc110c@gmail.com>
Date: Fri, 29 Oct 2021 18:34:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.2.0
Subject: Re: amdgpu "Fatal error during GPU init"; Ryzen 5600G integrated GPU
 + kernel 5.14.13
Content-Language: en-US
From: PGNet Dev <pgnet.dev@gmail.com>
To: lijo.lazar@amd.com, alexdeucher@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <b4adea1b-9a21-75d2-7ee7-25d4f28ef6f8@gmail.com>
 <2303555f-42cd-180c-7a67-1d104bceea7d@gmail.com>
 <CADnq5_PsKDreYH0aNNzfR_TbfMMsfVK=-hCCB0ThZ0PzcLPCpw@mail.gmail.com>
 <27b8936d-ba79-cc13-7768-692565bedc2f@amd.com>
 <9e964b4c-6a99-6605-63ae-f42537fd01db@gmail.com>
In-Reply-To: <9e964b4c-6a99-6605-63ae-f42537fd01db@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: pgnet.dev@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

in case it's useful

	grep -i amd /var/log/Xorg.0.log | grep -v Modeline
		[   324.709] (II) Applying OutputClass "AMDgpu" to /dev/dri/card0
		[   324.709]    loading driver: amdgpu
		[   324.818] (==) Matched amdgpu as autoconfigured driver 0
		[   324.818] (II) LoadModule: "amdgpu"
		[   324.825] (II) Loading /usr/lib64/xorg/modules/drivers/amdgpu_drv.so
		[   324.877] (II) Module amdgpu: vendor="X.Org Foundation"
		[   324.992] (II) AMDGPU: Driver for AMD Radeon:
		        All GPUs supported by the amdgpu kernel driver
		[   325.108] (II) Loading sub module "ramdac"
		[   325.108] (II) LoadModule: "ramdac"
		[   325.108] (II) Module "ramdac" already built-in
		[   325.110] (II) AMDGPU(0): Creating default Display subsection in Screen section
		[   325.110] (==) AMDGPU(0): Depth 24, (--) framebuffer bpp 32
		[   325.110] (II) AMDGPU(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
		[   325.110] (==) AMDGPU(0): Default visual is TrueColor
		[   325.110] (==) AMDGPU(0): RGB weight 888
		[   325.110] (II) AMDGPU(0): Using 8 bits per RGB (8 bit DAC)
		[   325.110] (--) AMDGPU(0): Chipset: "Unknown AMD Radeon GPU" (ChipID = 0x1638)
		[   327.957] (II) AMDGPU(0): glamor X acceleration enabled on AMD RENOIR (DRM 3.42.0, 5.14.14-200.fc34.x86_64, LLVM 12.0.1)
		[   327.957] (II) AMDGPU(0): glamor detected, initialising EGL layer.
		[   327.957] (==) AMDGPU(0): TearFree property default: auto
		[   327.957] (==) AMDGPU(0): VariableRefresh: disabled
		[   327.957] (II) AMDGPU(0): KMS Pageflipping: enabled
		[   327.957] (II) AMDGPU(0): Output HDMI-A-0 has no monitor section
		[   327.958] (II) AMDGPU(0): Output HDMI-A-1 has no monitor section
		[   327.958] (II) AMDGPU(0): Output DisplayPort-0 has no monitor section
		[   327.963] (II) AMDGPU(0): EDID for output HDMI-A-0
		[   327.963] (II) AMDGPU(0): EDID for output HDMI-A-1
		[   327.963] (II) AMDGPU(0): Manufacturer: VSC  Model: cc32  Serial#: 16843025
		[   327.963] (II) AMDGPU(0): Year: 2018  Week: 47
		[   327.963] (II) AMDGPU(0): EDID Version: 1.3
		[   327.963] (II) AMDGPU(0): Digital Display Input
		[   327.963] (II) AMDGPU(0): Max Image Size [cm]: horiz.: 60  vert.: 34
		[   327.963] (II) AMDGPU(0): Gamma: 2.20
		[   327.963] (II) AMDGPU(0): DPMS capabilities: Off
		[   327.963] (II) AMDGPU(0): Supported color encodings: RGB 4:4:4 YCrCb 4:4:4
		[   327.963] (II) AMDGPU(0): Default color space is primary color space
		[   327.963] (II) AMDGPU(0): First detailed timing is preferred mode
		[   327.963] (II) AMDGPU(0): redX: 0.661 redY: 0.332   greenX: 0.304 greenY: 0.613
		[   327.963] (II) AMDGPU(0): blueX: 0.149 blueY: 0.060   whiteX: 0.313 whiteY: 0.329
		[   327.963] (II) AMDGPU(0): Supported established timings:
		[   327.963] (II) AMDGPU(0): 720x400@70Hz
		[   327.963] (II) AMDGPU(0): 640x480@60Hz
		[   327.963] (II) AMDGPU(0): 640x480@67Hz
		[   327.963] (II) AMDGPU(0): 640x480@72Hz
		[   327.963] (II) AMDGPU(0): 640x480@75Hz
		[   327.963] (II) AMDGPU(0): 800x600@56Hz
		[   327.963] (II) AMDGPU(0): 800x600@60Hz
		[   327.963] (II) AMDGPU(0): 800x600@72Hz
		[   327.963] (II) AMDGPU(0): 800x600@75Hz
		[   327.964] (II) AMDGPU(0): 832x624@75Hz
		[   327.964] (II) AMDGPU(0): 1024x768@60Hz
		[   327.964] (II) AMDGPU(0): 1024x768@70Hz
		[   327.964] (II) AMDGPU(0): 1024x768@75Hz
		[   327.964] (II) AMDGPU(0): 1280x1024@75Hz
		[   327.964] (II) AMDGPU(0): 1152x864@75Hz
		[   327.964] (II) AMDGPU(0): Manufacturer's mask: 0
		[   327.964] (II) AMDGPU(0): Supported standard timings:
		[   327.964] (II) AMDGPU(0): #0: hsize: 2048  vsize 1152  refresh: 60  vid: 49377
		[   327.964] (II) AMDGPU(0): #1: hsize: 1920  vsize 1200  refresh: 60  vid: 209
		[   327.964] (II) AMDGPU(0): #2: hsize: 1920  vsize 1080  refresh: 60  vid: 49361
		[   327.964] (II) AMDGPU(0): #3: hsize: 1680  vsize 1050  refresh: 60  vid: 179
		[   327.964] (II) AMDGPU(0): #4: hsize: 1600  vsize 900  refresh: 60  vid: 49321
		[   327.964] (II) AMDGPU(0): #5: hsize: 1280  vsize 1024  refresh: 60  vid: 32897
		[   327.964] (II) AMDGPU(0): #6: hsize: 1280  vsize 800  refresh: 60  vid: 129
		[   327.964] (II) AMDGPU(0): #7: hsize: 1280  vsize 720  refresh: 60  vid: 49281
		[   327.964] (II) AMDGPU(0): Supported detailed timing:
		[   327.964] (II) AMDGPU(0): clock: 241.5 MHz   Image Size:  597 x 336 mm
		[   327.964] (II) AMDGPU(0): h_active: 2560  h_sync: 2608  h_sync_end 2640 h_blank_end 2720 h_border: 0
		[   327.964] (II) AMDGPU(0): v_active: 1440  v_sync: 1443  v_sync_end 1448 v_blanking: 1481 v_border: 0
		[   327.964] (II) AMDGPU(0): Serial No: UP2184700251
		[   327.964] (II) AMDGPU(0): Ranges: V min: 24 V max: 120 Hz, H min: 15 H max: 130 kHz, PixClock max 305 MHz
		[   327.964] (II) AMDGPU(0): Monitor name: VP2771
		[   327.964] (II) AMDGPU(0): Supported detailed timing:
		[   327.964] (II) AMDGPU(0): clock: 148.5 MHz   Image Size:  597 x 336 mm
		[   327.964] (II) AMDGPU(0): h_active: 1920  h_sync: 2008  h_sync_end 2052 h_blank_end 2200 h_border: 0
		[   327.964] (II) AMDGPU(0): v_active: 1080  v_sync: 1084  v_sync_end 1089 v_blanking: 1125 v_border: 0
		[   327.964] (II) AMDGPU(0): Supported detailed timing:
		[   327.964] (II) AMDGPU(0): clock: 74.2 MHz   Image Size:  597 x 336 mm
		[   327.964] (II) AMDGPU(0): h_active: 1920  h_sync: 2008  h_sync_end 2052 h_blank_end 2200 h_border: 0
		[   327.964] (II) AMDGPU(0): v_active: 540  v_sync: 542  v_sync_end 547 v_blanking: 562 v_border: 0
		[   327.964] (II) AMDGPU(0): Supported detailed timing:
		[   327.964] (II) AMDGPU(0): clock: 74.2 MHz   Image Size:  597 x 336 mm
		[   327.964] (II) AMDGPU(0): h_active: 1280  h_sync: 1390  h_sync_end 1430 h_blank_end 1650 h_border: 0
		[   327.964] (II) AMDGPU(0): v_active: 720  v_sync: 725  v_sync_end 730 v_blanking: 750 v_border: 0
		[   327.964] (II) AMDGPU(0): Supported detailed timing:
		[   327.964] (II) AMDGPU(0): clock: 127.8 MHz   Image Size:  597 x 336 mm
		[   327.964] (II) AMDGPU(0): h_active: 1280  h_sync: 1328  h_sync_end 1360 h_blank_end 1440 h_border: 0
		[   327.964] (II) AMDGPU(0): v_active: 1440  v_sync: 1443  v_sync_end 1453 v_blanking: 1481 v_border: 0
		[   327.964] (II) AMDGPU(0): Number of EDID sections to follow: 1
		[   327.964] (II) AMDGPU(0): EDID (in hex):
		[   327.964] (II) AMDGPU(0):    00ffffffffffff005a6332cc11010101
		[   327.964] (II) AMDGPU(0):    2f1c0103803c22782e4c55a9554d9d26
		[   327.964] (II) AMDGPU(0):    0f5054bfef80e1c0d100d1c0b300a9c0
		[   327.964] (II) AMDGPU(0):    8180810081c0565e00a0a0a029503020
		[   327.964] (II) AMDGPU(0):    350055502100001a000000ff00555032
		[   327.964] (II) AMDGPU(0):    3138343730303235310a000000fd0018
		[   327.964] (II) AMDGPU(0):    780f821e000a202020202020000000fc
		[   327.964] (II) AMDGPU(0):    005650323737310a2020202020200190
		[   327.964] (II) AMDGPU(0):    020334f15b5f1005040302070609080f
		[   327.964] (II) AMDGPU(0):    0e1f2021221413121116151a191e1d01
		[   327.964] (II) AMDGPU(0):    23097f07830100006b030c001300003c
		[   327.964] (II) AMDGPU(0):    20002001023a801871382d40582c4500
		[   327.964] (II) AMDGPU(0):    55502100001e011d8018711c1620582c
		[   327.964] (II) AMDGPU(0):    250055502100009e011d007251d01e20
		[   327.964] (II) AMDGPU(0):    6e28550055502100001ee73100a050a0
		[   327.964] (II) AMDGPU(0):    295030203a0055502100001a000000b7
		[   327.964] (--) AMDGPU(0): HDMI max TMDS frequency 300000KHz
		[   327.964] (II) AMDGPU(0): Printing probed modes for output HDMI-A-1
		[   327.964] (II) AMDGPU(0): EDID for output DisplayPort-0
		[   327.964] (II) AMDGPU(0): Output HDMI-A-0 disconnected
		[   327.964] (II) AMDGPU(0): Output HDMI-A-1 connected
		[   327.964] (II) AMDGPU(0): Output DisplayPort-0 disconnected
		[   327.964] (II) AMDGPU(0): Using exact sizes for initial modes
		[   327.964] (II) AMDGPU(0): Output HDMI-A-1 using initial mode 2560x1440 +0+0
		[   327.964] (II) AMDGPU(0): mem size init: gart size :bf6ca000 vram size: s:1d906000 visible:1d906000
		[   327.964] (==) AMDGPU(0): DPI set to (96, 96)
		[   327.964] (==) AMDGPU(0): Using gamma correction (1.0, 1.0, 1.0)
		[   327.964] (II) Loading sub module "ramdac"
		[   327.964] (II) LoadModule: "ramdac"
		[   327.964] (II) Module "ramdac" already built-in
		[   328.774] (II) AMDGPU(0): [DRI2] Setup complete
		[   328.774] (II) AMDGPU(0): [DRI2]   DRI driver: radeonsi
		[   328.774] (II) AMDGPU(0): [DRI2]   VDPAU driver: radeonsi
		[   329.625] (II) AMDGPU(0): Front buffer pitch: 10240 bytes
		[   329.642] (II) AMDGPU(0): SYNC extension fences enabled
		[   329.642] (II) AMDGPU(0): Present extension enabled
		[   329.642] (==) AMDGPU(0): DRI3 enabled
		[   329.642] (==) AMDGPU(0): Backing store enabled
		[   329.642] (II) AMDGPU(0): Direct rendering enabled
		[   329.944] (II) AMDGPU(0): Use GLAMOR acceleration.
		[   329.944] (II) AMDGPU(0): Acceleration enabled
		[   329.944] (==) AMDGPU(0): DPMS enabled
		[   329.944] (==) AMDGPU(0): Silken mouse enabled
		[   329.965] (II) AMDGPU(0): Set up textured video (glamor)
		[   330.109] (II) AMDGPU(0): Setting screen physical size to 677 x 381
		[   337.993] (II) AMDGPU(0): EDID vendor "VSC", prod id 52274
		[   337.993] (II) AMDGPU(0): Using EDID range info for horizontal sync
		[   337.993] (II) AMDGPU(0): Using EDID range info for vertical refresh
		[   337.993] (--) AMDGPU(0): HDMI max TMDS frequency 300000KHz
		[   337.994] (II) AMDGPU(0): EDID vendor "VSC", prod id 52274
		[   337.994] (II) AMDGPU(0): Using hsync ranges from config file
		[   337.994] (II) AMDGPU(0): Using vrefresh ranges from config file
		[   337.995] (--) AMDGPU(0): HDMI max TMDS frequency 300000KHz

	rpm -q --whatprovides  /usr/lib64/xorg/modules/drivers/amdgpu_drv.so
		xorg-x11-drv-amdgpu-21.0.0-1.fc34.x86_64
