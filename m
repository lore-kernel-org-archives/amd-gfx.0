Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09C7C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 15:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75076207D8
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 15:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1HxyvnHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75076207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 307D18955D;
	Thu, 25 Jun 2020 15:38:23 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700080.outbound.protection.outlook.com [40.107.70.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF4B78955D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 15:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYGGMMbgNmoN+Gtq4aZMSmgcAWTI0IQTYNqrwyiFkJDIHeIKK6/wxU3sYxegahPYlYWSaLWmkpa294dPMMCo8vHdROCs7+gM+Iqur0492kvnUd9HrpA45oLfNwrRGrRnaCdm6y5bZy8pM2jIQzwxqBToOHJxtA+Xr6dE2D9oqyrUeseyAdmMFuEZFEPQz407PD+9owwq21fKFRI9xtuYpXelsAbvZYKDraeY1Btq1XoEmjNc9YFBkNFiSbOiV9RvhQcD13opcKjWYFIgIEz6VQUKNwWI/7CaNJ3HkJV2+OENbz/6l3Ui6WTiKA3bpeXkCwuePN2qshdzsjqjLp7mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iq4Klw4ioLhg9GaRdBKm7JblAHUm55bsjWxKLBXHd2M=;
 b=CeTtAEO+GKKgHB8iKNklO2z0z39TNlaToi9A2YEA0cukl9dox99wvI9uLM/kNl6lPWJ7HhGbANm5vqLuM1EJBDAyXYoo5kV2o8fnRG8WobMsBVBj4i3x34rIX8cGIWgP36SFUUOZ0GtK+3dNyRg5ZGzuHbR8SC1oY56kPamu1Z5lFJ+zua01qk6BdUrcCtphe/kbkysQ7eINlojAYtx9upOvhYUbYwS7dRmYbIhuQJ9MdrQnhTqjbzIFYLcstQweUCYo00Ci+Gxu85ySyUl66c7edqsndiPsIjuKXc0ZCSzOkeVVogRnKgJa6X15ZM0CrT7wfirBX/zzecSS5itCfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iq4Klw4ioLhg9GaRdBKm7JblAHUm55bsjWxKLBXHd2M=;
 b=1HxyvnHP0adVRpRVhFeIgwthP1I9kKWxFZhPmNpD8sd1PuAXlmBFM3/N8lXSOHfY+tnjfqbn9Z8AfkAoGEB+nfBueWC0xOD8mwqlDaNrQ7rRdLH4pEGwq4o93vV86AwdIgsBxJji3D7UQJ9VKH/uQ2uAYV1CsyJJlnw4deKLqsk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 25 Jun
 2020 15:38:16 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1%9]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 15:38:16 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Let KFD use more VMIDs on Arcturus
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200625031834.16122-1-Felix.Kuehling@amd.com>
 <20200625031834.16122-2-Felix.Kuehling@amd.com>
 <48a11576-b734-7525-dc39-c4aef67d5d35@gmail.com>
 <77c53962-fd2e-7004-76ab-aae4580a49b9@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <841359ec-a1cd-7722-55e6-182b6e2b6578@amd.com>
Date: Thu, 25 Jun 2020 17:38:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <77c53962-fd2e-7004-76ab-aae4580a49b9@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Thu, 25 Jun 2020 15:38:14 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b8a0cb19-a53a-4f84-f8d9-08d8191dc6ff
X-MS-TrafficTypeDiagnostic: DM6PR12MB4313:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4313A08C09AB7096BE2AF6F483920@DM6PR12MB4313.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEkt1xAsfoLq9B4Bvy0Evi8JOrQt7sDenwqIZgAG45qo+dcHVpFHtLGz/vfWvhfoTUo6eaLYHGBDjHTG9Dfx/m2jTThFM6+N7UcVQQuzM7vF33w3LWFLc2SgN9wNaVoG6dcw9MYmgadMcq/zr91bvCF86n/h4JKFN/GSurdhSU7FHn3vv8X9VH/Hle1XWvd5jUk2vBgz66hgwooj9YET0cNKEuFRyTrRBWpb3ConecA9DJrBoULR34kJXFIZ0w/McCxNAAcuX2vJ2cqR7ZbspJ/3MALeDW1SxQyPO7nUraCMGN7UerRcxn9aMXb7Q/AH/tbwikUDGz1zQVrH/xb8Y/BoHCTS/rYYtIcGP6Z2TaQWgyJfx2B3MdQUpC9TEVQE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(186003)(36756003)(86362001)(66946007)(8936002)(6486002)(478600001)(316002)(16526019)(5660300002)(66476007)(66556008)(8676002)(83380400001)(2906002)(2616005)(31686004)(31696002)(52116002)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: v+aNAoRDgZar4ivfOkl6wCMx0jI4aV3Sch7q1xvkOqWsjNyFSz2J4v2VJeBkMTWRRxEnrqYzuEGRVpps6ITxSpKTpOFa2RRXCtpwwEuqf4ntzXjBX/STVikWcTNP+LrVHFK8ysnj/3ilxY1KdDKRmYppXTzvubxVJL7Y3SodM/b2FcH80IJNG+A88jb82s9tFfvSNiEDjnc7Dz86EsNx5xBA7SSGqMVISTW2qZGeGGAnDpWY8ab9HSGCUMImPXVp8qo/9Wgg49b7l2Eb4mVdcxXS6sVuGDoqOpgTX+PVj732Ff6d/gJ9hKAOI+CQU0eEAJT44WxNm+qwHeSawNFbpF14boY+JC7ptEBgSF6HFBb6a6VlxVJdCu2TEmP3+LRXQea0tLSrzUENVnzcBlosLzF/KRw+aIMf9B7TTZLdBD4ol9XjmjTnAWJdUuUK4jtXAUdOn5wYWpj+nuE7jSwjgpXNbydHTqCAi3guFeVQYD+MkDE1xHIjj7Ev9vR3FyxOL7ACArYj/B5JCcI0+ioDLl+LhODMJnQgrb68p7QRRDVrD8IRH/9VzOglWBn8RJsk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a0cb19-a53a-4f84-f8d9-08d8191dc6ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 15:38:15.8446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDStVP8i3FhGquxLT5tn5n0hPJJaw8wmIcYku4PjkchoigmInhlrXgE15MgVlPRg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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

QW0gMjUuMDYuMjAgdW0gMTc6MTUgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIwLTA2
LTI1IHVtIDQ6MTkgYS5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+IEFtIDI1LjA2LjIw
IHVtIDA1OjE4IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+PiBXaGVuIHRoZXJlIGlzIG5vIGdy
YXBoaWNzIHN1cHBvcnQsIEtGRCBjYW4gdXNlIG1vcmUgb2YgdGhlIFZNSURzLgo+Pj4gR3JhcGhp
Y3MKPj4+IFZNSURzIGFyZSBvbmx5IHVzZWQgZm9yIHZpZGVvIGRlY29kaW5nL2VuY29kaW5nIGFu
ZCBwb3N0IHByb2Nlc3NpbmcuCj4+PiBXaXRoCj4+PiB0d28gVkNFIGVuZ2luZXMsIHRoZXJlIGlz
IG5vIHJlYXNvbiB0byByZXNlcnZlIG1vcmUgdGhhbiAyIFZNSURzIGZvcgo+Pj4gdGhhdC4KPj4g
SUlSQyB0aGUgZXhwZWN0YXRpb24gaXMgdGhhdCB3ZSBzdGlsbCB1c2UgdGhlIGNvbXB1dGUgcXVl
dWVzIGZvciBwb3N0Cj4+IHByb2Nlc3NpbmcgYW5kIG5vdCB0aGUgS0ZELgo+Pgo+PiBTbyB3ZSB3
aWxsIG5lZWQgYXQgbGVhc3QgVk1JRHMgZm9yIHRoYXQgYXMgd2VsbC4KPiBDb3JyZWN0LiBQb3N0
IHByb2Nlc3NpbmcgdXNlcyBjb21wdXRlIHF1ZXVlcyBhbmQgVk1JRHMgaW4gdGhlIEdGWEhVQi4K
PiBWQ0UgdXNlcyBWTUlEcyBpbiB0aGUgTU1IVUIuIEkgYmVsaWV2ZSBpbiBNZXNhIHRoZXkgdXNl
IHRoZSBzYW1lIFZNCj4gY29udGV4dC4gU28gY2FuJ3QgdGhleSBzaGFyZSB0aGUgc2FtZSBWTUlE
cz8KCkFoISBHb29kIHBvaW50LCBCdXQgd2Ugc3RpbGwgbmVlZCBhdCBsZWFzdCAzIFZNSUQgd2hl
biBWTUlEIHJlc2VydmF0aW9uIAppcyBhY3RpdmUuCgpJIGRvbid0IHRoaW5rIHlvdSBjYW4gZ28g
YmVsb3cgdGhpcy4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBSZWdhcmRzLAo+ICDCoCBGZWxp
eAo+Cj4KPj4+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0Bh
bWQuY29tPgo+Pj4gLS0tCj4+PiAgwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5
XzAuYyB8IDExICsrKysrKysrLS0tCj4+PiAgwqAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjlfMC5jCj4+PiBpbmRleCA2ZTEwYjQyYzU3ZTUuLjM0NzA5MjllNWI4ZSAxMDA2NDQKPj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPj4+IEBAIC0xMjQ1LDEwICsxMjQ1
LDE1IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpCj4+PiAgwqDC
oMKgwqDCoCAvKgo+Pj4gIMKgwqDCoMKgwqDCoCAqIG51bWJlciBvZiBWTXMKPj4+ICDCoMKgwqDC
oMKgwqAgKiBWTUlEIDAgaXMgcmVzZXJ2ZWQgZm9yIFN5c3RlbQo+Pj4gLcKgwqDCoMKgICogYW1k
Z3B1IGdyYXBoaWNzL2NvbXB1dGUgd2lsbCB1c2UgVk1JRHMgMS03Cj4+PiAtwqDCoMKgwqAgKiBh
bWRrZmQgd2lsbCB1c2UgVk1JRHMgOC0xNQo+Pj4gK8KgwqDCoMKgICogYW1kZ3B1IGdyYXBoaWNz
L2NvbXB1dGUgd2lsbCB1c2UgVk1JRHMgMS4ubi0xCj4+PiArwqDCoMKgwqAgKiBhbWRrZmQgd2ls
bCB1c2UgVk1JRHMgbi4uMTUKPj4+ICvCoMKgwqDCoCAqCj4+PiArwqDCoMKgwqAgKiBUaGUgZmly
c3QgS0ZEIFZNSUQgaXMgOCBmb3IgR1BVcyB3aXRoIGdyYXBoaWNzLCAzIGZvcgo+Pj4gK8KgwqDC
oMKgICogY29tcHV0ZS1vbmx5IEdQVXMuIE9uIGNvbXB1dGUtb25seSBHUFVzIHRoYXQgbGVhdmVz
IDIgVk1JRHMKPj4+ICvCoMKgwqDCoCAqIGZvciB2aWRlbyBwcm9jZXNzaW5nLgo+Pj4gIMKgwqDC
oMKgwqDCoCAqLwo+Pj4gLcKgwqDCoCBhZGV2LT52bV9tYW5hZ2VyLmZpcnN0X2tmZF92bWlkID0g
ODsKPj4+ICvCoMKgwqAgYWRldi0+dm1fbWFuYWdlci5maXJzdF9rZmRfdm1pZCA9Cj4+PiArwqDC
oMKgwqDCoMKgwqAgYWRldi0+YXNpY190eXBlID09IENISVBfQVJDVFVSVVMgPyAzIDogODsKPj4+
ICDCoCDCoMKgwqDCoMKgIGFtZGdwdV92bV9tYW5hZ2VyX2luaXQoYWRldik7Cj4+PiAgICAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
