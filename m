Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17502C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 13:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D6E20801
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 13:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UVOXF/m8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D6E20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D6406E8F5;
	Thu, 11 Jun 2020 13:49:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB98D6E8F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 13:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIcOYBAg6wLIAjuH1JJl+EGp0dhn8azRiZ5UMLZV4shrlaC8rzZYdHPSZANtsiSKVYEGDR5wo5a7DgqhkBB8Fl4TUKCkmAGIF5U8kNAaYG0VALykHhc0IPdDDCOyc7sNxaP2BMVqqNiPg6zqYN+/fi84PSmIbJ3tssM3o7cqyaophs/YFliNTStRvodGXbUbuasXC2LZryjOWQkxS9FObUrTTf2jpOpbcwJFKNOIQsvFkals/zTyNFJ6HFJDcHtGXhqdlEPhNXxOI9gXHiWNbAKOBsXvytgEJp2j8aKWCfFqOtHvNB1mcQHKZmBB6a4TjlC55xDD9X7+jRtCGKU21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsom2unx+zm368NWjSPkna7dpKfW1xlnlfahLhdeXwY=;
 b=fTCv31eu8W487JuOypUoNvoGVa0B+6Tplq82/DDzinYckunrkUr5z2Ib51OlJhFuBy812Iy0uc9XzQDavY1mImqPD0ume6tSI5NMYWIp0OQypXW2lojGi4lKiOGb1TweJ3jFDLp/vXLI+fOgxpzgKA06ngNz9R7GBUiWSAludpY3cZBXmkQafFollcv3HTkqt0Fc7BxKDPrJzrwLGac1/o3P9XK3GfCKwCLDOoML+KAx9/9QmoFj/0XlDFg3cZejwZNg9GX8bU7ULY/fwTAX0m9CGLCYiJDtMQfCx3JOI6bjNW11OfbO4nSg7f8Gjy/l69G2vxSfPfv7nISIJPTA1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsom2unx+zm368NWjSPkna7dpKfW1xlnlfahLhdeXwY=;
 b=UVOXF/m8r1xCgpUPghZoRUSjiDM9+biWJHgYsujNBwt94LFpnRhwPDtBVyWSsa89EqxK2RFWKFSGTGm5afUjVJD7mqSt6p3vF3wO8tvyLAmaPUPr3JjA0FbcxrJ4XfgSSPpBuKGmYvTzAH+qasgdEGoddMWcgA7Ls0KjJs45OVM=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1288.namprd12.prod.outlook.com (2603:10b6:903:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 13:49:43 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3088.018; Thu, 11 Jun
 2020 13:49:43 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: correct ras query as part of ctx query
Thread-Topic: [PATCH] drm/amdgpu: correct ras query as part of ctx query
Thread-Index: AQHWP9qIV/sOkPBdwkGpzx2F46zje6jTPlgAgAAv02A=
Date: Thu, 11 Jun 2020 13:49:42 +0000
Message-ID: <CY4PR12MB1287BE78B8153B8E1B17E438F1800@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200611102423.32346-1-guchun.chen@amd.com>
 <DM5PR12MB2533855CADC7E732C21E9456ED800@DM5PR12MB2533.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2533855CADC7E732C21E9456ED800@DM5PR12MB2533.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-11T13:49:33Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=416a3a22-923a-47b4-b238-000077a874b5;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-11T13:49:38Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 92807af5-a2d1-4fcf-b92e-000040b288b3
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.165.43.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c779e2c-bec2-4921-44e8-08d80e0e4b84
x-ms-traffictypediagnostic: CY4PR12MB1288:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB12887BBC9DF3C2464EC6F345F1800@CY4PR12MB1288.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:561;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ur7Ld2WiS+MgkUtRGrjTkZDQKdCYmDOh9e7F26iW4UPnTCve6Yk8Ly9U5TJlRpDSLOSW4rLHT+S/yltgs3uTVdVMhZqwLlnyE+tr2ImN9GWlt9mc0fOOh77BlbSlLpw8ZiWnBx+Tm7S9ZdIwGmEDvEdMYbxNBAPgviR17QkggF8TQBD9QLiy0lZQe7ZVx3Y0CJibgnycdubxvrp/IBdQMeQmt0YqPtc4fh03BnLZ3KQBdb930V5Sg5M6/Lg7uAPvqF66BB4A+CeehYfJWnZQsg1k6nHXDM9F7CVZ1td+0y1TvWMlbBGgihtGBnUo0mDJkkeajVsgOHIKdU4uq39cWtCf++DQJEcwwiqq7pwKNtuE/lE3NxAi96kmQ1BCGRPF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(71200400001)(6636002)(52536014)(2906002)(66946007)(83380400001)(66476007)(64756008)(66556008)(8676002)(478600001)(66446008)(76116006)(86362001)(33656002)(8936002)(110136005)(53546011)(5660300002)(6506007)(55016002)(186003)(26005)(316002)(7696005)(9686003)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: /RpFxBvp+RFQA/hb9mZ6vdTe0zJ4B0ZORUPodce4VV/MlLuAcdLV05nYYrGTebJKbIPQtlOYWmcBXiOGWyv/esgIlqPTg8BCVBjEW9k01TtwPnfCtsBGdCHLRxAyR6omuJLNn2onY3KIJyTEDp2ijRRyVvDTuZ9jvehGIKOl2Zj4Tbr/bksJ6Ewe8jV9F9v16VLlEQFNFANI8b04wHg3eAsqW5+tUvkrUK+Aub7MYO/suNjpknDsTjxjXSl/kreCNT0X5uLK6z11SPjetd2S1LAHh8Hc6pt2jFpznrl2cizw2YN6Mm/6D+nHTq7o8OJ+cfqUwcS2pnXBI3IZtByaoY9tnzvb60gjzVQjoFsBY/eKY6cer3lmnmkOZ6bqEeZcUzN3t3+8y+Esd/nsJDGt8u/w0LW2LmBPlMyb1JAjR/rNl44Olhr6ISeGZ6WTejDbwUrSwvvOav3rdcpajW+yhiaylK6HHiF7YGL+aMp3gPdQ6pLYVHllUVCdMidi2tss
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c779e2c-bec2-4921-44e8-08d80e0e4b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 13:49:43.0096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZjfMVGZbbkV/EHI8tMcgT7n8fW4UcrB1Y4p1rU+u+ekmNmsm2gU/UmdEYBPjHKvbRbkzckxykF3XDn6xAQq3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1288
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

[AMD Public Use]

Hi Dennis,

Sorry for confusion brought by the commit message. I will update patch v2 later.

Regards,
Guchun

-----Original Message-----
From: Li, Dennis <Dennis.Li@amd.com> 
Sent: Thursday, June 11, 2020 6:57 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: correct ras query as part of ctx query

[AMD Official Use Only - Internal Distribution Only]

Hi, Guchun,
     The ras_manager obj will save the error counters in every querying, therefore the previous querying shouldn't affect the result of current querying. Please check the function: amdgpu_ras_error_query. 
 
Best Regards
Dennis Li
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Thursday, June 11, 2020 6:24 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: correct ras query as part of ctx query

Almost error count registers are automatically cleared after reading once, so both CE and UE count needs to be read in one loop.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 16 +++++++---------  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++++++++-----  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  4 ++--
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index c06cb06398b1..29fa6b6b9d3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -335,7 +335,7 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,  {
 	struct amdgpu_ctx *ctx;
 	struct amdgpu_ctx_mgr *mgr;
-	unsigned long ras_counter;
+	unsigned long ras_counter_ue, ras_counter_ce;
 
 	if (!fpriv)
 		return -EINVAL;
@@ -360,19 +360,17 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 	if (atomic_read(&ctx->guilty))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_GUILTY;
 
-	/*query ue count*/
-	ras_counter = amdgpu_ras_query_error_count(adev, false);
+	/*query both ue and ce count*/
+	amdgpu_ras_query_error_count(adev, &ras_counter_ue, &ras_counter_ce);
 	/*ras counter is monotonic increasing*/
-	if (ras_counter != ctx->ras_counter_ue) {
+	if (ras_counter_ue != ctx->ras_counter_ue) {
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_UE;
-		ctx->ras_counter_ue = ras_counter;
+		ctx->ras_counter_ue = ras_counter_ue;
 	}
 
-	/*query ce count*/
-	ras_counter = amdgpu_ras_query_error_count(adev, true);
-	if (ras_counter != ctx->ras_counter_ce) {
+	if (ras_counter_ce != ctx->ras_counter_ce) {
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_CE;
-		ctx->ras_counter_ce = ras_counter;
+		ctx->ras_counter_ce = ras_counter_ce;
 	}
 
 	mutex_unlock(&mgr->lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 337bf2da7bdc..109eff2869b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -861,15 +861,18 @@ int amdgpu_ras_error_cure(struct amdgpu_device *adev,  }
 
 /* get the total error counts on all IPs */ -unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
-		bool is_ce)
+void amdgpu_ras_query_error_count(struct amdgpu_device *adev,
+		unsigned long *ue_cnt, unsigned long *ce_cnt)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
 	struct ras_err_data data = {0, 0};
 
+	*ue_cnt = 0;
+	*ce_cnt = 0;
+
 	if (!con)
-		return 0;
+		return;
 
 	list_for_each_entry(obj, &con->head, node) {
 		struct ras_query_if info = {
@@ -877,13 +880,14 @@ unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 		};
 
 		if (amdgpu_ras_error_query(adev, &info))
-			return 0;
+			continue;
 
 		data.ce_count += info.ce_count;
 		data.ue_count += info.ue_count;
 	}
 
-	return is_ce ? data.ce_count : data.ue_count;
+	*ue_cnt = data.ue_count;
+	*ce_cnt = data.ce_count;
 }
 /* query/inject/cure end */
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index e7df5d8429f8..733eab5bc512 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -487,8 +487,8 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,  void amdgpu_ras_resume(struct amdgpu_device *adev);  void amdgpu_ras_suspend(struct amdgpu_device *adev);
 
-unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
-		bool is_ce);
+void amdgpu_ras_query_error_count(struct amdgpu_device *adev,
+		unsigned long *ue_cnt, unsigned long *ce_cnt);
 
 /* error handling functions */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
