Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA69C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 17:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC4120801
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 17:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC4120801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAADC6F8BC;
	Thu,  5 Dec 2019 17:09:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770051.outbound.protection.outlook.com [40.107.77.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D16B96E14B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 17:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/M1Y9KhN5ZEb7Y2gCP9V9agH75vxu92QekjsqenU7w9I4ZTQ8HTJ39pePMvUfIwzM7e30mLLJkHgtUeIad2svkGMPzCBYuEQbccSfQ144SZSjjwxQ+wCNuEsWmotto3FUQJxPPgAf/p5blqlS3jGbC/CeC7AR3NddgEbvBOjTb3UcWF2At7YnCDSEVCuxFBlypKT4SY+eyO0X+r5V/YSPABwm/CPJPJEH6ruPQYOz7pQYl8W/BI+L9slNBu+o9BuQrpzP5fKcP9zWsi9Ll5fpMBfq0M6ypBe2P35OhePRefGBTYRgBQwkhUM8nO4S7VVRlMbMGmyeOvIbTaDVJ6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhRRl84bqe86FeOV77uLFRbYm86eJk7AH4sqRfi96QU=;
 b=bJ7AsqCsgMRYC73xbkT5P6/SIDwL3VESsk/yWfJyYtPvj7x8zlg6x71wsFgLz6xMj5vJCVmi3dLXhND7HxD3b/dNQC9d8k8NpsHKRiJYZGICaoIXw5Tv+1ydnPbNfVlY3LrN1PGuk2TYRWzVnWwUeovhHKjoDQljRABsJvEnl98giO6S+3eMeOdQt+iiA87t1k8TfcpqmmaYm+iVhLrYioKhEA4XSqBw+hY/gft5kMOzq/+7nfJpdjL3LN8bqtPogAJ7RHZN4b6wZIayvhWT+/zzFVMgUjbM3XtXtYnpYDVyGFt2jksUS4ighW91hFAsInawfNf8DU4RWCH9i4JaYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2358.namprd12.prod.outlook.com (52.132.140.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 5 Dec 2019 17:09:43 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2495.026; Thu, 5 Dec 2019
 17:09:43 +0000
Subject: Re: reserving VRAM for page tables
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <aeb00323-d755-da07-e658-c9a5f5877aaa@amd.com>
 <daa521c7-a844-4d4c-a12f-11efa6f7d2bd@amd.com>
 <383e2b8f-0e6f-434d-c7af-cd60bc1ad216@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b3687b36-1d2b-75a6-8645-70b0768db068@amd.com>
Date: Thu, 5 Dec 2019 18:09:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <383e2b8f-0e6f-434d-c7af-cd60bc1ad216@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::18) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 098643fb-c982-4a43-e5e6-08d779a5ec14
X-MS-TrafficTypeDiagnostic: DM5PR12MB2358:|DM5PR12MB2358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23586FCC93D36DE9EC34A98A835C0@DM5PR12MB2358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02426D11FE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(199004)(189003)(6486002)(6506007)(2906002)(186003)(14454004)(53546011)(5660300002)(31686004)(305945005)(25786009)(316002)(99286004)(86362001)(6512007)(36756003)(81166006)(8936002)(8676002)(31696002)(65956001)(58126008)(110136005)(2870700001)(66946007)(66556008)(66476007)(76176011)(81156014)(478600001)(23676004)(229853002)(50466002)(6666004)(11346002)(2616005)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2358;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: taOGXXMcPXOBbFKl0YbKp/JjtMqwKhdP331mzcQija/saV8JMnpSpI73WBLM/B20ugDvnImCJl3nhKX8JQE3wdau+rZ18KW5cw6LnmNR3Nyx6pcME8R1LUoC1bl9JGkO6TpA9EwcZsZMzLx4/dq06CxKbpRc2g8zv6DtGnKanqWEfJI6xe36SUJJ3glyMETAym7vqLBSStJpKpW7ii6sQpxn6gL9n35+Mvty1ZlTNrEvi7yM0Tjpo0xikBWU0ogSZLGFM5tGWq3o2CbuP7IuVlVLp4nN8aYM3UPS55ynVMXcy4MgR566EOdwi9sINDjoxc7soChSliZIBqbChHdc245+bPvvaL9zugfL18Qu2rHvSYvf1n21nPDh3zFo0Okx74mYUVUN8dgJri8zQqPmC27JUIzg2+PH8EZlZBGPvfRZfsTceo+dCXks1/9xwaeN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098643fb-c982-4a43-e5e6-08d779a5ec14
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 17:09:43.5411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IY7LmW9flwnX55Y7C4q3Ev6X2C7aXBglQfl0KOTqGXbEGv+LnHBxUZByZ071M5p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhRRl84bqe86FeOV77uLFRbYm86eJk7AH4sqRfi96QU=;
 b=bcEryifBXPWDG1P8qNrQf08FZtuVJs+ZNarEw8mxFA80CY6QF5+fBFtLOvYfRwtB+kGUCzeneFhElsH25pywfMjRWywFHOfsI8xcZPYeVUWq9iSOFKUnlEJxlpKtjYONyNYu3yITL6uX6lZQ1JyVKKzdnv8LuAH0FUABmyoDaDs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WWVhaCwgYnV0IHdlIHNob3VsZCB0cnkgdG8gdW5pZnkgdGhlIG1lbW9yeSBtYW5hZ2VtZW50LgoK
SSBtZWFuIHdlIG11c3QgaGF2ZSBhIGNvbW1vbiByYXRpb25hbCBvbiBob3cgbXVjaCBtZW1vcnkg
cGFnZSB0YWJsZXMgYXJlIApnb2luZyB0byB1c2UuCgpJZiB3ZSBhbGxvdyBhcHBsaWNhdGlvbnMg
dG8gb3ZlcnN1YnNjcmliZSBvciBub3QgaXMgYSBjb21wbGV0ZWx5IApkaWZmZXJlbnQgdG9waWMu
CgpSZWdhcmRzLApDaHJpc3RpYW4uCgpBbSAwNS4xMi4xOSB1bSAxODowNSBzY2hyaWViIEZlbGl4
IEt1ZWhsaW5nOgo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBzaG91bGQgZ28gaW50byBhbWRncHVfdnJh
bV9tZ3IuIEtGRCB0cmllcyB0byBhdm9pZCAKPiBydW5uaW5nIG91dCBvZiBWUkFNIGZvciBwYWdl
IHRhYmxlcyBiZWNhdXNlIHdlIGNhbm5vdCBvdmVyc3Vic2NyaWJlIAo+IG1lbW9yeSB3aXRoaW4g
YSBwcm9jZXNzIGFuZCB3ZSB3YW50IHRvIGF2b2lkIGNvbXB1dGUgcHJvY2Vzc2VzIAo+IGV2aWN0
aW5nIGVhY2ggb3RoZXIgYmVjYXVzZSB0aGF0IHdvdWxkIG1lYW4gdGhyYXNoaW5nLiBUaG9zZSAK
PiBsaW1pdGF0aW9uIGRvbid0IGFwcGx5IHRvIGdyYXBoaWNzIGNvbnRleHRzLgo+Cj4gUmVnYXJk
cywKPiDCoCBGZWxpeAo+Cj4KPiBPbiAyMDE5LTEyLTA1IDU6NTAgYS5tLiwgQ2hyaXN0aWFuIEvD
tm5pZyB3cm90ZToKPgo+PiBTb3JyeSwganVzdCBmb3Jnb3QgdG8gYWRkIHRoZSBtYWlsaW5nIGxp
c3QuCj4+Cj4+IEFtIDA1LjEyLjE5IHVtIDExOjQ5IHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoK
Pj4+IEhpIGd1eXMsCj4+Pgo+Pj4gSSd2ZSBzZWVuIHNvbWUgcGF0Y2hlcyBmbHlpbmcgYnkgdG8g
Y2hhbmdlIGhvdyBtdWNoIFZSQU0gaXMgcmVzZXJ2ZWQgCj4+PiBmb3IgcGFnZSB0YWJsZXMgaW4g
dGhlIEtGRC4KPj4+Cj4+PiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIGZ1bGx5IG1vdmUgdGhhdCBp
bnRvIGFtZGdwdV92cmFtX21nci5jPwo+Pj4KPj4+IFJlZ2FyZHMsCj4+PiBDaHJpc3RpYW4uCj4+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
