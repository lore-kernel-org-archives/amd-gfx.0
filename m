Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D8CC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 15:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B7D2067C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 15:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZTegnbki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B7D2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B06A36E184;
	Thu, 12 Dec 2019 15:11:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 615C66E14E
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 15:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTmwP8aE1cwiIjyER0taE4FS6J7N8cxeme5Kq+w38/CK57Sg5cHA9NDJnSX3eu1G04joonIPL4twZ5A3E2nk7ZxJfJDsSRHdQIAbu7q9pqCv33rpdtTOH3XlIBuZ8SGyFlRESUVxdCdJuXC50LYYuYwMKuElc/Sib1euJ1ireH/85Dlv9JhUw1FDuNCUE6KwK3+DJR4AoXFaQXdqjzHeQMoNSgj7SIfbHD3a6c1zmN+ViaGcnUaDntmsLLoka6NUha8mRXEVQhyRA723Eoyip07+R8/8LVBn0IBZXkNfIf4jq5yFa9EeEFiZHiYmAvwyYrvxkfZgmAf/rguTLZdngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyOfI0StGPnU+WORJ3WQnxU+2dQW8g0KATF/zN7x5eo=;
 b=m+WugSTPUM6T9OSjgo4jxE/U7C9W0KEeaSx3CHo6FcHz6h60UsKr3tSjHf+iPyzGSGxto4pacW79aKbqd3gL40zHGpozWwTruV/rEbmdK98Xuda/h9OeD6qRjSoa3r55HyxyQbcRJoN93ikFSpVSOspq9wjAxr19BB53Yvs2ao5O9QXHuJfQsN7mihChd9gCaNAvJDp48Gr6owz3dL4I2+8s2KAVQELotJoq53qwBLe9d81x3NJAsxe7x9JUcq/hF7jAyZPcy6iW9EfGgummd/An2xQQHCnKh0OwXPkRudkrWA1l/IC+7rayO68FJiyAqnT5tNRN8/9LWQue8g+Yhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyOfI0StGPnU+WORJ3WQnxU+2dQW8g0KATF/zN7x5eo=;
 b=ZTegnbkiATyF1eTj0Ckq/vAljpkcDuA9txoMI3hTdx3phLWPs8kVQ8vdIsi+SGgSBus6eQQVd0FZleGlVRJKeWsbnuF2Cd9qQQX7qMHrmxkzvZV+kAwwybXLnjz6BuLpH90Eg9NRA30wO3k3APRDlA9zzxtOsIyw4ueLYtjtX6Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1341.namprd12.prod.outlook.com (10.169.205.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Thu, 12 Dec 2019 15:10:59 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80%12]) with mapi id 15.20.2538.016; Thu, 12 Dec 2019
 15:10:59 +0000
Subject: Re: [PATCH 2/5] drm: Add Reusable task barrier.
To: christian.koenig@amd.com, Alex Deucher <alexdeucher@gmail.com>
References: <1576094829-2245-1-git-send-email-andrey.grodzovsky@amd.com>
 <1576094829-2245-2-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_OCzqh_t5YHithp2Kh0rxHsk4XxnfHm-Cm2_T7ZGSA4Ow@mail.gmail.com>
 <2b12b91a-e40f-25f4-bc7c-71566ffdabd4@gmail.com>
 <fa72ffe9-39fb-4bf2-f8e7-8b4f53cfa7ad@gmail.com>
 <MWHPR12MB1453492D18A1C692AFFE701AEA550@MWHPR12MB1453.namprd12.prod.outlook.com>
 <dcfc91e5-fc0b-8965-e955-546a12e64ea0@gmail.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <c886cbc1-a1c0-b18b-65b9-9e33df1609b3@amd.com>
Date: Thu, 12 Dec 2019 10:10:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <dcfc91e5-fc0b-8965-e955-546a12e64ea0@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::27) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-Originating-IP: [2607:fea8:3edf:e127:3a1e:65e:fc37:38e9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 516eadf4-4bfe-479e-7508-08d77f157e59
X-MS-TrafficTypeDiagnostic: MWHPR12MB1341:|MWHPR12MB1341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB13414CE7870C4C30B6AB008FEA550@MWHPR12MB1341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0249EFCB0B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39840400004)(199004)(189003)(51444003)(53546011)(52116002)(6666004)(6506007)(6916009)(186003)(45080400002)(36756003)(6512007)(66574012)(2616005)(54906003)(4326008)(966005)(478600001)(31686004)(31696002)(2906002)(8936002)(66556008)(81166006)(86362001)(66946007)(5660300002)(8676002)(6486002)(66476007)(316002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1341;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlIInHJi0GsFIxKsZOSO1snk30zpZKROQskb7ovGDUNGPjZOgYcVvTnbDiWBabJIpPSp/Fy0E2aLCZv5uG4wkH0uR2Dw7urYAcnBGQsYh56+taBC6CYb+a8diT+w3Xx4o49D+giExVVondTr/01SIDHvN5zRz78SJUQwKYcsI1OYneCwJ/rxNMJteqMAX08XpDZnd1R9+jB9Bu39Urf01QMd3QhheDDuz57ySDhy0tj8txUjc4DGruKifeiqdUwpIODthgn7jPSn/pMHSucjZN8x0MZ/pDvCF/MWMi3o5NATOMMiE44GgnhgUWPoqJjDBzSaDltb9ncaVu3xMeL5LYhASH7ivrhG2RtpGsT2IvzG901iM40yp/453m63p0ofTA0OlaHRHkw/clMjQxt3+6CZHSyBExl3LvpP1dFb3hEVlFY93Aw9otHxF7X8ANwF/VM3tP/lARqaxYv0qqYaWSNHaLUNpN3DQuOlHcNYrDo4/a6BRUabgHwYKPC8pO4K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516eadf4-4bfe-479e-7508-08d77f157e59
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 15:10:58.9246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4hUKH7vDCaVjmVu4BjeV3GTA5EALkd4LegoA8tKHSSQV91s60W1oqVp9cLgI9EdM1vlVfuzrLgfEDT51IAP7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1341
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDEyLzEyLzE5IDEwOjA5IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDEyLjEy
LjE5IHVtIDE1OjUwIHNjaHJpZWIgR3JvZHpvdnNreSwgQW5kcmV5Ogo+PiBbQU1EIE9mZmljaWFs
IFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4+Cj4+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNr
b2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPgo+PiBTZW50OiAxMiBEZWNlbWJlciAyMDE5
IDAzOjMxCj4+IFRvOiBBbGV4IERldWNoZXI7IEdyb2R6b3Zza3ksIEFuZHJleQo+PiBDYzogRGV1
Y2hlciwgQWxleGFuZGVyOyBNYSwgTGU7IFF1YW4sIEV2YW47IGFtZC1nZnggbGlzdDsgWmhhbmcs
IEhhd2tpbmcKPj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzVdIGRybTogQWRkIFJldXNhYmxlIHRh
c2sgYmFycmllci4KPj4KPj4gQW0gMTIuMTIuMTkgdW0gMDk6MjQgc2NocmllYiBDaHJpc3RpYW4g
S8O2bmlnOgo+Pj4gQW0gMTEuMTIuMTkgdW0gMjE6MTkgc2NocmllYiBBbGV4IERldWNoZXI6Cj4+
Pj4gT24gV2VkLCBEZWMgMTEsIDIwMTkgYXQgMzowNyBQTSBBbmRyZXkgR3JvZHpvdnNreQo+Pj4+
IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPiB3cm90ZToKPj4+Pj4gSXQgaXMgdXNlZCB0byBz
eW5jaHJvbml6ZSBOIHRocmVhZHMgYXQgYSByZW5kZXZvdXogcG9pbnQgYmVmb3JlCj4+Pj4+IGV4
ZWN1dGlvbgo+Pj4+PiBvZiBjcml0aWNhbCBjb2RlIHRoYXQgaGFzIHRvIGJlIHN0YXJ0ZWQgYnkg
YWxsIHRoZSB0aHJlYWRzIGF0Cj4+Pj4+IGFwcHJveGltYXRseQo+Pj4+PiB0aGUgc2FtZSB0aW1l
Lgo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdy
b2R6b3Zza3lAYW1kLmNvbT4KPj4+PiBZb3Ugc2hvdWxkIHJlc2VuZCB0byBkcmktZGV2ZWwgc2lu
Y2UgdGhpcyB0YXNrIGJhcnJpZXIgaXMgYmVpbmcgYWRkZWQKPj4+PiB0byBjb21tb24gY29kZS4K
Pj4+IEFkZGl0aW9uYWwgdG8gdGhhdCB0aGlzIHdob2xlIHRoaW5nIGhhcyB0aGUgcG90ZW50aWFs
IHRvIHJhaXNlIGxvY2tkZXAKPj4+IHdhcm5pbmdzIGFuZCBpZiBJJ20gbm90IGNvbXBsZXRlbHkg
bWlzdGFrZW4gZG9lc24ndCBldmVuIHdvcmsgCj4+PiBjb3JyZWN0bHkuCj4+IENhbiB5b3UgZ2l2
ZSBtZSBhIHBvdGVudGlhbCBsb2NrZGVwIHNjZW5hcmlvID8KPgo+IExvY2tkZXAgdXN1YWxseSBj
b21wbGFpbnMgaWYgYSBsb2NrIGlzIHJlbGVhc2VkIGZyb20gYW5vdGhlciB0aHJlYWQgCj4gdGhh
biB3aGVyZSBpdCB3YXMgbG9ja2VkIGZyb20uCj4KPiBJbiB0aGUgY29kZSB5b3UgbGV0IGVhY2gg
dGhyZWFkIGRvIGEgZG93bigpIGFuZCB0aGVuIHRoZSBsYXN0IG9uZSBkb2VzIAo+IG11bHRpcGxl
IHVwKCkgY2FsbHMuCj4KPiBCdXQgSSB0aGluayB0aGF0IGlzIG9ubHkgaWxsZWdhbCBmb3IgbXV0
ZXhlcywgYnV0IGxlZ2FsIGZvciBzZW1hcGhvcmVzLgo+Cj4gQ2hyaXN0aWFuLgoKClllcywgZnJv
bSB3aGF0IEkndmUgcmVhZCBmb3Igc2VtYXBob3JlcyBpdCdzIG9rIHRvIHJlbGVhc2UgKHVwKSBm
cm9tIGEgCnRocmVhZCB3aGljaCBkaWRuJ3QgYWNxdWlyZSAoZG93bikKCkFuZHJleQoKCj4KPj4K
Pj4gQW5kcmV5Cj4+Cj4+PiBTZWUgTGludXgga2VybmVsIHNlbWFwaG9yZXMgZG9uJ3QgYWxsb3cg
bmVnYXRpdmUgdmFsdWVzICh0aGUgY291bnQKPj4+IGZpZWxkIGluIHN0cnVjdCBzZW1hcGhvcmUg
aXMgdW5zaWduZWQpLgo+PiBPaywgZm9yZ2V0IHdoYXQgSSd2ZSB3cm90ZS4gVGhhdCBpbmRlZWQg
c2VlbXMgdG8gYmUgc3VwcG9ydGVkLCBzb21lCj4+IG90aGVyIGRyaXZlcnMgYXJlIGFscmVhZHkg
dXNpbmcgc2VtYXBob3JlcyB0aGUgc2FtZSB3YXkuCj4+Cj4+IFJlZ2FyZHMsCj4+IENocmlzdGlh
bi4KPj4KPj4+IFJlZ2FyZHMsCj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4+IEFsZXgKPj4+Pgo+Pj4+
PiAtLS0KPj4+Pj4gwqDCoCBpbmNsdWRlL2RybS90YXNrX2JhcnJpZXIuaCB8IDEwNgo+Pj4+PiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4+Pj4gwqDCoCAx
IGZpbGUgY2hhbmdlZCwgMTA2IGluc2VydGlvbnMoKykKPj4+Pj4gwqDCoCBjcmVhdGUgbW9kZSAx
MDA2NDQgaW5jbHVkZS9kcm0vdGFza19iYXJyaWVyLmgKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvZHJtL3Rhc2tfYmFycmllci5oIGIvaW5jbHVkZS9kcm0vdGFza19iYXJyaWVyLmgK
Pj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4+Pj4gaW5kZXggMDAwMDAwMC4uODFmYjBmNwo+
Pj4+PiAtLS0gL2Rldi9udWxsCj4+Pj4+ICsrKyBiL2luY2x1ZGUvZHJtL3Rhc2tfYmFycmllci5o
Cj4+Pj4+IEBAIC0wLDAgKzEsMTA2IEBACj4+Pj4+ICsvKgo+Pj4+PiArICogQ29weXJpZ2h0IDIw
MTkgQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLgo+Pj4+PiArICoKPj4+Pj4gKyAqIFBlcm1p
c3Npb24gaXMgaGVyZWJ5IGdyYW50ZWQsIGZyZWUgb2YgY2hhcmdlLCB0byBhbnkgcGVyc29uCj4+
Pj4+IG9idGFpbmluZyBhCj4+Pj4+ICsgKiBjb3B5IG9mIHRoaXMgc29mdHdhcmUgYW5kIGFzc29j
aWF0ZWQgZG9jdW1lbnRhdGlvbiBmaWxlcyAodGhlCj4+Pj4+ICJTb2Z0d2FyZSIpLAo+Pj4+PiAr
ICogdG8gZGVhbCBpbiB0aGUgU29mdHdhcmUgd2l0aG91dCByZXN0cmljdGlvbiwgaW5jbHVkaW5n
IHdpdGhvdXQKPj4+Pj4gbGltaXRhdGlvbgo+Pj4+PiArICogdGhlIHJpZ2h0cyB0byB1c2UsIGNv
cHksIG1vZGlmeSwgbWVyZ2UsIHB1Ymxpc2gsIGRpc3RyaWJ1dGUsCj4+Pj4+IHN1YmxpY2Vuc2Us
Cj4+Pj4+ICsgKiBhbmQvb3Igc2VsbCBjb3BpZXMgb2YgdGhlIFNvZnR3YXJlLCBhbmQgdG8gcGVy
bWl0IHBlcnNvbnMgdG8KPj4+Pj4gd2hvbSB0aGUKPj4+Pj4gKyAqIFNvZnR3YXJlIGlzIGZ1cm5p
c2hlZCB0byBkbyBzbywgc3ViamVjdCB0byB0aGUgZm9sbG93aW5nCj4+Pj4+IGNvbmRpdGlvbnM6
Cj4+Pj4+ICsgKgo+Pj4+PiArICogVGhlIGFib3ZlIGNvcHlyaWdodCBub3RpY2UgYW5kIHRoaXMg
cGVybWlzc2lvbiBub3RpY2Ugc2hhbGwgYmUKPj4+Pj4gaW5jbHVkZWQgaW4KPj4+Pj4gKyAqIGFs
bCBjb3BpZXMgb3Igc3Vic3RhbnRpYWwgcG9ydGlvbnMgb2YgdGhlIFNvZnR3YXJlLgo+Pj4+PiAr
ICoKPj4+Pj4gKyAqIFRIRSBTT0ZUV0FSRSBJUyBQUk9WSURFRCAiQVMgSVMiLCBXSVRIT1VUIFdB
UlJBTlRZIE9GIEFOWSBLSU5ELAo+Pj4+PiBFWFBSRVNTIE9SCj4+Pj4+ICsgKiBJTVBMSUVELCBJ
TkNMVURJTkcgQlVUIE5PVCBMSU1JVEVEIFRPIFRIRSBXQVJSQU5USUVTIE9GCj4+Pj4+IE1FUkNI
QU5UQUJJTElUWSwKPj4+Pj4gKyAqIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFIEFO
RCBOT05JTkZSSU5HRU1FTlQuIElOIE5PCj4+Pj4+IEVWRU5UIFNIQUxMCj4+Pj4+ICsgKiBUSEUg
Q09QWVJJR0hUIEhPTERFUihTKSBPUiBBVVRIT1IoUykgQkUgTElBQkxFIEZPUiBBTlkgQ0xBSU0s
Cj4+Pj4+IERBTUFHRVMgT1IKPj4+Pj4gKyAqIE9USEVSIExJQUJJTElUWSwgV0hFVEhFUiBJTiBB
TiBBQ1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQgT1IKPj4+Pj4gT1RIRVJXSVNFLAo+Pj4+PiArICog
QVJJU0lORyBGUk9NLCBPVVQgT0YgT1IgSU4gQ09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBP
UiBUSEUKPj4+Pj4gVVNFIE9SCj4+Pj4+ICsgKiBPVEhFUiBERUFMSU5HUyBJTiBUSEUgU09GVFdB
UkUuCj4+Pj4+ICsgKgo+Pj4+PiArICovCj4+Pj4+ICsjaW5jbHVkZSA8bGludXgvc2VtYXBob3Jl
Lmg+Cj4+Pj4+ICsjaW5jbHVkZSA8bGludXgvYXRvbWljLmg+Cj4+Pj4+ICsKPj4+Pj4gKy8qCj4+
Pj4+ICsgKiBSZXVzYWJsZSAyIFBIQVNFIHRhc2sgYmFycmllciAocmFuZGV2b3V6IHBvaW50KSBp
bXBsZW1lbnRhdGlvbgo+Pj4+PiBmb3IgTiB0YXNrcy4KPj4+Pj4gKyAqIEJhc2VkIG9uIHRoZSBM
aXR0bGUgYm9vayBvZiBzZW1wYWhvcmVzIC0KPj4+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ3JlZW50ZWFwcmVzcy5j
b20lMkZ3cCUyRnNlbWFwaG9yZXMlMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q0FuZHJleS5Hcm9kem92
c2t5JTQwYW1kLmNvbSU3Q2RjZDBmMWE0Y2ZhNDQwZDdiMWFlMDhkNzdmMTU0OTM1JTdDM2RkODk2
MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzExNzYwMTcwNzMwNjgyMSZh
bXA7c2RhdGE9WDMlMkJnNVhwRk5yTmJWa2E2V2hCOFR4amhPRzF5dWMlMkJrNiUyRmRjdU8yTmx3
MCUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4+Pj4KPj4+Pj4gKyAqLwo+Pj4+PiArCj4+Pj4+ICsKPj4+
Pj4gKwo+Pj4+PiArI2lmbmRlZiBEUk1fVEFTS19CQVJSSUVSX0hfCj4+Pj4+ICsjZGVmaW5lIERS
TV9UQVNLX0JBUlJJRVJfSF8KPj4+Pj4gKwo+Pj4+PiArLyoKPj4+Pj4gKyAqIFJlcHJlc2VudHMg
YW4gaW5zdGFuY2Ugb2YgYSB0YXNrIGJhcnJpZXIuCj4+Pj4+ICsgKi8KPj4+Pj4gK3N0cnVjdCB0
YXNrX2JhcnJpZXIgewo+Pj4+PiArwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBuOwo+Pj4+PiAr
wqDCoMKgwqDCoMKgIGF0b21pY190IGNvdW50Owo+Pj4+PiArwqDCoMKgwqDCoMKgIHN0cnVjdCBz
ZW1hcGhvcmUgZW50ZXJfdHVybnN0aWxlOwo+Pj4+PiArwqDCoMKgwqDCoMKgIHN0cnVjdCBzZW1h
cGhvcmUgZXhpdF90dXJuc3RpbGU7Cj4+Pj4+ICt9Owo+Pj4+PiArCj4+Pj4+ICtzdGF0aWMgaW5s
aW5lIHZvaWQgdGFza19iYXJyaWVyX3NpZ25hbF90dXJuc3RpbGUoc3RydWN0IHNlbWFwaG9yZQo+
Pj4+PiAqdHVybnN0aWxlLAo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB1bnNpZ25lZCBpbnQgbikKPj4+Pj4gK3sKPj4+Pj4gK8KgwqDCoMKgwqDCoCBpbnQgaTsK
Pj4+Pj4gKwo+Pj4+PiArwqDCoMKgwqDCoMKgIGZvciAoaSA9IDAgOyBpIDwgbjsgaSsrKQo+Pj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1cCh0dXJuc3RpbGUpOwo+Pj4+PiArfQo+
Pj4+PiArCj4+Pj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgdGFza19iYXJyaWVyX2luaXQoc3RydWN0
IHRhc2tfYmFycmllciAqdGIpCj4+Pj4+ICt7Cj4+Pj4+ICvCoMKgwqDCoMKgwqAgdGItPm4gPSAw
Owo+Pj4+PiArwqDCoMKgwqDCoMKgIGF0b21pY19zZXQoJnRiLT5jb3VudCwgMCk7Cj4+Pj4+ICvC
oMKgwqDCoMKgwqAgc2VtYV9pbml0KCZ0Yi0+ZW50ZXJfdHVybnN0aWxlLCAwKTsKPj4+Pj4gK8Kg
wqDCoMKgwqDCoCBzZW1hX2luaXQoJnRiLT5leGl0X3R1cm5zdGlsZSwgMCk7Cj4+Pj4+ICt9Cj4+
Pj4+ICsKPj4+Pj4gK3N0YXRpYyBpbmxpbmUgdm9pZCB0YXNrX2JhcnJpZXJfYWRkX3Rhc2soc3Ry
dWN0IHRhc2tfYmFycmllciAqdGIpCj4+Pj4+ICt7Cj4+Pj4+ICvCoMKgwqDCoMKgwqAgdGItPm4r
KzsKPj4+Pj4gK30KPj4+Pj4gKwo+Pj4+PiArc3RhdGljIGlubGluZSB2b2lkIHRhc2tfYmFycmll
cl9yZW1fdGFzayhzdHJ1Y3QgdGFza19iYXJyaWVyICp0YikKPj4+Pj4gK3sKPj4+Pj4gK8KgwqDC
oMKgwqDCoCB0Yi0+bi0tOwo+Pj4+PiArfQo+Pj4+PiArCj4+Pj4+ICsvKgo+Pj4+PiArICogTGlu
ZXMgdXAgYWxsIHRoZSB0aHJlYWRzIEJFRk9SRSB0aGUgY3JpdGljYWwgcG9pbnQuCj4+Pj4+ICsg
Kgo+Pj4+PiArICogV2hlbiBhbGwgdGhyZWFkIHBhc3NlZCB0aGlzIGNvZGUgdGhlIGVudHJ5IGJh
cnJpZXIgaXMgYmFjayB0bwo+Pj4+PiBsb2NrZWQgc3RhdGUuCj4+Pj4+ICsgKi8KPj4+Pj4gK3N0
YXRpYyBpbmxpbmUgdm9pZCB0YXNrX2JhcnJpZXJfZW50ZXIoc3RydWN0IHRhc2tfYmFycmllciAq
dGIpCj4+Pj4+ICt7Cj4+Pj4+ICvCoMKgwqDCoMKgwqAgaWYgKGF0b21pY19pbmNfcmV0dXJuKCZ0
Yi0+Y291bnQpID09IHRiLT5uKQo+Pj4+PiArIHRhc2tfYmFycmllcl9zaWduYWxfdHVybnN0aWxl
KCZ0Yi0+ZW50ZXJfdHVybnN0aWxlLCB0Yi0+bik7Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoMKgwqDC
oCBkb3duKCZ0Yi0+ZW50ZXJfdHVybnN0aWxlKTsKPj4+Pj4gK30KPj4+Pj4gKwo+Pj4+PiArLyoK
Pj4+Pj4gKyAqIExpbmVzIHVwIGFsbCB0aGUgdGhyZWFkcyBBRlRFUiB0aGUgY3JpdGljYWwgcG9p
bnQuCj4+Pj4+ICsgKgo+Pj4+PiArICogVGhpcyBmdW5jdGlvbiBpcyB1c2VkIHRvIGF2b2lkIGFu
eSBvbmUgdGhyZWFkIHJ1bm5pbmcgYWhlYWQgb2YKPj4+Pj4gdGhlIHJlc2V0IGlmCj4+Pj4+ICsg
KiB0aGUgYmFycmllciBpcyB1c2VkIGluIGEgbG9vcCAocmVwZWF0ZWRseSkgLgo+Pj4+PiArICov
Cj4+Pj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgdGFza19iYXJyaWVyX2V4aXQoc3RydWN0IHRhc2tf
YmFycmllciAqdGIpCj4+Pj4+ICt7Cj4+Pj4+ICvCoMKgwqDCoMKgwqAgaWYgKGF0b21pY19kZWNf
cmV0dXJuKCZ0Yi0+Y291bnQpID09IDApCj4+Pj4+ICsgdGFza19iYXJyaWVyX3NpZ25hbF90dXJu
c3RpbGUoJnRiLT5leGl0X3R1cm5zdGlsZSwgdGItPm4pOwo+Pj4+PiArCj4+Pj4+ICvCoMKgwqDC
oMKgwqAgZG93bigmdGItPmV4aXRfdHVybnN0aWxlKTsKPj4+Pj4gK30KPj4+Pj4gKwo+Pj4+PiAr
c3RhdGljIGlubGluZSB2b2lkIHRhc2tfYmFycmllcl9mdWxsKHN0cnVjdCB0YXNrX2JhcnJpZXIg
KnRiKQo+Pj4+PiArewo+Pj4+PiArwqDCoMKgwqDCoMKgIHRhc2tfYmFycmllcl9lbnRlcih0Yik7
Cj4+Pj4+ICvCoMKgwqDCoMKgwqAgdGFza19iYXJyaWVyX2V4aXQodGIpOwo+Pj4+PiArfQo+Pj4+
PiArCj4+Pj4+ICsjZW5kaWYKPj4+Pj4gLS0gCj4+Pj4+IDIuNy40Cj4+Pj4+Cj4+Pj4+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+Pj4+IGFtZC1nZngg
bWFpbGluZyBsaXN0Cj4+Pj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+Pj4+IGh0
dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUz
QSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1n
ZngmYW1wO2RhdGE9MDIlN0MwMSU3Q0FuZHJleS5Hcm9kem92c2t5JTQwYW1kLmNvbSU3Q2RjZDBm
MWE0Y2ZhNDQwZDdiMWFlMDhkNzdmMTU0OTM1JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0
ZTE4M2QlN0MwJTdDMCU3QzYzNzExNzYwMTcwNzMwNjgyMSZhbXA7c2RhdGE9YllzRGNkTTBYNE13
MlElMkZRR0ViOXYwa1hwT2pxYW11RFZBVjhqSjVZUmpzJTNEJmFtcDtyZXNlcnZlZD0wIAo+Pj4+
Pgo+Pj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+
Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+Pj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5m
byUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q0FuZHJleS5Hcm9kem92c2t5JTQwYW1kLmNv
bSU3Q2RjZDBmMWE0Y2ZhNDQwZDdiMWFlMDhkNzdmMTU0OTM1JTdDM2RkODk2MWZlNDg4NGU2MDhl
MTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzExNzYwMTcwNzMwNjgyMSZhbXA7c2RhdGE9Yllz
RGNkTTBYNE13MlElMkZRR0ViOXYwa1hwT2pxYW11RFZBVjhqSjVZUmpzJTNEJmFtcDtyZXNlcnZl
ZD0wIAo+Pj4+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
