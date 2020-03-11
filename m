Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69390C2BB1D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 17:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F323C20737
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 17:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="faZWpWbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F323C20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F362F6E4D4;
	Wed, 11 Mar 2020 17:54:28 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760055.outbound.protection.outlook.com [40.107.76.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CCC26E4D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 17:54:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlavcNTeZ9ecGD2WQdbRk2cCIyCaEqQmnSRQ3hVsHP/mLAN2L41wwMh3HRpTUZUf3m5X0w/Yb0H+Qby1Q7MBvMAmeaDUKnCIF3WHGRJ6QEwhTPNJzMDMxVrjJwa9GvYl3JGXpxJIU8F+iPfhqg9PzaR13B5RB0MYwF3LWKp0GEo/Cytupf7HnvRYdImQSnTTKzPg4PQzisrVwuLZXBF2LW0QZhAsmARl9v7e6hiTyUnc4VViYSOjzWFOb6FiJ9+HGzb/1n2En+ac3eA7VabsFXZbqpRKW0otMLF5yXrmNJtLl6wKnp1vUxFI9rg9y2lQrmBKycUtZtwYt2A07QGw8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIc8xkVRq3SiEJud6Y3ofxsMAHdpZI/BPqLE/joqdLs=;
 b=RpsymPyPY++zDE7mRjr5/cAaoRmnE9LbacQGsLvEHQ1NDzdvqAhSBDYlnqK2nfDjePKdnwSvhFdvNtw/PfwbQmPAUkS3OGbzsl6WOKOqahS1+LlrglKtqNX8kN6z4rbzcS7+GfiRTVeu6Y4/PRSOpFnpBoJsdlomUSSy+UiqEK4F1YO6F1UkS1TgG+l7PgQg3uzXavpOLp502mtI2sThWZ9l3tmRN6jx98LoZIVGR3+6IvGbT1WjmKZu/loLz2rcUS8i2AziHSj/OrfhGX2Zu4cc4Wa2CmA7rLy5mwZ+H+eEOHhHVkndcOfnDy5gQlx5y28an3e1kGRuTEPW9fhtgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIc8xkVRq3SiEJud6Y3ofxsMAHdpZI/BPqLE/joqdLs=;
 b=faZWpWbCwHjrOI/leHcBY/9+JKS8+hxgeQbXWH39R7f8Lpx1QK/QNiff5+17HHkHaOafm1e7WOtV6RsW7lbct0jYkNTF825a6JFkGIlnsSn4sak4Nl455b1b5VIiwxILpvreXJuQQm6/XyNfeV7MZVO9wa7dLE6RJdIVVWSx9zQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 17:54:25 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 17:54:25 +0000
Subject: Re: [RFC PATCH 1/2] drm/sched: implement drm_sched_entity_num_jobs
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200311171809.7115-1-nirmoy.das@amd.com>
 <98391772-ecca-035e-73ff-26a3d5c8286b@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <2c445cde-ce1c-f46e-25dc-22c11f8e9b59@amd.com>
Date: Wed, 11 Mar 2020 18:58:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <98391772-ecca-035e-73ff-26a3d5c8286b@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f28:ae00:bd65:d97d:c346:e601]
 (2003:c5:8f28:ae00:bd65:d97d:c346:e601) by
 FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Wed, 11 Mar 2020 17:54:23 +0000
X-Originating-IP: [2003:c5:8f28:ae00:bd65:d97d:c346:e601]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4805a110-faff-4170-6781-08d7c5e53c77
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:|DM5PR12MB2485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2485289E4769041F21ED21598BFC0@DM5PR12MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(36756003)(110136005)(316002)(52116002)(31686004)(4326008)(53546011)(186003)(6666004)(16526019)(66556008)(66476007)(478600001)(5660300002)(31696002)(2616005)(6486002)(66946007)(81166006)(8676002)(81156014)(8936002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2485;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsJNqBvxklk5/J8hEm5vqzubI2bFVjPawrnxvRVeA6R9pVFz/UJxJ874nxfDKzHg/WAVtkBeqA84Bqk0GEkeD8oCU1me83uozXlHjcJUB8QMGtQmQ6H1hMO95bmyEsdjpeilkI5HjdMTnWrnCoDETlM3kxG4860dfP0V3R2y8RIgzF+pb0TZiZemOLvATdpi/W2OUk5LbN5pzAf/oit28z+F8b6v5bYTEDsM1F4eOIBOwO6hN8VTx89gplGiPUQhYuqeVLOMSIkXNEGtLX3jmnm0QkjtcGJ9ytH7n2SdPUWXW7Tl1lS7SjFOuwQvnN5WgRrYEYDtM6WzADeAe2PvD9oRMiamq1xvsWiciH8608JhL4d3pszazi0Uqjb0P7qEXn9jZ583Zq8NU+mTs1jZn3a2m0ORd8Hliq1y8vP7IuT98ZtAPYI4FMtX8LwwvAVo
X-MS-Exchange-AntiSpam-MessageData: nXr68uHqa+0B9YKRRPUPgUu0gUV3CfzYJocTPaQV1QTH31EKDZVM6CuMI5YRsMq7xdYaNb0agIPjSk6g1dvQaW72xANbnWkmY0yOiz40/CzGqHUME6dlEGb4yTAFGK7TcA6t9hIJ/o1ycMD19HRZpj1NUaHYolhqMxHtu1HkAn4PqXCHvlKay/R/+ELgPJR3IDUNoNZrXaTR0Sm6D7Lbzw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4805a110-faff-4170-6781-08d7c5e53c77
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 17:54:25.0474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCN5PXAC81RXLYHTuEFuGZ+izGfbn1GWFcyhrifVmDuKLjHJ7vY1JylR/QBvoRfsupHSRplilINTHKNBmdQqmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
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
Cc: Boyuan.Zhang@amd.com, nirmoy.das@amd.com, alexander.deucher@amd.com,
 James.Zhu@amd.com, Leo.Liu@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDMvMTEvMjAgNjoyMyBQTSwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4KPiBPbiAzLzEx
LzIwIDE6MTggUE0sIE5pcm1veSBEYXMgd3JvdGU6Cj4+IEltcGxlbWVudCBkcm1fc2NoZWRfZW50
aXR5X251bV9qb2JzKCkgc28gdGhhdCBkcm0gZHJpdmVycyBjYW4KPj4gcXVlcnkgbnVtYmVyIG9m
IGpvYnMgaW4gYW4gZW50aXR5Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJt
b3kuZGFzQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3Nj
aGVkX2VudGl0eS5jIHwgMTUgKysrKysrKysrKysrKysrCj4+IMKgIGluY2x1ZGUvZHJtL2dwdV9z
Y2hlZHVsZXIuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsKPj4gwqAgMiBmaWxl
cyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9zY2hl
ZHVsZXIvc2NoZWRfZW50aXR5LmMKPj4gaW5kZXggOTBmZDljMzBhZTVhLi5kZmU4MjE2ZjJkNTIg
MTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMK
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+PiBAQCAt
MTE5LDYgKzExOSwyMSBAQCBzdGF0aWMgYm9vbCBkcm1fc2NoZWRfZW50aXR5X2lzX2lkbGUoc3Ry
dWN0IAo+PiBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHkpCj4+IMKgwqDCoMKgwqAgcmV0dXJuIGZh
bHNlOwo+PiDCoCB9Cj4+IMKgICsvKioKPj4gKyAqIGRybV9zY2hlZF9lbnRpdHlfbnVtX2pvYiAt
IEdldCBudW1iZXIgb2Ygam9icyBpbiB0aGUgZW50aXR5CgoKdHlwbyBzL2RybV9zY2hlZF9lbnRp
dHlfbnVtX2pvYi9kcm1fc2NoZWRfZW50aXR5X251bV9qb2JzCgoKPj4gKyAqCj4+ICsgKiBAZW50
aXR5OiBzY2hlZHVsZXIgZW50aXR5Cj4+ICsgKgo+PiArICogUmV0dXJucyBudW1iZXIgb2Ygam9i
cyBpbiB0aGUgZW50aXR5Cj4+ICsgKi8KPj4gK2ludCBkcm1fc2NoZWRfZW50aXR5X251bV9qb2Jz
KHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHkpCj4+ICt7Cj4+ICvCoMKgwqAgaWYgKGRy
bV9zY2hlZF9lbnRpdHlfaXNfaWRsZShlbnRpdHkpKQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IDA7Cj4+ICsKPj4gK8KgwqDCoCByZXR1cm4gc3BzY19xdWV1ZV9jb3VudCgmZW50aXR5LT5qb2Jf
cXVldWUpOwo+PiArfQo+Cj4KPiBXaGF0IGFib3V0IHRoZSBqb2JzIHdoaWNoIGFscmVhZHkgaGF2
ZSBiZWVuIGRlcXVldWVkIGZyb20gam9iX3F1ZXVlIAo+IGFuZCBhcmUgaW4gcHJvZ3Jlc3MgaW4g
dGhlIEhXIHJpbmcgYnV0IHlldCB0byBjb21wbGV0ZSAtIGRvbid0IHRoZXkgCj4gY291bnQgPwoK
SGkgQW5kcmV5LAoKSSBhbSB0aGlua2luZyBpbiB0ZXJtcyBvZiBzb2Z0d2FyZSBzaWRlIG9mIHRo
ZSBjb3VudGluZyBiZWNhdXNlIGZvciBhbiAKZW50aXR5IG9uY2UgYSBqb2IgZGVxdWV1ZWQsIHRo
YXQgam9iIGlzIGNvbXBsZXRlbHkgbG9zdC4KCkkgbWlnaHQgYmUgd3JvbmcgaGVyZSB0aGF0J3Mg
d2h5IHRhZ2dlZCBSRkMgOikKCgpSZWdhcmRzLAoKTmlybW95CgoKPgo+IEFuZHJleQo+Cj4KPgo+
PiArRVhQT1JUX1NZTUJPTChkcm1fc2NoZWRfZW50aXR5X251bV9qb2JzKTsKPj4gwqAgLyoqCj4+
IMKgwqAgKiBkcm1fc2NoZWRfZW50aXR5X2lzX3JlYWR5IC0gQ2hlY2sgaWYgZW50aXR5IGlzIHJl
YWR5Cj4+IMKgwqAgKgo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5o
IGIvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oCj4+IGluZGV4IGQ4OTcyODM2ZDI0OC4uYjVj
ZWZmNzVjYmJlIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmgKPj4g
KysrIGIvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oCj4+IEBAIC0zNDEsNSArMzQxLDYgQEAg
dm9pZCBkcm1fc2NoZWRfZmVuY2VfZmluaXNoZWQoc3RydWN0IAo+PiBkcm1fc2NoZWRfZmVuY2Ug
KmZlbmNlKTsKPj4gwqAgdW5zaWduZWQgbG9uZyBkcm1fc2NoZWRfc3VzcGVuZF90aW1lb3V0KHN0
cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAKPj4gKnNjaGVkKTsKPj4gwqAgdm9pZCBkcm1fc2NoZWRf
cmVzdW1lX3RpbWVvdXQoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCwKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9u
ZyByZW1haW5pbmcpOwo+PiAraW50IGRybV9zY2hlZF9lbnRpdHlfbnVtX2pvYnMoc3RydWN0IGRy
bV9zY2hlZF9lbnRpdHkgKmVudGl0eSk7Cj4+IMKgIMKgICNlbmRpZgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
