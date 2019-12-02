Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E64C432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520A920848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520A920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 852D16E2A3;
	Mon,  2 Dec 2019 17:35:06 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720044.outbound.protection.outlook.com [40.107.72.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52D76E2A5
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esihIL8EjzXmcPcUe8OlTquzxoK0iJT52RNkpDvukcF3vTwxqnhs5dxvSyB4/Ge4qC183L2wJulTr6v+3EMMguTSddxjErmJrOw1YxiSq1GuXdJFFL2NpdwzRV1x/Z4wKVnM8GgbnWb7btBraG8p7jgr1GKclAudmMiJbj248SXnX9AGfskBs0YbTDR3+iDna6PnWqvnPvwJpYZxISQHeXRJIG+r/YbNCRwLDRxHacAPROI6jtQbu4hbpirbBwJATv1kIHsYECq2SI6J3lHEDY31tYTUt05fn5JVdHksHuj3j3S1/DHXLSQYXKcVMoAUwdf7GHcW7vvpMwvT8rb7vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iV7tO73x9mHKm4wjwlzbx3kD8oyLGrtchInOKoJfsc=;
 b=fuRHJpdMW6iHJtwoQg1KTI9OATgAb2tp29hadRvuiBpQUpQRt6SCbuqDZDhV3b+rJQej7BecYJ2kfsUpTtTz7CnpE7Fx/QHLyg7YD8x+dXEOYHwp7swSnYX0tx7IR2XDLpJFDK3NulEW4AhF9df/UjTuWiXkaeuLWHBjDb3oWsf1eT7uAZsIpd5x1ero9o6+N9KnbY26KbEOWbhitwwwNyA6ORXof3SoaVuckQ0m0bEr/WjGw0/qfTLgASwgEgTr3mQkWPiSgxhbZzfuMzljwlcnyClk2CrWlCfRmP/e4Ty0sI+Q/LS59Soma966fAkDHGd0Lkg5vsGwLnIqgzkPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:01 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:01 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/51] drm/amd/display: populate bios integrated info for
 renoir
Date: Mon,  2 Dec 2019 12:33:28 -0500
Message-Id: <20191202173405.31582-15-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c5af23e3-3d42-4707-b3e3-08d7774df4bd
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB28027B9AED3F31318F317BFD82430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(99286004)(6666004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCYPEDPLNKnXHqoRQqu3tjeaXOfWMgw1jO0S/LXHc/HMHXHxlAQAcbi0RkaWwlncCdSf2kjHzMEBfp687NHCHzR+DPd+EDwJjz3rRax9Gln56RTfZB7lrShTxAG5Yb162ufgz6LY0UOjHRuXhY/oPNvl+k5bfnzieXHQ2cAf8OLergaY73W/uSZsbLKTTmvB8rE8uCGpRaJ3heIf2SRzBWqpdGVVd02LKri5TYSM8ZenAmfiRWk9aT2I9X/ugCJq4SciW8fULZDMg12t1sD3F0p8hmlaSSwfNNmuTSEK6a3YLsJTM5PWYvua/pn1Vx+hO3ppA4MtasYgyGLYXOiFqg2WWqz3lBM8i6xuaer231roSCy0PJQBqC2W739J0pyoXo5Lx6ItsI4L7kUhRDScE9f9hqOZW46/r1lFV6MIyG0A1++iianh/j/GUOYNuOFS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5af23e3-3d42-4707-b3e3-08d7774df4bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:00.1133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlMQ+fLvh/41XW8Oip7CmE1b9ttUSM/F1zIAUkJp2oA/WW6w/ib+vrQzoAYU5nVN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iV7tO73x9mHKm4wjwlzbx3kD8oyLGrtchInOKoJfsc=;
 b=Ry4HZ61uaAfacuyQJ6uvAssZJ9cRWNEgr09BU4nAE7k359aL+TBE/+zdYC88LwSgS8Ka0IY0Tp3QJMPcmk/hV927vwBnbMOMo+R86MIE/umwCYN/6G98dMOzKmHmdEuMQ7aft/wd0p9AEcErgAIwa8/vFAmczx4TXnqpDhfTjFI=
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
Cc: Leo Li <sunpeng.li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 rodrigo.siqueira@amd.com, Joseph Gravenor <joseph.gravenor@amd.com>,
 harry.wentland@amd.com, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogSm9zZXBoIEdyYXZlbm9yIDxqb3NlcGguZ3JhdmVub3JAYW1kLmNvbT4KCltXaHldCldo
ZW4gdmlkZW9fbWVtb3J5X3R5cGUgYndfcGFyYW1zLT52cmFtX3R5cGUKaXMgYXNzaWduZWQsIHdl
ZGlzdGluZ3Vpc2ggYmV0d2VlbiBEZHI0TWVtVHlwZSBhbmQgTHBEZHI0TWVtVHlwZS4KQmVjYXVz
ZSBvZiB0aGlzIHdlIHdpbGwgbmV2ZXIgcmVwb3J0IHRoYXQgd2UgYXJlIHVzaW5nCkxwRGRyNE1l
bVR5cGUgYW5kIG5ldmVyIHJlLXB1cnBvc2UgV00gc2V0IEQKCltIb3ddCnBvcHVsYXRlIGJpb3Mg
aW50ZWdyYXRlZCBpbmZvIGZvciByZW5vaXIgYnkgYWRkaW5nIHRoZQpyZXZpc2lvbiBudW1iZXIg
Zm9yIHJlbm9pciBhbmQgdXNlIHRoYXQgaW50ZWdyYXRlZCBpbmZvCnRhYmxlIGluc3RlYWQgb2Yg
b2YgYXNpY19pZCB0byBnZXQgdGhlIHZyYW0gdHlwZQoKU2lnbmVkLW9mZi1ieTogSm9zZXBoIEdy
YXZlbm9yIDxqb3NlcGguZ3JhdmVub3JAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IFRvbnkgQ2hlbmcg
PFRvbnkuQ2hlbmdAYW1kLmNvbT4KQWNrZWQtYnk6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyMi5j
ICAgICB8ICAxICsKIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nsa19tZ3IvZGNuMjEvcm5f
Y2xrX21nci5jICB8IDEwICsrKysrKy0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyMi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2Jpb3MvYmlvc19wYXJzZXIyLmMKaW5kZXggZWIwNmVlNzY1Yzc4Li43Mjc5NWFlODFkZDAg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFy
c2VyMi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFy
c2VyMi5jCkBAIC0xNjM4LDYgKzE2MzgsNyBAQCBzdGF0aWMgZW51bSBicF9yZXN1bHQgY29uc3Ry
dWN0X2ludGVncmF0ZWRfaW5mbygKIAkJLyogRG9uJ3QgbmVlZCB0byBjaGVjayBtYWpvciByZXZp
c2lvbiBhcyB0aGV5IGFyZSBhbGwgMSAqLwogCQlzd2l0Y2ggKHJldmlzaW9uLm1pbm9yKSB7CiAJ
CWNhc2UgMTE6CisJCWNhc2UgMTI6CiAJCQlyZXN1bHQgPSBnZXRfaW50ZWdyYXRlZF9pbmZvX3Yx
MShicCwgaW5mbyk7CiAJCQlicmVhazsKIAkJZGVmYXVsdDoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtfbWdyL2RjbjIxL3JuX2Nsa19tZ3IuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtfbWdyL2RjbjIxL3JuX2Nsa19tZ3IuYwppbmRl
eCA4NDEwOTVkMDlkM2MuLjlmMDM4MWM2ODg0NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2Nsa19tZ3IvZGNuMjEvcm5fY2xrX21nci5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtfbWdyL2RjbjIxL3JuX2Nsa19tZ3IuYwpAQCAtNTY5
LDcgKzU2OSw3IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgZmluZF9kY2ZjbGtfZm9yX3ZvbHRhZ2Uo
c3RydWN0IGRwbV9jbG9ja3MgKmNsb2NrX3RhYmxlLCB1bnNpCiAJcmV0dXJuIDA7CiB9CiAKLXN0
YXRpYyB2b2lkIHJuX2Nsa19tZ3JfaGVscGVyX3BvcHVsYXRlX2J3X3BhcmFtcyhzdHJ1Y3QgY2xr
X2J3X3BhcmFtcyAqYndfcGFyYW1zLCBzdHJ1Y3QgZHBtX2Nsb2NrcyAqY2xvY2tfdGFibGUsIHN0
cnVjdCBod19hc2ljX2lkICphc2ljX2lkKQorc3RhdGljIHZvaWQgcm5fY2xrX21ncl9oZWxwZXJf
cG9wdWxhdGVfYndfcGFyYW1zKHN0cnVjdCBjbGtfYndfcGFyYW1zICpid19wYXJhbXMsIHN0cnVj
dCBkcG1fY2xvY2tzICpjbG9ja190YWJsZSwgc3RydWN0IGludGVncmF0ZWRfaW5mbyAqYmlvc19p
bmZvKQogewogCWludCBpLCBqID0gMDsKIApAQCAtNjAxLDggKzYwMSw4IEBAIHN0YXRpYyB2b2lk
IHJuX2Nsa19tZ3JfaGVscGVyX3BvcHVsYXRlX2J3X3BhcmFtcyhzdHJ1Y3QgY2xrX2J3X3BhcmFt
cyAqYndfcGFyYW1zCiAJCWJ3X3BhcmFtcy0+Y2xrX3RhYmxlLmVudHJpZXNbaV0uZGNmY2xrX21o
eiA9IGZpbmRfZGNmY2xrX2Zvcl92b2x0YWdlKGNsb2NrX3RhYmxlLCBjbG9ja190YWJsZS0+RkNs
b2Nrc1tqXS5Wb2wpOwogCX0KIAotCWJ3X3BhcmFtcy0+dnJhbV90eXBlID0gYXNpY19pZC0+dnJh
bV90eXBlOwotCWJ3X3BhcmFtcy0+bnVtX2NoYW5uZWxzID0gYXNpY19pZC0+dnJhbV93aWR0aCAv
IEREUjRfRFJBTV9XSURUSDsKKwlid19wYXJhbXMtPnZyYW1fdHlwZSA9IGJpb3NfaW5mby0+bWVt
b3J5X3R5cGU7CisJYndfcGFyYW1zLT5udW1fY2hhbm5lbHMgPSBiaW9zX2luZm8tPm1hX2NoYW5u
ZWxfbnVtYmVyOwogCiAJZm9yIChpID0gMDsgaSA8IFdNX1NFVF9DT1VOVDsgaSsrKSB7CiAJCWJ3
X3BhcmFtcy0+d21fdGFibGUuZW50cmllc1tpXS53bV9pbnN0ID0gaTsKQEAgLTY4NSw3ICs2ODUs
OSBAQCB2b2lkIHJuX2Nsa19tZ3JfY29uc3RydWN0KAogCiAJaWYgKHBwX3NtdSAmJiBwcF9zbXUt
PnJuX2Z1bmNzLmdldF9kcG1fY2xvY2tfdGFibGUpIHsKIAkJcHBfc211LT5ybl9mdW5jcy5nZXRf
ZHBtX2Nsb2NrX3RhYmxlKCZwcF9zbXUtPnJuX2Z1bmNzLnBwX3NtdSwgJmNsb2NrX3RhYmxlKTsK
LQkJcm5fY2xrX21ncl9oZWxwZXJfcG9wdWxhdGVfYndfcGFyYW1zKGNsa19tZ3ItPmJhc2UuYndf
cGFyYW1zLCAmY2xvY2tfdGFibGUsICZjdHgtPmFzaWNfaWQpOworCQlpZiAoY3R4LT5kY19iaW9z
ICYmIGN0eC0+ZGNfYmlvcy0+aW50ZWdyYXRlZF9pbmZvKSB7CisJCQlybl9jbGtfbWdyX2hlbHBl
cl9wb3B1bGF0ZV9id19wYXJhbXMgKGNsa19tZ3ItPmJhc2UuYndfcGFyYW1zLCAmY2xvY2tfdGFi
bGUsIGN0eC0+ZGNfYmlvcy0+aW50ZWdyYXRlZF9pbmZvKTsKKwkJfQogCX0KIAogCWlmICghSVNf
RlBHQV9NQVhJTVVTX0RDKGN0eC0+ZGNlX2Vudmlyb25tZW50KSAmJiBjbGtfbWdyLT5zbXVfdmVy
ID49IDB4MDAzNzE1MDApIHsKLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
