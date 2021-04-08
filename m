Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722BBC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 15:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2383E6113B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 15:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2383E6113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B24236EB5F;
	Thu,  8 Apr 2021 15:55:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A9ED6EB5E
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 15:55:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg0qTutGfkYsQGN3J2LKGSO12MYgQfAdOzd8FqjHjCNMvRf58lVqoJlRBsQvfGyowOf2o0Xwhkh+XtEd85JXV9NBVQgFfJfPXfI1wBJmaNKTQfq9XlvOBoWYqGnl2ecyBogH6YeMctya3T2SB6f4CaX9y0456v9DwZG5/GvKZQ1BovtZCpRSjE2gUH6bfmsFkipEJhG6XjOkCF1fFd5D5K++xAnxtv8rfaL1J4+2RNSozWRlO8pteSQTue1xdkvxbUq4eHat+U0Sz0jpemTuMeKTNG6tHjpATacrOxEDmgCgMuLor5dxXLSlZ73130Iai757vmiHQvOLeFzP3FLRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFCDGBS0WR7KrFC4E+3KBd69RFLrE437GxVOBkE9x08=;
 b=joC3y5YhRBy+hO/usrXmYObuIIW+2XY3trzINQFFlwjb07lU/6Gpd+HNk2yHTSqRD+4GYCMKsvlMNdm41Wy1n5t46ZNKfY7YOELun4JHHLmAJ7FFWXRTy4+y6TVBMKRYArx/iwRu3cMZYDmBJ2sV7tJp+3CoKV/k7rmlmscTksCbGC3cGhmhGkG+bvrHQhyJHxkiBOBqpt3doq6yjEtysLV53czHpfUYFEMV8oqatlhJQIdLwlcjbY4OghJFLe9Q+1yJHDUBcGxoVq/ulmFX7MN50AWyk2os/H7RAQ3syB/sFhZX/Sznd0Vlv2bR0t0eepQLzHBzdX3g6JLvRU3p5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFCDGBS0WR7KrFC4E+3KBd69RFLrE437GxVOBkE9x08=;
 b=sJUoReeaBwAp3B7Vw4NOVFQrFzsvvSeGSVyKyHL4WjbP8zJJ1k2z5u2R8cTRcxfRbiwwPTbfB0ujf8D1ajo9TgWjQ+UNdFNhas62O68q/SfGvJ13j2NjzCx+zIpWUkWccO1QOH0dASssEuFv2VUViVmFkFLOl5f+/U4qPkCFkus=
Received: from DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13)
 by DM4PR12MB5056.namprd12.prod.outlook.com (2603:10b6:5:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Thu, 8 Apr
 2021 15:55:32 +0000
Received: from DM4PR12MB5120.namprd12.prod.outlook.com
 ([fe80::cd02:f7b3:cbfb:9d8d]) by DM4PR12MB5120.namprd12.prod.outlook.com
 ([fe80::cd02:f7b3:cbfb:9d8d%3]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 15:55:32 +0000
From: "R, Bindu" <Bindu.R@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Update DCN302 SR Exit Latency
Thread-Topic: [PATCH] drm/amd/display: Update DCN302 SR Exit Latency
Thread-Index: AQHXLI6cJX1LMWhQIEScRWkZSH3WNaqqxOpP
Date: Thu, 8 Apr 2021 15:55:31 +0000
Message-ID: <DM4PR12MB5120EC535F3450809DF84D60F5749@DM4PR12MB5120.namprd12.prod.outlook.com>
References: <20210408154821.729834-1-aurabindo.pillai@amd.com>
In-Reply-To: <20210408154821.729834-1-aurabindo.pillai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-08T15:55:31.582Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc83db60-f498-4112-a3c2-08d8faa6bd49
x-ms-traffictypediagnostic: DM4PR12MB5056:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB50562F23EAED4723A546AA9CF5749@DM4PR12MB5056.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: acH5R0+BvUJsub0h+5FVVEbWEBIhk2jxT0BosKFsElqFTFaTIElbBUl0TCsKIPu3j24VW+R5iKR7wKIg6wuOuAxzSCBjVYXLTk6Whjn0MMFx8onp5bcUEBsXDhpSPpM6HPDbBk++ytIdlgQXkkmDDgIsKSHOv43LoP1fvW4HbnyYaOrc3Gskbe/I3DB65QGs/Lbrs/bSO9okHIj4WVk5g0VfF/ceoEQ/DUYUhLi7SyWT9UegIl3hrWAblCIaFJ2dW3lLr1VXkqxsAJnjCkjNYfGMsjwsk0CuHD5XuNQHEI5cPb1bOZR8rsIMM7fbVGP+XPUQuCjVbQwWOQQGfCUYn9+3ddXCLP3UselXK7G6NqiOqrJVbWjKhP7911IK/O4jpPUJUMkDsIqPEoWQfy0wn+9nquuvWWrt1SRUj5boDZ3IXgT0RjyeMIMnUQL2vF9jVUEvuSwV8z6CXRM0Blnn9fzwvVbKfDe4LLYJvBk9L5I0r1YVk6eKDG+Ci7C/T/vWpi/VczVxeo72c+udQBcX0Nrf9KQCWw15sN0T+b48lxhvJvmrqJsELgkHI9TEIVN6dZVCd5yPepNOY+0146X/fGmLekbd3yvpm/lDxkT0jmljujjJBaBFudKFc2qnU9dBJj5zIBuL0EJ1cjmZpo0EO28E1/2xiFrAeSUu8q7Bz2g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5120.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(52536014)(83380400001)(76116006)(8676002)(8936002)(64756008)(66476007)(33656002)(86362001)(316002)(7696005)(4326008)(110136005)(6506007)(53546011)(66556008)(66446008)(26005)(186003)(9686003)(55016002)(71200400001)(478600001)(66946007)(15650500001)(5660300002)(2906002)(38100700001)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?TjJnTnFlUUNybWdmZzZ5NXA3S2kvQlRMQ2ZUZGMrTnQ1S0RZcFFWUDJNVmN5?=
 =?utf-8?B?L1hraWZ1OW95OVF4cDdVNXFVQ2t4a3JYMjdmOXEyVWpTZWM4OWN2d2plckNq?=
 =?utf-8?B?VDBEMHEyeUdYdXR1cHRIeFVISGJwZlBhVHJDdkNoWFRBOVRmVW5kRUYzcERu?=
 =?utf-8?B?djdKaWt0QXVTQ0RqL2dScHBkd0NXWmpmaEF0QlRrOGlPQjE1SkR4M1lvSzRV?=
 =?utf-8?B?RkRBMVVqbXdad202S25tbXl2RFA4UmxKRWZDeXA2bXBRREZKZ3F1Z0lrSlpS?=
 =?utf-8?B?amZhaTBEcTlCT0NtQkx4OHA5MXl6anNrL1h1Ny9ySWs4MHBrM2JlV0Eyd2t2?=
 =?utf-8?B?dWNiSzkvWkFLMG40Qm9hV3RJYjBZQkdjWW1TWGZseHhSbnRpK0oveUNDcHdj?=
 =?utf-8?B?bXg2bVlkYzIvN3pVYXljTEFXaHE3REhrQ0lnQlJQZDdzMUJkYjFKRm9PdGxo?=
 =?utf-8?B?eVdpcWlhb1A4ZWtWWHF4emVOeU5nb3RFaXFTUkVpWUJQckw0cUFNVkNZYVds?=
 =?utf-8?B?dTcrbTF2WkpDaHBCQU8rZ2RFZUVSS3dNc0s2N3RtY1B6ZWdLMkYva0ZOWWJo?=
 =?utf-8?B?ZmFzTC9HY0JHdUxGSVozaXFTU1NYZWJBTXB1em9QRXcxRXRrQnpUTENMT0FF?=
 =?utf-8?B?M1Z3bk84UGJpdHVoR3lqVW9qbHg4WG9BTmR6MmpWQzZEdVlkSzI5RlFkaUs0?=
 =?utf-8?B?dVFWbFBteHVudllneXVmVUF4NU9nSHg5VnNDZm1ZUTlLRExjV0dVZ09Ya21X?=
 =?utf-8?B?dXZpSGhLaWVrQ1ZSd1VIQ1RNTXNJd0Q3dUplZ3AzeFA0bVBqdzJnb3IrRzF4?=
 =?utf-8?B?Q0RQSjlkNy9HNFYwMjd5L050cUV2WkM0UzZFUmo4SzBiWFZnU1pkWk9nZUVm?=
 =?utf-8?B?ZkM3aHRoMEhYN2s4UHpTaGxYbCtsbG5oVFVmS0d6NG5XNU9RNHF1SlVqRVRR?=
 =?utf-8?B?cUs2azhEaE1jT0dZVS80ZFREQkZyemR6TlZzVHFQeWNhQW4rNXdoYXdlMXFQ?=
 =?utf-8?B?aGdFS0JsV2NLckp1cnRudmFZa2h6MjlJdThqQTlFQW40VnBVK1l4dDlMbXpD?=
 =?utf-8?B?UzBLTk9vdGZWY05HWkF5aXYwNG03ZjVvSk5rdGExY0VuL24ySG9kVi9HMFll?=
 =?utf-8?B?T01JdW01eVNYd002Zm9SN2lSbXlTY3V0YjRQb2FrT0FlN0pHRjgrSjlLRmgx?=
 =?utf-8?B?ZkpvL1luUlpFazZCUXdlSW1aaUpOZHZLTFJsMjlKRkpJM2xOTzV1WUZVNkxO?=
 =?utf-8?B?b0trcTdpOERaNUI4Y1RldWtpZG01RFFONlhhdHl3SFY0MzhmbW5iSjAyUC8r?=
 =?utf-8?B?R3NudkkyTE1pRXhOZjluNFlvd2xlTngyMlBwZTFpL2tSOXl3MGpJVFpoTVhQ?=
 =?utf-8?B?dEFKSFdZR0FJNHE5b2RXTWkyTk9NTmVxcGdZTkRpU2lNcmQ1cXpiV1FWM1pW?=
 =?utf-8?B?eUFGVk45NXJrTUtON2krcHhxU3I5Qy92S29yNDFucWZuRlpWcFJFRW9qek1M?=
 =?utf-8?B?TTdpSTl5a2hOTWo1em1KZzRSUkNKOERRWFJVS2lzNlB0YVJuekNCai9CYkJ3?=
 =?utf-8?B?eEcxalc2OVlsWHp2RHZQUXFEQVRwL3pmdU5yTWtUSFBHY1FtQ3FYLy85cXJP?=
 =?utf-8?B?M1BkTG1uQWtXTkRTdHdETDArSjB1dWhMZlB1QW5Ga0JnbWsxNmw2cjc0eUFX?=
 =?utf-8?B?amx2TzgydmN1bTd3dERFNkhvdllxUnhzeHV4V2FHRVNEZGF1UzcyUEl0UnRS?=
 =?utf-8?Q?kZykNTWcaezupX+bt46UrfhWCzWesCIeJX29z8W?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5120.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc83db60-f498-4112-a3c2-08d8faa6bd49
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 15:55:31.9094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8NXlwwo57gBfE0bAncn6PxLC9gQcPEh5aEI5tQyxvdDZYlDF7tRPk9HmZ9tnmTPuBRRG1ET/mkB2gz5PFrYlEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5056
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
Cc: "Aberback, Joshua" <Joshua.Aberback@amd.com>
Content-Type: multipart/mixed; boundary="===============0222855032=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0222855032==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM4PR12MB5120EC535F3450809DF84D60F5749DM4PR12MB5120namp_"

--_000_DM4PR12MB5120EC535F3450809DF84D60F5749DM4PR12MB5120namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQri
gItIaSBKYXksDQogICBDb3VsZCB5b3UgcGxlYXNlIGFkZCBmZXcgZGV0YWlscyBvbiB0aGUgcm9v
dCBjYXVzZSwgaW4gdGhlIFtXaHkvSG93XSBzZWN0aW9uPw0KDQpUaGFua3MsDQpCaW5kdQ0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IEF1cmFiaW5kbyBQaWxsYWkgPGF1
cmFiaW5kby5waWxsYWlAYW1kLmNvbT4NClNlbnQ6IFRodXJzZGF5LCBBcHJpbCA4LCAyMDIxIDEx
OjQ4IEFNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcgPGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPg0KQ2M6IFBpbGxhaSwgQXVyYWJpbmRvIDxBdXJhYmluZG8uUGlsbGFp
QGFtZC5jb20+OyBSLCBCaW5kdSA8QmluZHUuUkBhbWQuY29tPjsgQWJlcmJhY2ssIEpvc2h1YSA8
Sm9zaHVhLkFiZXJiYWNrQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvZGlzcGxh
eTogVXBkYXRlIERDTjMwMiBTUiBFeGl0IExhdGVuY3kNCg0KRnJvbTogSm9zaHVhIEFiZXJiYWNr
IDxqb3NodWEuYWJlcmJhY2tAYW1kLmNvbT4NCg0KW1doeV0NClVwZGF0ZSBTUiBFeGl0IExhdGVu
Y3kgdG8gZml4IHNjcmVlbiBmbGlja2VyaW5nIGNhdXNlZCBkdWUgdG8gT1RHDQp1bmRlcmZsb3cN
Cg0KU2lnbmVkLW9mZi1ieTogSm9zaHVhIEFiZXJiYWNrIDxqb3NodWEuYWJlcmJhY2tAYW1kLmNv
bT4NCkFja2VkLWJ5OiBBdXJhYmluZG8gUGlsbGFpIDxhdXJhYmluZG8ucGlsbGFpQGFtZC5jb20+
DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMzAyL2RjbjMwMl9yZXNv
dXJjZS5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjMw
Mi9kY24zMDJfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24z
MDIvZGNuMzAyX3Jlc291cmNlLmMNCmluZGV4IGE5MjhjMWQ5YTU1Ny4uZmMyZGVhMjQzZDFiIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjMwMi9kY24zMDJf
cmVzb3VyY2UuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjMwMi9k
Y24zMDJfcmVzb3VyY2UuYw0KQEAgLTE2NCw3ICsxNjQsNyBAQCBzdHJ1Y3QgX3Zjc19kcGlfc29j
X2JvdW5kaW5nX2JveF9zdCBkY24zXzAyX3NvYyA9IHsNCg0KICAgICAgICAgICAgICAgICAubWlu
X2RjZmNsayA9IDUwMC4wLCAvKiBUT0RPOiBzZXQgdGhpcyB0byBhY3R1YWwgbWluIERDRkNMSyAq
Lw0KICAgICAgICAgICAgICAgICAubnVtX3N0YXRlcyA9IDEsDQotICAgICAgICAgICAgICAgLnNy
X2V4aXRfdGltZV91cyA9IDEyLA0KKyAgICAgICAgICAgICAgIC5zcl9leGl0X3RpbWVfdXMgPSAx
NS41LA0KICAgICAgICAgICAgICAgICAuc3JfZW50ZXJfcGx1c19leGl0X3RpbWVfdXMgPSAyMCwN
CiAgICAgICAgICAgICAgICAgLnVyZ2VudF9sYXRlbmN5X3VzID0gNC4wLA0KICAgICAgICAgICAg
ICAgICAudXJnZW50X2xhdGVuY3lfcGl4ZWxfZGF0YV9vbmx5X3VzID0gNC4wLA0KLS0NCjIuMzEu
MQ0KDQo=

--_000_DM4PR12MB5120EC535F3450809DF84D60F5749DM4PR12MB5120namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxwIHN0eWxlPSJmb250LWZhbWlseTpBcmlh
bDtmb250LXNpemU6MTFwdDtjb2xvcjojMDA3OEQ3O21hcmdpbjo1cHQ7IiBhbGlnbj0iTGVmdCI+
DQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldPGJy
Pg0KPC9wPg0KPGJyPg0KPGRpdj4NCjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTFwdDsi
PuKAi0hpIEpheSw8L3NwYW4+PC9kaXY+DQo8ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDEx
cHQ7Ij4mbmJzcDsmbmJzcDsgQ291bGQgeW91IHBsZWFzZSBhZGQgZmV3IGRldGFpbHMgb24gdGhl
IHJvb3QgY2F1c2UsIGluIHRoZSBbV2h5L0hvd10gc2VjdGlvbj88L3NwYW4+PC9kaXY+DQo8ZGl2
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDExcHQ7Ij48YnI+DQo8L3NwYW4+PC9kaXY+DQo8ZGl2
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDExcHQ7Ij5UaGFua3MsPC9zcGFuPjwvZGl2Pg0KPGRp
dj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMXB0OyI+QmluZHUgPGJyPg0KPC9zcGFuPjwvZGl2
Pg0KPGRpdiBpZD0iYXBwZW5kb25zZW5kIj48L2Rpdj4NCjxociBzdHlsZT0iZGlzcGxheTppbmxp
bmUtYmxvY2s7d2lkdGg6OTglIiB0YWJpbmRleD0iLTEiPg0KPGRpdiBpZD0iZGl2UnBseUZ3ZE1z
ZyIgZGlyPSJsdHIiPjxmb250IGZhY2U9IkNhbGlicmksIHNhbnMtc2VyaWYiIHN0eWxlPSJmb250
LXNpemU6MTFwdCIgY29sb3I9IiMwMDAwMDAiPjxiPkZyb206PC9iPiBBdXJhYmluZG8gUGlsbGFp
ICZsdDthdXJhYmluZG8ucGlsbGFpQGFtZC5jb20mZ3Q7PGJyPg0KPGI+U2VudDo8L2I+IFRodXJz
ZGF5LCBBcHJpbCA4LCAyMDIxIDExOjQ4IEFNPGJyPg0KPGI+VG86PC9iPiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZyAmbHQ7YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcmZ3Q7PGJy
Pg0KPGI+Q2M6PC9iPiBQaWxsYWksIEF1cmFiaW5kbyAmbHQ7QXVyYWJpbmRvLlBpbGxhaUBhbWQu
Y29tJmd0OzsgUiwgQmluZHUgJmx0O0JpbmR1LlJAYW1kLmNvbSZndDs7IEFiZXJiYWNrLCBKb3No
dWEgJmx0O0pvc2h1YS5BYmVyYmFja0BhbWQuY29tJmd0Ozxicj4NCjxiPlN1YmplY3Q6PC9iPiBb
UEFUQ0hdIGRybS9hbWQvZGlzcGxheTogVXBkYXRlIERDTjMwMiBTUiBFeGl0IExhdGVuY3k8L2Zv
bnQ+DQo8ZGl2PiZuYnNwOzwvZGl2Pg0KPC9kaXY+DQo8ZGl2IGNsYXNzPSJCb2R5RnJhZ21lbnQi
Pjxmb250IHNpemU9IjIiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTFwdDsiPg0KPGRpdiBjbGFz
cz0iUGxhaW5UZXh0Ij5Gcm9tOiBKb3NodWEgQWJlcmJhY2sgJmx0O2pvc2h1YS5hYmVyYmFja0Bh
bWQuY29tJmd0Ozxicj4NCjxicj4NCltXaHldPGJyPg0KVXBkYXRlIFNSIEV4aXQgTGF0ZW5jeSB0
byBmaXggc2NyZWVuIGZsaWNrZXJpbmcgY2F1c2VkIGR1ZSB0byBPVEc8YnI+DQp1bmRlcmZsb3c8
YnI+DQo8YnI+DQpTaWduZWQtb2ZmLWJ5OiBKb3NodWEgQWJlcmJhY2sgJmx0O2pvc2h1YS5hYmVy
YmFja0BhbWQuY29tJmd0Ozxicj4NCkFja2VkLWJ5OiBBdXJhYmluZG8gUGlsbGFpICZsdDthdXJh
YmluZG8ucGlsbGFpQGFtZC5jb20mZ3Q7PGJyPg0KLS0tPGJyPg0KJm5ic3A7ZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjMwMi9kY24zMDJfcmVzb3VyY2UuYyB8IDIgKy08YnI+DQom
bmJzcDsxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSk8YnI+DQo8
YnI+DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjMwMi9k
Y24zMDJfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24zMDIv
ZGNuMzAyX3Jlc291cmNlLmM8YnI+DQppbmRleCBhOTI4YzFkOWE1NTcuLmZjMmRlYTI0M2QxYiAx
MDA2NDQ8YnI+DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMzAyL2Rj
bjMwMl9yZXNvdXJjZS5jPGJyPg0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjbjMwMi9kY24zMDJfcmVzb3VyY2UuYzxicj4NCkBAIC0xNjQsNyArMTY0LDcgQEAgc3RydWN0
IF92Y3NfZHBpX3NvY19ib3VuZGluZ19ib3hfc3QgZGNuM18wMl9zb2MgPSB7PGJyPg0KJm5ic3A7
PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC5taW5fZGNmY2xr
ID0gNTAwLjAsIC8qIFRPRE86IHNldCB0aGlzIHRvIGFjdHVhbCBtaW4gRENGQ0xLICovPGJyPg0K
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC5udW1fc3RhdGVzID0gMSw8
YnI+DQotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC5zcl9leGl0X3RpbWVfdXMgPSAxMiw8
YnI+DQorJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC5zcl9leGl0X3RpbWVfdXMgPSAxNS41
LDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAuc3JfZW50ZXJf
cGx1c19leGl0X3RpbWVfdXMgPSAyMCw8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgLnVyZ2VudF9sYXRlbmN5X3VzID0gNC4wLDxicj4NCiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAudXJnZW50X2xhdGVuY3lfcGl4ZWxfZGF0YV9vbmx5
X3VzID0gNC4wLDxicj4NCi0tIDxicj4NCjIuMzEuMTxicj4NCjxicj4NCjwvZGl2Pg0KPC9zcGFu
PjwvZm9udD48L2Rpdj4NCjwvZGl2Pg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_DM4PR12MB5120EC535F3450809DF84D60F5749DM4PR12MB5120namp_--

--===============0222855032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0222855032==--
