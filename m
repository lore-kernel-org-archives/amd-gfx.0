Return-Path: <SRS0=OLW4=ZZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1568BC432C0
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 17:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F222073B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 17:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F222073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6FB46E869;
	Tue,  3 Dec 2019 17:33:47 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790041.outbound.protection.outlook.com [40.107.79.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE476E869
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2019 17:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUoxIX+OLMTJg1dGD3dL6EBbUfjPTMijNXR+woXetFPXbYjXsDcQAoJ4z9LqoVH7tqpBWlbvl6VYDjpGP1Bdlgu00hwfXiMUjQTT4vGfab/VehguDPikmRsR4MTyZsp3U7G85JzK+W2wzTz2vldLml1CwOlyD76XPsIYjFTzPEx5yB04RXjVWf/z47IjZD8KK8T9P73sL0tjEhgZ9F7n3KWsQL7eVAmgG8rR0OsN0+t4FrNwqT9o1jGkvz32g287HQPV3tow7NmegwZYkQt2N03Acl+IJgamRzAcshjLIsgkZNdb7MMh31x7nmRLNr/tU074MUZxE3tO0sGzj9ai4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/yLQCbqMySO1SDT62g90UztM4bzYb50ZIJdzoANYFI=;
 b=i2Tlnp7lVvndZE3SCN8BHcspJ4oUjByLKknGA36P4GkQIeu77/Jq1Q7iNM4SoZIC04fWWr/+qxrQphnQEltA4hSlMC3TGKf2wUMzn+C4hLU6U71EX0cnJbIjoty1jBV7WOTATXswJKZonbiCuAgoV1qWzEBumUZYPAgsf6hHfvYTNoL+gZ3lu6pLLowHZEh4CphcdGFKPT0UtKh0LbAP+9/uGarNMwMKqvArS2VgN5oncwVYNQmkrafLXqgoMXWkvZ8Xu08htSA+lUCOiWLaMNBbN/VXD/EbtEqoqs4QlQBa5/0bvhqeORfOZVCaoJdYfKkfFfg+TFc8/myczVBQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2533.namprd12.prod.outlook.com (52.132.139.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 17:33:45 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 17:33:44 +0000
Subject: Re: [RFC PATCH] drm/amdgpu: allocate entities on demand
To: Nirmoy <nirmodas@amd.com>, alexander.deucher@amd.com, kenny.ho@amd.com
References: <20191125231719.108949-1-nirmoy.das@amd.com>
 <2e514ab3-1582-6508-d81a-cbc2d12f42d7@amd.com>
 <74fd0faf-fd99-e33e-8d7a-95f9bb8be26a@gmail.com>
 <4954a31a-dfbb-1432-9ffe-42ad9f89073c@amd.com>
 <b141b429-42ae-9640-d9eb-7ab243240ea2@amd.com>
 <8e74a3fb-6aff-38cb-5bc0-a60cdd05e5ff@amd.com>
 <91f6a4cb-7034-cdc6-741a-4050e26d7a9d@gmail.com>
 <1fb9df42-7a35-aac3-8a88-6109106e7338@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <660b33dd-9e20-14ef-5320-743ed79c2250@amd.com>
Date: Tue, 3 Dec 2019 18:33:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <1fb9df42-7a35-aac3-8a88-6109106e7338@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0055.eurprd02.prod.outlook.com
 (2603:10a6:208:d2::32) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 75c8bf3b-9706-4958-f159-08d77816f23a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2533:|DM5PR12MB2533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25334FC086CB9C7F88F51E1983420@DM5PR12MB2533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02408926C4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(36756003)(2616005)(11346002)(446003)(46003)(14444005)(2906002)(8676002)(25786009)(81166006)(81156014)(6666004)(58126008)(186003)(7736002)(52116002)(6506007)(76176011)(6436002)(50466002)(23676004)(6486002)(4326008)(53546011)(6512007)(2486003)(229853002)(6636002)(86362001)(31686004)(31696002)(65956001)(6246003)(386003)(8936002)(6116002)(305945005)(66574012)(66476007)(478600001)(316002)(2870700001)(66946007)(99286004)(66556008)(5660300002)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2533;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7K7Ljq0EvaBIxi29jzi8DlAg0tCiwa8YNzsHi+aIemvs2+HYwYbmyL/jMSbLRY+zhBMsVx2mo1rlTYuFhlYNhCE5pdvY/Sx5FGKZfo7rfA4MYeNrJH6iLmurieDsF/NXSAppqwdK8ILwERruywjjtZM7Acn2ovJX+22Zv5Xr4eVprhUHqt6f74Dn/+shTzvEu8CNbnmFb1Ay3FRWhJK6AldA2ARS+nb7XTRL4HauecfkaXgX9I3+DMZByEMqVUa6ULlBLntSkKItnjak+htpPuHtg/cw3eK+dHQ61RsNwj/4FI0scD0VIKkEXNlFXWuYZIJ5tacb7/GmnLaPVqHaRmlOKo6mqGvEJlENIi4OoioY/BawgHCKPe9ZUsPwhtSJmH0hFWnFfPzrli8Q1cqNsqJB2JTk9zhYFPwN9jhcYnaZKULyfIuF4l0B1cNPWp5G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c8bf3b-9706-4958-f159-08d77816f23a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 17:33:44.6776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bABKJHLyPU0Oa3wH2e6+6tM3WP8YN/jFPr6evuOzj6DxkIFoBfMbpNViE0nEpqT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2533
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/yLQCbqMySO1SDT62g90UztM4bzYb50ZIJdzoANYFI=;
 b=rwBq2DUaoeXJxfjqo1IxdIl3C45u3Bps4aUFkXzCBPjptd5CWpj65u0ZDz7q0E0KWTTTjCdYrQPX5q7zlrd+Qhm9fD+KbYpVP7Jo7avvi1uPOB6N3N2wzFhKI2nuFUY0EaMFF6rCDiaBOLQxLrJviioSelp45N35eAwVM9rP//w=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDMuMTIuMTkgdW0gMTY6MDIgc2NocmllYiBOaXJtb3k6Cj4gSGkgQ2hyaXN0aWFuLAo+Cj4g
T24gMTIvMi8xOSAzOjU5IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAwMi4xMi4x
OSB1bSAxNTo0MyBzY2hyaWViIE5pcm1veToKPj4+Cj4+PiBEbyB5b3UgbWVhbiBzb21ldGhpbmcg
bGlrZQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmggYi9p
bmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmgKPj4+IGluZGV4IDY4NDY5MmE4ZWQ3Ni4uYWM2N2Y4
ZjA5OGZhIDEwMDY0NAo+Pj4gLS0tIGEvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oCj4+PiAr
KysgYi9pbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmgKPj4+IEBAIC04MSw3ICs4MSw3IEBAIGVu
dW0gZHJtX3NjaGVkX3ByaW9yaXR5IHsKPj4+IMKgc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgewo+
Pj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGxpc3RfaGVhZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBsaXN0Owo+Pj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRybV9zY2hlZF9yccKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqcnE7Cj4+PiAtwqDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fc2No
ZWRfcnHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKipycV9saXN0Owo+Pj4gK8KgwqDCoMKgwqAg
c3RydWN0IGRybV9ncHVfc2NoZWR1bGVywqDCoMKgwqDCoMKgwqAgKipzY2hlZDsKPj4+IMKgwqDC
oMKgwqDCoMKgIHVuc2lnbmVkIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIG51bV9ycV9saXN0Owo+Pj4gwqDCoMKgwqDCoMKgwqAgc3BpbmxvY2tfdMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBycV9sb2NrOwo+Pgo+PiBZZXMsIGV4YWN0
bHkuIFByb2JsZW0gaXMgdGhhdCBJJ20gbm90IDEwMCUgc3VyZSBpZiB0aGF0IHJlYWxseSB3b3Jr
cyAKPj4gd2l0aCBhbGwgdXNlcnMgb2YgdGhlIHJxX2xpc3QuCj4KPiBjdXJyZW50bHkgcnFfbGlz
dCB1c2VycyBkb2VzIHR3byBtYWluIHRhc2tzLgo+Cj4gMcKgIGNoYW5nZSBycSBwcmlvcml0eSBm
b3IgYSBjb250ZXh0IG9uIHVzZXIgcmVxdWVzdHMKPgo+IDLCoCBoZWxwcyBkcm0gc2NoZWR1bGVy
IHRvIGZpbmQgcnHCoCB3aXRoIGxlYXN0IGxvYWQuCj4KPiBDYW4geW91IHBsZWFzZSBjaGVjayB0
aGUgYmVsbG93IGRpZmYgaXQgZG9lc24ndCByZWFsbHkgd29yayBiZWNhdXNlIEkgCj4gZ2V0IHNv
bWUga2VybmVsIHBhbmljLiBCdXQgZG8geW91IHRoaW5rCj4KPiBpdCBpcyBtYXRjaGluZyB5b3Vy
IGlkZWEgPwoKWWVzLCB0aGF0IGxvb2tzIGV4YWN0bHkgbGlrZSB3aGF0IEkgaGFkIGluIG1pbmQu
CgpDaHJpc3RpYW4uCgo+Cj4gdGVzdEBpbnN0YWxsOn4vbGludXg+IGdpdCBkaWZmIAo+IGRyaXZl
cnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMgfHRlZQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jIAo+IGIvZHJpdmVycy9ncHUv
ZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+IGluZGV4IDFhNTE1MzE5N2ZlOS4uMGJiZDhk
ZGQ2YzgzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50
aXR5LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4g
QEAgLTM3LDkgKzM3LDkgQEAKPiDCoCAqIHN1Ym1pdCB0byBIVyByaW5nLgo+IMKgICoKPiDCoCAq
IEBlbnRpdHk6IHNjaGVkdWxlciBlbnRpdHkgdG8gaW5pdAo+IC0gKiBAcnFfbGlzdDogdGhlIGxp
c3Qgb2YgcnVuIHF1ZXVlIG9uIHdoaWNoIGpvYnMgZnJvbSB0aGlzCj4gKyAqIEBzY2hlZF9saXN0
OiB0aGUgbGlzdCBvZiBkcm0gc2NoZWRzIG9uIHdoaWNoIGpvYnMgZnJvbSB0aGlzCj4gwqAgKsKg
wqDCoMKgwqDCoMKgwqDCoMKgIGVudGl0eSBjYW4gYmUgc3VibWl0dGVkCj4gLSAqIEBudW1fcnFf
bGlzdDogbnVtYmVyIG9mIHJ1biBxdWV1ZSBpbiBycV9saXN0Cj4gKyAqIEBudW1fc2NoZWRfbGlz
dDogbnVtYmVyIG9mIGRybSBzY2hlZCBpbiBzY2hlZF9saXN0Cj4gwqAgKiBAZ3VpbHR5OiBhdG9t
aWNfdCBzZXQgdG8gMSB3aGVuIGEgam9iIG9uIHRoaXMgcXVldWUKPiDCoCAqwqDCoMKgwqDCoMKg
wqDCoMKgIGlzIGZvdW5kIHRvIGJlIGd1aWx0eSBjYXVzaW5nIGEgdGltZW91dAo+IMKgICoKPiBA
QCAtNDksMzAgKzQ5LDI0IEBACj4gwqAgKiBSZXR1cm5zIDAgb24gc3VjY2VzcyBvciBhIG5lZ2F0
aXZlIGVycm9yIGNvZGUgb24gZmFpbHVyZS4KPiDCoCAqLwo+IMKgaW50IGRybV9zY2hlZF9lbnRp
dHlfaW5pdChzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5LAo+IC3CoMKgIMKgwqDCoCDC
oMKgwqAgwqDCoCBzdHJ1Y3QgZHJtX3NjaGVkX3JxICoqcnFfbGlzdCwKPiAtwqDCoCDCoMKgwqAg
wqDCoMKgIMKgwqAgdW5zaWduZWQgaW50IG51bV9ycV9saXN0LAo+IC3CoMKgIMKgwqDCoCDCoMKg
wqAgwqDCoCBhdG9taWNfdCAqZ3VpbHR5KQo+ICvCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoCBzdHJ1
Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKipzY2hlZF9saXN0LAo+ICvCoMKgIMKgwqDCoCDCoMKgwqAg
wqDCoCB1bnNpZ25lZCBpbnQgbnVtX3NjaGVkX2xpc3QsCj4gK8KgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgIGF0b21pY190ICpndWlsdHksIGVudW0gZHJtX3NjaGVkX3ByaW9yaXR5IHByaW9yaXR5KQo+
IMKgewo+IC3CoMKgIMKgaW50IGk7Cj4KPiAtwqDCoCDCoGlmICghKGVudGl0eSAmJiBycV9saXN0
ICYmIChudW1fcnFfbGlzdCA9PSAwIHx8IHJxX2xpc3RbMF0pKSkKPiArwqDCoCDCoGlmICghKGVu
dGl0eSAmJiBzY2hlZF9saXN0ICYmIChudW1fc2NoZWRfbGlzdCA9PSAwIHx8IAo+IHNjaGVkX2xp
c3RbMF0pKSkKPiDCoMKgwqAgwqDCoMKgIMKgcmV0dXJuIC1FSU5WQUw7Cj4KPiDCoMKgwqAgwqBt
ZW1zZXQoZW50aXR5LCAwLCBzaXplb2Yoc3RydWN0IGRybV9zY2hlZF9lbnRpdHkpKTsKPiDCoMKg
wqAgwqBJTklUX0xJU1RfSEVBRCgmZW50aXR5LT5saXN0KTsKPiDCoMKgwqAgwqBlbnRpdHktPnJx
ID0gTlVMTDsKPiDCoMKgwqAgwqBlbnRpdHktPmd1aWx0eSA9IGd1aWx0eTsKPiAtwqDCoCDCoGVu
dGl0eS0+bnVtX3JxX2xpc3QgPSBudW1fcnFfbGlzdDsKPiAtwqDCoCDCoGVudGl0eS0+cnFfbGlz
dCA9IGtjYWxsb2MobnVtX3JxX2xpc3QsIHNpemVvZihzdHJ1Y3QgZHJtX3NjaGVkX3JxIAo+ICop
LAo+IC3CoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgR0ZQX0tFUk5FTCk7Cj4gLcKgwqAgwqBp
ZiAoIWVudGl0eS0+cnFfbGlzdCkKPiAtwqDCoCDCoMKgwqAgwqByZXR1cm4gLUVOT01FTTsKPiAt
Cj4gLcKgwqAgwqBmb3IgKGkgPSAwOyBpIDwgbnVtX3JxX2xpc3Q7ICsraSkKPiAtwqDCoCDCoMKg
wqAgwqBlbnRpdHktPnJxX2xpc3RbaV0gPSBycV9saXN0W2ldOwo+ICvCoMKgIMKgZW50aXR5LT5u
dW1fc2NoZWRfbGlzdCA9IG51bV9zY2hlZF9saXN0Owo+ICvCoMKgIMKgZW50aXR5LT5zY2hlZF9s
aXN0ID3CoCBzY2hlZF9saXN0Cj4gK8KgwqAgwqBlbnRpdHktPnByaW9yaXR5ID0gcHJpb3JpdHk7
Cj4KPiAtwqDCoCDCoGlmIChudW1fcnFfbGlzdCkKPiAtwqDCoCDCoMKgwqAgwqBlbnRpdHktPnJx
ID0gcnFfbGlzdFswXTsKPiArwqDCoCDCoGlmIChudW1fc2NoZWRfbGlzdCkKPiArwqDCoCDCoMKg
wqAgwqBlbnRpdHktPnJxID0gJmVudGl0eS0+c2NoZWRfbGlzdFswXS0+c2NoZWRfcnFbZW50aXR5
LT5wcmlvcml0eV07Cj4KPiDCoMKgwqAgwqBlbnRpdHktPmxhc3Rfc2NoZWR1bGVkID0gTlVMTDsK
Pgo+IEBAIC0xMzYsMTAgKzEzMCwxMCBAQCBkcm1fc2NoZWRfZW50aXR5X2dldF9mcmVlX3NjaGVk
KHN0cnVjdCAKPiBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHkpCj4gwqDCoMKgIMKgdW5zaWduZWQg
aW50IG1pbl9qb2JzID0gVUlOVF9NQVgsIG51bV9qb2JzOwo+IMKgwqDCoCDCoGludCBpOwo+Cj4g
LcKgwqAgwqBmb3IgKGkgPSAwOyBpIDwgZW50aXR5LT5udW1fcnFfbGlzdDsgKytpKSB7Cj4gLcKg
wqAgwqDCoMKgIMKgc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCA9IGVudGl0eS0+cnFf
bGlzdFtpXS0+c2NoZWQ7Cj4gK8KgwqAgwqBmb3IgKGkgPSAwOyBpIDwgZW50aXR5LT5udW1fc2No
ZWRfbGlzdDsgKytpKSB7Cj4gK8KgwqAgwqDCoMKgIMKgc3RydWN0IGRybV9ncHVfc2NoZWR1bGVy
ICpzY2hlZCA9IGVudGl0eS0+c2NoZWRfbGlzdFtpXTsKPgo+IC3CoMKgIMKgwqDCoCDCoGlmICgh
ZW50aXR5LT5ycV9saXN0W2ldLT5zY2hlZC0+cmVhZHkpIHsKPiArwqDCoCDCoMKgwqAgwqBpZiAo
IWVudGl0eS0+c2NoZWRfbGlzdFtpXS0+cmVhZHkpIHsKPiDCoMKgwqAgwqDCoMKgIMKgwqDCoCDC
oERSTV9XQVJOKCJzY2hlZCVzIGlzIG5vdCByZWFkeSwgc2tpcHBpbmciLCBzY2hlZC0+bmFtZSk7
Cj4gwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqBjb250aW51ZTsKPiDCoMKgwqAgwqDCoMKgIMKgfQo+
IEBAIC0xNDcsNyArMTQxLDcgQEAgZHJtX3NjaGVkX2VudGl0eV9nZXRfZnJlZV9zY2hlZChzdHJ1
Y3QgCj4gZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5KQo+IMKgwqDCoCDCoMKgwqAgwqBudW1fam9i
cyA9IGF0b21pY19yZWFkKCZzY2hlZC0+bnVtX2pvYnMpOwo+IMKgwqDCoCDCoMKgwqAgwqBpZiAo
bnVtX2pvYnMgPCBtaW5fam9icykgewo+IMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgbWluX2pvYnMg
PSBudW1fam9iczsKPiAtwqDCoCDCoMKgwqAgwqDCoMKgIMKgcnEgPSBlbnRpdHktPnJxX2xpc3Rb
aV07Cj4gK8KgwqAgwqDCoMKgIMKgwqDCoCDCoHJxID0gJmVudGl0eS0+c2NoZWRfbGlzdFtpXS0+
c2NoZWRfcnFbZW50aXR5LT5wcmlvcml0eV07Cj4gwqDCoMKgIMKgwqDCoCDCoH0KPiDCoMKgwqAg
wqB9Cj4KPiBAQCAtMzA0LDcgKzI5OCw2IEBAIHZvaWQgZHJtX3NjaGVkX2VudGl0eV9maW5pKHN0
cnVjdCBkcm1fc2NoZWRfZW50aXR5IAo+ICplbnRpdHkpCj4KPiDCoMKgwqAgwqBkbWFfZmVuY2Vf
cHV0KGVudGl0eS0+bGFzdF9zY2hlZHVsZWQpOwo+IMKgwqDCoCDCoGVudGl0eS0+bGFzdF9zY2hl
ZHVsZWQgPSBOVUxMOwo+IC3CoMKgIMKga2ZyZWUoZW50aXR5LT5ycV9saXN0KTsKPiDCoH0KPiDC
oEVYUE9SVF9TWU1CT0woZHJtX3NjaGVkX2VudGl0eV9maW5pKTsKPgo+IEBAIC0zNzIsOCArMzY1
LDkgQEAgdm9pZCBkcm1fc2NoZWRfZW50aXR5X3NldF9wcmlvcml0eShzdHJ1Y3QgCj4gZHJtX3Nj
aGVkX2VudGl0eSAqZW50aXR5LAo+IMKgwqDCoCDCoHVuc2lnbmVkIGludCBpOwo+Cj4gwqDCoMKg
IMKgc3Bpbl9sb2NrKCZlbnRpdHktPnJxX2xvY2spOwo+IC0KPiAtwqDCoCDCoGZvciAoaSA9IDA7
IGkgPCBlbnRpdHktPm51bV9ycV9saXN0OyArK2kpCj4gKy8vVE9ETwo+ICsvKgo+ICvCoMKgIMKg
Zm9yIChpID0gMDsgaSA8IGVudGl0eS0+bnVtX3NjaGVkX2xpc3Q7ICsraSkKPiDCoGRybV9zY2hl
ZF9lbnRpdHlfc2V0X3JxX3ByaW9yaXR5KCZlbnRpdHktPnJxX2xpc3RbaV0sIHByaW9yaXR5KTsK
Pgo+IMKgwqDCoCDCoGlmIChlbnRpdHktPnJxKSB7Cj4gQEAgLTM4MSw3ICszNzUsNyBAQCB2b2lk
IGRybV9zY2hlZF9lbnRpdHlfc2V0X3ByaW9yaXR5KHN0cnVjdCAKPiBkcm1fc2NoZWRfZW50aXR5
ICplbnRpdHksCj4gwqDCoMKgIMKgwqDCoCDCoGRybV9zY2hlZF9lbnRpdHlfc2V0X3JxX3ByaW9y
aXR5KCZlbnRpdHktPnJxLCBwcmlvcml0eSk7Cj4gwqDCoMKgIMKgwqDCoCDCoGRybV9zY2hlZF9y
cV9hZGRfZW50aXR5KGVudGl0eS0+cnEsIGVudGl0eSk7Cj4gwqDCoMKgIMKgfQo+IC0KPiArKi8K
PiDCoMKgwqAgwqBzcGluX3VubG9jaygmZW50aXR5LT5ycV9sb2NrKTsKPiDCoH0KPiDCoEVYUE9S
VF9TWU1CT0woZHJtX3NjaGVkX2VudGl0eV9zZXRfcHJpb3JpdHkpOwo+IEBAIC00ODYsNyArNDgw
LDcgQEAgdm9pZCBkcm1fc2NoZWRfZW50aXR5X3NlbGVjdF9ycShzdHJ1Y3QgCj4gZHJtX3NjaGVk
X2VudGl0eSAqZW50aXR5KQo+IMKgwqDCoCDCoHN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlOwo+IMKg
wqDCoCDCoHN0cnVjdCBkcm1fc2NoZWRfcnEgKnJxOwo+Cj4gLcKgwqAgwqBpZiAoc3BzY19xdWV1
ZV9jb3VudCgmZW50aXR5LT5qb2JfcXVldWUpIHx8IGVudGl0eS0+bnVtX3JxX2xpc3QgCj4gPD0g
MSkKPiArwqDCoCDCoGlmIChzcHNjX3F1ZXVlX2NvdW50KCZlbnRpdHktPmpvYl9xdWV1ZSkgfHwg
Cj4gZW50aXR5LT5udW1fc2NoZWRfbGlzdCA8PSAxKQo+IMKgwqDCoCDCoMKgwqAgwqByZXR1cm47
Cj4KPiDCoMKgwqAgwqBmZW5jZSA9IFJFQURfT05DRShlbnRpdHktPmxhc3Rfc2NoZWR1bGVkKTsK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
