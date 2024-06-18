Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE878C41513
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 18:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8E110E1C6;
	Tue, 18 Jun 2024 18:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C1pNC2AF";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C514910E1C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 18:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSVA/m55DUz1m+7vtYSBWBimyJ4nc3MqesdrUNyyQOFIH5BTmSdwoKCY5hr12KlpMc4GPUQk/eDxbs1RB+Dv9GIcjnmxQM3wv8zzojLU7+Dt/uUa1qbIb6EaSr5BD7NlBfmvQOW4OLl7lLNIFHkg4lJuuShWUGN8uRtpZmmIdu9I3gInJgdIM+7UF/+1V4zrTMLTHrE2Cin5/35iyReAXojqZMwvDAtZ0cbuDl3oTG51cHipL35I1HPScoXeZ6JzBBhaoFMswh/aYnJu3OoRQFIdpeylUR6vty/brYm4sx/aN+CoJPEhN//GGhP2mZRYPogBUDxFBHcKppdrlyK6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osTpfr+hIcCdZ3SXzL2mTRUvdaqHzmizaMsMdfVXvgE=;
 b=X/uQg5eSmM9WAYiJVbfIfbinPNY/ygZd99TORGZQTt7Q89k6ipX3K0XQW6rpDBjR1WD/cUaAn+/iu8w7fjP140dGlxQfhuXAPRhmCDjP7F5EnzvmQ6uevxow6rdE4y5jFBXLrnKENIbM6cu1HCsaNaADtPFF31z+UUWw+x7E/XP53tQd9l57IjIx1q7BdVMg24mMwtG+rB8ACJvxFzTSS1q0B/BKw5O9cTIoJcVBpSbVrVMNs2qu2zWtlUdMgwSANhBXkTMtdjjoZMssCeMepfN5g6BOCfsV6/fWrsdwAacq3wrieiUPMA/m6zNORHTq7mkzTyhbUEHYKqqIPHmLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osTpfr+hIcCdZ3SXzL2mTRUvdaqHzmizaMsMdfVXvgE=;
 b=C1pNC2AFdzm1t8Ghg/rKx+Fn3XoOrTFzBRyNChvR3u1gu1TGaDnrVFzhJnIDyxOGQkETtkgB8xDQyCXCENOikOwhGTaSRL7a+CS4xQNRfJ9YSBU57so3CZSBYQCfv0rKFfE1TFRlnvJxxG61At7byClL72FcmKUtqUMoNC2ilsY=
Received: from SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 18:04:08 +0000
Received: from SJ1PR12MB6316.namprd12.prod.outlook.com
 ([fe80::655b:63e9:1a28:ae65]) by SJ1PR12MB6316.namprd12.prod.outlook.com
 ([fe80::655b:63e9:1a28:ae65%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 18:04:08 +0000
From: "Slivka, Danijel" <Danijel.Slivka@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Chen, JingWen (Wayne)" <JingWen.Chen2@amd.com>, "Zhou, Peng Ju"
 <PengJu.Zhou@amd.com>
Subject: RE: [PATCH] drm/amd/pm: check whether smu is idle in sriov case
Thread-Topic: [PATCH] drm/amd/pm: check whether smu is idle in sriov case
Thread-Index: AQHawY71jaRVwZjzQUChFtvnwCrUlbHNot2AgAArfsA=
Date: Tue, 18 Jun 2024 18:04:08 +0000
Message-ID: <SJ1PR12MB631616155829D43E44CC965798CE2@SJ1PR12MB6316.namprd12.prod.outlook.com>
References: <20240618145944.95640-1-danijel.slivka@amd.com>
 <PH7PR12MB59976AE8297422B6EBB712C282CE2@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59976AE8297422B6EBB712C282CE2@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e6f7c535-c74b-44a9-b828-ad5a26b27fbf;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-18T17:55:42Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6316:EE_|LV8PR12MB9405:EE_
x-ms-office365-filtering-correlation-id: 9055b5a9-e74b-4d2b-ca41-08dc8fc10ca0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?iso-2022-jp?B?dnhtOXhGY2UrbE5BQmtFcndONnpET0Y4NWZOVUdTeHJzaE5iWVlMYkFa?=
 =?iso-2022-jp?B?WVljRmZJTWgyMktrRUMxMWk0ajFvZ2habEw1dUtxL3paeXAxeHRMU2pn?=
 =?iso-2022-jp?B?ZlBGY3hLeWpHVTFXZ3UxbU1MbTE1eFlWR1FFaWEwS211MWtuU21sL0Iw?=
 =?iso-2022-jp?B?QUtLVkx1WWpFT2xDNGJHS0g2ai9iLzdsZklyU1k2NXdxMU1sVTNsSzI2?=
 =?iso-2022-jp?B?ZG5ZQlJSb0tEMmNuMDN5YWptUXhvWm1sUkFGT3RXTS9JM0Ewcld5Z2ti?=
 =?iso-2022-jp?B?WGVmUDkzV1Awc0xvYnYzcmI3VEpWWFpaVFZBaTI4OG1XekswUkZJMmxm?=
 =?iso-2022-jp?B?RkorYUlwWGV0aVh0R1YzT0IwbVA1dkttNVNUZENDbllZUm9BbGxSSEIv?=
 =?iso-2022-jp?B?emRGV2xpNGdrWDgxSkdGZU1UK3BGaWpoTnpLRTczRVFaekVCRklFeURx?=
 =?iso-2022-jp?B?d2lXaW1CdzJDYXo0clBwZHo0ZTZ1djVrWjdEMmt3bVZhVGhNWHBTcE5Z?=
 =?iso-2022-jp?B?b21kOU9pRFZySERTRHFBQmpEbzhuTmVZa3hmQWo4Y2I2ZU4xYjFBZDR5?=
 =?iso-2022-jp?B?TWNXc0VkdVFGR2VNTStOdGh5bk5BODY5RnBUU2lwdnVnWFZ2anpZYXo5?=
 =?iso-2022-jp?B?Q3NvTVErYktFYVhidVJSVXd5c1pZaEE5UzIzQno1ako5L2d1S3J2M1Ar?=
 =?iso-2022-jp?B?ekpJMzNNeHpwOVBuTkpKTmloQk51QmcvRXdJTG9PcUdKVmZXV2t3TUZZ?=
 =?iso-2022-jp?B?UXhaNlhuYlRnY21kVHlCcS90b2NScnE4Z084N05jb3EzTzhEaWJTaXhu?=
 =?iso-2022-jp?B?STlhb2g4WnNielZVZmhqRjd3RUpkR1JZTEFUWUxia1V6Y1RvQ21Na0M2?=
 =?iso-2022-jp?B?QnV4b2ZSNmg5bVVSSXpaeGt2Q2VRQm56blMvRzJXYnV6NGNULzBLMHdU?=
 =?iso-2022-jp?B?QThUUk9VL25Mb0h2UzRQdkxqZE1ySVNuMDZaWEFhOFZQczdvSS9nYnJs?=
 =?iso-2022-jp?B?V2pzVzkzTER0UzNISG9iZ2FNZlZSc2h2N2gvWklIdXNoK3Zxcm9USGVM?=
 =?iso-2022-jp?B?NDRHd0xqQjdqZlpsdExieFBUMFZpb2JMSWZEeHd1dlJlamduUDY0UDhF?=
 =?iso-2022-jp?B?bTl2NHM1SkdHZS9SQjhWTWV3dU5GV2ZEaHJZVXVMSjhISkZ4dE9YZ1JX?=
 =?iso-2022-jp?B?Q1NabSttN1FLU0FENkN2VzZsN3pmaFRSak5PaWtXYk9XekFsQ3g3bGds?=
 =?iso-2022-jp?B?VFBjcFlMMENOMWtpZ3FlcU9mRnN0U1kvTFJ0cmhNYkU4WDgzYUlqSGlz?=
 =?iso-2022-jp?B?S0hVMG1vd1AxVnB6ek5Lb3ZSUUtKN2FoeFZkUVQwMXhhQ2E0ZXBjME5R?=
 =?iso-2022-jp?B?dUZNMkZwcDl3a1RtOWdjamg3L1JHRXEwL2ZKWDFwSTJ2NUxBOUs2Mjly?=
 =?iso-2022-jp?B?MytnejhWSjVYaWlMbVhJVHFCMTdmWkZva1RqNFdMZCt2OFpRcDd6a2hu?=
 =?iso-2022-jp?B?ZFJSSEpGLzExNUR1bnVRRHFoc0Z0WW1DMVk3WjJnVk11d2djREtSWmNB?=
 =?iso-2022-jp?B?WE0xMkI5cGRCbkVybUpyQ0VHVmtxVllhYm1yTlRKSU5NK2hvMWxOS1Jv?=
 =?iso-2022-jp?B?UnU3Q1U1SkNSdDFNSjhxSEhuaE5MSUdNWjdtcVRUM1ZuR1FwQkxqb0Zz?=
 =?iso-2022-jp?B?ZG1rbUFIWGdiaDZXZURYeThUOHRMTitZbnNubzA3M3ZSVHFoREFYdTN4?=
 =?iso-2022-jp?B?R05xTWNseDlJVTBaWkV3UThyL0VDN1AvWGhTb3FTcVZlYmgrZlM4OUNu?=
 =?iso-2022-jp?B?YnRhZEo3YnlKeGx3d2w4WEtySkxuQVlqRnRRYnZwQUh1ZWh0bm9POWFi?=
 =?iso-2022-jp?B?c1ZHckNFYytmakxydDdrcTZxVE5CQ0ZMSDdqSzVTOE51Wk1hclNMVW9G?=
 =?iso-2022-jp?B?VFZ4bDd5QldzRDdOcTdTSEVLUXRSUzBhNEZUdHN5UDYrTVFGS1BWUHRj?=
 =?iso-2022-jp?B?Zz0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6316.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VENBNkFlWVd5NkgxUGhNS1VJd3l5S29Fbmc5Qm1TS2t2TUQreGlNcUxJ?=
 =?iso-2022-jp?B?WnVhbVNhOVFsWlhGRDQ0Smk3aUFiOFVidEVWUnBDdDZRTkk5ckl6QUV3?=
 =?iso-2022-jp?B?Rm5wMXJ5VlFOMTRGL0xFUFYxL1NjMFpBUkRvYmw0R1FTNXFWT1ppek9O?=
 =?iso-2022-jp?B?ZEErVjJ5Rm1OUHRnMXZ1bUJoVXBCSTJGQzA1WlVXR0t3UnpCYWowbTNz?=
 =?iso-2022-jp?B?bGJTU0M3UlZ4a3RjYUUvR21DZ2VsTjkzNHl2RncyREk0cUlOYW1TbEZD?=
 =?iso-2022-jp?B?TVVhMm9VaFZvKzMzeW9oelZteUFEcXU0bTIvVGlaQTJ0MmpNRkROYk5T?=
 =?iso-2022-jp?B?TytsMkpnelZvYUZyKzVEbW9MTTdFMWZhUEdxdFlucGo0bUVUTFpwaGFP?=
 =?iso-2022-jp?B?UmwxQjJFQXhrL0VEYmhOcmcyUlcvbmUxV0J0NHBtNkdRR0VHUlhpNzQ0?=
 =?iso-2022-jp?B?TVBaaEtiQXYyQW1pWE9Cb1J6M2liOGdOQmRZWnB4UjVuK0Ria2ZIZElM?=
 =?iso-2022-jp?B?dnhXVTNzcHg2MzdRYWs5RFBOUTJVeUU3UEZUU1F0SGJUcWRPQllYYkFj?=
 =?iso-2022-jp?B?bk44c0hMcmF0Rk5KaURlQVpPWmM1VU9rVStSWnk5QnRTOGYybzgzNTJW?=
 =?iso-2022-jp?B?dndPUkxlQ2FiLzFwSFAyWS9HSkNrQ3o0QzhEOHlYWURiN0x0MWsxMk5h?=
 =?iso-2022-jp?B?NU1FQVZnUGRDbmMwWENWUVpYRXZQa1I0UWJFRUc2a1I4VTdmakNzbDdD?=
 =?iso-2022-jp?B?djMzQnNrRWVGa05vVWpCZ3VwdC9sREZrUkw5V1R6RFRMNDczeTNZSloz?=
 =?iso-2022-jp?B?aTRrQ0dXWks5c084dnF5TXJ4QVZhZjRRbzZvVngvT1N2UTdxZzE2dDFI?=
 =?iso-2022-jp?B?RzV2NC9XWU82c2YvS1FXVkFpdEdwVUhrcUNMcHZtRGl0eTI5aUtOdlpm?=
 =?iso-2022-jp?B?L0F3eGVvZ3ZuOXV6dmJ6ZWJ1aWJ4RnZZZjF2WjFHeXN3QzR0cUZEcUda?=
 =?iso-2022-jp?B?RHVnMmg2d2VMVmE1L0tCZ3cvQTFQWnBQOENIODg5YU5XV05yYjA2Z0hB?=
 =?iso-2022-jp?B?a3hVaTdUTGhmay9QWVoxT2N6WE1ZTVhGVHBVVkRqbkxvRDUrMEliZ0lJ?=
 =?iso-2022-jp?B?RlNNcWQrVW84ZjdWcmJacVFLamQ2WmdlbXhtWkZwVEdmTWZ0bEpmbzBV?=
 =?iso-2022-jp?B?c2xnUHhNZ0RjTFhUa2p4QVBkUjYrWHpWV0ZRSUt6eTA1MExjOVVXalhX?=
 =?iso-2022-jp?B?NHJrUWRFWFdHT0cwaFR2WUh2amV4K0Y5US84NjRLendSZTc1bG1OTllm?=
 =?iso-2022-jp?B?MnZ5NFpURmptYndua2Rqa29ZZkNjZDFkbmZWTlUzRVJzRXArY0s1aDVt?=
 =?iso-2022-jp?B?S1JTckdOWTZRdDgrNHJJQWRLaXRSUkFJcmxDT0hqbTVzNXhHblQrZWdp?=
 =?iso-2022-jp?B?N3ZXZ2sycnJwNDkvdmVxSisvRWt6bVVZKy9IdkM4SXZWWVByZHdKR2Rr?=
 =?iso-2022-jp?B?NXBNbGFlZTNEWUU4QnZBOHIvMTduSlQ4cVVzZHpyWmVVaUgrRk13aEpV?=
 =?iso-2022-jp?B?Z3VZWkMwVEFSK1RCVXprV3RyNkV2SDQySmdZaC9GM1ltNHVrNkhrVmVC?=
 =?iso-2022-jp?B?NTRPaTJJbk8zbWpOMndyQmNoWE9DT2wwUG9RNHFHVktjQlRJeGtQRlNw?=
 =?iso-2022-jp?B?L3BpL21qZHJZZkdSRXJRLzFrREtFV1JNbEo5Uk5aM1I3ZXRKbW94ZnJl?=
 =?iso-2022-jp?B?QUxnN3UwQkQzZ04wZHZrNkUrcXdNcmEvdjY4SDZKTDB5Nzd4Kzk0VHl1?=
 =?iso-2022-jp?B?R0IrMVFXRnR6UVdZOFhaQ0hXSjFRQlpEdUs4dTJrL0UxN0R1WHBYT3dX?=
 =?iso-2022-jp?B?eWlDWWtWNGlLL3hLNVd0Tkd5Rkh1SnJoTTZ5SDg5RzYzOTRYWS9VQURI?=
 =?iso-2022-jp?B?c0lFcWFsUEJNRDFOUGNVT1dYT3FxS2hqUlU5Ujg0MkpQREtGQnhaVnJO?=
 =?iso-2022-jp?B?UlROZlFaVUxzMjI5d1k1bis1dzlEaHlYM294Ris1SUFYVWJETVdHdW16?=
 =?iso-2022-jp?B?cUJ4ajFnQWswWm0wVTU2TGxaTDA2THVYM0ZFZ3dvV1hCTi9CYkY3WHk4?=
 =?iso-2022-jp?B?SkdMTHFLbFplaWJYUHo0aGo3b3lkWDhQc1BBTTNlQWMzQ0oycGRIS1FJ?=
 =?iso-2022-jp?B?Z2RPV0pvUlNBcitxQkp5RG8wZlA4VGllY01EbGl1aDBmWXJIaHF5dnRI?=
 =?iso-2022-jp?B?a0FGSW9nVEZmajhRak1QQUxydGZpT3hYUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6316.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9055b5a9-e74b-4d2b-ca41-08dc8fc10ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 18:04:08.2665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+cbWw1KnziSLKEMVnPgsTWIPCFH0/4LzMf9oPb9DSogSI2kWk3KxeCRvJ7R0fYlIzlHqClPrCt9M0pCilHtqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405
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

[AMD Official Use Only - AMD Internal Distribution Only]

I tried to set the C2PMSG_90 register to 1 on the PF side ( after receiving=
 command for request GPU init from VF) and from PF side this value is set t=
o 0x1 but from VF side the register still reads the old value.


BR,
Danijel

>-----Original Message-----
>From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
>Sent: Tuesday, June 18, 2024 5:20 PM
>To: Slivka, Danijel <Danijel.Slivka@amd.com>; amd-gfx@lists.freedesktop.or=
g
>Cc: Slivka, Danijel <Danijel.Slivka@amd.com>; Chen, JingWen (Wayne)
><JingWen.Chen2@amd.com>; Zhou, Peng Ju <PengJu.Zhou@amd.com>
>Subject: RE: [PATCH] drm/amd/pm: check whether smu is idle in sriov case
>
>This looks more like a workaround.
>Can we write the C2PMSG_90 register to 1 on the PF side when host receive
>GPU_RESET/GPU_INIT request command?
>
>Best Regards,
>Kevin
>
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Danijel
>Slivka
>Sent: 2024=1B$BG/=1B(B6=1B$B7n=1B(B18=1B$BF|=1B(B 23:00
>To: amd-gfx@lists.freedesktop.org
>Cc: Slivka, Danijel <Danijel.Slivka@amd.com>; Chen, JingWen (Wayne)
><JingWen.Chen2@amd.com>; Zhou, Peng Ju <PengJu.Zhou@amd.com>
>Subject: [PATCH] drm/amd/pm: check whether smu is idle in sriov case
>
>Why:
>If the reg mmMP1_SMN_C2PMSG_90 is being written to before or during
>amdgpu driver load or driver unload in sriov case, subsequent amdgpu drive=
r
>load will fail at smu hw_init.
>The default of mmMP1_SMN_C2PMSG_90 register at a clean environment is
>0x1, and if value differs from 0x1, amdgpu driver load will fail.
>
>How to fix:
>This patch is to check whether smu is idle by sending a test message to sm=
u. If
>smu is idle, it will respond.
>This will avoid errors in case mmMP1_SMN_C2PMSG_90 is not 0x1
>eventhough smu is idle.
>
>Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
>Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
>Signed-off-by: pengzhou <PengJu.Zhou@amd.com>
>---
> .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 17 ++++++--
> drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 42
>+++++++++++++++++++
> drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 ++
> 3 files changed, 58 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>index e17466cc1952..dafd91b352ec 100644
>--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>@@ -231,6 +231,7 @@ int smu_v13_0_check_fw_status(struct smu_context
>*smu)  {
>       struct amdgpu_device *adev =3D smu->adev;
>       uint32_t mp1_fw_flags;
>+      int ret =3D 0;
>
>       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
>       case IP_VERSION(13, 0, 4):
>@@ -244,11 +245,19 @@ int smu_v13_0_check_fw_status(struct
>smu_context *smu)
>               break;
>       }
>
>-      if ((mp1_fw_flags &
>MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
>-          MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT)
>-              return 0;
>+      if (!((mp1_fw_flags &
>MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
>+          MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT))
>+              return -EIO;
>+
>+      if (amdgpu_sriov_vf(adev)) {
>+              ret =3D smu_cmn_wait_smu_idle(smu);
>+              if (ret) {
>+                      dev_err(adev->dev, "SMU is not idle\n");
>+                      return ret;
>+              }
>+      }
>
>-      return -EIO;
>+      return 0;
> }
>
> int smu_v13_0_check_fw_version(struct smu_context *smu) diff --git
>a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>index 5592fd825aa3..de431c31ca7f 100644
>--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>@@ -359,6 +359,48 @@ int smu_cmn_wait_for_response(struct smu_context
>*smu)
>       return res;
> }
>
>+/**
>+ * smu_cmn_wait_smu_idle -- wait for smu to become idle
>+ * @smu: pointer to an SMU context
>+ *
>+ * Send SMU_MSG_TestMessage to check whether SMU is idle.
>+ * If SMU is idle, it will respond.
>+ * The returned parameter will be the param you pass + 1.
>+ *
>+ * Return 0 on success, -errno on error, indicating the execution
>+ * status and result of the message being waited for. See
>+ * __smu_cmn_reg2errno() for details of the -errno.
>+ */
>+int smu_cmn_wait_smu_idle(struct smu_context *smu) {
>+      u32 reg;
>+      u32 param =3D 0xff00011;
>+      uint32_t read_arg;
>+      int res, index;
>+
>+      index =3D smu_cmn_to_asic_specific_index(smu,
>+                                             CMN2ASIC_MAPPING_MSG,
>+                                             SMU_MSG_TestMessage);
>+
>+      if (index < 0)
>+              return index =3D=3D -EACCES ? 0 : index;
>+
>+      __smu_cmn_send_msg(smu, index, param);
>+      reg =3D __smu_cmn_poll_stat(smu);
>+      res =3D __smu_cmn_reg2errno(smu, reg);
>+
>+      if (unlikely(smu->adev->pm.smu_debug_mask &
>SMU_DEBUG_HALT_ON_ERROR) &&
>+          res && (res !=3D -ETIME)) {
>+              amdgpu_device_halt(smu->adev);
>+              WARN_ON(1);
>+      }
>+
>+      smu_cmn_read_arg(smu, &read_arg);
>+      if (read_arg =3D=3D param + 1)
>+              return 0;
>+      return res;
>+}
>+
> /**
>  * smu_cmn_send_smc_msg_with_param -- send a message with parameter
>  * @smu: pointer to an SMU context
>diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>index 1de685defe85..486acfc956a5 100644
>--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>@@ -51,6 +51,9 @@ static inline int pcie_gen_to_speed(uint32_t gen)  int
>smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>                                    uint16_t msg_index,
>                                    uint32_t param);
>+
>+int smu_cmn_wait_smu_idle(struct smu_context *smu);
>+
> int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>                                   enum smu_message_type msg,
>                                   uint32_t param,
>--
>2.34.1

