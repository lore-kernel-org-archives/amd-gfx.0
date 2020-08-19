Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D7AC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 14:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F0520738
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 14:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F0520738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF51789A83;
	Wed, 19 Aug 2020 14:36:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 240AA6E437
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 14:36:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwlFzy7nz+Np93+3DV6BXLkZO1skEyPY4UNqqLMIbAS4lpCGKJVmi/dL1cWYTjm1TouluM833BwAzaBQb29861/HXbcwsGjYtzMGSfrTARvz8aHu9cEuH74S157NCRgSlx7t3AofqRmyB7zeQhMmWzR8NqUopxXCEkzwb3Segu9+TJpC4zAGYbfRC3GzD2tZEDHSYqI52agVxXv6a6ypE5JoSDLO0xRV52g7EnZYyjJ0Tp/aIKt7FvPDwfLHPWRk5UwKv+gCbQ38laPW7kHKUF/TbH1XDcwDXlrxOL/i/jdVSgCAIUPcNQignTlFl6y99KhKNpLEfAUCqNH0Xxb87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5CW6Zr5R7oP82UCtKTriehE4/Uiui5b0GzRvpxdoRs=;
 b=m45BvHxTm0vznwg2YQNJlfjHrqcaIAY6mH1VIFzosywiVftShP9a/rry3yN1gHUI0etoY735CocNX1hKLNxb6h3EjSLbs8Y4rCsVV/7v3bCilrDlPRXxTNMGO6wjQL6dSvDwtu2l/Sn6PNK9Zyu0rhNxPzY36GuhNgf+ztdRkS4felOpKbpA+t9yo5ySguRyZOHUs5PXKqAXkh5za7sB9FsB4CqNvEp4Nuxn/hqV9MW/rzmRIzVqVh3FrNy4CaL4iB/kemMVlAz7kyJtbscmVTaXuAnxi1j4j9+0HiE/Xs0hEa0sytgk/lo/qg/L/fxasmQi4EiOyLkys+xrNpuqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5CW6Zr5R7oP82UCtKTriehE4/Uiui5b0GzRvpxdoRs=;
 b=JqZUALi/m/i7eF2on3fbUqTVEJD+faEVyzCpmt1uHIMLLDMNOk0kTxR3BFQAcfSluejdWqcZYKW/uImTECMQt18KuG0uLGLUYgIv82NUH7DzPkCAUhhrmZub+WL8TblmMtZXWMjWByB3hLG8Vpf+2TYBoJDCubJSCvnD/Tq+hpk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Wed, 19 Aug
 2020 14:36:07 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3305.025; Wed, 19 Aug 2020
 14:36:07 +0000
Subject: Re: [PATCH] drm/amdgpu: remap hdp coherency registers for vi on
 carrizo
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200819142816.215812-1-ray.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <197df017-d2a2-551a-7722-5f3c45de8544@amd.com>
Date: Wed, 19 Aug 2020 10:36:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200819142816.215812-1-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::29) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTBPR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 14:36:07 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: febeb780-9379-4290-3afb-08d8444d3589
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4557ADEDAED9974DBBD55C9F925D0@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1I+V3KM1UEnV0ysJYT11OoHjjtCnynw7kGin26u2lCI2rwdLPtpwpsHk6UEJ5GdijSmp8TgeYOwpSHEaU+xqO8qEWawHhmRw9ewOg518FLNiRLjXxGXzIstLBdRTixCmEmAXOP+wnpNPfqcDo/s7qiprjmhUEyB5HHcXR6tZy4/C8qB29ps3ktmit8ID2HFmdy887rZF+BA7pTsgSnFgsuSgF2yT324oUIJifXNMETDcbnYOGZB0qexOIZN00913Eof8EmGGVH8e0BEsaxnY/ojgvgzMgcWCDyDNNkVvn1NXrReLTgnGOyDAJDaYRaHJNeNEsqZreK0qFgFmk9YyiYUO51C70byomHBj9d7Uw0P/ZZ3WtMptu8amo4MiEhEKsQ4h61w1v9pDDbIrbiIzJQVheP2BZfJPHJ7GMUvbCT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(31686004)(6486002)(83380400001)(956004)(5660300002)(36756003)(26005)(44832011)(31696002)(66946007)(2616005)(66476007)(66556008)(110011004)(52116002)(86362001)(316002)(16576012)(8676002)(478600001)(8936002)(186003)(4326008)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fGSvleFAw5vy4fwCe7Lc52F2KnG5Lc89a4UGfJL+Tdu+adKb7pz5Ff9hAv7sEHiL0EecsE983JBjeRLOWcE+CmNajM+SuCI1C0xwiCR2/PP5471G8mrmeYbSnp9vptvmgJLKMcwqjQIC8v5b/PD2IQykhMgOW2WZkwTjwa8xVMn+4yvQ4JXLrXL34HSCKvE2jIF8+DiQpiHqyukHtfnMCxjWV4ERzgQaH6NVxRSPQ4FeJ95GSfjB9OXBqfNVAHBNXnftmtdMHSGLEJH1E+gqyNgm6rAmkFYcTelmo1VhQj7+sQAAOeC4P1RTc6nPvnvXLCrJcRKx8AptS4x3cI8ShDlrDTvIURpL3+rZPStUss8iEQnOiRqtZryoR+vUzWUTtJ+dR+RWTW7tQEn3zdjUNAP5bV9rczS9eML7r3RPior1PTS1nNnyTmXevdyaRPatL36ZHruO0wV2+J42ahyNKfpmfuLrpq6hD8ZoiBZDWeXaNxkQMp359bN8k2LkoqxAvtrS1tYPaX7XQmXc6OG2STPoa2B6u2PR0HArkzj6/COb6Rd+s5IxG1VvTD0vEGxrxp9GEKpZmWB/2Wc+B6xcb9G2A25vpVquvjshhUOmpix5Z5YGZqzzFkKJQtsKj70up4ZnDkKwmgqBAm/Aq5iiBg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febeb780-9379-4290-3afb-08d8444d3589
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 14:36:07.7289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KD96snW/BtJFLBU4KTp5QUNCU/SbQeNvBionLfuLJFztEkS1xYtjTAACvCuwh/4mIsNnnvqHGRue5NjPRJhxQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SnVzdCBmb3IgQ2Fycml6bywgSERQIGZsdXNoaW5nIGRvZXNuJ3QgbWFrZSBhIGxvdCBvZiBzZW5z
ZSBiZWNhdXNlIHdlCmRvbid0IHVzZSBIRFAgdG8gYWNjZXNzIHRoZSBmcmFtZWJ1ZmZlci4KClRo
ZSBjb2RlIHlvdSdyZSBjaGFuZ2luZyBkb2Vzbid0IGxvb2sgQ2Fycml6by1zcGVjaWZpYywgYnV0
IFZJLXNwZWNpZmljLgpTbyBpdCB3b3VsZCBhZmZlY3QgRmlqaSBhbmQgUG9sYXJpcyBhcyB3ZWxs
LiBXZSBhbHJlYWR5IHN1cHBvcnQgRmlqaSBhbmQKUG9sYXJpcyBkR1BVcyB3aXRoIEtGRCwgYXBw
YXJlbnRseSB3aXRob3V0IHJlbWFwcGluZyBIRFAgcmVnaXN0ZXJzLiBXaHkKaXMgdGhpcyBjaGFu
Z2Ugbm93IG5lZWRlZCBmb3IgQ2Fycml6bz8KClJlZ2FyZHMsCsKgIEZlbGl4CgpBbSAyMDIwLTA4
LTE5IHVtIDEwOjI4IGEubS4gc2NocmllYiBIdWFuZyBSdWk6Cj4gQ2FycnppbyBhbHNvIG5lZWRz
IHJlbWFwIEhEUF9NRU1fQ09IRVJFTkNZX0ZMVVNIX0NOVEwgYW5kCj4gSERQX1JFR19DT0hFUkVO
Q1lfRkxVU0hfQ05UTCB0byB0aGUgZW1wdHkgcGFnZSBpbiBtbWlvIHNwYWNlLiBUaGVuIHVzZXIK
PiBtb2RlIGlzIGFibGUgdG8gZG8gZmx1c2ggaGRwIGFzIHdlbGwuIEl0IHdpbGwgdXNlZCBmb3Ig
Zm9yY2UgZGdwdSBwYXRoCj4gb24gY2Fycml6by4KPgo+IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1
aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3ZpLmMgfCAxOCArKysrKysrKysrKysrKystLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMKPiBpbmRl
eCBhZjg5ODZhNTUzNTQuLmE1NDBmZTdjZmZjNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS92aS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmku
Ywo+IEBAIC03OCw2ICs3OCw3IEBACj4gICNpbmNsdWRlICJkY2VfdmlydHVhbC5oIgo+ICAjaW5j
bHVkZSAibXhncHVfdmkuaCIKPiAgI2luY2x1ZGUgImFtZGdwdV9kbS5oIgo+ICsjaW5jbHVkZSA8
dWFwaS9saW51eC9rZmRfaW9jdGwuaD4KPiAgCj4gIC8qCj4gICAqIEluZGlyZWN0IHJlZ2lzdGVy
cyBhY2Nlc3Nvcgo+IEBAIC05NDQsMTAgKzk0NSwxMCBAQCBzdGF0aWMgdWludDMyX3QgdmlfZ2V0
X3Jldl9pZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgc3RhdGljIHZvaWQgdmlfZmx1
c2hfaGRwKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJp
bmcpCj4gIHsKPiAgCWlmICghcmluZyB8fCAhcmluZy0+ZnVuY3MtPmVtaXRfd3JlZykgewo+IC0J
CVdSRUczMihtbUhEUF9NRU1fQ09IRVJFTkNZX0ZMVVNIX0NOVEwsIDEpOwo+IC0JCVJSRUczMiht
bUhEUF9NRU1fQ09IRVJFTkNZX0ZMVVNIX0NOVEwpOwo+ICsJCVdSRUczMigoYWRldi0+cm1taW9f
cmVtYXAucmVnX29mZnNldCArIEtGRF9NTUlPX1JFTUFQX0hEUF9NRU1fRkxVU0hfQ05UTCkgPj4g
MiwgMSk7Cj4gKwkJUlJFRzMyKChhZGV2LT5ybW1pb19yZW1hcC5yZWdfb2Zmc2V0ICsgS0ZEX01N
SU9fUkVNQVBfSERQX01FTV9GTFVTSF9DTlRMKSA+PiAyKTsKPiAgCX0gZWxzZSB7Cj4gLQkJYW1k
Z3B1X3JpbmdfZW1pdF93cmVnKHJpbmcsIG1tSERQX01FTV9DT0hFUkVOQ1lfRkxVU0hfQ05UTCwg
MSk7Cj4gKwkJYW1kZ3B1X3JpbmdfZW1pdF93cmVnKHJpbmcsIChhZGV2LT5ybW1pb19yZW1hcC5y
ZWdfb2Zmc2V0ICsgS0ZEX01NSU9fUkVNQVBfSERQX01FTV9GTFVTSF9DTlRMKSA+PiAyLCAxKTsK
PiAgCX0KPiAgfQo+ICAKPiBAQCAtMTA4NSw4ICsxMDg2LDExIEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgYW1kZ3B1X2FzaWNfZnVuY3MgdmlfYXNpY19mdW5jcyA9Cj4gIAo+ICBzdGF0aWMgaW50IHZp
X2NvbW1vbl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKPiAgewo+ICsjZGVmaW5lIE1NSU9fUkVH
X0hPTEVfT0ZGU0VUICgweDgwMDAwIC0gUEFHRV9TSVpFKQo+ICAJc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7Cj4gIAo+ICsJYWRldi0+
cm1taW9fcmVtYXAucmVnX29mZnNldCA9IE1NSU9fUkVHX0hPTEVfT0ZGU0VUOwo+ICsJYWRldi0+
cm1taW9fcmVtYXAuYnVzX2FkZHIgPSBhZGV2LT5ybW1pb19iYXNlICsgTU1JT19SRUdfSE9MRV9P
RkZTRVQ7Cj4gIAlpZiAoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKSB7Cj4gIAkJYWRldi0+c21j
X3JyZWcgPSAmY3pfc21jX3JyZWc7Cj4gIAkJYWRldi0+c21jX3dyZWcgPSAmY3pfc21jX3dyZWc7
Cj4gQEAgLTEzMzIsNiArMTMzNiwxMiBAQCBzdGF0aWMgaW50IHZpX2NvbW1vbl9zd19maW5pKHZv
aWQgKmhhbmRsZSkKPiAgCXJldHVybiAwOwo+ICB9Cj4gIAo+ICtzdGF0aWMgdm9pZCB2aV9yZW1h
cF9oZHBfcmVnaXN0ZXJzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICt7Cj4gKwlXUkVH
MzIobW1SRU1BUF9IRFBfTUVNX0ZMVVNIX0NOVEwsIGFkZXYtPnJtbWlvX3JlbWFwLnJlZ19vZmZz
ZXQgKyBLRkRfTU1JT19SRU1BUF9IRFBfTUVNX0ZMVVNIX0NOVEwpOwo+ICsJV1JFRzMyKG1tUkVN
QVBfSERQX1JFR19GTFVTSF9DTlRMLCBhZGV2LT5ybW1pb19yZW1hcC5yZWdfb2Zmc2V0ICsgS0ZE
X01NSU9fUkVNQVBfSERQX1JFR19GTFVTSF9DTlRMKTsKPiArfQo+ICsKPiAgc3RhdGljIGludCB2
aV9jb21tb25faHdfaW5pdCh2b2lkICpoYW5kbGUpCj4gIHsKPiAgCXN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOwo+IEBAIC0xMzQyLDYg
KzEzNTIsOCBAQCBzdGF0aWMgaW50IHZpX2NvbW1vbl9od19pbml0KHZvaWQgKmhhbmRsZSkKPiAg
CXZpX3BjaWVfZ2VuM19lbmFibGUoYWRldik7Cj4gIAkvKiBlbmFibGUgYXNwbSAqLwo+ICAJdmlf
cHJvZ3JhbV9hc3BtKGFkZXYpOwo+ICsJLyogcmVtYXAgaGRwIHJlZ2lzdGVycyAqLwo+ICsJdmlf
cmVtYXBfaGRwX3JlZ2lzdGVycyhhZGV2KTsKPiAgCS8qIGVuYWJsZSB0aGUgZG9vcmJlbGwgYXBl
cnR1cmUgKi8KPiAgCXZpX2VuYWJsZV9kb29yYmVsbF9hcGVydHVyZShhZGV2LCB0cnVlKTsKPiAg
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
