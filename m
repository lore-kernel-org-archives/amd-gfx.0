Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A464FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Oct 2022 09:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AF8410E4AD;
	Mon, 10 Oct 2022 09:01:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E042B10E4AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Oct 2022 09:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhtJLe8zMwpo0Uv4HESCjleUY1LBX9NrUffpJvQCr7EdqC6WQXGLsRrUqTOJbCdW3D+DzBzz6Z+IFDzqVCEsOoQeO3M6dfaAHBJyUGGIBu/kctapymkOZz2zuj1K9u14IrGAbMYJ+rFcWjw3XBYYlRRSkMYvRr9elGPOIabu6Ry+ondZ/8fUK8NK+qpjI+CeiEHCpw7wZMHKb99iW0NXZKbs3lc7RrbP4m4dYPOWbtAxCCToKPuztZ7nx5K1PakC4q5rHHQvYy0EjNGJdsaStyA+eg8uJRo7n0dfv8pPAkWmBDbBsVPg1Ul5jOlQ5UgjtL7C7rxzP7dZOUpUtTTAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZEpwBiy60TKFewW0eROhLKVutWXoBISGfxMOEHeI0E=;
 b=AQ9lBoGimJrVgGLvfrzNSe+Dd/xLEgPLIGnRA8mR57xq9ISU0Dp1l0H2FadREyxnhYHASOZ5T3nGbctAiAIchumxG9FNfATfbDMzVmflnv75Ip/pgZhlslN+xgIpGvCUV/e9fqvXZKW14WkwVXDcf2gE8nUVZ1x6NDw2L/Glg9J7GIr078HoIQylwRt/xvsxXWMxW204th1B6Lp98JjPLMJ3vHg0ph56DQpMY7V4mRWPHUuZy9l0WEWSYyS7oVQFc1dEe1xYqCzrzI336sV5Lsu45ZmYk1vikfGPxGtoWMAB3sVAfVc6fBkc6t3wIpuUfAse5VCva+H86WTCZ1f22w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZEpwBiy60TKFewW0eROhLKVutWXoBISGfxMOEHeI0E=;
 b=eIY/UPAETXuLy6RXoJzwCZgdSklOjFnRSlML9xMrNA4fA8mMYuTAJyLsf2znRmHhRXhcTsE3zwOb3g158a93e1Qx/mC7OUt1/pH5QIOLlq2O/5LzHWHasOKhwIZFHuddFlLLi6b7z1ifISXGxkBzOc0tL1koDZBxNXcV36pMrGY=
Received: from BYAPR12MB3094.namprd12.prod.outlook.com (2603:10b6:a03:db::23)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Mon, 10 Oct
 2022 09:01:15 +0000
Received: from BYAPR12MB3094.namprd12.prod.outlook.com
 ([fe80::9c43:e467:47e6:ca]) by BYAPR12MB3094.namprd12.prod.outlook.com
 ([fe80::9c43:e467:47e6:ca%7]) with mapi id 15.20.5676.036; Mon, 10 Oct 2022
 09:01:15 +0000
From: "Slivka, Danijel" <Danijel.Slivka@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: set vm_update_mode=0 as default for Sienna
 Cichlid in SRIOV case
Thread-Topic: [PATCH v2] drm/amdgpu: set vm_update_mode=0 as default for
 Sienna Cichlid in SRIOV case
Thread-Index: AQHY2KoirJKPq1z9ckiZuIHyJhCHtK4AAdkAgAdR+lA=
Date: Mon, 10 Oct 2022 09:01:15 +0000
Message-ID: <BYAPR12MB309451B6B5540D317691C7C798209@BYAPR12MB3094.namprd12.prod.outlook.com>
References: <20221005110325.31871-1-danijel.slivka@amd.com>
 <97a4e0df-bd79-8c1d-c3b1-af88850e8d3e@amd.com>
In-Reply-To: <97a4e0df-bd79-8c1d-c3b1-af88850e8d3e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5eb29dfd-d0b7-4099-9689-8d6b22f45bc6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-10T08:30:38Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3094:EE_|PH8PR12MB6865:EE_
x-ms-office365-filtering-correlation-id: 82a47cee-c82f-4864-e355-08daaa9dfcf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IjalZzLzOm2vnIs9DwQ6iPGYw9ABB+og13b/p2I/xbDJGAQ0cmNEGD9oSl8j9wWmEnySyQ2gE7KQZlpUoJ5mUMnx+XjGzYF6gZtZnKiMqIGbq5+RZfOTYNYOpwlIcdUJ074XpJLbf0A1pXv4blf16s97TwYYG8FbslMPv9h1fxsjDZ3dNQwiIOh4d2SBQlWItlEMXkH+XOQjel4vjuMT9IJB0gOooGoAF+yWkxXoW2SMCSV0aoSFKIGxlvT5S3M/Aj0CzBc/Js7cVvRwvXXVFIZtu1SxN8X/nHvn/sYrkbrbPAWaRRHagxfqPG12X+SdtaE8BkGWTuxwoIIaBeIYAsdM7VYWP9ndhEQMiruKWGZtJu5QzHgUIpWyiuBAb0BHabkxUukUoO7NjhkIbB4wBryhwBRIHRXd6rJGWryWq5FtbzV9eUolpiKOGa5vyUo0C6hBS4jgKxHp9wSGC98LVJKSP8u9X+872fW9K0x8thW8EUNhHLyBg7KrigdPO2G6zbCtMtAEIeqlNtwDkPg0JUqDF699HmJIpBg9R49NzWVMG++pV1wTBEPbjzs1EKHrf2M4+bsGx/GfH5hM1Yn40J0d0/IOYh73b3Sv4tNclI4OIOx1ot+MsIcaqy3Vk2GXNylbitLjxQDy6KXKuynwXT4kKDFGlJXvlGCuoyRVSDu9EVNZ574kvNyGwoKv7IwirR3LXwkScaixFEs3HFYZLCZdFrDneHzMBzfjhWlwITtYjb6bujHSoA1ytRhzJrWCw8hSs8TqITKiAHrbjLc5+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3094.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(33656002)(66446008)(38070700005)(86362001)(55016003)(66476007)(110136005)(64756008)(2906002)(76116006)(9686003)(478600001)(8676002)(66556008)(7696005)(26005)(316002)(38100700002)(122000001)(83380400001)(5660300002)(6506007)(71200400001)(53546011)(66946007)(41300700001)(8936002)(52536014)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um9hb1c0bENnU2lqUGwxSzF5aGFCa3h4UHVtTEgvVE1RR1VWNkJrOEluYnQv?=
 =?utf-8?B?U1drZmpxL0d5VHFsQ2FnRDNNTFNDc2dIbTI4azZ5RkVBaGxXQ3laZTBCajFH?=
 =?utf-8?B?cVlRblQycElOMmZ0Tk01TVdLUEdWUUV2SkF1TnlYRVc3eEZGblMxYUZ5UGN2?=
 =?utf-8?B?dXpMRWhZRFpMNzlFS29QM3pRaVoycHlXOEUzSHk1UUp3UmRURkl4VUYzRE9O?=
 =?utf-8?B?TlRZZXV6Z0o0L0x4MGRmRXc2eWtzcVdRQjBaUHJYNWFMZGhPVHY3eHJiQk16?=
 =?utf-8?B?V3hYb3h1bUl3dE9GeGpodUJrbmhHVTh4d2czRy9zVXUvbTNiY2hPajRRNUR3?=
 =?utf-8?B?SktyNFM4VUJOWjJCMDVEU1pKYWxEa2ZwR1VVWHhYVG9WMkVpbUFlL2ZYUy9n?=
 =?utf-8?B?UGNsclNyM2xTL0NHQ2g2QXBuQmw5V1FQSUFoQnNMTWZmanFhS3VvNSswSFFW?=
 =?utf-8?B?QktIcjhPVStoSkZYSndhR09VVXZPbEVQWmx3OHc1Q3hlcnFYOGNieXFWRkd2?=
 =?utf-8?B?N2w3L0NpUEdjSmFWZHJxZG9MSWlENHhyL244ZndhNGVCT3ZlWm5qUzl5T1px?=
 =?utf-8?B?Ym9pV3p4RXo2elllanNtbUU0NW1uVXNCNmVFR1pBSVppL1JlZk9xbDVpVVV1?=
 =?utf-8?B?a0VRY0JvMWxLY081YmFlbUFNcEp3c3NidFBWem5scUtXbHY1ZVJPUWR3TWNp?=
 =?utf-8?B?U2VoVlRyS2ZnUEg3aFlZWTlmUWt0QzE3Z01zZk5lZXRGNlJ2akFXWGRzVTFG?=
 =?utf-8?B?VlZGTnhXWWFhSkJKcUptc29TTkcrYlB1V0tqaTFYTk82c2VpamRiNGt1ZWo1?=
 =?utf-8?B?SlNBRGNUMU80WFNidVNRcHVGcEJxSkQxWERwZjdhWmVITlBwb2lNZVV4U2NN?=
 =?utf-8?B?aHFVdy91Mmw4bENEeGJtY0RESWNxWW5US0hPWUo2SkI1b1VwZm41R1BvVEEz?=
 =?utf-8?B?OS96ajRKcFc0cW96UWVDMklSS05YeVYzZ0JVNWJMZStHVktoODY4NlN6dFlr?=
 =?utf-8?B?cW9EMlpvR2tUTzZvMFNZa2lEb2IxSGx3UC9ORG05SHNyQ09nZWd3VnVzWjRQ?=
 =?utf-8?B?WVJYVmpYNm44UFhFaHZMVE9FaE9FWUV5Q1U0NkZmV0hqMERpaExkMVNSeGZT?=
 =?utf-8?B?K3B3OFlEUHRqa2hBZkZvQWc4R0QwckFxSjlkZ1BMbVVPRllmaUxzRVVRWkNL?=
 =?utf-8?B?TEoxWXVqRjd3bHc0Q25Na0V5NEhrdnRNMk9LbkNFQm5xU0JERFQ5M3doU3Ri?=
 =?utf-8?B?NmRqejcwQ29sbmdGY25WQ2NQZTlkYy9QZDdyQnB6S2d3LzAzOUQ3djNQN0dW?=
 =?utf-8?B?TU5aanI3SmFkM0EzTXoyU3hWNEZ4VE9hZkJiQ3lCa0ZDSE9zWk5leTFHU1Vo?=
 =?utf-8?B?R3BLM0ZqOEI3UE5oY0dKbWpEWk1vT0dIOHZzNlYyeWs0eUEzVDlMQUZzUGFF?=
 =?utf-8?B?cm5WcUk5c3JpVjE3VmVvckhRNFErM0FaTURaaW1NWEpCYXcwYys2Nld0dU4y?=
 =?utf-8?B?L3EzQUJQSWZIRVlKOFZFMEFkSDZKZGxELzF4Z3gwNUdBS3Uyb3dmS0hOWDNw?=
 =?utf-8?B?bWtRYkdJamIwRXBtazkya0xHa0tSVHVvd29xRnpEZ3k0dW9EZUdMTXYzTndw?=
 =?utf-8?B?QWVZL2VlcU5HdnVnRTFYVFBCd0JZeXhIVHNSd1lnUGV4OTJNNGhqa3l3SFhp?=
 =?utf-8?B?SVB5V2JoWHdLRW5RNkNwbjQ4aFR4b1h2WFhlUHo1d1lGK29tcTZ1QWp0a3V4?=
 =?utf-8?B?YWFIaU1YVTgxd0xGenBPSlZHRGRyNVNMalhDeGJOV2pGdktiSHFZNVNRemRC?=
 =?utf-8?B?UkxPNTdwUTE5SzhaZkw1NGRmNkVwOGk3MTQwb1dyVWJJVE1FZUI3Rmh3Z0JR?=
 =?utf-8?B?dEQ2aEJQQlBUQnFSYjNRNE54MGJzSS9OYXc4NUFoeTJHSlNIUjJsUTFUaVdK?=
 =?utf-8?B?V1p6dE5HK2JDQSt2QWtXR3lDYkdGSjhuWVNzUjl6aStWTXFFVkhZbFoyQXVa?=
 =?utf-8?B?ZlgxNWQ2K0RQakdmbWVraXhxcjNIWEtMWnE0MkppOHJDa2FaZm05SGlzZFRk?=
 =?utf-8?B?OC8yZnorbEEyTm1GT2NSV3hESFRjTUpacWpyR0YybUFIVU1hdkVyYXNvN0hZ?=
 =?utf-8?Q?0W3M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3094.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a47cee-c82f-4864-e355-08daaa9dfcf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 09:01:15.6503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyWMYjQKPlWZFeG3uI8izmS74QpXRXx3ga47UhUP+um58V+Fn9cAQVTUXRVSeSqEf6bCuzjWVhzOzz20Ys7z0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rIHlvdSBmb3IgdGhlIGlu
cHV0Lg0KDQpSZWdhcmRpbmcgZnVuY3Rpb24gYW1kZ3B1X3ZpcnRfbW1pb19ibG9ja2VkLCB0aGlz
IGlzIG5vdCByZXR1cm5pbmcgY29ycmVjdCByZXN1bHRzIGFzIGl0IGlzIGNoZWNraW5nIGlmIHJl
YWQgb3BlcmF0aW9uIGlzIHN1Y2Nlc3NmdWwsDQp3aGljaCBmb3IgVkYgTU1JTyBhY2Nlc3MgcHJv
dGVjdGlvbiBpcyBhbHdheXMgYWxsb3dlZC4NCg0KUmVnYXJkaW5nIG90aGVyIHN1Z2dlc3Rpb24g
dG8gc2V0IHRoaXMgaW4gc29tZSBjYXBhYmlsaXR5IGZsYWcsICB0aGlzIGZsYWcgc2hvdWxkIGJl
IHNldCBhZnRlciBWRiBNTUlPIGFjY2VzcyBwcm90ZWN0aW9uIGlzIGVuYWJsZWQsDQphZnRlciBk
cml2ZXIgaXMgYW1kZ3B1IGRyaXZlciBpcyBsb2FkZWQsICB0aHVzIGl0IHdvdWxkIHJlcXVpcmUg
cmVpbml0aWFsaXphdGlvbiBvZiB2bSBpbnN0YW5jZXMsIHRvIHNldCB2bV91cGRhdGUgZnVuY3Rp
b24gdG8gc2RtYSBpbnN0ZWFkIG9mIGNwdS4NCg0KV291bGQgaXQgYmUgYmV0dGVyIHRvIGtlZXAg
dGhpcyBmaXggaW4gYW1kZ3B1X3ZtX21hbmFnZXJfaW5pdCgpIHdoZW4gaW5pdGlhbGx5IHNldHRp
bmcgdGhlIHNtX3VwZGF0ZV9tb2RlPw0KDQpCUiwNCkRhbmlqZWwNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNv
bT4NClNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciA1LCAyMDIyIDY6NDMgUE0NClRvOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgU2xpdmthLCBEYW5pamVsIDxEYW5pamVsLlNsaXZrYUBh
bWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gZHJtL2FtZGdwdTogc2V0IHZtX3VwZGF0
ZV9tb2RlPTAgYXMgZGVmYXVsdCBmb3IgU2llbm5hIENpY2hsaWQgaW4gU1JJT1YgY2FzZQ0KDQpB
bSAyMDIyLTEwLTA1IHVtIDA3OjAzIHNjaHJpZWIgRGFuaWplbCBTbGl2a2E6DQo+IENQVSBwYWdl
dGFibGUgdXBkYXRlcyBoYXZlIGlzc3VlcyB3aXRoIEhEUCBmbHVzaCBhcyBWRiBNTUlPIGFjY2Vz
cw0KPiBwcm90ZWN0aW9uIGlzIG5vdCBhbGxvd2luZyB3cml0ZSBkdXJpbmcgc3Jpb3YgcnVudGlt
ZSB0bw0KPiBtbUJJRl9CWF9ERVYwX0VQRjBfVkYwX0hEUF9NRU1fQ09IRVJFTkNZX0ZMVVNIX0NO
VEwNCj4NCj4gU2lnbmVkLW9mZi1ieTogRGFuaWplbCBTbGl2a2EgPGRhbmlqZWwuc2xpdmthQGFt
ZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
IHwgNCArKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiBpbmRl
eCA4M2IwYzVkODZlNDguLjMyMDg4YWMwNjY2YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMNCj4gQEAgLTIzMzgsNyArMjMzOCw5IEBAIHZvaWQgYW1kZ3B1X3Zt
X21hbmFnZXJfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAgICAgICovDQo+
ICAgI2lmZGVmIENPTkZJR19YODZfNjQNCj4gICAgICAgaWYgKGFtZGdwdV92bV91cGRhdGVfbW9k
ZSA9PSAtMSkgew0KPiAtICAgICAgICAgICAgIGlmIChhbWRncHVfZ21jX3ZyYW1fZnVsbF92aXNp
YmxlKCZhZGV2LT5nbWMpKQ0KPiArICAgICAgICAgICAgIGlmIChhbWRncHVfZ21jX3ZyYW1fZnVs
bF92aXNpYmxlKCZhZGV2LT5nbWMpICYmDQo+ICsgICAgICAgICAgICAgICAgICEoYWRldi0+YXNp
Y190eXBlID09IENISVBfU0lFTk5BX0NJQ0hMSUQgJiYNCj4gKyAgICAgICAgICAgICAgICAgYW1k
Z3B1X3NyaW92X3ZmKGFkZXYpKSkNCg0KVGhpcyB3b3VsZCBuZWVkIGF0IGxlYXN0IGEgY29kZSBj
b21tZW50LiBCdXQgSSdkIHByZWZlciBhIG1vcmUgZ2VuZXJhbCBzb2x1dGlvbiB0aGF0IGV4cHJl
c3NlcyB0aGF0IHNvbWUgQVNJQ3MgZG9uJ3QgYWxsb3cgYW55IE1NSU8gYWNjZXNzIHVuZGVyIFNS
SU9WLg0KDQpJIGZvdW5kIHRoYXQgdGhlcmUgaXMgdGhpcyBmdW5jdGlvbiBkZWZpbmVkIGluIGFt
ZGdwdV92aXJ0LmMvaDogYm9vbCBhbWRncHVfdmlydF9tbWlvX2Jsb2NrZWQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpLiBXb3VsZCB0aGlzIHJldHVybiB0aGUgY29ycmVjdCByZXN1bHQgYW5k
IGNvdWxkIHlvdSB1c2UgaXQgaGVyZSBpbnN0ZWFkIG9mIGEgaGFyZC1jb2RlZCBhc2ljX3R5cGU/
DQoNCk9yIG1heWJlIHRoaXMgY291bGQgYmUgYWRkZWQgYXMgYSBmbGFnIGluIChhZGV2KS0+dmly
dC5jYXBzIGFuZCBnZXQgaW5pdGlhbGl6ZWQgaW4gc29tZSBBU0lDLXNwZWNpZmljIGNvZGUgcGF0
aC4NCg0KUmVnYXJkcywNCiAgIEZlbGl4DQoNCg0KPiAgICAgICAgICAgICAgICAgICAgICAgYWRl
di0+dm1fbWFuYWdlci52bV91cGRhdGVfbW9kZSA9DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEFNREdQVV9WTV9VU0VfQ1BVX0ZPUl9DT01QVVRFOw0KPiAgICAgICAgICAgICAgIGVs
c2UNCg==
