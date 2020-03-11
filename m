Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D821C0044D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 20:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5E92074B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 20:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IQJ3L0n3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5E92074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A7226E9FE;
	Wed, 11 Mar 2020 20:33:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D62A86E9FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 20:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmN3wEIq4nMjjSgUg1t8eIoZbpO7mjlOLf4KgT++HZXvumX6/CBwRa/Izmr4bMbbCi9qJ0VMRXhKO4YCRWMG7AKjDEEbdS0L01S4T+QqSt8fx3RrvUXo2L1VHAV8l2YV4cetPcOxP3D5t1z/t5jev0Pcv/29Bq5sGLR/lpdb4Upl+XeCQHyNfER1qU46/yLY47Fvt6Fd/iMDJ3K2XwIKWQ7VbM+vRzZwGsWyXjlTvomfD0c8y8EdBYl07PHsWNUcskBxYL5Y8FKeWKrRHdZxpqlkxUeWrQjVJbK2sBXPyqs/w8Tn6BSfKyLZi5zvd+HqcHSgbvF+aRfnwKqfrp5VWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2RIqGY1AFbkWtBfzb0V0zIglfNsdcmZClhOnXU7W/U=;
 b=WaYIxiqEDbYLxi83PaK6ZLpZ66eTvlHEVm80asBLv3hVIIRxjDHh+DTX7nAu8FcpYqgotizhAB8AMRpEFo0pOK+8Yp0kPg6UNjLAT0K47KdS6mtVfuGNgOAR/B/QRZ4BXMeGewjmxrEJaRG3/bTUsSVTnJvH+qF8PoGq6oFX7EX+ehthnRFAYr8FxRJMH5nq7RDiUPKAh2GIf6lCV9Yf0w8hsMFJ2PzY/iKALWS9E8TeOTO99o/ZDg9JtTjrGfV1p3WiJ6cau9II5okwbBVTXEYaxqbNrlUvm4Unoqu5B5StWwsiTgzd8qiMV1j8tDbjmx5Gb+/dXc/A89X6dPLyvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2RIqGY1AFbkWtBfzb0V0zIglfNsdcmZClhOnXU7W/U=;
 b=IQJ3L0n3faoT2XYWm1nV2C2C+xJMd9RqtasVkdNM8/hAbVInghfDu3y4gTwohHg8dFjMBdVoL9jmYQ1Zag7CrghpBXlOMXhYklsjkycAbINKZTKzoW6EQSqEQTRUAfgHtB0gJnAdv+0BG6brJLNCxiVipxdJFi9eEvl5RpTPQYg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (2603:10b6:208:168::31)
 by MN2PR12MB3535.namprd12.prod.outlook.com (2603:10b6:208:105::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Wed, 11 Mar
 2020 20:33:32 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 20:33:32 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Fix GPR read from debugfs (v2)
Date: Wed, 11 Mar 2020 16:33:21 -0400
Message-Id: <20200311203321.149060-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: BN6PR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:404:4b::32) To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 BN6PR11CA0046.namprd11.prod.outlook.com (2603:10b6:404:4b::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 20:33:31 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4990a64-43b6-4648-b437-08d7c5fb76e6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3535:|MN2PR12MB3535:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB35351A2608AF2578634667ECF7FC0@MN2PR12MB3535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(199004)(5660300002)(316002)(16526019)(186003)(86362001)(6486002)(66946007)(66574012)(6916009)(36756003)(2906002)(1076003)(66556008)(54906003)(26005)(8676002)(4326008)(66476007)(8936002)(81166006)(52116002)(478600001)(2616005)(81156014)(7696005)(6666004)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3535;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npCyw3qvK2YWdGgsc/gmPdjzPDzumA6ZR4a7ahrgADCxVJo/WN+cv0ZqEhGp6lJrkaEakkTMmt+Nud7hgqlYI3+jPIwy+sW4zEXryp+s3UNwWZwW2AHuDKP5WtaRqh+zhJ52/3fBVOmfb5utSOiV7UMKLsXyApN9rHEwhnCIH16EwFLWy2KTzZ9moL3eyCojha6P4qXjI8M61lP2aJLW91opez7tm6QxmEPSW99e0oPbp3VBv92wvC7ygtilYRxHJxLpJVwvvLA2H9Y8E41wSfr5cMCfMrB1+vlShaRPFhgH0zQq/SI+n8hEntXovJ4UHYOMEepwXDUxV2IHLDRqJL8jtKOC5vOiTLg2+1AvEK/T9sHYkcblFrtAKuAEqbTF7Kg8WjEyZg4YCzH2IdbwYK4jQ30Md67xC7bH0IAZzJ+nEo7ESf7AYOmpCwnORsDt
X-MS-Exchange-AntiSpam-MessageData: h0egzCdQxVt5igQ7amGh35AwCJbLvx/gFg3WPWGOwRhAthcpRXkq8xeCI9dbrNp0MkNO4uHzDBEEB9CcbTOwnVjV1MJ6/4CrfLG1XFkih7TFlufa30wGC1Oda1B8EUzELv2vWLvq7aNoH6VYzD+n8Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4990a64-43b6-4648-b437-08d7c5fb76e6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 20:33:32.1546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/facpadR4bH6ds3Q/t6ddURKTuNZtOnQLL7cl1iLWs3xNA4wg2K3cvbbJqKKarZSAGPJEVeuKtvKQ214x9/1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3535
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
Cc: Tom St Denis <tom.stdenis@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIG9mZnNldCBpbnRvIHRoZSBhcnJheSB3YXMgc3BlY2lmaWVkIGluIGJ5dGVzIGJ1dCBzaG91
bGQKYmUgaW4gdGVybXMgb2YgMzItYml0IHdvcmRzLiAgQWxzbyBwcmV2ZW50IGxhcmdlIHJlYWRz
IHRoYXQKd291bGQgYWxzbyBjYXVzZSBhIGJ1ZmZlciBvdmVycmVhZC4KCnYyOiAgUmVhZCBmcm9t
IGNvcnJlY3Qgb2Zmc2V0IGZyb20gaW50ZXJuYWwgc3RvcmFnZSBidWZmZXIuCgpTaWduZWQtb2Zm
LWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+CkFja2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGVidWdmcy5jCmluZGV4IDAwOTQyYWZjNGUxMy4uMDJiYjFiZTExZmZlIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMKQEAgLTc4NCwx
MSArNzg0LDExIEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9kZWJ1Z2ZzX2dwcl9yZWFkKHN0cnVj
dCBmaWxlICpmLCBjaGFyIF9fdXNlciAqYnVmLAogCXNzaXplX3QgcmVzdWx0ID0gMDsKIAl1aW50
MzJfdCBvZmZzZXQsIHNlLCBzaCwgY3UsIHdhdmUsIHNpbWQsIHRocmVhZCwgYmFuaywgKmRhdGE7
CiAKLQlpZiAoc2l6ZSAmIDMgfHwgKnBvcyAmIDMpCisJaWYgKHNpemUgPiA0MDk2IHx8IHNpemUg
JiAzIHx8ICpwb3MgJiAzKQogCQlyZXR1cm4gLUVJTlZBTDsKIAogCS8qIGRlY29kZSBvZmZzZXQg
Ki8KLQlvZmZzZXQgPSAqcG9zICYgR0VOTUFTS19VTEwoMTEsIDApOworCW9mZnNldCA9ICgqcG9z
ICYgR0VOTUFTS19VTEwoMTEsIDApKSA+PiAyOwogCXNlID0gKCpwb3MgJiBHRU5NQVNLX1VMTCgx
OSwgMTIpKSA+PiAxMjsKIAlzaCA9ICgqcG9zICYgR0VOTUFTS19VTEwoMjcsIDIwKSkgPj4gMjA7
CiAJY3UgPSAoKnBvcyAmIEdFTk1BU0tfVUxMKDM1LCAyOCkpID4+IDI4OwpAQCAtODI2LDcgKzgy
Niw3IEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9kZWJ1Z2ZzX2dwcl9yZWFkKHN0cnVjdCBmaWxl
ICpmLCBjaGFyIF9fdXNlciAqYnVmLAogCXdoaWxlIChzaXplKSB7CiAJCXVpbnQzMl90IHZhbHVl
OwogCi0JCXZhbHVlID0gZGF0YVtvZmZzZXQrK107CisJCXZhbHVlID0gZGF0YVtyZXN1bHQgPj4g
Ml07CiAJCXIgPSBwdXRfdXNlcih2YWx1ZSwgKHVpbnQzMl90ICopYnVmKTsKIAkJaWYgKHIpIHsK
IAkJCXJlc3VsdCA9IHI7Ci0tIAoyLjI0LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
