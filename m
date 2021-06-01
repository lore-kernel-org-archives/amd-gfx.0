Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A19C4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 10:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D6D61396
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 10:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D6D61396
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 256676E9DB;
	Tue,  1 Jun 2021 10:15:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 656C06E9DB
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 10:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ai56m389GOikLKCdt4cbThXOA9MrakB9HhZpEoYJn0zJa5KjNCu4L6Dd3HhSoiSjNVdPtHjFfJyPhwHeNbQuADlS5HQ/nccw1X2r8EUTRETXocPPD8ukIDmuf7wGfb0+AVvR6d819Yfwm7/TfVdtSN7i9/vi5iVHtrrS+Wqa7+TozlWuWjG75JjXZ0GCEnu5dz6qju2yq5CuUrH3oPHn6yDg68Ll1lVwr5+zjtMHwa9+FT868CMcoD0puv/hPg9HS9b1GLbJn2kThRb1qcVNr9YzqSBeFz6sFi3fkBIchXMnpLK8rA8wM86z7+Ho1vSO1QEhpgAJklpeICPXuSZCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryXK3iQdmhZdsRSw5icJD/gJteMAdA8LhpBsTLZ7ruk=;
 b=ltquNdxv+0AUR6Um4ueECiYHDg7kByTLfor03TAgX7mrpmUUkBAXwm+/3P3XKLWi24wz+FjI69qUSOfu7+zsT6qotx2aE45cZUsE4Ti6lUfQBhNfJxiGTGzx+9LvZgVgNzpDBMRIO7kafJyh2vgMPyiMAaKQaUsDDM5EDr+kxgcmDdvGHhBRJqMRuXpUJDo25G1XEzBv+2zuMmVCfhEA3LE8wMhh2o5bHADgrwBSd696urIvcs00KJ2ne5yFU9r/slkfhWHby5eqV3Hh3/kcmFIz+wh7JJh+nbcNhkqTZPt1U+JBtkKW5ynpLWbCoebGWx9MYt10+NCKWSnPDF3i7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryXK3iQdmhZdsRSw5icJD/gJteMAdA8LhpBsTLZ7ruk=;
 b=ESvkSFIIw0syQieDSwTi/O7XjkIRKB2zBRQWd1tb7xBPuurcJB4Usg6aW1SiAKc81aES3g0lNjSuY3Eyfde7A2FsnOUxgGLdxjgvAUxzeMdfmF4cXAztEFQ/5upqLaaMhU9KY25Br1CllgMBpalGQaOgX7gtKO8Aq1n8bOuAVl0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3934.namprd12.prod.outlook.com (2603:10b6:208:167::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Tue, 1 Jun
 2021 10:15:46 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 10:15:46 +0000
Subject: Re: [PATCH 1/1] drm/amd/display: fix coding style
To: Nirmoy Das <nirmoy.das@amd.com>, alexander.deucher@amd.com
References: <20210601101331.31846-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <84710d8c-88af-5dee-2714-7c3420e3ae17@amd.com>
Date: Tue, 1 Jun 2021 12:15:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210601101331.31846-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:5ee0:b6d9:de45:97bd]
X-ClientProxiedBy: AM0PR02CA0115.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::12) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:5ee0:b6d9:de45:97bd]
 (2a02:908:1252:fb60:5ee0:b6d9:de45:97bd) by
 AM0PR02CA0115.eurprd02.prod.outlook.com (2603:10a6:20b:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 10:15:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efa2bddc-8679-40fb-053d-08d924e637d2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3934:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39340B070B31156E686FF89F833E9@MN2PR12MB3934.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rS/V5hdDpRs7Rynvs8Lhto7GEU3gT5/2bT46Xmu3ZTZg8Nyj4c8LeYdZP/eF4XDWgnmWz1OpOsvC7sCMGGOEzC4JMpAnSmCGY8zqj/QSGdLpx+/CU9I+pHL46VzYhI/HQRU37Z1F1yc1S6UKhDnrR4LsAN5U01FdGDaTDxuOTezbKC1W0wMdcw4zrhYPnEtbHLevRC/racLfhuWnage7lmD4uQEJwlruR32Is/G2iSV8Z6ZOQ8SdzwUMUoSpRlOOMNOxGB0oaA87OCg1ZqgFsnYNBH2GBeS0FRxwCx14kBa8WhIn6nzPCHH0DaLzo7j2U48phrcDp32wQYCuIW8YLHCokIvCgerQXbV/7SKojxo5Qgiht+qCA7kd4LZwEJ0npzy7YQZQ6UzAVNA5/GTWVZYBm4UNzLRHGAiFN1IxWLlp+USVud8+1A58LnhjE12qTa/iFtkX+xAr8b8zgWtRiJjkx3RPzNt4r8DmUxFODf39CkFY4Hx5tuJs+Lur5NRt8cHDiIdTikLBnWWGhjyzGsY3Kew4TrRyX9dYEgNvTW2N3RXHNrvyn+WYb6lhutPv2mJZ2HIYQcop6/GR6Bw6mw3L2ZeFJry0fCkP9aGmwOLHSt/FCFCuOO7FNNWLxpi3jU9wIqmJ5G4az0z44V2hRRMHdShFq+badAmgH6DdwiJLPSRxz8dtZ8mpcYL0nudA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39850400004)(346002)(66946007)(6486002)(66476007)(5660300002)(6666004)(316002)(31686004)(31696002)(66556008)(86362001)(36756003)(2616005)(38100700002)(4326008)(83380400001)(8936002)(2906002)(478600001)(6636002)(8676002)(186003)(16526019)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bDd0WFVVUXgyUDNJVCtacDROVEdrbnBDcUFqL093Rlp2Vk8wUm42MWVDKzhE?=
 =?utf-8?B?VXJkVVU5bFY2SXBaVFZ3L25JT29iQ0VNb09NN2VCMXNpbWV3Nmo4eWxoOXM0?=
 =?utf-8?B?QW5oSExsd0w0M08yMEJmTEVUWFNPcjRRYWhUVnNSRlhGMWJBNzUrY0dIcFA2?=
 =?utf-8?B?c1gybGphT290VkdSb1BWWS96T0s4UGlYQi9GWHcxNnhEbGt6U1dTVWZZR28r?=
 =?utf-8?B?eE9tWGhPbXBka0t2RkYxdlVidlFWU282VkVNWHFnWVVOT1NSdkFHYkY4S3Iy?=
 =?utf-8?B?b0lQbDhRemxzd3lkcGlRdXJlM0dKSXo3ZkViUndKRVp4bEZHdVlKSjRGQjFI?=
 =?utf-8?B?NDBQZXNwNmJzTVR6aVUvV1orUWVkSmJzUWx0akNJak5Tb2RKV0JqQTJmQWlB?=
 =?utf-8?B?N3B5TnhreWE4bGFsKy8rL3pSSUZaY01tdU93UEZ3SEZBM1lrSXNQcXI4SWZ4?=
 =?utf-8?B?UmdFK1hpWER4ZlZQTzc0TjN5SlVDY0hTRld3cGNwdVVCMUdWSnZpOVBCdXE5?=
 =?utf-8?B?TGlncDd1dGpSZndBcHh1UmxKR05EYU5EZUNySlcwQUpib0syNU5ya29kYVdE?=
 =?utf-8?B?R3ZkeVkrUTNxenloMXM5Q0tBUHBJUXRJRGg5c0NPMzFDMWhjblJJd2Z5OE8z?=
 =?utf-8?B?WXRHaXNpQktQdzN4YmdQYXFmYkkzT0drakM0bCtSN0FtYzBQSnZEaTBrNWVi?=
 =?utf-8?B?c0p2Z3BlbTRkNVBodTB3MHUxUno0cEJGVkFQcUZ1RjJ5RUJoUFd1aW80Tllx?=
 =?utf-8?B?NmFYdGJCQUp1a3pCUndGU1dob21sS0xwNTJPaXBUdEt1SFFTU2NvWVBCTnBQ?=
 =?utf-8?B?dS9wZkExNHRRMWhPMWdMM3E5aWFZelJlTXI3RjFzWlhXaUsyQnlLSjNLQmpi?=
 =?utf-8?B?bmVkN1doVnVPSHg0VG9taDFqdDMrY2xaZmg5QWxiVUM0VGdFMXBoRmZkYXhu?=
 =?utf-8?B?cVIyT2VsTi9sWE5mTnlVY0luajhndWVNSlNuYUlrdkVjd0dSZDJkTEVkNVI3?=
 =?utf-8?B?TC9teENyQktMbGR6NkxmTWdMUEVhQ0x3ZmN0MEErN2trZzc5N0Flbk9Zcy9w?=
 =?utf-8?B?Nkg1TjhUYlZZL1gwMStza1V6K3F6bldodkE4b1p5Y20zWHhMaFgrRmtlWGlw?=
 =?utf-8?B?a2plM1lFK1pBa3hOUGhjSm9JKzgwTFoySmtzQ3lBOEYyR3J1dmxBOWJuMWVB?=
 =?utf-8?B?WmFnVWdmVm03TVEyeWZZUG5vZlNhRHZwaWZvRUxob0I3cSt6ZCtUWjJEQTV3?=
 =?utf-8?B?aDJBVzVhaWlJY0ZQMHNIYzI4UHV3RStRaTFYdEhSenZrSElJRDRScW5Tcmkz?=
 =?utf-8?B?OTZtRWpWYUNTajdkMEhiYW1mNlgvdms4aXBwNWtiVy9lOFlLeVJhQzVhUE96?=
 =?utf-8?B?dGdJdndwZi9JM2VaQXF4NmVLZlo4TjZkeFBhbk1IY1hRY1IwYkxRaDMrYnU4?=
 =?utf-8?B?UHJQZTlUQVhvRGVmK0xsbEZ5L3FQSEp2MEo2M2gyWDBSTk9TMm1wa1RISWxQ?=
 =?utf-8?B?YVZma1pkWkNXaVpuVXJRZExYc1pPcm84ZEJicERkMmNaNjdFejk0ZDdWYmxC?=
 =?utf-8?B?K2djM1RGclFoKzNGc1ZoeFJkN0FJOU40WEVWc0V6VTFKUUFFNGNJU3N4MnR6?=
 =?utf-8?B?Z2JaTWRjamExL2R2UEsrRUFVVWxJRXhjbEJOVVp3aE5yTjJST3NYanVSRjBE?=
 =?utf-8?B?N3I1ZmRQUVd6TGY0TFVoWlZ6R1JXQ0xBV3pRMU9XV2pBK0pGMXdxVGIvdzJH?=
 =?utf-8?B?dzNaUVFVRUJpeGd3SXNHQ2dqM0RrRkZlemt6MkIxZHp6bG9paGZPRXg1RXlT?=
 =?utf-8?B?bFUrWnNIdmdEUWM1RWFPQUxkelF6TGt2V2JQK2hrWXRNQjB1UzVGUllVOXdL?=
 =?utf-8?Q?9Mj+Nc29bC10A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa2bddc-8679-40fb-053d-08d924e637d2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 10:15:46.2006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlIFU+ksPkAYjZsLN4D8XVis7o3MeeM7V9Za0H9ZBCPaWa6FZBKl82rRPHA8/ZmB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3934
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

QW0gMDEuMDYuMjEgdW0gMTI6MTMgc2NocmllYiBOaXJtb3kgRGFzOgo+IEZpeGVzOiA2MGQxOThj
YTY2ZWNmNzc4ICgiZHJtL2FtZC9kaXNwbGF5OiBXQVJOX09OIGNsZWFudXBzIikKPgo+IFNpZ25l
ZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+IEhpIEFs
ZXgsCj4KPiBDYW4geW91IHBsZWFzZSBzcXVhc2ggdGhpcyB3aXRoIHRoZSAiRml4ZXMiIHBhdGNo
PwoKV2UgY291bGQga2VlcCB0aGF0IHNlcGFyYXRlZCBhcyB3ZWxsLCBubyBiaWcgZGVhbC4KCkNo
cmlzdGlhbi4KCj4KPiBUaGFua3MsCj4gTmlybW95Cj4KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAzICstLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gaW5kZXggMDliYmVjNGRhYjdj
Li41NmFiYzI3Yjc4ZjcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiBAQCAtMzE1LDkgKzMxNSw4IEBAIGdldF9jcnRjX2J5
X290Z19pbnN0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCXN0cnVjdCBkcm1fY3J0
YyAqY3J0YzsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2NydGMgKmFtZGdwdV9jcnRjOwo+Cj4gLQlpZiAo
V0FSTl9PTihvdGdfaW5zdCA9PSAtMSkpIHsKPiArCWlmIChXQVJOX09OKG90Z19pbnN0ID09IC0x
KSkKPiAgIAkJcmV0dXJuIGFkZXYtPm1vZGVfaW5mby5jcnRjc1swXTsKPiAtCX0KPgo+ICAgCWxp
c3RfZm9yX2VhY2hfZW50cnkoY3J0YywgJmRldi0+bW9kZV9jb25maWcuY3J0Y19saXN0LCBoZWFk
KSB7Cj4gICAJCWFtZGdwdV9jcnRjID0gdG9fYW1kZ3B1X2NydGMoY3J0Yyk7Cj4gLS0KPiAyLjMx
LjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
