Return-Path: <SRS0=J303=3J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3409C2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 17:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9101622525
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 17:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xW2GegBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9101622525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 463896EA5A;
	Mon, 20 Jan 2020 17:47:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 403096EA5A
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 17:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IclXNDxjI1tC5NohLlZvy06yASg27gKaJkchaK0WdjvPGROjsMgf0l6wXnRlO48M7TCCwwpalTDC7lHV8fXKybvumn7CfgVP9JMvGgcseney3MwILqDfU4Wl6nrBMrqlw89Z4HGVKaMPW6SypbNOn5vZW5x2llABEpXyJ1Jmbfowuxs9/KkR6YTC6FErYW1sDXGWvkE4+ZifSihrPd/KR/eacwZq2kk483Q6s04Vo919SEUjPXalz1J3JxMPuaIT5yQydl14h1mIXDDIZqjhb5sZN6SEbQqTGNzzIBPnXeAUMuOP6KbqkB7pE6GE0p8vk6IBsVMkADBHE8fwvmhesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBkz8wmlLBJJWV3x3j+/KWuI44kIy4eVRGD+RHx1YQY=;
 b=ghOo0fVkRkUSQ55Juw5kUbxnOURiHq49VSkjwO3ObcifAWqcB+Z3F8F/K793IoGzz6QVYxU0L1Nrqiqc4EY2kATTPmeMKSxI9+7yvk1IRWuZWJkElizb/eQPrRA+YMigtT1YWaVrkMSLl0w1kNdqUPebGyfzAqnxqvssLDXFtgN3ex3CFHf1tG0iQQGPotCYD8t9qJraBkWR1Qyd6yYi/2ABDF02AJN8m5FhdqZENIARD57xN08OXAR6D8X2dUgyAgYvOSw0+v/CM17y4mQj6PrjPhLOkmgaRgRDznnegRI4Asz9a286Jo85Xtk4cTNtYxxF6IV1LXlA7iXsHaR6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBkz8wmlLBJJWV3x3j+/KWuI44kIy4eVRGD+RHx1YQY=;
 b=xW2GegBu3c2Iqon8xixijtM4YXCC8KXOyezbnFMy1pQNKqlArLenJo8u4GkbnJw9etW7e1P9kRuhHvXSsfYyDmCTDwh0bu4R1Ru1B3pG7yg0XPIAInwpha2kUMxdFo5ME1ZxY7O8RIZQsd9M6JuaKqJD5Ru/PcVD/yQEdv+Qm8M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shaoyun.Liu@amd.com; 
Received: from DM6PR12MB3241.namprd12.prod.outlook.com (20.179.105.153) by
 DM6PR12MB3883.namprd12.prod.outlook.com (10.255.174.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 17:47:45 +0000
Received: from DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::e9a0:2dda:d7b9:9a10]) by DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::e9a0:2dda:d7b9:9a10%5]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 17:47:45 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: Improve Vega20 XGMI TLB flush workaround
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200118013735.19361-1-Felix.Kuehling@amd.com>
 <20200118013735.19361-3-Felix.Kuehling@amd.com>
From: shaoyunl <shaoyun.liu@amd.com>
Message-ID: <a5e68594-5350-d234-85a9-790364d864ec@amd.com>
Date: Mon, 20 Jan 2020 12:47:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200118013735.19361-3-Felix.Kuehling@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To DM6PR12MB3241.namprd12.prod.outlook.com
 (2603:10b6:5:186::25)
MIME-Version: 1.0
Received: from [10.1.38.28] (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Mon, 20 Jan 2020 17:47:45 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 100cef9f-b1fb-4bde-322e-08d79dd0db45
X-MS-TrafficTypeDiagnostic: DM6PR12MB3883:|DM6PR12MB3883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38836E83F882BFB371D3032CF4320@DM6PR12MB3883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(199004)(189003)(6486002)(956004)(2616005)(36756003)(66556008)(66946007)(5660300002)(66476007)(16526019)(8936002)(31696002)(478600001)(8676002)(86362001)(186003)(53546011)(31686004)(52116002)(26005)(2906002)(81156014)(81166006)(16576012)(316002)(43062003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3883;
 H:DM6PR12MB3241.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+sd6S8OF7Ff4gTHVHm52WMJLX2/hOWJatgq1KAnDIR8Gch8iUBL10qqpBa73cNYOuVjbeeiMIiqpRItnKkhSVzA+Ift08WEGUY/6V/EmUmG99+8qnLpfNAV07N6GnrL6wVjbyLaDVFwQ6NGtBa2HuVyLHrAu3647ieMq+ZrXRk0BLDYMMAg+E58AYLvL7SA1RaPJDZlqeGdgXaFZux8uGtbeJCrbRBsYK9myfRpNN3a6WNLMxR2Yl8XIq/c72XwTyOVOA7P/VWRFjWKw3kvpMxw36A5glY2gUtXw32HAkf1+q6htq/Pm+mD60fEB5f1lrHkjdnpueCoHj0Pk1CnNNKQPE0mcV3RYCqakIlypGWEPR5IRnd7nWFmHdxldLN3yHmQtkmw7chOZcBffF7a1xb9o3kZdzJoK83Wrt+p4sfqwv+O7yvIa8roBk47CEB9Fg1CiRTEfNhViOouaojlPLsuh+hPILnXsnG+2c0NtJu28KaDD2UMipOEQfd+Z7FR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100cef9f-b1fb-4bde-322e-08d79dd0db45
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 17:47:45.5646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lyeQKo0RsoUB8v9iLNyFzBIxkcLalSipv4OUn4dp7rudxC6EhMthmkuSka3kk4BLnoLdaQybVL1MtDY0F0dPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3883
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

Y29tbWVudHMgaW4gbGluZSAuCgpPbiAyMDIwLTAxLTE3IDg6MzcgcC5tLiwgRmVsaXggS3VlaGxp
bmcgd3JvdGU6Cj4gVXNpbmcgYSBoZWF2eS13ZWlnaHQgVExCIGZsdXNoIG9uY2UgaXMgbm90IHN1
ZmZpY2llbnQuIENvbmN1cnJlbnQKPiBtZW1vcnkgYWNjZXNzZXMgaW4gdGhlIHNhbWUgVExCIGNh
Y2hlIGxpbmUgY2FuIHJlLXBvcHVsYXRlIFRMQiBlbnRyaWVzCj4gZnJvbSBzdGFsZSB0ZXh0dXJl
IGNhY2hlIChUQykgZW50cmllcyB3aGlsZSB0aGUgaGVhdnktd2VpZ2h0IFRMQgo+IGZsdXNoIGlz
IGluIHByb2dyZXNzLiBUbyBmaXggdGhpcyByYWNlIGNvbmRpdGlvbiwgcGVyZm9ybSBhbm90aGVy
IFRMQgo+IGZsdXNoIGFmdGVyIHRoZSBoZWF2eS13ZWlnaHQgb25lLCB3aGVuIFRDIGlzIGtub3du
IHRvIGJlIGNsZWFuLgo+Cj4gTW92ZSB0aGUgd29ya2Fyb3VuZCBpbnRvIHRoZSBsb3ctbGV2ZWwg
VExCIGZsdXNoaW5nIGZ1bmN0aW9ucy4gVGhpcyB3YXkKPiB0aGV5IGFwcGx5IHRvIGFtZGdwdSBh
cyB3ZWxsLCBhbmQgS0lRLWJhc2VkIFRMQiBmbHVzaCBvbmx5IG5lZWRzIHRvCj4gc3luY2hyb25p
emUgb25jZS4KPgo+IENDOiBzaGFveXVuLmxpdUBhbWQuY29tCj4gU2lnbmVkLW9mZi1ieTogRmVs
aXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgfCAgNiArLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyAgICAgIHwgNjggKysrKysrKysrKysrKysrKystLS0t
LQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2Zk
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKPiBpbmRleCA4
NjA5Mjg3NjIwZWEuLjUzMjVmNmI0NTVmNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkLmMKPiBAQCAtNjQ3LDEzICs2NDcsOSBAQCBpbnQgYW1kZ3B1X2Ft
ZGtmZF9mbHVzaF9ncHVfdGxiX3ZtaWQoc3RydWN0IGtnZF9kZXYgKmtnZCwgdWludDE2X3Qgdm1p
ZCkKPiAgIGludCBhbWRncHVfYW1ka2ZkX2ZsdXNoX2dwdV90bGJfcGFzaWQoc3RydWN0IGtnZF9k
ZXYgKmtnZCwgdWludDE2X3QgcGFzaWQpCj4gICB7Cj4gICAJc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKilrZ2Q7Cj4gLQl1aW50MzJfdCBmbHVzaF90
eXBlID0gMDsKPiArCWNvbnN0IHVpbnQzMl90IGZsdXNoX3R5cGUgPSAwOwo+ICAgCWJvb2wgYWxs
X2h1YiA9IGZhbHNlOwo+ICAgCj4gLQlpZiAoYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25v
ZGVzICYmCj4gLQkJYWRldi0+YXNpY190eXBlID09IENISVBfVkVHQTIwKQo+IC0JCWZsdXNoX3R5
cGUgPSAyOwo+IC0KPiAgIAlpZiAoYWRldi0+ZmFtaWx5ID09IEFNREdQVV9GQU1JTFlfQUkpCj4g
ICAJCWFsbF9odWIgPSB0cnVlOwo+ICAgCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dtY192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlf
MC5jCj4gaW5kZXggOTAyMTZhYmYxNGE0Li5lMmE1ZTg1MmJkYjAgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiBAQCAtNDc2LDEzICs0NzYsMjYgQEAgc3RhdGljIHZv
aWQgZ21jX3Y5XzBfZmx1c2hfZ3B1X3RsYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWlu
dDMyX3Qgdm1pZCwKPiAgIHsKPiAgIAlib29sIHVzZV9zZW1hcGhvcmUgPSBnbWNfdjlfMF91c2Vf
aW52YWxpZGF0ZV9zZW1hcGhvcmUoYWRldiwgdm1odWIpOwo+ICAgCWNvbnN0IHVuc2lnbmVkIGVu
ZyA9IDE3Owo+IC0JdTMyIGosIGludl9yZXEsIHRtcDsKPiArCXUzMiBqLCBpbnZfcmVxLCBpbnZf
cmVxMiwgdG1wOwo+ICAgCXN0cnVjdCBhbWRncHVfdm1odWIgKmh1YjsKPiAgIAo+ICAgCUJVR19P
Tih2bWh1YiA+PSBhZGV2LT5udW1fdm1odWJzKTsKPiAgIAo+ICAgCWh1YiA9ICZhZGV2LT52bWh1
Ylt2bWh1Yl07Cj4gLQlpbnZfcmVxID0gZ21jX3Y5XzBfZ2V0X2ludmFsaWRhdGVfcmVxKHZtaWQs
IGZsdXNoX3R5cGUpOwo+ICsJaWYgKGFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9ub2RlcyAm
Jgo+ICsJICAgIGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFR0EyMCkgewo+ICsJCS8qIFZlZ2Ey
MCtYR01JIGNhY2hlcyBQVEVzIGluIFRDIGFuZCBUTEIuIEFkZCBhCj4gKwkJICogaGVhdnktd2Vp
Z2h0IFRMQiBmbHVzaCAodHlwZSAyKSwgd2hpY2ggZmx1c2hlcwo+ICsJCSAqIGJvdGguIER1ZSB0
byBhIHJhY2UgY29uZGl0aW9uIHdpdGggY29uY3VycmVudAo+ICsJCSAqIG1lbW9yeSBhY2Nlc3Nl
cyB1c2luZyB0aGUgc2FtZSBUTEIgY2FjaGUgbGluZSwgd2UKPiArCQkgKiBzdGlsbCBuZWVkIGEg
c2Vjb25kIFRMQiBmbHVzaCBhZnRlciB0aGlzLgo+ICsJCSAqLwo+ICsJCWludl9yZXEgPSBnbWNf
djlfMF9nZXRfaW52YWxpZGF0ZV9yZXEodm1pZCwgMik7Cj4gKwkJaW52X3JlcTIgPSBnbWNfdjlf
MF9nZXRfaW52YWxpZGF0ZV9yZXEodm1pZCwgZmx1c2hfdHlwZSk7Cgpbc2hhb3l1bmxdwqAgRm9y
IHRoZSBzZW5kIGludmFsaWRhdGlvbiBpbiB0aGlzIHNpdHVhdGlvbiAsY2FuIHdlIHVzZSAwwqAg
CmZvciB0aGUgZmx1c2ggdHlwZSBkaXJlY3RseSA/IEkgdGhpbmsgbm8gbWF0dGVyIHdoYXQncyB0
aGUgaW5wdXQgCmZsdXNoX3R5cGUgZm9yIHRoaXMgZnVuY3Rpb24gLCBoZWF2eS13ZWlnaHTCoCAr
IGxlZ2FjeSBpbnZhbGlkYXRpb24gCnNob3VsZCBiZSBlbm91Z2ggZm9yIGFsbCBvZiB0aGVtIC4K
Cj4gKwl9IGVsc2Ugewo+ICsJCWludl9yZXEgPSBnbWNfdjlfMF9nZXRfaW52YWxpZGF0ZV9yZXEo
dm1pZCwgZmx1c2hfdHlwZSk7Cj4gKwkJaW52X3JlcTIgPSAwOwo+ICsJfQo+ICAgCj4gICAJLyog
VGhpcyBpcyBuZWNlc3NhcnkgZm9yIGEgSFcgd29ya2Fyb3VuZCB1bmRlciBTUklPViBhcyB3ZWxs
Cj4gICAJICogYXMgR0ZYT0ZGIHVuZGVyIGJhcmUgbWV0YWwKPiBAQCAtNTIxLDIxICs1MzQsMjcg
QEAgc3RhdGljIHZvaWQgZ21jX3Y5XzBfZmx1c2hfZ3B1X3RsYihzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgdWludDMyX3Qgdm1pZCwKPiAgIAkJCURSTV9FUlJPUigiVGltZW91dCB3YWl0aW5n
IGZvciBzZW0gYWNxdWlyZSBpbiBWTSBmbHVzaCFcbiIpOwo+ICAgCX0KPiAgIAo+IC0JV1JFRzMy
X05PX0tJUShodWItPnZtX2ludl9lbmcwX3JlcSArIGVuZywgaW52X3JlcSk7Cj4gKwlkbyB7Cj4g
KwkJV1JFRzMyX05PX0tJUShodWItPnZtX2ludl9lbmcwX3JlcSArIGVuZywgaW52X3JlcSk7Cj4g
ICAKPiAtCS8qCj4gLQkgKiBJc3N1ZSBhIGR1bW15IHJlYWQgdG8gd2FpdCBmb3IgdGhlIEFDSyBy
ZWdpc3RlciB0byBiZSBjbGVhcmVkCj4gLQkgKiB0byBhdm9pZCBhIGZhbHNlIEFDSyBkdWUgdG8g
dGhlIG5ldyBmYXN0IEdSQk0gaW50ZXJmYWNlLgo+IC0JICovCj4gLQlpZiAodm1odWIgPT0gQU1E
R1BVX0dGWEhVQl8wKQo+IC0JCVJSRUczMl9OT19LSVEoaHViLT52bV9pbnZfZW5nMF9yZXEgKyBl
bmcpOwo+ICsJCS8qCj4gKwkJICogSXNzdWUgYSBkdW1teSByZWFkIHRvIHdhaXQgZm9yIHRoZSBB
Q0sgcmVnaXN0ZXIgdG8KPiArCQkgKiBiZSBjbGVhcmVkIHRvIGF2b2lkIGEgZmFsc2UgQUNLIGR1
ZSB0byB0aGUgbmV3IGZhc3QKPiArCQkgKiBHUkJNIGludGVyZmFjZS4KPiArCQkgKi8KPiArCQlp
ZiAodm1odWIgPT0gQU1ER1BVX0dGWEhVQl8wKQo+ICsJCQlSUkVHMzJfTk9fS0lRKGh1Yi0+dm1f
aW52X2VuZzBfcmVxICsgZW5nKTsKPiAgIAo+IC0JZm9yIChqID0gMDsgaiA8IGFkZXYtPnVzZWNf
dGltZW91dDsgaisrKSB7Cj4gLQkJdG1wID0gUlJFRzMyX05PX0tJUShodWItPnZtX2ludl9lbmcw
X2FjayArIGVuZyk7Cj4gLQkJaWYgKHRtcCAmICgxIDw8IHZtaWQpKQo+IC0JCQlicmVhazsKPiAt
CQl1ZGVsYXkoMSk7Cj4gLQl9Cj4gKwkJZm9yIChqID0gMDsgaiA8IGFkZXYtPnVzZWNfdGltZW91
dDsgaisrKSB7Cj4gKwkJCXRtcCA9IFJSRUczMl9OT19LSVEoaHViLT52bV9pbnZfZW5nMF9hY2sg
KyBlbmcpOwo+ICsJCQlpZiAodG1wICYgKDEgPDwgdm1pZCkpCj4gKwkJCQlicmVhazsKPiArCQkJ
dWRlbGF5KDEpOwo+ICsJCX0KPiArCj4gKwkJaW52X3JlcSA9IGludl9yZXEyOwo+ICsJCWludl9y
ZXEyID0gMDsKPiArCX0gd2hpbGUgKGludl9yZXEpOwo+ICAgCj4gICAJLyogVE9ETzogSXQgbmVl
ZHMgdG8gY29udGludWUgd29ya2luZyBvbiBkZWJ1Z2dpbmcgd2l0aCBzZW1hcGhvcmUgZm9yIEdG
WEhVQiBhcyB3ZWxsLiAqLwo+ICAgCWlmICh1c2Vfc2VtYXBob3JlKQo+IEBAIC01NzcsOSArNTk2
LDI2IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfZmx1c2hfZ3B1X3RsYl9wYXNpZChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKPiAgIAkJcmV0dXJuIC1FSU87Cj4gICAKPiAgIAlpZiAocmluZy0+
c2NoZWQucmVhZHkpIHsKPiArCQkvKiBWZWdhMjArWEdNSSBjYWNoZXMgUFRFcyBpbiBUQyBhbmQg
VExCLiBBZGQgYQo+ICsJCSAqIGhlYXZ5LXdlaWdodCBUTEIgZmx1c2ggKHR5cGUgMiksIHdoaWNo
IGZsdXNoZXMKPiArCQkgKiBib3RoLiBEdWUgdG8gYSByYWNlIGNvbmRpdGlvbiB3aXRoIGNvbmN1
cnJlbnQKPiArCQkgKiBtZW1vcnkgYWNjZXNzZXMgdXNpbmcgdGhlIHNhbWUgVExCIGNhY2hlIGxp
bmUsIHdlCj4gKwkJICogc3RpbGwgbmVlZCBhIHNlY29uZCBUTEIgZmx1c2ggYWZ0ZXIgdGhpcy4K
PiArCQkgKi8KPiArCQlib29sIHZlZ2EyMF94Z21pX3dhID0gKGFkZXYtPmdtYy54Z21pLm51bV9w
aHlzaWNhbF9ub2RlcyAmJgo+ICsJCQkJICAgICAgIGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZF
R0EyMCk7Cj4gKwkJLyogMiBkd29yZHMgZmx1c2ggKyA4IGR3b3JkcyBmZW5jZSAqLwo+ICsJCXVu
c2lnbmVkIGludCBuZHcgPSBraXEtPnBtZi0+aW52YWxpZGF0ZV90bGJzX3NpemUgKyA4Owo+ICsK
PiArCQlpZiAodmVnYTIwX3hnbWlfd2EpCj4gKwkJCW5kdyArPSBraXEtPnBtZi0+aW52YWxpZGF0
ZV90bGJzX3NpemU7Cj4gKwo+ICAgCQlzcGluX2xvY2soJmFkZXYtPmdmeC5raXEucmluZ19sb2Nr
KTsKPiAgIAkJLyogMiBkd29yZHMgZmx1c2ggKyA4IGR3b3JkcyBmZW5jZSAqLwo+IC0JCWFtZGdw
dV9yaW5nX2FsbG9jKHJpbmcsIGtpcS0+cG1mLT5pbnZhbGlkYXRlX3RsYnNfc2l6ZSArIDgpOwo+
ICsJCWFtZGdwdV9yaW5nX2FsbG9jKHJpbmcsIG5kdyk7Cj4gKwkJaWYgKHZlZ2EyMF94Z21pX3dh
KQo+ICsJCQlraXEtPnBtZi0+a2lxX2ludmFsaWRhdGVfdGxicyhyaW5nLAo+ICsJCQkJCQkgICAg
ICBwYXNpZCwgMiwgYWxsX2h1Yik7Cj4gICAJCWtpcS0+cG1mLT5raXFfaW52YWxpZGF0ZV90bGJz
KHJpbmcsCj4gICAJCQkJCXBhc2lkLCBmbHVzaF90eXBlLCBhbGxfaHViKTsKPiAgIAkJYW1kZ3B1
X2ZlbmNlX2VtaXRfcG9sbGluZyhyaW5nLCAmc2VxKTsKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
