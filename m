Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F1FC432C3
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 08:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4727B206BF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 08:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4727B206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0292C6E287;
	Tue, 26 Nov 2019 08:51:16 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800057.outbound.protection.outlook.com [40.107.80.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E4B06E287
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 08:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUhYwTDT2QmVWvjAOEpx7wwBnuYadMO/s4SZbmKSBXEHt9kLQEw+YMjFjx+Xs5W9Xsp+YzLOLBUeMLTIPm88FApYKBHfVueGB8siLCs7CQW0aVQvTOX8dGDNRalyL+qh3tvwCNoFYAS7HBnmbNICCNQSR3JDmSPwYie2H5L7CHvb1Qf+MXvZwaMhnsbDP6cppcOhwYq3PB7enkZ2rycZFtzU4jtnaLBcAmCL+xvSa2MfxQwjBb7yUT0QEjHyHugNYONKKi6SM5o9Wo5eDrzK8KiHM0bG5zfzBgevovwH5RoZ+CciVnTDIoDgx7pdDNzYxOBsN9XzHQH68vUr9SxBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFvDbGOJTbcX1kuBwu5p7b3UuBrMEds2ex67Dx4hc7A=;
 b=lW7Rv1lq93q2sfvszlT/2KuCzsdzrlZE+nkD1J1EBMI4U2aA2zMsYtBVlZYjTODbaOvy7i/D+xmO3gzRXQuRGoEhcXwSH6cWyzjQs6uZ87CjY6XPcwE8ROCT73sVVJdIw6XhmrE8NxYxmKhhODAOzkJln4o2Pg564DIgxn6agyvWf0O8Q4NolY+VibO0pTaSc/xp4Cdpk6bGLK25o6R9WrpqGqEdLeL33gE+ntRfVJ+s/hGpMg9EKMbuGcn9FLfUCZkpojGiAko1Ftle+JUnRZHBFUr2lRdtSV0D3P5XJeXzffCH8fNR2Htaj9Py3qf2cvsPaaYbm2JirBbE8qHBfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MWHPR12CA0054.namprd12.prod.outlook.com (2603:10b6:300:103::16)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.24; Tue, 26 Nov
 2019 08:51:11 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::205) by MWHPR12CA0054.outlook.office365.com
 (2603:10b6:300:103::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17 via Frontend
 Transport; Tue, 26 Nov 2019 08:51:11 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Tue, 26 Nov 2019 08:51:10 +0000
Received: from swae-HP-ProBook-455R-G6 (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 26 Nov
 2019 02:51:08 -0600
Date: Tue, 26 Nov 2019 16:51:25 +0800
From: Louis Li <ching-li@amd.com>
To: Harry Wentland <hwentlan@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix Apple dongle cannot be
 successfully detected
Message-ID: <20191126085125.GA10261@swae-HP-ProBook-455R-G6>
References: <20191114034212.1106-1-Ching-shih.Li@amd.com>
 <MN2PR12MB406250AEB8A10A080050D952AA4E0@MN2PR12MB4062.namprd12.prod.outlook.com>
 <3c30b486-7062-ade2-0dbd-7288fbf595c1@amd.com>
 <3ee8d870-c461-c68f-4a36-f2bf17e9e81f@amd.com>
 <20191122063359.GA13420@swae-HP-ProBook-455R-G6>
 <2d828fee-b8c7-ec8c-f454-2574fd68ed45@amd.com>
 <20191125094956.GA18516@swae-HP-ProBook-455R-G6>
 <95bdabb4-e216-559e-1a93-fb492903a7a0@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <95bdabb4-e216-559e-1a93-fb492903a7a0@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB02.amd.com (10.181.40.143) To SATLEXMB01.amd.com
 (10.181.40.142)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(428003)(47660400002)(199004)(189003)(13464003)(16526019)(70206006)(5660300002)(55016002)(8676002)(7736002)(81166006)(81156014)(14444005)(1076003)(305945005)(9686003)(6636002)(4326008)(6862004)(356004)(478600001)(8936002)(70586007)(6306002)(966005)(229853002)(6246003)(6666004)(336012)(50466002)(33656002)(11346002)(426003)(186003)(47776003)(33716001)(6116002)(3846002)(2906002)(316002)(54906003)(53546011)(386003)(4001150100001)(76176011)(2870700001)(26005)(446003)(23756003)(58126008)(46800400005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3925; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c76d76e7-5f17-4a1a-26c2-08d7724dc937
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <CH2PR12MB3925139B80E9B324A3144880AA450@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0233768B38
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OvhK6DRXLM83bkovfnxfElPCuqhfR6Cp/YasSUsJZcQ1XFPcT4p96OryoTWh5qQwqgK41F4UfFImL04SigFAA9tQcOWGFg2yv8ZIF/XWWekPpfOzwYVoQ7qAQ0lbJZ9OebB+bq9fw/T0gCDrMyI3JnxHu37m1//xyZBhYBOfGGTGo41SLCuK5quBH5nq3Lw9fCOZv+FC27JAttBvb8Hs1XjUQBhKtTKhAUx1bgFwFUdhp4OYtcs9m5g2pDPCAA7D/ec44txSYQ95OpZSievZaPM5GdoQPPPtfCbT78PzJStUdqJPVjWYemPD1hdL5N569VOFTgXy5nCMmzfe+RE/zxG0vDLNiUqNlEj/1wREmX/c/PbqqKGvk8PhopO3QACaNzWulukhiooyVIVq03+Qa58kPrSIq0WtubnS1LVUWzW9JG3p0QOnYybgzb9TGjugpsC+ctbXuu9Es579MVxjbSAVZ9t2z7jNu4vL8I2tKPQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 08:51:10.9665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c76d76e7-5f17-4a1a-26c2-08d7724dc937
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFvDbGOJTbcX1kuBwu5p7b3UuBrMEds2ex67Dx4hc7A=;
 b=fWV5kbNPq89IwJGkUoiiI/ggZw8d0TqRRoLXr0JtoVzVB1h5Q/fXNbw8o7gOF7c7+GklGB363S2OYiMISKuHwvioxR0UPfgw9c1x0spFQwkJoHSIAAhcgULRg1rl3KFBi+5LZXGRuvHoG+T2InPzB1jMMWGd+aqbgyeQl/ROUoY=
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Ching-shih \(Louis\)" <Ching-shih.Li@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126085125.pndW8IA4VXOnR2ZSBqctOMb3QF-MkIgbFUko9BRVO-k@z>

T24gTW9uLCBOb3YgMjUsIDIwMTkgYXQgMDk6MjQ6NTZBTSAtMDUwMCwgSGFycnkgV2VudGxhbmQg
d3JvdGU6Cj4gCj4gCj4gT24gMjAxOS0xMS0yNSA0OjQ5IGEubS4sIExvdWlzIExpIHdyb3RlOgo+
ID4gT24gRnJpLCBOb3YgMjIsIDIwMTkgYXQgMTA6MzE6MTlBTSAtMDUwMCwgSGFycnkgV2VudGxh
bmQgd3JvdGU6Cj4gPj4KPiA+Pgo+ID4+IE9uIDIwMTktMTEtMjIgMTozMyBhLm0uLCBMb3VpcyBM
aSB3cm90ZToKPiA+Pj4gT24gVGh1LCBOb3YgMjEsIDIwMTkgYXQgMDg6NDc6NTBBTSAtMDUwMCwg
S2F6bGF1c2thcywgTmljaG9sYXMgd3JvdGU6Cj4gPj4+PiBPbiAyMDE5LTExLTIxIDg6NDAgYS5t
LiwgS2F6bGF1c2thcywgTmljaG9sYXMgd3JvdGU6Cj4gPj4+Pj4gT24gMjAxOS0xMS0yMSAzOjMx
IGEubS4sIExpLCBDaGluZy1zaGloIChMb3Vpcykgd3JvdGU6Cj4gPj4+Pj4+IEhpIHJldmlld2Vy
cywKPiA+Pj4+Pj4KPiA+Pj4+Pj4gV2hhdCBpcyB0aGUgcmV2aWV3IHJlc3VsdCBmb3IgdGhpcyBw
YXRjaD8gQ3VzdG9tZXIgaXMgcHVzaGluZyBvbiB0aGlzCj4gPj4+Pj4+IGNoYW5nZSB0byBtZXJn
ZS4gVEtTIGZvciB5b3VyIGF0dGVudGlvbi4KPiA+Pj4+Pj4KPiA+Pj4+Pj4gQlIsCj4gPj4+Pj4+
IExvdWlzCj4gPj4+Pj4+Cj4gPj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPj4+
Pj4+IEZyb206IExvdWlzIExpIDxDaGluZy1zaGloLkxpQGFtZC5jb20+Cj4gPj4+Pj4+IFNlbnQ6
IFRodXJzZGF5LCBOb3ZlbWJlciAxNCwgMjAxOSAxMTo0MiBBTQo+ID4+Pj4+PiBUbzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+Pj4+Pj4gQ2M6IEthemxhdXNrYXMsIE5pY2hvbGFz
IDxOaWNob2xhcy5LYXpsYXVza2FzQGFtZC5jb20+OyBXZW50bGFuZCwgSGFycnkKPiA+Pj4+Pj4g
PEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+OyBMaSwgQ2hpbmctc2hpaCAoTG91aXMpIDxDaGluZy1z
aGloLkxpQGFtZC5jb20+Cj4gPj4+Pj4+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gZHJtL2FtZC9kaXNw
bGF5OiBGaXggQXBwbGUgZG9uZ2xlIGNhbm5vdCBiZQo+ID4+Pj4+PiBzdWNjZXNzZnVsbHkgZGV0
ZWN0ZWQKPiA+Pj4+Pj4KPiA+Pj4+Pj4gW1doeV0KPiA+Pj4+Pj4gRXh0ZXJuYWwgbW9uaXRvciBj
YW5ub3QgYmUgZGlzcGxheWVkIGNvbnNpc3RlbnRseSwgaWYgY29ubmVjdGluZyB2aWEKPiA+Pj4+
Pj4gdGhpcyBBcHBsZSBkb25nbGUgKEExNjIxLCBVU0IgVHlwZS1DIHRvIEhETUkpLgo+ID4+Pj4+
PiBCeSBleHBlcmltZW50cywgaXQgaXMgY29uZmlybWVkIHRoYXQgdGhlIGRvbmdsZSBuZWVkcyAy
MDBtcyBhdCBsZWFzdCB0bwo+ID4+Pj4+PiBiZSByZWFkeSBmb3IgY29tbXVuaWNhdGlvbiwgYWZ0
ZXIgaXQgc2V0cyBIUEQgc2lnbmFsIGhpZ2guCj4gPj4+Pj4+Cj4gPj4+Pj4+IFtIb3ddCj4gPj4+
Pj4+IFdoZW4gcmVjZWl2aW5nIEhQRCBJUlEsIGRlbGF5IDMwMG1zIGF0IHRoZSBiZWdpbm5pbmcg
b2YgaGFuZGxlX2hwZF9pcnEoKS4KPiA+Pj4+Pj4gVGhlbiBydW4gdGhlIG9yaWdpbmFsIHByb2Nl
ZHVyZS4KPiA+Pj4+Pj4gV2l0aCB0aGlzIHBhdGNoIGFwcGxpZWQsIHRoZSBwcm9ibGVtIGNhbm5v
dCBiZSByZXByb2R1Y2VkLgo+ID4+Pj4+PiBXaXRoIG90aGVyIGRvbmdsZXMsIHRlc3QgcmVzdWx0
cyBhcmUgUEFTUy4KPiA+Pj4+Pj4gVGVzdCByZXN1bHQgaXMgUEFTUyB0byBwbHVnIGluIEhETUkg
Y2FibGUgd2hpbGUgcGxheWluZyB2aWRlbywgYW5kIHRoZQo+ID4+Pj4+PiB2aWRlbyBpcyBiZWlu
ZyBwbGF5aW5nIHNtb290aGx5Lgo+ID4+Pj4+PiBUZXN0IHJlc3VsdCBpcyBQQVNTIGFmdGVyIHN5
c3RlbSByZXN1bWVzIGZyb20gc3VzcGVuZC4KPiA+Pj4+Pj4KPiA+Pj4+Pj4gU2lnbmVkLW9mZi1i
eTogTG91aXMgTGkgPENoaW5nLXNoaWguTGlAYW1kLmNvbT4KPiA+Pj4+Pgo+ID4+Pj4+IFRoaXMg
aXMgc3RpbGwgYSBOQUsgZnJvbSBtZSBzaW5jZSB0aGUgbG9naWMgaGFzbid0IGNoYW5nZWQgZnJv
bSB0aGUgZmlyc3QKPiA+Pj4+PiBwYXRjaC4KPiA+Pj4+Pgo+ID4+Pj4+IFNsZWVwcyBkb24ndCBi
ZWxvbmcgaW4gSVJRIGhhbmRsZXJzLgo+ID4+Pj4+Cj4gPj4+Pj4gUmVnYXJkcywKPiA+Pj4+PiBO
aWNob2xhcyBLYXpsYXVza2FzCj4gPj4+Pgo+ID4+Pj4gQWN0dWFsbHksIHRoaXMgbGl2ZXMgaW4g
dGhlIGxvdyBJUlEgY29udGV4dCB3aGljaCBtZWFucyB0aGF0IGl0J3MgYWxyZWFkeQo+ID4+Pj4g
YmVlbiBxdWV1ZWQgb2ZmIHRvIGEgd29yayB0aHJlYWQgc28gaXQncyBzYWZlIHRvIHNsZWVwLgo+
ID4+Pj4KPiA+Pj4+IEknbSBub3Qgc3VyZSB3ZSB3YW50IGEgZ2VuZXJhbCAzMDBtcyBzbGVlcCAo
ZXZlbiBieSBleHBlcmltZW50IHlvdSBzYWlkIHRoYXQKPiA+Pj4+IGl0IG9ubHkgbmVlZGVkIDIw
MG1zKSBmb3IgYWxsIGNvbm5lY3RvcnMuCj4gPj4+Pgo+ID4+Pj4gTmljaG9sYXMgS2F6bGF1c2th
cwo+ID4+Pj4KPiA+Pj4KPiA+Pj4gWWVzLCBpdCBpcyBJUlEgY29udGV4dC4gU2FmZSB0byBjYWxs
IHNsZWVwKCkuIE1vcmVvdmVyLCBpbiBjdXJyZW50IGRyaXZlciwKPiA+Pj4gZXZlbiB1ZGVsYXko
KSBpcyBjYWxsZWQgaW4gd2FpdF9mb3JfdHJhaW5pbmdfYXV4X3JkX2ludGVydmFsKCkgaW4gdGhl
IGZsb3cKPiA+Pj4gb2YgaGFuZGxlX2hwZF9pcnEoKS4KPiA+Pj4KPiA+Pj4gRm9yIDJuZCBxdWVz
dGlvbiwgb2YgY291cnNlIG5vdCBhbGwgY29ubmVjdG9ycyBoYXZlIHRoaXMgYmVoYXZpb3IuCj4g
Pj4+IEJhc2VkIG9uIHJlYWwgY2FzZXMgd2UgZXZlciBkZWFsdCwgc29tZSBkb25nbGVzIGxpa2Ug
dGhpcywgb3Igc29tZQo+ID4+PiBtb25pdG9ycyBkcml2ZW4gYnkgVENPTiwgaGF2ZSBzYW1lIGJl
aGF2aW9yLiBBbmQgbm8gY2hhbmNlIHRvIHJlYWQKPiA+Pj4gb3V0IGFueXRoaW5nIHRvIGRlY2lk
ZSBpZiBkZWxheSBpcyBuZWVkZWQuIFRoaXMgY2hhbmdlIGRvZXMgaGVscAo+ID4+PiB0byBoYXZl
IG91ciBkcml2ZXIgZ2FpbiBiZXR0ZXIgY29tcGF0aWJpbGl0eS4gVHJ1bHkgdGhpcyBzaG91bGQg
YmUKPiA+Pj4gcHJvYmxlbSBvZiBkb25nbGVzL21vbml0b3JzLiBXZSBhcmUgbm90IHRoZSBvbmx5
IG9uZSB0bwo+ID4+PiB3b3JrYXJvdW5kIHN1Y2ggYSBwcm9ibGVtLiBUaGlzIGNoYW5nZSBkb2Vz
IG5vdCBodXJ0IG90aGVyIGNvbm5lY3RzLAo+ID4+PiBhbmQgc29tZSBvdGhlciBkb25nbGVzIGFy
ZSB0ZXN0ZWQgb2ssIGUuZy4gSFAvSHV3YWkgZG9uZ2xlcywgZXRjLgo+ID4+Pgo+ID4+Cj4gPj4g
SSBzdGlsbCBkb24ndCBsaWtlIHRoaXMgY2hhbmdlLiBJdCBtaWdodCBpbXBhY3Qgb3RoZXIgdXNl
IGNhc2VzLCBzdWNoIGFzCj4gPj4gU1NULXRvLU1TVCBzd2l0Y2hpbmcgb24gTVNUIGRpc3BsYXlz
Lgo+ID4+Cj4gPj4gSGF2ZSB5b3UgY2hlY2tlZCBob3cgV2luZG93cyBkZWFscyB3aXRoIHRoaXMg
ZG9uZ2xlIGFuZCBob3cgdGhlIFdpbmRvd3MKPiA+PiB0ZWFtIHNvbHZlZCB0aGlzPyBIYXZlIHlv
dSBjaGVja2VkIGhvdyBvdGhlciBkcml2ZXJzIChzdWNoIGFzIGk5MTUpIGRlYWwKPiA+PiB3aXRo
IHRoaXMgZG9uZ2xlPwo+ID4+Cj4gPj4gSGF2ZSB5b3UgY2hlY2tlZCB3aGV0aGVyIHlvdSBjYW4g
cGFzcyBEUCBjb21wbGlhbmNlIHdpdGggdGhpcyBjaGFuZ2U/Cj4gPj4KPiA+PiBIYXJyeQo+ID4+
Cj4gPiAKPiA+IEdvb2QgcG9pbnRzLiBNU1QgYW5kIERQIGNvbXBsaWFuY2UgYXJlIG5vdCB2ZXJp
ZmllZCB5ZXQuCj4gPiAKPiA+IEZvciBXaW5kb3dzIGNhc2VzLCBzYW1lIHNvbHV0aW9uIHdhcyBp
bXBsZW1lbnRlZC4gQXMgSSBrbm93LCBpdCBnb2VzIHRvCj4gPiBwb2ludCByZWxlYXNlIChQUikg
aW5zdGVhZCBvZiBtYWluIGxpbmUuIENvbXBhbnkgTi4gaGFzIHNpbWlsYXIgc29sdXRpb24KPiA+
IHRvIHdvcmthcm91bmQgc3VjaCBhIHByb2JsZW0uIEZvciBpOTE1LCB0aGUgc29sdXRpb24gc2Vl
bXMgdG8gYmUgZGlmZmVyZW50Lgo+ID4gCj4gPiBXaWxsIHRoaXMgY2hhbmdlIGJlIGFjY2VwdGVk
IGlmIGl0IGNhbiBwYXNzIE1TVCBhbmQgY29tcGlsYW5jZT8KPiA+IAo+IAo+IFNhbWUgYXMgZm9y
IFdpbmRvd3MgSSdtIG5vdCBjb252aW5jZWQgdGhhdCB0aGlzIGNoYW5nZSBzaG91bGQgZ28gaW50
bwo+IG1haW5saW5lLiBJZiB0aGUgY3VzdG9tZXIgbmVlZHMgYSB3b3JrYXJvdW5kIHdlIGNhbiBh
bHdheXMgcHJvdmlkZSBpdCBvbgo+IGEgY3VzdG9tZXIgYnJhbmNoLgo+IAo+IEhhcnJ5Cj4gCgpV
bmRlcnN0YW5kLiBGb3J3YXJkIHRoaXMgY29tbWVudCB0byBjdXN0b21lci4gTm90IHN1cmUgd2hh
dCByZXNwb25zZSB3aWxsCmJlLgoKPiA+IExvdWlzCj4gPiAKPiA+Pj4+Pgo+ID4+Pj4+PiAtLS0K
PiA+Pj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYyB8IDUgKysrKysKPiA+Pj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KQo+ID4+Pj4+Pgo+ID4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+ID4+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiA+Pj4+Pj4gaW5kZXggMGFlZjkyYjdjMDM3
Li41Yjg0NGI2YTVhNTkgMTAwNjQ0Cj4gPj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiA+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+ID4+Pj4+PiBAQCAtMTAyNSw2
ICsxMDI1LDExIEBAIHN0YXRpYyB2b2lkIGhhbmRsZV9ocGRfaXJxKHZvaWQgKnBhcmFtKQo+ID4+
Pj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fZGV2aWNlICpkZXYgPSBjb25uZWN0b3ItPmRldjsK
PiA+Pj4+Pj4gwqDCoMKgwqDCoCBlbnVtIGRjX2Nvbm5lY3Rpb25fdHlwZSBuZXdfY29ubmVjdGlv
bl90eXBlID0gZGNfY29ubmVjdGlvbl9ub25lOwo+ID4+Pj4+PiArwqDCoMKgIC8qIFNvbWUgbW9u
aXRvcnMvZG9uZ2xlcyBuZWVkIGFyb3VuZCAyMDBtcyB0byBiZSByZWFkeSBmb3IKPiA+Pj4+Pj4g
Y29tbXVuaWNhdGlvbgo+ID4+Pj4+PiArwqDCoMKgwqAgKiBhZnRlciB0aG9zZSBkZXZpY2VzIGRy
aXZlIEhQRCBzaWduYWwgaGlnaC4KPiA+Pj4+Pj4gK8KgwqDCoMKgICovCj4gPj4+Pj4+ICvCoMKg
wqAgbXNsZWVwKDMwMCk7Cj4gPj4+Pj4+ICsKPiA+Pj4+Pj4gwqDCoMKgwqDCoCAvKiBJbiBjYXNl
IG9mIGZhaWx1cmUgb3IgTVNUIG5vIG5lZWQgdG8gdXBkYXRlIGNvbm5lY3RvciBzdGF0dXMgb3IK
PiA+Pj4+Pj4gbm90aWZ5IHRoZSBPUwo+ID4+Pj4+PiDCoMKgwqDCoMKgwqAgKiBzaW5jZSAoZm9y
IE1TVCBjYXNlKSBNU1QgZG9lcyB0aGlzIGluIGl0J3Mgb3duIGNvbnRleHQuCj4gPj4+Pj4+IMKg
wqDCoMKgwqDCoCAqLwo+ID4+Pj4+PiAtLSAKPiA+Pj4+Pj4gMi4yMS4wCj4gPj4+Pj4+Cj4gPj4+
Pj4KPiA+Pj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+ID4+Pj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gPj4+Pj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPiA+Pj4+PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngKPiA+Pj4+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
