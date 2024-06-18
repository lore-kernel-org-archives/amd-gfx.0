Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B1EC2BB9A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 07:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA44610E59D;
	Tue, 18 Jun 2024 07:18:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tfDx6VUD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D0F10E593
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 07:18:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF/xJxNS4wih0nfbDn73jyCw27BtfySrCRTit69ZkJacywj1Oe81eZh6MaaKuBKdJpfJERi0+UnTSCLMXFPOeEnWSMbaYVPgysicqhlZFkkKy3okjZx0HFCF0DNWK2UZYSYFM1Lt4z58xs1Y7Wndg7kW05145xCvQrXE1UixT0Q+hNrwoyiPTm8VzTcZRTLfWJOlVQog3icOmek+cC0eCEXff/BANXev7sTl2HxU8dkvWdMYBnRkN+corbTlLCHZC5YWWPK2AcqBZ/lhVahYe++Zs/XTQK+xjSDWWonrKEA31LHKnXTws/hj6JQ2bFTmRWX5xInzBd9M62ktwBu5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4voIdM/NPDAUVGzLs1Z/B5JLR+kcNFyttglUt42fPw=;
 b=XMsGz+jsw+BLL/UNFKalk4O9/mYy6eMD9LfLFY3PPP4ctDuhnnyBXOwuGWifzGZVolsP+CkK1okNy8cQR6fX4VgLLQy1aNxpv+msFNIW139U/N7QERLdRgNFZvXEe9D/zKTYN8F/8Q3VZmkxtlFod2pwhpWvmXSpnQdlnu5ihd498IGYNC5s7sfn/jXAXT8FHc2BlRtJ88rHqY63/6KSMIASdMqdPCMHWp9RPMzE7x4mybGA6IX6DzFq8xvZ8brOaguIf6X1kdbMgkezBfxtuj+/yJN4ELsaf1+ad52EsLf+eK91nPxcY7PQgtSL+3DBFbxgu3ujTpVcxCOzZ+9mpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4voIdM/NPDAUVGzLs1Z/B5JLR+kcNFyttglUt42fPw=;
 b=tfDx6VUDL8mVWE9W5xfGzJlK8tcZ0zYNAIoGLRW9KimsYKmbiAQgW76SM52W5yYl+b+FlreffoayeiWCd6CmcapJYx9hIJGyYzkNiGBrooayl2Dn3wyVjjJYNeFca934SB9B+IIDGAsdde1CbaYWau4wuaDaMCmUXpCupksnpO4=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 07:18:37 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%6]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 07:18:37 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH 5/5] drm/amdgpu: add gpu reset check and exception handling
Thread-Topic: [PATCH 5/5] drm/amdgpu: add gpu reset check and exception
 handling
Thread-Index: AQHawUmaMtPW0kUNE0eV3Dode3IuX7HNG09w
Date: Tue, 18 Jun 2024 07:18:36 +0000
Message-ID: <PH7PR12MB59977DF0F022392C22D51EEB82CE2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240618063359.304293-1-YiPeng.Chai@amd.com>
 <20240618063359.304293-5-YiPeng.Chai@amd.com>
In-Reply-To: <20240618063359.304293-5-YiPeng.Chai@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|IA0PR12MB8713:EE_
x-ms-office365-filtering-correlation-id: e262db23-f4f7-483e-461a-08dc8f66def9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info: =?gb2312?B?TU1ocXFJQi95WG15c0N5b3I3dFdTLzF5aWRuT2pTbHFKd1I0c21VVUJUTVp5?=
 =?gb2312?B?VGN0UFhDL0RRamVqRys0aFhEOGlCRFdoSHNYaW1HUnJaVVJaWnNxK3h6ek1z?=
 =?gb2312?B?ZjdlZmQxWFZUK2FjbUZSZFdud083d3dZM3B6SU1wVzlVY01QdjdPbmNnaTJY?=
 =?gb2312?B?YnhDRzc2cHB2aDVjVEhoS20yV0M0b05FYk5lVTQ0eVIwdUFpaFVpWC9FNFZi?=
 =?gb2312?B?d3F2ZDY5ODUxSTJmTVc1TnRpSVpSdFhXRU5JN3BxUWVtSnNHYUo0Z2ExakEz?=
 =?gb2312?B?Q1cxTzE3bHdEb0YrMmE5Mlp6cFVCa3gwVUJFMUZXdlpxMG1JZW9MeXpXNmRC?=
 =?gb2312?B?Unp2SCtCZi9FcDR6SXVQSndQbmptTFcyT1pzNlZ4Z1ZveTdYUUUyeHdWbU9N?=
 =?gb2312?B?bm5BcmFGRytMS0VuamVvdWc1NHRSSGdCa1VqM1g4M1FqamJnKzJ5SWkrUU9D?=
 =?gb2312?B?VTZ6dXMyUGU5bXoxR0E3N0ZwWHRrbmpRZmZmeU9WWU1oTXRvQnpMRUVQZ2cr?=
 =?gb2312?B?TXJuS0JHVHZMNXBkVGVrcURMMTVaekpsUG90UjdGcWdsVE90dlRFU2dCSDRX?=
 =?gb2312?B?VUE0ZC9xMWc4QS9hUTdSaGxQZVpJSHJsUFJvSmt0dGxNSk53em1CK3RmZjZN?=
 =?gb2312?B?UlV4SUhXWjhzLzhROVlmUXpISWhJaWVaVnJJSm5jbHZvZHZKcmkvVWpEa2FN?=
 =?gb2312?B?SWU2Wi9YektsS3RlcjYzeHI3UzJLZ28rMmtERmhOUEJSbnhpc2cvMXpDbCtv?=
 =?gb2312?B?NHFjYSs2SDZLdFVXQW1DUlJITXQ2TDhCOXplRFVIVWowRFNEYlBsRklUSE1t?=
 =?gb2312?B?ZDZrTUJ2cmxwLzUxbjE5YWdUMGVHZkpVakFNZU5ZQU56UjNLNEQ4TGYzMVF4?=
 =?gb2312?B?dHJEdXBTaE5Yd09INU9YOW5Md1NCY0hKWmxiY2V4eitja1c1SG90OVRoaWtS?=
 =?gb2312?B?ZFN1eEdmaFZFUkJaczBGQnYxSXJTaUVMeUE0dERabEpCeWJCN3AxamJYaW5K?=
 =?gb2312?B?blJrZHFKejAwT0VhK1hZbCsrT1VvKzhDZXg5Rk05RDBKOTNFbGo1WWdadG01?=
 =?gb2312?B?Zlo5TWlBRXY0WDhMMVIweWtJOEJxdUU2Y2tqMmNhZGt5RGNXZFU4RnhIdURL?=
 =?gb2312?B?WERzUW1ya1RnQVVoMTVXa2k4dmxrT2s1dmJDekk1eUxRVXFOTFpKWnJuUVBM?=
 =?gb2312?B?Y0JSczRNZkxRZEZmcXg5T0VBSTFPUi83VlFNTGV3M0J2dHRYbE5FZ0Ftemti?=
 =?gb2312?B?bVJXTDhzTS9zbUZpU1FGUERBUlJIZEdZNGJoY0RSL0hMdVJsTUFqT1ZVSllL?=
 =?gb2312?B?cEk3bVBXbDJiRWd6dHpwd1I1enczTFZtYWhtUGVGeTZRYXdZajBSeUwxNGpX?=
 =?gb2312?B?RS9jU25DLzE1cmZ0MXNtQzlvWXF4ZVVGR1B0MWNSU1orcVF3YWNDZnVreDhk?=
 =?gb2312?B?b0J4L3dKaC9VK2dYYnNONVB3YjdjVllGN1lYcDFWSlJmYnFMT3RKOUkxbEEw?=
 =?gb2312?B?RGRqd2xhS1pkZ1V5WmtYckxsdGdXR1Izb2NlVG1lRk8ySGRHWHBkTHhaSkVs?=
 =?gb2312?B?OVhLeEJ3SE1Hck42RjEwL1Y4QXZVSDNONG9LQmhYWFdHSmxGOWRyTStvNThL?=
 =?gb2312?B?ZDVXVi8vclpmSTgxZXRxdDJJUVA1SEtGR0RxMC9CeFhURFNKQng4RnlIQ1VN?=
 =?gb2312?B?UWxuSFMzZGFKODJSYWlBMTB2dnNtZTJmYVlDVDlBU0d5U0FFbEdaNWEza3hP?=
 =?gb2312?B?N3QrbUNYdDAyTDhZcWcwYW80OGNwM3lGdzZJVkRXUkw5elRVb2U5MG0wanI3?=
 =?gb2312?Q?iT2EpY3BiaYTHPnlPksWTUOhjv4ShHOrbV3/M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230037)(1800799021)(376011)(366013)(38070700015); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TFlINU9HQXE1TWU5SVpYMnpZUHpFclNzWkg1T3dPTTY4OWt4YU1mSytzbVU2?=
 =?gb2312?B?d1VGOXl5NklQNFdkWTR4aS9UaWRhNVBtUWxxNUdvK3V5TGNaTGVaaTVzV2FR?=
 =?gb2312?B?a3drdmVGeVQ2RkoxN3RKOCt0TTBrMGJVRzdxcWpXczgwQ1F3TWxTTnJtbXZP?=
 =?gb2312?B?dnZNMkdpdEJPaFJnTUsvUXZIa2dHOHp2djhKVGRGSElpam9QTEhsSitEaDVP?=
 =?gb2312?B?RjVtSnRXYWwzT0NxQ3RORVE4SDMyZ1R1bWpDQUF2dVRPWENEVW1wTEV5SDdp?=
 =?gb2312?B?OVNHZWh5dVBPeUhMWk5hbjBZQnJIVXRmVHdnQzRkcThOT0U3THJPYWxTTlVY?=
 =?gb2312?B?TjFkcVpEaThDMFZmT3ZNVWYwaUwrcVhBNWh5dUIrenB6WWFnQitYVjRqUWdX?=
 =?gb2312?B?a29ZYjZOTFNKZ0ZXNTdBNHM1SStCQXdzZ2Y3YWkvRUNRTVJuNGdEdk5jR2pi?=
 =?gb2312?B?WVk0NjhRa2FWazJLcHBRV0FVZHQ4OWZ0K1dkVmd1aGZFTnpyVEtBK01xUGJx?=
 =?gb2312?B?VDFkMFJ3MUxLbEdTeEZuQnA5VStUM1kwd1NaWitjbFZKZTJpL0NqNUlHbGRH?=
 =?gb2312?B?WCsrUWxja2NZbUIyM0NyWWRiTmh2QW43WFBydWNpZzdJd1o1VWI2UTZhbW5t?=
 =?gb2312?B?emxzVExmUTdwYklLL0lFY0RSVXF3T21YT1crVWxOUFIvWmhQYVVjYU9BMEFF?=
 =?gb2312?B?ZXQ4NEdGMnNEVTc2eU9vRTZ1eklON2lWMDFZUDI2S3JzMzdSM2RaRWVZZTJj?=
 =?gb2312?B?a0lsZ0Zheld6eStuVFFHTWVmeE1ILzlhQllHbFJxdFpVOEN3TUpOS0ZxbmlZ?=
 =?gb2312?B?RGQvRFkzR3VRMld5bjRNK3FNRmdBc203dTJYYk1rRDB3QnFWWUVDUTlVMkdJ?=
 =?gb2312?B?SEFIYk1LRmFYTUJJTnRpRG1vWm51U0FrekphajI3YnR1R01aTHd1YTk5RjFm?=
 =?gb2312?B?azM1UHdhcVYralNJbVR0eVZPd1RhQ1NtcU81dkpQSnMyVkNkejRwMGp0ajdt?=
 =?gb2312?B?QnVXY1lZbXNnckFMT2tWb2JDWlFWdTZKQmd3YllOQllUYUVZbXY5NXozeXNl?=
 =?gb2312?B?S3dRcmNxOEYrRXRTUmtZamN6dTlxVEhPOEpqMkliSjJ1NVRuTTdNdW1FRnZO?=
 =?gb2312?B?bmxBUE5OdmVoQ1dBK1g2RllGOFF4VHNNSkg1QW1lQ0QxVzI1aERESUs5WGFH?=
 =?gb2312?B?YU8wWmZYVzRkZ0dXWEc4WGNNQTZzOE1kOUZmQzBsekJ3d29rdTFkbktVRTV5?=
 =?gb2312?B?aUtFVFVydTI4TEh2SkVkV3RpbHBMdThodFU4QUpjS043a1hDQnY0L3hoRGtF?=
 =?gb2312?B?dnowYzlJMmJ1RDZqeTExUDhnMzZYSnBMWGpTL2tScjM0ZEtoY1BVUTZnREpR?=
 =?gb2312?B?WGZERnRhUDNlMVN1SjFodzhHZGlhMy9ibkFPOTlhcW5CbHNDK25Namh2dWUw?=
 =?gb2312?B?NkMrbEJBcFJPcTViV2JTSkw3K2RyR0xBZHhZZjhaNU9GcXNSaUNOdkxHVGZn?=
 =?gb2312?B?UDNnMGVwblhKdVFBMDlVSW9zU0RDYTlrSHk2MDYxMU5ZZ3VEZWNpTXZpRkky?=
 =?gb2312?B?YkV2NHQ0RUtrRXB2UGNMeENjN1l0Z3VYSnprQjNqcDFuMFovNHluZWxaL1VO?=
 =?gb2312?B?NmZ0eGkzalBpWGhvWkZFV09oTUpzZUJCTHU2b1hmYTkrcVR4dGtiblBqVXFM?=
 =?gb2312?B?aHpkYWtGbWRzRkNkQ0RpWk5SeGNUc3YwM0s5VnJvL1VjNlV1SXRyZmErSldX?=
 =?gb2312?B?QjhGQlVTdEJLRkxLSWRpUnlsbVhxSktBbmVDaU5UeXM1a2ZhdU9FT0NxUWp2?=
 =?gb2312?B?enlaeCtMSThtUUxKVndLa0x0djBGaTg1QmtEUHdBelpWS2xQbHNTSndDWFRV?=
 =?gb2312?B?SnphVHFKSlhSOCtGL0xKejEyMFZRRWJoY1dOanNkaWc4ZVpGSU5ZOFZ5Sito?=
 =?gb2312?B?UUxURFpheExpbmFoZWFZbktWSDZhMUIxNDVmelVnN1Zpb2d2QmZiZkhaM3E3?=
 =?gb2312?B?aDdXaHVNZ1V1R1pYZTV1NVh4ZHJkY0lwbGdCb0FnQUhTVUZyWHFjWFFsYlkx?=
 =?gb2312?B?RytQR1ozUTZZK3dCZFZ1L2dBbGRhcUxaM3BkK2ZTQ3BBalFWeXR0ZnBmZ2Fk?=
 =?gb2312?Q?KWo0=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e262db23-f4f7-483e-461a-08dc8f66def9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 07:18:36.9898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOrBr4pMYmHv6pHDR55ql7JxEnaQriduXuuyh/dp1IWk3EgiUWhyiUxJWZWPRcK+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713
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

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaGFpLCBUaG9tYXMgPFlpUGVu
Zy5DaGFpQGFtZC5jb20+IA0KU2VudDogMjAyNMTqNtTCMTjI1SAxNDozNA0KVG86IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdA
YW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgTGksIENhbmRpY2UgPENh
bmRpY2UuTGlAYW1kLmNvbT47IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQu
Y29tPjsgWWFuZywgU3RhbmxleSA8U3RhbmxleS5ZYW5nQGFtZC5jb20+OyBDaGFpLCBUaG9tYXMg
PFlpUGVuZy5DaGFpQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggNS81XSBkcm0vYW1kZ3B1OiBh
ZGQgZ3B1IHJlc2V0IGNoZWNrIGFuZCBleGNlcHRpb24gaGFuZGxpbmcNCg0KQWRkIGdwdSByZXNl
dCBjaGVjayBhbmQgZXhjZXB0aW9uIGhhbmRsaW5nIGZvciBwYWdlIHJldGlyZW1lbnQuDQoNClNp
Z25lZC1vZmYtYnk6IFlpUGVuZyBDaGFpIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KLS0tDQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgNDMgKysrKysrKysrKysrKysr
KysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCmluZGV4IDdmOGU2Y2EwNzk1Ny4uNjM1ZGM4
NmRiZmQ4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jh
cy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCkBAIC0x
Mzg2LDEwICsxMzg2LDE1IEBAIGludCBhbWRncHVfcmFzX3F1ZXJ5X2Vycm9yX3N0YXR1cyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IHJhc19xdWVyeV9pDQogCW1lbXNldCgmcWN0
eCwgMCwgc2l6ZW9mKHFjdHgpKTsNCiAJcWN0eC5ldmVudF9pZCA9IGFtZGdwdV9yYXNfYWNxdWly
ZV9ldmVudF9pZChhZGV2LCBhbWRncHVfcmFzX2ludHJfdHJpZ2dlcmVkKCkgPw0KIAkJCQkJCSAg
IFJBU19FVkVOVF9UWVBFX0lTUiA6IFJBU19FVkVOVF9UWVBFX0lOVkFMSUQpOw0KKw0KKwlpZiAo
IWRvd25fcmVhZF90cnlsb2NrKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSkpDQorCQlyZXR1cm4g
LUVJTzsNCisNCiAJcmV0ID0gYW1kZ3B1X3Jhc19xdWVyeV9lcnJvcl9zdGF0dXNfaGVscGVyKGFk
ZXYsIGluZm8sDQogCQkJCQkJICAgJmVycl9kYXRhLA0KIAkJCQkJCSAgICZxY3R4LA0KIAkJCQkJ
CSAgIGVycm9yX3F1ZXJ5X21vZGUpOw0KKwl1cF9yZWFkKCZhZGV2LT5yZXNldF9kb21haW4tPnNl
bSk7DQogCWlmIChyZXQpDQogCQlnb3RvIG91dF9maW5pX2Vycl9kYXRhOw0KIA0KQEAgLTI4ODQs
NiArMjg4OSwxNCBAQCBzdGF0aWMgaW50IGFtZGdwdV9yYXNfcG9pc29uX2NyZWF0aW9uX2hhbmRs
ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQogCXJldHVybiAwOw0KIH0NCiANCitzdGF0
aWMgdm9pZCBhbWRncHVfcmFzX2NsZWFyX3BvaXNvbl9maWZvKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KSB7DQorCXN0cnVjdCBhbWRncHVfcmFzICpjb24gPSBhbWRncHVfcmFzX2dldF9jb250
ZXh0KGFkZXYpOw0KKwlzdHJ1Y3QgcmFzX3BvaXNvbl9tc2cgbXNnOw0KKw0KKwl3aGlsZSAoa2Zp
Zm9fZ2V0KCZjb24tPnBvaXNvbl9maWZvLCAmbXNnKSk7IH0NCisNCiBzdGF0aWMgaW50IGFtZGdw
dV9yYXNfcG9pc29uX2NvbnN1bXB0aW9uX2hhbmRsZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsDQogCQkJdWludDMyX3QgbXNnX2NvdW50LCB1aW50MzJfdCAqZ3B1X3Jlc2V0KSAgeyBAQCAt
MjkxMyw2ICsyOTI2LDExIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Jhc19wb2lzb25fY29uc3VtcHRp
b25faGFuZGxlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCiAJCWVsc2UNCiAJCQlyZXNl
dCA9IHJlc2V0X2ZsYWdzOw0KIA0KKwkJLyogQ2hlY2sgaWYgZ3B1IGlzIGluIHJlc2V0IHN0YXRl
ICovDQorCQlpZiAoIWRvd25fcmVhZF90cnlsb2NrKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSkp
DQorCQkJcmV0dXJuIC1FSU87DQorCQl1cF9yZWFkKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSk7
DQoNCltLZXZpbl06DQpJJ20gY29uZnVzZWQgdGhhdCB3aHkgbm90IHVzaW5nICdhbWRncHVfaW5f
cmVzZXQoKScgaGVscGVyIGZ1bmN0aW9uIHRvIGNoZWNrIHJlc2V0IHN0YXRlPw0KDQpCZXN0IFJl
Z2FyZHMsDQpLZXZpbg0KKw0KIAkJZmx1c2hfZGVsYXllZF93b3JrKCZjb24tPnBhZ2VfcmV0aXJl
bWVudF9kd29yayk7DQogDQogCQlyZWluaXRfY29tcGxldGlvbigmY29uLT5yYXNfcmVjb3Zlcnlf
Y29tcGxldGlvbik7DQpAQCAtMjk3Nyw2ICsyOTk1LDMxIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Jh
c19wYWdlX3JldGlyZW1lbnRfdGhyZWFkKHZvaWQgKnBhcmFtKQ0KIAkJCX0NCiAJCX0NCiANCisJ
CWlmICgocmV0ID09IC1FSU8pIHx8IChncHVfcmVzZXQgPT0gQU1ER1BVX1JBU19HUFVfUkVTRVRf
TU9ERTFfUkVTRVQpKSB7DQorCQkJLyogZ3B1IGlzIGluIG1vZGUtMSByZXNldCBzdGF0ZSAqLw0K
KwkJCS8qIENsZWFyIHBvaXNvbiBjcmVhdGlvbiByZXF1ZXN0ICovDQorCQkJd2hpbGUgKGF0b21p
Y19yZWFkKCZjb24tPnBvaXNvbl9jcmVhdGlvbl9jb3VudCkpDQorCQkJCWF0b21pY19kZWMoJmNv
bi0+cG9pc29uX2NyZWF0aW9uX2NvdW50KTsNCltLZXZpbl06DQoNCkFoYSEgSXQgaXMgYmV0dGVy
IHRvIHVzZSBhdG9taWNfc2V0KCkgdG8gaW5zdGVhZCBvZiBpdC4NCg0KQmVzdCBSZWdhcmRzLA0K
S2V2aW4NCisNCisJCQkvKiBDbGVhciBwb2lzb24gY29uc3VtcHRpb24gZmlmbyAqLw0KKwkJCWFt
ZGdwdV9yYXNfY2xlYXJfcG9pc29uX2ZpZm8oYWRldik7DQorDQorCQkJd2hpbGUgKGF0b21pY19y
ZWFkKCZjb24tPnBhZ2VfcmV0aXJlbWVudF9yZXFfY250KSkNCisJCQkJYXRvbWljX2RlYygmY29u
LT5wYWdlX3JldGlyZW1lbnRfcmVxX2NudCk7DQorDQorCQkJaWYgKHJldCA9PSAtRUlPKSB7DQor
CQkJCS8qIFdhaXQgZm9yIG1vZGUtMSByZXNldCB0byBjb21wbGV0ZSAqLw0KKwkJCQlkb3duX3Jl
YWQoJmFkZXYtPnJlc2V0X2RvbWFpbi0+c2VtKTsNCisJCQkJdXBfcmVhZCgmYWRldi0+cmVzZXRf
ZG9tYWluLT5zZW0pOw0KKwkJCX0NCisNCisJCQkvKiBXYWtlIHVwIHdvcmsgcXVldWUgdG8gc2F2
ZSBiYWQgcGFnZXMgdG8gZWVwcm9tICovDQorCQkJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZjb24t
PnBhZ2VfcmV0aXJlbWVudF9kd29yaywgMCk7DQorCQl9IGVsc2UgaWYgKGdwdV9yZXNldCkgew0K
KwkJCS8qIGdwdSBpcyBpbiBtb2RlLTIgcmVzZXQgb3Igb3RoZXIgcmVzZXQgc3RhdGUgKi8NCisJ
CQkvKiBXYWtlIHVwIHdvcmsgcXVldWUgdG8gc2F2ZSBiYWQgcGFnZXMgdG8gZWVwcm9tICovDQor
CQkJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZjb24tPnBhZ2VfcmV0aXJlbWVudF9kd29yaywgMCk7
DQorCQl9DQogI2Vsc2UNCiAgICAgICAgIGRldl9pbmZvKGFkZXYtPmRldiwgIlN0YXJ0IHByb2Nl
c3NpbmcgcGFnZSByZXRpcmVtZW50LiByZXF1ZXN0OiVkXG4iLA0KICAgICAgICAgICAgICAgICAg
ICAgYXRvbWljX3JlYWQoJmNvbi0+cGFnZV9yZXRpcmVtZW50X3JlcV9jbnQpKTsNCi0tDQoyLjM0
LjENCg0K
