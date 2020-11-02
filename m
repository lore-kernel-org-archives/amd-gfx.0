Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D18C00A89
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 19:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB93206F1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 19:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="urB2Yfw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB93206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD9A46E50C;
	Mon,  2 Nov 2020 19:07:11 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF3F6E50C
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 19:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhTa9EzKvR8IrP3L9OZfmex+Tsd1ZMEOPEmpN0UV19Sl6OFq+yw4DmjK0nwheg/8NnLjqnu6DAw4lS2c2mhTCriYzG+dMDcEIkbgmwtPEeqqbM5BqIo6JaZneM0nT5So6ltE1EnqcmWkP7rqYD0/dTqJJd13X0XOOIE/pFhl7+ElRMKiQmn98edzJYK3oYNHCGkCtYx+7GmWVPQBcF2wvLTqcw78DaXsqBsWVVqfWA8HYPlz9z7upm6HOTCehLx6XYKzDe7jkOaV/z3CeT3cWcOIcbU3uXv+CkW3R/RWdrvzDiRVH3pDMNQg4RwyMmRCwCVKm+DSmKty8pThMD01Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e+EwF24h0NRffg0umphpm86GU/SEDrlUl/T0EHpnFY=;
 b=bl2JGoJRoSh3D8fNRXYkBbsIj+uDNod7Bs4TsBkjgtmZyRFxJmP86FodGBnrwB7vyPYPFWKZcfAEIUA9VocEtG5R7HOYgZW2sdpOWC+uaCAmAeBWqpwnLSB0QIPy1SZYiyb8DtPhc/Dsy98yeyUmbl0IvDckeiMuTi35GYkChlEgiA7sG7258Qsxqk7A7hidcMONus95b5gWrxv5fT/nZscUHgZozJkhvTi9ijwSqYxOjFwPV29jijPTRyq45XIOVj6FCaLHAW9aQsMhvMeUXIRebR6dsyaP1INa/PhP7IDml0ZKNX2eoj6/PCzflQlrgkqkuQzCfEvcGRvwJDwdPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e+EwF24h0NRffg0umphpm86GU/SEDrlUl/T0EHpnFY=;
 b=urB2Yfw/ozVdTibiV/yJBhfWRdlX8BuFwQa/Z9q/kTsKIIerAAX/5/uB00sy4l0ycPXbC0ijiLR2FYCSU8GSg0OzJRN0vaY3ZciSilLpLYKVNUDv75SymeXP6KchR8IV28g8FYNF93UdXwg8xDRNhX4DlapWwUD/R/aZX5c5wHU=
Received: from BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25)
 by BL0PR12MB2436.namprd12.prod.outlook.com (2603:10b6:207:42::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 19:07:07 +0000
Received: from BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::8867:11f7:90b3:1627]) by BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::8867:11f7:90b3:1627%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 19:07:07 +0000
From: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix off by one in amdgpu_vm_handle_fault
Thread-Topic: [PATCH] drm/amdgpu: fix off by one in amdgpu_vm_handle_fault
Thread-Index: AQHWsTSTxj+NjbZleESkWPXeSnKvHKm1NByQ
Date: Mon, 2 Nov 2020 19:07:07 +0000
Message-ID: <BL0PR12MB2433728EE1623B24562CDEEB9C100@BL0PR12MB2433.namprd12.prod.outlook.com>
References: <20201102162351.1493-1-christian.koenig@amd.com>
In-Reply-To: <20201102162351.1493-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-02T19:06:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=12105f12-369b-470a-80e5-0000118339e1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-02T19:07:04Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 1dcbf01d-27e7-4639-9268-0000f95d88b4
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [122.179.124.15]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b673162b-b516-4335-0a68-08d87f627e6e
x-ms-traffictypediagnostic: BL0PR12MB2436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2436FE211155AF99C76F863D9C100@BL0PR12MB2436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bY2jJsJGE7nwuRtzsDrVwrEYp8oIhG/B58Vi0vhxZ7L68JO972Bl8ABK5WgmrZ4cnbqHx/7QrmhNcxBL4VpxI+DJQQeRBseQfK3uqJqqbHfja1hh2a6Q6Yj9zzRTUeApcai+hLJJKRXtf3pSioN1s/U4nDchwgMR2Tdo4Ng8cQ64jdWpXd33DKCcXdu9CNQah3M3tHJGs3bztekqKuOhq4NmQ6iTJ8q/qLNTFl0jj9yqiyQ/TBQXHbcN7dL+tijzrz27Xxo3VFnK7lRYEubOdMKvixDkNJ7SEZ7O52TCUQ419FHyQBkplZlFwUboc3KKyPaNESyh1q+GuOrPJ8oV9ooDdR2OlKWHSgU6Sf0xRjE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(316002)(66556008)(66446008)(66476007)(71200400001)(66946007)(8936002)(7696005)(33656002)(53546011)(45080400002)(64756008)(966005)(6506007)(8676002)(478600001)(52536014)(5660300002)(76116006)(83380400001)(110136005)(2906002)(86362001)(26005)(55016002)(4326008)(186003)(66574015)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ECddbVwFHFNB0GRij4KC+brxTpKZ95QNjSuT+BpOAhhb/heRFmMacErgF/DSYTYlEIm4S6RmhlvNmMjP9JC0sOWZxMi/wqE1BI49chKU7wsk7pkEFFVrau01CtiCdtZVx1MbJZZ+2Q9vPWkV78OUlBjiczU6GqBYVCd3ICb65Knv72yazyFFhUME/e6ahIdjZogfc2SMjnW9pBcpbKSsGr0uKTEGkuwexMOToj5QFtQ/bSm9ZMx3+7QR4tRn1NZD730qk+H113qZatafgs/sMN53ujKkr7i8jI5Jy5WmYpcr06CVrNOQJL3GkzTmvABVZj7tqSSqwHyGTK5myzW+AzTElq66l7y1K2e5/qD5ZG8E660rbgDCbhE+aAmU1dWBQF5f3wHmIQFfhdzy0lLfbh71c4CFHHPyw5TE4ntr/+JmHUYeyzK+po1suoHUQriTwp/1d15+cqMhl0D6NhpLHdzWJzjeWiGHb/EcCB+luo4Mp+lULXqdTGipg9aGJHoflhSrdAqYmHqC5BnoBIdfAmRq72swm7pv6smrZycVxal9lCSNA+OUIBOV+jJsN2lzWSkfn92Lc56ajByLBiwpPR5njUT+a2l56z+KKoYkY9Q/Q2DD+xgs6iFvkUU3Oc8BVghOpr6NZoEB2BhpZN76kQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b673162b-b516-4335-0a68-08d87f627e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 19:07:07.6009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqAfvyU4VkrLv/GeqXOEx4Mr5/OZo5G9BR7KFWbcF5W8BweDFIGrBcPjvffpRWZsBBcd6zVU24ILMA/hfxsPUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2436
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1k
LWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9m
IENocmlzdGlhbiBLw7ZuaWcNClNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMiwgMjAyMCA5OjU0IFBN
DQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBLdWVobGluZywgRmVsaXgg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGZp
eCBvZmYgYnkgb25lIGluIGFtZGdwdV92bV9oYW5kbGVfZmF1bHQNCg0KVGhlIHZhbHVlIGlzIGlu
Y2x1c2l2ZSwgbm90IGV4Y2x1c2l2ZS4NCg0KTG9va3MgZ29vZCB0byBtZTogUmV2aWV3ZWQtYnk6
IE1hZGhhdiBDaGF1aGFuIDxtYWRoYXYuY2hhdWhhbkBhbWQuY29tPg0KDQpSZWdhcmRzLA0KTWFk
aGF2DQoNClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwg
MiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KaW5kZXggZGMwYmM1NTBlNDJiLi5m
ZGJlN2Q0ZThiOGIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCkBA
IC0zMzUxLDcgKzMzNTEsNyBAQCBib29sIGFtZGdwdV92bV9oYW5kbGVfZmF1bHQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2lnbmVkIGludCBwYXNpZCwNCiAJfQ0KIA0KIAlyID0gYW1k
Z3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKGFkZXYsIGFkZXYsIHZtLCB0cnVlLCBmYWxzZSwgTlVM
TCwgYWRkciwNCi0JCQkJCWFkZHIgKyAxLCBmbGFncywgdmFsdWUsIE5VTEwsIE5VTEwsDQorCQkJ
CQlhZGRyLCBmbGFncywgdmFsdWUsIE5VTEwsIE5VTEwsDQogCQkJCQlOVUxMKTsNCiAJaWYgKHIp
DQogCQlnb3RvIGVycm9yX3VubG9jazsNCi0tIA0KMi4yNS4xDQoNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9y
ZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q21hZGhh
di5jaGF1aGFuJTQwYW1kLmNvbSU3QzM4ZmQ1MWY2ZTNhNzRlNzAxNmU5MDhkODdmNGJiMzM0JTdD
M2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzM5OTMxMDQyMDgw
NzE4OSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9p
VjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT13
YW5XczdYU1FDV2VyVDFlOHdZeFpIcXltYW0yTHBxeXl0UGJlVXMlMkZ6RFElM0QmYW1wO3Jlc2Vy
dmVkPTANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
