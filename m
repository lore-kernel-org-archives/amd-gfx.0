Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B531BC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B49206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X1VBr1Ov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B49206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE13E6EA8A;
	Fri, 16 Oct 2020 03:29:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9FD56E9BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:29:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X84Y50RaOuviZUEqTOyn02pwu4dVIyFBRqjHfP65DqybKbw5CYvYD35JvVRjUbWVG+dyN2G9PqM9aTHQmVzjzd9tx9xx+L+/GErFD/0lgiInrw+kHzSVuE2SzBPe/1Wt4TGtsdgdjQIrrpLTE8jQrE6T0Oy0R1Ov+/7bU2//iVPA50JCVa6frH5DpfSKUE5JOb3I6M+hXOQ7z/3tm5PmCFZOrv0ikd5H+T0WO++3tTAqcfpWvbNLYJWI2dalEHpXVURScJD0A26MgocxkYjGPW1OUsZfQy17WZxeemz8gDsjdhVAqGhq/Byu/LOQO8ankcozzIprT82NhMtWSJUCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdIu/a/X5ZWSK9C4UaSzcR/AEseZxH0O+3UY/OuacgI=;
 b=JrlFrxDl0LUD+/HV5uCOEy6PmnWIZO2+n6UxnpONvPmGd1hEo7/LWS7LLq3KmwY17Dn33mz0DD/QOkbbfcjlchk/tSxDbZucTUa0AR8KFqYH9phometP14rLkSaDFZdmHgsCt2iemC1HmDyRHH4TVyGtohPrjeMDqeJJ568cbTTnK3VmxptP/XMX5Dk6BZZVI6TXNlO2ctaFVN2LMlN07wFpKE70JQrImtjXQEqqTNJiK8+pv9AvFnfvzpqUWGfHD8sZEMEyOgVAtSWjH3iyaqOE76cnPsM2Qz15zkdqIFlp3s2UTQjlu8QKzNxFW0u+AUlhFUQbgnrdqKVCcL3cLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdIu/a/X5ZWSK9C4UaSzcR/AEseZxH0O+3UY/OuacgI=;
 b=X1VBr1OvdJC3PNHuvb6j+Cchh6QhD06Lw9U2y+ozqF0a71/GawkNPVurCEeyA7buSiRv0CApKXeC/WcfsOBkFpYWQLQFDdfjk3Y8JtWP6cOkmejEWwqE4/4Fs6mM64odNHUADUdKEj/tbP0F+iOQBCLNmgUPjrY+SozrZqi0IiA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:29:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:29:03 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 34/40] drm/amd/pm: correct SMC sclk/mclk boot level setup
Date: Fri, 16 Oct 2020 11:26:46 +0800
Message-Id: <20201016032652.507-35-evan.quan@amd.com>
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
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8a38dca-a441-488c-9f59-08d871838f30
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB135438773CFF2A36F094261BE4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fn2dKk8n6W2gCRmQ+/5SLywpm4kGzye/I2k0xRejsqjTx+ebW1+2f9sw4BsPFONHhQUt8sJwAUv6JwAK+HwY8wycBaLpBv25lnnvE0rW4EKGVmevvjPf4FHaElgUSq3Yv0Bb/5fJzBU4sUF8T6Ae1inqYYl261dUzCH1Cd6WKQZC1DqW0Sl+j8INcmR768D5+WLw+9LMsGbL14LQg/AyVHHY5IGSdNlIz66dPcCXd9HBdwd59xstt40z3HJbRFn22FgtH5AHWjN4PmxJEkzA06e5Bep2Au8YdP8HAitNjf4M+7bUzgLTpx6gWlkG3b4Z/QeHDYuPfCjyOWhOaX3D2lPj7syC6l6XhK5cX1JUyLIpxynW2g/cm70hO81qmDaH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UdJe9oXdn+f+mqQ/5lzmpJTQKQtYDV13GzpSTf7CMgqGzdvFbItgLdGDKuQGlGzRyILez/3BAIDzRX4e+gAAvl7C5IdIn7YtqoQifBvXrFM6HyuchyarTWu/0JuC4AxfarMhkluDqy1lbUUNzQaLR43/FnBQPKXZr/z9+I4PRTzHamMYgaKXB89dXIU8RhNWpgBt6GIpxKJ8vg5LCEHus0rvOHk7W8nhgxzn4AsofhtSvV5xbCGaxyop41wTneX/daSIoRWjX4MXqRU3HXK6laJlKZQV0IDXw8Vuev5VeVE0vYwLd2hfWxZmCu/imbCtFb5OlkvHzjuQhmGenYeg6LPAx1dhEN2jRGj0NGw69FTR+3X2SPeIOjf5qSR1i8dHZ3jcw836+OqdOPBFOXl7RQFsHMHLADpu1iP3xV67QHb8TIyyqMJkGtGPZdg7Dt6EsT45orOzJ5FetR2B+8fhZAlaT9mWtEBuJIqunQn50aa0AEMCIbaYG4TQjbEblen2DQVP64iLLNa0Qj/dRP6/M1deb5ppAp0JxHqaS9LA6jdPq9I5CzHdJyM2eJRbkzTSw6sQ/KMU57rNi7uZ/GX7nG/LLZvscmvUGhYG82JZevWO+2DTgZjUZ8dhHPh6sjwYgTSq+YyIhrhg0wJeJ7F0TQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a38dca-a441-488c-9f59-08d871838f30
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:33.2866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grq5CgHG9FIcjiPPN43d3OTV/jHvcT+3loYFYh4vqRoqDymIJnHw2rPvAkKjiaOe
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

Correct Polaris smc boot level setup.

Change-Id: I0bb1cd916f65763ab6e8bb4a401508a3adbf8d2d
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index 47230d8fb592..d4253b1116c2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -1587,10 +1587,18 @@ static int polaris10_populate_smc_boot_level(struct pp_hwmgr *hwmgr,
 	result = phm_find_boot_level(&(data->dpm_table.sclk_table),
 			data->vbios_boot_state.sclk_bootup_value,
 			(uint32_t *)&(table->GraphicsBootLevel));
+	if (result) {
+		table->GraphicsBootLevel = 0;
+		result = 0;
+	}
 
 	result = phm_find_boot_level(&(data->dpm_table.mclk_table),
 			data->vbios_boot_state.mclk_bootup_value,
 			(uint32_t *)&(table->MemoryBootLevel));
+	if (result) {
+		table->MemoryBootLevel = 0;
+		result = 0;
+	}
 
 	table->BootVddc  = data->vbios_boot_state.vddc_bootup_value *
 			VOLTAGE_SCALE;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
