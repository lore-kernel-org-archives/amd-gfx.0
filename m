Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BE9C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 20:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45602070E
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 20:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45602070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EAA46F570;
	Fri, 22 Nov 2019 20:51:17 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760041.outbound.protection.outlook.com [40.107.76.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5466B6F572
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 20:51:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyG9KFSfWtYS5xdMOn8KqKJnXndCBd5MH8cPeHZfd8xvck/GCbFd3hwMVuJBJmsWydVpyC15mbZczU3plOyExWFWjoNt7GxHZYck3+DU/knujxhnNnlRfEHBXkyywERkCXKdvg007PCBt9ey5MPWrx4ywacvOWOMVjzR3yTA0pQlXsvHhrva7QfW2Qu7uFqSLGIP9UnHJpAOJrx0X2W4eYvoA7QUEIBLBiSqDOaak+/79ddERG77BmqmfvhQ/XdtJe5B3mY20VP0oQn3N5cv/ewHLxvdIcc1s6FvWQfi27x7hw17oBjNy8rzOjG+kxoOkHCJWtoUd5Dd9i81AgiYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bB0TDwGhPgonuS7LBJtdFNAge26NhYsRuItKetXNrko=;
 b=Su307Gon8T3GQ8W0+tnB7z5GhnCKddJxmnvuZh3KEvmhrIWEqqLYa1ig/kdWVKoJi/KtyCB6OShOgiLT+06S8VmzmIQsizHLpuO7Yc/UdShUumvxBPMC6a1IMOW6+k1xpza9P7sTgv1O40Y1QZ+4OGVf6i6IYTJ+k28t7j/PTXv8YD/lIQsPARv10om1UyjbtxZR4QWpRhqX7lecX9boh7mvkNX6SJKu9jWn07Ngh+B4N0MF+4/D92KgtN4IIT6LIWxoUoU2MzA0xNMckUG4jP/sVGdnbD3hsTftkT8bLzYnpIxSUokvtKYLHPmvQxumqHZ/dgz0IP2kdreoYI73/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3868.namprd12.prod.outlook.com (10.255.173.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Fri, 22 Nov 2019 20:51:14 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 20:51:14 +0000
Subject: Re: [PATCH] drm/amdgpu: Apply noretry setting for gfx10 and mmhub9.4
To: Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1574454197-13273-1-git-send-email-Oak.Zeng@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <b4dcc63c-e57e-30cb-06f2-11451c37a195@amd.com>
Date: Fri, 22 Nov 2019 15:51:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <1574454197-13273-1-git-send-email-Oak.Zeng@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::41) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1dfc0194-ecfb-477a-89b2-08d76f8db65c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3868:|DM6PR12MB3868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB386870FC2787366B90AFA99392490@DM6PR12MB3868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-Forefront-PRVS: 02296943FF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(199004)(189003)(2870700001)(478600001)(66556008)(66476007)(6436002)(36756003)(58126008)(31696002)(4326008)(5660300002)(52116002)(386003)(36916002)(23676004)(6506007)(25786009)(47776003)(6512007)(76176011)(7736002)(2906002)(2486003)(14454004)(6486002)(4001150100001)(66946007)(186003)(86362001)(6116002)(31686004)(53546011)(66066001)(65956001)(65806001)(3846002)(305945005)(229853002)(26005)(8936002)(81156014)(316002)(8676002)(81166006)(11346002)(2616005)(446003)(50466002)(6246003)(44832011)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3868;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTNJNWFvYkNiVGt4b0ZPNnNHRldxaVFrTThwYjkyK3FvdTRhRllVOCtST0tu?=
 =?utf-8?B?YlVSckYvVjk5NTRyc3BybDFLUmhLRFRpNStJQkUvN3dVNlRIWnJMb1B3WXNL?=
 =?utf-8?B?S2RuZDdpcXRwNEQ5SE9WQkNYb2ozVFcvN21UUWJ0T0xJbjhuRkNxK3M2VE9O?=
 =?utf-8?B?bGZuM2hMQU91Mlc5VGNLVjAraFoycXpuRVFQLzJjaE1TZ21rek54bWE3N09L?=
 =?utf-8?B?dnNzUFlLdTdpRk82L0FuMDBYNVZpMmxqRE9HK2xncU02UDI0ME1wQmhUVi9W?=
 =?utf-8?B?dkNQZE0vd0oraFI1anQzRmkrVE8zU210eG1CaEpRUFd1TGJLa3lIK3Foc2tx?=
 =?utf-8?B?K2FxVUJtQlVYSUFYdUFla2dVcExEVS8wSXJncjh0ZEFpb21WOUF5OUppcmRQ?=
 =?utf-8?B?ZGUzb0NZTXJBa3lMOU5lSjMrc1Jvc1Q3eUxQdXlGWUgvTTJYTk9sTmFrSENP?=
 =?utf-8?B?UFhLcTlhdFZQV2JyYithZEd0UTVveFNUbzE4NTZENGZYWkVFVkUyaENLWklX?=
 =?utf-8?B?cmgydm40N05QNWUzTzZsNnJsTlhzKzdTUHJhYkYwNkYwTzlidkRRUkI5R0NR?=
 =?utf-8?B?NUFHVTlSTXlJZXZLUnFJdHgrMHc5ZlJsbytKOTJDRUFUa1Z2cG55SExVS2di?=
 =?utf-8?B?ZDRmK2RROUU2Q2gvYkFQQ3dDMitkL2RYSjZtVEJUVzdWTjE3U1JaZFRKY2p4?=
 =?utf-8?B?U2lpRjZqUlZvTWMzQ21Ud3hiWTJPbUdFUTZvOVNGcE00c1RvZVAraFBYbzI5?=
 =?utf-8?B?VTdScnUxUDQ2TmduMUJQRWl2LzdzSFJuTkt5VkhCODZzMEVlM2ZPb3BVS1VK?=
 =?utf-8?B?VkxwVUJxOFlYd1Q5US9sMTVMdmhjL2M2bTNhQXBWVmVNeWtlWXpSOENFR1p6?=
 =?utf-8?B?RkJ3ZWpscVlNTFFzZmpKUXNKL0pUbHI0MU93U01hVmZxWjhhREd3VC95QnJq?=
 =?utf-8?B?L0hBck5CU0I3WDFJdXpPN0lJalB4blZ5TVM3d3AxWEpBRlE3ejRKdCtETWMw?=
 =?utf-8?B?T2lkaHZuZWdsQmtZbGFEYWRaRzh1TVowMncrcExURzhDemNCQXFidm9kNk5K?=
 =?utf-8?B?bFlVTTdkcXVzby84dGdKaXRIZytqR0RwNFJVK3drbWZqWTFCQW5icGFtYkVO?=
 =?utf-8?B?c2dZMVhsOFp1V2Y0Sk4yd2pkVy8xZ2MwZzIxeTVpczhmNU5uR3VFNGdSWk1k?=
 =?utf-8?B?emVBWWprVU5HOC81aTRTTmV4RVJQa2xsaFA2aUNHUTZkWHlaVG80TGlSMnFs?=
 =?utf-8?B?dWIxQm1aY2FwL1VWSHNGZHhiODJ4Z2ttNmZEcmRpcmhvZ1VuQXhpM0c2SFEz?=
 =?utf-8?B?OU1FT0N0a2FyQ3NZdEdTVmt5cXhhUUFORHQ4SXhzR1E3RzJ4ditxK2RwQ2t1?=
 =?utf-8?B?b1pVaUlIQSt3blc0bGlBYjdqRTB1L2tka3JrOWJkbDFlSmZZQzhyYm5sZmNm?=
 =?utf-8?B?aG5XU0FKdDc1aWFUTUF2UU9aTE5aRERjbU52Mko4eHRkamJiUTJBdW1uZFJz?=
 =?utf-8?B?VVVaVUFsZ0l2N05rL0FnbE4rS1E3OERER0R1enJIa1hZdjZPdlduMjhqOGFJ?=
 =?utf-8?B?RUJYL3Y0ZlpkR3BYM3lNRmNDR0F2K2xUWGNiKzhHYjFwdEJ4aGhzZms4YTJH?=
 =?utf-8?B?V2hNcDZ6cjRieU5iTkMwT2p2L0RnMjEyNVFOVVVsa25mVVBkc2JBVm5IZDR3?=
 =?utf-8?B?cDcxK1c0WDFIOEttQ0ZjWEE5amxqRG1ncDh5L1RFK2xNU1htZ0hCcUFNQWh4?=
 =?utf-8?B?eVdLZlVFVzlYeGovZkorbmdNeWNYamtwdTJlMk0wNzd2SFB6eFdTbVU4anhC?=
 =?utf-8?B?SzdMSXdadnJ5YTY1WDFkOHA3R2JhV2xQa1VPSVZvTGM2ZEZmblRvOFVnSkRG?=
 =?utf-8?B?VFdhbWZxQ3JWSUNMR0UvbFpJU2J0YW0zdjVnNG10MEFnNEx0QUdZelMyZ05j?=
 =?utf-8?B?VXlJMlJzb05YTUYxUy9YRVlld2RSa0crVkJnd2tZRStQNjJ6czlpTWFJaU1n?=
 =?utf-8?B?a0xPRmNVUmU3MHAzWlNKQVBUK1g1bEh2WXlHNlMxZTJadnd0MCt0d1VUZHVV?=
 =?utf-8?B?b1dkMzkrY05COFFlRTlrQWJKZUkzaHdxQktSc2xXdCtMbk81YnlSVVNjWHI2?=
 =?utf-8?B?cnZUV2FtUGsvUEZlcURYSksxcTZ0Sms3cWJpSEdCTlg4YzcvZmxNTTd2N1hO?=
 =?utf-8?B?VzF3UWYrUTY5YnZWQWlpaVFmaU5NbmxMYzNVRTRhVG5LbjU1dUlzdVNmSVlK?=
 =?utf-8?B?eDloMGxwYXEvL1RSaXhsMHVSb0Y1QTNTRmtUc1RUSTAwRmdZZHFzZ3A3aU95?=
 =?utf-8?B?cklxZ0lhK3JFMmVxSCtHUzZCS2RodDFrUys5eHFuTUVPKzhTY1BQVjRmVnR1?=
 =?utf-8?B?Ymk0dHFiWXRWNHFDWW1KNm5jNW1zZFBsQW1vdFJpd0h2dUVvbFlIei9MR0NV?=
 =?utf-8?Q?Av3SB2y1STADc1PyGd3ZlTOucmwYvBabpk0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dfc0194-ecfb-477a-89b2-08d76f8db65c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 20:51:13.9332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJm33+gPos6/V+FoGLMqoppjT4gQF8H8zhebtsPpHEVjNqLPGDW71u3e3+jhSo0cjs7TRAOT9fCxIiYOLDf/Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3868
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bB0TDwGhPgonuS7LBJtdFNAge26NhYsRuItKetXNrko=;
 b=Uajm5/WWYbpQBfc6sGx9ZwfWILSw67vyoa5op84MnjyajaanDoBPtWUfFQ+ERF9Oeirc8QbqPUGX7Z4ozPdy0gmK6Zy/hu1Nk0ynzmCcUHu6AQgw+LUSZjKCeJFOnEhRdhtHCUwSDGcIor9F41egs/uE2V4LAR0Le+kCbKsinjg=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Jay.Cornwall@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191122205112.uPaXd9XK9YbB31g88QIx_AprZT3M4IejZUNeSLGk8NM@z>

Ck9uIDIwMTktMTEtMjIgMzoyMyBwLm0uLCBPYWsgWmVuZyB3cm90ZToKPiBDb25maWcgdGhlIHRy
YW5zbGF0aW9uIHJldHJ5IGJlaGF2aW9yIGFjY29yZGluZyB0byBub3JldHJ5Cj4ga2VybmVsIHBh
cmFtZXRlcgo+Cj4gQ2hhbmdlLUlkOiBJNWI5MWVhNzc3MTUxMzdjZjhjYjg0ZTI1OGNjZGZiYjE5
YzdhNGVkMQo+IFNpZ25lZC1vZmYtYnk6IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29tPgo+IFN1
Z2dlc3RlZC1ieTogSmF5IENvcm53YWxsIDxKYXkuQ29ybndhbGxAYW1kLmNvbT4KPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jICB8IDQgKysrLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jIHwgNSArKystLQo+ICAgMiBmaWxl
cyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+IGluZGV4IDRkNmRmMzUuLjc0MzU0ODcgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+IEBAIC0xNzUxLDcgKzE3NTEs
OSBAQCBzdGF0aWMgdm9pZCBnZnhfdjEwXzBfY29uc3RhbnRzX2luaXQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpCj4gICAJZm9yIChpID0gMDsgaSA8IGFkZXYtPnZtX21hbmFnZXIuaWRfbWdy
W0FNREdQVV9HRlhIVUJfMF0ubnVtX2lkczsgaSsrKSB7Cj4gICAJCW52X2dyYm1fc2VsZWN0KGFk
ZXYsIDAsIDAsIDAsIGkpOwo+ICAgCQkvKiBDUCBhbmQgc2hhZGVycyAqLwo+IC0JCVdSRUczMl9T
T0MxNShHQywgMCwgbW1TSF9NRU1fQ09ORklHLCBERUZBVUxUX1NIX01FTV9DT05GSUcpOwo+ICsJ
CXRtcCA9IFJFR19TRVRfRklFTEQoREVGQVVMVF9TSF9NRU1fQ09ORklHLCBTSF9NRU1fQ09ORklH
LAo+ICsJCQkJUkVUUllfTU9ERSwgYW1kZ3B1X25vcmV0cnkgPyAyIDogMCk7Cj4gKwkJV1JFRzMy
X1NPQzE1KEdDLCAwLCBtbVNIX01FTV9DT05GSUcsIHRtcCk7CkkgZGlkbid0IGZpeCBnZnhfdjEw
XzAgb24gcHVycG9zZSBsYXN0IHRpbWUgSSB3b3JrZWQgb24gdGhpcyAKKCI3NWVlNjQ4NzVlNzUg
ZHJtL2FtZGtmZDogQ29uc2lzdGVudGx5IGFwcGx5IG5vcmV0cnkgc2V0dGluZyIpLCBiZWNhdXNl
IAp0aGUgcmV0cnkgd29ya3MgZGlmZmVyZW50bHkgb24gR0ZYdjEwLiBEbyB5b3UgaGF2ZSBuZXcg
aW5mb3JtYXRpb24gYWJvdXQgCmhvdyB0aGUgUkVUUllfTU9ERSBzZXR0aW5nIHdvcmtzIG9uIEdG
WHYxMD8gRG9lcyBpdCBhZmZlY3QgcGVyZm9ybWFuY2U/CgoKPiAgIAkJaWYgKGkgIT0gMCkgewo+
ICAgCQkJdG1wID0gUkVHX1NFVF9GSUVMRCgwLCBTSF9NRU1fQkFTRVMsIFBSSVZBVEVfQkFTRSwK
PiAgIAkJCQkoYWRldi0+Z21jLnByaXZhdGVfYXBlcnR1cmVfc3RhcnQgPj4gNDgpKTsKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jCj4gaW5kZXggNzUzZWVhMi4uODU5OWJm
ZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMKPiBAQCAtMzE0
LDcgKzMxNCw4IEBAIHN0YXRpYyB2b2lkIG1taHViX3Y5XzRfc2V0dXBfdm1pZF9jb25maWcoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGludCBodWJpZCkKPiAgIAkJCQkgICAgYWRldi0+dm1f
bWFuYWdlci5ibG9ja19zaXplIC0gOSk7Cj4gICAJCS8qIFNlbmQgbm8tcmV0cnkgWE5BQ0sgb24g
ZmF1bHQgdG8gc3VwcHJlc3MgVk0gZmF1bHQgc3Rvcm0uICovCj4gICAJCXRtcCA9IFJFR19TRVRf
RklFTEQodG1wLCBWTUwyVkMwX1ZNX0NPTlRFWFQxX0NOVEwsCj4gLQkJCQkgICAgUkVUUllfUEVS
TUlTU0lPTl9PUl9JTlZBTElEX1BBR0VfRkFVTFQsIDApOwo+ICsJCQkJICAgIFJFVFJZX1BFUk1J
U1NJT05fT1JfSU5WQUxJRF9QQUdFX0ZBVUxULAo+ICsJCQkJICAgICFhbWRncHVfbm9yZXRyeSk7
CgpSaWdodCwgdGhpcyB3YXMgbWlzc2VkIGluIG15IHByZXZpb3VzIGNvbW1pdCBiZWNhdXNlIG1t
aHViX3Y5XzQgd2FzIAphZGRlZCBsYXRlci4KClJlZ2FyZHMsCiDCoCBGZWxpeAoKCj4gICAJCVdS
RUczMl9TT0MxNV9PRkZTRVQoTU1IVUIsIDAsIG1tVk1MMlZDMF9WTV9DT05URVhUMV9DTlRMLAo+
ICAgCQkJCSAgICBodWJpZCAqIE1NSFVCX0lOU1RBTkNFX1JFR0lTVEVSX09GRlNFVCArIGksCj4g
ICAJCQkJICAgIHRtcCk7Cj4gQEAgLTkwNSw0ICs5MDYsNCBAQCBzdGF0aWMgdm9pZCBtbWh1Yl92
OV80X3F1ZXJ5X3Jhc19lcnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAg
IGNvbnN0IHN0cnVjdCBhbWRncHVfbW1odWJfZnVuY3MgbW1odWJfdjlfNF9mdW5jcyA9IHsKPiAg
IAkucmFzX2xhdGVfaW5pdCA9IGFtZGdwdV9tbWh1Yl9yYXNfbGF0ZV9pbml0LAo+ICAgCS5xdWVy
eV9yYXNfZXJyb3JfY291bnQgPSBtbWh1Yl92OV80X3F1ZXJ5X3Jhc19lcnJvcl9jb3VudCwKPiAt
fTsKPiBcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKPiArfTsKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
