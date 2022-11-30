Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CD8C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 07:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD69210E416;
	Wed, 30 Nov 2022 07:27:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BDE310E416
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 07:27:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POMrFYz9J522+RkkKB4au83CUg2+H/2sZz8OMrk5Qo0ksfmBpKJHS9nPcWN9HSFtVqxeG+MbVC3ufhDZeSkEk8CB32Cxvg2fz5Mbnf4K8FRDo+Ap8XK/dW4+5ePoNjsGPnjdOP67Let02DKHM/N6ioFYqqeUT/OZcZu03vy8hWI6K1bmnjB5vBdCK/5BggBDgGHVTD5jHbzey9DbD95eBumB6ZAWZcA5x7WTN1eJkdCLl9zPalvwb+ayxB9JDmjv+OZv9fMyxAimm/FcCa3+tDJYiI9zY7NUQUD/O3SVPOeVbG7gavPmX1zXCA3OPxXbM7M9Y5+YyFUFZ8mgO3QGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxhVLopzEBRLcIkKEnfT7Y2MKbnZodmRRsWQAopitK8=;
 b=BBT2miSEbjL6HK+COsa+foOpytZGokvS4Ymg/EpBGg5nng796b0F8fwu1M9VBjRjyZh/vcRlthRAl7nbsvdzzFvKIkKE0WQaVm3QCI7dF5TMDGLGne69G3FhCwnXXmXbz9OYFTES2QhQzRMTBl10lh7tQJHo+ZaLB1lCAIhZc1Fk+8XPru63iDCm8khWJZtmtbXswVnficXBoCNZ1eRzfCQJ64bGLUAlnmIROv56+uU+cza+FJn2rJqm5FXy9MEJhhyEMEE+RbqNqj1ow0L6FxpDKAJa4+eGQSidqxIstAzggIUQeonDklqHBvg9DvLOeUdbYnrjb3yA0lCcHJl24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxhVLopzEBRLcIkKEnfT7Y2MKbnZodmRRsWQAopitK8=;
 b=NTxnEsuXdBvXEEyfD33QXjV3L1XZnZmt+cv6Uh2dNPcpiKFEbuGVo1CjuuQXDZWtLChoKwGS75inUyZKnj+tzcSLYzV5Aw1fXQaWuDBxtacKP1jztH4u277tAUM+edH248Ke4Pj4iPSIKsKNZThaCLt1pEyBmFFsLL+MaEt0G1Y=
Received: from CY5PR15CA0052.namprd15.prod.outlook.com (2603:10b6:930:1b::9)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 07:27:19 +0000
Received: from CY4PEPF0000C96D.namprd02.prod.outlook.com
 (2603:10b6:930:1b:cafe::ff) by CY5PR15CA0052.outlook.office365.com
 (2603:10b6:930:1b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17 via Frontend
 Transport; Wed, 30 Nov 2022 07:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96D.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Wed, 30 Nov 2022 07:27:18 +0000
Received: from ecarx-Majolica-RN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 30 Nov 2022 01:27:14 -0600
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Add vkpreemption for gfx9 mcbp
Date: Wed, 30 Nov 2022 15:26:44 +0800
Message-ID: <20221130072644.8563-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96D:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a2bc91-a505-44d1-04ae-08dad2a4503c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25a1FAiJoq3VJeGLfLEOBqgHRTyB/MOtaSF7fGWuchD+rJ2hHczyT4xAXulDUq4klVsEM0iyauSmihWB0BtiAYJy7i0OSMtievL8j03UfoMo0h/thD4Gise0JmMa3YC8DeUK1eIcqzRJjYqNNO6IKWp4kq7awMr4XEeRG6V+X8z63xI+Xywvs21F1PkN4INb8Erg8l41cRNjy6vw/ynyZY3s355ntKr1oPJKi5Y+K+tm+lCPqxDJwyGj8CXTJn8OvecFVpz+plp4MuV3dWZWoItj7FBdZSOlKS7RhaUnBSy+IMyKzNLbMqtIObo8lUUv//YVfoWnH+zXE5MTI9zTbGIIX/2VJk2lxnuBf3O6aqb1/qNrYdr6tdKYVtWoWP1acUlq05RNHMnbRdMvj5on20DeArPM12v9z/X6zGd0haqpP2Y8u4Hm7zVWucpCSYlLgD2Ws3KaN87K/Nvrrerjo03uRC0vvS/5la62A4Ifm9grCzh+tAWcJ2I6nxYyfQunjLT6Mh+AI4ygsPT3epm5nwiGHgG8zjZSjfysjQS1X67rHpRtYygH43bd/M8p2SQm8AaZmlUXhvB3E4ZGHNQJSozvpxRVgRPHlXpzZFbB/uJzVw0Xv6oU1c23UhsLqE0N7q3tJ2DrSmnVJElSN+eKfhaMCkCFYNpr8DeASNIGbHO/VSNwAf0n9xU75pqrBSaanxb+EB6QgiytmmcuO4jOqT/HjToTYLPS02jW0Tln50ibEHaZp/hpV7fh8SyYldrhgPR37tlDp6iGfUd3KQUMWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(478600001)(316002)(6666004)(7696005)(83380400001)(36860700001)(86362001)(41300700001)(47076005)(6916009)(8936002)(336012)(426003)(30864003)(26005)(66574015)(82740400003)(40460700003)(40480700001)(5660300002)(356005)(2876002)(81166007)(2906002)(2616005)(15974865002)(70586007)(70206006)(8676002)(186003)(1076003)(16526019)(36756003)(82310400005)(4326008)(36900700001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 07:27:18.7677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a2bc91-a505-44d1-04ae-08dad2a4503c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
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
Cc: jiadozhu <jiadong.zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: jiadozhu <jiadong.zhu@amd.com>

This is a standalone test case used for software mcbp on gfx9.
Build and open two consoles to run:
build/bin/vkpreemption s gfx=draws:1000000,priority:high,delay:0
build/bin/vkpreemption c gfx=draws:1000000,priority:low,delay:0

The result is printed on the console of the server side.

Signed-off-by: jiadozhu <jiadong.zhu@amd.com>
---
 vkpreemption/CMakeLists.txt           |  17 +
 vkpreemption/VulkanInitializers.hpp   | 591 ++++++++++++++++++++
 vkpreemption/VulkanTools.cpp          | 361 ++++++++++++
 vkpreemption/VulkanTools.h            | 118 ++++
 vkpreemption/base.hpp                 | 269 +++++++++
 vkpreemption/build_lnx.sh             |  11 +
 vkpreemption/computework.hpp          | 429 ++++++++++++++
 vkpreemption/graphicwork.hpp          | 777 ++++++++++++++++++++++++++
 vkpreemption/headless.comp            |  34 ++
 vkpreemption/headless.comp.inc        |  33 ++
 vkpreemption/main.cpp                 | 385 +++++++++++++
 vkpreemption/triangle.frag            |  10 +
 vkpreemption/triangle.frag.glsl       |  10 +
 vkpreemption/triangle.frag.inc        |  17 +
 vkpreemption/triangle.vert            |  20 +
 vkpreemption/triangle.vert.glsl       |  20 +
 vkpreemption/triangle.vert.inc        |  34 ++
 vkpreemption/vk_amd_dispatch_tunnel.h |  34 ++
 vkpreemption/vk_internal_ext_helper.h |  33 ++
 19 files changed, 3203 insertions(+)
 create mode 100644 vkpreemption/CMakeLists.txt
 create mode 100644 vkpreemption/VulkanInitializers.hpp
 create mode 100644 vkpreemption/VulkanTools.cpp
 create mode 100644 vkpreemption/VulkanTools.h
 create mode 100644 vkpreemption/base.hpp
 create mode 100644 vkpreemption/build_lnx.sh
 create mode 100644 vkpreemption/computework.hpp
 create mode 100644 vkpreemption/graphicwork.hpp
 create mode 100644 vkpreemption/headless.comp
 create mode 100644 vkpreemption/headless.comp.inc
 create mode 100644 vkpreemption/main.cpp
 create mode 100644 vkpreemption/triangle.frag
 create mode 100644 vkpreemption/triangle.frag.glsl
 create mode 100644 vkpreemption/triangle.frag.inc
 create mode 100644 vkpreemption/triangle.vert
 create mode 100644 vkpreemption/triangle.vert.glsl
 create mode 100644 vkpreemption/triangle.vert.inc
 create mode 100644 vkpreemption/vk_amd_dispatch_tunnel.h
 create mode 100644 vkpreemption/vk_internal_ext_helper.h

diff --git a/vkpreemption/CMakeLists.txt b/vkpreemption/CMakeLists.txt
new file mode 100644
index 00000000..0c54ddab
--- /dev/null
+++ b/vkpreemption/CMakeLists.txt
@@ -0,0 +1,17 @@
+cmake_minimum_required(VERSION 2.8 FATAL_ERROR)
+cmake_policy(VERSION 2.8)
+project(vkpreemption)
+
+message("CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME}")
+
+include_directories(glm)
+
+set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/")
+
+file(GLOB EXAMPLE_SRC "*.cpp" "*.hpp")
+add_executable(vkpreemption ${EXAMPLE_SRC})
+
+target_link_libraries(
+    vkpreemption
+    libvulkan.so
+)
diff --git a/vkpreemption/VulkanInitializers.hpp b/vkpreemption/VulkanInitializers.hpp
new file mode 100644
index 00000000..806ab513
--- /dev/null
+++ b/vkpreemption/VulkanInitializers.hpp
@@ -0,0 +1,591 @@
+/*
+* Initializers for Vulkan structures and objects used by the examples
+* Saves lot of VK_STRUCTURE_TYPE assignments
+* Some initializers are parameterized for convenience
+*
+* Copyright (C) 2016 by Sascha Willems - www.saschawillems.de
+*
+* This code is licensed under the MIT license (MIT) (http://opensource.org/licenses/MIT)
+*/
+
+#pragma once
+
+#include <vector>
+#include "vulkan/vulkan.h"
+
+namespace vks
+{
+	namespace initializers
+	{
+
+		inline VkMemoryAllocateInfo memoryAllocateInfo()
+		{
+			VkMemoryAllocateInfo memAllocInfo {};
+			memAllocInfo.sType = VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO;
+			return memAllocInfo;
+		}
+
+		inline VkMappedMemoryRange mappedMemoryRange()
+		{
+			VkMappedMemoryRange mappedMemoryRange {};
+			mappedMemoryRange.sType = VK_STRUCTURE_TYPE_MAPPED_MEMORY_RANGE;
+			return mappedMemoryRange;
+		}
+
+		inline VkCommandBufferAllocateInfo commandBufferAllocateInfo(
+			VkCommandPool commandPool,
+			VkCommandBufferLevel level,
+			uint32_t bufferCount)
+		{
+			VkCommandBufferAllocateInfo commandBufferAllocateInfo {};
+			commandBufferAllocateInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO;
+			commandBufferAllocateInfo.commandPool = commandPool;
+			commandBufferAllocateInfo.level = level;
+			commandBufferAllocateInfo.commandBufferCount = bufferCount;
+			return commandBufferAllocateInfo;
+		}
+
+		inline VkCommandPoolCreateInfo commandPoolCreateInfo()
+		{
+			VkCommandPoolCreateInfo cmdPoolCreateInfo {};
+			cmdPoolCreateInfo.sType = VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO;
+			return cmdPoolCreateInfo;
+		}
+
+		inline VkCommandBufferBeginInfo commandBufferBeginInfo()
+		{
+			VkCommandBufferBeginInfo cmdBufferBeginInfo {};
+			cmdBufferBeginInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
+			return cmdBufferBeginInfo;
+		}
+
+		inline VkCommandBufferInheritanceInfo commandBufferInheritanceInfo()
+		{
+			VkCommandBufferInheritanceInfo cmdBufferInheritanceInfo {};
+			cmdBufferInheritanceInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_INHERITANCE_INFO;
+			return cmdBufferInheritanceInfo;
+		}
+
+		inline VkRenderPassBeginInfo renderPassBeginInfo()
+		{
+			VkRenderPassBeginInfo renderPassBeginInfo {};
+			renderPassBeginInfo.sType = VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO;
+			return renderPassBeginInfo;
+		}
+
+		inline VkRenderPassCreateInfo renderPassCreateInfo()
+		{
+			VkRenderPassCreateInfo renderPassCreateInfo {};
+			renderPassCreateInfo.sType = VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO;
+			return renderPassCreateInfo;
+		}
+
+		/** @brief Initialize an image memory barrier with no image transfer ownership */
+		inline VkImageMemoryBarrier imageMemoryBarrier()
+		{
+			VkImageMemoryBarrier imageMemoryBarrier {};
+			imageMemoryBarrier.sType = VK_STRUCTURE_TYPE_IMAGE_MEMORY_BARRIER;
+			imageMemoryBarrier.srcQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
+			imageMemoryBarrier.dstQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
+			return imageMemoryBarrier;
+		}
+
+		/** @brief Initialize a buffer memory barrier with no image transfer ownership */
+		inline VkBufferMemoryBarrier bufferMemoryBarrier()
+		{
+			VkBufferMemoryBarrier bufferMemoryBarrier {};
+			bufferMemoryBarrier.sType = VK_STRUCTURE_TYPE_BUFFER_MEMORY_BARRIER;
+			bufferMemoryBarrier.srcQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
+			bufferMemoryBarrier.dstQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
+			return bufferMemoryBarrier;
+		}
+
+		inline VkMemoryBarrier memoryBarrier()
+		{
+			VkMemoryBarrier memoryBarrier {};
+			memoryBarrier.sType = VK_STRUCTURE_TYPE_MEMORY_BARRIER;
+			return memoryBarrier;
+		}
+
+		inline VkImageCreateInfo imageCreateInfo()
+		{
+			VkImageCreateInfo imageCreateInfo {};
+			imageCreateInfo.sType = VK_STRUCTURE_TYPE_IMAGE_CREATE_INFO;
+			return imageCreateInfo;
+		}
+
+		inline VkSamplerCreateInfo samplerCreateInfo()
+		{
+			VkSamplerCreateInfo samplerCreateInfo {};
+			samplerCreateInfo.sType = VK_STRUCTURE_TYPE_SAMPLER_CREATE_INFO;
+			samplerCreateInfo.maxAnisotropy = 1.0f;
+			return samplerCreateInfo;
+		}
+
+		inline VkImageViewCreateInfo imageViewCreateInfo()
+		{
+			VkImageViewCreateInfo imageViewCreateInfo {};
+			imageViewCreateInfo.sType = VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO;
+			return imageViewCreateInfo;
+		}
+
+		inline VkFramebufferCreateInfo framebufferCreateInfo()
+		{
+			VkFramebufferCreateInfo framebufferCreateInfo {};
+			framebufferCreateInfo.sType = VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO;
+			return framebufferCreateInfo;
+		}
+
+		inline VkSemaphoreCreateInfo semaphoreCreateInfo()
+		{
+			VkSemaphoreCreateInfo semaphoreCreateInfo {};
+			semaphoreCreateInfo.sType = VK_STRUCTURE_TYPE_SEMAPHORE_CREATE_INFO;
+			return semaphoreCreateInfo;
+		}
+
+		inline VkFenceCreateInfo fenceCreateInfo(VkFenceCreateFlags flags = 0)
+		{
+			VkFenceCreateInfo fenceCreateInfo {};
+			fenceCreateInfo.sType = VK_STRUCTURE_TYPE_FENCE_CREATE_INFO;
+			fenceCreateInfo.flags = flags;
+			return fenceCreateInfo;
+		}
+
+		inline VkEventCreateInfo eventCreateInfo()
+		{
+			VkEventCreateInfo eventCreateInfo {};
+			eventCreateInfo.sType = VK_STRUCTURE_TYPE_EVENT_CREATE_INFO;
+			return eventCreateInfo;
+		}
+
+		inline VkSubmitInfo submitInfo()
+		{
+			VkSubmitInfo submitInfo {};
+			submitInfo.sType = VK_STRUCTURE_TYPE_SUBMIT_INFO;
+			return submitInfo;
+		}
+
+		inline VkViewport viewport(
+			float width,
+			float height,
+			float minDepth,
+			float maxDepth)
+		{
+			VkViewport viewport {};
+			viewport.width = width;
+			viewport.height = height;
+			viewport.minDepth = minDepth;
+			viewport.maxDepth = maxDepth;
+			return viewport;
+		}
+
+		inline VkRect2D rect2D(
+			int32_t width,
+			int32_t height,
+			int32_t offsetX,
+			int32_t offsetY)
+		{
+			VkRect2D rect2D {};
+			rect2D.extent.width = width;
+			rect2D.extent.height = height;
+			rect2D.offset.x = offsetX;
+			rect2D.offset.y = offsetY;
+			return rect2D;
+		}
+
+		inline VkBufferCreateInfo bufferCreateInfo()
+		{
+			VkBufferCreateInfo bufCreateInfo {};
+			bufCreateInfo.sType = VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO;
+			return bufCreateInfo;
+		}
+
+		inline VkBufferCreateInfo bufferCreateInfo(
+			VkBufferUsageFlags usage,
+			VkDeviceSize size)
+		{
+			VkBufferCreateInfo bufCreateInfo {};
+			bufCreateInfo.sType = VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO;
+			bufCreateInfo.usage = usage;
+			bufCreateInfo.size = size;
+			return bufCreateInfo;
+		}
+
+		inline VkDescriptorPoolCreateInfo descriptorPoolCreateInfo(
+			uint32_t poolSizeCount,
+			VkDescriptorPoolSize* pPoolSizes,
+			uint32_t maxSets)
+		{
+			VkDescriptorPoolCreateInfo descriptorPoolInfo {};
+			descriptorPoolInfo.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO;
+			descriptorPoolInfo.poolSizeCount = poolSizeCount;
+			descriptorPoolInfo.pPoolSizes = pPoolSizes;
+			descriptorPoolInfo.maxSets = maxSets;
+			return descriptorPoolInfo;
+		}
+
+		inline VkDescriptorPoolCreateInfo descriptorPoolCreateInfo(
+			const std::vector<VkDescriptorPoolSize>& poolSizes,
+			uint32_t maxSets)
+		{
+			VkDescriptorPoolCreateInfo descriptorPoolInfo{};
+			descriptorPoolInfo.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO;
+			descriptorPoolInfo.poolSizeCount = static_cast<uint32_t>(poolSizes.size());
+			descriptorPoolInfo.pPoolSizes = poolSizes.data();
+			descriptorPoolInfo.maxSets = maxSets;
+			return descriptorPoolInfo;
+		}
+
+		inline VkDescriptorPoolSize descriptorPoolSize(
+			VkDescriptorType type,
+			uint32_t descriptorCount)
+		{
+			VkDescriptorPoolSize descriptorPoolSize {};
+			descriptorPoolSize.type = type;
+			descriptorPoolSize.descriptorCount = descriptorCount;
+			return descriptorPoolSize;
+		}
+
+		inline VkDescriptorSetLayoutBinding descriptorSetLayoutBinding(
+			VkDescriptorType type,
+			VkShaderStageFlags stageFlags,
+			uint32_t binding,
+			uint32_t descriptorCount = 1)
+		{
+			VkDescriptorSetLayoutBinding setLayoutBinding {};
+			setLayoutBinding.descriptorType = type;
+			setLayoutBinding.stageFlags = stageFlags;
+			setLayoutBinding.binding = binding;
+			setLayoutBinding.descriptorCount = descriptorCount;
+			return setLayoutBinding;
+		}
+
+		inline VkDescriptorSetLayoutCreateInfo descriptorSetLayoutCreateInfo(
+			const VkDescriptorSetLayoutBinding* pBindings,
+			uint32_t bindingCount)
+		{
+			VkDescriptorSetLayoutCreateInfo descriptorSetLayoutCreateInfo {};
+			descriptorSetLayoutCreateInfo.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_SET_LAYOUT_CREATE_INFO;
+			descriptorSetLayoutCreateInfo.pBindings = pBindings;
+			descriptorSetLayoutCreateInfo.bindingCount = bindingCount;
+			return descriptorSetLayoutCreateInfo;
+		}
+
+		inline VkDescriptorSetLayoutCreateInfo descriptorSetLayoutCreateInfo(
+			const std::vector<VkDescriptorSetLayoutBinding>& bindings)
+		{
+			VkDescriptorSetLayoutCreateInfo descriptorSetLayoutCreateInfo{};
+			descriptorSetLayoutCreateInfo.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_SET_LAYOUT_CREATE_INFO;
+			descriptorSetLayoutCreateInfo.pBindings = bindings.data();
+			descriptorSetLayoutCreateInfo.bindingCount = static_cast<uint32_t>(bindings.size());
+			return descriptorSetLayoutCreateInfo;
+		}
+
+		inline VkPipelineLayoutCreateInfo pipelineLayoutCreateInfo(
+			const VkDescriptorSetLayout* pSetLayouts,
+			uint32_t setLayoutCount = 1)
+		{
+			VkPipelineLayoutCreateInfo pipelineLayoutCreateInfo {};
+			pipelineLayoutCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO;
+			pipelineLayoutCreateInfo.setLayoutCount = setLayoutCount;
+			pipelineLayoutCreateInfo.pSetLayouts = pSetLayouts;
+			return pipelineLayoutCreateInfo;
+		}
+
+		inline VkPipelineLayoutCreateInfo pipelineLayoutCreateInfo(
+			uint32_t setLayoutCount = 1)
+		{
+			VkPipelineLayoutCreateInfo pipelineLayoutCreateInfo{};
+			pipelineLayoutCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO;
+			pipelineLayoutCreateInfo.setLayoutCount = setLayoutCount;
+			return pipelineLayoutCreateInfo;
+		}
+
+		inline VkDescriptorSetAllocateInfo descriptorSetAllocateInfo(
+			VkDescriptorPool descriptorPool,
+			const VkDescriptorSetLayout* pSetLayouts,
+			uint32_t descriptorSetCount)
+		{
+			VkDescriptorSetAllocateInfo descriptorSetAllocateInfo {};
+			descriptorSetAllocateInfo.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO;
+			descriptorSetAllocateInfo.descriptorPool = descriptorPool;
+			descriptorSetAllocateInfo.pSetLayouts = pSetLayouts;
+			descriptorSetAllocateInfo.descriptorSetCount = descriptorSetCount;
+			return descriptorSetAllocateInfo;
+		}
+
+		inline VkDescriptorImageInfo descriptorImageInfo(VkSampler sampler, VkImageView imageView, VkImageLayout imageLayout)
+		{
+			VkDescriptorImageInfo descriptorImageInfo {};
+			descriptorImageInfo.sampler = sampler;
+			descriptorImageInfo.imageView = imageView;
+			descriptorImageInfo.imageLayout = imageLayout;
+			return descriptorImageInfo;
+		}
+
+		inline VkWriteDescriptorSet writeDescriptorSet(
+			VkDescriptorSet dstSet,
+			VkDescriptorType type,
+			uint32_t binding,
+			VkDescriptorBufferInfo* bufferInfo,
+			uint32_t descriptorCount = 1)
+		{
+			VkWriteDescriptorSet writeDescriptorSet {};
+			writeDescriptorSet.sType = VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET;
+			writeDescriptorSet.dstSet = dstSet;
+			writeDescriptorSet.descriptorType = type;
+			writeDescriptorSet.dstBinding = binding;
+			writeDescriptorSet.pBufferInfo = bufferInfo;
+			writeDescriptorSet.descriptorCount = descriptorCount;
+			return writeDescriptorSet;
+		}
+
+		inline VkWriteDescriptorSet writeDescriptorSet(
+			VkDescriptorSet dstSet,
+			VkDescriptorType type,
+			uint32_t binding,
+			VkDescriptorImageInfo *imageInfo,
+			uint32_t descriptorCount = 1)
+		{
+			VkWriteDescriptorSet writeDescriptorSet {};
+			writeDescriptorSet.sType = VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET;
+			writeDescriptorSet.dstSet = dstSet;
+			writeDescriptorSet.descriptorType = type;
+			writeDescriptorSet.dstBinding = binding;
+			writeDescriptorSet.pImageInfo = imageInfo;
+			writeDescriptorSet.descriptorCount = descriptorCount;
+			return writeDescriptorSet;
+		}
+
+		inline VkVertexInputBindingDescription vertexInputBindingDescription(
+			uint32_t binding,
+			uint32_t stride,
+			VkVertexInputRate inputRate)
+		{
+			VkVertexInputBindingDescription vInputBindDescription {};
+			vInputBindDescription.binding = binding;
+			vInputBindDescription.stride = stride;
+			vInputBindDescription.inputRate = inputRate;
+			return vInputBindDescription;
+		}
+
+		inline VkVertexInputAttributeDescription vertexInputAttributeDescription(
+			uint32_t binding,
+			uint32_t location,
+			VkFormat format,
+			uint32_t offset)
+		{
+			VkVertexInputAttributeDescription vInputAttribDescription {};
+			vInputAttribDescription.location = location;
+			vInputAttribDescription.binding = binding;
+			vInputAttribDescription.format = format;
+			vInputAttribDescription.offset = offset;
+			return vInputAttribDescription;
+		}
+
+		inline VkPipelineVertexInputStateCreateInfo pipelineVertexInputStateCreateInfo()
+		{
+			VkPipelineVertexInputStateCreateInfo pipelineVertexInputStateCreateInfo {};
+			pipelineVertexInputStateCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO;
+			return pipelineVertexInputStateCreateInfo;
+		}
+
+		inline VkPipelineInputAssemblyStateCreateInfo pipelineInputAssemblyStateCreateInfo(
+			VkPrimitiveTopology topology,
+			VkPipelineInputAssemblyStateCreateFlags flags,
+			VkBool32 primitiveRestartEnable)
+		{
+			VkPipelineInputAssemblyStateCreateInfo pipelineInputAssemblyStateCreateInfo {};
+			pipelineInputAssemblyStateCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_INPUT_ASSEMBLY_STATE_CREATE_INFO;
+			pipelineInputAssemblyStateCreateInfo.topology = topology;
+			pipelineInputAssemblyStateCreateInfo.flags = flags;
+			pipelineInputAssemblyStateCreateInfo.primitiveRestartEnable = primitiveRestartEnable;
+			return pipelineInputAssemblyStateCreateInfo;
+		}
+
+		inline VkPipelineRasterizationStateCreateInfo pipelineRasterizationStateCreateInfo(
+			VkPolygonMode polygonMode,
+			VkCullModeFlags cullMode,
+			VkFrontFace frontFace,
+			VkPipelineRasterizationStateCreateFlags flags = 0)
+		{
+			VkPipelineRasterizationStateCreateInfo pipelineRasterizationStateCreateInfo {};
+			pipelineRasterizationStateCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_CREATE_INFO;
+			pipelineRasterizationStateCreateInfo.polygonMode = polygonMode;
+			pipelineRasterizationStateCreateInfo.cullMode = cullMode;
+			pipelineRasterizationStateCreateInfo.frontFace = frontFace;
+			pipelineRasterizationStateCreateInfo.flags = flags;
+			pipelineRasterizationStateCreateInfo.depthClampEnable = VK_FALSE;
+			pipelineRasterizationStateCreateInfo.lineWidth = 1.0f;
+			return pipelineRasterizationStateCreateInfo;
+		}
+
+		inline VkPipelineColorBlendAttachmentState pipelineColorBlendAttachmentState(
+			VkColorComponentFlags colorWriteMask,
+			VkBool32 blendEnable)
+		{
+			VkPipelineColorBlendAttachmentState pipelineColorBlendAttachmentState {};
+			pipelineColorBlendAttachmentState.colorWriteMask = colorWriteMask;
+			pipelineColorBlendAttachmentState.blendEnable = blendEnable;
+			return pipelineColorBlendAttachmentState;
+		}
+
+		inline VkPipelineColorBlendStateCreateInfo pipelineColorBlendStateCreateInfo(
+			uint32_t attachmentCount,
+			const VkPipelineColorBlendAttachmentState * pAttachments)
+		{
+			VkPipelineColorBlendStateCreateInfo pipelineColorBlendStateCreateInfo {};
+			pipelineColorBlendStateCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_COLOR_BLEND_STATE_CREATE_INFO;
+			pipelineColorBlendStateCreateInfo.attachmentCount = attachmentCount;
+			pipelineColorBlendStateCreateInfo.pAttachments = pAttachments;
+			return pipelineColorBlendStateCreateInfo;
+		}
+
+		inline VkPipelineDepthStencilStateCreateInfo pipelineDepthStencilStateCreateInfo(
+			VkBool32 depthTestEnable,
+			VkBool32 depthWriteEnable,
+			VkCompareOp depthCompareOp)
+		{
+			VkPipelineDepthStencilStateCreateInfo pipelineDepthStencilStateCreateInfo {};
+			pipelineDepthStencilStateCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_DEPTH_STENCIL_STATE_CREATE_INFO;
+			pipelineDepthStencilStateCreateInfo.depthTestEnable = depthTestEnable;
+			pipelineDepthStencilStateCreateInfo.depthWriteEnable = depthWriteEnable;
+			pipelineDepthStencilStateCreateInfo.depthCompareOp = depthCompareOp;
+			pipelineDepthStencilStateCreateInfo.front = pipelineDepthStencilStateCreateInfo.back;
+			pipelineDepthStencilStateCreateInfo.back.compareOp = VK_COMPARE_OP_ALWAYS;
+			return pipelineDepthStencilStateCreateInfo;
+		}
+
+		inline VkPipelineViewportStateCreateInfo pipelineViewportStateCreateInfo(
+			uint32_t viewportCount,
+			uint32_t scissorCount,
+			VkPipelineViewportStateCreateFlags flags = 0)
+		{
+			VkPipelineViewportStateCreateInfo pipelineViewportStateCreateInfo {};
+			pipelineViewportStateCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_VIEWPORT_STATE_CREATE_INFO;
+			pipelineViewportStateCreateInfo.viewportCount = viewportCount;
+			pipelineViewportStateCreateInfo.scissorCount = scissorCount;
+			pipelineViewportStateCreateInfo.flags = flags;
+			return pipelineViewportStateCreateInfo;
+		}
+
+		inline VkPipelineMultisampleStateCreateInfo pipelineMultisampleStateCreateInfo(
+			VkSampleCountFlagBits rasterizationSamples,
+			VkPipelineMultisampleStateCreateFlags flags = 0)
+		{
+			VkPipelineMultisampleStateCreateInfo pipelineMultisampleStateCreateInfo {};
+			pipelineMultisampleStateCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_MULTISAMPLE_STATE_CREATE_INFO;
+			pipelineMultisampleStateCreateInfo.rasterizationSamples = rasterizationSamples;
+			pipelineMultisampleStateCreateInfo.flags = flags;
+			return pipelineMultisampleStateCreateInfo;
+		}
+
+		inline VkPipelineDynamicStateCreateInfo pipelineDynamicStateCreateInfo(
+			const VkDynamicState * pDynamicStates,
+			uint32_t dynamicStateCount,
+			VkPipelineDynamicStateCreateFlags flags = 0)
+		{
+			VkPipelineDynamicStateCreateInfo pipelineDynamicStateCreateInfo {};
+			pipelineDynamicStateCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_DYNAMIC_STATE_CREATE_INFO;
+			pipelineDynamicStateCreateInfo.pDynamicStates = pDynamicStates;
+			pipelineDynamicStateCreateInfo.dynamicStateCount = dynamicStateCount;
+			pipelineDynamicStateCreateInfo.flags = flags;
+			return pipelineDynamicStateCreateInfo;
+		}
+
+		inline VkPipelineDynamicStateCreateInfo pipelineDynamicStateCreateInfo(
+			const std::vector<VkDynamicState>& pDynamicStates,
+			VkPipelineDynamicStateCreateFlags flags = 0)
+		{
+			VkPipelineDynamicStateCreateInfo pipelineDynamicStateCreateInfo{};
+			pipelineDynamicStateCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_DYNAMIC_STATE_CREATE_INFO;
+			pipelineDynamicStateCreateInfo.pDynamicStates = pDynamicStates.data();
+			pipelineDynamicStateCreateInfo.dynamicStateCount = static_cast<uint32_t>(pDynamicStates.size());
+			pipelineDynamicStateCreateInfo.flags = flags;
+			return pipelineDynamicStateCreateInfo;
+		}
+
+		inline VkPipelineTessellationStateCreateInfo pipelineTessellationStateCreateInfo(uint32_t patchControlPoints)
+		{
+			VkPipelineTessellationStateCreateInfo pipelineTessellationStateCreateInfo {};
+			pipelineTessellationStateCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_TESSELLATION_STATE_CREATE_INFO;
+			pipelineTessellationStateCreateInfo.patchControlPoints = patchControlPoints;
+			return pipelineTessellationStateCreateInfo;
+		}
+
+		inline VkGraphicsPipelineCreateInfo pipelineCreateInfo(
+			VkPipelineLayout layout,
+			VkRenderPass renderPass,
+			VkPipelineCreateFlags flags = 0)
+		{
+			VkGraphicsPipelineCreateInfo pipelineCreateInfo {};
+			pipelineCreateInfo.sType = VK_STRUCTURE_TYPE_GRAPHICS_PIPELINE_CREATE_INFO;
+			pipelineCreateInfo.layout = layout;
+			pipelineCreateInfo.renderPass = renderPass;
+			pipelineCreateInfo.flags = flags;
+			pipelineCreateInfo.basePipelineIndex = -1;
+			pipelineCreateInfo.basePipelineHandle = VK_NULL_HANDLE;
+			return pipelineCreateInfo;
+		}
+
+		inline VkGraphicsPipelineCreateInfo pipelineCreateInfo()
+		{
+			VkGraphicsPipelineCreateInfo pipelineCreateInfo{};
+			pipelineCreateInfo.sType = VK_STRUCTURE_TYPE_GRAPHICS_PIPELINE_CREATE_INFO;
+			pipelineCreateInfo.basePipelineIndex = -1;
+			pipelineCreateInfo.basePipelineHandle = VK_NULL_HANDLE;
+			return pipelineCreateInfo;
+		}
+
+		inline VkComputePipelineCreateInfo computePipelineCreateInfo(
+			VkPipelineLayout layout,
+			VkPipelineCreateFlags flags = 0)
+		{
+			VkComputePipelineCreateInfo computePipelineCreateInfo {};
+			computePipelineCreateInfo.sType = VK_STRUCTURE_TYPE_COMPUTE_PIPELINE_CREATE_INFO;
+			computePipelineCreateInfo.layout = layout;
+			computePipelineCreateInfo.flags = flags;
+			return computePipelineCreateInfo;
+		}
+
+		inline VkPushConstantRange pushConstantRange(
+			VkShaderStageFlags stageFlags,
+			uint32_t size,
+			uint32_t offset)
+		{
+			VkPushConstantRange pushConstantRange {};
+			pushConstantRange.stageFlags = stageFlags;
+			pushConstantRange.offset = offset;
+			pushConstantRange.size = size;
+			return pushConstantRange;
+		}
+
+		inline VkBindSparseInfo bindSparseInfo()
+		{
+			VkBindSparseInfo bindSparseInfo{};
+			bindSparseInfo.sType = VK_STRUCTURE_TYPE_BIND_SPARSE_INFO;
+			return bindSparseInfo;
+		}
+
+		/** @brief Initialize a map entry for a shader specialization constant */
+		inline VkSpecializationMapEntry specializationMapEntry(uint32_t constantID, uint32_t offset, size_t size)
+		{
+			VkSpecializationMapEntry specializationMapEntry{};
+			specializationMapEntry.constantID = constantID;
+			specializationMapEntry.offset = offset;
+			specializationMapEntry.size = size;
+			return specializationMapEntry;
+		}
+
+		/** @brief Initialize a specialization constant info structure to pass to a shader stage */
+		inline VkSpecializationInfo specializationInfo(uint32_t mapEntryCount, const VkSpecializationMapEntry* mapEntries, size_t dataSize, const void* data)
+		{
+			VkSpecializationInfo specializationInfo{};
+			specializationInfo.mapEntryCount = mapEntryCount;
+			specializationInfo.pMapEntries = mapEntries;
+			specializationInfo.dataSize = dataSize;
+			specializationInfo.pData = data;
+			return specializationInfo;
+		}
+	}
+}
\ No newline at end of file
diff --git a/vkpreemption/VulkanTools.cpp b/vkpreemption/VulkanTools.cpp
new file mode 100644
index 00000000..e7fcac56
--- /dev/null
+++ b/vkpreemption/VulkanTools.cpp
@@ -0,0 +1,361 @@
+/*
+* Assorted commonly used Vulkan helper functions
+*
+* Copyright (C) 2016 by Sascha Willems - www.saschawillems.de
+*
+* This code is licensed under the MIT license (MIT) (http://opensource.org/licenses/MIT)
+*/
+
+#include "VulkanTools.h"
+
+namespace vks
+{
+	namespace tools
+	{
+		bool errorModeSilent = false;
+
+		std::string errorString(VkResult errorCode)
+		{
+			switch (errorCode)
+			{
+#define STR(r) case VK_ ##r: return #r
+				STR(NOT_READY);
+				STR(TIMEOUT);
+				STR(EVENT_SET);
+				STR(EVENT_RESET);
+				STR(INCOMPLETE);
+				STR(ERROR_OUT_OF_HOST_MEMORY);
+				STR(ERROR_OUT_OF_DEVICE_MEMORY);
+				STR(ERROR_INITIALIZATION_FAILED);
+				STR(ERROR_DEVICE_LOST);
+				STR(ERROR_MEMORY_MAP_FAILED);
+				STR(ERROR_LAYER_NOT_PRESENT);
+				STR(ERROR_EXTENSION_NOT_PRESENT);
+				STR(ERROR_FEATURE_NOT_PRESENT);
+				STR(ERROR_INCOMPATIBLE_DRIVER);
+				STR(ERROR_TOO_MANY_OBJECTS);
+				STR(ERROR_FORMAT_NOT_SUPPORTED);
+				STR(ERROR_SURFACE_LOST_KHR);
+				STR(ERROR_NATIVE_WINDOW_IN_USE_KHR);
+				STR(SUBOPTIMAL_KHR);
+				STR(ERROR_OUT_OF_DATE_KHR);
+				STR(ERROR_INCOMPATIBLE_DISPLAY_KHR);
+				STR(ERROR_VALIDATION_FAILED_EXT);
+				STR(ERROR_INVALID_SHADER_NV);
+#undef STR
+			default:
+				return "UNKNOWN_ERROR";
+			}
+		}
+
+		std::string physicalDeviceTypeString(VkPhysicalDeviceType type)
+		{
+			switch (type)
+			{
+#define STR(r) case VK_PHYSICAL_DEVICE_TYPE_ ##r: return #r
+				STR(OTHER);
+				STR(INTEGRATED_GPU);
+				STR(DISCRETE_GPU);
+				STR(VIRTUAL_GPU);
+#undef STR
+			default: return "UNKNOWN_DEVICE_TYPE";
+			}
+		}
+
+		VkBool32 getSupportedDepthFormat(VkPhysicalDevice physicalDevice, VkFormat *depthFormat)
+		{
+			// Since all depth formats may be optional, we need to find a suitable depth format to use
+			// Start with the highest precision packed format
+			std::vector<VkFormat> depthFormats = {
+				VK_FORMAT_D32_SFLOAT_S8_UINT,
+				VK_FORMAT_D32_SFLOAT,
+				VK_FORMAT_D24_UNORM_S8_UINT,
+				VK_FORMAT_D16_UNORM_S8_UINT,
+				VK_FORMAT_D16_UNORM
+			};
+
+			for (auto& format : depthFormats)
+			{
+				VkFormatProperties formatProps;
+				vkGetPhysicalDeviceFormatProperties(physicalDevice, format, &formatProps);
+				// Format must support depth stencil attachment for optimal tiling
+				if (formatProps.optimalTilingFeatures & VK_FORMAT_FEATURE_DEPTH_STENCIL_ATTACHMENT_BIT)
+				{
+					*depthFormat = format;
+					return true;
+				}
+			}
+
+			return false;
+		}
+
+		// Create an image memory barrier for changing the layout of
+		// an image and put it into an active command buffer
+		// See chapter 11.4 "Image Layout" for details
+
+		void setImageLayout(
+			VkCommandBuffer cmdbuffer,
+			VkImage image,
+			VkImageLayout oldImageLayout,
+			VkImageLayout newImageLayout,
+			VkImageSubresourceRange subresourceRange,
+			VkPipelineStageFlags srcStageMask,
+			VkPipelineStageFlags dstStageMask)
+		{
+			// Create an image barrier object
+			VkImageMemoryBarrier imageMemoryBarrier = vks::initializers::imageMemoryBarrier();
+			imageMemoryBarrier.oldLayout = oldImageLayout;
+			imageMemoryBarrier.newLayout = newImageLayout;
+			imageMemoryBarrier.image = image;
+			imageMemoryBarrier.subresourceRange = subresourceRange;
+
+			// Source layouts (old)
+			// Source access mask controls actions that have to be finished on the old layout
+			// before it will be transitioned to the new layout
+			switch (oldImageLayout)
+			{
+			case VK_IMAGE_LAYOUT_UNDEFINED:
+				// Image layout is undefined (or does not matter)
+				// Only valid as initial layout
+				// No flags required, listed only for completeness
+				imageMemoryBarrier.srcAccessMask = 0;
+				break;
+
+			case VK_IMAGE_LAYOUT_PREINITIALIZED:
+				// Image is preinitialized
+				// Only valid as initial layout for linear images, preserves memory contents
+				// Make sure host writes have been finished
+				imageMemoryBarrier.srcAccessMask = VK_ACCESS_HOST_WRITE_BIT;
+				break;
+
+			case VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL:
+				// Image is a color attachment
+				// Make sure any writes to the color buffer have been finished
+				imageMemoryBarrier.srcAccessMask = VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT;
+				break;
+
+			case VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL:
+				// Image is a depth/stencil attachment
+				// Make sure any writes to the depth/stencil buffer have been finished
+				imageMemoryBarrier.srcAccessMask = VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_WRITE_BIT;
+				break;
+
+			case VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL:
+				// Image is a transfer source
+				// Make sure any reads from the image have been finished
+				imageMemoryBarrier.srcAccessMask = VK_ACCESS_TRANSFER_READ_BIT;
+				break;
+
+			case VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL:
+				// Image is a transfer destination
+				// Make sure any writes to the image have been finished
+				imageMemoryBarrier.srcAccessMask = VK_ACCESS_TRANSFER_WRITE_BIT;
+				break;
+
+			case VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL:
+				// Image is read by a shader
+				// Make sure any shader reads from the image have been finished
+				imageMemoryBarrier.srcAccessMask = VK_ACCESS_SHADER_READ_BIT;
+				break;
+			default:
+				// Other source layouts aren't handled (yet)
+				break;
+			}
+
+			// Target layouts (new)
+			// Destination access mask controls the dependency for the new image layout
+			switch (newImageLayout)
+			{
+			case VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL:
+				// Image will be used as a transfer destination
+				// Make sure any writes to the image have been finished
+				imageMemoryBarrier.dstAccessMask = VK_ACCESS_TRANSFER_WRITE_BIT;
+				break;
+
+			case VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL:
+				// Image will be used as a transfer source
+				// Make sure any reads from the image have been finished
+				imageMemoryBarrier.dstAccessMask = VK_ACCESS_TRANSFER_READ_BIT;
+				break;
+
+			case VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL:
+				// Image will be used as a color attachment
+				// Make sure any writes to the color buffer have been finished
+				imageMemoryBarrier.dstAccessMask = VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT;
+				break;
+
+			case VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL:
+				// Image layout will be used as a depth/stencil attachment
+				// Make sure any writes to depth/stencil buffer have been finished
+				imageMemoryBarrier.dstAccessMask = imageMemoryBarrier.dstAccessMask | VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_WRITE_BIT;
+				break;
+
+			case VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL:
+				// Image will be read in a shader (sampler, input attachment)
+				// Make sure any writes to the image have been finished
+				if (imageMemoryBarrier.srcAccessMask == 0)
+				{
+					imageMemoryBarrier.srcAccessMask = VK_ACCESS_HOST_WRITE_BIT | VK_ACCESS_TRANSFER_WRITE_BIT;
+				}
+				imageMemoryBarrier.dstAccessMask = VK_ACCESS_SHADER_READ_BIT;
+				break;
+			default:
+				// Other source layouts aren't handled (yet)
+				break;
+			}
+
+			// Put barrier inside setup command buffer
+			vkCmdPipelineBarrier(
+				cmdbuffer,
+				srcStageMask,
+				dstStageMask,
+				0,
+				0, nullptr,
+				0, nullptr,
+				1, &imageMemoryBarrier);
+		}
+
+		// Fixed sub resource on first mip level and layer
+		void setImageLayout(
+			VkCommandBuffer cmdbuffer,
+			VkImage image,
+			VkImageAspectFlags aspectMask,
+			VkImageLayout oldImageLayout,
+			VkImageLayout newImageLayout,
+			VkPipelineStageFlags srcStageMask,
+			VkPipelineStageFlags dstStageMask)
+		{
+			VkImageSubresourceRange subresourceRange = {};
+			subresourceRange.aspectMask = aspectMask;
+			subresourceRange.baseMipLevel = 0;
+			subresourceRange.levelCount = 1;
+			subresourceRange.layerCount = 1;
+			setImageLayout(cmdbuffer, image, oldImageLayout, newImageLayout, subresourceRange, srcStageMask, dstStageMask);
+		}
+
+		void insertImageMemoryBarrier(
+			VkCommandBuffer cmdbuffer,
+			VkImage image,
+			VkAccessFlags srcAccessMask,
+			VkAccessFlags dstAccessMask,
+			VkImageLayout oldImageLayout,
+			VkImageLayout newImageLayout,
+			VkPipelineStageFlags srcStageMask,
+			VkPipelineStageFlags dstStageMask,
+			VkImageSubresourceRange subresourceRange)
+		{
+			VkImageMemoryBarrier imageMemoryBarrier = vks::initializers::imageMemoryBarrier();
+			imageMemoryBarrier.srcAccessMask = srcAccessMask;
+			imageMemoryBarrier.dstAccessMask = dstAccessMask;
+			imageMemoryBarrier.oldLayout = oldImageLayout;
+			imageMemoryBarrier.newLayout = newImageLayout;
+			imageMemoryBarrier.image = image;
+			imageMemoryBarrier.subresourceRange = subresourceRange;
+
+			vkCmdPipelineBarrier(
+				cmdbuffer,
+				srcStageMask,
+				dstStageMask,
+				0,
+				0, nullptr,
+				0, nullptr,
+				1, &imageMemoryBarrier);
+		}
+
+		void exitFatal(std::string message, int32_t exitCode)
+		{
+#if defined(_WIN32)
+			if (!errorModeSilent) {
+				MessageBox(NULL, message.c_str(), NULL, MB_OK | MB_ICONERROR);
+			}
+#elif defined(__ANDROID__)
+            LOGE("Fatal error: %s", message.c_str());
+			vks::android::showAlert(message.c_str());
+#endif
+			std::cerr << message << "\n";
+#if !defined(__ANDROID__)
+			exit(exitCode);
+#endif
+		}
+
+		void exitFatal(std::string message, VkResult resultCode)
+		{
+			exitFatal(message, (int32_t)resultCode);
+		}
+
+		std::string readTextFile(const char *fileName)
+		{
+			std::string fileContent;
+			std::ifstream fileStream(fileName, std::ios::in);
+			if (!fileStream.is_open()) {
+				printf("File %s not found\n", fileName);
+				return "";
+			}
+			std::string line = "";
+			while (!fileStream.eof()) {
+				getline(fileStream, line);
+				fileContent.append(line + "\n");
+			}
+			fileStream.close();
+			return fileContent;
+		}
+
+#if 1
+		// Android shaders are stored as assets in the apk
+		// So they need to be loaded via the asset manager
+		VkShaderModule loadShader(size_t size, const uint32_t* code, VkDevice device)
+		{
+			VkShaderModule shaderModule;
+			VkShaderModuleCreateInfo moduleCreateInfo;
+			moduleCreateInfo.sType = VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO;
+			moduleCreateInfo.pNext = NULL;
+			moduleCreateInfo.codeSize = size;
+			moduleCreateInfo.pCode = code;
+			moduleCreateInfo.flags = 0;
+
+			VK_CHECK_RESULT(vkCreateShaderModule(device, &moduleCreateInfo, NULL, &shaderModule));
+
+			return shaderModule;
+		}
+#else
+		VkShaderModule loadShader(const char *fileName, VkDevice device)
+		{
+			std::ifstream is(fileName, std::ios::binary | std::ios::in | std::ios::ate);
+
+			if (is.is_open())
+			{
+				size_t size = is.tellg();
+				is.seekg(0, std::ios::beg);
+				char* shaderCode = new char[size];
+				is.read(shaderCode, size);
+				is.close();
+
+				assert(size > 0);
+
+				VkShaderModule shaderModule;
+				VkShaderModuleCreateInfo moduleCreateInfo{};
+				moduleCreateInfo.sType = VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO;
+				moduleCreateInfo.codeSize = size;
+				moduleCreateInfo.pCode = (uint32_t*)shaderCode;
+
+				VK_CHECK_RESULT(vkCreateShaderModule(device, &moduleCreateInfo, NULL, &shaderModule));
+
+				delete[] shaderCode;
+
+				return shaderModule;
+			}
+			else
+			{
+				std::cerr << "Error: Could not open shader file \"" << fileName << "\"" << std::endl;
+				return VK_NULL_HANDLE;
+			}
+		}
+#endif
+
+		bool fileExists(const std::string &filename)
+		{
+			std::ifstream f(filename.c_str());
+			return !f.fail();
+		}
+	}
+}
\ No newline at end of file
diff --git a/vkpreemption/VulkanTools.h b/vkpreemption/VulkanTools.h
new file mode 100644
index 00000000..02b7bbf6
--- /dev/null
+++ b/vkpreemption/VulkanTools.h
@@ -0,0 +1,118 @@
+/*
+ * Assorted Vulkan helper functions
+ *
+ * Copyright (C) 2016 by Sascha Willems - www.saschawillems.de
+ *
+ * This code is licensed under the MIT license (MIT) (http://opensource.org/licenses/MIT)
+ */
+
+#pragma once
+
+#include "vulkan/vulkan.h"
+#include "VulkanInitializers.hpp"
+
+#include <math.h>
+#include <stdlib.h>
+#include <string>
+#include <cstring>
+#include <fstream>
+#include <assert.h>
+#include <stdio.h>
+#include <vector>
+#include <iostream>
+#include <stdexcept>
+#include <fstream>
+
+// Custom define for better code readability
+#define VK_FLAGS_NONE 0
+// Default fence timeout in nanoseconds
+#define DEFAULT_FENCE_TIMEOUT 100000000000
+
+// Macro to check and display Vulkan return results
+#define VK_CHECK_RESULT(f) \
+{ \
+	VkResult res = (f); \
+	if (res != VK_SUCCESS) { \
+		std::cout << "Fatal : VkResult is \"" << \
+		vks::tools::errorString(res) << "\" in " << __FILE__ << \
+		" at line " << __LINE__ << std::endl; \
+		assert(res == VK_SUCCESS); \
+	} \
+}
+
+#if defined(__ANDROID__)
+#define ASSET_PATH ""
+#else
+#define ASSET_PATH "./../data/"
+#endif
+
+namespace vks
+{
+	namespace tools
+	{
+		/** @brief Disable message boxes on fatal errors */
+		extern bool errorModeSilent;
+
+		/** @brief Returns an error code as a string */
+		std::string errorString(VkResult errorCode);
+
+		/** @brief Returns the device type as a string */
+		std::string physicalDeviceTypeString(
+			VkPhysicalDeviceType type);
+
+		// Selected a suitable supported depth format starting with 32
+		// bit down to 16 bit. Returns false if none of the depth
+		// formats in the list is supported by the device.
+		VkBool32 getSupportedDepthFormat(
+			VkPhysicalDevice physicalDevice,
+			VkFormat *depthFormat);
+
+		// Put an image memory barrier for setting an image layout on
+		// the sub resource into the given command buffer
+		void setImageLayout(
+			VkCommandBuffer cmdbuffer,
+			VkImage image,
+			VkImageLayout oldImageLayout,
+			VkImageLayout newImageLayout,
+			VkImageSubresourceRange subresourceRange,
+			VkPipelineStageFlags srcStageMask =
+				VK_PIPELINE_STAGE_ALL_COMMANDS_BIT,
+			VkPipelineStageFlags dstStageMask =
+				VK_PIPELINE_STAGE_ALL_COMMANDS_BIT);
+		// Uses a fixed sub resource layout with first mip level and
+		// layer
+		void setImageLayout(
+			VkCommandBuffer cmdbuffer,
+			VkImage image,
+			VkImageAspectFlags aspectMask,
+			VkImageLayout oldImageLayout,
+			VkImageLayout newImageLayout,
+			VkPipelineStageFlags srcStageMask =
+				VK_PIPELINE_STAGE_ALL_COMMANDS_BIT,
+			VkPipelineStageFlags dstStageMask =
+				VK_PIPELINE_STAGE_ALL_COMMANDS_BIT);
+
+		// brief Inser an image memory barrier into the command buffer
+		void insertImageMemoryBarrier(
+			VkCommandBuffer cmdbuffer,
+			VkImage image,
+			VkAccessFlags srcAccessMask,
+			VkAccessFlags dstAccessMask,
+			VkImageLayout oldImageLayout,
+			VkImageLayout newImageLayout,
+			VkPipelineStageFlags srcStageMask,
+			VkPipelineStageFlags dstStageMask,
+			VkImageSubresourceRange subresourceRange);
+
+		// Display error message and exit on fatal error
+		void exitFatal(std::string message, int32_t exitCode);
+		void exitFatal(std::string message, VkResult resultCode);
+
+		// Load a SPIR-V shader (binary)
+		VkShaderModule loadShader(size_t size, const uint32_t *code,
+					  VkDevice device);
+
+		/** @brief Checks if a file exists */
+		bool fileExists(const std::string & filename);
+	}
+}
diff --git a/vkpreemption/base.hpp b/vkpreemption/base.hpp
new file mode 100644
index 00000000..4c3e9edc
--- /dev/null
+++ b/vkpreemption/base.hpp
@@ -0,0 +1,269 @@
+/*
+ * *
+ * * Copyright (C) 2020 Samsung Electronics
+ * *
+ * */
+
+#pragma once
+
+#include <vulkan/vulkan.h>
+#include "VulkanTools.h"
+
+#include <map>
+#include <set>
+#include <utility>
+
+#if defined(VK_USE_PLATFORM_ANDROID_KHR)
+#define LOG(...) ((void)__android_log_print(ANDROID_LOG_INFO, "vulkanExample", __VA_ARGS__))
+#else
+#define LOG(...) { printf(__VA_ARGS__); fflush(stdout); }
+#endif
+
+struct QueueInfo {
+    VkQueueFlagBits type;
+    VkQueueGlobalPriorityEXT priority;
+    VkQueue queue;
+    uint32_t familyIndex;
+    unsigned offset;
+};
+
+class Workload {
+public:
+    virtual VkFence submit() = 0;
+    virtual void queryTimestamp(uint64_t time_stamp[], int count) = 0;
+    virtual void waitIdle() = 0;
+};
+
+class Base {
+    VkInstance m_instance;
+    VkDevice m_device;
+    VkPhysicalDevice m_physicalDevice;
+    VkPhysicalDeviceProperties m_deviceProperties;
+    std::map<VkQueueGlobalPriorityEXT, QueueInfo> m_graphicQueues;
+    std::map<VkQueueGlobalPriorityEXT, QueueInfo> m_computeQueues;
+
+    std::map<VkQueueGlobalPriorityEXT, QueueInfo>& GetQueueInfos(VkQueueFlagBits type) {
+        switch(type) {
+        case VK_QUEUE_COMPUTE_BIT: return m_computeQueues;
+        case VK_QUEUE_GRAPHICS_BIT: return m_graphicQueues;
+        default: LOG("Unsupported queue type\n");
+        }
+
+        return m_graphicQueues;
+    }
+    QueueInfo& CreateQueueInfo(VkQueueFlagBits type, VkQueueGlobalPriorityEXT priority) {
+        QueueInfo queueInfo = {};
+        queueInfo.type = type;
+        queueInfo.priority = priority;
+
+        return GetQueueInfos(type).insert({priority, queueInfo}).first->second;
+    }
+
+public:
+    VkDevice GetDevice() const { return m_device; }
+    VkInstance GetInstance() const { return m_instance; }
+    VkPhysicalDevice GetPhysicalDevice() const { return m_physicalDevice; }
+    VkPhysicalDeviceProperties GetPhysicalDeviceProperties() const { return m_deviceProperties; }
+    QueueInfo const& GetQueueInfo(VkQueueFlagBits type, VkQueueGlobalPriorityEXT priority) {
+        return GetQueueInfos(type).at(priority);
+    }
+
+    Base(std::vector<VkQueueGlobalPriorityEXT> graphicPriorities, std::vector<VkQueueGlobalPriorityEXT> computePriorities)
+    {
+		LOG("Create a device\n");
+
+#if defined(VK_USE_PLATFORM_ANDROID_KHR)
+		LOG("loading vulkan lib");
+		vks::android::loadVulkanLibrary();
+#endif
+
+		VkApplicationInfo appInfo = {};
+		appInfo.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO;
+		appInfo.pApplicationName = "Vulkan headless example";
+		appInfo.pEngineName = "ComputeWork";
+		appInfo.apiVersion = VK_API_VERSION_1_0;
+
+		/*
+			Vulkan instance creation (without surface extensions)
+		*/
+		VkInstanceCreateInfo instanceCreateInfo = {};
+		instanceCreateInfo.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
+		instanceCreateInfo.pApplicationInfo = &appInfo;
+
+		uint32_t layerCount = 0;
+#if defined(VK_USE_PLATFORM_ANDROID_KHR)
+		const char* validationLayers[] = { "VK_LAYER_GOOGLE_threading",	"VK_LAYER_LUNARG_parameter_validation",	"VK_LAYER_LUNARG_object_tracker","VK_LAYER_LUNARG_core_validation",	"VK_LAYER_LUNARG_swapchain", "VK_LAYER_GOOGLE_unique_objects" };
+		layerCount = 6;
+#else
+		const char* validationLayers[] = { "VK_LAYER_LUNARG_standard_validation" };
+		layerCount = 1;
+#endif
+#if DEBUG
+		// Check if layers are available
+		uint32_t instanceLayerCount;
+		vkEnumerateInstanceLayerProperties(&instanceLayerCount, nullptr);
+		std::vector<VkLayerProperties> instanceLayers(instanceLayerCount);
+		vkEnumerateInstanceLayerProperties(&instanceLayerCount, instanceLayers.data());
+
+		bool layersAvailable = true;
+		for (auto layerName : validationLayers) {
+			bool layerAvailable = false;
+			for (auto instanceLayer : instanceLayers) {
+				if (strcmp(instanceLayer.layerName, layerName) == 0) {
+					layerAvailable = true;
+					break;
+				}
+			}
+			if (!layerAvailable) {
+				layersAvailable = false;
+				break;
+			}
+		}
+
+		if (layersAvailable) {
+			instanceCreateInfo.ppEnabledLayerNames = validationLayers;
+			const char *validationExt = VK_EXT_DEBUG_REPORT_EXTENSION_NAME;
+			instanceCreateInfo.enabledLayerCount = layerCount;
+			instanceCreateInfo.enabledExtensionCount = 1;
+			instanceCreateInfo.ppEnabledExtensionNames = &validationExt;
+		}
+#endif
+		VK_CHECK_RESULT(vkCreateInstance(&instanceCreateInfo, nullptr, &m_instance));
+
+#if defined(VK_USE_PLATFORM_ANDROID_KHR)
+		vks::android::loadVulkanFunctions(m_instance);
+#endif
+#if DEBUG
+		if (layersAvailable) {
+			VkDebugReportCallbackCreateInfoEXT debugReportCreateInfo = {};
+			debugReportCreateInfo.sType = VK_STRUCTURE_TYPE_DEBUG_REPORT_CALLBACK_CREATE_INFO_EXT;
+			debugReportCreateInfo.flags = VK_DEBUG_REPORT_ERROR_BIT_EXT | VK_DEBUG_REPORT_WARNING_BIT_EXT;
+			debugReportCreateInfo.pfnCallback = (PFN_vkDebugReportCallbackEXT)debugMessageCallback;
+
+			// We have to explicitly load this function.
+			PFN_vkCreateDebugReportCallbackEXT vkCreateDebugReportCallbackEXT = reinterpret_cast<PFN_vkCreateDebugReportCallbackEXT>(vkGetInstanceProcAddr(m_instance, "vkCreateDebugReportCallbackEXT"));
+			assert(vkCreateDebugReportCallbackEXT);
+			VK_CHECK_RESULT(vkCreateDebugReportCallbackEXT(instance, &debugReportCreateInfo, nullptr, &debugReportCallback));
+		}
+#endif
+
+		/*
+			Vulkan device creation
+		*/
+		// Physical device (always use first)
+		uint32_t deviceCount = 0;
+		VK_CHECK_RESULT(vkEnumeratePhysicalDevices(m_instance, &deviceCount, nullptr));
+		std::vector<VkPhysicalDevice> physicalDevices(deviceCount);
+		VK_CHECK_RESULT(vkEnumeratePhysicalDevices(m_instance, &deviceCount, physicalDevices.data()));
+		m_physicalDevice = physicalDevices[0];
+
+		vkGetPhysicalDeviceProperties(m_physicalDevice, &m_deviceProperties);
+		LOG("GPU: %s\n", m_deviceProperties.deviceName);
+
+		const float defaultQueuePriority(0.0f);
+		uint32_t queueFamilyCount;
+		vkGetPhysicalDeviceQueueFamilyProperties(m_physicalDevice, &queueFamilyCount, nullptr);
+		std::vector<VkQueueFamilyProperties> queueFamilyProperties(queueFamilyCount);
+		vkGetPhysicalDeviceQueueFamilyProperties(m_physicalDevice, &queueFamilyCount, queueFamilyProperties.data());
+        const size_t queueCount = graphicPriorities.size() + computePriorities.size();
+        const size_t familyCount = queueFamilyProperties.size();
+        std::vector<unsigned> queueFamilyNextOffset(familyCount, 0);
+        std::vector<VkDeviceQueueCreateInfo> queueCreateInfos(familyCount);
+        std::vector<VkDeviceQueueGlobalPriorityCreateInfoEXT > queuePriorityCreateInfos(familyCount);
+
+        for (size_t i = 0; i < familyCount; i++) {
+            VkDeviceQueueGlobalPriorityCreateInfoEXT queuePriorityCreateInfo = {};
+            VkDeviceQueueCreateInfo queueCreateInfo = {};
+
+            queuePriorityCreateInfo.sType = VK_STRUCTURE_TYPE_DEVICE_QUEUE_GLOBAL_PRIORITY_CREATE_INFO_EXT;
+            queuePriorityCreateInfo.pNext = nullptr;
+            queuePriorityCreateInfo.globalPriority = VK_QUEUE_GLOBAL_PRIORITY_RANGE_SIZE_EXT;
+            queuePriorityCreateInfos[i] = queuePriorityCreateInfo;
+
+            queueCreateInfo.sType = VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO;
+            queueCreateInfo.queueFamilyIndex = static_cast<uint32_t>(i);
+            queueCreateInfo.pNext = nullptr;
+            queueCreateInfo.queueCount = 0;
+            queueCreateInfo.pQueuePriorities = &defaultQueuePriority;
+            queueCreateInfos[i] = queueCreateInfo;
+        }
+
+        auto addQueue = [&](VkQueueFlagBits type, VkQueueGlobalPriorityEXT globalPriority) {
+            for (uint32_t i = type - 1; i < static_cast<uint32_t>(queueFamilyProperties.size()); i++) {
+                printf("addQueue queueFamilyNextOffset:%d queueCount:%d queueFlags:%08x queuetype:%d\n",
+                    queueFamilyNextOffset[i], queueFamilyProperties[i].queueCount,
+                    queueFamilyProperties[i].queueFlags, type);
+                if ((queueFamilyNextOffset[i] < queueFamilyProperties[i].queueCount)
+                    && (queueFamilyProperties[i].queueFlags & type))
+                {
+                    auto& queueCreateInfo = queueCreateInfos[i];
+                    auto& queuePriorityCreateInfo = queuePriorityCreateInfos[i];
+
+                    if (queueCreateInfo.pNext == nullptr ||
+                        queuePriorityCreateInfo.globalPriority == globalPriority)
+                    {
+                        queuePriorityCreateInfos[i].globalPriority = globalPriority;
+                        queueCreateInfos[i].pNext = &queuePriorityCreateInfos[i];
+                        queueCreateInfos[i].queueCount++;
+
+                        auto& queueInfo = CreateQueueInfo(type, globalPriority);
+                        queueInfo.offset = queueFamilyNextOffset[i];
+                        queueInfo.familyIndex = i;
+
+                        queueCreateInfos[i].queueCount = queueFamilyProperties[i].queueCount;
+                        if (globalPriority == VkQueueGlobalPriorityEXT::VK_QUEUE_GLOBAL_PRIORITY_REALTIME_EXT
+                            || globalPriority == VkQueueGlobalPriorityEXT::VK_QUEUE_GLOBAL_PRIORITY_HIGH_EXT) {
+                            queueInfo.offset = queueCreateInfos[i].queueCount - 1;
+                        }
+
+                        queueFamilyNextOffset[i]++;
+                        return;
+                    } else {
+                        LOG("Queue family %d already assigned priority %d and trying to assign priority %d\n",
+                        i, queuePriorityCreateInfo.globalPriority, globalPriority);
+                    }
+                }
+            }
+            LOG("Unable to add queue of type %d and priority %d\n", type, globalPriority);
+            exit(-1);
+        };
+
+        // As the Queue with graphics capabilitiies also has compute, reserve it for graphics before its selected for compute
+        for (auto priority : graphicPriorities) {
+            addQueue(VK_QUEUE_GRAPHICS_BIT, priority);
+        }
+        for (auto priority : computePriorities) {
+            addQueue(VK_QUEUE_COMPUTE_BIT, priority);
+        }
+
+		// Create logical device
+		VkDeviceCreateInfo deviceCreateInfo = {};
+		deviceCreateInfo.sType = VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO;
+		deviceCreateInfo.queueCreateInfoCount = queueCreateInfos.size();
+		deviceCreateInfo.pQueueCreateInfos = queueCreateInfos.data();
+		VK_CHECK_RESULT(vkCreateDevice(m_physicalDevice, &deviceCreateInfo, nullptr, &m_device));
+
+        auto getQueue = [&](QueueInfo& queueInfo) {
+            vkGetDeviceQueue(m_device, queueInfo.familyIndex, queueInfo.offset, &queueInfo.queue);
+        };
+
+        LOG("Graphic queues : %zu\n", m_graphicQueues.size());
+        for (auto& item: m_graphicQueues) {
+            auto& queueInfo = item.second;
+            getQueue(queueInfo);
+            LOG(" [%p] familyIndex %d, priority %d\n", queueInfo.queue, queueInfo.familyIndex, queueInfo.priority);
+        }
+
+        LOG("Compute queues : %zu\n", m_computeQueues.size());
+        for (auto& item: m_computeQueues) {
+            auto& queueInfo = item.second;
+            getQueue(queueInfo);
+            LOG(" [%p] familyIndex %d, priority %d\n", queueInfo.queue, queueInfo.familyIndex, queueInfo.priority);
+        }
+    }
+
+    ~Base() {
+		vkDestroyDevice(m_device, nullptr);
+		vkDestroyInstance(m_instance, nullptr);
+    }
+};
diff --git a/vkpreemption/build_lnx.sh b/vkpreemption/build_lnx.sh
new file mode 100644
index 00000000..e8f8884b
--- /dev/null
+++ b/vkpreemption/build_lnx.sh
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+mkdir build
+
+cd build
+
+cmake -DCMAKE_BUILD_TYPE=Debug -GNinja ..
+
+ninja all
+
+cd ..
diff --git a/vkpreemption/computework.hpp b/vkpreemption/computework.hpp
new file mode 100644
index 00000000..30d111fb
--- /dev/null
+++ b/vkpreemption/computework.hpp
@@ -0,0 +1,429 @@
+/*
+* *
+* * Copyright (C) 2020 Samsung Electronics
+* *
+* */
+
+
+#pragma once
+
+#if defined(_WIN32)
+#pragma comment(linker, "/subsystem:console")
+#elif defined(VK_USE_PLATFORM_ANDROID_KHR)
+#include <android/native_activity.h>
+#include <android/asset_manager.h>
+#include <android_native_app_glue.h>
+#include <android/log.h>
+#include "VulkanAndroid.h"
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <assert.h>
+#include <vector>
+#include <iostream>
+#include <algorithm>
+
+#include <vulkan/vulkan.h>
+#include "VulkanTools.h"
+#include "base.hpp"
+
+#if defined(VK_USE_PLATFORM_ANDROID_KHR)
+android_app* androidapp;
+#endif
+
+#define DEBUG (!NDEBUG)
+
+#define BUFFER_ELEMENTS 32
+
+class ComputeWork : public Workload
+{
+    const VkDeviceSize bufferSize = BUFFER_ELEMENTS * sizeof(uint32_t);
+    std::vector<uint32_t> computeInput;
+    std::vector<uint32_t> computeOutput;
+
+public:
+	VkInstance instance;
+	VkPhysicalDevice physicalDevice;
+	VkDevice device;
+	uint32_t queueFamilyIndex;
+	VkPipelineCache pipelineCache;
+	VkQueue queue;
+	VkCommandPool commandPool;
+	VkCommandBuffer commandBuffer;
+	VkFence fence;
+	VkDescriptorPool descriptorPool;
+	VkDescriptorSetLayout descriptorSetLayout;
+	VkDescriptorSet descriptorSet;
+	VkPipelineLayout pipelineLayout;
+	VkPipeline pipeline;
+	VkShaderModule shaderModule;
+	VkQueryPool query_pool;
+
+    VkBuffer deviceBuffer, hostBuffer;
+    VkDeviceMemory deviceMemory, hostMemory;
+
+	VkDebugReportCallbackEXT debugReportCallback{};
+
+	VkResult createBuffer(VkBufferUsageFlags usageFlags, VkMemoryPropertyFlags memoryPropertyFlags, VkBuffer *buffer, VkDeviceMemory *memory, VkDeviceSize size, void *data = nullptr)
+	{
+		// Create the buffer handle
+		VkBufferCreateInfo bufferCreateInfo = vks::initializers::bufferCreateInfo(usageFlags, size);
+		bufferCreateInfo.sharingMode = VK_SHARING_MODE_EXCLUSIVE;
+		VK_CHECK_RESULT(vkCreateBuffer(device, &bufferCreateInfo, nullptr, buffer));
+
+		// Create the memory backing up the buffer handle
+		VkPhysicalDeviceMemoryProperties deviceMemoryProperties;
+		vkGetPhysicalDeviceMemoryProperties(physicalDevice, &deviceMemoryProperties);
+		VkMemoryRequirements memReqs;
+		VkMemoryAllocateInfo memAlloc = vks::initializers::memoryAllocateInfo();
+		vkGetBufferMemoryRequirements(device, *buffer, &memReqs);
+		memAlloc.allocationSize = memReqs.size;
+		// Find a memory type index that fits the properties of the buffer
+		bool memTypeFound = false;
+		for (uint32_t i = 0; i < deviceMemoryProperties.memoryTypeCount; i++) {
+			if ((memReqs.memoryTypeBits & 1) == 1) {
+				if ((deviceMemoryProperties.memoryTypes[i].propertyFlags & memoryPropertyFlags) == memoryPropertyFlags) {
+					memAlloc.memoryTypeIndex = i;
+					memTypeFound = true;
+				}
+			}
+			memReqs.memoryTypeBits >>= 1;
+		}
+		assert(memTypeFound);
+		VK_CHECK_RESULT(vkAllocateMemory(device, &memAlloc, nullptr, memory));
+
+		if (data != nullptr) {
+			void *mapped;
+			VK_CHECK_RESULT(vkMapMemory(device, *memory, 0, size, 0, &mapped));
+			memcpy(mapped, data, size);
+			vkUnmapMemory(device, *memory);
+		}
+
+		VK_CHECK_RESULT(vkBindBufferMemory(device, *buffer, *memory, 0));
+
+		return VK_SUCCESS;
+	}
+
+	ComputeWork(Base& base, QueueInfo queueInfo, unsigned commandCount = 1)
+        : computeInput(BUFFER_ELEMENTS)
+        , computeOutput(BUFFER_ELEMENTS)
+	{
+        device = base.GetDevice();
+        instance = base.GetInstance();
+        physicalDevice = base.GetPhysicalDevice();
+        queueFamilyIndex = queueInfo.familyIndex;
+        queue = queueInfo.queue;
+
+		// Compute command pool
+		VkCommandPoolCreateInfo cmdPoolInfo = {};
+		cmdPoolInfo.sType = VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO;
+		cmdPoolInfo.queueFamilyIndex = queueFamilyIndex;
+		cmdPoolInfo.flags = VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT;
+		VK_CHECK_RESULT(vkCreateCommandPool(device, &cmdPoolInfo, nullptr, &commandPool));
+
+		VkQueryPoolCreateInfo query_pool_info;
+		query_pool_info.sType = VK_STRUCTURE_TYPE_QUERY_POOL_CREATE_INFO;
+		query_pool_info.pNext = NULL;
+		query_pool_info.queryType = VK_QUERY_TYPE_TIMESTAMP;
+		query_pool_info.flags = 0;
+		query_pool_info.queryCount = 2;
+		query_pool_info.pipelineStatistics = 0;
+		VK_CHECK_RESULT(vkCreateQueryPool(device, &query_pool_info, NULL, &query_pool));
+
+		/*
+			Prepare storage buffers
+		*/
+
+		// Fill input data
+		uint32_t n = 0;
+		std::generate(computeInput.begin(), computeInput.end(), [&n] { return n++; });
+
+		// Copy input data to VRAM using a staging buffer
+		{
+			createBuffer(
+				VK_BUFFER_USAGE_TRANSFER_SRC_BIT | VK_BUFFER_USAGE_TRANSFER_DST_BIT,
+				VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT,
+				&hostBuffer,
+				&hostMemory,
+				bufferSize,
+				computeInput.data());
+
+			// Flush writes to host visible buffer
+			void* mapped;
+			vkMapMemory(device, hostMemory, 0, VK_WHOLE_SIZE, 0, &mapped);
+			VkMappedMemoryRange mappedRange = vks::initializers::mappedMemoryRange();
+			mappedRange.memory = hostMemory;
+			mappedRange.offset = 0;
+			mappedRange.size = VK_WHOLE_SIZE;
+			vkFlushMappedMemoryRanges(device, 1, &mappedRange);
+			vkUnmapMemory(device, hostMemory);
+
+			createBuffer(
+				VK_BUFFER_USAGE_STORAGE_BUFFER_BIT | VK_BUFFER_USAGE_TRANSFER_SRC_BIT | VK_BUFFER_USAGE_TRANSFER_DST_BIT,
+				VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT,
+				&deviceBuffer,
+				&deviceMemory,
+				bufferSize);
+
+			// Copy to staging buffer
+			VkCommandBufferAllocateInfo cmdBufAllocateInfo = vks::initializers::commandBufferAllocateInfo(commandPool, VK_COMMAND_BUFFER_LEVEL_PRIMARY, 1);
+			VkCommandBuffer copyCmd;
+			VK_CHECK_RESULT(vkAllocateCommandBuffers(device, &cmdBufAllocateInfo, &copyCmd));
+			VkCommandBufferBeginInfo cmdBufInfo = vks::initializers::commandBufferBeginInfo();
+			VK_CHECK_RESULT(vkBeginCommandBuffer(copyCmd, &cmdBufInfo));
+			//vkCmdResetQueryPool(copyCmd, query_pool, 0, 2);
+			VkBufferCopy copyRegion = {};
+			copyRegion.size = bufferSize;
+			//vkCmdWriteTimestamp(copyCmd, VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT, query_pool, 0);
+			vkCmdCopyBuffer(copyCmd, hostBuffer, deviceBuffer, 1, &copyRegion);
+			//vkCmdWriteTimestamp(copyCmd, VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT, query_pool, 1);
+			VK_CHECK_RESULT(vkEndCommandBuffer(copyCmd));
+
+			VkSubmitInfo submitInfo = vks::initializers::submitInfo();
+			submitInfo.commandBufferCount = 1;
+			submitInfo.pCommandBuffers = &copyCmd;
+			VkFenceCreateInfo fenceInfo = vks::initializers::fenceCreateInfo(VK_FLAGS_NONE);
+			VkFence fence;
+			VK_CHECK_RESULT(vkCreateFence(device, &fenceInfo, nullptr, &fence));
+
+			// Submit to the queue
+			VK_CHECK_RESULT(vkQueueSubmit(queue, 1, &submitInfo, fence));
+			VK_CHECK_RESULT(vkWaitForFences(device, 1, &fence, VK_TRUE, UINT64_MAX));
+
+			vkDestroyFence(device, fence, nullptr);
+			vkFreeCommandBuffers(device, commandPool, 1, &copyCmd);
+		}
+
+		/*
+			Prepare compute pipeline
+		*/
+		{
+			std::vector<VkDescriptorPoolSize> poolSizes = {
+				vks::initializers::descriptorPoolSize(VK_DESCRIPTOR_TYPE_STORAGE_BUFFER, 1),
+			};
+
+			VkDescriptorPoolCreateInfo descriptorPoolInfo =
+				vks::initializers::descriptorPoolCreateInfo(static_cast<uint32_t>(poolSizes.size()), poolSizes.data(), 1);
+			VK_CHECK_RESULT(vkCreateDescriptorPool(device, &descriptorPoolInfo, nullptr, &descriptorPool));
+
+			std::vector<VkDescriptorSetLayoutBinding> setLayoutBindings = {
+				vks::initializers::descriptorSetLayoutBinding(VK_DESCRIPTOR_TYPE_STORAGE_BUFFER, VK_SHADER_STAGE_COMPUTE_BIT, 0),
+			};
+			VkDescriptorSetLayoutCreateInfo descriptorLayout =
+				vks::initializers::descriptorSetLayoutCreateInfo(setLayoutBindings);
+			VK_CHECK_RESULT(vkCreateDescriptorSetLayout(device, &descriptorLayout, nullptr, &descriptorSetLayout));
+
+			VkPipelineLayoutCreateInfo pipelineLayoutCreateInfo =
+				vks::initializers::pipelineLayoutCreateInfo(&descriptorSetLayout, 1);
+			VK_CHECK_RESULT(vkCreatePipelineLayout(device, &pipelineLayoutCreateInfo, nullptr, &pipelineLayout));
+
+			VkDescriptorSetAllocateInfo allocInfo =
+				vks::initializers::descriptorSetAllocateInfo(descriptorPool, &descriptorSetLayout, 1);
+			VK_CHECK_RESULT(vkAllocateDescriptorSets(device, &allocInfo, &descriptorSet));
+
+			VkDescriptorBufferInfo bufferDescriptor = { deviceBuffer, 0, VK_WHOLE_SIZE };
+			std::vector<VkWriteDescriptorSet> computeWriteDescriptorSets = {
+				vks::initializers::writeDescriptorSet(descriptorSet, VK_DESCRIPTOR_TYPE_STORAGE_BUFFER, 0, &bufferDescriptor),
+			};
+			vkUpdateDescriptorSets(device, static_cast<uint32_t>(computeWriteDescriptorSets.size()), computeWriteDescriptorSets.data(), 0, NULL);
+
+			VkPipelineCacheCreateInfo pipelineCacheCreateInfo = {};
+			pipelineCacheCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_CACHE_CREATE_INFO;
+			VK_CHECK_RESULT(vkCreatePipelineCache(device, &pipelineCacheCreateInfo, nullptr, &pipelineCache));
+
+			// Create pipeline
+			VkComputePipelineCreateInfo computePipelineCreateInfo = vks::initializers::computePipelineCreateInfo(pipelineLayout, 0);
+
+			// Pass SSBO size via specialization constant
+			struct SpecializationData {
+				uint32_t BUFFER_ELEMENT_COUNT = BUFFER_ELEMENTS;
+			} specializationData;
+			VkSpecializationMapEntry specializationMapEntry = vks::initializers::specializationMapEntry(0, 0, sizeof(uint32_t));
+			VkSpecializationInfo specializationInfo = vks::initializers::specializationInfo(1, &specializationMapEntry, sizeof(SpecializationData), &specializationData);
+
+			VkPipelineShaderStageCreateInfo shaderStage = {};
+			shaderStage.sType = VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO;
+			shaderStage.stage = VK_SHADER_STAGE_COMPUTE_BIT;
+#if 1
+			const uint32_t headless_comp[] = {
+				#include "headless.comp.inc"
+			};
+			shaderStage.module = vks::tools::loadShader(sizeof(headless_comp), headless_comp, device);
+#else
+			shaderStage.module = vks::tools::loadShader(ASSET_PATH "shaders/computeheadless/headless.comp.spv", device);
+#endif
+			shaderStage.pName = "main";
+			shaderStage.pSpecializationInfo = &specializationInfo;
+			shaderModule = shaderStage.module;
+
+			assert(shaderStage.module != VK_NULL_HANDLE);
+			computePipelineCreateInfo.stage = shaderStage;
+			VK_CHECK_RESULT(vkCreateComputePipelines(device, pipelineCache, 1, &computePipelineCreateInfo, nullptr, &pipeline));
+
+			// Create a command buffer for compute operations
+			VkCommandBufferAllocateInfo cmdBufAllocateInfo =
+				vks::initializers::commandBufferAllocateInfo(commandPool, VK_COMMAND_BUFFER_LEVEL_PRIMARY, 1);
+			VK_CHECK_RESULT(vkAllocateCommandBuffers(device, &cmdBufAllocateInfo, &commandBuffer));
+
+			// Fence for compute CB sync
+			VkFenceCreateInfo fenceCreateInfo = vks::initializers::fenceCreateInfo(VK_FENCE_CREATE_SIGNALED_BIT);
+			VK_CHECK_RESULT(vkCreateFence(device, &fenceCreateInfo, nullptr, &fence));
+		}
+
+		/*
+			Command buffer creation (for compute work submission)
+		*/
+		{
+			VkCommandBufferBeginInfo cmdBufInfo = vks::initializers::commandBufferBeginInfo();
+
+			VK_CHECK_RESULT(vkBeginCommandBuffer(commandBuffer, &cmdBufInfo));
+			vkCmdResetQueryPool(commandBuffer, query_pool, 0, 2);
+			// Barrier to ensure that input buffer transfer is finished before compute shader reads from it
+			VkBufferMemoryBarrier bufferBarrier = vks::initializers::bufferMemoryBarrier();
+			bufferBarrier.buffer = deviceBuffer;
+			bufferBarrier.size = VK_WHOLE_SIZE;
+			bufferBarrier.srcAccessMask = VK_ACCESS_HOST_WRITE_BIT;
+			bufferBarrier.dstAccessMask = VK_ACCESS_SHADER_READ_BIT;
+			bufferBarrier.srcQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
+			bufferBarrier.dstQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
+
+			vkCmdPipelineBarrier(
+				commandBuffer,
+				VK_PIPELINE_STAGE_HOST_BIT,
+				VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT,
+				VK_FLAGS_NONE,
+				0, nullptr,
+				1, &bufferBarrier,
+				0, nullptr);
+
+			vkCmdBindPipeline(commandBuffer, VK_PIPELINE_BIND_POINT_COMPUTE, pipeline);
+			vkCmdBindDescriptorSets(commandBuffer, VK_PIPELINE_BIND_POINT_COMPUTE, pipelineLayout, 0, 1, &descriptorSet, 0, 0);
+			vkCmdWriteTimestamp(commandBuffer, VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT, query_pool, 0);
+			for (int i = 0;i < commandCount; i++) {
+			vkCmdDispatch(commandBuffer, BUFFER_ELEMENTS, 1, 1);
+			}
+			vkCmdWriteTimestamp(commandBuffer, VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT, query_pool, 1);
+
+			// Barrier to ensure that shader writes are finished before buffer is read back from GPU
+			bufferBarrier.srcAccessMask = VK_ACCESS_SHADER_WRITE_BIT;
+			bufferBarrier.dstAccessMask = VK_ACCESS_TRANSFER_READ_BIT;
+			bufferBarrier.buffer = deviceBuffer;
+			bufferBarrier.size = VK_WHOLE_SIZE;
+			bufferBarrier.srcQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
+			bufferBarrier.dstQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
+
+			vkCmdPipelineBarrier(
+				commandBuffer,
+				VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT,
+				VK_PIPELINE_STAGE_TRANSFER_BIT,
+				VK_FLAGS_NONE,
+				0, nullptr,
+				1, &bufferBarrier,
+				0, nullptr);
+
+			// Read back to host visible buffer
+			VkBufferCopy copyRegion = {};
+			copyRegion.size = bufferSize;
+			//vkCmdWriteTimestamp(commandBuffer, VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT, query_pool, 4);
+			vkCmdCopyBuffer(commandBuffer, deviceBuffer, hostBuffer, 1, &copyRegion);
+			//vkCmdWriteTimestamp(commandBuffer, VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT, query_pool, 5);
+
+			// Barrier to ensure that buffer copy is finished before host reading from it
+			bufferBarrier.srcAccessMask = VK_ACCESS_TRANSFER_WRITE_BIT;
+			bufferBarrier.dstAccessMask = VK_ACCESS_HOST_READ_BIT;
+			bufferBarrier.buffer = hostBuffer;
+			bufferBarrier.size = VK_WHOLE_SIZE;
+			bufferBarrier.srcQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
+			bufferBarrier.dstQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
+
+			vkCmdPipelineBarrier(
+				commandBuffer,
+				VK_PIPELINE_STAGE_TRANSFER_BIT,
+				VK_PIPELINE_STAGE_HOST_BIT,
+				VK_FLAGS_NONE,
+				0, nullptr,
+				1, &bufferBarrier,
+				0, nullptr);
+
+			VK_CHECK_RESULT(vkEndCommandBuffer(commandBuffer));
+
+		}
+	}
+
+    virtual VkFence submit() override {
+        // Submit compute work
+        vkResetFences(device, 1, &fence);
+        const VkPipelineStageFlags waitStageMask = VK_PIPELINE_STAGE_TRANSFER_BIT;
+        VkSubmitInfo computeSubmitInfo = vks::initializers::submitInfo();
+        computeSubmitInfo.pWaitDstStageMask = &waitStageMask;
+        computeSubmitInfo.commandBufferCount = 1;
+        computeSubmitInfo.pCommandBuffers = &commandBuffer;
+        VK_CHECK_RESULT(vkQueueSubmit(queue, 1, &computeSubmitInfo, fence));
+
+        return fence;
+    }
+
+	virtual void queryTimestamp(uint64_t time_stamp[], int count) override {
+		VK_CHECK_RESULT(vkGetQueryPoolResults(device, query_pool, 0, count,
+			sizeof(uint64_t)*count, time_stamp, sizeof(uint64_t), VK_QUERY_RESULT_64_BIT));
+	}
+
+    virtual void waitIdle() override {
+        VK_CHECK_RESULT(vkWaitForFences(device, 1, &fence, VK_TRUE, UINT64_MAX));
+
+        // Make device writes visible to the host
+        void *mapped;
+        vkMapMemory(device, hostMemory, 0, VK_WHOLE_SIZE, 0, &mapped);
+        VkMappedMemoryRange mappedRange = vks::initializers::mappedMemoryRange();
+        mappedRange.memory = hostMemory;
+        mappedRange.offset = 0;
+        mappedRange.size = VK_WHOLE_SIZE;
+        vkInvalidateMappedMemoryRanges(device, 1, &mappedRange);
+
+        // Copy to output
+        memcpy(computeOutput.data(), mapped, bufferSize);
+        vkUnmapMemory(device, hostMemory);
+
+		vkQueueWaitIdle(queue);
+
+		// Output buffer contents
+		LOG("Compute input:\n");
+		for (auto v : computeInput) {
+			LOG("%d \t", v);
+		}
+		std::cout << std::endl;
+
+		LOG("Compute output:\n");
+		for (auto v : computeOutput) {
+			LOG("%d \t", v);
+		}
+		std::cout << std::endl;
+    }
+
+	~ComputeWork()
+	{
+		vkDestroyBuffer(device, deviceBuffer, nullptr);
+		vkFreeMemory(device, deviceMemory, nullptr);
+		vkDestroyBuffer(device, hostBuffer, nullptr);
+		vkFreeMemory(device, hostMemory, nullptr);
+
+		vkDestroyPipelineLayout(device, pipelineLayout, nullptr);
+		vkDestroyDescriptorSetLayout(device, descriptorSetLayout, nullptr);
+		vkDestroyDescriptorPool(device, descriptorPool, nullptr);
+		vkDestroyPipeline(device, pipeline, nullptr);
+		vkDestroyPipelineCache(device, pipelineCache, nullptr);
+		vkDestroyFence(device, fence, nullptr);
+		vkDestroyCommandPool(device, commandPool, nullptr);
+		vkDestroyShaderModule(device, shaderModule, nullptr);
+#if DEBUG
+		if (debugReportCallback) {
+			PFN_vkDestroyDebugReportCallbackEXT vkDestroyDebugReportCallback = reinterpret_cast<PFN_vkDestroyDebugReportCallbackEXT>(vkGetInstanceProcAddr(instance, "vkDestroyDebugReportCallbackEXT"));
+			assert(vkDestroyDebugReportCallback);
+			vkDestroyDebugReportCallback(instance, debugReportCallback, nullptr);
+		}
+#endif
+	}
+};
+
diff --git a/vkpreemption/graphicwork.hpp b/vkpreemption/graphicwork.hpp
new file mode 100644
index 00000000..eba09481
--- /dev/null
+++ b/vkpreemption/graphicwork.hpp
@@ -0,0 +1,777 @@
+/*
+* *
+* * Copyright (C) 2020 Samsung Electronics
+* *
+* */
+
+
+#pragma once
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <assert.h>
+#include <vector>
+#include <array>
+#include <iostream>
+#include <algorithm>
+#include <ctime>
+
+#define GLM_FORCE_RADIANS
+#define GLM_FORCE_DEPTH_ZERO_TO_ONE
+#include <glm/glm.hpp>
+#include <glm/gtc/matrix_transform.hpp>
+
+#include <vulkan/vulkan.h>
+#include "VulkanTools.h"
+#include "base.hpp"
+
+#if defined(VK_USE_PLATFORM_ANDROID_KHR)
+//android_app* androidapp;
+#endif
+
+#define DEBUG (!NDEBUG)
+
+#define BUFFER_ELEMENTS 32
+
+class GraphicsWork : public Workload
+{
+public:
+	VkInstance instance;
+	VkPhysicalDevice physicalDevice;
+	VkDevice device;
+	uint32_t queueFamilyIndex;
+	VkPipelineCache pipelineCache;
+	VkQueue queue;
+    VkFence fence;
+	VkCommandPool commandPool;
+	VkCommandBuffer commandBuffer;
+	VkDescriptorSetLayout descriptorSetLayout;
+	VkPipelineLayout pipelineLayout;
+	VkPipeline pipeline;
+	std::vector<VkShaderModule> shaderModules;
+	VkBuffer vertexBuffer, indexBuffer;
+	VkDeviceMemory vertexMemory, indexMemory;
+	VkQueryPool query_pool;
+
+	struct FrameBufferAttachment {
+		VkImage image;
+		VkDeviceMemory memory;
+		VkImageView view;
+	};
+	int32_t width, height;
+	VkFramebuffer framebuffer;
+	FrameBufferAttachment colorAttachment, depthAttachment;
+	VkRenderPass renderPass;
+
+	VkDebugReportCallbackEXT debugReportCallback{};
+
+	uint32_t getMemoryTypeIndex(uint32_t typeBits, VkMemoryPropertyFlags properties) {
+		VkPhysicalDeviceMemoryProperties deviceMemoryProperties;
+		vkGetPhysicalDeviceMemoryProperties(physicalDevice, &deviceMemoryProperties);
+		for (uint32_t i = 0; i < deviceMemoryProperties.memoryTypeCount; i++) {
+			if ((typeBits & 1) == 1) {
+				if ((deviceMemoryProperties.memoryTypes[i].propertyFlags & properties) == properties) {
+					return i;
+				}
+			}
+			typeBits >>= 1;
+		}
+		return 0;
+	}
+
+	VkResult createBuffer(VkBufferUsageFlags usageFlags, VkMemoryPropertyFlags memoryPropertyFlags, VkBuffer *buffer, VkDeviceMemory *memory, VkDeviceSize size, void *data = nullptr)
+	{
+		// Create the buffer handle
+		VkBufferCreateInfo bufferCreateInfo = vks::initializers::bufferCreateInfo(usageFlags, size);
+		bufferCreateInfo.sharingMode = VK_SHARING_MODE_EXCLUSIVE;
+		VK_CHECK_RESULT(vkCreateBuffer(device, &bufferCreateInfo, nullptr, buffer));
+
+		// Create the memory backing up the buffer handle
+		VkMemoryRequirements memReqs;
+		VkMemoryAllocateInfo memAlloc = vks::initializers::memoryAllocateInfo();
+		vkGetBufferMemoryRequirements(device, *buffer, &memReqs);
+		memAlloc.allocationSize = memReqs.size;
+		memAlloc.memoryTypeIndex = getMemoryTypeIndex(memReqs.memoryTypeBits, memoryPropertyFlags);
+		VK_CHECK_RESULT(vkAllocateMemory(device, &memAlloc, nullptr, memory));
+
+		if (data != nullptr) {
+			void *mapped;
+			VK_CHECK_RESULT(vkMapMemory(device, *memory, 0, size, 0, &mapped));
+			memcpy(mapped, data, size);
+			vkUnmapMemory(device, *memory);
+		}
+
+		VK_CHECK_RESULT(vkBindBufferMemory(device, *buffer, *memory, 0));
+
+		return VK_SUCCESS;
+	}
+
+	/*
+		Submit command buffer to a queue and wait for fence until queue operations have been finished
+	*/
+	void submitWork(VkCommandBuffer cmdBuffer, VkQueue queue)
+	{
+		VkSubmitInfo submitInfo = vks::initializers::submitInfo();
+		submitInfo.commandBufferCount = 1;
+		submitInfo.pCommandBuffers = &cmdBuffer;
+		VkFenceCreateInfo fenceInfo = vks::initializers::fenceCreateInfo();
+
+		VK_CHECK_RESULT(vkCreateFence(device, &fenceInfo, nullptr, &fence));
+		VK_CHECK_RESULT(vkQueueSubmit(queue, 1, &submitInfo, fence));
+		VK_CHECK_RESULT(vkWaitForFences(device, 1, &fence, VK_TRUE, UINT64_MAX));
+		vkDestroyFence(device, fence, nullptr);
+	}
+
+	GraphicsWork(Base& base, QueueInfo queueInfo, unsigned commandCount = 10, unsigned triangleCount = 3)
+	{
+        device = base.GetDevice();
+        instance = base.GetInstance();
+        physicalDevice = base.GetPhysicalDevice();
+        queueFamilyIndex = queueInfo.familyIndex;
+        queue = queueInfo.queue;
+
+		// Command pool
+		VkCommandPoolCreateInfo cmdPoolInfo = {};
+		cmdPoolInfo.sType = VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO;
+		cmdPoolInfo.queueFamilyIndex = queueFamilyIndex;
+		cmdPoolInfo.flags = VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT;
+		VK_CHECK_RESULT(vkCreateCommandPool(device, &cmdPoolInfo, nullptr, &commandPool));
+
+		VkQueryPoolCreateInfo query_pool_info;
+		query_pool_info.sType = VK_STRUCTURE_TYPE_QUERY_POOL_CREATE_INFO;
+		query_pool_info.pNext = NULL;
+		query_pool_info.queryType = VK_QUERY_TYPE_TIMESTAMP;
+		query_pool_info.flags = 0;
+		query_pool_info.queryCount = 2;
+		query_pool_info.pipelineStatistics = 0;
+		VK_CHECK_RESULT(vkCreateQueryPool(device, &query_pool_info, NULL, &query_pool));
+
+		/*
+			Prepare vertex and index buffers
+		*/
+		struct Vertex {
+			float position[3];
+			float color[3];
+		};
+        auto randRange = [](float a, float b) -> float {
+            assert(b > a);
+            float dist = b - a;
+
+            return ((float)rand() / RAND_MAX * dist) - (dist/2);
+        };
+
+        std::srand(std::time(nullptr));
+		{
+
+			std::vector<Vertex> vertices = {
+				{ {  1.0f,  1.0f, 0.0f }, { 1.0f, 0.0f, 0.0f } },
+				{ { -1.0f,  1.0f, 0.0f }, { 0.0f, 1.0f, 0.0f } },
+				{ {  0.0f, -1.0f, 0.0f }, { 0.0f, 0.0f, 1.0f } }
+			};
+			std::vector<uint32_t> indices = { 0, 1, 2 };
+
+			const VkDeviceSize vertexBufferSize = vertices.size() * sizeof(Vertex);
+			const VkDeviceSize indexBufferSize = indices.size() * sizeof(uint32_t);
+
+			VkBuffer stagingBuffer;
+			VkDeviceMemory stagingMemory;
+
+			// Command buffer for copy commands (reused)
+			VkCommandBufferAllocateInfo cmdBufAllocateInfo = vks::initializers::commandBufferAllocateInfo(commandPool, VK_COMMAND_BUFFER_LEVEL_PRIMARY, 1);
+			VkCommandBuffer copyCmd;
+			VK_CHECK_RESULT(vkAllocateCommandBuffers(device, &cmdBufAllocateInfo, &copyCmd));
+			VkCommandBufferBeginInfo cmdBufInfo = vks::initializers::commandBufferBeginInfo();
+
+			// Copy input data to VRAM using a staging buffer
+			{
+				// Vertices
+				createBuffer(
+					VK_BUFFER_USAGE_TRANSFER_SRC_BIT,
+					VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT,
+					&stagingBuffer,
+					&stagingMemory,
+					vertexBufferSize,
+					vertices.data());
+
+				createBuffer(
+					VK_BUFFER_USAGE_VERTEX_BUFFER_BIT | VK_BUFFER_USAGE_TRANSFER_DST_BIT,
+					VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT,
+					&vertexBuffer,
+					&vertexMemory,
+					vertexBufferSize);
+
+				VK_CHECK_RESULT(vkBeginCommandBuffer(copyCmd, &cmdBufInfo));
+				VkBufferCopy copyRegion = {};
+				copyRegion.size = vertexBufferSize;
+				vkCmdCopyBuffer(copyCmd, stagingBuffer, vertexBuffer, 1, &copyRegion);
+				VK_CHECK_RESULT(vkEndCommandBuffer(copyCmd));
+
+				submitWork(copyCmd, queue);
+
+				vkDestroyBuffer(device, stagingBuffer, nullptr);
+				vkFreeMemory(device, stagingMemory, nullptr);
+
+				// Indices
+				createBuffer(
+					VK_BUFFER_USAGE_TRANSFER_SRC_BIT,
+					VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT,
+					&stagingBuffer,
+					&stagingMemory,
+					indexBufferSize,
+					indices.data());
+
+				createBuffer(
+					VK_BUFFER_USAGE_INDEX_BUFFER_BIT | VK_BUFFER_USAGE_TRANSFER_DST_BIT,
+					VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT,
+					&indexBuffer,
+					&indexMemory,
+					indexBufferSize);
+
+				VK_CHECK_RESULT(vkBeginCommandBuffer(copyCmd, &cmdBufInfo));
+				copyRegion.size = indexBufferSize;
+				vkCmdCopyBuffer(copyCmd, stagingBuffer, indexBuffer, 1, &copyRegion);
+				VK_CHECK_RESULT(vkEndCommandBuffer(copyCmd));
+
+				submitWork(copyCmd, queue);
+
+				vkDestroyBuffer(device, stagingBuffer, nullptr);
+				vkFreeMemory(device, stagingMemory, nullptr);
+			}
+		}
+
+		/*
+			Create framebuffer attachments
+		*/
+		width = 1024;
+		height = 1024;
+		VkFormat colorFormat = VK_FORMAT_R8G8B8A8_UNORM;
+		VkFormat depthFormat;
+		vks::tools::getSupportedDepthFormat(physicalDevice, &depthFormat);
+		{
+			// Color attachment
+			VkImageCreateInfo image = vks::initializers::imageCreateInfo();
+			image.imageType = VK_IMAGE_TYPE_2D;
+			image.format = colorFormat;
+			image.extent.width = width;
+			image.extent.height = height;
+			image.extent.depth = 1;
+			image.mipLevels = 1;
+			image.arrayLayers = 1;
+			image.samples = VK_SAMPLE_COUNT_1_BIT;
+			image.tiling = VK_IMAGE_TILING_OPTIMAL;
+			image.usage = VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT | VK_IMAGE_USAGE_TRANSFER_SRC_BIT;
+
+			VkMemoryAllocateInfo memAlloc = vks::initializers::memoryAllocateInfo();
+			VkMemoryRequirements memReqs;
+
+			VK_CHECK_RESULT(vkCreateImage(device, &image, nullptr, &colorAttachment.image));
+			vkGetImageMemoryRequirements(device, colorAttachment.image, &memReqs);
+			memAlloc.allocationSize = memReqs.size;
+			memAlloc.memoryTypeIndex = getMemoryTypeIndex(memReqs.memoryTypeBits, VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT);
+			VK_CHECK_RESULT(vkAllocateMemory(device, &memAlloc, nullptr, &colorAttachment.memory));
+			VK_CHECK_RESULT(vkBindImageMemory(device, colorAttachment.image, colorAttachment.memory, 0));
+
+			VkImageViewCreateInfo colorImageView = vks::initializers::imageViewCreateInfo();
+			colorImageView.viewType = VK_IMAGE_VIEW_TYPE_2D;
+			colorImageView.format = colorFormat;
+			colorImageView.subresourceRange = {};
+			colorImageView.subresourceRange.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;
+			colorImageView.subresourceRange.baseMipLevel = 0;
+			colorImageView.subresourceRange.levelCount = 1;
+			colorImageView.subresourceRange.baseArrayLayer = 0;
+			colorImageView.subresourceRange.layerCount = 1;
+			colorImageView.image = colorAttachment.image;
+			VK_CHECK_RESULT(vkCreateImageView(device, &colorImageView, nullptr, &colorAttachment.view));
+
+			// Depth stencil attachment
+			image.format = depthFormat;
+			image.usage = VK_IMAGE_USAGE_DEPTH_STENCIL_ATTACHMENT_BIT;
+
+			VK_CHECK_RESULT(vkCreateImage(device, &image, nullptr, &depthAttachment.image));
+			vkGetImageMemoryRequirements(device, depthAttachment.image, &memReqs);
+			memAlloc.allocationSize = memReqs.size;
+			memAlloc.memoryTypeIndex = getMemoryTypeIndex(memReqs.memoryTypeBits, VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT);
+			VK_CHECK_RESULT(vkAllocateMemory(device, &memAlloc, nullptr, &depthAttachment.memory));
+			VK_CHECK_RESULT(vkBindImageMemory(device, depthAttachment.image, depthAttachment.memory, 0));
+
+			VkImageViewCreateInfo depthStencilView = vks::initializers::imageViewCreateInfo();
+			depthStencilView.viewType = VK_IMAGE_VIEW_TYPE_2D;
+			depthStencilView.format = depthFormat;
+			depthStencilView.flags = 0;
+			depthStencilView.subresourceRange = {};
+			depthStencilView.subresourceRange.aspectMask = VK_IMAGE_ASPECT_DEPTH_BIT | VK_IMAGE_ASPECT_STENCIL_BIT;
+			depthStencilView.subresourceRange.baseMipLevel = 0;
+			depthStencilView.subresourceRange.levelCount = 1;
+			depthStencilView.subresourceRange.baseArrayLayer = 0;
+			depthStencilView.subresourceRange.layerCount = 1;
+			depthStencilView.image = depthAttachment.image;
+			VK_CHECK_RESULT(vkCreateImageView(device, &depthStencilView, nullptr, &depthAttachment.view));
+		}
+
+		/*
+			Create renderpass
+		*/
+		{
+			std::array<VkAttachmentDescription, 2> attchmentDescriptions = {};
+			// Color attachment
+			attchmentDescriptions[0].format = colorFormat;
+			attchmentDescriptions[0].samples = VK_SAMPLE_COUNT_1_BIT;
+			attchmentDescriptions[0].loadOp = VK_ATTACHMENT_LOAD_OP_CLEAR;
+			attchmentDescriptions[0].storeOp = VK_ATTACHMENT_STORE_OP_STORE;
+			attchmentDescriptions[0].stencilLoadOp = VK_ATTACHMENT_LOAD_OP_DONT_CARE;
+			attchmentDescriptions[0].stencilStoreOp = VK_ATTACHMENT_STORE_OP_DONT_CARE;
+			attchmentDescriptions[0].initialLayout = VK_IMAGE_LAYOUT_UNDEFINED;
+			attchmentDescriptions[0].finalLayout = VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL;
+			// Depth attachment
+			attchmentDescriptions[1].format = depthFormat;
+			attchmentDescriptions[1].samples = VK_SAMPLE_COUNT_1_BIT;
+			attchmentDescriptions[1].loadOp = VK_ATTACHMENT_LOAD_OP_CLEAR;
+			attchmentDescriptions[1].storeOp = VK_ATTACHMENT_STORE_OP_DONT_CARE;
+			attchmentDescriptions[1].stencilLoadOp = VK_ATTACHMENT_LOAD_OP_DONT_CARE;
+			attchmentDescriptions[1].stencilStoreOp = VK_ATTACHMENT_STORE_OP_DONT_CARE;
+			attchmentDescriptions[1].initialLayout = VK_IMAGE_LAYOUT_UNDEFINED;
+			attchmentDescriptions[1].finalLayout = VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL;
+
+			VkAttachmentReference colorReference = { 0, VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL };
+			VkAttachmentReference depthReference = { 1, VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL };
+
+			VkSubpassDescription subpassDescription = {};
+			subpassDescription.pipelineBindPoint = VK_PIPELINE_BIND_POINT_GRAPHICS;
+			subpassDescription.colorAttachmentCount = 1;
+			subpassDescription.pColorAttachments = &colorReference;
+			subpassDescription.pDepthStencilAttachment = &depthReference;
+
+			// Use subpass dependencies for layout transitions
+			std::array<VkSubpassDependency, 2> dependencies;
+
+			dependencies[0].srcSubpass = VK_SUBPASS_EXTERNAL;
+			dependencies[0].dstSubpass = 0;
+			dependencies[0].srcStageMask = VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT;
+			dependencies[0].dstStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT;
+			dependencies[0].srcAccessMask = VK_ACCESS_MEMORY_READ_BIT;
+			dependencies[0].dstAccessMask = VK_ACCESS_COLOR_ATTACHMENT_READ_BIT | VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT;
+			dependencies[0].dependencyFlags = VK_DEPENDENCY_BY_REGION_BIT;
+
+			dependencies[1].srcSubpass = 0;
+			dependencies[1].dstSubpass = VK_SUBPASS_EXTERNAL;
+			dependencies[1].srcStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT;
+			dependencies[1].dstStageMask = VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT;
+			dependencies[1].srcAccessMask = VK_ACCESS_COLOR_ATTACHMENT_READ_BIT | VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT;
+			dependencies[1].dstAccessMask = VK_ACCESS_MEMORY_READ_BIT;
+			dependencies[1].dependencyFlags = VK_DEPENDENCY_BY_REGION_BIT;
+
+			// Create the actual renderpass
+			VkRenderPassCreateInfo renderPassInfo = {};
+			renderPassInfo.sType = VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO;
+			renderPassInfo.attachmentCount = static_cast<uint32_t>(attchmentDescriptions.size());
+			renderPassInfo.pAttachments = attchmentDescriptions.data();
+			renderPassInfo.subpassCount = 1;
+			renderPassInfo.pSubpasses = &subpassDescription;
+			renderPassInfo.dependencyCount = static_cast<uint32_t>(dependencies.size());
+			renderPassInfo.pDependencies = dependencies.data();
+			VK_CHECK_RESULT(vkCreateRenderPass(device, &renderPassInfo, nullptr, &renderPass));
+
+			VkImageView attachments[2];
+			attachments[0] = colorAttachment.view;
+			attachments[1] = depthAttachment.view;
+
+			VkFramebufferCreateInfo framebufferCreateInfo = vks::initializers::framebufferCreateInfo();
+			framebufferCreateInfo.renderPass = renderPass;
+			framebufferCreateInfo.attachmentCount = 2;
+			framebufferCreateInfo.pAttachments = attachments;
+			framebufferCreateInfo.width = width;
+			framebufferCreateInfo.height = height;
+			framebufferCreateInfo.layers = 1;
+			VK_CHECK_RESULT(vkCreateFramebuffer(device, &framebufferCreateInfo, nullptr, &framebuffer));
+		}
+
+		/*
+			Prepare graphics pipeline
+		*/
+		{
+			std::vector<VkDescriptorSetLayoutBinding> setLayoutBindings = {};
+			VkDescriptorSetLayoutCreateInfo descriptorLayout =
+				vks::initializers::descriptorSetLayoutCreateInfo(setLayoutBindings);
+			VK_CHECK_RESULT(vkCreateDescriptorSetLayout(device, &descriptorLayout, nullptr, &descriptorSetLayout));
+
+			VkPipelineLayoutCreateInfo pipelineLayoutCreateInfo =
+				vks::initializers::pipelineLayoutCreateInfo(nullptr, 0);
+
+			// MVP via push constant block
+			VkPushConstantRange pushConstantRange = vks::initializers::pushConstantRange(VK_SHADER_STAGE_VERTEX_BIT, sizeof(glm::mat4), 0);
+			pipelineLayoutCreateInfo.pushConstantRangeCount = 1;
+			pipelineLayoutCreateInfo.pPushConstantRanges = &pushConstantRange;
+
+			VK_CHECK_RESULT(vkCreatePipelineLayout(device, &pipelineLayoutCreateInfo, nullptr, &pipelineLayout));
+
+			VkPipelineCacheCreateInfo pipelineCacheCreateInfo = {};
+			pipelineCacheCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_CACHE_CREATE_INFO;
+			VK_CHECK_RESULT(vkCreatePipelineCache(device, &pipelineCacheCreateInfo, nullptr, &pipelineCache));
+
+			// Create pipeline
+			VkPipelineInputAssemblyStateCreateInfo inputAssemblyState =
+				vks::initializers::pipelineInputAssemblyStateCreateInfo(VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST, 0, VK_FALSE);
+
+			VkPipelineRasterizationStateCreateInfo rasterizationState =
+				vks::initializers::pipelineRasterizationStateCreateInfo(VK_POLYGON_MODE_FILL, VK_CULL_MODE_BACK_BIT, VK_FRONT_FACE_CLOCKWISE);
+
+			VkPipelineColorBlendAttachmentState blendAttachmentState =
+				vks::initializers::pipelineColorBlendAttachmentState(0xf, VK_FALSE);
+
+			VkPipelineColorBlendStateCreateInfo colorBlendState =
+				vks::initializers::pipelineColorBlendStateCreateInfo(1, &blendAttachmentState);
+
+			VkPipelineDepthStencilStateCreateInfo depthStencilState =
+				vks::initializers::pipelineDepthStencilStateCreateInfo(VK_TRUE, VK_TRUE, VK_COMPARE_OP_LESS_OR_EQUAL);
+
+			VkPipelineViewportStateCreateInfo viewportState =
+				vks::initializers::pipelineViewportStateCreateInfo(1, 1);
+
+			VkPipelineMultisampleStateCreateInfo multisampleState =
+				vks::initializers::pipelineMultisampleStateCreateInfo(VK_SAMPLE_COUNT_1_BIT);
+
+			std::vector<VkDynamicState> dynamicStateEnables = {
+				VK_DYNAMIC_STATE_VIEWPORT,
+				VK_DYNAMIC_STATE_SCISSOR
+			};
+			VkPipelineDynamicStateCreateInfo dynamicState =
+				vks::initializers::pipelineDynamicStateCreateInfo(dynamicStateEnables);
+
+			VkGraphicsPipelineCreateInfo pipelineCreateInfo =
+				vks::initializers::pipelineCreateInfo(pipelineLayout, renderPass);
+
+			std::array<VkPipelineShaderStageCreateInfo, 2> shaderStages{};
+
+			pipelineCreateInfo.pInputAssemblyState = &inputAssemblyState;
+			pipelineCreateInfo.pRasterizationState = &rasterizationState;
+			pipelineCreateInfo.pColorBlendState = &colorBlendState;
+			pipelineCreateInfo.pMultisampleState = &multisampleState;
+			pipelineCreateInfo.pViewportState = &viewportState;
+			pipelineCreateInfo.pDepthStencilState = &depthStencilState;
+			pipelineCreateInfo.pDynamicState = &dynamicState;
+			pipelineCreateInfo.stageCount = static_cast<uint32_t>(shaderStages.size());
+			pipelineCreateInfo.pStages = shaderStages.data();
+
+			// Vertex bindings an attributes
+			// Binding description
+			std::vector<VkVertexInputBindingDescription> vertexInputBindings = {
+				vks::initializers::vertexInputBindingDescription(0, sizeof(Vertex), VK_VERTEX_INPUT_RATE_VERTEX),
+			};
+
+			// Attribute descriptions
+			std::vector<VkVertexInputAttributeDescription> vertexInputAttributes = {
+				vks::initializers::vertexInputAttributeDescription(0, 0, VK_FORMAT_R32G32B32_SFLOAT, 0),					// Position
+				vks::initializers::vertexInputAttributeDescription(0, 1, VK_FORMAT_R32G32B32_SFLOAT, sizeof(float) * 3),	// Color
+			};
+
+			VkPipelineVertexInputStateCreateInfo vertexInputState = vks::initializers::pipelineVertexInputStateCreateInfo();
+			vertexInputState.vertexBindingDescriptionCount = static_cast<uint32_t>(vertexInputBindings.size());
+			vertexInputState.pVertexBindingDescriptions = vertexInputBindings.data();
+			vertexInputState.vertexAttributeDescriptionCount = static_cast<uint32_t>(vertexInputAttributes.size());
+			vertexInputState.pVertexAttributeDescriptions = vertexInputAttributes.data();
+
+			pipelineCreateInfo.pVertexInputState = &vertexInputState;
+
+			shaderStages[0].sType = VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO;
+			shaderStages[0].stage = VK_SHADER_STAGE_VERTEX_BIT;
+			shaderStages[0].pName = "main";
+			shaderStages[1].sType = VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO;
+			shaderStages[1].stage = VK_SHADER_STAGE_FRAGMENT_BIT;
+			shaderStages[1].pName = "main";
+#if 1
+			const uint32_t triangle_vert[] = {
+				#include "triangle.vert.inc"
+			};
+			const uint32_t triangle_frag[] = {
+				#include "triangle.frag.inc"
+			};
+			shaderStages[0].module = vks::tools::loadShader(sizeof(triangle_vert), triangle_vert, device);
+			shaderStages[1].module = vks::tools::loadShader(sizeof(triangle_frag), triangle_frag, device);
+#else
+			shaderStages[0].module = vks::tools::loadShader(ASSET_PATH "shaders/renderheadless/triangle.vert.spv", device);
+			shaderStages[1].module = vks::tools::loadShader(ASSET_PATH "shaders/renderheadless/triangle.frag.spv", device);
+#endif
+			shaderModules = { shaderStages[0].module, shaderStages[1].module };
+			VK_CHECK_RESULT(vkCreateGraphicsPipelines(device, pipelineCache, 1, &pipelineCreateInfo, nullptr, &pipeline));
+		}
+
+		/*
+			Command buffer creation
+		*/
+		{
+			VkCommandBufferAllocateInfo cmdBufAllocateInfo =
+				vks::initializers::commandBufferAllocateInfo(commandPool, VK_COMMAND_BUFFER_LEVEL_PRIMARY, 1);
+			VK_CHECK_RESULT(vkAllocateCommandBuffers(device, &cmdBufAllocateInfo, &commandBuffer));
+
+			VkCommandBufferBeginInfo cmdBufInfo =
+				vks::initializers::commandBufferBeginInfo();
+
+			VK_CHECK_RESULT(vkBeginCommandBuffer(commandBuffer, &cmdBufInfo));
+
+			vkCmdResetQueryPool(commandBuffer, query_pool, 0, 2);
+
+			vkCmdWriteTimestamp(commandBuffer, VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT, query_pool, 0);
+
+			VkClearValue clearValues[2];
+			clearValues[0].color = { { 0.0f, 0.0f, 0.2f, 1.0f } };
+			clearValues[1].depthStencil = { 1.0f, 0 };
+
+			VkRenderPassBeginInfo renderPassBeginInfo = {};
+			renderPassBeginInfo.sType = VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO;
+			renderPassBeginInfo.renderArea.extent.width = width;
+			renderPassBeginInfo.renderArea.extent.height = height;
+			renderPassBeginInfo.clearValueCount = 2;
+			renderPassBeginInfo.pClearValues = clearValues;
+			renderPassBeginInfo.renderPass = renderPass;
+			renderPassBeginInfo.framebuffer = framebuffer;
+
+			vkCmdBeginRenderPass(commandBuffer, &renderPassBeginInfo, VK_SUBPASS_CONTENTS_INLINE);
+
+			VkViewport viewport = {};
+			viewport.height = (float)height;
+			viewport.width = (float)width;
+			viewport.minDepth = (float)0.0f;
+			viewport.maxDepth = (float)1.0f;
+			vkCmdSetViewport(commandBuffer, 0, 1, &viewport);
+
+			// Update dynamic scissor state
+			VkRect2D scissor = {};
+			scissor.extent.width = width;
+			scissor.extent.height = height;
+			vkCmdSetScissor(commandBuffer, 0, 1, &scissor);
+
+			vkCmdBindPipeline(commandBuffer, VK_PIPELINE_BIND_POINT_GRAPHICS, pipeline);
+
+			// Render scene
+			VkDeviceSize offsets[1] = { 0 };
+			vkCmdBindVertexBuffers(commandBuffer, 0, 1, &vertexBuffer, offsets);
+			vkCmdBindIndexBuffer(commandBuffer, indexBuffer, 0, VK_INDEX_TYPE_UINT32);
+
+            std::srand(std::time(nullptr));
+			std::vector<glm::vec3> pos(commandCount);
+            for (auto& v : pos) {
+                float x = ((float)rand() / RAND_MAX * 3.0) - 1.5f; // [-1.5,  1.5]
+                float y = ((float)rand() / RAND_MAX )      - 0.5f; // [-0.5,  0.5]
+                float z = ((float)rand() / RAND_MAX * 1.5) - 4.0f; // [-4.0, -2.5]
+
+				v = glm::vec3(x, y, z);
+            }
+
+			for (auto v : pos) {
+				glm::mat4 mvpMatrix = glm::perspective(glm::radians(60.0f), (float)width / (float)height, 0.1f, 256.0f) * glm::translate(glm::mat4(1.0f), v);
+				vkCmdPushConstants(commandBuffer, pipelineLayout, VK_SHADER_STAGE_VERTEX_BIT, 0, sizeof(mvpMatrix), &mvpMatrix);
+
+                vkCmdDrawIndexed(commandBuffer, 3, 1, 0, 0, 0);
+			}
+
+			vkCmdEndRenderPass(commandBuffer);
+			vkCmdWriteTimestamp(commandBuffer, VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT, query_pool, 1);
+
+			VK_CHECK_RESULT(vkEndCommandBuffer(commandBuffer));
+		}
+	}
+
+    virtual VkFence submit() override {
+		VkSubmitInfo submitInfo = vks::initializers::submitInfo();
+		submitInfo.commandBufferCount = 1;
+		submitInfo.pCommandBuffers = &commandBuffer;
+		VkFenceCreateInfo fenceInfo = vks::initializers::fenceCreateInfo();
+
+		VK_CHECK_RESULT(vkCreateFence(device, &fenceInfo, nullptr, &fence));
+		VK_CHECK_RESULT(vkQueueSubmit(queue, 1, &submitInfo, fence));
+
+        return fence;
+
+    }
+
+	virtual void queryTimestamp(uint64_t time_stamp[], int count) override {
+		VK_CHECK_RESULT(vkGetQueryPoolResults(device, query_pool, 0, count,
+			sizeof(uint64_t)*count, time_stamp, sizeof(uint64_t), VK_QUERY_RESULT_64_BIT));
+	}
+
+    virtual void waitIdle() override {
+		VK_CHECK_RESULT(vkWaitForFences(device, 1, &fence, VK_TRUE, UINT64_MAX));
+		vkDestroyFence(device, fence, nullptr);
+
+        vkDeviceWaitIdle(device);
+
+		/*
+			Copy framebuffer image to host visible image
+		*/
+		const char* imagedata;
+		{
+			// Create the linear tiled destination image to copy to and to read the memory from
+			VkImageCreateInfo imgCreateInfo(vks::initializers::imageCreateInfo());
+			imgCreateInfo.imageType = VK_IMAGE_TYPE_2D;
+			imgCreateInfo.format = VK_FORMAT_R8G8B8A8_UNORM;
+			imgCreateInfo.extent.width = width;
+			imgCreateInfo.extent.height = height;
+			imgCreateInfo.extent.depth = 1;
+			imgCreateInfo.arrayLayers = 1;
+			imgCreateInfo.mipLevels = 1;
+			imgCreateInfo.initialLayout = VK_IMAGE_LAYOUT_UNDEFINED;
+			imgCreateInfo.samples = VK_SAMPLE_COUNT_1_BIT;
+			imgCreateInfo.tiling = VK_IMAGE_TILING_LINEAR;
+			imgCreateInfo.usage = VK_IMAGE_USAGE_TRANSFER_DST_BIT;
+			// Create the image
+			VkImage dstImage;
+			VK_CHECK_RESULT(vkCreateImage(device, &imgCreateInfo, nullptr, &dstImage));
+			// Create memory to back up the image
+			VkMemoryRequirements memRequirements;
+			VkMemoryAllocateInfo memAllocInfo(vks::initializers::memoryAllocateInfo());
+			VkDeviceMemory dstImageMemory;
+			vkGetImageMemoryRequirements(device, dstImage, &memRequirements);
+			memAllocInfo.allocationSize = memRequirements.size;
+			// Memory must be host visible to copy from
+			memAllocInfo.memoryTypeIndex = getMemoryTypeIndex(memRequirements.memoryTypeBits, VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT);
+			VK_CHECK_RESULT(vkAllocateMemory(device, &memAllocInfo, nullptr, &dstImageMemory));
+			VK_CHECK_RESULT(vkBindImageMemory(device, dstImage, dstImageMemory, 0));
+
+			// Do the actual blit from the offscreen image to our host visible destination image
+			VkCommandBufferAllocateInfo cmdBufAllocateInfo = vks::initializers::commandBufferAllocateInfo(commandPool, VK_COMMAND_BUFFER_LEVEL_PRIMARY, 1);
+			VkCommandBuffer copyCmd;
+			VK_CHECK_RESULT(vkAllocateCommandBuffers(device, &cmdBufAllocateInfo, &copyCmd));
+			VkCommandBufferBeginInfo cmdBufInfo = vks::initializers::commandBufferBeginInfo();
+			VK_CHECK_RESULT(vkBeginCommandBuffer(copyCmd, &cmdBufInfo));
+
+			// Transition destination image to transfer destination layout
+			vks::tools::insertImageMemoryBarrier(
+				copyCmd,
+				dstImage,
+				0,
+				VK_ACCESS_TRANSFER_WRITE_BIT,
+				VK_IMAGE_LAYOUT_UNDEFINED,
+				VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL,
+				VK_PIPELINE_STAGE_TRANSFER_BIT,
+				VK_PIPELINE_STAGE_TRANSFER_BIT,
+				VkImageSubresourceRange{ VK_IMAGE_ASPECT_COLOR_BIT, 0, 1, 0, 1 });
+
+			// colorAttachment.image is already in VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL, and does not need to be transitioned
+
+			VkImageCopy imageCopyRegion{};
+			imageCopyRegion.srcSubresource.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;
+			imageCopyRegion.srcSubresource.layerCount = 1;
+			imageCopyRegion.dstSubresource.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;
+			imageCopyRegion.dstSubresource.layerCount = 1;
+			imageCopyRegion.extent.width = width;
+			imageCopyRegion.extent.height = height;
+			imageCopyRegion.extent.depth = 1;
+
+			vkCmdCopyImage(
+				copyCmd,
+				colorAttachment.image, VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL,
+				dstImage, VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL,
+				1,
+				&imageCopyRegion);
+
+			// Transition destination image to general layout, which is the required layout for mapping the image memory later on
+			vks::tools::insertImageMemoryBarrier(
+				copyCmd,
+				dstImage,
+				VK_ACCESS_TRANSFER_WRITE_BIT,
+				VK_ACCESS_MEMORY_READ_BIT,
+				VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL,
+				VK_IMAGE_LAYOUT_GENERAL,
+				VK_PIPELINE_STAGE_TRANSFER_BIT,
+				VK_PIPELINE_STAGE_TRANSFER_BIT,
+				VkImageSubresourceRange{ VK_IMAGE_ASPECT_COLOR_BIT, 0, 1, 0, 1 });
+
+			VK_CHECK_RESULT(vkEndCommandBuffer(copyCmd));
+
+			submitWork(copyCmd, queue);
+
+			// Get layout of the image (including row pitch)
+			VkImageSubresource subResource{};
+			subResource.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;
+			VkSubresourceLayout subResourceLayout;
+
+			vkGetImageSubresourceLayout(device, dstImage, &subResource, &subResourceLayout);
+
+			// Map image memory so we can start copying from it
+			vkMapMemory(device, dstImageMemory, 0, VK_WHOLE_SIZE, 0, (void**)&imagedata);
+			imagedata += subResourceLayout.offset;
+
+		/*
+			Save host visible framebuffer image to disk (ppm format)
+		*/
+
+#if defined (VK_USE_PLATFORM_ANDROID_KHR)
+			const char* filename = strcat(getenv("EXTERNAL_STORAGE"), "/headless.ppm");
+#else
+			const char* filename = "headless.ppm";
+#endif
+			std::ofstream file(filename, std::ios::out | std::ios::binary);
+
+			// ppm header
+			file << "P6\n" << width << "\n" << height << "\n" << 255 << "\n";
+
+			// If source is BGR (destination is always RGB) and we can't use blit (which does automatic conversion), we'll have to manually swizzle color components
+			// Check if source is BGR and needs swizzle
+			std::vector<VkFormat> formatsBGR = { VK_FORMAT_B8G8R8A8_SRGB, VK_FORMAT_B8G8R8A8_UNORM, VK_FORMAT_B8G8R8A8_SNORM };
+			const bool colorSwizzle = (std::find(formatsBGR.begin(), formatsBGR.end(), VK_FORMAT_R8G8B8A8_UNORM) != formatsBGR.end());
+
+			// ppm binary pixel data
+			for (int32_t y = 0; y < height; y++) {
+				unsigned int *row = (unsigned int*)imagedata;
+				for (int32_t x = 0; x < width; x++) {
+					if (colorSwizzle) {
+						file.write((char*)row + 2, 1);
+						file.write((char*)row + 1, 1);
+						file.write((char*)row, 1);
+					}
+					else {
+						file.write((char*)row, 3);
+					}
+					row++;
+				}
+				imagedata += subResourceLayout.rowPitch;
+			}
+			file.close();
+
+			LOG("Framebuffer image saved to %s\n", filename);
+
+			// Clean up resources
+			vkUnmapMemory(device, dstImageMemory);
+			vkFreeMemory(device, dstImageMemory, nullptr);
+			vkDestroyImage(device, dstImage, nullptr);
+		}
+
+		vkQueueWaitIdle(queue);
+    }
+
+	~GraphicsWork()
+	{
+		vkDestroyBuffer(device, vertexBuffer, nullptr);
+		vkFreeMemory(device, vertexMemory, nullptr);
+		vkDestroyBuffer(device, indexBuffer, nullptr);
+		vkFreeMemory(device, indexMemory, nullptr);
+		vkDestroyImageView(device, colorAttachment.view, nullptr);
+		vkDestroyImage(device, colorAttachment.image, nullptr);
+		vkFreeMemory(device, colorAttachment.memory, nullptr);
+		vkDestroyImageView(device, depthAttachment.view, nullptr);
+		vkDestroyImage(device, depthAttachment.image, nullptr);
+		vkFreeMemory(device, depthAttachment.memory, nullptr);
+		vkDestroyRenderPass(device, renderPass, nullptr);
+		vkDestroyFramebuffer(device, framebuffer, nullptr);
+		vkDestroyPipelineLayout(device, pipelineLayout, nullptr);
+		vkDestroyDescriptorSetLayout(device, descriptorSetLayout, nullptr);
+		vkDestroyPipeline(device, pipeline, nullptr);
+		vkDestroyPipelineCache(device, pipelineCache, nullptr);
+		vkDestroyCommandPool(device, commandPool, nullptr);
+		for (auto shadermodule : shaderModules) {
+			vkDestroyShaderModule(device, shadermodule, nullptr);
+		}
+#if DEBUG
+		if (debugReportCallback) {
+			PFN_vkDestroyDebugReportCallbackEXT vkDestroyDebugReportCallback = reinterpret_cast<PFN_vkDestroyDebugReportCallbackEXT>(vkGetInstanceProcAddr(instance, "vkDestroyDebugReportCallbackEXT"));
+			assert(vkDestroyDebugReportCallback);
+			vkDestroyDebugReportCallback(instance, debugReportCallback, nullptr);
+		}
+#endif
+#if defined(VK_USE_PLATFORM_ANDROID_KHR)
+		vks::android::freeVulkanLibrary();
+#endif
+	}
+};
+
diff --git a/vkpreemption/headless.comp b/vkpreemption/headless.comp
new file mode 100644
index 00000000..fb72c429
--- /dev/null
+++ b/vkpreemption/headless.comp
@@ -0,0 +1,34 @@
+#version 450
+
+layout(binding = 0) buffer Pos {
+   uint values[ ];
+};
+
+layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
+
+layout (constant_id = 0) const uint BUFFER_ELEMENTS = 32;
+
+uint fibonacci(uint n) {
+	if(n <= 1){
+		return n;
+	}
+	uint curr = 1;
+	uint prev = 1;
+	for(uint i = 2; i < n; ++i) {
+		uint temp = curr;
+		curr += prev;
+		prev = temp;
+	}
+	return curr;
+}
+
+void main()
+{
+	uint index = gl_GlobalInvocationID.x;
+	if (index >= BUFFER_ELEMENTS)
+		return;
+	//values[index] = fibonacci(values[index]);
+	//values[index] = fibonacci(index);
+	values[index] = values[index]+1;
+}
+
diff --git a/vkpreemption/headless.comp.inc b/vkpreemption/headless.comp.inc
new file mode 100644
index 00000000..b41717e9
--- /dev/null
+++ b/vkpreemption/headless.comp.inc
@@ -0,0 +1,33 @@
+	// 8.13.3727
+	0x07230203,0x00010000,0x00080008,0x00000026,0x00000000,0x00020011,0x00000001,0x0006000b,
+	0x00000001,0x4c534c47,0x6474732e,0x3035342e,0x00000000,0x0003000e,0x00000000,0x00000001,
+	0x0006000f,0x00000005,0x00000004,0x6e69616d,0x00000000,0x0000000b,0x00060010,0x00000004,
+	0x00000011,0x00000001,0x00000001,0x00000001,0x00030003,0x00000002,0x000001c2,0x00040005,
+	0x00000004,0x6e69616d,0x00000000,0x00040005,0x00000008,0x65646e69,0x00000078,0x00080005,
+	0x0000000b,0x475f6c67,0x61626f6c,0x766e496c,0x7461636f,0x496e6f69,0x00000044,0x00060005,
+	0x00000011,0x46465542,0x455f5245,0x454d454c,0x0053544e,0x00030005,0x00000018,0x00736f50,
+	0x00050006,0x00000018,0x00000000,0x756c6176,0x00007365,0x00030005,0x0000001a,0x00000000,
+	0x00040047,0x0000000b,0x0000000b,0x0000001c,0x00040047,0x00000011,0x00000001,0x00000000,
+	0x00040047,0x00000017,0x00000006,0x00000004,0x00050048,0x00000018,0x00000000,0x00000023,
+	0x00000000,0x00030047,0x00000018,0x00000003,0x00040047,0x0000001a,0x00000022,0x00000000,
+	0x00040047,0x0000001a,0x00000021,0x00000000,0x00040047,0x00000025,0x0000000b,0x00000019,
+	0x00020013,0x00000002,0x00030021,0x00000003,0x00000002,0x00040015,0x00000006,0x00000020,
+	0x00000000,0x00040020,0x00000007,0x00000007,0x00000006,0x00040017,0x00000009,0x00000006,
+	0x00000003,0x00040020,0x0000000a,0x00000001,0x00000009,0x0004003b,0x0000000a,0x0000000b,
+	0x00000001,0x0004002b,0x00000006,0x0000000c,0x00000000,0x00040020,0x0000000d,0x00000001,
+	0x00000006,0x00040032,0x00000006,0x00000011,0x00000020,0x00020014,0x00000012,0x0003001d,
+	0x00000017,0x00000006,0x0003001e,0x00000018,0x00000017,0x00040020,0x00000019,0x00000002,
+	0x00000018,0x0004003b,0x00000019,0x0000001a,0x00000002,0x00040015,0x0000001b,0x00000020,
+	0x00000001,0x0004002b,0x0000001b,0x0000001c,0x00000000,0x00040020,0x0000001f,0x00000002,
+	0x00000006,0x0004002b,0x00000006,0x00000022,0x00000001,0x0006002c,0x00000009,0x00000025,
+	0x00000022,0x00000022,0x00000022,0x00050036,0x00000002,0x00000004,0x00000000,0x00000003,
+	0x000200f8,0x00000005,0x0004003b,0x00000007,0x00000008,0x00000007,0x00050041,0x0000000d,
+	0x0000000e,0x0000000b,0x0000000c,0x0004003d,0x00000006,0x0000000f,0x0000000e,0x0003003e,
+	0x00000008,0x0000000f,0x0004003d,0x00000006,0x00000010,0x00000008,0x000500ae,0x00000012,
+	0x00000013,0x00000010,0x00000011,0x000300f7,0x00000015,0x00000000,0x000400fa,0x00000013,
+	0x00000014,0x00000015,0x000200f8,0x00000014,0x000100fd,0x000200f8,0x00000015,0x0004003d,
+	0x00000006,0x0000001d,0x00000008,0x0004003d,0x00000006,0x0000001e,0x00000008,0x00060041,
+	0x0000001f,0x00000020,0x0000001a,0x0000001c,0x0000001e,0x0004003d,0x00000006,0x00000021,
+	0x00000020,0x00050080,0x00000006,0x00000023,0x00000021,0x00000022,0x00060041,0x0000001f,
+	0x00000024,0x0000001a,0x0000001c,0x0000001d,0x0003003e,0x00000024,0x00000023,0x000100fd,
+	0x00010038
diff --git a/vkpreemption/main.cpp b/vkpreemption/main.cpp
new file mode 100644
index 00000000..ded4bfa9
--- /dev/null
+++ b/vkpreemption/main.cpp
@@ -0,0 +1,385 @@
+/*
+ * *
+ * * Copyright (C) 2020 Samsung Electronics
+ * *
+ * */
+
+#include "base.hpp"
+#include "computework.hpp"
+#include "graphicwork.hpp"
+
+#include <sys/stat.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/un.h>
+
+#include <unordered_map>
+
+#include <regex>
+#include <chrono>
+#include <numeric>
+#include <algorithm>
+#include <thread>
+
+#include<stdio.h>
+#include<stdlib.h>
+#include<unistd.h>
+#include<string.h>
+#include<sys/types.h>
+#include<sys/msg.h>
+#include<sys/ipc.h>
+#include<errno.h>
+
+#define RUN_TIMES 5
+class Request {
+
+    VkQueueGlobalPriorityEXT str2priority(const std::string& str) {
+        static const std::unordered_map<std::string, VkQueueGlobalPriorityEXT> map = {
+            {"low", VK_QUEUE_GLOBAL_PRIORITY_LOW_EXT},
+            {"medium", VK_QUEUE_GLOBAL_PRIORITY_MEDIUM_EXT},
+            {"high", VK_QUEUE_GLOBAL_PRIORITY_HIGH_EXT},
+            {"realtime", VK_QUEUE_GLOBAL_PRIORITY_REALTIME_EXT}
+        };
+
+        auto it = map.find(str);
+        if (it == map.end()) {
+            LOG("%s is not a valid priority. Use low, medium or high\n", str.c_str());
+            return VK_QUEUE_GLOBAL_PRIORITY_MAX_ENUM_EXT;
+        } else {
+            return it->second;
+        }
+    }
+
+
+public:
+    enum class Type {
+        Graphics,
+        Compute
+    };
+
+    unsigned m_commandCount;
+    VkQueueGlobalPriorityEXT m_priority;
+    std::chrono::microseconds m_delay = std::chrono::microseconds::zero();
+    Type m_type;
+    Workload* m_workload = nullptr;
+
+    Request(char* str)
+    {
+        const std::regex regex_graphic("gfx=draws:([0-9]+),priority:(low|medium|high),delay:([0-9]+)");
+        const std::regex regex_compute("compute=dispatch:([0-9]+),priority:(low|medium|high|realtime),delay:([0-9]+)");
+
+        std::cmatch m;
+
+        if (std::regex_match(str, m, regex_graphic)) {
+            m_type = Type::Graphics;
+            m_commandCount = stoi(m[1]);
+            m_priority = str2priority(m[2]);
+            m_delay = std::chrono::microseconds(std::stoi(m[3]));
+        } else if (std::regex_match(str, m, regex_compute)) {
+            m_type = Type::Compute;
+            m_commandCount = stoi(m[1]);
+            m_priority = str2priority(m[2]);
+            m_delay = std::chrono::microseconds(std::stoi(m[3]));
+        } else {
+            LOG("Could not parse \'%s\'", str);
+            exit(-1);
+        }
+        LOG("Request : commands %d, priority %d, delay %lld\n", m_commandCount, m_priority, m_delay.count());
+    }
+
+    ~Request() {
+        if (m_workload != nullptr) {
+            delete(m_workload);
+        }
+    }
+
+    VkQueueFlagBits vkQueueFlag() {
+        switch(m_type) {
+            case Type::Graphics: return VK_QUEUE_GRAPHICS_BIT;
+            case Type::Compute : return VK_QUEUE_COMPUTE_BIT;
+        }
+	return VK_QUEUE_FLAG_BITS_MAX_ENUM;
+    }
+
+    Workload* createWorkload(Base& base, QueueInfo queue, unsigned commandCount) {
+        switch(m_type) {
+            case Type::Graphics: return new GraphicsWork(base, queue, commandCount);
+            case Type::Compute : return new ComputeWork(base, queue, commandCount);
+        }
+	return nullptr;
+    }
+
+    void init(Base& base) {
+        auto queue = base.GetQueueInfo(vkQueueFlag(), m_priority);
+        m_workload = createWorkload(base, queue, m_commandCount);
+    }
+
+    void queryTimestamp(uint64_t time_stamp[], int count) {
+        m_workload->queryTimestamp(time_stamp, count);
+    }
+
+    void waitIdle() {
+        m_workload->waitIdle();
+    }
+
+    VkFence submit(Base& base) {
+        return m_workload->submit();
+    }
+
+    static std::vector<Request> rearrangeDelays(std::vector<Request> requests) {
+        // Sort the vector in ascending order of delays
+        std::sort(requests.begin(), requests.end(), [](Request a, Request b) { return a.m_delay < b.m_delay; });
+
+        // The delays do not compound, so subtract the previous one from the current
+        auto previous = std::chrono::microseconds::zero();
+        std::cout << "Delays : " << std::endl;
+        for (auto& request : requests) {
+            std::cout << request.m_delay.count();
+            request.m_delay -= previous;
+            std::cout << " -> " << request.m_delay.count() << std::endl;
+            previous = request.m_delay;
+        }
+
+        return requests;
+    }
+};
+
+#define SOCKET_PATH "/tmp/mysocket"
+#define IPC_KEY 0x12345678
+#define TYPE_S 1
+#define TYPE_C 2
+
+struct msgbuff{
+  long mtype;
+  char mtext[512];
+  uint64_t time_stamp[RUN_TIMES * 2];
+};
+
+struct timespec ts;
+struct timespec ts1;
+struct timespec ts2;
+int clifd = -1;
+
+int server()
+{
+    int servfd;
+    int ret;
+
+    servfd = socket(AF_LOCAL,SOCK_STREAM,0);
+    if(-1 == servfd)
+    {
+        perror("Can not create socket");
+        return -1;
+    }
+
+    struct sockaddr_un servaddr;
+    bzero(&servaddr, sizeof(servaddr));
+    strcpy(servaddr.sun_path+1, SOCKET_PATH);
+    servaddr.sun_family = AF_LOCAL;
+    socklen_t addrlen = 1 + strlen(SOCKET_PATH) + sizeof(servaddr.sun_family);
+
+    ret = bind(servfd, (struct sockaddr *)&servaddr, addrlen);
+    if(-1 == ret)
+    {
+        perror("bind failed");
+        return -1;
+    }
+
+    ret = listen(servfd, 100);
+    if(-1 == ret)
+    {
+        perror("listen failed");
+        return -1;
+    }
+
+    pthread_t tid;
+    struct sockaddr_un cliaddr;
+
+    printf("Wait for client connect \n");
+    memset(&cliaddr,0,sizeof(cliaddr));
+    clifd = accept(servfd,(struct sockaddr *)&cliaddr,&addrlen);
+    if(clifd == -1)
+    {
+        printf("accept connect failed\n");
+        return -1;
+    }
+    printf("Accept connect success\n");
+
+    char getData[100];
+    bzero(&getData,sizeof(getData));
+    ret = read(clifd,&getData,sizeof(getData));
+    if(ret > 0)
+    {
+        printf("Receive message: %s", getData);
+    }
+
+    return 0;
+}
+
+int client()
+{
+    int ret;
+
+    clifd = socket(AF_LOCAL, SOCK_STREAM, 0);
+    if(-1 == clifd)
+    {
+        perror("socket create failed\n");
+        return -1;
+    }
+
+    struct sockaddr_un cileddr;
+    bzero(&cileddr, sizeof(cileddr));
+    strcpy(cileddr.sun_path + 1, SOCKET_PATH);
+    cileddr.sun_family = AF_LOCAL;
+    socklen_t addrlen = sizeof(cileddr.sun_family) + strlen(SOCKET_PATH) + 1;
+
+    ret = connect(clifd, (struct sockaddr *)&cileddr, addrlen);
+    if(ret == -1) {
+        perror("Connect fail\n");
+        return -1;
+    }
+    const char *s = std::string("hello\n").c_str();
+    send(clifd,s,strlen(s),0);
+    printf("Client: send hello to server\n");
+    return 0;
+}
+
+uint64_t toTime(timespec ts){
+    return ts.tv_sec * 1000000000 + ts.tv_nsec;
+}
+
+int gfx(std::vector<Request> &requests, bool isServer) {
+    std::vector<VkQueueGlobalPriorityEXT> graphic_priorities;
+    std::vector<VkQueueGlobalPriorityEXT> compute_priorities;
+    Request& request = requests.back();
+
+    switch(request.m_type) {
+        case Request::Type::Graphics: graphic_priorities.push_back(request.m_priority); break;
+        case Request::Type::Compute : compute_priorities.push_back(request.m_priority); break;
+    }
+
+    Base base(graphic_priorities, compute_priorities);
+
+    printf("Waiting %lld us ... \n", request.m_delay.count());
+    fflush(stdout);
+    std::this_thread::sleep_for(request.m_delay);
+
+    int msgid = -1;
+
+    int i, j;
+
+    struct msgbuff buf;
+    memset(&buf, 0x00, sizeof(struct msgbuff));
+
+
+    if (isServer)
+    {
+        msgid = server();
+        if(msgid < 0)
+        {
+            perror("Server: msgget error");
+            exit(-1);
+        }
+    }
+    else {
+        msgid = client();
+        if(msgid < 0)
+        {
+            perror("Client: error , please start server first\n");
+            //exit(-1);
+        }
+    }
+
+    clock_gettime(CLOCK_MONOTONIC, &ts);
+
+    if (isServer)
+    {
+        printf("Server: start submission time: <%ld.%ld>\n",ts.tv_sec,ts.tv_nsec);
+    }
+    else
+    {
+        printf("Client: start submission time: <%ld.%ld>\n",ts.tv_sec,ts.tv_nsec);
+    }
+
+
+    uint64_t time_stamp[RUN_TIMES * 2];
+
+
+    std::vector<VkFence> fences;
+
+    for (i = 0; i < RUN_TIMES; i++) {
+
+        fences.clear();
+        clock_gettime(CLOCK_MONOTONIC, &ts1);
+
+        printf("pid %d running: %d \n", getpid(), i);
+        for (j = 0; j < 2; j++) {
+            request.init(base);
+            fflush(stdout);
+            fences.push_back(request.submit(base));
+        }
+
+        VK_CHECK_RESULT(vkWaitForFences(base.GetDevice(), fences.size(), fences.data(), VK_TRUE, UINT64_MAX));
+        clock_gettime(CLOCK_MONOTONIC, &ts2);
+        time_stamp[i * 2] = toTime(ts1);
+        time_stamp[i * 2 + 1] = toTime(ts2);
+
+    }
+
+
+    if (isServer)
+    {
+        int ret;
+        memset(&buf, 0x00, sizeof(struct msgbuff));
+        ret = read(clifd, &buf, sizeof(buf));
+        if(ret > 0)
+        {
+            printf("Receive message: client %s\n", buf.mtext);
+        }
+
+        for (i = 0; i < RUN_TIMES; i++) {
+            if (request.m_priority >= VK_QUEUE_GLOBAL_PRIORITY_HIGH_EXT
+                    && buf.time_stamp[i * 2] < time_stamp[i * 2]
+                    && buf.time_stamp[i * 2 + 1] > time_stamp[i * 2 + 1]) {
+                printf("success on(%d) high:%ld low: %ld\n",i,  time_stamp[i * 2 + 1] - time_stamp[i * 2],
+                    (buf.time_stamp[i * 2 + 1] - buf.time_stamp[i * 2]));
+                break;
+            }
+        }
+        if (i == RUN_TIMES) {
+            printf("****************************FAIL****************************\n");
+        }
+    }
+    else
+    {
+        int ret;
+        memset(&buf, 0x00, sizeof(struct msgbuff));
+        memcpy(buf.time_stamp, time_stamp, sizeof(time_stamp));
+        strcpy(buf.mtext, "gpu timestamp");
+        send(clifd, &buf, sizeof(buf), 0);
+        for (i = 0; i < RUN_TIMES; i++) {
+            printf("Client: gpu timestamp %lu %lu total:%ld\n", buf.time_stamp[i * 2],
+                buf.time_stamp[i * 2 + 1], (time_stamp[i * 2 + 1] - time_stamp[i * 2]));
+        }
+    }
+
+    request.waitIdle();
+
+    return 0;
+}
+
+int main(int argc, char *argv[]) {
+    std::vector<Request> requests;
+    // argv[1] must be used to specify client/server/ace mode
+    if (strcmp(argv[1], "s") && strcmp(argv[1], "c"))
+    {
+        fprintf(stderr,
+            "The first parameter must be specifying if it's client (c) or server (s) mode?\n");
+        exit(-1);
+    }
+
+    requests.emplace_back(argv[2]);
+    gfx(requests, !strcmp(argv[1], "s"));
+
+    return 0;
+}
diff --git a/vkpreemption/triangle.frag b/vkpreemption/triangle.frag
new file mode 100644
index 00000000..92e74502
--- /dev/null
+++ b/vkpreemption/triangle.frag
@@ -0,0 +1,10 @@
+#version 450
+
+layout (location = 0) in vec3 inColor;
+
+layout (location = 0) out vec4 outFragColor;
+
+void main()
+{
+  outFragColor = vec4(inColor, 1.0);
+}
\ No newline at end of file
diff --git a/vkpreemption/triangle.frag.glsl b/vkpreemption/triangle.frag.glsl
new file mode 100644
index 00000000..92e74502
--- /dev/null
+++ b/vkpreemption/triangle.frag.glsl
@@ -0,0 +1,10 @@
+#version 450
+
+layout (location = 0) in vec3 inColor;
+
+layout (location = 0) out vec4 outFragColor;
+
+void main()
+{
+  outFragColor = vec4(inColor, 1.0);
+}
\ No newline at end of file
diff --git a/vkpreemption/triangle.frag.inc b/vkpreemption/triangle.frag.inc
new file mode 100644
index 00000000..b382d48a
--- /dev/null
+++ b/vkpreemption/triangle.frag.inc
@@ -0,0 +1,17 @@
+	// 8.13.3727
+	0x07230203,0x00010000,0x00080008,0x00000013,0x00000000,0x00020011,0x00000001,0x0006000b,
+	0x00000001,0x4c534c47,0x6474732e,0x3035342e,0x00000000,0x0003000e,0x00000000,0x00000001,
+	0x0007000f,0x00000004,0x00000004,0x6e69616d,0x00000000,0x00000009,0x0000000c,0x00030010,
+	0x00000004,0x00000007,0x00030003,0x00000002,0x000001c2,0x00040005,0x00000004,0x6e69616d,
+	0x00000000,0x00060005,0x00000009,0x4674756f,0x43676172,0x726f6c6f,0x00000000,0x00040005,
+	0x0000000c,0x6f436e69,0x00726f6c,0x00040047,0x00000009,0x0000001e,0x00000000,0x00040047,
+	0x0000000c,0x0000001e,0x00000000,0x00020013,0x00000002,0x00030021,0x00000003,0x00000002,
+	0x00030016,0x00000006,0x00000020,0x00040017,0x00000007,0x00000006,0x00000004,0x00040020,
+	0x00000008,0x00000003,0x00000007,0x0004003b,0x00000008,0x00000009,0x00000003,0x00040017,
+	0x0000000a,0x00000006,0x00000003,0x00040020,0x0000000b,0x00000001,0x0000000a,0x0004003b,
+	0x0000000b,0x0000000c,0x00000001,0x0004002b,0x00000006,0x0000000e,0x3f800000,0x00050036,
+	0x00000002,0x00000004,0x00000000,0x00000003,0x000200f8,0x00000005,0x0004003d,0x0000000a,
+	0x0000000d,0x0000000c,0x00050051,0x00000006,0x0000000f,0x0000000d,0x00000000,0x00050051,
+	0x00000006,0x00000010,0x0000000d,0x00000001,0x00050051,0x00000006,0x00000011,0x0000000d,
+	0x00000002,0x00070050,0x00000007,0x00000012,0x0000000f,0x00000010,0x00000011,0x0000000e,
+	0x0003003e,0x00000009,0x00000012,0x000100fd,0x00010038
diff --git a/vkpreemption/triangle.vert b/vkpreemption/triangle.vert
new file mode 100644
index 00000000..b74ed3ec
--- /dev/null
+++ b/vkpreemption/triangle.vert
@@ -0,0 +1,20 @@
+#version 450
+
+layout (location = 0) in vec3 inPos;
+layout (location = 1) in vec3 inColor;
+
+layout (location = 0) out vec3 outColor;
+
+out gl_PerVertex {
+	vec4 gl_Position;
+};
+
+layout(push_constant) uniform PushConsts {
+	mat4 mvp;
+} pushConsts;
+
+void main()
+{
+	outColor = inColor;
+	gl_Position = pushConsts.mvp * vec4(inPos.xyz, 1.0);
+}
diff --git a/vkpreemption/triangle.vert.glsl b/vkpreemption/triangle.vert.glsl
new file mode 100644
index 00000000..b74ed3ec
--- /dev/null
+++ b/vkpreemption/triangle.vert.glsl
@@ -0,0 +1,20 @@
+#version 450
+
+layout (location = 0) in vec3 inPos;
+layout (location = 1) in vec3 inColor;
+
+layout (location = 0) out vec3 outColor;
+
+out gl_PerVertex {
+	vec4 gl_Position;
+};
+
+layout(push_constant) uniform PushConsts {
+	mat4 mvp;
+} pushConsts;
+
+void main()
+{
+	outColor = inColor;
+	gl_Position = pushConsts.mvp * vec4(inPos.xyz, 1.0);
+}
diff --git a/vkpreemption/triangle.vert.inc b/vkpreemption/triangle.vert.inc
new file mode 100644
index 00000000..91d00ba5
--- /dev/null
+++ b/vkpreemption/triangle.vert.inc
@@ -0,0 +1,34 @@
+	// 8.13.3727
+	0x07230203,0x00010000,0x00080008,0x00000024,0x00000000,0x00020011,0x00000001,0x0006000b,
+	0x00000001,0x4c534c47,0x6474732e,0x3035342e,0x00000000,0x0003000e,0x00000000,0x00000001,
+	0x0009000f,0x00000000,0x00000004,0x6e69616d,0x00000000,0x00000009,0x0000000b,0x00000010,
+	0x0000001a,0x00030003,0x00000002,0x000001c2,0x00040005,0x00000004,0x6e69616d,0x00000000,
+	0x00050005,0x00000009,0x4374756f,0x726f6c6f,0x00000000,0x00040005,0x0000000b,0x6f436e69,
+	0x00726f6c,0x00060005,0x0000000e,0x505f6c67,0x65567265,0x78657472,0x00000000,0x00060006,
+	0x0000000e,0x00000000,0x505f6c67,0x7469736f,0x006e6f69,0x00030005,0x00000010,0x00000000,
+	0x00050005,0x00000014,0x68737550,0x736e6f43,0x00007374,0x00040006,0x00000014,0x00000000,
+	0x0070766d,0x00050005,0x00000016,0x68737570,0x736e6f43,0x00007374,0x00040005,0x0000001a,
+	0x6f506e69,0x00000073,0x00040047,0x00000009,0x0000001e,0x00000000,0x00040047,0x0000000b,
+	0x0000001e,0x00000001,0x00050048,0x0000000e,0x00000000,0x0000000b,0x00000000,0x00030047,
+	0x0000000e,0x00000002,0x00040048,0x00000014,0x00000000,0x00000005,0x00050048,0x00000014,
+	0x00000000,0x00000023,0x00000000,0x00050048,0x00000014,0x00000000,0x00000007,0x00000010,
+	0x00030047,0x00000014,0x00000002,0x00040047,0x0000001a,0x0000001e,0x00000000,0x00020013,
+	0x00000002,0x00030021,0x00000003,0x00000002,0x00030016,0x00000006,0x00000020,0x00040017,
+	0x00000007,0x00000006,0x00000003,0x00040020,0x00000008,0x00000003,0x00000007,0x0004003b,
+	0x00000008,0x00000009,0x00000003,0x00040020,0x0000000a,0x00000001,0x00000007,0x0004003b,
+	0x0000000a,0x0000000b,0x00000001,0x00040017,0x0000000d,0x00000006,0x00000004,0x0003001e,
+	0x0000000e,0x0000000d,0x00040020,0x0000000f,0x00000003,0x0000000e,0x0004003b,0x0000000f,
+	0x00000010,0x00000003,0x00040015,0x00000011,0x00000020,0x00000001,0x0004002b,0x00000011,
+	0x00000012,0x00000000,0x00040018,0x00000013,0x0000000d,0x00000004,0x0003001e,0x00000014,
+	0x00000013,0x00040020,0x00000015,0x00000009,0x00000014,0x0004003b,0x00000015,0x00000016,
+	0x00000009,0x00040020,0x00000017,0x00000009,0x00000013,0x0004003b,0x0000000a,0x0000001a,
+	0x00000001,0x0004002b,0x00000006,0x0000001c,0x3f800000,0x00040020,0x00000022,0x00000003,
+	0x0000000d,0x00050036,0x00000002,0x00000004,0x00000000,0x00000003,0x000200f8,0x00000005,
+	0x0004003d,0x00000007,0x0000000c,0x0000000b,0x0003003e,0x00000009,0x0000000c,0x00050041,
+	0x00000017,0x00000018,0x00000016,0x00000012,0x0004003d,0x00000013,0x00000019,0x00000018,
+	0x0004003d,0x00000007,0x0000001b,0x0000001a,0x00050051,0x00000006,0x0000001d,0x0000001b,
+	0x00000000,0x00050051,0x00000006,0x0000001e,0x0000001b,0x00000001,0x00050051,0x00000006,
+	0x0000001f,0x0000001b,0x00000002,0x00070050,0x0000000d,0x00000020,0x0000001d,0x0000001e,
+	0x0000001f,0x0000001c,0x00050091,0x0000000d,0x00000021,0x00000019,0x00000020,0x00050041,
+	0x00000022,0x00000023,0x00000010,0x00000012,0x0003003e,0x00000023,0x00000021,0x000100fd,
+	0x00010038
diff --git a/vkpreemption/vk_amd_dispatch_tunnel.h b/vkpreemption/vk_amd_dispatch_tunnel.h
new file mode 100644
index 00000000..4246d1ad
--- /dev/null
+++ b/vkpreemption/vk_amd_dispatch_tunnel.h
@@ -0,0 +1,34 @@
+/*
+ ******************************************************************************
+ *
+ *  Trade secret of Advanced Micro Devices, Inc.
+ *  Copyright (c) 2014-2019, Advanced Micro Devices, Inc., (unpublished)
+ *
+ *  All rights reserved. This notice is intended as a precaution against
+ *  inadvertent publication and does not imply
+ *  publication or any waiver of confidentiality. The year included in the
+ *  foregoing notice is the year of creation of the work.
+ *
+ *****************************************************************************/
+#ifndef VK_AMD_DISPATCH_TUNNEL_H_
+#define VK_AMD_DISPATCH_TUNNEL_H_
+
+#include "vk_internal_ext_helper.h"
+
+#define VK_AMD_DISPATCH_TUNNEL                             1
+#define VK_AMD_DISPATCH_TUNNEL_SPEC_VERSION                1
+#define VK_AMD_DISPATCH_TUNNEL_EXTENSION_NAME              "VK_AMD_dispatch_tunnel"
+#define VK_AMD_DISPATCH_TUNNEL_EXTENSION_NUMBER            318
+
+#define VK_AMD_DISPATCH_TUNNEL_ENUM(type, offset) \
+	VK_EXTENSION_ENUM(VK_AMD_DISPATCH_TUNNEL_EXTENSION_NUMBER, type, offset)
+
+typedef struct VkDispatchTunnelInfoEXT {
+	VkStructureType	sType;
+	const void	*pNext;
+	bool		dispatchTunneling;
+} VkDispatchTunnelInfoEXT;
+
+#define VK_STRUCTURE_TYPE_DISPATCH_TUNNEL_INFO_AMD \
+	VK_AMD_DISPATCH_TUNNEL_ENUM(VkStructureType, 0)
+#endif /* VK_AMD_DISPATCH_TUNNEL_H_ */
diff --git a/vkpreemption/vk_internal_ext_helper.h b/vkpreemption/vk_internal_ext_helper.h
new file mode 100644
index 00000000..7f4bb3d2
--- /dev/null
+++ b/vkpreemption/vk_internal_ext_helper.h
@@ -0,0 +1,33 @@
+/*
+ ******************************************************************************
+ *
+ *  Trade secret of Advanced Micro Devices, Inc.
+ *  Copyright (c) 2014-2015, Advanced Micro Devices, Inc., (unpublished)
+ *
+ *  All rights reserved. This notice is intended as a precaution against
+ *  inadvertent publication and does not imply publication or any waiver
+ *  of confidentiality. The year included in the foregoing notice is the
+ *  year of creation of the work.
+ *
+ ******************************************************************************
+/**
+ ******************************************************************************
+ * @file  vk_internal_ext_helper.h
+ * @brief Helper header for unpublished extensions.
+ ******************************************************************************
+ */
+
+#ifndef VK_INTERNAL_EXT_HELPER_H_
+#define VK_INTERNAL_EXT_HELPER_H_
+
+#define VK_EXTENSION_ENUM_BASE_VALUE        1000000000ull
+#define VK_EXTENSION_ENUM_RANGE_SIZE        1000ull
+
+#define VK_EXTENSION_ENUM(extnr, type, offset) \
+	((type)(VK_EXTENSION_ENUM_BASE_VALUE + (((extnr)-1) * \
+	VK_EXTENSION_ENUM_RANGE_SIZE) + (offset)))
+
+#define VK_EXTENSION_BIT(type, bit) \
+	((type)(1 << (bit)))
+
+#endif /* VK_INTERNAL_EXT_HELPER_H_ */
-- 
2.25.1

