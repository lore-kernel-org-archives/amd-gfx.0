Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC290C2D0A3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 06:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120F52084C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 06:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M/f3FkQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120F52084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CBCA6E12D;
	Thu, 12 Nov 2020 06:26:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD836E12D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 06:26:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlwLdDR4K7ziFd7fdBfzyr4wQhveHsrOfNhwicJkKPb5WcqiXplej/4OZk6X+1QO0xFAM9i4aw58UGU37Y4e64TNFkVN0o49a172T6X73Re1Y3j8MUTIyp4mNsuy9treH9uT+SZOYg0/RjOCw6FSbK/lUgPZkdruwBmu6xB8g9cpsyrbwrPcaWXtjf2LSxDIytndYOpwZp0+bYvstWZ9mtyOYYMJ5b4heezyRFJ6MB208UnyEZqmZwudKlag1zFIIfPaeB/78Fd4Jx0ENz7pgk45CGOeVeoJEpyb3zPWNpr9a+CO8/MC4zHS6oj/Gnpu+EOXd7fzH8kxbHnDhy3eog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsfjQ53BJnEf6Ea6Z+97+vBTyevdMBkreH3zIEJ4S8o=;
 b=ECLbCs/tJTwuCf60nHryqZIaWCVe1IJxLgTt/yVQK2pm4vbl3miQIGfdZrkOz6siTKRtKW4Uml4WMtKABE4SGI+Q1BTiKeuXqhu50NwJGKjcO3cAuCOcQDp6T+cseHMDaF3+h/uHyBm8cQbe1HWIWBx2C/DjceV2gpRJkimTgwnoIyw/sjcPPuLconYgdClwP12nBLVnUNILCHekrs62hA5SZjeY0Jf0juPUjr82qsq2PslTqRKcVSxf10Tg3aJG1dVmPHhKpXZKHCDDpvLQNgE/np9nuXDQfrQakDWaXyyvZCs1OiZTVdngauxWFXCmB1nEWY8uPLspjpXWsyEnRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsfjQ53BJnEf6Ea6Z+97+vBTyevdMBkreH3zIEJ4S8o=;
 b=M/f3FkQkofEj02QyCWArPu8JEvO1ultjApbCHUa9zLdl/2fnsdnj6mWw7p9SYo79Jbl2mjBFILZdnpkDtqrRZnfWWsc5nPpkZBy9ErPKBUQ3mfsIf2J5IgMwEOVA0gGD/I/NsBJ2rT3K5zGJTe4eWWCLSjJsEeRbENPPprsUFro=
Received: from BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25)
 by MN2PR12MB3741.namprd12.prod.outlook.com (2603:10b6:208:162::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 12 Nov
 2020 06:26:50 +0000
Received: from BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::f82c:5e14:7caf:8f13]) by BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::f82c:5e14:7caf:8f13%6]) with mapi id 15.20.3541.023; Thu, 12 Nov 2020
 06:26:50 +0000
From: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/8] drm/amdgpu: cleanup gmc_v10_0_process_interrupt a bit
Thread-Topic: [PATCH 3/8] drm/amdgpu: cleanup gmc_v10_0_process_interrupt a bit
Thread-Index: AQHWsel0B7Y5yOWTJ0y040M/t59fdKnEFSpg
Date: Thu, 12 Nov 2020 06:26:50 +0000
Message-ID: <BL0PR12MB24337552EC0E4C6FB5111FD99CE70@BL0PR12MB2433.namprd12.prod.outlook.com>
References: <20201103135837.39693-1-christian.koenig@amd.com>
 <20201103135837.39693-3-christian.koenig@amd.com>
In-Reply-To: <20201103135837.39693-3-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-12T06:26:47Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4db1f449-cbf0-4383-87f7-00009e3c8626;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-12T06:26:42Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7fe83e33-7ab0-4ff1-9829-0000ce8fd034
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-12T06:26:48Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 7cfcab76-80c2-4e67-ac0d-0000ff45d52c
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [122.179.56.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3870ddaf-b817-462c-418d-08d886d3f060
x-ms-traffictypediagnostic: MN2PR12MB3741:
x-microsoft-antispam-prvs: <MN2PR12MB374110A54FDFBF11A2BCD77D9CE70@MN2PR12MB3741.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:366;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NqFlBA80/MTHTjb8im77V9ZM4ZX5h4jxicf0S8gYq4iEB3dEqzdEViizehJW++7nw0AIwQhl9tc3OLuLaxcQmIc39/MdZp91bgNXrcNIHOj1FNyc6+iMkhIvtAxGxhbvcaixao1+2bKNqzRo5niOET1m6Vkr0xVcD4mUPXag2dTS71OAl4vj5hDPO6oFjYXq7g9PxZV3zV42eCCsRvZ2HQic9Qby6ub0AR+IkzQSPncMHNQuWOnKHBhn80J2fjlPAaRlWzxdy/9uzeh3Iuo4VpghsTS+NwctotMUfu3APOXEzd+9Dzgar/Kl3rgVosa8NJOgag7BN1OhVUUBPWaqg9qbPoYWkhfwo6TMvNmyKxQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(8676002)(5660300002)(110136005)(9686003)(2906002)(186003)(66946007)(52536014)(478600001)(7696005)(316002)(45080400002)(66446008)(64756008)(66476007)(33656002)(66556008)(86362001)(76116006)(966005)(26005)(55016002)(6506007)(53546011)(71200400001)(83380400001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wXQ9yoDAsO2RB/g2SdLJoAV/bUpGneY+dt8OQl82CxCLrIH1D/W0ePfGoM+sNH5IKstvk5jE5+t/xo7uq3kpBQJb5CZwb0z9aqb1MDJeaWq0ipXewM6YiRPajq/nXsgItoCctoPRhmM3qjiiyoGlld0+/6HTEuZfPHCQkCyIZU58fa3YMv7ZjksIdFBhp35Sq825e9SHWIE2vzkKT5y5UP3KAtI3cVI3tqO4lnVVknvo6QcTpVMPoaiYqx1LX6Jhr1cEz3t+CUwMlnkA2DuY3iIIFssoUpvoAeay523xQHVKzFeIPs/b1noxMjrIP4idTiMO4J/rwjJX13XDWstDwbw9qg99iAF26UTcsGJzotaeAtX7Sxme9wkHI8QuCmY4FmvPa0P9st4rx4Y2RfD7LyunryXJINYxXTybDxYPrG0SG+JRfmFoUlqUKpHePV2biWdlGNoRCQ5TXOiVNZ1FBj0WPocb5oU0aEFRAOUqaVT+pluVTq+W20stCYTMYQM5ZIXOE5Ao5JL6L0hSS3cP7k9qqCWa6YGjxG8zEwmlnf7o6ClznBMGtOpJGpjd3srH7Azz7OXNQZNjznUL8NGKeKpIxYxypjbk+3ujrQU/CM0NKjT3ixZmlJD4k0l+tKazNGsLYvhmAz3rUTqtJv2XpA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3870ddaf-b817-462c-418d-08d886d3f060
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 06:26:50.1067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+UfJAKd+dptRc5MoxCSxeQDUIGYvka+5+gv8giFpcLbckHTf66XG8qxv6d6p0J+IE3S+na/JXmzawxzelSNiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3741
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1k
LWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9m
IENocmlzdGlhbiBLw7ZuaWcNClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDMsIDIwMjAgNzoyOSBQ
TQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBbUEFUQ0ggMy84
XSBkcm0vYW1kZ3B1OiBjbGVhbnVwIGdtY192MTBfMF9wcm9jZXNzX2ludGVycnVwdCBhIGJpdA0K
DQpSZXR1cm4gZWFybHkgaW4gY2FzZSBvZiBhIHJhdGVsaW1pdCBhbmQgZG9uJ3QgcHJpbnQgbGVh
ZGluZyB6ZXJvcyBmb3IgdGhlIGFkZHJlc3MuDQoNCkxvb2tzIGZpbmUgdG8gbWU6IFJldmlld2Vk
LWJ5OiBNYWRoYXYgQ2hhdWhhbiA8bWFkaGF2LmNoYXVoYW5AYW1kLmNvbT4NCg0KUmVnYXJkcywN
Ck1hZGhhdg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAu
YyB8IDM4ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDIwIGlu
c2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjEwXzAuYw0KaW5kZXggZDkzOTkzMjRiZTQ3Li5jZmZjM2NhOGZjZGUgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMNCkBAIC05NSw2ICs5NSw3IEBAIHN0YXRpYyBp
bnQgZ21jX3YxMF8wX3Byb2Nlc3NfaW50ZXJydXB0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LA0KIAkJCQkgICAgICAgc3RydWN0IGFtZGdwdV9pdl9lbnRyeSAqZW50cnkpICB7DQogCXN0cnVj
dCBhbWRncHVfdm1odWIgKmh1YiA9ICZhZGV2LT52bWh1YltlbnRyeS0+dm1pZF9zcmNdOw0KKwlz
dHJ1Y3QgYW1kZ3B1X3Rhc2tfaW5mbyB0YXNrX2luZm87DQogCXVpbnQzMl90IHN0YXR1cyA9IDA7
DQogCXU2NCBhZGRyOw0KIA0KQEAgLTExNSwyNCArMTE2LDI1IEBAIHN0YXRpYyBpbnQgZ21jX3Yx
MF8wX3Byb2Nlc3NfaW50ZXJydXB0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KIAkJV1JF
RzMyX1AoaHViLT52bV9sMl9wcm9fZmF1bHRfY250bCwgMSwgfjEpOw0KIAl9DQogDQotCWlmIChw
cmludGtfcmF0ZWxpbWl0KCkpIHsNCi0JCXN0cnVjdCBhbWRncHVfdGFza19pbmZvIHRhc2tfaW5m
bzsNCi0NCi0JCW1lbXNldCgmdGFza19pbmZvLCAwLCBzaXplb2Yoc3RydWN0IGFtZGdwdV90YXNr
X2luZm8pKTsNCi0JCWFtZGdwdV92bV9nZXRfdGFza19pbmZvKGFkZXYsIGVudHJ5LT5wYXNpZCwg
JnRhc2tfaW5mbyk7DQotDQotCQlkZXZfZXJyKGFkZXYtPmRldiwNCi0JCQkiWyVzXSBwYWdlIGZh
dWx0IChzcmNfaWQ6JXUgcmluZzoldSB2bWlkOiV1IHBhc2lkOiV1LCAiDQotCQkJImZvciBwcm9j
ZXNzICVzIHBpZCAlZCB0aHJlYWQgJXMgcGlkICVkKVxuIiwNCi0JCQllbnRyeS0+dm1pZF9zcmMg
PyAibW1odWIiIDogImdmeGh1YiIsDQotCQkJZW50cnktPnNyY19pZCwgZW50cnktPnJpbmdfaWQs
IGVudHJ5LT52bWlkLA0KLQkJCWVudHJ5LT5wYXNpZCwgdGFza19pbmZvLnByb2Nlc3NfbmFtZSwg
dGFza19pbmZvLnRnaWQsDQotCQkJdGFza19pbmZvLnRhc2tfbmFtZSwgdGFza19pbmZvLnBpZCk7
DQotCQlkZXZfZXJyKGFkZXYtPmRldiwgIiAgaW4gcGFnZSBzdGFydGluZyBhdCBhZGRyZXNzIDB4
JTAxNmxseCBmcm9tIGNsaWVudCAlZFxuIiwNCi0JCQlhZGRyLCBlbnRyeS0+Y2xpZW50X2lkKTsN
Ci0JCWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KLQkJCWh1Yi0+dm1odWJfZnVuY3MtPnBy
aW50X2wyX3Byb3RlY3Rpb25fZmF1bHRfc3RhdHVzKGFkZXYsIHN0YXR1cyk7DQotCX0NCisJaWYg
KCFwcmludGtfcmF0ZWxpbWl0KCkpDQorCQlyZXR1cm4gMDsNCisNCisJbWVtc2V0KCZ0YXNrX2lu
Zm8sIDAsIHNpemVvZihzdHJ1Y3QgYW1kZ3B1X3Rhc2tfaW5mbykpOw0KKwlhbWRncHVfdm1fZ2V0
X3Rhc2tfaW5mbyhhZGV2LCBlbnRyeS0+cGFzaWQsICZ0YXNrX2luZm8pOw0KKw0KKwlkZXZfZXJy
KGFkZXYtPmRldiwNCisJCSJbJXNdIHBhZ2UgZmF1bHQgKHNyY19pZDoldSByaW5nOiV1IHZtaWQ6
JXUgcGFzaWQ6JXUsICINCisJCSJmb3IgcHJvY2VzcyAlcyBwaWQgJWQgdGhyZWFkICVzIHBpZCAl
ZClcbiIsDQorCQllbnRyeS0+dm1pZF9zcmMgPyAibW1odWIiIDogImdmeGh1YiIsDQorCQllbnRy
eS0+c3JjX2lkLCBlbnRyeS0+cmluZ19pZCwgZW50cnktPnZtaWQsDQorCQllbnRyeS0+cGFzaWQs
IHRhc2tfaW5mby5wcm9jZXNzX25hbWUsIHRhc2tfaW5mby50Z2lkLA0KKwkJdGFza19pbmZvLnRh
c2tfbmFtZSwgdGFza19pbmZvLnBpZCk7DQorCWRldl9lcnIoYWRldi0+ZGV2LCAiICBpbiBwYWdl
IHN0YXJ0aW5nIGF0IGFkZHJlc3MgMHglMDEybGx4IGZyb20gY2xpZW50ICVkXG4iLA0KKwkJYWRk
ciwgZW50cnktPmNsaWVudF9pZCk7DQorDQorCWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0K
KwkJaHViLT52bWh1Yl9mdW5jcy0+cHJpbnRfbDJfcHJvdGVjdGlvbl9mYXVsdF9zdGF0dXMoYWRl
diwNCisJCQkJCQkJCSAgIHN0YXR1cyk7DQogDQogCXJldHVybiAwOw0KIH0NCi0tDQoyLjI1LjEN
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1n
ZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9u
YW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJG
bGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7
ZGF0YT0wNCU3QzAxJTdDbWFkaGF2LmNoYXVoYW4lNDBhbWQuY29tJTdDZjFlZWFmYjExNzNjNDEx
MDBlNmUwOGQ4ODAwMDk0NzMlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAl
N0MwJTdDNjM3NDAwMDg3Mjg3MTQ4MjAwJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9p
TUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUz
RCU3QzEwMDAmYW1wO3NkYXRhPU5XZjhTYTl5Z1NBaHVWV2lzbXFoS3FTZ3VJUkJUVGMzQUdjRWk3
REZnVEElM0QmYW1wO3Jlc2VydmVkPTANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
