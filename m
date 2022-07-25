Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9453BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 03:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F75113DEC;
	Mon, 25 Jul 2022 03:09:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95935113D3C
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 03:09:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjxSf/3zREKDyix9Wf0+Z8t+AIspiDtrYoUfYrJWvJgsq741TBWDYi9THrnAH9VzMN3ZeElmImAfBgJNkOUevLDTS1UzqbECGj1ZIODXNTG/TKpwrPNXIi8kr9CLe9EZRAJ7uc1w1//eRvJvVBhFjh2na+jhzUzK8qOJwEDl0b+K3rIVxpmGmzOcQpNtHLLvKfe5uWnDd1l6FvplwE8+IkPHH6IWvNLRiDW9Au4b20M3kV32vjLEu7hNeMkww2yQvmS7w1xqU05T6JKTHF/MbYfaTctMukBZ4011hFcDNPPLnif46TSfjTw1Y/A2vDwDblYmgnXX9q9M+ef+Bn5YKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiJ+z78Fr3kXNIeGwjJau4DdcvQH281ZqE1NRdaSFW0=;
 b=UM9vba6XVLWbzx7y+3zOTjI18g5WvG4OCv57vGUQVo/0CRXMdMkh8awuAFsb0dp1deD1ZTWdHiFNSMmIXND+yHH19S99UU4KtC50jMMDJ+LgP5cl70LKaIBPzjJFePvL3LxOy8gfrsR10VEpWS5yK/G/s8NpiORUtyS1BSrrgBXN9IGehaG2Y8ZQGsk6reJGXShYG0qAUFmxq8oO81ksjDsAFDePJjeuYg3mQ+yCtAyTrrKT1T32fFodumlgzlubw452/18wRjtmH6PA4l7jfJuOmJDDiDmnPwiz7/f0S0aF2c+RCrxD4gnNzELYS+P5axPxHFjNkKyMjWxRTp9osQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiJ+z78Fr3kXNIeGwjJau4DdcvQH281ZqE1NRdaSFW0=;
 b=jeKLvWbtCwzxMNynhTpGF7YmNDLm4a3M+WQnh0NJFVO4sXGnjXQdBBPfZ/VHlnOe4TnzB7Oqchu/85n5XJOrmhWQMPzqqmxwlSKZpjXdDQ9Tcd05jhNxk569XTDuSLf3jQhyvzpzCa0nn3c1hS5AVwPq9iPjUoyOMyt0CR3p+Ag=
Received: from DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) by
 MW2PR12MB2508.namprd12.prod.outlook.com (2603:10b6:907:9::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Mon, 25 Jul 2022 03:08:58 +0000
Received: from DM4PR12MB5868.namprd12.prod.outlook.com
 ([fe80::3cd1:3811:5902:6aac]) by DM4PR12MB5868.namprd12.prod.outlook.com
 ([fe80::3cd1:3811:5902:6aac%3]) with mapi id 15.20.5458.023; Mon, 25 Jul 2022
 03:08:58 +0000
From: "Guo, Shikai" <Shikai.Guo@amd.com>
To: =?utf-8?B?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Subject: RE: [PATCH] drm/amd/pm: Add get_gfx_off_status interface
Thread-Topic: [PATCH] drm/amd/pm: Add get_gfx_off_status interface
Thread-Index: AQHYnN/6h7Co02nH2kSxrBQ5TZsijK2IzNCAgAWhB9A=
Date: Mon, 25 Jul 2022 03:08:58 +0000
Message-ID: <DM4PR12MB586857EF67550C2FE3D00C329F959@DM4PR12MB5868.namprd12.prod.outlook.com>
References: <20220721085738.2528792-1-shikai.guo@amd.com>
 <25175965-26be-f7fd-cad3-bc00885c5dfa@igalia.com>
In-Reply-To: <25175965-26be-f7fd-cad3-bc00885c5dfa@igalia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-25T03:08:56Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=09f66490-dd56-4a57-afcd-883c14f1f131;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-25T03:08:56Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 68104aa3-abcb-4f8c-bd80-978ca22a9db9
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71123648-374f-41e4-4bdf-08da6deb045c
x-ms-traffictypediagnostic: MW2PR12MB2508:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sM4b1w/D0g541aGm0cy+SArliyVuEuRZygoWOmnuXZapyQgoOmgHI0ExzTtdRMdOlxNvnXiJhv3vy72RZq/SjaZrTzDNz+4eiSRuxSsZU+s9d2TXKxewY3UoSXZ8WtNU1JPZ4gP+HYx35cqwbn/5dMU94P322ijNJ6xXwnmSjzrJ3v2nJFdhm4C69FIphu0vVYNJ2+I7YRYWAh0QLD+en+WN6Zi7K/yMCFS2irm9NX47nlASkZQWzqxaAM/xpiaFIJRdnIIZCnG6XgqaXkYe5/C2spBA1nokCtn//JY7xYFA5RIiUO0s8dEP2TxftzJAE2eEFYzOMro5aAgMnvki09u2EbwyWxrdKL5cnm2rhOxstg33CkWzaedYoIfeK3TNJZn93KD6rehfQIGwQJjgN9XMDOWfd8EE8s+wyzwIDi0fwLUIpjBxZG3umLdLUMpP0pBGWNvr286fRWOYkxpxCgMDtj3lDS6vn81nEGCtpmdXQvoE+dEDGRhEuh67z13qnvRE+ZGnIVBqchfeYV1nC7lEBn3VUStOLcr5Nn3iD6Vgp71qA3dkKGPXHqsa0wjEyB0Toy8EKHj2qY5EG1lATQwgWFGfX67xg/FbkDX/yxiYeEdPhS5L+YgYu9u8F6Oae4yaJprwgPrmbEhtwEziEGKei/LHXce2az/FX3Ii6jh6OEAjPa6kcRLWvUxkkdpzxRw40AqMRLfjw63QxtNC01ZDw48xX8jTocbc4az6FPfxzELt2aRlJ2YIkApSUI7TQ5SvNzMc45omnMWgiW0pv6lVenX7NtfY03DKRV8PIGCywCzllsg7MxcggW5L6JKG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5868.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(26005)(478600001)(9686003)(186003)(53546011)(8936002)(4326008)(6506007)(33656002)(55016003)(7696005)(71200400001)(41300700001)(86362001)(38070700005)(122000001)(83380400001)(316002)(2906002)(5660300002)(4744005)(52536014)(66476007)(66446008)(8676002)(54906003)(6916009)(64756008)(66556008)(38100700002)(76116006)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NG1NbS9mZjB1RExHVmZUaWhDWHMvc0tLNFcyZlZ6ZHdFRklmYWVkZHpFWDhm?=
 =?utf-8?B?aE9UemFVT09UakpFd3FTWjcrS0ttUStLS1U2eFpTOG5XcE56RWtLNUlHZ1dn?=
 =?utf-8?B?OGJWMEhBOEZrRXU4VXhZaHVFeE95ak4xa25pTTQycVd6aFVmcGYxckxMV2Ft?=
 =?utf-8?B?L2hiSzlNbWowb0ROcEFCaW1JUW53K3lzaHRLMWVsaWJxL0lvODZuYmlEV3Nh?=
 =?utf-8?B?cDhVWHRJWXJjMnA1dlZ0bEZqdnpkUkI2MS94VmRxeW9OUkFtWDl4eXR0SSt2?=
 =?utf-8?B?SjRMV2pYSDcvU3duVDU2NUd1dFFyL3lEdUhNOTAxVjMyTTRLMlF5Rm5GeTN6?=
 =?utf-8?B?VnUvMHpBM3NLZ0FSTUpoUEg1UTk5TVZIVHAwSFRoN1RHVUpBd0VvL211dUE5?=
 =?utf-8?B?c1orNmNsWWJQZkNkN0wzZ0lqV1JWQlp4Vnd5WkpNQTlwNTR4b2YraTJ2S1ZP?=
 =?utf-8?B?T2VLbTlOYmhvZkxnby9qZVprby90Q0QyVDU2MHVyaktrN2dYZ1JTamR0OUxK?=
 =?utf-8?B?TkZGSmp0TWVhVHdDVWRHOWF0Wmo5cmpNSU1Ta1hpeDhETlVpUzQvREpnTG45?=
 =?utf-8?B?bmRTRDhRdVU3QUVaM3FDYlZBcVhFd09UUVdLYmtFK3N2cU1KWXRKYURKQlZV?=
 =?utf-8?B?N2dRR0ltL2tXdEUzdDQ5ZUwxWUNYamdTTy9oN3htS2Y3dDNsblJNNnhNUDdt?=
 =?utf-8?B?cXRYb2EvdzZhdWlEc0d1TExiWFN5ak9BY2xqRTdVUCtZMDhMdnViaDQybzM1?=
 =?utf-8?B?RThTWXZnTEZPcm5vRjF2ME9WTCtXS1dIYXlSM1JpVG8xODFDbnF2S1JHSWhz?=
 =?utf-8?B?ekFzUlpKa0xNczJmWkRUTnNxUkp6M2dsTGJDaUhUQVdTMTlJb1ZFUEl3ditX?=
 =?utf-8?B?M0RlYjc0Vk1wS0EwVnliWnFqSUh6eFR1U2NEUlRLcDkvaE84UXRZQU1wYWRy?=
 =?utf-8?B?QzV1MG9qQXZlejZCVUhwVGQ2dEQySW15R0VuSWVFaEJpd1R2UGNIaWdHbGpR?=
 =?utf-8?B?QW44UUJMRXNFeUZDN0RYaU9Ham5hQmRtcVFjdjV2YnVvUFNhV010VXI5TlJq?=
 =?utf-8?B?NnpVSVhYaXdJZ3U0Tmh3WGpldEsvVTVPNUFoUitSWlNveVFwMk1LNWhZejJK?=
 =?utf-8?B?VHQxYk9qL0hKQU9VUVB5NWdMcitLWEZFMmd2elZiT2FTdExsdlBnR2dXbWdE?=
 =?utf-8?B?anR1YWkvYWJSL1pUNUxpUEtPSFhmV3h4N1dpUGlkVUJYNHdsNENkWG1wQngy?=
 =?utf-8?B?NXp2NDU5MkJVZzhzakR3VGo4QXdpTjM0cWhNNXA2LysyeTZSYkZRTEdONFZx?=
 =?utf-8?B?dUhXSVJudks4elQ5OW1FU21SS2hnTEdRcVNnRWZhUm1hcEptWGZJeHlEZkRU?=
 =?utf-8?B?OFJSd2owamtIUGRHYlg2aWpsUDRBWlY0bUpseTduRWQ1Q3MzWW0rWTJTc2tF?=
 =?utf-8?B?ancxQTh3V1BxRmpPM2FGNUVrWWxmYXdUTyswckhyL285eC9LSFhwQmxKRmEw?=
 =?utf-8?B?M3A0L09ETHgybzcvb2RBbVQzWXIvZm1WME5lcWpBS1d0VzNMeCs4NUZ0b1Fa?=
 =?utf-8?B?TXpiemlnRmZLNXBYSW1uR1JabldOMGxsWkVBRFVndzRzYUtUdVFzeEdIUXc2?=
 =?utf-8?B?ZlA0NkZkL2s3bHR2dUhRU2FBSC9qY3dMMGZGd1BrNDI4OGZwRVlnTzl2QmpL?=
 =?utf-8?B?YVNnQVRvQ291VEN0OG53Qjh2ejdFUFlaeGpUOFoyTlNIN0ZFS1VYRXk2Wmty?=
 =?utf-8?B?OHRKMnZMcHN0VklkN3JDdXNvWVBhTno5Y3VtTFlMZmxWL3FRcTc2SlZjN05K?=
 =?utf-8?B?bm16YmpSczdUb1FhTmFMZDJWWEE3WU1IdjdlUVMyZllSaC9PTGdzM0tyT2w3?=
 =?utf-8?B?dDZNNVBYMFNYZTFNcTNwd1h1Rk8vamxUeTVBSUZQYW4xS01sVTZGWmhZWEx1?=
 =?utf-8?B?SzBUVVVJVkpnbmxNcjgwOXFHTVZxL0pyUE90Yjc3TklVZjJ0ZU1reTBYRm54?=
 =?utf-8?B?UW5MT3hTcyt2S0QrNm9qYVUvREF5bEJpaXBqNGdFWWZUZjk4c3ZoVlVyMkc5?=
 =?utf-8?B?VFVZOW1PQ2QwbTBYNDUzTno5ZU5MUm9DeTRDMUYvRTZDWUVzV3VMK0JFSGdX?=
 =?utf-8?Q?l+0rb7s8uki9CbiYEI2/t88g9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5868.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71123648-374f-41e4-4bdf-08da6deb045c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 03:08:58.4206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndnTfGGabUYZi6wMcIq6j0SpLspd8ZnZNPanbvWMEuSHSTy+E1jCB0/qkHFDei8Zac3EzXKw898qIyBN22ymrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2508
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KVGhhbmtzIGNvbW1lbnQsIEkg
d2lsbCBjaGFuZ2UgaXQuDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQW5kcsOp
IEFsbWVpZGEgPGFuZHJlYWxtZWlkQGlnYWxpYS5jb20+IA0KU2VudDogVGh1cnNkYXksIEp1bHkg
MjEsIDIwMjIgOToxMSBQTQ0KVG86IEd1bywgU2hpa2FpIDxTaGlrYWkuR3VvQGFtZC5jb20+DQpD
YzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNv
bT47IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJtL2FtZC9wbTogQWRkIGdldF9nZnhfb2ZmX3N0YXR1cyBpbnRlcmZhY2UNCg0KSGkgU2hpa2Fp
LA0KDQpDb3VsZCB5b3UgY2hhbmdlIHRoZSBjb21taXQgbWVzc2FnZSB0bw0KDQogZHJtL2FtZC9w
bTogQWRkIGdldF9nZnhfb2ZmX3N0YXR1cyBpbnRlcmZhY2UgZm9yIHllbGxvdyBjYXJwDQoNCk90
aGVyd2lzZSwgd2UgYXJlIGdvaW5nIHRvIGhhdmUgZHVwbGljYXRlZCBjb21taXQgbWVzc2FnZXMg
Zm9yIGVhY2ggbmV3IGFyY2hpdGVjdHVyZSBzdXBwb3J0aW5nIGdldF9nZnhfb2ZmX3N0YXR1cy4N
Cg0KQWxzbywgZ2l2aW5nIHRoYXQgdGhpcyBpcyB0aGUgc2Vjb25kIHZlcnNpb24gb2YgeW91ciBw
YXRjaCwgdGhlIHN1YmplY3Qgc2hvdWxkIGJlIFtQQVRDSCB2Ml0sIGFuZCB0aGUgcGF0Y2ggc2hv
dWxkIGNvbnRhaW4gYSBjaGFuZ2Vsb2cgY29tcGFyZWQgdG8gdGhlIHByZXZpb3VzIHBhdGNoIHZl
cnNpb24uDQoNCsOAcyAwNTo1NyBkZSAyMS8wNy8yMiwgc2hpa2FpLmd1b0BhbWQuY29tIGVzY3Jl
dmV1Og0KPiBGcm9tOiBTaGlrYWkgR3VvIDxTaGlrYWkuR3VvQGFtZC5jb20+DQo+IA0KPiBhZGQg
Z2V0X2dmeF9vZmZfc3RhdHVzIGludGVyZmFjZSB0byB5ZWxsb3dfY2FycF9wcHRfZnVuY3Mgc3Ry
dWN0dXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2hpa2FpIEd1byA8c2hpa2FpLmd1b0BhbWQu
Y29tPg0KDQoNClRoYW5rcywNCglBbmRyw6kNCg==
