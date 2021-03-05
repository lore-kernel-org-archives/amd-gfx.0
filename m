Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7448FC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 08:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B0464FE6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 08:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B0464FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F6B46E053;
	Fri,  5 Mar 2021 08:52:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B0F6E053
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 08:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juv8AlRDupEizmlMHugi9aFUiZHBvTAq2zvlnF6k3LA3jFRtxFz88z2uwvK6y2gG2ldzQe4y1Sk+Auss2eLU8+p2me99LvaEgcJbZ5MxaVwE+wVW3WZfFbXEilt8nQ+sJdTgTi7ElLwIx9U7ZFZ1u8d8aCH96yZbcm4b/DrKRdEoFava2SG74f0fd8Q7oEQaXdVGYxHdph6FsXqAgw0PfsBl1dCoyEGfEG546gyU4IHYonRoGavpudLQxGUNwkCUq/M7QslKOlQQqYWFG7/kDtin7qwCnOlPISsI7Cycw9mJ9RHdr00t39tAoMEJQR4+FFAfOPcfwJX48ymF/q2Nkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=418Zsm5WJTIOvvHSdjhe8V79hYQUJzMyYjg3E5YmBfc=;
 b=S6omTHEf3CH3zL5xT1QTpVba4WbKqo42Wv35RC3arbNb8S1AZ9MHSRRb5XbzfMBgWu18qv+Wz/b7bnVR9dQRT/vLOmExCStIjHTO/NeLrNZNHVHhBvjoTk6n3YXG5T0qNUC6hfmcaZRd9FODqt8wbRtD+yW+UhsiRRtWchJLA8JdmmrPSCkb+1AXznFRe9HEbnpypiGa5CAOtb7EdKPywSqW05Nydp/AXmH+cNtqlPHd2vNmUO+WzudpuoOsTeap42JhBu06mnF+YuebLWCUwdYiuFGapiZjQS8ElecWc/EtohObwX/ESUaDfM67tfC6jtF0SJeccSwnAp2gZLCU4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=418Zsm5WJTIOvvHSdjhe8V79hYQUJzMyYjg3E5YmBfc=;
 b=l0NED4ZeqIzvB7X5JPnPlmsESQF4fEsnkC7VFaEeEtTBoblArRd+5artyvB/Zjqi+OK0aHShJHa1O8oX5dNeBoH3Vk6OwKETUXyFO2bWQv4kOsWI2LeWkVDiv+82jv/ZAT0qK/0MqdLelGCWzc7409MJWWjU+HG/F6MYD1OsRnI=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2791.namprd12.prod.outlook.com (2603:10b6:a03:61::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 08:52:52 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3912.019; Fri, 5 Mar 2021
 08:52:51 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix some unload driver issues
Thread-Topic: [PATCH] drm/amdgpu: Fix some unload driver issues
Thread-Index: AQHXEV27YtpYoYbhtUOoONSNwG/opap1Bu4AgAAMA/CAAAPVAIAAAEUA
Date: Fri, 5 Mar 2021 08:52:51 +0000
Message-ID: <BY5PR12MB411597E6B51652225FE4687F8F969@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210305012019.58196-1-Emily.Deng@amd.com>
 <3c929a45-c8d6-904b-25ce-2909e530dead@gmail.com>
 <BY5PR12MB411507D0009D10FFA11F0C648F969@BY5PR12MB4115.namprd12.prod.outlook.com>
 <aa8bca56-919f-55fb-4618-aac21428213a@gmail.com>
In-Reply-To: <aa8bca56-919f-55fb-4618-aac21428213a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5b4c3fc2-624a-409b-aaee-490baeb8191f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-05T08:52:35Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6730d5a2-0747-46a6-8703-08d8dfb40f7b
x-ms-traffictypediagnostic: BYAPR12MB2791:
x-microsoft-antispam-prvs: <BYAPR12MB2791CE3AEB1D14D7BFD6EB368F969@BYAPR12MB2791.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: opY1mtbZ68567qKhReQ9vri2Ni/5Upz+woQLgecR82wfRAJaRmyJNOkcQr0ouuyPHVYjGhnQM75N8L8/lp/hX5jDfXJlvkDBgG6bhFMoHH+4rxv8s1CcB0ttA29pvP85bW+krzv6TyluXr+UUNTtqdTnHkUv41bMiC9REdElrzvk7GEbuZGDMk6opPnvyvk3GcBBPdjKjB5EnevOCg72WEkpj0jBOdyqAWSbTFscgDMXtflCiID8xdgcy+PjLKcoAVGDUMeO6KLxe9kTV9465Ey2pOAz6y8WlrYTZwm9prmwX+Jd3fVdGVUOW8mZrYPnpP/gEvwqXGKf6aKfVtYxlxj6KBhI8KPwm3qlA8LCM08t1djLH1j6C7UpO0309nov56bpPRDP6zcoqp9mXSh+e62xuCfmD+z5m3B4fCEvwKZlgDjCNq8Bf4GBHVheJmsBayEmZZSlI7WJt1oNujHi2vfic5sLm5bRmhCP0TJsuoGI60n1hCJ24pFPUGzei6xMG7lCd5gOAgBjqfWsKI3Z6w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(26005)(186003)(83380400001)(8676002)(8936002)(478600001)(7696005)(86362001)(76116006)(66574015)(52536014)(2906002)(9686003)(53546011)(6506007)(66556008)(66946007)(71200400001)(110136005)(66446008)(5660300002)(33656002)(316002)(55016002)(66476007)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?bVZrWEQ0eERrUGlzWmNwS3laT3lQbGZraVVONDUvVFJLRGNjREJzbjBKVHQx?=
 =?utf-8?B?ZUNwU1JuWlYxTmZmNGRNMkNTK1FmUW9pc1ZyVzVtSWlCOE1XWkt1N0dvM0JT?=
 =?utf-8?B?RWNGVS9ZMUplakNvR1d3ZW42Q0RvQTMwU0o4NnRCZis0VllFOUpoVWRVZnJ5?=
 =?utf-8?B?dkkxaTRoaWhMNW9wb3FRNzNILzhDSW8zc2MrdTlBcityQi9GMVJmQ0wrOUxC?=
 =?utf-8?B?aGFSVElhL01Ha21xdUJQTFFSdzI0TzdObktqV3lWOEhudTkzUC9ZV1J6RFNt?=
 =?utf-8?B?S2c2QThyUUhwemYxZmtvWEVIaWhRZWtRa3hUbzhReEI2VUVOaHMvS0owVkU2?=
 =?utf-8?B?Y3RLRUJFbFR2RHozckdIK3BXeHpvWFl3VGhxWHJBdmVQU2hNckNxTTd2SWtL?=
 =?utf-8?B?OXJQa2xJdTNtRGFCZzRYNnFldFd0TlFYOHZVQ2NiaisxMmRuSmNacHhtblNj?=
 =?utf-8?B?elo5ZzI2NHFDM2pPMG1RRmNoMTdxcGVxNk1rKyszR2VtaGZYOXVGNFE3dHpN?=
 =?utf-8?B?T1Q3UitSSmdGb2paVzFQUVdXZlhua04zNGVGNU9aVWN4MXlvTzFXYXVmYVNB?=
 =?utf-8?B?blBiektwZ003TnI3eE5ZdXJJTHZxU29WamdLM2NwbmI5QTNJWXlqemRyUHJq?=
 =?utf-8?B?RS8xWDNPdkhiRWtjRW84WmwzNFZ4aGxtZ1NGKzF5a2U4UnBTWU5BUnNtaFAz?=
 =?utf-8?B?MlRLai9oTzBscXU5Rk1XTmxHL3BjQjVvdkFTdkNaNWpCYlFoWUxwQUYvWEtn?=
 =?utf-8?B?d0VCVU1BZ2g0Tlc0RDZMRkFhR1M5cSttaG5xRDBNZXpwTlN4OUJXWGZFdXhS?=
 =?utf-8?B?NXprQURCRTltNEFoMjE4K2V1a21CWGNkd3ZNVmZ0aGNnTkhLQWVpQ2xGT25w?=
 =?utf-8?B?c1NweXdUNHNySXFzTWZKdjgvTmhISjJGemVpYXRnUkpSdEpZWEtYaGd3Mm8r?=
 =?utf-8?B?TWplMWdDS010NWJtd2gyeXJqTUJ6UDRFenRvS3MvTTlPN1dqdy9DQlpyYUdu?=
 =?utf-8?B?OXVub3FSZkdzeS9neEJVVVpxRjVGRkZrUVV0a3JzeHQwdnhrZ2RrU1pGV3pQ?=
 =?utf-8?B?SmZYcDhDZUlGZkt5d3ROdmJ1STQ4V0F6bXZmZXV3WGhFSng3KzBLRjhidkRQ?=
 =?utf-8?B?RVBGN0hvelJ3aVFobXZyZjR5bzN5SDlyUXFPaitOTURPQnBFWkU5aVhWcU5q?=
 =?utf-8?B?UmdVdnppODVPNk9ZNnpQWWNrSy9nc21LODhQbWhBcEpVb082UWcwTkpFMVRk?=
 =?utf-8?B?dHdBY3MrdWV3RDZORlRGZlA3NnBWdkdpM1IxZ0ZIeWFxYnBCQXZNeTRESmx0?=
 =?utf-8?B?MDBVL1lQaVpXbGVCRU4vNlJPQWY4UmJzMmI2MytxcitUM3JTNHFFUW4yc3Zu?=
 =?utf-8?B?enFyUWozWnZWTHo5TUxaNFNJdzlsUE5nMGwzVit3b0ttRWs0dWY4NzVZRWQ3?=
 =?utf-8?B?TThjY0gyL0czdVBUOGRJNUFUcTh1ZjUram5CS0UxTXp3WjA3RDgxZldXRmQ1?=
 =?utf-8?B?NFRoZEJkY1VtTktNQVhnSERNdVRaYWxvSkZZdTdDNUI2TDEzaFBMK0h0UzVC?=
 =?utf-8?B?U1JYTkNxN3JQaDRjMTdiMWhLYzRtV1NoTkhMSkg4R1lIMlM5QS83K2NPTnlw?=
 =?utf-8?B?aDNRSHN4K2xmS3lxL1FxR0xLSTIxRzhVclVSYTRRSDZXKzNlNmlTa0RPNHZq?=
 =?utf-8?B?RnRtcVBxSlF1b1grdE81RXBQZUM2bWJhbUZ4dXc5TGFic0FTQy9XOHllRnpQ?=
 =?utf-8?Q?cS9VwP8F9gf6CasydIrDf+d+GIj6pNAn053s7MU?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6730d5a2-0747-46a6-8703-08d8dfb40f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 08:52:51.8949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Qz7ogfw0FlKYcTF067KXvpTAeHCw6avO1O1GiONHPNXMIVSSSEj4mkmvwPtp8DF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2791
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQo+
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29l
bmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCj5TZW50OiBGcmlkYXksIE1hcmNoIDUsIDIw
MjEgNDo1MiBQTQ0KPlRvOiBEZW5nLCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1
OiBGaXggc29tZSB1bmxvYWQgZHJpdmVyIGlzc3Vlcw0KPg0KPg0KPg0KPkFtIDA1LjAzLjIxIHVt
IDA5OjQzIHNjaHJpZWIgRGVuZywgRW1pbHk6DQo+PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0g
SW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+Pj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtl
bkBnbWFpbC5jb20+DQo+Pj4gU2VudDogRnJpZGF5LCBNYXJjaCA1LCAyMDIxIDM6NTUgUE0NCj4+
PiBUbzogRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4IHNv
bWUgdW5sb2FkIGRyaXZlciBpc3N1ZXMNCj4+Pg0KPj4+IEFtIDA1LjAzLjIxIHVtIDAyOjIwIHNj
aHJpZWIgRW1pbHkgRGVuZzoNCj4+Pj4gV2hlbiB1bmxvYWRpbmcgZHJpdmVyIGFmdGVyIGtpbGxp
bmcgc29tZSBhcHBsaWNhdGlvbnMsIGl0IHdpbGwgaGl0DQo+Pj4+IHNkbWEgZmx1c2ggdGxiIGpv
YiB0aW1lb3V0IHdoaWNoIGlzIGNhbGxlZCBieSB0dG1fYm9fZGVsYXlfZGVsZXRlLg0KPj4+PiBT
byB0byBhdm9pZCB0aGUgam9iIHN1Ym1pdCBhZnRlciBmZW5jZSBkcml2ZXIgZmluaSwgY2FsbA0K
Pj4+PiB0dG1fYm9fbG9ja19kZWxheWVkX3dvcmtxdWV1ZSBiZWZvcmUgZmVuY2UgZHJpdmVyIGZp
bmkuIEFuZCBhbHNvIHB1dA0KPj4+IGRybV9zY2hlZF9maW5pIGJlZm9yZSB3YWl0aW5nIGZlbmNl
Lg0KPj4+DQo+Pj4gR29vZCBjYXRjaCwgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4+PiBmb3IgdGhpcyBwYXJ0Lg0KPj4+DQo+Pj4+IFNl
dCBhZGV2LT5nYXJ0LnB0ciB0byBudWxsIHRvIGZpeCBudWxsIHBvaW50ZXIgd2hlbiBjYWxsaW5n
DQo+Pj4+IGFtZGdwdV9nYXJ0X3VuYmluZCBpbiBhbWRncHVfYm9fZmluaSB3aGljaCBpcyBhZnRl
ciBnYXJ0X2ZpbmkuDQo+Pj4gRm9yIHRoYXQgb25lIEknbSB3b25kZXJpbmcgaWYgd2Ugc2hvdWxk
bid0IHJhdGhlciByZXdvcmsgb3IgZG91YmxlDQo+Pj4gY2hlY2sgdGhlIHRlYXIgZG93biBvcmRl
ci4NCj4+Pg0KPj4+IE9uIHRoZSBvdGhlciBoYW5kIHRoZSBoYXJkd2FyZSBzaG91bGQgYmUgaWRs
ZSBieSBub3cgKHRoaXMgY29tZXMNCj4+PiBhZnRlciB0aGUgZmVuY2VfZHJpdmVyX2ZpbmksIGRv
ZXNuJ3QgaXQ/KSBhbmQgaXQgbG9va3MgY2xlYW5lciBvbiBpdCdzIG93bi4NCj4+IFllcywgeW91
IGFyZSByaWdodCwgd2l0aG91dCBjb25zaWRlciBtZW1vcnkgbGVhaywgd2l0aCBhYm92ZSBwYXRj
aCwgdGhlIGJvDQo+YXJlIGFsbCBjbGVhbmVkLCB0aGVuIHdvbid0IGhhdmUgaXNzdWUuIEJ1dCBp
ZiBoYXZlIG1lbW9yeSBsZWFrLCBtYXliZSBpdCB3aWxsDQo+aGF2ZSBpc3N1ZSBpbiB0dG1fYm9f
Zm9yY2VfbGlzdF9jbGVhbi0+IHR0bV9tZW1fZXZpY3RfZmlyc3Q/DQo+DQo+WWVhaCwgdGhhdCBp
cyBhIGdvb2QgYXJndW1lbnQgYW5kIHBhcnQgb2Ygd2hhdCBJIG1lYW4gd2l0aCBpdCBsb29rcyBj
bGVhbmVyIG9uDQo+aXRzIG93bi4NCj4NCj5NYXliZSB3cml0ZSB0aGF0IGludG8gdGhlIGNvbW1p
dCBtZXNzYWdlIGxpa2UgdGhpcy4gV2l0aCB0aGF0IGRvbmUgdGhlIGZ1bGwNCj5wYXRjaCBoYXMg
bXkgcmIuDQo+DQo+UmVnYXJkcywNCj5DaHJpc3RpYW4uDQpPaywgdGhhbmtzLg0KPg0KPj4NCj4+
PiBSZWdhcmRzLA0KPj4+IENocmlzdGlhbi4NCj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBFbWls
eSBEZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAxICsNCj4+Pj4gICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgIHwgNSArKystLQ0KPj4+PiAgICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jICAgfCAxICsNCj4+Pj4gICAgMyBm
aWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMN
Cj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+Pj4g
aW5kZXggYTExNzYwZWMzOTI0Li5kZTA1OTdkMzQ1ODggMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+Pj4gQEAgLTM1OTQsNiArMzU5
NCw3IEBAIHZvaWQgYW1kZ3B1X2RldmljZV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+Pj4g
KmFkZXYpDQo+Pj4+ICAgIHsNCj4+Pj4gICAgZGV2X2luZm8oYWRldi0+ZGV2LCAiYW1kZ3B1OiBm
aW5pc2hpbmcgZGV2aWNlLlxuIik7DQo+Pj4+ICAgIGZsdXNoX2RlbGF5ZWRfd29yaygmYWRldi0+
ZGVsYXllZF9pbml0X3dvcmspOw0KPj4+PiArdHRtX2JvX2xvY2tfZGVsYXllZF93b3JrcXVldWUo
JmFkZXYtPm1tYW4uYmRldik7DQo+Pj4+ICAgIGFkZXYtPnNodXRkb3duID0gdHJ1ZTsNCj4+Pj4N
Cj4+Pj4gICAga2ZyZWUoYWRldi0+cGNpX3N0YXRlKTsNCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jDQo+Pj4+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4+Pj4gaW5kZXggMTQzYTE0ZjQ4NjZmLi42
ZDE2ZjU4YWM5MWUgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9mZW5jZS5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9mZW5jZS5jDQo+Pj4+IEBAIC01MzEsNiArNTMxLDggQEAgdm9pZCBhbWRncHVfZmVuY2Vf
ZHJpdmVyX2Zpbmkoc3RydWN0DQo+Pj4gYW1kZ3B1X2RldmljZQ0KPj4+PiAqYWRldikNCj4+Pj4N
Cj4+Pj4gICAgaWYgKCFyaW5nIHx8ICFyaW5nLT5mZW5jZV9kcnYuaW5pdGlhbGl6ZWQpDQo+Pj4+
ICAgIGNvbnRpbnVlOw0KPj4+PiAraWYgKCFyaW5nLT5ub19zY2hlZHVsZXIpDQo+Pj4+ICtkcm1f
c2NoZWRfZmluaSgmcmluZy0+c2NoZWQpOw0KPj4+PiAgICByID0gYW1kZ3B1X2ZlbmNlX3dhaXRf
ZW1wdHkocmluZyk7DQo+Pj4+ICAgIGlmIChyKSB7DQo+Pj4+ICAgIC8qIG5vIG5lZWQgdG8gdHJp
Z2dlciBHUFUgcmVzZXQgYXMgd2UgYXJlIHVubG9hZGluZyAqLw0KPj4+IEBAIC01MzksOA0KPj4+
PiArNTQxLDcgQEAgdm9pZCBhbWRncHVfZmVuY2VfZHJpdmVyX2Zpbmkoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpDQo+Pj4+ICAgIGlmIChyaW5nLT5mZW5jZV9kcnYuaXJxX3NyYykNCj4+Pj4g
ICAgYW1kZ3B1X2lycV9wdXQoYWRldiwgcmluZy0+ZmVuY2VfZHJ2LmlycV9zcmMsDQo+Pj4+ICAg
ICAgICAgICByaW5nLT5mZW5jZV9kcnYuaXJxX3R5cGUpOyAtaWYgKCFyaW5nLT5ub19zY2hlZHVs
ZXIpDQo+Pj4+IC1kcm1fc2NoZWRfZmluaSgmcmluZy0+c2NoZWQpOw0KPj4+PiArDQo+Pj4+ICAg
IGRlbF90aW1lcl9zeW5jKCZyaW5nLT5mZW5jZV9kcnYuZmFsbGJhY2tfdGltZXIpOw0KPj4+PiAg
ICBmb3IgKGogPSAwOyBqIDw9IHJpbmctPmZlbmNlX2Rydi5udW1fZmVuY2VzX21hc2s7ICsraikN
Cj4+Pj4gICAgZG1hX2ZlbmNlX3B1dChyaW5nLT5mZW5jZV9kcnYuZmVuY2VzW2pdKTsNCj4+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmMNCj4+
Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jDQo+Pj4+IGluZGV4
IDIzODIzYTU3Mzc0Zi4uZjFlZGU0YjQzZDA3IDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmMNCj4+Pj4gQEAgLTIwMiw2ICsyMDIsNyBAQCB2b2lk
IGFtZGdwdV9nYXJ0X3RhYmxlX3ZyYW1fZnJlZShzdHJ1Y3QNCj4+PiBhbWRncHVfZGV2aWNlICph
ZGV2KQ0KPj4+PiAgICByZXR1cm47DQo+Pj4+ICAgIH0NCj4+Pj4gICAgYW1kZ3B1X2JvX3VucmVm
KCZhZGV2LT5nYXJ0LmJvKTsNCj4+Pj4gK2FkZXYtPmdhcnQucHRyID0gTlVMTDsNCj4+Pj4gICAg
fQ0KPj4+Pg0KPj4+PiAgICAvKg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
