Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF0ACA9EBC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 10:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F8520873
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 10:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F8520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFFF6E52C;
	Mon, 28 Oct 2019 10:15:01 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820089.outbound.protection.outlook.com [40.107.82.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF136E52C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 10:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyBG/MDofUm8JfptIOcvhmSsmkuGRM2/8/CrgjBp/YjKbTzNFP3MAKv1NBPoDTAvnFOPGEKYN21QZ4DHJ5RdNhd+NzpIlrOCIjKkel8Y3hwYe0P5D/Qyq+d6BAiyDvQ1dME/v1QgYtLgnO1RmH1HTaHktWaK/W2lIxTND99dqIYvtgoN3fOwIHVOIJTDWMPaj/CQ4vgdie9Z6xvIjiRwYIrdMe3X/A9e06JpGlUj+dcDIU0Xs16FFu6mbwrhc43SjBJNVuja1IBIeEQJaLB1RbE/dsUCawcnTc8ueiyJpbfOEDQp1IieSfQobCOpFSU5jLeGMsf+I/lglLL9UGOh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMkqyS4WwKOiwk8WKfIO6g9J5l316cHAjhIpnMOn8n4=;
 b=fi6+kq+o6eWzKN4ncx/zSb3/j9/F/tk8Y8abxT6yQDkKOahXBG9maxDQQb0Dys1UH3nOTvEw3mDaD4aPnWfYQrnNX87OCnALoOrafBgz+IR3GkvYVaWO2x/5QxoNpBi7AqDov2sp2rfqfwjwLqgZCzvJ/tqr8jWZPnNatLI+vz6aSlqSQnebqSC1zcGXYOKEKly8Yyk7QKY05DbtDvFUxrM/kNyU0KNxpBWuSQV64HCoZ8Fqs0jRA7RA3CKvKpNd6vTm77xAOz+0Edjlu/mXNckaXqGD7a3Vm5cZNTL1DqUe2G9THBtVLaSIlLBdH/oK6k3Fj+BFgEn8saz5ewKvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3056.namprd12.prod.outlook.com (20.178.242.143) by
 MN2PR12MB3613.namprd12.prod.outlook.com (20.178.240.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Mon, 28 Oct 2019 10:14:55 +0000
Received: from MN2PR12MB3056.namprd12.prod.outlook.com
 ([fe80::f951:43eb:5b8e:2a31]) by MN2PR12MB3056.namprd12.prod.outlook.com
 ([fe80::f951:43eb:5b8e:2a31%4]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 10:14:55 +0000
From: <jianzh@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/SRIOV: SRIOV VF doesn't support BACO
Thread-Topic: [PATCH] drm/amdgpu/SRIOV: SRIOV VF doesn't support BACO
Thread-Index: AQHVjXiLEEkLZ1xVeEW9m36pMSA0kA==
Date: Mon, 28 Oct 2019 10:14:55 +0000
Message-ID: <20191028101432.16464-1-jianzh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::15) To MN2PR12MB3056.namprd12.prod.outlook.com
 (2603:10b6:208:ca::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bfb1d76e-aeea-4e6b-1b2f-08d75b8fadee
x-ms-traffictypediagnostic: MN2PR12MB3613:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3613D6787A7E1ACE75826A04E1660@MN2PR12MB3613.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(199004)(189003)(6916009)(99286004)(71200400001)(52116002)(2616005)(14444005)(2906002)(6506007)(5660300002)(256004)(476003)(386003)(486006)(71190400001)(2351001)(4744005)(50226002)(8936002)(66066001)(36756003)(8676002)(81166006)(1076003)(102836004)(81156014)(186003)(6512007)(4326008)(66946007)(5640700003)(2501003)(66446008)(6436002)(6486002)(26005)(66476007)(64756008)(66556008)(316002)(305945005)(54906003)(7736002)(14454004)(25786009)(3846002)(478600001)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3613;
 H:MN2PR12MB3056.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rf0KmdyAnU/S4bv8imGsSimT1z5uHb0BVDuA5YASggF1zNcFLNWR3/G8d0MffJHwOcMJlfTPkrn/ytNYubebGkdxPK2BgL3pwVYbWOvEEWLM6gP98Fdu3R3MoRnHC22c+aKve1IWX919IVkdc67zLf4ZJoAAwKlkKZ+8PBzShxWzevRvxrjerIF/YLG93bfKdJoz3LAhE/tNEdAA//3Bj6J7ncuYahfTO9NoIkcT1CHv3mUjCiJfXWMZVtHrx7X2WPTnif3j+cuSlHNU5CUTVjMv2ccczt1mwk6ALF4vDKs3z5Xji2A3/3EO6wtD2KNnLwCFyKyIcMadnrzxHfQOdjZmDQl2FuNRc65J56GF6jIBHs70C6cAuDj9188xb1X0PlEMZXY+cvDPjZpT2ChenBrcwILtq3s4iyv8L767g+vC3ecah1cXRC3qC5CuIcxm
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb1d76e-aeea-4e6b-1b2f-08d75b8fadee
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 10:14:55.7495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGO2WxC81QpLE2L63CaO7xsr+xg70Svw+dhNmf9T6fK8O/Q/DqlBslLRY7MKfnuA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3613
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMkqyS4WwKOiwk8WKfIO6g9J5l316cHAjhIpnMOn8n4=;
 b=wogF+He6ecCYF9QKiEiXNkbrZ+6R8Pzl12Ft2tOUEruEIa8sAVTSgTQyPFmUnkktUE+xW5V8S/kyHTyT10IcQRI8Gt/y/xPt0GEjGcSCioX6/+y8EvYphYYaoJNP/1nh1VQG0BkEmeUcx5txDiSaJn1RwAk3fVc65LYFFYyRuNY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jiange.Zhao@amd.com; 
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Zhao, Jiange" <Jiange.Zhao@amd.com>,
 "Nieto, David M" <David.Nieto@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028101455.u5ACGo44dKVyDYS2val80pQKFej1miQ8iyuMZ4zbhS4@z>

RnJvbTogSmlhbmdlIFpoYW8gPEppYW5nZS5aaGFvQGFtZC5jb20+CgpTUklPViBWRiBkb2Vzbid0
IHN1cHBvcnQgQkFDTy4KCk9ubHkgUEYgd2l0aCBCQUNPIGNhcGFiaWxpdHkgY2FuIGRvIGl0LgoK
U2lnbmVkLW9mZi1ieTogSmlhbmdlIFpoYW8gPEppYW5nZS5aaGFvQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L252LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jCmluZGV4IDIy
YWIxOTU1YjkyMy4uYTU1YTJlODNmYjE5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9udi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMKQEAgLTI5
OSw3ICsyOTksNyBAQCBudl9hc2ljX3Jlc2V0X21ldGhvZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKIHsKIAlzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSA9ICZhZGV2LT5zbXU7CiAKLQlpZiAo
c211X2JhY29faXNfc3VwcG9ydChzbXUpKQorCWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpICYm
IHNtdV9iYWNvX2lzX3N1cHBvcnQoc211KSkKIAkJcmV0dXJuIEFNRF9SRVNFVF9NRVRIT0RfQkFD
TzsKIAllbHNlCiAJCXJldHVybiBBTURfUkVTRVRfTUVUSE9EX01PREUxOwotLSAKMi4yMC4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
