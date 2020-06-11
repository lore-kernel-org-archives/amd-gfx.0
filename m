Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5210C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 20:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5291C20720
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 20:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lcLnVXF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5291C20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F17C76E93C;
	Thu, 11 Jun 2020 20:23:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE566E93C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 20:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VP8jpFnCQGOqSH8iNuIelvYDRgW7tLdOl5AaFwjuJNJFkdeJc0ePeQ4slSaaOsPXh9cL4kolBpUIM7GskQtLeR5+DixehgeqWrpBNzj6lZ98g9C1zK96zl1yF5rnI0u/Kygbs9hxFCmw7QzT6EGK4VbNb4XPsIK+tMABAdxAykM5ktP2bnJneHKOIWuuMVeVty4VxHl3iJTnnl0kefGkSmE5MfeTCsa85vXF93j3IhGCCFcS1FQaesQvV/Ig609umtmz4mJhygQsdf7GiJRxlSVBfIdF7QklpVfVRbKzP9VzHAMWgjrTZh84EcVYFk9uTNdL2Q9YrmGaqtrkOu1O9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbnvum1OURBuvLc2Tx8O0JtSmQqdqNuKwAw4NEIOXKg=;
 b=LCcXdMXg529sL6cdWoaOqIOUA4B0zk5tjLihjunqSBIf1Mu0icv5BCud0ElwM1+d/0+F5DdBlzV10GuYdXsk/o6AW7gPxlqHgRD2RtHZQRx9UgRF7UOCkJ7MiXrcsMWpk/jQZHxdoUX6d1zQCoen+obB2GKYOxrvo7IPnnK6y+DuLxu+rlF9FtWLqK81oSKT1/4XeTuBTtioBFAJp53X00n92HDrGmpF3Dlc1UyexAhQD+ZDY1TWbmhG9b5rd7VrjZhWem051DTOihL11Kmi6GfJQR3ZAAq1dF3aNDE5SrIPAkrwBkgzsXf/KANxq58/cAM0i+stfqzAaLvx9tUi+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbnvum1OURBuvLc2Tx8O0JtSmQqdqNuKwAw4NEIOXKg=;
 b=lcLnVXF959VrjgwnqFmP05EmOiaRXIF1EhYa65LeMoytKPxdgeUKvHQsXcjIzXl/pF/NkfZO7yLNpbgqA7v3cQe+QXC9/XwvmxvTVLi8H1Irm1aKCqR4d1s7To8s4od2ddGlPFaCu+y96YtG6Eter8/D+35zhWKOAh+TwpBKyOI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Thu, 11 Jun
 2020 20:23:13 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3088.021; Thu, 11 Jun 2020
 20:23:13 +0000
Subject: Re: [PATCH] drm/amdkfd: Use correct major in devcgroup check
To: Lorenz Brun <lorenz@brun.one>, amd-gfx@lists.freedesktop.org,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20200611201121.317165-1-lorenz@brun.one>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <5d245481-8e61-11dc-50d1-802c060450bc@amd.com>
Date: Thu, 11 Jun 2020 16:23:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200611201121.317165-1-lorenz@brun.one>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::32) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YT1PR01CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Thu, 11 Jun 2020 20:23:12 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c3b67b26-29e3-4e09-b036-08d80e4543e0
X-MS-TrafficTypeDiagnostic: SA0PR12MB4575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4575A9F81F3C067BF2FC1A8292800@SA0PR12MB4575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byUo9RuALz2z8wDorKfGHD7MmkVY0uXGn/KnpvsNPT/y8pEdxyRsZ7F5VUCIZhgaYSuTk80AsYbPDmijafuJkgwnsoEMNxYVQGIAggoADohSFye6wWOrZmlymYqRYTehygjnhsPo+Q40alOL/fts2EiVMMRl41IbSu9ShtCLtU3sefRCbrNT+PEeAi6l1uEVi+hUkHktkM/Ipr12yQWQt+COc4wl6KSKXGVE2MTB+3XPE9A1pGgxW1cLseGRZbVVjC2okCSssC3jTFPQATKsvokhgSIda5aSE91aQjhTU4JJf5LtwSKdWGuBvEboTPwIfJcc/pikcLF/oEDMclq+OFXdfkQC0XXtt9hiNhydGVYtKuZd9GfwTdJ/zV3tC39x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(8676002)(316002)(16576012)(8936002)(5660300002)(83380400001)(110136005)(36756003)(66946007)(66556008)(66476007)(31696002)(6486002)(26005)(186003)(478600001)(52116002)(16526019)(956004)(2616005)(6636002)(31686004)(44832011)(2906002)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1J5fBD3MZD9sBJ3VYAFu01jhgSk5n5SaCn+7IsKH4PHSYFsrDijaEm+UuuxQ4ERA51yxPA0z9Iace6YzytGE02IMkSveeFiIHsCSyUCeVSS7N0j7fE39jrhrX4mAybpxTEtONtMA9CH4aINxm3c0xny/MHbvEHa7aYVZu9Mrx8UKmoLJjF69k7zLLrTZS5x5SyQV++jRXLqlI2ROzh1WFsHQb8UIgHPD4Tdhx14Dq+p3I3/ytSL281f9XfX3vBmBVzAwkfAbNx59WTKtc7E79peHlRqzaT9QHPHLzl3vTMaGSctx+D+2yZs4QQ/yb6OnERIcTRsJ7eZvSGnxRdju5IMuqsZs1CZGF+eU1j8zmMxscAS1Q2hX/lBqCvdMjE9jS9vU3sAKMZ+MwLXJ0Qyyvj2RTmRyJKhIRTThw79KWBY2puaUOA26Er1ytQjV79jNI6JdoxPjm6Rza236CKf3DcYMqN22Lh6X22CNTdNqcMo0wPVgxL8dwiug+imaNU7x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b67b26-29e3-4e09-b036-08d80e4543e0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 20:23:12.9494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJeyh4qlQOJyr5VUEuO9//aKvZlihFJxPAEXh/7Ym6f7i4CA9OMUVyI8JzCsacpBHtccdCBRwipxxPavvaMtnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
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

QW0gMjAyMC0wNi0xMSB1bSA0OjExIHAubS4gc2NocmllYiBMb3JlbnogQnJ1bjoKPiBUaGUgZXhp
c3RpbmcgY29kZSB1c2VkIHRoZSBtYWpvciB2ZXJzaW9uIG51bWJlciBvZiB0aGUgRFJNIGRyaXZl
cgo+IGluc3RlYWQgb2YgdGhlIGRldmljZSBtYWpvciBudW1iZXIgb2YgdGhlIERSTSBzdWJzeXN0
ZW0gZm9yCj4gdmFsaWRhdGluZyBhY2Nlc3MgZm9yIGEgZGV2aWNlcyBjZ3JvdXAuCj4KPiBUaGlz
IG1lYW50IHRoYXQgYWNjZXNzZXMgYWxsb3dlZCBieSB0aGUgZGV2aWNlcyBjZ3JvdXAgd2VyZW4n
dAo+IHBlcm1pdHRlZCBhbmQgY2VydGFpbiBhY2Nlc3NlcyBkZW5pZWQgYnkgdGhlIGRldmljZXMg
Y2dyb3VwIHdlcmUKPiBwZXJtaXR0ZWQgKGlmIHRoZXkgbWF0Y2hlZCB0aGUgd3JvbmcgbWFqb3Ig
ZGV2aWNlIG51bWJlcikuCj4KPiBTaWduZWQtb2ZmLWJ5OiBMb3JlbnogQnJ1biA8bG9yZW56QGJy
dW4ub25lPgoKUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQu
Y29tPgoKVGhhbmtzIGZvciB0aGlzIGZpeC4gSSB3aWxsIGFwcGx5IGl0IHRvIG91ciBhbWQtc3Rh
Z2luZy1kcm0tbmV4dCBicmFuY2guCgpSZWdhcmRzLArCoCBGZWxpeAoKCj4gRml4ZXM6IDZiODU1
ZjdiODNkMmYgKCJkcm0vYW1ka2ZkOiBDaGVjayBhZ2FpbnN0IGRldmljZSBjZ3JvdXAiKQo+IC0t
LQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oIHwgMyArKy0KPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oCj4gaW5kZXggZjA1ODdkOTQyOTRkLi5mZWU2MDkyMWZj
Y2YgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaAo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgKPiBAQCAtNDAsNiAr
NDAsNyBAQAo+ICAjaW5jbHVkZSA8ZHJtL2RybV9maWxlLmg+Cj4gICNpbmNsdWRlIDxkcm0vZHJt
X2Rydi5oPgo+ICAjaW5jbHVkZSA8ZHJtL2RybV9kZXZpY2UuaD4KPiArI2luY2x1ZGUgPGRybS9k
cm1faW9jdGwuaD4KPiAgI2luY2x1ZGUgPGtnZF9rZmRfaW50ZXJmYWNlLmg+Cj4gICNpbmNsdWRl
IDxsaW51eC9zd2FwLmg+Cj4gIAo+IEBAIC0xMDc2LDcgKzEwNzcsNyBAQCBzdGF0aWMgaW5saW5l
IGludCBrZmRfZGV2Y2dyb3VwX2NoZWNrX3Blcm1pc3Npb24oc3RydWN0IGtmZF9kZXYgKmtmZCkK
PiAgI2lmIGRlZmluZWQoQ09ORklHX0NHUk9VUF9ERVZJQ0UpIHx8IGRlZmluZWQoQ09ORklHX0NH
Uk9VUF9CUEYpCj4gIAlzdHJ1Y3QgZHJtX2RldmljZSAqZGRldiA9IGtmZC0+ZGRldjsKPiAgCj4g
LQlyZXR1cm4gZGV2Y2dyb3VwX2NoZWNrX3Blcm1pc3Npb24oREVWQ0dfREVWX0NIQVIsIGRkZXYt
PmRyaXZlci0+bWFqb3IsCj4gKwlyZXR1cm4gZGV2Y2dyb3VwX2NoZWNrX3Blcm1pc3Npb24oREVW
Q0dfREVWX0NIQVIsIERSTV9NQUpPUiwKPiAgCQkJCQkgIGRkZXYtPnJlbmRlci0+aW5kZXgsCj4g
IAkJCQkJICBERVZDR19BQ0NfV1JJVEUgfCBERVZDR19BQ0NfUkVBRCk7Cj4gICNlbHNlCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
