Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036FEC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 10:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A446B2063A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 10:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JMRiYEmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A446B2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60F806E8F3;
	Thu, 11 Jun 2020 10:57:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CEA66E8F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 10:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGOFM36npyfVCYz1x46MgwaVcAnHI0xnku+SaVPb5eaLVj8aMjBLjGwber9umd/ZWx8TQQypAg0yaVD5hHygZIiPBP21Nw3VYSN8TudiMGVIPeXSDWammpRTwXHFwhPKaTZ2czM8ihrlUqURSOzJfh2jcFRo/TGmzUtD35m7EIAzWAgEWW9bLPemHCGghWE0qPx5nnFptDWMijbXHKXus93K/gRbNVTJQgO8Z4ZRudYEQITWoKrKPpCEY0V4hEV6hRDaKiAnfnsmIT9ScTzrr9TnYtGzQgtLoOiCqB/jbC4Bny1D1hEU6OZQshwFy3uEwIfrShSVAsKuJH5PXmN7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dqUCkrdBV9vej3L2a1978XVcI7ch60aXmuN+k7mPyY=;
 b=iobS+3Dobn7N71Z6bmeQxLzO7mi6p2eqW82iYuObwO2Pz3zvkqjNFllWRAYLm/V5Z7ldef/dLZzIlXtv42ZnE4tDAkZ2BML4FPVCGIZ5i2CcRveBJ3tCG/WO6sYeJ/oO1JMyGOGIw5KPuhtqhnpiMvIXv+7ZNxQkoy3GFyrueUdzkE5JCoKwiHApFkW0RiCWpQEft9AlxD9aZaIcIVUN933VovqKzcf5pI6wtKiMUZ3UxEcMlXkPVTA/cWlTqiRpScykpgzqrUnaOaU9tJhnMjR2VrEgwnixpBngeS+z7qdkQuZ8fAGFVaMF5fKqJdRhfPIhcsjJdRcnOgblIxEzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dqUCkrdBV9vej3L2a1978XVcI7ch60aXmuN+k7mPyY=;
 b=JMRiYEmK6t1T2DhuQqVm0e9LPyubE0MPmTMPZ7K/SQKvj/f0KbX0OkfsF/VNOSEZ60mBJGCBeYsu+bFXpZn4RlWsSNvmCcjTsac9Ye+jTDYvdS3ILLfrAr6jMppa0FQ7x+/kvCjHwWwAmcG5Eb5SYdExVla1vyLr+oD6Jiz/SIc=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM5PR12MB2534.namprd12.prod.outlook.com (2603:10b6:4:b4::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18; Thu, 11 Jun 2020 10:56:58 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b899:73f2:15df:da86]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b899:73f2:15df:da86%7]) with mapi id 15.20.3088.018; Thu, 11 Jun 2020
 10:56:58 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: correct ras query as part of ctx query
Thread-Topic: [PATCH] drm/amdgpu: correct ras query as part of ctx query
Thread-Index: AQHWP9qJQQnunOeke0GZCT1cc8BDjajTPJbw
Date: Thu, 11 Jun 2020 10:56:58 +0000
Message-ID: <DM5PR12MB2533855CADC7E732C21E9456ED800@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200611102423.32346-1-guchun.chen@amd.com>
In-Reply-To: <20200611102423.32346-1-guchun.chen@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-11T10:56:44Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=71498f33-d608-4592-b85b-00001f42db3d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-11T10:56:44Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e7e84097-37f4-488c-b87c-00004a013ed3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2c5488f-c8f3-4dec-e961-08d80df629b5
x-ms-traffictypediagnostic: DM5PR12MB2534:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2534E8F88C869CF775A26D66ED800@DM5PR12MB2534.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 47Hg+9yCDVH5bwbVYOL+ptTVGZ4D6auAd69yAGfD+oSvzdBVivhfaWZeIAm/37/D7jcVokAwctbps0/HXHiDk+G5++sMz4kP3sM8i/dpD6C7Jl1FXvv7HESgl1aWiw+QqGB4icyiJwpf0z2r3767PEC/vkOWWTq9aScvX50bpBJg2HO5O7Za85oeJz2yiXCS0jtxxZcrGKct0nrZ6wk6hbELyzpRlnxXkAp/zPF556sOomn3XSPisEIbZpDno8DyeybaSrG3BxSumuCQsY4XX1uobj27oXsz6QZjZja2SRablNGKf/cIajpwnzi1UzALTBkzXjqexOraQMgMF7ky5L0FSVnXD/8QmxThVNpCAIr5zKv6/frGruu8O/Pkoj/Z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(6636002)(66556008)(66446008)(83380400001)(71200400001)(5660300002)(66946007)(52536014)(9686003)(316002)(8936002)(76116006)(66476007)(110136005)(64756008)(2906002)(33656002)(6506007)(186003)(8676002)(86362001)(478600001)(26005)(7696005)(53546011)(55016002)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: frXDw0Ls9VxrtMcmfAgBvWki3IpuHv7NQMSxOIcMFcvZFvWUxATjqnkDzc/mbpnn8+Cfr0+rGqfMHfqJ+LhkI5zLq4jCrKkldAk6q8rU2tqslFHD0Os3nXDw4/HSqvmmypzDquGPjzPlzjBvJ9RT762+Ebb2YuIF2yAw1jHpF3RT60rhcSzHOI5ydMQuCSObkTEmbDQoT8osbHA1ZK9/+wFOuLruPrs+qnzfrcBVhvhg1z/fWy3+qiMFhWxBssEcxEEVQ4D1diNpVNi389Cgl7iTk9sAe4LKs/bXAjAG7qWsIQ8ikpKl6NAC7LkIdEe4EOKR7lob7tY/s3bP34RLfssBfd8leWOtPeg6b5vrEC8rWbP7jj5Mk5Ic8O+u+yXW9F/G0iQlSsEliBp9KzFa6KEbRiCSnaoztiMSSVvqvQGUD/NoMUo2F8YG6OUv3DZapB6QQVq+Hx/LFGFU795Aj3wSz0GFacjxuPMz9qsyQNjjZ0+M/4h0F78fIMZ8aT85
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c5488f-c8f3-4dec-e961-08d80df629b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 10:56:58.5189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zemYd6Mj7vhHBsAKPg+lDlrcnW59j/x6SKcjHmG629VlLgmsW2DHa1NweBz4Cb83
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2534
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
