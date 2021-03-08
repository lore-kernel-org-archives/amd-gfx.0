Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF5AC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AFB651D1
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AFB651D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD3B289612;
	Mon,  8 Mar 2021 13:58:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8776289612
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 13:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVl3++i35gXp3FQaVzVyUCYzZzOVb8nMQDteE2ZRhcmcNx8JpRBrWydePdEIAz7lmaYiQjfQwRwhDLHIzj34dbgcY312nBePlj0Ws0q8sIy77zGnpomA4vgWuEOupYteVUSkChfDJA35QM9lL0cj15j/mgE3c4jn1ISxKqf4XN89B9JlVPqofBQ1Z1hHmiFCejrSSXDWTU1kA/amBu2N8adTRhaWhGU1foUY8no2cvjf018lwbmEMO6EJAbayrJ58pP2iybdDjGLuGb6Fw3m3bcdjH/UQSZ+huDIsZTW9JwdiJTSWN8anBFpvoseKXjINgPxasStjC7uJLE3S5jYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BnbGb6ZhqGmJac149jms0AB14Sets7WQZrzlECHJ/4=;
 b=lsZy8OiSpRMwcVQgDE2WkbalfgmW7WnmybBLGQH2BOVnjiloXRbCkGNUnhSTgEZWsunRvPtxlxk3h4G1K8EytWpD/LTKzoBf3YFQK8tv3RQj+/CUZOXYQ1WmJDZi7XMHLtOaKvAMEk6reo1kNoR34AeFFxubsI1UHpdHjFoYzPr7XnICL8IKlrodyWwUqRH5QHHrVWLTmA6GI4BHa9W8HgNDi2ZxOeO8AxWy0FReAb3kO4KAv+pV/rggdgJM9y+1bAcHFX9M4jdloGE/CSboyoez0wuB+VVd2fieb5Y6J5DBPGycbjqAJYXuBkckdNsfBOqX/CcWu+6qRrcdEB/tGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BnbGb6ZhqGmJac149jms0AB14Sets7WQZrzlECHJ/4=;
 b=zZdCQJe4fVYVJ7Ds14hidW4+M1Z2wdqE1CA68O8+465xlJQBBDC5Z1sfNVoUHhziHVucNf4UBHcKC1QzWRYMRY+YTjGUKdTQQRJrOhYLp1GrDcBkK5r7/C6T7KDDQAjNFQgj2uLIiRmWw9T4Q2c1/xHbv21kYDzfiAAs54w8Exo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 8 Mar
 2021 13:58:28 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 13:58:28 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu: use amdgpu_bo_create_user() for gem object
To: Nirmoy <nirmodas@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Nirmoy Das <nirmoy.das@amd.com>
References: <20210305143532.5936-1-nirmoy.das@amd.com>
 <20210305143532.5936-3-nirmoy.das@amd.com>
 <0d083697-b194-99ac-71b5-866d2974a6a8@gmail.com>
 <ede649d0-2e9a-1826-28c8-e2d348887d1a@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a3c7d386-8e64-b579-4f20-03634cfe4df7@amd.com>
Date: Mon, 8 Mar 2021 14:58:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <ede649d0-2e9a-1826-28c8-e2d348887d1a@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:4794:2f8d:7bcd:36a5]
X-ClientProxiedBy: AM0PR01CA0127.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::32) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:4794:2f8d:7bcd:36a5]
 (2a02:908:1252:fb60:4794:2f8d:7bcd:36a5) by
 AM0PR01CA0127.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 13:58:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11f00bcd-f567-469f-8ec2-08d8e23a3f5a
X-MS-TrafficTypeDiagnostic: BL0PR12MB4913:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4913C7270A385D32253BABDE83939@BL0PR12MB4913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yx/eNL3FH/poAlHUvTS5EBvns+17iZa3F5Iv/QBO7eEWERsOJYcs/l0eIMa3lhwolAvFecQhp1aBUk2e7GPVNE9O1ckJs4XugMVkFYX67Ngy2HyN34oddE7cdR6P8jaxNAUmk2aIHedcyKDIrKh2QJOCMNDZUiSmDU0qw49R+dcDsjCvCq7/JzxRG9b1eMYfvlagzX7RXvHqbdiXugyk73zWg3PmL3MshMWBuhEhxJza5b2cFRdGg7VaOMymZDbtoIUGvw7aGnghMxgrf9CAe7DlbfknqBYb7ZD8jnu567r9hGvmy8gU1GtrLTAGGCWbrs9A1zOiwVYrw7c3W7g+3/QdcxjZ6DlAa3MQ31J5kyIRCGXRFS4jwqIwXfswakbB0ELAZ9leulO/tMNHN43g2MdReVGrvAg7lJv16LfSyxkWdyq2rI473GMH26FXwu6l/sN9CleLAsqgMuNEWq1dJ45gwkv2g02Y2FZHN3IObRvgjJmOTe9a3Hx/UZyndPOEyb52cXTASO/wEXgHNCq0XM3kE2ZOOwGuq8nod89vw1ILTNk88HjaEHqINyzWwoqDXw107f1j3tGN2ZvzALsdMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(86362001)(31696002)(4326008)(186003)(16526019)(6666004)(8936002)(478600001)(2906002)(53546011)(6636002)(6486002)(110136005)(316002)(31686004)(83380400001)(2616005)(52116002)(66574015)(36756003)(5660300002)(66946007)(66476007)(66556008)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YmdmUXhvakZwL09kYTErQUpCL0hTclgwYmFTd1o4dGRLTVV4S0JaMzgvUmk5?=
 =?utf-8?B?ZzdDNVo4aE1EV1VObXg3VzNJVnp6YVVsZWU5RjY0aktyblI0RUVMV3BRLzdE?=
 =?utf-8?B?S2x5QStLaWU3cFJOM1hGYmZ2ZW05dDRuMERNVGlZSjVrTnVxN0c3Z3ZiRHZ3?=
 =?utf-8?B?bjlRY1JHSWRGcGdIbnAwWUdjSnhpbmVTZzhFdGx6NlR5cnRpMEtKOHFTMXlo?=
 =?utf-8?B?OE5uUjVjT3RhWVlHM1UvKzVQQ1lGMnFrRklxNVExaUsrRVZsS2NJZ0hpZ1di?=
 =?utf-8?B?bEtiY3N6cmFlVGRVdXdkQ2N0UTZDakl2MzdKNkZhVDNqYURXM3UreWhGbksz?=
 =?utf-8?B?eGt5SDdIMFVlWHNjdnRIYWoyZVVkQnlNNDBBaDIrZjdPRWIvYXZrK3FTeGNN?=
 =?utf-8?B?SW1YNmFjcEtYWVl2aERTa3J6eGxISE5CUVJVNDlWejBoQXRZNTM3Z2xGOUJT?=
 =?utf-8?B?b0UxWFJTditYYXdEUHMwSFBQV3FYN2E5NVIzYWIzNVB6U3F2M0lXNDNEdGpW?=
 =?utf-8?B?YlNlbk0wTmpoMkg1R1Z3MTU3UW9NZktiVjRMSzRIUCt1VHBKUVoyY1I2bnYw?=
 =?utf-8?B?QnN5QW5NMHRvRytWSDlJZmhQbmJjZnYwTEtFVTUvRmhQc1JsSzRsNUdxS2dh?=
 =?utf-8?B?SW54dnpDa1VvMkFRR2VhanhjNisrSFJBeEJKTEtLY1ZMMVl6bjZaZjlNS0hl?=
 =?utf-8?B?d3ZFSjVvSlNPamlsRi8vYWVCbm5TU2czUE9hakprVXNHT3JBaUJUNUR4dEpo?=
 =?utf-8?B?TkdJdkM1VWszNFVxSVVKZmMzZXZhb0Z6Kzh6Y3REdUUyY3BybXQraEI3UG9x?=
 =?utf-8?B?U0FOWEVFM1FxbDdnV09jak5BWHZveXlCT2VrbzAzbEZwSnkvSGJWMDVQVHEw?=
 =?utf-8?B?NTY0OGkzdHZDZ1VHMithaW9Zd25MMU1SaDJVMXFOakcvT0RJbVpjc1ZDOEhq?=
 =?utf-8?B?aXRzMzF1OXF3c0FUOEl0T0JmMEZUQUtkVlBlaWdqWXhad1FvQlBXamNVOWV3?=
 =?utf-8?B?VzNwT0VLMDNIYVJnVVptcDJxaTJVY3lmczFjRGZYUzA0cnJBa3lBN2lpa3VT?=
 =?utf-8?B?aFRuOEhiS0IwNWswek11bmpZTmsyaUJYQTZHUDFUYXhEbXdCcW1XS0ZEQkJa?=
 =?utf-8?B?VDViR0laTU00UGR2a3NmU2oxR090SWhvMXVzTG9CdVBZaFVHb2gxTHAxUHNn?=
 =?utf-8?B?TzBwZkVvNVRPNFVnR3lLWU1SU25uek9tNnl5bS8xQzBvQVowTi9FUTNXdlR6?=
 =?utf-8?B?U2F4ODZBVjJUZDJPZ0hBY3VWcXRZYVhQcWxiS0o0MUhJK0srcHNHdnU1WXFL?=
 =?utf-8?B?aytKeG1RUTVCTGpTeHluSlhLVXhlZ2RLckprZjRZcndjcElzcE1pQkdXQkZI?=
 =?utf-8?B?UlprSi9XYlN4OVJsSU1EY2dDTERlaHgvU2pua2NnandGMlNXaytsdS9talpT?=
 =?utf-8?B?amtrR2tud2tRM2I4cFdDcWNmOGZFWjQ1QWhtN1h0VXNGbUg5Y1VTeU9rSDli?=
 =?utf-8?B?WHRtNExiNzBvbHlBblhlTVA2TDAwbHNlZTloZk84U0tuYms2dmZCekRFZ25O?=
 =?utf-8?B?Nk50ZkRHK0dnNThlcTNkVXNiT0hrZWcwbXZXcXQrQnpITFdSUm9QSVJYaU5k?=
 =?utf-8?B?ZWRQUm1RbnZ4VnhNSUFmSWVsNWVxbUZpNFVLa1RWZXZ0SzdVY2JCY0FNNjE5?=
 =?utf-8?B?RnRXV0Nja0c5MmRKOEhiSzJoUEoxbXBCYnVzWFlpcDRDYUp0ZE1jZGxTYjQ2?=
 =?utf-8?B?Y3RFdWx3dmlkQzA5SmV5M2h1Q3pzbDMrRUZrOWhGMytscXN0WXdiMGJ4OHBU?=
 =?utf-8?B?UjVsWnlDUEZLaHA4eXIrU05GNFBUM3M2Z1VQWjFpOStscXlXeUZLcGVwUU9l?=
 =?utf-8?Q?Tjok/sKAz/ybq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f00bcd-f567-469f-8ec2-08d8e23a3f5a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 13:58:27.9250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqR6gIvhSSN9k2kJOWlSIH4wQmhE00hCFGDaz4snWA+ZsWFQKem1HntWONeftAej
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAwOC4wMy4yMSB1bSAxNDo1NiBzY2hyaWViIE5pcm1veToKPgo+IE9uIDMvNS8yMSA0OjEx
IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBXZSBtaWdodCBuZWVkIHRvIHVzZSB0aGlz
IGZvciB0aGUgS0ZEIGFzIHdlbGwuCj4KPiBEbyB5b3UgbWVhbiBmb3IgYW1kZ3B1X2FtZGtmZF9h
bGxvY19nd3MoKSA/CgpGb3IgZXhhbXBsZSwgeWVzLiBCYXNpY2FsbHkgYWxsIHBsYWNlcyB3aGVy
ZSBLRkQgYWxsb2NhdGVkIGFuIEJPIHdpdGggCnRoZSBUVE0gdHlwZSBkZXZpY2UvdXNlci4KClJl
Z2FyZHMsCkNocmlzdGlhbi4KCj4KPgo+IFJlZ2FyZHMsCj4KPiBOaXJtb3kKPgo+Cj4KPj4KPj4g
Q2hyaXN0aWFuLgo+Pgo+PiBBbSAwNS4wMy4yMSB1bSAxNTozNSBzY2hyaWViIE5pcm1veSBEYXM6
Cj4+PiBHRU0gb2JqZWN0cyBlbmNhcHN1bGF0ZSBhbWRncHVfYm8gZm9yIHVzZXJzcGFjZSBhcHBs
aWNhdGlvbnMuCj4+PiBOb3cgdGhhdCB3ZSBoYXZlIGEgbmV3IGFtZGdwdV9ib191c2VyIHN1YmNs
YXNzIGZvciB0aGF0IHB1cnBvc2UsCj4+PiBsZXQncyB1c2UgdGhhdCBpbnN0ZWFkLgo+Pj4KPj4+
IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPj4+IC0tLQo+
Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIHwgNCArKystCj4+
PiDCoCAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyAK
Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+PiBpbmRleCA4
ZTliOGE2ZTZlZjAuLjlkMmI1NWViMzFjMiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dlbS5jCj4+PiBAQCAtNTQsNiArNTQsNyBAQCBpbnQgYW1kZ3B1X2dlbV9v
YmplY3RfY3JlYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlIAo+Pj4gKmFkZXYsIHVuc2lnbmVkIGxv
bmcgc2l6ZSwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qg
ZHJtX2dlbV9vYmplY3QgKipvYmopCj4+PiDCoCB7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRn
cHVfYm8gKmJvOwo+Pj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvX3VzZXIgKnVibzsKPj4+IMKg
wqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ib19wYXJhbSBicDsKPj4+IMKgwqDCoMKgwqAgaW50IHI7
Cj4+PiDCoCBAQCAtNjgsNyArNjksNyBAQCBpbnQgYW1kZ3B1X2dlbV9vYmplY3RfY3JlYXRlKHN0
cnVjdCAKPj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2lnbmVkIGxvbmcgc2l6ZSwKPj4+IMKg
IHJldHJ5Ogo+Pj4gwqDCoMKgwqDCoCBicC5mbGFncyA9IGZsYWdzOwo+Pj4gwqDCoMKgwqDCoCBi
cC5kb21haW4gPSBpbml0aWFsX2RvbWFpbjsKPj4+IC3CoMKgwqAgciA9IGFtZGdwdV9ib19jcmVh
dGUoYWRldiwgJmJwLCAmYm8pOwo+Pj4gK8KgwqDCoCByID0gYW1kZ3B1X2JvX2NyZWF0ZV91c2Vy
KGFkZXYsICZicCwgJnVibyk7Cj4+PiDCoMKgwqDCoMKgIGlmIChyKSB7Cj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKHIgIT0gLUVSRVNUQVJUU1lTKSB7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAoZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9DUFVfQUNDRVNTX1JFUVVJUkVE
KSB7Cj4+PiBAQCAtODUsNiArODYsNyBAQCBpbnQgYW1kZ3B1X2dlbV9vYmplY3RfY3JlYXRlKHN0
cnVjdCBhbWRncHVfZGV2aWNlIAo+Pj4gKmFkZXYsIHVuc2lnbmVkIGxvbmcgc2l6ZSwKPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCB9Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+PiDC
oMKgwqDCoMKgIH0KPj4+ICvCoMKgwqAgYm8gPSAmdWJvLT5ibzsKPj4+IMKgwqDCoMKgwqAgKm9i
aiA9ICZiby0+dGJvLmJhc2U7Cj4+PiDCoCDCoMKgwqDCoMKgIHJldHVybiAwOwo+PgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
