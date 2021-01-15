Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47CAC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 13:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4435D2339E
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 13:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4435D2339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F856E40A;
	Fri, 15 Jan 2021 13:38:53 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 795526E40A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 13:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbSGPvXj+6r9Ner6jatwugi0AZ95i75chDNuxk+NOHHykDqnmJO8VMEBsSXyQpwlv/4t280ZWcrPHoscChfly1K9v3bZp/K8LwHJYD5NGFFHMBQiPGzXwq4iLnLgH00CukWl2C/dSlpN5dpFVOoko2v2Ee9vIGVxtdsqTUpEHqh1BZNwJIIwwqhnZ7+Co6B4QB6l8o3sPRruImINHF1+3rYw9F1G4dZKjoJ3tofG/QliiERYsimWmGmoQE/8m6IlOo2EwVrRG0YzIa1v+DoHPPp7YfVYYiBSq3A1tMl/eAq0tzdRcg67+B2DbvInM5rXLcRlbH290AX0Q1Ln+PrYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0F/+1+ghlg7hs3hjYkC9sJThqQEF97UPmQJ2jxrnGg=;
 b=eQirhcAGEATU9xrBsmP7okQQSOp9HnZN7UgoZLz5lWs5jOUEQlXlmD5q7hjw7/1NruU06YIQ5zh4S2pVw6QiIIxW7CtGTOtNadB3lQ5trVoD5hDJ+JJY5itz111v0Fb4qa3GqL0r7VncNecHhvFtpOl4hHTEdaO8/lpTM8r/rkHGPh1ITNALv5yOaJGBv1h+gUo/UYIFrr2MxnAtGrJOxa8upMAarOmJlwckIHPyevsSAE13RwC3fGtluUI2Fa8O0to/4wlegKZb3PoD0QqfejPB1Mn8Y5HT6bWsldz/9AHSmx/YBagx2lGaXzzDoOgJ1AKRyfnWNVnTmG4S7KPoNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0F/+1+ghlg7hs3hjYkC9sJThqQEF97UPmQJ2jxrnGg=;
 b=lvr2T+BMtkQQz2L9qtJX/LFt1gKj4k6W5quHtf8gjQGln3ENIaNX2tKbdQJiVanlD1tAAHGhbt9OSyhsQaTrBbP8ET5CIFYX8QYy6zyKEgnMz4Uxzi6auPz0fu1UKhWrFbV+Gp+RhpzKS1fvZ5cUEDtnBSxfQi8EAD5xCiwrHP8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1235.namprd12.prod.outlook.com (2603:10b6:404:20::17)
 by BN6PR1201MB2467.namprd12.prod.outlook.com (2603:10b6:404:a7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 15 Jan
 2021 13:38:46 +0000
Received: from BN6PR12MB1235.namprd12.prod.outlook.com
 ([fe80::41d1:8070:766:e2e0]) by BN6PR12MB1235.namprd12.prod.outlook.com
 ([fe80::41d1:8070:766:e2e0%3]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 13:38:46 +0000
Date: Sat, 16 Jan 2021 05:38:12 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix the system memory page fault
 because of copy overflow
Message-ID: <20210115213812.GB516039@hr-amd>
References: <20210115184658.513045-1-ray.huang@amd.com>
 <BY5PR12MB488513CB51AD26664AE5AF89EAA70@BY5PR12MB4885.namprd12.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BY5PR12MB488513CB51AD26664AE5AF89EAA70@BY5PR12MB4885.namprd12.prod.outlook.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR04CA0073.apcprd04.prod.outlook.com
 (2603:1096:202:15::17) To BN6PR12MB1235.namprd12.prod.outlook.com
 (2603:10b6:404:20::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR04CA0073.apcprd04.prod.outlook.com (2603:1096:202:15::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Fri, 15 Jan 2021 13:38:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03c98baf-e9c9-4d61-6aa8-08d8b95ae1a0
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2467:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2467003E96A3ECCA1E7C265AECA70@BN6PR1201MB2467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Zrp69A7ZZvpu0B7640Rqkh9R1ONJKwEtONzdMa9ssycNp1wEV2Z7BnTOxqZxdjM+0JX3wa6BcUkFCmsfSVv9wjaB5vRzqhJvjwoTh0dm8fXE5TjRP72kpzabmGKXQ3JhSa6EW1xFVkJn+Fjc2WXLCGu4TxMKSfZp0rOmO1tbRZZzyLtzf6cKfQSnwDDkwfNzJM1TAyQynjJax3ev6lH+VdTiCel0VYsJJpHibvAoBkofJTD9/FU6MApJa9EPU0uwX/HFAygF9TsxoSdXlHofPgN7B9LY/dJO5gcFUguaxk03g22dOph4i8MiqaaZ5K+YpN//cONY1+i78PRPsUTCXqjPSNUUfEPCaPhWsqX9uY6ca32doFEBdvFUrcgCalKAjvaAMAT07EKp5CeVN+LQkmKlQrggRxs42ZCgaoscZOQiPgTcwqZkr6QGKLU45cql8vM2NUArEx80ayN0VxX9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1235.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(54906003)(5660300002)(33656002)(66946007)(966005)(66556008)(9686003)(4326008)(6636002)(316002)(8676002)(6666004)(55016002)(83380400001)(6496006)(2906002)(33716001)(478600001)(956004)(186003)(26005)(66476007)(1076003)(45080400002)(16526019)(52116002)(53546011)(8936002)(6862004)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SXFnQjBQV0hxWjZPUUNlcTEvWDBReWcwdHJMYVZyYUVBV0MwanM5TVpsWE1n?=
 =?utf-8?B?dWZiQ0RwbVBpU0VKL3d3Q0lCS1hQWEJWTGJqNHBYYjJrWlZ5TjVhQUNIWXpw?=
 =?utf-8?B?UjR1bkRJalBJVGovcTNGeWNJZUxvM0xQUVFUdFQxaVUzUWtqV3VPbGlweVRT?=
 =?utf-8?B?RFZFU240V09ZQXp0alh1QTkvSmhiRXByQjIvcTQ3SWdVQm8wRXNGT2hYN2ha?=
 =?utf-8?B?czIyZ2NFTlpWQkpYMWdQUjdSWnhOL2RLOEFoZGVNTFZaMEcvUUJqSnh5bUZX?=
 =?utf-8?B?MzBJU3k3RG5zb1lSN0NwcVp6Z2hlWnloWVArYlZ4MGtUNmxDZWhPc21SK3ps?=
 =?utf-8?B?VVo4S3NPb1BsK3ZlQWxTQVBXMmNWQjRGam9RQTNvSFcwQnJodTByQXNUU1kx?=
 =?utf-8?B?d05Kd0JBMHJDNUp0MTVJdHhkVk1UWWs0b0JZbWJWZ3l4OWw0dVR6b3lhcUpF?=
 =?utf-8?B?bWpTV0lJZEFOSkljMFZMR2F4LzJUYXNLRlorckVRN0xOdWx4Q1MwdHhzYldV?=
 =?utf-8?B?VHdEcEZDdHJKbFlsem4wbU5Qd295b25Ed25jczNsY25MMUJZT05FUlRiOHhs?=
 =?utf-8?B?R2xpenVheXZVTTFQaUJpUGR5U1Qxb0VBL29ZR0lDbUt5ZHBFQUkrQ3NtdERJ?=
 =?utf-8?B?blFzRmZHZ0FlR2wycjR3Nm5WNC9iSXpZUWVpekkxc1dYZFp2OHNjNEk4bWpX?=
 =?utf-8?B?MTlyRmNRZ3FqZFhacldHek9vQm10TzgxYVNuTUdoUWVUWjZvYi9iL2YyTjVi?=
 =?utf-8?B?bWkyZDNtR2NqdjBRNjBQNW9vRmE1S1ZUUjUrbWFrM0szTE92dFhKL2dad1lY?=
 =?utf-8?B?bUcrSlg3RlRtTVRYQUVualZZZUlZcm9HK0pQVUVxMmRocVRkajgwTjIrcTVW?=
 =?utf-8?B?ek1MeUpIRXdjQzJ4UFQ3cDZvb2phZmpocHZlSUl0WW1FRmFBcGhmRWVvdTdE?=
 =?utf-8?B?aFRNMUdwRVJDa0g4TjVuMXErMXU5REhzeWxHR2t5L1hMY1ZTZ0xGVTl3bitR?=
 =?utf-8?B?UEJnZk5FZFdUU3B1TlgxNTdlVW9rdENHayt5ZG1jVThpTi9OckZpZjluTGpR?=
 =?utf-8?B?OWowNlNnMzNiRWFQVjlJbmV0dlZSNitQUjdEZW5uOFFMOE5kcnhIOGtYdDlq?=
 =?utf-8?B?aVk5S3RTZFFJNk9yZFB3TjE3Mk1pdEMrU3g2T25uLzhsLzduSFYxMWFSdnpI?=
 =?utf-8?B?UTNIVEViSCtRS3lLRm5xcTE2YTRlOGVVd3Vzbld4NDFzUzJUbWJZNWMwcmo1?=
 =?utf-8?B?cERhN2tiTVBkUlBkYm9tVkRCSS84UnNlNFZrSkJKaXhVbllRY1B3YWVtL2sw?=
 =?utf-8?Q?uvXcJEqRkMl981vLvj7+c5HeFNq6XVQ2Yx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c98baf-e9c9-4d61-6aa8-08d8b95ae1a0
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 13:38:45.8426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QIuhSxgujo/PsngmqTYxU5PSmudnsO3v3I7xMhLBpv5yPd5A0+/wivwxB5EYI/XwIJltXt09BdtP/mQZ+nu/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2467
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Su,
 Jinzhou \(Joe\)" <Jinzhou.Su@amd.com>, Lee Jones <lee.jones@linaro.org>, "Zhu,
 Changfeng" <Changfeng.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBKYW4gMTUsIDIwMjEgYXQgMDc6MjY6MjNQTSArMDgwMCwgQ2hlbiwgSmlhbnNvbmcg
KFNpbW9uKSB3cm90ZToKPiBbQU1EIFB1YmxpYyBVc2VdCj4gCj4gSGkgUnVpLAo+IFNlZW1zIHRo
ZSBjaGFuZ2UgaGFzIHZpb2xhdGVkIHRoZSBrZXJuZWwgY29kaW5nIHN0eWxl8J+YiiwgcGxlYXNl
IGhlbHAgY2hlY2suCj4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJv
Y2Vzcy9jb2Rpbmctc3R5bGUuaHRtbAo+IAo+IEFsbG9jYXRpbmcgbWVtb3J5Cj4gLi4uLi4uCj4g
VGhlIHByZWZlcnJlZCBmb3JtIGZvciBwYXNzaW5nIGEgc2l6ZSBvZiBhIHN0cnVjdCBpcyB0aGUg
Zm9sbG93aW5nOgo+IAo+IHAgPSBrbWFsbG9jKHNpemVvZigqcCksIC4uLik7Cj4gVGhlIGFsdGVy
bmF0aXZlIGZvcm0gd2hlcmUgc3RydWN0IG5hbWUgaXMgc3BlbGxlZCBvdXQgaHVydHMgcmVhZGFi
aWxpdHkgYW5kIGludHJvZHVjZXMgYW4gb3Bwb3J0dW5pdHkgZm9yIGEgYnVnIHdoZW4gdGhlIHBv
aW50ZXIgdmFyaWFibGUgdHlwZSBpcyBjaGFuZ2VkIGJ1dCB0aGUgY29ycmVzcG9uZGluZyBzaXpl
b2YgdGhhdCBpcyBwYXNzZWQgdG8gYSBtZW1vcnkgYWxsb2NhdG9yIGlzIG5vdC4KClllcywgSSBz
ZWUuIFRoYW5rcy4KClJheQoKPiAKPiBSZWdhcmRzLAo+IEppYW5zb25nCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgSHVhbmcgUnVpCj4gU2VudDogU2F0dXJkYXksIEph
bnVhcnkgMTYsIDIwMjEgMjo0NyBBTQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBT
dSwgSmluemhvdSAoSm9lKSA8SmluemhvdS5TdUBhbWQuY29tPjsgSHVhbmcsIFJheSA8UmF5Lkh1
YW5nQGFtZC5jb20+OyBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPjsgWmh1LCBDaGFu
Z2ZlbmcgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQv
ZGlzcGxheTogZml4IHRoZSBzeXN0ZW0gbWVtb3J5IHBhZ2UgZmF1bHQgYmVjYXVzZSBvZiBjb3B5
IG92ZXJmbG93Cj4gCj4gVGhlIGJ1ZmZlciBpcyBhbGxvY2F0ZWQgd2l0aCB0aGUgc2l6ZSBvZiBw
b2ludGVyIGFuZCBjb3B5IHdpdGggdGhlIHNpemUgb2YgZGF0YSBzdHJ1Y3R1cmUuIFRoZW4gdHJp
Z2dlciB0aGUgc3lzdGVtIG1lbW9yeSBwYWdlIGZhdWx0LiBVc2UgdGhlIG9yaWduYWwgZGF0YSBz
dHJ1Y3R1cmUgdG8gZ2V0IHRoZSBvYmplY3Qgc2l6ZS4KPiAKPiBGaXhlczogYThlMzAwMDViIGRy
bS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbms6IE1vdmUgc29tZSBsb2NhbCBkYXRhIGZyb20g
dGhlIHN0YWNrIHRvIHRoZSBoZWFwCj4gCj4gU2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXku
aHVhbmdAYW1kLmNvbT4KPiBDYzogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KPiAt
LS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jIHwgNCAr
Ky0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4g
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xp
bmsuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYwo+IGlu
ZGV4IDY5NTczZDY3MDU2ZC4uNzMxNzg5NzhhZTc0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYwo+IEBAIC0xMzgwLDcgKzEzODAsNyBAQCBz
dGF0aWMgYm9vbCBkY19saW5rX2NvbnN0cnVjdChzdHJ1Y3QgZGNfbGluayAqbGluaywKPiAKPiAg
RENfTE9HR0VSX0lOSVQoZGNfY3R4LT5sb2dnZXIpOwo+IAo+IC1pbmZvID0ga3phbGxvYyhzaXpl
b2YoaW5mbyksIEdGUF9LRVJORUwpOwo+ICtpbmZvID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IGlu
dGVncmF0ZWRfaW5mbyksIEdGUF9LRVJORUwpOwo+ICBpZiAoIWluZm8pCj4gIGdvdG8gY3JlYXRl
X2ZhaWw7Cj4gCj4gQEAgLTE1NDUsNyArMTU0NSw3IEBAIHN0YXRpYyBib29sIGRjX2xpbmtfY29u
c3RydWN0KHN0cnVjdCBkY19saW5rICpsaW5rLAo+ICB9Cj4gCj4gIGlmIChiaW9zLT5pbnRlZ3Jh
dGVkX2luZm8pCj4gLW1lbWNweShpbmZvLCBiaW9zLT5pbnRlZ3JhdGVkX2luZm8sIHNpemVvZigq
aW5mbykpOwo+ICttZW1jcHkoaW5mbywgYmlvcy0+aW50ZWdyYXRlZF9pbmZvLCBzaXplb2Yoc3Ry
dWN0IGludGVncmF0ZWRfaW5mbykpOwo+IAo+ICAvKiBMb29rIGZvciBjaGFubmVsIG1hcHBpbmcg
Y29ycmVzcG9uZGluZyB0byBjb25uZWN0b3IgYW5kIGRldmljZSB0YWcgKi8KPiAgZm9yIChpID0g
MDsgaSA8IE1BWF9OVU1CRVJfT0ZfRVhUX0RJU1BMQVlfUEFUSDsgaSsrKSB7Cj4gLS0KPiAyLjI1
LjEKPiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBo
dHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMl
M0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQt
Z2Z4JmFtcDtkYXRhPTA0JTdDMDElN0NKaWFuc29uZy5DaGVuJTQwYW1kLmNvbSU3Q2FhMWYwZTAx
OTY1ODRhYzQxNDUyMDhkOGI5NDJmZjUwJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4
M2QlN0MwJTdDMCU3QzYzNzQ2MzA0NDY5NTYwODQ3OCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhl
eUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZD
STZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1PaGxCTW0wM3RnMEpVY3RqcEV0Tzg4aEwxRG51NXd4
dDdLZXVvam02MU5RJTNEJmFtcDtyZXNlcnZlZD0wCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
