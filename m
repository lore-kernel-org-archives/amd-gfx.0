Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD3BC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 07:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA957206B1
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 07:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iwIYxDVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA957206B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C7596EB7D;
	Fri, 13 Mar 2020 07:44:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9400B6EB7A
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 07:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLdSSnr/cwaugIHIYj/ga9eSJ+o8nCaCoY0GlBWm0+VBmkF3RqCSU4+tu/lZDHk2z7zb1BF1a1HkU3X66tMFc8S4nvgFmO8G+U3O/1KtGFJwrE+AHp5fkc6hkIwIdLvFGQ+CxO4kgGDVU5bNd2zsmjkZZouiCyV/+IgU5n5w3durJslZTCEVDBFBjzth9L7u1mbqhjyg5esKonI2eRLkVCTZONXQ3NTQJjhOTIjGMuFfPqIuAvbeQ0/bvHDzyy0r+0RUmmb7qgR7nGTyc/QKpQkbyFlhEZCOSIHN098NUcpt8Jgmnqct7kY1UNiuoA+Mrvmna68TheXF1FVvGYRhmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq/GyrZMocufwnNynTGswulhYSy5oT2KliZahcDSv3Y=;
 b=TWmxiROXLa4BuwV1jE7uK6nQIlp3bmEpJ08e0LPEIg74D6N2beFjsPuOp68H/WgUdCLZ7lpJoTLZZ7Svky8t81OUCh4Iw1P3fOKjeiNQYpHrkVxrCkZQUYp6AJqvBOeD5TfcrLVH/aUNZncd+0J0miKRJkkPq4yF63SbCGe60uyDRUPLisN8APNOi9C0s0lamlF+cKFJWWoB3oG0FgC7Ay6xwOEcRR24rwittJPY5aqKwXQ//j6+lAtwd5BjTrFDLV2ZBMmEpUTQfOPNqIVMh7NtMgiFkI800qk2WSIY70q9zVQQ92QZB9KBwZQKL+ZgTBfvxRIa9ghSTfVmF06J1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq/GyrZMocufwnNynTGswulhYSy5oT2KliZahcDSv3Y=;
 b=iwIYxDVNSjN8D8LG1NanoiBqlfORNEqqKiR2NwNyPpYeBIArhsxlCuWm2nJApMi8NKwrRwmIS+/4bzZkSkQPS9KPMKK4NkhPkS/RG8dRbXfdUj/+tRKzMXQVjqDje4WwI3p/9Q267GCH/1TUyETWDQi40aBZXqXgODChuPeH2u0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2781.namprd12.prod.outlook.com (2603:10b6:805:67::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 07:44:05 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 07:44:05 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm//amdgpu: Always sync fence before unlock eviction_lock
Date: Fri, 13 Mar 2020 15:43:35 +0800
Message-Id: <20200313074336.19545-2-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313074336.19545-1-xinhui.pan@amd.com>
References: <20200313074336.19545-1-xinhui.pan@amd.com>
X-ClientProxiedBy: HK2PR03CA0048.apcprd03.prod.outlook.com
 (2603:1096:202:17::18) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR03CA0048.apcprd03.prod.outlook.com (2603:1096:202:17::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.7 via Frontend Transport; Fri, 13 Mar 2020 07:44:04 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7963053-b63e-4bb5-8edc-08d7c7224e80
X-MS-TrafficTypeDiagnostic: SN6PR12MB2781:|SN6PR12MB2781:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27810E7F09250ADA1B47903A87FA0@SN6PR12MB2781.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(199004)(8676002)(5660300002)(81166006)(81156014)(6486002)(54906003)(52116002)(7696005)(4326008)(66476007)(66946007)(66556008)(8936002)(66574012)(1076003)(186003)(26005)(16526019)(2906002)(6916009)(2616005)(956004)(316002)(86362001)(36756003)(6666004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2781;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fQaD6noU+DghnbqNvLfp555NcW0Ylel08uX+o7nAMu/d7q6AzNAXmMnBzoS/YHrlshkhcCHaGPAOQF1OWvHhP/6Pms/RDg3EItXY9ZM7EcAA3oi2jZRAxOqBTgQ3wwpWUXi4opjOQGcwae2sN+yKuOkK11KGm4T2YEqkFRS7SakBMVxS6vnf1TqUav8QuqRZuvyxeYOAxM3BmVkII9RfNrBbEOWjiGc9uPZGH4KMPXr/355mW9Rykb0rvUZb9MvmzyZGZXmoR+F1jz3PXUY1V96VSAT04xo3TorpvrPK+ZDW9/PfF0G73ecgat6jv7MwAiUa4smKO+vpSCWkNeDtT6FhDX4KDeUNlXeC/zPnSnkF20zgTPtw7pC8Cie66/Tt6Q66ghVTXrymisHFYkNrXS7bUf4Z7B/rNySex+QJNS+zb4MH79LAJBSTAlL1pLZz
X-MS-Exchange-AntiSpam-MessageData: y9bezLOi+lifz1oTC1pmVib7dy+BjQkAT3WOkJ3X6zj81vb8jlHlXarTQ2ctrefjQy+aRjsHaBHIS6afah3GOJ2ouZ+EKUdHm3QdUrxFYgxx2xoEAXnAXbKSOpxtiaHYtrmtyGgUhtSygTagd9ERNQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7963053-b63e-4bb5-8edc-08d7c7224e80
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 07:44:05.7337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whNw3/hkBq5TvyEpS6nlDObzhiWkjmSy4iLhiu/Il54bOsIjbfB856Ah4UVq7r94
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2781
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
 Felix Kuehling <Felix.Kuehling@amd.com>, xinhui pan <xinhui.pan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIGZlbmNlIGdlbmVyYXRlZCBpbiAtPmNvbW1pdCBpcyBhIHNoYXJlZCBvbmUsIHNvIGFkZCBp
dCB0byByZXN2LgpBbmQgd2UgbmVlZCBkbyB0aGF0IHdpdGggZXZpY3Rpb24gbG9jayBob2xkLgoK
Q3VycmVudGx5IHdlIG9ubHkgc3luYyBsYXN0X2RpcmVjdC9sYXN0X2RlbGF5ZWQgYmVmb3JlIC0+
cHJlcGFyZS4gQnV0IHdlCmZhaWwgdG8gc3luYyB0aGUgbGFzdCBmZW5jZSBnZW5lcmF0ZWQgYnkg
LT5jb21taXQuIFRoYXQgY3Vhc2VzIHByb2JsZW1zCmlmIGV2aWN0aW9uIGhhcHBlbmVzIGxhdGVy
LCBidXQgaXQgZG9lcyBub3Qgc3luYyB0aGUgbGFzdCBmZW5jZS4KCkNjOiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+CkNjOiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4KU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgOSArKysrKysrLS0KIDEg
ZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwppbmRleCA3MzM5ODgzMTE5NmYuLmY0MjRiNTk2OTkz
MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTE1ODIsNiArMTU4
Miw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAogCXN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyBwYXJhbXM7
CiAJZW51bSBhbWRncHVfc3luY19tb2RlIHN5bmNfbW9kZTsKIAlpbnQgcjsKKwlzdHJ1Y3QgYW1k
Z3B1X2JvICpyb290ID0gdm0tPnJvb3QuYmFzZS5ibzsKIAogCW1lbXNldCgmcGFyYW1zLCAwLCBz
aXplb2YocGFyYW1zKSk7CiAJcGFyYW1zLmFkZXYgPSBhZGV2OwpAQCAtMTYwNCw4ICsxNjA1LDYg
QEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCiAJfQogCiAJaWYgKGZsYWdzICYgQU1ER1BVX1BURV9WQUxJRCkgewotCQlz
dHJ1Y3QgYW1kZ3B1X2JvICpyb290ID0gdm0tPnJvb3QuYmFzZS5ibzsKLQogCQlpZiAoIWRtYV9m
ZW5jZV9pc19zaWduYWxlZCh2bS0+bGFzdF9kaXJlY3QpKQogCQkJYW1kZ3B1X2JvX2ZlbmNlKHJv
b3QsIHZtLT5sYXN0X2RpcmVjdCwgdHJ1ZSk7CiAKQEAgLTE2MjMsNiArMTYyMiwxMiBAQCBzdGF0
aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKIAogCXIgPSB2bS0+dXBkYXRlX2Z1bmNzLT5jb21taXQoJnBhcmFtcywgZmVuY2UpOwog
CisJaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxhc3RfZGlyZWN0KSkKKwkJYW1kZ3B1
X2JvX2ZlbmNlKHJvb3QsIHZtLT5sYXN0X2RpcmVjdCwgdHJ1ZSk7CisKKwlpZiAoIWRtYV9mZW5j
ZV9pc19zaWduYWxlZCh2bS0+bGFzdF9kZWxheWVkKSkKKwkJYW1kZ3B1X2JvX2ZlbmNlKHJvb3Qs
IHZtLT5sYXN0X2RlbGF5ZWQsIHRydWUpOworCiBlcnJvcl91bmxvY2s6CiAJYW1kZ3B1X3ZtX2V2
aWN0aW9uX3VubG9jayh2bSk7CiAJcmV0dXJuIHI7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
