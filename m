Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE0FC432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 06:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A2C20674
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 06:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A2C20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A07356E1F9;
	Fri, 22 Nov 2019 06:38:55 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740043.outbound.protection.outlook.com [40.107.74.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E11B56E1F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 06:38:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOGOkBJYpBemfCbaQQXX6olRPXA31yNZavcWq9fr3DhumKcLX7ht30Yh0G+ZNsc2DNLizLPZOJcsZR7zrmwE7up3yL1vm49Sf2pdnY2WwcgrCbrflLt0G0QiQCid0KLhPneSKpzNuKnVGqCynEf/ZghhywbjCOSdt1yOhVXpUtvrMFzw4yK7mf3al1CUS+ylbLns77uDK7rQkpESmPudajyYWVaTM8PS4R2LS09SOo3wiHGFaWn6ypxqW0JHrX5q7ckR6+8mgB3nYXc8YQbwHb9fBmKdrvlfal1alS9jm7fIXr7LNHmWabXavGGh9dnVLWpNOxCSs+iFSjo19cJZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHVlaEyWTGABAzIjTEjThhKxyGoE2y33i+1DaQOAUP8=;
 b=Red45RmPjM6xHuvxhNO3y+3/ey8adHCb5dnREXC6XKvEJcGHxXvtwxyRWkhBSTg4h6q2n1SV598C6E1HahQs8QtFobrkoA20nOzEi3E1hZMOX/syX+BLPX2sJ9HZuMebfLa6GV+E9Ve+3OO7sLy9IUD+bVuUUuZP/4Mgd1BuwPDbwMffM5q+pQZADXlDIPmRcCOpWnt1G1xZZn50Zetr0VGH08BFFJUrJGlWEhUuq9WKJJgQ0N5Mu7M1fqG+UhFF+rtuWRb9Ly0LgG/yNT9ANeQkkbI1peih/E6J5y8VVWhtO1n9gTwIPLzCjYVTRHlvqky7YxujrcGRWXvhyiJ6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from SN1PR12CA0095.namprd12.prod.outlook.com (2603:10b6:802:21::30)
 by MN2PR12MB3102.namprd12.prod.outlook.com (2603:10b6:208:c6::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Fri, 22 Nov
 2019 06:38:51 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::208) by SN1PR12CA0095.outlook.office365.com
 (2603:10b6:802:21::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2474.18 via Frontend
 Transport; Fri, 22 Nov 2019 06:38:51 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Fri, 22 Nov 2019 06:38:51 +0000
Received: from swae-HP-ProBook-455R-G6 (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 22 Nov
 2019 00:38:49 -0600
Date: Fri, 22 Nov 2019 14:33:59 +0800
From: Louis Li <ching-li@amd.com>
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix Apple dongle cannot be
 successfully detected
Message-ID: <20191122063359.GA13420@swae-HP-ProBook-455R-G6>
References: <20191114034212.1106-1-Ching-shih.Li@amd.com>
 <MN2PR12MB406250AEB8A10A080050D952AA4E0@MN2PR12MB4062.namprd12.prod.outlook.com>
 <3c30b486-7062-ade2-0dbd-7288fbf595c1@amd.com>
 <3ee8d870-c461-c68f-4a36-f2bf17e9e81f@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3ee8d870-c461-c68f-4a36-f2bf17e9e81f@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB01.amd.com (10.181.40.142) To SATLEXMB01.amd.com
 (10.181.40.142)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(39860400002)(346002)(428003)(47660400002)(13464003)(189003)(199004)(186003)(53546011)(26005)(386003)(446003)(336012)(16526019)(4001150100001)(11346002)(6636002)(5660300002)(478600001)(14444005)(1076003)(426003)(305945005)(70206006)(70586007)(76176011)(7736002)(2870700001)(6862004)(81166006)(81156014)(2906002)(6116002)(8936002)(23756003)(33716001)(33656002)(8676002)(316002)(58126008)(54906003)(6246003)(50466002)(4326008)(9686003)(55016002)(6306002)(47776003)(6666004)(3846002)(356004)(229853002)(46800400005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3102; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33cf2a6e-c363-4b78-c51f-08d76f16a307
X-MS-TrafficTypeDiagnostic: MN2PR12MB3102:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <MN2PR12MB310260D4AFE37579B584475DAA490@MN2PR12MB3102.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0p003Ssyky7Y4DUM1azGUWA2JLzRtWZvCUR6h6uUWwaH4sknvDcagZv6JdhJJuoX4EXmtHlizzSuZrUN4Z78lLWDzvWhrasoweCuFoSjMndOkiZWwcFejx6n/THUP7XgJGvgwzcaEdfHV5ZquLrSHoN4APY3hZxPJJj/vab5uqLZ0EgXEvW30ApHkXAhH3dDeGtfmHFuWwMXePe8rdLTkG+T4yrTu2fDiPXocAAQf1aacZiJT4pW0qxmE/84TKjUqyh2IdbUmVZykWxo4HyWPb0XhUBt+zeljcbZk+KfPFl+2Z5d4MR+ZQTJxhLDOE8TC9MgAk0l/yiCTz4BZyoKXxscOC9GAIdUREXuUVWwsn3hconTM4C/yDXrIQGtd8zLEnvhN0YIBWuN/uFf+DzRmebdv2UxZEA0bM3COaAIGY1pqrQtAeHqlo5c1DMEaySDkBN3bWN0zR7/IqGVqPVL1Aw6FzseooToVmux29V47bE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 06:38:51.0533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cf2a6e-c363-4b78-c51f-08d76f16a307
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3102
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHVlaEyWTGABAzIjTEjThhKxyGoE2y33i+1DaQOAUP8=;
 b=RE0ZCnkoWZ7T4XoxOgkVPZaQrtC5+hwIfSTPvR1KGzUhTjk6e2u2wzQJtg64uOpvVpdh9S3OaF9Wozytb55fKkz/DwWN55m8M4eMkfRv0aPcJbt0cZ5Bss5xQJCfUVkjGwel/4+JVrcldoPoHmaZadvFRosfCCM1rEHvkoNtNR0=
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Ching-shih \(Louis\)" <Ching-shih.Li@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191122063359.CHSZ3zJYHCmAsnDpcGpMEZuHVxq5p1VZf1q5bEIA11g@z>

T24gVGh1LCBOb3YgMjEsIDIwMTkgYXQgMDg6NDc6NTBBTSAtMDUwMCwgS2F6bGF1c2thcywgTmlj
aG9sYXMgd3JvdGU6Cj4gT24gMjAxOS0xMS0yMSA4OjQwIGEubS4sIEthemxhdXNrYXMsIE5pY2hv
bGFzIHdyb3RlOgo+ID5PbiAyMDE5LTExLTIxIDM6MzEgYS5tLiwgTGksIENoaW5nLXNoaWggKExv
dWlzKSB3cm90ZToKPiA+PkhpIHJldmlld2VycywKPiA+Pgo+ID4+V2hhdCBpcyB0aGUgcmV2aWV3
IHJlc3VsdCBmb3IgdGhpcyBwYXRjaD8gQ3VzdG9tZXIgaXMgcHVzaGluZyBvbiB0aGlzCj4gPj5j
aGFuZ2UgdG8gbWVyZ2UuIFRLUyBmb3IgeW91ciBhdHRlbnRpb24uCj4gPj4KPiA+PkJSLAo+ID4+
TG91aXMKPiA+Pgo+ID4+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+PkZyb206IExvdWlz
IExpIDxDaGluZy1zaGloLkxpQGFtZC5jb20+Cj4gPj5TZW50OiBUaHVyc2RheSwgTm92ZW1iZXIg
MTQsIDIwMTkgMTE6NDIgQU0KPiA+PlRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
ID4+Q2M6IEthemxhdXNrYXMsIE5pY2hvbGFzIDxOaWNob2xhcy5LYXpsYXVza2FzQGFtZC5jb20+
OyBXZW50bGFuZCwgSGFycnkKPiA+PjxIYXJyeS5XZW50bGFuZEBhbWQuY29tPjsgTGksIENoaW5n
LXNoaWggKExvdWlzKSA8Q2hpbmctc2hpaC5MaUBhbWQuY29tPgo+ID4+U3ViamVjdDogW1BBVENI
IHYyXSBkcm0vYW1kL2Rpc3BsYXk6IEZpeCBBcHBsZSBkb25nbGUgY2Fubm90IGJlCj4gPj5zdWNj
ZXNzZnVsbHkgZGV0ZWN0ZWQKPiA+Pgo+ID4+W1doeV0KPiA+PkV4dGVybmFsIG1vbml0b3IgY2Fu
bm90IGJlIGRpc3BsYXllZCBjb25zaXN0ZW50bHksIGlmIGNvbm5lY3RpbmcgdmlhCj4gPj50aGlz
IEFwcGxlIGRvbmdsZSAoQTE2MjEsIFVTQiBUeXBlLUMgdG8gSERNSSkuCj4gPj5CeSBleHBlcmlt
ZW50cywgaXQgaXMgY29uZmlybWVkIHRoYXQgdGhlIGRvbmdsZSBuZWVkcyAyMDBtcyBhdCBsZWFz
dCB0bwo+ID4+YmUgcmVhZHkgZm9yIGNvbW11bmljYXRpb24sIGFmdGVyIGl0IHNldHMgSFBEIHNp
Z25hbCBoaWdoLgo+ID4+Cj4gPj5bSG93XQo+ID4+V2hlbiByZWNlaXZpbmcgSFBEIElSUSwgZGVs
YXkgMzAwbXMgYXQgdGhlIGJlZ2lubmluZyBvZiBoYW5kbGVfaHBkX2lycSgpLgo+ID4+VGhlbiBy
dW4gdGhlIG9yaWdpbmFsIHByb2NlZHVyZS4KPiA+PldpdGggdGhpcyBwYXRjaCBhcHBsaWVkLCB0
aGUgcHJvYmxlbSBjYW5ub3QgYmUgcmVwcm9kdWNlZC4KPiA+PldpdGggb3RoZXIgZG9uZ2xlcywg
dGVzdCByZXN1bHRzIGFyZSBQQVNTLgo+ID4+VGVzdCByZXN1bHQgaXMgUEFTUyB0byBwbHVnIGlu
IEhETUkgY2FibGUgd2hpbGUgcGxheWluZyB2aWRlbywgYW5kIHRoZQo+ID4+dmlkZW8gaXMgYmVp
bmcgcGxheWluZyBzbW9vdGhseS4KPiA+PlRlc3QgcmVzdWx0IGlzIFBBU1MgYWZ0ZXIgc3lzdGVt
IHJlc3VtZXMgZnJvbSBzdXNwZW5kLgo+ID4+Cj4gPj5TaWduZWQtb2ZmLWJ5OiBMb3VpcyBMaSA8
Q2hpbmctc2hpaC5MaUBhbWQuY29tPgo+ID4KPiA+VGhpcyBpcyBzdGlsbCBhIE5BSyBmcm9tIG1l
IHNpbmNlIHRoZSBsb2dpYyBoYXNuJ3QgY2hhbmdlZCBmcm9tIHRoZSBmaXJzdAo+ID5wYXRjaC4K
PiA+Cj4gPlNsZWVwcyBkb24ndCBiZWxvbmcgaW4gSVJRIGhhbmRsZXJzLgo+ID4KPiA+UmVnYXJk
cywKPiA+TmljaG9sYXMgS2F6bGF1c2thcwo+IAo+IEFjdHVhbGx5LCB0aGlzIGxpdmVzIGluIHRo
ZSBsb3cgSVJRIGNvbnRleHQgd2hpY2ggbWVhbnMgdGhhdCBpdCdzIGFscmVhZHkKPiBiZWVuIHF1
ZXVlZCBvZmYgdG8gYSB3b3JrIHRocmVhZCBzbyBpdCdzIHNhZmUgdG8gc2xlZXAuCj4gCj4gSSdt
IG5vdCBzdXJlIHdlIHdhbnQgYSBnZW5lcmFsIDMwMG1zIHNsZWVwIChldmVuIGJ5IGV4cGVyaW1l
bnQgeW91IHNhaWQgdGhhdAo+IGl0IG9ubHkgbmVlZGVkIDIwMG1zKSBmb3IgYWxsIGNvbm5lY3Rv
cnMuCj4gCj4gTmljaG9sYXMgS2F6bGF1c2thcwo+IAoKWWVzLCBpdCBpcyBJUlEgY29udGV4dC4g
U2FmZSB0byBjYWxsIHNsZWVwKCkuIE1vcmVvdmVyLCBpbiBjdXJyZW50IGRyaXZlciwKZXZlbiB1
ZGVsYXkoKSBpcyBjYWxsZWQgaW4gd2FpdF9mb3JfdHJhaW5pbmdfYXV4X3JkX2ludGVydmFsKCkg
aW4gdGhlIGZsb3cKb2YgaGFuZGxlX2hwZF9pcnEoKS4KCkZvciAybmQgcXVlc3Rpb24sIG9mIGNv
dXJzZSBub3QgYWxsIGNvbm5lY3RvcnMgaGF2ZSB0aGlzIGJlaGF2aW9yLgpCYXNlZCBvbiByZWFs
IGNhc2VzIHdlIGV2ZXIgZGVhbHQsIHNvbWUgZG9uZ2xlcyBsaWtlIHRoaXMsIG9yIHNvbWUKbW9u
aXRvcnMgZHJpdmVuIGJ5IFRDT04sIGhhdmUgc2FtZSBiZWhhdmlvci4gQW5kIG5vIGNoYW5jZSB0
byByZWFkCm91dCBhbnl0aGluZyB0byBkZWNpZGUgaWYgZGVsYXkgaXMgbmVlZGVkLiBUaGlzIGNo
YW5nZSBkb2VzIGhlbHAKdG8gaGF2ZSBvdXIgZHJpdmVyIGdhaW4gYmV0dGVyIGNvbXBhdGliaWxp
dHkuIFRydWx5IHRoaXMgc2hvdWxkIGJlCnByb2JsZW0gb2YgZG9uZ2xlcy9tb25pdG9ycy4gV2Ug
YXJlIG5vdCB0aGUgb25seSBvbmUgdG8Kd29ya2Fyb3VuZCBzdWNoIGEgcHJvYmxlbS4gVGhpcyBj
aGFuZ2UgZG9lcyBub3QgaHVydCBvdGhlciBjb25uZWN0cywKYW5kIHNvbWUgb3RoZXIgZG9uZ2xl
cyBhcmUgdGVzdGVkIG9rLCBlLmcuIEhQL0h1d2FpIGRvbmdsZXMsIGV0Yy4KCj4gPgo+ID4+LS0t
Cj4gPj7CoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5j
IHwgNSArKysrKwo+ID4+wqAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+ID4+Cj4g
Pj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRn
cHVfZG0uYwo+ID4+Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbS5jCj4gPj5pbmRleCAwYWVmOTJiN2MwMzcuLjViODQ0YjZhNWE1OSAxMDA2NDQKPiA+Pi0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiA+
PisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMK
PiA+PkBAIC0xMDI1LDYgKzEwMjUsMTEgQEAgc3RhdGljIHZvaWQgaGFuZGxlX2hwZF9pcnEodm9p
ZCAqcGFyYW0pCj4gPj7CoMKgwqDCoMKgIHN0cnVjdCBkcm1fZGV2aWNlICpkZXYgPSBjb25uZWN0
b3ItPmRldjsKPiA+PsKgwqDCoMKgwqAgZW51bSBkY19jb25uZWN0aW9uX3R5cGUgbmV3X2Nvbm5l
Y3Rpb25fdHlwZSA9IGRjX2Nvbm5lY3Rpb25fbm9uZTsKPiA+PivCoMKgwqAgLyogU29tZSBtb25p
dG9ycy9kb25nbGVzIG5lZWQgYXJvdW5kIDIwMG1zIHRvIGJlIHJlYWR5IGZvcgo+ID4+Y29tbXVu
aWNhdGlvbgo+ID4+K8KgwqDCoMKgICogYWZ0ZXIgdGhvc2UgZGV2aWNlcyBkcml2ZSBIUEQgc2ln
bmFsIGhpZ2guCj4gPj4rwqDCoMKgwqAgKi8KPiA+PivCoMKgwqAgbXNsZWVwKDMwMCk7Cj4gPj4r
Cj4gPj7CoMKgwqDCoMKgIC8qIEluIGNhc2Ugb2YgZmFpbHVyZSBvciBNU1Qgbm8gbmVlZCB0byB1
cGRhdGUgY29ubmVjdG9yIHN0YXR1cyBvcgo+ID4+bm90aWZ5IHRoZSBPUwo+ID4+wqDCoMKgwqDC
oMKgICogc2luY2UgKGZvciBNU1QgY2FzZSkgTVNUIGRvZXMgdGhpcyBpbiBpdCdzIG93biBjb250
ZXh0Lgo+ID4+wqDCoMKgwqDCoMKgICovCj4gPj4tLSAKPiA+PjIuMjEuMAo+ID4+Cj4gPgo+ID5f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID5hbWQtZ2Z4
IG1haWxpbmcgbGlzdAo+ID5hbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID5odHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPiAKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
