Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A8EC432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AB220678
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AB220678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1FCA6E25F;
	Wed, 27 Nov 2019 09:49:33 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720048.outbound.protection.outlook.com [40.107.72.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C38306E25F
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 09:49:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7qI1qcjRbbtzYaTClFP0fEG/jBuFC9vZGz8LMW1Ep95nuO+l0bLF72B+s0SR4KW0tt+blr8a9eyuS24V+2tBIs1VIgV+g+ebbtir6YoxEfnd+YYVbai9MHpfHKnndRuosckluWf8LN5CV8gNV7mSm+ZLNOsuVnCb05Hw4/eKX9wjEnoYaH1nSDeQ1hFqUNg2GV3S03XYwvQHHcpJ4vp96YSFRDlOJIB7Yt/AZUvOl+UAAjiYmR/mt4VYnjLGB8QcC7ml3p6FAB4sx0eGlpnYY+e4zLVD3S1dgWDa6ZTI2J7aZNgZ/1400nrqTvTnezyFQ9hVDLseMAR0ez06zGaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErU5KwKCeNzFLl7xkanWQDHhX0x6cSUMIMsRLhh1r+U=;
 b=jxm41qGsNgpKlvAuc8ndW3ur7MNW7sW5ouT6bDGRaspjsqERU9NQvK8i5vl6RAnT499rb3LLXXkXtrHOHEDJROMOY6oW+DmbFC6WAATQRd9xTBiuUNGoGWyFSjm4UiyL3SQR+JpTaGsGN5JKhFwMXDAF3G9/cCYoj7eGfNGgik/GMHnATq0YLrI/WyjEOlIBuuORhIjn4DrS5466UhP/tVzewkKWBvB1U4c7DWu2Nu042pbxJLsPLnod3tvWQI3iRB8jsQ6BPNztCx6yu/pmkCTcJni3ysXvtWf3R2wiTHTFuCzpz3VK2ETg6H0nR6Fekj23xwOI5LWPF7n5jy08NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB2869.namprd12.prod.outlook.com (20.179.92.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.24; Wed, 27 Nov 2019 09:49:30 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::e09a:808e:1ea9:db3f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::e09a:808e:1ea9:db3f%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 09:49:30 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 10/10] drm/amdgpu: reduce redundant uvd context lost
 warning message
Thread-Topic: [PATCH 10/10] drm/amdgpu: reduce redundant uvd context lost
 warning message
Thread-Index: AQHVpQNVnMDEjZMEDUKNA032btoRd6eexYDQ
Date: Wed, 27 Nov 2019 09:49:30 +0000
Message-ID:
 <BYAPR12MB280648A1C59519AA77B3FCA9F1440@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-9-git-send-email-le.ma@amd.com>
In-Reply-To: <1574846129-4826-9-git-send-email-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-27T09:49:27Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fd28ad11-65ce-4d69-bfb5-0000331a5625;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-11-27T09:49:27Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a374dbb4-2718-4e22-87da-0000569e03ef
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57243f29-d7d0-400f-0806-08d7731f1978
x-ms-traffictypediagnostic: BYAPR12MB2869:|BYAPR12MB2869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB286945C1DE2041D4D0FE1DDCF1440@BYAPR12MB2869.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(13464003)(199004)(189003)(229853002)(6436002)(8936002)(186003)(66946007)(76116006)(26005)(66446008)(110136005)(2501003)(2906002)(55016002)(66066001)(9686003)(99286004)(66556008)(4326008)(6246003)(316002)(33656002)(15650500001)(81166006)(81156014)(54906003)(64756008)(5660300002)(3846002)(86362001)(14444005)(256004)(478600001)(66476007)(446003)(7696005)(14454004)(6116002)(76176011)(74316002)(71190400001)(53546011)(71200400001)(11346002)(8676002)(7736002)(305945005)(52536014)(6506007)(102836004)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2869;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VuSshGCNrrnzzD4utaQCAp791MCbK/2B8/XKuhhZkoiPfujqW8Najb3M+mVRV7wS8NNWYLhv3CJhHwRoutj2q1dAMLGG8AdFJE9t+u234nBRE74APhr5e0zY20P2IEZ6WP/RkJvNZoWhr4iM9wtPndapt+E5OqguLTMB4ywB7JPr+gxoblD4SjSrJYXJvR5UmfUvPxsBzdZxNWbv+HKUYN+ntCx9qDml2aA2LfbWosLe1ywJAYf7sVN02pkys0unbozyqRjo09t5Xa+gEV1W97fzoErL3/VCogPdOBFip5QQspNrPQAgM1Xyk43cLKhN/74yYlIV3M8xGkBFJ6Rs7g1ePsjkWnUCI0TM2o3/DxQS0vBtsuVyAu/bIJjQOzDXb1SP3NCmt/7/6uKcZh++1r9hfDg8/gAqfejAAXvDbECqzYd++hV36Li2QDZHpWiY
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57243f29-d7d0-400f-0806-08d7731f1978
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 09:49:30.1453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+8tcJmcoY71cCyWs64wXEG57a0jzCkRfgyHszHugfv6MZb+1F0zox/9xbL7mQOrGCaDpKXYi3AWrakQLDMnmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2869
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErU5KwKCeNzFLl7xkanWQDHhX0x6cSUMIMsRLhh1r+U=;
 b=NXUY9JxuZm9CUxX3W8xcUOu3IuuiRxYtFWJz/ACxhFTUzamEBeRBighSIsJgiQ6EBxCj2TWRKUrV/BLV0qCPCd9xToDARF6EcMracmA03VteHbhZ8zjUGy9PZ3pcDRW3wqfmcCkojWcla0Pqct/toHjT4EGHbx14dw3E3TxkOkk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127094930.qJSeRum2K6lYWTeBetMYKb93RrA9ruy7orxgh5LWeAE@z>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQoKCgoK
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KRnJvbTogTGUgTWEgPGxlLm1hQGFtZC5jb20+IApT
ZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDI3LCAyMDE5IDU6MTUgUE0KVG86IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQu
Y29tPjsgQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPjsgWmhvdTEsIFRhbyA8VGFv
Llpob3UxQGFtZC5jb20+OyBMaSwgRGVubmlzIDxEZW5uaXMuTGlAYW1kLmNvbT47IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IE1hLCBMZSA8TGUuTWFAYW1k
LmNvbT4KU3ViamVjdDogW1BBVENIIDEwLzEwXSBkcm0vYW1kZ3B1OiByZWR1Y2UgcmVkdW5kYW50
IHV2ZCBjb250ZXh0IGxvc3Qgd2FybmluZyBtZXNzYWdlCgpNb3ZlIHRoZSBwcmludCBvdXQgb2Yg
dXZkIGluc3RhbmNlIGxvb3AgaW4gYW1kZ3B1X3V2ZF9zdXNwZW5kCgpDaGFuZ2UtSWQ6IElmYWQ5
OTdkZWJkODQ3NjNlMWI1NWQ2NjhlMTQ0YjcyOTU5OGYxMTVlClNpZ25lZC1vZmYtYnk6IExlIE1h
IDxsZS5tYUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91
dmQuYyB8IDUgKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZk
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMKaW5kZXggZTMyNGJm
ZS4uYWM3Yzc3OTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV91dmQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMKQEAg
LTM3NywxMiArMzc3LDE1IEBAIGludCBhbWRncHVfdXZkX3N1c3BlbmQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpCiAKIAkJLyogcmUtd3JpdGUgMCBzaW5jZSBlcnJfZXZlbnRfYXRodWIgd2ls
bCBjb3JydXB0IFZDUFUgYnVmZmVyICovCiAJCWlmIChhbWRncHVfcmFzX2ludHJfdHJpZ2dlcmVk
KCkpIHsKLQkJCURSTV9XQVJOKCJVVkQgVkNQVSBzdGF0ZSBtYXkgbG9zdCBkdWUgdG8gUkFTIEVS
UkVWRU5UX0FUSFVCX0lOVEVSUlVQVFxuIik7CiAJCQltZW1zZXQoYWRldi0+dXZkLmluc3Rbal0u
c2F2ZWRfYm8sIDAsIHNpemUpOwogCQl9IGVsc2UgewogCQkJbWVtY3B5X2Zyb21pbyhhZGV2LT51
dmQuaW5zdFtqXS5zYXZlZF9ibywgcHRyLCBzaXplKTsKIAkJfQogCX0KKworCWlmIChhbWRncHVf
cmFzX2ludHJfdHJpZ2dlcmVkKCkpIHsKKwkJRFJNX1dBUk4oIlVWRCBWQ1BVIHN0YXRlIG1heSBs
b3N0IGR1ZSB0byBSQVMgRVJSRVZFTlRfQVRIVUJfSU5URVJSVVBUXG4iKTsKKwpbR3VjaHVuXXRo
ZSAieyIgYWZ0ZXIgdGhlIGlmIGNvbmRpdGlvbiBuZWVkcyB0byBiZSByZW1vdmVkPwoKIAlyZXR1
cm4gMDsKIH0KIAotLSAKMi43LjQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
