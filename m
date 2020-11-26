Return-Path: <SRS0=2cAG=FA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A597C56202
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 14:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7315020872
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 14:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WnRb25BB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7315020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A8EB88FE2;
	Thu, 26 Nov 2020 14:44:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE24E88FE2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 14:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcjuO62K3EBSFhPYYeq+GdqP71wCZMVJnSH+tqf00hG8dE33C365a1ZuSvcm6CajeVBN06bABdD97TE+Kiy36Mh63IlVoOr6vXweaac+my7S/NOfdEDJl61IqvoUyJDdynkhz/WbKF5wxPvdKiFQYs9gPRZwbVQNCxOSXLqs5FHZJvPLPa0GnTTxBAVqRFkAcRvSi7bHHGt2+GJdW6QSu8+nzr4PkjGwSd14Z4QVK6VFwYcWLRhMVAp2myF6k49PjnK8jOMnx6+4wNkSy4u+B6VZDSlAKkV0gB9eE7v0QWlbayWnhw1zIp/SHuhOetpESQz5zYKbEsj9PL/ISX4Tyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZMUOGJK4y5IuKE2nwezuJgwUNhGxKw1nZCrT/lECVY=;
 b=V34oqkG5cxq7zB+CKfpiJjsH7RYIPmDqh1N+KEqTKGy2oZAG/VFSOFiu8fZDbZAwTDroULiBI2G8GF1nm2qZvrvgeZ7jQ4ZtOSgj3aCvmXODJuZefAHfRXJ1VxzkM/RQOpOSgDGRO/oQLzuW3ZXyE432EM0bfXe0hz1vvcYAo+bMOpf10C7lxh9yqRcp9ND3vlF8Tgy0d8cXmlddoZlTf30YJ9Pp6DdNzKn7+NmcnrngfXaSm10fkkqijJjjMDctDQutXbArZjQWLJ3Xf9rQrYMaU/NumrafPoeXu5SSqlSz70lyOkKl59ruHdl/PbBj9cgxl+wbaviQqYzDqkCPcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZMUOGJK4y5IuKE2nwezuJgwUNhGxKw1nZCrT/lECVY=;
 b=WnRb25BBiW1dqXfanTK1tiPKj/M5GmDN3uo6SNDN8bTOp1lkyg5gVP9XbcSl7MpmV3WCFIdS8Xtv8ApXoJHyRtwXe3Rt/ZwZFlHCOl3FfiqsLZrGYOp+0fbeFkDSAypyeD9yDGewtYBWdzPUkb9FpopP3PMAhnuOi3aRrGqYI+Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9)
 by BL0PR12MB2418.namprd12.prod.outlook.com (2603:10b6:207:4d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Thu, 26 Nov
 2020 14:44:27 +0000
Received: from MN2PR12MB4374.namprd12.prod.outlook.com
 ([fe80::b835:bfbc:7e12:fe5]) by MN2PR12MB4374.namprd12.prod.outlook.com
 ([fe80::b835:bfbc:7e12:fe5%5]) with mapi id 15.20.3611.023; Thu, 26 Nov 2020
 14:44:26 +0000
Subject: Re: [PATCH] drm/amd/display: Clear dc remote sinks on MST disconnect
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201126143105.32016-1-aurabindo.pillai@amd.com>
 <ab9f847e-d819-7ff0-f677-c2ee5587b2ae@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <80920fc9-e9b9-c0b1-a829-66a76a25443a@amd.com>
Date: Thu, 26 Nov 2020 09:44:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <ab9f847e-d819-7ff0-f677-c2ee5587b2ae@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::19) To MN2PR12MB4374.namprd12.prod.outlook.com
 (2603:10b6:208:266::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 14:44:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff187947-a6b1-4451-7ac4-08d89219c59d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2418:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB24187DBF53AE6E8C159C8B098CF90@BL0PR12MB2418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jv1sRLbhJ7PMM8kwz2fi5l85PaG1xAJf9kKGEdzDA0wBbaGG1NxQYlMYeDmAwBdwY8EVAl3/YuhdJ9nbFA3GKgfjly3muLb/psNMLPbblCCMvm1NfMYT0y+U8Ay8uLkSszHNXu+qydFn96tm8sNfyIz3GniwqUrOIfkehtrd01SZRxdrI/DNo56/sKd4Rg7fE0k3ISHQKSrkG4DwoOFMm5KhUDScwOtycpt7oRtBAAl9JfuSA5IfAwv60yroiSLz2mJfbHYVPx795uQ2zwKpMb5vOMTG1fXs1Fg9dHtA3kZqDFWRG/jNsgbAnfAcxeRGKhCp783NppFuiudCMGL7CZjyFHN4MJjFIL7R64SfjSsq4UAmfzgd48rMGy4u/U188MY0vUtKmJfYmV6jJRgGctgAqOsBVvkNPc2gTifU71s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(956004)(66476007)(2616005)(66946007)(66556008)(6486002)(2906002)(83380400001)(31696002)(26005)(316002)(478600001)(44832011)(45080400002)(16526019)(186003)(4001150100001)(36756003)(8676002)(8936002)(52116002)(966005)(4326008)(86362001)(16576012)(5660300002)(31686004)(110136005)(53546011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OVo1ZGxIWjVQaDlVdGs3UTBmTllhNmlOanJjMFdlYmd4NXY0cTJsNzJ2ZHhQ?=
 =?utf-8?B?Vzl6Z1ErSm9ENFc0TEdKMThPZGVHTS9WT1p5R2poVjFJNUFCemM5OVBvclVl?=
 =?utf-8?B?cHdqL3NPOFZPZFA4b3k3RGdSUUs1NWgydW92VzZTTVIzWXRaRXBkaEpnSXRE?=
 =?utf-8?B?cHhRSHJ3QmV4ZlQreGVacjlMcUcxNGYwaVV2d3FQK1c4REE1dnQydERxTGpi?=
 =?utf-8?B?eHphNkdIckJ0N3ZLYTAwakdrZThOaGJDTENaMkRUeXhOYTRFN3A1ekx6dzhX?=
 =?utf-8?B?RkN5T053eTQ0N3NQM1dPb21KZ2dUNlpLaUN2L293amJacHpPN1hWZHNYYTl4?=
 =?utf-8?B?UVYzMG4rRU1pM3VMazlRejBPMDY3NVNvakNhaHVQMm1ZMzlmcm12bllLckN5?=
 =?utf-8?B?WUs3TmdyRTFlMzEvc3NJVDU0VWhvWmt1WHRicmRESk5Ycyt4dGo0ekVyTXNC?=
 =?utf-8?B?T2xrcytad29rU3hOcGhXVjFyRXU3Zy9xUldFWVFndEhJTkpsT3VCQ2pYeVBk?=
 =?utf-8?B?b0FrY3lKVkFidHBiRlNJS0FCWGExSS92SXNuUFVMOWFjVWg5cUNtaUF2aHlk?=
 =?utf-8?B?YXRXamxQTVc4Z1U2MUVYQkREbFg5bjV4S2lSMEtYanFFYzZXRnFDZDZ6UmxI?=
 =?utf-8?B?bzlKbjBiZXErY3lDV0hKR0RnVWxWMTZkQS8ra0hDekxhN1E5bk9JQ2RqYy8x?=
 =?utf-8?B?NmdjNHZGRDFrdGF1c2Q4elZ2Rmp4TzdMQ1hKeFNEeDgyYTN0ZkZnT0FlcEph?=
 =?utf-8?B?OXRMckp2TmVCWjl1Ui9XQ0gvNmkzZi82REM1eXZaZHhrSFA0Vk04YnNRUU0v?=
 =?utf-8?B?Mk8wQ0FoUmlhUjlnZFhHMDM2bjlKcVhaeTFPRmIyV2lXaEoyY2pOd0RQclQ3?=
 =?utf-8?B?Y2tJZ1laNEFENTJRMllYQlVTNkkwNmo3SmF6UXp4TG0zTHRiY1BCdy9jZzJz?=
 =?utf-8?B?WmYrdWtHSWE1aVo4OUpjNkh0YXNObk9QQ2duL1ZBVWxrVXcxRXU4VCs1dDZ3?=
 =?utf-8?B?WU5YRlV2bnN3WkhZZm15N3AvL2lmemtFQ0FTMk9LOTBmcklocnRkK0p3V0hQ?=
 =?utf-8?B?eWVSYUNCdGUzTDNlU09JOEFKbVZjOXk2Y2cvalRxbGZIMlRFOGpyYlo5TzNE?=
 =?utf-8?B?YVpwYWcwNlBYVkswUW5OZ3BuWmJINCtPQldJVlZuOXpDRFlaR003cHRtVnlj?=
 =?utf-8?B?MDU1T010NURpejVjV0JYcmczdDU4Vm5Qd3Z5MzhOMlA4Q1kxZmM5VkdDTjRm?=
 =?utf-8?B?WnplNCtvRFpGQ0NvZUJUcEZOTlZnWTNobk5QT2Zxa2pjZlRLUzVXeVJER2N5?=
 =?utf-8?Q?tlaz/6PcJMsgqIFGi5aGh6EBfg5+Y5Sis5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff187947-a6b1-4451-7ac4-08d89219c59d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 14:44:26.1957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9b1dWvsbh3OiBeZpcoUNbcgPbhZSKV4ASytlNbZY3WIswL3BgSFOsqT5uxQuzVtCu/MGj7XaOT6jq3yFn212g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2418
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
Cc: Bhawanpreet.Lakha@amd.com, aurabindo.pilai@amd.com, Eryk.Brol@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0xMS0yNiA5OjM1IGEubS4sIEthemxhdXNrYXMsIE5pY2hvbGFzIHdyb3RlOgo+IE9u
IDIwMjAtMTEtMjYgOTozMSBhLm0uLCBBdXJhYmluZG8gUGlsbGFpIHdyb3RlOgo+PiBbV2h5Jkhv
d10KPj4gUmVjZW50IGNoYW5nZXMgdG8gdXBzdHJlYW0gbXN0IGNvZGUgcmVtb3ZlIHRoZSBjYWxs
YmFjayB3aGljaAo+PiBjbGVhcmVkIHRoZSBpbnRlcm5hbCBzdGF0ZSBmb3IgbXN0LiBNb3ZlIHRo
ZSBtaXNzaW5nIGZ1bmN0aW9uYWxpdHkKPj4gdGhhdCB3YXMgcHJldmlvdXNseSBjYWxsZWQgdGhy
b3VnaCB0aGUgZGVzdHJveSBjYWxsIGJhY2sgZm9yIG1zdCAKPj4gY29ubmVjdG9yCj4+IGRlc3Ry
b3kKPj4KPj4gU2lnbmVkLW9mZi1ieTogQXVyYWJpbmRvIFBpbGxhaSA8YXVyYWJpbmRvLnBpbGxh
aUBhbWQuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBFcnlrIEJyb2wgPGVyeWsuYnJvbEBhbWQuY29t
Pgo+PiAtLS0KPj4gwqAgLi4uL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVy
cy5jIHwgMjIgKysrKysrKysrKysrKysrKystLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZG1faGVscGVycy5owqDCoCB8wqAgMiArLQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQs
IDIxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZWxwZXJzLmMgCj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVy
cy5jCj4+IGluZGV4IGI3ZDdlYzNiYTAwZC4uZDhiMGYwN2RlYWYyIDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZWxwZXJzLmMK
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1f
aGVscGVycy5jCj4+IEBAIC00MTgsOSArNDE4LDEwIEBAIGJvb2wgZG1faGVscGVyc19kcF9tc3Rf
c3RhcnRfdG9wX21ncigKPj4gwqAgdm9pZCBkbV9oZWxwZXJzX2RwX21zdF9zdG9wX3RvcF9tZ3Io
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGNfY29udGV4dCAqY3R4LAo+PiAtwqDCoMKg
wqDCoMKgwqAgY29uc3Qgc3RydWN0IGRjX2xpbmsgKmxpbmspCj4+ICvCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3QgZGNfbGluayAqbGluaykKPj4gwqAgewo+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVf
ZG1fY29ubmVjdG9yICphY29ubmVjdG9yID0gbGluay0+cHJpdjsKPj4gK8KgwqDCoCB1aW50OF90
IGk7Cj4+IMKgwqDCoMKgwqAgaWYgKCFhY29ubmVjdG9yKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBEUk1fRVJST1IoIkZhaWxlZCB0byBmaW5kIGNvbm5lY3RvciBmb3IgbGluayEiKTsKPj4gQEAg
LTQzMCw4ICs0MzEsMjUgQEAgdm9pZCBkbV9oZWxwZXJzX2RwX21zdF9zdG9wX3RvcF9tZ3IoCj4+
IMKgwqDCoMKgwqAgRFJNX0lORk8oIkRNX01TVDogc3RvcHBpbmcgVE0gb24gYWNvbm5lY3Rvcjog
JXAgW2lkOiAlZF1cbiIsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFjb25uZWN0b3Is
IGFjb25uZWN0b3ItPmJhc2UuYmFzZS5pZCk7Cj4+IC3CoMKgwqAgaWYgKGFjb25uZWN0b3ItPm1z
dF9tZ3IubXN0X3N0YXRlID09IHRydWUpCj4+ICvCoMKgwqAgaWYgKGFjb25uZWN0b3ItPm1zdF9t
Z3IubXN0X3N0YXRlID09IHRydWUpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGRybV9kcF9tc3Rf
dG9wb2xvZ3lfbWdyX3NldF9tc3QoJmFjb25uZWN0b3ItPm1zdF9tZ3IsIGZhbHNlKTsKPj4gKwo+
PiArwqDCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IE1BWF9TSU5LU19QRVJfTElOSzsgaSsr
KSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChsaW5rLT5yZW1vdGVfc2lua3NbaV0g
PT0gTlVMTCkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4g
Kwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAobGluay0+cmVtb3RlX3NpbmtzW2ldLT5z
aW5rX3NpZ25hbCA9PQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNJR05BTF9U
WVBFX0RJU1BMQVlfUE9SVF9NU1QpIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBkY19saW5rX3JlbW92ZV9yZW1vdGVfc2luayhsaW5rLCBsaW5rLT5yZW1vdGVfc2lua3NbaV0p
Owo+IAo+IEluIGdlbmVyYWwgSSB0aGluayB0aGlzIHBhdGNoIGxvb2tzIGZpbmUsIGFuZCB5b3Ug
Y2FuIGhhdmUgdGhlOgo+IAo+IFJldmlld2VkLWJ5OiBOaWNob2xhcyBLYXpsYXVza2FzIDxuaWNo
b2xhcy5rYXpsYXVza2FzQGFtZC5jb20+Cj4gCj4gQnV0IEkgdGhpbmsgdGhhdCB0aGlzIGxvb3Ag
aXMgcmVkdW5kYW50IC0gZGNfbGlua19yZW1vdmVfcmVtb3RlX3NpbmsgCj4gc2hvdWxkIGJlIHJl
bW92aW5nIGFsbCB0aGUgcmVtb3RlIHNpbmtzLiBOb3Qgc3VyZSBpZiByZW1vdGVfc2lua3MgY2Fu
IAo+IHN0YXJ0IGF0IGFuIGluZGV4IG90aGVyIHRoYW4gMCB0aG91Z2guCj4gCgpJJ2QgcHJlZmVy
IHdlIGNsZWFuIHRoaXMgdXAgaWYgaXQncyByZWR1bmRhbnQuIE90aGVyd2lzZSByZWR1bmRhbnQg
Y29kZSAKc3RheXMgYXJvdW5kIGZvcmV2ZXIgYW5kIG1ha2VzIGZ1dHVyZSBkZWJ1ZyBtb3JlIGN1
bWJlcnNvbWUuCgpIYXJyeQoKPiBSZWdhcmRzLAo+IE5pY2hvbGFzIEthemxhdXNrYXMKPiAKPj4g
Kwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChhY29ubmVjdG9yLT5kY19z
aW5rKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkY19zaW5r
X3JlbGVhc2UoYWNvbm5lY3Rvci0+ZGNfc2luayk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBhY29ubmVjdG9yLT5kY19zaW5rID0gTlVMTDsKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFjb25uZWN0b3ItPmRjX2xpbmstPmN1cl9s
aW5rX3NldHRpbmdzLmxhbmVfY291bnQgCj4+ID0gMDsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB9Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4gK8KgwqDCoMKgwqDC
oMKgIH0KPj4gK8KgwqDCoCB9ID7CoMKgIH0KPj4gwqAgYm9vbCBkbV9oZWxwZXJzX2RwX3JlYWRf
ZHBjZCgKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbV9o
ZWxwZXJzLmggCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtX2hlbHBlcnMu
aAo+PiBpbmRleCBiMmNkODQ5MWM3MDcuLjA3ZTM0OWIxMDY3YiAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtX2hlbHBlcnMuaAo+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1faGVscGVycy5oCj4+IEBAIC0xMTMsNyArMTEzLDcg
QEAgYm9vbCBkbV9oZWxwZXJzX2RwX21zdF9zdGFydF90b3BfbWdyKAo+PiDCoCB2b2lkIGRtX2hl
bHBlcnNfZHBfbXN0X3N0b3BfdG9wX21ncigKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBk
Y19jb250ZXh0ICpjdHgsCj4+IC3CoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgZGNfbGluayAq
bGluayk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGNfbGluayAqbGluayk7Cj4+IMKgIC8q
Kgo+PiDCoMKgICogT1Mgc3BlY2lmaWMgYXV4IHJlYWQgY2FsbGJhY2suCj4+IMKgwqAgKi8KPj4K
PiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFt
ZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRw
czovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4
JmFtcDtkYXRhPTA0JTdDMDElN0NIQVJSWS5XRU5UTEFORCU0MGFtZC5jb20lN0M3NTc2ODY2YTA1
MTU0YjY2Y2RiMjA4ZDg5MjE4OThkYSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNk
JTdDMCU3QzAlN0M2Mzc0MTk5ODE2NDQ0NDQ5MjAlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlK
V0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2
TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9c203anZieFclMkJnRVVldldnakFDeWRuanVpRTdTZ3R1
bk1CVUlwTFQ5OXI0JTNEJmFtcDtyZXNlcnZlZD0wIAo+IApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
