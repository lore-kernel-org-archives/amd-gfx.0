Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057CCC4CECE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0AB0206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="r1LVAH8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AB0206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E24D6E45C;
	Fri, 13 Mar 2020 13:19:51 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760077.outbound.protection.outlook.com [40.107.76.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5C406E45C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 13:19:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKhYdpMdoAV3FL8X2osFMRC3+jNyXIeAkAypmakuvJl8Dryy4TT7RPnG+/gf47kZYcLPvFvhJEG+EOOwnfGjUrfPZg0jkIxIHvhX9jPIaNE/o7CF9UF0+O1JVRV2ZyKpp7TiH4ZJ9VjkEAZ2mcAfB3iQvjvByVONk/nxCFYFkVqZgCSdpNknfsTLdYhIVFUA8OKsmVz2I04tR2X8cYh0shZVTnpXgFU0GZ7tSGyl59XyqbcZpHa78HBv6llN/C/YjFlCYYhCM6g1W7R9QkyK0w/sNuAY55NkxVe1NbmLzJ5E5Aj2HlZsm+sLUrqG82yN8GuB/uPTuLYi2QC6HT8iCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1W7o8zfyHd7ZhYWU5Z/qdiaXnjTHsot3K9rFdW+Qaec=;
 b=Js899vrCE0E5X5dBnU3V/3hbavOs4mKjnS9woskG06mC+beDubSp5e4Qob/56YwiPdEsuvZ6TJn9fh3UGQwaUl2BNmgVxEtnf7GjcGNkqzLd8Y0RAQK1LHRZLIWPreAFeNjthshWUqFIqC6PPpaT2nLFDq000Mfx08+bu0ryXf/iQJHCzZnGupCA9cRNmz0NMbs0jkHMGsC7FY9+E6Ikh9NBbeqyHFjV5bx8RYaaVOMOVPQe1WXlUVtnPMLYkF5kqCQ7WqZ0cic6auZ1ljVeQzJp/35ELLxXd7m+cn15r6ic/WsZ5BkQuW+pPNWHOeOIy2bNsFXtUROCrGBqQNrYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1W7o8zfyHd7ZhYWU5Z/qdiaXnjTHsot3K9rFdW+Qaec=;
 b=r1LVAH8py06tedD7KKlxifYjit2g8y8TounoNGKybCslWz+t9MrT+OE9EWnLvYiRqtWX+FoIcBm4glnmK6ko0+yBZ5FvmM6sewA/09m1CXblCrhZMvs5Vm7puoGlPBQXatRngCGlvsBW1GCVTQq4ZNx05RZ7/uewImvJ52qyA1U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2750.namprd12.prod.outlook.com (2603:10b6:805:77::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 13:19:49 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 13:19:49 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/amdgpu: unref the bo after job submit
Date: Fri, 13 Mar 2020 21:19:18 +0800
Message-Id: <20200313131918.29721-3-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313131918.29721-1-xinhui.pan@amd.com>
References: <20200313131918.29721-1-xinhui.pan@amd.com>
X-ClientProxiedBy: HK2PR02CA0182.apcprd02.prod.outlook.com
 (2603:1096:201:21::18) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR02CA0182.apcprd02.prod.outlook.com (2603:1096:201:21::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Fri, 13 Mar 2020 13:19:47 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1fd2f8ae-5879-4b55-3d6d-08d7c7513532
X-MS-TrafficTypeDiagnostic: SN6PR12MB2750:|SN6PR12MB2750:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27509CD73A101CEE2A41B1F287FA0@SN6PR12MB2750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:378;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(199004)(66476007)(16526019)(7696005)(186003)(316002)(26005)(86362001)(2616005)(36756003)(956004)(66574012)(81166006)(54906003)(52116002)(6666004)(2906002)(8936002)(478600001)(81156014)(5660300002)(6916009)(8676002)(66556008)(4326008)(1076003)(6486002)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2750;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/AW01UfjRzzfoeRNCMfP0JBSIeF5xlZAv+Bsa933dQkjIQ1MdioFKuDiOOMk/6F8LOYzobvvoL8EVZn/NXNIrv+/vyeupmw7mqyI4O9lMGptVq4SMCvyB+gm+68B5gz1kWdZjRBjEi8C8Y97kzK7nOfZc2MRb914DWx5HE3XfBkVqP3cga8/1I33KcIfpR6yw8XyvWFEcl2QDiamgxSkXCzcV1SUmHP950M1LS1IuoQZxk/9P9YoyOK1aJWGT7XqHCMKvbIou6nGpy46YM6LkLnGbKpct5d7dojygBs2BSRd9ZxLPAhgkVzAOJekJWnTN+Z7CQRETWuygLaOgUzRRhRJT6uuO3H4S+Gt1+Ex4XBuXAN6S2zRMKb5IKsCMkQsD6cqNxD99p94inQpYUBP9Tp4Z5KTptYPAggiFIZY2d805eT281dn/wDqhQr2vrW
X-MS-Exchange-AntiSpam-MessageData: pmf23kJnhEdLTq+GlTx7Wzf2sxwJ5AM8yxafWwJdVrjJAOBDHgigRZr5g2xe0N/l0IupjKV6+t07JOdeqynYrBWLmD7xiwY6kopeayWP/2OOjTfUodWahp3dfGYaUS5mOIxfD4CU3eLZq5REp5k+fQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd2f8ae-5879-4b55-3d6d-08d7c7513532
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 13:19:49.7066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJO65QxlqdLldjgw/sYG1xrxUiRBVp/XoMR7kjX5YGOjMraEyiNiufig4p0eSoJj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2750
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

T3RoZXJ3aXNlIHdlIG1pZ2h0IGZyZWUgQk9zIGJlZm9yZSBqb2IgaGFzIGNvbXBsZXRlZC4KV2Ug
YWRkIHRoZSBmZW5jZSB0byBCTyBhZnRlciBjb21taXQsIHNvIGZyZWUgQk9zIGFmdGVyIHRoYXQu
CgpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogRmVsaXggS3VlaGxpbmcg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1
aS5wYW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
YyB8IDM4ICsrKysrKysrKysrKysrKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjggaW5z
ZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYwppbmRleCA3MzM5ODgzMTE5NmYuLmJkNDBhNzkyM2I2NyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTk0MiwxMyArOTQyLDE3IEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3ZtX2FsbG9jX3B0cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKICAqCiAgKiBA
ZW50cnk6IFBERSB0byBmcmVlCiAgKi8KLXN0YXRpYyB2b2lkIGFtZGdwdV92bV9mcmVlX3RhYmxl
KHN0cnVjdCBhbWRncHVfdm1fcHQgKmVudHJ5KQorc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2ZyZWVf
dGFibGUoc3RydWN0IGFtZGdwdV92bV9wdCAqZW50cnksCisJCQkJCXN0cnVjdCBsaXN0X2hlYWQg
KmhlYWQpCiB7CiAJaWYgKGVudHJ5LT5iYXNlLmJvKSB7CiAJCWVudHJ5LT5iYXNlLmJvLT52bV9i
byA9IE5VTEw7CiAJCWxpc3RfZGVsKCZlbnRyeS0+YmFzZS52bV9zdGF0dXMpOwotCQlhbWRncHVf
Ym9fdW5yZWYoJmVudHJ5LT5iYXNlLmJvLT5zaGFkb3cpOwotCQlhbWRncHVfYm9fdW5yZWYoJmVu
dHJ5LT5iYXNlLmJvKTsKKwkJaWYgKCFoZWFkKSB7CisJCQlhbWRncHVfYm9fdW5yZWYoJmVudHJ5
LT5iYXNlLmJvLT5zaGFkb3cpOworCQkJYW1kZ3B1X2JvX3VucmVmKCZlbnRyeS0+YmFzZS5ibyk7
CisJCX0gZWxzZQorCQkJbGlzdF9hZGQoJmVudHJ5LT5iYXNlLnZtX3N0YXR1cywgaGVhZCk7CiAJ
fQogCWt2ZnJlZShlbnRyeS0+ZW50cmllcyk7CiAJZW50cnktPmVudHJpZXMgPSBOVUxMOwpAQCAt
OTY1LDcgKzk2OSw4IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92bV9mcmVlX3RhYmxlKHN0cnVjdCBh
bWRncHVfdm1fcHQgKmVudHJ5KQogICovCiBzdGF0aWMgdm9pZCBhbWRncHVfdm1fZnJlZV9wdHMo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkgICAgICAgc3RydWN0IGFtZGdwdV92bSAq
dm0sCi0JCQkgICAgICAgc3RydWN0IGFtZGdwdV92bV9wdF9jdXJzb3IgKnN0YXJ0KQorCQkJICAg
ICAgIHN0cnVjdCBhbWRncHVfdm1fcHRfY3Vyc29yICpzdGFydCwKKwkJCQkgICBzdHJ1Y3QgbGlz
dF9oZWFkICpoZWFkKQogewogCXN0cnVjdCBhbWRncHVfdm1fcHRfY3Vyc29yIGN1cnNvcjsKIAlz
dHJ1Y3QgYW1kZ3B1X3ZtX3B0ICplbnRyeTsKQEAgLTk3MywxMCArOTc4LDEwIEBAIHN0YXRpYyB2
b2lkIGFtZGdwdV92bV9mcmVlX3B0cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAl2bS0+
YnVsa19tb3ZlYWJsZSA9IGZhbHNlOwogCiAJZm9yX2VhY2hfYW1kZ3B1X3ZtX3B0X2Rmc19zYWZl
KGFkZXYsIHZtLCBzdGFydCwgY3Vyc29yLCBlbnRyeSkKLQkJYW1kZ3B1X3ZtX2ZyZWVfdGFibGUo
ZW50cnkpOworCQlhbWRncHVfdm1fZnJlZV90YWJsZShlbnRyeSwgaGVhZCk7CiAKIAlpZiAoc3Rh
cnQpCi0JCWFtZGdwdV92bV9mcmVlX3RhYmxlKHN0YXJ0LT5lbnRyeSk7CisJCWFtZGdwdV92bV9m
cmVlX3RhYmxlKHN0YXJ0LT5lbnRyeSwgaGVhZCk7CiB9CiAKIC8qKgpAQCAtMTQyOCw3ICsxNDMz
LDggQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2ZyYWdtZW50KHN0cnVjdCBhbWRncHVfdm1fdXBk
YXRlX3BhcmFtcyAqcGFyYW1zLAogICovCiBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVfcHRl
cyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywKIAkJCQkgdWludDY0X3Qg
c3RhcnQsIHVpbnQ2NF90IGVuZCwKLQkJCQkgdWludDY0X3QgZHN0LCB1aW50NjRfdCBmbGFncykK
KwkJCQkgdWludDY0X3QgZHN0LCB1aW50NjRfdCBmbGFncywKKwkJCQkgc3RydWN0IGxpc3RfaGVh
ZCAqaGVhZCkKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHBhcmFtcy0+YWRldjsK
IAlzdHJ1Y3QgYW1kZ3B1X3ZtX3B0X2N1cnNvciBjdXJzb3I7CkBAIC0xNTM5LDcgKzE1NDUsNyBA
QCBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVfcHRlcyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0
ZV9wYXJhbXMgKnBhcmFtcywKIAkJCSAqIGNvbXBsZXRlbHkgY292ZXJlZCBieSB0aGUgcmFuZ2Ug
YW5kIHNvIHBvdGVudGlhbGx5IHN0aWxsIGluIHVzZS4KIAkJCSAqLwogCQkJd2hpbGUgKGN1cnNv
ci5wZm4gPCBmcmFnX3N0YXJ0KSB7Ci0JCQkJYW1kZ3B1X3ZtX2ZyZWVfcHRzKGFkZXYsIHBhcmFt
cy0+dm0sICZjdXJzb3IpOworCQkJCWFtZGdwdV92bV9mcmVlX3B0cyhhZGV2LCBwYXJhbXMtPnZt
LCAmY3Vyc29yLCBoZWFkKTsKIAkJCQlhbWRncHVfdm1fcHRfbmV4dChhZGV2LCAmY3Vyc29yKTsK
IAkJCX0KIApAQCAtMTU4Miw2ICsxNTg4LDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBk
YXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJc3RydWN0IGFtZGdwdV92
bV91cGRhdGVfcGFyYW1zIHBhcmFtczsKIAllbnVtIGFtZGdwdV9zeW5jX21vZGUgc3luY19tb2Rl
OwogCWludCByOworCXN0cnVjdCBsaXN0X2hlYWQgaGVhZDsKIAogCW1lbXNldCgmcGFyYW1zLCAw
LCBzaXplb2YocGFyYW1zKSk7CiAJcGFyYW1zLmFkZXYgPSBhZGV2OwpAQCAtMTU4OSw2ICsxNTk2
LDggQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCiAJcGFyYW1zLmRpcmVjdCA9IGRpcmVjdDsKIAlwYXJhbXMucGFnZXNf
YWRkciA9IHBhZ2VzX2FkZHI7CiAKKwlJTklUX0xJU1RfSEVBRCgmaGVhZCk7CisKIAkvKiBJbXBs
aWNpdGx5IHN5bmMgdG8gY29tbWFuZCBzdWJtaXNzaW9ucyBpbiB0aGUgc2FtZSBWTSBiZWZvcmUK
IAkgKiB1bm1hcHBpbmcuIFN5bmMgdG8gbW92aW5nIGZlbmNlcyBiZWZvcmUgbWFwcGluZy4KIAkg
Ki8KQEAgLTE2MTcsMTMgKzE2MjYsMjIgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBkYXRl
X21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJaWYgKHIpCiAJCWdvdG8gZXJy
b3JfdW5sb2NrOwogCi0JciA9IGFtZGdwdV92bV91cGRhdGVfcHRlcygmcGFyYW1zLCBzdGFydCwg
bGFzdCArIDEsIGFkZHIsIGZsYWdzKTsKKwlyID0gYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKCZwYXJh
bXMsIHN0YXJ0LCBsYXN0ICsgMSwgYWRkciwgZmxhZ3MsICZoZWFkKTsKIAlpZiAocikKIAkJZ290
byBlcnJvcl91bmxvY2s7CiAKIAlyID0gdm0tPnVwZGF0ZV9mdW5jcy0+Y29tbWl0KCZwYXJhbXMs
IGZlbmNlKTsKIAogZXJyb3JfdW5sb2NrOgorCXdoaWxlICghbGlzdF9lbXB0eSgmaGVhZCkpIHsK
KwkJc3RydWN0IGFtZGdwdV92bV9wdCAqZW50cnkgPSBsaXN0X2ZpcnN0X2VudHJ5KCZoZWFkLAor
CQkJCXN0cnVjdCBhbWRncHVfdm1fcHQsIGJhc2Uudm1fc3RhdHVzKTsKKwkJbGlzdF9kZWwoJmVu
dHJ5LT5iYXNlLnZtX3N0YXR1cyk7CisKKwkJYW1kZ3B1X2JvX3VucmVmKCZlbnRyeS0+YmFzZS5i
by0+c2hhZG93KTsKKwkJYW1kZ3B1X2JvX3VucmVmKCZlbnRyeS0+YmFzZS5ibyk7CisJfQorCiAJ
YW1kZ3B1X3ZtX2V2aWN0aW9uX3VubG9jayh2bSk7CiAJcmV0dXJuIHI7CiB9CkBAIC0zMTE4LDcg
KzMxMzYsNyBAQCB2b2lkIGFtZGdwdV92bV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSkKIAkJYW1kZ3B1X3ZtX2ZyZWVfbWFwcGluZyhhZGV2LCB2
bSwgbWFwcGluZywgTlVMTCk7CiAJfQogCi0JYW1kZ3B1X3ZtX2ZyZWVfcHRzKGFkZXYsIHZtLCBO
VUxMKTsKKwlhbWRncHVfdm1fZnJlZV9wdHMoYWRldiwgdm0sIE5VTEwsIE5VTEwpOwogCWFtZGdw
dV9ib191bnJlc2VydmUocm9vdCk7CiAJYW1kZ3B1X2JvX3VucmVmKCZyb290KTsKIAlXQVJOX09O
KHZtLT5yb290LmJhc2UuYm8pOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
