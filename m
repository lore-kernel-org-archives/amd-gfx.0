Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE7DC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9483F2067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9483F2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 476BB6EBA7;
	Tue, 12 Nov 2019 18:04:04 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790057.outbound.protection.outlook.com [40.107.79.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5E06EBA4
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqaVnluIeb+Ad5zhEKqt1xCbLdRi2NCZN53w2dvwUQuhCBRhyuzwFBx7Uv2X5S9P4V4M5u6mSif8vyJpgYFO/SOa6hAdEaH9OfI1tYZ17Q0psOsVTJCqiGfsSGMnax8wXdzzVGhZ3xQun4rTvVswRl9yITAEGmhCB+xdU6X8fjfVbhWQvf3JktVsIrcsKNkD8R/ss0yH5mk3dntVKiPXggwYrhLRCmJrY0FDYcmp2jMg/40UyjdMBVNyx48L6BMDE9YiXESxI90cfmnuxbTRXFIp1+Ueigcv9wPcf8dGNaDKHM+lavIShWfVfiQZVWDtxQ27QRsMEjYwGv4rLPHgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zcz7SUJQsLy2f56bVp4I12+pYCGOhqYG8w6ZcEyeYc8=;
 b=Ig68fUCOa1xgE/NfRS7QukGwVCNauwId/6ScIBqQ1oMk3GLVcpqKgvbZpgsq4Ybql+zevi1Mgi73vsdB2YlBP0vcz+8Vn+D20HPcUiWoHPeD0pGaP+QeUSyijBQLw8rEmjjiyILLLDaQe149jxVtxsZc2pDH3hFzEaNmsSJiuMdp0rUIMw6Lv3I0EdjJH2pXiF/0AZAK5/19kPZiXaEO9CZsF8tkIJBStWAo9ztOXUdo4U1fCLf460YQjNT91dV5kXmM+2NXhySzH3l2E4E9htEb8ctkOngmmjO/MIhwS9pvjyJ9SD5AMrMM+/GM9sRWMwpuHCTDCk7fmRdG0bcTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB2405.namprd12.prod.outlook.com (52.132.140.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 18:04:00 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 18:04:00 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/21] drm/amdgpu: add amdgpu_jpeg and JPEG tests
Date: Tue, 12 Nov 2019 13:03:10 -0500
Message-Id: <20191112180329.3927-3-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112180329.3927-1-leo.liu@amd.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 402cc55e-cf9e-4f05-4e81-08d7679ab19d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2405:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24056D5EE15303054426E58BE5770@DM5PR12MB2405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(4326008)(6512007)(76176011)(66066001)(47776003)(6666004)(2351001)(478600001)(51416003)(52116002)(14454004)(6916009)(44832011)(486006)(186003)(476003)(2616005)(6506007)(386003)(7736002)(26005)(25786009)(2361001)(14444005)(36756003)(86362001)(305945005)(446003)(11346002)(6116002)(8676002)(3846002)(99286004)(16586007)(66476007)(50226002)(66946007)(2906002)(6486002)(6436002)(8936002)(81166006)(50466002)(5660300002)(316002)(1076003)(48376002)(81156014)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2405;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUxCKrt5JpbEiI/AYai60hYCWSp3gE8bzTi+RmbopvLmlYBwJ+la7qjw3ngSlLiWOjWWBQNhgGPz+QVvCM3U+R++LvtSbJHkFPzzlK4sObn1+ANo3GJHfp8qL3qTRonE+X/7/1Q5MRxt37S8p+eqicrfYFBzDFPeWKS+MbSwCjcxEludPs+dZIjsxjUj9TCYB7ZerVER7pOaj4oGKlb5IBzM6daVPUER/0HniQhPLDlsoasmYwpGXSqed0GlQQ81+vwIN5lLOK68+rE1E0MoFXKO4AtkXxCeznVIpkpwMhGlbKG+TrEBaTzH0uaXwVhe9NQvTgWvb27wFyqw6K1lvukTUf4KmSn4YBhygh6Zvb3PNW/eYlRAxZvBgphUN9956UhsGrXndqXCp+C9CY2R0ksRoufOrw6OIhF6Q3am6BO+XawclQMS42UjBqoOJnxD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402cc55e-cf9e-4f05-4e81-08d7679ab19d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:04:00.0914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAxVWlHLpjTHTjfnhhB8n+99e2etwQbFT4PG68mmBQxbtCFh3u0XWIJ7L0XleltC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2405
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zcz7SUJQsLy2f56bVp4I12+pYCGOhqYG8w6ZcEyeYc8=;
 b=NBj8roAszRZxMT49LhDQswFk9gf2g31/SjeBYEAUTjonhMF+11nSdCZbjlOMowgbuudErpvkZJNaF1OnrxUpmjL0Xm+w3iFo/+3HcqUAHIENbWoIhGMFhn0gvkpkGFczZTKOknqrcdtrK2mNLE82RYG/PoPExLD2WtAcqhaLYCI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112180310.2hc4VSs77Hsun8NZ6Pzi-XRQfxPGi37HD6ATXGZJHwQ@z>

SXQgd2lsbCBiZSB1c2VkIGZvciBhbGwgdmVyc2lvbnMgb2YgSlBFRyBldmVudHVhbGx5LiBQcmV2
aW91cwpKUEVHIHRlc3RzIHdpbGwgYmUgcmVtb3ZlZCBsYXRlciBzaW5jZSB0aGV5IGFyZSBzdGls
bCB1c2VkIGJ5CkpQRUcyLnguCgpTaWduZWQtb2ZmLWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvTWFrZWZpbGUgICAgICB8ICAgNSAr
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pwZWcuYyB8IDEzNSArKysrKysr
KysrKysrKysrKysrKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pwZWcu
aCB8ICAgMyArCiAzIGZpbGVzIGNoYW5nZWQsIDE0MSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9qcGVnLmMKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9NYWtlZmls
ZSBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L01ha2VmaWxlCmluZGV4IDdlYjE3MmViZjNm
OC4uMTFjYTcwMTA1ZWViIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9N
YWtlZmlsZQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9NYWtlZmlsZQpAQCAtMTQ3
LDEyICsxNDcsMTMgQEAgYW1kZ3B1LXkgKz0gXAogCXZjZV92M18wLm8gXAogCXZjZV92NF8wLm8K
IAotIyBhZGQgVkNOIGJsb2NrCisjIGFkZCBWQ04gYW5kIEpQRUcgYmxvY2sKIGFtZGdwdS15ICs9
IFwKIAlhbWRncHVfdmNuLm8gXAogCXZjbl92MV8wLm8gXAogCXZjbl92Ml8wLm8gXAotCXZjbl92
Ml81Lm8KKwl2Y25fdjJfNS5vIFwKKwlhbWRncHVfanBlZy5vCiAKICMgYWRkIEFUSFVCIGJsb2Nr
CiBhbWRncHUteSArPSBcCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfanBlZy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pwZWcuYwpu
ZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLmQ5YTU0N2Q0ZDNiMgotLS0g
L2Rldi9udWxsCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmMK
QEAgLTAsMCArMSwxMzUgQEAKKy8qCisgKiBDb3B5cmlnaHQgMjAxOSBBZHZhbmNlZCBNaWNybyBE
ZXZpY2VzLCBJbmMuCisgKiBBbGwgUmlnaHRzIFJlc2VydmVkLgorICoKKyAqIFBlcm1pc3Npb24g
aXMgaGVyZWJ5IGdyYW50ZWQsIGZyZWUgb2YgY2hhcmdlLCB0byBhbnkgcGVyc29uIG9idGFpbmlu
ZyBhCisgKiBjb3B5IG9mIHRoaXMgc29mdHdhcmUgYW5kIGFzc29jaWF0ZWQgZG9jdW1lbnRhdGlv
biBmaWxlcyAodGhlCisgKiAiU29mdHdhcmUiKSwgdG8gZGVhbCBpbiB0aGUgU29mdHdhcmUgd2l0
aG91dCByZXN0cmljdGlvbiwgaW5jbHVkaW5nCisgKiB3aXRob3V0IGxpbWl0YXRpb24gdGhlIHJp
Z2h0cyB0byB1c2UsIGNvcHksIG1vZGlmeSwgbWVyZ2UsIHB1Ymxpc2gsCisgKiBkaXN0cmlidXRl
LCBzdWIgbGljZW5zZSwgYW5kL29yIHNlbGwgY29waWVzIG9mIHRoZSBTb2Z0d2FyZSwgYW5kIHRv
CisgKiBwZXJtaXQgcGVyc29ucyB0byB3aG9tIHRoZSBTb2Z0d2FyZSBpcyBmdXJuaXNoZWQgdG8g
ZG8gc28sIHN1YmplY3QgdG8KKyAqIHRoZSBmb2xsb3dpbmcgY29uZGl0aW9uczoKKyAqCisgKiBU
SEUgU09GVFdBUkUgSVMgUFJPVklERUQgIkFTIElTIiwgV0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkg
S0lORCwgRVhQUkVTUyBPUgorICogSU1QTElFRCwgSU5DTFVESU5HIEJVVCBOT1QgTElNSVRFRCBU
TyBUSEUgV0FSUkFOVElFUyBPRiBNRVJDSEFOVEFCSUxJVFksCisgKiBGSVRORVNTIEZPUiBBIFBB
UlRJQ1VMQVIgUFVSUE9TRSBBTkQgTk9OLUlORlJJTkdFTUVOVC4gSU4gTk8gRVZFTlQgU0hBTEwK
KyAqIFRIRSBDT1BZUklHSFQgSE9MREVSUywgQVVUSE9SUyBBTkQvT1IgSVRTIFNVUFBMSUVSUyBC
RSBMSUFCTEUgRk9SIEFOWSBDTEFJTSwKKyAqIERBTUFHRVMgT1IgT1RIRVIgTElBQklMSVRZLCBX
SEVUSEVSIElOIEFOIEFDVElPTiBPRiBDT05UUkFDVCwgVE9SVCBPUgorICogT1RIRVJXSVNFLCBB
UklTSU5HIEZST00sIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEggVEhFIFNPRlRXQVJFIE9S
IFRIRQorICogVVNFIE9SIE9USEVSIERFQUxJTkdTIElOIFRIRSBTT0ZUV0FSRS4KKyAqCisgKiBU
aGUgYWJvdmUgY29weXJpZ2h0IG5vdGljZSBhbmQgdGhpcyBwZXJtaXNzaW9uIG5vdGljZSAoaW5j
bHVkaW5nIHRoZQorICogbmV4dCBwYXJhZ3JhcGgpIHNoYWxsIGJlIGluY2x1ZGVkIGluIGFsbCBj
b3BpZXMgb3Igc3Vic3RhbnRpYWwgcG9ydGlvbnMKKyAqIG9mIHRoZSBTb2Z0d2FyZS4KKyAqCisg
Ki8KKworI2luY2x1ZGUgImFtZGdwdS5oIgorI2luY2x1ZGUgImFtZGdwdV9qcGVnLmgiCisjaW5j
bHVkZSAic29jMTVkLmgiCisjaW5jbHVkZSAic29jMTVfY29tbW9uLmgiCisKK2ludCBhbWRncHVf
anBlZ19kZWNfcmluZ190ZXN0X3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQoreworCXN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gcmluZy0+YWRldjsKKwl1aW50MzJfdCB0bXAgPSAw
OworCXVuc2lnbmVkIGk7CisJaW50IHI7CisKKwlXUkVHMzIoYWRldi0+anBlZy5pbnN0W3Jpbmct
Pm1lXS5leHRlcm5hbC5qcGVnX3BpdGNoLCAweENBRkVERUFEKTsKKwlyID0gYW1kZ3B1X3Jpbmdf
YWxsb2MocmluZywgMyk7CisJaWYgKHIpCisJCXJldHVybiByOworCisJYW1kZ3B1X3Jpbmdfd3Jp
dGUocmluZywgUEFDS0VUMChhZGV2LT5qcGVnLmludGVybmFsLmpwZWdfcGl0Y2gsIDApKTsKKwlh
bWRncHVfcmluZ193cml0ZShyaW5nLCAweERFQURCRUVGKTsKKwlhbWRncHVfcmluZ19jb21taXQo
cmluZyk7CisKKwlmb3IgKGkgPSAwOyBpIDwgYWRldi0+dXNlY190aW1lb3V0OyBpKyspIHsKKwkJ
dG1wID0gUlJFRzMyKGFkZXYtPmpwZWcuaW5zdFtyaW5nLT5tZV0uZXh0ZXJuYWwuanBlZ19waXRj
aCk7CisJCWlmICh0bXAgPT0gMHhERUFEQkVFRikKKwkJCWJyZWFrOworCQl1ZGVsYXkoMSk7CisJ
fQorCisJaWYgKGkgPj0gYWRldi0+dXNlY190aW1lb3V0KQorCQlyID0gLUVUSU1FRE9VVDsKKwor
CXJldHVybiByOworfQorCitzdGF0aWMgaW50IGFtZGdwdV9qcGVnX2RlY19zZXRfcmVnKHN0cnVj
dCBhbWRncHVfcmluZyAqcmluZywgdWludDMyX3QgaGFuZGxlLAorCQlzdHJ1Y3QgZG1hX2ZlbmNl
ICoqZmVuY2UpCit7CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Owor
CXN0cnVjdCBhbWRncHVfam9iICpqb2I7CisJc3RydWN0IGFtZGdwdV9pYiAqaWI7CisJc3RydWN0
IGRtYV9mZW5jZSAqZiA9IE5VTEw7CisJY29uc3QgdW5zaWduZWQgaWJfc2l6ZV9kdyA9IDE2Owor
CWludCBpLCByOworCisJciA9IGFtZGdwdV9qb2JfYWxsb2Nfd2l0aF9pYihyaW5nLT5hZGV2LCBp
Yl9zaXplX2R3ICogNCwgJmpvYik7CisJaWYgKHIpCisJCXJldHVybiByOworCisJaWIgPSAmam9i
LT5pYnNbMF07CisKKwlpYi0+cHRyWzBdID0gUEFDS0VUSihhZGV2LT5qcGVnLmludGVybmFsLmpw
ZWdfcGl0Y2gsIDAsIDAsIFBBQ0tFVEpfVFlQRTApOworCWliLT5wdHJbMV0gPSAweERFQURCRUVG
OworCWZvciAoaSA9IDI7IGkgPCAxNjsgaSArPSAyKSB7CisJCWliLT5wdHJbaV0gPSBQQUNLRVRK
KDAsIDAsIDAsIFBBQ0tFVEpfVFlQRTYpOworCQlpYi0+cHRyW2krMV0gPSAwOworCX0KKwlpYi0+
bGVuZ3RoX2R3ID0gMTY7CisKKwlyID0gYW1kZ3B1X2pvYl9zdWJtaXRfZGlyZWN0KGpvYiwgcmlu
ZywgJmYpOworCWlmIChyKQorCQlnb3RvIGVycjsKKworCWlmIChmZW5jZSkKKwkJKmZlbmNlID0g
ZG1hX2ZlbmNlX2dldChmKTsKKwlkbWFfZmVuY2VfcHV0KGYpOworCisJcmV0dXJuIDA7CisKK2Vy
cjoKKwlhbWRncHVfam9iX2ZyZWUoam9iKTsKKwlyZXR1cm4gcjsKK30KKworaW50IGFtZGdwdV9q
cGVnX2RlY19yaW5nX3Rlc3RfaWIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBsb25nIHRpbWVv
dXQpCit7CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2OworCXVpbnQz
Ml90IHRtcCA9IDA7CisJdW5zaWduZWQgaTsKKwlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSA9IE5V
TEw7CisJbG9uZyByID0gMDsKKworCXIgPSBhbWRncHVfanBlZ19kZWNfc2V0X3JlZyhyaW5nLCAx
LCAmZmVuY2UpOworCWlmIChyKQorCQlnb3RvIGVycm9yOworCisJciA9IGRtYV9mZW5jZV93YWl0
X3RpbWVvdXQoZmVuY2UsIGZhbHNlLCB0aW1lb3V0KTsKKwlpZiAociA9PSAwKSB7CisJCXIgPSAt
RVRJTUVET1VUOworCQlnb3RvIGVycm9yOworCX0gZWxzZSBpZiAociA8IDApIHsKKwkJZ290byBl
cnJvcjsKKwl9IGVsc2UgeworCQlyID0gMDsKKwl9CisKKwlmb3IgKGkgPSAwOyBpIDwgYWRldi0+
dXNlY190aW1lb3V0OyBpKyspIHsKKwkJdG1wID0gUlJFRzMyKGFkZXYtPmpwZWcuaW5zdFtyaW5n
LT5tZV0uZXh0ZXJuYWwuanBlZ19waXRjaCk7CisJCWlmICh0bXAgPT0gMHhERUFEQkVFRikKKwkJ
CWJyZWFrOworCQl1ZGVsYXkoMSk7CisJfQorCisJaWYgKGkgPj0gYWRldi0+dXNlY190aW1lb3V0
KQorCQlyID0gLUVUSU1FRE9VVDsKKworCWRtYV9mZW5jZV9wdXQoZmVuY2UpOworZXJyb3I6CisJ
cmV0dXJuIHI7Cit9CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfanBlZy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pwZWcuaAppbmRl
eCAzNmUyYjczNDBjOTcuLmE4ZDk4OGMyNWY0NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2pwZWcuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfanBlZy5oCkBAIC00Myw0ICs0Myw3IEBAIHN0cnVjdCBhbWRncHVfanBlZyB7CiAJ
dW5zaWduZWQgaGFydmVzdF9jb25maWc7CiB9OwogCitpbnQgYW1kZ3B1X2pwZWdfZGVjX3Jpbmdf
dGVzdF9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyk7CitpbnQgYW1kZ3B1X2pwZWdfZGVj
X3JpbmdfdGVzdF9pYihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIGxvbmcgdGltZW91dCk7CisK
ICNlbmRpZiAvKl9fQU1ER1BVX0pQRUdfSF9fKi8KLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
