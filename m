Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E981C4706C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 22:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC7C410E537;
	Tue,  9 Jan 2024 22:58:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C4B110E537
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 22:58:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHGlcUjc7fyKPuqfpnTqDRctyEKIABn+EU083F9YdYUaHEuwTpx0ZORs3lefKai8pZ+tVfgCjhFByCViXKNkliJhhM/KdJNch+msJi7GlU9cas/t0JXG58bpXNH4vJiscpHU+geY+3ir89bnLsDXR6N7JWFvHYQCgl8Jtp4bWJcZTox+AIRnbr/cwNk6mLcVII1KDPmFcqykKIk8kegAOnZ0HpBmN4Msdfo41FyVhwftsYmNbOQdWQ2VQWVwyi8R5xX+S6KxMWESy8fWEpWjPZzP2Pf5ScKiXu1oMp+emX9NRMEbFSsFLwT4R3kbZ2Hx5pEgjLQNt09OdHDtTln6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYab827oUkRiGF4qBajSRHcYNvABdU4kqfRCnEiqQbY=;
 b=B9P68hZ6mv4GPxXYpF8O9577KFtuNpXc1E7iZg6R15Bx8l7pKPTvnVjrzHhVD9jjbsxoNiE3Zr8p6GHveby0951j2/vVhpwc7KeBJU2W17FoqjbHHo/omVBvmngrGAkytHLzgyeidVgo9/h06rrVGrrQNF6BH3vn687oxAhMcqvYOFvSOsrDD8MuB1GYLSay7a+MlvJu2unV8/8EC7EI6X+tPPymfa90Mt1qHEnHVeZXUQEhHb3bojWpu91ejDrEc31uYTrX0ruUSyHvnQV34zyH9GPoVLEt2lvbO22ijwGX8RJaSw77gV3q0S7DMfA7Jvj9Myl0s7Ad/wlom/aqdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYab827oUkRiGF4qBajSRHcYNvABdU4kqfRCnEiqQbY=;
 b=yPjHalBOHV6HOPVImvFVVQ0AqMtsRHrvrTTn+Ff/WPetvxmUCXagyfQmPc3cVCYanxRJhwEWcMuQBWpErkPDRIL8YxPaafJcn5zDFpp8FJvoEBIpiHECZX/QqPTGBNsGviwi7JkxRCdkINpD8N9xclb2oNYZb4MQOMJv4JYhAwc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN9PR12MB5355.namprd12.prod.outlook.com (2603:10b6:408:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 22:58:56 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 22:58:56 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Alexander Koskovich
 <AKoskovich@protonmail.com>
Subject: RE: Documentation for RGB strip on RX 7900 XTX (Reference)
Thread-Topic: Documentation for RGB strip on RX 7900 XTX (Reference)
Thread-Index: AQHaQg5xcJeFw0AC60y3NTa3oyYX3rDQfpSAgAAhGwCAAPZNgIAAWl0AgAAXaDCAAAJJgIAABpfAgAAJiPA=
Date: Tue, 9 Jan 2024 22:58:56 +0000
Message-ID: <BL1PR12MB51448DA153067FE1F635FEB1F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <oCYzPIgXFcQ3jdqAKY2upsY5qq23yOba06RkrzD5Bfai97jMWxGvBsaOiKi1k5oZvNg7IoJLE6jAA6BLGFXt08WbBEtdgJA4snn7khZ0JFM=@protonmail.com>
 <BL1PR12MB514454D5E625F71BB0E6A8B6F76B2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <xgXz7D0Xgjysg4ZLJpfd1ryjeEoM2fKFn9W5WIGBGxc6WSxcYxTZPzwKRNbqPYcDIf8P1zuDr5SYqSvl36GqzW8TimxvO7BGDq5S_zv8v3g=@protonmail.com>
 <BL1PR12MB5144D58D8EDA16731BA48102F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <Z8njgokdcTunZi6xnF-M7IGXA4_xj14qJE91X07_kII2oHfXkYWS45kIoKR3en9EIFyylWj5U_VFOjZkqcgbN_14JkeMlNtsRc13Jjvro58=@protonmail.com>
 <BL1PR12MB5144B46479ABF320088A4976F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <q_oRbF5mexY0ttw_MbcyqUd1KQIr1Ny7pg5sCCcIpor4AKUwktVDvuwoUpW0JO-rJXxJnyB5zOQ4JDYGRM2vNWeC2tMAsEto2JHlN6o-4Tk=@protonmail.com>
 <BL1PR12MB5144D4968D7C79D30F9D63F1F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144D4968D7C79D30F9D63F1F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=158fc79d-ad45-45df-92b9-d58c410db6a1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-09T22:22:54Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BN9PR12MB5355:EE_
x-ms-office365-filtering-correlation-id: 3454ff37-bc1e-419d-8df3-08dc11668eda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FXqdQurLf2xCQ89DEcoa1+4EI4hz7S6rcprmaVdGFY00VAuxlXoFHqn8as0Dq+AaYZ71BXS4k1VDzc/E/nKWhsXrMvmTCprxUJ75f2K1LKtMf5N2WNKq+/WYcY9AOv48qorsn2kuAbfdsB8gv2F7BWtN+Gm2ZfJLPa6MP+qR6g/1L2UBIu+B0WVwmRFCXuJznBzmt507a7m9Ksval6EvrRAsIHFo4uELlLoM8ligu3Xvfy+sdwXL6ncTlb/1NX+1aNpg8mR8FIlE3axYkuZD3Mb2u4M+x2Pb99L+H4eYDEc+rQsqilGcCqS5HgHkgty2gkuPLt4AQ0fH+R4tKREZ8QEsVwVa7XU6SU3rk3BsJmzbmbzoa22c/QWgytHQ/KtNpeTGyTmLTRQPxDj2g/eLZ0xqTTCBeUXE6kJljo1ex/MMzxcE7ArGC5T8Y9HVUvkWZFtadBaBo8XLdOvUtZqxswXQEg/ZjxS3xbr8hp+SVUd6xF7rnY9nKhLzADSfmIYZkGJX58/oyjBsDknTEGb3fWh350zGr+Dl3vHjq9KRanJt3uJ4Ra8ekyxYAtWSTcYrIPfv0aKETcE1dPjb6AVBJi08muaPepcKnzfXuTq9kM8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(5660300002)(33656002)(86362001)(2940100002)(966005)(7696005)(6506007)(71200400001)(26005)(53546011)(9686003)(8676002)(478600001)(4326008)(8936002)(110136005)(66946007)(316002)(41300700001)(66476007)(66556008)(66446008)(76116006)(64756008)(122000001)(38100700002)(83380400001)(52536014)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T285OFlwYldQa2p4T3cybS9MY0pUVFgySFVrSjMrajg4akdDbkFyTTlrUWR0?=
 =?utf-8?B?YWRKdHpTQUtEZm80cUx3RmpHN01SMHlnZDBKa0ZvVDd1Z0JLZ3kxSHljaDhO?=
 =?utf-8?B?SFhNKzlxSHVjWi9td1M4eGtINVBJMTBBMHNVVXFleWJZK1VwdWRQVGYzNkx4?=
 =?utf-8?B?N0Z5SmRpQkgvMVZRQkhMaWU5UmU3OWZIazllb1gzb0pRMTkwekJCVkkzeUc5?=
 =?utf-8?B?OGV3TE5NQ3FaTjJ6N0xPS2ZvaUpLRjROK2FZNVpaaDJXT2pMQTJ4QzRpbmhP?=
 =?utf-8?B?bXFGRGVackhOMWZUWVNIckpxd0tZdVZzdCtoU3dwakNFSHRjeHNlY294R083?=
 =?utf-8?B?RGd3bnNHeFJRSm1sb3VLcU8rUFpiYko5aytXOFhNRTFVVFJxeDlnQm5VQ2RS?=
 =?utf-8?B?dEczOFBZbUNURFBVa0V6TXNRVEtkQWNWV0lPT29pSHJES0FOajFqVjVCZjZU?=
 =?utf-8?B?aXlxQlF6VHljNnd2NkdWdlVheTNGVjhlLzJYNklNZU1qam81VFlocjBiQ2Rq?=
 =?utf-8?B?SmlBNEJQd09MY1JxeTNnSlpJak5qTEFXTWFYV1ZqTnNSZlFlUkp2bDNCSmgx?=
 =?utf-8?B?enhPaXQrVGJWcW5hOFdTZTkrR1lZUktydmswREdEQlZwMncyZnJqc3MraS8v?=
 =?utf-8?B?RWNZN1V3OGxqYkVEdkpNSXg0ZUFPaWpCN2NmeGFOeEFLUER5dFY0T0ZQaXNI?=
 =?utf-8?B?ZWFyOGg1dFNMVkFNNmhqNStkdFp6NmRINndlVkcyUk5xZHIrTjNJZlRVbkVJ?=
 =?utf-8?B?RC9CRmNOZnk4dldIYSt1OXVNOFFGQTdNRzJ2cHUwRUI0RGZlb3g3S0VhOFF0?=
 =?utf-8?B?N0k3L0hGbTJ1RGtmRHdrOG1VWFk2SHVJRDRzM1ZzNXJ4V1FiOVM4WldSSjhL?=
 =?utf-8?B?ZW83YkJhdlYxMjJtdFB1Q2l1T29IZFgvNlE2VndlWGhMQXRvRDRGVFVWb2to?=
 =?utf-8?B?N3YrakhuZHVpWGpTbHlqbmFJRnR0TnRKL2ZOWGc5RXRKRElPYVh5TkUvdlEy?=
 =?utf-8?B?N1N1dXZFdmJxM01kcVFNcmtiT25rb2hTRldrNTZtSHVLOU85QzZQWmI0VTZk?=
 =?utf-8?B?R2FmMVZOQlAvTUhZRWg2eDViZUk2aUFXYzFlS2IrdTM2d2ppUkdIeGRCVWo1?=
 =?utf-8?B?UnQ2Vlp2QjdWUUIxNFE1cW5IVUFUM3o5ajhLKzdVNlRSeURDZWVPR2hCMExa?=
 =?utf-8?B?SDdHbkZOVXV3bkRJNGRIemNWVmdMcXprdUxtbWFHV21FcHR6bFhZcUsycHMr?=
 =?utf-8?B?Wk5UUmRVMmQ1YjJlcm1QcVdhVE1taGNWdmdCNUsxa2VGR0pUeUhnVldaY1gy?=
 =?utf-8?B?d25VNnlIbzQrdzRhVXp4MTBBVjY2V21iaWx1UVRDTEdqeHhYYTZRRkJ3VUwx?=
 =?utf-8?B?SEJYSlhHWWgwWmVWV0NOSXBEMytJaWhHT0R0U3pZc1licWpCc3l6ZEU2UDF0?=
 =?utf-8?B?YXlWa1h2TmUxWFZyQzhpQk15azlNV0dDdWtJVS9XUFd5eFZLV3pSNmZDV1pk?=
 =?utf-8?B?K3hSeDBMRDgvUlY1dmIvRVp0ZXpua21UVzhQR0VmdTdaMzdzTVhmdjJHYnEv?=
 =?utf-8?B?V3FoeXRRSDhQWFVqK3NVWE11UDQ3UGF3MmxSeDAxSUpsdWNJSnRISFlORHBz?=
 =?utf-8?B?NXJFRHQvbnhaYk5xVGZYbzZzUlg0RHphbmdHOGtBV2pmMG1MbU5yeDhqN2t1?=
 =?utf-8?B?TFpLTXFOVjdaaGEyb0w2WWpvQ2oyM25ma3ZQeEp4cGhZelcrNytJNHlRZm4x?=
 =?utf-8?B?T0djb0lma3Y4dlhaVDJQOEtDTUJ4MDBWeW5kYzBaVlBhcmpINzZYc0RDdGI5?=
 =?utf-8?B?b1YwaHh2SFczSDhHTVRva3VNTlRHWjZ5bmRGWTUxbyt0MWkrMmxSUFQyNzZj?=
 =?utf-8?B?RGVLS0xBclU3MFFVNFJqZEhRSGZVRHlkSUhKbW9rUXJIU3pMK3NuQ3Jyd2s2?=
 =?utf-8?B?WDRvUE5hb3cxcTYrckc1eUVwODdOdTdHZXFLcmppcmtpUHpoSWcrZ1ZnK0hO?=
 =?utf-8?B?VXhaOG01YXNwVmF1UHVObHV1LzhEV2Zlclk4MXVteXYvTFRVZUZiWjNYNUw5?=
 =?utf-8?B?Z0JtRVpUeDR2OUE4YUNDUVVVSUI5eG80REwveWFvZlVwWkI2ekJkNmxUQWdp?=
 =?utf-8?Q?4dx0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3454ff37-bc1e-419d-8df3-08dc11668eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 22:58:56.0710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIxWekgIop9extyMtVES9tPu5eOXLPTc5N6y92WsvPmpEymENB7iu48ltbNQFYwRvehpwj7XCs1V1IgmZN7QLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5355
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4
IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4g
RGV1Y2hlciwgQWxleGFuZGVyDQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgOSwgMjAyNCA1OjI5
IFBNDQo+IFRvOiBBbGV4YW5kZXIgS29za292aWNoIDxBS29za292aWNoQHByb3Rvbm1haWwuY29t
Pg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUkU6IERv
Y3VtZW50YXRpb24gZm9yIFJHQiBzdHJpcCBvbiBSWCA3OTAwIFhUWCAoUmVmZXJlbmNlKQ0KPiA+
DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBBbGV4YW5kZXIgS29z
a292aWNoIDxBS29za292aWNoQHByb3Rvbm1haWwuY29tPg0KPiA+IFNlbnQ6IFR1ZXNkYXksIEph
bnVhcnkgOSwgMjAyNCA0OjU5IFBNDQo+ID4gVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4gPiBTdWJqZWN0OiBSRTogRG9jdW1lbnRhdGlvbiBmb3IgUkdCIHN0cmlwIG9uIFJYIDc5
MDAgWFRYIChSZWZlcmVuY2UpDQo+ID4NCj4gPiBJcyB0aGUgQUlCL09FTSBmb3IgdGhpcyBib2Fy
ZCBub3QgQU1EPw0KPiA+IGh0dHBzOi8vd3d3LmFtZC5jb20vZW4vcHJvZHVjdHMvZ3JhcGhpY3Mv
YW1kLXJhZGVvbi1yeC03OTAweHR4DQo+ID4NCj4NCj4gSSdsbCBkb3VibGUgY2hlY2sgKHdlIHVz
dWFsbHkgZG9uJ3QgcHJvZHVjZSByZWZlcmVuY2UgYm9hcmRzIHdpdGggUkdCKSwgYnV0DQo+IG15
IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBpZiBhbnkgb2YgdGhlIGJvYXJkcyBhdmFpbGFibGUgZm9y
IHNhbGUgb24gYW1kLmNvbQ0KPiBoYXMgUkdCIGNvbnRyb2xzLCB0aGUgUkdCIGNvbnRyb2wgaXMg
cHJvdmlkZWQgYnkgYSB0aGlyZCBwYXJ0eSB2ZW5kb3IuDQoNCg0KQ29vbGVyTWFzdGVyIHByb3Zp
ZGVzIHRoZSBSR0Igc29sdXRpb24uICBTZWU6DQpodHRwczovL3d3dy5hbWQuY29tL2VuL3N1cHBv
cnQvZ3JhcGhpY3MvYW1kLXJhZGVvbi1yeC03MDAwLXNlcmllcy9hbWQtcmFkZW9uLXJ4LTc5MDAt
c2VyaWVzL2FtZC1yYWRlb24tcngtNzkwMHh0eA0KDQpBbGV4DQoNCg0KPg0KPiBBbGV4DQo+DQo+
ID4NCj4gPg0KPiA+IE9uIFR1ZXNkYXksIEphbnVhcnkgOXRoLCAyMDI0IGF0IDQ6NTMgUE0sIERl
dWNoZXIsIEFsZXhhbmRlcg0KPiA+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPiB3cm90ZToN
Cj4gPg0KPiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBH
ZW5lcmFsXQ0KPiA+ID4NCj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+
ID4gRnJvbTogQWxleGFuZGVyIEtvc2tvdmljaCBBS29za292aWNoQHByb3Rvbm1haWwuY29tDQo+
ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgOSwgMjAyNCAzOjI3IFBNDQo+ID4gPiA+IFRv
OiBEZXVjaGVyLCBBbGV4YW5kZXIgQWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbQ0KPiA+ID4gPiBD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiA+ID4gU3ViamVjdDogUkU6IERv
Y3VtZW50YXRpb24gZm9yIFJHQiBzdHJpcCBvbiBSWCA3OTAwIFhUWA0KPiA+ID4gPiAoUmVmZXJl
bmNlKQ0KPiA+ID4gPg0KPiA+ID4gPiBEb2UgQU1EIGhhdmUgZG9jdW1lbnRhdGlvbiBvbiB0aGUg
aTJjIGRhdGEgdGhhdCBnZXRzIHNlbnQNCj4gPiA+ID4gY3VycmVudGx5IHRob3VnaD8gSSB3YXMg
aG9waW5nIHRvIGZpZ3VyZSBvdXQgd2hhdCB5b3UgbmVlZCB0bw0KPiA+ID4gPiBjaGFuZ2UgaW4g
dGhlIGNvbW1hbmQgdGhhdCBnZXRzIHNlbnQgdG8gY2hhbmdlIHN0dWZmIGxpa2UNCj4gPiA+ID4g
YnJpZ2h0bmVzcywgY29sb3IgKHJlZCwgZ3JlZW4sIGJsdWUpLCByYWluYm93LCBtb3JzZSBjb2Rl
LCBldGMuDQo+ID4gPg0KPiA+ID4NCj4gPiA+IEl0IGRlcGVuZHMgb24gdGhlIExFRCBjb250cm9s
bGVyIHVzZWQgYnkgdGhlIEFJQi9PRU0uIFRoZQ0KPiA+ID4gcHJvZ3JhbW1pbmcNCj4gPiBzZXF1
ZW5jZSBpcyBkZXBlbmRlbnQgb24gdGhlIExFRCBjb250cm9sbGVyLg0KPiA+ID4NCj4gPiA+IEFs
ZXgNCj4gPiA+DQo+ID4gPiA+IE9uIFR1ZXNkYXksIEphbnVhcnkgOXRoLCAyMDI0IGF0IDEwOjEw
IEFNLCBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPiA+ID4gQWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bSB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gPiBbUHVibGljXQ0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+ID4gRnJvbTogQWxleGFu
ZGVyIEtvc2tvdmljaCBBS29za292aWNoQHByb3Rvbm1haWwuY29tDQo+ID4gPiA+ID4gPiBTZW50
OiBNb25kYXksIEphbnVhcnkgOCwgMjAyNCA3OjIyIFBNDQo+ID4gPiA+ID4gPiBUbzogRGV1Y2hl
ciwgQWxleGFuZGVyIEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20NCj4gPiA+ID4gPiA+IENjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+ID4gPiA+ID4gU3ViamVjdDogUkU6IERv
Y3VtZW50YXRpb24gZm9yIFJHQiBzdHJpcCBvbiBSWCA3OTAwIFhUWA0KPiA+ID4gPiA+ID4gKFJl
ZmVyZW5jZSkNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBDdXJyZW50bHkgdGhlIHJlZmVyZW5j
ZSBjb29sZXIgZnJvbSBBTUQgZG9lcyBub3QgaGF2ZSBhbg0KPiA+ID4gPiA+ID4gZXhpc3Rpbmcg
UkdCIGNvbnRyb2xsZXIgZm9yIE9wZW5SR0IsIHRoYXQncyB3aHkgSSB3YXMgbG9va2luZw0KPiA+
ID4gPiA+ID4gZm9yIGRvY3VtZW50YXRpb24gb24gdGhlIEkyQyBjb21tYW5kcyB0byBzZW5kIHRv
IHRoZSBzZWNvbmQNCj4gPiA+ID4gPiA+IFNNVSwgc28gSSBkb24ndCByaXNrIGJyaWNraW5nIG15
IGNhcmQgYnkgc2VuZGluZyB3cm9uZw0KPiA+ID4gPiA+ID4gY29tbWFuZHMgZHVyaW5nIGRldmVs
b3BtZW50IHNvbWVob3cuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gd3JpdGVTZXRDTURXaXRo
RGF0YToNCj4gPiA+ID4gPiA+DQo+ID4gKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCj4gPiA+ID4gPiA+IGFkbGkyYy5pU2l6ZSA9
IHNpemVvZihBRExJMkMpDQo+ID4gPiA+ID4gPiBhZGxpMmMuaUFjdGlvbiA9IEFETF9ETF9JMkNf
QUNUSU9OV1JJVEUgYWRsaTJjLmlBZGRyZXNzID0gMHhiNA0KPiA+ID4gPiA+ID4gYWRsaTJjLmlT
cGVlZCA9IDEwMA0KPiA+ID4gPiA+ID4gMCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiA+ID4gRGV2IDA6IEFETF9EaXNwbGF5X1dyaXRl
QW5kUmVhZFNNVUkyQygwLCAmYWRsaTJjKSA9IDANCj4gPiA+ID4gPiA+IGFkbGkyYy5pRGF0YVNp
emUgPQ0KPiA+ID4gPiA+ID4gMjQgaTJjRGF0YVswXX5bMjRdDQo+ID4gPiA+ID4gPiA0MCA1MSAy
YyAwMSAwMCAwMCBmZiAwMCBmZiBmZiBmZiBjYyAwMCBjYyAwMCAwMCAwMCBmZiBmZiBmZiBmZg0K
PiA+ID4gPiA+ID4gZmYgZmYgZmYNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBGcm9tIHRoZSBS
R0IgYXBwJ3MgbG9ncyB0aGlzIGlzIGFuIGV4YW1wbGUgb2Ygd2hhdCB0aGUNCj4gPiA+ID4gPiA+
IG9mZmljaWFsIEFNRCBhcHBsaWNhdGlvbiBvbiBXaW5kb3dzIGlzIHNlbmRpbmcgd2hlbiBpdCBj
aGFuZ2VzDQo+ID4gPiA+ID4gPiBjb2xvcnMgb24gdGhlDQo+ID4gUkdCIHN0cmlwLg0KPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+IEZyb20gdGhpcyBjYW4gaXQgYmUgYXNzdW1lZCB0aGUgQU1EIGNh
cmQgaXMgdXNpbmcgdGhlIGxhdHRlcg0KPiA+ID4gPiA+ID4gbWV0aG9kIHlvdSBtZW50aW9uZWQg
d2l0aCB0aGUgc2Vjb25kIFNNVSBJMkMgYnVzLCBpbiB3aGljaA0KPiA+ID4gPiA+ID4gY2FzZSBu
byBkcml2ZXIgY2hhbmdlcyB3b3VsZCBiZSBuZWVkZWQ/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJ
SVJDLCBlYWNoIEFJQi9PRU0gdXNlcyBpdHMgb3duIHByZWZlcnJlZCBSR0IgY29udHJvbGxlci4g
VGhlDQo+ID4gPiA+ID4gcmVmZXJlbmNlIGJvYXJkIGp1c3QgZGVmaW5lcyB3aGljaCBpMmMgYnVz
ZXMgY2FuIGJlIHVzZWQuIFRoZQ0KPiA+ID4gPiA+IFJHQiBjb250cm9sIGFwcGxpY2F0aW9uIGlz
IGp1c3QgYSB1c2Vyc3BhY2UgYXBwIHByb3ZpZGVkIGJ5IHRoZQ0KPiA+ID4gPiA+IEFJQi9PRU0g
dGhhdCBjYWxscyBBREwgdG8gdGFsayB0byB3aGljaGV2ZXIgaTJjIGJ1cyB0aGUgdmVuZG9yDQo+
ID4gPiA+ID4gcHV0IHRoZWlyIFJHQiBjb250cm9sbGVyIG9uLiBPbiBMaW51eCB5b3UgY2FuIGRv
IHNvbWV0aGluZw0KPiA+ID4gPiA+IHNpbWlsYXIgdXNpbmcgdGhlIGkyY19kZXYgbW9kdWxlIHRv
IG9wZW4gYSBjb25uZWN0aW9uIHRvIHRoZSBpMmMNCj4gPiA+ID4gPiBidXMgZHJpdmVyDQo+ID4g
cHJvdmlkZWQgYnkgdGhlIGtlcm5lbC4gSSBiZWxpZXZlIHRoYXQgaXMgd2hhdCBvcGVuUkdCIGRv
ZXMgdG9kYXkuDQo+ID4gPiA+ID4gSXQgbG9va3MgbGlrZSB5b3UgYWxyZWFkeSBoYXZlIHRoZSBw
cm9ncmFtbWluZyBzZXF1ZW5jZSBhYm92ZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEFsZXgNCj4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gT24gTW9uZGF5LCBKYW51YXJ5IDh0aCwgMjAyNCBhdCA1OjMy
IFBNLCBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPiA+ID4gPiA+IEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20gd3JvdGU6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBbUHVibGljXQ0KPiA+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
PiA+ID4gPiA+ID4gRnJvbTogYW1kLWdmeCBhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnIE9uDQo+ID4gPiA+ID4gPiA+ID4gQmVoYWxmIE9mIEFsZXhhbmRlciBLb3Nrb3ZpY2gN
Cj4gPiA+ID4gPiA+ID4gPiBTZW50OiBTdW5kYXksIEphbnVhcnkgNywgMjAyNCAxMToxOSBQTQ0K
PiA+ID4gPiA+ID4gPiA+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+ID4g
PiA+ID4gPiA+IFN1YmplY3Q6IERvY3VtZW50YXRpb24gZm9yIFJHQiBzdHJpcCBvbiBSWCA3OTAw
IFhUWA0KPiA+ID4gPiA+ID4gPiA+IChSZWZlcmVuY2UpDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+ID4gPiBIZWxsbywNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IEkgd2Fz
IHdvbmRlcmluZyBpZiBBTUQgd291bGQgYmUgYWJsZSBwcm92aWRlIGFueQ0KPiA+ID4gPiA+ID4g
PiA+IGRvY3VtZW50YXRpb24gZm9yIHRoZSBSR0Igc3RyaXAgb24gdGhlIHJlZmVyZW5jZSBjb29s
ZXINCj4gPiA+ID4gPiA+ID4gPiAoaHR0cHM6Ly93d3cuYW1kLmNvbS9lbi9wcm9kdWN0cy9ncmFw
aGljcy9hbWQtcmFkZW9uLXJ4LQ0KPiA+ID4gPiA+ID4gPiA+IDc5MDB4dHgpPw0KPiA+ID4gPiA+
ID4gPiA+IEl0DQo+ID4gPiA+ID4gPiA+ID4gbG9va3MgdG8gYmUgaGFuZGxlZCB2aWEgSTJDIGNv
bW1hbmRzIHRvIHRoZSBTTVUsIGJ1dA0KPiA+ID4gPiA+ID4gPiA+IGhhdmluZyBwcm9wZXIgZG9j
dW1lbnRhdGlvbiB3b3VsZCBiZSBleHRyZW1lbHkgaGVscGZ1bC4NCj4gPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ID4gSXQgZGVwZW5kcyBvbiB0aGUgQUlCL09FTSBhbmQgaG93IHRoZXkgZGVzaWdu
ZWQgdGhlIHNwZWNpZmljDQo+ID4gPiA+ID4gPiA+IGJvYXJkLiBUaGUgUkdCIGNvbnRyb2xsZXIg
d2lsbCBlaXRoZXIgYmUgYXR0YWNoZWQgdG8gdGhlDQo+ID4gPiA+ID4gPiA+IEREQ1ZHQSBpMmMg
YnVzIG9uIHRoZSBkaXNwbGF5IGhhcmR3YXJlIG9yIHRoZSBzZWNvbmQgU01VIGkyYw0KPiA+ID4g
PiA+ID4gPiBidXMuIFRoZSBmb3JtZXIgd2lsbCByZXF1aXJlIGNoYW5nZXMgdG8gdGhlIGFtZGdw
dSBkaXNwbGF5DQo+ID4gPiA+ID4gPiA+IGNvZGUgdG8gcmVnaXN0ZXIgZGlzcGxheSBpMmMgYnVz
ZXMgdGhhdCBhcmUgbm90IHVzZWQgYnkgdGhlDQo+ID4gPiA+ID4gPiA+IGRpc3BsYXkgY29ubmVj
dG9ycyBvbiB0aGUgYm9hcmQgc28gdGhleSBjYW4gYmUgdXNlZCBieSAzcmQNCj4gPiA+ID4gPiA+
ID4gcGFydHkNCj4gPiBhcHBsaWNhdGlvbnMuDQo+ID4gPiA+ID4gPiA+IEN1cnJlbnRseSB3ZSBv
bmx5IHJlZ2lzdGVyIGkyYyBidXNlcyB1c2VkIGZvciBkaXNwbGF5IGNvbm5lY3RvcnMuDQo+ID4g
PiA+ID4gPiA+IFRoZSBsYXR0ZXIgYnVzZXMgYXJlIGFscmVhZHkgcmVnaXN0ZXJlZCB3aXRoIHRo
ZSBpMmMNCj4gPiA+ID4gPiA+ID4gc3Vic3lzdGVtIHNpbmNlIHRoZXkgYXJlIHVzZWQgZm9yIG90
aGVyIHRoaW5ncyBsaWtlIEVFUFJPTXMNCj4gPiA+ID4gPiA+ID4gb24gc2VydmVyIGFuZCB3b3Jr
c3RhdGlvbiBjYXJkcyBhbmQgc2hvdWxkIGJlIGF2YWlsYWJsZSB2aWENCj4gPiA+ID4gPiA+ID4g
c3RhbmRhcmQgTGludXggaTJjIEFQSXMuIEknbSBub3Qgc3VyZSB3aGF0IGkyYyBMRUQNCj4gPiA+
ID4gPiA+ID4gY29udHJvbGxlcnMgZWFjaCBBSUIgdmVuZG9yIHVzZXMgb2ZmIGhhbmQuDQo+ID4g
PiA+ID4gPiA+IGh0dHBzOi8vb3BlbnJnYi5vcmcvaW5kZXguaHRtbCB3b3VsZCBwcm9iYWJseSBi
ZSBhIGdvb2QgcmVzb3VyY2UNCj4gZm9yIHRoYXQgaW5mb3JtYXRpb24uDQo+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+IEFsZXgNCg==
