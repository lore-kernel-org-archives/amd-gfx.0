Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6D5C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 16:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B478F610FA
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 16:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B478F610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD0B6E0DF;
	Mon, 17 May 2021 16:54:53 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E496E0DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 16:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvhE/RDbQQp2cpKt20OXLyJ4kbdlKVUTGregfXwxH3x0vp/QJv7SydBQzIEFKqurw/wMMGY+EgaWY7wcLEfl6nM/KHOrHumO2YI1T4NlgZ98KHLewRXuBo75/TCEuTepliaVZZ81HUOiI4SUaMdHPSmSotUV2dQUllHvcMWmmHzvCbT6dHsInTbjEmXlcNgez41Kmm4GgvjDvWZCSlNc6aYPCkoStMq63eOSNgXaj8uf5fS0VcgBdvaQPeuEpdxepTgpRBq864OYl6V1gFlEW1yrFliuprC90F5SpDqyksz5RTZkI5o+uMJsYFE9tYUxwxQwDwOlQm3xUyByiJ3D/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANAx0/+JPRJkTdBqPXNd7bEuPJvWOTxhlD2w6qhdqlk=;
 b=e5r6jHQDF3TP2CJYt/10TMTLeVqAAtQSnq2q2VfKOM4rcECfv1P+7XJ6uJ/YpjCxChtmhoFAYXuj7Qc4Y4cqdkIPGq0UOWVi6CyOCosQc4eSDWoLjtTBlUA+S6jwx4TnG1a5DGTaZco/wxg5ch6ZyStYjQznbm+lnq5kmjzOeYNE6T2XuzHdWse5YalJ67X+SA59zU5LgDWHiUQ2UMKMIcYbO5VtMEUSu0MzqJfm0qVQIdHHOzZWwwDWv62b9oFBntysbl2LvEvIjfr3tnpqPfqPhcFXPtr/kaPwBcbUBMBZl81EC22HkxVOjQG9zVZNyzOyH7X/1pvdGRLXy9ubIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANAx0/+JPRJkTdBqPXNd7bEuPJvWOTxhlD2w6qhdqlk=;
 b=VUTXMXpHxcJfsaSIf9guqEu/0AbDbV/K6/ZHv/WxLAI26DDsEOp0HdoZubZQS7SP3UJiGODVDTKckmMKBtFi1sHk86BTumHnL9OqJM3Lc27zluJumSL4E7VtOmqRZpiZ2+tz/9p9W8Sqq1OJCPh60QDHBYj568PHbIZaRX8Zw0k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Mon, 17 May 2021 16:54:50 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 16:54:50 +0000
Subject: Re: [PATCH v2 1/2] drm/amdgpu: enhance amdgpu_vcn_suspend
To: Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1621263428-8631-1-git-send-email-James.Zhu@amd.com>
 <1621266752-11959-1-git-send-email-James.Zhu@amd.com>
 <85106a30-90ee-6e04-65cd-90f8e290c3d2@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <15dbc004-f5d6-6722-d7bf-40ade20d2cee@amd.com>
Date: Mon, 17 May 2021 12:54:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <85106a30-90ee-6e04-65cd-90f8e290c3d2@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40)
 To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.230.192] (165.204.55.251) by
 YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Mon, 17 May 2021 16:54:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06e4a9a9-752b-4200-5751-08d919547c01
X-MS-TrafficTypeDiagnostic: DM6PR12MB3355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33551F45747D0E4CD4F0EAC1E42D9@DM6PR12MB3355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQW6sE+wDsrwQuG8wgbGIUzhWbIIYkRvMgwy2U9BeY4GYmr0UGWDlJJh+akm/IVvucy0R6wo5PVYD4C4+kBdjvnDUYXDr5N2OjdG+8bYuXf383k+gtCVqtQ9GGVsoyAHAJwwo3QEQPfYoEzc2MavnorjlXQyQQjLUFyAfI61Dqz46HGyFz+6MlC4Y1LVPeIcZw33ImZBmW260aSpKnTPGPK2ZqIgKt2eQNZRX6mseNkFyxVnzDbTPV4paUklZvbNeqwpPYCqIoGrLXCwUJpKpFCHJDKK45jq3BQ3NSNj52wuWXgkBvBUa0eQPYzquHCHtF6OlA2JG/aO+ZuXjr/FGxfPODHngvIEiKjBVs2ExR3rbmzq8C348TZx92OCEaZhtnuzSvgr5lYb5tcPVquyBeb1V0xz/5f3MRnWksXvAYN/O2RaoTTrToKu74KJ3sleahDisG13sLH4rv+WRfCiv0lQjlVjQKbRvnAw41upFVjHITCRaiaOjur0qjpXg22bUiHQdCOQKfRQ5zTueVtrtkXBnbYfQEL3UpY4dXDoiVlmOtY4mJkthOq4b/6K2+F3h2cNo1219N2sV51+96eFdadtwiuQr4bCbBrBfnTMtkWmOwmqiqyZAhvnmEdMUnpij+cw3QiWa0/9EAPmo4MbM7odl64PbliZGW92DKxFzj/JXqC/GOcNTrzPP39TcN87cJXyExUpSzC2dRM3RsixUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(8936002)(83380400001)(2906002)(31696002)(478600001)(38100700002)(36756003)(36916002)(8676002)(66556008)(66476007)(5660300002)(53546011)(31686004)(26005)(316002)(16526019)(186003)(956004)(2616005)(16576012)(110136005)(52116002)(66946007)(38350700002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VHFMenNjYWlYN0crSDM0dlg5MjVlYWFEOVJnTGROaWRIQnQySFBSN1NZeE9E?=
 =?utf-8?B?UWlJMkJhUG9wbTRscHg0NHBWdHVxVjhqRllnTktlczVDR0NCOFF1aldRNTlR?=
 =?utf-8?B?Z2o3eGRvMllncHlsQXZWTExENlYxc1QrMit3eEgzbGprNHhBbmhPTXJQWi9H?=
 =?utf-8?B?Y1h5Q2JkWEdEU0ZrNnhQRk1iTllQdFNGN3I0K0w5QUJFcUhlVThFaXlCZWFF?=
 =?utf-8?B?OG85c04xQzJlblloQ0pRWFhseHJkWlcvYWU5T1Y5RlFqYmo1MzNVdGI5QmRL?=
 =?utf-8?B?eHNaSVBsUmxxMjBVd2Z3YXllWUlxbTMyMWxIV3lPUWtrYXQrSnlPei9BQkEr?=
 =?utf-8?B?cmJ0ZTBXeUdrR0xyaXUySjVjcDZ6ejl1Mlg0aFRVclNGaFEvTWVQWnRXUXFS?=
 =?utf-8?B?cmN2NVJZNXB3dVFVaXFZNWxZWUhhWE12UGlSNDVObDdaWlpISWQycnRsSW5a?=
 =?utf-8?B?RGI3YW9YK0tKZms4ckxyYTRTZE1GSU9aeFlXU1BLY1Y3RUJNQ29DUG5nZDY2?=
 =?utf-8?B?eXJBa29BT20xcXV3NlY0WUJtN2lwdnNtSUM1WDNUa2d5Lyt5bG4yUXFmTXlW?=
 =?utf-8?B?dzl1MU0yaTFhNG1YWXF6SkNMLzRzL2gydE9aQVBjU2FSa3F6RWNaTW1OSmlB?=
 =?utf-8?B?dEE0TGp5OXNqU0NmTmZVb1R5cFRLTHdLaHNWSGNBQU96ZFNuRTZmYU1YdGdC?=
 =?utf-8?B?Q1E4M20xcUVVRU5CVi9jWUVjblhnTU9ndWxTaExkVlBTUWtXQVM0dWdpOTds?=
 =?utf-8?B?SnlTaEVYVE9CZ3ZabGNUa3B4YmF1Mk5PNlRjNHVOaGRwam8wWjVzQ2FxOUd5?=
 =?utf-8?B?VzlVT0l6ZWg1eUJSbGRXWVhkMXpWNGUzbzhWQmc5dzE4QjJWMUtOek9vdjBU?=
 =?utf-8?B?aEMzYXBNTHdBbnhtVjIwYjJLNXJaVUx3clVxQ3dIdDZlNVIvSDJWZFB0ZkhN?=
 =?utf-8?B?eWt2UGhxdklGbUNPRENUUHRlWlhSL2tna05UOWtVSVF5ZHFES0RTbHVKbVI1?=
 =?utf-8?B?b3M0Z2w1QjdYYjBBSURIcy9hRXdMOXBXckdvTXZGM1lmK09wT1ZzNzFrNTdL?=
 =?utf-8?B?dFVTRzM0OHVTNk5GOXROMitDS3Jwa2RvV1hKVUxNSU1iYmRzTFJnWVN4bkhQ?=
 =?utf-8?B?aFdVWmhlTmY0UVlQaXVxY3VPUERPNGJZY01QS1BSM0NWaGR4YkNoL0tFbUJU?=
 =?utf-8?B?MnJCWjF3cHEvdWRYdlF3Z2pBWCtjalduMHlabUF0VURYTDNMZlhBQ3IvMC9x?=
 =?utf-8?B?c0JYbU5naFNWT0NvZjd6Z2FQTnJ1Y2RHeDEvVFFtZ1ZCSHJHYmZiRVJHaEZQ?=
 =?utf-8?B?SFVoRWtjeXhpWW1SQ3hRS3dYSEVOaFJxVGhJNlROWUVCOEdzdDlDYTNHWUEw?=
 =?utf-8?B?MWZ4WlZHMy95THNQSDNBTzdTNkJxaDhhWGlGaUZlZi9Jb092ODBPSFpNdnlv?=
 =?utf-8?B?WFNSTFdqNzJldXVJNG5Zd0I4Ujl3d0prVHNRZGY3eUppZEtIUHBXd0NsOXk2?=
 =?utf-8?B?dU5sNzlmSDgraW5KYlNQR1RWeGZHYkY4VVEzclhnREV3T0NIWjVSbzdpTlds?=
 =?utf-8?B?NmRhZ05UYUM3RGxFUGprVkc0TmxGRDlMZ1N4bEhSNlp5RkRBYUFXZGwwM3Rm?=
 =?utf-8?B?N3RKM0NYTEMrZ0ZNQnBhbGhRMWxlMXo4a3dHN0psaWYvdEdDcEEzbVRHVkRu?=
 =?utf-8?B?WWdNUlBGT09FQ3ZqalZDcG13ZjhYdnVNVkt2bG81VzZ5RnN6cDUwYzVWcXh1?=
 =?utf-8?Q?XdZpMd4h+3gP7cejuM3oeffJeItGEOhmqH/Kvhl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e4a9a9-752b-4200-5751-08d919547c01
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 16:54:49.9594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzlaOMme7a0+oqis0Wn+++2XfYOHyo+kt00NonQJAkrJQo5hXb0wdhJk4QyeRo3P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3355
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

SSBhbSB3b25kZXJpbmcgaWYgdGhlcmUgYXJlIHN0aWxsIHNvbWUgam9icyBrZXB0IGluIHRoZSBx
dWV1ZSwgaXQgaXMgCmx1Y2t5IHRvIGNoZWNrCgpVVkRfUE9XRVJfU1RBVFVTIGRvbmUsIGJ1dCBh
ZnRlciwgZncgc3RhcnQgYSBuZXcgam9iIHRoYXQgbGlzdCBpbiB0aGUgcXVldWUuCgpUbyBoYW5k
bGUgdGhpcyBzaXR1YXRpb24gcGVyZmVjdGx5LCB3ZSBuZWVkIGFkZCBtZWNoYW5pc20gdG8gc3Vz
cGVuZCBmdyAKZmlyc3QuCgpBbm90aGVyIGNhc2UsIGlmIGl0IGlzIHVubHVja3ksIHRoYXTCoCB2
Y24gZncgaHVuZyBhdCB0aGF0IHRpbWUsIApVVkRfUE9XRVJfU1RBVFVTCgphbHdheXMga2VlcHMg
YnVzeS7CoMKgIHRoZW4gaXQgbmVlZHMgZm9yY2UgcG93ZXJpbmcgZ2F0ZSB0aGUgdmNuIGh3IGFm
dGVyIApjZXJ0YWluIHRpbWUgd2FpdGluZy4KCkJlc3QgUmVnYXJkcyEKCkphbWVzCgpPbiAyMDIx
LTA1LTE3IDEyOjM0IHAubS4sIExlbyBMaXUgd3JvdGU6Cj4KPiBPbiAyMDIxLTA1LTE3IDExOjUy
IGEubS4sIEphbWVzIFpodSB3cm90ZToKPj4gRHVyaW5nIHZjbiBzdXNwZW5kcywgc3RvcCByaW5n
IGNvbnRpbnVlIHRvIHJlY2VpdmUgbmV3IHJlcXVlc3RzLAo+PiBhbmQgdHJ5IHRvIHdhaXQgZm9y
IGFsbCB2Y24gam9icyB0byBmaW5pc2ggZ3JhY2VmdWxseS4KPj4KPj4gdjI6IEZvcmNlZCBwb3dl
cmluZyBnYXRlIHZjbiBoYXJkd2FyZSBhZnRlciBmZXcgd2FpbnRpbmcgcmV0cnkuCj4+Cj4+IFNp
Z25lZC1vZmYtYnk6IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgfCAyMiArKysrKysrKysrKysr
KysrKysrKystCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdmNuLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4+
IGluZGV4IDIwMTY0NTkuLjlmM2E2ZTcgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdmNuLmMKPj4gQEAgLTI3NSw5ICsyNzUsMjkgQEAgaW50IGFtZGdwdV92Y25fc3Vz
cGVuZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4gwqAgewo+PiDCoMKgwqDCoMKgIHVu
c2lnbmVkIHNpemU7Cj4+IMKgwqDCoMKgwqAgdm9pZCAqcHRyOwo+PiArwqDCoMKgIGludCByZXRy
eV9tYXggPSA2Owo+PiDCoMKgwqDCoMKgIGludCBpOwo+PiDCoCAtwqDCoMKgIGNhbmNlbF9kZWxh
eWVkX3dvcmtfc3luYygmYWRldi0+dmNuLmlkbGVfd29yayk7Cj4+ICvCoMKgwqAgZm9yIChpID0g
MDsgaSA8IGFkZXYtPnZjbi5udW1fdmNuX2luc3Q7ICsraSkgewo+PiArwqDCoMKgwqDCoMKgwqAg
aWYgKGFkZXYtPnZjbi5oYXJ2ZXN0X2NvbmZpZyAmICgxIDw8IGkpKQo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjb250aW51ZTsKPj4gK8KgwqDCoMKgwqDCoMKgIHJpbmcgPSAmYWRldi0+dmNu
Lmluc3RbaV0ucmluZ19kZWM7Cj4+ICvCoMKgwqDCoMKgwqDCoCByaW5nLT5zY2hlZC5yZWFkeSA9
IGZhbHNlOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoCBmb3IgKGogPSAwOyBqIDwgYWRldi0+dmNu
Lm51bV9lbmNfcmluZ3M7ICsraikgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByaW5nID0g
JmFkZXYtPnZjbi5pbnN0W2ldLnJpbmdfZW5jW2pdOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByaW5nLT5zY2hlZC5yZWFkeSA9IGZhbHNlOwo+PiArwqDCoMKgwqDCoMKgwqAgfQo+PiArwqDC
oMKgIH0KPj4gKwo+PiArwqDCoMKgIHdoaWxlIChyZXRyeV9tYXgtLSAmJiAKPj4gY2FuY2VsX2Rl
bGF5ZWRfd29ya19zeW5jKCZhZGV2LT52Y24uaWRsZV93b3JrKSkKPj4gK8KgwqDCoMKgwqDCoMKg
IG1kZWxheSg1KTsKPgo+IEkgdGhpbmsgaXQncyBwb3NzaWJsZSB0byBoYXZlIG9uZSBwZW5kaW5n
IGpvYiB1bnByb2Nlc3NlZCB3aXRoIFZDTiAKPiB3aGVuIHN1c3BlbmQgc2VxdWVuY2UgZ2V0dGlu
ZyBoZXJlLCBidXQgaXQgc2hvdWxkbid0IGJlIG1vcmUgdGhhbiBvbmUsIAo+IGNhbmNlbF9kZWxh
eWVkX3dvcmtfc3luYyBwcm9iYWJseSByZXR1cm4gZmFsc2UgYWZ0ZXIgdGhlIGZpcnN0IHRpbWUs
IAo+IHNvIGNhbGxpbmcgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jIG9uY2Ugc2hvdWxkIGJlIGVu
b3VnaCBoZXJlLiB3ZSAKPiBwcm9iYWJseSBuZWVkIHRvIHdhaXQgbG9uZ2VyIGZyb206Cj4KPiBT
T0MxNV9XQUlUX09OX1JSRUcoVkNOLCBpbnN0X2lkeCwgbW1VVkRfUE9XRVJfU1RBVFVTLCAxLAo+
IMKgwqDCoCDCoMKgwqAgVVZEX1BPV0VSX1NUQVRVU19fVVZEX1BPV0VSX1NUQVRVU19NQVNLKTsK
Pgo+IHRvIG1ha2Ugc3VyZSB0aGUgdW5wcm9jZXNzZWQgam9iIGdldCBkb25lLgo+Cj4KPiBSZWdh
cmRzLAo+Cj4gTGVvCj4KPgo+PiArwqDCoMKgIGlmICghcmV0cnlfbWF4ICYmICFhbWRncHVfc3Jp
b3ZfdmYoYWRldikpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChSUkVHMzJfU09DMTUoVkNOLCBp
LCBtbVVWRF9TVEFUVVMpKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl93YXJuKGFk
ZXYtPmRldiwgIkZvcmNlZCBwb3dlcmluZyBnYXRlIHZjbiBoYXJkd2FyZSEiKTsKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdmNuX3YzXzBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKGFkZXYsIEFN
RF9QR19TVEFURV9HQVRFKTsKPj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4gK8KgwqDCoCB9Cj4+IMKg
IMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IGFkZXYtPnZjbi5udW1fdmNuX2luc3Q7ICsraSkg
ewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGFkZXYtPnZjbi5oYXJ2ZXN0X2NvbmZpZyAmICgx
IDw8IGkpKQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
