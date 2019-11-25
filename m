Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A57BC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 15:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA3202082F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 15:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3202082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EEDF895D7;
	Mon, 25 Nov 2019 15:40:33 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760079.outbound.protection.outlook.com [40.107.76.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D05895D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 15:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbqrGsLOh9ZKF1HNUnNK0NUfANWAC9PcxD3cO5bifMSbQ067igMgvK0k4piB5lDGKCaIykz+eqVNwmqGopvI9BeJGGUt6J3MQAha+U9YCa/rCbi1cnFdrWDmm8EplJneFtbCFvZMrEUuHibhW9lL/y7Ra9J5mjLodHoQubvPz+mg9KMjB6xfkPymbC6g++/F1/IrP6Aq43xs1m4sKYu/mhXSTN70gIh8rpOsRx142SDYhkiTvigPbzT0CRjsH+se570KZykWpEdBLcSksd59ONBcrJXsKGfNlKVAf0XP92hDlFAL3S3GrEJkKfLD/nrurWpjwMeUDTtqHh4pzPs26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhd1L3TVxtvkXH2NpFNuRjhdFH2CXt7+RBxvyVO60KI=;
 b=Wkj/5yOBWLM1zczag7CDmW3j/dUm86fg+C3CfqxwPeU61iuEtzltkVZ8cK9tnTZRVEL+UwCqdiF7Eco50U023Al4dtFqDRH7q8WabjJNIxJIVom2U4S7S1X4NztG+hrq3RbS7qsVbpmMvi/G15LASTtTfjYq8ZCL3NbinOkZM+erMixXxScSOfdvduepNyOF9IB6ef+TflveXNWNq4EtFAlP/NdGhDj2nnnmeWVJ7F282JQjhR8IxaaG0nlAzbVKBStQUovZjTM+6sjiQ6+moar+P5eyG19isMmeDSpd4HrHgiwE/DP1XkMB/1EdfnPZGMKgVvYVvsd2dxLaTTpnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0045.namprd12.prod.outlook.com (2603:10b6:0:56::13) by
 CH2PR12MB3894.namprd12.prod.outlook.com (2603:10b6:610:2b::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.18; Mon, 25 Nov 2019 15:40:30 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::207) by DM3PR12CA0045.outlook.office365.com
 (2603:10b6:0:56::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Mon, 25 Nov 2019 15:40:30 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Mon, 25 Nov 2019 15:40:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 Nov
 2019 09:40:29 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 Nov
 2019 09:40:29 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 Nov 2019 09:40:29 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Null check aconnector in
 event_property_validate
Date: Mon, 25 Nov 2019 10:40:24 -0500
Message-ID: <20191125154024.21218-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(428003)(189003)(199004)(6916009)(4326008)(70586007)(70206006)(2351001)(47776003)(1076003)(478600001)(6666004)(53416004)(356004)(7696005)(81166006)(336012)(81156014)(36756003)(8936002)(316002)(48376002)(5660300002)(26005)(50466002)(2906002)(305945005)(14444005)(2616005)(426003)(186003)(50226002)(8676002)(86362001)(51416003)(16586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3894; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb79b30a-1dfb-45b5-2fa8-08d771bdcd4d
X-MS-TrafficTypeDiagnostic: CH2PR12MB3894:
X-Microsoft-Antispam-PRVS: <CH2PR12MB389414C6ED1D24A9A4EE12FDF94A0@CH2PR12MB3894.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0232B30BBC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8qotT8DU74HsU12z47cB/875mpsIAey8fnFAILGCDYH3N21iYBLZDer1Ya9MSpFeMGjWj3cThy8HY4EZgVM17wwMMHZOcrKuB1Vrwm95eM7HD9XqTxPxI/v0FCCkZp0QuiqfCjYAqo7X9xzryasvfEv/yMGXZfMOQSdOMQqeeg7ZKsTwgUffYeCYVqkrrX+N/2iZkIHNTyIBZuSmLuRESzInAcrsgIhYN4V7mxVrFhErxj+QuaSxRXIMgFiqZoocUYtbBPJMtJkG4FP57tyns2AIhhJlzNeo/z1qkiZfewA2mdH8iMQh+Czjm69zSafyN0qsYH1OwGML8wi3gXOUt6ShZCtjxMV9qC7bjjADBKNDrO6Iam1re7NJoq9bfpmBVqRayGW+dt9O/sRqV7Os8w9jud9Kfgn2F2JdRLP6b9nf82Z9TMTvmWWaKABT5hVE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 15:40:30.2349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb79b30a-1dfb-45b5-2fa8-08d771bdcd4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3894
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhd1L3TVxtvkXH2NpFNuRjhdFH2CXt7+RBxvyVO60KI=;
 b=KUhSan0P9d0erKzO5yGDTLK7aCZ1drNMJiHrfVf2IRzt0guCgrl4n5waLS+iNSvuO/1zyby4zgl5vPFyL9+Zf9DV2eG+3Pc68eGTckeacu4tjUViFb0N6nsFZv8E/1vhLK+c7ySVjMUO3rL7uwrOhjAi/fSwVLZaz3dzvFJdf3w=
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125154024.u8VniipDvqFn0eIz3iyHhx5ZxLgJ4JgX0dgF6fn6_ns@z>

W1doeV0KcHJldmlvdXNseSBldmVudF9wcm9wZXJ0eV92YWxpZGF0ZSB3YXMgb25seSBjYWxsZWQg
YWZ0ZXIgd2UgZW5hYmxlZCB0aGUgZGlzcGxheS4KQnV0IGFmdGVyICJSZWZhY3RvciBIRENQIHRv
IGhhbmRsZSBtdWx0aXBsZSBkaXNwbGF5cyBwZXIgbGluayIgdGhpcyBmdW5jdGlvbgpjYW4gYmUg
Y2FsbGVkIGF0IGFueSB0aW1lLiBJbiBjZXJ0YWluIGNhc2VzIHdlIGRvbid0IGhhdmUgYSBhY29u
bmVjdG9yCgpbSG93XQpOdWxsIGNoZWNrIGFjb25uZWN0b3IgYW5kIGV4aXQgZWFybHkuIFRoaXMg
aXMgb2sgYmVjYXVzZSB3ZSBvbmx5IG5lZWQgdG8gY2hlY2sgdGhlCkVOQUJMRUQtPkRFU0lSRUQg
dHJhbnNpdGlvbiBpZiBhIGNvbm5lY3RvciBleGlzdHMuCgpGaXhlcyA6Y2M1ZGFlOWY2Mjg2IGRy
bS9hbWQvZGlzcGxheTogUmVmYWN0b3IgSERDUCB0byBoYW5kbGUgbXVsdGlwbGUgZGlzcGxheXMg
cGVyIGxpbmsKU2lnbmVkLW9mZi1ieTogQmhhd2FucHJlZXQgTGFraGEgPEJoYXdhbnByZWV0Lkxh
a2hhQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG1faGRjcC5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbV9oZGNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbV9oZGNwLmMKaW5kZXggZjY4NjRhNTE4OTFhLi5hZTMyOTMzNWRmY2MgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hkY3AuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZGNw
LmMKQEAgLTIyNSw2ICsyMjUsOSBAQCBzdGF0aWMgdm9pZCBldmVudF9wcm9wZXJ0eV92YWxpZGF0
ZShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJc3RydWN0IG1vZF9oZGNwX2Rpc3BsYXlfcXVl
cnkgcXVlcnk7CiAJc3RydWN0IGFtZGdwdV9kbV9jb25uZWN0b3IgKmFjb25uZWN0b3IgPSBoZGNw
X3dvcmstPmFjb25uZWN0b3I7CiAKKwlpZiAoIWFjb25uZWN0b3IpCisJCXJldHVybjsKKwogCW11
dGV4X2xvY2soJmhkY3Bfd29yay0+bXV0ZXgpOwogCiAJcXVlcnkuZW5jcnlwdGlvbl9zdGF0dXMg
PSBNT0RfSERDUF9FTkNSWVBUSU9OX1NUQVRVU19IRENQX09GRjsKLS0gCjIuMTcuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
