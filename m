Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4A4C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D33A2067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D33A2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C49F6EBA3;
	Tue, 12 Nov 2019 18:03:58 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790070.outbound.protection.outlook.com [40.107.79.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9558A6EBA3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7qjBj/7Y+jAglb8sRq+CBgSo3MPNeT5emQl4an8vyyPr/uhF7KabyI/HTwE5ZOgQNznr4QfVbzGFJPNPyc6Sayj4YFFZ56rBabzNtG8UogttXi5Jyep5/zVw7prMTnXs/ZcbtUNcGnBuK8X0utykPGa/xyumlYxQ8PkB6IdhhSx0eI/HL/1JHQRgISuUHcTZ9lCr0o9CAZyC2YyiV5QjUUI58l0P2UgTvR4Hpj+e34jwUzwTT54AmHxjqGmwC0RRZPr9R3gis9t5nxFhd1+y8utWWc5QZzGoCo7kG3+XWBbBm/NbDBFAwmjXh5ZaoZXTwzmVn0fc58gnKkZoJcj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyaN8qp22by71zJLUEi01TUTH/LqrJvOMgGdG8GgpeU=;
 b=QMzxRG9jcBfoc9R3/ivmt5q7aruSfS1rkXZ0YekFupmV1rXFAV2YWlqJOvpo664JKZB3BolzKoD8xnjaFPabL/QS6m2DmGsVukbcXuTIWWw7GDnvs4ex+AsYGz6hnzlU8IMG6bI4gZfVkSfk1hQzNO5q5k2++zeF5QKumtoZN6bjX0X3A7q4UgaWNjKgiKOq2k/mmI6kTfRieN7fZEzrlcLoagisGNc1PRL3zo7vSPaW68Zt62SO2hJSAsRGQC7qkTzYTXgFWh8DXPMK/UNKfkitCllvmz4vYtts2eqpl17fzNOfEInCFfDBbZRWB0hXeFbF++4ok9YgvZYaV7XvMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB2405.namprd12.prod.outlook.com (52.132.140.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 18:03:55 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 18:03:55 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/21] Separate JPEG from VCN
Date: Tue, 12 Nov 2019 13:03:08 -0500
Message-Id: <20191112180329.3927-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82ef226c-3291-4d7a-3052-08d7679aaee1
X-MS-TrafficTypeDiagnostic: DM5PR12MB2405:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2405B8532AAE7FB1AA366173E5770@DM5PR12MB2405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(4326008)(6512007)(66066001)(47776003)(6666004)(2351001)(478600001)(51416003)(52116002)(14454004)(6916009)(44832011)(486006)(186003)(476003)(2616005)(6506007)(386003)(7736002)(26005)(25786009)(2361001)(36756003)(86362001)(305945005)(6116002)(8676002)(3846002)(99286004)(16586007)(66476007)(50226002)(66946007)(2906002)(6486002)(6436002)(8936002)(81166006)(50466002)(5660300002)(316002)(1076003)(48376002)(81156014)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2405;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWHPhdB85lLjzTJJgbyjrwEQ+RXUbSZqm9NDHEFbLbYq4rxXCPO76Cr0yjF1TohAg6MKVOiw8+mfng4YZ1UCghHfa/zyIiIDxETzmqwdCtEiLZFUMJCFRSoyKGwus6v+ogIx4LloWqQc7Cm44kL/hGQy+yuAnGKYGOsOrXCXJYJFt8Agf8AiDH6zucD6UD9gnudZCHbdKOVB8w7qA7ThERWIVr41SpCcK1sEPjqxwND57fTj3gglbAKwgZHcl0pPv4/RlTJ+R2IzXwjZo/VKGLj0dx8mpq1g/7WLc4yJLSCxOv1cKVSwpKo6yMtw0ZTeTXHv4j7A+ZTTkLPOn7USIo/REOnFIMRprMwq9G1RlorkjAf7sp2YuZDurRPWSDn48yWojtqaCTihVVvrGdlErx1ZxECMkzQklQCGszDxzka7Vd9x/16qByiBxID86EX2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ef226c-3291-4d7a-3052-08d7679aaee1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:03:55.4991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wumeTC8QmWMCv3PpUKHNJqQtH7GVeImOSHbeiIawcE43e++pgMj6vax97Oxm5Cxp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2405
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyaN8qp22by71zJLUEi01TUTH/LqrJvOMgGdG8GgpeU=;
 b=Ntrt5rv191B5zsMBYwNji/dFfFR+sY14CP9ynVtVP/Dv/gFraYN9hwFlu7B6y+ghQii8JuXsm5TElvOM9Glkwa3Y32aAc2BsPt3L+7s+RpP9Y+Uwy3IeLD2xo6a6+rR/O9osENQ5V7i1tJceTEqxsGHSZYgfYwff7xSF5svWk54=
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
Message-ID: <20191112180308.qWp-vJkatzaXYvXXsrKs9ty8pxOYYe0GbPAPlfWTAe4@z>

RnJvbSBKUEVHMi4wLCBKUEVHIGlzIGEgc2VwYXJhdGVkIElQIGJsb2NrLCBhbmQgaGFzIGl0IG93
biBQRy9DRywKYW5kIHBvd2VyIG1hbmFnZW1lbnQuIEl0IGRvZXNuJ3QgcmVxdWlyZSBGVywgc28g
aW5kZXBlZGVudCBmcm9tIEZXIApsb2FkaW5nIGFzIHdlbGwuCgpQYXRjaCAxLTQ6IFNlcGFyYXRl
IEpQRUcxLjAgZnJvbSBTVyB3aXNlLCBzaW5jZSBKUEVHMS4wIGlzIHN0aWxsCmNvbWJpbmVkIHdp
dGggVkNOMS4wIGVzcC4gaW4gcG93ZXIgbWFuYWdlbWVudDsKUGF0Y2ggNS0xMDogU2VwYXJhdGUg
SlBFRzIuMCBhcyBhbiBpbmRlcGVuZGVudCBJUCB3aXRoIFBHL0NHOwpQYXRjaCAxMS0xNTogQWRk
IHBvd2VyIG1hbmFnZW1lbnQgZm9yIEpQRUcgb2YgTmF2aTF4IGFuZCBSZW5vaXI7ClBhdGNoIDE2
OiBFbmFibGUgSlBFRzIuMDsKUGF0Y2ggMTctMjA6IFNlcGFyYXRlIEpQRUcyLjUgZnJvbSBWQ04y
LjU7ClBhdGNoIDIxOiBFbmFibGUgSlBFRzIuNSAKCkxlbyBMaXUgKDIxKToKICBkcm0vYW1kZ3B1
OiBhZGQgSlBFRyBIVyBJUCBhbmQgU1cgc3RydWN0dXJlcwogIGRybS9hbWRncHU6IGFkZCBhbWRn
cHVfanBlZyBhbmQgSlBFRyB0ZXN0cwogIGRybS9hbWRncHU6IHNlcGFyYXRlIEpQRUcxLjAgY29k
ZSBvdXQgZnJvbSBWQ04xLjAKICBkcm0vYW1kZ3B1OiB1c2UgdGhlIEpQRUcgc3RydWN0dXJlIGZv
ciBnZW5lcmFsIGRyaXZlciBzdXBwb3J0CiAgZHJtL2FtZGdwdTogYWRkIEpQRUcgSVAgYmxvY2sg
dHlwZQogIGRybS9hbWRncHU6IGFkZCBKUEVHIGNvbW1vbiBmdW5jdGlvbnMgdG8gYW1kZ3B1X2pw
ZWcKICBkcm0vYW1kZ3B1OiBhZGQgSlBFRyB2Mi4wIGZ1bmN0aW9uIHN1cHBvcnRzCiAgZHJtL2Ft
ZGdwdTogcmVtb3ZlIHVubmVjZXNzYXJ5IEpQRUcyLjAgY29kZSBmcm9tIFZDTjIuMAogIGRybS9h
bWRncHU6IGFkZCBKUEVHIFBHIGFuZCBDRyBpbnRlcmZhY2UKICBkcm0vYW1kZ3B1OiBhZGQgUEcg
YW5kIENHIGZvciBKUEVHMi4wCiAgZHJtL2FtZC9wb3dlcnBsYXk6IGFkZCBKUEVHIFBvd2VycGxh
eSBpbnRlcmZhY2UKICBkcm0vYW1kL3Bvd2VycGxheTogYWRkIEpQRUcgcG93ZXIgY29udHJvbCBm
b3IgTmF2aTF4CiAgZHJtL2FtZC9wb3dlcnBsYXk6IGFkZCBQb3dlcmdhdGUgSlBFRyBmb3IgUmVu
b2lyCiAgZHJtL2FtZC9wb3dlcnBsYXk6IGFkZCBKUEVHIHBvd2VyIGNvbnRyb2wgZm9yIFJlbm9p
cgogIGRybS9hbWQvcG93ZXJwbGF5OiBzZXQgSlBFRyB0byBTTVUgZHBtCiAgZHJtL2FtZGdwdTog
ZW5hYmxlIEpQRUcyLjAgZHBtCiAgZHJtL2FtZGdwdTogYWRkIGRyaXZlciBzdXBwb3J0IGZvciBK
UEVHMi4wIGFuZCBhYm92ZQogIGRybS9hbWRncHU6IGVuYWJsZSBKUEVHMi4wIGZvciBOYXZpMXgg
YW5kIFJlbm9pcgogIGRybS9hbWRncHU6IG1vdmUgSlBFRzIuNSBvdXQgZnJvbSBWQ04yLjUKICBk
cm0vYW1kZ3B1OiBlbmFibGUgQXJjdHVydXMgQ0cgZm9yIFZDTiBhbmQgSlBFRyBibG9ja3MKICBk
cm0vYW1kZ3B1OiBlbmFibGUgQXJjdHVydXMgSlBFRzIuNSBibG9jawoKIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L01ha2VmaWxlICAgICAgICAgICB8ICAgOCArLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1LmggICAgICAgICAgIHwgICA1ICsKIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9jdHguYyAgICAgICB8ICAgNCArLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jICAgIHwgICAyICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9qcGVnLmMgICAgICB8IDIxNSArKysrKwogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2pwZWcuaCAgICAgIHwgIDYyICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfa21zLmMgICAgICAgfCAgMTUgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9wbS5jICAgICAgICB8ICAgOCArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcG0uaCAgICAgICAgfCAgIDEgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Zjbi5jICAgICAgIHwgMTEzICstLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Zjbi5oICAgICAgIHwgICA1IC0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2pwZWdfdjFfMC5jICAgICAgICB8IDU4NCArKysrKysrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9qcGVnX3YxXzAuaCAgICAgICAgfCAgMzIgKwogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvanBlZ192Ml8wLmMgICAgICAgIHwgODI3ICsrKysrKysrKysrKysrKysrKwogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml8wLmggICAgICAgIHwgIDQyICsKIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfNS5jICAgICAgICB8IDY0MSArKysrKysrKysr
KysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml81LmggICAgICAgIHwgIDI5
ICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgICAgICAgICAgICAgICB8ICAxMSAr
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyAgICAgICAgICAgIHwgIDEwICst
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jICAgICAgICAgfCA0ODEgKy0t
LS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzAuYyAgICAgICAgIHwg
NDk2ICstLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfMC5oICAg
ICAgICAgfCAgMTMgLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYyAgICAg
ICAgIHwgMjQ2ICstLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQu
aCAgICAgIHwgICA1ICstCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211
LmMgICAgfCAgIDUgKwogLi4uL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvYW1kZ3B1X3NtdS5o
ICAgIHwgICAzICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXVfdjEyXzAu
aCB8ICAgMiArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMgICAg
fCAgMzIgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Jlbm9pcl9wcHQuYyAgICB8
ICAyNyArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfaW50ZXJuYWwuaCAgfCAg
IDQgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMl8wLmMgICAgIHwgIDEx
ICsKIDMxIGZpbGVzIGNoYW5nZWQsIDI1OTMgaW5zZXJ0aW9ucygrKSwgMTM0NiBkZWxldGlvbnMo
LSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
anBlZy5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2pwZWcuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2pwZWdfdjFfMC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvanBlZ192MV8wLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9qcGVnX3YyXzAuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2pwZWdfdjJfMC5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvanBlZ192Ml81LmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9qcGVnX3YyXzUuaAoKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
