Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC95C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 14:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA6B64FE5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 14:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA6B64FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 898CC6EA1C;
	Wed, 10 Mar 2021 14:06:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC21A6EA1C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 14:05:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LscaCYtyhtDWJa+ieH480EJBkdcyzWOdfScpdZCvt/ETuLm/pSlASqZSaXx+b6mp3u3NWueOeAnraTLaQMp4C2dleJRhs8zibd3MpAZHed40zczIO+RL5SFQ8E4mzKCrbKQ1faZqJIS3Rk2hd29eDU1hWuelTWkHuuFowAkHK5C8cfLL8HK4oGg4xnfLY2OFWYLN29ruDZzzqNBXYaxX1eelv7vNyGHOIQMzOPrpBceO3dsZzRj0Y/Fxr7RSOJIO/Fct5tV7EcruBxasoyFzO8NtmqfxURkhcnBgF51ASURi9ge0iLBRdElcenHCgsNUvt6+bDTCq8kaYI87zpu50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hqwETmrEL5H1cqUNOvkqz601H0SRx7RYhl5gv+Ngag=;
 b=UgyS+c9s5y6ZBlLb/WKTCsMFMrhva3HVSSsQCYOMS8Zt/Y3stt999nlWfdXs0aZXI59eShPtW1sjtQ/JTCHrLGUr1pwYxfV+8JsKc6nQGxmAy8svMsPV8iNOb7Fs3KtAuVqaodD031okC+17FPo/M1OXp+NowO54M47CinOsEFOfJJPjmBSGNVaZNWPmMY7eEIiE38wB3ePzH3N8T7pfCw+bfWmiLCxgyLT0WHvKhwZeU6xuP95LCdYd+g6JOcWJvd9PKrWuJM9FdS50gAsI5oDt3eDvTSJYV8crma9an9+DXzEgEoOH4VjFOQkOSKcAQPuzZZcQ1ke0YiWB6v3+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hqwETmrEL5H1cqUNOvkqz601H0SRx7RYhl5gv+Ngag=;
 b=mwaH2KkHg74fr6BOMRZAWrUF7yp1pGZVkDsMhhTmSqSqykkmQkaxwLGU/qRGb6sKBoQpNjkszDouuvrjn3WIrzQFz4AUKFjY4wT9sbVtdRZlWmha6j+el5EGc/pBNgMGR65zO4jJq8eJKyiAPiqqiSnJbSHpNs00Fz6UL1clW48=
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 by DM5PR12MB2581.namprd12.prod.outlook.com (2603:10b6:4:b2::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.30; Wed, 10 Mar
 2021 14:05:55 +0000
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::28e0:5877:b4e6:6bdc]) by DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::28e0:5877:b4e6:6bdc%9]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 14:05:55 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Liu, Monk"
 <Monk.Liu@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH v4] drm/amd/amdgpu implement tdr advanced mode
Thread-Topic: [PATCH v4] drm/amd/amdgpu implement tdr advanced mode
Thread-Index: AQHXFZ9BggKFBBQx4ku18DddIDGpRap9LeKAgAALQKOAAAQcAIAAAk07
Date: Wed, 10 Mar 2021 14:05:55 +0000
Message-ID: <DM5PR1201MB0204120DC4A44A5A32196901BB919@DM5PR1201MB0204.namprd12.prod.outlook.com>
References: <20210310111921.928619-1-Jack.Zhang1@amd.com>
 <70e3aabc-6bb0-b88c-0e97-de42e1e8b8e6@amd.com>
 <DM5PR1201MB02044274BD6BB85B3828074FBB919@DM5PR1201MB0204.namprd12.prod.outlook.com>,
 <59f47063-0d33-ff9c-b91e-fdd85baf5eac@amd.com>
In-Reply-To: <59f47063-0d33-ff9c-b91e-fdd85baf5eac@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-10T13:58:05.4809230Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.246.140.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2edc924-1e7a-40e0-a0f8-08d8e3cd9f4c
x-ms-traffictypediagnostic: DM5PR12MB2581:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB25810299AF7F09727283BFD6BB919@DM5PR12MB2581.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WSopHRDfCckWNvbpfJUm3wCbWAkxGW8Rvf6rwSpLQ7cfpe4S8kl0igwMtueCLffG+bfq5PvbNORMka6rz7EG2jgmD+FHoKMfnCE34P/1k8zVi1QMwKGc+Me1oSewQPtjFRjj+YO1IskxK/ug7GNbkPRydE74gMlNNv8sQ1OgZKBP0nK2WiGFGhwPddRfmLQlumfIw7KNAg61tor0LXj6pOeHPokF+QFCpkrdH38RdM+qNq50ZzTlpXAIjxT51wfXJbL9r1nhyFlseJF2B9Mpmq4+GXMGe/oi8hjKQVjMglDjLQBVM3dTtWOnvXPY9aAEuD7CHKLJwgqpsEQYjdFGAXHKCl764ujQGefwv0bRHldaq+FJjh8sdv5zm9K9ak85d5MvcfkjSeIPtvBwrSrb5Mjize2RRL8i/KOhZYTy//91YrbkcZ3OSjsCBkKOojqNGo8dRigYURw9+6lA1JgOG+pUTlgL3MXk4xOAD3w/bPRTg8OdM5flR8b90Hw/yBe7HraELqZZuvr2atIpPAmblA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0204.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(5660300002)(53546011)(6636002)(7696005)(6506007)(2906002)(52536014)(83380400001)(110136005)(316002)(30864003)(9686003)(55016002)(86362001)(66476007)(64756008)(76116006)(26005)(66556008)(66446008)(91956017)(33656002)(478600001)(66946007)(186003)(8936002)(71200400001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?gb2312?B?cVp0SlU4RTBGODVZMytBVjVsaFJ0R0RjSUNyKzRqQ1l3VmJkOUNaK25xRDFq?=
 =?gb2312?B?RmJhVnQ3QytyRjFlZTdBcnRwaUlqM2QxdnMxbFR3VkRyNGIzT1NEcFRYSWFF?=
 =?gb2312?B?Z3VBM28zWHJINWNMbWtPaXNkSlNBeG9rTGlCL3hnU2MvNHlNb0hVcDE5OTlQ?=
 =?gb2312?B?VnlkYzBlcytQODh2bVJoUjFmbzFYLzFXRFh0V0R5RzNzK0p6WVJGdmlQY0Rz?=
 =?gb2312?B?L0FvN3ZZbmxHS09XYUdxYWZDVloxYXFDZEhOd01JQWxkcllsSEp4Wm15SWF6?=
 =?gb2312?B?MVRMYSt2M1Y1M0xBcXpCdktpeXdMQUJQb01qSTJKR1pSMW1QTlNmNjBta1N6?=
 =?gb2312?B?S20yQTRlZVJRRER3MG9CNGtzR2hJTGViRHdrdEU0VUkrYlpXVGVhN1ZrRWx5?=
 =?gb2312?B?TjQyWCtOUmp5bXBJdE5RUXZONEN1N2xvRFJNSWJtVXZxK2VlVjZXMzIzL0dX?=
 =?gb2312?B?K3FpaThSRnpUODNlaHlUTW1iR2o2Z1hhWE0zQ24yN3ZnbUwwbDJQSjhIMUJw?=
 =?gb2312?B?bW95aWJLWCtOU1FuczFrK3FQTkVKMFk5Wm55bXI5SU1tMGFoRkJXdHFsQVVU?=
 =?gb2312?B?Yzl5NjEzZWVtYjZ3cDBpUjdWMURCLzhqblcwMTVZRERBdXV0dTd4VHhnQytL?=
 =?gb2312?B?ZDZESHc2cFgwY3NvbFZzUXdNVFR1aWM1VXRlZjhzanlJMjk5amtyeDlDbjNp?=
 =?gb2312?B?citYdDVSRFJlVUJ2UWRtZDB2c2Z6dEV6ais4bkpFK0ZXcTRUK1F4UGN4SmhZ?=
 =?gb2312?B?dXprVEdpbjR1NmRYeFZ6RWV5MnR0bExQekZPbnR3a1o4cUxITlUyVGc3dWQr?=
 =?gb2312?B?V2dqU2RzUWZ6YStrQ0tEb01tek1KOUl2YVFaZ1MyWWNiU2ZZbS9jU1lCMkgr?=
 =?gb2312?B?NDNtOFFpZ0Q0M1ZNcDMyL2xieVNjQzBQVFVScnFvZ3hjc2JibWdjNG9BVWxC?=
 =?gb2312?B?MENteDlOSG1mb2hPMnNzM1RNalNQZWZIWlJ0ZHc5Uysrckc5ZzBVSmgwVDEy?=
 =?gb2312?B?Rld1NEZsUmZxTUhRa2c2S1B4SFJ0cHorQWR4MmdnL0duaVhqU0JwY3l4YXp3?=
 =?gb2312?B?enk1ZVd6TmJOU0tUbW1qeU4xRWtVQzBUV3lqRXZ3eXNxQ3BrTjhMWEtkQkhv?=
 =?gb2312?B?USs1OWhWUjFKditOUngxMmZQcWFiRnBwbXpJdGVrRHRQV3lIVGkvOTRYQy9w?=
 =?gb2312?B?bkRHd3kzU3ppMEd1S2J5dnU5V2hFL1hSTy95eUM5eGhqUWIyNGN5SUJwK3Nr?=
 =?gb2312?B?VEx6OUVVU054QzdROWtqSHVlME0wQkNleTNYSDRKU3h4SzRDZ3hEbXVTTkp6?=
 =?gb2312?B?Mjh6K3lIM1lZa0RuWWFiQ0NoUGpoUU4zZjdXSkxwQ0xtd3pHKzZqV2l2eHZD?=
 =?gb2312?B?Ylc1RkVxaFZrN1owem9JWmJRL1dmbjZ5OWluNjBteGZXb2VGMHZGVTVFTXF1?=
 =?gb2312?B?VjNjVXRqVzJBa3pnbytmMTk2SnFSMHZGMUxsOGIvZE5Dd0tpODFvVnZZcTkw?=
 =?gb2312?B?RmFZRVIxVXI3Q2Qvc3poOTJpMlN5bXBnNzdCSHg4Q20rUDN5djVub2QxTE5L?=
 =?gb2312?B?Z2hDQjMvV0pLV2p6SUJpblNQZTBXSmNKU0U4blpzNXJJaGlobmRoZkRLUHRR?=
 =?gb2312?B?VXNUSnphdHk2NkdNaGZEMGNNQ0Y5NlB6WEJBZGJNeU1aaWVsTnFkVU1TemZK?=
 =?gb2312?B?Z0hYNDk4c0RoOEU0Sk4vSnNkbWFoTGJFUTVMNUJZNDlhS3V2OEtjS2ZZZ1dk?=
 =?gb2312?B?a0h3d1ZjbEpmM0w1QkNuZ3VyajJqdFFNQ1ZOZEJ3bjRMR3hjVWtVVWxnb2pv?=
 =?gb2312?B?N2cwUE92U2p5NHFuRVpVUT09?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0204.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2edc924-1e7a-40e0-a0f8-08d8e3cd9f4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 14:05:55.1436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GxpEjm2Y8kvuuNZKBjpSdlHMbi3v6EgnBDxtqdyCU0KLNeMoCYshPYrrLwbcRjOn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2581
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
Content-Type: multipart/mixed; boundary="===============1720370410=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1720370410==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_DM5PR1201MB0204120DC4A44A5A32196901BB919DM5PR1201MB0204_"

--_000_DM5PR1201MB0204120DC4A44A5A32196901BB919DM5PR1201MB0204_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoN
CkFzIE1vbmsgcHJldmlvdXNseSBleHBsYWluZWQgaW4gYW5vdGhlciBtYWlsIHNlc3Npb24uIEJl
Y2F1c2UgdGhlIGRybV9zY2hlZF9yZXN1Ym1pdF9qb2JzIHN1Ym1pdCBhbGwgam9icyB3aGljaCBk
b2VzIG5vdCBtZWV0IG91ciBuZWVkcy4NCg0KV2UgbmVlZCBhIG5ldyBBUGkgIGRybV9zY2hlZF9y
ZXN1Ym1pdF9qb2JzMigpDQp0byBzdWJtaXQgdGhlIGZpcnN0IGpvYiBvZiBhIHJpbmcuIChhbHNv
IHdlIGNhbiBsZXZlcmFnZSB0aGUgZXJyb3IgaGFuZGxpbmcgZm9yIE51bGwgb3IgRXJyb3IgZmVu
Y2UgaW5zaWRlIHRoaXMgZnVuY3Rpb24gKS4NCg0KSXQgc2VlbXMgY2xlYW4gdG8gdXNlIHRoaXMg
am9iczIgZnVuY3Rpb24gdGhhbiB3cml0aW5nIHRoZSBydW5fam9iICsgc29tZSBlcnJvciBoYW5k
bGluZyBpbiB0aGUgbWFpbiBsb2dpYy4NCg0KDQpUaGFua3OjrA0KL0phY2sNCg0KDQoNCg0KDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0Kt6LLzcqxvOQ6IDIwMjHE6jPUwjEwyNXQx8ba
yP0gz8LO5zk6NDkNCsrVvP7IyzogWmhhbmcsIEphY2sgKEppYW4pOyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgR3JvZHpvdnNreSwgQW5kcmV5OyBMaXUsIE1vbms7IERlbmcsIEVtaWx5
DQrW98ziOiBSZTogW1BBVENIIHY0XSBkcm0vYW1kL2FtZGdwdSBpbXBsZW1lbnQgdGRyIGFkdmFu
Y2VkIG1vZGUNCg0KQW5kcmV5IG5lZWRzIHRvIHJldmlldyB0aGUgcmVzdGUsIGJ1dCBlc3NlbnRp
YWxseSBJIGRvbid0IHNlZSB0aGUgcmVhc29uIHdoeSB5b3UgbmVlZCB0aGlzIGRybV9zY2hlZF9y
ZXN1Ym1pdF9qb2JzMigpLg0KDQpDaHJpc3RpYW4uDQoNCkFtIDEwLjAzLjIxIHVtIDE0OjM2IHNj
aHJpZWIgWmhhbmcsIEphY2sgKEppYW4pOg0KDQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50
ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQoNClRoYW5rcyBDaHJpc3RpYW6jrCBqdXN0IGRpZCB0
aGUgY2hlY2twYXRjaCBzY2FuLiAgUGxlYXNlIHNlZSB0aGUgVjYgcGF0Y2gNCg0KL0phY2sNCg0K
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTogS29lbmlnLCBDaHJpc3Rp
YW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT48bWFpbHRvOkNocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NClNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTAsIDIwMjEgODo1NDo1MyBQTQ0KVG86IFpo
YW5nLCBKYWNrIChKaWFuKSA8SmFjay5aaGFuZzFAYW1kLmNvbT48bWFpbHRvOkphY2suWmhhbmcx
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc+IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz48bWFp
bHRvOmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgR3JvZHpvdnNreSwgQW5kcmV5IDxB
bmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPjxtYWlsdG86QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNv
bT47IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT48bWFpbHRvOk1vbmsuTGl1QGFtZC5jb20+
OyBEZW5nLCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPjxtYWlsdG86RW1pbHkuRGVuZ0BhbWQu
Y29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2NF0gZHJtL2FtZC9hbWRncHUgaW1wbGVtZW50IHRk
ciBhZHZhbmNlZCBtb2RlDQoNCkFtIDEwLjAzLjIxIHVtIDEyOjE5IHNjaHJpZWIgSmFjayBaaGFu
ZzoNCj4gW1doeV0NCj4gUHJldmlvdXMgdGRyIGRlc2lnbiB0cmVhdHMgdGhlIGZpcnN0IGpvYiBp
biBqb2JfdGltZW91dCBhcyB0aGUgYmFkIGpvYi4NCj4gQnV0IHNvbWV0aW1lcyBhIGxhdGVyIGJh
ZCBjb21wdXRlIGpvYiBjYW4gYmxvY2sgYSBnb29kIGdmeCBqb2IgYW5kDQo+IGNhdXNlIGFuIHVu
ZXhwZWN0ZWQgZ2Z4IGpvYiB0aW1lb3V0IGJlY2F1c2UgZ2Z4IGFuZCBjb21wdXRlIHJpbmcgc2hh
cmUNCj4gaW50ZXJuYWwgR0MgSFcgbXV0dWFsbHkuDQo+DQo+IFtIb3ddDQo+IFRoaXMgcGF0Y2gg
aW1wbGVtZW50cyBhbiBhZHZhbmNlZCB0ZHIgbW9kZS5JdCBpbnZvbHZlcyBhbiBhZGRpdGluYWwN
Cj4gc3luY2hyb25vdXMgcHJlLXJlc3VibWl0IHN0ZXAoU3RlcDAgUmVzdWJtaXQpIGJlZm9yZSBu
b3JtYWwgcmVzdWJtaXQNCj4gc3RlcCBpbiBvcmRlciB0byBmaW5kIHRoZSByZWFsIGJhZCBqb2Iu
DQo+DQo+IDEuIEF0IFN0ZXAwIFJlc3VibWl0IHN0YWdlLCBpdCBzeW5jaHJvbm91c2x5IHN1Ym1p
dHMgYW5kIHBlbmRzIGZvciB0aGUNCj4gZmlyc3Qgam9iIGJlaW5nIHNpZ25hbGVkLiBJZiBpdCBn
ZXRzIHRpbWVvdXQsIHdlIGlkZW50aWZ5IGl0IGFzIGd1aWx0eQ0KPiBhbmQgZG8gaHcgcmVzZXQu
IEFmdGVyIHRoYXQsIHdlIHdvdWxkIGRvIHRoZSBub3JtYWwgcmVzdWJtaXQgc3RlcCB0bw0KPiBy
ZXN1Ym1pdCBsZWZ0IGpvYnMuDQo+DQo+IDIuIFJlLWluc2VydCBCYWlsaW5nIGpvYiB0byBtaXJy
b3JfbGlzdCwgYW5kIGxlYXZlIGl0IHRvIGJlIGhhbmRsZWQgYnkNCj4gdGhlIG1haW4gcmVzZXQg
dGhyZWFkLg0KPg0KPiAzLiBGb3Igd2hvbGUgZ3B1IHJlc2V0KHZyYW0gbG9zdCksIGRvIHJlc3Vi
bWl0IGFzIHRoZSBvbGQgd2F5Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNrIFpoYW5nIDxKYWNr
LlpoYW5nMUBhbWQuY29tPjxtYWlsdG86SmFjay5aaGFuZzFAYW1kLmNvbT4NCj4gQ2hhbmdlLUlk
OiBJNDA4MzU3ZjEwYjkwMzRjYWFhMWI4MzYxMGUxOWU1MTRjNWZiYWFmMg0KPiAtLS0NCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA3MyArKysrKysrKysr
KysrKysrKysrKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMg
ICAgfCAgMiArLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jICAg
ICB8IDc1ICsrKysrKysrKysrKysrKysrKysrKysNCj4gICBpbmNsdWRlL2RybS9ncHVfc2NoZWR1
bGVyLmggICAgICAgICAgICAgICAgfCAgMiArDQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxNDggaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBpbmRleCBlMjQ3YzNhMmVjMDguLjAyMDU2MzU1YTA1NSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBA
QCAtNDYzOSw3ICs0NjM5LDcgQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgICBpbnQgaSwgciA9IDA7DQo+ICAgICAgICBi
b29sIG5lZWRfZW1lcmdlbmN5X3Jlc3RhcnQgPSBmYWxzZTsNCj4gICAgICAgIGJvb2wgYXVkaW9f
c3VzcGVuZGVkID0gZmFsc2U7DQo+IC0NCj4gKyAgICAgaW50ICAgICB0bXBfdnJhbV9sb3N0X2Nv
dW50ZXI7DQoNClBsZWFzZSBrZWVwIHRoZSBlbXBvdHkgbGluZSBiZXR3ZWVuIGRlY2xhcmF0aW9u
IGFuZCBjb2RlLg0KDQpJbiBnZW5lcmFsIGdpdmUgdGhhdCBwYXRjaCBhIHBhc3Mgd2l0aCBjaGVj
a3BhdGgucGwgc2luY2UgdGhlcmUgYXJlIGENCmNvdXBsZSBvZiBvdGhlciBwbGFjZSB3aGljaCBu
ZWVkcyBmaXhpbmcgYXQgZmlyc3QgZ2xhbmNlLg0KDQpDaHJpc3RpYW4uDQoNCg0KPiAgICAgICAg
LyoNCj4gICAgICAgICAqIFNwZWNpYWwgY2FzZTogUkFTIHRyaWdnZXJlZCBhbmQgZnVsbCByZXNl
dCBpc24ndCBzdXBwb3J0ZWQNCj4gICAgICAgICAqLw0KPiBAQCAtNDY4OSw5ICs0Njg5LDE0IEBA
IGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LA0KPiAgICAgICAgICAgICAgICBkZXZfaW5mbyhhZGV2LT5kZXYsICJCYWlsaW5nIG9uIFREUiBm
b3Igc19qb2I6JWxseCwgYXMgYW5vdGhlciBhbHJlYWR5IGluIHByb2dyZXNzIiwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgam9iID8gam9iLT5iYXNlLmlkIDogLTEp
Ow0KPg0KPiAtICAgICAgICAgICAgIC8qIGV2ZW4gd2Ugc2tpcHBlZCB0aGlzIHJlc2V0LCBzdGls
bCBuZWVkIHRvIHNldCB0aGUgam9iIHRvIGd1aWx0eSAqLw0KPiAtICAgICAgICAgICAgIGlmIChq
b2IpDQo+ICsgICAgICAgICAgICAgaWYgKGpvYikgew0KPiArICAgICAgICAgICAgICAgICAgICAg
LyogcmUtaW5zZXJ0IG5vZGUgdG8gYXZvaWQgbWVtb3J5IGxlYWsgKi8NCj4gKyAgICAgICAgICAg
ICAgICAgICAgIHNwaW5fbG9jaygmam9iLT5iYXNlLnNjaGVkLT5qb2JfbGlzdF9sb2NrKTsNCj4g
KyAgICAgICAgICAgICAgICAgICAgIGxpc3RfYWRkKCZqb2ItPmJhc2Uubm9kZSwgJmpvYi0+YmFz
ZS5zY2hlZC0+cGVuZGluZ19saXN0KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgIHNwaW5fdW5s
b2NrKCZqb2ItPmJhc2Uuc2NoZWQtPmpvYl9saXN0X2xvY2spOw0KPiArICAgICAgICAgICAgICAg
ICAgICAgLyogZXZlbiB3ZSBza2lwcGVkIHRoaXMgcmVzZXQsIHN0aWxsIG5lZWQgdG8gc2V0IHRo
ZSBqb2IgdG8gZ3VpbHR5ICovDQo+ICAgICAgICAgICAgICAgICAgICAgICAgZHJtX3NjaGVkX2lu
Y3JlYXNlX2thcm1hKCZqb2ItPmJhc2UpOw0KPiArICAgICAgICAgICAgIH0NCj4gICAgICAgICAg
ICAgICAgZ290byBza2lwX3JlY292ZXJ5Ow0KPiAgICAgICAgfQ0KPg0KPiBAQCAtNDc4OCw2ICs0
NzkzLDcgQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsDQo+ICAgICAgICAgICAgICAgIH0NCj4gICAgICAgIH0NCj4NCj4gKyAgICAgdG1w
X3ZyYW1fbG9zdF9jb3VudGVyID0gYXRvbWljX3JlYWQoJigoYWRldiktPnZyYW1fbG9zdF9jb3Vu
dGVyKSk7DQo+ICAgICAgICAvKiBBY3R1YWwgQVNJQyByZXNldHMgaWYgbmVlZGVkLiovDQo+ICAg
ICAgICAvKiBUT0RPIEltcGxlbWVudCBYR01JIGhpdmUgcmVzZXQgbG9naWMgZm9yIFNSSU9WICov
DQo+ICAgICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7DQo+IEBAIC00ODA1LDYgKzQ4
MTEsNjcgQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsDQo+ICAgICAgICAvKiBQb3N0IEFTSUMgcmVzZXQgZm9yIGFsbCBkZXZzIC4qLw0K
PiAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeSh0bXBfYWRldiwgZGV2aWNlX2xpc3RfaGFuZGxl
LCBnbWMueGdtaS5oZWFkKSB7DQo+DQo+ICsgICAgICAgICAgICAgaWYgKGFtZGdwdV9ncHVfcmVj
b3ZlcnkgPT0gMiAmJg0KPiArICAgICAgICAgICAgICAgICAgICAgISh0bXBfdnJhbV9sb3N0X2Nv
dW50ZXIgPCBhdG9taWNfcmVhZCgmYWRldi0+dnJhbV9sb3N0X2NvdW50ZXIpKSkgew0KPiArDQo+
ICsgICAgICAgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX01BWF9SSU5HUzsg
KytpKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfcmlu
ZyAqcmluZyA9IHRtcF9hZGV2LT5yaW5nc1tpXTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW50IHJldCA9IDA7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBkcm1fc2NoZWRfam9iICpzX2pvYjsNCj4gKw0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpZiAoIXJpbmcgfHwgIXJpbmctPnNjaGVkLnRocmVhZCkNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gKw0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAvKiBObyBwb2ludCB0byByZXN1Ym1pdCBqb2JzIGlmIHdlIGRpZG4ndCBI
VyByZXNldCovDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICghdG1wX2FkZXYt
PmFzaWNfcmVzZXRfcmVzICYmICFqb2Jfc2lnbmFsZWQpIHsNCj4gKw0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHNfam9iID0gbGlzdF9maXJzdF9lbnRyeV9vcl9udWxs
KCZyaW5nLT5zY2hlZC5wZW5kaW5nX2xpc3QsIHN0cnVjdCBkcm1fc2NoZWRfam9iLCBsaXN0KTsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoc19qb2IgPT0gTlVM
TCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRp
bnVlOw0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogY2xl
YXIgam9iJ3MgZ3VpbHR5IGFuZCBkZXBlbmQgdGhlIGZvbG93aW5nIHN0ZXAgdG8gZGVjaWRlIHRo
ZSByZWFsIG9uZSAqLw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRy
bV9zY2hlZF9yZXNldF9rYXJtYShzX2pvYik7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZHJtX3NjaGVkX3Jlc3VibWl0X2pvYnMyKCZyaW5nLT5zY2hlZCwgMSk7DQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gZG1hX2ZlbmNlX3dh
aXRfdGltZW91dChzX2pvYi0+c19mZW5jZS0+cGFyZW50LCBmYWxzZSwgcmluZy0+c2NoZWQudGlt
ZW91dCk7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAo
cmV0ID09IDApIHsgLyogdGltZW91dCAqLw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgRFJNX0VSUk9SKCJGb3VuZCB0aGUgcmVhbCBiYWQgam9iISByaW5n
OiVzLCBqb2JfaWQ6JWxseFxuIiwgcmluZy0+c2NoZWQubmFtZSwgc19qb2ItPmlkKTsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIHNldCBndWlsdHkg
Ki8NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRybV9z
Y2hlZF9pbmNyZWFzZV9rYXJtYShzX2pvYik7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC8qIGRvIGh3IHJlc2V0ICovDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFk
ZXYpKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGFtZGdwdV92aXJ0X2ZpbmlfZGF0YV9leGNoYW5nZShhZGV2KTsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgciA9IGFtZGdwdV9k
ZXZpY2VfcmVzZXRfc3Jpb3YoYWRldiwgZmFsc2UpOw0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAocikNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5hc2lj
X3Jlc2V0X3JlcyA9IHI7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB9IGVsc2Ugew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICByICA9IGFtZGdwdV9kb19hc2ljX3Jlc2V0KGhpdmUsIGRldmljZV9s
aXN0X2hhbmRsZSwgJm5lZWRfZnVsbF9yZXNldCwgZmFsc2UpOw0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAociAmJiByID09IC1FQUdB
SU4pDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZ290byByZXRyeTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIH0NCj4gKw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLyogYWRkIHJlc2V0IGNvdW50ZXIgc28gdGhhdCB0aGUgZm9sbG93aW5n
IHJlc3VibWl0dGVkIGpvYiBjb3VsZCBmbHVzaCB2bWlkICovDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhdG9taWNfaW5jKCZ0bXBfYWRldi0+Z3B1X3Jl
c2V0X2NvdW50ZXIpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29udGludWU7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fQ0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogZ290IHRo
ZSBodyBmZW5jZSwgc2lnbmFsIGZpbmlzaGVkIGZlbmNlICovDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYXRvbWljX2RlYygmcmluZy0+c2NoZWQubnVtX2pvYnMpOw0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRtYV9mZW5jZV9nZXQoJnNf
am9iLT5zX2ZlbmNlLT5maW5pc2hlZCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZG1hX2ZlbmNlX3NpZ25hbCgmc19qb2ItPnNfZmVuY2UtPmZpbmlzaGVkKTsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkbWFfZmVuY2VfcHV0KCZzX2pv
Yi0+c19mZW5jZS0+ZmluaXNoZWQpOw0KPiArDQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAvKiByZW1vdmUgbm9kZSBmcm9tIGxpc3QgYW5kIGZyZWUgdGhlIGpv
YiAqLw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNwaW5fbG9jaygm
cmluZy0+c2NoZWQuam9iX2xpc3RfbG9jayk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbGlzdF9kZWxfaW5pdCgmc19qb2ItPm5vZGUpOw0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrKCZyaW5nLT5zY2hlZC5qb2JfbGlz
dF9sb2NrKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByaW5nLT5z
Y2hlZC5vcHMtPmZyZWVfam9iKHNfam9iKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfQ0KPiArICAgICAgICAgICAgICAgICAgICAgfQ0KPiArICAgICAgICAgICAgIH0NCj4gKw0K
PiAgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX01BWF9SSU5HUzsgKytpKSB7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nID0gdG1w
X2FkZXYtPnJpbmdzW2ldOw0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ry
di5jDQo+IGluZGV4IDg2NWY5MjQ3NzJiMC4uOWMzZjRlZGI3NTMyIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+IEBAIC01MDksNyArNTA5LDcgQEAgbW9k
dWxlX3BhcmFtX25hbWVkKGNvbXB1dGVfbXVsdGlwaXBlLCBhbWRncHVfY29tcHV0ZV9tdWx0aXBp
cGUsIGludCwgMDQ0NCk7DQo+ICAgICogRE9DOiBncHVfcmVjb3ZlcnkgKGludCkNCj4gICAgKiBT
ZXQgdG8gZW5hYmxlIEdQVSByZWNvdmVyeSBtZWNoYW5pc20gKDEgPSBlbmFibGUsIDAgPSBkaXNh
YmxlKS4gVGhlIGRlZmF1bHQgaXMgLTEgKGF1dG8sIGRpc2FibGVkIGV4Y2VwdCBTUklPVikuDQo+
ICAgICovDQo+IC1NT0RVTEVfUEFSTV9ERVNDKGdwdV9yZWNvdmVyeSwgIkVuYWJsZSBHUFUgcmVj
b3ZlcnkgbWVjaGFuaXNtLCAoMSA9IGVuYWJsZSwgMCA9IGRpc2FibGUsIC0xID0gYXV0bykiKTsN
Cj4gK01PRFVMRV9QQVJNX0RFU0MoZ3B1X3JlY292ZXJ5LCAiRW5hYmxlIEdQVSByZWNvdmVyeSBt
ZWNoYW5pc20sICgyID0gYWR2YW5jZWQgdGRyIG1vZGUsIDEgPSBlbmFibGUsIDAgPSBkaXNhYmxl
LCAtMSA9IGF1dG8pIik7DQo+ICAgbW9kdWxlX3BhcmFtX25hbWVkKGdwdV9yZWNvdmVyeSwgYW1k
Z3B1X2dwdV9yZWNvdmVyeSwgaW50LCAwNDQ0KTsNCj4NCj4gICAvKioNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIGIvZHJpdmVycy9ncHUvZHJt
L3NjaGVkdWxlci9zY2hlZF9tYWluLmMNCj4gaW5kZXggZDgyYTdlYmY2MDk5Li45OWE2YThiZGRk
NmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jDQo+IEBAIC0z
OTUsNiArMzk1LDgxIEBAIHZvaWQgZHJtX3NjaGVkX2luY3JlYXNlX2thcm1hKHN0cnVjdCBkcm1f
c2NoZWRfam9iICpiYWQpDQo+ICAgfQ0KPiAgIEVYUE9SVF9TWU1CT0woZHJtX3NjaGVkX2luY3Jl
YXNlX2thcm1hKTsNCj4NCj4gKw0KPiArdm9pZCBkcm1fc2NoZWRfcmVzdWJtaXRfam9iczIoc3Ry
dWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCwgaW50IG1heCkNCj4gK3sNCj4gKyAgICAgc3Ry
dWN0IGRybV9zY2hlZF9qb2IgKnNfam9iLCAqdG1wOw0KPiArICAgICB1aW50NjRfdCBndWlsdHlf
Y29udGV4dDsNCj4gKyAgICAgYm9vbCBmb3VuZF9ndWlsdHkgPSBmYWxzZTsNCj4gKyAgICAgc3Ry
dWN0IGRtYV9mZW5jZSAqZmVuY2U7DQo+ICsgICAgIGludCBpID0gMDsNCj4gKw0KPiArICAgICBs
aXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoc19qb2IsIHRtcCwgJnNjaGVkLT5wZW5kaW5nX2xpc3Qs
IGxpc3QpIHsNCj4gKyAgICAgICAgICAgICBzdHJ1Y3QgZHJtX3NjaGVkX2ZlbmNlICpzX2ZlbmNl
ID0gc19qb2ItPnNfZmVuY2U7DQo+ICsNCj4gKyAgICAgICAgICAgICBpZiAoaT49bWF4KQ0KPiAr
ICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsNCj4gKyAgICAgICAgICAgICBpZiAoIWZv
dW5kX2d1aWx0eSAmJiBhdG9taWNfcmVhZCgmc19qb2ItPmthcm1hKSA+IHNjaGVkLT5oYW5nX2xp
bWl0KSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICBmb3VuZF9ndWlsdHkgPSB0cnVlOw0KPiAr
ICAgICAgICAgICAgICAgICAgICAgZ3VpbHR5X2NvbnRleHQgPSBzX2pvYi0+c19mZW5jZS0+c2No
ZWR1bGVkLmNvbnRleHQ7DQo+ICsgICAgICAgICAgICAgfQ0KPiArDQo+ICsgICAgICAgICAgICAg
aWYgKGZvdW5kX2d1aWx0eSAmJiBzX2pvYi0+c19mZW5jZS0+c2NoZWR1bGVkLmNvbnRleHQgPT0g
Z3VpbHR5X2NvbnRleHQpDQo+ICsgICAgICAgICAgICAgICAgICAgICBkbWFfZmVuY2Vfc2V0X2Vy
cm9yKCZzX2ZlbmNlLT5maW5pc2hlZCwgLUVDQU5DRUxFRCk7DQo+ICsNCj4gKyAgICAgICAgICAg
ICBkbWFfZmVuY2VfcHV0KHNfam9iLT5zX2ZlbmNlLT5wYXJlbnQpOw0KPiArICAgICAgICAgICAg
IGZlbmNlID0gc2NoZWQtPm9wcy0+cnVuX2pvYihzX2pvYik7DQo+ICsgICAgICAgICAgICAgaSsr
Ow0KPiArDQo+ICsgICAgICAgICAgICAgaWYgKElTX0VSUl9PUl9OVUxMKGZlbmNlKSkgew0KPiAr
ICAgICAgICAgICAgICAgICAgICAgaWYgKElTX0VSUihmZW5jZSkpDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGRtYV9mZW5jZV9zZXRfZXJyb3IoJnNfZmVuY2UtPmZpbmlzaGVkLCBQ
VFJfRVJSKGZlbmNlKSk7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgIHNfam9iLT5zX2Zl
bmNlLT5wYXJlbnQgPSBOVUxMOw0KPiArICAgICAgICAgICAgIH0gZWxzZSB7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICBzX2pvYi0+c19mZW5jZS0+cGFyZW50ID0gZmVuY2U7DQo+ICsgICAgICAg
ICAgICAgfQ0KPiArICAgICB9DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKGRybV9zY2hlZF9yZXN1
Ym1pdF9qb2JzMik7DQo+ICsNCj4gKw0KPiArDQo+ICt2b2lkIGRybV9zY2hlZF9yZXNldF9rYXJt
YShzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqYmFkKQ0KPiArew0KPiArICAgICBpbnQgaTsNCj4gKyAg
ICAgc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKnRtcDsNCj4gKyAgICAgc3RydWN0IGRybV9zY2hl
ZF9lbnRpdHkgKmVudGl0eTsNCj4gKyAgICAgc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hl
ZCA9IGJhZC0+c2NoZWQ7DQo+ICsNCj4gKyAgICAgLyogZG9uJ3QgcmVzZXQgQGJhZCdzIGthcm1h
IGlmIGl0J3MgZnJvbSBLRVJORUwgUlEsDQo+ICsgICAgICAqIGJlY2F1c2Ugc29tZXRpbWVzIEdQ
VSBoYW5nIHdvdWxkIGNhdXNlIGtlcm5lbCBqb2JzIChsaWtlIFZNIHVwZGF0aW5nIGpvYnMpDQo+
ICsgICAgICAqIGNvcnJ1cHQgYnV0IGtlZXAgaW4gbWluZCB0aGF0IGtlcm5lbCBqb2JzIGFsd2F5
cyBjb25zaWRlcmVkIGdvb2QuDQo+ICsgICAgICAqLw0KPiArICAgICBpZiAoYmFkLT5zX3ByaW9y
aXR5ICE9IERSTV9TQ0hFRF9QUklPUklUWV9LRVJORUwpIHsNCj4gKyAgICAgICAgICAgICBhdG9t
aWNfc2V0KCZiYWQtPmthcm1hLCAwKTsNCj4gKyAgICAgICAgICAgICBmb3IgKGkgPSBEUk1fU0NI
RURfUFJJT1JJVFlfTUlOOyBpIDwgRFJNX1NDSEVEX1BSSU9SSVRZX0tFUk5FTDsNCj4gKyAgICAg
ICAgICAgICAgICAgIGkrKykgew0KPiArICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRybV9z
Y2hlZF9ycSAqcnEgPSAmc2NoZWQtPnNjaGVkX3JxW2ldOw0KPiArDQo+ICsgICAgICAgICAgICAg
ICAgICAgICBzcGluX2xvY2soJnJxLT5sb2NrKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgIGxp
c3RfZm9yX2VhY2hfZW50cnlfc2FmZShlbnRpdHksIHRtcCwgJnJxLT5lbnRpdGllcywgbGlzdCkg
ew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoYmFkLT5zX2ZlbmNlLT5zY2hl
ZHVsZWQuY29udGV4dCA9PQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW50
aXR5LT5mZW5jZV9jb250ZXh0KSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpZiAoZW50aXR5LT5ndWlsdHkpDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF0b21pY19zZXQoZW50aXR5LT5ndWls
dHksIDApOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgICAgICAgICAgICAg
ICB9DQo+ICsgICAgICAgICAgICAgICAgICAgICBzcGluX3VubG9jaygmcnEtPmxvY2spOw0KPiAr
ICAgICAgICAgICAgICAgICAgICAgaWYgKCZlbnRpdHktPmxpc3QgIT0gJnJxLT5lbnRpdGllcykN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgICAgICAg
fQ0KPiArICAgICB9DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKGRybV9zY2hlZF9yZXNldF9rYXJt
YSk7DQo+ICsNCj4gICAvKioNCj4gICAgKiBkcm1fc2NoZWRfc3RvcCAtIHN0b3AgdGhlIHNjaGVk
dWxlcg0KPiAgICAqDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmgg
Yi9pbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmgNCj4gaW5kZXggMWM4MTVlMGExNGVkLi4wMWM2
MDkxNDk3MzEgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaA0KPiAr
KysgYi9pbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmgNCj4gQEAgLTMyMSw3ICszMjEsOSBAQCB2
b2lkIGRybV9zY2hlZF93YWtldXAoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCk7DQo+
ICAgdm9pZCBkcm1fc2NoZWRfc3RvcChzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkLCBz
dHJ1Y3QgZHJtX3NjaGVkX2pvYiAqYmFkKTsNCj4gICB2b2lkIGRybV9zY2hlZF9zdGFydChzdHJ1
Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkLCBib29sIGZ1bGxfcmVjb3ZlcnkpOw0KPiAgIHZv
aWQgZHJtX3NjaGVkX3Jlc3VibWl0X2pvYnMoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hl
ZCk7DQo+ICt2b2lkIGRybV9zY2hlZF9yZXN1Ym1pdF9qb2JzMihzdHJ1Y3QgZHJtX2dwdV9zY2hl
ZHVsZXIgKnNjaGVkLCBpbnQgbWF4KTsNCj4gICB2b2lkIGRybV9zY2hlZF9pbmNyZWFzZV9rYXJt
YShzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqYmFkKTsNCj4gK3ZvaWQgZHJtX3NjaGVkX3Jlc2V0X2th
cm1hKHN0cnVjdCBkcm1fc2NoZWRfam9iICpiYWQpOw0KPiAgIGJvb2wgZHJtX3NjaGVkX2RlcGVu
ZGVuY3lfb3B0aW1pemVkKHN0cnVjdCBkbWFfZmVuY2UqIGZlbmNlLA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHkpOw0K
PiAgIHZvaWQgZHJtX3NjaGVkX2ZhdWx0KHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQp
Ow0KDQoNCg0K

--_000_DM5PR1201MB0204120DC4A44A5A32196901BB919DM5PR1201MB0204_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
As Monk previously explained in another mail session.&nbsp;Because the drm_=
sched_resubmit_jobs submit all jobs which does not meet our needs.
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
We need a new APi&nbsp; drm_sched_resubmit_jobs2()<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0px; padding: 0px; font-=
family: sans-serif; font-size: 11pt; color: black; text-align: left;">
to submit the first job of a ring. (also we can leverage the error handling=
 for Null or Error fence inside this function&nbsp;).&nbsp;</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0px; padding: 0px; font-=
family: sans-serif; font-size: 11pt; color: black; text-align: left;">
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0px; padding: 0px; font-=
family: sans-serif; font-size: 11pt; color: black; text-align: left;">
It seems clean to use this jobs2 function than writing the run_job + some e=
rror handling in the main logic.&nbsp;</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0px; padding: 0px; font-=
family: sans-serif; font-size: 11pt; color: black; text-align: left;">
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0px; padding: 0px; font-=
family: sans-serif; font-size: 11pt; color: black; text-align: left;">
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0px; padding: 0px; font-=
family: sans-serif; font-size: 11pt; color: black; text-align: left;">
Thanks=A3=AC<br>
/Jack </div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0px; padding: 0px; font-=
family: sans-serif; font-size: 11pt; color: black; text-align: left;">
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0px; padding: 0px; font-=
family: sans-serif; font-size: 11pt; color: black; text-align: left;">
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0px; padding: 0px; font-=
family: sans-serif; font-size: 11pt; color: black; text-align: left;">
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<br>
</div>
<div id=3D"id-f87222bd-c403-491c-81fb-bdf2e154f36d" class=3D"ms-outlook-mob=
ile-reference-message">
<div style=3D"font-family: sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;"><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg"><strong>=B7=A2=BC=FE=C8=CB:</strong> Koenig, Chri=
stian &lt;Christian.Koenig@amd.com&gt;<br>
<strong>=B7=A2=CB=CD=CA=B1=BC=E4:</strong> 2021=C4=EA3=D4=C210=C8=D5=D0=C7=
=C6=DA=C8=FD =CF=C2=CE=E79:49<br>
<strong>=CA=D5=BC=FE=C8=CB:</strong> Zhang, Jack (Jian); amd-gfx@lists.free=
desktop.org; Grodzovsky, Andrey; Liu, Monk; Deng, Emily<br>
<strong>=D6=F7=CC=E2:</strong> Re: [PATCH v4] drm/amd/amdgpu implement tdr =
advanced mode<br>
</div>
<br>
<meta content=3D"text/html; charset=3Dutf-8">
Andrey needs to review the reste, but essentially I don't see the reason wh=
y you need this drm_sched_resubmit_jobs2().<br>
<br>
Christian.<br>
<br>
<div class=3D"moz-cite-prefix">Am 10.03.21 um 14:36 schrieb Zhang, Jack (Ji=
an):<br>
</div>
<blockquote type=3D"cite">
<p align=3D"Left" style=3D"font-family:Arial; font-size:11pt; color:#0078D7=
; margin:5pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Thanks Christian=A3=AC just did the checkpatch scan.&nbsp; Please see the V=
6 patch<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
/Jack<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0px; padding:0px; font-fam=
ily:sans-serif; font-size:11pt; color:black; text-align:left">
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Christian.Koenig@amd.com"=
>&lt;Christian.Koenig@amd.com&gt;</a><br>
<b>Sent:</b> Wednesday, March 10, 2021 8:54:53 PM<br>
<b>To:</b> Zhang, Jack (Jian) <a class=3D"moz-txt-link-rfc2396E" href=3D"ma=
ilto:Jack.Zhang1@amd.com">
&lt;Jack.Zhang1@amd.com&gt;</a>; <a class=3D"moz-txt-link-abbreviated" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Grodzovsky, Andrey <a class=3D"m=
oz-txt-link-rfc2396E" href=3D"mailto:Andrey.Grodzovsky@amd.com">
&lt;Andrey.Grodzovsky@amd.com&gt;</a>; Liu, Monk <a class=3D"moz-txt-link-r=
fc2396E" href=3D"mailto:Monk.Liu@amd.com">
&lt;Monk.Liu@amd.com&gt;</a>; Deng, Emily <a class=3D"moz-txt-link-rfc2396E=
" href=3D"mailto:Emily.Deng@amd.com">
&lt;Emily.Deng@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH v4] drm/amd/amdgpu implement tdr advanced mode</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Am 10.03.21 um 12:19 schrieb Jack Zhang:<br>
&gt; [Why]<br>
&gt; Previous tdr design treats the first job in job_timeout as the bad job=
.<br>
&gt; But sometimes a later bad compute job can block a good gfx job and<br>
&gt; cause an unexpected gfx job timeout because gfx and compute ring share=
<br>
&gt; internal GC HW mutually.<br>
&gt;<br>
&gt; [How]<br>
&gt; This patch implements an advanced tdr mode.It involves an additinal<br=
>
&gt; synchronous pre-resubmit step(Step0 Resubmit) before normal resubmit<b=
r>
&gt; step in order to find the real bad job.<br>
&gt;<br>
&gt; 1. At Step0 Resubmit stage, it synchronously submits and pends for the=
<br>
&gt; first job being signaled. If it gets timeout, we identify it as guilty=
<br>
&gt; and do hw reset. After that, we would do the normal resubmit step to<b=
r>
&gt; resubmit left jobs.<br>
&gt;<br>
&gt; 2. Re-insert Bailing job to mirror_list, and leave it to be handled by=
<br>
&gt; the main reset thread.<br>
&gt;<br>
&gt; 3. For whole gpu reset(vram lost), do resubmit as the old way.<br>
&gt;<br>
&gt; Signed-off-by: Jack Zhang <a class=3D"moz-txt-link-rfc2396E" href=3D"m=
ailto:Jack.Zhang1@amd.com">
&lt;Jack.Zhang1@amd.com&gt;</a><br>
&gt; Change-Id: I408357f10b9034caaa1b83610e19e514c5fbaaf2<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 73 ++++++++++=
++++++++++-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp; =
|&nbsp; 2 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_main.c&nbsp;&nbsp;&nbsp;&n=
bsp; | 75 ++++++++++++++++++++++<br>
&gt;&nbsp;&nbsp; include/drm/gpu_scheduler.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +<br>
&gt;&nbsp;&nbsp; 4 files changed, 148 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index e247c3a2ec08..02056355a055 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -4639,7 +4639,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_emergency_restart =
=3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool audio_suspended =3D fal=
se;<br>
&gt; -<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; tmp_vram_lost_co=
unter;<br>
<br>
Please keep the empoty line between declaration and code.<br>
<br>
In general give that patch a pass with checkpath.pl since there are a <br>
couple of other place which needs fixing at first glance.<br>
<br>
Christian.<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Special case: RAS tr=
iggered and full reset isn't supported<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; @@ -4689,9 +4689,14 @@ int amdgpu_device_gpu_recover(struct amdgpu_dev=
ice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;Bailing on TDR for s_job:%=
llx, as another already in progress&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; job ? job-&gt;base.id : -1);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* even we skipped this reset, still need to set the job to guilty */<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (job)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (job) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* re-insert node to av=
oid memory leak */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;job-&gt;=
base.sched-&gt;job_list_lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;job-&gt;b=
ase.node, &amp;job-&gt;base.sched-&gt;pending_list);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;job-&g=
t;base.sched-&gt;job_list_lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* even we skipped this=
 reset, still need to set the job to guilty */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sch=
ed_increase_karma(&amp;job-&gt;base);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto skip_recovery;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -4788,6 +4793,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tmp_vram_lost_counter =3D atomic_read(&amp;(=
(adev)-&gt;vram_lost_counter));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Actual ASIC resets if nee=
ded.*/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO Implement XGMI hive =
reset logic for SRIOV */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {=
<br>
&gt; @@ -4805,6 +4811,67 @@ int amdgpu_device_gpu_recover(struct amdgpu_dev=
ice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Post ASIC reset for all d=
evs .*/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev=
, device_list_handle, gmc.xgmi.head) {<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (amdgpu_gpu_recovery =3D=3D 2 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(tmp_vram_lost_counter=
 &lt; atomic_read(&amp;adev-&gt;vram_lost_counter))) {<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AM=
DGPU_MAX_RINGS; ++i) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D tmp_adev-&gt;rings[i]=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *s_job;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!ring || !ring-&gt;sched.thread)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; co=
ntinue;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /* No point to resubmit jobs if we didn't HW reset=
*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!tmp_adev-&gt;asic_reset_res &amp;&amp; !job_s=
ignaled) {<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_=
job =3D list_first_entry_or_null(&amp;ring-&gt;sched.pending_list, struct d=
rm_sched_job, list);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (s_job =3D=3D NULL)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 clear job's guilty and depend the folowing step to decide the real one */<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dr=
m_sched_reset_karma(s_job);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dr=
m_sched_resubmit_jobs2(&amp;ring-&gt;sched, 1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
t =3D dma_fence_wait_timeout(s_job-&gt;s_fence-&gt;parent, false, ring-&gt;=
sched.timeout);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (ret =3D=3D 0) { /* timeout */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Found the rea=
l bad job! ring:%s, job_id:%llx\n&quot;, ring-&gt;sched.name, s_job-&gt;id)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set guilty */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_increase_karma(s_jo=
b);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* do hw reset */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; amdgpu_virt_fini_data_exchange(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_reset_sriov(adev, false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt=
;asic_reset_res =3D r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; r&nbsp; =3D amdgpu_do_asic_reset(hive, device_list_handl=
e, &amp;need_full_reset, false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; if (r &amp;&amp; r =3D=3D -EAGAIN)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto ret=
ry;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* add reset counter so that =
the following resubmitted job could flush vmid */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;tmp_adev-&gt;=
gpu_reset_counter);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 got the hw fence, signal finished fence */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; at=
omic_dec(&amp;ring-&gt;sched.num_jobs);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm=
a_fence_get(&amp;s_job-&gt;s_fence-&gt;finished);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm=
a_fence_signal(&amp;s_job-&gt;s_fence-&gt;finished);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm=
a_fence_put(&amp;s_job-&gt;s_fence-&gt;finished);<br>
&gt; +<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 remove node from list and free the job */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sp=
in_lock(&amp;ring-&gt;sched.job_list_lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; li=
st_del_init(&amp;s_job-&gt;node);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sp=
in_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ri=
ng-&gt;sched.ops-&gt;free_job(s_job);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
amdgpu_ring *ring =3D tmp_adev-&gt;rings[i];<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c<br>
&gt; index 865f924772b0..9c3f4edb7532 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; @@ -509,7 +509,7 @@ module_param_named(compute_multipipe, amdgpu_compu=
te_multipipe, int, 0444);<br>
&gt;&nbsp;&nbsp;&nbsp; * DOC: gpu_recovery (int)<br>
&gt;&nbsp;&nbsp;&nbsp; * Set to enable GPU recovery mechanism (1 =3D enable=
, 0 =3D disable). The default is -1 (auto, disabled except SRIOV).<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; -MODULE_PARM_DESC(gpu_recovery, &quot;Enable GPU recovery mechanism, (=
1 =3D enable, 0 =3D disable, -1 =3D auto)&quot;);<br>
&gt; +MODULE_PARM_DESC(gpu_recovery, &quot;Enable GPU recovery mechanism, (=
2 =3D advanced tdr mode, 1 =3D enable, 0 =3D disable, -1 =3D auto)&quot;);<=
br>
&gt;&nbsp;&nbsp; module_param_named(gpu_recovery, amdgpu_gpu_recovery, int,=
 0444);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/=
scheduler/sched_main.c<br>
&gt; index d82a7ebf6099..99a6a8bddd6f 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; +++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; @@ -395,6 +395,81 @@ void drm_sched_increase_karma(struct drm_sched_jo=
b *bad)<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; EXPORT_SYMBOL(drm_sched_increase_karma);<br>
&gt;&nbsp;&nbsp; <br>
&gt; +<br>
&gt; +void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int ma=
x)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *s_job, *tmp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t guilty_context;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool found_guilty =3D false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *fence;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(s_job, tmp, &amp;sc=
hed-&gt;pending_list, list) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct drm_sched_fence *s_fence =3D s_job-&gt;s_fence;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (i&gt;=3Dmax)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!found_guilty &amp;&amp; atomic_read(&amp;s_job-&gt;karma) &gt; sch=
ed-&gt;hang_limit) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found_guilty =3D true;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; guilty_context =3D s_jo=
b-&gt;s_fence-&gt;scheduled.context;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (found_guilty &amp;&amp; s_job-&gt;s_fence-&gt;scheduled.context =3D=
=3D guilty_context)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_set_error(&am=
p;s_fence-&gt;finished, -ECANCELED);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dma_fence_put(s_job-&gt;s_fence-&gt;parent);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; fence =3D sched-&gt;ops-&gt;run_job(s_job);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; i++;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (IS_ERR_OR_NULL(fence)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(fence))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_set_error(&amp;s_fence-&gt;finished, PTR=
_ERR(fence));<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_job-&gt;s_fence-&gt;p=
arent =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_job-&gt;s_fence-&gt;p=
arent =3D fence;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL(drm_sched_resubmit_jobs2);<br>
&gt; +<br>
&gt; +<br>
&gt; +<br>
&gt; +void drm_sched_reset_karma(struct drm_sched_job *bad)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *tmp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *entity;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler *sched =3D bad-&gt;=
sched;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* don't reset @bad's karma if it's from KER=
NEL RQ,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * because sometimes GPU hang would cau=
se kernel jobs (like VM updating jobs)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * corrupt but keep in mind that kernel=
 jobs always considered good.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (bad-&gt;s_priority !=3D DRM_SCHED_PRIORI=
TY_KERNEL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; atomic_set(&amp;bad-&gt;karma, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; for (i =3D DRM_SCHED_PRIORITY_MIN; i &lt; DRM_SCHED_PRIORITY_KERNEL;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_rq *rq=
 =3D &amp;sched-&gt;sched_rq[i];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;rq-&gt;l=
ock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_saf=
e(entity, tmp, &amp;rq-&gt;entities, list) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (bad-&gt;s_fence-&gt;scheduled.context =3D=3D<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity-&gt;fence_context) =
{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (entity-&gt;guilty)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; atomic_set(entity-&gt;guilty, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br=
eak;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;rq-&gt=
;lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (&amp;entity-&gt;lis=
t !=3D &amp;rq-&gt;entities)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL(drm_sched_reset_karma);<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * drm_sched_stop - stop the scheduler<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h=
<br>
&gt; index 1c815e0a14ed..01c609149731 100644<br>
&gt; --- a/include/drm/gpu_scheduler.h<br>
&gt; +++ b/include/drm/gpu_scheduler.h<br>
&gt; @@ -321,7 +321,9 @@ void drm_sched_wakeup(struct drm_gpu_scheduler *sc=
hed);<br>
&gt;&nbsp;&nbsp; void drm_sched_stop(struct drm_gpu_scheduler *sched, struc=
t drm_sched_job *bad);<br>
&gt;&nbsp;&nbsp; void drm_sched_start(struct drm_gpu_scheduler *sched, bool=
 full_recovery);<br>
&gt;&nbsp;&nbsp; void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sch=
ed);<br>
&gt; +void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int ma=
x);<br>
&gt;&nbsp;&nbsp; void drm_sched_increase_karma(struct drm_sched_job *bad);<=
br>
&gt; +void drm_sched_reset_karma(struct drm_sched_job *bad);<br>
&gt;&nbsp;&nbsp; bool drm_sched_dependency_optimized(struct dma_fence* fenc=
e,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm=
_sched_entity *entity);<br>
&gt;&nbsp;&nbsp; void drm_sched_fault(struct drm_gpu_scheduler *sched);<br>
<br>
</div>
</span></font></div>
</div>
</blockquote>
<br>
<br>
</div>
</div>
</body>
</html>

--_000_DM5PR1201MB0204120DC4A44A5A32196901BB919DM5PR1201MB0204_--

--===============1720370410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1720370410==--
