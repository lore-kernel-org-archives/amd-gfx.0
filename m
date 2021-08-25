Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8302DC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 04:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1906113B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 04:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C1906113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADB366E113;
	Wed, 25 Aug 2021 04:13:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B27246E113
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 04:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1MlK1P+++aPaaFjex5LjGEyqlwhMLDiixUg4cmCfRud8Hq/5LBliYDV9l7bp9WqmPQK9XQru7EFRv0juV4Bwqnb1BeZDuGsCtMQCr8PRFKzj0fra6Qb4r579ySmcTVcf2WaG7/LmU8iA5KiBOMi/kIcFlrvOfbUmHDpfbTS5hYZAcxkNyAv+j57yOhZcF3SDIKLWMY023iRV54OSea6xyuFBFoXc/zb06XQdvCo+EegbtWjepbitcam4O1FpHo7NTtkMgHU4BeW9pHUFhji3EEwWfp/HrXIat0ieAtHroEku0oahqoDl/fZou7xVlN2L/dIbpmpclLxVLbjel6Elw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rOha3WJ6cP37zn74R8Tqt8B4oemF7Z2ewEsQujZ3bc=;
 b=mSzxIJAX/IPQZJ5EpqxasAr4/vouuazE3Rxqf5LzfwK0kCRllX1RNlhlWv+gb/pn7Rt0bVzsMY/FILyxykwVskBuHBrxnBqtZqKsiCxZ5uHTAbP0FCMyGB6E/TVYf7O3+8daGWfTHVECHFktgBfzWQ5cYV0+WtTNNc6I7SSt2tn+TErIX0uJnTGVHCr092BnymPKJPizMLDzPGz6uZMzhso1BuKdwPO86wfAhNVVdTRm1lzyl7pi8ORjNL8fV4OujDeVBe/z2RZVSb47J3+my5D5aRKaOs4Rf5fHgH/Rv1jVYsOI3rKGgrfZ4CAhnFW2EGGrLqd7tHc3honxkcrIhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rOha3WJ6cP37zn74R8Tqt8B4oemF7Z2ewEsQujZ3bc=;
 b=SoPQMUTVtH7jk8DUgDzUtrhjE1w8YEWgxtkl8i7/3zpQsvyK6EpsYSLNiQ1J2KSd0QEep3nEOZXYOQW66gxQUFNCEJFIH65PILucM5+pNhr4IXIUCVMJiSFVbH5x8wvs1LievcZrCkALsV9BWz9m32BOL2TYSs5vG28AvRa5SAo=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Wed, 25 Aug
 2021 04:13:56 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::acc6:c407:1353:6a]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::acc6:c407:1353:6a%5]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 04:13:56 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/sched: fix the bug of time out calculation
Thread-Topic: [PATCH] drm/sched: fix the bug of time out calculation
Thread-Index: AQHXmM2hoKzSUXfclkqTVcF2Xz2h6auCvB6AgAAELgCAANPpQA==
Date: Wed, 25 Aug 2021 04:13:56 +0000
Message-ID: <BL1PR12MB5269F7DCCFA0619BA286C00E84C69@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <1629798692-21361-1-git-send-email-Monk.Liu@amd.com>
 <c83ad5a4-0adc-3940-ff86-b9e194235604@amd.com>
 <ad3529fd-0a9c-e095-6cce-8063072f43be@amd.com>
In-Reply-To: <ad3529fd-0a9c-e095-6cce-8063072f43be@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-25T04:13:54Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c21a31e2-9798-4fc0-88fb-5edb2b98b716;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 880a5ca9-d1f5-4f12-3ca6-08d9677ec1aa
x-ms-traffictypediagnostic: BL1PR12MB5223:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB522341B60DEF5D5911B5B54684C69@BL1PR12MB5223.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eHsXfK0dUXdCGduRyRsFvys4NGYZFxNjs7W13EsZXdzVIpRQeIgOkuWV34FHwCcmCeGhRH803N1ku6Cw2dI0Mnn/Gl5oLsnZrU2K5I8NEOFL+C15RWNCYHCGAGcFF4xQr/Bovte9hTHhVZl9muS2djdXIEoumbee8NdCIbkhqFDmq42g8AjiX40zcOj4aJGyDsRIz990X54sfVjVip72kg5Hy2c/dCEwN+In2VJzftGAqV97OrpPC3Zst3DLLbZJZyAMKwjz9w+aP4Wc5RZ10GSCEyLAvDtgX84YoFVYXYygM2PChI7CKHZqwl1yZzS6S0L/0CMSP/HLDmTRwDlGTVI9rUbhZsSK95DqvFaRvUrjJll3cvn8rFJnIqvHwmwhG1ynxFYeakg4//g0HSyQhLUtPYKB/87Rn4TqVoGRfxLlP9Z7+IzwxBWnBM1hE3+SUrd0l839p7i/TkYMGjEtG4/eFgc+snwNeYgOKXt+GG8N0pm4U+3SbevIT/B1ndiT/mSKf9/ltenEtoAl7u8iU+nXs8bcpadEm6iCwkdvDjP5v6S464XcuOSvyIcmDoZiBC0Z/VGJYMRyYz95bKj8CrrxuWL5zBjiQta76SBAzfYuUurKM1pAJQqWb0b65DKrhBdwwBLsclRUXRdM6P4mhXeZ51yFkHMgBz2Zmw2PdvIk0LYD1QwqD3syZlenL0GSFBzK7DVnJItPOn3s/N2AEA4cQ3BIjcjK6SNoE2lsqndA7+uGM+XHsFMi7Xu8doQY28vHjpcwxwdbCbuVTfp+ITu8alyPapSCCHJCHBVChDp5UOg+ru75KJiNo5d6uO63CQ2G2qDjhaA06LiFyKAy0g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(83380400001)(55016002)(122000001)(66946007)(26005)(38100700002)(53546011)(64756008)(9686003)(76116006)(86362001)(2906002)(186003)(66446008)(71200400001)(316002)(66556008)(8676002)(66476007)(966005)(8936002)(38070700005)(508600001)(52536014)(7696005)(110136005)(5660300002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDgrRTIxQ2ZWamY3S3RNaFZlSWZMQThrdzZHU0w1QWhEUHM0N3pmUXhOOHpK?=
 =?utf-8?B?azgyYTVvR051WFRKM3BHME9yK0pObThxRmtlMFU4cWJQTG9XMjBDcWJLYXll?=
 =?utf-8?B?N3lwRCt0NUtKY3VVdENHUFFhTjJuN2xyL2Y3Y0ZsRXNjNFdrWDQxRUtYTlRM?=
 =?utf-8?B?Z016ckJSK2p0bXNNSzFXK3dObXkydDZQeTA0alI2MnZUSERxdzZPZWFtWnU1?=
 =?utf-8?B?czEvOXRtLysxTURuOXh0N2x6bnRKLzdWRG9sOTJXbVVJcDg0cTAzTWc0ZTBC?=
 =?utf-8?B?UHIxRmZTaUNZTE53TnI0MHJFRzJxemhONTZFdTFqQmpWMGNjQXIzM1pFRmN5?=
 =?utf-8?B?OFZGOHdJd3FhaFpQRDRsVHMwcXdSS05lWkE0b2M0aWF5SUVmUnQ4bTNjaHRP?=
 =?utf-8?B?QWpKQjRoczZWNTZiUVI3ejIzSmR4OUx0eldsQldHVzY1R0ozaGFNODhiN0lN?=
 =?utf-8?B?R2hkNU1NdmJVelYyS2hBT1FEa2VlTStOcGQ1OHlPZEVHNWdxQ1U4TTNvWmVa?=
 =?utf-8?B?VTI4ZWJxN0szV0l3eWpHZFJML3BEejEyR0JXSitBTDF1cnpaeFFLdFRPcXg2?=
 =?utf-8?B?KzdHRzB2ZklMUHNMbWVHM2VERGRjRHhiY29mZ0pZOEpTRC8wbEpVdjRmRm1z?=
 =?utf-8?B?UC8xQ01za2dTRDVNLzFORnNPRGpERk5EbEg2cHBsa2VGTnBWYzBGSWhBVjVJ?=
 =?utf-8?B?WWx2RUlxWjFtUFZ3eEVpV2xldkVJd3oxYnNRR3R0b0lvVjFMMlo1VnlxMW4r?=
 =?utf-8?B?RE1Wa2Y5dGR6dlpXeEI1cUY2enRKdnd3YWRqbk5uNHRIZ044SWIzZmUwRXNw?=
 =?utf-8?B?RXVURFZrUDhvc3B4TDltNFVuQWlvb1BmNUJYdWtpakRlajU3VE5vY2Fja2da?=
 =?utf-8?B?TENiazkyQkIzeERIZjlCRUJON1RoeVpOeXJLYitNZ1U3VGh6OERzZS9MQTls?=
 =?utf-8?B?dVFyVm03Q3hUUkpuL3VIU0RpZmhUSHJUeTV1V1lqcjNGRXdsSkNPM1h5QW5Q?=
 =?utf-8?B?amh3d1p6dXRGT3g1S1greHdKYmJ1bmFab1VSRDhkS1V0WEFZSUVmKzl6blpw?=
 =?utf-8?B?Q0F5M0dhVGpBRllmSUQ4K2xsOHdiMldWZ3BhVTQzaDRPdSs3Tnc3cHU1OXdG?=
 =?utf-8?B?SXVXRkxtOHUyTndWYVVPUXdOcTFkQ05zKzVwT2xjNGw2Yy9tZEgrUVBMU2t3?=
 =?utf-8?B?MXdCalFvZk9vOC9uNXBidVRDMnJ0LzBOTVNZek9sZm50cDRQV1FiV1dyeHND?=
 =?utf-8?B?VGxJMFU5WFlrbnBDZm5IVlhlcmt5Mm5sNkZWM2ZEWDgvUHZvU2xJRVM2WFEx?=
 =?utf-8?B?dkY2WWN4OXVlR1lnN2dWNkU1YTlZeHhzOFZLOFU5R1ZJdEhBUW5BZWFzS2xY?=
 =?utf-8?B?aHhyL0lPS3Ftd0NLNnU0bDJjRkRZbExKc2NVb2JNWHY4OEVOdjFMYWNHaGcy?=
 =?utf-8?B?UmZpNkUrczZKbnNOemJpQmRlQmVobVI0azhnbUQ5a1FEWTlGRjloYncwY1k3?=
 =?utf-8?B?VjBMbkJ1VTJiZWtkSTUvenNyU2dRWDVqSEhiRXRyYlI2OFR1Smp3MUh2aU9u?=
 =?utf-8?B?RVhyR09NWlBPeUN3SzViOU9zNXVqY1J6MXZEQ0ZUWE9XZmx0L1l2ajNHK3hC?=
 =?utf-8?B?MDVwQmFOc3dUd3hHdGNKNlVwUFc3c2MvOGxzVVRsVkZSTWtEZFRSdGVqUkxa?=
 =?utf-8?B?RElHMGFVNFkrZWg2VU5Zblg0V3Jqd3hUYVNucTVkRzMrY1A0ZkdnNzU2RWYx?=
 =?utf-8?Q?vZD/NzNgTx+iZsjbSDLAxUCvErPpTYN53h3TBvp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880a5ca9-d1f5-4f12-3ca6-08d9677ec1aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 04:13:56.0772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pA/hGVRGVa6nlBXyC7Sm/T5rpRWLC+AXo7dRnrnwbije/hupdPUo9s9DqIFFQkh/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPj4NCjNkIHBvaW50IC0gaWYgbGlzdCBlbXB0eSB5
b3UgbmVlZCB0byBjYW5jZWwgdGhlIHRpbWVyLCBsZXQgdGhlIG5ldyBqb2IgY29taW5nIGFmdGVy
IHRoYXQgcmVzdGFydCBpdC4NCg0KPj4NCjJuZCAtIGlmIHlvdSBoYXZlIHR3byBhZGphY2VudCBq
b2JzIHN0YXJ0ZWQgdmVyeSBjbG9zZWx5IHlvdSBlZmZlY3RpdmVseSBsZXR0aW5nIHRoZSBzZWNv
bmQgam9iIHRvIGJlIHR3aWNlIGxvbmdlciBoYW5nIHdpdGhvdXQgVERSIGJlY2F1c2UgeW91IHJl
c2V0IFREUiB0aW1lciBmb3IgaXQgd2hlbiBpdCdzIGFsbW9zdCBleHBpcmVkLiBJZiB3ZSBjb3Vs
ZCBoYXZlIFRUTCAodGltZSB0byBsaXZlIGNvdW50ZXIpIGZvciBlYWNoIGpvYiBhbmQgdGhlbiBk
byBtb2RfZGVsYXllZF93b3JrIHRvIHRoZSBUVEwgb2YgdGhlIGZvbGxvd2luZyBqb2IgaW5zdGVh
ZCBvZiBqdXN0IGZ1bGwgdGltZXIgcmVzZXQgdGhlbiB0aGlzIHdvdWxkIGJlIG1vcmUgcHJlY2lz
ZS4gQnV0IHRoaXMgaXMgbW9yZSBvZiByZWNvbW1lbmRhdGlvbiBmb3IgaW1wcm92ZW1lbnQuDQoN
Cj4+DQoxc3QgeW91IHNob3VsZCBwcm9iYWJseSByZW1vdmUgdGhpcyBub3cNCmh0dHBzOi8vZWxp
eGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjE0LXJjMS9zb3VyY2UvZHJpdmVycy9ncHUvZHJtL3Nj
aGVkdWxlci9zY2hlZF9tYWluLmMjTDc5Nw0KDQoNCkkgY2hlY2tlZCBhbmQgdGhvdWdodCBhbGwg
YWJvdmUgcG9pbnRzIGZyb20geW91LCBlbmQgdXAgd2l0aCBhIFYyIHBhdGNoLCBwbGVhc2UgdGFr
ZSBhIGxvb2sgYWdhaW4uDQoNClRoYW5rcyANCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQpNb25rIExpdSB8IENsb3VkLUdQVSBDb3JlIHRlYW0NCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogR3JvZHpvdnNreSwgQW5kcmV5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQu
Y29tPiANClNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyNCwgMjAyMSAxMTowMiBQTQ0KVG86IExpdSwg
TW9uayA8TW9uay5MaXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vc2NoZWQ6IGZpeCB0aGUgYnVnIG9mIHRpbWUgb3V0IGNh
bGN1bGF0aW9uDQoNCg0KT24gMjAyMS0wOC0yNCAxMDo0NiBhLm0uLCBBbmRyZXkgR3JvZHpvdnNr
eSB3cm90ZToNCj4NCj4gT24gMjAyMS0wOC0yNCA1OjUxIGEubS4sIE1vbmsgTGl1IHdyb3RlOg0K
Pj4gdGhlIG9yaWdpbmFsIGxvZ2ljIGlzIHdyb25nIHRoYXQgdGhlIHRpbWVvdXQgd2lsbCBub3Qg
YmUgcmV0cmlnZ2VyZCANCj4+IGFmdGVyIHRoZSBwcmV2aW91cyBqb2Igc2lnYW5sZWQsIGFuZCB0
aGF0IGxlYWQgdG8gdGhlIHNjZW5hcmlvIHRoYXQgDQo+PiBhbGwgam9icyBpbiB0aGUgc2FtZSBz
Y2hlZHVsZXIgc2hhcmVzIHRoZSBzYW1lIHRpbWVvdXQgdGltZXIgZnJvbSB0aGUgDQo+PiB2ZXJ5
IGJlZ2luaW5nIGpvYiBpbiB0aGlzIHNjaGVkdWxlciB3aGljaCBpcyB3cm9uZy4NCj4+DQo+PiB3
ZSBzaG91bGQgbW9kaWZ5IHRoZSB0aW1lciBldmVyeXRpbWUgYSBwcmV2aW91cyBqb2Igc2lnbmFs
ZWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+DQo+
PiAtLS0NCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIHwgMTIg
KysrKysrKysrKysrDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYw0K
Pj4gYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYw0KPj4gaW5kZXggYTJh
OTUzNi4uZmIyNzAyNSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIv
c2NoZWRfbWFpbi5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21h
aW4uYw0KPj4gQEAgLTIzNSw2ICsyMzUsMTMgQEAgc3RhdGljIHZvaWQgZHJtX3NjaGVkX3N0YXJ0
X3RpbWVvdXQoc3RydWN0IA0KPj4gZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkKQ0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIHNjaGVkdWxlX2RlbGF5ZWRfd29yaygmc2NoZWQtPndvcmtfdGRyLCBzY2hl
ZC0+dGltZW91dCk7DQo+PiDCoCB9DQo+PiDCoCArc3RhdGljIHZvaWQgZHJtX3NjaGVkX3Jlc3Rh
cnRfdGltZW91dChzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXINCj4+ICpzY2hlZCkNCj4+ICt7DQo+
PiArwqDCoMKgIGlmIChzY2hlZC0+dGltZW91dCAhPSBNQVhfU0NIRURVTEVfVElNRU9VVCAmJg0K
Pj4gK8KgwqDCoMKgwqDCoMKgICFsaXN0X2VtcHR5KCZzY2hlZC0+cGVuZGluZ19saXN0KSkNCj4+
ICvCoMKgwqDCoMKgwqDCoCBtb2RfZGVsYXllZF93b3JrKHN5c3RlbV93cSwgJnNjaGVkLT53b3Jr
X3RkciwgDQo+PiArc2NoZWQtPnRpbWVvdXQpOw0KDQoNCjNkIHBvaW50IC0gaWYgbGlzdCBlbXB0
eSB5b3UgbmVlZCB0byBjYW5jZWwgdGhlIHRpbWVyLCBsZXQgdGhlIG5ldyBqb2IgY29taW5nIGFm
dGVyIHRoYXQgcmVzdGFydCBpdC4NCg0KQW5kcmV5DQoNCg0KPj4gK30NCj4+ICsNCj4+IMKgIC8q
Kg0KPj4gwqDCoCAqIGRybV9zY2hlZF9mYXVsdCAtIGltbWVkaWF0ZWx5IHN0YXJ0IHRpbWVvdXQg
aGFuZGxlcg0KPj4gwqDCoCAqDQo+PiBAQCAtNjkzLDYgKzcwMCwxMSBAQCBkcm1fc2NoZWRfZ2V0
X2NsZWFudXBfam9iKHN0cnVjdCANCj4+IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCkNCj4+IMKg
wqDCoMKgwqAgaWYgKGpvYiAmJiBkbWFfZmVuY2VfaXNfc2lnbmFsZWQoJmpvYi0+c19mZW5jZS0+
ZmluaXNoZWQpKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLyogcmVtb3ZlIGpvYiBmcm9tIHBl
bmRpbmdfbGlzdCAqLw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGxpc3RfZGVsX2luaXQoJmpvYi0+
bGlzdCk7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqAgLyogb25jZSB0aGUgam9iIGRlbGV0ZWQg
ZnJvbSBwZW5kaW5nIGxpc3Qgd2Ugc2hvdWxkIHJlc3RhcnQNCj4+ICvCoMKgwqDCoMKgwqDCoMKg
ICogdGhlIHRpbWVvdXQgY2FsY3VsYXRpb24gZm9yIHRoZSBuZXh0IGpvYi4NCj4+ICvCoMKgwqDC
oMKgwqDCoMKgICovDQo+PiArwqDCoMKgwqDCoMKgwqAgZHJtX3NjaGVkX3Jlc3RhcnRfdGltZW91
dChzY2hlZCk7DQo+DQo+DQo+IEkgdGhpbmsgdGhpcyBzaG91bGQgd29yaywgYnV0IDIgcG9pbnRz
IC0NCj4NCj4gMXN0IHlvdSBzaG91bGQgcHJvYmFibHkgcmVtb3ZlIHRoaXMgbm93DQo+IGh0dHBz
Oi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjE0LXJjMS9zb3VyY2UvZHJpdmVycy9ncHUv
ZHJtL3NjaGUNCj4gZHVsZXIvc2NoZWRfbWFpbi5jI0w3OTcNCj4NCj4gMm5kIC0gaWYgeW91IGhh
dmUgdHdvIGFkamFjZW50IGpvYnMgc3RhcnRlZCB2ZXJ5IGNsb3NlbHkgeW91IA0KPiBlZmZlY3Rp
dmVseSBsZXR0aW5nIHRoZSBzZWNvbmQgam9iIHRvIGJlIHR3aWNlIGxvbmdlciBoYW5nIHdpdGhv
dXQgVERSIA0KPiBiZWNhdXNlIHlvdSByZXNldCBURFIgdGltZXIgZm9yIGl0IHdoZW4gaXQncyBh
bG1vc3QgZXhwaXJlZC4gSWYgd2UgDQo+IGNvdWxkIGhhdmUgVFRMICh0aW1lIHRvIGxpdmUgY291
bnRlcikgZm9yIGVhY2ggam9iIGFuZCB0aGVuIGRvIA0KPiBtb2RfZGVsYXllZF93b3JrIHRvIHRo
ZSBUVEwgb2YgdGhlIGZvbGxvd2luZyBqb2IgaW5zdGVhZCBvZiBqdXN0IGZ1bGwgDQo+IHRpbWVy
IHJlc2V0IHRoZW4gdGhpcyB3b3VsZCBiZSBtb3JlIHByZWNpc2UuIEJ1dCB0aGlzIGlzIG1vcmUg
b2YgDQo+IHJlY29tbWVuZGF0aW9uIGZvciBpbXByb3ZlbWVudC4NCj4NCj4gQW5kcmV5DQo+DQo+
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLyogbWFrZSB0aGUgc2NoZWR1bGVkIHRpbWVzdGFtcCBt
b3JlIGFjY3VyYXRlICovDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbmV4dCA9IGxpc3RfZmlyc3Rf
ZW50cnlfb3JfbnVsbCgmc2NoZWQtPnBlbmRpbmdfbGlzdCwNCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHR5cGVvZigqbmV4dCksIGxpc3QpOw0K
