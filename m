Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CB7C3DA64
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 03:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D46210E092;
	Fri, 26 Jul 2024 03:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n/T0Iqlo";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C53A10E092
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 03:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bo/1xeVGP/7J0dsLtTsW/1UwSTT2dU6I5H2yINOwxOS3lJ4Ic0TNvTNhy7SPxdU7r9aNmOhAMdjEyl/lGWy3OEZgCzEFtPmTJnMKL6gaYO3CKkotMMn8JfxiiqUK2nxxu1/1TZy/pi8IK5PcHfKT2Aj03M7vGcDJLXV1okYhZwaybctZisAlk3ZCf/wgJ/W83RwbFgq2IstnV0JoqMfYyi2d6HrWcs0zb1E7XBWg5eeMYlyDoO5GTBIYNgHrnBF7uinLY+bHiEFwYpa6Tsv2fpZHN6mV6mTm8yxMDiO4trWmIfkgCVEzpaE5RSDNoqlutJVF7ihgMzFPx6OkL+F8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euiyyztqcU43tpBEx2JFJ0mSo95DtJncLg4zVhvkmlg=;
 b=n/xGIyEGHe/6xHpv2ZyVty/glkQE8p0q8Ha34RhTmYFXTgWzpniNIo8FITEbiTd88tsx1bL/2BvfCRhLdIdcQ9mjlBS0Zvq+P36ebzpCra/cZysdmBqfHfB5FuCq3u4GarHwuNwqt1kk1ndCYuaLudOi79zi21gnBZ++HYnhwwdScLGueoec6XomPv3YVdZKIpvSsFKH1L8TblNpwECYJt06Byi6yiXiv9rOVMlSHBagASiKyFjGc+I0PFgZ1lSdvinombwHT68mudY2FdN8CRiFaE/bZUVKEP9mjBRzCxi8HX6ra08YMaAJ0OFvdNLnFtYG+8bdxayhhgg36S4Jng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euiyyztqcU43tpBEx2JFJ0mSo95DtJncLg4zVhvkmlg=;
 b=n/T0IqloNOmDrR9a/P0cifGzYARuaxhdJqPNzXkQkU+zGFgkBy1FbvXzvg9GoTFhL1W5DY3MuyFzVM1kHVhHqKR5YohdE0fmUH+SI+y1BtJc3v9PBnUH911Zujti7myr51Fm8O7U01deWxTHwJFkQYGERoc63qgV1fupYG9pM1k=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.28; Fri, 26 Jul 2024 03:11:26 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%3]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 03:11:26 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm: update documentation on memory clock
Thread-Topic: [PATCH] drm/amdgpu/pm: update documentation on memory clock
Thread-Index: AQHanM58c0jMHgM1h0OLWlw7SarhVbIIfRMAgABbpkA=
Date: Fri, 26 Jul 2024 03:11:26 +0000
Message-ID: <DM4PR12MB51655820A3FFEB1AFD23BFEF8EB42@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20240502202216.3385044-1-alexander.deucher@amd.com>
 <CADnq5_NsEWDX2T05PvaQHccLE8S8zUWYEeCmVn=4wEm+p1DdHw@mail.gmail.com>
In-Reply-To: <CADnq5_NsEWDX2T05PvaQHccLE8S8zUWYEeCmVn=4wEm+p1DdHw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3f11b373-5f4d-4b8b-945b-21afaadd3373;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-26T03:09:02Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|DM6PR12MB4468:EE_
x-ms-office365-filtering-correlation-id: 62cbe24d-6647-46d2-33ce-08dcad20a2fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T0ZvTUVCR0dLZnIrUm9ENUM2TTU4YlFEZ1o1VzAycXpWbUdsUEV0OVprenhB?=
 =?utf-8?B?UTJCbjR5RVdyOVMwTEs1OWFHeTR6N3ZmQzFoSE00a04xYnd3ZkNxV1VXMnJO?=
 =?utf-8?B?d09UTEZUbjYwNFlzYnY4OXA0cXJPSVhFWktKV29JdGZNUmVRTXNXWVp3eGhj?=
 =?utf-8?B?b2VnK0FuM0Mzckg5YXVTVG5QazlXZEtrMHVONXh0eTFZMUROcmc1eEVqT0x1?=
 =?utf-8?B?amo3UnNoUi9zMnVMb2VSeVR6RXZKQ2JQWm1YVTFOc0UydzZ0U3VObEozelIw?=
 =?utf-8?B?cFJRcmZaRGtaRlhjcE83bHhOdzZaMXY3TERxdFEyZElaU1hjdU5nZVphOE9q?=
 =?utf-8?B?d1o1UTVkM29hcWZUWi91c1EvRG8yUTJOekVZUU5EWUZNL0YzMXRVVVo1UmlT?=
 =?utf-8?B?S3lJcHhqN3dpVFdndjBxeTZ5QURBRitJMytONlFyMDF6ZlFVVTVYeFE3T3M0?=
 =?utf-8?B?aDlWc2VKMnRsL203dlkvdTF0djFkUEd2QXBXMUxOMDhKdHp2djJCdXFYVlMz?=
 =?utf-8?B?RVA2TU9Dbk5uNmZwRFd5eS8yck5yUGFCZUZkTnZ4U1VpcDhZWXVUbVNjSGI0?=
 =?utf-8?B?MzRlMGdrWmZsTk5qanJBVnVFcFllL3cvQXd2a0d3ODJWTG0yVUNlbHZ0UWg3?=
 =?utf-8?B?RktEV0ZBUVVKRnI5bzBhQ3ordXZLei9vVlRMMjJnNUF6YkdPcXZyZTZ0TmxJ?=
 =?utf-8?B?TU9MN0dPbnhiNHlKanBsZGFNRHR4WU5MaUQyRHJYQVB0VWFwL3g4QS9nc2tB?=
 =?utf-8?B?K1BJUGJ6ZmczaHZLSXNVaFNQV3lxaU1HWWNsY29LUEUwdXlYLzlxSHorOFBt?=
 =?utf-8?B?QXFvaENUenREeDN2OXdxQUNUYUFUWk9iZTNWRy94UWtkNkQyQ0UwVW92cEZa?=
 =?utf-8?B?WFlBOEdBSXdkU2ViOUZYcnBORW5rY05JdkgwMk5BTEdncGJxcFpRUzltbFBr?=
 =?utf-8?B?MHJ5a0RnWlFEUUsvVmd3SllEdmVIUlpGeGFHM29uMjIzR3AzRTg2SHBvSXlG?=
 =?utf-8?B?STl2ZEZHYUN0WVBXUWFOUzkrOGJEdFZxQ2dYNFpGM2xpNUhJWE5iODRPbDY0?=
 =?utf-8?B?R29jcDBmWUZtTHFLN1N4REJPTHFOOHhmbUh2cndMOUVTYjVlV2doazE3bUpI?=
 =?utf-8?B?Sm84R0xSa3dnMHkzSGNQOGtJUWdTL0ZNc094NmlwMUZRUm96SlhEK2ZBTzN5?=
 =?utf-8?B?WWZnVnhsaWgzQTVKT3U5bk1Nc1k0ZTN0dFo2Zk9uQWJma1k3UE5ydXBudUUv?=
 =?utf-8?B?cTB6N05yTmxzREVOam5sdnBhb01uc2xybTF1dFBLQ0ZLVCtGSkc3QjNsR2kr?=
 =?utf-8?B?OTdkTFhDTzhPZVRSV2t3RFgvSGp2MTZxa0M1cjRrTERDZGV0YmJLaTlUcm1i?=
 =?utf-8?B?Q3VSMWxNU0REaUFVcWNIMUdkdXNwZ2JnNmp3L0tZbFhYMUpnSmlqM1h5UjNO?=
 =?utf-8?B?QVRTVno5YnRnQXBoaHVLYnA3dmNtS0lEbk92eWd1TE5DdGNuUHFET2dhWnI2?=
 =?utf-8?B?Q2c4KzJENmRZRTJGYlhMNVhnOTRFTEtXcVhvQ3JjdlNZdUJyeG9pS2h0RFYw?=
 =?utf-8?B?NjFEZTEvaXhuV2l3VW9iemV2Sjc0U1NuTmxPTkFPT0xPeXY4cEN4U2pRWU5k?=
 =?utf-8?B?VkJxMDVwbDNLeFhUWDA3OU9WUWR0ZzczQkZmYWlOYmlUSlBrOGo5Tkx6TWdT?=
 =?utf-8?B?SGk1REVlV1Qwd0hlYkYva25aYWRYZ0cwNXhrSmg3VEY4RWpjVUF3Nm1aU3dh?=
 =?utf-8?B?MzM4b2FKaHF2QmkydzFtQjRibGRLT0VNZXRKTUFiSEhSYUNxYkVCdzkrd1hB?=
 =?utf-8?B?NlpGV1d2MjZBSHJveDJuUGNVUzh6ZkR1Z1VnY291UHlhRUIxL1cyaEpkWEZF?=
 =?utf-8?B?ek1yT0xLdmUyNytCeWVaMWE5WW85aGdRaEQzbkw0NncwUFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1pob3JNc3pBZnc0S0dFZ1lSSjZDTWo2MjB4VHg0Z2hZV050ZDhtcUlQWUhK?=
 =?utf-8?B?VXl0elVRQXM4cXpteGdtWVN0OGFWUnE2QlE3RG95cU1QTDBld2pCaGp5SDQz?=
 =?utf-8?B?MEl3TTcwRTNpWkR4cWVWVWNMbnVIR0R5N1hSZXRJYll1T0JMd1VzOUJhTEZx?=
 =?utf-8?B?Y3pvVWQvUUdqT0hNZlNFc0ZFZ2R4YUdQVGVOaXpJbGhtQkhCV0REb3FzWG82?=
 =?utf-8?B?OGNYMk9haEZNMHhJUkdxcVJwQkZEODRHUnVrTFpDTUpGeTFYa2lYY3VpdDZt?=
 =?utf-8?B?M2xlbGZiZFI0Qnp4dTNpWHRObGp2cEErL3VzYmNzWjE1OFlNazlhUUQ3MXVB?=
 =?utf-8?B?dVJVWjNxaFNoU0hEcUdVZXJoVDRSNW5XSjJNQllzd3p1YkcydGNZUUFVSitL?=
 =?utf-8?B?VThEOXNPQjJGRlFFbXdzbUUrU2JCajJILzdzWVVRMUlyWTNZTElvcFZyeXlW?=
 =?utf-8?B?TE1FYmVsMzFGRUNLZ203RnB2YzVGL3dOcE5xVXlBNkh3ZTB5MUpwYU5yQW1l?=
 =?utf-8?B?UTVWeWFLY0ZWNnN6U1ZocmhaSGxNV1lQRzF4dkZrWWIzODd6Tlh1MGthZ2ZE?=
 =?utf-8?B?Y05jVGpHQVpDKzhWWjlWeGFTOXl3dWcvVWRYc1B6NlU4UXlYdkVibDJWU2x3?=
 =?utf-8?B?eDNOelhFbmxtekptdU9OdXhVR3N4cmIzcXQ5eFcrQXBUS0Y5Y0c3MjFGaDJw?=
 =?utf-8?B?ZnluclorNHlSQUxMRWxmUHFoMS9OVkcrb2tWMEUzU0xtWVYxQ205YVZwWVNL?=
 =?utf-8?B?Nk9kd2dDVlRWQ2xqUTc1Q2ZzOVRzS0RabG1TSmRQRTBMME1jVWFhWkh5V3dr?=
 =?utf-8?B?RUpRT0tLb1pCQ0FnS244QjFSNDVVdmp6ZzJiK1kzdlBBUG1KK2tXOGd4aHlK?=
 =?utf-8?B?OGxSejduNk9WM3NxdklwazNXRkkwSHRscXdDRXN3dmxZWFRGQWdBblREREhR?=
 =?utf-8?B?TmNkemRVMjlCZFR4N3NLTVpZMUdxUGNMbkhkQ1FFMCtQUjBrcWFpUG5vTUpF?=
 =?utf-8?B?R1J6dzBqWms2T3o0anB0eEllSExhT1FpYWlTRmNCakt6ZThDbW1hNmR4Ukc2?=
 =?utf-8?B?RnMvZVBES3RCU0xQNTJCd05SNDZjU212Y2gxNmk3L0xxYTZGYUxQYWgxVGpZ?=
 =?utf-8?B?Sy9DWmYxbUN1VE84dDE0azhzRkp1WGhYNXB5SGJSUVp6UkVxazBvSVozVkd1?=
 =?utf-8?B?MCtPWEVYaXlZR0Q3MHVzK1NjRjBxcGhSVlVySEdPcWtSRHhJNzJZRWlnUzda?=
 =?utf-8?B?NjIzclJTRlBybUhGNnFSMTl4QjFRVGhEMUVxbm55ZzhqeEdlNGo1UCt2SHI5?=
 =?utf-8?B?Q2p1RXBhWVdUTjI4bHJiekhHcDZRSGZQbFBPaytXc1JhQzN5S0gzazZEcHVo?=
 =?utf-8?B?aXczNXBNNU1iWDVIZmlOeW5VSnNHeTQwTTFtVkhBbnZId1ZnU3dvYWJNVk4y?=
 =?utf-8?B?b2FDem0rU0xIZEFwbmk4NGZWSkhZMTdqNjZ3VGRtZWs1RFRIR0NMN0ZOSjhw?=
 =?utf-8?B?YjRGQ3pCNkowRHF6aE1tY294cG4vdEJwNzNaR1MxYk9QaGgxK1hXS1hOWkZJ?=
 =?utf-8?B?YTQ2L2lFYmRBcDRmWVNwNnNnNzVLdmVpbFlYMmF6dXg4V0NnNkJKeVFNSjNj?=
 =?utf-8?B?bFhSYjNFMkx4MW0ycDl6TmQrWEhuYVcyellvVkdYM09JYnR0WnM3QUlDekNh?=
 =?utf-8?B?TXNPYndGd0pPcDBDSjNyUm9wUnN6TkQxZUpVSWhmNEo5UVBINzhrQ3l2VXJN?=
 =?utf-8?B?VkVlcFMxRkQrVFQzS0lDTmc2QStCOU0vakNSR0pGZU4zdkZmT0RYWnM4eWlF?=
 =?utf-8?B?YU91ZllBRGhqQStiekVBSk5Qc2IycG9qUENiMmJUcFpJdDlzeDVJWHZiMlZG?=
 =?utf-8?B?cGQ5TXpLd3lrTG83bTJZa0MrTnJ5TFYvZ3lXVDU0Vmg2bUxHSkVEMERwc04v?=
 =?utf-8?B?Y3FFTmlTOGdlaDFrMkovUnRNMHo3RXlaUFBGNlBSVTNhRFhQejU4M05PWVlN?=
 =?utf-8?B?QkxtdkZyelVOdGgxK1hWczVsdEc5Nk8zcTByTHZoWDZYaS9CTDhZMWFpY3Zo?=
 =?utf-8?B?QzdPVG5SZmkyTEFwdVljQ2JJY09zd2NkbExLbmp1bEUvelN5ZFFUTmUxVDZ5?=
 =?utf-8?Q?tZ2k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62cbe24d-6647-46d2-33ce-08dcad20a2fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 03:11:26.4251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EE+PJpK0jAtQZ+T6Vxf39/zYkIW6fZcRK/Pdf4d4KHq8UmFc0B5PGt05iEwiFKz7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgQWxleCwNCkkga25vdyB0aGF0IEc2IE1DTEsgPSAyKlVDTEsuDQpNYXkgSSBrbm93IGhv
dyBkaWQgeW91IGdldCB0aGUgZGF0YSB0aGF0IGVmZmVjdGl2ZV9tZW1vcnlfY2xvY2sgPSBtZW1v
cnlfY29udHJvbGxlcl9jbG9jayAqIDE/DQpUaGFua3MuDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3Rv
cC5vcmc+IE9uIEJlaGFsZiBPZiBBbGV4IERldWNoZXINClNlbnQ6IEZyaWRheSwgSnVseSAyNiwg
MjAyNCA1OjQxIEFNDQpUbzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTog
W1BBVENIXSBkcm0vYW1kZ3B1L3BtOiB1cGRhdGUgZG9jdW1lbnRhdGlvbiBvbiBtZW1vcnkgY2xv
Y2sNCg0KQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBT
b3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNr
aW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KDQoNClBpbmc/DQoNCk9uIFRodSwgTWF5IDIsIDIw
MjQgYXQgNTowN+KAr1BNIEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4g
d3JvdGU6DQo+DQo+IFVwZGF0ZSBkb2N1bWVudGF0aW9uIGZvciBSRE5BMyBkR1BVcy4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMgfCA2ICsrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
YW1kZ3B1X3BtLmMNCj4gaW5kZXggZWM5MDU4YzgwNjQ3YS4uOWFkMTE0ZTY5NWU1ZCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9wbS5jDQo+IEBAIC02MTAsMTIgKzYxMCwxOCBAQCBz
dGF0aWMgc3NpemVfdCBhbWRncHVfc2V0X3BwX3RhYmxlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4g
ICAqDQo+ICAgKiBDbG9jayBjb252ZXJzaW9uIChNaHopOg0KPiAgICoNCj4gKyAqIFByZS1SRE5B
MyBHUFVzOg0KPiArICoNCj4gICAqIEhCTTogZWZmZWN0aXZlX21lbW9yeV9jbG9jayA9IG1lbW9y
eV9jb250cm9sbGVyX2Nsb2NrICogMQ0KPiAgICoNCj4gICAqIEc1OiBlZmZlY3RpdmVfbWVtb3J5
X2Nsb2NrID0gbWVtb3J5X2NvbnRyb2xsZXJfY2xvY2sgKiAxDQo+ICAgKg0KPiAgICogRzY6IGVm
ZmVjdGl2ZV9tZW1vcnlfY2xvY2sgPSBtZW1vcnlfY29udHJvbGxlcl9jbG9jayAqIDINCj4gICAq
DQo+ICsgKiBSRE5BMyBHUFVzOg0KPiArICoNCj4gKyAqIEc2OiBlZmZlY3RpdmVfbWVtb3J5X2Ns
b2NrID0gbWVtb3J5X2NvbnRyb2xsZXJfY2xvY2sgKiAxDQo+ICsgKg0KPiAgICogRFJBTSBkYXRh
IHJhdGUgKE1UL3MpOg0KPiAgICoNCj4gICAqIEhCTTogZWZmZWN0aXZlX21lbW9yeV9jbG9jayAq
IDIgPSBkYXRhX3JhdGUNCj4gLS0NCj4gMi40NC4wDQo+DQo=
