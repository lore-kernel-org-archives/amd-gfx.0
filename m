Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5745BC388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 18:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE117247FF
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 18:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cAe48+Za"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE117247FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E63846E051;
	Wed, 28 Oct 2020 18:08:59 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750074.outbound.protection.outlook.com [40.107.75.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92ED96E2C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 18:08:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBoSKedbLazsCGgWPoItBq4og+pmb4SnPJZvu6mHdSQO6G/FJNv513EpDIzF/d2G/gXRDSm1sGDN2TgXXJ75mwKpFV46H0U9J6TM2xvNFrmRXG694tnhNoPXOzY7XvU6Pjuk3mbr0fMibkj5m6uG8N4cDVHCWdyw6Y7bIfBLOVHD80akilzHT16DCH0U9qbFxYrSHth3DTCTRjPpw41uljpUIX/n5h0AjGra+NTzWz5aULyisrr4QOgGfg4A09//inA4hppzNereA7xjw01ndK2aZfYcsUS9GdlW+Y/N3ewQ0sU/lFwg0L67TkTQBQpET5i8mNyDurAEfBfZPjj0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbkBf7MkENTZNSCoUcN3+eO5rFxw2IojvirkOqiPt7c=;
 b=O7XIE2XqfGLTvs1ECM9NZu5DFCIEn3vxtNhINr40xitEXajh4c/TbZb87KmaJ3XsjK+fil/UR1MzJJZDmxVwu26X6qXO9T3kbfjYsS0T4+MROsDvkitmBy+Yo2dxwAe0zqLV8XGrJBaLV4qtf+7lbDvutUESz5w/7Rp7/jngpop/LZIrgzdDiN4Rstn2LmzSPYkMsAGn5sFUXXhvdbvQvEDdXRBBnrwZfjcWbLq036+2I0k+2MTLAsBrCi2L6SBTZmsmKF/TOZ5taj5sfokiE7U5OB2qSdk7A0X3pF60QAwNnUhy2kWTTTCiFw+znA+uKw2FYoAwuGUMx9UlKdcZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbkBf7MkENTZNSCoUcN3+eO5rFxw2IojvirkOqiPt7c=;
 b=cAe48+ZaAbTEl7tToTGE4TLpZHe52F2zBxdg6oe6hAc2e3dxnWjxpEHyy2eXKTd4oFNI3wUGRftS8qsw9DBkTmJ6bWwkANDR18tRQaJ34GfRuB8qow3m6Q2J6liGwGl4B7YWsu7wPrM2m/N+xwuHkHl3DgHl8FCMnGhwf7lU/m4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN6PR12MB2829.namprd12.prod.outlook.com (2603:10b6:805:e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 28 Oct
 2020 18:08:56 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d436:e21c:e4e8:7deb]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d436:e21c:e4e8:7deb%5]) with mapi id 15.20.3499.019; Wed, 28 Oct 2020
 18:08:56 +0000
Subject: Re: [PATCH] drm/amdgpu: Add kernel parameter to force no xgmi
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20201028145502.2703-1-alex.sierra@amd.com>
 <7d27dd5f-e178-188a-6537-6b4d6d31b205@gmail.com>
From: "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>
Message-ID: <4306b2ef-736c-57a3-4110-6fb953fb76d4@amd.com>
Date: Wed, 28 Oct 2020 13:08:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <7d27dd5f-e178-188a-6537-6b4d6d31b205@gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: DM5PR07CA0138.namprd07.prod.outlook.com
 (2603:10b6:3:13e::28) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.8.180] (165.204.77.11) by
 DM5PR07CA0138.namprd07.prod.outlook.com (2603:10b6:3:13e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 18:08:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f6e56ab9-2203-4faf-2a9b-08d87b6c8907
X-MS-TrafficTypeDiagnostic: SN6PR12MB2829:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28299599F96D150717ADC8BFFD170@SN6PR12MB2829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKmZFB2OYSrAfBeEhoJ4AFLz031MkTPLsYk6evHHjH0mKQZHPapZdBcsyUnuCMaaJgz6ih4AcFK1sKS19nY369JfEXrcLsM1O/QFUlreMbhyIS2PAsZBTR2UEhPw0vCbKYH1CLEBj5W9mz748eaWMc9lFbLGxlxhFJPHT5ZsveCkZJuKiLBzrXFk89FpblXIZebkJTYKnBio6/SlNRbupcosW9KzR2LMUyyuLJvYlwtnaD6X3ljFDn8RDYToa86SSbOIPqyTk2ANksSkCctX+Fml18fBQDFhM/TGsQu4F44YK4tcy3Rh5nwvOPpBuvJYkqf9b5YmbmpL+oPXewb8QQLL8unEdEiYolwZCGrgSmaUmFy/OAeZao2AVf3jz8Wo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(86362001)(66476007)(36756003)(16576012)(8676002)(26005)(16526019)(5660300002)(316002)(53546011)(6486002)(186003)(52116002)(2906002)(66556008)(66946007)(478600001)(31696002)(83380400001)(66574015)(8936002)(6666004)(31686004)(2616005)(956004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TdCXYBXRyY2XUJy6AATTo/fnGJOAljW/Ue9l3Wik24U3Gy69L2S/vcW9u9jrH/7X9wxL/hyDy2OcAqzl1bRL2iGEkZXhdGKt4scm00bfel6Tae3shx1g7HleP/Rp5gxs/H2PU7SVh2K9rLGTllEBPaPKo3xQG5iQzO2puoPXfZG6y2ROXR9GwvO8pJHYp/lVmYH/ibqsx3TxAUbex+WP4aPoaMv8RguTdt2KEdR24jxPr/ZtHShEdVVXImSuRbWtYu7xhhZ2cMkB5njg9UoTMDPErPlIOLz0Q+Gi5OeqAuF+smofjBwc1spmD2Q9Vi+KZ/XZNthogwcL3fcgIbaUi1C2XtkS/VXTcPthF2SDgR7NzV7V6jJcGbDe64kXQaz77HpXGO6fnHbtLR1KwRH1/SWRs53PO5StwEOhQqVE2qrKzu1vIo0vozdM71gKFwRx7ZsQ0qAFH7cqgRx2BkuEHq4WoIsGpvsJQWwKyybz7v6iHRtTVS8djYiQt9SYTojZQGv6m6cR8Ri1m7IswtptG/4Rrfryx9/CXzlh1JbzHt/aVuBZCCVop4UrH+SzeSm9LONNsGU2UH/pJQWt/Akf6lLgQME+S26vHv9R5N1YL6JzFC0pIAp7do+j12bJaZDSecTtk2FMXvh+MT6/pSDYtA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e56ab9-2203-4faf-2a9b-08d87b6c8907
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 18:08:55.9463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEonT0y5uGVx8FDd2TTU2n7G2j7Tq37NAi8a8y+1sBGRMJcEYp/VnvPH9QuhvxeGRaPXJqwWBJgn6N3yguqRZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2829
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDEwLzI4LzIwMjAgOTo1OCBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyOC4x
MC4yMCB1bSAxNTo1NSBzY2hyaWViIEFsZXggU2llcnJhOgo+PiBCeSBlbmFibGluZyB0aGlzIHBh
cmFtZXRlciwgdGhlIHN5c3RlbSB3aWxsIGJlIGZvcmNlZCB0byB1c2UgcGNpZQo+PiBpbnRlcmZh
Y2Ugb25seSBmb3IgcDJwIHRyYW5zYWN0aW9ucy4KPgo+IEJldHRlciBuYW1lIHRoYXQgYW1kZ3B1
X3hnbWkgd2l0aCBhIGRlZmF1bHQgdmFsdWUgb2YgZW5hYmxlZC4KPgo+IE9yIG1heWJlIGFkZCBh
bm90aGVyIGJpdCB2YWx1ZSBmb3IgYW1kZ3B1X3ZtX2RlYnVnIGluc3RlYWQuCgpBY2sKClJlZ2Fy
ZHMsCkFsZXggU2llcnJhCgo+Cj4KPj4KPj4gU2lnbmVkLW9mZi1ieTogQWxleCBTaWVycmEgPGFs
ZXguc2llcnJhQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHUuaMKgwqDCoMKgwqDCoMKgIHwgMSArCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDIgKy0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Rydi5jwqDCoMKgIHwgOSArKysrKysrKysKPj4gwqAgMyBmaWxlcyBjaGFu
Z2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCAKPj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHUuaAo+PiBpbmRleCBiYTY1ZDRmMmFiNjcuLjM2NDVmMDBlOWY2MSAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKPj4gQEAgLTE4OCw2ICsxODgs
NyBAQCBleHRlcm4gaW50IGFtZGdwdV9kaXNjb3Zlcnk7Cj4+IMKgIGV4dGVybiBpbnQgYW1kZ3B1
X21lczsKPj4gwqAgZXh0ZXJuIGludCBhbWRncHVfbm9yZXRyeTsKPj4gwqAgZXh0ZXJuIGludCBh
bWRncHVfZm9yY2VfYXNpY190eXBlOwo+PiArZXh0ZXJuIGludCBhbWRncHVfZm9yY2Vfbm9feGdt
aTsKPj4gwqAgI2lmZGVmIENPTkZJR19IU0FfQU1ECj4+IMKgIGV4dGVybiBpbnQgc2NoZWRfcG9s
aWN5Owo+PiDCoCBleHRlcm4gYm9vbCBkZWJ1Z19ldmljdGlvbnM7Cj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgCj4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4+IGluZGV4IDFmZTg1MGUwYTk0ZC4u
MGE1ZDk3YTg0MDE3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jCj4+IEBAIC0yMjU3LDcgKzIyNTcsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZp
Y2VfaXBfaW5pdChzdHJ1Y3QgCj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+IMKgwqDCoMKgwqAg
aWYgKHIpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGluaXRfZmFpbGVkOwo+PiDCoCAtwqDC
oMKgIGlmIChhZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMgPiAxKQo+PiArwqDCoMKg
IGlmICghYW1kZ3B1X2ZvcmNlX25vX3hnbWkgJiYgYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2Fs
X25vZGVzID4gMSkKPgo+IE1obSwgdGhpcyB3aWxsIG1vc3QgbGlrZWx5IGNhdXNlIHByb2JsZW1z
LiBZb3Ugc3RpbGwgbmVlZCB0byBhZGQgdGhlIAo+IGRldmljZSB0byB0aGUgaGl2ZSBiZWNhdXNl
IG90aGVyd2lzZSBHUFUgd29uJ3Qgd29yay4KCldoYXQga2luZCBvZiBwcm9ibGVtcz8gU28gZmFy
LCBJIGhhdmUgdmFsaWRhdGVkIHRoaXMgdXNpbmcgYSBzeXN0ZW0gd2l0aCAKbXVsdGlwbGUgZGV2
aWNlcyBhbmQgcnVubmluZyAuL3JvY21fYmFuZHdpZHRoX3Rlc3QgLXQuIFdpdGggYW5kIHdpdGhv
dXQgCnRoZSBwYXJhbWV0ZXIgc2V0LgoKUmVnYXJkcywKQWxleCBTaWVycmEKCj4KPiBBcGFydCBm
cm9tIHRoYXQgc291bmRzIGxpa2UgYSBnb29kIGlkZWEgaW4gZ2VuZXJhbC4KPgo+IENocmlzdGlh
bi4KPgo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X3hnbWlfYWRkX2RldmljZShhZGV2KTsK
Pj4gwqDCoMKgwqDCoCBhbWRncHVfYW1ka2ZkX2RldmljZV9pbml0KGFkZXYpOwo+PiDCoCBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIAo+PiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+PiBpbmRleCA0Yjc4ZWNmZDM1
ZjcuLjIyNDg1MDY3Y2YzMSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rydi5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kcnYuYwo+PiBAQCAtMTYwLDYgKzE2MCw3IEBAIGludCBhbWRncHVfZm9yY2VfYXNpY190eXBl
ID0gLTE7Cj4+IMKgIGludCBhbWRncHVfdG16ID0gMDsKPj4gwqAgaW50IGFtZGdwdV9yZXNldF9t
ZXRob2QgPSAtMTsgLyogYXV0byAqLwo+PiDCoCBpbnQgYW1kZ3B1X251bV9rY3EgPSAtMTsKPj4g
K2ludCBhbWRncHVfZm9yY2Vfbm9feGdtaSA9IDA7Cj4+IMKgIMKgIHN0cnVjdCBhbWRncHVfbWdw
dV9pbmZvIG1ncHVfaW5mbyA9IHsKPj4gwqDCoMKgwqDCoCAubXV0ZXggPSBfX01VVEVYX0lOSVRJ
QUxJWkVSKG1ncHVfaW5mby5tdXRleCksCj4+IEBAIC01MjIsNiArNTIzLDE0IEBAIG1vZHVsZV9w
YXJhbV9uYW1lZChyYXNfZW5hYmxlLCAKPj4gYW1kZ3B1X3Jhc19lbmFibGUsIGludCwgMDQ0NCk7
Cj4+IMKgIE1PRFVMRV9QQVJNX0RFU0MocmFzX21hc2ssICJNYXNrIG9mIFJBUyBmZWF0dXJlcyB0
byBlbmFibGUgKGRlZmF1bHQgCj4+IDB4ZmZmZmZmZmYpLCBvbmx5IHZhbGlkIHdoZW4gcmFzX2Vu
YWJsZSA9PSAxIik7Cj4+IMKgIG1vZHVsZV9wYXJhbV9uYW1lZChyYXNfbWFzaywgYW1kZ3B1X3Jh
c19tYXNrLCB1aW50LCAwNDQ0KTsKPj4gwqAgKy8qKgo+PiArICogRE9DOiBmb3JjZV9ub194Z21p
ICh1aW50KQo+PiArICogRm9yY2VzIG5vdCB0byB1c2UgeGdtaSBpbnRlcmZhY2UgKDAgPSBkaXNh
YmxlLCAxID0gZW5hYmxlKS4KPj4gKyAqIERlZmF1bHQgaXMgMCAoZGlzYWJsZWQpLgo+PiArICov
Cj4+ICtNT0RVTEVfUEFSTV9ERVNDKGZvcmNlX25vX3hnbWksICJGb3JjZSBub3QgdG8gdXNlIHhn
bWkgaW50ZXJmYWNlIik7Cj4+ICttb2R1bGVfcGFyYW1fbmFtZWQoZm9yY2Vfbm9feGdtaSwgYW1k
Z3B1X2ZvcmNlX25vX3hnbWksIGludCwgMDYwMCk7Cj4+ICsKPj4gwqAgLyoqCj4+IMKgwqAgKiBE
T0M6IHNpX3N1cHBvcnQgKGludCkKPj4gwqDCoCAqIFNldCBTSSBzdXBwb3J0IGRyaXZlci4gVGhp
cyBwYXJhbWV0ZXIgd29ya3MgYWZ0ZXIgc2V0IGNvbmZpZyAKPj4gQ09ORklHX0RSTV9BTURHUFVf
U0kuIEZvciBTSSBhc2ljLCB3aGVuIHJhZGVvbiBkcml2ZXIgaXMgZW5hYmxlZCwKPgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
