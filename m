Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC31C43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 19:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BCC21582
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 19:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="okWwEPH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BCC21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC2FF89C83;
	Mon, 16 Dec 2019 19:33:54 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B47B089C83
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 19:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gi25hV/VWUywc5A/uEHAmGsK0Zm+NKXFFAT/zKB7H3JkYBnsBQY1C3OsyCa0b0sdXmJgN6alnPj83MwORy3IksQXmDpxYW4bdsyBW3wCIk2GNfS4Gz4N+2XmiqxX7QrD6qG5KjGcGQOj2wdQ3kyPDJHbGZX7yGelZSv+vHsy4bPvPmm5HBwtlxX1JJ84+hDHf6FsbQDNFJidXt1sPu+wPfiKe5eFTBX03+CS+mmkRqc4iiYatcJWXt4ncIxs72yHq91MufHLD8AL5B9sRpJdrxB8yUHCwGpovEC3FXHPsGp3uIPB2wyH1AR70l0UQzkCMJjwK2+Ku2ysyplLq5xR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kawfHqHV/RM5WsqBksw4/HNRKxtxevlN3WLJ5CHU7/Y=;
 b=BFvEs3PppMsbrYB+3JfCDxKpBHCJoVNjCvw1MBoPQNIWDdtaqq86LcDEZjU7vT0yoYVWngXpHAG9lDcYMoXDrjSQJu49pu6N02xYLtCe+t9kskKRAGs43NDXqWPI1nYzgpx4sbX4NZJQ4Luchg2cGnm40b/V3S4DYPxE0EfmoPJXkGJsBtytpdJ1f96WK7IVMe+FRIR4Jy2YhbbQQ0qLxmmy2DzjuolxeCKm92FZzgEtR4/o5x7p4MzCkqmnfZrxgXgIOsQRDG5nnhDxRbjcJf9RBDDLLNhMhhQvnTFJXOClvraZVyRwfQLhcjX1qMbKDyK4I75/sLVW4gqSOxsBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kawfHqHV/RM5WsqBksw4/HNRKxtxevlN3WLJ5CHU7/Y=;
 b=okWwEPH9Os5fXK7M1GqWQwJKbCrJovLVFvVf/1JlCrNNi/1nT7VUeTqadE4Ilz12kz74TKuUE3cH+2yLVGZlCO9Cge19DMtA+WP1NaMOLRRBLAp4nR8TJZvhdtRDC6MRhQMsin+bcNAQHI4hZ/El06H5neUuyQaklz5426GKtVY=
Received: from BL0PR12MB2339.namprd12.prod.outlook.com (52.132.11.148) by
 BL0PR12MB2403.namprd12.prod.outlook.com (52.132.28.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Mon, 16 Dec 2019 19:33:52 +0000
Received: from BL0PR12MB2339.namprd12.prod.outlook.com
 ([fe80::9c32:dffe:31f5:49ca]) by BL0PR12MB2339.namprd12.prod.outlook.com
 ([fe80::9c32:dffe:31f5:49ca%2]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 19:33:52 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>,
 "Wu, Hersen" <hersenxs.wu@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: Add SMU WMTABLE Validity Check for
 Renoir
Thread-Topic: [PATCH] drm/amd/powerplay: Add SMU WMTABLE Validity Check for
 Renoir
Thread-Index: AQHVsdVXARYCrrTBukWTTOtvSOnRTqe9K2bg
Date: Mon, 16 Dec 2019 19:33:51 +0000
Message-ID: <BL0PR12MB2339F67134CB65A08D07205CFD510@BL0PR12MB2339.namprd12.prod.outlook.com>
References: <20191213164931.26471-1-zhan.liu@amd.com>
In-Reply-To: <20191213164931.26471-1-zhan.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-16T19:33:50Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=33849a3c-59fd-4ec8-a9d0-0000aecf6ab4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-16T19:33:50Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a92d6205-3c0e-4b97-bd3b-0000e39efbd5
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hersenxs.wu@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: afe73165-6910-4f51-77f4-08d7825ee1ad
x-ms-traffictypediagnostic: BL0PR12MB2403:|BL0PR12MB2403:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24034E23EB1E02704DE2AFBAFD510@BL0PR12MB2403.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(13464003)(189003)(199004)(71200400001)(8676002)(33656002)(7696005)(8936002)(52536014)(81166006)(478600001)(110136005)(316002)(55016002)(66446008)(64756008)(66476007)(66946007)(86362001)(66556008)(76116006)(53546011)(26005)(6506007)(5660300002)(9686003)(186003)(81156014)(2906002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2403;
 H:BL0PR12MB2339.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vQuwYL4DTuTvy6RsWustzWUVSJTcdo0JFr5B3R/7t6okBZasVrlxWhbu64G8vT2flDBb4xLTPEdmRypYEr0XLFevHOov67ccRWQv1Um0c9jNmxrM77BenEcLMJjcTUGzAGxjiXOPunfhNmHN2xe6Qh83D008Yqi4qyp0oD4fac30u3qZ+6SQqJD0bq6xCMIsL3DQhU2HOL35mbFL31IIzOC3+CeRTns9aNOupIUC7HvRoL7IrHj7WA7qY0xcN9BnjaSZNU0Ks8z2EzaYZDzVs1gCv4AmWp2ZDIKIDALn7o5YoQdPJyNkK6vGnwZLQpUoQwCaHx3hzXzkM/I6XJXo8XJTv9zyVupSfqzGyYTabXZet+lCnj8x9Z4S9aab0QfE063cJ1WxgB2Xue9+F7fnX+aSqMj+/j5wgdI7p5WQwh/V3WE2cu5oMB2l72uRQ2BIRkRzMP3J315fWm8+TZALT9I0AKytX8HbEhJLy80RZAcuZpTcXf//5CRTQ4M0rRUWQntYAwkpkSqQEn+mJoUhnw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe73165-6910-4f51-77f4-08d7825ee1ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 19:33:51.9853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JClYeJvPe7TwPDSSgfb2hTc9hgjqgqNgrG0Le7uYlwPCk1edFkbp4mhdUc1hRE/TS/dPLZxAAm8AxPxIdrlaCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2403
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

The patch looks good.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>

-----Original Message-----
From: Liu, Zhan <Zhan.Liu@amd.com> 
Sent: Friday, December 13, 2019 11:50 AM
To: amd-gfx@lists.freedesktop.org; Wu, Hersen <hersenxs.wu@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Cc: Liu, Zhan <Zhan.Liu@amd.com>
Subject: [PATCH] drm/amd/powerplay: Add SMU WMTABLE Validity Check for Renoir

[Why]
SMU watermark table (WMTABLE) validity check is missing on Renoir. This validity check is very useful for checking whether WMTABLE is updated successfully.

[How]
Add SMU watermark validity check.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 89a54f8e08d3..81520b0fca68 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -777,9 +777,17 @@ static int renoir_set_watermarks_table(
 	}
 
 	/* pass data to smu controller */
-	ret = smu_write_watermarks_table(smu);
+	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
+			!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+		ret = smu_write_watermarks_table(smu);
+		if (ret) {
+			pr_err("Failed to update WMTABLE!");
+			return ret;
+		}
+		smu->watermarks_bitmap |= WATERMARKS_LOADED;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int renoir_get_power_profile_mode(struct smu_context *smu,
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
