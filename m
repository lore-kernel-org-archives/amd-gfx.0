Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B5DC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 11:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9B420706
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 11:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kthzzrng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9B420706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E90FD6E207;
	Mon, 24 Aug 2020 11:59:06 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690087.outbound.protection.outlook.com [40.107.69.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E44916E207
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 11:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXAbzlcnfih6IBQ2983Oks5Mx4yUPzFAA7ctFLGSZQNTV8nwe+CyJkqViseRkKUtVVV12z7i1qKwCQPzYQCRJA1sgR4Nfqpu2iluS+YbhaHfqUWgIeJw2GjqkdEnMHb8IBMd435+vcy0iJsVUGSIrQmBiBX6TqHcdMwBhx1jSn+u/vm0rXzNNqXaHH7zwIg0rmdTTjvfdYn3Xhy0Xj4pLBXBgYnwACq4TIoo/HPRjsIDpld60V0o43CW9pFh3i7oGy8ugDtRBr3q6G/hLswqhVXE6PyQlM0XjOz2aGNQgM5Zd++PB+fWPRmc0vijQUXubtqjtJIzBETgSAz1uxNM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nNr64iS97iabWysxwEE2Xjb3klkXfwJ47f9PleOSoo=;
 b=NrLyxIYTCx+3G5r1fL8oC0Gqj3G5DjQPslFey9wcKq8LSb7IINlMpZOb5Oj9g6dWV9b+V5quLJcmq/wDhOjqIuAPPelLuenueu05RTVz/xvs/swXQLbe++pAn4NcJn+p0lTV2bbCrHD6AhdGHSC8zYrJ7rCx0Tj8CCEx5hEJUwL0mnaj6CBlZ5IUuSIJLgta54UnEJWCsjlKIugjgduHn4Jm81B9OFXYxcomTgDt+Q/MyT1RmFYFSxHr8GbJKPy44sVRb4wKgYj80wtfawC5DgOAZPCBBe3QluZCSCxQAENeVZU12tcPfPGpvZiYvaYQcEUmvArZxd/1VkOsVns4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nNr64iS97iabWysxwEE2Xjb3klkXfwJ47f9PleOSoo=;
 b=kthzzrngo+miU/85dAp6j6f8xl7f5JgyRn7aox6YKm/UWO6nVoXrcm6a8ywGmZCbEfIvW/vl7c5SKWD4RdrsnSZwSTSlqdwSipYb1DSbsD7LbG8xCzX18Qx8DMTxpDOHbmWdCaiQ+VnC9VHKqbCquxVpLJmsu+4pe8uYic6mal4=
Received: from CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 11:59:04 +0000
Received: from CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::f564:86dc:de1a:63b7]) by CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::f564:86dc:de1a:63b7%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 11:59:04 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix is_dpm_running() run error on 32bit system
Thread-Topic: [PATCH] drm/amd/pm: fix is_dpm_running() run error on 32bit
 system
Thread-Index: AQHWefSm3w9Yr3cGjku+/K4y9f0hWqlHJtZA
Date: Mon, 24 Aug 2020 11:59:03 +0000
Message-ID: <CH2PR12MB4326C5DAD1707EB4F9E7D338EA560@CH2PR12MB4326.namprd12.prod.outlook.com>
References: <20200824085922.2134157-1-kevin1.wang@amd.com>
In-Reply-To: <20200824085922.2134157-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b15dae98-a907-47c7-8ad7-fb60da63a35b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-24T11:54:52Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d529fc77-5370-46bb-53f4-08d8482518dd
x-ms-traffictypediagnostic: CH2PR12MB4309:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB430985FD22A56A448E7484F8EA560@CH2PR12MB4309.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yT5MFPaiRi4N0FYOexR/D2VFZviSQMI2mpE+kTpPKDsBD7k1CukBLKQdlEVdh24OcV7GqvxHA+q/QqVGTPyAc24FhdRerhd74QiyoV/gLW30FpsykNpXbn+fqtBy36pCZP/HwPthLmJXiYLYMr5TyB9IraFQAa2GFRn9QZXnqkT+9JTuIJ/cVu3oWhKRZ57FMMF/XJsuv/zLrsqwHCSAXsJph+O95vaMxt0i0XYvK8cg5xgVxkFzLrDql21mVcH38n9XLGw2v7POezJGerEI0O5kgjs++Ana1GWvnKJifLR/MPiqWvYzAj7/EfVFD14oinPvOdq1vUd4gXnPAaCbIgJqhdJTW1P6P3+8VOgeIww=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4326.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(7696005)(33656002)(66446008)(9686003)(86362001)(83380400001)(71200400001)(478600001)(110136005)(66556008)(55016002)(64756008)(66476007)(45080400002)(8936002)(54906003)(2906002)(6506007)(66946007)(966005)(186003)(76116006)(53546011)(5660300002)(26005)(52536014)(8676002)(316002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: RCwlk5YhTp9K+X4DCaf2WOqNkpOUKyA0vaVW0vUm5H7NjW32dhuEQtgcyA9L79GdO/CejVfe+g159Fz8exYETvEn2YQfwLOIK11ftE+8bBRcXHIStPlopSKHk6ML/3Wg1c4Ix7oPjXA/0gvu6g01D3ANpJUcX8N2Sbsi+4WYq3qSRA8F8EbmfrSYBxViYpmN+P2fvxPp8OGxIs+A3AY1DHfrqy4EB12+6ECpRmT9Qn33XK+W7i1XLE1Ro3nezris0fjDDvlRlqhc4ISPW6527Xvr3Mr4Vg8Sg6F/EQ06J4yPIH6YkD8yjuG0iY1AVMzVAgckx+m9vAFeev08cVsAjR9Id7NsAUXVi3mCvw8k7VG2eHcAbfic1FOMyAP/D1xC4sE9m9oAHqy7EKWNes/824kC6xRq0eAK1hCNMtZvNo04dWegsAl2X0laeye+aqMRRx7ob8RtsmqNdP5NLFaG8jr13YQmwkGOSSsX37I3gm73edwGLLBx7gzqFIgs1RmOWNbFZhZwpnV7nDKI66fgg4Fu941h/LHuaHiabtUXTPCS8yrUwR84r2W+lLfF/ZK5gcCyADIw0UqgylaPoxBELM7iuoqf2WUzxh3wwpypSRic17k+Gu/2b3xjqdoK/urQE0qktaYGwba1KfNHIsU42A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d529fc77-5370-46bb-53f4-08d8482518dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 11:59:03.9007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9M2SQvtnKCyAHqPSQ1JyoBzf5o/DzFHMus80HaJazoN2tWOjpjX09iZpOuL8GCgVIk0mCSHqVG//63UpJ6Uwfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Good point, but  I wonder whether the outmost uint64_t cast is necessary?

Regards,
Jiansong
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin
Sent: Monday, August 24, 2020 4:59 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: fix is_dpm_running() run error on 32bit system

From: Kevin Wang <kevin1.wang@amd.com>

the C type "unsigned long" size is 32bit on 32bit system, it will cause code logic error, so replace it with "uint64_t".

Signed-off-by: Kevin <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 9 +++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 9 +++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 9 +++++++--
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 8347b1f2509f..e619315b0f5c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1844,10 +1844,15 @@ static bool arcturus_is_dpm_running(struct smu_context *smu)  {
 int ret = 0;
 uint32_t feature_mask[2];
-unsigned long feature_enabled;
+uint64_t feature_enabled;
+
 ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
-feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
+if (ret)
+return false;
+
+feature_enabled = (uint64_t)((uint64_t)feature_mask[0] |
    ((uint64_t)feature_mask[1] << 32));
+
 return !!(feature_enabled & SMC_DPM_FEATURE);  }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 72f3d68691d8..d95b370adaf4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1345,10 +1345,15 @@ static bool navi10_is_dpm_running(struct smu_context *smu)  {
 int ret = 0;
 uint32_t feature_mask[2];
-unsigned long feature_enabled;
+uint64_t feature_enabled;
+
 ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
-feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
+if (ret)
+return false;
+
+feature_enabled = (uint64_t)((uint64_t)feature_mask[0] |
    ((uint64_t)feature_mask[1] << 32));
+
 return !!(feature_enabled & SMC_DPM_FEATURE);  }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 66d655958a78..f8df6448ab4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1150,10 +1150,15 @@ static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)  {
 int ret = 0;
 uint32_t feature_mask[2];
-unsigned long feature_enabled;
+uint64_t feature_enabled;
+
 ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
-feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
+if (ret)
+return false;
+
+feature_enabled = (uint64_t)((uint64_t)feature_mask[0] |
    ((uint64_t)feature_mask[1] << 32));
+
 return !!(feature_enabled & SMC_DPM_FEATURE);  }

--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CJiansong.Chen%40amd.com%7Cffe808387ca14e51bab408d8480bc717%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637338562729795065&amp;sdata=U2xw6nM06S0Am3TFYfyLhCHob2k3UH%2BYgMX1hYFKKHE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
