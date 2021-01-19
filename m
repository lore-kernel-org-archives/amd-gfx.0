Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F039C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 01:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0317C223DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 01:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0317C223DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7146E7D2;
	Tue, 19 Jan 2021 01:20:45 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770080.outbound.protection.outlook.com [40.107.77.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CAE06E7D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 01:20:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzOt9xFM/nySGUAScaDH9ea76Rg7Q4/f5D9QK5Nulj/NOK9RGHWj6i6h88HU9Hdy7mcRYm7c9p+QFoi31qBuGF2yTg6wPiWYNFjKumRelqhGa5+i6nkKADtOTIFF9PejHCGadu5BpnF2p2kBF2tqwyvDhTqZt/kVbcvouHuNoVlwxRGW0vQ9L7maDtO9+1GMMg0b6Oi3O9fnzEgqWiGl6+nrNznisnWOsxIfybbKOWg7mCnJe/UDvEMwQeiNZMzpj/YV6NxLxtdLwTnmUGKD9MO/PlG0kQ/1eKpVLx3LTazM+hiboQ5SwtyelBvHXiWrvmklTkzGOP+L2J+ibGRLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T5CZuIAmQSkeih/zrWcthVVnPYoSoVru9jPCv/WMVo=;
 b=gscrMYz57xBeY2lNBThHeDwYfoM3k9mvfFrYaxwXwOy+rJIMyFIw3gbYaSJpWFj+FdkrI4mDzTW4pQT0Z5eEbibeS9t85wSDgl77vMMPiEUX4z2pRXRi0hvb71PhEmnxTpWfOXdGxpJHKoa6rqV2Jm1347ymJthU9vnU+TWmqJFevW0nwXaqdepL8QY26onvWa7m/7TAISzXVjoqX2b25M336Q4O7UIj17KuaLintlBiuu4DuAb2iHjM/KDkfjkF6q1P74Eei/AVtB1JX6rgqX0ami3zwxKPq8HH0sEpKWik7otoVVQVd1oVrD+nXOnGamjAkgDD+RbIGe9FZCMEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T5CZuIAmQSkeih/zrWcthVVnPYoSoVru9jPCv/WMVo=;
 b=jZI83yFngcyhCmI4NNeindoIbKV3mFwzeC/Xb0NN5cUBRQpQ+bqFHdW59fm27xJCRXTdS1wJ0HIdMujED1r1sJbcmZ9SoHVBc3qhNTszUAmDSOqPS+uZZM27aMfyIowfXVFb9WXlOMK0e9ychIpx57V+SdZYxKw3KrDryve0wXs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 01:20:40 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 01:20:40 +0000
Subject: Re: [PATCH v2 1/1] drm/amdkfd: Enable userptr support when KFD is
 enabled
To: philip yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210118232824.32649-1-Felix.Kuehling@amd.com>
 <d11b2228-e3dd-0dcb-d497-2242ab06c917@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <cf411cd5-2474-8078-ce01-c3c5150e97d6@amd.com>
Date: Mon, 18 Jan 2021 20:20:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <d11b2228-e3dd-0dcb-d497-2242ab06c917@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Tue, 19 Jan 2021 01:20:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c2ed2ef-d722-4a59-6395-08d8bc186f41
X-MS-TrafficTypeDiagnostic: MN2PR12MB4335:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4335C1BEE2D62344CA74C9C892A30@MN2PR12MB4335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xjSUGXvwckrkoczDLy/zSaNS9UwXZrERmGYz3y8sDSHefFTstTkXXECMkprt42vYkRGQavRn16b6lCYDEspBLP5+oZVTYUFkl65MkkaX5d6DX7raNy6UMmKpiASBXTF6Rz/jIsw4CZEzA6eNPv1jCPY+E0mNUmA7KJe706SHFsUr7Uu1GkvTrw8gX8A35F52fm/gaGl/nG0/d/SiZ3POQk0OKTFvGQyuT6LeQvp/K3WEdrq+M+ZInTWAmwqjTrcw/SW34filIFh/MBRuqXgNVhWC8X5/h3L6PtT9BZk8nMWLTbMLH8Nzhf+mDhqsOgrKbmCVlApEyjELueG6gyH15mJRmceHUgfiJJ3rAli2Mb8Lo5p+3dyFggdLxJd+yz2eAJYR+CKbF3KSfmfglz7WMGp/5E3LI4ZvibWEZY14NsXL9k+Q+5PHH/tU5Dw3tyJpaheW83+CyIbLtI2OOl0UPIdrXu0wyxka0rHTBn4T+i8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(316002)(2906002)(16576012)(478600001)(8936002)(44832011)(86362001)(956004)(2616005)(36756003)(52116002)(53546011)(83380400001)(186003)(66946007)(31686004)(8676002)(66556008)(66476007)(5660300002)(31696002)(6486002)(16526019)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UytPbFJtWHFRZGo4MTlvOTBLcjExRHh4K0loZlYvWWViY1hFRlJtU2sxSzkv?=
 =?utf-8?B?OW9CSlNuaEFoOGNkQTRtUTk2bFBZRVdmTW0vSDZJSm8xMHVsb3NwUmlQWEx3?=
 =?utf-8?B?L09icFgxSHp4RUtnSDdMMmR3Zyt6SFpVQk9hekZYbG9wSWdldGcrNmFZbnZT?=
 =?utf-8?B?T2NTOFp1Tk81dUpKOVQ4WTF6NnUvZUlTWWdML2RnZWZ2OHhSbzdtb3JoUngy?=
 =?utf-8?B?d0JXYUNJVHJDUm5RVjBjcUN6YVhQZGkzOXZycTdkVFVCbnIyZVE4WWwvTUdz?=
 =?utf-8?B?Y0I3VGlTUHBib1F2dThyMWVKMzV4RzNmbnFGSHhvVGRHMlBmRXJXdGp4MHZJ?=
 =?utf-8?B?L3JLK1Ixd2hHcTQ5aWRpdlBMNkpXUmNKcEZtSkw0VGs0cVBwOXNyZFdJM0Jl?=
 =?utf-8?B?aFFhTERrY2VqbFpCbm15clA0bHkyK1hjSDdLeVB5MHloY2RmTHg5ZE02dXJa?=
 =?utf-8?B?cEJsbm1jeHFSK1RpaXVySFVNZnU2Z2pTNElkSHA0SE5wTERmRDRLS1l6QlRp?=
 =?utf-8?B?UnZTNFJsMnUrM3ZOSE5SanIwR2t6MHUwdXMwN3hzZnJsa3RQUDIrUnFibU9k?=
 =?utf-8?B?M0Zkc2hrNDIxNzJvMjdrSEhCSmRVRm5uQTZBbVVyMmtjc3dCZVJaakxOQ0J0?=
 =?utf-8?B?d21YLzc3ZnRIazFac1FwU0Mwb1VzMlQwcHZiY09tY1JycTMra0FyZENmd3Vj?=
 =?utf-8?B?b1p6NXAva3JGMVh0dng1SmpRTnVOWlVwSDEzYXlJdUxHK04zU1ExVFh1NFFO?=
 =?utf-8?B?L2JPRVVCcEJ4VERxekRXVHpqQjNUWWk3aEgrbnZPR1B3WWVIbVUrMk9oU2Fk?=
 =?utf-8?B?TW1zdU5lR25oTVA0L0dVNDZxeWZwSHEybUEyNit2YzB6eGVmb0pmcVMzRElF?=
 =?utf-8?B?ZytrUDVUQlZsR2tkWlhEd2dDL3RsNS9LZGUyMDZpQlNFU2xDOWxENkMwSVJ1?=
 =?utf-8?B?ZS9qeWRvcFU0cEFMeXRDcDZvMkg1a3BZSWxabHlFK01lREpvN1RVbkRRdHBW?=
 =?utf-8?B?aWpSLzRDZ3VxZHZUM295VDlsUXJuanVOdnpSR3lWQzFVVVA1TWttcElKT3FO?=
 =?utf-8?B?eWUrT1p1YUh1V3VSSUZGT3VId1dCNy94WkdhMEcxTVE4OUpaSWhCeW5ZTWRN?=
 =?utf-8?B?NXk3NXl3ci9FMjBWcmtQMzRzbTJoSytxZGUrVzJ0WG55WUF4MVUzUjBmbTl6?=
 =?utf-8?B?OW5sV25UcWJ3elVIcVlGRUlidkFEakU1dVJPUjVvTEl6Z2x5czlUNkVpaWVy?=
 =?utf-8?B?NDh3R2Q5ZEptUVBtRENjdmRVVXQ1K3hzZGhUUTdPekgzRGt6RUJ1SzAwWDdW?=
 =?utf-8?Q?kLWI4aVGX2OgbZql00lUzjSFJggERv+qSf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2ed2ef-d722-4a59-6395-08d8bc186f41
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 01:20:40.6749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UG6I91yRD79leNdTcu9CK1mc9m4oRZzJp8eqfBOe2RTYTJV1BC8obTWzMbqckI3QDFzej+pubqbBDchj5hDjvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
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

QW0gMjAyMS0wMS0xOCB1bSA4OjAxIHAubS4gc2NocmllYiBwaGlsaXAgeWFuZzoKPgo+Cj4gT24g
MjAyMS0wMS0xOCA2OjI4IHAubS4sIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+PiBST0NtIHVzZXIg
bW9kZSBkZXBlbmRzIG9uIHVzZXJwdHIgc3VwcG9ydC4gV2l0aG91dCBpdCwgS0ZEIGlzIGJhc2lj
YWxseQo+PiB1c2VsZXNzLgo+Pgo+PiBNYWtlIHN1cmUgSFNBX0FNRCBzZWxlY3RzIHRoZSBzYW1l
IG9wdGlvbnMgYXMgRFJNX0FNREdQVV9VU0VSUFRSIHRvIGF2b2lkCj4+IGJyb2tlbiBjb25maWd1
cmF0aW9ucyB3aGVyZSB1c2VycHRyIGdldHMgZW5hYmxlZCBidXQgaXRzIGRlcGVuZGVuY2llcyBh
cmUKPj4gZGlzYWJsZWQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxp
eC5LdWVobGluZ0BhbWQuY29tPgo+PiAtLS0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L0tjb25maWcgfCAyICsrCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4+Cj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQvS2NvbmZpZwo+PiBpbmRleCBlOGZiMTBjNDFmMTYuLmYwMmM5
MzhmNzVkYSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvS2NvbmZp
Zwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnCj4+IEBAIC03LDYg
KzcsOCBAQCBjb25maWcgSFNBX0FNRAo+PiAgCWJvb2wgIkhTQSBrZXJuZWwgZHJpdmVyIGZvciBB
TUQgR1BVIGRldmljZXMiCj4+ICAJZGVwZW5kcyBvbiBEUk1fQU1ER1BVICYmIChYODZfNjQgfHwg
QVJNNjQgfHwgUFBDNjQpCj4+ICAJaW1wbHkgQU1EX0lPTU1VX1YyIGlmIFg4Nl82NAo+PiArCXNl
bGVjdCBITU1fTUlSUk9SCj4+ICAJc2VsZWN0IE1NVV9OT1RJRklFUgo+PiArCXNlbGVjdCBEUk1f
QU1ER1BVX1VTRVJQVFIKPgo+IGFtZC9hbWRncHUvS2NvbmZpZyBzZWxlY3QgSE1NX01JUlJPUiBh
bmQgTU1VX05PVElGSUVSIGlmCj4gRFJNX0FNREdQVV9VU0VSUFRSIGlzIGVuYWJsZWQsCj4KPiBJ
IGd1ZXNzIHNlbGVjdCBEUk1fQU1ER1BVX1VTRVJQVFIgaGVyZSBpcyBlbm91Z2gsIEhNTV9NSVJS
T1IgYW5kCj4gTU1VX05PVElGSUVSIGlzIHJlZHVuZGFudC4KPgpJIHJlYWQgdGhpcyB3YXJuaW5n
IGluIERvY3VtZW50YXRpb24va2J1aWxkL2tjb25maWctbGFuZ3VhZ2UucnN0OgoKwqAgTm90ZToK
wqDCoMKgwqDCoMKgwqAgc2VsZWN0IHNob3VsZCBiZSB1c2VkIHdpdGggY2FyZS4gc2VsZWN0IHdp
bGwgZm9yY2UKwqDCoMKgwqDCoMKgwqAgYSBzeW1ib2wgdG8gYSB2YWx1ZSB3aXRob3V0IHZpc2l0
aW5nIHRoZSBkZXBlbmRlbmNpZXMuCsKgwqDCoMKgwqDCoMKgIEJ5IGFidXNpbmcgc2VsZWN0IHlv
dSBhcmUgYWJsZSB0byBzZWxlY3QgYSBzeW1ib2wgRk9PIGV2ZW4KwqDCoMKgwqDCoMKgwqAgaWYg
Rk9PIGRlcGVuZHMgb24gQkFSIHRoYXQgaXMgbm90IHNldC4KwqDCoMKgwqDCoMKgwqAgSW4gZ2Vu
ZXJhbCB1c2Ugc2VsZWN0IG9ubHkgZm9yIG5vbi12aXNpYmxlIHN5bWJvbHMKwqDCoMKgwqDCoMKg
wqAgKG5vIHByb21wdHMgYW55d2hlcmUpIGFuZCBmb3Igc3ltYm9scyB3aXRoIG5vIGRlcGVuZGVu
Y2llcy4KwqDCoMKgwqDCoMKgwqAgVGhhdCB3aWxsIGxpbWl0IHRoZSB1c2VmdWxuZXNzIGJ1dCBv
biB0aGUgb3RoZXIgaGFuZCBhdm9pZArCoMKgwqDCoMKgwqDCoCB0aGUgaWxsZWdhbCBjb25maWd1
cmF0aW9ucyBhbGwgb3Zlci4KCkknbSBub3Qgc3VyZSBpZiAiZGVwZW5kZW5jaWVzIiBpbiB0aGlz
IGNvbnRleHQgaW5jbHVkZXMgImRlcGVuZHMiIGFuZAoic2VsZWN0Ii4gQnV0IHRvIGJlIHN1cmUs
IEknZCByYXRoZXIgbWFrZSBzdXJlIEtGRCBoYXMgYWxsIGl0IG5lZWRzCndpdGhvdXQgcmVseWlu
ZyBvbiBpbmRpcmVjdCBkZXBlbmRlbmNpZXMuCgpSZWdhcmRzLArCoCBGZWxpeAoKCj4gUGhpbGlw
Cj4KPj4gIAloZWxwCj4+ICAJICBFbmFibGUgdGhpcyBpZiB5b3Ugd2FudCB0byB1c2UgSFNBIGZl
YXR1cmVzIG9uIEFNRCBHUFUgZGV2aWNlcy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
