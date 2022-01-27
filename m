Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B775AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 14:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46CE710F032;
	Thu, 27 Jan 2022 14:15:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A0E010F032
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 14:15:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KV/Xvx8wEmXmNpnyIhi2vnfrNjW52/qaGi4P5WbM+jmctfG2KgrZ9sb74jkYTSowNUMqT4SV1qAxwSllGa/pmozbqIRBuVFa0EggZ9EzgR2gajosNev1+fSnJmc3u2C85HmfOd5dfl+OCkOl5neJYl4Geq7w9oDv48qiZGoucAzQwXNs8ZQzS9Y0Sdy4zMaI2Itdt7k5QqaQT/cmXpyMp9QEAofUVKm7rS7HExarI4MvffX/ZEACcVIyOkGjy1b+kDo/5FqvVjVOXJlgy/kP8l20d7dVGCtA22hVlBXDPambGVEIAX63DgwiJFxXHlJPraTVdESF07puFCrtxDlKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GXM/FFWr2nrMrUgNU3Vz2lnmMlZgZLv854+8NQ2dfc=;
 b=UkmzC1xb01UfYXhu7Erkwb9sV9lAR0g5HZN+n65r1AWfpve7h2lNxmBa7j/KuSelbBN4+56BMlKkV0vKbg+PA2HPofu4oHRHHvoen5tks4WDkHrq1vbEqwS5smyeCT1xBq2jU0G7aOTUbgj2E2f/bzUYABQjgZE226suk7m944r4hRpLUQz9PA0e5UlY3yowS4cp04566En0k+IAvj5grODiaksgiDUSzdSvP1QhoNKpjtnpMzJnFkvpBAniAVExyp9g9MnTzWLnyDfixg5CtaGmOSLwkLSAIZjSks+UTT51jhC1IC8VtHbKERXgwNmljqCQ5BBb+A66BoKaGQfxRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GXM/FFWr2nrMrUgNU3Vz2lnmMlZgZLv854+8NQ2dfc=;
 b=VBOiE/LSY+IMla5uRFwg1/+MW2EYposBsCBYuT+eTJkK01RGcIA1lmcamJt1iER9+m60O8/eXxxZhbE5tX6tCszUkS543buwEJtEu9LBeRSpK/27G/4btcqu+OciSbhB9aFkU7g0O2ayoDptxR0gNFD92svDEPEfs2nIeLDuWY8=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by BN8PR12MB4769.namprd12.prod.outlook.com (2603:10b6:408:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 14:15:22 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::d4e4:8282:5f20:c812]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::d4e4:8282:5f20:c812%4]) with mapi id 15.20.4909.017; Thu, 27 Jan 2022
 14:15:22 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Newton, Jeremy"
 <Jeremy.Newton@amd.com>
Subject: Re: FIx for UMR arm build
Thread-Topic: FIx for UMR arm build
Thread-Index: AQHYEtkhGgvqGfCQbkqox484qGU4i6x24ORbgAAI3YCAAAEjFw==
Date: Thu, 27 Jan 2022 14:15:21 +0000
Message-ID: <DM6PR12MB3547927A130AEE839CB4FBB5F7219@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <DM8PR12MB54148E41D5C03634DDAC738FF6209@DM8PR12MB5414.namprd12.prod.outlook.com>
 <DM8PR12MB5414E5088A8AFE9240C57654F6219@DM8PR12MB5414.namprd12.prod.outlook.com>
 <CADnq5_PYaE16eEJ45d4Sq4D8LvHH7jrZVwhvET0hQHwogus0RA@mail.gmail.com>
In-Reply-To: <CADnq5_PYaE16eEJ45d4Sq4D8LvHH7jrZVwhvET0hQHwogus0RA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-27T14:15:21.464Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: e3969fc6-b8a6-d493-69bb-4463a0a94beb
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8cb075b-576a-4e70-5a72-08d9e19f747f
x-ms-traffictypediagnostic: BN8PR12MB4769:EE_
x-microsoft-antispam-prvs: <BN8PR12MB47694A864B6613685C0C57AFF7219@BN8PR12MB4769.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ag1MwoqoRH0MyUelGZYkktV/tI+zUajLzp1YXqQ6hpt2enRYIYTzhthggh2R45WO00rUXCXe6f33POImt/x0ssUG/mkKSzrKTwzFx6Q9nhqA0nN5TgjUa0/SUztzzcmvrpfMJEUANvBCT50aw20+MzF4p50PDnvOQ5yExuP2PlUQFuyyismJoh7UeIoMxvqVfDlZaJoanPShGSpkepHkN7k42qVox5Jvx3wPRUeuVRCHIiLgLFQs1UFIUcWXUyEVJeh4V3ORdyAAlSUiPHI4a9jO9eVM27aPvTyEloAcn+rh35R2XiXeS4wsYZXrg/iJ1S2TGDqBRti4r4tHviXdNrTRU6rwRjNuv+G8fe2tkBkDPZoWRCDH9Yv8fkMyxiPHlePdzwyTtscbhooCsz9CDMwKWtVbdDX9pWSsC7ceNsCpjTbVvyHcMy9bI4aKwmDHhFRSNn1hUJbxJ28WGJTUKtFpjOs1CD1ryEhY2C+7b/l+U94UZ3ZwVQ+3Z3pmhb7SPi5NDLFbhfIdpl1+9YVEwK0h6hcNrvILflTmMvoXpH+iTobAYP0z8S11So22wVHTqTT1sso29yq0+J41ZTclH3G2PjxGZu1f/tIKbTuYWw9PHREwy+DRD6uZwibP8s4pmUgaY0GOYqX5acIq04k2rLcL2g9IujFIagLx03zzsvQoxg2Bsjge6QQ4CuLVzqtAuPqe/8/DpVvVQr7s3cozjA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(5660300002)(9686003)(55016003)(76116006)(122000001)(186003)(91956017)(38100700002)(86362001)(7696005)(52536014)(2906002)(4744005)(6506007)(33656002)(71200400001)(4326008)(508600001)(110136005)(6636002)(8676002)(66556008)(66476007)(8936002)(66946007)(64756008)(66446008)(316002)(38070700005)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rzh0R0Q3RUo0MFU0T1RQdGdTeVU0SVhlbkxlWUxtTXJEUXJwWGhwSU9teEdM?=
 =?utf-8?B?U3dSdENEODk2ZzROVSt3Zm1GU1FReGc3K2dHcGpZMmVVd2xWWmNaeklGSTB6?=
 =?utf-8?B?OFlLMmJ0UnpLNVNyK2lKdXI2cXQ5RHRNSlNLRlU1R1Vhc3NPS3ZkM1ZEamZ3?=
 =?utf-8?B?OHpiNmFwQ2NaRmhiSUF1OHJiRWgyZVlZUGp5MHJucnJvUGlnSDFvU2dNVHdr?=
 =?utf-8?B?a09WLzk0SitxY0ZBZ1Q0VVVOZkZpTWNMMXA5bXdaS1hwc2pQU3B5VDdrd0di?=
 =?utf-8?B?eFg2REJLdDJaemRpMzdwcFRwRDJ1SnRNSC9DRXkwL2hyYkZibkFTY09NTkhm?=
 =?utf-8?B?TVlaMnJpN0ZwV3JGNUhpWUlXdnVLb3BZZnorejh0RnhXSSt4VnZ0Q2NGeTdx?=
 =?utf-8?B?aFBodEk1ckVlOFJ4RndsTzlyYTR0NWc3Yk1YZWx2ei9Dd1hOemErbUlyWHhB?=
 =?utf-8?B?MzFXTk9Oc0NrNWdKOFZuK0NpMExSYTcrUmxObkE1alVJZlJHdzFHamZpYWZu?=
 =?utf-8?B?TGRmWWpOQ1p5TnE2MEZEN20rTUd2dFg2a01wNEJKRjBXTzZVSlRYVlBWeVZQ?=
 =?utf-8?B?VnNid2NzUFJTdmwrWG1wb1NBL3A5MTVkT2NPOHdleWhrK25WcXBMN3VaWmJB?=
 =?utf-8?B?aVR0cnh3dm1qcmd0MU96cTJ0T3BDa3YzdjRSamNIYmFUdWNsTWFOZjFNK0dB?=
 =?utf-8?B?eERYT0o4c2IyaXl4bWV0T2RFcTlSTlNvaXVBMmdZWFkxRXQyMlRONGZmVGt6?=
 =?utf-8?B?V3oycjk2K0lvK1dWRSs1VmtvTFU5VFVlU1RIOVA0TExXcnFJdlIyWE9mTUF3?=
 =?utf-8?B?UVE4WElybjBTQ1MxU0lwZ0d4QVdPeDNudGZQSGxaUnVnbUc0dUxlQndMRFFx?=
 =?utf-8?B?MzcxQUptMjR0ZENEVE14MWtrbTMrc1ZkYlZoaFBuUVJRWlpxRytXWlp3aGNK?=
 =?utf-8?B?V0c2bmlQZ1pPcjJZaXhsM2t3bktnNWVWQ0haek1KVzlPMmFiZjI2ZTJyeXFq?=
 =?utf-8?B?eC9aL2NpTzlBL2IrYkxRaGVnQmgwL3VtcVIzMEY2T0NtSWp1ZmhTRWErNklq?=
 =?utf-8?B?Qkw0UFNKOTVjUjcrOStJY1NRN0N6eGw1TEtpN0dGeWVQbTVLdk5QTWFhWTBQ?=
 =?utf-8?B?NFBvYWZMNnJiQVU1WnZ1SlMyWmx5dXpEMWt2cWg0ODlhemRESzJVQlRSSWhV?=
 =?utf-8?B?OENYRXQ0S29rMktRUW9UOWRId2FxdnpyU1Y3VEcrNlRyTDRXRWJLQ2JDeDVS?=
 =?utf-8?B?TnNkbGIxdW1LK3A2R3ZGaHdqWVRQN1BYQWJ6VHVZUlkyS2ZPWUVwOXJ2WklD?=
 =?utf-8?B?R2JSTkVvc1NzYmxrUHkwYWNoTXdaYW5LUXB0QkNJc1lmcy9CSEd3T1hkMno0?=
 =?utf-8?B?RXk4c3lnVEJCbGpzNDFBUlhIRmVPNkRkcjM1SU1RK0pBNmtUdUtKQUNsOG8r?=
 =?utf-8?B?V3JFaTEvWStwOUlTaGo5ZGNVbEZhZE9kcEJZUmIzUHltSXFWVW9wSG1HWjdM?=
 =?utf-8?B?Yll6V0pxUGVjcEluVVhJdDhLQURUdW9nNUtIOHRhbXUrblBtaTZUR2pNODZx?=
 =?utf-8?B?aFZtbVpyYTdXK21zR0QwRjdNeW84cG16d2Jvb2lCUG1oSWQwMlgyb1pFV1h1?=
 =?utf-8?B?d05OaEFPK0g4WEc2SVVSWlV4bi9ES1M3dFZnTWhoWmZMTm4ybUE5SjQvQ0pI?=
 =?utf-8?B?WFk3U2VQM1lLcjBFRGNHVFJVL1pidzh5N1BXTmdiVkU2Tkx0d0V6NTMxeExq?=
 =?utf-8?B?ME9JbmtkK1gyTENWMnVUT3NmVUsya29RSEdUZCt3Z2x0bElsanZUc0ZsVmFR?=
 =?utf-8?B?NEt0MWZjeGF5dkk4OFBYVmFHQld6S3IzSXQrN1BjenBYZ25YOTNocjN4dnlB?=
 =?utf-8?B?TUE0STNOWXpkTGZGSkFmbStoNjJETWwxdnJUOGZ1eXRuRHVDSlpiMFV5eDZR?=
 =?utf-8?B?dGZzLzRlQVFDaWUyTVIza3F4dVhmYTFMaGEvTGtnbE91VDh1cWRza09NRWR3?=
 =?utf-8?B?Rk90SVEyS2dqWXVLeHV6bUpDNUluT1pBWVAzbCtpdXBIcU1CTmRlczN3ZDMw?=
 =?utf-8?B?K2kzcXJ1MlFyZmh4czd6cjhHUG9iQmMwVHRRQ2FQZDRtVkc5WEVvRXArOUxq?=
 =?utf-8?B?M1dGbUxDUjdPK1k4NDRvZVViQVh6NFlkOTYydW16aDZwZUVBOWtnKzhEQmI2?=
 =?utf-8?B?eVpKUEExa0RiNUNNY1JESmp2c0VLVlRCNDEvTHJIZlJqZ3ZFYVU3RjdHcEdq?=
 =?utf-8?Q?tG4975fuUatBn8KK1TC8Dr/xAewqkSGjZDBFp8zgc4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cb075b-576a-4e70-5a72-08d9e19f747f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 14:15:21.9720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/I+XdW2PA5zx9cZD0Wmj9C+/4mE93Xn/M+6S+qyba5OdM6RIJIrEI/YNFT8xOFKKquRCgDtt1PB26uocyVWNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4769
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KUHVzaGVkIG91dCwgd2l0aCB5b3VyIFJiLg0KDQoN
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTogQWxleCBE
ZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQpTZW50OiBUaHVyc2RheSwgSmFudWFyeSAy
NywgMjAyMiAwOToxMQ0KVG86IE5ld3RvbiwgSmVyZW15DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc7IFN0RGVuaXMsIFRvbQ0KU3ViamVjdDogUmU6IEZJeCBmb3IgVU1SIGFybSBi
dWlsZA0KDQpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPg0KDQpPbiBUaHUsIEphbiAyNywgMjAyMiBhdCA4OjM5IEFNIE5ld3RvbiwgSmVyZW15IDxK
ZXJlbXkuTmV3dG9uQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5
XQ0KPg0KPg0KPiBTb3JyeSBJIHRoaW5rIEkgZm9yZ290IHRvIGF0dGFjaCB0aGUgcGF0Y2gg8J+Z
gg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBGcm9tOiBOZXd0b24sIEpl
cmVteQ0KPiBTZW50OiBKYW51YXJ5IDI3LCAyMDIyIDg6MzkgQU0NCj4gVG86IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCj4gQ2M6
IFN0RGVuaXMsIFRvbSA8VG9tLlN0RGVuaXNAYW1kLmNvbT4NCj4gU3ViamVjdDogRkl4IGZvciBV
TVIgYXJtIGJ1aWxkDQo+DQo+IEkga25vdyB3ZSBvbmx5IHRlY2huaWNhbGx5IG9ubHkgY2FyZSBh
Ym91dCB4ODYsIGJ1dCB0aGlzIGp1c3QgZml4ZXMgYSBzeW50YXggaXNzdWUgaWYgeW91IGJ1aWxk
IG9uIGFybS4NCg==
