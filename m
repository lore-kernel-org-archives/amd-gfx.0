Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8E6C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB0E20848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB0E20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D116E296;
	Mon,  2 Dec 2019 17:34:57 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe49::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED4C6E296
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:34:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9E51xxsDq73G4X2dPK0igxNjshmxu66XONSyQcbxXgswcnhzOgoAGxWsEPlpJsxs4aeY+bHavO89hcRy47wrAEmtSsH44xc1IDv+8ZSgJZZGV9FtbDhiKPPO8eJ1D/rWCHCtwAOcYRw/JuSeNyZ9NHgdSbBoduygeLWfcU89geOLtvnFv7dz8OVS622ARSWSCIS4S4UdMZNJtRjdanWErc5/PjJ+PN6k2a1AfqLcs0P67D3Fa6n82m5JloB2tj+JAwWsb3wNRkeNIMKeNkQdTGZjy1anuQyOv1IikXCGyoKbfwjnAmfC3TB4CjyeqURLDMMsFvZxxnxzXwjCLzPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfaJxgSGz+n7gQi78CLNlRkz1gNj57tt7VFNM2sRdDQ=;
 b=ELH6o7KYopgNKT7gJEt6CstX0yHCpOx/0nLkXPqcu1Wg/1oc6Cw9u1WInToiwI48gXaTf3AFCpGPDgPReqPety5HyqGV1GFJWFcpm38VekOTSX7kbUuUBBwLfgdp08ic0a+kI2LQO21eXfFgd0k0z/qBCp0YO/wTQWpA1X9QtxxalOu9Ej14caWXmYIUGa4IHZeS001fG/Dwty7ZtAMjRBvEsdcsl/bkWhWdqmehp9wOJluMqc65YPu5c5zAAiLAaUtiePIC3okatpT7KtEluO0UpSmo+94V1p32o2T5AEh/dKbNQ3GekW2B+UPUD98DmVSdDNDjjblAalsH+Y1RFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:34:53 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:34:52 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/51] drm/amd/display: Fix Dali clk mgr construct
Date: Mon,  2 Dec 2019 12:33:18 -0500
Message-Id: <20191202173405.31582-5-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202173405.31582-1-sunpeng.li@amd.com>
References: <20191202173405.31582-1-sunpeng.li@amd.com>
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b49c96af-c7d4-4ea4-4f8e-08d7774def53
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB26104A00C739FED9E5ECD8A882430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(6666004)(51416003)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BR10eJHHQYCbZ9CCKQFnWG8hCtyvMZY+Mr7Sro1VyssAzfsyK1IdSMvFcvhOVaJiq5iwYFiPfWlFOtr30Fl/YaCvwSg5r+qV023TutVFF/09pX4bj+yvbSdB8AGW0wDbbCj1hdR41bsq6xUD/MhGLq/8PoWYmMhzs1UEIU27jJwXopGVwA4gm2Ixi5gAz7M5RbocnD/LUTuQnSCRyRv9yx/adU7BaB3OICicHpvh5york9UzqTsrsFPA6o78nPVxbsbfIRxHc+MRXi0NZLpxdYka0GFxG9Q20Zy5IarmkEOJyLxucX6zAixJxij3KdDMTWaQrNDEn1eQAq8UiAKs2tgoGZslbc6IyrdshGrqXq+W9+XARJmvAuWE8mbkTjroSbxSbT2ey51cNYuoYWtWFyzfZE6O6ciHquRdxp5sRidaQ5nvbTzy1aPsBvlqwWHg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49c96af-c7d4-4ea4-4f8e-08d7774def53
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:34:51.0214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpIGdjjDIMB6QoDG3BYpXjDMX+Y1Tri8YTEcoIDoCKmtO6T0ZQft+QFH4dKqkXO2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfaJxgSGz+n7gQi78CLNlRkz1gNj57tt7VFNM2sRdDQ=;
 b=LQp+764h1yp1pM4GxdyvCRFeNuB9MoeOvQxleqbZqEQXivQvrKo19MCdLe44nYBDOCIPysUkJ/dlRKFWVyXFO9E+eL6R0Wxmw/Px2JvXmCcMwKfz8ykSbbkkRj7NcF+TURig50NxQ5Cd94zuTpko6FA/WXJ4Fcldwyd7YWv+dEo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Cc: Eric Yang <eric.yang2@amd.com>, Leo Li <sunpeng.li@amd.com>,
 harry.wentland@amd.com, rodrigo.siqueira@amd.com,
 Michael Strauss <michael.strauss@amd.com>, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTWljaGFlbCBTdHJhdXNzIDxtaWNoYWVsLnN0cmF1c3NAYW1kLmNvbT4KCltXSFldCkRh
bGkgaXMgY3VycmVudGx5IGJlaW5nIG1pc2ludGVycHJldGVkIGFzIFJlbm9pciwKYXMgYSByZXN1
bHQgdXNlcyB3cm9uZyBjbGsgbWdyIGNvbnN0cnVjdG9yCgpbSE9XXQpBZGQgY2hlY2sgdG8gaW5p
dCBEYWxpIGFzIFJhdmVuMiBiZWZvcmUgaXQgY2FuIGJlIG1pc2lkZW50aWZpZWQKQ2xlYW4gdXAg
JiBmaXggUmF2ZW4yICYgRGFsaSBBU0lDIGNoZWNrcwpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFN0
cmF1c3MgPG1pY2hhZWwuc3RyYXVzc0BhbWQuY29tPgpSZXZpZXdlZC1ieTogRXJpYyBZYW5nIDxl
cmljLnlhbmcyQGFtZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2xrX21nci9jbGtfbWdyLmMgIHwg
IDcgKysrKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvZGFsX2FzaWNf
aWQuaCB8IDEyICsrKysrLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jbGtfbWdyL2Nsa19tZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
bGtfbWdyL2Nsa19tZ3IuYwppbmRleCBhN2M0YzFkMWZjNTkuLjZkNjBlZjgyMjYxOSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nsa19tZ3IvY2xrX21nci5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtfbWdyL2Nsa19tZ3IuYwpAQCAt
MTM0LDYgKzEzNCwxMyBAQCBzdHJ1Y3QgY2xrX21nciAqZGNfY2xrX21ncl9jcmVhdGUoc3RydWN0
IGRjX2NvbnRleHQgKmN0eCwgc3RydWN0IHBwX3NtdV9mdW5jcyAqcAogCiAjaWYgZGVmaW5lZChD
T05GSUdfRFJNX0FNRF9EQ19EQ04pCiAJY2FzZSBGQU1JTFlfUlY6CisJCWlmIChBU0lDUkVWX0lT
X0RBTEkoYXNpY19pZC5od19pbnRlcm5hbF9yZXYpKSB7CisJCQkvKiBURU1QOiB0aGlzIGNoZWNr
IGhhcyB0byBjb21lIGJlZm9yZSBBU0lDUkVWX0lTX1JFTk9JUiAqLworCQkJLyogd2hpY2ggYWxz
byBpbmNvcnJlY3RseSByZXR1cm5zIHRydWUgZm9yIERhbGkgKi8KKwkJCXJ2Ml9jbGtfbWdyX2Nv
bnN0cnVjdChjdHgsIGNsa19tZ3IsIHBwX3NtdSk7CisJCQlicmVhazsKKwkJfQorCiAJCWlmIChB
U0lDUkVWX0lTX1JFTk9JUihhc2ljX2lkLmh3X2ludGVybmFsX3JldikpIHsKIAkJCXJuX2Nsa19t
Z3JfY29uc3RydWN0KGN0eCwgY2xrX21nciwgcHBfc211LCBkY2NnKTsKIAkJCWJyZWFrOwpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvZGFsX2FzaWNfaWQu
aCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL2RhbF9hc2ljX2lkLmgKaW5k
ZXggNmY1NjIwOGE5NDcxLi43MmI2NTljNjNhZWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9pbmNsdWRlL2RhbF9hc2ljX2lkLmgKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2luY2x1ZGUvZGFsX2FzaWNfaWQuaApAQCAtMTM0LDE5ICsxMzQsMTcgQEAK
ICNkZWZpbmUgUElDQVNTT19BMCAweDQxCiAvKiBEQ04xXzAxICovCiAjZGVmaW5lIFJBVkVOMl9B
MCAweDgxCisjZGVmaW5lIFJBVkVOMl8xNUQ4X1JFVl9FMyAweEUzCisjZGVmaW5lIFJBVkVOMl8x
NUQ4X1JFVl9FNCAweEU0CiAjZGVmaW5lIFJBVkVOMV9GMCAweEYwCiAjZGVmaW5lIFJBVkVOX1VO
S05PV04gMHhGRgogCi0jZGVmaW5lIFBJQ0FTU09fMTVEOF9SRVZfRTMgMHhFMwotI2RlZmluZSBQ
SUNBU1NPXzE1RDhfUkVWX0U0IDB4RTQKLQogI2RlZmluZSBBU0lDUkVWX0lTX1JBVkVOKGVDaGlw
UmV2KSAoKGVDaGlwUmV2ID49IFJBVkVOX0EwKSAmJiBlQ2hpcFJldiA8IFJBVkVOX1VOS05PV04p
CiAjZGVmaW5lIEFTSUNSRVZfSVNfUElDQVNTTyhlQ2hpcFJldikgKChlQ2hpcFJldiA+PSBQSUNB
U1NPX0EwKSAmJiAoZUNoaXBSZXYgPCBSQVZFTjJfQTApKQotI2RlZmluZSBBU0lDUkVWX0lTX1JB
VkVOMihlQ2hpcFJldikgKChlQ2hpcFJldiA+PSBSQVZFTjJfQTApICYmIChlQ2hpcFJldiA8IFBJ
Q0FTU09fMTVEOF9SRVZfRTMpKQotI2RlZmluZSBBU0lDUkVWX0lTX0RBTEkoZUNoaXBSZXYpICgo
ZUNoaXBSZXYgPj0gUElDQVNTT18xNUQ4X1JFVl9FMykgJiYgKGVDaGlwUmV2IDwgUkFWRU4xX0Yw
KSkKLQorI2RlZmluZSBBU0lDUkVWX0lTX1JBVkVOMihlQ2hpcFJldikgKChlQ2hpcFJldiA+PSBS
QVZFTjJfQTApICYmIChlQ2hpcFJldiA8IFJBVkVOMV9GMCkpCiAjZGVmaW5lIEFTSUNSRVZfSVNf
UlYxX0YwKGVDaGlwUmV2KSAoKGVDaGlwUmV2ID49IFJBVkVOMV9GMCkgJiYgKGVDaGlwUmV2IDwg
UkFWRU5fVU5LTk9XTikpCi0KKyNkZWZpbmUgQVNJQ1JFVl9JU19EQUxJKGVDaGlwUmV2KSAoKGVD
aGlwUmV2ID09IFJBVkVOMl8xNUQ4X1JFVl9FMykgXAorCQl8fCAoZUNoaXBSZXYgPT0gUkFWRU4y
XzE1RDhfUkVWX0U0KSkKIAogI2RlZmluZSBGQU1JTFlfUlYgMTQyIC8qIERDTiAxKi8KIAotLSAK
Mi4yNC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
