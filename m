Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D837AC87FCF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 20:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 690D310E491;
	Thu,  7 Aug 2025 20:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BTLuIaQ6";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7267310E491
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 20:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFd3+oEOiCtF17t+LY0sGF6MbnCI2lEobwSXi5kEyMQYMVy4S/HPyjslGcmjJF1NLiXliHRbnk0CmiqKs9WoE8mB+pgZc9DgUcLeyoWVGnWPT03kryF2eQUhGKtP5qGizS2vNDmgOy8h3r4m4Vei4Yckk9QjZfDsrEuyGDi/MQRbFuMMulGgUX3JOhBXIkTTKOGNQSzbVNVFV0damcx2dB/+7RLxLJmEAsppLtUWB8+OWSh4XUkk9QZgaqS6wnftmnOIIEKGgwUiDo8z+m02b849siAcefy9eKj/4AlS95+VAyMClxVZ7FZjxtkqjs5UWKn2QlBWwumChkXZjPihUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf3bcjTMQWnZTYJKqkB3HkXU/2rvKYaFMzjlWcfRjoA=;
 b=WGAAXywR90TAsWVHQvSAI2wBEFpFiAi1p6iFpanmywSw9vJAp9zwSGkJWKrKPvEiZL8anjoIcB1V2Vf+OOyvFMxg6nw08LpdJ2Cu2NcvndzxsyIsbyUUHuiXLW45ZFhEU9llMK7xAl3w/02CLL4dNLX2My3tXxIjXa4ibDkKHccEMV1I4SvAjEYZKZC3sMfcNNXG68YnQStGTwjM/mrVVeCWmBPEiqhRYnL2s9DW54yO4LYlixAfhvaq82KAm5aVZh+1McPedW3DtDVUiRqMitmK0bpRW/k2BGBcHuB3sr/54/FFYapJ1E8jG0CxbJSVZ/ldLlZe8x9NLZik1JCS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf3bcjTMQWnZTYJKqkB3HkXU/2rvKYaFMzjlWcfRjoA=;
 b=BTLuIaQ6aKln9CECc7gzYMGosQ7K94GD9yAZt1nVfWHOY03jN1ItJ5ircIv8NX5BGrvs+/YqYXVyfIcS4fUZqWm0CCgAMBsofgbhpzcqTY/+pb1SwKLfKHAd1yjfUqQKbyV7UjTlqbBvUoYIVvnrtfw/BpOW/hLQScReUFmCRBE=
Received: from BL0PR01CA0020.prod.exchangelabs.com (2603:10b6:208:71::33) by
 CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.16; Thu, 7 Aug 2025 20:23:09 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::2c) by BL0PR01CA0020.outlook.office365.com
 (2603:10b6:208:71::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Thu,
 7 Aug 2025 20:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 20:23:08 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 15:23:07 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>
Subject: [PATCH v11] Add CRIU support for amdgpu dmabuf
Date: Thu, 7 Aug 2025 16:22:42 -0400
Message-ID: <20250807202245.2970262-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 87083a8f-faaa-4aad-bf17-08ddd5f0391c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/2+uWSB0Vx7OZoSPZ1oMF4W+qnykzn4qlq3aoRbVnXFAMZVrhpUzjdtmXHFs?=
 =?us-ascii?Q?v6qbGIY2tmTDaHKLt04j1bsGgFUHtvf6RnOQb/H+lUTvKhQgssqW8tb1HQIm?=
 =?us-ascii?Q?C6keuYw9OqZttWUPcqXsNBkJf3QepTGH/gWolc/JJf/Y5xaAnt+CA3RiZHtQ?=
 =?us-ascii?Q?5Yb7Pu4PGOIfq6RH79epvBUgYTm8WblSLju2wPE6e6JdkMWMNQh9TM2MYdEa?=
 =?us-ascii?Q?jlSsdSxM3WGdkF3yFIYF7xqOuIaP2YM/kawQJD/WcogWxcAetVoS+F3/ROQx?=
 =?us-ascii?Q?ot+S1Ca0YmScr/W7zpIfO/cjZsCL3x6kkws0q9PebQjEvMS+23pJDcJ64h/O?=
 =?us-ascii?Q?nwG/YoMQL2s1IyzA2WQug4PdHIe0TdR9DgOWhulfH1ycksbo+YHg4y8qbOsA?=
 =?us-ascii?Q?LF08687YalO/l3XeD+qAqK0t8Gk0CnWOAM5AZHOfKYcUDJsnYeY2L0z/ifMD?=
 =?us-ascii?Q?qDdAZmCV7zs2j9i6auAVOqAgwREHzmbxPZO4ncxSUu4xodhQpP/4HdD1AH8H?=
 =?us-ascii?Q?wesbTBpl33dhgN4zBd1D33PotnJvdLR2bJprXNASJwhjEvEfAnYL4DZZAImC?=
 =?us-ascii?Q?/mnaZse1j4VBabYmOcqW6gaG4Q5XVKSN+l3RQJ9ML9Xlm1JerO3glMnpgLMC?=
 =?us-ascii?Q?QQmTPhGswF/kFE2s3k3aOnsnXJ3cKi8CROd7qtQuj6aslX0vCSmkBy3PuMjE?=
 =?us-ascii?Q?3rV0HsF2knUwRQ7fkbRnjYNvOZ5ENdAkwnUzDRp1gQMwWMppD3Vxoh4zlJcA?=
 =?us-ascii?Q?n4WjXOQp+1SaJwEam/EpImuIfS2PQlE7wgUYHdCZBcUmub0awOcYDp3nuXse?=
 =?us-ascii?Q?izQsTI868Rd8VzFVw9/r1EfbCMmLCckr7AXDxwVI29gPXSbD2nPr6hf8gLuY?=
 =?us-ascii?Q?/2MBueOnLmdmevloqa6/urBG5hInXm4rU8isazusgywFLwkqpiqWk1R3M1JU?=
 =?us-ascii?Q?qYmdfjAoPc2y2afVYqEgaw5Wn4fa8Np3Q35McItI3P8KeJwGeX9HKU9xEVtw?=
 =?us-ascii?Q?B/Fb/fSAFQhZcPYELqulyS93L1HQzqpEDSfxlR0pugZSKjEVzCI1uSFQP7PT?=
 =?us-ascii?Q?9/zRZ4Fqtf+uCiNm+TFrdDoEi5rdVH50roXo4wlSTkp0vhKzpUZ32i3VLE8p?=
 =?us-ascii?Q?XMP+5XnZRPmSEEUHjyr2u1Q/MKMrmaWh/UEYp6lp8aRNJgb7dipOj2SoEfHr?=
 =?us-ascii?Q?4w6wIiVwxcPIoIKH1hZNagFGqmhV2xEFkwqnEBCXNW27zr9uYJO+yX202CF/?=
 =?us-ascii?Q?Bsgoo4uyoB9hRW8/HhuLQPFyMwenuLsHs9Bwwlu9wSDu3QcLn+yTQcprxOkR?=
 =?us-ascii?Q?oXPWxEns1bB/sa/mAnKuvztaTLxGR6w8pk1opiMzG6NPZqohQGHL8JbuQZnN?=
 =?us-ascii?Q?IQ635rBOoISJuU5PCvaM3lbhbXlEiplOkuLGn2/wRKUSZ4iE5Xh2luzBek1J?=
 =?us-ascii?Q?50jFpIlEvrdi0pxwneXwyckRnkES7Klbm27DJPg83jIJvKpnpCwpti6Qbq4V?=
 =?us-ascii?Q?rdUOn/a20W1X4HHnASNor0OjEgSb5TEKKN6nDIuMjsVRrPEc5MdEz0q+8Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 20:23:08.2388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87083a8f-faaa-4aad-bf17-08ddd5f0391c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch series adds support for CRIU checkpointing of processes that
share memory with the amdgpu dmabuf interface.

This v11 fixes some locking and formatting issues identified by Christian

Accompanying CRIU changes:
https://github.com/checkpoint-restore/criu/pull/2613


