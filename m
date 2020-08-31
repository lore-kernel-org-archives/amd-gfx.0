Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61925C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3213820936
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JrHiDrkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3213820936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5C3B89E0E;
	Mon, 31 Aug 2020 15:11:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C9889E0E
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 15:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqC2gB4RxfSIErsmFhKoYDRfVKcjF5bPJ33Pu1j5/vDc8VGZgxBjwMfX5mKnYmSAwhW8rxjKG7AbOwUeurltWyf2gJREbvYXO5oQSI7NFENunNoUpQYqrv+62AcVdFdkUzdzGg5hh9LxF7iAKbqHjLNGAy9MUdG/FZXQpZj+9ZWiIG/7QFZ7m9r3hrz8VIdX6hProgHKv6LrppqCZv8eVf+MN27DGz621D95I59OwllabbxOvq8IGWEnzltgUPuWgTxO5YzJztSW+RDwQN/fMpNDSl2Paz01O0pnZqMXPiLUzWUmwH8i6pH74FeGqDOrgfWTqKEiNFzyYvNFMeC+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRqiMKblGVjWhBGTJ7D8AwizLb4ml1C5nMMl66lFD7A=;
 b=ibqT3plC6jd1lXNrqYmPqaecD4movlsWrdomh+FyUh+XylrbfXtdrE/e6G35FCwwuYsArp+PDaN8QMtu3155tLF+InHg3y1ajmGOrz/u2pRCQGGRf+7AAqxx1W6tPTzfbVFmEODiUDgokhe7O1rPjvcXH2No2u9Lm9Q1/2Rrmumbkh5pRCxz0ZUHad3zlSEpFaVBuYk5xGuxMbyOcNTeCiUna5hb96r3edkj0ZHIv8fgOGyXI2JPaa3QjWBvQw1HB8kS8XbByhwdq4Jit3VNVdCIgjd+YT8/8S0MSGyb+8Aj03r/NO2O9Lf0017x2Ebjv7oWFSpL+j0GlgYLzHZwnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRqiMKblGVjWhBGTJ7D8AwizLb4ml1C5nMMl66lFD7A=;
 b=JrHiDrkbYI4/8YWlWMwq/vF/o9LgXCR/KDa/limlVRfYTtAFdtmgRsyw6lN/7DCgy/hFTRmjA1utAgouxCbknT8saRv2qsaVGBszWYS5xjXNIbficq3izrf9iOGR40JxnY2LEW0PcLAuCa0tEj4iUz5FgTzQfQuAp7nbcdwhc74=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Mon, 31 Aug 2020 15:11:09 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 15:11:09 +0000
Subject: Re: [PATCH 3/7] drm/amdgpu: Block all job scheduling activity during
 DPC recovery
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-4-git-send-email-andrey.grodzovsky@amd.com>
 <3261236e-b13e-73ef-85e5-f7eabe5305b2@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <3c1daca9-41e8-a3ca-5731-503f242a1fb0@amd.com>
Date: Mon, 31 Aug 2020 11:11:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <3261236e-b13e-73ef-85e5-f7eabe5305b2@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR18CA0006.namprd18.prod.outlook.com
 (2603:10b6:404:121::16) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BN6PR18CA0006.namprd18.prod.outlook.com (2603:10b6:404:121::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 15:11:08 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:1802:46a:68a:71ca]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ec32c2e-7aa2-49ba-d1ac-08d84dc0175a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4137:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB41372E29C1F747DDA1A26F90EA510@DM6PR12MB4137.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRZffOusFm/DJ1oguyLb7X7ASCYnYSScrTQVp/nYwdBNr27Lty6Sh7V4Xh8FzqXgaNYcV1oyZ9MKjDfTK4H7Mr8yKtE8ta1O8Atz82ZP83eMXPpkmr9gmqF0X4mwYAOltySaWvbNeJCofSkaSJIF+t4n9uBxBW3wTALSIL6BdEw/xXh5xn5A+ytDAXXIawuFLEiaPZPwDMb3ySK6Xex2Y8viJedipnNty9U73qNMw0I54vNrwKhNN0gwcHW2DdgUt8aaRjLn1n46BJsSfoTNCtfG03+Q4nBj/lZfVxyQDT1kwexYT0orW8gl0ELj2Gh7taOTqasYpXkFh2TCn9if+JF6T3mly63b7K5QhOwfWFx5063dWGhzyXkOooVPpnAV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(316002)(478600001)(36756003)(2906002)(83380400001)(8936002)(16576012)(8676002)(5660300002)(53546011)(956004)(31686004)(52116002)(186003)(66476007)(66946007)(4326008)(86362001)(6486002)(66556008)(31696002)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: upgEXDQQGjP+Y2IdhvENsq5fxCUpDjFMqtes+pJX0Ob5Lj+mswlJMm4HY3blg1L2o9BNzBU/pWLd/Cux08QaIeb6N5j43BOTaZLT0spfsgkrNcYK4dKUt71T3Vq7tGw7C94Y5FSJOUUJQMi1H8SyEiab1ENoWQ1iHcQLowOd2/g60EEQa9PRMm45gHjggc+XHEBJIujrgV4KleRpLZ1pg6qVnlZMJpzyGDY4m0sexRz4dz1UyBQU+95YstSZSbVeJaTICPRFY9zDzOlXLwFmMaf9dhV1px/6kXTSMHyanQutf6lEh5+R9/6EQZ2XqyeuX9uQe6zsGKMCUzanovCV37L0S55n8Kwx1xEzOWhProEBQSgxKXcOt6WDmIx3k81GPHX8+OkFPz7fDv6lK2VdF5EIBh8yuHW/KnZNy5zG7aqvvZQoWsZEBrrmsC5NFyzVQhhDa7kmbFDwJc01c7T1x7EgIDci0ud07Tu09RzkIWikCL3WbJCM8dNc08GiI0OMq/cEjtZxFBQXKqZuFnPeg/p7sVkXA/hZuzOBUBgnnAYDrettcDr5jfwoEpazz4CStS8dKOksvPpyQrbfUiWteaee6kkLeO9oVfQqY8bxunTiR3wKqWkF+H+wC8I+Q1SediJ50HmpjoAtcSYgoy3SBaW0xi4AniD0z5rDrByFfHRVrKXzPmcPQFr+qiifbiw81UYoRV0EMvKw95mHiieOzA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec32c2e-7aa2-49ba-d1ac-08d84dc0175a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:11:09.5216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4bV7N+pmKaaeYuI5jl+qaJBplagOkGhtCylyd3e8gLOXTs6iEDbD1ZH9nwHDpp5E6o6kEdfTL8GBA9O4JK/og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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
Cc: alexander.deucher@amd.com, nirmodas@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDgvMjgvMjAgMTA6MTYgUE0sIEx1YmVuIFR1aWtvdiB3cm90ZToKPiBPbiAyMDIwLTA4LTI2
IDEwOjQ2LCBBbmRyZXkgR3JvZHpvdnNreSB3cm90ZToKPj4gRFBDIHJlY292ZXJ5IGludm9sdmVz
IEFTSUMgcmVzZXQganVzdCBhcyBub3JtYWwgR1BVIHJlY292ZXJ5IHNvIGJsb2NrCj4+IFNXIEdQ
VSBzaGNlZHVsZXJzIGFuZCB3YWl0IG9uIGFsbCBjb25jdXJlbnQgR1BVIHJlc2V0cy4KPj4KPj4g
U2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5j
b20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YyB8IDU3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQo+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCA1MyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4+IGluZGV4IGUxYmJlZmQuLjBhMjEzMGIgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPj4gQEAg
LTQ3NDcsNiArNDc0NywyMCBAQCBpbnQgYW1kZ3B1X2RldmljZV9iYWNvX2V4aXQoc3RydWN0IGRy
bV9kZXZpY2UgKmRldikKPj4gICAJcmV0dXJuIDA7Cj4+ICAgfQo+PiAgIAo+PiArc3RhdGljIHZv
aWQgYW1kZ3B1X2NhbmNlbF9hbGxfdGRyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+PiAr
ewo+PiArCWludCBpOwo+PiArCj4+ICsJZm9yIChpID0gMDsgaSA8IEFNREdQVV9NQVhfUklOR1M7
ICsraSkgewo+PiArCQlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSBhZGV2LT5yaW5nc1tpXTsK
Pj4gKwo+PiArCQlpZiAoIXJpbmcgfHwgIXJpbmctPnNjaGVkLnRocmVhZCkKPj4gKwkJCWNvbnRp
bnVlOwo+PiArCj4+ICsJCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmcmluZy0+c2NoZWQud29y
a190ZHIpOwo+PiArCX0KPj4gK30KPj4gKwo+PiAgIC8qKgo+PiAgICAqIGFtZGdwdV9wY2lfZXJy
b3JfZGV0ZWN0ZWQgLSBDYWxsZWQgd2hlbiBhIFBDSSBlcnJvciBpcyBkZXRlY3RlZC4KPj4gICAg
KiBAcGRldjogUENJIGRldmljZSBzdHJ1Y3QKPj4gQEAgLTQ3NjAsMTYgKzQ3NzQsMzggQEAgcGNp
X2Vyc19yZXN1bHRfdCBhbWRncHVfcGNpX2Vycm9yX2RldGVjdGVkKHN0cnVjdCBwY2lfZGV2ICpw
ZGV2LCBwY2lfY2hhbm5lbF9zdGEKPj4gICB7Cj4+ICAgCXN0cnVjdCBkcm1fZGV2aWNlICpkZXYg
PSBwY2lfZ2V0X2RydmRhdGEocGRldik7Cj4+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gZHJtX3RvX2FkZXYoZGV2KTsKPj4gKwlpbnQgaTsKPj4gICAKPj4gICAJRFJNX0lORk8oIlBD
SSBlcnJvcjogZGV0ZWN0ZWQgY2FsbGJhY2ssIHN0YXRlKCVkKSEhXG4iLCBzdGF0ZSk7Cj4+ICAg
Cj4+ICAgCXN3aXRjaCAoc3RhdGUpIHsKPj4gICAJY2FzZSBwY2lfY2hhbm5lbF9pb19ub3JtYWw6
Cj4+ICAgCQlyZXR1cm4gUENJX0VSU19SRVNVTFRfQ0FOX1JFQ09WRVI7Cj4+IC0JY2FzZSBwY2lf
Y2hhbm5lbF9pb19mcm96ZW46IHsKPj4gLQkJLyogRmF0YWwgZXJyb3IsIHByZXBhcmUgZm9yIHNs
b3QgcmVzZXQgKi8KPj4gKwljYXNlIHBjaV9jaGFubmVsX2lvX2Zyb3plbjogeyAvKiBGYXRhbCBl
cnJvciwgcHJlcGFyZSBmb3Igc2xvdCByZXNldCAqLwo+PiArCj4+ICsJCS8qCj4+ICsJCSAqIENh
bmNlbCBhbmQgd2FpdCBmb3IgYWxsIFREUnMgaW4gcHJvZ3Jlc3MgaWYgZmFpbGluZyB0bwo+PiAr
CQkgKiBzZXQgIGFkZXYtPmluX2dwdV9yZXNldCBpbiBhbWRncHVfZGV2aWNlX2xvY2tfYWRldgo+
PiArCQkgKgo+PiArCQkgKiBMb2NraW5nIGFkZXYtPnJlc2V0X3NlbSB3aWxsIHBlcmV2ZW50IGFu
eSBleHRlcm5hbCBhY2Nlc3MKPj4gKwkJICogdG8gR1BVIGR1cmluZyBQQ0kgZXJyb3IgcmVjb3Zl
cnkKPj4gKwkJICovCj4+ICsJCXdoaWxlICghYW1kZ3B1X2RldmljZV9sb2NrX2FkZXYoYWRldiwg
TlVMTCkpCj4+ICsJCQlhbWRncHVfY2FuY2VsX2FsbF90ZHIoYWRldik7Cj4gSXMgaXQgcG9zc2li
bGUgZm9yIHRoaXMgdG8gaGFuZyBmb3JldmVyPyBJdCBldmVudHVhbGx5Cj4gcmVzb2x2ZXMgdG8g
X19jYW5jZWxfd29ya190aW1lcigpIGluIGtlcm5lbC93b3JrcXVldWUuYwo+IHdoaWNoIHByb3Zp
ZGVzIG5vIHRpbWVvdXQuCj4KPiBJZiB5b3UgY2Fubm90IGd1YXJhbnRlZSB0aGUgVERScyB0byBy
ZXR1cm4gYmFjaywgdGhlbgo+IHlvdSdkIG5lZWQgYSB0aW1lb3V0IGhlcmUuCj4KPiBSZWdhcmRz
LAo+IEx1YmVuCgoKVW5sZXNzIHRoZXJlIGlzIGEgYnVnIGluIHRoZcKgIHJlc2V0IGNvZGUgKHN1
Y2ggYXMgZGVhZGxvY2tzIHdoaWNoIHRoZW4gc2hvdWxkIGJlIApmaXhlZCkKaXQgc2hvdWxkIHBy
b2dyZXNzIHRvIGNvbXBsZXRpb24gYW5kIHNvIEkgZG9uJ3Qgc2VlIGFuIGlzc3VlIGhlcmUuCgpB
bmRyZXkKCgo+Cj4+ICsKPj4gKwkJLyoKPj4gKwkJICogQmxvY2sgYW55IHdvcmsgc2NoZWR1bGlu
ZyBhcyB3ZSBkbyBmb3IgcmVndWFsciBHUFUgcmVzZXQKPj4gKwkJICogZm9yIHRoZSBkdXJhdGlv
biBvZiB0aGUgcmVjb3ZlcnlxCj4+ICsJCSAqLwo+PiArCQlmb3IgKGkgPSAwOyBpIDwgQU1ER1BV
X01BWF9SSU5HUzsgKytpKSB7Cj4+ICsJCQlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSBhZGV2
LT5yaW5nc1tpXTsKPj4gKwo+PiArCQkJaWYgKCFyaW5nIHx8ICFyaW5nLT5zY2hlZC50aHJlYWQp
Cj4+ICsJCQkJY29udGludWU7Cj4+ICsKPj4gKwkJCWRybV9zY2hlZF9zdG9wKCZyaW5nLT5zY2hl
ZCwgTlVMTCk7Cj4+ICsJCX0KPj4gICAKPj4gLQkJYW1kZ3B1X2RldmljZV9sb2NrX2FkZXYoYWRl
dik7Cj4+ICAgCQlyZXR1cm4gUENJX0VSU19SRVNVTFRfTkVFRF9SRVNFVDsKPj4gICAJfQo+PiAg
IAljYXNlIHBjaV9jaGFubmVsX2lvX3Blcm1fZmFpbHVyZToKPj4gQEAgLTQ5MDIsOCArNDkzOCwy
MSBAQCB2b2lkIGFtZGdwdV9wY2lfcmVzdW1lKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQo+PiAgIHsK
Pj4gICAJc3RydWN0IGRybV9kZXZpY2UgKmRldiA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsKPj4g
ICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBkcm1fdG9fYWRldihkZXYpOwo+PiArCWlu
dCBpOwo+PiAgIAo+PiAtCWFtZGdwdV9kZXZpY2VfdW5sb2NrX2FkZXYoYWRldik7Cj4+ICAgCj4+
ICAgCURSTV9JTkZPKCJQQ0kgZXJyb3I6IHJlc3VtZSBjYWxsYmFjayEhXG4iKTsKPj4gKwo+PiAr
CWZvciAoaSA9IDA7IGkgPCBBTURHUFVfTUFYX1JJTkdTOyArK2kpIHsKPj4gKwkJc3RydWN0IGFt
ZGdwdV9yaW5nICpyaW5nID0gYWRldi0+cmluZ3NbaV07Cj4+ICsKPj4gKwkJaWYgKCFyaW5nIHx8
ICFyaW5nLT5zY2hlZC50aHJlYWQpCj4+ICsJCQljb250aW51ZTsKPj4gKwo+PiArCj4+ICsJCWRy
bV9zY2hlZF9yZXN1Ym1pdF9qb2JzKCZyaW5nLT5zY2hlZCk7Cj4+ICsJCWRybV9zY2hlZF9zdGFy
dCgmcmluZy0+c2NoZWQsIHRydWUpOwo+PiArCX0KPj4gKwo+PiArCWFtZGdwdV9kZXZpY2VfdW5s
b2NrX2FkZXYoYWRldik7Cj4+ICAgfQo+PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
