Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D799BC34056
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 19:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F4420801
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 19:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XV9mQp5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F4420801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F64E6EC7F;
	Wed, 19 Feb 2020 19:06:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6F96EC7F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 19:06:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDm6iyu28noLkB44bTZDtB5ggaTr6Lu5/PzQKqRAsB7pKdMMwDgsDLwoyEUFNVlCViv0FU/9YueHUCQ//qGSHYdLJt+6urMqgUO1RNiibShAOCCx+XMs27WylUU02oW+ZpDno8vxVlSsio8WZKjFvGNxl5I8K22zSZyv/E8b+LGcTEhckwAreWvyER9oPg8WAtWkTeDoP59GKt4ZfdMCEeAxLXO0wHVd8CgQfC6wRvOkI8fVieLZ+8XljPwYIeMlLzqNLFeuaBfcQsmAGpgGEmDp71GSrOMs3AkpBuuKVAdaFmHQMGJP1mjpqmHdtlRLmsxmNVvRK/HCQkCDt9q8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAzEmDvYHp0rjfcHW0gcOGP35vUuhEThME/n0OL0YM4=;
 b=jNl3rZVx4AqSlYadaE7ly3gesO4aMLeVY7sGcYEtT+0+Kk22dnvrRtwyKYDt/Wne79HgryCmsdZpWeCFKDQSpf+p+YqrCTiDtZ/lpt29i2OD741Y5Rs0jHRzRV9sUsaP6A3y27FN/GA31dA28O5XGbQYVCvxtmJEwrDqDKufQV5esv6XglebE4Na8Ocbue27u3obkL0yI2SbsWbIqUpRRbst1pjdrJkM0sYcfCWoNH+Pk6W4vVCiF474iPM6ttgM+WIEa9DPLkcUrblUEPBksuz6qgcb1rJcIPg2skQxN2T+K4ONjGkhC5oyTs/UuU9ujOtUv8V+T+pn7jrMGT+0Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAzEmDvYHp0rjfcHW0gcOGP35vUuhEThME/n0OL0YM4=;
 b=XV9mQp5FFvvG0MIi6KRTknT5ef/YjK+HQK4cwkHWlTs1AmydHcExSKYP4LpGKuDt79fQdjawafTZ976PHxtxmlrrldPtuQUWhJQnM7S98hTHwHHbM8wS+vE+PHExb93hkf2kzcPbbcCdjjQlHmnavpJGykGq+tX8oyle/bJgBrQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0010.namprd12.prod.outlook.com (10.172.87.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 19:06:30 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 19:06:29 +0000
Subject: Re: [RFC PATCH v6] drm/amdgpu: Remove kfd eviction fence before
 release bo
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200219124652.7465-1-xinhui.pan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f40cfec5-a2c7-761d-888e-949867b641f7@amd.com>
Date: Wed, 19 Feb 2020 14:06:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20200219124652.7465-1-xinhui.pan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::19)
 To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.31.19.228] (165.204.54.211) by
 YT1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 19:06:29 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9506925-c21a-4acd-b1b2-08d7b56ed38b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0010:|DM5PR1201MB0010:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB001025387B6A58723C88893692100@DM5PR1201MB0010.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(189003)(199004)(4326008)(86362001)(956004)(2906002)(2616005)(66574012)(478600001)(53546011)(31696002)(186003)(26005)(44832011)(6486002)(16526019)(5660300002)(16576012)(81166006)(81156014)(36756003)(31686004)(8936002)(8676002)(316002)(54906003)(66946007)(66476007)(66556008)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0010;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gyD3EBBv2N3l3visZjvOqBAPkVLOC8DOsihdsg64gfLOVhF4+hLJcP9GQF60QLLqCAkbSwIuSre/cmh5gZcvw2YfR0DnnFcgjIAO3ol4G/D0y1pTmISk3X0PfOCPpRFCRMkERoDvDg+1nEuMXz2lIjXIdWCRpRQQ1NtwPwSD9avEIFfWuWv+pnlCIs4DM7z4BnlAI0+QsNdTva1YnXUZ05BdRbS3M3me3BgWviWUGpr68UwGg/TrcHAYzEvN5md/NXt00sObJSes6HVuk78OrEyjRMfDLVTR9deq++SsZzndHimGpD1NNf6LiWf6YURztXcG8sFPSMgDyMPXmGRzujgul72YvZsfW7qFfo6CJr4BH3ydX861ktTyb1hfLQG0dRYcCoWZXdsrjY4Tihpa6FLkj1ovF/y52L5fwkYFSOdg+D6qbRONoX5xq9KhRHCo
X-MS-Exchange-AntiSpam-MessageData: PxPajCPE+hMtaldFnUZRlqhFBOt73rnHCKf0z3RHWGRa/UE0niyV6iSNeEQqiDDWw5M5R+VjDVxKrb34EFsctUvSYwVc2Pfj2CMM73dXcrQfgGS4OEhH5vxEXl8BLphYFlfJ8Ij25nDduE20nPIBbA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9506925-c21a-4acd-b1b2-08d7b56ed38b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 19:06:29.9180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DYi8/Z2sSDYnTpZJ+zxQ0IYcJ3PrfDImpxMcGSGnrn722V8/Jwn6cKzYc8DrfEXmsivL2BRSnng/eeZuNxqag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0010
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMi0xOSA3OjQ2LCB4aW5odWkgcGFuIHdyb3RlOgo+IE5vIG5lZWQgdG8gdHJpZ2dl
ciBldmljdGlvbiBhcyB0aGUgbWVtb3J5IG1hcHBpbmcgd2lsbCBub3QgYmUgdXNlZAo+IGFueW1v
cmUuCj4KPiBBbGwgcHQvcGQgYm9zIHNoYXJlIHNhbWUgcmVzdiwgaGVuY2UgdGhlIHNhbWUgc2hh
cmVkIGV2aWN0aW9uIGZlbmNlLgo+IEV2ZXJ5dGltZSBwYWdlIHRhYmxlIGlzIGZyZWVkLCB0aGUg
ZmVuY2Ugd2lsbCBiZSBzaWdubGVkIGFuZCB0aGF0IGN1YXNlcwo+IGtmZCB1bmV4Y2VwdGVkIGV2
aWN0aW9ucy4KPgo+IENDOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Cj4gQ0M6IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0BhbWQuY29tPgo+IENDOiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQWNrZWQtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiB4
aW5odWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxp
bmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgoKPiAtLS0KPiBjaGFuZ2UgZnJvbSB2NToKPiB1
c2UgdHJ5bG9jayBpbnN0ZWFkLCBhbmQgYWRkIHdhcm5fb25fb25jZSB0byBnaXZlIGEgbGltaXRk
IHdhcm5pbmcuCj4KPiBjaGFuZ2UgZnJvbSB2NDoKPiBiYXNlZCBvbiBuZXcgdHRtIGNvZGUuCj4K
PiBjaGFuZ2UgZnJvbSB2MzoKPiBmaXggYSBjb2RpbmcgZXJyb3IKPgo+IGNoYW5nZSBmcm9tIHYy
Ogo+IGJhc2VkIG9uIENocmlzJyBkcm0vdHRtOiByZXdvcmsgQk8gZGVsYXllZCBkZWxldGUgcGF0
Y2hzZXQuCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2Zk
LmggICAgfCAgMSArCj4gICAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1
dm0uYyAgfCAzOCArKysrKysrKysrKysrKysrKysrCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfb2JqZWN0LmMgICAgfCAgNSArKysKPiAgIDMgZmlsZXMgY2hhbmdlZCwgNDQg
aW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmQuaAo+IGluZGV4IDllOGRiNzAyZDg3OC4uMGVlOGFhZTZjNTE5IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuaAo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuaAo+IEBAIC05Niw2ICs5Niw3IEBAIHN0
cnVjdCBhbWRncHVfYW1ka2ZkX2ZlbmNlICphbWRncHVfYW1ka2ZkX2ZlbmNlX2NyZWF0ZSh1NjQg
Y29udGV4dCwKPiAgIAkJCQkJCSAgICAgICBzdHJ1Y3QgbW1fc3RydWN0ICptbSk7Cj4gICBib29s
IGFtZGtmZF9mZW5jZV9jaGVja19tbShzdHJ1Y3QgZG1hX2ZlbmNlICpmLCBzdHJ1Y3QgbW1fc3Ry
dWN0ICptbSk7Cj4gICBzdHJ1Y3QgYW1kZ3B1X2FtZGtmZF9mZW5jZSAqdG9fYW1kZ3B1X2FtZGtm
ZF9mZW5jZShzdHJ1Y3QgZG1hX2ZlbmNlICpmKTsKPiAraW50IGFtZGdwdV9hbWRrZmRfcmVtb3Zl
X2ZlbmNlX29uX3B0X3BkX2JvcyhzdHJ1Y3QgYW1kZ3B1X2JvICpibyk7Cj4gICAKPiAgIHN0cnVj
dCBhbWRrZmRfcHJvY2Vzc19pbmZvIHsKPiAgIAkvKiBMaXN0IGhlYWQgb2YgYWxsIFZNcyB0aGF0
IGJlbG9uZyB0byBhIEtGRCBwcm9jZXNzICovCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+IGluZGV4IGVmNzIxY2I2NTg2OC4uODk4ODUx
YmVjMzc3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmRfZ3B1dm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmRfZ3B1dm0uYwo+IEBAIC0yNzYsNiArMjc2LDQyIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Ft
ZGtmZF9yZW1vdmVfZXZpY3Rpb25fZmVuY2Uoc3RydWN0IGFtZGdwdV9ibyAqYm8sCj4gICAJcmV0
dXJuIDA7Cj4gICB9Cj4gICAKPiAraW50IGFtZGdwdV9hbWRrZmRfcmVtb3ZlX2ZlbmNlX29uX3B0
X3BkX2JvcyhzdHJ1Y3QgYW1kZ3B1X2JvICpibykKPiArewo+ICsJc3RydWN0IGFtZGdwdV9ibyAq
cm9vdCA9IGJvOwo+ICsJc3RydWN0IGFtZGdwdV92bV9ib19iYXNlICp2bV9ibzsKPiArCXN0cnVj
dCBhbWRncHVfdm0gKnZtOwo+ICsJc3RydWN0IGFtZGtmZF9wcm9jZXNzX2luZm8gKmluZm87Cj4g
KwlzdHJ1Y3QgYW1kZ3B1X2FtZGtmZF9mZW5jZSAqZWY7Cj4gKwlpbnQgcmV0Owo+ICsKPiArCS8q
IHdlIGNhbiBhbHdheXMgZ2V0IHZtX2JvIGZyb20gcm9vdCBQRCBiby4qLwo+ICsJd2hpbGUgKHJv
b3QtPnBhcmVudCkKPiArCQlyb290ID0gcm9vdC0+cGFyZW50Owo+ICsKPiArCXZtX2JvID0gcm9v
dC0+dm1fYm87Cj4gKwlpZiAoIXZtX2JvKQo+ICsJCXJldHVybiAwOwo+ICsKPiArCXZtID0gdm1f
Ym8tPnZtOwo+ICsJaWYgKCF2bSkKPiArCQlyZXR1cm4gMDsKPiArCj4gKwlpbmZvID0gdm0tPnBy
b2Nlc3NfaW5mbzsKPiArCWlmICghaW5mbyB8fCAhaW5mby0+ZXZpY3Rpb25fZmVuY2UpCj4gKwkJ
cmV0dXJuIDA7Cj4gKwo+ICsJZWYgPSBjb250YWluZXJfb2YoZG1hX2ZlbmNlX2dldCgmaW5mby0+
ZXZpY3Rpb25fZmVuY2UtPmJhc2UpLAo+ICsJCQlzdHJ1Y3QgYW1kZ3B1X2FtZGtmZF9mZW5jZSwg
YmFzZSk7Cj4gKwo+ICsJQlVHX09OKCFkbWFfcmVzdl90cnlsb2NrKGJvLT50Ym8uYmFzZS5yZXN2
KSk7Cj4gKwlyZXQgPSBhbWRncHVfYW1ka2ZkX3JlbW92ZV9ldmljdGlvbl9mZW5jZShibywgZWYp
Owo+ICsJZG1hX3Jlc3ZfdW5sb2NrKGJvLT50Ym8uYmFzZS5yZXN2KTsKPiArCj4gKwlkbWFfZmVu
Y2VfcHV0KCZlZi0+YmFzZSk7Cj4gKwlyZXR1cm4gcmV0Owo+ICt9Cj4gKwo+ICAgc3RhdGljIGlu
dCBhbWRncHVfYW1ka2ZkX2JvX3ZhbGlkYXRlKHN0cnVjdCBhbWRncHVfYm8gKmJvLCB1aW50MzJf
dCBkb21haW4sCj4gICAJCQkJICAgICBib29sIHdhaXQpCj4gICB7Cj4gQEAgLTEwNDUsNiArMTA4
MSw4IEBAIHZvaWQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9kZXN0cm95X2NiKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAo+ICAgCWxpc3RfZGVsKCZ2bS0+dm1fbGlzdF9ub2RlKTsKPiAgIAltdXRl
eF91bmxvY2soJnByb2Nlc3NfaW5mby0+bG9jayk7Cj4gICAKPiArCXZtLT5wcm9jZXNzX2luZm8g
PSBOVUxMOwo+ICsKPiAgIAkvKiBSZWxlYXNlIHBlci1wcm9jZXNzIHJlc291cmNlcyB3aGVuIGxh
c3QgY29tcHV0ZSBWTSBpcyBkZXN0cm95ZWQgKi8KPiAgIAlpZiAoIXByb2Nlc3NfaW5mby0+bl92
bXMpIHsKPiAgIAkJV0FSTl9PTighbGlzdF9lbXB0eSgmcHJvY2Vzc19pbmZvLT5rZmRfYm9fbGlz
dCkpOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2Jq
ZWN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPiBpbmRl
eCA2ZjYwYTU4MWUzYmEuLjU3NjZkMjBmMjlkOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPiBAQCAtMTMwNyw2ICsxMzA3LDExIEBAIHZvaWQgYW1k
Z3B1X2JvX3JlbGVhc2Vfbm90aWZ5KHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8pCj4gICAJ
aWYgKGFiby0+a2ZkX2JvKQo+ICAgCQlhbWRncHVfYW1ka2ZkX3VucmVzZXJ2ZV9tZW1vcnlfbGlt
aXQoYWJvKTsKPiAgIAo+ICsJLyogV2Ugb25seSByZW1vdmUgdGhlIGZlbmNlIGlmIHRoZSByZXN2
IGhhcyBpbmRpdmlkdWFsaXplZC4gKi8KPiArCVdBUk5fT05fT05DRShiby0+YmFzZS5yZXN2ICE9
ICZiby0+YmFzZS5fcmVzdik7Cj4gKwlpZiAoYm8tPmJhc2UucmVzdiA9PSAmYm8tPmJhc2UuX3Jl
c3YpCj4gKwkJYW1kZ3B1X2FtZGtmZF9yZW1vdmVfZmVuY2Vfb25fcHRfcGRfYm9zKGFibyk7Cj4g
Kwo+ICAgCWlmIChiby0+bWVtLm1lbV90eXBlICE9IFRUTV9QTF9WUkFNIHx8ICFiby0+bWVtLm1t
X25vZGUgfHwKPiAgIAkgICAgIShhYm8tPmZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9X
SVBFX09OX1JFTEVBU0UpKQo+ICAgCQlyZXR1cm47Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
