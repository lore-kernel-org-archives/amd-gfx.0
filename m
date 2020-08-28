Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451F8C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 14:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15BC320791
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 14:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C3j+/b9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BC320791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8029088FFB;
	Fri, 28 Aug 2020 14:30:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C25766E4C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 14:30:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eo2/fgqf5vzChIGQx7wpmPmwsSuV70a3sRhyeer9BR2Ai+4s81vguXkcbFEl43ZyHRyz8+zA3EqSuyfvilNIZ09EyuFuRgt6hzoFMYKhQhNCWrIkeU5oQV+TLStcJ6p04gM4uKQVP004DtA97k6IGlqTVBTP1tk2dEyHfcKhdswSzrvsl6kbVTciL0TZsqpkrr30l2eeh9VTn6IqvoVPb9or/G9/1c25mgubAYUu9Na4MNU/wHkqD00pHO9Xgw9ZtTUbAN3abVZpwfq7kYbhsquOwzion79HE2LPBAsLn7m+4mbTUdoqezXoGEhrPup4zOsdxJ+bmVBqdQipKPXsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5Sj10KYceb9cYhLDR/luOUFKD83abG3r+bl950YzFc=;
 b=Tp2jo8XvqtSCjm8dGkCnYDW5ngRUYsco47QEgG8CsSHSktHy9/OGy2LIOCthrKc4kE7Ng/yvCvOCMlJ7aQYDAbZz1FhcuP/0ePS0YWgWsLGOrM9e+PZKDBqywEIcc6dhzN0/ovDnwCu/vvcPi7F/XDqx3sgI0n7zYmTkshaKoNYupYV9BblAi3HbXT1SG70ixWmxTqPy8Jpcjorxi/QboZgS2ZM9/OYMRvy+KIha28KoMo/ykT+VPI6DuB+YKiEv3YQ49woSe0CkJMqyBtkNJNNjVK4VT82cTtso+ZQ0EYBX0Etmr16Mc8Gg6S7MU2+f7iKti5TYRqnjEhSsi6GvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5Sj10KYceb9cYhLDR/luOUFKD83abG3r+bl950YzFc=;
 b=C3j+/b9izKOHVesKqThosdxP2tpqNkWDwiE5jRdiPhx+BRAMWEkw6GlrJ7BC17wwBNLyRiUTAyfaynV73qKIUiFsaWIGhloEev7WiQClJ0WLl5QFefqurpGvEaX4FodDlXPpIio7BqvWks+AF6BQei+lPY4dPOtoTN+msMgCyBI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3693.namprd12.prod.outlook.com (2603:10b6:208:159::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 28 Aug
 2020 14:30:44 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3283.030; Fri, 28 Aug 2020
 14:30:44 +0000
Subject: Re: [PATCH 3/8] drm/amdgpu: add pre_asic_init callback for SI
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200824161527.2001591-1-alexander.deucher@amd.com>
 <20200824161527.2001591-3-alexander.deucher@amd.com>
 <62c44d4c-ece3-5e61-7d20-2d8da9734a1a@gmail.com>
 <CADnq5_NSEURcJgMpd3EH7UFEqLW9ib6yrvOELFm0BXxoj4kcaw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1e839263-7f06-d1b0-c70f-eba408b2e389@amd.com>
Date: Fri, 28 Aug 2020 16:30:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_NSEURcJgMpd3EH7UFEqLW9ib6yrvOELFm0BXxoj4kcaw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0061.eurprd04.prod.outlook.com
 (2603:10a6:208:1::38) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR04CA0061.eurprd04.prod.outlook.com (2603:10a6:208:1::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 14:30:43 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 310f70b2-e8a3-4445-ddac-08d84b5ef256
X-MS-TrafficTypeDiagnostic: MN2PR12MB3693:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3693C2DFFE67217CD5911CA583520@MN2PR12MB3693.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H4JJmE9TOBme1yk4pmInXPt3ujiijHbbdLZI8uHsiUmU4fLgpo2Vw/WITsiCv6zMsshdNt0TPS+EoDYbaPaDjtP4HhmGIUv3MX0JfJ7ovfQ+mVoEpQw3cHsGpF09UMgP044FYV7k/x2cMjE25aRyqJTcO2ZpMFd/aLeA8JHN/260wPS6yDY8b4CgvE3MMNBtJl9WFXfq+IYs39zLnJuGafJmEoaa6poFyQ2T1YOjHjpUnuYkxwF0Mwtk+DI/k3G2vVMA8Y0nVhTHt41chE3941meDhV6BMkLGCoJcQmBQVmC7InDhLDYPx272sG0SUBpMP/7Z57rY77mNUCzqVSZNWjec5BHI89pZb//TiTcrC6GI/tj8teD2iyHOapZHw57
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(5660300002)(66574015)(6486002)(478600001)(2906002)(186003)(36756003)(2616005)(52116002)(53546011)(83380400001)(16526019)(4326008)(316002)(31686004)(66556008)(6666004)(66476007)(66946007)(6916009)(8936002)(31696002)(54906003)(8676002)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +HxM30+cf03xoHqk+CTA8SGo5nzNvwnMxyeTomzzsA8sdrxinJWMU3+TyEWivSiUCZ8D+MeUXn3BMbpnUt4nBuytDwbTdD5ZkeB/llHOt3cVXulm8pK+yraTTPO+q5q7xfZBSVJgdUi2IiLwiwztvsZj4D657yTIAp/lT3sIH34Ko3oPqNWOHS1N4rE/gSYGH01tfOEdWN1hp4Gl3uDVvHMOUgGsVfxLAHP3v/HPqcSeqfCDuRyqjn1GZJTREsYgcW+3JXLWWjtxkly4qGPaHfb96NFJsa8N7Htvz/Ai70Ckl1DigXopacotWRwmYuqaiCHrAF9EViwJC4bOa4pt2717lpLrd1MjfpZZNSKoSMu9gvorJ3LEhKjmgkLrWRmU1a4EgooG/w8/5tN5iywYTx1tcm+CM9AcmM/4+IohIHkUkKT6rDTGsiisbAeL4tu9hsvHTmwgsrj0HbO/zZJGMhhh3uV3VVknNuyzvPWwcQGMSPvKfG+pQX1FaHhjD4lZrep5rYwIxOn6LJ5a9G1cb+VV0ecNbshQw2ET3lvfsgRFyIJ8nP8qcW17yBvAS5C1HGH4y/nccEKncW/UANeOZwYe2j0bkndTjcIOiCUkYvJdY1JxkK3x8cqray7U4xDC+HBh0hsZGIKwBhsrsoTRXQ0ie+xYKyaW3FkVRuuWJUHnBUT5HAjsyK2PCyKZn+ylLKueOUeWUn5CRZqUNbYvBQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310f70b2-e8a3-4445-ddac-08d84b5ef256
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 14:30:44.0281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3gSTVjMDVzmqH8BeSY0kKkZQctZgrug5X7+VT9TJJsgCa8kNoWRJBKe3sQRV7Qk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3693
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjguMDguMjAgdW0gMTU6Mzggc2NocmllYiBBbGV4IERldWNoZXI6Cj4gT24gRnJpLCBBdWcg
MjgsIDIwMjAgYXQgNDowNiBBTSBDaHJpc3RpYW4gS8O2bmlnCj4gPGNrb2VuaWcubGVpY2h0enVt
ZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPj4gQW0gMjQuMDguMjAgdW0gMTg6MTUgc2NocmllYiBB
bGV4IERldWNoZXI6Cj4+PiBOb3RoaW5nIHRvIGRvIGZvciB0aGlzIGZhbWlseS4KPj4gVWZmLCBu
by4gQ2FuJ3Qgd2UganVzdCBtYWtlIHRoZSBjYWxsYmFjayBvcHRpb25hbD8KPj4KPiBJIGd1ZXNz
IHdlIGNvdWxkLCBidXQgYWxsIG9mIHRoZSBvdGhlciBhc2ljIGNhbGxiYWNrcyBhcmUgYXNzdW1l
ZCB0byBiZSBwcmVzZW50LgoKWWVhaCwgYnV0IHRob3NlIGFyZW4ndCBlbXB0eS4gQXJlbid0IHRo
ZXk/CgpXaGVuIHdlIGdvdCBhbiBlbXB0eSBjYWxsYmFjayB3ZSByZWFsbHkgc2hvdWxkIG1ha2Ug
aXQgb3B0aW9uYWwsIGV4Y2VwdCAKaWYgaXQgaXMgZXh0cmVtZWx5IHBlcmZvcm1hbmNlIGNyaXRp
Y2FsLgoKQ2hyaXN0aWFuLgoKPgo+IEFsZXgKPgo+Pj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zaS5jIHwgNSArKysrKwo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zaS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2kuYwo+Pj4gaW5kZXggZWFh
MmYwNzFiMTM5Li40NTVkNWUzNjZjNjkgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zaS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaS5j
Cj4+PiBAQCAtMTg3MSw2ICsxODcxLDEwIEBAIHN0YXRpYyBpbnQgc2lfc2V0X3ZjZV9jbG9ja3Mo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUzMiBldmNsaywgdTMyIGVjY2xrKQo+Pj4gICAg
ICAgIHJldHVybiAwOwo+Pj4gICAgfQo+Pj4KPj4+ICtzdGF0aWMgdm9pZCBzaV9wcmVfYXNpY19p
bml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4gK3sKPj4+ICt9Cj4+PiArCj4+PiAg
ICBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9hc2ljX2Z1bmNzIHNpX2FzaWNfZnVuY3MgPQo+
Pj4gICAgewo+Pj4gICAgICAgIC5yZWFkX2Rpc2FibGVkX2Jpb3MgPSAmc2lfcmVhZF9kaXNhYmxl
ZF9iaW9zLAo+Pj4gQEAgLTE4OTIsNiArMTg5Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1k
Z3B1X2FzaWNfZnVuY3Mgc2lfYXNpY19mdW5jcyA9Cj4+PiAgICAgICAgLm5lZWRfcmVzZXRfb25f
aW5pdCA9ICZzaV9uZWVkX3Jlc2V0X29uX2luaXQsCj4+PiAgICAgICAgLmdldF9wY2llX3JlcGxh
eV9jb3VudCA9ICZzaV9nZXRfcGNpZV9yZXBsYXlfY291bnQsCj4+PiAgICAgICAgLnN1cHBvcnRz
X2JhY28gPSAmc2lfYXNpY19zdXBwb3J0c19iYWNvLAo+Pj4gKyAgICAgLnByZV9hc2ljX2luaXQg
PSAmc2lfcHJlX2FzaWNfaW5pdCwKPj4+ICAgIH07Cj4+Pgo+Pj4gICAgc3RhdGljIHVpbnQzMl90
IHNpX2dldF9yZXZfaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
