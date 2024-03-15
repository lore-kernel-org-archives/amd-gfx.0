Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DA4C54E5D
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 01:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F8CE10FF38;
	Fri, 15 Mar 2024 01:40:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FRRO5334";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 274D210FF38
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 01:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9ICwGNhpDX56D21kbGZ4dravSUnUeltsgyDwv4Q+YRYt+EoYtMB9P8cCrIdpb3rPaxs6DvSC1YQFxzRNFYLN3j3C5K88HWOMWkNywohH7X/36gJnzPa7LqBspNuFqUP8hgmO7tYg2eVAgKD/ljBZ/H/KNgwVAp306Ca+LTLy4rxFq6kMYPtUNguL330KI8HYb8P4wsxu2tIz0aO/IY6ssm5ue4KdcIpr9rmBe6L6RPTZH02/phN3Ui61Q0tpPYpEmOS7kULTXBqU2R1+RTV7RldfypIEoJn3VkRddy2vN2NpzG4wmcGJn9m5P/A8IQEEMWnAwEFdUlnWWoF5r0BvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPwH5f5LUP86GF4LS/xepzQYFyWKzi/eM6Xosx0luDA=;
 b=FRMRenVvaxo/5PhMZQITJqaIMREyxsPPacwb3BnFVloeBVp8Hbv54wl08QB8f5lGVoaSOZYQIB0bFARMn53EKBKaIPjKTrNbt+8NPeusXmxxyKzx2yC5V5pkWlAg5cg5HV+ni4N31aN3vGlHE3rPx+40ZHJGES4nUxNFzPcyJ/annQTCXuPbnaNHLEQNa9mkoEOO7P8qIsFjnWqh5E9DYw8EgHETkM11GbQz/5kRX05U01b/nYLgT78dH6SJuCScQXRalZMmBZNDFlJ9C3jyORc7bmtWzkq3Yj+yWyvbMFz+AhUkxOYMEE50mBpfCK8CeNjV8eQUIdPA+Nb7fgQ6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPwH5f5LUP86GF4LS/xepzQYFyWKzi/eM6Xosx0luDA=;
 b=FRRO5334xXSDxlv1MrcfzqT+WPcpvWr8s7UH+ihVryR1OeDrxKywDZTHqWcdGqFYSRF884/is6r1VLY5HX2XQBZzLCTA4+KScxQCvxFiEVJ9yFUBgoaR8M7/GdFm/9XXDUGcm2hjFE5IDm147fxLpTne+RzdbS2N1fTbPiyvko8=
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Fri, 15 Mar
 2024 01:40:28 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::950c:8c43:3454:884b]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::950c:8c43:3454:884b%4]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 01:40:28 +0000
From: "Lee, Peyton" <Peyton.Lee@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, "Ma, Li" <Li.Ma@amd.com>, "Yu, Lang"
 <Lang.Yu@amd.com>
Subject: =?utf-8?B?5Zue6KaGOiBbUEFUQ0hdIGRybS9hbWRncHUvdnBlOiBwb3dlciBvbiB2cGUg?=
 =?utf-8?Q?when_hw=5Finit?=
Thread-Topic: [PATCH] drm/amdgpu/vpe: power on vpe when hw_init
Thread-Index: AQHadTtmZPKIR7z+KUKKDKPyWJhnTbE1pxOAgADLt0CAAMFAAIAA0Wfg
Date: Fri, 15 Mar 2024 01:40:28 +0000
Message-ID: <MN2PR12MB437320223A607D4BAA8C182586282@MN2PR12MB4373.namprd12.prod.outlook.com>
References: <20240313114451.1592772-1-peytolee@amd.com>
 <CADnq5_OTwaLWJ9LiicJu-hO+WDF6fPB5PFQWzAqopyrDVn6R5Q@mail.gmail.com>
 <MN2PR12MB4373845FF59F1ACC83AAEFC986292@MN2PR12MB4373.namprd12.prod.outlook.com>
 <CADnq5_MzsCoj0VMKkQecWfGS1UAXE7Xvje3eoNbTP7fbdvXHRQ@mail.gmail.com>
In-Reply-To: <CADnq5_MzsCoj0VMKkQecWfGS1UAXE7Xvje3eoNbTP7fbdvXHRQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=75a20cad-4a42-4916-bc2a-bffdc274b18b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-15T01:27:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4373:EE_|DM4PR12MB6493:EE_
x-ms-office365-filtering-correlation-id: 0d64473f-7393-4629-b2b2-08dc4490e4bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iDrLbKo/Q/ts3DLsVx1TCUPfxTUJ1KJGVAy5cLdQNUBqDK3/+CM4QmQ2n6gyVuxlAZK9OrHJTTIRZlpJi/AgN2d4iuPbgU1Xs6ryLWMjullxQigOwWKgGPygMrzGQzaLK2OA8JqlK1dPLL4GjgZieoZOmiWmmoVC0YdA2lxvl8ayUcXxObxZScYqr6NZZ/weMiwp5V+8S0K/iTfEufeEljS81SvdEUrBoVcaAmszTZhqKcjn5yhwRbbMyy9m1SNjRCt5KX8IlxIrpjU35fNBpjku3S1FqP8SUr47GDFc7Zj5yUogUYSer7cMJKy4CX8fCyeCJDvDRuYCB2mxZphWkL/0yDJ0EhovhCsp7R3XSnoNwL/+lJjDQKX3XbCchQA9WVVejazobEbFyTaf4fRYod1tuGMWPxuU+FFiIXkX9osBAueju7fEDCxchV8U7BFXmVYsks17OcH7e/nxGuLnUTLhlDW7dhBJ+gWc4FiTWZ0YRqAQ3CZvMMrp5X4YTude2ar8VSpjWdfWf4Expq2sfuTYMpxVfh45CR6qhIpFYhQH2tWJ+/xjvhILp9aMo3pnPtCjo2yoajyXzXAexHgdq9ADx1yHf7JfIiEhTGrS9I1m3MWuixl7GvanNqptuyofhWfOIC2fAAcQ6Q7AXWb/ClCN0nmabA0nUDMKtGcIUYPHx8UBRUp3JB7rMUBopGb6tEvYrlPfMLT1db7zJP34KlchDxevgbCYB0SoFUB978s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:MN2PR12MB4373.namprd12.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlBjeVNSc0o5UDh4bFo1VzRPeTZQeGdVcTFqU2gzUTYyQWVNcEJ4WWdoaEp5?=
 =?utf-8?B?aEJWUVNoOGJoM25iQmF6MjRtWVV1OUZINVdzV1JFZ1NWQ2xtVSszUUU4ZlJH?=
 =?utf-8?B?b2Z0eGNpWjRzQTBZV1BKa1NKQ1NnN0lhNnpadndBZFBYWHNvaW1LS1h3MU5B?=
 =?utf-8?B?TnIvZnJMRHhlQWVYZ0Y2NFdxeHRQUW9GTUdMUC94UFh1QjhZMWNBbGQ0YzlS?=
 =?utf-8?B?UUp6OHZNOVpoSGJoOWVwd3BIS0FYcGZQUmk2NTROc1JXZGFCZVlTTHJEVG5I?=
 =?utf-8?B?R1NqSldEWHRtb3p3azdxSURXSzRoK3FRQS9VMEx0dGhUN21IblVETW5xS0hK?=
 =?utf-8?B?NHRuV1JKSGdWb1pYc1BEUWFlcU1La05QMThzTFZHSmhqbWY4Z242VkZrTE1P?=
 =?utf-8?B?ck55aGlaSUsxWnlIQ0VXLzlUa0ZOWDdwZXgwQ0hNQmpHbkE2eUExUHpFOG5I?=
 =?utf-8?B?bFByMzNybUZtTUJMcy9GT1p6Ky9hcVZXdUpSVXhYVEdLRGJhSmFMcUpXTVc1?=
 =?utf-8?B?MUYzdCtWc3krZUlNWXRtTkZjVWpoU2lMTzdhK2lTNE9HbURSOUt5U0hZTTlN?=
 =?utf-8?B?R0pjQjdpTGRhQnZFenI0RnRVdUJ2S1dVZ2lkZzBpckg2UWVVYzhQZDlvQjEz?=
 =?utf-8?B?a1FqYzdXa3FaeDlBalZidEtkQTF4a0xRN3RJSmRzUXNJNjVJRnhBRG4ycEty?=
 =?utf-8?B?MGZsRWRmQ2ZyYnFSUnlHcUJtTjZPcTg5M1VWM3p2MnB3ZVdmdVQ0TUZZNUYx?=
 =?utf-8?B?c2owai83ZURVSG5jaXdtTFhWU0swOU9QQnZjaUlsSnhISGs0ZENRSk1QTFVh?=
 =?utf-8?B?bFFvbTJwQjY5aDkzOEVUTHVDZlRQUmk0UEZtbDdOTUhqcVNjM01nWDdmdUU2?=
 =?utf-8?B?b1BvSEVadlI4MzVGMmtZMkhFNWM3V2FtSFhPd0daSjdGbzhyY0Izems2MVZ4?=
 =?utf-8?B?SkYzSCt2QWhjb0JTRER4R1dZZDhtQnpwc0ljd3Y5QkMzNURYZ2xSMzMwemto?=
 =?utf-8?B?V3JWQzZpUS9uVTRhUWFMdkJvYWNjalVrcWFTbmY2dFo2MVM4OEFLS3BHUEM3?=
 =?utf-8?B?cUZoSmJrNm51ZHltSjlwUjl3dEh1VHlTM05RWWVIV3FibHVrcWdmbElhbWdk?=
 =?utf-8?B?V0pEaks5S2FtVWxJa1M3aGlVZ2MrQ3c4ci91YlRXNWZ6dHh3aC80VHNrSmJB?=
 =?utf-8?B?bEZYSFhETGF3Y3lIaHRMZjNEUkpaZnVrK0lTMGsrUzRlSk96b0hGaDJNWjVK?=
 =?utf-8?B?eEdNZnptbit4VllpTi9sN3hsWmMyS0IyTHZVeFpKMG1Gd2JHZ1AxVXBkVnZp?=
 =?utf-8?B?elR2SWNjcnlZUGYvMVpyWElRMHg4OXN0MHZ3QU4ydVl3bWM5SjNGZEs1cE9O?=
 =?utf-8?B?Q0c2Rk00RU1mcklLSnJWeVNRdVk5bXpTY0diYU1nR0Y0MUJVYVRIYXl4bDls?=
 =?utf-8?B?K3hnYmRxTUlpOGN4OG1wVEV1VlNZdUNyWUh6bmI0OWJHRndTYU8wYkErWlIr?=
 =?utf-8?B?L29nVlROenFLdDF5eWwxUkxSNDN6REd0OC9hMnVDMk9idC9LOGl3OFM0czlW?=
 =?utf-8?B?dGFZM2RPSitjRUlab2hBSDYrOTJ2MXEvSDBsVFAyU0FOSDhIaFNaRC9meTRJ?=
 =?utf-8?B?NlQrVFp1STVMUmcycVBTenJtclRRcWRLeFp0TWVnR0pGRi9PZlp1em5pd2or?=
 =?utf-8?B?YkZaVlYwUVYxRnVjRGVISzg0TnJlR1VPdkFWQXpaOFkwblJoQi9SZFlRcUFp?=
 =?utf-8?B?Y2RibWRPTFdLWnB6RFVmbjFTOWVobWxKb0lGK3FZVUltT0Z6ZVh5WUVSWXpl?=
 =?utf-8?B?UFdPTDhnUXJmVkhUenhLUDY5WXRLd0hEa0Zqc25ES2kyRFI1TDBOUTFFSUFB?=
 =?utf-8?B?aTRwR3Zvd3hJNnlkR0hybDRvRGIzRGVYZUVqMWdydU5kVXExdURIVlpQNkxr?=
 =?utf-8?B?R09PeGYwMmRqZVJyUklBbUM3ZzBoY252SitVTG42bFoyR3l4R2RLdUJnZWw3?=
 =?utf-8?B?M1BNVlNsT1dCSldoSFRQd3ppR0dLaDVNUUg4cU1LN0lobmVhYnVXWnNNQWVX?=
 =?utf-8?B?K2ZwVkc4MmRZTTBzVlVnTEt1aURQQldaRGZZK3RodDFZWHNXQUh0OTFWRUlp?=
 =?utf-8?Q?hXNQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d64473f-7393-4629-b2b2-08dc4490e4bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 01:40:28.2647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GH/ZZ4Ny5KNZQHLOdd2NYfRNaNWCwNI3BzVJWSkcbFdVDoFIfXgSgqfpIf0WRORkHu8DY3l/wYAoa8aJWdmcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFsZXgNCg0KPiBJIHRoaW5r
IGl0IHdpbGwgY29udGludWUgdG8gYmUgcG93ZXJlZCB1cCB1bnRpbCBhIFZQRSBqb2IgY29tZXMg
aW4gYW5kIGNvbXBsZXRlcyBhbmQgdGhlIGlkbGUgaGFuZGxlciBnZXRzIHNjaGVkdWxlZC4gIElm
IGEgVlBFIGpvYiBkb2Vzbid0IGNvbWUgaW4sIGl0IHdpbGwgc3RheSBwb3dlcmVkIHVwIEkgdGhp
bmsuDQpZZXMsIGNvcnJlY3QuDQpBbmQgYWZ0ZXIgdGhlIFZQRSBpcyBjYWxsZWQgdG8gZG8gaW5p
dGlhbGl6YXRpb24sIGEgc2ltcGxlIHRlc3QgaXMgZXhlY3V0ZWQgZm9yIGNoZWNraW5nIFZQRSBz
dGF0dXMsIGFuZCB0aGUgaWRsZSBoYW5kbGVyIGdldHMgc2NoZWR1bGVkIHRvIHBvd2VyIG9mZiB0
aGUgVlBFIHdoZW4gdGhlIHRlc3QgZmluaXNoZWQuDQoNClRoYW5rcywNClBleXRvbg0KDQotLS0t
LeWOn+Wni+mDteS7ti0tLS0tDQrlr4Tku7bogIU6IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJA
Z21haWwuY29tPg0K5a+E5Lu25pel5pyfOiBUaHVyc2RheSwgTWFyY2ggMTQsIDIwMjQgODo1OCBQ
TQ0K5pS25Lu26ICFOiBMZWUsIFBleXRvbiA8UGV5dG9uLkxlZUBhbWQuY29tPg0K5Ymv5pysOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdAYW1kLmNvbT47
IE1hLCBMaSA8TGkuTWFAYW1kLmNvbT47IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+DQrkuLvm
l6g6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHUvdnBlOiBwb3dlciBvbiB2cGUgd2hlbiBod19pbml0
DQoNCk9uIFdlZCwgTWFyIDEzLCAyMDI0IGF0IDk6MzPigK9QTSBMZWUsIFBleXRvbiA8UGV5dG9u
LkxlZUBhbWQuY29tPiB3cm90ZToNCj4NCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVy
YWxdDQo+DQo+IEhpIEFsZXgsDQo+DQo+IFRoZXJlIGFyZSB0d28gcGxhY2VzIHdoZXJlIFZQRSB3
aWxsIGxvc2UgcG93ZXI6IFdoZW4gdGhlcmUgaXMgYSBzeXN0ZW0gY2FsbCB0byB2cGVfaHdfZmlu
aSgpLCBhbmQgdGhlIHZwZS10aHJlYWQgZmluZHMgdGhhdCBWRVAgaGFzIG5vIGpvYnMgaW4gdGhl
IHF1ZXVlLg0KPiBUaGlzIHBhdGNoIGlzIHRvIG1ha2Ugc3VyZSB0aGF0IFZQRSBpcyBwb3dlciB1
cCBiZWZvcmUgbG9hZGluZyBmaXJtd2FyZS4NCg0KSSB0aGluayBpdCB3aWxsIGNvbnRpbnVlIHRv
IGJlIHBvd2VyZWQgdXAgdW50aWwgYSBWUEUgam9iIGNvbWVzIGluIGFuZCBjb21wbGV0ZXMgYW5k
IHRoZSBpZGxlIGhhbmRsZXIgZ2V0cyBzY2hlZHVsZWQuICBJZiBhIFZQRSBqb2IgZG9lc24ndCBj
b21lIGluLCBpdCB3aWxsIHN0YXkgcG93ZXJlZCB1cCBJIHRoaW5rLg0KDQpBbGV4DQoNCj4NCj4g
VGhhbmtzLA0KPiBQZXl0b24NCj4gLS0tLS3ljp/lp4vpg7Xku7YtLS0tLQ0KPiDlr4Tku7bogIU6
IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KPiDlr4Tku7bml6XmnJ86IFdl
ZG5lc2RheSwgTWFyY2ggMTMsIDIwMjQgOToxNyBQTQ0KPiDmlLbku7bogIU6IExlZSwgUGV5dG9u
IDxQZXl0b24uTGVlQGFtZC5jb20+DQo+IOWJr+acrDogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+OyBNYSwNCj4gTGkgPExpLk1hQGFt
ZC5jb20+OyBZdSwgTGFuZyA8TGFuZy5ZdUBhbWQuY29tPg0KPiDkuLvml6g6IFJlOiBbUEFUQ0hd
IGRybS9hbWRncHUvdnBlOiBwb3dlciBvbiB2cGUgd2hlbiBod19pbml0DQo+DQo+IE9uIFdlZCwg
TWFyIDEzLCAyMDI0IGF0IDc6NDHigK9BTSBQZXl0b24gTGVlIDxwZXl0b2xlZUBhbWQuY29tPiB3
cm90ZToNCj4gPg0KPiA+IFRvIGZpeCBtb2RlMiByZXNldCBmYWlsdXJlLg0KPiA+IFNob3VsZCBw
b3dlciBvbiBWUEUgd2hlbiBod19pbml0Lg0KPg0KPiBXaGVuIGRvZXMgaXQgZ2V0IHBvd2VyZWQg
ZG93biBhZ2Fpbj8gIFdvbid0IHRoaXMgbGVhdmUgaXQgcG93ZXJlZCB1cD8NCj4NCj4gQWxleA0K
Pg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGV5dG9uIExlZSA8cGV5dG9sZWVAYW1kLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZwZS5jIHwg
NiArKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cGUuYw0KPiA+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZwZS5jDQo+ID4gaW5kZXggNzBj
NWNjODBlY2RjLi5lY2ZlMGYzNmU4M2UgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZwZS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZwZS5jDQo+ID4gQEAgLTM5Niw2ICszOTYsMTIgQEAgc3RhdGljIGludCB2
cGVfaHdfaW5pdCh2b2lkICpoYW5kbGUpDQo+ID4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3ZwZSAq
dnBlID0gJmFkZXYtPnZwZTsNCj4gPiAgICAgICAgIGludCByZXQ7DQo+ID4NCj4gPiArICAgICAg
IC8qIFBvd2VyIG9uIFZQRSAqLw0KPiA+ICsgICAgICAgcmV0ID0gYW1kZ3B1X2RldmljZV9pcF9z
ZXRfcG93ZXJnYXRpbmdfc3RhdGUoYWRldiwgQU1EX0lQX0JMT0NLX1RZUEVfVlBFLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1EX1BH
X1NUQVRFX1VOR0FURSk7DQo+ID4gKyAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiAgICAgICAgIHJldCA9IHZwZV9sb2FkX21pY3JvY29k
ZSh2cGUpOw0KPiA+ICAgICAgICAgaWYgKHJldCkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJu
IHJldDsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
