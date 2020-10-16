Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB00C43457
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1120206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4M3r1XYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1120206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4271B6EA87;
	Fri, 16 Oct 2020 03:28:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD8B6EA87
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEXyIoNYKFHIDyh273v2eD7lzAqGToyAw0T6FZOnc4TpZ+XmzcaIhqho9lsIGFWBY9RIEShEMKwuu82BhSc2EOCD/h/EAoEsvrWvLEOG6DKCSd8QSWl/Yp7ZQ6tSYVioeDyi5yKas0ucP6hlbAMACd1pkzroD2C9S2jBX7VJ2V/fKCh1DYRuc/9pZOcRAnM7DeOeHxxhpK4vWGKerl3nOYhJW5qkZg8BDUB9TvyXraFFwKT+L/T/s14lKxFwW1LZAfvwHQWRN3bbksDlbBEVtxQ1Zj/iYOgsigQl9jeGyJZB2/H2gYOzbWov4ZUehyhJPyJehfnJfOPQSiwzgn72hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=309nebs/tyg+RZ8bE5Cpaa0iBXh5oWyDwA2fO47RzxE=;
 b=bys6klnWQ2ZrkBhoIvH1pKOa7AZaYcaTRMcVelAYHivXc/fL7HTa3+FGrzfGYp3NJlx4ntOh0Fi4GiQ+muDu6Rms/xLjn8h/yx7xzRrAVGW9dtmS4/HXVDjwnjOIoX1XBWpAnjJX17Gjzcfue78oyX/D8jBcMLYpgEW6pwShcniJKanglMEXqFXOfpowdQOoZUpOBS4X4lDb7gP+JItrTgCOVw7+V8XsAwhWel8CltLQiegXmzEHY+XOExk4l+Jv1ILQBlQGNpMVEmYt1slENsERsgW9Mo9cIztP78NwzSCIq8eMhR4krR6H6A/Y9g/+8NZJLnYl8QGfTtGy+A5BTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=309nebs/tyg+RZ8bE5Cpaa0iBXh5oWyDwA2fO47RzxE=;
 b=4M3r1XYh/RWVAaZNZISAM60q+2iVNXHZmiZL5wN4vxsqatmSVEsW4V4tKSFeKuH5IInm1ZaG3p3Ms6tsTisVHLcY6ku6UZyOOZPcJZOWSuLd0iy1AJvxZhL7dWD8eHX73C9EOk2o83hzxae5VkzwVwsdlc+0NVZhzE+0iMtlSD4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:27 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:27 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 31/40] drm/amd/pm: correct the way to get the highest vddc
Date: Fri, 16 Oct 2020 11:26:43 +0800
Message-Id: <20201016032652.507-32-evan.quan@amd.com>
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
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e0532b5-bd2a-41b5-39f3-08d871838bb7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1354AE63A40068665755AA2FE4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HesBbpufsYPXnZduRMxSEOclUxXldJdTMHpTHkqA4qL3sd5GaemqzOgmdXZaulDaahHPvuCXCCN134tWLwTYgCYCA0bs9QEtvHuqgPCslMYYVtDftxhFNREpL0w6rT+gLfpA91HouzQB7rsglvTcmAtLG8gt9EctFeINreOOzgQ3KhuPXT5waztpKV+KEDnqXBNb/Tof8TVpTr1VEmNPryQ8XjTzHc4Oefvvtu455Xi0FjzTR0hRf/HzHp0/bpq9Py/zv17YFuB5ypEUY6mF6D5yLrHeGJZMHlitwIzqtXJzbLHEwbjtCHj+QoYFl4VdILKLQgmZkOVjeXcLjyWGKTtPb3w45zgOzJuDU8otumVuu+35Tu4nLcNd2FsAQryzN5Zyf1i8iJ4k7lxZ7uohz0vRU5mzOFwIIV6M2BeX8jE7K40/IISuanT8okYbYAol
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004)(43043002)(15583001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: WkuM/EtQE8F92gEP8BRslO/c2of9hrvhsifqsk0AD8bWnyCnG/6HwB81XAKNMmSTjkdOc4+wq7F7e9RXY66Q+jqOoCoM3TOl9Yv6/TBo4okUGrCaG4FOZRNC3bNNzhhDOpN9C5ycNSJXV25EE9w0ZefX5kETqjVAQAc5xlZQszS+wnssy6Ry8ua/JggSeGsfTioPInePi4QoERUTxfIoSIjSWQSeX/jlrFpHZmU4mRfnZqvbcvMddHZYz6dBO9ThbZoBtR9WBd0h4rAN7xmBLpGt8jT+UMgmpUhLevEzQfuH3h/lcA+ggmsgEGFFJWybiphItMFAtUUwK5F1HI0RY0J9W70LMtz+HAaERcKaW72aaLn/z160KrZGqMoLwIAuuNuCWjUGEnrC4juG8eD5Q7K1bHstpqyISBIIGl/nK9EihRyrUoL5bUpUrvW0/jcVKYilIt4nNNjtajwUJyzV6xLGZd0uDZNPqjE1OYQcfBz/YpJOpoEdwejxrIexwWDpxqMqCBVnR7Mhh2um0dZycR8nCs/Sg302Sq4xG07OkvgP605Sb8C1Jdg7F+SFxzzyPWY7Ur6OAx4ZXLOj4vDuavaZr42guW2IunzDmdeJKLODGk5+Xs+fbbvik0bRfEyqfWKcdFoExW6uJX9Is5Qcmw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0532b5-bd2a-41b5-39f3-08d871838bb7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:27.3639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FL2KVnC4iqKU50d1sM43U9waPrs9RjRFlzJYxTBW9UAXW0T1LN0VuwjlFRE9sNtB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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

Populate the correct highest vddc setting on Polaris.

Change-Id: Iabbfa11ddd44352610d71079bdeccc2540253365
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 1f13b88409c7..7eca860236db 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2282,6 +2282,28 @@ static int smu7_complete_dependency_tables(struct pp_hwmgr *hwmgr)
 	return result;
 }
 
+static int smu7_find_highest_vddc(struct pp_hwmgr *hwmgr)
+{
+	struct phm_ppt_v1_information *table_info =
+			(struct phm_ppt_v1_information *)(hwmgr->pptable);
+	struct phm_ppt_v1_clock_voltage_dependency_table *allowed_sclk_vdd_table =
+						table_info->vdd_dep_on_sclk;
+	struct phm_ppt_v1_voltage_lookup_table *lookup_table =
+						table_info->vddc_lookup_table;
+	uint16_t highest_voltage;
+	uint32_t i;
+
+	highest_voltage = allowed_sclk_vdd_table->entries[allowed_sclk_vdd_table->count - 1].vddc;
+
+	for (i = 0; i < lookup_table->count; i++) {
+		if (lookup_table->entries[i].us_vdd < ATOM_VIRTUAL_VOLTAGE_ID0 &&
+		    lookup_table->entries[i].us_vdd > highest_voltage)
+			highest_voltage = lookup_table->entries[i].us_vdd;
+	}
+
+	return highest_voltage;
+}
+
 static int smu7_set_private_data_based_on_pptable_v1(struct pp_hwmgr *hwmgr)
 {
 	struct phm_ppt_v1_information *table_info =
@@ -2310,8 +2332,12 @@ static int smu7_set_private_data_based_on_pptable_v1(struct pp_hwmgr *hwmgr)
 		allowed_sclk_vdd_table->entries[allowed_sclk_vdd_table->count - 1].clk;
 	table_info->max_clock_voltage_on_ac.mclk =
 		allowed_mclk_vdd_table->entries[allowed_mclk_vdd_table->count - 1].clk;
-	table_info->max_clock_voltage_on_ac.vddc =
-		allowed_sclk_vdd_table->entries[allowed_sclk_vdd_table->count - 1].vddc;
+	if (hwmgr->chip_id >= CHIP_POLARIS10 && hwmgr->chip_id <= CHIP_VEGAM)
+		table_info->max_clock_voltage_on_ac.vddc =
+			smu7_find_highest_vddc(hwmgr);
+	else
+		table_info->max_clock_voltage_on_ac.vddc =
+			allowed_sclk_vdd_table->entries[allowed_sclk_vdd_table->count - 1].vddc;
 	table_info->max_clock_voltage_on_ac.vddci =
 		allowed_mclk_vdd_table->entries[allowed_mclk_vdd_table->count - 1].vddci;
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
