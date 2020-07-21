Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E225AC433E4
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 05:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833E320792
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 05:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nV2qQFDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833E320792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 139B5898E8;
	Tue, 21 Jul 2020 05:42:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0667C898E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 05:42:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNosNWNq602NrbMiDR5PtDuMgdfTCnSA+zviYDWs1eB1NAKxWB4Gnp3WJLTM1eeElIayFH5cipaWbZ18epgGdJAbSVzDvez4uMwqXYQ25LPvSxlm1TC9dv2a2ghLNfL6ASLUZ47fcmB+PdrA4AHu1LBtY8nK+y44dqeimegasd1SUyc71zBH+qegfoXTX/pvP8tzBOhLhEZQmWTCBdQoINQPerBEVufOrIg4Fc8WIYLXVnbM89sPrkTRSWPsmoXvqavNaZmk4GScOIPaBPQTxRjGnB5Pi6/ZK+tG2H9EnZecnohXxpmee81V4ut12xb0Wfrj/EYPis18iavjpN+efA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X2JQZe+Zf4Sv536FwoQoTNVxSyUzFzoiWVAUedmW0s=;
 b=QpYsrZX/YsrWBmZAassON+XAI4AuUqD/7mR8gcjzXzTVIjMAuYrEv2JmD7Oo4O8Eu3Udbc06+nLBaDyTiUxFQjMY52uQcr05EYE+3i2G9H9yxqd7WgnbhJ7ULwCO36JycQEsnIu5Zfhiu8YcOuk0goFaU60N1NWE6ayH9t9+SJf2FFElrn2vesKUYlqUJpH7xIeHmjpEL3SbpfTBqrNi9iXNWCeHwGPbnHBgA8xi/4UAMZ3eVyVpsU4CexfugnrH8APqGzYHOqs0GvDgRnOH+XrLeFIQvIQyxffKOOBeYKEJjuV9WmP/OKUsggwsz3IZ8TcyCbTFNAOQomBLrkT+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X2JQZe+Zf4Sv536FwoQoTNVxSyUzFzoiWVAUedmW0s=;
 b=nV2qQFDkga562U/bfFQN4LnIGNCoHjFDXasLr0r+FV6YWngFobvIjQ1hM60rc0osfFcuHCG7NjjVgNoUJkuBtqkTr/UbfeC+L4Dp+4vGzROwJkV6gTKZWzaQNwvw+DlJzzj5d2Kz7/mCf6xtj20/O3zrYJrNPz1KfMRDGcqgC9A=
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR1201MB0237.namprd12.prod.outlook.com (2603:10b6:301:56::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 05:42:21 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2%10]) with mapi id 15.20.3195.026; Tue, 21 Jul
 2020 05:42:21 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBkcm0vYW1kL3Bvd2VycGxheTogZml4IHR5cG9zIGZv?=
 =?gb2312?Q?r_clk_map?=
Thread-Topic: [PATCH] drm/amd/powerplay: fix typos for clk map
Thread-Index: AQHWXxhobJoh8wdAPkaIvir5fdXBzKkRf0sw
Date: Tue, 21 Jul 2020 05:42:20 +0000
Message-ID: <MWHPR12MB185451F0F867DC5BDEF4EB80EF780@MWHPR12MB1854.namprd12.prod.outlook.com>
References: <20200721043533.2227-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200721043533.2227-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [240e:e0:a67e:8600:cc2e:5ea:6f2b:6b41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 455b286f-afc4-4ec4-97c2-08d82d38d681
x-ms-traffictypediagnostic: MWHPR1201MB0237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB0237A1D6D076FAF164BA041AEF780@MWHPR1201MB0237.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EHmp69+gOeUkAIwpVXgPlB15iODS+3HNb5VM2/7qBWFLySV8dBN7ZYa8S4hxgomBeHMn0Y4ypJMyUqAj3zSfGhlgUPrOYlxBuuGdfHAoyygRfBYY7UoothRhuP6HvdW5w6pwLZb1s2HP1o+GwfbkC55P0mefaLeFYpApBpg/mjlB8Je/4AxZew1yB8+oYpHmAm+Vj/ocxIh7FUfH6WImu4PMh86DMKdqBdMZqR/hkW06epBh7eB7hnAtPXUQ9y1IntIDQZ/VNgHaAQdxJhrsEBzwlp2E1FGYGMY94H1QAGhhx3WA7Z/e5jmdjFaB+RwGKy2FJSDITKiGsuyxFNpa9A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(2906002)(55016002)(6506007)(86362001)(33656002)(64756008)(66946007)(66446008)(66556008)(66476007)(4326008)(54906003)(478600001)(76116006)(110136005)(9686003)(52536014)(316002)(5660300002)(71200400001)(7696005)(186003)(83380400001)(224303003)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4AOBKz9Gx3jhXpVLo6/jR3gdf/IRSxRFI64cB59b2y2dAe3LQ+GQmk6sFxyO8XeyW9iERMvdGml5XMgAaWA/6r2ACoZTyNkbIyQxPaKpdgwlfObHegwz1wt+6WFcta4yA9BcHbNTkLpB2qwE0wNIQ0RXvVALRAKdgS5StsXENOxjxKjVc5ZTGHa3o9Go5NwBKPjqXO702SFUQVk670Cr+GVpv2KrKhjYNCXeX1YdQTw52BnDfvfpynqU/n361aDD17BAwaAfo0Xvf5QeYNqJTILL8Q6v2ONVQiac/xWy4vIKkafIFCumpF1w/cMqsTFLNCsbxWYmzCdAxWSLxX5EbEpWvsy7D790KHkgiFa9fwqZlY46VjXtqYtPNV80Ffrvt3RhbFy4qbhl7qlNlbKi4TlMAShWpIO/vLYuHUHYh7hiRRj+ba7AYo+LziAUdqtrhLCDyzhSwb2py0IEtq5UKRRU1SW3o6I3vudJEsllL1NNY6l5Qua5mKtcCBAbF9WCKhez8alXcJ5pPzPW1WUILbwClG5cOrX2LCiKtnlBHx0=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455b286f-afc4-4ec4-97c2-08d82d38d681
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 05:42:20.9912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ab/UppOO0Lm/21uwmTE+WckelkN5tVJ8VBB+Uq4Gsr9d75y/WkGnHC9EeMKOZA4X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0237
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IExpa3VuIEdhbyA8TGlrdW4uR2FvQGFtZC5jb20+DQoNClJlZ2FyZHMsDQpM
aWt1bg0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogSmlhbnNvbmcgQ2hlbiBbbWFpbHRv
OkppYW5zb25nLkNoZW5AYW1kLmNvbV0gDQq3osvNyrG85DogMjAyMMTqN9TCMjHI1SAxMjozNg0K
ytW8/sjLOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0Ks63LzTogWmhvdTEsIFRhbyA8
VGFvLlpob3UxQGFtZC5jb20+OyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT47
IEdhbywgTGlrdW4gPExpa3VuLkdhb0BhbWQuY29tPjsgQ2hlbiwgSmlhbnNvbmcgKFNpbW9uKSA8
SmlhbnNvbmcuQ2hlbkBhbWQuY29tPg0K1vfM4jogW1BBVENIXSBkcm0vYW1kL3Bvd2VycGxheTog
Zml4IHR5cG9zIGZvciBjbGsgbWFwDQoNCkl0IHNob3VsZCBiZSBEQ0xLMS0+UFBDTEtfRENMS18x
IGFuZCBWQ0xLLT5QUENMS19WQ0xLXzAuDQoNClNpZ25lZC1vZmYtYnk6IEppYW5zb25nIENoZW4g
PEppYW5zb25nLkNoZW5AYW1kLmNvbT4NCkNoYW5nZS1JZDogSWIyMjM5YjM1ODQwZDM3NzRhMGUx
YWEzMTE0ZDJmOTY1ZTZkODhlN2MNCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L3NpZW5uYV9jaWNobGlkX3BwdC5jIHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L3NpZW5uYV9jaWNobGlkX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvc2llbm5hX2NpY2hsaWRfcHB0LmMNCmluZGV4IGNhZThlNzc2ZmFmZS4uODdlZWRk
N2MyOGVjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc2llbm5h
X2NpY2hsaWRfcHB0LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NpZW5u
YV9jaWNobGlkX3BwdC5jDQpAQCAtMTI4LDggKzEyOCw4IEBAIHN0YXRpYyBzdHJ1Y3QgY21uMmFz
aWNfbWFwcGluZyBzaWVubmFfY2ljaGxpZF9jbGtfbWFwW1NNVV9DTEtfQ09VTlRdID0gew0KIAlD
TEtfTUFQKFVDTEssCQlQUENMS19VQ0xLKSwNCiAJQ0xLX01BUChNQ0xLLAkJUFBDTEtfVUNMSyks
DQogCUNMS19NQVAoRENMSywJCVBQQ0xLX0RDTEtfMCksDQotCUNMS19NQVAoRENMSzEsCQlQUENM
S19EQ0xLXzApLA0KLQlDTEtfTUFQKFZDTEssCQlQUENMS19WQ0xLXzEpLA0KKwlDTEtfTUFQKERD
TEsxLAkJUFBDTEtfRENMS18xKSwNCisJQ0xLX01BUChWQ0xLLAkJUFBDTEtfVkNMS18wKSwNCiAJ
Q0xLX01BUChWQ0xLMSwJCVBQQ0xLX1ZDTEtfMSksDQogCUNMS19NQVAoRENFRkNMSywJUFBDTEtf
RENFRkNMSyksDQogCUNMS19NQVAoRElTUENMSywJUFBDTEtfRElTUENMSyksDQotLSANCjIuMTcu
MQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
