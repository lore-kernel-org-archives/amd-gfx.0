Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A86CFA775
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 13:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C704B10EA0E;
	Fri,  4 Oct 2024 13:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lupT6KuG";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA1E10EA0E
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 13:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQaArPmOZaQBaXG6Rg+WArjxnR2w6+oBj3AqtFvmc+o9voxOVdgJzocZ0uK4+nriqig4QevWb6CE3pLKR/ZUR++j95yENQ6Cujp4KNVD/0L2xn5OxaVcwKu0jlKvnwoNbBDEdBcUukAZ/P9NeKzTT7fNVAuBex3UsJCoQSLXn/HY1H7KAJSbnPxyRF0IijXONlt1RcDJ875SIqWZ9aFZkGPMMHKNkW06gpfTfhff1Y/4feAqqOfcjqe1l0AY3ypYIvF9smJvgXc5IWy4XOhxYnxubx9T+BPEKdVIrDTJAM4+2ndvtcPUP9KJyn+xaJpALsM4wPu27cE+Tnu5vX7ZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pnbNB4IfNRMz+5Q6swmXHK3w3IIKWNYbSwU92kHkrg=;
 b=GsB+p8kFM1EEjI0bXcO4HA5zz9iwm9CPmz3LKVzvjjxPhyRaQ/rb5w64LQxqlNjuoRCvLqI4g+iFn6pQ4x/5jfCmId4ePZb4+ed2raDRscOABZ7A9wnNMQVN+lvhIJS4iVta/dcxN+f39VT3z10iBq0iTvNXkATd5CON/luy2Bpxpe8NM+yF9tYZq0VIau+IdSelQpSKVTrj55rtSvdrZMcUZCJAFsa2Hf9Z9fI/CW6iHRprvqvSNnGI2mlpHvlWjrW+xlzl1LLmTJ6SNSqZ1duKjQVzlFnUX/jYEJEYZSGFxZ/6R7ZB3iqiEtlPZefl2CVLBLLa0VQ/pGT7ZhmDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pnbNB4IfNRMz+5Q6swmXHK3w3IIKWNYbSwU92kHkrg=;
 b=lupT6KuGs95Qu+YtCq3T6G8I2kVFKoqVYFWXr7usjioGxWbVP6G7frsrYD5VaeP+0qezwfThAmWSUCDLbW4Qok0CgNJCAN06H/tZTRW+Ht2hSLKmiRpSs76hty/CozWBA13V5bdMzaKdxnl/ItfDAwNQdueQr3fP0lH2mDL+LPk=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 13:52:56 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 13:52:56 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: not restore userptr buffer if kfd process
 has been removed
Thread-Topic: [PATCH v2] drm/amdkfd: not restore userptr buffer if kfd process
 has been removed
Thread-Index: AQHbFdYaTvXUh/koQkSEiN/hcI2iR7J1hgMAgAAQowCAAQY+YA==
Date: Fri, 4 Oct 2024 13:52:55 +0000
Message-ID: <BL1PR12MB5898A00B1AAFFE27CEBB6FC685722@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20241003205526.35748-1-xiaogang.chen@amd.com>
 <63ed9ee7-a4a1-4912-9ef7-743879941ced@amd.com>
 <0e3ffe8d-da8d-4932-99f8-8241d17573f6@amd.com>
In-Reply-To: <0e3ffe8d-da8d-4932-99f8-8241d17573f6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=266ce730-3bf5-4faf-b90c-cab85717bf8e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-04T13:49:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|CH3PR12MB7523:EE_
x-ms-office365-filtering-correlation-id: b608ddd2-0bac-4f40-bbcf-08dce47bd96e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TlBNZDNjRHRRUEtlYXRncUxvNlNVRDd6Rytxa0hYNFBseHFib3VtNUFtYld1?=
 =?utf-8?B?R2lmL0FWc0ZFRGdqcFpnckJjcEFyTEFSOGJkR1pRdEhkSVp1UkNWaTVtOTh2?=
 =?utf-8?B?MWdJYTVRSXo1d256NmJvMXFvMlFET2YrTExqSHJiL21kbC81WW5tZHZScmM2?=
 =?utf-8?B?NXd5ME5PMjdmVmdhcFNQKzVzdDFWVktWWWhmN0VVSWxYRFBQSzZhc3VtTURP?=
 =?utf-8?B?N1U5ZDhXUUIrS0tubXhBRVkxd0ZnTUswZzFsbGF6Nlg1WlJ2UFdYWjBSQjln?=
 =?utf-8?B?S1J5d09jcEd3R3k2U3Y3bXlnN0ZuN2JneEF6bGpVSnd6cC9lNFBqWE44ditZ?=
 =?utf-8?B?R0dCbHAySTIrR3hBQmdMTGVWY2VzZ0hjTE1RZzlyNndHNXBLRFJHS2w3aVd3?=
 =?utf-8?B?a3BSSHh0ZU0zQjdQNGFsaU1laVNYZmFsbXAvVzFxWnRBWE5oTkdja2JZNDlC?=
 =?utf-8?B?YVRhS2gvNUZPaVo5bklrZ3RxLyt0ODd3V1hTNFRwaFZwUjgyU09wcXZPb3Zq?=
 =?utf-8?B?cExEUHpLVlFaNzNhNUVadHBpaG0wSWc4a1ZvbDMvcGt6Vy9KemJOQ2ovS2hv?=
 =?utf-8?B?VWpQSlgxdFR5ZkZGNTk0YXZMZ0c4aVlEdzVWMXRhVGE3VWtEMExrL1kvTk9K?=
 =?utf-8?B?dUpod2toRnc2QWNRMFRmNVJZdUpzQVNzMW9uV29hVGxPMSsweDNCZkpwSFRQ?=
 =?utf-8?B?eTN6bFVudWRtM2lsZDR0QVdUa2h4WUFmd2RLOXhLTFE4TnFYTEI0U3paVnJN?=
 =?utf-8?B?TjdIMHBXM0VQa3dVcThFYlRpek5jWnMvNFk4bWZHWm9nZDRxWVZ1cUpsNWU2?=
 =?utf-8?B?MGt0Tzc3NWNuTVZWaHUvY1V0MXRSaHgwYXBVZGlGOVEzRFZuai9DTlhPWVZK?=
 =?utf-8?B?anQ0U2V5bitRSmRwdUV6MEtSSno5N2ZQdEU1R1l4ckNIUUJ0QkRMMjN5YnNq?=
 =?utf-8?B?SVRJNlYwUG1pMWJrZG9yek5QbittdWdkdmlQOVlPTFcvRlBjeVlGaWxkUHQz?=
 =?utf-8?B?MytyWDI2V04vRmtySUFiRTBLNGNxY3hHR1o4UUtzVm0xSUZOYzN6aU8wUXR3?=
 =?utf-8?B?RW9TRWU4SmlId21UK2lmdFZlTTNLMzJJcVNmSFNGdExuUVVYOVhyN1dSSkJT?=
 =?utf-8?B?Lys5WHFUVWtZUTFzYU1PTWZWZUY5cEJqbDVvY2dLYTdhdTJQNXZuaDAvQk5O?=
 =?utf-8?B?VkJ2WlRYVFcya1Eyc2ZXSDVsTlg2QWk3bGNQK1J1QzE5ZFF0V2Zjd2JMSGNZ?=
 =?utf-8?B?cDZKbDlqdzVUcmNzTml6dGNkK0Zjc05JQjFBSTUvamZtZEZHejRFemdySG0x?=
 =?utf-8?B?bTFlaHdqOEdPWWFjS1JIdTFoU0dDQktUTVNMN0o3SnZhbEpPRXpseDQ0bXpB?=
 =?utf-8?B?ZkZDVklIcnFYSEhpWC9Sa2FxZlpMdnc5Y3ladFRUM2tFVWd5VEpBVktvTlor?=
 =?utf-8?B?RWFzbEY2QWJ6QjdyMmk0YWhKQzNWQnNCMkJwT2svY2hpSTMrdEtKaCtveksr?=
 =?utf-8?B?UE1qSC9zdXlQMllRaG5sZ05jSXMzZFhSckUwK2hEdUgyOWR6a295RFRGSTlW?=
 =?utf-8?B?K1hFMG5KTjh4R21QRUUvcVk3eWdoNlcxK2dmc3hHa0RaT2NSM24raithOXMr?=
 =?utf-8?B?ZWZJcmhIWnJ5UHMweVFJRGc5UWhjMzEwekxtZW00b2IzR2NiRENjQnppQ0dW?=
 =?utf-8?B?RUsrOTZlazV3VWliMjV0NGtkL2hzMGpVV29hb2VhM2R4Q25vWVdBYW1FZUJn?=
 =?utf-8?B?cDdaRnR5V0dwbzg2UnBtM2FCVWw2N2pLenNPQ2lMbnBYdGoyNDlpdXVISGhj?=
 =?utf-8?B?bUU4a3BxRDRJeGtpM0xrZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cm5wUTc4aWc1YlVGSThKUDBmVS9pdG5DNFNLRVhrdlhXSmtoci9Zb1FMTXBG?=
 =?utf-8?B?aEhIdndDODVrd3p6WVJxRUtmbWNocit0WGI5ME42NGkwTkRXa2xRcHJWYXlT?=
 =?utf-8?B?OVRrVmxFSDRGQVdQQTBvK3NiODd6SFI2cUpYOFBGcnRNS3lFemVYMGxPS0hW?=
 =?utf-8?B?QkJPUEJxSy9vTzVlQ0ZldlBoakJFREFCVnhKOUhCMmkwVGs1NWwrUFhWZy9D?=
 =?utf-8?B?MkgxMmJ0ZEVVOUhvSDB1am90MzdaQ20ra1Z1cHRvb1pMeDk5TklCQnV0b3Jk?=
 =?utf-8?B?Z0dMYzUrNXdHRW14dVppaTgxZUVBZ0JVRDZ6UFJuU1pheVR1bWF4V3BUMTVR?=
 =?utf-8?B?UVpjQTBzMDRyZFF6OWtxSUFMMU52US9aMmxEU2VYQnV3ZFQyL2NWbEE1Smda?=
 =?utf-8?B?eENhSlRWRlA0SEkxait4VFRlUmRlUWtRVDBzSHpHdTNKOVp0eE1WTEFYemhO?=
 =?utf-8?B?UHZvR2VjQmdVY0M5dE02RTRFSVlEaXI0VVdTYWk1Si95dDlzUWRVaXJuSW1X?=
 =?utf-8?B?Q3NVVUxCN3FwbkwzUVN3b1BhbmJVeWUxT01EemJhU3c3Y3NTeDh5Y2t5bXNC?=
 =?utf-8?B?SnhBRFRYYkxta0wzY05RNC9kNmo5OHpUUVdRNThyczdrN0hNeEhmMHBqU0pV?=
 =?utf-8?B?UHJIcCt6U3Zuc2M1UU16NlZRb1VJb1BCN0JhaHMwaEt1OEpTb05GME5DbDd0?=
 =?utf-8?B?TGE0TVpmeEsyQ29zdEo3TkFsa280SFVyVlZYRy9qSkZ3QW85dnVJMnBLd3BL?=
 =?utf-8?B?YjlrQmVrN2hTajFUVXM3UEkzNmNsYjdxZGRudEJ0Q2QxcUF4MVZ1NzhLNFNj?=
 =?utf-8?B?eUw2dE0xd3pjYW5KaXd4bDNFZ2ZSOXVRU1VxNlo2YzBOZXE1aGlxQTJXRGJU?=
 =?utf-8?B?NFhMRHZsUXVIbjVSVnMvVVNWQ2RlT3lnZW43Nkc3dDJJeHRDVGQ5ZGZ1UXBC?=
 =?utf-8?B?MGxuWWwvWmE1bzdzRUdVV1ZoSVZxOE9WeGdHSk94MDNQV3pWd1lHMXc3Nm5p?=
 =?utf-8?B?ZDhUOVMyVE92MzVTYnRMZGMxa2R0L084TEdGdFJCa1pXQUVhSXUvTjcrQWtm?=
 =?utf-8?B?L2lZLyt6dWhKQUVIaXJwL2tsRTA0bitpZkV4V2N2dllBWWpEaDBMcXlEcHgz?=
 =?utf-8?B?TWFFa0VEejFOcUhoK3VNMVVrdndLS3Q3UzdyOVhXdTR3NGlkejBQU0ZpVmdU?=
 =?utf-8?B?R1lXcFZMb3h3cFg4M1NQbEE3Q2lRbUdlOG15NTc2dVdVR2d1WGE2aDBMaEZJ?=
 =?utf-8?B?SldXcjV2N1gxNVZNU3VBTnczaGpiY3VNNFVFSzZMK05mYmYrTUpmaTJvUTF2?=
 =?utf-8?B?N0tONjZKMi9mK0c2RmEyanZPc0NvWm1jc2ZxNUp0ZGpES1pHTEV3QUwxQ2FS?=
 =?utf-8?B?cEZhcW5tZTFXMGNwa29XWjZTdXNCYzd6Qm5FVVhzN0M1Um5XVTVOVGFXenRr?=
 =?utf-8?B?VHNQQ3J6T0dGcWNOOHpENHlodElNNStKSVFiU2diN3pZM0lZNnlnalhzd3JN?=
 =?utf-8?B?MkNmQmV3cGlFU09tQmJKTmpIYkVxcVo1SnBsQmtocTRyS1Q0alo5T0pTbXZZ?=
 =?utf-8?B?V2dVbEN5eVJqVS9Vd3dTUS9EQzdmbThVUjV3NzJVSWdHRUdtelVJemYzRUdp?=
 =?utf-8?B?TzljNFkrSmRYRXZ4SFBvTSswNnZ4bTVpRXRoRExpS2VDZ0c0b0psQ21GS3NT?=
 =?utf-8?B?K2tDV2tCYWdOMEtXaFdVTVFFZHhOTkcvdFNpQXltUHpTMFZXY0FZd1hJS3pY?=
 =?utf-8?B?ZWdxbTRwUjkzbkw1Rk0yRWlpSnp4U29tNy9US1dxL2tyRVRoYzJCay81anRt?=
 =?utf-8?B?akkxWldtbmU2WUJUTTBPWTBFWG9jRDJrWWRHTFU1ckV2dUJKU2VEVy9XcFo0?=
 =?utf-8?B?aVVPRVpFQUZXanBZanNnSTlIQUxuaHVNZ1FsMnp4OU9kYm1HQnpLR3Bzdnpx?=
 =?utf-8?B?d1RPN2ZsQkszaE5ZaS8yRTRjcmFhWkVZMXlDeFJYSGUxN1FWdDJZOGxXYXB6?=
 =?utf-8?B?eXluVnd1Tm56MmlTejlTOWU0RWN2Nm9YOG5yWTBEZUE1TjVDWnJFcFRqQ21H?=
 =?utf-8?B?N1J4dERjRzF3RXlIeUxQVWswTGRvUXVvMC92ZWYyaGdPeG90WExQTlZOYm53?=
 =?utf-8?Q?DzOQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b608ddd2-0bac-4f40-bbcf-08dce47bd96e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 13:52:55.9714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: muz8wAeUBmP4SFiEj8V91ze6zYghP+yCdUBkZlrQ3i1USPhDp7pcLwp/ZlMeO83QRpNtqZY4RIYAlbq45GQDFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4
LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQ2hlbiwNCj4gWGlh
b2dhbmcNCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMywgMjAyNCA2OjExIFBNDQo+IFRvOiBL
dWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPiBDYzogWWFuZywgUGhpbGlwIDxQaGlsaXAuWWFuZ0BhbWQuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBkcm0vYW1ka2ZkOiBub3QgcmVzdG9yZSB1c2VycHRy
IGJ1ZmZlciBpZiBrZmQgcHJvY2VzcyBoYXMNCj4gYmVlbiByZW1vdmVkDQo+DQo+DQo+IE9uIDEw
LzMvMjAyNCA0OjExIFBNLCBGZWxpeCBLdWVobGluZyB3cm90ZToNCj4gPg0KPiA+IE9uIDIwMjQt
MTAtMDMgMTY6NTUsIFhpYW9nYW5nLkNoZW4gd3JvdGU6DQo+ID4+IEZyb206IFhpYW9nYW5nIENo
ZW4gPHhpYW9nYW5nLmNoZW5AYW1kLmNvbT4NCj4gPj4NCj4gPj4gV2hlbiBrZmQgcHJvY2VzcyBo
YXMgYmVlbiB0ZXJtaW5hdGVkIG5vdCByZXN0b3JlIHVzZXJwdHIgYnVmZmVyIGFmdGVyDQo+ID4+
IG1tdSBub3RpZmllciBpbnZhbGlkYXRlcyBhIHJhbmdlLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2Zm
LWJ5OiBYaWFvZ2FuZyBDaGVuPFhpYW9nYW5nLkNoZW5AYW1kLmNvbT4NCj4gPj4gLS0tDQo+ID4+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwgMTIg
KysrKysrKystLS0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiA+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiA+PiBpbmRleCBjZTVjYTMwNGRiYTkuLjFk
ZjA5MjZiNjNiMyAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiA+PiBAQCAtMjUyNCwxMSArMjUyNCwxNSBAQCBp
bnQgYW1kZ3B1X2FtZGtmZF9ldmljdF91c2VycHRyKHN0cnVjdA0KPiA+PiBtbXVfaW50ZXJ2YWxf
bm90aWZpZXIgKm1uaSwNCj4gPj4gICAgICAgICAgIC8qIEZpcnN0IGV2aWN0aW9uLCBzdG9wIHRo
ZSBxdWV1ZXMgKi8NCj4gPj4gICAgICAgICAgIHIgPSBrZ2Qya2ZkX3F1aWVzY2VfbW0obW5pLT5t
bSwNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgIEtGRF9RVUVVRV9FVklDVElPTl9UUklH
R0VSX1VTRVJQVFIpOw0KPiA+PiAtICAgICAgICBpZiAocikNCj4gPj4gKw0KPiA+PiArICAgICAg
ICBpZiAociAmJiByICE9IC1FU1JDSCkNCj4gPj4gICAgICAgICAgICAgICBwcl9lcnIoIkZhaWxl
ZCB0byBxdWllc2NlIEtGRFxuIik7DQo+ID4+IC0gICAgICAgIHF1ZXVlX2RlbGF5ZWRfd29yayhz
eXN0ZW1fZnJlZXphYmxlX3dxLA0KPiA+PiAtICAgICAgICAgICAgJnByb2Nlc3NfaW5mby0+cmVz
dG9yZV91c2VycHRyX3dvcmssDQo+ID4+IC0gICAgICAgICAgICBtc2Vjc190b19qaWZmaWVzKEFN
REdQVV9VU0VSUFRSX1JFU1RPUkVfREVMQVlfTVMpKTsNCj4gPj4gKw0KPiA+PiArICAgICAgICBp
ZiAoIXIgfHwgciAhPSAtRVNSQ0gpIHsNCj4gPg0KPiA+IFRoaXMgY29uZGl0aW9uIGlzIGFsd2F5
cyB0cnVlLg0KPiA+DQo+IHNvIHN1cmUgd2h5IHRoaXMgY29uZGl0aW9uIGlzIGFsd2F5cyB0cnVl
PyAga2dkMmtmZF9xdWllc2NlX21tIGNhbg0KPiByZXR1cm4gLUVTUkNIIHdoZW4gaXQgY2Fubm90
IGZpbmQga2ZkIHByb2Nlc3MgY29ycmVzcG9uZGVudCB0byBtbmktPm1tLA0KPiB0aGVuIGFib3Zl
IGNoZWNraW5nIHdpbGwgYmUgZmFsc2UsIHRoZW4gd2lsbCBub3QgcXVldWUgcmVzdG9yZSB3b3Jr
IGl0ZW0NCj4gaW50byBzeXN0ZW1fZnJlZXphYmxlX3dxLg0KDQpJZiB5b3UgZXhwYW5kIHRoZSAy
IGNvbmRpdGlvbnMsIGl0IGJlY29tZXMgImlmIChyICE9MCB8fCByICE9IC0zKSIsIHdoaWNoIHdp
bGwgYWx3YXlzIGJlIHRydWUgZm9yIGFueSB2YWx1ZSBvZiByLg0KDQogS2VudA0KDQo+DQo+IFJl
Z2FyZHMNCj4NCj4gWGlhb2dhbmcNCj4NCj4gPiBSZWdhcmRzLA0KPiA+ICAgRmVsaXgNCj4gPg0K
PiA+DQo+ID4+ICsgcXVldWVfZGVsYXllZF93b3JrKHN5c3RlbV9mcmVlemFibGVfd3EsDQo+ID4+
ICsgICAgICAgICAgICAgICAgJnByb2Nlc3NfaW5mby0+cmVzdG9yZV91c2VycHRyX3dvcmssDQo+
ID4+ICsgbXNlY3NfdG9famlmZmllcyhBTURHUFVfVVNFUlBUUl9SRVNUT1JFX0RFTEFZX01TKSk7
DQo+ID4+ICsgICAgICAgIH0NCj4gPj4gICAgICAgfQ0KPiA+PiAgICAgICBtdXRleF91bmxvY2so
JnByb2Nlc3NfaW5mby0+bm90aWZpZXJfbG9jayk7DQo=
