Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD40C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 10:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DCB20722
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 10:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DCB20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 455DA89B46;
	Wed, 27 Nov 2019 10:03:01 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740079.outbound.protection.outlook.com [40.107.74.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172238921B
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 10:03:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPdgzyyQE8ap/k2H4qT/piy4wZjBna9Y7HBiqgJZajaG3q29odkWgMcICV2Yd5pgcRUo5NN64NyqdeqmHphXNoB8JDMOZ7LE9Vu62xjT75395+RPxliamMPr5FWyajeOcI8IyzVFIjFq+FpAdfFuHNWnCfVsdsMCFEuBJhgbk5NRuB0A9yTqJ8A2iF2OSoa5TUNFmADXe6eE6alkp+G2Jt2mjy4126FUQOMEwStIbdU/R2UDaqB4F2IBGbBsDLwd3gsEM5kuOJkopr1ZnHeMKeE67V8iGoNTcVNvZcFneLf/Vsw9LF3RbjnOPj/8xGvJFcSKjAj9tQ7NWWexhGS82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wp6wQl9y3fN6qX7d7G25OIwAXuz7A5YEGfEehez3Jg4=;
 b=OKelZKYvO7Ig/12zS/Vj6lkoYUcr8OsycVW+bTAkKWUFTIW57ROGdZYHT08fV1pnVpmsnCWKEuwAvbp6fuQAhcYbiYgvJBcNW0qWbzziP12iU3VhOrXHMwm1wNXyAO8Yl/osFtAdAqMlynlA+qFB0UcpOfdSWqVXSi+vQueRIkkKYVAIeChmZeyvYFLqMdVtGzkGu79oo1ORiSKP/FJnCe3JWgieGGssToKHLGXCEl2AOLnJqLN0xjj+b63dL6BRYU+3A5AJh4vzvzVdXJAtq2wQQVIKWyARgHEs4wdaTm0JxmtPLYX8udCzt8I5mD5dpIkykqVRXUjTp/qW4kZyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0089.namprd12.prod.outlook.com (2603:10b6:0:57::33) by
 CY4PR12MB1381.namprd12.prod.outlook.com (2603:10b6:903:42::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Wed, 27 Nov 2019 10:02:57 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::208) by DM3PR12CA0089.outlook.office365.com
 (2603:10b6:0:57::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2474.19 via Frontend
 Transport; Wed, 27 Nov 2019 10:02:57 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 27 Nov 2019 10:02:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 04:02:39 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 04:02:39 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 27 Nov 2019 04:02:37 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/10 v2] drm/amdgpu: reduce redundant uvd context lost
 warning message
Date: Wed, 27 Nov 2019 18:02:33 +0800
Message-ID: <1574848953-11109-1-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(428003)(189003)(199004)(356004)(70206006)(6666004)(8676002)(2906002)(44832011)(426003)(86362001)(305945005)(48376002)(81166006)(81156014)(50226002)(6916009)(54906003)(70586007)(478600001)(50466002)(8936002)(47776003)(51416003)(14444005)(316002)(186003)(2351001)(36756003)(5660300002)(4326008)(336012)(2616005)(16586007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1381; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6e63209-d238-44b8-04fc-08d77320fa5a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1381:
X-Microsoft-Antispam-PRVS: <CY4PR12MB138156EEB70AC2E49AA76BC0F6440@CY4PR12MB1381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 023495660C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkIO8LrbtSOAvGnKoQFjCxekWCbGmg9dfuafQa9wJ2HZp/t4rYbXKDP3gupiT9ex0aEZyj3JGNBmQRmR+HIjmNTpXrNYcJABd8Z2VaP0UYZskTuBGS2ceECxty4VlAgBSqAi7feA3JqgHSwDu5BUKjLZ+gxGPsactzWSqiNS/q53ObEinOMhey9xKkYQKfrlGSympwQ8CmMuYgXnYQBHFI01PnD9oeg+HZUxn81CQk1gQGdDtT2ceuGtpU7Mq3z7bVCbm948IQsS4ma+c6v2Q6VKvxXcJX5BAbNFO5C2clGElhC2tDbhd7OTyaisiimddlXFldznf+tA4LlZL0OeRdIztKmV6pc6mJjsOLdLjtuujkexzpzonhg7paNjpNfIk74PeqVdCiZQksRcHUITyTx3dP1xqWh6EHaaoDmb3CiMYXEbqbGsWpoCXYQ3uIOl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 10:02:57.1745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e63209-d238-44b8-04fc-08d77320fa5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1381
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wp6wQl9y3fN6qX7d7G25OIwAXuz7A5YEGfEehez3Jg4=;
 b=gElYOqXv0bZyYSXEhbrQbxq11JGpnjgfPF+0PiMYmVQ8q1S0SzUdJJt9Pp9wE6bnUUHBy/pwI1iZxgFMUd+ofTzmWmWCkfYKbIRWny0+w3FtN5jxi/02TRZDv6wfcD1opyOLzM/u1+i+QCWd443AYk349NxLsCJ0ibctlHvdI78=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
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
Cc: guchun.chen@amd.com, tao.zhou1@amd.com, Le Ma <le.ma@amd.com>,
 alexander.deucher@amd.com, dennis.li@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127100233.fUzB8NmKpXPAVuXXr1ZXt8rjFxw5xdsYDO12hInkA6c@z>

TW92ZSB0aGUgcHJpbnQgb3V0IG9mIHV2ZCBpbnN0YW5jZSBsb29wIGluIGFtZGdwdV91dmRfc3Vz
cGVuZAoKdjI6IGRyb3AgdW5uZWNlc3NhcnkgYnJhY2tldHMKCkNoYW5nZS1JZDogSWZhZDk5N2Rl
YmQ4NDc2M2UxYjU1ZDY2OGUxNDRiNzI5NTk4ZjExNWUKU2lnbmVkLW9mZi1ieTogTGUgTWEgPGxl
Lm1hQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5j
IHwgMTAgKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dXZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMKaW5kZXggZTMy
NGJmZS4uNjkyNDhlY2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91dmQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMK
QEAgLTM3NiwxMyArMzc2LDE1IEBAIGludCBhbWRncHVfdXZkX3N1c3BlbmQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCiAJCQlyZXR1cm4gLUVOT01FTTsKIAogCQkvKiByZS13cml0ZSAwIHNp
bmNlIGVycl9ldmVudF9hdGh1YiB3aWxsIGNvcnJ1cHQgVkNQVSBidWZmZXIgKi8KLQkJaWYgKGFt
ZGdwdV9yYXNfaW50cl90cmlnZ2VyZWQoKSkgewotCQkJRFJNX1dBUk4oIlVWRCBWQ1BVIHN0YXRl
IG1heSBsb3N0IGR1ZSB0byBSQVMgRVJSRVZFTlRfQVRIVUJfSU5URVJSVVBUXG4iKTsKKwkJaWYg
KGFtZGdwdV9yYXNfaW50cl90cmlnZ2VyZWQoKSkKIAkJCW1lbXNldChhZGV2LT51dmQuaW5zdFtq
XS5zYXZlZF9ibywgMCwgc2l6ZSk7Ci0JCX0gZWxzZSB7CisJCWVsc2UKIAkJCW1lbWNweV9mcm9t
aW8oYWRldi0+dXZkLmluc3Rbal0uc2F2ZWRfYm8sIHB0ciwgc2l6ZSk7Ci0JCX0KIAl9CisKKwlp
ZiAoYW1kZ3B1X3Jhc19pbnRyX3RyaWdnZXJlZCgpKQorCQlEUk1fV0FSTigiVVZEIFZDUFUgc3Rh
dGUgbWF5IGxvc3QgZHVlIHRvIFJBUyBFUlJFVkVOVF9BVEhVQl9JTlRFUlJVUFRcbiIpOworCiAJ
cmV0dXJuIDA7CiB9CiAKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
