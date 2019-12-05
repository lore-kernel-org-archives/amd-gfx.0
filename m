Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E78C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 07:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F4C20675
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 07:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F4C20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 912396E981;
	Thu,  5 Dec 2019 07:26:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A92D46E981
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 07:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dc9D3MpnNL0wLEPuGjT6je4YAwGKZKL530QSGYCw7ME1sbJc2V6nuUTsJOnKsIf2IH2umr4Ccah4wSG875gBQAdae7AOdbAMCyYSmtpCfcyUgQVscMXY3l2ofiwjHBIruwBCveyRDsn07A7YHbvmAOEo7Pn18NDsmAuTV8asHsmeR9qO9SXkZ0CVH/XnTfcH3NhKW77bHWkFurjumlhA+sUwGS7qH/njaonPGFnCbHcUKhgON6xpuxUeon8NL2YB33wwuLa6r4Me7yzrgTB64r7JTx7raH3Xc8PvquwymeOQanB1rxVjUXNJM2Ipgb9FKp9qKdUNtkweejwAnisBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz7H6r+6LBjpvpog9yGX3NrCWFz99m4jdtGHQC1UFzM=;
 b=OTT9wT01ELpm5G0Nefr+DJY6L7dRnXgazb9bdcCCC1yNeSqZDZbCKXTZHuEgn4fDrqo9zFzsody9zHv5t0EvJnZUCTRhDxuFlWtYy/IoHsdGtxIVht3EdTpVrhhu0K0ODYIX7L3Q9lyTpeu8ezsQENy4DWXPayAIyE7xvL0MOFoTFnKi96ywgYzVSRDJw2sp3iCu1Lb7PS8+CnYteiirIFGsB/Pu9zAJgTA2h/JK2WIQsO9c1bJc6DhgkbLIt8noUPTLQaIDQtWDfm9cvtG5I8y7xLCeYghKbp1utGOqDE43HmBkEdGMeZ6FK2tEYROoP0YaB3+X2K/W3BbFV4LAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB3294.namprd12.prod.outlook.com (20.179.81.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 5 Dec 2019 07:26:12 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::48df:615a:93a3:6f74]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::48df:615a:93a3:6f74%7]) with mapi id 15.20.2495.026; Thu, 5 Dec 2019
 07:26:11 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: rename a leftover DCN1_0 kconfig
Date: Thu,  5 Dec 2019 15:25:57 +0800
Message-Id: <20191205072557.20915-1-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:202:2e::16) To MN2PR12MB3087.namprd12.prod.outlook.com
 (2603:10b6:208:d2::32)
MIME-Version: 1.0
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4b5b0c4b-de47-4260-19b8-08d779546715
X-MS-TrafficTypeDiagnostic: MN2PR12MB3294:|MN2PR12MB3294:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3294848916855F406B516AA3895C0@MN2PR12MB3294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-Forefront-PRVS: 02426D11FE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(189003)(199004)(50466002)(6666004)(5660300002)(48376002)(2361001)(66556008)(36756003)(2616005)(2351001)(4326008)(7736002)(26005)(44832011)(6506007)(14444005)(186003)(81166006)(50226002)(51416003)(8936002)(66476007)(478600001)(66946007)(3846002)(52116002)(86362001)(316002)(14454004)(4744005)(8676002)(2870700001)(6916009)(6436002)(1076003)(305945005)(6116002)(25786009)(81156014)(2906002)(6486002)(6512007)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3294;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2/E6mngUsfsJBcxf+QIH583KSV10wKK+PQlbPecvweFpbCfKOzVd8+wfCHyPN4LIQEazoM2VANsKR+9wJofedc/OEj+osX0zalGa/ugdPHBKBs7wKIgOqAw6QT8bGwpqi47dQXhfRWl5ahQP7BFwb3Fy6W5RKB6h0OhYs4PM3MUACtYxShgAlkjsWXiOqAXoRpy+DrV95V1jFKTxD1u6M1dlOWdkeUF0pfo9IER+2sFUj4+AbzuRY1vS2wD4Y+8VeLFvfNblAvtGhrIvsIQEwCqjXD2YPX5fGVziQT1Ukug82nouBoI/3g+iPegs2wvLTHyyJOrQ/ZbpyaFX4f5X8pB+8jK8h+xOKRDZATMJXrzvCaObTQIKv0v6KHf9pHJDWm6ioLliE156cjIzb57aKE3YObaIxRpllVCszHi5QNBOQxo/RaEXTayxQ6mN9d+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5b0c4b-de47-4260-19b8-08d779546715
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 07:26:11.8929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QM65Kbk6Yry37y6loUA6shZubwxjFLVhxEjknBClHURyKNh1ZU5s7lGCCAIDipVS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3294
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz7H6r+6LBjpvpog9yGX3NrCWFz99m4jdtGHQC1UFzM=;
 b=guTfLAxy/Z846DODmKNTXv7NEGLDHjCab+fNbMppULHuzsT8qDUNKSASM6cnfJzHK5TDTJ0R48DMBuk8OA9iLhlEKNFM03bz2MWj31X8+3HE7fkygWu2iyP8u9JKGV3M3pVaV9IM93lvkELoEOJXHQy9ADKsLFFndPMqaQ5fboM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
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
Cc: Bhawanpreet.Lakha@amd.com, harry.wentland@amd.com,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXM6IGI4NmExYWEzNmE5MiAoImRybS9hbWQvZGlzcGxheTogcmVuYW1lIERDTjFfMCBrY29u
ZmlnIHRvIERDTiIpClNpZ25lZC1vZmYtYnk6IFhpYW9qaWUgWXVhbiA8eGlhb2ppZS55dWFuQGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYyB8IDIg
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCmluZGV4IDI2NDVkMjBlOGM0Yy4uNTcz
YzIwZDI1ZTU4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29y
ZS9kYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMKQEAg
LTIxODEsNyArMjE4MSw3IEBAIHN0YXRpYyB2b2lkIGNvbW1pdF9wbGFuZXNfZm9yX3N0cmVhbShz
dHJ1Y3QgZGMgKmRjLAogCX0KIAlpZiAoZGMtPmh3c3MucHJvZ3JhbV9mcm9udF9lbmRfZm9yX2N0
eCAmJiB1cGRhdGVfdHlwZSAhPSBVUERBVEVfVFlQRV9GQVNUKSB7CiAJCWRjLT5od3NzLnByb2dy
YW1fZnJvbnRfZW5kX2Zvcl9jdHgoZGMsIGNvbnRleHQpOwotI2lmZGVmIENPTkZJR19EUk1fQU1E
X0RDX0RDTjFfMAorI2lmZGVmIENPTkZJR19EUk1fQU1EX0RDX0RDTgogCQlpZiAoZGMtPmRlYnVn
LnZhbGlkYXRlX2RtbF9vdXRwdXQpIHsKIAkJCWZvciAoaSA9IDA7IGkgPCBkYy0+cmVzX3Bvb2wt
PnBpcGVfY291bnQ7IGkrKykgewogCQkJCXN0cnVjdCBwaXBlX2N0eCBjdXJfcGlwZSA9IGNvbnRl
eHQtPnJlc19jdHgucGlwZV9jdHhbaV07Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
