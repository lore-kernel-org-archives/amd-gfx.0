Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE5EC33CAF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 02:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851A52072B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 02:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FECGnilL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851A52072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44CEA6F379;
	Fri, 17 Jan 2020 02:01:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17DDE6F379
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 02:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ5dAMzKg1eAk+z+hyBO1IfCXARP5qBJi1J5u5GLr1YVzAk+kabGrbLqnzMiRWsEMVnBOMSMPD/ZBBhU4yVXZ3VeWJ6mPWnDxMq33pFSWDxftWVJ9r644OcFdgjq6kt/DdI7VlFQSRkn81+Q4GI3j/eLwK/To+gCmJBlPGVmkGZ/9ae94kG+0PdmjvDLP5joM2y0Bci+cxBB5t33n0Gz8xua04PmRPJfHFp59g/mzIBNU6KW4+0QDpRDyfc492WvNw8xfDVagh8leZmSeX99dmNxssjTvxlRz32XI4OXuS3VssOjyPuQsndpyERheLImxBCUc+/rc0QVTo9+OGK0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA1g92kB+2x/09ARmnoSv8FYt/z2SuaNcvKlcMFg2fw=;
 b=daJZOXIGoygWfbeUSp5WsEBWTfgYY7ythMgDuo6khTnv0UA44xjhkxdZciSrv1aapLmQQaYuTvIz6Oy638EmA/zbdeEcmo8NQPtTHp25iULZQvoPRoh1xM3C71ltEdWVko5c1MermXXBkJbu6exBgG5OouhaEndhFAF7wq80JNxR1gVUdJDrqAk4Qak4HIA8dtp89Ci1QDzup7osri9hPNALuQDgrH6D7ZKbNlNYr4RFqBVu8PPWrBDxnUZInsfuA5LQPiASqhhn4LI+5/0koRvDf7xHX1FAg1ZqtwyuIr9l0Y/zoyD1G/pjxrWRukHWL73OoMTtRTEhZiloz1FhUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA1g92kB+2x/09ARmnoSv8FYt/z2SuaNcvKlcMFg2fw=;
 b=FECGnilL6DR5ZeeQXe8akiHpZb9zE0i45Sk9leu4Ui97+l7nb982wq32UYrnc6yzd1483S6e5lILLadD3mUxvrsIFR+Q2pATnULio+yC5juhPpTLBEfbn1JwZAENpPbqvJj88frtJXZLy9sktuPIze/fCJ9X/wuIdbuKSZoPcBQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0236.namprd12.prod.outlook.com (10.174.107.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Fri, 17 Jan 2020 02:01:10 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2644.021; Fri, 17 Jan 2020
 02:01:09 +0000
Subject: Re: [PATCH] drm/amdgpu: add coreboot workaround for KV/KB
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 fredrik.bruhn@unibap.com, amd-gfx@lists.freedesktop.org
References: <20200116130907.22410-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <c5aa1227-adc0-f7d0-1786-deec7ca681c1@amd.com>
Date: Thu, 16 Jan 2020 21:01:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20200116130907.22410-1-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::24) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.31.19.228] (165.204.54.211) by
 YTOPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Fri, 17 Jan 2020 02:01:07 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6216c360-b62a-4c5b-11dc-08d79af11e2f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0236:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0236B71BADDDE6006648A18992310@DM5PR1201MB0236.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-Forefront-PRVS: 0285201563
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(8936002)(81166006)(81156014)(8676002)(5660300002)(44832011)(31696002)(86362001)(66574012)(2906002)(66476007)(66556008)(66946007)(478600001)(31686004)(36756003)(316002)(6486002)(16576012)(52116002)(2616005)(186003)(16526019)(53546011)(26005)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0236;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpr4Ao2EtZahDEePDaPYQB4QawRDtKtIMueNowkpafWYTBc2fUSS20W9puR4ht3x5z2v+1HGEIMsQctHyx0nudc7sTWJD5HlV2FYXCsMA9ZiErm1wVQ77TnQRfl5s/Z0AbBLzrhZFGFY/rRpqvsgYB7ilWhGf52igshQWKBPD/7OsT3KzdF2DSI1tOgaU6qZwpOZQJOWSidiLijQgXsjXsuNZ3d4I8rc/JSJd+Jgs6iTm+B3JqTo3YKx4KovROnhq6axKkCd6IMs5S3GCZX4PT/WohH4rc9O2auMhha6cZCHuRwfPOIzEqWD1C6sNlk7O5gfIhqoZWIpJnWZCpIw5YllIOIbUh753dH9HYvv+8dlfIJeMWcF7FLyOXHFNyH2nxuZGDrYW0gfB0x2CiU/un4j/U8osBsSB3c/NF5YEUI8hYNO0pr8AQoSkgCKn7sL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6216c360-b62a-4c5b-11dc-08d79af11e2f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 02:01:09.7104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQwF4+YB4W9euxUT6sShVpGETdhkrC9Ucdxy7dr0qCyDgAm1MHpO2L3TlRjJbBkUpzpI5wvsO+pe6JEDV44PAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0236
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

T24gMjAyMC0wMS0xNiA4OjA5LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IENvcmVib290IHNl
ZW1zIHRvIGhhdmUgYSBwcm9ibGVtIGNvcnJlY3RseSBzZXR0aW5nIHVwIGFjY2VzcyB0byB0aGUg
c3RvbGVuIFZSQU0KPiBvbiBLVi9LQi4gVXNlIHRoZSBkaXJlY3QgYWNjZXNzIG9ubHkgd2hlbiBu
ZWNlc3NhcnkuCgpJJ20gbm90IHN1cmUgd2hhdCB5b3UgbWVhbiBieSAibmVjZXNzYXJ5Ii4KCj4K
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjdfMC5jIHwgMyAr
Ky0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjdfMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y3XzAuYwo+IGluZGV4IDE5ZDViMTMzZTFkNy4u
OWRhOTU5NmEzNjM4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dt
Y192N18wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjdfMC5jCj4g
QEAgLTM4MSw3ICszODEsOCBAQCBzdGF0aWMgaW50IGdtY192N18wX21jX2luaXQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJYWRldi0+Z21jLmFwZXJfc2l6ZSA9IHBjaV9yZXNvdXJj
ZV9sZW4oYWRldi0+cGRldiwgMCk7Cj4gICAKPiAgICNpZmRlZiBDT05GSUdfWDg2XzY0Cj4gLQlp
ZiAoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKSB7Cj4gKwlpZiAoYWRldi0+ZmxhZ3MgJiBBTURf
SVNfQVBVICYmCj4gKwkgICAgYWRldi0+Z21jLnJlYWxfdnJhbV9zaXplID4gYWRldi0+Z21jLmFw
ZXJfc2l6ZSkgewoKQ1BVIGFjY2VzcyB0byB0aGUgd2hvbGUgVlJBTSBpc24ndCByZWFsbHkgbmVj
ZXNzYXJ5LiBJIHRob3VnaHQgdGhlIG1haW4gCm1vdGl2YXRpb24gZm9yIGFjY2Vzc2luZyBGQiBk
aXJlY3RseSBvbiBBUFVzIHdhcyBiZXR0ZXIgcGVyZm9ybWFuY2UuIApZb3UncmUgZGlzYWJsaW5n
IHRoYXQgb3B0aW1pemF0aW9uIG9uIGFsbCBBUFVzIHdoZXJlIHRoZSBGQiBpcyBzbWFsbGVyIAp0
aGFuIHRoZSBhcGVydHVyZSBzaXplLgoKUmVnYXJkcywKIMKgIEZlbGl4CgoKPiAgIAkJYWRldi0+
Z21jLmFwZXJfYmFzZSA9ICgodTY0KVJSRUczMihtbU1DX1ZNX0ZCX09GRlNFVCkpIDw8IDIyOwo+
ICAgCQlhZGV2LT5nbWMuYXBlcl9zaXplID0gYWRldi0+Z21jLnJlYWxfdnJhbV9zaXplOwo+ICAg
CX0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
