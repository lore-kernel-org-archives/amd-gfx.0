Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D38C5AE49
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 20:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE3D210E22B;
	Fri, 20 Feb 2026 20:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n+e16o+f";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19C9F10E22B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 20:31:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJFDT1P9r1GJ5USKfjOaV/rPWOYTSMzYKpJTusZaI/vZc7nd0YZEhbI5+v1BGoXvcWd9Ll64EKYzIL1eXcNHIzSenxAX+i6aj9m3DyGBXoXYwnb/sSwgdqHnJuDBWGvqcLJ0Mb23D5Q3IMVrbBt5AIdODR4bbzQgp9ck/HKxf+6ZE4LqvEVNllCL53yFxiCd1ND+/ta91580faNw00MpgTGMiWBWOqvMduRfmHW/am3009nV/RqIskEkT21Uh9EiOZDfbcXMCslwU93qQjL2k7Zv84xu1UL6BzCNT97AqfGzJC94NAzahZ+LxHKmeSUPOMsQ7T20/Giid9lKpxoohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueHJx2NKGrWvtAQBPhBjqF8IpOofj1Ox2v4ll83blVw=;
 b=W37PhWFPODyo8hWFPC0iLRciI2swhpgK0FnUOqGa/FVeUJZ+MXkR157fsSdxe8FyyC1IzHoKi71Rrmfr4indHc/HGN4X7p6VGO+mz0IiDEezBk3iHMaUG0qCEqqg+96kTQ3Lbzjr3NFBNSiUiMvLFbeDmsMx65e8HroL2O0UfQzOkv5Iv7G2TYpkkp7ZhwZbe3H+33gyMP+bIP391Q8EG+seFArinC/JP6Ebryo9dLi8KB6xRdTbuGe4rFJF91AApJ6bZK9hl2aPta35KHi8AyNSkodaVpOyIvg7zeJRjEG9AV9j0sMvRFQuT+8uX6PYQuYJ7ufXBv861mzpcb2n3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueHJx2NKGrWvtAQBPhBjqF8IpOofj1Ox2v4ll83blVw=;
 b=n+e16o+fpBp+5rvH6lRlsn94/ZSTrkZiNe80s9S909RhD/8s49gfBJXwrlGpzLgto/V5cS6tT56svA96tEIfD3JZUHaOGfyb28pYtN2bDJ5LjNXMYm/GdEuq7uzwtKZDwjHllC6H9QLRkZtUgVx04axROI2WfHmH/SKV85hsuBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Fri, 20 Feb
 2026 20:31:01 +0000
Received: from PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::3129:67e7:f119:5593]) by PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::3129:67e7:f119:5593%5]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 20:31:01 +0000
Content-Type: multipart/alternative;
 boundary="------------r0v3Id2y6bC2qK25McPIUrpX"
Message-ID: <2dce4859-02df-4956-b3a0-a96b4ccd0dd8@amd.com>
Date: Fri, 20 Feb 2026 15:30:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/amdgpu/sdma4.0: adjust SDMA limits
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20260219160224.1976043-1-alexander.deucher@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20260219160224.1976043-1-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBPR0101CA0188.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::31) To PH7PR12MB6420.namprd12.prod.outlook.com
 (2603:10b6:510:1fc::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6420:EE_|PH8PR12MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 35bec46e-accd-4b4e-152b-08de70bef642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ry9XQlV6ZmJseHhXNWdKb3FNNmJKOE9uWGlIZFU5dWdOeWxMdFh0VjhLWEJS?=
 =?utf-8?B?ZS8xVGxaOXRsaFdjRHBYQXo5VTUrNUkxOXFQZnc5RU03NGhsSmtYMHB0a3ll?=
 =?utf-8?B?T1F1OTFRM3c5SEZIMy9oZSsrdUFKQXIyTi96Sndoa3FURXdrV213WFlERlpl?=
 =?utf-8?B?RkZTNnVsbTVRTWtqWm9RNm5KR0o4Z0JHcHhiMVVvYjBaZ21ZN2VkUEN3NVVQ?=
 =?utf-8?B?UDF5c3FkOVNKZ3hTVkNWRWFGcjdNQ1owOFRLVHUrQTVQTHlTdWo3UGJDMDJQ?=
 =?utf-8?B?bGFoYXF2MFlEdkJVUmFWeVRRbk9VNjR4d05TWnByVzc1aG0rQ2hTNGRxOXJE?=
 =?utf-8?B?VDJvZE1DMzJwVWNWamNmbGJGNVFUTjE3SEVRT0NjYnVWZkV3MTlBYTMwKzZ0?=
 =?utf-8?B?ZzdDUmJ5QmdtLzFRL1hEU0lEdHNtcjc3NS8rL1docHYwa0JvcThhd1lXdGRU?=
 =?utf-8?B?OTFmL1pPUzhnTVpIRzZERktHcW1mdlk5RjNybGhoSE94L1FJTlJpVUhhb0M0?=
 =?utf-8?B?ejBOSVBTYzQzdXR1OVcraFJVZTdOYWZqcUhLSFJHcXRDcEF0S0xpKzRObDhP?=
 =?utf-8?B?TVlXRUZvMWhjZ1k5QkMwWkljWHdMSDZLUVNaL2tqeU1XWUNlOHFucE5XamlR?=
 =?utf-8?B?c2FMUkRwTGt2cXIvVk5odTlRLytqeFlBdXVoNUMrTDF5dFNLWEVuWXpLSHFu?=
 =?utf-8?B?ejJIUUlteVVRaUVXbk1ENnV0L0VJay94eEszeWhGRm5JU3B4WHYycVptdGNn?=
 =?utf-8?B?c3hWUSsrbWdkck1IK2ZlQVZvVkF1djNEM3ZVcld0ZHNrczRYWHQ1WEZ5bDNC?=
 =?utf-8?B?SVRDcDdwUFVSbnlrUVE2ZnovQWZMczZVYWlMQXZvZHpGZVRkMEV4a0szVXZG?=
 =?utf-8?B?aGljRTBnaTdnV2o0MXFCN0NiUUFTUFlac3VwRkVyZ0FvN0c0UFBld2M5UGlL?=
 =?utf-8?B?d3hWaG5iZTR5UkQ1RkNwYXRxY2xLZ2trbktCZEtYcnA3anhhbkttVDdRWU5H?=
 =?utf-8?B?NlhGNFVLT0x2RStsZEtVZ2ljbmcrb3NBcjBYQm1Tdm53dTB3RHpydHM0cXAz?=
 =?utf-8?B?R2g3c01BSUFiRm1XRldLK3FKajh1UFJjRmxSOXVqaGlXT2FGeEYzVmpjVTZL?=
 =?utf-8?B?NUE5R25SWEhZbGhpK1ovV2lSY0Vkdm1xSkxCWnR6d3g4MjRybXlaT2xTWGFX?=
 =?utf-8?B?TGVSMHFxeUx0ei91QnZzei9TcUdQTGx5Vlo2WEFYcVZ4OGMxL1cxNmp1MlJM?=
 =?utf-8?B?Nkp4L0tjcE5pMlNkdXlmZFdhZ2NFck51dzg2ZFd2WHRHOGdwaDZLS05FWjdN?=
 =?utf-8?B?cllOV01LOVZoZElkZmxzMWJ1WW5YWHV0THRJcVlFc28rWDBuWU0rRk1iVEsy?=
 =?utf-8?B?Z1BKK1hZSEU0WEZ4U203L0hsbVhFY2FPa3ZpUXg1Vkhrd2JrLy80SVY3S3JX?=
 =?utf-8?B?MVRFQnJ0NXUvcndFWTlFQ2k5NzVKbVVGUE1BU2JETjFXY256c0FZT0cxQUtL?=
 =?utf-8?B?elYvenZaV24yQVpvVFh2OWU2UmloQ1N5TFQ3Q29vU3NiZGdycy9QY0x3Ris3?=
 =?utf-8?B?RXB0WTh3WnhpSm9YbGRId2t4WEFoOW1kL3AxOFpzaWhUZExNbHdyTDF4ZTlU?=
 =?utf-8?B?T3NuS2JCSlMzd2VOMDBtejBQclBIR2tNV3ZJb3pxaGZ3QnFRNjhnZmdOQWNX?=
 =?utf-8?B?Y2JibFZJWUwraXErdFd1NHBqQ2tIazRDODJhY0E4a2VGN05pL25zTWx2bU1i?=
 =?utf-8?B?T25JVTRTMHlFUzcrdG5WTk9GNWlsV3h2SHFCdVJLSWVVUFlHYmpoQUJQa2ps?=
 =?utf-8?B?WkpSZWoyb2ltb0creGpkOUpVZ25rOENITWxKL0tuc2pFRFhlaUMwRTRYazNz?=
 =?utf-8?B?NnJEVTUyQWNkN0NKZ0FkcHJ3eGJBY3V1TmpVcVkyeS91QVpqRmhqa0xOanF1?=
 =?utf-8?B?dkk5UWJqMlRoY1h0aWNtL2NFMWlRQmpHdUFxQ3A2M2ZiMUtCUmtaeXZMV1pa?=
 =?utf-8?B?WWxPUzdSZk0rMnpsWlZPcmZONEs0cnBpNGNUYmlMdDJrN3BaNWVTaHhNODJn?=
 =?utf-8?B?cktldHVxVFJPWEwxK3BMNkJQNHNFRjEyaGdXU0Vuc216TUZDZER1NEJSWlhv?=
 =?utf-8?Q?mmIw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzJYdVlSeElpdXhDYnNRNWpsNGhCOThHaU1XeURPNjBNeWk2c0ExVzJ6VU5G?=
 =?utf-8?B?bllud2pPcERUZHN6R0g0OHU3SVdKZFdFZ05JZUNNVDRITXlpSm1nOFY3QU5p?=
 =?utf-8?B?SitSUEhFU0NnLytqeVVmUHFBTzl5VmxFMllJM0FZNDJpRTQzOFRqeW9tcHZN?=
 =?utf-8?B?NjIrNjJrZ2xXRWxtQlN1c0lobW54ZnJjd08zbHBtSlZMWW9va0Q0NC9ZMFRk?=
 =?utf-8?B?VEJ2UUkzZGpmZ1BnRDNjVno2aVc4V1NMMFM1RHEwWEpyWDloK1V1ZnVLVWUv?=
 =?utf-8?B?cWhpQnVVME5UT1BNVi9Ga3R4WE4xV1R5UUh5QkFHcXF5M0c4anE3b3BYdTFh?=
 =?utf-8?B?VS9qTzBhL3JWd2JqeElwTHRqY1g0cnhxWStvWWFNMzMxSmZwT3RhVDEyUjZU?=
 =?utf-8?B?WEZOajBSUTcyMEhZbWgwSitFaUtSWE9rNkRqTTd0ZndWNnM4dDh0MGQvSkhr?=
 =?utf-8?B?Q1N5RE1kU3VwQnF2VytaM2lJMTg4TU0rclh6NlJzSjIrOHBYSlM1cHhKVTZ3?=
 =?utf-8?B?VmlMenFMNHd4eVUvQ3ZwUmdvZGJXUXhSUkhOZFpJVWZGWlJrNUttd2Zjbjh0?=
 =?utf-8?B?bjErNFRZWGUrQ0RXZUh1cnQzRkd5TC9xSFMvM3dqckE1bTh6QVl3Y0hsbi8r?=
 =?utf-8?B?VGdLVjNVVmJ5R2h1dGRDMlRMOXZkTktKWFpZeVlxakE2QlRyR1h0aWFOMVBK?=
 =?utf-8?B?TkpSZjI4MUE5WWZNRmNSVnJMa1lUaTR6VWs2dm04SHIxOGMyS1BxRFRobXh2?=
 =?utf-8?B?YW1VQVkrT2U1b1VXclhZWlRkS0FjbVR4d1lqN2NSc1pKK3c0VVZjRTBhUHlk?=
 =?utf-8?B?Qk9QKzdFREliVkFLdjBsK1UxNUxOaVlGMkozbUNURmIyRTRiVEdxUmZrS215?=
 =?utf-8?B?NHhpVXJsUlNmWTFqRHo5SUJ0bE16VDUvOVNDL1ZFQ09HRzhzWURjOXR1NWht?=
 =?utf-8?B?d1dqMkphZ3Q0Vkw1bEFFWk4zbmlsV01Jc2IzUUFQNmNSTDJrYTN6VjVrL1Bq?=
 =?utf-8?B?RzF3VS9tenNPVGtoVVpxOTN4WGlqRkYwRnY3QksvSHFPSzFZNkpDOEZxbWZi?=
 =?utf-8?B?R2N1RHNzSjdwREpEeUlUZkxadTZ2M3hWS0cxSWx6U1lVT2d2bnplMUV0MUNj?=
 =?utf-8?B?TGNZdVVwZVdaQWVuVmgwZHJaQXVzVUhqZTIzRXc3RHdaekVqbWpxSHpYRzdx?=
 =?utf-8?B?T2lPN0s5eDkwQnlZQVlHMlF0ODV0bEZ1alZvZGJpMWYyYVNzOEpZWVpPcU5y?=
 =?utf-8?B?ZkJFbWdlMWRCaHNvYUtrNHNEZmtDWTFIMG9XdUFSdmZRaDhqeExBbXNJOGVz?=
 =?utf-8?B?V2d0RFpZOWJMRnZ4amJIMk9iQzR1Q1gwdzdtL0dnQ0loMDlLc2huYkFEWllC?=
 =?utf-8?B?RDR6ancrWkFhZDVTdHlvWlRxb2N2em5mSWQ4bHZLREFnSlFDZ0w5dHBuMlFP?=
 =?utf-8?B?N2lJRnhzcjRoT0YycVNjeFNhN1J4T25adDNad05sMXNHOXR6b0xoS2NRTHVx?=
 =?utf-8?B?dCtKWVlVeE9kNmlsVXVlV3hSeS84ZHlsN3g2aEpIcTNQbklKWFRzT252ejdG?=
 =?utf-8?B?ajlsa24xWktETVhMZ1hIQ0hsT1l4cWJmcFBXUWd6d1NXQUg0dHRNMkdXT2t4?=
 =?utf-8?B?TWpJR0k0RDlWdHFDdmJISC9hWDRRaDJTc3ZqZDVySllGTnNVYktkQ085V0c0?=
 =?utf-8?B?cHdYR1ZDNmptRkJpaXU3MVZBd05hcnBkVTNXWFB6aG15Q1RNUkxkSlhFaXRD?=
 =?utf-8?B?QWtqeHlGYWtoOW5YS05Jb21jTmhFa1U2ekp3MVVPbFVldDIyV1hoMDBQQkdq?=
 =?utf-8?B?VForckxJUTk2VUVKemlCcGNVU0NYQXBUVmJpdE1TdkVycUpSbXpKbzBRRzhE?=
 =?utf-8?B?NHVJZFYwK1kxUUIvaEdMZldnQnhyVTk4TjdEUjVQV2tKbHQyL3BOdnZweE9C?=
 =?utf-8?B?bWtaTzFyTG55bTFPRGhuekY0L2UyZDVJZll4bnZEWXk5YWUvdXNvb0NmeWpX?=
 =?utf-8?B?ZUZKZ1ZLVjRDSkJBZlRmektmWnFNMmRWNHFIY2c2YTQyaHU5amRKWEY2bGRt?=
 =?utf-8?B?djVHNmQzbTdCY0M3RTdWOXJlQmlZaWFrUzVKNTZiK2tDWURkMXlQNzg5YXJj?=
 =?utf-8?B?YVpEMEJ6ZHVnTUdUYVhuRWFNaE9OOGRmRmF2ZVpFcVhWMlpDSzZlUnRZZmlu?=
 =?utf-8?B?RzAvekhKQ080NWJVemtUNWFJWG9ORzIxOFIwdnR0UVNqVnpPTWRZc09IYVQ3?=
 =?utf-8?B?UFJhRUtualo3UnlHNzY4QnJNVzQvRnVLeGltUHhaSUNkRVFPdkVyWVh0bVFY?=
 =?utf-8?B?cTJiaUtwaW5Rc0lRN3k3RDV6OUhmVFY2VkxUZEQrMkNIczBWSGhJdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bec46e-accd-4b4e-152b-08de70bef642
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 20:31:01.4037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ebFuzCb1QjwE3Q2N65VSqVySneXJW3T9xt8fEJ+COQ2cuAzhx+JHqBns4GM2/D0DpGe+xi0MOtg2aiSdCKbXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770
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

--------------r0v3Id2y6bC2qK25McPIUrpX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The entire series of 7 patches looks good to me.

Reviewed-by: Vitaly Prosyak vitaly.prosyak@amd.com

Yes — for SDMA 5.0 the maximum COPY transfer size should be 1 << 22 (0x400000). I validated the limits using the new IGT tests.


On 2026-02-19 11:02, Alex Deucher wrote:
> SDMA 4.4.x has increased transfer limits.
>
> v2: fix harder, use shifts to make it more obvious
>
> Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index a35d9951e22a9..44f0f23e11484 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2604,18 +2604,31 @@ static void sdma_v4_0_emit_fill_buffer(struct amdgpu_ib *ib,
>  }
>  
>  static const struct amdgpu_buffer_funcs sdma_v4_0_buffer_funcs = {
> -	.copy_max_bytes = 0x400000,
> +	.copy_max_bytes = 1 << 22,
>  	.copy_num_dw = 7,
>  	.emit_copy_buffer = sdma_v4_0_emit_copy_buffer,
>  
> -	.fill_max_bytes = 0x400000,
> +	.fill_max_bytes = 1 << 22,
> +	.fill_num_dw = 5,
> +	.emit_fill_buffer = sdma_v4_0_emit_fill_buffer,
> +};
> +
> +static const struct amdgpu_buffer_funcs sdma_v4_4_buffer_funcs = {
> +	.copy_max_bytes = 1 << 30,
> +	.copy_num_dw = 7,
> +	.emit_copy_buffer = sdma_v4_0_emit_copy_buffer,
> +
> +	.fill_max_bytes = 1 << 30,
>  	.fill_num_dw = 5,
>  	.emit_fill_buffer = sdma_v4_0_emit_fill_buffer,
>  };
>  
>  static void sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -	adev->mman.buffer_funcs = &sdma_v4_0_buffer_funcs;
> +	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) >= IP_VERSION(4, 4, 0))
> +		adev->mman.buffer_funcs = &sdma_v4_4_buffer_funcs;
> +	else
> +		adev->mman.buffer_funcs = &sdma_v4_0_buffer_funcs;
>  	if (adev->sdma.has_page_queue)
>  		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].page;
>  	else
--------------r0v3Id2y6bC2qK25McPIUrpX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p data-start="0" data-end="48">The entire series of 7 patches looks
      good to me.</p>
    <p data-start="50" data-end="102">Reviewed-by: Vitaly Prosyak <a data-start="78" data-end="102" class="decorated-link cursor-pointer" rel="noopener">vitaly.prosyak@amd.com<span aria-hidden="true" class="ms-0.5 inline-block align-middle leading-none"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" aria-hidden="true" data-rtl-flip="" class="block h-[0.75em] w-[0.75em] stroke-current stroke-[0.75]"><use fill="currentColor"></use></svg></span></a></p>
    <p data-start="104" data-end="238" data-is-last-node="" data-is-only-node="">Yes — for SDMA 5.0 the maximum COPY transfer
      size should be 1 &lt;&lt; 22 (0x400000). I validated the limits
      using the new IGT tests.</p>
    <pre wrap="" class="moz-quote-pre"></pre>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-02-19 11:02, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260219160224.1976043-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">SDMA 4.4.x has increased transfer limits.

v2: fix harder, use shifts to make it more obvious

Cc: Vitaly Prosyak <a class="moz-txt-link-rfc2396E" href="mailto:vitaly.prosyak@amd.com">&lt;vitaly.prosyak@amd.com&gt;</a>
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index a35d9951e22a9..44f0f23e11484 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2604,18 +2604,31 @@ static void sdma_v4_0_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v4_0_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 &lt;&lt; 22,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v4_0_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 &lt;&lt; 22,
+	.fill_num_dw = 5,
+	.emit_fill_buffer = sdma_v4_0_emit_fill_buffer,
+};
+
+static const struct amdgpu_buffer_funcs sdma_v4_4_buffer_funcs = {
+	.copy_max_bytes = 1 &lt;&lt; 30,
+	.copy_num_dw = 7,
+	.emit_copy_buffer = sdma_v4_0_emit_copy_buffer,
+
+	.fill_max_bytes = 1 &lt;&lt; 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v4_0_emit_fill_buffer,
 };
 
 static void sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev)
 {
-	adev-&gt;mman.buffer_funcs = &amp;sdma_v4_0_buffer_funcs;
+	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) &gt;= IP_VERSION(4, 4, 0))
+		adev-&gt;mman.buffer_funcs = &amp;sdma_v4_4_buffer_funcs;
+	else
+		adev-&gt;mman.buffer_funcs = &amp;sdma_v4_0_buffer_funcs;
 	if (adev-&gt;sdma.has_page_queue)
 		adev-&gt;mman.buffer_funcs_ring = &amp;adev-&gt;sdma.instance[0].page;
 	else
</pre>
    </blockquote>
  </body>
</html>

--------------r0v3Id2y6bC2qK25McPIUrpX--
