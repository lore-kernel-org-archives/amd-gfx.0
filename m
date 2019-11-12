Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF06C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 21:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48D52084E
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 21:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48D52084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F4116EBF3;
	Tue, 12 Nov 2019 21:26:57 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720085.outbound.protection.outlook.com [40.107.72.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D196EBF3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 21:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4BVMfxczQxMEoRDAG3fwIk40mkFf21j7tE1jAc7haFur6H3fM57UswOmDXYT0mM9OP7hRQ6RT/6BLzeGqOEVw5mJ0whwwaA0Z8EYD0DzkWSkDDlPrqGVvh+OrKegshHzP55lncJ8twCcsyd1iAgJHYs5bckk4hh6WUnPRruoVzzWYDWCx5e2Rk5okN4J3EUdQw3BaxSJrvBPo/6Qjy0Aqk48Q0ikmwnhC4NonfnA04r0/saa33lkirbLaWoTtd8LmgTA0YJFOXu2tgZzrKzlULh3KTx8WwedAeIHdMlmKxx0gmiawIqhZMJ1iwuj1SdY3ecIrw20gpCHlL4auu0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3trUSGMphifyegkpL+ML0WDXALcvA99mV8cQ+pOkKg=;
 b=A80Iz6BphKX/qsyrcTsKHP3ixROjsW8uCaYabb5xF8jG8CbOYcDi5tjYxIYAAPc2Dn/wMCP9+WYOJPeV4g9JgzZFMdMhAV40e+OGCBpsn3prOhQmDP+5n7Fwh0Zi2iCbDQVtLh8Y3lV4WmdvaSuLOEv4v/6Ku8IfrZTMMEtURYTqDAXpnrXTTtnXhzdeDUH3R5T9W49tH6Qdfv2mKTRfwsnVWNY8Y9+6Rv63ltlHPp4+n1E5ASMUfDPCmMatdiU3Rri1zEyduSmkDLsgreelnanhees2MNj61mH2h0USZ2V4S5SumFCFlU4nqmxMaLghrYkRUy93I0mWfB2/hjmktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3723.namprd12.prod.outlook.com (10.255.172.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 21:26:54 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 21:26:54 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdkfd: Use QUEUE_IS_ACTIVE macro in mqd v10
Date: Tue, 12 Nov 2019 16:26:40 -0500
Message-Id: <20191112212641.4643-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::15)
 To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4bce3cd6-1e2a-4c6d-b83f-08d767b70a08
X-MS-TrafficTypeDiagnostic: DM6PR12MB3723:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3723305E0D2666022202E7A7F0770@DM6PR12MB3723.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(4326008)(66476007)(6512007)(2351001)(47776003)(478600001)(6666004)(66066001)(51416003)(52116002)(6916009)(14454004)(305945005)(7736002)(486006)(476003)(386003)(6506007)(2616005)(186003)(26005)(25786009)(14444005)(2361001)(36756003)(86362001)(3846002)(6116002)(99286004)(16586007)(66556008)(66946007)(2906002)(8936002)(50226002)(6486002)(81166006)(81156014)(6436002)(8676002)(50466002)(5660300002)(1076003)(48376002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3723;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1LWa5955jH91SD/58bJDIIw9M/Iptgn/1bZDkOK6b3lENma2kamXW+SoqAoq5MWHT6cUtJgTyshBMjwO0oSfSjQDtMXDyBgiGE6ciH+XLDXtKnNET1NWNeXCMS6+50SSiiv8IXFDUm82frTD8E31Sn/YRJnapbrZ0ge3ujRUVFn33Lm7/sQ9iU1eeX8FNPDxHu8IYdlD+Un3bhss5Af3obpOZYlrQICbbrNACTumhux3CmsaxgFafCTnqVcJw1okYIfpCpTG/DxVziTOT6KF19qIoAOKVn8YL93T4iw3syZ9/VE2S1w4Qsu5e8Rp0i4EyewZ1TNqq1dimIeiaFEcjNfeTvc/E7FXvuL4V1VO9ORMXzvwpj8E7y4yd0WlmAXyo31JzICNa44Epb9WMESIk39CaGItYwzTpH9sitgJ4LgaexYQm0eKQg8c0yxHrfz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bce3cd6-1e2a-4c6d-b83f-08d767b70a08
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 21:26:54.3482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkgRIIldXG9d7kXeSrCQPopBhiXcaaWBJiKJXjC3tvg5OrmA4wQxDfPCxzxSByC1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3723
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3trUSGMphifyegkpL+ML0WDXALcvA99mV8cQ+pOkKg=;
 b=xrG57REqpPsMntDSMHCNoFFhaw3Mpn4cbLHR+5vJnFXokwYrnL2AZrwMwsqttkOrpt3/1zr2sT6TJYdL/aF/tVQMe2Fl40i15ywtWV/kd+oqfelGfVnDh+4XgLCgpKi0NjW9hcLSp1kh2M7hTnHH26V7MVlCQ4JNjEvcXY6JAqM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112212640.BKJ9-kMTi4fIkcX1rv0YbX-kG7yj6tGsxRk8KIKYOKI@z>

VGhpcyBpcyBkb25lIGZvciBvdGhlciBHRlggaW4gY29tbWl0IGJiMmQyMTI4YTU0YzQuIFBvcnQg
aXQgdG8gR0ZYMTAuCgpDaGFuZ2UtSWQ6IEk5ZTA0ODcyYmUzYWYwZTkwZjVmNjkzMDIyNjg5NmIx
ZWE1NDVmM2Q5ClNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jIHwgMTEg
KystLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5h
Z2VyX3YxMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Yx
MC5jCmluZGV4IDk1NGRjOGFjNGZmMS4uNDZkZGIzM2I2MjRhIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jCkBAIC0yMTMsMTAgKzIxMyw3
IEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV9tcWQoc3RydWN0IG1xZF9tYW5hZ2VyICptbSwgdm9pZCAq
bXFkLAogCXVwZGF0ZV9jdV9tYXNrKG1tLCBtcWQsIHEpOwogCXNldF9wcmlvcml0eShtLCBxKTsK
IAotCXEtPmlzX2FjdGl2ZSA9IChxLT5xdWV1ZV9zaXplID4gMCAmJgotCQkJcS0+cXVldWVfYWRk
cmVzcyAhPSAwICYmCi0JCQlxLT5xdWV1ZV9wZXJjZW50ID4gMCAmJgotCQkJIXEtPmlzX2V2aWN0
ZWQpOworCXEtPmlzX2FjdGl2ZSA9IFFVRVVFX0lTX0FDVElWRSgqcSk7CiB9CiAKIHN0YXRpYyBp
bnQgZGVzdHJveV9tcWQoc3RydWN0IG1xZF9tYW5hZ2VyICptbSwgdm9pZCAqbXFkLApAQCAtMzQ4
LDExICszNDUsNyBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfbXFkX3NkbWEoc3RydWN0IG1xZF9tYW5h
Z2VyICptbSwgdm9pZCAqbXFkLAogCW0tPnNkbWFfcXVldWVfaWQgPSBxLT5zZG1hX3F1ZXVlX2lk
OwogCW0tPnNkbWF4X3JsY3hfZHVtbXlfcmVnID0gU0RNQV9STENfRFVNTVlfREVGQVVMVDsKIAot
Ci0JcS0+aXNfYWN0aXZlID0gKHEtPnF1ZXVlX3NpemUgPiAwICYmCi0JCQlxLT5xdWV1ZV9hZGRy
ZXNzICE9IDAgJiYKLQkJCXEtPnF1ZXVlX3BlcmNlbnQgPiAwICYmCi0JCQkhcS0+aXNfZXZpY3Rl
ZCk7CisJcS0+aXNfYWN0aXZlID0gUVVFVUVfSVNfQUNUSVZFKCpxKTsKIH0KIAogLyoKLS0gCjIu
MTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
