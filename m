Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1592CC34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 14:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C9B24654
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 14:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZrE8KstA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C9B24654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 632E96E81F;
	Wed, 19 Feb 2020 14:27:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1C718947A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 14:27:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1DEQqR8omJK5AjByN4dQDrBFUkkR+bTjMW5tmhj7TNXcoW/jIiKaYNm+jEdCDsErXplcPL7CyrW8brfCyCId0ihSH1qZLE9Hx2hKu55XEdiIcpPkOg6DNyCPbaiLYtUVHrEhOBZ4EgTNx5Zph6emYlhH0Q96g2XsDxm7UU86x1OYPfwkyXMrZRW3Ot9gm2Ef35vPms+lJ3Ut7/VS+CaLmCBPQevdlUdOPvfIi7+VpnBv7baz/Czc6MMrfEyMzUH3JyjrwC7oro3U0rQxItLrT001FVCfkfUZ5QUGBitfXiV3/cTNpUHBcsg6eOSc1Zo8YJh4M1vvWYBEZRVhxuGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk+7YCUondH0ikXMzCMk+N8pu3bu73pq29g7aJzbmeU=;
 b=RHXL2Y3x41cb0U8fM+NgVqC1Y3EkGQ4sqmT9z/NPReFixMhd31uUNW3u0yTxCtZXm2x5XhVYuLSpNn2isZPaw7yNWaDtjbHVa0iFxB+L+XupRIbGfTI5zjCAkD1yTmNIdlzSdfQaXRFwT2JxPQ8h5bBjsFHFpH5ZMOKXSpBg3fcqNugbuxREiz3p2EFut0mblttnnQOv1bd/z5BMxYpuycijBoIx+la9llb3kATw0o74IiN7pJ2UZ/bcNESJ0JnTfujkyhlL3hupzZ3eVJEXgX2dQZ/gWaqqDShqOPoDg6qaqY7kR7Fw7ABr6DqU0UQZH/DcjMZF/zLbEE6Bbgp4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk+7YCUondH0ikXMzCMk+N8pu3bu73pq29g7aJzbmeU=;
 b=ZrE8KstA9PZia1jCGYCcP0T031OI9WoDM9HjAmS/W67ZE992E8A9Dxy93EyYq6qV0xEaEP5o/buJMv6VYhc3vqJmxqJfNM8QQMP1Y8rfH/gGVza33+Gnp3JiRnTuUvO2NLcTzteNsoBj8rnQitkIENMMwddKHmpT6BuhPMzKaMY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (10.255.237.223) by
 MN2PR12MB3007.namprd12.prod.outlook.com (20.178.244.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Wed, 19 Feb 2020 14:27:56 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 14:27:56 +0000
Subject: Re: [PATCH] drm/amdgpu: add VM update fences back to the root PD
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 luben.tuikov@amd.com, Marek.Olsak@amd.com, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20200219142014.25386-1-christian.koenig@amd.com>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <1fde8a92-0b9b-4b0a-e319-7b407810d36c@amd.com>
Date: Wed, 19 Feb 2020 09:27:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200219142014.25386-1-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:404:c9::12) To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR04CA0086.namprd04.prod.outlook.com (2603:10b6:404:c9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 14:27:55 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5cc7e3d3-cbb5-44a1-4b3b-08d7b547e949
X-MS-TrafficTypeDiagnostic: MN2PR12MB3007:|MN2PR12MB3007:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB30072E3CD1913BD29524FE81F7100@MN2PR12MB3007.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(199004)(189003)(316002)(16526019)(6512007)(6486002)(26005)(81156014)(66476007)(186003)(5660300002)(81166006)(8676002)(31686004)(66946007)(36756003)(66556008)(6506007)(86362001)(2616005)(52116002)(956004)(66574012)(8936002)(2906002)(31696002)(53546011)(478600001)(15650500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3007;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/Awq3ebjlRBu8K8DWsC71Uzh79gUDu2/b4RmClVZzrfiZwsBpRqnBTGFr/7sHS1GY5meC3Bv1FPgtTZ/v22rYY+MNCvB6rqxNgRxWaRdUUWt1tjsTsmGiJ4R0b/xJhFyv693eu2eTaZE3XD7IHYCU04NECCcW5tRUBl1ElDewOeTvyJ4mhAb2d9Q4bCgw0yKeAdxvsSxYY3v4eTb02aDbl+3OCrTxFZ/IRik//E8tPT7pv0YJ3yJv20F3rgXr+gxF4/z11UXisTT1iqpYk1+MdGm/Fi1jFZR7gRhg4SGsyvEfaG5n4F2AW2Z7B0/N5SQXFioM2FN7RFxo9xtEGvWjwYGC9BQR+rVBxXFl2i3nu7pgazVbXHEX3YSxQ7XE1B5uolELqucfODv9NArBgmMAOfz5pyHOE6l//Cdl4aEGfQNlxyZgQTKgihRGPRG8/5
X-MS-Exchange-AntiSpam-MessageData: /4A+s+neR5Fz0fKTApyEUkRVwsG1cDQxAQCWZusffuHGngBBGE18qoz/BwECbKfWL2VaWTD7Rftm2sh3rqFFQ2tII7pLuh5e0fQAqzrGEVIyjrcCe1dhxeayoX+U8/c5itirb/CM51LnUjsiBXnLfQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc7e3d3-cbb5-44a1-4b3b-08d7b547e949
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:27:56.1352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCIOfl5RWaceA0C49k5Ubcoy6HSfP8BaIdNNfmyCfofxYaX2abihpuqFZaTAsUqpU52IGc6X7WVzTDUntdhgUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3007
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

VGhpcyBkb2Vzbid0IGFwcGx5IG9uIHRvcCBvZiA3ZmQzYjYzMmUxN2U1NWM1ZmZkMDA4ZjlmMDI1
NzU0ZTdkYWExYjY2IAp3aGljaCBpcyB0aGUgdGlwIG9mIGRybS1uZXh0CgoKVG9tCgpPbiAyMDIw
LTAyLTE5IDk6MjAgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBZGQgdXBkYXRlIGZl
bmNlcyB0byB0aGUgcm9vdCBQRCB3aGlsZSBtYXBwaW5nIEJPcy4KPgo+IE90aGVyd2lzZSBQRHMg
ZnJlZWQgZHVyaW5nIHRoZSBtYXBwaW5nIHdvbid0IHdhaXQgZm9yCj4gdXBkYXRlcyB0byBmaW5p
c2ggYW5kIGNhbiBjYXVzZSBjb3JydXB0aW9ucy4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMTQgKysrKysrKysrKysrLS0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCBlN2FiMGMxZTI3OTMuLmRkNjNjY2Ri
YWQyYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTU4
NSw4ICs1ODUsOCBAQCB2b2lkIGFtZGdwdV92bV9nZXRfcGRfYm8oc3RydWN0IGFtZGdwdV92bSAq
dm0sCj4gICB7Cj4gICAJZW50cnktPnByaW9yaXR5ID0gMDsKPiAgIAllbnRyeS0+dHYuYm8gPSAm
dm0tPnJvb3QuYmFzZS5iby0+dGJvOwo+IC0JLyogT25lIGZvciBUVE0gYW5kIG9uZSBmb3IgdGhl
IENTIGpvYiAqLwo+IC0JZW50cnktPnR2Lm51bV9zaGFyZWQgPSAyOwo+ICsJLyogVHdvIGZvciBW
TSB1cGRhdGVzLCBvbmUgZm9yIFRUTSBhbmQgb25lIGZvciB0aGUgQ1Mgam9iICovCj4gKwllbnRy
eS0+dHYubnVtX3NoYXJlZCA9IDQ7Cj4gICAJZW50cnktPnVzZXJfcGFnZXMgPSBOVUxMOwo+ICAg
CWxpc3RfYWRkKCZlbnRyeS0+dHYuaGVhZCwgdmFsaWRhdGVkKTsKPiAgIH0KPiBAQCAtMTYxOSw2
ICsxNjE5LDE2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCQlnb3RvIGVycm9yX3VubG9jazsKPiAgIAl9Cj4g
ICAKPiArCWlmIChmbGFncyAmIEFNREdQVV9QVEVfVkFMSUQpIHsKPiArCQlzdHJ1Y3QgYW1kZ3B1
X2JvICpyb290ID0gdm0tPnJvb3QuYmFzZS5ibzsKPiArCj4gKwkJaWYgKCFkbWFfZmVuY2VfaXNf
c2lnbmFsZWQodm0tPmxhc3RfZGlyZWN0KSkKPiArCQkJYW1kZ3B1X2JvX2ZlbmNlKHJvb3QsIHZt
LT5sYXN0X2RpcmVjdCwgdHJ1ZSk7Cj4gKwo+ICsJCWlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVk
KHZtLT5sYXN0X2RlbGF5ZWQpKQo+ICsJCQlhbWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxhc3Rf
ZGVsYXllZCwgdHJ1ZSk7Cj4gKwl9Cj4gKwo+ICAgCXIgPSB2bS0+dXBkYXRlX2Z1bmNzLT5wcmVw
YXJlKCZwYXJhbXMsIHJlc3YsIHN5bmNfbW9kZSk7Cj4gICAJaWYgKHIpCj4gICAJCWdvdG8gZXJy
b3JfdW5sb2NrOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
