Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CACC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 23:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F66A2176D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 23:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qPUP3JZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F66A2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E3C6E1D3;
	Tue, 17 Dec 2019 23:40:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F13046E1E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 23:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOZOwpL1AK3917v4W7kG+oUsOzhQO3gUGcMcdTTa+lAiQfsc8DP6V7jfV+UJ7a6qa7hSmKXQlMEnRbV93P+a0rwPVivXRBUluY5917ySGpOSxOE4GS3PJIwjkr8dsOUhRqiT2GSIIbwFKvKejsEapgFoZPyK820Wl6cn8EllD3k8Y4e6eXEvIM8lU4p0ERgB/Q/yw0guSM+EtKFZYD9tZW38DKeBAt1iHKeJ3gjMGNjr01zfdlLBH3pbqOyhjK9ymm7xEuctRWV2IGASH2xTeL1PP8I3ea0pzTkkTeXgQbUx+bC1KX6SMF3Cpnr/uL2Qg5PsGh2ZTp68fSp5eDmcUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wiU/iGiE3VXwQtOnbTFXd4KjyY9jtOzesVGwhbr+58=;
 b=FUl5nWcVfxcEp2wgvOfiUE7BA7DeJlYIxcM6PBVfn+mSLzYPK3muf9SkKolWubFFzNGDUKsu+5Kfg/lJHKKjjRHVwi+tWJq2I5ScQ4ewRXnV5EyAETyDgi67OaZI5AkjFaSH4uEuCDs8u8RcWpCMOOii0QyzInxIYSkOpwq2Nnh5pFccqdsI/t4BfAQMSVtBTU25MwJ2An5RWLhSPwoyzBfTCvSOTXPrR5rTcJtd0DcQPu4q6LI+z6ulshx3d/Kc9OS5WoECAeUXOgfWQ8NiwqoLUeH3QGt9JLQMlzxr1gpGaxSV0gi7+V0jqE+9lq3Dfp1YHNJNtkP8MBgQlzWjPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wiU/iGiE3VXwQtOnbTFXd4KjyY9jtOzesVGwhbr+58=;
 b=qPUP3JZor38kWj/dz32gJ76/3/PXoAwkg6U6p5oFfYuNYDcQ2XcDDdWOzPlVEbAouoiu/3KA5NUTpZ1VUX/8Cb3R6gcOtRFYTeYhPPlZ6YmDlA1vmUecWAutTVNtUNDzuTrKgnP6M2f4lcDwJLyiqlDPysntlo9IRMjbAjZcAhQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3641.namprd12.prod.outlook.com (20.178.199.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Tue, 17 Dec 2019 23:40:28 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 23:40:28 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: expose num_cp_queues data field to
 topology node
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 Yong Zhao <Yong.Zhao@amd.com>
References: <1576479771-10748-1-git-send-email-ray.huang@amd.com>
 <1576479771-10748-2-git-send-email-ray.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <58f5772e-76dd-2ff7-d58a-46cf4063cb0a@amd.com>
Date: Tue, 17 Dec 2019 18:40:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <1576479771-10748-2-git-send-email-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [142.116.99.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 185e950f-c444-41a0-08d1-08d7834a7f39
X-MS-TrafficTypeDiagnostic: DM6PR12MB3641:|DM6PR12MB3641:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB36413A2916BD6EEABA76704692500@DM6PR12MB3641.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 02543CD7CD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(199004)(189003)(66946007)(52116002)(110136005)(2906002)(36756003)(66476007)(66556008)(6486002)(8676002)(5660300002)(6512007)(316002)(31686004)(31696002)(186003)(81156014)(81166006)(86362001)(4326008)(4001150100001)(8936002)(26005)(6506007)(53546011)(44832011)(478600001)(6636002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3641;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xbtf5GoobUMMsXsfPRCzYUlf4uH4Rgc6AhnoxtjhjDdoFV4G9AVbPgmGDp5OqitcGxpoTrfKe71Z8fR0VG8p1OMrTaOC6SJ+WHaHUTcIpt6qaPuz3lKzLFHSvJy+T6Ke8I1mci3RQyweb6vLna/UTz2nL3OUfx+tNVNSjIxLLvsjNN6zpF2oBNhHbWy3ftIA6BCn44U057oKgSoA8oRHBzwkafvNm7JuyVmjLM5o5K//jr9Ww5LaTYvDd4b1pFmPZU7VYCllIo1ScxMhwIZqKtxYeSZahImbL+xIXHxi1Hz8MHwxBTu29glSa8DAcUBFDJWOwV6Wo3hSDQrRvxNbes/vHtg3qLvf1y9R86VnGVbKe8blypq+pPlzDnMlqbSL0N5s2Q9JcJGie4LjzyyBNCqReSF01Tt2fC1qSnppt6Atghvt9K1Ofh+tIs7zQHG9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185e950f-c444-41a0-08d1-08d7834a7f39
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 23:40:28.3356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOyRUQZAzJMqaVWiIiQEa+s1n2oOS/5mCJF3U/u7B75MkkWi0EzfsXA33IP7OIKBrf/CeqTiWcAtRs98oxu00w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3641
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VlIGNvbW1lbnQgaW5saW5lLiBPdGhlciB0aGFuIHRoYXQsIHRoZSBzZXJpZXMgbG9va3MgZ29v
ZCB0byBtZS4KCk9uIDIwMTktMTItMTYgMjowMiwgSHVhbmcgUnVpIHdyb3RlOgo+IFRodW5rIGRy
aXZlciB3b3VsZCBsaWtlIHRvIGtub3cgdGhlIG51bV9jcF9xdWV1ZXMgZGF0YSwgaG93ZXZlciB0
aGlzIGRhdGEgcmVsaWVkCj4gb24gZGlmZmVyZW50IGFzaWMgc3BlY2lmaWMuIFNvIGl0J3MgYmV0
dGVyIHRvIGdldCBpdCBmcm9tIGtmZCBkcml2ZXIuCj4KPiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBS
dWkgPHJheS5odWFuZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3RvcG9sb2d5LmMgfCAzICsrKwo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3RvcG9sb2d5LmggfCAzICsrLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfdG9wb2xvZ3kuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3Bv
bG9neS5jCj4gaW5kZXggY2MwMWNjZC4uMjAzYzgyMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jCj4gQEAgLTQ4OCw2ICs0ODgsOCBAQCBzdGF0aWMgc3Np
emVfdCBub2RlX3Nob3coc3RydWN0IGtvYmplY3QgKmtvYmosIHN0cnVjdCBhdHRyaWJ1dGUgKmF0
dHIsCj4gICAJCQlkZXYtPm5vZGVfcHJvcHMubnVtX3NkbWFfeGdtaV9lbmdpbmVzKTsKPiAgIAlz
eXNmc19zaG93XzMyYml0X3Byb3AoYnVmZmVyLCAibnVtX3NkbWFfcXVldWVzX3Blcl9lbmdpbmUi
LAo+ICAgCQkJZGV2LT5ub2RlX3Byb3BzLm51bV9zZG1hX3F1ZXVlc19wZXJfZW5naW5lKTsKPiAr
CXN5c2ZzX3Nob3dfMzJiaXRfcHJvcChidWZmZXIsICJudW1fY3BfcXVldWVzIiwKPiArCQkJZGV2
LT5ub2RlX3Byb3BzLm51bV9jcF9xdWV1ZXMpOwo+ICAgCj4gICAJaWYgKGRldi0+Z3B1KSB7Cj4g
ICAJCWxvZ19tYXhfd2F0Y2hfYWRkciA9Cj4gQEAgLTEzMTYsNiArMTMxOCw3IEBAIGludCBrZmRf
dG9wb2xvZ3lfYWRkX2RldmljZShzdHJ1Y3Qga2ZkX2RldiAqZ3B1KQo+ICAgCWRldi0+bm9kZV9w
cm9wcy5udW1fZ3dzID0gKGh3c19nd3Nfc3VwcG9ydCAmJgo+ICAgCQlkZXYtPmdwdS0+ZHFtLT5z
Y2hlZF9wb2xpY3kgIT0gS0ZEX1NDSEVEX1BPTElDWV9OT19IV1MpID8KPiAgIAkJYW1kZ3B1X2Ft
ZGtmZF9nZXRfbnVtX2d3cyhkZXYtPmdwdS0+a2dkKSA6IDA7Cj4gKwlkZXYtPm5vZGVfcHJvcHMu
bnVtX2NwX3F1ZXVlcyA9IGdldF9xdWV1ZXNfbnVtKGRldi0+Z3B1LT5kcW0pOwo+ICAgCj4gICAJ
a2ZkX2ZpbGxfbWVtX2Nsa19tYXhfaW5mbyhkZXYpOwo+ICAgCWtmZF9maWxsX2lvbGlua19ub25f
Y3JhdF9pbmZvKGRldik7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF90b3BvbG9neS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5
LmgKPiBpbmRleCA5MzQ2Y2MxLi5lNDQ3OTAxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3RvcG9sb2d5LmgKPiBAQCAtMjcsNyArMjcsNyBAQAo+ICAgI2luY2x1ZGUgPGxp
bnV4L2xpc3QuaD4KPiAgICNpbmNsdWRlICJrZmRfY3JhdC5oIgo+ICAgCj4gLSNkZWZpbmUgS0ZE
X1RPUE9MT0dZX1BVQkxJQ19OQU1FX1NJWkUgMjgKPiArI2RlZmluZSBLRkRfVE9QT0xPR1lfUFVC
TElDX05BTUVfU0laRSAyNAoKSSBkb24ndCBzZWUgd2h5IHlvdSBuZWVkIHRvIGNoYW5nZSB0aGUg
bmFtZSBzaXplIGhlcmUuIEknbSBub3QgYXdhcmUgb2YgCmFueSByZXF1aXJlbWVudCB0aGF0IHRo
ZSBzdHJ1Y3R1cmUgc2l6ZSBjYW5ub3QgY2hhbmdlLiBUaGlzIGNvbW1lbnQgCmFwcGxpZXMgdG8g
cGF0Y2ggMSBhcyB3ZWxsLgoKUmVnYXJkcywKIMKgIEZlbGl4Cgo+ICAgCj4gICAjZGVmaW5lIEhT
QV9DQVBfSE9UX1BMVUdHQUJMRQkJCTB4MDAwMDAwMDEKPiAgICNkZWZpbmUgSFNBX0NBUF9BVFNf
UFJFU0VOVAkJCTB4MDAwMDAwMDIKPiBAQCAtODIsNiArODIsNyBAQCBzdHJ1Y3Qga2ZkX25vZGVf
cHJvcGVydGllcyB7Cj4gICAJdWludDMyX3QgbnVtX3NkbWFfZW5naW5lczsKPiAgIAl1aW50MzJf
dCBudW1fc2RtYV94Z21pX2VuZ2luZXM7Cj4gICAJdWludDMyX3QgbnVtX3NkbWFfcXVldWVzX3Bl
cl9lbmdpbmU7Cj4gKwl1aW50MzJfdCBudW1fY3BfcXVldWVzOwo+ICAgCWNoYXIgbmFtZVtLRkRf
VE9QT0xPR1lfUFVCTElDX05BTUVfU0laRV07Cj4gICB9Owo+ICAgCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
