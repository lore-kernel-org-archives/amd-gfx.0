Return-Path: <SRS0=Eo1a=4F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5905C35242
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 04:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B22120718
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 04:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VK+/t8k1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B22120718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EF656E48D;
	Mon, 17 Feb 2020 04:47:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11E286E48D
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2020 04:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiOwzU8QjhdegS0aTsbyNltEqzuuMUbYm3LVcTuxR+v7/0J4y4MVKJB23SkFB2Fszqi/QxGBOKJ1T0gY/NrCsRFi3AKRQYkh54Tj6fOJ2oauGKStdm7ntXWFw5EPQtC07DK+jE7OOfpz3wtfFAAdhG7zpcv5t6ZueGS+quClgR8J6xDHcLqWUw+LivcdEC5gQXBevB70bVXXphOPUJPY9m79TaGGEd+hXzmBOFp8zgxTvYqiHviGqozG90ytOsPX5xWxOfiuQZB2P82GKZdRfeyocYd50ODN9SsnUnkjHqMXchLLGz4DRw8x/tjBtwps0UDiLKhbcknW+hhVGRk78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIfC7FNCZ5xSBrFKLT6g7WpBQerS068HNXxbwHBlST4=;
 b=A//TvqJtMo6zpNyAdwEPTE9JG+vwk5U5ussKHsCjucpkJnJO1DXguYlMEBpc+f5LxGDsCKnrZFz0pKL/joa/J9Q/qoqQzqzodhBZZoi685sNTtrNwwmdbd8NdJi6c1eR0Clf8Bvd7IFnuDVbnuDbPzpxOjW8EP1mLn2WlmGfGROYZa+z3AIvYys+wHzprfeKtKj9O3VcSkLOETq52ECMzCoJc3tCtGb7/yXhQTM/kvXIvJndWpZIUQ99kX1k7hI6z+cfF8mmWI4NroavKJDxO3lOrk+0cd7VroT6J/jA9QJHGObud6Khabj6J4c7BlA8afjzaZG2Uq9Ym8yHhEEdCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIfC7FNCZ5xSBrFKLT6g7WpBQerS068HNXxbwHBlST4=;
 b=VK+/t8k1fJlieBVWccAnGrYRnvztcq6TCUe4LOcEyzpMR9MvTwdyTmJrq+50Ach8wxpBO/Xg2TnSpOs2SR/xfP+giZPdBr7qKiLBBUS9VO8x7k7QcsBMSAHj9GxTcTwsSqeOgmJPHkv2BvMyLvqG+tF12IlEbZU0bTN7ixK9jHA=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4189.namprd12.prod.outlook.com (52.135.49.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Mon, 17 Feb 2020 04:47:11 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2729.031; Mon, 17 Feb 2020
 04:47:11 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Wu, Hersen" <hersenxs.wu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/powerplay: nv1x, renior copy dcn clock
 settings of watermark to smu during boot up
Thread-Topic: [PATCH 1/2] drm/amdgpu/powerplay: nv1x, renior copy dcn clock
 settings of watermark to smu during boot up
Thread-Index: AQHV4z/Oh0hGghV2r0CjHNwhlajji6ge0+SQ
Date: Mon, 17 Feb 2020 04:47:11 +0000
Message-ID: <MN2PR12MB33440740F9B0EEADC326074CE4160@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200214140508.4582-1-hersenxs.wu@amd.com>
In-Reply-To: <20200214140508.4582-1-hersenxs.wu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4abff677-d6f7-4917-a409-0000e054f7d2;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-17T04:46:20Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ebc8178-a6dc-442e-6a44-08d7b36473bf
x-ms-traffictypediagnostic: MN2PR12MB4189:|MN2PR12MB4189:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB418938B79B984FB37A60132BE4160@MN2PR12MB4189.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0316567485
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(189003)(199004)(66946007)(52536014)(55016002)(966005)(66446008)(9686003)(66556008)(45080400002)(316002)(5660300002)(64756008)(66476007)(4326008)(478600001)(76116006)(110136005)(81166006)(8676002)(8936002)(7696005)(81156014)(33656002)(186003)(71200400001)(6506007)(53546011)(26005)(86362001)(2906002)(32563001)(357404004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4189;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N0G17A2WMRIkClnyWVB9gbEx9GffLMbziyNAhkEVpo1YU6kT/SC1709Y16Ez229jygaR57tpcejR66Pw2FA7nqMe9lrcCaFkva1BtwVu/hEbpRSsB7jzaMBC3/vaoO0xqDe+e0IWxybH9ytseP5MNhjemWPetbhF1V+8c49UpO1lDI73WGBlrO3YqISjWGvvS671dQNCYm0NUud6+6XLrbmxv2qFx+Lk8Edz6RTcFbFZveDVFK+Ek3F7Id4CapARamKLTMx5KnlbtxvrnKLTzeP29xdA+ziXnono91y+T1fUhJurnMFsvswOvi1EtcjxpE92YVd3eoKrYqZWFiCLD+K3MMzKuZ7cv4mrpCKFk/R2SzOzQSHLO3ry69KlLyhy9MwIcMdj8WjZMQF+kl2YQ2FjK/4R1zFTGxy3NIaWW8HfVtapBG3rqsAV2k6htU8dmqtE6NvtVgROiYk4k9cdEdUPZLq2C1nDUSKBAsKI8MMiquoPxIohmUUdgC+FHj4W2tLAChVJUPETT391V7p5xm/Q3N5hY1XghmbVjDAL9GUT6EdURDcNt7D6Rsr4SlGDbx2U3/Ec1GQA29ZmmAaepw==
x-ms-exchange-antispam-messagedata: pZkjpgFZUgELzfI4JeMmERBxqdI6cvtlt674tn3dDRVRNtJ+ENKySk5goS/2Wuv7pFvj24yhneL5ZDu5nN1H/yU5/Is44FxEDUF1FkQxKwGYiTXv5hEGIQ1A4kl0XK4KQMEH0kNbyZo/IvIMVq6RPQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebc8178-a6dc-442e-6a44-08d7b36473bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2020 04:47:11.4301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Gxj01OqDasnUWVJezTTq7yqwDvRHmBMiRkSCHGLGVNTyYU0HYzgQTavmYHZe0gU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
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
Cc: "Wu, Hersen" <hersenxs.wu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hersen Wu
Sent: Friday, February 14, 2020 10:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wu, Hersen <hersenxs.wu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/powerplay: nv1x, renior copy dcn clock settings of watermark to smu during boot up

dc to pplib interface is changed for navi1x, renoir.
display_config_changed is not called by dc anymore.
smu_write_watermarks_table is not executed for navi1x, renoir
during boot up.

solution: call smu_write_watermarks_table just after dc pass
watermark clock settings to pplib

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c |  7 +++++--
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 22 +++++++++++++---------
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c |  5 +++--
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 9f2428fd98f6..882d5db427db 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2056,8 +2056,11 @@ int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
 			smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
 			smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		smu_set_watermarks_table(smu, table, clock_ranges);
-		smu->watermarks_bitmap |= WATERMARKS_EXIST;
-		smu->watermarks_bitmap &= ~WATERMARKS_LOADED;
+
+		if (!(smu->watermarks_bitmap & WATERMARKS_EXIST)) {
+			smu->watermarks_bitmap |= WATERMARKS_EXIST;
+			smu->watermarks_bitmap &= ~WATERMARKS_LOADED;
+		}
 	}
 
 	mutex_unlock(&smu->mutex);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 0d73a49166af..aed4d6e60907 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1062,15 +1062,6 @@ static int navi10_display_config_changed(struct smu_context *smu)
 {
 	int ret = 0;
 
-	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
-	    !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
-		ret = smu_write_watermarks_table(smu);
-		if (ret)
-			return ret;
-
-		smu->watermarks_bitmap |= WATERMARKS_LOADED;
-	}
-
 	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
 	    smu_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
 	    smu_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
@@ -1493,6 +1484,7 @@ static int navi10_set_watermarks_table(struct smu_context *smu,
 				       *clock_ranges)
 {
 	int i;
+	int ret = 0;
 	Watermarks_t *table = watermarks;
 
 	if (!table || !clock_ranges)
@@ -1544,6 +1536,18 @@ static int navi10_set_watermarks_table(struct smu_context *smu,
 				clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
 	}
 
+	smu->watermarks_bitmap |= WATERMARKS_EXIST;
+
+	/* pass data to smu controller */
+	if (!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+		ret = smu_write_watermarks_table(smu);
+		if (ret) {
+			pr_err("Failed to update WMTABLE!");
+			return ret;
+		}
+		smu->watermarks_bitmap |= WATERMARKS_LOADED;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 810994017f49..bdbf1fc48c68 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -810,9 +810,10 @@ static int renoir_set_watermarks_table(
 				clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
 	}
 
+	smu->watermarks_bitmap |= WATERMARKS_EXIST;
+
 	/* pass data to smu controller */
-	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
-			!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+	if (!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
 		ret = smu_write_watermarks_table(smu);
 		if (ret) {
 			pr_err("Failed to update WMTABLE!");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C742d1723754546186b7e08d7b156ed07%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637172859262316999&amp;sdata=FI30%2BEhDIYt7MASMtIAALJ2USnR6nbo3jKC6ZXSuOWI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
