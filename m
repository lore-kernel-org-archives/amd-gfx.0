Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C88C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 13:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CE0C8DF3A;
	Thu, 11 Aug 2022 13:22:55 +0000 (UTC)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E72858D716
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 13:22:46 +0000 (UTC)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx0.riseup.net (Postfix) with ESMTPS id 4M3SCn4DZrz9sF3;
 Thu, 11 Aug 2022 13:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1660224166; bh=jgxcJWwtwfKgw5HutrqI20z18f8f70toYUux33HP6iw=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=mIThNjLtvHJOJpRKkz+VgQ9tdVSBH2Ciqr42Qqz6yC1xgOPu/5dzG0nbPPfs+1tfO
 rgengHTLVgiUrfQH3R1b6pCuQpXvFQjYWEexD8y+e7eSm5VdR3rbTDompKPCcaUo75
 KZxvqtQCiufw4Gy1BRakKJdvr1HC2rR8tsepB/zo=
X-Riseup-User-ID: D97836AAD10454D85E822580D34A18EB6711DFE45D17A8F64E17202019FF7FC3
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews2.riseup.net (Postfix) with ESMTPSA id 4M3SCf33V5z1yWw;
 Thu, 11 Aug 2022 13:22:38 +0000 (UTC)
Message-ID: <345e6701-aa18-c347-a515-62d897125a4f@riseup.net>
Date: Thu, 11 Aug 2022 10:22:31 -0300
MIME-Version: 1.0
From: =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
Subject: Re: [PATCH 1/8] drm/amd/display: Introduce KUnit tests for fixed31_32
 library
To: David Gow <davidgow@google.com>, Daniel Latypov <dlatypov@google.com>
References: <20220811004010.61299-1-tales.aparecida@gmail.com>
 <20220811004010.61299-2-tales.aparecida@gmail.com>
 <CAGS_qxryOVG_ZvV1+i_egPZO8Ngq4EoFRK=Q_J9S8urj3kPyxA@mail.gmail.com>
 <CABVgOSm0Sakf8wnwCt8xB09+U3rzgxYPToOWkJK4ssfc-AkX2A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABVgOSm0Sakf8wnwCt8xB09+U3rzgxYPToOWkJK4ssfc-AkX2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: andrealmeid@riseup.net, Thomas Zimmermann <tzimmermann@suse.de>,
 siqueirajordao@riseup.net, Jonathan Corbet <corbet@lwn.net>,
 David Airlie <airlied@linux.ie>, Tales Aparecida <tales.aparecida@gmail.com>,
 Trevor Woerner <twoerner@gmail.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, mwen@igalia.com,
 Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 magalilemes00@gmail.com, Isabella Basso <isabbasso@riseup.net>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 KUnit Development <kunit-dev@googlegroups.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/11/22 04:19, David Gow wrote:
> On Thu, Aug 11, 2022 at 11:05 AM 'Daniel Latypov' via KUnit
> Development <kunit-dev@googlegroups.com> wrote:
>>
>> On Wed, Aug 10, 2022 at 5:40 PM Tales Aparecida
>> <tales.aparecida@gmail.com> wrote:
>>>
>>> The fixed31_32 library performs a lot of the mathematical operations
>>> involving fixed-point arithmetic and the conversion of integers to
>>> fixed-point representation.
>>>
>>> This unit tests intend to assure the proper functioning of the basic
>>> mathematical operations of fixed-point arithmetic, such as
>>> multiplication, conversion from fractional to fixed-point number,
>>> and more. Use kunit_tool to run:
>>>
>>> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
>>>          --kunitconfig=drivers/gpu/drm/amd/display/tests/
>>
>> Nice, thanks for including a kunitconfig, that'll help a lot.
>>
>> Just as an FYI: if you're working on top of torvalds/master, I think
>> you would no longer need --arch=x86_64.
>> Before, CONFIG_PCI=y was tricky to enable on UML, but commit
>> 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
>> landed for 6.0.
>>
>> I.e. I can run this command on torvalds/master w/ no other patches applied:
>>
>> $ ./tools/testing/kunit/kunit.py config --kunitconfig=/dev/stdin <<EOF
>> CONFIG_KUNIT=y
>> CONFIG_PCI=y
>> CONFIG_DRM=y
>> CONFIG_DRM_AMDGPU=y
>> CONFIG_DRM_AMD_DC=y
>> EOF
>>
>> I haven't tried to apply this series locally yet to double-check, but
>> I'm pretty sure that means these tests should work as well.
>> Running under UML would hopefully have faster compile times and be
>> less resource heavy than a QEMU VM (but I've not measured to verify
>> that).
>>
> 
> 
> There are still a few issues which prevent these tests from working on
> UML I haven't had a chance to go through all of them yet, but I'll
> drop a couple of quick responses to some of the individual patches.
> 
> The first thing to note is that amdgpu doesn't actually build on UML
> at all without:
> https://patchwork.kernel.org/project/linux-rdma/patch/20220218075727.2737623-3-davidgow@google.com/
> 
> IIRC, no-one liked spreading !defined(CONFIG_UML) everwhere. Replacing
> it with IS_ENABLED(CONFIG_X86) also works, as X86_64 is defined on
> UML, but X86 isn't.
> 
> The other issues are basically just other missing #ifdef checks or
> dependencies. Plus there's a warning on my system even under x86_64
> for integer overflow in the MIN_I64 definition.

Currently, we only support the tests to x86_64, as the DC core don't
build to UML yet. In the future, I intend to send the patch that enables
the tests to run on UML, but for the first iteration, we focused in running
the tests on x86.

If you want with UML, you can apply the following patch (which is working in
progress yet):
------
 From cac02e5d714d78e1d69995383b818eec26661925 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Date: Sat, 23 Jul 2022 14:57:41 -0300
Subject: [PATCH] drm/amdgpu: Enable compilation under UML
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The User-Mode Linux configuration is used by KUnit to execute kernel
results directly. This removes the need for a test machine or a virtual
machine. Therefore, as KUnit tests are being added to AMDGPU, it is
interesting to enable compilation under UML, as it eases running the tests
on CI and developers' machines.

Also, the use of UML is encouraged by the KUnit team [1], as it is considered
a better practice to write tests that run on UML to tests that only run
under a particular architecture.

[1] https://docs.kernel.org/dev-tools/kunit/usage.html#writing-tests-for-other-architectures

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
  drivers/gpu/drm/amd/amdkfd/kfd_crat.c               | 6 +++---
  drivers/gpu/drm/amd/amdkfd/kfd_topology.c           | 2 +-
  drivers/gpu/drm/amd/display/Kconfig                 | 2 +-
  drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c       | 8 ++++----
  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 2 +-
  5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index a5409531a2fd..bbed3284e78e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1766,7 +1766,7 @@ static int kfd_fill_mem_info_for_cpu(int numa_node_id, int *avail_size,
  	return 0;
  }
  
-#ifdef CONFIG_X86_64
+#if IS_ENABLED(CONFIG_X86)
  static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
  				uint32_t *num_entries,
  				struct crat_subtype_iolink *sub_type_hdr)
@@ -1825,7 +1825,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
  	struct crat_subtype_generic *sub_type_hdr;
  	int avail_size = *size;
  	int numa_node_id;
-#ifdef CONFIG_X86_64
+#if IS_ENABLED(CONFIG_X86)
  	uint32_t entries = 0;
  #endif
  	int ret = 0;
@@ -1890,7 +1890,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
  			sub_type_hdr->length);
  
  		/* Fill in Subtype: IO Link */
-#ifdef CONFIG_X86_64
+#if IS_ENABLED(CONFIG_X86)
  		ret = kfd_fill_iolink_info_for_cpu(numa_node_id, &avail_size,
  				&entries,
  				(struct crat_subtype_iolink *)sub_type_hdr);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 25990bec600d..5f0e58c430a1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1923,7 +1923,7 @@ static int kfd_cpumask_to_apic_id(const struct cpumask *cpumask)
  	first_cpu_of_numa_node = cpumask_first(cpumask);
  	if (first_cpu_of_numa_node >= nr_cpu_ids)
  		return -1;
-#ifdef CONFIG_X86_64
+#if IS_ENABLED(CONFIG_X86)
  	return cpu_data(first_cpu_of_numa_node).apicid;
  #else
  	return first_cpu_of_numa_node;
diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 72e7a63da79f..d066af22ecea 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -6,7 +6,7 @@ config DRM_AMD_DC
  	bool "AMD DC - Enable new display engine"
  	default y
  	select SND_HDA_COMPONENT if SND_HDA_CORE
-	select DRM_AMD_DC_DCN if (X86 || PPC64)
+	select DRM_AMD_DC_DCN if (X86 || PPC64 || UML)
  	help
  	  Choose this option if you want to use the new display engine
  	  support for AMDGPU. This adds required support for Vega and
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c
index 660510842ecf..a591090784ee 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c
@@ -39,7 +39,7 @@
  #define REG(reg)\
  	(gpio->regs->reg)
  
-static void store_registers(
+static void hw_gpio_store_registers(
  	struct hw_gpio *gpio)
  {
  	REG_GET(MASK_reg, MASK, &gpio->store.mask);
@@ -48,7 +48,7 @@ static void store_registers(
  	/* TODO store GPIO_MUX_CONTROL if we ever use it */
  }
  
-static void restore_registers(
+static void hw_gpio_restore_registers(
  	struct hw_gpio *gpio)
  {
  	REG_UPDATE(MASK_reg, MASK, gpio->store.mask);
@@ -63,7 +63,7 @@ bool dal_hw_gpio_open(
  {
  	struct hw_gpio *pin = FROM_HW_GPIO_PIN(ptr);
  
-	store_registers(pin);
+	hw_gpio_store_registers(pin);
  
  	ptr->opened = (dal_hw_gpio_config_mode(pin, mode) == GPIO_RESULT_OK);
  
@@ -132,7 +132,7 @@ void dal_hw_gpio_close(
  {
  	struct hw_gpio *pin = FROM_HW_GPIO_PIN(ptr);
  
-	restore_registers(pin);
+	hw_gpio_restore_registers(pin);
  
  	ptr->mode = GPIO_MODE_UNKNOWN;
  	ptr->opened = false;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index e4fcbf8a7eb5..825b80590f1b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1738,7 +1738,7 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
  
  static bool intel_core_rkl_chk(void)
  {
-#if IS_ENABLED(CONFIG_X86_64)
+#if IS_ENABLED(CONFIG_X86)
  	struct cpuinfo_x86 *c = &cpu_data(0);
  
  	return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
-- 
2.37.1
------

Best Regards,
- Maíra Canal

> 
> Cheers,
> -- David
