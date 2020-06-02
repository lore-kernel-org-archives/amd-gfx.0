Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8C9C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 20:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ADCB20674
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 20:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j9pnlzP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADCB20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30E886E46C;
	Tue,  2 Jun 2020 20:46:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CC806E48B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 20:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hM+USNy1P7Lw5NZkuQES4cOTtxroJbUaeVwEyk/zBWsm/3pfHXGys52QeVf2IYn3g2on2XNOOD/2palE6wZ+VLCaw+FHRhdDt4YEVKWxuLmSLevmKluyZHcayhBGJ0BG65sVwww7zNEYbWLgZUdqhxpGsKez+8VZEdxVbcaFGEVVrMORpVtWHuPNGSepEqG2+VJ8U6B9YAxDXNwlKHnazoZpw5QmntivrspsDlcCOdLf06vCtbsJR2c/IHg9smn/L9XGxKW1TRY7OVs7FA8LPqYqp4itvypqmHGPe5j8yly5MzVi0c+gnOEd3cf1I2FyMOuH76wgTPSzsMZRhRf+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA1KI9DKxYGhYmeQScFfYl1OVTlKXUvJjgx2gP+9ukc=;
 b=KdCxPlXrTH8avlAC0FAFKTvi/fUqANPsBn+RESBlTXnaocQ2vhST0lvW/o6SuM1p6PCFNOOjSr00VpVq4I9MVUCCdQeKxM1ZAXlZj9tUuSdbQXgRlL4NBZXYEXxCNk1ATcftEXA8sQSe6oLcGfEwbKkL1CZDJYdycIyt1hraoNU0KV8qew5EwaI8W9j+4teC55g6PPuczzjZGrWMiOAPHLTmN+SFn26c7O/I8iPDBl/n6WH+2roNLmWGVaLIQm2xIObg4JELWwuTU1WrWlJvYSBBGRMli+jeCOqU/y1dHT7Z6uelUiBu/dm6RaZ8MIkB9mRalW/+eQWUcv3GpnSzuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA1KI9DKxYGhYmeQScFfYl1OVTlKXUvJjgx2gP+9ukc=;
 b=j9pnlzP0MHFRDKX96NaO3Rr8Mfgc9VVc7f06Jnj6WY1rDB+S1C2AvMfiV7gOw9p9+D0cMgZSJOMFG7sG4iSQ8Vea2tvZl6IQZxMRplUno3zuxZJhb7cp/KHTOI7Jpt3TpHWp1RfcXGxVd0JVlSikndNCCzquhRrhv+xBgda8GhA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1155.namprd12.prod.outlook.com (2603:10b6:404:1b::17)
 by BN6PR12MB1121.namprd12.prod.outlook.com (2603:10b6:404:1c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 2 Jun
 2020 20:46:54 +0000
Received: from BN6PR12MB1155.namprd12.prod.outlook.com
 ([fe80::6c17:115:fa26:adf2]) by BN6PR12MB1155.namprd12.prod.outlook.com
 ([fe80::6c17:115:fa26:adf2%12]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 20:46:54 +0000
Subject: Re: [PATCH] drm/amdgpu: restrict bo mapping within gpu address limits
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200602182735.5940-1-rajneesh.bhardwaj@amd.com>
 <0c1e4120-e8fd-585f-f785-0cb081636ac9@amd.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
Message-ID: <54aae79c-4149-3405-8381-57b6672ef714@amd.com>
Date: Tue, 2 Jun 2020 16:46:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <0c1e4120-e8fd-585f-f785-0cb081636ac9@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::48) To BN6PR12MB1155.namprd12.prod.outlook.com
 (2603:10b6:404:1b::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.34.178] (165.204.54.211) by
 YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Tue, 2 Jun 2020 20:46:52 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 521229b6-686a-4c64-b8ad-08d807361509
X-MS-TrafficTypeDiagnostic: BN6PR12MB1121:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1121D62A2BED8BD207B7760FFE8B0@BN6PR12MB1121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AjVzWP+pnFA5GnrfCUpN8Shh9EEaayKweV44zmqgqAWnF/OFINk2MXCz3Pn0n6Q8uiQ7OnT9P9wigKwPIVRHcA9icjrgVIh4YHPbF9SDuTx+WLda36aP79t+yYcnFea0uJMlx7a4PQ7sFTZSCGOMVLv5MyxrozIYGifFbGzUG2uwhdxXeZ7GTNAWMM/t/k/p8pt3wC7vZTBe59RU5WuZveNzZDa+4zGhtWKLtLd3zGIK6EYf5MoK33tiOahNFKTEgRXU3S/uFEFdcpmiwVd9kgxrl412XtkzkJnYqD3wVl8ZWixOH82eiJ93PcRu/8WX+XDkVm+Y7sBl3ftBhjw4FXmJ1Qy9mqIBuXJqZxrUPOrKZcwdLP/sk8LS87rHCKHe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1155.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(4326008)(2906002)(66946007)(2616005)(956004)(66476007)(66556008)(8936002)(83380400001)(8676002)(5660300002)(186003)(53546011)(86362001)(31696002)(6666004)(31686004)(16526019)(16576012)(316002)(66574014)(6486002)(36756003)(26005)(478600001)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SrlWbQauQtsMtm7RIT8qgHUz1Rfixa5OlcmL7AaKXLQufVV8Cub9xpl3QdJCpwlAWWWXqHR0nEnELmBI8LBApkMK8mEEh/vkuXDF0iqfCq8DbSdGKkZC6WcCMSsaTARyQm6WiU9vIlasiFbdXYjnxnqEL2gaCtPAWOuIIuw1vvImduQ9Ecq3MH8KwRCdTSjDrI83Nw3VJnMUTKF9g2OBhLR1fx1pr3NTIaI0fHESQ73/Uj/INwng5NQTPuxA10sQzpEeqlX5wzWcxenNyeZxZETYnJTIeDXIbRMx2HbWTFcx+Ku8vciaJBF3fvr0ShI/Xf6gUBx07+SY4xIc2CB95FNymQklVSsjnVBf1Xh6O0KaxefFC2tWoZeVomNO77zU2ik80JP88+6jkC0v7Fr/+Yu/0ExtqxN+IqQbPSLm+jAc7uzBCueBxu9LaGxSPAayE1UuzJsX7FHHx966QTbR2Vp6Bt8J8tHiNckO3Dx/zp4/tMEyz4LQKztELFmpTsNA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521229b6-686a-4c64-b8ad-08d807361509
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 20:46:53.7821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uac5ekIXyKYJ5b6gYkAJPCgUnk76Tc2XMgezWCp41NmLF1TPm4VcCeB3fPpwcDBWziVaqL6umqgrQzGkT+M82g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1121
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDYvMi8yMDIwIDM6NTEgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gSGkgUmFqbmVl
c2gsCj4KPiBJIHRoaW5rIHdlIGhhdmUgcmV2aWV3ZWQgdGhlIHBhdGNoIG11bHRpcGxlIHRpbWVz
IG5vdywgeW91IGNhbiBwdXNoIGl0IAo+IHRvIHRoZSBhbWQtc3RhZ2luZy1kcm0tbmV4dCBicmFu
Y2guCgpUaGFua3MgQ2hyaXN0aWFuLiBKdXN0IHdhbnRlZCB0byBtYWtlIHN1cmUgaXRzIHNlbnQg
b25jZSBvbiB0aGUgcHVibGljIApsaXN0LiBJJ2xsIHB1c2ggaXQgdG8gdGhlIGJyYW5jaCBub3cu
CgoKPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4gQW0gMDIuMDYuMjAgdW0gMjA6Mjcgc2No
cmllYiBSYWpuZWVzaCBCaGFyZHdhajoKPj4gSGF2ZSBzdHJpY3QgY2hlY2sgb24gYm8gbWFwcGlu
ZyBzaW5jZSBvbiBzb21lIHN5c3RlbXMsIHN1Y2ggYXMgQStBIG9yCj4+IGh5YnJpZCwgdGhlIGNw
dSBtaWdodCBzdXBwb3J0IDUgbGV2ZWwgcGFnaW5nIG9yIGNhbiBhZGRyZXNzIG1lbW9yeSBhYm92
ZQo+PiA0OCBiaXRzIGJ1dCBncHUgbWlnaHQgYmUgbGltaXRlZCBieSBoYXJkd2FyZSB0byBqdXN0
IHVzZSA0OCBiaXRzLiBJbgo+PiBnZW5lcmFsLCB0aGlzIGFwcGxpZXMgdG8gYWxsIGFzaWNzIHdo
ZXJlIHRoaXMgbGltaXRhdGlvbiBjYW4gYmUgY2hlY2tlZAo+PiBhZ2FpbnN0IHRoZWlyIG1heF9w
Zm4gcmFuZ2UuIFRoaXMgcmVzdHJpY3RzIHRoZSByYW5nZSB0byBtYXAgYm8gd2l0aGluCj4+IHBy
YXRpY2FsIGxpbWl0cyBvZiBjcHUgYW5kIGdwdSBmb3Igc2hhcmVkIHZpcnR1YWwgbWVtb3J5IGFj
Y2Vzcy4KPj4KPj4gUmV2aWV3ZWQtYnk6IE9hayBaZW5nIDxvYWsuemVuZ0BhbWQuY29tPgo+PiBS
ZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+
PiBSZXZpZXdlZC1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgo+PiBB
Y2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBSYWpuZWVzaCBCaGFyZHdhaiA8cmFqbmVlc2guYmhhcmR3YWpAYW1kLmNvbT4K
Pj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNiAr
KysrLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+IGluZGV4
IDc0MTc3NTRlOTE0MS4uNzFlMDA1Y2YyOTUyIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYwo+PiBAQCAtMjIwOCw3ICsyMjA4LDggQEAgaW50IGFtZGdwdV92bV9i
b19tYXAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+IMKgwqDCoMKgwqAgLyogbWFrZSBz
dXJlIG9iamVjdCBmaXQgYXQgdGhpcyBvZmZzZXQgKi8KPj4gwqDCoMKgwqDCoCBlYWRkciA9IHNh
ZGRyICsgc2l6ZSAtIDE7Cj4+IMKgwqDCoMKgwqAgaWYgKHNhZGRyID49IGVhZGRyIHx8Cj4+IC3C
oMKgwqDCoMKgwqDCoCAoYm8gJiYgb2Zmc2V0ICsgc2l6ZSA+IGFtZGdwdV9ib19zaXplKGJvKSkp
Cj4+ICvCoMKgwqDCoMKgwqDCoCAoYm8gJiYgb2Zmc2V0ICsgc2l6ZSA+IGFtZGdwdV9ib19zaXpl
KGJvKSkgfHwKPj4gK8KgwqDCoMKgwqDCoMKgIChlYWRkciA+PSBhZGV2LT52bV9tYW5hZ2VyLm1h
eF9wZm4gPDwgQU1ER1BVX0dQVV9QQUdFX1NISUZUKSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiAtRUlOVkFMOwo+PiDCoCDCoMKgwqDCoMKgIHNhZGRyIC89IEFNREdQVV9HUFVfUEFHRV9T
SVpFOwo+PiBAQCAtMjI3Myw3ICsyMjc0LDggQEAgaW50IGFtZGdwdV92bV9ib19yZXBsYWNlX21h
cChzdHJ1Y3QgCj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+IMKgwqDCoMKgwqAgLyogbWFrZSBz
dXJlIG9iamVjdCBmaXQgYXQgdGhpcyBvZmZzZXQgKi8KPj4gwqDCoMKgwqDCoCBlYWRkciA9IHNh
ZGRyICsgc2l6ZSAtIDE7Cj4+IMKgwqDCoMKgwqAgaWYgKHNhZGRyID49IGVhZGRyIHx8Cj4+IC3C
oMKgwqDCoMKgwqDCoCAoYm8gJiYgb2Zmc2V0ICsgc2l6ZSA+IGFtZGdwdV9ib19zaXplKGJvKSkp
Cj4+ICvCoMKgwqDCoMKgwqDCoCAoYm8gJiYgb2Zmc2V0ICsgc2l6ZSA+IGFtZGdwdV9ib19zaXpl
KGJvKSkgfHwKPj4gK8KgwqDCoMKgwqDCoMKgIChlYWRkciA+PSBhZGV2LT52bV9tYW5hZ2VyLm1h
eF9wZm4gPDwgQU1ER1BVX0dQVV9QQUdFX1NISUZUKSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiAtRUlOVkFMOwo+PiDCoCDCoMKgwqDCoMKgIC8qIEFsbG9jYXRlIGFsbCB0aGUgbmVlZGVk
IG1lbW9yeSAqLwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
