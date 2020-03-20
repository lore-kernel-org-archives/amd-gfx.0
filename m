Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC48C4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 13:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99862076E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 13:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UiRk31G6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99862076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA156EB37;
	Fri, 20 Mar 2020 13:24:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2214E6EB34
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 13:24:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcwmkeQWWp4LA0f9Uhd9ZrmK6vOXgw9age0tn69IDg+lbheCb/iVYz2bjt1+yCHTIasQacblBATNRghUAdvGgNvZT/dAyBAc7iOwcfa617dM0O3KEY1LIudB328FcnZRV9IE/Rigqs6/pti7B4F+FLxpsU3F7DCX9ZFcpfWY2pNpYZqdhsOjz848lbieg3pwDuBq63FxOX/Vk8GQS35T+Mrb9Y2N1DnaylyFIaj+13B6NA1K/VMdKrp2a5owWGAeMlo+fUHG6pGa/2uptvUm14bLlxwJkG0ZUF15LdrLOcYkAur3GbuMBXBjc8jIGy99Qo/J0eJC4QBMRaqAIzsCiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIDimZOGEd2akL1y/wNhi2ZpVi4XHBAY1blJr2eqL3A=;
 b=SnDGq+wjWTaKXDjnD8y5y3i+Q6gRKFOIyZl6q9FbdHam7QbF0uV5mN8UliRM4gcEzXCnBKq6PLe0etmMs7BsHZzUbbU2T3hGc5d92FR6LpSUPWImhtTG2NF2AFLEHw6GPoNsrn1SdMe3oHC5zG/L1FYzDxrJLkVWmm90/zJ4Olcke471ns/Qsh+2s3CeyuoGbsDPlClq5XjUQ9+8Q5fyg7F1ResQN7MVVMngegmKSr9IOimeB0pj0rmGuGtsxzyybCQ8ecUsuYTVAsZUPzo5gmjwsP/YXYMZFZm7QvpwZ5msW+dUoeo+shmc7Xr5Twn1MbWz8NlHboSt1vZC4SqPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIDimZOGEd2akL1y/wNhi2ZpVi4XHBAY1blJr2eqL3A=;
 b=UiRk31G6bwRRac7bW6YKZ/++Xo090gxvT1wfoTX0UXnU5apg0/JJ7NbMchFdOu1Io+4SY8n6JQ7ukCojoVYU3GdtKqKPTMne6QSQQSywI6luq8DqbL4avYvk4tVRvsh0ZCFT2VTcRPeRde5OZGok0/CT+N5ZEpusIuSubzu42J0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3178.namprd12.prod.outlook.com (2603:10b6:5:18d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 20 Mar
 2020 13:24:27 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2814.025; Fri, 20 Mar 2020
 13:24:27 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: Add documentation for unique_id
Date: Fri, 20 Mar 2020 09:24:07 -0400
Message-Id: <20200320132407.9902-3-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320132407.9902-1-kent.russell@amd.com>
References: <20200320132407.9902-1-kent.russell@amd.com>
X-ClientProxiedBy: YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16)
 To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.17 via Frontend Transport; Fri, 20 Mar 2020 13:24:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c96fe24-af0f-4925-3325-08d7ccd203c3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3178:|DM6PR12MB3178:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3178B0FE58C7781E3E9DC06085F50@DM6PR12MB3178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(199004)(44832011)(16526019)(2906002)(26005)(66476007)(52116002)(316002)(7696005)(956004)(36756003)(2616005)(5660300002)(186003)(66946007)(66556008)(8936002)(4744005)(1076003)(6486002)(8676002)(6666004)(81166006)(81156014)(6916009)(478600001)(4326008)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3178;
 H:DM6PR12MB3721.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLAquVESvwSUnNovmgWP62x7cMnVBAZ4L7ENUqc83uJ6F5ypdz6o5s6MnsOd4pm1IudZBj3/qCCNlR3vq2Vod60HuitGbZFg73T8ifKG37o4WwOUVxckf1D1r2kjzxs0u5KE7auoHYt0L2VdAoeIfeawYGBQcqLSOomYV8b1z6gNMo6yA6Hx4Q9oKrmwQzTAUGJdvZOkETkXKRK0Zo/credkqkF0mnOGGD/FFMERurlIKXlqUC36Bu8HF6nPj6EM8Ybn6PNTSW5Z0A+er/QdxD5aOWqvx60eV0F+MxCY4HfHUSUYDl9A6lBOSN5vQUJK6ssCh5/CpBnHwxTMVPeZT8C8rZPBHqAxNKNCJfytqMv5GLKFtCsWoD1e70HP+e4yVfmftvOnE7/pGpIbuuBrHFKEBkIPKGaJbvG9/EYzr3htCdIucBvMgvQRj2bzAYXP
X-MS-Exchange-AntiSpam-MessageData: 1Iwtef2MBwwv14Ip4gPywxzTkc0y1s6Slrbg50T8oVwv6iaLSieOn0RZ6jgPnIZEfv1e2labO9vlJnGbZjvj/huNfA/8GDey2LaABzliLJrpUvLM4L51zudOEVLZ3n4vmz+MjkeYgsJKVXb5+VFyxg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c96fe24-af0f-4925-3325-08d7ccd203c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 13:24:27.6416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsLaK5bh1UmF/o2UN9GR26kuVoQEmgTSAj43HN6LM1wktplJMVs7ycimABNN0fFhHPJFrO9pjz77FlfoPCvtPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3178
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the amdgpu.rst tie-ins for the unique_id documentation

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 Documentation/gpu/amdgpu.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index 9afcc30e0f42..4cc74325bf91 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -227,6 +227,12 @@ serial_number
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
    :doc: serial_number
 
+unique_id
+---------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+   :doc: unique_id
+
 GPU Memory Usage Information
 ============================
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
