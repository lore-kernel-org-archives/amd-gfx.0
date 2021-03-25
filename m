Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DB7C433C1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521A161A21
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521A161A21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B716EB68;
	Thu, 25 Mar 2021 16:16:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 435176EB68
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 16:16:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0lfNEZXQUmBBwjtNOWNHTDIPsk9tBV6n9lY0RYha1Fthj9CEzT8fOrCrkWBWlQ9L7nymFgjlGLkl6kOMfj2iorOKoWk/3oYLVBpOLhNPZXXhBmbtn71MF5WqTn1C3IULxEhT3sbi7YQNN9kVGocllvu+CLIEEICP9YsGmQWz2J1B1CWpnhcXdx8Ev8C3T1k8Hx7ILrsH/x+7mujHgHx9eaIOVZzPAfrFb5fNEq6fOp3JdHyYD9A3F0rjJytfd6UcNRGC2JH3qaswmn5N3bdfsKnP1vvothoPyJoCQJH+gc81rJNTSr/0Mho9K4/YyLbJDAb2l6o9VjX+f2rVX0szA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PT7j0yasIuHX5zC/dLZuh1hNB/13b3m7//DUkvTOtEo=;
 b=CY2KoihTbTVTEcT4smfgNGO/FRN34A4J1nFURwbu3eZRP8HdQCv5X9sz16EvsxDnO+WsHcESaCak9G10Rq90AjxMx53B8MWdfuQW4RCYmUG70PIV4BILu8yK4iDx7tiY41jKcKiUGvG/K8fsUrAXnDxb64V/OwErJEDdI5v8eDvPm7q6aS3FGiqruu1CqNEy++o4eMtw4sXIeYyj9EMYqjEpx3MYna7+NKpjIDozqgwaUK9g4hitqomjBhodCOvCjN/C4rytaYJZs1dDYliPxkHqNMGM/tftJJPW44ukOzdEWXnWdJkGHfY59tTw3rdXu8ZpeWPeu9/SjzpFPcHY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PT7j0yasIuHX5zC/dLZuh1hNB/13b3m7//DUkvTOtEo=;
 b=Bl+9CS6+cbcIrFZkq5oh7Z6lUQNLA7x8aH+xOWgw1SuQu5gQxXhhu6gE3hT3W3y/nzCiciwu6bcEPjG1AXIHB3Xnc/IwWv6W6b1Gw12nzR+Gp9hTYo6GSQxeP9wa+ujRISL24n/NCc3oSlkw2uEqZ7+mye2ExwKJk4qHABasflA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 16:16:12 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 16:16:12 +0000
Subject: Re: Need to support mixed memory mappings with HMM
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <ba49d13c-6b64-f9a6-f309-0dda56e90abf@amd.com>
 <dc28799b-d3a9-6922-f06a-c19eb75a9805@amd.com>
 <415c5920-0c70-819b-555e-a0c0fce301ef@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ee1951eb-f789-14c2-608e-a6f77355c9ab@amd.com>
Date: Thu, 25 Mar 2021 17:16:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <415c5920-0c70-819b-555e-a0c0fce301ef@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:52c7:fa7f:c799:1b6d]
X-ClientProxiedBy: AM8P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::32) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:52c7:fa7f:c799:1b6d]
 (2a02:908:1252:fb60:52c7:fa7f:c799:1b6d) by
 AM8P191CA0027.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24 via Frontend Transport; Thu, 25 Mar 2021 16:16:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c8bd43ce-5cd7-464a-aa31-08d8efa94ea6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4224E5FB7415D882B9917A8A83629@MN2PR12MB4224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NtGg46LH5uaZ0hKQjhBf7qo9TeBZr+sjDNsJj2M60J1XrnOXBqx3cd3zwxu7xSBxK32xlUJ0+QY8dpqp3SYHaH/MotFXaNKXWLTYIAbUuUyAL/LZ+GPmfISSr1s8c6MB7jG7TSG3iFZuwQjqwLiv8EIrF/VDs4VbiB4hBWVJcAi+ZsFtBJb/Punc852dzPQkClaqRfziB6CiGgfzAuYe3VRVmRktUlUzAVeftqn+dLO+DiaEGbGgC7orF3fe/RgJJ1ATxiTQR11O9HEwKjVUQlQMAEaefTKh1Krx2PeUv6Q3EuDDgGNQjJnCoWjFSTZIfJTx0BvzKtB007+L43yxr6jLDxfKNyfMqp9qeSTbo95S2RUCPBZcrK8r/sNyVhNhSmDmWFZyUzd+WOACRCKN+aqlusXhSlgC4ijOPY6+rLBPl10L6NA1e1dNOAXsnCY7fqpWVmVpR8aM6JNrrpiSeCmTW8oziqBjw6zGer9hZsUMV44Hg7q2i7A6sM++5u8e1XxwtVrFtH3CC7RYsgbPxPhCED+0kZ4Qck/tGa6S13qKcwcF2bs8gr0hxOujNFw7ONEZff0XRi4Zo35fOK76rGsFp0fGARYOXFIAml3VEWQQmqzpIJoT8zsYScrKPkWrP7BiktAlLWsgDqKV7iYq0chCV6TaRvCNfanOhhAcsPZjJV1Fr7w/IYXik4QrDcH2jUilNOAjE41YzHp0zEklVsQ65yj+BJ6eF0kke9ODCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(6486002)(2906002)(66946007)(5660300002)(66476007)(2616005)(16526019)(83380400001)(186003)(66574015)(66556008)(6666004)(38100700001)(8936002)(86362001)(8676002)(478600001)(316002)(31686004)(31696002)(52116002)(110136005)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TmZNc0lpU0V6bzVabnQ0ZWpFZlJrR0h2QnpWNFhNUHNEQXgzbG5UN0Y1SjBZ?=
 =?utf-8?B?cmVxVlFGdW94QXlWY0FJblNqNWE3dzlJR3Mxam8xTkNmUG9lS2tjamx6Q3Yr?=
 =?utf-8?B?aHRhbm9RT0V6ZEd4OW9ENWRoZmcyRWhHQm5JcUJZK3Y2T2FYUEhwWWw4bXZk?=
 =?utf-8?B?ZUN4N3NRdStSRUZQRnVyMWh5ZUVVdTBjUDVTR1YrTEVxR0J4YnpsSU1IYkE4?=
 =?utf-8?B?V0w3UHRmUXgxUnJqZzl3aVFsVnlOVmZiYzhoTHRrT0dWU0pnVkxpdEZ3ZGtQ?=
 =?utf-8?B?UnJnZVdkWDRyVW9rcTZrYjEwVExYYzFQVExlRE9TN2RaRXNvODVsZHcydWk1?=
 =?utf-8?B?eTd1Y1RyNGkxdHZxMFZOWHh0ZVlqSko0Qm9aeDVmNnRWeFM4UkR6LzJaK0xK?=
 =?utf-8?B?TTY0MUFkcS9lK2JyT1BxSXBSeS9aR3ozMlhUcklDRy9EckVSbUxiU1lVSlNn?=
 =?utf-8?B?U3gyNDNTTkFsMzVxbXZFa2hpQ3BjN0F2R21TNjhEVkc4T1JzSVdsakxCVHJM?=
 =?utf-8?B?aG1tQVZpcUl0ZEhQa3B4OW8xT0VuUWN0UFNFbTdwd3RvNjk1ZEpuVkVZM2lH?=
 =?utf-8?B?MHhmanVRTi9zWmRuQjRXNUIyVmszTzI0blk4dEtWU2hZMk11OVUwYWJUbzVT?=
 =?utf-8?B?ay9yU0VDcFY1MkZNMzV4a2s2K1RPdzNocDBuNGZ5Y1RBTVczdnNMTEhrNTcr?=
 =?utf-8?B?SEE1ZlJMeW9EdzVTYmhKUmpqeDlDTU0xaDk2dE1CZGJFdmhwSWphSXJvaSt6?=
 =?utf-8?B?NEdRbUUwTEpKTG1nM2pUSk16Smw4K1dQMU5lTW1ncEl0RzNiMjNWUHErZ1dL?=
 =?utf-8?B?WktZT0szQzlkN3JCSWVEcUtuSXozd2VLV2VrQ3AreWpoZTNOQTB6dzlhS2hC?=
 =?utf-8?B?OWxqWis2cyt2cnVudDVJYUsvcmJBMi9DanV3NHZqbXFYNFJZdGt5YWswQ1l6?=
 =?utf-8?B?WnhucytGVitacnIxSUorWHo4NVpaRkkrV1NTb0YzR1hWV0lwaUR5V0pXNE9V?=
 =?utf-8?B?UExhQzNCVVJEZVFDZ0lPa1FFRnB3dWFhNE9SY0o3Vkgzb0QzTlptbHVWTUh3?=
 =?utf-8?B?aHFTQXcrUXUzOUpEVjN2MWkzbm1UN25oL3FFNUQrYUNpNGh6cCs2RzBVbFQ0?=
 =?utf-8?B?WVNsMXpUeTlGU2FSVFMvZWxVZFZiU3FPbGRML0xpVDEyZmpWMkltVG92VlFw?=
 =?utf-8?B?MlZueHA0NDdTQ1h1R1NxQVBhaVFlRU9lSmgxc05CbFZiTVA4eVB6T2tkbzN3?=
 =?utf-8?B?L05NaXBQNEVobU80RVA2U29OcGdmcVNDazFBTGllUmdJc09FbHF3MGRTV2t6?=
 =?utf-8?B?Q3BGamhHYmR0SUk1NlVCNkl3YUdwSUNOd29TeVpjbnhCcG5WNFZMbkxISHlY?=
 =?utf-8?B?TFkwZjhNSXFnbHVkK3IyNmd2bmFaTmhMaEh5elFBYitRanNTVnA3eHhIQytE?=
 =?utf-8?B?QUdNOGJEdWsva0hJeml4RG5OczJ2UzBsRjlReWUxSW5QbkNVWlp6TGV5L3VU?=
 =?utf-8?B?MXBWNjBpZFRJUlhCazZzQkt0MG1qb1Nra2VtS1BvSFZvcmVIa3hHVGxuNGtQ?=
 =?utf-8?B?N25UTUR6allXL0hzSEM3djFmczA4dUtmNzY3UXl2U09vZlU5bTlyUHF6SlJm?=
 =?utf-8?B?Zi96M0pZVnRSckt0citGOXNpOUtiQ1JJMnl3b1ozaC82dGw0S29UYmNPK0tX?=
 =?utf-8?B?MlpKaTNtQlhwY2VlU3pHYWh4TVdWbldSZXgxZUkyeUN2Q0RmWHRLT2RJYVNm?=
 =?utf-8?B?UE9RbkEvWng3eW5kYTM4MDM3OWplOTBiZGxkS0Uyb2xKRzZic29ueE8wYy9F?=
 =?utf-8?B?aVhEMm8vN2RpQlRpenQrOHQzV0FUVTEvc25ydEpMZTFDMy85Tmd4U1p2VWp1?=
 =?utf-8?Q?gyWHVvmO0GUUv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bd43ce-5cd7-464a-aa31-08d8efa94ea6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 16:16:12.4749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQ9k2apn0IG+5j1CmSE6VBt47u2iFktwMN7YKyi73qOojKXHw3A12Yc9cnMRhhJE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
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

QW0gMjUuMDMuMjEgdW0gMTc6MTQgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIxLTAz
LTI1IHVtIDEyOjEwIHAubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Pgo+PiBBbSAyNS4w
My4yMSB1bSAxNzowMyBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+Pj4gSGksCj4+Pgo+Pj4gVGhp
cyBpcyBhIGxvbmcgb25lIHdpdGggYSBwcm9wb3NhbCBmb3IgYSBwcmV0dHkgc2lnbmlmaWNhbnQg
cmVkZXNpZ24gb2YKPj4+IGhvdyB3ZSBoYW5kbGUgbWlncmF0aW9ucyBhbmQgVlJBTSBtYW5hZ2Vt
ZW50IHdpdGggSE1NLiBUaGlzIGlzIGJhc2VkIG9uCj4+PiBteSBvd24gZGVidWdnaW5nIGFuZCBy
ZWFkaW5nIG9mIHRoZSBtaWdyYXRlX3ZtYSBoZWxwZXJzLCBhcyB3ZWxsIGFzCj4+PiBBbGV4J3Mg
cHJvYmxlbXMgd2l0aCBtaWdyYXRpb25zIG9uIEErQS4gSSBob3BlIHdlIGNhbiBkaXNjdXNzIHRo
aXMgbmV4dAo+Pj4gTW9uZGF5IGFmdGVyIHlvdSd2ZSBoYWQgc29tZSB0aW1lIGRvIGRpZ2VzdCBp
dC4KPj4+Cj4+PiBJIGRpZCBzb21lIGRlYnVnZ2luZyB5ZXN0ZXJkYXkgYW5kIGZvdW5kIHRoYXQg
bWlncmF0aW9ucyB0byBWUkFNIGNhbgo+Pj4gZmFpbCBmb3Igc29tZSBwYWdlcy4gVGhlIGN1cnJl
bnQgbWlncmF0aW9uIGhlbHBlcnMgaGF2ZSBtYW55IGNvcm5lcgo+Pj4gY2FzZXMgd2hlcmUgYSBw
YWdlIGNhbm5vdCBiZSBtaWdyYXRlZC4gU29tZSBvZiB0aGVtIG1heSBiZSBmaXhhYmxlCj4+PiAo
YWRkaW5nIHN1cHBvcnQgZm9yIFRIUCksIG90aGVycyBhcmUgbm90IChsb2NrZWQgcGFnZXMgYXJl
IHNraXBwZWQgdG8KPj4+IGF2b2lkIGRlYWRsb2NrcykuIFRoZXJlZm9yZSBJIHRoaW5rIG91ciBj
dXJyZW50IGNvZGUgaXMgdG9vIGluZmxleGlibGUKPj4+IHdoZW4gaXQgYXNzdW1lcyB0aGF0IGEg
cmFuZ2UgaXMgZW50aXJlbHkgaW4gb25lIHBsYWNlLgo+Pj4KPj4+IEFsZXggYWxzbyByYW4gaW50
byBzb21lIGZ1bm55IGlzc3VlcyB3aXRoIENPVyBvbiBBK0Egd2hlcmUgc29tZSBwYWdlcwo+Pj4g
Z2V0IGZhdWx0ZWQgYmFjayB0byBzeXN0ZW0gbWVtb3J5LiBJIHRoaW5rIGEgbG90IG9mIHRoZSBw
cm9ibGVtcyBoZXJlCj4+PiB3aWxsIGdldCBlYXNpZXIgb25jZSB3ZSBzdXBwb3J0IG1peGVkIG1h
cHBpbmdzLgo+Pj4KPj4+IE1peGVkIEdQVSBtYXBwaW5ncwo+Pj4gPT09PT09PT09PT0KPj4+Cj4+
PiBUaGUgaWRlYSBpcywgdG8gcmVtb3ZlIGFueSBhc3N1bXB0aW9ucyB0aGF0IGFuIGVudGlyZSBz
dm1fcmFuZ2UgaXMgaW4KPj4+IG9uZSBwbGFjZS4gSW5zdGVhZCBobW1fcmFuZ2VfZmF1bHQgZ2l2
ZXMgdXMgYSBsaXN0IG9mIHBhZ2VzLCBzb21lIG9mCj4+PiB3aGljaCBhcmUgc3lzdGVtIG1lbW9y
eSBhbmQgb3RoZXJzIGFyZSBkZXZpY2VfcHJpdmF0ZSBvciBkZXZpY2VfZ2VuZXJpYy4KPj4+Cj4+
PiBXZSB3aWxsIG5lZWQgYW4gYW1kZ3B1X3ZtIGludGVyZmFjZSB0aGF0IGxldHMgdXMgbWFwIG1p
eGVkIHBhZ2UgYXJyYXlzCj4+PiB3aGVyZSBkaWZmZXJlbnQgcGFnZXMgdXNlIGRpZmZlcmVudCBQ
VEUgZmxhZ3MuIFdlIGNhbiBoYXZlIGF0IGxlYXN0IDMKPj4+IGRpZmZlcmVudCB0eXBlcyBvZiBw
YWdlcyBpbiBvbmUgbWFwcGluZzoKPj4+Cj4+PiAgwqAgMS4gU3lzdGVtIG1lbW9yeSAoUy1iaXQg
c2V0KQo+Pj4gIMKgIDIuIExvY2FsIG1lbW9yeSAoUy1iaXQgY2xlYXJlZCwgTVRZUEUgZm9yIGxv
Y2FsIG1lbW9yeSkKPj4+ICDCoCAzLiBSZW1vdGUgWEdNSSBtZW1vcnkgKFMtYml0IGNsZWFyZWQs
IE1UWVBFK0MgZm9yIHJlbW90ZSBtZW1vcnkpCj4+Pgo+Pj4gTXkgaWRlYSBpcyB0byBjaGFuZ2Ug
dGhlIGFtZGdwdV92bV91cGRhdGVfbWFwcGluZyBpbnRlcmZhY2UgdG8gdXNlIHNvbWUKPj4+IGhp
Z2gtYml0IGluIHRoZSBwYWdlc19hZGRyIGFycmF5IHRvIGluZGljYXRlIHRoZSBwYWdlIHR5cGUu
IEZvciB0aGUKPj4+IGRlZmF1bHQgcGFnZSB0eXBlICgwKSBub3RoaW5nIHJlYWxseSBjaGFuZ2Vz
IGZvciB0aGUgY2FsbGVycy4gVGhlCj4+PiAiZmxhZ3MiIHBhcmFtZXRlciBuZWVkcyB0byBiZWNv
bWUgYSBwb2ludGVyIHRvIGFuIGFycmF5IHRoYXQgZ2V0cwo+Pj4gaW5kZXhlZCBieSB0aGUgaGln
aCBiaXRzIGZyb20gdGhlIHBhZ2VzX2FkZHIgYXJyYXkuIEZvciBleGlzdGluZyBjYWxsZXJzCj4+
PiBpdCdzIGFzIGVhc3kgYXMgY2hhbmdpbmcgZmxhZ3MgdG8gJmZsYWdzIChhcnJheSBvZiBzaXpl
IDEpLiBGb3IgSE1NIHdlCj4+PiB3b3VsZCBwYXNzIGEgcG9pbnRlciB0byBhIHJlYWwgYXJyYXku
Cj4+IFllYWgsIEkndmUgdGhvdWdodCBhYm91dCBzdHVmZiBsaWtlIHRoYXQgYXMgd2VsbCBmb3Ig
YSB3aGlsZS4KPj4KPj4gUHJvYmxlbSBpcyB0aGF0IHRoaXMgd29uJ3Qgd29yayB0aGF0IGVhc2ls
eS4gV2UgYXNzdW1lIGF0IG1hbnkgcGxhY2VzCj4+IHRoYXQgdGhlIGZsYWdzIGRvZXNuJ3QgY2hh
bmdlIGZvciB0aGUgcmFuZ2UgaW4gcXVlc3Rpb24uCj4gSSB0aGluayBzb21lIGxvd2VyIGxldmVs
IGZ1bmN0aW9ucyBhc3N1bWUgdGhhdCB0aGUgZmxhZ3Mgc3RheSB0aGUgc2FtZQo+IGZvciBwaHlz
aWNhbGx5IGNvbnRpZ3VvdXMgcmFuZ2VzLiBCdXQgaWYgeW91IHVzZSB0aGUgaGlnaC1iaXRzIHRv
IGVuY29kZQo+IHRoZSBwYWdlIHR5cGUsIHRoZSByYW5nZXMgd29uJ3QgYmUgY29udGlndW91cyBh
bnkgbW9yZS4gU28geW91IGNhbgo+IGNoYW5nZSBwYWdlIGZsYWdzIGZvciBkaWZmZXJlbnQgY29u
dGlndW91cyByYW5nZXMuCgpZZWFoLCBidXQgdGhlbiB5b3UgYWxzbyBnZXQgYWJzb2x1dGVseSB6
ZXJvIFRIUCBhbmQgZnJhZ21lbnQgZmxhZ3Mgc3VwcG9ydC4KCkJ1dCBJIHRoaW5rIHdlIGNvdWxk
IGFsc28gYWRkIHRob3NlIGxhdGVyIG9uLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IFJlZ2Fy
ZHMsCj4gIMKgIEZlbGl4Cj4KPgo+PiBXZSB3b3VsZCBzb21laG93IG5lZWQgdG8gY2hhbmdlIHRo
YXQgdG8gZ2V0IHRoZSBmbGFncyBkaXJlY3RseSBmcm9tCj4+IHRoZSBsb3cgYml0cyBvZiB0aGUg
RE1BIGFkZHJlc3Mgb3Igc29tZXRoaW5nIGluc3RlYWQuCj4+Cj4+IENocmlzdGlhbi4KPj4KPj4+
IE9uY2UgdGhpcyBpcyBkb25lLCBpdCBsZWFkcyB0byBhIG51bWJlciBvZiBvcHBvcnR1bml0aWVz
IGZvcgo+Pj4gc2ltcGxpZmljYXRpb24gYW5kIGJldHRlciBlZmZpY2llbmN5IGluIGtmZF9zdm06
Cj4+Pgo+Pj4gIMKgwqAgKiBTdXBwb3J0IG1pZ3JhdGlvbiB3aGVuIGNwYWdlcyAhPSBucGFnZXMK
Pj4+ICDCoMKgICogTWlncmF0ZSBhIHBhcnQgb2YgYW4gc3ZtX3JhbmdlIHdpdGhvdXQgc3BsaXR0
aW5nIGl0LiBObyBtb3JlCj4+PiAgwqDCoMKgwqAgc3BsaXR0aW5nIG9mIHJhbmdlcyBpbiBDUFUg
cGFnZSBmYXVsdHMKPj4+ICDCoMKgICogTWlncmF0ZSBhIHBhcnQgb2YgYW4gc3ZtX3JhbmdlIGlu
IEdQVSBwYWdlIGZhdWx0IGhhbmRsZXIuIE5vIG1vcmUKPj4+ICDCoMKgwqDCoCBtaWdyYXRpbmcg
dGhlIHdob2xlIHJhbmdlIGZvciBhIHNpbmdsZSBwYWdlIGZhdWx0Cj4+PiAgwqDCoCAqIFNpbXBs
aWZpZWQgVlJBTSBtYW5hZ2VtZW50IChzZWUgYmVsb3cpCj4+Pgo+Pj4gV2l0aCB0aGF0LCBzdm1f
cmFuZ2Ugd2lsbCBubyBsb25nZXIgaGF2ZSBhbiAiYWN0dWFsX2xvYyIgZmllbGQuIElmIHdlJ3Jl
Cj4+PiBub3Qgc3VyZSB3aGVyZSB0aGUgZGF0YSBpcywgd2UgbmVlZCB0byBjYWxsIG1pZ3JhdGUu
IElmIGl0J3MgYWxyZWFkeSBpbgo+Pj4gdGhlIHJpZ2h0IHBsYWNlLCB0aGVuIGNwYWdlcyB3aWxs
IGJlIDAgYW5kIHdlIGNhbiBza2lwIGFsbCB0aGUgc3RlcHMKPj4+IGFmdGVyIG1pZ3JhdGVfdm1h
X3NldHVwLgo+Pj4KPj4+IFNpbXBsaWZpZWQgVlJBTSBtYW5hZ2VtZW50Cj4+PiA9PT09PT09PT09
PT09PQo+Pj4KPj4+IFZSQU0gQk9zIGFyZSBubyBsb25nZXIgYXNzb2NpYXRlZCB3aXRoIHByYW5n
ZXMuIEluc3RlYWQgdGhleSBhcmUKPj4+ICJmcmVlLWZsb2F0aW5nIiwgYWxsb2NhdGVkIGR1cmlu
ZyBtaWdyYXRpb24gdG8gVlJBTSwgd2l0aCByZWZlcmVuY2UKPj4+IGNvdW50IGZvciBlYWNoIHBh
Z2UgdGhhdCB1c2VzIHRoZSBCTy4gUmVmIGlzIHJlbGVhc2VkIGluIHBhZ2UtcmVsZWFzZQo+Pj4g
Y2FsbGJhY2suIFdoZW4gdGhlIHJlZiBjb3VudCBkcm9wcyB0byAwLCBmcmVlIHRoZSBCTy4KPj4+
Cj4+PiBWUkFNIEJPIHNpemUgc2hvdWxkIG1hdGNoIHRoZSBtaWdyYXRpb24gZ3JhbnVsYXJpdHks
IDJNQiBieSBkZWZhdWx0Lgo+Pj4gVGhhdCB3YXkgdGhlIEJPIGNhbiBiZSBmcmVlZCB3aGVuIG1l
bW9yeSBnZXRzIG1pZ3JhdGVkIG91dC4gSWYgbWlncmF0aW9uCj4+PiBvZiBzb21lIHBhZ2VzIGZh
aWxzIHRoZSBCTyBtYXkgbm90IGJlIGZ1bGx5IG9jY3VwaWVkLiBBbHNvIHNvbWUgcGFnZXMKPj4+
IG1heSBiZSByZWxlYXNlZCBpbmRpdmlkdWFsbHkgb24gQStBIGR1ZSB0byBDT1cgb3Igb3RoZXIg
ZXZlbnRzLgo+Pj4KPj4+IEV2aWN0aW9uIG5lZWRzIHRvIG1pZ3JhdGUgYWxsIHRoZSBwYWdlcyBz
dGlsbCB1c2luZyB0aGUgQk8uIElmIHRoZSBCTwo+Pj4gc3RydWN0IGtlZXBzIGFuIGFycmF5IG9m
IHBhZ2UgcG9pbnRlcnMsIHRoYXQncyBiYXNpY2FsbHkgdGhlIG1pZ3JhdGUuc3JjCj4+PiBmb3Ig
dGhlIGV2aWN0aW9uLiBNaWdyYXRpb24gY2FsbHMgInRyeV90b191bm1hcCIsIHdoaWNoIGhhcyB0
aGUgYmVzdAo+Pj4gY2hhbmNlIG9mIGZyZWVpbmcgdGhlIEJPLCBldmVuIHdoZW4gc2hhcmVkIGJ5
IG11bHRpcGxlIHByb2Nlc3Nlcy4KPj4+Cj4+PiBJZiB3ZSBjYW5ub3QgZ3VhcmFudGVlIGV2aWN0
aW9uIG9mIHBhZ2VzLCB3ZSBjYW5ub3QgdXNlIFRUTSBmb3IgVlJBTQo+Pj4gYWxsb2NhdGlvbnMu
IE5lZWQgdG8gdXNlIGFtZGdwdV92cmFtX21nci4gTmVlZCBhIHdheSB0byBkZXRlY3QgbWVtb3J5
Cj4+PiBwcmVzc3VyZSBzbyB3ZSBjYW4gc3RhcnQgZXZpY3RpbmcgbWVtb3J5Lgo+Pj4KPj4+IFJl
Z2FyZHMsCj4+PiAgwqDCoCBGZWxpeAo+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
