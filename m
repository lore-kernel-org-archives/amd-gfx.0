Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9B5C43217
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 10:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CED060F43
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 10:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5CED060F43
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E456E89EBD;
	Mon, 11 Oct 2021 10:03:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EEF889EBD
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 10:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWtcksIRz7bR1DxMg67ssj/rbnQE7obwQrmX2+Mf4Y1Hr++4rTETh9v+6R0tiB19FDwfMY5/JFhbkRj7YTWrnKGzW2CER6V/c6pIIKe9vvCtqkz9DakGtc/tvnvUCVF4gC5UuP29HVMmAR4Waoe7A1/fHwqWKSN8GcjDmlRTEczsCIZkbr3veL2FCuOAP0SFqh9oH2QWcIwfeUZfCEuyY7BfI7mcYEuL7lvmsEJmMp+295YesfRRXboCp1oGjNTRezmqDk+MwrDnwB47daU2jy9JFLvd59sjmNyJBNNlaQGgpMHDkIMJKIFrRMGUmcOXyX0MwbFjSl9EOk68PSEg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kp4PFOfNzh2Xt2XvpdIiSKxjKtLCZHpMwHyA2hfiOs8=;
 b=EPDH6B2AbjwYniarqYcreKFFbBF0DVjcp7U432NlQS4HIGSXvfCzxv7d1ipD90Uf51ugYRGx9MSkBbkK9bwTVda0uupIVp9BTIjq3sXhSOWakYaPG0le5wRJBE250io3SlSTWAwIiPhIG/2/iXFMfSmlT1/1jRcGmv2BDT8ickHI/rSyDrheQ0numVRmtPwv4cmv04pU6A0OYY9OIEKR5UcLajeFu1tW2o+87+AzVaRbh9Kcg7u4OkFNVNZv3kFGw0Ucr+rCEjs19iP06+mBT0ViyVC1WV7VJhVMrCnAJ9pT9abt0t94PJECyofvRYXw06J6RuEsKS8hZTuCmo0hCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kp4PFOfNzh2Xt2XvpdIiSKxjKtLCZHpMwHyA2hfiOs8=;
 b=EVNzxJvKDcV/xA2WUAoixdJUov2dNTzwQ23VbeNWBAA3tBZs5Rj3LM+iwOc9RrGt38orzVfWXQ5YcT4AW73pFzUd939ZB3fsx07+WeLvJ0Cyi+J/V0M2uRnzYvHFLMcP4Tl3L505w8MW8iHHp0euaZa/O4f/GWIwCX10P4U8h8w=
Received: from BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19)
 by BN6PR12MB1380.namprd12.prod.outlook.com (2603:10b6:404:1f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Mon, 11 Oct
 2021 10:03:46 +0000
Received: from BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::84b6:69c0:9fb7:cd1d]) by BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::84b6:69c0:9fb7:cd1d%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 10:03:45 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: youling 257 <youling257@gmail.com>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhu, James"
 <James.Zhu@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
Thread-Topic: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
Thread-Index: AQHXtELZo07wLtaE6kqRLoUB3h9VLqvNZa4AgAABQ4CAADzXAA==
Date: Mon, 11 Oct 2021 10:03:45 +0000
Message-ID: <BN6PR12MB1187E3D949682D0714EA6253C1B59@BN6PR12MB1187.namprd12.prod.outlook.com>
References: <20210928082819.205231-2-yifan1.zhang@amd.com>
 <20211011061326.13718-1-youling257@gmail.com>
 <CAOzgRdaG2Zo-_kDGo2d-AZ0zoSHHW5T_dh9HFrk46i3kXiMitg@mail.gmail.com>
In-Reply-To: <CAOzgRdaG2Zo-_kDGo2d-AZ0zoSHHW5T_dh9HFrk46i3kXiMitg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-11T10:03:39Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6b8cd496-4bc5-4601-b196-fd1771b35351;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f08a3bdc-04c1-43fe-2a17-08d98c9e69c9
x-ms-traffictypediagnostic: BN6PR12MB1380:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB1380812E17FBBADEE6E97308C1B59@BN6PR12MB1380.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RJSS94lulDma1M7wNA62hvW00qTa9PAmUXaqR7eS40AwVzWFevhv1uUGPL4mCvZMdhWFiNeuz4Kpxo3HBNFVgS9WwRXP5Jub/vtfkr7itzBWx5NxL5YWziMm6/nehukme1XTD8DcZ0xU7z6ILaPdsLmRcwbJLJ1zcpzMQJyDsfGz7ZdWgPDa2I/ZwgJve3iKR0PRQqlNcCt/5B5pE6+X9PqDAzJcH5hV5kCizpfTjNEmYd/iRGQBon6D8+nHho24nqqwYSgmRUjBfAAkvv1LlKSqZNiVfKxhinWcK4HgDxsUFpIqlkQ8SJivMgNtai/ahHcdk9vjzK1820GSabIqUIyerpcoOTojDl/o1mt+BVNw9pK3CmS7gNs5wixOOi5XaFkDKFX4RNJxRS1sXB51kyDAlwcEZLPwdxRgYlX7iP3eHjldPG42icCI45OJQF1WRCHgQT+G772/zv+gqv518AUGuSAMJLje/C+Tzq0QLTCLAFUB7c1DCu5q/MkVX3IWB6DHhcYy4uQg+R3Vu6btT8tvI33qp9Nqg4iI0k2kN7Vs7HrhIFi6lmfa1nFEKwXWE+/d9hvu/ixXROGieC58HgflUakDJg2brZYhEhERSZrqQS+72cYXhWGpBgK8OKGA6FyDqj0ZCJaC9zm7ErEidl5jigtDtSOckFUryLCl8p7IBDrNuAZ495GeJC5ntHX4BwLJozWSIa3PHPEOMLBApw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1187.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(99936003)(4326008)(186003)(4001150100001)(55016002)(52536014)(6916009)(26005)(5660300002)(33656002)(54906003)(9686003)(83380400001)(66556008)(66476007)(66446008)(64756008)(38070700005)(86362001)(8676002)(6506007)(53546011)(2906002)(8936002)(122000001)(508600001)(7696005)(76116006)(66946007)(71200400001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTBJQ0wyM0ZmbkhZYVA2MjhQamJ2Sll1RzZ2d0k5V08yQ3c2RjhJY1VSMGts?=
 =?utf-8?B?bkQ5WW00S05WR3c1ZCtMM2JSQ0NnekMrbVJpVmJ1SnFUYVBRNzVCeUJ6UVdJ?=
 =?utf-8?B?UDJJQXB0UDFUd3NXMERkU21zRkF5dkRsbVlTSVZtS0svbklkcTIvQ2MzWXhB?=
 =?utf-8?B?SzRMc2d4Q1lEdEtyejRJSUtPMDlZU0RJNXFjSVBIT1Y4QWNQQThnbzlqSWFV?=
 =?utf-8?B?Qmhvb0FiWGVyK1oxRXFTYm9CMFYrck5GS25oK3FzcDFrb0s2RDlkbFE2M3JL?=
 =?utf-8?B?YmtBVnR5OVNRdksrS2ZFZm9NMTBKbWxiR3pxU3JGTE9wTldGU3lpcmtXaWFj?=
 =?utf-8?B?M1NKWENVamxpZ3Iya0h0ak8vKzVzVi9LVDN6bjBtcVBFQnlqTEQ2Zm4wbkpB?=
 =?utf-8?B?NGs5YnlOSVpQTVo1WXV5T2cxUWNiUVI3N285SGxXYW9zSWtVdENHUFV2cnFQ?=
 =?utf-8?B?WlJISWgzUXVpUWs2VDRxUGxaUERPN2xnNmVOcmRISGs0dVIvQ3NlSndlYzdx?=
 =?utf-8?B?TjdiV084ZGxyTDV5bGFOZm1jT2g1cGhIN09SaERaN2loVkc4eGhDSXNHTjJq?=
 =?utf-8?B?ajNGRloyNlpLMjVOeE1uRjROUG1jMEh1cmd5VDV6ZnlhL25JL0Ryb3ZMWmpN?=
 =?utf-8?B?ZnozWWw2SFFLK0lJZUQ5WTJlZ0tDUEowN1dRMGhIVjRjZzhKUHltQVlLRCto?=
 =?utf-8?B?UjAva0FQLyswNTBmaGZKcDE1S0djRDNsSDZiOTJ5SGRqeDRWNnp4UlRpVUJw?=
 =?utf-8?B?VWhMcEN4eTdDeG93UDlsaGVHR0p6dmhZZXhtQy9pdTlYcWgrMEhuRXQ1UG9i?=
 =?utf-8?B?c1ZFdHZ2WmM4aUEzeVZKV0JXdm9kOE9XcGdBZ2Q1MlVpeHVDNXpHbFE0S21J?=
 =?utf-8?B?M0pIL2xwYWtJSUFTc284ZUNmc2FlZ0pnQkExREYwdnVtYm1JQXk0Z1JobWpL?=
 =?utf-8?B?QlBzUXh0MEhLaEtFUXRZZnZ2V0swbEVRNG1sSVczTWVyQXR5Nnd2cUVJeHlQ?=
 =?utf-8?B?NmIxZk1LdWZHMTFaZi9QOUNtNzNndkdRcTYxVzNLbzdBVGd3OE94TTBiSVJa?=
 =?utf-8?B?OXRGV3BweHowWTF3RE1ieitjcEg3ZVBoTTl1WVljN0xwQjJOY2g2MUM4ZzJy?=
 =?utf-8?B?UTFoOUYyU3dmNlA2N3BHU1daYS85UVRZWDM0blhyUXBBSmpPaG4yUnRCdmxJ?=
 =?utf-8?B?S2NYa1B6ZElnM0Z6bWI0QzlYWHNacmh2VVlGSVNNWkkrdERnd2VvcUZVQXVO?=
 =?utf-8?B?RDJqUHlIaVFIOGtZNm4yTW9UY2VjT25taEpnR3lMNXpYWHo2RWRpWnJkOVRp?=
 =?utf-8?B?RGNZc2h0R2hnRUkvRVdZVG1McG9GSldhdFNWVldRcDZtU2JkbFRoMUNTbEUr?=
 =?utf-8?B?M241RTBaVTN5cEw2TzExSklxVEJmd2NHSmlhNEMweG5pMjF0aDl0d1NscHBu?=
 =?utf-8?B?aEtJUzlTdkhiUnNVa09qR2VtUW1rTXEzQ2kwd01yckpTbVpHZ3c3VHZqVzZT?=
 =?utf-8?B?YmRFWUd2UVdXWHI0Vk9COGprZVZSVFZLVnVVc0Y1ZlYvNlkrclhaQUhSQ25C?=
 =?utf-8?B?TkdPV1pNaHFVSjBHMmJ2VGFXaFltUExJUTVkSlhtd28rNDVJU1JDYUJFYkNt?=
 =?utf-8?B?NnlGb3ZMWWNQS0JsWGMxeWF3aTgwcE9LUEx3cmMrakxKZmtmQktQVkJQUFhs?=
 =?utf-8?B?MXJwMEFmR2FIV2lWcEJyU3BlL3R3ZTJ1Rm9iUVAvUjVoNVpWRHZXRUI2bDVk?=
 =?utf-8?Q?E1OSIyQr/c/eAF1ulWWmGozvqPVY78/dzenQwX8?=
Content-Type: multipart/mixed;
 boundary="_002_BN6PR12MB1187E3D949682D0714EA6253C1B59BN6PR12MB1187namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08a3bdc-04c1-43fe-2a17-08d98c9e69c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 10:03:45.5209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xb7/autTLYNcxyDb8SqOhDPn+RYIg7HWEFTHV5nY9gMUm/tjYGtcJcdFugmvNk2q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1380
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

--_002_BN6PR12MB1187E3D949682D0714EA6253C1B59BN6PR12MB1187namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W1B1YmxpY10NCg0KSGkgeW91bGluZywNCg0KV291bGQgeW91IHBscyB0cnkgdGhpcyBwYXRjaCA/
IA0KDQpCUnMsDQpZaWZhbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogeW91
bGluZyAyNTcgPHlvdWxpbmcyNTdAZ21haWwuY29tPiANClNlbnQ6IE1vbmRheSwgT2N0b2JlciAx
MSwgMjAyMSAyOjE4IFBNDQpUbzogWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdAYW1kLmNvbT4N
CkNjOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6
IGluaXQgaW9tbXUgYWZ0ZXIgYW1ka2ZkIGRldmljZSBpbml0DQoNCmRybS9hbWRncHU6IGluaXQg
aW9tbXUgYWZ0ZXIgYW1ka2ZkIGRldmljZSBpbml0IGJ1dCBDT05GSUdfQU1EX0lPTU1VPXkgQ09O
RklHX0FNRF9JT01NVV9WMj15DQpbICAgIDAuMjAzMzg2XSBBTUQtVmk6IEFNRCBJT01NVXYyIGRy
aXZlciBieSBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4NClsgICAgMC4yMDMzODddIEFN
RC1WaTogQU1EIElPTU1VdjIgZnVuY3Rpb25hbGl0eSBub3QgYXZhaWxhYmxlIG9uIHRoaXMgc3lz
dGVtDQpbICAgIDcuNjIyMDUyXSBrZmQga2ZkOiBhbWRncHU6IEFsbG9jYXRlZCAzOTY5MDU2IGJ5
dGVzIG9uIGdhcnQNClsgICAgNy42MjIxMjhdIGtmZCBrZmQ6IGFtZGdwdTogZXJyb3IgZ2V0dGlu
ZyBpb21tdSBpbmZvLiBpcyB0aGUgaW9tbXUgZW5hYmxlZD8NClsgICAgNy42MjIxMjldIGtmZCBr
ZmQ6IGFtZGdwdTogRXJyb3IgaW5pdGlhbGl6aW5nIGlvbW11djINClsgICAgNy42MjI0MzBdIGtm
ZCBrZmQ6IGFtZGdwdTogZGV2aWNlIDEwMDI6MTVkOCBOT1QgYWRkZWQgZHVlIHRvIGVycm9ycw0K
DQoyMDIxLTEwLTExIDE0OjEzIEdNVCswODowMCwgeW91bGluZzI1NyA8eW91bGluZzI1N0BnbWFp
bC5jb20+Og0KPiBteSBrZXJuZWwgY29uZmlnIENPTkZJR19BTURfSU9NTVU9eSBDT05GSUdfQU1E
X0lPTU1VX1YyPXkuDQo+IGxpbnV4IGtlcm5lbCA1LjE1cmMyICJkcm0vYW1kZ3B1OiBtb3ZlIGlv
bW11X3Jlc3VtZSBiZWZvcmUgaXAgaW5pdC9yZXN1bWUiDQo+IGNhdXNlIG15IGFtZCAzNDAwZyBz
dXNwZW5kIHRvIGRpc2sgcmVzdW1lIGZhaWxlZCwgaGF2ZSB0byBwcmVzcyBwb3dlciANCj4gYnV0
dG9uIHRvIGZvcmNlIHNodXRkb3duLg0KPiBsaW51eCBrZXJuZWwgNS4xNXJjNSAiZHJtL2FtZGdw
dTogaW5pdCBpb21tdSBhZnRlciBhbWRrZmQgZGV2aWNlIGluaXQiIA0KPiBjYXVzZSBteSBhbWQg
MzQwMGcgYmxhY2tzY3JlZW4gd2hlbiBib290IGVudGVyIG15IHVzZXJzcGFjZS4NCj4gaSBuZWVk
IHJldmVydCAiZHJtL2FtZGdwdTogaW5pdCBpb21tdSBhZnRlciBhbWRrZmQgZGV2aWNlIGluaXQi
IGFuZA0KPiAiZHJtL2FtZGdwdTogbW92ZSBpb21tdV9yZXN1bWUgYmVmb3JlIGlwIGluaXQvcmVz
dW1lIiBmb3IgbXkgDQo+IHVzZXJzcGFjZSwgcnVubmluZyBhbmRyb2lkeDg2IHdpdGggbWVzYTIx
LjMgb24gYW1kZ3B1Lg0KPg0K

--_002_BN6PR12MB1187E3D949682D0714EA6253C1B59BN6PR12MB1187namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdkfd-fix-boot-resume-error-when-iommuv2-disabl.patch"
Content-Description:  0001-drm-amdkfd-fix-boot-resume-error-when-iommuv2-disabl.patch
Content-Disposition: attachment;
	filename="0001-drm-amdkfd-fix-boot-resume-error-when-iommuv2-disabl.patch";
	size=1644; creation-date="Mon, 11 Oct 2021 09:55:31 GMT";
	modification-date="Mon, 11 Oct 2021 09:55:31 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1ZmU2NzhiOTQwYzk1NjA4YjUyZmY5MTQ1YmM4ZmU3NjFlMGNiYWVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZaWZhbiBaaGFuZyA8eWlmYW4xLnpoYW5nQGFtZC5jb20+CkRh
dGU6IE1vbiwgMTEgT2N0IDIwMjEgMTc6NTM6MTUgKzA4MDAKU3ViamVjdDogW1BBVENIXSBkcm0v
YW1ka2ZkOiBmaXggYm9vdC9yZXN1bWUgZXJyb3Igd2hlbiBpb21tdXYyIGRpc2FibGVkIGluCiBi
aW9zCgpkcmFmdCBwYXRjaCB0byBmaXggdGhlIGlzc3VlLgoKU2lnbmVkLW9mZi1ieTogWWlmYW4g
WmhhbmcgPHlpZmFuMS56aGFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYyB8IDQgLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2RldmljZS5jICAgIHwgNCArKysrCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMKaW5kZXggYWY5YmRmMTZlZWZkLi45ZGZjZWYyMDE1YzggMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTI0MzIsMTAgKzI0MzIsNiBAQCBzdGF0
aWMgaW50IGFtZGdwdV9kZXZpY2VfaXBfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikK
IAlpZiAoIWFkZXYtPmdtYy54Z21pLnBlbmRpbmdfcmVzZXQpCiAJCWFtZGdwdV9hbWRrZmRfZGV2
aWNlX2luaXQoYWRldik7CiAKLQlyID0gYW1kZ3B1X2FtZGtmZF9yZXN1bWVfaW9tbXUoYWRldik7
Ci0JaWYgKHIpCi0JCWdvdG8gaW5pdF9mYWlsZWQ7Ci0KIAlhbWRncHVfZnJ1X2dldF9wcm9kdWN0
X2luZm8oYWRldik7CiAKIGluaXRfZmFpbGVkOgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2RldmljZS5jCmluZGV4IDRhNDE2MjMxYjI0Yy4uMWZhZGM5ZmIxNjhkIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jCkBAIC05MTYsMTAgKzkxNiwxNCBAQCBib29sIGtn
ZDJrZmRfZGV2aWNlX2luaXQoc3RydWN0IGtmZF9kZXYgKmtmZCwKIAlrZmRfZG91YmxlX2NvbmZp
cm1faW9tbXVfc3VwcG9ydChrZmQpOwogCiAJaWYgKGtmZF9pb21tdV9kZXZpY2VfaW5pdChrZmQp
KSB7CisJCWtmZC0+dXNlX2lvbW11X3YyID0gZmFsc2U7CiAJCWRldl9lcnIoa2ZkX2RldmljZSwg
IkVycm9yIGluaXRpYWxpemluZyBpb21tdXYyXG4iKTsKIAkJZ290byBkZXZpY2VfaW9tbXVfZXJy
b3I7CiAJfQogCisJaWYoa2dkMmtmZF9yZXN1bWVfaW9tbXUoa2ZkKSkKKwkJZ290byBkZXZpY2Vf
aW9tbXVfZXJyb3I7CisKIAlrZmRfY3dzcl9pbml0KGtmZCk7CiAKIAlzdm1fbWlncmF0ZV9pbml0
KChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWtmZC0+a2dkKTsKLS0gCjIuMjUuMQoK

--_002_BN6PR12MB1187E3D949682D0714EA6253C1B59BN6PR12MB1187namp_--
