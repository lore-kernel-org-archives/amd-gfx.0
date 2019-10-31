Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB6ECA9EC7
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 00:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650962067D
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 00:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650962067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 139BC6EBC0;
	Thu, 31 Oct 2019 00:17:54 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820070.outbound.protection.outlook.com [40.107.82.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF116EBC0
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 00:17:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwzWLnxCVuvWsaTggPQ/TSSxryceM9xGspzUiEsZE62Mi3BXn5kh1jCCJ5wCtHLvJx0iOdcQiZ8NETUyYm/NehEZFkViEVtPyRGJUROxoGBUxYjEz0baWPSBqnqVhpnEevrG3XQsgaYO04Y+54LheqlTWE1IC5YOFUGUWDdTYXCJvp5spVRDbH8LW/cYxHoGiWK3VuoLZMkT7DQ7cQR3r00jc40/Eufvh4Yoh789+qEIl2UZmnRacKrwSe1tXBfceHHp15/5oh5WNOxnqEuf8Vj+gkLqKkPim70uh3nZxD1dx+VrbAfStF8TvxjtLFbFzH2eTVwyOq1mXGfixvzCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ycogz1N2SL2Fzj8iF/bkIREXNm9dhoXDChSoB/erDus=;
 b=IPaPo6heabqM8lgS4mv62wpTtsz4lGS7iBWT4MveY7yFJ+6nK9p7Zzfx/ORC6YN0eDxtcIw/XxvFzUY8nydU9uosppiz+6b8jigdbwifnmxBaWpP7nQnTNV5bBjzvp3eQNxD4cDgDyxQEoB2I5QllZwFyu3nRmM63NSEA9G0rj7CYa4of5TllMK2+GUxdAXGQ2MlOI8H/7nSQll+vRPUGv1ALpiCj+pAJdNV36vZgATFiGtPbpSPT/HOSjOFDdE4L9l6InigYEs71OytwRKTw1tnNNKP77ughJVRmY1g1B5C+7HwtIOv6YePx4EQTGUWalxCIuYTQWlHYtlH9A6jYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB2747.namprd12.prod.outlook.com (20.176.116.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 31 Oct 2019 00:17:51 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e%7]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 00:17:51 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdkfd: Adjust function sequences to avoid
 unnecessary declarations
Thread-Topic: [PATCH 1/3] drm/amdkfd: Adjust function sequences to avoid
 unnecessary declarations
Thread-Index: AQHVj4CheoGk4fpIk0CN5w2HS0ar8g==
Date: Thu, 31 Oct 2019 00:17:50 +0000
Message-ID: <20191031001739.10764-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::28) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4be2233d-d995-4fb1-8b21-08d75d97c40e
x-ms-traffictypediagnostic: DM6PR12MB2747:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2747DE5B995D9EAFC1FED5A3F0630@DM6PR12MB2747.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(189003)(199004)(99286004)(66556008)(66476007)(6512007)(6506007)(486006)(6916009)(66946007)(64756008)(66446008)(71190400001)(71200400001)(2351001)(102836004)(305945005)(386003)(3846002)(6116002)(2906002)(5640700003)(4326008)(7736002)(52116002)(14444005)(8936002)(66066001)(2501003)(316002)(6436002)(50226002)(25786009)(86362001)(6486002)(14454004)(256004)(36756003)(5660300002)(476003)(2616005)(81156014)(26005)(186003)(1076003)(478600001)(8676002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2747;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QpThxzF9xpsUZM5nJnCS5YaHxuTtmlRslkTEKreLE3Ff9x+ET1bhjU5dFZ/fBjQUxwV07cEevCc8AAthS609Mcg9hSDLBJTaSilAay+4o+UHjuWxD8LujProMGH0LRWoFZPMqCF3rHcoLtvcw4T4Pmg4pp8d1cMQukYSyxD9sHi0sJb7+0gldBRf0RROVwuX6disFvr77biCI0f4bSDOiBbee7emjPIvie2OTsklnchgJpGHndTf2RhXB1tNfY0MzcTkoMOL1TjW1XWFE+uYbMNGfTvubucDu2/k3F37hBwjS+FPrxOZaAlpJAIg7ZEePYhHw8Nx8uTAN+rSateajfpJlGMNB34DSOJAmynm0yaQ3Mz13ml6oY7Qze2U8K79zt1GZw2d07981i+lykIMi1+5E7rsBFTbZ+j1YVQmtvmos0jUr1QfCNwZZMA8aAly
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be2233d-d995-4fb1-8b21-08d75d97c40e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 00:17:51.0274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DnL6qqdCz5pH5xGq0byur+NFfKdtMSpnU/O7NaCtMSByNRhmxUggES/REHwJmkFX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2747
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ycogz1N2SL2Fzj8iF/bkIREXNm9dhoXDChSoB/erDus=;
 b=WTpZTvXUXOkxZQuTZhNyHDlNzmpqj4njkBZdQOIn+zmXloNOTlN/k0PP3o4gLa2cn+Tk+lJrpn4Tq6sLNWjEWcdrDe6n0CW/KJDqjsArDzY0tcRe+t8ZkJVZWgkGuS1cMW7mA5NCZnbL9zTTo6MpFtcVqF/EmqWHtKbtB64sm/A=
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
Cc: "Zhao, Yong" <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031001750.gB69Z4VJndF3Y5FUsBED7dmWVjluxvLvZtFxY2dD9L8@z>

VGhpcyBpcyBjbGVhbmVyLgoKQ2hhbmdlLUlkOiBJOGNkZWNhZDM4N2Q4YzU0N2EwODhjNjA1MGY3
NzM4NWVlMTEzNWJlMQpTaWduZWQtb2ZmLWJ5OiBZb25nIFpoYW8gPFlvbmcuWmhhb0BhbWQuY29t
PgotLS0KIC4uLi9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZV92OS5jICB8IDE5
ICsrKysrKystLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9rZXJuZWxfcXVldWVfdjkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJu
ZWxfcXVldWVfdjkuYwppbmRleCA5YTRiYWZiMmUxNzUuLjNiNWNhMmIxZDdhNiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZV92OS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWVfdjkuYwpAQCAtMjYs
MTggKzI2LDYgQEAKICNpbmNsdWRlICJrZmRfcG00X2hlYWRlcnNfYWkuaCIKICNpbmNsdWRlICJr
ZmRfcG00X29wY29kZXMuaCIKIAotc3RhdGljIGJvb2wgaW5pdGlhbGl6ZV92OShzdHJ1Y3Qga2Vy
bmVsX3F1ZXVlICprcSwgc3RydWN0IGtmZF9kZXYgKmRldiwKLQkJCWVudW0ga2ZkX3F1ZXVlX3R5
cGUgdHlwZSwgdW5zaWduZWQgaW50IHF1ZXVlX3NpemUpOwotc3RhdGljIHZvaWQgdW5pbml0aWFs
aXplX3Y5KHN0cnVjdCBrZXJuZWxfcXVldWUgKmtxKTsKLXN0YXRpYyB2b2lkIHN1Ym1pdF9wYWNr
ZXRfdjkoc3RydWN0IGtlcm5lbF9xdWV1ZSAqa3EpOwotCi12b2lkIGtlcm5lbF9xdWV1ZV9pbml0
X3Y5KHN0cnVjdCBrZXJuZWxfcXVldWVfb3BzICpvcHMpCi17Ci0Jb3BzLT5pbml0aWFsaXplID0g
aW5pdGlhbGl6ZV92OTsKLQlvcHMtPnVuaW5pdGlhbGl6ZSA9IHVuaW5pdGlhbGl6ZV92OTsKLQlv
cHMtPnN1Ym1pdF9wYWNrZXQgPSBzdWJtaXRfcGFja2V0X3Y5OwotfQotCiBzdGF0aWMgYm9vbCBp
bml0aWFsaXplX3Y5KHN0cnVjdCBrZXJuZWxfcXVldWUgKmtxLCBzdHJ1Y3Qga2ZkX2RldiAqZGV2
LAogCQkJZW51bSBrZmRfcXVldWVfdHlwZSB0eXBlLCB1bnNpZ25lZCBpbnQgcXVldWVfc2l6ZSkK
IHsKQEAgLTY3LDYgKzU1LDEzIEBAIHN0YXRpYyB2b2lkIHN1Ym1pdF9wYWNrZXRfdjkoc3RydWN0
IGtlcm5lbF9xdWV1ZSAqa3EpCiAJCQkJa3EtPnBlbmRpbmdfd3B0cjY0KTsKIH0KIAordm9pZCBr
ZXJuZWxfcXVldWVfaW5pdF92OShzdHJ1Y3Qga2VybmVsX3F1ZXVlX29wcyAqb3BzKQoreworCW9w
cy0+aW5pdGlhbGl6ZSA9IGluaXRpYWxpemVfdjk7CisJb3BzLT51bmluaXRpYWxpemUgPSB1bmlu
aXRpYWxpemVfdjk7CisJb3BzLT5zdWJtaXRfcGFja2V0ID0gc3VibWl0X3BhY2tldF92OTsKK30K
Kwogc3RhdGljIGludCBwbV9tYXBfcHJvY2Vzc192OShzdHJ1Y3QgcGFja2V0X21hbmFnZXIgKnBt
LAogCQl1aW50MzJfdCAqYnVmZmVyLCBzdHJ1Y3QgcWNtX3Byb2Nlc3NfZGV2aWNlICpxcGQpCiB7
Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
