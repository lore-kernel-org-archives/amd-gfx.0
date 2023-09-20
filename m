Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BADCE79AC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 08:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977A010E45F;
	Wed, 20 Sep 2023 08:37:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EDFD10E461
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 08:37:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtzIazUATqGEduT+eWgq0hckPCK98F0lhgAjJ5uxEdNNGqMOy6Ra4z5sbCGQKqH0p6DECoE6u3NgiSmqA6gxK1zpWpUDKotVrVCsEOA9m6g5Fw9pOWp2M0HMWDYsZxWZREpjaLOcngd8rumBidKWU1gljcRMZbDEDVPGtTCs4S7VIE+ObqQj3F+/RDWmDw+00oA8mH7OsOkdF9Gfsiv7ai5q5RhydWq+tHC9JAvs0Exh2TSX0kwZodb4rlRZaJWbhY3VOZIrJ42szbk6KNGxPGsEqP9hQDGBV17Mk8DEMfVeZiwQG9RMRZtpnZ3AA8m+EEr+Usw+J5jJgSWuR1CELg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXBjy13w6HFOYWMVirt1IiQ8I3cfUZT7p/5b0xP7sds=;
 b=Sjmmgt63GB0AKsKamKN0YN5+LKjJR66mDFsgayWtoBQc0sTYQqzN9Q7Ea1CvKSQfcHQsXKKaEnoPnO8of+D1XQ6FtESbRM2H67+LfodoYeMMN0RJOy9vFkXpMo3Ss3DNE7LFZpJw+q5OOP8jVCvJEltBMfG5gWfL/nrAwO4wRKcovgoFD3KTxblEpGVgQO/nYng/+xz6Hx4d/aRLJqi0/WUor5OnxPrNdWfkrKyNFe1iKyIAUB0dmVpeElrIcEP12DHKSKapAQ7UxaE1JbUL3m6pVW/dl7gaa7etgxp4A+CM/9xDjnupE5etRrN9mLwhaIe9bGI4nhNq0DSMrLWZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXBjy13w6HFOYWMVirt1IiQ8I3cfUZT7p/5b0xP7sds=;
 b=C36zii8i3XFhvA9zwrI7ftka+2mkEf/wZe3A7vp09A4TG/LWDAqjQL0cVme38gyPwzt4spBRwKdqTrILP7dNrulQcVPSyaonMPJJZU5MJ4EDgBCb7sfLnaOqHVoU0cJyfxHzXIXRXF0L0Wufxh6er4qz9zEgB620Vi5i/QCn7TU=
Received: from BL0PR1501CA0017.namprd15.prod.outlook.com
 (2603:10b6:207:17::30) by DM4PR12MB5038.namprd12.prod.outlook.com
 (2603:10b6:5:389::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 08:37:45 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::26) by BL0PR1501CA0017.outlook.office365.com
 (2603:10b6:207:17::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26 via Frontend
 Transport; Wed, 20 Sep 2023 08:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 08:37:45 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 03:37:33 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <candice.li@amd.com>, <kevinyang.wang@amd.com>,
 <yipeng.chai@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: change if condition for bad channel bitmap
 update
Date: Wed, 20 Sep 2023 16:36:59 +0800
Message-ID: <20230920083659.8237-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230920083659.8237-1-tao.zhou1@amd.com>
References: <20230920083659.8237-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DM4PR12MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: e7283f86-9da3-4899-ed79-08dbb9b4dcc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WTTnIHvJtOE8Mj9WnUt4b32D3S9PyhTbFT5EA57+rPeYkN9HXtGDr0U6qYM/6Eccr9ErZhsawMRJTQ09P+Kz94lgvhZ3XopJuTdUqrRF6YAYiS/7NYDF2FVlABmB/BPoBGnA/MCKQsMpFoWNOXj5nnRPZxnqpyBetW6mdt0/DgtXqLYD6gTEf9pRWw7czegfdnS2sg1+rB40CbkuhPs2MPuk3yB/h5YOV9PudgefwPz0QPUqN+cAcRPpGRfxHDX65TTM1bpdLnxGUGY5K+369y9Ooi1tNrSI6OTGsqOiBsnmPNISLChuw0S5qt76sBwILNXZq/cPfJhs9CvgBSTbTnd615m6yXoHh2YHyf468kij1eopLKhgHkSewKNW4nk0nIRgvcNH7seMU6ZEisk0xGOSWSWJ7MqjUF3P3Ec7dR2fDtAD36TD3jdSho/X29/of5yHebLmBA18wfNSDWF7g8hplS6FUBKACyc9yjgS0tZcc2vVb9+8ezP9cYJvu5VWUML5Xh5G1NKg2WscZ7HWuaoMCAdzA43yKoQJPOi5mjqzaJmA08Yo2MMkm55XDwruYv1C+lGU2pcroxgyhv7jUJJHvGEhQfzKGchDp6JYwHLb5rq01jaXV09ifAMW1A0Sft/80v/R114TogG9+VmJtDEDoz2xdMSTuw+OxSCzKapix28N2fPIZxaflmtmWB/PV+yUYypOLo1HGzI1DHPaOKRRingSYHetabKjN22ubGZ6ltxeiEtglhEJqY6prKewIiET6Y1M/pth7iwWj7uTGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(186009)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(7696005)(6666004)(40460700003)(356005)(86362001)(81166007)(82740400003)(40480700001)(36756003)(36860700001)(1076003)(336012)(2906002)(15650500001)(26005)(2616005)(47076005)(6636002)(16526019)(426003)(83380400001)(478600001)(5660300002)(8936002)(4326008)(8676002)(110136005)(41300700001)(316002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 08:37:45.1602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7283f86-9da3-4899-ed79-08dbb9b4dcc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5038
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The amdgpu_ras_eeprom_control.bad_channel_bitmap is u32 type, but the
channel index could be larger than 32. For the ASICs whose channel
number is more than 32, the amdgpu_dpm_send_hbm_bad_channel_flag
interface is not supported, so we simply bypass channel bitmap update under
this condition.

v2: replace sizeof with BITS_PER_TYPE, we should check bit number
instead of byte number.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 8ced4be784e0..c60d2f79eeef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -616,7 +616,8 @@ amdgpu_ras_eeprom_append_table(struct amdgpu_ras_eeprom_control *control,
 		__encode_table_record_to_buf(control, &record[i], pp);
 
 		/* update bad channel bitmap */
-		if (!(control->bad_channel_bitmap & (1 << record[i].mem_channel))) {
+		if ((record[i].mem_channel < BITS_PER_TYPE(control->bad_channel_bitmap)) &&
+		    !(control->bad_channel_bitmap & (1 << record[i].mem_channel))) {
 			control->bad_channel_bitmap |= 1 << record[i].mem_channel;
 			con->update_channel_flag = true;
 		}
@@ -969,7 +970,8 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 		__decode_table_record_from_buf(control, &record[i], pp);
 
 		/* update bad channel bitmap */
-		if (!(control->bad_channel_bitmap & (1 << record[i].mem_channel))) {
+		if ((record[i].mem_channel < BITS_PER_TYPE(control->bad_channel_bitmap)) &&
+		    !(control->bad_channel_bitmap & (1 << record[i].mem_channel))) {
 			control->bad_channel_bitmap |= 1 << record[i].mem_channel;
 			con->update_channel_flag = true;
 		}
-- 
2.35.1

