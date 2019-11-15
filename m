Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F83C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F38320709
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F38320709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC8D6F3E4;
	Fri, 15 Nov 2019 03:35:36 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690051.outbound.protection.outlook.com [40.107.69.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A4C6F3EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 03:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMGYACYAniiyRSkgbU6TEfdMrkoL0+wbQhuZeY9AwG/5sRnBIUSSAOMLk5J1rO+puWnMoR+ZoesdVdarhvm6pfa46MBMvecUXDikk5UvZVjdsUMmDaAbva2RKsIAqKQCgQDTvVXIiqpqdmM4LVIM97WqgF6CZfuiHJZFPsfKzFogm2d4fTKsaT8KtqQIDz5h7VBo9mZd0q3bq1yDTJHv4gyzUpYQhz9P9Lhej8H/jO7w2cG+DQR41eg9aGo48oQN4MwOf7QXddS28frUpw52PwwBQLrtfmP78vGOhYD1o6iQmmwiEFEbYIR5o7oqTg5Rj9l3ZJ+jkrYMNVERYqQngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FN7+JrNNIfqOnOhD07uKTTVPpT+3pvgLBOafuwf8CtA=;
 b=YeoTB/NwJ/YWR4cpAKRXV3ct0yo1UQrtr4se2u+Qt8I+5XEahikBb2d2eiGCd9AAGAeeuFaYnc3LQWxer+nmYzWC6WmJwMt03xkiNyvDm+OV71ecLnCvHZRVa8ABg6qIellMkJjQe5hJb1Xr4X8eg4GDtbzdPZm+OGl1a50gZ0sDPcSYt0x62YpftWdDscHuLH1CHGwgRXiOpcQhGNY5/tiTuLP92lifxRFTommeQgNkOa06JrB04IgFZjpLPKr/ExRHLjzoN8++/q7b9LWDk1OwITYQDeODpWmyYv7LGDbf8GjMQbYoiQ4c17t24G3DtRxUQ+w/FcxgFHZTWwD3Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 03:35:32 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 03:35:32 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/12] tests/amdgpu: add device handle as input param for
 exec_cs_helper and write_linear_helper (v4)
Date: Fri, 15 Nov 2019 11:34:49 +0800
Message-Id: <1573788895-3936-6-git-send-email-aaron.liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
X-ClientProxiedBy: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To MN2PR12MB3838.namprd12.prod.outlook.com
 (2603:10b6:208:16c::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b2403c0-2217-40ac-10da-08d7697cde4a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36634FC7FBBDAC1410CFB489F0700@MN2PR12MB3663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(51416003)(52116002)(6512007)(76176011)(7736002)(386003)(26005)(11346002)(44832011)(486006)(4326008)(2616005)(25786009)(6506007)(6436002)(6486002)(5660300002)(478600001)(66556008)(446003)(186003)(86362001)(3846002)(6116002)(14454004)(48376002)(50466002)(66946007)(8936002)(50226002)(305945005)(66476007)(476003)(81156014)(81166006)(8676002)(2906002)(6916009)(16586007)(66066001)(14444005)(316002)(54906003)(2351001)(2361001)(47776003)(6666004)(36756003)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3663;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uIikXsVI18Oi/fJQ915964ZBw3yF1O2eBbIKLp62XZBHY+0MoEK9vqRDzhqGJNrUWAsjX34FBDOteyQDsO9Etc/jbd3BqvPNptH6txbW3+lCVNVDjJwSsk6WyKaad65D2j78SXAOc85uu/5bb/J2mOJcNckX19ShXiYYaA4as+FWLGOkEP6CmKJlcwLI5gIlKRvRWssqSWtUi6N2kxXjHLU7ec8sXoaj8rkgrzNmBLXf2MStfruGbiHUx1GKpWgywYhJn6B3fBSH4xCOtJeISyTokwvf/p2xB7BIeoV8JpPYvRFhNzxc8kSPZDK9TWv09CQ+G1o6FtXZgr1PDokT9b/JB5qDvb2y804op76A5RSYz47J8CH4byznLZBPd9y+Ys5+Ws97dUkzFehovj9DnCygm2VCHABwFtPnP7AdojDa70KVynq6tFcQ6QHSeqw8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2403c0-2217-40ac-10da-08d7697cde4a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 03:35:32.5389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uw62GwJn8U5tbZgrMtXeVEVN9FU/nEOTinIqoSJdYD9RB+W7EKlxJ8GB4nfa/WVN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FN7+JrNNIfqOnOhD07uKTTVPpT+3pvgLBOafuwf8CtA=;
 b=sKM07QoX+tY1lx9GNrmBEz0J4JrY+UdTMeDxYITUKklE+Ke2SwF1o/KDKvkGBtFT499HoPTd3PKdbEZbdcJYVBs8wZOC8+ak60/dNcxo5IMWny+rXWQer/iNQLWn6bpExBeiCpeSEk/IpH6J9ZcGctNXpGNsKmZM47fETXw2c4Y=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
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
Cc: Marek.Olsak@amd.com, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Luben.Tuikov@amd.com, Alexander.Deucher@amd.com,
 Leo.Liu@amd.com, Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115033449.p6ePMBCrohTJXxdtRvc2S10GwJYzbLLNB7xznpvlcZU@z>

RnJvbTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KClRoaXMgcGF0Y2ggaXMgdG8gYWRk
IGFkZCBkZXZpY2UgaGFuZGxlIGFzIGlucHV0IHBhcmFtIGZvciBleGVjX2NzX2hlbHBlcgphbmQg
d3JpdGVfbGluZWFyX2hlbHBlci4KCkJlY2F1c2UgdGhleSBhcmUgbmVlZGVkIGluIHNlY3VyaXR5
IHRlc3RzLgoKdjI6IGZpeCB0eXBvIHRoYXQgYmFzaWMgdGVzdHMgc2hvdWxkIGJlIHVuLXNlY3Vy
ZS4KdjM6IHJlZmluZSB0aGUgZnVuY3Rpb24gaW1wbGVtZW50YXRpb24uCnY0OiByZW1vdmUgYW1k
Z3B1X2NzX2N0eF9jcmVhdGUzIGNhbGxpbmcuCgpTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJh
eS5odWFuZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBYXJvbiBMaXUgPGFhcm9uLmxpdUBhbWQu
Y29tPgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
PgotLS0KIHRlc3RzL2FtZGdwdS9hbWRncHVfdGVzdC5oIHwgIDQgKysrLQogdGVzdHMvYW1kZ3B1
L2Jhc2ljX3Rlc3RzLmMgfCA1MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2FtZGdwdS9hbWRncHVfdGVzdC5oIGIvdGVzdHMvYW1k
Z3B1L2FtZGdwdV90ZXN0LmgKaW5kZXggNjdiZTQzNy4uMTZjMmRhMCAxMDA2NDQKLS0tIGEvdGVz
dHMvYW1kZ3B1L2FtZGdwdV90ZXN0LmgKKysrIGIvdGVzdHMvYW1kZ3B1L2FtZGdwdV90ZXN0LmgK
QEAgLTI2Myw3ICsyNjMsOSBAQCBDVV9CT09MIHN1aXRlX3NlY3VyaXR5X3Rlc3RzX2VuYWJsZSh2
b2lkKTsKIGV4dGVybiBDVV9UZXN0SW5mbyBzZWN1cml0eV90ZXN0c1tdOwogCiBleHRlcm4gdm9p
ZAotYW1kZ3B1X2NvbW1hbmRfc3VibWlzc2lvbl93cml0ZV9saW5lYXJfaGVscGVyX3dpdGhfc2Vj
dXJlKHVuc2lnbmVkIGlwX3R5cGUsCithbWRncHVfY29tbWFuZF9zdWJtaXNzaW9uX3dyaXRlX2xp
bmVhcl9oZWxwZXJfd2l0aF9zZWN1cmUoYW1kZ3B1X2RldmljZV9oYW5kbGUKKwkJCQkJCQkgIGRl
dmljZSwKKwkJCQkJCQkgIHVuc2lnbmVkIGlwX3R5cGUsCiAJCQkJCQkJICBib29sIHNlY3VyZSk7
CiAKIC8qKgpkaWZmIC0tZ2l0IGEvdGVzdHMvYW1kZ3B1L2Jhc2ljX3Rlc3RzLmMgYi90ZXN0cy9h
bWRncHUvYmFzaWNfdGVzdHMuYwppbmRleCAzMWM5YTU0Li41MTU0ODEyIDEwMDY0NAotLS0gYS90
ZXN0cy9hbWRncHUvYmFzaWNfdGVzdHMuYworKysgYi90ZXN0cy9hbWRncHUvYmFzaWNfdGVzdHMu
YwpAQCAtMTI4MywxMiArMTI4MywxNCBAQCBzdGF0aWMgdm9pZCBhbWRncHVfY29tbWFuZF9zdWJt
aXNzaW9uX2NvbXB1dGUodm9pZCkKICAqIHBtNF9zcmMsIHJlc291cmNlcywgaWJfaW5mbywgYW5k
IGlic19yZXF1ZXN0CiAgKiBzdWJtaXQgY29tbWFuZCBzdHJlYW0gZGVzY3JpYmVkIGluIGlic19y
ZXF1ZXN0IGFuZCB3YWl0IGZvciB0aGlzIElCIGFjY29tcGxpc2hlZAogICovCi1zdGF0aWMgdm9p
ZCBhbWRncHVfdGVzdF9leGVjX2NzX2hlbHBlcihhbWRncHVfY29udGV4dF9oYW5kbGUgY29udGV4
dF9oYW5kbGUsCi0JCQkJICAgICAgIHVuc2lnbmVkIGlwX3R5cGUsCi0JCQkJICAgICAgIGludCBp
bnN0YW5jZSwgaW50IHBtNF9kdywgdWludDMyX3QgKnBtNF9zcmMsCi0JCQkJICAgICAgIGludCBy
ZXNfY250LCBhbWRncHVfYm9faGFuZGxlICpyZXNvdXJjZXMsCi0JCQkJICAgICAgIHN0cnVjdCBh
bWRncHVfY3NfaWJfaW5mbyAqaWJfaW5mbywKLQkJCQkgICAgICAgc3RydWN0IGFtZGdwdV9jc19y
ZXF1ZXN0ICppYnNfcmVxdWVzdCkKK3N0YXRpYyB2b2lkCithbWRncHVfdGVzdF9leGVjX2NzX2hl
bHBlcl9yYXcoYW1kZ3B1X2RldmljZV9oYW5kbGUgZGV2aWNlX2hhbmRsZSwKKwkJCSAgICAgICBh
bWRncHVfY29udGV4dF9oYW5kbGUgY29udGV4dF9oYW5kbGUsCisJCQkgICAgICAgdW5zaWduZWQg
aXBfdHlwZSwgaW50IGluc3RhbmNlLCBpbnQgcG00X2R3LAorCQkJICAgICAgIHVpbnQzMl90ICpw
bTRfc3JjLCBpbnQgcmVzX2NudCwKKwkJCSAgICAgICBhbWRncHVfYm9faGFuZGxlICpyZXNvdXJj
ZXMsCisJCQkgICAgICAgc3RydWN0IGFtZGdwdV9jc19pYl9pbmZvICppYl9pbmZvLAorCQkJICAg
ICAgIHN0cnVjdCBhbWRncHVfY3NfcmVxdWVzdCAqaWJzX3JlcXVlc3QpCiB7CiAJaW50IHI7CiAJ
dWludDMyX3QgZXhwaXJlZDsKQEAgLTEzNjEsOCArMTM2MywyNCBAQCBzdGF0aWMgdm9pZCBhbWRn
cHVfdGVzdF9leGVjX2NzX2hlbHBlcihhbWRncHVfY29udGV4dF9oYW5kbGUgY29udGV4dF9oYW5k
bGUsCiAJQ1VfQVNTRVJUX0VRVUFMKHIsIDApOwogfQogCi12b2lkIGFtZGdwdV9jb21tYW5kX3N1
Ym1pc3Npb25fd3JpdGVfbGluZWFyX2hlbHBlcl93aXRoX3NlY3VyZSh1bnNpZ25lZCBpcF90eXBl
LAotCQkJCQkJCSAgICAgICBib29sIHNlY3VyZSkKK3N0YXRpYyB2b2lkCithbWRncHVfdGVzdF9l
eGVjX2NzX2hlbHBlcihhbWRncHVfY29udGV4dF9oYW5kbGUgY29udGV4dF9oYW5kbGUsCisJCQkg
ICB1bnNpZ25lZCBpcF90eXBlLCBpbnQgaW5zdGFuY2UsIGludCBwbTRfZHcsCisJCQkgICB1aW50
MzJfdCAqcG00X3NyYywgaW50IHJlc19jbnQsCisJCQkgICBhbWRncHVfYm9faGFuZGxlICpyZXNv
dXJjZXMsCisJCQkgICBzdHJ1Y3QgYW1kZ3B1X2NzX2liX2luZm8gKmliX2luZm8sCisJCQkgICBz
dHJ1Y3QgYW1kZ3B1X2NzX3JlcXVlc3QgKmlic19yZXF1ZXN0KQoreworCWFtZGdwdV90ZXN0X2V4
ZWNfY3NfaGVscGVyX3JhdyhkZXZpY2VfaGFuZGxlLCBjb250ZXh0X2hhbmRsZSwKKwkJCQkgICAg
ICAgaXBfdHlwZSwgaW5zdGFuY2UsIHBtNF9kdywgcG00X3NyYywKKwkJCQkgICAgICAgcmVzX2Nu
dCwgcmVzb3VyY2VzLCBpYl9pbmZvLAorCQkJCSAgICAgICBpYnNfcmVxdWVzdCk7Cit9CisKK3Zv
aWQKK2FtZGdwdV9jb21tYW5kX3N1Ym1pc3Npb25fd3JpdGVfbGluZWFyX2hlbHBlcl93aXRoX3Nl
Y3VyZShhbWRncHVfZGV2aWNlX2hhbmRsZQorCQkJCQkJCSAgZGV2aWNlLCB1bnNpZ25lZAorCQkJ
CQkJCSAgaXBfdHlwZSwgYm9vbCBzZWN1cmUpCiB7CiAJY29uc3QgaW50IHNkbWFfd3JpdGVfbGVu
Z3RoID0gMTI4OwogCWNvbnN0IGludCBwbTRfZHcgPSAyNTY7CkBAIC0xMzg4LDEzICsxNDA2LDEz
IEBAIHZvaWQgYW1kZ3B1X2NvbW1hbmRfc3VibWlzc2lvbl93cml0ZV9saW5lYXJfaGVscGVyX3dp
dGhfc2VjdXJlKHVuc2lnbmVkIGlwX3R5cGUsCiAJaWJzX3JlcXVlc3QgPSBjYWxsb2MoMSwgc2l6
ZW9mKCppYnNfcmVxdWVzdCkpOwogCUNVX0FTU0VSVF9OT1RfRVFVQUwoaWJzX3JlcXVlc3QsIE5V
TEwpOwogCi0JciA9IGFtZGdwdV9xdWVyeV9od19pcF9pbmZvKGRldmljZV9oYW5kbGUsIGlwX3R5
cGUsIDAsICZod19pcF9pbmZvKTsKKwlyID0gYW1kZ3B1X3F1ZXJ5X2h3X2lwX2luZm8oZGV2aWNl
LCBpcF90eXBlLCAwLCAmaHdfaXBfaW5mbyk7CiAJQ1VfQVNTRVJUX0VRVUFMKHIsIDApOwogCiAJ
Zm9yIChpID0gMDsgc2VjdXJlICYmIChpIDwgMik7IGkrKykKIAkJZ3R0X2ZsYWdzW2ldIHw9IEFN
REdQVV9HRU1fQ1JFQVRFX0VOQ1JZUFRFRDsKIAotCXIgPSBhbWRncHVfY3NfY3R4X2NyZWF0ZShk
ZXZpY2VfaGFuZGxlLCAmY29udGV4dF9oYW5kbGUpOworCXIgPSBhbWRncHVfY3NfY3R4X2NyZWF0
ZShkZXZpY2UsICZjb250ZXh0X2hhbmRsZSk7CiAKIAlDVV9BU1NFUlRfRVFVQUwociwgMCk7CiAK
QEAgLTE0MDYsNyArMTQyNCw3IEBAIHZvaWQgYW1kZ3B1X2NvbW1hbmRfc3VibWlzc2lvbl93cml0
ZV9saW5lYXJfaGVscGVyX3dpdGhfc2VjdXJlKHVuc2lnbmVkIGlwX3R5cGUsCiAJCWxvb3AgPSAw
OwogCQl3aGlsZShsb29wIDwgMikgewogCQkJLyogYWxsb2NhdGUgVUMgYm8gZm9yIHNETUEgdXNl
ICovCi0JCQlyID0gYW1kZ3B1X2JvX2FsbG9jX2FuZF9tYXAoZGV2aWNlX2hhbmRsZSwKKwkJCXIg
PSBhbWRncHVfYm9fYWxsb2NfYW5kX21hcChkZXZpY2UsCiAJCQkJCQkgICAgc2RtYV93cml0ZV9s
ZW5ndGggKiBzaXplb2YodWludDMyX3QpLAogCQkJCQkJICAgIDQwOTYsIEFNREdQVV9HRU1fRE9N
QUlOX0dUVCwKIAkJCQkJCSAgICBndHRfZmxhZ3NbbG9vcF0sICZibywgKHZvaWQqKikmYm9fY3B1
LApAQCAtMTQ0NSwxMSArMTQ2MywxMCBAQCB2b2lkIGFtZGdwdV9jb21tYW5kX3N1Ym1pc3Npb25f
d3JpdGVfbGluZWFyX2hlbHBlcl93aXRoX3NlY3VyZSh1bnNpZ25lZCBpcF90eXBlLAogCQkJCQlw
bTRbaSsrXSA9IDB4ZGVhZGJlYWY7CiAJCQl9CiAKLQkJCWFtZGdwdV90ZXN0X2V4ZWNfY3NfaGVs
cGVyKGNvbnRleHRfaGFuZGxlLAotCQkJCQkJICAgaXBfdHlwZSwgcmluZ19pZCwKLQkJCQkJCSAg
IGksIHBtNCwKLQkJCQkJCSAgIDEsIHJlc291cmNlcywKLQkJCQkJCSAgIGliX2luZm8sIGlic19y
ZXF1ZXN0KTsKKwkJCWFtZGdwdV90ZXN0X2V4ZWNfY3NfaGVscGVyX3JhdyhkZXZpY2UsIGNvbnRl
eHRfaGFuZGxlLAorCQkJCQkJICAgICAgIGlwX3R5cGUsIHJpbmdfaWQsIGksIHBtNCwKKwkJCQkJ
CSAgICAgICAxLCByZXNvdXJjZXMsIGliX2luZm8sCisJCQkJCQkgICAgICAgaWJzX3JlcXVlc3Qp
OwogCiAJCQkvKiB2ZXJpZnkgaWYgU0RNQSB0ZXN0IHJlc3VsdCBtZWV0cyB3aXRoIGV4cGVjdGVk
ICovCiAJCQlpID0gMDsKQEAgLTE0NzYsNyArMTQ5Myw4IEBAIHZvaWQgYW1kZ3B1X2NvbW1hbmRf
c3VibWlzc2lvbl93cml0ZV9saW5lYXJfaGVscGVyX3dpdGhfc2VjdXJlKHVuc2lnbmVkIGlwX3R5
cGUsCiAKIHN0YXRpYyB2b2lkIGFtZGdwdV9jb21tYW5kX3N1Ym1pc3Npb25fd3JpdGVfbGluZWFy
X2hlbHBlcih1bnNpZ25lZCBpcF90eXBlKQogewotCWFtZGdwdV9jb21tYW5kX3N1Ym1pc3Npb25f
d3JpdGVfbGluZWFyX2hlbHBlcl93aXRoX3NlY3VyZShpcF90eXBlLAorCWFtZGdwdV9jb21tYW5k
X3N1Ym1pc3Npb25fd3JpdGVfbGluZWFyX2hlbHBlcl93aXRoX3NlY3VyZShkZXZpY2VfaGFuZGxl
LAorCQkJCQkJCQkgIGlwX3R5cGUsCiAJCQkJCQkJCSAgZmFsc2UpOwogfQogCi0tIAoyLjcuNAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
