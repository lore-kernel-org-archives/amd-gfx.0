Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09183C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E0D23B28
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E0D23B28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E1826E051;
	Tue,  8 Dec 2020 19:04:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E1D66E051
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 19:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqgmUGa6Yug8OZbKj6YdkOoN8PlLUgeYjiNY8mtRzR9PQKqRNHlv+O4woaq+zexrOqli/qPOISv9qxmk4/h/aaPIstNqXqBpq6z4dsoDBe16fu1SV/GeUtFtRBIdyz/24k/wzTNSHpg/3jsWscAZgsurbnqpFEwsPd1mSV50B3BbrGqeUTmVif1EWuMYUQb8WCMz3CX5UH4ftddrSQaHe/U879Nvktt8iDhUGiEyaAkYMcH8YoLSYI/70TkGRDoAhzOXrkPPlE/m9AOOEGbL2BlnlTnOuUPpB+H2mIWpF3U9Ai0W17hnend8iUHamIhQIbEMss8MhLwqgZpVlZk+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOA7NBV2mMEoDliLeHoMKIAjWsCR3XPNJLNt5TFIqkk=;
 b=emgKsmWPmH01nGgF0wxbLjszVJfXAzs/HV/tT6upSBwpP0rzETr7bmk5B6vAbnuto8DeO89wT8jx98F5jwVvcbDtBL1YMr0xUWWmYgk91OfFqBZMFmYUFzMoAO0pluh0WEwicVuYm0AlLcP0RRBrsNxxAaiFhRCvAgfc63P4emTpL7zBIDJyN/GhJL+GBOA3grdAsj32mLcy8RRpdVS7lTU6cD0nG5UoFayFBBUMxQNY7tzO3yxkA64VJcrSMwjWMpLamQeAFbfP4hNpk3pM3jglwbIx8hkUqSi8zIOGErqWPKmpskJxa7uflBeuYMtrFaAyLaGGlTNtok3vA8KYYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOA7NBV2mMEoDliLeHoMKIAjWsCR3XPNJLNt5TFIqkk=;
 b=jqZ5ShogztaSDaMXUYUiQE4Q0ORBMoJ3tDQ/uaPnlwae+Ok47qXiIAj94c5IHqoiOMGTARChJc1vBOCZyUD5KYzV3d/WtVtbt02KSjzWsx3ZSdDu1STYWG6zNHEudBP8LrmmKwpKVgVvL/3bmtuDiz8U8xE7WnYK/4Wf44uY/bo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3792.namprd12.prod.outlook.com (2603:10b6:208:16e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 8 Dec
 2020 19:04:24 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3654.012; Tue, 8 Dec 2020
 19:04:24 +0000
Subject: Re: [PATCH v2 1/1] drm/amdgpu: clean up bo in vce and vcn test
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <772be2aa-56f0-14d5-3de4-343c556e1dc2@gmail.com>
 <20201208185916.4569-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2823362e-9a76-b3f7-6d26-7143d7a8f40c@amd.com>
Date: Tue, 8 Dec 2020 20:04:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201208185916.4569-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM3PR05CA0091.eurprd05.prod.outlook.com
 (2603:10a6:207:1::17) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR05CA0091.eurprd05.prod.outlook.com (2603:10a6:207:1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Tue, 8 Dec 2020 19:04:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 498db946-d78e-44f1-5d8e-08d89bac13c9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3792B2DD3BAF3650C068D20583CD0@MN2PR12MB3792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHHhhxUXy4JS1hgeQg8TwrCfwN2DXMk1BkaxZm9hhw5Ps6uRMtFudSayl41cTM4SFPIZInRWB3cbehSyrqJj0+ZDKxpsZSbMFKmPNV7M0vAkGC/eh7ecQdU1T5CPzYPGgwfsvkJJFjISNzBLY6R7eT9ogu2zDjENgLkPExQVqCm7u8Gn7GSp/6xiyCZ9DLlrAHdG5DZaoIsv+YUVNcITnvzcLhb1S3GS0pVm+7kqoj2rEaqNOKQI+ZDN7rDwWwL0gXFlvU4VqE0WE11a/znbdrwj5D1MrDvcjPgyLp/Jdu5qE4drPwtf7fLPGn/BfblMlgR4raeHOcMPKnGRE2VQBOQJMfbo+kb7M9qs1Yz1UYKe7uvelpX7F/LlyZtGS6UCV+Xh0iu3TfnWyYf9VSYYIY+Xvb7cOpb7AenClz7/iVcxORCUsqiXjlmNVZuC5ygW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(5660300002)(186003)(66946007)(8676002)(66476007)(2906002)(6486002)(8936002)(4326008)(66574015)(86362001)(2616005)(34490700003)(31686004)(31696002)(52116002)(66556008)(36756003)(83380400001)(508600001)(6666004)(16526019)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eU0weXlucnkzWlVBQ3hZcGZzcGdJVHQydjY5NCt3UVpRbStBUk43Zkx6a0M0?=
 =?utf-8?B?SHI3ejhOTlo1OGRhd2VMVlY0UkhuUmQrL2dKNnRJYWNjWjBRTDBMdytob3Vm?=
 =?utf-8?B?YTNueElHUkk0a2pjNVltRDBJdk5ZSEZiZ29VYmVwK1dtZlBvTFBkMkppTklw?=
 =?utf-8?B?NlRJQzRmNnJhVFhFYVF4RlZaQm01dTNGdXJCcGxPVWYybG5QMzQzclRJY3Za?=
 =?utf-8?B?bm8vanpSZFhlMVFyamJsMElLczRTc2lsNXhIL0REeERLSXpUWEN4STBWM28w?=
 =?utf-8?B?aWhIT2dQOEdCano2UWF1T2MzY3BBQklmRno3MytCUW0ycjVBaXhVUGplUmU1?=
 =?utf-8?B?SEFoYTNGcmZVSDVaZm1kempiV0V5TTFQcHdpQjJSeitHb2syT0J6TGtYeURv?=
 =?utf-8?B?ak5tdHZSOGpXdXN5WUJ4bEJWeGgvcW5MREgwMFJ2TEpyWERVWEJZVzNNSmFS?=
 =?utf-8?B?WENLVGU4cXVPczRoNmtRSDdvK2lCK3RXZlA4Nk9BdmJROGV3aFNXSWp3YXVr?=
 =?utf-8?B?ejlzaDZLOE90MUNHYjJSMG9ZeUdrNmdaVWl0Q3JXdExTcTFoUUhRYXZ2VGxH?=
 =?utf-8?B?WTZKRmxoK1FCZGZPOUNZdzgreWRKcWh0N2Fod21GaVErWDB5RkljRnVjT2Fk?=
 =?utf-8?B?aWwvQVRXNU1IbHo3U0huTTZrUFA2VVNENjF2bWlTMUdVdUU1TmtmRDNnSGRL?=
 =?utf-8?B?SG5keElQMW1ONkluWU9hbENPaTJJU2hmRmZ5eFVSMEdkcW5ueVh1UE82QWY1?=
 =?utf-8?B?aVFvQXBsM2hjaFhSN3I5aTVJakpxaGhBNlNxc3Y0ZWRlSkhlbHErd0ZVTmdQ?=
 =?utf-8?B?TkE0ZjI1ZDF5WGpGcVNGYVhFUlZubWNVemVJandvWHZLUEludy9oOFZRVEVh?=
 =?utf-8?B?MERNTnEzSEVXNmZ0Z0piK1ZjeS92NzhpeHVmdlRqZzluZWhCb21nWHI4UnpV?=
 =?utf-8?B?MTlsSUM1NnUrMGJlVmVnOUdBZDhuaWx1amxKMmVxQWs2ZkJxKzI3enA0RVZ6?=
 =?utf-8?B?cVUyVktQQnA5ak42UjVhQjF0V3NXS25TVVl2clBYWVdRNU5BZmY1Vjk2cDhi?=
 =?utf-8?B?OGNjbDI0d1VnYk0rNnhIVXBPb2t3dGJXWXoxY2NKUnJqcjRuQ0xJb0ZNYVVX?=
 =?utf-8?B?VC9BMkE3TWFhVTdweGxiN1lXc0txdHZYU01ZMVVNQnhPeHRIdEhuMFBJNzB0?=
 =?utf-8?B?Q1RIT2NJQUlRNm9LTDBWa29aRzU4MWE1OFNPUXJVRDhyTXpqaVB5aXhPaVda?=
 =?utf-8?B?bnI5YW1lUmlKeURTZ0dXeTBEU2xJbThvcGNwTFdBd2gyTDlTcjhvcWlRdTB3?=
 =?utf-8?B?NnhpbDdQWG91VFZ2MjIwdUJFTFNJL1B6NW1sdHFFdVh6dEVPcmJlV2FNSFhw?=
 =?utf-8?B?eXdWSDdsbTJDTFRwbTZYaGJvdndTNUlFeTZ4TkwyUU9ZRG1TS0RoZjhsNUxr?=
 =?utf-8?Q?9ironzgp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 19:04:24.1049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 498db946-d78e-44f1-5d8e-08d89bac13c9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UanaSOWJUpu0ATOU97+frM7U2g7oAojcMbu5BhrozAwlW7lGhevPcCiB3Fo9kYNq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3792
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDguMTIuMjAgdW0gMTk6NTkgc2NocmllYiBOaXJtb3kgRGFzOgo+IEJPIGNyZWF0ZWQgd2l0
aCBhbWRncHVfYm9fY3JlYXRlX3Jlc2VydmVkKCkgd2Fzbid0IGNsZWFuCj4gcHJvcGVybHkgYmVm
b3JlLCB3aGljaCBjYXVzZXM6Cj4KPiBbICAgMjEuMDU2MjE4XSBXQVJOSU5HOiBDUFU6IDAgUElE
OiA3IGF0IGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmM6NTE4IHR0bV9ib19yZWxlYXNlKzB4
MmJmLzB4MzEwIFt0dG1dCj4gPHNuaXA+Cj4gWyAgIDIxLjA1NjQzMF0gQ2FsbCBUcmFjZToKPiBb
ICAgMjEuMDU2NTI1XSAgYW1kZ3B1X2JvX3VucmVmKzB4MWEvMHgzMCBbYW1kZ3B1XQo+IFsgICAy
MS4wNTY2MzVdICBhbWRncHVfdmNuX2RlY19zZW5kX21zZysweDFiMi8weDI3MCBbYW1kZ3B1XQo+
IFsgICAyMS4wNTY3NDBdICBhbWRncHVfdmNuX2RlY19nZXRfY3JlYXRlX21zZy5jb25zdHByb3Au
MCsweGQ4LzB4MTAwIFthbWRncHVdCj4gWyAgIDIxLjA1Njg0M10gIGFtZGdwdV92Y25fZGVjX3Jp
bmdfdGVzdF9pYisweDI3LzB4MTgwIFthbWRncHVdCj4gWyAgIDIxLjA1NjkzNl0gIGFtZGdwdV9p
Yl9yaW5nX3Rlc3RzKzB4ZjEvMHgxNTAgW2FtZGdwdV0KPiBbICAgMjEuMDU3MDI0XSAgYW1kZ3B1
X2RldmljZV9kZWxheWVkX2luaXRfd29ya19oYW5kbGVyKzB4MTEvMHgzMCBbYW1kZ3B1XQo+IFsg
ICAyMS4wNTcwMzBdICBwcm9jZXNzX29uZV93b3JrKzB4MWRmLzB4MzcwCj4gWyAgIDIxLjA1NzAz
M10gIHdvcmtlcl90aHJlYWQrMHg0Ni8weDM0MAo+IFsgICAyMS4wNTcwMzRdICA/IHByb2Nlc3Nf
b25lX3dvcmsrMHgzNzAvMHgzNzAKPiBbICAgMjEuMDU3MDM3XSAga3RocmVhZCsweDExYi8weDE0
MAo+IFsgICAyMS4wNTcwMzldICA/IF9fa3RocmVhZF9iaW5kX21hc2srMHg2MC8weDYwCj4gWyAg
IDIxLjA1NzA0M10gIHJldF9mcm9tX2ZvcmsrMHgyMi8weDMwCj4KPiBTaWduZWQtb2ZmLWJ5OiBO
aXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+CgpBdCBzb21lIHBvaW50IHdlIHNob3VsZCBw
cm9iYWJseSBzd2l0Y2ggdG8gdXNpbmcgYW4gU0EgQk8gYW5kIHN0b3AgdGhpcyAKbWVzcyBoZXJl
LgoKQnV0IGZvciBub3cgdGhlIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IAo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92Y2UuYyB8IDIgKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92Y24uYyB8IDkgKysrKysrLS0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmNlLmMKPiBpbmRleCBlY2FhMmQ3NDgzYjIuLjc4YTRkZDliZjExZiAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNlLmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNlLmMKPiBAQCAtMTE1MSw2ICsxMTUxLDYg
QEAgaW50IGFtZGdwdV92Y2VfcmluZ190ZXN0X2liKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywg
bG9uZyB0aW1lb3V0KQo+ICAgZXJyb3I6Cj4gICAJZG1hX2ZlbmNlX3B1dChmZW5jZSk7Cj4gICAJ
YW1kZ3B1X2JvX3VucmVzZXJ2ZShibyk7Cj4gLQlhbWRncHVfYm9fdW5yZWYoJmJvKTsKPiArCWFt
ZGdwdV9ib19mcmVlX2tlcm5lbCgmYm8sIE5VTEwsIE5VTEwpOwo+ICAgCXJldHVybiByOwo+ICAg
fQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPiBpbmRleCA3ZTE5YTY2
NTY3MTUuLjkyMWI4MTA1NGMxYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmNuLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdmNuLmMKPiBAQCAtNDY1LDYgKzQ2NSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Zjbl9kZWNf
c2VuZF9tc2coc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+ICAgCXN0cnVjdCBhbWRncHVfam9i
ICpqb2I7Cj4gICAJc3RydWN0IGFtZGdwdV9pYiAqaWI7Cj4gICAJdWludDY0X3QgYWRkcjsKPiAr
CXZvaWQgKm1zZyA9IE5VTEw7Cj4gICAJaW50IGksIHI7Cj4gICAKPiAgIAlyID0gYW1kZ3B1X2pv
Yl9hbGxvY193aXRoX2liKGFkZXYsIDY0LAo+IEBAIC00NzQsNiArNDc1LDcgQEAgc3RhdGljIGlu
dCBhbWRncHVfdmNuX2RlY19zZW5kX21zZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCj4gICAK
PiAgIAlpYiA9ICZqb2ItPmlic1swXTsKPiAgIAlhZGRyID0gYW1kZ3B1X2JvX2dwdV9vZmZzZXQo
Ym8pOwo+ICsJbXNnID0gYW1kZ3B1X2JvX2twdHIoYm8pOwo+ICAgCWliLT5wdHJbMF0gPSBQQUNL
RVQwKGFkZXYtPnZjbi5pbnRlcm5hbC5kYXRhMCwgMCk7Cj4gICAJaWItPnB0clsxXSA9IGFkZHI7
Cj4gICAJaWItPnB0clsyXSA9IFBBQ0tFVDAoYWRldi0+dmNuLmludGVybmFsLmRhdGExLCAwKTsK
PiBAQCAtNDkyLDcgKzQ5NCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Zjbl9kZWNfc2VuZF9tc2co
c3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+ICAgCj4gICAJYW1kZ3B1X2JvX2ZlbmNlKGJvLCBm
LCBmYWxzZSk7Cj4gICAJYW1kZ3B1X2JvX3VucmVzZXJ2ZShibyk7Cj4gLQlhbWRncHVfYm9fdW5y
ZWYoJmJvKTsKPiArCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYm8sIE5VTEwsICh2b2lkICoqKSZt
c2cpOwo+ICAgCj4gICAJaWYgKGZlbmNlKQo+ICAgCQkqZmVuY2UgPSBkbWFfZmVuY2VfZ2V0KGYp
Owo+IEBAIC01MDUsNyArNTA3LDcgQEAgc3RhdGljIGludCBhbWRncHVfdmNuX2RlY19zZW5kX21z
ZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCj4gICAKPiAgIGVycjoKPiAgIAlhbWRncHVfYm9f
dW5yZXNlcnZlKGJvKTsKPiAtCWFtZGdwdV9ib191bnJlZigmYm8pOwo+ICsJYW1kZ3B1X2JvX2Zy
ZWVfa2VybmVsKCZibywgTlVMTCwgKHZvaWQgKiopJm1zZyk7Cj4gICAJcmV0dXJuIHI7Cj4gICB9
Cj4gICAKPiBAQCAtNzYxLDYgKzc2Myw3IEBAIGludCBhbWRncHVfdmNuX2VuY19yaW5nX3Rlc3Rf
aWIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBsb25nIHRpbWVvdXQpCj4gICBlcnJvcjoKPiAg
IAlkbWFfZmVuY2VfcHV0KGZlbmNlKTsKPiAgIAlhbWRncHVfYm9fdW5yZXNlcnZlKGJvKTsKPiAt
CWFtZGdwdV9ib191bnJlZigmYm8pOwo+ICsJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZibywgTlVM
TCwgTlVMTCk7Cj4gKwo+ICAgCXJldHVybiByOwo+ICAgfQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
