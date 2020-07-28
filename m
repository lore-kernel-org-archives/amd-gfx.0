Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57371C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 10:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D2420775
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 10:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NaX4fQdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D2420775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82C189718;
	Tue, 28 Jul 2020 10:22:46 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750052.outbound.protection.outlook.com [40.107.75.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 599AB6E24B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 10:22:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2z1W6SEM7jVTm8U6WwNgACi8EploJWTgxPneYo5QN8YXYO6Bx21fLY1/sp+aLvQR3rGRSJhM6QFSAQ6Pwb0efHrQa9fJJC8D7DvFNg+hhc0zSr2VTlsbcxR3d4Ep4/UffrhAOohDud+EEylZOut2udACIOCDR5Bk0aLwZpEw2Pp7TjGa0lptVvvb8XM5AiUvHnzfj8+dzLlDFYumch87y8vZl8QrOEVFOUIHdPVgSfJFLik9QBzD+5nacZA5ZkH1HrXvdsHPd7b/gBZeXc8v0tEhNheqkl8eHcjGxh70gho0n/RNJo9T9znPX1Xqjof7wW7omuuyTFsjjGJBLq/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7osTbqjNgeYXAuON8e/bs4IeEdkjqHg6UksLLL3w6E=;
 b=GtBydXWIuJr2+YfIgEZPdRR9gJOUANJpkCM4UNaJ7OM5rOQO8k+u2M+MWW6LJYWztZUOpWgbqDs1TWgFuTwGXaJPcrjvoe2L5Vx1RobS9FGxb3TKKPYgNHnh0JnXzKC5BBeYtf97Lem1bPf0oprGmrBlZv1NDv2EzZChkP78+UEZAIdg6MIcTOkMxAF5dhHSKig4PIvz0MqQYO8dgF6iAagPVy//qvbNBOHumQ6Z8jlp9WE2TKUn3xCjy/2ZRK0rW4pts8vy0hoGOuDOTdfEGzrygeT1rPF114PcGD2OcXzoN8Eu4RqGss9nvTRJPk6dx/LgK11vQgEnoI1rubA3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7osTbqjNgeYXAuON8e/bs4IeEdkjqHg6UksLLL3w6E=;
 b=NaX4fQdBNzOiUduxVDPyOPNWiOjQ8R2fWpP/f1yiSxrGKFmKiCYOTNXAuru2Q0Kxdqn5iqeKF+eTxcTAzwmLcDXYji4q/f7uAzbNu/mA6wlXwrQFzMNrUVnZo3w5KVkD0y0fhh99ZOn9zE/SblzWTMrn/s8TdyxqpjC2uVwsZec=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB2471.namprd12.prod.outlook.com
 (2603:10b6:903:d0::10) by CY4PR12MB1847.namprd12.prod.outlook.com
 (2603:10b6:903:11c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 10:22:41 +0000
Received: from CY4PR1201MB2471.namprd12.prod.outlook.com
 ([fe80::3912:f141:7c9c:ea33]) by CY4PR1201MB2471.namprd12.prod.outlook.com
 ([fe80::3912:f141:7c9c:ea33%9]) with mapi id 15.20.3216.024; Tue, 28 Jul 2020
 10:22:41 +0000
From: Jack Xiao <Jack.Xiao@amd.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Hawking.Zhang@amd.com, Christian.Koenig@amd.com, Le.Ma@amd.com
Subject: [PATCH 4/4] drm/amdgpu: assign the cpu/gpu address of fence from ring
Date: Tue, 28 Jul 2020 18:21:54 +0800
Message-Id: <20200728102154.2505095-4-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200728102154.2505095-1-Jack.Xiao@amd.com>
References: <20200728102154.2505095-1-Jack.Xiao@amd.com>
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To CY4PR1201MB2471.namprd12.prod.outlook.com
 (2603:10b6:903:d0::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jackfedora30.amd.com (58.247.170.242) by
 HK2PR02CA0146.apcprd02.prod.outlook.com (2603:1096:202:16::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Tue, 28 Jul 2020 10:22:39 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 285b5450-22b7-4eea-127a-08d832e028ce
X-MS-TrafficTypeDiagnostic: CY4PR12MB1847:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18476D70FEF83D755AB289C5EF730@CY4PR12MB1847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c04dowIm9Alku8yWsRUriWaU6EXao+UHHyp5VCsYODcUT2tztL4Dt1hXve+9ecoHGqa/7KuURXCvs/XQx1qJb09/AlwRNOxh7CRnMstz4PviY3TbShNTGd78uXxw9DB7Tcxk/pZoq7Yn4boMTGLzYJaR5ScyM0d37hmQtRFGYJz67thNhX5Ac2eWjj/TxsNvQv588KyncTOr71N+kbN/fwPMlzcg8A3NFtNo3ogVsnqguNQoNV/cW5ngAYygkOO0MW3ZDqlYrmej+LAaqeLIdLeAca6Q1mNGBcXx/ZQEI8z7yuytbBY/YcKdkiXViqtCWLVVQCtFI8D/BlaZnfALYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB2471.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(26005)(5660300002)(86362001)(1076003)(6666004)(2906002)(36756003)(66476007)(66556008)(66946007)(16526019)(52116002)(7696005)(478600001)(4326008)(54906003)(6636002)(956004)(83380400001)(2616005)(6486002)(316002)(8676002)(186003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6P+pV5vokm0uG58X+gHRH0jKCLtlI4kATr+itkBm8+u6Gq1T0L/+LA/z+PFeUhjjJvurL0Td4yMMhyjHEMeaRHWJwQwwKCNufv8uarY0OCMvvnnd6jTGy8sTmEc7UFLbOd3S6CI6yTtEYT4KcfNAQpI05VXz4jR25u+fAqN4urA/C+b9p65I52ZFrVpE3nFwAny1kJNZUN6iIvwuiiMoWqSp1+S95eRSzjdzugQMsvVuvTqaXNy9V/zJgDYP2KXuVgqc+mUGM7HML7tPYBGYSQFwwGZwWr1HSqNBL94/MaA7yi10inH16O6aDQ1z+aYaOVVuPM7moy8OkDH6QYDJNKgw9dzqDHqtHU0nikWhuFdLEV83Lzo5/vdtm8CGEM9Gz2W8nGiDC6fVFbyh2HjR3eU6s+Fi2FekN9km5T3jZikG0n7uz2KxX4sytMYaPuAasyST2yNtkXiPeksruGiSd/4LtfTaXAVDRsy04YIf0rL1Wqe8Xo7GpBTJpnbElrmJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285b5450-22b7-4eea-127a-08d832e028ce
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB2471.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 10:22:41.6519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xK0nDh8gxpW/biT7aOuf9nKRLBKZCz64XlqlGRRIjYaCDVGmtxSEj3Mq8WQ1bzHn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1847
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
Cc: Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

YXNzaWduIHRoZSBjcHUvZ3B1IGFkZHJlc3Mgb2YgZmVuY2UgZm9yIHRoZSBub3JtYWwgb3IgbWVz
IHJpbmcKZnJvbSByaW5nIHN0cnVjdHVyZS4KClNpZ25lZC1vZmYtYnk6IEphY2sgWGlhbyA8SmFj
ay5YaWFvQGFtZC5jb20+ClJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5n
QGFtZC5jb20+CkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgfCA0
ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYwppbmRleCA1OGQ0YzIxOTE3
OGEuLjBiZTNlMjAwNzM4NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2ZlbmNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Zl
bmNlLmMKQEAgLTQwNyw4ICs0MDcsOCBAQCBpbnQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9zdGFydF9y
aW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKIAl1aW50NjRfdCBpbmRleDsKIAogCWlmIChy
aW5nLT5mdW5jcy0+dHlwZSAhPSBBTURHUFVfUklOR19UWVBFX1VWRCkgewotCQlyaW5nLT5mZW5j
ZV9kcnYuY3B1X2FkZHIgPSAmYWRldi0+d2Iud2JbcmluZy0+ZmVuY2Vfb2Zmc107Ci0JCXJpbmct
PmZlbmNlX2Rydi5ncHVfYWRkciA9IGFkZXYtPndiLmdwdV9hZGRyICsgKHJpbmctPmZlbmNlX29m
ZnMgKiA0KTsKKwkJcmluZy0+ZmVuY2VfZHJ2LmNwdV9hZGRyID0gcmluZy0+ZmVuY2VfY3B1X2Fk
ZHI7CisJCXJpbmctPmZlbmNlX2Rydi5ncHVfYWRkciA9IHJpbmctPmZlbmNlX2dwdV9hZGRyOwog
CX0gZWxzZSB7CiAJCS8qIHB1dCBmZW5jZSBkaXJlY3RseSBiZWhpbmQgZmlybXdhcmUgKi8KIAkJ
aW5kZXggPSBBTElHTihhZGV2LT51dmQuZnctPnNpemUsIDgpOwotLSAKMi4yNi4yCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
