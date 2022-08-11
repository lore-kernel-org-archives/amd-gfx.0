Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31AFC25B0C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 15:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E33B4837;
	Thu, 11 Aug 2022 15:48:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77EAB9C969
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 15:48:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjF4yDqUvflw47/wAqnOLgnRf5ecWOhJovsNykH7GVKkNDN3CCyC8nXTsj4fw7ANLLmHg+i0rYUydSv9XdpQ56E36VxP4Fbd37kZD/iVXYSrVO8YOVC6GNZxlIxdbMiQ86VBLx+TdgrTRlqFdSTsO4IPBHhHc5qF/bK3VAW5fwHujif8q4p8RALB44s71SgJRLMl+envhd+aR17He7Q2Ds2mo0tf6eXmQhlZ0MjHeXrcXh+MzcPKbLeQ31xerv5NRip0mo3L0OxmXm6+JT2X1g5OKw3EnIUD64JCxyx0dZtQt0WvQEpPTYqpQLLQ+HcT9so+PHQwTAGF2rU3LYYRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWfTK3YwGjPYv6X32mIy9Ozgbe5h96PWKEjjKqtCAdo=;
 b=E8Ir9MweMPe2YqMhxEsFxdjob1lYzBxIaEH6GkgO71Iwwy92zgCOD0ZNEWYpPrM741cqKplElqihdDLJUtAZn+tQJxVk5SDuucGUWFnGuOz1ttT092rM/ldDVs8U20j0G/mJC9S4S0I67c20DU1oGZK0wH7otlo1kz0iPkaHrKLgsGP1dpjsksA/UUkUqPoLTv/Z17bip+RSD8f5Zx5x0s0tCRPpKt3XoUbW3GrdAO0ubDZR3/+A4Y9aQ0j8CxupWZ84k68o1zIHLhP5Ud3Ve8rQ3QR9v7m9iOBLkQBWsaXLG9ccMz54zccte4kca+6OLOtgkMsSoUMkkIHzpirrvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWfTK3YwGjPYv6X32mIy9Ozgbe5h96PWKEjjKqtCAdo=;
 b=Rdj6RxDrXcNYci7qD4k/btCWRHvDr8LDQTeDmN1Lw1or1byBtcBVZyJaxZwVTg2f0pp9AtZrPejpiaFJvpXP0AK1b8z4hWdCV/hx+54i0hK4SWYeui7CyZK7IN5oMltifEJ1oWwxpNTMEgYLew7gOjoabg+wAtJ6IN87r7YOvYY=
Received: from BN9PR03CA0389.namprd03.prod.outlook.com (2603:10b6:408:f7::34)
 by DM5PR12MB1338.namprd12.prod.outlook.com (2603:10b6:3:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 11 Aug
 2022 15:48:42 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::bf) by BN9PR03CA0389.outlook.office365.com
 (2603:10b6:408:f7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Thu, 11 Aug 2022 15:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 15:48:41 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 10:48:36 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] Documentation/gpu: Add an explanation about the DCN
 pipeline
Date: Thu, 11 Aug 2022 11:48:18 -0400
Message-ID: <20220811154819.3566210-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811154819.3566210-1-Rodrigo.Siqueira@amd.com>
References: <20220811154819.3566210-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 590d5260-a1f5-48a7-2255-08da7bb0f74a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1338:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39jkXHEwD3Y4jGB8qhVkJUKEqOwNiecILEqpu4EcdNmdYXi1VdfOn5tTZr4B6ZfoipuwohJIvN3JFsP8Xdrd29qpzW/qFkYFm7XnUi9QsggWzrBvjZ/VFv2l5areL28qOjdx9YGbGGPyQByW1jWPhrSvBanTvIYVA6oJXJc1JgQwSZaXV4yN1FGT7xrkBPf/wus0vxh1WDU8UYx7WXEMBkk62L740I+Qe50iaRidSj0ZtR19ezPIzi08Wav+ObaPhDUxzOPrU79Y5j4KJMZtcodDar+arbyBGmf/QVBqgsAPuYjMfE0+ymIQgI65ChzPRNw0p4AnegFPCPNYQH20NTfosvLRUorP+utNaTYcI6s1m58PYsmEyKZFj5H2R6yQw1AbFroNj8RjrDaFlnM4B2ker8xWNp1+PZAOx7POTKelmBlSzKSjyGWDepLll7HQ7tYY8qdrl6syUPpAbdebFnKU7YqJwxPv77uVMuH5SQ6UDVcHvy3hVAvm5G6PV/MIj/zFiwj7flTpaReDgDIvVFG4yLKE+dLLYaI4heyHSyHsLjVzesXgZ9qCM8Lyj4fczORgUfKKNbEyNHX3sZJxkc/sp/7n50T3IaycAX5x+i3O+k6stCTl+76NAyIAJcFpGfAEz2dNHhtU2OhA/cdR47d00rXJFwQd/IaimP0SEHMKDkrh0O3dknoeoRlkMJoPRpRxNsbccL5TVT2JxAhmYu1jmPNcBYnFgnV/x5HfWyouWhhb+98H5+XSP3KKdhIFumRbe6ykzsfydmlafyBMqlvS0f8FX2aWoEi/umhpVdhIh9D6bhg7Fk4UH+WHc3978uXxWoNv/ZvPdbQ06Y+BQD0j8cyY7GrIpTSXzt90H9OppLtKSBHtowY8PBJgOwurtVloXWQAEyldy41Njwg3YA/MfmiuCbkddUCPkOrTZ7I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(396003)(36840700001)(46966006)(40470700004)(316002)(5660300002)(8936002)(478600001)(54906003)(6916009)(7696005)(30864003)(41300700001)(186003)(336012)(16526019)(36756003)(2906002)(6666004)(426003)(1076003)(2616005)(47076005)(66574015)(26005)(81166007)(19273905006)(356005)(86362001)(40460700003)(83380400001)(36860700001)(40480700001)(8676002)(4326008)(70586007)(70206006)(82740400003)(82310400005)(36900700001)(579004)(559001)(563064011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 15:48:41.9012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 590d5260-a1f5-48a7-2255-08da7bb0f74a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1338
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Mark
 Yacoub <markyacoub@chromium.org>, Pekka Paalanen <pekka.paalanen@collabora.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Simon Ser <contact@emersion.fr>, Sean Paul <seanpaul@chromium.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the DCN code, we constantly talk about hardware pipeline, pipeline,
or even just pipes, which is a concept that is not obvious to everyone.
For this reason, this commit expands the DCN overview explanation by
adding a new section that describes what a pipeline is from the DCN
perspective.

Changes since V1:
- Rewrite the first paragraph that describes AMD hardware pipeline.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Mark Yacoub <markyacoub@chromium.org>
Cc: Pierre-Loup <pgriffais@valvesoftware.com>
Cc: Michel Dänzer <michel.daenzer@mailbox.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/amdgpu/display/dcn-overview.rst       |   59 +
 .../amdgpu/display/pipeline_4k_no_split.svg   |  958 +++++++++++++++
 .../gpu/amdgpu/display/pipeline_4k_split.svg  | 1062 +++++++++++++++++
 3 files changed, 2079 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/display/pipeline_4k_no_split.svg
 create mode 100644 Documentation/gpu/amdgpu/display/pipeline_4k_split.svg

diff --git a/Documentation/gpu/amdgpu/display/dcn-overview.rst b/Documentation/gpu/amdgpu/display/dcn-overview.rst
index f98624d7828e..9fea6500448b 100644
--- a/Documentation/gpu/amdgpu/display/dcn-overview.rst
+++ b/Documentation/gpu/amdgpu/display/dcn-overview.rst
@@ -124,6 +124,65 @@ depth format), bit-depth reduction/dithering would kick in. In OPP, we would
 also apply a regamma function to introduce the gamma removed earlier back.
 Eventually, we output data in integer format at DIO.
 
+AMD Hardware Pipeline
+---------------------
+
+When discussing graphics on Linux, the **pipeline** term can sometimes be
+overloaded with multiple meanings, so it is important to define what we mean
+when we say **pipeline**. In the DCN driver, we use the term **hardware
+pipeline** or **pipeline** or just **pipe** as an abstraction to indicate a
+sequence of DCN blocks instantiated to address some specific configuration. DC
+core treats DCN blocks as individual resources, meaning we can build a pipeline
+by taking resources for all individual hardware blocks to compose one pipeline.
+In actuality, we can't connect an arbitrary block from one pipe to a block from
+another pipe; they are routed linearly, except for DSC, which can be
+arbitrarily assigned as needed. We have this pipeline concept for trying to
+optimize bandwidth utilization.
+
+.. kernel-figure:: pipeline_4k_no_split.svg
+
+Additionally, let's take a look at parts of the DTN log (see
+'Documentation/gpu/amdgpu/display/dc-debug.rst' for more information) since
+this log can help us to see part of this pipeline behavior in real-time::
+
+ HUBP:  format  addr_hi  width  height ...
+ [ 0]:      8h      81h   3840    2160
+ [ 1]:      0h       0h      0       0
+ [ 2]:      0h       0h      0       0
+ [ 3]:      0h       0h      0       0
+ [ 4]:      0h       0h      0       0
+ ...
+ MPCC:  OPP  DPP ...
+ [ 0]:   0h   0h ...
+
+The first thing to notice from the diagram and DTN log it is the fact that we
+have different clock domains for each part of the DCN blocks. In this example,
+we have just a single **pipeline** where the data flows from DCHUB to DIO, as
+we intuitively expect. Nonetheless, DCN is flexible, as mentioned before, and
+we can split this single pipe differently, as described in the below diagram:
+
+.. kernel-figure:: pipeline_4k_split.svg
+
+Now, if we inspect the DTN log again we can see some interesting changes::
+
+ HUBP:  format  addr_hi  width  height ...
+ [ 0]:      8h      81h   1920    2160 ...
+ ...
+ [ 4]:      0h       0h      0       0 ...
+ [ 5]:      8h      81h   1920    2160 ...
+ ...
+ MPCC:  OPP  DPP ...
+ [ 0]:   0h   0h ...
+ [ 5]:   0h   5h ...
+
+From the above example, we now split the display pipeline into two vertical
+parts of 1920x2160 (i.e., 3440x2160), and as a result, we could reduce the
+clock frequency in the DPP part. This is not only useful for saving power but
+also to better handle the required throughput. The idea to keep in mind here is
+that the pipe configuration can vary a lot according to the display
+configuration, and it is the DML's responsibility to set up all required
+configuration parameters for multiple scenarios supported by our hardware.
+
 Global Sync
 -----------
 
diff --git a/Documentation/gpu/amdgpu/display/pipeline_4k_no_split.svg b/Documentation/gpu/amdgpu/display/pipeline_4k_no_split.svg
new file mode 100644
index 000000000000..5fa289d99fcd
--- /dev/null
+++ b/Documentation/gpu/amdgpu/display/pipeline_4k_no_split.svg
@@ -0,0 +1,958 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   xmlns:dc="http://purl.org/dc/elements/1.1/"
+   xmlns:cc="http://creativecommons.org/ns#"
+   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
+   xmlns:svg="http://www.w3.org/2000/svg"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   width="1055.4928"
+   height="404.60379"
+   viewBox="0 0 279.26579 107.05142"
+   version="1.1"
+   id="svg8"
+   inkscape:version="0.92.5 (2060ec1f9f, 2020-04-08)"
+   sodipodi:docname="pipeline_4k_no_split.svg">
+  <defs
+     id="defs2">
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="marker8858"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path8616"
+         style="fill:#aa00d4;fill-opacity:1;fill-rule:evenodd;stroke:#aa00d4;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Send"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Send"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path8622"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="matrix(-0.3,0,0,-0.3,0.69,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Lend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Lend"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path8592"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:1.00000003pt;stroke-opacity:1"
+         transform="matrix(-0.8,0,0,-0.8,-10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Lend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Lend"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path8610"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="matrix(-1.1,0,0,-1.1,-1.1,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-3"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-6"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-3-2"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-6-9"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-3-2-1"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-6-9-9"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-3-2-7"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-6-9-8"
+         style="fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-3-4"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-6-5"
+         style="fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-0"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-3"
+         style="fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-6"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-1"
+         style="fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-3-2-6"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-6-9-1"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-0-7"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-3-4"
+         style="fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-6-3"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-1-0"
+         style="fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-3-2-8"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-6-9-6"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-3"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-6"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="marker8858-3"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path8616-5"
+         style="fill:#00ffcc;fill-opacity:1;fill-rule:evenodd;stroke:#00ffcc;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-3-3"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-6-56"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-0-2"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-3-9"
+         style="fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-9"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-3"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94-6"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7-9"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94-6-7"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7-9-4"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94-6-0"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7-9-7"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94-6-0-1"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7-9-7-4"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94-6-0-2"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7-9-7-6"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94-6-0-2-4"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7-9-7-6-9"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94-8"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7-7"
+         style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94-6-0-2-7"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7-9-7-6-6"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+  </defs>
+  <sodipodi:namedview
+     id="base"
+     pagecolor="#ffffff"
+     bordercolor="#666666"
+     borderopacity="1.0"
+     inkscape:pageopacity="0.0"
+     inkscape:pageshadow="2"
+     inkscape:zoom="1.4"
+     inkscape:cx="213.41584"
+     inkscape:cy="301.17934"
+     inkscape:document-units="mm"
+     inkscape:current-layer="layer1"
+     showgrid="false"
+     inkscape:window-width="2560"
+     inkscape:window-height="1376"
+     inkscape:window-x="0"
+     inkscape:window-y="27"
+     inkscape:window-maximized="1"
+     showguides="false"
+     fit-margin-top="0"
+     fit-margin-left="0"
+     fit-margin-right="0"
+     fit-margin-bottom="0"
+     units="px"
+     inkscape:snap-global="false" />
+  <metadata
+     id="metadata5">
+    <rdf:RDF>
+      <cc:Work
+         rdf:about="">
+        <dc:format>image/svg+xml</dc:format>
+        <dc:type
+           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
+        <dc:title />
+      </cc:Work>
+    </rdf:RDF>
+  </metadata>
+  <g
+     inkscape:label="Layer 1"
+     inkscape:groupmode="layer"
+     id="layer1"
+     transform="translate(349.34521,-0.81564989)">
+    <rect
+       style="fill:none;stroke:#000000;stroke-width:1.00353587;stroke-linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none"
+       id="rect834"
+       width="30.251244"
+       height="88.477814"
+       x="-317.81958"
+       y="14.782127"
+       ry="2.5590618e-06" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+       x="-314.73792"
+       y="21.83947"
+       id="text838"><tspan
+         sodipodi:role="line"
+         id="tspan836"
+         x="-314.73792"
+         y="21.83947"
+         style="stroke-width:0.16370411">DCHUB</tspan></text>
+    <g
+       id="g2025"
+       transform="translate(-2.4916954,-1.2533369)">
+      <text
+         id="text838-5"
+         y="31.969406"
+         x="-254.53119"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="31.969406"
+           x="-254.53119"
+           id="tspan836-3"
+           sodipodi:role="line">DPP</tspan><tspan
+           id="tspan936"
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="40.15461"
+           x="-254.53119"
+           sodipodi:role="line">(0)</tspan></text>
+      <rect
+         ry="7.8154301e-07"
+         y="20.596174"
+         x="-269.66983"
+         height="27.021315"
+         width="30.696135"
+         id="rect834-5"
+         style="fill:none;stroke:#000000;stroke-width:0.55864918;stroke-linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none" />
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.1637041"
+       x="-297.75696"
+       y="109.44505"
+       id="text1063"><tspan
+         sodipodi:role="line"
+         id="tspan1061"
+         x="-297.75696"
+         y="115.23865"
+         style="stroke-width:0.1637041" /></text>
+    <g
+       id="g1878"
+       transform="translate(-0.62971878)">
+      <text
+         id="text846"
+         y="30.716068"
+         x="-302.27368"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#44aa00;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           style="text-align:center;text-anchor:middle;fill:#44aa00;stroke-width:0.16370411"
+           y="30.716068"
+           x="-302.27368"
+           id="tspan844"
+           sodipodi:role="line">HUBP</tspan><tspan
+           id="tspan863"
+           style="text-align:center;text-anchor:middle;fill:#44aa00;stroke-width:0.16370411"
+           y="38.901276"
+           x="-302.27368"
+           sodipodi:role="line">(0)</tspan></text>
+      <g
+         id="g1853">
+        <rect
+           style="fill:none;fill-opacity:1;stroke:#55d400;stroke-width:0.94157624;stroke-linecap:butt;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0"
+           id="rect1850"
+           width="24.708241"
+           height="17.224693"
+           x="-314.41837"
+           y="24.241148" />
+      </g>
+    </g>
+    <g
+       transform="translate(-0.62971878,18.810271)"
+       id="g1878-1">
+      <text
+         id="text846-2"
+         y="30.716068"
+         x="-302.27368"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#44aa00;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           style="text-align:center;text-anchor:middle;fill:#44aa00;stroke-width:0.16370411"
+           y="30.716068"
+           x="-302.27368"
+           id="tspan844-7"
+           sodipodi:role="line">HUBP</tspan><tspan
+           id="tspan863-0"
+           style="text-align:center;text-anchor:middle;fill:#44aa00;stroke-width:0.16370411"
+           y="38.901276"
+           x="-302.27368"
+           sodipodi:role="line">(1)</tspan></text>
+      <g
+         id="g1853-9">
+        <rect
+           style="fill:none;fill-opacity:1;stroke:#55d400;stroke-width:0.94157624;stroke-linecap:butt;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0"
+           id="rect1850-3"
+           width="24.708241"
+           height="17.224693"
+           x="-314.41837"
+           y="24.241148" />
+      </g>
+    </g>
+    <g
+       transform="translate(-0.62971878,57.029814)"
+       id="g1878-8">
+      <text
+         id="text846-7"
+         y="30.716068"
+         x="-302.27368"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#44aa00;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           style="text-align:center;text-anchor:middle;fill:#44aa00;stroke-width:0.16370411"
+           y="30.716068"
+           x="-302.27368"
+           id="tspan844-9"
+           sodipodi:role="line">HUBP</tspan><tspan
+           id="tspan863-20"
+           style="text-align:center;text-anchor:middle;fill:#44aa00;stroke-width:0.16370411"
+           y="38.901276"
+           x="-302.27368"
+           sodipodi:role="line">(5)</tspan></text>
+      <g
+         id="g1853-2">
+        <rect
+           style="fill:none;fill-opacity:1;stroke:#55d400;stroke-width:0.94157624;stroke-linecap:butt;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0"
+           id="rect1850-37"
+           width="24.708241"
+           height="17.224693"
+           x="-314.41837"
+           y="24.241148" />
+      </g>
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:3.17499995px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.26458332"
+       x="-310.7348"
+       y="72.106789"
+       id="text8862-5"><tspan
+         sodipodi:role="line"
+         id="tspan8860-9"
+         x="-310.7348"
+         y="72.106789"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:14.11111069px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';fill:#44aa00;stroke-width:0.26458332">...</tspan></text>
+    <path
+       style="fill:none;stroke:#ff0000;stroke-width:0.96187615;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-94)"
+       d="m -288.90777,32.862737 h 14.20296"
+       id="path1171"
+       inkscape:connector-curvature="0" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:3.17499995px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.26458332"
+       x="-264.85431"
+       y="62.072891"
+       id="text8862-5-8"><tspan
+         sodipodi:role="line"
+         id="tspan8860-9-4"
+         x="-264.85431"
+         y="62.072891"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:14.11111069px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';fill:#000000;stroke-width:0.26458332">...</tspan></text>
+    <g
+       id="g2025-5"
+       transform="translate(40.522337,-1.1484419)" />
+    <g
+       id="g7343"
+       transform="translate(40.522337,-1.2533369)">
+      <text
+         id="text838-5-6"
+         y="31.969406"
+         x="-254.53119"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="31.969406"
+           x="-254.53119"
+           id="tspan836-3-3"
+           sodipodi:role="line">MPC</tspan><tspan
+           id="tspan936-2"
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="40.15461"
+           x="-254.53119"
+           sodipodi:role="line">(0)</tspan></text>
+      <rect
+         ry="7.8154301e-07"
+         y="20.596174"
+         x="-269.66983"
+         height="27.021315"
+         width="30.696135"
+         id="rect834-5-0"
+         style="fill:none;stroke:#000000;stroke-width:0.55864918;stroke-linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none" />
+    </g>
+    <g
+       id="g7343-2"
+       transform="translate(84.178583,-1.2533369)">
+      <text
+         id="text838-5-6-54"
+         y="31.969406"
+         x="-254.53119"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="31.969406"
+           x="-254.53119"
+           id="tspan836-3-3-7"
+           sodipodi:role="line">OPP</tspan><tspan
+           id="tspan936-2-44"
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="40.15461"
+           x="-254.53119"
+           sodipodi:role="line">(0)</tspan></text>
+      <rect
+         ry="7.8154301e-07"
+         y="20.596174"
+         x="-269.66983"
+         height="27.021315"
+         width="30.696135"
+         id="rect834-5-0-3"
+         style="fill:none;stroke:#000000;stroke-width:0.55864918;stroke-linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none" />
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:3.17499995px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.26458332"
+       x="-221.84029"
+       y="62.072891"
+       id="text8862-5-8-6"><tspan
+         sodipodi:role="line"
+         id="tspan8860-9-4-5"
+         x="-221.84029"
+         y="62.072891"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:14.11111069px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';fill:#000000;stroke-width:0.26458332">...</tspan></text>
+    <path
+       style="fill:none;stroke:#ff0000;stroke-width:0.83149505;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-94-6)"
+       d="m -240.90479,32.86192 h 10.61353"
+       id="path1171-3"
+       inkscape:connector-curvature="0" />
+    <path
+       style="fill:none;stroke:#ff0000;stroke-width:0.83149505;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-94-6-0)"
+       d="m -198.19009,32.86192 h 10.61353"
+       id="path1171-3-8"
+       inkscape:connector-curvature="0" />
+    <g
+       id="g7343-2-2"
+       transform="translate(127.15447,-1.1484419)">
+      <text
+         id="text838-5-6-54-0"
+         y="65.122154"
+         x="-254.32814"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           id="tspan936-2-44-8"
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="65.122154"
+           x="-254.32814"
+           sodipodi:role="line">OPTC</tspan></text>
+      <rect
+         ry="2.4256708e-06"
+         y="20.805576"
+         x="-269.46042"
+         height="83.865906"
+         width="30.277332"
+         id="rect834-5-0-3-9"
+         style="fill:none;stroke:#000000;stroke-width:0.97745234;stroke-linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none" />
+    </g>
+    <path
+       style="fill:none;stroke:#ff0000;stroke-width:0.83149505;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-94-6-0-2)"
+       d="m -154.34485,32.86192 h 10.61353"
+       id="path1171-3-8-6"
+       inkscape:connector-curvature="0" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:3.17499995px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.26458332"
+       x="-178.18404"
+       y="62.072891"
+       id="text8862-5-8-6-0"><tspan
+         sodipodi:role="line"
+         id="tspan8860-9-4-5-4"
+         x="-178.18404"
+         y="62.072891"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:14.11111069px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';fill:#000000;stroke-width:0.26458332">...</tspan></text>
+    <path
+       style="fill:#000000;stroke:#000000;stroke-width:0.96187615;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-94-8)"
+       d="m -335.20986,59.030276 h 14.20296"
+       id="path1171-17"
+       inkscape:connector-curvature="0" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+       x="-349.77686"
+       y="61.404655"
+       id="text838-2"><tspan
+         sodipodi:role="line"
+         id="tspan836-7"
+         x="-349.77686"
+         y="61.404655"
+         style="stroke-width:0.16370411">SDP</tspan></text>
+    <path
+       style="fill:none;stroke:#000000;stroke-width:1.32291663;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:1.32291667, 1.32291667;stroke-dashoffset:0;stroke-opacity:1"
+       d="M -279.04164,107.86706 V 0.89985833"
+       id="path11907"
+       inkscape:connector-curvature="0" />
+    <path
+       style="fill:none;stroke:#000000;stroke-width:1.32291663;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:1.3229167, 1.3229167;stroke-dashoffset:0;stroke-opacity:1"
+       d="M -235.57438,107.86707 V 0.89985663"
+       id="path11907-6-1"
+       inkscape:connector-curvature="0" />
+    <path
+       style="fill:none;stroke:#000000;stroke-width:1.32291663;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:1.32291671, 1.32291671;stroke-dashoffset:0;stroke-opacity:1"
+       d="M -149.96277,107.86707 V 0.89985223"
+       id="path11907-6-1-0"
+       inkscape:connector-curvature="0" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+       x="-257.38275"
+       y="5.003336"
+       id="text838-6"><tspan
+         sodipodi:role="line"
+         id="tspan836-1"
+         x="-257.38275"
+         y="5.003336"
+         style="font-size:4.93888903px;text-align:center;text-anchor:middle;stroke-width:0.16370411">DPPCLK</tspan><tspan
+         sodipodi:role="line"
+         x="-257.38275"
+         y="13.188541"
+         style="font-size:4.93888903px;text-align:center;text-anchor:middle;stroke-width:0.16370411"
+         id="tspan12658">535.916Mhz</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+       x="-192.85298"
+       y="5.003336"
+       id="text838-6-5"><tspan
+         sodipodi:role="line"
+         id="tspan836-1-9"
+         x="-192.85298"
+         y="5.003336"
+         style="font-size:4.93888903px;text-align:center;text-anchor:middle;stroke-width:0.16370411">DISPCLK</tspan><tspan
+         sodipodi:role="line"
+         x="-192.85298"
+         y="13.188541"
+         style="font-size:4.93888903px;text-align:center;text-anchor:middle;stroke-width:0.16370411"
+         id="tspan12662">541.275 Mhz</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+       x="-302.03766"
+       y="5.003336"
+       id="text838-6-5-4"><tspan
+         sodipodi:role="line"
+         id="tspan836-1-9-9"
+         x="-312.23135"
+         y="5.003336"
+         style="font-size:4.93888903px;stroke-width:0.16370411;text-anchor:middle;text-align:center">DCFCLK</tspan><tspan
+         sodipodi:role="line"
+         x="-312.23135"
+         y="13.188541"
+         style="font-size:4.93888903px;stroke-width:0.16370411;text-anchor:middle;text-align:center"
+         id="tspan12660">506 Mhz</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+       x="-96.075348"
+       y="4.568048"
+       id="text838-6-5-0"><tspan
+         sodipodi:role="line"
+         id="tspan836-1-9-91"
+         x="-96.075348"
+         y="4.568048"
+         style="font-size:4.93888903px;stroke-width:0.16370411">SymCLK</tspan></text>
+    <g
+       id="g7343-2-2-7"
+       transform="translate(168.61494,-1.1484419)">
+      <text
+         id="text838-5-6-54-0-7"
+         y="65.122154"
+         x="-254.32814"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           id="tspan936-2-44-8-1"
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="65.122154"
+           x="-254.32814"
+           sodipodi:role="line">DIO</tspan></text>
+      <rect
+         ry="2.4256708e-06"
+         y="20.805576"
+         x="-269.46042"
+         height="83.865906"
+         width="30.277332"
+         id="rect834-5-0-3-9-1"
+         style="fill:none;stroke:#000000;stroke-width:0.97745234;stroke-linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none" />
+    </g>
+    <path
+       style="fill:none;stroke:#000000;stroke-width:1.32291663;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:1.32291672, 1.32291672;stroke-dashoffset:0;stroke-opacity:1"
+       d="M -108.38539,107.86707 V 0.89985092"
+       id="path11907-6-1-0-5"
+       inkscape:connector-curvature="0" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+       x="-143.52292"
+       y="5.0467439"
+       id="text838-6-5-0-9"><tspan
+         sodipodi:role="line"
+         id="tspan836-1-9-91-7"
+         x="-143.52292"
+         y="5.0467439"
+         style="font-size:4.93888903px;stroke-width:0.16370411">VirtualPCLK</tspan></text>
+    <path
+       style="fill:none;stroke:#ff0000;stroke-width:0.83149505;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-94-6-0-2-7)"
+       d="m -112.24183,60.747629 h 10.61353"
+       id="path1171-3-8-6-7"
+       inkscape:connector-curvature="0" />
+  </g>
+</svg>
diff --git a/Documentation/gpu/amdgpu/display/pipeline_4k_split.svg b/Documentation/gpu/amdgpu/display/pipeline_4k_split.svg
new file mode 100644
index 000000000000..b43119e7eb8a
--- /dev/null
+++ b/Documentation/gpu/amdgpu/display/pipeline_4k_split.svg
@@ -0,0 +1,1062 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   xmlns:dc="http://purl.org/dc/elements/1.1/"
+   xmlns:cc="http://creativecommons.org/ns#"
+   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
+   xmlns:svg="http://www.w3.org/2000/svg"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   width="1055.4928"
+   height="404.60379"
+   viewBox="0 0 279.26579 107.05142"
+   version="1.1"
+   id="svg8"
+   inkscape:version="0.92.5 (2060ec1f9f, 2020-04-08)"
+   sodipodi:docname="pipeline_no_split_4k.svg">
+  <defs
+     id="defs2">
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="marker8858"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path8616"
+         style="fill:#aa00d4;fill-opacity:1;fill-rule:evenodd;stroke:#aa00d4;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Send"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Send"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path8622"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="matrix(-0.3,0,0,-0.3,0.69,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Lend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Lend"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path8592"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:1.00000003pt;stroke-opacity:1"
+         transform="matrix(-0.8,0,0,-0.8,-10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Lend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Lend"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path8610"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="matrix(-1.1,0,0,-1.1,-1.1,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-3"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-6"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-3-2"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-6-9"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-3-2-1"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-6-9-9"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-3-2-7"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-6-9-8"
+         style="fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-3-4"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-6-5"
+         style="fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-0"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-3"
+         style="fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-6"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-1"
+         style="fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-3-2-6"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-6-9-1"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-0-7"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-3-4"
+         style="fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-6-3"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-1-0"
+         style="fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-3-2-8"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-6-9-6"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-3"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-6"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="marker8858-3"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path8616-5"
+         style="fill:#00ffcc;fill-opacity:1;fill-rule:evenodd;stroke:#00ffcc;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-3-3"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-6-56"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-8-0-2"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         inkscape:connector-curvature="0"
+         id="path1200-9-3-9"
+         style="fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-9"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-3"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94-6"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7-9"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94-6-7"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7-9-4"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94-6-0"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7-9-7"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94-6-0-1"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7-9-7-4"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94-6-0-2"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7-9-7-6"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94-6-0-2-4"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7-9-7-6-9"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94-8"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7-7"
+         style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow2Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow2Mend-94-6-0-2-7"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path1200-7-9-7-6-6"
+         style="fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
+         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
+         transform="scale(-0.6)"
+         inkscape:connector-curvature="0" />
+    </marker>
+  </defs>
+  <sodipodi:namedview
+     id="base"
+     pagecolor="#ffffff"
+     bordercolor="#666666"
+     borderopacity="1.0"
+     inkscape:pageopacity="0.0"
+     inkscape:pageshadow="2"
+     inkscape:zoom="1.4"
+     inkscape:cx="491.27298"
+     inkscape:cy="306.89362"
+     inkscape:document-units="mm"
+     inkscape:current-layer="layer1"
+     showgrid="false"
+     inkscape:window-width="2560"
+     inkscape:window-height="1376"
+     inkscape:window-x="0"
+     inkscape:window-y="27"
+     inkscape:window-maximized="1"
+     showguides="false"
+     fit-margin-top="0"
+     fit-margin-left="0"
+     fit-margin-right="0"
+     fit-margin-bottom="0"
+     units="px"
+     inkscape:snap-global="false" />
+  <metadata
+     id="metadata5">
+    <rdf:RDF>
+      <cc:Work
+         rdf:about="">
+        <dc:format>image/svg+xml</dc:format>
+        <dc:type
+           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
+        <dc:title></dc:title>
+      </cc:Work>
+    </rdf:RDF>
+  </metadata>
+  <g
+     inkscape:label="Layer 1"
+     inkscape:groupmode="layer"
+     id="layer1"
+     transform="translate(349.34521,-0.81564989)">
+    <rect
+       style="fill:none;stroke:#000000;stroke-width:1.00353587;stroke-linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none"
+       id="rect834"
+       width="30.251244"
+       height="88.477814"
+       x="-317.81958"
+       y="14.782127"
+       ry="2.5590618e-06" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+       x="-314.73792"
+       y="21.83947"
+       id="text838"><tspan
+         sodipodi:role="line"
+         id="tspan836"
+         x="-314.73792"
+         y="21.83947"
+         style="stroke-width:0.16370411">DCHUB</tspan></text>
+    <g
+       id="g2025"
+       transform="translate(-2.4916954,-1.2533369)">
+      <text
+         id="text838-5"
+         y="31.969406"
+         x="-254.53119"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="31.969406"
+           x="-254.53119"
+           id="tspan836-3"
+           sodipodi:role="line">DPP</tspan><tspan
+           id="tspan936"
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="40.15461"
+           x="-254.53119"
+           sodipodi:role="line">(0)</tspan></text>
+      <rect
+         ry="7.8154301e-07"
+         y="20.596174"
+         x="-269.66983"
+         height="27.021315"
+         width="30.696135"
+         id="rect834-5"
+         style="fill:none;stroke:#000000;stroke-width:0.55864918;stroke-linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none" />
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.1637041"
+       x="-297.75696"
+       y="109.44505"
+       id="text1063"><tspan
+         sodipodi:role="line"
+         id="tspan1061"
+         x="-297.75696"
+         y="115.23865"
+         style="stroke-width:0.1637041" /></text>
+    <g
+       id="g1878"
+       transform="translate(-0.62971878)">
+      <text
+         id="text846"
+         y="30.716068"
+         x="-302.27368"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#44aa00;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           style="text-align:center;text-anchor:middle;fill:#44aa00;stroke-width:0.16370411"
+           y="30.716068"
+           x="-302.27368"
+           id="tspan844"
+           sodipodi:role="line">HUBP</tspan><tspan
+           id="tspan863"
+           style="text-align:center;text-anchor:middle;fill:#44aa00;stroke-width:0.16370411"
+           y="38.901276"
+           x="-302.27368"
+           sodipodi:role="line">(0)</tspan></text>
+      <g
+         id="g1853">
+        <rect
+           style="fill:none;fill-opacity:1;stroke:#55d400;stroke-width:0.94157624;stroke-linecap:butt;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0"
+           id="rect1850"
+           width="24.708241"
+           height="17.224693"
+           x="-314.41837"
+           y="24.241148" />
+      </g>
+    </g>
+    <g
+       transform="translate(-0.62971878,18.810271)"
+       id="g1878-1">
+      <text
+         id="text846-2"
+         y="30.716068"
+         x="-302.27368"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#44aa00;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           style="text-align:center;text-anchor:middle;fill:#44aa00;stroke-width:0.16370411"
+           y="30.716068"
+           x="-302.27368"
+           id="tspan844-7"
+           sodipodi:role="line">HUBP</tspan><tspan
+           id="tspan863-0"
+           style="text-align:center;text-anchor:middle;fill:#44aa00;stroke-width:0.16370411"
+           y="38.901276"
+           x="-302.27368"
+           sodipodi:role="line">(1)</tspan></text>
+      <g
+         id="g1853-9">
+        <rect
+           style="fill:none;fill-opacity:1;stroke:#55d400;stroke-width:0.94157624;stroke-linecap:butt;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0"
+           id="rect1850-3"
+           width="24.708241"
+           height="17.224693"
+           x="-314.41837"
+           y="24.241148" />
+      </g>
+    </g>
+    <g
+       transform="translate(-0.62971878,57.029814)"
+       id="g1878-8">
+      <text
+         id="text846-7"
+         y="30.716068"
+         x="-302.27368"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#44aa00;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           style="text-align:center;text-anchor:middle;fill:#44aa00;stroke-width:0.16370411"
+           y="30.716068"
+           x="-302.27368"
+           id="tspan844-9"
+           sodipodi:role="line">HUBP</tspan><tspan
+           id="tspan863-20"
+           style="text-align:center;text-anchor:middle;fill:#44aa00;stroke-width:0.16370411"
+           y="38.901276"
+           x="-302.27368"
+           sodipodi:role="line">(5)</tspan></text>
+      <g
+         id="g1853-2">
+        <rect
+           style="fill:none;fill-opacity:1;stroke:#55d400;stroke-width:0.94157624;stroke-linecap:butt;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0"
+           id="rect1850-37"
+           width="24.708241"
+           height="17.224693"
+           x="-314.41837"
+           y="24.241148" />
+      </g>
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:3.17499995px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.26458332"
+       x="-310.7348"
+       y="72.106789"
+       id="text8862-5"><tspan
+         sodipodi:role="line"
+         id="tspan8860-9"
+         x="-310.7348"
+         y="72.106789"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:14.11111069px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';fill:#44aa00;stroke-width:0.26458332">...</tspan></text>
+    <g
+       id="g2031"
+       transform="translate(-2.4568452,2.9399645)">
+      <text
+         id="text838-5-3"
+         y="84.805916"
+         x="-254.56604"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="84.805916"
+           x="-254.56604"
+           id="tspan836-3-6"
+           sodipodi:role="line">DPP</tspan><tspan
+           id="tspan936-1"
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="92.991119"
+           x="-254.56604"
+           sodipodi:role="line">(5)</tspan></text>
+      <rect
+         ry="7.8154301e-07"
+         y="73.432686"
+         x="-269.70468"
+         height="27.021317"
+         width="30.696136"
+         id="rect834-5-2"
+         style="fill:none;stroke:#000000;stroke-width:0.55864918;stroke-linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none" />
+    </g>
+    <path
+       style="fill:none;stroke:#ff0000;stroke-width:0.96187615;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-9)"
+       d="m -289.17681,89.892551 h 14.20296"
+       id="path1171-1"
+       inkscape:connector-curvature="0" />
+    <path
+       style="fill:none;stroke:#ff0000;stroke-width:0.96187615;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-94)"
+       d="m -288.90777,32.862737 h 14.20296"
+       id="path1171"
+       inkscape:connector-curvature="0" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:3.17499995px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.26458332"
+       x="-264.85431"
+       y="62.072891"
+       id="text8862-5-8"><tspan
+         sodipodi:role="line"
+         id="tspan8860-9-4"
+         x="-264.85431"
+         y="62.072891"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:14.11111069px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';fill:#000000;stroke-width:0.26458332">...</tspan></text>
+    <g
+       id="g2025-5"
+       transform="translate(40.522337,-1.1484419)" />
+    <g
+       id="g7343"
+       transform="translate(40.522337,-1.2533369)">
+      <text
+         id="text838-5-6"
+         y="31.969406"
+         x="-254.53119"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="31.969406"
+           x="-254.53119"
+           id="tspan836-3-3"
+           sodipodi:role="line">MPC</tspan><tspan
+           id="tspan936-2"
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="40.15461"
+           x="-254.53119"
+           sodipodi:role="line">(0)</tspan></text>
+      <rect
+         ry="7.8154301e-07"
+         y="20.596174"
+         x="-269.66983"
+         height="27.021315"
+         width="30.696135"
+         id="rect834-5-0"
+         style="fill:none;stroke:#000000;stroke-width:0.55864918;stroke-linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none" />
+    </g>
+    <g
+       id="g7343-1"
+       transform="translate(40.522337,56.303939)">
+      <text
+         id="text838-5-6-5"
+         y="31.969406"
+         x="-254.53119"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="31.969406"
+           x="-254.53119"
+           id="tspan836-3-3-5"
+           sodipodi:role="line">MPC</tspan><tspan
+           id="tspan936-2-4"
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="40.15461"
+           x="-254.53119"
+           sodipodi:role="line">(5)</tspan></text>
+      <rect
+         ry="7.8154301e-07"
+         y="20.596174"
+         x="-269.66983"
+         height="27.021315"
+         width="30.696135"
+         id="rect834-5-0-7"
+         style="fill:none;stroke:#000000;stroke-width:0.55864918;stroke-linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none" />
+    </g>
+    <g
+       id="g7343-2"
+       transform="translate(84.178583,-1.2533369)">
+      <text
+         id="text838-5-6-54"
+         y="31.969406"
+         x="-254.53119"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="31.969406"
+           x="-254.53119"
+           id="tspan836-3-3-7"
+           sodipodi:role="line">OPP</tspan><tspan
+           id="tspan936-2-44"
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="40.15461"
+           x="-254.53119"
+           sodipodi:role="line">(0)</tspan></text>
+      <rect
+         ry="7.8154301e-07"
+         y="20.596174"
+         x="-269.66983"
+         height="27.021315"
+         width="30.696135"
+         id="rect834-5-0-3"
+         style="fill:none;stroke:#000000;stroke-width:0.55864918;stroke-linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none" />
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:3.17499995px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.26458332"
+       x="-221.84029"
+       y="62.072891"
+       id="text8862-5-8-6"><tspan
+         sodipodi:role="line"
+         id="tspan8860-9-4-5"
+         x="-221.84029"
+         y="62.072891"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:14.11111069px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';fill:#000000;stroke-width:0.26458332">...</tspan></text>
+    <path
+       style="fill:none;stroke:#ff0000;stroke-width:0.83149505;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-94-6)"
+       d="m -240.90479,32.86192 h 10.61353"
+       id="path1171-3"
+       inkscape:connector-curvature="0" />
+    <path
+       style="fill:none;stroke:#ff0000;stroke-width:0.83149505;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-94-6-7)"
+       d="m -241.09039,89.891298 h 10.61353"
+       id="path1171-3-5"
+       inkscape:connector-curvature="0" />
+    <path
+       style="fill:none;stroke:#ff0000;stroke-width:0.83149505;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-94-6-0)"
+       d="m -198.19009,32.86192 h 10.61353"
+       id="path1171-3-8"
+       inkscape:connector-curvature="0" />
+    <g
+       id="g7343-2-6"
+       transform="translate(84.178583,56.303939)">
+      <text
+         id="text838-5-6-54-8"
+         y="31.969406"
+         x="-254.53119"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="31.969406"
+           x="-254.53119"
+           id="tspan836-3-3-7-8"
+           sodipodi:role="line">OPP</tspan><tspan
+           id="tspan936-2-44-4"
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="40.15461"
+           x="-254.53119"
+           sodipodi:role="line">(0)</tspan></text>
+      <rect
+         ry="7.8154301e-07"
+         y="20.596174"
+         x="-269.66983"
+         height="27.021315"
+         width="30.696135"
+         id="rect834-5-0-3-3"
+         style="fill:none;stroke:#000000;stroke-width:0.55864918;stroke-linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none" />
+    </g>
+    <path
+       style="fill:none;stroke:#ff0000;stroke-width:0.83149505;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-94-6-0-1)"
+       d="m -198.00111,89.891298 h 10.61353"
+       id="path1171-3-8-9"
+       inkscape:connector-curvature="0" />
+    <g
+       id="g7343-2-2"
+       transform="translate(127.15447,-1.1484419)">
+      <text
+         id="text838-5-6-54-0"
+         y="65.122154"
+         x="-254.32814"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           id="tspan936-2-44-8"
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="65.122154"
+           x="-254.32814"
+           sodipodi:role="line">OPTC</tspan></text>
+      <rect
+         ry="2.4256708e-06"
+         y="20.805576"
+         x="-269.46042"
+         height="83.865906"
+         width="30.277332"
+         id="rect834-5-0-3-9"
+         style="fill:none;stroke:#000000;stroke-width:0.97745234;stroke-linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none" />
+    </g>
+    <path
+       style="fill:none;stroke:#ff0000;stroke-width:0.83149505;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-94-6-0-2)"
+       d="m -154.34485,32.86192 h 10.61353"
+       id="path1171-3-8-6"
+       inkscape:connector-curvature="0" />
+    <path
+       style="fill:none;stroke:#ff0000;stroke-width:0.83149505;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-94-6-0-2-4)"
+       d="m -154.34485,89.891298 h 10.61353"
+       id="path1171-3-8-6-5"
+       inkscape:connector-curvature="0" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:3.17499995px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.26458332"
+       x="-178.18404"
+       y="62.072891"
+       id="text8862-5-8-6-0"><tspan
+         sodipodi:role="line"
+         id="tspan8860-9-4-5-4"
+         x="-178.18404"
+         y="62.072891"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:14.11111069px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';fill:#000000;stroke-width:0.26458332">...</tspan></text>
+    <path
+       style="fill:#000000;stroke:#000000;stroke-width:0.96187615;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-94-8)"
+       d="m -335.20986,59.030276 h 14.20296"
+       id="path1171-17"
+       inkscape:connector-curvature="0" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+       x="-349.77686"
+       y="61.404655"
+       id="text838-2"><tspan
+         sodipodi:role="line"
+         id="tspan836-7"
+         x="-349.77686"
+         y="61.404655"
+         style="stroke-width:0.16370411">SDP</tspan></text>
+    <path
+       style="fill:none;stroke:#000000;stroke-width:1.32291663;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:1.32291667, 1.32291667;stroke-dashoffset:0;stroke-opacity:1"
+       d="M -279.04164,107.86706 V 0.89985833"
+       id="path11907"
+       inkscape:connector-curvature="0" />
+    <path
+       style="fill:none;stroke:#000000;stroke-width:1.32291663;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:1.3229167, 1.3229167;stroke-dashoffset:0;stroke-opacity:1"
+       d="M -235.57438,107.86707 V 0.89985663"
+       id="path11907-6-1"
+       inkscape:connector-curvature="0" />
+    <path
+       style="fill:none;stroke:#000000;stroke-width:1.32291663;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:1.32291671, 1.32291671;stroke-dashoffset:0;stroke-opacity:1"
+       d="M -149.96277,107.86707 V 0.89985223"
+       id="path11907-6-1-0"
+       inkscape:connector-curvature="0" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+       x="-257.38275"
+       y="5.003336"
+       id="text838-6"><tspan
+         sodipodi:role="line"
+         id="tspan836-1"
+         x="-257.38275"
+         y="5.003336"
+         style="font-size:4.93888903px;text-align:center;text-anchor:middle;stroke-width:0.16370411">DPPCLK</tspan><tspan
+         sodipodi:role="line"
+         x="-257.38275"
+         y="13.188541"
+         style="font-size:4.93888903px;text-align:center;text-anchor:middle;stroke-width:0.16370411"
+         id="tspan12658">267.958Mhz</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+       x="-192.85298"
+       y="5.003336"
+       id="text838-6-5"><tspan
+         sodipodi:role="line"
+         id="tspan836-1-9"
+         x="-192.85298"
+         y="5.003336"
+         style="font-size:4.93888903px;text-align:center;text-anchor:middle;stroke-width:0.16370411">DISPCLK</tspan><tspan
+         sodipodi:role="line"
+         x="-192.85298"
+         y="13.188541"
+         style="font-size:4.93888903px;text-align:center;text-anchor:middle;stroke-width:0.16370411"
+         id="tspan12662">541.275 Mhz</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+       x="-302.03766"
+       y="5.003336"
+       id="text838-6-5-4"><tspan
+         sodipodi:role="line"
+         id="tspan836-1-9-9"
+         x="-312.23135"
+         y="5.003336"
+         style="font-size:4.93888903px;stroke-width:0.16370411;text-anchor:middle;text-align:center">DCFCLK</tspan><tspan
+         sodipodi:role="line"
+         x="-312.23135"
+         y="13.188541"
+         style="font-size:4.93888903px;stroke-width:0.16370411;text-anchor:middle;text-align:center"
+         id="tspan12660">506 Mhz</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+       x="-96.075348"
+       y="4.568048"
+       id="text838-6-5-0"><tspan
+         sodipodi:role="line"
+         id="tspan836-1-9-91"
+         x="-96.075348"
+         y="4.568048"
+         style="font-size:4.93888903px;stroke-width:0.16370411">SymCLK</tspan></text>
+    <g
+       id="g7343-2-2-7"
+       transform="translate(168.61494,-1.1484419)">
+      <text
+         id="text838-5-6-54-0-7"
+         y="65.122154"
+         x="-254.32814"
+         style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+         xml:space="preserve"><tspan
+           id="tspan936-2-44-8-1"
+           style="text-align:center;text-anchor:middle;stroke-width:0.16370411"
+           y="65.122154"
+           x="-254.32814"
+           sodipodi:role="line">DIO</tspan></text>
+      <rect
+         ry="2.4256708e-06"
+         y="20.805576"
+         x="-269.46042"
+         height="83.865906"
+         width="30.277332"
+         id="rect834-5-0-3-9-1"
+         style="fill:none;stroke:#000000;stroke-width:0.97745234;stroke-linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none" />
+    </g>
+    <path
+       style="fill:none;stroke:#000000;stroke-width:1.32291663;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:1.32291672, 1.32291672;stroke-dashoffset:0;stroke-opacity:1"
+       d="M -108.38539,107.86707 V 0.89985092"
+       id="path11907-6-1-0-5"
+       inkscape:connector-curvature="0" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.54816437px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.16370411"
+       x="-143.52292"
+       y="5.0467439"
+       id="text838-6-5-0-9"><tspan
+         sodipodi:role="line"
+         id="tspan836-1-9-91-7"
+         x="-143.52292"
+         y="5.0467439"
+         style="font-size:4.93888903px;stroke-width:0.16370411">VirtualPCLK</tspan></text>
+    <path
+       style="fill:none;stroke:#ff0000;stroke-width:0.83149505;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-94-6-0-2-7)"
+       d="m -112.24183,60.747629 h 10.61353"
+       id="path1171-3-8-6-7"
+       inkscape:connector-curvature="0" />
+  </g>
+</svg>
-- 
2.35.1

