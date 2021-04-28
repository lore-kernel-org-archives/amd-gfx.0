Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F60AC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 07:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F73761405
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 07:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F73761405
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99AFE6EABB;
	Wed, 28 Apr 2021 07:53:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FCE96EABB
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 07:53:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jeo5GYrBfIN3pt8ExTd7Eeme45xF6jupiaaJiTUTzSfrF6d7Inu8KONAuzL8qhmKQiqtGYbTdEeuH/HTIP1NXYKdvUyX4C2IY8xlnLz6mkws89549IvV+Xa9yn+Jd0Gh4JlJop4prU8Ke3mces1LRaUTZ+R4utgDE++pE37JfyXpGhn2sM5UB9kgsPpDaQqJque6w6TfiJ3pBQZtyrNSV6c5Xz7I8UjEySgZA+1bzVrIQMNsv4zHTkcZZA//DUDoy9knVUMVV5XUoCMJUZtQhfr0Ks345S7T5ELOJKAG5LS0+WN2TosF41RgC5ri/iTSZxyo8aFtdjkIOIhRCwWFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB2FC2b/SarDGW+qmjW7zMToB7RHUEpwaCweY9Qv4Vs=;
 b=QC9pI+jCmB/Cf6ckXHNPizhlK16gLVzD4b5BLEzg8cTakN/OLObjCoJcAQaq+lcTkdbNbSukwFtWur1balrq3U8BY25G7NtrESfHyPUdmYsIk3a5vdDYzyZolSpUIbydrrYqoC6bncmKLK4HA1jvbmwPYrc41ypEFc+sbaAWX9u4kLeR0UwL9xYm+igAhiRh1ohEYMWg/JMS86G2sMDlfQCRzOXbxRD/qJneFEmQ0xQyFIccMgCtKy1vKHTxkWaBoJ30KCa+uFhq9u98wZX1hbcpQ7k7R7g3tLWLqcUNqVW7hbu3b9xY692m/zSfK14hO8c4353uQeV+//bSURJfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB2FC2b/SarDGW+qmjW7zMToB7RHUEpwaCweY9Qv4Vs=;
 b=JO8Jx7vEC+DjxBGz5IScS6zQyEsL/QmZrOcS5qowvWPw9R9xv++eTYqHJTm78UfhGkOspM/9eMztZPVSaPs6O2gpcwDYEU8SMRJBvknEiHYCzJF1rMtC35x3WKwIqddar/0LQgiM11t2DJS/d1MU81Am3Qm0ilduLz4GySGytv4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 07:53:53 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Wed, 28 Apr 2021
 07:53:53 +0000
Subject: Re: [PATCH v5 4/5] drm/amdgpu: address remove from fault filter
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210423153550.25188-1-Philip.Yang@amd.com>
 <20210427145119.670-1-Philip.Yang@amd.com>
 <3c65430a-1bdb-27cb-6573-dfc9e4035e8c@amd.com>
 <cf02bd7e-f442-fd0f-4184-c50a84929095@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <0ca90df0-a26a-2b62-4da6-6e49beaf052a@amd.com>
Date: Wed, 28 Apr 2021 03:53:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <cf02bd7e-f442-fd0f-4184-c50a84929095@gmail.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::15) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT1PR01CA0046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24 via Frontend Transport; Wed, 28 Apr 2021 07:53:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e681e56-6a4a-42c1-e4e3-08d90a1ac4b2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4125D2F6B1E0C6F8B6D7C9C492409@MN2PR12MB4125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kmDniG44AynXyDDTjiku4KF/ZPRokyn/PHn3ONe7ERNWVC1FJ0WJr0O2HIJlswcwKtbafpYo13cWxS9TBHbWxhPNuQMxH9lEcUnOMps2RT4YKhz79Q8aTUKWUFZ7l7A77hDLaXDemZeYsYOWASKZnXNlKlfhbMslFVUACCltTmtIWf8d0QO19hRtKNaV8EwqRhT5TZbN2NDowtmUZ/0XpAb0FjLwIqVP2H4u15e/2fzLBw7AOdC1Wrxe1iYXBBWvFYQftbQub4mvJjUMaJ3HGkwYS5CIZt6B5SQXKxcGJd7Ot3uW6m2ea0jyNrcAq7MKwJCA0UAx+IP/DBb9M/s1lpPqayLkS1g/Uj9/ajh3UUClsv59oIb+4S+/DkTiAf+fTKYa71vudhINimZD7bB4QAmyjSNGwr3EdQ4L0S9i22BXp8OTqgm/4mVy3xsmkBpM/s+Q6oKxjIYA02Xi085XRL9TdFPXBY6viTOdVCdH4XZyCxD1kcNjsJS2QR3vyIiMtdKPRemH0IOehMKLMOf5oojJhvEg0pIazLPVY0JeZbSCWNrOZ1h3pghyjp9hlUOV6ndy91zFdT9YqyizaosVBiEsUqDlnezrfjNfvQtFmvVjNCrm1eJiqdPcZMNPir8xyxSIt7DrpfCAIqYSZxkj0WnoR9/+n2Xye1+kofoQTBiriBirVvQDIC/VVOtdpk9PATJieLgqkbVvFL0QMrZ0IhMvVNoctGVN419L7P5SffA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(478600001)(8936002)(31686004)(44832011)(2906002)(8676002)(38100700002)(110136005)(16576012)(36756003)(53546011)(966005)(16526019)(186003)(2616005)(26005)(956004)(316002)(66476007)(66946007)(31696002)(66556008)(66574015)(5660300002)(83380400001)(86362001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y1NLSzRIdENsTUtBZWphMUMxdUZwSmUxSFAyVEZmd1Y2VWo0K2lCR25lZmxn?=
 =?utf-8?B?d1hSR3NTbGRJc0dQRlNDMUZhVGJWd2tkY1ZXV2ZWVGZNbjRhY1YwVW9EQXVv?=
 =?utf-8?B?TDVhenpOdFVzMU5GVGlTR2h0RHpuY0w5cEVBMGEzYUFkTUsveDgwb3NpTHF6?=
 =?utf-8?B?eEhBcCt3ZUY5SWJxaEYxK0ZnM1RZZlZoWUJrUzhuNWFZeEdGNWFJbWVyWE9a?=
 =?utf-8?B?R0MrUUhaVXV3bmVGWjhaM2dGYThqM2dRMGV1VjZMSjh4SVJoNitlSzNJMGVF?=
 =?utf-8?B?M1M1N1NWNUNHeFVoV0VHK25hcUJCOTF5SHNaTko3VDdER2ZvbG01YkM1WW5o?=
 =?utf-8?B?MGQ3THJQS200VHVTck42U2dkemgyTlQxZ1JKdGdKTEFXb0poRHV3UUtYVmxu?=
 =?utf-8?B?cm9RN0xHRFFpQkdRcGxxTVdXNkpSRWVGUEZNVlJLWkJlbHA0Q2xTVDlseEla?=
 =?utf-8?B?dDliU2ZHMWsxQ0JhWmdNVUk3dTl2TnJKY3dNQjdMb1VnK0JjS2prTlJZcG5F?=
 =?utf-8?B?VTMwTjZMQ0hCL3VkWVkrZVNncTlPYlNKTmNsZ1NWcEFpT1IyRmZodzBsRENN?=
 =?utf-8?B?MkpFbWR4RDJzMWdHd0pzaUpRMUpMS0NUdmhxUGRWQndkZnQ5eitpYlNPdzQ1?=
 =?utf-8?B?bEUrbHNJaGFFRUkzMzhOUHE2aFM2T0dNY3NsWDRxOEJwQVF5NDBUbkFJanFO?=
 =?utf-8?B?bGpzKzBKeit3R21lbHNvS2ZKemh1anplSDJNZEdJaHNobnYrVXl0cmV1WDNC?=
 =?utf-8?B?RGFHNkNHQ1dRUU9IQktJZklIOEl3NHFhM3UwUTJuaktqNmFuUGc1dDBSdzJI?=
 =?utf-8?B?N2p4NmwwOUs2MmZuait5bEVyWVhlWkhvMnpIUHM2cHhnOVRZQmJSL2VmcGVr?=
 =?utf-8?B?QlZjZ1YxdWZwY21PSjgybjByMW9SUTdqZmdEbWlGTDZhZkQ5aGhYbmxHSVFV?=
 =?utf-8?B?RkliTlA1SnlJMDVCK05tdms0TFBKZnhPUTA3d2FUbm1JYitPSmI2MWNieU9N?=
 =?utf-8?B?dlIyUTJsTTRtU3hESjZNWmtMaHJMWEdzajQ2TytkUTBqYlVQOGsvTUVBSEVu?=
 =?utf-8?B?dnpxeU10QmtsVlJwUGI0cU9rRVJYMzBOdFRxM0RvNlBjS2VUY2JYaVFsdDVI?=
 =?utf-8?B?RmY4dlUxaGJ6SFBVMVlKNisxK1BUc1g1aUFJMTM2OGVMaUJFMlVXc1VTQ0Rs?=
 =?utf-8?B?NWNMaFU4NkFveDZhWGNyVmJpa1pma0NSS3RKbitsTUFmSGVrNkJ0WHJCMHVE?=
 =?utf-8?B?cFp2UGNTUTR5TGJWTlFzR0liTGVxQm0rN25NdmFWZWZ2eXNjclo2QmowV2ZY?=
 =?utf-8?B?dGtzSnJMTWlYSmsvaW1iOUpFV2NnZ2N1akVlWFVoOXcySFVHVHZBU3Q2SExY?=
 =?utf-8?B?K3IwV0dRTzhOQXpEOVk3Z0lHUWZmalFyTGJRNk50Qk8vY0V6K3ovUmJCOUN4?=
 =?utf-8?B?WkRuNUxxRXozdDFvb280WE9laHIxUWNEZDhvcDVsTXNrdkp3K0x5SEQwVmox?=
 =?utf-8?B?REV0OERpRnBlRUN1U21SaWVWald1Ujl0em1pcFhCTGdDcDNhS1Z3cUxsU1Zq?=
 =?utf-8?B?WWpvOU5lenhIS2FSTm5INTVFS2tBOWdFYmJxU1J6aS9tSytPRnJmcUh0TVpx?=
 =?utf-8?B?NWRQaGZEcFlpZzZzQTNIVkVSbFhqMjh4UDJsWXQzc1FZNGRxN3I5YWRUVGhM?=
 =?utf-8?B?QjUzamV0NEs5enZYRlpRbHNJVTNTcTRERG41WGVXVGUzbWhrK05YR3Y0YWJ3?=
 =?utf-8?Q?GEkKpN2jfvmzSbG0JqOn+yeaEooDJVV/cefb+/s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e681e56-6a4a-42c1-e4e3-08d90a1ac4b2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 07:53:53.6316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRULFTPwpH4DnR8hXvSkp1TT1ftGjwaDGIWw5uZtOBNFdRNhXhhvbaq+ygonW1pZVcAyc+TKSvVS9w16G3b5Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
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

QW0gMjAyMS0wNC0yOCB1bSAyOjU0IGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFt
IDI3LjA0LjIxIHVtIDIwOjIxIHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+IE9uIDIwMjEtMDQt
MjcgMTA6NTEgYS5tLiwgUGhpbGlwIFlhbmcgd3JvdGU6Cj4+PiBBZGQgaW50ZXJmYWNlIHRvIHJl
bW92ZSBhZGRyZXNzIGZyb20gZmF1bHQgZmlsdGVyIHJpbmcgYnkgcmVzZXR0aW5nCj4+PiBmYXVs
dCByaW5nIGVudHJ5IGtleSwgdGhlbiBmdXR1cmUgdm0gZmF1bHQgb24gdGhlIGFkZHJlc3Mgd2ls
bCBiZQo+Pj4gcHJvY2Vzc2VkIHRvIHJlY292ZXIuCj4+Pgo+Pj4gRGVmaW5lIGZhdWx0IGtleSBh
cyBhdG9taWM2NF90IHR5cGUgdG8gdXNlIGF0b21pYyByZWFkL3NldC9jbXB4Y2hnIGtleQo+Pj4g
dG8gcHJvdGVjdCBmYXVsdCByaW5nIGFjY2VzcyBieSBpbnRlcnJ1cHQgaGFuZGxlciBhbmQgaW50
ZXJydXB0Cj4+PiBkZWZlcnJlZAo+Pj4gd29yayBmb3IgdmcyMC4gQ2hhbmdlIGZhdWx0LT50aW1l
c3RhbXAgdG8gNDgtYml0IHRvIHNoYXJlIHNhbWUgdWludDY0X3QKPj4+IHdpdGggOC1iaXQgZmF1
bHQtPm5leHQsIGl0IGlzIGVub3VnaCBmb3IgNDhiaXQgSUggdGltZXN0YW1wLgo+Pj4KPj4+IFNp
Z25lZC1vZmYtYnk6IFBoaWxpcCBZYW5nIDxQaGlsaXAuWWFuZ0BhbWQuY29tPgo+Pj4gLS0tCj4+
PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMgfCA0OAo+Pj4gKysr
KysrKysrKysrKysrKysrKysrKy0tLQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dtYy5oIHzCoCA2ICsrLS0KPj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgNDggaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nbWMuYwo+Pj4gaW5kZXggYzM5ZWQ5ZWIwOTg3Li5hMmU4MWU5MTNhYmIgMTAw
NjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKPj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+Pj4gQEAgLTMz
Miw2ICszMzIsMTcgQEAgdm9pZCBhbWRncHVfZ21jX2FncF9sb2NhdGlvbihzdHJ1Y3QKPj4+IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfZ21jICptYykKPj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG1jLT5hZ3Bfc2l6ZSA+PiAyMCwgbWMtPmFncF9zdGFydCwgbWMtPmFn
cF9lbmQpOwo+Pj4gwqAgfQo+Pj4gwqAgKy8qKgo+Pj4gKyAqIGFtZGdwdV9nbWNfZmF1bHRfa2V5
IC0gZ2V0IGhhc2sga2V5IGZyb20gdm0gZmF1bHQgYWRkcmVzcyBhbmQgcGFzaWQKPj4+ICsgKgo+
Pj4gKyAqIEBhZGRyOiA0OGJpdCBwaHlzaWNhbCBhZGRyZXNzCj4+PiArICogQHBhc2lkOiA0IGJp
dAo+Pgo+PiBUaGlzIGNvbW1lbnQgaXMgbWlzbGVhZGluZy4gVGhlIFBBU0lEIGlzIG5vdCA0LWJp
dC4gSXQncyAxNi1iaXQuIEJ1dAo+PiBzaGlmdGluZyB0aGUgYWRkcmVzcyBieSA0IGJpdCBpcyBz
dWZmaWNpZW50IGJlY2F1c2UgdGhlIGFkZHJlc3MgaXMKPj4gcGFnZS1hbGlnbmVkLCB3aGljaCBt
ZWFucyB0aGUgbG93IDEyIGJpdHMgYXJlIDAuIFNvIHRoaXMgd291bGQgYmUKPj4gbW9yZSBhY2N1
cmF0ZToKPj4KPj4gQGFkZHI6IDQ4IGJpdCBwaHlzaWNhbCBhZGRyZXNzLCBwYWdlIGFsaWduZWQg
KDM2IHNpZ25pZmljYW50IGJpdHMpCj4+IEBwYXNpZDogMTYgYml0IHByb2Nlc3MgYWRkcmVzcyBz
cGFjZSBpZGVudGlmaWVyCj4+Cj4+IFdpdGggdGhhdCBmaXhlZCwgdGhlIHBhdGNoIGlzCj4+Cj4+
IFJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPj4K
Pj4KPj4+ICsgKi8KPj4+ICtzdGF0aWMgaW5saW5lIHVpbnQ2NF90IGFtZGdwdV9nbWNfZmF1bHRf
a2V5KHVpbnQ2NF90IGFkZHIsIHVpbnQxNl90Cj4+PiBwYXNpZCkKPj4+ICt7Cj4+PiArwqDCoMKg
IHJldHVybiBhZGRyIDw8IDQgfCBwYXNpZDsKPj4+ICt9Cj4KPiBNYXliZSBjaGFuZ2luZyB0aGlz
IHNvIHRoYXQgd2UgaGF2ZSAiYWRkciAqICgoMSA8PCAxNikgLwo+IEFNREdQVV9QQUdFX1NJWkUp
IHwgcGFzaWQiIHdvdWxkIGhlbHAgdG8gYmV0dGVyIGRvY3VtZW50IHRoYXQ/CgpJIGZpbmQgdGhp
cyBhIG1peCBvZiBtdWx0aXBsaWNhdGlvbiwgZGl2aXNpb24gYW5kIGJpdC1zaGlmdCBtb3JlCmNv
bmZ1c2luZy4gSG93IGFib3V0ICJhZGRyIDw8ICgxNiAtIEFNREdQVV9HUFVfUEFHRV9TSElGVCkg
fCBwYXNpZCI/CgpSZWdhcmRzLArCoCBGZWxpeAoKCj4KPiBDaHJpc3RpYW4uCj4KPj4+ICsKPj4+
IMKgIC8qKgo+Pj4gwqDCoCAqIGFtZGdwdV9nbWNfZmlsdGVyX2ZhdWx0cyAtIGZpbHRlciBWTSBm
YXVsdHMKPj4+IMKgwqAgKgo+Pj4gQEAgLTM0OCw4ICszNTksNyBAQCBib29sIGFtZGdwdV9nbWNf
ZmlsdGVyX2ZhdWx0cyhzdHJ1Y3QKPj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQ2NF90IGFk
ZHIsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MTZfdCBw
YXNpZCwgdWludDY0X3QgdGltZXN0YW1wKQo+Pj4gwqAgewo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3Qg
YW1kZ3B1X2dtYyAqZ21jID0gJmFkZXYtPmdtYzsKPj4+IC0KPj4+IC3CoMKgwqAgdWludDY0X3Qg
c3RhbXAsIGtleSA9IGFkZHIgPDwgNCB8IHBhc2lkOwo+Pj4gK8KgwqDCoCB1aW50NjRfdCBzdGFt
cCwga2V5ID0gYW1kZ3B1X2dtY19mYXVsdF9rZXkoYWRkciwgcGFzaWQpOwo+Pj4gwqDCoMKgwqDC
oCBzdHJ1Y3QgYW1kZ3B1X2dtY19mYXVsdCAqZmF1bHQ7Cj4+PiDCoMKgwqDCoMKgIHVpbnQzMl90
IGhhc2g7Cj4+PiDCoCBAQCAtMzY1LDcgKzM3NSw3IEBAIGJvb2wgYW1kZ3B1X2dtY19maWx0ZXJf
ZmF1bHRzKHN0cnVjdAo+Pj4gYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDY0X3QgYWRkciwKPj4+
IMKgwqDCoMKgwqAgd2hpbGUgKGZhdWx0LT50aW1lc3RhbXAgPj0gc3RhbXApIHsKPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCB1aW50NjRfdCB0bXA7Cj4+PiDCoCAtwqDCoMKgwqDCoMKgwqAgaWYgKGZh
dWx0LT5rZXkgPT0ga2V5KQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChhdG9taWM2NF9yZWFkKCZm
YXVsdC0+a2V5KSA9PSBrZXkpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
dHJ1ZTsKPj4+IMKgIMKgwqDCoMKgwqDCoMKgwqDCoCB0bXAgPSBmYXVsdC0+dGltZXN0YW1wOwo+
Pj4gQEAgLTM3OCw3ICszODgsNyBAQCBib29sIGFtZGdwdV9nbWNfZmlsdGVyX2ZhdWx0cyhzdHJ1
Y3QKPj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQ2NF90IGFkZHIsCj4+PiDCoCDCoMKgwqDC
oMKgIC8qIEFkZCB0aGUgZmF1bHQgdG8gdGhlIHJpbmcgKi8KPj4+IMKgwqDCoMKgwqAgZmF1bHQg
PSAmZ21jLT5mYXVsdF9yaW5nW2dtYy0+bGFzdF9mYXVsdF07Cj4+PiAtwqDCoMKgIGZhdWx0LT5r
ZXkgPSBrZXk7Cj4+PiArwqDCoMKgIGF0b21pYzY0X3NldCgmZmF1bHQtPmtleSwga2V5KTsKPj4+
IMKgwqDCoMKgwqAgZmF1bHQtPnRpbWVzdGFtcCA9IHRpbWVzdGFtcDsKPj4+IMKgIMKgwqDCoMKg
wqAgLyogQW5kIHVwZGF0ZSB0aGUgaGFzaCAqLwo+Pj4gQEAgLTM4Nyw2ICszOTcsMzYgQEAgYm9v
bCBhbWRncHVfZ21jX2ZpbHRlcl9mYXVsdHMoc3RydWN0Cj4+PiBhbWRncHVfZGV2aWNlICphZGV2
LCB1aW50NjRfdCBhZGRyLAo+Pj4gwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4+PiDCoCB9Cj4+
PiDCoCArLyoqCj4+PiArICogYW1kZ3B1X2dtY19maWx0ZXJfZmF1bHRzX3JlbW92ZSAtIHJlbW92
ZSBhZGRyZXNzIGZyb20gVk0gZmF1bHRzCj4+PiBmaWx0ZXIKPj4+ICsgKgo+Pj4gKyAqIEBhZGV2
OiBhbWRncHUgZGV2aWNlIHN0cnVjdHVyZQo+Pj4gKyAqIEBhZGRyOiBhZGRyZXNzIG9mIHRoZSBW
TSBmYXVsdAo+Pj4gKyAqIEBwYXNpZDogUEFTSUQgb2YgdGhlIHByb2Nlc3MgY2F1c2luZyB0aGUg
ZmF1bHQKPj4+ICsgKgo+Pj4gKyAqIFJlbW92ZSB0aGUgYWRkcmVzcyBmcm9tIGZhdWx0IGZpbHRl
ciwgdGhlbiBmdXR1cmUgdm0gZmF1bHQgb24KPj4+IHRoaXMgYWRkcmVzcwo+Pj4gKyAqIHdpbGwg
cGFzcyB0byByZXRyeSBmYXVsdCBoYW5kbGVyIHRvIHJlY292ZXIuCj4+PiArICovCj4+PiArdm9p
ZCBhbWRncHVfZ21jX2ZpbHRlcl9mYXVsdHNfcmVtb3ZlKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LAo+Pj4gdWludDY0X3QgYWRkciwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHVpbnQxNl90IHBhc2lkKQo+Pj4gK3sKPj4+ICvCoMKgwqAgc3RydWN0IGFt
ZGdwdV9nbWMgKmdtYyA9ICZhZGV2LT5nbWM7Cj4+PiArwqDCoMKgIHVpbnQ2NF90IGtleSA9IGFt
ZGdwdV9nbWNfZmF1bHRfa2V5KGFkZHIsIHBhc2lkKTsKPj4+ICvCoMKgwqAgc3RydWN0IGFtZGdw
dV9nbWNfZmF1bHQgKmZhdWx0Owo+Pj4gK8KgwqDCoCB1aW50MzJfdCBoYXNoOwo+Pj4gK8KgwqDC
oCB1aW50NjRfdCB0bXA7Cj4+PiArCj4+PiArwqDCoMKgIGhhc2ggPSBoYXNoXzY0KGtleSwgQU1E
R1BVX0dNQ19GQVVMVF9IQVNIX09SREVSKTsKPj4+ICvCoMKgwqAgZmF1bHQgPSAmZ21jLT5mYXVs
dF9yaW5nW2dtYy0+ZmF1bHRfaGFzaFtoYXNoXS5pZHhdOwo+Pj4gK8KgwqDCoCBkbyB7Cj4+PiAr
wqDCoMKgwqDCoMKgwqAgaWYgKGF0b21pYzY0X2NtcHhjaGcoJmZhdWx0LT5rZXksIGtleSwgMCkg
PT0ga2V5KQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+PiArCj4+PiArwqDC
oMKgwqDCoMKgwqAgdG1wID0gZmF1bHQtPnRpbWVzdGFtcDsKPj4+ICvCoMKgwqDCoMKgwqDCoCBm
YXVsdCA9ICZnbWMtPmZhdWx0X3JpbmdbZmF1bHQtPm5leHRdOwo+Pj4gK8KgwqDCoCB9IHdoaWxl
IChmYXVsdC0+dGltZXN0YW1wIDwgdG1wKTsKPj4+ICt9Cj4+PiArCj4+PiDCoCBpbnQgYW1kZ3B1
X2dtY19yYXNfbGF0ZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4gwqAgewo+
Pj4gwqDCoMKgwqDCoCBpbnQgcjsKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ21jLmgKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dtYy5oCj4+PiBpbmRleCA5ZDExYzAyYTM5MzguLjZhYTFkNTJkM2FlZSAxMDA2NDQKPj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaAo+Pj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCj4+PiBAQCAtNjYsOSArNjYs
OSBAQCBzdHJ1Y3QgZmlybXdhcmU7Cj4+PiDCoMKgICogR01DIHBhZ2UgZmF1bHQgaW5mb3JtYXRp
b24KPj4+IMKgwqAgKi8KPj4+IMKgIHN0cnVjdCBhbWRncHVfZ21jX2ZhdWx0IHsKPj4+IC3CoMKg
wqAgdWludDY0X3TCoMKgwqAgdGltZXN0YW1wOwo+Pj4gK8KgwqDCoCB1aW50NjRfdMKgwqDCoCB0
aW1lc3RhbXA6NDg7Cj4+PiDCoMKgwqDCoMKgIHVpbnQ2NF90wqDCoMKgIG5leHQ6QU1ER1BVX0dN
Q19GQVVMVF9SSU5HX09SREVSOwo+Pj4gLcKgwqDCoCB1aW50NjRfdMKgwqDCoCBrZXk6NTI7Cj4+
PiArwqDCoMKgIGF0b21pYzY0X3TCoMKgwqAga2V5Owo+Pj4gwqAgfTsKPj4+IMKgIMKgIC8qCj4+
PiBAQCAtMzE4LDYgKzMxOCw4IEBAIHZvaWQgYW1kZ3B1X2dtY19hZ3BfbG9jYXRpb24oc3RydWN0
Cj4+PiBhbWRncHVfZGV2aWNlICphZGV2LAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfZ21jICptYyk7Cj4+PiDCoCBib29sIGFtZGdwdV9nbWNf
ZmlsdGVyX2ZhdWx0cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDY0X3QKPj4+IGFk
ZHIsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MTZfdCBw
YXNpZCwgdWludDY0X3QgdGltZXN0YW1wKTsKPj4+ICt2b2lkIGFtZGdwdV9nbWNfZmlsdGVyX2Zh
dWx0c19yZW1vdmUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+PiB1aW50NjRfdCBhZGRy
LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDE2X3Qg
cGFzaWQpOwo+Pj4gwqAgaW50IGFtZGdwdV9nbWNfcmFzX2xhdGVfaW5pdChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldik7Cj4+PiDCoCB2b2lkIGFtZGdwdV9nbWNfcmFzX2Zpbmkoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpOwo+Pj4gwqAgaW50IGFtZGdwdV9nbWNfYWxsb2NhdGVfdm1faW52
X2VuZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Cj4+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
