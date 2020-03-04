Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B7AC3F2CD
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 14:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB5F20732
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 14:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IRoDULZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB5F20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC4926E198;
	Wed,  4 Mar 2020 14:57:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC3126E198
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 14:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBuBsJpcVns8Zwqfm2AAohfwjqYLyp7dtSw9wJOlkW2oXaXa0i+5JZARrbl3jg/RIOHvFfXvT+bARJJgjfNKKZwXbYxbsXwfaaWdGFHfsei7cJhDtnUlkYcqLqI1Dnx/AWtm9jcAg73GH2CN71UYRcXiWnnDrA9nreJuRwmdlY6qOHTEoVc1rDE2X1ggDmXVYEo4l1de1VKL5KoFJEBY+HWBL2Uu4Yo14Me/fqGWEVUPm6sKc+VcMFtpG4uibqR48c/s/F9O9jTcQ0RvDp42XJ9HOEjvG9CONBmDvcX/KA9EwsILcKh/ixTk9L2tCAuH1aiNNt4wnkHkBQxJfxvz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AI1PdZlk9SEn2B2y6J+TBdkIyzTMMrHNOwoXlW7nws=;
 b=iOWq+brsmKYWZCB7O+cxHAtmMJmNghXKyKJlgNCGDV4UsCL9f3+dNyOpKiy7yBK2wfdt1H2L/f9hc+tKdcayhdSd2Aadnt0HZpEFSEHFfSsOs1FdLbX8XZdxMhyE5d/C4syFqemwtz/nZllKZWwerHTsN3JWTyDcgIjR8+lUIa4be5lmJXlGpW02Sh8E8aItj3VF9K0RgDwJH8/rRlCmB8iZjl4S8sd/NA+VIzVVxUAKPWyWifaZMNQwEr2eRR2KVxArzICYUU1YYx5bnJNkMqSjC+pY00TOjS9F7boQwTQR6ja8mPf0Oskuk7tCn+TvDpKcB22Dk3wZVVEanp+JaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AI1PdZlk9SEn2B2y6J+TBdkIyzTMMrHNOwoXlW7nws=;
 b=IRoDULZjeevqdbyzViX+mzisSZYSNwCnD4jsnj/ZNL3kXJCZ+hHEnF/UClmdlH1jm2wEG0Se+ZwRkIxIwXEOKJZDei4dbQdLQ231DOFetr4Y/esmeTNkVTZaFd62Ed0GtAWhaEb3e/KxZwJqPm2N41vMOwS0vnGswdGa8h+e4vc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB2918.namprd12.prod.outlook.com (2603:10b6:a03:13c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 14:57:17 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 14:57:17 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu/vcn: fix race condition issue for vcn start
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
 <29c65b64-26d1-dfef-9da9-2563f291c2e8@gmail.com>
 <00b0a2df-a45c-43e6-9c7e-6567b0f86180@amd.com>
 <2ddda823-0edd-d4f9-560b-0c89b0157e9b@amd.com>
 <11274ae4-da5e-5c7d-ba1a-877f22daea24@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <6294bcbb-e663-79e5-371b-28eb3a47dbfb@amd.com>
Date: Wed, 4 Mar 2020 09:57:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <11274ae4-da5e-5c7d-ba1a-877f22daea24@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.233.155] (165.204.55.251) by
 YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 14:57:17 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 118b7214-7e23-4ee7-40e2-08d7c04c552e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2918:|BYAPR12MB2918:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB29181C3E328C9E888BD89ECFE4E50@BYAPR12MB2918.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(189003)(36756003)(66574012)(31696002)(478600001)(81156014)(2906002)(81166006)(8936002)(31686004)(316002)(66476007)(66556008)(8676002)(66946007)(26005)(16526019)(186003)(2616005)(110136005)(5660300002)(36916002)(53546011)(6486002)(52116002)(956004)(16576012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2918;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stJCSdASoBEzWv9GRmwQVzeP08tzyysgwArSNv8ATcbl4l5vCIxjzTLkn0FEhc34Isax+NjMyjqOBUUPQBpYWXlP7FaoO9lFDRJ/b4vnoa6cPczM6PkZX5pGAONUK8AE0pPnvfMcWSHO2zZCwxjzKrZo0kNjc0M0NxcCLaI2Wxprf6r1V8DXewUojd+DeDtuaI3OF/lmFdewF8NdiaxKCLj/iEEVEA2EOY0BcO07dNEUN7sSLPFR6FMa6UIgdRMfohx13BqGOPFYarvOOck595zc2fwHqP4lKAyuBvvO+1aIFPXZMt3QfcyERHpBFh8qflqHV5nuF6hRvzkj36mE5bxUDfhSAEBKVtdjxRVX/f3ldOHqmenaosbv5BPVgMqO/ArbGtmvK/wicIJ8Purw0u16ZejLEGf2dq/Tp/SuzI1cUNX76awu5YF1EzTAzsmS
X-MS-Exchange-AntiSpam-MessageData: ofDvheXfHYG7QNURAox5jQj4dYcAR5o7/O323JHGZLZhNtvBrgBBIKxqHiyDWbL0K/dbScCCh4dq77bq7JKiEQbJuyx2+3YJGynhW7mGgr507d5g4MeBTUbTeoH59Zuxk02GPY6+GR+7L/6tiiQkcQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118b7214-7e23-4ee7-40e2-08d7c04c552e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 14:57:17.8005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jeBXsh3ni0FSRO6svyVdPSGX52OXWJXK4u6egMNUPAkLgqMALODo/G9gZtOoLXI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2918
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjAtMDMtMDQgMzo1MyBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDAz
LjAzLjIwIHVtIDIzOjQ4IHNjaHJpZWIgSmFtZXMgWmh1Ogo+Pgo+PiBPbiAyMDIwLTAzLTAzIDI6
MDMgcC5tLiwgSmFtZXMgWmh1IHdyb3RlOgo+Pj4KPj4+IE9uIDIwMjAtMDMtMDMgMTo0NCBwLm0u
LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+IEFtIDAzLjAzLjIwIHVtIDE5OjE2IHNjaHJp
ZWIgSmFtZXMgWmh1Ogo+Pj4+PiBGaXggcmFjZSBjb25kaXRpb24gaXNzdWUgd2hlbiBtdWx0aXBs
ZSB2Y24gc3RhcnRzIGFyZSBjYWxsZWQuCj4+Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEphbWVz
IFpodSA8SmFtZXMuWmh1QGFtZC5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiDCoCBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgfCA0ICsrKysKPj4+Pj4gwqAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oIHwgMSArCj4+Pj4+IMKgIDIgZmlsZXMgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgCj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Zjbi5jCj4+Pj4+IGluZGV4IGY5NjQ2NGUuLmFhNzY2M2YgMTAwNjQ0Cj4+
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+Pj4+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4+Pj4gQEAgLTYz
LDYgKzYzLDcgQEAgaW50IGFtZGdwdV92Y25fc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKPj4+Pj4gwqDCoMKgwqDCoCBpbnQgaSwgcjsKPj4+Pj4gwqAgwqDCoMKgwqDCoCBJTklU
X0RFTEFZRURfV09SSygmYWRldi0+dmNuLmlkbGVfd29yaywgCj4+Pj4+IGFtZGdwdV92Y25faWRs
ZV93b3JrX2hhbmRsZXIpOwo+Pj4+PiArwqDCoMKgIG11dGV4X2luaXQoJmFkZXYtPnZjbi52Y25f
cGdfbG9jayk7Cj4+Pj4+IMKgIMKgwqDCoMKgwqAgc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsK
Pj4+Pj4gwqDCoMKgwqDCoCBjYXNlIENISVBfUkFWRU46Cj4+Pj4+IEBAIC0yMTAsNiArMjExLDcg
QEAgaW50IGFtZGdwdV92Y25fc3dfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAKPj4+Pj4gKmFk
ZXYpCj4+Pj4+IMKgwqDCoMKgwqAgfQo+Pj4+PiDCoCDCoMKgwqDCoMKgIHJlbGVhc2VfZmlybXdh
cmUoYWRldi0+dmNuLmZ3KTsKPj4+Pj4gK8KgwqDCoCBtdXRleF9kZXN0cm95KCZhZGV2LT52Y24u
dmNuX3BnX2xvY2spOwo+Pj4+PiDCoCDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4+PiDCoCB9Cj4+
Pj4+IEBAIC0zMjEsNiArMzIzLDcgQEAgdm9pZCBhbWRncHVfdmNuX3JpbmdfYmVnaW5fdXNlKHN0
cnVjdCAKPj4+Pj4gYW1kZ3B1X3JpbmcgKnJpbmcpCj4+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Owo+Pj4+PiDCoMKgwqDCoMKgIGJvb2wgc2V0
X2Nsb2NrcyA9IAo+Pj4+PiAhY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZhZGV2LT52Y24uaWRs
ZV93b3JrKTsKPj4+Pj4gwqAgK8KgwqDCoCBtdXRleF9sb2NrKCZhZGV2LT52Y24udmNuX3BnX2xv
Y2spOwo+Pj4+Cj4+Pj4gVGhhdCBzdGlsbCB3b24ndCB3b3JrIGNvcnJlY3RseSBoZXJlLgo+Pj4+
Cj4+Pj4gVGhlIHdob2xlIGlkZWEgb2YgdGhlIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygpIGFu
ZCAKPj4+PiBzY2hlZHVsZV9kZWxheWVkX3dvcmsoKSBkYW5jZSBpcyB0aGF0IHlvdSBoYXZlIGV4
YWN0bHkgb25lIHVzZXIgb2YgCj4+Pj4gdGhhdC4gSWYgeW91IGhhdmUgbXVsdGlwbGUgcmluZ3Mg
dGhhdCB3aG9sZSB0aGluZyB3b24ndCB3b3JrIAo+Pj4+IGNvcnJlY3RseS4KPj4+Pgo+Pj4+IFRv
IGZpeCB0aGlzIHlvdSBuZWVkIHRvIGNhbGwgbXV0ZXhfbG9jaygpIGJlZm9yZSAKPj4+PiBjYW5j
ZWxfZGVsYXllZF93b3JrX3N5bmMoKSBhbmQgc2NoZWR1bGVfZGVsYXllZF93b3JrKCkgYmVmb3Jl
IAo+Pj4+IG11dGV4X3VubG9jaygpLgo+Pj4KPj4+IEJpZyBsb2NrIGRlZmluaXRlbHkgd29ya3Mu
IEkgYW0gdHJ5aW5nIHRvIHVzZSBhcyBzbWFsbGVyIGxvY2sgYXMgCj4+PiBwb3NzaWJsZSBoZXJl
LiB0aGUgc2hhcmUgcmVzb3VyY2Ugd2hpY2ggbmVlZHMgcHJvdGVjdCBoZXJlIGFyZSBwb3dlciAK
Pj4+IGdhdGUgcHJvY2VzcyBhbmQgZHBnIG1vZGUgc3dpdGNoIHByb2Nlc3MuCj4+Pgo+Pj4gaWYg
d2UgbW92ZSBtdXRleF91bmxvY2soKSBiZWZvcmUgc2NoZWR1bGVfZGVsYXllZF93b3JrKC4gSSBh
bSAKPj4+IHdvbmRlcmluZyB3aGF0IGFyZSB0aGUgb3RoZXIgbmVjZXNzYXJ5IHJlc291cmNlcyB3
aGljaCBuZWVkIHByb3RlY3QuCj4+Cj4+IEJ5IHRoZSB3YXksIGNhbmNlbF9kZWxheWVkX3dvcmtf
c3luYygpIHN1cHBvcnRzIG11bHRpcGxlIHRocmVhZCAKPj4gaXRzZWxmLCBzbyBJIGRpZG4ndCBw
dXQgaXQgaW50byBwcm90ZWN0aW9uIGFyZWEuCj4KPiBZZWFoLCBidXQgdGhhdCdzIGNvcnJlY3Qg
YnV0IGl0IHN0aWxsIHdvbid0IHdvcmtpbmcgY29ycmVjdGx5IDopCj4KPiBTZWUgdGhlIHByb2Js
ZW0gaXMgdGhhdCBvbmx5IGZvciB0aGUgZmlyc3QgY2FsbGVyIAo+IGNhbmNlbF9kZWxheWVkX3dv
cmtfc3luYygpIHJldHVybnMgdHJ1ZSBiZWNhdXNlIGl0IGNhbmNlbGVkIHRoZSAKPiBkZWxheWVk
IHdvcmsuCgppZiB0aGUgMXN0IGNhbGxlciBnZXRzIHRydWUuIHRoZSAybmQgY2FsbGVyIHVuZm9y
dHVuYXRlbHkgbWF5IG1pc3MgdGhpcyAKcGVuZGluZyBzdGF0dXMsIHNvIGl0IHdpbGwgdW5nYXRl
IHRoZSBwb3dlciB3aGljaCBpcyB1bmV4cGVjdGVkLgoKQnV0IGluIHBvd2VyIGdhdGUvdW5nYXRl
IGZ1bmN0aW9uLCBhIHBvd2VyIHN0YXRlIGlzIG1haW50YWluZWQsIHNvIHRoaXMgCm1pc3Mgd29u
J3QgYmUgcmVhbGx5IHRyaWdnZXJlZCB0byB1bmdhdGUgdGhlIHBvd2VyLgoKU28gSSB0aGluayBj
YW5jZWxfZGVsYXllZF93b3JrX3N5bmMoKSAvIHNjaGVkdWxlX2RlbGF5ZWRfd29yaygpIGFyZSBu
b3QgCm5lY2Vzc2FyeSBiZSBwcm90ZWN0ZWQgaGVyZS4KCkJlc3QgUmVnYXJkcyEKCkphbWVzCgo+
Cj4gRm9yIGFsbCBvdGhlcnMgaXQgcmV0dXJucyBmYWxzZSBhbmQgdGhvc2Ugd291bGQgdGhlbiB0
aGluayB0aGF0IHRoZXkgCj4gbmVlZCB0byB1bmdhdGUgdGhlIHBvd2VyLgo+Cj4gVGhlIG9ubHkg
c29sdXRpb24gSSBzZWUgaXMgdG8gZWl0aGVyIHB1dCBib3RoIHRoZSAKPiBjYW5jZWxfZGVsYXll
ZF93b3JrX3N5bmMoKSBhbmQgc2NoZWR1bGVfZGVsYXllZF93b3JrKCkgdW5kZXIgdGhlIHNhbWUg
Cj4gbXV0ZXggcHJvdGVjdGlvbiBvciBzdGFydCB0byB1c2UgYW4gYXRvbWljIG9yIG90aGVyIGNv
dW50ZXIgdG8gbm90ZSAKPiBjb25jdXJyZW50IHByb2Nlc3NpbmcuCj4KPj4gcG93ZXIgZ2F0ZSBp
cyBzaGFyZWQgYnkgYWxsIFZDTiBJUCBpbnN0YW5jZXMgYW5kIGRpZmZlcmVudCByaW5ncyAsIHNv
IAo+PiBpdMKgIG5lZWRzIGJlIHB1dCBpbnRvIHByb3RlY3Rpb24gYXJlYS4KPj4KPj4gZWFjaCBy
aW5nJ3Mgam9iIGl0c2VsZiBpcyBzZXJpYWxpemVkIGJ5IHNjaGVkdWxlci4gaXQgZG9lc24ndCBu
ZWVkIAo+PiBiZcKgIHB1dCBpbnRvIHRoaXMgcHJvdGVjdGlvbiBhcmVhLgo+Cj4gWWVzLCB0aG9z
ZSBzaG91bGQgd29yayBhcyBleHBlY3RlZC4KPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+
Cj4+Pgo+Pj4gVGhhbmtzIQo+Pj4KPj4+IEphbWVzCj4+Pgo+Pj4+Cj4+Pj4gUmVnYXJkcywKPj4+
PiBDaHJpc3RpYW4uCj4+Pj4KPj4+Pj4gwqDCoMKgwqDCoCBpZiAoc2V0X2Nsb2Nrcykgewo+Pj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxzZSk7Cj4+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfZGV2aWNlX2lwX3NldF9wb3dlcmdhdGluZ19z
dGF0ZShhZGV2LCAKPj4+Pj4gQU1EX0lQX0JMT0NLX1RZUEVfVkNOLAo+Pj4+PiBAQCAtMzQ1LDYg
KzM0OCw3IEBAIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2JlZ2luX3VzZShzdHJ1Y3QgCj4+Pj4+IGFt
ZGdwdV9yaW5nICpyaW5nKQo+Pj4+PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+dmNuLnBh
dXNlX2RwZ19tb2RlKGFkZXYsIHJpbmctPm1lLCAmbmV3X3N0YXRlKTsKPj4+Pj4gwqDCoMKgwqDC
oCB9Cj4+Pj4+ICvCoMKgwqAgbXV0ZXhfdW5sb2NrKCZhZGV2LT52Y24udmNuX3BnX2xvY2spOwo+
Pj4+PiDCoCB9Cj4+Pj4+IMKgIMKgIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2VuZF91c2Uoc3RydWN0
IGFtZGdwdV9yaW5nICpyaW5nKQo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Zjbi5oIAo+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92Y24uaAo+Pj4+PiBpbmRleCA2ZmUwNTczLi4yYWUxMTBkIDEwMDY0NAo+Pj4+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgKPj4+Pj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCj4+Pj4+IEBAIC0yMDAsNiAr
MjAwLDcgQEAgc3RydWN0IGFtZGdwdV92Y24gewo+Pj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBkcm1f
Z3B1X3NjaGVkdWxlciAKPj4+Pj4gKnZjbl9kZWNfc2NoZWRbQU1ER1BVX01BWF9WQ05fSU5TVEFO
Q0VTXTsKPj4+Pj4gwqDCoMKgwqDCoCB1aW50MzJfdMKgwqDCoMKgwqDCoMKgwqAgbnVtX3Zjbl9l
bmNfc2NoZWQ7Cj4+Pj4+IMKgwqDCoMKgwqAgdWludDMyX3TCoMKgwqDCoMKgwqDCoMKgIG51bV92
Y25fZGVjX3NjaGVkOwo+Pj4+PiArwqDCoMKgIHN0cnVjdCBtdXRleMKgwqDCoMKgwqDCoMKgwqAg
dmNuX3BnX2xvY2s7Cj4+Pj4+IMKgIMKgwqDCoMKgwqAgdW5zaWduZWTCoMKgwqAgaGFydmVzdF9j
b25maWc7Cj4+Pj4+IMKgwqDCoMKgwqAgaW50ICgqcGF1c2VfZHBnX21vZGUpKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAo+Pj4+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
