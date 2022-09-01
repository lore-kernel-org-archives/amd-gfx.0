Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79F4ECAAD1
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Sep 2022 01:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E318C10E17F;
	Thu,  1 Sep 2022 01:11:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6386810E17F
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Sep 2022 01:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1m/abupge2cXvmxduc3BVYVTlTEFDVCxMBCnqMMJ9tm1sh5H17B0I9PSBAUBj/O/GQBMLC/nwfI4dJrgA5+ZsBtEeFIc2WZRcBDR2pk6DXoXDN1CJA4fLbJHQCerS/38dhe+306Pgrk1Aq2kPdddQhXdye0iek3cHhARAwiq8iuEja7SKboMXR43vjpDIr+hvR8iuKLzMI5HAvJlaqTnX8O69Sr9u7B3nygt85N0bUS92UeboZKJmuytY9VrduG1aNiEAe+z4gD+GWmXHU3dmtLWtc/42Mt3pF6AsrnlWArcGPwCeW16VwQvn98Zsw2Bt7U5xH4T06IWAEQdPxnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hd6pQp9paYw/sxlDn9bV+UK+MfX50QJAE/tRKHHT+qA=;
 b=MvyZ/DkkDS4le2aqyThGdJNAEhB8eHIkfySZqp0czHE2+WCHLpS8IvLt1XRFYjE6qSx18dM6fQLe7ZTSKJMd4L5OmEVgHm8p42gJUvFYkGAY1GzVx4ImBndax4SyJes2b6aBOdsVQ7JxET2Nw/uPiBsGh8QHPoIqqfpguSXk3IevECCtHDDMolsjyROqIr33elHJ+HC0w2MW7JW3TA/FQZKLf+AjDRqLQOTEKKv+KYIfBfqhhfPRHkuVV7gqxQ4Koh1ATjXLQfGBKMiNoduykAriFq00sATHMCPLrqxP/7pWXliVM0pfeNP/BXfkUBh/jL8eIVzqFHbtOj4WhqNwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hd6pQp9paYw/sxlDn9bV+UK+MfX50QJAE/tRKHHT+qA=;
 b=af1UqqEhoiL5uFNdNB613CR5RvCys5StStbazrkipWFXb/u8bsW15qKOJBaSCrA5hO9+D5itzK1LZ+AlFnwehQ7nWUlNNM3jDenU+ixDZWMauiAVacT0evVEkynmHd01NpGDvHFIkDoQYSaP8RAWE0ZFYxlmj2CZZAJCDefKliI=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Thu, 1 Sep
 2022 01:11:24 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::6047:4ead:7690:57e6]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::6047:4ead:7690:57e6%2]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 01:11:24 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu:  disable the debugger on gfx1036
Thread-Topic: [PATCH] drm/amdgpu:  disable the debugger on gfx1036
Thread-Index: Adi9n5u4QBhFsURoQ4+Un9d1uHtasA==
Date: Thu, 1 Sep 2022 01:11:24 +0000
Message-ID: <DM4PR12MB51525C1D8C1E070C54C78301E37B9@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-31T00:50:18Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=338a98a8-b401-4727-910d-a6d4f3e7b2d3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-09-01T01:11:21Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: e8d6c8d3-1bf0-4eac-b8b3-54966d512bf7
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dfa5ac8-97d9-4ca7-392b-08da8bb6e3c1
x-ms-traffictypediagnostic: PH8PR12MB6770:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1SP/YZ3YElkm2cv7UVQINm/R9pae/ADEhiVtEvUI1T+fAwGKSpBU7s/GJ5WQC40tytoBKk+aV6lYsbuDm+W7ksO7kSCMG/HakXgxZwSGo5+5SKCQXNKL56+wsX3hIiqy8AWL031fQ+IUn6vr6OEM36iffxsMMDtWWQPDAp8DGFghc1vthPp2ni85gqMoPY7/QnKjYEN8JwfHGdzeJB6ula1hl/QUyutSbPFR6ALof8hYf2gmYJFoTcjHwSKVS1IOyXAvtqbyvji9UpxgBBJk7kM/u4Q9Vordfx59/XDIDq6W43ms6o1abAey+rETfDHUM6i70mTxU7L+QhdEmQFg9uzR3SbXyjGsS9SmW6m9C0tmDXSUWA6TjJ1a9QB3ecQwIbj3A2kTaCZGxRFKrR/xYLHBnl5wAW0Ia1xx6DG3POPEp191VoSNzGq1GeGnBjqhnMTKKo7gNLlgDWbvy3iwhWtxRW+IfKcqLsnm+k1rpHE1xoLt/Mz17lGi05E3IK20yJDQQOjW+slEE5bceIiy0wAWD9I4+whvyqbgFLRVvNW06Oi5jYTCqBmSTB+SERNGEA86vtmvqoOtc7L7zbOOACSYNDLvW9uaXUmAHdj28vXJYvBhXeEZsRA85PnvZNj9l/wS4tWlw0wLvskqauE+lQy3xJVEvFF0yEZHN2sd3yJPd2ysynjHUykkPwY7UNMN/8fckrBwJ7BZsbRS7QD3oey0YxBfpL7PNFjlxEIQL7JNJl2HWyCrpBv5xreTHv6dmhKJ76F3OsMyjcMafrqOT2NjK+VgzMjXwaENKSfSpkqUhuYvxqu56+AkTwO9hYrG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(122000001)(2906002)(38100700002)(478600001)(8936002)(5660300002)(52536014)(33656002)(66946007)(7696005)(8676002)(64756008)(6506007)(4326008)(186003)(38070700005)(4744005)(55016003)(66556008)(66476007)(66446008)(316002)(54906003)(26005)(76116006)(9686003)(41300700001)(110136005)(71200400001)(86362001)(473944003)(414714003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm5mM1h3L2JaNTEybkk5dzNlbUswVU4vbGszZDFXNXg1MkwyT3NUM2haTXVo?=
 =?utf-8?B?Y1BaMTJ1eUhHYlNTZ1V0VmNsS2pBRUVuRnQyVzNxYzBTZEg1ZXhuQkJWSFI4?=
 =?utf-8?B?UVIycU1xYlJvOTJVT2NtUmVNU05GQ09hNUUxRXdBOURlVW9JanhBZDVoTm52?=
 =?utf-8?B?ck9yLzFJbXhRWlZPWmVFdkQ3MExWdnk5dEhYOEtqOGpCTkRFc3UzNHIyLzBn?=
 =?utf-8?B?dm9SbzNPaElsNUdnK1Q1RUNOVmZBWXJRNnNZbHBKU0lJakpzUUFCVzJLK0hh?=
 =?utf-8?B?cFlrKzU3Skt2SXpqUWZZOHJnR2JTSGR5TXlIZTU2TmV6U0tidnNpVW9ib0x0?=
 =?utf-8?B?MVNDbG5CZUppWU9KNXdkTzFtaEhRSE5STXA0RSthd1FnamxxRWwwSjRXMFVw?=
 =?utf-8?B?MXc2N2VDTmdtUVRzdlYzbnUwNTRRN2dyak1FYmVhR2hBN0g3cDVlNlpoT3pJ?=
 =?utf-8?B?Nll5cVMyajFGRG9OcmN4UTNUUTJtdHlsMC9iaDVzWlJSaFpEWjM2NSt5RDNC?=
 =?utf-8?B?cGJEem1HamFDdGJkdnVkbjRpQVY4cHRManE1Y1dvKzJNMFl6ekMrNmRqc3NS?=
 =?utf-8?B?ZVJTM1Z3ZEc3dGN0OFpYM0U4MjZZTTNLeG1xemorNGhUQXdpZ2NhT1JsdGxj?=
 =?utf-8?B?Q05oeDBJZlR0WVhQOTJ4c1dhdmtlQmwxcGxPcS9XbHlPdm1rT3RDSmo0L3N6?=
 =?utf-8?B?aWFnNDduT29PSXBxSjJXZytvcjVCekxEZ2hLT1hObm1nQlhiLzhxQjNCOWdJ?=
 =?utf-8?B?SEJSdUxSWHg5eFprcVd6a05YUSs3dDl6Y1ZiMEhSWVFtTWFDd0U2TDNLVU1v?=
 =?utf-8?B?clJldGVSQ3ZhditHTGRJemp5Wk9kUm5aVkNrWkZEQVd3aGNvcis5QlpSRFZC?=
 =?utf-8?B?SHdjd1JMWXZTelhIcnFUSktaWFo2S3N3UnpFMUJwTmNISVpRd1JHelZFRmhm?=
 =?utf-8?B?ZjEyVmNhL2h5Rnl3dVJBZHp5OFlDbU90STU2UWovbmExTkJVVkZNeEg1S3N0?=
 =?utf-8?B?SVJjZURuUHc1WHR2RTU3T3BoRURHcm5uN0QxNmpOM3pLa0poRG5UQU9QR3A3?=
 =?utf-8?B?L2srWHR0OUtRZkk4NkpQM29vU3N0MzRCRVY0enRHT05RcjFYNzdxdXJNUnBK?=
 =?utf-8?B?c1FUZDY2cjdKZkh5REJIU0NpdUlKVjdoUXNLclJCM0FVR2dLNGpaUjNKWVdM?=
 =?utf-8?B?eitrQzVyRDdtbncrWU1KTURVRm54Y2JGSWd6K3pHSVRjdGlvRzdLRXlDdnEx?=
 =?utf-8?B?SjN0Q25TQ3cxUEZ4KzZaYWptbkVFN2RCSWkxM3ZEUHhYUnUrMVVpU2dJTWtq?=
 =?utf-8?B?YUZsemNsc2d0ZXIrR3IxTVBxWDJ3cWc4eTRHckUrMU9pVEV3bmtaSnlsbTZo?=
 =?utf-8?B?ZlUvTCtqa1M4ekpZb09rem5SdE9hZUpyZkFuYkkyVWhlTk1FTUZpRzM1Mk1p?=
 =?utf-8?B?UE43bmlTbnd2U1NJQjgyekowK215K2h0SVJuV05kU2xXNXBrOEs3UXB3YnFT?=
 =?utf-8?B?U1MzRlJ5YjhWN0xOMDhJQ0l0SCtQaGNreEcyZ25lRDBIdTcvR2FSTndUSjRl?=
 =?utf-8?B?STB1MDh6Q0FMLzBubTA1d2tidEtOVkhhUkZKWVNQVzBZTGRWTzRuaGQxVnlF?=
 =?utf-8?B?Q0tzYnpSMmRBSHZOd3cwUHlReldKVmpET0pQZUxadVB2bVZGS2lqM2NGL1l3?=
 =?utf-8?B?cXhvenNHQ1pXbVN6aHFPYUZjcTBjN25XY3BhWjd2QzQ1dnRvVTZ6bHl4NHNN?=
 =?utf-8?B?MHN4eGxRN2NjenlxeElqWHRJMW9rN2NuZzNHdGJOZWlpaHJHUlRaZTNpdGpZ?=
 =?utf-8?B?c3RGK1RJcVY2Q3pBZGt3NkJoY2xOMkp5ZTJLaDU4Z2o1Y3pLQ3VidCtNWEE4?=
 =?utf-8?B?VVFPT2c1RnJVZ1NUekhhNU13UTVGaHdBUHBMbVprZDJVdXlJdTZLbUJuQ2ta?=
 =?utf-8?B?ZDZlZWoxS2kyb2JVdlJmS0JWUk5yVEFFaTJpUHlTZW9rVDh2dDlTeFh5ZlA3?=
 =?utf-8?B?d1BiWnRPK2VIRUdtVHNlNUYrUDZlQzJOYjQ1UEFRaDJsRnpEVzljY2lldU9n?=
 =?utf-8?B?eCtBcStsWlV6RnJiUGd0NW5mMFJQS1AvN2lCNnNaUHFISVM2K0dNc09SWUhB?=
 =?utf-8?Q?6sHn5kRNKK+auqOCJ91SNWpnA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfa5ac8-97d9-4ca7-392b-08da8bb6e3c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 01:11:24.7277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5xdJuVwUCR1vMRs2SF0GkjFkMMiEqBwGWOh4lKXzrpQYQG/nRcTOe8YYhMkcQAJQc9NHYYPgN/i45cG1SdBKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KDQpEaXNhYmxlIHRoZSBkZWJ1Z2dlciBvbiBnZngxMDM2Lg0KIA0KU2lnbmVk
LW9mZi1ieTogamllMXpoYW4gamVzc2UuemhhbmdAYW1kLmNvbQ0KICAgIENoYW5nZS1JZDogSWYx
ZDk2MDhkNTA4ZDFlYjI5ZTZjMWRlN2FjN2QxZGI5M2QxMDAwYjANCiANCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGVidWcuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9kZWJ1Zy5jDQppbmRleCA1YWIyMGY2ZGMyOTEuLjg5ZWJiM2VlOWNjYyAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZWJ1Zy5jDQorKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGVidWcuYw0KQEAgLTEwOTcsNiArMTA5
Nyw3IEBAIGJvb2wga2ZkX2RiZ19oYXNfc3VwcG9ydGVkX2Zpcm13YXJlKHN0cnVjdCBrZmRfZGV2
ICpkZXYpDQogICAgICAgICAgICAgICAgYnJlYWs7DQogICAgICAgIGNhc2UgSVBfVkVSU0lPTigx
MCwgMSwgMyk6IC8qIEN5YW4gU2tpbGxmaXNoICovDQogICAgICAgIGNhc2UgSVBfVkVSU0lPTigx
MCwgMywgMyk6IC8qIFllbGxvdyBDYXJwKi8NCisgICAgICBjYXNlIElQX1ZFUlNJT04oMTAsIDMs
IDYpOiAvKiBnZngxMDM2Ki8NCiAgICAgICAgICAgICAgICBmaXJtd2FyZV9zdXBwb3J0ZWQgPSBm
YWxzZTsNCiAgICAgICAgICAgICAgICBicmVhazsNCiAgICAgICAgZGVmYXVsdDoNCg==
