Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7C0C4BA3B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 09:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12972468A
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 09:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BCne2sbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12972468A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D19A89949;
	Thu, 27 Feb 2020 09:55:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E038589949
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 09:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efEzRUgELJMVt6+6WVC1/vCU/WSArPrvhbZLj3c1tes1bvxWIGbyLVUe1OkknT7pSfHEF77Y33dw1rMm70k6QjZYOG+MDFTECHqFj2F17BDWMwzkWSHVIp0cd4EIzCXnZOUzux5E9S58ynXcXqm0UJpjkA7kJz5tSA+8d41R4yCLyvzoOVe1mZPrRgJpGEYy5llzK8OQISB6ztqZfhdh2fXV7F1cLy7t0WQoPtxxkdHQC/v94HwzC0yfdkG7+gQXIZYOjhDqqZbUU9YcKSK0gybqpI+/nn41kQ59QvURU4MN9mhBiINqHi2aZBmCkTmZNs4fd9b5g85jk340noKbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQTnvsBKkac/cTsxv4y2sdGLiZ8XVvhifpuuJ6GbWt8=;
 b=b9h/dYSY1B081jBKii9XLJQ1ZLTJ8nbzXLcHu9eg0efTBCx94RTYeW+8eIyfi7wiyrFJ0MJ+n6klX4Oly2W4dDt1OxEOjQzE8fjBCl4LVW9Fkx1mBgjYpz9++cQE9Aqg2VA7CYZuhYucYSplGs7OJ+QdG/SY4LKyFJYS33tQ4ycC1FpJu5N4KzJ3JZeh///5ait+vMQIZhdpIwrKR8Wl18hiDV5H1CiqIquiHBiRMEsDkxdjKUUIDvh5Xbe+WfJFlqbUhPBYonj2M4iHpej6DItHyxuY3y9iif1HlkRGQQhgQynCjRMFIx+nDVeuK7DWabhyizTrhcTdGKjer3Gppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQTnvsBKkac/cTsxv4y2sdGLiZ8XVvhifpuuJ6GbWt8=;
 b=BCne2sbwUuqwvr9cJUN7QltoA1VLFmW0N/L+qbD6xzOH0HIZqaj5VrGXNfCXgUXs1fAgfAGj8IMawQGxBxT+NouwFnY45LGMRjVmAXbmDIco+KZ6CAPXDWQQfkUzWJWcaSGMu6P0w57mr6jEOSxpm5QhKzadAq44xBWouRdDGKM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1145.namprd12.prod.outlook.com (2603:10b6:3:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 09:55:55 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2750.021; Thu, 27 Feb
 2020 09:55:55 +0000
Subject: Re: [RFC PATCH 1/3] drm/amdgpu: implement ring init_priority for
 compute ring
To: Nirmoy <nirmodas@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>
References: <20200226203730.4621-1-nirmoy.das@amd.com>
 <20200226203730.4621-2-nirmoy.das@amd.com>
 <CADnq5_M2w2W5eSX9m5x0hjY3TB7CxJa9YJfyUemk+mfgMVMMPA@mail.gmail.com>
 <65374d06-4bbb-defe-8d5d-9964d1e3ab79@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <16949a36-c27d-8f07-530c-8916fa63ddf5@amd.com>
Date: Thu, 27 Feb 2020 10:55:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <65374d06-4bbb-defe-8d5d-9964d1e3ab79@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR07CA0027.eurprd07.prod.outlook.com
 (2603:10a6:205:1::40) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR07CA0027.eurprd07.prod.outlook.com (2603:10a6:205:1::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.10 via Frontend Transport; Thu, 27 Feb 2020 09:55:54 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4ed52178-5d76-4cc9-f006-08d7bb6b3cca
X-MS-TrafficTypeDiagnostic: DM5PR12MB1145:|DM5PR12MB1145:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1145B21A103F17ED9D226D4D83EB0@DM5PR12MB1145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(110136005)(16526019)(54906003)(186003)(6666004)(6486002)(86362001)(31686004)(8676002)(8936002)(52116002)(66476007)(66946007)(66556008)(4326008)(966005)(2906002)(2616005)(5660300002)(478600001)(53546011)(45080400002)(36756003)(81156014)(31696002)(81166006)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1145;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ugrJ0Qkf48DVNw+DQqdDsL4yaPTA1A0qFBYouNXaSug7ku3g+n7nIZbEiCr1b1BHT3HCClHcW7W/BvUgAjwoTiIZ5LwrM5pnug6ESENdV1jduL0b0qhE8V/5ifYH0oTiAEsKcdEvA0bjRPUiJuzUkaVz4HizclqqhoBvrA6lss9lvBSIaYQd5yRNaIEyjZB44zJKbfnpYfu84VPQ9Feq5i3TcvZk+qfb78Na02zgvVIDQrVFrHzMtnlCZvgYUKG2V+WSn+XjT84Gr0hHqp2mjIhp0nNImwVLouGk8FBwpxmuDoePvzVnCIx5jwI6hFIXtHrmn8p5Io/iwI/KxNHm0kfG0B482USp5sAELL7YPNrg+vvHZHSewLpL0e1Ubjy3w9JHKHHLHZoSHjzGM6xYBkyYlRN1G1AzIMZ70DBkHd85KMDYeJTDsmqyA2PsFPi1r/yRSki1Eu4i/+zsRCgCb+me5IxGcxp5KSC2ssF80gE=
X-MS-Exchange-AntiSpam-MessageData: 8Iuf8lWnVQJ1GaeiMTBVA3vzLXz0wZ2rq+7/MaCawS40LSMEjBRnUrc79MxUScCbmj4KLUM0cQQA0T2WdjyA052NqYHH+xnMwRUUJSqCsIGieBCGIBQqYddeqxFa43/oBd2xWr4+mgwKPMCf0NI0e71ifx5R7FrtTRGiC/CeO1hPr21VAzZkMwuKyyci8gbTFecvLIl00wNG81i1pL0A9Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed52178-5d76-4cc9-f006-08d7bb6b3cca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 09:55:55.3831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5WoRTJ9BSHA5B1b9J7vSt0mefn/dNx/tgUjn4hjyJM/UQR5fAvmYWLFg/dLrOwS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Huang Rui <Ray.Huang@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjcuMDIuMjAgdW0gMTA6NTcgc2NocmllYiBOaXJtb3k6Cj4KPiBPbiAyLzI3LzIwIDU6NDQg
QU0sIEFsZXggRGV1Y2hlciB3cm90ZToKPj4gT24gV2VkLCBGZWIgMjYsIDIwMjAgYXQgMzozNCBQ
TSBOaXJtb3kgRGFzIDxuaXJtb3kuYWllbWRAZ21haWwuY29tPiAKPj4gd3JvdGU6Cj4+PiBpbml0
X3ByaW9yaXR5IHdpbGwgc2V0IHNlY29uZCBjb21wdXRlIHF1ZXVlKGdmeDggYW5kIGdmeDkpIG9m
IGEgcGlwZSAKPj4+IHRvIGhpZ2ggcHJpb3JpdHkKPj4+IGFuZCAxc3QgcXVldWUgdG8gbm9ybWFs
IHByaW9yaXR5Lgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNA
YW1kLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3JpbmcuaCB8wqAgMSArCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhf
MC5jwqDCoMKgIHwgMTQgKysrKysrKysrKysrKysKPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OV8wLmPCoMKgwqAgfCAxMyArKysrKysrKysrKysrCj4+PiDCoCAzIGZpbGVz
IGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuaCAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3JpbmcuaAo+Pj4gaW5kZXggMjRjYWZmMDg1ZDAwLi5hMTA5MzczYjlm
ZTggMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmlu
Zy5oCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oCj4+
PiBAQCAtMTcwLDYgKzE3MCw3IEBAIHN0cnVjdCBhbWRncHVfcmluZ19mdW5jcyB7Cj4+PiDCoMKg
wqDCoMKgwqDCoMKgIC8qIHByaW9yaXR5IGZ1bmN0aW9ucyAqLwo+Pj4gwqDCoMKgwqDCoMKgwqDC
oCB2b2lkICgqc2V0X3ByaW9yaXR5KSAoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGVudW0gZHJtX3NjaGVkX3ByaW9yaXR5IHByaW9yaXR5KTsKPj4+ICvCoMKgwqDCoMKgwqAgdm9p
ZCAoKmluaXRfcHJpb3JpdHkpIChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpOwo+Pj4gwqDCoMKg
wqDCoMKgwqDCoCAvKiBUcnkgdG8gc29mdCByZWNvdmVyIHRoZSByaW5nIHRvIG1ha2UgdGhlIGZl
bmNlIHNpZ25hbCAqLwo+Pj4gwqDCoMKgwqDCoMKgwqDCoCB2b2lkICgqc29mdF9yZWNvdmVyeSko
c3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1bnNpZ25lZCAKPj4+IHZtaWQpOwo+Pj4gwqDCoMKg
wqDCoMKgwqDCoCBpbnQgKCpwcmVlbXB0X2liKShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpOwo+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgCj4+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKPj4+IGluZGV4IGZhMjQ1
OTczZGUxMi4uMTRiYWI2ZTA4YmQ2IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y4XzAuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y4XzAuYwo+Pj4gQEAgLTYzMzQsNiArNjMzNCwxOSBAQCBzdGF0aWMgdm9pZCAKPj4+IGdm
eF92OF8wX3Jpbmdfc2V0X3ByaW9yaXR5X2NvbXB1dGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5n
LAo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBnZnhfdjhfMF9waXBlX3Jlc2VydmVfcmVzb3VyY2VzKGFk
ZXYsIHJpbmcsIGFjcXVpcmUpOwo+Pj4gwqAgfQo+Pj4KPj4+ICtzdGF0aWMgdm9pZCBnZnhfdjhf
MF9yaW5nX2luaXRfcHJpb3JpdHlfY29tcHV0ZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgCj4+PiAqcmlu
ZykKPj4+ICt7Cj4+PiArwqDCoMKgwqDCoMKgIC8qIHNldCBwaXBlIDAgdG8gbm9ybWFsIHByaW9y
aXR5IGFuZCBwaXBlIDEgdG8gaGlnaCBwcmlvcml0eSovCj4+PiArwqDCoMKgwqDCoMKgIGlmIChy
aW5nLT5xdWV1ZSA9PSAxKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZnhf
djhfMF9ocWRfc2V0X3ByaW9yaXR5KHJpbmctPmFkZXYsIHJpbmcsIHRydWUpOwo+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2Z4X3Y4XzBfcmluZ19zZXRfcGlwZV9wZXJjZW50KHJp
bmcsIHRydWUpOwo+Pj4gK8KgwqDCoMKgwqDCoCB9IGVsc2Ugewo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZ2Z4X3Y4XzBfaHFkX3NldF9wcmlvcml0eShyaW5nLT5hZGV2LCByaW5n
LCBmYWxzZSk7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZnhfdjhfMF9yaW5n
X3NldF9waXBlX3BlcmNlbnQocmluZywgZmFsc2UpOwo+Pj4gK8KgwqDCoMKgwqDCoCB9Cj4+PiAr
Cj4+PiArfQo+PiBXZSBzaG91bGQgZHJvcCBnZnhfdjhfMF9ocWRfc2V0X3ByaW9yaXR5KCkgYW5k
IHNldCB0aGUgcHJpb3JpdGllcyBpbgo+PiB0aGUgbXFkIGluc3RlYWQuwqAgSW4gZ2Z4X3Y4XzBf
bXFkX2luaXQoKSwgc2V0Cj4+IG1xZC0+Y3BfaHFkX3BpcGVfcHJpb3JpdHkgYW5kIG1xZC0+Y3Bf
aHFkX3F1ZXVlX3ByaW9yaXR5IGFzCj4+IGFwcHJvcHJpYXRlIGZvciBlYWNoIHF1ZXVlLsKgIEkn
bSBub3Qgc3VyZSB3ZSB3YW50IHRvIG1lc3Mgd2l0aAo+PiBnZnhfdjhfMF9yaW5nX3NldF9waXBl
X3BlcmNlbnQgdWx0aW1hdGVseSBhdCBhbGwgb25jZSB0aGlzIGxhbmRzLgo+PiBUaGF0IHN0dWZm
IHN0YXRpY2FsbHkgYWRqdXN0cyB0aGUgcHJpb3JpdGllcyBiZXR3ZWVuIGdmeCBhbmQgY29tcHV0
ZS4KPiBUaGFua3MgQWxleC4gSSB3aWxsIHNlbmQgYSB1cGRhdGVkIHBhdGNoIGZvciB0aGlzLgoK
TWF5YmUgd2FpdCBhIHNlY29uZCB3aXRoIHRoYXQgSSdtIGp1c3QgZ29pbmcgb3ZlciBwYXRjaCAj
Mi4KCkNocmlzdGlhbi4KCj4+Cj4+PiArCj4+PiDCoCBzdGF0aWMgdm9pZCBnZnhfdjhfMF9yaW5n
X2VtaXRfZmVuY2VfY29tcHV0ZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgCj4+PiAqcmluZywKPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1NjQgYWRkciwgdTY0IHNlcSwKPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBmbGFncykKPj4+IEBAIC02
OTY3LDYgKzY5ODAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIAo+
Pj4gZ2Z4X3Y4XzBfcmluZ19mdW5jc19jb21wdXRlID0gewo+Pj4gwqDCoMKgwqDCoMKgwqDCoCAu
aW5zZXJ0X25vcCA9IGFtZGdwdV9yaW5nX2luc2VydF9ub3AsCj4+PiDCoMKgwqDCoMKgwqDCoMKg
IC5wYWRfaWIgPSBhbWRncHVfcmluZ19nZW5lcmljX3BhZF9pYiwKPj4+IMKgwqDCoMKgwqDCoMKg
wqAgLnNldF9wcmlvcml0eSA9IGdmeF92OF8wX3Jpbmdfc2V0X3ByaW9yaXR5X2NvbXB1dGUsCj4+
PiArwqDCoMKgwqDCoMKgIC5pbml0X3ByaW9yaXR5ID0gZ2Z4X3Y4XzBfcmluZ19pbml0X3ByaW9y
aXR5X2NvbXB1dGUsCj4+PiDCoMKgwqDCoMKgwqDCoMKgIC5lbWl0X3dyZWcgPSBnZnhfdjhfMF9y
aW5nX2VtaXRfd3JlZywKPj4+IMKgIH07Cj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OV8wLmMKPj4+IGluZGV4IDFjN2ExNmI5MTY4Ni4uMGM2Njc0M2ZiNmY1IDEwMDY0
NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+Pj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+Pj4gQEAgLTUxNDMsNiAr
NTE0MywxOCBAQCBzdGF0aWMgdm9pZCAKPj4+IGdmeF92OV8wX3Jpbmdfc2V0X3ByaW9yaXR5X2Nv
bXB1dGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBnZnhf
djlfMF9waXBlX3Jlc2VydmVfcmVzb3VyY2VzKGFkZXYsIHJpbmcsIGFjcXVpcmUpOwo+Pj4gwqAg
fQo+Pj4KPj4+ICtzdGF0aWMgdm9pZCBnZnhfdjlfMF9yaW5nX2luaXRfcHJpb3JpdHlfY29tcHV0
ZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgCj4+PiAqcmluZykKPj4+ICt7Cj4+PiArwqDCoMKgwqDCoMKg
IC8qIHNldCBwaXBlIDAgdG8gbm9ybWFsIHByaW9yaXR5IGFuZCBwaXBlIDEgdG8gaGlnaCBwcmlv
cml0eSovCj4+PiArwqDCoMKgwqDCoMKgIGlmIChyaW5nLT5xdWV1ZSA9PSAxKSB7Cj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZnhfdjlfMF9ocWRfc2V0X3ByaW9yaXR5KHJpbmct
PmFkZXYsIHJpbmcsIHRydWUpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2Z4
X3Y5XzBfcmluZ19zZXRfcGlwZV9wZXJjZW50KHJpbmcsIHRydWUpOwo+Pj4gK8KgwqDCoMKgwqDC
oCB9IGVsc2Ugewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2Z4X3Y5XzBfaHFk
X3NldF9wcmlvcml0eShyaW5nLT5hZGV2LCByaW5nLCBmYWxzZSk7Cj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBnZnhfdjlfMF9yaW5nX3NldF9waXBlX3BlcmNlbnQocmluZywgdHJ1
ZSk7Cj4+PiArwqDCoMKgwqDCoMKgIH0KPj4+ICt9Cj4+IFNhbWUgY29tbWVudCBhcyBhYm92ZS4K
Pj4KPj4gQWxleAo+Pgo+Pj4gKwo+Pj4gwqAgc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfcmluZ19zZXRf
d3B0cl9jb21wdXRlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKPj4+IMKgIHsKPj4+IMKgwqDC
oMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Owo+Pj4g
QEAgLTY1MTQsNiArNjUyNiw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVu
Y3MgCj4+PiBnZnhfdjlfMF9yaW5nX2Z1bmNzX2NvbXB1dGUgPSB7Cj4+PiDCoMKgwqDCoMKgwqDC
oMKgIC5pbnNlcnRfbm9wID0gYW1kZ3B1X3JpbmdfaW5zZXJ0X25vcCwKPj4+IMKgwqDCoMKgwqDC
oMKgwqAgLnBhZF9pYiA9IGFtZGdwdV9yaW5nX2dlbmVyaWNfcGFkX2liLAo+Pj4gwqDCoMKgwqDC
oMKgwqDCoCAuc2V0X3ByaW9yaXR5ID0gZ2Z4X3Y5XzBfcmluZ19zZXRfcHJpb3JpdHlfY29tcHV0
ZSwKPj4+ICvCoMKgwqDCoMKgwqAgLmluaXRfcHJpb3JpdHkgPSBnZnhfdjlfMF9yaW5nX2luaXRf
cHJpb3JpdHlfY29tcHV0ZSwKPj4+IMKgwqDCoMKgwqDCoMKgwqAgLmVtaXRfd3JlZyA9IGdmeF92
OV8wX3JpbmdfZW1pdF93cmVnLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoCAuZW1pdF9yZWdfd2FpdCA9
IGdmeF92OV8wX3JpbmdfZW1pdF9yZWdfd2FpdCwKPj4+IMKgwqDCoMKgwqDCoMKgwqAgLmVtaXRf
cmVnX3dyaXRlX3JlZ193YWl0ID0gCj4+PiBnZnhfdjlfMF9yaW5nX2VtaXRfcmVnX3dyaXRlX3Jl
Z193YWl0LAo+Pj4gLS0gCj4+PiAyLjI1LjAKPj4+Cj4+PiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3Rv
cC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0Nu
aXJtb3kuZGFzJTQwYW1kLmNvbSU3Q2RmZWVhYTIyNDU5NTQ4YmI3Yjk4MDhkN2JiM2ZjYjYwJTdD
M2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE4Mzc1NDk4NzE1
NTQ3MSZhbXA7c2RhdGE9Q1VSJTJCeG9MQk8lMkZQU0c3QjFseUtBZ1FWY01MciUyQnFRUllsSEhz
M09HRlpQQSUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
