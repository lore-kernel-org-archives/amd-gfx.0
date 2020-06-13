Return-Path: <SRS0=UFcq=72=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D726C433DF
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Jun 2020 02:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2C7206F5
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Jun 2020 02:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l8Qr5NvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2C7206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8BB26E222;
	Sat, 13 Jun 2020 02:09:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FB656E222
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jun 2020 02:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsTCe3ifEANZ5tksczzpRGYmO/Kio1t2nvqp8B1yQR1XTVJk7rZ9wZk47kgdqklHnZQkLwz3Pw8rlPGhm2uoxJ/NDqRN8t6Fg3qmILanD7mbVvtVs46n40jDBnDdcyQeBYdE99fVAftoGibOwc/j5TZHSNk7Kdchvf3xt2NV7MjxG5NrTkig8IwN5OiXzQCcghxWRr2KHOKo2+l/cqe5z/X5I0qDPXimuy24FNTW2p9wOpU/0fCTBaf8quB9nbTV7YUqbmfSHGflDBfKeEu5T7dRcB6ERyaugx3cD3fYOoc5xIChxKMWOTFOCUNtiYVE6ITrIdBihD+OCunw4SpVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbRnu9th+g3ZCU+BhkXhGM73v4fPwn8KVZGdy4lZsdc=;
 b=ad7HhFVPsESfaWvBaaK7JaucpZwrgyRLHJ3RtDxsOgStz0GVSr4Lv4aXU/aUm+z+nK2fxqAmNNyvGG0T/gU826PfT/n+/+E5QDeCks2Y8ZMMxUejX/MwsQssOUWXtb3r7ewYfYFuU7pf6/9el7Q6nCeoAnJEyw9G96beCfdUdlAoE2lyoDk7srzAju83YxjLpzNSQTvJ85p/+E93Tr0KUPuqbOgMjsQ6Xi4YFQcgw6MduUNN4yiCzNvYqRwBRZ8g67jk5hWKr5tTxZTPLFefX3CU/xmE3PTtG0e9+f/w/nsxSIzMkeAOJ4Yv+M5L82T7bjet9KbTAkYmON9OPJzXdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbRnu9th+g3ZCU+BhkXhGM73v4fPwn8KVZGdy4lZsdc=;
 b=l8Qr5NvY5JczfRmc7OTVlvwSeV2aPS04naD5ZTdGNQLchwHMxbY5SRQ4iIl8X+OBqNXQ+N3wX5WMGZhoTgzjDtO/1NwcITdv34pBSvgHYQXBSxiJkcaxiT1eY9KEdCQLZE5iGL3XRnn7As8RWel03H5B1zp8/Jb+R/DPZTkr51w=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.22; Sat, 13 Jun 2020 02:09:34 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::201f:4349:f4ba:abf9]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::201f:4349:f4ba:abf9%7]) with mapi id 15.20.3088.019; Sat, 13 Jun 2020
 02:09:34 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: Add eviction debug messages
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200612033422.5682-1-Felix.Kuehling@amd.com>
 <98a97cf1-51d4-fade-95c3-6ed649a53ccf@amd.com>
 <81fba166-150a-496b-30d8-fdebc54bea5d@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <7bcf2fe2-44f2-3f9d-8d31-31ab4f0ce182@amd.com>
Date: Fri, 12 Jun 2020 22:09:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <81fba166-150a-496b-30d8-fdebc54bea5d@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::14) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTBPR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Sat, 13 Jun 2020 02:09:33 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8dab2158-2583-489d-9b1a-08d80f3ed0c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB2601:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2601B24E1B8711C7F68C0196E69E0@DM6PR12MB2601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0433DB2766
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKTVCp5nGZ8qOJTt+Tft1EbC4rikcqwz+ZRXQS08h9kGYiYGnz+KjCsaBZpmWZ3kgNt94+MT9xvZozwp/cCqrydOPtO4L2H0kn8q2R0vsuOJRFj5nPaAY53w7tdQK/XIvTR30kfcOSQo17/FxtCXxKt359VmwsHgJWw4brPul0aFH0tDFPgz64YYcr+WTq+Dp2dzsdzdHXywiXm6aXzULBmStUSs31d7u1qv26X2zzdFXmplpXfACNfPXu8GQvCYc8f4cbGcPReuMxrpx4p2NldLlZZgkwnJCkXHhNMJ/O5mk8zcUVXyIUABEWDGKB4AzzSKbjy5NL33PpbQM3Y/pMKSJAP33HB0rnypL3fd5Uj5yA66gLblIN7lpn06aKPR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(16576012)(4326008)(66556008)(31686004)(66946007)(66476007)(52116002)(16526019)(6486002)(478600001)(8676002)(53546011)(26005)(186003)(5660300002)(83380400001)(15650500001)(2906002)(316002)(956004)(8936002)(31696002)(2616005)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4usRaygwl3GFmuC4wWdnWpq4UJe9UZbOYbuYsd9DSPR5cuT2FgodqHR2CZECWfnCmZIu6FtFeSsnYc466ZFt9pIUWlhHswtcTxYQ6/wNW2psAleDlB8U29joYkRNThOFW7qtQf3jK1lynvmwbd8bCjK4xABnaiMkNUduW+qqFbTgKapVWZ86Wx8oO+mSoBigoMCP+5xoupncc0sifjz1NiGlkOwUWYR0JhAbu45ha7IWJW0dGzoc4ZL1C6cL7Pc7BGsuPSrPQx7qsKoptGZpOVqC7OziBMdpcrSTJAcVPWc0XPN3Hwk4M5chLCwmcNR5Y8iOSPkz81TT3+5vkKi1/8/kcmZSYDgmv4T1bg9Pidb4lYLctQfCjt0Ez4DGUjeEGjfA1BKlSMke01LJXahkhBjoPfXUP+TgQWMJWCHn/O97kEBbjZAZHZdWG2ndst5CJZBBHwKAdSSsRsaZw/FBKHQt8ee5xBLDkxNBeCuiy9ZVIahxgOl4LnWTkdRrM7hk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dab2158-2583-489d-9b1a-08d80f3ed0c1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2020 02:09:34.0001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZISySAy/hp/PESPRuBT62ILyWLt8vJ7VGtmA2H8MOUgx8EvIWEpaLmR+AK4LeYVC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2601
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24uCgpSZXZpZXdlZC1ieTogUGhpbGlwIFlhbmcgPFBo
aWxpcC5ZYW5nQGFtZC5jb20+CgpPbiAyMDIwLTA2LTEyIDc6NDMgcC5tLiwgRmVsaXggS3VlaGxp
bmcgd3JvdGU6Cgo+IEFtIDIwMjAtMDYtMTIgdW0gNjowMyBwLm0uIHNjaHJpZWIgcGhpbGlwIHlh
bmc6Cj4+IEl0J3MgZ29vZCBpZGVhLCBiZXR0ZXIgdG8gYWRkIHNhbWUgcHJpbnQgaW4gc3lzdGVt
IG1lbW9yeSBldmljdGlvbgo+PiBwYXRoIGFtZGdwdV9hbWRrZmRfZXZpY3RfdXNlcnB0ci4KPiBU
aGF0J3MgY292ZXJlZCBieSB0aGUgbWVzc2FnZSBpbiBrZ2Qya2ZkX3F1aWVzY2VfbW0uCj4KPgo+
PiBVc2UgV0FSTl9PTkNFIHRvIGF2b2lkIGR1cGxpY2F0ZSBtZXNzYWdlcy4KPiBJIHdhbnQgZHVw
bGljYXRlIG1lc3NhZ2VzLiBJZiBtYW55IGRpZmZlcmVudCBraW5kcyBvZiBldmljdGlvbnMgYXJl
Cj4gaGFwcGVuaW5nIEkgd2FudCB0byBzZWUgdGhlbSBhbGwuIFRoZSBtb2R1bGUgcGFyYW1ldGVy
IGlzIHRoZXJlIHNvIEkgY2FuCj4gdHVybiBpdCBvbi9vZmYgZm9yIHNob3J0IGJ1cnN0cyB3aGls
ZSBpbnRlcmVzdGluZyB0aGluZ3MgYXJlIGhhcHBlbmluZy4KPiBJdCdzIG9mZiBieSBkZWZhdWx0
Lgo+Cj4gSSB3YXMgY29uc2lkZXJpbmcgV0FSTl9SQVRFTElNSVQsIGJ1dCB0aGF0IG1heSBza2lw
IGludGVyZXN0aW5nCj4gZXZpY3Rpb25zIEkgYWN0dWFsbHkgd2FudCB0byBzZWUuCj4KPiBSZWdh
cmRzLAo+ICDCoCBGZWxpeAo+Cj4KPj4gUmVnYXJkcywKPj4KPj4gUGhpbGlwCj4+Cj4+Cj4+IE9u
IDIwMjAtMDYtMTEgMTE6MzQgcC5tLiwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4+PiBVc2UgV0FS
TiB0byBwcmludCBtZXNzYWdlcyB3aXRoIGJhY2t0cmFjZSB3aGVuIGV2aWN0aW9ucyBhcmUgdHJp
Z2dlcmVkLgo+Pj4gVGhpcyBjYW4gaGVscCBkZXRlcm1pbmUgdGhlIHJvb3QgY2F1c2Ugb2YgZXZp
Y3Rpb25zIGFuZCBoZWxwIHNwb3QgZHJpdmVyCj4+PiBidWdzIHRyaWdnZXJpbmcgZXZpY3Rpb25z
IHVuaW50ZW50aW9uYWxseSwgb3IgaGVscCB3aXRoIHBlcmZvcm1hbmNlCj4+PiB0dW5pbmcKPj4+
IGJ5IGF2b2lkaW5nIGNvbmRpdGlvbnMgdGhhdCBjYXVzZSBldmljdGlvbnMgaW4gYSBzcGVjaWZp
YyB3b3JrbG9hZC4KPj4+Cj4+PiBUaGUgbWVzc2FnZXMgYXJlIGNvbnRyb2xsZWQgYnkgYSBuZXcg
bW9kdWxlIHBhcmFtZXRlciB0aGF0IGNhbiBiZQo+Pj4gY2hhbmdlZAo+Pj4gYXQgcnVudGltZToK
Pj4+Cj4+PiAgwqDCoCBlY2hvIFkgPiAvc3lzL21vZHVsZS9hbWRncHUvcGFyYW1ldGVycy9kZWJ1
Z19ldmljdGlvbnMKPj4+ICDCoMKgIGVjaG8gTiA+IC9zeXMvbW9kdWxlL2FtZGdwdS9wYXJhbWV0
ZXJzL2RlYnVnX2V2aWN0aW9ucwo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5n
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+Pj4gLS0tCj4+PiAgwqAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1LmjCoMKgwqDCoMKgIHwgMiArKwo+Pj4gIMKgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuY8KgIHwgOCArKysrKysrKwo+Pj4gIMKgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMgfCAyICsrCj4+PiAgwqAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jwqAgfCAzICsrKwo+Pj4gIMKgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmjCoMKgwqAgfCA1ICsrKysrCj4+PiAgwqAg
NSBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdS5oCj4+PiBpbmRleCAxMGFlOTJlODM1ZjYuLjZjN2RkMGE3MDdjOSAx
MDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+Pj4gQEAgLTE4Niw4ICsx
ODYsMTAgQEAgZXh0ZXJuIGludCBhbWRncHVfbm9yZXRyeTsKPj4+ICDCoCBleHRlcm4gaW50IGFt
ZGdwdV9mb3JjZV9hc2ljX3R5cGU7Cj4+PiAgwqAgI2lmZGVmIENPTkZJR19IU0FfQU1ECj4+PiAg
wqAgZXh0ZXJuIGludCBzY2hlZF9wb2xpY3k7Cj4+PiArZXh0ZXJuIGJvb2wgZGVidWdfZXZpY3Rp
b25zOwo+Pj4gIMKgICNlbHNlCj4+PiAgwqAgc3RhdGljIGNvbnN0IGludCBzY2hlZF9wb2xpY3kg
PSBLRkRfU0NIRURfUE9MSUNZX0hXUzsKPj4+ICtzdGF0aWMgY29uc3QgYm9vbCBkZWJ1Z19ldmlj
dGlvbnM7IC8qID0gZmFsc2UgKi8KPj4+ICDCoCAjZW5kaWYKPj4+ICDCoCDCoCBleHRlcm4gaW50
IGFtZGdwdV90bXo7Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYu
Ywo+Pj4gaW5kZXggZDRkN2NjYTFjYzcyLi5mZGYzNTBkNWU3YjcgMTAwNjQ0Cj4+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+Pj4gQEAgLTcwNSw2ICs3MDUsMTQgQEAg
TU9EVUxFX1BBUk1fREVTQyhod3NfZ3dzX3N1cHBvcnQsICJBc3N1bWUgTUVDMgo+Pj4gRlcgc3Vw
cG9ydHMgR1dTIGJhcnJpZXJzIChmYWxzZSA9Cj4+PiAgwqAgaW50IHF1ZXVlX3ByZWVtcHRpb25f
dGltZW91dF9tcyA9IDkwMDA7Cj4+PiAgwqAgbW9kdWxlX3BhcmFtKHF1ZXVlX3ByZWVtcHRpb25f
dGltZW91dF9tcywgaW50LCAwNjQ0KTsKPj4+ICDCoCBNT0RVTEVfUEFSTV9ERVNDKHF1ZXVlX3By
ZWVtcHRpb25fdGltZW91dF9tcywgInF1ZXVlIHByZWVtcHRpb24KPj4+IHRpbWVvdXQgaW4gbXMg
KDEgPSBNaW5pbXVtLCA5MDAwID0gZGVmYXVsdCkiKTsKPj4+ICsKPj4+ICsvKioKPj4+ICsgKiBE
T0M6IGRlYnVnX2V2aWN0aW9ucyhib29sKQo+Pj4gKyAqIEVuYWJsZSBleHRyYSBkZWJ1ZyBtZXNz
YWdlcyB0byBoZWxwIGRldGVybWluZSB0aGUgY2F1c2Ugb2YgZXZpY3Rpb25zCj4+PiArICovCj4+
PiArYm9vbCBkZWJ1Z19ldmljdGlvbnM7Cj4+PiArbW9kdWxlX3BhcmFtKGRlYnVnX2V2aWN0aW9u
cywgYm9vbCwgMDY0NCk7Cj4+PiArTU9EVUxFX1BBUk1fREVTQyhkZWJ1Z19ldmljdGlvbnMsICJl
bmFibGUgZXZpY3Rpb24gZGVidWcgbWVzc2FnZXMKPj4+IChmYWxzZSA9IGRlZmF1bHQpIik7Cj4+
PiAgwqAgI2VuZGlmCj4+PiAgwqAgwqAgLyoqCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYwo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfc3luYy5jCj4+PiBpbmRleCBiODdjYTE3MTk4NmEuLjA3MmYwZTExODVhOCAx
MDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMK
Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMKPj4+IEBA
IC0yNzUsNiArMjc1LDggQEAgaW50IGFtZGdwdV9zeW5jX3Jlc3Yoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsCj4+PiBzdHJ1Y3QgYW1kZ3B1X3N5bmMgKnN5bmMsCj4+PiAgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+ICDC
oCArwqDCoMKgwqDCoMKgwqAgV0FSTihkZWJ1Z19ldmljdGlvbnMgJiYgZmVuY2Vfb3duZXIgPT0K
Pj4+IEFNREdQVV9GRU5DRV9PV05FUl9LRkQsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICJBZGRpbmcgZXZpY3Rpb24gZmVuY2UgdG8gc3luYyBvYmoiKTsKPj4+ICDCoMKgwqDCoMKgwqDC
oMKgwqAgciA9IGFtZGdwdV9zeW5jX2ZlbmNlKHN5bmMsIGYsIGZhbHNlKTsKPj4+ICDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKHIpCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7
Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5j
Cj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYwo+Pj4gaW5kZXgg
MjIzNDhjZWJhZjM2Li44MDM5M2UwNTgzYmIgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9kZXZpY2UuYwo+Pj4gQEAgLTk0Miw2ICs5NDIsNyBAQCBpbnQga2dkMmtmZF9x
dWllc2NlX21tKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQo+Pj4gIMKgwqDCoMKgwqAgaWYgKCFwKQo+
Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVTUkNIOwo+Pj4gIMKgICvCoMKgwqAgV0FS
TihkZWJ1Z19ldmljdGlvbnMsICJFdmljdGluZyBwaWQgJWQiLCBwLT5sZWFkX3RocmVhZC0+cGlk
KTsKPj4+ICDCoMKgwqDCoMKgIHIgPSBrZmRfcHJvY2Vzc19ldmljdF9xdWV1ZXMocCk7Cj4+PiAg
wqAgwqDCoMKgwqDCoCBrZmRfdW5yZWZfcHJvY2VzcyhwKTsKPj4+IEBAIC0xMDA5LDYgKzEwMTAs
OCBAQCBpbnQKPj4+IGtnZDJrZmRfc2NoZWR1bGVfZXZpY3RfYW5kX3Jlc3RvcmVfcHJvY2Vzcyhz
dHJ1Y3QgbW1fc3RydWN0ICptbSwKPj4+ICDCoMKgwqDCoMKgIC8qIER1cmluZyBwcm9jZXNzIGlu
aXRpYWxpemF0aW9uIGV2aWN0aW9uX3dvcmsuZHdvcmsgaXMKPj4+IGluaXRpYWxpemVkCj4+PiAg
wqDCoMKgwqDCoMKgICogdG8ga2ZkX2V2aWN0X2JvX3dvcmtlcgo+Pj4gIMKgwqDCoMKgwqDCoCAq
Lwo+Pj4gK8KgwqDCoCBXQVJOKGRlYnVnX2V2aWN0aW9ucywgIlNjaGVkdWxpbmcgZXZpY3Rpb24g
b2YgcGlkICVkIGluICVsZAo+Pj4gamlmZmllcyIsCj4+PiArwqDCoMKgwqDCoMKgwqDCoCBwLT5s
ZWFkX3RocmVhZC0+cGlkLCBkZWxheV9qaWZmaWVzKTsKPj4+ICDCoMKgwqDCoMKgIHNjaGVkdWxl
X2RlbGF5ZWRfd29yaygmcC0+ZXZpY3Rpb25fd29yaywgZGVsYXlfamlmZmllcyk7Cj4+PiAgwqAg
b3V0Ogo+Pj4gIMKgwqDCoMKgwqAga2ZkX3VucmVmX3Byb2Nlc3MocCk7Cj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaAo+Pj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oCj4+PiBpbmRleCAxNzNkNThiMmQ4MWYuLjUxYmEy
MDIwNzMyZSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9w
cml2LmgKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgKPj4+
IEBAIC0xNzcsNiArMTc3LDExIEBAIGV4dGVybiBib29sIGh3c19nd3Nfc3VwcG9ydDsKPj4+ICDC
oMKgICovCj4+PiAgwqAgZXh0ZXJuIGludCBxdWV1ZV9wcmVlbXB0aW9uX3RpbWVvdXRfbXM7Cj4+
PiAgwqAgKy8qCj4+PiArICogRW5hYmxlIGV2aWN0aW9uIGRlYnVnIG1lc3NhZ2VzCj4+PiArICov
Cj4+PiArZXh0ZXJuIGJvb2wgZGVidWdfZXZpY3Rpb25zOwo+Pj4gKwo+Pj4gIMKgIGVudW0gY2Fj
aGVfcG9saWN5IHsKPj4+ICDCoMKgwqDCoMKgIGNhY2hlX3BvbGljeV9jb2hlcmVudCwKPj4+ICDC
oMKgwqDCoMKgIGNhY2hlX3BvbGljeV9ub25jb2hlcmVudApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
