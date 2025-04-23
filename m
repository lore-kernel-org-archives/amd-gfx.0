Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6802EC369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 10:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1294E10E683;
	Wed, 23 Apr 2025 10:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S/IBH6or";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 659EA10E683
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 10:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdSmHW8j86bvXQlUGmEUx8h53qSFgMsQlqE+F2+G+dXcjzR8cGXt1wOXac6128biaaIeEZOV+hknr5qXygQQPQLsxgZLGunN54fQKcWV+uoFwA01vNd9kbDIrmULkJCPDpnHBu1aCybIozhY72jGGsmWPvYSneTxYZoc/LvCDMqkJ/e7N0wDaWN4IJPM0Uq2GvO6cwz/o0aH1JbnK6qlu+lq2lG2T517LBwmkia81JZGVdSCIM5ck9DyK7cUPfFeIok0kdfqy7aBmiv0ryiLq4qREx6fbWcGSc+z25m1dKUGvc931ImcPjav4pjkOkHIh4+5I3s+VUErevASUb5C+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkimvYPzVKJaNz0kXXSTzkeVkUHHalXfZilltTHOjvg=;
 b=zSAtvAd7H2lU8NUI4M19pP7j/6p/Eh9/CH5JiGwPcqK7nZFTptGza9qxJcwUc1SoDndD024/qX7wNtTYc1RG8NqGRdJFl+P3iSjSCpYjYR4iXXfmRRmkNCmQDPqzD5vzaRm1W5TDPuCBeRJUdjojD4CKNzbdL5Ta479uLLCx4nwKyxgbtNz8wDb+hJy5r1NcvDG2sRTydAaUBjYaqc1vLaoTwNBmPMgKozsxDL9etdn9LPKpd35MX8XDP30k0LTbF2mKZXtTZD8IdykyNxXQ2UOW9/QcCJ9LmEdbzjM4tOBJNUWBwlGVzkQC8uNv8gTN6J67CUcay5rIewh6gE395g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkimvYPzVKJaNz0kXXSTzkeVkUHHalXfZilltTHOjvg=;
 b=S/IBH6orWcTcxHuhvJsSLi8TNbaJB+EACA+Qf51JMfhF59uozS7eugmEaBTiH8KIj1zGVOFSNFCjsDxP0M23O7Bjiwz3M+nrgaKqzYPJbvS2AUrgb8/8ymy8M16KvF7mg08EegPVT62adjPcxhwGtKHFvj/TGD0ZcusVYrTKw7Q=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by LV8PR12MB9617.namprd12.prod.outlook.com (2603:10b6:408:2a0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 10:52:37 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8655.030; Wed, 23 Apr 2025
 10:52:37 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Yadav, Arvind" <Arvind.Yadav@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: only keep most recent fence for each
 context
Thread-Topic: [PATCH v2] drm/amdgpu: only keep most recent fence for each
 context
Thread-Index: AQHbtD1SMcd625P44UyWLKJTh9lh5rOxEvZA
Date: Wed, 23 Apr 2025 10:52:37 +0000
Message-ID: <BL1PR12MB57537BB48BF34E8946B1DCC693BA2@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250423104824.7014-1-Arvind.Yadav@amd.com>
In-Reply-To: <20250423104824.7014-1-Arvind.Yadav@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=becadae2-7422-4060-803e-70161b271c3f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-23T10:51:52Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|LV8PR12MB9617:EE_
x-ms-office365-filtering-correlation-id: afcebe52-0d0b-46d5-6f1a-08dd8254f623
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?RWkzazFGY3NmMU9BTzBlaVhwM0lRR2drNG8rbnFVKzJEaFROa3licmFYaXdY?=
 =?utf-8?B?T1dCSW9HSVFVbDd0SVFVVVpQQ3FHYU1uQmFBZUdPMWhpZ2pnQWpITjluUHlW?=
 =?utf-8?B?aXUvM3FoRklnLzVrN2xzN2s3SE1qRGlRT0FiKzRMbjhqUVdTWWpOYkJKaXhH?=
 =?utf-8?B?cytVYldDcHIzRTZQcVhiU3FSQjc5aU9GTWk2NmE5UFZYeCtpQ21EVTZHTFQz?=
 =?utf-8?B?MEJwOHVaeno3TmJSV3dTU2JUTW5ETkxYOFkwRnVXUHM4QUpnanVOdXFHMDFX?=
 =?utf-8?B?Ry8xOFlYYXZxUHp4RURRektaaUtPQTJpaXpqd1gxRXpxeGRISWRaVjhVS1VH?=
 =?utf-8?B?cE80OUFuWkV6WG9lZjlTY3dtQUpIemVZTzQzRkdJT2RwS2pxQUhZYmV4dVNB?=
 =?utf-8?B?bW1weENRRjEwdFJyQ0xOa1BHUW9EWE9uK2tFVTk5eVhDUnBrYU9Penlva0pU?=
 =?utf-8?B?MjF2T29HM0s5Rk1scm9Vc3Y0aFFaaWwwT2syYWpHdTc0aTRYaE5RTXZ5Y3g5?=
 =?utf-8?B?Q3NEckNBZnpDS2tpbkR5OFBEU1dqUVVySEIvVEM5UTY1VHdaQjJLdnhIWmRx?=
 =?utf-8?B?OWpHU0FhNWZ2N2ZmbXVPL29tdk1ldXYxRmh6TXZHWDR5Nmo2UTliR3FtZ0pV?=
 =?utf-8?B?UlBKYmNpKzhBUkp6Z0pxaXRGYXg1VzBrekhST3hheTFYWHBwSTFQZ1hva01r?=
 =?utf-8?B?SDZVWkFnbys5SE5RS1RSaXJPRUt1VlRjU3c3N1JLUTVIT2s0ZWdmTlNuZ2ZZ?=
 =?utf-8?B?VFdOZWZZR1d5WnhiUmZWZlR2OTJldEd1UHNKMVcvSnFsZUw0YzJuVXlSVXNm?=
 =?utf-8?B?anI1dFRLV09hZHRQSnpkWGVOamtTanZFa0JjUDF0dy9hWnVMZkxMNlZHRHVx?=
 =?utf-8?B?T0ZuZzBPc0pNUHZMQXRlVTJJWThuNUlCRlAyaWQvajBkRjdMUjl6TGhiM0Fm?=
 =?utf-8?B?K1JFNkFua2w2alY0WDVEeWd4RXFPczd5VEY5UndFdGlrVTUzTE05WWlrQUlN?=
 =?utf-8?B?NjV0ZFpHVzBSNHFZa21MWHJZUjV2dWlnc2liVHE4ZXlEeDFzUHNZNkl4dElk?=
 =?utf-8?B?TlNoQncwYVcwS1BTUU11ejA5QjY5STdaZU9MbElkVWhJQnc3bDV0eXc1RlV2?=
 =?utf-8?B?Z2JBTkRVYVJlcmxDWXF2WlZGVWR4Y0M1VDRYMTFZU1dSdHpaVzU1TXpSOFB6?=
 =?utf-8?B?d1JxYzhDSTAwclZtVmZvSFlvTXlLT1ZHV0g3cXkzLzliUGs2dTJ3SHhIc0Iv?=
 =?utf-8?B?SVg4bElPMEFybjk0bFdMSHoyZTFocG5oVkcwRFhGMDlBclpvRmF2OVhCK2l2?=
 =?utf-8?B?SDMzazRaVVFjdUI5UnpHNy85V292T1d6TnRROGFEWHRkVGcvZnErNzJXYUcz?=
 =?utf-8?B?cTFaaEZvclVaeTFKdFMxTFV5SW53TlhIM1hhbm1pZ2JyTzVMS1dVbWs4L25r?=
 =?utf-8?B?bHlHV2RTK2I3YzB1UkQ2YVJTZ3VWazhxK2VzTCs0bCtiWVJYV1V2TEFMdUQv?=
 =?utf-8?B?ZGZSbFNZZmhlNC9CcnlhaC9QWVNrTzBMWEd4bGNtTzllUTlPaVgxc25CS1pn?=
 =?utf-8?B?TjY1WHk2Mk1VRmVmaE5IWDBua29GTHlHbzVXTmovdHdPZ29jVUl4SUdPK3dC?=
 =?utf-8?B?Z010RVVkQ2JLa3hycURSTGlMZElNRjJKa1c4WFBkWVF1SzF2NFN2dWlPVkNO?=
 =?utf-8?B?TFZXR2QwVFIzZEhRUFJyNGMrTE94WG94RUlpbzZ5K2lxd0RJemlJZHFSWEk1?=
 =?utf-8?B?a0laZHNNaEU0Q1U1bGhLS3pyQnRxTVFHT0tBS3ZWa0V4ZDE3eGg3YU5MdXoz?=
 =?utf-8?B?ZlVCbzRFcXNha2pRVWNNSTFtdXVDQ2JVQWlPWlN1enpkd2ZPckpkQ2dKMnJn?=
 =?utf-8?B?V25mUkRqVjlRZ0J0RW5STVpJcElNU0tKNkFoWTBPRmZHU2JMaTBRN3QxamJJ?=
 =?utf-8?B?TldJdHRPV001OEcyOU5lUERRQXAyUVBKU2djSjhQQm5ZbzJ1NXpUaG5kSmdW?=
 =?utf-8?Q?5BEXhNzRqTFwFo82mQsR+qgbTf3Zhg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWtZaXpLU1MzQzZPYjM0K0lMTVhFQnRoTVQ3MDZCU3B5S3NJTmp6b3BVVWNL?=
 =?utf-8?B?QTF6SDBCMERwNFV4TU5PbnF6eHMrTzBCaHYza1VQKzRDa0t6dk96VWpuWGx6?=
 =?utf-8?B?bDB0Wk8rWG9UM3RZckkxTmhqM1JYc2xxNy9JaUc0NUxkcjAzY09aYzA5NXRQ?=
 =?utf-8?B?eG9pNTNwdlU1VENJeklDSlRCTHRFRGFRK1VCeXlvZ0VKSGR5VWl5U2lldEpn?=
 =?utf-8?B?ZmxjcmxqS2xCUzBwbU9hTm9wS2pvRGRORnFiaktQZWVWQllQcDNveE5NeTBv?=
 =?utf-8?B?UEM4MUFHd2VNVlBuUC9VbDhyM0VRZlVDbnk3Z3ZJdWo0ZTFjZkYwbkhVZDZi?=
 =?utf-8?B?bzQ2aG5sM1A3Yi9BTFR0a2hQaUJkVDZNSjZRbXRjbTh3a1gvYTEySlRvcWxS?=
 =?utf-8?B?Rk5JL3EzT2Y1VkZqR1pBcEdWb0hra1Rub0FBN0FlUzJOQ1Q0U2UwSlMwcXpX?=
 =?utf-8?B?VHVkSVhCbVh1amlOODdNanNQWUlHQ3dHTmIzaW1NUEJlTTRNRUNNc28zRGcr?=
 =?utf-8?B?NUk5eHpidXJsUmNwZkM5d2tKNUxJZ0daVkk0aTVNUTRONFZoVUVmTnkvOU85?=
 =?utf-8?B?MHhtOXlzMFoxSVlaV1Jwd2U3MUFNRTQ5T0pZQ0FJK09YVmVpOWFiVzlJK2d1?=
 =?utf-8?B?c3U1d2JGQWNkZEc1TWJZU0l5ZWZSMGp0UXBjNlFXdUdFM3k1aTdoKzVWdG9P?=
 =?utf-8?B?ZTlGWEdHekdWQzFYRFJjM09hTlF3eXBzeE5iMVltbFZTcVFuNkZwMkljeDI0?=
 =?utf-8?B?SERHTUZweS84ZWRBQnZHS3pCZzJjd0RaeVFUMEh4WWhYNm5BektDNTVNbWtl?=
 =?utf-8?B?dUhHNkdXb0Q1UDNYazY3UkRndDhSZTdYclBXaFRaZE5xZFM0dmVpMHJjMnZp?=
 =?utf-8?B?MGM1SWFWbUlOSFpPVTlocXNHNUJHRmYxQzQweHFxVE5kbzI0eFJxOXJMSVVN?=
 =?utf-8?B?dVVoRDFCRDlnR1U5K0RmcnBPa01ZWU9pdGgzZDc1MkZ2Tk9vM0dqYVlBRnpq?=
 =?utf-8?B?dzlJMUJMRkQ3WVZXcGoyVFF6dWJvcU0zZlJ6Yzlud2l4bWFURmIvYVprYVdM?=
 =?utf-8?B?YnFScTBJUG9tZXNMWWhLdG8wOUx2cmg5UlkwTjJGS2VOTWVqYlBPekJKczZw?=
 =?utf-8?B?ejdPOW5seVUxOURrUUlISE9iS2QySzFVcTRNUzY1Q3ArM2VYdXhhMmRtTGRt?=
 =?utf-8?B?OC9nUks3emsrOUpSZHMwbC8wMEd3Qk4ySFhkNThtbDB6SU9XTTQvOGlLdnVw?=
 =?utf-8?B?SjFmdGpvRWpUMXArWlUrZXdSQjcydEhHR0hObklSYkZhSmdDYUpvT3RTODVM?=
 =?utf-8?B?VS9xa0E3c1p3RVFwOCs1WVpsQmVYdjRVK1QxT2xpYzg4cUF2K2REbnZWbFoz?=
 =?utf-8?B?cFdadlNta2t2YVlFY2VMZGpEQm15ZFl5VGdtbnFyamM3a3ljZk1kUWJpaGpR?=
 =?utf-8?B?V2ZTWXZMTDVnV1lZNkZEdkRNNEVNbkhDZWJlb01zc011REJsMzhXanJIS1Ny?=
 =?utf-8?B?VnV3Y2puOFdQdnRxaGpaZkhuL3JuNnF1ZzN2NCtucGRBSVN5UUZWMWQ5OWha?=
 =?utf-8?B?T0IzQlR1TjQ1SVRWNFdKQllJNUE1UktpZ0l4MzRZcS9zNmZ3ZVdhVmlYZGVw?=
 =?utf-8?B?YmVlSzRQcnU5dlhRR2d5OFROcDNEQUtSdlNlRG1Gd3FRbm9aaG9kK1dQSXVZ?=
 =?utf-8?B?RWtIWHBobXZrYlcvNVV2KzE2c00yMy9uRE1RLzAzOGROY00yTzdPU1lLcDgw?=
 =?utf-8?B?REtiVXEwQnpEdG9JcFFGS003ZUZnY3VqQnFVcEg3RDR3U0E3d1lwZllDbE41?=
 =?utf-8?B?SWhOUUpXQlNuamFJYWVMSGErQUh0Vy8xMVBVOUtLM1VpbWJ1OUhxa3loeXNl?=
 =?utf-8?B?M1VuRjcxSUdDQk5IWFUwTFl2YmY4cHJKKzN0NlZjNmR3RzdBU2dPTVR6MGpP?=
 =?utf-8?B?NXg1cnh1YjZMamJTeUVwRmRIdFhyVnZ0azdNRC9mRStYdmtMcFJuOUM2MkJ4?=
 =?utf-8?B?czJMMGx5TTNVYzc4NGdCK3RqMDhLdS9wMkp6TFU1UjF1Mnk4RWVuU0tUZ1pK?=
 =?utf-8?B?VGhCM3NuMGF0S3lVT2RGRGZiRWpKcC9rNWJraXNuQVdTR0lxdmZhNkQ4eGk0?=
 =?utf-8?Q?hHPc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afcebe52-0d0b-46d5-6f1a-08dd8254f623
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 10:52:37.4343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIhnUzafCKIOXn5Dw9dSR67gNhAJAEaRFu/v1YrBK+X7cx0a36v8MLEXDTVeyc/yaEW311QP9nuj+KK+1pXS6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617
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
Cg0KWW91IG5lZWQgdG8gc3BsaXQgdGhpcyBpbiBhIGRtYV9idWYgcGF0Y2ggYW5kIGFtZCB1c2Vy
cSBwYXRjaCBzZXBhcmF0ZWx5Lg0KDQpSZWdhcmRzDQpTdW5pbCBLaGF0cmkNCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFlhZGF2LCBBcnZpbmQgPEFydmluZC5ZYWRhdkBhbWQu
Y29tPg0KU2VudDogV2VkbmVzZGF5LCBBcHJpbCAyMywgMjAyNSA0OjE4IFBNDQpUbzogS29lbmln
LCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtoYXRyaSwgU3VuaWwgPFN1bmlsLktoYXRy
aUBhbWQuY29tPjsgUGFuZWVyIFNlbHZhbSwgQXJ1bnByYXZpbiA8QXJ1bnByYXZpbi5QYW5lZXJT
ZWx2YW1AYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWWFkYXYs
IEFydmluZCA8QXJ2aW5kLllhZGF2QGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPjsgWWFkYXYsIEFydmluZCA8QXJ2aW5kLllhZGF2QGFtZC5jb20+
DQpTdWJqZWN0OiBbUEFUQ0ggdjJdIGRybS9hbWRncHU6IG9ubHkga2VlcCBtb3N0IHJlY2VudCBm
ZW5jZSBmb3IgZWFjaCBjb250ZXh0DQoNCk1lc2EgcGFzc2VzIHNoYXJlZCBibywgZmVuY2Ugc3lu
Y29iaiB0byB1c2VycV9pb2N0bC4NClRoZXJlIGNhbiBiZSBkdXBsaWNhdGVzIGhlcmUgb3Igc29t
ZSBmZW5jZXMgdGhhdCBhcmUgb2xkLg0KVGhpcyBwYXRjaCBpcyByZW1vdmUgZHVwbGljYXRlcyBm
ZW5jZSBhbmQgb25seSBrZWVwIHRoZSBtb3N0IHJlY2VudCBmZW5jZSBmb3IgZWFjaCBjb250ZXh0
Lg0KDQp2MjogRXhwb3J0IHRoaXMgY29kZSBmcm9tIGRtYS1mZW5jZS11bndyYXAuYyhieSBDaHJp
c3RpYW4pLg0KDQpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0K
Q2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCkNjOiBTdW5p
bCBLaGF0cmkgPHN1bmlsLmtoYXRyaUBhbWQuY29tPg0KQ2M6IEFydW5wcmF2aW4gUGFuZWVyIFNl
bHZhbSA8QXJ1bnByYXZpbi5QYW5lZXJTZWx2YW1AYW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IEFy
dmluZCBZYWRhdiA8YXJ2aW5kLnlhZGF2QGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2RtYS1idWYv
ZG1hLWZlbmNlLXVud3JhcC5jICAgICAgICAgICAgfCAyOSArKysrKysrKysrKysrKysrKysrDQog
Li4uL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2UuYyAgIHwgIDIgKysNCiBp
bmNsdWRlL2xpbnV4L2RtYS1mZW5jZS11bndyYXAuaCAgICAgICAgICAgICAgfCAgMyArKw0KIDMg
ZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9k
bWEtYnVmL2RtYS1mZW5jZS11bndyYXAuYyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtZmVuY2UtdW53
cmFwLmMNCmluZGV4IDJhMDU5YWMwZWQyNy4uMTg4NzRlZWRmMDkxIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9kbWEtYnVmL2RtYS1mZW5jZS11bndyYXAuYw0KKysrIGIvZHJpdmVycy9kbWEtYnVmL2Rt
YS1mZW5jZS11bndyYXAuYw0KQEAgLTE3OSwzICsxNzksMzIgQEAgc3RydWN0IGRtYV9mZW5jZSAq
X19kbWFfZmVuY2VfdW53cmFwX21lcmdlKHVuc2lnbmVkIGludCBudW1fZmVuY2VzLA0KICAgICAg
ICByZXR1cm4gdG1wOw0KIH0NCiBFWFBPUlRfU1lNQk9MX0dQTChfX2RtYV9mZW5jZV91bndyYXBf
bWVyZ2UpOw0KKw0KKy8qKg0KKyAqIGRtYV9mZW5jZV9zaHJpbmtfYXJyYXkgLSByZXR1cm4gdGhl
IHNocmluayBmZW5jZXMgZnJvbSBmZW5jZQ0KK2NvbnRhaW5lcnMNCisgKiBAZmVuY2VzOiBhcnJh
eSBvZiBmZW5jZQ0KKyAqIEBudW1fZmVuY2VzOiBudW1iZXIgb2YgZmVuY2UgaW4gZmVuY2UgYXJy
YXkgQGZlbmNlcw0KKyAqDQorICogb25seSBrZWVwIG1vc3QgcmVjZW50IGZlbmNlIGZvciBlYWNo
IGNvbnRleHQuIEl0IHdpbGwgcmVtb3ZlDQorZHVwbGljYXRlDQorICogYW5kIG9sZCBmZW5jZSBv
ZiBzYW1lIGNvbnRleHQuDQorICovDQordW5zaWduZWQgc2hvcnQgZG1hX2ZlbmNlX3Nocmlua19h
cnJheShzdHJ1Y3QgZG1hX2ZlbmNlICoqZmVuY2VzLA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1bnNpZ25lZCBzaG9ydCBudW1fZmVuY2VzKQ0KK3sNCisgICAgICAgdW5z
aWduZWQgc2hvcnQgY291bnQgPSAwOw0KKw0KKyAgICAgICBpZiAobnVtX2ZlbmNlcyA8PSAxKQ0K
KyAgICAgICAgICAgICAgIHJldHVybiBudW1fZmVuY2VzOw0KKw0KKyAgICAgICBzb3J0KGZlbmNl
cywgbnVtX2ZlbmNlcywgc2l6ZW9mKCpmZW5jZXMpLCBmZW5jZV9jbXAsIE5VTEwpOw0KKw0KKyAg
ICAgICBmb3IgKGludCBpID0gMTsgaSA8IG51bV9mZW5jZXM7IGkrKykgew0KKyAgICAgICAgICAg
ICAgIGlmIChmZW5jZXNbaV0tPmNvbnRleHQgPT0gZmVuY2VzW2NvdW50XS0+Y29udGV4dCkNCisg
ICAgICAgICAgICAgICAgICAgICAgIGRtYV9mZW5jZV9wdXQoZmVuY2VzW2ldKTsNCisgICAgICAg
ICAgICAgICBlbHNlDQorICAgICAgICAgICAgICAgICAgICAgICBmZW5jZXNbKytjb3VudF0gPSBm
ZW5jZXNbaV07DQorICAgICAgIH0NCisNCisgICAgICAgcmV0dXJuICsrY291bnQ7DQorfQ0KK0VY
UE9SVF9TWU1CT0xfR1BMKGRtYV9mZW5jZV9zaHJpbmtfYXJyYXkpOw0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCmluZGV4IDMyODhjMmZmNjky
ZS4uY2M3NGJiMGVkMDZmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91c2VycV9mZW5jZS5jDQpAQCAtODUxLDYgKzg1MSw4IEBAIGludCBhbWRncHVfdXNlcnFf
d2FpdF9pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRhLA0KICAgICAgICAg
ICAgICAgICAgICAgICAgZmVuY2VzW251bV9mZW5jZXMrK10gPSBmZW5jZTsNCiAgICAgICAgICAg
ICAgICB9DQoNCisgICAgICAgICAgICAgICBudW1fZmVuY2VzID0gZG1hX2ZlbmNlX3Nocmlua19h
cnJheShmZW5jZXMsIG51bV9mZW5jZXMpOw0KKw0KICAgICAgICAgICAgICAgIHdhaXRxID0gaWRy
X2ZpbmQoJnVzZXJxX21nci0+dXNlcnFfaWRyLCB3YWl0X2luZm8tPndhaXRxX2lkKTsNCiAgICAg
ICAgICAgICAgICBpZiAoIXdhaXRxKQ0KICAgICAgICAgICAgICAgICAgICAgICAgZ290byBmcmVl
X2ZlbmNlczsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RtYS1mZW5jZS11bndyYXAuaCBi
L2luY2x1ZGUvbGludXgvZG1hLWZlbmNlLXVud3JhcC5oDQppbmRleCA2NmIxZTU2ZmJiODEuLjk0
ODAxZmVlZWU0YiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvZG1hLWZlbmNlLXVud3JhcC5o
DQorKysgYi9pbmNsdWRlL2xpbnV4L2RtYS1mZW5jZS11bndyYXAuaA0KQEAgLTcyLDQgKzcyLDcg
QEAgc3RydWN0IGRtYV9mZW5jZSAqX19kbWFfZmVuY2VfdW53cmFwX21lcmdlKHVuc2lnbmVkIGlu
dCBudW1fZmVuY2VzLA0KICAgICAgICAgICAgICAgIF9fZG1hX2ZlbmNlX3Vud3JhcF9tZXJnZShB
UlJBWV9TSVpFKF9fZiksIF9fZiwgX19jKTsgICAgXA0KICAgICAgICB9KQ0KDQorDQordW5zaWdu
ZWQgc2hvcnQgZG1hX2ZlbmNlX3Nocmlua19hcnJheShzdHJ1Y3QgZG1hX2ZlbmNlICoqZmVuY2Vz
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBzaG9ydCBu
dW1fZmVuY2VzKTsNCiAjZW5kaWYNCi0tDQoyLjM0LjENCg0K
