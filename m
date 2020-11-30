Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36D5C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 17:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628042073C
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 17:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cNnRh2sg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628042073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE7296E5D5;
	Mon, 30 Nov 2020 17:35:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E95F86E5D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 17:35:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9vsk/w7GXADfRx3LNRbCo7vXhmKGPDGCkBxqQSNqUpQPweQ8FDwaswGyvsp3/NtWeKQM5FWIzquiYTjmftkrfujGuFUqWWm9wGi8hMdXsDV+YTyF3Rzo2d4KChFPqwWnn6ZtDW6A292mefbE2vFLa2HuGdzTixq0xau6n6VHgGcrSi3wv3kIFP5Dyh7NchGA5ahxtV4HrrZqjEFTjJNHP6ln1Y3qte2nBjLPtW1EcDnfLeDbv4Ua54Z7qD8MEQetlBPNGseboyra6Ylz1iiZyCljkSSMCco1915ZvYJlja50qG7/KJOQFH10+gV0aw+4uzYuQrdPe1jC6FwJiCq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIU33yyVU1N0UR3h6ccB8VdoXT+PYPUj95l8rue5EZY=;
 b=UkhF/ERLJNtjkmhwR7U7QZyHa8BwCOTNmLULTryiixfx2vlRphDw/hhTWydl++jPCFf/GFn2zjbMrPM6jwijj/+izipDZhcNbP8ty3RZ+SV+ckvemnyNEvSvjg6FtxM/mUyZDNtGid/cuGHRnEeiY1AvUzg0pUPQEQIGC37+2M31m7DXZvsD4isHy7UJBhdGm5Gf7PwerVVCqmMar2pVJTMK1fWkZpE4U0OapSbI3mGvp0sGqGxu+Lka0SDrZsNWa7vpoUI+RvVS1Ieui/HdW389gbHF+5SwtsNgD0zx6auaEynfdcvEGh4GmR7nd5AQCgXoQrhvaIe0KPZjnK/yzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIU33yyVU1N0UR3h6ccB8VdoXT+PYPUj95l8rue5EZY=;
 b=cNnRh2sgbiYIDmDkXYEX1VNo6CTdfpv+xFo49vewY5400CO1N/Q7cQ3dNtx65PRlXxCzQ6RshpUKyhdjRandcNC61HfUw9858W08g9p+FE7NiE96FCmtSI3Do+z3eXujR8dmNFHwimBfaovFjlovm9ApYqABNOq1BfVhBS15FQ8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB3695.namprd12.prod.outlook.com (2603:10b6:208:15a::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 17:35:29 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%8]) with mapi id 15.20.3611.024; Mon, 30 Nov 2020
 17:35:29 +0000
Subject: Re: [PATCH v3] drm/amd/amdgpu: set the default value of noretry to 1
 for some dGPUs
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20201015033557.3046-1-Jack.Gui@amd.com>
 <ccd27274-44e1-3bfc-24a8-e24750889efe@amd.com>
 <CAP+8YyF59Hnq=NgVbfV__GqMZ8y+HyNYRqoPo3hOBDUj1+CtZA@mail.gmail.com>
 <CY4PR12MB1287D8AA91368C4BCA99E47BF1F60@CY4PR12MB1287.namprd12.prod.outlook.com>
 <MN2PR12MB4488508A68085217363A0F64F7F50@MN2PR12MB4488.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <c3854154-1889-4ee6-3f30-c63100b0a248@amd.com>
Date: Mon, 30 Nov 2020 12:35:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <MN2PR12MB4488508A68085217363A0F64F7F50@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::33) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 17:35:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97a2d398-bfe3-44b0-4eda-08d89556541b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3695:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36953F6CCFADFF0BC41A366A92F50@MN2PR12MB3695.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnkpyrd5TfVG4KzeEyfxYMref+pLNnVMeQWSKpL5MsrHlQffCvE4/3yJTIjFgOsWMed6UlXppzr2ia7TIUzBMCJQk2VUWYYYkR0jtaM+bVb9JY72cQ6Xr+1yMeZziK7D+FYfEWJtvXFRzaE2/MvMM5RX/LJAeYYDk7Gwac1c//MG+hzcssvA50kr/KpjyLPz3WnVDsMuxbWQUn8yo1zfwOWg8xebcGZi+Ag3GCDPQeMaehmJpi305pwGukvf00fgFxvcD8gQl+ii7xxdahXPpVKbNd+Od8UhnRkfXQaHb13jyiO/xZaZ9UVJ3l+CZbTtxABTnZMUcL8Pm8pYiYwVAIZP/BlPYisB5HOElDFFlHWzkOW5cSE4EZAshWlza3Bd+JOHp7fentTDfI4T+O169l/zKLaJUY1yMKjspv1ubSkBcrb64D/SqaQfWY6LGBuC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(31686004)(4001150100001)(86362001)(956004)(6486002)(8676002)(8936002)(5660300002)(16576012)(316002)(110136005)(54906003)(4326008)(2616005)(966005)(478600001)(44832011)(31696002)(186003)(66946007)(2906002)(26005)(66556008)(66476007)(53546011)(36756003)(83380400001)(52116002)(16526019)(43740500002)(357404004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MEU2eDRKS3pCYzlaOEUyTnYyMGVsZTRBZUUzTXpjM0ZWSkQ2Z1RxaTlXMmtB?=
 =?utf-8?B?a0l6SVNJOWpEcEY0czhEWFJZZ2t0aWdtc3BMc3R5cFdMK0ZXQ3J1eG1pb2lF?=
 =?utf-8?B?VlhZbXIySG9JL3BtVURnemROUTFKMG5uRCtJOEQxMUFzN1BLOXpHSmtHY3pn?=
 =?utf-8?B?WHVoZmJuR3Y1NUVMbWQ3dUQxK29KSXBTOVVwcUJETXdFQXJrb3Q0c2lMUUdM?=
 =?utf-8?B?WGRyRkVPV2pUWDV5aGwvVitlNVVja3JRQzErbE8yYURrWW9pVVh3MHc5TUZZ?=
 =?utf-8?B?ZGwrWko2NWltWjczMlNlOXZTOXBCcG9GRlpwc3dMMzFkQThGaDZvblJDSTJN?=
 =?utf-8?B?bGFVSWs1UWlhRDlMcHFWZmFSQy9ZbjhTdjZ3MjI2blE1dWxqc1E4VDdKWlBU?=
 =?utf-8?B?L3FPQytmcTh2Z3ZCMG9GSTBwVVFQeDB5am0wQTZFWkNTdUsyL0FQY0ZoN0NX?=
 =?utf-8?B?RlhLdkQ3RVV1dEc3VjJBU0xvcEo1U0ZYSGdxUVBES0FlMzdOMk5JTkpNbXNU?=
 =?utf-8?B?SE5vT1hnMlVrZlpXYjZNYkcyNlVUMVNBR01tZUZzbEhGVjMvd2ZYQVJnTWNi?=
 =?utf-8?B?Y3NnVWp2eTlITVVRRjFmK1N5RVV1OCs1Slo4WVJmMjV3ODNvSzBCNlJvYWNj?=
 =?utf-8?B?UCt5R2RpOGF1UHVJeFR2TW5DR3JzYW1ES3pod1E0U3NDTDI2WVViWGlleUZr?=
 =?utf-8?B?TUdvbm5xQWVmRTVKd1U2UDRkR1hXZTNkeTlveHdwYXRHWHEyRVFUVFZPSU55?=
 =?utf-8?B?c1YyYmtObUtvZ25BUzlQWnNONndoWGNMQmxLTjVtZ2YxMnV6UVdwRExSS0E3?=
 =?utf-8?B?RWlTSzhVSWpRSDFVMnVpbkJ2c3RUVS9rUzhyYitXRDd5cFBHYzg2WHh4ajRt?=
 =?utf-8?B?TTlWV1E3dlJ5aXlFRWlBb3cvc3VmZkY5c1FRenhsN3lLMUtMWXNnZ202MHBC?=
 =?utf-8?B?MW9zWHV2Q0dIRnpDNkJ5UGJ6OHpGd2RJUi8yaldMdjlhWHhSeGJ6eEdhK210?=
 =?utf-8?B?aWZ4T1p0aWcrUGZoM1FGMERRYlVlVTJjTUFtT1BFL2ZvQStxMlZqeGVSNEJp?=
 =?utf-8?B?STMxZDNMaEhud2ZyVDE3Mzl3VWVrOFFGaHUxK1J0UFN1RlgrM0NsWDJZM3NQ?=
 =?utf-8?B?Y1NueVFPSVdKQmUwNFpNMG1sMkk2U3lYWC9XeHZGeDdHaEU0QjRaeGtvWDJY?=
 =?utf-8?B?a1Baak9vS2F6WGRtYmVEMHBCaThFYkpVRmt6Ris5Z3Iwa0xHOVdkQWNyR2hU?=
 =?utf-8?B?OXJCS050bG1KQ0t0MmZjbGZFVFJKdDlDWjl5TGJLdTh4bGkvWjR1dzF0SGdz?=
 =?utf-8?Q?DGw3jzgusWKyu263AW1ciDVagba/RHoB1x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a2d398-bfe3-44b0-4eda-08d89556541b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 17:35:28.9770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZ4++eCRjQ1ZXWchqAXKK2StjyIgmgIT8OKvyX6NVlhkLuMXynoKHft/UrQnlI/tQeSCg08Yw2sbXvg2FvyZLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3695
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Gui,
 Jack" <Jack.Gui@amd.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TGlrZSBJIHN0YXRlZCBlbHNld2hlcmUsIEkgd291bGQgcmVjb21tZW5kIG5vcmV0cnk9MCBmb3Ig
TmF2aSBhbmQgbGF0ZXIKR1BVcyBiZWNhdXNlIHRoZXJlIGlzIG5vIHBlcmZvcm1hbmNlIGFkdmFu
dGFnZSBmcm9tIGRpc2FibGluZyByZXRyeSBvbgp0aG9zZSBHUFVzLgoKClJlZ2FyZHMsCsKgIEZl
bGl4CgoKQW0gMjAyMC0xMS0zMCB1bSAxMjoyMiBwLm0uIHNjaHJpZWIgRGV1Y2hlciwgQWxleGFu
ZGVyOgo+Cj4gW0FNRCBQdWJsaWMgVXNlXQo+Cj4KPiBXZSBuZWVkIHRvIGZpZ3VyZSBvdXQgd2hh
dCB0aGUgcm9vdCBjYXVzZSBpcyB0aGVuLsKgIElmIHdlIGNhbid0IGZpZ3VyZQo+IGl0IG91dCBz
b29uLCB3ZSBzaG91bGQgcmV2ZXJ0IHRoZSBjaGFuZ2UgZm9yIG5hdmkxeCBhbmQgY29udGludWUg
dG8KPiBkZWJ1ZyBpdCB1bnRpbCB3ZSBjYW4gZmluZCB0aGUgcm9vdCBjYXVzZSBhbmQgd2UgY2Fu
IHNhZmVseSByZS1lbmFibGUgaXQuCj4KPiBBbGV4Cj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gKkZyb206
KiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+Cj4gKlNlbnQ6KiBTdW5kYXksIE5v
dmVtYmVyIDI5LCAyMDIwIDI6MjIgQU0KPiAqVG86KiBCYXMgTmlldXdlbmh1aXplbiA8YmFzQGJh
c25pZXV3ZW5odWl6ZW4ubmw+OyBLdWVobGluZywgRmVsaXgKPiA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4KPiAqQ2M6KiBHdWksIEphY2sgPEphY2suR3VpQGFtZC5jb20+OyBaaG91MSwgVGFvIDxU
YW8uWmhvdTFAYW1kLmNvbT47Cj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QgPGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPjsgSHVhbmcsIFJheQo+IDxSYXkuSHVhbmdAYW1kLmNvbT47IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47Cj4gWmhhbmcsIEhhd2tp
bmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KPiAqU3ViamVjdDoqIFJFOiBbUEFUQ0ggdjNdIGRy
bS9hbWQvYW1kZ3B1OiBzZXQgdGhlIGRlZmF1bHQgdmFsdWUgb2YKPiBub3JldHJ5IHRvIDEgZm9y
IHNvbWUgZEdQVXMKPiDCoAo+IFtBTUQgUHVibGljIFVzZV0KPgo+IEhpIEJhcyBOaWV1d2VuaHVp
emVuLAo+Cj4gSSBkb24ndCB0aGluayBkaXJlY3QgcmV2ZXJ0IGlzIG9uZSByaWdodCBhcHByb2Fj
aCwgdGhvdWdoIGl0J3MgYWJsZSB0bwo+IGZpeCB5b3VyIHByb2JsZW0uwqAgbm9yZXRyeT0wIHdp
bGwgY2F1c2Ugb3RoZXIgdGVzdCBmYWlsdXJlIG9uIHNldmVyYWwKPiBBU0lDcy4KPgo+IFJlZ2Fy
ZHMsCj4gR3VjaHVuCj4KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IGFtZC1n
ZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBC
YXMKPiBOaWV1d2VuaHVpemVuCj4gU2VudDogU3VuZGF5LCBOb3ZlbWJlciAyOSwgMjAyMCA4OjM4
IEFNCj4gVG86IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPiBDYzog
R3VpLCBKYWNrIDxKYWNrLkd1aUBhbWQuY29tPjsgQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBh
bWQuY29tPjsKPiBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IGFtZC1nZnggbWFpbGlu
ZyBsaXN0Cj4gPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgSHVhbmcsIFJheSA8UmF5
Lkh1YW5nQGFtZC5jb20+Owo+IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT47IFpoYW5nLCBIYXdraW5nCj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYzXSBkcm0vYW1kL2FtZGdwdTogc2V0IHRoZSBkZWZhdWx0IHZhbHVl
IG9mCj4gbm9yZXRyeSB0byAxIGZvciBzb21lIGRHUFVzCj4KPiBDYW4gd2UgcmV2ZXJ0IHRoaXMg
cGF0Y2ggdG8gZml4Cj4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9p
c3N1ZXMvMTM3NCA/Cj4KPiBPbiBUaHUsIE9jdCAxNSwgMjAyMCBhdCA0OjMwIFBNIEZlbGl4IEt1
ZWhsaW5nCj4gPGZlbGl4Lmt1ZWhsaW5nQGFtZC5jb20+IHdyb3RlOgo+ID4KPiA+IEFtIDIwMjAt
MTAtMTQgdW0gMTE6MzUgcC5tLiBzY2hyaWViIENoZW5nbWluZyBHdWk6Cj4gPiA+IG5vcmV0cnkg
PSAwIGNhdXNlIHNvbWUgZEdQVSdzIGtmZCBwYWdlIGZhdWx0IHRlc3RzIGZhaWwsIHNvIHNldAo+
ID4gPiBub3JldHJ5IHRvIDEgZm9yIHRoZXNlIHNwZWNpYWwgQVNJQ3M6Cj4gPiA+IHZlZ2EyMC9u
YXZpMTAvbmF2aTE0L0FSQ1RVUlVTCj4gPiA+Cj4gPiA+IHYyOiBtZXJnZSByYXZlbiBhbmQgZGVm
YXVsdCBjYXNlIGR1ZSB0byB0aGUgc2FtZSBzZXR0aW5nCj4gPiA+IHYzOiByZW1vdmUgQVJDVFVS
VVMKPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2hlbmdtaW5nIEd1aSA8SmFjay5HdWlAYW1k
LmNvbT4KPiA+ID4gQ2hhbmdlLUlkOiBJM2JlNzBmNDYzYTQ5YjBjZDVjNTY0NTY0MzFkNmMyY2I5
OGIxMzg3Mgo+ID4KPiA+IEFja2VkLWJ5OiBGZWxpeCBLdWhsaW5nIDxGZWxpeC5LdWVobGluZ0Bh
bWQuY29tPgo+ID4KPiA+Cj4gPiA+IC0tLQo+ID4gPsKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nbWMuYyB8IDIzCj4gPiA+ICsrKysrKysrKysrKysrKy0tLS0tLS0tCj4gPiA+
wqAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4gPiA+
Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21j
LmMKPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKPiA+ID4g
aW5kZXggMzY2MDRkNzUxZDYyLi5mMjZlYjRlNTRiMTIgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+ID4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKPiA+ID4gQEAgLTQyNSwyMCArNDI1LDI3IEBA
IHZvaWQgYW1kZ3B1X2dtY19ub3JldHJ5X3NldChzdHJ1Y3QKPiBhbWRncHVfZGV2aWNlICphZGV2
KQo+ID4gPsKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2dtYyAqZ21jID0gJmFkZXYtPmdtYzsK
PiA+ID4KPiA+ID7CoMKgwqDCoMKgwqAgc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKPiA+ID4g
LcKgwqDCoMKgIGNhc2UgQ0hJUF9SQVZFTjoKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAvKiBSYXZlbiBjdXJyZW50bHkgaGFzIGlzc3VlcyB3aXRoIG5vcmV0cnkKPiA+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICogcmVnYXJkbGVzcyBvZiB3aGF0IHdlIGRlY2lkZSBmb3Ig
b3RoZXIKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogYXNpY3MsIHdlIHNob3Vs
ZCBsZWF2ZSByYXZlbiB3aXRoCj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIG5v
cmV0cnkgPSAwIHVudGlsIHdlIHJvb3QgY2F1c2UgdGhlCj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqIGlzc3Vlcy4KPiA+ID4gK8KgwqDCoMKgIGNhc2UgQ0hJUF9WRUdBMjA6Cj4g
PiA+ICvCoMKgwqDCoCBjYXNlIENISVBfTkFWSTEwOgo+ID4gPiArwqDCoMKgwqAgY2FzZSBDSElQ
X05BVkkxNDoKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBub3JldHJ5ID0gMCB3aWxsIGNhdXNlIGtmZCBwYWdlIGZh
dWx0IHRlc3RzIGZhaWwKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogZm9yIHNv
bWUgQVNJQ3MsIHNvIHNldCBkZWZhdWx0IHRvIDEgZm9yIHRoZXNlIEFTSUNzLgo+ID4gPsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKGFtZGdwdV9ub3JldHJ5ID09IC0xKQo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnbWMtPm5vcmV0cnkgPSAwOwo+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnbWMtPm5vcmV0cnkgPSAxOwo+ID4gPsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZQo+ID4gPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdtYy0+bm9yZXRyeSA9IGFtZGdwdV9ub3JldHJ5Owo+
ID4gPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiA+ICvCoMKgwqDCoCBj
YXNlIENISVBfUkFWRU46Cj4gPiA+wqDCoMKgwqDCoMKgIGRlZmF1bHQ6Cj4gPiA+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLyogZGVmYXVsdCB0aGlzIHRvIDAgZm9yIG5vdywgYnV0IHdlIG1h
eSB3YW50Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogUmF2ZW4gY3VycmVudGx5
IGhhcyBpc3N1ZXMgd2l0aCBub3JldHJ5Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqIHJlZ2FyZGxlc3Mgb2Ygd2hhdCB3ZSBkZWNpZGUgZm9yIG90aGVyCj4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqIGFzaWNzLCB3ZSBzaG91bGQgbGVhdmUgcmF2ZW4gd2l0aAo+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBub3JldHJ5ID0gMCB1bnRpbCB3ZSBy
b290IGNhdXNlIHRoZQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpc3N1ZXMu
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqIGRlZmF1bHQgdGhpcyB0byAwIGZvciBub3csIGJ1dCB3ZSBtYXkgd2Fu
dAo+ID4gPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHRvIGNoYW5nZSB0aGlzIGlu
IHRoZSBmdXR1cmUgZm9yIGNlcnRhaW4KPiA+ID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKiBHUFVzIGFzIGl0IGNhbiBpbmNyZWFzZSBwZXJmb3JtYW5jZSBpbgo+ID4gPsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGNlcnRhaW4gY2FzZXMuCj4gPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4gYW1kLWdmeCBtYWlsaW5nIGxp
c3QKPiA+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPiBodHRwczovL2xpc3QvIDxo
dHRwczovL2xpc3Q+Cj4gPiBzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUy
RmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q2d1Cj4gPiBjaHVuLmNoZW4lNDBhbWQuY29tJTdD
NmQ2MjZlMmEzYmFlNDg3NzAyNGYwOGQ4OTNmZjE1ZGIlN0MzZGQ4OTYxZmU0ODg0Cj4gPiBlNjA4
ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc0MjIwNzEwODU4MDA0NzYlN0NVbmtub3duJTdD
VFdGcGJHWnNiCj4gPiAzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pC
VGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlCj4gPiA3QzEwMDAmYW1wO3NkYXRhPVZGcWVnR3dQ
Q2oxMHEzWTVCZFpzVnEyYSUyQjRUYjM1OG1ZVkRhTmtBOXpMVSUzRCZhbXA7Cj4gPiByZXNlcnZl
ZD0wCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
