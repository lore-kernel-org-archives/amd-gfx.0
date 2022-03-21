Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA48C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 12:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9240D10E2F1;
	Mon, 21 Mar 2022 12:00:26 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C398D10E2B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 12:00:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6VwbPN3AHZG51eBPTN3DkGnYM90/OOOF93rdUvKGoBqv0ggtrFjSJPN9D+cH8duxkGSCh1q78Nd1VBbBYQFqdzAIYrV90MSTnnBaUwMrv1YlmlfgFZzaSsYvJ64748GoGa3SJVBKd+qfX8/tpC6a5Pg0oZg29bS9ZtWTQtvWyf4oN9hzRYWVE2+q1Nfzbx0+TI8h+yzLqihhb7l/saof3ON2Vc7PUbpKKl4eXCDPFC8dYaGnHalj1tdCx4isSTPt8iM5NL8TcMYIZVFYrUl/lb+4i7urGAic2vY52x1V5haUisum5+O7O6KGHMjfAzvnyhZfwEZlgNwyewH2WUeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxDXSUC9MPu1+FhPFwgZevE7vWHqkLGCYxCkwvbLrN8=;
 b=MXcjLA9FoHS1695JgzPLqbrxzn+e+PmbdOJZqb9jW+vlgZlnWI6viATHoRixPkp5fjvJfst1T4LRfwH5WufpAD7a7RivYed/aXD2dGbh7uc9Ep7BB4Cww18qixrAhiNKKBoEaw2RumH9VO9D9etOkC0tlfPNwETAzUDC4beoMVm1/fJ5zx5hEpp1hwBXnENCdOOYUtJxmnbK7sfvxYUFZt9jYlIMcQO4i8KmKJ+Lg3xVP8PpqtmNcJuVNV/wSvpIOu2xuFLcy3nbVw1JJZgJO58xZ8/fESyvdcJ+FFIdphhAzCc7+MZZcVoWsz6ttA1NG8mr7l3oyAC7xRNenOTwrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxDXSUC9MPu1+FhPFwgZevE7vWHqkLGCYxCkwvbLrN8=;
 b=HLj2za+mIBQULvmnlwSVaHVSDh+eYdTcZuxXpdKEhdD20/L74DHHV/BAfRdgj1TqpX7ELgkaxJT9bim9r74PqPHro+hEuat12FOQ7Tu869vMTBeAJ6SGrriWob7PVZjYG0nSte6wvOf563esrcJiejKavWM1csYnmup7e/7fbkM=
Received: from MWHPR12MB1264.namprd12.prod.outlook.com (2603:10b6:300:d::16)
 by CY4PR12MB1253.namprd12.prod.outlook.com (2603:10b6:903:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Mon, 21 Mar
 2022 12:00:16 +0000
Received: from MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::f85d:36da:b28d:507c]) by MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::f85d:36da:b28d:507c%9]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 12:00:15 +0000
From: "S, Shirish" <Shirish.S@amd.com>
To: "S, Shirish" <Shirish.S@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>
Subject: RE: [PATCH] amd/display: set backlight only if required
Thread-Topic: [PATCH] amd/display: set backlight only if required
Thread-Index: AQHYNV1hM78HQPFM5UmEXJTFbMNuXKy6UiCAgAQjrYCACsxRgA==
Date: Mon, 21 Mar 2022 03:47:49 +0000
Message-ID: <MWHPR12MB126408E512075A72E08F21A6F2169@MWHPR12MB1264.namprd12.prod.outlook.com>
References: <20220311153320.101332-1-shirish.s@amd.com>
 <0b094720-8c17-db60-bccf-7cdb4ecf6dee@amd.com>
 <3d397907-4845-3900-1046-47a6a5cd3fb6@amd.com>
In-Reply-To: <3d397907-4845-3900-1046-47a6a5cd3fb6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-21T03:47:09Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ee67a9f2-753c-4627-8f9e-c4d3a0d97459;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-21T03:47:45Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: ffc50c32-97bb-4c8f-a9f2-19eb10c2de32
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd391001-1de4-48c3-260b-08da0b325cb5
x-ms-traffictypediagnostic: CY4PR12MB1253:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1253B121674B3A7D8C21519BF2169@CY4PR12MB1253.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AJZQw1UadIfIjxZVHMQfTdl9KjfK6LOhrK9zuz+nZEW/fACEDLIiyHAMfXCIwCwCVTwwsRF2lb3qN7jdBk7gqcb+EwA5EgLqTAETfrJSKSYukJzWs6OhzI3AOKrNgi1i4qECEcLWwO+f3SCSfy4znEo2Cy4IAbONqrgXxcwmdQkb9HEW6XPkHnvz0NoHqt3TTiZ8yGJxQoAKB82AJvINAEscOmI3kZEp7S9nP8SLhWLuWE4crSagGu1EBLr8NSxAkbuM8Mp77G+LZDwFUvIJxxQfMrp0pO1RSIVrGb/RkrjV3FwSrwQcCUe4ezjh7akuCrTZe+pGp8xGzumu0Egm8mG7Y9yTEy59d8ziwuUGZpdRNVOP1p/OhcVPLYFzy+3rtUVpt8iCOF9Bzi7rtdztgGRty7kegUnQxqix6ASGrWvoH0+fe7T4RaC06H0H/Gfua1R8pKmTxcnlMbGtp7ur+QoSGXPJOoj3jffou2RM2a5GIewrR4n791lBhtV29VqeD/LIbEfACBlsaR173XAotuofc8IeP+klv/aypW3Wc4E6xbDXkoFuYOgEWgxxiUSpu2/ChU6C7n03V5vFVA5PPNoK+rsuDnCr2loAksfydaaNh30TtkElIm9QhxG5NJ/vFqcXshaQNEQ2Os/anB5bbk/YC8nB2KVlVPjKOxB0k5R/PbFGZWBEDlcgEhuzSvD9fzxV/hhFQUAbKo15HrugNQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1264.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(4326008)(2906002)(52536014)(8936002)(66446008)(66476007)(66946007)(8676002)(76116006)(66556008)(64756008)(186003)(26005)(55016003)(508600001)(6506007)(6666004)(9686003)(7696005)(53546011)(71200400001)(6636002)(33656002)(38070700005)(122000001)(86362001)(921005)(5660300002)(110136005)(38100700002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vm1pRCtFQjZVUzBZMC9DU1Y1ejhkRm5XMnFHU0RpdzR1MjhpWlNyVUNUaXAr?=
 =?utf-8?B?NVp0clFJZllaWkQzUllteWdzVDBFYUZ4VVIzRjhsQ0hJb0pnbDIwdkpFdExR?=
 =?utf-8?B?YmVnVDJrQ3RKMUU3MUx2OVIxcEovR3k3SWJ0OFZobldjYkRGSXlhWEVMUkFF?=
 =?utf-8?B?UjNNVTV4U2cvNmlpbkEwOWdmbkNxY3NyV3ZPRG5kZEJpNXRoRis1R3ljLzdv?=
 =?utf-8?B?YjhrK3JIRVVHNnpnSXRFaXczdlV5S3V3cU41aUxjMnBKb1FGSE1GVmQ4eHdl?=
 =?utf-8?B?NG5kMTRQUllFQS9nZHk5MlZDVmUxY2NaNHhqQWlBeXg3am5tbHlhNVRPMExh?=
 =?utf-8?B?NTNJZWpsejNiU2Mwb0hDQ21EV2Z3d1pRaXNOR01ha1prSFZJaXJ6UHdSdWJh?=
 =?utf-8?B?MnJlWmhnSy9pZ3dKOUp1WjNEZTJrWk1nbDVTSEMzZys0d2hkVkprdHFTSWxt?=
 =?utf-8?B?SG1rdEVoWFNndlBiTzVYMTZRVlc4NEtBQ1RNYzB1cGZYUi8vdU9Ib3pEYXZG?=
 =?utf-8?B?QWdpSFJmV3BycUlnT01lM3pDNExlb2hOaHdBVnVxengyb3RkQTI5WFRnUUx0?=
 =?utf-8?B?Y3p0TkFnR2dtZXR4WXJqNEtWRG5abW9wV3BicVBiVGQ0QmkybzhTc1RUdHNY?=
 =?utf-8?B?cGtzUmhuWGgyNlBzOFZsemFoRFlJTGhQOGEvcnhOQmVhZDVvdTViVnNEMFhE?=
 =?utf-8?B?Mjdvd2MvWUdGVmh1YzRud0NSYmVSaVkxSWNSaGRBdXc1dER2aVd0NHlIWUxa?=
 =?utf-8?B?R3pxNVdGR1htNlpFMkw1YzlwemZFVmh4Z1RLN2V1MTFuU1g3VThkS1QzLzIx?=
 =?utf-8?B?YUFJbzZWN2dzSWZQODhkS2k0czhvTnJUVmhJb0RJYTIybFRFcE1PdFBIbURo?=
 =?utf-8?B?QVlIS1VPdHNKR3lXR09YYlRqeUpjdEc5T1k5Q0w1bnlxQXVrcjh0WVJsMTBu?=
 =?utf-8?B?WFd5OXJLdjU3R2wxTTU4K092YzNtMEMzMCtFWlJzQnRaSXNEd0hLMFM1ejRC?=
 =?utf-8?B?QzVkQ08wZmhSRmlCUjZDMW4wRkxBeG01Um9xOTBFanpzSEpXUExmOVJTN1ZN?=
 =?utf-8?B?U3MzZUdoVjdUTDhaZFQ5Z3NUNkh5cm4yaVFuTU5oYis1RTVIQmpIcGVMMEVK?=
 =?utf-8?B?TFVsbVd0eGo2M1JMb2VkZzVnVWkyLzlvaVhFZDhNM2FaWG5sVlN6RU83V1Fh?=
 =?utf-8?B?OFhnQk85YnFYUUMzeXBldnh0ZzU2QzlZMzV1OWV4cDBwZlc5QTErVzk3WGNX?=
 =?utf-8?B?cmgzTEZJZUFmZlFyMUxJVjIwVUp5RG1GSmpUUVR6N2Z5NHB6dkx5VjByQkly?=
 =?utf-8?B?MWVzcjdMYURCM3M4dmtBM2o2MWV3WnV6K2NXcmpNeXF1R3dlRHFjckNnNjI0?=
 =?utf-8?B?WlBzTklBK1lKVnpMSEsrVHFCM29NYitEU1pKNGlKaVlQdFRZV240azlFbEhZ?=
 =?utf-8?B?TytmNWEwZllvZzNSdEZVMDVFelNyRlFNNmdabm13ZGhYYWxRZ1dXN0h6OVR1?=
 =?utf-8?B?VlBiZHgrUHdqNk9NQ3hBcVFJUHNueDJ3OXhzejgrUnVSUXZabDFWdTR3WDVD?=
 =?utf-8?B?T0diYzRsbEdkZEt1cjEvaDhRWmFGcGhGMEMrMjhtSlJtVmlBWUk1MlFjYUFB?=
 =?utf-8?B?UGFkS1hEYmFyOC9VOVpzY1ZBWXdGTXJQMG12TUdKendUWkhPS2cvZVhheVo3?=
 =?utf-8?B?WGI3SnFZek5hcnFlSExjKzJVdElJS3BPRm1OQW9FZU1HUSs3citHdW1DaWFJ?=
 =?utf-8?B?Zk5NTHpRSVoyS2Y0ZkFMR0tJUGdKYWc3V2puL0d1a28rOFg0ZlRtL2ZneGVL?=
 =?utf-8?B?WFVLVUhESVROMkVJUUZHS2wzYXE3UlVMV3h2NFR3a3ZtS3hFVmpST2tjeUlh?=
 =?utf-8?B?emxFZlBnbG5OSGRZa01qOUFXdy8vcm1mUkFweUtxVWUwamhqQ2hXZHdGajVu?=
 =?utf-8?Q?LXcPGackhrg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1264.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd391001-1de4-48c3-260b-08da0b325cb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 12:00:15.4867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ydJklNltyrpPu0VhXMIGlaeki59Xg9aEbEFJW6/1kyI5BUD+LnvXSqYZhW5kwLFGt7gmD1nbIYzMQSjGb8LeXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1253
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KUGluZyENCg0KDQoNCg0KUmVnYXJkcywNClNoaXJp
c2ggUw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUywgU2hpcmlzaCA8c3No
YW5rYXJAYW1kLmNvbT4gDQpTZW50OiBNb25kYXksIE1hcmNoIDE0LCAyMDIyIDEyOjI0IFBNDQpU
bzogV2VudGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPjsgUywgU2hpcmlzaCA8
U2hpcmlzaC5TQGFtZC5jb20+OyBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5j
b20+OyBLYXpsYXVza2FzLCBOaWNob2xhcyA8TmljaG9sYXMuS2F6bGF1c2thc0BhbWQuY29tPjsg
TGFraGEsIEJoYXdhbnByZWV0IDxCaGF3YW5wcmVldC5MYWtoYUBhbWQuY29tPg0KQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBhbWQvZGlzcGxh
eTogc2V0IGJhY2tsaWdodCBvbmx5IGlmIHJlcXVpcmVkDQoNCg0KT24gMy8xMS8yMDIyIDk6MTEg
UE0sIEhhcnJ5IFdlbnRsYW5kIHdyb3RlOg0KPg0KPiBPbiAzLzExLzIyIDEwOjMzLCBTaGlyaXNo
IFMgd3JvdGU6DQo+PiBbV2h5XQ0KPj4gY29tcGFyaW5nIHB3bSBibCB2YWx1ZXMgKGNvdmVydGVk
KSB3aXRoIHVzZXIgYnJpZ2h0bmVzcyhjb252ZXJ0ZWQpIA0KPj4gbGV2ZWxzIGluIGNvbW1pdF90
YWlsIGxlYWRzIHRvIGNvbnRpbnVvdXMgc2V0dGluZyBvZiBiYWNrbGlnaHQgdmlhIA0KPj4gZG11
YiBhcyB0aGV5IGRvbid0IHRvIG1hdGNoLg0KPiBXaHkgZG8gdGhlIHZhbHVlcyBub3QgbWF0Y2g/
DQoNCkhlcmUgaXMgYSBzYW1wbGUgb2YgdmFsdWVzOg0KDQpkbXViX2FibV9nZXRfY3VycmVudF9i
YWNrbGlnaHQoKSByZWFkcyBiYWNrbGlnaHQgdmFsdWUgYXMgMTE1MjYgPT4NCmNvbnZlcnRfdG9f
dXNlcigpIGFzIDQ1Lg0KDQp1c2VyX2JyaWdodG5lc3MgdmFsdWUgdG8gYmUgc2V0IGF0IHRoaXMg
cG9pbnQgaXMgMTU5ID0+DQpjb252ZXJ0X2Zyb21fdXNlcigpIGdpdmVzIDQwODYzLg0KDQpOb3cs
IHdlIGFyZSBjb250aW51b3VzbHkgY29tcGFyaW5nIDQ1IChjdXJyZW50IGJhY2tsaWdodCkgd2l0
aCAxNTkgKHRvIGJlIHNldCBmcm9tIHVzZXIgc3BhY2UpIGluIGV2ZXJ5IGNvbW1pdCB0YWlsIHRp
bGwgYW55IGFjdHVhbCBjaGFuZ2VzIGhhcHBlbiB0byBicmlnaHRuZXNzLg0KDQpJZGVhbGx5LCBj
dXJyZW50IGJyaWdodG5lc3MvYmFja2xpZ2h0IHZhbHVlIHJlYWQgZnJvbSBwd20gcmVnaXN0ZXIs
IHdoZW4gY29udmVydGVkIHNob3VsZCB5aWVsZCAxNTkgYnV0IGl0IHJldHVybnMgNDUuDQoNCkhl
bmNlLCBJIGJlbGlldmUsIHRoZXJlJ3MgYSBidWcgZWl0aGVyIGluIGNvbnZlcnNpb24gYmFjayBh
bmQgZm9ydGggb2YgdXNlciBzcGFjZSBsZXZlbHMgb3IgcHdtIHJlZ2lzdGVyIGlzIG5vdCB0aGUg
cmlnaHQgd2F5IHRvIGFycml2ZSBhdCBjdXJyZW50IGJyaWdodG5lc3MgdmFsdWVzLg0KDQo+ICAg
SXQgbG9va3MgbGlrZSB0aGUgdmFsdWUgbWlzbWF0Y2gNCj4gaXMgb3VyIHJvb3QgY2F1c2UuDQpZ
ZXMsIGFwcGFyZW50bHkgSSBjb3VsZCBub3QgZmluZCBhbnkgb3RoZXIgcmVnaXN0ZXIgcmVhZCB0
aGF0IGNvdWxkIGJhaWwgdXMgb3V0IGhlcmUgYW5kIHByb3ZpZGUgYWN0dWFsL3Byb3BlciB2YWx1
ZXMsIGhlbmNlIHRoaXMgcGF0Y2guDQo+IEkgcmVtZW1iZXIgYSB3aGlsZSBiYWNrIGxvb2tpbmcg
YXQgYW4gaXNzdWUgd2hlcmUgd2UgdGhlIHJlYWRiYWNrIHdhcyANCj4gZnJvbSBETUNVIHdoaWxl
IHdlIHdlcmUgc2V0dGluZyBCTCBkaXJlY3RseSB2aWEgUFdNLiBJIHdvbmRlciBpZiB0aGUgDQo+
IG9wcG9zaXRlIGlzIGhhcHBlbmluZyBub3cuDQo+DQo+IFNlZSB0aGlzIGZvciB0aGUgcHJldmlv
dXMgZml4Og0KPiAyYmYzZDYyZGFiY2MgZHJtL2FtZC9kaXNwbGF5OiBHZXQgYmFja2xpZ2h0IGZy
b20gUFdNIGlmIERNQ1UgaXMgbm90IA0KPiBpbml0aWFsaXplZA0KDQpUaGUgc2FtcGxlIHZhbHVl
cyBtZW50aW9uZWQgYWJvdmUgYXJlIHdpdGggdGhpcyBwYXRjaCBhcHBsaWVkLg0KDQpJcyB0aGVy
ZSBhIGJldHRlciB3YXkgb2YgcmVhZGluZyBjdXJyZW50IGJhY2tsaWdodCBsZXZlbHMsIHRoYXQg
cmVmbGVjdCB1c2VyIHNwYWNlIG9uZXM/DQoNCg0KPj4gVGhpcyBsZWFkcyBvdmVyZHJpdmUgaW4g
cXVldWluZyBvZiBjb21tYW5kcyB0byBETUNVIHRoYXQgc29tZXRpbWVzIGxlYWQNCj4+IHRvIGRl
cGVuZGluZyBvbiBsb2FkIG9uIERNQ1UgZnc6DQo+Pg0KPj4gIltkcm06ZGNfZG11Yl9zcnZfd2Fp
dF9pZGxlXSAqRVJST1IqIEVycm9yIHdhaXRpbmcgZm9yIERNVUIgaWRsZTogc3RhdHVzPTMiDQo+
Pg0KPj4gW0hvd10NCj4+IFN0b3JlIGxhc3Qgc3VjY2Vzc2Z1bGx5IHNldCBiYWNrbGlnaHQgdmFs
dWUgYW5kIGNvbXBhcmUgd2l0aCBpdCBpbnN0ZWFkDQo+PiBvZiBwd20gcmVhZHMgd2hpY2ggaXMg
bm90IHdoYXQgd2Ugc2hvdWxkIGNvbXBhcmUgd2l0aC4NCj4+DQo+IERvZXMgQkwgd29yayByZWxp
YWJseSBhZnRlciBTMyBvciBTNCB3aXRoIHlvdXIgY2hhbmdlPyBJIHdvbmRlciBpZg0KPiB0aGVy
ZSBhcmUgdXNlLWNhc2VzIHRoYXQgbWlnaHQgYnJlYWsgYmVjYXVzZSB3ZSdyZSBubyBsb25nZXIg
Y29tcGFyaW5nDQo+IGFnYWluc3QgdGhlIGFjdHVhbCBCTCB2YWx1ZSBidXQgYWdhaW5zdCBhIHN0
b3JlZCB2YXJpYWJsZS4NCkkndmUgdmVyaWZpZWQgdGhpcyBwYXRjaCBmb3IgYm9vdCwgUzBpMyBh
bmQgR1VJIG1ldGhvZCBvZiBjaGFuZ2luZyANCmJyaWdodG5lc3Mgb24gQ2hyb21lT1MNCj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFNoaXJpc2ggUyA8c2hpcmlzaC5zQGFtZC5jb20+DQo+PiAtLS0NCj4+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDcg
KysrKy0tLQ0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbS5oIHwgNiArKysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPj4gaW5kZXggZGYwOTgwZmY5YTYzLi4yYjgzMzdl
NDc4NjEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbS5jDQo+PiBAQCAtMzk3Miw3ICszOTcyLDcgQEAgc3RhdGljIHUzMiBj
b252ZXJ0X2JyaWdodG5lc3NfdG9fdXNlcihjb25zdCBzdHJ1Y3QgYW1kZ3B1X2RtX2JhY2tsaWdo
dF9jYXBzICpjYXANCj4+ICAgCQkJCSBtYXggLSBtaW4pOw0KPj4gICB9DQo+PiAgIA0KPj4gLXN0
YXRpYyBpbnQgYW1kZ3B1X2RtX2JhY2tsaWdodF9zZXRfbGV2ZWwoc3RydWN0IGFtZGdwdV9kaXNw
bGF5X21hbmFnZXIgKmRtLA0KPj4gK3N0YXRpYyB2b2lkIGFtZGdwdV9kbV9iYWNrbGlnaHRfc2V0
X2xldmVsKHN0cnVjdCBhbWRncHVfZGlzcGxheV9tYW5hZ2VyICpkbSwNCj4+ICAgCQkJCQkgaW50
IGJsX2lkeCwNCj4+ICAgCQkJCQkgdTMyIHVzZXJfYnJpZ2h0bmVzcykNCj4+ICAgew0KPj4gQEAg
LTQwMDMsNyArNDAwMyw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RtX2JhY2tsaWdodF9zZXRfbGV2
ZWwoc3RydWN0IGFtZGdwdV9kaXNwbGF5X21hbmFnZXIgKmRtLA0KPj4gICAJCQlEUk1fREVCVUco
IkRNOiBGYWlsZWQgdG8gdXBkYXRlIGJhY2tsaWdodCBvbiBlRFBbJWRdXG4iLCBibF9pZHgpOw0K
Pj4gICAJfQ0KPj4gICANCj4+IC0JcmV0dXJuIHJjID8gMCA6IDE7DQo+PiArCWlmIChyYykNCj4+
ICsJCWRtLT5hY3R1YWxfYnJpZ2h0bmVzc1tibF9pZHhdID0gdXNlcl9icmlnaHRuZXNzOw0KPj4g
ICB9DQo+PiAgIA0KPj4gICBzdGF0aWMgaW50IGFtZGdwdV9kbV9iYWNrbGlnaHRfdXBkYXRlX3N0
YXR1cyhzdHJ1Y3QgYmFja2xpZ2h0X2RldmljZSAqYmQpDQo+PiBAQCAtOTk0NCw3ICs5OTQ1LDcg
QEAgc3RhdGljIHZvaWQgYW1kZ3B1X2RtX2F0b21pY19jb21taXRfdGFpbChzdHJ1Y3QgZHJtX2F0
b21pY19zdGF0ZSAqc3RhdGUpDQo+PiAgIAkvKiByZXN0b3JlIHRoZSBiYWNrbGlnaHQgbGV2ZWwg
Ki8NCj4+ICAgCWZvciAoaSA9IDA7IGkgPCBkbS0+bnVtX29mX2VkcHM7IGkrKykgew0KPj4gICAJ
CWlmIChkbS0+YmFja2xpZ2h0X2RldltpXSAmJg0KPj4gLQkJICAgIChhbWRncHVfZG1fYmFja2xp
Z2h0X2dldF9sZXZlbChkbSwgaSkgIT0gZG0tPmJyaWdodG5lc3NbaV0pKQ0KPj4gKwkJICAgIChk
bS0+YWN0dWFsX2JyaWdodG5lc3NbaV0gIT0gZG0tPmJyaWdodG5lc3NbaV0pKQ0KPj4gICAJCQlh
bWRncHVfZG1fYmFja2xpZ2h0X3NldF9sZXZlbChkbSwgaSwgZG0tPmJyaWdodG5lc3NbaV0pOw0K
Pj4gICAJfQ0KPj4gICAjZW5kaWYNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uaA0KPj4gaW5kZXggMzcyZjlhZGYwOTFhLi4zMjEyNzli
Yzg3N2IgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbS5oDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbS5oDQo+PiBAQCAtNTQwLDYgKzU0MCwxMiBAQCBzdHJ1Y3QgYW1kZ3B1
X2Rpc3BsYXlfbWFuYWdlciB7DQo+PiAgIAkgKiBjYWNoZWQgYmFja2xpZ2h0IHZhbHVlcy4NCj4+
ICAgCSAqLw0KPj4gICAJdTMyIGJyaWdodG5lc3NbQU1ER1BVX0RNX01BWF9OVU1fRURQXTsNCj4+
ICsJLyoqDQo+PiArCSAqIEBhY3R1YWxfYnJpZ2h0bmVzczoNCj4gImFjdHVhbCIgc2VlbXMgbWlz
bGVhZGluZyBoZXJlLiBXZSBtaWdodCB3YW50IHRvIGNhbGwgdGhpcw0KPiAibGFzdCIgb3Igc29t
ZXRoaW5nIGFsb25nIHRob3NlIGxpbmVzLg0KPg0KPiBCdXQgbGV0J3MgZmlyc3Qgc2VlIGlmIHdl
IGNhbiBmaXggdGhlIG1pc21hdGNoIG9mIEJMIHJlYWRzDQo+IGFuZCB3cml0ZXMuDQoNClllcywg
bGV0cyB0aG9yb3VnaGx5IGV2YWx1YXRlIGlmIHRoZXJlIGlzIGFueSBvdGhlciB3YXkuDQoNClJl
Z2FyZHMsDQoNClNoaXJpc2ggUw0KDQo+DQo+IEhhcnJ5DQo+DQo+PiArCSAqDQo+PiArCSAqIGxh
c3Qgc3VjY2Vzc2Z1bGx5IGFwcGxpZWQgYmFja2xpZ2h0IHZhbHVlcy4NCj4+ICsJICovDQo+PiAr
CXUzMiBhY3R1YWxfYnJpZ2h0bmVzc1tBTURHUFVfRE1fTUFYX05VTV9FRFBdOw0KPj4gICB9Ow0K
Pj4gICANCj4+ICAgZW51bSBkc2NfY2xvY2tfZm9yY2Vfc3RhdGUgew0K
