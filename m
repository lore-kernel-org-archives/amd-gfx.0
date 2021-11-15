Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DD9C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 16:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E61461C32
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 16:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E61461C32
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CE6D6E0A6;
	Mon, 15 Nov 2021 16:11:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E49EA6E0A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 16:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSc9aBmcqf1H7Av92UZyL8Zf+pY2C1Kdnt11Ol3xtIQgFxXCRs73+u7yxYbDineJN0TqwoXpl4Ax18D7id03VobbgstR7gN5oQ7UqiddKiXJtQmigEplM612p1T+tPF4WiH+BBQmvd6Q8bXr2HiFulp5J/q7R2DCgGuPrxDzxgGfKjT9x7T6zv5wg5YnZXV0dRCaU1dm0zAal9qDBwylwQgP4BqPM6e329igOwCKmtci7UJOEZ9MAq17URRTc6oKiqSkvU8dcjOsX6KR6Pkh2VBpRRsGqui1m1f0xcSWySB6zm2sZkPfeSXNGWH92wN5rVPzywrTG0F1zXmx4dlE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcTvKJhJTO+7efUKoPIGLhZ7yFiwaQv+eO9XdmrqeL0=;
 b=eZnc0xAiGZukQCeJd7LFGODoYmF7tFrxQR4QN0qMnLrW7vDhhA7xlcNQdA9hWxjy3fHVpeiKUd4wz6ZdJrIX7RAv/B+KS69Y4A6tiWiMI0vV5me3Qd2i8GTiph5PeGgTErYEILoLbDpou4yZZadNQAA1KU5sKtWXTP+SfigOfA56KtlAz30wwR5lyLjaitsk0XBvmwtVUdFTZzEjMhY5+KRIflhZdcmmQ0xiWxhOPHJeHXfnEgOK/fv1fXu/foX6wlsgK4NUWehePA6TntH/BhzcjymHD6Vm8iKCrpnL8D1fxtUwPLsoQoGjbNNb8nIFp1fKvM2HYYeVl4MSV/gCpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcTvKJhJTO+7efUKoPIGLhZ7yFiwaQv+eO9XdmrqeL0=;
 b=0A9TSy1M83EiEeGlVpOBnCYqttqbqX9qjHZpxb+n3ZIT+oje7xvtVCR03WBDiTGBrULSuXx8jcu7UfQCXiyOcK9MEDaq1WZYsTYx93GXwYX6J2Qc8lTkFu1pz9JHxXwmYDKW/ONHHaagKJeSwnBjvgp7J4gqA3cEC9/j9TCtBhU=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5332.namprd12.prod.outlook.com (2603:10b6:610:d7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Mon, 15 Nov
 2021 16:11:54 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::d1fa:7115:639b:7ac8]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::d1fa:7115:639b:7ac8%5]) with mapi id 15.20.4690.026; Mon, 15 Nov 2021
 16:11:54 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdkfd: Fix kernel panic when reset failed and
 been triggered again
Thread-Topic: [PATCH] drm/amd/amdkfd: Fix kernel panic when reset failed and
 been triggered again
Thread-Index: AQHX2YDMkRUpQUvKukuG/egnGm3jfqwEwpiAgAAA/JA=
Date: Mon, 15 Nov 2021 16:11:54 +0000
Message-ID: <CH0PR12MB5372288CA8A7F03210C2947FF4989@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211114175503.10197-1-shaoyun.liu@amd.com>
 <75704fb5-369c-f587-4b5a-81f7828a0cb1@amd.com>
In-Reply-To: <75704fb5-369c-f587-4b5a-81f7828a0cb1@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-15T16:11:52Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fade6e6a-eb10-4337-bc16-3414d8aaa947;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e98e6646-82dd-4c4b-31d7-08d9a852a469
x-ms-traffictypediagnostic: CH0PR12MB5332:
x-microsoft-antispam-prvs: <CH0PR12MB5332FAFD6776CD638D5F0802F4989@CH0PR12MB5332.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VT+0PBmTZ+KewQJ87lrTB+Y/WNE/j0ZN7BHS6yEtir+DrUymaIsDyDotqSHmYjtBVL12CFx2soavBclj/P1C/fw419kD1XOYbnFSiR/PWG9kH3f0uhlTjJCGNsHQbqMV/KLcgiUJW9aii7nYTiaj5Fy7i1AwhitjYBSqHttm+Xvv9oGjpODVHtK44+p9N6vubjlSeoc9obnIpu2BhcJFULVh+qc6fn+/IYHdf4DaUa7UM6zKU07XhkP3eSDPp8tB8G0z6K+9CPulo6BOficBoND8am7MMiUDvHBhm38bl7IFsH2Kh5GsZ09ZEe1UXAxIybB34I986hqH+YlnpmDW90ZNOIprAqh70Y91xDQqwBqV2B+K8kaAs7VSH5efbxkB18dM99ubfArWoXHu3qDx8C3sKIoORDhxFSAf0cxiK/JbdU66t15uqAmejCy0GlMSSgFkCiW3FzV40hShA5bsriAApBEnGgo75YaQ+21jaIB8vX/MC4EaVaV1SuTYTd1FqLe3F7d3jbJJ57JiI4zcGLvXl8/ttP8XgPO7+hvUZcWK9uKv9rZdA+3bXNjaJN05FHhDUE/uF52XJ3MPfEaRotSmLWm1lyqHfbCTor1r2KfMeHFXrvORoHOzHD4zKZQA5p9wgBZC5NnPX0ExVp1a5zsbqrEy1SHJdEyh+1Es1TAvPpGFe1V4CRkl0bVfUV/554TH84DIfNKZWJqzDs0Irg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(66946007)(8936002)(33656002)(86362001)(83380400001)(6506007)(53546011)(122000001)(64756008)(66556008)(66446008)(110136005)(66476007)(71200400001)(4001150100001)(52536014)(508600001)(38070700005)(9686003)(7696005)(38100700002)(5660300002)(76116006)(55016002)(186003)(316002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cllXTG1zMkRuTnpTUUQrTDd4MzdCTWhEMncvV3RWR2VUZGFtRjVRTkVvWnpj?=
 =?utf-8?B?SmRJb29IMFNZOXlvaG9DZDBVbDBYbnZRUU1taGxrWGxIejhWWlpqRW9rT1Rm?=
 =?utf-8?B?SzhGVFFiNm5OaCt0YzZzbUFTMFc1eGcvbmRpZ0cxSTFGeW1tbFl0L2NrTVFi?=
 =?utf-8?B?b0RWRFN3dkFOS0RscVdKYXdRY1JlQjJERWhHclRzaVE5bXBFaWM2ZXp3bmxz?=
 =?utf-8?B?S0pPcVBZQmdiT0p2YVFRUFNBeGRVUjFON01ySzY5UWwwZmQ0TEZEeUs2Tk0v?=
 =?utf-8?B?aGsvNW1UZkR3T1RTcmxWZklGSE5Xb09ZNXd4QVJOL3d1TVRaMU1hTUpyVm8x?=
 =?utf-8?B?SDdjQyszSUlJOW1jNnUrdFZ1RTRrQS9pQStYeHJwWnpIQUhhNitvQUplTmZz?=
 =?utf-8?B?UkVSNlpONiszaEk4SmZ2Q2JFMmFTOVJxTFV4VzZ3RWJRL0IxN0kvT0RVS05O?=
 =?utf-8?B?ZDNFZzZ1SVA3LzNhNTM0eHRkMG56Q3BPYnJUL0phSm5JSi9uWGtBSkR2a0N5?=
 =?utf-8?B?OUJhRDZMaG9nQ1RaV1ByT1hYS1hrZTBSOEYyTk1ZV0hKWVRHcDJIZ0VLZGhy?=
 =?utf-8?B?YmZKaXMzWFlZb0FVRmNTRURSc0FxejVpbk56QjhkcDU0UnVPcHhoSkw2c2Ev?=
 =?utf-8?B?M3Jyenh6ZmJXS0ZOelNmMlF1V3o5QUp1aWZ2ekl0blBkckZnalZ3dXBPSXQ2?=
 =?utf-8?B?SGhoZXBlK2dndVAyOWpRUm5YcFFIQ081V1pQakdCa2plUHl4RVNsczZvWlVy?=
 =?utf-8?B?SjM3WUN2K1lhRkFTQjFVSGhYbkVObnhJSnY4SGdWa3NTaWhMSEU5dGE3SVBt?=
 =?utf-8?B?RUV4QnNOdXpDS2lweUNlRFN2OFRxSWROeHcvYTRkYVFzVGpzN3RJRjJuVEs2?=
 =?utf-8?B?RFVnYlFVK3RmRTlNb0xGWnR4NEg4N21ET0hHZy8zTzA5OWgzVjlYZWQ4K2Jk?=
 =?utf-8?B?WWtQQmhkN3NVSjJ6L3pmRE96N0laa2ZPNWNUZVlMNTlGZ0lJbmlnV2lpUFRq?=
 =?utf-8?B?ZktaZDlWRWxIbzFLdi9XcTd0d2d4THdzTjNxdVdjLzhEaDNqelVHa1A1ekds?=
 =?utf-8?B?ZHRjVXc5RDZFZGY0UVowUTdYL1hYSVZHWVVudkxaeDREeDNMbVJvaThCVEJY?=
 =?utf-8?B?MWlHZko0SENxZ2IxdlRveEV4ZndDRENKekZhWGdnc05MVElvczBzcTl1dUk0?=
 =?utf-8?B?WklnT05NQVd0UjV1ekZwWW1uWExSZFFyRDJPak5td3k0UjEzRVI3RkpWU1Iy?=
 =?utf-8?B?RVczRkp3YTYrOVg2ZDFJa05qRVpJWVVBN2R4QnYzT1VEZ2ZLOEhHNmJDTE8z?=
 =?utf-8?B?L1hMbVh3RjJrNE9tUTFyalVnZy9ZTWxqUWdsclZBRjVJVGxMTWlmVEE3SEFK?=
 =?utf-8?B?Mis0ZzloYmtudmhwOWJmeEY1aGU2Z28yZm8zWm1vcmtYNnN5WlN4WHRLZGlt?=
 =?utf-8?B?MGJEYS9FMk5yV1VzOURRTmM3cUVBUXZRTkJGd2p0enBKQ2h6UkZGTVgrcjVq?=
 =?utf-8?B?QXJmRlZIK0s4NytEQ2F3YkdrT0hIMjB3TGJSdjNmMmhwUU1oTDJwcFl1c2N6?=
 =?utf-8?B?dUZiN1EwcER0U3FkVUVQZ2ZZTXl1UXl4Zjg2SkpNZU9aMlY4QUpyZXhZZVE5?=
 =?utf-8?B?dFNrZlhXYjdKL1VhSXZZaGZPQmhnamdmZGVRZ0JHRGlrRmdxNzlUeTNrY1Ji?=
 =?utf-8?B?RGpCT2FQOGRCV3dINnk5aFVLTWRVSkhJdnJGYjFkMHE4UU1DVUM5aUIzd3Ev?=
 =?utf-8?B?MjhickIrUmRQdmJVeEZZMnlCMXAyQ0NxK3Z4ZzFKejBqcVo1WXlLSSs5Qnp1?=
 =?utf-8?B?SDNNeUdmVjFVOG5GNTM4TkUzQmUzMUVtVHhzUUFFVjVVVCtVUldJVVZVZGdN?=
 =?utf-8?B?MXkvWERNbVJKSGJKZDV4TWtJanVhNlJWOXlob1hDYXRzOEkySmQyVmVRZmw4?=
 =?utf-8?B?MGpFcTBSTmVCdUdDbE9NbWthYlQyMWsxR0xtdDJuSlZGVGprK3dhMU0wZ1BN?=
 =?utf-8?B?dityaS9pVzYzZDhMSVNLRWtBWUlTcmdnT21iZk1kb0tEbjJDbUx3Szc0T0x2?=
 =?utf-8?B?MmhCQ0VkMXdQT2xDbVhxeVMybTRNdEhoQWw2Y0x0TnBlc21rNi9vR29vc3hq?=
 =?utf-8?B?dUZZUnpYaUZ1K3VTdUpxQW5WZWYzdWVGNm5MczUrSFd5Y3U0SjdqUEQ1azRW?=
 =?utf-8?B?OWQrOHlEcm5XV01PelFjcWt2d0NTK05hOFg1NFFTd3BhYnVoTWQ2NFZLcklo?=
 =?utf-8?B?QW5yRTdlK3U3Nks4OFpuMC9iSEtnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98e6646-82dd-4c4b-31d7-08d9a852a469
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 16:11:54.6677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcpUqVknYwAg7zaA4DkJaVoZ6QcuWperY/YBqhvABwUuH7CMBWlPPj9zIh6AOF2ZYd5elDwf0ldU59+sqWE7pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5332
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KT20sIHNvdW5kcyByZWFzb25hYmxlIA0KDQpUaGFu
a3MgDQpTaGFveXVuLmxpdSANCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEt1
ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4gDQpTZW50OiBNb25kYXksIE5v
dmVtYmVyIDE1LCAyMDIxIDExOjA3IEFNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc7IExpdSwgU2hhb3l1biA8U2hhb3l1bi5MaXVAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGRybS9hbWQvYW1ka2ZkOiBGaXgga2VybmVsIHBhbmljIHdoZW4gcmVzZXQgZmFpbGVkIGFu
ZCBiZWVuIHRyaWdnZXJlZCBhZ2Fpbg0KDQpBbSAyMDIxLTExLTE0IHVtIDEyOjU1IHAubS4gc2No
cmllYiBzaGFveXVubDoNCj4gSW4gU1JJT1YgY29uZmlndXJhdGlvbiwgdGhlIHJlc2V0IG1heSBm
YWlsZWQgdG8gYnJpbmcgYXNpYyBiYWNrIHRvIA0KPiBub3JtYWwgYnV0IHN0b3AgY3BzY2ggYWxy
ZWFkeSBiZWVuIGNhbGxlZCwgdGhlIHN0YXJ0X2Nwc2NoIHdpbGwgbm90IGJlIA0KPiBjYWxsZWQg
c2luY2UgdGhlcmUgaXMgbm8gcmVzdW1lIGluIHRoaXMgY2FzZS4gIFdoZW4gcmVzZXQgYmVlbiB0
cmlnZ2VyZWQgYWdhaW4sIGRyaXZlciBzaG91bGQgYXZvaWQgdG8gZG8gdW5pbml0aWFsaXphdGlv
biBhZ2Fpbi4NCj4NCj4gU2lnbmVkLW9mZi1ieTogc2hhb3l1bmwgPHNoYW95dW4ubGl1QGFtZC5j
b20+DQoNCklmIHRoZXJlIGlzIGEgcG9zc2liaWxpdHkgdGhhdCBzdG9wX2Nwc2NoIGlzIGNhbGxl
ZCBtdWx0aXBsZSB0aW1lcywgSSB0aGluayB0aGUgY2hlY2sgZm9yIHRoYXQgc2hvdWxkIGJlIGF0
IHRoZSBzdGFydCBvZiB0aGUgZnVuY3Rpb24uDQpTb21ldGhpbmcgbGlrZToNCg0KwqDCoMKgIGlm
ICghZHFtLT5zY2hlZF9ydW5uaW5nKQ0KwqDCoMKgIMKgwqDCoCByZXR1cm4gMDsNCg0KUmVnYXJk
cywNCsKgIEZlbGl4DQoNCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jIHwgMTAgKysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jIA0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+
IGluZGV4IDQyYjJjYzk5OTQzNC4uYmNjODk4MGQ3N2UwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYw0KPiBA
QCAtMTIyOCwxMiArMTIyOCwxNCBAQCBzdGF0aWMgaW50IHN0b3BfY3BzY2goc3RydWN0IGRldmlj
ZV9xdWV1ZV9tYW5hZ2VyICpkcW0pDQo+ICAJaWYgKCFkcW0tPmlzX2h3c19oYW5nKQ0KPiAgCQl1
bm1hcF9xdWV1ZXNfY3BzY2goZHFtLCBLRkRfVU5NQVBfUVVFVUVTX0ZJTFRFUl9BTExfUVVFVUVT
LCAwKTsNCj4gIAloYW5naW5nID0gZHFtLT5pc19od3NfaGFuZyB8fCBkcW0tPmlzX3Jlc2V0dGlu
ZzsNCj4gLQlkcW0tPnNjaGVkX3J1bm5pbmcgPSBmYWxzZTsNCj4gIA0KPiAtCXBtX3JlbGVhc2Vf
aWIoJmRxbS0+cGFja2V0X21ncik7DQo+ICsJaWYgKGRxbS0+c2NoZWRfcnVubmluZykgew0KPiAr
CQlkcW0tPnNjaGVkX3J1bm5pbmcgPSBmYWxzZTsNCj4gKwkJcG1fcmVsZWFzZV9pYigmZHFtLT5w
YWNrZXRfbWdyKTsNCj4gKwkJa2ZkX2d0dF9zYV9mcmVlKGRxbS0+ZGV2LCBkcW0tPmZlbmNlX21l
bSk7DQo+ICsJCXBtX3VuaW5pdCgmZHFtLT5wYWNrZXRfbWdyLCBoYW5naW5nKTsNCj4gKwl9DQo+
ICANCj4gLQlrZmRfZ3R0X3NhX2ZyZWUoZHFtLT5kZXYsIGRxbS0+ZmVuY2VfbWVtKTsNCj4gLQlw
bV91bmluaXQoJmRxbS0+cGFja2V0X21nciwgaGFuZ2luZyk7DQo+ICAJZHFtX3VubG9jayhkcW0p
Ow0KPiAgDQo+ICAJcmV0dXJuIDA7DQo=
