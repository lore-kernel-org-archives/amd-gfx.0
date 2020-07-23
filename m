Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D0FC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F363A2084D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kyIntst7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F363A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66DF6E866;
	Thu, 23 Jul 2020 08:34:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E5A36E866
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 08:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amjpotSINSW/lZupOyVeU8C2114UPPR11VvGP2JI10OrepHKf5cxsm1qAIu3Nw7liLrUE2N+63JyNHWrtsfAKMbQHjmqmDH3bYGdkzSk33RgzimH7+5Xs69aK4hz0JXM7DUcK1t+M+W+1PaI9q4alI4clOYUxCVGv6cquGN9hzV6g2T3yUkYip4f4+1Mv8GZajER2F9ijaB4cqQ56l8kRhiXJjZXbJ8eeJc0IuAZD6Lae9Hyf1zchuh6dw5KK6nZoWhQy3UAieADOwSJizk2DeTgsSL/Leys5rSmrowZx+KSf+8mhrWGqQ5VJ7dpHc2vOrdQph8S26r0plSwjbGSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5r2O6JfzOI57RNulbexZIwN6gXYELplBvurx9XSxUGU=;
 b=B0KmY+WE+cv9bee9giQFrDoxBnrd/5ra823Ys4ZEf61odylRA4FaE7r+MHIzznylNaoniXlhh1pRS1w82QrxuQjE8FGBwh7tfSx3tE2fCPBPYHt0+8/WKLOgjj7DVH2Oov9k28ci3vedHM5hX3xIRW7yLA+BAY4vi53p21HUFSb6czUyhx/ATzhE3CQEG1U/cBTY+cbCcFfOD61ujKn4PwvS59nQ1yiKDB/6OxuQSGUqqKkJx8gWZ3P8yLwGM0kHfPF7vysR0s5+f7s1eg9fn7YnzXCGvZigrzTiREjMyDQRIMtbyuvv+hEJ59Ty9U2tSvN5vXJsepUqjDuix7RvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5r2O6JfzOI57RNulbexZIwN6gXYELplBvurx9XSxUGU=;
 b=kyIntst7B95qYkLoYmCU9d6pkVVKwAYScsOezGUcBnQTqj+Z+Hai88k7mj/56Ytb5aJQD3H36elfVIKio9aaF99WPm9HCh9b1Ra+5xECBTHgau/w94wP8phPejrN05plWRoO0r+Q3YO+HQ2zEUKEVqWKH9cRRpYAkPjn8qNjYxA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0005.namprd12.prod.outlook.com (2603:10b6:903:d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 23 Jul
 2020 08:34:16 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.024; Thu, 23 Jul
 2020 08:34:16 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Stanley.Yang@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com
Subject: [PATCH 3/9] drm/amdgpu: add bad gpu tag definition
Date: Thu, 23 Jul 2020 16:33:40 +0800
Message-Id: <20200723083346.8743-4-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723083346.8743-1-guchun.chen@amd.com>
References: <20200723083346.8743-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR03CA0105.apcprd03.prod.outlook.com (2603:1096:203:b0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Thu, 23 Jul 2020 08:34:12 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b930158a-0e79-44ee-6883-08d82ee32efd
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0005:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB000580F62253F24135ABE635F1760@CY4PR1201MB0005.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYg0aBJ/5IN3YsAFMOKLjfz9Wb4IdOWKw2tVwDQWcRGrbPXLjfOP61lUyU6jRa/s4eVrU0U+KDfvQ+14+hcPe/mbcA2LflvE+r8ZFg/FhbYFPSPlsknNOYugTsjK8eCwYnArhcBq/Y0LNQTcMZEqQxuwDvqZDWdY0mBDEpK3TmyyJzXUzpEZnNWnqZ+8mLoWg+hIoJo+RVYkowU7y71eRfKT5Sypz5R5Dwwgtp/CxRF5InRopC/FZTIb7FY1GsHuvsofW4dfXeyNgjGMvzoPiZb1r6RUtQhgvUCUEAyeoe0Zw6NnybwGWYGeFUgzme74
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(8936002)(316002)(2616005)(36756003)(2906002)(16526019)(186003)(8676002)(6486002)(44832011)(4326008)(956004)(26005)(7696005)(4744005)(478600001)(52116002)(5660300002)(66476007)(66556008)(66946007)(83380400001)(1076003)(6636002)(86362001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oX9sEjxDoJDPBb++Yb6/79IXttbxLBzkTd+L/xhvMpKIGnRKIyjd03mdszoXlZ8wJK5OPlxUFfLXJRd+hVPg0HwIZ0IBPcr57xsKcAWdr/GfDhFkK0Y6Evc0agjmxMJ7sC8+1r0GFkuJDvQBhcnde2p9PnDub7siha1gYbOuA6cCcrDeBeYvD3yEXO3x6E2W1mTPVdq+sBeJBjzF+NcitVdd2GpNrfM+Xi0Am2gjxRf0jhgCYtdYDkSxluFlS//Ve8Syvc41KM0stCMFQU09HTPVfbdzpH6hGcaQcJOYOQDssihTRnNI4lfusIYWBXUnyg9/OkEVCMAUap4PCtyl049qInwX3wNIlrr7uaX4nI+FlhIgOsl4YBVlNLvkMbAELJ68JDhakHCx1tHjtOAeGNdp+5sDZj5pqfHlu0srcuQvesw3GsBioNf6HCNGwwCeG9JY3UYylf86en7KKXqG5hp6Z2xWe5LBw0Uy2fNBIAv56c5S4dhfkT4Z3UcS9OO/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b930158a-0e79-44ee-6883-08d82ee32efd
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 08:34:15.8736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NjmS3l6dJabIPv7sPyi1VixRDvNUDo8kOBZ42zTSXqpvV7mXjWDyKKFHw1hrOWo/B45VWxVDLLlx1Jjw1xHIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0005
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyB0YWcgd2lsbCBiZSBoaXJlZCBmb3IgYmFkIGdwdSBkZXRlY3Rpb24uCgpTaWduZWQtb2Zm
LWJ5OiBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmFzX2VlcHJvbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jhc19lZXByb20uYwppbmRleCBhMmM5ODJiMWVhYzYuLjM1YzBjODQ5ZDQ5YiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jCkBAIC00Niw2ICs0
Niw5IEBACiAjZGVmaW5lIEVFUFJPTV9UQUJMRV9IRFJfVkFMIDB4NDE0ZDQ0NTIKICNkZWZpbmUg
RUVQUk9NX1RBQkxFX1ZFUiAweDAwMDEwMDAwCiAKKy8qIEJhZCBHUFUgdGFnIOKAmEJBREfigJkg
Ki8KKyNkZWZpbmUgRUVQUk9NX1RBQkxFX0hEUl9CQUQgMHg0MjQxNDQ0NworCiAvKiBBc3N1bWUg
MiBNYml0IHNpemUgKi8KICNkZWZpbmUgRUVQUk9NX1NJWkVfQllURVMgMjU2MDAwCiAjZGVmaW5l
IEVFUFJPTV9QQUdFX19TSVpFX0JZVEVTIDI1NgotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
