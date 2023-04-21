Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61278C7618E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 09:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D863D10E09C;
	Fri, 21 Apr 2023 09:28:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED60710E09C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 09:28:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ihz7qU7IAKA6BVIBIp7DcESwLLr7NTp/MK+qQAWJNTUQ4RA2tHhDQpSD1g42A/llMXzUGQl3RkQ2tVmHmJMedEdc8IIxv8eaX68VNzZduM0vykyXAqmHxaTC7AP/SBhpTJwh1zQ7m+LLloDiiu7BRQTIwq7Uo7ufognNx8zXNgLo6wNd27/4vRORk+QWTzqHp8OFubd4nqYMnzzGyDJ8WPWka6ahtq1MxMZfugAet5bLDz2BbbND1K7j1c5e/+OSWntz5+Wxbuh4ZhfxpI5WoJBZoSQ8X6WNstmUihdaPMG3Rlwi64Qx9Ygu+r8cYp3/nEJ5RUcpL9fPG8WgB4wTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7c4qQuHZiWnefMTH6DC83ISNjII+szHvvnWyvSWP1So=;
 b=CAerA9220HaBs8HQ8kNfkrFrT9Ev2/zb80K54NWK8I9mNQiJOCEl/hzfVZEshJgf4FK8diPEDBbyrk7JgsPwjZinsOQfuWsMjDtMu3brE2r3qv3Vb562hfr9KZOrjWipQZw5UOPiV3w6A4SGRlJgBDNbzvlO5B8JZ500/EFx2Hm8W/bpw0/1zxOnayzvjRRm7zLUO4HvxLX77DljdoDGAmhUzmcaC0dSq/QsE55xj4xbWXpOxGffli454F3DnBTKxugPDpileX4ssaNoMvwveJe+yaSppKlnLj57qpKUW6jNKWo50rqqtgf76aQvFI2PprKqhQJxqDouTnvxyAWRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7c4qQuHZiWnefMTH6DC83ISNjII+szHvvnWyvSWP1So=;
 b=KurppLdhxzd34z2WctU9DWs4swAAB/u2e/RJTxcHO45MFowvvFTQUrF5Dua/aD1CzzwxJgRV7x8y1STEvbUGr5MdMCscaBQtsuhL3TCXfxW+trq/khZzf8De1FIAIGR8fBefPo/1LcJl3I8Dq2W3SLRHpgZJhScaCGGvduAMuh4=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by CH0PR12MB5371.namprd12.prod.outlook.com (2603:10b6:610:d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 09:28:32 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::1372:f6c8:8479:a4b]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::1372:f6c8:8479:a4b%3]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 09:28:32 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: extend the default timeout for kernel compute
 queues
Thread-Topic: [PATCH] drm/amdgpu: extend the default timeout for kernel
 compute queues
Thread-Index: AQHZc2lBemb3BucZUUeLMNyn/uJJP680KFkAgAFWbaA=
Date: Fri, 21 Apr 2023 09:28:31 +0000
Message-ID: <CH2PR12MB4152D176F5D832AD19178579FE609@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20230420091942.5981-1-Feifei.Xu@amd.com>
 <CADnq5_OkR-34GappsZNH5sSrRFOJ36J5_cykreckErekz=bxSw@mail.gmail.com>
In-Reply-To: <CADnq5_OkR-34GappsZNH5sSrRFOJ36J5_cykreckErekz=bxSw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-21T09:28:28Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=919c2e2e-0d0d-46f5-874a-f56ee7c00f39;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-21T09:28:28Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 9dc9e93b-a64c-4584-aaf0-7aa564ca41d0
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|CH0PR12MB5371:EE_
x-ms-office365-filtering-correlation-id: 64b9d347-d41b-4797-99ae-08db424ac5fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P2xPG/GaM7hDqP7E8dA7LrercQSFTUDycly6hsSDbgZ9yfub0wF4NhQExUfqC9W0+mRfLOXZEHOiV6i0aiL1KAEftTdjSL4st9Ks4IrtcY5jSroDzooYUs5pykLodlB083bNP8RYuoECjte3vyN1uvZDKeaeXDdMq0ZM+IjZqghlc3A0kJhHMYUKUSeflzKCb8toowTHwbnDeSKUSqUB0BQx7gsDE0VJIy0qqr0OORsceEdsm2LdPyJqTc6SH7tKQ5NrK7ttu73QB+/L4IBcQeuJFy7+EjvmgfDSs1OMLCMGlRc9qYWNO+MvHVnnaDGRLCNuOLSADimIJLh0GSPMrxbi4bQHhQg+JQoFXocQxSYKA+oi6ph3AiyRZrE84FKcOcgRQ3CgTnfZExeGQLOHahsFbSVM32Pkqc/p4gMe0kD/DAXGAuuUWPXc1X4TlUjuaG51yc8xGzKtJSAakepWzeY7VNUTbpKFAMkHH8BBs1qbbZpeo6o7Co5ikINwZcLYS+JvSmTcXUeBHscwGS+0WevJhjgpqJmfObWkDzXJQVVfOCDrb1hh050CLXXXCc+QesjFMVYE3uQ1elOjzc/G0JbikU5KhTVQLcAEQxJjJGL+PEYFFFtjjYsNw/xIDZGz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199021)(52536014)(8676002)(8936002)(5660300002)(316002)(122000001)(41300700001)(6916009)(4326008)(66446008)(64756008)(38100700002)(66476007)(86362001)(38070700005)(55016003)(9686003)(6506007)(2906002)(33656002)(53546011)(26005)(7696005)(83380400001)(186003)(76116006)(66946007)(66556008)(478600001)(71200400001)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlBoOWwzeFRyVjgwbXRyNXQxV3hJbnl4clB4ZEVkNDZMcFpVVFRxdTVEajhH?=
 =?utf-8?B?cTRLS2FXdXlkNFMzREJvemI5Mndqb2hxQ080RDBxZVNPYnEwOTVkWkxYTkd3?=
 =?utf-8?B?QVRSOUFRcnAxWVVhMFJXL2h1aWZFV2NPckVxZEY0d2hkZ2t3UGJOa1VGMkgy?=
 =?utf-8?B?TUM1RTJBcTZkSDdGZFkwYURiTHdqcXdlZXo5dC96VnZGczdwL2wzY096L2VZ?=
 =?utf-8?B?eVppUlhheU4xdXJqbHpxVmxMbldsa1BxRkRad3pPTGlPNnBjWEg3cEZhSExl?=
 =?utf-8?B?N3FxM25LdkQ5YUdPYU1YZi9yRmNQRTJmeER3QXBZMGRNa2IyN1RubnBaU3Yw?=
 =?utf-8?B?UG1WMGpzSGZYVWRjL2hIdmF2aXJHK3lTTkxhVHJjdXJxV0ozTElUNkFRaXNZ?=
 =?utf-8?B?QXhWYi9qUnhza2ZWaFlucHlxbFpQdFAvYXoxZlpjTjE2VTdaQVpPeEo0R1Fk?=
 =?utf-8?B?cG5RSVgxdVg2REZVdHRRN1o2UENiYVZHem8zRXE2VGxiQmE0T2tWZlJTMWli?=
 =?utf-8?B?VEpNclBQMlJ1aWNNcjRDQzlacjVGZTl0a05IV3dIYzhCOGJJWXEvTzRVeE44?=
 =?utf-8?B?SnBFdDErNVltSnBOVFVJMWJNN3N3b1JxWStGSzlMNk9YTTlBQkwwY1Q4N2Fq?=
 =?utf-8?B?VWxrSWlLK2xsQ2s0SHU5RENrRU82bUl4U3VPMHVCOCs0OTBnWDkrQjVjeUJ5?=
 =?utf-8?B?ZFlkMWdGUFZmV3VTdHVCYlorOEVKYkFKVHdPSE1WeWV4TmhLRlA3VENWYjlK?=
 =?utf-8?B?TFFZYlA4bGNoUHBnaFF1d1kwdXdWK1BXT2hGUkRFcmMwaVc1Snk2ZHZ3WUZl?=
 =?utf-8?B?V3VNMmt3ZXNyaWVoUkd0QklkMVpuc08vcFBWeTd4WDZwREZiNWtiejFTMXlK?=
 =?utf-8?B?NTZQYkV1VTdsNldmZC9pdFZmSUk3NFpxSGM4WTVMT29wUUcwQ2I0dFR1U0Zs?=
 =?utf-8?B?TlNPZkNZQVRUdlJzSHp6Z052bUM5RXRPVWxFSmlpRFkwYWhiTzkxZnVONGRI?=
 =?utf-8?B?L2p3MmhuUjc0OCtBa1IyRmZUQmpFb2RUeklSTURYRVNmZE1GYXZNaVpiSjBU?=
 =?utf-8?B?YlFpS1RuWnR1ZUhrTW5kWjZyYlprcllBUDZRSkJHaHV6MWs3ak5aeEdWenQ0?=
 =?utf-8?B?a1NmMGlCdTgzTVJZSHVNSDd5azBNYlEzQ2hYV1FYdnFrUHA5R0d1QlE0TmhB?=
 =?utf-8?B?M3piUU5DYWc2bHNaenI4anlQd3N5U20zY3dhMWc1Y3crRVNPWktWdnpwbzhl?=
 =?utf-8?B?S1JGUitEYUhzcUNXTkVzSjdhNmtLQTRiNFB3czJQRWNlZW5tVzJGQ0x4ZDFu?=
 =?utf-8?B?T0U2azh0ZndTZXBHQkE3WFpZekM1eDFnWFRQZmNHbmxvQkNYMERNMTlOZDhy?=
 =?utf-8?B?SUlCR1pHTEVzdjBjaFdyeGorWlBDVjFLN29xZG90WXJnek1mZzdKeW45NG8r?=
 =?utf-8?B?NW5wZ2xaeERUcVlQZGpXMzF4SU52a0ZLYTQveFYrajNsTEJnNWwxeVRuYkp6?=
 =?utf-8?B?V253YW9kNHFWTitXdnFWNEUvcjc1SUc5SVRSajI5MFc0dGJBbDBsUmJEWjRF?=
 =?utf-8?B?a2UyOHNqdmRJYlVPZ0JkRS9qeWF1c0h0MWhsTCtOd0ozSkNrTkxHaHIwWkNt?=
 =?utf-8?B?MzRhWkhQT1lFUVdEbHFmWUttN1pBMEcrMGFxd1RWT2pYa2krcldzUU9BdEpw?=
 =?utf-8?B?TkFyTWdFMTV1aG9iYi9ET2RROEhLZTJKdWVxMGMvcGI2WmNwaE5SbVNVbkp6?=
 =?utf-8?B?U2Z6Tzhicm8rTEh4RFdqdWl0NDJjc3R5dG5lcm9CNU1BVXJMZjNqaXU1L205?=
 =?utf-8?B?S2lOVEt5RFZ5TVl5NC81YU0wOGZDT0NnaEhGdGRURXQ5NERYdklYYVBVSTBi?=
 =?utf-8?B?VjdDcStyTmJUNEsvWC9iT3Qxa093TzF6OHB3SlhUaHdLRmpoWXZUQStIaFMv?=
 =?utf-8?B?SzIxMEZEam00VHFOVVJ0QnVBdlVXeWVxWkZBR0ljVHBCODg0Zkp3OHcvVlZi?=
 =?utf-8?B?Q2lReUlyMVBvYVNlck8rRXZWdUUzeUFFUTVmY3pUdTQvQnNzdWNPK0cwQTRj?=
 =?utf-8?B?eExWb0JSV0xZVS8yaDdBdHF4NitjSGtOSmN1c2VTLzg4ai9kdE1jUW5pWDEy?=
 =?utf-8?Q?xGHI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b9d347-d41b-4797-99ae-08db424ac5fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 09:28:31.9302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jtCJpuOjbH2rLq8K47V50cTGz5wYoLXzaNq/sLLFO4NFcK7Hu5+f1iKiwTvZYgZW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5371
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkZvciBzb21lIFZ1bGthbiBzdHJl
c3MgdGVzdHMsIGl0IG1pZ2h0IGJlIG5vdCBwb3NzaWJsZSB0byByZXdyaXRlIHVzaW5nIFJPQ20u
DQpBZnRlciBhIHR3aWNlIHRoaW5rLCBpdCBtaWdodCBiZSB0b28gcmlza3kgaWYgd2UgcHV0IDEy
MHMsIGJlY2F1c2Ugb2YgdGhlIHNvZnRsb2NrdXAgdGltZW91dCBzZXQgdG8gMTIwcy4NCg0KVG8g
c3VwcG9ydCBzb21lIHN0cmVzcyB0ZXN0cyBsaWtlIHRoZSBvbmUgd2hpY2ggcmVjZW50bHkgSSBz
YXcgb24gc3RyZXNzYmVuY2ggKFZ1bGthbiBzdHJlc3MgdGVzdCksIGlmIHdlIHNob3J0ZW4gdGhl
IDEyMHMgdG8gYSByZWFzb25hYmxlIHJhbmdlIGxpa2UgMTAwcywgaXQgY2FuIGFsc28gZml4IHRo
ZSBzb2Z0d2FyZSBoYW5nLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxl
eCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IA0KU2VudDogVGh1cnNkYXksIEFwcmls
IDIwLCAyMDIzIDg6NTcgUE0NClRvOiBYdSwgRmVpZmVpIDxGZWlmZWkuWHVAYW1kLmNvbT4NCkNj
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcu
WmhhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGV4dGVuZCB0
aGUgZGVmYXVsdCB0aW1lb3V0IGZvciBrZXJuZWwgY29tcHV0ZSBxdWV1ZXMNCg0KT24gVGh1LCBB
cHIgMjAsIDIwMjMgYXQgNToxOeKAr0FNIEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+IHdy
b3RlOg0KPg0KPiBFeHRlbmQgdG8gMTIwcy4gVGhlIGRlZmF1bHQgdGltZW91dCB2YWx1ZSBzaG91
bGQgYWxzbyBleHRlbmQgaWYgDQo+IGNvbXB1dGUgc2hhZGVyIGV4ZWN1dGlvbiB0aW1lIGV4dGVu
ZGVkLiBPdGhlcndpc2Ugc29tZSBzdHJlc3MgdGVzdCANCj4gd2lsbCB0cmlnZ2VyIGNvbXB1dGUg
cmluZyB0aW1lb3V0IGluIHNvZnR3YXJlLg0KDQpJIHRoaW5rIHRoYXQncyBwcm9iYWJseSB0b28g
bG9uZy4gIDIgbWludXRlcyBpcyBhIGxvbmcgdGltZSB0byBoYXZlIGEgaHVuZyBzeXN0ZW0uICBJ
IHRoaW5rIHdlIHNob3VsZCByZXdvcmsgdGhlIHRlc3RzIG9yIHVzZSBST0NtIGZvciBsb25nIHJ1
bm5pbmcgdGVzdCBjYXNlcy4NCg0KQWxleA0KDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEZlaWZlaSBY
dSA8RmVpZmVpLlh1QGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBpbmRleCBlNTM2ODg2ZjZkNDIuLjFmOThiNGIwYTU0OSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBA
QCAtMzQ3NSw3ICszNDc1LDcgQEAgc3RhdGljIGludCANCj4gYW1kZ3B1X2RldmljZV9nZXRfam9i
X3RpbWVvdXRfc2V0dGluZ3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+DQo+ICAgICAg
ICAgLyoNCj4gICAgICAgICAgKiBCeSBkZWZhdWx0IHRpbWVvdXQgZm9yIG5vbiBjb21wdXRlIGpv
YnMgaXMgMTAwMDANCj4gLSAgICAgICAgKiBhbmQgNjAwMDAgZm9yIGNvbXB1dGUgam9icy4NCj4g
KyAgICAgICAgKiBhbmQgMTIwMDAwIGZvciBjb21wdXRlIGpvYnMuDQo+ICAgICAgICAgICogSW4g
U1ItSU9WIG9yIHBhc3N0aHJvdWdoIG1vZGUsIHRpbWVvdXQgZm9yIGNvbXB1dGUNCj4gICAgICAg
ICAgKiBqb2JzIGFyZSA2MDAwMCBieSBkZWZhdWx0Lg0KPiAgICAgICAgICAqLw0KPiBAQCAtMzQ4
NSw3ICszNDg1LDcgQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2dldF9qb2JfdGltZW91dF9z
ZXR0aW5ncyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAgICAgICAgICAgICAgIGFk
ZXYtPmNvbXB1dGVfdGltZW91dCA9IGFtZGdwdV9zcmlvdl9pc19wcF9vbmVfdmYoYWRldikgPw0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmll
cyg2MDAwMCkgOiBtc2Vjc190b19qaWZmaWVzKDEwMDAwKTsNCj4gICAgICAgICBlbHNlDQo+IC0g
ICAgICAgICAgICAgICBhZGV2LT5jb21wdXRlX3RpbWVvdXQgPSAgbXNlY3NfdG9famlmZmllcyg2
MDAwMCk7DQo+ICsgICAgICAgICAgICAgICBhZGV2LT5jb21wdXRlX3RpbWVvdXQgPSAgbXNlY3Nf
dG9famlmZmllcygxMjAwMDApOw0KPg0KPiAgICAgICAgIGlmIChzdHJubGVuKGlucHV0LCBBTURH
UFVfTUFYX1RJTUVPVVRfUEFSQU1fTEVOR1RIKSkgew0KPiAgICAgICAgICAgICAgICAgd2hpbGUg
KCh0aW1lb3V0X3NldHRpbmcgPSBzdHJzZXAoJmlucHV0LCAiLCIpKSAmJg0KPiAtLQ0KPiAyLjM0
LjENCj4NCg==
