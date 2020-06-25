Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11023C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 02:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A5220789
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 02:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="exI6TfYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A5220789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6E16EA0E;
	Thu, 25 Jun 2020 02:07:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770052.outbound.protection.outlook.com [40.107.77.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 019806EA0E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 02:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aR8IHrRUD7SZfC70xHmSsFC+//dfTtcMbfluodniB52xRyXNCVWQPcbNjX5Bkd1aiJzbX+0Ir+UZm+kyo9BhdYzCwcfOw7j3TCbuRn/qHk16/dWuwlZyF45h6/eeAZF0+F/Qb5mHyYv7sj1cwEXJJAv4J3KLsUeQDVNhwNNnXCjYXloyz+DJGlIWsUWgDovP513pIurhJFelmsOfcHrODPMXsh8QNop1psTfF7FxzkGTURTmX9ph92dG31UmSjK2KARfrEWTVdUqYsRfY9O5Ke2b4G732o1loYyu+O23pqLo0Z6HiYBWSBNu7oJZzpkQSp1bYsv6J0OSSArFa3DIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dN32Vzd8FLyDdFbXz+ob2+MLvzWv9f/4zJzSHFMNTU=;
 b=b0JzjleedC4j4qkc8CVC/imgM9s554wNwx8+7M68NfmCyJZUMnuBzvdNRxop+JmgMJyGx0fW+gs2tdStOJO70xQRdar3yTnk3id8ckxPtsLb29ir8VRDcw8ZAX0UFrjiaLTD9YMBEnqO4Hy1clQthYM9XVBg6eMbzfQX6CPA69NnIqZEOSdWyyRNAEbqovd8vfiuwdjWAtNCPTteZCPlKVJvA3L8xvwYiX+zCYnrTzDc1kjFA6hoJWMq1cBU51tRL91gyNoCPauCC19Oih2qp8YV6JTc6lgS2UlI+MCHXUPG8rywzppeAG1farxZANTXFiBPj2C6ZLBq41IuuU1Xnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dN32Vzd8FLyDdFbXz+ob2+MLvzWv9f/4zJzSHFMNTU=;
 b=exI6TfYGfH94AZoPztafEyQ3A/TUXy2lPjgYi0RiDGDRO1ZPE1WtncLOkiWg0MxI0V5g742Bzg+vK2sehMAF8JDZNHy2woeGACdw1vn4lDSPqiCUcR3mqgdYJKITSeb9n2gEAz5gvZ6/AgQjrZi4gsuoTc6FQuEBfRWTnr52ZZs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2512.namprd12.prod.outlook.com (2603:10b6:802:31::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 25 Jun
 2020 02:06:58 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3109.021; Thu, 25 Jun 2020
 02:06:58 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: enable runtime pm on vega10 when noretry=0
To: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20200624190519.2378793-1-alexander.deucher@amd.com>
 <20200624190519.2378793-2-alexander.deucher@amd.com>
 <59f8ba89-24d4-cc1c-c573-41534978d262@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <99315d09-6410-1098-b53d-99f75695580d@amd.com>
Date: Wed, 24 Jun 2020 22:06:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <59f8ba89-24d4-cc1c-c573-41534978d262@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::27) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Thu, 25 Jun 2020 02:06:57 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4d76e16f-a95b-4532-3a61-08d818ac70c1
X-MS-TrafficTypeDiagnostic: SN1PR12MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2512C051F3800105C594D28E92920@SN1PR12MB2512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcHFeyp1hrEtlPoRsoz4dEL91rqgqWN66pB6kuwlGwSO0r1KbCWlx3c+cxOjphVVtrf5X9I1VKPjQw38MZ//MmFhS0nNdWsZASposiBePQH7NoOUGq6pyJ7QHQoidd9dRri/l6mZDn4VZ/5RQcB4CCIYTqpyEA49D3UKvcBTizCdkfargpaFZ2KI2UeInovVknL5TO/6trYy/zCnFCIDIsat0NFgh+QrQwt4sD7ptm0627Y0TSRs9Lg+cYNh8s1xSTzj5SOe9PwpaaWXI+N0blx1+n69zaeoBWqB3Rai5sxDmp1jBtPLd+Txh91GUu4okMlOEL/0o4mj4nfEM4jNRjDu3qJSa7A9iwO0r2DobmWL1NZtIs/HWDMIPtzQluUJNwKn3c3p3fxfCIAi98l4czgkHja1uDYx0E09G06SUZw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(2616005)(8936002)(5660300002)(6486002)(110136005)(83380400001)(66556008)(36756003)(66946007)(2906002)(66476007)(8676002)(478600001)(966005)(16526019)(86362001)(53546011)(186003)(44832011)(956004)(31686004)(52116002)(16576012)(31696002)(26005)(316002)(45080400002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HjwzY9TdpqR/cR0cewD2YvLO/mc05V6iPiIU4nVXPMfLFZ1MTz8VVsOx+3DL9Vf8V5Bcb1HrEbMFSedG6a9xhDYuIQUu4e0nJZwP50Wxe2qFFks+pbvI9tGBlNNXBh+dNShlfgkI0XDNNVn2nSaDMXOgFnwrszDsFqN5UzIfhjzzvVGBaAb+KalgsBPs3FvHvSapSPs7BgzFamRVmG9m25S3wnEdDwa4ucEtuAoWprriY8l3cucPdOyEPtlFImyNw6gQM/hvniwRScCZanLDX8wtHvXRbol4EE55oCjMHiy1fEtySam2ah8QGursnB3K96Qqs51W9DFbA0PZXQ7/Omqm1ozBIE0tgsO1RS+9kVb152vy3prF5iopvPuNiFBnfFpj8trslQvpltyKe7YiYtu6j29ek6QR8ol32nbm02GsB+pySUd0bJUzhsCopRtNBODAmKA7CTUTqdqurvOLH/ChVxmoe/rgWFolFmaPVqA3QcVwff/5oe4xa8UFTQkK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d76e16f-a95b-4532-3a61-08d818ac70c1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 02:06:58.0276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vFJ8/vJd8sK+TeEARpAUgWppPcbV2Pog1fQJUrSkp7hZIzWoB+gfr+o1ADxsBOMcsTSS7SVTYQ0hNZ1y8Fppg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2512
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjAtMDYtMjQgdW0gODowNiBwLm0uIHNjaHJpZWIgQmhhcmR3YWosIFJham5lZXNoOgo+
Cj4gT24gNi8yNC8yMDIwIDM6MDUgUE0sIEFsZXggRGV1Y2hlciB3cm90ZToKPj4gW0NBVVRJT046
IEV4dGVybmFsIEVtYWlsXQo+Pgo+PiBUaGUgZmFpbHVyZXMgd2l0aCBST0NtIG9ubHkgaGFwcGVu
IHdpdGggbm9yZXRyeT0xLCBzbwo+PiBlbmFibGUgcnVudGltZSBwbSB3aGVuIG5vcmV0cnk9MCAo
dGhlIGN1cnJlbnQgZGVmYXVsdCkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyB8IDYgKysrKystCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYwo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9rbXMuYwo+PiBpbmRleCAwZmVjMzllZWQxNjQuLjM0MWQwNzJlZGQ5NSAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYwo+PiBAQCAtMTc2
LDcgKzE3Niw2IEBAIGludCBhbWRncHVfZHJpdmVyX2xvYWRfa21zKHN0cnVjdCBkcm1fZGV2aWNl
Cj4+ICpkZXYsIHVuc2lnbmVkIGxvbmcgZmxhZ3MpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNhc2UgQ0hJUF9CT05BSVJFOgo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBjYXNlIENISVBfSEFXQUlJOgo+PiDCoCAjZW5kaWYKPj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY2FzZSBDSElQX1ZFR0ExMDoKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY2FzZSBDSElQX1ZFR0EyMDoKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY2FzZSBDSElQX0FSQ1RVUlVTOgo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBjYXNlIENISVBfU0lFTk5BX0NJQ0hMSUQ6Cj4+IEBAIC0xODQsNiArMTgzLDExIEBA
IGludCBhbWRncHVfZHJpdmVyX2xvYWRfa21zKHN0cnVjdCBkcm1fZGV2aWNlCj4+ICpkZXYsIHVu
c2lnbmVkIGxvbmcgZmxhZ3MpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoYW1kZ3B1X3J1bnRpbWVfcG0gPiAwKQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZXYt
PnJ1bnBtID0gdHJ1ZTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGJyZWFrOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIENI
SVBfVkVHQTEwOgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLyogdHVybiBydW5wbSBvbiBpZiBub3JldHJ5PTAgKi8KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghYW1kZ3B1X25vcmV0cnkpCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YWRldi0+cnVucG0gPSB0cnVlOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYnJlYWs7Cj4KPiBUaG91Z2ggaXQgZml4ZXMgdGhlIFJPQ20gcHl0b3JjaCBp
c3N1ZSBidXQgYXJlbid0IHRoZXJlIGFueSBzdGFiaWxpdHkKPiBhbmQgcGVyZm9ybWFuY2Ugb3B0
aW1pemF0aW9uIGNvbmNlcm5zIGFzIGl0IHdpbGwgaW1wYWN0IHJlY292ZXJhYmxlCj4gcGFnZSBm
YXVsdHM/Cj4KPiBJIGhhdmUgbm8gb2JqZWN0aW9uIHRvIHRoaXMgb3RoZXJ3aXNlLgo+Cj4gKyBm
ZWxpeAoKVGhpcyBvbmx5IGRpc2FibGVzIHJ1bnRpbWUgUE0gaW4gc29tZSBjb3JuZXIgY2FzZSBh
cyBhIHdvcmthcm91bmQgdW50aWwKd2UgdW5kZXJzdGFuZCB0aGUgcm9vdCBjYXVzZSBvZiB0aGUg
cHJvYmxlbS4gVGhlIG9ubHkgaW1wYWN0IHNob3VsZCBiZQptb3JlIHBvd2VyIGNvbnN1bXB0aW9u
IHdoaWxlIHRoZSBHUFUgaXMgaWRsZS4gSSBkb24ndCBleHBlY3QgYQpwZXJmb3JtYW5jZSBvciBz
dGFiaWxpdHkgaW1wYWN0IGZyb20gdGhpcyBjaGFuZ2UuCgpUaGUgc2VyaWVzIGlzCgpSZXZpZXdl
ZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgpSZWdhcmRzLArC
oCBGZWxpeAoKPgo+IEFja2VkLWJ5OiBSYWpuZWVzaCBCaGFyZHdhaiA8cmFqbmVlc2guYmhhcmR3
YWpAYW1kLmNvbT4KPgo+Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlZmF1
bHQ6Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAv
KiBlbmFibGUgcnVucG0gb24gVkkrICovCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBhZGV2LT5ydW5wbSA9IHRydWU7Cj4+IC0tIAo+PiAyLjI1LjQK
Pj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4g
aHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBz
JTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1k
LWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDcmFqbmVlc2guYmhhcmR3YWolNDBhbWQuY29tJTdDYzk4
NWVmMDQxNGJkNDFiNDhlYjUwOGQ4MTg3MTk2ZWQlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5
OTRlMTgzZCU3QzAlN0MwJTdDNjM3Mjg2MjIzNDM3NTUzNjIyJmFtcDtzZGF0YT13UkpidTMlMkYz
enUlMkJIWjNLQSUyRlpteWgxeWhnQVRNMnpPTlJyJTJGdkk1S3N4ck0lM0QmYW1wO3Jlc2VydmVk
PTAKPj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
