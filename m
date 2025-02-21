Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B18C021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 10:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D9D10E281;
	Fri, 21 Feb 2025 10:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p3i11JRZ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B30F510E24A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 10:30:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ah9Oidn+IBI4iotExeMcJbMIPFl26mFV8gFZCrASIALGIGwGesTr0CC1nx/UY1XpmI8LRveXRfrQEz3rl2McPxRzbdcInsc6OqnorcI1U0qmcQJ217IemDQXmY4ul43A7AsVtR340Ff4/vH9bjZito2vZ+0QHj7MSWsA13h2aBapgmIn3pmT5UPo+YqZwWxYf8/x7WpmNj0GkgGCjzzwxSH0hcu9auPithP5TJxiVCrviepq3AsCufRurILV/AgkyCacBBczrMy81vxrn+3TplIhCgrv6UArYM4OlOU9sXN2SaK/svXdAmpNo4LCiQIbK0fJWlbAMK2Xgom7eXvRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLi6qRO81LisrWhOruROwBll4Xn2ZoM8zNczRbMjHf0=;
 b=KujLP9lHbpU3vbimpq+uVFzCbLln10oj8x9nsO4YzgA5Kwk5eNb6geQLdbQxYSzwKc3+qYLI1RTgfUBhUX4VGTph3GTQR7Kb4/o8Eexoigb6oyQPXFidMWjrhHtT7qc086mBcyodGqKTIPPkW6MRPTpe2C6rgcGWbfFo7yH97BhgDJEVYXqnS5xdDmlh6mACS4ndWJ41ZhwMOQLBEdUZ4r9OQmQ54ZOI3fgpYzMVol/HPIu1lDTA0w7l2d2AkV+xOl7FTQUH7hzu5hGzsw42o2ga+gNkfbYuXEKXV3kmmoy1MhtpVh8Y6jb3F6h/e4hLISBkkzEcDKgd6Zm+/97sBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLi6qRO81LisrWhOruROwBll4Xn2ZoM8zNczRbMjHf0=;
 b=p3i11JRZYD22WGjXGwHuH1efrjLddqxNJXsb2e8yoFRYHM1SWXNhT68E8dETASYq6cwYsxfUUXdgi7qaysRjOnTXAVnv+Qy23CvmbDqfZUORKqOqlWMB78+D0+/iOlH0VZ118H271HzC54LM3nygJImh+Zy2QeQXqHKZs5x/M6k=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 10:30:26 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 10:30:26 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "Huang, Tim"
 <Tim.Huang@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH v3 2/2] drm/amdgpu: Initialize SDMA sysfs reset mask in
 late_init
Thread-Topic: [PATCH v3 2/2] drm/amdgpu: Initialize SDMA sysfs reset mask in
 late_init
Thread-Index: AQHbhChd4kd5HPmWIkG4kqNmAPpeMLNRaJAAgAAl8bA=
Date: Fri, 21 Feb 2025 10:30:26 +0000
Message-ID: <DM4PR12MB51522B436AA65052172FDA2EE3C72@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250221061746.3949672-1-jesse.zhang@amd.com>
 <20250221061746.3949672-2-jesse.zhang@amd.com>
 <7f5f3c07-e0b9-424d-afea-880ebfd9d8a3@amd.com>
In-Reply-To: <7f5f3c07-e0b9-424d-afea-880ebfd9d8a3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7aec4ff7-46b6-43ee-8946-1496a1454ba7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-21T10:28:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MW4PR12MB8610:EE_
x-ms-office365-filtering-correlation-id: 8ec1177b-be51-4f10-b9ac-08dd5262c193
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?N1MwMHUwWnJaVjdIcjBsT1k0ZmtRN1VKS1ZTbXhrUjdvMEhuK1JuK2dLMkpY?=
 =?utf-8?B?dEVjVGxLVmRlWjVOREwzWitBUm13QVpQNU41ZTRqeGtIUk1OelRqcFNLZTh1?=
 =?utf-8?B?YlFucVdYWEZkVkNZUVBWQlZKYzFvL1hEb3RxbnRBRmRsYWRBanZVM2UzN0Qv?=
 =?utf-8?B?VkdKY0lxL0liK3BQenY0c0Q0a1o3UWdrT21vZEVqUXZzejFKTUY5azIvRFRQ?=
 =?utf-8?B?SkNiRk9vNSt2cjc1RVdtTzEyNUJkekxCeCtIOW8zdDBPeTdxZVk5c0hmZk5q?=
 =?utf-8?B?b2lTSVlVbzBjRVlidzVIZ3ArbWpGLzI2VGJySmRiTnlKTXNUSXVaYjFKcGlD?=
 =?utf-8?B?c2F0Rmd0aE9IdWVldzNOTWhJOWdlaE52NldrMFErY3dKeXpSZytvT0JsdzhY?=
 =?utf-8?B?cklCSy9ROFJMQnRFY3phbmtxZmtNcVlCcVhQeUdsMUVmUjgrWWNEaERGbEZX?=
 =?utf-8?B?K3FrZlZCMzVuKzYrZzI2TG5CdlAzKzhXRnVXZk5lVnJ3cTQ3QjNQdWVKNENh?=
 =?utf-8?B?STlEY3lZZllHK09nbDVaRS95bWhKZ2hxbmgxc3JtV2l3d0NTTm1ObkE4V3Bq?=
 =?utf-8?B?VEJSK21hc2VFZHpBN3hONlcrZi9zcThGMmVmK05oMmZ6c01meVM0OC9BVkVB?=
 =?utf-8?B?ZFZnbURSUDhjMWFTcnJUVWk2RW9XUXF0M0xYR0JUc1ZuUjF0WktKZWxyVFRW?=
 =?utf-8?B?M1NtR2NaNklVSm42Y3N5RnhhTURoem5FaU00RFNnaC9NY2x6clpGSnJveTBG?=
 =?utf-8?B?b0k1M1FxdzdBVGQybThsOFdrTG92SlBiM0FOSkNmeUpnY2c2UndZWUsvc0lo?=
 =?utf-8?B?NWJFRm1CaE1KR1pvQllQUWNDR1JrQWVPR3I4d2pFcXhXRW9VQVRFTHRMMFk4?=
 =?utf-8?B?M2NlRlJOWGtWR08wRDc1Uk1sV1ZDMzd2bnNiajVpR1RFZmdGOGRlRlA5cFlT?=
 =?utf-8?B?b0swQUhmb3dXUEt3K0Jja2ozbVYyKy9naGtkVUFuYWxydFlqY1lndGFYZ00z?=
 =?utf-8?B?UDVFRHc0aDNreXJIS2tOMk9IeEdpR2dDY2NSNjc2aktaanNmWkxwQ1R0SHZ5?=
 =?utf-8?B?bEZQK2I4MnNNZTJUZ0VNSVVwNE11VWJKemlwaHRXdmJ1aDJ3Z2x2OXQyZGc2?=
 =?utf-8?B?TTZDT3B1UXZ2MFpSVVNFZkIxZjJsMDcxZnplUG5uNVMvNVgzc1BPS2JreW9F?=
 =?utf-8?B?bFNjYXloMjIwMUloSmhVMXpJMkdKU292V1p6d2RnOVQvMjVBTXlYTkRhRzBT?=
 =?utf-8?B?Vk04Z3NWQVFFMklkWCtNTXMrS1lSUVpvUm1JZWlCemQwam96TGlERjh1M2Qr?=
 =?utf-8?B?dnNXVHZwTkdxYXdRbWw4STVaU1M5L21jcmRkaGhJVUVVVGY4UFRjaVhaV1ll?=
 =?utf-8?B?SUZMeVF1cDFhMVQwZjgvWkVUN1NhOXpKaGVxSkZwOUowTmRVL21WNHAwUjc4?=
 =?utf-8?B?TUN1UUJieGFrNW1qdFJVc0h5TFhOSVpJMHZrQ3lBVG43dEZNTTYvQStJQ2t2?=
 =?utf-8?B?TmxEZ1JoMDhpVFhCQzllSXYwQTVhMUpRWVZKbk9BQ2xSay85U2hkN2VEc2N5?=
 =?utf-8?B?ajVlclhUeERQdy9nV2xzZG1jKy9GOHBFeFozT2U3andXZW1YeWlZYmEzWlZq?=
 =?utf-8?B?S3VXcWNEbDlSQnl6aDB1cVdUWUZBcWdYam52dU1JWi9hb2ZOaVRiLzJEN2xY?=
 =?utf-8?B?c0haZ3pMejdCKzgwL2pOaDNWL3RNemFRaHU4RjFYUkxHZkVMR0xZdml3UUlF?=
 =?utf-8?B?bTh0emxlWVV6UkJEYmRvUnVtaGdKQnFLbjEzQXZMYW9pODhTVTZoOTdoU094?=
 =?utf-8?B?UWUvclhJWXhvSFVRTnpPSEQ1a3oyUzRqcmp0QjFFMEVKaFl3dVNISzB1OEN1?=
 =?utf-8?B?dzRsOWJkeVFPT0NRN0h2Mm1seXUxZjRwYXZhYXpYQms5ZGx4U3hHWnNRS3NL?=
 =?utf-8?Q?6mX0AYF88LofxQ1y1qm+au4NZ+XCr7qI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEhvVzVYeWJRWUd6Tk15bkJWcWhvcm0weVcrMFUzeEE1U3FFdng4bmJxNUNE?=
 =?utf-8?B?dWdSb3l1L21tWlVhUnpRTUZTTnB4Z2hvendGYWp6anYySFNxZkZsL01sMkpH?=
 =?utf-8?B?aEpQeExVdEhUNDNzQ2QzaFhtUnNCRlV3dGZUL1FlSVpUWUozOFJqT0hwdWVy?=
 =?utf-8?B?SCt0aCtiekpUbndPUEZjeWd6VEN0QVBrdlROaXBLdXduUWxLQnJmN0dlQ0Qv?=
 =?utf-8?B?aDFUcFVYZy81YUk5eGpCYmV5ZWs1ZER3U0hUVitQWTNEL1lEZzhDOUlaZEZw?=
 =?utf-8?B?NkRPOUtuUlhKUG9pdjlhVHVheHpwaUN1SW93MmNmanEyUHJxYlZic3lWT1g3?=
 =?utf-8?B?RUlZNUwvVmVvMVZlWitUTy8xdXorQ0wwcG9OdXFtTldxS1VGeVBSMENMOUhI?=
 =?utf-8?B?SGEzdFAranRhVGNaOGhuelFMTWJ4WDdpdUgzejJWTXkrT0pQYkwrUnBZVXpC?=
 =?utf-8?B?ZjdhSmI1QTFuaDljMWpaUGVnVW4vVEY2SERNOTFlYVdOZkVWMVZBeEx2bHVR?=
 =?utf-8?B?ZjFGcjJKRjRxUWttR2hUbkxZOUV2QmV4S1BYa0JaVThvTjRINCtBN000dzlw?=
 =?utf-8?B?ZDRTeWxWUVI4MWo1WG00Um5IVHRoc0lKai9uWEkyeHNJek11cUdwZDJVOTRR?=
 =?utf-8?B?V0ZCcWpSQk1hSWpNalhvK0dkQTJPNnRucmlzcTlnSFYxQkwxbXJpWm5INDEy?=
 =?utf-8?B?N1hYNVNpSlRpS01jQ1JPSUZ4Z2tuaTJZYmljSmxzZzRsUXk4Wm1qelV4NDFZ?=
 =?utf-8?B?dXJJbXJjRklObzIySTVhTDB2WTdjU29QOHJnSVYza0d2ODJhc3E3RzMyQWl3?=
 =?utf-8?B?SndaYjBLOERVVTdNdllzSE5tbmlvMFpFUWJVOGdaeXJMcldUQ3FQWWRyTXB6?=
 =?utf-8?B?WTFXS0pNbkk1MFE3bCtQS1NnWEFTUlRFZ1dTeXh0V3FQbXJMVGg3elc5MDBZ?=
 =?utf-8?B?dlJZNWRRMTU0SGlIVkxWaW5ReDdWNEVGQ3ZZWHhsR05hbmp5cW91MEV5TEU5?=
 =?utf-8?B?L3dlWGlHM3JqbXBHbmQwM2djeDFTejFPb2d4dDNPN2laa2R5Z21HZUUwK0xW?=
 =?utf-8?B?eWc2eWRXSkMrQkI3ZXdPajRzM2pPVkIwUThGeURlRVJsZEU3UDlCSmY1ZDNn?=
 =?utf-8?B?aVlVakRqTUhYWFFRenhicnJTNVF2MUtUZ3JWeFMraHlSK1NueHYvYUhKWTVS?=
 =?utf-8?B?SDdLSDlEbndaR3FzcmtZU2tITnZyUDBlRjN5Y2hPbHZNNnhvOXhFUE8yOStl?=
 =?utf-8?B?NVNwMXQ3dFlKL1I4eW9tUU92SllVZmVKWFJoVVY0SXNQREM1emp0cFpHclpr?=
 =?utf-8?B?MnNUYWd2dHRENXZ1L1UwZlJQaFc1TVhZV0VNeXFZQWd0TmxPUEMrM2hRb2Rt?=
 =?utf-8?B?SFZKMW9zb3pZU3gxNURPS1YwRmlkN1VIbElRb1h2Q2tFd2JjR1NLYUt0RzNi?=
 =?utf-8?B?cis0OHNnVUFuUEo0YWNNWnFlUk82SkRiVzVYcC9aVEh3VHNaQTR5bWtGR3Qr?=
 =?utf-8?B?SWpOOVUvRk9oRE9iNFhqdzdkMzBUbDNUaFhxbFovUTFibGNIdDRoOVVwdy9B?=
 =?utf-8?B?TVl6RmRyNHFHL2RJditjdm4zQkhQY0JKeVBLNU15WlhFSnVGN1RPZkpxbzkw?=
 =?utf-8?B?Zk9RT2pOTzlsYkZqaUJUNHRxSGtMZ244NVRiODc2NFBoZjgxTG1mSDYwTHlU?=
 =?utf-8?B?WDFBNG5GWng4b0Zja3VQN2I2VHR1QjJ2OXJZNm0vUWt5ZkJTdnFyeXh2QWFS?=
 =?utf-8?B?d1NMZUdxMTlad21vQkd4eGhqYng2VmF6a01CK3NFYUNySmJNRTY0WmpBaW1K?=
 =?utf-8?B?Rm0ycWtBVEtiamIzdkgySEQ4ZjlzMkw1Zlp0Q2pZMmNFc01nd3J0T3ZmUVhW?=
 =?utf-8?B?STB1dkhaVHlyMjhrQThDZkRYU1dsM1BxTE5GdElySU92VVVEWHF0R0lSUVRs?=
 =?utf-8?B?eHNSMTE1NXVHY0E2VnVQSGRDbC9FRklpZWlwWWRiQStpSXZoMzJINXovdmJ0?=
 =?utf-8?B?d3FwNWVPUmpKbEJkTllFb3l6M05SVkpWYmZ0TGhKbytlSzI4WUo1ZlQwVDho?=
 =?utf-8?B?MHorTDFtTFVRSWlOaDljYzhVL2ljaTZELytYZVl1STcxdkNFRVpzOG14Yy8r?=
 =?utf-8?Q?7Wcw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec1177b-be51-4f10-b9ac-08dd5262c193
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 10:30:26.4090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nMUjZXtO+y+jI3S2NmJ8w7+9gUC28a0KCtoGwb/4LzDV8bhR7lIVJCBR21lUVbIORkV9dhb3aUOb+zh/MzVZzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxh
emFyQGFtZC5jb20+DQpTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDIxLCAyMDI1IDQ6MTMgUE0NClRv
OiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPjsgS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+OyBaaHUsIEpp
YWRvbmcgPEppYWRvbmcuWmh1QGFtZC5jb20+OyBIdWFuZywgVGltIDxUaW0uSHVhbmdAYW1kLmNv
bT47IFByb3N5YWssIFZpdGFseSA8Vml0YWx5LlByb3N5YWtAYW1kLmNvbT4NClN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjMgMi8yXSBkcm0vYW1kZ3B1OiBJbml0aWFsaXplIFNETUEgc3lzZnMgcmVzZXQg
bWFzayBpbiBsYXRlX2luaXQNCg0KDQoNCk9uIDIvMjEvMjAyNSAxMTo0NyBBTSwgamVzc2Uuemhh
bmdAYW1kLmNvbSB3cm90ZToNCj4gRnJvbTogIkplc3NlLnpoYW5nQGFtZC5jb20iIDxKZXNzZS56
aGFuZ0BhbWQuY29tPg0KPg0KPiAtIEludHJvZHVjZSBhIG5ldyBmdW5jdGlvbiBgc2RtYV92NF80
XzJfaW5pdF9zeXNmc19yZXNldF9tYXNrYCB0byBpbml0aWFsaXplIHRoZSBzeXNmcyByZXNldCBt
YXNrIGZvciBTRE1BLg0KPiAtIE1vdmUgdGhlIGluaXRpYWxpemF0aW9uIG9mIHRoZSBzeXNmcyBy
ZXNldCBtYXNrIHRvIHRoZSBgbGF0ZV9pbml0YCBzdGFnZSB0byBlbnN1cmUgdGhhdCB0aGUgU01V
ICBpbml0aWFsaXphdGlvbg0KPiAgICAgIGFuZCBjYXBhYmlsaXR5IHNldHVwIGFyZSBjb21wbGV0
ZWQgYmVmb3JlIGNoZWNraW5nIHRoZSBTRE1BIHJlc2V0IGNhcGFiaWxpdHkuDQo+IC0gQ29uc29s
aWRhdGUgdGhlIGxvZ2ljIGZvciBzZXR0aW5nIHRoZSBzdXBwb3J0ZWQgcmVzZXQgdHlwZXMgYW5k
IGluaXRpYWxpemluZyB0aGUgc3lzZnMgcmVzZXQgbWFzayBpbnRvIHRoZSBuZXcgZnVuY3Rpb24u
DQo+IC0gRm9yIElQIHZlcnNpb25zIDkuNC4zIGFuZCA5LjQuNCwgZW5hYmxlIHBlci1xdWV1ZSBy
ZXNldCBpZiB0aGUgTUVDIGZpcm13YXJlIHZlcnNpb24gaXMgYXQgbGVhc3QgMHhiMCBhbmQgUE1G
VyBzdXBwb3J0cyBxdWV1ZSByZXNldC4NCj4gLSBBZGQgYSBUT0RPIGNvbW1lbnQgZm9yIGZ1dHVy
ZSBzdXBwb3J0IG9mIHBlci1xdWV1ZSByZXNldCBmb3IgSVAgdmVyc2lvbiA5LjQuNS4NCj4NCj4g
VGhpcyBjaGFuZ2UgZW5zdXJlcyB0aGF0IHBlci1xdWV1ZSByZXNldCBpcyBvbmx5IGVuYWJsZWQg
d2hlbiB0aGUgTUVDIGFuZCBQTUZXIHN1cHBvcnQgaXQuDQo+DQo+IFN1Z2dlc3RlZC1ieTogSm9u
YXRoYW4gS2ltIDxKb25hdGhhbi5LaW1AYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVml0YWx5
IFByb3N5YWsgPHZpdGFseS5wcm9zeWFrQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEplc3Nl
IFpoYW5nIDxqZXNzZS56aGFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NkbWFfdjRfNF8yLmMgfCA1NQ0KPiArKysrKysrKysrKysrKysrKysrKy0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF80XzIuYw0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfNF8yLmMNCj4gaW5kZXggNGZh
Njg4ZTAwZjVlLi5mZDI4ODRkZTJkYzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NkbWFfdjRfNF8yLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc2RtYV92NF80XzIuYw0KPiBAQCAtMTA3LDYgKzEwNyw3IEBAIHN0YXRpYyB2b2lkIHNkbWFf
djRfNF8yX3NldF92bV9wdGVfZnVuY3Moc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYpOyAg
c3RhdGljIHZvaWQgc2RtYV92NF80XzJfc2V0X2lycV9mdW5jcyhzdHJ1Y3QNCj4gYW1kZ3B1X2Rl
dmljZSAqYWRldik7ICBzdGF0aWMgdm9pZCBzZG1hX3Y0XzRfMl9zZXRfcmFzX2Z1bmNzKHN0cnVj
dA0KPiBhbWRncHVfZGV2aWNlICphZGV2KTsgIHN0YXRpYyB2b2lkDQo+IHNkbWFfdjRfNF8yX3Nl
dF9lbmdpbmVfcmVzZXRfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0KPiArc3Rh
dGljIGludCAgc2RtYV92NF80XzJfaW5pdF9zeXNmc19yZXNldF9tYXNrKHN0cnVjdCBhbWRncHVf
ZGV2aWNlDQo+ICsqYWRldik7DQo+DQo+ICBzdGF0aWMgdTMyIHNkbWFfdjRfNF8yX2dldF9yZWdf
b2Zmc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgICAgICAgICAgICAgIHUzMiBp
bnN0YW5jZSwgdTMyIG9mZnNldCkNCj4gQEAgLTEzNjYsNiArMTM2Nyw3IEBAIHN0YXRpYyBpbnQN
Cj4gc2RtYV92NF80XzJfcHJvY2Vzc19yYXNfZGF0YV9jYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwgIHN0YXRpYw0KPiBpbnQgc2RtYV92NF80XzJfbGF0ZV9pbml0KHN0cnVjdCBhbWRncHVf
aXBfYmxvY2sgKmlwX2Jsb2NrKSAgew0KPiAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diA9IGlwX2Jsb2NrLT5hZGV2Ow0KPiArICAgICBpbnQgcjsNCj4gICNpZiAwDQo+ICAgICAgIHN0
cnVjdCByYXNfaWhfaWYgaWhfaW5mbyA9IHsNCj4gICAgICAgICAgICAgICAuY2IgPSBzZG1hX3Y0
XzRfMl9wcm9jZXNzX3Jhc19kYXRhX2NiLCBAQCAtMTM3NCw3ICsxMzc2LDEyIEBADQo+IHN0YXRp
YyBpbnQgc2RtYV92NF80XzJfbGF0ZV9pbml0KHN0cnVjdCBhbWRncHVfaXBfYmxvY2sgKmlwX2Js
b2NrKQ0KPiAgICAgICBpZiAoIWFtZGdwdV9wZXJzaXN0ZW50X2VkY19oYXJ2ZXN0aW5nX3N1cHBv
cnRlZChhZGV2KSkNCj4gICAgICAgICAgICAgICBhbWRncHVfcmFzX3Jlc2V0X2Vycm9yX2NvdW50
KGFkZXYsIEFNREdQVV9SQVNfQkxPQ0tfX1NETUEpOw0KPg0KPiAtICAgICByZXR1cm4gMDsNCj4g
KyAgICAgLyogVGhlIGluaXRpYWxpemF0aW9uIGlzIGRvbmUgaW4gdGhlIGxhdGVfaW5pdCBzdGFn
ZSB0byBlbnN1cmUgdGhhdCB0aGUgU01VDQo+ICsgICAgICAqIGluaXRpYWxpemF0aW9uIGFuZCBj
YXBhYmlsaXR5IHNldHVwIGFyZSBjb21wbGV0ZWQgYmVmb3JlIHdlIGNoZWNrIHRoZSBTRE1BDQo+
ICsgICAgICAqIHJlc2V0IGNhcGFiaWxpdHkNCj4gKyAgICAgICovDQo+ICsgICAgIHIgPSBzZG1h
X3Y0XzRfMl9pbml0X3N5c2ZzX3Jlc2V0X21hc2soYWRldik7DQoNCkxhdGUgaW5pdCBpcyBjYWxs
ZWQgYWZ0ZXIgZXZlcnkgcmVzZXQuIFNpbmNlIHRoZSBzeXNmcyBmaWxlIGlzIGNyZWF0ZWQgYWxy
ZWFkeSwgaXQgd2lsbCByZXR1cm4gc29tZXRoaW5nIGxpa2UgLUVFWElTVC4NCiBUaGFua3MgIExp
am8sIHVwZGF0ZSB0aGUgcGF0Y2gNClRoYW5rcywNCkxpam8NCg0KPiArICAgICByZXR1cm4gcjsN
Cj4gIH0NCj4NCj4gIHN0YXRpYyBpbnQgc2RtYV92NF80XzJfc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1
X2lwX2Jsb2NrICppcF9ibG9jaykgQEANCj4gLTE0ODEsMTAgKzE0ODgsNiBAQCBzdGF0aWMgaW50
IHNkbWFfdjRfNF8yX3N3X2luaXQoc3RydWN0IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spDQo+
ICAgICAgICAgICAgICAgfQ0KPiAgICAgICB9DQo+DQo+IC0gICAgIC8qIFRPRE86IEFkZCBxdWV1
ZSByZXNldCBtYXNrIHdoZW4gRlcgZnVsbHkgc3VwcG9ydHMgaXQgKi8NCj4gLSAgICAgYWRldi0+
c2RtYS5zdXBwb3J0ZWRfcmVzZXQgPQ0KPiAtICAgICAgICAgICAgIGFtZGdwdV9nZXRfc29mdF9m
dWxsX3Jlc2V0X21hc2soJmFkZXYtPnNkbWEuaW5zdGFuY2VbMF0ucmluZyk7DQo+IC0NCj4gICAg
ICAgaWYgKGFtZGdwdV9zZG1hX3Jhc19zd19pbml0KGFkZXYpKSB7DQo+ICAgICAgICAgICAgICAg
ZGV2X2VycihhZGV2LT5kZXYsICJmYWlsIHRvIGluaXRpYWxpemUgc2RtYSByYXMgYmxvY2tcbiIp
Ow0KPiAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiBAQCAtMTQ5Nyw5ICsxNTAwLDYg
QEAgc3RhdGljIGludCBzZG1hX3Y0XzRfMl9zd19pbml0KHN0cnVjdCBhbWRncHVfaXBfYmxvY2sg
KmlwX2Jsb2NrKQ0KPiAgICAgICBlbHNlDQo+ICAgICAgICAgICAgICAgRFJNX0VSUk9SKCJGYWls
ZWQgdG8gYWxsb2NhdGVkIG1lbW9yeSBmb3IgU0RNQSBJUCBEdW1wXG4iKTsNCj4NCj4gLSAgICAg
ciA9IGFtZGdwdV9zZG1hX3N5c2ZzX3Jlc2V0X21hc2tfaW5pdChhZGV2KTsNCj4gLSAgICAgaWYg
KHIpDQo+IC0gICAgICAgICAgICAgcmV0dXJuIHI7DQo+ICAgICAgIC8qIEluaXRpYWxpemUgZ3Vp
bHR5IGZsYWdzIGZvciBHRlggYW5kIFBBR0UgcXVldWVzICovDQo+ICAgICAgIGFkZXYtPnNkbWEu
Z2Z4X2d1aWx0eSA9IGZhbHNlOw0KPiAgICAgICBhZGV2LT5zZG1hLnBhZ2VfZ3VpbHR5ID0gZmFs
c2U7DQo+IEBAIC0yMzI4LDYgKzIzMjgsNDUgQEAgc3RhdGljIHZvaWQgc2RtYV92NF80XzJfc2V0
X3ZtX3B0ZV9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAgICAgYWRldi0+
dm1fbWFuYWdlci52bV9wdGVfbnVtX3NjaGVkcyA9IGFkZXYtPnNkbWEubnVtX2luc3RhbmNlczsg
IH0NCj4NCj4gKy8qKg0KPiArICogc2RtYV92NF80XzJfaW5pdF9zeXNmc19yZXNldF9tYXNrIC0g
SW5pdGlhbGl6ZSBzeXNmcyByZXNldCBtYXNrDQo+ICtmb3IgU0RNQQ0KPiArICogQGFkZXY6IFBv
aW50ZXIgdG8gdGhlIEFNREdQVSBkZXZpY2Ugc3RydWN0dXJlDQo+ICsgKg0KPiArICogVGhpcyBm
dW5jdGlvbiBpbml0aWFsaXplcyB0aGUgc3lzZnMgcmVzZXQgbWFzayBmb3IgU0RNQSBhbmQgc2V0
cw0KPiArdGhlIHN1cHBvcnRlZA0KPiArICogcmVzZXQgdHlwZXMgYmFzZWQgb24gdGhlIElQIHZl
cnNpb24gYW5kIGZpcm13YXJlIHZlcnNpb25zLg0KPiArICoNCj4gKyAqIFJldHVybnM6IDAgb24g
c3VjY2Vzcywgb3IgYSBuZWdhdGl2ZSBlcnJvciBjb2RlIG9uIGZhaWx1cmUuDQo+ICsgKi8NCj4g
K3N0YXRpYyBpbnQgc2RtYV92NF80XzJfaW5pdF9zeXNmc19yZXNldF9tYXNrKHN0cnVjdCBhbWRn
cHVfZGV2aWNlDQo+ICsqYWRldikgew0KPiArICAgICBpbnQgciA9IDA7DQo+ICsNCj4gKyAgICAg
LyogU2V0IHRoZSBzdXBwb3J0ZWQgcmVzZXQgdHlwZXMgKi8NCj4gKyAgICAgYWRldi0+c2RtYS5z
dXBwb3J0ZWRfcmVzZXQgPQ0KPiArICAgICAgICAgICAgIGFtZGdwdV9nZXRfc29mdF9mdWxsX3Jl
c2V0X21hc2soJmFkZXYtPnNkbWEuaW5zdGFuY2VbMF0ucmluZyk7DQo+ICsgICAgIC8qDQo+ICsg
ICAgICAqIHRoZSB1c2VyIHF1ZXVlIHJlbGllcyBvbiBNRUMgZncgYW5kIHBtZncgd2hlbiB0aGUg
c2RtYSBxdWV1ZSBkbyByZXNldC4NCj4gKyAgICAgICogaXQgbmVlZHMgdG8gY2hlY2sgYm90aCBv
ZiB0aGVtIGF0IGhlcmUgdG8gc2tpcCBvbGQgbWVjIGFuZCBwbWZ3Lg0KPiArICAgICAgKi8NCj4g
KyAgICAgc3dpdGNoIChhbWRncHVfaXBfdmVyc2lvbihhZGV2LCBHQ19IV0lQLCAwKSkgew0KPiAr
ICAgICBjYXNlIElQX1ZFUlNJT04oOSwgNCwgMyk6DQo+ICsgICAgIGNhc2UgSVBfVkVSU0lPTig5
LCA0LCA0KToNCj4gKyAgICAgICAgICAgICBpZiAoKGFkZXYtPmdmeC5tZWNfZndfdmVyc2lvbiA+
PSAweGIwKSAmJiBhbWRncHVfZHBtX3Jlc2V0X3NkbWFfaXNfc3VwcG9ydGVkKGFkZXYpKQ0KPiAr
ICAgICAgICAgICAgICAgICAgICAgYWRldi0+c2RtYS5zdXBwb3J0ZWRfcmVzZXQgfD0gQU1ER1BV
X1JFU0VUX1RZUEVfUEVSX1FVRVVFOw0KPiArICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICBj
YXNlIElQX1ZFUlNJT04oOSwgNCwgNSk6DQo+ICsgICAgICAgICAgICAgLypUT0RPOiBlbmFibGUg
dGhlIHF1ZXVlIHJlc2V0IGZsYWcgdW50aWwgZncgc3VwcG9ydGVkICovDQo+ICsgICAgIGRlZmF1
bHQ6DQo+ICsgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgIH0NCj4gKw0KPiArICAgICAvKiBJ
bml0aWFsaXplIHRoZSBzeXNmcyByZXNldCBtYXNrICovDQo+ICsgICAgIHIgPSBhbWRncHVfc2Rt
YV9zeXNmc19yZXNldF9tYXNrX2luaXQoYWRldik7DQo+ICsNCj4gKyAgICAgcmV0dXJuIHI7DQo+
ICsNCj4gK30NCj4gKw0KPiAgY29uc3Qgc3RydWN0IGFtZGdwdV9pcF9ibG9ja192ZXJzaW9uIHNk
bWFfdjRfNF8yX2lwX2Jsb2NrID0gew0KPiAgICAgICAudHlwZSA9IEFNRF9JUF9CTE9DS19UWVBF
X1NETUEsDQo+ICAgICAgIC5tYWpvciA9IDQsDQoNCg==
