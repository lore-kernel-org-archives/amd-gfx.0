Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2A9C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 08:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1AAF206C3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 08:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xU4CAQ7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AAF206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5A4D6E5D3;
	Wed, 20 May 2020 08:32:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B95256E5D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 08:32:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSve4Ag6BIHe+RSfdLs6xasMI4rEzaVIe71UDgEIZGif3pxQdFVdfFoKK0BW6SajvT3zjJjK+N7wbIFkyTHhemmRBMM2tdoihIh0M23BNyngAMBN6emwHoKPm8CCLi+tqC6MQoqya33qscMN698kaAKLzcwzdXE0l0SDIRHrrwrMQWD4iiYWSypCDnF7vXLseSqQmBzoomwNDyNtmqqayZDf/hA/rh93OxEl2HAX2Juo3jaeesTKyCtVf4YrYkHo96z5gUTP1Xs/uyBO7c4RMJB5V+B+i56QKEDJxhs2+KfEsJoLrbnfufMOVg7G/Pxy9/dbCsvncQctRHac0yHTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SfAirp4uBLPnp+RHOHV27IlBFDXboErsChJus22GQ4=;
 b=YpcDMGwZAcpHlUlNc8JMRpezrQASkqZn9Gk6P7Ip1PFJ/fyz3lS3lqe9KlmzVbVfic/B42FnZONgU2qRsEnfbjJgIVkC564qvysaFmgsYmEoSyc63+erNPSczJAsj77GeTMBncMeQ86jhtbjX6ifzqZQL/wIkJFKXpJNKLhGfHf37BtAxWv7ZHOvsYWZL5mJIed7is+sk70AWvB03wJklqTuB1s2l8n80My0yxJJtjOsMfSJWCBnnAZwi6kqHf1UiqczyEVcvkxmdqJ2hGRPmahuIkyWAoDa+6A2w65xBeI6I4NbVPWjd46XPc0pSL++84ZesEnVCXLIWGnlijL4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SfAirp4uBLPnp+RHOHV27IlBFDXboErsChJus22GQ4=;
 b=xU4CAQ7G09vtgeg95Angg6C21JgfgCngn8+cXoDLeYJkexMmXVBt9ya091mcpbyYjzC7zp/5BzOcEWDUI4uiiZCBLJn6+zbntIn+LehhPeuqpy9v+FmxEm52fYaFA/s5nvgOWvNY5rACN9RxBcd7s3bFnSM20wKoBQ9Ps/+Ntgk=
Received: from BN8PR04CA0014.namprd04.prod.outlook.com (2603:10b6:408:70::27)
 by DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Wed, 20 May
 2020 08:32:04 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::7) by BN8PR04CA0014.outlook.office365.com
 (2603:10b6:408:70::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Wed, 20 May 2020 08:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 08:32:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 20 May
 2020 03:32:00 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 20 May
 2020 03:32:00 -0500
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 20 May 2020 03:31:59 -0500
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerpay: Disable gfxoff when setting manual mode on
 picasso and raven
Date: Wed, 20 May 2020 16:31:56 +0800
Message-ID: <1589963516-25033-1-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966005)(316002)(2906002)(6666004)(86362001)(426003)(2616005)(7696005)(336012)(70586007)(26005)(36756003)(186003)(82310400002)(70206006)(4326008)(356005)(8676002)(81166007)(5660300002)(478600001)(8936002)(6916009)(47076004)(82740400003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8aee8cb7-39db-406d-ba24-08d7fc98464b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:
X-Microsoft-Antispam-PRVS: <DM5PR12MB250470C0E91E2EB6055D9BDC9DB60@DM5PR12MB2504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 64FIHsMqCuiRtaf7Kg/UUamsve44h8U4Rgb2Oys6iCT84e3fTbqxd2cQQy9REzIZRTkEQMlKqxfJWO2j0J8Ib0KEfYjALEC75xyi5KArU1tSma0M2cMCL7Rl7TRkCTme/tmggKsl2xHIRoaO0Dccnv9lVSBTtCU6qiy1+fWG0FVUBK7mgi8mbCj9bbjEZfdOuhAOyzHuP0CiCW0OImxFXfWky2ZylOTDnnSr5IBVugTzkn8bpnDCCqm2+ym44VbEiye83pq8X4p3bzij/fR3yST/8KbQeQiHEHqYgF11RwqiCR/KeIztf25DYIgx8OX7tQORGomOYDRoei0N/lrQyxijUzMs2vcOO9bblToA9EhlOUi2P8qkqamPzjNfRRHXiqw6hC7hcviSL3CrQ6+I2yfsVeVjJumAS3lZyZN2sCjOzcZX7IqDxQST67MYhBRjxDGatjAxfaKyvAo5UnlfHXvkRlPepVjC923HLbhxG0Qe42eC206Gi4eIXP67QxsbaRwWs8Sn7ys16RmNYV+QDw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 08:32:04.0331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aee8cb7-39db-406d-ba24-08d7fc98464b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
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
IGNvbW1hbmQgbGluZToKICAgc3VkbyBzdSAtYyAiZWNobyBtYW51YWwgPiAvc3lzL2NsYXNzL2Ry
bS9jYXJkMC9kZXZpY2UvcG93ZXJfZHBtX2ZvcmNlX3BlcmZvcm1hbmNlX2xldmVsIgogICBzdWRv
IHN1IC1jICJlY2hvIDIgPiAvc3lzL2NsYXNzL2RybS9jYXJkMC9kZXZpY2UvcHBfZHBtX3NjbGsi
ICAgKGZpeCBTQ0xLIHRvIDE0MDBNSHopCjMuIE1vdmUgdGhlIG1vdXNlIGFyb3VuZCBpbiBXaW5k
b3cKNC4gUGhlbm9tZW5vbiA6ICBUaGUgc2NyZWVuIGZyb3plbgoKVGVzdGVyIHdpbGwgc3dpdGNo
IHNjbGsgbGV2ZWwgZHVyaW5nIGdsbWFyazIgcnVuIHRpbWUuIEFQVSB3aWxsIGVudGVyCiJnZnhv
ZmYiIHN0YXRlIGludGVybWl0dGVudGx5IGR1cmluZyBnbG1hcmsyIHJ1biB0aW1lLiBUaGUgc3lz
dGVtIGdvdApoYW5nZWQgaWYgZml4IEdGWENMSyB0byAxNDAwTUh6IHdoZW4gQVBVIGlzIGluICJn
ZnhvZmYiIHN0YXRlLgoKW0RlYnVnXQoxLiBGaXggU0NMSyB0byBYIE1IegogICAgMTQwMDogc2Ny
ZWVuIGZyb3plbiwgc2NyZWVuIGJsYWNrLCB0aGVuIE9TIHdpbGwgcmVib290LgogICAgMTMwMDog
c2NyZWVuIGZyb3plbgogICAgMTIwMDogc2NyZWVuIGZyb3plbiwgc2NyZWVuIGJsYWNrLgogICAg
MTEwMDogc2NyZWVuIGZyb3plbiwgc2NyZWVuIGJsYWNrLCB0aGVuIE9TIHdpbGwgcmVib290Lgog
ICAgMTAwMDogc2NyZWVuIGZyb3plbiwgc2NyZWVuIGJsYWNrLgogICAgOTAwOiAgc2NyZWVuIGZy
b3plbiwgc2NyZWVuIGJsYWNrLCB0aGVuIE9TIHdpbGwgcmVib290LgogICAgODAwOiAgU2l0dWF0
aW9uIE5vbWFsLCBpc3N1ZSBkaXNhcHBlYXIuCiAgICA3MDA6ICBTaXR1YXRpb24gTm9tYWwsIGlz
c3VlIGRpc2FwcGVhci4KMi4gU0JJT1Mgc2V0dGluZzogQU1EIENCUyAtLT4gU01VIERlYnVnIE9w
dGlvbnMgLS0+U01VIERlYnVnIC0tPiAiR0ZYIERMRE8gUHNtIE1hcmdpbiBDb250cm9sIjoKICAg
IDUwIDogU2l0dWF0aW9uIE5vbWFsLCBpc3N1ZSBkaXNhcHBlYXIuCiAgICA0NSA6IFNpdHVhdGlv
biBOb21hbCwgaXNzdWUgZGlzYXBwZWFyLgogICAgNDAgOiBTaXR1YXRpb24gTm9tYWwsIGlzc3Vl
IGRpc2FwcGVhci4KICAgIDM1IDogU2l0dWF0aW9uIE5vbWFsLCBpc3N1ZSBkaXNhcHBlYXIuCiAg
ICAzMCA6IHNjcmVlbiBibGFjay4KICAgIDI1IDogc2NyZWVuIGZyb3plbiwgdGhlbiBibHVycmVk
IHNjcmVlbi4KICAgIDIwIDogc2NyZWVuIGZyb3plbi4KICAgIDE1IDogc2NyZWVuIGJsYWNrLgog
ICAgMTAgOiBzY3JlZW4gZnJvemVuLgogICAgNSAgOiBzY3JlZW4gZnJvemVuLCB0aGVuIGJsdXJy
ZWQgc2NyZWVuLgozLiBEaXNhYmxlIEdGWE9GRiBmZWF0dXJlCiAgIFNpdHVhdGlvbiBOb21hbCwg
aXNzdWUgZGlzYXBwZWFyLgoKW1doeV0KVGhyb3VnaCBhIHBlcmlvZCBvZiB0aW1lIGRlYnVnZ2lu
ZyB3aXRoIFN5cyBFbmcgdGVhbSBhbmQgU01VIHRlYW0uCgpTeXMgRW5nIHRlYW0gc2FpZCB0aGlz
IGlzIHZvbHRhZ2UvZnJlcXVlbmN5IG1hcmdpbmFsIGlzc3VlIG5vdCBhIEYvVyBvcgpIL1cgYnVn
LiBUaGlzIGV4cGVyaW1lbnQgcHJvdmVzIHRoYXQgZGVmYXVsdCB0YXJnZXRQc20gW2ZvciBmPTE0
MDBNSHpdCmlzIG5vdCBzdWZmaWNpZW50IHdoZW4gR0ZYT0ZGIGlzIGVuYWJsZWQgb24gUGljYXNz
by4KClNNVSB0ZWFtIHRoaW5rIGl0IGlzIGFuIG9kZCB0ZXN0IGNvbmRpdGlvbnMgdG8gZm9yY2Ug
c2Nsaz0iMTQwME1IeiIgd2hlbgpHUFUgaXMgaW4gImdmeG9mZiIgc3RhdGXvvIx0aGVuIHdha2Ug
dXAgdGhlIEdGWC4gU0NMSyBzaG91bGQgYmUgaW4gdGhlCiJsb3dlc3QgZnJlcXVlbmN5IiB3aGVu
IGdmeG9mZi4KCltIb3ddCkRpc2FibGUgZ2Z4b2ZmIHdoZW4gc2V0dGluZyBtYW51YWwgbW9kZS4K
CkJ5IHRoZSB3YXksIGZyb20gdGhlIHVzZXIgcG9pbnQgb2Ygdmlldywgbm93IHRoYXQgdXNlciBz
d2l0Y2ggdG8gbWFudWFsCm1vZGUgYW5kIGZvcmNlIFNDTEsgRnJlcXVlbmN5LCBoZSBkb24ndCB3
YW50IFNDTEsgYmUgY29udHJvbGxlZCBieQp3b3JrbG9hZC4gSXQgYmVjb21lcyBtZWFuaW5nbGVz
cyB0byAic3dpdGNoIHRvIG1hbnVhbCBtb2RlIiBpZiBBUFUgZW50ZXIKImdmeG9mZiIgZHVlIHRv
IGxhY2sgb2Ygd29ya2xvYWQgYXQgdGhpcyBwb2ludC4KClRpcHM6IFNhbWUgaXNzdWUgb2JzZXJ2
ZWQgb24gUmF2ZW4uCgpTaWduZWQtb2ZmLWJ5OiBjaGVuIGdvbmcgPGN1cnJ5LmdvbmdAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5j
IHwgNiArKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdtZ3IuYwppbmRleCA0Zjhj
MWI4Li42MDJiZTYzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9o
d21nci9zbXUxMF9od21nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3
bWdyL3NtdTEwX2h3bWdyLmMKQEAgLTU2NSw2ICs1NjUsNyBAQCBzdGF0aWMgaW50IHNtdTEwX2h3
bWdyX2JhY2tlbmRfZmluaShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQogc3RhdGljIGludCBzbXUx
MF9kcG1fZm9yY2VfZHBtX2xldmVsKHN0cnVjdCBwcF9od21nciAqaHdtZ3IsCiAJCQkJZW51bSBh
bWRfZHBtX2ZvcmNlZF9sZXZlbCBsZXZlbCkKIHsKKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diA9IGh3bWdyLT5hZGV2OwogCXN0cnVjdCBzbXUxMF9od21nciAqZGF0YSA9IGh3bWdyLT5iYWNr
ZW5kOwogCXVpbnQzMl90IG1pbl9zY2xrID0gaHdtZ3ItPmRpc3BsYXlfY29uZmlnLT5taW5fY29y
ZV9zZXRfY2xvY2s7CiAJdWludDMyX3QgbWluX21jbGsgPSBod21nci0+ZGlzcGxheV9jb25maWct
Pm1pbl9tZW1fc2V0X2Nsb2NrLzEwMDsKQEAgLTczMCw2ICs3MzEsMTEgQEAgc3RhdGljIGludCBz
bXUxMF9kcG1fZm9yY2VfZHBtX2xldmVsKHN0cnVjdCBwcF9od21nciAqaHdtZ3IsCiAJCQkJCQlO
VUxMKTsKIAkJYnJlYWs7CiAJY2FzZSBBTURfRFBNX0ZPUkNFRF9MRVZFTF9NQU5VQUw6CisJCWlm
IChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9SQVZFTil7CisJCQlpZiAoYWRldi0+cmV2X2lkIDwg
OCkKKwkJCQlzbXUxMF9nZnhfb2ZmX2NvbnRyb2woaHdtZ3IsIGZhbHNlKTsKKwkJfQorCQlicmVh
azsKIAljYXNlIEFNRF9EUE1fRk9SQ0VEX0xFVkVMX1BST0ZJTEVfRVhJVDoKIAlkZWZhdWx0Ogog
CQlicmVhazsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
