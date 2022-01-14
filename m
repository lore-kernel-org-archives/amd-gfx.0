Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FD1C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 16:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6808810EADA;
	Fri, 14 Jan 2022 16:48:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6752B10EADA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 16:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuyyL+K/OCrRBIRsdNNBZ1Qd47+7YFlpiNF1Bb9kSN9vab+deZOA90G//wPQnfkxEiyehZbi4KyMcXK7BvpBPDXyU3s48E5rqDh7fVsCsCMgHiLiQlwfZR7C7qulV7sWLuyrIGJr+7ks+gJwGlO2NHi4BiCXl5x1U65Vlbzs3GqWVtAT/b7kCp39gj4XlLTL8/XgFtXn1kJiyAvoQWANIVJPIthrilS0BreTAVuKcCgrEGbstc4lSA64blmVPoDgJdODWrC4AjtNtu+DwFSwEv8b2jBzwoBIxFHVZ6bgRJTDBl71/ZJ3U9bAH7TssgyRWEcjJ8RNnW9PcxMefbHHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O763gDyqLSwB+et61Toz4nI8AeGqjFs4195ef1yvFiE=;
 b=QPrjQqYCNxN/j4AFqT5pDU7T/kIxy3xNxmAuRBTZa39uq+ZlDdGSwAwNvCmRxgREbQA8DWRBbRcd3WknqsFzzJk0uuCCEu7M7TwrbSfWXw0Sh/F3EGfoaULvWAYzvCtXTpcxNiUBgbL6Xi+Lzl4hI2FoBQ7IZ4faIdSeI07CGo3jjjXAvKBBg70mLL+SeUCM92NfY4brSVe7l2JHrX7+A8W/WNH1MVIhcJv1AU2/DiDgygPkzc4sWI9duwE74OjGSEV2OWiuPnSIVDKH9pDv8A4PBo0th7epfJe433OogyW00Er1QY2B73FXDc6yBhXogpuOh9rAD0toLhT5BCZNlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O763gDyqLSwB+et61Toz4nI8AeGqjFs4195ef1yvFiE=;
 b=HxIOqCYXpG66ATv2y/v+M27RU1agPeH0ccy64K5GsPscbZcWHuXV4R2iOIfP7YMLs8vnIBF7pe8epNWNJJmfNkpkElop+cJGd6E2YACd4369LoKB//lfvC605mXg+sNLx5JolDtCZaIXmliVBTOkjxL6A2+Ac2svyG7W1cdYzU0=
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by SN6PR12MB2783.namprd12.prod.outlook.com (2603:10b6:805:78::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Fri, 14 Jan
 2022 16:48:38 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98fd:4e9b:b4d6:64a3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98fd:4e9b:b4d6:64a3%7]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 16:48:38 +0000
From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, Chris Hixon
 <linux-kernel-bugs@hixontech.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
Thread-Topic: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
Thread-Index: AQHYA+ae6sg+dIaBJUyRjV2fOt6qWqxXxhOAgAAhVQCACpQmAIAANimAgAASZ4A=
Date: Fri, 14 Jan 2022 16:48:37 +0000
Message-ID: <DM4PR12MB51821F1E18FB484415BACF31EC549@DM4PR12MB5182.namprd12.prod.outlook.com>
References: <20220107164959.12511-1-mario.limonciello@amd.com>
 <DM4PR12MB51821C74C0F9C8254A8CE048EC4D9@DM4PR12MB5182.namprd12.prod.outlook.com>
 <BL1PR12MB5157D5DC6BE941A1C1294DFDE24D9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <991bfaea-2978-321d-deb8-cefa4572877e@hixontech.com>
 <BL1PR12MB5157374DD79D0BF24D907DE3E2549@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5157374DD79D0BF24D907DE3E2549@BL1PR12MB5157.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=df56ff08-9ecc-4e57-9cfc-9f6884e9433f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-14T16:44:22Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1cc3d01-6ef0-4431-8f7b-08d9d77db678
x-ms-traffictypediagnostic: SN6PR12MB2783:EE_
x-microsoft-antispam-prvs: <SN6PR12MB2783AE130D95AE0165107005EC549@SN6PR12MB2783.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y5DkvmsEWdjYpEdDr5/CHBvN4LcilNaXNHDEsN4gGNfQhWt+A78ERdLqC7kontK+vLtRpM0r/0IsWouCJoC0cLQT+ZOvPdKpG3y3ql9HT68YciWF4ZzHuBhoQ6KvIqF5j3pWflJp92g30vStX63Ab+IQH9mpaPpW2UOU9vIkvvw3LygX3WjxFu0l/rq0B9Qn60LqTCLs+PDuKZhr2F/SToZzn/m0jtwtJU3t6duiyMRcV7pYTB7B1jDiaQOjhw/jPWg8sWIEuHiiyTjvbLJjz5r1ai7yAIJ3PSayV5bFWcNYXMMjSvlXa6p0f5yYedJJu1WSHqCBpwmDTwl2GSy57MTNZQjqdp4mYlkl6Mk6HxtMoMe3f27NqHWj3z8O0aEZcp01o+0xkJB2lHCT88qBYLjTNAOWuMhublkaA+OCgQzJ7FDWlhOIgXd2XMK5v7SOXGUeyW8yCsVuzZt8vTFPovSGySTdliKC9VMu8KH4W3thgS/3e/MHa0sPx/phMIxncyAvM+FohAMSnmRoe/MCSxz+w/Xm2+dtNEvYiVJLOtFDGGO/0Ry/hF76OCSfbDALcnDSWhhtIauz8f4YW4ugCrd/Tf1b4mHFzkhIXwiHz+e7Z+G9x91BdHW5rh2uBmquHDcLZAOWUN+uG28wZ/A19wccF7stxviaAQaRUeCg6R34s1xzAf6yJpmxKmq7czHTdzldp1SGbbWgOq9DlfLvw25FLvpkOSVkmedWx5MwW2k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(33656002)(316002)(66476007)(8676002)(66946007)(76116006)(186003)(26005)(66446008)(54906003)(7696005)(38100700002)(86362001)(83380400001)(66556008)(64756008)(110136005)(8936002)(508600001)(71200400001)(52536014)(122000001)(4326008)(9686003)(53546011)(6506007)(2906002)(55016003)(5660300002)(473944003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXZZNitzdHhqeUU4M3V4eldNcTc5S1dFQVNkYVg1bS9lQ0FlcmpvZW9LcGpO?=
 =?utf-8?B?blJObDR0eHlyeTAvMVVNa3cvMW15TzdTR0tucGdmYnE1L3VMd0NqMFMzZTk3?=
 =?utf-8?B?aVV4RmdHcC93L0lLQ25pb2ovYU8zT2FBWUFzVUp6cW1qOGJ2b0F1R0Z2MS80?=
 =?utf-8?B?cWU1Q2QxcFRLRjJoZjFCcElOaFppMUJOTDNpeldWbGk2N29rV2R1MS9BUVhq?=
 =?utf-8?B?TlBSaVVyWFZQaTgzYlQ5QnZSRU11cWxhRWk2M0JJYmg2SUJNdnVtNW92SlZJ?=
 =?utf-8?B?MkIzV3RGc1F2dHRGdjc5d0wwK1VBdHUzdjFaZFhRT204LzZ6bmRwRFE3N1pI?=
 =?utf-8?B?ZERXRUdBT2N4b3h5UCt2YmpCR2pBRlI3V2hVZHBHRXNGUU81dnhXbTdHaDFl?=
 =?utf-8?B?TFBBT1JQZ1Nkb3hpSjd0RVBTV3dqL0dWTDY1bFZncjgyYktVejRzY2luV0E5?=
 =?utf-8?B?R25NVUFYL1hzYTFnWHFSb3AyRXVQZCtCaW9BWitxNUszNVJMcVFpSmhwY3hF?=
 =?utf-8?B?cjBHczJWbTdEV2pwMk5HaW1rUDhadS9Sc0t1aExFMHBrb3lZTGVubEVZMVRk?=
 =?utf-8?B?dS81VTNibTQzK2lCaWVGcHg0dEhDU01HTitGMmJWQXYzb3RqVkdjWnlEVElF?=
 =?utf-8?B?OWlUOUFsNVRaYVFTVWU4dGw2MUJSMmJHOWI3Y3ltYitTNzJTRjF0SWFlcjAr?=
 =?utf-8?B?SjUzQ2xkZ0h4RllQaWJSbXBQTFdMa01RWmRLeXpVTWJIMHJaY2s4RmVzaUdI?=
 =?utf-8?B?VTUzQVBCemh2b2VOdGpDN0NkRWJxZ3dZdkQrOThRN1hYdlo1TDlHZWFXZ1V5?=
 =?utf-8?B?cW1waFNuclY2N2piQ09qZzZGRm1pcERpOFhVbGN2ZENUcnUxUHFOM0F6RlZJ?=
 =?utf-8?B?SmR0VmNycHJkWFhkcXVSMGNKblVya3VRdnJjUHRoOGh0MTJuTU1tbHM0Um9i?=
 =?utf-8?B?UFE3Z3pmUzdCVFlUL2xXUkp5OUhmeitXVHZLVHVMTlA0Z0FqOEFCSVN5WmFy?=
 =?utf-8?B?cGdQYnhtaFBScHFXQzl5MkJnY0UxcGIrQiswK05lM21CQ1pTcjIrallnS0hk?=
 =?utf-8?B?ZW04SXpnRlNqbUpIQnp0VExrNmR1ZlRVYlAySlY2dlhuNkw3VHV6Ymk0M3E4?=
 =?utf-8?B?allqM0pwWE9RZ2l6OW5TZnNVMlRpSVdvVlltTEFjK1QrbjU4TlBZMlRCNkVT?=
 =?utf-8?B?NUNZWkNVLzFrUVl5d28xUXIxc3NhcmdNcGRsZGxvWXg5bGJiSzViSEpWSGox?=
 =?utf-8?B?QUJvOGFBNUlNTnlMN0VVWHJ4ZnhxczNzTm00LzhNMEFKOVh6c01lcWdDYWMr?=
 =?utf-8?B?eHk2MEdITTRjTGZNKzVQbnBUUDBoaFlFQ2NNMnhYd1NUbC9ZajJQb3lxTXJF?=
 =?utf-8?B?eXhhOUY5K2hYR002MVJqOWVHVHlGcFh5TEg5TkVnc0EyODMxbHdwanA1UmF6?=
 =?utf-8?B?T2hSL29vazArckU3RWZtYjNzeFZ1YjN3cEg0eWpMZUZqK05KRTVRVU8zcHhO?=
 =?utf-8?B?Q242RWw4UC9sUDFVaU05V2pqOExzWkFRRitmeVBsbVRyM3lMTFN2ZkNsQ1lG?=
 =?utf-8?B?SU43TmJydVFYWnNsSHZlV2Y2b3B0aDVpVEY0M2w0YnhhMUUxQlIvT2lNdEJk?=
 =?utf-8?B?eTB5eU5xMnNhYTFiVmI4MUNCYlBXQkEyclZ0ZTcwd0dpNW5JaGFnTU9URmRJ?=
 =?utf-8?B?VzJscVJOUUFTbStOSmVnTjVxN0VGYzFXYUtRTUdBZk5henJ1WlVNNGZ2TVZQ?=
 =?utf-8?B?ZGlhRHhJWXRuUGk3Wlp0a1BVS2Rucmd3d3VENXh1elp6Z2d0bWUxRlBmdVg0?=
 =?utf-8?B?dXlxdTRld3luR3doNXRmSkFIN2t5bFRYbjhFeEh5eUJIOEdqVG9KWUZrRUpW?=
 =?utf-8?B?OHlnbVBxZ252bFVleElQbCs1Y2FoNTlFaXc2RFl6NkJBTnhURE9nVnZtcGJG?=
 =?utf-8?B?eHE0WkMydUR6RHJIYzBXbW5IcTV1QkZ0UnFNOXV2Umw0T0JOVEwzOEdhN01n?=
 =?utf-8?B?V0J5NERvN25XVlRSTHBRYzNjMXkzN3Z4MzJiSCtzYm9MZkM4dGtTSXNYQ1p3?=
 =?utf-8?B?VGlmRUlpaUw5bVRFaDUzbWoyKzQrTkFtREFZMUxPOWcwZlA0QkhUaDE1c3cx?=
 =?utf-8?B?Y3FtYWtycjFmai9aVWlRR1lPalBLTmlUeVZIU2kyUm05MHJYWkJ0ekhDN1l5?=
 =?utf-8?Q?XeaLjiABVePzMU9AiDF2lJc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cc3d01-6ef0-4431-8f7b-08d9d77db678
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 16:48:38.0111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmbT1/TgwbCDfOUH6GyGaDc38VUEENVhR60k/Wetc498dqXVA0jnRiDJgGQ5/DHHDSTc1aseOT6GS0Czwj+g6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2783
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
Cc: "Zhuo, Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>,
 Scott Bruce <smbruce@gmail.com>, "spasswolf@web.de" <spasswolf@web.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNp
ZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IEphbnVhcnkg
MTQsIDIwMjIgMTA6MzggQU0NCj4gVG86IENocmlzIEhpeG9uIDxsaW51eC1rZXJuZWwtYnVnc0Bo
aXhvbnRlY2guY29tPjsgS2F6bGF1c2thcywgTmljaG9sYXMNCj4gPE5pY2hvbGFzLkthemxhdXNr
YXNAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBaaHVvLCBR
aW5ncWluZyAoTGlsbGlhbikgPFFpbmdxaW5nLlpodW9AYW1kLmNvbT47IFNjb3R0IEJydWNlDQo+
IDxzbWJydWNlQGdtYWlsLmNvbT47IHNwYXNzd29sZkB3ZWIuZGUNCj4gU3ViamVjdDogUkU6IFtQ
QVRDSCB2NV0gZHJtL2FtZC9kaXNwbGF5OiBSZXZlcnQgVy9BIGZvciBoYXJkIGhhbmdzIG9uDQo+
IERDTjIwL0RDTjIxDQo+IEltcG9ydGFuY2U6IEhpZ2gNCj4NCj4gW0FNRCBPZmZpY2lhbCBVc2Ug
T25seV0NCj4NCj4gPiA+DQo+ID4gPg0KPiA+ID4+IEkgdGhpbmsgdGhlIHJldmVydCBpcyBmaW5l
IG9uY2Ugd2UgZmlndXJlIG91dCB3aGVyZSB3ZSdyZSBtaXNzaW5nIGNhbGxzIHRvOg0KPiA+ID4+
DQo+ID4gPj4gICAgICAgICAgLm9wdGltaXplX3B3cl9zdGF0ZSA9IGRjbjIxX29wdGltaXplX3B3
cl9zdGF0ZSwNCj4gPiA+PiAgICAgICAgICAuZXhpdF9vcHRpbWl6ZWRfcHdyX3N0YXRlID0gZGNu
MjFfZXhpdF9vcHRpbWl6ZWRfcHdyX3N0YXRlLA0KPiA+ID4+DQo+ID4gPj4gVGhlc2UgYXJlIGFs
cmVhZHkgcGFydCBvZiBkY19saW5rX2RldGVjdCwgc28gSSBzdXNwZWN0IHRoZXJlJ3MgYW5vdGhl
cg0KPiA+IGludGVyZmFjZQ0KPiA+ID4+IGluIERDIHRoYXQgc2hvdWxkIGJlIHVzaW5nIHRoZXNl
Lg0KPiA+ID4+DQo+ID4gPj4gSSB0aGluayB0aGUgYmVzdCB3YXkgdG8gZGVidWcgdGhpcyBpcyB0
byByZXZlcnQgdGhlIHBhdGNoIGxvY2FsbHkgYW5kIGFkZCBhDQo+IHN0YWNrDQo+ID4gPj4gZHVt
cCB3aGVuIERNQ1VCIGhhbmdzIG91ciB0aW1lcyBvdXQuDQo+ID4gPiBPSyBzbyBJIGRpZCB0aGlz
IG9uIHRvcCBvZiBhbWQtc3RhZ2luZy1kcm0tbmV4dCB3aXRoIG15IHY1IHBhdGNoICh0aGlzDQo+
IHJldmVydCBpbg0KPiA+IHBsYWNlKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9zcnYuYw0KPiA+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfc3J2LmMNCj4gPiA+IGluZGV4IDkyODBm
MmFiZDk3My4uMGJkMzJmODJmM2RiIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfc3J2LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX3Nydi5jDQo+ID4gPiBAQCAtNzg5LDggKzc4
OSwxMCBAQCBlbnVtIGRtdWJfc3RhdHVzDQo+ID4gZG11Yl9zcnZfY21kX3dpdGhfcmVwbHlfZGF0
YShzdHJ1Y3QgZG11Yl9zcnYgKmRtdWIsDQo+ID4gPiAgICAgICAgICAvLyBFeGVjdXRlIGNvbW1h
bmQNCj4gPiA+ICAgICAgICAgIHN0YXR1cyA9IGRtdWJfc3J2X2NtZF9leGVjdXRlKGRtdWIpOw0K
PiA+ID4NCj4gPiA+IC0gICAgICAgaWYgKHN0YXR1cyAhPSBETVVCX1NUQVRVU19PSykNCj4gPiA+
ICsgICAgICAgaWYgKHN0YXR1cyAhPSBETVVCX1NUQVRVU19PSykgew0KPiA+ID4gKyAgICAgICAg
ICAgICAgIEFTU0VSVCgwKTsNCj4gPiA+ICAgICAgICAgICAgICAgICAgcmV0dXJuIHN0YXR1czsN
Cj4gPiA+ICsgICAgICAgfQ0KPiA+ID4NCj4gPiA+ICAgICAgICAgIC8vIFdhaXQgZm9yIERNVUIg
dG8gcHJvY2VzcyBjb21tYW5kDQo+ID4gPiAgICAgICAgICBzdGF0dXMgPSBkbXViX3Nydl93YWl0
X2Zvcl9pZGxlKGRtdWIsIDEwMDAwMCk7DQo+ID4gPg0KPiA+ID4+IFRoYXQgd2F5IHlvdSBjYW4g
a25vdyB3aGVyZSB0aGUgUEhZIHdhcyB0cnlpbmcgdG8gYmUgYWNjZXNzZWQNCj4gd2l0aG91dCB0
aGUNCj4gPiA+PiByZWZjbGsgYmVpbmcgb24uDQo+ID4gPj4NCj4gPiA+PiBXZSBoYWQgYSBzaW1p
bGFyIGlzc3VlIGluIERDTjMxIHdoaWNoIGRpZG4ndCByZXF1aXJlIGEgVy9BIGxpa2UgRENOMjEu
DQo+ID4gPj4NCj4gPiA+PiBJJ2QgbGlrZSB0byBob2xkIG9mZiBvbiBtZXJnaW5nIHRoaXMgdW50
aWwgdGhhdCBoYW5nIGlzIHZlcmlmaWVkIGFzIGdvbmUuDQo+ID4gPj4NCj4gPiA+IFRoZW4gSSB0
b29rIGEgUk4gbGFwdG9wIHJ1bm5pbmcgRE1VQiAweDAxMDEwMDE5IGFuZCBkaXNhYmxlZCBlRFAs
IGFuZA0KPiA+IGNvbmZpcm1lZA0KPiA+ID4gbm8gQ1JUQyB3YXMgY29uZmlndXJlZCBidXQgcGx1
Z2dlZCBpbiBhbiBIRE1JIGNhYmxlOg0KPiA+ID4NCj4gPiA+IGNvbm5lY3Rvcls3OF06IGVEUC0x
DQo+ID4gPiAgICAgICAgICBjcnRjPShudWxsKQ0KPiA+ID4gICAgICAgICAgc2VsZl9yZWZyZXNo
X2F3YXJlPTANCj4gPiA+IGNvbm5lY3Rvcls4NV06IEhETUktQS0xDQo+ID4gPiAgICAgICAgICBj
cnRjPWNydGMtMQ0KPiA+ID4gICAgICAgICAgc2VsZl9yZWZyZXNoX2F3YXJlPTANCj4gPiA+DQo+
ID4gPiBJIHRyaWdnZXJlZCAxMDAgaG90cGx1Z3MgbGlrZSB0aGlzOg0KPiA+ID4NCj4gPiA+ICMh
L2Jpbi9iYXNoDQo+ID4gPiBmb3IgaSBpbiB7MC4uMTAwLi4xfQ0KPiA+ID4gZG8NCj4gPiA+ICAg
ICAgZWNobyAxIHwgdGVlIC9zeXMva2VybmVsL2RlYnVnL2RyaS8wL0hETUktQS0xL3RyaWdnZXJf
aG90cGx1Zw0KPiA+ID4gICAgICBzbGVlcCAzDQo+ID4gPiBkb25lDQo+ID4gPg0KPiA+ID4gVW5m
b3J0dW5hdGVseSwgbm8gaGFuZyBvciB0cmFjZWJhY2sgdG8gYmUgc2VlbiAoYW5kIEhETUkgY29u
dGludWVzIHRvDQo+IHdvcmspLg0KPiA+ID4gSSBhbHNvIG1hbnVhbGx5IHB1bGxlZCB0aGUgcGx1
ZyBhIGhhbmRmdWwgb2YgdGltZXMgSSBkb24ndCBrbm93IHRoZQ0KPiBzcGVjaWZpY3MNCj4gPiB0
aGF0IExpbGxpYW4gaGFkIHRoZQ0KPiA+ID4gZmFpbHVyZSB0aG91Z2gsIHNvIHRoaXMgbWlnaHQg
bm90IGJlIGEgZ29vZCBlbm91Z2ggY2hlY2suDQo+ID4gPg0KPiA+ID4gSSdsbCB0cnkgdG8gdXBn
cmFkZSBETVVCIHRvIDB4MTAxMDAxYyAodGhlIGxhdGVzdCB2ZXJzaW9uKSBhbmQgZG91YmxlDQo+
IGNoZWNrDQo+ID4gdGhhdCBhcyB3ZWxsLg0KPiA+DQo+ID4gSSBhcHBsaWVkIHBhdGNoIHY1IGFu
ZCB0aGUgYWJvdmUgQVNTRVJUIHBhdGNoLCBvbiB0b3Agb2YgYm90aCBMaW51eA0KPiA+IDUuMTYt
cmM4IGFuZCA1LjE2Lg0KPiA+DQo+ID4gUmVzdWx0OiBubyBwcm9ibGVtcyB3aXRoIHN1c3BlbmQv
cmVzdW1lLCAxNisgY3ljbGVzLg0KPiA+DQo+ID4gQXMgZmFyIGFzIHRoZSBoYW5nIGdvZXM6DQo+
ID4NCj4gPiBJIHBsdWdnZWQgaW4gYW4gSERNSSBjYWJsZSBjb25uZWN0ZWQgdG8gbXkgVFYsIGFu
ZCBjb25maWd1cmVkIEdub21lIHRvDQo+ID4gdXNlIHRoZSBleHRlcm5hbCBkaXNwbGF5IG9ubHku
DQo+ID4NCj4gPiBjb25uZWN0b3JzIGZyb20gL3N5cy9rZXJuZWwvZGVidWcvZHJpLzAvc3RhdGU6
DQo+ID4NCj4gPiBjb25uZWN0b3JbNzhdOiBlRFAtMQ0KPiA+ICAgICAgY3J0Yz0obnVsbCkNCj4g
PiAgICAgIHNlbGZfcmVmcmVzaF9hd2FyZT0wDQo+ID4gY29ubmVjdG9yWzg1XTogSERNSS1BLTEN
Cj4gPiAgICAgIGNydGM9Y3J0Yy0xDQo+ID4gICAgICBzZWxmX3JlZnJlc2hfYXdhcmU9MA0KPiA+
IGNvbm5lY3Rvcls4OV06IERQLTENCj4gPiAgICAgIGNydGM9KG51bGwpDQo+ID4gICAgICBzZWxm
X3JlZnJlc2hfYXdhcmU9MA0KPiA+DQo+ID4gSSBtYW51YWxseSB1bnBsdWdnZWQvcGx1Z2dlZCB0
aGUgSERNSSBjYWJsZSAxNisgdGltZXMsIGFuZCBhbHNvIHJhbjoNCj4gPg0KPiA+ICQgc3VkbyBz
aCAtYyAnZm9yICgoaT0wO2k8MTAwO2krKykpOyBkbyBlY2hvIDEgfCB0ZWUNCj4gPiAvc3lzL2tl
cm5lbC9kZWJ1Zy9kcmkvMC9IRE1JLUEtMS90cmlnZ2VyX2hvdHBsdWc7IHNsZWVwIDM7IGRvbmUn
DQo+ID4NCj4gPiBUaGUgc3lzdGVtIGRpZCBub3QgaGFuZywgYW5kIEkgc2F3IG5vIGtlcm5lbCBs
b2cgb3V0cHV0IGZyb20gdGhlIEFTU0VSVC4NCj4gPg0KPiA+IEkgYWxzbyB0cmllZCBhIFVTQi1D
IGRvY2sgd2l0aCBhbiBIRE1JIHBvcnQsIHdpdGggdGhlIHNhbWUgcmVzdWx0cywNCj4gPiB0aG91
Z2ggdGhlcmUgYXJlIG90aGVyIGlzc3VlcyB3aXRoIHRoaXMgKHBlcmhhcHMgd29ydGh5IG9mIG90
aGVyIGJ1Zw0KPiA+IHJlcG9ydHMpLg0KPiA+DQo+ID4gSXMgdGhlcmUgc29tZSByZWFzb24gdG8g
dXNlIGFtZC1zdGFnaW5nLWRybS1uZXh0IGZvciB0aGlzIHRlc3Q/DQo+ID4NCj4gPiBJIGRvbid0
IHVzZSB0aGUgSERNSSBjb25uZWN0aW9uIG11Y2ggYW5kIEkgaGF2ZSBuZXZlciBleHBlcmllbmNl
ZCBhDQo+IGhhbmcNCj4gPiB3aXRoIEhETUkgaW4gdGhlIGZpcnN0IHBsYWNlLiBDYW4gc29tZW9u
ZSBzZW5kIGEgbGluayB0byBhbg0KPiA+IGlzc3VlL2Rpc2N1c3Npb24gd2hlcmUgdGhpcyBoYW5n
IGlzIGJlaW5nIGRpc2N1c3NlZD8NCj4gPg0KPiA+IEhXOiBIUCBFTlZZIHgzNjAgQ29udmVydGli
bGUgMTUtZHMxeHh4LCBBTUQgUnl6ZW4gNyA0NzAwVSB3aXRoDQo+IFJhZGVvbg0KPiA+IEdyYXBo
aWNzDQo+ID4gT1MvRGVza3RvcDogQXJjaCBMaW51eCwgR25vbWUgNDEuMyAoV2F5bGFuZCkNCj4g
PiBGVzogbGludXgtZmlybXdhcmUtZ2l0IDIwMjExMjI5LjU3ZDZiOTUtMSwgRE1VQiB2ZXJzaW9u
PTB4MDEwMTAwMUMNCj4gPg0KPg0KPiBOaWNob2xhcywNCj4NCj4gV2UndmUgZ290IGEgaGFuZGZ1
bCBvZiBwZW9wbGUgbm93IChteXNlbGYgaW5jbHVkZWQpIHdobyBoYXZlIGRvbmUgYQ0KPiBidW5j
aCBvZg0KPiBwaHlzaWNhbCBhbmQgc29mdHdhcmUgdHJpZ2dlcmVkIGhvdHBsdWdzIG9uIGEgdmFy
aWV0eSBvZiBwb3J0cyBvbiB0b3Agb2YgYm90aA0KPiBhbWQtc3RhZ2luZy1kcm0tbmV4dCBhbmQg
NS4xNiBhbmQgbm90IHNlZWluZyBhbnkgaGFuZ3MuICBHaXZlbiB0aGlzIGlzDQo+IGxpbmdlcmlu
Zw0KPiBvbiA1LjE2LCBhcmUgeW91IGFtZW5hYmxlIHRvIGl0IGFuZCBsZXR0aW5nIExpbGxpYW4g
ZGlnIGZ1cnRoZXIgYWZ0ZXIgc2hlIHJldHVybnMNCj4gb24NCj4gdGhlIHNwZWNpZmljIGNhc2Ug
dGhhdCBzaGUgaGFkIHByb2JsZW1zIHdpdGggdG8gc2VlIGlmIHdlJ3JlIG1pc3NpbmcgYW55dGhp
bmcNCj4gZWxzZT8NCj4NCj4gVGhhbmtzLA0KDQpJIHRoaW5rIGl0IHdhcyBvYnNlcnZlZCBkdXJp
bmcgSERNSSBjb21wbGlhbmNlIHRlc3Rpbmcgb3IgZnJlcXVlbnQgSERDUCBlbnRlci9leGl0IG9u
IENocm9tZSwgSSBkb24ndCByZW1lbWJlciB0aGUgZGV0YWlscyBvZmYgdGhlIHRvcCBvZiBteSBo
ZWFkLiBUaGUgc3lzdGVtIHdvdWxkIGNvbXBsZXRlbHkgbG9jayB1cCB1bmRlciB0aG9zZSBjb25k
aXRpb25zLg0KDQpJJ20gbm90IGZhbWlsaWFyIHdpdGggdGhlIHVyZ2VuY3kgb2YgdGhlIHJlcXVl
c3QgZm9yIHlvdXIgc3BlY2lmaWMgaXNzdWUsIGJ1dCBpZiB5b3UgZmVlbCB0aGF0IHRoZSB0cmFk
ZW9mZiBpcyB3b3J0aCBpdCB0aGVuIHlvdSBjYW4gZ28gYWhlYWQgYW5kIHJldmVydCBmb3Igbm93
Lg0KDQpSZXZpZXdlZC1ieTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2th
c0BhbWQuY29tPg0KDQpSZWdhcmRzLA0KTmljaG9sYXMgS2F6bGF1c2thcw0K
