Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031E6C4708A
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 14:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A5460233
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 14:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A5460233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6291E6E06B;
	Thu, 27 May 2021 14:27:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE47B6E06B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 14:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYKS8UlK9k3sgebbuEdT9ikx7gh6WVdXGZCHLSbiDYxIq12H8rk7aE5aDEGxdnAD702WdbRKsLf/u7LW6n/WeAadis6DDCustEO5QMCJ/b0uP+hdSIXslsxgcXdDozH0cuUQc4KL11Wg/bFyl2Lw7XvJ/rvyaSte0w6HXxTQza7GlPMmA5J7s/y8RMtmR6gzodxcK3tW3W0NRrmhf1QIvP4i/UdOUFOFpWKIu5MeQ1o6Z5vPoA1E/qhE26cDOl9RMd1U977HElZigPGju15GdAP6tJrlPe6SoZx1Tfz9xuP9cOblIyYgzzaiDf+F+wjLUW0cwJS3rzWNAWnwC7sKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHrS8tzv8d2YljtA4/o2WgwWivbgxTx7ciKMzPIG7Lc=;
 b=NAgLqJG17Q7XF5CoJ5lp467C5MyVMBXQBKD9ZZrK3AbGkoif/KtkUhF+crO6JEZC3NY0OgVeUlIWBLVl2kNiR+F99haCL5ibmN8ZnwAaOPFC0zJq8g/kKf3JOGpGp27yScv74FZqIyv33mj1EZmh+T6je0PZpvyf4EngexMzOdilH4hNO8lGwDHwlrB3hufaaMvlaY6NjmqBQ7eZxWcHJuuKz/YZBiCVfZ6KyzWSET3e/I5H5kDUMCE2cPtrEO6CRcBZmtSRqQrlA6y1xFgFTYjypSgv3L8ChfESr1iFfnDevgf+e/smTTr8+ztmWoCMqqWExAIVCUVi6T+jgd5ZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHrS8tzv8d2YljtA4/o2WgwWivbgxTx7ciKMzPIG7Lc=;
 b=ZGKAYNAmlrmxPIYVk8ALDEU3wibhgIfMc0xKP+nYcV66PjVfWXzcAx/OMFO/x+4z75v9j67EYgiyCI1DD25tNQ/LR2HAXGdOpNrculBZQoj8yPqV2CMxkKGsOMGU7DadpE4zmfzZETmlVpAqeqi+O5PRjvmYLlifIYTe4dzRQHE=
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB4634.namprd12.prod.outlook.com (2603:10b6:5:165::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 14:27:35 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd%5]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 14:27:35 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Li, Xin (Justin)"
 <Xin2.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing
Thread-Topic: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing
Thread-Index: AQHXUhfETBl7xmI9ZkmPB12tNyWEC6r1lYEAgAGKpgA=
Date: Thu, 27 May 2021 14:27:34 +0000
Message-ID: <DM5PR12MB178774A9B6AA4CF3DE4E81A1E5239@DM5PR12MB1787.namprd12.prod.outlook.com>
References: <20210526101310.1872892-1-xin2.li@amd.com>
 <dfab1180-2ee9-7d41-8a12-0a7e86dca9d4@amd.com>
In-Reply-To: <dfab1180-2ee9-7d41-8a12-0a7e86dca9d4@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
x-ms-exchange-imapappendstamp: DM5PR12MB1787.namprd12.prod.outlook.com
 (15.20.4173.022)
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0278a774-e793-4775-be7f-6cfad67c6f9a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-27T14:27:34Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2607:9880:2088:19:a536:705b:2ac8:75cc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bf7fdaa-4902-4bbb-7fae-08d9211b923f
x-ms-traffictypediagnostic: DM6PR12MB4634:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB46341155BA25C5F6A199DD2AE5239@DM6PR12MB4634.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9nshR4hrY0nW9sBZblR2JOGGE0d5QIFm8QURV8BTtXqWfYkL4g1unU9gwBFmOntZ4deJ5QLVi88XbzCbgO/F5EY9Wzje01qgOXcDb2sNm5yDHxSkF73UNshnW4q0Nmb0hRtWzC+nDpwCOCbhI0lO5gScHg57hmEFY8Vr7WhfIlSKHYIU9mPJPRPifGCJ89wxTrX6KfmNt5m6THIIVtZKGKmLGbC2YVY5FzKul66XTrcFuZ43o+K/2FV9i24fsoUJnfjhSm7DBGyJz9jQqOeNVTOXJmH6N5K+qqqRz8IJfA4j00DF2G1WyU4BvnzbRmtz2XQHAI5IB1bAoJV/WwjZP2KbXonM+qe/lUyi42tE42+g0V3a/gdE7RLOe9rz9kL/9ZQtb7zpei+K7G2H1LZpERyP985XQn/Bvl8q5L3rHlaZP28n/YjbsdMzqS7AHMy0Z07cfVlsLlBaRgA1cLBwKCXHR3tvLvUjgn4lKax+vaJpcykP9b1V+6kIuR5qFuPVOFBlcy1B2O/Avj7GO3FJs+IZOIdvDwLrG3rXLnMeJIkw9Rai1vArjFRJgRYnJWH38nWhAd8/cY9HEvApmkvSua9FWzHeKPVqhHkkjl1+OGg123Td2Qk62K7vIBQ7ihfqyWcx1rMuhPKHJc5+YsJjQDGzEssQ2Ae5Huh1Lf+CeSOgSpUPMBmfPzZa930bWM4Y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(66446008)(66476007)(66946007)(64756008)(6506007)(66556008)(83380400001)(186003)(4326008)(71200400001)(53546011)(478600001)(66574015)(7696005)(8676002)(122000001)(52536014)(38100700002)(55016002)(76116006)(33656002)(86362001)(110136005)(54906003)(316002)(2906002)(5660300002)(9686003)(8936002)(65966003)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?c0VmMWZvRWxISDJpbERyQVc1ZFQvdXJyWmpXVmJpSmtXaWE1ZVIyNEhmOHhN?=
 =?utf-8?B?aDVUQU1FUFh4aVpORDMyVVBwbFU5UTBYUVpaZDgrMmxOeUphMmR6TlBRUVVX?=
 =?utf-8?B?aEpQWTA1UXJXcHd0RHJZZTFFS29LY1UweDVzem1BMHUwU1NuWXFObENoNVlP?=
 =?utf-8?B?WTYvc2V2UEhiSDJKdWJoclJiYThkZ21xOVU2c3FkR2VWTmhzTEZ1ODhPVVhl?=
 =?utf-8?B?NmNpNEhxR0IvU1VxNHREcmRSSkVFZEpDWFhFNElDM3cwdVpCY0FWSmRVdDYw?=
 =?utf-8?B?ZlJCczMvd1VZbEw1TS9wem5pNWxVajFtMHdMb1BaN0hvSVlJT3FneEFFM0FE?=
 =?utf-8?B?ditSRU80dEgwYlNFdUhFdFhGdjNrV3NFL0lNTldIMEZlUFBObE96amFVdGFO?=
 =?utf-8?B?THpxRHhJMmV3Z3I3cGlmdXBmOWtiWE9ud2Y0bGUvekZLMDdMeEJjeWFORFV0?=
 =?utf-8?B?a0tRc1E0WDR6VDYvOUFGYjBKOGRBT3h6czZKd2lMVjVCZTREKzBZMVR0cjd2?=
 =?utf-8?B?NzQ2anVEdlN6VlNhdWo5a3RJUERETFZHZDlkWFFTNkxBWFlHelRkRjEvUjJs?=
 =?utf-8?B?Y2pTZjUzUy9ESFVaQXRTRnJkamtTWUVkellwbU1YL1cxQmdvQjV2T1lSQ0lI?=
 =?utf-8?B?NFdvVFFRenFpMUtRVVEvK29CakxlSTlvb3JLbWdrQk5xNS80VFZoM2YrdnUv?=
 =?utf-8?B?NUFMZFZiKzFiTGI1OHpnQ1B2aytDMDBRdzZJSUkra3JBVFp1MWUxNjlQU0c5?=
 =?utf-8?B?ZmtjK3paZEZaeUxCOEgrQnN1R2NLUHlBbWpQNWg0cFpqdkoycyt0VW9tS3BP?=
 =?utf-8?B?S0NTeXZtTms2U2UvTmthaG03QWZPRmp6UXYybGp0N0NlVWprbTBOZG1FNEc0?=
 =?utf-8?B?bHNjOHpBZGJmTmJ0NDdCeW5FOTIzaXVOS2Y3YWxUZTlwZnpuaWo3Rk9DeXRM?=
 =?utf-8?B?L2p6aGdNaHpnWUUyczFnK0RqbEgyNW9FaWtOTHlLZFp5Y1FVNC9La0t1V0Jm?=
 =?utf-8?B?MFJPYWkrRUtlVVBLS3pyUTBhZlFWbWNBVTZNbjk1QjZQUnJjVEtMR3h2MnJY?=
 =?utf-8?B?dHh1cU5aOTZMNlhzcFFxMFg2eWRmVUZaYXRscnVNcU5nU0NOb3JHVG1hcHlR?=
 =?utf-8?B?SjZoUzJ3N1dtZ3Yya0tJY3hZVTNEdHNLZHU4OTFxUCtvdG1XUk9BaWtkUGdm?=
 =?utf-8?B?NjZHcThLOUs1Z2F0b1RBeCtKZnFvNmV6RlJtUFpKQ0JvSW9KdzRwSUc5L1BE?=
 =?utf-8?B?WDdpTm9sbFpuRDZVMHV0Z0pZUUtuVUR1OURyeVppdmtvMDNsbVQ3MHBxYkZF?=
 =?utf-8?B?L0lCTGY3d213T0FkK2ZhZC9lelg0M3dMdWxQRzU1UnZOR1pvV2k0WmhnZzhJ?=
 =?utf-8?B?U2NveEtuU3U4OEdsNGhCN2R6V3gyRnJwTFc2cFg5bm80TVBZWVROOXQ0blQ2?=
 =?utf-8?B?d2p6UzFIemFsM2VtZWJFaFZJazdsUUlIRzhsdmhrUmEwT043ak0rSnJFNkZV?=
 =?utf-8?B?Q3NkaXZ2TmFBZXZMS2g1T3VORStHb3NkTWNEZDdPRUVSZTV3TzJTOFNMWC9j?=
 =?utf-8?B?a0RaYXF5QU13S3VTbFI2M3NEUXhkRnJQelQzYlp5dStQNlpkeGRPT2RIWVNa?=
 =?utf-8?B?UGE5R3lnekhwaTJHT3dKNEx6RWtockJYUk8xSzhKZDRDR3FaNHJrRDBxYVI1?=
 =?utf-8?B?TUQ3bDVocldjWi9vUWt5elR2SU80bFBtRGFGRTVoWEp2TDM3SGJMMXhQL0p5?=
 =?utf-8?B?dEpTTkxPK0JJdGEycUllK2RvT0NadXRMY0xQeFZYZGlxemk2L3NaUHZ1TkJt?=
 =?utf-8?B?cFpXUnliWWtzK2NkelFBWnpZcUdZM2RhSm05WUpsdEV0cjRzYnpPeXhXM2FX?=
 =?utf-8?Q?7NUOxf/BDvm2j?=
Content-ID: <F9703F4B820C3F4D84010D59445A03B2@amdcloud.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf7fdaa-4902-4bbb-7fae-08d9211b923f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 14:27:35.0044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvRvViwH+0bSU9gGNKwDEzgWU84YFPWjL9ZAE6JHV4z3NYkzP/nWbePZ0TOux6yL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4634
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Min,
 Frank" <Frank.Min@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KT24gMjAyMS0wNS0yNiA2OjQ5IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3Jv
dGU6DQo+IEFtIDI2LjA1LjIxIHVtIDEyOjEzIHNjaHJpZWIgTGksIFhpbiAoSnVzdGluKToNCj4+
IHNpbmNlIHZjbiBkZWNvZGluZyByaW5nIGlzIG5vdCByZXF1aXJlZCwgc28ganVzdCBkaXNhYmxl
IGl0Lg0KPj4NCj4+IENjOiBBbGV4LkRldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
DQo+PiBDYzogQ2hyaXN0aWFuLktvbmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBMaS5YaW4uSnVzdGluIDx4aW4yLmxpQGFtZC5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBGcmFuay5NaW4gPEZyYW5rLk1pbkBhbWQuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyB8ICA2ICsrKy0tLQ0KPj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfMC5jICAgfCAyNSArKysrKysrKysrKysrKy0t
LS0tLS0tLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTQgZGVs
ZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9rbXMuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21z
LmMNCj4+IGluZGV4IDUyNGU0ZmU1ZWZlOC4uNjE0ZTZiMDZlOTRlIDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jDQo+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMNCj4+IEBAIC00MjcsNyArNDI3LDkgQEAg
c3RhdGljIGludCBhbWRncHVfaHdfaXBfaW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPj4gKmFk
ZXYsDQo+PiAgICAgICAgICAgICAgIGlmIChhZGV2LT51dmQuaGFydmVzdF9jb25maWcgJiAoMSA8
PCBpKSkNCj4+ICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4gICAtICAgICAgICAgICAg
aWYgKGFkZXYtPnZjbi5pbnN0W2ldLnJpbmdfZGVjLnNjaGVkLnJlYWR5KQ0KPj4gKyAgICAgICAg
ICAgIGlmIChhZGV2LT52Y24uaW5zdFtpXS5yaW5nX2RlYy5zY2hlZC5yZWFkeSB8fA0KPj4gKyAg
ICAgICAgICAgICAgICAoYWRldi0+YXNpY190eXBlID09IENISVBfTkFWSTEyICYmDQo+PiArICAg
ICAgICAgICAgICAgIGFtZGdwdV9zcmlvdl92ZihhZGV2KSkpDQo+DQo+IExlbyBuZWVkcyB0byB0
YWtlIGEgY2xvc2VyIGxvb2ssIGJ1dCB0aGF0IGxvb2tzIGZpc2h5IHRvIG1lLg0KDQpUaGUgZGVj
b2RlIGlzIGV4cGxpY2l0bHkgZGlzYWJsZWQgd2l0aCBzcmlvdiBjYXNlIHdpdGggdmNuMg0KDQor
ICAgICAgICAgICAgcmluZy0+c2NoZWQucmVhZHkgPSBmYWxzZTsNCg0KYW5kIEkgZG9uJ3QgdW5k
ZXJzdGFuZCBlaXRoZXIgd2h5IHRvIGFkZCB0aGUgcmluZyBudW1iZXIgaGVyZSBpZiBhbHJlYWR5
DQpoYXZlIGl0IGRpc2FibGVkLiBJZiB5b3UgYXJlIHRyeWluZyB0byB3b3JrYXJvdW5kIHNvbWUg
aXNzdWVzLCB0aGUNCmNoYW5nZXMgZnJvbSBoZXJlIGlzIHZlcnkgYmFkIGhhY2sgYW5kIHlvdSBw
cm9iYWJseSBuZWVkIHRvIGZpbmQgdGhlDQpyZWFsIHJvb3QgY2F1c2UuDQoNClJlZ2FyZHMsDQoN
Ckxlbw0KDQoNCj4NCj4gV2h5IHNob3VsZCB0aGUgcmluZyBiZSBhdmFpbGFibGUgaWYgaXQgaXMg
ZGlzYWJsZWQ/IFRoYXQgZG9lc24ndCBtYWtlDQo+IHNlbnNlLg0KPg0KPiBDaHJpc3RpYW4uDQo+
DQo+PiAgICAgICAgICAgICAgICAgICArK251bV9yaW5nczsNCj4+ICAgICAgICAgICB9DQo+PiAg
ICAgICAgICAgaWJfc3RhcnRfYWxpZ25tZW50ID0gMTY7DQo+PiBAQCAtNzcwLDggKzc3Miw2IEBA
IGludCBhbWRncHVfaW5mb19pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LA0KPj4gdm9pZCAq
ZGF0YSwgc3RydWN0IGRybV9maWxlICpmaWxwKQ0KPj4gICAgICAgICAgICAgICBkZXZfaW5mby0+
aWRzX2ZsYWdzIHw9IEFNREdQVV9JRFNfRkxBR1NfRlVTSU9OOw0KPj4gICAgICAgICAgIGlmIChh
bWRncHVfbWNicCB8fCBhbWRncHVfc3Jpb3ZfdmYoYWRldikpDQo+PiAgICAgICAgICAgICAgIGRl
dl9pbmZvLT5pZHNfZmxhZ3MgfD0gQU1ER1BVX0lEU19GTEFHU19QUkVFTVBUSU9OOw0KPj4gLSAg
ICAgICAgaWYgKGFtZGdwdV9pc190bXooYWRldikpDQo+PiAtICAgICAgICAgICAgZGV2X2luZm8t
Pmlkc19mbGFncyB8PSBBTURHUFVfSURTX0ZMQUdTX1RNWjsNCj4+ICAgICAgICAgICAgIHZtX3Np
emUgPSBhZGV2LT52bV9tYW5hZ2VyLm1heF9wZm4gKiBBTURHUFVfR1BVX1BBR0VfU0laRTsNCj4+
ICAgICAgICAgICB2bV9zaXplIC09IEFNREdQVV9WQV9SRVNFUlZFRF9TSVpFOw0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml8wLmMNCj4+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzAuYw0KPj4gaW5kZXggOGFmNTY3YzU0NmRiLi5k
YzhhMzY3NjZjNGEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
Y25fdjJfMC5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfMC5j
DQo+PiBAQCAtMjIwLDE3ICsyMjAsMjAgQEAgc3RhdGljIGludCB2Y25fdjJfMF9od19pbml0KHZv
aWQgKmhhbmRsZSkNCj4+ICAgew0KPj4gICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYg
PSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7DQo+PiAgICAgICBzdHJ1Y3QgYW1kZ3B1
X3JpbmcgKnJpbmcgPSAmYWRldi0+dmNuLmluc3QtPnJpbmdfZGVjOw0KPj4gLSAgICBpbnQgaSwg
cjsNCj4+ICsgICAgaW50IGksIHIgPSAtMTsNCj4+ICAgICAgICAgYWRldi0+bmJpby5mdW5jcy0+
dmNuX2Rvb3JiZWxsX3JhbmdlKGFkZXYsIHJpbmctPnVzZV9kb29yYmVsbCwNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJpbmctPmRvb3JiZWxsX2luZGV4LCAwKTsNCj4+ICAgLSAgICBp
ZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KPj4gKyAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFk
ZXYpKSB7DQo+PiAgICAgICAgICAgdmNuX3YyXzBfc3RhcnRfc3Jpb3YoYWRldik7DQo+PiAtDQo+
PiAtICAgIHIgPSBhbWRncHVfcmluZ190ZXN0X2hlbHBlcihyaW5nKTsNCj4+IC0gICAgaWYgKHIp
DQo+PiAtICAgICAgICBnb3RvIGRvbmU7DQo+PiArICAgICAgICBpZiAoYWRldi0+YXNpY190eXBl
ID09IENISVBfTkFWSTEyKQ0KPj4gKyAgICAgICAgICAgIHJpbmctPnNjaGVkLnJlYWR5ID0gZmFs
c2U7DQo+PiArICAgIH0gZWxzZSB7DQo+PiArICAgICAgICByID0gYW1kZ3B1X3JpbmdfdGVzdF9o
ZWxwZXIocmluZyk7DQo+PiArICAgICAgICBpZiAocikNCj4+ICsgICAgICAgICAgICBnb3RvIGRv
bmU7DQo+PiArICAgIH0NCj4+ICAgICAgICAgLy9EaXNhYmxlIHZjbiBkZWNvZGUgZm9yIHNyaW92
DQo+PiAgICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KPj4gQEAgLTI0NSw4ICsyNDgs
MTEgQEAgc3RhdGljIGludCB2Y25fdjJfMF9od19pbml0KHZvaWQgKmhhbmRsZSkNCj4+ICAgICBk
b25lOg0KPj4gICAgICAgaWYgKCFyKQ0KPj4gLSAgICAgICAgRFJNX0lORk8oIlZDTiBkZWNvZGUg
YW5kIGVuY29kZSBpbml0aWFsaXplZA0KPj4gc3VjY2Vzc2Z1bGx5KHVuZGVyICVzKS5cbiIsDQo+
PiAtICAgICAgICAgICAgKGFkZXYtPnBnX2ZsYWdzICYgQU1EX1BHX1NVUFBPUlRfVkNOX0RQRyk/
IkRQRw0KPj4gTW9kZSI6IlNQRyBNb2RlIik7DQo+PiArICAgICAgICBEUk1fSU5GTygiVkNOICVz
IGVuY29kZSBpbml0aWFsaXplZCBzdWNjZXNzZnVsbHkodW5kZXIgJXMpLlxuIiwNCj4+ICsgICAg
ICAgICAgICAoYWRldi0+YXNpY190eXBlID09IENISVBfTkFWSTEyICYmDQo+PiArICAgICAgICAg
ICAgICAgIGFtZGdwdV9zcmlvdl92ZihhZGV2KSk/IiI6ImRlY29kZSBhbmQiLA0KPj4gKyAgICAg
ICAgICAgIChhZGV2LT5wZ19mbGFncyAmDQo+PiArICAgICAgICAgICAgICAgIEFNRF9QR19TVVBQ
T1JUX1ZDTl9EUEcpPyJEUEcgTW9kZSI6IlNQRyBNb2RlIik7DQo+PiAgICAgICAgIHJldHVybiBy
Ow0KPj4gICB9DQo+PiBAQCAtMTcyMSw5ICsxNzI3LDYgQEAgaW50IHZjbl92Ml8wX2RlY19yaW5n
X3Rlc3RfcmluZyhzdHJ1Y3QNCj4+IGFtZGdwdV9yaW5nICpyaW5nKQ0KPj4gICAgICAgdW5zaWdu
ZWQgaTsNCj4+ICAgICAgIGludCByOw0KPj4gICAtICAgIGlmIChhbWRncHVfc3Jpb3ZfdmYoYWRl
dikpDQo+PiAtICAgICAgICByZXR1cm4gMDsNCj4+IC0NCj4+ICAgICAgIFdSRUczMihhZGV2LT52
Y24uaW5zdFtyaW5nLT5tZV0uZXh0ZXJuYWwuc2NyYXRjaDksIDB4Q0FGRURFQUQpOw0KPj4gICAg
ICAgciA9IGFtZGdwdV9yaW5nX2FsbG9jKHJpbmcsIDQpOw0KPj4gICAgICAgaWYgKHIpDQo+DQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
