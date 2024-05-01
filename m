Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8311C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 20:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E90EE10EAA5;
	Wed,  1 May 2024 20:38:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bWmrCaR0";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B67F10EAA5
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 20:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPn+eJr19Mvji0jQzXFptYBICqc0KDIhacuLBBE/QoaHXccI59oyxhvpeYc2DjlMUW8663z5NmYEVSYVPScwJWPuzSBxseo3hL9zUV80MYIkOFoxeuc3mLtmU7fldlUfA85xGHB+OiJyX+0Ni6fh2l3uP6c6d7j8ygeYPpHJAKBrTJj/7nflJzX2//OyvcuvLfAt5R2l3vDZH6cGFlX5SwD/la3+wAZNclTiueUDg8xrhTQ3Nj44aVOMraNavX50fmlI1khTdSty1Ek1pDfyzl1xqMLTH5Ub68KWE996mQbCdvjGoQhb46cRFw7xYSR/2jiNyfmdkZDwWPZ+Z3pyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07ebaCldVZDZy/iHXRwXFjI66P8f9C2P3eDBmSnsv2c=;
 b=ZFUooU/4mTxKdGpXIMIq9BQoVEk7palaT5hRNWFIfW6EQiFLZGa4r7474apJtjzGip/gVpjnNNcMrM2A9Fr67DD7tkoaz5Do2bJw5sHhURA4c9ZdPw8u9RKEB4i16I7PbppHQmmmE3D1gBJwGrOrM/uqja9QrH5dy/Y7h2//vOx6mU9alfJh7KBefYOMKv7thRnZFJdJg/5JP3Fx2rmIC3XiiSaojkOaukDzSQY0P+0oyoGg7DcWOedEPMFrRAgJ+gBpDkLatu836B7i9R0a5s2ajOShrIW8ZwsAeuvCD8V8oru3dhztrY4mlvBOaWErWqEAH6NI/B7HsZNJbA9cNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07ebaCldVZDZy/iHXRwXFjI66P8f9C2P3eDBmSnsv2c=;
 b=bWmrCaR0sOg7OxFsFgV9b6LRKe/bdBM1tTRrHJyoLZOCMWZR2TogHNblqHBlQagq6axrelDq1wz2TgHzvcD5RmKxHJVj/fVqX0z/Ad+S3mqsWRFZ/MfAyWhSNIicntYDsuZ7Podh1czmnGZUSBKTdj2/bLpSeppr6JjgPpear9I=
Received: from DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) by
 PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.29; Wed, 1 May 2024 20:38:01 +0000
Received: from DS7PR12MB8321.namprd12.prod.outlook.com
 ([fe80::5a8:7f31:78b8:c41d]) by DS7PR12MB8321.namprd12.prod.outlook.com
 ([fe80::5a8:7f31:78b8:c41d%4]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 20:38:01 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdkfd: Fix a resource leak in
 svm_range_validate_and_map()
Thread-Topic: [PATCH] drm/amd/amdkfd: Fix a resource leak in
 svm_range_validate_and_map()
Thread-Index: AQHam1Y3YDSqUvlft0SFa2vYgX9wZ7GCtaQAgAAHGYCAABtbsA==
Date: Wed, 1 May 2024 20:38:01 +0000
Message-ID: <DS7PR12MB8321B44C51A686414D50DD9FE3192@DS7PR12MB8321.namprd12.prod.outlook.com>
References: <20240430232901.2878169-1-Ramesh.Errabolu@amd.com>
 <5ec8572d-1eb3-4475-b953-2f70f5df9493@amd.com>
 <78000261-387d-4794-ace1-c72865d95475@amd.com>
In-Reply-To: <78000261-387d-4794-ace1-c72865d95475@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6f6fe357-02cd-4099-bf75-d6fb216dc78b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-01T20:37:29Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8321:EE_|PH7PR12MB9174:EE_
x-ms-office365-filtering-correlation-id: 00ad30c1-2f01-4db5-2d30-08dc6a1e9801
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cVBBbWxJVS9PdnRMWTRETlcyZ1BhUE91Yno5YkgzMzczanlaTEZ1ZzFLcm9o?=
 =?utf-8?B?NzZ3Uk5xbUpiYXUyRDFGV25XK2ZoOTFBRUlSSGVUamozOC9CQXltbTlkUzMr?=
 =?utf-8?B?L1JXY2t2SG1TRDUwTHpYRWVpaEpka1N4aEdEWmp4S0o3WE54QUhTUWJyVmwz?=
 =?utf-8?B?SzBmL1ZKN1I2T1RoL0RpM05jWnJ0c2JiMkdqb2Zzb2xyOXFBVTg5UnZHMnV2?=
 =?utf-8?B?c0lnb2pxeXA5V3Nia3Z4UTg0V3NqT0lML1AwM3U3bDlLMHhTdmFLeFR0T2tU?=
 =?utf-8?B?dkdnaFpRMUNRYVlvTHdkc09XMmJleFhRZUJzUHYzZ2gwTjJPYm4wc0UrQkdr?=
 =?utf-8?B?YTlybmNDeXhhS2wvU0JkZmZsQXBOR2lOU2ZIeUZnN05oYWdPR1B5TUJ1dVJk?=
 =?utf-8?B?cUZFUEdEY25OUEFIMUZKd2FtZWVZeUZwcmJhdmlLUmpDQmZqV3ZsQWpCOWhC?=
 =?utf-8?B?YVh2aHRGcTNDMXVJSVBkWGM1SnhjNFU5aXhJbGRIZmx2SkdiR1ZPM29aNzFR?=
 =?utf-8?B?MWpleGxESEFEb1NkbkJnd1RoRkc4T3Q0dFd3aXVvOEsxRllwTkUxOStjK0Vs?=
 =?utf-8?B?djFPVWowN1VBUWxBTDdDYlI4MXNBQi9xRUxUYkJ1QjArUkVkWlZKVS9HcGcx?=
 =?utf-8?B?Z2lZYU54MXI3R3c0VnQranAxMkpKOEcxK3JFVUtEdkNZQ21nMXBSWGlkZjR3?=
 =?utf-8?B?TW8xcVdMQkZPTzJyeENQNXdGTXZ5RDk0OWlLaEhxZHFQcGlXbWl2N1dHcGxE?=
 =?utf-8?B?ei9tS3FHZU1mV3B6WkdjZDlURjZYODZkYUI4enQyMk93b0FUR2lnWTlTVHZM?=
 =?utf-8?B?d08yeEtteFVxQkhnK2VhODFmWi9aS0FDM0IwSXRLdmlqb0twVktBTFdJb01R?=
 =?utf-8?B?d2xYNE15Zk4rNVd4a1VRN0t2Z3E3Wlg3Vzcza29jRWwvM2ZTakdhS1A2OHlv?=
 =?utf-8?B?MW1BeUhPT0J1VThTNnBHdXZIVHJlNjg1Q3NBbnFBNDhtR2RMOTI2a2I2MFI2?=
 =?utf-8?B?YVJ4L09rcnFkNVIrY2ZFMEZtSUsxNit6NWhZSis3UklCTC9EdWdseHRURDlG?=
 =?utf-8?B?TUZXdTdXM2ErMHhERU1iR1FwTDRoSHpmYy8ySFNwcUJjZ0QxSkdjQkZ3T3NT?=
 =?utf-8?B?UW9iK08rMVJlbGZ1NWwvdlpyM3lKTGdWd1VrMVBVMlZNajVReDFsaEZwQllK?=
 =?utf-8?B?KzZkMHRZRlk5YUoxT01aTG5nQzBsRTUweEx1UGtmTmlScUNZQVhuYUJOZkxG?=
 =?utf-8?B?V0NYdXpNMHdJSWtPVHovM3p3bHdtUEZoRXVJNlkyMFpjVGtKQW9xVG10UnRR?=
 =?utf-8?B?YmNMTE1GTHdoODNqaURLTTBQYloybXBWa0tJajlZQjJjUTJWSHdlbXdLZHF5?=
 =?utf-8?B?Ky9CM2hBUHlQeHRJSlROb3ZGMmN4SHBsY0ROaE0xZmUzYjlJUjArYit6MTFD?=
 =?utf-8?B?RHRyYnkra0IramF0dmpxbGtKcTRGczBHVlRyb2tvUHVhTVhzcE1YbFY0a2c1?=
 =?utf-8?B?NnpEcTU3bWMvdXJ3MFRTT2h6b1l6bWFvZW52TkhDZzVpN00wdWt3OGF1QTdX?=
 =?utf-8?B?YnRpWHkvVlFaRjNLR0hGK1I4MW41eXI3ZU4wMVlHZFptMk0zczlDMEYrQlJz?=
 =?utf-8?B?aVgyQTRiaFZENkxFRDYyY2cvYjd1eGtwb0hYWmJoTXhHOTdRd2ZFTzh0SnpR?=
 =?utf-8?B?ZURRb0t0NWEvWWhpUjYzRE42bFZYZVh1MFpHbkdDR09vOEY5RmxtdE1NeDNy?=
 =?utf-8?B?MnA1N1NaVVRGU0VoREtIb0FET1Fmd2QyZE8ya2w1WmZZT0FuZTFsbkhTTjF6?=
 =?utf-8?B?V3dnYXNxazVzOGJmdjlvZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB8321.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVV2NzJ2ZHM3bjFqSGh5MmZ0TnhUdXcxb05OQmo3akt4dklKWU56NUpjYVY1?=
 =?utf-8?B?Wno2UXlKK0JIR0lOQ3FBMFhqVXg3SDd6dy92ZmNkNHBCN0FDaG9vcVdCMjVh?=
 =?utf-8?B?SGFybkk3SkNrSjlMVjd4empkdnJtZ21mOXhEMzdhUUNyNlJCOFBFd0ptSUs1?=
 =?utf-8?B?MlVXUC9oZ3QyRklsVUlwbElZcXBLUEZBNHNrR3plSTVqci9yZlFlUDRMQS9q?=
 =?utf-8?B?b2ovSDdFVWNmd2wrVWhRWnhBT3B5eVpsNUFFa1VnR3FzVEdYdXN1SzM2ZVZu?=
 =?utf-8?B?SllEajkwc1E2ZzdKZmQydkpNa01tZzVKOHFJeFdOUnREYU9JUU8yOUI0dCsr?=
 =?utf-8?B?djErNmRzVWlKaXdPRXZtdTdsT0tqeFB5TXZHZy9vaEdZbWpJNlBwbyt3d013?=
 =?utf-8?B?OUNzWEdGTitqNjRveWtuOHZaS0VramxmSFQ2TkpqcGpJMVdZVDRsZmV3dGJF?=
 =?utf-8?B?aFVtZkQ4dWVuM215VW4rV081YU9TeFlhL0VoV3VreWRVcjBNdGFpNVEwZlBa?=
 =?utf-8?B?aks2Nmo4T3ZtRFEwNlZJakJPRmp2OStjd0JmUTl0VXgyZW1sM0lQZUhoakRl?=
 =?utf-8?B?NDVVMmxDTzZaRnF2bk1LVGRERG1rdUhxTWhTLy9mejh5YXI0ekovak42T2w5?=
 =?utf-8?B?VXM3V2YzcnFqeVQ2U01KZEg2VGJzcStRZE14cmpHaHd6dkRXdFE1M2JrMjdJ?=
 =?utf-8?B?dUVZaU4vclpQemRHMUlqWG1XbmxqUmVuaUdOdnI2ZzlQV1Zrdy8vcUsxYzVj?=
 =?utf-8?B?MXUvWlZBczQ5Y1ZLcjRLN0N3VUJlVFJRcHYzZU13cVRxa002aDRVWVlmOG5i?=
 =?utf-8?B?d0lNaXVSS21EQ2orVTZxWXpqQXZ6ZEpKYW44bDJrRjErM1hIcnB4d0N2eW9I?=
 =?utf-8?B?QlRUVTVoQ1VJVFd0cXVlMFRMSWdDRGlWRzl0WEpNYzFUS1R4d1BTV0dkN1BP?=
 =?utf-8?B?d2FqbTFSZ1F5dzZTeTdVaFdBRGNtNU0zcFR5NWk2ckJSKzhkOWNUT2NXNDBF?=
 =?utf-8?B?eVVwZGdYVzl1U0ZPNDRxU012ZHFLNWU2Umc5dDNaVmlBNXFrTyswTTNDQVZ3?=
 =?utf-8?B?ZHRBZktScU56Z2M4YURnNHhTeGlSWVUzYXZnVldrY1J3K3lOTHZtb2ZEaVB0?=
 =?utf-8?B?WUZwR1pXY2liTXNMZWxQSFlCbjdQQ3dEY0hEQ2JaRE5OeWJieXYxSnUyOU9K?=
 =?utf-8?B?WjErUEhYWU1BSmFGZXk1NnR5NmJ2ZkIrbFBRL3d3cWtyU21DWFRGbC9sU0dl?=
 =?utf-8?B?dTVINUI5VGhiZnpvOGxMaWQxaTZPQitScGR2ckw0YnBLemJ6RkhRVisvdVBh?=
 =?utf-8?B?MmNhS2JSU0ltcnp3MXoxeVFVaUhabHhKVGE5THc5MFpSRkdrbXJvTncrN05o?=
 =?utf-8?B?SitmL2dkQVlSQXFTWjM3SFFRSnYveTdiZHd6MGQrVmN3NmxKaCtIcGYvRlJq?=
 =?utf-8?B?SGRrTTgweEFmSFozWlk0UiswUllaSkJGMlBmT0lhSTNvSHk2cHUvQ3B0YVBG?=
 =?utf-8?B?Z2ZsUXRsQWRpRTRJa3pwMEFUMzBBRkJFL1J5czVjWi9KM015NkcyUWFYOEtY?=
 =?utf-8?B?bmxlZUcyT3VQd3kzL0tXZUFUeGVmZEZIRmtYYWI3ZzRDaVl0VFRsWFB5L0RE?=
 =?utf-8?B?UVZPU2hxdWpxZDh5RUJQSWY2SFYzYnRRcUcwVFJ5Y201OGlaazlIckthSjV3?=
 =?utf-8?B?UmZ1TVdscDRxZDVtVngvdnYrMm1wbHU2V1lpYjlMcTFOeEg2dmx0bjVrK1Rw?=
 =?utf-8?B?ZlFMNFQyR0llVkIvT1lGUjl1MnF4eHZ5RmNMRmJIa0I4UHFuYlEvME0xSmxP?=
 =?utf-8?B?b0hrWUF6eDRYbjRKcWYrNlpnS20yRzVLWTRYS3FmbHBHaW1QV1dqOWhOQ3Rt?=
 =?utf-8?B?dXNNSEZvTG1PYzRzb1V6aWt3TEovVWU0SW81Ync5UHJVYnBlcmJJTWZoNDRX?=
 =?utf-8?B?QVhuUnBzY3hhblZGRDh4czBiNnA5cWx6Y0lIdHRTeVAzOWxZbnplS2tzSDc0?=
 =?utf-8?B?dGlxYkZESHhnUmNLUDJDVkRUcjhhdlA3b0hhOGdoQVU3WjE1WUJvbTgvTW5u?=
 =?utf-8?B?YnFIRmVkbzQxMVJpU0J2TGR2anVtcjdDVjR5QUdxZGJsOWo4ckNJbFR3eGhO?=
 =?utf-8?Q?1zew=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8321.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ad30c1-2f01-4db5-2d30-08dc6a1e9801
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 20:38:01.1015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mmm5r2Aj/qIUfejZ4g4ier3JrkqyUx2aJPKSzWNBQhLS5ZMoGWoaCuwYTGbbD2FXUg8/e+W2ZjGHwgfin//q7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9174
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkdvb2QgY2F0Y2ggb24gZHJvcHBp
bmcgcmV0dXJuIHZhbHVlcw0KDQpSZWdhcmRzLA0KUmFtZXNoDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+
DQpTZW50OiBUaHVyc2RheSwgTWF5IDIsIDIwMjQgMTI6MzAgQU0NClRvOiBFcnJhYm9sdSwgUmFt
ZXNoIDxSYW1lc2guRXJyYWJvbHVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL2FtZGtmZDogRml4IGEgcmVzb3VyY2Ug
bGVhayBpbiBzdm1fcmFuZ2VfdmFsaWRhdGVfYW5kX21hcCgpDQoNCg0KT24gMjAyNC0wNS0wMSAx
NDozNCwgRmVsaXggS3VlaGxpbmcgd3JvdGU6DQo+DQo+DQo+IE9uIDIwMjQtMDQtMzAgMTk6Mjks
IFJhbWVzaCBFcnJhYm9sdSB3cm90ZToNCj4+IEFuYWx5c2lzIG9mIGNvZGUgYnkgQ292ZXJpdHks
IGEgc3RhdGljIGNvZGUgYW5hbHlzZXIsIGhhcyBpZGVudGlmaWVkDQo+PiBhIHJlc291cmNlIGxl
YWsgaW4gdGhlIHN5bWJvbCBobW1fcmFuZ2UuIFRoaXMgbGVhayBvY2N1cnMgd2hlbiBvbmUgb2YN
Cj4+IHRoZSBwcmlvciBzdGVwcyBiZWZvcmUgaXQgaXMgcmVsZWFzZWQgZW5jb3VudGVycyBhbiBl
cnJvci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBSYW1lc2ggRXJyYWJvbHUgPFJhbWVzaC5FcnJh
Ym9sdUBhbWQuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9zdm0uYyB8IDYgKysrKy0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9zdm0uYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3Zt
LmMNCj4+IGluZGV4IDM4Njg3NWU2ZWI5Ni4uZGNiMWQ1ZDNmODYwIDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jDQo+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMNCj4+IEBAIC0xNjU4LDcgKzE2NTgsNyBAQCBzdGF0
aWMgaW50IHN2bV9yYW5nZV92YWxpZGF0ZV9hbmRfbWFwKHN0cnVjdA0KPj4gbW1fc3RydWN0ICpt
bSwNCj4+ICAgICAgIHN0YXJ0ID0gbWFwX3N0YXJ0IDw8IFBBR0VfU0hJRlQ7DQo+PiAgICAgICBl
bmQgPSAobWFwX2xhc3QgKyAxKSA8PCBQQUdFX1NISUZUOw0KPj4gICAgICAgZm9yIChhZGRyID0g
c3RhcnQ7ICFyICYmIGFkZHIgPCBlbmQ7ICkgew0KPj4gLSAgICAgICAgc3RydWN0IGhtbV9yYW5n
ZSAqaG1tX3JhbmdlOw0KPj4gKyAgICAgICAgc3RydWN0IGhtbV9yYW5nZSAqaG1tX3JhbmdlID0g
TlVMTDsNCj4+ICAgICAgICAgICB1bnNpZ25lZCBsb25nIG1hcF9zdGFydF92bWE7DQo+PiAgICAg
ICAgICAgdW5zaWduZWQgbG9uZyBtYXBfbGFzdF92bWE7DQo+PiAgICAgICAgICAgc3RydWN0IHZt
X2FyZWFfc3RydWN0ICp2bWE7IEBAIC0xNjk2LDcgKzE2OTYsOSBAQCBzdGF0aWMNCj4+IGludCBz
dm1fcmFuZ2VfdmFsaWRhdGVfYW5kX21hcChzdHJ1Y3QgbW1fc3RydWN0ICptbSwNCj4+ICAgICAg
ICAgICB9DQo+PiAgICAgICAgICAgc3ZtX3JhbmdlX2xvY2socHJhbmdlKTsNCj4+IC0gICAgICAg
IGlmICghciAmJiBhbWRncHVfaG1tX3JhbmdlX2dldF9wYWdlc19kb25lKGhtbV9yYW5nZSkpIHsN
Cj4+ICsNCj4+ICsgICAgICAgIC8vIEZyZWUgYmFja2luZyBtZW1vcnkgb2YgaG1tX3JhbmdlIGlm
IGl0IHdhcyBpbml0aWFsaXplZA0KPj4gKyAgICAgICAgaWYgKGhtbV9yYW5nZSAmJiBhbWRncHVf
aG1tX3JhbmdlX2dldF9wYWdlc19kb25lKGhtbV9yYW5nZSkpDQo+PiArew0KPj4gICAgICAgICAg
ICAgICBwcl9kZWJ1ZygiaG1tIHVwZGF0ZSB0aGUgcmFuZ2UsIG5lZWQgdmFsaWRhdGUNCj4+IGFn
YWluXG4iKTsNCj4+ICAgICAgICAgICAgICAgciA9IC1FQUdBSU47DQo+DQo+IE5hY2shIFRoaXMg
Y2FuIG5vdyBvdmVycmlkZSBvdGhlciBlcnJvciBjb2RlcyB0aGF0IGFyZW4ndCBtZWFudCB0byBi
ZQ0KPiBvdmVycmlkZGVuIHdpdGggLUVBR0FJTi4NCj4NCj4gSSB0aGluayBhIGJldHRlciBzb2x1
dGlvbiB3b3VsZCBiZSB0byBqdXN0IHJldnNlcnNlIHRoaXMgY29uZGl0aW9uIHRvDQo+IGVuc3Vy
ZSB0aGF0IGFtZGdwdV9obW1fcmFuZ2VfZ2V0X3BhZ2VzX2RvbmUgaXMgYWx3YXlzIGNhbGxlZDoN
Cj4NCj4gICAgICAgICAgaWYgKGFtZGdwdV9obW1fcmFuZ2VfZ2V0X3BhZ2VzX2RvbmUoaG1tX3Jh
bmdlKSAmJiAhcikgew0KDQpDb3JyZWN0aW9uOiBZb3Ugc3RpbGwgbmVlZCB0aGUgTlVMTCBjaGVj
azoNCg0KICAgICAgICAgICAgICAgIGlmIChobW1fcmFuZ2UgJiYNCiAgICAgICAgICAgICAgICAg
ICAgYW1kZ3B1X2htbV9yYW5nZV9nZXRfcGFnZXNfZG9uZShobW1fcmFuZ2UpICYmDQogICAgICAg
ICAgICAgICAgICAgICFyKSB7DQogICAgICAgICAgICAgICAgICAgICAgICAuLi4NCiAgICAgICAg
ICAgICAgICB9DQoNClJlZ2FyZHMsDQogICBGZWxpeA0KDQo+ICAgICAgICAgICAgICAuLi4NCj4g
ICAgICAgICAgICAgIHIgPSAtRUFHQUlOOw0KPiAgICAgICAgICB9DQo+DQo+IFJlZ2FyZHMsDQo+
ICAgIEZlbGl4DQo+DQo+PiAgICAgICAgICAgfQ0K
