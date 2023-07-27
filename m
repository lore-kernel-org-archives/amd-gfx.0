Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0756EC001DF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 00:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78E5A10E4A6;
	Thu, 27 Jul 2023 00:51:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D60D10E4A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 00:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCfE/ziAYZl6emjTALUqEsT0s/lZ/4TMHQvuJmDplU/BUnJT+SKf8QKyVrpM2+pEXFkq6pv5EHrfJ2/cQ31/MLQgMkp7yPcNVKPsLU9klLSlNFgtOTnQO+Qfp8o3D08UW1g7sE74+Nzs9md8dTuVBkoDRWoWT98KrcNlfXc0k1niTwf+9DENP0Ogk8xddRGjMc8QqBfOf/O7OEri7NvpjdZz35jFowvgIhOz1IDSXPQ6Xfz10g9K55pRDDhB8F3HLN8qA/iOjxpVX9o9V7qKwR/XX+pECBdXKjYNfngN9BiZiX0cuvCEA5pHc+jGkRKEHvAfE5bcFRC/b/eTUSPZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bzks0ks3Ien7WJH7N5hwYsckESiEC2/UBRgMrxcHLo=;
 b=V+5DektNytVkZGag8rmI6HAidAzv9qane+xlKwSWUBrijbDgzMsRdrHTfW2Ska5vpB7jNKNeAaIzmlgS1lkOvi548q/Aye1locM5Or/re8EmNSajix8DBhb88uJU4M6+grJwLjA+Dexd1WrdLVBUOni2kSfLYZVQsV3poIBomJ1QfO7bruixV6kQ3qSHIkOXvZu4xtgQJl/+0B2z8Sx8mDGms87TkyyvVopcwPNiJyxjNbU+7UbmPwO4CjFypVcXXDRt8Ra/eMgTZlK2q3VMdsVaz5GxC2Wpa0x0roOnEY/YbLnlQsK9dGHhbxsEbOnM6ELy8j3M6LIYBQYnn3hbVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bzks0ks3Ien7WJH7N5hwYsckESiEC2/UBRgMrxcHLo=;
 b=W8ZBCEFru9DPa6NUcQg4CbCREcL6KF5z3UJ6mE/shtBqsI8x7bjYdpA3xufxxHl4bcxDn/YNqgDk+uIacwd9cd+r4WW5IfWaiypfu2zVnWljzqp9KQNC8/dH1/TgeztuXj3Ws3pDcdCFEisGCcqlNCV5XBu7IFH+2F/McfizINQ=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Thu, 27 Jul 2023 00:51:14 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::c725:d5a0:a4a8:772b]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::c725:d5a0:a4a8:772b%3]) with mapi id 15.20.6609.032; Thu, 27 Jul 2023
 00:51:14 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Swarnakar, Praful"
 <Praful.Swarnakar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix style issues in amdgpu_debugfs.c
Thread-Topic: [PATCH] drm/amdgpu: Fix style issues in amdgpu_debugfs.c
Thread-Index: AQHZv9g24nC9dzBVl0qL9MlB8EA7ba/MXoYAgABqjqA=
Date: Thu, 27 Jul 2023 00:51:14 +0000
Message-ID: <MN2PR12MB4128C1D391B44F709D5019E59001A@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230726153851.2219088-1-Praful.Swarnakar@amd.com>
 <CADnq5_PcNWfRF=MsvduFFT9-xmmOr2GJNkCE-rDu3A-o_3_7vA@mail.gmail.com>
In-Reply-To: <CADnq5_PcNWfRF=MsvduFFT9-xmmOr2GJNkCE-rDu3A-o_3_7vA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=07873396-865d-4f0c-a6db-c6a545e140e9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-27T00:51:07Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|DS0PR12MB6557:EE_
x-ms-office365-filtering-correlation-id: f25c84a7-1bd7-4ede-e35d-08db8e3b9448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: igB78ude1SFboIStuhkTk/2r94Pe7ozZD/UYJpRE972G3WawMv8mcZcVIszlshf34jsq7Bbnl6oECrptwLrweeuLFMoasSidC4rlc3Aaj98uNNoG27YVWIa4CD+MrzQdDKcDs0/AM/Rf6aiF6z6MfOpbA2jSFJrRTH8MT9lugqfqrmUxEG+mUH10YSAm6nNl2xqtrTynEZH390iI8W2cwth0XFl9K7kZAEKtkenMQZ+fp992kkqhU75GMx4PwLbP/m+JPmMNeAZwbfVXmpDL+wP7oOK30353X0PzZIvCSscecfcIyNcDRfIscDYOLnkrcJedWRJpuqgefJWgQm0HDg99C1qeKmHp1gdG71ydTvzC+jFOyusvr5ZCxC0ctE6Rqvl3xaT58fJE8CN3XCEtVE7xzBDmtg1Ina1Vh17/ZF+44c2tOHuq33IXQiFI153/MReOQnwRNOh708wd50SJG5A/5glucQIC4dG/GZAiYrklrJ6Opwcp5mYAkmEbxBBVeM2c9kmvFswm+gdoahL+odfdstMJqMOLyDhrR0ILxN2x0BAiqz0GEl8Os6zyvmA3WFQamYb5n87tD+IZSgFtl3wVDK4Q5zWtWuAg7YfYOLLCQWdg9xAlLAcnHSwoaa9h
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(2906002)(66946007)(54906003)(66556008)(66476007)(64756008)(76116006)(66446008)(9686003)(83380400001)(66574015)(55016003)(86362001)(38070700005)(33656002)(122000001)(38100700002)(110136005)(186003)(478600001)(26005)(7696005)(55236004)(53546011)(71200400001)(6506007)(41300700001)(5660300002)(4326008)(6636002)(316002)(52536014)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUgzMzF3TVNYOURHb29KMGZxakVnaFBNY09maWZEOFFmTmJxLzgydG5ENSt1?=
 =?utf-8?B?eHd5NzY0ZHhpTTExdVEzcjlxM2YvekFoTkozWmQvSGxsSENWQnBSdHBMWjI1?=
 =?utf-8?B?dFVJUGdKREdpZER6VCtoRFQ1b3VyaW11L1dZVlczTXJMK25OcVFJL1pBTHZN?=
 =?utf-8?B?OFFaNXdpRXUwTExlWEpsSkk5UFd3VXNKT1BOTE1rVW1PMzExUXZtWmIvZllJ?=
 =?utf-8?B?cUJTNk5hSnkwS2hwcERkNjlwcVBYaGlGUUx2aG9ZUURtSmtGZGJ3c3hXT3F6?=
 =?utf-8?B?NFc2S0pZbGN1a0YvcnZQL0R3UlE1WTFBdVMwQnJneTBoUGhVNmhScklCR0dE?=
 =?utf-8?B?NE9IWEJIa3QzNFdqM2g3bFpsR3NRTThtd0kzZXAxSUJWYVpoTENmbkd0Ynhq?=
 =?utf-8?B?eE5ZWFNqbkhKczdsNEI4TGpMQ3hZV2NZR0MrUms5eE1YVXpOQ1luSW4rUVBN?=
 =?utf-8?B?YTdoQm9NZ2FGSnNMTGc0ejc1VU1ZZDMvcURsSnNYU05JVzJGRWNYUHNVdFl2?=
 =?utf-8?B?cE5LdCtYb3ZMMzBWcnJFSExEK1E4Zm9wNkdYdGljb25CZUl1Y3hsaGo5Vjk3?=
 =?utf-8?B?VEJSYjFzeGFScnNWTEdWZWc0bDlBZEQ3MndjcDJ5MWt5YlNyVUN6VDVrTTc2?=
 =?utf-8?B?amVUMUlLRkRPTFB6b3FsTkJiczYySmZXaU4xY1dRYTRKRENjWGJBWG81K2Fu?=
 =?utf-8?B?cyswKzkvekRDZGdMRS9OMzJYQ1hCemczZkt4TlpSRXRNbEJaakI0blBlcEhv?=
 =?utf-8?B?SUJibWRNeWdtRUxuK1JrUXQ3QlAxM1BXVnVuelBSNTJRbmRxNU50cFFjV25t?=
 =?utf-8?B?S2NJVHJRYlRlVlVMVXVFNzBUQUVvNTBVNzNpU3A5Z1hJQzNhd2lnSDdNbU9G?=
 =?utf-8?B?VTVkS0swb3MyVXkybzdVY0VsRCtWeVVMb0RYYi9pN1NhVytmNG54TGdkdWJL?=
 =?utf-8?B?TzB5Uk9RWE1BNnovUkY0M0NSWHNkemVlK0ltNk5YdDNjUENQNGYrV09pcVp1?=
 =?utf-8?B?M3I5eld5eE55d1NhWU1Od21Uc2NIeWhMN0pGZyt3bktDd0xLV0hndUdYYmk5?=
 =?utf-8?B?Zk4rODduWUZ3WTVuMHU3S1pQYmJHQ1k1OFRqdEpMbFNhV2RJQWVzSnBsWlVu?=
 =?utf-8?B?dzM2L0IvSzZlYUU1VDFPWGlxUVBUSmp0aE41Qm9RdWFRR2lzNGRxUkM5RUZB?=
 =?utf-8?B?b21FL3ZhZTZDSVpBazZyOUdMeS9TMkN4dzFsdW1hVjR3Y3BGZlQrcnJBVWZk?=
 =?utf-8?B?Uy8vU2cyVGNsUTdEYWdhc0dDSU9DMGk4Y29pTGY1KzJ6Y2ErQmJ4ak80SWFt?=
 =?utf-8?B?cFZ2dStzaDQ2VEN6TkhKbXhnVnZZNTRPMldhT0ptMGxxUHl6WGNvTVROOHlP?=
 =?utf-8?B?ZTV2YTN1VGUvdUYwcHkwRDU1ZmY2Yk9keEFaVm1zWk1mdWRVd05rNE1iais4?=
 =?utf-8?B?Y2RtY0t5T0VubUhnbTdmVFRTcEppV2hYSXU3dFk1aGRRL3J1TVduL3ZuNmg2?=
 =?utf-8?B?bHBTajkrQmJ0QXVvMU55RjBVaS9JRGFxanlMRG9vN3JYWGpzbUJjSHlqUU9W?=
 =?utf-8?B?M1NVSk4vcnNEczF6dy9oa05LUkl1ZFkwbHBQSFdZWEFtVWxKbHdrOHFOSjJh?=
 =?utf-8?B?UklnSEtwUUtBTXVjZ0V1NllaNFZJQVZoV1VOVy9rTVVnWWtIdmhQSVE0VFZ4?=
 =?utf-8?B?Rmg4aHpjMGFBTGNnWURybDdyTGoyYlFzQjZYS3MyL2hRN24ycHdwK2Z0QnFz?=
 =?utf-8?B?K0FFMmtuMG9LaXpKMDRONSt1RW5QZnJiOXRRamlrUzNpRDFicXJrUUcwdkdL?=
 =?utf-8?B?bmlmaGRXS3YyQXFWYllDamhwTTVYditvRGtZZ2taVmpPMnM4SXdNNThGVUlD?=
 =?utf-8?B?Wk9pUXpkeEtJcVZ4S0ZaTlpSYWpwZVNva3JPSEFCSkx2c0VRTHk0YUF2WTBz?=
 =?utf-8?B?ZktZK2xlQTRWZzBqY24rZHppZnlLMnhOWFRwcUIxQzlZVW1FL0pFQ3V6R0lq?=
 =?utf-8?B?N1pPbGtOU000ZmhEMWdobTVIOE5VQXVlRnZVb3BrWDU3QThLQi9sUTRLUHgy?=
 =?utf-8?B?ZUtSRzM2cUxvQk9MSnFiT0doQTdTZHA3SzMraXBMOUVXK2g3Z0NIc0RLMktp?=
 =?utf-8?Q?GAo8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25c84a7-1bd7-4ede-e35d-08db8e3b9448
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 00:51:14.4606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehehK8CzB6cQ1vgM7MSBpcNB6CV95CZohpjMlAP5udxY6y2YQmS73gNi7d9r3YPsBQ3wAa1U9nqxUv0ZHRQjBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2Fu
LnNoYW5tdWdhbUBhbWQuY29tPg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
YW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxm
IE9mIEFsZXggRGV1Y2hlcg0KU2VudDogV2VkbmVzZGF5LCBKdWx5IDI2LCAyMDIzIDExOjU5IFBN
DQpUbzogU3dhcm5ha2FyLCBQcmFmdWwgPFByYWZ1bC5Td2FybmFrYXJAYW1kLmNvbT4NCkNjOiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT47IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NClN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCBzdHlsZSBpc3N1ZXMgaW4gYW1kZ3B1X2RlYnVnZnMu
Yw0KDQpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
Pg0KDQpPbiBXZWQsIEp1bCAyNiwgMjAyMyBhdCAxMTo0NeKAr0FNIFByYWZ1bCBTd2FybmFrYXIg
PFByYWZ1bC5Td2FybmFrYXJAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IEZpeGVzIHRoZSBmb2xsb3dp
bmcgdG8gYWxpZ24gdG8gbGludXggY29kaW5nIHN0eWxlOg0KPg0KPiBXQVJOSU5HOiBNaXNzaW5n
IGEgYmxhbmsgbGluZSBhZnRlciBkZWNsYXJhdGlvbnMNCj4gV0FSTklORzogc2l6ZW9mICpyZCBz
aG91bGQgYmUgc2l6ZW9mKCpyZCkNCj4NCj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4NCj4gQ2M6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBQcmFmdWwgU3dhcm5ha2FyIDxQcmFmdWwuU3dhcm5ha2FyQGFtZC5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyB8IDMg
KystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdm
cy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPiBp
bmRleCAwMGFiMGIzYzgyNzcuLmE0ZmFlYTRmYTBiNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+IEBAIC0zNzUsNyArMzc1LDcgQEAgc3Rh
dGljIGludCBhbWRncHVfZGVidWdmc19ncHJ3YXZlX29wZW4oc3RydWN0DQo+IGlub2RlICppbm9k
ZSwgc3RydWN0IGZpbGUgKmZpbGUpICB7DQo+ICAgICAgICAgc3RydWN0IGFtZGdwdV9kZWJ1Z2Zz
X2dwcndhdmVfZGF0YSAqcmQ7DQo+DQo+IC0gICAgICAgcmQgPSBremFsbG9jKHNpemVvZiAqcmQs
IEdGUF9LRVJORUwpOw0KPiArICAgICAgIHJkID0ga3phbGxvYyhzaXplb2YoKnJkKSwgR0ZQX0tF
Uk5FTCk7DQo+ICAgICAgICAgaWYgKCFyZCkNCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRU5P
TUVNOw0KPiAgICAgICAgIHJkLT5hZGV2ID0gZmlsZV9pbm9kZShmaWxlKS0+aV9wcml2YXRlOyBA
QCAtMzg4LDYgKzM4OCw3IEBADQo+IHN0YXRpYyBpbnQgYW1kZ3B1X2RlYnVnZnNfZ3Byd2F2ZV9v
cGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdA0KPiBmaWxlICpmaWxlKSAgc3RhdGljIGlu
dCBhbWRncHVfZGVidWdmc19ncHJ3YXZlX3JlbGVhc2Uoc3RydWN0IGlub2RlDQo+ICppbm9kZSwg
c3RydWN0IGZpbGUgKmZpbGUpICB7DQo+ICAgICAgICAgc3RydWN0IGFtZGdwdV9kZWJ1Z2ZzX2dw
cndhdmVfZGF0YSAqcmQgPSBmaWxlLT5wcml2YXRlX2RhdGE7DQo+ICsNCj4gICAgICAgICBtdXRl
eF9kZXN0cm95KCZyZC0+bG9jayk7DQo+ICAgICAgICAga2ZyZWUoZmlsZS0+cHJpdmF0ZV9kYXRh
KTsNCj4gICAgICAgICByZXR1cm4gMDsNCj4gLS0NCj4gMi4yNS4xDQo+DQo=
