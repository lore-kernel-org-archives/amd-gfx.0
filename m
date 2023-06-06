Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657C5C77B73
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 16:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EAB110E379;
	Tue,  6 Jun 2023 16:24:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64BB910E383
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 16:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OC/PJncZGwliaGcQC3rhoffhRoF0TFgoP7A4bvSSFqCwO0FtyHcRdVgmHDPOE52JYRKphUlnkJyPtiFX9bkSVkODitRD+UtQxsbeXdtvEoNnJabfeYBqZiLaPaQ5aGUPgOo5kT+ey6SzcuXJN+yvBhjMdITfWPwarQBgtZtjYJmlF93MP8dVDOpoB1XZBokJgMAWCP2DBslX6iUGXDngKSwnUBQkmt9Ae0E+c5s9vOKnrMXMh7Lpka9wylq3u4v1SYJRDeNQBQaSMvyX5VymRtfLX90ixXM5NEGALJQhGPUXEPOVPVgUgIX0Jrc6+0ztiguoy1ciPI+d3dfqY8usuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mMW9jC98oJp6IpUM9G1YCwa4nElBiGVuERPuBcO5/Y=;
 b=NM9XfIT/JxjQRoWQfciAYm3MY1OytZnRmRxZ1UX9uePVWRxoQzdYNrClmJFiw017M5lvjri+BrCDFJfUFpWJWFlce0xLqIjd2HfyvfJy3/dRWf6EjyZPAfY2k+aLZuUenpiR/H7wOjdUmwOUDVxHElAv/u3bAkM50KeXVh4kjafdbMcGA/52ny+7WlGARoNnRQEFcXQLzkO9Th15wGtFMffbltxc6lB3NDeMHzNkCGOkbO2IPPMY7dlUOUeEGXRzSGwcErK+HaSjbKq7MIsdJAQKzQoZyyhh+0+B7dI8vPYiTrLTXIh9PYaiTCgwUYBFwsXCd23Fjj0vcINDXTTxSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mMW9jC98oJp6IpUM9G1YCwa4nElBiGVuERPuBcO5/Y=;
 b=hqQjDgkCWsU+bK+UNTVlOIjemLl0KSH9//t7CvhSvQ8R3tmI0CSKnKuCVgF2WKmlNe1Sp0MYlC6YCG5RifJLzzPxrBPf/dmCkA29usSk+8DgCH95aATpVQ1CwURpiQi5xVPAnz9/ozoISQ04WJ3srn01KJOsrKvLpxZVB9V2lEY=
Received: from DS7PR03CA0343.namprd03.prod.outlook.com (2603:10b6:8:55::17) by
 DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Tue, 6 Jun 2023 16:24:32 +0000
Received: from DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::27) by DS7PR03CA0343.outlook.office365.com
 (2603:10b6:8:55::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 16:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT083.mail.protection.outlook.com (10.13.173.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 16:24:32 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 11:24:30 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amdkfd: don't sleep when event age unmatch
Date: Tue, 6 Jun 2023 12:24:18 -0400
Message-ID: <20230606162418.1862540-4-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606162418.1862540-1-James.Zhu@amd.com>
References: <20230606162418.1862540-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT083:EE_|DM6PR12MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f4be5a-bddd-430e-197e-08db66aa82c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nv13Txdi836xLfjw2GoxV+RLgImssmtgitKO3JZFruTxBjW2iuxEWp8aHLokLn4RsKY/JO/bLjFn9J2BayLzaKJEKk+DpbBnHbDNMu/aVh2UUlnsne4art+wrjE4QHVWnL51/UmOX0ofVwNaHpMChwF6YZ+depgpKX6SqX6a3rLF6lI1frCs+oFieKiAFoJ9KFQnVSelgD4kEqHb0ZJV5U+4uLn/Tj/Msme3N4WYbiohPnprkJlAP/w+aIAfViTXh0hv4/9a9UbEAU3NPeOaIwoD8Y8OAIRugHUbs7SsdP6b8Wtqht1eKAtk9uf9gWZ1K2gw2vbp+8UBVK/TyFGlDPy0tjg1qR6e9XG937afn1osqqSNP3RYdsCfm3iH6q+AvHV2PlPBilYtye+W8XTsM+z+7zhak5oIr+XU3V0LcMY6xcnCQtef2VV5S2igED7VA/g35kruoTbVI9JSunVXrbwkVS0Iw7ic8LmpPJv6D5PdghHgChUvLb40DYIczQzfyDft1tNRhteluw/VjTxrBpxd1UCzUuNOEi14XHmDIQG5DU0Fr9VDX6sffwIzGxn+jm14H5zKZ5rZLEd0i1+I+h3cZhTFomHXWAECwsKNhXzphDoE28vqLZI1c09Ffb8sETGxgWQmbBdZcPGk4Kkv+h4DqgxE45h+W+LHCq+oDMaEl2uXFxDdBGDNvBdMj9Z5jOK7v6q1MxOoC6ExIprWwfJ5VHbsLLCJ87JuU36E2R2qkjJSDCiJFvvgIeH6US6stvSlf63dc9U8RDTWUpmqXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(1076003)(2616005)(41300700001)(7696005)(336012)(426003)(6666004)(47076005)(26005)(186003)(36860700001)(16526019)(83380400001)(40460700003)(40480700001)(478600001)(54906003)(82740400003)(70586007)(6916009)(356005)(81166007)(82310400005)(8936002)(316002)(4326008)(70206006)(5660300002)(8676002)(2906002)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 16:24:32.6533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f4be5a-bddd-430e-197e-08db66aa82c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073
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
Cc: Felix.kuehling@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Don't sleep when event age unmatch, and update last_event_age.
It is only for KFD_EVENT_TYPE_SIGNAL which is checked by user space.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index c7689181cc22..f4ceb5be78ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -952,6 +952,21 @@ int kfd_wait_on_events(struct kfd_process *p,
 					event_data.event_id);
 		if (ret)
 			goto out_unlock;
+
+		/* last_event_age = 0 reserved for backward compatible */
+		if (event_data.signal_event_data.last_event_age &&
+			event_waiters[i].event->event_age !=
+				event_data.signal_event_data.last_event_age) {
+			event_data.signal_event_data.last_event_age =
+				event_waiters[i].event->event_age;
+			WRITE_ONCE(event_waiters[i].activated, true);
+
+			if (copy_to_user(&events[i], &event_data,
+				sizeof(struct kfd_event_data))) {
+				ret = -EFAULT;
+				goto out_unlock;
+			}
+		}
 	}
 
 	/* Check condition once. */
-- 
2.34.1

