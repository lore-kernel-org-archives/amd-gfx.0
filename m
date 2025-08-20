Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DA2CA0EFC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 21:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F8210E28B;
	Wed, 20 Aug 2025 21:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uj3w/MRz";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 877C510E28B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 21:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YK5erB4R9pSGrPhPNN3wtXRlYEAIu9yFGUPltCVbcIHvjitD4fwJizm6R4UEUIbIDBUAw8yefj+w04rFBNet7nDlUxwMfUrVLHvgQVFOBWmESKNbZbE3xxJZ8FccdZpyNkcXJmTLYxQEympSO90n68NUNB80VJLzBtU87L+mB916+0YfChFGwrE+YlYOCAsUktWuy0Cm2HgNWTOubS+k8tXMXLj1AdGQNa+IDsK2CrX4vo/sfMgKlOyDbqj5V3VnCQN7KAMGwMHZ5kNm4on+OMOvIGUg4d9pnrpJ1vOFNEJZZkqTMQPQ91zxSwxnkfKYG81vW37B/C1um1J2zuPczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fdYfrI53RDvDtBGh5/eHVmoXY/SekGPuKqS+zTfF6w=;
 b=BywQMvGoK4p7DeBKJr7jiWouh5VAXbsSa3a+Egwnin2J7KY3J/Upf0IouYGL0JV0P+esk/MP0XrqNANLME6QF0Q8t8iJR6PaPfqS0fOV7rc+EbxtfKxfKnAVMu4FrHDLCsqq7ucdiRBnj2gN8JojnfSj6LIp/XXmeb34RzwavqRHMpwbwJLLIZO9NUp5/rLYsWR8FtKQZg2kaN/5k5PeVQZUhVV28g49EcD4oF3nEcxar4gq0J+n9EBO/vz9lAYnYYwg0h4Zx5Fsrh+wflUxHvRaSwHl3WbUY8vgPowEwQx7pI/zzIwo3zcIIk87uKryrRZ+i5AvT94cElDLBBFStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fdYfrI53RDvDtBGh5/eHVmoXY/SekGPuKqS+zTfF6w=;
 b=uj3w/MRzCRPHMn5OCWLtQ7nJLSs9Th/CySFXDrojLVDl51sI1r7caczf5Nc4TaPtm2EN/ESqY99TvMyDxK+aDg287YIDj1EsMwkInQacSomfykwrWZWugkMmn5DrNIbFPIrDlNQEB8hPA5+LGhFWhphCChDkwesNySLir20YX/U=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA3PR12MB8763.namprd12.prod.outlook.com (2603:10b6:806:312::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 21:00:26 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.9009.018; Wed, 20 Aug 2025
 21:00:26 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC PATCH 4/7] drm/amdgpu: Add mmio_remap fields to amdgpu_device
Thread-Topic: [RFC PATCH 4/7] drm/amdgpu: Add mmio_remap fields to
 amdgpu_device
Thread-Index: AQHcEcZBP5O+rknIiEy4OTevG3f967RsBwKA
Date: Wed, 20 Aug 2025 21:00:26 +0000
Message-ID: <BL1PR12MB5144B533CFA6A83FC47B1A8CF733A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250820113254.3864753-5-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250820113254.3864753-5-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-20T20:59:19.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA3PR12MB8763:EE_
x-ms-office365-filtering-correlation-id: 37cd6c61-1352-44b6-27b9-08dde02c9665
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?WU9rVlJST0pLZDlCYlgzSncxTDQxZllDRWVhYW91OXZ6dloxNk94LzduTmtw?=
 =?utf-8?B?ZkM2NzNiME1iUzUzL3M5MVNMK1dRVjYrZ0N4dlcxN3hlaFBlVy9WVWhhMHhC?=
 =?utf-8?B?elcydDZWUDh6TW15STZsWnNvY0Z0OTBFNkFUdk02UG5nZCtPek1lRlFJNEgv?=
 =?utf-8?B?S0VCdHI1ZTJuUE9QVTFiMHEwc05EN0M4anRsbGZ2OWRuQ01Ud1pURGJrK0NR?=
 =?utf-8?B?TGhvZWZnR3NUaCtCMG4rRlVuS3NLSmNJSkJ6K3FFT3k4UFlEcXZDa1BjZk9r?=
 =?utf-8?B?NDVmYjVqU0drbmx2Zzk5bmZUQ1NVOHQ1ZUs3NUtXWXhURmVaQ3BUUVM0eHlE?=
 =?utf-8?B?ZkxYMzBrSDFoRThXdHpNTWlUU2lPNWVWWFF1ZjJSck04WkZmM05lYzdIMmJt?=
 =?utf-8?B?QkZKYXVodGFSc0hhaU1QbG5ZQzdadkRNYUFHd2dhZjVSb0w3NlZqQVIwamlz?=
 =?utf-8?B?aDlnY2FVdmJtT1lUTllMNFhYT1dwWVpHclFITmdQRVVrbWRBR1pTMHI5bDFP?=
 =?utf-8?B?aGJSd25yQUZ1TW5iTnhRdzdaVGZVdHZHSW9aN1hsTmFLQXZCdUNUNnNRRnRD?=
 =?utf-8?B?UG5TL2Z6YnQxMXcvRzhBeTlpeUNhUWNibVNTM3FPazNLbmdWYnZDRjJNTWZC?=
 =?utf-8?B?eW9hVEVST2MyM2lDQVNSVFpRMTQ1MzlwOEN2RXA0VkRuUHcrSkMwbWh5cHd3?=
 =?utf-8?B?U3d6SUJ0SHVWbkZVSkM4R0RPelpOMVl3Y1ZrTWY1VUtuS2IwL2RLbzRKUmxp?=
 =?utf-8?B?RXdnRElrNUcvaHFCWEdOODFSUlJXUVFRdk1kS1BNOU5PNkIzazg3ZStrc25w?=
 =?utf-8?B?SU1mTXQrS0pvM0lvWWNUc3Voemt4eXlqeTNOUWM0STgxNnM4YVBSMDl3V0F0?=
 =?utf-8?B?b0swdXFKOGtkU1hPT1pnNjViZGdlNDJDejVWYW5tUlJkMC9aOWpjVXE2WWd4?=
 =?utf-8?B?U040VW8ybSt0bk1USmxjVHhvUjBGVW5HNEMwbGRYZWdpVmF6SExWZlFuWmNk?=
 =?utf-8?B?a2VRakw5SlQrMDJubVJ2VWNUd1JxOC9wZmdyUnlOdXVjNkZoY2g5OXhQN0FF?=
 =?utf-8?B?cHJpdUtmQ1hFa3dyaEdJSmlLR1JOeDE1RzNpT3hIN2FwK1N3QzcwWG43cU9B?=
 =?utf-8?B?Z3lybTRLcTcxeE1qT3MzYy8vdnB3U1JxQWxhNkwrVHR2QTg1NTBRdWROVGhi?=
 =?utf-8?B?TStEbC9FU28zODRONDJpcFRGTWdLTHRjRFZqS2wxdFcrbER6R1EwTnJtOFBT?=
 =?utf-8?B?SE1veXBhMGFUbDB4VGtHY0YxK0ZCSlAvVW1TNHNOdUFDSHBRQkg0Q01ONm1W?=
 =?utf-8?B?UkRUd0M5MjVDSjByT04zQUNyS2RXc2k4UGl4N002SU95TnlVbDJ3RkswRDhF?=
 =?utf-8?B?RHp1czRqSDlkN3oxZitGTlB4QVdlNjJqSitRMEtTSGIzdlo2WE95a0l6U2d3?=
 =?utf-8?B?WHRGQVF1Vi9ORnY4SUVxbTIxZUlqekttSnhIV1ZUMndsajNnK0JQdTloQkFN?=
 =?utf-8?B?MUhOdUNXZzNIaTlZUGtFUWJhSzhIeG11bEpidjNxei9kUWNQY3ZQV2RzeFRN?=
 =?utf-8?B?c0RGalEydXNidGd1eUd1Z3F5UW5jUDN2RlhSMmgrTTBvcFpJQWltY1JZaEov?=
 =?utf-8?B?Q3dCYXdnWWRtSC9rdDEwYzFLSHlraTh6akZyeG9qRTMwL2JaZDk2S04xc2k4?=
 =?utf-8?B?ZTR4V0tsNnI2YUFneTd5WUgzU245Y2xHZVhEdDZLM0RDeGxRZjg3K25xWW53?=
 =?utf-8?B?WTNaZXdFVEZUeENFOGdiS3NKOUlSS3U3RkU0OXlkdUg0djRRTjl0b2ZLU0Nu?=
 =?utf-8?B?Tks3Q0ErQ3NWQUVrNFAyTVV1NEFaYS9Odk05MWZjajU2Tjh6czhXUWNCSXp3?=
 =?utf-8?B?RzJ4Sk82azUxMkdZcDRQek1KcEVVMFFUY2U4YzRoSytYdkdVWGRyb2RERXJv?=
 =?utf-8?B?RXhjSVkxOVFZZzVxRGRHT1poNEpjUzh5KzM1T1RER3lxTm5HQ3RRM1MyZXpU?=
 =?utf-8?Q?H6UHRSB+SOV1M5TA4F4L8MBvavcSC8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTQ4enNJcHV2UFZTQ3cwS0E3ekw3dmIwZW15ZTR5VTBFNVVQV0diQ1laNVcy?=
 =?utf-8?B?K1Rkc01ETXlWRzZWQUdSYlFaMmpsN2NqL3ozRzYwRWNMM20vK0c3dGdiVkpj?=
 =?utf-8?B?OXV0OFRwSTk4YU9UQ3pHeWdzbURvc2dHeUZHdTJoT2U1L2tMeDNTSFQ2VmRx?=
 =?utf-8?B?YzJDL3FydVJSUVB2cFNsZ1BMbDJNcU9ISE5MdXViQUtpTmtmSDdMR1RxNjNN?=
 =?utf-8?B?YStBRW5HdTNZQStvUzJIYXJ3b1ZWVU1BRlJMRGpkbTduS2J2OVpwTUVPMGVs?=
 =?utf-8?B?WVVoMXlZRGYySnpubnJkQTNEZVR1Z1o0UlRMTStNa0pOODB1VjFYM1ZkRkZI?=
 =?utf-8?B?eGtwcDIvL21oRzRxNzdVTlh6YmQ3a01QUVZTWmlsa1Z0emNEK1d1QUJ3aHlh?=
 =?utf-8?B?VFJqelU2akZ2RXJjdGhrT00yNXZ5cGhiaCs3OXN2WGZXOWMyd2RUY1hhd2Jl?=
 =?utf-8?B?V3VlVUNESDhtK29vRFF6T0pJaG9MMjVXL00rb3FFb1owbTF2cTlDNmV3K3Br?=
 =?utf-8?B?eG9nTW4rZzdzclhvSWYyVTFJQk5KbzhaKzgyQXNxV1ZGekEwbUEwZ0tCOE5s?=
 =?utf-8?B?NnhpY09GR1laa0tLTjR3SGtQNlRqS0pUOFh2cTZMSjZNQlNIK0NSdXFETmUz?=
 =?utf-8?B?RlhoSVM5a2JpWlNqWnlhOE52RTFoQWlzU1c1b1ZGdTVNNVVxM0g0QUpvUGxu?=
 =?utf-8?B?bEg3OU1GM2NHUlFqcWJONEJZNEJUTkRJZ2grRlMyMldHczdjUnUyN3NWb0Zy?=
 =?utf-8?B?dnJpZkFteHNQdWZiUWVpOGV2UGNCanFaMnZlM05vTTM0RkFkb1V4eldTTk9S?=
 =?utf-8?B?KzhSQVhnY08waFFWN3J5UmtqR0JxUGk5bE9nbHhXY1BJMDcwemczakxFemVO?=
 =?utf-8?B?UUxIZFNmWE1BZGZzR3MyNm5vcWN2RW5WYi9RSW5ZbFZPR2tINDNFUGkwUDBP?=
 =?utf-8?B?VUZjMHM0bzM2N3JMM2FtVXl1ZGlYZzRJM3RtemdxVU0xQXp6NXdGdkc2ZDNU?=
 =?utf-8?B?VUJXZFhSZFZKUkxvSS9LbHRKN2pzbVNWbDUyN1FFaHNHUWlTMTJyZTQrVmZC?=
 =?utf-8?B?NDllL0IwSUFKYUdkUndpVEdQZm9hOWdib3pudXF6QXNJZXdjU1lNeGxyUFNx?=
 =?utf-8?B?akJVN0N3dmtIY0dlVDZtNTZ6WDRSbWNkbEJwMW5VL1B5bHU4ZXp4RXZLOU1Q?=
 =?utf-8?B?aFNMYkc1Z1FjL3pPaEt4WDM2MmYraHkxcnM0N1piaHl3VVloQjFidE4xUFZn?=
 =?utf-8?B?L3M5a2ZsOUtSZ2JnUU9RMzE2b0djcExVS01rOVRUcUNzVFhka3hGM0l5SHVp?=
 =?utf-8?B?VVVVTVAxU3kyOURGZHVLaXFzeFdxRStkVDRhbmxZcmJlc3l3QWlqd2lWU1Bx?=
 =?utf-8?B?M2p6K0EzZndjV0RmQ2xWSWJ4NUNoaGpCVDRIOUx1SzNoSXhKNGZLOCt0RnFj?=
 =?utf-8?B?VW9LWSthN00rTTY3U01Bdk9VM2dkVkFxa2dma2dFak9rRHVoV1pWK3lhWldR?=
 =?utf-8?B?Q0tLdXJucnduUTdyYVYzSFFTU0FvTUlrSnAwenhOR0N2ejdCcVB4YTIxbGc0?=
 =?utf-8?B?OFV0SVRGc3VjQ1Nmd24yV0xBUVFsU0U0R2FsYmdSelNGTVlhOTVHUDUwUndx?=
 =?utf-8?B?cFZmQTQ0WGdjZTFITEE3RHRYSUFoQWxMdVVRc1VRd3dhT2JlVExDYk9hbTBk?=
 =?utf-8?B?VStHSEtqVjY0WWx5dUhGOFpGSU5STjBheWZXOWR0N1cxOXo2NTFKK2g5djJv?=
 =?utf-8?B?aytWYnRqaDd3cExIRVpvTnUvRXhHZTlCNGdWSzBNVVVFYXBsb2Z1aGhNUzZr?=
 =?utf-8?B?SlJnZ1E4QUlLNnlVaDh6cXJMT0R4U0pZUGlQcEZtMisrelBkeERBVTNBNXNO?=
 =?utf-8?B?VzBXRGtZUHBKb3NpS09NbUpaWHFabmdwdXVSRzJDR1JwcTFrMUg4V1YxRE52?=
 =?utf-8?B?QWlBUkZjTjNvTmd5a2ozYnBqZlUzOW5rZGZHc3QxMHRjZTFmRWVHN1NNM3Fq?=
 =?utf-8?B?Mk1kSC9Qc2ZBYUc0WHdRUUlCaTl5elpOckoxOW5ZUzVhS2JEVUFVNGFQL1Mr?=
 =?utf-8?B?ZXZEd2xhSFhVR3FoTTFoWEs1T1o0S2VhRjM3cTRwL3BHV0pnQ3dpeEphNEJs?=
 =?utf-8?Q?G+mY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cd6c61-1352-44b6-27b9-08dde02c9665
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 21:00:26.2723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2/81IKWcy+hjKXv3BF3ULUZ99xFL48Xb5wRJP/WIftPy6aJQQOIQ4KpubUx4lYdMMra/14syplQzSf5QkdR8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8763
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTSEFOTVVH
QU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgQXVndXN0IDIwLCAyMDI1IDc6MzMgQU0NCj4gVG86IEtvZW5pZywgQ2hyaXN0aWFu
IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzsgU0hBTk1VR0FNLCBTUklOSVZBU0FODQo+IDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29t
Pg0KPiBTdWJqZWN0OiBbUkZDIFBBVENIIDQvN10gZHJtL2FtZGdwdTogQWRkIG1taW9fcmVtYXAg
ZmllbGRzIHRvIGFtZGdwdV9kZXZpY2UNCj4NCj4gQWRkIGJvb2trZWVwaW5nIGZvciB0aGUgcmVt
YXAgcGFnZSB0byBzdHJ1Y3QgYW1kZ3B1X2RldmljZToNCj4NCj4gKiBtbWlvX3JlbWFwX2JvIChz
aW5nbGV0b24gQk8pDQo+ICogbW1pb19yZW1hcF9iYXNlLCBtbWlvX3JlbWFwX2JhcnN6IChyZWdp
c3RlciBCQVIgYmFzZS9zaXplKQ0KPiAqIG1taW9fcmVtYXBfb2Zmc2V0IChCQVItcmVsYXRpdmUg
b2Zmc2V0IG9mIHRoZSByZW1hcCBwYWdlKQ0KPiAqIG1taW9fcmVtYXBfc2l6ZSAoUEFHRV9TSVpF
KQ0KDQpJdCdzIG5vdCBQQUdFX1NJWkUgaXQncyA0Sy4gIElmIHRoZSBQQUdFX1NJWkUgaXMgPjRL
IG9uIHRoZSBzeXN0ZW0sIHRoZW4gd2UgY2FuJ3Qgc3VwcG9ydCB0aGlzLg0KDQo+DQo+IENjOiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IENjOiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNyaW5p
dmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIHwgNyArKysrKysrDQo+ICAxIGZp
bGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdS5oDQo+IGluZGV4IGRkZDQ3MmU1NmY2OS4uNmM0Nzc1OTY2MTdiIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiBAQCAtMTAzOCw2ICsxMDM4LDEzIEBAIHN0
cnVjdCBhbWRncHVfZGV2aWNlIHsNCj4gICAgICAgYW1kZ3B1X2Jsb2NrX3dyZWdfdCAgICAgICAg
ICAgICBhdWRpb19lbmRwdF93cmVnOw0KPiAgICAgICBzdHJ1Y3QgYW1kZ3B1X2Rvb3JiZWxsICAg
ICAgICAgIGRvb3JiZWxsOw0KPg0KPiArICAgICAvKiA9PT09PSBNTUlPIHJlbWFwIChIRFAgZmx1
c2gpIGJvb2trZWVwaW5nID09PT09ICovDQo+ICsgICAgIHN0cnVjdCBhbWRncHVfYm8gICAgICAg
ICAgICAgICAgKm1taW9fcmVtYXBfYm87ICAgLyogc2luZ2xldG9uIEJPICovDQo+ICsgICAgIHJl
c291cmNlX3NpemVfdCAgICAgICAgICAgICAgICAgIG1taW9fcmVtYXBfYmFzZTsgIC8qIFJFRyBC
QVIgYnVzIGJhc2UgKi8NCj4gKyAgICAgcmVzb3VyY2Vfc2l6ZV90ICAgICAgICAgICAgICAgICAg
bW1pb19yZW1hcF9iYXJzejsgLyogUkVHIEJBUiBzaXplICovDQo+ICsgICAgIHJlc291cmNlX3Np
emVfdCAgICAgICAgICAgICAgICAgIG1taW9fcmVtYXBfb2Zmc2V0Oy8qIEJBUi1yZWxhdGl2ZSBv
ZmZzZXQgb2YNCj4gcmVtYXAgcGFnZSAqLw0KPiArICAgICByZXNvdXJjZV9zaXplX3QgICAgICAg
ICAgICAgICAgICBtbWlvX3JlbWFwX3NpemU7ICAvKiBhbHdheXMgUEFHRV9TSVpFICovDQoNCkFs
d2F5cyA0Sy4NCg0KQWxleA0KDQoNCj4gKw0KPiAgICAgICAvKiBjbG9jay9wbGwgaW5mbyAqLw0K
PiAgICAgICBzdHJ1Y3QgYW1kZ3B1X2Nsb2NrICAgICAgICAgICAgY2xvY2s7DQo+DQo+IC0tDQo+
IDIuMzQuMQ0KDQo=
