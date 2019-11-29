Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC660C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9DCD21781
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DCD21781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804786E10E;
	Fri, 29 Nov 2019 08:26:24 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820080.outbound.protection.outlook.com [40.107.82.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F476E10E
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 08:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/uAz7FkwOUSNUSrq44Vdy8DRkw1KlmjlbmE+MmjgCHz/0tqj/+24Mg9vPIXRtmYlKsYzkQ7ODw/k24q/0cdCrgWJpSbrFA8xmMmhWZlygyK2fCvbFoRJNC5RaT3vUQ8QhrgEs/3JBvhkskWiwWyw3dmcS+a2/EAoodmTVSszvciglawVSgMiPeUaCPwuGo+DyUxGDFpnjuXDU3xCavNeDeE+ebRod6J/emHIsvWlvTHednj5sPPIzQe1Invz30cZ495nZFvqXbDYLnlOBXA01tXob2qNCEpy0UFT3K2sZW0T7pjgOl4Yo85NsX2RJsMHSqZ4C0OrozD3uAYH6cs1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOA0D6oAi5ysncRGFjWdiACzkK+4AwaPqc0aJPOtFMU=;
 b=AGVwV3v6Nbv6WGtMZSZyXbczkSIvVY1WTL+og9l0Mhr/G+6uF0q3A0OkwUENnOR6Rx5mXSwYKRnVdmMjC5pNE+0RIvOjpzAS6/JkybkOLx08+DQYrIfNdXCd6C45TeXKRzV1ODF7Ot2lW8THwJAF4GJI2zMeqBsG4XFWcLXDYJ9pHZgURbTIg1SVuItaJRQAq/MzkXFbBy8qwg1mO2zhYkLuzJbJ523Z7ERFUiTMlXl9Ovd/7q8vlP44LnW25PY4ezD7wkxspzaPn3TS0MsDYvSnoHM2KwODuoO3njPoqdDOd84ywxFJap+1yWjG25zXm9LSNmGj2CraK8hiXJqMUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0068.namprd12.prod.outlook.com (2603:10b6:0:57::12) by
 BYAPR12MB2664.namprd12.prod.outlook.com (2603:10b6:a03:69::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Fri, 29 Nov 2019 08:26:20 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::201) by DM3PR12CA0068.outlook.office365.com
 (2603:10b6:0:57::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18 via Frontend
 Transport; Fri, 29 Nov 2019 08:26:20 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Fri, 29 Nov 2019 08:26:20 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 29 Nov
 2019 02:26:19 -0600
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 29 Nov 2019 02:26:18 -0600
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: not remove sysfs if not create sysfs
Date: Fri, 29 Nov 2019 16:26:16 +0800
Message-ID: <20191129082616.4979-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(428003)(189003)(199004)(70586007)(305945005)(14444005)(5024004)(70206006)(50226002)(48376002)(6862004)(81156014)(81166006)(4326008)(50466002)(53416004)(8936002)(8676002)(316002)(2616005)(16586007)(47776003)(45080400002)(54906003)(37006003)(426003)(36756003)(478600001)(186003)(6636002)(26005)(356004)(336012)(2351001)(1076003)(2906002)(51416003)(7696005)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2664; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0029811-0256-451e-81fe-08d774a5d01f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2664:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2664624F05489B358D3272BAE5460@BYAPR12MB2664.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 0236114672
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUGGlKwAqhla5qJWKNCbbyKFXkfr/0dH+lfly7WrXYulTJPr+Kg49NRQ7vSDebie4MyTaU1gSKRsXsyJWMuHPMM0G/FwADJGAlHCCqwShxp3y3NdBwZ2lu7et+NMqM6DPYphNB5oAU6rXRZUUWfWzdrEVT6kFLmSq5R/5vNSHg+DmwdE9WSN2WHlA3cAngvb1iAoVNx79rnQT8R66E4k79Z7A2Hj3N06HOt10LEHqkkTP/wp0wP7rGNhHw2RoCHTjXn0Q4zC1cBfQFR1nfi1GTZJfMN2U8zDoAfQWKypMuPfigw7NxtOsclj0mvOoJlBBDl3nOLouvDYWxqqSCozMhMHSConPCDMWrjAjH3/ohQk8S0QMdeyzTuDlBLtE6cZAhPr2BjBXNEB+r0wsXDZ1u4BoyF7bJbNHO1Ei/AMK/lBI/Fhfspw3hCUpu4AZxyL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2019 08:26:20.5525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0029811-0256-451e-81fe-08d774a5d01f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2664
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOA0D6oAi5ysncRGFjWdiACzkK+4AwaPqc0aJPOtFMU=;
 b=oZ2J0GtG36bNrECqBoqjE1FcFbMC3Q5Wfe2GEw40s7mPNiev6iaXme21p5Bmu2Yj17GGEaCRvaTDL1IRpHJIfM+pYbgG7gixUhUSvtxLRiEN2o3zCM5i+zIeKVI4n4QI41EdkUXwcIo2NzX7juo4cSLpmtAe1ttsBcj+x2SX8rM=
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2hlbiBsb2FkIGFtZGdwdSBmYWlsZWQgYmVmb3JlIGNyZWF0ZSBwbV9zeXNmcyBhbmQgdWNvZGVf
c3lzZnMsCnRoZSBwbV9zeXNmcyBhbmQgdWNvZGVfc3lzZnMgc2hvdWxkIG5vdCBiZSByZW1vdmVk
LgpPdGhlcndpc2UsIHRoZXJlIHdpbGwgYmUgd2FybmluZyBjYWxsIHRyYWNlIGp1c3QgbGlrZSBi
ZWxvdy4KWyAgIDI0LjgzNjM4Nl0gW2RybV0gVkNFIGluaXRpYWxpemVkIHN1Y2Nlc3NmdWxseS4K
WyAgIDI0Ljg0MTM1Ml0gYW1kZ3B1IDAwMDA6MDA6MDcuMDogYW1kZ3B1X2RldmljZV9pcF9pbml0
IGZhaWxlZApbICAgMjUuMzcwMzgzXSBhbWRncHUgMDAwMDowMDowNy4wOiBGYXRhbCBlcnJvciBk
dXJpbmcgR1BVIGluaXQKWyAgIDI1Ljg4OTU3NV0gW2RybV0gYW1kZ3B1OiBmaW5pc2hpbmcgZGV2
aWNlLgpbICAgMjYuMDY5MTI4XSBhbWRncHUgMDAwMDowMDowNy4wOiBbZHJtOmFtZGdwdV9yaW5n
X3Rlc3RfaGVscGVyIFthbWRncHVdXSAqRVJST1IqIHJpbmcga2lxXzIuMS4wIHRlc3QgZmFpbGVk
ICgtMTEwKQpbICAgMjYuMDcwMTEwXSBbZHJtOmdmeF92OV8wX2h3X2ZpbmkgW2FtZGdwdV1dICpF
UlJPUiogS0NRIGRpc2FibGUgZmFpbGVkClsgICAyNi4yMDAzMDldIFtUVE1dIEZpbmFsaXppbmcg
cG9vbCBhbGxvY2F0b3IKWyAgIDI2LjIwMDMxNF0gW1RUTV0gRmluYWxpemluZyBETUEgcG9vbCBh
bGxvY2F0b3IKWyAgIDI2LjIwMDM0OV0gW1RUTV0gWm9uZSAga2VybmVsOiBVc2VkIG1lbW9yeSBh
dCBleGl0OiAwIEtpQgpbICAgMjYuMjAwMzUxXSBbVFRNXSBab25lICAgZG1hMzI6IFVzZWQgbWVt
b3J5IGF0IGV4aXQ6IDAgS2lCClsgICAyNi4yMDAzNTNdIFtkcm1dIGFtZGdwdTogdHRtIGZpbmFs
aXplZApbICAgMjYuMjA1MzI5XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0K
WyAgIDI2LjIwNTMzMF0gc3lzZnMgZ3JvdXAgJ2Z3X3ZlcnNpb24nIG5vdCBmb3VuZCBmb3Iga29i
amVjdCAnMDAwMDowMDowNy4wJwpbICAgMjYuMjA1MzQ3XSBXQVJOSU5HOiBDUFU6IDAgUElEOiAx
MjI4IGF0IGZzL3N5c2ZzL2dyb3VwLmM6MjU2IHN5c2ZzX3JlbW92ZV9ncm91cCsweDgwLzB4OTAK
WyAgIDI2LjIwNTM0OF0gTW9kdWxlcyBsaW5rZWQgaW46IGFtZGdwdShPRSspIGdwdV9zY2hlZChP
RSkgdHRtKE9FKSBkcm1fa21zX2hlbHBlcihPRSkgZHJtKE9FKSBpMmNfYWxnb19iaXQgZmJfc3lz
X2ZvcHMgc3lzY29weWFyZWEgc3lzZmlsbHJlY3Qgc3lzaW1nYmx0IHJwY3NlY19nc3Nfa3JiNSBh
dXRoX3JwY2dzcyBuZnN2NCBuZnMgbG9ja2QgZ3JhY2UgZnNjYWNoZSBiaW5mbXRfbWlzYyBzbmRf
aGRhX2NvZGVjX2dlbmVyaWMgbGVkdHJpZ19hdWRpbyBjcmN0MTBkaWZfcGNsbXVsIHNuZF9oZGFf
aW50ZWwgY3JjMzJfcGNsbXVsIHNuZF9oZGFfY29kZWMgZ2hhc2hfY2xtdWxuaV9pbnRlbCBzbmRf
aGRhX2NvcmUgc25kX2h3ZGVwIHNuZF9wY20gc25kX3RpbWVyIGlucHV0X2xlZHMgc25kIGpveWRl
diBzb3VuZGNvcmUgc2VyaW9fcmF3IHBjc3BrciBldmJ1ZyBhZXNuaV9pbnRlbCBhZXNfeDg2XzY0
IGNyeXB0b19zaW1kIGNyeXB0ZCBtYWNfaGlkIGdsdWVfaGVscGVyIHN1bnJwYyBpcF90YWJsZXMg
eF90YWJsZXMgYXV0b2ZzNCA4MTM5dG9vIHBzbW91c2UgODEzOWNwIG1paSBpMmNfcGlpeDQgcGF0
YV9hY3BpIGZsb3BweQpbICAgMjYuMjA1MzY5XSBDUFU6IDAgUElEOiAxMjI4IENvbW06IG1vZHBy
b2JlIFRhaW50ZWQ6IEcgICAgICAgICAgIE9FICAgICA1LjIuMC1yYzEgIzEKWyAgIDI2LjIwNTM3
MF0gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5Niks
IEJJT1MgVWJ1bnR1LTEuOC4yLTF1YnVudHUxIDA0LzAxLzIwMTQKWyAgIDI2LjIwNTM3Ml0gUklQ
OiAwMDEwOnN5c2ZzX3JlbW92ZV9ncm91cCsweDgwLzB4OTAKWyAgIDI2LjIwNTM3NF0gQ29kZTog
ZTggMzUgYjkgZmYgZmYgNWIgNDEgNWMgNDEgNWQgNWQgYzMgNDggODkgZGYgZTggZjYgYjUgZmYg
ZmYgZWIgYzYgNDkgOGIgNTUgMDAgNDkgOGIgMzQgMjQgNDggYzcgYzcgNDggN2EgNzAgOTggZTgg
NjAgNjMgZDMgZmYgPDBmPiAwYiBlYiBkNyA2NiA5MCA2NiAyZSAwZiAxZiA4NCAwMCAwMCAwMCAw
MCAwMCAwZiAxZiA0NCAwMCAwMCA1NQpbICAgMjYuMjA1Mzc1XSBSU1A6IDAwMTg6ZmZmZmJlZTI0
MmIwYjkwOCBFRkxBR1M6IDAwMDEwMjgyClsgICAyNi4yMDUzNzZdIFJBWDogMDAwMDAwMDAwMDAw
MDAwMCBSQlg6IDAwMDAwMDAwMDAwMDAwMDAgUkNYOiAwMDAwMDAwMDAwMDAwMDA2ClsgICAyNi4y
MDUzNzddIFJEWDogMDAwMDAwMDAwMDAwMDAwNyBSU0k6IDAwMDAwMDAwMDAwMDAwOTIgUkRJOiBm
ZmZmOTdhZDZmODE3MzgwClsgICAyNi4yMDUzNzddIFJCUDogZmZmZmJlZTI0MmIwYjkyMCBSMDg6
IGZmZmZmZmZmOThmNTIwYzQgUjA5OiAwMDAwMDAwMDAwMDAwMmIzClsgICAyNi4yMDUzNzhdIFIx
MDogZmZmZmJlZTI0MmIwYjhmOCBSMTE6IDAwMDAwMDAwMDAwMDAyYjMgUjEyOiBmZmZmZmZmZmMw
ZTU4MjQwClsgICAyNi4yMDUzNzldIFIxMzogZmZmZjk3YWQ2ZDFmZTBiMCBSMTQ6IGZmZmY5N2Fk
NGRiOTU0YzggUjE1OiBmZmZmOTdhZDRkYjdmZmYwClsgICAyNi4yMDUzODBdIEZTOiAgMDAwMDdm
ZjNkOGExYzRjMCgwMDAwKSBHUzpmZmZmOTdhZDZmODAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAw
MDAwMDAwMDAKWyAgIDI2LjIwNTM4MV0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDog
MDAwMDAwMDA4MDA1MDAzMwpbICAgMjYuMjA1MzgxXSBDUjI6IDAwMDA3ZjliMmVmMWRmMDQgQ1Iz
OiAwMDAwMDAwNDJhYWI4MDAxIENSNDogMDAwMDAwMDAwMDM2MDZmMApbICAgMjYuMjA1Mzg0XSBE
UjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAw
MDAwMDAwMApbICAgMjYuMjA1Mzg1XSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAw
MGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMApbICAgMjYuMjA1Mzg1XSBDYWxsIFRyYWNl
OgpbICAgMjYuMjA1NDYxXSAgYW1kZ3B1X3Vjb2RlX3N5c2ZzX2ZpbmkrMHgxOC8weDIwIFthbWRn
cHVdClsgICAyNi4yMDU1MThdICBhbWRncHVfZGV2aWNlX2ZpbmkrMHgzYjQvMHg1NjAgW2FtZGdw
dV0KWyAgIDI2LjIwNTU3M10gIGFtZGdwdV9kcml2ZXJfdW5sb2FkX2ttcysweDRmLzB4YTAgW2Ft
ZGdwdV0KWyAgIDI2LjIwNTYyM10gIGFtZGdwdV9kcml2ZXJfbG9hZF9rbXMrMHhjZC8weDI1MCBb
YW1kZ3B1XQpbICAgMjYuMjA1NjM3XSAgZHJtX2Rldl9yZWdpc3RlcisweDEyYi8weDFjMCBbZHJt
XQpbICAgMjYuMjA1Njk1XSAgYW1kZ3B1X3BjaV9wcm9iZSsweDEyYS8weDFlMCBbYW1kZ3B1XQpb
ICAgMjYuMjA1Njk5XSAgbG9jYWxfcGNpX3Byb2JlKzB4NDcvMHhhMApbICAgMjYuMjA1NzAxXSAg
cGNpX2RldmljZV9wcm9iZSsweDEwNi8weDFiMApbICAgMjYuMjA1NzA0XSAgcmVhbGx5X3Byb2Jl
KzB4MjFhLzB4M2YwClsgICAyNi4yMDU3MDZdICBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4MTFjLzB4
MTQwClsgICAyNi4yMDU3MDddICBkZXZpY2VfZHJpdmVyX2F0dGFjaCsweDU4LzB4NjAKWyAgIDI2
LjIwNTcwOV0gIF9fZHJpdmVyX2F0dGFjaCsweGMzLzB4MTQwCgpTaWduZWQtb2ZmLWJ5OiBZaW50
aWFuIFRhbyA8eXR0YW9AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHUuaCAgICAgICAgfCAgMyArKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYyB8IDE2ICsrKysrKysrKysrKy0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTUgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5o
CmluZGV4IGMzYTM5NGQ4NDFhOC4uOTU4ZTgwMDVhNmNjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHUuaApAQCAtMTA0MSw2ICsxMDQxLDkgQEAgc3RydWN0IGFtZGdwdV9kZXZpY2Ugewog
CiAJdWludDY0X3QJCQl1bmlxdWVfaWQ7CiAJdWludDY0X3QJZGZfcGVyZm1vbl9jb25maWdfYXNz
aWduX21hc2tbQU1ER1BVX01BWF9ERl9QRVJGTU9OU107CisKKwlib29sCQkJCXBtX3N5c2ZzX2Vu
OworCWJvb2wJCQkJdWNvZGVfc3lzZnNfZW47CiB9OwogCiBzdGF0aWMgaW5saW5lIHN0cnVjdCBh
bWRncHVfZGV2aWNlICphbWRncHVfdHRtX2FkZXYoc3RydWN0IHR0bV9ib19kZXZpY2UgKmJkZXYp
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5kZXggZTdhMTc1
YTZhNDQ4Li4zZGExZjg0ZGIyNzQgMTAwNzU1Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMKQEAgLTMwMTMsMTIgKzMwMTMsMTggQEAgaW50IGFtZGdwdV9kZXZpY2VfaW5p
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJYW1kZ3B1X3BtX3ZpcnRfc3lzZnNfaW5p
dChhZGV2KTsKIAogCXIgPSBhbWRncHVfcG1fc3lzZnNfaW5pdChhZGV2KTsKLQlpZiAocikKKwlp
ZiAocikgeworCQlhZGV2LT5wbV9zeXNmc19lbiA9IGZhbHNlOwogCQlEUk1fRVJST1IoInJlZ2lz
dGVyaW5nIHBtIGRlYnVnZnMgZmFpbGVkICglZCkuXG4iLCByKTsKKwl9IGVsc2UKKwkJYWRldi0+
cG1fc3lzZnNfZW4gPSB0cnVlOwogCiAJciA9IGFtZGdwdV91Y29kZV9zeXNmc19pbml0KGFkZXYp
OwotCWlmIChyKQorCWlmIChyKSB7CisJCWFkZXYtPnVjb2RlX3N5c2ZzX2VuID0gZmFsc2U7CiAJ
CURSTV9FUlJPUigiQ3JlYXRpbmcgZmlybXdhcmUgc3lzZnMgZmFpbGVkICglZCkuXG4iLCByKTsK
Kwl9IGVsc2UKKwkJYWRldi0+dWNvZGVfc3lzZnNfZW4gPSB0cnVlOwogCiAJciA9IGFtZGdwdV9k
ZWJ1Z2ZzX2dlbV9pbml0KGFkZXYpOwogCWlmIChyKQpAQCAtMzExMyw3ICszMTE5LDggQEAgdm9p
ZCBhbWRncHVfZGV2aWNlX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAjZW5kaWYK
IAl9CiAJYW1kZ3B1X2ZlbmNlX2RyaXZlcl9maW5pKGFkZXYpOwotCWFtZGdwdV9wbV9zeXNmc19m
aW5pKGFkZXYpOworCWlmIChhZGV2LT5wbV9zeXNmc19lbikKKwkJYW1kZ3B1X3BtX3N5c2ZzX2Zp
bmkoYWRldik7CiAJYW1kZ3B1X2ZiZGV2X2ZpbmkoYWRldik7CiAJciA9IGFtZGdwdV9kZXZpY2Vf
aXBfZmluaShhZGV2KTsKIAlpZiAoYWRldi0+ZmlybXdhcmUuZ3B1X2luZm9fZncpIHsKQEAgLTMx
NDgsNyArMzE1NSw4IEBAIHZvaWQgYW1kZ3B1X2RldmljZV9maW5pKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQogCiAJYW1kZ3B1X2RlYnVnZnNfcmVnc19jbGVhbnVwKGFkZXYpOwogCWRldmlj
ZV9yZW1vdmVfZmlsZShhZGV2LT5kZXYsICZkZXZfYXR0cl9wY2llX3JlcGxheV9jb3VudCk7Ci0J
YW1kZ3B1X3Vjb2RlX3N5c2ZzX2ZpbmkoYWRldik7CisJaWYgKGFkZXYtPnVjb2RlX3N5c2ZzX2Vu
KQorCQlhbWRncHVfdWNvZGVfc3lzZnNfZmluaShhZGV2KTsKIAlpZiAoSVNfRU5BQkxFRChDT05G
SUdfUEVSRl9FVkVOVFMpKQogCQlhbWRncHVfcG11X2ZpbmkoYWRldik7CiAJYW1kZ3B1X2RlYnVn
ZnNfcHJlZW1wdF9jbGVhbnVwKGFkZXYpOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
