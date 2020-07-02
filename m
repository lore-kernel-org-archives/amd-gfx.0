Return-Path: <SRS0=uuOW=AN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C318DC433E1
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 08:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DD22084C
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 08:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kr/wIE18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DD22084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58DFF89B61;
	Thu,  2 Jul 2020 08:39:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2022589B61
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2020 08:39:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnKJYgzy/mV98SixZLf7euG/8+MrC40EmhuPVIOiJC8iB+0BhWWGNx3TaIC8+SKlHTfRHOK/xpYFFprJwxLK3zHtI+ZFo1/KjOI3Kdopyr4ZY0OhOF7qWJRLncYY5QEoHCMEgvvcVWDrjri3Mxxv7yqP+inlJ7Z2DHu1HCkMlsVcFpjE0lqmPDoAMscQN2iNZwZQWmDUL/LakEQOZAuXYyAOMhvNteiR7Pw7SdI77qlSyalkaU3dUQisjXn3hZWBDS18nRzJXdCwQUpT5n10spHXwafF4AfUEVDavqUPoLYmcS9wiHKDUdva3mVa79KVBy0RgfLhD/uBpYfuNRfFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PasxLQoyH2QT9ekzgjo7YSu56aRPm4Zxf1lQkmX8GVs=;
 b=lADq7/tbChlf1pJ4QJLOsUMRoonPDPg+tawafbGZ1tfGsq8Knyfx0y+3ie/M/UC2cvLPgQsNA8PkbiRbZw/lgJNRC9SSxrV/h6t+VGK839ENPNiqhR4iyNfRSbh/KjfY22nrjuftAk5U4nWdvs0R4FYcD9T1XIsvtrJS7G4h1keFJyz5lwh3Uvca/ojeO2Xs4s/D/mO/o0E1ZW6niUrcctEjzRPnT62YyvC7EtmL4CYqQ897BsEXbMb9oHPys+RDlHRjzTcSOVxEoLtac9srG91P63ktFLZucBb887E5RSxK1/ZIl1M29cjoNqSKHERBb06akhOsj8blu16FZKscWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PasxLQoyH2QT9ekzgjo7YSu56aRPm4Zxf1lQkmX8GVs=;
 b=Kr/wIE18fjDBe5bFUdrd6tLMf+TDIylLTfhAfamIw7oX+Zt/7V9aIiztn/MpIgljbpP0tgk9n0/D3EgySY+9giuMWc2j11BpiK7YVsgs7jscaLt7k74ika7hy5QcbZ8ItOMLcwIyl/tsSOvWVhwNtnH9ZeDWsWhgA+TxPmdrFuY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 08:39:07 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3153.021; Thu, 2 Jul 2020
 08:39:07 +0000
Subject: Re: [PATCH v2] gpu/drm: Remove debug info about CPU address
To: Tiezhu Yang <yangtiezhu@loongson.cn>, alexander.deucher@amd.com
References: <1593656863-1894-1-git-send-email-yangtiezhu@loongson.cn>
 <85c81fa9-2994-d861-0690-a79600ed84b3@amd.com>
 <af4f9870-3161-87f7-ff4f-1c0ad7869717@loongson.cn>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7aa4d0c5-14ba-594d-e3fb-9acba82cf45d@amd.com>
Date: Thu, 2 Jul 2020 10:39:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <af4f9870-3161-87f7-ff4f-1c0ad7869717@loongson.cn>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0057.eurprd07.prod.outlook.com
 (2603:10a6:207:4::15) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0057.eurprd07.prod.outlook.com (2603:10a6:207:4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.12 via Frontend Transport; Thu, 2 Jul 2020 08:39:06 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c658345-8eb2-434e-4a85-08d81e636206
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41269BCF4CA49DC22C96F4D8836D0@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kP/c3i6EMQJWY2ovu8Uoxvw/15wlJ2JMILyV8d8NNPzDEoTdGOf3mBn7+iJCmUGwitiyKyFfuWGyWA6FJoiSvia0ftPud1dTm8co+4lEP441XLYn0+BOiF24bSuq24x4X6Ez7TAkJI3LQyUWpN6GsbvqdrNGxnsPqRsstLtQieyQNgQXtYFBeLgjb7ZeAv1+6XUsbqomuN9NYR5o0JQuOnNRqEs1BxZ759V3GIyn1iXmpcXln9U806T/NL25PfMdyD1cRdEC0SqH7PG2iRz1H3E4pID78r6z1y+EZC0yV/TGlefrXy+1OWiWPVPqWoxv4JxqcITBKhTKIBL9Cl/X3T700eTirDitcQaQrYcG5m0UdCaQQDHzcS6shs/XMth0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(31686004)(36756003)(66574015)(2616005)(316002)(6666004)(4326008)(8936002)(83380400001)(52116002)(8676002)(53546011)(6486002)(6636002)(2906002)(31696002)(16526019)(186003)(478600001)(66946007)(66556008)(66476007)(86362001)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xzROn6ZyzO1fthFk2i+be9Ss7TEYa/sTaPztLEWhZGtHAUSWt1bfRtXM2rKIwESt8DWfZgjSOLBJnKbAUeoM09ecwkzdtA8wXi0On72q9a4OUY1JcLFkiIOpTloszy4YjoWjmajMGkBOB1x4LPOn6aKPyqD01rslJRz60gPFqe23AkcKpbcQ0fF8T9XuxUutho246uFP1ZnROJ04iVBDqvYWpDrFzlba9X0qcuQZycbhC5OekZiLKz5cqJ3u+wVVN0xVBy/Xc6pWQWCZHB3RfXXG8ZXynKgozGjzGku7XRO6D289iAVgA0/Um6fA37VH0XXhb6uN+TEh7HnbUELTnn3R8pefUkNcaj0C6aTPfRTTG5Q55YfKkstG6J/UiFCIRPZv8E8D70GYGHm9j/hf7l6x4LIvbr+G5JtD+0H8eBv2MkNIxiaWC8sStJts1+z4YU3ElorbwI0GeL6Murumaf0SMiEWPBCmrV6SCFUxc8zwm3Z72cfspbG8vnaYHQRaXsoCnTkvq3zcVv+g4jKc5F9YXOhF9WtxlgNRAI4E8VykxMc7kjwylgui68G0X6Bt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c658345-8eb2-434e-4a85-08d81e636206
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 08:39:06.9679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pE2EzDgpg/9bWT596zdQVOGPRZvjB8RR4sXbJmG6vjHFM23q9qca4e43JOC7zKfe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMDcuMjAgdW0gMTA6MzUgc2NocmllYiBUaWV6aHUgWWFuZzoKPiBPbiAwNy8wMi8yMDIw
IDA0OjI3IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAwMi4wNy4yMCB1bSAwNDoy
NyBzY2hyaWViIFRpZXpodSBZYW5nOgo+Pj4gV2hlbiBJIHVwZGF0ZSB0aGUgbGF0ZXN0IGtlcm5l
bCwgSSBzZWUgdGhlIGZvbGxvd2luZyAKPj4+ICJfX19fcHRydmFsX19fXyIgYm9vdAo+Pj4gbWVz
c2FnZXMuCj4+Pgo+Pj4gW8KgwqDCoCAxLjg3MjYwMF0gcmFkZW9uIDAwMDA6MDE6MDUuMDogZmVu
Y2UgZHJpdmVyIG9uIHJpbmcgMCB1c2UgZ3B1IAo+Pj4gYWRkciAweDAwMDAwMDAwNDgwMDBjMDAg
YW5kIGNwdSBhZGRyIDB4KF9fX19wdHJ2YWxfX19fKQo+Pj4gW8KgwqDCoCAxLjg3OTA5NV0gcmFk
ZW9uIDAwMDA6MDE6MDUuMDogZmVuY2UgZHJpdmVyIG9uIHJpbmcgNSB1c2UgZ3B1IAo+Pj4gYWRk
ciAweDAwMDAwMDAwNDAwNTYwMzggYW5kIGNwdSBhZGRyIDB4KF9fX19wdHJ2YWxfX19fKQo+Pj4K
Pj4+IEJvdGggcmFkZW9uX2ZlbmNlX2RyaXZlcl9zdGFydF9yaW5nKCkgYW5kIAo+Pj4gYW1kZ3B1
X2ZlbmNlX2RyaXZlcl9zdGFydF9yaW5nKCkKPj4+IGhhdmUgdGhlIHNpbWlsYXIgaXNzdWUsIHRo
ZXJlIGV4aXN0cyB0aGUgZm9sbG93aW5nIHR3byBtZXRob2RzIHRvIAo+Pj4gc29sdmUgaXQ6Cj4+
PiAoMSkgVXNlICIlcEsiIGluc3RlYWQgb2YgIiVwIiBzbyB0aGF0IHRoZSBDUFUgYWRkcmVzcyBj
YW4gYmUgcHJpbnRlZCAKPj4+IHdoZW4KPj4+IHRoZSBrcHRyX3Jlc3RyaWN0IHN5c2N0bCBpcyBz
ZXQgdG8gMS4KPj4+ICgyKSBKdXN0IGNvbXBsZXRlbHkgZHJvcCB0aGUgQ1BVIGFkZHJlc3Mgc3Vn
Z2VzdGVkIGJ5IENocmlzdGlhbiwgCj4+PiBiZWNhdXNlCj4+PiB0aGUgQ1BVIGFkZHJlc3Mgd2Fz
IHVzZWZ1bCBpbiB0aGUgcGFzdCwgYnV0IGlzbid0IGFueSBtb3JlLiBXZSBub3cgCj4+PiBoYXZl
IGEKPj4+IGRlYnVnZnMgZmlsZSB0byByZWFkIHRoZSBjdXJyZW50IGZlbmNlIHZhbHVlcy4KPj4+
Cj4+PiBTaW5jZSB0aGUgQ1BVIGFkZHJlc3MgaXMgbm90IG11Y2ggdXNlZnVsLCBqdXN0IHJlbW92
ZSB0aGUgZGVidWcgaW5mbyAKPj4+IGFib3V0Cj4+PiBDUFUgYWRkcmVzcy4KPj4+Cj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBUaWV6aHUgWWFuZyA8eWFuZ3RpZXpodUBsb29uZ3Nvbi5jbj4KPj4KPj4gU3Bs
aXR0aW5nIGl0IGludG8gb25lIHBhdGNoIGZvciByYWRlb24gYW5kIG9uZSBmb3IgYW1kZ3B1IG1p
Z2h0IGJlIAo+PiBuaWNlIHRvIGhhdmUuCj4KPiBTaG91bGQgSSBzcGxpdCB0aGlzIHBhdGNoIGlu
dG8gdHdvIHBhdGNoZXMgYW5kIHRoZW4gc2VuZCB2Mz8KPiBJZiB5ZXMsIEkgd2lsbCBkbyBpdCBz
b29uLgoKRm9yIG1lIGl0J3Mgb2sgdG8gbWVyZ2UgaXQgbGlrZSBpdCBpcyBub3cuCgpPbmx5IEFs
ZXggY291bGQgaW5zaXN0cyB0byBzcGxpdCB0aGUgcGF0Y2hlcywgYnV0IHRoZW4gaGUgd2lsbCBw
cm9iYWJseSAKZG8gaXQgaGltc2VsZi4KClRoYW5rcyBmb3IgdGhlIGhlbHAsCkNocmlzdGlhbi4K
Cj4KPj4KPj4gQnV0IGVpdGhlciB3YXkgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgCj4+
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGZvciB0aGUgcGF0Y2guCj4+Cj4+IFRoYW5rcywK
Pj4gQ2hyaXN0aWFuLgo+Pgo+Pj4gLS0tCj4+Pgo+Pj4gdjI6Cj4+PiDCoMKgIC0gSnVzdCByZW1v
dmUgdGhlIGRlYnVnIGluZm8gYWJvdXQgQ1BVIGFkZHJlc3Mgc3VnZ2VzdGVkIGJ5IAo+Pj4gQ2hy
aXN0aWFuCj4+PiDCoMKgIC0gTW9kaWZ5IHRoZSBwYXRjaCBzdWJqZWN0IGFuZCB1cGRhdGUgdGhl
IGNvbW1pdCBtZXNzYWdlCj4+Pgo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2ZlbmNlLmMgfCA1ICsrLS0tCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9mZW5jZS5jwqDCoMKgwqAgfCA0ICsrLS0KPj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPj4+IGluZGV4IGQ4NzhmZTcuLmEyOWYyZjkgMTAwNjQ0
Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYwo+Pj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPj4+IEBAIC00
MjIsOSArNDIyLDggQEAgaW50IGFtZGdwdV9mZW5jZV9kcml2ZXJfc3RhcnRfcmluZyhzdHJ1Y3Qg
Cj4+PiBhbWRncHVfcmluZyAqcmluZywKPj4+IMKgwqDCoMKgwqAgcmluZy0+ZmVuY2VfZHJ2Lmly
cV90eXBlID0gaXJxX3R5cGU7Cj4+PiDCoMKgwqDCoMKgIHJpbmctPmZlbmNlX2Rydi5pbml0aWFs
aXplZCA9IHRydWU7Cj4+PiDCoCAtwqDCoMKgIERSTV9ERVZfREVCVUcoYWRldi0+ZGV2LCAiZmVu
Y2UgZHJpdmVyIG9uIHJpbmcgJXMgdXNlIGdwdSBhZGRyICIKPj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAiMHglMDE2bGx4LCBjcHUgYWRkciAweCVwXG4iLCByaW5nLT5uYW1lLAo+Pj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJpbmctPmZlbmNlX2Rydi5ncHVfYWRkciwgcmlu
Zy0+ZmVuY2VfZHJ2LmNwdV9hZGRyKTsKPj4+ICvCoMKgwqAgRFJNX0RFVl9ERUJVRyhhZGV2LT5k
ZXYsICJmZW5jZSBkcml2ZXIgb24gcmluZyAlcyB1c2UgZ3B1IGFkZHIgCj4+PiAweCUwMTZsbHhc
biIsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmluZy0+bmFtZSwgcmluZy0+ZmVu
Y2VfZHJ2LmdwdV9hZGRyKTsKPj4+IMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+PiDCoCB9Cj4+PiDC
oCBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZmVuY2UuYyAKPj4+
IGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZmVuY2UuYwo+Pj4gaW5kZXggNDNmMmY5
My4uODczNWJmMiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9u
X2ZlbmNlLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ZlbmNlLmMK
Pj4+IEBAIC04NjUsOCArODY1LDggQEAgaW50IHJhZGVvbl9mZW5jZV9kcml2ZXJfc3RhcnRfcmlu
ZyhzdHJ1Y3QgCj4+PiByYWRlb25fZGV2aWNlICpyZGV2LCBpbnQgcmluZykKPj4+IMKgwqDCoMKg
wqAgfQo+Pj4gwqDCoMKgwqDCoCByYWRlb25fZmVuY2Vfd3JpdGUocmRldiwgCj4+PiBhdG9taWM2
NF9yZWFkKCZyZGV2LT5mZW5jZV9kcnZbcmluZ10ubGFzdF9zZXEpLCByaW5nKTsKPj4+IMKgwqDC
oMKgwqAgcmRldi0+ZmVuY2VfZHJ2W3JpbmddLmluaXRpYWxpemVkID0gdHJ1ZTsKPj4+IC3CoMKg
wqAgZGV2X2luZm8ocmRldi0+ZGV2LCAiZmVuY2UgZHJpdmVyIG9uIHJpbmcgJWQgdXNlIGdwdSBh
ZGRyIAo+Pj4gMHglMDE2bGx4IGFuZCBjcHUgYWRkciAweCVwXG4iLAo+Pj4gLcKgwqDCoMKgwqDC
oMKgwqAgcmluZywgcmRldi0+ZmVuY2VfZHJ2W3JpbmddLmdwdV9hZGRyLCAKPj4+IHJkZXYtPmZl
bmNlX2RydltyaW5nXS5jcHVfYWRkcik7Cj4+PiArwqDCoMKgIGRldl9pbmZvKHJkZXYtPmRldiwg
ImZlbmNlIGRyaXZlciBvbiByaW5nICVkIHVzZSBncHUgYWRkciAKPj4+IDB4JTAxNmxseFxuIiwK
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgIHJpbmcsIHJkZXYtPmZlbmNlX2RydltyaW5nXS5ncHVfYWRk
cik7Cj4+PiDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4gwqAgfQo+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
