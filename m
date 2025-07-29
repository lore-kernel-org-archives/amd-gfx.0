Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20778C83F26
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 02:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E0E710E1B3;
	Tue, 29 Jul 2025 02:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WQvoaimU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC39E10E1B3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 02:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yyh6yHOy5zCbLdO1dfSdQvIcy3gMGJYKx9FTNS0Z47HnttAl/h7Dy2yAeY0tuaSkEBzfVcaYmZlfe6WdqfzB5bNZLfJ0bOsdr4Kqp1+IjiFlPhPuUT/yGGN0yi809RZjMrjMTO2M1zDmFO3Vbjv1E407/8+Na+xv+3/osuwpgiHAxmgs/WisNwVr0AklaJadKzjipwumo2ETyBrhXOtj9yYoLS7lCreiUzqTzKBxyd+opbYF0nQCYmiSdvqVs2UVgSRgFCLH6CgX5BTvNVUU13w8JpN9SdiyJ8Hv0QV0S5KraiMlvqwBmvNdIatIaZw9WYgfbqku91z2tCJQ1JS/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FHJLQUoOuPIkCyG4Bl+yUxtHK3S/BA//5z+rc66ibI=;
 b=j1XYflznURvxOlcwSXUXQuZi2mvCEpe8e+YEp0es6p4hGGRTjPyP1kVzm2FgwoYd8dnJ/EVyxLDKOysLVzhrGbmDwLsBkS5o9A/+6viofeuuW8bvKp9u66oVwuPIN398DZYoAgrAktZCxrNAs8DBQ++cts7SyUZs6tIPNu5V5f9rIA8JP6hixRq/Ef2iwDkQnRrZC/zaltCHJPTeCMwDc51cYp+4ekNwyku2zawZORtjrOIdiaDWTW/inFsre+tvqhkC5ExlcbXToVzLwiBfFXOOOAZXg9WpIdB0ckk2DcWKLx/7cpvMstzPJEErPuaDjtmHnd2UU9Ptpxf3lxEcVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FHJLQUoOuPIkCyG4Bl+yUxtHK3S/BA//5z+rc66ibI=;
 b=WQvoaimU2ex2HxaJBuuvM3fgt8P8dIMG/SCXSBklJ542P5LwHsGPRYBCHdDqrcnK7E+3TFdz7BSIvkFG9Wihr4XRv5raPKz78k+b0mh0frgmF5xgP1iTVQQAYbR31xwoPGU1/wiAE19HnkZwZ+7PH/2qNaXwd1FSwiiOhaO3e4I=
Received: from PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 02:41:08 +0000
Received: from PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::dd32:9eed:14e9:33f1]) by PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::dd32:9eed:14e9:33f1%6]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 02:41:08 +0000
From: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "cao, lin" <lin.cao@amd.com>, "Zhang,
 Tiantian (Celine)" <Tiantian.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: keep job->vm in amdgpu_job_prepare_job
Thread-Topic: [PATCH] drm/amdgpu: keep job->vm in amdgpu_job_prepare_job
Thread-Index: AQHb+7EcoCXofQ9OfkW7m4hre0+GirRHQr2ggACbcwCAAIv0sA==
Date: Tue, 29 Jul 2025 02:41:08 +0000
Message-ID: <PH0PR12MB5420F3163B34DB33AF74B6D9E025A@PH0PR12MB5420.namprd12.prod.outlook.com>
References: <20250723090624.53536-1-YuanShang.Mao@amd.com>
 <PH0PR12MB5420F1D3878389D200D4E419E05AA@PH0PR12MB5420.namprd12.prod.outlook.com>
 <CADnq5_MBSe2tuczKGwigygErxYUXg=O+H63NcnFnMd_C0qLwpA@mail.gmail.com>
In-Reply-To: <CADnq5_MBSe2tuczKGwigygErxYUXg=O+H63NcnFnMd_C0qLwpA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-29T02:30:35.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5420:EE_|SJ0PR12MB6854:EE_
x-ms-office365-filtering-correlation-id: 961eead7-f84f-4448-227b-08ddce495f3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aFNmLytadUdVQ2JzZmVwdmpjQ0V4QUs2OG5maXdnS29IL3pKZWVUU29SUkpB?=
 =?utf-8?B?MTlBcmduc2ppYk5uSWRXRTd6aVlqclMrd2E4SUF5T0VSME0wV2huRlYwZ0c4?=
 =?utf-8?B?LzZQemhURG9rTGswT3NhaHVnVUJ2dWc5Y1lRRWptaytWRGZaRC8xT2hHaDFO?=
 =?utf-8?B?UHcrdnlXTVBTb05vNWpMY2o2dkh2a1Q2WVJSZTd3N2w4L2V6TVV3U2dkdjl0?=
 =?utf-8?B?TlpJRnR0Mk5hZHZXZTZ2bExxY2MyKzVDTktjczRJZnNiN3BjY3JPQ2NPL2c1?=
 =?utf-8?B?T3RtT25pL2pCeFRteDA0YWtnTU1qMGZnbktxL1pLZWZaZkhEcVI1S1BEUU9W?=
 =?utf-8?B?ald3ampxbFdFVTNGTmxtR1U0N3pvQUxFLzczM0J5UGFvWXBtbVhzbkxXTWhG?=
 =?utf-8?B?bUx5Z3h4TVpVT2hUZWNRK1hUYWtPSE9lV2VVYWQ4TGJGd1dvU2JDRWp1VGxr?=
 =?utf-8?B?Wmh4WTlOcDF5cDFjb0ZxaDlweG5wWm5PMGh6anlwM3pEUmJvdW44bnl6ZXQw?=
 =?utf-8?B?S2djdjYrMlJ4SFFuUU1CRURuaWw5RU85a3FBdWN3eW1lZUtoNE14SXlHUFVk?=
 =?utf-8?B?VUlhdkpRdStMVG9XZVFqVUtLc0F0a0Z3UEVVQ0MwN1ZhTHNJTjRTL3dtbUkw?=
 =?utf-8?B?UDg5RDZUaUpFU0JDL243U2x5bHFjcjRXSmM1bTZEQ1hwOU1MNVpIRjdGcHM2?=
 =?utf-8?B?N2w4ZFBmOFVLQVYvNjhpL24rNGplZ3Y1OXVWeE92UURvRGhlcG85dENSOEpt?=
 =?utf-8?B?VXVZQmdWRDEwd2F1S2tUWnRqS1JHbml2UkRpb0I5d3pFbHBSNkpGS0g3SEJG?=
 =?utf-8?B?QlB3TjJtTlBpa0w2UURFYmdLWlJ5M3p2dXd2bVFWSlNqeHhKRkxWbHFucW45?=
 =?utf-8?B?a1BmVUxONUpteldIbEJXenc3ZGhWdjdBd2VrVjVQa3loZ25wRzlDbHNIVjA0?=
 =?utf-8?B?endZdUlLRkN4S1lRNGxxRXR0SzBobXVBSGJmODA2SVdjTjlzczY1U2JkWi9J?=
 =?utf-8?B?aFZGQ2NseWlBRFJsbXZiRFF5Y3BnSGpabHpiNEMyOXlLelRtUlBtdm5RbUY0?=
 =?utf-8?B?LzVBUVVHU202N3ZxcGkxS3lKTjc1WUhiY0J2cGtCeHd5azVibDNzdjJaaSs2?=
 =?utf-8?B?NkVGallLeENncDV0L0tpa3I2d0R1MWU4aXZ5TGRvTTd3T3dnQVcyeEs2Zzk3?=
 =?utf-8?B?c2huTzlYeCt6VVk3azUzanZLMDYvN2V3MFl2SVpLZDFrNDZ1UVN3V3UyYmNE?=
 =?utf-8?B?NjRSclhTQjFMOGxFNnpnWk9vNVFCVmFsdS9DVytFSVpQMHQydjJKbkZLMUlw?=
 =?utf-8?B?RUhrTlcxdzg4dktWZmVVbUJCNThVbFZpT0FlK3lZaFExUmNRMmtBb3BuT004?=
 =?utf-8?B?d2srSjVYYnpRd2xHbzdVMzhlMEVxMXAzbVhzM1pZMHhQNlE4OTlmR2RTdUh1?=
 =?utf-8?B?ZnRGM2pEa3l3TFBQNHhIRGxkR3I2dndHKzh4ZVd5cnFSeGdYR0lQbUlNMlZI?=
 =?utf-8?B?ZVo2RGNWbW43TUFMVmZSY1VBL0xJVFNwL3hGRVZqclVCdkVDa1E4N205b0ZG?=
 =?utf-8?B?M1U5enZHTzJ0QkVjQlVyVncvZTU0b0tqSkttZTA0YkpaNXUzaWphUUc5eWth?=
 =?utf-8?B?cTBxc2tTM0lyMVFRWEVwMHVoU3AzWDl0TjByRUhFTGhha0JZYXcwSXlMVmwy?=
 =?utf-8?B?UW5ra2ZqU1FxcVNXcXBhMmRZTVAwWE9ZcCtuUjg3R1BRYS9kRUsrZFVmQVdX?=
 =?utf-8?B?V0VyekxoaU5qYmd3YjBxWHhSYjlWeTNTQ05oZE5VczJibThubUZjcTlEUUt5?=
 =?utf-8?B?VCt6S1paM256eDZ2TXovcUErNDVJRTFUbGZpdUthdzhGaW4wUEF1dWN5d2Zv?=
 =?utf-8?B?Y2xLamZDcE5QS2F6TDd0RTFmYlNZOXRPRHJWeFJ2R2VNWG1LYVEvVVVubGNT?=
 =?utf-8?B?dUdjM2VQSjFvajRibWdGaXl4VkVXYVF6aWRvRHJoRUJmSXBUYVN5QmVqem5N?=
 =?utf-8?Q?p4sbwCVRR+cvfzBWZloUUJvpWXrxLo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUpSbVRXRDdyNlBxZFJNM1BGSWJXZDBOdzhFdE96YmZ3UVhBYWRwb2dWa2M0?=
 =?utf-8?B?SHpMbldxdzZualdWUmNDbFd0c0xOL0lEWlIxMURhVzMwY0dXVkkvT0NTaXVY?=
 =?utf-8?B?MjlrcUJBaG01OE1xYjU0T1JBM1VBbURlWEpiVGhGRmh5R0JaWU9WbmpWcEg0?=
 =?utf-8?B?d0Q1MWY0MytOOEVuVTJxUHRLaEMwOG10TE5sd2RFQWVaM1FKa05mNnV1OVlt?=
 =?utf-8?B?VVV1QWlJVmsxSUROelNqbjJGTFJIOTB6ckZkTjlwenlRZlorZ1AwNExlblk0?=
 =?utf-8?B?bXFqaEFmaTVzdGNjZTFrbTErREM5NUVrZHZybVNpTHo5bzZGWFY3NHhXQWtI?=
 =?utf-8?B?dk1iZXhmam9NSDZOaThBWGJ4ZkFnbmdvd1MzNCtWOTRMYzRSZFJlbGFFN1pD?=
 =?utf-8?B?UkJHZ1YvaXF0eFE2ek1IVnl1R0U4ajZNZUlQZkJNQTZqaWZSaStyWUJaeUZP?=
 =?utf-8?B?OC9VbzlJWFNHaWp6MmIwYXI5emh0SDg3SVBRUktBeVUvelJiYUJoSXdPQ3Jj?=
 =?utf-8?B?RTNhbENaMms5TXlkWHRqb2FqTi9iR0lIYlliSVQzUU82Q3JwR25HTU5Xc3FN?=
 =?utf-8?B?NG9SL28rTENnaW0zRittenBTTHRMUWxLSTBNVkZzSlp1dERtYlM2ekxndHcv?=
 =?utf-8?B?cW16aS9RcUpZeVpJM1JQRzcxV2JRSXBlVUJKc2V3OW5rZFdwL3A0aVQrVEU4?=
 =?utf-8?B?T252SG51REtiVzFZVWx2ZEZZWUxkcmFhYXlIQzZKKzJaR25MRnNWTHRBOWhF?=
 =?utf-8?B?RktvY2VnNkdReTFZTG9NMkEwSThpVmo0UTJkVU52NTYvTVhKU3FRYzVwSkcr?=
 =?utf-8?B?TWg0RUUrekNpUHlhMGJrSkt3emlLdFVlWDdteVFzOThTQ2Y3b2UyTlcvdjdk?=
 =?utf-8?B?cy8vTW1EZzUrSkFFeXNlYkRBL2JQM3FRejZwdjQ2NzU2WmlRTnN1bXR6dk1O?=
 =?utf-8?B?akZNSVdQSUJzTWNMdWhiQXZrRHFtcDFXU3JJMmZsVkdRWWVBejE0TnMvdVJy?=
 =?utf-8?B?bjNTU3hrN2VBYUJiTXlWeUhnTko0UEtPcFd3K3ZLVnBSRUU5VnBuZzVLeFE5?=
 =?utf-8?B?TldRQTVkZXpzb0FPOXVXb2VDcWhTYUhHTnROUno3cDhuOS9lT1E4TFZuelpW?=
 =?utf-8?B?SDJIVTIrdFlrY1ZKRW9CdTA2KzZ3bUxtaDJ3Z3lYWlRVK1FEb1l1Z3ZxYjJD?=
 =?utf-8?B?VTk4SUJkTDQ4WmF4a3FWZUtYNTVoU1NXWUQ3UTBTTHJLU1BNcnN3MWRwVG8y?=
 =?utf-8?B?bENaOGhJL2N0M2F0WVJPamdCTzJya0ZJVHFCQzI3YndUZ3N3b3ZQa2x1bmhz?=
 =?utf-8?B?aE1zcVVJSDR3dkpJdmxNVjVPOTQwUVJDVXhrdDlMSzFsU2ZlZWlRQUQ5enRp?=
 =?utf-8?B?R2dwL05zdGJ3WHBGYW1FNC9VMVplcHJjd3Njb1hWTnNHQVZFaWxoU014d2RK?=
 =?utf-8?B?dWR1Zkc0NnphRE1aekUyVVZKQktYL2NvdFM3MDRTMzhCSFpYS2x3RGptMTNk?=
 =?utf-8?B?dTlEWmZCbXFvdTlXc0xtYXhDMmRFajh0eTRCYWR6NTE5WHZWU1FLMWVIR1I2?=
 =?utf-8?B?cmVuUGozWWplREF2WTV6SDNkOW51bHlOY2lZQkRldnNuc2haODRvMEFGL3Js?=
 =?utf-8?B?TjhBcFJvdWpqTTQ2L0NIZCt1a2kvQjd4SHRWZ0MxT2l0djVnWjAybGRPUDJq?=
 =?utf-8?B?Q2ZoWG9EZ1lnaEhCSi94Z081WVh0c3REYW9hN0pMMVJkRTVZTFhkZFJKdUV2?=
 =?utf-8?B?YUtHUjc0QXpLNWN3ajBRdnVqT2pTeCtsaTNBVkxnUXpYNW1xUk81ODRzVEI3?=
 =?utf-8?B?MkZsQSsvT0ZyMFZ6MzVLdS91WGdCM1BpdzdNcEROb1ErTnEvMTlEc2ZuWmNp?=
 =?utf-8?B?bFhsSlVmY1dZRWZrNHlxUDJ4WVF2eStteFZkV3Zvd25IUUN2N214STdOQVdE?=
 =?utf-8?B?WXRLMVlBeGpUV05nakdwczZOcXYxVUJPU2JuVUhDRjVEQmt3ZnZsVUFrU25X?=
 =?utf-8?B?WFluQzFseTVVaHUyR0tZU2RHd1gyVUc3bk9xZlNKWTRtd3Fscy81b0tvQ1l1?=
 =?utf-8?B?a3Y2SFpkYnUxajNLQ1FWQ0ZqY1RaNnpEL2thWXRrOU4rYlRKQTBxVmNmdXBi?=
 =?utf-8?Q?t1Rw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961eead7-f84f-4448-227b-08ddce495f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 02:41:08.2164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XK1A/ylHmODrs2EBdpgwMNVoL+IgvVPCFhC2mS3ReBqtK7BAaYboDPiQcflFQNOwZgupPkuL/hDbN+GfujZW4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854
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
Cg0KSGkgQWxleGFuZGVyDQoNCj4gSSBkaWRuJ3QgdGhpbmsgd2UgYWN0dWFsbHkgcmVzdWJtaXR0
aW5nIGpvYnMgYW55bW9yZS4gIEhvdyBhcmUgd2UgZW5kaW5nIHVwIHRyeWluZyB0byByZXN1Ym1p
dCBpbiB0aGUgZmlyc3QgcGxhY2U/DQoNCkl0IGlzIG5vdCBhYm91dCByZXN1Ym1pdHRpbmcuIGFt
ZGdwdV92bV9nZW5lcmF0aW9uIHdpbGwgY2hlY2sgaWYgdGhlIFZNIGlzIHZhbGlkIGZvciB0aGlz
IGpvYiB0byB1c2UuIEZvciBleGFtcGxlLCBpZiBhIGdmeCBqb2IgZGVwZW5kcyBvbiBhbiBzZG1h
IGpvYiwgd2hpY2ggaXMgYWxyZWFkeSBjYW5jZWxsZWQsIHRoZW4gdGhlIGdmeCBqb2Igc2hvdWxk
IGJlIHNraXBwZWQuDQpQZXJoYXBzIHRoZSBkZXBlbmRlbmNpZXMgYmV0d2VlbiB0YXNrcyBzaG91
bGQgYmUgcmVzb2x2ZWQgYnkgdGhlIGRybSBpbnN0ZWFkIG9mIGFtZGdwdS4NCg0KdWludDY0X3Qg
YW1kZ3B1X3ZtX2dlbmVyYXRpb24oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBh
bWRncHVfdm0gKnZtKQ0Kew0KICAgICAgICB1aW50NjRfdCByZXN1bHQgPSAodTY0KWF0b21pY19y
ZWFkKCZhZGV2LT52cmFtX2xvc3RfY291bnRlcikgPDwgMzI7DQoNCiAgICAgICAgaWYgKCF2bSkN
CiAgICAgICAgICAgICAgICByZXR1cm4gcmVzdWx0Ow0KDQogICAgICAgIHJlc3VsdCArPSBsb3dl
cl8zMl9iaXRzKHZtLT5nZW5lcmF0aW9uKTsNCiAgICAgICAgLyogQWRkIG9uZSBpZiB0aGUgcGFn
ZSB0YWJsZXMgd2lsbCBiZSByZS1nZW5lcmF0ZWQgb24gbmV4dCBDUyAqLw0KICAgICAgICBpZiAo
ZHJtX3NjaGVkX2VudGl0eV9lcnJvcigmdm0tPmRlbGF5ZWQpKQ0KICAgICAgICAgICAgICAgICsr
cmVzdWx0Ow0KDQogICAgICAgIHJldHVybiByZXN1bHQ7DQp9DQoNClRoYW5rcw0KUml2ZXINCg0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1
Y2hlckBnbWFpbC5jb20+DQpTZW50OiBUdWVzZGF5LCBKdWx5IDI5LCAyMDI1IDI6MTAgQU0NClRv
OiBZdWFuU2hhbmcgTWFvIChSaXZlcikgPFl1YW5TaGFuZy5NYW9AYW1kLmNvbT4NCkNjOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlz
dGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IGNhbywgbGluIDxsaW4uY2FvQGFtZC5jb20+OyBaaGFuZywgVGlhbnRpYW4gKENlbGlu
ZSkgPFRpYW50aWFuLlpoYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1k
Z3B1OiBrZWVwIGpvYi0+dm0gaW4gYW1kZ3B1X2pvYl9wcmVwYXJlX2pvYg0KDQpPbiBNb24sIEp1
bCAyOCwgMjAyNSBhdCA1OjAx4oCvQU0gWXVhblNoYW5nIE1hbyAoUml2ZXIpIDxZdWFuU2hhbmcu
TWFvQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIElu
dGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPg0KPiBIaSBBbGV4YW5kZXINCj4NCj4gICAgICAg
ICBTaW5jZSBDaHJpc3RpYW4gaXMgb24gdmFjYXRpb24uIENvdWxkIHlvdSBoZWxwIHJldmlldyB0
aGUgYmVsb3cgcGF0Y2g/DQo+ICAgICAgICAgSWYgc2V0IGpvYi0+dm0gdG8gbnVsbCBpbiBhbWRn
cHVfam9iX3ByZXBhcmVfam9iLCB0aGUgam9iIHdoaWNoIHNob3VsZCBiZSBza2lwcGVkIGluIGFt
ZGdwdV9qb2JfcnVuIHdpbGwgYmUgc3VibWl0dGVkIHVuZXhwZWN0ZWRseS4NCg0KSSB0aGluayB3
ZSBjYW4ganVzdCByZW1vdmUgdGhlIGFtZGdwdV92bV9nZW5lcmF0aW9uKCkgY2hlY2sgaW4gYW1k
Z3B1X2pvYl9ydW4oKS4gIEkgZGlkbid0IHRoaW5rIHdlIGFjdHVhbGx5IHJlc3VibWl0dGluZyBq
b2JzIGFueW1vcmUuICBIb3cgYXJlIHdlIGVuZGluZyB1cCB0cnlpbmcgdG8gcmVzdWJtaXQgaW4g
dGhlIGZpcnN0IHBsYWNlPw0KDQpBbGV4DQoNCj4NCj4gVGhhbmtzDQo+IFJpdmVyDQo+DQo+DQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFl1YW5TaGFuZyBNYW8gKFJpdmVy
KSA8WXVhblNoYW5nLk1hb0BhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMjMsIDIw
MjUgNTowNiBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IEtv
ZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBZdWFuU2hhbmcgTWFv
DQo+IChSaXZlcikgPFl1YW5TaGFuZy5NYW9AYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBrZWVwIGpvYi0+dm0gaW4gYW1kZ3B1X2pvYl9wcmVwYXJlX2pvYg0KPg0KPiBq
b2ItPnZtIGlzIHVzZWQgaW4gZnVuY3Rpb24gYW1kZ3B1X2pvYl9ydW4gdG8gZ2V0IHRoZSBwYWdl
DQo+IHRhYmxlIHJlLWdlbmVyYXRpb24gY291bnRlciBhbmQgZGVjaWRlIHdoZXRoZXIgdGhlIGpv
YiBzaG91bGQgYmUgc2tpcHBlZC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogWXVhblNoYW5nIDxZdWFu
U2hhbmcuTWFvQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2pvYi5jIHwgNyAtLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBkZWxldGlvbnMo
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9q
b2IuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYw0KPiBpbmRl
eCA0NWZlYmRjMmYzNDkuLjE4OTk4MzQzODE1ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9qb2IuYw0KPiBAQCAtMzYwLDEzICszNjAsNiBAQCBhbWRncHVfam9iX3By
ZXBhcmVfam9iKHN0cnVjdCBkcm1fc2NoZWRfam9iICpzY2hlZF9qb2IsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIGRldl9lcnIocmluZy0+YWRldi0+ZGV2LCAiRXJyb3IgZ2V0dGluZyBWTSBJ
RCAoJWQpXG4iLCByKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJvcjsNCj4g
ICAgICAgICAgICAgICAgIH0NCj4gLSAgICAgICAgICAgICAgIC8qDQo+IC0gICAgICAgICAgICAg
ICAgKiBUaGUgVk0gc3RydWN0dXJlIG1pZ2h0IGJlIHJlbGVhc2VkIGFmdGVyIHRoZSBWTUlEIGlz
DQo+IC0gICAgICAgICAgICAgICAgKiBhc3NpZ25lZCwgd2UgaGFkIG11bHRpcGxlIHByb2JsZW1z
IHdpdGggcGVvcGxlIHRyeWluZyB0byB1c2UNCj4gLSAgICAgICAgICAgICAgICAqIHRoZSBWTSBw
b2ludGVyIHNvIGJldHRlciBzZXQgaXQgdG8gTlVMTC4NCj4gLSAgICAgICAgICAgICAgICAqLw0K
PiAtICAgICAgICAgICAgICAgaWYgKCFmZW5jZSkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
am9iLT52bSA9IE5VTEw7DQo+ICAgICAgICAgICAgICAgICByZXR1cm4gZmVuY2U7DQo+ICAgICAg
ICAgfQ0KPg0KPiAtLQ0KPiAyLjI1LjENCj4NCg==
