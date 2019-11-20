Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF23C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 01:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D896223B0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 01:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D896223B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52AA6E3F0;
	Wed, 20 Nov 2019 01:52:36 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760052.outbound.protection.outlook.com [40.107.76.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 844356E3F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 01:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ge9nK8sQwjRJ8xO1O750SKZy/m5NN7PWC4ELfY+XYlUlpTMvXovDSohUALpgbLPmJ10iyK6WbxFnyuy6ck7vSyZz26ennmXS8CYAApQwsCB7/90g+n/+pDOB8s4FksvdZAy6PWBDxEl18qudoO8l9xfhkwR+N7SYdIuYDXxS2BAB5cGN+i49W6e4BC+G88Pc4o4+IVilyFszsAgyJbNbAaGjw2YFuNzuMkp14icFkUwGLPjPNJeT+oZkAcKbp00LLE+9MjNTD5GCJ14TfscIN54iEbcCU78wy+5NcEU1YKjQIq+VV0UX86vMQJWwfQNG1kucUzsMUzMdP9Uxvs4BFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vs/14N0ZypDHE6rnnQK+7Obl+1LyAaY6nsVoUom14pA=;
 b=T7MITB2l7kO+FG3niO6xmyxSalUOCWv3AeqTOonu+cGjCHFmv1QxxRiMLBhJabDvhEM+3+oxQyUUMl1Fh3hPcVBioS8tcEqBymB/kqq3TR5GqzIErXsH4cgI8ztfHY9O4MzIL/m4iLQbJgJWgXa8uOFerx16BkrmfC5m0JH3dr7ao0hqZnoYY73Lg27APk7+xHTJUYLKimUbFMGnzMygRAbXTdwDRkiIMmM2ByFLh9VLPn5BfvgWAkDeYiNDkEYXNgOwYLyw0dk6okRjgHiSOsmczimD4R9AExxKnGBHehzmbl8yboM/bQvf8vQ0NxV7WBgHzZz1Hn8WxzFyrqUQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN8PR12MB3348.namprd12.prod.outlook.com (20.178.211.221) by
 BN8PR12MB3521.namprd12.prod.outlook.com (20.179.65.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Wed, 20 Nov 2019 01:52:33 +0000
Received: from BN8PR12MB3348.namprd12.prod.outlook.com
 ([fe80::a158:1dcd:18f4:8b81]) by BN8PR12MB3348.namprd12.prod.outlook.com
 ([fe80::a158:1dcd:18f4:8b81%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 01:52:32 +0000
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
To: Aaron Liu <aaron.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <6cba1e53-1c0d-d408-4d16-cae93ec9e62e@amd.com>
Date: Tue, 19 Nov 2019 20:52:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::19) To BN8PR12MB3348.namprd12.prod.outlook.com
 (2603:10b6:408:47::29)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22d68711-f24c-4878-642e-08d76d5c4ed9
X-MS-TrafficTypeDiagnostic: BN8PR12MB3521:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB352132B4E886AB198C60F45C994F0@BN8PR12MB3521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(47776003)(305945005)(31696002)(7736002)(50466002)(58126008)(478600001)(316002)(6486002)(6436002)(3846002)(14444005)(6512007)(229853002)(31686004)(6246003)(2906002)(230700001)(6116002)(446003)(11346002)(44832011)(2616005)(476003)(36756003)(386003)(6506007)(53546011)(186003)(26005)(486006)(99286004)(23676004)(66476007)(66556008)(4326008)(14454004)(52116002)(66946007)(76176011)(2486003)(65806001)(81156014)(5660300002)(81166006)(86362001)(8936002)(8676002)(25786009)(65956001)(66066001)(4001150100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3521;
 H:BN8PR12MB3348.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBNdUtPWS3lDj3rQ+3YVbnSP3Eckm53qDgtJcWBaG9omzadB7x0S0a1WsJz/7k3/IiGQ3tJW1HDe/MpjEJQ+9khYrMx0WsMPzjt4aksOSLuhUQkIPMNkQYao9Sht9lBP/s/gLFA3SC5zhIPxPoBIERoSWOncuoZM7oi2sY3SeBjNgXNgeoQXaK/qgzfOaYZed4BcqyqoY1CFcBLHWFTOjHFlW1e91xoWWf4jzbMeX/6/e8JBF+D8e2kuxWqJd7RtyWDm7ewWVwvNFbr2p0QSk+G/L+cs2P0+MFpreFmzDbyXAwl2WZFp5/j2zxt41K4XId1CHsMgk9T9gNoEuQiBxj/4dFo3sUXgwNyAuijpn14cbfaY7Jz2q96nvVMlOLFRyoUEZmqswCz7eNfjg4tOyjHyaJKAizPTPMIkPOZc3h1KfEgMlKxQ+9gARKCO27dZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d68711-f24c-4878-642e-08d76d5c4ed9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 01:52:32.5761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlOe57zwenPAjwISmA9WeryJUtXeNiZVMWJu/anVWiRc5OUDHCIuS2/jXzbafLtG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3521
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vs/14N0ZypDHE6rnnQK+7Obl+1LyAaY6nsVoUom14pA=;
 b=P7FCQ5sMTnRnsJqzo4WGGanOkmQWU7rTC6bv1nANrcsmze8/OaChu+NUJ77ds1mbe/FNdLytb0LOWg+QcdXu2dtzIFIOZ8YDQE+16qAmgaM4oU+yQxzFoFhQBXBNpc5zX08xnOoqYh/XQvpz+ovftzJO61+IcLfyPpKTC9Xmiho=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alexander.Deucher@amd.com, Marek.Olsak@amd.com, Ray.Huang@amd.com,
 Leo.Liu@amd.com, Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120015230.__8cgcPUNgC4Vv3jKzgaKyHB6qeR2xzT2XwBB1y6-BA@z>

T24gMjAxOS0xMS0xNCAxMDozNCBwLm0uLCBBYXJvbiBMaXUgd3JvdGU6Cj4gRnJvbTogSHVhbmcg
UnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPiAKPiBUbyBhbGlnbiB0aGUga2VybmVsIHVhcGkgY2hh
bmdlIGZyb20gQWxleDoKPiAKPiAiQWRkIGEgZmxhZyB0byB0aGUgR0VNX0NSRUFURSBpb2N0bCB0
byBjcmVhdGUgZW5jcnlwdGVkIGJ1ZmZlcnMuIEJ1ZmZlcnMgd2l0aAo+IHRoaXMgZmxhZyBzZXQg
d2lsbCBiZSBjcmVhdGVkIHdpdGggdGhlIFRNWiBiaXQgc2V0IGluIHRoZSBQVEVzIG9yIGVuZ2lu
ZXMKPiBhY2Nlc3NpbmcgdGhlbS4gVGhpcyBpcyByZXF1aXJlZCBpbiBvcmRlciB0byBwcm9wZXJs
eSBhY2Nlc3MgdGhlIGRhdGEgZnJvbSB0aGUKPiBlbmdpbmVzLiIKPiAKPiBXZSB3aWxsIHVzZSBH
RU1fQ1JFQVRFX0VOQ1JZUFRFRCBmbGFnIGZvciBzZWN1cmUgYnVmZmVyIGFsbG9jYXRpb24uCj4g
Cj4gU2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPiBSZXZpZXdl
ZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IC0tLQo+ICBp
bmNsdWRlL2RybS9hbWRncHVfZHJtLmggfCA1ICsrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oIGIv
aW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oCj4gaW5kZXggNWMyOGFhNy4uMWE5NWUzNyAxMDA2NDQK
PiAtLS0gYS9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmgKPiArKysgYi9pbmNsdWRlL2RybS9hbWRn
cHVfZHJtLmgKPiBAQCAtMTQxLDYgKzE0MSwxMSBAQCBleHRlcm4gIkMiIHsKPiAgICogcmVsZWFz
aW5nIHRoZSBtZW1vcnkKPiAgICovCj4gICNkZWZpbmUgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9X
SVBFX09OX1JFTEVBU0UJKDEgPDwgOSkKPiArLyogRmxhZyB0aGF0IEJPIHdpbGwgYmUgZW5jcnlw
dGVkIGFuZCB0aGF0IHRoZSBUTVogYml0IHNob3VsZCBiZQo+ICsgKiBzZXQgaW4gdGhlIFBURXMg
d2hlbiBtYXBwaW5nIHRoaXMgYnVmZmVyIHZpYSBHUFVWTSBvcgo+ICsgKiBhY2Nlc3NpbmcgaXQg
d2l0aCB2YXJpb3VzIGh3IGJsb2Nrcwo+ICsgKi8KPiArI2RlZmluZSBBTURHUFVfR0VNX0NSRUFU
RV9FTkNSWVBURUQJCSgxIDw8IDEwKQoKU3R5bGUhClRBQiBjaGFyPyEKCllvdSBoYXZlIGEgVEFC
IGNoYXIgYmV0d2VlbiAiLi5fRU5DUllQVEVEIiBhbmQgIigxIDw8IDEwKSIKRG8gTk9UIGFkZC9p
bnNlcnQgVEFCIGNoYXJzIGluc3RlYWQgb2Ygc3BhY2UgdG8gYWxpZ24gY29sdW5tbnMhCklmIHdo
ZW4geW91IHByZXNzIFRhYiBrZXkgYSB0YWIgaXMgaW5zZXJ0ZWQsIGFzIG9wcG9zZWQgdG8gdGhl
IGxpbmUKaW5kZW50ZWQsIHRoZW4gRE8gTk9UIHVzZSB0aGlzIGVkaXRvci4KVGhlIFRhYiBrZXkg
c2hvdWxkICJpbmRlbnQgYWNjb3JkaW5nIHRvIG1vZGUiIGJ5IGluc2VydGluZyBUQUIgY2hhcnMu
CklmIHRoZSBsaW5lIGlzIGFscmVhZHkgaW5kZW50ZWQsIGFzIHRoaXMgb25lIGlzLCB0aGVuIGl0
IHNob3VsZCBkbyBub3RoaW5nLgoKRG9uJ3QgYnVuY2ggdXAgZGVmaW5pdGlvbnMgdG9nZXRoZXIs
IG5vciB0aGVpciBjb21tZW50cy4KWW91IG5lZWQgYW4gZW1wdHkgbGluZSBhZnRlciAjZGVmaW5l
IGFuZCBiZWZvcmUgLyogRmxhZyB0aGF0IC4uLiAqLwoKSW4gY29tbWVudHMgcGxlYXNlIHVzZSBw
cmVzZW50IHRlbnNlLCBub3QgZnV0dXJlIHRlbnNlIQoKVGhlIGNvbW1lbnQgY2FuIGJlIGltcHJv
dmVkIGxpa2U6CgovKiBJbmRpY2F0ZXMgdGhhdCB0aGUgQk8gaXMgZW5jcnlwdGVkLiBUaGlzIHdp
bGwgc2V0IHRoZSBUTVoKICogYml0IGluIFBURXMgd2hlbiBtYXBwaW5nIHRoaXMgYnVmZmVyLgog
Ki8KI2RlZmluZSBBTURHUFVfR0VNX0NSRUFURV9FTkNSWVBURUQKClJlZ2FyZHMsCkx1YmVuCgo+
ICAKPiAgLyogSHlicmlkIHNwZWNpZmljICovCj4gIC8qIEZsYWcgdGhhdCB0aGUgbWVtb3J5IGFs
bG9jYXRpb24gc2hvdWxkIGJlIGZyb20gdG9wIG9mIGRvbWFpbiAqLwo+IAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
