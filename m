Return-Path: <SRS0=wil9=7Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586A0C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 23:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54822078A
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 23:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aSqlNqCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54822078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91FFC6E151;
	Fri, 12 Jun 2020 23:43:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E164A6E151
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2020 23:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDCWvujUU0FsqMCIl1/S3LAxHLUnwYvr3SxIj0+K+MPOG6CEPVprqrNAczPvNaZb645EnhqD4i/BbTIaFiEQ5vOcuDpmiwaK3zH4rraYT+1h21418nh+uilFqCd08NskjNiaVYMFn0kD1jO81f/NeoE4fX4rY7ksIGTiysA28wZDXehy0ttqIwhSRhBucPjQ7GY+T5vfiBs4uQdyJj7LcX7tyhouqRi6y43Rxn9/pKzrWlhC0IU/ZQZSeutb9hHc+RnSuzN3cMz0MXqW5HsjKZQrvCM0ytoZUQLxJAeaFZ4cXwu8kphcwbWmDBKmMXb1ixBfpnqgqH96bjQdmd+oww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCa6OoYts94gsloJMN/DjUQeCRRmOG4G6ifJzLv4z+M=;
 b=DNino3Rneju+y1+3LLwfqDlB+yV+HJvfYeMr7Z04vh7T981Czf+78v4ET6n62W+6PuYXIWN6TvCegba5dbliR1OglE+ADS1I9CR2lVQGHqRDa2n6IJl5PHMvSPLzv674t+tlLXABkUdL9vIlmllKnyOVL0RZtw259FHcUgaRjlm8uUMtdIasYXTRK6tgyX6i7F7LGmqDhc03CH9zFciGv3W+ynMmWdhuF8bvgk9ohiGH2M9GsJbl2H1Qprfbgm3VYpkBxj6ZwlDZpPzmpDVIPtQsZILoVY5wBkiuA6rt5fsWdtBHzcxnWwx/pvk5pRS6sjJfbW/qzHlQRx4BJKJVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCa6OoYts94gsloJMN/DjUQeCRRmOG4G6ifJzLv4z+M=;
 b=aSqlNqCotyE/dCvbQAa9eOjReN/igjFO8U5QWSI7tl1G1w4bX+EXlpOqMmj2Yp/o6e4rl/WywTUve5Em3XzgeqhCcdzroIz91PbdDUBt/1HPGGdNHd2ylllWjaM5h0li7UhADHPLgYSqYkfshyPl6WUS+WPYG66kPbnd4GinL5Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Fri, 12 Jun
 2020 23:43:56 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3088.021; Fri, 12 Jun 2020
 23:43:56 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: Add eviction debug messages
To: philip yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200612033422.5682-1-Felix.Kuehling@amd.com>
 <98a97cf1-51d4-fade-95c3-6ed649a53ccf@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <81fba166-150a-496b-30d8-fdebc54bea5d@amd.com>
Date: Fri, 12 Jun 2020 19:43:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <98a97cf1-51d4-fade-95c3-6ed649a53ccf@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::48) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YQBPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Fri, 12 Jun 2020 23:43:56 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e205341e-84fe-4596-fcc0-08d80f2a78eb
X-MS-TrafficTypeDiagnostic: SA0PR12MB4384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB438496C773FBB5A15A9E341C92810@SA0PR12MB4384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0432A04947
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oamMdE4e7JL4rj4oIWERzo7Rmv+NJYnBVr/zzfxwt46ySE+VzIRgo+7HBWnjhLbTV/gLt8cdoMvwhX7V5Rfp5nVP+lAy7TcvMpoFtbGja3EHJUv+jSq3keVpEe1FX5v6YmaI+gGtVuVCWykbkeVsiDX7y3a0EP9ZiL7UmFaWpLyefqLa8TpJq0mEjn7i840je3YNp/PVDVp8mzGsFW/6jttpcmKOczpc33qhZR67TJ+HWJJY/FrCcWpAdkFz3clSIT1XtJy9AXoTLidr5mWpSr5Cvh+FshymOZ51QnFiTDbkj7P7/m0sBSS9N6yzMt3b1z1X1ONQyirlkMBoB5wo3/jO8Wl2jIuss95wqi8vr5S3+fmJ5uR5QFeXULpLdm5f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(2906002)(6666004)(8676002)(2616005)(8936002)(83380400001)(956004)(16526019)(186003)(31686004)(53546011)(26005)(52116002)(6486002)(16576012)(316002)(36756003)(31696002)(86362001)(66556008)(44832011)(66476007)(478600001)(4326008)(15650500001)(5660300002)(66946007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TSML+2l9ZvGWGVO3/HSzVsuPFjFF2lxugedBj81eBAnKTJaBbYHNaxjzGtSNjCN3gZTo9SarKVOSr3fvd6xGdjuEtmdb9HuCA+tK+nyPsu5CyDdv/VKpt86XHINFSzyTL6/HPzGTW/XStoW+0W+lKCHwFLBMrF+udJ4neMf7XT/BjyN4dtSzDoDisFg8Km04QXZaL8srNekvtml0fxff1PwDGuixFqj2meypP/aewquX7joiMClm6i58rO7OigNpw+DamaY6wTB7phVcROmSPrPBsxhnzmpGam959317pm3hXlgGkDY9yR71uGZWy7Pe9U77SJ9lplvjQw285siAZ/o+QKaIGyOVhf5LiJhV2bW3VDwEVtVKNVgaKY7StmwKebkKlloY/SR77QAWsrJQlvx81vdxGdhsTcxyRHhI+IeLlOb1Q1gi2dUL/pDdX+pNo/VuuslEeEZBWRlBGve6brNlbgH+4PE4ZNxxlues0ZRgInDx4mjwnuMQPhTaTcL8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e205341e-84fe-4596-fcc0-08d80f2a78eb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2020 23:43:56.7388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4lxD3WUB73VAGSGfZ7+zn+nKE9PH9PLzLVvtZ0ByRbNEYA/1pwoghbkWvOD+2hcLdmNCJtGX7eIPurT8kqOgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
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
Cc: gang.ba@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMC0wNi0xMiB1bSA2OjAzIHAubS4gc2NocmllYiBwaGlsaXAgeWFuZzoKPiBJdCdzIGdv
b2QgaWRlYSwgYmV0dGVyIHRvIGFkZCBzYW1lIHByaW50IGluIHN5c3RlbSBtZW1vcnkgZXZpY3Rp
b24KPiBwYXRoIGFtZGdwdV9hbWRrZmRfZXZpY3RfdXNlcnB0ci4KClRoYXQncyBjb3ZlcmVkIGJ5
IHRoZSBtZXNzYWdlIGluIGtnZDJrZmRfcXVpZXNjZV9tbS4KCgo+Cj4gVXNlIFdBUk5fT05DRSB0
byBhdm9pZCBkdXBsaWNhdGUgbWVzc2FnZXMuCgpJIHdhbnQgZHVwbGljYXRlIG1lc3NhZ2VzLiBJ
ZiBtYW55IGRpZmZlcmVudCBraW5kcyBvZiBldmljdGlvbnMgYXJlCmhhcHBlbmluZyBJIHdhbnQg
dG8gc2VlIHRoZW0gYWxsLiBUaGUgbW9kdWxlIHBhcmFtZXRlciBpcyB0aGVyZSBzbyBJIGNhbgp0
dXJuIGl0IG9uL29mZiBmb3Igc2hvcnQgYnVyc3RzIHdoaWxlIGludGVyZXN0aW5nIHRoaW5ncyBh
cmUgaGFwcGVuaW5nLgpJdCdzIG9mZiBieSBkZWZhdWx0LgoKSSB3YXMgY29uc2lkZXJpbmcgV0FS
Tl9SQVRFTElNSVQsIGJ1dCB0aGF0IG1heSBza2lwIGludGVyZXN0aW5nCmV2aWN0aW9ucyBJIGFj
dHVhbGx5IHdhbnQgdG8gc2VlLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+Cj4gUmVnYXJkcywKPgo+
IFBoaWxpcAo+Cj4KPiBPbiAyMDIwLTA2LTExIDExOjM0IHAubS4sIEZlbGl4IEt1ZWhsaW5nIHdy
b3RlOgo+PiBVc2UgV0FSTiB0byBwcmludCBtZXNzYWdlcyB3aXRoIGJhY2t0cmFjZSB3aGVuIGV2
aWN0aW9ucyBhcmUgdHJpZ2dlcmVkLgo+PiBUaGlzIGNhbiBoZWxwIGRldGVybWluZSB0aGUgcm9v
dCBjYXVzZSBvZiBldmljdGlvbnMgYW5kIGhlbHAgc3BvdCBkcml2ZXIKPj4gYnVncyB0cmlnZ2Vy
aW5nIGV2aWN0aW9ucyB1bmludGVudGlvbmFsbHksIG9yIGhlbHAgd2l0aCBwZXJmb3JtYW5jZQo+
PiB0dW5pbmcKPj4gYnkgYXZvaWRpbmcgY29uZGl0aW9ucyB0aGF0IGNhdXNlIGV2aWN0aW9ucyBp
biBhIHNwZWNpZmljIHdvcmtsb2FkLgo+Pgo+PiBUaGUgbWVzc2FnZXMgYXJlIGNvbnRyb2xsZWQg
YnkgYSBuZXcgbW9kdWxlIHBhcmFtZXRlciB0aGF0IGNhbiBiZQo+PiBjaGFuZ2VkCj4+IGF0IHJ1
bnRpbWU6Cj4+Cj4+IMKgwqAgZWNobyBZID4gL3N5cy9tb2R1bGUvYW1kZ3B1L3BhcmFtZXRlcnMv
ZGVidWdfZXZpY3Rpb25zCj4+IMKgwqAgZWNobyBOID4gL3N5cy9tb2R1bGUvYW1kZ3B1L3BhcmFt
ZXRlcnMvZGVidWdfZXZpY3Rpb25zCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5n
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1LmjCoMKgwqDCoMKgIHwgMiArKwo+PiDCoCBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZHJ2LmPCoCB8IDggKysrKysrKysKPj4gwqAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYyB8IDIgKysKPj4gwqAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2RldmljZS5jwqAgfCAzICsrKwo+PiDCoCBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfcHJpdi5owqDCoMKgIHwgNSArKysrKwo+PiDCoCA1IGZpbGVzIGNoYW5n
ZWQsIDIwIGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdS5oCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
LmgKPj4gaW5kZXggMTBhZTkyZTgzNWY2Li42YzdkZDBhNzA3YzkgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4+IEBAIC0xODYsOCArMTg2LDEwIEBAIGV4dGVybiBpbnQg
YW1kZ3B1X25vcmV0cnk7Cj4+IMKgIGV4dGVybiBpbnQgYW1kZ3B1X2ZvcmNlX2FzaWNfdHlwZTsK
Pj4gwqAgI2lmZGVmIENPTkZJR19IU0FfQU1ECj4+IMKgIGV4dGVybiBpbnQgc2NoZWRfcG9saWN5
Owo+PiArZXh0ZXJuIGJvb2wgZGVidWdfZXZpY3Rpb25zOwo+PiDCoCAjZWxzZQo+PiDCoCBzdGF0
aWMgY29uc3QgaW50IHNjaGVkX3BvbGljeSA9IEtGRF9TQ0hFRF9QT0xJQ1lfSFdTOwo+PiArc3Rh
dGljIGNvbnN0IGJvb2wgZGVidWdfZXZpY3Rpb25zOyAvKiA9IGZhbHNlICovCj4+IMKgICNlbmRp
Zgo+PiDCoCDCoCBleHRlcm4gaW50IGFtZGdwdV90bXo7Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZHJ2LmMKPj4gaW5kZXggZDRkN2NjYTFjYzcyLi5mZGYzNTBkNWU3Yjcg
MTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPj4gQEAgLTcw
NSw2ICs3MDUsMTQgQEAgTU9EVUxFX1BBUk1fREVTQyhod3NfZ3dzX3N1cHBvcnQsICJBc3N1bWUg
TUVDMgo+PiBGVyBzdXBwb3J0cyBHV1MgYmFycmllcnMgKGZhbHNlID0KPj4gwqAgaW50IHF1ZXVl
X3ByZWVtcHRpb25fdGltZW91dF9tcyA9IDkwMDA7Cj4+IMKgIG1vZHVsZV9wYXJhbShxdWV1ZV9w
cmVlbXB0aW9uX3RpbWVvdXRfbXMsIGludCwgMDY0NCk7Cj4+IMKgIE1PRFVMRV9QQVJNX0RFU0Mo
cXVldWVfcHJlZW1wdGlvbl90aW1lb3V0X21zLCAicXVldWUgcHJlZW1wdGlvbgo+PiB0aW1lb3V0
IGluIG1zICgxID0gTWluaW11bSwgOTAwMCA9IGRlZmF1bHQpIik7Cj4+ICsKPj4gKy8qKgo+PiAr
ICogRE9DOiBkZWJ1Z19ldmljdGlvbnMoYm9vbCkKPj4gKyAqIEVuYWJsZSBleHRyYSBkZWJ1ZyBt
ZXNzYWdlcyB0byBoZWxwIGRldGVybWluZSB0aGUgY2F1c2Ugb2YgZXZpY3Rpb25zCj4+ICsgKi8K
Pj4gK2Jvb2wgZGVidWdfZXZpY3Rpb25zOwo+PiArbW9kdWxlX3BhcmFtKGRlYnVnX2V2aWN0aW9u
cywgYm9vbCwgMDY0NCk7Cj4+ICtNT0RVTEVfUEFSTV9ERVNDKGRlYnVnX2V2aWN0aW9ucywgImVu
YWJsZSBldmljdGlvbiBkZWJ1ZyBtZXNzYWdlcwo+PiAoZmFsc2UgPSBkZWZhdWx0KSIpOwo+PiDC
oCAjZW5kaWYKPj4gwqAgwqAgLyoqCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfc3luYy5jCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3N5bmMuYwo+PiBpbmRleCBiODdjYTE3MTk4NmEuLjA3MmYwZTExODVhOCAxMDA2NDQKPj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYwo+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jCj4+IEBAIC0yNzUsNiArMjc1
LDggQEAgaW50IGFtZGdwdV9zeW5jX3Jlc3Yoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+
IHN0cnVjdCBhbWRncHVfc3luYyAqc3luYywKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y29udGludWU7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+IMKgICvCoMKgwqDCoMKgwqDCoCBX
QVJOKGRlYnVnX2V2aWN0aW9ucyAmJiBmZW5jZV9vd25lciA9PQo+PiBBTURHUFVfRkVOQ0VfT1dO
RVJfS0ZELAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJBZGRpbmcgZXZpY3Rpb24gZmVu
Y2UgdG8gc3luYyBvYmoiKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHIgPSBhbWRncHVfc3luY19m
ZW5jZShzeW5jLCBmLCBmYWxzZSk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocikKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfZGV2aWNlLmMKPj4gaW5kZXggMjIzNDhjZWJhZjM2Li44MDM5M2UwNTgzYmIgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYwo+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMKPj4gQEAgLTk0Miw2
ICs5NDIsNyBAQCBpbnQga2dkMmtmZF9xdWllc2NlX21tKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQo+
PiDCoMKgwqDCoMKgIGlmICghcCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRVNSQ0g7
Cj4+IMKgICvCoMKgwqAgV0FSTihkZWJ1Z19ldmljdGlvbnMsICJFdmljdGluZyBwaWQgJWQiLCBw
LT5sZWFkX3RocmVhZC0+cGlkKTsKPj4gwqDCoMKgwqDCoCByID0ga2ZkX3Byb2Nlc3NfZXZpY3Rf
cXVldWVzKHApOwo+PiDCoCDCoMKgwqDCoMKgIGtmZF91bnJlZl9wcm9jZXNzKHApOwo+PiBAQCAt
MTAwOSw2ICsxMDEwLDggQEAgaW50Cj4+IGtnZDJrZmRfc2NoZWR1bGVfZXZpY3RfYW5kX3Jlc3Rv
cmVfcHJvY2VzcyhzdHJ1Y3QgbW1fc3RydWN0ICptbSwKPj4gwqDCoMKgwqDCoCAvKiBEdXJpbmcg
cHJvY2VzcyBpbml0aWFsaXphdGlvbiBldmljdGlvbl93b3JrLmR3b3JrIGlzCj4+IGluaXRpYWxp
emVkCj4+IMKgwqDCoMKgwqDCoCAqIHRvIGtmZF9ldmljdF9ib193b3JrZXIKPj4gwqDCoMKgwqDC
oMKgICovCj4+ICvCoMKgwqAgV0FSTihkZWJ1Z19ldmljdGlvbnMsICJTY2hlZHVsaW5nIGV2aWN0
aW9uIG9mIHBpZCAlZCBpbiAlbGQKPj4gamlmZmllcyIsCj4+ICvCoMKgwqDCoMKgwqDCoMKgIHAt
PmxlYWRfdGhyZWFkLT5waWQsIGRlbGF5X2ppZmZpZXMpOwo+PiDCoMKgwqDCoMKgIHNjaGVkdWxl
X2RlbGF5ZWRfd29yaygmcC0+ZXZpY3Rpb25fd29yaywgZGVsYXlfamlmZmllcyk7Cj4+IMKgIG91
dDoKPj4gwqDCoMKgwqDCoCBrZmRfdW5yZWZfcHJvY2VzcyhwKTsKPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgKPj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfcHJpdi5oCj4+IGluZGV4IDE3M2Q1OGIyZDgxZi4uNTFiYTIwMjA3MzJl
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oCj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgKPj4gQEAgLTE3Nyw2
ICsxNzcsMTEgQEAgZXh0ZXJuIGJvb2wgaHdzX2d3c19zdXBwb3J0Owo+PiDCoMKgICovCj4+IMKg
IGV4dGVybiBpbnQgcXVldWVfcHJlZW1wdGlvbl90aW1lb3V0X21zOwo+PiDCoCArLyoKPj4gKyAq
IEVuYWJsZSBldmljdGlvbiBkZWJ1ZyBtZXNzYWdlcwo+PiArICovCj4+ICtleHRlcm4gYm9vbCBk
ZWJ1Z19ldmljdGlvbnM7Cj4+ICsKPj4gwqAgZW51bSBjYWNoZV9wb2xpY3kgewo+PiDCoMKgwqDC
oMKgIGNhY2hlX3BvbGljeV9jb2hlcmVudCwKPj4gwqDCoMKgwqDCoCBjYWNoZV9wb2xpY3lfbm9u
Y29oZXJlbnQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
