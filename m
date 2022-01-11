Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C98C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 17:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE57A10E150;
	Tue, 11 Jan 2022 17:31:20 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F6EB10E150
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 17:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIINW3wDD4XIICalHcCk5JAftwK+i+tX+GfiLhB4+8M/gL7HB0P0EWQRJ6xua675PYVbnSB9qr41SWxQC+K2ky1XbMf7jHe5kCtUXqQ4ZRpDWLgzVUPIRo2D6rNsDwjxzyVoXREGs3qVacLJo26/tDG4da9AwvhVT73Hb9HvCfhc+PztGEn0nEGuhCHQ+3taQMdKsUTHHPK0PZImvhxEY209ZUehs2QQ0AHnoF1CUbzqOMNhpoVVhQJ5DA8e7pFwPJf2yVUlxsE8zP1Qnqa0Sj2+yu44UZfEysnwO15FsLuU5NVmdgK4zjhsymdsjYvmLKMpiqt8QEEqpN8bTMRL6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEZ9BvAREFj35yxnLrrZsbNWM7Nl4x16pIw4gf0maOg=;
 b=iy1iA6J/5f9qeVc8j+UvbzT8n3AlYyZSrlGx97KBbJuR2FIUbmd0bc56mg2nn0cQnwC0ED+vtfwNo+ft3MUcUeWFkmD8i5Elasjv9zZaN7jltnkgHAaLljseyD2KVOMyMKctQPGtRd+26v/7WqBoaj0PpcF93Gz+XhQKv9V1O1br0MfncPJSU4imd46Df9R816OaEr9KVCXY0WqYQHdVVloerHf/lA2eQrSM8zmanVs2k8Q+gV6hng+TdOMwS4uAmHilLklHNziwzSBe0IRFnjVuGzyQLzbVf4MZxL23AY01jPggOAK69MEa1JYXNAjrUXjXzwbM4ZCa+9Fm5UFIiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEZ9BvAREFj35yxnLrrZsbNWM7Nl4x16pIw4gf0maOg=;
 b=NDJTh2OdwIF6/lRHQRUm/qIWhE5BdTDDaiWPpqXxst3JFgVUK1+Lrg9Qazg4Oo1kMHdZkRZ+eo7DMvC0BgVnM/QKig/Ec6CkDg7jYRmXlcUcLUNa1h20m6reIKlgMSsf7hJURuxngdl8M4Zcw4gyXFGcYGWfqxuhQrFzaZ045Z4=
Received: from DM6PR02CA0112.namprd02.prod.outlook.com (2603:10b6:5:1b4::14)
 by CH2PR12MB3735.namprd12.prod.outlook.com (2603:10b6:610:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 17:31:17 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::d6) by DM6PR02CA0112.outlook.office365.com
 (2603:10b6:5:1b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Tue, 11 Jan 2022 17:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Tue, 11 Jan 2022 17:31:17 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 11 Jan
 2022 11:31:16 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix ASIC name typos
Date: Tue, 11 Jan 2022 12:31:05 -0500
Message-ID: <20220111173105.699766-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1f26dcb-afbb-4ebd-fe0b-08d9d5282c75
X-MS-TrafficTypeDiagnostic: CH2PR12MB3735:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB37358921442FC57B349650BA85519@CH2PR12MB3735.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvGxKUdDQZiqUoZmlaYA33lJH6Ejrk36AeCsXmn3lanyHFmXT6vf30q7/VDM1uqpNm4OBQt6MSBc7snGWyK9MQLebgyD9hhplBH7GPKcy44247kOJaJpZ50hqPsev3KucqCII2kERVG9XltRcNibV5Izc4YHP/MxKCNbIuylrReQ70l7JODvI3hA/1MsS83E6w4UjsEHej/C9GYSqTc52kbyZ24Q3ey09/9ETzHp4DBjwWFJd6W3OtmkE12MfyKvsH00PboUEX8akKItSNojPMWNFWQZ6aHHFV4EvZUajBwywJryg/fT3QwjGvXt0MzXhUnLpwlEkwQddxdMWjhJT5wyoa0+T1FHeUrE431WFQ+0rBWnRjkOM9L6dD9U4885WNpUftyx9uBJckSWDehRbAlMVrs9lbMfbXsoufubvrAttjwjqLBrndSt8tt4chrg+UFj3U/8UkKI+2Rh9acJv8xNE1DXKo/ojKcrNNDyoBCxCmVCG8QCTNNJhQFT8o6K6p3oNRFmT3jr0/ioURg07OCXYc/n8O4cFdDIfjEl5R3zZSPVpwBGIQebQQQqaOmoytJf7zrmWttPmNmwfcAPdVU+orJo5f7QwcU1oF1QxmgPF/4q+OLDdHoEcZap82mqSLdWQRbo2a5cEX2TUQ+K6jUiDhCjiXFmDeNy3MchaQmoUVdOjDrFEv5bgeT6GAdnOryt2SuykJKEYmuDkTlQ/8fVlc3KH77DYSkfp/BCfK/DYFfu4OI15Exmaj0xXjFtjiqLPtjXfxsaw9vsBPvRiWRzLiFLq3TPL5o3wmMDer0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(81166007)(186003)(316002)(356005)(16526019)(4326008)(26005)(44832011)(70586007)(6916009)(426003)(336012)(8676002)(36860700001)(70206006)(2616005)(40460700001)(508600001)(83380400001)(82310400004)(7696005)(2906002)(1076003)(86362001)(8936002)(5660300002)(36756003)(47076005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 17:31:17.0036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f26dcb-afbb-4ebd-fe0b-08d9d5282c75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3735
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Three misspelled ASICs in comments here, so fix the spelling

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 127d41d0e4f0..2b65d0acae2c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -68,20 +68,20 @@ static void kfd_device_info_set_sdma_queue_num(struct kfd_dev *kfd)
 		case IP_VERSION(4, 0, 1):/* VEGA12 */
 		case IP_VERSION(4, 1, 0):/* RAVEN */
 		case IP_VERSION(4, 1, 1):/* RAVEN */
-		case IP_VERSION(4, 1, 2):/* RENIOR */
+		case IP_VERSION(4, 1, 2):/* RENOIR */
 		case IP_VERSION(5, 2, 1):/* VANGOGH */
 		case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
 			kfd->device_info.num_sdma_queues_per_engine = 2;
 			break;
 		case IP_VERSION(4, 2, 0):/* VEGA20 */
-		case IP_VERSION(4, 2, 2):/* ARCTUTUS */
+		case IP_VERSION(4, 2, 2):/* ARCTURUS */
 		case IP_VERSION(4, 4, 0):/* ALDEBARAN */
 		case IP_VERSION(5, 0, 0):/* NAVI10 */
 		case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
 		case IP_VERSION(5, 0, 2):/* NAVI14 */
 		case IP_VERSION(5, 0, 5):/* NAVI12 */
 		case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */
-		case IP_VERSION(5, 2, 2):/* NAVY_FLOUDER */
+		case IP_VERSION(5, 2, 2):/* NAVY_FLOUNDER */
 		case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
 		case IP_VERSION(5, 2, 5):/* BEIGE_GOBY */
 			kfd->device_info.num_sdma_queues_per_engine = 8;
-- 
2.25.1

