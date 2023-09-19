Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4228BCD54A9
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 10:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB6CE10E374;
	Tue, 19 Sep 2023 10:09:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A04A10E36D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 10:09:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8+qLYXZ5dIsF0Rd2zgrzM+8V4zR2rmUw/apb9TQIeapecMYMmwG35owX1tm6VYNGlBSZGidTdecjyzl4iplAY/f93WIEshqtGcUQ0/d9Vr7rrBz91X9wl1ENzsc8cnfL1709IciHWPPtNpoHpCZYuONJiniLwpPR98XXGRB+eIZAxbTRc62irJ9hIHJSsc03aIalfsvUNxA45KPQxD8C8TIekFICyDHJDfEK0yxNh+FZM1Kv/tNVRde1JD8VjAFzYzfzLVYeo1+J5vxKX6e1jh9EVwMnIWCxh0KoRJ42goWIecjQFMl3xNO0JSWNTOXXcOnsFkLupLP1I4kDsp0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Olory1FSIMWP0x6kgbaTml9QaerX4rWtphsZUVuS3GY=;
 b=oAB3Raz4Vk+gKA1Guqf6ACkgBTnwa6wqlWLX1v0Eq6+pAelLf/XexYWgtQChTl2UDzkhUTT5lzyBD23BjMwvRO9WBuP3ZQnGFsy1CzfWf964PgQoPYCv0/aTGZF4sME8Qgf+4oXo34br4VinXtmsekieTf7fdwcUukGrPkrVSas5OF2dJyUA75CPp6G1n0nXad8wZdTH5WBsfPNUT4sKSEt679Xgj+d3U6I3WQH0brpZ3d+mdZMb+CspBeHdJf+F8MoVUJ2kZO/yPDCssmh+XsB7hFqqJPpwAyJI/9cVVfH9U83aCW6gVkBF3I0tXf6p4Qwt62DVrymWfNx4zDmvJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Olory1FSIMWP0x6kgbaTml9QaerX4rWtphsZUVuS3GY=;
 b=EH5cBQEUTCCKObRKzkku4OuOSXX11r1QnTCQCoL3FKyX2qrOCSu48vRD5ZTJZG0IKVK4d9tqP24UHf2IKQeACYTPA7Voi6PRebIt4S17GscWSsWBz8FJKp3+kuoj7aHHv/a+ikLShsw3OosE0hzCl2WCioEy04MVQHi5LzUgROQ=
Received: from MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::35)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Tue, 19 Sep
 2023 10:09:53 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::9d) by MW4P220CA0030.outlook.office365.com
 (2603:10b6:303:115::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 10:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 10:09:52 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 05:09:49 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <candice.li@amd.com>, <kevinyang.wang@amd.com>,
 <yipeng.chai@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: change if condition for bad channel bitmap
 update
Date: Tue, 19 Sep 2023 18:09:36 +0800
Message-ID: <20230919100936.8810-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230919100936.8810-1-tao.zhou1@amd.com>
References: <20230919100936.8810-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e8bf07-1506-47af-c4dc-08dbb8f890f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7eawm7fAaPYpMC/eGdchmu5nY+KIU7MNSAT6Bi4jZZCupec8KwX0Xi+Ee1WL+2fZckkYtRt2Wy7eV3gXzzrFT6StDRbo5OWTT+NULWTLWtO8tDA6whQVdXnxVaigYQm5k9n7XLRqM7F7l2gBfgSNwHckgQ4q5hk98BPR23BTYg8JflfEhp8aMLwePIm+GKzWbnPQfnkOWzDnUJWF/MHL19EaiZxG/FPqVHc1q7jFBs0fD2FOpwXj5iFd6CsSZg+qhbC/MFMYOviJZ2lxh5mq/94zeuQ0k9u8Vun+dsYW9TJe9CWSdCLc1ll+DIzJOnyMWmTIfagyVqQNco4KD8eqrDDiCIB7FaPkH5Ypg1uCPPdvW59iHVEZPRiT0l6AtDmxGHQJkqs5MJYRN6ZuMlDCZIElkd1nlGxf/dOPAdLDEb/TQeGG7uTEvZTx7sa0eVK4/HvWF+iW4n4N2B4nVssur5dCFYW/ZNQoyqjz05U8tIS3L8OnStiq5VgnwYDZWUwvgsWjKQ2ekffEHyO9SUbjfjiPsxAHNRh7FzWeh5VwjwlWbV6gMvhuSmJBuSSA9ZvDtoijshGvDxaNHqSfAYoXL6EvcE9P0X2IGTsZCKDv+RxOamQzZ6ftbFWX3bm2DkPrtoTUgrDx8/EBDIKG5TBaBX1NyTuyeUwHiIceP6S+Crw/rKScUv6AstTmzg3cTKMxEzps6dFBg7McJLqBIlB08HgZQUZXIl1xFcOpV3GrsHTyk9B+GxDoEewX5pZVD8zyon2KRf0FMlHbHUJL4GKTTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(82310400011)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(40480700001)(26005)(16526019)(336012)(110136005)(41300700001)(70586007)(6636002)(316002)(1076003)(70206006)(15650500001)(478600001)(8676002)(8936002)(4326008)(426003)(7696005)(36756003)(40460700003)(36860700001)(47076005)(2616005)(6666004)(81166007)(356005)(86362001)(83380400001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 10:09:52.4961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e8bf07-1506-47af-c4dc-08dbb8f890f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
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

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 8ced4be784e0..1c4433f22f4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -616,7 +616,8 @@ amdgpu_ras_eeprom_append_table(struct amdgpu_ras_eeprom_control *control,
 		__encode_table_record_to_buf(control, &record[i], pp);
 
 		/* update bad channel bitmap */
-		if (!(control->bad_channel_bitmap & (1 << record[i].mem_channel))) {
+		if ((record[i].mem_channel < sizeof(control->bad_channel_bitmap)) &&
+		    !(control->bad_channel_bitmap & (1 << record[i].mem_channel))) {
 			control->bad_channel_bitmap |= 1 << record[i].mem_channel;
 			con->update_channel_flag = true;
 		}
@@ -969,7 +970,8 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 		__decode_table_record_from_buf(control, &record[i], pp);
 
 		/* update bad channel bitmap */
-		if (!(control->bad_channel_bitmap & (1 << record[i].mem_channel))) {
+		if ((record[i].mem_channel < sizeof(control->bad_channel_bitmap)) &&
+		    !(control->bad_channel_bitmap & (1 << record[i].mem_channel))) {
 			control->bad_channel_bitmap |= 1 << record[i].mem_channel;
 			con->update_channel_flag = true;
 		}
-- 
2.35.1

