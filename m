Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2DBC2BA19
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 16:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1AA2064A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 16:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ayEz7yNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1AA2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B1A6EA2B;
	Wed, 15 Apr 2020 16:35:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 210CE6EA2B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 16:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezIuv8Wsdygo4BfeCc64MpLR5Nutkjn4n1YyCCxMR1WIfXCBWwWE88z6cjcG1XUemgRFsdJsD6wOKkUekj2Y1CISc+d5c2eJydcZkvtHm7M74OfffD1dY4I9ifhPKhOw3gz49ApD0P6XhHmIV8v9pdIGNdA19EVWQ9+zBgXv2bAYyI9U9aTMC6czTf+EfWP0BlQvS52sscGqp4iW6XrMAsZUQvzW5v58PFWA1IU2/8fVDUQ8uOJMIFtuGH8ZP7CuGEIo547K3Ys66suPHrTs8wwtFCinZpQ+R8/jcl9AsA7BYFkdeMe/5fLb0MgfwepyjnyUl9gqnpfUZuE9rs40eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3uQep6/LFxIA9DnkT539GK8qcIszN81V3Yw6WZfj2k=;
 b=dNLyqtvmsrW5qwQPmR8nmv6wg3PP3Wa5TY0ogI4BsVwViksOHRjK/718cHt8nLtay1kRE/99gpM1KvYzJD0IMNPEkmejQq5KoiVLoUlxnh8f7eEXcLgA1XQi6oEsQdGYPhjCnFAymc1B5D8Hdv1MW8eNL0Oe7WS8qgckQSZ1oK6RD6eClehZpe3SLLKV7La8hlQ2vIonfdEJ1tgW/MOFledNa55iqG+tsnvjOCUJ5tWEOhRoWlO89Xja8rA6DTUG+ttaOWnkPvk3Q0VZl6aVMcrSxKaaM5nG2NjFziUDG93fyIxTE1oD6ejC976A8FgNd87aOLB6pR0u/98mBf9luQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3uQep6/LFxIA9DnkT539GK8qcIszN81V3Yw6WZfj2k=;
 b=ayEz7yNCBg3ai6rRrQ6hN0n9PZvbqdq40UAryBJquzGSoddnjs3dzmMaF77Gt/ub/EGwilUubFgcq3XgvJndQeisJRQHbL+WAhXnhtaehmdgts4tt7m1tO3226jfhfcu1Y/VfPs8YCI1p35DCx35I8j5RaUDdcwr6xS0A90sUGY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from BN6PR12MB1155.namprd12.prod.outlook.com (2603:10b6:404:1b::17)
 by BN6PR12MB1330.namprd12.prod.outlook.com (2603:10b6:404:1e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Wed, 15 Apr
 2020 16:35:02 +0000
Received: from BN6PR12MB1155.namprd12.prod.outlook.com
 ([fe80::21ee:121a:3f5f:a569]) by BN6PR12MB1155.namprd12.prod.outlook.com
 ([fe80::21ee:121a:3f5f:a569%9]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 16:35:02 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/gmc: Fix spelling mistake.
Date: Wed, 15 Apr 2020 12:34:25 -0400
Message-Id: <20200415163425.8046-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To BN6PR12MB1155.namprd12.prod.outlook.com
 (2603:10b6:404:1b::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Wed, 15 Apr 2020 16:35:01 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0fd7dfd6-9512-49a9-a688-08d7e15af1d3
X-MS-TrafficTypeDiagnostic: BN6PR12MB1330:|BN6PR12MB1330:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1330F11FFF58282A7BA553BCFEDB0@BN6PR12MB1330.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1155.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(44832011)(4326008)(66946007)(478600001)(66476007)(86362001)(956004)(6666004)(52116002)(7696005)(66556008)(316002)(26005)(2616005)(1076003)(2906002)(16526019)(8676002)(8936002)(5660300002)(6486002)(6916009)(186003)(36756003)(81156014);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/Mwldu4VUs65+IGMioIbvQNrFkBIl/MmqWwx7qrzhgQP7n0bjgiBfRLok3nAxb40i5PxD7H2j7thcig/Hjy1xNqL6bYeSysN4ZHrwEuKq9rlFlW3urH1HvihBKa36kdqMOymJdaVD416rfpBSpl8HWr2/x/tpd6DEJHhzrr13u2CTZwcK6NmJiceonDMFwDdbCvnZXNTOprhmZCHZxWHKXWWuSLD7KhasybPFHY5dJF6pW9whT1QbQkJCul9jdf24CJ3nvSC3eSJ7UKMpIff6/mlPg1LJrzEqmpKY/L3RyDeTlmAxG1Xr/GTXdf3c5kDYJBRWlb5q76lWYRpwI+MajhA+0tWnBQxxbnOQhAWroxLsUyvPa7ZW089BFW9bDv9gQDVgnCQXsLCb7pPR6J1JTtdAuNAEaeFZ75kR5VpdDQA0tRtL53d6tjHVF0EyB+
X-MS-Exchange-AntiSpam-MessageData: LpMmrHc9PGPncwjQ8GlrRX5dCBI+eH/WoXaTPDlt9pv3JkYn89Ptt/iJsDdSs0b3nKOfyGZr+/qD2U09eov5sqmkyN6anS38F3MfYDLrf3P0G7IUkocys9TwDRzJWA+fCSfgBMXOw2b5RZ/eaQZKRQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd7dfd6-9512-49a9-a688-08d7e15af1d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 16:35:01.9279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQAeWXheFoGH4MjVNJlp3/rDiQICwRsCiB9zq7xPiFVkSE/msNcQyR839GAZf3GXEcfOSe/1hZOazjnD9YYYdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1330
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
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgYSBtaW5vciB0eXBvIGluIHRoZSBmaWxlLgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogUmFqbmVlc2ggQmhh
cmR3YWogPHJham5lZXNoLmJoYXJkd2FqQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dtYy5jIHwgMTIgKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nbWMuYwppbmRleCA0ZjhmZDA2N2QxNTAuLmFjYWJiNTdhYThhZiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwpAQCAtMTM2LDggKzEzNiw4IEBAIHVpbnQ2
NF90IGFtZGdwdV9nbWNfYWdwX2FkZHIoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibykKIC8q
KgogICogYW1kZ3B1X2dtY192cmFtX2xvY2F0aW9uIC0gdHJ5IHRvIGZpbmQgVlJBTSBsb2NhdGlv
bgogICoKLSAqIEBhZGV2OiBhbWRncHUgZGV2aWNlIHN0cnVjdHVyZSBob2xkaW5nIGFsbCBuZWNl
c3NhcnkgaW5mb3JtYXRpb25zCi0gKiBAbWM6IG1lbW9yeSBjb250cm9sbGVyIHN0cnVjdHVyZSBo
b2xkaW5nIG1lbW9yeSBpbmZvcm1hdGlvbnMKKyAqIEBhZGV2OiBhbWRncHUgZGV2aWNlIHN0cnVj
dHVyZSBob2xkaW5nIGFsbCBuZWNlc3NhcnkgaW5mb3JtYXRpb24KKyAqIEBtYzogbWVtb3J5IGNv
bnRyb2xsZXIgc3RydWN0dXJlIGhvbGRpbmcgbWVtb3J5IGluZm9ybWF0aW9uCiAgKiBAYmFzZTog
YmFzZSBhZGRyZXNzIGF0IHdoaWNoIHRvIHB1dCBWUkFNCiAgKgogICogRnVuY3Rpb24gd2lsbCB0
cnkgdG8gcGxhY2UgVlJBTSBhdCBiYXNlIGFkZHJlc3MgcHJvdmlkZWQKQEAgLTE2NSw4ICsxNjUs
OCBAQCB2b2lkIGFtZGdwdV9nbWNfdnJhbV9sb2NhdGlvbihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwgc3RydWN0IGFtZGdwdV9nbWMgKm1jLAogLyoqCiAgKiBhbWRncHVfZ21jX2dhcnRfbG9j
YXRpb24gLSB0cnkgdG8gZmluZCBHQVJUIGxvY2F0aW9uCiAgKgotICogQGFkZXY6IGFtZGdwdSBk
ZXZpY2Ugc3RydWN0dXJlIGhvbGRpbmcgYWxsIG5lY2Vzc2FyeSBpbmZvcm1hdGlvbnMKLSAqIEBt
YzogbWVtb3J5IGNvbnRyb2xsZXIgc3RydWN0dXJlIGhvbGRpbmcgbWVtb3J5IGluZm9ybWF0aW9u
cworICogQGFkZXY6IGFtZGdwdSBkZXZpY2Ugc3RydWN0dXJlIGhvbGRpbmcgYWxsIG5lY2Vzc2Fy
eSBpbmZvcm1hdGlvbgorICogQG1jOiBtZW1vcnkgY29udHJvbGxlciBzdHJ1Y3R1cmUgaG9sZGlu
ZyBtZW1vcnkgaW5mb3JtYXRpb24KICAqCiAgKiBGdW5jdGlvbiB3aWxsIHBsYWNlIHRyeSB0byBw
bGFjZSBHQVJUIGJlZm9yZSBvciBhZnRlciBWUkFNLgogICoKQEAgLTIwNyw4ICsyMDcsOCBAQCB2
b2lkIGFtZGdwdV9nbWNfZ2FydF9sb2NhdGlvbihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwg
c3RydWN0IGFtZGdwdV9nbWMgKm1jKQogCiAvKioKICAqIGFtZGdwdV9nbWNfYWdwX2xvY2F0aW9u
IC0gdHJ5IHRvIGZpbmQgQUdQIGxvY2F0aW9uCi0gKiBAYWRldjogYW1kZ3B1IGRldmljZSBzdHJ1
Y3R1cmUgaG9sZGluZyBhbGwgbmVjZXNzYXJ5IGluZm9ybWF0aW9ucwotICogQG1jOiBtZW1vcnkg
Y29udHJvbGxlciBzdHJ1Y3R1cmUgaG9sZGluZyBtZW1vcnkgaW5mb3JtYXRpb25zCisgKiBAYWRl
djogYW1kZ3B1IGRldmljZSBzdHJ1Y3R1cmUgaG9sZGluZyBhbGwgbmVjZXNzYXJ5IGluZm9ybWF0
aW9uCisgKiBAbWM6IG1lbW9yeSBjb250cm9sbGVyIHN0cnVjdHVyZSBob2xkaW5nIG1lbW9yeSBp
bmZvcm1hdGlvbgogICoKICAqIEZ1bmN0aW9uIHdpbGwgcGxhY2UgdHJ5IHRvIGZpbmQgYSBwbGFj
ZSBmb3IgdGhlIEFHUCBCQVIgaW4gdGhlIE1DIGFkZHJlc3MKICAqIHNwYWNlLgotLSAKMi4xNy4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
