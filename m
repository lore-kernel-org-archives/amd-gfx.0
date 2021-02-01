Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136D3C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C749964DE3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C749964DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F1A86E118;
	Mon,  1 Feb 2021 15:14:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1EB86E118
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 15:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3OL/VLNKZU1nY+ecMqXFqv2X17RN53Y99ntOynNfa1OwRPe6Rt6TUfHXPoPY8GpnYFClgjYD6fQn2ZdiXPjvBPHC0vFnDE13LpQEnjthBoy5srFmiBPAXyhESMd+XRNG9vlXDoxMLheZtoeNMwy8AtmNgSfS79CAuFu+1Dxi0Lw6OUapChA5aTPk0f01pUS5l6Ww2YOGgVZDs2eHQ3BxXeukYFX3Do2H3yHl/jvjzVJAwhAW+J02SyPg0wKtN5dQNf1csikRApE+AuMdRLrM2pW7SfKVR8A4cbdI/EnyjDbyuCVUyrHDQRVpJB4jfjOPD7AH8R2iVU3CyxuRfMDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+xRho7hWoMxXSkelSxQ/xAi4C0KrXmM00SAQsWO+R4=;
 b=P+ZCJfgI/Scp50IvzmpPE2wXlO6DBb+ulBId2VEtdVsbNidPsa1bgVmP811zxB6O2I0sDBi8al5XfqBDekhV62SfZxuMzX3SAP6P5TKoGWlwXb1dCd7wRj2Q7U1DDd6KMQb11M2+wF7luf9EYeijx13un2i8pz7dBMYSFQyqPJ79j6+d7vgwNruxJ8oIyT3nf2fgxIP0Pvjt0s6ajgrfg66wC1M4ItBkNyd0NLGsEKvpAtZENNfQ6h8WY4UxLUlRVoTiKL9KKAijmFeuuKsN1MSV7ePIbGfIt3mBi2jD6Nic2K+DmGo/ZSlpxwy9UdAMqOLgs38fNOPx8f8muzrmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+xRho7hWoMxXSkelSxQ/xAi4C0KrXmM00SAQsWO+R4=;
 b=zybjjHOGsPy8aUngCUg/7AvghLp3kWkMNxrJdNmmDCMljO9NEf0wuwpswvcPPzPFsL4XoK3qvGXSzII4Otz510jvO/mqogKnUc5rWaiUcYrvc5aRpVNhVeDtGO8JRNh3XVODYhImr3d37NWygTQRK+zbmFV4DlzJeTGa3tVZV7g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Mon, 1 Feb
 2021 15:13:59 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::dd41:21fb:f94f:eb03]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::dd41:21fb:f94f:eb03%3]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 15:13:59 +0000
Subject: Re: [PATCH] drm/amdgpu: enable freesync for A+A configs
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20210201143408.81475-1-christian.koenig@amd.com>
 <2226fb7c-97e5-ba63-041d-219902e56dbe@amd.com>
 <7c3deeb7-8dfd-5a04-297f-292c4d1ded79@gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <101a7093-8dd0-80bf-9f31-79d08af809d7@amd.com>
Date: Mon, 1 Feb 2021 20:43:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <7c3deeb7-8dfd-5a04-297f-292c4d1ded79@gmail.com>
Content-Language: en-US
X-Originating-IP: [106.51.20.251]
X-ClientProxiedBy: MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::29) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.68.111] (106.51.20.251) by
 MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Mon, 1 Feb 2021 15:13:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da357b19-1a5b-4428-bd6c-08d8c6c4000c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB41297BE8EE642C66E7E932C1F2B69@BY5PR12MB4129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnIxFoat6pxpeA1ujrEldl5NseyRQXgqdojgD4S/aIgi1P3QjVOwg+TCiU57FaYM6GQDGEK0n+jjLg1W9TV0utTjqkL/iHJa5WOsfjrwIN9okuNYqoNhQQsophgCH8392nfaKX7ydBRUzRSRGtvIeOu8hUhBm9uOO2a79Co57vCYjF+sSZmSl4uwA6yF20uaVJCXpz/QBqnQuCUDil2Fd/pzb2ppgYUB+u5eHZ4grN/yirMapYnNbozZu92SoDzxHpmVkb8h8l6CLX8FzRVWj5/WGfS/dlw9+JcAHi/kqb+O0DGV5b6HzDMC+QhoBL1LdscZzWXYugypEgvBiCT2UNB/mjexio7A9ryEI4S2IIphpPwYb9lM+6lvZoEaNG1dgh0XTLYzPK/ABdN3ywo5YXPhjfJsruKPLwPaxB8Vh6O3xsJWEchuqjgEqsC7IHK+oqEIR0VhnFczUxr/gSA4pF8ILeiaXI1jZ+r5PoH0YJ6eQLvIkvMKALQSnHZJFpVsMGcNY3Q04WrxDmaeqortp/FSMiwy71hzk6PvJ15+gSA7XrZQe7zKfgG2sTnTCvX8iKcMY6gq2+DPl3Fddv5xvAZEuu2aDk1fZalFX+9B+4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(2616005)(31696002)(6486002)(956004)(1006002)(8676002)(31686004)(66476007)(83380400001)(6666004)(86362001)(16576012)(2906002)(316002)(66946007)(66574015)(186003)(478600001)(66556008)(36756003)(53546011)(55236004)(26005)(44832011)(5660300002)(16526019)(52116002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UWovS3Mrc1NWQnZwaTU5MFFRRjVxQlZQMk5iSGNuTTA1SWg5Snc1TjIycnlC?=
 =?utf-8?B?Tk9LYzJsYkRUWGJ0dnhHeWdaUVduUVVYbXJnbFBOdU5RTnJTT0RQemQ5N2Nm?=
 =?utf-8?B?WG9URkFmWkxUTWt0eGVqVnJEazNCdWYyTVhlaG1BYzVXOTRxNlhNUkZycE5y?=
 =?utf-8?B?Y3BxM2F1TFJVdGdMbml6cmFGRzFEbjlJanpjV1NtTHVsS1ZNWUZjKy9SV0xZ?=
 =?utf-8?B?UWY4RzBPNURvY1lWYjhLN0pXRUpoQklIRkNQYkVmRGswOExnVnZtZ0U2SnNS?=
 =?utf-8?B?eDFTTXlmYWJGT1RkYWZ4WVV1dWRvTTV2UGN3R0pYTmptcDdYRHZWemxNTWVs?=
 =?utf-8?B?ODhMMkJvOTFVazdpOURleVpRY3Q3SUNmSk5UUHVYajhvSWdudUtMVCt3WWZa?=
 =?utf-8?B?a2tJb09TNzIxdmtUaTAyRzBqVTNqSktCY2gvMlZVTGpXRjJKQkFsWHdYalRy?=
 =?utf-8?B?RlJxUStnbWFxbDJtMnZ6Y0dKd2RaT2JMY29CTklWY1daOEhrdENMT1I2U2dD?=
 =?utf-8?B?WjJVNnBEYnk4VnJvS01LTHNkYmJ6VS9jWGkwQ3AycDBEenVsR0NYM1RFMjNZ?=
 =?utf-8?B?UlVTTmlDcUVVbktMcC9NSjFvM2x0VkQvTWJaMTc0dzRBM2xxb25XUkxEc2du?=
 =?utf-8?B?eFk3WWRpYVFGdklyRzZtRmtxTnEzOGIyTVNzUmx1UC93VFFCOVVpRGNYdUh3?=
 =?utf-8?B?blREcEJicUJTa2tieng2RlBhUU9XSzdtMDBQbEpvUXVCaFMwZ1EvK3pCamlO?=
 =?utf-8?B?VzJSeXh3Y05KVVlJTGdOdzliamVOWUZGdDFJOGFhaWNJbWExSHFHUllHR2U1?=
 =?utf-8?B?WllONnlPMnZ6OCtPS2MvbHZQNmJxNVpVTHptdkRKd3ZVVXp4aWIvc2pUcVJN?=
 =?utf-8?B?OGNlZXdEY3Y5Yy9uZzVhNE81NStpSVhkR3IxSnhOaEI1MHRZYVArSFlkYWdl?=
 =?utf-8?B?QTdhTlJGTHhId2I5VGFHQURkczFxYnlpNmdGTjF4eDJ0V3NXNmRYMHVoUWxZ?=
 =?utf-8?B?MTlVRkVHb3NqaVlCQytMMEdzWHZNNjI1VEg3MVFzeUtDa29KdG1pS2o0RVZV?=
 =?utf-8?B?YzM3bjNiRzdhWEp6TmxUakNpT3F5OWJWWFo1MmpiSzJWL3plVWFhNHd0VktB?=
 =?utf-8?B?Zm9BNytPYjZKZ25Zb0hRQ3lvRjFGZDhvaWRJbVoyQVVDN1dnM1R5azZhLzhH?=
 =?utf-8?B?cWdyL1E0d05RR1NJRWJ4ZlhrMTUyQnRpUU1iWUFDby9aUUdEcXdsbnFTRTU4?=
 =?utf-8?B?SGptMlFma3hyZHJzL1RPUnN3bGdXTDFDUkxNZld5NVR2MXFDTVlmNzArMEhY?=
 =?utf-8?B?UE5HTjJLNHg0VDRyQlJhQzQrS2pGYktUcGM3NnNJZnhaTlVESm4wZXpXYTl0?=
 =?utf-8?B?TDM3dWlnR2k1SVpmemdUdGwxY2NnQ2VwaEIvYVVCUzRJSm9UdEN2dFczVzNH?=
 =?utf-8?Q?ixm1FM+H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da357b19-1a5b-4428-bd6c-08d8c6c4000c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 15:13:59.1128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxoRs1gqc1ficQvf5itIUJM06Pwmd8tIssg6265J3bzpUaGxAbGnipkv3XnSkdkkWWTE4ueryE0Pgn64OBE8hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129
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

Ck9uIDAxLzAyLzIxIDg6MzkgcG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMDEuMDIu
MjEgdW0gMTY6MDYgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+IEhlbGxvIENocmlzdGlhbiwK
Pj4KPj4gT24gMDEvMDIvMjEgODowNCBwbSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IFNv
bWUgbmV3ZXIgQVBVcyBjYW4gc2Nhbm91dCBkaXJlY3RseSBmcm9tIEdUVCwgdGhhdCBzYXZlcyB1
cyBmcm9tCj4+PiBhbGxvY2F0aW5nIGFub3RoZXIgYm91bmNlIGJ1ZmZlciBpbiBWUkFNIGFuZCBl
bmFibGVzIGZyZWVzeW5jIGluIHN1Y2gKPj4+IGNvbmZpZ3VyYXRpb25zLgo+PiBTaGFsbCB3ZSBh
ZGQgc29tZSBtb3JlIGRldGFpbHMgYWJvdXQgaG93IHRoaXMgcGF0Y2ggaGVscHMgd2l0aCBWUlIs
IGxpa2UgIldpdGhvdXQgdGhpcyBwYXRjaCwgaXQgd29uJ3QgYmUgcG9zc2libGUgZm9yIHRoZSBJ
R1BVIHRvIGZsaXAgYnVmZmVycyB3aGljaCBhcmUgY29tcG9zZWQgb24gYW4gZXh0ZXJuYWwgR1BV
IiBvciBzb21ldGhpbmcgaW4gdGhvc2UgbGluZXMgPwo+IEhvdyBhYm91dDoKPgo+ICJXaXRob3V0
IHRoaXMgcGF0Y2ggY3JlYXRpbmcgYSBmcmFtZWJ1ZmZlciBmcm9tIHRoZSBpbXBvcnRlZCBCTyB3
aWxsIAo+IGZhaWwgYW5kIHVzZXJzcGFjZSB3aWxsIGZhbGwgYmFjayB0byBhIGNvcHkiLgoKWWVw
LCBsb29rcyBnb29kIGVub3VnaC4gVGhlcmUgaXMganVzdCBvbmUgbW9yZSB0aW55IGNvbW1lbnQg
YmVsb3csIHBsZWFzZSBjaGVjayB0aGF0IG91dCB0b28uCgo+Cj4gVGhhbmtzLAo+IENocmlzdGlh
bi4KPgo+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgo+Pj4gLS0tCj4+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kaXNwbGF5LmMgfCA4ICsrKysrKy0tCj4+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9vYmplY3QuYyAgfCAyICstCj4+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rpc3BsYXkuYwo+Pj4gaW5kZXggYTYzODcwOWU5YzkyLi44MjNiYzI1ZDg3ZGUg
MTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxh
eS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5j
Cj4+PiBAQCAtOTMwLDggKzkzMCwxMCBAQCBhbWRncHVfZGlzcGxheV91c2VyX2ZyYW1lYnVmZmVy
X2NyZWF0ZShzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LAo+Pj4gICAJCQkJICAgICAgIHN0cnVjdCBk
cm1fZmlsZSAqZmlsZV9wcml2LAo+Pj4gICAJCQkJICAgICAgIGNvbnN0IHN0cnVjdCBkcm1fbW9k
ZV9mYl9jbWQyICptb2RlX2NtZCkKPj4+ICAgewo+Pj4gLQlzdHJ1Y3QgZHJtX2dlbV9vYmplY3Qg
Km9iajsKPj4+ICAgCXN0cnVjdCBhbWRncHVfZnJhbWVidWZmZXIgKmFtZGdwdV9mYjsKPj4+ICsJ
c3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmo7Cj4+PiArCXN0cnVjdCBhbWRncHVfYm8gKmJvOwo+
Pj4gKwl1aW50MzJfdCBkb21haW5zOwo+Pj4gICAJaW50IHJldDsKPj4+ICAgCj4+PiAgIAlvYmog
PSBkcm1fZ2VtX29iamVjdF9sb29rdXAoZmlsZV9wcml2LCBtb2RlX2NtZC0+aGFuZGxlc1swXSk7
Cj4+PiBAQCAtOTQyLDcgKzk0NCw5IEBAIGFtZGdwdV9kaXNwbGF5X3VzZXJfZnJhbWVidWZmZXJf
Y3JlYXRlKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCj4+PiAgIAl9Cj4+PiAgIAo+Pj4gICAJLyog
SGFuZGxlIGlzIGltcG9ydGVkIGRtYS1idWYsIHNvIGNhbm5vdCBiZSBtaWdyYXRlZCB0byBWUkFN
IGZvciBzY2Fub3V0ICovCj4+PiAtCWlmIChvYmotPmltcG9ydF9hdHRhY2gpIHsKPj4+ICsJYm8g
PSBnZW1fdG9fYW1kZ3B1X2JvKG9iaik7Cj4+IElzIGl0IHBvc3NpYmxlIHRoYXQgdGhlIGJvIGNh
biBiZSBOVUxMID8gSSBtZWFuIGRvIHdlIG5lZWQgYSBOVUxMIGNoZWNrIGhlcmUgPwoKVGhpcyBv
bmUgOikKCi0gU2hhc2hhbmsKCj4+PiArCWRvbWFpbnMgPSBhbWRncHVfZGlzcGxheV9zdXBwb3J0
ZWRfZG9tYWlucyhkcm1fdG9fYWRldihkZXYpLCBiby0+ZmxhZ3MpOwo+Pj4gKwlpZiAob2JqLT5p
bXBvcnRfYXR0YWNoICYmICEoZG9tYWlucyAmIEFNREdQVV9HRU1fRE9NQUlOX0dUVCkpIHsKPj4+
ICAgCQlkcm1fZGJnX2ttcyhkZXYsICJDYW5ub3QgY3JlYXRlIGZyYW1lYnVmZmVyIGZyb20gaW1w
b3J0ZWQgZG1hX2J1ZlxuIik7Cj4+PiAgIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7Cj4+PiAg
IAl9Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29i
amVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4+PiBp
bmRleCA1Njg1NGEzZWUxOWMuLjBiZDIyZWQxZGFjZiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4+PiBAQCAtOTAwLDcgKzkwMCw3IEBAIGlu
dCBhbWRncHVfYm9fcGluX3Jlc3RyaWN0ZWQoc3RydWN0IGFtZGdwdV9ibyAqYm8sIHUzMiBkb21h
aW4sCj4+PiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4+PiAgIAo+Pj4gICAJLyogQSBzaGFyZWQgYm8g
Y2Fubm90IGJlIG1pZ3JhdGVkIHRvIFZSQU0gKi8KPj4+IC0JaWYgKGJvLT5wcmltZV9zaGFyZWRf
Y291bnQpIHsKPj4+ICsJaWYgKGJvLT5wcmltZV9zaGFyZWRfY291bnQgfHwgYm8tPnRiby5iYXNl
LmltcG9ydF9hdHRhY2gpIHsKPj4gV2l0aCB0aGUgYWJvdmUgY29uY2VybnMgYWRkcmVzc2VkIChv
ciByZWFzb25lZCA6KSksIHBsZWFzZSBmZWVsIGZyZWUgdG8gdXNlOgo+Pgo+PiBSZXZpZXdlZC1i
eTogU2hhc2hhbmsgU2hhcm1hIDxzaGFzaGFuay5zaGFybWFAYW1kLmNvbT4KPj4KPj4gLSBTaGFz
aGFuawo+Pgo+Pj4gICAJCWlmIChkb21haW4gJiBBTURHUFVfR0VNX0RPTUFJTl9HVFQpCj4+PiAg
IAkJCWRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsKPj4+ICAgCQllbHNlCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
