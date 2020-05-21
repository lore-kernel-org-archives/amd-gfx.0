Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F595C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 10:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63530206F6
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 10:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="auRea0u0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63530206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0944E6E110;
	Thu, 21 May 2020 10:43:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F2E6E110
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 10:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOZ+MDCyuKcgiQud161oNud0vaguNBuczVGIb7DYNBn36/oSVKierKn0rb1sRyEOn8kORoomI0PZVF+tBhyx2Fdz/e99EjaJvgVSk9M84PGLzNSazHwAxauVZEEgcniZcmlG/MoRFdCcMsZWH65IVjNDIS5SLYH8TNndQdQk6khyqkEy/DXqgtYyasVebrX42+bMPQvfbs0uayhKeITZO48ZxdRq/5pFlQ3K3cUbo5ME5X9iG9vFO0Skvc0AErR3mmjwFFMZyUbIM3JZ3a8FD3uzomVVBM4eFyXNGhT7iyHSSkbfXpfYQZhDFfI5Fum1QgikO98Z4inGZf9T7iZtgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVoySnLZRcZG46h4lcsY9If3OGePmxhpQvoxaFmtnc0=;
 b=Dm5AztNruRXbqbj9C145Be82xAOuSX1Vu5PwmrGD5wBKxBCPL/XyEr7AOxwp3VV8SKM2w3eMy3mLXBeewJELvsLPUn5THTuNX16UA+mHq+Vr41nrMWHDXP2louX19dSGXcmbuzvmxRVSNAn+CCGtK7TW8kjxQD2LCeQK9Ju+4pkEEC/+atRqRTrFnuzW9OdmWRRC58ynisgeGK3pNidBbUMbu5LH0BK8bXaxw0IbG4Yf8jt+5fpS4LOkl2isDvK4AS521labiF+GriKuvKfB8SsrTAiw54O9zGQOVERggT/yNk//jSZhY5kw33IgJAYREetYpWrqcQ3L2iziEa+SQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVoySnLZRcZG46h4lcsY9If3OGePmxhpQvoxaFmtnc0=;
 b=auRea0u09IROfkn3NX/4j1W1dS+EMPFwvnZz6RSMwghNSRlX577Sph75PojnX4dayOthDaS9+yXk0Pwu5NCQ3C3wgjwlhfeeRP4wfw/BwqAgsgQw0qiCAvCbo3iZf9rluDb4W11TYVUA3GGJWnDXzgCCTwDj9J2eTrJPjXip7PI=
Received: from BN6PR11CA0007.namprd11.prod.outlook.com (2603:10b6:405:2::17)
 by BYAPR12MB2823.namprd12.prod.outlook.com (2603:10b6:a03:96::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 10:43:28 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::53) by BN6PR11CA0007.outlook.office365.com
 (2603:10b6:405:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Thu, 21 May 2020 10:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 10:43:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 21 May
 2020 05:43:27 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 21 May
 2020 05:43:27 -0500
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 21 May 2020 05:43:26 -0500
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerpay: Disable gfxoff when setting manual mode on
 picasso and raven
Date: Thu, 21 May 2020 18:43:14 +0800
Message-ID: <1590057794-14232-1-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966005)(82310400002)(6666004)(81166007)(426003)(336012)(186003)(316002)(70586007)(26005)(2616005)(7696005)(356005)(2906002)(70206006)(36756003)(82740400003)(8936002)(5660300002)(86362001)(8676002)(47076004)(478600001)(4326008)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a615b796-c67b-4286-fb70-08d7fd73cb99
X-MS-TrafficTypeDiagnostic: BYAPR12MB2823:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2823BCA009DF5D80B224A6B19DB70@BYAPR12MB2823.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jcVHqdwhWzUA18rb9zOkuspnp2apcvMtpGKs/30ob8KuJNi4nl9Dph0SPH8A0ESXaSkYHbxvu7DFe16e9dCucPw+2bL2Ptv71nUOpJ97ub7J8m1Td814HxlDrZQbMHxWq4mHUEdb862PgmXZEoxa7BeO5RwCrIg+2kUbVen5JGRrmNI54HtF9c+WUvoF1dS0myPV1y5TePck8WWMaftEVhVcfKw9E42tU+q61ojUhElu1GRmGOovvABgdO/UZgyTubkmZL9Qrltyhgx2n9ir9HQAMHbZgSsaVBbhX4F5Nidnov904o9S60FayL0eIW7HZXUhF09s2kP86AECSaZ+iQFJIzNxk7eHCmixVC6mKIDECgOSOs7bj9/1dxGC6mtrfVaRwb/mJ/114f6TkqlHg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 10:43:27.4707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a615b796-c67b-4286-fb70-08d7fd73cb99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2823
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
Cc: chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1Byb2JsZW0gZGVzY3JpcHRpb25dCjEuIEJvb3QgdXAgcGljYXNzbyBwbGF0Zm9ybSwgbGF1bmNo
ZXMgZGVza3RvcCwgRG9uJ3QgZG8gYW55dGhpbmcgKEFQVSBlbnRlciBpbnRvICJnZnhvZmYiIHN0
YXRlKQoyLiBSZW1vdGUgbG9naW4gdG8gcGxhdGZvcm0gdXNpbmcgU1NILCB0aGVuIHR5cGUgdGhl
IGNvbW1hbmQgbGluZToKCXN1ZG8gc3UgLWMgImVjaG8gbWFudWFsID4gL3N5cy9jbGFzcy9kcm0v
Y2FyZDAvZGV2aWNlL3Bvd2VyX2RwbV9mb3JjZV9wZXJmb3JtYW5jZV9sZXZlbCIKCXN1ZG8gc3Ug
LWMgImVjaG8gMiA+IC9zeXMvY2xhc3MvZHJtL2NhcmQwL2RldmljZS9wcF9kcG1fc2NsayIgKGZp
eCBTQ0xLIHRvIDE0MDBNSHopCjMuIE1vdmUgdGhlIG1vdXNlIGFyb3VuZCBpbiBXaW5kb3cKNC4g
UGhlbm9tZW5vbiA6ICBUaGUgc2NyZWVuIGZyb3plbgoKVGVzdGVyIHdpbGwgc3dpdGNoIHNjbGsg
bGV2ZWwgZHVyaW5nIGdsbWFyazIgcnVuIHRpbWUuCkFQVSB3aWxsIGVudGVyICJnZnhvZmYiIHN0
YXRlIGludGVybWl0dGVudGx5IGR1cmluZyBnbG1hcmsyIHJ1biB0aW1lLgpUaGUgc3lzdGVtIGdv
dCBoYW5nZWQgaWYgZml4IEdGWENMSyB0byAxNDAwTUh6IHdoZW4gQVBVIGlzIGluICJnZnhvZmYi
CnN0YXRlLgoKW0RlYnVnXQoxLiBGaXggU0NMSyB0byBYIE1IegoJMTQwMDogc2NyZWVuIGZyb3pl
biwgc2NyZWVuIGJsYWNrLCB0aGVuIE9TIHdpbGwgcmVib290LgoJMTMwMDogc2NyZWVuIGZyb3pl
bi4KCTEyMDA6IHNjcmVlbiBmcm96ZW4sIHNjcmVlbiBibGFjay4KCTExMDA6IHNjcmVlbiBmcm96
ZW4sIHNjcmVlbiBibGFjaywgdGhlbiBPUyB3aWxsIHJlYm9vdC4KCTEwMDA6IHNjcmVlbiBmcm96
ZW4sIHNjcmVlbiBibGFjay4KCTkwMDogIHNjcmVlbiBmcm96ZW4sIHNjcmVlbiBibGFjaywgdGhl
biBPUyB3aWxsIHJlYm9vdC4KCTgwMDogIFNpdHVhdGlvbiBOb21hbCwgaXNzdWUgZGlzYXBwZWFy
LgoJNzAwOiAgU2l0dWF0aW9uIE5vbWFsLCBpc3N1ZSBkaXNhcHBlYXIuCjIuIFNCSU9TIHNldHRp
bmc6IEFNRCBDQlMgLS0+IFNNVSBEZWJ1ZyBPcHRpb25zIC0tPlNNVSBEZWJ1ZyAtLT4gIkdGWCBE
TERPIFBzbSBNYXJnaW4gQ29udHJvbCI6Cgk1MCA6IFNpdHVhdGlvbiBOb21hbCwgaXNzdWUgZGlz
YXBwZWFyLgoJNDUgOiBTaXR1YXRpb24gTm9tYWwsIGlzc3VlIGRpc2FwcGVhci4KCTQwIDogU2l0
dWF0aW9uIE5vbWFsLCBpc3N1ZSBkaXNhcHBlYXIuCgkzNSA6IFNpdHVhdGlvbiBOb21hbCwgaXNz
dWUgZGlzYXBwZWFyLgoJMzAgOiBzY3JlZW4gYmxhY2suCgkyNSA6IHNjcmVlbiBmcm96ZW4sIHRo
ZW4gYmx1cnJlZCBzY3JlZW4uCgkyMCA6IHNjcmVlbiBmcm96ZW4uCgkxNSA6IHNjcmVlbiBibGFj
ay4KCTEwIDogc2NyZWVuIGZyb3plbi4KCTUgIDogc2NyZWVuIGZyb3plbiwgdGhlbiBibHVycmVk
IHNjcmVlbi4KMy4gRGlzYWJsZSBHRlhPRkYgZmVhdHVyZQoJU2l0dWF0aW9uIE5vbWFsLCBpc3N1
ZSBkaXNhcHBlYXIuCgpbV2h5XQpUaHJvdWdoIGEgcGVyaW9kIG9mIHRpbWUgZGVidWdnaW5nIHdp
dGggU3lzIEVuZyB0ZWFtIGFuZCBTTVUgdGVhbSwgU3lzCkVuZyB0ZWFtIHNhaWQgdGhpcyBpcyB2
b2x0YWdlL2ZyZXF1ZW5jeSBtYXJnaW5hbCBpc3N1ZSBub3QgYSBGL1cgb3IgSC9XCmJ1Zy4gVGhp
cyBleHBlcmltZW50IHByb3ZlcyB0aGF0IGRlZmF1bHQgdGFyZ2V0UHNtIFtmb3IgZj0xNDAwTUh6
XSBpcwpub3Qgc3VmZmljaWVudCB3aGVuIEdGWE9GRiBpcyBlbmFibGVkIG9uIFBpY2Fzc28uCgpT
TVUgdGVhbSB0aGluayBpdCBpcyBhbiBvZGQgdGVzdCBjb25kaXRpb25zIHRvIGZvcmNlIHNjbGs9
IjE0MDBNSHoiIHdoZW4KR1BVIGlzIGluICJnZnhvZmYiIHN0YXRl77yMdGhlbiB3YWtlIHVwIHRo
ZSBHRlguIFNDTEsgc2hvdWxkIGJlIGluIHRoZQoibG93ZXN0IGZyZXF1ZW5jeSIgd2hlbiBnZnhv
ZmYuCgpbSG93XQpEaXNhYmxlIGdmeG9mZiB3aGVuIHNldHRpbmcgbWFudWFsIG1vZGUuCkVuYWJs
ZSBnZnhvZmYgd2hlbiBzZXR0aW5nIG90aGVyIG1vZGUoZXhpdGluZyBtYW51YWwgbW9kZSkgYWdh
aW4uCgpCeSB0aGUgd2F5LCBmcm9tIHRoZSB1c2VyIHBvaW50IG9mIHZpZXcsIG5vdyB0aGF0IHVz
ZXIgc3dpdGNoIHRvIG1hbnVhbAptb2RlIGFuZCBmb3JjZSBTQ0xLIEZyZXF1ZW5jeSwgaGUgZG9u
J3Qgd2FudCBTQ0xLIGJlIGNvbnRyb2xsZWQgYnkKd29ya2xvYWQuSXQgYmVjb21lcyBtZWFuaW5n
bGVzcyB0byAic3dpdGNoIHRvIG1hbnVhbCBtb2RlIiBpZiBBUFUgZW50ZXIgImdmeG9mZiIKZHVl
IHRvIGxhY2sgb2Ygd29ya2xvYWQgYXQgdGhpcyBwb2ludC4KClRpcHM6IFNhbWUgaXNzdWUgb2Jz
ZXJ2ZWQgb24gUmF2ZW4uCgpTaWduZWQtb2ZmLWJ5OiBjaGVuIGdvbmcgPGN1cnJ5LmdvbmdAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYyB8IDkgKysr
KysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcG0uYwppbmRleCAxN2JjN2Y1Li5kNDUzOTRjIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYwpAQCAtMzcxLDYgKzM3MSwxNSBAQCBzdGF0aWMgc3Np
emVfdCBhbWRncHVfc2V0X3Bvd2VyX2RwbV9mb3JjZV9wZXJmb3JtYW5jZV9sZXZlbChzdHJ1Y3Qg
ZGV2aWNlICpkZXYsCiAJCXJldHVybiBjb3VudDsKIAl9CiAKKwlpZihhZGV2LT5hc2ljX3R5cGUg
PT0gQ0hJUF9SQVZFTil7CisJCWlmIChhZGV2LT5yZXZfaWQgPCA4KXsKKwkJCWlmIChjdXJyZW50
X2xldmVsICE9IEFNRF9EUE1fRk9SQ0VEX0xFVkVMX01BTlVBTCAmJiBsZXZlbCA9PSBBTURfRFBN
X0ZPUkNFRF9MRVZFTF9NQU5VQUwpCisJCQkJYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxz
ZSk7CisJCQllbHNlIGlmIChjdXJyZW50X2xldmVsID09IEFNRF9EUE1fRk9SQ0VEX0xFVkVMX01B
TlVBTCAmJiBsZXZlbCAhPSBBTURfRFBNX0ZPUkNFRF9MRVZFTF9NQU5VQUwpCisJCQkJYW1kZ3B1
X2dmeF9vZmZfY3RybChhZGV2LCB0cnVlKTsKKwkJfQorCX0KKwogCS8qIHByb2ZpbGVfZXhpdCBz
ZXR0aW5nIGlzIHZhbGlkIG9ubHkgd2hlbiBjdXJyZW50IG1vZGUgaXMgaW4gcHJvZmlsZSBtb2Rl
ICovCiAJaWYgKCEoY3VycmVudF9sZXZlbCAmIChBTURfRFBNX0ZPUkNFRF9MRVZFTF9QUk9GSUxF
X1NUQU5EQVJEIHwKIAkgICAgQU1EX0RQTV9GT1JDRURfTEVWRUxfUFJPRklMRV9NSU5fU0NMSyB8
Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
