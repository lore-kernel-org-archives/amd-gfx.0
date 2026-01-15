Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C56D3CCAF
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 05:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BA4D10E074;
	Thu, 15 Jan 2026 05:51:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RbaJJYR+";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B62E710E074
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 05:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1F4SYfWHdbzi3M5NsVpEr02SLv8jw8EhyQSOnHWmgLMcPu9bs5Gg97IrHbhcTA57m/RSsZwGdwgSuEIvtxinbYPkOg0uSHOXzjzkAcLmGgAFDgxeD5/drm1L/Glyj7KxWLbF6fL8FyFYWWSwsnZRBU+npyKUIAml9CohAlJeuqndcyAP9amF9rq8/SF4PHTB9uEO3FRSDX6REoNM9N3R3Yxo3tpAaZqxPtqHCJs6+B6bfsyvx+QPE0MLUWr29ZYkr3hJhdyi50Iu4KntRT3PDS2dr3TAR5p7/hXKX6w+EWT8h9FHR9ZA8Dg1130Dk8TUYsbHrbM2K83PM5F/Ug93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfgK4PHdqZfMq1GfEmj6BupVaTz3Ler5sSsgY0FCdRA=;
 b=sFdN+j0/nA8zH6NPCEZZEfddp5srtDvAsiAlHByO9GqXF//pTmEgv8nXUeJ/uP0CWo13lcsmdbJ1pZBbgNWtkSQzkuqIpIbETN9wg2OgLdn/RdwbPZiUlBSMXPAbVUs9OAU3k15zKxmyPmX5SmnAlMJFCWO+cw6RXpGB+KHANlfqdgyCxXbz4m2Nqhuk2CSZjVW/naefumdJcdIGl2/c+TltXdeeX6bSJTMKoDG7jLkryKQxbaMXD6DqZSI3W8mipZkaW9EYTVCj9LebriymQVPuG6BzvKm9E/dZ+GAX6Brr659/Ibuc7VbTwpB/UnkolptqpuYJZ/idkNCMgvOJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfgK4PHdqZfMq1GfEmj6BupVaTz3Ler5sSsgY0FCdRA=;
 b=RbaJJYR+yqWMPWxyM8EIj1z4/GeD3aNeCabR9hlh/yZ/U3p1+zughIiqDY3QoJelvfdgVA3EKzTMIvXHl5fFUQyp/D4fv4c6E63b/sswipx6TavnKrrJIoyLy5JOehRL2VjRZkPlBD6O/VSRV9x80OPWrTffSaxyKWitgR/uVQ4=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 05:51:15 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::53da:e77e:261e:5a29]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::53da:e77e:261e:5a29%5]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 05:51:15 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Amos Jianjun Kong <kongjianjun@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen,
 Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [PATCH v2 1/1] drm/amdgpu: free hw_vm_fence when fail in
 amdgpu_job_alloc
Thread-Topic: [PATCH v2 1/1] drm/amdgpu: free hw_vm_fence when fail in
 amdgpu_job_alloc
Thread-Index: AQHchcqCjdUV6mNHsk2q+KAlS1GSwLVSn58AgACePgA=
Date: Thu, 15 Jan 2026 05:51:15 +0000
Message-ID: <BL1PR12MB5849461809B2FD2D6EE07A0AE78CA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20260115025548.621264-1-Jiqian.Chen@amd.com>
 <CAFeW=paBoemhGFkra+qf7CwrmoQSEXKwsLJ1rzS+CL91_3=x1w@mail.gmail.com>
In-Reply-To: <CAFeW=paBoemhGFkra+qf7CwrmoQSEXKwsLJ1rzS+CL91_3=x1w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.9520.004)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|MW4PR12MB6826:EE_
x-ms-office365-filtering-correlation-id: 0f9a5e48-7cb8-4b80-7ae5-08de53fa18af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?N1JLQ0J3VjJ6NkZ6aUZHYVl1RU1XN0ZqK1d1S3o0cEl5OWEwRGZvUTErUHRv?=
 =?utf-8?B?VGY2TC82K3pQMDVseG9FbEx2bUhtMFpSKzl1RnI5ZlNRMk5CWmxvRVFmMTVY?=
 =?utf-8?B?SE9ZTSt5OE5XdjVTempvaExDTXcwSGRQVEdxL1Z5RXhRT0U4cjEzRzdsWFZV?=
 =?utf-8?B?U2o5U0ZLZENVK21JZDJxeWZLU0VKQnNPYnNkeHdHNi9wWWIxRU9GdnRZMlcv?=
 =?utf-8?B?eFljWkVkZWVuK0oxdHhETm1paURYWU5uVWV1VWlzQk9VUU5Ucm9QWnI3dnBl?=
 =?utf-8?B?UmpyT09lQUhFR2hQczc3RE0xTWNUdlViRmVrRnJxTjU1TVM0UHR3aHJpWVVX?=
 =?utf-8?B?N01pemRCblhhZGlIRkkxNGJQbGdFNFdCSyt6ZUlqYWE3eENGN3VBdUdWTy9Q?=
 =?utf-8?B?bHZ3d25mZHhtb0RKZzI3anloN3RZT09KTUxuY0hyRFFsclFxRUlqdUdYb3hQ?=
 =?utf-8?B?UHlZSno4WWV2eUZvcG9jU3FEUUVjL09wSThFbjlrZVhOeTBoSGtXejhLb1Vi?=
 =?utf-8?B?UE9WUytVOUNMRzdXR3pqR3M1cEF2WmNvYy9NbUc0TXNqMlFSWklHU0s1Qmxy?=
 =?utf-8?B?U0gwaW1xYWdZL1lySHNuYnkwdFZkZW1RUEtvdWxOZlFjZXRFNG51QkNadVNv?=
 =?utf-8?B?a2dyUnJkaVJIVDd2L0JXQ3IrMFpiaWNpQ2tYN2FLaUs3M2QwN1dBZUV2dkhY?=
 =?utf-8?B?enI4eHhSOUFsTG1mdStnSXVRaGNmMUViNFZlUThTVjVGRFZkSmpURmd2akVk?=
 =?utf-8?B?b1hiK09pSnRMQ1F6MStxVEp0alR2Nkd6QldDMnl2ZkIzRXVwR29vRUI4V2dz?=
 =?utf-8?B?VUhQSVVkMWVTSnZlc0hPdkRqVnpiNWhUNDgxQzlBUXpLa3kzMkRMSDlQZU9m?=
 =?utf-8?B?dlJzUjlKQXl6aW9Va3crZ0tUS3lPKzd6ZHRkUmJZUWZaQzEzV0EvUSs2aVBR?=
 =?utf-8?B?aHpoM3EyL1VtY085WGFNVFkrZFlBMmVFY09jdFViUEY4ZFpyRUJNV3l1dUpU?=
 =?utf-8?B?MmZNUW8xV3lDcUNWc0VMMStmTUpEUTBYSElJZ21BTWJtV0NzbUJWSHg3YVdp?=
 =?utf-8?B?U1FxYUxqaGRpTlFxY1dINXdvRTFDbFJVaVQ4alNRZ1Z3QWVjb0oxYk9VUlcv?=
 =?utf-8?B?V1hvcGp6UXlxNmg4R1VJSXNzUC80WWtCNXRxUWdpWm4rTXJSTjlkNEFqU2J5?=
 =?utf-8?B?UHhvMFNIQW0wN2RNa1Z5T0pSU3F0VUhWbVc3bDRkbzNIQ2xxWUNOYnA1Nkpy?=
 =?utf-8?B?ZHc3QlhEM2pSMFMweWlJSkd3L3lmaXZyeFBpVHBDak1tSS9pdENXdzNCaWE2?=
 =?utf-8?B?VjREZkFrQ2gralhDVW1aeFo3Y3BJeWdMUm1Oby85U0lRN3RxZmJvOHA5NnA3?=
 =?utf-8?B?eDFDbTJhbzlqZ3lrdjlXazRENUdObU1vQjRyeDFQSk9KWnBnKzQzUzQ4V1ZO?=
 =?utf-8?B?b3FDOXV0Z2wvVkhOM21YaDkzd1Q4a0VrTENGa3VpZjM4dGJCM3c2VkdJZ1Vx?=
 =?utf-8?B?eU9zR280VktNcUcxKzBXd1JkSGllS1lQeVZzVTZCanlsWm1LZlhYdGZEeEla?=
 =?utf-8?B?M3hNZEhlQzM1czQ4a3JtUjMxWHNvRHpQUnRFb2pFVnRpank2M29GMlpkSG5J?=
 =?utf-8?B?Y2tON05rYUI5UUUvb0JyUEk2OSthY01QdlNPQWl5OVJHNkRJSWpnZElQcFRk?=
 =?utf-8?B?bTBUWGRQLzhFNXlrZ0VJSVlTVjl4bnQ3UFJITU9sTGVEaVlyVkpmT3RkN0JR?=
 =?utf-8?B?U1o5RnZaNnN6OVRVcERCVXc1bmhaTVRYS3RtdFp6ME1wOEg4bFhhclBEdUJy?=
 =?utf-8?B?ZnpGaEVucjFzYWFuaHY1Tk1SelNtdk5lWndmc0tQSTFMdzRCaG9DOE8rTmhp?=
 =?utf-8?B?TzhYWm9XcGFOeXVaMFdDRktMR1dGTDFGWGVGQmxDWTR6bEZXbk9WSFo1Z2NQ?=
 =?utf-8?B?TzgvbDdPdm1aK1Q3UW1KVnVIMlBrYVp5cWpBKytHSEp4QnlzOFZ3dGhXRGVO?=
 =?utf-8?B?V0FzZ0FvWldtMDRCbUZUSGdLNzNDT1ZSb3MyUUEzQkVsNTZISEVMNm9CcW5x?=
 =?utf-8?B?UURBWkt1Rm9QcFBPUlNwNGxJMnZDcmdWOVJ5VTQ0Q0lZN09Na09VUVpIQ1cy?=
 =?utf-8?B?MVZPbmRjd08wN2ZDUkJjbHIrbUZtWE9kcVlpTTl5cWVPeFFhbVYydklzdGJz?=
 =?utf-8?Q?uhUmOw32m2h3MgVN+ikMACc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzBUaldmcU4xMFRiYmFFTXNIU1dSOGdodU8wVk1SemFkVExVYzVnRTRma2Er?=
 =?utf-8?B?cUp2b3cwdmxxTm9sOE5lN20xdHAxVU56NmlEcnVUUndVY3FhVzdDalFoL3Fr?=
 =?utf-8?B?L0d1ajBOaENZK243K1BaQ0JlYTBTZmQ2TW9QdGh5VlVrdW9Nb1k5Y3hsSDBi?=
 =?utf-8?B?VkJBWnF4bU80a2FDMEg1VW1xMWcwcW41NjNzL1dDQ0J1ZTJzV0pLWi9NYlFX?=
 =?utf-8?B?Ny8wZ3g3TVdNaVJCN1I2Z3JyZHNiaTFuMjRrRHJWUjNua2svMmFCbkZHL29P?=
 =?utf-8?B?dFByd1NhYzY5WWRSVFQwOFpwTnRZNGxySkxGRDB1K3pWaXdKZjFRcm9nV3c1?=
 =?utf-8?B?YXBIVmNSSWVSOTZDZUNiV1NDN0VDL05peGZaN0h4UGNlNTB2RDZReEh2bVFi?=
 =?utf-8?B?NDlLaWNtOWlmMHRZOHpBaTBtMG5id0F3MWhLaWZNK1BBNWdVbFVlSXhFajho?=
 =?utf-8?B?c1pxSG1Fandtc0VZTUNiV28vaUt2bzdzY2pGd0dRUjhqMG9memJNZ0VZVExs?=
 =?utf-8?B?UUxoZGJJcDFPRzdoeGcvN1cydnlramtTbDR6eHZpM1JzUHc0ZDJreExvcW1v?=
 =?utf-8?B?Yk5ZTUJhTW9QcHZ2U1QrYWdWUXFRclFvYkQ2YmVraTdhSHhVRFhUdUdoVW1D?=
 =?utf-8?B?L1V3cDAzTWwzNXdLbGFCenRwdjAvQWkzN01yN2tXd1Z3YzBaRXY3TE5Pd0ts?=
 =?utf-8?B?VnFEcmRDQUxWdVFTdnN2ekVrUCtvL0I4U01rRHRxdnNoTW9aUDRtQStNd0Ey?=
 =?utf-8?B?OVI4QXdXdFZVekpST0dwMEc3dFFQMStYMEtJVWY0RGY3Z0MzT1hGQlBqMGwv?=
 =?utf-8?B?eWYwaGFvcHpHUGcreU1jMDZHQVJLeUFpOHBma1grVmQvUVlEc3duRzJTakVk?=
 =?utf-8?B?cXd3ekxPelI4bkxKVGtYbG9ZYzBONTI5d0FCb2lUVVlmSE0wQWJENnM5MXZk?=
 =?utf-8?B?dEMwUjdPRXAvbHV4R29hRWFkYWtaOUxZdCsrNlNkQ0VWcjNoME9KNGNMTllM?=
 =?utf-8?B?NDNHSzl5cS9KdTBBTXZGWU5ibjhVWXlKdFFOeVJCc3VmbVRZSEwzc0YwRUJt?=
 =?utf-8?B?SWNWOVhJWUdKSDMxRmNqc3dHaWYwU2k1OUtIK2EvbXVpeXhtVlZ1ak1EdU50?=
 =?utf-8?B?YTdTYi9Qa0J5ZmpGbVBsMWFVNVg1VWNYZVVsRGdIdnpEdndjbXNZSHJ4Nkk1?=
 =?utf-8?B?SVQwYUdPWWV2RitLVm5iT29mVTE0ZFB6UC80N09ybkZDRlQrYjU2djMyU2Ji?=
 =?utf-8?B?MitrMFB4RGhMRzBERGdrTUJLZklIME01RXIzMUxLMmVzZ1BDdHZZRjBQNit2?=
 =?utf-8?B?dnJqU0NJeGV3Yy93dUhPUHYxazgrLy9SaUh3RXhIemxhSDFveXNCa3N4eFZj?=
 =?utf-8?B?cXpxTm4rL3dJbjRBUm44Rmw5ZVM5K0dSZWtqNmY2L2UrZFVvM3dBS0ZhSHdE?=
 =?utf-8?B?aW5UMTE4a2NmVy9ReWZMMGpiVFU2am8yU1BZaGRxeC9HcDZtcWdqN252TFBO?=
 =?utf-8?B?azA3SERUYjkwVHd3ZEJPKy9ub0g0azAxT05tNWx1NkhsU2tYa1NuSGU0ZGta?=
 =?utf-8?B?d2dBa2h5VGhZRlo4dFc2K2lqUEFFNFlXWVZCa3E0SVEwcXdwYzQvVGdkbEVv?=
 =?utf-8?B?TzhES01kY0kzSjN2UnhiOStOZzI3dDJkdmxrYWJPaXZjSy9yZEQ0T21nNzhT?=
 =?utf-8?B?YUV3MGI5QzVDQnpvWXZhbFl4RHh2VTg4RnRWcG04U2lWa0M4OVBacDlWSzF4?=
 =?utf-8?B?eFpUWWw0NE9OeCtLRE53V2JscERLeHc2bmQvTldiVm5JVHQ3cEdUc0VYVUpt?=
 =?utf-8?B?VjVnbDRvM0JyRUpwS05MWXV5a0lIWEswV2lFQi9seEJFVFoyUDF4UUxoOEJs?=
 =?utf-8?B?WElOejJNUTRLQTBmdCs0Z28vVW5hN2hnc1ZCemh2NHlLVTdNczBzZVk1ZVVR?=
 =?utf-8?B?VUZGM0tKVDlZcXFYc0tIUzhMd2Jla1R3UnpZRGhpWEQ2MlVWZWcyYnhXNVRU?=
 =?utf-8?B?S3NPdWdrYmhzR1A2Ti9kcERJSEFxTEY5U3VTalFNck1PSUVOZjNrc0J6a1hw?=
 =?utf-8?B?eUtOcVA5MWtidGJJVHk5TWd5cWtnWjBHN2djc1JEYmdzQ2VWeHhxQytyT29S?=
 =?utf-8?B?czVBTmFDZEtZMlllQ3IyN1VtRGtjczdhTTdkOFFnWVZ6ZDJHNk0xV3YvQ2pX?=
 =?utf-8?B?dDVyV3Z2RzVZWWhSb3p2Mzc1YUY4TnZheWZmemkrMVlvZWNVSnpCT2ZodjE4?=
 =?utf-8?B?SUQ2Z013VkthaXpXaytuUzF0L2tIb0tpMVVsbUMrU2dBVi9zQTR5ZG5QZm93?=
 =?utf-8?Q?8bUjxmGukCG74OuC7G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A31641B1B88784B8E5B6C266B060947@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9a5e48-7cb8-4b80-7ae5-08de53fa18af
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 05:51:15.4059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y1NGFoyuvZ7jwMFuros6hDt1z18HuvCOd08Cn96oJwLR0s/+WzOP8mio3WnXOjHLwMvngrL9+M+tt/DvtUMOJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
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

T24gMjAyNi8xLzE1IDEyOjE1LCBBbW9zIEppYW5qdW4gS29uZyB3cm90ZToNCj4gT24gVGh1LCBK
YW4gMTUsIDIwMjYgYXQgMTE6MDLigK9BTSBKaXFpYW4gQ2hlbiA8SmlxaWFuLkNoZW5AYW1kLmNv
bT4gd3JvdGU6DQo+Pg0KPj4gSWYgZHJtX3NjaGVkX2pvYl9pbml0IGZhaWxzLCBod192bV9mZW5j
ZSBpcyBub3QgZnJlZWQgY3VycmVudGx5LA0KPj4gdGhlbiBjYXVzZSBtZW1vcnkgbGVhay4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBKaXFpYW4gQ2hlbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4+
IC0tLQ0KPj4gdjEtPnYyIGNoYW5nZXM6DQo+PiAqIGFzc2lnbiB0aGUgcmV0dXJuIGNvZGUgb2Yg
ZHJtX3NjaGVkX2pvYl9pbml0IGFuZCBjaGVjayB0aGF0IGluc3RlYWQuDQo+PiAtLS0NCj4+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMgfCA3ICsrKysrLS0NCj4+ICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMNCj4+IGluZGV4IDdmNWQwMTE2NDg5
Ny4uMWRhYTkxNDViMjE3IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2pvYi5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfam9iLmMNCj4+IEBAIC0yMTksOCArMjE5LDExIEBAIGludCBhbWRncHVfam9iX2FsbG9jKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwNCj4+ICAgICAg
ICAgaWYgKCFlbnRpdHkpDQo+PiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+IA0KPiBJIGhh
dmUgYSBxdWVzdGlvbiB0aGF0IG1heSBub3QgYmUgcmVsYXRlZCB0byB0aGUgUEFUQ0guDQo+IA0K
PiBXaHkgbm90IGNoZWNrICdlbnRpdHknIGF0IHRoZSBiZWdpbm5pbmcgb2YgZnVuY3Rpb24gYW1k
Z3B1X2pvYl9hbGxvYygpPw0KPiBDdXJyZW50bHkgaWYgdGhlICdlbnRpdHknIGlzIGludmFsaWQs
IHRoZSBhbGxvY2F0ZWQgMyBzdHJ1Y3RzIHdvbid0IGJlIHJlbGVhc2VkLg0KV2hhdCBJIGNhbiBz
ZWUgaXMgbm90IGFsbCBqb2JzIG5lZWQgdG8gYmUgYXNzb2NpYXRlZCB3aXRoIGFuIGVudGl0eSB3
aGVuIHRoZXkgYXJlIGFsbG9jYXRlZC4NCkl0IGFsbG93cyBlbnRpdHkgdG8gYmUgTlVMTCB3aGVu
IGFsbG9jYXRlIGEgbmV3IGpvYiwgdGhlbiByZXR1cm4gdGhlIGpvYiwgbGlrZSBhbWRncHVfYW1k
a2ZkX3N1Ym1pdF9pYigpLg0KDQo+IA0KPiANCj4+IC0gICAgICAgcmV0dXJuIGRybV9zY2hlZF9q
b2JfaW5pdCgmKCpqb2IpLT5iYXNlLCBlbnRpdHksIDEsIG93bmVyLA0KPj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGRybV9jbGllbnRfaWQpOw0KPj4gKyAgICAgICByID0gZHJt
X3NjaGVkX2pvYl9pbml0KCYoKmpvYiktPmJhc2UsIGVudGl0eSwgMSwgb3duZXIsIGRybV9jbGll
bnRfaWQpOw0KPj4gKyAgICAgICBpZiAoIXIpDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIDA7
DQo+PiArDQo+PiArICAgICAgIGtmcmVlKCgqam9iKS0+aHdfdm1fZmVuY2UpOw0KPiANCj4gVGhl
IFYyIGxvb2tzIGdvb2QsIGl0J3MgYWxyZWFkeSBhZGRyZXNzZWQgdGhlIHByb2JsZW0gbWVudGlv
bmVkIGJ5IENocmlzdGlhbi4NCj4gDQo+IFJldmlld2VkLWJ5OiBBbW9zIEtvbmcgPGtvbmdqaWFu
anVuQGdtYWlsLmNvbT4NClRoYW5rcy4NCg0KPiANCj4+ICBlcnJfZmVuY2U6DQo+PiAgICAgICAg
IGtmcmVlKCgqam9iKS0+aHdfZmVuY2UpOw0KPj4gLS0NCj4+IDIuMzQuMQ0KPj4NCg0KLS0gDQpC
ZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hlbi4NCg0K
