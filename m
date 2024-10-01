Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD708CEACFF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Oct 2024 20:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B99310E67C;
	Tue,  1 Oct 2024 20:09:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="diK30ojj";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCCC310E67C
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Oct 2024 20:09:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxHR7NjdCCk5EkzdddpGb/PLq9+kCPATxPECgNjhAtvbeznJwggy3YOec0/r+tLp1W82Stp9KsicE5cXcOS6Cl5q8sXAt47xLDxVh/ydpq85L4XdU0l9tiZ/dTI069g8xqeFCOwixq1JsSe+6bHNAzoQIxnxPJQSpjFfXjdGY2JnR0mfsxEWky9m7hfUmEuJJxFCQDXNR/Gt4TvIQL0cUlFEHzW5E/6PlKoxJFhX1PpWaw4npxRiYcel8ns2d2gI0M+Pc4N8TBgnma06cWtw3HJzABNjl3nS0zh+EXMWyk2C/kn5ljl0HNo+V8TQfu0GlYaD3OXOtnJI9Q9/nH7VoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySApBBGP9PdAvPqt+aQViBrCus3ZJ0YnEVgHIHxJgUw=;
 b=UaM/fkosDvLcHvyI86gMlXl3LalhJi7Lr+ExyYkhOB/ICkjalj6VX3F0FWJd7mvz+9iBX9iIEhrHV+/zvYQE9hIePlDZLmT5GvPkKVCevLukqLJjFV4aGGs8+l4mrTEMpc9zEXIwWHYDrNFD0Y1TmtF+NV2SZWwW3APjIl+ly98yX2kc2jCS55/wqoGTaW7hNepYgp2r323g+GhQSnkt5GMsP35S/S5dbWCVT7HdPIkV1deQOjhLwDeHaeJmFPCfbaGRF9OhNWQiVjoj7AYsrWeoM9P5pDEa+Y9TwG0b8TcQJUX1+cCG2M34SpxKZlDfMMbWb9znQhuzZLX2CYZ1wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySApBBGP9PdAvPqt+aQViBrCus3ZJ0YnEVgHIHxJgUw=;
 b=diK30ojj1doYukVKPUe1kplzajawWbrlzUqnNKqvPUORZeqP5fwoSuHARec9s9DbAuZSNGDl7L8OQP2VFZauh9xdnO9P3Stvl3SlZ6jlK1uUwOA5xCntai0cTA5lxOPKD1lCqUDyt3z9R5B1t2cAqIGpmlHG9N1+DR66aSk9Veo=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CY8PR12MB8362.namprd12.prod.outlook.com (2603:10b6:930:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 20:09:33 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 20:09:33 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, John Rowley <lkml@johnrowley.me>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "regressions@lists.linux.dev"
 <regressions@lists.linux.dev>
Subject: RE: [REGRESSION][BISECTED] 58a261bfc967: choppy GPU performance
Thread-Topic: [REGRESSION][BISECTED] 58a261bfc967: choppy GPU performance
Thread-Index: AQHbE9Pb8DZMKBqMp0K/Cz9q61hhxrJyPX0AgAAF/suAAA/YgIAAAIQQ
Date: Tue, 1 Oct 2024 20:09:33 +0000
Message-ID: <BL1PR12MB5144E1E23B22D99E0024BDE4F7772@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <9b80e957-f20a-4bd7-a40b-2b5f1decf5a4@johnrowley.me>
 <925cd47c-8f1e-4b74-aeff-6d13ae5f0753@johnrowley.me>
 <95c575a3-100c-4808-b451-b92f14598188@amd.com>
 <836c2c82-4dfe-40f4-8d50-5e7bff04c38c@johnrowley.me>
 <7ed81635-3872-463c-94e5-e4972da9d014@amd.com>
 <bcc97e4e-ffe0-47a7-bd29-c993e5404a33@amd.com>
In-Reply-To: <bcc97e4e-ffe0-47a7-bd29-c993e5404a33@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=656414f1-08db-4bfd-a949-7a3e8704f338;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-01T20:09:06Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CY8PR12MB8362:EE_
x-ms-office365-filtering-correlation-id: 52f582db-0b99-46e2-935c-08dce254f772
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TGVNYkQ4QVR0WU1FNTJrWnVaVjZsOHY5RjFIQm5LQWhGWWtPZ0MwM3Y1YUh2?=
 =?utf-8?B?dGZVa3ZsRzh3M3dIdFJwa2xOekVRQktOaVE2RitDamtwd0FuVjBDZXM1cUMz?=
 =?utf-8?B?V0dVenl6VGZrQXVUMUNNUlVaZEg2L3JaTlFldWEvdUcvTG9jdkhGTG8yVnhO?=
 =?utf-8?B?MEJ4OVdwYU9yRFp4SnBES3VNVlUwT2Q5bXVxN2lwRHdPcGNGaGxpOHFHZm0r?=
 =?utf-8?B?S3VVdFpmemt6U3pEM0ljckorT1JIYzdYVVhqQVFCSXlMSURZQjBBVFlhekhn?=
 =?utf-8?B?WWc0bjliaXY5TjhsZi9pZUk5M0xjME5YWDc0cnRUcVpLN0c5U0Z3aW5pVkwz?=
 =?utf-8?B?TkE0OUpJY0ptQ2VHNVJLRUtSdkJCOWZ0SHMvK3JZeU1PQllqZmdsenUvOXh1?=
 =?utf-8?B?R1VzQVJacHZ3L0p0NWJWa2lmcnE0SytSSm9raGdqeDZTK29XQldlOXRiODhU?=
 =?utf-8?B?QUNmZmVDRVl2Ym95R2p5bERhbCtNWklKcHNUa21vRmx2S3ZDb1NFTGZwdXYv?=
 =?utf-8?B?OEhwdG5mZnBHSHVzaVJ1Y2s1aHcwRVRRRFBPZC9COEM0bENvNy90UDg0YWVJ?=
 =?utf-8?B?ZHdNZDdZbVhLZlhZYks2U04wcStGQ0RoOFd4QllSc3JQRVFBcmhwSzNvZW5C?=
 =?utf-8?B?dnhEcnJUVFpyNHoyV05wQU9XeHdIU1RNTUs2bUhEZnd0Wml1ZUdrelo2RFR2?=
 =?utf-8?B?UnBMQ2U1aTVPdHhZQXJVVms5aGV6OGJ6UThWMUdzRVUwNzJvcm1DUUZ0d09B?=
 =?utf-8?B?UUpvdHVHYmI5TjU2MXpVdjRLL3oyR29oL3dYend3Uk9DTEhPbjZ1eXN2Y2wz?=
 =?utf-8?B?ZHYybTRUMEh6NEEwY0hhNjcvZFFjbzYxUm5KK25Yc0luL2hIMDUvUkdESTFI?=
 =?utf-8?B?QXBFZk1iMEUvVVZwcEJrY2tPMTVXNXpoV0NHTmgwdDRWNmtIVHZoWWQ4S3VP?=
 =?utf-8?B?K2hSTDN1U0ZFVTVhYk4wek5zaXpZSDh1WEc1QVFPb2RyVEpEQXFzWkV2TmxS?=
 =?utf-8?B?b2FCalVLMXU1alhza0VhY1Y3YlRCRWhtVWtBd1IvQnExb3dhRFhDeW5wYWtj?=
 =?utf-8?B?bnpRdmtyR09OOXVndU5UU2s2K3BaWm1oQ0ZKYXhBM0VRVDgvdzdOZHpDRW9k?=
 =?utf-8?B?MEQ5eklsSC9ERTgyZFhEYmVobjM0VVczZkhCTW5Nd3lQSHljdmlOSU5VL3pj?=
 =?utf-8?B?blFidUFFOUIwV3UwMmNvT3JTU1BUWkhqdmVWQXB2SXBnM0E3TGt5S1I0VERL?=
 =?utf-8?B?T01aWEliTWd3REp6cHZYbFBBZDR4SVlkUHhwa3d4SUh3Zy9sTGo4QXNmcUNq?=
 =?utf-8?B?eW80dXZIbDZYUlhZS2s2UEVyVExvRThraExlRzQ4UlE0bU1oeTc1K0pIKzlq?=
 =?utf-8?B?dzJ3cEFuOFo0UmNZRXhSeFFvcVh1RjNwSEE0ZnhDMUdBVDNWUEFsRkZKMU5s?=
 =?utf-8?B?NDhycGVWN3RzZ3JaSnFjOGl1cllmTzVVMUxGeUZhYVNGZjdRTk8rclFYZ3BS?=
 =?utf-8?B?cDlxZktJTjNaSERMSG1Yb2UyWHpiKzlQTHdFM2FnVnFRUkNDa2JCK01MMklV?=
 =?utf-8?B?KzhtM0xzN0s5dllyRFdKQndndjdMM0xZMEp5L2JZVVVNaWdxL0RhMlZqcVVy?=
 =?utf-8?B?RHYyQ1RqUm5KTEM2b083SmhudTVqbnZjT0xBUkJ5d1F5K2RQNEw5ZGI3UWJ4?=
 =?utf-8?B?Y29sZjI5TER2THZaWGxHcjB2TDBoNTJnQlFOVDZ2SzVXdVlSTi9sR1RRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFpiTE0wNUNubk9QOVZxRnQwazA1aXVpczNoSEhPUEFVdVJKRTdRcTIvUExS?=
 =?utf-8?B?SDJQZzZXWXlyQWpCRFBrVUJqZFo0bE1hNlVWRmhRdGRGMHdMYUhwMWtLS2or?=
 =?utf-8?B?TXRKRFlITVV2TUo3bmRmVTVmdUgycGExV0ZRWGt5NmpmOGM4NmJZYWpHNHhZ?=
 =?utf-8?B?SFI3ZjdwQzc0ZTU1aVhzbXRmZ2pNc2Z1OVVkUVloZGdXc0pBSk9RcDJwOHp2?=
 =?utf-8?B?OGtiaHBnSzZFZk1ieHA5ZHZMM2FxSG00M2RJUzNmQVRBQUhiUW9JaTRMMlkx?=
 =?utf-8?B?VjJ2TDdvYy9WbURnRFVsSW5iMk1sL2lINk94eC9VaXd6MnlMYWMvakk3b2pv?=
 =?utf-8?B?QVZ6WTVZQnpwMUN2M1IxRXB0UHdqeVVJamU3d09uRnhWaUlnWkVyckQ5Wms3?=
 =?utf-8?B?ZW82bVdLTzRteDhGWnBPdkxUZXJzTUJtanNjN21ZemNHWEk0blFud0tIWE5z?=
 =?utf-8?B?VHcvejM4RW15blJOemE1VUU2dC9mMkppakF6RVUzYTRpckIyQnJuamF4ay9p?=
 =?utf-8?B?MnlqazNSUHVabldvcmM4dFJQbEVFQnQzN0EyZDhoM3RZa29leC9BNWd5Y3U0?=
 =?utf-8?B?enR4T0Q2VWQzT2lLL0JpYWxacGdaQ05DTnNVYVgrUHJKNlF6Y0RBdndqZE53?=
 =?utf-8?B?YUhSVFJnUXE2MnFXMTRSQzV6cjkwQWE4RlRWZjlVR2Vxb3hNUmpqeG9ITGpW?=
 =?utf-8?B?R1dDdHNTTktIQVFrUUxvUTQ3WkFpNXA0UXFuL0I1a2xEcFlvV3pWQjBwTmYv?=
 =?utf-8?B?akE2eWFlWEt4MW9TcWQrT0hjQ2cyWDlEVWxnb3dsOGV0bHErejd5UGNUV0Jr?=
 =?utf-8?B?RW00SmxkY24yOUFOTUNTSzgzQThGUGN1N0pkVDQrNG5tazlGdDBSbHd2bXdR?=
 =?utf-8?B?ZnQ3MVo3MjVQYS8yRVBudlVxN3daVldVeit1WmJnUXgyaWxST1BKNjBkeUo1?=
 =?utf-8?B?Z1UyNnVRN0U5clRheG1WMEw4ZU43QUhiVGlLNzlRSGlFM1ZrYnpDaW14R1JD?=
 =?utf-8?B?eHA3MlFnUGYxbHJxYVBiVnNZV1NOQjN1QUg2VnUzUEZ1bDY5UnpFZ01xREo4?=
 =?utf-8?B?dlBsRG1oTTgwNGVVeklmZ2hqb281NEVmWnVzS1dRUEM4bW9tck9EV3hISXFZ?=
 =?utf-8?B?eS9BakljWjBxM0JBbFFCR1dMQTZVT3JqbERuNTdickZ4bldRTUN3SXNUZStT?=
 =?utf-8?B?c1JjTStnV2t0alN0S01vNHhaS01nRzRlRUFXTTBUN1oyQkVWekUybjdhK0RT?=
 =?utf-8?B?Nit6YVN1bm1FQlFvRmVMOWkvZVJDcXg2STZvTlQzVEpFZGd1UU95TGlPS2sr?=
 =?utf-8?B?TEd4QUpWMElMTFRaVzdKTlk4MDNDMm8wNENGbHI1MkR4VFFieThTUWFGOFpX?=
 =?utf-8?B?alVtaFlNbVlBcmJvajFDdDAreW5PeWxia2pHY1V2ZjNybXJtR2xIdUkzSlFa?=
 =?utf-8?B?Y1M0NmZXd3UvTldSeGQ1K3duVFZPNTRlSkk5elVxdUN4WmtCYTJVV2FjRFV1?=
 =?utf-8?B?SmwwV245clVjWmwvaUtWNGdUK1d5UDRYT0g5SG16L1B6cVpzNjNoV0FyTS9y?=
 =?utf-8?B?czQyM3YzR0haUFlnSmw0YjlKdTFzcHFlNWVvM1dBR25iVmMySGU2Wk5sSDVM?=
 =?utf-8?B?WUtIc1gxUngyRWg2SWtvbEJnaTBTMjRlSjJ5NU9NOXpKMEV2bTZId2FGT2hR?=
 =?utf-8?B?THNrREdHa3VXTnMvTHpMb0hXZmM3UEJzWHBBcFZ3YUhUOFY2dVpjWjZVdmRl?=
 =?utf-8?B?akN0Ly9UWEtHNGVGL0tDWW5ZR1F6QjQ1TG9mTnhnU3NZMC9SSHVQSFlPVGlP?=
 =?utf-8?B?aFFlL1dtc1NUVmU3T2ZCMUpGcTRxQUNhY0dRc2FnaWhkM296OU1tUnBLenZm?=
 =?utf-8?B?SC82N2xZYUNVY0M0d3NUQzdVYUNuaHlmYjErTjdYTDZRSTdLd3U3TjU2YXFz?=
 =?utf-8?B?dDFEWUFUREFPcGl6YjVMMTJJL3MwN2F3TUFEbnQrT2JnUm1ld0kzQ21kMUNH?=
 =?utf-8?B?bXpnTmFteGdNZVdQdTAzZkRLc0Y0N2duU3h0RHFlRm9qTG1mdElBVGROOFpZ?=
 =?utf-8?B?VVYyVGk2aVovT3hWb3d4N3ZFWjVxQ1doTmhnOE5TS1pPSjY0TXZQa0U5Zjh3?=
 =?utf-8?Q?xa6M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f582db-0b99-46e2-935c-08dce254f772
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 20:09:33.6059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jk65+UKxVFDRRtdsBpKnFcPtU/pNzO5F7x72pdzkzAsf11FKuJXm0zGGUrxDZ/XYeD5ERIjC5Hd1oLrdGMd4mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4
IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgTGVv
IExpDQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMSwgMjAyNCA0OjA3IFBNDQo+IFRvOiBMaW1v
bmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBKb2huIFJvd2xleQ0K
PiA8bGttbEBqb2hucm93bGV5Lm1lPjsgTWFoZm9veiwgSGFtemEgPEhhbXphLk1haGZvb3pAYW1k
LmNvbT4NCj4gQ2M6IFdlbnRsYW5kLCBIYXJyeSA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT47IFNp
cXVlaXJhLCBSb2RyaWdvDQo+IDxSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsNCj4gcmVncmVzc2lvbnNAbGlzdHMubGludXguZGV2DQo+IFN1
YmplY3Q6IFJlOiBbUkVHUkVTU0lPTl1bQklTRUNURURdIDU4YTI2MWJmYzk2NzogY2hvcHB5IEdQ
VQ0KPiBwZXJmb3JtYW5jZQ0KPg0KPg0KPg0KPg0KPiBPbiAyMDI0LTEwLTAxIDE1OjEwLCBNYXJp
byBMaW1vbmNpZWxsbyB3cm90ZToNCj4gPiBPbiAxMC8xLzIwMjQgMTQ6MDksIEpvaG4gUm93bGV5
IHdyb3RlOg0KPiA+PiBJIHdhcyB1c2luZyBwb3dlci1wcm9maWxlcy1kYWVtb24gdmVyc2lvbiAw
LjIzIGluIGJhbGFuY2VkIG1vZGUuDQo+ID4+DQo+ID4+IEkgYWxzbyB0ZXN0ZWQgVExQLCBhbmQg
dmFuaWxsYSBrZXJuZWwgd2l0aG91dCBhbnkgcG93ZXIgZGFlbW9ucyBydW5uaW5nLg0KPiA+PiBX
aXRob3V0IGFueSBkYWVtb25zIEkgdXNlIHRoZSBmb2xsb3dpbmc6DQo+ID4+DQo+ID4+ICAgICAg
ZW5lcmd5X3BlcmZvcm1hbmNlX3ByZWZlcmVuY2U6IGJhbGFuY2VfcG93ZXINCj4gPj4NCj4gPj4g
ICAgICBzY2FsaW5nX2RyaXZlcjogYW1kLXBzdGF0ZS1lcHANCj4gPj4NCj4gPj4gICAgICBzY2Fs
aW5nX2dvdmVybm9yOiBwb3dlcnNhdmUNCj4gPj4NCj4gPg0KPiA+IFRoYW5rcyBhcyBsb25nIGFz
IGl0IGNhbiByZXByb2R1Y2UgaW4gJ2JhbGFuY2VkJyBtb2RlIHRoYXQgc2hvdWxkDQo+ID4gZXhj
bHVkZSBQUEQgZnJvbSBiZWluZyB0aGUgY2F1c2UgYW5kIGl0IG1vc3QgbGlrZWx5IGEgcHVyZSBr
ZXJuZWwgYnVnLg0KPiA+DQo+DQo+IEknbSBjdXJpb3VzIGlmIHlvdSBoYXZlIGEgUFNSIHN1cHBv
cnRlZCBwYW5lbC4gRG9lcyBzZXR0aW5nDQo+IGFtZGdwdS5kY2RlYnVnbWFzaz0weDEwIG9uIHlv
dXIga2VybmVsIGNtZGxpbmUgaGVscD8gVGhpcyBmb3JjZSBkaXNhYmxlcw0KPiBQU1IuDQo+DQo+
IEFub3RoZXIgZmxhZyB0byB0cnkgaXMgYW1kZ3B1LmRjZGVidWdtYXNrPTB4ODAwLCB3aGljaCBh
bGxvd3MgUFNSIGJ1dCBkaXNhYmxlcw0KPiBpZGxlIHBvd2VyIG9wdGltaXphdGlvbnMuIEkgd29u
ZGVyIGlmIHRoYXQgbWF5IGJlIGNhdXNpbmcgZXh0cmEgbGF0ZW5jeS4NCg0KRm9yIHJlZmVyZW5j
ZSwgdGhpcyBpcyBhbHNvIGJlaW5nIHRyYWNrZWQgaGVyZToNCmh0dHBzOi8vZ2l0bGFiLmZyZWVk
ZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzM2NTgNCg0KQWxleA0KDQoNCj4NCj4gLSBMZW8N
Cg==
