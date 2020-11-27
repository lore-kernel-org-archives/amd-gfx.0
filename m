Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0D5C2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 04:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6047922228
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 04:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ttGy9GyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6047922228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF506E89C;
	Fri, 27 Nov 2020 04:24:11 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690047.outbound.protection.outlook.com [40.107.69.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0CB46E89C
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 04:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Frwf3Ls3argCVPRbEbmBLy44JLU66vYJSk4ZOD8l1yb948Yg7C23c+H4C0FJ6FRJqu9i1mpA44UeqLgkemdXz/NRVldt/d3QJOxOsa66/syDwL6jUlqw06PWBCxnGM1DaeaQ/35Xe08lbZFGmBiLwLgo4m4Rv/y847K0i1CLN2GE2HhgdAb3bZ5nfYRWHf94kDDcd1sCHZ5kV7stBsazlQhpxEt8vLOg3B/PZouWZF/RPF4NY2b91JEIGd8tXKfTduz7Ul5niWNo4g+FXRiZ89ubJ0QIdbnPQ1Ui+R3EVSCvVANoEvkSgHS040OSgRElZF1mBIz7KawPRFib8gv1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KR64ZORoUcOwJv1EeLXJU1n24E2f2rVqRLK93dR+jeA=;
 b=klaj6bOzfJ43LkGoNVz/l75cstRQFAV+Y+t3Lan6FCckRSHgs6089B1ZHOoRrSrN3dZTGNiqs/K6z/5SxA6rE8u+q8XLu5iO/63HnsHkghYvPkTtl1Vt7eYKD/iUCqN0+GDphjCmArl9XZxgXSAkQ1URozDHYbH/Bo/oqVTiBJKP0cxjaI28rtYNsXPpS4XgMM6gZT3zywuua7yOrHRxMNxoLAi1/jeiaGkACW38/DLBDHQqUU+ta/A0nAXMZ55jBKU5IZfTh2soqa0h9V0ph6CCtjzvSOv+sCITA+Hcs+IUXCKnZeiOXeZwbod943tGLtaeVWtCn+/im1IZWaWFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KR64ZORoUcOwJv1EeLXJU1n24E2f2rVqRLK93dR+jeA=;
 b=ttGy9GyLOJz8XPeGa+RFclJ1rqXs5XNmWjw+/Nq1ZXFLFoT5AjDuWm2GU6dC9buJYPsL2KFFUAHJBTtFShzIJdBWprLHXrpUNMf2QRotQdF6nzvHNEaHPYAxHGX5qcJziAvd6AKDRI1SFyxg5gdFgLiD1mwnWdRPe+1vR6sy5uY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3117.namprd12.prod.outlook.com (2603:10b6:208:d1::22)
 by MN2PR12MB3630.namprd12.prod.outlook.com (2603:10b6:208:cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Fri, 27 Nov
 2020 04:24:05 +0000
Received: from MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::7ccd:6ebf:40e7:7039]) by MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::7ccd:6ebf:40e7:7039%7]) with mapi id 15.20.3589.030; Fri, 27 Nov 2020
 04:24:05 +0000
Subject: Re: [PATCH] drm/amd/display: Extends Tune min clk for MPO for RV
From: Pratik Vishwakarma <pvishwak@amd.com>
To: Harry Wentland <harry.wentland@amd.com>,
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 nicholas.kazlauskas@amd.com, hersenxs.wu@amd.com,
 amd-gfx@lists.freedesktop.org, roman.li@amd.com
References: <20201124155508.2096060-1-Pratik.Vishwakarma@amd.com>
 <393ee532-7690-ce76-4b36-75a65656173b@amd.com>
 <858f7cc8-77c0-9955-d164-e644b84cfb5f@amd.com>
Message-ID: <5f5c4a53-5f08-0879-cb33-da7b86c680d5@amd.com>
Date: Fri, 27 Nov 2020 09:53:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <858f7cc8-77c0-9955-d164-e644b84cfb5f@amd.com>
Content-Language: en-US
X-Originating-IP: [122.181.197.12]
X-ClientProxiedBy: MA1PR01CA0137.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::31) To MN2PR12MB3117.namprd12.prod.outlook.com
 (2603:10b6:208:d1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.6] (122.181.197.12) by
 MA1PR01CA0137.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 04:24:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 114d6122-44e6-4b9b-18c9-08d8928c46b5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3630:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36309C7945B82B436384D86C80F80@MN2PR12MB3630.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7dumPC3QdnMcH3V4Hk9uu5g7ltTgqnYSoKOohQDhjYOSoV2sibDUi2uubfHjwGXv5tZjFEVOMOp98rzUeCUGOHRxqwefptTR4gqRMTWJ7idd8ffCgdfmvym+pzGIPg09knMAsIzI5NkSEa8ntra3XQOU4WfC4iSdBqvYYdF+0un14IovSY9a0oHnNjyDn2YXC3dEQvWoiSNTsDrHCjKflCHpFXw5yAKuAE3Tg2XbpoqiSdUZNJlcEyqgcQRl8FxAXL54xckm6BZ1+EM8nrlxYOxQM6avGsvVr5Ieuvct+czMsAWyvg7HeFv/Z0aGj+l2otSWMtBz3oie8T4qrUzSiXQDklK/CX6k5f3R3jAuTaijyw2vGR2MipsD+S6v5q3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3117.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(2906002)(53546011)(83380400001)(6486002)(5660300002)(31696002)(8676002)(52116002)(4001150100001)(31686004)(66946007)(2616005)(316002)(16576012)(956004)(8936002)(110136005)(66556008)(66476007)(26005)(6666004)(6636002)(16526019)(186003)(36756003)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N0Z1bDhFakNKZDZEOXZJS245RXRycTFVTTlWYVV6QVJRNlhTcEFJZ2IzWlpa?=
 =?utf-8?B?YVZkclVzTVZVbGRxWHllTURUOWgxWmFZdXc2aHdCTnJQTDhhcWdNc2xOVzZq?=
 =?utf-8?B?ZmNvL1o3MitKN1pZczhKQ0lxYTVRNGRWRmpsSGJ4ajVLMHNrNzdQOUVDTW41?=
 =?utf-8?B?ckttbkFKNHpUcFU1S1hNbWpldXJuNHAwVEZucjhIM1c3MFk2RVArUWM1eG5o?=
 =?utf-8?B?UkJCb0FGMVYzMTd6dmxQOGN3MmFlekdKS3pOeHV5dDM1RTA1RHFqSElvaFlE?=
 =?utf-8?B?blRlNEZ0bkdTdVVSMC9NRlBsK1p2SVRObFdoaUJVVVpHT3JMcDhLTHNFSTk2?=
 =?utf-8?B?alRnem82ZlRITU1od3JMbXhmQmhCNVRLVWYxS2hJcFZvSWJLSGZQaEh0NUts?=
 =?utf-8?B?ejhKMHBlVFZuSXYwa3NOY1pLd05jdU8vblhCdllpQXVkQ2g5bWVoTFFna2lP?=
 =?utf-8?B?VlNzTTkydmNOdytqcHVJa2tMaW9DS1pSaHEwNG1oYXlsVlF5MTNGenQ4U1hx?=
 =?utf-8?B?bWFWTUg3K2NCY21QUWc3b1hkZjhJRlVVdG9QRXQ2SE95ZEVUTE1TTnVjQmN1?=
 =?utf-8?B?K0RJL0FIMWdWYmtYNHdlU2ptZUErVVdDQzA4dG0zTHJSb2gvdS9aMjhsaU5Q?=
 =?utf-8?B?Y1hCRis4MWhBb2xMZFFJb2pRNzhEZ1RmQVdiaTlKa052ZUljMHRNM1BqT1RI?=
 =?utf-8?B?bjV2MXRwaHJRM0xKMjBrZmFoWi9DSmNVZVI5MlhGNVJyTElaRXdycDR1ZEk1?=
 =?utf-8?B?cTE5Nlc4N1d6dWdTUDd6SWpMNS9leEloU0UzcHpIRy9vYzFKY29lL3o3TDg4?=
 =?utf-8?B?T0R0Sno4aTMwQmJ0bCtjZzFaejgraXFqR3BXU2VqZjh5S0JMQ1ZaaS85Q3dn?=
 =?utf-8?B?MllFOHpBZ2dtUUFZRVQ0SFlZbFF4UlRIUWh2YWlIYllTKy9RejlaYXYrY0x4?=
 =?utf-8?B?MGp2Vm9lWCt6ZTJJd3doT2lrMUpvaW9uaHhiYjFteHpROHRCVUIxSnIxVTNT?=
 =?utf-8?B?dDRpQ2VkQkxCQ1p4OVZxRHJvdEJFTzNsVVRQNWF0UGp3VzRyNmQ5UGZEY3gv?=
 =?utf-8?B?M0JlRm00MHNXaHNXU1EycFRBOHdWZUhOUmNUYXVDaVNYTFlxaEplZkhTUE1J?=
 =?utf-8?B?QmNicHpBVGtMUHJyY0FlQ2tlL0lBQ3VRNll5NDkxR21jVjZGWkZieWZTL2J6?=
 =?utf-8?B?ald3dDREY3ZVTzZtazBmOVlGbEpPWUVCZVltbVUwaXMxYWE5TzNodWt0U3J0?=
 =?utf-8?B?UUM0eE5xdVB3Y043UEkrUTU3WDcvVmpKRzBkN0dLRldSbVV0UzVhZXhocHpG?=
 =?utf-8?Q?xCzCG9xrlEXUaQt7raU5/7n76hxepggerb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114d6122-44e6-4b9b-18c9-08d8928c46b5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3117.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 04:24:05.4843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H25GcJXo5FyPOKMcnSgHnPywCPNvqgYXiihOypLmvtemHuCc3AtuOV8QABei1uUi+3pP0TknWKenwRCXLMBWcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3630
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

RnJpZW5kbHkgcGluZy4KUGxlYXNlIGhlbHAgcmV2aWV3LgoKUmVnYXJkcwpQcmF0aWsKT24gMjUv
MTEvMjAgMTA6MDIgYW0sIFByYXRpayBWaXNod2FrYXJtYSB3cm90ZToKPiBPbiAyNS8xMS8yMCAx
OjM4IGFtLCBIYXJyeSBXZW50bGFuZCB3cm90ZToKPj4gT24gMjAyMC0xMS0yNCAxMDo1NSBhLm0u
LCBQcmF0aWsgVmlzaHdha2FybWEgd3JvdGU6Cj4+PiBbV2h5XQo+Pj4gQ2hhbmdlcyBpbiB2aWRl
byByZXNvbHV0aW9uIGR1cmluZyBwbGF5YmFjayBjYXVzZQo+Pj4gZGlzcGNsayB0byByYW1wIGhp
Z2hlciBidXQgc2V0cyBpbmNvbXBhdGlsZSBmY2xrCj4+PiBhbmQgZGNmY2xrIHZhbHVlcyBmb3Ig
TVBPLgo+Pj4KPj4+IFtIb3ddCj4+PiBDaGVjayBmb3IgTVBPIGFuZCBzZXQgcHJvcGVyIG1pbiBj
bGsgdmFsdWVzCj4+PiBmb3IgdGhpcyBjYXNlIGFsc28uIFRoaXMgd2FzIG1pc3NlZCBkdXJpbmcg
cHJldmlvdXMKPj4+IHBhdGNoLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFByYXRpayBWaXNod2Fr
YXJtYSA8UHJhdGlrLlZpc2h3YWthcm1hQGFtZC5jb20+Cj4+PiAtLS0KPj4+IMKgIC4uLi9kaXNw
bGF5L2RjL2Nsa19tZ3IvZGNuMTAvcnYxX2Nsa19tZ3IuY8KgwqDCoCB8IDE5IAo+Pj4gKysrKysr
KysrKysrKysrKy0tLQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCAKPj4+IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2Nsa19tZ3IvZGNuMTAvcnYxX2Nsa19tZ3IuYyAKPj4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nsa19tZ3IvZGNuMTAvcnYxX2Nsa19tZ3IuYwo+Pj4gaW5k
ZXggNzViODI0MGVkMDU5Li5lZDA4N2E5ZTczYmIgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2xrX21nci9kY24xMC9ydjFfY2xrX21nci5jCj4+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2xrX21nci9kY24xMC9ydjFfY2xrX21n
ci5jCj4+PiBAQCAtMjc1LDkgKzI3NSwyMiBAQCBzdGF0aWMgdm9pZCBydjFfdXBkYXRlX2Nsb2Nr
cyhzdHJ1Y3QgY2xrX21nciAKPj4+ICpjbGtfbWdyX2Jhc2UsCj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKHBwX3NtdS0+c2V0X2hhcmRfbWluX2ZjbGtfYnlfZnJlcSAmJgo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcF9zbXUtPnNldF9oYXJkX21pbl9kY2ZjbGtfYnlf
ZnJlcSAmJgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcF9zbXUtPnNl
dF9taW5fZGVlcF9zbGVlcF9kY2ZjbGspIHsKPj4+IC0gcHBfc211LT5zZXRfaGFyZF9taW5fZmNs
a19ieV9mcmVxKCZwcF9zbXUtPnBwX3NtdSwgCj4+PiBuZXdfY2xvY2tzLT5mY2xrX2toeiAvIDEw
MDApOwo+Pj4gLSBwcF9zbXUtPnNldF9oYXJkX21pbl9kY2ZjbGtfYnlfZnJlcSgmcHBfc211LT5w
cF9zbXUsIAo+Pj4gbmV3X2Nsb2Nrcy0+ZGNmY2xrX2toeiAvIDEwMDApOwo+Pj4gLSBwcF9zbXUt
PnNldF9taW5fZGVlcF9zbGVlcF9kY2ZjbGsoJnBwX3NtdS0+cHBfc211LCAKPj4+IChuZXdfY2xv
Y2tzLT5kY2ZjbGtfZGVlcF9zbGVlcF9raHogKyA5OTkpIC8gMTAwMCk7Cj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAvLyBPbmx5IGluY3JlYXNlIGNsb2NrcyB3aGVuIGRpc3BsYXkgaXMgYWN0
aXZlIGFuZCBNUE8gCj4+PiBpcyBlbmFibGVkCj4+Cj4+IFdoeSBkbyB3ZSB3YW50IHRvIG9ubHkg
ZG8gdGhpcyB3aGVuIE1QTyBpcyBlbmFibGVkPwo+Pgo+PiBIYXJyeQo+Cj4gSGkgSGFycnksCj4K
PiBXaGVuIE1QTyBpcyBlbmFibGVkIGFuZCBzeXN0ZW0gbW92ZXMgdG8gbG93ZXIgY2xvY2sgc3Rh
dGUsIGNsb2NrIAo+IHZhbHVlcyBhcmUgbm90IHN1ZmZpY2llbnQgYW5kIHdlIHNlZSBmbGFzaCBs
aW5lcyBhY3Jvc3MgZW50aXJlIHNjcmVlbi4KPgo+IFRoaXMgaXNzdWUgaXMgbm90IG9ic2VydmVk
IHdoZW4gTVBPIGlzIGRpc2FibGVkIG9yIG5vdCBhY3RpdmUuCj4KPiBSZWdhcmRzLAo+Cj4gUHJh
dGlrCj4KPj4KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChkaXNwbGF5X2NvdW50ICYm
IGlzX21wb19lbmFibGVkKGNvbnRleHQpKSB7Cj4+PiArIHBwX3NtdS0+c2V0X2hhcmRfbWluX2Zj
bGtfYnlfZnJlcSgmcHBfc211LT5wcF9zbXUsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoKG5ld19jbG9ja3MtPmZjbGtfa2h6IC8gMTAwMCkgKiAx
MDEpIC8gMTAwKTsKPj4+ICsgcHBfc211LT5zZXRfaGFyZF9taW5fZGNmY2xrX2J5X2ZyZXEoJnBw
X3NtdS0+cHBfc211LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKChuZXdfY2xvY2tzLT5kY2ZjbGtfa2h6IC8gMTAwMCkgKiAxMDEpIC8gCj4+PiAx
MDApOwo+Pj4gKyBwcF9zbXUtPnNldF9taW5fZGVlcF9zbGVlcF9kY2ZjbGsoJnBwX3NtdS0+cHBf
c211LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KG5ld19jbG9ja3MtPmRjZmNsa19kZWVwX3NsZWVwX2toeiArIDk5OSkgLyAKPj4+IDEwMDApOwo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsKPj4+ICsgcHBfc211LT5zZXRfaGFy
ZF9taW5fZmNsa19ieV9mcmVxKCZwcF9zbXUtPnBwX3NtdSwKPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5ld19jbG9ja3MtPmZjbGtfa2h6IC8gMTAw
MCk7Cj4+PiArIHBwX3NtdS0+c2V0X2hhcmRfbWluX2RjZmNsa19ieV9mcmVxKCZwcF9zbXUtPnBw
X3NtdSwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG5ld19jbG9ja3MtPmRjZmNsa19raHogLyAxMDAwKTsKPj4+ICsgcHBfc211LT5zZXRfbWluX2Rl
ZXBfc2xlZXBfZGNmY2xrKCZwcF9zbXUtPnBwX3NtdSwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChuZXdfY2xvY2tzLT5kY2ZjbGtfZGVlcF9zbGVl
cF9raHogKyA5OTkpIC8gCj4+PiAxMDAwKTsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0K
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+PiDCoMKgwqDCoMKgIH0KPj4+Cj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
