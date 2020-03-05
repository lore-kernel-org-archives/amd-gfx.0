Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2044DC3F2D2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 16:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66C72073B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 16:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N/IAE2ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66C72073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46BB6EBDF;
	Thu,  5 Mar 2020 16:06:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 726AC6EBDF
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 16:06:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYWzqYeRfjvK+dR6LPt2WYJfXN6AwRdk2TiPFDTYuXtYf5Tg8G7jpgyp8Z3MzhI0zslX/9TyiPrrkXcmUEWXICX7jjmzpnODGoSrxosLMO5zBaohzKj5Mg0AcAcRj53Fgq6AhMD4bkMRk3EajJW4sw9XiAkRMFtvQNT2Oni6Y/2rgnind+LNA5LiYtDXiZoiBiLqAFYi9V2cZwndaKsvPVgOF0GbADj5fBhciw4TjJYRFu0dZqVUyhajrWxglOBqT38gh+nk2+LXiaxBpPnHSNUuZbVHj+ZqwYNml9270MHqEcIY+1Hfz93ZFLNqNanNyeFBSFLnkwvENd8oh1sNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnZx92FbjM/RrteTTYOzrKXkIklQnDpS9eInprmdfh8=;
 b=Jd+ZONZksEAY0EttgBJsfdg8UiN19MuUsShKMr7m4pKPb/QritCZeozNoavrT1f1asQ3y5g9jHQxfgwNPLQottSLX73HHlKOx19sJuMKylyUsDfeLMK7zuryh8Dy7GVc1U/2ZyTNRb1WdGFygSZWYnxTMtOEheXJ3ZRbutL9PNBbuJ6FY9t/G5TqlFKm39lwHeXb3GDKzOl1MVu0Eruy/EUdtWW5dE926GTFyJuHxWfVuu2D7x2bH40konMrlVkHpZyBvCDdm0JA9H7mJS0HnRLgH3aT4X/JWnukMvuIeocqd7HNGnmRMI+7l+plL2apfVyTd6b1jnrhfkAglKUqeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnZx92FbjM/RrteTTYOzrKXkIklQnDpS9eInprmdfh8=;
 b=N/IAE2haWwH9FZ5XjD0od+nxYEeXrnboqw7KKPpRjJ5mTJjgCVDM718cgZ3gvd+U0WouoN3HDxgFTJwTTlsdWnGa8WEX8eDHLj30Xx3F4NJFKo3hnH8Jk7tVExmnBpnWsytvVw9PUO1gRQQo4cwBd+OBoe9C0HjFO4jofJEWa3A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5PR1201MB0155.namprd12.prod.outlook.com (2603:10b6:4:55::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Thu, 5 Mar
 2020 16:06:30 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 16:06:30 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: Signal eviction fence on process
 destruction (v2)
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20200304210637.27283-3-Felix.Kuehling@amd.com>
 <20200304215023.11551-1-Felix.Kuehling@amd.com>
 <72EFF772-7B30-4BCC-8DC5-E985100C31B8@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <53154a08-d2a0-3460-6ef6-b80a2226160b@amd.com>
Date: Thu, 5 Mar 2020 11:06:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <72EFF772-7B30-4BCC-8DC5-E985100C31B8@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::16) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YTOPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Thu, 5 Mar 2020 16:06:29 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be422caf-4d2b-43fb-56fb-08d7c11f2aa6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0155:|DM5PR1201MB0155:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01559ECB034183892CF30C0392E20@DM5PR1201MB0155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(189003)(199004)(31696002)(31686004)(52116002)(37006003)(36916002)(86362001)(53546011)(54906003)(8936002)(44832011)(16576012)(8676002)(81156014)(6636002)(81166006)(316002)(2906002)(5660300002)(186003)(66946007)(16526019)(36756003)(956004)(2616005)(66556008)(66476007)(26005)(478600001)(4326008)(6486002)(6862004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0155;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: inRUR4JEmBpNk+MIZzzgVdgIUA+3ybitAR68MwZSSsh75QT93xdd1yoE9kpndrcjBK1h3OeNDc0KJlGjY6hLHvNJf0ZaqRGEGd7BBnrqhcVu1nb+K/40NMlVLYoTQpBeEWcY8gUyA8B1wwSbRqnpQOPNtwRoatAiP5rLNLXVN6jYXp3wJISuwNvy/pLTAw7yWdtcWimU14+NXYj1gNgDgATgkOP31c3mEs2Zd3BGqjFLjaBb8PMIJguXhTGNdGBIaWDowrtjdZstBpYlGtN7jTlWjNpkBjh8i4TxwP1vCGddlSaC3PchujF4CIZ01A3CjdAwgMBPpiPa9Ror5Di4HzrIYGj+vmxT82Qe9HOYp8WOAQXip+bBpr9YsHRSztvIejVlwcsqBXS8Ld0nscfIcqaygAnzX28rALcJrfGAehytRwg0jromBNXCBB4J4nLa
X-MS-Exchange-AntiSpam-MessageData: GkBtkRmEktcYogxedpIXwinNX/EXaj2fqlwYmQC/Ou3DA1CQ1BPrcs7844jE1QMm9o1ystVglAelxbfMGaw6NQLmxBu6AUblCTUObRxAVJj4Rp2FnnrdsXSCR+lIKgR7TNibMKUKWpzGqe+b2fyyGg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be422caf-4d2b-43fb-56fb-08d7c11f2aa6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 16:06:30.2194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rvqEwwBu7iK1xXtLctH6kaecOWZMtwYwffeq5IFqQggZ1XUBOHH9NZwt2Ha2wYZmuqRkVzWDW84A1Ay5Zx4AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0155
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W21vdmluZyB0byBwdWJsaWMgbWFpbGluZyBsaXN0XQoKVGhhbmsgeW91LiBJJ2xsIGFsc28gYXBw
bHkgcGF0Y2ggMi8yIHRvIGFtZC1zdGFnaW5nLWRybS1uZXh0LiBJdCdzIG5vdCAKZml4aW5nIGEg
bWVtb3J5IGxlYWsgdGhlcmUsIGJ1dCBpdCBzaG91bGQgbWFrZSBjbGVhbnVwIGFmdGVyIHByb2Nl
c3MgCnRlcm1pbmF0aW9uIG1vcmUgZWZmaWNpZW50IGJ5IGF2b2lkaW5nIGRlbGF5ZWQgZGVsZXRl
IG9mIEJPcy4KClJlZ2FyZHMsCiDCoCBGZWxpeAoKT24gMjAyMC0wMy0wNCAxMDo0NiBwLm0uLCBQ
YW4sIFhpbmh1aSB3cm90ZToKPiBTZXJpZXMgaXMgUmV2aWV3ZWQtYnk6IHhpbmh1aSBwYW4gPHhp
bmh1aS5wYW5AYW1kLmNvbT4KPgo+PiAyMDIw5bm0M+aciDXml6UgMDU6NTDvvIxLdWVobGluZywg
RmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+IOWGmemBk++8mgo+Pgo+PiBPdGhlcndpc2Ug
Qk9zIG1heSB3YWl0IGZvciB0aGUgZmVuY2UgaW5kZWZpbml0ZWx5IGFuZCBuZXZlciBiZSBkZXN0
cm95ZWQuCj4+Cj4+IHYyOiBTaWduYWwgdGhlIGZlbmNlIHJpZ2h0IGFmdGVyIGRlc3Ryb3lpbmcg
cXVldWVzIHRvIGF2b2lkIHVubmVjZXNzYXJ5Cj4+ICAgICBkZWxheWUtZGVsZXRlIGluIGtmZF9w
cm9jZXNzX3dxX3JlbGVhc2UKPj4KPj4gU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZl
bGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4+IC0tLQo+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfcHJvY2Vzcy5jIHwgNSArKysrKwo+PiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJv
Y2Vzcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwo+PiBpbmRl
eCBkNWQ0NjYwMjIxYWYuLjI2ZjdmMTc4YjY2ZCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4+IEBAIC02MjUsNiArNjI1LDExIEBAIHN0YXRpYyB2b2lk
IGtmZF9wcm9jZXNzX25vdGlmaWVyX3JlbGVhc2Uoc3RydWN0IG1tdV9ub3RpZmllciAqbW4sCj4+
Cj4+IAkvKiBJbmRpY2F0ZSB0byBvdGhlciB1c2VycyB0aGF0IE1NIGlzIG5vIGxvbmdlciB2YWxp
ZCAqLwo+PiAJcC0+bW0gPSBOVUxMOwo+PiArCS8qIFNpZ25hbCB0aGUgZXZpY3Rpb24gZmVuY2Ug
YWZ0ZXIgdXNlciBtb2RlIHF1ZXVlcyBhcmUKPj4gKwkgKiBkZXN0cm95ZWQuIFRoaXMgYWxsb3dz
IGFueSBCT3MgdG8gYmUgZnJlZWQgd2l0aG91dAo+PiArCSAqIHRyaWdnZXJpbmcgcG9pbnRsZXNz
IGV2aWN0aW9ucyBvciB3YWl0aW5nIGZvciBmZW5jZXMuCj4+ICsJICovCj4+ICsJZG1hX2ZlbmNl
X3NpZ25hbChwLT5lZik7Cj4+Cj4+IAltdXRleF91bmxvY2soJnAtPm11dGV4KTsKPj4KPj4gLS0g
Cj4+IDIuMjUuMQo+PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
