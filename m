Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05887C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DFA64E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DFA64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 782386EB4A;
	Wed, 24 Feb 2021 22:20:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F23AE6EB43
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv4+UUEoFelVXwdIeiXfKKFT2leAXzpIVhwO3Xp+Fw8vbkGR95np+CK4kHfjbkZaHVkl84Pw/ypHXrHJgoigOA5k62v0ASH4odrQhCImB81ux4B8Suu1zFnOulKs2tcUv1qd8xK8EGwfK+FHDcDAdkwU07fmbY/ZyKK6AV/qxv9f5pTSwNiLnr30HwQ558h5T8+DuXCndwEnCru4AgbGTdgZGfcwMn0qRml/VgBk2u8bqeLNwTojfjrT7ddieRNI27DFXSxBYZQkNdTN4NmRdr31CKk9exHM9Z25vhpxZUh5K6kAJFfJakWTE9eXDPjTI2OiZ+zHmyAOnB8Z45xv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfoBGy4JKdmI50zIrPLZJlIRa+U+n43O0cNgXrc+SLo=;
 b=RUdToqZckktHIdhk1ySWX/P5OvLbxz6KI7SSl0nhEnRzUPvGKsS2EKTHN8tYSxnhGAVRUvdDvrdrVcS4wlKzmpR3P/QtdklL2tEv/6L3xrF3SM5lq6tSIX9y4DKMZVkVrEqXe1XVi8YBjugSbTmWbWTIKjNybvQRboMKzYQRk6nbQ4EQ7bnGbcsGqoTNjrG3oQMT0jim453jRToxVDNHS+Iclyzc/KcmtvPDK20Zfl5wO+0yKF/OvTBLZyfAesmXBHIHpJlQfU2kUvf/rQUFyamKco84sf0m3q0As6sJQEwJvsJTXwt9h24O5REKlNZF8B3I3X3lK0w1imRNevdfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfoBGy4JKdmI50zIrPLZJlIRa+U+n43O0cNgXrc+SLo=;
 b=RQ1kKNzQtduU0HBpcy09/nhOWf8vIltV/r/Rqlh2Lyq2ZS5JoRLLiLOc4f+YKiDjmbXyjAhX9gDkhDacAVekYRbZWod1TKSMFV1LcmEeXK0pdLGNwT5FD2v7QPGPINP8wimf8ESxtVShe4tYICPj01KX3XUpJNYllGe3IK1maxo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:29 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:29 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 065/159] drm/amdgpu: added register list driver ctx (v2)
Date: Wed, 24 Feb 2021 17:17:25 -0500
Message-Id: <20210224221859.3068810-58-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d108583-0b92-4477-a44b-08d8d912562e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175B63FE36FA90E63F44E10F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zq7rJ3So4jyeaEVKRf+fRs2yyrWktviZVvShiAevo5AJFMsIgiIVk/lAAhkBqzc54MFeXw1WhP3bMvZP48vM2EWfjoCH8VXqOTNe4len+3xUJIyXRWx+5UjEF8ysbmxr8o9y4qeRPtSc6O4NLfVc28gx0awGCyBfgqUKcGZwqfJtZDPIO2AcXUdY2nt1svJ+7D6Ov6QDXDL5hgrSfm8LcqwtMJAO5QXubLOMK1gAhWqVHBv6y1l5W3qx4cuurzVpbPeOoSIbDvTZGxkUwyEfMq23JO2AW8FixJPrV+lA3X837L/jrhRSJP+lxsIjJRgx9ISzbnTiaC+a9jzeT7iqSl+/rNr/P4hSbfcQ9fQgYWiqYpQLUp1NHicz+A/yOYX7lYS2ny3gtj76pukSQZXCiqKO9bRr9T7fbIlSWjHed8aqDx/1rRLlOd7uHe7xFMne6PfCqPGWSp5KWgeVNbJCbsntXb0N4ijCcFV4uuVEdUHV+gDisBh2hdEViiaOhlxszHM6+fR3/mRa2u92TIpyALmIK0QZhzx7ZEWq0IKwQCwFH6GP82GdGEheQNbHLI1EKpxiaM5XBHFJUwEVciSiIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ko8X29K0ITY9R5icH2/jD4SH3Wtw27HNKGqAoqbLilzC+V6crCiZmHFowLjK?=
 =?us-ascii?Q?RlA18zyfmB7W0U5QpUlT0R7wRWa4vVCZJx9wQOddsqi18VkBqam5xRCr7F3H?=
 =?us-ascii?Q?OUdHdnHNjk9TAK4HgqDhr36q6/RSjbAefZAN15I0f+1/0AmwZfEG9r1hJ8aB?=
 =?us-ascii?Q?PNQYVCadD22qPxZI8THVy6+nE0WlekKWYBrARg+/mL3bzZ7eUjavt3m9hb7A?=
 =?us-ascii?Q?n66aFK7Y27cXRYwm/enbi9krEP5BW3Di6IusfHy1KDmRzC6w6urGLp+xaBUQ?=
 =?us-ascii?Q?i76rRc5Ez79zUV7M6sd8QBjHSEV960juUagKByNDluPWVDt9cVtARTXNJ49X?=
 =?us-ascii?Q?9jAIqx+dGLfll0HFt/FDQBQG9vuZiRk/aueLCz+PHoQ0N4PWOa2156/QqQoT?=
 =?us-ascii?Q?VlDQPGH98Zu6BBYuaV9XVuZhfpr+gvXjVvAl1rx5vFQrhSVf6h48KU7b/gaU?=
 =?us-ascii?Q?6OAhpEbF1dNTszA4UisKBa2X374ELK14U0INB1VP+MVX57o3i09h8MCiD4xQ?=
 =?us-ascii?Q?/pc4mcZw04JMHK/d8z6Z9k7f/2VcSN9E8T6hcFa1ykD42zXqnT7ZGGQ2nvhM?=
 =?us-ascii?Q?05g1bzKt/INxR/a9T8egIcnoX5aPyST2JKcDqVD9J8rKRf9mNFieHBZz6oIV?=
 =?us-ascii?Q?M8PxsIY9JbULXCN+44puqGdY0w7N/I6hYP74pvANhgvV2MsKsoz28/TSluz8?=
 =?us-ascii?Q?cQJo+XZHeKacZQASWu0UEOcOIlAKaoH1G1sqM7jtqJOf/HESLW6UP1L7xh0f?=
 =?us-ascii?Q?6h5tGVScRumHGTilTmTFTsw9nVLvCeBACDL1XVBTAMdQs3B/o5e9cIWU+Dq9?=
 =?us-ascii?Q?UPV8o/txaJhMW8F0KzIBinwdrzwqDdR9aNt9QujONmEilVk3hx9bMXMjUTwW?=
 =?us-ascii?Q?kwGrxXI1ZbXxook8Lm60fbt3ouepQ5wVJAjGh7X3tnCrfVFgo8L8eDU0wWt+?=
 =?us-ascii?Q?01cnJ/LSefx4mV7ad++Z7JltWaExJqCF+HBbSN96ZkqsUY0rCW5a/M3DRMbt?=
 =?us-ascii?Q?p3fpivfJAkyKKWev05BLODLI6eyRzaOMjFFGZc1ewQ/k0w6tzmtSJ+W/EZYi?=
 =?us-ascii?Q?fWMZy6kyxpUFaeMI5GNXQGWgai2kpViPFXrIGgJqKrU724gXHdZ9kX/Sy9qj?=
 =?us-ascii?Q?sLIzaL+auewXWX/Dj6lRpyUwuxvMUkcYiCbsgxGZtWl5IT5o4Vs805qqMAsf?=
 =?us-ascii?Q?qMOHiwCn1Z5bDfmb57/bZ723DhSA5mSaXQ0r6qg/f3CkOuYeH1WbEFiI7cFk?=
 =?us-ascii?Q?NaUbSSJI4tgHorjulkh9i8YLYSq/dT9Cgam7MjlohwDH5z9Tog7YBCoFG8M7?=
 =?us-ascii?Q?FJyIY+5L0B4XN2Z7jyMFiz49?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d108583-0b92-4477-a44b-08d8d912562e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:05.3552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2n33tI6MBJDXsGJVkaHGcTBRPe3cD8X7/KvKciIOiYftGAQPmms3kihNw4tdZxsd+1PaO95N2oMQuhJtRWP8hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: John Clements <john.clements@amd.com>

updated psp bin parsing and load register list

v2: update to latest interface (Alex)

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: John Clements <john.clements@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index abcb2721df15..8dc88258d729 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2756,6 +2756,9 @@ int psp_init_sos_microcode(struct psp_context *psp,
 			adev->psp.spl_bin_size = le32_to_cpu(sos_hdr_v1_3->spl_size_bytes);
 			adev->psp.spl_start_addr = (uint8_t *)adev->psp.sys_start_addr +
 				le32_to_cpu(sos_hdr_v1_3->spl_offset_bytes);
+			adev->psp.rl_bin_size = le32_to_cpu(sos_hdr_v1_3->rl_size_bytes);
+			adev->psp.rl_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+				le32_to_cpu(sos_hdr_v1_3->rl_offset_bytes);
 		}
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 2ba6490fa487..b19717b2e110 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -248,11 +248,13 @@ struct psp_context
 	uint32_t			toc_bin_size;
 	uint32_t			kdb_bin_size;
 	uint32_t			spl_bin_size;
+	uint32_t			rl_bin_size;
 	uint8_t				*sys_start_addr;
 	uint8_t				*sos_start_addr;
 	uint8_t				*toc_start_addr;
 	uint8_t				*kdb_start_addr;
 	uint8_t				*spl_start_addr;
+	uint8_t				*rl_start_addr;
 
 	/* tmr buffer */
 	struct amdgpu_bo		*tmr_bo;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 46449e70348b..8d4239b8f71b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -105,6 +105,9 @@ struct psp_firmware_header_v1_3 {
 	uint32_t spl_header_version;
 	uint32_t spl_offset_bytes;
 	uint32_t spl_size_bytes;
+	uint32_t rl_header_version;
+	uint32_t rl_offset_bytes;
+	uint32_t rl_size_bytes;
 };
 
 /* version_major=1, version_minor=0 */
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
