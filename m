Return-Path: <SRS0=9SYE=DH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F90C4727E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 13:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512B02071E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 13:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EHob5iSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512B02071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C51436E203;
	Wed, 30 Sep 2020 13:58:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EEC06E203
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 13:58:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCPTsYt4ooWNVN0hoy3b2AKBuuM8lUFjwJp0wKUswNhfvaTsu2B0ggi5M4MkZ18I28INB9416Zio9J4lUzP/zuSrI5Vb4rjp+8+yPINvg2tVg7Au/lg4AOWOPJTdoFZhqm/JjGd1agNpi+jW4vWQkfHrBDKCiW1sAE8jIrrD09BxOMISV6YcJYLZMb7JragVBsKZSdOPPQ6TyJPz1cHPdmruH2Rc5IYf8OXg6puN7b2pT3+qKob2eAOE/gRuO9zUJyvr//hBOmxSpmEhRGYlHVM5QVehE2AuF4P+0oe3ja/kGUeOwrMMhke1ov1CghAr1Ubh8Avy0VgTCt3b+LUmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8zFF9OvMuqaYjbXbOYRrDJm/69nKbKe3KjWyHCEck4=;
 b=d6pBsrQIPm1OcSqfesM0udojUwGIYTLZ3ofHGH+YDHutzNXksx2lN67PdZBcpslU4wIqOqA6Eh3V6lMxyofdJ2Y+2gaHSCzN941ZTVlV98PC0wfnSIRzL1XyPTukVxcaUklkFQpaBwSEiWsLTRQ81OZgm4GyE27VnkilLE/Dvd66qNB4SNnuLu3/MyXYlXmcYlqoU4JYJNHLhDJ/Hc6fHT3xSSdMMCyA+1gIPTXmjS4D89gQOKAu8UKuKn7VL4MQIlP86pDzUVautyw370LbzteyH7MRNjZCNUCvSE5ocB68trFNY8Db7MRL1DOT/fUSTNPKADD3T33zaGQh0QkOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8zFF9OvMuqaYjbXbOYRrDJm/69nKbKe3KjWyHCEck4=;
 b=EHob5iShgaZR3RYVo8l9Ccl0/2nWTrLBBcoKnzsFUDxpTBEdqI+iWoKWFL9u/8wH4sZij0vuvviE70awnrMgv5QTNhhm1h6LjZGxy3ML44ada7tsc0FADPU52WRp9pNBuqYUXacR9ZafiFVw1WUoSxvxk9PGIhE+eaJ59KnKc80=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0184.namprd12.prod.outlook.com (2603:10b6:910:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 30 Sep
 2020 13:58:53 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 13:58:53 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Tom.StDenis@amd.com
Subject: [PATCH] drm/amdgpu: fix build error
Date: Wed, 30 Sep 2020 21:58:34 +0800
Message-Id: <20200930135834.6917-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR04CA0087.apcprd04.prod.outlook.com
 (2603:1096:202:15::31) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR04CA0087.apcprd04.prod.outlook.com (2603:1096:202:15::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32 via Frontend Transport; Wed, 30 Sep 2020 13:58:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 937a9f64-10cb-4752-2701-08d86548f6ef
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0184:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0184A487452A1B90592A1675F1330@CY4PR1201MB0184.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mmxRPVlYSI4QJ+OzuQaNZeWDp0V/PqS9MjGD9rGkC5OQVtMrHhuUHfMlJCawPe+2ir6CYbl/cVfTUjrEitALuRj5zQ1LoFKWAmVRclnxmPHKZMq9Dez7Qyfxf+9z0cxDRfj85sT15tvqEu6vlnYn11s7tsOaJ1VgVhSD5qFL4JD3CuIq7kNC66AmX0ZRhWCdbEgJ/iGXCsQ7XBZZtqOHjWGrxZKHzL6wyr7fj1BFtldu8/N4MwYVTfz6t5esWxHnt8/ZFndipeP7Qk7+SM7J1huXAftDM9/T3Dqt4TCp9Id33lUQIViTXJYPjYI2jKYLd4yozsdICkb3rpByDsrLtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(36756003)(7696005)(186003)(26005)(16526019)(6666004)(44832011)(5660300002)(66476007)(66946007)(66556008)(6486002)(2906002)(316002)(478600001)(8676002)(4326008)(86362001)(83380400001)(1076003)(6636002)(2616005)(8936002)(956004)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OFhuGdOb6sWr8ol6BKt2hrma1fgB7mwBrYdX0To6DWAVmnwYNwaEOKKq/BWfMQMmLmxOgOo+50/yAf9MlyZjIkizt9hF+UCV1h5DQou67B1gAvqkYnrpLmLq2Gw3abggkGY46+ekHsXuL6mG3Vjzx3CAMbdH5ixiq7rUX7FKKmQukGdNShifui0RdrU3MRm3M8UFVEFSeCLgCFjhaGj5G+iMpUF+pXyW0UPdJUAhyeoEz/yQm1T+0icdepxHzkRJWFCr6LYHt9JpbxL19Wg1cSkcUMSYMqJ25QHKOq4UTCf7x4ZQcemlVifXLRWjUNDPg/a3ZUzwIHhCAPdhg1KDtLGxw5+6zYagR6TDFSOYxLw+lW6P1uRtR3TYUsV9rTBS4zho7PBQtjsuPOLHgiXsBMadxZEzeeMohV7AeIPj/otECigT+ItcuPkfEh0qBXX5lOrcGt1fjAjkvmptluoa39bZwXRdP1HICTuG77buUT1tMCRe35MdWxZcrwTWt26sZxSsPGgdFTy9yVS4RPA46Y3LhgsJ7bmoLb4R/gCItoo2kWP/mH40DGoUvXLr1LyhgjirtI1XXit3oJqAvKvsJ27RnLdf+q94pko+y9sdjCmI0Kh+pBMKt7hjE7XrwjTVmwFuQC77O1z23ZAJqX80yQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937a9f64-10cb-4752-2701-08d86548f6ef
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 13:58:53.0982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGtHDKQ47u3oST5RuksN6N3D8uIX+QFMgCB0mYn/t4CD/U82RnABYZDGlyUwcP7CD2JH8PwS9faHDkkJugWKlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0184
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

UmVncmVzc2lvbiBieSBwYXRjaDoKZmQ1ODNjNGYwMWE3IGRybS9hbWRncHU6IGRyb3AgZHVwbGlj
YXRlZCBlY2MgY2hlY2sgZm9yIHZlZ2ExMCAodjQpCgpDQyBbTV0gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeGh1Yl92Ml8xLm8KZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5
XzAuYzogSW4gZnVuY3Rpb24g4oCYZ21jX3Y5XzBfbGF0ZV9pbml04oCZOgpkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jOjEyMTY6NTk6IGVycm9yOiBleHBlY3RlZCDigJgp4oCZ
IGJlZm9yZSDigJh74oCZIHRva2VuCiAxMjE2IHwgICBpZiAoIShhZGV2LT5yYXNfZmVhdHVyZXMg
JiAoMSA8PCBBTURHUFVfUkFTX0JMT0NLX19VTUMpKSB7CiAgICAgIHwgICAgICB+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+CiAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICkK
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYzoxMjIwOjI6IGVycm9yOiBleHBl
Y3RlZCBleHByZXNzaW9uIGJlZm9yZSDigJh94oCZIHRva2VuCiAxMjIwIHwgIH0KICAgICAgfCAg
XgogIENDIFtNXSAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzEubwoKU2lnbmVk
LW9mZi1ieTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dtY192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlf
MC5jCmluZGV4IDE1MTY4Njg4OGMzMi4uNmU5ZGUwMmQ1NDU1IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dtY192OV8wLmMKQEAgLTEyMTMsNyArMTIxMyw3IEBAIHN0YXRpYyBpbnQgZ21jX3Y5
XzBfbGF0ZV9pbml0KHZvaWQgKmhhbmRsZSkKIAkgKiB3cml0ZXMsIHdoaWxlIGRpc2FibGVzIEhC
TSBFQ0MgZm9yIHZlZ2ExMC4KIAkgKi8KIAlpZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJiAo
YWRldi0+YXNpY190eXBlID09IENISVBfVkVHQTEwKSkgewotCQlpZiAoIShhZGV2LT5yYXNfZmVh
dHVyZXMgJiAoMSA8PCBBTURHUFVfUkFTX0JMT0NLX19VTUMpKSB7CisJCWlmICghKGFkZXYtPnJh
c19mZWF0dXJlcyAmICgxIDw8IEFNREdQVV9SQVNfQkxPQ0tfX1VNQykpKSB7CiAJCQlpZiAoYWRl
di0+ZGYuZnVuY3MtPmVuYWJsZV9lY2NfZm9yY2VfcGFyX3dyX3JtdykKIAkJCQlhZGV2LT5kZi5m
dW5jcy0+ZW5hYmxlX2VjY19mb3JjZV9wYXJfd3Jfcm13KGFkZXYsIGZhbHNlKTsKIAkJfQotLSAK
Mi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
