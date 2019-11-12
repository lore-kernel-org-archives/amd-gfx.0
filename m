Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC58C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCF62067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCF62067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C966EBAD;
	Tue, 12 Nov 2019 18:04:20 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690048.outbound.protection.outlook.com [40.107.69.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F9C6EBAD
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9iCQN3NdfUxaWm6JBcjT4WSiF9K2TTiqFoQTAu5oIlInB0nEQfM7huphq2/oBTAbC4HoZbspUH4AbfKtrZmx3bIbxp6x3iYoaHQa2zeAxJ0k+H2iV0hrejxww4lHOLmz/jnBLtLgZbu8qSE/Pl2xyRGTxY4uMm+EUMfyJPTTOA090vhjHq5WVeneum5IaAGphuZd88OHF0E6AqZIEMuz5A/cE7rjprdW0TfRWkTOizhFZ21Zua5QqfvdHpxzFkh3JNU9hKLSeigbdGBpcqnovJhDSPUYMukvcJxiuIdDP+2QTYF4p5zJ8UuxzD3izYAzJLuP2dpNyQv/z3f1KJK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Is9/j2bH4NT8f4hGGxFub67FyLXpgmhuIfLMHJ63W8=;
 b=ZvKvkg8P+XgusgON1tcipMaaZ+ysXJKTLJ0MEsVoBNlgBoKmqZ3da8nCULy7awwy+ojEbdmhVBvlZUaZSrGfWGc5hQhvY5KdYGtxhs6Sm+4uvKEC6TiYQFcO04zP/3mH7iIrP2Jc/00n3tlyhMwt1CysBwhi8LI+HHQFjkfwpfadAMU3JaCryn6Pf5R4aNdPNQmzaoDVSxiItvd/fabtIdFNHUTV2+p4UwBo3UQkV1UA2Dt6GbUS/oIFjGibqB0KPTYAUqVIYji2g576Q6hSnckbLRTbTjOQdeudmT9OCSaTuB9e+WgRT0CkxS1fB1DRXT59Do5kN5JXGD8vlsAF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1580.namprd12.prod.outlook.com (10.172.40.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 18:04:17 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 18:04:17 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/21] drm/amdgpu: add driver support for JPEG2.0 and above
Date: Tue, 12 Nov 2019 13:03:25 -0500
Message-Id: <20191112180329.3927-18-leo.liu@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: afdd7910-c231-45d6-46b8-08d7679abc07
X-MS-TrafficTypeDiagnostic: DM5PR12MB1580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15802D821F9802E24E23FB1FE5770@DM5PR12MB1580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(478600001)(6512007)(305945005)(186003)(26005)(8936002)(6436002)(6486002)(5660300002)(76176011)(99286004)(25786009)(14454004)(51416003)(476003)(446003)(2616005)(4326008)(386003)(6506007)(6916009)(16586007)(7736002)(316002)(52116002)(86362001)(11346002)(50226002)(6666004)(486006)(2361001)(8676002)(44832011)(1076003)(36756003)(3846002)(6116002)(66066001)(47776003)(50466002)(2906002)(48376002)(66946007)(66556008)(2351001)(66476007)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1580;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7Z3gf/51IOafFxFaGQFHio3/4++bbThzbyBjOZoChtzL0OS6n4N/Lwpyrr+OxWAyjNh4Lu1g3K+CSHpXGsP+MQ4Zjp4e7BYOvlcD18zwccmRhqRYCyocTxSwBxl5b8oNOkAtSq2HJ3lLPXv/7kLzq8xKHJ+BEZACifJ34Y56L7l1h0ltgH1S4zwAndapFz/eH/3sl6/YbNG01Akecqcy8tyFD+Df2DnmDeBOGy8YCVIaDtRQI66o7yxvK+iamTNCMa6wunEuwl5NicN97Tn0TFOFs5nI4IvQCPBfLissvP+3zPWP9YaNPvvHetdJRyr2xEbkr4ES6LjBN78vByvqBO4xsZmybo3B5vKIERMYV6s8+R+OrQHpTvOPIgEBvQAHEoy6T/LtDpiacgiEPC4zE+IsKrnpp7VAjqpy/+EGRa2eeOPJ2SEfDhFTZAtzoRS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afdd7910-c231-45d6-46b8-08d7679abc07
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:04:17.6630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qb3dnmmm16Fa3txAtWVfksNLCkiB2mh52126u2jtF8h8GovTMblinfXfBr+vM8hC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1580
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Is9/j2bH4NT8f4hGGxFub67FyLXpgmhuIfLMHJ63W8=;
 b=QP/Wz4/EQtYCymS/XoQI1LFb3wELoLbluTJV8sXE89Q84DHGJYIOlwJBANUqw5zT/Sef1DB3PhYb1TMcJENv39iC2BO0jV2btfDeMS3A8Kwuw3iz7ei1BHnjFCtjyZP2E+DMBVfGipb40nrtvs87tPQ1O7JbN2UM5bAQIx89HCA=
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
Message-ID: <20191112180325.ybat7hdhN_qC8H_DqK3X0L2xQoeRd7yy5wCcMhM4ocw@z>

QnkgdXNpbmcgSlBFRyBJUCBibG9jayB0eXBlCgpTaWduZWQtb2ZmLWJ5OiBMZW8gTGl1IDxsZW8u
bGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jIHwgMiArKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jICAgIHwg
OSArKysrKysrLS0KIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCA4
NWMwMjRiNzRkNmQuLjE3YmU2Mzg5YWRmNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYwpAQCAtMTk2NCw2ICsxOTY0LDcgQEAgc3RhdGljIGludCBhbWRncHVf
ZGV2aWNlX3NldF9jZ19zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJaWYgKGFk
ZXYtPmlwX2Jsb2Nrc1tpXS52ZXJzaW9uLT50eXBlICE9IEFNRF9JUF9CTE9DS19UWVBFX1VWRCAm
JgogCQkgICAgYWRldi0+aXBfYmxvY2tzW2ldLnZlcnNpb24tPnR5cGUgIT0gQU1EX0lQX0JMT0NL
X1RZUEVfVkNFICYmCiAJCSAgICBhZGV2LT5pcF9ibG9ja3NbaV0udmVyc2lvbi0+dHlwZSAhPSBB
TURfSVBfQkxPQ0tfVFlQRV9WQ04gJiYKKwkJICAgIGFkZXYtPmlwX2Jsb2Nrc1tpXS52ZXJzaW9u
LT50eXBlICE9IEFNRF9JUF9CTE9DS19UWVBFX0pQRUcgJiYKIAkJICAgIGFkZXYtPmlwX2Jsb2Nr
c1tpXS52ZXJzaW9uLT5mdW5jcy0+c2V0X2Nsb2NrZ2F0aW5nX3N0YXRlKSB7CiAJCQkvKiBlbmFi
bGUgY2xvY2tnYXRpbmcgdG8gc2F2ZSBwb3dlciAqLwogCQkJciA9IGFkZXYtPmlwX2Jsb2Nrc1tp
XS52ZXJzaW9uLT5mdW5jcy0+c2V0X2Nsb2NrZ2F0aW5nX3N0YXRlKCh2b2lkICopYWRldiwKQEAg
LTE5OTQsNiArMTk5NSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9zZXRfcGdfc3RhdGUo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGVudW0gYW1kX3Bvd2VyCiAJCWlmIChhZGV2LT5p
cF9ibG9ja3NbaV0udmVyc2lvbi0+dHlwZSAhPSBBTURfSVBfQkxPQ0tfVFlQRV9VVkQgJiYKIAkJ
ICAgIGFkZXYtPmlwX2Jsb2Nrc1tpXS52ZXJzaW9uLT50eXBlICE9IEFNRF9JUF9CTE9DS19UWVBF
X1ZDRSAmJgogCQkgICAgYWRldi0+aXBfYmxvY2tzW2ldLnZlcnNpb24tPnR5cGUgIT0gQU1EX0lQ
X0JMT0NLX1RZUEVfVkNOICYmCisJCSAgICBhZGV2LT5pcF9ibG9ja3NbaV0udmVyc2lvbi0+dHlw
ZSAhPSBBTURfSVBfQkxPQ0tfVFlQRV9KUEVHICYmCiAJCSAgICBhZGV2LT5pcF9ibG9ja3NbaV0u
dmVyc2lvbi0+ZnVuY3MtPnNldF9wb3dlcmdhdGluZ19zdGF0ZSkgewogCQkJLyogZW5hYmxlIHBv
d2VyZ2F0aW5nIHRvIHNhdmUgcG93ZXIgKi8KIAkJCXIgPSBhZGV2LT5pcF9ibG9ja3NbaV0udmVy
c2lvbi0+ZnVuY3MtPnNldF9wb3dlcmdhdGluZ19zdGF0ZSgodm9pZCAqKWFkZXYsCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKaW5kZXggNGE0MDg1ZWM1M2UwLi42Yzc3NWE2
NWEyMDYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKQEAgLTQwMCw3
ICs0MDAsOSBAQCBzdGF0aWMgaW50IGFtZGdwdV9od19pcF9pbmZvKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAogCQlpYl9zaXplX2FsaWdubWVudCA9IDE7CiAJCWJyZWFrOwogCWNhc2UgQU1E
R1BVX0hXX0lQX1ZDTl9KUEVHOgotCQl0eXBlID0gQU1EX0lQX0JMT0NLX1RZUEVfVkNOOworCQl0
eXBlID0gKGFtZGdwdV9kZXZpY2VfaXBfZ2V0X2lwX2Jsb2NrKGFkZXYsIEFNRF9JUF9CTE9DS19U
WVBFX0pQRUcpKSA/CisJCQlBTURfSVBfQkxPQ0tfVFlQRV9KUEVHIDogQU1EX0lQX0JMT0NLX1RZ
UEVfVkNOOworCiAJCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5qcGVnLm51bV9qcGVnX2luc3Q7IGkr
KykgewogCQkJaWYgKGFkZXYtPmpwZWcuaGFydmVzdF9jb25maWcgJiAoMSA8PCBpKSkKIAkJCQlj
b250aW51ZTsKQEAgLTUyMSw5ICs1MjMsMTIgQEAgc3RhdGljIGludCBhbWRncHVfaW5mb19pb2N0
bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRhLCBzdHJ1Y3QgZHJtX2ZpbGUKIAkJ
CWJyZWFrOwogCQljYXNlIEFNREdQVV9IV19JUF9WQ05fREVDOgogCQljYXNlIEFNREdQVV9IV19J
UF9WQ05fRU5DOgotCQljYXNlIEFNREdQVV9IV19JUF9WQ05fSlBFRzoKIAkJCXR5cGUgPSBBTURf
SVBfQkxPQ0tfVFlQRV9WQ047CiAJCQlicmVhazsKKwkJY2FzZSBBTURHUFVfSFdfSVBfVkNOX0pQ
RUc6CisJCQl0eXBlID0gKGFtZGdwdV9kZXZpY2VfaXBfZ2V0X2lwX2Jsb2NrKGFkZXYsIEFNRF9J
UF9CTE9DS19UWVBFX0pQRUcpKSA/CisJCQkJQU1EX0lQX0JMT0NLX1RZUEVfSlBFRyA6IEFNRF9J
UF9CTE9DS19UWVBFX1ZDTjsKKwkJCWJyZWFrOwogCQlkZWZhdWx0OgogCQkJcmV0dXJuIC1FSU5W
QUw7CiAJCX0KLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
