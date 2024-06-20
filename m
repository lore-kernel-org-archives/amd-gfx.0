Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC8BC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 14:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4924010EA11;
	Thu, 20 Jun 2024 14:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="caDGPLz3";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2593D10EA11
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 14:30:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExLBWmjm1qsc1JBxEA698EealQK0lBd3AD0XyQ5pdcSXRVOObmgk/RlQvOiuTXC2bgYRVs4wXP2vmPfGz6g1jXMh3fC8ahJ6cxIIN5mOcC9T02wSa8Q3ZuL4wIBPJARIvq+Z0jkHkwsfOnohHQKHTVF5rEHS9dKvf2WHcJdydd3bPVheL23EbrKoFysp/cNq8DkdyREZ8sGvv4/okWtuSODUQ5hlZpOEUp0Ov8cSbkOnx+v59Ud39QpteIEFfPLKHg340dz+s02qdPgjf9fbAG0QNVMEKRVS0QxDGF6UFoBLkKaMs3elMlJxe3HYoc4+ipLtS7e306QpVVLXnimLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kW/3F4e6OEKkyKL7ySNnG7DOZqCN/oYsrGZmGy126cY=;
 b=VFuJyvJOAd9MZVNsTOtwKbYDyDpERONaSU/fKdr7GKHnKH7NHZYv385KTEoqKeC6+QdhBYAvFP8c9EvmQPDE1HsrYQlx3kMdcf1YMmvp/5J95PJ9SfJIXzGF/CJz2ey7qawNIc/bd05xgk+oAj9jIO8sFr4uwrlI614cpx5GYAvms0pGIz5S0Oq1vpJLYSFALHXg+nYWCttvLhSbxvhj+oTpKFL0rYeM1e9RfWAHT7Q+3g3hslzsMqVHEbVRM5cXmJokvYNH8wuRQnuPNOaXXf/HroeIIsNjWoLfb8tY9Ahn7cwzOOpHmed2oUrqq0yBl2SMgbGXpEl2M/CQNt/J1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kW/3F4e6OEKkyKL7ySNnG7DOZqCN/oYsrGZmGy126cY=;
 b=caDGPLz3b7+vsf41F0Cob/N0CyKFOpNyHX0QnRa9nKGRUvpUzRvz8szaTvy3tJRnEt+Jh8erf2p/10X5owibGDSCVPUlWnhfmlDmR7OgZwEZoK/VFKJ75N9wZxIkeXvPExGeVo4qGtQrrC3uhrrqoLRsfJSxFehackILLsXpz9E=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 14:30:46 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7677.033; Thu, 20 Jun 2024
 14:30:46 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: track bo memory stats at runtime
Thread-Topic: [PATCH] drm/amdgpu: track bo memory stats at runtime
Thread-Index: AQHawqkYLS30htUXHUuLu1WknLowTLHQYpaAgABQasA=
Date: Thu, 20 Jun 2024 14:30:46 +0000
Message-ID: <SA1PR12MB85991FD8CED8F54570069464EDC82@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240620003014.21453-1-Yunxiang.Li@amd.com>
 <f56fc803-dd1a-4dd3-a06e-d268fdd76e1e@amd.com>
In-Reply-To: <f56fc803-dd1a-4dd3-a06e-d268fdd76e1e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=27060fdd-ea99-4b43-b0f3-b065f5c9c607;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-06-20T14:15:06Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|DS0PR12MB7899:EE_
x-ms-office365-filtering-correlation-id: c03a36af-57f3-412c-4fa3-08dc91359325
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?SCtVQ1JoUXMxbFRwVkZvTXFnYVQ5MTJCUVhZaFkyQzRrZXVkalhDOVdZakxG?=
 =?utf-8?B?Z08yNlNBc3lNUXM4V2hobkpyYTJSdnVUZEtPWnVOZ3Q0dmFKdHF5a1hsN0FB?=
 =?utf-8?B?cHozWEZyeUdoYXIwRUVlRDVNZC9ad01jUk1CdE9ITFE2S1R5L3c4eFhnd3l5?=
 =?utf-8?B?bTJYV2ZCRStwOTF4TW1MMkNKS1oyNGo5eHovZVl2dDVhYTVOYVBuWXgvYlZn?=
 =?utf-8?B?VmFQakRZaVdPL3NCeUJCMHdUTnJWTUxvbjNzUTlYZHRCc3Nza0lta2t3OVg1?=
 =?utf-8?B?QjlUbHdJeFUvOEx0WU9iUVpHVzQ1UFZibm5uNlAwU0FzY3d2dTRCelZkU2lM?=
 =?utf-8?B?aG9uM2hCSCtvSXVteTF4d2NTdVhJUXh5bVNqOHFwSDc0V05McExmZ1IyRXRz?=
 =?utf-8?B?eC9CM3RHaW9MQk9mQUJud29PZEtEK1BjQkhoTHM4b0ovRmdlUjlPdmd2R1ps?=
 =?utf-8?B?MXp3YVJmUVBxdXNrTmEwTUpEakhMUzV3TFhlczJ6a3hiWVlxcnhNWmN5cHRp?=
 =?utf-8?B?MFR4SXE2ZnlGVUI3aXE5VjNrMEFtQ3VXMVhTb3FGTi9hTWhMWW5BZUQ4Um1U?=
 =?utf-8?B?dkQ0QWVqWXo3VllWbDlkOURUcHhmTnJVdm9ra2o1d1R5amJ2UFJ5VUtpSHVl?=
 =?utf-8?B?RUtuNnU3T0VZcG9pWG83TWlZc3J6NGdYS05SNUNlUHZGMkh1cEZhcmRJSS9j?=
 =?utf-8?B?VGg2SFpQWWE0b0hZUGg5KzVPT1ZxTlpKbGpCV0tzSFFTT0JZaDc5TllaRlhu?=
 =?utf-8?B?cFdGM3Bsa25HT2lpNkZHMmxFMWxVc1pnUHpoNEY0NHBNaVRObks0aXBYU2hy?=
 =?utf-8?B?THg2L3BsckVjWVkydlJFZlVhWUU2dGs0TnUrT1pZajBWbXdpcnhhWmFldWFW?=
 =?utf-8?B?OXRwbExtOWZVUktMYkhOWXJtbmJ0MW9tdVdIWSs5R01ndi8zV1JUY1lyR2gv?=
 =?utf-8?B?aG4rVG5qNW5ySGdrempTYjY2U3pMYVJqbHA2a0I4YlpKQ3oxTlZUa0lqNVVt?=
 =?utf-8?B?dUFmV2sxY0lWekNBeHZ5OGQ4WkNxN2kyUWtoanVINzJuRiszaksrYlJ1a09j?=
 =?utf-8?B?OFRCNjZ6WEtXQzhVSjFGc2pqYU1OdDBua0hJbXUzVFJHY0M2RjJqYVhmR28r?=
 =?utf-8?B?dEZVM1Z5ZDlDSnVFSkd0dVZaTDlkSmR3NmRQMDFZV055VnNvbDZzYmNGOW1Z?=
 =?utf-8?B?QW5LUVFoK3hDaGc4WXIxRHk2Sk5KMm83aldqTTh3ZHlDWXRMWEsySVhrZG9U?=
 =?utf-8?B?RGFrTHovejM4eEFHL3FZZUF5M0I2Vjc3Z2wvcTBiUmc4Mi8wZzFxOXlHQ1VJ?=
 =?utf-8?B?UmcvQ1BIT1RyOTZHS2dzTzJyMEZhMWRHS3FHb0wzdjJwZTJNY2ZBWGlZcnFm?=
 =?utf-8?B?aXF3MXdxZHZnZHplNklaOVdYd1FBZ3YwZXZwR2lYRDZxY2FrK2d5eHNUNk8z?=
 =?utf-8?B?VU42aTNISUtKckZuR3RxME84VU9CaS81ZFdMcGJ4alhONTNwdlE0dXJaUk8r?=
 =?utf-8?B?RWd0QXh2bnhwZU9wVDZhUVh1VFJnZTZpcGdOWVUzMTJEa3hKKzdkL0F1RXFJ?=
 =?utf-8?B?Zi91a3F2VG0zVnpNZU9ucHF0UHUwOTBXWkdvTmlnRzFsUHVKb3Rja0QrTk1r?=
 =?utf-8?B?c3BiZjAwcVdrNGpvQk1xWFZ6SHJKVTdNRDU1eFAvQi92NnptbnBncEV3NFNk?=
 =?utf-8?B?QndvL0Nhd0oraldRVXF0aHUydDUveGR0Mjl4am5pVnl1d09Udkt6NGpmemV1?=
 =?utf-8?B?R2pnUDhveWZLRjNrYmdsY1g2YTJlS0RzV3VscC9WSDJ5NXA1V0lQZlNkRUZ1?=
 =?utf-8?Q?McJEalittBFxQSJVxZJMPoYuIuIb+gip3gqH0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eC9vN1JTeEFrODVwM3lwcTdFT3V3SDhZMHVJZE9lSEhZSGJJWVkrVHM5aXow?=
 =?utf-8?B?ZEhSWmQ3aEsxaENEbGx5WUUwaSszeE9zOGVVRGd5SUdnQ2hpNWNLMTk2bC9B?=
 =?utf-8?B?ZkpZR3V4YmV4dkhJak9JNi9zUDNxQjUwL0h3QzVKYVRobzNVMHF6T0FTSU83?=
 =?utf-8?B?SFJXSDNVZXRGVEYwb1NZRS9Pak1lNGR5dEZORzhFM2dKUFF6QURsNnBlbFJ2?=
 =?utf-8?B?QTVvTDlJOHBPUDRDSG1pVUl3ekxKZGVJaXR4NVQrR3VHVTRJL0NTbU4zRFZi?=
 =?utf-8?B?YjIrOEQ5djlxMkpYYmJ0RXBVankxamxKOGVqVEJjcGM1eUpEdjNVNlpEL0xJ?=
 =?utf-8?B?aXBKZm1aRTBTM3B1c2t6NHFuSENWaVBMY0l2YjhkbUxrQmhpeUtHSDVHWEtk?=
 =?utf-8?B?UHFjMXlISG9jZDlOdFg5RVpxUFFKT3grdU1rakx4R3YzV2JudUJSdXN1RFBt?=
 =?utf-8?B?Nm9RMkNQR0F5ZFJzU2JuQUthMytVZWR4WllPdXdaQzVkcTAxSXZWZUhpaXRM?=
 =?utf-8?B?alVMZkg1cTF6WWk4VjdZckdVcmRUTENvRnZoTGJlelR5Ni9VNnlqbmRVUkFE?=
 =?utf-8?B?Nm5NM2h6NGtKSW1CTDNBWEJaOEo1ZURvcFIyZEszS0hXVCtCb3dOZkVadkxT?=
 =?utf-8?B?TkhSc2phMGhlRzZlYmsyOUYzdUMrNFVKYkZkYU9ZMFU5TEd2QXk1Z0M2UjVD?=
 =?utf-8?B?eUJyMEF3S2lGc1NrWmttcURqUWRMODhSK0pNcGdoZFdvd3l5bUZkbkRVTEww?=
 =?utf-8?B?S0RRNGZ3S0xtM3Jha25tZ25OMXZ1dUgweUhvRXkxY0dwdlBDdGVHa0wwc0Jm?=
 =?utf-8?B?eWZEZDdqOXdmVE1xRk9rWE1RSFpDZWxSeTVHVnBweUNyOGwwRDZrUGszSjgw?=
 =?utf-8?B?ZytUU3Q5OHBKRERxUDZIRjVLNHBCdFJzVDNXaytjWEFCZ0c1Y2ZOOTVrSmhr?=
 =?utf-8?B?ZFY4N2plQ0R1RnZqbU8rK0E0SEx0eUplY0RmK1BQRmhzakxCTTFXWFBDZ1By?=
 =?utf-8?B?bzlTSjhCVE1iaHNreFh4NXhPRHpibmpQUjR0VnB2MUc2YzF6ZHZSQ0FJUTYr?=
 =?utf-8?B?T1RCd0R1YkNCZVdCNnZldzArdnJoYzNJZHV2SE5JdUtHR0cyMTRWdGl4d1pG?=
 =?utf-8?B?eU9OY09tckQ3RWxOL2N3ZS9tdzRUMEtzQmp3eDJWOTZqOVgzRkRwRVhpMjN3?=
 =?utf-8?B?VVhEZmdrVE1wdGNRRXVHdDdDRXZUL09mM29PbGdPWnMvRlFZa3FzeUVGV3p4?=
 =?utf-8?B?anlYbk1kWitHUTFLNGUrdmk1MXNFY09QRloxRlJjWkxJeEptbFpiTWlnc2do?=
 =?utf-8?B?RmdydFJHbzkwZzNkbnNxMmhodmo4ZVE5YzUvb0tEbXJCdTNWZzhzVWZ1RC9F?=
 =?utf-8?B?RTBBU0g0THdTSHM3NFpOaldtbGcyZTdQZzhBMjVGbnFYeXp5bHlCSndUZE0v?=
 =?utf-8?B?aERyOFIvSmRoTHFMdXJJTlYvSDZraFZ3T0kwQnoyWXRhWER6bW9DL2ZzNXRt?=
 =?utf-8?B?UHlWRDM1c0Nhb2tqODhOSzB2enpZM1paeVIyc092Z1NFbC9GRUF0VGpjbkJO?=
 =?utf-8?B?UCtrdXhZeC9HbmRsZGpCdUJhbVlrNnJvT1NlL1pEd3pJeEExVU5yeE1xc3A5?=
 =?utf-8?B?VDV2TW9JU0M1QVZlcDJNcWxidExXT05Kd2ZsMTVZQS9vdHg3Vkw1dzVZSlRJ?=
 =?utf-8?B?MU5BTlRoQmFuOUJTQzZaYjZDRTJvWjhQN1dJQ3JtMTJ0azVacllaNnhiVnZ1?=
 =?utf-8?B?VjE5aGg3bnRMWXNqb3hjVHRpY3ZFbENUY3BIalUwdmo0QnA3c2dzRjNJOU5T?=
 =?utf-8?B?K2FYU0JLOGMwSFNLTnd1c1h5Q04zdXNDbVFuTlhXMFRMZ3FXT2psSEordUhi?=
 =?utf-8?B?cjFCUVlCVEVIYmNNQit0aDlidjV5WGptaUEzbitsQklqSk5lYlY0b2N6bjRT?=
 =?utf-8?B?SE9YMWEraXlTWjRFcmVzRGtWZ3JMWnBuWUxEMGRQcUpSMVBzOHZaQnJnSVpN?=
 =?utf-8?B?SzU2Z1dsTTBzVUUwc2k2S0RiNVc4UXozVUNZdHJvck1SZ1djdjlBOUQ1QWt6?=
 =?utf-8?B?Ym5qODh1eFBsekhiaDVNQ3lQWERrblZ1QzB5d0FBRmNOL1R1VUczdy9tRHpx?=
 =?utf-8?Q?hNdA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03a36af-57f3-412c-4fa3-08dc91359325
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 14:30:46.7527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M6cqc3OLG5tZkxxvpJ37sSPfmzzZydX7lOSYP3cU9YoUcgumtTtvMZZdy8zrV0zkTEG97JcecyeEJ7uEqcTwUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899
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

W1B1YmxpY10NCg0KPiA+ICsgICBkbWFfcmVzdl9sb2NrKGJvLT50Ym8uYmFzZS5yZXN2LCBOVUxM
KTsNCj4NCj4gV2h5IGRvIHlvdSBncmFiIHRoZSBCTyBsb2NrIHRvIHVwZGF0ZSB0aGUgc3RhdHM/
IFRoYXQgZG9lc24ndCBzZWVtIHRvIG1ha2UNCj4gYW55IHNlbnNlLg0KPg0KPiA+ICsgICB1cGRh
dGVfc3RhdHMgPSAhKGJvLT5mbGFncyAmIEFNREdQVV9HRU1fV0FTX0VYUE9SVEVEKTsNCj4gPiAr
ICAgaWYgKHVwZGF0ZV9zdGF0cykNCj4gPiArICAgICAgICAgICBhbWRncHVfYm9fYWRkX21lbW9y
eShibywgJnN0YXRzKTsNCj4gPiArICAgZWxzZQ0KPiA+ICsgICAgICAgICAgIGRtYV9yZXN2X3Vu
bG9jayhiby0+dGJvLmJhc2UucmVzdik7DQo+ID4gKw0KPiA+ICAgICBidWYgPSBkcm1fZ2VtX3By
aW1lX2V4cG9ydChnb2JqLCBmbGFncyk7DQo+ID4gLSAgIGlmICghSVNfRVJSKGJ1ZikpDQo+ID4g
KyAgIGlmICghSVNfRVJSKGJ1ZikpIHsNCj4gPiAgICAgICAgICAgICBidWYtPm9wcyA9ICZhbWRn
cHVfZG1hYnVmX29wczsNCj4gPiArICAgICAgICAgICBpZiAodXBkYXRlX3N0YXRzKSB7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICBmb3IgKGJhc2UgPSBiby0+dm1fYm87IGJhc2U7IGJhc2UgPSBi
YXNlLT5uZXh0KSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHNwaW5fbG9jaygm
YmFzZS0+dm0tPnN0YXR1c19sb2NrKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
YmFzZS0+dm0tPnN0YXRzLnZyYW1fc2hhcmVkICs9IHN0YXRzLnZyYW07DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGJhc2UtPnZtLT5zdGF0cy5ndHRfc2hhcmVkICs9IHN0YXRzLmd0
dDsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgYmFzZS0+dm0tPnN0YXRzLmNwdV9z
aGFyZWQgKz0gc3RhdHMuY3B1Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBzcGlu
X3VubG9jaygmYmFzZS0+dm0tPnN0YXR1c19sb2NrKTsNCj4gPiArICAgICAgICAgICAgICAgICAg
IH0NCj4gPiArICAgICAgICAgICAgICAgICAgIGJvLT5mbGFncyB8PSBBTURHUFVfR0VNX1dBU19F
WFBPUlRFRDsNCj4gPiArICAgICAgICAgICAgICAgICAgIGRtYV9yZXN2X3VubG9jayhiby0+dGJv
LmJhc2UucmVzdik7DQoNClRoZSB0aG91Z2h0IGhlcmUgaXMgdGhhdCBJIGRvbid0IHdhbnQgdHdv
IGV4cG9ydHMgb2YgdGhlIHNhbWUgYnVmZmVyIHRvIHJhY2UgaGVyZSBhbmQgaW5jcmVhc2UgdGhl
IHN0YXRzIHR3aWNlLiBCdXQgaWYgQk8gY2FuIG9ubHkgYmUgZXhwb3J0ZWQgb25jZSB0aGVuIHll
cyB0aGlzIGlzIG5vdCBuZWVkZWQuDQoNCj4gRG9uJ3QgdG91Y2ggYW55IFZNIGludGVybmFscyBm
cm9tIHRoZSBCTyBjb2RlLg0KPiBEb24ndCB0b3VjaCBhbnkgVk0gaW50ZXJuYWxzIGluIFRUTSBj
b2RlLg0KDQpXaGF0IHdvdWxkIGJlIHRoZSBwcmVmZXJyZWQgYXBwcm9hY2g/IEkgY2FuIHB1dCBh
IHNtYWxsIGhlbHBlciBpbiBhbWRncHVfdm0gb3IgYW1kZ3B1X2JvIEkgc3VwcG9zZS4NCg0KPiA+
ICAgI2RlZmluZSBBTURHUFVfR0VNX0NSRUFURV9HRlgxMl9EQ0MgICAgICAgICAgICAgICAoMSA8
PCAxNikNCj4gPg0KPiA+ICsvKiBGbGFnIHRoYXQgQk8gd2FzIGV4cG9ydGVkIGF0IG9uZSBwb2lu
dCBhbmQgY291bnRzIHRvcndhcmRzIHRoZQ0KPiAic2hhcmVkIg0KPiA+ICsgKiBtZW1vcnkgc3Rh
dHMuIE9uY2Ugc2V0IGl0IGRvZXMgbm90IGdldCBjbGVhcmVkIHVudGlsIHRoZSBCTyBpcyBkZXN0
cm95ZWQuDQo+ID4gKyAqLw0KPiA+ICsjZGVmaW5lIEFNREdQVV9HRU1fV0FTX0VYUE9SVEVEICAg
ICAgICAgICAgKDEgPDwgMTcpDQo+ID4gKw0KPg0KPiBBYnNvbHV0ZWx5IGNsZWFyIE5BSyB0byB0
aGF0IGFwcHJvYWNoLiBUaGlzIGlzIG5vdCBldmVuIHJlbW90ZWx5IGFuIGFsbG9jYXRpb24NCj4g
ZmxhZyBidXQgc29tZSBzdGF0dXMuDQo+DQo+IEFkZGl0aW9uYWwgdG8gdGhhdCBjb21wbGV0ZWx5
IHVubmVjZXNzYXJ5IHNpbmNlIEJPcyBhcmUgdXN1YWxseSBvbmx5IGV4cG9ydGVkDQo+IG9uY2Uu
DQoNCklmIEJPcyBjYW4gb25seSBiZSBleHBvcnRlZCBvbmNlIHRoZW4gd2UgZG9uJ3QgbmVlZCB0
aGlzIGtpbmQgb2YgbWFya2VyLCBidXQgSSB0aGluayB1c2VyIHNwYWNlIGlzIGZyZWUgdG8gZXhw
b3J0IGFzIG1hbnkgdGltZXMgYXMgdGhleSB3aXNoIHJpZ2h0PyBJIGZpcnN0IHRyaWVkIHRvIGhh
bmRsZSB0aGUgdW5zaGFyZSBjYXNlIGFzIHdlbGwsIGJ1dCBJIGRvbid0IHNlZSBhbnkgd2hlcmUg
aW4gdGhhdCBwYXRoIHdlIGNhbiBlYXNpbHkgaG9vayBpbnRvLiBJIGNhbiBnaXZlIGl0IGFub3Ro
ZXIgdHJ5Lg0KDQpSZWdhcmRzLA0KVGVkZHkNCg==
