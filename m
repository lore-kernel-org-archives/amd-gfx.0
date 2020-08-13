Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B07C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 15:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF0B20658
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 15:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NLrUWxwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF0B20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DA956EA30;
	Thu, 13 Aug 2020 15:03:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13A5D6EA30
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 15:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6+n8Mq+ujFSUBEVRxhPUbftfMCSq3WChc8ytrhHzxiA2wy1mgynEDGElH6MmW25gis3AuLdebEPJWSYlNOMuiq58hWvvisFz1SdfJr3uMHpTI+ZkN6jFC54K42EeZwTlXuBUR+XNHsETvFDhz7CAHyQN/2Nhia22orpg4YQ+RbE326jrSAs9ACut/e48FGpFjU79oAMnGPf3LjTQjTchkrgI6Fm/ggkOJNfGvwiLjhUncI8jYuhj2ZYSdCGm0ZgsrU9WAAgJUvU6mG+9z7HZLckj+FvzdxOueFnp2xeDpysqekeRFGBfN2dB8ZgIpFqfkMBWis1mfNzQonz1UFnoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yAWKV3GK01r63RzmTosVPPiLS1SIrKOlTTFor+MS28=;
 b=mX5wYPPOxETVsMxA5+4hcR3hTx9Jh7UmvMn3bLjVR+68pgESleT6RnB2qYUZ24xIb0dVliOe+jpuYcpagxdTC2wU4RCbvsot2mb8sZzR/RQPzaTfuDSpBP9Gs0zFHzVMJxZU7Pk4Sf6+JDV8W6ztoNBMb5q7vUHNYRiv5xyMNb2uKB5c8QMCakwXVQisz39nw7X9rDK2a0JK40cYri6E2mxPTeKrb7GPU3Ex57SpjkIsBMJ5BsXcybOeS1SyPZfA9lCr9TAWI5VqjtUdi8DZlMzJ3q1yzz1uISIZ92VHeNNiASmBCXeRCh2T1IRBhanFU8sXn2mZIsJnXR/B6NlrQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yAWKV3GK01r63RzmTosVPPiLS1SIrKOlTTFor+MS28=;
 b=NLrUWxwzvnE2U7yWeDcG5UEGsRnaS6YVU4PxVHXo8xv2wRmzshNm4ERV2mTVlLE/s33rnyI5ic09ulRO65ogtzhrkp12yzi+sS9DLajYnoasqmHJHnyyBf4z9Q4/Qw2ZOS8VbyC9YJXCs5ptJiQ54BUvRVhOueFUwsyFux2P7oI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3260.namprd12.prod.outlook.com (2603:10b6:5:183::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Thu, 13 Aug
 2020 15:03:17 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3283.020; Thu, 13 Aug 2020
 15:03:17 +0000
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: add initial support for pci error
 handler
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200811133053.71123-1-nirmoy.das@amd.com>
 <1795711a-9261-2cb4-642e-44bc25afc9ce@amd.com>
 <9770d7a3-0d4e-f609-4530-991154ef1a49@amd.com>
 <b6e878c0-bade-77a5-fda7-6be234c2f6b7@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <50cab62a-e8d4-0e0d-438b-b274c09d0972@amd.com>
Date: Thu, 13 Aug 2020 17:06:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <b6e878c0-bade-77a5-fda7-6be234c2f6b7@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR1201CA0017.namprd12.prod.outlook.com
 (2603:10b6:405:4c::27) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.5.101] (165.204.84.11) by
 BN6PR1201CA0017.namprd12.prod.outlook.com (2603:10b6:405:4c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Thu, 13 Aug 2020 15:03:16 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a85d57d9-7e1f-4516-e90b-08d83f9a02ae
X-MS-TrafficTypeDiagnostic: DM6PR12MB3260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32600670CE46B4A05B08FDFD8B430@DM6PR12MB3260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtCv7Qi0/xiIGBJ3XYlCA8aH5+Uhf61eZ1LFQmYv95cjIyfittYaPGff00d9CEcJsH+zMw2WGYd+dsyFwE2a5cKOTHlWF/VfnVFc7Nx+lwJkAzMz2/n2CeQ4V7rByZ9uH3lA95kA/FNjNGZbfHFnK9qK9z6ad4+fX810DjukEr7nN8l0bKTaP/nAIwwFfwUKiW1phodEbb2pojLKSY8eXY3Su9lWriW8uEfQVAzy3LXxQVwj84OUUp7p74wCWWtQdQwhVG3ZB7kQCUNc9gJ8Ah9iE1aO71ZB4txKgl2W+qDUPxpPmMUoi6GFIygu+rz6WUN+aMMQiQdQWd0uWkKDCgXPMX2aA1FVmC1UsovbenXOS/Hb52lmdReCR2GRGYrgp1Zlf2VczPhRRfn8vBCmObyUk1v1GHoU9tOb0OJ5pMyhg522hT85jtWT2DLBUR97UEsp+56qpdQfn3/VSyrYYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(110136005)(4326008)(16526019)(186003)(66946007)(66556008)(66476007)(8676002)(52116002)(5660300002)(53546011)(31686004)(83380400001)(2906002)(16576012)(26005)(316002)(8936002)(478600001)(956004)(2616005)(966005)(31696002)(36756003)(6486002)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0N0w7x9gclN171Jyd+wH02lt7BUcroSgiNVh3uLAjsJuvzoQII7x+mwf70mRids7dvi7DSUrQK/SQaxR+jkkYMq58fwHE8wJzQUCxTOgz8BnW4ETuzglXOvW6b2H6weHbrGyqGIZNRR+n+I8PavqOj28og5k9eo7jK8gu9jiR04s5W7qLZOtaK81MpMUuBGtBIG/nvnURxGMtojIhYW4bJf5hXgec+OANjYnvdsohtUPJhZU655/7j5qiDeSj7RyuZcCbANc2JNzcUw9iG40no7FZhMBwI0kgzTyxKNiCQSINmQmlQonkCOP5xFyHIP5Melk1VkxCWeSu4M92tKltiuil4fSNhICOJL7+RQdZn+fqx7I0kVcWw9WYfNYtaztqVcZAXtrKHfvMrk1jhCZLz2kAG04/j4+x/xwKCAGdFIcjsp0vtKIdbdDFlg8HkwpyPW/toxWOV443Y0NwFcuCePOkTrZDvfbJ11jytgy1z8pmbnNdcura14YlBv+UvU9lSPqfSlQR3tmElh7WL5cZWEUcmBqIEbd/yYapvQj0nJVPYU0CneSy5s3zXBDmu3YRd2LC1p2BV9930Tg7ofh4QKiOqLPrbDQAZz27WSqKQDn0unu4pP30CLFiojj1Xtkw47NV+A7VgE/5QODkzCQrg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85d57d9-7e1f-4516-e90b-08d83f9a02ae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 15:03:17.6595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkAoqCbNQp0NXSIq5VqzMgawkPu9rlCA/ipcBXM3Ua0/bIWE20fVKm3B/gWDpYcgwyAEX2hulYLjfSFTYQL7ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3260
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDgvMTMvMjAgMzozOCBQTSwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4KPiBPbiA4LzEz
LzIwIDc6MDkgQU0sIE5pcm1veSB3cm90ZToKPj4KPj4gT24gOC8xMi8yMCA0OjUyIFBNLCBBbmRy
ZXkgR3JvZHpvdnNreSB3cm90ZToKPj4+Cj4+PiBPbiA4LzExLzIwIDk6MzAgQU0sIE5pcm1veSBE
YXMgd3JvdGU6Cj4+Pj4gVGhpcyBwYXRjaCB3aWxsIGlnbm9yZSBub24tZmF0YWwgZXJyb3JzIGFu
ZCB0cnkgdG8KPj4+PiBzdG9wIGFtZGdwdSdzIHN3IHN0YWNrIG9uIGZhdGFsIGVycm9ycy4KPj4+
Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPj4+
PiAtLS0KPj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCA1
NiAKPj4+PiArKysrKysrKysrKysrKysrKysrKysrKystCj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQs
IDU0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIAo+Pj4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4+Pj4gaW5kZXggYzEyMTlhZjJlN2Q2Li4y
YjllZGUzMDAwZWUgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2Rydi5jCj4+Pj4gQEAgLTM1LDYgKzM1LDcgQEAKPj4+PiDCoCAjaW5jbHVkZSA8bGludXgvcG1f
cnVudGltZS5oPgo+Pj4+IMKgICNpbmNsdWRlIDxsaW51eC92Z2Ffc3dpdGNoZXJvby5oPgo+Pj4+
IMKgICNpbmNsdWRlIDxkcm0vZHJtX3Byb2JlX2hlbHBlci5oPgo+Pj4+ICsjaW5jbHVkZSA8ZHJt
L2RybV9hdG9taWNfaGVscGVyLmg+Cj4+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L21tdV9ub3RpZmll
ci5oPgo+Pj4+IMKgIMKgICNpbmNsdWRlICJhbWRncHUuaCIKPj4+PiBAQCAtMTUxNiw2ICsxNTE3
LDU4IEBAIHN0YXRpYyBzdHJ1Y3QgZHJtX2RyaXZlciBrbXNfZHJpdmVyID0gewo+Pj4+IMKgwqDC
oMKgwqAgLnBhdGNobGV2ZWwgPSBLTVNfRFJJVkVSX1BBVENITEVWRUwsCj4+Pj4gwqAgfTsKPj4+
PiDCoCArc3RhdGljIHBjaV9lcnNfcmVzdWx0X3QgYW1kZ3B1X3BjaV9lcnJfZGV0ZWN0ZWQoc3Ry
dWN0IHBjaV9kZXYgCj4+Pj4gKnBkZXYsCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcGNpX2NoYW5uZWxfc3RhdGVfdCBzdGF0ZSkKPj4+PiArewo+
Pj4+ICvCoMKgwqAgc3RydWN0IGRybV9kZXZpY2UgKmRldiA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2
KTsKPj4+PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gZGV2LT5kZXZfcHJp
dmF0ZTsKPj4+PiArwqDCoMKgIGludCBpOwo+Pj4+ICvCoMKgwqAgaW50IHJldCA9IFBDSV9FUlNf
UkVTVUxUX0RJU0NPTk5FQ1Q7Cj4+Pj4gKwo+Pj4+ICvCoMKgwqAgc3dpdGNoIChzdGF0ZSkgewo+
Pj4+ICvCoMKgwqAgY2FzZSBwY2lfY2hhbm5lbF9pb19ub3JtYWw6Cj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIHJldCA9IFBDSV9FUlNfUkVTVUxUX0NBTl9SRUNPVkVSOwo+Pj4+ICvCoMKgwqDCoMKgwqDC
oCBicmVhazsKPj4+PiArwqDCoMKgIGRlZmF1bHQ6Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qIERp
c2FibGUgcG93ZXIgbWFuYWdlbWVudCAqLwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBhZGV2LT5ydW5w
bSA9IDA7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qIFN1c3BlbmQgYWxsIElPIG9wZXJhdGlvbnMg
Ki8KPj4+PiArwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2ZiZGV2X3NldF9zdXNwZW5kKGFkZXYsIDEp
Owo+Pj4+ICsgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZhZGV2LT5kZWxheWVkX2luaXRfd29y
ayk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBBTURHUFVfTUFYX1JJTkdT
OyArK2kpIHsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3Jpbmcg
KnJpbmcgPSBhZGV2LT5yaW5nc1tpXTsKPj4+PiArCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKCFyaW5nIHx8ICFyaW5nLT5zY2hlZC50aHJlYWQpCj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4+PiArCj4+Pj4gKyBhbWRncHVfam9iX3N0b3Bf
YWxsX2pvYnNfb25fc2NoZWQoJnJpbmctPnNjaGVkKTsKPj4+Cj4+Pgo+Pj4gWW91IG5lZWQgdG8g
Y2FsbCBkcm1fc2NoZWRfc3RvcCBmaXJzdCBiZWZvcmUgY2FsbGluZyB0aGlzCj4+Pgo+Pj4+ICvC
oMKgwqDCoMKgwqDCoCB9Cj4+Pj4gKwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoYWRldi0+bW9k
ZV9pbmZvLm1vZGVfY29uZmlnX2luaXRpYWxpemVkKSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKCFhbWRncHVfZGV2aWNlX2hhc19kY19zdXBwb3J0KGFkZXYpKQo+Pj4+ICsgZHJt
X2hlbHBlcl9mb3JjZV9kaXNhYmxlX2FsbChhZGV2LT5kZGV2KTsKPj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBlbHNlCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkcm1f
YXRvbWljX2hlbHBlcl9zaHV0ZG93bihhZGV2LT5kZGV2KTsKPj4+PiArwqDCoMKgwqDCoMKgwqAg
fQo+Pj4+ICsKPj4+PiArwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9maW5pKGFk
ZXYpOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBhbWRncHVfZmJkZXZfZmluaShhZGV2KTsKPj4+PiAr
wqDCoMKgwqDCoMKgwqAgLyogVHJ5IHRvIGNsb3NlIGRybSBkZXZpY2UgdG8gc3RvcCBhcHBsaWNh
dGlvbnMKPj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIGZyb20gb3BlbmluZyBkcmkgZmlsZXMgZm9y
IGZ1cnRoZXIgSU8gb3BlcmF0aW9ucy4KPj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIFRPRE86IFRo
aXMgd2lsbCB0aHJvdyB3YXJuaW5nIGFzIHR0bSBpcyBub3QKPj4+PiArwqDCoMKgwqDCoMKgwqDC
oCAqIGNsZWFuZWQgcGVycGVybHkgKi8KPj4+PiArwqDCoMKgwqDCoMKgwqAgZHJtX2Rldl9maW5p
KGRldik7Cj4+Pgo+Pj4KPj4+IEkgdGhpbmsgdXNlciBtb2RlIGFwcGxpY2F0aW9ucyBtaWdodCBz
dGlsbCBob2xkIHJlZmVyZW5jZSB0byB0aGUgZHJtIAo+Pj4gZGV2aWNlIHRocm91Z2ggdGhyb3Vn
aCBkcm1fZGV2X2dldCBlaXRoZXIgYnkgZGlyZWN0bHkgb3BlbmluZwo+Pj4gdGhlIGRldmljZSBm
aWxlIG9yIGluZGlyZWN0bHkgdGhyb3VnaCBpbXBvcnRpbmcgRE1BIGJ1ZmYsIGlmIHNvIHdoZW4g
Cj4+PiB0aGUgbGFzdCBvZiB0aGVtIHRlcm1pbmF0ZSAKPj4+IGRybV9kZXZfcHV0LT5kcm1fZGV2
X3JlbGVhc2UtPi4uLi0+ZHJtX2Rldl9maW5pCj4+PiBtaWdodCBnZXQgY2FsbGVkIGFnYWluIGNh
dXNpbmcgdXNlIGFmdGVyIGZyZWUgZS50LmMgaXNzdWVzLiBNYXliZSAKPj4+IGJldHRlciB0byBj
YWxsIGhlcmUgZHJtX2Rldl9wdXQgdGhlbiBhbmQgc28gZHJtX2Rldl9maW5pIHdpbGwgZ2V0IAo+
Pj4gY2FsbGVkIHdoZW4gdGhpcwo+Pj4gbGFzdCB1c2VyIGNsaWVudCByZWxlYXNlcyBoaXMgcmVm
ZXJlbmNlLgo+Pgo+Pgo+PiBkcm1fZGV2X2ZpbmkoKSBzZWVtcyB0byBiZSBjbGVhbmVyLiBQcm9i
bGVtIGlzwqAgd2luZG93IG1hbmFnZXIoc3dheSkgCj4+IG5ldmVyIGdldHMgdGVybWluYXRlZCBh
ZnRlciB0aGUgQUVSIGVycm9yIGFuZCBkcm0gZmlsZXMgcmVtYWlucyAKPj4gYWN0aXZlLiBTaW1w
bGUgY2F0IG9uIGRyaSBmaWxlcwo+Pgo+PiBnb2VzIHRob3VnaCBhbWRncHUgYW5kIHNwaXRzIG91
dCBtb3JlIGVycm9ycy4KPgo+Cj4gV2hhdCBoYXBwZW5zIGlmIHlvdSBraWxsIHRoZSB3aW5kb3cg
bWFuYWdlciBhZnRlciB5b3UgY2xvc2VkIGRybSAKPiBkZXZpY2Ugd2l0aCB5b3VyIG9yaWdpbmFs
IGNvZGUgYXBwbGllZCA/IEkgd291bGQgZXhwZWN0IGRybV9kZXZfZmluaSAKPiB0byBiZSBjYWxs
ZWQgYWdhaW4KPiBmb3IgdGhlIHJlYXNvbiBpIGV4cGxhaW5lZCBhYm92ZSBhbmQgdGhpcyB3b3Vs
ZCBvYnZpb3VzbHkgd291bGQgYmUgCj4gd3JvbmcgdG8gaGFwcGVuLgoKSGkgQW5kcmV5LAoKCmht
bSBJIHF1aWNrbHkgdHJpZWQgdGhhdCwgS2VybmVsIGNyYXNoZWQgYW5kIGxhdGVyIHJlYm9vdGVk
IGFmdGVyIApzb21ldGltZS4gSSBkb24ndCBoYXZlIGEgc2VyaWFsIGNvbnNvbGUgdG8gY2hlY2sg
bG9ncyBhbmQgdGhlcmUgd2FzIG5vIApsb2dzIGFmdGVyd2FyZHMgaW4gam91cm5hbGN0bC4KCmRy
bV9kZXZfcHV0KCkgaGFkIHNpbWlsYXIgYmVoYXZpb3IsIGtlcm5lbC9tYWNoaW5lIHdhcyBpbmFj
Y2Vzc2libGUgb3ZlciAKc3NoLgoKCkRpZCB5b3UgZmFjZSBzYW1lIGJlaGF2aW9yIHdoaWxlIHRl
c3RpbmcgZ3B1IGhvdHBsdWcgPwoKCk5pcm1veQoKCj4KPiBBbmRyZXkKPgo+Cj4+Cj4+Cj4+Pgo+
Pj4gQWxzbyBhIGdlbmVyYWwgcXVlc3Rpb24gLSBpbiBteSB3b3JrIG9uIERQQyByZWNvdmVyeSBm
ZWF0dXJlIHdoaWNoIAo+Pj4gdHJpZXMgdG8gcmVjb3ZlciBhZnRlciBQQ0llIGVycm9yIC0gb25j
ZSB0aGUgUENJIGVycm9yIGhhcyBoYXBwZW5lZCAKPj4+IE1NSU8gcmVnaXN0ZXJzIGJlY29tZQo+
Pj4gdW5hY2Nlc3NpYmxlIGZvciByL3cgYXMgdGhlIFBDSSBsaW5rIGlzIGRlYWQgdW50aWwgYWZ0
ZXIgdGhlIFBDSSAKPj4+IGxpbmsgaXMgcmVzZXQgYnkgdGhlIERQQyBkcml2ZXIgKHNlZSAKPj4+
IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L1BDSS9wY2ktZXJyb3ItcmVj
b3ZlcnkuaHRtbCAKPj4+IHNlY3Rpb24gNi4xLjQpLgo+Pj4gWW91ciBjYXNlIGlzIHRvIHRyeSBh
bmQgZ3JhY2VmdWxseSB0byBjbG9zZSB0aGUgZHJtIGRldmljZSBvbmNlIAo+Pj4gZmF0YWwgZXJy
b3IgaGFwcGVuZWQsIGRpZG4ndCB5b3UgZW5jb3VudGVyIGVycm9ycyBvciB3YXJuaW5ncyB3aGVu
IAo+Pj4gYWNjZXNzaW5nIEhXIHJlZ2lzdGVycyBkdXJpbmcgYW55IG9mIHRoZSBvcGVyYXRpb25z
Cj4+PiBhYm92ZSA/Cj4+Cj4+Cj4+IEFzIGRpc2N1c3NlZCBvdmVyIGNoYXQsIGl0IHNlZW1zIGFl
ciBnZW5lcmF0ZWQgd2l0aCBhZXItaW5qZWN0IHRvb2wgCj4+IGp1c3QgdHJpZ2dlcnMga2VybmVs
IFBDSSBlcnJvciBBUElzIGJ1dCB0aGUgZGV2aWNlIGlzIHN0aWxsIGFjdGl2ZSBzbyAKPj4gSSBk
aWRuJ3QgZW5jb3VudGVyIGFueSBlcnJvcnMgd2hlbiBhY2Nlc3NpbmcgSFcgcmVnaXN0ZXJzLgo+
Pgo+Pgo+PiBOaXJtb3kKPj4KPj4KPj4+Cj4+PiBBbmRyZXkKPj4+Cj4+Pgo+Pj4+ICvCoMKgwqDC
oMKgwqDCoCBicmVhazsKPj4+PiArwqDCoMKgIH0KPj4+PiArCj4+Pj4gK8KgwqDCoCByZXR1cm4g
cmV0Owo+Pj4+ICt9Cj4+Pj4gKwo+Pj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9lcnJvcl9o
YW5kbGVycyBhbWRncHVfZXJyX2hhbmRsZXIgPSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoCAuZXJyb3Jf
ZGV0ZWN0ZWQgPSBhbWRncHVfcGNpX2Vycl9kZXRlY3RlZCwKPj4+PiArfTsKPj4+PiArCj4+Pj4g
Kwo+Pj4+IMKgIHN0YXRpYyBzdHJ1Y3QgcGNpX2RyaXZlciBhbWRncHVfa21zX3BjaV9kcml2ZXIg
PSB7Cj4+Pj4gwqDCoMKgwqDCoCAubmFtZSA9IERSSVZFUl9OQU1FLAo+Pj4+IMKgwqDCoMKgwqAg
LmlkX3RhYmxlID0gcGNpaWRsaXN0LAo+Pj4+IEBAIC0xNTIzLDEwICsxNTc2LDkgQEAgc3RhdGlj
IHN0cnVjdCBwY2lfZHJpdmVyIAo+Pj4+IGFtZGdwdV9rbXNfcGNpX2RyaXZlciA9IHsKPj4+PiDC
oMKgwqDCoMKgIC5yZW1vdmUgPSBhbWRncHVfcGNpX3JlbW92ZSwKPj4+PiDCoMKgwqDCoMKgIC5z
aHV0ZG93biA9IGFtZGdwdV9wY2lfc2h1dGRvd24sCj4+Pj4gwqDCoMKgwqDCoCAuZHJpdmVyLnBt
ID0gJmFtZGdwdV9wbV9vcHMsCj4+Pj4gK8KgwqDCoCAuZXJyX2hhbmRsZXIgPSAmYW1kZ3B1X2Vy
cl9oYW5kbGVyLAo+Pj4+IMKgIH07Cj4+Pj4gwqAgLQo+Pj4+IC0KPj4+PiDCoCBzdGF0aWMgaW50
IF9faW5pdCBhbWRncHVfaW5pdCh2b2lkKQo+Pj4+IMKgIHsKPj4+PiDCoMKgwqDCoMKgIGludCBy
OwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
