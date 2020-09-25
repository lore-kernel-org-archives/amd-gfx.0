Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90723C4363D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 17:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF25D221EC
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 17:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dM1ajoQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF25D221EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16A846ED0A;
	Fri, 25 Sep 2020 17:52:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F3F76ED0A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 17:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpK7iU/doU8AmS3SkfkUwZnjqsXYW4qYGVDKPpecqdDYJs4hgf/c0T147D0I3wcP9WEaSVUiSm2N5neqTH2VWb5MlISCV0RUsGkIX7tUyRWPavBsNp7/ypQ6GFM5DOb1MEcnp8lIg2BFd/qlJaceuVNYh0WJrXpC4sGE7ZkAQ/30BsWuBq31WVgsN0GH2+IEeg1kf6QZA3yZMnNBdAimP/X+nZ3G1L45ypLTUERRrrUIyTbJCFw+ql7qqpetf4LkILfkWEuvft48+snZgRHAY82YDxxVVFq6Znd+2wIFW97udKyNq1rskhvUkZmOMBnfgUfbbvnokFNBnRLxRNlSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8pVNZolWMPFyALhf5YAB7sJVBtIVffsGtMEkkboM/o=;
 b=ldz67K4q083cpo2snAi2wdq3YOThSVtTVChqc1Bp8Y1zNCeQ7ep6efwllqe7gerIrnadmF+XK67FXxq9WvZIpRK/05F7ziUr7y83PGTLWg6zdTU7/tgXbVJT/TxMvB090dKmuAUmavyIlkRgME7YxYmRYuw3u2lr/4Lau6yW1K96cgQHpNhJ6Xw0U5J9EJXILZuFcqT8qY7UG8oF2PnHQzWFcwJmpuolFs62VW9//v3/78uYEVCflfFRmfJxrjM9xPwp3KUUdj+rcpiSBQFs/mKU/A48NODeCoQRIq7u37A/yfnHkGClfHRJCugDu6toVwVU8oRUAERgQ1axD/6VJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8pVNZolWMPFyALhf5YAB7sJVBtIVffsGtMEkkboM/o=;
 b=dM1ajoQ3KjQESQ9g/w3kI8tILWCNvYmcYmADEMgCoSWJbntx8ffuCsTk/Bt8dbRRUPzqvNNNTunx+XxpiJEfFiJIxoIffSYAJ8mpDbluuGYuhE/6d0WIbWsYIZ1saAih2/odw5lV6ZgV9FNDst7rC276XAfFLhvH+pAmU+a66kw=
Received: from DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) by
 DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.15; Fri, 25 Sep 2020 17:52:13 +0000
Received: from DM5PR12MB1337.namprd12.prod.outlook.com
 ([fe80::9cb7:1c41:684d:fc4e]) by DM5PR12MB1337.namprd12.prod.outlook.com
 ([fe80::9cb7:1c41:684d:fc4e%9]) with mapi id 15.20.3391.027; Fri, 25 Sep 2020
 17:52:13 +0000
From: "Cyr, Aric" <Aric.Cyr@amd.com>
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 7/9] drm/amd/display: Revert check for flip pending before
 locking pipes
Thread-Topic: [PATCH 7/9] drm/amd/display: Revert check for flip pending
 before locking pipes
Thread-Index: AQHWk0vgISoZH+S82U25dTUvAcZrxKl5gT8AgAAhPpA=
Date: Fri, 25 Sep 2020 17:52:13 +0000
Message-ID: <DM5PR12MB1337F9F15FF5B5124773673182360@DM5PR12MB1337.namprd12.prod.outlook.com>
References: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
 <20200925145455.2398170-8-Rodrigo.Siqueira@amd.com>
 <c03bb7fd-09a3-4f1e-b0a5-e7b49d7fc630@daenzer.net>
In-Reply-To: <c03bb7fd-09a3-4f1e-b0a5-e7b49d7fc630@daenzer.net>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-25T17:52:01Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2320061a-1aa2-4464-9f0a-000036e3ebff;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-25T17:52:01Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 05c8f983-43aa-4553-89d2-0000003cc240
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: daenzer.net; dkim=none (message not signed)
 header.d=none;daenzer.net; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f31b6765-c29a-4f20-6be9-08d8617bbc22
x-ms-traffictypediagnostic: DM6PR12MB3212:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB321237B21D81BC3DF785A37782360@DM6PR12MB3212.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n7VuXgZw2fUPbOTpkhIYccwkLe0zbU4jqtupJfIzcoUkVrPL0JEUWl+g+yPm7DeDbnQolQV/lKht+ehf4l0LoMhoqCyy/uz1ZjEqRrNfRnUjskhOxtvSIVeYXVZWRtSTp9xyCZga4FmcDS8oQTst3jQ4Knfo6efxbKbJikq8BISQzCn3Sdj25/Q+Q5V7WpM48glHiSkpVAzwHUK4ceKfyQxlX4FXoXRjaeKjfjTUhH3APw21r1gMHa4A0OfLfElmUZ+rVxSooLjaTpzQUTeKIbAI65czxOk8uc/d6dV24z/rDZvW2eDpd2gnbkaLZbAvtrPCAkjbx9xdULkxRRKHEI55WarJqaPwy9uiXt+T/CUERVXju8pjcVztqsxL94p6SMJG21Fau3HemrdPGy8C7A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(186003)(110136005)(7696005)(26005)(86362001)(316002)(4326008)(66446008)(5660300002)(66476007)(45080400002)(66556008)(53546011)(76116006)(71200400001)(6506007)(478600001)(64756008)(66946007)(52536014)(55016002)(66574015)(9686003)(2906002)(8936002)(8676002)(54906003)(33656002)(966005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: axLLHnY7+DCviY2l1Ii8MhVx48No1ajCfsR6SgQonCLuRS7R2wAodZCAr3MJNhX23lYZElu3JGMGAGDgbNN7BBXiWhG2eDLM/tJyjBxriOpYhi7ZPiU79goLBW/7KSAymQ28rTgrhkC7dwqHwz1WPTOEny4kNuVU+Vj4dDOlJ5W337KtPLDRpyaf/ziYpN9K72g6mSMl16kYyO18Kvm4/rHrYJiyBkHkebLOvbyKJI/eHKcJDvlaSO6JLm1ciLer5lK1ID2s7MUyd/AEWHCEYPOe3H9U0rZPN4++jngM9Pqy7wwQDRDAoHwt3vH8egy5/kgKc+Eq/8s9JCML0REYW8EBwllvYYW2X9Ko9pXJOEGy44gwVTzxIy8uxPat5LhMQ2lf2IlVLzFFKORpEGOSGB4MNIRLBAXZgC39B6LH2uYn8nuikQBsGl3YxbEeIYyEpE9WJM0qRNkXdInhLYFGr77NEdsVJZ1NQlG/VszqLeB9F3Gcnqp1bjmpK2FWcPfKK/qvjpgYTXnxWw8EJS91Lv3yWsthrsmnjq8K6lwDFkM3qV0w0+wvqTaWEKAJIKcQmLn/D5t/D9+Xz/eQxFtloSlthY/sFFeuVxVWbDPjXM4JGd2kg8UHuYga83kaYsWZs0WUD7EuyuZvqahVx1zsTw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31b6765-c29a-4f20-6be9-08d8617bbc22
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 17:52:13.6260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6AMP0r0k+TcFgBrTeLCNeElJ520W1ZWaaCzwALJMYuMx4vaeFUox4xRZjz1IxNP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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
Cc: "Brol, Eryk" <Eryk.Brol@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo, 
 Qingqing" <Qingqing.Zhuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpJ
dCdzIGFscmVhZHkgdW4tcmV2ZXJ0ZWQgaW4gbGF0ZXN0LiAgVGhleSBjb3VsZCBiZSBzcXVhc2hl
ZCBJTU8uDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNaWNoZWwgRMOkbnpl
ciA8bWljaGVsQGRhZW56ZXIubmV0PiANClNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDI1LCAyMDIw
IDExOjUzDQpUbzogU2lxdWVpcmEsIFJvZHJpZ28gPFJvZHJpZ28uU2lxdWVpcmFAYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogQ3lyLCBBcmljIDxBcmljLkN5ckBh
bWQuY29tPjsgQnJvbCwgRXJ5ayA8RXJ5ay5Ccm9sQGFtZC5jb20+OyBMaSwgU3VuIHBlbmcgKExl
bykgPFN1bnBlbmcuTGlAYW1kLmNvbT47IFdlbnRsYW5kLCBIYXJyeSA8SGFycnkuV2VudGxhbmRA
YW1kLmNvbT47IFpodW8sIFFpbmdxaW5nIDxRaW5ncWluZy5aaHVvQGFtZC5jb20+OyBQaWxsYWks
IEF1cmFiaW5kbyA8QXVyYWJpbmRvLlBpbGxhaUBhbWQuY29tPjsgTGFraGEsIEJoYXdhbnByZWV0
IDxCaGF3YW5wcmVldC5MYWtoYUBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCA3LzldIGRy
bS9hbWQvZGlzcGxheTogUmV2ZXJ0IGNoZWNrIGZvciBmbGlwIHBlbmRpbmcgYmVmb3JlIGxvY2tp
bmcgcGlwZXMNCg0KT24gMjAyMC0wOS0yNSA0OjU0IHAubS4sIFJvZHJpZ28gU2lxdWVpcmEgd3Jv
dGU6DQo+IEZyb206IEFyaWMgQ3lyIDxhcmljLmN5ckBhbWQuY29tPg0KPiANCj4gVGhpcyByZXZl
cnRzIGNvbW1pdCBlODJkOGVhZTllODFhZjI0MzI1NmY3MGJlYzU5M2JhZWQ1MGIwYmRiLg0KDQpF
dmVyeSByZXZlcnQgc2hvdWxkIGV4cGxhaW4gaW4gdGhlIGNvbW1pdCBsb2cgd2h5IHRoZSBjaGFu
Z2UgaXMgYmVpbmcgDQpyZXZlcnRlZC4gKFlvdXIgZnV0dXJlIHNlbHZlcyBtaWdodCB0aGFuayB5
b3UgZm9yIHRoYXQgc29tZWRheSA6KQ0KDQoNCi0tIA0KRWFydGhsaW5nIE1pY2hlbCBEw6RuemVy
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnJlZGhhdC5jb20lMkYmYW1w
O2RhdGE9MDIlN0MwMSU3Q0FyaWMuQ3lyJTQwYW1kLmNvbSU3Q2ZmODMxOGY3NTA1ZjQ4YWM0ZTYw
MDhkODYxNmIxMDUwJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3
QzYzNzM2NjQ1OTc2NDQ2NzI4MyZhbXA7c2RhdGE9ZWVLZEI4Tk5iM3RhbnZ3NUdUb0c3WWJFVFkl
MkZZS25FSlFYUnNmdUU2dTVrJTNEJmFtcDtyZXNlcnZlZD0wDQpMaWJyZSBzb2Z0d2FyZSBlbnRo
dXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXINCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
