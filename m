Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D46C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6056112D
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E6056112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 998276E45D;
	Thu, 21 Oct 2021 13:57:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6A746E45D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 13:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSNepRToE3FHIAIDSPbQcZMEtk1oLt9GANwwGdZkutwUNkf4Hkek4vBUJusz5U8+iSEPqgSEmFiPqvUJmF6hVNKZmzTvmH2rd7BTWyUCfLa4UAQwNkWTXJ3imgVZaI2uGqxjyTMRHhkUgnihPiK2T7axm6FoU9uoHf6ptAagZp7VrNoSfmaXGicbXCsekKXDpAQ3tBJgt7hMu5Zlc7lSRMQQ54yC656bkX/dwWGLSu8yTWDnmLDH+BfKGf362Lkj1wocg3+UpRDU1HtDG6tQDmNraJ2OImwukxqmmNpYVPx09g/353FXPudxBjia6IiaB+Bf+l5xppkq6T5FabLzVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4IFtMTp9KKp+3JbBz+LLfkPbSjy8lI4gKfDkhHgbl8=;
 b=GIPuReTXAfIW2ZK5wyuhKD4FHtunD4/8bc0b1hZvH1MNB+tOvWHY/BDmFuQs/6rm/NlPVNy3AS3Nf+pBGdK8j7+UuKBtE3f2l10HCmHwQEvManUyGnuEItG5rSq16Ee8j6QAh/fKsAVeqoEyIuIOkvOWzxvWt28phMBZA+KM9wA0lzmW2KVHquPoHXvbG/EKe8IdEdnHdzVMOXuVXhhQuyAIDxYJpPMcfqWy09cGJlgCuEdry/iM8+x6R85yIHN2omRZ91O7QwOzhVsI0kj56nQH0YUvY4ZKx1htqxof5679BRUgC7auA6gHFGFqT5KKtu96XgpurgndxqEP6pBJ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4IFtMTp9KKp+3JbBz+LLfkPbSjy8lI4gKfDkhHgbl8=;
 b=OVufzs8/Aa64oeywdIRhu1embGDuCkumxIgtFYLgYIRli+y6dhVcE4T1FgkaTmROOgbRUbT2WwFE67YauM8+qkq4u3oXLrqAmYNTP/qipSjy5fg7JCW6TDTv7y7RtplrCdPseYFVxGQRZWoflyInPEr9u4iKEtPbOl4OoAK1IR8=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM5PR12MB1769.namprd12.prod.outlook.com (2603:10b6:3:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 13:57:32 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 13:57:32 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Implement bad_page_threshold = -2 case
Thread-Topic: [PATCH 3/3] drm/amdgpu: Implement bad_page_threshold = -2 case
Thread-Index: AQHXxdCFHjJje/5lf02XLXYO+IHCm6vcbl+AgAAB8ICAAQsOMA==
Date: Thu, 21 Oct 2021 13:57:32 +0000
Message-ID: <DM6PR12MB3324666DE901C7501C292D3E85BF9@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20211020163520.1167214-1-kent.russell@amd.com>
 <20211020163520.1167214-3-kent.russell@amd.com>
 <42f538e2-22b7-7a74-7212-a6063694164b@amd.com>
 <311fd85f-b3ab-377f-c98b-858b3afa6af3@amd.com>
In-Reply-To: <311fd85f-b3ab-377f-c98b-858b3afa6af3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-21T13:57:30Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=654fa777-8e8e-4e48-93f5-6555311a47c4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2832d243-3566-4dc0-dc27-08d9949aba6e
x-ms-traffictypediagnostic: DM5PR12MB1769:
x-microsoft-antispam-prvs: <DM5PR12MB1769A8D938967937EB58E35D85BF9@DM5PR12MB1769.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ymJ0bdedOwt89XlpFV8ZoeEHt+xTvIuW5GypC4FJBWHMvhO/gntCsR5qBHuNTN6cjKUP9k3dHtS0PSLCm8iO0VvJXYuExoZYJ/x84pp+/0MqpSggh/t88lqqy3x+chGAEOuZwIuS9k6r6GMWsZXFhXgKVPQaUSeYwGl6FAy/d2tyncXkoTnh7brNYSUIKtHfiMnk0Zo8AnJB8ez1yAFmueGm95tBxG058SuoBSeacRkFBbX813A6lnREdaxrVhdoeXEO5X39OO2N5KBSNmEEy4GqnSXNakBCqecCPEotQ9y120LKCvpOjKRU3dCOUQaZV8eY2mtIQK6zbk509oPFVs3Rytje4p++E9u55+V+JnwpWE3bMSP2VAYon+ANgI8g4smgGyKbS0t+Yy/WWjDQ2Y9WS8CtS/oSmHim1c0tW3ltMIJ7SOc1D1hWU14XHtTwOyOhz7w/WjgYVPwrFyoujtoFumAG0/w5Bx2VCBOmhqNvAi4YNZJpI4+lYDRldq0ZR6cxKMUsVcTKRN0hR3tCR8uXBZv9fZ5GagJPHW6Wo722WTwjXXlpMCrGt3VdxtneBK0qLTzNiMNpX5lZdM2n/D+qYUFRwSfoRQDrRVEhT8ojJMzfQuesgwotY2UMz6jnaRYsHSNyVmjT/2nAUY9tZPAGUZHMBrSpbrM8nxUNYvoQhREJM7TwifG44GgVmZAPKyDIQ1j70drhwJgNNyx8Gw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(52536014)(38100700002)(7696005)(66946007)(5660300002)(76116006)(316002)(4001150100001)(83380400001)(55016002)(110136005)(9686003)(66446008)(64756008)(38070700005)(4326008)(66476007)(53546011)(71200400001)(66556008)(8676002)(6506007)(186003)(8936002)(86362001)(33656002)(508600001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHlkSlprUm00SCttR21WeVVSSnZxamt0SFgyTUxzdDJQMmw0S2hOclV5cndx?=
 =?utf-8?B?M2pCVTNIYXp3ZEJsZCt5ZE1ZcU5nL01ZcVpNbCtOZ0YxRWxvL2xKdjhCL0Y2?=
 =?utf-8?B?T3k4Z3Rxbnk4cW1DTE9CaWRVeDdDcUMwVlAvQzBFbGdaYTdNMkJvQ1ZVdVBq?=
 =?utf-8?B?Ly9NVnlIZGZRcmtQZVVHb2lLQU81a3lGNjE5ZG9URmpOclNjN0FLR1F1RWFs?=
 =?utf-8?B?ckc3eGszSWp1S2tUaW05NnR4YVBxdmQvUStSU2hveDdCejFjZzZteGZPdjlV?=
 =?utf-8?B?b2lVTWFCTUVlOXdtdW9rYzVzMmp1YnJlZjhmbnV6ZXoyQWFMdWdwdlBsOGFK?=
 =?utf-8?B?NEFIWmMzQk81ZUo0OGdKSG44QUN4Nlc2RzltT2QwNzhmNXVnK0JPNmdQM0ZY?=
 =?utf-8?B?MjBWMEdCSWRtZGlWZFB5Rlk2TzJzUjFtd3VnLzhZL3VRcENsNXpVS1hqMk5h?=
 =?utf-8?B?LzllY3dSMXpyc2xHZ29DTXNvcEpmRXFMVFhEZ3NJeWw1UkVvcU5adnp0b0pT?=
 =?utf-8?B?UTc1cndQQ1BZakM2NzJLMXhUR0lsbTMrMU1aN0ljNml6NDE3UUJwYnB4MkxH?=
 =?utf-8?B?U2tzV1duZU1VRHdXMHFXWGgxRlVkK3A5eHZuQ3MzNC8wend0dFhVblBJazFv?=
 =?utf-8?B?MWd4THpMekFtME5qT1hJekVOVndROUlyU09GNkpPdjJ5TWphNkpVKzQ2TlJp?=
 =?utf-8?B?UlIwMUR0d1NlSk5zL3RHRDBJMW1IckZRNmwzN2JmcjlXa1ZYZGJkVlBYdXlY?=
 =?utf-8?B?ZjZCVEYzM1VaM0RmSjRmNFlxTG5EbU9GclhJL1JwK2c2WkRhN2EwQTRBaTEz?=
 =?utf-8?B?UFlLdTR4dnZQZWFwcURVRnh6QlRGclNoNnRsMUx5enp0ZWpVd2x3QUNKTEMw?=
 =?utf-8?B?YTN0MDNQYjAxYi80QXRPRDVLeWMzT0hjcnk3UFRndGc5blBBSnJhRjBLdzc5?=
 =?utf-8?B?OVFJNmthNkxUbnhveU5GeGxtYlIvcnU4VUZUejQ2Y3UyTVg1bVdVMG9LdXdP?=
 =?utf-8?B?K3d5R3NiMTFDcWpuNjJEMkFmVHNzcEF6S0MraFV5N0NVdTd6WXJrRUFYSWVk?=
 =?utf-8?B?ODBmYUw1RCtTUDl5U2hDOVBSY2ZDMzVlVWUrWStSUlJCYVMwZVNyY0E5bnAy?=
 =?utf-8?B?L0NLVVdMN2tVNEZKYWltU3J5T25YOTBOTUVyMEcxSVRuYUV3OFVsd2FScm15?=
 =?utf-8?B?V1Q5MEYwNjdaTkRUUGZ4dllxNkROVHNrNmhFeEFxTlM4N1BTaGdGMkxmUjRB?=
 =?utf-8?B?UjhodlcxZnJCY2ZxcGlPWElFU2x6My9nQjhWc0pmdnAraHhoYjNXTldkWlRK?=
 =?utf-8?B?eHVVbmpFLyt6RFJkbERxWGhsWmtVck90MTdKdFVDbWNBR1p2cWN2UHBKN0Ry?=
 =?utf-8?B?VFhKdDdleTVJVXZmK3YyTkdVd2ZqYU5YZFhJR1c0TWF3VjV3UTQ5UU5zKzQx?=
 =?utf-8?B?bG4wbWhWRUZtWnplaHFIVTZqMzI4ZXVtMWh5L2NsQWZrVWxMd24vRUNsVUY2?=
 =?utf-8?B?S21FSVlrbDJBUjBXcjJQZnJ1a3VGYkx2Z0RDWExNeURuZ1d4aGRRWU9uUTho?=
 =?utf-8?B?WFFVSmZoWWRPaWU0Wm5hQmhCV2FMVmFtZXJmYWN5WTErazJqWVpiZ1lNQ05F?=
 =?utf-8?B?WDRuVmtja21iOVYwOWttYTF2Z3RkU0hiWGxNMGFqWis2WkVRNDRvejY1Unh5?=
 =?utf-8?B?ejI2R2VOcUFZQXhBZjVlWU9IcjgzRWJ5dkVSZXZOVzJFNk01aVFMbEVRMnZE?=
 =?utf-8?B?Sk1CVXlwUFA5VXU5eWwyclhIZXMxVTVvZ2JqVHllcFRSQ0s2RjJ0WW9GeHpN?=
 =?utf-8?B?cVNNS1ZrVkVKc05pN1U3RmJtOGc4dkxWQmUxMXV3Wkp1U2w2L0ZSbC9UY0pK?=
 =?utf-8?Q?SZWgrf0YAu4Ij?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2832d243-3566-4dc0-dc27-08d9949aba6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 13:57:32.2868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krussell@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1769
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogVHVpa292LCBMdWJlbiA8THViZW4uVHVpa292QGFtZC5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgT2N0b2JlciAyMCwgMjAyMSA2OjAxIFBNDQo+IFRvOiBLdWVobGluZywgRmVs
aXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBSdXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxA
YW1kLmNvbT47DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBKb3NoaSwg
TXVrdWwgPE11a3VsLkpvc2hpQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBk
cm0vYW1kZ3B1OiBJbXBsZW1lbnQgYmFkX3BhZ2VfdGhyZXNob2xkID0gLTIgY2FzZQ0KPiANCj4g
T24gMjAyMS0xMC0yMCAxNzo1NCwgRmVsaXggS3VlaGxpbmcgd3JvdGU6DQo+ID4gT24gMjAyMS0x
MC0yMCAxMjozNSBwLm0uLCBLZW50IFJ1c3NlbGwgd3JvdGU6DQo+ID4+IElmIHRoZSBiYWRfcGFn
ZV90aHJlc2hvbGQga2VybmVsIHBhcmFtZXRlciBpcyBzZXQgdG8gLTIsDQo+ID4+IGNvbnRpbnVl
IHRvIHBvc3QgdGhlIEdQVS4gUHJpbnQgYSB3YXJuaW5nIHRvIGRtZXNnIHRoYXQgdGhpcyBhY3Rp
b24gaGFzDQo+ID4+IGJlZW4gZG9uZSwgYW5kIHRoYXQgcGFnZSByZXRpcmVtZW50IHdpbGwgb2J2
aW91c2x5IG5vdCB3b3JrIGZvciBzYWlkIEdQVQ0KPiA+IEknZCBzcXVhc2ggcGF0Y2ggMiBhbmQg
My4gVGhlIHNxdWFzaGVkIHBhdGNoIGlzDQo+ID4NCj4gPiBBY2tlZC1ieTogRmVsaXggS3VlaGxp
bmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IA0KPiBJIHdhcyBqdXN0IHRoaW5raW5nIHRo
ZSBzYW1lIHRoaW5nLiBLZWVwIHRoZSB0aXRsZSBhbmQgdGV4dCBvZiBwYXRjaCAyIGFuZCBhZGQg
dGhlIGRlc2NyaXB0aW9uDQo+IG9mIDMgdG8gMi4gV2l0aCB0aGF0IGRvbmU6DQo+IA0KPiBSZXZp
ZXdlZC1ieTogTHViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4NCg0KU291bmRzIGdv
b2QsIHRoYW5rcy4gSSB3YXMgb24gdGhlIGZlbmNlIGFib3V0IGNvbWJpbmluZyB0aGVtIGZyb20g
d2hlbiBJIGhhZCB0aGUgc2VwYXJhdGUga2VybmVsIHBhcmFtLCBhbmQgaXQgd2FzIGVhc2llciB0
byBzcXVhc2ggaXQgYXQgcmV2aWV3IHRpbWUgdGhhbiB0byBzZXBhcmF0ZSBpdC4gSSdsbCBzdGls
bCBuZWVkIHRvIHdvcmsgb24gcGF0Y2ggIzEgYnV0IHRoYW5rcyBmb3IgdGhlIHJldmlld3MgaGVy
ZSENCg0KIEtlbnQNCg0KPiANCj4gUmVnYXJkcywNCj4gTHViZW4NCj4gDQo+ID4NCj4gPg0KPiA+
PiBDYzogTHViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4NCj4gPj4gQ2M6IE11a3Vs
IEpvc2hpIDxNdWt1bC5Kb3NoaUBhbWQuY29tPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBLZW50IFJ1
c3NlbGwgPGtlbnQucnVzc2VsbEBhbWQuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jIHwgMTMgKysrKysrKysrLS0tLQ0K
PiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmFzX2VlcHJvbS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19l
ZXByb20uYw0KPiA+PiBpbmRleCAxZWRlMGYwZDZmNTUuLjMxODUyMzMwYzFkYiAxMDA2NDQNCj4g
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYw0K
PiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5j
DQo+ID4+IEBAIC0xMTE1LDExICsxMTE1LDE2IEBAIGludCBhbWRncHVfcmFzX2VlcHJvbV9pbml0
KHN0cnVjdA0KPiBhbWRncHVfcmFzX2VlcHJvbV9jb250cm9sICpjb250cm9sLA0KPiA+PiAgIAkJ
CXJlcyA9IGFtZGdwdV9yYXNfZWVwcm9tX2NvcnJlY3RfaGVhZGVyX3RhZyhjb250cm9sLA0KPiA+
PiAgIAkJCQkJCQkJICAgUkFTX1RBQkxFX0hEUl9WQUwpOw0KPiA+PiAgIAkJfSBlbHNlIHsNCj4g
Pj4gLQkJCSpleGNlZWRfZXJyX2xpbWl0ID0gdHJ1ZTsNCj4gPj4gLQkJCWRldl9lcnIoYWRldi0+
ZGV2LA0KPiA+PiAtCQkJCSJSQVMgcmVjb3JkczolZCBleGNlZWQgdGhyZXNob2xkOiVkLCAiDQo+
ID4+IC0JCQkJIkdQVSB3aWxsIG5vdCBiZSBpbml0aWFsaXplZC4gUmVwbGFjZSB0aGlzIEdQVSBv
ciBpbmNyZWFzZSB0aGUNCj4gdGhyZXNob2xkIiwNCj4gPj4gKwkJCWRldl9lcnIoYWRldi0+ZGV2
LCAiUkFTIHJlY29yZHM6JWQgZXhjZWVkIHRocmVzaG9sZDolZCIsDQo+ID4+ICAgCQkJCWNvbnRy
b2wtPnJhc19udW1fcmVjcywgcmFzLT5iYWRfcGFnZV9jbnRfdGhyZXNob2xkKTsNCj4gPj4gKwkJ
CWlmIChhbWRncHVfYmFkX3BhZ2VfdGhyZXNob2xkID09IC0yKSB7DQo+ID4+ICsJCQkJZGV2X3dh
cm4oYWRldi0+ZGV2LCAiR1BVIHdpbGwgYmUgaW5pdGlhbGl6ZWQgZHVlIHRvDQo+IGJhZF9wYWdl
X3RocmVzaG9sZCA9IC0yLiIpOw0KPiA+PiArCQkJCWRldl93YXJuKGFkZXYtPmRldiwgIlBhZ2Ug
cmV0aXJlbWVudCB3aWxsIG5vdCB3b3JrIGZvcg0KPiB0aGlzIEdQVSBpbiB0aGlzIHN0YXRlLiIp
Ow0KPiA+PiArCQkJCXJlcyA9IDA7DQo+ID4+ICsJCQl9IGVsc2Ugew0KPiA+PiArCQkJCSpleGNl
ZWRfZXJyX2xpbWl0ID0gdHJ1ZTsNCj4gPj4gKwkJCQlkZXZfZXJyKGFkZXYtPmRldiwgIkdQVSB3
aWxsIG5vdCBiZSBpbml0aWFsaXplZC4gUmVwbGFjZSB0aGlzDQo+IEdQVSBvciBpbmNyZWFzZSB0
aGUgdGhyZXNob2xkLiIpOw0KPiA+PiArCQkJfQ0KPiA+PiAgIAkJfQ0KPiA+PiAgIAl9IGVsc2Ug
ew0KPiA+PiAgIAkJRFJNX0lORk8oIkNyZWF0aW5nIGEgbmV3IEVFUFJPTSB0YWJsZSIpOw0K
