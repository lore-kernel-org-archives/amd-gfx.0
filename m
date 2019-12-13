Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E330C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 00:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03052073B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 00:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4h7gXN+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03052073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9148A89F43;
	Fri, 13 Dec 2019 00:25:21 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam04on0624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4e::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF6D889E63
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 00:25:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLlqb5ZvOSc2QlMIJtY9t4Fs6zNcL5ej1b1/66IC9B7D1zMAKk6ruL01fmylDocLpApwCAOuZ3k3spVt3s2bkU5OjVBO3UBOC4G2PuyuHFsKB2YlHTIjaR/CnX4QvQZJwOAwalsRD08xAfiVjxoys0ixJQKoDSdozSU1gIAemxUV3ao09BoYhdZjFxd9C0EKUm/B4usr4c/w9JZ/kvmU+hQab2qrxXUgpMEQJi5RjuYzfo45xjen11iwpWg7fEVTdpMYg6xX1WLWV+WwQBjo/RbaRBhxjCRdu98z7clfUs7kL1bH/xIqA6WtyxyIv8OY0B7QWUiEjmGurQSkXSJMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9xyvW4iS3BWUGDFR66wE+bdFxlYklJqawQ+78NhveQ=;
 b=NJ9FMswVJfOwIRps1Qz/OFYTUN9aWBdoY6OzfzubHb2+OqJjxyI/vJDE5koABBU6zBrTE1eS5fJ+/zoC0YcOXfvuKxvBk2uCkex1sM+2rtAeNOqVudG4wzwBhequPRf7GwB8PmYLJrBvXCWwPiiGVdlr4hC1eZWmdMzMB/JNw5Uj6CT4o0LSQHKA+3S/z+oZhAuju/LrwGqtRxcCG+/gz5HJICMbjlV4DPA14hDlXy0hiktZ9F43I8iugGQy3PMZfRG7yYRbyf1wUNfn/C92eu178UKBXqw9XUEoA14W5xStICIgftiQ9oPvehwv6NtDFQzz6TetoxanuLZyiL6Jrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9xyvW4iS3BWUGDFR66wE+bdFxlYklJqawQ+78NhveQ=;
 b=4h7gXN+vs+lSjZXAi2mOn1gZffFwLUxkhb8AXe5dnIfTJY79Dj5mcs8U7i4ARkR7TQyr249jgyYS2c5d4sTKbVIem6jt/ekbHWHM0HDSe4bzL6EGy7pysvxO292mrEuLKwlpI7yYrLO9KHZotdybiITGd7524q39FNyZ1lF4AX4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3033.namprd12.prod.outlook.com (20.178.31.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Fri, 13 Dec 2019 00:25:19 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2516.018; Fri, 13 Dec 2019
 00:25:19 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: Add Arcturus specific
 set_vm_context_page_table_base()
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191203044215.29605-1-Yong.Zhao@amd.com>
 <20191203044215.29605-2-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <82eaab73-939f-4d0c-1984-46304d92a469@amd.com>
Date: Thu, 12 Dec 2019 16:25:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191203044215.29605-2-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BYAPR06CA0068.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::45) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [12.1.75.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: edb95857-5c86-4e81-42ef-08d77f62ef12
X-MS-TrafficTypeDiagnostic: DM6PR12MB3033:|DM6PR12MB3033:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3033AFEF622E6494ED7D620A92540@DM6PR12MB3033.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0250B840C1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(86362001)(31686004)(36756003)(2906002)(31696002)(316002)(66946007)(66556008)(66476007)(6512007)(81166006)(8676002)(5660300002)(186003)(26005)(44832011)(478600001)(2616005)(6486002)(81156014)(53546011)(6666004)(8936002)(6506007)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3033;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFlRbje5lOaZcsTaIwBDDzegVd4FiIeiC0PteNO33W+Y5lWKo5gsvMkWQ9W0OEXnOpTAq+HDMJWFVpDVV+T5BIh1FYEWzIcdTry1eTFr8uPGgINcBzLDl1tj+CKurpifILX6YSRVxBeLtqXCpbLI3WmSEkDFmxRUZJaHtwnyQwUG+MqXRU4ujzrX3xWkB4vwe+VO5vrIoWxpUZmex3T9SbctlJRgR6HdSXwBTM/EYt+fBSCCsi2olaEP3j3N6D38tTg07TifywTnEFvDvkQdfxtSoBF2eZHcvXZiUV3yz00y0mLfdLLL+vzs3q7UUCN3qt3+X4Dc5/g8h+rOvu0zfCFIvPEQJ4+yhZtuk9qrobSJyRuKN2RwIiXNggGW0aC+RbreIYvAR+YXcvP1b1owH7IsrutLkLXQJV+Lq06jouQvzWdH4KRsqakvOjr0a/a7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb95857-5c86-4e81-42ef-08d77f62ef12
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 00:25:19.2747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6KE/6Sn1s3/+krtD54MBuGpbk+SkI+sJWrJwtW7amhs3H5Ys5H1uc1c8Acd02qJKf+sgxA9b/7ZJQ56ew6fAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3033
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

SSBhZ3JlZSB3aXRoIENocmlzdGlhbidzIGNvbW1lbnRzIG9uIHBhdGNoIDEuIFdpdGggdGhvc2Ug
Zml4ZWQsIHRoZSAKc2VyaWVzIGlzCgpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4
Lkt1ZWhsaW5nQGFtZC5jb20+CgpSZWdhcmRzLAogwqAgRmVsaXgKCk9uIDIwMTktMTItMDIgMjA6
NDIsIFlvbmcgWmhhbyB3cm90ZToKPiBTaW5jZSBBcmN0dXJ1cyBoYXMgaXQgb3duIGZ1bmN0aW9u
IHBvaW50ZXIsIHdlIGNhbiBtb3ZlIEFyY3R1cnVzCj4gc3BlY2lmaWMgbG9naWMgdG8gdGhlcmUg
cmF0aGVyIHRoYW4gbGVhdmluZyBpdCBlbnRhbmdsZWQgd2l0aAo+IG90aGVyIEdGWDkgY2hpcHMu
Cj4KPiBDaGFuZ2UtSWQ6IEk3ZGY3YzAwNGEwYzhhYzA2MTZkZWQwZTY1MTQ0NjcwZGY1MGY5MmE3
Cj4gU2lnbmVkLW9mZi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNvbT4KPiAtLS0KPiAg
IC4uLi9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2FyY3R1cnVzLmMgICB8IDIwICsrKysr
KysrKysrKysrKysrKy0KPiAgIC4uLi9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9n
ZnhfdjkuYyB8IDE0ICsrKy0tLS0tLS0tLS0KPiAgIC4uLi9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZF9nZnhfdjkuaCB8ICAyIC0tCj4gICAzIGZpbGVzIGNoYW5nZWQsIDIyIGluc2Vy
dGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfYXJjdHVydXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfYXJjdHVydXMuYwo+IGluZGV4IGI2NzEzZTBlZDFiMi4u
M2MxMTk0MDdkYzM0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hbWRrZmRfYXJjdHVydXMuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmRfYXJjdHVydXMuYwo+IEBAIC00Niw2ICs0Niw4IEBACj4gICAjaW5jbHVk
ZSAic29jMTUuaCIKPiAgICNpbmNsdWRlICJzb2MxNWQuaCIKPiAgICNpbmNsdWRlICJhbWRncHVf
YW1ka2ZkX2dmeF92OS5oIgo+ICsjaW5jbHVkZSAiZ2Z4aHViX3YxXzAuaCIKPiArI2luY2x1ZGUg
Im1taHViX3Y5XzQuaCIKPiAgIAo+ICAgI2RlZmluZSBIUURfTl9SRUdTIDU2Cj4gICAjZGVmaW5l
IERVTVBfUkVHKGFkZHIpIGRvIHsJCQkJXAo+IEBAIC0yNTgsNiArMjYwLDIyIEBAIHN0YXRpYyBp
bnQga2dkX2hxZF9zZG1hX2Rlc3Ryb3koc3RydWN0IGtnZF9kZXYgKmtnZCwgdm9pZCAqbXFkLAo+
ICAgCXJldHVybiAwOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyB2b2lkIGtnZF9zZXRfdm1fY29udGV4
dF9wYWdlX3RhYmxlX2Jhc2Uoc3RydWN0IGtnZF9kZXYgKmtnZCwgdWludDMyX3Qgdm1pZCwKPiAr
CQl1aW50NjRfdCBwYWdlX3RhYmxlX2Jhc2UpCj4gK3sKPiArCXN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2ID0gZ2V0X2FtZGdwdV9kZXZpY2Uoa2dkKTsKPiArCj4gKwlpZiAoIWFtZGdwdV9hbWRr
ZmRfaXNfa2ZkX3ZtaWQoYWRldiwgdm1pZCkpIHsKPiArCQlwcl9lcnIoInRyeWluZyB0byBzZXQg
cGFnZSB0YWJsZSBiYXNlIGZvciB3cm9uZyBWTUlEICV1XG4iLAo+ICsJCSAgICAgICB2bWlkKTsK
PiArCQlyZXR1cm47Cj4gKwl9Cj4gKwo+ICsJbW1odWJfdjlfNF9zZXR1cF92bV9wdF9yZWdzKGFk
ZXYsIHZtaWQsIHBhZ2VfdGFibGVfYmFzZSk7Cj4gKwo+ICsJZ2Z4aHViX3YxXzBfc2V0dXBfdm1f
cHRfcmVncyhhZGV2LCB2bWlkLCBwYWdlX3RhYmxlX2Jhc2UpOwo+ICt9Cj4gKwo+ICAgY29uc3Qg
c3RydWN0IGtmZDJrZ2RfY2FsbHMgYXJjdHVydXNfa2ZkMmtnZCA9IHsKPiAgIAkucHJvZ3JhbV9z
aF9tZW1fc2V0dGluZ3MgPSBrZ2RfZ2Z4X3Y5X3Byb2dyYW1fc2hfbWVtX3NldHRpbmdzLAo+ICAg
CS5zZXRfcGFzaWRfdm1pZF9tYXBwaW5nID0ga2dkX2dmeF92OV9zZXRfcGFzaWRfdm1pZF9tYXBw
aW5nLAo+IEBAIC0yNzcsNyArMjk1LDcgQEAgY29uc3Qgc3RydWN0IGtmZDJrZ2RfY2FsbHMgYXJj
dHVydXNfa2ZkMmtnZCA9IHsKPiAgIAkuZ2V0X2F0Y192bWlkX3Bhc2lkX21hcHBpbmdfaW5mbyA9
Cj4gICAJCQlrZ2RfZ2Z4X3Y5X2dldF9hdGNfdm1pZF9wYXNpZF9tYXBwaW5nX2luZm8sCj4gICAJ
LmdldF90aWxlX2NvbmZpZyA9IGtnZF9nZnhfdjlfZ2V0X3RpbGVfY29uZmlnLAo+IC0JLnNldF92
bV9jb250ZXh0X3BhZ2VfdGFibGVfYmFzZSA9IGtnZF9nZnhfdjlfc2V0X3ZtX2NvbnRleHRfcGFn
ZV90YWJsZV9iYXNlLAo+ICsJLnNldF92bV9jb250ZXh0X3BhZ2VfdGFibGVfYmFzZSA9IGtnZF9z
ZXRfdm1fY29udGV4dF9wYWdlX3RhYmxlX2Jhc2UsCj4gICAJLmludmFsaWRhdGVfdGxicyA9IGtn
ZF9nZnhfdjlfaW52YWxpZGF0ZV90bGJzLAo+ICAgCS5pbnZhbGlkYXRlX3RsYnNfdm1pZCA9IGtn
ZF9nZnhfdjlfaW52YWxpZGF0ZV90bGJzX3ZtaWQsCj4gICAJLmdldF9oaXZlX2lkID0gYW1kZ3B1
X2FtZGtmZF9nZXRfaGl2ZV9pZCwKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMKPiBpbmRleCA2ZjFhNDY3NmRkZGUuLmU3ODYxZjBlZjQx
NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2Zk
X2dmeF92OS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZF9nZnhfdjkuYwo+IEBAIC00MCw3ICs0MCw2IEBACj4gICAjaW5jbHVkZSAic29jMTVkLmgiCj4g
ICAjaW5jbHVkZSAibW1odWJfdjFfMC5oIgo+ICAgI2luY2x1ZGUgImdmeGh1Yl92MV8wLmgiCj4g
LSNpbmNsdWRlICJtbWh1Yl92OV80LmgiCj4gICAKPiAgIAo+ICAgZW51bSBocWRfZGVxdWV1ZV9y
ZXF1ZXN0X3R5cGUgewo+IEBAIC03NTgsOCArNzU3LDggQEAgdWludDMyX3Qga2dkX2dmeF92OV9h
ZGRyZXNzX3dhdGNoX2dldF9vZmZzZXQoc3RydWN0IGtnZF9kZXYgKmtnZCwKPiAgIAlyZXR1cm4g
MDsKPiAgIH0KPiAgIAo+IC12b2lkIGtnZF9nZnhfdjlfc2V0X3ZtX2NvbnRleHRfcGFnZV90YWJs
ZV9iYXNlKHN0cnVjdCBrZ2RfZGV2ICprZ2QsIHVpbnQzMl90IHZtaWQsCj4gLQkJdWludDY0X3Qg
cGFnZV90YWJsZV9iYXNlKQo+ICtzdGF0aWMgdm9pZCBrZ2RfZ2Z4X3Y5X3NldF92bV9jb250ZXh0
X3BhZ2VfdGFibGVfYmFzZShzdHJ1Y3Qga2dkX2RldiAqa2dkLAo+ICsJCQl1aW50MzJfdCB2bWlk
LCB1aW50NjRfdCBwYWdlX3RhYmxlX2Jhc2UpCj4gICB7Cj4gICAJc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYgPSBnZXRfYW1kZ3B1X2RldmljZShrZ2QpOwo+ICAgCj4gQEAgLTc2OSwxNCArNzY4
LDcgQEAgdm9pZCBrZ2RfZ2Z4X3Y5X3NldF92bV9jb250ZXh0X3BhZ2VfdGFibGVfYmFzZShzdHJ1
Y3Qga2dkX2RldiAqa2dkLCB1aW50MzJfdCB2bWkKPiAgIAkJcmV0dXJuOwo+ICAgCX0KPiAgIAo+
IC0JLyogVE9ETzogdGFrZSBhZHZhbnRhZ2Ugb2YgcGVyLXByb2Nlc3MgYWRkcmVzcyBzcGFjZSBz
aXplLiBGb3IKPiAtCSAqIG5vdywgYWxsIHByb2Nlc3NlcyBzaGFyZSB0aGUgc2FtZSBhZGRyZXNz
IHNwYWNlIHNpemUsIGxpa2UKPiAtCSAqIG9uIEdGWDggYW5kIG9sZGVyLgo+IC0JICovCj4gLQlp
ZiAoYWRldi0+YXNpY190eXBlID09IENISVBfQVJDVFVSVVMpIHsKPiAtCQltbWh1Yl92OV80X3Nl
dHVwX3ZtX3B0X3JlZ3MoYWRldiwgdm1pZCwgcGFnZV90YWJsZV9iYXNlKTsKPiAtCX0gZWxzZQo+
IC0JCW1taHViX3YxXzBfc2V0dXBfdm1fcHRfcmVncyhhZGV2LCB2bWlkLCBwYWdlX3RhYmxlX2Jh
c2UpOwo+ICsJbW1odWJfdjFfMF9zZXR1cF92bV9wdF9yZWdzKGFkZXYsIHZtaWQsIHBhZ2VfdGFi
bGVfYmFzZSk7Cj4gICAKPiAgIAlnZnhodWJfdjFfMF9zZXR1cF92bV9wdF9yZWdzKGFkZXYsIHZt
aWQsIHBhZ2VfdGFibGVfYmFzZSk7Cj4gICB9Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5oCj4gaW5kZXggZDllOWFkMjJiMmJkLi4wMmIx
NDI2ZDE3ZDEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FtZGtmZF9nZnhfdjkuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ2Z4X3Y5LmgKPiBAQCAtNTcsOCArNTcsNiBAQCB1aW50MzJfdCBrZ2RfZ2Z4X3Y5
X2FkZHJlc3Nfd2F0Y2hfZ2V0X29mZnNldChzdHJ1Y3Qga2dkX2RldiAqa2dkLAo+ICAgCj4gICBi
b29sIGtnZF9nZnhfdjlfZ2V0X2F0Y192bWlkX3Bhc2lkX21hcHBpbmdfaW5mbyhzdHJ1Y3Qga2dk
X2RldiAqa2dkLAo+ICAgCQkJCQl1aW50OF90IHZtaWQsIHVpbnQxNl90ICpwX3Bhc2lkKTsKPiAt
dm9pZCBrZ2RfZ2Z4X3Y5X3NldF92bV9jb250ZXh0X3BhZ2VfdGFibGVfYmFzZShzdHJ1Y3Qga2dk
X2RldiAqa2dkLCB1aW50MzJfdCB2bWlkLAo+IC0JCXVpbnQ2NF90IHBhZ2VfdGFibGVfYmFzZSk7
Cj4gICBpbnQga2dkX2dmeF92OV9pbnZhbGlkYXRlX3RsYnMoc3RydWN0IGtnZF9kZXYgKmtnZCwg
dWludDE2X3QgcGFzaWQpOwo+ICAgaW50IGtnZF9nZnhfdjlfaW52YWxpZGF0ZV90bGJzX3ZtaWQo
c3RydWN0IGtnZF9kZXYgKmtnZCwgdWludDE2X3Qgdm1pZCk7Cj4gICBpbnQga2dkX2dmeF92OV9n
ZXRfdGlsZV9jb25maWcoc3RydWN0IGtnZF9kZXYgKmtnZCwKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
