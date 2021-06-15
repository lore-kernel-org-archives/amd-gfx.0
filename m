Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A03C48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 14:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A737761490
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 14:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A737761490
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B096E0FC;
	Tue, 15 Jun 2021 14:40:47 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF556E0FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 14:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PL725Ys8wVEQBY526X1+j4ykFWIWJh5xDtJgrHJ4k5DcQB/xn/Ny1YWdmbAeKFQD1/GBG7I4ZNLpSW1x1kisJ6YUWcHPkhrL5cpxz5uSuuXoyms4amMCxANMrbKEM0Bqx2Ao7rosywWJxGPPnkWpiU7s/hWaRuT3801v5byOVLVZA5/O8wWtZbqaqFzSsWkRMOul6/lsZVSIPb2ZTxNsFWu6XkICqVOIXwE+Zs/5o7/P4f+CGag7IblyA6+EWfs3xIYR0ZpKLRhU1V7S3QcC8cBPq4OFAw0VaLxsy/OIaV8YkfrU75b8TTvtm47l3fdPLHD6cFwgR59M4wQV9Yr21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAXhkl59pRjUh+SmMZZDopho18HXiWOmCT56H0b5ytk=;
 b=RoWa1aKir+dVFoeJTvCvnF+rMuICpgVC2Dwc5bWlgtfHzZEa2zMlECd+65RdCZprdug/n6l2HGHigoyTz+YnL394XPz1YWUpq438zee9yag+Y7vRvonDOTl4eN9/DEW+kyf98e5siQ2m7xGW7avHTYvuYDgVM4SmKTu6SSzoxjqAKqtMCjc+D+QEyvO9OXbW/6pG6lvndMcKF2nKwafK4/TAPD99VL0jaqFt78PF4yYwWUN0AD4dgNYH4VB4rBHJ8dDre0VKcMgFZe2WhMvH5XKk/ZMEuEBmnqSAkf/zDDLWr8Y07jzxuUcwa+k6GK5or+3A7XSRMUoI/1R/osvlJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAXhkl59pRjUh+SmMZZDopho18HXiWOmCT56H0b5ytk=;
 b=XFkXKwV13RvK3vpL59ernXiObFAAMiejlny/NlflKJ1XrK54QXxYnsWElmswqgWRB0YUwgBgPpqSiUCncH7CxABzIGWYJC1YEwBmSprQwjuAJUJoPFJs1IHJc0vJ0tKxCUmQpo5boRBR8QceXT/Kmcc8CfKNd495vQUpsR7RtzA=
Received: from DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11)
 by DM6PR12MB5568.namprd12.prod.outlook.com (2603:10b6:5:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Tue, 15 Jun
 2021 14:40:44 +0000
Received: from DM4PR12MB5374.namprd12.prod.outlook.com
 ([fe80::dd20:3f66:e06a:2297]) by DM4PR12MB5374.namprd12.prod.outlook.com
 ([fe80::dd20:3f66:e06a:2297%4]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 14:40:44 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: Use spinlock_irqsave for pasid_lock
Thread-Topic: [PATCH 1/1] drm/amdgpu: Use spinlock_irqsave for pasid_lock
Thread-Index: AQHXYWmmjToysnOKX0CmhZzBh+kfyasU4vWA
Date: Tue, 15 Jun 2021 14:40:44 +0000
Message-ID: <E3747B77-A860-492A-AF1F-34FFE7DD7E39@amd.com>
References: <20210614220702.11246-1-Felix.Kuehling@amd.com>
In-Reply-To: <20210614220702.11246-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.49.21050901
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e03cfdf-d5a1-4191-8d2a-08d9300b8ec1
x-ms-traffictypediagnostic: DM6PR12MB5568:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB556801D616D04EE3BA71D86080309@DM6PR12MB5568.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zxPnO035X8NZnep+ezLJdeLrPdxhg4FqvYmFry8sM3longoW3nbP2RZ31ZFfYFVgNC/RdKlk27gw5XxHGdrgvXnjRpsCDCPpkV4m5QYt5eLydY5Y+gaQ5nZDnOfm7kf6ed9q9IwC6DyB5JNf6dOCFPmWtiVUuGQ1A0BJ3R9NZlM9WiVaeC4ddUacn7w0rgYL3GfWSdUPbcu4FJIvCC70CfLC4Dtjdh/VvjZrdJWuCtrzM2MeYraUkfrCXJXawi8RBzQmEAMrnVxIGn4A7UUM4FvAleMZXvg2nkKUM83DVnxjkx+H9gIXC9NCoriEhIZ+A5a12RS4pVsERkY1zm4af0lTRcL9dE1c3bhK5HsndDsauV4kmEg3ZAh6klwnOjiG5CSScmMtHvx18fqwX945FNo8rDikyevOMkc5tqokcuXjTarkGSdNM9AQE5OoHDEWFp0mTrhS2JOiKQqHd2rRV1gBYAJrRVi6eBRR/Au0YcoumM2DNqtbBrzwxt6hV8YtA5RRRZjJkBjH4hi4F+0uYS+/Wvz7eoObTiRnYjAV6gzlNJCccFBYy6Qh/v0kSfFoDPrapYzIamrH1m088q976Ke7r1wqjXyymafF9q6os//jDHHeqXmJusFAktsjfTy93aRImpBGjc0FrrCKi3/A6oSGyrW37tPalxDl0rRNICnjDMnoOkmxs2Si3urPlh43
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(71200400001)(76116006)(66476007)(5660300002)(6506007)(2906002)(64756008)(66556008)(66446008)(33656002)(6512007)(86362001)(83380400001)(2616005)(66946007)(110136005)(26005)(91956017)(316002)(36756003)(186003)(45080400002)(6486002)(8676002)(38100700002)(122000001)(8936002)(966005)(478600001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vmh5TlFibnVkVkd1NmJ6R3oxQTByZkdoUjBaU1RiNXZ1QlltZlBNUnFiWnFK?=
 =?utf-8?B?cWQxclQzMEtqOHMrVnZrcUdMMjBkc3ZUQmZjaWpjYnhKd1Q5aXl6eTBKRkx5?=
 =?utf-8?B?dUNRM2FhNzNiMCtoeEUyN2hZNTFMQ3dtbW40VnVhandaTTgwOUhVZnpqRmNE?=
 =?utf-8?B?T1lWNktEWnkvT29QbEhFcURLTUQydUxoWWpoK004eGdIM0crRzc3dElZemxi?=
 =?utf-8?B?TkVlMlluaG8vOVdEeGo2RXZoeVhlR2h3VDFEdnFLYmVGbk1uc1BvWG4wdEhF?=
 =?utf-8?B?OU5SUElQalc5SlRIai82Ujl1YkdYd2RTQ0ZCcDNFVUV3SGZCL0VIV1hjL3U4?=
 =?utf-8?B?RGlpcFVVS2taRUhvQi9pbkVmVm0vc21OazJadjlmVFd6S2NCRjJlNzJMVG1m?=
 =?utf-8?B?Ui9iSm4xQUI2aGh1cHZ1YW9TTDJBcDR0TFVobllNL3M1SmJqZjlPV2tDSkg0?=
 =?utf-8?B?ODd6U1lpVXN1YUhFQjNjbnQzb2pmR2lsTkJsOS9ZNXdsaHplTVBJbUVKckRC?=
 =?utf-8?B?bUE1eUpMWEphTjZqejZ1S05VL0lIdGNJNDFXM0RXWGdHTjBPTVFISTE5VE5V?=
 =?utf-8?B?eXJ6SVVxQ3pmc1VvUDVCLzFlQys3SHN1Yk5JeHFWVWtjZ0xFRSsra2FPQkZN?=
 =?utf-8?B?MmVDUkFoZW01aTNzNXNnbTczdm1JL0loZUFBK2k0RjhrNW1KZW9XRXBLeUlG?=
 =?utf-8?B?Ym8yNmp6dWlzcWtBSDBlMkh4NFR1RDFPN1dBOUNCTTA4Zjl6MzBMYXVpN1hh?=
 =?utf-8?B?NVhQc1d1OGtMMmsvZ3kzNGlPa0trQ2RGdXZMRmxaaFpHakVSRFUyVGgzNVhl?=
 =?utf-8?B?WFJBNHU5U2ltMkN5OWpJNm5abnBMaUpZVHppN0RZRVIwU2lxOWJ3Zzl6RmRm?=
 =?utf-8?B?bDdNLzBxeGkrMjY2U05BNGhZdS9KZlk2NUZsSnlnKzR4aFdtRERIQ1lkRkNa?=
 =?utf-8?B?NmNYOVVOcmtFbllZVnFjbFh3WGJISFoyM2taTko2N3NPS0JqNk56T2UvcjRV?=
 =?utf-8?B?Z0RTR3BBbkJnL1hpemVRNGJxdGF3VnF4R3ZaM25QbGdkTnhaMGJkQ3o1NXdB?=
 =?utf-8?B?WnZzOTRIYXRHKzVGN3BhdDZpNzV0UFp5c1pWUy8weElJeVp4QXhiOXNYUXFV?=
 =?utf-8?B?UkwxaDVRRzluU05EOEYrMVJPTS9FeGQvdHNjV1RSYThWK1JvN0pVT0FCbWxm?=
 =?utf-8?B?LzR2SGhJMElUUXczNHFTTjJMSHh0ZjVYbzZPdUR5WGx2SG9yVnJmVXh5TzlJ?=
 =?utf-8?B?Sjl6ZDk3cmVkUXo0UmZVUEZ6eEtCUUN1L0Y1WW1GMkxncnM3RUN0LzMvU1Nw?=
 =?utf-8?B?Wll5SWx4Tmd5SDJJbnhETDJMZ3BLS2R6bWxtTk5FY0lFS1NkbDhkN01sMldE?=
 =?utf-8?B?RERUYTA1TVA0ZHJFQ1grZExYSVFlTHZjb0tiYjM0Ulp6ZUhzaXhDVjdqQW5k?=
 =?utf-8?B?WE9ybFhFWWgvaVFqU1lLOXlqNW9xV0JBSFpQSWpXTnNFS2VpaGwzLzRHZDJE?=
 =?utf-8?B?UmdUMzE5QndnMGQ0d1ZuUlpUcTd5ZVcvY2FUeE51TXZNL0hvQmp5K1Bqc3Fh?=
 =?utf-8?B?MEhQWi9UaUhhTDg4MWVzOVpyQkora2JLdTcvazFDc3V1WC9sbkJQL1F4Vmpa?=
 =?utf-8?B?NW1NWXVqbHJ6eGRZQjN1RnNvMXRqaVl1QlRRbDlMdGl1NVpkMmxNdnVaSmFJ?=
 =?utf-8?B?TThHY3g3UVBzdTRMT2RGeVNseTBPSXNTeVh3Y0RzRFZFV2xDOG1sYWZPRGZy?=
 =?utf-8?B?VlRqcFA2WEhjdFlCclQ3SEE3b0lsV2F2SzRUNlVjdzloTUdTVElLbXJYSXFa?=
 =?utf-8?B?dlpUdlVxNmVLNHpBWHkyUT09?=
Content-ID: <E7BA15A88600EF44B563764EE993AD0A@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e03cfdf-d5a1-4191-8d2a-08d9300b8ec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 14:40:44.6652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sSHNzfQGhqHgi/cHEglrxiTWXPaZVEUpfUzmHilVaKn87FnJjKJqozVSennHkiMQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5568
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

UmV2aWV3ZWQtYnk6IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29tPg0KDQpSZWdhcmRzLA0KT2Fr
IA0KDQogDQoNCu+7v09uIDIwMjEtMDYtMTQsIDY6MDcgUE0sICJhbWQtZ2Z4IG9uIGJlaGFsZiBv
ZiBGZWxpeCBLdWVobGluZyIgPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmcg
b24gYmVoYWxmIG9mIEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+IHdyb3RlOg0KDQogICAgVGhpcyBz
aG91bGQgZml4IGEga2VybmVsIExPQ0tERVAgd2FybmluZyBvbiBWZWdhMTA6DQogICAgWyAgMTQ5
LjQxNjYwNF0gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgICBbICAxNDkuNDIw
ODc3XSBXQVJOSU5HOiBpbmNvbnNpc3RlbnQgbG9jayBzdGF0ZQ0KICAgIFsgIDE0OS40MjUxNTJd
IDUuMTEuMC1rZmQtZmt1ZWhsaW4gIzUxNyBOb3QgdGFpbnRlZA0KICAgIFsgIDE0OS40Mjk3NzBd
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogICAgWyAgMTQ5LjQzNDA1M10gaW5j
b25zaXN0ZW50IHtIQVJESVJRLU9OLVd9IC0+IHtJTi1IQVJESVJRLVd9IHVzYWdlLg0KICAgIFsg
IDE0OS40NDAwNTldIHN3YXBwZXIvMy8wIFtIQzFbMV06U0MwWzBdOkhFMDpTRTFdIHRha2VzOg0K
ICAgIFsgIDE0OS40NDUxOThdIGZmZmY5YWM4MGUwMDVkNjggKCZhZGV2LT52bV9tYW5hZ2VyLnBh
c2lkX2xvY2spez8uKy59LXsyOjJ9LCBhdDogYW1kZ3B1X3ZtX2dldF90YXNrX2luZm8rMHgyNS8w
eDkwIFthbWRncHVdDQogICAgWyAgMTQ5LjQ1NjI1Ml0ge0hBUkRJUlEtT04tV30gc3RhdGUgd2Fz
IHJlZ2lzdGVyZWQgYXQ6DQogICAgWyAgMTQ5LjQ2MTEzNl0gICBsb2NrX2FjcXVpcmUrMHgyNDIv
MHgzOTANCiAgICBbICAxNDkuNDY0ODk1XSAgIF9yYXdfc3Bpbl9sb2NrKzB4MmMvMHg0MA0KICAg
IFsgIDE0OS40Njg2NDddICAgYW1kZ3B1X3ZtX2hhbmRsZV9mYXVsdCsweDQ0LzB4MzgwIFthbWRn
cHVdDQogICAgWyAgMTQ5LjQ3NDE4N10gICBnbWNfdjlfMF9wcm9jZXNzX2ludGVycnVwdCsweGE4
LzB4NDEwIFthbWRncHVdDQogICAgLi4uDQoNCiAgICBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVo
bGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCiAgICAtLS0NCiAgICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCA5ICsrKysrLS0tLQ0KICAgICAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQogICAgZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCiAgICBpbmRleCAzYjZjMGI0OGQwYjEuLjBiNjM2ODZm
YzMxYSAxMDA2NDQNCiAgICAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYw0KICAgICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQog
ICAgQEAgLTMzOTQsMTEgKzMzOTQsMTIgQEAgYm9vbCBhbWRncHVfdm1faGFuZGxlX2ZhdWx0KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1MzIgcGFzaWQsDQogICAgIHsNCiAgICAgCWJvb2wg
aXNfY29tcHV0ZV9jb250ZXh0ID0gZmFsc2U7DQogICAgIAlzdHJ1Y3QgYW1kZ3B1X2JvICpyb290
Ow0KICAgICsJdW5zaWduZWQgbG9uZyBpcnFmbGFnczsNCiAgICAgCXVpbnQ2NF90IHZhbHVlLCBm
bGFnczsNCiAgICAgCXN0cnVjdCBhbWRncHVfdm0gKnZtOw0KICAgICAJaW50IHI7DQoNCiAgICAt
CXNwaW5fbG9jaygmYWRldi0+dm1fbWFuYWdlci5wYXNpZF9sb2NrKTsNCiAgICArCXNwaW5fbG9j
a19pcnFzYXZlKCZhZGV2LT52bV9tYW5hZ2VyLnBhc2lkX2xvY2ssIGlycWZsYWdzKTsNCiAgICAg
CXZtID0gaWRyX2ZpbmQoJmFkZXYtPnZtX21hbmFnZXIucGFzaWRfaWRyLCBwYXNpZCk7DQogICAg
IAlpZiAodm0pIHsNCiAgICAgCQlyb290ID0gYW1kZ3B1X2JvX3JlZih2bS0+cm9vdC5iYXNlLmJv
KTsNCiAgICBAQCAtMzQwNiw3ICszNDA3LDcgQEAgYm9vbCBhbWRncHVfdm1faGFuZGxlX2ZhdWx0
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1MzIgcGFzaWQsDQogICAgIAl9IGVsc2Ugew0K
ICAgICAJCXJvb3QgPSBOVUxMOw0KICAgICAJfQ0KICAgIC0Jc3Bpbl91bmxvY2soJmFkZXYtPnZt
X21hbmFnZXIucGFzaWRfbG9jayk7DQogICAgKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZhZGV2
LT52bV9tYW5hZ2VyLnBhc2lkX2xvY2ssIGlycWZsYWdzKTsNCg0KICAgICAJaWYgKCFyb290KQ0K
ICAgICAJCXJldHVybiBmYWxzZTsNCiAgICBAQCAtMzQyNCwxMSArMzQyNSwxMSBAQCBib29sIGFt
ZGdwdV92bV9oYW5kbGVfZmF1bHQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUzMiBwYXNp
ZCwNCiAgICAgCQlnb3RvIGVycm9yX3VucmVmOw0KDQogICAgIAkvKiBEb3VibGUgY2hlY2sgdGhh
dCB0aGUgVk0gc3RpbGwgZXhpc3RzICovDQogICAgLQlzcGluX2xvY2soJmFkZXYtPnZtX21hbmFn
ZXIucGFzaWRfbG9jayk7DQogICAgKwlzcGluX2xvY2tfaXJxc2F2ZSgmYWRldi0+dm1fbWFuYWdl
ci5wYXNpZF9sb2NrLCBpcnFmbGFncyk7DQogICAgIAl2bSA9IGlkcl9maW5kKCZhZGV2LT52bV9t
YW5hZ2VyLnBhc2lkX2lkciwgcGFzaWQpOw0KICAgICAJaWYgKHZtICYmIHZtLT5yb290LmJhc2Uu
Ym8gIT0gcm9vdCkNCiAgICAgCQl2bSA9IE5VTEw7DQogICAgLQlzcGluX3VubG9jaygmYWRldi0+
dm1fbWFuYWdlci5wYXNpZF9sb2NrKTsNCiAgICArCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmFk
ZXYtPnZtX21hbmFnZXIucGFzaWRfbG9jaywgaXJxZmxhZ3MpOw0KICAgICAJaWYgKCF2bSkNCiAg
ICAgCQlnb3RvIGVycm9yX3VubG9jazsNCg0KICAgIC0tIA0KICAgIDIuMzIuMA0KDQogICAgX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCiAgICBhbWQtZ2Z4
IG1haWxpbmcgbGlzdA0KICAgIGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQogICAgaHR0
cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNB
JTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdm
eCZhbXA7ZGF0YT0wNCU3QzAxJTdDb2FrLnplbmclNDBhbWQuY29tJTdDY2JiZGYzODVjNmEyNDAz
YmRkYzQwOGQ5MmY4MGM2ZGElN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAl
N0MwJTdDNjM3NTkzMDUyNDE4MzEzMjIxJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9p
TUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUz
RCU3QzEwMDAmYW1wO3NkYXRhPU1kbFp6UmpuYzlzZzlpa1hzdThkTm5paCUyRmxPS1JoN2E0WDlw
TkVXUFNJbyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
