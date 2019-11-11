Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB557C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 23:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B0721655
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 23:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B0721655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F026E33F;
	Mon, 11 Nov 2019 23:25:41 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730058.outbound.protection.outlook.com [40.107.73.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A13C66E0C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 23:25:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euHnVpny7zjkoz0Ct5woJl40pLL2B0OVw5sBoUSM0WzLNqE4HA8nMJG1gadQtDs8BDBhuFJnUS3ISe5iRbjEBmpcbLifpx9/57Cz8102W0kwMVxjqkoZm7Atn9sXm88ft7DuA0pakCOgzNPq5+N8Fk+3KxKkayuEWM9Tt3VWuVByftmepw1udMuWUYuzWyCCWQ/OU2zrL+P4UZVgCw6N4IplxVB4hEqLoAt2v0n6eKcc8Xw5FVB+XtDJKy4S4LaK8i9yQP9U/ao4FDcFgQmzZGYHFGoswDsq7NAbKkqE5MDTTjd036BeOdM1Rh06qFTNw6vqLT8SemQbQ66fbTgmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHMYjs6S0cAIsL+zIPgNllU9mhMhWl0eEN7BIN66pyM=;
 b=ib6FL11J7eKqiqrUo2AyjpKe24GEXJX/n302RWptTfbvWZvTYngTj8j8ISduzR9YE4yev2DBV8bj5VaHMklCOImZuSuOlSAt4ySkOl6WAsHSoLqPkn51xFSnNlwFPD/GNzX5ba6v3qTw7Snb8574d3XAV9ujOA51psSd4Fe27BbAMlXDTm3mcKd25lDrUhtNsFkQyhv1OQRASX21lG2daE1ywkTesASjskoVHEvL4hIpkVxHmqj+tEHQTIvQtKO9368zw8IpxvKF5BiH0QwtO6FrxS2UCryfr/+qanCScvDYMIVmMs+rnYM3tg6B3WS3xHv/4OhzEP4LXx3H94VUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3452.namprd12.prod.outlook.com (20.178.29.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Mon, 11 Nov 2019 23:25:38 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 23:25:38 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Jay.Cornwall@amd.com
Subject: [PATCH 1/3] drm/amdkfd: Implement queue priority controls for gfx10
Date: Mon, 11 Nov 2019 18:25:19 -0500
Message-Id: <20191111232521.10528-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16)
 To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab9d9726-83f5-4dff-6878-08d766fe7615
X-MS-TrafficTypeDiagnostic: DM6PR12MB3452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34527D194B2DBCD57B2F131DF0740@DM6PR12MB3452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(189003)(199004)(6116002)(14454004)(1076003)(6512007)(66476007)(25786009)(7736002)(305945005)(66556008)(66066001)(3846002)(47776003)(4326008)(36756003)(66946007)(50466002)(6486002)(486006)(6636002)(50226002)(48376002)(478600001)(6666004)(81166006)(81156014)(8676002)(99286004)(6436002)(14444005)(86362001)(476003)(8936002)(2616005)(316002)(26005)(6506007)(386003)(5660300002)(2906002)(16586007)(51416003)(52116002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3452;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhN9CX+/7jtkM1Lei4m1EBC5il/QlJYGAaPLkmQcXV+q4eXk0Frori0igrhpNB6sHo+9E/ZaON08LH9Hl5YtX873SybCPjWTZXK4xCbbQvgp5Gg5CrrSxp0yiOM0vgwtiEgz/ooa1drI59Icm/NLFPxCMwiEE1w4sPViHmg5EmrgJxa/x4Xo8agtgTfDo5uO/b4zsfCsXXCIp1/e/3ylnqXQSDSHTzEkTfwOiJQMdMlLvxwTwg2ZZSN3qf4P8n6fUGMqmX6UxR6VIp0hn4mG5L1Hm2Pp7ILoo5CSbRfFJPfMDG9Amp/eSpTzgvnmyWV8/NU3YPbZ3jRpX9zfVqlVWxulSjzNQvNWH5Hp/uiDPIrJBYrHgGiXlRazRuSvsN8SGHeuCWwG6LAUy2l3HKqf9RpUdD+fxRxmeoGxbc53ID/7kwhBlt488c+32OmAzz0H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9d9726-83f5-4dff-6878-08d766fe7615
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 23:25:38.6894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UszDa/ngpsahzu/ynup9MMBQ7tTMY5pH02viXaOoA8jk6YEMl+uZssL4qNTzj+3x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3452
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHMYjs6S0cAIsL+zIPgNllU9mhMhWl0eEN7BIN66pyM=;
 b=TVZT13KRoqmD7p6+uuSNqqm1PUQQktsGEF8SxDCThZpkBNlgIGIkr4P3uA4f/EniOJ/keDs7ARVo8AMODLiEwzeKMKlJWDgJS6T0Dx8srHQ+M+4C3MXb0Wpf35+cQ/crf4MbqmvC28H9i8F5LSxetSDnYnymSbOdrkEfak3j44w=
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
Message-ID: <20191111232519.PGsQZNcIGGnr2VIscuxPB-J71D6Imr6aiWYK7KhdMtw@z>

UG9ydGVkIGZyb20gZ2Z4OS4KCkNoYW5nZS1JZDogSTM4OGRjN2M2MDllZDcyNGE2ZDYwMDg0MGY4
ZTczMTdkOWMyYzg3N2QKU2lnbmVkLW9mZi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMg
fCAxMCArKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRf
bWFuYWdlcl92MTAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdl
cl92MTAuYwppbmRleCA0YTIzNmIyYzIzNTQuLjQ4ODRjZDZjNjVjZSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYwpAQCAtNjYsNiArNjYs
MTIgQEAgc3RhdGljIHZvaWQgdXBkYXRlX2N1X21hc2soc3RydWN0IG1xZF9tYW5hZ2VyICptbSwg
dm9pZCAqbXFkLAogCQltLT5jb21wdXRlX3N0YXRpY190aHJlYWRfbWdtdF9zZTMpOwogfQogCitz
dGF0aWMgdm9pZCBzZXRfcHJpb3JpdHkoc3RydWN0IHYxMF9jb21wdXRlX21xZCAqbSwgc3RydWN0
IHF1ZXVlX3Byb3BlcnRpZXMgKnEpCit7CisJbS0+Y3BfaHFkX3BpcGVfcHJpb3JpdHkgPSBwaXBl
X3ByaW9yaXR5X21hcFtxLT5wcmlvcml0eV07CisJbS0+Y3BfaHFkX3F1ZXVlX3ByaW9yaXR5ID0g
cS0+cHJpb3JpdHk7Cit9CisKIHN0YXRpYyBzdHJ1Y3Qga2ZkX21lbV9vYmogKmFsbG9jYXRlX21x
ZChzdHJ1Y3Qga2ZkX2RldiAqa2ZkLAogCQlzdHJ1Y3QgcXVldWVfcHJvcGVydGllcyAqcSkKIHsK
QEAgLTEwOSw5ICsxMTUsNiBAQCBzdGF0aWMgdm9pZCBpbml0X21xZChzdHJ1Y3QgbXFkX21hbmFn
ZXIgKm1tLCB2b2lkICoqbXFkLAogCQkJMSA8PCBDUF9IUURfUVVBTlRVTV9fUVVBTlRVTV9TQ0FM
RV9fU0hJRlQgfAogCQkJMTAgPDwgQ1BfSFFEX1FVQU5UVU1fX1FVQU5UVU1fRFVSQVRJT05fX1NI
SUZUOwogCi0JbS0+Y3BfaHFkX3BpcGVfcHJpb3JpdHkgPSAxOwotCW0tPmNwX2hxZF9xdWV1ZV9w
cmlvcml0eSA9IDE1OwotCiAJaWYgKHEtPmZvcm1hdCA9PSBLRkRfUVVFVUVfRk9STUFUX0FRTCkg
ewogCQltLT5jcF9ocWRfYXFsX2NvbnRyb2wgPQogCQkJMSA8PCBDUF9IUURfQVFMX0NPTlRST0xf
X0NPTlRST0wwX19TSElGVDsKQEAgLTIwOCw2ICsyMTEsNyBAQCBzdGF0aWMgdm9pZCB1cGRhdGVf
bXFkKHN0cnVjdCBtcWRfbWFuYWdlciAqbW0sIHZvaWQgKm1xZCwKIAkJbS0+Y3BfaHFkX2N0eF9z
YXZlX2NvbnRyb2wgPSAwOwogCiAJdXBkYXRlX2N1X21hc2sobW0sIG1xZCwgcSk7CisJc2V0X3By
aW9yaXR5KG0sIHEpOwogCiAJcS0+aXNfYWN0aXZlID0gKHEtPnF1ZXVlX3NpemUgPiAwICYmCiAJ
CQlxLT5xdWV1ZV9hZGRyZXNzICE9IDAgJiYKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
