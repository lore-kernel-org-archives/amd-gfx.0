Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C304C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 15:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D003861426
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 15:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D003861426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F2486E0C4;
	Wed, 21 Apr 2021 15:29:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB306E0C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 15:29:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDaJkr6+eesPzVjJd8B8CbCMLDw9YE7r7Sa3hOehKdNjuik0YV2srIreh8cRxMEPKHVyalfhkyNqSDorJNxXJ6FzMMUT5F5rU6B0tognDMCuvrM3cHTh5Eye2guBlmYiBVw9SzwH5unTGSpv5w1TgiOYBMmRtHghUdTNhQz8rUqG0QcFN/eY3nHfhuGnRdWxG+8ZHb0Eb+apu0jO4xcK8By2MJeaW0ICAXcZIo7z7toNxfAr+txOshOWRIcdRcpDM/N29d63hyfkqyuMzLRCOrBwqRa1xfsVESLf2QS8b0TEiXT4qGjAZHkmytZphZj6Xwt0lszsxanyfZZ2/emLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6HXXG7UGdgZ4IIsBxiB6F6RfydRfi1YbVGTJCRiO1U=;
 b=f1EU6OUzyGjYg8fdcCZFn79bdvaa5kV0RKHSw8fXGB9bcG0ae9MY63zFjJC2ClTP0UrtW/WJ7liwy3Wyzov4ugOeggGmyBsecp/Tj435+mg/jQPQoV99a7QkV+dTqVzRpEEuAiL7PYjnRRZbUEta98ntyOq4SD09hF0aWWJF074zdTf0euVZu8DIkSt9P6GiUM1lYY0ao16NP9voVlma2Rjsbfg+4pgh7zbGQ8Kk2LfIheyJD6JSxx5cyzEyhdG/i1RiWJzANVq8fKMsVfrJ8odDQpvtsm3tqD+83h5r0z5ljJXHvTR1xZpHQoMMWg55U3VHNHiEEhyDIjLdc7x9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6HXXG7UGdgZ4IIsBxiB6F6RfydRfi1YbVGTJCRiO1U=;
 b=edkfhRcm5tC7WpCw2YrglZfVgQjDjmoAgKqOh2+o3bjZsYRGLDl2JCNA60g8h9awMJy1/1lExbHAFpxv/JU2OJSGQ2ZRHAnyb/eEIckUiur/yO/DdTdY/j8Gy6yqs9505fsHc7IVwMo+/+/j2AWy7yyTLrFrgvTw/VYTvZcysCE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB3790.namprd12.prod.outlook.com (2603:10b6:208:164::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.20; Wed, 21 Apr
 2021 15:29:10 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Wed, 21 Apr 2021
 15:29:10 +0000
Subject: Re: [PATCH 4/6] drm/amdgpu: address remove from fault filter
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
References: <20210420202122.4701-1-Philip.Yang@amd.com>
 <20210420202122.4701-4-Philip.Yang@amd.com>
 <d9ff9130-667f-1b5f-83b9-d7dc77743db3@amd.com>
 <818c1295-2340-a6fe-9b64-e7a5e74d411e@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <9ea89549-afb4-ed48-4ff2-0ae740251d59@amd.com>
Date: Wed, 21 Apr 2021 11:29:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <818c1295-2340-a6fe-9b64-e7a5e74d411e@gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::43) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Wed, 21 Apr 2021 15:29:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0e1ab24-ed6e-450f-3fb3-08d904da35ef
X-MS-TrafficTypeDiagnostic: MN2PR12MB3790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3790F7A6F7544964DD496E8392479@MN2PR12MB3790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3RmC4XVYwot2OiIytOEuAkpMxOMpRfzvi1pppl3dP8D8mc3Ds7UF6pgUSHYaGv9WNm1ZY+iZx/JvNCoXuX46c+z+BUwshyD+6FG5/liszLYY19No214yhdwWVDoZvIrzzljo0jGgyteBHNJLamVeuFfQpvnkQAyRFt1ghzyVH1e61pM0t65HwcV/nHVVS9RGTuEZyYpLvbVulCFV+e338G822iHVVebRBhAyZYCpKfF/CZHcgGRGmwA+od6hVAJW0azALje6cQ+nApOumdlQYhfZoMbXruDBvLZxew+NDP/O2VIS0gLEw2NC/lmkQQ8XkGHfO3ZyApD4r2z18gmjqo/wB3QJ3g7+GgQTcsamR842Xyr30hKKTSCeyXzciBN1uVn2nJYpH2IOoZ6d9vjaauyoDNbl0gjISZy7qeKSv98gEJvFia1r1nc5MeID2jx+e6L/4Zs6XrtAhfDeqlLBwOhc1O6/WCJONGE2zxl2Vm8ySC4rtyyugih3xVszbUb28stFGeyLNOoHABTg7K61rlyB5xn9VzPR961uFN/MMvkn+toGL7xwyUOm3I2o0F0oatZu4D/dFFHyPkQdd5VXDT4ZnrndoCEf10XIZ5v8cVlCT/50OE2IUdvsuw6Jr/C3+NUGmv5CIO1ffck0YHO8hX/GOLo3UcPow77xPUyOR6IE2I+YY4JIBfQqrGzYUT6IevXETewi7YlUxs09bXqTL7jq5T/Qz9oiUtI9Cea0OycwrFZ34cK/brI3unRSyHciOXxwiSmFtRQhSuk2lbbKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(2906002)(2616005)(53546011)(31686004)(86362001)(16576012)(956004)(6636002)(31696002)(16526019)(478600001)(66574015)(966005)(6486002)(316002)(83380400001)(36916002)(26005)(66946007)(38100700002)(66476007)(66556008)(38350700002)(110136005)(186003)(44832011)(8676002)(52116002)(36756003)(45080400002)(5660300002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aGgvSkx6TCs4bUZWeElvOE5ZQW5uRi9YanRQT3JOYmE4dUhmdGhWK21sOC9W?=
 =?utf-8?B?SDNJWnpaY1RTSy90dXlQcjBJR2o0ZE5xZnlrOXpYZld4NjlnaDUra0x1a3lH?=
 =?utf-8?B?NWxjbVpsUzRFdmQvTGc0OTVrWE5SbHlLV2dsbDh1RE5qeEZ3Y0svU3lYWTdl?=
 =?utf-8?B?ZllMcS91b3VCMGZRcVBqWHpJalNreGlkTFNBYkdoMXZCZEF1Rzd1WUN2ai9Y?=
 =?utf-8?B?dmtvbG9MUEVIekdwRXJFMk84RHhxSFRKMDVYSmt6UXFzTjRueE1YN0gwTGtH?=
 =?utf-8?B?bXo2aUxzN0F2NmUrR3BoYzAzanVrTWZieDhiZG1oejFqc2dPYzRNOFczU0Za?=
 =?utf-8?B?RlYxZllLa3k1dHd4N09hOUQ0aVpFR2IvZnFnODJrcENnbjlXZDN6RElrVnlz?=
 =?utf-8?B?OGRVdE9jSHcxSmQxMU5MMkt2ajNPQlQzekR6Zk9VeE50TzNUTXcxOFRlUzJy?=
 =?utf-8?B?cnJZc21LTWllQmZ6YTFKZlFMbHlKZWVpWXQ1NzkrcXhLWG9YNG1WNDNWd3ln?=
 =?utf-8?B?amRJR0drRjVtWG5ZNndqQzJ2V2JMR3RJQm44eWlsQldlZEU5cnNldlRia21K?=
 =?utf-8?B?UGRaWUU3aGtuZkQxZDhacnZFbmJhb1NDWE9GMEIwZHN1WFp1OWdTZ05Mczl0?=
 =?utf-8?B?b0RHcEM4ZU0xdjVyL2JmNm8vcE5obS9RUDBQNUx5c2J4VndBMmZWc1pST296?=
 =?utf-8?B?TGhydzZEVlpxajVkUS9MM09jV2FzV3UrY3JieE8rMC9FQ2Ixb2hkbGVzZTl6?=
 =?utf-8?B?cHJHRmY5VGNQZFhkQ2M0NStHckxCb1ozSXRpclN3amJ3eDFRd1YzTEdyVTh3?=
 =?utf-8?B?WS8wNHlmNGpRLzFVU1hOSWxVRVVYS2RoQURaTk1jSlEramwyanRSZEgvc1ZU?=
 =?utf-8?B?ejc2TURPKzFzZVhSZkhyQlUxdnV2RW5iOE5oc1BWa0VabFlMTUVRdEJ3c3lG?=
 =?utf-8?B?VVQ0Z00xTkV0R21vWUtaWktTdFhFLytIaml1Y0RKZWJkZ3ZZOUNFRUJvRGdJ?=
 =?utf-8?B?OEtmWElxRnVtdlN0ZlQzWE9sNFk5MEhudEJzL00xazhLeHQ4WmRyM1FkdURI?=
 =?utf-8?B?bDdZVnRSL2phSVJoNmwwYzlXb2JoUy9jMk9lc3EybTQzV0oxd2k3eG84R01M?=
 =?utf-8?B?Z1hmeDlwNWgyVzc5ekQ1T3FOY3ZZbjhxTnVkczc3TWpnTGIyUVplM0JrRnNv?=
 =?utf-8?B?M2FvUm1nYU1kc3N2S09mdjRXY1QzeFNOUmJJQ2M3cXovc0tHSi9aRFZ0bjlS?=
 =?utf-8?B?NHdCV2RLTno4QmQ4UWZZMno0QS9IUFM4UldxRkhzNkkrblZMbUlNNlBHYzdy?=
 =?utf-8?B?TXYva3YzUEhtTFZ6Q1gyWGVEUUxaZk0vYzRtYUpmRnQxb2x0WFNjUkdZR2Ew?=
 =?utf-8?B?akhVdFBoWXFmYy8wMVl1U1ZESmRLYjk0aFkwQUpqbUFtenl6eHFwNFNUeDhr?=
 =?utf-8?B?L3NtZFlRVFlWOTVYdGhOQmptU09hWGlPcjFXdndxb1g4V05oajNkQXFXUms2?=
 =?utf-8?B?MVFMNnZZVzFkK2xSdXNqOGhVcjZzNXFUKzJtczlKR0ZpdTd4SHcwWWlwdndG?=
 =?utf-8?B?aFZtVllXd1JVUVNRK2N5SHFPNWpWb0lubkhnY3ZZNExKeWF3d0cyU2J0Z25j?=
 =?utf-8?B?c1BJYWh0b3lBUkVQaGoyc1MwNHN2S0RPc285TUFGQ2Vqem43VjFZMEY3d0NW?=
 =?utf-8?B?WHJUR281V0RDUFdiREovOFZTeStJRWJObmF4YjNwNGg5ZGFIdnQ1NHhCQ0dG?=
 =?utf-8?Q?mU4Cp5TKAOsDVSXTGoxzmzPkqu1w5Mllqs+Vlfn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e1ab24-ed6e-450f-3fb3-08d904da35ef
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 15:29:10.5940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFj7tbvQXpQKO/ikxep+ABqPkfBlfFZGIE9w6LYIEfQm24H2uXEEDFg1VPw/JyJ0KXBVC6TbM0G9fhMuifKg7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3790
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

T24gMjAyMS0wNC0yMSAzOjU1IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjEu
MDQuMjEgdW0gMDM6MjAgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPj4gQW0gMjAyMS0wNC0yMCB1
bSA0OjIxIHAubS4gc2NocmllYiBQaGlsaXAgWWFuZzoKPj4+IEFkZCBpbnRlcmZhY2UgdG8gcmVt
b3ZlIGFkZHJlc3MgZnJvbSBmYXVsdCBmaWx0ZXIgcmluZyBieSByZXNldHRpbmcKPj4+IGZhdWx0
IHJpbmcgZW50cnkgb2YgdGhlIGZhdWx0IGFkZHJlc3MgdGltZXN0YW1wIHRvIDAsIHRoZW4gZnV0
dXJlIHZtCj4+PiBmYXVsdCBvbiB0aGUgYWRkcmVzcyB3aWxsIGJlIHByb2Nlc3NlZCB0byByZWNv
dmVyLgo+Pj4KPj4+IENoZWNrIGZhdWx0IGFkZHJlc3MgZnJvbSBmYXVsdCByaW5nLCBhZGQgYWRk
cmVzcyBpbnRvIGZhdWx0IHJpbmcgYW5kCj4+PiByZW1vdmUgYWRkcmVzcyBmcm9tIGZhdWx0IHJp
bmcgYXJlIHNlcmlhbGl6ZWQgaW4gc2FtZSBpbnRlcnJ1cHQgCj4+PiBkZWZlcnJlZAo+Pj4gd29y
aywgZG9uJ3QgaGF2ZSByYWNlIGNvbmRpdGlvbi4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBQaGls
aXAgWWFuZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysr
Cj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmggfMKgIDIgKysK
Pj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMgCj4+PiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+Pj4gaW5kZXggYzM5ZWQ5ZWIwOTg3
Li4zMzhlNDVmYTY2Y2IgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ21jLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nbWMuYwo+Pj4gQEAgLTM4Nyw2ICszODcsMzAgQEAgYm9vbCBhbWRncHVfZ21jX2ZpbHRlcl9m
YXVsdHMoc3RydWN0IAo+Pj4gYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDY0X3QgYWRkciwKPj4+
IMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+Pj4gwqAgfQo+Pj4gwqAgKy8qKgo+Pj4gKyAqIGFt
ZGdwdV9nbWNfZmlsdGVyX2ZhdWx0c19yZW1vdmUgLSByZW1vdmUgYWRkcmVzcyBmcm9tIFZNIGZh
dWx0cyAKPj4+IGZpbHRlcgo+Pj4gKyAqCj4+PiArICogQGFkZXY6IGFtZGdwdSBkZXZpY2Ugc3Ry
dWN0dXJlCj4+PiArICogQGFkZHI6IGFkZHJlc3Mgb2YgdGhlIFZNIGZhdWx0Cj4+PiArICogQHBh
c2lkOiBQQVNJRCBvZiB0aGUgcHJvY2VzcyBjYXVzaW5nIHRoZSBmYXVsdAo+Pj4gKyAqCj4+PiAr
ICogUmVtb3ZlIHRoZSBhZGRyZXNzIGZyb20gZmF1bHQgZmlsdGVyLCB0aGVuIGZ1dHVyZSB2bSBm
YXVsdCBvbiAKPj4+IHRoaXMgYWRkcmVzcwo+Pj4gKyAqIHdpbGwgcGFzcyB0byByZXRyeSBmYXVs
dCBoYW5kbGVyIHRvIHJlY292ZXIuCj4+PiArICovCj4+PiArdm9pZCBhbWRncHVfZ21jX2ZpbHRl
cl9mYXVsdHNfcmVtb3ZlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCAKPj4+IHVpbnQ2NF90
IGFkZHIsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50
MTZfdCBwYXNpZCkKPj4+ICt7Cj4+PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfZ21jICpnbWMgPSAm
YWRldi0+Z21jOwo+Pj4gKwo+Pj4gK8KgwqDCoCB1aW50NjRfdCBrZXkgPSBhZGRyIDw8IDQgfCBw
YXNpZDsKPj4+ICvCoMKgwqAgc3RydWN0IGFtZGdwdV9nbWNfZmF1bHQgKmZhdWx0Owo+Pj4gK8Kg
wqDCoCB1aW50MzJfdCBoYXNoOwo+Pj4gKwo+Pj4gK8KgwqDCoCBoYXNoID0gaGFzaF82NChrZXks
IEFNREdQVV9HTUNfRkFVTFRfSEFTSF9PUkRFUik7Cj4+PiArwqDCoMKgIGZhdWx0ID0gJmdtYy0+
ZmF1bHRfcmluZ1tnbWMtPmZhdWx0X2hhc2hbaGFzaF0uaWR4XTsKPj4gWW91IG5lZWQgdG8gbG9v
cCBvdmVyIHRoZSBmYXVsdCByaW5nIHRvIGZpbmQgYSBmYXVsdCB3aXRoIHRoZSBtYXRjaGluZwo+
PiBrZXkgc2luY2UgdGhlcmUgbWF5IGJlIGhhc2ggY29sbGlzaW9ucy4KPj4KPj4gWW91IGFsc28g
bmVlZCB0byBtYWtlIHN1cmUgeW91IGRvbid0IGJyZWFrIHRoZSBzaW5nbGUgbGluayBsaXN0IG9m
IGtleXMKPj4gd2l0aCB0aGUgc2FtZSBoYXNoIHdoZW4geW91IHJlbW92ZSBhbiBlbnRyeS4gSSB0
aGluayB0aGUgZWFzaWVyIHdheSB0bwo+PiByZW1vdmUgYW4gZW50cnkgd2l0aG91dCBicmVha2lu
ZyB0aGlzIHJpbmcrY2xvc2VkIGhhc2hpbmcgc3RydWN0dXJlIGlzCj4+IHRvIHJlc2V0IHRoZSBm
YXVsdC0+a2V5IHJhdGhlciB0aGFuIHRoZSBmYXVsdC0+dGltZXN0YW1wLgo+Pgo+PiBGaW5hbGx5
LCB5b3UgbmVlZCB0byBhZGQgbG9ja2luZyB0byB0aGUgZmF1bHQgcmluZyBzdHJ1Y3R1cmUuIEN1
cnJlbnRseQo+PiBpdCdzIG5vdCBwcm90ZWN0ZWQgYnkgYW55IGxvY2tzIGJlY2F1c2Ugb25seSBv
bmUgdGhyZWFkICh0aGUgaW50ZXJydXB0Cj4+IGhhbmRsZXIpIGFjY2Vzc2VzIGl0LiBOb3cgeW91
IGhhdmUgYW5vdGhlciB0aHJlYWQgdGhhdCBjYW4gcmVtb3ZlCj4+IGVudHJpZXMsIHNvIHlvdSBu
ZWVkIHRvIHByb3RlY3QgaXQgd2l0aCBhIGxvY2suIElmIHlvdSBhcmUgaGFuZGxpbmcKPj4gcmV0
cnkgZmF1bHRzLCB5b3Uga25vdyB0aGF0IHRoZSBpbnRlcnJ1cHQgaGFuZGxlciBpcyByZWFsbHkg
YSB3b3JrZXIKPj4gdGhyZWFkLCBzbyB5b3UgY2FuIHVzZSBhIG11dGV4IG9yIGEgc3Bpbi1sb2Nr
LCBidXQgaXQgZG9lc24ndCBuZWVkIHRvIGJlCj4+IGludGVycnVwdC1zYWZlLgo+Cj4gSSBkb24n
dCB0aGluayB5b3UgbmVlZCBhIGxvY2sgYXQgYWxsLgo+Cj4gSnVzdCB1c2luZyBjbXB4Y2hnKCkg
dG8gdXBkYXRlIHRoZSBrZXkgc2hvdWxkIGRvIGl0Lgo+Cj4gU29tZXRoaW5nIGxpa2UgdGhpczoK
Pgo+IMKgwqDCoMKgwqDCoMKgIGhhc2ggPSBoYXNoXzY0KGtleSwgQU1ER1BVX0dNQ19GQVVMVF9I
QVNIX09SREVSKTsKPiDCoMKgwqDCoMKgwqDCoCBmYXVsdCA9ICZnbWMtPmZhdWx0X3JpbmdbZ21j
LT5mYXVsdF9oYXNoW2hhc2hdLmlkeF07Cj4gwqDCoMKgwqDCoMKgwqAgd2hpbGUgKGZhdWx0LT50
aW1lc3RhbXAgPj0gc3RhbXApIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWlu
dDY0X3QgdG1wOwo+Cj4gwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIGNtcHhjaGcoJmZhdWx0
LT5rZXksIGtleSwgMCk7CgpHb29kIGlkZWEuIFRoZW4gd2Ugc2hvdWxkIHByb2JhYmx5IHVzZSBS
RUFEX09OQ0UgYW5kIFdSSVRFX09OQ0UgdG8gCmFjY2VzcyBmYXVsdC0+a2V5IGluIG90aGVyIHBs
YWNlcy4KClJlZ2FyZHMsCiDCoCBGZWxpeAoKCj4KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdG1wID0gZmF1bHQtPnRpbWVzdGFtcDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZmF1bHQgPSAmZ21jLT5mYXVsdF9yaW5nW2ZhdWx0LT5uZXh0XTsKPgo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBDaGVjayBpZiB0aGUgZW50cnkgd2FzIHJldXNlZCAq
Lwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZmF1bHQtPnRpbWVzdGFtcCA+
PSB0bXApCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBi
cmVhazsKPiDCoMKgwqDCoMKgwqDCoCB9Cj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPgo+Pgo+
PiBSZWdhcmRzLAo+PiDCoMKgIEZlbGl4Cj4+Cj4+Cj4+PiArwqDCoMKgIGZhdWx0LT50aW1lc3Rh
bXAgPSAwOwo+Pj4gK30KPj4+ICsKPj4+IMKgIGludCBhbWRncHVfZ21jX3Jhc19sYXRlX2luaXQo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+PiDCoCB7Cj4+PiDCoMKgwqDCoMKgIGludCBy
Owo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMu
aCAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCj4+PiBpbmRl
eCA5ZDExYzAyYTM5MzguLjQ5OGE3YTBkNWE5ZSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaAo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dtYy5oCj4+PiBAQCAtMzE4LDYgKzMxOCw4IEBAIHZvaWQgYW1kZ3B1
X2dtY19hZ3BfbG9jYXRpb24oc3RydWN0IAo+Pj4gYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2dtYyAqbWMp
Owo+Pj4gwqAgYm9vbCBhbWRncHVfZ21jX2ZpbHRlcl9mYXVsdHMoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHVpbnQ2NF90IAo+Pj4gYWRkciwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHVpbnQxNl90IHBhc2lkLCB1aW50NjRfdCB0aW1lc3RhbXApOwo+Pj4g
K3ZvaWQgYW1kZ3B1X2dtY19maWx0ZXJfZmF1bHRzX3JlbW92ZShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgCj4+PiB1aW50NjRfdCBhZGRyLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdWludDE2X3QgcGFzaWQpOwo+Pj4gwqAgaW50IGFtZGdwdV9nbWNf
cmFzX2xhdGVfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Cj4+PiDCoCB2b2lkIGFt
ZGdwdV9nbWNfcmFzX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwo+Pj4gwqAgaW50
IGFtZGdwdV9nbWNfYWxsb2NhdGVfdm1faW52X2VuZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dik7Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+
IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+
IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFt
ZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q2ZlbGl4Lmt1ZWhsaW5nJTQwYW1kLmNvbSU3QzdkMTk4
NzAwMTRmZjQwYjZkODBiMDhkOTA0OWFlOGEwJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0
ZTE4M2QlN0MwJTdDMCU3QzYzNzU0NTg4NTY0MjM1NzU5MyU3Q1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENK
WFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1iMExuTzlTUVBnWXNrSVJIMHZDaktlYnZoJTJG
WXpGZmlkUm5lMTVxMldJWHclM0QmYW1wO3Jlc2VydmVkPTAgCj4+Cj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
