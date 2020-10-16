Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59981C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17A8206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V6TfyoFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17A8206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55B266E97C;
	Fri, 16 Oct 2020 03:27:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8F66E97C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kn69eaf4a37zfjW0MmFAEbGNbBuztJe7groty4/EHjXjxGcGVM8avONXhHnQdttjTv0Vj9iN1s1CnZOQj2DiJy2e4zLykf64eCxu1aXmPPkSC6m0GDLyKYxOs0i+az/VWOQrmBII76+3iXuQftghlAdiqEY64UYCWFUpR2gkiaCudtLz5AfO5vp3xV6Vlb8ElKD/aRhVIHK60iSH2QFWHwVNa/rNYutzRcfItR+q8HZ3KQkOSZ+qcsrOgLu/nevXlUlrDRMs5Tw/neAY8cG0/hF91XuT54GLV/wuLlq7ZR3ktmFzd1X2itKQJV/FvNisdI6z1fATVa9sl0Fuu2hEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwK6hdER751BRz1WbxvanK/1vPtQaJ0v86z+Hiukfa0=;
 b=gTNPkx6EKPXKyRcs7awF4oIVFKwxE3Fi7beUmSwWBL1oS9NmyYxxKu763WawuxRPof38+LFVfqcNKgu79d9Os9r7LwvQ538NDFiW7EirHPecWhZg05Vc3DXZis5+oJ2pQ0rFte6YEznf3kp0nuce+fQz5B6u+82+Pd1CZ8z4V4opdaWXCgvKqSWq3aCbevnvrLpT74qgfr+2sAnbUSTi6L8BWSW86r8QBg7eLW3wmnJHEkY07HPlgK1f6jKFVxOuvwApVRKYLchb4F/dvA0e+ae+PDnhXkrRKlzWCN/qxHHbDrGQaqMlyPXoasKzqLo7kBMaUxnpXVbg6rxe6GMJ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwK6hdER751BRz1WbxvanK/1vPtQaJ0v86z+Hiukfa0=;
 b=V6TfyoFIML1WWnOHpvy3jznh6zddn9Gbf7C4f7vNqg3Q0YjQl+1ialNK192YrhQisonAkJMKDJuGjhmQuyXDpbI+hsG/95C+8TvqeMseXf+wLE/WVVQu5vMZLQopnbrZoSTrH/zMUMTol751zWC23sCa3goscUd5rxVeMVqLc0A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:27:35 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:27:35 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/40] drm/amd/pm: populate smc vddc table
Date: Fri, 16 Oct 2020 11:26:14 +0800
Message-Id: <20201016032652.507-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4e28ed1-4dc5-4174-3f67-08d871836ce6
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB4680B948AB0D5458E18B764DE4030@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 03Liew2/BbrQpjL891rdpUKFLwjq2mA9QzTyk8jakTVS9li/2KNSpkwGYyHG0aePQAoGTKuXQDzBbA3NT1ds5O9GIurbnvI63MJn3I0PbDa2c55uJ2DINK2OlJx0J50w25zJK4pZWkSvgYV0NlY1czcwfH3pwiXqq6ZXR9tciIEEKDunoQf1nLPz4+XFB2p4+B14ZwqvrSf8AobkRkIEEJw7GHyED5kbdG053J04gxjtxLGMb2m3aGog/JNYeMAQXxALlofuZuLTyJGy2NBVRWgn0R1Ia2GWbcdlAmmDqIV2R/7yhIhhWfMNUWHi1o3vkyRQXVVmS67Pcg1P7gKQ1rKppV7qzUGgesXuCyMdjraUJGiDHz6JzW/sIiFHK1Gt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(4326008)(6666004)(36756003)(316002)(34490700002)(66946007)(6916009)(19627235002)(5660300002)(956004)(66556008)(66476007)(2616005)(44832011)(186003)(52116002)(7696005)(86362001)(8676002)(2906002)(6486002)(26005)(16526019)(1076003)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KAF65//xhDUiZl+vHb+5YU+OA22dczRQgKpnyu/RUxbAz93+Jg0fnsVK0+A+sujkQSn/O2dIUm4wCUQ35x1mXx7oeOPFF/aMZdWYLntRHC9oIHMeMnz/+cQdZ+VtOWxHrLAWdRfvbROWEGsokwONmsLyjAAqKRAdFNjrjyfT0pgH3AqXAbFMZb0rXWUblglmO9UeJqQbucj38wne1VkTzx1y04SoyT1hQOQxUtbHvhmVQfQD9k/IbOPnGkYR1kCHUSxBlIqL3354ty1PF1Iztkl5U6jX66GdBD5k4V3mtjqD9UC6hLDtnDD2nn481edjoO9GL/RprZMmk9oKJ5PjKXk6F8DK41ifh3pJug+5cE+yznkbvI9i3ZfT16WJGlOgn1LcJl4J8ZEILG+0fatUZGay2o9iBCw7ZoJUjtlE+N0KDy0psHTymMSNYex4sIeFQeg4gHB2rqTl7LEmn+qAzKVlIqnuaqtzcRhgCcdgZFkRowRiVdkleiomj+lxwNMVIlEqEjwD2Lie3ugD2rQ2Vn9xda7wRWJEh6IBrMx9YGyuah0Z01IKvSV5Hlp0o+vVIAVVjW8mENFYwGEnJt/njwOqdx6m+yLKbL4hZ1xBkVaz4jBlcDCzGVdjXM7zbOqlbZ1+tPI2HB53FYlepQTSkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e28ed1-4dc5-4174-3f67-08d871836ce6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:27:35.5887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoCj2D5nW6XnKcMOoAxFsIF381k4X1FeUAppqh6mXXvo7+4ozthQ8Nyf8v/I97uN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add missing vddc table setup.

Change-Id: Ia104bb685040f9779274b2dacda5a4744067d3af
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/powerplay/smumgr/polaris10_smumgr.c    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index c3d2e6dcf62a..4a786b159bbb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -671,6 +671,31 @@ static int polaris10_populate_smc_mvdd_table(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
+static int polaris10_populate_smc_vddc_table(struct pp_hwmgr *hwmgr,
+					struct SMU74_Discrete_DpmTable *table)
+{
+	uint32_t count, level;
+	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+
+	count = data->vddc_voltage_table.count;
+
+	if (SMU7_VOLTAGE_CONTROL_BY_GPIO == data->voltage_control) {
+		if (count > SMU_MAX_SMIO_LEVELS)
+			count = SMU_MAX_SMIO_LEVELS;
+		for (level = 0; level < count; ++level) {
+			table->SmioTable1.Pattern[level].Voltage =
+				PP_HOST_TO_SMC_US(data->vddc_voltage_table.entries[level].value * VOLTAGE_SCALE);
+			table->SmioTable1.Pattern[level].Smio = (uint8_t) level;
+
+			table->Smio[level] |= data->vddc_voltage_table.entries[level].smio_low;
+		}
+
+		table->SmioMask1 = data->vddc_voltage_table.mask_low;
+	}
+
+	return 0;
+}
+
 static int polaris10_populate_smc_vddci_table(struct pp_hwmgr *hwmgr,
 					struct SMU74_Discrete_DpmTable *table)
 {
@@ -725,6 +750,7 @@ static int polaris10_populate_cac_table(struct pp_hwmgr *hwmgr,
 static int polaris10_populate_smc_voltage_tables(struct pp_hwmgr *hwmgr,
 		struct SMU74_Discrete_DpmTable *table)
 {
+	polaris10_populate_smc_vddc_table(hwmgr, table);
 	polaris10_populate_smc_vddci_table(hwmgr, table);
 	polaris10_populate_smc_mvdd_table(hwmgr, table);
 	polaris10_populate_cac_table(hwmgr, table);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
