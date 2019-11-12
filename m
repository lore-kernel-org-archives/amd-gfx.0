Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D06C17441
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CD32184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CD32184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E69846EA34;
	Tue, 12 Nov 2019 00:33:59 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800058.outbound.protection.outlook.com [40.107.80.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C98F6EA2E
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:33:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clafaUMsC4mrYNlXNdZthl2yS/si0brcn+jPW7rVhiEDiGqnG7g9pM5L3ZbqjQn01nVO0cuFzZQIHbsFzciHOdSI5NSrdeF7e0kdwMDHYjZc3BfZOycHKVVCqJArxkRK03OVexLdTi7Ruc6TfVtjtKdcCqMHJbh/BWOmFGZqkxMt+cSML8agAgh9lciCDf5Fngm+xkvKhke4DaObNSxjXbFtZvA9wcE9cLWUP2qy25N8YW1/uG0ve8Tk6AYFqppGkQ03ucL0vTQJyWomi/yqEN6W0EVQWLcwJzkzXnLXYUJWHSDooGbcLEx1T7NFoJAzFPXh48Eqz9GZE2ofPmhrJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXTjA8AvwxAkNN/wKuIiFe3WViavJwBqoQOWNDG/RFo=;
 b=TQfzIV0xBCWSfVkaniCyRXQ3qXKojIElHh0FKijj98ZjbIvG3twPo/Uzg9CAFmUhQI3122fWJEMPHs44K6fIXDwPO/gwb77Dbv2+11zomVAX1IpNuDYnvXaz3t9R+MIxoYdWlJDE9wENrDTrCXSAwl/KY9VcGI3qRKDLfKUQuCRgVRYopKnybZxVAbzj11jI59uSXUIcSupY/e8RoFHWyF0Cc+ZmzKUaM/OcijDiCVQZAmgAmcbd74T5xTjzZVYWaWy58nz+iwuufoN2+LUc8ryPeiNrv4LNpHFTebVNoTIn46bL97HzFBk4Kx0rzNZP6qI1aV4Wll8OYBlj29oucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:33:55 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:33:55 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/30] drm/amd/display: revert change causing DTN hang for RV
Date: Mon, 11 Nov 2019 19:33:09 -0500
Message-Id: <20191112003324.8419-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
References: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd4666fd-9edc-4779-06be-08d76708001c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25541B7078DCE56CE287CCF998770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(14444005)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BxBx55nARsm6JisYHB2okPWMYTBNE03JndUWNUEuPhaCf9sBKxJBr2dE5fzinC70pNcy45WfjoiOkUq0WfLpfTu1Md9Z6kqQu+snEDMnWaKxshhM9gWLyrJZibUDZ2MvTKNV0u7ZZmqgJdZQYxI8pHRWQztH3hdPzrJm1YqqEPxUVrxlylD420GoEnHb4rEqmP4HGc1jWWD2bGm19Lwe2mHTd8JZWKlia/vd54WHt6eluDc5/UFmW82k8ofvuqgwKQgsvGYPiCgsmLkCllXs7CvTcPd3NU2yit6+ST0SBD7MBF9+XUC8+dUWaZBz2LIxBCUtAp2Qh4WPHd/kQIe2T0pDDfHqK0F7aIrUHA1NocAdpmHK5jwQhxjvujQKZLudvE3rXxgjTosPR9AL76DsvRFj2ryBP6EWNVvALlT1Wd8L6pdsoMHRX8HaTg+WM7Wo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4666fd-9edc-4779-06be-08d76708001c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:33:55.7649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDDUWO1X8X4eBrMudDgzWEbnhGWNpqrdMOdjS6eiTLQHr0IJgjj+1uCXA7xRQAOtnxcXUr6NasAjuqng1ITi9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXTjA8AvwxAkNN/wKuIiFe3WViavJwBqoQOWNDG/RFo=;
 b=SLwCT2wc2pMJqmkzvLsg7mHN8qtGocaSr5nzumz3GvEPL/QQhWK29iybZvz/61LekzzxJ/TdmDHoNcIyaAxcel9jhtm+wXZNm0hr0qXhmPjNZwjpK0bP0mQByTmcAox4msv/jDR0TEMAFVI4fvxtgFahScc8jF9MEvz+s9DsmLQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Jun Lei <Jun.Lei@amd.com>, Samson Tam <Samson.Tam@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003309.a0JshL7vh7bSiCWPlo0cE_Idzb_tUo9jeBr3lZjc1ZE@z>

RnJvbTogU2Ftc29uIFRhbSA8U2Ftc29uLlRhbUBhbWQuY29tPgoKW1doeV0KSGFuZ2luZyBvbiBS
ViBmb3IgRFROIGRyaXZlciB2ZXJpZmllcgoKW0hvd10KUm9sbCBiYWNrIGNoYW5nZSBhbmQgaW52
ZXN0aWdhdGUgZnVydGhlcgoKU2lnbmVkLW9mZi1ieTogU2Ftc29uIFRhbSA8U2Ftc29uLlRhbUBh
bWQuY29tPgpSZXZpZXdlZC1ieTogSnVuIExlaSA8SnVuLkxlaUBhbWQuY29tPgpBY2tlZC1ieTog
Um9kcmlnbyBTaXF1ZWlyYSA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgfCAyNyAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2NvcmUvZGMuYwppbmRleCBmZmM4YjFmODk2OTAuLjFmZGJhMTNiM2QwZiAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCkBAIC0xNzQ4LDM3ICsx
NzQ4LDEyIEBAIHN0YXRpYyBzdHJ1Y3QgZGNfc3RyZWFtX3N0YXR1cyAqc3RyZWFtX2dldF9zdGF0
dXMoCiAKIHN0YXRpYyBjb25zdCBlbnVtIHN1cmZhY2VfdXBkYXRlX3R5cGUgdXBkYXRlX3N1cmZh
Y2VfdHJhY2VfbGV2ZWwgPSBVUERBVEVfVFlQRV9GVUxMOwogCi1zdGF0aWMgdm9pZCB2YWxpZGF0
ZV9kY2Nfd2l0aF9tZXRhX2FkZHJlc3MoCi0Jc3RydWN0IGRjX3BsYW5lX2RjY19wYXJhbSAqZGNj
LAotCXN0cnVjdCBkY19wbGFuZV9hZGRyZXNzICphZGRyZXNzKQotewotCWlmICgoYWRkcmVzcy0+
Z3JwaC5tZXRhX2FkZHIucXVhZF9wYXJ0ID09IDApICYmCi0JCWRjYy0+ZW5hYmxlKSB7Ci0JCUFT
U0VSVCghZGNjLT5lbmFibGUpOwotCQlkY2MtPmVuYWJsZSA9IGZhbHNlOwotCX0gZWxzZSBpZiAo
KGFkZHJlc3MtPmdycGgubWV0YV9hZGRyLnF1YWRfcGFydCAhPSAwKSAmJgotCQkhZGNjLT5lbmFi
bGUpCi0JCWRjYy0+ZW5hYmxlID0gdHJ1ZTsKLQotCWlmIChhZGRyZXNzLT50eXBlICE9IFBMTl9B
RERSX1RZUEVfR1JBUEhJQ1MpIHsKLQkJaWYgKChhZGRyZXNzLT5ncnBoX3N0ZXJlby5yaWdodF9t
ZXRhX2FkZHIucXVhZF9wYXJ0ID09IDApICYmCi0JCQlkY2MtPmVuYWJsZSkgewotCQkJQVNTRVJU
KCFkY2MtPmVuYWJsZSk7Ci0JCQlkY2MtPmVuYWJsZSA9IGZhbHNlOwotCQl9IGVsc2UgaWYgKChh
ZGRyZXNzLT5ncnBoX3N0ZXJlby5yaWdodF9tZXRhX2FkZHIucXVhZF9wYXJ0ICE9IDApICYmCi0J
CQkhZGNjLT5lbmFibGUpCi0JCQlkY2MtPmVuYWJsZSA9IHRydWU7Ci0JfQotfQotCiBzdGF0aWMg
dm9pZCBjb3B5X3N1cmZhY2VfdXBkYXRlX3RvX3BsYW5lKAogCQlzdHJ1Y3QgZGNfcGxhbmVfc3Rh
dGUgKnN1cmZhY2UsCiAJCXN0cnVjdCBkY19zdXJmYWNlX3VwZGF0ZSAqc3JmX3VwZGF0ZSkKIHsK
IAlpZiAoc3JmX3VwZGF0ZS0+ZmxpcF9hZGRyKSB7CiAJCXN1cmZhY2UtPmFkZHJlc3MgPSBzcmZf
dXBkYXRlLT5mbGlwX2FkZHItPmFkZHJlc3M7Ci0JCXZhbGlkYXRlX2RjY193aXRoX21ldGFfYWRk
cmVzcygmc3VyZmFjZS0+ZGNjLCAmc3VyZmFjZS0+YWRkcmVzcyk7Ci0KIAkJc3VyZmFjZS0+Zmxp
cF9pbW1lZGlhdGUgPQogCQkJc3JmX3VwZGF0ZS0+ZmxpcF9hZGRyLT5mbGlwX2ltbWVkaWF0ZTsK
IAkJc3VyZmFjZS0+dGltZS50aW1lX2VsYXBzZWRfaW5fdXNbc3VyZmFjZS0+dGltZS5pbmRleF0g
PQpAQCAtMTgyNyw4ICsxODAyLDYgQEAgc3RhdGljIHZvaWQgY29weV9zdXJmYWNlX3VwZGF0ZV90
b19wbGFuZSgKIAkJCQlzcmZfdXBkYXRlLT5wbGFuZV9pbmZvLT5nbG9iYWxfYWxwaGFfdmFsdWU7
CiAJCXN1cmZhY2UtPmRjYyA9CiAJCQkJc3JmX3VwZGF0ZS0+cGxhbmVfaW5mby0+ZGNjOwotCQl2
YWxpZGF0ZV9kY2Nfd2l0aF9tZXRhX2FkZHJlc3MoJnN1cmZhY2UtPmRjYywgJnN1cmZhY2UtPmFk
ZHJlc3MpOwotCiAJCXN1cmZhY2UtPnNkcl93aGl0ZV9sZXZlbCA9CiAJCQkJc3JmX3VwZGF0ZS0+
cGxhbmVfaW5mby0+c2RyX3doaXRlX2xldmVsOwogCQlzdXJmYWNlLT5sYXllcl9pbmRleCA9Ci0t
IAoyLjI0LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
